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

let bit i n = n land (1 lsl i) <> 0

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
  let lo = Convert.I64_.extend_i32_u (word32 s) in
  let hi = Convert.I64_.extend_i32_u (word32 s) in
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

let u32 s = Int64.to_int32 (uN 32 s)
let u64 s = uN 64 s
let s7 s = Int64.to_int (sN 7 s)
let s32 s = Int64.to_int32 (sN 32 s)
let s33 s = Convert.I32_.wrap_i64 (sN 33 s)
let s64 s = sN 64 s
let f32 s = F32.of_bits (word32 s)
let f64 s = F64.of_bits (word64 s)
let v128 s = V128.of_bits (get_string 16 s)

let len32 s =
  let pos = pos s in
  let n = u32 s in
  if I32.le_u n (Int32.of_int (len s - pos)) then Int32.to_int n else
    error s pos "length out of bounds"

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
let idx s = u32 s

let mutability s =
  match byte s with
  | 0 -> Cons
  | 1 -> Var
  | _ -> error s (pos s - 1) "malformed mutability"

let typeuse idx s =
  let pos = pos s in
  match idx s with
  | i when i >= 0l -> Idx i
  | _ -> error s pos "malformed type index"

let numtype s =
  match s7 s with
  | -0x01 -> I32T
  | -0x02 -> I64T
  | -0x03 -> F32T
  | -0x04 -> F64T
  | _ -> error s (pos s - 1) "malformed number type"

let vectype s =
  match s7 s with
  | -0x05 -> V128T
  | _ -> error s (pos s - 1) "malformed vector type"

let heaptype s =
  let pos = pos s in
  either [
    (fun s -> UseHT (typeuse s33 s));
    (fun s ->
      match s7 s with
      | -0x0c -> NoExnHT
      | -0x0d -> NoFuncHT
      | -0x0e -> NoExternHT
      | -0x0f -> NoneHT
      | -0x10 -> FuncHT
      | -0x11 -> ExternHT
      | -0x12 -> AnyHT
      | -0x13 -> EqHT
      | -0x14 -> I31HT
      | -0x15 -> StructHT
      | -0x16 -> ArrayHT
      | -0x17 -> ExnHT
      | _ -> error s pos "malformed heap type"
    )
  ] s

let reftype s =
  let pos = pos s in
  match s7 s with
  | -0x0c -> (Null, NoExnHT)
  | -0x0d -> (Null, NoFuncHT)
  | -0x0e -> (Null, NoExternHT)
  | -0x0f -> (Null, NoneHT)
  | -0x10 -> (Null, FuncHT)
  | -0x11 -> (Null, ExternHT)
  | -0x12 -> (Null, AnyHT)
  | -0x13 -> (Null, EqHT)
  | -0x14 -> (Null, I31HT)
  | -0x15 -> (Null, StructHT)
  | -0x16 -> (Null, ArrayHT)
  | -0x17 -> (Null, ExnHT)
  | -0x1c -> (NoNull, heaptype s)
  | -0x1d -> (Null, heaptype s)
  | _ -> error s pos "malformed reference type"

let valtype s =
  either [
    (fun s -> NumT (numtype s));
    (fun s -> VecT (vectype s));
    (fun s -> RefT (reftype s));
  ] s

let resulttype s = vec valtype s

let packtype s =
  let pos = pos s in
  match s7 s with
  | -0x08 -> I8T
  | -0x09 -> I16T
  | _ -> error s pos "malformed storage type"

let storagetype s =
  either [
    (fun s -> ValStorageT (valtype s));
    (fun s -> PackStorageT (packtype s));
  ] s

let fieldtype s =
  let t = storagetype s in
  let mut = mutability s in
  FieldT (mut, t)

let structtype s =
  StructT (vec fieldtype s)

let arraytype s =
  ArrayT (fieldtype s)

let functype s =
  let ts1 = resulttype s in
  let ts2 = resulttype s in
  FuncT (ts1, ts2)

