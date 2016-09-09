open Source
open Types
open Values
open Memory
open Kernel


(* Labels *)

let rec relabel f n e = relabel' f n e.it @@ e.at
and relabel' f n = function
  | Nop -> Nop
  | Unreachable -> Unreachable
  | Drop e -> Drop (relabel f n e)
  | Block (es, e) ->
    Block (List.map (relabel f (n + 1)) es, relabel f (n + 1) e)
  | Loop e -> Loop (relabel f (n + 1) e)
  | Break (x, eo) ->
    Break (relabel_var f n x, Lib.Option.map (relabel f n) eo)
  | BreakIf (x, eo, e) ->
    BreakIf (relabel_var f n x, Lib.Option.map (relabel f n) eo, relabel f n e)
  | BreakTable (xs, x, eo, e) ->
    BreakTable
      (List.map (relabel_var f n) xs, relabel_var f n x,
       Lib.Option.map (relabel f n) eo, relabel f n e)
  | If (e1, e2, e3) -> If (relabel f n e1, relabel f n e2, relabel f n e3)
  | Select (e1, e2, e3) ->
    Select (relabel f n e1, relabel f n e2, relabel f n e3)
  | Call (x, es) -> Call (x, List.map (relabel f n) es)
  | CallIndirect (x, e, es) ->
    CallIndirect (x, relabel f n e, List.map (relabel f n) es)
  | GetLocal x -> GetLocal x
  | SetLocal (x, e) -> SetLocal (x, relabel f n e)
  | TeeLocal (x, e) -> TeeLocal (x, relabel f n e)
  | GetGlobal x -> GetGlobal x
  | SetGlobal (x, e) -> SetGlobal (x, relabel f n e)
  | Load (memop, e) -> Load (memop, relabel f n e)
  | Store (memop, e1, e2) -> Store (memop, relabel f n e1, relabel f n e2)
  | LoadExtend (extop, e) -> LoadExtend (extop, relabel f n e)
  | StoreWrap (wrapop, e1, e2) ->
    StoreWrap (wrapop, relabel f n e1, relabel f n e2)
  | Const c -> Const c
  | Unary (unop, e) -> Unary (unop, relabel f n e)
  | Binary (binop, e1, e2) -> Binary (binop, relabel f n e1, relabel f n e2)
  | Test (testop, e) -> Test (testop, relabel f n e)
  | Compare (relop, e1, e2) -> Compare (relop, relabel f n e1, relabel f n e2)
  | Convert (cvtop, e) -> Convert (cvtop, relabel f n e)
  | Host (hostop, es) -> Host (hostop, List.map (relabel f n) es)

and relabel_var f n x = f n x.it @@ x.at

let label e = relabel (fun n i -> if i < n then i else i + 1) 0 e
let return e = relabel (fun n i -> if i = -1 then n else i) (-1) e


(* Expressions *)

