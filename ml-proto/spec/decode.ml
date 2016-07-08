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
  match get s with
  | 0x01 -> Int32Type
  | 0x02 -> Int64Type
  | 0x03 -> Float32Type
  | 0x04 -> Float64Type
  | _ -> error s (pos s - 1) "invalid value type"

let expr_type s = vec1 value_type s

let func_type s =
  expect 0x05 s "invalid function type";
  let ins = vec value_type s in
  let out = expr_type s in
  FuncType (ins, match out with None -> [] | Some t -> [t])


(* Decode expressions *)

open Kernel
open Ast

let op s = u8 s
let arity s = vu s

let memop s =
  let align = vu s in
  (*TODO: check flag bits*)
  let offset = vu64 s in
  offset, align

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

let rec expr s =
  let pos = pos s in
  match op s with
  | 0x00 -> Nop
  | 0x01 ->
    let es' = expr_block s in
    expect 0x0f s "END opcode expected";
    Block es'
  | 0x02 ->
    let es' = expr_block s in
    expect 0x0f s "END opcode expected";
    Loop es'
  | 0x03 ->
    let es1 = expr_block s in
    if peek s = Some 0x04 then begin
      expect 0x04 s "ELSE or END opcode expected";
      let es2 = expr_block s in
      expect 0x0f s "END opcode expected";
      If (es1, es2)
    end else begin
      expect 0x0f s "END opcode expected";
      If (es1, [])
    end
  | 0x04 -> error s pos "misplaced ELSE opcode"
  | 0x05 -> Select
  | 0x06 ->
    let n = arity s in
    let x = at var s in
    Br (n, x)
  | 0x07 ->
    let n = arity s in
    let x = at var s in
    Br_if (n, x)
  | 0x08 ->
    let n = arity s in
    let xs = vec (at var) s in
    let x = at var s in
    Br_table (n, xs, x)
  | 0x09 ->
    let n = arity s in
    Return n
  | 0x0a -> Unreachable
  | 0x0b -> Drop
  | 0x0c | 0x0d | 0x0e as b -> illegal s pos b
  | 0x0f -> error s pos "misplaced END opcode"

  | 0x10 -> I32_const (at vs32 s)
  | 0x11 -> I64_const (at vs64 s)
  | 0x12 -> F32_const (at f32 s)
  | 0x13 -> F64_const (at f64 s)

  | 0x14 ->
    let x = at var s in
    Get_local x
  | 0x15 ->
    let x = at var s in
    Set_local x

  | 0x16 ->
    let n = arity s in
    let x = at var s in
    Call (n, x)
  | 0x17 ->
    let n = arity s in
    let x = at var s in
    Call_indirect (n, x)
  | 0x18 ->
    let n = arity s in
    let x = at var s in
    Call_import (n, x)

  | 0x19 ->
    let x = at var s in
    Tee_local x

  | 0x1a | 0x1b | 0x1c | 0x1d | 0x1e | 0x1f as b -> illegal s pos b

  | 0x20 -> let o, a = memop s in I32_load8_s (o, a)
  | 0x21 -> let o, a = memop s in I32_load8_u (o, a)
  | 0x22 -> let o, a = memop s in I32_load16_s (o, a)
  | 0x23 -> let o, a = memop s in I32_load16_u (o, a)
  | 0x24 -> let o, a = memop s in I64_load8_s (o, a)
  | 0x25 -> let o, a = memop s in I64_load8_u (o, a)
  | 0x26 -> let o, a = memop s in I64_load16_s (o, a)
  | 0x27 -> let o, a = memop s in I64_load16_u (o, a)
  | 0x28 -> let o, a = memop s in I64_load32_s (o, a)
  | 0x29 -> let o, a = memop s in I64_load32_u (o, a)
  | 0x2a -> let o, a = memop s in I32_load (o, a)
  | 0x2b -> let o, a = memop s in I64_load (o, a)
  | 0x2c -> let o, a = memop s in F32_load (o, a)
  | 0x2d -> let o, a = memop s in F64_load (o, a)

  | 0x2e -> let o, a = memop s in I32_store8 (o, a)
  | 0x2f -> let o, a = memop s in I32_store16 (o, a)
  | 0x30 -> let o, a = memop s in I64_store8 (o, a)
  | 0x31 -> let o, a = memop s in I64_store16 (o, a)
  | 0x32 -> let o, a = memop s in I64_store32 (o, a)
  | 0x33 -> let o, a = memop s in I32_store (o, a)
  | 0x34 -> let o, a = memop s in I64_store (o, a)
  | 0x35 -> let o, a = memop s in F32_store (o, a)
  | 0x36 -> let o, a = memop s in F64_store (o, a)

  | 0x37 | 0x38 as b -> illegal s pos b

  | 0x39 -> Grow_memory
  | 0x3a as b -> illegal s pos b
  | 0x3b -> Current_memory

  | 0x3c | 0x3d | 0x3e | 0x3f as b -> illegal s pos b

  | 0x40 -> I32_add
  | 0x41 -> I32_sub
  | 0x42 -> I32_mul
  | 0x43 -> I32_div_s
  | 0x44 -> I32_div_u
  | 0x45 -> I32_rem_s
  | 0x46 -> I32_rem_u
  | 0x47 -> I32_and
  | 0x48 -> I32_or
  | 0x49 -> I32_xor
  | 0x4a -> I32_shl
  | 0x4b -> I32_shr_u
  | 0x4c -> I32_shr_s
  | 0x4d -> I32_eq
  | 0x4e -> I32_ne
  | 0x4f -> I32_lt_s
  | 0x50 -> I32_le_s
  | 0x51 -> I32_lt_u
  | 0x52 -> I32_le_u
  | 0x53 -> I32_gt_s
  | 0x54 -> I32_ge_s
  | 0x55 -> I32_gt_u
  | 0x56 -> I32_ge_u
  | 0x57 -> I32_clz
  | 0x58 -> I32_ctz
  | 0x59 -> I32_popcnt
  | 0x5a -> I32_eqz

  | 0x5b -> I64_add
  | 0x5c -> I64_sub
  | 0x5d -> I64_mul
  | 0x5e -> I64_div_s
  | 0x5f -> I64_div_u
  | 0x60 -> I64_rem_s
  | 0x61 -> I64_rem_u
  | 0x62 -> I64_and
  | 0x63 -> I64_or
  | 0x64 -> I64_xor
  | 0x65 -> I64_shl
  | 0x66 -> I64_shr_u
  | 0x67 -> I64_shr_s
  | 0x68 -> I64_eq
  | 0x69 -> I64_ne
  | 0x6a -> I64_lt_s
  | 0x6b -> I64_le_s
  | 0x6c -> I64_lt_u
  | 0x6d -> I64_le_u
  | 0x6e -> I64_gt_s
  | 0x6f -> I64_ge_s
  | 0x70 -> I64_gt_u
  | 0x71 -> I64_ge_u
  | 0x72 -> I64_clz
  | 0x73 -> I64_ctz
  | 0x74 -> I64_popcnt

  | 0x75 -> F32_add
  | 0x76 -> F32_sub
  | 0x77 -> F32_mul
  | 0x78 -> F32_div
  | 0x79 -> F32_min
  | 0x7a -> F32_max
  | 0x7b -> F32_abs
  | 0x7c -> F32_neg
  | 0x7d -> F32_copysign
  | 0x7e -> F32_ceil
  | 0x7f -> F32_floor
  | 0x80 -> F32_trunc
  | 0x81 -> F32_nearest
  | 0x82 -> F32_sqrt
  | 0x83 -> F32_eq
  | 0x84 -> F32_ne
  | 0x85 -> F32_lt
  | 0x86 -> F32_le
  | 0x87 -> F32_gt
  | 0x88 -> F32_ge

  | 0x89 -> F64_add
  | 0x8a -> F64_sub
  | 0x8b -> F64_mul
  | 0x8c -> F64_div
  | 0x8d -> F64_min
  | 0x8e -> F64_max
  | 0x8f -> F64_abs
  | 0x90 -> F64_neg
  | 0x91 -> F64_copysign
  | 0x92 -> F64_ceil
  | 0x93 -> F64_floor
  | 0x94 -> F64_trunc
  | 0x95 -> F64_nearest
  | 0x96 -> F64_sqrt
  | 0x97 -> F64_eq
  | 0x98 -> F64_ne
  | 0x99 -> F64_lt
  | 0x9a -> F64_le
  | 0x9b -> F64_gt
  | 0x9c -> F64_ge

  | 0x9d -> I32_trunc_s_f32
  | 0x9e -> I32_trunc_s_f64
  | 0x9f -> I32_trunc_u_f32
  | 0xa0 -> I32_trunc_u_f64
  | 0xa1 -> I32_wrap_i64
  | 0xa2 -> I64_trunc_s_f32
  | 0xa3 -> I64_trunc_s_f64
  | 0xa4 -> I64_trunc_u_f32
  | 0xa5 -> I64_trunc_u_f64
  | 0xa6 -> I64_extend_s_i32
  | 0xa7 -> I64_extend_u_i32
  | 0xa8 -> F32_convert_s_i32
  | 0xa9 -> F32_convert_u_i32
  | 0xaa -> F32_convert_s_i64
  | 0xab -> F32_convert_u_i64
  | 0xac -> F32_demote_f64
  | 0xad -> F32_reinterpret_i32
  | 0xae -> F64_convert_s_i32
  | 0xaf -> F64_convert_u_i32
  | 0xb0 -> F64_convert_s_i64
  | 0xb1 -> F64_convert_u_i64
  | 0xb2 -> F64_promote_f32
  | 0xb3 -> F64_reinterpret_i64
  | 0xb4 -> I32_reinterpret_f32
  | 0xb5 -> I64_reinterpret_f64

  | 0xb6 -> I32_rotl
  | 0xb7 -> I32_rotr
  | 0xb8 -> I64_rotl
  | 0xb9 -> I64_rotr
  | 0xba -> I64_eqz

  | b when b > 0xba -> illegal s pos b

  | b -> error s pos "too few operands for operator"