let comptype s =
  match s7 s with
  | -0x20 -> FuncCT (functype s)
  | -0x21 -> StructCT (structtype s)
  | -0x22 -> ArrayCT (arraytype s)
  | _ -> error s (pos s - 1) "malformed definition type"

let subtype s =
  match peek s with
  | Some i when i = -0x30 land 0x7f ->
    skip 1 s;
    let uts = vec (typeuse u32) s in
    SubT (NoFinal, uts, comptype s)
  | Some i when i = -0x31 land 0x7f ->
    skip 1 s;
    let uts = vec (typeuse u32) s in
    SubT (Final, uts, comptype s)
  | _ -> SubT (Final, [], comptype s)

let rectype s =
  match peek s with
  | Some i when i = -0x32 land 0x7f -> skip 1 s; RecT (vec subtype s)
  | _ -> RecT [subtype s]


let limits uN s =
  let flags = byte s in
  require (flags land 0xfa = 0) s (pos s - 1) "malformed limits flags";
  let has_max = (flags land 1 = 1) in
  let at = if flags land 4 = 4 then I64AT else I32AT in
  let min = uN s in
  let max = opt uN has_max s in
  at, {min; max}

let tagtype s =
  zero s;
  TagT (typeuse idx s)

let globaltype s =
  let t = valtype s in
  let mut = mutability s in
  GlobalT (mut, t)

let memorytype s =
  let at, lim = limits u64 s in
  MemoryT (at, lim)

let tabletype s =
  let t = reftype s in
  let at, lim = limits u64 s in
  TableT (at, lim, t)

let externtype s =
  match byte s with
  | 0x00 -> ExternFuncT (typeuse idx s)
  | 0x01 -> ExternTableT (tabletype s)
  | 0x02 -> ExternMemoryT (memorytype s)
  | 0x03 -> ExternGlobalT (globaltype s)
  | 0x04 -> ExternTagT (tagtype s)
  | _ -> error s (pos s - 1) "malformed import kind"


(* Instructions *)

open Ast
open Mnemonics

let op s = byte s
let end_ s = expect 0x0b s "END opcode expected"

let memop s =
  let pos = pos s in
  let flags = u32 s in
  require (I32.lt_u flags 0x80l) s pos "malformed memop flags";
  let has_idx = Int32.logand flags 0x40l <> 0l in
  let x = if has_idx then at idx s else Source.(0l @@ no_region) in
  let align = Int32.(to_int (logand flags 0x3fl)) in
  let offset = u64 s in
  x, align, offset

let blocktype s =
  either [
    (fun s -> VarBlockType (at (fun s -> idx_of_typeuse (typeuse s33 s)) s));
    (fun s -> expect 0x40 s ""; ValBlockType None);
    (fun s -> ValBlockType (Some (valtype s)));
  ] s

let local s =
  let n = u32 s in
  let t = at valtype s in
  n, Local t.it @@ t.at

let locals s =
  let pos = pos s in
  let nts = vec local s in
  let ns = List.map (fun (n, _) -> Convert.I64_.extend_i32_u n) nts in
  require (I64.lt_u (List.fold_left I64.add 0L ns) 0x1_0000_0000L)
    s pos "too many locals";
  List.flatten (List.map (Lib.Fun.uncurry Lib.List32.make) nts)


