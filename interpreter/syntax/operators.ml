open Source
open Types
open Values
open Ast


let i32_const n = Const (I32 n.it @@ n.at)
let i64_const n = Const (I64 n.it @@ n.at)
let f32_const n = Const (F32 n.it @@ n.at)
let f64_const n = Const (F64 n.it @@ n.at)
let v128_const n = Const (V128 n.it @@ n.at)

let unreachable = Unreachable
let nop = Nop
let drop = Drop
let select = Select
let block bt es = Block (bt, es)
let loop bt es = Loop (bt, es)
let if_ bt es1 es2 = If (bt, es1, es2)
let br x = Br x
let br_if x = BrIf x
let br_table xs x = BrTable (xs, x)

let return = Return
let call x = Call x
let call_indirect x = CallIndirect x

let local_get x = LocalGet x
let local_set x = LocalSet x
let local_tee x = LocalTee x
let global_get x = GlobalGet x
let global_set x = GlobalSet x

let i32_load align offset = Load {ty = I32Type; align; offset; sz = None}
let i64_load align offset = Load {ty = I64Type; align; offset; sz = None}
let f32_load align offset = Load {ty = F32Type; align; offset; sz = None}
let f64_load align offset = Load {ty = F64Type; align; offset; sz = None}
let i32_load8_s align offset =
  Load {ty = I32Type; align; offset; sz = Some (Pack8, SX)}
let i32_load8_u align offset =
  Load {ty = I32Type; align; offset; sz = Some (Pack8, ZX)}
let i32_load16_s align offset =
  Load {ty = I32Type; align; offset; sz = Some (Pack16, SX)}
let i32_load16_u align offset =
  Load {ty = I32Type; align; offset; sz = Some (Pack16, ZX)}
let i64_load8_s align offset =
  Load {ty = I64Type; align; offset; sz = Some (Pack8, SX)}
let i64_load8_u align offset =
  Load {ty = I64Type; align; offset; sz = Some (Pack8, ZX)}
let i64_load16_s align offset =
  Load {ty = I64Type; align; offset; sz = Some (Pack16, SX)}
let i64_load16_u align offset =
  Load {ty = I64Type; align; offset; sz = Some (Pack16, ZX)}
let i64_load32_s align offset =
  Load {ty = I64Type; align; offset; sz = Some (Pack32, SX)}
let i64_load32_u align offset =
  Load {ty = I64Type; align; offset; sz = Some (Pack32, ZX)}

let i32_store align offset = Store {ty = I32Type; align; offset; sz = None}
let i64_store align offset = Store {ty = I64Type; align; offset; sz = None}
let f32_store align offset = Store {ty = F32Type; align; offset; sz = None}
let f64_store align offset = Store {ty = F64Type; align; offset; sz = None}
let i32_store8 align offset =
  Store {ty = I32Type; align; offset; sz = Some Pack8}
let i32_store16 align offset =
  Store {ty = I32Type; align; offset; sz = Some Pack16}
let i64_store8 align offset =
  Store {ty = I64Type; align; offset; sz = Some Pack8}
let i64_store16 align offset =
  Store {ty = I64Type; align; offset; sz = Some Pack16}
let i64_store32 align offset =
  Store {ty = I64Type; align; offset; sz = Some Pack32}

let i32_clz = Unary (I32 I32Op.Clz)
let i32_ctz = Unary (I32 I32Op.Ctz)
let i32_popcnt = Unary (I32 I32Op.Popcnt)
let i64_clz = Unary (I64 I64Op.Clz)
let i64_ctz = Unary (I64 I64Op.Ctz)
let i64_popcnt = Unary (I64 I64Op.Popcnt)
let f32_neg = Unary (F32 F32Op.Neg)
let f32_abs = Unary (F32 F32Op.Abs)
let f32_sqrt = Unary (F32 F32Op.Sqrt)
let f32_ceil = Unary (F32 F32Op.Ceil)
let f32_floor = Unary (F32 F32Op.Floor)
let f32_trunc = Unary (F32 F32Op.Trunc)
let f32_nearest = Unary (F32 F32Op.Nearest)
let f64_neg = Unary (F64 F64Op.Neg)
let f64_abs = Unary (F64 F64Op.Abs)
let f64_sqrt = Unary (F64 F64Op.Sqrt)
let f64_ceil = Unary (F64 F64Op.Ceil)
let f64_floor = Unary (F64 F64Op.Floor)
let f64_trunc = Unary (F64 F64Op.Trunc)
let f64_nearest = Unary (F64 F64Op.Nearest)

