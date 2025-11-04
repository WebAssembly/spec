open Il.Ast
open Il
open Util.Source

module StringMap = Map.Make(String)
type uncase_map = (mixop list) StringMap.t

type env = {
  mutable uncase_map : uncase_map;
  mutable env : Il.Env.t;
}

let empty_env = {
  uncase_map = StringMap.empty;
  env = Il.Env.empty
}

let error at msg = Util.Error.error at "uncase-removal" msg

let var_prefix = "v_"
let proj_prefix = "proj_"

let get_case_typs t = 
  match t.it with
  | TupT typs -> typs
  | _ -> [(VarE ("_" $ t.at) $$ t.at % t, t)]

let iter_name i = 
  match i with
  | Opt -> "opt"
  | List | List1 | ListN _ -> "list"

let rec typ_name t =
  match t.it with
  | VarT (id, _) -> id.it
  | BoolT -> "bool"
  | NumT _ -> "num"
  | TextT -> "str"
  | TupT pairs -> String.concat "__" (List.map (fun (_, t) -> typ_name t) pairs) ^ "_pair"
  | IterT (typ, iter) -> typ_name typ ^ "_" ^ iter_name iter 

let make_arg p = 
  (match p.it with
  | ExpP (id, typ) -> ExpA (VarE id $$ id.at % typ) 
  | TypP id -> TypA (VarT (id, []) $ id.at) (* TODO unsure this makes sense*)
  | DefP (id, _, _) -> DefA id 
  | GramP (_, _) -> assert false (* Avoid this *)
  ) $ p.at

let make_bind p = 
  (match p.it with 
  | ExpP (id, typ) -> ExpB (id, typ)
  | TypP id -> TypB id
  | DefP (id, params, typ) -> DefB (id, params, typ)
  | GramP _ -> assert false (* Avoid this *)
  ) $ p.at

