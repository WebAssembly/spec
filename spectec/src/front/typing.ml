open Source
open Ast
open Print


(* Errors *)

let error at msg = Source.error at "type" msg


(* Environment *)

module Env = Map.Make(String)

type var_typ = typ
type syn_typ = deftyp
type rel_typ = typ
type def_typ = typ * typ

type env =
  { mutable vars : var_typ Env.t;
    mutable typs : syn_typ Env.t;
    mutable rels : rel_typ Env.t;
    mutable defs : def_typ Env.t;
  }

let new_env () =
  { vars = Env.empty;
    typs = Env.empty;
    rels = Env.empty;
    defs = Env.empty;
  }

let find space env' id =
  match Env.find_opt id.it env' with
  | None -> error id.at ("undeclared " ^ space ^ " `" ^ id.it ^ "`")
  | Some t -> t

let bind space env' id typ =
  if Env.mem id.it env' then
    error id.at ("duplicate declaration for " ^ space ^ " `" ^ id.it ^ "`")
  else
    Env.add id.it typ env'

let rebind space env' id typ =
  assert (Env.mem id.it env');
  Env.add id.it typ env'

let find_field fields atom at =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) fields with
  | Some (_, x, _) -> x
  | None -> error at ("unbound field `" ^ string_of_atom atom ^ "`")

let find_case cases atom at =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) cases with
  | Some (_, x, _) -> x
  | None -> error at ("unknown case `" ^ string_of_atom atom ^ "`")


(* Type Accessors *)

let rec expand' env = function
  | VarT id as typ' ->
    (match (find "syntax type" env.typs id).it with
    | AliasT typ1 -> expand' env typ1.it
    | StructT typfields -> StrT typfields
    | _ -> typ'
    )
  | TupT [] -> SeqT []
  | TupT [typ] -> expand' env typ.it
  | typ' -> typ'

let expand_singular' env typ' =
  match expand' env typ' with
  | IterT (typ1, (Opt | List | List1)) -> typ1.it
  | typ' -> typ'

let expand env typ = expand' env typ.it


let as_error at phrase typ expected =
  error at (
    phrase ^ "'s type `" ^ string_of_typ typ ^ "` " ^
    "does not match expected type `" ^ expected ^ "`"
  )

let as_list_typ phrase env typ at : typ =
  match expand' env typ.it with
  | IterT (typ1, (List | List1 | ListN _)) -> typ1
  | _ -> as_error at phrase typ "(_)*"

let as_struct_typ phrase env typ at : typfield list =
  match expand_singular' env typ.it with
  | StrT fields -> fields
  | _ -> as_error at phrase typ "{...}"

let rec as_variant_typid' phrase env id at : typcase list =
  match (find "syntax type" env.typs id).it with
  | VariantT (ids, cases) ->
    List.concat (cases :: List.map (as_variant_typid "" env) ids)
  | _ -> as_error id.at phrase (VarT id @@ id.at) "| ..."

and as_variant_typid phrase env id : typcase list =
  as_variant_typid' phrase env id id.at

let as_variant_typ phrase env typ at : typcase list =
  match expand_singular' env typ.it with
  | VarT id -> as_variant_typid' phrase env id at
  | _ -> as_error at phrase typ "| ..."


let is_x_typ as_x_typ env typ =
  try ignore (as_x_typ "" env typ no_region); true
  with Error _ -> false

let is_variant_typ = is_x_typ as_variant_typ


(* Type Matching *)

let match_iter env iter1 iter2 =
  match iter1, iter2 with
  | _, List -> true
  | Opt, List1 -> true
  | _, _ -> Eq.eq_iter iter1 iter2

