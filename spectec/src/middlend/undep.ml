(*
This transformation separates indexed types into simple types and their corresponding
wellformedness predicate. 

This is achieved through the following steps:
  * Create the wellformedness predicate as a relation that takes in the corresponding
  type, and its dependent type parameters. 
    * For variants, it creates a wellformedness case for each variant case. it supplies
    the premises that the indexed type used to have.
    * For structs/records, it creates a singular case where all premises of all fields
    are checked.
  * For definitions and relations, we collect terms that should have a wellformedness check 
  and add it to the current premise list. This results in wellformedness predicates being
  "bubbled up."
  * Then finally, we traverse through the IL, removing any notion of indexed types.

As an example,
given the following variant indexed type:

syntax foo(v : t) = 
  | CASE{v2 : t}(v2 : t)
  -- if v = v2

where t is an arbitrary type, and v and v2 are terms of type t.

Assume that type t needs a wellformedness check.

This is transformed into: 

syntax foo = 
  | CASE{v2 : t}(v2 : t)

relation wf_foo: `%%`(t, foo)
  rule foo_case_0{v : t, v2 : t}:
    `%%`(v, CASE_foo(v2))
    -- wf_t: `%`(v)
    -- if (v = v2)

This pass requires the typefamilyremoval pass to be ran first, as it ensures that type families are
transformed correctly.
*)

open Il.Ast
open Util.Source
open Util.Error
open Il
open Util

module StringSet = Set.Make(String)

type env = {
  mutable wf_set : StringSet.t;
  mutable il_env : Il.Env.t;
}

let empty_env = {
  wf_set = StringSet.empty;
  il_env = Il.Env.empty
}

let wf_pred_prefix = "wf_"
let rule_prefix = "case_"

(* flag that deactivates adding wellformedness predicates to relations *)
let deactivate_wfness = false

let error at msg = error at "Undep error" msg

let rec split3concat = function
    [] -> ([], [], [])
  | (x,y, z)::l ->
    let (rx, ry, rz) = split3concat l in 
    (x @ rx, y @ ry, z @ rz)

let remove_last_char s =
  if not (String.ends_with ~suffix:"*" s || String.ends_with ~suffix:"?" s) then s else  
  let len = String.length s in
  if len = 0 then s
  else String.sub s 0 (len - 1)

let bind_wf_set env id =
  if id <> "" && id <> "_" then
  env.wf_set <- StringSet.add id env.wf_set

let is_type_arg arg = 
  match arg.it with
  | TypA _ -> true
  | _ -> false

let is_type_param param =
  match param.it with
  | TypP _ -> true
  | _ -> false

let is_type_bind bind = 
  match bind.it with
  | TypB _ -> true
  | _ -> false

let filter_iter_binds exp iter_binds = 
  let free_vars = (Free.free_exp exp).varid in
  (List.fold_left (fun (free_set, acc) (iter, id_exp_pairs) -> 
    let new_id_exp_pairs = List.filter (fun (id, _) -> 
      Free.Set.mem id.it free_set
    ) id_exp_pairs in
    if new_id_exp_pairs = [] then (free_set, acc) else 
    let iter_vars = List.fold_left (fun acc (_, e) ->
      Free.Set.union acc (Free.free_exp e).varid  
    ) Free.Set.empty new_id_exp_pairs in 
    let new_set = Free.Set.union iter_vars free_set in
    (new_set, (iter, new_id_exp_pairs) :: acc)
  ) (free_vars, []) iter_binds) 
  |> snd |> List.rev