let i32_add = Binary (I32 I32Op.Add)
let i32_sub = Binary (I32 I32Op.Sub)
let i32_mul = Binary (I32 I32Op.Mul)
let i32_div_s = Binary (I32 I32Op.DivS)
let i32_div_u = Binary (I32 I32Op.DivU)
let i32_rem_s = Binary (I32 I32Op.RemS)
let i32_rem_u = Binary (I32 I32Op.RemU)
let i32_and = Binary (I32 I32Op.And)
let i32_or = Binary (I32 I32Op.Or)
let i32_xor = Binary (I32 I32Op.Xor)
let i32_shl = Binary (I32 I32Op.Shl)
let i32_shr_s = Binary (I32 I32Op.ShrS)
let i32_shr_u = Binary (I32 I32Op.ShrU)
let i32_rotl = Binary (I32 I32Op.Rotl)
let i32_rotr = Binary (I32 I32Op.Rotr)
let i64_add = Binary (I64 I64Op.Add)
let i64_sub = Binary (I64 I64Op.Sub)
let i64_mul = Binary (I64 I64Op.Mul)
let i64_div_s = Binary (I64 I64Op.DivS)
let i64_div_u = Binary (I64 I64Op.DivU)
let i64_rem_s = Binary (I64 I64Op.RemS)
let i64_rem_u = Binary (I64 I64Op.RemU)
let i64_and = Binary (I64 I64Op.And)
let i64_or = Binary (I64 I64Op.Or)
let i64_xor = Binary (I64 I64Op.Xor)
let i64_shl = Binary (I64 I64Op.Shl)
let i64_shr_s = Binary (I64 I64Op.ShrS)
let i64_shr_u = Binary (I64 I64Op.ShrU)
let i64_rotl = Binary (I64 I64Op.Rotl)
let i64_rotr = Binary (I64 I64Op.Rotr)
let f32_add = Binary (F32 F32Op.Add)
let f32_sub = Binary (F32 F32Op.Sub)
let f32_mul = Binary (F32 F32Op.Mul)
let f32_div = Binary (F32 F32Op.Div)
let f32_min = Binary (F32 F32Op.Min)
let f32_max = Binary (F32 F32Op.Max)
let f32_copysign = Binary (F32 F32Op.CopySign)
let f64_add = Binary (F64 F64Op.Add)
let f64_sub = Binary (F64 F64Op.Sub)
let f64_mul = Binary (F64 F64Op.Mul)
let f64_div = Binary (F64 F64Op.Div)
let f64_min = Binary (F64 F64Op.Min)
let f64_max = Binary (F64 F64Op.Max)
let f64_copysign = Binary (F64 F64Op.CopySign)

let i32_eqz = Test (I32 I32Op.Eqz)
let i64_eqz = Test (I64 I64Op.Eqz)

