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

let error at msg = Source.error at "unthe" msg

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

(* If the expression (or premise) under iteration changes, we may be able to
drop some variables from the iterexp *)

let update_iterexp_vars (sets : Il.Free.sets) ((iter, vs) : iterexp) : iterexp =
  (iter, List.filter (fun v -> Il.Free.Set.mem v.it sets.varid) vs)

(* If a bind and premise is generated under an iteration, wrap them accordingly *)

let under_iterexp (iter, vs) eqns : iterexp * eqns =
   let new_vs = List.map (fun ((v, _, _), _) -> v) eqns in
   let iterexp' = (iter, vs @ new_vs) in
   let eqns' = List.map (fun ((v, t, is), pr) ->
     let pr_iterexp = update_iterexp_vars (Il.Free.free_prem pr) (iter, vs @ new_vs) in
     let pr' = IterPr (pr, pr_iterexp) $ no_region in
     ((v, t, is@[iter]), pr')
   ) eqns in
   iterexp', eqns'


(* Generic traversal helpers *)

type 'a traversal = int ref -> 'a -> eqns * 'a
type ('a, 'b) traversal_k = int ref -> 'a -> ('a -> 'b) -> eqns * 'b

let phrase (t : 'a traversal) : ('a, 'b) note_phrase traversal
  = fun n x -> let eqns, x' = t n x.it in eqns, x' $$ x.at % x.note

let t_list (t : 'a traversal) : ('a list, 'b) traversal_k
  = fun n xs k ->
    let eqnss, xs' = List.split (List.map (t n) xs) in
    List.concat eqnss, k xs'

let unary (t : 'a traversal) : ('a, 'b) traversal_k =
  fun n x k ->
  let eqns, exp' = t n x in
  eqns, k exp'

let binary (t1 : 'a traversal) (t2 : 'b traversal) : ('a * 'b, 'c) traversal_k =
  fun n (x1, x2) k ->
  let eqns1, x1' = t1 n x1 in
  let eqns2, x2' = t2 n x2 in
  eqns1 @ eqns2, k (x1', x2')

let ternary (t1 : 'a traversal) (t2 : 'b traversal) (t3 : 'c traversal) : ('a * 'b * 'c, 'd) traversal_k =
  fun n (x1, x2, x3) k ->
  let eqns1, x1' = t1 n x1 in
  let eqns2, x2' = t2 n x2 in
  let eqns3, x3' = t3 n x3 in
  eqns1 @ eqns2 @ eqns3, k (x1', x2', x3')

(* Expr traversal *)

let rec t_exp n e : eqns * exp =
  (* Descend first using t_exp2, and then see if we have to pull out the current expression *)
  let eqns, e' = t_exp2 n e in
  match e.it with
  |  TheE exp ->
    let ot = exp.note in
    let t = match ot.it with
      | IterT (t, Opt) -> t
      | _ -> error exp.at "Expected option type in TheE"
    in
    let x = fresh_id n in
    let xe = VarE x $$ no_region % t in
    let bind = (x, t, []) in
    let prem = IfPr (
      CmpE (EqOp, exp, OptE (Some xe) $$ no_region % ot) $$ no_region % (BoolT $ no_region)
    ) $ no_region in
    eqns @ [(bind, prem)], xe
  | _ -> eqns, e'

(* Traversal helpers *)

and t_exp2 n = phrase t_exp' n

and t_e n x k = unary t_exp n x k
and t_ee n x k = binary t_exp t_exp n x k
and t_eee n x k = ternary t_exp t_exp t_exp n x k
and t_epe n x k = ternary t_exp t_path t_exp n x k

and t_exp' n e : eqns * exp' =
  match e with
  | VarE _ | BoolE _ | NatE _ | TextE _ | OptE None -> [], e

  | UnE (uo, exp) -> t_e n exp (fun exp' -> UnE (uo, exp'))
  | DotE (exp, a) -> t_e n exp (fun exp' -> DotE (exp', a))
  | LenE exp -> t_e n exp (fun exp' -> LenE exp')
  | MixE (mo, exp) -> t_e n exp (fun exp' -> MixE (mo, exp'))
  | CallE (f, exp) ->t_e n exp (fun exp' -> CallE (f, exp'))
  | OptE (Some exp) ->t_e n exp (fun exp' -> OptE (Some exp'))
  | TheE exp ->t_e n exp (fun exp' -> TheE exp')
  | CaseE (a, exp) ->t_e n exp (fun exp' -> CaseE (a, exp'))
  | SubE (exp, a, b) -> t_e n exp (fun exp' -> SubE (exp', a, b))

  | BinE (bo, exp1, exp2) -> t_ee n (exp1, exp2) (fun (e1', e2') -> BinE (bo, e1', e2'))
  | CmpE (co, exp1, exp2) -> t_ee n (exp1, exp2) (fun (e1', e2') -> CmpE (co, e1', e2'))
  | IdxE (exp1, exp2) -> t_ee n (exp1, exp2) (fun (e1', e2') -> IdxE (e1', e2'))
  | CompE (exp1, exp2) -> t_ee n (exp1, exp2) (fun (e1', e2') -> CompE (e1', e2'))
  | CatE (exp1, exp2) -> t_ee n (exp1, exp2) (fun (e1', e2') -> CatE (e1', e2'))

  | SliceE (exp1, exp2, exp3) -> t_eee n (exp1, exp2, exp3) (fun (e1', e2', e3') -> SliceE (e1', e2', e3'))

  | UpdE (exp1, path, exp2) -> t_epe n (exp1, path, exp2) (fun (e1', p', e2') -> UpdE (e1', p', e2'))
  | ExtE (exp1, path, exp2) -> t_epe n (exp1, path, exp2) (fun (e1', p', e2') -> ExtE (e1', p', e2'))

  | StrE fields -> t_list t_field n fields (fun fields' -> StrE fields')

  | TupE es -> t_list t_exp n es (fun es' -> TupE es')
  | ListE es -> t_list t_exp n es (fun es' -> ListE es')
  | ElementsOfE (exp1, exp2) ->
      t_ee n (exp1, exp2) (fun (e1', e2') -> ElementsOfE (e1', e2'))
  | ListBuilderE (exp1, exp2) ->
      t_ee n (exp1, exp2) (fun (e1', e2') -> ListBuilderE (e1', e2'))

  | IterE (e, iterexp) ->
    let eqns1, e' = t_exp n e in
    let iterexp', eqns1' = under_iterexp iterexp eqns1 in
    let eqns2, iterexp'' = t_iterexp n iterexp' in
    let iterexp''' = update_iterexp_vars (Il.Free.free_exp e') iterexp'' in
    eqns1' @ eqns2, IterE (e', iterexp''')

