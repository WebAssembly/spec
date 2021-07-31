open Source
open Ast
open Script
open Values
open Types
open Sexpr


(* Generic formatting *)

let nat n = I32.to_string_u (I32.of_int_u n)
let nat32 = I32.to_string_u

let add_hex_char buf c = Printf.bprintf buf "\\%02x" (Char.code c)
let add_char buf = function
  | '\n' -> Buffer.add_string buf "\\n"
  | '\t' -> Buffer.add_string buf "\\t"
  | '\"' -> Buffer.add_string buf "\\\""
  | '\\' -> Buffer.add_string buf "\\\\"
  | c when '\x20' <= c && c < '\x7f' -> Buffer.add_char buf c
  | c -> add_hex_char buf c
let add_unicode_char buf = function
  | (0x09 | 0x0a) as uc -> add_char buf (Char.chr uc)
  | uc when 0x20 <= uc && uc < 0x7f -> add_char buf (Char.chr uc)
  | uc -> Printf.bprintf buf "\\u{%02x}" uc

let string_with iter add_char s =
  let buf = Buffer.create 256 in
  Buffer.add_char buf '\"';
  iter (add_char buf) s;
  Buffer.add_char buf '\"';
  Buffer.contents buf

let bytes = string_with String.iter add_hex_char
let string = string_with String.iter add_char
let name = string_with List.iter add_unicode_char

let list_of_opt = function None -> [] | Some x -> [x]

let list f xs = List.map f xs
let listi f xs = List.mapi f xs
let opt f xo = list f (list_of_opt xo)

let tab head f xs = if xs = [] then [] else [Node (head, list f xs)]
let atom f x = Atom (f x)

let break_bytes s =
  let ss = Lib.String.breakup s 16 in
  list (atom bytes) ss

