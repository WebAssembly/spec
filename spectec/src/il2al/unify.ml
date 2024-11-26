(**
Functions that transform IL into IL.
**)

open Il.Ast
open Il.Eq
open Il.Free
open Util
open Source
open Def
open Il2al_util


let rename = ref false

(* Error *)

let error at msg = Error.error at "prose translation" msg


(* Environment for unified ids *)

module Map = Map.Make(String)

type idxs = (string * int) Map.t
type env = {
  mutable idxs : idxs;
  frees : Set.t;
}

let unified_prefix = "u"
let imap : idxs ref = ref Map.empty

let init_var m id t =
  let typid = Al.Al_util.typ_to_var_name t in
  let nid = id.it |> Str.global_replace (Str.regexp "[^a-zA-Z]") "" in
  let len = String.length nid in
  match Map.find_opt typid m with
  (* Use the shortest non-empty name. Prioritize typid than others. *)
  | Some (s, _) when String.length s < len -> m
  | Some (s, _) when s = typid && String.length s = len -> m
  | _ when len = 0 -> m
  | _ -> Map.add typid (nid, 1) m

let init_map_bind m bind =
  match bind.it with
  | ExpB (id, t) -> init_var m id t
  | _ -> m

let init_map_rule m rule =
  match rule.it with
  | RuleD (_, binds, _, _, _) -> List.fold_left init_map_bind m binds

let init_map_clause m clause =
  match clause.it with
  | DefD (binds, _, _, _) -> List.fold_left init_map_bind m binds

let init_map il =
  let env' =
    List.fold_left (fun m def ->
      match def.it with
      | RelD (_, _, _, rules) ->
        List.fold_left init_map_rule m rules
      | DecD (_, _, _, clauses) ->
        List.fold_left init_map_clause m clauses
      | _ -> m
    ) Map.empty il
  in
  imap := env'

let init_env frees = { idxs = !imap; frees }


(* Estimate appropriate id name for a given type *)
let rec avoid_collision env name idx =
  let name' = name ^ "_" ^ unified_prefix ^ (string_of_int idx) in
  if Set.mem name' env.frees then
    avoid_collision env name (idx + 1)
  else
    name, idx

let get_unified_idx env typid =
  let idxs = env.idxs in
  let n, i =
    match Map.find_opt typid idxs with
    | Some (n, i) when String.length n >= String.length typid -> typid, i
    | Some (n, i) -> n, i
    | None -> typid, 1
  in
  let name, idx = avoid_collision env n i in

  env.idxs <- Map.add typid (name, idx + 1) idxs;
  name, idx

let gen_new_unified env ty =
  let typid = Al.Al_util.typ_to_var_name ty in
  let name, idx = get_unified_idx env typid in
  name ^ "_" ^ unified_prefix ^ (string_of_int idx) $ no_region

let is_unified_id id = String.split_on_char '_' id |> Util.Lib.List.last |> String.starts_with ~prefix:unified_prefix

let extract_unified_idx id =
  let ss, s = String.split_on_char '_' id |> Util.Lib.List.split_last in
  if String.starts_with ~prefix:unified_prefix s then
    (try
      let ss = String.concat "_" ss in
      let s = String.sub s 1 (String.length s - 1) |> int_of_string in
      Some (ss, s)
    with Failure _ -> None)
  else
    None

(* Rename unified ids to non-unified ones *)

