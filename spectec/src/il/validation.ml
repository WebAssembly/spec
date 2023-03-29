open Util
open Source
open Ast
open Print


(* Errors *)

let error at msg = Source.error at "type" msg


(* Environment *)

module Env = Map.Make(String)

type var_typ = typ
type syn_typ = deftyp
type rel_typ = typmix
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

let fwd_deftyp id = NotationT ([[]; []], VarT (id $ no_region) $ no_region)
let fwd_deftyp_bad = fwd_deftyp "(undefined)" $ no_region
let fwd_deftyp_ok = fwd_deftyp "(forward)" $ no_region

let find space env' id =
  match Env.find_opt id.it env' with
  | None -> error id.at ("undeclared " ^ space ^ " `" ^ id.it ^ "`")
  | Some t -> t

let bind space env' id typ =
  if Env.mem id.it env' then
    error id.at ("duplicate declaration for " ^ space ^ " `" ^ id.it ^ "`")
  else
    Env.add id.it typ env'

let rebind _space env' id typ =
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
    | NotationT ([[]; []], typ1) -> expand' env typ1.it
    | _ -> typ'
    )
  | typ' -> typ'

let expand env typ = expand' env typ.it


type direction = Infer | Check

let as_error at phrase dir typ expected =
  match dir with
  | Infer ->
    error at (
      phrase ^ "'s type `" ^ string_of_typ typ ^
      "` does not match expected type `" ^ expected ^ "`"
    )
  | Check ->
    error at (
      phrase ^ "'s type does not match expected type `" ^
      string_of_typ typ ^ "`"
    )

let match_iter iter1 iter2 =
  iter2 = List || Eq.eq_iter iter1 iter2

let as_iter_typ iter phrase env dir typ at : typ =
  match expand' env typ.it with
  | IterT (typ1, iter2) when match_iter iter iter2 -> typ1
  | _ -> as_error at phrase dir typ ("(_)" ^ string_of_iter iter)

let as_list_typ phrase env dir typ at : typ =
  match expand' env typ.it with
  | IterT (typ1, (List | List1 | ListN _)) -> typ1
  | _ -> as_error at phrase dir typ "(_)*"

let as_tup_typ phrase env dir typ at : typ list =
  match expand' env typ.it with
  | TupT typs -> typs
  | _ -> as_error at phrase dir typ "(_,...,_)"


let as_mix_typid phrase env id at : mixop * typ =
  match (find "syntax type" env.typs id).it with
  | NotationT (mixop, typ) -> mixop, typ
  | _ -> as_error at phrase Infer (VarT id $ id.at) "`mixin-op`(...)"

let as_mix_typ phrase env dir typ at : mixop * typ =
  match expand' env typ.it with
  | VarT id -> as_mix_typid phrase env id at
  | _ -> as_error at phrase dir typ ("`mixin-op`(...)")

let as_struct_typid phrase env id at : typfield list =
  match (find "syntax type" env.typs id).it with
  | StructT fields -> fields
  | _ -> as_error at phrase Infer (VarT id $ id.at) "{...}"

let as_struct_typ phrase env dir typ at : typfield list =
  match expand' env typ.it with
  | VarT id -> as_struct_typid phrase env id at
  | _ -> as_error at phrase dir typ "{...}"

let rec as_variant_typid phrase env id at : typcase list =
  match (find "syntax type" env.typs id).it with
  | VariantT (ids, cases) ->
    List.concat (cases :: List.map (fun id -> as_variant_typid "" env id at) ids)
  | _ -> as_error at phrase Infer (VarT id $ id.at) "| ..."

let as_variant_typ phrase env dir typ at : typcase list =
  match expand' env typ.it with
  | VarT id -> as_variant_typid phrase env id at
  | _ -> as_error at phrase dir typ "| ..."


(* Type Equivalence *)

let equiv_list equiv_x xs1 xs2 =
  List.length xs1 = List.length xs2 && List.for_all2 equiv_x xs1 xs2

