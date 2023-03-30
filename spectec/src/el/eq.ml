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
  | ListN exp1, ListN exp2 -> eq_exp exp1 exp2
  | _, _ -> false


(* Types *)

and eq_typ typ1 typ2 =
  (*
  Printf.printf "[eq] (%s) == (%s)  eq=%b\n%!"
    (Print.string_of_typ typ1) (Print.string_of_typ typ2)
    (typ1.it = typ2.it);
  *)
  typ1.it = typ2.it ||
  match typ1.it, typ2.it with
  | VarT id1, VarT id2 -> id1.it = id2.it
  | TupT typs1, TupT typs2 ->
    eq_list eq_typ typs1 typs2
  | IterT (typ11, iter1), IterT (typ21, iter2) ->
    eq_typ typ11 typ21 && eq_iter iter1 iter2
  | _, _ ->
    false

and eq_nottyp nottyp1 nottyp2 =
  (*
  Printf.printf "[eq] (%s) == (%s)  eq=%b\n%!"
    (Print.string_of_nottyp nottyp1) (Print.string_of_nottyp nottyp2)
    (nottyp1.it = nottyp2.it);
  *)
  nottyp1.it = nottyp2.it ||
  match nottyp1.it, nottyp2.it with
  | TypT typ1, TypT typ2 -> eq_typ typ1 typ2
  | AtomT atom1, AtomT atom2 -> atom1 = atom2
  | SeqT nottyps1, SeqT nottyps2 -> eq_list eq_nottyp nottyps1 nottyps2
  | InfixT (nottyp11, atom1, nottyp12), InfixT (nottyp21, atom2, nottyp22) ->
    eq_nottyp nottyp11 nottyp21 && atom1 = atom2 && eq_nottyp nottyp12 nottyp22
  | BrackT (brack1, nottyp11), BrackT (brack2, nottyp21) ->
    brack1 = brack2 && eq_nottyp nottyp11 nottyp21
  | ParenNT nottyp1, ParenNT nottyp2 -> eq_nottyp nottyp1 nottyp2
  | IterNT (nottyp11, iter1), IterNT (nottyp21, iter2) ->
    eq_nottyp nottyp11 nottyp21 && eq_iter iter1 iter2
  | _, _ ->
    false


(* Expressions *)

and eq_exp exp1 exp2 =
  exp1.it = exp2.it ||
  match exp1.it, exp2.it with
  | VarE id1, VarE id2 -> id1.it = id2.it
  | UnE (unop1, exp11), UnE (unop2, exp21) ->
    unop1 = unop2 && eq_exp exp11 exp21
  | BinE (exp11, binop1, exp12), BinE (exp21, binop2, exp22) ->
    eq_exp exp11 exp21 && binop1 = binop2 && eq_exp exp12 exp22
  | CmpE (exp11, cmpop1, exp12), CmpE (exp21, cmpop2, exp22) ->
    eq_exp exp11 exp21 && cmpop1 = cmpop2 && eq_exp exp12 exp22
  | LenE exp11, LenE exp21 ->
    eq_exp exp11 exp21
  | IdxE (exp11, exp12), IdxE (exp21, exp22)
  | CommaE (exp11, exp12), CommaE (exp21, exp22)
  | CompE (exp11, exp12), CompE (exp21, exp22)
  | FuseE (exp11, exp12), FuseE (exp21, exp22) ->
    eq_exp exp11 exp21 && eq_exp exp12 exp22
  | SliceE (exp11, exp12, exp13), SliceE (exp21, exp22, exp23) ->
    eq_exp exp11 exp21 && eq_exp exp12 exp22 && eq_exp exp13 exp23
  | UpdE (exp11, path1, exp12), UpdE (exp21, path2, exp22)
  | ExtE (exp11, path1, exp12), ExtE (exp21, path2, exp22) ->
    eq_exp exp11 exp21 && eq_path path1 path2 && eq_exp exp12 exp22
  | ParenE (exp11, b1), ParenE (exp21, b2) ->
    eq_exp exp11 exp21 && b1 = b2
  | SeqE exps1, SeqE exps2
  | TupE exps1, TupE exps2 ->
    eq_list eq_exp exps1 exps2
  | StrE fields1, StrE fields2 ->
    eq_nl_list eq_expfield fields1 fields2
  | DotE (exp11, atom1), DotE (exp21, atom2) ->
    eq_exp exp11 exp21 && atom1 = atom2
  | InfixE (exp11, atom1, exp12), InfixE (exp21, atom2, exp22) ->
    eq_exp exp11 exp21 && atom1 = atom2 && eq_exp exp12 exp22
  | BrackE (brack1, exp1), BrackE (brack2, exp2) ->
    brack1 = brack2 && eq_exp exp1 exp2
  | CallE (id1, exp1), CallE (id2, exp2) ->
    id1 = id2 && eq_exp exp1 exp2
  | IterE (exp11, iter1), IterE (exp21, iter2) ->
    eq_exp exp11 exp21 && eq_iter iter1 iter2
  | _, _ ->
    false

and eq_expfield (atom1, exp1) (atom2, exp2) =
  atom1 = atom2 && eq_exp exp1 exp2

and eq_path path1 path2 =
  match path1.it, path2.it with
  | RootP, RootP -> true
  | IdxP (path11, exp1), IdxP (path21, exp2) ->
    eq_path path11 path21 && eq_exp exp1 exp2
  | DotP (path11, atom1), DotP (path21, atom2) ->
    eq_path path11 path21 && atom1 = atom2
  | _, _ ->
    false