and expr_block s = List.rev (expr_block' s [])
and expr_block' s es =
  if eos s then es else
  match peek s with
  | None | Some (0x04 | 0x0f) -> es
  | _ ->
    let pos = pos s in
    let e' = expr s in
    expr_block' s (Source.(e' @@ region s pos pos) :: es)


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
  | "export" -> `ExportSection
  | "start" -> `StartSection
  | "code" -> `CodeSection
  | "data" -> `DataSection
  | _ -> `UnknownSection

let section tag f default s =
  if eos s then default else
  let start_pos = pos s in
  let size = vu s in
  let id_pos = pos s in
  if id s <> tag then (rewind start_pos s; default) else
  let s' = substream s (id_pos + size) in
  let x = f s' in
  require (eos s') s' (pos s') "junk at end of section";
  x


(* Type section *)

let type_section s =
  section `TypeSection (vec func_type) [] s


(* Import section *)

let import s =
  let itype = at var s in
  let module_name = string s in
  let func_name = string s in
  {itype; module_name; func_name}

let import_section s =
  section `ImportSection (vec (at import)) [] s


(* Function section *)

let func_section s =
  section `FuncSection (vec (at var)) [] s


(* Table section *)

let table_section s =
  section `TableSection (vec (at var)) [] s


(* Memory section *)

let memory s =
  let min = vu64 s in
  let max = vu64 s in
  let _ = bool s in (*TODO: pending change*)
  {min; max; segments = []}

let memory_section s =
  section `MemorySection (opt (at memory) true) None s


