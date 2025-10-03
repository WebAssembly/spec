open Source
open Value
open V128
open Ast
open Types
open Pack

(* Instructions *)

let i32_const n = Const (I32 n.it @@ n.at)
let i64_const n = Const (I64 n.it @@ n.at)
let f32_const n = Const (F32 n.it @@ n.at)
let f64_const n = Const (F64 n.it @@ n.at)
let v128_const n = VecConst (V128 n.it @@ n.at)
let ref_null t = RefNull t
let ref_func x = RefFunc x

let at_const = function
  | I32AT -> fun n -> i32_const (Convert.I32_.wrap_i64 n.it @@ n.at)
  | I64AT -> i64_const

let unreachable = Unreachable
let nop = Nop
let drop = Drop
let select t = Select t

let block bt es = Block (bt, es)
let loop bt es = Loop (bt, es)
let if_ bt es1 es2 = If (bt, es1, es2)

let br x = Br x
let br_if x = BrIf x
let br_table xs x = BrTable (xs, x)
let br_on_null x = BrOnNull x
let br_on_non_null x = BrOnNonNull x
let br_on_cast x t1 t2 = BrOnCast (x, t1, t2)
let br_on_cast_fail x t1 t2 = BrOnCastFail (x, t1, t2)

let catch x1 x2 = Catch (x1, x2)
let catch_ref x1 x2 = CatchRef (x1, x2)
let catch_all x = CatchAll x
let catch_all_ref x = CatchAllRef x

let return = Return
let call x = Call x
let call_ref x = CallRef x
let call_indirect x y = CallIndirect (x, y)
let return_call x = ReturnCall x
let return_call_ref x = ReturnCallRef x
let return_call_indirect x y = ReturnCallIndirect (x, y)

let throw x = Throw x
let throw_ref = ThrowRef
let try_table bt cs es = TryTable (bt, cs, es)

let local_get x = LocalGet x
let local_set x = LocalSet x
let local_tee x = LocalTee x
let global_get x = GlobalGet x
let global_set x = GlobalSet x

let table_get x = TableGet x
let table_set x = TableSet x
let table_size x = TableSize x
let table_grow x = TableGrow x
let table_fill x = TableFill x
let table_copy x y = TableCopy (x, y)
let table_init x y = TableInit (x, y)
let elem_drop x = ElemDrop x

let i32_load x align offset =
  Load (x, {ty = I32T; align; offset; pack = None})
let i64_load x align offset =
  Load (x, {ty = I64T; align; offset; pack = None})
let f32_load x align offset =
  Load (x, {ty = F32T; align; offset; pack = None})
let f64_load x align offset =
  Load (x, {ty = F64T; align; offset; pack = None})
let i32_load8_s x align offset =
  Load (x, {ty = I32T; align; offset; pack = Some (Pack8, S)})
let i32_load8_u x align offset =
  Load (x, {ty = I32T; align; offset; pack = Some (Pack8, U)})
let i32_load16_s x align offset =
  Load (x, {ty = I32T; align; offset; pack = Some (Pack16, S)})
let i32_load16_u x align offset =
  Load (x, {ty = I32T; align; offset; pack = Some (Pack16, U)})
let i64_load8_s x align offset =
  Load (x, {ty = I64T; align; offset; pack = Some (Pack8, S)})
let i64_load8_u x align offset =
  Load (x, {ty = I64T; align; offset; pack = Some (Pack8, U)})
let i64_load16_s x align offset =
  Load (x, {ty = I64T; align; offset; pack = Some (Pack16, S)})
let i64_load16_u x align offset =
  Load (x, {ty = I64T; align; offset; pack = Some (Pack16, U)})
let i64_load32_s x align offset =
  Load (x, {ty = I64T; align; offset; pack = Some (Pack32, S)})
let i64_load32_u x align offset =
  Load (x, {ty = I64T; align; offset; pack = Some (Pack32, U)})

let i32_store x align offset =
  Store (x, {ty = I32T; align; offset; pack = None})
let i64_store x align offset =
  Store (x, {ty = I64T; align; offset; pack = None})
let f32_store x align offset =
  Store (x, {ty = F32T; align; offset; pack = None})
let f64_store x align offset =
  Store (x, {ty = F64T; align; offset; pack = None})
let i32_store8 x align offset =
  Store (x, {ty = I32T; align; offset; pack = Some Pack8})
let i32_store16 x align offset =
  Store (x, {ty = I32T; align; offset; pack = Some Pack16})
let i64_store8 x align offset =
  Store (x, {ty = I64T; align; offset; pack = Some Pack8})
let i64_store16 x align offset =
  Store (x, {ty = I64T; align; offset; pack = Some Pack16})
let i64_store32 x align offset =
  Store (x, {ty = I64T; align; offset; pack = Some Pack32})

