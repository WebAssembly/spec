open Source
open Types
open Values
open Memory
open Ast


let i32_const n = Const (I32 n.it @@ n.at)
let i64_const n = Const (I64 n.it @@ n.at)
let f32_const n = Const (F32 n.it @@ n.at)
let f64_const n = Const (F64 n.it @@ n.at)

let unreachable = Unreachable
let nop = Nop
let drop = Drop
let block ts es = Block (ts, es)
let loop ts es = Loop (ts, es)
let br x = Br x
let br_if x = BrIf x
let br_table xs x = BrTable (xs, x)
let return = Return
let if_ ts es1 es2 = If (ts, es1, es2)
let select = Select

let call x = Call x
let call_indirect x = CallIndirect x

let get_local x = GetLocal x
let set_local x = SetLocal x
let tee_local x = TeeLocal x
let get_global x = GetGlobal x
let set_global x = SetGlobal x

let i32_load align offset = Load {ty = I32Type; align; offset; sz = None}
let i64_load align offset = Load {ty = I64Type; align; offset; sz = None}
let f32_load align offset = Load {ty = F32Type; align; offset; sz = None}
let f64_load align offset = Load {ty = F64Type; align; offset; sz = None}
let i32_load8_s align offset =
  Load {ty = I32Type; align; offset; sz = Some (Mem8, SX)}
let i32_load8_u align offset =
  Load {ty = I32Type; align; offset; sz = Some (Mem8, ZX)}
let i32_load16_s align offset =
  Load {ty = I32Type; align; offset; sz = Some (Mem16, SX)}
let i32_load16_u align offset =
  Load {ty = I32Type; align; offset; sz = Some (Mem16, ZX)}
let i64_load8_s align offset =
  Load {ty = I64Type; align; offset; sz = Some (Mem8, SX)}
let i64_load8_u align offset =
  Load {ty = I64Type; align; offset; sz = Some (Mem8, ZX)}
let i64_load16_s align offset =
  Load {ty = I64Type; align; offset; sz = Some (Mem16, SX)}
let i64_load16_u align offset =
  Load {ty = I64Type; align; offset; sz = Some (Mem16, ZX)}
let i64_load32_s align offset =
  Load {ty = I64Type; align; offset; sz = Some (Mem32, SX)}
let i64_load32_u align offset =
  Load {ty = I64Type; align; offset; sz = Some (Mem32, ZX)}

let i32_store align offset = Store {ty = I32Type; align; offset; sz = None}
let i64_store align offset = Store {ty = I64Type; align; offset; sz = None}
let f32_store align offset = Store {ty = F32Type; align; offset; sz = None}
let f64_store align offset = Store {ty = F64Type; align; offset; sz = None}
let i32_store8 align offset =
  Store {ty = I32Type; align; offset; sz = Some Mem8}
let i32_store16 align offset =
  Store {ty = I32Type; align; offset; sz = Some Mem16}
let i64_store8 align offset =
  Store {ty = I64Type; align; offset; sz = Some Mem8}
let i64_store16 align offset =
  Store {ty = I64Type; align; offset; sz = Some Mem16}
let i64_store32 align offset =
  Store {ty = I64Type; align; offset; sz = Some Mem32}

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

let i32_wrap_i64 = Convert (I32 I32Op.WrapI64)
let i32_trunc_s_f32 = Convert (I32 I32Op.TruncSF32)
let i32_trunc_u_f32 = Convert (I32 I32Op.TruncUF32)
let i32_trunc_s_f64 = Convert (I32 I32Op.TruncSF64)
let i32_trunc_u_f64 = Convert (I32 I32Op.TruncUF64)
let i64_extend_s_i32 = Convert (I64 I64Op.ExtendSI32)
let i64_extend_u_i32 = Convert (I64 I64Op.ExtendUI32)
let i64_trunc_s_f32 = Convert (I64 I64Op.TruncSF32)
let i64_trunc_u_f32 = Convert (I64 I64Op.TruncUF32)
let i64_trunc_s_f64 = Convert (I64 I64Op.TruncSF64)
let i64_trunc_u_f64 = Convert (I64 I64Op.TruncUF64)
let f32_convert_s_i32 = Convert (F32 F32Op.ConvertSI32)
let f32_convert_u_i32 = Convert (F32 F32Op.ConvertUI32)
let f32_convert_s_i64 = Convert (F32 F32Op.ConvertSI64)
let f32_convert_u_i64 = Convert (F32 F32Op.ConvertUI64)
let f32_demote_f64 = Convert (F32 F32Op.DemoteF64)
let f64_convert_s_i32 = Convert (F64 F64Op.ConvertSI32)
let f64_convert_u_i32 = Convert (F64 F64Op.ConvertUI32)
let f64_convert_s_i64 = Convert (F64 F64Op.ConvertSI64)
let f64_convert_u_i64 = Convert (F64 F64Op.ConvertUI64)
let f64_promote_f32 = Convert (F64 F64Op.PromoteF32)
let i32_reinterpret_f32 = Convert (I32 I32Op.ReinterpretFloat)
let i64_reinterpret_f64 = Convert (I64 I64Op.ReinterpretFloat)
let f32_reinterpret_i32 = Convert (F32 F32Op.ReinterpretInt)
let f64_reinterpret_i64 = Convert (F64 F64Op.ReinterpretInt)

let current_memory = CurrentMemory
let grow_memory = GrowMemory

