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
let reset s pos = s.pos := pos

let check n s = if pos s + n > len s then raise EOS
let skip n s = if n < 0 then raise EOS else check n s; s.pos := !(s.pos) + n

let read s = Char.code (s.bytes.[!(s.pos)])
let peek s = if eos s then None else Some (read s)
let get s = check 1 s; let b = read s in skip 1 s; b
let get_string n s = let i = pos s in skip n s; String.sub s.bytes i n


(* Errors *)

open Source

module Code = Error.Make ()
exception Code = Code.Error

let string_of_byte b = Printf.sprintf "%02x" b
let string_of_multi n = Printf.sprintf "%02lx" n

let position s pos = {file = s.name; line = -1; column = pos}
let region s left right = {left = position s left; right = position s right}

let error s pos msg = raise (Code (region s pos pos, msg))
let require b s pos msg = if not b then error s pos msg

let guard f s =
  try f s with EOS -> error s (len s) "unexpected end of section or function"

let get = guard get
let get_string n = guard (get_string n)
let skip n = guard (skip n)

let expect b s msg = require (guard get s = b) s (pos s - 1) msg
let illegal s pos b = error s pos ("illegal opcode " ^ string_of_byte b)
let illegal2 s pos b n =
  error s pos ("illegal opcode " ^ string_of_byte b ^ " " ^ string_of_multi n)

let at f s =
  let left = pos s in
  let x = f s in
  let right = pos s in
  x @@ region s left right


(* Generic values *)

let byte s =
  get s

let word16 s =
  let lo = byte s in
  let hi = byte s in
  hi lsl 8 + lo

let word32 s =
  let lo = Int32.of_int (word16 s) in
  let hi = Int32.of_int (word16 s) in
  Int32.(add lo (shift_left hi 16))

let word64 s =
  let lo = I64_convert.extend_i32_u (word32 s) in
  let hi = I64_convert.extend_i32_u (word32 s) in
  Int64.(add lo (shift_left hi 32))

let rec uN n s =
  require (n > 0) s (pos s) "integer representation too long";
  let b = byte s in
  require (n >= 7 || b land 0x7f < 1 lsl n) s (pos s - 1) "integer too large";
  let x = Int64.of_int (b land 0x7f) in
  if b land 0x80 = 0 then x else Int64.(logor x (shift_left (uN (n - 7) s) 7))

let rec sN n s =
  require (n > 0) s (pos s) "integer representation too long";
  let b = byte s in
  let mask = (-1 lsl (n - 1)) land 0x7f in
  require (n >= 7 || b land mask = 0 || b land mask = mask) s (pos s - 1)
    "integer too large";
  let x = Int64.of_int (b land 0x7f) in
  if b land 0x80 = 0
  then (if b land 0x40 = 0 then x else Int64.(logor x (logxor (-1L) 0x7fL)))
  else Int64.(logor x (shift_left (sN (n - 7) s) 7))

let u1 s = Int64.to_int (uN 1 s)
let u32 s = Int64.to_int32 (uN 32 s)
let s7 s = Int64.to_int (sN 7 s)
let s32 s = Int64.to_int32 (sN 32 s)
let s33 s = I32_convert.wrap_i64 (sN 33 s)
let s64 s = sN 64 s
let f32 s = F32.of_bits (word32 s)
let f64 s = F64.of_bits (word64 s)
let v128 s = V128.of_bits (get_string (Types.vec_size Types.V128Type) s)

let len32 s =
  let pos = pos s in
  let n = u32 s in
  if I32.le_u n (Int32.of_int (len s - pos)) then Int32.to_int n else
    error s pos "length out of bounds"

let bool s = (u1 s = 1)
let string s = let n = len32 s in get_string n s
let rec list f n s = if n = 0 then [] else let x = f s in x :: list f (n - 1) s
let opt f b s = if b then Some (f s) else None
let vec f s = let n = len32 s in list f n s

let rec either fs s =
  match fs with
  | [] -> assert false
  | [f] -> f s
  | f::fs' ->
    let pos = pos s in try f s with Code _ -> reset s pos; either fs' s

let name s =
  let pos = pos s in
  try Utf8.decode (string s) with Utf8.Utf8 ->
    error s pos "malformed UTF-8 encoding"

