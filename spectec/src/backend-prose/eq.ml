open Prose

let eq_list eq l1 l2 =
  List.length l1 = List.length l2
  && List.for_all2 eq l1 l2

let eq_cmpop = (=)

let eq_expr = Al.Eq.eq_expr

let rec eq_stmt i1 i2 =
  match (i1, i2) with
  | LetS (e11, e12), LetS (e21, e22) ->
      eq_expr e11 e21
      && eq_expr e12 e22
  | CmpS (e11, cmp1, e12), CmpS (e21, cmp2, e22) ->
      eq_expr e11 e21
      && eq_cmpop cmp1 cmp2
      && eq_expr e12 e22
  | IsValidS (opt1, e11, l1), IsValidS (opt2, e21, l2) ->
      Option.equal eq_expr opt1 opt2
      && eq_expr e11 e21
      && eq_list eq_expr l1 l2
  | MatchesS (e11, e12), MatchesS (e21, e22) ->
      eq_expr e11 e21
      && eq_expr e12 e22
  | IsConstS (opt1, e11), IsConstS (opt2, e21) ->
      Option.equal eq_expr opt1 opt2
      && eq_expr e11 e21
  | IsDefinedS e1, IsDefinedS e2 ->
      eq_expr e1 e2
  | IfS (e11, il1), IfS (e21, il2) ->
      eq_expr e11 e21
      && List.for_all2 eq_stmt il1 il2
  | ForallS (l1, il1), ForallS (l2, il2) ->
      eq_list (fun (e11, e12) (e21, e22) -> eq_expr e11 e21 && eq_expr e12 e22) l1 l2
      && eq_list eq_stmt il1 il2
  | EitherS (il1), EitherS (il2) ->
      eq_list (fun l1 l2 -> eq_list eq_stmt l1 l2) il1 il2
  | RelS (s1, el1), RelS (s2, el2) ->
    s1 = s2
    && eq_list eq_expr el1 el2
  | YetS s1, YetS s2 ->
    s1 = s2
  | _, _ -> i1 = i2
