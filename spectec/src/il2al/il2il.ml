(**
Functions that transform IL into IL.
**)

open Il.Ast
open Il.Eq
open Il.Free
open Util
open Util.Source

type rgroup = (exp * exp * (prem list)) phrase list

(* Helpers *)

(* Unifying lhs *)

(* Estimate appropriate id name for a given type *)

let unified_prefix = "u"
let _unified_idx = ref 0
let init_unified_idx () = _unified_idx := 0
let get_unified_idx () = let i = !_unified_idx in _unified_idx := (i+1); i
let gen_new_unified ty = (Al.Al_util.typ_to_var_name ty) ^ "_" ^ unified_prefix ^ (string_of_int (get_unified_idx())) $ no_region
let is_unified_id id = String.split_on_char '_' id |> Util.Lib.List.last |> String.starts_with ~prefix:unified_prefix

let rec overlap e1 e2 = if eq_exp e1 e2 then e1 else
  let replace_it it = { e1 with it = it } in
  match e1.it, e2.it with
    (* Already unified *)
    | VarE id, _ when is_unified_id id.it ->
      e1
    | IterE ({ it = VarE id; _} as e, (iter, _)), _  when is_unified_id id.it ->
      let t = overlap_typ e1.note e2.note in
      let i = (iter, [(id, t)]) in
      { e1 with it = IterE (e, i); note = t }
    (* Not unified *)
    | UnE (unop1, e1), UnE (unop2, e2) when unop1 = unop2 ->
      UnE (unop1, overlap e1 e2) |> replace_it
    | BinE (binop1, e1, e1'), BinE (binop2, e2, e2') when binop1 = binop2 ->
      BinE (binop1, overlap e1 e2, overlap e1' e2') |> replace_it
    | CmpE (cmpop1, e1, e1'), CmpE (cmpop2, e2, e2') when cmpop1 = cmpop2 ->
      CmpE (cmpop1, overlap e1 e2, overlap e1' e2') |> replace_it
    | IdxE (e1, e1'), IdxE (e2, e2') ->
      IdxE (overlap e1 e2, overlap e1' e2') |> replace_it
    | SliceE (e1, e1', e1''), SliceE (e2, e2', e2'') ->
      SliceE (overlap e1 e2, overlap e1' e2', overlap e1'' e2'') |> replace_it
    | UpdE (e1, path1, e1'), UpdE (e2, path2, e2') when eq_path path1 path2 ->
      UpdE (overlap e1 e2, path1, overlap e1' e2') |> replace_it
    | ExtE (e1, path1, e1'), ExtE (e2, path2, e2') when eq_path path1 path2 ->
      ExtE (overlap e1 e2, path1, overlap e1' e2') |> replace_it
    | StrE efs1, StrE efs2 when List.map fst efs1 = List.map fst efs2 ->
      StrE (List.map2 (fun (a1, e1) (_, e2) -> (a1, overlap e1 e2)) efs1 efs2) |> replace_it
    | DotE (e1, atom1), DotE (e2, atom2) when eq_atom atom1 atom2 ->
      DotE (overlap e1 e2, atom1) |> replace_it
    | CompE (e1, e1'), CompE (e2, e2') ->
      CompE (overlap e1 e2, overlap e1' e2') |> replace_it
    | LenE e1, LenE e2 ->
      LenE (overlap e1 e2) |> replace_it
    | TupE es1, TupE es2 when List.length es1 = List.length es2 ->
      TupE (List.map2 overlap es1 es2) |> replace_it
    | CallE (id1, as1), CallE (id2, as2) when eq_id id1 id2 ->
      CallE (id1, List.map2 overlap_arg as1 as2) |> replace_it
    | IterE (e1, itere1), IterE (e2, itere2) when eq_iterexp itere1 itere2 ->
      IterE (overlap e1 e2, itere1) |> replace_it
    | ProjE (e1, i1), ProjE (e2, i2) when i1 = i2 ->
      ProjE (overlap e1 e2, i1) |> replace_it
    | UncaseE (e1, op1), UncaseE (e2, op2) when eq_mixop op1 op2 ->
      UncaseE (overlap e1 e2, op1) |> replace_it
    | OptE (Some e1), OptE (Some e2) ->
      OptE (Some (overlap e1 e2)) |> replace_it
    | TheE e1, TheE e2 ->
      TheE (overlap e1 e2) |> replace_it
    | ListE es1, ListE es2 when List.length es1 = List.length es2 ->
      ListE (List.map2 overlap es1 es2) |> replace_it
    | CatE (e1, e1'), CatE (e2, e2') ->
      CatE (overlap e1 e2, overlap e1' e2') |> replace_it
    | MemE (e1, e1'), MemE (e2, e2') ->
      MemE (overlap e1 e2, overlap e1' e2') |> replace_it
    | CaseE (mixop1, e1), CaseE (mixop2, e2) when eq_mixop mixop1 mixop2 ->
      CaseE (mixop1, overlap e1 e2) |> replace_it
    | SubE (e1, typ1, typ1'), SubE (e2, typ2, typ2') when eq_typ typ1 typ2 && eq_typ typ1' typ2' ->
      SubE (overlap e1 e2, typ1, typ1') |> replace_it
    (* HARDCODE: Unifying CatE with non-CatE *)
    | CatE ({ it = IterE (_, (ListN _, _)); _ } as e1', _), _ -> overlap e1 { e2 with it = CatE (e1', e2) }
    | _, CatE ({ it = IterE (_, (ListN _, _)); _ } as e2', _) -> overlap { e1 with it = CatE (e2', e1) } e2
    | _ ->
      let ty = overlap_typ e1.note e2.note in
      let id = gen_new_unified ty in
      let it =
        match ty.it with
        | IterT (ty, iter) -> IterE (VarE id $$ no_region % ty, (iter, [(id, ty)]))
        | _ -> VarE id
      in
      { e1 with it = it; note = ty }

