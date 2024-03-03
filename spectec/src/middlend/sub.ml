(*
This transformation replaces SubE expressions with explicit subtype injection
functions.

 1. It traverses all expressions and finds out which type pairs
    occur in SubE expressions
    - all type pairs mentioned in SubE expressions
    - for all variant types: list of constructors
    - for all alias types: right hand side of the alias

 2. It traverses all definitions to collect information about variant types and
    type aliases (assuming only such types occur in type aliases).

 3. It generates explicit injection functions for pairs, and put them in the
 right spot (after both types are defined, but outside `RecD` groups)

 4. It replaces occurrences of SubE with a suitable CallE

Step 1 and 4 are done together, and step 2 and 3

This pass assumes that there is no name shadowing in the type definitions.

*)

open Util
open Source
open Il.Ast

(* Errors *)

let error at msg = Source.error at "subtype elimination" msg

(* Environment *)

module M = Map.Make(String)
module S = Set.Make(struct
  type t = id * id
  let compare (t1, t2) (t3, t4) = compare (t1.it, t2.it) (t3.it, t4.it)
end)

(*
The environment consist of:
  * Which constructors the type has (and their non-aliased concrete type)
  * Which SubE type pairs have been observed, but not yet generated
*)
type env =
  { mutable typ : (param list * id * arg list * typcase list) M.t;
    mutable pairs : S.t
  }

let new_env () : env =
  { typ = M.empty;
    pairs = S.empty;
  }

let lookup (env : env) (id : id) : param list * id * arg list * typcase list =
  match M.find_opt id.it env.typ with
  | None -> error id.at ("unknown type `" ^ id.it ^ "`")
  | Some t -> t

let arg_of_param param =
  match param.it with
  | ExpP (id, t) -> ExpA (VarE id $$ param.at % t) $ param.at
  | TypP id -> TypA (VarT (id, []) $ param.at) $ param.at

let register_variant (env : env) (id : id) params (cases : typcase list) =
  if M.mem id.it env.typ then
    error id.at ("duplicate declaration for type `" ^ id.it ^ "`")
  else
    env.typ <- M.add id.it (params, id, List.map arg_of_param params, cases) env.typ

let subst_of_args =
  List.fold_left2 (fun s arg param ->
    match arg.it, param.it with
    | ExpA e, ExpP (id, _) -> Il.Subst.add_varid s id e
    | TypA t, TypP id -> Il.Subst.add_typid s id t
    | _, _ -> assert false
  ) Il.Subst.empty

let register_alias (env : env) (id : id) params (id2 : id) args =
  match M.find_opt id2.it env.typ with
  | Some (params2, id3, args2, cases) ->
    let s = subst_of_args args params2 in
    let args' = Il.Subst.(subst_list subst_arg s args2) in
    let cases' = Il.Subst.(subst_list subst_typcase s cases) in
    env.typ <- M.add id.it (params, id3, args', cases') env.typ
  | None -> () (* Not an alias of a variant type *)

let injection_name (sub : id) (sup : id) = sup.it ^ "_" ^ sub.it $ no_region

let var_of_typ typ = match typ.it with
  | VarT (id, args) -> Some (id, args)
  | NumT _ -> None
  | _ -> error typ.at ("Non-variable or number type expression not supported `" ^ Il.Print.string_of_typ typ ^ "`")

(* Step 1 and 4: Collect SubE occurrences, and replace with function *)

(* The main transformation case *)
let rec t_exp env exp =
  let exp' = t_exp2 env exp in
  match exp'.it with
  | SubE (e, sub_ty, sup_ty) ->
