open Util
open Source
open Ast
open Xl

module type Arg =
sig
  type scope

  val visit_atom : atom -> unit
  val visit_mixop : mixop -> unit
  val visit_typid : id -> unit
  val visit_relid : id -> unit
  val visit_ruleid : id -> unit
  val visit_varid : id -> unit
  val visit_defid : id -> unit
  val visit_gramid : id -> unit

  val visit_typ : typ -> unit
  val visit_deftyp : deftyp -> unit
  val visit_exp : exp -> unit
  val visit_path : path -> unit
  val visit_sym : sym -> unit
  val visit_prem : prem -> unit
  val visit_def : def -> unit

  val visit_hint : hint -> unit

  val scope_enter : id -> typ -> scope
  val scope_exit : id -> scope -> unit
end

module Skip =
struct
  type scope = unit

  let visit_atom _ = ()
  let visit_mixop _ = ()
  let visit_typid _ = ()
  let visit_relid _ = ()
  let visit_ruleid _ = ()
  let visit_varid _ = ()
  let visit_defid _ = ()
  let visit_gramid _ = ()

  let visit_typ _ = ()
  let visit_deftyp _ = ()
  let visit_exp _ = ()
  let visit_path _ = ()
  let visit_sym _ = ()
  let visit_prem _ = ()
  let visit_def _ = ()

  let visit_hint _ = ()

  let scope_enter _ _ = ()
  let scope_exit _ _ = ()
end


module Make(X : Arg) =
struct
open X

let opt = Option.iter
let list = List.iter
let pair f1 f2 (x1, x2) = f1 x1; f2 x2


(* Identifiers, operators, literals *)

let bool _b = ()
let num _n = ()
let text _s = ()

let atom at = visit_atom at
let mixop at = visit_mixop at
let typid x = visit_typid x
let relid x = visit_relid x
let ruleid x = visit_ruleid x
let varid x = visit_varid x
let defid x = visit_defid x
let gramid x = visit_gramid x

let unop _op = ()
let binop _op = ()
let cmpop _op = ()

let hint h = visit_hint h
let hints = list hint


(* Iterations *)

let rec iter it =
  match it with
  | Opt | List | List1 -> ()
  | ListN _ -> assert false

