open Prose

let eq_list eq l1 l2 =
  List.length l1 = List.length l2
  && List.for_all2 eq l1 l2

let eq_cmpop = (=)

let eq_expr = Al.Eq.eq_expr

let rec eq_instr i1 i2 =
  match (i1, i2) with
  | LetI (e11, e12), LetI (e21, e22) ->
      eq_expr e11 e21
      && eq_expr e12 e22
  | CmpI (e11, cmp1, e12), CmpI (e21, cmp2, e22) ->
      eq_expr e11 e21
      && eq_cmpop cmp1 cmp2
      && eq_expr e12 e22
  | MemI (e11, e12), MemI (e21, e22) ->
      eq_expr e11 e21 && eq_expr e12 e22
  | IsValidI (opt1, e11, l1), IsValidI (opt2, e21, l2) ->
      Option.equal eq_expr opt1 opt2
      && eq_expr e11 e21
      && eq_list eq_expr l1 l2
  | MatchesI (e11, e12), MatchesI (e21, e22) ->
      eq_expr e11 e21
      && eq_expr e12 e22
  | IsConstI (opt1, e11), IsConstI (opt2, e21) ->
      Option.equal eq_expr opt1 opt2
      && eq_expr e11 e21
  | IfI (e11, il1), IfI (e21, il2) ->
      eq_expr e11 e21
      && List.for_all2 eq_instr il1 il2
  | ForallI (l1, il1), ForallI (l2, il2) ->
      eq_list (fun (e11, e12) (e21, e22) -> eq_expr e11 e21 && eq_expr e12 e22) l1 l2
      && eq_list eq_instr il1 il2
  | EquivI (e11, e12), EquivI (e21, e22) ->
      eq_expr e11 e21
      && eq_expr e12 e22
  | EitherI (il1), EitherI (il2) ->
      eq_list (fun l1 l2 -> eq_list eq_instr l1 l2) il1 il2
  | _, _ -> i1 = i2