let rec collect_userdef_exp iterexps e = 
  match e.it with
  | CaseE _ | StrE _ -> [((e, e.note), filter_iter_binds e iterexps)]
  | CallE (_, args) -> List.concat_map (collect_userdef_arg iterexps) args
  | UnE (_, _, e1) | CvtE (e1, _, _) | LiftE e1 | TheE e1 | OptE (Some e1) 
  | ProjE (e1, _) | UncaseE (e1, _)
  | LenE e1 | DotE (e1, _)
  | SubE (e1, _, _) -> collect_userdef_exp iterexps e1
  | BinE (_, _, e1, e2) | CmpE (_, _, e1, e2)
  | CompE (e1, e2) | MemE (e1, e2)
  | CatE (e1, e2) | IdxE (e1, e2) -> collect_userdef_exp iterexps e1 @ collect_userdef_exp iterexps e2
  | TupE exps | ListE exps -> List.concat_map (collect_userdef_exp iterexps) exps
  | SliceE (e1, e2, e3) -> collect_userdef_exp iterexps e1 @ collect_userdef_exp iterexps e2 @ collect_userdef_exp iterexps e3
  | UpdE (e1, p, e2) 
  | ExtE (e1, p, e2) -> collect_userdef_exp iterexps e1 @ collect_userdef_path iterexps p @ collect_userdef_exp iterexps e2
  | IterE (e1, ((_, id_exp_pairs) as iterexp)) -> 
    collect_userdef_exp (iterexp :: iterexps) e1 @ 
    List.concat_map (fun (_, exp) -> collect_userdef_exp iterexps exp) id_exp_pairs
  | _ -> []

and collect_userdef_arg iterexps a =
  match a.it with
  | ExpA exp -> collect_userdef_exp iterexps exp
  | _ -> (* TODO - possibly need to go through all types of args *) 
    []

