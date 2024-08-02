open Util.Source
open Ast

module Atom = El.Atom


(* Helpers *)

let eq_opt eq_x xo1 xo2 =
  match xo1, xo2 with
  | Some x1, Some x2 -> eq_x x1 x2
  | _, _ -> xo1 = xo2

let eq_list eq_x xs1 xs2 =
  List.length xs1 = List.length xs2 && List.for_all2 eq_x xs1 xs2

let eq_pair eq_x eq_y (x1, y1) (x2, y2) =
  eq_x x1 x2 && eq_y y1 y2


(* Ids *)

let eq_id i1 i2 =
  i1.it = i2.it

let eq_atom atom1 atom2 =
  Atom.eq atom1 atom2

let eq_mixop op1 op2 =
  Mixop.eq op1 op2


(* Iteration *)

let rec eq_iter iter1 iter2 =
  match iter1, iter2 with
  | ListN (e1, ido1), ListN (e2, ido2) -> eq_exp e1 e2 && eq_opt eq_id ido1 ido2
  | _, _ -> iter1 = iter2


(* Types *)

and eq_typ t1 t2 =
  match t1.it, t2.it with
  | VarT (id1, as1), VarT (id2, as2) -> eq_id id1 id2 && eq_list eq_arg as1 as2
  | TupT xts1, TupT xts2 -> eq_list (eq_pair eq_exp eq_typ) xts1 xts2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    eq_typ t11 t21 && eq_iter iter1 iter2
  | _, _ -> t1.it = t2.it

and eq_deftyp dt1 dt2 =
  match dt1.it, dt2.it with
  | AliasT t1, AliasT t2 -> eq_typ t1 t2
  | StructT tfs1, StructT tfs2 -> eq_list eq_typfield tfs1 tfs2
  | VariantT tcs1, VariantT tcs2 -> eq_list eq_typcase tcs1 tcs2
  | _, _ -> false

and eq_typfield (atom1, (_binds1, t1, prems1), _) (atom2, (_binds2, t2, prems2), _) =
  eq_atom atom1 atom2 && eq_typ t1 t2 && eq_list eq_prem prems1 prems2

and eq_typcase (op1, (_binds1, t1, prems1), _) (op2, (_binds2, t2, prems2), _) =
  eq_mixop op1 op2 && eq_typ t1 t2 && eq_list eq_prem prems1 prems2


(* Expressions *)

and eq_exp e1 e2 =
  match e1.it, e2.it with
  | VarE id1, VarE id2 -> eq_id id1 id2
  | UnE (op1, e11), UnE (op2, e21) -> op1 = op2 && eq_exp e11 e21
  | BinE (op1, e11, e12), BinE (op2, e21, e22) ->
    op1 = op2 && eq_exp e11 e21 && eq_exp e12 e22
  | CmpE (op1, e11, e12), CmpE (op2, e21, e22) ->
    op1 = op2 && eq_exp e11 e21 && eq_exp e12 e22
  | LenE e11, LenE e21 -> eq_exp e11 e21
  | IdxE (e11, e12), IdxE (e21, e22)
  | CompE (e11, e12), CompE (e21, e22)
  | MemE (e11, e12), MemE (e21, e22)
  | CatE (e11, e12), CatE (e21, e22) -> eq_exp e11 e21 && eq_exp e12 e22
  | SliceE (e11, e12, e13), SliceE (e21, e22, e23) ->
    eq_exp e11 e21 && eq_exp e12 e22 && eq_exp e13 e23
  | UpdE (e11, p1, e12), UpdE (e21, p2, e22)
  | ExtE (e11, p1, e12), ExtE (e21, p2, e22) ->
    eq_exp e11 e21 && eq_path p1 p2 && eq_exp e12 e22
  | TupE es1, TupE es2
  | ListE es1, ListE es2 -> eq_list eq_exp es1 es2
  | StrE efs1, StrE efs2 -> eq_list eq_expfield efs1 efs2
  | DotE (e11, atom1), DotE (e21, atom2) -> eq_exp e11 e21 && eq_atom atom1 atom2
  | UncaseE (e1, op1), UncaseE (e2, op2) -> eq_mixop op1 op2 && eq_exp e1 e2
  | CallE (id1, as1), CallE (id2, as2) -> eq_id id1 id2 && eq_list eq_arg as1 as2
  | IterE (e11, iter1), IterE (e21, iter2) ->
    eq_exp e11 e21 && eq_iterexp iter1 iter2
  | OptE eo1, OptE eo2 -> eq_opt eq_exp eo1 eo2
  | ProjE (e1, i1), ProjE (e2, i2) -> eq_exp e1 e2 && i1 = i2
  | TheE e1, TheE e2 -> eq_exp e1 e2
  | CaseE (op1, e1), CaseE (op2, e2) -> eq_mixop op1 op2 && eq_exp e1 e2
  | SubE (e1, t11, t12), SubE (e2, t21, t22) ->
    eq_exp e1 e2 && eq_typ t11 t21 && eq_typ t12 t22
  | _, _ -> e1.it = e2.it

and eq_expfield (atom1, e1) (atom2, e2) =
  eq_atom atom1 atom2 && eq_exp e1 e2

and eq_path p1 p2 =
  match p1.it, p2.it with
  | RootP, RootP -> true
  | IdxP (p11, e1), IdxP (p21, e2) -> eq_path p11 p21 && eq_exp e1 e2
  | SliceP (p11, e11, e12), SliceP (p21, e21, e22) ->
    eq_path p11 p21 && eq_exp e11 e21 && eq_exp e12 e22
  | DotP (p11, atom1), DotP (p21, atom2) -> eq_path p11 p21 && eq_atom atom1 atom2
  | _, _ -> p1.it = p2.it

and eq_iterexp (iter1, xes1) (iter2, xes2) =
  eq_iter iter1 iter2 && eq_list (eq_pair eq_id eq_exp) xes1 xes2


(* Grammars *)

and eq_sym g1 g2 =
  match g1.it, g2.it with
  | VarG (id1, args1), VarG (id2, args2) ->
    eq_id id1 id2 && eq_list eq_arg args1 args2
  | SeqG gs1, SeqG gs2
  | AltG gs1, AltG gs2 -> eq_list eq_sym gs1 gs2
  | RangeG (g11, g12), RangeG (g21, g22) -> eq_sym g11 g21 && eq_sym g12 g22
  | IterG (g11, iter1), IterG (g21, iter2) ->
    eq_sym g11 g21 && eq_iterexp iter1 iter2
  | AttrG (e1, g11), AttrG (e2, g21) -> eq_exp e1 e2 && eq_sym g11 g21
  | _, _ -> g1.it = g2.it


(* Premises *)

and eq_prem prem1 prem2 =
  match prem1.it, prem2.it with
  | RulePr (id1, op1, e1), RulePr (id2, op2, e2) ->
    eq_id id1 id2 && eq_mixop op1 op2 && eq_exp e1 e2
  | IfPr e1, IfPr e2 -> eq_exp e1 e2
  | IterPr (prem1, e1), IterPr (prem2, e2) ->
    eq_prem prem1 prem2 && eq_iterexp e1 e2
  | _, _ -> prem1.it = prem2.it


(* Definitions *)

and eq_arg a1 a2 =
  match a1.it, a2.it with
  | ExpA e1, ExpA e2 -> eq_exp e1 e2
  | TypA t1, TypA t2 -> eq_typ t1 t2
  | DefA id1, DefA id2 -> eq_id id1 id2
  | GramA g1, GramA g2 -> eq_sym g1 g2
  | _, _ -> false
