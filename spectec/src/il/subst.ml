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

let mem_varid s id = Map.mem id.it s.varid
let mem_typid s id = Map.mem id.it s.typid
let mem_defid s id = Map.mem id.it s.defid
let mem_gramid s id = Map.mem id.it s.gramid

let find_varid s id = Map.find id.it s.varid
let find_typid s id = Map.find id.it s.typid
let find_defid s id = Map.find id.it s.defid
let find_gramid s id = Map.find id.it s.gramid

let add_varid s id e = if id.it = "_" then s else {s with varid = Map.add id.it e s.varid}
let add_typid s id t = if id.it = "_" then s else {s with typid = Map.add id.it t s.typid}
let add_defid s id x = if id.it = "_" then s else {s with defid = Map.add id.it x s.defid}
let add_gramid s id g = if id.it = "_" then s else {s with gramid = Map.add id.it g s.gramid}

let remove_varid s id = if id.it = "_" then s else {s with varid = Map.remove id.it s.varid}
let remove_typid s id = if id.it = "_" then s else {s with typid = Map.remove id.it s.typid}
let remove_defid s id = if id.it = "_" then s else {s with defid = Map.remove id.it s.defid}
let remove_gramid s id = if id.it = "_" then s else {s with gramid = Map.remove id.it s.gramid}

let union s1 s2 =
  { varid = Map.union (fun _ _e1 e2 -> Some e2) s1.varid s2.varid;
    typid = Map.union (fun _ _t1 t2 -> Some t2) s1.typid s2.typid;
    defid = Map.union (fun _ _x1 x2 -> Some x2) s1.defid s2.defid;
    gramid = Map.union (fun _ _x1 x2 -> Some x2) s1.gramid s2.gramid;
  }

