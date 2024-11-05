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

(* Expr traversal *)
let rec t_exp env e : prem list =
  (* First the conditions to be generated here *)
  begin match e.it with
  | CvtE (_exp, t1, t2) when t1 > t2 ->
    []  (* TODO *)
  | IdxE (exp1, exp2) ->
    [IfPr (CmpE (`LtOp, `NatT, exp2, LenE exp1 $$ e.at % exp2.note) $$ e.at % (BoolT $ e.at)) $ e.at]
  | TheE exp ->
    [IfPr (CmpE (`NeOp, `BoolT, exp, OptE None $$ e.at % exp.note) $$ e.at % (BoolT $ e.at)) $ e.at]
  | IterE ({it= CmpE (`EqOp, _,  _, _); _}, iterexp) -> iter_side_conditions env iterexp
  | MemE (_exp, exp) ->
    [IfPr (CmpE (`GtOp, `NatT, LenE exp $$ exp.at % (NumT `NatT $ exp.at), NumE (`Nat Z.zero) $$ no_region % (NumT `NatT $ no_region)) $$ e.at % (BoolT $ e.at)) $ e.at]
  | _ -> []
  end @
  (* And now descend *)
  match e.it with
  | VarE _ | BoolE _ | NumE _ | TextE _ | OptE None
  -> []
  | UnE (_, _, exp)
  | DotE (exp, _)
  | LenE exp
  | ProjE (exp, _)
  | UncaseE (exp, _)
  | OptE (Some exp)
  | TheE exp
  | CaseE (_, exp)
  | CvtE (exp, _, _)
  | SubE (exp, _, _)
  -> t_exp env exp
  | BinE (_, _, exp1, exp2)
  | CmpE (_, _, exp1, exp2)
  | IdxE (exp1, exp2)
  | CompE (exp1, exp2)
  | MemE (exp1, exp2)
  | CatE (exp1, exp2)
  -> t_exp env exp1 @ t_exp env exp2
  | SliceE (exp1, exp2, exp3)
  -> t_exp env exp1 @ t_exp env exp2 @ t_exp env exp3
  | UpdE (exp1, path, exp2)
  | ExtE (exp1, path, exp2)
  -> t_exp env exp1 @ t_path env path @ t_exp env exp2
  | CallE (_, args)
  -> List.concat_map (t_arg env) args
  | StrE fields
  -> List.concat_map (fun (_, e) -> t_exp env e) fields
  | TupE es | ListE es
  -> List.concat_map (t_exp env) es
  | IterE (e1, iterexp)
  ->
    t_iterexp env iterexp @
    let env' = env_under_iter env iterexp in
    List.map (fun pr -> iterPr (pr, iterexp) $ e.at) (t_exp env' e1)

and t_iterexp env (iter, _) = t_iter env iter

and t_iter env = function
  | ListN (e, _) -> t_exp env e
  | _ -> []

and t_path env path = match path.it with
  | RootP -> []
  | IdxP (path, e) -> t_path env path @ t_exp env e
  | SliceP (path, e1, e2) -> t_path env path @ t_exp env e1 @ t_exp env e2
  | DotP (path, _) -> t_path env path

and t_arg env arg = match arg.it with
  | ExpA exp -> t_exp env exp
  | TypA _ -> []
  | DefA _ -> []
  | GramA _ -> []


let rec t_prem env prem =
  (match prem.it with
  | RulePr (_, _, exp) -> t_exp env exp
  | IfPr e -> t_exp env e
  | LetPr (e1, e2, _) -> t_exp env e1 @ t_exp env e2
  | ElsePr -> []
  | IterPr (prem, iterexp)
  -> iter_side_conditions env iterexp @
     t_iterexp env iterexp @
     let env' = env_under_iter env iterexp in
     List.map (fun pr -> iterPr (pr, iterexp) $ prem.at) (t_prem env' prem)
  ) @ [prem]

let t_prems env = List.concat_map (t_prem env)

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
    let prems' = t_prems env prems in
    let extra_prems = t_exp env exp in
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