let v128_load x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = None})
let v128_load8x8_s x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = Some (Pack64, ExtLane (Pack8x8, S))})
let v128_load8x8_u x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = Some (Pack64, ExtLane (Pack8x8, U))})
let v128_load16x4_s x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = Some (Pack64, ExtLane (Pack16x4, S))})
let v128_load16x4_u x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = Some (Pack64, ExtLane (Pack16x4, U))})
let v128_load32x2_s x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = Some (Pack64, ExtLane (Pack32x2, S))})
let v128_load32x2_u x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = Some (Pack64, ExtLane (Pack32x2, U))})
let v128_load8_splat x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = Some (Pack8, ExtSplat)})
let v128_load16_splat x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = Some (Pack16, ExtSplat)})
let v128_load32_splat x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = Some (Pack32, ExtSplat)})
let v128_load64_splat x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = Some (Pack64, ExtSplat)})
let v128_load32_zero x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = Some (Pack32, ExtZero)})
let v128_load64_zero x align offset =
  VecLoad (x, {ty = V128T; align; offset; pack = Some (Pack64, ExtZero)})
let v128_load8_lane x align offset i =
  VecLoadLane (x, {ty = V128T; align; offset; pack = Pack8}, i)
let v128_load16_lane x align offset i =
  VecLoadLane (x, {ty = V128T; align; offset; pack = Pack16}, i)
let v128_load32_lane x align offset i =
  VecLoadLane (x, {ty = V128T; align; offset; pack = Pack32}, i)
let v128_load64_lane x align offset i =
  VecLoadLane (x, {ty = V128T; align; offset; pack = Pack64}, i)

let v128_store x align offset =
  VecStore (x, {ty = V128T; align; offset; pack = ()})
let v128_store8_lane x align offset i =
  VecStoreLane (x, {ty = V128T; align; offset; pack = Pack8}, i)
let v128_store16_lane x align offset i =
  VecStoreLane (x, {ty = V128T; align; offset; pack = Pack16}, i)
let v128_store32_lane x align offset i =
  VecStoreLane (x, {ty = V128T; align; offset; pack = Pack32}, i)
let v128_store64_lane x align offset i =
  VecStoreLane (x, {ty = V128T; align; offset; pack = Pack64}, i)

let memory_size x = MemorySize x
let memory_grow x = MemoryGrow x
let memory_fill x = MemoryFill x
let memory_copy x y = MemoryCopy (x, y)
let memory_init x y = MemoryInit (x, y)
let data_drop x = DataDrop x

let ref_is_null = RefIsNull
let ref_as_non_null = RefAsNonNull  
let ref_test t = RefTest t
let ref_cast t = RefCast t
let ref_eq = RefEq

let ref_i31 = RefI31
let i31_get_u = I31Get U
let i31_get_s = I31Get S
let struct_new x = StructNew (x, Explicit)
let struct_new_default x = StructNew (x, Implicit)
let struct_get x y = StructGet (x, y, None)
let struct_get_u x y = StructGet (x, y, Some U)
let struct_get_s x y = StructGet (x, y, Some S)
let struct_set x y = StructSet (x, y)
let array_new x = ArrayNew (x, Explicit)
let array_new_default x = ArrayNew (x, Implicit)
let array_new_fixed x n = ArrayNewFixed (x, n)
let array_new_elem x y = ArrayNewElem (x, y)
let array_new_data x y = ArrayNewData (x, y)
let array_get x = ArrayGet (x, None)
let array_get_u x = ArrayGet (x, Some U)
let array_get_s x = ArrayGet (x, Some S)
let array_set x = ArraySet x
let array_len = ArrayLen
let array_copy x y = ArrayCopy (x, y)
let array_fill x = ArrayFill x
let array_init_data x y = ArrayInitData (x, y)
let array_init_elem x y = ArrayInitElem (x, y)