let sized f s =
  let size = len32 s in
  let start = pos s in
  let x = f size s in
  require (pos s = start + size) s start "section size mismatch";
  x


(* Types *)

open Types

let zero s = expect 0x00 s "zero byte expected"
let var s = u32 s

let num_type s =
  match s7 s with
  | -0x01 -> I32Type
  | -0x02 -> I64Type
  | -0x03 -> F32Type
  | -0x04 -> F64Type
  | _ -> error s (pos s - 1) "malformed number type"

let vec_type s =
  match s7 s with
  | -0x05 -> V128Type
  | _ -> error s (pos s - 1) "malformed vector type"

let ref_type s =
  match s7 s with
  | -0x10 -> FuncRefType
  | -0x11 -> ExternRefType
  | _ -> error s (pos s - 1) "malformed reference type"

let value_type s =
  either [
    (fun s -> NumType (num_type s));
    (fun s -> VecType (vec_type s));
    (fun s -> RefType (ref_type s));
  ] s

let result_type s = vec value_type s

let func_type s =
  match s7 s with
  | -0x20 ->
    let ts1 = result_type s in
    let ts2 = result_type s in
    FuncType (ts1, ts2)
  | _ -> error s (pos s - 1) "malformed function type"

let limits uN s =
  let has_max = bool s in
  let min = uN s in
  let max = opt uN has_max s in
  {min; max}

let table_type s =
  let t = ref_type s in
  let lim = limits u32 s in
  TableType (lim, t)

let memory_type s =
  let lim = limits u32 s in
  MemoryType lim

let mutability s =
  match byte s with
  | 0 -> Immutable
  | 1 -> Mutable
  | _ -> error s (pos s - 1) "malformed mutability"

let global_type s =
  let t = value_type s in
  let mut = mutability s in
  GlobalType (t, mut)

let tag_type s =
  zero s; at var s

(* Instructions *)

open Ast
open Operators

let op s = byte s
let end_ s = expect 0x0b s "END opcode expected"

let memop s =
  let align = u32 s in
  require (I32.le_u align 32l) s (pos s - 1) "malformed memop flags";
  let offset = u32 s in
  Int32.to_int align, offset

let block_type s =
  let p = pos s in
  either [
    (fun s -> let x = at s33 s in require (x.it >= 0l) s p ""; VarBlockType x);
    (fun s -> expect 0x40 s ""; ValBlockType None);
    (fun s -> ValBlockType (Some (value_type s)));
  ] s

