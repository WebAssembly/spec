open Util
open Source
open Il
open Ast


(* Errors *)

let error at msg = Error.error at "dimension" msg


(* Environment *)

module Map = Map.Make(String)

type ctx = iter list
type dims = (region * ctx) Map.t
type outer = dims
type rdims = (region * ctx * [`Impl | `Expl | `Outer]) list Map.t

let new_dims outer =
  ref (Map.map (fun (at, ctx) -> [(at, ctx, `Outer)]) outer)

let localize outer dims =
  Map.fold (fun x _ dims -> Map.remove x dims) outer dims


let il_occur occur =
  let ss =
    List.map (fun (x, (t, iters)) ->
      x ^ ":" ^ Il.Debug.il_typ t ^
        String.concat "" (List.map Il.Debug.il_iter iters)
    ) (Map.bindings occur)
  in "{" ^ String.concat ", " ss ^ "}"


(* Solving constraints *)

let string_of_ctx id ctx =
  id ^ String.concat "" (List.map Print.string_of_iter ctx)

let rec is_prefix ctx1 ctx2 =
  match ctx1, ctx2 with
  | [], _ -> true
  | _, [] -> false
  | iter1::ctx1', iter2::ctx2' ->
    Eq.eq_iter iter1 iter2 && is_prefix ctx1' ctx2'


let rec check_ctx id (at0, ctx0, mode0) = function
  | [] -> ()
  | (at, ctx, mode)::ctxs ->
    if not (is_prefix ctx0 ctx) && (mode0 <> `Impl || mode <> `Impl) then
      error at ("inconsistent variable context, " ^
        string_of_ctx id ctx0 ^ " vs " ^ string_of_ctx id ctx ^
        " (" ^ string_of_region at0 ^ ")");
    check_ctx id (at0, ctx0, mode0) ctxs


let check_ctxs id ctxs : region * ctx =
  (* Invariant: there is at most one Outer occurrence per id. *)
  let sorted =
    if List.for_all (fun (_, _, mode) -> mode = `Impl) ctxs then
      (* Take first occurrence *)
      List.stable_sort
        (fun (at1, _, _) (at2, _, _) -> compare at1 at2)
        ctxs
    else
      let sorted = List.stable_sort
        (fun (_, ctx1, mode1) (_, ctx2, mode2) ->
          if mode1 = `Outer then -1 else if mode2 = `Outer then +1 else
          compare (List.length ctx1) (List.length ctx2))
        ctxs
      in
      check_ctx id (List.hd sorted) (List.tl sorted);
      sorted
  in
  let at, ctx, _ = List.hd sorted in
  at, ctx

let check_dims (dims : rdims ref) : dims =
Printf.printf "[check_dims] %s\n%!" (Debug.domain !dims);
  Map.mapi check_ctxs !dims


(* Collecting constraints *)

let strip_index = function
  | ListN (e, Some _) -> ListN (e, None)
  | iter -> iter

let check_typid _dims _ctx _id = ()   (* Types are always global *)
let check_gramid _dims _ctx _id = ()  (* Grammars are always global *)

let check_varid dims ctx mode id =
  dims := Map.add_to_list id.it (id.at, ctx, mode) !dims

let uncheck_varid dims id =
  let ctxs' = List.tl (Map.find id.it !dims) in
  dims :=
    if ctxs' = [] then
      Map.remove id.it !dims
    else
      Map.add id.it ctxs' !dims

let rec check_iter dims ctx it =
  match it with
  | Opt | List | List1 -> ()
  | ListN (e, x_opt) ->
    check_exp dims ctx e;
    Option.iter (check_varid dims [] `Expl) x_opt

