open Util
open Source
open Ast
open Xl

module type Arg =
sig
  val visit_atom : atom -> unit
  val visit_typid : id -> unit
  val visit_gramid : id -> unit
  val visit_relid : id -> unit
  val visit_ruleid : id -> unit
  val visit_varid : id -> unit
  val visit_defid : id -> unit

  val visit_typ : typ -> unit
  val visit_exp : exp -> unit
  val visit_path : path -> unit
  val visit_prem : prem -> unit
  val visit_sym : sym -> unit
  val visit_def : def -> unit

  val visit_hint : hint -> unit
end

module Skip =
struct
  let visit_atom _ = ()
  let visit_typid _ = ()
  let visit_gramid _ = ()
  let visit_relid _ = ()
  let visit_ruleid _ = ()
  let visit_varid _ = ()
  let visit_defid _ = ()

  let visit_typ _ = ()
  let visit_exp _ = ()
  let visit_path _ = ()
  let visit_prem _ = ()
  let visit_sym _ = ()
  let visit_def _ = ()

  let visit_hint _ = ()
end


module Make(X : Arg) =
struct
open X

let opt = Option.iter
let list = List.iter

let nl_elem f = function Nl -> () | Elem x -> f x
let nl_list f = list (nl_elem f)


(* Identifiers, operators, literals *)

let bool _b = ()
let num _n = ()
let text _s = ()

let atom at = visit_atom at
let typid x = visit_typid x
let gramid x = visit_gramid x
let relid x = visit_relid x
let ruleid x = visit_ruleid x
let varid x = visit_varid x
let defid x = visit_defid x

let natop _op = ()
let unop _op = ()
let binop _op = ()
let cmpop _op = ()

let hint h = visit_hint h
let hints = list hint


(* Iterations *)

let rec iter it =
  match it with
  | Opt | List | List1 -> ()
  | ListN (e, xo) -> exp e; opt varid xo


(* Types *)

and dots _ = ()
and numtyp _t = ()

and typ t =
  visit_typ t;
  match t.it with
  | VarT (x, as_) -> typid x; args as_
  | BoolT | TextT -> ()
  | NumT nt -> numtyp nt
  | ParenT t1 -> typ t1
  | TupT ts -> list typ ts
  | IterT (t1, it) -> typ t1; iter it
  | StrT (dots1, ts, tfs, dots2) ->
    dots dots1; nl_list typ ts; nl_list typfield tfs; dots dots2
  | CaseT (dots1, ts, tcs, dots2) ->
    dots dots1; nl_list typ ts; nl_list typcase tcs; dots dots2
  | ConT tc -> typcon tc
  | RangeT tes -> nl_list typenum tes
  | AtomT at -> atom at
  | SeqT ts -> list typ ts
  | InfixT (t1, at, t2) -> typ t1; atom at; typ t2
  | BrackT (at1, t1, at2) -> atom at1; typ t1; atom at2

and typfield (at, (t, prs), hs) = atom at; typ t; prems prs; hints hs
and typcase (at, (t, prs), hs) = atom at; typ t; prems prs; hints hs
and typcon ((t, prs), hs) = typ t; prems prs; hints hs
and typenum (e, eo) = exp e; opt exp eo


(* Expressions *)

and exp e =
  visit_exp e;
  match e.it with
  | VarE (x, as_) -> varid x; args as_
  | BoolE b -> bool b
  | NumE (op, n) -> natop op; num n
  | TextE s -> text s
  | EpsE | HoleE _ | LatexE _ -> ()
  | CvtE (e1, nt) -> exp e1; numtyp nt
  | UnE (op, e1) -> unop op; exp e1
  | LenE e1 | ArithE e1 | ParenE e1 | UnparenE e1 -> exp e1
  | DotE (e1, at) -> exp e1; atom at
  | SizeE x -> gramid x
  | BinE (e1, op, e2) -> exp e1; binop op; exp e2
  | CmpE (e1, op, e2) -> exp e1; cmpop op; exp e2
  | IdxE (e1, e2) | CommaE (e1, e2) | CatE (e1, e2) | MemE (e1, e2)
  | FuseE (e1, e2) -> exp e1; exp e2
  | SliceE (e1, e2, e3) -> exp e1; exp e2; exp e3
  | SeqE es | ListE es | TupE es -> list exp es
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) -> exp e1; path p; exp e2
  | StrE efs -> nl_list expfield efs
  | CallE (x, as_) -> defid x; args as_
  | IterE (e1, it) -> exp e1; iter it
  | TypE (e1, t) -> exp e1; typ t
  | AtomE at -> atom at
  | InfixE (e1, at1, e2) -> exp e1; atom at1; exp e2
  | BrackE (at1, e1, at2) -> atom at1; exp e1; atom at2