let rec instr s =
  let pos = pos s in
  match op s with
  | 0x00 -> unreachable
  | 0x01 -> nop

  | 0x02 ->
    let bt = block_type s in
    let es' = instr_block s in
    end_ s;
    block bt es'
  | 0x03 ->
    let bt = block_type s in
    let es' = instr_block s in
    end_ s;
    loop bt es'
  | 0x04 ->
    let bt = block_type s in
    let es1 = instr_block s in
    if peek s = Some 0x05 then begin
      expect 0x05 s "ELSE or END opcode expected";
      let es2 = instr_block s in
      end_ s;
      if_ bt es1 es2
    end else begin
      end_ s;
      if_ bt es1 []
    end

  | 0x05 -> error s pos "misplaced ELSE opcode"
  | 0x06 ->
    let bt = block_type s in
    let es = instr_block s in
    let ct = catch_list s in
    let ca =
      if peek s = Some 0x19 then begin
        ignore (byte s);
        Some (instr_block s)
      end else
        None
    in
    if ct <> [] || ca <> None then begin
      end_ s;
      try_catch bt es ct ca
    end else begin
      match op s with
      | 0x0b -> try_catch bt es [] None
      | 0x18 -> try_delegate bt es (at var s)
      | b -> illegal s pos b
    end
  | 0x07 -> error s pos "misplaced CATCH opcode"
  | 0x08 -> throw (at var s)
  | 0x09 -> rethrow (at var s)
  | 0x0a as b -> illegal s pos b
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
    let y = at var s in
    let x = at var s in
    call_indirect x y

  | 0x12 | 0x13 | 0x14 | 0x15 | 0x16 | 0x17 as b -> illegal s pos b

  | 0x18 -> error s pos "misplaced DELEGATE opcode"
  | 0x19 -> error s pos "misplaced CATCH_ALL opcode"

  | 0x1a -> drop
  | 0x1b -> select None
  | 0x1c -> select (Some (vec value_type s))

  | 0x1d | 0x1e | 0x1f as b -> illegal s pos b

  | 0x20 -> local_get (at var s)
  | 0x21 -> local_set (at var s)
  | 0x22 -> local_tee (at var s)
  | 0x23 -> global_get (at var s)
  | 0x24 -> global_set (at var s)
  | 0x25 -> table_get (at var s)
  | 0x26 -> table_set (at var s)

  | 0x27 as b -> illegal s pos b

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

  | 0x3f -> zero s; memory_size
  | 0x40 -> zero s; memory_grow

  | 0x41 -> i32_const (at s32 s)
  | 0x42 -> i64_const (at s64 s)
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
  | 0xa8 -> i32_trunc_f32_s
  | 0xa9 -> i32_trunc_f32_u
  | 0xaa -> i32_trunc_f64_s
  | 0xab -> i32_trunc_f64_u
  | 0xac -> i64_extend_i32_s
  | 0xad -> i64_extend_i32_u
  | 0xae -> i64_trunc_f32_s
  | 0xaf -> i64_trunc_f32_u
  | 0xb0 -> i64_trunc_f64_s
  | 0xb1 -> i64_trunc_f64_u
  | 0xb2 -> f32_convert_i32_s
  | 0xb3 -> f32_convert_i32_u
  | 0xb4 -> f32_convert_i64_s
  | 0xb5 -> f32_convert_i64_u
  | 0xb6 -> f32_demote_f64
  | 0xb7 -> f64_convert_i32_s
  | 0xb8 -> f64_convert_i32_u
  | 0xb9 -> f64_convert_i64_s
  | 0xba -> f64_convert_i64_u
  | 0xbb -> f64_promote_f32

  | 0xbc -> i32_reinterpret_f32
  | 0xbd -> i64_reinterpret_f64
  | 0xbe -> f32_reinterpret_i32
  | 0xbf -> f64_reinterpret_i64

  | 0xc0 -> i32_extend8_s
  | 0xc1 -> i32_extend16_s
  | 0xc2 -> i64_extend8_s
  | 0xc3 -> i64_extend16_s
  | 0xc4 -> i64_extend32_s

  | 0xc5 | 0xc6 | 0xc7 | 0xc8 | 0xc9 | 0xca | 0xcb
  | 0xcc | 0xcd | 0xce | 0xcf as b -> illegal s pos b

  | 0xd0 -> ref_null (ref_type s)
  | 0xd1 -> ref_is_null
  | 0xd2 -> ref_func (at var s)

  | 0xfc as b ->
    (match u32 s with
    | 0x00l -> i32_trunc_sat_f32_s
    | 0x01l -> i32_trunc_sat_f32_u
    | 0x02l -> i32_trunc_sat_f64_s
    | 0x03l -> i32_trunc_sat_f64_u
    | 0x04l -> i64_trunc_sat_f32_s
    | 0x05l -> i64_trunc_sat_f32_u
    | 0x06l -> i64_trunc_sat_f64_s
    | 0x07l -> i64_trunc_sat_f64_u

    | 0x08l ->
      let x = at var s in
      zero s; memory_init x
    | 0x09l -> data_drop (at var s)
    | 0x0al -> zero s; zero s; memory_copy
    | 0x0bl -> zero s; memory_fill

    | 0x0cl ->
      let y = at var s in
      let x = at var s in
      table_init x y
    | 0x0dl -> elem_drop (at var s)
    | 0x0el ->
      let x = at var s in
      let y = at var s in
      table_copy x y
    | 0x0fl -> table_grow (at var s)
    | 0x10l -> table_size (at var s)
    | 0x11l -> table_fill (at var s)

    | n -> illegal2 s pos b n
    )

  | 0xfd ->
    (match u32 s with
    | 0x00l -> let a, o = memop s in v128_load a o
    | 0x01l -> let a, o = memop s in v128_load8x8_s a o
    | 0x02l -> let a, o = memop s in v128_load8x8_u a o
    | 0x03l -> let a, o = memop s in v128_load16x4_s a o
    | 0x04l -> let a, o = memop s in v128_load16x4_u a o
    | 0x05l -> let a, o = memop s in v128_load32x2_s a o
    | 0x06l -> let a, o = memop s in v128_load32x2_u a o
    | 0x07l -> let a, o = memop s in v128_load8_splat a o
    | 0x08l -> let a, o = memop s in v128_load16_splat a o
    | 0x09l -> let a, o = memop s in v128_load32_splat a o
    | 0x0al -> let a, o = memop s in v128_load64_splat a o
    | 0x0bl -> let a, o = memop s in v128_store a o
    | 0x0cl -> v128_const (at v128 s)
    | 0x0dl -> i8x16_shuffle (List.init 16 (fun _ -> byte s))
    | 0x0el -> i8x16_swizzle
    | 0x0fl -> i8x16_splat
    | 0x10l -> i16x8_splat
    | 0x11l -> i32x4_splat
    | 0x12l -> i64x2_splat
    | 0x13l -> f32x4_splat
    | 0x14l -> f64x2_splat
    | 0x15l -> let i = byte s in i8x16_extract_lane_s i
    | 0x16l -> let i = byte s in i8x16_extract_lane_u i
    | 0x17l -> let i = byte s in i8x16_replace_lane i
    | 0x18l -> let i = byte s in i16x8_extract_lane_s i
    | 0x19l -> let i = byte s in i16x8_extract_lane_u i
    | 0x1al -> let i = byte s in i16x8_replace_lane i
    | 0x1bl -> let i = byte s in i32x4_extract_lane i
    | 0x1cl -> let i = byte s in i32x4_replace_lane i
    | 0x1dl -> let i = byte s in i64x2_extract_lane i
    | 0x1el -> let i = byte s in i64x2_replace_lane i
    | 0x1fl -> let i = byte s in f32x4_extract_lane i
    | 0x20l -> let i = byte s in f32x4_replace_lane i
    | 0x21l -> let i = byte s in f64x2_extract_lane i
    | 0x22l -> let i = byte s in f64x2_replace_lane i
    | 0x23l -> i8x16_eq
    | 0x24l -> i8x16_ne
    | 0x25l -> i8x16_lt_s
    | 0x26l -> i8x16_lt_u
    | 0x27l -> i8x16_gt_s
    | 0x28l -> i8x16_gt_u
    | 0x29l -> i8x16_le_s
    | 0x2al -> i8x16_le_u
    | 0x2bl -> i8x16_ge_s
    | 0x2cl -> i8x16_ge_u
    | 0x2dl -> i16x8_eq
    | 0x2el -> i16x8_ne
    | 0x2fl -> i16x8_lt_s
    | 0x30l -> i16x8_lt_u
    | 0x31l -> i16x8_gt_s
    | 0x32l -> i16x8_gt_u
    | 0x33l -> i16x8_le_s
    | 0x34l -> i16x8_le_u
    | 0x35l -> i16x8_ge_s
    | 0x36l -> i16x8_ge_u
    | 0x37l -> i32x4_eq
    | 0x38l -> i32x4_ne
    | 0x39l -> i32x4_lt_s
    | 0x3al -> i32x4_lt_u
    | 0x3bl -> i32x4_gt_s
    | 0x3cl -> i32x4_gt_u
    | 0x3dl -> i32x4_le_s
    | 0x3el -> i32x4_le_u
    | 0x3fl -> i32x4_ge_s
    | 0x40l -> i32x4_ge_u
    | 0x41l -> f32x4_eq
    | 0x42l -> f32x4_ne
    | 0x43l -> f32x4_lt
    | 0x44l -> f32x4_gt
    | 0x45l -> f32x4_le
    | 0x46l -> f32x4_ge
    | 0x47l -> f64x2_eq
    | 0x48l -> f64x2_ne
    | 0x49l -> f64x2_lt
    | 0x4al -> f64x2_gt
    | 0x4bl -> f64x2_le
    | 0x4cl -> f64x2_ge
    | 0x4dl -> v128_not
    | 0x4el -> v128_and
    | 0x4fl -> v128_andnot
    | 0x50l -> v128_or
    | 0x51l -> v128_xor
    | 0x52l -> v128_bitselect
    | 0x53l -> v128_any_true
    | 0x54l ->
      let a, o = memop s in
      let lane = byte s in
      v128_load8_lane a o lane
    | 0x55l ->
      let a, o = memop s in
      let lane = byte s in
      v128_load16_lane a o lane
    | 0x56l ->
      let a, o = memop s in
      let lane = byte s in
      v128_load32_lane a o lane
    | 0x57l ->
      let a, o = memop s in
      let lane = byte s in
      v128_load64_lane a o lane
    | 0x58l ->
      let a, o = memop s in
      let lane = byte s in
      v128_store8_lane a o lane
    | 0x59l ->
      let a, o = memop s in
      let lane = byte s in
      v128_store16_lane a o lane
    | 0x5al ->
      let a, o = memop s in
      let lane = byte s in
      v128_store32_lane a o lane
    | 0x5bl ->
      let a, o = memop s in
      let lane = byte s in
      v128_store64_lane a o lane
    | 0x5cl -> let a, o = memop s in v128_load32_zero a o
    | 0x5dl -> let a, o = memop s in v128_load64_zero a o
    | 0x5el -> f32x4_demote_f64x2_zero
    | 0x5fl -> f64x2_promote_low_f32x4
    | 0x60l -> i8x16_abs
    | 0x61l -> i8x16_neg
    | 0x62l -> i8x16_popcnt
    | 0x63l -> i8x16_all_true
    | 0x64l -> i8x16_bitmask
    | 0x65l -> i8x16_narrow_i16x8_s
    | 0x66l -> i8x16_narrow_i16x8_u
    | 0x67l -> f32x4_ceil
    | 0x68l -> f32x4_floor
    | 0x69l -> f32x4_trunc
    | 0x6al -> f32x4_nearest
    | 0x6bl -> i8x16_shl
    | 0x6cl -> i8x16_shr_s
    | 0x6dl -> i8x16_shr_u
    | 0x6el -> i8x16_add
    | 0x6fl -> i8x16_add_sat_s
    | 0x70l -> i8x16_add_sat_u
    | 0x71l -> i8x16_sub
    | 0x72l -> i8x16_sub_sat_s
    | 0x73l -> i8x16_sub_sat_u
    | 0x74l -> f64x2_ceil
    | 0x75l -> f64x2_floor
    | 0x76l -> i8x16_min_s
    | 0x77l -> i8x16_min_u
    | 0x78l -> i8x16_max_s
    | 0x79l -> i8x16_max_u
    | 0x7al -> f64x2_trunc
    | 0x7bl -> i8x16_avgr_u
    | 0x7cl -> i16x8_extadd_pairwise_i8x16_s
    | 0x7dl -> i16x8_extadd_pairwise_i8x16_u
    | 0x7el -> i32x4_extadd_pairwise_i16x8_s
    | 0x7fl -> i32x4_extadd_pairwise_i16x8_u
    | 0x80l -> i16x8_abs
    | 0x81l -> i16x8_neg
    | 0x82l -> i16x8_q15mulr_sat_s
    | 0x83l -> i16x8_all_true
    | 0x84l -> i16x8_bitmask
    | 0x85l -> i16x8_narrow_i32x4_s
    | 0x86l -> i16x8_narrow_i32x4_u
    | 0x87l -> i16x8_extend_low_i8x16_s
    | 0x88l -> i16x8_extend_high_i8x16_s
    | 0x89l -> i16x8_extend_low_i8x16_u
    | 0x8al -> i16x8_extend_high_i8x16_u
    | 0x8bl -> i16x8_shl
    | 0x8cl -> i16x8_shr_s
    | 0x8dl -> i16x8_shr_u
    | 0x8el -> i16x8_add
    | 0x8fl -> i16x8_add_sat_s
    | 0x90l -> i16x8_add_sat_u
    | 0x91l -> i16x8_sub
    | 0x92l -> i16x8_sub_sat_s
    | 0x93l -> i16x8_sub_sat_u
    | 0x94l -> f64x2_nearest
    | 0x95l -> i16x8_mul
    | 0x96l -> i16x8_min_s
    | 0x97l -> i16x8_min_u
    | 0x98l -> i16x8_max_s
    | 0x99l -> i16x8_max_u
    | 0x9bl -> i16x8_avgr_u
    | 0x9cl -> i16x8_extmul_low_i8x16_s
    | 0x9dl -> i16x8_extmul_high_i8x16_s
    | 0x9el -> i16x8_extmul_low_i8x16_u
    | 0x9fl -> i16x8_extmul_high_i8x16_u
    | 0xa0l -> i32x4_abs
    | 0xa1l -> i32x4_neg
    | 0xa3l -> i32x4_all_true
    | 0xa4l -> i32x4_bitmask
    | 0xa7l -> i32x4_extend_low_i16x8_s
    | 0xa8l -> i32x4_extend_high_i16x8_s
    | 0xa9l -> i32x4_extend_low_i16x8_u
    | 0xaal -> i32x4_extend_high_i16x8_u
    | 0xabl -> i32x4_shl
    | 0xacl -> i32x4_shr_s
    | 0xadl -> i32x4_shr_u
    | 0xael -> i32x4_add
    | 0xb1l -> i32x4_sub
    | 0xb5l -> i32x4_mul
    | 0xb6l -> i32x4_min_s
    | 0xb7l -> i32x4_min_u
    | 0xb8l -> i32x4_max_s
    | 0xb9l -> i32x4_max_u
    | 0xbal -> i32x4_dot_i16x8_s
    | 0xbcl -> i32x4_extmul_low_i16x8_s
    | 0xbdl -> i32x4_extmul_high_i16x8_s
    | 0xbel -> i32x4_extmul_low_i16x8_u
    | 0xbfl -> i32x4_extmul_high_i16x8_u
    | 0xc0l -> i64x2_abs
    | 0xc1l -> i64x2_neg
    | 0xc3l -> i64x2_all_true
    | 0xc4l -> i64x2_bitmask
    | 0xc7l -> i64x2_extend_low_i32x4_s
    | 0xc8l -> i64x2_extend_high_i32x4_s
    | 0xc9l -> i64x2_extend_low_i32x4_u
    | 0xcal -> i64x2_extend_high_i32x4_u
    | 0xcbl -> i64x2_shl
    | 0xccl -> i64x2_shr_s
    | 0xcdl -> i64x2_shr_u
    | 0xcel -> i64x2_add
    | 0xd1l -> i64x2_sub
    | 0xd5l -> i64x2_mul
    | 0xd6l -> i64x2_eq
    | 0xd7l -> i64x2_ne
    | 0xd8l -> i64x2_lt_s
    | 0xd9l -> i64x2_gt_s
    | 0xdal -> i64x2_le_s
    | 0xdbl -> i64x2_ge_s
    | 0xdcl -> i64x2_extmul_low_i32x4_s
    | 0xddl -> i64x2_extmul_high_i32x4_s
    | 0xdel -> i64x2_extmul_low_i32x4_u
    | 0xdfl -> i64x2_extmul_high_i32x4_u
    | 0xe0l -> f32x4_abs
    | 0xe1l -> f32x4_neg
    | 0xe3l -> f32x4_sqrt
    | 0xe4l -> f32x4_add
    | 0xe5l -> f32x4_sub
    | 0xe6l -> f32x4_mul
    | 0xe7l -> f32x4_div
    | 0xe8l -> f32x4_min
    | 0xe9l -> f32x4_max
    | 0xeal -> f32x4_pmin
    | 0xebl -> f32x4_pmax
    | 0xecl -> f64x2_abs
    | 0xedl -> f64x2_neg
    | 0xefl -> f64x2_sqrt
    | 0xf0l -> f64x2_add
    | 0xf1l -> f64x2_sub
    | 0xf2l -> f64x2_mul
    | 0xf3l -> f64x2_div
    | 0xf4l -> f64x2_min
    | 0xf5l -> f64x2_max
    | 0xf6l -> f64x2_pmin
    | 0xf7l -> f64x2_pmax
    | 0xf8l -> i32x4_trunc_sat_f32x4_s
    | 0xf9l -> i32x4_trunc_sat_f32x4_u
    | 0xfal -> f32x4_convert_i32x4_s
    | 0xfbl -> f32x4_convert_i32x4_u
    | 0xfcl -> i32x4_trunc_sat_f64x2_s_zero
    | 0xfdl -> i32x4_trunc_sat_f64x2_u_zero
    | 0xfel -> f64x2_convert_low_i32x4_s
    | 0xffl -> f64x2_convert_low_i32x4_u
    | n -> illegal s pos (I32.to_int_u n)
    )

  | b -> illegal s pos b