let i32_eq = Compare (I32 I32Op.Eq)
let i32_ne = Compare (I32 I32Op.Ne)
let i32_lt_s = Compare (I32 I32Op.LtS)
let i32_lt_u = Compare (I32 I32Op.LtU)
let i32_le_s = Compare (I32 I32Op.LeS)
let i32_le_u = Compare (I32 I32Op.LeU)
let i32_gt_s = Compare (I32 I32Op.GtS)
let i32_gt_u = Compare (I32 I32Op.GtU)
let i32_ge_s = Compare (I32 I32Op.GeS)
let i32_ge_u = Compare (I32 I32Op.GeU)
let i64_eq = Compare (I64 I64Op.Eq)
let i64_ne = Compare (I64 I64Op.Ne)
let i64_lt_s = Compare (I64 I64Op.LtS)
let i64_lt_u = Compare (I64 I64Op.LtU)
let i64_le_s = Compare (I64 I64Op.LeS)
let i64_le_u = Compare (I64 I64Op.LeU)
let i64_gt_s = Compare (I64 I64Op.GtS)
let i64_gt_u = Compare (I64 I64Op.GtU)
let i64_ge_s = Compare (I64 I64Op.GeS)
let i64_ge_u = Compare (I64 I64Op.GeU)
let f32_eq = Compare (F32 F32Op.Eq)
let f32_ne = Compare (F32 F32Op.Ne)
let f32_lt = Compare (F32 F32Op.Lt)
let f32_le = Compare (F32 F32Op.Le)
let f32_gt = Compare (F32 F32Op.Gt)
let f32_ge = Compare (F32 F32Op.Ge)
let f64_eq = Compare (F64 F64Op.Eq)
let f64_ne = Compare (F64 F64Op.Ne)
let f64_lt = Compare (F64 F64Op.Lt)
let f64_le = Compare (F64 F64Op.Le)
let f64_gt = Compare (F64 F64Op.Gt)
let f64_ge = Compare (F64 F64Op.Ge)

let i32_extend8_s = Unary (I32 (I32Op.ExtendS Pack8))
let i32_extend16_s = Unary (I32 (I32Op.ExtendS Pack16))
let i64_extend8_s = Unary (I64 (I64Op.ExtendS Pack8))
let i64_extend16_s = Unary (I64 (I64Op.ExtendS Pack16))
let i64_extend32_s = Unary (I64 (I64Op.ExtendS Pack32))

let i32_wrap_i64 = Convert (I32 I32Op.WrapI64)
let i32_trunc_f32_s = Convert (I32 I32Op.TruncSF32)
let i32_trunc_f32_u = Convert (I32 I32Op.TruncUF32)
let i32_trunc_f64_s = Convert (I32 I32Op.TruncSF64)
let i32_trunc_f64_u = Convert (I32 I32Op.TruncUF64)
let i32_trunc_sat_f32_s = Convert (I32 I32Op.TruncSatSF32)
let i32_trunc_sat_f32_u = Convert (I32 I32Op.TruncSatUF32)
let i32_trunc_sat_f64_s = Convert (I32 I32Op.TruncSatSF64)
let i32_trunc_sat_f64_u = Convert (I32 I32Op.TruncSatUF64)
let i64_extend_i32_s = Convert (I64 I64Op.ExtendSI32)
let i64_extend_i32_u = Convert (I64 I64Op.ExtendUI32)
let i64_trunc_f32_s = Convert (I64 I64Op.TruncSF32)
let i64_trunc_f32_u = Convert (I64 I64Op.TruncUF32)
let i64_trunc_f64_s = Convert (I64 I64Op.TruncSF64)
let i64_trunc_f64_u = Convert (I64 I64Op.TruncUF64)
let f32_convert_i32_s = Convert (F32 F32Op.ConvertSI32)
let f32_convert_i32_u = Convert (F32 F32Op.ConvertUI32)
let f32_convert_i64_s = Convert (F32 F32Op.ConvertSI64)
let f32_convert_i64_u = Convert (F32 F32Op.ConvertUI64)
let i64_trunc_sat_f32_s = Convert (I64 I64Op.TruncSatSF32)
let i64_trunc_sat_f32_u = Convert (I64 I64Op.TruncSatUF32)
let i64_trunc_sat_f64_s = Convert (I64 I64Op.TruncSatSF64)
let i64_trunc_sat_f64_u = Convert (I64 I64Op.TruncSatUF64)
let f32_demote_f64 = Convert (F32 F32Op.DemoteF64)
let f64_convert_i32_s = Convert (F64 F64Op.ConvertSI32)
let f64_convert_i32_u = Convert (F64 F64Op.ConvertUI32)
let f64_convert_i64_s = Convert (F64 F64Op.ConvertSI64)
let f64_convert_i64_u = Convert (F64 F64Op.ConvertUI64)
let f64_promote_f32 = Convert (F64 F64Op.PromoteF32)
let i32_reinterpret_f32 = Convert (I32 I32Op.ReinterpretFloat)
let i64_reinterpret_f64 = Convert (I64 I64Op.ReinterpretFloat)
let f32_reinterpret_i32 = Convert (F32 F32Op.ReinterpretInt)
let f64_reinterpret_i64 = Convert (F64 F64Op.ReinterpretInt)

