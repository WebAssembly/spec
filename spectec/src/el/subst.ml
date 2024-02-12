open Util.Source
open Ast


(* Data Structure *)

module Map = Map.Make(String)

type subst =
  { varid : exp Map.t;
    typid : typ Map.t;
    gramid : sym Map.t;
  }

type t = subst

let empty =
  { varid = Map.empty;
    typid = Map.empty;
    gramid = Map.empty;
  }

let mem_varid s id = Map.mem id.it s.varid
let mem_typid s id = Map.mem id.it s.typid
let mem_gramid s id = Map.mem id.it s.gramid

let add_varid s id e = if id.it = "_" then s else {s with varid = Map.add id.it e s.varid}
let add_typid s id t = if id.it = "_" then s else {s with typid = Map.add id.it t s.typid}
let add_gramid s id g = if id.it = "_" then s else {s with gramid = Map.add id.it g s.gramid}

let union s1 s2 =
  { varid = Map.union (fun _ _e1 e2 -> Some e2) s1.varid s2.varid;
    typid = Map.union (fun _ _t1 t2 -> Some t2) s1.typid s2.typid;
    gramid = Map.union (fun _ _g1 g2 -> Some g2) s1.gramid s2.gramid;
  }


(* Helpers *)

let subst_opt subst_x s xo = Option.map (subst_x s) xo
let subst_list subst_x s xs = List.map (subst_x s) xs

let subst_nl_elem subst_x s = function Nl -> Nl | Elem x -> Elem (subst_x s x)
let subst_nl_list subst_x s xs = List.map (subst_nl_elem subst_x s) xs


(* Identifiers *)

