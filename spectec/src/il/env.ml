open Ast
open Util.Source


(* Errors *)

let phase = ref "validation"

let error at msg = Util.Error.error at !phase msg


(* Environment *)

module Set = Set.Make(String)
module Map = Map.Make(String)

type var_def = typ
type typ_def = param list * inst list
type rel_def = mixop * typ * rule list
type def_def = param list * typ * clause list
type gram_def = param list * typ * prod list

type t =
  { vars : var_def Map.t;
    typs : typ_def Map.t;
    defs : def_def Map.t;
    rels : rel_def Map.t;
    grams : gram_def Map.t;
  }


(* Operations *)

let empty =
  { vars = Map.empty;
    typs = Map.empty;
    defs = Map.empty;
    rels = Map.empty;
    grams = Map.empty;
  }

let mem map id = Map.mem id.it map

let find_opt map id =
  Map.find_opt id.it map

let find space map id =
  match find_opt map id with
  | None -> error id.at ("undeclared " ^ space)
  | Some t -> t

let bind _space map id rhs =
  if id.it = "_" then
    map
(* TODO(3, rossberg): reactivate?
  else if mem map id then
    error id.at ("duplicate declaration for " ^ space)
*)
  else
    Map.add id.it rhs map

let rebind _space map id rhs =
  assert (Map.mem id.it map);
  Map.add id.it rhs map

let mem_var env id = mem env.vars id
let mem_typ env id = mem env.typs id
let mem_def env id = mem env.defs id
let mem_rel env id = mem env.rels id
let mem_gram env id = mem env.grams id

let find_opt_var env id = find_opt env.vars id
let find_opt_typ env id = find_opt env.typs id
let find_opt_def env id = find_opt env.defs id
let find_opt_rel env id = find_opt env.rels id
let find_opt_gram env id = find_opt env.grams id

let find_var env id = find "variable" env.vars id
let find_typ env id = find "type" env.typs id
let find_def env id = find "definition" env.defs id
let find_rel env id = find "relation" env.rels id
let find_gram env id = find "grammar" env.grams id

let bind_var env id rhs = {env with vars = bind "variable" env.vars id rhs}
let bind_typ env id rhs = {env with typs = bind "type" env.typs id rhs}
let bind_def env id rhs = {env with defs = bind "definition" env.defs id rhs}
let bind_rel env id rhs = {env with rels = bind "relation" env.rels id rhs}
let bind_gram env id rhs = {env with grams = bind "grammar" env.grams id rhs}

let rebind_var env id rhs = {env with vars = rebind "variable" env.vars id rhs}
let rebind_typ env id rhs = {env with typs = rebind "type" env.typs id rhs}
let rebind_def env id rhs = {env with defs = rebind "definition" env.defs id rhs}
let rebind_rel env id rhs = {env with rels = rebind "relation" env.rels id rhs}
let rebind_gram env id rhs = {env with grams = rebind "grammar" env.grams id rhs}


(* Extraction *)

let rec env_of_def env d =
  match d.it with
  | TypD (id, ps, insts) -> bind_typ env id (ps, insts)
  | DecD (id, ps, t, clauses) -> bind_def env id (ps, t, clauses)
  | RelD (id, mixop, t, rules) -> bind_rel env id (mixop, t, rules)
  | GramD (id, ps, t, prods) -> bind_gram env id (ps, t, prods)
  | RecD ds -> List.fold_left env_of_def env ds
  | HintD _ -> env

let env_of_script ds =
  List.fold_left env_of_def empty ds