and instr_block s = List.rev (instr_block' s [])
and instr_block' s es =
  match peek s with
  | None | Some (0x05 | 0x07 | 0x0a | 0x0b | 0x18 | 0x19) -> es
  | _ ->
    let pos = pos s in
    let e' = instr s in
    instr_block' s ((e' @@ region s pos pos) :: es)
and catch_list s =
  if peek s = Some 0x07 then begin
    ignore (byte s);
    let tag = at var s in
    let instrs = instr_block s in
    (tag, instrs) :: catch_list s
  end else
    []

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
    | 12 -> `DataCountSection
    | 13 -> `TagSection
    | _ -> error s (pos s) "malformed section id"
    ) bo

let section_with_size tag f default s =
  match id s with
  | Some tag' when tag' = tag -> skip 1 s; sized f s
  | _ -> default

let section tag f default s =
  section_with_size tag (fun _ -> f) default s


(* Type section *)

let type_ s = at func_type s

let type_section s =
  section `TypeSection (vec type_) [] s


(* Import section *)

let import_desc s =
  match byte s with
  | 0x00 -> FuncImport (at var s)
  | 0x01 -> TableImport (table_type s)
  | 0x02 -> MemoryImport (memory_type s)
  | 0x03 -> GlobalImport (global_type s)
  | 0x04 -> TagImport (tag_type s)
  | _ -> error s (pos s - 1) "malformed import kind"

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

(* Tag section *)

let tag s =
  let tgtype = tag_type s in
  {tgtype}

let tag_section s =
  section `TagSection (vec (at tag)) [] s

