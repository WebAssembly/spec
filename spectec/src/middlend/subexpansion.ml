open Util
open Source
open Il.Ast
open Il

(* Errors *)

let error at msg = Error.error at "sub expression expansion" msg

(* Environment *)

(* Global IL env*)
let env_ref = ref Il.Env.empty

module S = Set.Make(String)

let empty_tuple_exp at = TupE [] $$ at % (TupT [] $ at)

(* Computes the cartesian product of a given list. *)
let product_of_lists (lists : 'a list list) = 
  List.fold_left (fun acc lst ->
    List.concat_map (fun existing -> 
      List.map (fun v -> v :: existing) lst) acc) [[]] lists

let product_of_lists_append (lists : 'a list list) = 
  List.fold_left (fun acc lst ->
    List.concat_map (fun existing -> 
      List.map (fun v -> existing @ [v]) lst) acc) [[]] lists

let get_bind_id b =
  match b.it with
  | ExpB (id, _) | TypB id 
  | DefB (id, _, _) | GramB (id, _, _) -> id.it

let eq_sube (id, t1, t2) (id', t1', t2') =
  Eq.eq_id id id' && Eq.eq_typ t1 t1' && Eq.eq_typ t2 t2'

let rec collect_sube_exp e = 
  let c_func = collect_sube_exp in
  match e.it with
  (* Assumption - nested sub expressions do not exist. Must also be a varE. *)
  | SubE ({it = VarE id; _}, t1, t2) -> [id, t1, t2]
  | CallE (_, args) -> List.concat_map collect_sube_arg args
  | StrE fields -> List.concat_map (fun (_a, e1) -> c_func e1) fields
  | UnE (_, _, e1) | CvtE (e1, _, _) | LiftE e1 | TheE e1 | OptE (Some e1) 
  | ProjE (e1, _) | UncaseE (e1, _)
  | CaseE (_, e1) | LenE e1 | DotE (e1, _) -> c_func e1
  | BinE (_, _, e1, e2) | CmpE (_, _, e1, e2)
  | CompE (e1, e2) | MemE (e1, e2)
  | CatE (e1, e2) | IdxE (e1, e2) -> c_func e1 @ c_func e2
  | TupE exps | ListE exps -> List.concat_map collect_sube_exp exps
  | SliceE (e1, e2, e3) -> c_func e1 @ c_func e2 @ c_func e3
  | UpdE (e1, p, e2) 
  | ExtE (e1, p, e2) -> c_func e1 @ collect_fcalls_path p @ c_func e2
  | IterE (e1, (iter, id_exp_pairs)) -> 
    c_func e1 @ collect_sube_iter iter @
    List.concat_map (fun (_, exp) -> c_func exp) id_exp_pairs
  | _ -> []

and collect_sube_iter i = 
  match i with
  | ListN (e1, _) -> collect_sube_exp e1
  | _ -> []
    
and collect_sube_arg a =
  match a.it with
  | ExpA exp -> collect_sube_exp exp
  | _ -> []

and collect_fcalls_path p =
  match p.it with
  | RootP -> []
  | IdxP (p, e) -> collect_fcalls_path p @ collect_sube_exp e
  | SliceP (p, e1, e2) -> collect_fcalls_path p @ collect_sube_exp e1 @ collect_sube_exp e2
  | DotP (p, _) -> collect_fcalls_path p

let check_matching c_args match_args = 
  Option.is_some (try 
    Eval.match_list Eval.match_arg !env_ref Subst.empty c_args match_args 
    with Eval.Irred -> None)

let get_case_typ t = 
  match t.it with
  | TupT typs -> typs
  | _ -> [VarE ("_" $ t.at) $$ t.at % t, t]

let collect_all_instances case_typ ids at inst =
  match inst.it with
  | InstD (_, _, {it = VariantT typcases; _}) when 
    List.for_all (fun (_, (_, t, _), _) -> t.it = TupT []) typcases  -> 
    [], List.map (fun (m, _, _) -> CaseE (m, empty_tuple_exp no_region) $$ at % case_typ) typcases
  | InstD (_, _, {it = VariantT typcases; _}) -> 
    let _, binds, new_cases = 
      List.fold_left (fun (ids', binds, cases) (m, (_, t, _), _) ->
        let typs = get_case_typ t in
        let new_binds, typs' = Utils.improve_ids_binders ids' true t.at typs in
        let exps = List.map fst typs' in 
        let tup_exp = TupE exps $$ at % t in
        let case_exp = CaseE (m, tup_exp) $$ at % case_typ in
        let new_ids = List.map get_bind_id new_binds in 
        (new_ids @ ids', new_binds @ binds, case_exp :: cases)  
      ) (ids, [], []) typcases
    in
    binds, new_cases
  | _ -> error at "Expected a variant type"

let rec collect_all_instances_typ ids at typ =
  match typ.it with
  | VarT (var_id, dep_args) -> let (_, insts) = Il.Env.find_typ !env_ref var_id in 
    (match insts with
    | [] -> ([], []) (* Should never happen *)
    | _ -> 
      let inst_opt = List.find_opt (fun inst -> 
        match inst.it with 
        | InstD (_, args, _) -> check_matching dep_args args
      ) insts in
      match inst_opt with
      | None -> error at ("Could not find specific instance for typ: " ^ Il.Print.string_of_typ typ)
      | Some inst -> collect_all_instances typ ids at inst
    )
  | TupT exp_typ_pairs -> 
    let (binds_lst, instances_list) = List.map (fun (_, t) -> 
      collect_all_instances_typ ids at t
    ) exp_typ_pairs |> List.split in
    List.concat binds_lst, List.map (fun exps -> TupE exps $$ at % typ) (product_of_lists_append instances_list)
  | _ -> ([], [])

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

let t_clause _env clause =
  match clause.it with 
  | DefD (binds, lhs, rhs, prems) ->
    let subs = List.concat_map (fun a -> 
      Lib.List.nub eq_sube (collect_sube_arg a)
    ) lhs in
    let ids = List.map get_bind_id binds in
    let binds', cases = 
      List.fold_left (fun (binds, cases) (id, t1, _) -> 
        let new_binds, cases' = collect_all_instances_typ ids id.at t1 in 
        let cases'' = List.map (fun e -> (id, e)) cases' in
        (new_binds @ binds, cases'' :: cases)
      ) (binds, []) subs 
    in
    let cases' = product_of_lists cases in
    let subst_list = List.map (List.fold_left (fun acc (id, exp) -> 
      Il.Subst.add_varid acc id exp) Il.Subst.empty
    ) cases' in
    List.map (fun subst -> 
      let binds_filtered = Lib.List.filter_not (fun b -> match b.it with
        | ExpB (id, _) -> Il.Subst.mem_varid subst id  
        | _ -> false
      ) binds' in 
      let new_lhs = Il.Subst.subst_args subst lhs in
      let new_prems = Il.Subst.subst_list Il.Subst.subst_prem subst prems in
      let new_rhs = Il.Subst.subst_exp subst rhs in
      (* Reduction is done here to remove subtyping expressions *)
      DefD (binds_filtered, List.map (Il.Eval.reduce_arg !env_ref) new_lhs, new_rhs, new_prems) $ clause.at
    ) subst_list

let t_clauses env = List.concat_map (t_clause env)

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

let rec t_def env def = 
  match def.it with
  | RecD defs -> { def with it = RecD (List.map (t_def env) defs) }
  | DecD (id, params, typ, clauses) ->
    { def with it = DecD (id, t_params env params, t_typ env typ, t_clauses env clauses) }
  | TypD (id, params, insts) ->
    { def with it = TypD (id, t_params env params, t_insts env insts) }
  | RelD (id, mixop, typ, rules) ->
    { def with it = RelD (id, mixop, t_typ env typ, List.map (t_rule env) rules) }
  | GramD (id, params, typ, prods) ->
    { def with it = GramD (id, t_params env params, t_typ env typ, t_prods env prods) }
  | HintD _ -> def

let transform (defs : script) =
  env_ref := Il.Env.env_of_script defs;
  let env = () in 
  List.map (t_def env) defs