let any_convert_extern = ExternConvert Internalize
let extern_convert_any = ExternConvert Externalize

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
let i32_div_s = Binary (I32 I32Op.(Div S))
let i32_div_u = Binary (I32 I32Op.(Div U))
let i32_rem_s = Binary (I32 I32Op.(Rem S))
let i32_rem_u = Binary (I32 I32Op.(Rem U))
let i32_and = Binary (I32 I32Op.And)
let i32_or = Binary (I32 I32Op.Or)
let i32_xor = Binary (I32 I32Op.Xor)
let i32_shl = Binary (I32 I32Op.Shl)
let i32_shr_s = Binary (I32 I32Op.(Shr S))
let i32_shr_u = Binary (I32 I32Op.(Shr U))
let i32_rotl = Binary (I32 I32Op.Rotl)
let i32_rotr = Binary (I32 I32Op.Rotr)
let i64_add = Binary (I64 I64Op.Add)
let i64_sub = Binary (I64 I64Op.Sub)
let i64_mul = Binary (I64 I64Op.Mul)
let i64_div_s = Binary (I64 I64Op.(Div S))
let i64_div_u = Binary (I64 I64Op.(Div U))
let i64_rem_s = Binary (I64 I64Op.(Rem S))
let i64_rem_u = Binary (I64 I64Op.(Rem U))
let i64_and = Binary (I64 I64Op.And)
let i64_or = Binary (I64 I64Op.Or)
let i64_xor = Binary (I64 I64Op.Xor)
let i64_shl = Binary (I64 I64Op.Shl)
let i64_shr_s = Binary (I64 I64Op.(Shr S))
let i64_shr_u = Binary (I64 I64Op.(Shr U))
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
let i32_lt_s = Compare (I32 I32Op.(Lt S))
let i32_lt_u = Compare (I32 I32Op.(Lt U))
let i32_le_s = Compare (I32 I32Op.(Le S))
let i32_le_u = Compare (I32 I32Op.(Le U))
let i32_gt_s = Compare (I32 I32Op.(Gt S))
let i32_gt_u = Compare (I32 I32Op.(Gt U))
let i32_ge_s = Compare (I32 I32Op.(Ge S))
let i32_ge_u = Compare (I32 I32Op.(Ge U))
let i64_eq = Compare (I64 I64Op.Eq)
let i64_ne = Compare (I64 I64Op.Ne)
let i64_lt_s = Compare (I64 I64Op.(Lt S))
let i64_lt_u = Compare (I64 I64Op.(Lt U))
let i64_le_s = Compare (I64 I64Op.(Le S))
let i64_le_u = Compare (I64 I64Op.(Le U))
let i64_gt_s = Compare (I64 I64Op.(Gt S))
let i64_gt_u = Compare (I64 I64Op.(Gt U))
let i64_ge_s = Compare (I64 I64Op.(Ge S))
let i64_ge_u = Compare (I64 I64Op.(Ge U))
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

let i32_extend8_s = Unary (I32 I32Op.(ExtendS Pack8))
let i32_extend16_s = Unary (I32 I32Op.(ExtendS Pack16))
let i64_extend8_s = Unary (I64 I64Op.(ExtendS Pack8))
let i64_extend16_s = Unary (I64 I64Op.(ExtendS Pack16))
let i64_extend32_s = Unary (I64 I64Op.(ExtendS Pack32))

let i32_wrap_i64 = Convert (I32 I32Op.WrapI64)
let i32_trunc_f32_s = Convert (I32 I32Op.(TruncF32 S))
let i32_trunc_f32_u = Convert (I32 I32Op.(TruncF32 U))
let i32_trunc_f64_s = Convert (I32 I32Op.(TruncF64 S))
let i32_trunc_f64_u = Convert (I32 I32Op.(TruncF64 U))
let i32_trunc_sat_f32_s = Convert (I32 I32Op.(TruncSatF32 S))
let i32_trunc_sat_f32_u = Convert (I32 I32Op.(TruncSatF32 U))
let i32_trunc_sat_f64_s = Convert (I32 I32Op.(TruncSatF64 S))
let i32_trunc_sat_f64_u = Convert (I32 I32Op.(TruncSatF64 U))
let i64_extend_i32_s = Convert (I64 I64Op.(ExtendI32 S))
let i64_extend_i32_u = Convert (I64 I64Op.(ExtendI32 U))
let i64_trunc_f32_s = Convert (I64 I64Op.(TruncF32 S))
let i64_trunc_f32_u = Convert (I64 I64Op.(TruncF32 U))
let i64_trunc_f64_s = Convert (I64 I64Op.(TruncF64 S))
let i64_trunc_f64_u = Convert (I64 I64Op.(TruncF64 U))
let f32_convert_i32_s = Convert (F32 F32Op.(ConvertI32 S))
let f32_convert_i32_u = Convert (F32 F32Op.(ConvertI32 U))
let f32_convert_i64_s = Convert (F32 F32Op.(ConvertI64 S))
let f32_convert_i64_u = Convert (F32 F32Op.(ConvertI64 U))
let i64_trunc_sat_f32_s = Convert (I64 I64Op.(TruncSatF32 S))
let i64_trunc_sat_f32_u = Convert (I64 I64Op.(TruncSatF32 U))
let i64_trunc_sat_f64_s = Convert (I64 I64Op.(TruncSatF64 S))
let i64_trunc_sat_f64_u = Convert (I64 I64Op.(TruncSatF64 U))
let f32_demote_f64 = Convert (F32 F32Op.DemoteF64)
let f64_convert_i32_s = Convert (F64 F64Op.(ConvertI32 S))
let f64_convert_i32_u = Convert (F64 F64Op.(ConvertI32 U))
let f64_convert_i64_s = Convert (F64 F64Op.(ConvertI64 S))
let f64_convert_i64_u = Convert (F64 F64Op.(ConvertI64 U))
let f64_promote_f32 = Convert (F64 F64Op.PromoteF32)
let i32_reinterpret_f32 = Convert (I32 I32Op.ReinterpretFloat)
let i64_reinterpret_f64 = Convert (I64 I64Op.ReinterpretFloat)
let f32_reinterpret_i32 = Convert (F32 F32Op.ReinterpretInt)
let f64_reinterpret_i64 = Convert (F64 F64Op.ReinterpretInt)