let rec match_typ' env typ1 typ2 =
  (*
  Printf.printf "[match] (%s) <: (%s)  >>  (%s) <: (%s)\n%!"
    (string_of_typ typ1) (string_of_typ typ2)
    (string_of_typ (expand env typ1 @@ typ1.at))
    (string_of_typ (expand env typ2 @@ typ2.at));
  *)
  match expand env typ1, expand env typ2 with
  | typ1', typ2' when Eq.eq_typ (typ1' @@ typ1.at) (typ2' @@ typ2.at) ->
    true
  | SeqT [typ11], _ ->
    match_typ' env typ11 typ2
  | _, SeqT [typ21] ->
    match_typ' env typ1 typ21
  | SeqT [], SeqT (typ21::typs2) ->
    match_typ' env typ1 typ21 &&
    match_typ' env typ1 (SeqT typs2 @@ typ2.at)
  | SeqT (typ11::typs1), SeqT (typ21::typs2) ->
    match_typ' env typ11 typ21 &&
    match_typ' env (SeqT typs1 @@ typ1.at) (SeqT typs2 @@ typ2.at)
  | AtomT atom, _ when is_variant_typ env typ2 ->
    let cases = as_variant_typ "" env typ2 typ1.at in
    (try
      let typs2 = find_case cases atom typ1.at in
      match_typ' env (SeqT [] @@ typ1.at) (SeqT typs2 @@ typ2.at)
    with Source.Error _ -> false)
  | SeqT ({it = AtomT atom; at} :: typs1), _ when is_variant_typ env typ2 ->
    let cases = as_variant_typ "" env typ2 at in
    (try
      let typs2 = find_case cases atom at in
      match_typ' env (SeqT typs1 @@ typ1.at) (SeqT typs2 @@ typ2.at)
    with Source.Error _ -> false)
  | _, _ when is_variant_typ env typ1 && is_variant_typ env typ2 ->
    let cases1 = as_variant_typ "" env typ1 typ2.at in
    let cases2 = as_variant_typ "" env typ2 typ1.at in
    List.for_all (fun (atom, typs1, _) ->
      try
        let typs2 = find_case cases2 atom typ1.at in
        match_typ' env (SeqT typs1 @@ typ1.at) (SeqT typs2 @@ typ2.at)
      with Source.Error _ -> false
    ) cases1
  | SeqT [], IterT (_, (Opt | List)) ->
    true
  | SeqT (typ11::typs12), IterT (_, (List | List1)) ->
    match_typ' env typ11 typ2 &&
    match_typ' env (SeqT typs12 @@ typ1.at) typ2
  | IterT (typ11, iter1), IterT (typ21, iter2) ->
    match_typ' env typ11 typ21 && match_iter env iter1 iter2 ||
    match_typ' env typ1 typ21
  | _, IterT (typ21, (Opt | List | List1)) ->
    match_typ' env typ1 typ21
  | TupT typs1, TupT typs2 ->
    match_typs env typs1 typs2
  | RelT (typ11, relop1, typ12), RelT (typ21, relop2, typ22) ->
    match_typ' env typ11 typ21 && relop1 = relop2 && match_typ' env typ12 typ22
  | BrackT (brackop1, typs1), BrackT (brackop2, typs2) ->
    brackop1 = brackop2 && match_typs env typs1 typs2
  | _, _ ->
    false

