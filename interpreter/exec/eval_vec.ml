open Types
open Values

module V128Op =
struct
  open Ast.V128Op
  open V128Vec
  open V128

  let testop (op : testop) =
    let f = match op with
      | I8x16 AllTrue -> V128.I8x16.all_true
      | I16x8 AllTrue -> V128.I16x8.all_true
      | I32x4 AllTrue -> V128.I32x4.all_true
      | I64x2 AllTrue -> V128.I64x2.all_true
      | _ -> .
    in fun v -> f (of_vec 1 v)

  let unop (op : unop) =
    let f = match op with
      | I8x16 Neg -> V128.I8x16.neg
      | I8x16 Abs -> V128.I8x16.abs
      | I8x16 Popcnt -> V128.I8x16.popcnt
      | I16x8 Neg -> V128.I16x8.neg
      | I16x8 Abs -> V128.I16x8.abs
      | I32x4 Abs -> V128.I32x4.abs
      | I32x4 Neg -> V128.I32x4.neg
      | I64x2 Abs -> V128.I64x2.abs
      | I64x2 Neg -> V128.I64x2.neg
      | F32x4 Abs -> V128.F32x4.abs
      | F32x4 Neg -> V128.F32x4.neg
      | F32x4 Sqrt -> V128.F32x4.sqrt
      | F32x4 Ceil -> V128.F32x4.ceil
      | F32x4 Floor -> V128.F32x4.floor
      | F32x4 Trunc -> V128.F32x4.trunc
      | F32x4 Nearest -> V128.F32x4.nearest
      | F64x2 Abs -> V128.F64x2.abs
      | F64x2 Neg -> V128.F64x2.neg
      | F64x2 Sqrt -> V128.F64x2.sqrt
      | F64x2 Ceil -> V128.F64x2.ceil
      | F64x2 Floor -> V128.F64x2.floor
      | F64x2 Trunc -> V128.F64x2.trunc
      | F64x2 Nearest -> V128.F64x2.nearest
      | _ -> assert false
    in fun v -> to_vec (f (of_vec 1 v))

  let binop (op : binop) =
    let f = match op with
      | I8x16 Swizzle -> V128.V8x16.swizzle
      | I8x16 (Shuffle is) -> fun a b -> V128.V8x16.shuffle a b is
      | I8x16 NarrowS -> V128.I8x16_convert.narrow_s
      | I8x16 NarrowU -> V128.I8x16_convert.narrow_u
      | I8x16 Add -> V128.I8x16.add
      | I8x16 AddSatS -> V128.I8x16.add_sat_s
      | I8x16 AddSatU -> V128.I8x16.add_sat_u
      | I8x16 Sub -> V128.I8x16.sub
      | I8x16 SubSatS -> V128.I8x16.sub_sat_s
      | I8x16 SubSatU -> V128.I8x16.sub_sat_u
      | I8x16 MinS -> V128.I8x16.min_s
      | I8x16 MinU -> V128.I8x16.min_u
      | I8x16 MaxS -> V128.I8x16.max_s
      | I8x16 MaxU -> V128.I8x16.max_u
      | I8x16 AvgrU -> V128.I8x16.avgr_u
      | I8x16 RelaxedSwizzle -> V128.V8x16.swizzle
      | I16x8 NarrowS -> V128.I16x8_convert.narrow_s
      | I16x8 NarrowU -> V128.I16x8_convert.narrow_u
      | I16x8 Add -> V128.I16x8.add
      | I16x8 AddSatS -> V128.I16x8.add_sat_s
      | I16x8 AddSatU -> V128.I16x8.add_sat_u
      | I16x8 Sub -> V128.I16x8.sub
      | I16x8 SubSatS -> V128.I16x8.sub_sat_s
      | I16x8 SubSatU -> V128.I16x8.sub_sat_u
      | I16x8 Mul -> V128.I16x8.mul
      | I16x8 MinS -> V128.I16x8.min_s
      | I16x8 MinU -> V128.I16x8.min_u
      | I16x8 MaxS -> V128.I16x8.max_s
      | I16x8 MaxU -> V128.I16x8.max_u
      | I16x8 AvgrU -> V128.I16x8.avgr_u
      | I16x8 ExtMulLowS -> V128.I16x8_convert.extmul_low_s
      | I16x8 ExtMulHighS -> V128.I16x8_convert.extmul_high_s
      | I16x8 ExtMulLowU -> V128.I16x8_convert.extmul_low_u
      | I16x8 ExtMulHighU -> V128.I16x8_convert.extmul_high_u
      | I16x8 Q15MulRSatS -> V128.I16x8.q15mulr_sat_s
      | I16x8 RelaxedQ15MulRS -> V128.I16x8.q15mulr_sat_s
      | I16x8 RelaxedDot -> V128.I16x8_convert.dot_s
      | I32x4 Add -> V128.I32x4.add
      | I32x4 Sub -> V128.I32x4.sub
      | I32x4 MinS -> V128.I32x4.min_s
      | I32x4 MinU -> V128.I32x4.min_u
      | I32x4 MaxS -> V128.I32x4.max_s
      | I32x4 MaxU -> V128.I32x4.max_u
      | I32x4 Mul -> V128.I32x4.mul
      | I32x4 ExtMulLowS -> V128.I32x4_convert.extmul_low_s
      | I32x4 ExtMulHighS -> V128.I32x4_convert.extmul_high_s
      | I32x4 ExtMulLowU -> V128.I32x4_convert.extmul_low_u
      | I32x4 ExtMulHighU -> V128.I32x4_convert.extmul_high_u
      | I64x2 Add -> V128.I64x2.add
      | I64x2 Sub -> V128.I64x2.sub
      | I64x2 Mul -> V128.I64x2.mul
      | I32x4 DotS -> V128.I32x4_convert.dot_s
      | I64x2 ExtMulLowS -> V128.I64x2_convert.extmul_low_s
      | I64x2 ExtMulHighS -> V128.I64x2_convert.extmul_high_s
      | I64x2 ExtMulLowU -> V128.I64x2_convert.extmul_low_u
      | I64x2 ExtMulHighU -> V128.I64x2_convert.extmul_high_u
      | F32x4 Add -> V128.F32x4.add
      | F32x4 Sub -> V128.F32x4.sub
      | F32x4 Mul -> V128.F32x4.mul
      | F32x4 Div -> V128.F32x4.div
      | F32x4 Min -> V128.F32x4.min
      | F32x4 Max -> V128.F32x4.max
      | F32x4 Pmin -> V128.F32x4.pmin
      | F32x4 Pmax -> V128.F32x4.pmax
      | F32x4 RelaxedMin -> V128.F32x4.min
      | F32x4 RelaxedMax -> V128.F32x4.max
      | F64x2 Add -> V128.F64x2.add
      | F64x2 Sub -> V128.F64x2.sub
      | F64x2 Mul -> V128.F64x2.mul
      | F64x2 Div -> V128.F64x2.div
      | F64x2 Min -> V128.F64x2.min
      | F64x2 Max -> V128.F64x2.max
      | F64x2 Pmin -> V128.F64x2.pmin
      | F64x2 Pmax -> V128.F64x2.pmax
      | F64x2 RelaxedMin -> V128.F64x2.min
      | F64x2 RelaxedMax -> V128.F64x2.max
      | _ -> assert false
    in fun v1 v2 -> to_vec (f (of_vec 1 v1) (of_vec 2 v2))

  let ternop (op : ternop) =
    let f = match op with
      | F32x4 RelaxedMadd -> V128.F32x4.fma
      | F32x4 RelaxedNmadd -> V128.F32x4.fnma
      | F64x2 RelaxedMadd -> V128.F64x2.fma
      | F64x2 RelaxedNmadd -> V128.F64x2.fnma
      | I8x16 RelaxedLaneselect -> V128.V1x128.bitselect
      | I16x8 RelaxedLaneselect -> V128.V1x128.bitselect
      | I32x4 RelaxedLaneselect -> V128.V1x128.bitselect
      | I64x2 RelaxedLaneselect -> V128.V1x128.bitselect
      | I32x4 RelaxedDotAccum -> V128.I32x4_convert.dot_s_accum
      | _ -> assert false
    in fun v1 v2 v3 -> to_vec (f (of_vec 1 v1) (of_vec 2 v2) (of_vec 3 v3))

  let relop (op : relop) =
    let f = match op with
      | I8x16 Eq -> V128.I8x16.eq
      | I8x16 Ne -> V128.I8x16.ne
      | I8x16 LtS -> V128.I8x16.lt_s
      | I8x16 LtU -> V128.I8x16.lt_u
      | I8x16 LeS -> V128.I8x16.le_s
      | I8x16 LeU -> V128.I8x16.le_u
      | I8x16 GtS -> V128.I8x16.gt_s
      | I8x16 GtU -> V128.I8x16.gt_u
      | I8x16 GeS -> V128.I8x16.ge_s
      | I8x16 GeU -> V128.I8x16.ge_u
      | I16x8 Eq -> V128.I16x8.eq
      | I16x8 Ne -> V128.I16x8.ne
      | I16x8 LtS -> V128.I16x8.lt_s
      | I16x8 LtU -> V128.I16x8.lt_u
      | I16x8 LeS -> V128.I16x8.le_s
      | I16x8 LeU -> V128.I16x8.le_u
      | I16x8 GtS -> V128.I16x8.gt_s
      | I16x8 GtU -> V128.I16x8.gt_u
      | I16x8 GeS -> V128.I16x8.ge_s
      | I16x8 GeU -> V128.I16x8.ge_u
      | I32x4 Eq -> V128.I32x4.eq
      | I32x4 Ne -> V128.I32x4.ne
      | I32x4 LtS -> V128.I32x4.lt_s
      | I32x4 LtU -> V128.I32x4.lt_u
      | I32x4 LeS -> V128.I32x4.le_s
      | I32x4 LeU -> V128.I32x4.le_u
      | I32x4 GtS -> V128.I32x4.gt_s
      | I32x4 GtU -> V128.I32x4.gt_u
      | I32x4 GeS -> V128.I32x4.ge_s
      | I32x4 GeU -> V128.I32x4.ge_u
      | I64x2 Eq -> V128.I64x2.eq
      | I64x2 Ne -> V128.I64x2.ne
      | I64x2 LtS -> V128.I64x2.lt_s
      | I64x2 LeS -> V128.I64x2.le_s
      | I64x2 GtS -> V128.I64x2.gt_s
      | I64x2 GeS -> V128.I64x2.ge_s
      | F32x4 Eq -> V128.F32x4.eq
      | F32x4 Ne -> V128.F32x4.ne
      | F32x4 Lt -> V128.F32x4.lt
      | F32x4 Le -> V128.F32x4.le
      | F32x4 Gt -> V128.F32x4.gt
      | F32x4 Ge -> V128.F32x4.ge
      | F64x2 Eq -> V128.F64x2.eq
      | F64x2 Ne -> V128.F64x2.ne
      | F64x2 Lt -> V128.F64x2.lt
      | F64x2 Le -> V128.F64x2.le
      | F64x2 Gt -> V128.F64x2.gt
      | F64x2 Ge -> V128.F64x2.ge
      | _ -> assert false
    in fun v1 v2 -> to_vec (f (of_vec 1 v1) (of_vec 2 v2))

  let cvtop (op : cvtop) =
    let f = match op with
      | I16x8 ExtendLowS -> V128.I16x8_convert.extend_low_s
      | I16x8 ExtendHighS -> V128.I16x8_convert.extend_high_s
      | I16x8 ExtendLowU -> V128.I16x8_convert.extend_low_u
      | I16x8 ExtendHighU -> V128.I16x8_convert.extend_high_u
      | I16x8 ExtAddPairwiseS -> V128.I16x8_convert.extadd_pairwise_s
      | I16x8 ExtAddPairwiseU -> V128.I16x8_convert.extadd_pairwise_u
      | I32x4 ExtendLowS -> V128.I32x4_convert.extend_low_s
      | I32x4 ExtendHighS -> V128.I32x4_convert.extend_high_s
      | I32x4 ExtendLowU -> V128.I32x4_convert.extend_low_u
      | I32x4 ExtendHighU -> V128.I32x4_convert.extend_high_u
      | I32x4 TruncSatSF32x4 -> V128.I32x4_convert.trunc_sat_f32x4_s
      | I32x4 TruncSatUF32x4 -> V128.I32x4_convert.trunc_sat_f32x4_u
      | I32x4 TruncSatSZeroF64x2 -> V128.I32x4_convert.trunc_sat_f64x2_s_zero
      | I32x4 TruncSatUZeroF64x2 -> V128.I32x4_convert.trunc_sat_f64x2_u_zero
      | I32x4 RelaxedTruncSF32x4 -> V128.I32x4_convert.trunc_sat_f32x4_s
      | I32x4 RelaxedTruncUF32x4 -> V128.I32x4_convert.trunc_sat_f32x4_u
      | I32x4 RelaxedTruncSZeroF64x2 -> V128.I32x4_convert.trunc_sat_f64x2_s_zero
      | I32x4 RelaxedTruncUZeroF64x2 -> V128.I32x4_convert.trunc_sat_f64x2_u_zero
      | I32x4 ExtAddPairwiseS -> V128.I32x4_convert.extadd_pairwise_s
      | I32x4 ExtAddPairwiseU -> V128.I32x4_convert.extadd_pairwise_u
      | I64x2 ExtendLowS -> V128.I64x2_convert.extend_low_s
      | I64x2 ExtendHighS -> V128.I64x2_convert.extend_high_s
      | I64x2 ExtendLowU -> V128.I64x2_convert.extend_low_u
      | I64x2 ExtendHighU -> V128.I64x2_convert.extend_high_u
      | F32x4 ConvertSI32x4 -> V128.F32x4_convert.convert_i32x4_s
      | F32x4 ConvertUI32x4 -> V128.F32x4_convert.convert_i32x4_u
      | F32x4 DemoteZeroF64x2 -> V128.F32x4_convert.demote_f64x2_zero
      | F64x2 PromoteLowF32x4 -> V128.F64x2_convert.promote_low_f32x4
      | F64x2 ConvertSI32x4 -> V128.F64x2_convert.convert_i32x4_s
      | F64x2 ConvertUI32x4 -> V128.F64x2_convert.convert_i32x4_u
      | _ -> assert false
    in fun v -> to_vec (f (of_vec 1 v))

  let shiftop (op : shiftop) =
    let f = match op with
      | I8x16 Shl -> V128.I8x16.shl
      | I8x16 ShrS -> V128.I8x16.shr_s
      | I8x16 ShrU -> V128.I8x16.shr_u
      | I16x8 Shl -> V128.I16x8.shl
      | I16x8 ShrS -> V128.I16x8.shr_s
      | I16x8 ShrU -> V128.I16x8.shr_u
      | I32x4 Shl -> V128.I32x4.shl
      | I32x4 ShrS -> V128.I32x4.shr_s
      | I32x4 ShrU -> V128.I32x4.shr_u
      | I64x2 Shl -> V128.I64x2.shl
      | I64x2 ShrS -> V128.I64x2.shr_s
      | I64x2 ShrU -> V128.I64x2.shr_u
      | _ -> .
    in fun v n -> to_vec (f (of_vec 1 v) (I32Num.of_num 2 n))

  let bitmaskop (op : bitmaskop) v =
    let f = match op with
      | I8x16 Bitmask -> V128.I8x16.bitmask
      | I16x8 Bitmask -> V128.I16x8.bitmask
      | I32x4 Bitmask -> V128.I32x4.bitmask
      | I64x2 Bitmask -> V128.I64x2.bitmask
      | _ -> .
    in I32 (f (of_vec 1 v))

  let vtestop (op : vtestop) =
    let f = match op with
      | AnyTrue -> V128.I8x16.any_true
    in fun v -> f (of_vec 1 v)

  let vunop (op : vunop) =
    let f = match op with
      | Not -> V128.V1x128.lognot
    in fun v -> to_vec (f (of_vec 1 v))

  let vbinop (op : vbinop) =
    let f = match op with
      | And -> V128.V1x128.and_
      | Or -> V128.V1x128.or_
      | Xor -> V128.V1x128.xor
      | AndNot -> V128.V1x128.andnot
    in fun v1 v2 -> to_vec (f (of_vec 1 v1) (of_vec 2 v2))

  let vternop (op : vternop) =
    let f = match op with
      | Bitselect -> V128.V1x128.bitselect
    in fun v1 v2 v3 -> to_vec (f (of_vec 1 v1) (of_vec 2 v2) (of_vec 3 v3))
