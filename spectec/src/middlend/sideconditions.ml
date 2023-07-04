(*
This transformation make explicit the following implicit side conditions
of terms in premises and conclusions:

 * Array access          a[i]         i < |a|
 * Joint iteration       e*{v1,v2}    |v1*| = |v2*|
 * Option projection     !(e)         e =!= null

(The option projection would probably be nicer by rewriting !(e) to a fresh
variable x and require e=?x. Maybe later.)
*)

open Util
open Source
open Il.Ast

(* Errors *)

let _error at msg = Source.error at "sideconditions" msg

module Env = Map.Make(String)

(* Smart constructor for LenE that optimizes |x^n| into n *)
let lenE e = match e.it with
| IterE (_, (ListN ne, _)) -> ne
| _ -> LenE e $$ no_region % (NatT $ no_region)

let is_null e = CmpE (EqOp, e, OptE None $$ no_region % e.note) $$ no_region % (BoolT $ e.at)
let iffE e1 e2 = IfPr (BinE (EquivOp, e1, e2) $$ no_region % (BoolT $ no_region)) $ no_region
let same_len e1 e2 = IfPr (CmpE (EqOp, lenE e1, lenE e2) $$ no_region % (BoolT $ no_region)) $ no_region
let has_len ne e = IfPr (CmpE (EqOp, lenE e, ne) $$ no_region % (BoolT $ no_region)) $ no_region

let iter_side_conditions env ((iter, vs) : iterexp) : premise list =
  let iter' = if iter = Opt then Opt else List in
  let ves = List.map (fun v ->
    let t = Env.find v.it env in
    IterE (VarE v $$ no_region % t, (iter, [v])) $$ no_region % (IterT (t, iter') $ no_region)) vs in
 match iter, ves with
  | _, [] -> []
  | Opt, (e::es) -> List.map (fun e' -> iffE (is_null e) (is_null e')) es
  | (List|List1), (e::es) -> List.map (same_len e) es
  | ListN ne, es -> List.map (has_len ne) es

(* Expr traversal *)
let rec t_exp env e : premise list =
  (* First the conditions to be generated here *)
  begin match e.it with
  | IdxE (exp1, exp2) ->
    [IfPr (CmpE (LtOp, exp2, LenE exp1 $$ no_region % exp2.note) $$ no_region % (BoolT $ no_region)) $ no_region]
  | TheE exp ->
    [IfPr (CmpE (NeOp, exp, OptE None $$ no_region % exp.note) $$ no_region % (BoolT $ no_region)) $ no_region]
  | IterE (_exp, iterexp) -> iter_side_conditions env iterexp
  | _ -> []
  end @
  (* And now descend *)
  match e.it with
  | VarE _ | BoolE _ | NatE _ | TextE _ | OptE None
  -> []
  | UnE (_, exp)
  | DotE (exp, _)
  | LenE exp
  | MixE (_, exp)
  | CallE (_, exp)
  | OptE (Some exp)
  | TheE exp
  | CaseE (_, exp)
  | SubE (exp, _, _)
  -> t_exp env exp
  | BinE (_, exp1, exp2)
  | CmpE (_, exp1, exp2)
  | IdxE (exp1, exp2)
  | CompE (exp1, exp2)
  | CatE (exp1, exp2)
  | ElementsOfE (exp1, exp2)
  -> t_exp env exp1 @ t_exp env exp2
  | SliceE (exp1, exp2, exp3)
  -> t_exp env exp1 @ t_exp env exp2 @ t_exp env exp3
  | UpdE (exp1, path, exp2)
  | ExtE (exp1, path, exp2)
  -> t_exp env exp1 @ t_path env path @ t_exp env exp2
  | StrE fields
  -> List.concat_map (fun (_, e) -> t_exp env e) fields
  | TupE es | ListE es
  -> List.concat_map (t_exp env) es
  | IterE (e, iterexp)
  -> List.map (fun pr -> IterPr (pr, iterexp) $ no_region) (t_exp env e) @ t_iterexp env iterexp

and t_iterexp env (iter, _) = t_iter env iter

and t_iter env = function
  | ListN e -> t_exp env e
  | _ -> []

and t_path env path = match path.it with
  | RootP -> []
  | IdxP (path, e) -> t_path env path @ t_exp env e
  | SliceP (path, e1, e2) -> t_path env path @ t_exp env e1 @ t_exp env e2
  | DotP (path, _) -> t_path env path


let rec t_prem env prem = match prem.it with
  | RulePr (_, _, exp) -> t_exp env exp
  | IfPr e -> t_exp env e
  | LetPr (e1, e2) -> t_exp env e1 @ t_exp env e2
  | ElsePr -> []
  | IterPr (prem, iterexp)
  -> iter_side_conditions env iterexp @
     List.map (fun pr -> IterPr (pr, iterexp) $ no_region) (t_prem env prem) @ t_iterexp env iterexp

let t_prems env = List.concat_map (t_prem env)

let is_identity e = match e.it with
  | CmpE (EqOp, e1, e2) -> Il.Eq.eq_exp e1 e2
  | _ -> false

(* Is prem always true? *)
let is_true prem = match prem.it with
  | IfPr e -> is_identity e
  | _ -> false

(* Does prem1 obviously imply prem2? *)
let rec implies prem1 prem2 = Il.Eq.eq_prem prem1 prem2 ||
  match prem2.it with
  | IterPr (prem2', _) -> implies prem1 prem2'
  | _ -> false

let reduce_prems prems = prems
  |> Util.Lib.List.filter_not is_true
  |> Util.Lib.List.nub implies

let t_rule' = function
  | RuleD (id, binds, mixop, exp, prems) ->
    let env = List.fold_left (fun env (v, t, _) -> Env.add v.it t env) Env.empty binds in
    let extra_prems = t_prems env prems @ t_exp env exp in
    let prems' = reduce_prems (extra_prems @ prems) in
    RuleD (id, binds, mixop, exp, prems')

let t_rule x = { x with it = t_rule' x.it }

let t_rules = List.map t_rule

let rec t_def' = function
  | RecD defs -> RecD (List.map t_def defs)
  | RelD (id, mixop, typ, rules) ->
    RelD (id, mixop, typ, t_rules rules)
  | def -> def

and t_def x = { x with it = t_def' x.it }

let transform (defs : script) =
  List.map t_def defs