let rec instr s =
  let pos = pos s in
  match op s with
  | 0x00 -> unreachable
  | 0x01 -> nop

  | 0x02 ->
    let bt = blocktype s in
    let es' = instr_block s in
    end_ s;
    block bt es'
  | 0x03 ->
    let bt = blocktype s in
    let es' = instr_block s in
    end_ s;
    loop bt es'
  | 0x04 ->
    let bt = blocktype s in
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
  | 0x06 | 0x07 as b -> illegal s pos b
  | 0x08 -> throw (at idx s)
  | 0x09 as b -> illegal s pos b
  | 0x0a -> throw_ref
  | 0x0b -> error s pos "misplaced END opcode"

  | 0x0c -> br (at idx s)
  | 0x0d -> br_if (at idx s)
  | 0x0e ->
    let xs = vec (at idx) s in
    let x = at idx s in
    br_table xs x
  | 0x0f -> return

  | 0x10 -> call (at idx s)
  | 0x11 ->
    let y = at idx s in
    let x = at idx s in
    call_indirect x y
  | 0x12 -> return_call (at idx s)
  | 0x13 ->
    let y = at idx s in
    let x = at idx s in
    return_call_indirect x y

  | 0x14 -> call_ref (at idx s)
  | 0x15 -> return_call_ref (at idx s)

  | 0x16 | 0x17 | 0x18 | 0x19 as b -> illegal s pos b

  | 0x1a -> drop
  | 0x1b -> select None
  | 0x1c -> select (Some (vec valtype s))

  | 0x1d | 0x1e as b -> illegal s pos b

  | 0x1f ->
    let bt = blocktype s in
    let cs = vec (at catch) s in
    let es = instr_block s in
    end_ s;
    try_table bt cs es

  | 0x20 -> local_get (at idx s)
  | 0x21 -> local_set (at idx s)
  | 0x22 -> local_tee (at idx s)
  | 0x23 -> global_get (at idx s)
  | 0x24 -> global_set (at idx s)
  | 0x25 -> table_get (at idx s)
  | 0x26 -> table_set (at idx s)

  | 0x27 as b -> illegal s pos b

  | 0x28 -> let x, a, o = memop s in i32_load x a o
  | 0x29 -> let x, a, o = memop s in i64_load x a o
  | 0x2a -> let x, a, o = memop s in f32_load x a o
  | 0x2b -> let x, a, o = memop s in f64_load x a o
  | 0x2c -> let x, a, o = memop s in i32_load8_s x a o
  | 0x2d -> let x, a, o = memop s in i32_load8_u x a o
  | 0x2e -> let x, a, o = memop s in i32_load16_s x a o
  | 0x2f -> let x, a, o = memop s in i32_load16_u x a o
  | 0x30 -> let x, a, o = memop s in i64_load8_s x a o
  | 0x31 -> let x, a, o = memop s in i64_load8_u x a o
  | 0x32 -> let x, a, o = memop s in i64_load16_s x a o
  | 0x33 -> let x, a, o = memop s in i64_load16_u x a o
  | 0x34 -> let x, a, o = memop s in i64_load32_s x a o
  | 0x35 -> let x, a, o = memop s in i64_load32_u x a o

  | 0x36 -> let x, a, o = memop s in i32_store x a o
  | 0x37 -> let x, a, o = memop s in i64_store x a o
  | 0x38 -> let x, a, o = memop s in f32_store x a o
  | 0x39 -> let x, a, o = memop s in f64_store x a o
  | 0x3a -> let x, a, o = memop s in i32_store8 x a o
  | 0x3b -> let x, a, o = memop s in i32_store16 x a o
  | 0x3c -> let x, a, o = memop s in i64_store8 x a o
  | 0x3d -> let x, a, o = memop s in i64_store16 x a o
  | 0x3e -> let x, a, o = memop s in i64_store32 x a o

  | 0x3f -> memory_size (at idx s)
  | 0x40 -> memory_grow (at idx s)

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

  | 0xd0 -> ref_null (heaptype s)
  | 0xd1 -> ref_is_null
  | 0xd2 -> ref_func (at idx s)
  | 0xd3 -> ref_eq
  | 0xd4 -> ref_as_non_null
  | 0xd5 -> br_on_null (at idx s)
  | 0xd6 -> br_on_non_null (at idx s)

  | 0xfb as b ->
    (match u32 s with
    | 0x00l -> struct_new (at idx s)
    | 0x01l -> struct_new_default (at idx s)
    | 0x02l -> let x = at idx s in let y = at idx s in struct_get x y
    | 0x03l -> let x = at idx s in let y = at idx s in struct_get_s x y
    | 0x04l -> let x = at idx s in let y = at idx s in struct_get_u x y
    | 0x05l -> let x = at idx s in let y = at idx s in struct_set x y

    | 0x06l -> array_new (at idx s)
    | 0x07l -> array_new_default (at idx s)
    | 0x08l -> let x = at idx s in let n = u32 s in array_new_fixed x n
    | 0x09l -> let x = at idx s in let y = at idx s in array_new_data x y
    | 0x0al -> let x = at idx s in let y = at idx s in array_new_elem x y
    | 0x0bl -> array_get (at idx s)
    | 0x0cl -> array_get_s (at idx s)
    | 0x0dl -> array_get_u (at idx s)
    | 0x0el -> array_set (at idx s)
    | 0x0fl -> array_len
    | 0x10l -> array_fill (at idx s)
    | 0x11l -> let x = at idx s in let y = at idx s in array_copy x y
    | 0x12l -> let x = at idx s in let y = at idx s in array_init_data x y
    | 0x13l -> let x = at idx s in let y = at idx s in array_init_elem x y

    | 0x14l -> ref_test (NoNull, heaptype s)
    | 0x15l -> ref_test (Null, heaptype s)
    | 0x16l -> ref_cast (NoNull, heaptype s)
    | 0x17l -> ref_cast (Null, heaptype s)
    | 0x18l | 0x19l as opcode ->
      let flags = byte s in
      require (flags land 0xfc = 0) s (pos + 2) "malformed br_on_cast flags";
      let x = at idx s in
      let rt1 = ((if bit 0 flags then Null else NoNull), heaptype s) in
      let rt2 = ((if bit 1 flags then Null else NoNull), heaptype s) in
      (if opcode = 0x18l then br_on_cast else br_on_cast_fail) x rt1 rt2

    | 0x1al -> any_convert_extern
    | 0x1bl -> extern_convert_any

    | 0x1cl -> ref_i31
    | 0x1dl -> i31_get_s
    | 0x1el -> i31_get_u

    | n -> illegal2 s pos b n
    )

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
      let y = at idx s in
      let x = at idx s in
      memory_init x y
    | 0x09l -> data_drop (at idx s)
    | 0x0al ->
      let x = at idx s in
      let y = at idx s in
      memory_copy x y
    | 0x0bl -> memory_fill (at idx s)

    | 0x0cl ->
      let y = at idx s in
      let x = at idx s in
      table_init x y
    | 0x0dl -> elem_drop (at idx s)
    | 0x0el ->
      let x = at idx s in
      let y = at idx s in
      table_copy x y
    | 0x0fl -> table_grow (at idx s)
    | 0x10l -> table_size (at idx s)
    | 0x11l -> table_fill (at idx s)

    | n -> illegal2 s pos b n
    )

  | 0xfd ->
    (match u32 s with
    | 0x00l -> let x, a, o = memop s in v128_load x a o
    | 0x01l -> let x, a, o = memop s in v128_load8x8_s x a o
    | 0x02l -> let x, a, o = memop s in v128_load8x8_u x a o
    | 0x03l -> let x, a, o = memop s in v128_load16x4_s x a o
    | 0x04l -> let x, a, o = memop s in v128_load16x4_u x a o
    | 0x05l -> let x, a, o = memop s in v128_load32x2_s x a o
    | 0x06l -> let x, a, o = memop s in v128_load32x2_u x a o
    | 0x07l -> let x, a, o = memop s in v128_load8_splat x a o
    | 0x08l -> let x, a, o = memop s in v128_load16_splat x a o
    | 0x09l -> let x, a, o = memop s in v128_load32_splat x a o
    | 0x0al -> let x, a, o = memop s in v128_load64_splat x a o
    | 0x0bl -> let x, a, o = memop s in v128_store x a o
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
      let x, a, o = memop s in
      let lane = byte s in
      v128_load8_lane x a o lane
    | 0x55l ->
      let x, a, o = memop s in
      let lane = byte s in
      v128_load16_lane x a o lane
    | 0x56l ->
      let x, a, o = memop s in
      let lane = byte s in
      v128_load32_lane x a o lane
    | 0x57l ->
      let x, a, o = memop s in
      let lane = byte s in
      v128_load64_lane x a o lane
    | 0x58l ->
      let x, a, o = memop s in
      let lane = byte s in
      v128_store8_lane x a o lane
    | 0x59l ->
      let x, a, o = memop s in
      let lane = byte s in
      v128_store16_lane x a o lane
    | 0x5al ->
      let x, a, o = memop s in
      let lane = byte s in
      v128_store32_lane x a o lane
    | 0x5bl ->
      let x, a, o = memop s in
      let lane = byte s in
      v128_store64_lane x a o lane
    | 0x5cl -> let x, a, o = memop s in v128_load32_zero x a o
    | 0x5dl -> let x, a, o = memop s in v128_load64_zero x a o
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
    | 0x9al as n -> illegal s pos (I32.to_int_u n)
    | 0x9bl -> i16x8_avgr_u
    | 0x9cl -> i16x8_extmul_low_i8x16_s
    | 0x9dl -> i16x8_extmul_high_i8x16_s
    | 0x9el -> i16x8_extmul_low_i8x16_u
    | 0x9fl -> i16x8_extmul_high_i8x16_u
    | 0xa0l -> i32x4_abs
    | 0xa1l -> i32x4_neg
    | 0xa2l as n -> illegal s pos (I32.to_int_u n)
    | 0xa3l -> i32x4_all_true
    | 0xa4l -> i32x4_bitmask
    | 0xa5l | 0xa6l as n -> illegal s pos (I32.to_int_u n)
    | 0xa7l -> i32x4_extend_low_i16x8_s
    | 0xa8l -> i32x4_extend_high_i16x8_s
    | 0xa9l -> i32x4_extend_low_i16x8_u
    | 0xaal -> i32x4_extend_high_i16x8_u
    | 0xabl -> i32x4_shl
    | 0xacl -> i32x4_shr_s
    | 0xadl -> i32x4_shr_u
    | 0xael -> i32x4_add
    | 0xafl | 0xb0l as n -> illegal s pos (I32.to_int_u n)
    | 0xb1l -> i32x4_sub
    | 0xb2l | 0xb3l | 0xb4l as n -> illegal s pos (I32.to_int_u n)
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
    | 0xc2l as n -> illegal s pos (I32.to_int_u n)
    | 0xc3l -> i64x2_all_true
    | 0xc4l -> i64x2_bitmask
    | 0xc5l | 0xc6l as n -> illegal s pos (I32.to_int_u n)
    | 0xc7l -> i64x2_extend_low_i32x4_s
    | 0xc8l -> i64x2_extend_high_i32x4_s
    | 0xc9l -> i64x2_extend_low_i32x4_u
    | 0xcal -> i64x2_extend_high_i32x4_u
    | 0xcbl -> i64x2_shl
    | 0xccl -> i64x2_shr_s
    | 0xcdl -> i64x2_shr_u
    | 0xcel -> i64x2_add
    | 0xcfl | 0xd0l as n -> illegal s pos (I32.to_int_u n)
    | 0xd1l -> i64x2_sub
    | 0xd2l | 0xd3l | 0xd4l as n -> illegal s pos (I32.to_int_u n)
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
    | 0xe2l as n -> illegal s pos (I32.to_int_u n)
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
    | 0x100l -> i8x16_relaxed_swizzle
    | 0x101l -> i32x4_relaxed_trunc_f32x4_s
    | 0x102l -> i32x4_relaxed_trunc_f32x4_u
    | 0x103l -> i32x4_relaxed_trunc_f64x2_s_zero
    | 0x104l -> i32x4_relaxed_trunc_f64x2_u_zero
    | 0x105l -> f32x4_relaxed_madd
    | 0x106l -> f32x4_relaxed_nmadd
    | 0x107l -> f64x2_relaxed_madd
    | 0x108l -> f64x2_relaxed_nmadd
    | 0x109l -> i8x16_relaxed_laneselect
    | 0x10al -> i16x8_relaxed_laneselect
    | 0x10bl -> i32x4_relaxed_laneselect
    | 0x10cl -> i64x2_relaxed_laneselect
    | 0x10dl -> f32x4_relaxed_min
    | 0x10el -> f32x4_relaxed_max
    | 0x10fl -> f64x2_relaxed_min
    | 0x110l -> f64x2_relaxed_max
    | 0x111l -> i16x8_relaxed_q15mulr_s
    | 0x112l -> i16x8_relaxed_dot_i8x16_i7x16_s
    | 0x113l -> i32x4_relaxed_dot_i8x16_i7x16_add_s
    | n -> illegal s pos (I32.to_int_u n)
    )

  | b -> illegal s pos b

