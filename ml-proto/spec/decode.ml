(* Decoding stream *)

type stream =
{
  name : string;
  bytes : string;
  pos : int ref;
  len : int
}

exception EOS

let stream name bs = {name; bytes = bs; pos = ref 0; len = String.length bs}
let substream s end_ = {s with len = end_}

let len s = s.len
let pos s = !(s.pos)
let eos s = (pos s = len s)

let check n s = if pos s + n > len s then raise EOS
let skip n s = check n s; s.pos := !(s.pos) + n
let rewind p s = s.pos := p

let read s = Char.code (s.bytes.[!(s.pos)])
let peek s = if eos s then None else Some (read s)
let get s = check 1 s; let b = read s in skip 1 s; b
let get_string n s = let i = pos s in skip n s; String.sub s.bytes i n


(* Errors *)

module Code = Error.Make ()
exception Code = Code.Error

let string_of_byte b = Printf.sprintf "%02x" b

let position s pos = Source.({file = s.name; line = -1; column = pos})
let region s left right =
  Source.({left = position s left; right = position s right})

let error s pos msg = raise (Code (region s pos pos, msg))
let require b s pos msg = if not b then error s pos msg

let guard f s =
  try f s with EOS -> error s (len s) "unexpected end of binary or function"

let get = guard get
let get_string n = guard (get_string n)
let skip n = guard (skip n)

let expect b s msg = require (guard get s = b) s (pos s - 1) msg
let illegal s pos b = error s pos ("illegal opcode " ^ string_of_byte b)

let at f s =
  let left = pos s in
  let x = f s in
  let right = pos s in
  Source.(x @@ region s left right)



(* Generic values *)

let bit i n = Int32.(logand n (shift_left 1l i)) <> 0l

let u8 s = get s

let u16 s =
  let lo = u8 s in
  let hi = u8 s in
  hi lsl 8 + lo

let u32 s =
  let lo = Int32.of_int (u16 s) in
  let hi = Int32.of_int (u16 s) in
  Int32.(add lo (shift_left hi 16))

let u64 s =
  let lo = Int64.of_int32 (u32 s) in
  let hi = Int64.of_int32 (u32 s) in
  Int64.(add lo (shift_left hi 32))

let rec vu64 s =
  let b = u8 s in
  let x = Int64.of_int (b land 0x7f) in
  if b land 0x80 = 0 then x
  else Int64.(logor x (shift_left (vu64 s) 7))
  (*TODO: check for overflow*)

let rec vs64 s =
  let b = u8 s in
  let x = Int64.of_int (b land 0x7f) in
  if b land 0x80 = 0
  then (if b land 0x40 = 0 then x else Int64.(logor x (logxor (-1L) 0x7fL)))
  else Int64.(logor x (shift_left (vs64 s) 7))
  (*TODO: check for overflow*)

let vu32 s = Int64.to_int32 (vu64 s)  (*TODO:check overflow*)
let vs32 s = Int64.to_int32 (vs64 s)  (*TODO:check overflow*)
let vu s = Int64.to_int (vu64 s)  (*TODO:check overflow*)
let f32 s = F32.of_bits (u32 s)
let f64 s = F64.of_bits (u64 s)

let bool s = match get s with 0 | 1 as n -> n <> 0 | _ -> error s (pos s - 1) "invalid boolean"
let string s = let n = vu s in get_string n s
let rec list f n s = if n = 0 then [] else let x = f s in x :: list f (n - 1) s
let opt f b s = if b then Some (f s) else None
let vec f s = let n = vu s in list f n s
let vec1 f s = let b = bool s in opt f b s


(* Types *)

open Types

let value_type s =
  match u8 s with
  | 0x01 -> I32Type
  | 0x02 -> I64Type
  | 0x03 -> F32Type
  | 0x04 -> F64Type
  | _ -> error s (pos s - 1) "invalid value type"

let elem_type s =
  match u8 s with
  | 0x20 -> AnyFuncType
  | _ -> error s (pos s - 1) "invalid element type"