let rename_string env s =
  match extract_unified_idx s with
  | Some (base_name, idx) ->
    (match Map.find_opt base_name env.idxs with
    | Some (_, idx') when idx' <= 2 ->
      if Set.mem base_name env.frees
      then base_name ^ "_" ^ (string_of_int idx) else base_name
    | _ -> base_name ^ "_" ^ (string_of_int idx))
  | None -> s

let rename_id env id = { id with it = rename_string env id.it }

let rename_iterexp env (iter, ides) = (iter, List.map (fun (id, e) -> (rename_id env id, e)) ides)

let rename_exp env exp =
  {exp with it = match exp.it with
  | VarE id -> VarE (rename_id env id)
  | exp' -> exp'
  }

let rename_prem env p =
  {p with it = match p.it with
  | LetPr (e1, e2, ss) -> LetPr (e1, e2, List.map (rename_string env) ss)
  | p' -> p' }

let rename_rule_def (env, rd) =
  if not !rename then rd else
  let transformer = { Il_walk.base_transformer with
    transform_exp = rename_exp env;
    transform_prem = rename_prem env;
    transform_iterexp = rename_iterexp env;
  } in
  Il_walk.transform_rule_def transformer rd

let rename_helper_def (env, hd) =
  if not !rename then hd else
  let transformer = { Il_walk.base_transformer with
    transform_exp = rename_exp env;
    transform_prem = rename_prem env;
    transform_iterexp = rename_iterexp env;
    } in
  Il_walk.transform_helper_def transformer hd

let rec overlap env e1 e2 = if eq_exp e1 e2 then e1 else
  let replace_it it = { e1 with it = it } in
  match e1.it, e2.it with
    (* Already unified *)
    | VarE id, _ when is_unified_id id.it ->
      e1
    | IterE ({ it = VarE id; _} as e, i), _ when is_unified_id id.it ->
      let t = overlap_typ env e1.note e2.note in
      { e1 with it = IterE (e, i); note = t }
    (* Not unified *)
    | UnE (unop1, nt1, e1), UnE (unop2, nt2, e2) when unop1 = unop2 && nt1 = nt2 ->
      UnE (unop1, nt1, overlap env e1 e2) |> replace_it
    | BinE (binop1, nt1, e1, e1'), BinE (binop2, nt2, e2, e2') when binop1 = binop2 && nt1 = nt2 ->
      BinE (binop1, nt1, overlap env e1 e2, overlap env e1' e2') |> replace_it
    | CmpE (cmpop1, nt1, e1, e1'), CmpE (cmpop2, nt2, e2, e2') when cmpop1 = cmpop2 && nt1 = nt2 ->
      CmpE (cmpop1, nt1, overlap env e1 e2, overlap env e1' e2') |> replace_it
    | IdxE (e1, e1'), IdxE (e2, e2') ->
      IdxE (overlap env e1 e2, overlap env e1' e2') |> replace_it
    | SliceE (e1, e1', e1''), SliceE (e2, e2', e2'') ->
      SliceE (overlap env e1 e2, overlap env e1' e2', overlap env e1'' e2'') |> replace_it
    | UpdE (e1, path1, e1'), UpdE (e2, path2, e2') when eq_path path1 path2 ->
      UpdE (overlap env e1 e2, path1, overlap env e1' e2') |> replace_it
    | ExtE (e1, path1, e1'), ExtE (e2, path2, e2') when eq_path path1 path2 ->
      ExtE (overlap env e1 e2, path1, overlap env e1' e2') |> replace_it
    | StrE efs1, StrE efs2 when List.map fst efs1 = List.map fst efs2 ->
      StrE (List.map2 (fun (a1, e1) (_, e2) -> (a1, overlap env e1 e2)) efs1 efs2) |> replace_it
    | DotE (e1, atom1), DotE (e2, atom2) when eq_atom atom1 atom2 ->
      DotE (overlap env e1 e2, atom1) |> replace_it
    | CompE (e1, e1'), CompE (e2, e2') ->
      CompE (overlap env e1 e2, overlap env e1' e2') |> replace_it
    | LenE e1, LenE e2 ->
      LenE (overlap env e1 e2) |> replace_it
    | TupE es1, TupE es2 when List.length es1 = List.length es2 ->
      TupE (List.map2 (overlap env) es1 es2) |> replace_it
    | CallE (id1, as1), CallE (id2, as2) when eq_id id1 id2 ->
      CallE (id1, List.map2 (overlap_arg env) as1 as2) |> replace_it
    | IterE (e1, itere1), IterE (e2, itere2) when eq_iterexp itere1 itere2 ->
      IterE (overlap env e1 e2, itere1) |> replace_it
    | ProjE (e1, i1), ProjE (e2, i2) when i1 = i2 ->
      ProjE (overlap env e1 e2, i1) |> replace_it
    | UncaseE (e1, op1), UncaseE (e2, op2) when eq_mixop op1 op2 ->
      UncaseE (overlap env e1 e2, op1) |> replace_it
    | OptE (Some e1), OptE (Some e2) ->
      OptE (Some (overlap env e1 e2)) |> replace_it
    | TheE e1, TheE e2 ->
      TheE (overlap env e1 e2) |> replace_it
    | ListE es1, ListE es2 when List.length es1 = List.length es2 ->
      ListE (List.map2 (overlap env) es1 es2) |> replace_it
    | CatE (e1, e1'), CatE (e2, e2') ->
      CatE (overlap env e1 e2, overlap env e1' e2') |> replace_it
    | MemE (e1, e1'), MemE (e2, e2') ->
      MemE (overlap env e1 e2, overlap env e1' e2') |> replace_it
    | CaseE (mixop1, e1), CaseE (mixop2, e2) when eq_mixop mixop1 mixop2 ->
      CaseE (mixop1, overlap env e1 e2) |> replace_it
    | SubE (e1, typ1, typ1'), SubE (e2, typ2, typ2') when eq_typ typ1 typ2 && eq_typ typ1' typ2' ->
      SubE (overlap env e1 e2, typ1, typ1') |> replace_it
    (* HARDCODE: Unifying CatE with non-CatE *)
    | CatE ({ it = IterE (_, (ListN _, _)); _ } as e1', _), _ -> overlap env e1 { e2 with it = CatE (e1', e2) }
    | _, CatE ({ it = IterE (_, (ListN _, _)); _ } as e2', _) -> overlap env { e1 with it = CatE (e2', e1) } e2
    | _ ->
      let ty = overlap_typ env e1.note e2.note in
      let id = gen_new_unified env ty in
      let it =
        match ty.it with
        | IterT (ty1, iter) ->
          IterE (VarE id $$ no_region % ty1, (iter, [(id, VarE id $$ no_region % ty)]))
        | _ -> VarE id
      in
      { e1 with it; note = ty }