and instr_block s = List.rev (instr_block' s [])
and instr_block' s es =
  match peek s with
  | None | Some (0x05 | 0x0b) -> es
  | _ ->
    let pos = pos s in
    let e' = instr s in
    instr_block' s ((e' @@ region s pos pos) :: es)

and catch s =
  match byte s with
  | 0x00 ->
    let x1 = at idx s in
    let x2 = at idx s in
    Mnemonics.catch x1 x2
  | 0x01 ->
    let x1 = at idx s in
    let x2 = at idx s in
    catch_ref x1 x2
  | 0x02 -> catch_all (at idx s)
  | 0x03 -> catch_all_ref (at idx s)
  | _ -> error s (pos s - 1) "malformed catch clause"

let const s =
  let c = at instr_block s in
  end_ s;
  c


(* Sections *)

let id s =
  let bo = peek s in
  Lib.Option.map
    (function
    | 0 -> Custom.Custom
    | 1 -> Custom.Type
    | 2 -> Custom.Import
    | 3 -> Custom.Func
    | 4 -> Custom.Table
    | 5 -> Custom.Memory
    | 6 -> Custom.Global
    | 7 -> Custom.Export
    | 8 -> Custom.Start
    | 9 -> Custom.Elem
    | 10 -> Custom.Code
    | 11 -> Custom.Data
    | 12 -> Custom.DataCount
    | 13 -> Custom.Tag
    | _ -> error s (pos s) "malformed section id"
    ) bo

