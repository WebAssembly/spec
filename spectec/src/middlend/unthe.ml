(*
This transformation removes use of the ! operator from relations, by
introducing fresh variables.

An occurrence of !(e) will be replaced with a fresh variable x of the suitable
type (and dimension), and a new condition e = ?(x) is added.

This is an alternative to to how the Sideconditions pass handles the ! operator.
If you need both, passes, run this one first.
*)

open Util
open Source
open Il.Ast

(* Errors *)

let _error at msg = Source.error at "sideconditions" msg

(* We pull out fresh variables and equating side conditions. *)

type bind = (id * typ * iter list)
type eqn = (bind * premise)
type eqns = eqn list

(* Fresh name generation *)

let name i = "o" ^ string_of_int i (* no clash avoidance *)

let fresh_id (n : int ref) : id =
  let i = !n in
  n := !n+1;
  name i $ no_region

(* If a bind and premise is generated under an iteration, wrap them accordingly *)
let eqn_under_iterexp (i, vs) new_vs ((v, t, is), pr) : eqn =
 ((v, t, is@[i]), IterPr (pr, (i, vs @ new_vs)) $ no_region)

let under_iterexp (iter, vs) eqns : iterexp * eqns =
   let new_vs = List.map (fun ((v, _, _), _) -> v) eqns in
   let iterexp' = (iter, vs @ new_vs) in
   let eqns' = List.map (eqn_under_iterexp (iter, vs) new_vs) eqns in
   iterexp', eqns'

(* Generic traversal helpers *)

type 'a traversal = Il.Validation.env -> int ref -> 'a -> eqns * 'a
type ('a, 'b) traversal_k = Il.Validation.env -> int ref -> 'a -> ('a -> 'b) -> eqns * 'b

let phrase (t : 'a traversal) : 'a phrase traversal
  = fun env n x -> let eqns, x' = t env n x.it in eqns, x' $ x.at

let t_list (t : 'a traversal) : ('a list, 'b) traversal_k
  = fun env n xs k ->
    let eqnss, xs' = List.split (List.map (t env n) xs) in
    List.concat eqnss, k xs'

let unary (t : 'a traversal) : ('a, 'b) traversal_k =
  fun env n x k ->
  let eqns, exp' = t env n x in
  eqns, k exp'

let binary (t1 : 'a traversal) (t2 : 'b traversal) : ('a * 'b, 'c) traversal_k =
  fun env n (x1, x2) k ->
  let eqns1, x1' = t1 env n x1 in
  let eqns2, x2' = t2 env n x2 in
  eqns1 @ eqns2, k (x1', x2')

let ternary (t1 : 'a traversal) (t2 : 'b traversal) (t3 : 'c traversal) : ('a * 'b * 'c, 'd) traversal_k =
  fun env n (x1, x2, x3) k ->
  let eqns1, x1' = t1 env n x1 in
  let eqns2, x2' = t2 env n x2 in
  let eqns3, x3' = t3 env n x3 in
  eqns1 @ eqns2 @ eqns3, k (x1', x2', x3')

(* Expr traversal *)

let rec t_exp env n e : eqns * exp =
  (* Descend first using t_exp2, and then see if we have to pull out the current expression *)
  let eqns, e' = t_exp2 env n e in
  match e.it with
  |  TheE exp ->
    let x = fresh_id n in
    let xe = VarE x $ no_region in
    let t = Il.Validation.infer_exp env e' in
    let bind = (x, t, []) in
    let prem = IfPr (CmpE (EqOp, exp, OptE (Some xe) $ no_region) $ no_region) $ no_region in
    eqns @ [(bind, prem)], xe
  | _ -> eqns, e'

(* Traversal helpers *)

and t_exp2 env n = phrase t_exp' env n

and t_e env n x k = unary t_exp env n x k
and t_ee env n x k = binary t_exp t_exp env n x k
and t_eee env n x k = ternary t_exp t_exp t_exp env n x k
and t_epe env n x k = ternary t_exp t_path t_exp env n x k

and t_exp' env n e : eqns * exp' =
  match e with
  | VarE _ | BoolE _ | NatE _ | TextE _ | OptE None -> [], e

  | UnE (uo, exp) -> t_e env n exp (fun exp' -> UnE (uo, exp'))
  | DotE (a, exp, b) -> t_e env n exp (fun exp' -> DotE (a, exp', b))
  | LenE exp -> t_e env n exp (fun exp' -> LenE exp')
  | MixE (mo, exp) -> t_e env n exp (fun exp' -> MixE (mo, exp'))
  | CallE (f, exp) ->t_e env n exp (fun exp' -> CallE (f, exp'))
  | OptE (Some exp) ->t_e env n exp (fun exp' -> OptE (Some exp'))
  | TheE exp ->t_e env n exp (fun exp' -> TheE exp')
  | CaseE (a, exp, b) ->t_e env n exp (fun exp' -> CaseE (a, exp', b))
  | SubE (exp, a, b) -> t_e env n exp (fun exp' -> SubE (exp', a, b))

  | BinE (bo, exp1, exp2) -> t_ee env n (exp1, exp2) (fun (e1', e2') -> BinE (bo, e1', e2'))
  | CmpE (co, exp1, exp2) -> t_ee env n (exp1, exp2) (fun (e1', e2') -> CmpE (co, e1', e2'))
  | IdxE (exp1, exp2) -> t_ee env n (exp1, exp2) (fun (e1', e2') -> IdxE (e1', e2'))
  | CompE (exp1, exp2) -> t_ee env n (exp1, exp2) (fun (e1', e2') -> CompE (e1', e2'))
  | CatE (exp1, exp2) -> t_ee env n (exp1, exp2) (fun (e1', e2') -> CatE (e1', e2'))

  | SliceE (exp1, exp2, exp3) -> t_eee env n (exp1, exp2, exp3) (fun (e1', e2', e3') -> SliceE (e1', e2', e3'))

  | UpdE (exp1, path, exp2) -> t_epe env n (exp1, path, exp2) (fun (e1', p', e2') -> UpdE (e1', p', e2'))
  | ExtE (exp1, path, exp2) -> t_epe env n (exp1, path, exp2) (fun (e1', p', e2') -> ExtE (e1', p', e2'))

  | StrE fields -> t_list t_field env n fields (fun fields' -> StrE fields')

  | TupE es -> t_list t_exp env n es (fun es' -> TupE es')
  | ListE es -> t_list t_exp env n es (fun es' -> ListE es')

  | IterE (e, iterexp) ->
    let eqns1, e' = t_exp env n e in
    let iterexp', eqns1' = under_iterexp iterexp eqns1 in
    let eqns2, iterexp'' = t_iterexp env n iterexp' in
    eqns1' @ eqns2, IterE (e', iterexp'')