and t_field n ((a, e) : expfield) =
  unary t_exp n e (fun e' -> (a, e'))

and t_iterexp n (iter, vs) =
  unary t_iter n iter (fun iter' -> (iter', vs))

and t_iter n iter = match iter with
  | ListN e -> unary t_exp n e (fun e' -> ListN e')
  | _ -> [], iter

and t_path n = phrase t_path' n

and t_path' n path = match path with
  | RootP -> [], path
  | IdxP (path, e) -> binary t_path t_exp n (path, e) (fun (path', e') -> IdxP (path', e'))
  | SliceP (path, e1, e2) -> ternary t_path t_exp t_exp n (path, e1, e2) (fun (path', e1', e2') -> SliceP (path', e1', e2'))
  | DotP (path, a) -> unary t_path n path (fun path' -> DotP (path', a))

let rec t_prem n : premise -> eqns * premise = phrase t_prem' n

and t_prem' n prem : eqns * premise' =
  match prem with
  | RulePr (a, b, exp) ->
    unary t_exp n exp (fun exp' -> RulePr (a, b, exp'))
  | IfPr e -> unary t_exp n e (fun e' -> IfPr e')
  | LetPr (e1, e2) -> binary t_exp t_exp n (e1, e2) (fun (e1', e2') -> LetPr (e1', e2'))
  | ElsePr -> [], prem
  | IterPr (prem, iterexp) ->
    let eqns1, prem' = t_prem n prem in
    let iterexp', eqns1' = under_iterexp iterexp eqns1 in
    let eqns2, iterexp'' = t_iterexp n iterexp' in
    let iterexp''' = update_iterexp_vars (Il.Free.free_prem prem') iterexp'' in
    eqns1' @ eqns2, IterPr (prem', iterexp''')

let t_prems n k  = t_list t_prem n k (fun x -> x)

let t_rule' = function
  | RuleD (id, binds, mixop, exp, prems) ->
    (* Counter for fresh variables *)
    let n = ref 0 in
    let eqns, (exp', prems') = binary t_exp t_prems n (exp, prems) (fun x -> x) in
    let extra_binds, extra_prems = List.split eqns in
    RuleD (id, binds @ extra_binds, mixop, exp', extra_prems @ prems')

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

