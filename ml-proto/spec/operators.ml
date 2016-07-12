open Source
open Types
open Values
open Memory
open Ast


let i32_const n = Const (Int32 n.it @@ n.at)
let i64_const n = Const (Int64 n.it @@ n.at)
let f32_const n = Const (Float32 n.it @@ n.at)
let f64_const n = Const (Float64 n.it @@ n.at)

let unreachable = Unreachable
let nop = Nop
let drop = Drop
let block es = Block es
let loop es = Loop es
let br n x = Br (n, x)
let br_if n x = BrIf (n, x)
let br_table n xs x = BrTable (n, xs, x)
let return n = Return n
let if_ es1 es2 = If (es1, es2)
let select = Select

let call n x = Call (n, x)
let call_import n x = CallImport (n, x)
let call_indirect n x = CallIndirect (n, x)

let get_local x = GetLocal x
let set_local x = SetLocal x
let tee_local x = TeeLocal x

let i32_load align offset = Load {ty = Int32Type; align; offset}
let i64_load align offset = Load {ty = Int64Type; align; offset}
let f32_load align offset = Load {ty = Float32Type; align; offset}
let f64_load align offset = Load {ty = Float64Type; align; offset}
let i32_store align offset = Store {ty = Int32Type; align; offset}
let i64_store align offset = Store {ty = Int64Type; align; offset}
let f32_store align offset = Store {ty = Float32Type; align; offset}
let f64_store align offset = Store {ty = Float64Type; align; offset}
let i32_load8_s align offset =
    LoadPacked {memop = {ty = Int32Type; align; offset}; sz = Mem8; ext = SX}
let i32_load8_u align offset =
    LoadPacked {memop = {ty = Int32Type; align; offset}; sz = Mem8; ext = ZX}
let i32_load16_s align offset =
    LoadPacked {memop = {ty = Int32Type; align; offset}; sz = Mem16; ext = SX}
let i32_load16_u align offset =
    LoadPacked {memop = {ty = Int32Type; align; offset}; sz = Mem16; ext = ZX}
let i64_load8_s align offset =
    LoadPacked {memop = {ty = Int64Type; align; offset}; sz = Mem8; ext = SX}
let i64_load8_u align offset =
    LoadPacked {memop = {ty = Int64Type; align; offset}; sz = Mem8; ext = ZX}
let i64_load16_s align offset =
    LoadPacked {memop = {ty = Int64Type; align; offset}; sz = Mem16; ext = SX}
let i64_load16_u align offset =
    LoadPacked {memop = {ty = Int64Type; align; offset}; sz = Mem16; ext = ZX}
let i64_load32_s align offset =
    LoadPacked {memop = {ty = Int64Type; align; offset}; sz = Mem32; ext = SX}
let i64_load32_u align offset =
    LoadPacked {memop = {ty = Int64Type; align; offset}; sz = Mem32; ext = ZX}
let i32_store8 align offset =
    StorePacked {memop = {ty = Int32Type; align; offset}; sz = Mem8}
let i32_store16 align offset =
    StorePacked {memop = {ty = Int32Type; align; offset}; sz = Mem16}
let i64_store8 align offset =
    StorePacked {memop = {ty = Int64Type; align; offset}; sz = Mem8}
let i64_store16 align offset =
    StorePacked {memop = {ty = Int64Type; align; offset}; sz = Mem16}
let i64_store32 align offset =
    StorePacked {memop = {ty = Int64Type; align; offset}; sz = Mem32}

