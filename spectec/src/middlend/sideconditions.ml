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
open Il.Free
open Il.Walk

(* Errors *)

let error at msg = Error.error at "side condition" msg

module Env = Map.Make(String)

(* Smart constructor for LenE that optimizes |x^n| into n *)
let lenE e = match e.it with
| IterE (_, (ListN (ne, _), _)) -> ne
| _ -> LenE e $$ e.at % (NumT `NatT $ e.at)

(* Smart constructor for IterPr that removes dead iter-variables *)
let iterPr (pr, (iter, vars)) =
  let frees = free_prem pr in
  let vars' = List.filter (fun (id, _) ->
    Set.mem id.it frees.varid
  ) vars in
  (* Must keep at least one variable to keep the iteration well-formed *)
  let vars'' = if vars' <> [] then vars' else [List.hd vars] in
  IterPr (pr, (iter, vars''))

let is_null e = CmpE (`EqOp, `BoolT, e, OptE None $$ e.at % e.note) $$ e.at % (BoolT $ e.at)
let iffE e1 e2 = IfPr (BinE (`EquivOp, `BoolT, e1, e2) $$ e1.at % (BoolT $ e1.at)) $ e1.at
let same_len e1 e2 = IfPr (CmpE (`EqOp, `BoolT, lenE e1, lenE e2) $$ e1.at % (BoolT $ e1.at)) $ e1.at
(* let has_len ne e = IfPr (CmpE (`EqOp, None, lenE e, ne) $$ e.at % (BoolT $ e.at)) $ e.at *)

(* updates the types in the environment as we go under iteras *)
let env_under_iter env ((_, vs) : iterexp) =
  List.fold_left (fun env (v, e) -> Env.add v.it e.note env) env vs

let iter_side_conditions _env ((iter, vs) : iterexp) : prem list =
  (* let iter' = if iter = Opt then Opt else List in *)
  match iter, List.map snd vs with
  | Opt, (e::es) -> List.map (fun e' -> iffE (is_null e) (is_null e')) es
  | (List|List1), (e::es) -> List.map (same_len e) es
  (* | ListN (ne, None), es -> List.map (has_len ne) es *)
  | ListN _, _ -> []
  | _ -> []

let is_eq_exp e = 
  match e.it with
  | CmpE (`EqOp, _,  _, _) -> true
  | _ -> false
  
(* Expr traversal *)
let rec t_exp env e =
  match e.it with
  | CvtE (_exp, t1, t2) when t1 > t2 ->
    ([], true) (* TODO *)
  | IdxE (exp1, exp2) ->
    ([IfPr (CmpE (`LtOp, `NatT, exp2, LenE exp1 $$ e.at % exp2.note) $$ e.at % (BoolT $ e.at)) $ e.at], true)
  | TheE exp ->
    ([IfPr (CmpE (`NeOp, `BoolT, exp, OptE None $$ e.at % exp.note) $$ e.at % (BoolT $ e.at)) $ e.at], true) 
  | MemE (_exp, exp) ->
    ([IfPr (CmpE (`GtOp, `NatT, LenE exp $$ exp.at % (NumT `NatT $ exp.at), NumE (`Nat Z.zero) $$ no_region % (NumT `NatT $ no_region)) $$ e.at % (BoolT $ e.at)) $ e.at], true)
  | IterE (e1, ((iter, _) as iterexp))
  ->
    let env' = env_under_iter env iterexp in
    let collector1 = create_collector env in
    let collector2 = create_collector env' in
    let iter_prems = if is_eq_exp e1 then iter_side_conditions env iterexp else [] in 
    (
    iter_prems @ 
    collect_iter collector1 iter @ 
    List.map (fun pr -> iterPr (pr, iterexp) $ e.at) (collect_exp collector2 e1), false)
  | _ -> ([], true)
and t_prem env prem =
  let res, continue = (match prem.it with
  | IterPr (prem', ((iter, _) as iterexp))
  -> 
    let env' = env_under_iter env iterexp in
    let collector1 = create_collector env in
    let collector2 = create_collector env' in
    (iter_side_conditions env iterexp @
    collect_iter collector1 iter @
    List.map (fun pr -> iterPr (pr, iterexp) $ prem'.at) (collect_prem collector2 prem' @ [prem']), false)
  | NegPr _ -> 
    (* We do not want to infer anything from NegPr *)
    ([], false)
  | _ -> ([], true)
  ) in
  res, continue

and create_collector env = 
  let base_prem_collector: prem list collector = base_collector [] (@) in
  { base_prem_collector with collect_exp = t_exp env; collect_prem = t_prem env }

let is_identity e =
  try
    let e' = (Il.Eval.reduce_exp Il.Env.empty e) in
    match e'.it with
    | BoolE b -> b
    | _ -> false
  with _ -> false

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
    let env = List.fold_left (fun env bind ->
      match bind.it with
      | ExpB (v, t) -> Env.add v.it t env
      | TypB _ | DefB _ | GramB _ -> error bind.at "unexpected type argument in rule") Env.empty binds
    in
    let collector = create_collector env in
    let prems' = List.concat_map (fun prem -> collect_prem collector prem @ [prem]) prems in
    let extra_prems = collect_exp collector exp in
    let reduced_prems = reduce_prems (extra_prems @ prems') in
    RuleD (id, binds, mixop, exp, reduced_prems)

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