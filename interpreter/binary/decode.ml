(* Decoding stream *)

type stream =
{
  name : string;
  bytes : string;
  pos : int ref;
}

exception EOS

let stream name bs = {name; bytes = bs; pos = ref 0}

let len s = String.length s.bytes
let pos s = !(s.pos)
let eos s = (pos s = len s)

let check n s = if pos s + n > len s then raise EOS
let skip n s = check n s; s.pos := !(s.pos) + n

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

let u8 s =
  get s

let u16 s =
  let lo = u8 s in
  let hi = u8 s in
  hi lsl 8 + lo

let u32 s =
  let lo = Int32.of_int (u16 s) in
  let hi = Int32.of_int (u16 s) in
  Int32.(add lo (shift_left hi 16))

let u64 s =
  let lo = I64_convert.extend_u_i32 (u32 s) in
  let hi = I64_convert.extend_u_i32 (u32 s) in
  Int64.(add lo (shift_left hi 32))

let rec vuN n s =
  require (n > 0) s (pos s) "integer representation too long";
  let b = u8 s in
  require (n >= 7 || b land 0x7f < 1 lsl n) s (pos s - 1) "integer too large";
  let x = Int64.of_int (b land 0x7f) in
  if b land 0x80 = 0 then x else Int64.(logor x (shift_left (vuN (n - 7) s) 7))

let rec vsN n s =
  require (n > 0) s (pos s) "integer representation too long";
  let b = u8 s in
  let mask = (-1 lsl n) land 0x7f in
  require (n >= 7 || b land mask = 0 || b land mask = mask) s (pos s - 1)
    "integer too large";
  let x = Int64.of_int (b land 0x7f) in
  if b land 0x80 = 0
  then (if b land 0x40 = 0 then x else Int64.(logor x (logxor (-1L) 0x7fL)))
  else Int64.(logor x (shift_left (vsN (n - 7) s) 7))

let vu1 s = Int64.to_int (vuN 1 s)
let vu32 s = Int64.to_int32 (vuN 32 s)
let vs7 s = Int64.to_int (vsN 7 s)
let vs32 s = Int64.to_int32 (vsN 32 s)
let vs64 s = vsN 64 s
let f32 s = F32.of_bits (u32 s)
let f64 s = F64.of_bits (u64 s)

let len32 s =
  let pos = pos s in
  let n = vu32 s in
  if n <= Int32.of_int (len s) then Int32.to_int n else
    error s pos "length out of bounds"

let bool s = (vu1 s = 1)
let string s = let n = len32 s in get_string n s
let rec list f n s = if n = 0 then [] else let x = f s in x :: list f (n - 1) s
let opt f b s = if b then Some (f s) else None
let vec f s = let n = len32 s in list f n s

let name s =
  let pos = pos s in
  try Utf8.decode (string s) with Utf8.Utf8 ->
    error s pos "invalid UTF-8 encoding"

let sized f s =
  let size = len32 s in
  let start = pos s in
  let x = f size s in
  require (pos s = start + size) s start "section size mismatch";
  x


(* Types *)

open Types

let value_type s =
  match vs7 s with
  | -0x01 -> I32Type
  | -0x02 -> I64Type
  | -0x03 -> F32Type
  | -0x04 -> F64Type
  | _ -> error s (pos s - 1) "invalid value type"

let elem_type s =
  match vs7 s with
  | -0x10 -> AnyFuncType
  | _ -> error s (pos s - 1) "invalid element type"

let stack_type s =
  match peek s with
  | Some 0x40 -> skip 1 s; []
  | _ -> [value_type s]

let func_type s =
  match vs7 s with
  | -0x20 ->
    let ins = vec value_type s in
    let out = vec value_type s in
    FuncType (ins, out)
  | _ -> error s (pos s - 1) "invalid function type"

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

let var s = vu32 s

let op s = u8 s
let end_ s = expect 0x0b s "END opcode expected"

let memop s =
  let align = vu32 s in
  require (I32.le_u align 32l) s (pos s - 1) "invalid memop flags";
  let offset = vu32 s in
  Int32.to_int align, offset