let i32_clz = Unary (Int32 I32Op.Clz)
let i32_ctz = Unary (Int32 I32Op.Ctz)
let i32_popcnt = Unary (Int32 I32Op.Popcnt)
let i64_clz = Unary (Int64 I64Op.Clz)
let i64_ctz = Unary (Int64 I64Op.Ctz)
let i64_popcnt = Unary (Int64 I64Op.Popcnt)
let f32_neg = Unary (Float32 F32Op.Neg)
let f32_abs = Unary (Float32 F32Op.Abs)
let f32_sqrt = Unary (Float32 F32Op.Sqrt)
let f32_ceil = Unary (Float32 F32Op.Ceil)
let f32_floor = Unary (Float32 F32Op.Floor)
let f32_trunc = Unary (Float32 F32Op.Trunc)
let f32_nearest = Unary (Float32 F32Op.Nearest)
let f64_neg = Unary (Float64 F64Op.Neg)
let f64_abs = Unary (Float64 F64Op.Abs)
let f64_sqrt = Unary (Float64 F64Op.Sqrt)
let f64_ceil = Unary (Float64 F64Op.Ceil)
let f64_floor = Unary (Float64 F64Op.Floor)
let f64_trunc = Unary (Float64 F64Op.Trunc)
let f64_nearest = Unary (Float64 F64Op.Nearest)

let i32_add = Binary (Int32 I32Op.Add)
let i32_sub = Binary (Int32 I32Op.Sub)
let i32_mul = Binary (Int32 I32Op.Mul)
let i32_div_s = Binary (Int32 I32Op.DivS)
let i32_div_u = Binary (Int32 I32Op.DivU)
let i32_rem_s = Binary (Int32 I32Op.RemS)
let i32_rem_u = Binary (Int32 I32Op.RemU)
let i32_and = Binary (Int32 I32Op.And)
let i32_or = Binary (Int32 I32Op.Or)
let i32_xor = Binary (Int32 I32Op.Xor)
let i32_shl = Binary (Int32 I32Op.Shl)
let i32_shr_s = Binary (Int32 I32Op.ShrS)
let i32_shr_u = Binary (Int32 I32Op.ShrU)
let i32_rotl = Binary (Int32 I32Op.Rotl)
let i32_rotr = Binary (Int32 I32Op.Rotr)
let i64_add = Binary (Int64 I64Op.Add)
let i64_sub = Binary (Int64 I64Op.Sub)
let i64_mul = Binary (Int64 I64Op.Mul)
let i64_div_s = Binary (Int64 I64Op.DivS)
let i64_div_u = Binary (Int64 I64Op.DivU)
let i64_rem_s = Binary (Int64 I64Op.RemS)
let i64_rem_u = Binary (Int64 I64Op.RemU)
let i64_and = Binary (Int64 I64Op.And)
let i64_or = Binary (Int64 I64Op.Or)
let i64_xor = Binary (Int64 I64Op.Xor)
let i64_shl = Binary (Int64 I64Op.Shl)
let i64_shr_s = Binary (Int64 I64Op.ShrS)
let i64_shr_u = Binary (Int64 I64Op.ShrU)
let i64_rotl = Binary (Int64 I64Op.Rotl)
let i64_rotr = Binary (Int64 I64Op.Rotr)
let f32_add = Binary (Float32 F32Op.Add)
let f32_sub = Binary (Float32 F32Op.Sub)
let f32_mul = Binary (Float32 F32Op.Mul)
let f32_div = Binary (Float32 F32Op.Div)
let f32_min = Binary (Float32 F32Op.Min)
let f32_max = Binary (Float32 F32Op.Max)
let f32_copysign = Binary (Float32 F32Op.CopySign)
let f64_add = Binary (Float64 F64Op.Add)
let f64_sub = Binary (Float64 F64Op.Sub)
let f64_mul = Binary (Float64 F64Op.Mul)
let f64_div = Binary (Float64 F64Op.Div)
let f64_min = Binary (Float64 F64Op.Min)
let f64_max = Binary (Float64 F64Op.Max)
let f64_copysign = Binary (Float64 F64Op.CopySign)

let i32_eqz = Test (Int32 I32Op.Eqz)
let i64_eqz = Test (Int64 I64Op.Eqz)

