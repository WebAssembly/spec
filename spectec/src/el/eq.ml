open Util.Source
open Ast


(* Helpers *)

let eq_list eq_x xs1 xs2 =
  List.length xs1 = List.length xs2 && List.for_all2 eq_x xs1 xs2

let eq_opt eq_x xo1 xo2 =
  eq_list eq_x (Option.to_list xo1) (Option.to_list xo2)

let eq_nl_elem eq_x e1 e2 =
  match e1, e2 with
  | Elem x1, Elem x2 -> eq_x x1 x2
  | _, _ -> e1 = e2

let eq_nl_list eq_x xs1 xs2 = eq_list (eq_nl_elem eq_x) xs1 xs2


(* Iteration *)

let rec eq_iter iter1 iter2 =
  match iter1, iter2 with
  | ListN (e1, None), ListN (e2, None) -> eq_exp e1 e2
  | ListN (e1, Some id1), ListN (e2, Some id2) ->
    eq_exp e1 e2 && id1.it = id2.it
  | _, _ -> iter1 = iter2


(* Types *)

and eq_typ t1 t2 =
  match t1.it, t2.it with
  | VarT (id1, args1), VarT (id2, args2) ->
    id1.it = id2.it && eq_list eq_arg args1 args2
  | ParenT t11, ParenT t21 -> eq_typ t11 t21
  | TupT ts1, TupT ts2 -> eq_list eq_typ ts1 ts2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    eq_typ t11 t21 && eq_iter iter1 iter2
  | StrT tfs1, StrT tfs2 -> eq_nl_list eq_typfield tfs1 tfs2
  | CaseT (dots11, ts1, tcs1, dots12), CaseT (dots21, ts2, tcs2, dots22) ->
    dots11 = dots21 && eq_nl_list eq_typ ts1 ts2 &&
    eq_nl_list eq_typcase tcs1 tcs2 && dots12 = dots22
  | ConT tc1, ConT tc2 -> eq_typcon tc1 tc2
  | RangeT tes1, RangeT tes2 -> eq_nl_list eq_typenum tes1 tes2
  | AtomT atom1, AtomT atom2 -> atom1.it = atom2.it
  | SeqT ts1, SeqT ts2 -> eq_list eq_typ ts1 ts2
  | InfixT (t11, atom1, t12), InfixT (t21, atom2, t22) ->
    eq_typ t11 t21 && atom1.it = atom2.it && eq_typ t12 t22
  | BrackT (l1, t11, r1), BrackT (l2, t21, r2) ->
    l1.it = l2.it && eq_typ t11 t21 && r1.it = r2.it
  | _, _ -> t1.it = t2.it

and eq_typfield (atom1, (t1, prems1), _) (atom2, (t2, prems2), _) =
  atom1.it = atom2.it && eq_typ t1 t2 && eq_nl_list eq_prem prems1 prems2

and eq_typcase (atom1, (t1, prems1), _) (atom2, (t2, prems2), _) =
  atom1.it = atom2.it && eq_typ t1 t2 && eq_nl_list eq_prem prems1 prems2

and eq_typenum (e1, eo1) (e2, eo2) =
  eq_exp e1 e2 && eq_opt eq_exp eo1 eo2

and eq_typcon ((t1, prems1), _) ((t2, prems2), _) =
  eq_typ t1 t2 && eq_nl_list eq_prem prems1 prems2


(* Expressions *)