and t_field env n ((a, e) : expfield) =
  unary t_exp env n e (fun e' -> (a, e'))

and t_iterexp env n (iter, vs) =
  unary t_iter env n iter (fun iter' -> (iter', vs))

and t_iter env n iter = match iter with
  | ListN e -> unary t_exp env n e (fun e' -> ListN e')
  | _ -> [], iter

and t_path env n = phrase t_path' env n

and t_path' env n path = match path with
  | RootP -> [], path
  | IdxP (path, e) -> binary t_path t_exp env n (path, e) (fun (path', e') -> IdxP (path', e'))
  | DotP (path, a) -> unary t_path env n path (fun path' -> DotP (path', a))

let rec t_prem env n : premise -> eqns * premise = phrase t_prem' env n

and t_prem' env n prem : eqns * premise' =
  match prem with
  | RulePr (a, b, exp) ->
    unary t_exp env n exp (fun exp' -> RulePr (a, b, exp'))
  | IfPr e -> unary t_exp env n e (fun e' -> IfPr e')
  | ElsePr -> [], prem
  | IterPr (prem, iterexp) ->
    let eqns1, prem' = t_prem env n prem in
    let iterexp', eqns1' = under_iterexp iterexp eqns1 in
    let eqns2, iterexp'' = t_iterexp env n iterexp' in
    eqns1' @ eqns2, IterPr (prem', iterexp'')

let t_prems env n k  = t_list t_prem env n k (fun x -> x)

let t_rule' env = function
  | RuleD (id, binds, mixop, exp, prems) ->
    (* Entering the scope of the binds; need to pass them to Il.Validation for type infernece *)
    Il.Validation.valid_binds env binds;
    (* Counter for fresh variables *)
    let n = ref 0 in
    let eqns, (exp', prems') = binary t_exp t_prems env n (exp, prems) (fun x -> x) in
    let extra_binds, extra_prems = List.split eqns in
    Il.Validation.clear_binds env;
    RuleD (id, binds @ extra_binds, mixop, exp', extra_prems @ prems')

let t_rule env x = { x with it = t_rule' env x.it }

let t_rules env = List.map (t_rule env)

let rec t_def' env = function
  | RecD defs -> RecD (List.map (t_def env) defs)
  | RelD (id, mixop, typ, rules, hints) ->
    RelD (id, mixop, typ, t_rules env rules, hints)
  | def -> def

and t_def env x = { x with it = t_def' env x.it }

let transform (defs : script) =
  (* Run type inference *)
  let env = Il.Validation.new_env () in
  Il.Validation.valid_defs env defs;
  List.map (t_def env) defs

