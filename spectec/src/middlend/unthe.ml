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

let error at msg = Error.error at "option projection" msg

(* We pull out fresh variables and equating side conditions. *)

type eqn = bind * prem
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
  let vs' = List.filter (fun (v, _) -> Il.Free.Set.mem v.it sets.varid) vs in
  let vs'' = if vs' <> [] then vs' else
    match iter with
    | ListN _ -> vs'
    | _ -> [List.hd vs]  (* prevent empty iterator list *)
  in (iter, vs'')

(* If a bind and premise is generated under an iteration, wrap them accordingly *)

let under_iterexp (iter, vs) eqns : iterexp * eqns =
   let new_vs = List.map (fun (bind, _) ->
     match bind.it with
     | ExpB (v, t) ->
       (v, VarE v $$ v.at % (IterT (t, match iter with Opt -> Opt | _ -> List) $ v.at))
     | TypB _ | DefB _ | GramB _ -> error bind.at "unexpected type binding"
   ) eqns in
   let eqns' = List.map2 (fun (bind, pr) (v, e) ->
     let iterexp' = update_iterexp_vars (Il.Free.free_prem pr) (iter, vs @ [(v, e)]) in
     let pr' = IterPr (pr, iterexp') $ no_region in
     (ExpB (v, e.note) $ bind.at, pr')
   ) eqns new_vs in
   (iter, vs @ new_vs), eqns'


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
  | TheE exp ->
    let ot = exp.note in
    let t = match ot.it with
      | IterT (t, Opt) -> t
      | _ -> error exp.at "Expected option type in TheE"
    in
    let x = fresh_id n in
    let xe = VarE x $$ no_region % t in
    let bind = ExpB (x, t) $ no_region in
    let prem = IfPr (
      CmpE (`EqOp, `BoolT, exp, OptE (Some xe) $$ no_region % ot) $$ no_region % (BoolT $ no_region)
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
  | VarE _ | BoolE _ | NumE _ | TextE _ | OptE None -> [], e

  | UnE (uo, nto, exp) -> t_e n exp (fun exp' -> UnE (uo, nto, exp'))
  | DotE (exp, a) -> t_e n exp (fun exp' -> DotE (exp', a))
  | LenE exp -> t_e n exp (fun exp' -> LenE exp')
  | CallE (f, args) -> t_list t_arg n args (fun args' -> CallE (f, args'))
  | ProjE (exp, i) -> t_e n exp (fun exp' -> ProjE (exp', i))
  | UncaseE (exp, mo) -> t_e n exp (fun exp' -> UncaseE (exp', mo))
  | OptE (Some exp) -> t_e n exp (fun exp' -> OptE (Some exp'))
  | TheE exp -> t_e n exp (fun exp' -> TheE exp')
  | LiftE exp -> t_e n exp (fun exp' -> LiftE exp')
  | CaseE (mixop, exp) -> t_e n exp (fun exp' -> CaseE (mixop, exp'))
  | CvtE (exp, a, b) -> t_e n exp (fun exp' -> CvtE (exp', a, b))
  | SubE (exp, a, b) -> t_e n exp (fun exp' -> SubE (exp', a, b))

  | BinE (bo, nto, exp1, exp2) -> t_ee n (exp1, exp2) (fun (e1', e2') -> BinE (bo, nto, e1', e2'))
  | CmpE (co, nto, exp1, exp2) -> t_ee n (exp1, exp2) (fun (e1', e2') -> CmpE (co, nto, e1', e2'))
  | IdxE (exp1, exp2) -> t_ee n (exp1, exp2) (fun (e1', e2') -> IdxE (e1', e2'))
  | CompE (exp1, exp2) -> t_ee n (exp1, exp2) (fun (e1', e2') -> CompE (e1', e2'))
  | CatE (exp1, exp2) -> t_ee n (exp1, exp2) (fun (e1', e2') -> CatE (e1', e2'))
  | MemE (exp1, exp2) -> t_ee n (exp1, exp2) (fun (e1', e2') -> MemE (e1', e2'))

  | SliceE (exp1, exp2, exp3) -> t_eee n (exp1, exp2, exp3) (fun (e1', e2', e3') -> SliceE (e1', e2', e3'))

  | UpdE (exp1, path, exp2) -> t_epe n (exp1, path, exp2) (fun (e1', p', e2') -> UpdE (e1', p', e2'))
  | ExtE (exp1, path, exp2) -> t_epe n (exp1, path, exp2) (fun (e1', p', e2') -> ExtE (e1', p', e2'))

  | StrE fields -> t_list t_field n fields (fun fields' -> StrE fields')

  | TupE es -> t_list t_exp n es (fun es' -> TupE es')
  | ListE es -> t_list t_exp n es (fun es' -> ListE es')
  | IterE (e, iterexp) ->
    let eqns1, e' = t_exp n e in
    let iterexp', eqns1' = under_iterexp iterexp eqns1 in
    let eqns2, iterexp'' = t_iterexp n iterexp' in
    let iterexp''' = update_iterexp_vars (Il.Free.free_exp e') iterexp'' in
    eqns1' @ eqns2, IterE (e', iterexp''')

and t_field n ((a, e) : expfield) =
  unary t_exp n e (fun e' -> (a, e'))

and t_iterexp n iterexp =
  binary t_iter t_iterbinds n iterexp Fun.id

and t_iterbinds n binds =
  t_list t_iterbind n binds Fun.id

and t_iterbind n (id, e) =
  unary t_exp n e (fun e' -> (id, e'))

and t_iter n iter = match iter with
  | ListN (e, id_opt) -> unary t_exp n e (fun e' -> ListN (e', id_opt))
  | _ -> [], iter

and t_path n = phrase t_path' n

and t_path' n path = match path with
  | RootP -> [], path
  | IdxP (path, e) -> binary t_path t_exp n (path, e) (fun (path', e') -> IdxP (path', e'))
  | SliceP (path, e1, e2) -> ternary t_path t_exp t_exp n (path, e1, e2) (fun (path', e1', e2') -> SliceP (path', e1', e2'))
  | DotP (path, a) -> unary t_path n path (fun path' -> DotP (path', a))

and t_arg n = phrase t_arg' n

and t_arg' n arg = match arg with
  | ExpA exp -> unary t_exp n exp (fun exp' -> ExpA exp')
  | TypA _ -> [], arg
  | DefA _ -> [], arg
  | GramA _ -> [], arg

let rec t_prem n : prem -> eqns * prem = phrase t_prem' n

and t_prem' n prem : eqns * prem' =
  match prem with
  | RulePr (a, b, exp) ->
    unary t_exp n exp (fun exp' -> RulePr (a, b, exp'))
  | IfPr e -> unary t_exp n e (fun e' -> IfPr e')
  | LetPr (e1, e2, ids) -> binary t_exp t_exp n (e1, e2) (fun (e1', e2') -> LetPr (e1', e2', ids))
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

let rec t_def' = function
  | RecD defs -> RecD (List.map t_def defs)
  | RelD (id, mixop, typ, rules) -> RelD (id, mixop, typ, List.map t_rule rules)
  | def -> def

and t_def x = { x with it = t_def' x.it }

let transform (defs : script) =
  List.map t_def defs