(* Global section *)

let global s =
  let gtype = global_type s in
  let ginit = const s in
  {gtype; ginit}

let global_section s =
  section `GlobalSection (vec (at global)) [] s


(* Export section *)

let export_desc s =
  match byte s with
  | 0x00 -> FuncExport (at var s)
  | 0x01 -> TableExport (at var s)
  | 0x02 -> MemoryExport (at var s)
  | 0x03 -> GlobalExport (at var s)
  | 0x04 -> TagExport (at var s)
  | _ -> error s (pos s - 1) "malformed export kind"

let export s =
  let name = name s in
  let edesc = at export_desc s in
  {name; edesc}

let export_section s =
  section `ExportSection (vec (at export)) [] s


(* Start section *)

let start s =
  let sfunc = at var s in
  {sfunc}

let start_section s =
  section `StartSection (opt (at start) true) None s


(* Code section *)

let local s =
  let n = u32 s in
  let t = value_type s in
  n, t

let locals s =
  let pos = pos s in
  let nts = vec local s in
  let ns = List.map (fun (n, _) -> I64_convert.extend_i32_u n) nts in
  require (I64.lt_u (List.fold_left I64.add 0L ns) 0x1_0000_0000L)
    s pos "too many locals";
  List.flatten (List.map (Lib.Fun.uncurry Lib.List32.make) nts)

let code _ s =
  let locals = locals s in
  let body = instr_block s in
  end_ s;
  {locals; body; ftype = -1l @@ no_region}

let code_section s =
  section `CodeSection (vec (at (sized code))) [] s