and iterexp : 'a. ('a -> unit) -> 'a -> _ -> unit = fun f body (it, xes) ->
  let eo, xo, xts1 =
    match it with
    | ListN (e, Some x) -> Some e, Some x, [(x, NumT `NatT $ x.at)]
    | ListN (e, None) -> Some e, None, []
    | _ -> None, None, []
  in
  let xts = xts1 @ List.map (fun (x, e) -> x, e.note) xes in
  let old_scopes = List.map (fun (x, t) -> scope_enter x t) xts in
  f body;
  opt varid xo;
  list (pair varid ignore) xes;
  List.iter2 (fun (x, _) scope -> scope_exit x scope)
    (List.rev xts) (List.rev old_scopes);
  opt exp eo; list (pair ignore exp) xes


(* Types *)

and dots _ = ()
and numtyp _nt = ()
and optyp = function #Bool.typ -> () | #Num.typ as nt -> numtyp nt

and typ ?(prems = []) t =
  visit_typ t;
  match t.it with
  | VarT (x, as_) -> typid x; args as_
  | BoolT | TextT -> ()
  | NumT nt -> numtyp nt
  | TupT [] -> list prem prems
  | TupT ((x, t)::xts) ->
    typ t;
    let scope = scope_enter x t in
    varid x;
    typ (TupT xts $ t.at) ~prems;
    scope_exit x scope
  | IterT (t1, it) -> typ t1; iter it

and deftyp t =
  visit_deftyp t;
  match t.it with
  | AliasT t -> typ t
  | StructT tfs -> list typfield tfs
  | VariantT tcs -> list typcase tcs

and typfield (at, (ps, t, prems), hs) =
  atom at; params ps; typ t ~prems; hints hs
and typcase (op, (ps, t, prems), hs) =
  mixop op; params ps; typ t ~prems; hints hs


(* Expressions *)

and exp e =
  visit_exp e;
  match e.it with
  | VarE x -> varid x
  | BoolE b -> bool b
  | NumE n -> num n
  | TextE s -> text s
  | UnE (op, ot, e1) -> unop op; optyp ot; exp e1
  | BinE (op, ot, e1, e2) -> binop op; optyp ot; exp e1; exp e2
  | CmpE (op, ot, e1, e2) -> cmpop op; optyp ot; exp e1; exp e2
  | TupE es | ListE es -> list exp es
  | ProjE (e1, _) | TheE e1 | LiftE e1 | LenE e1 -> exp e1
  | CaseE (op, e1) -> mixop op; exp e1
  | UncaseE (e1, op) -> exp e1; mixop op
  | OptE eo -> opt exp eo
  | StrE efs -> list expfield efs
  | DotE (e1, at) -> exp e1; atom at
  | CompE (e1, e2) | MemE (e1, e2) | CatE (e1, e2) | IdxE (e1, e2) -> exp e1; exp e2
  | SliceE (e1, e2, e3) -> exp e1; exp e2; exp e3
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) -> exp e1; path p; exp e2
  | CallE (x, as_) -> defid x; args as_
  | IterE (e1, it) -> iterexp exp e1 it
  | CvtE (e1, nt1, nt2) -> exp e1; numtyp nt1; numtyp nt2
  | SubE (e1, t1, t2) -> exp e1; typ t1; typ t2
 
and expfield (at, e) = atom at; exp e

and path p =
  visit_path p;
  match p.it with
  | RootP -> ()
  | IdxP (p1, e) -> path p1; exp e
  | SliceP (p1, e1, e2) -> path p1; exp e1; exp e2
  | DotP (p1, at) -> path p1; atom at


(* Grammars *)

and sym g =
  visit_sym g;
  match g.it with
  | VarG (x, as_) -> gramid x; args as_
  | NumG n -> num (`Nat (Z.of_int n))
  | TextG s -> text s
  | EpsG -> ()
  | SeqG gs | AltG gs -> list sym gs
  | RangeG (g1, g2) -> sym g1; sym g2
  | IterG (g1, it) -> iterexp sym g1 it
  | AttrG (e, g1) -> exp e; sym g1


(* Premises *)

and prem pr =
  visit_prem pr;
  match pr.it with
  | RulePr (x, op, e) -> relid x; mixop op; exp e
  | IfPr e -> exp e
  | ElsePr -> ()
  | IterPr (pr1, it) -> iterexp prem pr1 it
  | LetPr (e1, e2, _) -> exp e1; exp e2

and prems prs = list prem prs


(* Definitions *)

and arg a =
  match a.it with
  | ExpA e -> exp e
  | TypA t -> typ t
  | DefA x -> defid x
  | GramA g -> sym g

and param p =
  match p.it with
  | ExpP (x, t) -> varid x; typ t
  | TypP x -> typid x
  | DefP (x, ps, t) -> defid x; params ps; typ t
  | GramP (x, ps, t) -> gramid x; params ps; typ t

and args as_ = list arg as_
and params ps = list param ps

let hintdef d =
  match d.it with
  | TypH (x, hs) -> typid x; hints hs
  | RelH (x, hs) -> relid x; hints hs
  | DecH (x, hs) -> defid x; hints hs
  | GramH (x, hs) -> gramid x; hints hs

let inst i =
  match i.it with
  | InstD (ps, as_, dt) -> params ps; args as_; deftyp dt

let rule r =
  match r.it with
  | RuleD (x, ps, op, e, prs) -> ruleid x; params ps; mixop op; exp e; prems prs

let clause c =
  match c.it with
  | DefD (ps, as_, e, prs) -> params ps; args as_; exp e; prems prs

let prod p =
  match p.it with
  | ProdD (ps, g, e, prs) -> params ps; sym g; exp e; prems prs

let rec def d =
  visit_def d;
  match d.it with
  | TypD (x, ps, insts) -> typid x; params ps; list inst insts
  | RelD (x, op, t, rules) -> relid x; mixop op; typ t; list rule rules
  | DecD (x, ps, t, clauses) -> defid x; params ps; typ t; list clause clauses
  | GramD (x, ps, t, prods) -> gramid x; params ps; typ t; list prod prods
  | RecD ds -> list def ds
  | HintD hd -> hintdef hd
end