let v128_not = VecUnaryBits (V128 V128Op.Not)
let v128_and = VecBinaryBits (V128 V128Op.And)
let v128_andnot = VecBinaryBits (V128 V128Op.AndNot)
let v128_or = VecBinaryBits (V128 V128Op.Or)
let v128_xor = VecBinaryBits (V128 V128Op.Xor)
let v128_bitselect = VecTernaryBits (V128 V128Op.Bitselect)
let v128_any_true = VecTestBits (V128 V128Op.AnyTrue)

let i8x16_swizzle = VecBinary (V128 (I8x16 V128Op.Swizzle))
let i8x16_shuffle is = VecBinary (V128 (I8x16 (V128Op.Shuffle is)))

let i8x16_splat = VecSplat (V128 (I8x16 V128Op.Splat))
let i8x16_extract_lane_s i = VecExtract (V128 (I8x16 V128Op.(Extract (i, S))))
let i8x16_extract_lane_u i = VecExtract (V128 (I8x16 V128Op.(Extract (i, U))))
let i8x16_replace_lane i = VecReplace (V128 (I8x16 V128Op.(Replace i)))
let i8x16_eq = VecCompare (V128 (I8x16 V128Op.Eq))
let i8x16_ne = VecCompare (V128 (I8x16 V128Op.Ne))
let i8x16_lt_s = VecCompare (V128 (I8x16 V128Op.(Lt S)))
let i8x16_lt_u = VecCompare (V128 (I8x16 V128Op.(Lt U)))
let i8x16_le_s = VecCompare (V128 (I8x16 V128Op.(Le S)))
let i8x16_le_u = VecCompare (V128 (I8x16 V128Op.(Le U)))
let i8x16_gt_s = VecCompare (V128 (I8x16 V128Op.(Gt S)))
let i8x16_gt_u = VecCompare (V128 (I8x16 V128Op.(Gt U)))
let i8x16_ge_s = VecCompare (V128 (I8x16 V128Op.(Ge S)))
let i8x16_ge_u = VecCompare (V128 (I8x16 V128Op.(Ge U)))
let i8x16_neg = VecUnary (V128 (I8x16 V128Op.Neg))
let i8x16_bitmask = VecBitmask (V128 (I8x16 V128Op.Bitmask))
let i8x16_all_true = VecTest (V128 (I8x16 V128Op.AllTrue))
let i8x16_narrow_i16x8_s = VecBinary (V128 (I8x16 V128Op.(Narrow S)))
let i8x16_narrow_i16x8_u = VecBinary (V128 (I8x16 V128Op.(Narrow U)))
let i16x8_extend_low_i8x16_s = VecConvert (V128 (I16x8 V128Op.(Extend (Low, S))))
let i16x8_extend_high_i8x16_s = VecConvert (V128 (I16x8 V128Op.(Extend (High, S))))
let i16x8_extend_low_i8x16_u = VecConvert (V128 (I16x8 V128Op.(Extend (Low, U))))
let i16x8_extend_high_i8x16_u = VecConvert (V128 (I16x8 V128Op.(Extend (High, U))))
let i8x16_shl = VecShift (V128 (I8x16 V128Op.Shl))
let i8x16_shr_s = VecShift (V128 (I8x16 V128Op.(Shr S)))
let i8x16_shr_u = VecShift (V128 (I8x16 V128Op.(Shr U)))
let i8x16_add = VecBinary (V128 (I8x16 V128Op.Add))
let i8x16_add_sat_s = VecBinary (V128 (I8x16 V128Op.(AddSat S)))
let i8x16_add_sat_u = VecBinary (V128 (I8x16 V128Op.(AddSat U)))
let i8x16_sub = VecBinary (V128 (I8x16 V128Op.Sub))
let i8x16_sub_sat_s = VecBinary (V128 (I8x16 V128Op.(SubSat S)))
let i8x16_sub_sat_u = VecBinary (V128 (I8x16 V128Op.(SubSat U)))
let i8x16_abs = VecUnary (V128 (I8x16 V128Op.Abs))
let i8x16_popcnt = VecUnary (V128 (I8x16 V128Op.Popcnt))
let i8x16_min_s = VecBinary (V128 (I8x16 V128Op.(Min S)))
let i8x16_min_u = VecBinary (V128 (I8x16 V128Op.(Min U)))
let i8x16_max_s = VecBinary (V128 (I8x16 V128Op.(Max S)))
let i8x16_max_u = VecBinary (V128 (I8x16 V128Op.(Max U)))
let i8x16_avgr_u = VecBinary (V128 (I8x16 V128Op.AvgrU))