let func_type s =
  expect 0x40 s "invalid function type";
  let ins = vec value_type s in
  let out = vec value_type s in
  FuncType (ins, out)

let limits vu s =
  let has_max = bool s in
  let min = vu s in
  let max = opt vu has_max s in
  {min; max}

let table_type s =
  let t = elem_type s in
  let lim = limits vu32 s in
  TableType (lim, t)

let memory_type s =
  let lim = limits vu32 s in
  MemoryType lim

let mutability s =
  match u8 s with
  | 0 -> Immutable
  | 1 -> Mutable
  | _ -> error s (pos s - 1) "invalid mutability"

let global_type s =
  let t = value_type s in
  let mut = mutability s in
  GlobalType (t, mut)


(* Decode instructions *)

open Ast
open Operators

let op s = u8 s
let arity s = vu s

let memop s =
  let align = vu32 s in
  require (I32.lt_u align 32l) s (pos s - 1) "invalid memop flags";
  let offset = vu64 s in
  1 lsl Int32.to_int align, offset

let var s = vu s
let var32 s = Int32.to_int (vu32 s)

let rec args n stack s pos = args' n stack [] s pos
and args' n stack es s pos =
  match n, stack with
  | 0, _ -> es, stack
  | n, e::stack' -> args' (n - 1) stack' (e::es) s pos
  | _ -> error s pos "too few operands for operator"

let args1 b stack s pos =
  match args (if b then 1 else 0) stack s pos with
  | [], stack' -> None, stack'
  | [e], stack' -> Some e, stack'
  | _ -> assert false