let break_string s =
  let ss, s' = Lib.List.split_last (Lib.String.split s '\n') in
  list (atom string) (List.map (fun s -> s ^ "\n") ss @ [s'])


(* Types *)

let num_type t = string_of_num_type t
let simd_type t = string_of_simd_type t
let ref_type t = string_of_ref_type t
let refed_type t = string_of_refed_type t
let value_type t = string_of_value_type t

let decls kind ts = tab kind (atom value_type) ts

let func_type (FuncType (ins, out)) =
  Node ("func", decls "param" ins @ decls "result" out)

let struct_type = func_type

let limits nat {min; max} =
  String.concat " " (nat min :: opt nat max)

let global_type = function
  | GlobalType (t, Immutable) -> atom string_of_value_type t
  | GlobalType (t, Mutable) -> Node ("mut", [atom string_of_value_type t])

let pack_size = function
  | Pack8 -> "8"
  | Pack16 -> "16"
  | Pack32 -> "32"
  | Pack64 -> "64"

let extension = function
  | SX -> "_s"
  | ZX -> "_u"

let pack_shape = function
  | Pack8x8 -> "8x8"
  | Pack16x4 -> "16x4"
  | Pack32x2 -> "32x2"

let simd_extension sz = function
  | ExtShape (sh, ext) -> pack_shape sh ^ extension ext
  | ExtSplat -> pack_size sz ^ "_splat"
  | ExtZero -> pack_size sz ^ "_zero"


(* Operators *)

module IntOp =
struct
  open Ast.IntOp

  let testop xx = function
    | Eqz -> "eqz"

  let relop xx = function
    | Eq -> "eq"
    | Ne -> "ne"
    | LtS -> "lt_s"
    | LtU -> "lt_u"
    | GtS -> "gt_s"
    | GtU -> "gt_u"
    | LeS -> "le_s"
    | LeU -> "le_u"
    | GeS -> "ge_s"
    | GeU -> "ge_u"

  let unop xx = function
    | Clz -> "clz"
    | Ctz -> "ctz"
    | Popcnt -> "popcnt"
    | ExtendS sz -> "extend" ^ pack_size sz ^ "_s"

  let binop xx = function
    | Add -> "add"
    | Sub -> "sub"
    | Mul -> "mul"
    | DivS -> "div_s"
    | DivU -> "div_u"
    | RemS -> "rem_s"
    | RemU -> "rem_u"
    | And -> "and"
    | Or -> "or"
    | Xor -> "xor"
    | Shl -> "shl"
    | ShrS -> "shr_s"
    | ShrU -> "shr_u"
    | Rotl -> "rotl"
    | Rotr -> "rotr"

  let cvtop xx = function
    | ExtendSI32 -> "extend_i32_s"
    | ExtendUI32 -> "extend_i32_u"
    | WrapI64 -> "wrap_i64"
    | TruncSF32 -> "trunc_f32_s"
    | TruncUF32 -> "trunc_f32_u"
    | TruncSF64 -> "trunc_f64_s"
    | TruncUF64 -> "trunc_f64_u"
    | TruncSatSF32 -> "trunc_sat_f32_s"
    | TruncSatUF32 -> "trunc_sat_f32_u"
    | TruncSatSF64 -> "trunc_sat_f64_s"
    | TruncSatUF64 -> "trunc_sat_f64_u"
    | ReinterpretFloat -> "reinterpret_f" ^ xx
end

module FloatOp =
struct
  open Ast.FloatOp

  let testop xx = fun _ -> assert false

  let relop xx = function
    | Eq -> "eq"
    | Ne -> "ne"
    | Lt -> "lt"
    | Gt -> "gt"
    | Le -> "le"
    | Ge -> "ge"

  let unop xx = function
    | Neg -> "neg"
    | Abs -> "abs"
    | Ceil -> "ceil"
    | Floor -> "floor"
    | Trunc -> "trunc"
    | Nearest -> "nearest"
    | Sqrt -> "sqrt"

  let binop xx = function
    | Add -> "add"
    | Sub -> "sub"
    | Mul -> "mul"
    | Div -> "div"
    | Min -> "min"
    | Max -> "max"
    | CopySign -> "copysign"

  let cvtop xx = function
    | ConvertSI32 -> "convert_i32_s"
    | ConvertUI32 -> "convert_i32_u"
    | ConvertSI64 -> "convert_i64_s"
    | ConvertUI64 -> "convert_i64_u"
    | PromoteF32 -> "promote_f32"
    | DemoteF64 -> "demote_f64"
    | ReinterpretInt -> "reinterpret_i" ^ xx
end

module V128Op =
struct
  open Ast.V128Op

  let testop (op : testop) = match op with
    | I8x16 AllTrue -> "i8x16.all_true"
    | I16x8 AllTrue -> "i16x8.all_true"
    | I32x4 AllTrue -> "i32x4.all_true"
    | I64x2 AllTrue -> "i64x2.all_true"
    | V128x1 AnyTrue -> "v128.any_true"
    | _ -> .

  let unop (op : unop) = match op with
    | I8x16 Neg -> "i8x16.neg"
    | I8x16 Abs -> "i8x16.abs"
    | I8x16 Popcnt -> "i8x16.popcnt"
    | I16x8 Abs -> "i16x8.abs"
    | I16x8 Neg -> "i16x8.neg"
    | I16x8 ExtendLowS -> "i16x8.extend_low_i8x16_s"
    | I16x8 ExtendHighS -> "i16x8.extend_high_i8x16_s"
    | I16x8 ExtendLowU -> "i16x8.extend_low_i8x16_u"
    | I16x8 ExtendHighU -> "i16x8.extend_high_i8x16_u"
    | I16x8 ExtAddPairwiseS -> "i16x8.extadd_pairwise_i8x16_s"
    | I16x8 ExtAddPairwiseU -> "i16x8.extadd_pairwise_i8x16_u"
    | I32x4 Abs -> "i32x4.abs"
    | I32x4 Neg -> "i32x4.neg"
    | I32x4 ExtendLowS -> "i32x4.extend_low_i16x8_s"
    | I32x4 ExtendHighS -> "i32x4.extend_high_i16x8_s"
    | I32x4 ExtendLowU -> "i32x4.extend_low_i16x8_u"
    | I32x4 ExtendHighU -> "i32x4.extend_high_i16x8_u"
    | I32x4 TruncSatF32x4S -> "i32x4.trunc_sat_f32x4_s"
    | I32x4 TruncSatF32x4U -> "i32x4.trunc_sat_f32x4_u"
    | I32x4 TruncSatF64x2SZero -> "i32x4.trunc_sat_f64x2_s_zero"
    | I32x4 TruncSatF64x2UZero -> "i32x4.trunc_sat_f64x2_u_zero"
    | I32x4 ExtAddPairwiseS -> "i32x4.extadd_pairwise_i16x8_s"
    | I32x4 ExtAddPairwiseU -> "i32x4.extadd_pairwise_i16x8_u"
    | I64x2 Abs -> "i64x2.abs"
    | I64x2 Neg -> "i64x2.neg"
    | I64x2 ExtendLowS -> "i64x2.extend_low_i32x4_s"
    | I64x2 ExtendHighS -> "i64x2.extend_high_i32x4_s"
    | I64x2 ExtendLowU -> "i64x2.extend_low_i32x4_u"
    | I64x2 ExtendHighU -> "i64x2.extend_high_i32x4_u"
    | F32x4 Ceil -> "f32x4.ceil"
    | F32x4 Floor -> "f32x4.floor"
    | F32x4 Trunc -> "f32x4.trunc"
    | F32x4 Nearest -> "f32x4.nearest"
    | F32x4 DemoteF64x2Zero  -> "f32x4.demote_f64x2_zero"
    | F64x2 Ceil -> "f64x2.ceil"
    | F64x2 Floor -> "f64x2.floor"
    | F64x2 Trunc -> "f64x2.trunc"
    | F64x2 Nearest -> "f64x2.nearest"
    | F32x4 Abs -> "f32x4.abs"
    | F32x4 Neg -> "f32x4.neg"
    | F32x4 Sqrt -> "f32x4.sqrt"
    | F32x4 ConvertI32x4S -> "f32x4.convert_i32x4_s"
    | F32x4 ConvertI32x4U -> "f32x4.convert_i32x4_u"
    | F64x2 Abs -> "f64x2.abs"
    | F64x2 Neg -> "f64x2.neg"
    | F64x2 Sqrt -> "f64x2.sqrt"
    | F64x2 PromoteLowF32x4  -> "f64x2.promote_low_f32x4"
    | F64x2 ConvertI32x4S -> "f64x2.convert_low_i32x4_s"
    | F64x2 ConvertI32x4U -> "f64x2.convert_low_i32x4_u"
    | V128x1 Not -> "v128.not"
    | _ -> failwith "Unimplemented v128 unop"

  let binop (op : binop) = match op with
    | I8x16 (Shuffle is) -> "i8x16.shuffle " ^ (String.concat " " (List.map nat is))
    | I8x16 Swizzle -> "i8x16.swizzle"
    | I8x16 Eq -> "i8x16.eq"
    | I8x16 Ne -> "i8x16.ne"
    | I8x16 LtS -> "i8x16.lt_s"
    | I8x16 LtU -> "i8x16.lt_u"
    | I8x16 GtS -> "i8x16.gt_s"
    | I8x16 GtU -> "i8x16.gt_u"
    | I8x16 LeS -> "i8x16.le_s"
    | I8x16 LeU -> "i8x16.le_u"
    | I8x16 GeS -> "i8x16.ge_s"
    | I8x16 GeU -> "i8x16.ge_u"
    | I16x8 Eq -> "i16x8.eq"
    | I16x8 Ne -> "i16x8.ne"
    | I16x8 LtS -> "i16x8.lt_s"
    | I16x8 LtU -> "i16x8.lt_u"
    | I16x8 GtS -> "i16x8.gt_s"
    | I16x8 GtU -> "i16x8.gt_u"
    | I16x8 LeS -> "i16x8.le_s"
    | I16x8 LeU -> "i16x8.le_u"
    | I16x8 GeS -> "i16x8.ge_s"
    | I16x8 GeU -> "i16x8.ge_u"
    | I32x4 Eq -> "i32x4.eq"
    | I32x4 Ne -> "i32x4.ne"
    | I32x4 LtS -> "i32x4.lt_s"
    | I32x4 LtU -> "i32x4.lt_u"
    | I32x4 GtS -> "i32x4.gt_s"
    | I32x4 GtU -> "i32x4.gt_u"
    | I32x4 LeS -> "i32x4.le_s"
    | I32x4 LeU -> "i32x4.le_u"
    | I32x4 GeS -> "i32x4.ge_s"
    | I32x4 GeU -> "i32x4.ge_u"
    | I64x2 Eq -> "i64x2.eq"
    | I64x2 Ne -> "i64x2.ne"
    | I64x2 LtS -> "i64x2.lt_s"
    | I64x2 GtS -> "i64x2.gt_s"
    | I64x2 LeS -> "i64x2.le_s"
    | I64x2 GeS -> "i64x2.ge_s"
    | I8x16 NarrowS -> "i8x16.narrow_i16x8_s"
    | I8x16 NarrowU -> "i8x16.narrow_i16x8_u"
    | I8x16 Add -> "i8x16.add"
    | I8x16 AddSatS -> "i8x16.add_sat_s"
    | I8x16 AddSatU -> "i8x16.add_sat_u"
    | I8x16 Sub -> "i8x16.sub"
    | I8x16 SubSatS -> "i8x16.sub_sat_s"
    | I8x16 SubSatU -> "i8x16.sub_sat_u"
    | I8x16 MinS -> "i8x16.min_s"
    | I8x16 MinU -> "i8x16.min_u"
    | I8x16 MaxS -> "i8x16.max_s"
    | I8x16 MaxU -> "i8x16.max_u"
    | I8x16 AvgrU -> "i8x16.avgr_u"
    | I16x8 NarrowS -> "i16x8.narrow_i32x4_s"
    | I16x8 NarrowU -> "i16x8.narrow_i32x4_u"
    | I16x8 Add -> "i16x8.add"
    | I16x8 AddSatS -> "i16x8.add_sat_s"
    | I16x8 AddSatU -> "i16x8.add_sat_u"
    | I16x8 Sub -> "i16x8.sub"
    | I16x8 SubSatS -> "i16x8.sub_sat_s"
    | I16x8 SubSatU -> "i16x8.sub_sat_u"
    | I16x8 Mul -> "i16x8.mul"
    | I16x8 MinS -> "i16x8.min_s"
    | I16x8 MinU -> "i16x8.min_u"
    | I16x8 MaxS -> "i16x8.max_s"
    | I16x8 MaxU -> "i16x8.max_u"
    | I16x8 AvgrU -> "i16x8.avgr_u"
    | I16x8 ExtMulLowS -> "i16x8.extmul_low_i8x16_s"
    | I16x8 ExtMulHighS -> "i16x8.extmul_high_i8x16_s"
    | I16x8 ExtMulLowU -> "i16x8.extmul_low_i8x16_u"
    | I16x8 ExtMulHighU -> "i16x8.extmul_high_i8x16_u"
    | I16x8 Q15MulRSatS -> "i16x8.q15mulr_sat_s"
    | I32x4 Add -> "i32x4.add"
    | I32x4 Sub -> "i32x4.sub"
    | I32x4 Mul -> "i32x4.mul"
    | I32x4 MinS -> "i32x4.min_s"
    | I32x4 MinU -> "i32x4.min_u"
    | I32x4 MaxS -> "i32x4.max_s"
    | I32x4 MaxU -> "i32x4.max_u"
    | I32x4 DotI16x8S -> "i32x4.dot_i16x8_s"
    | I32x4 ExtMulLowS -> "i32x4.extmul_low_i16x8_s"
    | I32x4 ExtMulHighS -> "i32x4.extmul_high_i16x8_s"
    | I32x4 ExtMulLowU -> "i32x4.extmul_low_i16x8_u"
    | I32x4 ExtMulHighU -> "i32x4.extmul_high_i16x8_u"
    | I64x2 Add -> "i64x2.add"
    | I64x2 Sub -> "i64x2.sub"
    | I64x2 Mul -> "i64x2.mul"
    | I64x2 ExtMulLowS -> "i64x2.extmul_low_i32x4_s"
    | I64x2 ExtMulHighS -> "i64x2.extmul_high_i32x4_s"
    | I64x2 ExtMulLowU -> "i64x2.extmul_low_i32x4_u"
    | I64x2 ExtMulHighU -> "i64x2.extmul_high_i32x4_u"
    | F32x4 Eq -> "f32x4.eq"
    | F32x4 Ne -> "f32x4.ne"
    | F32x4 Lt -> "f32x4.lt"
    | F32x4 Le -> "f32x4.le"
    | F32x4 Gt -> "f32x4.gt"
    | F32x4 Ge -> "f32x4.ge"
    | F32x4 Add -> "f32x4.add"
    | F32x4 Sub -> "f32x4.sub"
    | F32x4 Mul -> "f32x4.mul"
    | F32x4 Div -> "f32x4.div"
    | F32x4 Min -> "f32x4.min"
    | F32x4 Max -> "f32x4.max"
    | F32x4 Pmin -> "f32x4.pmin"
    | F32x4 Pmax -> "f32x4.pmax"
    | F64x2 Eq -> "f64x2.eq"
    | F64x2 Ne -> "f64x2.ne"
    | F64x2 Lt -> "f64x2.lt"
    | F64x2 Gt -> "f64x2.gt"
    | F64x2 Le -> "f64x2.le"
    | F64x2 Ge -> "f64x2.ge"
    | F64x2 Add -> "f64x2.add"
    | F64x2 Sub -> "f64x2.sub"
    | F64x2 Mul -> "f64x2.mul"
    | F64x2 Div -> "f64x2.div"
    | F64x2 Min -> "f64x2.min"
    | F64x2 Max -> "f64x2.max"
    | F64x2 Pmin -> "f64x2.pmin"
    | F64x2 Pmax -> "f64x2.pmax"
    | V128x1 And -> "v128.and"
    | V128x1 AndNot -> "v128.andnot"
    | V128x1 Or -> "v128.or"
    | V128x1 Xor -> "v128.xor"
    | _ -> failwith "Unimplemented v128 binop"

  let ternop (op : ternop) = match op with
    | V128x1 Bitselect -> "v128.bitselect"
    | _ -> .

  let shiftop (op : shiftop) = match op with
    | I8x16 Shl -> "i8x16.shl"
    | I8x16 ShrS -> "i8x16.shr_s"
    | I8x16 ShrU -> "i8x16.shr_u"
    | I16x8 Shl -> "i16x8.shl"
    | I16x8 ShrS -> "i16x8.shr_s"
    | I16x8 ShrU -> "i16x8.shr_u"
    | I32x4 Shl -> "i32x4.shl"
    | I32x4 ShrS -> "i32x4.shr_s"
    | I32x4 ShrU -> "i32x4.shr_u"
    | I64x2 Shl -> "i64x2.shl"
    | I64x2 ShrS -> "i64x2.shr_s"
    | I64x2 ShrU -> "i64x2.shr_u"
    | _ -> .

  let bitmaskop (op : bitmaskop) = match op with
    | I8x16 Bitmask -> "i8x16.bitmask"
    | I16x8 Bitmask -> "i16x8.bitmask"
    | I32x4 Bitmask -> "i32x4.bitmask"
    | I64x2 Bitmask -> "i64x2.bitmask"
    | _ -> .

  let cvtop (op : cvtop) = match op with
    | I8x16 Splat -> "i8x16.splat"
    | I16x8 Splat -> "i16x8.splat"
    | I32x4 Splat -> "i32x4.splat"
    | I64x2 Splat -> "i64x2.splat"
    | F32x4 Splat -> "f32x4.splat"
    | F64x2 Splat -> "f64x2.splat"
    | _ -> .

  let extractop (op : extractop) = match op with
    | I8x16 (Extract (i, Some SX)) -> "i8x16.extract_lane_s " ^ nat i
    | I8x16 (Extract (i, Some ZX)) -> "i8x16.extract_lane_u " ^ nat i
    | I16x8 (Extract (i, Some SX)) -> "i16x8.extract_lane_s " ^ nat i
    | I16x8 (Extract (i, Some ZX)) -> "i16x8.extract_lane_u " ^ nat i
    | I32x4 (Extract (i, None)) -> "i32x4.extract_lane " ^ nat i
    | I64x2 (Extract (i, None)) -> "i64x2.extract_lane " ^ nat i
    | F32x4 (Extract (i, None)) -> "f32x4.extract_lane " ^ nat i
    | F64x2 (Extract (i, None)) -> "f64x2.extract_lane " ^ nat i
    | _ -> assert false

  let replaceop (op : replaceop) = match op with
    | I8x16 (Replace i) -> "i8x16.replace_lane " ^ nat i
    | I16x8 (Replace i) -> "i16x8.replace_lane " ^ nat i
    | I32x4 (Replace i) -> "i32x4.replace_lane " ^ nat i
    | I64x2 (Replace i) -> "i64x2.replace_lane " ^ nat i
    | F32x4 (Replace i) -> "f32x4.replace_lane " ^ nat i
    | F64x2 (Replace i) -> "f64x2.replace_lane " ^ nat i
    | _ -> .
end

let oper (intop, floatop) op =
  num_type (type_of_num op) ^ "." ^
  (match op with
  | I32 o -> intop "32" o
  | I64 o -> intop "64" o
  | F32 o -> floatop "32" o
  | F64 o -> floatop "64" o
  )

let unop = oper (IntOp.unop, FloatOp.unop)
let binop = oper (IntOp.binop, FloatOp.binop)
let testop = oper (IntOp.testop, FloatOp.testop)
let relop = oper (IntOp.relop, FloatOp.relop)
let cvtop = oper (IntOp.cvtop, FloatOp.cvtop)

let memop name typ {ty; align; offset; _} sz =
  typ ty ^ "." ^ name ^
  (if offset = 0l then "" else " offset=" ^ nat32 offset) ^
  (if 1 lsl align = sz then "" else " align=" ^ nat (1 lsl align))

let loadop op =
  match op.pack with
  | None -> memop "load" num_type op (num_size op.ty)
  | Some (sz, ext) ->
    memop ("load" ^ pack_size sz ^ extension ext) num_type op (packed_size sz)

let storeop op =
  match op.pack with
  | None -> memop "store" num_type op (num_size op.ty)
  | Some sz -> memop ("store" ^ pack_size sz) num_type op (packed_size sz)

let simd_loadop (op : simd_loadop) =
  match op.pack with
  | None -> memop "load" simd_type op (simd_size op.ty)
  | Some (sz, ext) ->
    memop ("load" ^ simd_extension sz ext) simd_type op (packed_size sz)

let simd_storeop op =
  memop "store" simd_type op (simd_size op.ty)

let simd_laneop instr (op, i) =
  memop (instr ^ pack_size op.pack ^ "_lane") simd_type op
    (packed_size op.pack) ^ " " ^ nat i


(* Expressions *)

let var x = nat32 x.it
let num v = string_of_num v.it
let simd v = string_of_simd v.it
let constop v = num_type (type_of_num v) ^ ".const"

let block_type = function
  | VarBlockType x -> [Node ("type " ^ var x, [])]
  | ValBlockType ts -> decls "result" (list_of_opt ts)

let rec instr e =
  let head, inner =
    match e.it with
    | Unreachable -> "unreachable", []
    | Nop -> "nop", []
    | Drop -> "drop", []
    | Select None -> "select", []
    | Select (Some []) -> "select", [Node ("result", [])]
    | Select (Some ts) -> "select", decls "result" ts
    | Block (bt, es) -> "block", block_type bt @ list instr es
    | Loop (bt, es) -> "loop", block_type bt @ list instr es
    | If (bt, es1, es2) ->
      "if", block_type bt @
        [Node ("then", list instr es1); Node ("else", list instr es2)]
    | Br x -> "br " ^ var x, []
    | BrIf x -> "br_if " ^ var x, []
    | BrTable (xs, x) ->
      "br_table " ^ String.concat " " (list var (xs @ [x])), []
    | Return -> "return", []
    | Call x -> "call " ^ var x, []
    | CallIndirect (x, y) ->
      "call_indirect " ^ var x, [Node ("type " ^ var y, [])]
    | LocalGet x -> "local.get " ^ var x, []
    | LocalSet x -> "local.set " ^ var x, []
    | LocalTee x -> "local.tee " ^ var x, []
    | GlobalGet x -> "global.get " ^ var x, []
    | GlobalSet x -> "global.set " ^ var x, []
    | TableGet x -> "table.get " ^ var x, []
    | TableSet x -> "table.set " ^ var x, []
    | TableSize x -> "table.size " ^ var x, []
    | TableGrow x -> "table.grow " ^ var x, []
    | TableFill x -> "table.fill " ^ var x, []
    | TableCopy (x, y) -> "table.copy " ^ var x ^ " " ^ var y, []
    | TableInit (x, y) -> "table.init " ^ var x ^ " " ^ var y, []
    | ElemDrop x -> "elem.drop " ^ var x, []
    | Load op -> loadop op, []
    | Store op -> storeop op, []
    | SimdLoad op -> simd_loadop op, []
    | SimdStore op -> simd_storeop op, []
    | SimdLoadLane op -> simd_laneop "load" op, []
    | SimdStoreLane op -> simd_laneop "store" op, []
    | MemorySize -> "memory.size", []
    | MemoryGrow -> "memory.grow", []
    | MemoryFill -> "memory.fill", []
    | MemoryCopy -> "memory.copy", []
    | MemoryInit x -> "memory.init " ^ var x, []
    | DataDrop x -> "data.drop " ^ var x, []
    | RefNull t -> "ref.null", [Atom (refed_type t)]
    | RefIsNull -> "ref.is_null", []
    | RefFunc x -> "ref.func " ^ var x, []
    | Const n -> constop n.it ^ " " ^ num n, []
    | Test op -> testop op, []
    | Compare op -> relop op, []
    | Unary op -> unop op, []
    | Binary op -> binop op, []
    | Convert op -> cvtop op, []
    | SimdConst n -> "v128.const i32x4 " ^ simd n, []
    | SimdTest (V128 op) -> V128Op.testop op, []
    | SimdUnary (V128 op) -> V128Op.unop op, []
    | SimdBinary (V128 op) -> V128Op.binop op, []
    | SimdTernary (V128 op) -> V128Op.ternop op, []
    | SimdShift (V128 op) -> V128Op.shiftop op, []
    | SimdBitmask (V128 op) -> V128Op.bitmaskop op, []
    | SimdConvert (V128 op) -> V128Op.cvtop op, []
    | SimdExtract (V128 op) -> V128Op.extractop op, []
    | SimdReplace (V128 op) -> V128Op.replaceop op, []
  in Node (head, inner)

let const head c =
  match c.it with
  | [e] -> instr e
  | es -> Node (head, list instr c.it)


(* Functions *)

let func_with_name name f =
  let {ftype; locals; body} = f.it in
  Node ("func" ^ name,
    [Node ("type " ^ var ftype, [])] @
    decls "local" locals @
    list instr body
  )

let func_with_index off i f =
  func_with_name (" $" ^ nat (off + i)) f

let func f =
  func_with_name "" f

let start x = Node ("start " ^ var x, [])


(* Tables & memories *)

let table off i tab =
  let {ttype = TableType (lim, t)} = tab.it in
  Node ("table $" ^ nat (off + i) ^ " " ^ limits nat32 lim,
    [atom ref_type t]
  )

let memory off i mem =
  let {mtype = MemoryType lim} = mem.it in
  Node ("memory $" ^ nat (off + i) ^ " " ^ limits nat32 lim, [])

let is_elem_kind = function
  | FuncRefType -> true
  | _ -> false

let elem_kind = function
  | FuncRefType -> "func"
  | _ -> assert false

let is_elem_index e =
  match e.it with
  | [{it = RefFunc _; _}] -> true
  | _ -> false

let elem_index e =
  match e.it with
  | [{it = RefFunc x; _}] -> atom var x
  | _ -> assert false

let segment_mode category mode =
  match mode.it with
  | Passive -> []
  | Active {index; offset} ->
    (if index.it = 0l then [] else [Node (category, [atom var index])]) @
    [const "offset" offset]
  | Declarative -> [Atom "declare"]

let elem i seg =
  let {etype; einit; emode} = seg.it in
  Node ("elem $" ^ nat i,
    segment_mode "table" emode @
    if is_elem_kind etype && List.for_all is_elem_index einit then
      atom elem_kind etype :: list elem_index einit
    else
      atom ref_type etype :: list (const "item") einit
  )

let data i seg =
  let {dinit; dmode} = seg.it in
  Node ("data $" ^ nat i, segment_mode "memory" dmode @ break_bytes dinit)


(* Modules *)

let typedef i ty =
  Node ("type $" ^ nat i, [struct_type ty.it])

let import_desc fx tx mx gx d =
  match d.it with
  | FuncImport x ->
    incr fx; Node ("func $" ^ nat (!fx - 1), [Node ("type", [atom var x])])
  | TableImport t ->
    incr tx; table 0 (!tx - 1) ({ttype = t} @@ d.at)
  | MemoryImport t ->
    incr mx; memory 0 (!mx - 1) ({mtype = t} @@ d.at)
  | GlobalImport t ->
    incr gx; Node ("global $" ^ nat (!gx - 1), [global_type t])

let import fx tx mx gx im =
  let {module_name; item_name; idesc} = im.it in
  Node ("import",
    [atom name module_name; atom name item_name; import_desc fx tx mx gx idesc]
  )

let export_desc d =
  match d.it with
  | FuncExport x -> Node ("func", [atom var x])
  | TableExport x -> Node ("table", [atom var x])
  | MemoryExport x -> Node ("memory", [atom var x])
  | GlobalExport x -> Node ("global", [atom var x])

let export ex =
  let {name = n; edesc} = ex.it in
  Node ("export", [atom name n; export_desc edesc])

let global off i g =
  let {gtype; ginit} = g.it in
  Node ("global $" ^ nat (off + i), global_type gtype :: list instr ginit.it)


(* Modules *)

let var_opt = function
  | None -> ""
  | Some x -> " " ^ x.it

let module_with_var_opt x_opt m =
  let fx = ref 0 in
  let tx = ref 0 in
  let mx = ref 0 in
  let gx = ref 0 in
  let imports = list (import fx tx mx gx) m.it.imports in
  Node ("module" ^ var_opt x_opt,
    listi typedef m.it.types @
    imports @
    listi (table !tx) m.it.tables @
    listi (memory !mx) m.it.memories @
    listi (global !gx) m.it.globals @
    listi (func_with_index !fx) m.it.funcs @
    list export m.it.exports @
    opt start m.it.start @
    listi elem m.it.elems @
    listi data m.it.datas
  )

let binary_module_with_var_opt x_opt bs =
  Node ("module" ^ var_opt x_opt ^ " binary", break_bytes bs)

let quoted_module_with_var_opt x_opt s =
  Node ("module" ^ var_opt x_opt ^ " quote", break_string s)

let module_ = module_with_var_opt None


(* Scripts *)

let num mode = if mode = `Binary then hex_string_of_num else string_of_num
let simd mode = if mode = `Binary then hex_string_of_simd else string_of_simd

let ref_ = function
  | NullRef t -> Node ("ref.null " ^ refed_type t, [])
  | ExternRef n -> Node ("ref.extern " ^ nat32 n, [])
  | _ -> assert false

let literal mode lit =
  match lit.it with
  | Num n -> Node (constop n ^ " " ^ num mode n, [])
  | Simd v -> Node ("v128.const i32x4 " ^ simd mode v, [])
  | Ref r -> ref_ r

let definition mode x_opt def =
  try
    match mode with
    | `Textual ->
      let rec unquote def =
        match def.it with
        | Textual m -> m
        | Encoded (_, bs) -> Decode.decode "" bs
        | Quoted (_, s) -> unquote (Parse.string_to_module s)
      in module_with_var_opt x_opt (unquote def)
    | `Binary ->
      let rec unquote def =
        match def.it with
        | Textual m -> Encode.encode m
        | Encoded (_, bs) -> Encode.encode (Decode.decode "" bs)
        | Quoted (_, s) -> unquote (Parse.string_to_module s)
      in binary_module_with_var_opt x_opt (unquote def)
    | `Original ->
      match def.it with
      | Textual m -> module_with_var_opt x_opt m
      | Encoded (_, bs) -> binary_module_with_var_opt x_opt bs
      | Quoted (_, s) -> quoted_module_with_var_opt x_opt s
  with Parse.Syntax _ ->
    quoted_module_with_var_opt x_opt "<invalid module>"

let access x_opt n =
  String.concat " " [var_opt x_opt; name n]

let action mode act =
  match act.it with
  | Invoke (x_opt, name, lits) ->
    Node ("invoke" ^ access x_opt name, List.map (literal mode) lits)
  | Get (x_opt, name) ->
    Node ("get" ^ access x_opt name, [])

let nan = function
  | CanonicalNan -> "nan:canonical"
  | ArithmeticNan -> "nan:arithmetic"

let nanop (n : nanop) =
  match n.it with
  | F32 n' | F64 n' -> nan n'
  | _ -> .

let num_pat mode = function
  | NumPat n -> literal mode (Values.Num n.it @@ n.at)
  | NanPat nan -> Node (constop nan.it ^ " " ^ nanop nan, [])

let lane_pat mode pat shape =
  let choose fb ft = if mode = `Binary then fb else ft in
  match pat, shape with
  | NumPat {it = Values.I32 i; _}, Simd.I8x16 ->
    choose I8.to_hex_string I8.to_string_s i
  | NumPat {it = Values.I32 i; _}, Simd.I16x8 ->
    choose I16.to_hex_string I16.to_string_s i
  | NumPat n, _ -> num mode n.it
  | NanPat nan, _ -> nanop nan

let simd_pat mode = function
  | SimdPat (shape, pats) ->
    let lanes = List.map (fun p -> Atom (lane_pat mode p shape)) pats in
    Node ("v128.const " ^ Simd.string_of_shape shape, lanes)

let ref_pat = function
  | RefPat r -> ref_ r.it
  | RefTypePat t -> Node ("ref." ^ refed_type t, [])

let result mode res =
  match res.it with
  | NumResult np -> num_pat mode np
  | SimdResult vp -> simd_pat mode vp
  | RefResult rp -> ref_pat rp

let assertion mode ass =
  match ass.it with
  | AssertMalformed (def, re) ->
    (match mode, def.it with
    | `Binary, Quoted _ -> []
    | _ ->
      [Node ("assert_malformed", [definition `Original None def; Atom (string re)])]
    )
  | AssertInvalid (def, re) ->
    [Node ("assert_invalid", [definition mode None def; Atom (string re)])]
  | AssertUnlinkable (def, re) ->
    [Node ("assert_unlinkable", [definition mode None def; Atom (string re)])]
  | AssertUninstantiable (def, re) ->
    [Node ("assert_trap", [definition mode None def; Atom (string re)])]
  | AssertReturn (act, results) ->
    [Node ("assert_return", action mode act :: List.map (result mode) results)]
  | AssertTrap (act, re) ->
    [Node ("assert_trap", [action mode act; Atom (string re)])]
  | AssertExhaustion (act, re) ->
    [Node ("assert_exhaustion", [action mode act; Atom (string re)])]

let command mode cmd =
  match cmd.it with
  | Module (x_opt, def) -> [definition mode x_opt def]
  | Register (n, x_opt) -> [Node ("register " ^ name n ^ var_opt x_opt, [])]
  | Action act -> [action mode act]
  | Assertion ass -> assertion mode ass
  | Meta _ -> assert false

let script mode scr = Lib.List.concat_map (command mode) scr