let i16x8_splat = VecSplat (V128 (I16x8 V128Op.Splat))
let i16x8_extract_lane_s i = VecExtract (V128 (I16x8 V128Op.(Extract (i, S))))
let i16x8_extract_lane_u i = VecExtract (V128 (I16x8 V128Op.(Extract (i, U))))
let i16x8_replace_lane i = VecReplace (V128 (I16x8 V128Op.(Replace i)))
let i16x8_eq = VecCompare (V128 (I16x8 V128Op.Eq))
let i16x8_ne = VecCompare (V128 (I16x8 V128Op.Ne))
let i16x8_lt_s = VecCompare (V128 (I16x8 V128Op.(Lt S)))
let i16x8_lt_u = VecCompare (V128 (I16x8 V128Op.(Lt U)))
let i16x8_le_s = VecCompare (V128 (I16x8 V128Op.(Le S)))
let i16x8_le_u = VecCompare (V128 (I16x8 V128Op.(Le U)))
let i16x8_gt_s = VecCompare (V128 (I16x8 V128Op.(Gt S)))
let i16x8_gt_u = VecCompare (V128 (I16x8 V128Op.(Gt U)))
let i16x8_ge_s = VecCompare (V128 (I16x8 V128Op.(Ge S)))
let i16x8_ge_u = VecCompare (V128 (I16x8 V128Op.(Ge U)))
let i16x8_neg = VecUnary (V128 (I16x8 V128Op.Neg))
let i16x8_bitmask = VecBitmask (V128 (I16x8 V128Op.Bitmask))
let i16x8_all_true = VecTest (V128 (I16x8 V128Op.AllTrue))
let i16x8_narrow_i32x4_s = VecBinary (V128 (I16x8 V128Op.(Narrow S)))
let i16x8_narrow_i32x4_u = VecBinary (V128 (I16x8 V128Op.(Narrow U)))
let i16x8_shl = VecShift (V128 (I16x8 V128Op.Shl))
let i16x8_shr_s = VecShift (V128 (I16x8 V128Op.(Shr S)))
let i16x8_shr_u = VecShift (V128 (I16x8 V128Op.(Shr U)))
let i16x8_add = VecBinary (V128 (I16x8 V128Op.Add))
let i16x8_add_sat_s = VecBinary (V128 (I16x8 V128Op.(AddSat S)))
let i16x8_add_sat_u = VecBinary (V128 (I16x8 V128Op.(AddSat U)))
let i16x8_sub = VecBinary (V128 (I16x8 V128Op.Sub))
let i16x8_sub_sat_s = VecBinary (V128 (I16x8 V128Op.(SubSat S)))
let i16x8_sub_sat_u = VecBinary (V128 (I16x8 V128Op.(SubSat U)))
let i16x8_mul = VecBinary (V128 (I16x8 V128Op.Mul))
let i16x8_abs = VecUnary (V128 (I16x8 V128Op.Abs))
let i16x8_min_s = VecBinary (V128 (I16x8 V128Op.(Min S)))
let i16x8_min_u = VecBinary (V128 (I16x8 V128Op.(Min U)))
let i16x8_max_s = VecBinary (V128 (I16x8 V128Op.(Max S)))
let i16x8_max_u = VecBinary (V128 (I16x8 V128Op.(Max U)))
let i16x8_avgr_u = VecBinary (V128 (I16x8 V128Op.AvgrU))
let i16x8_extmul_low_i8x16_s = VecBinary (V128 (I16x8 V128Op.(ExtMul (Low, S))))
let i16x8_extmul_high_i8x16_s = VecBinary (V128 (I16x8 V128Op.(ExtMul (High, S))))
let i16x8_extmul_low_i8x16_u = VecBinary (V128 (I16x8 V128Op.(ExtMul (Low, U))))
let i16x8_extmul_high_i8x16_u = VecBinary (V128 (I16x8 V128Op.(ExtMul (High, U))))
let i16x8_q15mulr_sat_s = VecBinary (V128 (I16x8 V128Op.Q15MulRSatS))
let i16x8_extadd_pairwise_i8x16_s = VecConvert (V128 (I16x8 V128Op.(ExtAddPairwise S)))
let i16x8_extadd_pairwise_i8x16_u = VecConvert (V128 (I16x8 V128Op.(ExtAddPairwise U)))

