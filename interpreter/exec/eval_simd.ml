open Types
open Values

exception TypeError of int * value * value_type

let of_arg f n v = try f v with Value t -> raise (TypeError (n, v, t))

module SimdOp (SXX : Simd.S) (Value : ValueType with type t = SXX.t) = struct
  open Ast.SimdOp

  let to_value = Value.to_value

  let of_value = of_arg Value.of_value

  let unop (op : unop) =
    fun v -> match op with
      | I8x16 Neg -> to_value (SXX.I8x16.neg (of_value 1 v))
      | I8x16 Abs -> to_value (SXX.I8x16.abs (of_value 1 v))
      | I8x16 Popcnt -> to_value (SXX.I8x16.popcnt (of_value 1 v))
      | I16x8 Neg -> to_value (SXX.I16x8.neg (of_value 1 v))
      | I16x8 Abs -> to_value (SXX.I16x8.abs (of_value 1 v))
      | I16x8 WidenLowS -> to_value (SXX.I16x8_convert.widen_low_s (of_value 1 v))
      | I16x8 WidenHighS -> to_value (SXX.I16x8_convert.widen_high_s (of_value 1 v))
      | I16x8 WidenLowU -> to_value (SXX.I16x8_convert.widen_low_u (of_value 1 v))
      | I16x8 WidenHighU -> to_value (SXX.I16x8_convert.widen_high_u (of_value 1 v))
      | I32x4 Abs -> to_value (SXX.I32x4.abs (of_value 1 v))
      | I32x4 Neg -> to_value (SXX.I32x4.neg (of_value 1 v))
      | I32x4 WidenLowS -> to_value (SXX.I32x4_convert.widen_low_s (of_value 1 v))
      | I32x4 WidenHighS -> to_value (SXX.I32x4_convert.widen_high_s (of_value 1 v))
      | I32x4 WidenLowU -> to_value (SXX.I32x4_convert.widen_low_u (of_value 1 v))
      | I32x4 WidenHighU -> to_value (SXX.I32x4_convert.widen_high_u (of_value 1 v))
      | I32x4 TruncSatF32x4S -> to_value (SXX.I32x4_convert.trunc_sat_f32x4_s (of_value 1 v))
      | I32x4 TruncSatF32x4U -> to_value (SXX.I32x4_convert.trunc_sat_f32x4_u (of_value 1 v))
      | I64x2 Abs -> to_value (SXX.I64x2.abs (of_value 1 v))
      | I64x2 Neg -> to_value (SXX.I64x2.neg (of_value 1 v))
      | I64x2 WidenLowS -> to_value (SXX.I64x2_convert.widen_low_s (of_value 1 v))
      | I64x2 WidenHighS -> to_value (SXX.I64x2_convert.widen_high_s (of_value 1 v))
      | I64x2 WidenLowU -> to_value (SXX.I64x2_convert.widen_low_u (of_value 1 v))
      | I64x2 WidenHighU -> to_value (SXX.I64x2_convert.widen_high_u (of_value 1 v))
      | F32x4 Abs -> to_value (SXX.F32x4.abs (of_value 1 v))
      | F32x4 Neg -> to_value (SXX.F32x4.neg (of_value 1 v))
      | F32x4 Sqrt -> to_value (SXX.F32x4.sqrt (of_value 1 v))
      | F32x4 Ceil -> to_value (SXX.F32x4.ceil (of_value 1 v))
      | F32x4 Floor -> to_value (SXX.F32x4.floor (of_value 1 v))
      | F32x4 Trunc -> to_value (SXX.F32x4.trunc (of_value 1 v))
      | F32x4 Nearest -> to_value (SXX.F32x4.nearest (of_value 1 v))
      | F32x4 ConvertI32x4S -> to_value (SXX.F32x4_convert.convert_i32x4_s (of_value 1 v))
      | F32x4 ConvertI32x4U -> to_value (SXX.F32x4_convert.convert_i32x4_u (of_value 1 v))
      | F64x2 Abs -> to_value (SXX.F64x2.abs (of_value 1 v))
      | F64x2 Neg -> to_value (SXX.F64x2.neg (of_value 1 v))
      | F64x2 Sqrt -> to_value (SXX.F64x2.sqrt (of_value 1 v))
      | F64x2 Ceil -> to_value (SXX.F64x2.ceil (of_value 1 v))
      | F64x2 Floor -> to_value (SXX.F64x2.floor (of_value 1 v))
      | F64x2 Trunc -> to_value (SXX.F64x2.trunc (of_value 1 v))
      | F64x2 Nearest -> to_value (SXX.F64x2.nearest (of_value 1 v))
      | V128 Not -> to_value (SXX.V128.lognot (of_value 1 v))
      | _ -> assert false

  let binop (op : binop) =
    let f = match op with
      | I8x16 Swizzle -> SXX.V8x16.swizzle
      | I8x16 (Shuffle imms) -> fun a b -> SXX.V8x16.shuffle a b imms
      | I8x16 Eq -> SXX.I8x16.eq
      | I8x16 Ne -> SXX.I8x16.ne
      | I8x16 LtS -> SXX.I8x16.lt_s
      | I8x16 LtU -> SXX.I8x16.lt_u
      | I8x16 LeS -> SXX.I8x16.le_s
      | I8x16 LeU -> SXX.I8x16.le_u
      | I8x16 GtS -> SXX.I8x16.gt_s
      | I8x16 GtU -> SXX.I8x16.gt_u
      | I8x16 GeS -> SXX.I8x16.ge_s
      | I8x16 GeU -> SXX.I8x16.ge_u
      | I8x16 NarrowS -> SXX.I8x16_convert.narrow_s
      | I8x16 NarrowU -> SXX.I8x16_convert.narrow_u
      | I8x16 Add -> SXX.I8x16.add
      | I8x16 AddSatS -> SXX.I8x16.add_sat_s
      | I8x16 AddSatU -> SXX.I8x16.add_sat_u
      | I8x16 Sub -> SXX.I8x16.sub
      | I8x16 SubSatS -> SXX.I8x16.sub_sat_s
      | I8x16 SubSatU -> SXX.I8x16.sub_sat_u
      | I8x16 MinS -> SXX.I8x16.min_s
      | I8x16 MinU -> SXX.I8x16.min_u
      | I8x16 MaxS -> SXX.I8x16.max_s
      | I8x16 MaxU -> SXX.I8x16.max_u
      | I8x16 AvgrU -> SXX.I8x16.avgr_u
      | I16x8 Eq -> SXX.I16x8.eq
      | I16x8 Ne -> SXX.I16x8.ne
      | I16x8 LtS -> SXX.I16x8.lt_s
      | I16x8 LtU -> SXX.I16x8.lt_u
      | I16x8 LeS -> SXX.I16x8.le_s
      | I16x8 LeU -> SXX.I16x8.le_u
      | I16x8 GtS -> SXX.I16x8.gt_s
      | I16x8 GtU -> SXX.I16x8.gt_u
      | I16x8 GeS -> SXX.I16x8.ge_s
      | I16x8 GeU -> SXX.I16x8.ge_u
      | I16x8 NarrowS -> SXX.I16x8_convert.narrow_s
      | I16x8 NarrowU -> SXX.I16x8_convert.narrow_u
      | I16x8 Add -> SXX.I16x8.add
      | I16x8 AddSatS -> SXX.I16x8.add_sat_s
      | I16x8 AddSatU -> SXX.I16x8.add_sat_u
      | I16x8 Sub -> SXX.I16x8.sub
      | I16x8 SubSatS -> SXX.I16x8.sub_sat_s
      | I16x8 SubSatU -> SXX.I16x8.sub_sat_u
      | I16x8 Mul -> SXX.I16x8.mul
      | I16x8 MinS -> SXX.I16x8.min_s
      | I16x8 MinU -> SXX.I16x8.min_u
      | I16x8 MaxS -> SXX.I16x8.max_s
      | I16x8 MaxU -> SXX.I16x8.max_u
      | I16x8 AvgrU -> SXX.I16x8.avgr_u
      | I16x8 ExtMulLowS -> SXX.I16x8_convert.extmul_low_s
      | I16x8 ExtMulHighS -> SXX.I16x8_convert.extmul_high_s
      | I16x8 ExtMulLowU -> SXX.I16x8_convert.extmul_low_u
      | I16x8 ExtMulHighU -> SXX.I16x8_convert.extmul_high_u
      | I32x4 Add -> SXX.I32x4.add
      | I32x4 Sub -> SXX.I32x4.sub
      | I32x4 MinS -> SXX.I32x4.min_s
      | I32x4 MinU -> SXX.I32x4.min_u
      | I32x4 MaxS -> SXX.I32x4.max_s
      | I32x4 MaxU -> SXX.I32x4.max_u
      | I32x4 Mul -> SXX.I32x4.mul
      | I32x4 Eq -> SXX.I32x4.eq
      | I32x4 Ne -> SXX.I32x4.ne
      | I32x4 LtS -> SXX.I32x4.lt_s
      | I32x4 LtU -> SXX.I32x4.lt_u
      | I32x4 LeS -> SXX.I32x4.le_s
      | I32x4 LeU -> SXX.I32x4.le_u
      | I32x4 GtS -> SXX.I32x4.gt_s
      | I32x4 GtU -> SXX.I32x4.gt_u
      | I32x4 GeS -> SXX.I32x4.ge_s
      | I32x4 GeU -> SXX.I32x4.ge_u
      | I32x4 DotI16x8S -> SXX.I32x4_convert.dot_i16x8_s
      | I64x2 Eq -> SXX.I64x2.eq
      | I64x2 Ne -> SXX.I64x2.ne
      | I64x2 LtS -> SXX.I64x2.lt_s
      | I64x2 LeS -> SXX.I64x2.le_s
      | I64x2 GtS -> SXX.I64x2.gt_s
      | I64x2 GeS -> SXX.I64x2.ge_s
      | I32x4 ExtMulLowS -> SXX.I32x4_convert.extmul_low_s
      | I32x4 ExtMulHighS -> SXX.I32x4_convert.extmul_high_s
      | I32x4 ExtMulLowU -> SXX.I32x4_convert.extmul_low_u
      | I32x4 ExtMulHighU -> SXX.I32x4_convert.extmul_high_u
      | I64x2 Add -> SXX.I64x2.add
      | I64x2 Sub -> SXX.I64x2.sub
      | I64x2 Mul -> SXX.I64x2.mul
      | I64x2 ExtMulLowS -> SXX.I64x2_convert.extmul_low_s
      | I64x2 ExtMulHighS -> SXX.I64x2_convert.extmul_high_s
      | I64x2 ExtMulLowU -> SXX.I64x2_convert.extmul_low_u
      | I64x2 ExtMulHighU -> SXX.I64x2_convert.extmul_high_u
      | F32x4 Eq -> SXX.F32x4.eq
      | F32x4 Ne -> SXX.F32x4.ne
      | F32x4 Lt -> SXX.F32x4.lt
      | F32x4 Le -> SXX.F32x4.le
      | F32x4 Gt -> SXX.F32x4.gt
      | F32x4 Ge -> SXX.F32x4.ge
      | F32x4 Add -> SXX.F32x4.add
      | F32x4 Sub -> SXX.F32x4.sub
      | F32x4 Mul -> SXX.F32x4.mul
      | F32x4 Div -> SXX.F32x4.div
      | F32x4 Min -> SXX.F32x4.min
      | F32x4 Max -> SXX.F32x4.max
      | F32x4 Pmin -> SXX.F32x4.pmin
      | F32x4 Pmax -> SXX.F32x4.pmax
      | F64x2 Eq -> SXX.F64x2.eq
      | F64x2 Ne -> SXX.F64x2.ne
      | F64x2 Lt -> SXX.F64x2.lt
      | F64x2 Le -> SXX.F64x2.le
      | F64x2 Gt -> SXX.F64x2.gt
      | F64x2 Ge -> SXX.F64x2.ge
      | F64x2 Add -> SXX.F64x2.add
      | F64x2 Sub -> SXX.F64x2.sub
      | F64x2 Mul -> SXX.F64x2.mul
      | F64x2 Div -> SXX.F64x2.div
      | F64x2 Min -> SXX.F64x2.min
      | F64x2 Max -> SXX.F64x2.max
      | F64x2 Pmin -> SXX.F64x2.pmin
      | F64x2 Pmax -> SXX.F64x2.pmax
      | V128 And -> SXX.V128.and_
      | V128 Or -> SXX.V128.or_
      | V128 Xor -> SXX.V128.xor
      | V128 AndNot -> SXX.V128.andnot
      | _ -> assert false
    in fun v1 v2 -> to_value (f (of_value 1 v1) (of_value 2 v2))

  let testop (op : testop) =
    let f = match op with
    | V128 AnyTrue -> SXX.I8x16.any_true
    | I8x16 AllTrue -> SXX.I8x16.all_true
    | I16x8 AllTrue -> SXX.I16x8.all_true
    | I32x4 AllTrue -> SXX.I32x4.all_true
    | _ -> assert false
    in fun v -> f (of_value 1 v)

  let relop op = assert false

  let extractop op v =
    let v128 = of_value 1 v in
    match op with
    | I8x16 (SX, imm) -> (I32 (SXX.I8x16.extract_lane_s imm v128))
    | I8x16 (ZX, imm) -> (I32 (SXX.I8x16.extract_lane_u imm v128))
    | I16x8 (SX, imm) -> (I32 (SXX.I16x8.extract_lane_s imm v128))
    | I16x8 (ZX, imm) -> (I32 (SXX.I16x8.extract_lane_u imm v128))
    | I32x4 (_, imm) -> (I32 (SXX.I32x4.extract_lane_s imm v128))
    | I64x2 (_, imm) -> (I64 (SXX.I64x2.extract_lane_s imm v128))
    | F32x4 (_, imm) -> (F32 (SXX.F32x4.extract_lane imm v128))
    | F64x2 (_, imm) -> (F64 (SXX.F64x2.extract_lane imm v128))
    | _ -> assert false

  let replaceop op v (r : Values.value) =
    let v128 = of_value 1 v in
    match op, r with
    | I8x16 imm, I32 r -> to_value (SXX.I8x16.replace_lane imm v128 r)
    | I16x8 imm, I32 r -> to_value (SXX.I16x8.replace_lane imm v128 r)
    | I32x4 imm, I32 r -> to_value (SXX.I32x4.replace_lane imm v128 r)
    | I64x2 imm, I64 r -> to_value (SXX.I64x2.replace_lane imm v128 r)
    | F32x4 imm, F32 r -> to_value (SXX.F32x4.replace_lane imm v128 r)
    | F64x2 imm, F64 r -> to_value (SXX.F64x2.replace_lane imm v128 r)
    | _ -> assert false

  let ternop op =
    let f = match op with
    | Bitselect -> SXX.V128.bitselect
    in fun v1 v2 v3 -> to_value (f (of_value 1 v1) (of_value 2 v2) (of_value 3 v3))

  let shiftop (op : shiftop) =
    let f = match op with
    | I8x16 Shl -> SXX.I8x16.shl
    | I8x16 ShrS -> SXX.I8x16.shr_s
    | I8x16 ShrU -> SXX.I8x16.shr_u
    | I16x8 Shl -> SXX.I16x8.shl
    | I16x8 ShrS -> SXX.I16x8.shr_s
    | I16x8 ShrU -> SXX.I16x8.shr_u
    | I32x4 Shl -> SXX.I32x4.shl
    | I32x4 ShrS -> SXX.I32x4.shr_s
    | I32x4 ShrU -> SXX.I32x4.shr_u
    | I64x2 Shl -> SXX.I64x2.shl
    | I64x2 ShrS -> SXX.I64x2.shr_s
    | I64x2 ShrU -> SXX.I64x2.shr_u
    | _ -> failwith "unimplemented shr_u"
    in fun v s -> to_value (f (of_value 1 v) (of_arg I32Value.of_value 2 s))

  let bitmaskop (op : Simd.shape) v =
    let f = match op with
    | Simd.I8x16 -> SXX.I8x16.bitmask
    | Simd.I16x8 -> SXX.I16x8.bitmask
    | Simd.I32x4 -> SXX.I32x4.bitmask
    | Simd.I64x2 -> SXX.I64x2.bitmask
    | _ -> assert false
    in I32 (f (of_value 1 v))