let rec instr s =
  let pos = pos s in
  match op s with
  | 0x00 -> unreachable
  | 0x01 -> nop

  | 0x02 ->
    let ts = stack_type s in
    let es' = instr_block s in
    end_ s;
    block ts es'
  | 0x03 ->
    let ts = stack_type s in
    let es' = instr_block s in
    end_ s;
    loop ts es'
  | 0x04 ->
    let ts = stack_type s in
    let es1 = instr_block s in
    if peek s = Some 0x05 then begin
      expect 0x05 s "ELSE or END opcode expected";
      let es2 = instr_block s in
      end_ s;
      if_ ts es1 es2
    end else begin
      end_ s;
      if_ ts es1 []
    end

  | 0x05 -> error s pos "misplaced ELSE opcode"
  | 0x06| 0x07 | 0x08 | 0x09 | 0x0a as b -> illegal s pos b
  | 0x0b -> error s pos "misplaced END opcode"

  | 0x0c -> br (at var s)
  | 0x0d -> br_if (at var s)
  | 0x0e ->
    let xs = vec (at var) s in
    let x = at var s in
    br_table xs x
  | 0x0f -> return

  | 0x10 -> call (at var s)
  | 0x11 ->
    let x = at var s in
    expect 0x00 s "zero flag expected";
    call_indirect x

  | 0x12 | 0x13 | 0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 as b -> illegal s pos b

  | 0x1a -> drop
  | 0x1b -> select

  | 0x1c | 0x1d | 0x1e | 0x1f as b -> illegal s pos b

  | 0x20 -> get_local (at var s)
  | 0x21 -> set_local (at var s)
  | 0x22 -> tee_local (at var s)
  | 0x23 -> get_global (at var s)
  | 0x24 -> set_global (at var s)

  | 0x25 | 0x26 | 0x27 as b -> illegal s pos b

  | 0x28 -> let a, o = memop s in i32_load a o
  | 0x29 -> let a, o = memop s in i64_load a o
  | 0x2a -> let a, o = memop s in f32_load a o
  | 0x2b -> let a, o = memop s in f64_load a o
  | 0x2c -> let a, o = memop s in i32_load8_s a o
  | 0x2d -> let a, o = memop s in i32_load8_u a o
  | 0x2e -> let a, o = memop s in i32_load16_s a o
  | 0x2f -> let a, o = memop s in i32_load16_u a o
  | 0x30 -> let a, o = memop s in i64_load8_s a o
  | 0x31 -> let a, o = memop s in i64_load8_u a o
  | 0x32 -> let a, o = memop s in i64_load16_s a o
  | 0x33 -> let a, o = memop s in i64_load16_u a o
  | 0x34 -> let a, o = memop s in i64_load32_s a o
  | 0x35 -> let a, o = memop s in i64_load32_u a o

  | 0x36 -> let a, o = memop s in i32_store a o
  | 0x37 -> let a, o = memop s in i64_store a o
  | 0x38 -> let a, o = memop s in f32_store a o
  | 0x39 -> let a, o = memop s in f64_store a o
  | 0x3a -> let a, o = memop s in i32_store8 a o
  | 0x3b -> let a, o = memop s in i32_store16 a o
  | 0x3c -> let a, o = memop s in i64_store8 a o
  | 0x3d -> let a, o = memop s in i64_store16 a o
  | 0x3e -> let a, o = memop s in i64_store32 a o

  | 0x3f ->
    expect 0x00 s "zero flag expected";
    current_memory
  | 0x40 ->
    expect 0x00 s "zero flag expected";
    grow_memory

  | 0x41 -> i32_const (at vs32 s)
  | 0x42 -> i64_const (at vs64 s)
  | 0x43 -> f32_const (at f32 s)
  | 0x44 -> f64_const (at f64 s)

  | 0x45 -> i32_eqz
  | 0x46 -> i32_eq
  | 0x47 -> i32_ne
  | 0x48 -> i32_lt_s
  | 0x49 -> i32_lt_u
  | 0x4a -> i32_gt_s
  | 0x4b -> i32_gt_u
  | 0x4c -> i32_le_s
  | 0x4d -> i32_le_u
  | 0x4e -> i32_ge_s
  | 0x4f -> i32_ge_u

  | 0x50 -> i64_eqz
  | 0x51 -> i64_eq
  | 0x52 -> i64_ne
  | 0x53 -> i64_lt_s
  | 0x54 -> i64_lt_u
  | 0x55 -> i64_gt_s
  | 0x56 -> i64_gt_u
  | 0x57 -> i64_le_s
  | 0x58 -> i64_le_u
  | 0x59 -> i64_ge_s
  | 0x5a -> i64_ge_u

  | 0x5b -> f32_eq
  | 0x5c -> f32_ne
  | 0x5d -> f32_lt
  | 0x5e -> f32_gt
  | 0x5f -> f32_le
  | 0x60 -> f32_ge

  | 0x61 -> f64_eq
  | 0x62 -> f64_ne
  | 0x63 -> f64_lt
  | 0x64 -> f64_gt
  | 0x65 -> f64_le
  | 0x66 -> f64_ge

  | 0x67 -> i32_clz
  | 0x68 -> i32_ctz
  | 0x69 -> i32_popcnt
  | 0x6a -> i32_add
  | 0x6b -> i32_sub
  | 0x6c -> i32_mul
  | 0x6d -> i32_div_s
  | 0x6e -> i32_div_u
  | 0x6f -> i32_rem_s
  | 0x70 -> i32_rem_u
  | 0x71 -> i32_and
  | 0x72 -> i32_or
  | 0x73 -> i32_xor
  | 0x74 -> i32_shl
  | 0x75 -> i32_shr_s
  | 0x76 -> i32_shr_u
  | 0x77 -> i32_rotl
  | 0x78 -> i32_rotr

  | 0x79 -> i64_clz
  | 0x7a -> i64_ctz
  | 0x7b -> i64_popcnt
  | 0x7c -> i64_add
  | 0x7d -> i64_sub
  | 0x7e -> i64_mul
  | 0x7f -> i64_div_s
  | 0x80 -> i64_div_u
  | 0x81 -> i64_rem_s
  | 0x82 -> i64_rem_u
  | 0x83 -> i64_and
  | 0x84 -> i64_or
  | 0x85 -> i64_xor
  | 0x86 -> i64_shl
  | 0x87 -> i64_shr_s
  | 0x88 -> i64_shr_u
  | 0x89 -> i64_rotl
  | 0x8a -> i64_rotr

  | 0x8b -> f32_abs
  | 0x8c -> f32_neg
  | 0x8d -> f32_ceil
  | 0x8e -> f32_floor
  | 0x8f -> f32_trunc
  | 0x90 -> f32_nearest
  | 0x91 -> f32_sqrt
  | 0x92 -> f32_add
  | 0x93 -> f32_sub
  | 0x94 -> f32_mul
  | 0x95 -> f32_div
  | 0x96 -> f32_min
  | 0x97 -> f32_max
  | 0x98 -> f32_copysign

  | 0x99 -> f64_abs
  | 0x9a -> f64_neg
  | 0x9b -> f64_ceil
  | 0x9c -> f64_floor
  | 0x9d -> f64_trunc
  | 0x9e -> f64_nearest
  | 0x9f -> f64_sqrt
  | 0xa0 -> f64_add
  | 0xa1 -> f64_sub
  | 0xa2 -> f64_mul
  | 0xa3 -> f64_div
  | 0xa4 -> f64_min
  | 0xa5 -> f64_max
  | 0xa6 -> f64_copysign

  | 0xa7 -> i32_wrap_i64
  | 0xa8 -> i32_trunc_s_f32
  | 0xa9 -> i32_trunc_u_f32
  | 0xaa -> i32_trunc_s_f64
  | 0xab -> i32_trunc_u_f64
  | 0xac -> i64_extend_s_i32
  | 0xad -> i64_extend_u_i32
  | 0xae -> i64_trunc_s_f32
  | 0xaf -> i64_trunc_u_f32
  | 0xb0 -> i64_trunc_s_f64
  | 0xb1 -> i64_trunc_u_f64
  | 0xb2 -> f32_convert_s_i32
  | 0xb3 -> f32_convert_u_i32
  | 0xb4 -> f32_convert_s_i64
  | 0xb5 -> f32_convert_u_i64
  | 0xb6 -> f32_demote_f64
  | 0xb7 -> f64_convert_s_i32
  | 0xb8 -> f64_convert_u_i32
  | 0xb9 -> f64_convert_s_i64
  | 0xba -> f64_convert_u_i64
  | 0xbb -> f64_promote_f32

  | 0xbc -> i32_reinterpret_f32
  | 0xbd -> i64_reinterpret_f64
  | 0xbe -> f32_reinterpret_i32
  | 0xbf -> f64_reinterpret_i64

  | b -> illegal s pos b