let i32x4_splat = VecSplat (V128 (I32x4 V128Op.Splat))
let i32x4_extract_lane i = VecExtract (V128 (I32x4 V128Op.(Extract (i, ()))))
let i32x4_replace_lane i = VecReplace (V128 (I32x4 V128Op.(Replace i)))
let i32x4_eq = VecCompare (V128 (I32x4 V128Op.Eq))
let i32x4_ne = VecCompare (V128 (I32x4 V128Op.Ne))
let i32x4_lt_s = VecCompare (V128 (I32x4 V128Op.(Lt S)))
let i32x4_lt_u = VecCompare (V128 (I32x4 V128Op.(Lt U)))
let i32x4_le_s = VecCompare (V128 (I32x4 V128Op.(Le S)))
let i32x4_le_u = VecCompare (V128 (I32x4 V128Op.(Le U)))
let i32x4_gt_s = VecCompare (V128 (I32x4 V128Op.(Gt S)))
let i32x4_gt_u = VecCompare (V128 (I32x4 V128Op.(Gt U)))
let i32x4_ge_s = VecCompare (V128 (I32x4 V128Op.(Ge S)))
let i32x4_ge_u = VecCompare (V128 (I32x4 V128Op.(Ge U)))
let i32x4_abs = VecUnary (V128 (I32x4 V128Op.Abs))
let i32x4_neg = VecUnary (V128 (I32x4 V128Op.Neg))
let i32x4_bitmask = VecBitmask (V128 (I32x4 V128Op.Bitmask))
let i32x4_all_true = VecTest (V128 (I32x4 V128Op.AllTrue))
let i32x4_extend_low_i16x8_s = VecConvert (V128 (I32x4 V128Op.(Extend (Low, S))))
let i32x4_extend_high_i16x8_s = VecConvert (V128 (I32x4 V128Op.(Extend (High, S))))
let i32x4_extend_low_i16x8_u = VecConvert (V128 (I32x4 V128Op.(Extend (Low, U))))
let i32x4_extend_high_i16x8_u = VecConvert (V128 (I32x4 V128Op.(Extend (High, U))))
let i32x4_shl = VecShift (V128 (I32x4 V128Op.Shl))
let i32x4_shr_s = VecShift (V128 (I32x4 V128Op.(Shr S)))
let i32x4_shr_u = VecShift (V128 (I32x4 V128Op.(Shr U)))
let i32x4_add = VecBinary (V128 (I32x4 V128Op.Add))
let i32x4_sub = VecBinary (V128 (I32x4 V128Op.Sub))
let i32x4_min_s = VecBinary (V128 (I32x4 V128Op.(Min S)))
let i32x4_min_u = VecBinary (V128 (I32x4 V128Op.(Min U)))
let i32x4_max_s = VecBinary (V128 (I32x4 V128Op.(Max S)))
let i32x4_max_u = VecBinary (V128 (I32x4 V128Op.(Max U)))
let i32x4_mul = VecBinary (V128 (I32x4 V128Op.Mul))
let i32x4_dot_i16x8_s = VecBinary (V128 (I32x4 V128Op.DotS))
let i32x4_trunc_sat_f32x4_s = VecConvert (V128 (I32x4 V128Op.(TruncSatF32x4 S)))
let i32x4_trunc_sat_f32x4_u = VecConvert (V128 (I32x4 V128Op.(TruncSatF32x4 U)))
let i32x4_trunc_sat_f64x2_s_zero = VecConvert (V128 (I32x4 V128Op.(TruncSatZeroF64x2 S)))
let i32x4_trunc_sat_f64x2_u_zero = VecConvert (V128 (I32x4 V128Op.(TruncSatZeroF64x2 U)))
let i32x4_extmul_low_i16x8_s = VecBinary (V128 (I32x4 V128Op.(ExtMul (Low, S))))
let i32x4_extmul_high_i16x8_s = VecBinary (V128 (I32x4 V128Op.(ExtMul (High, S))))
let i32x4_extmul_low_i16x8_u = VecBinary (V128 (I32x4 V128Op.(ExtMul (Low, U))))
let i32x4_extmul_high_i16x8_u = VecBinary (V128 (I32x4 V128Op.(ExtMul (High, U))))
let i32x4_extadd_pairwise_i16x8_s = VecConvert (V128 (I32x4 V128Op.(ExtAddPairwise S)))
let i32x4_extadd_pairwise_i16x8_u = VecConvert (V128 (I32x4 V128Op.(ExtAddPairwise U)))