end

module V128Op = SimdOp (V128) (Values.V128Value)

module V128CvtOp =
struct
  open Ast.SimdOp

  let cvtop op v : value =
    match op with
    | I8x16 Splat -> V128 (V128.I8x16.splat (of_arg I32Value.of_value 1 v))
    | I16x8 Splat -> V128 (V128.I16x8.splat (of_arg I32Value.of_value 1 v))
    | I32x4 Splat -> V128 (V128.I32x4.splat (of_arg I32Value.of_value 1 v))
    | I64x2 Splat -> V128 (V128.I64x2.splat (of_arg I64Value.of_value 1 v))
    | F32x4 Splat -> V128 (V128.F32x4.splat (of_arg F32Value.of_value 1 v))
    | F64x2 Splat -> V128 (V128.F64x2.splat (of_arg F64Value.of_value 1 v))
    | _ -> assert false
end


let unop = V128Op.unop
let binop = V128Op.binop
let testop = V128Op.testop
let relop = V128Op.relop
let cvtop = V128CvtOp.cvtop

let eval_extractop extractop v = V128Op.extractop extractop v
let eval_replaceop replaceop v r = V128Op.replaceop replaceop v r
let eval_ternop = V128Op.ternop
let eval_shiftop = V128Op.shiftop
let eval_bitmaskop = V128Op.bitmaskop