let create_projection_functions id params mixops inst =
  let get_deftyp inst' = (match inst'.it with
    | InstD (_binds, _args, deftyp) -> deftyp.it
  ) in 
  let at = inst.at in 
  let user_typ = VarT (id, List.map make_arg params) $ at in 
  let param_ids = List.map (fun p -> (Utils.get_param_id p).it) params in 
  let fresh_name = Utils.generate_var param_ids "x" in
  let new_param = ExpP (fresh_name $ at, user_typ) $ at in
  let make_func m case_typs has_one_case idx = 
    let new_params = params @ [new_param] in 
    let new_var_exps = List.mapi (fun idx (_, t) -> VarE (var_prefix ^ typ_name t ^ "_" ^ Int.to_string idx $ at) $$ at % t) case_typs in 
    let tupt = TupT case_typs $ at in
    let no_name_tupt = TupT (List.map (fun (e, t) -> ({e with it = VarE ("_" $ e.at)}, t)) case_typs) $ at in
    let new_tup = TupE (new_var_exps) $$ at % tupt in
    let new_case_exp = CaseE(m, new_tup) $$ at % user_typ in
    let new_arg = ExpA new_case_exp $ at in 
    let new_binds = List.mapi (fun idx (_, t) -> ExpB (var_prefix ^ typ_name t ^ "_" ^ Int.to_string idx $ at, t) $ at) case_typs in
    let clause = DefD (List.map make_bind params @ new_binds, List.map make_arg params @ [new_arg], new_tup, []) $ at in 
    let normal = DecD ((proj_prefix ^ id.it ^ "_" ^ Int.to_string idx) $ id.at, new_params, no_name_tupt, [clause]) in

    if has_one_case then normal else
    (* extra handling in case that it has more than one case *)
    let extra_arg = ExpA (VarE (fresh_name $ at) $$ at % user_typ) $ at in
    let new_bind = ExpB (fresh_name $ at, user_typ) $ at in 
    let opt_type = IterT (no_name_tupt, Opt) $ at in
    let none_exp = OptE (None) $$ at % no_name_tupt in
    let opt_tup = OptE (Some new_tup) $$ at % opt_type in 
    let clause' = DefD (List.map make_bind params @ new_binds, List.map make_arg params @ [new_arg], opt_tup, []) $ at in
    let extra_clause = DefD (List.map make_bind params @ new_binds @ [new_bind], List.map make_arg params @ [extra_arg], none_exp, []) $ at in
    DecD ((proj_prefix ^ id.it ^ "_" ^ Int.to_string idx) $ id.at, new_params, opt_type, [clause'; extra_clause])
  in

  List.map (fun m -> 
    (match (get_deftyp inst) with
    (* Should not happen due to reduction while collecting uncase expressions *)
    | AliasT _typ -> error inst.at "Found type alias while constructing projection functions, should not happen"
    (* Should not be allowed since struct does not have cases *)
    | StructT _ -> error inst.at "Found struct construction while constructing projection functions, should not happen" 
    | VariantT typcases -> 
      let mixop_opt = List.find_mapi (fun i (m', (_, t, _), _) -> 
        if not (Eq.eq_mixop m m') then None else 
        Some (i, m, t)
      ) typcases in
      begin match mixop_opt with
      | Some (i, m, t) -> make_func m (get_case_typs t) (List.length typcases = 1) i
      | None -> 
        error inst.at ("Could not find mixop " ^ Il.Print.string_of_mixop m ^ 
        " while constructing projection functions") 
      end 
    )
  ) mixops

let get_proj_info p_env m id = 
  let opt = Env.find_opt_typ p_env.env (id $ no_region) in
  match opt with
  | Some (_, [{it = InstD(_, _, {it = VariantT typcases; _}); _}]) -> 
    List.find_mapi (fun i (m', (_, t, _), _) -> 
      if Eq.eq_mixop m m' then Some (i, t) else None
    ) typcases |>
    Option.map (fun (i, t) -> (i, t, List.length typcases = 1))
  | _ -> None

let transform_tuple_type t = 
  match t.it with
  | TupT ts -> TupT (List.map (fun (e, t) -> (VarE ("_" $ e.at) $$ e.at % t, t)) ts) $ t.at
  | _ -> t

let rec transform_iter p_env i =
  match i with 
  | ListN (exp, id_opt) -> ListN (transform_exp p_env exp, id_opt)
  | _ -> i

and transform_typ p_env t = 
  (match t.it with
  | VarT (id, args) -> VarT (id, List.map (transform_arg p_env) args)
  | TupT exp_typ_pairs -> TupT (List.map (fun (e, t) -> (transform_exp p_env e, transform_typ p_env t)) exp_typ_pairs)
  | IterT (typ, iter) -> IterT (transform_typ p_env typ, transform_iter p_env iter)
  | typ -> typ
  ) $ t.at

and transform_exp p_env e = 
  let t_func = transform_exp p_env in
  let exp_type = transform_typ p_env e.note in
  (match e.it with
  | UncaseE(exp, m) -> 
    (* Supplying the projection function for UncaseE removal *)
    let typ = Eval.reduce_typ p_env.env exp.note in 
    let typ_name = Print.string_of_typ_name typ in
    let proj_info_opt = get_proj_info p_env m typ_name in
    let args = (match typ.it with 
      | VarT (_, args) -> args
      | _ -> error e.at ("Found non-variable type in uncase expression: " ^ Il.Print.string_of_typ typ)
    ) in 
    let args' = List.map (transform_arg p_env) (args @ [ExpA exp $ e.at]) in
    let fun_id idx = proj_prefix ^ typ_name ^ "_" ^ Int.to_string idx $ e.at in
    begin match proj_info_opt with 
    | Some (idx, _, true) -> CallE (fun_id idx, args')
    | Some (idx, t, false) -> 
      let call_typ = IterT (transform_tuple_type t, Opt) $ e.at in
      TheE (CallE (fun_id idx, args') $$ e.at % call_typ)
    | None -> error e.at ("Could not find mixop: " ^ Il.Print.string_of_mixop m)
    end
  | CaseE (m, e1) -> CaseE (m, t_func e1)
  | StrE fields -> StrE (List.map (fun (a, e1) -> (a, t_func e1)) fields)
  | UnE (unop, optyp, e1) -> UnE (unop, optyp, t_func e1)
  | BinE (binop, optyp, e1, e2) -> BinE (binop, optyp, t_func e1, t_func e2)
  | CmpE (cmpop, optyp, e1, e2) -> CmpE (cmpop, optyp, t_func e1, t_func e2)
  | TupE (exps) -> TupE (List.map t_func exps)
  | ProjE (e1, n) -> ProjE (t_func e1, n)
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
  | UpdE (e1, p, e2) -> UpdE (t_func e1, transform_path p_env p, t_func e2)
  | ExtE (e1, p, e2) -> ExtE (t_func e1, transform_path p_env p, t_func e2)
  | CallE (id, args) -> CallE (id, List.map (transform_arg p_env) args)
  | IterE (e1, (iter, id_exp_pairs)) -> IterE (t_func e1, (transform_iter p_env iter, List.map (fun (id, exp) -> (id, t_func exp)) id_exp_pairs))
  | CvtE (e1, nt1, nt2) -> CvtE (t_func e1, nt1, nt2)
  | SubE (e1, t1, t2) -> SubE (t_func e1, transform_typ p_env t1, transform_typ p_env t2)
  | exp -> exp
  ) $$ e.at % exp_type

and transform_path p_env path = 
  (match path.it with
  | RootP -> RootP
  | IdxP (p, e) -> IdxP (transform_path p_env p, transform_exp p_env e)
  | SliceP (p, e1, e2) -> SliceP (transform_path p_env p, transform_exp p_env e1, transform_exp p_env e2)
  | DotP (p, a) -> DotP (transform_path p_env p, a)
  ) $$ path.at % (transform_typ p_env path.note)

and transform_sym p_env s = 
  (match s.it with
  | VarG (id, args) -> VarG (id, List.map (transform_arg p_env) args)
  | SeqG syms -> SeqG (List.map (transform_sym p_env) syms)
  | AltG syms -> AltG (List.map (transform_sym p_env) syms)
  | RangeG (syml, symu) -> RangeG (transform_sym p_env syml, transform_sym p_env symu)
  | IterG (sym, (iter, id_exp_pairs)) -> IterG (transform_sym p_env sym, (transform_iter p_env iter, 
      List.map (fun (id, exp) -> (id, transform_exp p_env exp)) id_exp_pairs)
    )
  | AttrG (e, sym) -> AttrG (transform_exp p_env e, transform_sym p_env sym)
  | sym -> sym 
  ) $ s.at 

and transform_arg p_env a =
  (match a.it with
  | ExpA exp -> ExpA (transform_exp p_env exp)
  | TypA typ -> TypA (transform_typ p_env typ)
  | DefA id -> DefA id
  | GramA sym -> GramA (transform_sym p_env sym)
  ) $ a.at

and transform_bind p_env b =
  (match b.it with
  | ExpB (id, typ) -> ExpB (id, transform_typ p_env typ)
  | TypB id -> TypB id
  | DefB (id, params, typ) -> DefB (id, List.map (transform_param p_env) params, transform_typ p_env typ)
  | GramB (id, params, typ) -> GramB (id, List.map (transform_param p_env) params, transform_typ p_env typ)
  ) $ b.at 
  
and transform_param p_env p =
  (match p.it with
  | ExpP (id, typ) -> ExpP (id, transform_typ p_env typ)
  | TypP id -> TypP id
  | DefP (id, params, typ) -> DefP (id, List.map (transform_param p_env) params, transform_typ p_env typ)
  | GramP (id, typ) -> GramP (id, transform_typ p_env typ)
  ) $ p.at 

let rec transform_prem p_env prem = 
  (match prem.it with
  | RulePr (id, m, e) -> RulePr (id, m, transform_exp p_env e)
  | IfPr e -> IfPr (transform_exp p_env e)
  | LetPr (e1, e2, ids) -> LetPr (transform_exp p_env e1, transform_exp p_env e2, ids)
  | ElsePr -> ElsePr
  | IterPr (prem1, (iter, id_exp_pairs)) -> IterPr (transform_prem p_env prem1, 
      (transform_iter p_env iter, List.map (fun (id, exp) -> (id, transform_exp p_env exp)) id_exp_pairs)
    )
  | NegPr p -> NegPr p
  ) $ prem.at

let transform_inst p_env inst = 
  (match inst.it with
  | InstD (binds, args, deftyp) -> InstD (List.map (transform_bind p_env) binds, List.map (transform_arg p_env) args, 
    (match deftyp.it with 
    | AliasT typ -> AliasT (transform_typ p_env typ)
    | StructT typfields -> StructT (List.map (fun (a, (c_binds, typ, prems), hints) ->
        (a, (List.map (transform_bind p_env) c_binds, transform_typ p_env typ, List.map (transform_prem p_env) prems), hints)  
      ) typfields)
    | VariantT typcases -> 
      VariantT (List.map (fun (m, (c_binds, typ, prems), hints) -> 
        (m, (List.map (transform_bind p_env) c_binds, transform_typ p_env typ, List.map (transform_prem p_env) prems), hints)  
      ) typcases)
    ) $ deftyp.at
  )
  ) $ inst.at

let transform_rule p_env rule = 
  (match rule.it with
  | RuleD (id, binds, m, exp, prems) -> RuleD (id.it $ no_region, 
    List.map (transform_bind p_env) binds, 
    m, 
    transform_exp p_env exp, 
    List.map (transform_prem p_env) prems
  )
  ) $ rule.at

let transform_clause p_env clause =
  (match clause.it with 
  | DefD (binds, args, exp, prems) -> DefD (List.map (transform_bind p_env) binds, 
    List.map (transform_arg p_env) args,
    transform_exp p_env exp, 
    List.map (transform_prem p_env) prems
  )
  ) $ clause.at

let transform_prod p_env prod = 
  (match prod.it with 
  | ProdD (binds, sym, exp, prems) -> ProdD (List.map (transform_bind p_env) binds,
    transform_sym p_env sym,
    transform_exp p_env exp,
    List.map (transform_prem p_env) prems
  )
  ) $ prod.at

let rec transform_def p_env def = 
  (match def.it with
  | TypD (id, params, [inst]) -> 
    let d = TypD (id, List.map (transform_param p_env) params, [transform_inst p_env inst]) in 
    (match (StringMap.find_opt id.it p_env.uncase_map) with 
      | None -> [d]
      | Some ms -> d :: create_projection_functions id params ms inst
    )
  | TypD (id, params, insts) -> 
    [TypD (id, List.map (transform_param p_env) params, List.map (transform_inst p_env) insts)]
  | RelD (id, m, typ, rules) -> 
    [RelD (id, m, transform_typ p_env typ, List.map (transform_rule p_env) rules)]
  | DecD (id, params, typ, clauses) -> [DecD (id, List.map (transform_param p_env) params, transform_typ p_env typ, List.map (transform_clause p_env) clauses)]
  | GramD (id, params, typ, prods) -> [GramD (id, List.map (transform_param p_env) params, transform_typ p_env typ, List.map (transform_prod p_env) prods)]
  | RecD defs -> [RecD (List.concat_map (transform_def p_env) defs)]
  | HintD hintdef -> [HintD hintdef]
  ) |> List.map (fun d -> d $ def.at)

let collect_uncase_iter env: uncase_map ref * (module Iter.Arg) =
  let module Arg = 
    struct
      include Iter.Skip 
      let acc = ref StringMap.empty
      let visit_exp (exp : exp) = 
        match exp.it with
        | UncaseE(e, m) -> 
          let typ_name = Print.string_of_typ_name (Il.Eval.reduce_typ env e.note) in
          acc := StringMap.update typ_name (fun int_set_opt -> match int_set_opt with 
            | None -> Some [m]
            | Some ms -> 
              Some (if List.mem m ms then ms else m :: ms) 
          ) !acc
        | _ -> ()
    end
  in Arg.acc, (module Arg)

let transform (il : script): script =
  let p_env = empty_env in 
  p_env.env <- Il.Env.env_of_script il;

  (* Building up uncase_map *)
  let acc, (module Arg : Iter.Arg) = collect_uncase_iter p_env.env in
  let module Acc = Iter.Make(Arg) in
  List.iter Acc.def il;
  p_env.uncase_map <- !acc;

  (* Main transformation *)
  List.concat_map (transform_def p_env) il 