and instr_block s = List.rev (instr_block' s [])
and instr_block' s es =
  match peek s with
  | None | Some (0x05 | 0x0b) -> es
  | _ ->
    let pos = pos s in
    let e' = instr s in
    instr_block' s (Source.(e' @@ region s pos pos) :: es)

let const s =
  let c = at instr_block s in
  end_ s;
  c


(* Sections *)

let id s =
  let bo = peek s in
  Lib.Option.map
    (function
    | 0 -> `CustomSection
    | 1 -> `TypeSection
    | 2 -> `ImportSection
    | 3 -> `FuncSection
    | 4 -> `TableSection
    | 5 -> `MemorySection
    | 6 -> `GlobalSection
    | 7 -> `ExportSection
    | 8 -> `StartSection
    | 9 -> `ElemSection
    | 10 -> `CodeSection
    | 11 -> `DataSection
    | _ -> error s (pos s) "invalid section id"
    ) bo

let section_with_size tag f default s =
  match id s with
  | Some tag' when tag' = tag -> ignore (u8 s); sized f s
  | _ -> default

let section tag f default s =
  section_with_size tag (fun _ -> f) default s


(* Type section *)

let type_ s = at func_type s

let type_section s =
  section `TypeSection (vec type_) [] s


(* Import section *)

let import_desc s =
  match u8 s with
  | 0x00 -> FuncImport (at var s)
  | 0x01 -> TableImport (table_type s)
  | 0x02 -> MemoryImport (memory_type s)
  | 0x03 -> GlobalImport (global_type s)
  | _ -> error s (pos s - 1) "invalid import kind"

let import s =
  let module_name = name s in
  let item_name = name s in
  let idesc = at import_desc s in
  {module_name; item_name; idesc}

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

let export_desc s =
  match u8 s with
  | 0x00 -> FuncExport (at var s)
  | 0x01 -> TableExport (at var s)
  | 0x02 -> MemoryExport (at var s)
  | 0x03 -> GlobalExport (at var s)
  | _ -> error s (pos s - 1) "invalid export kind"

let export s =
  let name = name s in
  let edesc = at export_desc s in
  {name; edesc}

let export_section s =
  section `ExportSection (vec (at export)) [] s


