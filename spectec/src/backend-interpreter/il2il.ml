(**

Functions that trasnforms IL into IL.
Potentially, this can be moved to the middle-end.

**)

open Il.Ast
open Il.Eq
open Util.Source

(** Walker-based transformer **)
let rec transform_expr f e =
  let new_ = transform_expr f in
  { e with it = match (f e).it with
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
    | MixE (op, e1) -> MixE (op, new_ e1)
    | CallE (id, e1) -> CallE (id, new_ e1)
    | IterE (e1, iter) -> IterE (new_ e1, iter) (* TODO iter *)
    | OptE eo -> OptE ((Option.map new_) eo)
    | TheE e1 -> TheE (new_ e1)
    | ListE es -> ListE ((List.map new_) es)
    | CatE (e1, e2) -> CatE (new_ e1, new_ e2)
    | CaseE (atom, e1) -> CaseE (atom, new_ e1)
    | SubE (e1, _t1, t2) -> SubE (new_ e1, _t1, t2)
    | ElementsOfE (e1, e2) -> ElementsOfE (new_ e1, new_ e2)
    | ListBuilderE (e1, e2) -> ListBuilderE (new_ e1, new_ e2) }

(** Change right_assoc cat into left_assoc cat **)
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

(** Change left_assoc cat into right_assoc cat **)
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

(** Unifying lhs **)
let unified_prefix = "fresh_"
let _unified_id = ref 0
let init_unified_id () = _unified_id := 0
let get_unified_id () = let i = !_unified_id in _unified_id := (i+1); i
let gen_new_unified () = unified_prefix ^ (string_of_int (get_unified_id())) $ no_region
let to_iter e iterexp = IterE (e, iterexp)