let remove_varid' s id' = {s with varid = Map.remove id' s.varid}
let remove_varids s ids' =
  Free.Set.(fold (fun id' s -> remove_varid' s id') ids' s)


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

let subst_varid s id =
  match Map.find_opt id.it s.varid with
  | None -> id
  | Some {it = VarE id'; _} -> id'
  | Some _ -> raise (Invalid_argument "subst_varid")

let subst_defid s id =
  match Map.find_opt id.it s.defid with
  | None -> id
  | Some id' -> id'

let subst_gramid s id =
  match Map.find_opt id.it s.gramid with
  | None -> id
  | Some {it = VarG (id', []); _} -> id'
  | Some _ -> raise (Invalid_argument "subst_varid")


(* Iterations *)

let rec subst_iter s iter =
  match iter with
  | Opt | List | List1 -> iter, s
  | ListN (e, id_opt) ->
    ListN (subst_exp s e, subst_opt subst_varid s id_opt),
    Option.fold id_opt ~none:s ~some:(remove_varid s)


(* Types *)

and subst_typ s t =
  (match t.it with
  | VarT (id, as_) ->
    (match Map.find_opt id.it s.typid with
    | None -> VarT (id, subst_args s as_)
    | Some t' -> assert (as_ = []); t'.it  (* We do not support higher-order substitutions yet *)
    )
  | BoolT | NumT _ | TextT -> t.it
  | TupT ets -> TupT (fst (subst_list_dep subst_typbind Free.bound_typbind s ets))
  | IterT (t1, iter) ->
    let iter', s' = subst_iter s iter in
    IterT (subst_typ s' t1, iter')
  ) $ t.at

and subst_typbind s (e, t) =
  (e, subst_typ s t)

and subst_deftyp s dt =
  (match dt.it with
  | AliasT t -> AliasT (subst_typ s t)
  | StructT tfs -> StructT (subst_list subst_typfield s tfs)
  | VariantT tcs -> VariantT (subst_list subst_typcase s tcs)
  ) $ dt.at

and subst_typfield s (atom, (bs, t, prems), hints) =
  let bs', s' = subst_binds s bs in
  (atom, (bs', subst_typ s' t, subst_list subst_prem s' prems), hints)

and subst_typcase s (op, (bs, t, prems), hints) =
  let bs', s' = subst_binds s bs in
  (op, (bs', subst_typ s' t, subst_list subst_prem s' prems), hints)


(* Expressions *)

and subst_exp s e =
  (match e.it with
  | VarE id ->
    (match Map.find_opt id.it s.varid with
    | None -> VarE id
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
  | CallE (id, as_) -> CallE (subst_defid s id, subst_args s as_)
  | IterE (e1, iterexp) ->
    let it', s' = subst_iterexp s iterexp in
    IterE (subst_exp s' e1, it')
  | ProjE (e1, i) -> ProjE (subst_exp s e1, i)
  | UncaseE (e1, op) -> UncaseE (subst_exp s e1, op)
  | OptE eo -> OptE (subst_opt subst_exp s eo)
  | TheE e -> TheE (subst_exp s e)
  | ListE es -> ListE (subst_list subst_exp s es)
  | CatE (e1, e2) -> CatE (subst_exp s e1, subst_exp s e2)
  | CaseE (op, e1) -> CaseE (op, subst_exp s e1)
  | CvtE (e1, nt1, nt2) -> CvtE (subst_exp s e1, nt1, nt2)
  | SubE (e1, t1, t2) -> SubE (subst_exp s e1, subst_typ s t1, subst_typ s t2)
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

and subst_iterexp s (iter, xes) =
  (* TODO(3, rossberg): This is assuming expressions in s are closed, is that okay? *)
  let iter', s' = subst_iter s iter in
  (iter', List.map (fun (id, e) -> (id, subst_exp s e)) xes),
  List.fold_left remove_varid s' (List.map fst xes)


(* Grammars *)

and subst_sym s g =
  (match g.it with
  | VarG (id, args) -> VarG (subst_gramid s id, List.map (subst_arg s) args)
  | NumG _ | TextG _ -> g.it
  | EpsG -> EpsG
  | SeqG gs -> SeqG (subst_list subst_sym s gs)
  | AltG gs -> AltG (subst_list subst_sym s gs)
  | RangeG (g1, g2) -> RangeG (subst_sym s g1, subst_sym s g2)
  | IterG (g1, iterexp) ->
    let it', s' = subst_iterexp s iterexp in
    IterG (subst_sym s' g1, it')
  | AttrG (e, g1) -> AttrG (subst_exp s e, subst_sym s g1)
  ) $ g.at


(* Premises *)

and subst_prem s prem =
  (match prem.it with
  | RulePr (id, op, e) -> RulePr (id, op, subst_exp s e)
  | IfPr e -> IfPr (subst_exp s e)
  | ElsePr -> ElsePr
  | IterPr (prem1, iterexp) ->
    let it', s' = subst_iterexp s iterexp in
    IterPr (subst_prem s' prem1, it')
  | LetPr (e1, e2, ids) -> LetPr (subst_exp s e1, subst_exp s e2, ids)
  ) $ prem.at


(* Definitions *)

and subst_arg s a =
  (match a.it with
  | ExpA e -> ExpA (subst_exp s e)
  | TypA t -> TypA (subst_typ s t)
  | DefA id -> DefA (subst_defid s id)
  | GramA g -> GramA (subst_sym s g)
  ) $ a.at

and subst_bind s b =
  (match b.it with
  | ExpB (id, t) -> ExpB (id, subst_typ s t)
  | TypB id -> TypB id
  | DefB (id, ps, t) ->
    let ps', s' = subst_params s ps in
    DefB (id, ps', subst_typ s' t)
  | GramB (id, ps, t) ->
    let ps', s' = subst_params s ps in
    GramB (id, ps', subst_typ s' t)
  ) $ b.at

and subst_param s p =
  (match p.it with
  | ExpP (id, t) -> ExpP (id, subst_typ s t)
  | TypP id -> TypP id
  | DefP (id, ps, t) ->
    let ps', s' = subst_params s ps in
    DefP (id, ps', subst_typ s' t)
  | GramP (id, t) -> GramP (id, subst_typ s t)
  ) $ p.at

and subst_args s as_ = subst_list subst_arg s as_
and subst_binds s bs = subst_list_dep subst_bind Free.bound_bind s bs
and subst_params s ps = subst_list_dep subst_param Free.bound_param s ps


(* Optimizations *)

let subst_typ s t = if s = empty then t else subst_typ s t
let subst_deftyp s dt = if s = empty then dt else subst_deftyp s dt
let subst_exp s e = if s = empty then e else subst_exp s e
let subst_sym s g = if s = empty then g else subst_sym s g
let subst_prem s pr = if s = empty then pr else subst_prem s pr
