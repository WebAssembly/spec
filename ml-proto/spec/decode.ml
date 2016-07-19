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
  expect 0x40 s "invalid function type";
  let ins = vec value_type s in
  let out = expr_type s in
  {ins; out}


(* Decode expressions *)

open Kernel
open Ast

let op s = u8 s
let arity s = vu s
let arity1 s = bool s

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

let rec expr stack s =
  let pos = pos s in
  match op s, stack with
  | 0x00, es ->
    Nop, es
  | 0x01, es ->
    let es' = expr_block s in
    expect 0x0f s "`end` opcode expected";
    Block es', es
  | 0x02, es ->
    let es' = expr_block s in
    expect 0x0f s "`end` opcode expected";
    Loop es', es
  | 0x03, e :: es ->
    let es1 = expr_block s in
    if peek s = Some 0x04 then begin
      expect 0x04 s "`else` or `end` opcode expected";
      let es2 = expr_block s in
      expect 0x0f s "`end` opcode expected";
      If (e, es1, es2), es
    end else begin
      expect 0x0f s "`end` opcode expected";
      If (e, es1, []), es
    end
  | 0x04, _ ->
    error s pos "misplaced `else` opcode"
  | 0x05, e3 :: e2 :: e1 :: es ->
    Select (e1, e2, e3), es
  | 0x06, es ->
    let b = arity1 s in
    let x = at var s in
    let eo, es' = args1 b es s pos in
    Br (x, eo), es'
  | 0x07, e :: es ->
    let b = arity1 s in
    let x = at var s in
    let eo, es' = args1 b es s pos in
    Br_if (x, eo, e), es'
  | 0x08, e :: es ->
    let b = arity1 s in
    let xs = vec (at var) s in
    let x = at var s in
    let eo, es' = args1 b es s pos in
    Br_table (xs, x, eo, e), es'
  | 0x09, es ->
    let b = arity1 s in
    let eo, es' = args1 b es s pos in
    Return eo, es'
  | 0x0a, es ->
    Unreachable, es
  | 0x0b, e :: es ->
    Drop e, es
  | 0x0c | 0x0d | 0x0e as b, _ ->
    illegal s pos b
  | 0x0f, _ ->
    error s pos "misplaced `end` opcode"

  | 0x10, es -> I32_const (at vs32 s), es
  | 0x11, es -> I64_const (at vs64 s), es
  | 0x12, es -> F32_const (at f32 s), es
  | 0x13, es -> F64_const (at f64 s), es

  | 0x14, es ->
    let x = at var s in
    Get_local x, es
  | 0x15, e :: es ->
    let x = at var s in
    Set_local (x, e), es

  | 0x16, es ->
    let n = arity s in
    let x = at var s in
    let es1, es' = args n es s pos in
    Call (x, es1), es'
  | 0x17, es ->
    let n = arity s in
    let x = at var s in
    let es1, es' = args (n + 1) es s pos in
    Call_indirect (x, List.hd es1, List.tl es1), es'
  | 0x18, es ->
    let n = arity s in
    let x = at var s in
    let es1, es' = args n es s pos in
    Call_import (x, es1), es'

  | 0x19, e :: es ->
    let x = at var s in
    Tee_local (x, e), es
  | 0x1a, es ->
    let x = at var s in
    Get_global x, es
  | 0x1b, e :: es ->
    let x = at var s in
    Set_global (x, e), es

  | 0x1c | 0x1d | 0x1e | 0x1f as b, _ ->
    illegal s pos b

  | 0x20, e :: es -> let o, a = memop s in I32_load8_s (o, a, e), es
  | 0x21, e :: es -> let o, a = memop s in I32_load8_u (o, a, e), es
  | 0x22, e :: es -> let o, a = memop s in I32_load16_s (o, a, e), es
  | 0x23, e :: es -> let o, a = memop s in I32_load16_u (o, a, e), es
  | 0x24, e :: es -> let o, a = memop s in I64_load8_s (o, a, e), es
  | 0x25, e :: es -> let o, a = memop s in I64_load8_u (o, a, e), es
  | 0x26, e :: es -> let o, a = memop s in I64_load16_s (o, a, e), es
  | 0x27, e :: es -> let o, a = memop s in I64_load16_u (o, a, e), es
  | 0x28, e :: es -> let o, a = memop s in I64_load32_s (o, a, e), es
  | 0x29, e :: es -> let o, a = memop s in I64_load32_u (o, a, e), es
  | 0x2a, e :: es -> let o, a = memop s in I32_load (o, a, e), es
  | 0x2b, e :: es -> let o, a = memop s in I64_load (o, a, e), es
  | 0x2c, e :: es -> let o, a = memop s in F32_load (o, a, e), es
  | 0x2d, e :: es -> let o, a = memop s in F64_load (o, a, e), es

  | 0x2e, e2 :: e1 :: es -> let o, a = memop s in I32_store8 (o, a, e1, e2), es
  | 0x2f, e2 :: e1 :: es -> let o, a = memop s in I32_store16 (o, a, e1, e2), es
  | 0x30, e2 :: e1 :: es -> let o, a = memop s in I64_store8 (o, a, e1, e2), es
  | 0x31, e2 :: e1 :: es -> let o, a = memop s in I64_store16 (o, a, e1, e2), es
  | 0x32, e2 :: e1 :: es -> let o, a = memop s in I64_store32 (o, a, e1, e2), es
  | 0x33, e2 :: e1 :: es -> let o, a = memop s in I32_store (o, a, e1, e2), es
  | 0x34, e2 :: e1 :: es -> let o, a = memop s in I64_store (o, a, e1, e2), es
  | 0x35, e2 :: e1 :: es -> let o, a = memop s in F32_store (o, a, e1, e2), es
  | 0x36, e2 :: e1 :: es -> let o, a = memop s in F64_store (o, a, e1, e2), es

  | 0x37 | 0x38 as b, _ -> illegal s pos b

  | 0x39, e :: es -> Grow_memory e, es
  | 0x3a as b, _ -> illegal s pos b
  | 0x3b, es -> Current_memory, es

  | 0x3c | 0x3d | 0x3e | 0x3f as b, _ -> illegal s pos b

  | 0x40, e2 :: e1 :: es -> I32_add (e1, e2), es
  | 0x41, e2 :: e1 :: es -> I32_sub (e1, e2), es
  | 0x42, e2 :: e1 :: es -> I32_mul (e1, e2), es
  | 0x43, e2 :: e1 :: es -> I32_div_s (e1, e2), es
  | 0x44, e2 :: e1 :: es -> I32_div_u (e1, e2), es
  | 0x45, e2 :: e1 :: es -> I32_rem_s (e1, e2), es
  | 0x46, e2 :: e1 :: es -> I32_rem_u (e1, e2), es
  | 0x47, e2 :: e1 :: es -> I32_and (e1, e2), es
  | 0x48, e2 :: e1 :: es -> I32_or (e1, e2), es
  | 0x49, e2 :: e1 :: es -> I32_xor (e1, e2), es
  | 0x4a, e2 :: e1 :: es -> I32_shl (e1, e2), es
  | 0x4b, e2 :: e1 :: es -> I32_shr_u (e1, e2), es
  | 0x4c, e2 :: e1 :: es -> I32_shr_s (e1, e2), es
  | 0x4d, e2 :: e1 :: es -> I32_eq (e1, e2), es
  | 0x4e, e2 :: e1 :: es -> I32_ne (e1, e2), es
  | 0x4f, e2 :: e1 :: es -> I32_lt_s (e1, e2), es
  | 0x50, e2 :: e1 :: es -> I32_le_s (e1, e2), es
  | 0x51, e2 :: e1 :: es -> I32_lt_u (e1, e2), es
  | 0x52, e2 :: e1 :: es -> I32_le_u (e1, e2), es
  | 0x53, e2 :: e1 :: es -> I32_gt_s (e1, e2), es
  | 0x54, e2 :: e1 :: es -> I32_ge_s (e1, e2), es
  | 0x55, e2 :: e1 :: es -> I32_gt_u (e1, e2), es
  | 0x56, e2 :: e1 :: es -> I32_ge_u (e1, e2), es
  | 0x57, e :: es -> I32_clz e, es
  | 0x58, e :: es -> I32_ctz e, es
  | 0x59, e :: es -> I32_popcnt e, es
  | 0x5a, e :: es -> I32_eqz e, es

  | 0x5b, e2 :: e1 :: es -> I64_add (e1, e2), es
  | 0x5c, e2 :: e1 :: es -> I64_sub (e1, e2), es
  | 0x5d, e2 :: e1 :: es -> I64_mul (e1, e2), es
  | 0x5e, e2 :: e1 :: es -> I64_div_s (e1, e2), es
  | 0x5f, e2 :: e1 :: es -> I64_div_u (e1, e2), es
  | 0x60, e2 :: e1 :: es -> I64_rem_s (e1, e2), es
  | 0x61, e2 :: e1 :: es -> I64_rem_u (e1, e2), es
  | 0x62, e2 :: e1 :: es -> I64_and (e1, e2), es
  | 0x63, e2 :: e1 :: es -> I64_or (e1, e2), es
  | 0x64, e2 :: e1 :: es -> I64_xor (e1, e2), es
  | 0x65, e2 :: e1 :: es -> I64_shl (e1, e2), es
  | 0x66, e2 :: e1 :: es -> I64_shr_u (e1, e2), es
  | 0x67, e2 :: e1 :: es -> I64_shr_s (e1, e2), es
  | 0x68, e2 :: e1 :: es -> I64_eq (e1, e2), es
  | 0x69, e2 :: e1 :: es -> I64_ne (e1, e2), es
  | 0x6a, e2 :: e1 :: es -> I64_lt_s (e1, e2), es
  | 0x6b, e2 :: e1 :: es -> I64_le_s (e1, e2), es
  | 0x6c, e2 :: e1 :: es -> I64_lt_u (e1, e2), es
  | 0x6d, e2 :: e1 :: es -> I64_le_u (e1, e2), es
  | 0x6e, e2 :: e1 :: es -> I64_gt_s (e1, e2), es
  | 0x6f, e2 :: e1 :: es -> I64_ge_s (e1, e2), es
  | 0x70, e2 :: e1 :: es -> I64_gt_u (e1, e2), es
  | 0x71, e2 :: e1 :: es -> I64_ge_u (e1, e2), es
  | 0x72, e :: es -> I64_clz e, es
  | 0x73, e :: es -> I64_ctz e, es
  | 0x74, e :: es -> I64_popcnt e, es

  | 0x75, e2 :: e1 :: es -> F32_add (e1, e2), es
  | 0x76, e2 :: e1 :: es -> F32_sub (e1, e2), es
  | 0x77, e2 :: e1 :: es -> F32_mul (e1, e2), es
  | 0x78, e2 :: e1 :: es -> F32_div (e1, e2), es
  | 0x79, e2 :: e1 :: es -> F32_min (e1, e2), es
  | 0x7a, e2 :: e1 :: es -> F32_max (e1, e2), es
  | 0x7b, e :: es -> F32_abs e, es
  | 0x7c, e :: es -> F32_neg e, es
  | 0x7d, e2 :: e1 :: es -> F32_copysign (e1, e2), es
  | 0x7e, e :: es -> F32_ceil e, es
  | 0x7f, e :: es -> F32_floor e, es
  | 0x80, e :: es -> F32_trunc e, es
  | 0x81, e :: es -> F32_nearest e, es
  | 0x82, e :: es -> F32_sqrt e, es
  | 0x83, e2 :: e1 :: es -> F32_eq (e1, e2), es
  | 0x84, e2 :: e1 :: es -> F32_ne (e1, e2), es
  | 0x85, e2 :: e1 :: es -> F32_lt (e1, e2), es
  | 0x86, e2 :: e1 :: es -> F32_le (e1, e2), es
  | 0x87, e2 :: e1 :: es -> F32_gt (e1, e2), es
  | 0x88, e2 :: e1 :: es -> F32_ge (e1, e2), es

  | 0x89, e2 :: e1 :: es -> F64_add (e1, e2), es
  | 0x8a, e2 :: e1 :: es -> F64_sub (e1, e2), es
  | 0x8b, e2 :: e1 :: es -> F64_mul (e1, e2), es
  | 0x8c, e2 :: e1 :: es -> F64_div (e1, e2), es
  | 0x8d, e2 :: e1 :: es -> F64_min (e1, e2), es
  | 0x8e, e2 :: e1 :: es -> F64_max (e1, e2), es
  | 0x8f, e :: es -> F64_abs e, es
  | 0x90, e :: es -> F64_neg e, es
  | 0x91, e2 :: e1 :: es -> F64_copysign (e1, e2), es
  | 0x92, e :: es -> F64_ceil e, es
  | 0x93, e :: es -> F64_floor e, es
  | 0x94, e :: es -> F64_trunc e, es
  | 0x95, e :: es -> F64_nearest e, es
  | 0x96, e :: es -> F64_sqrt e, es
  | 0x97, e2 :: e1 :: es -> F64_eq (e1, e2), es
  | 0x98, e2 :: e1 :: es -> F64_ne (e1, e2), es
  | 0x99, e2 :: e1 :: es -> F64_lt (e1, e2), es
  | 0x9a, e2 :: e1 :: es -> F64_le (e1, e2), es
  | 0x9b, e2 :: e1 :: es -> F64_gt (e1, e2), es
  | 0x9c, e2 :: e1 :: es -> F64_ge (e1, e2), es

  | 0x9d, e :: es -> I32_trunc_s_f32 e, es
  | 0x9e, e :: es -> I32_trunc_s_f64 e, es
  | 0x9f, e :: es -> I32_trunc_u_f32 e, es
  | 0xa0, e :: es -> I32_trunc_u_f64 e, es
  | 0xa1, e :: es -> I32_wrap_i64 e, es
  | 0xa2, e :: es -> I64_trunc_s_f32 e, es
  | 0xa3, e :: es -> I64_trunc_s_f64 e, es
  | 0xa4, e :: es -> I64_trunc_u_f32 e, es
  | 0xa5, e :: es -> I64_trunc_u_f64 e, es
  | 0xa6, e :: es -> I64_extend_s_i32 e, es
  | 0xa7, e :: es -> I64_extend_u_i32 e, es
  | 0xa8, e :: es -> F32_convert_s_i32 e, es
  | 0xa9, e :: es -> F32_convert_u_i32 e, es
  | 0xaa, e :: es -> F32_convert_s_i64 e, es
  | 0xab, e :: es -> F32_convert_u_i64 e, es
  | 0xac, e :: es -> F32_demote_f64 e, es
  | 0xad, e :: es -> F32_reinterpret_i32 e, es
  | 0xae, e :: es -> F64_convert_s_i32 e, es
  | 0xaf, e :: es -> F64_convert_u_i32 e, es
  | 0xb0, e :: es -> F64_convert_s_i64 e, es
  | 0xb1, e :: es -> F64_convert_u_i64 e, es
  | 0xb2, e :: es -> F64_promote_f32 e, es
  | 0xb3, e :: es -> F64_reinterpret_i64 e, es
  | 0xb4, e :: es -> I32_reinterpret_f32 e, es
  | 0xb5, e :: es -> I64_reinterpret_f64 e, es

  | 0xb6, e2 :: e1 :: es -> I32_rotl (e1, e2), es
  | 0xb7, e2 :: e1 :: es -> I32_rotr (e1, e2), es
  | 0xb8, e2 :: e1 :: es -> I64_rotl (e1, e2), es
  | 0xb9, e2 :: e1 :: es -> I64_rotr (e1, e2), es
  | 0xba, e :: es -> I64_eqz e, es

  | b, _ when b > 0xba -> illegal s pos b

  | b, _ -> error s pos "too few operands for operator"

and expr_block s = List.rev (expr_block' [] s)
and expr_block' stack s =
  if eos s then stack else
  match peek s with
  | None | Some (0x04 | 0x0f) -> stack
  | _ ->
    let pos = pos s in
    let e', stack' = expr stack s in
    expr_block' (Source.(e' @@ region s pos pos) :: stack') s


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


(* Global section *)

let global s =
  let n = vu s in
  let t = value_type s in
  Lib.List.make n t

let global_section s =
  section `GlobalSection (fun s -> List.flatten (vec global s)) [] s


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
  require (version = Encode.version) s 4 "unknown binary version";
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
  let globals = global_section s in
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
  in {memory; types; globals; funcs; imports; exports; table; start}


let decode name bs = at module_ (stream name bs)

