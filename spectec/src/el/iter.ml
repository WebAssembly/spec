open Util
open Source
open Ast

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
let nat _n = ()
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
  | StrT tfs -> nl_list typfield tfs
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
  | NatE (op, n) -> natop op; nat n
  | TextE s -> text s
  | EpsE | HoleE _ | LatexE _ -> ()
  | UnE (op, e1) -> unop op; exp e1
  | LenE e1 | ArithE e1 | ParenE (e1, _) | UnparenE e1 -> exp e1
  | DotE (e1, at) -> exp e1; atom at
  | SizeE x -> gramid x
  | BinE (e1, op, e2) -> exp e1; binop op; exp e2
  | CmpE (e1, op, e2) -> exp e1; cmpop op; exp e2
  | IdxE (e1, e2) | CommaE (e1, e2) | CompE (e1, e2) | MemE (e1, e2)
  | FuseE (e1, e2) -> exp e1; exp e2
  | SliceE (e1, e2, e3) -> exp e1; exp e2; exp e3
  | SeqE es | TupE es -> list exp es
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
  | NatG (op, n) -> natop op; nat n
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
  let (g, e, prs) = pr.it in
  sym g; exp e; prems prs

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
  | StrT _ | CaseT _ | ConT _ | RangeT _ -> assert false
  ) $ t.at

and clone_typcase (atom, (t, prs), hints) =
  (clone_atom atom, (clone_typ t, prs), List.map clone_hint hints)

and clone_exp e =
  (match e.it with
  | VarE (id, args) -> VarE (id, List.map clone_arg args)
  | (BoolE _ | NatE _ | TextE _ | EpsE | SizeE _ | HoleE _) as e' -> e'
  | AtomE atom -> AtomE (clone_atom atom)
  | UnE (op, e1) -> UnE (op, clone_exp e1)
  | BinE (e1, op, e2) -> BinE (clone_exp e1, op, clone_exp e2)
  | CmpE (e1, op, e2) -> CmpE (clone_exp e1, op, clone_exp e2)
  | SeqE es -> SeqE (List.map clone_exp es)
  | IdxE (e1, e2) -> IdxE (clone_exp e1, clone_exp e2)
  | SliceE (e1, e2, e3) -> SliceE (clone_exp e1, clone_exp e2, clone_exp e3)
  | UpdE (e1, p, e2) -> UpdE (clone_exp e1, clone_path p, clone_exp e2)
  | ExtE (e1, p, e2) -> ExtE (clone_exp e1, clone_path p, clone_exp e2)
  | StrE efs -> StrE (Convert.map_nl_list clone_expfield efs)
  | DotE (e1, atom) -> DotE (clone_exp e1, clone_atom atom)
  | CommaE (e1, e2) -> CommaE (clone_exp e1, clone_exp e2)
  | CompE (e1, e2) -> CompE (clone_exp e1, clone_exp e2)
  | MemE (e1, e2) -> MemE (clone_exp e1, clone_exp e2)
  | LenE e1 -> LenE (clone_exp e1)
  | ParenE (e1, b) -> ParenE (clone_exp e1, b)
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

and clone_arg a =
  (match !(a.it) with
  | ExpA e -> ExpA (clone_exp e)
  | TypA t -> TypA (clone_typ t)
  | GramA _ as a' -> a'
  | DefA _ as a' -> a'
  ) |> ref $ a.at

and clone_hint hint = {hint with hintexp = clone_exp hint.hintexp}