let rec instr s =
  let pos = pos s in
  match op s with
  | 0x00 -> unreachable
  | 0x01 ->
    let es' = instr_block s in
    expect 0x0f s "END opcode expected";
    block es'
  | 0x02 ->
    let es' = instr_block s in
    expect 0x0f s "END opcode expected";
    loop es'
  | 0x03 ->
    let es1 = instr_block s in
    if peek s = Some 0x04 then begin
      expect 0x04 s "`else` or `end` opcode expected";
      let es2 = instr_block s in
      expect 0x0f s "END opcode expected";
      if_ es1 es2
    end else begin
      expect 0x0f s "END opcode expected";
      if_ es1 []
    end
  | 0x04 -> error s pos "misplaced ELSE opcode"
  | 0x05 -> select
  | 0x06 ->
    let n = arity s in
    let x = at var s in
    br n x
  | 0x07 ->
    let n = arity s in
    let x = at var s in
    br_if n x
  | 0x08 ->
    let n = arity s in
    let xs = vec (at var) s in
    let x = at var s in
    br_table n xs x
  | 0x09 -> return
  | 0x0a -> nop
  | 0x0b -> drop
  | 0x0c | 0x0d | 0x0e as b -> illegal s pos b
  | 0x0f -> error s pos "misplaced END opcode"

  | 0x10 -> i32_const (at vs32 s)
  | 0x11 -> i64_const (at vs64 s)
  | 0x12 -> f32_const (at f32 s)
  | 0x13 -> f64_const (at f64 s)

  | 0x14 -> get_local (at var s)
  | 0x15 -> set_local (at var s)

  | 0x16 -> call (at var s)
  | 0x17 -> call_indirect (at var s)

  | 0x19 -> tee_local (at var s)

  | 0x1a | 0x1b | 0x1c | 0x1d | 0x1e | 0x1f as b -> illegal s pos b

  | 0x20 -> let a, o = memop s in i32_load8_s a o
  | 0x21 -> let a, o = memop s in i32_load8_u a o
  | 0x22 -> let a, o = memop s in i32_load16_s a o
  | 0x23 -> let a, o = memop s in i32_load16_u a o
  | 0x24 -> let a, o = memop s in i64_load8_s a o
  | 0x25 -> let a, o = memop s in i64_load8_u a o
  | 0x26 -> let a, o = memop s in i64_load16_s a o
  | 0x27 -> let a, o = memop s in i64_load16_u a o
  | 0x28 -> let a, o = memop s in i64_load32_s a o
  | 0x29 -> let a, o = memop s in i64_load32_u a o
  | 0x2a -> let a, o = memop s in i32_load a o
  | 0x2b -> let a, o = memop s in i64_load a o
  | 0x2c -> let a, o = memop s in f32_load a o
  | 0x2d -> let a, o = memop s in f64_load a o

  | 0x2e -> let a, o = memop s in i32_store8 a o
  | 0x2f -> let a, o = memop s in i32_store16 a o
  | 0x30 -> let a, o = memop s in i64_store8 a o
  | 0x31 -> let a, o = memop s in i64_store16 a o
  | 0x32 -> let a, o = memop s in i64_store32 a o
  | 0x33 -> let a, o = memop s in i32_store a o
  | 0x34 -> let a, o = memop s in i64_store a o
  | 0x35 -> let a, o = memop s in f32_store a o
  | 0x36 -> let a, o = memop s in f64_store a o

  | 0x37 | 0x38 as b -> illegal s pos b

  | 0x39 -> grow_memory
  | 0x3a as b -> illegal s pos b
  | 0x3b -> current_memory

  | 0x3c | 0x3d | 0x3e | 0x3f as b -> illegal s pos b

  | 0x40 -> i32_add
  | 0x41 -> i32_sub
  | 0x42 -> i32_mul
  | 0x43 -> i32_div_s
  | 0x44 -> i32_div_u
  | 0x45 -> i32_rem_s
  | 0x46 -> i32_rem_u
  | 0x47 -> i32_and
  | 0x48 -> i32_or
  | 0x49 -> i32_xor
  | 0x4a -> i32_shl
  | 0x4b -> i32_shr_u
  | 0x4c -> i32_shr_s
  | 0x4d -> i32_eq
  | 0x4e -> i32_ne
  | 0x4f -> i32_lt_s
  | 0x50 -> i32_le_s
  | 0x51 -> i32_lt_u
  | 0x52 -> i32_le_u
  | 0x53 -> i32_gt_s
  | 0x54 -> i32_ge_s
  | 0x55 -> i32_gt_u
  | 0x56 -> i32_ge_u
  | 0x57 -> i32_clz
  | 0x58 -> i32_ctz
  | 0x59 -> i32_popcnt
  | 0x5a -> i32_eqz

  | 0x5b -> i64_add
  | 0x5c -> i64_sub
  | 0x5d -> i64_mul
  | 0x5e -> i64_div_s
  | 0x5f -> i64_div_u
  | 0x60 -> i64_rem_s
  | 0x61 -> i64_rem_u
  | 0x62 -> i64_and
  | 0x63 -> i64_or
  | 0x64 -> i64_xor
  | 0x65 -> i64_shl
  | 0x66 -> i64_shr_u
  | 0x67 -> i64_shr_s
  | 0x68 -> i64_eq
  | 0x69 -> i64_ne
  | 0x6a -> i64_lt_s
  | 0x6b -> i64_le_s
  | 0x6c -> i64_lt_u
  | 0x6d -> i64_le_u
  | 0x6e -> i64_gt_s
  | 0x6f -> i64_ge_s
  | 0x70 -> i64_gt_u
  | 0x71 -> i64_ge_u
  | 0x72 -> i64_clz
  | 0x73 -> i64_ctz
  | 0x74 -> i64_popcnt

  | 0x75 -> f32_add
  | 0x76 -> f32_sub
  | 0x77 -> f32_mul
  | 0x78 -> f32_div
  | 0x79 -> f32_min
  | 0x7a -> f32_max
  | 0x7b -> f32_abs
  | 0x7c -> f32_neg
  | 0x7d -> f32_copysign
  | 0x7e -> f32_ceil
  | 0x7f -> f32_floor
  | 0x80 -> f32_trunc
  | 0x81 -> f32_nearest
  | 0x82 -> f32_sqrt
  | 0x83 -> f32_eq
  | 0x84 -> f32_ne
  | 0x85 -> f32_lt
  | 0x86 -> f32_le
  | 0x87 -> f32_gt
  | 0x88 -> f32_ge

  | 0x89 -> f64_add
  | 0x8a -> f64_sub
  | 0x8b -> f64_mul
  | 0x8c -> f64_div
  | 0x8d -> f64_min
  | 0x8e -> f64_max
  | 0x8f -> f64_abs
  | 0x90 -> f64_neg
  | 0x91 -> f64_copysign
  | 0x92 -> f64_ceil
  | 0x93 -> f64_floor
  | 0x94 -> f64_trunc
  | 0x95 -> f64_nearest
  | 0x96 -> f64_sqrt
  | 0x97 -> f64_eq
  | 0x98 -> f64_ne
  | 0x99 -> f64_lt
  | 0x9a -> f64_le
  | 0x9b -> f64_gt
  | 0x9c -> f64_ge

  | 0x9d -> i32_trunc_s_f32
  | 0x9e -> i32_trunc_s_f64
  | 0x9f -> i32_trunc_u_f32
  | 0xa0 -> i32_trunc_u_f64
  | 0xa1 -> i32_wrap_i64
  | 0xa2 -> i64_trunc_s_f32
  | 0xa3 -> i64_trunc_s_f64
  | 0xa4 -> i64_trunc_u_f32
  | 0xa5 -> i64_trunc_u_f64
  | 0xa6 -> i64_extend_s_i32
  | 0xa7 -> i64_extend_u_i32
  | 0xa8 -> f32_convert_s_i32
  | 0xa9 -> f32_convert_u_i32
  | 0xaa -> f32_convert_s_i64
  | 0xab -> f32_convert_u_i64
  | 0xac -> f32_demote_f64
  | 0xad -> f32_reinterpret_i32
  | 0xae -> f64_convert_s_i32
  | 0xaf -> f64_convert_u_i32
  | 0xb0 -> f64_convert_s_i64
  | 0xb1 -> f64_convert_u_i64
  | 0xb2 -> f64_promote_f32
  | 0xb3 -> f64_reinterpret_i64
  | 0xb4 -> i32_reinterpret_f32
  | 0xb5 -> i64_reinterpret_f64

  | 0xb6 -> i32_rotl
  | 0xb7 -> i32_rotr
  | 0xb8 -> i64_rotl
  | 0xb9 -> i64_rotr
  | 0xba -> i64_eqz

  | 0xbb -> get_global (at var s)
  | 0xbc -> set_global (at var s)

  | b when b > 0xbc -> illegal s pos b

  | b -> error s pos "too few operands for operator"