and overlap_arg env a1 a2 = if eq_arg a1 a2 then a1 else
  (match a1.it, a2.it with
    | ExpA e1, ExpA e2 -> ExpA (overlap env e1 e2)
    | TypA _, TypA _
    | DefA _, DefA _
    | GramA _, GramA _ -> a1.it
    | _, _ -> assert false
  ) $ a1.at

and overlap_typ env t1 t2 = if eq_typ t1 t2 then t1 else
  (match t1.it, t2.it with
    | VarT (id1, args1), VarT (id2, args2) when id1 = id2 ->
      VarT (id1, List.map2 (overlap_arg env) args1 args2)
    | TupT ets1, TupT ets2 when List.for_all2 (fun (e1, _) (e2, _) -> eq_exp e1 e2) ets1 ets2 ->
      TupT (List.map2 (fun (e1, t1) (_, t2) -> (e1, (overlap_typ env) t1 t2)) ets1 ets2)
    | IterT (t1, iter1), IterT (t2, iter2) when eq_iter iter1 iter2 ->
      IterT (overlap_typ env t1 t2, iter1)
    | _ -> assert false (* Unreachable due to IL validation *)
  ) $ t1.at

let pairwise_concat (a,b) (c,d) = (a@c, b@d)

let rec collect_unified template e = if eq_exp template e then [], [] else
  match template.it, e.it with
    | VarE id, _
    | IterE ({ it = VarE id; _}, _) , _
      when is_unified_id id.it ->
      [IfPr (CmpE (`EqOp, `BoolT, template, e) $$ e.at % (BoolT $ e.at)) $ e.at],
      [ExpB (id, template.note) $ e.at]
    | UnE (_, _, e1), UnE (_, _, e2)
    | DotE (e1, _), DotE (e2, _)
    | LenE e1, LenE e2
    | IterE (e1, _), IterE (e2, _)
    | ProjE (e1, _), ProjE (e2, _)
    | UncaseE (e1, _), UncaseE (e2, _)
    | OptE (Some e1), OptE (Some e2)
    | TheE e1, TheE e2
    | CaseE (_, e1), CaseE (_, e2)
    | SubE (e1, _, _), SubE (e2, _, _) -> collect_unified e1 e2
    | BinE (_, _, e1, e1'), BinE (_, _, e2, e2')
    | CmpE (_, _, e1, e1'), CmpE (_, _, e2, e2')
    | IdxE (e1, e1'), IdxE (e2, e2')
    | UpdE (e1, _, e1'), UpdE (e2, _, e2')
    | ExtE (e1, _, e1'), ExtE (e2, _, e2')
    | CompE (e1, e1'), CompE (e2, e2')
    | CatE (e1, e1'), CatE (e2, e2') -> pairwise_concat (collect_unified e1 e2) (collect_unified e1' e2')
    | MemE (e1, e1'), MemE (e2, e2') -> pairwise_concat (collect_unified e1 e2) (collect_unified e1' e2')
    | SliceE (e1, e1', e1''), SliceE (e2, e2', e2'') ->
      pairwise_concat (pairwise_concat (collect_unified e1 e2) (collect_unified e1' e2')) (collect_unified e1'' e2'')
    | StrE efs1, StrE efs2 ->
      List.fold_left2 (fun acc (_, e1) (_, e2) -> pairwise_concat acc (collect_unified e1 e2)) ([], []) efs1 efs2
    | TupE es1, TupE es2
    | ListE es1, ListE es2 ->
      List.fold_left2 (fun acc e1 e2 -> pairwise_concat acc (collect_unified e1 e2)) ([], []) es1 es2
    | CallE (_, as1), CallE (_, as2) -> collect_unified_args as1 as2
    (* HARDCODE: Unifying CatE with non-CatE *)
    | CatE (_, e1), _ -> collect_unified e1 e
    | _ ->
      error e.at "cannot unify the expression with previous rule for the same instruction"