let rec equiv_typ' env typ1 typ2 =
  (*
  Printf.printf "[equiv] (%s) == (%s)  eq=%b\n%!"
    (Print.string_of_typ typ1) (Print.string_of_typ typ2)
    (typ1.it = typ2.it);
  *)
  typ1.it = typ2.it ||
  match expand env typ1, expand env typ2 with
  | VarT id1, VarT id2 -> id1.it = id2.it
  | TupT typs1, TupT typs2 ->
    equiv_list (equiv_typ' env) typs1 typs2
  | IterT (typ11, iter1), IterT (typ21, iter2) ->
    equiv_typ' env typ11 typ21 && Eq.eq_iter iter1 iter2
  | typ1', typ2' ->
    Eq.eq_typ (typ1' $ typ1.at) (typ2' $ typ2.at)

let equiv_typ env typ1 typ2 at =
  if not (equiv_typ' env typ1 typ2) then
    error at ("expression's type `" ^ string_of_typ typ1 ^ "` " ^
      "does not match expected type `" ^ string_of_typ typ2 ^ "`")


(* Operators *)

let infer_unop = function
  | NotOp -> BoolT
  | PlusOp | MinusOp -> NatT

let infer_binop = function
  | AndOp | OrOp | ImplOp | EquivOp -> BoolT
  | AddOp | SubOp | MulOp | DivOp | ExpOp -> NatT

let infer_cmpop = function
  | EqOp | NeOp -> None
  | LtOp | GtOp | LeOp | GeOp -> Some NatT


(* Atom Bindings *)

let check_atoms phrase item get_atom list at =
  let _, dups =
    List.fold_right (fun item (set, dups) ->
      let s = Print.string_of_atom (get_atom item) in
      Free.Set.(if mem s set then (set, s::dups) else (add s set, dups))
    ) list (Free.Set.empty, [])
  in
  if dups <> [] then
    error at (phrase ^ " contains duplicate " ^ item ^ "(s) `" ^
      String.concat "`, `" dups ^ "`")


(* Iteration *)

let valid_list valid_x_y env xs ys at =
  if List.length xs <> List.length ys then
    error at ("arity mismatch for expression list, expected " ^
      string_of_int (List.length ys) ^ ", got " ^ string_of_int (List.length xs));
  List.iter2 (valid_x_y env) xs ys


let rec valid_iter env iter =
  match iter with
  | Opt | List | List1 -> ()
  | ListN exp -> valid_exp env exp (NatT $ exp.at)


(* Types *)

and valid_typ env typ =
  match typ.it with
  | VarT id ->
    if find "syntax type" env.typs id = fwd_deftyp_bad then
      error typ.at ("invalid forward reference to syntax type `" ^ id.it ^ "`")
  | BoolT
  | NatT
  | TextT ->
    ()
  | TupT typs ->
    List.iter (valid_typ env) typs
  | IterT (typ1, iter) ->
    match iter with
    | ListN exp -> error exp.at "definite iterator not allowed in type"
    | _ -> valid_typ env typ1; valid_iter env iter

and valid_deftyp env deftyp =
  match deftyp.it with
  | NotationT typmix ->
    valid_typmix env typmix deftyp.at
  | StructT fields ->
    check_atoms "record" "field" (fun (atom, _, _) -> atom) fields deftyp.at;
    List.iter (valid_typfield env) fields
  | VariantT (ids, cases) ->
    List.iter (fun id ->
      let deftypI = find "syntax type" env.typs id in
      if deftypI = fwd_deftyp_ok || deftypI = fwd_deftyp_bad then
        error id.at ("invalid forward reference to syntax type `" ^ id.it ^ "`");
    ) ids;
    let casess = List.map (fun id -> as_variant_typid "parent" env id id.at) ids in
    let cases' = List.flatten (cases::casess) in
    check_atoms "variant" "case" (fun (atom, _, _) -> atom) cases' deftyp.at;
    List.iter (valid_typcase env) cases

and valid_typmix env (mixop, typ) at =
  let arity =
    match typ.it with
    | TupT typs -> List.length typs
    | _ -> 1
  in
  if List.length mixop <> arity + 1 then
    error at ("inconsistent arity in mixin notation, `" ^ string_of_mixop mixop ^
      "` applied to " ^ string_of_typ typ);
  valid_typ env typ

and valid_typfield env (_atom, typ, _hints) = valid_typ env typ
and valid_typcase env (_atom, typ, _hints) = valid_typ env typ


(* Expressions *)

and infer_exp env exp : typ =
  match exp.it with
  | VarE id -> find "variable" env.vars id
  | BoolE _ -> BoolT $ exp.at
  | NatE _ | LenE _ -> NatT $ exp.at
  | TextE _ -> TextT $ exp.at
  | UnE (unop, _) -> infer_unop unop $ exp.at
  | BinE (binop, _, _) -> infer_binop binop $ exp.at
  | CmpE _ -> BoolT $ exp.at
  | IdxE (exp1, _) ->
    as_list_typ "expression" env Infer (infer_exp env exp1) exp1.at
  | SliceE (exp1, _, _)
  | UpdE (exp1, _, _)
  | ExtE (exp1, _, _)
  | CompE (exp1, _) ->
    infer_exp env exp1
  | StrE _ -> error exp.at "cannot infer type of record"
  | DotE (exp1, atom) ->
    let typ1 = infer_exp env exp1 in
    let typfields = as_struct_typ "expression" env Infer typ1 exp1.at in
    find_field typfields atom exp1.at
  | TupE exps -> TupT (List.map (infer_exp env) exps) $ exp.at
  | CallE (id, _) -> snd (find "function" env.defs id)
  | MixE _ -> error exp.at "cannot infer type of mixin notation"
  | IterE (exp1, iter) ->
    let iter' = match iter with ListN _ -> List | iter' -> iter' in
    IterT (infer_exp env exp1, iter') $ exp.at
  | OptE _ -> error exp.at "cannot infer type of option"
  | ListE _ -> error exp.at "cannot infer type of list"
  | CatE _ -> error exp.at "cannot infer type of concatenation"
  | CaseE _ -> error exp.at "cannot infer type of case constructor"
  | SubE (_, _, typ) -> typ


and valid_exp env exp typ =
  (*
  Printf.printf "[valid %s] %s  :  %s\n%!"
    (string_of_region exp.at) (string_of_exp exp) (string_of_typ typ);
  *)
  match exp.it with
  | VarE _ | BoolE _ | NatE _ | TextE _ ->
    let typ' = infer_exp env exp in
    equiv_typ env typ' typ exp.at
  | UnE (unop, exp1) ->
    let typ' = infer_unop unop $ exp.at in
    valid_exp env exp1 typ';
    equiv_typ env typ' typ exp.at
  | BinE (binop, exp1, exp2) ->
    let typ' = infer_binop binop $ exp.at in
    valid_exp env exp1 typ';
    valid_exp env exp2 typ';
    equiv_typ env typ' typ exp.at
  | CmpE (cmpop, exp1, exp2) ->
    let typ' =
      match infer_cmpop cmpop with
      | Some typ' -> typ' $ exp.at
      | None -> infer_exp env exp1
    in
    valid_exp env exp1 typ';
    valid_exp env exp2 typ';
    equiv_typ env (BoolT $ exp.at) typ exp.at
  | IdxE (exp1, exp2) ->
    let typ1 = infer_exp env exp1 in
    let typ' = as_list_typ "expression" env Infer typ1 exp1.at in
    valid_exp env exp1 typ1;
    valid_exp env exp2 (NatT $ exp2.at);
    equiv_typ env typ' typ exp.at
  | SliceE (exp1, exp2, exp3) ->
    let _typ' = as_list_typ "expression" env Check typ exp1.at in
    valid_exp env exp1 typ;
    valid_exp env exp2 (NatT $ exp2.at);
    valid_exp env exp3 (NatT $ exp3.at)
  | UpdE (exp1, path, exp2) ->
    valid_exp env exp1 typ;
    let typ2 = valid_path env path typ in
    valid_exp env exp2 typ2
  | ExtE (exp1, path, exp2) ->
    valid_exp env exp1 typ;
    let typ2 = valid_path env path typ in
    let _typ21 = as_list_typ "path" env Check typ2 path.at in
    valid_exp env exp2 typ2
  | StrE expfields ->
    let typfields = as_struct_typ "record" env Check typ exp.at in
    valid_list valid_expfield env expfields typfields exp.at
  | DotE (exp1, atom) ->
    let typ1 = infer_exp env exp1 in
    valid_exp env exp1 typ1;
    let typfields = as_struct_typ "expression" env Infer typ1 exp1.at in
    let typ' = find_field typfields atom exp1.at in
    equiv_typ env typ' typ exp.at
  | CompE (exp1, exp2) ->
    let _ = as_struct_typ "record" env Check typ exp.at in
    valid_exp env exp1 typ;
    valid_exp env exp2 typ
  | LenE exp1 ->
    let typ1 = infer_exp env exp1 in
    let _typ11 = as_list_typ "expression" env Infer typ1 exp1.at in
    valid_exp env exp1 typ1;
    equiv_typ env (NatT $ exp.at) typ exp.at
  | TupE exps ->
    let typs = as_tup_typ "tuple" env Check typ exp.at in
    valid_list valid_exp env exps typs exp.at
  | CallE (id, exp2) ->
    let typ2, typ' = find "function" env.defs id in
    valid_exp env exp2 typ2;
    equiv_typ env typ' typ exp.at
  | MixE (mixop, exp) ->
    let typmix = as_mix_typ "mixin notation" env Check typ exp.at in
    valid_expmix env mixop exp typmix exp.at
  | IterE (exp1, iter) ->
    valid_iter env iter;
    let typ1 = as_iter_typ iter "iteration" env Check typ exp.at in
    valid_exp env exp1 typ1
  | OptE expo ->
    let typ1 = as_iter_typ Opt "option" env Check typ exp.at in
    Option.iter (fun exp1 -> valid_exp env exp1 typ1) expo
  | ListE exps ->
    let typ1 = as_iter_typ List "list" env Check typ exp.at in
    List.iter (fun expI -> valid_exp env expI typ1) exps
  | CatE (exp1, exp2) ->
    let _typ1 = as_iter_typ List "list" env Check typ exp.at in
    valid_exp env exp1 typ;
    valid_exp env exp2 typ
  | CaseE (atom, exp) ->
    let cases = as_variant_typ "" env Check typ exp.at in
    let typ' = find_case cases atom exp.at in
    valid_exp env exp typ'
  | SubE (exp1, typ1, typ2) ->
    valid_typ env typ1;
    valid_typ env typ2;
    valid_exp env exp1 typ1;
    equiv_typ env typ2 typ exp.at

and valid_expmix env mixop exp (mixop', typ) at =
  if mixop <> mixop' then
    error at (
      "mixin notation `" ^ string_of_mixop mixop ^
      "` does not match expected notation `" ^ string_of_mixop mixop' ^ "`"
    );
  valid_exp env exp typ

and valid_expfield env (atom1, exp) (atom2, typ, _) =
  if atom1 <> atom2 then error exp.at "unexpected record field";
  valid_exp env exp typ

and valid_path env path typ : typ =
  match path.it with
  | RootP -> typ
  | IdxP (path1, exp2) ->
    let typ1 = valid_path env path1 typ in
    valid_exp env exp2 (NatT $ exp2.at);
    as_list_typ "path" env Check typ1 path1.at
  | DotP (path1, atom) ->
    let typ1 = valid_path env path1 typ in
    let typfields = as_struct_typ "path" env Check typ1 path1.at in
    find_field typfields atom path1.at


(* Definitions *)

let valid_binds env binds =
  List.iter (fun (id, typ) ->
    valid_typ env typ;
    env.vars <- bind "variable" env.vars id typ
  ) binds

let valid_prem env prem =
  match prem.it with
  | RulePr (id, mixop, exp, iter_opt) ->
    valid_expmix env mixop exp (find "relation" env.rels id) exp.at;
    Option.iter (valid_iter env) iter_opt
  | IffPr (exp, iter_opt) ->
    valid_exp env exp (BoolT $ exp.at);
    Option.iter (valid_iter env) iter_opt
  | ElsePr ->
    ()

let valid_rule env typmix rule =
  match rule.it with
  | RuleD (_id, binds, mixop, exp, prems) ->
    valid_binds env binds;
    valid_expmix env mixop exp typmix exp.at;
    List.iter (valid_prem env) prems;
    env.vars <- Env.empty

let valid_clause env typ1 typ2 clause =
  match clause.it with
  | DefD (binds, exp1, exp2, prems) ->
    valid_binds env binds;
    valid_exp env exp1 typ1;
    valid_exp env exp2 typ2;
    List.iter (valid_prem env) prems;
    env.vars <- Env.empty


let infer_def env def =
  match def.it with
  | SynD (id, deftyp, _hints) ->
    let fwd_deftyp =
      match deftyp.it with NotationT _ -> fwd_deftyp_bad | _ -> fwd_deftyp_ok in
    env.typs <- bind "syntax" env.typs id fwd_deftyp
  | RelD (id, typmix, _rules, _hints) ->
    valid_typmix env typmix def.at;
    env.rels <- bind "relation" env.rels id typmix
  | DecD (id, typ1, typ2, _clauses, _hints) ->
    valid_typ env typ1;
    valid_typ env typ2;
    env.defs <- bind "function" env.defs id (typ1, typ2)
  | _ -> ()


type bind = {bind : 'a. string -> 'a Env.t -> id -> 'a -> 'a Env.t}

let rec valid_def {bind} env def =
  match def.it with
  | SynD (id, deftyp, _hints) ->
    valid_deftyp env deftyp;
    env.typs <- bind "syntax" env.typs id deftyp;
  | RelD (id, typmix, rules, _hints) ->
    valid_typmix env typmix def.at;
    List.iter (valid_rule env typmix) rules;
    env.rels <- bind "relation" env.rels id typmix
  | DecD (id, typ1, typ2, clauses, _hints) ->
    valid_typ env typ1;
    valid_typ env typ2;
    List.iter (valid_clause env typ1 typ2) clauses;
    env.defs <- bind "function" env.defs id (typ1, typ2)
  | RecD defs ->
    List.iter (infer_def env) defs;
    List.iter (valid_def {bind = rebind} env) defs;
    List.iter (fun def ->
      match (List.hd defs).it, def.it with
      | SynD _, SynD _
      | RelD _, RelD _
      | DecD _, DecD _ -> ()
      | _, _ ->
        error (List.hd defs).at (" " ^ string_of_region def.at ^
          ": invalid recurion between definitions of different sort")
    ) defs


(* Scripts *)

let valid defs =
  let env = new_env () in
  List.iter (valid_def {bind} env) defs