let rec overlap e1 e2 = if eq_exp e1 e2 then e1 else
  ( match e1.it, e2.it with
  | VarE id, _
  | IterE ({ it = VarE id; _}, _) , _
    when String.starts_with ~prefix:unified_prefix id.it -> e1.it
  | UnE (unop1, e1), UnE (unop2, e2) when unop1 = unop2 ->
      UnE (unop1, overlap e1 e2)
  | BinE (binop1, e1, e1'), BinE (binop2, e2, e2') when binop1 = binop2 ->
      BinE (binop1, overlap e1 e2, overlap e1' e2')
  | CmpE (cmpop1, e1, e1'), CmpE (cmpop2, e2, e2') when cmpop1 = cmpop2 ->
      CmpE (cmpop1, overlap e1 e2, overlap e1' e2')
  | IdxE (e1, e1'), IdxE (e2, e2') ->
      IdxE (overlap e1 e2, overlap e1' e2')
  | SliceE (e1, e1', e1''), SliceE (e2, e2', e2'') ->
      SliceE (overlap e1 e2, overlap e1' e2', overlap e1'' e2'')
  | UpdE (e1, path1, e1'), UpdE (e2, path2, e2') when eq_path path1 path2 ->
      UpdE (overlap e1 e2, path1, overlap e1' e2')
  | ExtE (e1, path1, e1'), ExtE (e2, path2, e2') when eq_path path1 path2 ->
      ExtE (overlap e1 e2, path1, overlap e1' e2')
  | StrE efs1, StrE efs2 when List.map fst efs1 = List.map fst efs2 ->
      StrE (List.map2 (fun (a1, e1) (_, e2) -> (a1, overlap e1 e2)) efs1 efs2)
  | DotE (e1, atom1), DotE (e2, atom2) when atom1 = atom2 ->
      DotE (overlap e1 e2, atom1)
  | CompE (e1, e1'), CompE (e2, e2') ->
      CompE (overlap e1 e2, overlap e1' e2')
  | LenE e1, LenE e2 ->
      LenE (overlap e1 e2)
  | TupE es1, TupE es2 when List.length es1 = List.length es2 ->
      TupE (List.map2 overlap es1 es2)
  | MixE (mixop1, e1), MixE (mixop2, e2) when mixop1 = mixop2 ->
      MixE (mixop1, overlap e1 e2)
  | CallE (id1, e1), CallE (id2, e2) when eq_id id1 id2->
      CallE (id1, overlap e1 e2)
  | IterE (e1, itere1), IterE (e2, itere2) when eq_iterexp itere1 itere2 ->
      IterE (overlap e1 e2, itere1)
  | OptE (Some e1), OptE (Some e2) ->
      OptE (Some (overlap e1 e2))
  | TheE e1, TheE e2 ->
      TheE (overlap e1 e2)
  | ListE es1, ListE es2 when List.length es1 = List.length es2 ->
      ListE (List.map2 overlap es1 es2)
  | CatE (e1, e1'), CatE (e2, e2') ->
      CatE (overlap e1 e2, overlap e1' e2')
  | CaseE (atom1, e1), CaseE (atom2, e2) when atom1 = atom2 ->
      CaseE (atom1, overlap e1 e2)
  | SubE (e1, typ1, typ1'), SubE (e2, typ2, typ2') when eq_typ typ1 typ2 && eq_typ typ1' typ2' ->
      SubE (overlap e1 e2, typ1, typ1')
  | _ ->
    let id = gen_new_unified () in
    match e1.note.it with
    | IterT (ty, iter) -> to_iter (VarE id $$ no_region % ty) (iter, [id])
    | _ -> VarE id
  ) $$ (e1.at % e1.note)

let pairwise_concat (a,b) (c,d) = (a@c, b@d)

let rec collect_unified template e = if eq_exp template e then [], [] else match template.it, e.it with
  | VarE id, _
  | IterE ({ it = VarE id; _}, _) , _
    when String.starts_with ~prefix:unified_prefix id.it ->
    [ IfPr (CmpE (EqOp, template, e) $$ no_region % (BoolT $ no_region)) $ no_region ],
    [id, template.note, []]
  (* one e *)
  | UnE (_, e1), UnE (_, e2)
  | DotE (e1, _), DotE (e2, _)
  | LenE e1, LenE e2
  | MixE (_, e1), MixE (_, e2)
  | CallE (_, e1), CallE (_, e2)
  | IterE (e1, _), IterE (e2, _)
  | OptE (Some e1), OptE (Some e2)
  | TheE e1, TheE e2
  | CaseE (_, e1), CaseE (_, e2)
  | SubE (e1, _, _), SubE (e2, _, _) -> collect_unified e1 e2
  (* two e *)
  | BinE (_, e1, e1'), BinE (_, e2, e2')
  | CmpE (_, e1, e1'), CmpE (_, e2, e2')
  | IdxE (e1, e1'), IdxE (e2, e2')
  | UpdE (e1, _, e1'), UpdE (e2, _, e2')
  | ExtE (e1, _, e1'), ExtE (e2, _, e2')
  | CompE (e1, e1'), CompE (e2, e2')
  | CatE (e1, e1'), CatE (e2, e2') -> pairwise_concat (collect_unified e1 e2) (collect_unified e1' e2')
  (* others *)
  | SliceE (e1, e1', e1''), SliceE (e2, e2', e2'') ->
      pairwise_concat (pairwise_concat (collect_unified e1 e2) (collect_unified e1' e2')) (collect_unified e1'' e2'')
  | StrE efs1, StrE efs2 ->
      List.fold_left2 (fun acc (_, e1) (_, e2) -> pairwise_concat acc (collect_unified e1 e2)) ([], []) efs1 efs2
  | TupE es1, TupE es2
  | ListE es1, ListE es2 ->
      List.fold_left2 (fun acc e1 e2 -> pairwise_concat acc (collect_unified e1 e2)) ([], []) es1 es2
  | _ -> failwith "Impossible collect_unified"

(** If prems include a otherwise premise, make it first prem **)
let prioritize_else prems =
  let other, non_others = List.partition (fun p -> p.it = ElsePr) prems in
  other @ non_others

let apply_template_to_red_group template (lhs, rhs, prems, binds) =
  let (new_prems, new_binds) = collect_unified template lhs in
  (* TODO: Remove this depedency on animation. Perhaps this should be moved as a middle end before animation path *)
  let animated_prems = Middlend.Animate.animate_prems (Il.Free.free_exp template) new_prems in
  (template, rhs, (animated_prems @ prems) |> prioritize_else, binds @ new_binds)

let unify_lhs' reduction_group =
  init_unified_id();
  let lhs_group = List.map (function (lhs, _, _, _) -> lhs) reduction_group in
  let hd = List.hd lhs_group in
  let tl = List.tl lhs_group in
  let template = List.fold_left overlap hd tl in
  List.map (apply_template_to_red_group template) reduction_group

let unify_lhs (reduction_name, reduction_group) =
  let to_left_assoc (lhs, rhs, prems, bind) = (to_left_assoc_cat lhs), rhs, prems, bind in
  let to_right_assoc (lhs, rhs, prems, bind) = (to_right_assoc_cat lhs), rhs, prems, bind in
  (* typical f^-1 ∘ g ∘ f *)
  reduction_name, (reduction_group |> List.map to_left_assoc |> unify_lhs' |> List.map to_right_assoc)

let apply_template_to_def template def =
  let DefD (binds, lhs, rhs, prems) = def.it in
  let (new_prems, new_binds) = collect_unified template lhs in
  let animated_prems = Middlend.Animate.animate_prems (Il.Free.free_exp template) new_prems in
  DefD (binds @ new_binds, template, rhs, (animated_prems @ prems) |> prioritize_else) $ no_region

let unify_defs defs =
  init_unified_id();
  let lhs_s = List.map (fun x -> let DefD(_, lhs, _, _) = x.it in lhs) defs in
  let hd = List.hd lhs_s in
  let tl = List.tl lhs_s in
  let template = List.fold_left overlap hd tl in
  List.map (apply_template_to_def template) defs
