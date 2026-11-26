open Util
open Source
open Il.Ast
open Il.Free
open Il.Walk


(* Errors *)

let error at msg = Error.error at "sideconditions" msg

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
  IterPr (pr, (iter, vars'))

let is_null e = CmpE (`EqOp, `BoolT, e, OptE None $$ e.at % e.note) $$ e.at % (BoolT $ e.at)
let is_non_empty e = IfPr (CmpE (`NeOp, `BoolT, e, ListE [] $$ e.at % e.note) $$ e.at % (BoolT $ e.at)) $ e.at
let equiv e1 e2 = IfPr (BinE (`EquivOp, `BoolT, e1, e2) $$ e1.at % (BoolT $ e1.at)) $ e1.at
let same_len e1 e2 = IfPr (CmpE (`EqOp, `BoolT, lenE e1, lenE e2) $$ e1.at % (BoolT $ e1.at)) $ e1.at
(* let has_len ne e = IfPr (CmpE (`EqOp, None, lenE e, ne) $$ e.at % (BoolT $ e.at)) $ e.at *)

(* updates the types in the environment as we go under iteras *)
let env_under_iter env ((_, vs) : iterexp) =
  List.fold_left (fun env (v, e) -> Il.Env.bind_var env v e.note) env vs

let iter_side_conditions _env ((iter, vs) : iterexp) : prem list =
  (* let iter' = if iter = Opt then Opt else List in *)
  match iter, List.map snd vs with
  | Opt, e::es -> List.map (fun e' -> equiv (is_null e) (is_null e')) es
  | List, e::es -> List.map (same_len e) es
  | List1, e::es -> List.map (same_len e) es @ [is_non_empty e]
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

let is_true_exp env e =
  match Il.Eval.reduce_exp env e with
  | Ok {it = BoolE b; _} -> b
  | _ -> false

(* Is prem always true? *)
let is_true_prem env prem =
  match prem.it with
  | IfPr e -> is_true_exp env e
  | _ -> false

(* Does prem1 obviously imply prem2? *)
let rec implies prem1 prem2 =
  Il.Eq.eq_prem prem1 prem2 ||
  match prem2.it with
  | IterPr (prem2', _) -> implies prem1 prem2'
  | _ -> false

(* Remove empty premise iterators *)
let rec flatten_empty_iter prem =
  match prem.it with
  | IterPr (prem', iterexp) ->
    let prem'' = flatten_empty_iter prem' in
    (match iterexp with
    | ((Opt | List | List1), []) -> prem''
    | _ -> IterPr (prem'', iterexp) $ prem.at)
  | _ -> prem

let reduce_prems env prems = prems
  |> List.map flatten_empty_iter
  |> Util.Lib.List.filter_not (is_true_prem env)
  |> Util.Lib.List.nub implies

let t_params env =
  List.fold_left (fun env param ->
    match param.it with
    | ExpP (v, t) -> Il.Env.bind_var env v t
    | TypP _ | DefP _ | GramP _ -> error param.at "unexpected paramater or quantifier in rule"
  ) env

let t_rule' env = function
  | RuleD (id, quants, mixop, exp, prems) ->
    let env' = t_params env quants in
    let collector = create_collector env' in
    let prems' = List.concat_map (fun prem -> collect_prem collector prem @ [prem]) prems in
    let extra_prems = collect_exp collector exp in
    let reduced_prems = reduce_prems env (extra_prems @ prems') in
    RuleD (id, quants, mixop, exp, reduced_prems)

let t_rule env x = { x with it = t_rule' env x.it }

let t_rules env = List.map (t_rule env)

let rec t_def' env = function
  | RecD defs -> RecD (List.map (t_def env) defs)
  | RelD (id, params, mixop, typ, rules) ->
    let env' = Il.Env.env_of_params env params in
    RelD (id, params, mixop, typ, t_rules env' rules)
  | def -> def

and t_def env x = { x with it = t_def' env x.it }

let transform (defs : script) =
  let env = Il.Env.env_of_script defs in
  List.map (t_def env) defs
