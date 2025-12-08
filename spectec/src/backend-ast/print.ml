open Util
open Sexpr
open Source
open Xl
open Il
open Ast


(* Literal *)

let bool b = Atom (Bool.to_string b)
let text t = Atom ("\"" ^ String.escaped t ^ "\"")
let id x = text x.it
let mixop op =
  String.concat "%" (List.map (
    fun ats -> String.concat "" (List.map Atom.to_string ats)) op
  ) |> text

let num = function
  | `Nat n -> Node ("nat", [Atom (Z.to_string n)])
  | `Int i -> Node ("int", [Atom ((if i >= Z.zero then "+" else "-") ^ Z.to_string (Z.abs i))])
  | `Rat q -> Node ("rat", [Atom (Z.to_string (Q.num q) ^ "/" ^ Z.to_string (Q.den q))])
  | `Real r -> Node ("real", [Atom (Printf.sprintf "%.17g" r)])


(* Operators *)

let unop = function
  | `NotOp -> Atom "not"
  | `PlusOp -> Atom "plus"
  | `MinusOp -> Atom "minus"
  | `PlusMinusOp -> Atom "plusminus"
  | `MinusPlusOp -> Atom "minusplus"

let binop = function
  | `AndOp -> Atom "and"
  | `OrOp -> Atom "or"
  | `ImplOp -> Atom "impl"
  | `EquivOp -> Atom "equiv"
  | `AddOp -> Atom "add"
  | `SubOp -> Atom "sub"
  | `MulOp -> Atom "mul"
  | `DivOp -> Atom "div"
  | `ModOp -> Atom "mod"
  | `PowOp -> Atom "pow"

let cmpop = function
  | `EqOp -> Atom "eq"
  | `NeOp -> Atom "ne"
  | `LtOp -> Atom "lt"
  | `GtOp -> Atom "gt"
  | `LeOp -> Atom "le"
  | `GeOp -> Atom "ge"


(* Iterations *)

let rec iter = function
  | Opt -> Atom "opt"
  | List -> Atom "list"
  | List1 -> Atom "list1"
  | ListN (e, xo) -> Node ("listn", [exp e] @ List.map id (Option.to_list xo))


(* Types *)

and booltyp t = Atom (Bool.string_of_typ t)
and numtyp t = Atom (Num.string_of_typ t)

and optyp = function
  | #Bool.typ as t -> booltyp t
  | #Num.typ as t -> numtyp t

and typ t =
  match t.it with
  | VarT (x, as1) -> Node ("var", [id x] @ List.map arg as1)
  | BoolT -> Atom "bool"
  | NumT t -> numtyp t
  | TextT -> Atom "text"
  | TupT ets -> Node ("tup", List.map typbind ets)
  | IterT (t1, it) -> Node ("iter", [typ t1; iter it])

and deftyp dt =
  match dt.it with
  | AliasT t -> Node ("alias", [typ t])
  | StructT tfs -> Node ("struct", List.map typfield tfs)
  | VariantT tcs -> Node ("variant", List.map typcase tcs)

and typbind (e, t) =
  Node ("bind", [exp e; typ t])

and typfield (at, (bs, t, prs), _hints) =
  Node ("field", mixop [[at]] :: List.map bind bs @ typ t :: List.map prem prs)

and typcase (op, (bs, t, prs), _hints) =
  Node ("case", mixop op :: List.map bind bs @ typ t :: List.map prem prs)


(* Expressions *)

and exp e =
  match e.it with
  | VarE x -> Node ("var", [id x])
  | BoolE b -> Node ("bool", [bool b])
  | NumE n -> Node ("num", [num n])
  | TextE t -> Node ("text", [text t])
  | UnE (op, t, e2) -> Node ("un", [unop op; optyp t; exp e2])
  | BinE (op, t, e1, e2) -> Node ("bin", [binop op; optyp t; exp e1; exp e2])
  | CmpE (op, t, e1, e2) -> Node ("cmp", [cmpop op; optyp t; exp e1; exp e2])
  | IdxE (e1, e2) -> Node ("idx", [exp e1; exp e2])
  | SliceE (e1, e2, e3) -> Node ("slice", [exp e1; exp e2; exp e3])
  | UpdE (e1, p, e2) -> Node ("upd", [exp e1; path p; exp e2])
  | ExtE (e1, p, e2) -> Node ("ext", [exp e1; path p; exp e2])
  | StrE efs -> Node ("struct", List.map expfield efs)
  | DotE (e1, at) -> Node ("dot", [exp e1; mixop [[at]]])
  | CompE (e1, e2) -> Node ("comp", [exp e1; exp e2])
  | MemE (e1, e2) -> Node ("mem", [exp e1; exp e2])
  | LenE e1 -> Node ("len", [exp e1])
  | TupE es -> Node ("tup", List.map exp es)
  | CallE (x, as1) -> Node ("call", id x :: List.map arg as1)
  | IterE (e1, it) -> Node ("iter", [exp e1] @ iterexp it)
  | ProjE (e1, i) -> Node ("proj", [exp e1; Atom (string_of_int i)])
  | CaseE (op, e1) -> Node ("case", [mixop op; exp e1])
  | UncaseE (e1, op) -> Node ("uncase", [exp e1; mixop op])
  | OptE eo -> Node ("opt", List.map exp (Option.to_list eo))
  | TheE e1 -> Node ("unopt", [exp e1])
  | ListE es -> Node ("list", List.map exp es)
  | LiftE e1 -> Node ("lift", [exp e1])
  | CatE (e1, e2) -> Node ("cat", [exp e1; exp e2])
  | CvtE (e1, nt1, nt2) -> Node ("cvt", [numtyp nt1; numtyp nt2; exp e1])
  | SubE (e1, t1, t2) -> Node ("sub", [typ t1; typ t2; exp e1])
  | IfE (e1, e2, e3) -> Node ("if", [exp e1; exp e2; exp e3])

and expfield (at, e) =
  Node ("field", [mixop [[at]]; exp e])

and path p =
  match p.it with
  | RootP -> Atom "root"
  | IdxP (p1, e) -> Node ("idx", [path p1; exp e])
  | SliceP (p1, e1, e2) -> Node ("slice", [path p1; exp e1; exp e2])
  | DotP (p1, at) -> Node ("dot", [path p1; mixop [[at]]])

and iterexp (it, xes) =
  iter it :: List.map (fun (x, e) -> Node ("dom", [id x; exp e])) xes


(* Grammars *)

and sym g =
  match g.it with
  | VarG (x, as1) -> Node ("var", id x :: List.map arg as1)
  | NumG n -> Node ("num", [Atom (Printf.sprintf "0x%02X" n)])
  | TextG t -> Node ("text", [text t])
  | EpsG -> Atom "eps"
  | SeqG gs -> Node ("seq", List.map sym gs)
  | AltG gs -> Node ("alt", List.map sym gs)
  | RangeG (g1, g2) -> Node ("range", [sym g1; sym g2])
  | IterG (g1, it) -> Node ("iter", [sym g1] @ iterexp it)
  | AttrG (e, g1) -> Node ("attr", [exp e; sym g1])


(* Premises *)

and prem pr =
  match pr.it with
  | RulePr (x, op, e) -> Node ("rule", [id x; mixop op; exp e])
  | IfPr e -> Node ("if", [exp e])
  | LetPr (e1, e2, _xs) -> Node ("let", [exp e1; exp e2])
  | ElsePr -> Atom "else"
  | IterPr (pr1, it) -> Node ("iter", [prem pr1] @ iterexp it)
  | NegPr pr1 -> Node ("neg", [prem pr1])


(* Definitions *)

and arg a =
  match a.it with
  | ExpA e -> Node ("exp", [exp e])
  | TypA t -> Node ("typ", [typ t])
  | DefA x -> Node ("def", [id x])
  | GramA g -> Node ("gram", [sym g])

and bind bind =
  match bind.it with
  | ExpB (x, t) -> Node ("exp", [id x; typ t])
  | TypB x -> Node ("typ", [id x])
  | DefB (x, ps, t) -> Node ("def", [id x] @ List.map param ps @ [typ t])
  | GramB (x, ps, t) -> Node ("gram", [id x] @ List.map param ps @ [typ t])

and param p =
  match p.it with
  | ExpP (x, t) -> Node ("exp", [id x; typ t])
  | TypP x -> Node ("typ", [id x])
  | DefP (x, ps, t) -> Node ("def", [id x] @ List.map param ps @ [typ t])
  | GramP (x, t) -> Node ("gram", [id x; typ t])

let inst inst =
  match inst.it with
  | InstD (bs, as_, dt) ->
    Node ("inst", List.map bind bs @ List.map arg as_ @ [deftyp dt])

let rule rule =
  match rule.it with
  | RuleD (x, bs, op, e, prs) ->
    Node ("rule", [id x] @ List.map bind bs @ [mixop op; exp e] @ List.map prem prs)

let clause clause =
  match clause.it with
  | DefD (bs, as_, e, prs) ->
    Node ("clause", List.map bind bs @ List.map arg as_ @ [exp e] @ List.map prem prs)

let prod prod =
  match prod.it with
  | ProdD (bs, g, e, prs) ->
    Node ("prod", List.map bind bs @ [sym g; exp e] @ List.map prem prs)

let rec def d =
  match d.it with
  | TypD (x, ps, insts) ->
    Node ("typ", [id x] @ List.map param ps @ List.map inst insts)
  | RelD (x, op, t, rules) ->
    Node ("rel", [id x; mixop op; typ t] @ List.map rule rules)
  | DecD (x, ps, t, clauses) ->
    Node ("def", [id x] @ List.map param ps @ [typ t] @ List.map clause clauses)
  | GramD (x, ps, t, prods) ->
    Node ("gram", [id x] @ List.map param ps @ [typ t] @ List.map prod prods)
  | RecD ds ->
    Node ("rec", List.map def ds)
  | HintD _ ->
    Atom ""


(* Scripts *)

let script ds =
  List.filter ((<>) (Atom "")) (List.map def ds)


(* Printing *)

open Config

let output_typ oc cfg t = Sexpr.output oc cfg.width (typ t)
let output_exp oc cfg e = Sexpr.output oc cfg.width (exp e)
let output_def oc cfg d = Sexpr.output oc cfg.width (def d)
let output_script oc cfg s = List.iter (Sexpr.output oc cfg.width) (script s)

let string_of_typ cfg t = Sexpr.to_string cfg.width (typ t)
let string_of_exp cfg e = Sexpr.to_string cfg.width (exp e)
let string_of_def cfg d = Sexpr.to_string cfg.width (def d)
let string_of_script cfg s =
  String.concat "\n" (List.map (Sexpr.to_string cfg.width) (script s))