and check_iterexp : 'a. _ -> _ -> (_ -> _ -> 'a -> unit) -> 'a -> _ -> unit =
  fun dims ctx f body (it, xes) ->
  check_iter dims ctx it;
  List.iter (fun (x, e) -> check_varid dims [] `Expl x; check_exp dims ctx e) xes;
  (* Only check body if iteration isn't annotated already.
   * That may happen when e.g. an expression got substituted originating from
   * a type definition already processed earlier. *)
  if xes = [] then f dims (strip_index it::ctx) body;
  (* Remove locals.
   * All locals are scalar, so no checking or annotation is needed for them. *)
  List.iter (fun (x, _) -> uncheck_varid dims x) xes;
  match it with
  | ListN (_, Some x) -> uncheck_varid dims x
  | _ -> ()

and check_typ dims ctx t =
  match t.it with
  | VarT (x, args) ->
    check_typid dims ctx x;
    List.iter (check_arg dims ctx) args
  | BoolT
  | NumT _
  | TextT -> ()
  | TupT xts -> List.iter (check_typbind dims ctx) xts
  | IterT (t1, iter) ->
    check_iter dims ctx iter;
    check_typ dims (strip_index iter::ctx) t1

and check_typbind dims ctx (x, t) =
  check_varid dims ctx `Impl x;
  check_typ dims ctx t

(*
and check_deftyp dims ctx dt =
  match dt.it with
  | AliasT t ->
    check_typ dims ctx t
  | StructT tfs ->
    List.iter (fun (_, (qs, tI, prems), _) ->
      let dims' = ref Map.empty in
      assert (qs = []);
      check_typ dims' ctx tI;
      List.iter (check_prem dims' ctx) prems
    ) tfs
  | VariantT tcs ->
    List.iter (fun (_, (qs, tI, prems), _) ->
      let dims' = ref Map.empty in
      assert (qs = []);
      check_typ dims' ctx tI;
      List.iter (check_prem dims' ctx) prems
    ) tcs
*)

and check_exp dims ctx e =
  Debug.(log "il.check_exp"
    (fun _ -> il_exp e)
    (fun _ -> domain !dims)
  ) @@ fun _ ->
  match e.it with
  | VarE x ->
    check_varid dims ctx `Expl x
  | BoolE _
  | NumE _
  | TextE _ -> ()
  | CvtE (e1, _, _)
  | UnE (_, _, e1)
  | LenE e1
  | ProjE (e1, _)
  | TheE e1
  | LiftE e1 ->
    check_exp dims ctx e1
  | BinE (_, _, e1, e2)
  | CmpE (_, _, e1, e2)
  | IdxE (e1, e2)
  | CatE (e1, e2)
  | MemE (e1, e2)
  | CompE (e1, e2) ->
    check_exp dims ctx e1;
    check_exp dims ctx e2
  | SliceE (e1, e2, e3) ->
    check_exp dims ctx e1;
    check_exp dims ctx e2;
    check_exp dims ctx e3
  | UpdE (e1, p, e2)
  | ExtE (e1, p, e2) ->
    check_exp dims ctx e1;
    check_path dims ctx p;
    check_exp dims ctx e2
  | OptE eo ->
    Option.iter (check_exp dims ctx) eo
  | ListE es
  | TupE es ->
    List.iter (check_exp dims ctx) es
  | StrE efs ->
    List.iter (check_expfield dims ctx) efs
  | DotE (e1, _)
  | CaseE (_, e1)
  | UncaseE (e1, _) ->
    check_exp dims ctx e1
  | CallE (_, as_) ->
    List.iter (check_arg dims ctx) as_
  | IterE (e1, ite) ->
    check_iterexp dims ctx check_exp e1 ite
  | SubE (e1, t1, t2) ->
    check_exp dims ctx e1;
    check_typ dims ctx t1;
    check_typ dims ctx t2

and check_expfield dims ctx (_, e) =
  check_exp dims ctx e

and check_path dims ctx p =
  match p.it with
  | RootP -> ()
  | IdxP (p1, e) ->
    check_path dims ctx p1;
    check_exp dims ctx e
  | SliceP (p1, e1, e2) ->
    check_path dims ctx p1;
    check_exp dims ctx e1;
    check_exp dims ctx e2
  | DotP (p1, _) ->
    check_path dims ctx p1

and check_sym dims ctx g =
  match g.it with
  | VarG (x, args) ->
    check_gramid dims ctx x;
    List.iter (check_arg dims ctx) args
  | NumG _
  | TextG _
  | EpsG -> ()
  | SeqG gs
  | AltG gs ->
    List.iter (check_sym dims ctx) gs
  | RangeG (g1, g2) ->
    check_sym dims ctx g1;
    check_sym dims ctx g2
  | AttrG (e, g1) ->
    check_exp dims ctx e;
    check_sym dims ctx g1
  | IterG (g1, ite) ->
    check_iterexp dims ctx check_sym g1 ite


and check_prem dims ctx prem =
  match prem.it with
  | RulePr (_x, _mixop, e) -> check_exp dims ctx e
  | IfPr e -> check_exp dims ctx e
  | ElsePr -> ()
  | LetPr (e1, e2, _xs) ->
    check_exp dims ctx e1;
    check_exp dims ctx e2
  | IterPr (prem1, ite) ->
    check_iterexp dims ctx check_prem prem1 ite

and check_arg dims ctx a =
  match a.it with
  | ExpA e -> check_exp dims ctx e
  | TypA t -> check_typ dims ctx t
  | GramA g -> check_sym dims ctx g
  | DefA _x -> ()

and check_param dims p =
  match p.it with
  | ExpP (x, t) ->
    check_varid dims [] `Expl x;
    check_typ dims [] t
  | TypP x ->
    check_typid dims [] x;
    check_varid dims [] `Impl x
  | GramP (x, ps, t) ->
    check_gramid dims [] x;
    List.iter (check_param dims) ps;
    check_typ dims [] t
  | DefP (_x, ps, t) ->
    List.iter (check_param dims) ps;
    check_typ dims [] t


(* External interface *)

let check outer ps as_ ts es gs prs : dims =
  let dims = new_dims outer in
  List.iter (check_param dims) ps;
  List.iter (check_arg dims []) as_;
  List.iter (check_typ dims []) ts;
  List.iter (check_exp dims []) es;
  List.iter (check_sym dims []) gs;
  List.iter (check_prem dims []) prs;
  localize outer (check_dims dims)

(*
let rec check_def d : dims =
  let dims = new_dims Map.empty in
  match d.it with
  | TypD (_x, ps, insts) ->
    List.iter (check_param dims) ps;
    List.iter (check_inst dims) insts;
    check_dims dims
  | RelD (_x, _mixop, t, rules) ->
    check_typ dims [] t;
    List.iter (check_rule dims) rules;
    check_dims dims
  | DecD (_x, ps, t, clauses) ->
    List.iter (check_param dims) ps;
    check_typ dims [] t;
    List.iter (check_clause dims) clauses;
    check_dims dims
  | GramD (_x, ps, t, prods) ->
    List.iter (check_param dims) ps;
    check_typ dims [] t;
    List.iter (check_prod dims) prods;
    check_dims dims
  | RecD _ds ->
    assert false
  | HintD _ ->
    check_dims dims

and check_inst dims inst =
  match inst.it with
  | InstD (qs, as_, dt) ->
    assert (qs = []);
    List.iter (check_arg dims []) as_;
    check_deftyp dims [] dt

and check_rule dims rule =
  match rule.it with
  | RuleD (_x, qs, _mixop, e, prems) ->
    assert (qs = []);
    check_exp dims [] e;
    List.iter (check_prem dims []) prems

and check_clause dims clause =
  match clause.it with
  | DefD (qs, as_, e, prems) ->
    assert (qs = []);
    List.iter (check_arg dims []) as_;
    check_exp dims [] e;
    List.iter (check_prem dims []) prems

and check_prod dims prod =
  match prod.it with
  | ProdD (qs, g, e, prems) ->
    assert (qs = []);
    check_sym dims [] g;
    check_exp dims [] e;
    List.iter (check_prem dims []) prems


let check_inst outer as_ dt : dims =
  let dims = new_dims outer in
  List.iter (check_arg dims []) as_;
  check_deftyp dims [] dt;
  localize outer (check_dims dims)

let check_prod outer g e prems : dims =
  let dims = new_dims outer in
  check_sym dims [] g;
  check_exp dims [] e;
  List.iter (check_prem dims []) prems;
  localize outer (check_dims dims)

let check_abbr outer g1 g2 prems : dims =
  let dims = new_dims outer in
  check_sym dims [] g1;
  check_sym dims [] g2;
  List.iter (check_prem dims []) prems;
  localize outer (check_dims dims)

let check_deftyp outer ts prems : dims =
  let dims = new_dims outer in
  List.iter (check_typ dims []) ts;
  List.iter (check_prem dims []) prems;
  localize outer (check_dims dims)
*)


(* Annotating iterations *)

type occur = (typ * iter list) Map.t

let union = Map.union (fun _ (_, ctx1 as occ1) (_, ctx2 as occ2) ->
  (* For well-typed scripts, t1 == t2. *)
  Some (if List.length ctx1 < List.length ctx2 then occ1 else occ2))

let annot_varid' id' = function
  | Opt -> id' ^ Il.Print.string_of_iter Opt
  | _ -> id' ^ Il.Print.string_of_iter List

let rec annot_varid id = function
  | [] -> id
  | iter::iters -> annot_varid (annot_varid' id.it iter $ id.at) iters


let rec annot_iter side dims iter : iter * occur =
  Il.Debug.(log "il.annot_iter"
    (fun _ -> fmt "%s" (il_iter iter))
    (fun (iter', occur) -> fmt "%s %s" (il_iter iter') (il_occur occur))
  ) @@ fun _ ->
  match iter with
  | Opt | List | List1 -> iter, Map.empty
  | ListN (e, x_opt) ->
    let e', occur = annot_exp side dims e in
    ListN (e', x_opt), occur

and annot_iterexp side dims occur1 (it, xes) at : iterexp * occur =
  Il.Debug.(log_at "il.annot_iterexp" at
    (fun _ -> fmt "%s %s" (il_iter it) (il_occur occur1))
    (fun ((it', _), occur') -> fmt "%s %s" (il_iter it') (il_occur occur'))
  ) @@ fun _ ->
  assert (xes = []);
  let it', occur2 = annot_iter side dims it in
  (* Remove locals and lower context level of non-locals *)
  let occur1' =
    List.filter_map (fun (x, (t, its)) ->
      match its with
      | [] -> None
      | it::its' -> Some (x, (annot_varid' x it, (IterT (t, it) $ at, its')))
    ) (Map.bindings occur1)
  in
  List.iter (fun (x, _) -> assert (not (Map.mem x.it dims))) xes;
  if side = `Rhs && occur1' = [] && match it with Opt | ListN _ -> false | _ -> true then
    error at "iteration does not contain iterable variable";
  let xes' =
    List.map (fun (x, (x', (t, _))) -> x $ at, VarE (x' $ at) $$ at % t) occur1' in
  (it', xes'), union (Map.of_seq (List.to_seq (List.map snd occur1'))) occur2

and annot_typ dims t : typ * occur =
  Il.Debug.(log "il.annot_typ"
    (fun _ -> fmt "%s" (il_typ t))
    (fun (t', occur') -> fmt "%s %s" (il_typ t') (il_occur occur'))
  ) @@ fun _ ->
  let it, occur =
    match t.it with
    | VarT (x, as1) ->
      let as1', occurs = List.split (List.map (annot_arg dims) as1) in
      VarT (x, as1'), List.fold_left union Map.empty occurs
    | BoolT | NumT _ | TextT ->
      t.it, Map.empty
    | TupT xts ->
      let xts', occurs = List.split (List.map (annot_typbind dims) xts) in
      TupT xts', List.fold_left union Map.empty occurs
    | IterT (t1, iter) ->
      let t1', occur1 = annot_typ dims t1 in
      let (iter', _), occur = annot_iterexp `Lhs dims occur1 (iter, []) t.at in
      IterT (t1', iter'), occur
  in {t with it}, occur

and annot_typbind dims (x, t) : (id * typ) * occur =
  let occur1 =
    if x.it <> "_" && Map.mem x.it dims then
      Map.singleton x.it (t, snd (Map.find x.it dims))
    else
      Map.empty
  in
  let t', occur2 = annot_typ dims t in
  (x, t'), union occur1 occur2


and annot_exp side dims e : exp * occur =
  Il.Debug.(log "il.annot_exp"
    (fun _ -> fmt "%s" (il_exp e))
    (fun (e', occur') -> fmt "%s %s" (il_exp e') (il_occur occur'))
  ) @@ fun _ ->
  let it, occur =
    match e.it with
    | VarE x when x.it <> "_" && Map.mem x.it dims ->
      VarE x, Map.singleton x.it (e.note, snd (Map.find x.it dims))
    | VarE _ | BoolE _ | NumE _ | TextE _ ->
      e.it, Map.empty
    | UnE (op, nt, e1) ->
      let e1', occur1 = annot_exp side dims e1 in
      UnE (op, nt, e1'), occur1
    | BinE (op, nt, e1, e2) ->
      let e1', occur1 = annot_exp side dims e1 in
      let e2', occur2 = annot_exp side dims e2 in
      BinE (op, nt, e1', e2'), union occur1 occur2
    | CmpE (op, nt, e1, e2) ->
      let side' = if op = `EqOp then `Lhs else side in
      let e1', occur1 = annot_exp side' dims e1 in
      let e2', occur2 = annot_exp side' dims e2 in
      CmpE (op, nt, e1', e2'), union occur1 occur2
    | IdxE (e1, e2) ->
      let e1', occur1 = annot_exp side dims e1 in
      let e2', occur2 = annot_exp side dims e2 in
      IdxE (e1', e2'), union occur1 occur2
    | SliceE (e1, e2, e3) ->
      let e1', occur1 = annot_exp side dims e1 in
      let e2', occur2 = annot_exp side dims e2 in
      let e3', occur3 = annot_exp side dims e3 in
      SliceE (e1', e2', e3'), union (union occur1 occur2) occur3
    | UpdE (e1, p, e2) ->
      let e1', occur1 = annot_exp side dims e1 in
      let p', occur2 = annot_path dims p in
      let e2', occur3 = annot_exp side dims e2 in
      UpdE (e1', p', e2'), union (union occur1 occur2) occur3
    | ExtE (e1, p, e2) ->
      let e1', occur1 = annot_exp side dims e1 in
      let p', occur2 = annot_path dims p in
      let e2', occur3 = annot_exp side dims e2 in
      ExtE (e1', p', e2'), union (union occur1 occur2) occur3
    | StrE efs ->
      let efs', occurs = List.split (List.map (annot_expfield side dims) efs) in
      StrE efs', List.fold_left union Map.empty occurs
    | DotE (e1, atom) ->
      let e1', occur1 = annot_exp side dims e1 in
      DotE (e1', atom), occur1
    | CompE (e1, e2) ->
      let e1', occur1 = annot_exp side dims e1 in
      let e2', occur2 = annot_exp side dims e2 in
      CompE (e1', e2'), union occur1 occur2
    | LenE e1 ->
      let e1', occur1 = annot_exp side dims e1 in
      LenE e1', occur1
    | TupE es ->
      let es', occurs = List.split (List.map (annot_exp side dims) es) in
      TupE es', List.fold_left union Map.empty occurs
    | CallE (id, as1) ->
      let as1', occurs = List.split (List.map (annot_arg dims) as1) in
      CallE (id, as1'), List.fold_left union Map.empty occurs
    | IterE (e1, iter) ->
      let e1', occur1 = annot_exp side dims e1 in
      let iter', occur' = annot_iterexp side dims occur1 iter e.at in
      IterE (e1', iter'), occur'
    | ProjE (e1, i) ->
      let e1', occur1 = annot_exp side dims e1 in
      ProjE (e1', i), occur1
    | UncaseE (e1, op) ->
      let e1', occur1 = annot_exp side dims e1 in
      UncaseE (e1', op), occur1
    | OptE None ->
      OptE None, Map.empty
    | OptE (Some e1) ->
      let e1', occur1 = annot_exp side dims e1 in
      OptE (Some e1'), occur1
    | TheE e1 ->
      let e1', occur1 = annot_exp side dims e1 in
      TheE e1', occur1
    | ListE es ->
      let es', occurs = List.split (List.map (annot_exp side dims) es) in
      ListE es', List.fold_left union Map.empty occurs
    | LiftE e1 ->
      let e1', occur1 = annot_exp side dims e1 in
      LiftE e1', occur1
    | MemE (e1, e2) ->
      let e1', occur1 = annot_exp side dims e1 in
      let e2', occur2 = annot_exp side dims e2 in
      MemE (e1', e2'), union occur1 occur2
    | CatE (e1, e2) ->
      let e1', occur1 = annot_exp side dims e1 in
      let e2', occur2 = annot_exp side dims e2 in
      CatE (e1', e2'), union occur1 occur2
    | CaseE (atom, e1) ->
      let e1', occur1 = annot_exp side dims e1 in
      CaseE (atom, e1'), occur1
    | CvtE (e1, nt1, nt2) ->
      let e1', occur1 = annot_exp side dims e1 in
      CvtE (e1', nt1, nt2), occur1
    | SubE (e1, t1, t2) ->
      let e1', occur1 = annot_exp side dims e1 in
      let t1', occur2 = annot_typ dims t1 in
      let t2', occur3 = annot_typ dims t2 in
      SubE (e1', t1', t2'), union occur1 (union occur2 occur3)
  in {e with it}, occur

and annot_expfield side dims (atom, e) : expfield * occur =
  let e', occur = annot_exp side dims e in
  (atom, e'), occur

and annot_path dims p : path * occur =
  let it, occur =
    match p.it with
    | RootP -> RootP, Map.empty
    | IdxP (p1, e) ->
      let p1', occur1 = annot_path dims p1 in
      let e', occur2 = annot_exp `Rhs dims e in
      IdxP (p1', e'), union occur1 occur2
    | SliceP (p1, e1, e2) ->
      let p1', occur1 = annot_path dims p1 in
      let e1', occur2 = annot_exp `Rhs dims e1 in
      let e2', occur3 = annot_exp `Rhs dims e2 in
      SliceP (p1', e1', e2'), union occur1 (union occur2 occur3)
    | DotP (p1, atom) ->
      let p1', occur1 = annot_path dims p1 in
      DotP (p1', atom), occur1
  in {p with it}, occur

and annot_sym dims g : sym * occur =
  Il.Debug.(log_in "il.annot_sym" (fun _ -> il_sym g));
  let it, occur =
    match g.it with
    | VarG (x, as1) ->
      let as1', occurs = List.split (List.map (annot_arg dims) as1) in
      VarG (x, as1'), List.fold_left union Map.empty occurs
    | NumG _ | TextG _ | EpsG ->
      g.it, Map.empty
    | SeqG gs ->
      let gs', occurs = List.split (List.map (annot_sym dims) gs) in
      SeqG gs', List.fold_left union Map.empty occurs
    | AltG gs ->
      let gs', occurs = List.split (List.map (annot_sym dims) gs) in
      AltG gs', List.fold_left union Map.empty occurs
    | RangeG (g1, g2) ->
      let g1', occur1 = annot_sym dims g1 in
      let g2', occur2 = annot_sym dims g2 in
      RangeG (g1', g2'), union occur1 occur2
    | IterG (g1, iter) ->
      let g1', occur1 = annot_sym dims g1 in
      let iter', occur' = annot_iterexp `Lhs dims occur1 iter g.at in
      IterG (g1', iter'), occur'
    | AttrG (e1, g2) ->
      let e1', occur1 = annot_exp `Lhs dims e1 in
      let g2', occur2 = annot_sym dims g2 in
      AttrG (e1', g2'), union occur1 occur2
  in {g with it}, occur

and annot_arg dims a : arg * occur =
  let it, occur =
    match a.it with
    | ExpA e ->
      let e', occur1 = annot_exp `Rhs dims e in
      ExpA e', occur1
    | TypA t ->
      let t', occur1 = annot_typ dims t in
      TypA t', occur1
    | DefA x ->
      DefA x, Map.empty
    | GramA g ->
      let g', occur1 = annot_sym dims g in
      GramA g', occur1
  in {a with it}, occur

and annot_param dims p : param * occur =
  let it, occur =
    match p.it with
    | ExpP (x, t) ->
      let occur1 =
        if x.it <> "_" && Map.mem x.it dims then
          Map.singleton x.it (t, snd (Map.find x.it dims))
        else
          Map.empty
      in
      let t', occur2 = annot_typ dims t in
      ExpP (x, t'), union occur1 occur2
    | TypP x  ->
      TypP x, Map.empty
    | DefP (x, ps, t) ->
      let ps', occurs = List.split (List.map (annot_param dims) ps) in
      let t', occur2 = annot_typ dims t in
      DefP (x, ps', t'), List.fold_left union occur2 occurs
    | GramP (x, ps, t) ->
      let ps', occurs = List.split (List.map (annot_param dims) ps) in
      let t', occur2 = annot_typ dims t in
      GramP (x, ps', t'), List.fold_left union occur2 occurs
  in {p with it}, occur

and annot_prem dims prem : prem * occur =
  let it, occur =
    match prem.it with
    | RulePr (x, op, e) ->
      let e', occur = annot_exp `Rhs dims e in
      RulePr (x, op, e'), occur
    | IfPr e ->
      let e', occur = annot_exp `Rhs dims e in
      IfPr e', occur
    | LetPr (e1, e2, ids) ->
      let e1', occur1 = annot_exp `Lhs dims e1 in
      let e2', occur2 = annot_exp `Rhs dims e2 in
      LetPr (e1', e2', ids), union occur1 occur2
    | ElsePr ->
      ElsePr, Map.empty
    | IterPr (prem1, iter) ->
      let prem1', occur1 = annot_prem dims prem1 in
      let iter', occur' = annot_iterexp `Rhs dims occur1 iter prem.at in
      IterPr (prem1', iter'), occur'
  in {prem with it}, occur

(*
let annot_inst dims inst : inst * occur =
  let InstD (qs, as_, dt) = inst.it in
  assert (qs = []);
  let as', occurs = List.split (List.map (annot_arg dims) as_) in
  let dt', occur = dt, Map.empty in  (* assume dt was already annotated *)
  {inst with it = InstD (qs, as', dt')}, List.fold_left union occur occurs
*)


(* Top-level entry points *)

let annot_top annot_x dims x =
  let x', occurs = annot_x dims x in
  assert (Map.for_all (fun _ (_t, ctx) -> ctx = []) occurs);
  x'

let annot_iter = annot_top (annot_iter `Rhs)
let annot_typ = annot_top annot_typ
let annot_exp = annot_top (annot_exp `Rhs)
let annot_sym = annot_top annot_sym
let annot_prem = annot_top annot_prem
let annot_arg = annot_top annot_arg
let annot_param = annot_top annot_param


(* Environment manipulation *)

let union dims1 dims2 =
  Map.union (fun _ _ y -> Some y) dims1 dims2

let restrict dims bound =
  Map.filter Il.Free.(fun x _ -> Set.mem x bound.varid) dims
