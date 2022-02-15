open Source
open Types
open Value
open Ast


let i32_const n = Const (I32 n.it @@ n.at)
let i64_const n = Const (I64 n.it @@ n.at)
let f32_const n = Const (F32 n.it @@ n.at)
let f64_const n = Const (F64 n.it @@ n.at)
let ref_null t = RefNull t
let ref_func x = RefFunc x

let unreachable = Unreachable
let nop = Nop
let drop = Drop
let select t = Select t

let block bt es = Block (bt, es)
let loop bt es = Loop (bt, es)
let if_ bt es1 es2 = If (bt, es1, es2)
let let_ bt ts es = Let (bt, ts, es)

let br x = Br x
let br_if x = BrIf x
let br_table xs x = BrTable (xs, x)
let br_on_null x = BrCast (x, NullOp)
let br_on_i31 x = BrCast (x, I31Op)
let br_on_data x = BrCast (x, DataOp)
let br_on_array x = BrCast (x, ArrayOp)
let br_on_func x = BrCast (x, FuncOp)
let br_on_cast x = BrCast (x, RttOp)
let br_on_non_null x = BrCastFail (x, NullOp)
let br_on_non_i31 x = BrCastFail (x, I31Op)
let br_on_non_data x = BrCastFail (x, DataOp)
let br_on_non_array x = BrCastFail (x, ArrayOp)
let br_on_non_func x = BrCastFail (x, FuncOp)
let br_on_cast_fail x = BrCastFail (x, RttOp)

let return = Return
let call x = Call x
let call_ref = CallRef
let call_indirect x y = CallIndirect (x, y)
let return_call_ref = ReturnCallRef
let func_bind x = FuncBind x

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

let memory_size = MemorySize
let memory_grow = MemoryGrow
let memory_fill = MemoryFill
let memory_copy = MemoryCopy
let memory_init x = MemoryInit x
let data_drop x = DataDrop x

let ref_is_null = RefTest NullOp
let ref_is_i31 = RefTest I31Op
let ref_is_data = RefTest DataOp
let ref_is_array = RefTest ArrayOp
let ref_is_func = RefTest FuncOp
let ref_test = RefTest RttOp
let ref_as_non_null = RefCast NullOp
let ref_as_i31 = RefCast I31Op
let ref_as_data = RefCast DataOp
let ref_as_array = RefCast ArrayOp
let ref_as_func = RefCast FuncOp
let ref_cast = RefCast RttOp
let ref_eq = RefEq

let i31_new = I31New
let i31_get_u = I31Get ZX
let i31_get_s = I31Get SX
let struct_new x = StructNew (x, Explicit)
let struct_new_default x = StructNew (x, Implicit)
let struct_get x y = StructGet (x, y, None)
let struct_get_u x y = StructGet (x, y, Some ZX)
let struct_get_s x y = StructGet (x, y, Some SX)
let struct_set x y = StructSet (x, y)
let array_new x = ArrayNew (x, Explicit)
let array_new_default x = ArrayNew (x, Implicit)
let array_get x = ArrayGet (x, None)
let array_get_u x = ArrayGet (x, Some ZX)
let array_get_s x = ArrayGet (x, Some SX)
let array_set x = ArraySet x
let array_len = ArrayLen

let rtt_canon x = RttCanon x

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
