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

let _error at msg = Error.error at "totality" msg

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
    {exp' with it = TheE {exp' with note = IterT (exp'.note, Opt) $ exp'.at}}
  | _ -> exp'


(* Type traversal *)

and t_typ env x = { x with it = t_typ' env x.it }

and t_typ' env = function
  | VarT (id, args) -> VarT (id, t_args env args)
  | (BoolT | NumT _ | TextT) as t -> t
  | TupT xts -> TupT (List.map (fun (id, t) -> (id, t_typ env t)) xts)
  | IterT (t, iter) -> IterT (t_typ env t, t_iter env iter)

and t_deftyp env x = { x with it = t_deftyp' env x.it }

and t_deftyp' env = function
  | AliasT t -> AliasT (t_typ env t)
  | StructT typfields -> StructT (List.map (t_typfield env) typfields)
  | VariantT typcases -> VariantT (List.map (t_typcase env) typcases)

and t_typfield env (atom, (binds, t, prems), hints) =
  (atom, (t_binds env binds, t_typ env t, t_prems env prems), hints)
and t_typcase env (atom, (binds, t, prems), hints) =
  (atom, (t_binds env binds, t_typ env t, t_prems env prems), hints)


(* Expr traversal *)

and t_exp2 env x = { x with it = t_exp' env x.it; note = t_typ env x.note }

and t_exp' env = function
  | (VarE _ | BoolE _ | NumE _ | TextE _) as e -> e
  | UnE (unop, nto, exp) -> UnE (unop, nto, t_exp env exp)
  | BinE (binop, nto, exp1, exp2) -> BinE (binop, nto, t_exp env exp1, t_exp env exp2)
  | CmpE (cmpop, nto, exp1, exp2) -> CmpE (cmpop, nto, t_exp env exp1, t_exp env exp2)
  | IdxE (exp1, exp2) -> IdxE (t_exp env exp1, t_exp env exp2)
  | SliceE (exp1, exp2, exp3) -> SliceE (t_exp env exp1, t_exp env exp2, t_exp env exp3)
  | UpdE (exp1, path, exp2) -> UpdE (t_exp env exp1, t_path env path, t_exp env exp2)
  | ExtE (exp1, path, exp2) -> ExtE (t_exp env exp1, t_path env path, t_exp env exp2)
  | StrE fields -> StrE (List.map (fun (a, e) -> a, t_exp env e) fields)
  | DotE (e, a) -> DotE (t_exp env e, a)
  | CompE (exp1, exp2) -> CompE (t_exp env exp1, t_exp env exp2)
  | LenE exp -> LenE (t_exp env exp)
  | TupE es -> TupE (List.map (t_exp env) es)
  | CallE (a, args) -> CallE (a, List.map (t_arg env) args)
  | IterE (e, iterexp) -> IterE (t_exp env e, t_iterexp env iterexp)
  | ProjE (e, i) -> ProjE (t_exp env e, i)
  | UncaseE (e, mixop) -> UncaseE (t_exp env e, mixop)
  | OptE None -> OptE None
  | OptE (Some exp) -> OptE (Some (t_exp env exp))
  | TheE exp -> TheE (t_exp env exp)
  | ListE es -> ListE (List.map (t_exp env) es)
  | LiftE exp -> LiftE (t_exp env exp)
  | CatE (exp1, exp2) -> CatE (t_exp env exp1, t_exp env exp2)
  | MemE (exp1, exp2) -> MemE (t_exp env exp1, t_exp env exp2)
  | CaseE (mixop, e) -> CaseE (mixop, t_exp env e)
  | CvtE (exp, t1, t2) -> CvtE (t_exp env exp, t1, t2)
  | SubE (exp, t1, t2) -> SubE (t_exp env exp, t_typ env t1, t_typ env t2)

and t_iter env = function
  | ListN (e, id_opt) -> ListN (t_exp env e, id_opt)
  | i -> i

and t_iterexp env (iter, xes) =
  (t_iter env iter, List.map (fun (x, e) -> x, t_exp env e) xes)

and t_path' env = function
  | RootP -> RootP
  | IdxP (path, e) -> IdxP (t_path env path, t_exp env e)
  | SliceP (path, e1, e2) -> SliceP (t_path env path, t_exp env e1, t_exp env e2)
  | DotP (path, a) -> DotP (t_path env path, a)

and t_path env x = { x with it = t_path' env x.it; note = t_typ env x.note }

and t_sym' env = function
  | VarG (id, args) -> VarG (id, t_args env args)
  | (NumG _ | TextG _ | EpsG) as g -> g
  | SeqG syms -> SeqG (List.map (t_sym env) syms)
  | AltG syms -> AltG (List.map (t_sym env) syms)
  | RangeG (sym1, sym2) -> RangeG (t_sym env sym1, t_sym env sym2)
  | IterG (sym, iter) -> IterG (t_sym env sym, t_iterexp env iter)
  | AttrG (e, sym) -> AttrG (t_exp env e, t_sym env sym)

and t_sym env x = { x with it = t_sym' env x.it }

and t_arg' env = function
  | ExpA exp -> ExpA (t_exp env exp)
  | TypA t -> TypA (t_typ env t)
  | DefA id -> DefA id
  | GramA sym -> GramA (t_sym env sym)

and t_arg env x = { x with it = t_arg' env x.it }

and t_bind' env = function
  | ExpB (id, t) -> ExpB (id, t_typ env t)
  | TypB id -> TypB id
  | DefB (id, ps, t) -> DefB (id, t_params env ps, t_typ env t)
  | GramB (id, ps, t) -> GramB (id, t_params env ps, t_typ env t)

and t_bind env x = { x with it = t_bind' env x.it }

and t_param' env = function
  | ExpP (id, t) -> ExpP (id, t_typ env t)
  | TypP id -> TypP id
  | DefP (id, ps, t) -> DefP (id, t_params env ps, t_typ env t)
  | GramP (id, t) -> GramP (id, t_typ env t)

and t_param env x = { x with it = t_param' env x.it }

and t_args env = List.map (t_arg env)
and t_binds env = List.map (t_bind env)
and t_params env = List.map (t_param env)

and t_prem' env = function
  | RulePr (id, mixop, exp) -> RulePr (id, mixop, t_exp env exp)
  | IfPr e -> IfPr (t_exp env e)
  | LetPr (e1, e2, ids) -> LetPr (t_exp env e1, t_exp env e2, ids)
  | ElsePr -> ElsePr
  | IterPr (prem, iterexp) -> IterPr (t_prem env prem, t_iterexp env iterexp)

and t_prem env x = { x with it = t_prem' env x.it }

and t_prems env = List.map (t_prem env)

let t_clause' env = function
 | DefD (binds, lhs, rhs, prems) ->
   DefD (t_binds env binds, t_args env lhs, t_exp env rhs, t_prems env prems)

let t_clause env (clause : clause) = { clause with it = t_clause' env clause.it }

let t_inst' env = function
 | InstD (binds, args, deftyp) ->
   InstD (t_binds env binds, t_args env args, t_deftyp env deftyp)

let t_inst env (inst : inst) = { inst with it = t_inst' env inst.it }

let t_insts env = List.map (t_inst env)

let t_prod' env = function
 | ProdD (binds, lhs, rhs, prems) ->
   ProdD (t_binds env binds, t_sym env lhs, t_exp env rhs, t_prems env prems)

let t_prod env (prod : prod) = { prod with it = t_prod' env prod.it }

let t_rule' env = function
  | RuleD (id, binds, mixop, exp, prems) ->
    RuleD (id, t_binds env binds, mixop, t_exp env exp, t_prems env prems)

let t_rule env x = { x with it = t_rule' env x.it }

let rec t_def' env = function
  | RecD defs -> RecD (List.map (t_def env) defs)
  | DecD (id, params, typ, clauses) ->
    let params' = t_params env params in
    let typ' = t_typ env typ in
    let clauses' = List.map (t_clause env) clauses in
    if is_partial env id then
      let typ'' = IterT (typ', Opt) $ no_region in
      let clauses'' = List.map (fun clause -> match clause.it with
        DefD (binds, lhs, rhs, prems) ->
          { clause with
            it = DefD (t_binds env binds, lhs, OptE (Some rhs) $$ no_region % typ'', prems) }
        ) clauses' in
      let binds, args = List.mapi (fun i param -> match param.it with
        | ExpP (_, typI) ->
          let x = ("x" ^ string_of_int i) $ no_region in
          [ExpB (x, typI) $ x.at], ExpA (VarE x $$ no_region % typI) $ no_region
        | TypP id -> [], TypA (VarT (id, []) $ no_region) $ no_region
        | DefP (id, _, _) -> [], DefA id $ no_region
        | GramP (id, _) -> [], GramA (VarG (id, []) $ no_region) $ no_region
        ) params' |> List.split in
      let catch_all = DefD (List.concat binds, args,
        OptE None $$ no_region % typ'', []) $ no_region in
      DecD (id, params', typ'', clauses'' @ [ catch_all ])
    else
      DecD (id, params', typ', clauses')
  | TypD (id, params, insts) ->
    TypD (id, t_params env params, t_insts env insts)
  | RelD (id, mixop, typ, rules) ->
    RelD (id, mixop, t_typ env typ, List.map (t_rule env) rules)
  | GramD (id, params, typ, prods) ->
    GramD (id, t_params env params, typ, List.map (t_prod env) prods)
  | HintD _ as def -> def

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