let i64x2_splat = VecSplat (V128 (I64x2 V128Op.Splat))
let i64x2_extract_lane i = VecExtract (V128 (I64x2 V128Op.(Extract (i, ()))))
let i64x2_replace_lane i = VecReplace (V128 (I64x2 V128Op.(Replace i)))
let i64x2_extend_low_i32x4_s = VecConvert (V128 (I64x2 V128Op.(Extend (Low, S))))
let i64x2_extend_high_i32x4_s = VecConvert (V128 (I64x2 V128Op.(Extend (High, S))))
let i64x2_extend_low_i32x4_u = VecConvert (V128 (I64x2 V128Op.(Extend (Low, U))))
let i64x2_extend_high_i32x4_u = VecConvert (V128 (I64x2 V128Op.(Extend (High, U))))
let i64x2_eq = VecCompare (V128 (I64x2 V128Op.Eq))
let i64x2_ne = VecCompare (V128 (I64x2 V128Op.Ne))
let i64x2_lt_s = VecCompare (V128 (I64x2 V128Op.(Lt S)))
let i64x2_le_s = VecCompare (V128 (I64x2 V128Op.(Le S)))
let i64x2_gt_s = VecCompare (V128 (I64x2 V128Op.(Gt S)))
let i64x2_ge_s = VecCompare (V128 (I64x2 V128Op.(Ge S)))
let i64x2_abs = VecUnary (V128 (I64x2 V128Op.Abs))
let i64x2_neg = VecUnary (V128 (I64x2 V128Op.Neg))
let i64x2_bitmask = VecBitmask (V128 (I64x2 V128Op.Bitmask))
let i64x2_all_true = VecTest (V128 (I64x2 V128Op.AllTrue))
let i64x2_add = VecBinary (V128 (I64x2 V128Op.Add))
let i64x2_sub = VecBinary (V128 (I64x2 V128Op.Sub))
let i64x2_mul = VecBinary (V128 (I64x2 V128Op.Mul))
let i64x2_shl = VecShift (V128 (I64x2 V128Op.Shl))
let i64x2_shr_s = VecShift (V128 (I64x2 V128Op.(Shr S)))
let i64x2_shr_u = VecShift (V128 (I64x2 V128Op.(Shr U)))
let i64x2_extmul_low_i32x4_s = VecBinary (V128 (I64x2 V128Op.(ExtMul (Low, S))))
let i64x2_extmul_high_i32x4_s = VecBinary (V128 (I64x2 V128Op.(ExtMul (High, S))))
let i64x2_extmul_low_i32x4_u = VecBinary (V128 (I64x2 V128Op.(ExtMul (Low, U))))
let i64x2_extmul_high_i32x4_u = VecBinary (V128 (I64x2 V128Op.(ExtMul (High, U))))

let f32x4_splat = VecSplat (V128 (F32x4 V128Op.Splat))
let f32x4_extract_lane i = VecExtract (V128 (F32x4 V128Op.(Extract (i, ()))))
let f32x4_replace_lane i = VecReplace (V128 (F32x4 V128Op.(Replace i)))
let f32x4_eq = VecCompare (V128 (F32x4 V128Op.Eq))
let f32x4_ne = VecCompare (V128 (F32x4 V128Op.Ne))
let f32x4_lt = VecCompare (V128 (F32x4 V128Op.Lt))
let f32x4_le = VecCompare (V128 (F32x4 V128Op.Le))
let f32x4_gt = VecCompare (V128 (F32x4 V128Op.Gt))
let f32x4_ge = VecCompare (V128 (F32x4 V128Op.Ge))
let f32x4_abs = VecUnary (V128 (F32x4 V128Op.Abs))
let f32x4_neg = VecUnary (V128 (F32x4 V128Op.Neg))
let f32x4_sqrt = VecUnary (V128 (F32x4 V128Op.Sqrt))
let f32x4_ceil = VecUnary (V128 (F32x4 V128Op.Ceil))
let f32x4_floor = VecUnary (V128 (F32x4 V128Op.Floor))
let f32x4_trunc = VecUnary (V128 (F32x4 V128Op.Trunc))
let f32x4_nearest = VecUnary (V128 (F32x4 V128Op.Nearest))
let f32x4_add = VecBinary (V128 (F32x4 V128Op.Add))
let f32x4_sub = VecBinary (V128 (F32x4 V128Op.Sub))
let f32x4_mul = VecBinary (V128 (F32x4 V128Op.Mul))
let f32x4_div = VecBinary (V128 (F32x4 V128Op.Div))
let f32x4_min = VecBinary (V128 (F32x4 V128Op.Min))
let f32x4_max = VecBinary (V128 (F32x4 V128Op.Max))
let f32x4_pmin = VecBinary (V128 (F32x4 V128Op.Pmin))
let f32x4_pmax = VecBinary (V128 (F32x4 V128Op.Pmax))
let f32x4_demote_f64x2_zero = VecConvert (V128 (F32x4 V128Op.DemoteZeroF64x2))
let f32x4_convert_i32x4_s = VecConvert (V128 (F32x4 V128Op.(ConvertI32x4 S)))
let f32x4_convert_i32x4_u = VecConvert (V128 (F32x4 V128Op.(ConvertI32x4 U)))