(* Element section *)

let passive s =
  Passive

let active s =
  let index = at var s in
  let offset = const s in
  Active {index; offset}

let active_zero s =
  let index = 0l @@ no_region in
  let offset = const s in
  Active {index; offset}

let declarative s =
  Declarative

let elem_index s =
  let x = at var s in
  [ref_func x @@ x.at]

let elem_kind s =
  match byte s with
  | 0x00 -> FuncRefType
  | _ -> error s (pos s - 1) "malformed element kind"

let elem s =
  match u32 s with
  | 0x00l ->
    let emode = at active_zero s in
    let einit = vec (at elem_index) s in
    {etype = FuncRefType; einit; emode}
  | 0x01l ->
    let emode = at passive s in
    let etype = elem_kind s in
    let einit = vec (at elem_index) s in
    {etype; einit; emode}
  | 0x02l ->
    let emode = at active s in
    let etype = elem_kind s in
    let einit = vec (at elem_index) s in
    {etype; einit; emode}
  | 0x03l ->
    let emode = at declarative s in
    let etype = elem_kind s in
    let einit = vec (at elem_index) s in
    {etype; einit; emode}
  | 0x04l ->
    let emode = at active_zero s in
    let einit = vec const s in
    {etype = FuncRefType; einit; emode}
  | 0x05l ->
    let emode = at passive s in
    let etype = ref_type s in
    let einit = vec const s in
    {etype; einit; emode}
  | 0x06l ->
    let emode = at active s in
    let etype = ref_type s in
    let einit = vec const s in
    {etype; einit; emode}
  | 0x07l ->
    let emode = at declarative s in
    let etype = ref_type s in
    let einit = vec const s in
    {etype; einit; emode}
  | _ -> error s (pos s - 1) "malformed elements segment kind"