and match_typs env typs1 typs2 =
  List.length typs1 = List.length typs2 &&
  List.for_all2 (match_typ' env) typs1 typs2

let match_typ phrase env typ1 typ2 at =
  if not (match_typ' env typ1 typ2) then
    error at (
      phrase ^ "'s type `" ^ string_of_typ typ1 ^
    "` does not match expected type `" ^ string_of_typ typ2 ^ "`"
    )



(* Operators *)

let check_unop = function
  | NotOp -> BoolT
  | PlusOp | MinusOp -> NatT

let check_binop = function
  | AndOp | OrOp | ImplOp -> BoolT
  | AddOp | SubOp | MulOp | DivOp | ExpOp -> NatT

let check_cmpop = function
  | EqOp | NeOp -> VarT ("(any)" @@ no_region)
  | LtOp | GtOp | LeOp | GeOp -> NatT


(* Iteration *)

let rec check_iter env iter =
  match iter with
  | Opt | List | List1 -> ()
  | ListN exp ->
    let typ = check_exp env exp in
    match_typ "iterator" env typ (NatT @@ exp.at) exp.at


(* Types *)

and check_typ env typ =
  match typ.it with
  | VarT id ->
    ignore (find "syntax type" env.typs id)
  | AtomT _
  | BoolT
  | NatT
  | TextT ->
    ()
  | SeqT typs ->
    List.iter (check_typ env) typs
  | StrT typfields ->
    List.iter (check_typfield env) typfields
    (* TODO: check for duplicates *)
  | TupT typs ->
    List.iter (check_typ env) typs
  | RelT (typ1, relop, typ2) ->
    check_typ env typ1;
    check_typ env typ2
  | BrackT (brackop, typs) ->
    List.iter (check_typ env) typs
  | IterT (typ1, iter) ->
    check_typ env typ1;
    check_iter env iter;
    match iter with
    | ListN exp -> error exp.at "definite iterator not allowed in type"
    | _ -> ()

and check_deftyp env deftyp =
  match deftyp.it with
  | AliasT typ ->
    check_typ env typ
  | StructT typfields ->
    List.iter (check_typfield env) typfields
    (* TODO: check for duplicate atoms *)
  | VariantT (ids, cases) ->
    let _casess = List.map (as_variant_typid "parent" env) ids in
    List.iter (check_typcase env) cases
    (* TODO: check for duplicate atoms *)


and check_typfield env (atom, typ, _hints) =
  check_typ env typ

and check_typcase env (atom, typs, _hints) =
  List.iter (check_typ env) typs


(* Expressions *)

and prefix_id id =
  match String.index_opt id.it '_', String.index_opt id.it '\'' with
  | None, None -> id
  | None, Some n | Some n, None -> String.sub id.it 0 n @@ id.at
  | Some n1, Some n2 -> String.sub id.it 0 (min n1 n2) @@ id.at

and check_exp env exp : typ =
  (*
  Printf.printf "[check %s] (%s)\n%!"
    (string_of_region exp.at) (string_of_exp exp);
  *)
  match exp.it with
  | VarE id -> find "variable" env.vars (prefix_id id)
  | AtomE atom -> AtomT atom @@ exp.at
  | BoolE bool -> BoolT @@ exp.at
  | NatE nat -> NatT @@ exp.at
  | TextE text -> TextT @@ exp.at
  | UnE (unop, exp1) ->
    let typ1 = check_exp env exp1 in
    let typ = check_unop unop @@ exp.at in
    match_typ "unary operator" env typ1 typ exp.at;
    typ
  | BinE (exp1, binop, exp2) ->
    let typ1 = check_exp env exp1 in
    let typ2 = check_exp env exp2 in
    let typ = check_binop binop @@ exp.at in
    match_typ "binary operator left operand" env typ1 typ exp.at;
    match_typ "binary operator right operand" env typ2 typ exp.at;
    typ
  | CmpE (exp1, cmpop, exp2) ->
    let typ1 = check_exp env exp1 in
    let typ2 = check_exp env exp2 in
    let typ =
      match check_cmpop cmpop with
      | VarT {it = "(any)"; _} -> typ1
      | typ' -> typ' @@ exp.at
    in
    match_typ "binary operator left operand" env typ1 typ exp.at;
    let typ3 =
      match exp2.it with
      | CmpE (exp21, _, _) -> check_exp env exp21
      | _ -> typ2
    in
    match_typ "binary operator right operand" env typ3 typ exp.at;
    BoolT @@ exp.at
  | SeqE exps ->
    let typs = List.map (check_exp env) exps in
    SeqT typs @@ exp.at
  | IdxE (exp1, exp2) ->
    let typ1 = check_exp env exp1 in
    let typ = as_list_typ "expression" env typ1 exp1.at in
    let typ2 = check_exp env exp2 in
    match_typ "index" env typ2 (NatT @@ exp2.at) exp2.at;
    typ
  | SliceE (exp1, exp2, exp3) ->
    let typ1 = check_exp env exp1 in
    let _ = as_list_typ "expression" env typ1 exp1.at in
    let typ2 = check_exp env exp2 in
    let typ3 = check_exp env exp3 in
    match_typ "index" env typ2 (NatT @@ exp2.at) exp2.at;
    match_typ "length" env typ3 (NatT @@ exp3.at) exp3.at;
    typ1
  | UpdE (exp1, path, exp2) ->
    let typ1 = check_exp env exp1 in
    let typ = as_list_typ "expression" env typ1 exp1.at in
    let typ2' = check_path env typ path in
    let typ2 = check_exp env exp2 in
    match_typ "element" env typ2 typ2' exp.at;
    typ1
  | ExtE (exp1, path, exp2) ->
    let typ1 = check_exp env exp1 in
    let typ = as_list_typ "expression" env typ1 exp1.at in
    let typ2' = check_path env typ path in
    let _ = as_list_typ "path" env typ2' path.at in
    let typ2 = check_exp env exp2 in
    match_typ "element" env typ2 typ2' exp.at;
    typ1
  | StrE expfields ->
    let typfields = List.map (check_expfield env) expfields in
    (* TODO: check for duplicates *)
    StrT typfields @@ exp.at
  | DotE (exp1, atom) ->
    let typ1 = check_exp env exp1 in
    let typfields = as_struct_typ "expression" env typ1 exp1.at in
    find_field typfields atom exp.at
  | CommaE (exp1, exp2) ->
    let typ1 = check_exp env exp1 in
    let typ2 = check_exp env exp2 in
    let typfields = as_struct_typ "expression" env typ1 exp1.at in
    (* TODO: this is a bit of a hack *)
    (match typ2.it with
    | SeqT ({it = AtomT atom; at} :: typs2) ->
      let typ2' = find_field typfields atom at in
      match_typ "element" env (SeqT typs2 @@ at) typ2' exp.at
    | _ ->
      match_typ "right operand" env typ2 typ1 exp.at
    );
    typ1
  | CompE (exp1, exp2) ->
    let typ1 = check_exp env exp1 in
    let typ2 = check_exp env exp2 in
    match_typ "right operand" env typ2 typ1 exp.at;
    typ1
  | LenE exp1 ->
    let typ1 = check_exp env exp1 in
    let _ = as_list_typ "expression" env typ1 exp1.at in
    NatT @@ exp.at
  | TupE exps ->
    let typs = List.map (check_exp env) exps in
    TupT typs @@ exp.at
  | CallE (id, exp2) ->
    let typ2 = check_exp env exp2 in
    let typ2', typ = find "function" env.defs id in
    match_typ "expression" env typ2 typ2' exp.at;
    typ
  | RelE (exp1, relop, exp2) ->
    let typ1 = check_exp env exp1 in
    let typ2 = check_exp env exp2 in
    RelT (typ1, relop, typ2) @@ exp.at
  | BrackE (brackop, exps) ->
    let typs = List.map (check_exp env) exps in
    BrackT (brackop, typs) @@ exp.at
  | IterE (exp1, iter) ->
    let typ1 = check_exp env exp1 in
    check_iter env iter;
    let iter' =
      match iter with
      | ListN _ -> List
      | iter' -> iter'
    in
    IterT (typ1, iter') @@ exp.at
  | HoleE ->
    error exp.at "misplaced hole"
  | CatE _ ->
    error exp.at "misplaced token concatenation"

and check_expfield env (atom, exp) : typfield =
  let typ = check_exp env exp in
  (atom, typ, [])

and check_path env typ path : typ =
  match path.it with
  | RootP -> typ
  | IdxP (path1, exp2) ->
    let typ1 = check_path env typ path1 in
    let typ2 = check_exp env exp2 in
    match_typ "index" env typ2 (NatT @@ exp2.at) exp2.at;
    as_list_typ "path" env typ1 path1.at
  | DotP (path1, atom) ->
    let typ1 = check_path env typ path1 in
    let typfields = as_struct_typ "path" env typ1 path1.at in
    find_field typfields atom path1.at


(* Definitions *)

let check_prem env prem =
  match prem.it with
  | RulePr (id, exp, iter_opt) ->
    let typ = check_exp env exp in
    let typ' = find "relation" env.rels id in
    match_typ "premise" env typ typ' exp.at;
    Option.iter (check_iter env) iter_opt
  | IffPr exp ->
    let typ = check_exp env exp in
    match_typ "condition" env typ (BoolT @@ exp.at) exp.at;
  | ElsePr ->
    ()


let infer_def env def =
  match def.it with
  | SynD (id, _, _) ->
    let dummy = AliasT (VarT ("(pre)" @@ def.at) @@ def.at) @@ def.at in
    env.typs <- bind "syntax" env.typs id dummy
  | _ -> ()

let check_def env def =
  match def.it with
  | SynD (id, deftyp, hints) ->
    check_deftyp env deftyp;
    env.typs <- rebind "syntax" env.typs id deftyp;
    env.vars <- bind "variable" env.vars id (VarT id @@ id.at)
  | RelD (id, typ, hints) ->
    check_typ env typ;
    env.rels <- bind "relation" env.rels id typ
  | RuleD (id, ids, exp, prems) ->
    let typ = check_exp env exp in
    let typ' = find "relation" env.rels id in
    match_typ "rule" env typ typ' exp.at;
    List.iter (check_prem env) prems
  | VarD (id, typ, hints) ->
    check_typ env typ;
    env.vars <- bind "variable" env.vars id typ
  | DecD (id, exp1, typ2, hints) ->
    let typ1 = check_exp env exp1 in
    check_typ env typ2;
    env.defs <- bind "function" env.defs id (typ1, typ2)
  | DefD (id, exp1, exp2) ->
    (* TODO: check no free variables *)
    let typ1 = check_exp env exp1 in
    let typ2 = check_exp env exp2 in
    let typ1', typ2' = find "function" env.defs id in
    match_typ "argument" env typ1 typ1' exp1.at;
    match_typ "result" env typ2 typ2' exp2.at


(* Scripts *)

let check defs =
  let env = new_env () in
  List.iter (infer_def env) defs;
  List.iter (check_def env) defs