and overlap_arg a1 a2 = if eq_arg a1 a2 then a1 else
  (match a1.it, a2.it with
    | ExpA e1, ExpA e2 -> ExpA (overlap e1 e2)
    | TypA _, TypA _
    | DefA _, DefA _
    | GramA _, GramA _ -> a1.it
    | _, _ -> assert false
  ) $ a1.at

and overlap_typ t1 t2 = if eq_typ t1 t2 then t1 else
  (match t1.it, t2.it with
    | VarT (id1, args1), VarT (id2, args2) when id1 = id2 ->
      VarT (id1, List.map2 overlap_arg args1 args2)
    | TupT ets1, TupT ets2 when List.for_all2 (fun (e1, _) (e2, _) -> eq_exp e1 e2) ets1 ets2 ->
      TupT (List.map2 (fun (e1, t1) (_, t2) -> (e1, overlap_typ t1 t2)) ets1 ets2)
    | IterT (t1, iter1), IterT (t2, iter2) when eq_iter iter1 iter2 ->
      IterT (overlap_typ t1 t2, iter1)
    | _ -> assert false (* Unreachable due to IL validation *)
  ) $ t1.at

let pairwise_concat (a,b) (c,d) = (a@c, b@d)

type if_or_let = If | Let
let if_or_let_flag = ref If

let rec collect_unified template e = if eq_exp template e then [], [] else
  match template.it, e.it with
    | VarE id, _
    | IterE ({ it = VarE id; _}, _) , _
      when is_unified_id id.it ->
      [
        match !if_or_let_flag with
        | If -> IfPr (CmpE (EqOp, template, e) $$ e.at % (BoolT $ e.at)) $ e.at
        | Let -> LetPr (e, template, []) $ e.at
      ],
      [ ExpB (id, template.note, []) $ e.at ]
    | UnE (_, e1), UnE (_, e2)
    | DotE (e1, _), DotE (e2, _)
    | LenE e1, LenE e2
    | IterE (e1, _), IterE (e2, _)
    | ProjE (e1, _), ProjE (e2, _)
    | UncaseE (e1, _), UncaseE (e2, _)
    | OptE (Some e1), OptE (Some e2)
    | TheE e1, TheE e2
    | CaseE (_, e1), CaseE (_, e2)
    | SubE (e1, _, _), SubE (e2, _, _) -> collect_unified e1 e2
    | BinE (_, e1, e1'), BinE (_, e2, e2')
    | CmpE (_, e1, e1'), CmpE (_, e2, e2')
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
      Util.Error.error e.at "prose transformation" "cannot unify the expression with previous rule for the same instruction"

and collect_unified_arg template a = if eq_arg template a then [], [] else match template.it, a.it with
  | ExpA template', ExpA e -> collect_unified template' e
  | TypA _, TypA _
  | DefA _, DefA _
  | GramA _, GramA _ -> [], []
  | _ -> Util.Error.error a.at "prose transformation" "cannot unify the argument"