(* Start section *)

let start_section s =
  section `StartSection (opt (at var) true) None s


(* Code section *)

let local s =
  let n = len32 s in
  let t = value_type s in
  Lib.List.make n t

let code _ s =
  let locals = List.flatten (vec local s) in
  let body = instr_block s in
  end_ s;
  {locals; body; ftype = Source.((-1l) @@ Source.no_region)}

let code_section s =
  section `CodeSection (vec (at (sized code))) [] s


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


(* Custom section *)

let custom size s =
  let start = pos s in
  let _id = name s in
  skip (size - (pos s - start)) s;
  true

let custom_section s =
  section_with_size `CustomSection custom false s


(* Modules *)

let rec iterate f s = if f s then iterate f s

let module_ s =
  let magic = u32 s in
  require (magic = 0x6d736100l) s 0 "magic header not detected";
  let version = u32 s in
  require (version = Encode.version) s 4 "unknown binary version";
  iterate custom_section s;
  let types = type_section s in
  iterate custom_section s;
  let imports = import_section s in
  iterate custom_section s;
  let func_types = func_section s in
  iterate custom_section s;
  let tables = table_section s in
  iterate custom_section s;
  let memories = memory_section s in
  iterate custom_section s;
  let globals = global_section s in
  iterate custom_section s;
  let exports = export_section s in
  iterate custom_section s;
  let start = start_section s in
  iterate custom_section s;
  let elems = elem_section s in
  iterate custom_section s;
  let func_bodies = code_section s in
  iterate custom_section s;
  let data = data_section s in
  iterate custom_section s;
  require (pos s = len s) s (len s) "junk after last section";
  require (List.length func_types = List.length func_bodies)
    s (len s) "function and code section have inconsistent lengths";
  let funcs =
    List.map2 Source.(fun t f -> {f.it with ftype = t} @@ f.at)
      func_types func_bodies
  in {types; tables; memories; globals; funcs; imports; exports; elems; data; start}


let decode name bs = at module_ (stream name bs)
