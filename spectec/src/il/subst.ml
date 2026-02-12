open Util.Source
open Ast


(* Data Structure *)

module Map = Map.Make(String)

type subst =
  {varid : exp Map.t; typid : typ Map.t; defid : id Map.t; gramid : sym Map.t}
type t = subst

let empty =
  { varid = Map.empty;
    typid = Map.empty;
    defid = Map.empty;
    gramid = Map.empty;
  }

let mem_varid s x = Map.mem x.it s.varid
let mem_typid s x = Map.mem x.it s.typid
let mem_defid s x = Map.mem x.it s.defid
let mem_gramid s x = Map.mem x.it s.gramid

let find_varid s x = Map.find x.it s.varid
let find_typid s x = Map.find x.it s.typid
let find_defid s x = Map.find x.it s.defid
let find_gramid s x = Map.find x.it s.gramid

let add_varid s x e = if x.it = "_" then s else {s with varid = Map.add x.it e s.varid}
let add_typid s x t = if x.it = "_" then s else {s with typid = Map.add x.it t s.typid}
let add_defid s x x' = if x.it = "_" then s else {s with defid = Map.add x.it x' s.defid}
let add_gramid s x g = if x.it = "_" then s else {s with gramid = Map.add x.it g s.gramid}

let remove_varid s x = if x.it = "_" then s else {s with varid = Map.remove x.it s.varid}
let remove_typid s x = if x.it = "_" then s else {s with typid = Map.remove x.it s.typid}
let remove_defid s x = if x.it = "_" then s else {s with defid = Map.remove x.it s.defid}
let remove_gramid s x = if x.it = "_" then s else {s with gramid = Map.remove x.it s.gramid}

let union s1 s2 =
  { varid = Map.union (fun _ _e1 e2 -> Some e2) s1.varid s2.varid;
    typid = Map.union (fun _ _t1 t2 -> Some t2) s1.typid s2.typid;
    defid = Map.union (fun _ _x1 x2 -> Some x2) s1.defid s2.defid;
    gramid = Map.union (fun _ _g1 g2 -> Some g2) s1.gramid s2.gramid;
  }

let remove_varid' s x' = {s with varid = Map.remove x' s.varid}
let remove_varids s xs' = Free.Set.(fold (fun x' s -> remove_varid' s x') xs' s)


(* Helpers *)

let subst_opt subst_x s xo = Option.map (subst_x s) xo
let subst_list subst_x s xs = List.map (subst_x s) xs

let rec subst_list_dep subst_x bound_x s = function
  | [] -> [], s
  | x::xs ->
    let x' = subst_x s x in
    let xs', s' = subst_list_dep subst_x bound_x (remove_varids s (bound_x x).Free.varid) xs in
    x'::xs', s'


(* Identifiers *)

let subst_defid s x =
  match Map.find_opt x.it s.defid with
  | None -> x
  | Some x' -> x'