and collect_unified_args as1 as2 =
  List.fold_left2 (fun acc a1 a2 -> pairwise_concat acc (collect_unified_arg a1 a2)) ([], []) as1 as2

(* If otherwise premises are included, make them the first *)
let prioritize_else prems =
  let other, non_others = List.partition (fun p -> p.it = ElsePr) prems in
  other @ non_others

let lhs_of_prem pr =
  match pr.it with
  | LetPr (lhs, _, _) -> lhs
  | _ -> Error.error pr.at "prose translation" "expected a LetPr"
let rhs_of_prem pr =
  match pr.it with
  | LetPr (_, rhs, _) -> rhs
  | _ -> Error.error pr.at "prose translation" "expected a LetPr"
let replace_lhs lhs pr =
  match pr.it with
  | LetPr (lhs', rhs, _) ->
    if eq_exp lhs lhs' then
      pr
    else
      { pr with it = LetPr (lhs, rhs, (free_exp lhs).varid |> Set.to_list) }
  | _ -> Error.error pr.at "prose translation" "expected a LetPr"
let inject_ids pr1 pr2 =
  match pr1.it, pr2.it with
  | LetPr (_, _, ids), LetPr (lhs, rhs, _) ->
    let ids' = Set.inter (Set.of_list ids) (free_exp lhs).varid |> Set.to_list in
    { pr2 with it = LetPr (lhs, rhs, ids') }
  | _ -> Error.error (over_region [pr1.at; pr2.at]) "prose translation" "expected a LetPr"

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

let unify_rules rules =
  init_unified_idx();
  if_or_let_flag := If;

  let concls = List.map (fun x -> let RuleD(_, _, _, e, _) = x.it in e) rules in
  let hd = List.hd concls in
  let tl = List.tl concls in
  let template = List.fold_left overlap hd tl in
  List.map (apply_template_to_rule template) rules


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
      let new_prems' = List.map (inject_ids prem) new_prems in
      new_prem :: new_prems')
  ) prems

let unify_enc premss encs =
  let idxs = List.map fst encs in
  let ps = List.map snd encs in

  let es = List.map lhs_of_prem ps in

  let hd = List.hd es in
  let tl = List.tl es in

  let template = List.fold_left overlap hd tl in

  List.map2 (apply_template_to_prems template) premss idxs

let is_enc pr =
  match pr.it with
  | LetPr (_, e, _) ->
    (match e.note.it with
    | VarT (id, []) -> List.mem id.it ["stackT"; "inputT"; "contextT"]
    | _ -> false)
  | _ -> false

let rec extract_encs' cnt =
  function
  | [] -> []
  | hd :: tl ->
    if is_enc hd then
      (cnt, hd) :: extract_encs' (cnt + 1) tl
    else
      extract_encs' (cnt + 1) tl
let extract_encs = extract_encs' 0

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
  let (lhs, rhs, _prems) = r.it in
  (*
  List.iter (fun p -> print_endline (Il.Print.string_of_prem p)) _prems;
  print_endline "->";
  List.iter (fun p -> print_endline (Il.Print.string_of_prem p)) prems;
  print_endline "";
  *)
  { r with it = (lhs, rhs, prems) }

let unify_rgroup rgroup =
  init_unified_idx();
  if_or_let_flag := Let;

  let premss = List.map (fun g -> let (_, _, prems) = g.it in prems) rgroup in
  let encss = List.map extract_encs premss in
  let unifiable_encss = filter_unifiable encss in
  let new_premss = List.fold_left unify_enc (lift premss) unifiable_encss |> unlift in
  let animated_premss = List.map (Animate.animate_prems {empty with varid = Set.of_list Encode.input_vars}) new_premss in

  List.map2 replace_prems rgroup animated_premss


(** 3. Functions **)

let apply_template_to_def template def =
  match def.it with
  | DefD (binds, lhs, rhs, prems) ->
    let new_prems, new_binds = collect_unified_args template lhs in
    let animated_prems = Animate.animate_prems (free_list free_arg template) new_prems in
    DefD (binds @ new_binds, template, rhs, (animated_prems @ prems) |> prioritize_else) $ def.at

let unify_defs defs =
  init_unified_idx();
  if_or_let_flag := If;

  let lhs_s = List.map (fun x -> let DefD(_, lhs, _, _) = x.it in lhs) defs in
  let hd = List.hd lhs_s in
  let tl = List.tl lhs_s in
  let template = List.fold_left (List.map2 overlap_arg) hd tl in
  List.map (apply_template_to_def template) defs