let section_with_size kind f default s =
  match id s with
  | Some kind' when kind' = kind -> skip 1 s; sized f s
  | _ -> default

let section kind f default s =
  section_with_size kind (fun _ -> f) default s


(* Type section *)

let type_ s = at rectype s

let type_section s =
  section Custom.Type (vec type_) [] s


(* Import section *)

let import s =
  let module_name = name s in
  let item_name = name s in
  let xt = externtype s in
  Import (module_name, item_name, xt)

let import_section s =
  section Custom.Import (vec (at import)) [] s


(* Function section *)

let func_section s =
  section Custom.Func (vec (at idx)) [] s


(* Table section *)

let table s =
  either [
    (fun s ->
      expect 0x40 s "";
      zero s;
      let tt = tabletype s in
      let c = const s in
      Table (tt, c)
    );
    (fun s ->
      let at = region s (pos s) (pos s) in
      let TableT (_, _at, (_, ht)) as tt = tabletype s in
      let c = [RefNull ht @@ at] @@ at in
      Table (tt, c)
    );
  ] s

let table_section s =
  section Custom.Table (vec (at table)) [] s


(* Memory section *)

let memory s =
  let mt = memorytype s in
  Memory mt

let memory_section s =
  section Custom.Memory (vec (at memory)) [] s