let memory_size = MemorySize
let memory_grow = MemoryGrow

(* SIMD *)
let v128_load align offset = Load {ty = V128Type; align; offset; sz = None}
let v128_store align offset = Store {ty = V128Type; align; offset; sz = None}
let v128_not = Unary (V128 (V128Op.V128 V128Op.Not))
let v128_and = Binary (V128 (V128Op.V128 V128Op.And))
let v128_andnot = Binary (V128 (V128Op.V128 V128Op.AndNot))
let v128_or = Binary (V128 (V128Op.V128 V128Op.Or))
let v128_xor = Binary (V128 (V128Op.V128 V128Op.Xor))
let v128_bitselect = Ternary (V128Op.Bitselect)

let v8x16_swizzle = Binary (V128 V128Op.(I8x16 Swizzle))
let v8x16_shuffle imms = Binary (V128 V128Op.(I8x16 (Shuffle imms)))

let i8x16_splat = Convert (V128 (V128Op.I8x16 V128Op.Splat))
let i8x16_extract_lane_s imm = SimdExtract (V128Op.I8x16 (SX, imm))
let i8x16_extract_lane_u imm = SimdExtract (V128Op.I8x16 (ZX, imm))
let i8x16_replace_lane imm = SimdReplace (V128Op.I8x16 imm)
let i8x16_eq = Binary (V128 V128Op.(I8x16 Eq))
let i8x16_ne = Binary (V128 V128Op.(I8x16 Ne))
let i8x16_lt_s = Binary (V128 V128Op.(I8x16 LtS))
let i8x16_lt_u = Binary (V128 V128Op.(I8x16 LtU))
let i8x16_le_s = Binary (V128 V128Op.(I8x16 LeS))
let i8x16_le_u = Binary (V128 V128Op.(I8x16 LeU))
let i8x16_gt_s = Binary (V128 V128Op.(I8x16 GtS))
let i8x16_gt_u = Binary (V128 V128Op.(I8x16 GtU))
let i8x16_ge_s = Binary (V128 V128Op.(I8x16 GeS))
let i8x16_ge_u = Binary (V128 V128Op.(I8x16 GeU))
let i8x16_neg = Unary (V128 (V128Op.I8x16 V128Op.Neg))
let i8x16_any_true = Test (V128 (V128Op.I8x16 V128Op.AnyTrue))
let i8x16_bitmask = SimdBitmask V128Op.(I8x16 Bitmask)
let i8x16_all_true = Test (V128 (V128Op.I8x16 V128Op.AllTrue))
let i8x16_narrow_i16x8_s = Binary (V128 V128Op.(I8x16 NarrowS))
let i8x16_narrow_i16x8_u = Binary (V128 V128Op.(I8x16 NarrowU))
let i16x8_widen_low_i8x16_s = Unary (V128 V128Op.(I16x8 WidenLowS))
let i16x8_widen_high_i8x16_s = Unary (V128 V128Op.(I16x8 WidenHighS))
let i16x8_widen_low_i8x16_u = Unary (V128 V128Op.(I16x8 WidenLowU))
let i16x8_widen_high_i8x16_u = Unary (V128 V128Op.(I16x8 WidenHighU))
let i8x16_shl = SimdShift V128Op.(I8x16 Shl)
let i8x16_shr_s = SimdShift V128Op.(I8x16 ShrS)
let i8x16_shr_u = SimdShift V128Op.(I8x16 ShrU)
let i8x16_add = Binary (V128 (V128Op.I8x16 V128Op.Add))
let i8x16_add_saturate_s = Binary (V128 V128Op.(I8x16 AddSatS))
let i8x16_add_saturate_u = Binary (V128 V128Op.(I8x16 AddSatU))
let i8x16_sub = Binary (V128 (V128Op.I8x16 V128Op.Sub))
let i8x16_sub_saturate_s = Binary (V128 V128Op.(I8x16 SubSatS))
let i8x16_sub_saturate_u = Binary (V128 V128Op.(I8x16 SubSatU))
let i8x16_abs = Unary (V128 (V128Op.I8x16 V128Op.Abs))
let i8x16_min_s = Binary (V128 (V128Op.I8x16 V128Op.MinS))
let i8x16_min_u = Binary (V128 (V128Op.I8x16 V128Op.MinU))
let i8x16_max_s = Binary (V128 (V128Op.I8x16 V128Op.MaxS))
let i8x16_max_u = Binary (V128 (V128Op.I8x16 V128Op.MaxU))
let i8x16_avgr_u = Binary (V128 (V128Op.I8x16 V128Op.AvgrU))

