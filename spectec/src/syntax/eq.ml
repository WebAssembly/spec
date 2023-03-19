open Ast
open Source


(* Helpers *)

let eq_opt eq_x xo1 xo2 =
  match xo1, xo2 with
  | Some x1, Some x2 -> eq_x x1 x2
  | _, _ -> xo1 = xo2

let eq_list eq_x xs1 xs2 =
  List.length xs1 = List.length xs2 && List.for_all2 eq_x xs1 xs2


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
  | SeqT typs1, SeqT typs2
  | TupT typs1, TupT typs2 ->
    eq_list eq_typ typs1 typs2
  | StrT fields1, StrT fields2 -> eq_list eq_typfield fields1 fields2
  | RelT (typ11, relop1, typ12), RelT (typ21, relop2, typ22) ->
    eq_typ typ11 typ21 && relop1 = relop2 && eq_typ typ12 typ22
  | BrackT (brackop1, typs1), BrackT (brackop2, typs2) ->
    brackop1 = brackop2 && eq_list eq_typ typs1 typs2
  | IterT (typ11, iter1), IterT (typ21, iter2) ->
    eq_typ typ11 typ21 && eq_iter iter1 iter2
  | _, _ ->
    false

and eq_typfield (atom1, typ1, _) (atom2, typ2, _) =
  atom1 = atom2 && eq_typ typ1 typ2


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
  | CatE (exp11, exp12), CatE (exp21, exp22)
  | FuseE (exp11, exp12), FuseE (exp21, exp22) ->
    eq_exp exp11 exp21 && eq_exp exp12 exp22
  | SliceE (exp11, exp12, exp13), SliceE (exp21, exp22, exp23) ->
    eq_exp exp11 exp21 && eq_exp exp12 exp22 && eq_exp exp13 exp23
  | UpdE (exp11, path1, exp12), UpdE (exp21, path2, exp22)
  | ExtE (exp11, path1, exp12), ExtE (exp21, path2, exp22) ->
    eq_exp exp11 exp21 && eq_path path1 path2 && eq_exp exp12 exp22
  | SeqE exps1, SeqE exps2
  | TupE exps1, TupE exps2
  | ListE exps1, ListE exps2 ->
    eq_list eq_exp exps1 exps2
  | StrE fields1, StrE fields2 ->
    eq_list eq_expfield fields1 fields2
  | DotE (exp11, atom1), DotE (exp21, atom2) ->
    eq_exp exp11 exp21 && atom1 = atom2
  | RelE (exp11, relop1, exp12), RelE (exp21, relop2, exp22) ->
    eq_exp exp11 exp21 && relop1 = relop2 && eq_exp exp12 exp22
  | BrackE (brackop1, exps1), BrackE (brackop2, exps2) ->
    brackop1 = brackop2 && eq_list eq_exp exps1 exps2
  | CallE (id1, exp1), CallE (id2, exp2) ->
    id1 = id2 && eq_exp exp1 exp2
  | IterE (exp11, iter1), IterE (exp21, iter2) ->
    eq_exp exp11 exp21 && eq_iter iter1 iter2
  | OptE expo1, OptE expo2 -> eq_opt eq_exp expo1 expo2
  | CaseE (atom1, exps1), CaseE (atom2, exps2) ->
    atom1 = atom2 && eq_list eq_exp exps1 exps2
  | SubE (exp1, typ11, typ12), SubE (exp2, typ21, typ22) ->
    eq_exp exp1 exp2 && eq_typ typ11 typ21 && eq_typ typ12 typ22
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