(* Tag section *)

let tag s =
  let tt = tagtype s in
  Tag tt

let tag_section s =
  section Custom.Tag (vec (at tag)) [] s


(* Global section *)

let global s =
  let gt = globaltype s in
  let c = const s in
  Global (gt, c)

let global_section s =
  section Custom.Global (vec (at global)) [] s


(* Export section *)

let externidx s =
  match byte s with
  | 0x00 -> FuncX (at idx s)
  | 0x01 -> TableX (at idx s)
  | 0x02 -> MemoryX (at idx s)
  | 0x03 -> GlobalX (at idx s)
  | 0x04 -> TagX (at idx s)
  | _ -> error s (pos s - 1) "malformed export kind"

let export s =
  let name = name s in
  let xx = at externidx s in
  Export (name, xx)

let export_section s =
  section Custom.Export (vec (at export)) [] s


(* Start section *)

let start s =
  let x = at idx s in
  Start x

let start_section s =
  section Custom.Start (opt (at start) true) None s


(* Code section *)

let code _ s =
  let ls = locals s in
  let es = instr_block s in
  end_ s;
  Func (-1l @@ no_region, ls, es)

let code_section s =
  section Custom.Code (vec (at (sized code))) [] s


(* Element section *)

let passive s =
  Passive

let active s =
  let x = at idx s in
  let c = const s in
  Active (x, c)

