(**
Functions that transform IL into IL.
**)

open Il.Ast
open Il.Eq
open Util
open Util.Source

type rgroup = (exp * exp * (prem list)) phrase list

(* Helpers *)

let take_prefix n str =
  if String.length str < n then
    str
  else
    String.sub str 0 n


(* Walker-based transformer *)

let rec transform_expr f e =
  let new_ = transform_expr f in
  let it =
    match (f e).it with
    | VarE _
    | BoolE _
    | NatE _
    | TextE _ -> e.it
    | UnE (op, e1) -> UnE (op, new_ e1)
    | BinE (op, e1, e2) -> BinE (op, new_ e1, new_ e2)
    | CmpE (op, e1, e2) -> CmpE (op, new_ e1, new_ e2)
    | IdxE (e1, e2) -> IdxE (new_ e1, new_ e2)
    | SliceE (e1, e2, e3) -> SliceE (new_ e1, new_ e2, new_ e3)
    | UpdE (e1, p, e2) -> UpdE (new_ e1, p, new_ e2)
    | ExtE (e1, p, e2) -> ExtE (new_ e1, p, new_ e2)
    | StrE efs -> StrE efs (* TODO efs *)
    | DotE (e1, atom) -> DotE (new_ e1, atom)
    | CompE (e1, e2) -> CompE (new_ e1, new_ e2)
    | LenE e1 -> LenE (new_ e1)
    | TupE es -> TupE ((List.map new_) es)
    | CallE (id, as1) -> CallE (id, List.map (transform_arg f) as1)
    | IterE (e1, iter) -> IterE (new_ e1, iter) (* TODO iter *)
    | ProjE (e1, i) -> ProjE (new_ e1, i)
    | UncaseE (e1, op) -> UncaseE (new_ e1, op)
    | OptE eo -> OptE ((Option.map new_) eo)
    | TheE e1 -> TheE (new_ e1)
    | ListE es -> ListE ((List.map new_) es)
    | CatE (e1, e2) -> CatE (new_ e1, new_ e2)
    | MemE (e1, e2) -> MemE (new_ e1, new_ e2)
    | CaseE (mixop, e1) -> CaseE (mixop, new_ e1)
    | SubE (e1, _t1, t2) -> SubE (new_ e1, _t1, t2)
  in { e with it }


and transform_arg f a =
  { a with it = match a.it with
    | ExpA e -> ExpA (transform_expr f e)
    | TypA t -> TypA t
    | DefA id -> DefA id }

(* Change right_assoc cat into left_assoc cat *)
let to_left_assoc_cat =
  let rec rotate_ccw e =
    begin match e.it with
    | CatE (l, r) ->
      begin match r.it with
      | CatE (rl, rr) ->
        { e with it = CatE (CatE (l, rl) $$ no_region % e.note, rr) } |> rotate_ccw
      | _ -> e
      end
    | _ -> e
    end in
  transform_expr rotate_ccw


(* Change left_assoc cat into right_assoc cat *)
let to_right_assoc_cat =
  let rec rotate_cw e =
    begin match e.it with
    | CatE (l, r) ->
      begin match l.it with
      | CatE (ll, lr) ->
        { e with it = CatE (ll, CatE (lr, r) $$ no_region% e.note) } |> rotate_cw
      | _ -> e
      end
    | _ -> e
    end in
  transform_expr rotate_cw


(* Unifying lhs *)

(* Estimate appropriate id name for a given type *)
let rec type_to_id ty = match ty.it with
(* TODO: guess this for "var" in el? *)
| VarT (id, _) -> take_prefix 5 id.it
| BoolT -> "b"
| NumT NatT -> "n"
| NumT IntT -> "i"
| NumT RatT -> "q"
| NumT RealT -> "r"
| TextT -> "s"
| TupT tys -> List.map type_to_id (List.map snd tys) |> String.concat "_"
| IterT (t, _) -> type_to_id t

let unified_prefix = "u"
let _unified_idx = ref 0
let init_unified_idx () = _unified_idx := 0
let get_unified_idx () = let i = !_unified_idx in _unified_idx := (i+1); i
let gen_new_unified ty = (type_to_id ty) ^ "_" ^ unified_prefix ^ (string_of_int (get_unified_idx())) $ no_region
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
    | TypA _, TypA _ -> a1.it
    | DefA _, DefA _ -> a1.it
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

let rec collect_unified template e = if eq_exp template e then [], [] else
  match template.it, e.it with
    | VarE id, _
    | IterE ({ it = VarE id; _}, _) , _
      when is_unified_id id.it ->
      [ IfPr (CmpE (EqOp, template, e) $$ no_region % (BoolT $ no_region)) $ no_region ],
      [ ExpB (id, template.note, []) $ no_region ]
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
    | _ -> Util.Error.error e.at "prose transformation" "cannot unify the expression with previous rule for the same instruction"

and collect_unified_arg template a = if eq_arg template a then [], [] else match template.it, a.it with
  | ExpA template', ExpA e -> collect_unified template' e
  | TypA _, TypA _ -> [], []
  | DefA _, DefA _ -> [], []
  | _ -> Util.Error.error a.at "prose transformation" "cannot unify the argument"

and collect_unified_args as1 as2 =
  List.fold_left2 (fun acc a1 a2 -> pairwise_concat acc (collect_unified_arg a1 a2)) ([], []) as1 as2

(* If otherwise premises are included, make them the first *)
let prioritize_else prems =
  let other, non_others = List.partition (fun p -> p.it = ElsePr) prems in
  other @ non_others

let apply_template_to_rgroup template (lhs, rhs, prems) =
  let new_prems, _ = collect_unified template lhs in
  (* TODO: Remove this depedency on animation. Perhaps this should be moved as a middle end before animation path *)
  let animated_prems = Animate.animate_prems (Il.Free.free_exp template) (new_prems @ prems) in
  template, rhs, prioritize_else animated_prems

let unify_lhs' rgroup =
  init_unified_idx();
  let fst = fun (x, _, _) -> x in
  let lhs_group = List.map (fun r -> fst r.it) rgroup in
  let hd = List.hd lhs_group in
  let tl = List.tl lhs_group in
  let template = List.fold_left overlap hd tl in
  List.map (Source.map (apply_template_to_rgroup template)) rgroup

let unify_lhs (rname, rgroup) =
  let to_left_assoc (lhs, rhs, prems) = to_left_assoc_cat lhs, rhs, prems in
  let to_right_assoc (lhs, rhs, prems) = to_right_assoc_cat lhs, rhs, prems in
  (* typical f^-1 ∘ g ∘ f *)
  rname, (rgroup |> List.map (Source.map to_left_assoc) |> unify_lhs' |> List.map (Source.map to_right_assoc))

let apply_template_to_def template def =
  match def.it with
  | DefD (binds, lhs, rhs, prems) ->
    let new_prems, new_binds = collect_unified_args template lhs in
    let animated_prems = Animate.animate_prems Il.Free.(free_list free_arg template) new_prems in
    DefD (binds @ new_binds, template, rhs, (animated_prems @ prems) |> prioritize_else) $ no_region

let unify_defs defs =
  init_unified_idx();
  let lhs_s = List.map (fun x -> let DefD(_, lhs, _, _) = x.it in lhs) defs in
  let hd = List.hd lhs_s in
  let tl = List.tl lhs_s in
  let template = List.fold_left (List.map2 overlap_arg) hd tl in
  List.map (apply_template_to_def template) defs