let elem_section s =
  section `ElemSection (vec (at elem)) [] s


(* Data section *)

let data s =
  match u32 s with
  | 0x00l ->
    let dmode = at active_zero s in
    let dinit = string s in
    {dinit; dmode}
  | 0x01l ->
    let dmode = at passive s in
    let dinit = string s in
    {dinit; dmode}
  | 0x02l ->
    let dmode = at active s in
    let dinit = string s in
    {dinit; dmode}
  | _ -> error s (pos s - 1) "malformed data segment kind"

let data_section s =
  section `DataSection (vec (at data)) [] s


(* DataCount section *)

let data_count s =
  Some (u32 s)

let data_count_section s =
  section `DataCountSection data_count None s


(* Custom section *)

let custom size s =
  let start = pos s in
  let id = name s in
  let bs = get_string (size - (pos s - start)) s in
  Some (id, bs)

let custom_section s =
  section_with_size `CustomSection custom None s

let non_custom_section s =
  match id s with
  | None | Some `CustomSection -> None
  | _ -> skip 1 s; sized skip s; Some ()


(* Modules *)

let rec iterate f s = if f s <> None then iterate f s

let magic = 0x6d736100l

let module_ s =
  let header = word32 s in
  require (header = magic) s 0 "magic header not detected";
  let version = word32 s in
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
  let tags = tag_section s in
  iterate custom_section s;
  let globals = global_section s in
  iterate custom_section s;
  let exports = export_section s in
  iterate custom_section s;
  let start = start_section s in
  iterate custom_section s;
  let elems = elem_section s in
  iterate custom_section s;
  let data_count = data_count_section s in
  iterate custom_section s;
  let func_bodies = code_section s in
  iterate custom_section s;
  let datas = data_section s in
  iterate custom_section s;
  require (pos s = len s) s (len s) "unexpected content after last section";
  require (List.length func_types = List.length func_bodies)
    s (len s) "function and code section have inconsistent lengths";
  require (data_count = None || data_count = Some (Lib.List32.length datas))
    s (len s) "data count and data section have inconsistent lengths";
  require (data_count <> None ||
    List.for_all Free.(fun f -> (func f).datas = Set.empty) func_bodies)
    s (len s) "data count section required";
  let funcs =
    List.map2 (fun t f -> {f.it with ftype = t} @@ f.at) func_types func_bodies
  in {types; tables; memories; tags; globals; funcs; imports; exports; elems;
      datas; start}


let decode name bs = at module_ (stream name bs)

let all_custom tag s =
  let header = word32 s in
  require (header = magic) s 0 "magic header not detected";
  let version = word32 s in
  require (version = Encode.version) s 4 "unknown binary version";
  let rec collect () =
    iterate non_custom_section s;
    match custom_section s with
    | None -> []
    | Some (n, s) when n = tag -> s :: collect ()
    | Some _ -> collect ()
  in collect ()

let decode_custom tag name bs = all_custom tag (stream name bs)