end

module V128CvtOp =
struct
  open Ast.V128Op
  open V128Vec
  open V128

  let splatop (op : splatop) v =
    let i =
      match op with
      | I8x16 Splat -> V128.I8x16.splat (I32Num.of_num 1 v)
      | I16x8 Splat -> V128.I16x8.splat (I32Num.of_num 1 v)
      | I32x4 Splat -> V128.I32x4.splat (I32Num.of_num 1 v)
      | I64x2 Splat -> V128.I64x2.splat (I64Num.of_num 1 v)
      | F32x4 Splat -> V128.F32x4.splat (F32Num.of_num 1 v)
      | F64x2 Splat -> V128.F64x2.splat (F64Num.of_num 1 v)
    in to_vec i

  let extractop (op : extractop) v =
    let v128 = of_vec 1 v in
    match op with
    | I8x16 (Extract (i, SX)) -> I32 (V128.I8x16.extract_lane_s i v128)
    | I8x16 (Extract (i, ZX)) -> I32 (V128.I8x16.extract_lane_u i v128)
    | I16x8 (Extract (i, SX)) -> I32 (V128.I16x8.extract_lane_s i v128)
    | I16x8 (Extract (i, ZX)) -> I32 (V128.I16x8.extract_lane_u i v128)
    | I32x4 (Extract (i, ())) -> I32 (V128.I32x4.extract_lane_u i v128)
    | I64x2 (Extract (i, ())) -> I64 (V128.I64x2.extract_lane_u i v128)
    | F32x4 (Extract (i, ())) -> F32 (V128.F32x4.extract_lane i v128)
    | F64x2 (Extract (i, ())) -> F64 (V128.F64x2.extract_lane i v128)

  let replaceop (op : replaceop) v (n : Values.num) =
    let v128 = of_vec 1 v in
    let v128' = match op with
      | I8x16 (Replace i) -> V128.I8x16.replace_lane i v128 (I32Num.of_num 1 n)
      | I16x8 (Replace i) -> V128.I16x8.replace_lane i v128 (I32Num.of_num 1 n)
      | I32x4 (Replace i) -> V128.I32x4.replace_lane i v128 (I32Num.of_num 1 n)
      | I64x2 (Replace i) -> V128.I64x2.replace_lane i v128 (I64Num.of_num 1 n)
      | F32x4 (Replace i) -> V128.F32x4.replace_lane i v128 (F32Num.of_num 1 n)
      | F64x2 (Replace i) -> V128.F64x2.replace_lane i v128 (F64Num.of_num 1 n)
    in to_vec v128'
end

(* Dispatch *)

let op v128 = function
  | V128 x -> v128 x

let eval_testop = op V128Op.testop
let eval_unop = op V128Op.unop
let eval_binop = op V128Op.binop
let eval_ternop = op V128Op.ternop
let eval_relop = op V128Op.relop
let eval_cvtop = op V128Op.cvtop
let eval_shiftop = op V128Op.shiftop
let eval_bitmaskop = op V128Op.bitmaskop
let eval_vtestop = op V128Op.vtestop
let eval_vunop = op V128Op.vunop
let eval_vbinop = op V128Op.vbinop
let eval_vternop = op V128Op.vternop
let eval_splatop = op V128CvtOp.splatop
let eval_extractop = op V128CvtOp.extractop
let eval_replaceop = op V128CvtOp.replaceop
