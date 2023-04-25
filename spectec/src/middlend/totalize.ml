(*
This transformation totalizes partial functions.

Partial functions are recognized by the partial flag hint (for now, inference
would be possible).

The declarations are changed:

 * the return type is wrapped in the option type `?`
 * all clauses rhs' are wrapped in the option type injection `?(…)`
 * a catch-all clause is added returning `null`

All calls to such functions are wrapped in option projection `THE e`.

*)

open Util
open Source
open Il.Ast

(* Errors *)

let _error at msg = Source.error at "totalize" msg

(* Environment *)

module S = Set.Make(String)

type env =
  { mutable partial_funs : S.t;
  }

let new_env () : env =
  { partial_funs = S.empty;
  }

let is_partial (env : env) (id : id) = S.mem id.it env.partial_funs

let register_partial (env : env) (id :id) =
  env.partial_funs <- S.add id.it env.partial_funs

(* Transformation *)

(* The main transformation case *)
let rec t_exp env exp =
  let exp' = t_exp2 env exp in
  match exp'.it with
  | CallE (f, _) when is_partial env f ->
    TheE exp' $ no_region
  | _ -> exp'

and t_exp2 env x = { x with it = t_exp' env x.it }

(* Expr traversal *)
and t_exp' env = function
  | (VarE _ | BoolE _ | NatE _ | TextE _) as e -> e
  | UnE (unop, exp) -> UnE (unop, t_exp env exp)
  | BinE (binop, exp1, exp2) -> BinE (binop, t_exp env exp1, t_exp env exp2)
  | CmpE (cmpop, exp1, exp2) -> CmpE (cmpop, t_exp env exp1, t_exp env exp2)
  | IdxE (exp1, exp2) -> IdxE (t_exp env exp1, t_exp env exp2)
  | SliceE (exp1, exp2, exp3) -> SliceE (t_exp env exp1, t_exp env exp2, t_exp env exp3)
  | UpdE (exp1, path, exp2) -> UpdE (t_exp env exp1, t_path env path, t_exp env exp2)
  | ExtE (exp1, path, exp2) -> ExtE (t_exp env exp1, t_path env path, t_exp env exp2)
  | StrE fields -> StrE (List.map (fun (a, e) -> a, t_exp env e) fields)
  | DotE (t, e, a) -> DotE (t, t_exp env e, a)
  | CompE (exp1, exp2) -> CompE (t_exp env exp1, t_exp env exp2)
  | LenE exp -> LenE exp
  | TupE es -> TupE (List.map (t_exp env) es)
  | MixE (mixop, exp) -> MixE (mixop, t_exp env exp)
  | CallE (a, exp) -> CallE (a, t_exp env exp)
  | IterE (e, iterexp) -> IterE (t_exp env e, t_iterexp env iterexp)
  | OptE None -> OptE None
  | OptE (Some exp) -> OptE (Some exp)
  | TheE exp -> TheE exp
  | ListE es -> ListE (List.map (t_exp env) es)
  | CatE (exp1, exp2) -> CatE (t_exp env exp1, t_exp env exp2)
  | CaseE (a, e, t) -> CaseE (a, t_exp env e, t)
  | SubE (e, t1, t2) -> SubE (e, t1, t2)

and t_iter env = function
  | ListN e -> ListN (t_exp env e)
  | i -> i

and t_iterexp env (iter, vs) = (t_iter env iter, vs)

and t_path' env = function
  | RootP -> RootP
  | IdxP (path, e) -> IdxP (t_path env path, t_exp env e)
  | SliceP (path, e1, e2) -> SliceP (t_path env path, t_exp env e1, t_exp env e2)
  | DotP (path, a) -> DotP (t_path env path, a)

and t_path env x = { x with it = t_path' env x.it }

let rec t_prem' env = function
  | RulePr (id, mixop, exp) -> RulePr (id, mixop, t_exp env exp)
  | IfPr e -> IfPr (t_exp env e)
  | AssignPr (e1, e2) -> AssignPr (t_exp env e1, t_exp env e2)
  | ElsePr -> ElsePr
  | IterPr (prem, iterexp) -> IterPr (t_prem env prem, t_iterexp env iterexp)

and t_prem env x = { x with it = t_prem' env x.it }

let t_prems env = List.map (t_prem env)

let t_clause' env = function
 | DefD (binds, lhs, rhs, prems) ->
  DefD (binds, t_exp env lhs, t_exp env rhs, t_prems env prems)

let t_clause env (clause : clause) = { clause with it = t_clause' env clause.it }

let t_rule' env = function
  | RuleD (id, binds, mixop, exp, prems) ->
    RuleD (id, binds, mixop, t_exp env exp, t_prems env prems)

let t_rule env x = { x with it = t_rule' env x.it }

let rec t_def' env = function
  | RecD defs -> RecD (List.map (t_def env) defs)
  | DecD (id, typ1, typ2, clauses) ->
    let clauses' = List.map (t_clause env) clauses in
    if is_partial env id
    then
      let typ2' = IterT (typ2, Opt) $ no_region in
      let clauses'' = List.map (fun clause -> match clause.it with
        DefD (binds, lhs, rhs, prems) ->
          { clause with it = DefD (binds, lhs, OptE (Some rhs) $ no_region, prems) }
        ) clauses' in
      let x = "x" $ no_region in
      let catch_all = DefD ([(x, typ1, [])], VarE x $ no_region, OptE None $ no_region, []) $ no_region in
      DecD (id, typ1, typ2', clauses'' @ [ catch_all ])
    else
      DecD (id, typ1, typ2, clauses')
  | RelD (id, mixop, typ, rules) ->
    RelD (id, mixop, typ, List.map (t_rule env) rules)
  | (SynD _ | HintD _) as def -> def

and t_def env x = { x with it = t_def' env x.it }


let is_partial_hint hint = hint.hintid.it = "partial"

let register_hints env def =
  match def.it with
  | HintD {it = DecH (id, hints); _} when List.exists is_partial_hint hints ->
    register_partial env id
  | _ -> ()

let transform (defs : script) =
  let env = new_env () in
  List.iter (register_hints env) defs;
  List.map (t_def env) defs