let active_zero s =
  let x = 0l @@ no_region in
  let c = const s in
  Active (x, c)

let declarative s =
  Declarative

let elem_index s =
  let x = at idx s in
  [ref_func x @@ x.at]

let elem_kind s =
  match byte s with
  | 0x00 -> (NoNull, FuncHT)
  | _ -> error s (pos s - 1) "malformed element kind"

let elem s =
  match u32 s with
  | 0x00l ->
    let emode = at active_zero s in
    let rt = (NoNull, FuncHT) in
    let cs = vec (at elem_index) s in
    Elem (rt, cs, emode)
  | 0x01l ->
    let emode = at passive s in
    let rt = elem_kind s in
    let cs = vec (at elem_index) s in
    Elem (rt, cs, emode)
  | 0x02l ->
    let emode = at active s in
    let rt = elem_kind s in
    let cs = vec (at elem_index) s in
    Elem (rt, cs, emode)
  | 0x03l ->
    let emode = at declarative s in
    let rt = elem_kind s in
    let cs = vec (at elem_index) s in
    Elem (rt, cs, emode)
  | 0x04l ->
    let emode = at active_zero s in
    let rt = (Null, FuncHT) in
    let cs = vec const s in
    Elem (rt, cs, emode)
  | 0x05l ->
    let emode = at passive s in
    let rt = reftype s in
    let cs = vec const s in
    Elem (rt, cs, emode)
  | 0x06l ->
    let emode = at active s in
    let rt = reftype s in
    let cs = vec const s in
    Elem (rt, cs, emode)
  | 0x07l ->
    let emode = at declarative s in
    let rt = reftype s in
    let cs = vec const s in
    Elem (rt, cs, emode)
  | _ -> error s (pos s - 1) "malformed elements segment kind"

let elem_section s =
  section Custom.Elem (vec (at elem)) [] s


(* Data section *)

let data s =
  match u32 s with
  | 0x00l ->
    let dmode = at active_zero s in
    let bs = string s in
    Data (bs, dmode)
  | 0x01l ->
    let dmode = at passive s in
    let bs = string s in
    Data (bs, dmode)
  | 0x02l ->
    let dmode = at active s in
    let bs = string s in
    Data (bs, dmode)
  | _ -> error s (pos s - 1) "malformed data segment kind"

let data_section s =
  section Custom.Data (vec (at data)) [] s


(* DataCount section *)

let data_count s =
  Some (u32 s)