and eq_exp e1 e2 =
  match e1.it, e2.it with
  | VarE (id1, args1), VarE (id2, args2) ->
    id1.it = id2.it && eq_list eq_arg args1 args2
  | UnE (op1, e11), UnE (op2, e21) -> op1 = op2 && eq_exp e11 e21
  | BinE (e11, op1, e12), BinE (e21, op2, e22) ->
    eq_exp e11 e21 && op1 = op2 && eq_exp e12 e22
  | CmpE (e11, op1, e12), CmpE (e21, op2, e22) ->
    eq_exp e11 e21 && op1 = op2 && eq_exp e12 e22
  | LenE e11, LenE e21 -> eq_exp e11 e21
  | IdxE (e11, e12), IdxE (e21, e22)
  | CommaE (e11, e12), CommaE (e21, e22)
  | CompE (e11, e12), CompE (e21, e22)
  | FuseE (e11, e12), FuseE (e21, e22) -> eq_exp e11 e21 && eq_exp e12 e22
  | SliceE (e11, e12, e13), SliceE (e21, e22, e23) ->
    eq_exp e11 e21 && eq_exp e12 e22 && eq_exp e13 e23
  | UpdE (e11, p1, e12), UpdE (e21, p2, e22)
  | ExtE (e11, p1, e12), ExtE (e21, p2, e22) ->
    eq_exp e11 e21 && eq_path p1 p2 && eq_exp e12 e22
  | ParenE (e11, b1), ParenE (e21, b2) -> eq_exp e11 e21 && b1 = b2
  | SeqE es1, SeqE es2
  | TupE es1, TupE es2 -> eq_list eq_exp es1 es2
  | StrE efs1, StrE efs2 -> eq_nl_list eq_expfield efs1 efs2
  | DotE (e11, atom1), DotE (e21, atom2) -> eq_exp e11 e21 && atom1.it = atom2.it
  | AtomE atom1, AtomE atom2 -> atom1.it = atom2.it
  | InfixE (e11, atom1, e12), InfixE (e21, atom2, e22) ->
    eq_exp e11 e21 && atom1.it = atom2.it && eq_exp e12 e22
  | BrackE (l1, e1, r1), BrackE (l2, e2, r2) ->
    l1.it = l2.it && eq_exp e1 e2 && r1.it = r2.it
  | CallE (id1, args1), CallE (id2, args2) ->
    id1.it = id2.it && eq_list eq_arg args1 args2
  | IterE (e11, iter1), IterE (e21, iter2) ->
    eq_exp e11 e21 && eq_iter iter1 iter2
  | TypE (e11, t1), TypE (e21, t2) ->
    eq_exp e11 e21 && eq_typ t1 t2
  | _, _ -> e1.it = e2.it

and eq_expfield (atom1, e1) (atom2, e2) =
  atom1.it = atom2.it && eq_exp e1 e2

and eq_path p1 p2 =
  match p1.it, p2.it with
  | RootP, RootP -> true
  | IdxP (p11, e1), IdxP (p21, e2) -> eq_path p11 p21 && eq_exp e1 e2
  | SliceP (p11, e11, e12), SliceP (p21, e21, e22) ->
    eq_path p11 p21 && eq_exp e11 e21 && eq_exp e12 e22
  | DotP (p11, atom1), DotP (p21, atom2) -> eq_path p11 p21 && atom1.it = atom2.it
  | _, _ -> p1.it = p2.it


(* Premises *)

and eq_prem prem1 prem2 =
  match prem1.it, prem2.it with
  | VarPr (id1, t1), VarPr (id2, t2) -> id1.it = id2.it && eq_typ t1 t2
  | RulePr (id1, e1), RulePr (id2, e2) -> id1.it = id2.it && eq_exp e1 e2
  | IfPr e1, IfPr e2 -> eq_exp e1 e2
  | IterPr (prem11, iter1), IterPr (prem21, iter2) ->
    eq_prem prem11 prem21 && eq_iter iter1 iter2
  | _, _ -> prem1.it = prem2.it


(* Grammars *)

and eq_sym g1 g2 =
  match g1.it, g2.it with
  | VarG (id1, args1), VarG (id2, args2) ->
    id1.it = id2.it && eq_list eq_arg args1 args2
  | SeqG gs1, SeqG gs2
  | AltG gs1, AltG gs2 -> eq_nl_list eq_sym gs1 gs2
  | TupG gs1, TupG gs2 -> eq_list eq_sym gs1 gs2
  | RangeG (g11, g12), RangeG (g21, g22) -> eq_sym g11 g21 && eq_sym g12 g22
  | ParenG g11, ParenG g21 -> eq_sym g11 g21
  | IterG (g11, iter1), IterG (g21, iter2) ->
    eq_sym g11 g21 && eq_iter iter1 iter2
  | ArithG e1, ArithG e2 -> eq_exp e1 e2
  | AttrG (e1, g11), AttrG (e2, g21) -> eq_exp e1 e2 && eq_sym g11 g21
  | _, _ -> g1.it = g2.it


(* Definitions *)

and eq_arg a1 a2 =
  match !(a1.it), !(a2.it) with
  | ExpA e1, ExpA e2 -> eq_exp e1 e2
  | TypA t1, TypA t2 -> eq_typ t1 t2
  | GramA g1, GramA g2 -> eq_sym g1 g2
  | _, _ -> false

and eq_param p1 p2 =
  match p1.it, p2.it with
  | ExpP (id1, t1), ExpP (id2, t2) -> id1.it = id2.it && eq_typ t1 t2
  | TypP id1, TypP id2 -> id1.it = id2.it
  | GramP (id1, t1), GramP (id2, t2) -> id1.it = id2.it && eq_typ t1 t2
  | _, _ -> false
