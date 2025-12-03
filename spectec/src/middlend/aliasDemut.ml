(*
Lifts type aliases out of mutual groups.
*)

open Util
open Source
open Il.Ast

(* Errors *)

let error at msg = Error.error at "alias recursion lifting" msg

(* Environment *)

(* Global IL env*)
let env_ref = ref Il.Env.empty

module S = Set.Make(String)

type env = {
  aliases : S.t; (* Aliases to reduce *)
}

(* The main transformation case *)

let rec t_typ env x =
  match x.it with
  | VarT (id, []) when S.mem id.it env.aliases -> Il.Eval.reduce_typ !env_ref x
  | _ -> t_typ2 env x

(* Traversal boilerplate *)

and t_typ2 env x = { x with it = t_typ' env x.it }

and t_typ' env = function
  | VarT (id, args) -> VarT (id, t_args env args)
  | (BoolT | NumT _ | TextT) as t -> t
  | TupT xts -> TupT (List.map (fun (id, t) -> (id, t_typ env t)) xts)
  | IterT (t, iter) -> IterT (t_typ env t, iter)

and t_deftyp env x = { x with it = t_deftyp' env x.it }

and t_deftyp' env = function
  | AliasT t -> AliasT (t_typ env t)
  | StructT typfields -> StructT (List.map (t_typfield env) typfields)
  | VariantT typcases -> VariantT (List.map (t_typcase env) typcases)

and t_typfield env (atom, (binds, t, prems), hints) =
  (atom, (t_binds env binds, t_typ env t, t_prems env prems), hints)
and t_typcase env (atom, (binds, t, prems), hints) =
  (atom, (t_binds env binds, t_typ env t, t_prems env prems), hints)

and t_exp env x = { x with it = t_exp' env x.it; note = t_typ env x.note }

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
  | LiftE exp -> LiftE (t_exp env exp)
  | LenE exp -> LenE (t_exp env exp)
  | TupE es -> TupE (List.map (t_exp env) es)
  | CallE (a, args) -> CallE (a, t_args env args)
  | IterE (e, iterexp) -> IterE (t_exp env e, t_iterexp env iterexp)
  | ProjE (e, i) -> ProjE (t_exp env e, i)
  | UncaseE (e, mixop) -> UncaseE (t_exp env e, mixop)
  | OptE None -> OptE None
  | OptE (Some exp) -> OptE (Some (t_exp env exp))
  | TheE exp -> TheE (t_exp env exp)
  | ListE es -> ListE (List.map (t_exp env) es)
  | CatE (exp1, exp2) -> CatE (t_exp env exp1, t_exp env exp2)
  | MemE (exp1, exp2) -> MemE (t_exp env exp1, t_exp env exp2)
  | CaseE (mixop, e) -> CaseE (mixop, t_exp env e)
  | CvtE (exp, t1, t2) -> CvtE (t_exp env exp, t1, t2)
  | SubE (e, t1, t2) -> SubE (e, t1, t2)
  | IfE (e1, e2, e3) -> IfE (t_exp env e1, t_exp env e2, t_exp env e3)

and t_iter env = function
  | ListN (e, id_opt) -> ListN (t_exp env e, id_opt)
  | i -> i

and t_iterexp env (iter, vs) =
  (t_iter env iter, List.map (fun (id, e) -> (id, t_exp env e)) vs)

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
  | NegPr prem -> NegPr (t_prem env prem)
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

let t_clauses env = List.map (t_clause env)

let t_inst' env = function
 | InstD (binds, args, deftyp) ->
   InstD (t_binds env binds, t_args env args, t_deftyp env deftyp)

let t_inst env (inst : inst) = { inst with it = t_inst' env inst.it }

let t_insts env = List.map (t_inst env)

let t_prod' env = function
 | ProdD (binds, lhs, rhs, prems) ->
   ProdD (t_binds env binds, t_sym env lhs, t_exp env rhs, t_prems env prems)

let t_prod env (prod : prod) = { prod with it = t_prod' env prod.it }

let t_prods env = List.map (t_prod env)

let t_rule' env = function
  | RuleD (id, binds, mixop, exp, prems) ->
    RuleD (id, t_binds env binds, mixop, t_exp env exp, t_prems env prems)

let t_rule env x = { x with it = t_rule' env x.it }

let alias_def_id def = 
  match def.it with
  | TypD(id, _, [{it = InstD (_, _, {it = AliasT _; _}); _}]) -> Some id.it
  | _ -> None

let is_alias_typ_def def = Option.is_some (alias_def_id def)

let rec t_def env def = 
  match def.it with
  | RecD defs ->
      let alias_defs, other_defs = List.partition is_alias_typ_def defs in
      let new_ids = List.filter_map alias_def_id alias_defs in
      let env' = { aliases = S.union env.aliases (S.of_list new_ids) } in
      let other_defs = List.concat_map (t_def env') other_defs in
      let alias_defs = List.concat_map (t_def env') alias_defs in
      if other_defs = [] then
        error (at def) "mutual group consists entirely of type aliases; at least one non-alias definition is required"
      else
        [ { def with it = RecD other_defs} ] @ alias_defs
  | DecD (id, params, typ, clauses) ->
    [ { def with it = DecD (id, t_params env params, t_typ env typ, t_clauses env clauses) } ]
  | TypD (id, params, insts) ->
    [ { def with it = TypD (id, t_params env params, t_insts env insts) } ]
  | RelD (id, mixop, typ, rules) ->
    [ { def with it = RelD (id, mixop, t_typ env typ, List.map (t_rule env) rules) } ]
  | GramD (id, params, typ, prods) ->
    [ { def with it = GramD (id, t_params env params, t_typ env typ, t_prods env prods) } ]
  | HintD _ -> [ def ]

let transform (defs : script) =
  env_ref := Il.Env.env_of_script defs;
  let env = { aliases = S.empty } in
  List.concat_map (t_def env) defs
