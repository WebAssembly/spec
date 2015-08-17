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
  locals : value_type list;
  params : value_type list;
  returns : expr_type;
  labels : expr_type list;
  tables : func_type list
}

let lookup category list x =
  try List.nth list x.it
  with Failure _ ->
    error x.at ("unknown " ^ category ^ " " ^ string_of_int x.it)

let func c x = lookup "function" c.funcs x
let param c x = lookup "parameter" c.params x
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

let type_dist = function
  | Near -> Int32Type
  | Far -> Int64Type

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
    | ToInt32S | ToInt32U -> error at "invalid conversion op Int32->Int32"
    | ToInt64S | ToInt64U -> Int32Type, Int64Type
    | ToFloat32S | ToFloat32U | ToFloatCast -> Int32Type, Float32Type
    | ToFloat64S | ToFloat64U -> Int32Type, Float64Type
    )
  | Values.Int64 cvt ->
    let open Int64Op in
    (match cvt with
    | ToInt32S | ToInt32U -> Int64Type, Int32Type
    | ToInt64S | ToInt64U -> error at "invalid conversion op Int64->Int64"
    | ToFloat32S | ToFloat32U -> Int64Type, Float32Type
    | ToFloat64S | ToFloat64U | ToFloatCast -> Int64Type, Float64Type
    )
  | Values.Float32 cvt ->
    let open Float32Op in
    (match cvt with
    | ToInt32S | ToInt32U | ToIntCast -> Float32Type, Int32Type
    | ToInt64S | ToInt64U -> Float32Type, Int64Type
    | ToFloat32 -> error at "invalid conversion op Float32->Float32"
    | ToFloat64 -> Float32Type, Float64Type
    )
  | Values.Float64 cvt ->
    let open Float64Op in
    (match cvt with
    | ToInt32S | ToInt32U -> Float64Type, Int32Type
    | ToInt64S | ToInt64U | ToIntCast -> Float64Type, Int64Type
    | ToFloat32 -> Float64Type, Float32Type
    | ToFloat64 -> error at "invalid conversion op Float64->Float64"
    )

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

  | Dispatch (x, e1, es) ->
    let {ins; outs} = table c x in
    check_expr c [Int32Type] e1;
    check_exprs c ins es;
    check_type outs ts e.at

  | Return es ->
    check_exprs c c.returns es

  | Destruct (xs, e1) ->
    check_expr c (List.map (local c) xs) e1;
    check_type [] ts e.at

  | GetParam x ->
    check_type [param c x] ts e.at

  | GetLocal x ->
    check_type [local c x] ts e.at

  | SetLocal (x, e1) ->
    check_expr c [local c x] e1;
    check_type [] ts e.at

  | GetGlobal x ->
    check_type [global c x] ts e.at

  | SetGlobal (x, e1) ->
    check_expr c [global c x] e1;
    check_type [] ts e.at

  | GetMemory (memop, e1) ->
    check_expr c [type_dist memop.dist] e1;
    check_type [type_mem memop.mem] ts e.at

  | SetMemory (memop, e1, e2) ->
    check_expr c [type_dist memop.dist] e1;
    check_expr c [type_mem memop.mem] e2;
    check_type [] ts e.at

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
  let c' = {c with locals = List.map it locals;
                   params = List.map it params;
                  returns = List.map it results} in
  check_expr c' (List.map it results) e

let check_table c table =
  match table.it with
  | [] ->
    error table.at "empty table"
  | x::xs ->
    let s = func c x in
    List.iter (fun xI -> check_func_type (func c xI) s xI.at) xs;
    {c with tables = c.tables @ [s]}

let check_export c x =
  ignore (func c x)

let check_module m =
  let {funcs; exports; tables; globals; memory; data} = m.it in
  require (fst memory >= Int64.of_int (String.length data)) m.at
    "data section does not fit memory";
  let c =
    {
      funcs = List.map type_func funcs;
      globals = List.map it globals;
      locals = [];
      params = [];
      returns = [];
      tables = [];
      labels = []
    }
  in
  let c' = List.fold_left check_table c tables in
  List.iter (check_func c') funcs;
  List.iter (check_export c') exports