and expfield (at, e) = atom at; exp e

and path p =
  visit_path p;
  match p.it with
  | RootP -> ()
  | IdxP (p1, e) -> path p1; exp e
  | SliceP (p1, e1, e2) -> path p1; exp e1; exp e2
  | DotP (p1, at) -> path p1; atom at


(* Premises *)

and prem pr =
  visit_prem pr;
  match pr.it with
  | VarPr (x, t) -> varid x; typ t
  | RulePr (x, e) -> relid x; exp e
  | IfPr e -> exp e
  | ElsePr -> ()
  | IterPr (pr1, it) -> prem pr1; iter it

and prems prs = nl_list prem prs


(* Grammars *)

and sym g =
  visit_sym g;
  match g.it with
  | VarG (x, as_) -> gramid x; args as_
  | NumG (op, n) -> natop op; num (`Nat n)
  | TextG s -> text s
  | EpsG -> ()
  | SeqG gs | AltG gs -> nl_list sym gs
  | RangeG (g1, g2) | FuseG (g1, g2) -> sym g1; sym g2
  | ParenG g1 | UnparenG g1 -> sym g1
  | TupG gs -> list sym gs
  | IterG (g1, it) -> sym g1; iter it
  | ArithG e -> exp e
  | AttrG (e, g1) -> exp e; sym g1

and prod pr =
  match pr.it with
  | SynthP (g, e, prs) -> sym g; exp e; prems prs
  | RangeP (g1, e1, g2, e2) -> sym g1; exp e1; sym g2; exp e2
  | EquivP (g1, g2, prs) -> sym g1; sym g2; prems prs

and gram gr =
  let (dots1, prs, dots2) = gr.it in
  dots dots1; nl_list prod prs; dots dots2


(* Definitions *)

and arg a =
  match !(a.it) with
  | ExpA e -> exp e
  | TypA t -> typ t
  | GramA g -> sym g
  | DefA x -> defid x

and param p =
  match p.it with
  | ExpP (x, t) -> varid x; typ t
  | TypP x -> typid x
  | GramP (x, t) -> gramid x; typ t
  | DefP (x, ps, t) -> defid x; params ps; typ t

and args as_ = list arg as_
and params ps = list param ps

let hintdef d =
  match d.it with
  | AtomH (x, at, hs) -> varid x; atom at; hints hs
  | TypH (x1, x2, hs) -> typid x1; ruleid x2; hints hs
  | GramH (x1, x2, hs) -> gramid x1; ruleid x2; hints hs
  | RelH (x, hs) -> relid x; hints hs
  | VarH (x, hs) -> varid x; hints hs
  | DecH (x, hs) -> defid x; hints hs

let def d =
  visit_def d;
  match d.it with
  | FamD (x, ps, hs) -> typid x; params ps; hints hs
  | TypD (x1, x2, as_, t, hs) -> typid x1; ruleid x2; args as_; typ t; hints hs
  | GramD (x1, x2, ps, t, gr, hs) -> typid x1; ruleid x2; params ps; typ t; gram gr; hints hs
  | VarD (x, t, hs) -> varid x; typ t; hints hs
  | SepD -> ()
  | RelD (x, t, hs) -> relid x; typ t; hints hs
  | RuleD (x1, x2, e, prs) -> relid x1; ruleid x2; exp e; prems prs
  | DecD (x, ps, t, hs) -> defid x; params ps; typ t; hints hs
  | DefD (x, as_, e, prs) -> defid x; args as_; exp e; prems prs
  | HintD hd -> hintdef hd
end


(* Cloning *)

let clone_note note = Atom.{note with def = ""}
let clone_atom atom = {atom with note = clone_note atom.note}

let rec clone_iter = function
  | ListN (e, ido) -> ListN (clone_exp e, ido)
  | iter -> iter

and clone_typ t =
  (match t.it with
  | VarT (id, args) -> VarT (id, List.map clone_arg args)
  | (BoolT | NumT _ | TextT) as t' -> t'
  | ParenT t1 -> ParenT (clone_typ t1)
  | TupT ts -> TupT (List.map clone_typ ts)
  | IterT (t1, iter) -> IterT (clone_typ t1, clone_iter iter) 
  | AtomT atom -> AtomT (clone_atom atom)
  | SeqT ts -> SeqT (List.map clone_typ ts)
  | InfixT (t1, atom, t2) -> InfixT (clone_typ t1, clone_atom atom, clone_typ t2)
  | BrackT (atom1, t1, atom2) -> BrackT (clone_atom atom1, clone_typ t1, clone_atom atom2)
  | StrT (dots1, ts, tfs, dots2) -> StrT (dots1, Convert.map_nl_list clone_typ ts, Convert.map_nl_list clone_typfield tfs, dots2)
  | CaseT (dots1, ts, tcs, dots2) -> CaseT (dots1, Convert.map_nl_list clone_typ ts, Convert.map_nl_list clone_typcase tcs, dots2)
  | ConT tc -> ConT (clone_typcon tc)
  | RangeT tes -> RangeT (Convert.map_nl_list clone_typenum tes)
  ) $ t.at

and clone_typfield (atom, (t, prs), hints) =
  (clone_atom atom, (clone_typ t, Convert.map_nl_list clone_prem prs), List.map clone_hint hints)

and clone_typcase (atom, (t, prs), hints) =
  (clone_atom atom, (clone_typ t, Convert.map_nl_list clone_prem prs), List.map clone_hint hints)

and clone_typcon ((t, prs), hints) =
  ((clone_typ t, Convert.map_nl_list clone_prem prs), List.map clone_hint hints)

and clone_typenum (e1, eo2) =
  (clone_exp e1, Option.map clone_exp eo2)

and clone_exp e =
  (match e.it with
  | VarE (id, args) -> VarE (id, List.map clone_arg args)
  | (BoolE _ | NumE _ | TextE _ | EpsE | SizeE _ | HoleE _) as e' -> e'
  | AtomE atom -> AtomE (clone_atom atom)
  | CvtE (e1, t) -> CvtE (clone_exp e1, t)
  | UnE (op, e1) -> UnE (op, clone_exp e1)
  | BinE (e1, op, e2) -> BinE (clone_exp e1, op, clone_exp e2)
  | CmpE (e1, op, e2) -> CmpE (clone_exp e1, op, clone_exp e2)
  | SeqE es -> SeqE (List.map clone_exp es)
  | ListE es -> ListE (List.map clone_exp es)
  | IdxE (e1, e2) -> IdxE (clone_exp e1, clone_exp e2)
  | SliceE (e1, e2, e3) -> SliceE (clone_exp e1, clone_exp e2, clone_exp e3)
  | UpdE (e1, p, e2) -> UpdE (clone_exp e1, clone_path p, clone_exp e2)
  | ExtE (e1, p, e2) -> ExtE (clone_exp e1, clone_path p, clone_exp e2)
  | StrE efs -> StrE (Convert.map_nl_list clone_expfield efs)
  | DotE (e1, atom) -> DotE (clone_exp e1, clone_atom atom)
  | CommaE (e1, e2) -> CommaE (clone_exp e1, clone_exp e2)
  | CatE (e1, e2) -> CatE (clone_exp e1, clone_exp e2)
  | MemE (e1, e2) -> MemE (clone_exp e1, clone_exp e2)
  | LenE e1 -> LenE (clone_exp e1)
  | ParenE e1 -> ParenE (clone_exp e1)
  | TupE es -> TupE (List.map clone_exp es)
  | InfixE (e1, atom, e2) -> InfixE (clone_exp e1, clone_atom atom, clone_exp e2)
  | BrackE (atom1, e1, atom2) -> BrackE (clone_atom atom1, clone_exp e1, clone_atom atom2)
  | CallE (id, args) -> CallE (id, List.map clone_arg args)
  | IterE (e1, iter) -> IterE (clone_exp e1, clone_iter iter)
  | TypE (e1, t) -> TypE (clone_exp e1, clone_typ t)
  | ArithE e1 -> ArithE (clone_exp e1)
  | FuseE (e1, e2) -> FuseE (clone_exp e1, clone_exp e2)
  | UnparenE e1 -> UnparenE (clone_exp e1)
  | LatexE s -> LatexE s
  ) $ e.at

and clone_expfield (atom, e) = (clone_atom atom, clone_exp e)

and clone_path p =
  (match p.it with
  | RootP -> RootP
  | IdxP (p1, e) -> IdxP (clone_path p1, clone_exp e)
  | SliceP (p1, e1, e2) -> SliceP (clone_path p1, clone_exp e1, clone_exp e2)
  | DotP (p1, atom) -> DotP (clone_path p1, clone_atom atom)
  ) $ p.at

and clone_sym g =
  (match g.it with
  | VarG (id, args) -> VarG (id, List.map clone_arg args)
  | (NumG _ | TextG _ | EpsG) as g' -> g'
  | SeqG gs -> SeqG (Convert.map_nl_list clone_sym gs)
  | AltG gs -> AltG (Convert.map_nl_list clone_sym gs)
  | RangeG (g1, g2) -> RangeG (clone_sym g1, clone_sym g2)
  | ParenG g1 -> ParenG (clone_sym g1)
  | TupG gs -> TupG (List.map clone_sym gs)
  | IterG (g1, iter) -> IterG (clone_sym g1, clone_iter iter)
  | ArithG e1 -> ArithG (clone_exp e1)
  | AttrG (e1, g2) -> AttrG (clone_exp e1, clone_sym g2)
  | FuseG (g1, g2) -> FuseG (clone_sym g1, clone_sym g2)
  | UnparenG g1 -> UnparenG (clone_sym g1)
  ) $ g.at

and clone_prod prod =
  (match prod.it with
  | SynthP (g, e, prs) ->
    SynthP (clone_sym g, clone_exp e, Convert.map_nl_list clone_prem prs)
  | RangeP (g1, e1, g2, e2) ->
    RangeP (clone_sym g1, clone_exp e1, clone_sym g2, clone_exp e2)
  | EquivP (g1, g2, prs) ->
    EquivP (clone_sym g1, clone_sym g2, Convert.map_nl_list clone_prem prs)
  ) $ prod.at

and clone_gram gram =
  let dots1, prods, dots2 = gram.it in
  {gram with it = dots1, Convert.map_nl_list clone_prod prods, dots2}

and clone_prem pr =
  (match pr.it with
  | VarPr (x, t) -> VarPr (x, clone_typ t)
  | RulePr (x, e) -> RulePr (x, clone_exp e)
  | IfPr e -> IfPr (clone_exp e)
  | ElsePr -> ElsePr
  | IterPr (pr1, it) -> IterPr (clone_prem pr1, clone_iter it)
  ) $ pr.at

and clone_arg a =
  (match !(a.it) with
  | ExpA e -> ExpA (clone_exp e)
  | TypA t -> TypA (clone_typ t)
  | GramA _ as a' -> a'
  | DefA _ as a' -> a'
  ) |> ref $ a.at

and clone_param p =
  (match p.it with
  | ExpP (x, t) -> ExpP (x, clone_typ t)
  | TypP x -> TypP x
  | GramP (x, t) -> GramP (x, clone_typ t)
  | DefP (x, ps, t) -> DefP (x, List.map clone_param ps, clone_typ t)
  ) $ p.at

and clone_hint hint = {hint with hintexp = clone_exp hint.hintexp}

let clone_hintdef d =
  (match d.it with
  | AtomH (x, at, hs) -> AtomH (x, clone_atom at, List.map clone_hint hs)
  | TypH (x1, x2, hs) -> TypH (x1, x2, List.map clone_hint hs)
  | GramH (x1, x2, hs) -> GramH (x1, x2, List.map clone_hint hs)
  | RelH (x, hs) -> RelH (x, List.map clone_hint hs)
  | VarH (x, hs) -> VarH (x, List.map clone_hint hs)
  | DecH (x, hs) -> DecH (x, List.map clone_hint hs)
  ) $ d.at

let clone_def d =
  (match d.it with
  | FamD (x, ps, hs) -> FamD (x, List.map clone_param ps, List.map clone_hint hs)
  | TypD (x1, x2, as_, t, hs) -> TypD (x1, x2, List.map clone_arg as_, clone_typ t, List.map clone_hint hs)
  | GramD (x1, x2, ps, t, gr, hs) -> GramD (x1, x2, List.map clone_param ps, clone_typ t, clone_gram gr, List.map clone_hint hs)
  | VarD (x, t, hs) -> VarD (x, clone_typ t, List.map clone_hint hs)
  | SepD -> SepD
  | RelD (x, t, hs) -> RelD (x, clone_typ t, List.map clone_hint hs)
  | RuleD (x1, x2, e, prs) -> RuleD (x1, x2, clone_exp e, Convert.map_nl_list clone_prem prs)
  | DecD (x, ps, t, hs) -> DecD (x, List.map clone_param ps, clone_typ t, List.map clone_hint hs)
  | DefD (x, as_, e, prs) -> DefD (x, List.map clone_arg as_, clone_exp e, Convert.map_nl_list clone_prem prs)
  | HintD hd -> HintD (clone_hintdef hd)
  ) $ d.at
