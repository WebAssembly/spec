open Util.Source
open Ast


(* Helpers *)

let eq_list eq_x xs1 xs2 =
  List.length xs1 = List.length xs2 && List.for_all2 eq_x xs1 xs2

let eq_nl_elem eq_x e1 e2 =
  match e1, e2 with
  | Elem x1, Elem x2 -> eq_x x1 x2
  | _, _ -> false

let eq_nl_list eq_x xs1 xs2 = eq_list (eq_nl_elem eq_x) xs1 xs2


(* Iteration *)

let rec eq_iter iter1 iter2 =
  iter1 = iter2 ||
  match iter1, iter2 with
  | ListN (e1, None), ListN (e2, None) -> eq_exp e1 e2
  | ListN (e1, Some id1), ListN (e2, Some id2) ->
    eq_exp e1 e2 && id1.it = id2.it
  | _, _ -> false


(* Types *)

and eq_typ t1 t2 =
  (*
  Printf.printf "[eq] (%s) == (%s)  eq=%b\n%!"
    (Print.string_of_typ t1) (Print.string_of_typ t2)
    (t1.it = t2.it);
  *)
  t1.it = t2.it ||
  match t1.it, t2.it with
  | VarT id1, VarT id2 -> id1.it = id2.it
  | TupT ts1, TupT ts2 -> eq_list eq_typ ts1 ts2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    eq_typ t11 t21 && eq_iter iter1 iter2
  | AtomT atom1, AtomT atom2 -> atom1 = atom2
  | SeqT ts1, SeqT ts2 -> eq_list eq_typ ts1 ts2
  | InfixT (t11, atom1, t12), InfixT (t21, atom2, t22) ->
    eq_typ t11 t21 && atom1 = atom2 && eq_typ t12 t22
  | BrackT (brack1, t11), BrackT (brack2, t21) ->
    brack1 = brack2 && eq_typ t11 t21
  | _, _ ->
    false


(* Expressions *)

and eq_exp e1 e2 =
  e1.it = e2.it ||
  match e1.it, e2.it with
  | VarE id1, VarE id2 -> id1.it = id2.it
  | UnE (op1, e11), UnE (op2, e21) -> op1 = op2 && eq_exp e11 e21
  | BinE (e11, op1, e12), BinE (e21, op2, e22) ->
    eq_exp e11 e21 && op1 = op2 && eq_exp e12 e22
  | CmpE (e11, op1, e12), CmpE (e21, op2, e22) ->
    eq_exp e11 e21 && op1 = op2 && eq_exp e12 e22
  | LenE e11, LenE e21 -> eq_exp e11 e21
  | IdxE (e11, e12), IdxE (e21, e22)
  | CommaE (e11, e12), CommaE (e21, e22)
  | CompE (e11, e12), CompE (e21, e22)
  | FuseE (e11, e12), FuseE (e21, e22)
  | ElementsOfE (e11, e12), ElementsOfE (e21, e22)
  | ListBuilderE (e11, e12), ListBuilderE (e21, e22) ->
    eq_exp e11 e21 && eq_exp e12 e22
  | SliceE (e11, e12, e13), SliceE (e21, e22, e23) ->
    eq_exp e11 e21 && eq_exp e12 e22 && eq_exp e13 e23
  | UpdE (e11, p1, e12), UpdE (e21, p2, e22)
  | ExtE (e11, p1, e12), ExtE (e21, p2, e22) ->
    eq_exp e11 e21 && eq_path p1 p2 && eq_exp e12 e22
  | ParenE (e11, b1), ParenE (e21, b2) -> eq_exp e11 e21 && b1 = b2
  | SeqE es1, SeqE es2
  | TupE es1, TupE es2 -> eq_list eq_exp es1 es2
  | StrE efs1, StrE efs2 -> eq_nl_list eq_expfield efs1 efs2
  | DotE (e11, atom1), DotE (e21, atom2) -> eq_exp e11 e21 && atom1 = atom2
  | InfixE (e11, atom1, e12), InfixE (e21, atom2, e22) ->
    eq_exp e11 e21 && atom1 = atom2 && eq_exp e12 e22
  | BrackE (brack1, e1), BrackE (brack2, e2) -> brack1 = brack2 && eq_exp e1 e2
  | CallE (id1, e1), CallE (id2, e2) -> id1 = id2 && eq_exp e1 e2
  | IterE (e11, iter1), IterE (e21, iter2) ->
    eq_exp e11 e21 && eq_iter iter1 iter2
  | _, _ ->
    false

and eq_expfield (atom1, e1) (atom2, e2) =
  atom1 = atom2 && eq_exp e1 e2

and eq_path p1 p2 =
  match p1.it, p2.it with
  | RootP, RootP -> true
  | IdxP (p11, e1), IdxP (p21, e2) -> eq_path p11 p21 && eq_exp e1 e2
  | SliceP (p11, e11, e12), SliceP (p21, e21, e22) ->
    eq_path p11 p21 && eq_exp e11 e21 && eq_exp e12 e22
  | DotP (p11, atom1), DotP (p21, atom2) -> eq_path p11 p21 && atom1 = atom2
  | _, _ ->
    false
