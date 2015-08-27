(*
 * (c) 2015 Andreas Rossberg
 *)

open Values
open Ast
open Source

let error = Error.error


(* Module Instances *)

type value = Values.value
type func = Ast.func

module ExportMap = Map.Make(String)
type export_map = func ExportMap.t

type module_instance =
{
  funcs : func list;
  exports : export_map;
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
  try List.nth list x.it with Failure _ ->
    error x.at ("runtime: undefined " ^ category ^ " " ^ string_of_int x.it)

let func c x = lookup "function" c.modul.funcs x
let global c x = lookup "global" c.modul.globals x
let table c x y = lookup "entry" (lookup "table" c.modul.tables x) y
let local c x = lookup "local" c.locals x
let label c x = lookup "label" c.labels x

let export m x =
  try ExportMap.find x.it m.exports
  with Not_found ->
    error x.at ("runtime: undefined export " ^ x.it)

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
    ("runtime: type error, expected " ^ Types.string_of_value_type t ^
      ", got " ^ Types.string_of_value_type (type_of v))

let unary vs at =
  match vs with
  | [v] -> v
  | [] -> error at "runtime: expression produced no value"
  | _ -> error at "runtime: expression produced multiple values"

let int32 v at =
  match unary v at with
  | Int32 i -> i
  | v -> type_error at v Types.Int32Type


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

  | Switch (_t, e1, arms, e2) ->
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

  | LoadGlobal x ->
    [!(global c x)]

  | StoreGlobal (x, e1) ->
    let v1 = unary (eval_expr c e1) e1.at in
    global c x := v1;
    []

  | Load ({align; mem; _}, e1) ->
    let v1 = unary (eval_expr c e1) e1.at in
    (try [Memory.load c.modul.memory align (Memory.address_of_value v1) mem]
    with exn -> memory_error e.at exn)

  | Store ({align; mem; _}, e1, e2) ->
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
  let locals = List.map (fun v -> ref v) vs @ List.map eval_decl f.it.locals in
  let c = {modul = m; locals; labels = []; return = Return.label} in
  try eval_expr c f.it.body
  with Return.Label vs -> vs


(* Modules *)

let init m =
  let {Ast.funcs; exports; tables; globals; memory} = m.it in
  let mem =
    match memory with
    | None -> Memory.create 0
    | Some {it = {initial; segments; _}} ->
      let mem = Memory.create initial in
      Memory.init mem (List.map it segments);
      mem
  in
  let func x = List.nth funcs x.it in
  let export ex = ExportMap.add ex.it.name (func ex.it.func) in
  let exports = List.fold_right export exports ExportMap.empty in
  let tables = List.map (fun tab -> List.map func tab.it) tables in
  let globals = List.map eval_decl globals in
  {funcs; exports; tables; globals; memory = mem}

let invoke m name vs =
  let f = export m (name @@ no_region) in
  eval_func m f vs

let eval e =
  let f = {params = []; results = []; locals = []; body = e} @@ no_region in
  let memory = Memory.create 0 in
  let exports = ExportMap.singleton "eval" f in
  let m = {funcs = [f]; exports; tables = []; globals = []; memory} in
  unary (eval_func m f []) e.at
