(*
 * (c) 2015 Andreas Rossberg
 *)

open Ast
open Source
open Types


(* Errors *)

let error = Error.error
let require b at s = if not b then error at s


(* Context *)

type context =
{
  funcs : func_type list;
  globals : value_type list;
  tables : func_type list;
  locals : value_type list;
  returns : expr_type;
  labels : expr_type list
}

let c0 =
  {funcs = []; globals = []; tables = [];
   locals = []; returns = []; labels = []} 

let lookup category list x =
  try List.nth list x.it with Failure _ ->
    error x.at ("unknown " ^ category ^ " " ^ string_of_int x.it)

let func c x = lookup "function" c.funcs x
let local c x = lookup "local" c.locals x
let global c x = lookup "global" c.globals x
let table c x = lookup "table" c.tables x
let label c x = lookup "label" c.labels x


(* Type comparison *)

let check_type actual expected at =
  require (expected = [] || actual = expected) at
    ("type mismatch: expression has type " ^ string_of_expr_type actual ^
     " but the context requires " ^ string_of_expr_type expected)

let check_func_type actual expected at =
  require (actual = expected) at "inconsistent function type in table"

let nary = List.map (fun ty -> [ty])


(* Type Synthesis *)

let type_mem = function
  | Memory.SInt8Mem -> Int32Type
  | Memory.SInt16Mem -> Int32Type
  | Memory.SInt32Mem -> Int32Type
  | Memory.SInt64Mem -> Int64Type
  | Memory.UInt8Mem -> Int32Type
  | Memory.UInt16Mem -> Int32Type
  | Memory.UInt32Mem -> Int32Type
  | Memory.UInt64Mem -> Int64Type
  | Memory.Float32Mem -> Float32Type
  | Memory.Float64Mem -> Float64Type

let type_value = Values.type_of
let type_unop = Values.type_of
let type_binop = Values.type_of
let type_relop = Values.type_of

let type_cvt at = function
  | Values.Int32 cvt ->
    let open Int32Op in
    (match cvt with
    | ExtendSInt32 | ExtendUInt32 -> error at "invalid conversion"
    | WrapInt64 -> Int64Type
    | TruncSFloat32 | TruncUFloat32 | ReinterpretFloat -> Float32Type
    | TruncSFloat64 | TruncUFloat64 -> Float64Type
    ), Int32Type
  | Values.Int64 cvt ->
    let open Int64Op in
    (match cvt with
    | ExtendSInt32 | ExtendUInt32 -> Int32Type
    | WrapInt64 -> error at "invalid conversion"
    | TruncSFloat32 | TruncUFloat32 -> Float32Type
    | TruncSFloat64 | TruncUFloat64 | ReinterpretFloat -> Float64Type
    ), Int64Type
  | Values.Float32 cvt ->
    let open Float32Op in
    (match cvt with
    | ConvertSInt32 | ConvertUInt32 | ReinterpretInt -> Int32Type
    | ConvertSInt64 | ConvertUInt64 -> Int64Type
    | PromoteFloat32 -> error at "invalid conversion"
    | DemoteFloat64 -> Float64Type
    ), Float32Type
  | Values.Float64 cvt ->
    let open Float64Op in
    (match cvt with
    | ConvertSInt32 | ConvertUInt32 -> Int32Type
    | ConvertSInt64 | ConvertUInt64 | ReinterpretInt -> Int64Type
    | PromoteFloat32 -> Float32Type
    | DemoteFloat64 -> error at "invalid conversion"
    ), Float64Type

let type_func f =
  let {params; results; _} = f.it in
  {ins = List.map it params; outs = List.map it results}


(* Type Analysis *)

(*
 * check_expr : context -> expr -> expr_type -> unit
 *
 * Conventions:
 *   c : context
 *   e : expr
 *   v : value
 *   t : value_type
 *)

