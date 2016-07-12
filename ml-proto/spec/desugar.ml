open Source
open Types
open Values
open Memory
open Kernel


(* Expressions *)

let rec expr e = expr' e.at e.it @@ e.at
and expr' at = function
  | Ast.I32_const n -> Const (Int32 n.it @@ n.at)
  | Ast.I64_const n -> Const (Int64 n.it @@ n.at)
  | Ast.F32_const n -> Const (Float32 n.it @@ n.at)
  | Ast.F64_const n -> Const (Float64 n.it @@ n.at)

  | Ast.Nop -> Nop
  | Ast.Unreachable -> Unreachable
  | Ast.Drop -> Drop
  | Ast.Block es -> Block (expr_list es)
  | Ast.Loop es -> Loop (expr_list es)
  | Ast.Br (n, x) -> Break (n, x)
  | Ast.Br_if (n, x) -> BreakIf (n, x)
  | Ast.Br_table (n, xs, x) -> BreakTable (n, xs, x)
  | Ast.Return n -> Return n
  | Ast.If (es1, es2) -> If (expr_list es1, expr_list es2)
  | Ast.Select -> Select

  | Ast.Call (n, x) -> Call (n, x)
  | Ast.Call_import (n, x) -> CallImport (n, x)
  | Ast.Call_indirect (n, x) -> CallIndirect (n, x)

  | Ast.Get_local x -> GetLocal x
  | Ast.Set_local x -> SetLocal x
  | Ast.Tee_local x -> TeeLocal x

  | Ast.I32_load (offset, align) -> Load {ty = Int32Type; offset; align}
  | Ast.I64_load (offset, align) -> Load {ty = Int64Type; offset; align}
  | Ast.F32_load (offset, align) -> Load {ty = Float32Type; offset; align}
  | Ast.F64_load (offset, align) -> Load {ty = Float64Type; offset; align}
  | Ast.I32_store (offset, align) -> Store {ty = Int32Type; offset; align}
  | Ast.I64_store (offset, align) -> Store {ty = Int64Type; offset; align}
  | Ast.F32_store (offset, align) -> Store {ty = Float32Type; offset; align}
  | Ast.F64_store (offset, align) -> Store {ty = Float64Type; offset; align}
  | Ast.I32_load8_s (offset, align) ->
    LoadPacked {memop = {ty = Int32Type; offset; align}; sz = Mem8; ext = SX}
  | Ast.I32_load8_u (offset, align) ->
    LoadPacked {memop = {ty = Int32Type; offset; align}; sz = Mem8; ext = ZX}
  | Ast.I32_load16_s (offset, align) ->
    LoadPacked {memop = {ty = Int32Type; offset; align}; sz = Mem16; ext = SX}
  | Ast.I32_load16_u (offset, align) ->
    LoadPacked {memop = {ty = Int32Type; offset; align}; sz = Mem16; ext = ZX}
  | Ast.I64_load8_s (offset, align) ->
    LoadPacked {memop = {ty = Int64Type; offset; align}; sz = Mem8; ext = SX}
  | Ast.I64_load8_u (offset, align) ->
    LoadPacked {memop = {ty = Int64Type; offset; align}; sz = Mem8; ext = ZX}
  | Ast.I64_load16_s (offset, align) ->
    LoadPacked {memop = {ty = Int64Type; offset; align}; sz = Mem16; ext = SX}
  | Ast.I64_load16_u (offset, align) ->
    LoadPacked {memop = {ty = Int64Type; offset; align}; sz = Mem16; ext = ZX}
  | Ast.I64_load32_s (offset, align) ->
    LoadPacked {memop = {ty = Int64Type; offset; align}; sz = Mem32; ext = SX}
  | Ast.I64_load32_u (offset, align) ->
    LoadPacked {memop = {ty = Int64Type; offset; align}; sz = Mem32; ext = ZX}
  | Ast.I32_store8 (offset, align) ->
    StorePacked {memop = {ty = Int32Type; offset; align}; sz = Mem8}
  | Ast.I32_store16 (offset, align) ->
    StorePacked {memop = {ty = Int32Type; offset; align}; sz = Mem16}
  | Ast.I64_store8 (offset, align) ->
    StorePacked {memop = {ty = Int64Type; offset; align}; sz = Mem8}
  | Ast.I64_store16 (offset, align) ->
    StorePacked {memop = {ty = Int64Type; offset; align}; sz = Mem16}
  | Ast.I64_store32 (offset, align) ->
    StorePacked {memop = {ty = Int64Type; offset; align}; sz = Mem32}

  | Ast.I32_clz -> Unary (Int32 I32Op.Clz)
  | Ast.I32_ctz -> Unary (Int32 I32Op.Ctz)
  | Ast.I32_popcnt -> Unary (Int32 I32Op.Popcnt)
  | Ast.I64_clz -> Unary (Int64 I64Op.Clz)
  | Ast.I64_ctz -> Unary (Int64 I64Op.Ctz)
  | Ast.I64_popcnt -> Unary (Int64 I64Op.Popcnt)
  | Ast.F32_neg -> Unary (Float32 F32Op.Neg)
  | Ast.F32_abs -> Unary (Float32 F32Op.Abs)
  | Ast.F32_sqrt -> Unary (Float32 F32Op.Sqrt)
  | Ast.F32_ceil -> Unary (Float32 F32Op.Ceil)
  | Ast.F32_floor -> Unary (Float32 F32Op.Floor)
  | Ast.F32_trunc -> Unary (Float32 F32Op.Trunc)
  | Ast.F32_nearest -> Unary (Float32 F32Op.Nearest)
  | Ast.F64_neg -> Unary (Float64 F64Op.Neg)
  | Ast.F64_abs -> Unary (Float64 F64Op.Abs)
  | Ast.F64_sqrt -> Unary (Float64 F64Op.Sqrt)
  | Ast.F64_ceil -> Unary (Float64 F64Op.Ceil)
  | Ast.F64_floor -> Unary (Float64 F64Op.Floor)
  | Ast.F64_trunc -> Unary (Float64 F64Op.Trunc)
  | Ast.F64_nearest -> Unary (Float64 F64Op.Nearest)

  | Ast.I32_add -> Binary (Int32 I32Op.Add)
  | Ast.I32_sub -> Binary (Int32 I32Op.Sub)
  | Ast.I32_mul -> Binary (Int32 I32Op.Mul)
  | Ast.I32_div_s -> Binary (Int32 I32Op.DivS)
  | Ast.I32_div_u -> Binary (Int32 I32Op.DivU)
  | Ast.I32_rem_s -> Binary (Int32 I32Op.RemS)
  | Ast.I32_rem_u -> Binary (Int32 I32Op.RemU)
  | Ast.I32_and -> Binary (Int32 I32Op.And)
  | Ast.I32_or -> Binary (Int32 I32Op.Or)
  | Ast.I32_xor -> Binary (Int32 I32Op.Xor)
  | Ast.I32_shl -> Binary (Int32 I32Op.Shl)
  | Ast.I32_shr_s -> Binary (Int32 I32Op.ShrS)
  | Ast.I32_shr_u -> Binary (Int32 I32Op.ShrU)
  | Ast.I32_rotl -> Binary (Int32 I32Op.Rotl)
  | Ast.I32_rotr -> Binary (Int32 I32Op.Rotr)
  | Ast.I64_add -> Binary (Int64 I64Op.Add)
  | Ast.I64_sub -> Binary (Int64 I64Op.Sub)
  | Ast.I64_mul -> Binary (Int64 I64Op.Mul)
  | Ast.I64_div_s -> Binary (Int64 I64Op.DivS)
  | Ast.I64_div_u -> Binary (Int64 I64Op.DivU)
  | Ast.I64_rem_s -> Binary (Int64 I64Op.RemS)
  | Ast.I64_rem_u -> Binary (Int64 I64Op.RemU)
  | Ast.I64_and -> Binary (Int64 I64Op.And)
  | Ast.I64_or -> Binary (Int64 I64Op.Or)
  | Ast.I64_xor -> Binary (Int64 I64Op.Xor)
  | Ast.I64_shl -> Binary (Int64 I64Op.Shl)
  | Ast.I64_shr_s -> Binary (Int64 I64Op.ShrS)
  | Ast.I64_shr_u -> Binary (Int64 I64Op.ShrU)
  | Ast.I64_rotl -> Binary (Int64 I64Op.Rotl)
  | Ast.I64_rotr -> Binary (Int64 I64Op.Rotr)
  | Ast.F32_add -> Binary (Float32 F32Op.Add)
  | Ast.F32_sub -> Binary (Float32 F32Op.Sub)
  | Ast.F32_mul -> Binary (Float32 F32Op.Mul)
  | Ast.F32_div -> Binary (Float32 F32Op.Div)
  | Ast.F32_min -> Binary (Float32 F32Op.Min)
  | Ast.F32_max -> Binary (Float32 F32Op.Max)
  | Ast.F32_copysign -> Binary (Float32 F32Op.CopySign)
  | Ast.F64_add -> Binary (Float64 F64Op.Add)
  | Ast.F64_sub -> Binary (Float64 F64Op.Sub)
  | Ast.F64_mul -> Binary (Float64 F64Op.Mul)
  | Ast.F64_div -> Binary (Float64 F64Op.Div)
  | Ast.F64_min -> Binary (Float64 F64Op.Min)
  | Ast.F64_max -> Binary (Float64 F64Op.Max)
  | Ast.F64_copysign -> Binary (Float64 F64Op.CopySign)

  | Ast.I32_eqz -> Test (Int32 I32Op.Eqz)
  | Ast.I64_eqz -> Test (Int64 I64Op.Eqz)

  | Ast.I32_eq -> Compare (Int32 I32Op.Eq)
  | Ast.I32_ne -> Compare (Int32 I32Op.Ne)
  | Ast.I32_lt_s -> Compare (Int32 I32Op.LtS)
  | Ast.I32_lt_u -> Compare (Int32 I32Op.LtU)
  | Ast.I32_le_s -> Compare (Int32 I32Op.LeS)
  | Ast.I32_le_u -> Compare (Int32 I32Op.LeU)
  | Ast.I32_gt_s -> Compare (Int32 I32Op.GtS)
  | Ast.I32_gt_u -> Compare (Int32 I32Op.GtU)
  | Ast.I32_ge_s -> Compare (Int32 I32Op.GeS)
  | Ast.I32_ge_u -> Compare (Int32 I32Op.GeU)
  | Ast.I64_eq -> Compare (Int64 I64Op.Eq)
  | Ast.I64_ne -> Compare (Int64 I64Op.Ne)
  | Ast.I64_lt_s -> Compare (Int64 I64Op.LtS)
  | Ast.I64_lt_u -> Compare (Int64 I64Op.LtU)
  | Ast.I64_le_s -> Compare (Int64 I64Op.LeS)
  | Ast.I64_le_u -> Compare (Int64 I64Op.LeU)
  | Ast.I64_gt_s -> Compare (Int64 I64Op.GtS)
  | Ast.I64_gt_u -> Compare (Int64 I64Op.GtU)
  | Ast.I64_ge_s -> Compare (Int64 I64Op.GeS)
  | Ast.I64_ge_u -> Compare (Int64 I64Op.GeU)
  | Ast.F32_eq -> Compare (Float32 F32Op.Eq)
  | Ast.F32_ne -> Compare (Float32 F32Op.Ne)
  | Ast.F32_lt -> Compare (Float32 F32Op.Lt)
  | Ast.F32_le -> Compare (Float32 F32Op.Le)
  | Ast.F32_gt -> Compare (Float32 F32Op.Gt)
  | Ast.F32_ge -> Compare (Float32 F32Op.Ge)
  | Ast.F64_eq -> Compare (Float64 F64Op.Eq)
  | Ast.F64_ne -> Compare (Float64 F64Op.Ne)
  | Ast.F64_lt -> Compare (Float64 F64Op.Lt)
  | Ast.F64_le -> Compare (Float64 F64Op.Le)
  | Ast.F64_gt -> Compare (Float64 F64Op.Gt)
  | Ast.F64_ge -> Compare (Float64 F64Op.Ge)

  | Ast.I32_wrap_i64 -> Convert (Int32 I32Op.WrapInt64)
  | Ast.I32_trunc_s_f32 -> Convert (Int32 I32Op.TruncSFloat32)
  | Ast.I32_trunc_u_f32 -> Convert (Int32 I32Op.TruncUFloat32)
  | Ast.I32_trunc_s_f64 -> Convert (Int32 I32Op.TruncSFloat64)
  | Ast.I32_trunc_u_f64 -> Convert (Int32 I32Op.TruncUFloat64)
  | Ast.I64_extend_s_i32 -> Convert (Int64 I64Op.ExtendSInt32)
  | Ast.I64_extend_u_i32 -> Convert (Int64 I64Op.ExtendUInt32)
  | Ast.I64_trunc_s_f32 -> Convert (Int64 I64Op.TruncSFloat32)
  | Ast.I64_trunc_u_f32 -> Convert (Int64 I64Op.TruncUFloat32)
  | Ast.I64_trunc_s_f64 -> Convert (Int64 I64Op.TruncSFloat64)
  | Ast.I64_trunc_u_f64 -> Convert (Int64 I64Op.TruncUFloat64)
  | Ast.F32_convert_s_i32 -> Convert (Float32 F32Op.ConvertSInt32)
  | Ast.F32_convert_u_i32 -> Convert (Float32 F32Op.ConvertUInt32)
  | Ast.F32_convert_s_i64 -> Convert (Float32 F32Op.ConvertSInt64)
  | Ast.F32_convert_u_i64 -> Convert (Float32 F32Op.ConvertUInt64)
  | Ast.F32_demote_f64 -> Convert (Float32 F32Op.DemoteFloat64)
  | Ast.F64_convert_s_i32 -> Convert (Float64 F64Op.ConvertSInt32)
  | Ast.F64_convert_u_i32 -> Convert (Float64 F64Op.ConvertUInt32)
  | Ast.F64_convert_s_i64 -> Convert (Float64 F64Op.ConvertSInt64)
  | Ast.F64_convert_u_i64 -> Convert (Float64 F64Op.ConvertUInt64)
  | Ast.F64_promote_f32 -> Convert (Float64 F64Op.PromoteFloat32)
  | Ast.I32_reinterpret_f32 -> Convert (Int32 I32Op.ReinterpretFloat)
  | Ast.I64_reinterpret_f64 -> Convert (Int64 I64Op.ReinterpretFloat)
  | Ast.F32_reinterpret_i32 -> Convert (Float32 F32Op.ReinterpretInt)
  | Ast.F64_reinterpret_i64 -> Convert (Float64 F64Op.ReinterpretInt)

  | Ast.Current_memory -> CurrentMemory
  | Ast.Grow_memory -> GrowMemory

and expr_list = function
  | [] -> []
  | e :: es -> expr e :: expr_list es


(* Functions and Modules *)

let rec func f = func' f.it @@ f.at
and func' = function
  | {Ast.body = es; ftype; locals} ->
    {body = [Block (expr_list es) @@ Source.no_region]; ftype; locals}

let rec module_ m = module' m.it @@ m.at
and module' = function
  | {Ast.funcs = fs; start; memory; types; imports; exports; table} ->
    {funcs = List.map func fs; start; memory; types; imports; exports; table}

let desugar = module_
