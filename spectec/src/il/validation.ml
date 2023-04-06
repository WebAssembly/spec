open Util
open Source
open Ast
open Print


(* Errors *)

let error at msg = Source.error at "type" msg


(* Environment *)

module Env = Map.Make(String)

type var_typ = typ * iter list
type syn_typ = deftyp
type rel_typ = mixop * typ
type def_typ = typ * typ

type env =
  { mutable vars : var_typ Env.t;
    mutable typs : syn_typ Env.t;
    mutable rels : rel_typ Env.t;
    mutable defs : def_typ Env.t;
    ctx : iter list;
  }

let new_env () =
  { vars = Env.empty;
    typs = Env.empty;
    rels = Env.empty;
    defs = Env.empty;
    ctx = [];
  }

let fwd_deftyp id = NotationT ([[]; []], VarT (id $ no_region) $ no_region)
let fwd_deftyp_bad = fwd_deftyp "(undefined)" $ no_region
let fwd_deftyp_ok = fwd_deftyp "(forward)" $ no_region

let find space env' id =
  match Env.find_opt id.it env' with
  | None -> error id.at ("undeclared " ^ space ^ " `" ^ id.it ^ "`")
  | Some t -> t

let bind space env' id t =
  if Env.mem id.it env' then
    error id.at ("duplicate declaration for " ^ space ^ " `" ^ id.it ^ "`")
  else
    Env.add id.it t env'

let rebind _space env' id t =
  assert (Env.mem id.it env');
  Env.add id.it t env'

let find_field fs atom at =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) fs with
  | Some (_, x, _) -> x
  | None -> error at ("unbound field `" ^ string_of_atom atom ^ "`")

let find_case cases atom at =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) cases with
  | Some (_, x, _) -> x
  | None -> error at ("unknown case `" ^ string_of_atom atom ^ "`")


let rec is_prefix ctx1 ctx2 =
  match ctx1, ctx2 with
  | [], _ -> true
  | _, [] -> false
  | iter1::ctx1', iter2::ctx2' ->
    Eq.eq_iter iter1 iter2 && is_prefix ctx1' ctx2'


(* Type Accessors *)

let rec expand' env = function
  | VarT id as t' ->
    (match (find "syntax type" env.typs id).it with
    | AliasT t1 -> expand' env t1.it
    | _ -> t'
    )
  | t' -> t'

let expand env t = expand' env t.it


type direction = Infer | Check

let as_error at phrase dir t expected =
  match dir with
  | Infer ->
    error at (
      phrase ^ "'s type `" ^ string_of_typ t ^
      "` does not match expected type `" ^ expected ^ "`"
    )
  | Check ->
    error at (
      phrase ^ "'s type does not match expected type `" ^
      string_of_typ t ^ "`"
    )

let match_iter iter1 iter2 =
  iter2 = List || Eq.eq_iter iter1 iter2

let as_iter_typ iter phrase env dir t at : typ =
  match expand' env t.it with
  | IterT (t1, iter2) when match_iter iter iter2 -> t1
  | _ -> as_error at phrase dir t ("(_)" ^ string_of_iter iter)

let as_list_typ phrase env dir t at : typ =
  match expand' env t.it with
  | IterT (t1, (List | List1 | ListN _)) -> t1
  | _ -> as_error at phrase dir t "(_)*"

let as_tup_typ phrase env dir t at : typ list =
  match expand' env t.it with
  | TupT ts -> ts
  | _ -> as_error at phrase dir t "(_,...,_)"


let as_mix_typid phrase env id at : mixop * typ =
  match (find "syntax type" env.typs id).it with
  | NotationT (mixop, t) -> mixop, t
  | _ -> as_error at phrase Infer (VarT id $ id.at) "`mixin-op`(...)"

let as_mix_typ phrase env dir t at : mixop * typ =
  match expand' env t.it with
  | VarT id -> as_mix_typid phrase env id at
  | _ -> as_error at phrase dir t ("`mixin-op`(...)")

let as_struct_typid phrase env id at : typfield list =
  match (find "syntax type" env.typs id).it with
  | StructT tfs -> tfs
  | _ -> as_error at phrase Infer (VarT id $ id.at) "{...}"

let as_struct_typ phrase env dir t at : typfield list =
  match expand' env t.it with
  | VarT id -> as_struct_typid phrase env id at
  | _ -> as_error at phrase dir t "{...}"

let rec as_variant_typid phrase env id at : typcase list =
  match (find "syntax type" env.typs id).it with
  | VariantT (ids, cases) ->
    List.concat (cases :: List.map (fun id -> as_variant_typid "" env id at) ids)
  | _ -> as_error at phrase Infer (VarT id $ id.at) "| ..."