let rec check_expr c ts e =
  match e.it with
  | Nop ->
    check_type [] ts e.at

  | Block es ->
    require (es <> []) e.at "invalid block";
    let es', eN = Lib.List.split_last es in
    List.iter (check_expr c []) es';
    check_expr c ts eN

  | If (e1, e2, e3) ->
    check_expr c [Int32Type] e1;
    check_expr c ts e2;
    check_expr c ts e3

  | Loop e1 ->
    check_expr c [] e1

  | Label e1 ->
    let c' = {c with labels = ts :: c.labels} in
    check_expr c' ts e1

  | Break (x, es) ->
    check_exprs c (label c x) es

  | Switch (t, e1, arms, e2) ->
    require (t.it = Int32Type || t.it = Int64Type) t.at "invalid switch type";
    (* TODO: Check that cases are unique. *)
    check_expr c [t.it] e1;
    List.iter (check_arm c t.it ts) arms;
    check_expr c ts e2

  | Call (x, es) ->
    let {ins; outs} = func c x in
    check_exprs c ins es;
    check_type outs ts e.at

  | CallIndirect (x, e1, es) ->
    let {ins; outs} = table c x in
    check_expr c [Int32Type] e1;
    check_exprs c ins es;
    check_type outs ts e.at

  | Return es ->
    check_exprs c c.returns es

  | Destruct (xs, e1) ->
    check_expr c (List.map (local c) xs) e1;
    check_type [] ts e.at

  | GetLocal x ->
    check_type [local c x] ts e.at

  | SetLocal (x, e1) ->
    check_expr c [local c x] e1;
    check_type [local c x] ts e.at

  | LoadGlobal x ->
    check_type [global c x] ts e.at

  | StoreGlobal (x, e1) ->
    check_expr c [global c x] e1;
    check_type [global c x] ts e.at

  | Load (memop, e1) ->
    check_memop memop e.at;
    check_expr c [Int32Type] e1;
    check_type [type_mem memop.mem] ts e.at

  | Store (memop, e1, e2) ->
    check_memop memop e.at;
    check_expr c [Int32Type] e1;
    check_expr c [memop.ty] e2;
    check_type [memop.ty] ts e.at

  | Const v ->
    check_literal c ts v

  | Unary (unop, e1) ->
    let t = type_unop unop in
    check_expr c [t] e1;
    check_type [t] ts e.at

  | Binary (binop, e1, e2) ->
    let t = type_binop binop in
    check_expr c [t] e1;
    check_expr c [t] e2;
    check_type [t] ts e.at

  | Compare (relop, e1, e2) ->
    let t = type_relop relop in
    check_expr c [t] e1;
    check_expr c [t] e2;
    check_type [Int32Type] ts e.at

  | Convert (cvt, e1) ->
    let t1, t = type_cvt e.at cvt in
    check_expr c [t1] e1;
    check_type [t] ts e.at

and check_exprs c ts = function
  | [e] ->
    check_expr c ts e
  | es ->
    try List.iter2 (check_expr c) (nary ts) es
    with Invalid_argument _ -> error (Source.ats es) "arity mismatch"

and check_literal c ts l =
    check_type [type_value l.it] ts l.at

and check_arm c t ts arm =
  let {value = l; expr = e; fallthru} = arm.it in
  check_literal c [t] l;
  check_expr c (if fallthru then [] else ts) e

and check_memop {ty; mem; align} at =
  require (Lib.Int.is_power_of_two align) at "non-power-of-two alignment";
  let open Memory in
  match mem, ty with
  | (SInt8Mem | SInt16Mem | SInt32Mem), Int32Type
  | (UInt8Mem | UInt16Mem | UInt32Mem), Int32Type
  | (SInt8Mem | SInt16Mem | SInt32Mem | SInt64Mem), Int64Type
  | (UInt8Mem | UInt16Mem | UInt32Mem | UInt64Mem), Int64Type
  | Float32Mem, Float32Type
  | Float64Mem, Float64Type -> ()
  | _ -> error at "type-inconsistent memory operator"


(*
 * check_func : context -> func -> unit
 * check_module : context -> modul -> unit
 *
 * Conventions:
 *   c : context
 *   m : modul
 *   f : func
 *   e : expr
 *   v : value
 *   t : value_type
 *   s : func_type
 *)

let check_func c f =
  let {params; results; locals; body = e} = f.it in
  let c' = {c with locals = List.map it params @ List.map it locals;
                  returns = List.map it results} in
  check_expr c' (List.map it results) e

let check_table c tab =
  match tab.it with
  | [] ->
    error tab.at "empty table"
  | x::xs ->
    let s = func c x in
    List.iter (fun xI -> check_func_type (func c xI) s xI.at) xs;
    {c with tables = c.tables @ [s]}

module NameSet = Set.Make(String)

let check_export c set ex =
  let {name; func = x} = ex.it in
  ignore (func c x);
  require (not (NameSet.mem name set)) ex.at
    "duplicate export name";
  NameSet.add name set

let check_segment size prev_end seg =
  let seg_end = seg.it.Memory.addr + String.length seg.it.Memory.data in
  require (seg.it.Memory.addr >= prev_end) seg.at
    "data segment not disjoint and ordered";
  require (size >= seg_end) seg.at
    "data segment does not fit memory";
  seg_end

let check_memory memory =
  require (memory.it.initial <= memory.it.max) memory.at
    "initial memory size must be less than maximum";
  ignore (List.fold_left (check_segment memory.it.initial) 0 memory.it.segments)

let check_module m =
  let {funcs; exports; tables; globals; memory} = m.it in
  Lib.Option.app check_memory memory;
  let c = {c0 with funcs = List.map type_func funcs;
                 globals = List.map it globals} in
  let c' = List.fold_left check_table c tables in
  List.iter (check_func c') funcs;
  ignore (List.fold_left (check_export c') NameSet.empty exports)