and collect_userdef_prem iterexps p =
  match p.it with
  | IfPr e | RulePr (_, _, e) -> collect_userdef_exp iterexps e
  | LetPr (e1, e2, _) -> collect_userdef_exp iterexps e1 @ collect_userdef_exp iterexps e2
  | IterPr (p', ((_, id_exp_pairs) as iterexp)) -> collect_userdef_prem (iterexp :: iterexps) p' @
    List.concat_map (fun (_, exp) -> collect_userdef_exp iterexps exp) id_exp_pairs
  | _ -> [] 

and collect_userdef_path iterexps p =
  match p.it with
  | RootP -> []
  | IdxP (p, e) -> collect_userdef_path iterexps p @ collect_userdef_exp iterexps e
  | SliceP (p, e1, e2) -> collect_userdef_path iterexps p @ collect_userdef_exp iterexps e1 @ collect_userdef_exp iterexps e2
  | DotP (p, _) -> collect_userdef_path iterexps p

let rec transform_iter env i =
  match i with 
  | ListN (exp, id_opt) -> ListN (transform_exp env exp, id_opt)
  | _ -> i

and transform_typ env t = 
  (match t.it with
  | VarT (id, args) -> VarT (id, List.filter is_type_arg (List.map (transform_arg env) args))
  | TupT exp_typ_pairs -> TupT (List.map (fun (e, t) -> (transform_exp env e, transform_typ env t)) exp_typ_pairs)
  | IterT (typ, iter) -> IterT (transform_typ env typ, transform_iter env iter)
  | typ -> typ
  ) $ t.at

and transform_exp env e = 
  let t_func = transform_exp env in
  (match e.it with
  | CaseE (m, e1) -> CaseE (m, t_func e1)
  | StrE fields -> StrE (List.map (fun (a, e1) -> (a, t_func e1)) fields)
  | UnE (unop, optyp, e1) -> UnE (unop, optyp, t_func e1)
  | BinE (binop, optyp, e1, e2) -> BinE (binop, optyp, t_func e1, t_func e2)
  | CmpE (cmpop, optyp, e1, e2) -> CmpE (cmpop, optyp, t_func e1, t_func e2)
  | TupE (exps) -> TupE (List.map t_func exps)
  | ProjE (e1, n) -> ProjE (t_func e1, n)
  | UncaseE (e1, m) -> UncaseE (t_func e1, m)
  | OptE e1 -> OptE (Option.map t_func e1)
  | TheE e1 -> TheE (t_func e1)
  | DotE (e1, a) -> DotE (t_func e1, a)
  | CompE (e1, e2) -> CompE (t_func e1, t_func e2)
  | ListE entries -> ListE (List.map t_func entries)
  | LiftE e1 -> LiftE (t_func e1)
  | MemE (e1, e2) -> MemE (t_func e1, t_func e2)
  | LenE e1 -> LenE (t_func e1)
  | CatE (e1, e2) -> CatE (t_func e1, t_func e2)
  | IdxE (e1, e2) -> IdxE (t_func e1, t_func e2)
  | SliceE (e1, e2, e3) -> SliceE (t_func e1, t_func e2, t_func e3)
  | UpdE (e1, p, e2) -> UpdE (t_func e1, transform_path env p, t_func e2)
  | ExtE (e1, p, e2) -> ExtE (t_func e1, transform_path env p, t_func e2)
  | CallE (id, args) -> CallE (id, List.map (transform_arg env) args)
    (* HACK - Change IterE of option with no iteration variable into a OptE *)
  | IterE (e1, (Opt, [])) -> 
    OptE (Some (t_func e1)) 
  | IterE (e1, (iter, id_exp_pairs)) -> IterE (t_func e1, (transform_iter env iter, List.map (fun (id, exp) -> (id, t_func exp)) id_exp_pairs))
  | CvtE (e1, nt1, nt2) -> CvtE (t_func e1, nt1, nt2)
  | SubE (e1, t1, t2) -> SubE (t_func e1, transform_typ env t1, transform_typ env t2)
  | exp -> exp
  ) $$ e.at % transform_typ env e.note

and transform_path env path = 
  (match path.it with
  | RootP -> RootP
  | IdxP (p, e) -> IdxP (transform_path env p, transform_exp env e)
  | SliceP (p, e1, e2) -> SliceP (transform_path env p, transform_exp env e1, transform_exp env e2)
  | DotP (p, a) -> DotP (transform_path env p, a)
  ) $$ path.at % transform_typ env path.note

and transform_sym env s = 
  (match s.it with
  | VarG (id, args) -> VarG (id, List.map (transform_arg env) args)
  | SeqG syms -> SeqG (List.map (transform_sym env) syms)
  | AltG syms -> AltG (List.map (transform_sym env) syms)
  | RangeG (syml, symu) -> RangeG (transform_sym env syml, transform_sym env symu)
  | IterG (sym, (iter, id_exp_pairs)) -> IterG (transform_sym env sym, (transform_iter env iter, 
      List.map (fun (id, exp) -> (id, transform_exp env exp)) id_exp_pairs)
    )
  | AttrG (e, sym) -> AttrG (transform_exp env e, transform_sym env sym)
  | sym -> sym 
  ) $ s.at 

and transform_arg env a =
  (match a.it with
  | ExpA exp -> ExpA (transform_exp env exp)
  | TypA typ -> TypA (transform_typ env typ)
  | DefA id -> DefA id
  | GramA sym -> GramA (transform_sym env sym)
  ) $ a.at

and transform_bind env b =
  (match b.it with
  | ExpB (id, typ) -> ExpB (id, transform_typ env typ)
  | TypB id -> TypB id
  | DefB (id, params, typ) -> DefB (id, List.map (transform_param env) params, transform_typ env typ)
  | GramB (id, params, typ) -> GramB (id, List.map (transform_param env) params, transform_typ env typ)
  ) $ b.at 
  
and transform_param env p =
  (match p.it with
  | ExpP (id, typ) -> ExpP (id, transform_typ env typ)
  | TypP id -> TypP id
  | DefP (id, params, typ) -> DefP (id, List.map (transform_param env) params, transform_typ env typ)
  | GramP (id, typ) -> GramP (id, transform_typ env typ)
  ) $ p.at 

let rec transform_prem env prem = 
  (match prem.it with
  | RulePr (id, m, e) -> RulePr (id, m, transform_exp env e)
  | IfPr e -> IfPr (transform_exp env e)
  | LetPr (e1, e2, ids) -> LetPr (transform_exp env e1, transform_exp env e2, ids)
  | ElsePr -> ElsePr
  | IterPr (prem1, (iter, id_exp_pairs)) -> IterPr (transform_prem env prem1, 
      (transform_iter env iter, List.map (fun (id, exp) -> (id, transform_exp env exp)) id_exp_pairs)
    )
  | NegPr p -> NegPr p
  ) $ prem.at

let transform_inst env inst = 
  (match inst.it with
  | InstD (binds, args, deftyp) -> InstD (List.map (transform_bind env) binds |> List.filter is_type_bind, List.map (transform_arg env) args |> List.filter is_type_arg, 
    (match deftyp.it with 
    | AliasT typ -> AliasT (transform_typ env typ)
    | StructT typfields -> StructT (List.map (fun (a, (c_binds, typ, _prems), hints) ->
        (a, (List.map (transform_bind env) c_binds, transform_typ env typ, []), hints)  
      ) typfields)
    | VariantT typcases -> 
      VariantT (List.map (fun (m, (c_binds, typ, _prems), hints) -> 
        (m, (List.map (transform_bind env) c_binds, transform_typ env typ, []), hints)  
      ) typcases)
    ) $ deftyp.at
  )) $ inst.at

let needs_wfness env def = 
  match def.it with
  | TypD (_, _, [{it = InstD (binds, _, deftyp); _}]) ->
    let prems_list = match deftyp.it with
    | StructT typfields -> List.map (fun (_, (_, _, prems), _) -> prems) typfields
    | VariantT typcases -> List.map (fun (_, (_, _, prems), _) -> prems) typcases
    | _ -> []
    in
    List.exists (fun b -> match b.it with
      | ExpB (id, _) -> StringSet.mem id.it env.wf_set
      | _ -> false 
    ) binds ||
    List.exists (fun prems -> prems <> []) prems_list
  | _ -> false

let rec get_wf_pred env (exp, t) = 
  let get_id exp =
    match exp.it with
    | VarE id -> id
    | _ -> 
      (* This should never happen as long as the code doesn't change *)
      error exp.at ("Abnormal bind - does not have correct exp: " ^ Il.Print.string_of_exp exp)
  in
  let t' = Utils.reduce_type_aliasing env.il_env t in
  let exp' = {exp with note = t'} in 
  match t'.it with
    | VarT (id, args) when StringSet.mem id.it env.wf_set ->
      let new_mixop = [] :: List.init (List.length args + 1) (fun _ -> []) in
      let exp_args = List.filter_map (fun a -> match a.it with 
        | ExpA exp -> Some exp
        | _ -> None
      ) args in
      let tupt = TupT (List.map (fun e -> (VarE ("" $ id.at) $$ id.at % e.note), e.note) exp_args) $ id.at in
      let tuple_exp = TupE (exp_args @ [exp']) $$ id.at % tupt in
      [RulePr (wf_pred_prefix ^ id.it $ id.at, new_mixop, tuple_exp) $ id.at]
    | IterT (typ, iter) ->
      let name = get_id exp' in
      let name' = remove_last_char name.it $ name.at in 
      let prems = get_wf_pred env (VarE name' $$ name.at % typ, typ) in
      List.map (fun prem -> IterPr (prem, (iter, [(name', exp')])) $ name.at) prems
    | TupT exp_typ_pairs -> 
      let prems = 
        List.mapi (fun idx (_, typ) -> 
          get_wf_pred env (ProjE (exp', idx) $$ exp.at % typ, typ)) exp_typ_pairs |> 
        List.concat 
      in
      prems
    | _ -> []

let rec non_empty_var e = 
  match e.it with
  | VarE id -> id.it <> "" && id.it <> "_"
  | IterE (e, _) -> non_empty_var e 
  | TupE exps -> List.exists non_empty_var exps
  | _ -> false

let get_exp_typ b = 
  match b.it with
  | ExpB (id, typ) -> Some (VarE id $$ id.at % typ, typ)
  | _ -> None
  
let create_well_formed_predicate id env inst = 
  let at = id.at in 
  let user_typ = VarT(id, []) $ at in
  let new_mixop pairs = [] :: List.init (List.length pairs + 1) (fun _ -> []) in
  let create_pairs binds = List.split (List.filter_map (fun b -> match b.it with 
      | ExpB (id', typ) -> Some ((VarE ("_" $ id'.at) $$ id'.at % typ, typ), (VarE id' $$ id'.at % typ, typ))
      | _ -> None
    ) binds) in
  let tupt pairs = TupT (pairs @ [(VarE ("_" $ at) $$ at % user_typ, user_typ)]) $ at in
  match inst.it with
  (* Variant well formedness predicate creation *)
  | InstD (binds, _args, {it = VariantT typcases; _}) -> 
    let pairs_without_names, dep_exp_typ_pairs = create_pairs binds in
    let rules = List.mapi (fun i (m, (case_binds, case_typ, prems), _) ->
      let exp_typ_pairs = match case_typ.it with
        | TupT tups -> tups
        | _ -> [(VarE ("_" $ id.at) $$ id.at % case_typ, case_typ)] 
      in 
      let extra_binds, t_pairs = Utils.improve_ids_binders [] false id.at exp_typ_pairs in
      let new_binds = case_binds @ extra_binds in 
      let exp = TupE (List.map fst t_pairs) $$ at % (TupT t_pairs $ at) in 
      let case_exp = CaseE (m, exp) $$ at % user_typ in
      let tuple_exp = TupE (List.map fst dep_exp_typ_pairs @ [case_exp]) $$ at % tupt pairs_without_names in
      let extra_prems = List.filter_map get_exp_typ new_binds |> List.concat_map (get_wf_pred env) in
      RuleD (id.it ^ "_" ^ rule_prefix ^ Int.to_string i $ at, 
        List.map (transform_bind env) (binds @ new_binds), new_mixop dep_exp_typ_pairs, 
        transform_exp env tuple_exp, 
        List.map (transform_prem env) (extra_prems @ prems)
      ) $ at
    ) typcases
    in
    let has_no_prems = List.for_all (fun rule -> match rule.it with
      | RuleD (_, _, _, _, prems) -> prems = []   
    ) rules in
    if has_no_prems then None else 
    let relation = RelD (wf_pred_prefix ^ id.it $ id.at, new_mixop dep_exp_typ_pairs, tupt pairs_without_names, rules) $ at in 
    bind_wf_set env id.it;
    Some relation

  (* Struct/Record well formedness predicate creation *)
  | InstD (binds, _args, {it = StructT typfields; _}) -> 
    let pairs_without_names, dep_exp_typ_pairs = create_pairs binds in
    let atoms = List.map (fun (a, _, _) -> a) typfields in
    let is_wrapped, pairs, rule_prems = split3concat (List.map (fun (_, (_, t, prems), _) ->
      let tups, wrapped = match t.it with 
        | TupT tups when List.exists (fun (e, _) -> non_empty_var e) tups -> tups, true
        | TupT [] -> [], false
        | _ -> [(VarE ("_" $ id.at) $$ id.at % t, t)], false
      in 
      ([wrapped], tups, prems)
    ) typfields) in

    let (rule_binds, pairs') = Utils.improve_ids_binders [] true at pairs in
    let new_prems = (List.filter_map get_exp_typ rule_binds |> List.concat_map (get_wf_pred env)) @ rule_prems in
    let str_exp = StrE (List.map2 (fun a ((e, t), wrapped) -> 
      let tupt = TupT [(e, t)] $ at in
      let tupe = TupE [e] $$ at % tupt in 
      if wrapped then (a, tupe) else 
      (a, e)
    ) atoms (List.combine pairs' is_wrapped)) $$ at % user_typ in 
    let tupe = TupE (List.map fst dep_exp_typ_pairs @ [str_exp]) $$ at % tupt pairs_without_names in
    let rule = RuleD (id.it ^ "_" ^ rule_prefix $ id.at, 
      List.map (transform_bind env) (binds @ rule_binds), 
      new_mixop dep_exp_typ_pairs, 
      tupe, 
      List.map (transform_prem env) (new_prems)) $ at 
    in
  
    if new_prems = [] then None else 
    let relation = RelD (wf_pred_prefix ^ id.it $ id.at, new_mixop dep_exp_typ_pairs, tupt pairs_without_names, [rule]) $ at in 
    bind_wf_set env id.it;
    Some relation
  | _ -> None

let get_extra_prems env binds exp prems = 
  if deactivate_wfness then [] else 
  let wf_terms = collect_userdef_exp [] exp @ List.concat_map (collect_userdef_prem []) prems in
  let unique_terms = Util.Lib.List.nub (fun ((e1, _t1), iterexp1) ((e2, _t2), iterexp2) -> 
    Il.Eq.eq_exp e1 e2 && Il.Eq.eq_list Il.Eq.eq_iterexp iterexp1 iterexp2
  ) wf_terms in
  
  let more_prems = List.concat_map (fun (pair, iterexps) -> 
    List.map (fun prem' -> List.fold_left (fun acc iterexp ->
      IterPr (acc, iterexp) $ acc.at   
    ) prem' iterexps) (get_wf_pred env pair) 
  ) unique_terms in

  (* Leverage the fact that the wellformed predicates are "bubbled up" and remove unnecessary wf preds*)
  let free_vars = (Free.free_list Free.free_prem more_prems).varid in
  let binds_filtered = Lib.List.filter_not (fun b -> match b.it with 
    | ExpB (id, _) -> Free.Set.mem id.it free_vars
    | _ -> true
  ) binds in
  let bind_prems = (List.filter_map get_exp_typ binds_filtered) |> List.concat_map (get_wf_pred env) in
  bind_prems @ more_prems
    
let transform_rule env rule = 
  (match rule.it with
  | RuleD (id, binds, m, exp, prems) -> 
    let extra_prems = get_extra_prems env binds exp prems in 
    RuleD (id, 
      List.map (transform_bind env) binds, 
      m, 
      transform_exp env exp, 
      List.map (transform_prem env) (extra_prems @ prems) 
    )
  ) $ rule.at

let transform_clause env clause =
  (match clause.it with 
  | DefD (binds, args, exp, prems) -> 
    let extra_prems = get_extra_prems env binds exp prems in 
    DefD (List.map (transform_bind env) binds, 
      List.map (transform_arg env) args,
      transform_exp env exp, 
      List.map (transform_prem env) (extra_prems @ prems)
    )
  ) $ clause.at

let transform_prod env prod = 
  (match prod.it with 
  | ProdD (binds, sym, exp, prems) -> ProdD (List.map (transform_bind env) binds,
    transform_sym env sym,
    transform_exp env exp,
    List.map (transform_prem env) prems
  )) $ prod.at

let is_not_exp_param param =
  match param.it with
  | ExpP _ -> false
  | _ -> true

let get_def_id def = 
  match def.it with 
  | TypD (id, _, _) -> id
  | _ -> "" $ def.at

let rec transform_def env def = 
  match def.it with
  | TypD (id, params, [inst]) when List.exists is_not_exp_param params -> 
    (TypD (id, List.map (transform_param env) params |> List.filter is_type_param, [inst]) $ def.at, [])
  | TypD (id, params, [inst]) -> 
    let relation = create_well_formed_predicate id env inst in
    (TypD (id, List.map (transform_param env) params |> List.filter is_type_param, [transform_inst env inst]) $ def.at, Option.to_list relation)
  | TypD (_, _, _) -> 
    error def.at "Multiples instances encountered, please run type family removal pass first."
  | RelD (id, m, typ, rules) -> 
    (RelD (id, m, transform_typ env typ, List.map (transform_rule env) rules) $ def.at, [])
  | DecD (id, params, typ, clauses) -> (DecD (id, List.map (transform_param env) params, transform_typ env typ, List.map (transform_clause env) clauses) $ def.at, [])
  | GramD (id, params, typ, prods) -> (GramD (id, List.map (transform_param env) params, transform_typ env typ, List.map (transform_prod env) prods) $ def.at, [])
  | RecD defs -> 
    if List.exists (needs_wfness env) defs 
      then List.iter (fun d -> bind_wf_set env (get_def_id d).it) defs; 
    let defs', wf_relations = List.map (transform_def env) defs |> List.split in
    let rec_defs = RecD defs' $ def.at in
    if List.concat wf_relations = [] then (rec_defs, []) else
    (rec_defs, [RecD (List.concat wf_relations) $ def.at])
  | HintD hintdef -> (HintD hintdef $ def.at, [])
  
let transform (il : script): script =
  let env = empty_env in 
  env.il_env <- Il.Env.env_of_script il;
  List.concat_map (fun d -> 
    let (t_d, wf_relations) = transform_def env d in 
    t_d :: wf_relations
  ) il