let subst_varid s id =
  match Map.find_opt id.it s.varid with
  | None -> id
  | Some {it = VarE (id', []); _} -> id'
  | Some _ -> raise (Invalid_argument "subst_varid")

let subst_gramid s id =
  match Map.find_opt id.it s.gramid with
  | None -> id
  | Some {it = VarG (id', []); _} -> id'
  | Some _ -> raise (Invalid_argument "subst_gramid")


(* Iterations *)

let rec subst_iter s iter =
  match iter with
  | Opt | List | List1 -> iter
  | ListN (e, id_opt) -> ListN (subst_exp s e, subst_opt subst_varid s id_opt)


(* Types *)

and subst_typ s t =
  (match t.it with
  | VarT (id, args) ->
    if id.it <> (Convert.strip_var_suffix id).it then
      Util.Source.error id.at "syntax" "identifer suffix encountered during substitution";
    (match Map.find_opt id.it s.typid with
    | None -> VarT (id, List.map (subst_arg s) args)
    | Some t' -> assert (args = []); t'.it  (* We do not support higher-order substitutions yet *)
    )
  | BoolT | NumT _ | TextT | AtomT _ -> t.it
  | ParenT t1 -> ParenT (subst_typ s t1)
  | TupT ts -> TupT (subst_list subst_typ s ts)
  | IterT (t1, iter) -> IterT (subst_typ s t1, subst_iter s iter)
  | StrT tfs -> StrT (subst_nl_list subst_typfield s tfs)
  | CaseT (dots1, ts, tcs, dots2) ->
    CaseT (dots1, subst_nl_list subst_typ s ts,
      subst_nl_list subst_typcase s tcs, dots2)
  | RangeT tes -> RangeT (subst_nl_list subst_typenum s tes)
  | SeqT ts -> SeqT (subst_list subst_typ s ts)
  | InfixT (t1, op, t2) -> InfixT (subst_typ s t1, op, subst_typ s t2)
  | BrackT (l, t1, r) -> BrackT (l, subst_typ s t1, r)
  ) $ t.at

and subst_typfield s (atom, (t, prems), hints) =
  (atom, (subst_typ s t, subst_nl_list subst_prem s prems), hints)
and subst_typcase s (atom, (t, prems), hints) =
  (atom, (subst_typ s t, subst_nl_list subst_prem s prems), hints)
and subst_typenum s (e, eo) =
  (subst_exp s e, subst_opt subst_exp s eo)


(* Expressions *)

and subst_exp s e =
  (match e.it with
  | VarE (id, args) ->
    (match Map.find_opt id.it s.varid with
    | None -> VarE (id, List.map (subst_arg s) args)
    | Some e' -> assert (args = []); e'.it  (* We do not support higher-order substitutions yet *)
    )
  | AtomE _ | BoolE _ | NatE _ | TextE _ -> e.it
  | UnE (op, e1) -> UnE (op, subst_exp s e1)
  | BinE (e1, op, e2) -> BinE (subst_exp s e1, op, subst_exp s e2)
  | CmpE (e1, op, e2) -> CmpE (subst_exp s e1, op, subst_exp s e2)
  | EpsE -> EpsE
  | SeqE es -> SeqE (subst_list subst_exp s es)
  | IdxE (e1, e2) -> IdxE (subst_exp s e1, subst_exp s e2)
  | SliceE (e1, e2, e3) -> SliceE (subst_exp s e1, subst_exp s e2, subst_exp s e3)
  | UpdE (e1, p, e2) -> UpdE (subst_exp s e1, subst_path s p, subst_exp s e2)
  | ExtE (e1, p, e2) -> ExtE (subst_exp s e1, subst_path s p, subst_exp s e2)
  | StrE efs -> StrE (subst_nl_list subst_expfield s efs)
  | DotE (e1, atom) -> DotE (subst_exp s e1, atom)
  | CommaE (e1, e2) -> CommaE (subst_exp s e1, subst_exp s e2)
  | CompE (e1, e2) -> CompE (subst_exp s e1, subst_exp s e2)
  | LenE e1 -> LenE (subst_exp s e1)
  | SizeE id -> SizeE (subst_gramid s id)
  | ParenE (e1, b) -> ParenE (subst_exp s e1, b)
  | TupE es -> TupE (subst_list subst_exp s es)
  | InfixE (e1, atom, e2) -> InfixE (subst_exp s e1, atom, subst_exp s e2)
  | BrackE (l, e1, r) -> BrackE (l, subst_exp s e1, r)
  | CallE (id, args) -> CallE (id, subst_list subst_arg s args)
  | IterE (e1, iter) -> IterE (subst_exp s e1, subst_iter s iter)
  | TypE (e1, t) -> TypE (subst_exp s e1, subst_typ s t)
  | HoleE h -> HoleE h
  | FuseE (e1, e2) -> FuseE (subst_exp s e1, subst_exp s e2)
  ) $ e.at

and subst_expfield s (atom, e) = (atom, subst_exp s e)

and subst_path s p =
  (match p.it with
  | RootP -> RootP
  | IdxP (p1, e) -> IdxP (subst_path s p1, subst_exp s e)
  | SliceP (p1, e1, e2) ->
    SliceP (subst_path s p1, subst_exp s e1, subst_exp s e2)
  | DotP (p1, atom) -> DotP (subst_path s p1, atom)
  ) $ p.at


(* Premises *)

and subst_prem s prem =
  (match prem.it with
  | VarPr (id, t) -> VarPr (id, subst_typ s t)
  | RulePr (id, e) -> RulePr (id, subst_exp s e)
  | IfPr e -> IfPr (subst_exp s e)
  | ElsePr -> ElsePr
  | IterPr (prem1, iter) -> IterPr (subst_prem s prem1, subst_iter s iter)
  ) $ prem.at


(* Grammars *)

and subst_sym s g =
  (match g.it with
  | VarG (id, args) ->
    (match Map.find_opt id.it s.gramid with
    | None -> VarG (id, List.map (subst_arg s) args)
    | Some g' -> assert (args = []); g'.it (* We do not support higher-order substitutions yet *)
    )
  | NatG _ | TextG _ -> g.it
  | EpsG -> EpsG
  | SeqG gs -> SeqG (subst_nl_list subst_sym s gs)
  | AltG gs -> AltG (subst_nl_list subst_sym s gs)
  | RangeG (g1, g2) -> RangeG (subst_sym s g1, subst_sym s g2)
  | ParenG g1 -> ParenG (subst_sym s g1)
  | TupG gs -> TupG (subst_list subst_sym s gs)
  | IterG (g1, iter) -> IterG (subst_sym s g1, subst_iter s iter)
  | ArithG e -> ArithG (subst_exp s e)
  | AttrG (e, g1) -> AttrG (subst_exp s e, subst_sym s g1)
  | FuseG (g1, g2) -> FuseG (subst_sym s g1, subst_sym s g2)
  ) $ g.at

(*
and subst_prod s prod =
  let (g, e, prems) = prod.it in
  (subst_sym s g, subst_exp s e, subst_nl_list subst_prem s prems) $ prod.at

and subst_gram s gram =
  let (dots1, prods, dots2) = gram.it in
  (dots1, subst_nl_list subst_prod s prods, dots2) $ gram.at
*)


(* Definitions *)

and subst_arg s a =
  ref
  (match !(a.it) with
  | ExpA e -> ExpA (subst_exp s e)
  | TypA t -> TypA (subst_typ s t)
  | GramA g -> GramA (subst_sym s g)
  ) $ a.at

and subst_param s p =
  (match p.it with
  | ExpP (id, t) -> ExpP (id, subst_typ s t)
  | TypP id -> TypP id
  | GramP (id, t) -> GramP (id, subst_typ s t)
  ) $ p.at