let rec expr e = expr' e.at e.it @@ e.at
and expr' at = function
  | Ast.I32_const n -> Const (Int32 n.it @@ n.at)
  | Ast.I64_const n -> Const (Int64 n.it @@ n.at)
  | Ast.F32_const n -> Const (Float32 n.it @@ n.at)
  | Ast.F64_const n -> Const (Float64 n.it @@ n.at)

  | Ast.Nop -> Nop
  | Ast.Unreachable -> Unreachable
  | Ast.Drop e -> Drop (expr e)
  | Ast.Block [] -> Nop
  | Ast.Block es ->
    let es', e = Lib.List.split_last es in Block (List.map expr es', expr e)
  | Ast.Loop es -> Block ([], Loop (block es) @@ at)
  | Ast.Br (x, eo) -> Break (x, Lib.Option.map expr eo)
  | Ast.Br_if (x, eo, e) -> BreakIf (x, Lib.Option.map expr eo, expr e)
  | Ast.Br_table (xs, x, eo, e) ->
    BreakTable (xs, x, Lib.Option.map expr eo, expr e)
  | Ast.Return eo -> Break (-1 @@ at, Lib.Option.map expr eo)
  | Ast.If (e, es1, es2) -> If (expr e, seq es1, seq es2)
  | Ast.Select (e1, e2, e3) -> Select (expr e1, expr e2, expr e3)

  | Ast.Call (x, es) -> Call (x, List.map expr es)
  | Ast.Call_indirect (x, e, es) -> CallIndirect (x, expr e, List.map expr es)

  | Ast.Get_local x -> GetLocal x
  | Ast.Set_local (x, e) -> SetLocal (x, expr e)
  | Ast.Tee_local (x, e) -> TeeLocal (x, expr e)
  | Ast.Get_global x -> GetGlobal x
  | Ast.Set_global (x, e) -> SetGlobal (x, expr e)

  | Ast.I32_load (offset, align, e) ->
    Load ({ty = Int32Type; offset; align}, expr e)
  | Ast.I64_load (offset, align, e) ->
    Load ({ty = Int64Type; offset; align}, expr e)
  | Ast.F32_load (offset, align, e) ->
    Load ({ty = Float32Type; offset; align}, expr e)
  | Ast.F64_load (offset, align, e) ->
    Load ({ty = Float64Type; offset; align}, expr e)
  | Ast.I32_store (offset, align, e1, e2) ->
    Store ({ty = Int32Type; offset; align}, expr e1, expr e2)
  | Ast.I64_store (offset, align, e1, e2) ->
    Store ({ty = Int64Type; offset; align}, expr e1, expr e2)
  | Ast.F32_store (offset, align, e1, e2) ->
    Store ({ty = Float32Type; offset; align}, expr e1, expr e2)
  | Ast.F64_store (offset, align, e1, e2) ->
    Store ({ty = Float64Type; offset; align}, expr e1, expr e2)
  | Ast.I32_load8_s (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int32Type; offset; align}; sz = Mem8; ext = SX}, expr e)
  | Ast.I32_load8_u (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int32Type; offset; align}; sz = Mem8; ext = ZX}, expr e)
  | Ast.I32_load16_s (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int32Type; offset; align}; sz = Mem16; ext = SX}, expr e)
  | Ast.I32_load16_u (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int32Type; offset; align}; sz = Mem16; ext = ZX}, expr e)
  | Ast.I64_load8_s (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int64Type; offset; align}; sz = Mem8; ext = SX}, expr e)
  | Ast.I64_load8_u (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int64Type; offset; align}; sz = Mem8; ext = ZX}, expr e)
  | Ast.I64_load16_s (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int64Type; offset; align}; sz = Mem16; ext = SX}, expr e)
  | Ast.I64_load16_u (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int64Type; offset; align}; sz = Mem16; ext = ZX}, expr e)
  | Ast.I64_load32_s (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int64Type; offset; align}; sz = Mem32; ext = SX}, expr e)
  | Ast.I64_load32_u (offset, align, e) ->
    LoadExtend
      ({memop = {ty = Int64Type; offset; align}; sz = Mem32; ext = ZX}, expr e)
  | Ast.I32_store8 (offset, align, e1, e2) ->
    StoreWrap
      ({memop = {ty = Int32Type; offset; align}; sz = Mem8}, expr e1, expr e2)
  | Ast.I32_store16 (offset, align, e1, e2) ->
    StoreWrap
      ({memop = {ty = Int32Type; offset; align}; sz = Mem16}, expr e1, expr e2)
  | Ast.I64_store8 (offset, align, e1, e2) ->
    StoreWrap
      ({memop = {ty = Int64Type; offset; align}; sz = Mem8}, expr e1, expr e2)
  | Ast.I64_store16 (offset, align, e1, e2) ->
    StoreWrap
      ({memop = {ty = Int64Type; offset; align}; sz = Mem16}, expr e1, expr e2)
  | Ast.I64_store32 (offset, align, e1, e2) ->
    StoreWrap
      ({memop = {ty = Int64Type; offset; align}; sz = Mem32}, expr e1, expr e2)

  | Ast.I32_clz e -> Unary (Int32 I32Op.Clz, expr e)
  | Ast.I32_ctz e -> Unary (Int32 I32Op.Ctz, expr e)
  | Ast.I32_popcnt e -> Unary (Int32 I32Op.Popcnt, expr e)
  | Ast.I64_clz e -> Unary (Int64 I64Op.Clz, expr e)
  | Ast.I64_ctz e -> Unary (Int64 I64Op.Ctz, expr e)
  | Ast.I64_popcnt e -> Unary (Int64 I64Op.Popcnt, expr e)
  | Ast.F32_neg e -> Unary (Float32 F32Op.Neg, expr e)
  | Ast.F32_abs e -> Unary (Float32 F32Op.Abs, expr e)
  | Ast.F32_sqrt e -> Unary (Float32 F32Op.Sqrt, expr e)
  | Ast.F32_ceil e -> Unary (Float32 F32Op.Ceil, expr e)
  | Ast.F32_floor e -> Unary (Float32 F32Op.Floor, expr e)
  | Ast.F32_trunc e -> Unary (Float32 F32Op.Trunc, expr e)
  | Ast.F32_nearest e -> Unary (Float32 F32Op.Nearest, expr e)
  | Ast.F64_neg e -> Unary (Float64 F64Op.Neg, expr e)
  | Ast.F64_abs e -> Unary (Float64 F64Op.Abs, expr e)
  | Ast.F64_sqrt e -> Unary (Float64 F64Op.Sqrt, expr e)
  | Ast.F64_ceil e -> Unary (Float64 F64Op.Ceil, expr e)
  | Ast.F64_floor e -> Unary (Float64 F64Op.Floor, expr e)
  | Ast.F64_trunc e -> Unary (Float64 F64Op.Trunc, expr e)
  | Ast.F64_nearest e -> Unary (Float64 F64Op.Nearest, expr e)

  | Ast.I32_add (e1, e2) -> Binary (Int32 I32Op.Add, expr e1, expr e2)
  | Ast.I32_sub (e1, e2) -> Binary (Int32 I32Op.Sub, expr e1, expr e2)
  | Ast.I32_mul (e1, e2) -> Binary (Int32 I32Op.Mul, expr e1, expr e2)
  | Ast.I32_div_s (e1, e2) -> Binary (Int32 I32Op.DivS, expr e1, expr e2)
  | Ast.I32_div_u (e1, e2) -> Binary (Int32 I32Op.DivU, expr e1, expr e2)
  | Ast.I32_rem_s (e1, e2) -> Binary (Int32 I32Op.RemS, expr e1, expr e2)
  | Ast.I32_rem_u (e1, e2) -> Binary (Int32 I32Op.RemU, expr e1, expr e2)
  | Ast.I32_and (e1, e2) -> Binary (Int32 I32Op.And, expr e1, expr e2)
  | Ast.I32_or (e1, e2) -> Binary (Int32 I32Op.Or, expr e1, expr e2)
  | Ast.I32_xor (e1, e2) -> Binary (Int32 I32Op.Xor, expr e1, expr e2)
  | Ast.I32_shl (e1, e2) -> Binary (Int32 I32Op.Shl, expr e1, expr e2)
  | Ast.I32_shr_s (e1, e2) -> Binary (Int32 I32Op.ShrS, expr e1, expr e2)
  | Ast.I32_shr_u (e1, e2) -> Binary (Int32 I32Op.ShrU, expr e1, expr e2)
  | Ast.I32_rotl (e1, e2) -> Binary (Int32 I32Op.Rotl, expr e1, expr e2)
  | Ast.I32_rotr (e1, e2) -> Binary (Int32 I32Op.Rotr, expr e1, expr e2)
  | Ast.I64_add (e1, e2) -> Binary (Int64 I64Op.Add, expr e1, expr e2)
  | Ast.I64_sub (e1, e2) -> Binary (Int64 I64Op.Sub, expr e1, expr e2)
  | Ast.I64_mul (e1, e2) -> Binary (Int64 I64Op.Mul, expr e1, expr e2)
  | Ast.I64_div_s (e1, e2) -> Binary (Int64 I64Op.DivS, expr e1, expr e2)
  | Ast.I64_div_u (e1, e2) -> Binary (Int64 I64Op.DivU, expr e1, expr e2)
  | Ast.I64_rem_s (e1, e2) -> Binary (Int64 I64Op.RemS, expr e1, expr e2)
  | Ast.I64_rem_u (e1, e2) -> Binary (Int64 I64Op.RemU, expr e1, expr e2)
  | Ast.I64_and (e1, e2) -> Binary (Int64 I64Op.And, expr e1, expr e2)
  | Ast.I64_or (e1, e2) -> Binary (Int64 I64Op.Or, expr e1, expr e2)
  | Ast.I64_xor (e1, e2) -> Binary (Int64 I64Op.Xor, expr e1, expr e2)
  | Ast.I64_shl (e1, e2) -> Binary (Int64 I64Op.Shl, expr e1, expr e2)
  | Ast.I64_shr_s (e1, e2) -> Binary (Int64 I64Op.ShrS, expr e1, expr e2)
  | Ast.I64_shr_u (e1, e2) -> Binary (Int64 I64Op.ShrU, expr e1, expr e2)
  | Ast.I64_rotl (e1, e2) -> Binary (Int64 I64Op.Rotl, expr e1, expr e2)
  | Ast.I64_rotr (e1, e2) -> Binary (Int64 I64Op.Rotr, expr e1, expr e2)
  | Ast.F32_add (e1, e2) -> Binary (Float32 F32Op.Add, expr e1, expr e2)
  | Ast.F32_sub (e1, e2) -> Binary (Float32 F32Op.Sub, expr e1, expr e2)
  | Ast.F32_mul (e1, e2) -> Binary (Float32 F32Op.Mul, expr e1, expr e2)
  | Ast.F32_div (e1, e2) -> Binary (Float32 F32Op.Div, expr e1, expr e2)
  | Ast.F32_min (e1, e2) -> Binary (Float32 F32Op.Min, expr e1, expr e2)
  | Ast.F32_max (e1, e2) -> Binary (Float32 F32Op.Max, expr e1, expr e2)
  | Ast.F32_copysign (e1, e2) ->
    Binary (Float32 F32Op.CopySign, expr e1, expr e2)
  | Ast.F64_add (e1, e2) -> Binary (Float64 F64Op.Add, expr e1, expr e2)
  | Ast.F64_sub (e1, e2) -> Binary (Float64 F64Op.Sub, expr e1, expr e2)
  | Ast.F64_mul (e1, e2) -> Binary (Float64 F64Op.Mul, expr e1, expr e2)
  | Ast.F64_div (e1, e2) -> Binary (Float64 F64Op.Div, expr e1, expr e2)
  | Ast.F64_min (e1, e2) -> Binary (Float64 F64Op.Min, expr e1, expr e2)
  | Ast.F64_max (e1, e2) -> Binary (Float64 F64Op.Max, expr e1, expr e2)
  | Ast.F64_copysign (e1, e2) ->
    Binary (Float64 F64Op.CopySign, expr e1, expr e2)

  | Ast.I32_eqz e -> Test (Int32 I32Op.Eqz, expr e)
  | Ast.I64_eqz e -> Test (Int64 I64Op.Eqz, expr e)

  | Ast.I32_eq (e1, e2) -> Compare (Int32 I32Op.Eq, expr e1, expr e2)
  | Ast.I32_ne (e1, e2) -> Compare (Int32 I32Op.Ne, expr e1, expr e2)
  | Ast.I32_lt_s (e1, e2) -> Compare (Int32 I32Op.LtS, expr e1, expr e2)
  | Ast.I32_lt_u (e1, e2) -> Compare (Int32 I32Op.LtU, expr e1, expr e2)
  | Ast.I32_le_s (e1, e2) -> Compare (Int32 I32Op.LeS, expr e1, expr e2)
  | Ast.I32_le_u (e1, e2) -> Compare (Int32 I32Op.LeU, expr e1, expr e2)
  | Ast.I32_gt_s (e1, e2) -> Compare (Int32 I32Op.GtS, expr e1, expr e2)
  | Ast.I32_gt_u (e1, e2) -> Compare (Int32 I32Op.GtU, expr e1, expr e2)
  | Ast.I32_ge_s (e1, e2) -> Compare (Int32 I32Op.GeS, expr e1, expr e2)
  | Ast.I32_ge_u (e1, e2) -> Compare (Int32 I32Op.GeU, expr e1, expr e2)
  | Ast.I64_eq (e1, e2) -> Compare (Int64 I64Op.Eq, expr e1, expr e2)
  | Ast.I64_ne (e1, e2) -> Compare (Int64 I64Op.Ne, expr e1, expr e2)
  | Ast.I64_lt_s (e1, e2) -> Compare (Int64 I64Op.LtS, expr e1, expr e2)
  | Ast.I64_lt_u (e1, e2) -> Compare (Int64 I64Op.LtU, expr e1, expr e2)
  | Ast.I64_le_s (e1, e2) -> Compare (Int64 I64Op.LeS, expr e1, expr e2)
  | Ast.I64_le_u (e1, e2) -> Compare (Int64 I64Op.LeU, expr e1, expr e2)
  | Ast.I64_gt_s (e1, e2) -> Compare (Int64 I64Op.GtS, expr e1, expr e2)
  | Ast.I64_gt_u (e1, e2) -> Compare (Int64 I64Op.GtU, expr e1, expr e2)
  | Ast.I64_ge_s (e1, e2) -> Compare (Int64 I64Op.GeS, expr e1, expr e2)
  | Ast.I64_ge_u (e1, e2) -> Compare (Int64 I64Op.GeU, expr e1, expr e2)
  | Ast.F32_eq (e1, e2) -> Compare (Float32 F32Op.Eq, expr e1, expr e2)
  | Ast.F32_ne (e1, e2) -> Compare (Float32 F32Op.Ne, expr e1, expr e2)
  | Ast.F32_lt (e1, e2) -> Compare (Float32 F32Op.Lt, expr e1, expr e2)
  | Ast.F32_le (e1, e2) -> Compare (Float32 F32Op.Le, expr e1, expr e2)
  | Ast.F32_gt (e1, e2) -> Compare (Float32 F32Op.Gt, expr e1, expr e2)
  | Ast.F32_ge (e1, e2) -> Compare (Float32 F32Op.Ge, expr e1, expr e2)
  | Ast.F64_eq (e1, e2) -> Compare (Float64 F64Op.Eq, expr e1, expr e2)
  | Ast.F64_ne (e1, e2) -> Compare (Float64 F64Op.Ne, expr e1, expr e2)
  | Ast.F64_lt (e1, e2) -> Compare (Float64 F64Op.Lt, expr e1, expr e2)
  | Ast.F64_le (e1, e2) -> Compare (Float64 F64Op.Le, expr e1, expr e2)
  | Ast.F64_gt (e1, e2) -> Compare (Float64 F64Op.Gt, expr e1, expr e2)
  | Ast.F64_ge (e1, e2) -> Compare (Float64 F64Op.Ge, expr e1, expr e2)

  | Ast.I32_wrap_i64 e -> Convert (Int32 I32Op.WrapInt64, expr e)
  | Ast.I32_trunc_s_f32 e -> Convert (Int32 I32Op.TruncSFloat32, expr e)
  | Ast.I32_trunc_u_f32 e -> Convert (Int32 I32Op.TruncUFloat32, expr e)
  | Ast.I32_trunc_s_f64 e -> Convert (Int32 I32Op.TruncSFloat64, expr e)
  | Ast.I32_trunc_u_f64 e -> Convert (Int32 I32Op.TruncUFloat64, expr e)
  | Ast.I64_extend_s_i32 e -> Convert (Int64 I64Op.ExtendSInt32, expr e)
  | Ast.I64_extend_u_i32 e -> Convert (Int64 I64Op.ExtendUInt32, expr e)
  | Ast.I64_trunc_s_f32 e -> Convert (Int64 I64Op.TruncSFloat32, expr e)
  | Ast.I64_trunc_u_f32 e -> Convert (Int64 I64Op.TruncUFloat32, expr e)
  | Ast.I64_trunc_s_f64 e -> Convert (Int64 I64Op.TruncSFloat64, expr e)
  | Ast.I64_trunc_u_f64 e -> Convert (Int64 I64Op.TruncUFloat64, expr e)
  | Ast.F32_convert_s_i32 e -> Convert (Float32 F32Op.ConvertSInt32, expr e)
  | Ast.F32_convert_u_i32 e -> Convert (Float32 F32Op.ConvertUInt32, expr e)
  | Ast.F32_convert_s_i64 e -> Convert (Float32 F32Op.ConvertSInt64, expr e)
  | Ast.F32_convert_u_i64 e -> Convert (Float32 F32Op.ConvertUInt64, expr e)
  | Ast.F32_demote_f64 e -> Convert (Float32 F32Op.DemoteFloat64, expr e)
  | Ast.F64_convert_s_i32 e -> Convert (Float64 F64Op.ConvertSInt32, expr e)
  | Ast.F64_convert_u_i32 e -> Convert (Float64 F64Op.ConvertUInt32, expr e)
  | Ast.F64_convert_s_i64 e -> Convert (Float64 F64Op.ConvertSInt64, expr e)
  | Ast.F64_convert_u_i64 e -> Convert (Float64 F64Op.ConvertUInt64, expr e)
  | Ast.F64_promote_f32 e -> Convert (Float64 F64Op.PromoteFloat32, expr e)
  | Ast.I32_reinterpret_f32 e -> Convert (Int32 I32Op.ReinterpretFloat, expr e)
  | Ast.I64_reinterpret_f64 e -> Convert (Int64 I64Op.ReinterpretFloat, expr e)
  | Ast.F32_reinterpret_i32 e -> Convert (Float32 F32Op.ReinterpretInt, expr e)
  | Ast.F64_reinterpret_i64 e -> Convert (Float64 F64Op.ReinterpretInt, expr e)

  | Ast.Current_memory -> Host (CurrentMemory, [])
  | Ast.Grow_memory e -> Host (GrowMemory, [expr e])

