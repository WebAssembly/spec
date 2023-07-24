(*
This transformation removes various forms of wildcards from the syntax.

In particular we currently detect
 * `FOO?` where `FOO is a constructor of a single-constructor-variant
 * `()?`

Like many other transformations, this bridges the gap between the source
syntax, where expressions are really relations (can fail, can denote multiple
values) and the target syntax of theorem provers, where expressions must be
purely functional (given a value for all free variables, must denote exactly
one value).

The overall structure of this module is similar to that of Middlend.Unthe.
*)

open Util
open Source
open Il.Ast

(* Errors *)

let _error at msg = Source.error at "wild" msg

(* Environment

We need to know which variant types have exactly one constructor.
(We do not remember the name of the constructor, and assume the input to
be well-typed.
*)

module S = Set.Make(String)
type env = {
  mutable unit_variants : S.t;
  mutable counter : int;  (* to generate fresh names *)
}
let new_env () : env = { unit_variants = S.empty; counter = 0 }

(*
The main predicate here: Which expressions are

 - universal (describes all values of the current type) and
 - multi-valued (describes more than one value)

So far, we only look for `FOO?` and `()?`, but this can be extended of cousre.
*)

let rec is_universal env exp : bool =
  match exp.it with
  | TupE es -> List.for_all (is_universal env) es
  | CaseE _ -> begin match exp.note.it with
    | VarT i -> S.mem i.it env.unit_variants
    | _ -> false
  end
  | _ -> false

let is_universal_and_multi_value env exp : bool =
  match exp.it with
  | IterE (e, (Opt, [])) -> is_universal env e
  | _ -> false


(* We pull out fresh variables and equating side conditions. *)

type bind = (id * typ * iter list)
type binds = bind list

(* Fresh name generation *)

let name i = "w" ^ string_of_int i (* NB: no clash avoidance yet *)

let fresh_id env : id =
  let i = env.counter in
  env.counter <- env.counter + 1;
  name i $ no_region

(* If a bind and premise is generated under an iteration, wrap them accordingly *)

let under_iterexp (iter, vs) binds : iterexp * binds =
   let new_vs = List.map (fun (v, _, _) -> v) binds in
   let iterexp' = (iter, vs @ new_vs) in
   let binds' = List.map (fun (v, t, is) -> (v, t, is@[iter])) binds in
   iterexp', binds'

(* Generic traversal helpers *)

type 'a traversal = env -> 'a -> binds * 'a
type ('a, 'b) traversal_k = env -> 'a -> ('a -> 'b) -> binds * 'b

let phrase (t : 'a traversal) : ('a, 'b) note_phrase traversal
  = fun env x -> let binds, x' = t env x.it in binds, x' $$ x.at % x.note

let t_list (t : 'a traversal) : ('a list, 'b) traversal_k
  = fun n xs k ->
    let bindss, xs' = List.split (List.map (t n) xs) in
    List.concat bindss, k xs'

let unary (t : 'a traversal) : ('a, 'b) traversal_k =
  fun n x k ->
  let binds, exp' = t n x in
  binds, k exp'

let binary (t1 : 'a traversal) (t2 : 'b traversal) : ('a * 'b, 'c) traversal_k =
  fun n (x1, x2) k ->
  let binds1, x1' = t1 n x1 in
  let binds2, x2' = t2 n x2 in
  binds1 @ binds2, k (x1', x2')

let ternary (t1 : 'a traversal) (t2 : 'b traversal) (t3 : 'c traversal) : ('a * 'b * 'c, 'd) traversal_k =
  fun n (x1, x2, x3) k ->
  let binds1, x1' = t1 n x1 in
  let binds2, x2' = t2 n x2 in
  let binds3, x3' = t3 n x3 in
  binds1 @ binds2 @ binds3, k (x1', x2', x3')

(* Expr traversal *)


let rec t_exp env e : binds * exp =
  (* Descend first using t_exp2, and then see if we have to pull out the current expression *)
  let binds, e' = t_exp2 env e in
  if is_universal_and_multi_value env e'
  then
    let t = e.note in
    let x = fresh_id env in
    let xe = VarE x $$ no_region % t in
    let bind = (x, t, []) in
    binds @ [bind], xe
  else binds, e'

(* Traversal helpers *)

and t_exp2 env = phrase t_exp' env

and t_e env x k = unary t_exp env x k
and t_ee env x k = binary t_exp t_exp env x k
and t_eee env x k = ternary t_exp t_exp t_exp env x k
and t_epe env x k = ternary t_exp t_path t_exp env x k

and t_exp' env e : binds * exp' =
  match e with
  | VarE _ | BoolE _ | NatE _ | TextE _ | OptE None -> [], e

  | UnE (uo, exp) -> t_e env exp (fun exp' -> UnE (uo, exp'))
  | DotE (exp, a) -> t_e env exp (fun exp' -> DotE (exp', a))
  | LenE exp -> t_e env exp (fun exp' -> LenE exp')
  | MixE (mo, exp) -> t_e env exp (fun exp' -> MixE (mo, exp'))
  | CallE (f, exp) ->t_e env exp (fun exp' -> CallE (f, exp'))
  | OptE (Some exp) ->t_e env exp (fun exp' -> OptE (Some exp'))
  | TheE exp ->t_e env exp (fun exp' -> TheE exp')
  | CaseE (a, exp) ->t_e env exp (fun exp' -> CaseE (a, exp'))
  | SubE (exp, a, b) -> t_e env exp (fun exp' -> SubE (exp', a, b))

  | BinE (bo, exp1, exp2) -> t_ee env (exp1, exp2) (fun (e1', e2') -> BinE (bo, e1', e2'))
  | CmpE (co, exp1, exp2) -> t_ee env (exp1, exp2) (fun (e1', e2') -> CmpE (co, e1', e2'))
  | IdxE (exp1, exp2) -> t_ee env (exp1, exp2) (fun (e1', e2') -> IdxE (e1', e2'))
  | CompE (exp1, exp2) -> t_ee env (exp1, exp2) (fun (e1', e2') -> CompE (e1', e2'))
  | CatE (exp1, exp2) -> t_ee env (exp1, exp2) (fun (e1', e2') -> CatE (e1', e2'))

  | SliceE (exp1, exp2, exp3) -> t_eee env (exp1, exp2, exp3) (fun (e1', e2', e3') -> SliceE (e1', e2', e3'))

  | UpdE (exp1, path, exp2) -> t_epe env (exp1, path, exp2) (fun (e1', p', e2') -> UpdE (e1', p', e2'))
  | ExtE (exp1, path, exp2) -> t_epe env (exp1, path, exp2) (fun (e1', p', e2') -> ExtE (e1', p', e2'))

  | StrE fields -> t_list t_field env fields (fun fields' -> StrE fields')

  | TupE es -> t_list t_exp env es (fun es' -> TupE es')
  | ListE es -> t_list t_exp env es (fun es' -> ListE es')

  | IterE (e, iterexp) ->
    let binds1, e' = t_exp env e in
    let iterexp', binds1' = under_iterexp iterexp binds1 in
    let binds2, iterexp'' = t_iterexp env iterexp' in
    binds1' @ binds2, IterE (e', iterexp'')

and t_field env ((a, e) : expfield) =
  unary t_exp env e (fun e' -> (a, e'))

and t_iterexp env (iter, vs) =
  unary t_iter env iter (fun iter' -> (iter', vs))

and t_iter env iter = match iter with
  | ListN (e, id_opt) -> unary t_exp env e (fun e' -> ListN (e', id_opt))
  | _ -> [], iter

and t_path env = phrase t_path' env

and t_path' env path = match path with
  | RootP -> [], path
  | IdxP (path, e) -> binary t_path t_exp env (path, e) (fun (path', e') -> IdxP (path', e'))
  | SliceP (path, e1, e2) -> ternary t_path t_exp t_exp env (path, e1, e2) (fun (path', e1', e2') -> SliceP (path', e1', e2'))
  | DotP (path, a) -> unary t_path env path (fun path' -> DotP (path', a))

let rec t_prem env : premise -> binds * premise = phrase t_prem' env

and t_prem' env prem : binds * premise' =
  match prem with
  | RulePr (a, b, exp) ->
    unary t_exp env exp (fun exp' -> RulePr (a, b, exp'))
  | IfPr e -> unary t_exp env e (fun e' -> IfPr e')
  | LetPr (e1, e2) -> binary t_exp t_exp env (e1, e2) (fun (e1', e2') -> LetPr (e1', e2'))
  | ElsePr -> [], prem
  | IterPr (prem, iterexp) ->
    let binds1, prem' = t_prem env prem in
    let iterexp', binds1' = under_iterexp iterexp binds1 in
    let binds2, iterexp'' = t_iterexp env iterexp' in
    binds1' @ binds2, IterPr (prem', iterexp'')

let t_prems env k  = t_list t_prem env k (fun x -> x)

let t_rule' env = function
  | RuleD (id, binds, mixop, exp, prems) ->
    (* Reset counter for fresh variables *)
    env.counter <- 0;
    let extra_binds, (exp', prems') = binary t_exp t_prems env (exp, prems) (fun x -> x) in
    RuleD (id, binds @ extra_binds, mixop, exp', prems')

let t_rule env x = { x with it = t_rule' env x.it }

let t_rules env = List.map (t_rule env)

let rec t_def' env = function
  | SynD (id, { it = VariantT []; _ }) as def ->
    env.unit_variants <- S.add id.it env.unit_variants;
    def
  | RecD defs -> RecD (t_defs env defs)
  | RelD (id, mixop, typ, rules) ->
    RelD (id, mixop, typ, t_rules env rules)
  | def -> def

and t_def env x = { x with it = t_def' env x.it }

and t_defs env = List.map (t_def env)

let transform (defs : script) =
  let env = new_env () in
  t_defs env defs