(Printf.eprintf "[sub @ %s] %s  <:  %s\n%!" (string_of_region exp'.at) (Il.Print.string_of_typ sub_ty) (Il.Print.string_of_typ sup_ty);
    begin match var_of_typ sub_ty, var_of_typ sup_ty with
    | Some (sub, args_sub), Some (sup, args_sup) ->
      env.pairs <- S.add (sub, sup) env.pairs;
      { exp' with it = CallE (injection_name sub sup, args_sub @ args_sup @ [ExpA e $ e.at])}
    | _, _ ->
Printf.eprintf "[sub @ %s REMAINS] %s  <:  %s\n%!" (string_of_region exp'.at) (Il.Print.string_of_typ sub_ty) (Il.Print.string_of_typ sup_ty);
     exp'
    end
)
  | _ -> exp'

(* Traversal boilerplate *)

and t_typ env x = { x with it = t_typ' env x.it }

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

and t_exp2 env x = { x with it = t_exp' env x.it; note = t_typ env x.note }

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
  | DotE (e, a) -> DotE (t_exp env e, a)
  | CompE (exp1, exp2) -> CompE (t_exp env exp1, t_exp env exp2)
  | LenE exp -> LenE exp
  | TupE es -> TupE (List.map (t_exp env) es)
  | CallE (a, args) -> CallE (a, t_args env args)
  | IterE (e, iterexp) -> IterE (t_exp env e, t_iterexp env iterexp)
  | ProjE (e, i) -> ProjE (t_exp env e, i)
  | UncaseE (e, mixop) -> UncaseE (t_exp env e, mixop)
  | OptE None -> OptE None
  | OptE (Some exp) -> OptE (Some exp)
  | TheE exp -> TheE exp
  | ListE es -> ListE (List.map (t_exp env) es)
  | CatE (exp1, exp2) -> CatE (t_exp env exp1, t_exp env exp2)
  | CaseE (mixop, e) -> CaseE (mixop, t_exp env e)
  | SubE (e, t1, t2) -> SubE (e, t1, t2)

and t_iter env = function
  | ListN (e, id_opt) -> ListN (t_exp env e, id_opt)
  | i -> i

and t_iterexp env (iter, vs) = (t_iter env iter, vs)

and t_path' env = function
  | RootP -> RootP
  | IdxP (path, e) -> IdxP (t_path env path, t_exp env e)
  | SliceP (path, e1, e2) -> SliceP (t_path env path, t_exp env e1, t_exp env e2)
  | DotP (path, a) -> DotP (t_path env path, a)

and t_path env x = { x with it = t_path' env x.it; note = t_typ env x.note }

and t_arg' env = function
  | ExpA exp -> ExpA (t_exp env exp)
  | TypA t -> TypA t

and t_arg env x = { x with it = t_arg' env x.it }

and t_bind' env = function
  | ExpB (id, t, dim) -> ExpB (id, t_typ env t, dim)
  | TypB id -> TypB id

and t_bind env x = { x with it = t_bind' env x.it }

and t_param' env = function
  | ExpP (id, t) -> ExpP (id, t_typ env t)
  | TypP id -> TypP id

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
   DefD (t_binds env binds, (*DO NOT intro calls on LHS: t_args env*) lhs, t_exp env rhs, t_prems env prems)

let t_clause env (clause : clause) = { clause with it = t_clause' env clause.it }

let t_clauses env = List.map (t_clause env)

let t_inst' env = function
 | InstD (binds, args, deftyp) ->
   InstD (t_binds env binds, (*DO NOT intro calls on LHS: t_args env*) args, t_deftyp env deftyp)

let t_inst env (inst : inst) = { inst with it = t_inst' env inst.it }

let t_insts env = List.map (t_inst env)

let t_rule' env = function
  | RuleD (id, binds, mixop, exp, prems) ->
    RuleD (id, t_binds env binds, mixop, t_exp env exp, t_prems env prems)

let t_rule env x = { x with it = t_rule' env x.it }

let rec t_def' env = function
  | RecD defs -> RecD (List.map (t_def env) defs)
  | DecD (id, params, typ, clauses) ->
    DecD (id, t_params env params, typ, t_clauses env clauses)
  | TypD (id, params, insts) ->
    TypD (id, t_params env params, t_insts env insts)
  | RelD (id, mixop, typ, rules) ->
    RelD (id, mixop, t_typ env typ, List.map (t_rule env) rules)
  | HintD _ as def -> def

and t_def env (def : def) = { def with it = t_def' env def.it }

(* Step 2 and 3: Traverse definitions, collect type information, insert as soon as possible *)

let rec add_type_info env (def : def) = match def.it with
  | RecD defs -> List.iter (add_type_info env) defs
  | TypD (id, params, [inst]) ->  (* TODO: handle type families *)
    let InstD (_, _, deftyp) = inst.it in
    begin match deftyp.it with
    | VariantT cases -> register_variant env id params cases
    | AliasT {it = VarT (id2, args); _} -> register_alias env id params id2 args
    | _ -> ()
    end
  | _ ->()

let is_ready env (t1, t2) = M.mem t1.it env.typ && M.mem t2.it env.typ

(* Returns type pairs that are defined now, and removes them from the env *)
let ready_pairs (env : env) =
  let (ready, todo) = S.partition (is_ready env) env.pairs in
  env.pairs <- todo;
  S.elements ready


(* Rename parameters to avoid name clashes *)
let rec rename_params s = function
  | [] -> []
  | { it = ExpP (id, t); at; _ } :: params ->
    let id' = (id.it ^ "_2") $ id.at in
    let t' = Il.Subst.subst_typ s t in
    (ExpP (id', t') $ at) ::
      rename_params (Il.Subst.add_varid s id (VarE id' $$ id.at % t')) params
  | { it = TypP id; at; _ } :: params ->
    let id' = (id.it ^ "_2") $ id.at in
    (TypP id' $ at) ::
      rename_params (Il.Subst.add_typid s id (VarT (id', []) $ id.at)) params

let insert_injections env (def : def) : def list =
  add_type_info env def;
  let pairs = ready_pairs env in
  [ def ] @
  List.map (fun (sub, sup) ->
    let name = injection_name sub sup in
    let (params_sub, real_id_sub, args_sub, cases_sub) = lookup env sub in
    let (params_sup, _, _, _) = lookup env sup in
    let params_sup' = rename_params Il.Subst.empty params_sup in
    let sub_ty = VarT (sub, List.map arg_of_param params_sub) $ no_region in
    let sup_ty = VarT (sup, List.map arg_of_param params_sup') $ no_region in
    let real_ty = VarT (real_id_sub, args_sub) $ no_region in
    let clauses = List.map (fun (a, (_binds, arg_typ, _prems), _hints) ->
      match arg_typ.it with
      | TupT ts ->
        let binds = List.mapi (fun i (_, arg_typ_i) -> ExpB ("x" ^ string_of_int i $ no_region, arg_typ_i, []) $ no_region) ts in
        let xes = List.map (fun bind ->
          match bind.it with
          | ExpB (x, arg_typ_i, _) -> VarE x $$ no_region % arg_typ_i
          | TypB _ -> assert false) binds
        in
        let xe = TupE xes $$ no_region % arg_typ in
        DefD (binds,
          [ExpA (CaseE (a, xe) $$ no_region % real_ty) $ no_region],
          CaseE (a, xe) $$ no_region % sup_ty, []) $ no_region
      | _ ->
        let x = "x" $ no_region in
        let xe = VarE x $$ no_region % arg_typ in
        DefD ([ExpB (x, arg_typ, []) $ x.at],
          [ExpA (CaseE (a, xe) $$ no_region % real_ty) $ no_region],
          CaseE (a, xe) $$ no_region % sup_ty, []) $ no_region
      ) cases_sub in
    DecD (name, params_sub @ params_sup' @ [ExpP ("_" $ no_region, sub_ty) $ no_region], sup_ty, clauses) $ no_region
  ) pairs


let transform (defs : script) =
  let env = new_env () in
  let defs' = List.map (t_def env) defs in
  let defs'' = List.concat_map (insert_injections env) defs' in
  S.iter (fun (sub, sup) -> error sup.at ("left-over subtype coercion `" ^ sub.it ^ "` <: `" ^ sup.it ^ "`")) env.pairs;
  defs''