let subst_gramid s x =
  match Map.find_opt x.it s.gramid with
  | None -> x
  | Some {it = VarG (x', []); _} -> x'
  | Some _ -> raise (Invalid_argument "subst_gramid")


(* Iterations *)

let rec subst_iter s iter =
  match iter with
  | Opt | List | List1 -> iter
  | ListN (e, xo) -> ListN (subst_exp s e, xo)

and subst_iterexp : 'a. subst -> (subst -> 'a -> 'a) -> 'a -> _ -> 'a * _ =
  fun s f body (it, xes) ->
  let it', xxts1 =
    match it with
    | ListN (e, Some x) ->
      let x' = Fresh.refresh_varid x in
      ListN (e, Some x'), [(x, x', NumT `NatT $ x.at)]
    | _ -> it, []
  in
  let it'' = subst_iter s it' in
  let xes' = List.map (fun (x, e) -> Fresh.refresh_varid x, subst_exp s e) xes in
  let xxts = List.map2 (fun (x, _) (x', e') -> x, x', e'.note) xes xes' in
  let s' = 
    List.fold_left (fun s (x, x', t) ->
      add_varid s x (VarE x' $$ x'.at % t)
    ) s (xxts1 @ xxts)
  in
  f s' body,
  (it'', xes')


(* Types *)

and subst_typ s t =
  (match t.it with
  | VarT (x, as_) ->
    (match Map.find_opt x.it s.typid with
    | None -> VarT (x, subst_args s as_)
    | Some t' -> assert (as_ = []); t'.it  (* We do not support higher-order substitutions yet *)
    )
  | BoolT | NumT _ | TextT -> t.it
  | TupT xts -> TupT (fst (subst_tup_typ s xts))
  | IterT (t1, it) -> IterT (subst_typ s t1, subst_iter s it)
  ) $ t.at

and subst_typ' s t =
  match t.it with
  | TupT xts -> let xts', s' = subst_tup_typ s xts in TupT xts' $ t.at, s'
  | _ -> subst_typ s t, s

and subst_tup_typ s = function
  | [] -> [], s
  | (x, t)::xts ->
    let x' = Fresh.refresh_varid x in
    let t' = subst_typ s t in
    let s' = add_varid s x (VarE x' $$ x'.at % t') in
    let xts', s'' = subst_tup_typ s' xts in
    (x', t') :: xts', s''

and subst_deftyp s dt =
  (match dt.it with
  | AliasT t -> AliasT (subst_typ s t)
  | StructT tfs -> StructT (subst_list subst_typfield s tfs)
  | VariantT tcs -> VariantT (subst_list subst_typcase s tcs)
  ) $ dt.at

and subst_typfield s (atom, (t, qs, prems), hints) =
  let t', s' = subst_typ' s t in
  let qs', s'' = subst_quants s' qs in
  (atom, (t', qs', subst_list subst_prem s'' prems), hints)

and subst_typcase s (op, (t, qs, prems), hints) =
  let t', s' = subst_typ' s t in
  let qs', s'' = subst_quants s' qs in
  (op, (t', qs', subst_list subst_prem s'' prems), hints)


(* Expressions *)

and subst_exp s e =
  (match e.it with
  | VarE x ->
    (match Map.find_opt x.it s.varid with
    | None -> VarE x
    | Some e' -> e'.it
    )
  | BoolE _ | NumE _ | TextE _ -> e.it
  | UnE (op, ot, e1) -> UnE (op, ot, subst_exp s e1)
  | BinE (op, ot, e1, e2) -> BinE (op, ot, subst_exp s e1, subst_exp s e2)
  | CmpE (op, ot, e1, e2) -> CmpE (op, ot, subst_exp s e1, subst_exp s e2)
  | IdxE (e1, e2) -> IdxE (subst_exp s e1, subst_exp s e2)
  | SliceE (e1, e2, e3) -> SliceE (subst_exp s e1, subst_exp s e2, subst_exp s e3)
  | UpdE (e1, p, e2) -> UpdE (subst_exp s e1, subst_path s p, subst_exp s e2)
  | ExtE (e1, p, e2) -> ExtE (subst_exp s e1, subst_path s p, subst_exp s e2)
  | StrE efs -> StrE (subst_list subst_expfield s efs)
  | DotE (e1, atom) -> DotE (subst_exp s e1, atom)
  | CompE (e1, e2) -> CompE (subst_exp s e1, subst_exp s e2)
  | MemE (e1, e2) -> MemE (subst_exp s e1, subst_exp s e2)
  | LenE e1 -> LenE (subst_exp s e1)
  | TupE es -> TupE (subst_list subst_exp s es)
  | CallE (x, as_) -> CallE (subst_defid s x, subst_args s as_)
  | IterE (e1, iterexp) ->
    let e1', it' = subst_iterexp s subst_exp e1 iterexp in
    IterE (e1', it')
  | ProjE (e1, i) -> ProjE (subst_exp s e1, i)
  | UncaseE (e1, op) ->
    let e1' = subst_exp s e1 in
    assert (match e1'.note.it with VarT _ -> true | _ -> false);
    UncaseE (subst_exp s e1, op)
  | OptE eo -> OptE (subst_opt subst_exp s eo)
  | TheE e -> TheE (subst_exp s e)
  | ListE es -> ListE (subst_list subst_exp s es)
  | LiftE e -> LiftE (subst_exp s e)
  | CatE (e1, e2) -> CatE (subst_exp s e1, subst_exp s e2)
  | CaseE (op, e1) ->
    assert (match e.note.it with VarT _ -> true | _ -> false);
    CaseE (op, subst_exp s e1)
  | CvtE (e1, nt1, nt2) -> CvtE (subst_exp s e1, nt1, nt2)
  | SubE (e1, t1, t2) -> SubE (subst_exp s e1, subst_typ s t1, subst_typ s t2)
  | IfE (e1, e2, e3) -> IfE (subst_exp s e1, subst_exp s e2, subst_exp s e3)
  ) $$ e.at % subst_typ s e.note

and subst_expfield s (atom, e) = (atom, subst_exp s e)

and subst_path s p =
  (match p.it with
  | RootP -> RootP
  | IdxP (p1, e) -> IdxP (subst_path s p1, subst_exp s e)
  | SliceP (p1, e1, e2) ->
    SliceP (subst_path s p1, subst_exp s e1, subst_exp s e2)
  | DotP (p1, atom) -> DotP (subst_path s p1, atom)
  ) $$ p.at % subst_typ s p.note


(* Grammars *)

and subst_sym s g =
  (match g.it with
  | VarG (x, []) ->
    (match Map.find_opt x.it s.gramid with
    | None -> VarG (x, [])
    | Some g' -> g'.it
    )
  | VarG (x, args) -> VarG (subst_gramid s x, List.map (subst_arg s) args)
  | NumG _ | TextG _ -> g.it
  | EpsG -> EpsG
  | SeqG gs -> SeqG (subst_list subst_sym s gs)
  | AltG gs -> AltG (subst_list subst_sym s gs)
  | RangeG (g1, g2) -> RangeG (subst_sym s g1, subst_sym s g2)
  | IterG (g1, iterexp) ->
    let g1', it' = subst_iterexp s subst_sym g1 iterexp in
    IterG (g1', it')
  | AttrG (e, g1) -> AttrG (subst_exp s e, subst_sym s g1)
  ) $ g.at


(* Premises *)

and subst_prem s prem =
  (match prem.it with
  | RulePr (x, as_, op, e) -> RulePr (x, subst_args s as_, op, subst_exp s e)
  | IfPr e -> IfPr (subst_exp s e)
  | ElsePr -> ElsePr
  | IterPr (prem1, iterexp) ->
    let prem1', it' = subst_iterexp s subst_prem prem1 iterexp in
    IterPr (prem1', it')
  | LetPr (e1, e2, xs) -> LetPr (subst_exp s e1, subst_exp s e2, xs)
  | NegPr prem1 -> NegPr (subst_prem s prem1)
  ) $ prem.at


(* Definitions *)

and subst_arg s a =
  (match a.it with
  | ExpA e -> ExpA (subst_exp s e)
  | TypA t -> TypA (subst_typ s t)
  | DefA x -> DefA (subst_defid s x)
  | GramA g -> GramA (subst_sym s g)
  ) $ a.at

and subst_param s p =
  (match p.it with
  | ExpP (x, t) -> ExpP (x, subst_typ s t)
  | TypP x -> TypP x
  | DefP (x, ps, t) ->
    let ps', s' = subst_params s ps in
    DefP (x, ps', subst_typ s' t)
  | GramP (x, ps, t) ->
    let ps', s' = subst_params s ps in
    GramP (x, ps', subst_typ s' t)
  ) $ p.at

and subst_args s as_ = subst_list subst_arg s as_
and subst_params s ps = subst_list_dep subst_param Free.bound_param s ps
and subst_quants s ps = subst_list_dep subst_param Free.bound_quant s ps


(* Optimizations *)

let subst_typ s t = if s = empty then t else subst_typ s t
let subst_deftyp s dt = if s = empty then dt else subst_deftyp s dt
let subst_exp s e = if s = empty then e else subst_exp s e
let subst_sym s g = if s = empty then g else subst_sym s g
let subst_prem s pr = if s = empty then pr else subst_prem s pr