let i16x8_splat = Convert (V128 (V128Op.I16x8 V128Op.Splat))
let i16x8_extract_lane_s imm = SimdExtract (V128Op.I16x8 (SX, imm))
let i16x8_extract_lane_u imm = SimdExtract (V128Op.I16x8 (ZX, imm))
let i16x8_replace_lane imm = SimdReplace (V128Op.I16x8 imm)
let i16x8_eq = Binary (V128 V128Op.(I16x8 Eq))
let i16x8_ne = Binary (V128 V128Op.(I16x8 Ne))
let i16x8_lt_s = Binary (V128 V128Op.(I16x8 LtS))
let i16x8_lt_u = Binary (V128 V128Op.(I16x8 LtU))
let i16x8_le_s = Binary (V128 V128Op.(I16x8 LeS))
let i16x8_le_u = Binary (V128 V128Op.(I16x8 LeU))
let i16x8_gt_s = Binary (V128 V128Op.(I16x8 GtS))
let i16x8_gt_u = Binary (V128 V128Op.(I16x8 GtU))
let i16x8_ge_s = Binary (V128 V128Op.(I16x8 GeS))
let i16x8_ge_u = Binary (V128 V128Op.(I16x8 GeU))
let i16x8_neg = Unary (V128 (V128Op.I16x8 V128Op.Neg))
let i16x8_any_true = Test (V128 (V128Op.I16x8 V128Op.AnyTrue))
let i16x8_bitmask = SimdBitmask V128Op.(I16x8 Bitmask)
let i16x8_all_true = Test (V128 (V128Op.I16x8 V128Op.AllTrue))
let i16x8_narrow_i32x4_s = Binary (V128 V128Op.(I16x8 NarrowS))
let i16x8_narrow_i32x4_u = Binary (V128 V128Op.(I16x8 NarrowU))
let i16x8_shl = SimdShift V128Op.(I16x8 Shl)
let i16x8_shr_s = SimdShift V128Op.(I16x8 ShrS)
let i16x8_shr_u = SimdShift V128Op.(I16x8 ShrU)
let i16x8_add = Binary (V128 (V128Op.I16x8 V128Op.Add))
let i16x8_add_saturate_s = Binary (V128 V128Op.(I16x8 AddSatS))
let i16x8_add_saturate_u = Binary (V128 V128Op.(I16x8 AddSatU))
let i16x8_sub = Binary (V128 (V128Op.I16x8 V128Op.Sub))
let i16x8_sub_saturate_s = Binary (V128 V128Op.(I16x8 SubSatS))
let i16x8_sub_saturate_u = Binary (V128 V128Op.(I16x8 SubSatU))
let i16x8_mul = Binary (V128 (V128Op.I16x8 V128Op.Mul))
let i16x8_abs = Unary (V128 (V128Op.I16x8 V128Op.Abs))
let i16x8_min_s = Binary (V128 (V128Op.I16x8 V128Op.MinS))
let i16x8_min_u = Binary (V128 (V128Op.I16x8 V128Op.MinU))
let i16x8_max_s = Binary (V128 (V128Op.I16x8 V128Op.MaxS))
let i16x8_max_u = Binary (V128 (V128Op.I16x8 V128Op.MaxU))
let i16x8_avgr_u = Binary (V128 (V128Op.I16x8 V128Op.AvgrU))