let i32_eq = Compare (Int32 I32Op.Eq)
let i32_ne = Compare (Int32 I32Op.Ne)
let i32_lt_s = Compare (Int32 I32Op.LtS)
let i32_lt_u = Compare (Int32 I32Op.LtU)
let i32_le_s = Compare (Int32 I32Op.LeS)
let i32_le_u = Compare (Int32 I32Op.LeU)
let i32_gt_s = Compare (Int32 I32Op.GtS)
let i32_gt_u = Compare (Int32 I32Op.GtU)
let i32_ge_s = Compare (Int32 I32Op.GeS)
let i32_ge_u = Compare (Int32 I32Op.GeU)
let i64_eq = Compare (Int64 I64Op.Eq)
let i64_ne = Compare (Int64 I64Op.Ne)
let i64_lt_s = Compare (Int64 I64Op.LtS)
let i64_lt_u = Compare (Int64 I64Op.LtU)
let i64_le_s = Compare (Int64 I64Op.LeS)
let i64_le_u = Compare (Int64 I64Op.LeU)
let i64_gt_s = Compare (Int64 I64Op.GtS)
let i64_gt_u = Compare (Int64 I64Op.GtU)
let i64_ge_s = Compare (Int64 I64Op.GeS)
let i64_ge_u = Compare (Int64 I64Op.GeU)
let f32_eq = Compare (Float32 F32Op.Eq)
let f32_ne = Compare (Float32 F32Op.Ne)
let f32_lt = Compare (Float32 F32Op.Lt)
let f32_le = Compare (Float32 F32Op.Le)
let f32_gt = Compare (Float32 F32Op.Gt)
let f32_ge = Compare (Float32 F32Op.Ge)
let f64_eq = Compare (Float64 F64Op.Eq)
let f64_ne = Compare (Float64 F64Op.Ne)
let f64_lt = Compare (Float64 F64Op.Lt)
let f64_le = Compare (Float64 F64Op.Le)
let f64_gt = Compare (Float64 F64Op.Gt)
let f64_ge = Compare (Float64 F64Op.Ge)

let i32_wrap_i64 = Convert (Int32 I32Op.WrapInt64)
let i32_trunc_s_f32 = Convert (Int32 I32Op.TruncSFloat32)
let i32_trunc_u_f32 = Convert (Int32 I32Op.TruncUFloat32)
let i32_trunc_s_f64 = Convert (Int32 I32Op.TruncSFloat64)
let i32_trunc_u_f64 = Convert (Int32 I32Op.TruncUFloat64)
let i64_extend_s_i32 = Convert (Int64 I64Op.ExtendSInt32)
let i64_extend_u_i32 = Convert (Int64 I64Op.ExtendUInt32)
let i64_trunc_s_f32 = Convert (Int64 I64Op.TruncSFloat32)
let i64_trunc_u_f32 = Convert (Int64 I64Op.TruncUFloat32)
let i64_trunc_s_f64 = Convert (Int64 I64Op.TruncSFloat64)
let i64_trunc_u_f64 = Convert (Int64 I64Op.TruncUFloat64)
let f32_convert_s_i32 = Convert (Float32 F32Op.ConvertSInt32)
let f32_convert_u_i32 = Convert (Float32 F32Op.ConvertUInt32)
let f32_convert_s_i64 = Convert (Float32 F32Op.ConvertSInt64)
let f32_convert_u_i64 = Convert (Float32 F32Op.ConvertUInt64)
let f32_demote_f64 = Convert (Float32 F32Op.DemoteFloat64)
let f64_convert_s_i32 = Convert (Float64 F64Op.ConvertSInt32)
let f64_convert_u_i32 = Convert (Float64 F64Op.ConvertUInt32)
let f64_convert_s_i64 = Convert (Float64 F64Op.ConvertSInt64)
let f64_convert_u_i64 = Convert (Float64 F64Op.ConvertUInt64)
let f64_promote_f32 = Convert (Float64 F64Op.PromoteFloat32)
let i32_reinterpret_f32 = Convert (Int32 I32Op.ReinterpretFloat)
let i64_reinterpret_f64 = Convert (Int64 I64Op.ReinterpretFloat)
let f32_reinterpret_i32 = Convert (Float32 F32Op.ReinterpretInt)
let f64_reinterpret_i64 = Convert (Float64 F64Op.ReinterpretInt)

let current_memory = CurrentMemory
let grow_memory = GrowMemory