(* Export section *)

let export s =
  let x = at var s in
  let name = string s in
  {name; kind = `Func x} (*TODO: pending resolution*)

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
  let locals = List.flatten (vec local s) in
  let size = vu s in
  let body = expr_block (substream s (pos s + size)) in
  {locals; body; ftype = Source.((-1) @@ Source.no_region)}

let code_section s =
  section `CodeSection (vec (at code)) [] s


(* Data section *)

let segment s =
  let addr = vu64 s in
  let data = string s in
  {Memory.addr; data}

let data_section s =
  section `DataSection (vec (at segment)) [] s


(* Unknown section *)

let unknown_section s =
  section `UnknownSection (fun s -> skip (len s - pos s) s; true) false s


(* Modules *)

let rec iterate f s = if f s then iterate f s

let module_ s =
  let magic = u32 s in
  require (magic = 0x6d736100l) s 0 "magic header not detected";
  let version = u32 s in
  require (version = 0x0bl) s 4 "unknown binary version";
  iterate unknown_section s;
  let types = type_section s in
  iterate unknown_section s;
  let imports = import_section s in
  iterate unknown_section s;
  let func_types = func_section s in
  iterate unknown_section s;
  let table = table_section s in
  iterate unknown_section s;
  let memory_limits = memory_section s in
  iterate unknown_section s;
  let exports = export_section s in
  iterate unknown_section s;
  let start = start_section s in
  iterate unknown_section s;
  let func_bodies = code_section s in
  iterate unknown_section s;
  let segments = data_section s in
  iterate unknown_section s;
  (*TODO: name section*)
  iterate unknown_section s;
  require (pos s = len s) s (len s) "junk after last section";
  require (List.length func_types = List.length func_bodies)
    s (len s) "function and code section have inconsistent lengths";
  require (memory_limits <> None || segments = [])
    s (len s) "data section without memory section";
  let funcs =
    List.map2 Source.(fun t f -> {f.it with ftype = t} @@ f.at)
      func_types func_bodies in
  let memory =
    match memory_limits with
    | None -> None
    | Some memory -> Some Source.({memory.it with segments} @@ memory.at)
  in {memory; types; funcs; imports; exports; table; start}


let decode name bs = at module_ (stream name bs)