let i32x4_splat = Convert (V128 (V128Op.I32x4 V128Op.Splat))
let i32x4_extract_lane imm = SimdExtract (V128Op.I32x4 (ZX, imm))
let i32x4_replace_lane imm = SimdReplace (V128Op.I32x4 imm)
let i32x4_eq = Binary (V128 V128Op.(I32x4 Eq))
let i32x4_ne = Binary (V128 V128Op.(I32x4 Ne))
let i32x4_lt_s = Binary (V128 V128Op.(I32x4 LtS))
let i32x4_lt_u = Binary (V128 V128Op.(I32x4 LtU))
let i32x4_le_s = Binary (V128 V128Op.(I32x4 LeS))
let i32x4_le_u = Binary (V128 V128Op.(I32x4 LeU))
let i32x4_gt_s = Binary (V128 V128Op.(I32x4 GtS))
let i32x4_gt_u = Binary (V128 V128Op.(I32x4 GtU))
let i32x4_ge_s = Binary (V128 V128Op.(I32x4 GeS))
let i32x4_ge_u = Binary (V128 V128Op.(I32x4 GeU))
let i32x4_abs = Unary (V128 (V128Op.I32x4 V128Op.Abs))
let i32x4_neg = Unary (V128 (V128Op.I32x4 V128Op.Neg))
let i32x4_any_true = Test (V128 (V128Op.I32x4 V128Op.AnyTrue))
let i32x4_bitmask = SimdBitmask V128Op.(I32x4 Bitmask)
let i32x4_all_true = Test (V128 (V128Op.I32x4 V128Op.AllTrue))
let i32x4_widen_low_i16x8_s = Unary (V128 V128Op.(I32x4 WidenLowS))
let i32x4_widen_high_i16x8_s = Unary (V128 V128Op.(I32x4 WidenHighS))
let i32x4_widen_low_i16x8_u = Unary (V128 V128Op.(I32x4 WidenLowU))
let i32x4_widen_high_i16x8_u = Unary (V128 V128Op.(I32x4 WidenHighU))
let i32x4_shl = SimdShift V128Op.(I32x4 Shl)
let i32x4_shr_s = SimdShift V128Op.(I32x4 ShrS)
let i32x4_shr_u = SimdShift V128Op.(I32x4 ShrU)
let i32x4_add = Binary (V128 (V128Op.I32x4 V128Op.Add))
let i32x4_sub = Binary (V128 (V128Op.I32x4 V128Op.Sub))
let i32x4_min_s = Binary (V128 (V128Op.I32x4 V128Op.MinS))
let i32x4_min_u = Binary (V128 (V128Op.I32x4 V128Op.MinU))
let i32x4_max_s = Binary (V128 (V128Op.I32x4 V128Op.MaxS))
let i32x4_max_u = Binary (V128 (V128Op.I32x4 V128Op.MaxU))
let i32x4_mul = Binary (V128 (V128Op.I32x4 V128Op.Mul))
let i32x4_trunc_sat_f32x4_s = Unary (V128 V128Op.(I32x4 TruncSatF32x4S))
let i32x4_trunc_sat_f32x4_u = Unary (V128 V128Op.(I32x4 TruncSatF32x4U))