let as_variant_typ phrase env dir t at : typcase list =
  match expand' env t.it with
  | VarT id -> as_variant_typid phrase env id at
  | _ -> as_error at phrase dir t "| ..."


(* Type Equivalence *)

let equiv_list equiv_x xs1 xs2 =
  List.length xs1 = List.length xs2 && List.for_all2 equiv_x xs1 xs2

let rec equiv_typ' env t1 t2 =
  (*
  Printf.printf "[equiv] (%s) == (%s)  eq=%b\n%!"
    (Print.string_of_typ t1) (Print.string_of_typ t2)
    (t1.it = t2.it);
  *)
  t1.it = t2.it ||
  match expand env t1, expand env t2 with
  | VarT id1, VarT id2 -> id1.it = id2.it
  | TupT ts1, TupT ts2 ->
    equiv_list (equiv_typ' env) ts1 ts2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    equiv_typ' env t11 t21 && Eq.eq_iter iter1 iter2
  | t1', t2' ->
    Eq.eq_typ (t1' $ t1.at) (t2' $ t2.at)

let equiv_typ env t1 t2 at =
  if not (equiv_typ' env t1 t2) then
    error at ("expression's type `" ^ string_of_typ t1 ^ "` " ^
      "does not match expected type `" ^ string_of_typ t2 ^ "`")


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
  | ListN e -> valid_exp env e (NatT $ e.at)


(* Types *)

and valid_typ env t =
  match t.it with
  | VarT id ->
    if find "syntax type" env.typs id = fwd_deftyp_bad then
      error t.at ("invalid forward reference to syntax type `" ^ id.it ^ "`")
  | BoolT
  | NatT
  | TextT ->
    ()
  | TupT ts ->
    List.iter (valid_typ env) ts
  | IterT (t1, iter) ->
    match iter with
    | ListN e -> error e.at "definite iterator not allowed in type"
    | _ -> valid_typ env t1; valid_iter env iter

and valid_deftyp env dt =
  match dt.it with
  | AliasT t ->
    valid_typ env t
  | NotationT (mixop, t) ->
    valid_typmix env (mixop, t) dt.at
  | StructT tfs ->
    check_atoms "record" "field" (fun (atom, _, _) -> atom) tfs dt.at;
    List.iter (valid_typfield env) tfs
  | VariantT (ids, cases) ->
    List.iter (fun id ->
      let dtI = find "syntax type" env.typs id in
      if dtI = fwd_deftyp_ok || dtI = fwd_deftyp_bad then
        error id.at ("invalid forward reference to syntax type `" ^ id.it ^ "`");
    ) ids;
    let casess = List.map (fun id -> as_variant_typid "parent" env id id.at) ids in
    let cases' = List.flatten (cases::casess) in
    check_atoms "variant" "case" (fun (atom, _, _) -> atom) cases' dt.at;
    List.iter (valid_typcase env) cases

and valid_typmix env (mixop, t) at =
  let arity =
    match t.it with
    | TupT ts -> List.length ts
    | _ -> 1
  in
  if List.length mixop <> arity + 1 then
    error at ("inconsistent arity in mixin notation, `" ^ string_of_mixop mixop ^
      "` applied to " ^ string_of_typ t);
  valid_typ env t

and valid_typfield env (_atom, t, _hints) = valid_typ env t
and valid_typcase env (_atom, t, _hints) = valid_typ env t


(* Expressions *)

and infer_exp env e : typ =
  match e.it with
  | VarE id -> fst (find "variable" env.vars id)
  | BoolE _ -> BoolT $ e.at
  | NatE _ | LenE _ -> NatT $ e.at
  | TextE _ -> TextT $ e.at
  | UnE (op, _) -> infer_unop op $ e.at
  | BinE (op, _, _) -> infer_binop op $ e.at
  | CmpE _ -> BoolT $ e.at
  | IdxE (e1, _) -> as_list_typ "expression" env Infer (infer_exp env e1) e1.at
  | SliceE (e1, _, _)
  | UpdE (e1, _, _)
  | ExtE (e1, _, _)
  | CompE (e1, _) -> infer_exp env e1
  | StrE _ -> error e.at "cannot infer type of record"
  | DotE (t1, e1, atom) ->
    let tfs = as_struct_typ "expression" env Check t1 e1.at in
    find_field tfs atom e1.at
  | TupE es -> TupT (List.map (infer_exp env) es) $ e.at
  | CallE (id, _) -> snd (find "function" env.defs id)
  | MixE _ -> error e.at "cannot infer type of mixin notation"
  | IterE (e1, iter) ->
    let iter' = match iter with ListN _ -> List | iter' -> iter' in
    IterT (infer_exp env e1, iter') $ e.at
  | OptE _ -> error e.at "cannot infer type of option"
  | ListE _ -> error e.at "cannot infer type of list"
  | CatE _ -> error e.at "cannot infer type of concatenation"
  | CaseE _ -> error e.at "cannot infer type of case constructor"
  | SubE (_, _, t) -> t


and valid_exp env e t =
  (*
  Printf.printf "[valid %s] %s  :  %s\n%!"
    (string_of_region e.at) (string_of_exp e) (string_of_typ t);
  *)
  match e.it with
  | VarE id ->
    let t', dim = find "variable" env.vars id in
    equiv_typ env t' t e.at;
    if not (is_prefix dim env.ctx) then
      error e.at ("inconsistent use of iterated variable `" ^
        id.it ^ String.concat "" (List.map string_of_iter dim) ^ "` in " ^
        "context `_" ^ String.concat "" (List.map string_of_iter env.ctx) ^ "`")
  | BoolE _ | NatE _ | TextE _ ->
    let t' = infer_exp env e in
    equiv_typ env t' t e.at
  | UnE (op, e1) ->
    let t' = infer_unop op $ e.at in
    valid_exp env e1 t';
    equiv_typ env t' t e.at
  | BinE (op, e1, e2) ->
    let t' = infer_binop op $ e.at in
    valid_exp env e1 t';
    valid_exp env e2 t';
    equiv_typ env t' t e.at
  | CmpE (op, e1, e2) ->
    let t' =
      match infer_cmpop op with
      | Some t' -> t' $ e.at
      | None -> infer_exp env e1
    in
    valid_exp env e1 t';
    valid_exp env e2 t';
    equiv_typ env (BoolT $ e.at) t e.at
  | IdxE (e1, e2) ->
    let t1 = infer_exp env e1 in
    let t' = as_list_typ "expression" env Infer t1 e1.at in
    valid_exp env e1 t1;
    valid_exp env e2 (NatT $ e2.at);
    equiv_typ env t' t e.at
  | SliceE (e1, e2, e3) ->
    let _typ' = as_list_typ "expression" env Check t e1.at in
    valid_exp env e1 t;
    valid_exp env e2 (NatT $ e2.at);
    valid_exp env e3 (NatT $ e3.at)
  | UpdE (e1, p, e2) ->
    valid_exp env e1 t;
    let t2 = valid_path env p t in
    valid_exp env e2 t2
  | ExtE (e1, p, e2) ->
    valid_exp env e1 t;
    let t2 = valid_path env p t in
    let _typ21 = as_list_typ "path" env Check t2 p.at in
    valid_exp env e2 t2
  | StrE efs ->
    let tfs = as_struct_typ "record" env Check t e.at in
    valid_list valid_expfield env efs tfs e.at
  | DotE (t1, e1, atom) ->
    valid_typ env t1;
    valid_exp env e1 t1;
    let tfs = as_struct_typ "expression" env Check t1 e1.at in
    let t' = find_field tfs atom e1.at in
    equiv_typ env t' t e.at
  | CompE (e1, e2) ->
    let _ = as_struct_typ "record" env Check t e.at in
    valid_exp env e1 t;
    valid_exp env e2 t
  | LenE e1 ->
    let t1 = infer_exp env e1 in
    let _typ11 = as_list_typ "expression" env Infer t1 e1.at in
    valid_exp env e1 t1;
    equiv_typ env (NatT $ e.at) t e.at
  | TupE es ->
    let ts = as_tup_typ "tuple" env Check t e.at in
    valid_list valid_exp env es ts e.at
  | CallE (id, e2) ->
    let t2, t' = find "function" env.defs id in
    valid_exp env e2 t2;
    equiv_typ env t' t e.at
  | MixE (op, e) ->
    let tmix = as_mix_typ "mixin notation" env Check t e.at in
    valid_expmix env op e tmix e.at
  | IterE (e1, iter) ->
    valid_iter env iter;
    let t1 = as_iter_typ iter "iteration" env Check t e.at in
    valid_exp {env with ctx = iter::env.ctx} e1 t1
  | OptE eo ->
    let t1 = as_iter_typ Opt "option" env Check t e.at in
    Option.iter (fun e1 -> valid_exp env e1 t1) eo
  | ListE es ->
    let t1 = as_iter_typ List "list" env Check t e.at in
    List.iter (fun eI -> valid_exp env eI t1) es
  | CatE (e1, e2) ->
    let _typ1 = as_iter_typ List "list" env Check t e.at in
    valid_exp env e1 t;
    valid_exp env e2 t
  | CaseE (atom, e1, t2) ->
    valid_typ env t2;
    let cases = as_variant_typ "case" env Check t2 e.at in
    let t1 = find_case cases atom e1.at in
    valid_exp env e1 t1;
    equiv_typ env t2 t e.at
  | SubE (e1, t1, t2) ->
    valid_typ env t1;
    valid_typ env t2;
    valid_exp env e1 t1;
    equiv_typ env t2 t e.at

and valid_expmix env mixop e (mixop', t) at =
  if mixop <> mixop' then
    error at (
      "mixin notation `" ^ string_of_mixop mixop ^
      "` does not match expected notation `" ^ string_of_mixop mixop' ^ "`"
    );
  valid_exp env e t

and valid_expfield env (atom1, e) (atom2, t, _) =
  if atom1 <> atom2 then error e.at "unexpected record field";
  valid_exp env e t

and valid_path env p t : typ =
  match p.it with
  | RootP -> t
  | IdxP (p1, e2) ->
    let t1 = valid_path env p1 t in
    valid_exp env e2 (NatT $ e2.at);
    as_list_typ "path" env Check t1 p1.at
  | DotP (p1, atom) ->
    let t1 = valid_path env p1 t in
    let tfs = as_struct_typ "path" env Check t1 p1.at in
    find_field tfs atom p1.at


(* Definitions *)

let valid_binds env binds =
  List.iter (fun (id, t, dim) ->
    valid_typ env t;
    env.vars <- bind "variable" env.vars id (t, dim)
  ) binds

let valid_iter_opt env = function
  | None -> env
  | Some iter -> valid_iter env iter; {env with ctx = iter::env.ctx}

let valid_prem env prem =
  match prem.it with
  | RulePr (id, mixop, e, iter_opt) ->
    let env' = valid_iter_opt env iter_opt in
    valid_expmix env' mixop e (find "relation" env.rels id) e.at
  | IfPr (e, iter_opt) ->
    let env' = valid_iter_opt env iter_opt in
    valid_exp env' e (BoolT $ e.at)
  | ElsePr ->
    ()

let valid_rule env mixop t rule =
  match rule.it with
  | RuleD (_id, binds, mixop', e, prems) ->
    valid_binds env binds;
    valid_expmix env mixop' e (mixop, t) e.at;
    List.iter (valid_prem env) prems;
    env.vars <- Env.empty

let valid_clause env t1 t2 clause =
  match clause.it with
  | DefD (binds, e1, e2, prems) ->
    valid_binds env binds;
    valid_exp env e1 t1;
    valid_exp env e2 t2;
    List.iter (valid_prem env) prems;
    env.vars <- Env.empty;
    let free_rh = Free.(Set.diff (free_exp e2).varid (free_exp e1).varid) in
    if free_rh <> Free.Set.empty then
      error clause.at ("definition contains unbound variable(s) `" ^
        String.concat "`, `" (Free.Set.elements free_rh) ^ "`")


let infer_def env d =
  match d.it with
  | SynD (id, dt, _hints) ->
    let fwd_deftyp =
      match dt.it with NotationT _ -> fwd_deftyp_bad | _ -> fwd_deftyp_ok in
    env.typs <- bind "syntax" env.typs id fwd_deftyp
  | RelD (id, mixop, t, _rules, _hints) ->
    valid_typmix env (mixop, t) d.at;
    env.rels <- bind "relation" env.rels id (mixop, t)
  | DecD (id, t1, t2, _clauses, _hints) ->
    valid_typ env t1;
    valid_typ env t2;
    env.defs <- bind "function" env.defs id (t1, t2)
  | _ -> ()


type bind = {bind : 'a. string -> 'a Env.t -> id -> 'a -> 'a Env.t}

let rec valid_def {bind} env d =
  match d.it with
  | SynD (id, dt, _hints) ->
    valid_deftyp env dt;
    env.typs <- bind "syntax" env.typs id dt;
  | RelD (id, mixop, t, rules, _hints) ->
    valid_typmix env (mixop, t) d.at;
    List.iter (valid_rule env mixop t) rules;
    env.rels <- bind "relation" env.rels id (mixop, t)
  | DecD (id, t1, t2, clauses, _hints) ->
    valid_typ env t1;
    valid_typ env t2;
    List.iter (valid_clause env t1 t2) clauses;
    env.defs <- bind "function" env.defs id (t1, t2)
  | RecD ds ->
    List.iter (infer_def env) ds;
    List.iter (valid_def {bind = rebind} env) ds;
    List.iter (fun d ->
      match (List.hd ds).it, d.it with
      | SynD _, SynD _
      | RelD _, RelD _
      | DecD _, DecD _ -> ()
      | _, _ ->
        error (List.hd ds).at (" " ^ string_of_region d.at ^
          ": invalid recurion between definitions of different sort")
    ) ds


(* Scripts *)

let valid ds =
  let env = new_env () in
  List.iter (valid_def {bind} env) ds