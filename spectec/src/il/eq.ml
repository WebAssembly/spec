open Util.Source
open Ast


(* Helpers *)

let eq_opt eq_x xo1 xo2 =
  match xo1, xo2 with
  | Some x1, Some x2 -> eq_x x1 x2
  | _, _ -> xo1 = xo2

let eq_list eq_x xs1 xs2 =
  List.length xs1 = List.length xs2 && List.for_all2 eq_x xs1 xs2


(* Ids *)

let eq_id i1 i2 =
  i1.it = i2.it


(* Iteration *)

let rec eq_iter iter1 iter2 =
  iter1 = iter2 ||
  match iter1, iter2 with
  | ListN e1, ListN e2 -> eq_exp e1 e2
  | IndexedListN (id1, e1), IndexedListN (id2, e2) ->
    id1.it = id2.it && eq_exp e1 e2
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
  | VarT id1, VarT id2 -> eq_id id1 id2
  | TupT ts1, TupT ts2 -> eq_list eq_typ ts1 ts2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    eq_typ t11 t21 && eq_iter iter1 iter2
  | _, _ ->
    false


(* Expressions *)

and eq_exp e1 e2 =
  e1.it = e2.it ||
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
  | CatE (e11, e12), CatE (e21, e22) -> eq_exp e11 e21 && eq_exp e12 e22
  | SliceE (e11, e12, e13), SliceE (e21, e22, e23) ->
    eq_exp e11 e21 && eq_exp e12 e22 && eq_exp e13 e23
  | UpdE (e11, p1, e12), UpdE (e21, p2, e22)
  | ExtE (e11, p1, e12), ExtE (e21, p2, e22) ->
    eq_exp e11 e21 && eq_path p1 p2 && eq_exp e12 e22
  | TupE es1, TupE es2
  | ListE es1, ListE es2 -> eq_list eq_exp es1 es2
  | StrE efs1, StrE efs2 -> eq_list eq_expfield efs1 efs2
  | DotE (e11, atom1), DotE (e21, atom2) -> eq_exp e11 e21 && atom1 = atom2
  | MixE (op1, e1), MixE (op2, e2) -> op1 = op2 && eq_exp e1 e2
  | CallE (id1, e1), CallE (id2, e2) -> eq_id id1 id2 && eq_exp e1 e2
  | IterE (e11, iter1), IterE (e21, iter2) ->
    eq_exp e11 e21 && eq_iterexp iter1 iter2
  | OptE eo1, OptE eo2 -> eq_opt eq_exp eo1 eo2
  | TheE e1, TheE e2 -> eq_exp e1 e2
  | CaseE (atom1, e1), CaseE (atom2, e2) -> atom1 = atom2 && eq_exp e1 e2
  | SubE (e1, t11, t12), SubE (e2, t21, t22) ->
    eq_exp e1 e2 && eq_typ t11 t21 && eq_typ t12 t22
  | _, _ -> false

and eq_expfield (atom1, e1) (atom2, e2) =
  atom1 = atom2 && eq_exp e1 e2

and eq_path p1 p2 =
  match p1.it, p2.it with
  | RootP, RootP -> true
  | IdxP (p11, e1), IdxP (p21, e2) -> eq_path p11 p21 && eq_exp e1 e2
  | SliceP (p11, e11, e12), SliceP (p21, e21, e22) ->
    eq_path p11 p21 && eq_exp e11 e21 && eq_exp e12 e22
  | DotP (p11, atom1), DotP (p21, atom2) -> eq_path p11 p21 && atom1 = atom2
  | _, _ -> false

and eq_iterexp (iter1, ids1) (iter2, ids2) =
  eq_iter iter1 iter2 && eq_list eq_id ids1 ids2

let rec eq_prem prem1 prem2 =
  prem1.it = prem2.it ||
  match prem1.it, prem2.it with
  | RulePr (id1, op1, e1), RulePr (id2, op2, e2) ->
    eq_id id1 id2 && op1 = op2 && eq_exp e1 e2
  | IfPr e1, IfPr e2 -> eq_exp e1 e2
  | ElsePr, ElsePr -> true
  | IterPr (prem1, e1), IterPr (prem2, e2) ->
    eq_prem prem1 prem2 && eq_iterexp e1 e2
  | _, _ -> false