and collect_unified_arg template a = if eq_arg template a then [], [] else match template.it, a.it with
  | ExpA template', ExpA e -> collect_unified template' e
  | TypA _, TypA _
  | DefA _, DefA _
  | GramA _, GramA _ -> [], []
  | _ -> error a.at "cannot unify the argument"

and collect_unified_args as1 as2 =
  List.fold_left2 (fun acc a1 a2 -> pairwise_concat acc (collect_unified_arg a1 a2)) ([], []) as1 as2

(* If otherwise premises are included, make them the first *)
let prioritize_else prems =
  let other, non_others = List.partition (fun p -> p.it = ElsePr) prems in
  other @ non_others


(* x list list -> x list list list *)
let lift = List.map (fun xs -> List.map (fun x -> [x]) xs)
(* x list list list -> x list list *)
let unlift = List.map List.concat

(** 1. Validation rules **)

let apply_template_to_rule template rule =
  match rule.it with
  | RuleD (id, binds, mixop, exp, prems) ->
    let new_prems, _ = collect_unified template exp in
    RuleD (id, binds, mixop, template, new_prems @ prems) $ rule.at

let unify_rules env rules =
  let concls = List.map (fun x -> let RuleD(_, _, _, e, _) = x.it in e) rules in
  let hd = List.hd concls in
  let tl = List.tl concls in
  let template = List.fold_left (overlap env) hd tl in
  List.map (apply_template_to_rule template) rules
  (* |> rename_rules *)


(** 2. Reduction rules **)

let apply_template_to_prems template prems idx =
  List.mapi (fun i prem ->
    if i <> idx then
      prem
    else (
      assert (List.length prem = 1);
      let prem = List.hd prem in
      let new_prem = replace_lhs template prem in
      let new_prems, _ = collect_unified template (lhs_of_prem prem) in
      new_prem :: new_prems)
  ) prems

let unify_enc env premss encs =
  let idxs = List.map fst encs in
  let ps = List.map snd encs in

  let es = List.map lhs_of_prem ps in

  let hd = List.hd es in
  let tl = List.tl es in

  let template = List.fold_left (overlap env) hd tl in

  List.map2 (apply_template_to_prems template) premss idxs

