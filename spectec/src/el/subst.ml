open Util.Source
open Ast


(* Data Structure *)

module Map = Map.Make(String)

type subst =
  { varid : exp Map.t;
    typid : typ Map.t;
    gramid : sym Map.t;
    defid : id Map.t;
    unop : unop Map.t;
  }

type t = subst

let empty =
  { varid = Map.empty;
    typid = Map.empty;
    gramid = Map.empty;
    defid = Map.empty;
    unop = Map.empty;
  }

let mem_varid s id = Map.mem id.it s.varid
let mem_typid s id = Map.mem id.it s.typid
let mem_gramid s id = Map.mem id.it s.gramid
let mem_defid s id = Map.mem id.it s.defid
let mem_unop s op = Map.mem (Print.string_of_unop op) s.unop

let add_varid s id e = if id.it = "_" then s else {s with varid = Map.add id.it e s.varid}
let add_typid s id t = if id.it = "_" then s else {s with typid = Map.add id.it t s.typid}
let add_gramid s id g = if id.it = "_" then s else {s with gramid = Map.add id.it g s.gramid}
let add_defid s id id' = if id.it = "_" then s else {s with defid = Map.add id.it id' s.defid}
let add_unop s op op' = {s with unop = Map.add (Print.string_of_unop op) op' s.unop}

let union s1 s2 =
  { varid = Map.union (fun _ _e1 e2 -> Some e2) s1.varid s2.varid;
    typid = Map.union (fun _ _t1 t2 -> Some t2) s1.typid s2.typid;
    gramid = Map.union (fun _ _g1 g2 -> Some g2) s1.gramid s2.gramid;
    defid = Map.union (fun _ _id1 id2 -> Some id2) s1.defid s2.defid;
    unop = Map.union (fun _ _op1 op2 -> Some op2) s1.unop s2.unop;
  }

let pm_fst = add_unop (add_unop empty `PlusMinusOp `PlusOp) `MinusPlusOp `MinusOp
let pm_snd = add_unop (add_unop empty `PlusMinusOp `MinusOp) `MinusPlusOp `PlusOp


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

let subst_defid s id =
  match Map.find_opt id.it s.defid with
  | None -> id
  | Some id' -> id'


(* Iterations *)

let rec subst_iter s iter =
  match iter with
  | Opt | List | List1 -> iter
  | ListN (e, id_opt) -> ListN (subst_exp s e, subst_opt subst_varid s id_opt)


(* Types *)

and subst_typ s t =
  (match t.it with
  | VarT (id, args) ->
    let id' = Convert.strip_var_suffix id in
    (match Map.find_opt id'.it s.typid with
    | None -> VarT (id, List.map (subst_arg s) args)
    | Some t' ->
      if id'.it <> id.it then
        Util.Error.error id.at "syntax" "identifer suffix encountered during substitution";
      assert (args = []); t'.it  (* We do not support higher-order substitutions yet *)
    )
  | BoolT | NumT _ | TextT | AtomT _ -> t.it
  | ParenT t1 -> ParenT (subst_typ s t1)
  | TupT ts -> TupT (subst_list subst_typ s ts)
  | IterT (t1, iter) -> IterT (subst_typ s t1, subst_iter s iter)
  | StrT tfs -> StrT (subst_nl_list subst_typfield s tfs)
  | CaseT (dots1, ts, tcs, dots2) ->
    CaseT (dots1, subst_nl_list subst_typ s ts,
      subst_nl_list subst_typcase s tcs, dots2)
  | ConT tc -> ConT (subst_typcon s tc)
  | RangeT tes -> RangeT (subst_nl_list subst_typenum s tes)
  | SeqT ts -> SeqT (subst_list subst_typ s ts)
  | InfixT (t1, op, t2) -> InfixT (subst_typ s t1, op, subst_typ s t2)
  | BrackT (l, t1, r) -> BrackT (l, subst_typ s t1, r)
  ) $ t.at

and subst_typfield s (atom, (t, prems), hints) =
  (atom, (subst_typ s t, subst_nl_list subst_prem s prems), hints)
and subst_typcase s (atom, (t, prems), hints) =
  (atom, (subst_typ s t, subst_nl_list subst_prem s prems), hints)
and subst_typcon s ((t, prems), hints) =
  ((subst_typ s t, subst_nl_list subst_prem s prems), hints)
and subst_typenum s (e, eo) =
  (subst_exp s e, subst_opt subst_exp s eo)


(* Expressions *)

and subst_unop s = function
  | #signop as op ->
    (match Map.find_opt (Print.string_of_unop op) s.unop with
    | Some op' -> op'
    | None -> op
    )
  | op -> op