let i64x2_splat = Convert (V128 (V128Op.I64x2 V128Op.Splat))
let i64x2_extract_lane imm = SimdExtract (V128Op.I64x2 (ZX, imm))
let i64x2_replace_lane imm = SimdReplace (V128Op.I64x2 imm)
let i64x2_neg = Unary (V128 (V128Op.I64x2 V128Op.Neg))
let i64x2_add = Binary (V128 (V128Op.I64x2 V128Op.Add))
let i64x2_sub = Binary (V128 (V128Op.I64x2 V128Op.Sub))
let i64x2_mul = Binary (V128 (V128Op.I64x2 V128Op.Mul))
let i64x2_shl = SimdShift V128Op.(I64x2 Shl)
let i64x2_shr_s = SimdShift V128Op.(I64x2 ShrS)
let i64x2_shr_u = SimdShift V128Op.(I64x2 ShrU)

let f32x4_splat = Convert (V128 (V128Op.F32x4 V128Op.Splat))
let f32x4_extract_lane imm = SimdExtract (V128Op.F32x4 (ZX, imm))
let f32x4_replace_lane imm = SimdReplace (V128Op.F32x4 imm)
let f32x4_eq = Binary (V128 V128Op.(F32x4 Eq))
let f32x4_ne = Binary (V128 V128Op.(F32x4 Ne))
let f32x4_lt = Binary (V128 V128Op.(F32x4 Lt))
let f32x4_le = Binary (V128 V128Op.(F32x4 Le))
let f32x4_gt = Binary (V128 V128Op.(F32x4 Gt))
let f32x4_ge = Binary (V128 V128Op.(F32x4 Ge))
let f32x4_abs = Unary (V128 (V128Op.F32x4 V128Op.Abs))
let f32x4_neg = Unary (V128 (V128Op.F32x4 V128Op.Neg))
let f32x4_sqrt = Unary (V128 (V128Op.F32x4 V128Op.Sqrt))
let f32x4_add = Binary (V128 (V128Op.F32x4 V128Op.Add))
let f32x4_sub = Binary (V128 (V128Op.F32x4 V128Op.Sub))
let f32x4_mul = Binary (V128 (V128Op.F32x4 V128Op.Mul))
let f32x4_div = Binary (V128 (V128Op.F32x4 V128Op.Div))
let f32x4_min = Binary (V128 (V128Op.F32x4 V128Op.Min))
let f32x4_max = Binary (V128 (V128Op.F32x4 V128Op.Max))
let f32x4_convert_i32x4_s = Unary (V128 V128Op.(F32x4 ConvertI32x4S))
let f32x4_convert_i32x4_u = Unary (V128 V128Op.(F32x4 ConvertI32x4U))

let f64x2_splat = Convert (V128 (V128Op.F64x2 V128Op.Splat))
let f64x2_extract_lane imm = SimdExtract (V128Op.F64x2 (ZX, imm))
let f64x2_replace_lane imm = SimdReplace (V128Op.F64x2 imm)
let f64x2_eq = Binary (V128 V128Op.(F64x2 Eq))
let f64x2_ne = Binary (V128 V128Op.(F64x2 Ne))
let f64x2_lt = Binary (V128 V128Op.(F64x2 Lt))
let f64x2_le = Binary (V128 V128Op.(F64x2 Le))
let f64x2_gt = Binary (V128 V128Op.(F64x2 Gt))
let f64x2_ge = Binary (V128 V128Op.(F64x2 Ge))
let f64x2_neg = Unary (V128 (V128Op.F64x2 V128Op.Neg))
let f64x2_sqrt = Unary (V128 (V128Op.F64x2 V128Op.Sqrt))
let f64x2_add = Binary (V128 (V128Op.F64x2 V128Op.Add))
let f64x2_sub = Binary (V128 (V128Op.F64x2 V128Op.Sub))
let f64x2_mul = Binary (V128 (V128Op.F64x2 V128Op.Mul))
let f64x2_div = Binary (V128 (V128Op.F64x2 V128Op.Div))
let f64x2_min = Binary (V128 (V128Op.F64x2 V128Op.Min))
let f64x2_max = Binary (V128 (V128Op.F64x2 V128Op.Max))
let f64x2_abs = Unary (V128 (V128Op.F64x2 V128Op.Abs))