and seq = function
  | [] -> Nop @@ Source.no_region
  | es ->
    let es', e = Lib.List.split_last es in
    Block (List.map expr es', expr e) @@@ List.map Source.at es

and block = function
  | [] -> Nop @@ Source.no_region
  | es ->
    let es', e = Lib.List.split_last es in
    Block (List.map label (List.map expr es'), label (expr e))
      @@@ List.map Source.at es


(* Functions and Modules *)

let rec global g = global' g.it @@ g.at
and global' = function
  | {Ast.gtype = t; value = e} -> {gtype = t; value = expr e}

let rec func f = func' f.it @@ f.at
and func' = function
  | {Ast.body = es; ftype; locals} -> {body = return (seq es); ftype; locals}

let rec segment seg = segment' seg.it @@ seg.at
and segment' = function
  | {index; Ast.offset = e; init} -> {index; offset = expr e; init}

let rec module_ m = module' m.it @@ m.at
and module' = function
  | {Ast.funcs = fs; start; globals = gs; memories; types; imports; exports; tables; elems; data} ->
    let globals = List.map global gs in
    let elems = List.map segment elems in
    let funcs = List.map func fs in
    let data = List.map segment data in
    {funcs; start; globals; memories; types; imports; exports; tables; elems; data}

let desugar = module_