let f64x2_splat = VecSplat (V128 (F64x2 V128Op.Splat))
let f64x2_extract_lane i = VecExtract (V128 (F64x2 V128Op.(Extract (i, ()))))
let f64x2_replace_lane i = VecReplace (V128 (F64x2 V128Op.(Replace i)))
let f64x2_eq = VecCompare (V128 (F64x2 V128Op.Eq))
let f64x2_ne = VecCompare (V128 (F64x2 V128Op.Ne))
let f64x2_lt = VecCompare (V128 (F64x2 V128Op.Lt))
let f64x2_le = VecCompare (V128 (F64x2 V128Op.Le))
let f64x2_gt = VecCompare (V128 (F64x2 V128Op.Gt))
let f64x2_ge = VecCompare (V128 (F64x2 V128Op.Ge))
let f64x2_neg = VecUnary (V128 (F64x2 V128Op.Neg))
let f64x2_sqrt = VecUnary (V128 (F64x2 V128Op.Sqrt))
let f64x2_ceil = VecUnary (V128 (F64x2 V128Op.Ceil))
let f64x2_floor = VecUnary (V128 (F64x2 V128Op.Floor))
let f64x2_trunc = VecUnary (V128 (F64x2 V128Op.Trunc))
let f64x2_nearest = VecUnary (V128 (F64x2 V128Op.Nearest))
let f64x2_add = VecBinary (V128 (F64x2 V128Op.Add))
let f64x2_sub = VecBinary (V128 (F64x2 V128Op.Sub))
let f64x2_mul = VecBinary (V128 (F64x2 V128Op.Mul))
let f64x2_div = VecBinary (V128 (F64x2 V128Op.Div))
let f64x2_min = VecBinary (V128 (F64x2 V128Op.Min))
let f64x2_max = VecBinary (V128 (F64x2 V128Op.Max))
let f64x2_abs = VecUnary (V128 (F64x2 V128Op.Abs))
let f64x2_pmin = VecBinary (V128 (F64x2 V128Op.Pmin))
let f64x2_pmax = VecBinary (V128 (F64x2 V128Op.Pmax))
let f64x2_promote_low_f32x4 = VecConvert (V128 (F64x2 V128Op.PromoteLowF32x4))
let f64x2_convert_low_i32x4_s = VecConvert (V128 (F64x2 V128Op.(ConvertI32x4 S)))
let f64x2_convert_low_i32x4_u = VecConvert (V128 (F64x2 V128Op.(ConvertI32x4 U)))

let i8x16_relaxed_swizzle = VecBinary (V128 (I8x16 V128Op.RelaxedSwizzle))
let i8x16_relaxed_laneselect = VecTernary (V128 (I8x16 V128Op.RelaxedLaneselect))
let i16x8_relaxed_q15mulr_s = VecBinary (V128 (I16x8 V128Op.RelaxedQ15MulRS))
let i16x8_relaxed_laneselect = VecTernary (V128 (I16x8 V128Op.RelaxedLaneselect))
let i32x4_relaxed_trunc_f32x4_s = VecConvert (V128 (I32x4 V128Op.(RelaxedTruncF32x4 S)))
let i32x4_relaxed_trunc_f32x4_u = VecConvert (V128 (I32x4 V128Op.(RelaxedTruncF32x4 U)))
let i32x4_relaxed_trunc_f64x2_s_zero = VecConvert (V128 (I32x4 V128Op.(RelaxedTruncZeroF64x2 S)))
let i32x4_relaxed_trunc_f64x2_u_zero = VecConvert (V128 (I32x4 V128Op.(RelaxedTruncZeroF64x2 U)))
let i32x4_relaxed_laneselect = VecTernary (V128 (I32x4 V128Op.RelaxedLaneselect))
let i64x2_relaxed_laneselect = VecTernary (V128 (I64x2 V128Op.RelaxedLaneselect))
let f32x4_relaxed_madd = VecTernary (V128 (F32x4 V128Op.RelaxedMadd))
let f32x4_relaxed_nmadd = VecTernary (V128 (F32x4 V128Op.RelaxedNmadd))
let f32x4_relaxed_min = VecBinary (V128 (F32x4 V128Op.RelaxedMin))
let f32x4_relaxed_max = VecBinary (V128 (F32x4 V128Op.RelaxedMax))
let f64x2_relaxed_madd = VecTernary (V128 (F64x2 V128Op.RelaxedMadd))
let f64x2_relaxed_nmadd = VecTernary (V128 (F64x2 V128Op.RelaxedNmadd))
let f64x2_relaxed_min = VecBinary (V128 (F64x2 V128Op.RelaxedMin))
let f64x2_relaxed_max = VecBinary (V128 (F64x2 V128Op.RelaxedMax))
let i16x8_relaxed_dot_i8x16_i7x16_s = VecBinary (V128 (I16x8 V128Op.RelaxedDot))
let i32x4_relaxed_dot_i8x16_i7x16_add_s = VecTernary (V128 (I32x4 V128Op.RelaxedDotAddS))