let is_encoded_ctxt pr =
  match pr.it with
  | LetPr (_, e, _) ->
    (match e.note.it with
    | VarT (id, []) -> List.mem id.it ["inputT"; "stackT"; "contextT"]
    | _ -> false)
  | _ -> false
let is_encoded_pop_or_winstr pr =
  match pr.it with
  | LetPr (_, e, _) ->
    (match e.note.it with
    | VarT (id, []) -> List.mem id.it ["inputT"; "stackT"]
    | _ -> false)
  | _ -> false

let rec extract_encs' pred cnt =
  function
  | [] -> []
  | hd :: tl ->
    if pred hd then
      (cnt, hd) :: extract_encs' pred (cnt + 1) tl
    else
      extract_encs' pred (cnt + 1) tl
let extract_encs pred = extract_encs' pred 0

let has_identical_rhs iprem1 iprem2 =
  let rhs1 = iprem1 |> snd |> rhs_of_prem in
  let rhs2 = iprem2 |> snd |> rhs_of_prem in

  eq_exp rhs1 rhs2

let rec filter_unifiable encss =
  match encss with
  | [] -> assert false
  | encs :: encss' ->
    if encs = [] then
      []
    else
      let hd = List.hd encs in
      let tl = List.tl encs in
      let pairs = List.map (fun encs -> List.partition (has_identical_rhs hd) encs) encss' in
      let fsts = List.map fst pairs in
      let snds = List.map snd pairs in

      assert (List.for_all (fun xs -> List.length xs <= 1) fsts);

      if List.for_all (fun xs -> List.length xs = 1) fsts then
        (hd :: List.map List.hd fsts) :: filter_unifiable (tl :: snds)
      else
        filter_unifiable (tl :: snds)

let replace_prems r prems =
  let lhs, rhs, _ = r in
  lhs, rhs, prems

let unify_rule_clauses env pred input_vars (clauses: rule_clause list) =
  let premss = List.map (fun g -> let _, _, prems = g in prems) clauses in
  let encss = List.map (extract_encs pred) premss in
  let unifiable_encss = filter_unifiable encss in
  let new_premss = List.fold_left (unify_enc env) (lift premss) unifiable_encss |> unlift in
  let animated_premss = List.map (Animate.animate_prems {empty with varid = Set.of_list (input_vars @ Encode.input_vars)}) new_premss in

  List.map2 replace_prems clauses animated_premss

let rule_to_tup rule =
  match rule.it with
  | RuleD (_, _, _, exp, prems) ->
    match exp.it with
    | TupE [ lhs; rhs ] -> (lhs, rhs, prems)
    | _ -> error exp.at "form of reduction rule"

(* group reduction rules that have same name *)
let rec group_rules : (id * rule) list -> rule_def list = function
  | [] -> []
  | h :: t ->
    let (rel_id, rule) = h in
    let name = name_of_rule rule in
    let t1, t2 =
      List.partition (fun (_, rule) -> name_of_rule rule = name) t in
    let rules = rule :: List.map (fun (rel_id', rule') ->
      if rel_id = rel_id' then rule' else
        error rule'.at
        "this reduction rule uses a different relation compared to the previous rules"
    ) t1 in
    let tups = List.map rule_to_tup rules in
    let at = rules |> List.map at |> over_region in

    ((name, rel_id, tups) $ at) :: group_rules t2

(* extract reduction rules for wasm instructions *)
let extract_rules def =
  match def.it with
  | RelD (id, _, _, rules) -> List.map (fun rule -> id, rule) rules
  | _ -> []

let unify_ctxt (env: env) (input_vars: string list) (clauses: rule_clause list) : rule_clause list =
  unify_rule_clauses env is_encoded_ctxt input_vars clauses

let unify_pop_and_winstr env rule_def =
  unify_rule_clauses env is_encoded_pop_or_winstr [] rule_def