let data_count_section s =
  section Custom.DataCount data_count None s


(* Custom section *)

let custom place size s =
  let start = pos s in
  let name = name s in
  let content = get_string (size - (pos s - start)) s in
  Custom.{name; content; place}

let some_custom place size s =
  Some (at (custom place size) s)

let custom_section place s =
  section_with_size Custom.Custom (some_custom place) None s


(* Modules *)

let rec iterate f s =
  match f s with
  | None -> []
  | Some x -> x :: iterate f s

let magic = 0x6d736100l

let module_ s =
  let header = word32 s in
  require (header = magic) s 0 "magic header not detected";
  let version = word32 s in
  require (version = Encode.version) s 4 "unknown binary version";
  let customs = iterate (custom_section Custom.(Before Type)) s in
  let types = type_section s in
  let customs = customs @ iterate (custom_section Custom.(After Type)) s in
  let imports = import_section s in
  let customs = customs @ iterate (custom_section Custom.(After Import)) s in
  let func_types = func_section s in
  let customs = customs @ iterate (custom_section Custom.(After Func)) s in
  let tables = table_section s in
  let customs = customs @ iterate (custom_section Custom.(After Table)) s in
  let memories = memory_section s in
  let customs = customs @ iterate (custom_section Custom.(After Memory)) s in
  let tags = tag_section s in
  let customs = customs @ iterate (custom_section Custom.(After Tag)) s in
  let globals = global_section s in
  let customs = customs @ iterate (custom_section Custom.(After Global)) s in
  let exports = export_section s in
  let customs = customs @ iterate (custom_section Custom.(After Export)) s in
  let start = start_section s in
  let customs = customs @ iterate (custom_section Custom.(After Start)) s in
  let elems = elem_section s in
  let customs = customs @ iterate (custom_section Custom.(After Elem)) s in
  let data_count = data_count_section s in
  let customs = customs @ iterate (custom_section Custom.(After DataCount)) s in
  let func_bodies = code_section s in
  let customs = customs @ iterate (custom_section Custom.(After Code)) s in
  let datas = data_section s in
  let customs = customs @ iterate (custom_section Custom.(After Data)) s in
  require (pos s = len s) s (len s) "unexpected content after last section";
  require (List.length func_types = List.length func_bodies)
    s (len s) "function and code section have inconsistent lengths";
  require (data_count = None || data_count = Some (Lib.List32.length datas))
    s (len s) "data count and data section have inconsistent lengths";
  require (data_count <> None ||
    List.for_all Free.(fun f -> (func f).datas = Set.empty) func_bodies)
    s (len s) "data count section required";
  let funcs =
    List.map2 Source.(fun x f ->
      let Func (_, ls, es) = f.it in Func (x, ls, es) @@ f.at
    ) func_types func_bodies
  in
  { types; tables; memories; tags; globals; funcs;
    imports; exports; elems; datas; start },
  customs


let decode_custom m bs custom =
  let open Source in
  let Custom.{name; content; place} = custom.it in
  match Custom.handler name, Custom.handler (Utf8.decode "custom") with
  | Some (module Handler), _ ->
    let fmt = Handler.decode m bs custom in
    let module S = struct module Handler = Handler let it = fmt end in
    [(module S : Custom.Section)]
  | None, Some (module Handler') ->
    let fmt = Handler'.decode m bs custom in
    let module S = struct module Handler = Handler' let it = fmt end in
    [(module S : Custom.Section)]
  | None, None ->
    if !Flags.custom_reject then
      raise (Custom.Code (custom.at,
        "unknown custom section \"" ^ Utf8.encode name ^ "\""))
    else
      []

let decode_with_custom name bs =
  let m_cs = at module_ (stream name bs) in
  let open Source in
  let m', cs = m_cs.it in
  let m = m' @@ m_cs.at in
  m, List.flatten (List.map (decode_custom m bs) cs)

let decode name bs = fst (decode_with_custom name bs)