and subst_exp s e =
  (match e.it with
  | VarE (id, args) ->
    (match Map.find_opt id.it s.varid with
    | None -> VarE (id, List.map (subst_arg s) args)
    | Some e' -> assert (args = []); e'.it  (* We do not support higher-order substitutions yet *)
    )
  | AtomE _ | BoolE _ | NumE _ | TextE _ -> e.it
  | CvtE (e1, nt) -> CvtE (subst_exp s e1, nt)
  | UnE (op, e1) -> UnE (subst_unop s op, subst_exp s e1)
  | BinE (e1, op, e2) -> BinE (subst_exp s e1, op, subst_exp s e2)
  | CmpE (e1, op, e2) -> CmpE (subst_exp s e1, op, subst_exp s e2)
  | EpsE -> EpsE
  | SeqE es -> SeqE (subst_list subst_exp s es)
  | ListE es -> ListE (subst_list subst_exp s es)
  | IdxE (e1, e2) -> IdxE (subst_exp s e1, subst_exp s e2)
  | SliceE (e1, e2, e3) -> SliceE (subst_exp s e1, subst_exp s e2, subst_exp s e3)
  | UpdE (e1, p, e2) -> UpdE (subst_exp s e1, subst_path s p, subst_exp s e2)
  | ExtE (e1, p, e2) -> ExtE (subst_exp s e1, subst_path s p, subst_exp s e2)
  | StrE efs -> StrE (subst_nl_list subst_expfield s efs)
  | DotE (e1, atom) -> DotE (subst_exp s e1, atom)
  | CommaE (e1, e2) -> CommaE (subst_exp s e1, subst_exp s e2)
  | CatE (e1, e2) -> CatE (subst_exp s e1, subst_exp s e2)
  | MemE (e1, e2) -> MemE (subst_exp s e1, subst_exp s e2)
  | LenE e1 -> LenE (subst_exp s e1)
  | SizeE id -> SizeE (subst_gramid s id)
  | ParenE e1 -> ParenE (subst_exp s e1)
  | TupE es -> TupE (subst_list subst_exp s es)
  | InfixE (e1, atom, e2) -> InfixE (subst_exp s e1, atom, subst_exp s e2)
  | BrackE (l, e1, r) -> BrackE (l, subst_exp s e1, r)
  | CallE (id, args) -> CallE (subst_defid s id, subst_list subst_arg s args)
  | IterE (e1, iter) -> IterE (subst_exp s e1, subst_iter s iter)
  | TypE (e1, t) -> TypE (subst_exp s e1, subst_typ s t)
  | ArithE e1 -> ArithE (subst_exp s e1)
  | HoleE h -> HoleE h
  | FuseE (e1, e2) -> FuseE (subst_exp s e1, subst_exp s e2)
  | UnparenE e1 -> UnparenE (subst_exp s e1)
  | LatexE s -> LatexE s
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


(* Grammars *)

and subst_sym s g =
  (match g.it with
  | VarG (id, args) ->
    (match Map.find_opt id.it s.gramid with
    | None -> VarG (id, List.map (subst_arg s) args)
    | Some g' -> assert (args = []); g'.it (* We do not support higher-order substitutions yet *)
    )
  | NumG _ | TextG _ -> g.it
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
  | UnparenG g1 -> UnparenG (subst_sym s g1)
  ) $ g.at

and subst_prod s prod =
  (match prod.it with
  | SynthP (g, e, prems) ->
    SynthP (subst_sym s g, subst_exp s e, subst_nl_list subst_prem s prems)
  | RangeP (g1, e1, g2, e2) ->
    RangeP (subst_sym s g1, subst_exp s e1, subst_sym s g2, subst_exp s e2)
  | EquivP (g1, g2, prems) ->
    EquivP (subst_sym s g1, subst_sym s g2, subst_nl_list subst_prem s prems)
  ) $ prod.at

and subst_gram s gram =
  let (dots1, prods, dots2) = gram.it in
  (dots1, subst_nl_list subst_prod s prods, dots2) $ gram.at


(* Premises *)

and subst_prem s prem =
  (match prem.it with
  | VarPr (id, t) -> VarPr (id, subst_typ s t)
  | RulePr (id, e) -> RulePr (id, subst_exp s e)
  | IfPr e -> IfPr (subst_exp s e)
  | ElsePr -> ElsePr
  | IterPr (prem1, iter) -> IterPr (subst_prem s prem1, subst_iter s iter)
  ) $ prem.at


(* Definitions *)

and subst_arg s a =
  ref
  (match !(a.it) with
  | ExpA e -> ExpA (subst_exp s e)
  | TypA t -> TypA (subst_typ s t)
  | GramA g -> GramA (subst_sym s g)
  | DefA id -> DefA (subst_defid s id)
  ) $ a.at

and subst_param s p =
  (match p.it with
  | ExpP (id, t) -> ExpP (id, subst_typ s t)
  | TypP id -> TypP id
  | GramP (id, t) -> GramP (id, subst_typ s t)
  | DefP (id, ps, t) -> DefP (id, List.map (subst_param s) ps, subst_typ s t)
  ) $ p.at

let subst_def s d =
  (match d.it with
  | FamD (x, ps, hs) -> FamD (x, List.map (subst_param s) ps, hs)
  | TypD (x1, x2, as_, t, hs) -> TypD (x1, x2, List.map (subst_arg s) as_, subst_typ s t, hs)
  | GramD (x1, x2, ps, t, gr, hs) -> GramD (x1, x2, List.map (subst_param s) ps, subst_typ s t, subst_gram s gr, hs)
  | VarD (x, t, hs) -> VarD (x, subst_typ s t, hs)
  | SepD -> SepD
  | RelD (x, t, hs) -> RelD (x, subst_typ s t, hs)
  | RuleD (x1, x2, e, prs) -> RuleD (x1, x2, subst_exp s e, Convert.map_nl_list (subst_prem s) prs)
  | DecD (x, ps, t, hs) -> DecD (x, List.map (subst_param s) ps, subst_typ s t, hs)
  | DefD (x, as_, e, prs) -> DefD (x, List.map (subst_arg s) as_, subst_exp s e, Convert.map_nl_list (subst_prem s) prs)
  | HintD hd -> HintD hd
  ) $ d.at
