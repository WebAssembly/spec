(*
 * (c) 2015 Andreas Rossberg
 *)

open Types
open Syntax
open Source

let error = Error.error


(* Module Instances *)

type value = Types.value
type func = Syntax.func

type module_instance =
{
  funcs : func list;
  exports : func list;
  tables : func list list;
  globals : value ref list;
  memory : Memory.t
}


(* Configurations *)

type label = value list -> exn

type config =
{
  modul : module_instance;
  locals : value ref list;
  labels : label list;
  return : label
}

let lookup category list x =
  try List.nth list x.it
  with Invalid_argument _ ->
    error x.at ("runtime: undefined " ^ category ^ " " ^ string_of_int x.it)

let export m x = lookup "export" m.exports x
let func c x = lookup "function" c.modul.funcs x
let global c x = lookup "global" c.modul.globals x
let table c x y = lookup "entry" (lookup "table" c.modul.tables x) y
let local c x = lookup "local" c.locals x
let label c x = lookup "label" c.labels x

module MakeLabel () =
struct
  exception Label of value list
  let label vs = Label vs
end


(* Type and memory errors *)

let memory_error at = function
  | Memory.Align -> error at "runtime: unaligned memory access"
  | Memory.Bounds -> error at "runtime: out of bounds memory access"
  | Memory.Address -> error at "runtime: illegal address value"
  | exn -> raise exn

let type_error at v t =
  error at
    ("runtime: type error, expected " ^ string_of_value_type t ^
      ", got " ^ string_of_value_type (type_of v))

let unary vs at =
  match vs with
  | [v] -> v
  | [] -> error at "runtime: expression produced no value"
  | _ -> error at "runtime: expression produced multiple values"

let int32 v at =
  match unary v at with
  | Int32 i -> i
  | v -> type_error at v Int32Type


(* Evaluation *)

(*
 * eval_expr : config -> expr -> value list
 *
 * Conventions:
 *   c : config
 *   e : expr
 *   v : value
 *)

let rec eval_expr c e =
  match e.it with
  | Nop ->
    []

  | Block es ->
    let es', eN = Lib.List.split_last es in
    List.iter (fun eI -> ignore (eval_expr c eI)) es';
    eval_expr c eN

  | If (e1, e2, e3) ->
    let i = int32 (eval_expr c e1) e1.at in
    eval_expr c (if i <> Int32.zero then e2 else e3)

  | Loop e1 ->
    ignore (eval_expr c e1);
    eval_expr c e

  | Label e1 ->
    let module L = MakeLabel () in
    let c' = {c with labels = L.label :: c.labels} in
    (try eval_expr c' e1 with L.Label vs -> vs)

  | Break (x, es) ->
    raise (label c x (eval_exprs c es))

  | Switch (e1, arms, e2) ->
    let v = unary (eval_expr c e1) e1.at in
    (match List.fold_left (eval_arm c v) `Seek arms with
    | `Seek | `Fallthru -> eval_expr c e2
    | `Done vs -> vs
    )

  | Call (x, es) ->
    let vs = eval_exprs c es in
    eval_func c.modul (func c x) vs

  | Dispatch (x, e1, es) ->
    let i = int32 (eval_expr c e1) e1.at in
    let vs = eval_exprs c es in
    eval_func c.modul (table c x (Int32.to_int i @@ e1.at)) vs

  | Return es ->
    raise (c.return (eval_exprs c es))

  | Destruct (xs, e1) ->
    let vs = eval_expr c e1 in
    List.iter2 (fun x v -> local c x := v) xs vs;
    []

  | GetLocal x ->
    [!(local c x)]

  | SetLocal (x, e1) ->
    let v1 = unary (eval_expr c e1) e1.at in
    local c x := v1;
    []

  | GetGlobal x ->
    [!(global c x)]

  | SetGlobal (x, e1) ->
    let v1 = unary (eval_expr c e1) e1.at in
    global c x := v1;
    []

  | GetMemory ({align; mem; _}, e1) ->
    let v1 = unary (eval_expr c e1) e1.at in
    (try [Memory.load c.modul.memory align (Memory.address_of_value v1) mem]
    with exn -> memory_error e.at exn)

  | SetMemory ({align; mem; _}, e1, e2) ->
    let v1 = unary (eval_expr c e1) e1.at in
    let v2 = unary (eval_expr c e2) e2.at in
    (try Memory.store c.modul.memory align (Memory.address_of_value v1) mem v2
    with exn -> memory_error e.at exn);
    []

  | Const v ->
    [v.it]

  | Unary (unop, e1) ->
    let v1 = unary (eval_expr c e1) e1.at in
    (try [Arithmetic.eval_unop unop v1]
    with Arithmetic.TypeError (_, v, t) -> type_error e1.at v t)

  | Binary (binop, e1, e2) ->
    let v1 = unary (eval_expr c e1) e1.at in
    let v2 = unary (eval_expr c e2) e2.at in
    (try [Arithmetic.eval_binop binop v1 v2]
    with Arithmetic.TypeError (i, v, t) ->
      type_error (if i = 1 then e1 else e2).at v t)

  | Compare (relop, e1, e2) ->
    let v1 = unary (eval_expr c e1) e1.at in
    let v2 = unary (eval_expr c e2) e2.at in
    (try [Int32 Int32.(if Arithmetic.eval_relop relop v1 v2 then one else zero)]
    with Arithmetic.TypeError (i, v, t) ->
      type_error (if i = 1 then e1 else e2).at v t)

  | Convert (cvt, e1) ->
    let v1 = unary (eval_expr c e1) e1.at in
    (try [Arithmetic.eval_cvt cvt v1]
    with Arithmetic.TypeError (_, v, t) -> type_error e1.at v t)

and eval_exprs c = function
  | [e] ->
    eval_expr c e
  | es ->
    List.concat (List.map (eval_expr c) es)

and eval_arm c v stage arm =
  let {value; expr = e; fallthru} = arm.it in
  match stage, v = value.it with
  | `Seek, true | `Fallthru, _ ->
    if fallthru
    then (ignore (eval_expr c e); `Fallthru)
    else `Done (eval_expr c e)
  | `Seek, false | `Done _, _ ->
    stage


(*
 * eval_func : modul -> func -> value list -> value list
 *
 * Conventions:
 *   c : config
 *   m : modul
 *   f : func
 *   e : expr
 *   v : value
 *)

and eval_decl t =
  ref (default_value t.it)

and eval_func m f vs =
  let module Return = MakeLabel () in
  let locals = List.map ref vs @ List.map eval_decl f.it.locals in
  let c = {modul = m; locals; labels = []; return = Return.label} in
  try eval_expr c f.it.body
  with Return.Label vs -> vs


(* Modules *)

let init m =
  let {Syntax.funcs; exports; tables; globals; memory = (n, _)} = m.it in
  {
    funcs = funcs;
    exports = List.map (fun x -> List.nth funcs x.it) exports;
    tables =
      List.map (fun t -> List.map (fun x -> List.nth funcs x.it) t.it) tables;
    globals = List.map eval_decl globals;
    memory = Memory.create (Int64.to_int n)
  }

let invoke m x vs =
  let f = export m (x @@ Source.no_region) in
  eval_func m f vs

let eval m e =
  let f = {params = []; results = []; locals = []; body = e} @@ Source.no_region
  in unary (eval_func m f []) e.at