and instr_block s = List.rev (instr_block' s [])
and instr_block' s es =
  if eos s then es else
  match peek s with
  | None | Some (0x04 | 0x0f) -> es
  | _ ->
    let pos = pos s in
    let e' = instr s in
    instr_block' s (Source.(e' @@ region s pos pos) :: es)

let const s =
  let c = at instr_block s in
  expect 0x0f s "END opcode expected";
  c


(* Sections *)

let trace s name =
  print_endline
    (name ^ " @ " ^ string_of_int (pos s) ^ " = " ^ string_of_byte (read s))

let id s =
  match string s with
  | "type" -> `TypeSection
  | "import" -> `ImportSection
  | "function" -> `FuncSection
  | "table" -> `TableSection
  | "memory" -> `MemorySection
  | "global" -> `GlobalSection
  | "export" -> `ExportSection
  | "start" -> `StartSection
  | "code" -> `CodeSection
  | "element" -> `ElemSection
  | "data" -> `DataSection
  | _ -> `UnknownSection

let section tag f default s =
  if eos s then default else
  let start_pos = pos s in
  if id s <> tag then (rewind start_pos s; default) else
  let size = vu s in
  let content_pos = pos s in
  let s' = substream s (content_pos + size) in
  let x = f s' in
  require (eos s') s' (pos s') "junk at end of section";
  x


(* Type section *)

let type_section s =
  section `TypeSection (vec func_type) [] s


(* Import section *)

let import_kind s =
  match u8 s with
  | 0x00 -> FuncImport (at var s)
  | 0x01 -> TableImport (table_type s)
  | 0x02 -> MemoryImport (memory_type s)
  | 0x03 -> GlobalImport (global_type s)
  | _ -> error s (pos s - 1) "invalid import kind"

let import s =
  let module_name = string s in
  let item_name = string s in
  let ikind = at import_kind s in
  {module_name; item_name; ikind}

let import_section s =
  section `ImportSection (vec (at import)) [] s


(* Function section *)

let func_section s =
  section `FuncSection (vec (at var)) [] s


(* Table section *)

let table s =
  let ttype = table_type s in
  {ttype}

let table_section s =
  section `TableSection (vec (at table)) [] s


(* Memory section *)

let memory s =
  let mtype = memory_type s in
  {mtype}

let memory_section s =
  section `MemorySection (vec (at memory)) [] s


(* Global section *)

let global s =
  let gtype = global_type s in
  let value = const s in
  {gtype; value}

let global_section s =
  section `GlobalSection (vec (at global)) [] s


(* Export section *)

let export_kind s =
  match u8 s with
  | 0x00 -> FuncExport
  | 0x01 -> TableExport
  | 0x02 -> MemoryExport
  | 0x03 -> GlobalExport
  | _ -> error s (pos s - 1) "invalid export kind"

let export s =
  let name = string s in
  let ekind = at export_kind s in
  let item = at var s in
  {name; ekind; item}

let export_section s =
  section `ExportSection (vec (at export)) [] s


(* Start section *)

let start_section s =
  section `StartSection (opt (at var) true) None s


(* Code section *)

let local s =
  let n = vu s in
  let t = value_type s in
  Lib.List.make n t

let code s =
  let size = vu s in
  let pos = pos s in
  let locals = List.flatten (vec local s) in
  let body = instr_block (substream s (pos + size)) in
  {locals; body; ftype = Source.((-1) @@ Source.no_region)}

let code_section s =
  section `CodeSection (vec (at code)) [] s


(* Element section *)

let segment dat s =
  let index = at var s in
  let offset = const s in
  let init = dat s in
  {index; offset; init}

let table_segment s =
  segment (vec (at var)) s

let elem_section s =
  section `ElemSection (vec (at table_segment)) [] s


(* Data section *)

let memory_segment s =
  segment string s

let data_section s =
  section `DataSection (vec (at memory_segment)) [] s


(* Unknown section *)

let unknown_section s =
  section `UnknownSection (fun s -> skip (len s - pos s) s; true) false s


(* Modules *)

let rec iterate f s = if f s then iterate f s

let module_ s =
  let magic = u32 s in
  require (magic = 0x6d736100l) s 0 "magic header not detected";
  let version = u32 s in
  require (version = Encode.version) s 4 "unknown binary version";
  iterate unknown_section s;
  let types = type_section s in
  iterate unknown_section s;
  let imports = import_section s in
  iterate unknown_section s;
  let func_types = func_section s in
  iterate unknown_section s;
  let tables = table_section s in
  iterate unknown_section s;
  let memories = memory_section s in
  iterate unknown_section s;
  let globals = global_section s in
  iterate unknown_section s;
  let exports = export_section s in
  iterate unknown_section s;
  let start = start_section s in
  iterate unknown_section s;
  let func_bodies = code_section s in
  iterate unknown_section s;
  let elems = elem_section s in
  iterate unknown_section s;
  let data = data_section s in
  iterate unknown_section s;
  (*TODO: name section*)
  iterate unknown_section s;
  require (pos s = len s) s (len s) "junk after last section";
  require (List.length func_types = List.length func_bodies)
    s (len s) "function and code section have inconsistent lengths";
  let funcs =
    List.map2 Source.(fun t f -> {f.it with ftype = t} @@ f.at)
      func_types func_bodies
  in {types; tables; memories; globals; funcs; imports; exports; elems; data; start}


let decode name bs = at module_ (stream name bs)