let unify_rule_def (env: env) (rule: rule_def) : rule_def =
  let instr_name, rel_id, clauses = rule.it in
  let unified_clauses = unify_pop_and_winstr env clauses in
  let pops, clauses' = extract_pops unified_clauses in
  let subgroups = group_by_context clauses' in
  let new_clauses =
    List.concat_map
      (function
        | None, subgroup ->
          List.map (fun (lhs, rhs, prems) -> lhs, rhs, pops @ prems) subgroup
        | _, subgroup ->
          let popped_vars =
            List.concat_map
              (fun p ->
                match p.it with
                | LetPr (_, _, ids) -> ids
                | _ -> assert false
              )
              pops
          in
          let sub_env = { idxs = env.idxs; frees = env.frees } in
          subgroup
          |> unify_ctxt sub_env popped_vars
          |> List.map (fun (lhs, rhs, prems) -> lhs, rhs, pops @ prems)
      )
      subgroups
  in
  (instr_name, rel_id, new_clauses) $ rule.at

let has_substring str sub =
  let len_s = String.length str in
  let len_sub = String.length sub in
  let rec aux i =
    if i > len_s - len_sub then false
    else if String.sub str i len_sub = sub then true
    else aux (i + 1)
  in
  aux 0

let reorder_unified_args args prems =
  (* Helpers *)
  let has_uarg_on_rhs p =
    match p.it with
    | LetPr (_, {it = VarE id; _}, _) -> is_unified_id id.it
    | _ -> false
  in
  let on_rhs p a =
    match a.it with
    | ExpA e -> has_substring (e |> Il.Print.string_of_exp) (rhs_of_prem p |> Il.Print.string_of_exp)
    | _ -> false
  in
  let rec find_index f xs =
    match xs with
    | [] -> 0
    | hd :: tl -> if f hd then 0 else 1 + find_index f tl
  in
  let index_of p = find_index (on_rhs p) args in
  let cmp p1 p2 = index_of p1 - index_of p2 in

  let uprems, prems = List.partition has_uarg_on_rhs prems in
  let uprems' = List.sort cmp uprems in
  uprems' @ prems

let apply_template_to_def template def =
  match def.it with
  | DefD (binds, lhs, rhs, prems) ->
    let new_prems, new_binds = collect_unified_args template lhs in
    let animated_prems = Animate.animate_prems (free_list free_arg template) new_prems in
    let reordered_prems = reorder_unified_args template animated_prems in
    DefD (binds @ new_binds, template, rhs, (reordered_prems @ prems) |> prioritize_else) $ def.at

let unify_defs env defs =
  let lhs_s = List.map (fun x -> let DefD(_, lhs, _, _) = x.it in lhs) defs in
  let hd = List.hd lhs_s in
  let tl = List.tl lhs_s in
  let template = List.fold_left (List.map2 (overlap_arg env)) hd tl in
  List.map (apply_template_to_def template) defs

let unify_helper_def env hd =
  match hd.it with
  | (id, clauses, partial) -> (id, unify_defs env clauses, partial) $ hd.at

let extract_helpers partial_funcs def =
  match def.it with
  | DecD (id, _, _, clauses) when List.length clauses > 0 ->
    let partial = if List.mem id partial_funcs then Partial else Total in
    Some ((id, clauses, partial) $ def.at)
  | _ -> None

let unify (il: script) : rule_def list * helper_def list =
  init_map il;
  let rule_defs =
    il
    |> List.concat_map extract_rules
    |> group_rules
    |> List.map (
      fun rd ->
        let frees = (Free.free_rule_def rd).varid in
        let env = init_env frees in
        (env, unify_rule_def env rd)
    )
    |> List.map rename_rule_def
  in

  let partial_funcs =
    let get_partial_func def =
      let is_partial_hint hint = hint.hintid.it = "partial" in
      match def.it with
      | HintD { it = DecH (id, hints); _ } when List.exists is_partial_hint hints ->
        Some (id)
      | _ -> None
    in
    List.filter_map get_partial_func il
  in
  let helper_defs =
    il
    |> List.filter_map (extract_helpers partial_funcs)
    |> List.map (
      fun hd ->
        let frees = (Free.free_helper_def hd).varid in
        let env = init_env frees in
        (env, unify_helper_def env hd)
    )
    |> List.map rename_helper_def
  in

  rule_defs, helper_defs
