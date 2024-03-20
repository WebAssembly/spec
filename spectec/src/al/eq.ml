open Ast
open Util
open Source

let rec eq_expr e1 e2 =
  match e1.it, e2.it with
  | VarE id1, VarE id2 -> id1 = id2
  | NumE n1, NumE n2 -> n1 = n2
  | BoolE b1, BoolE b2 -> b1 = b2
  | UnE (unop1, e1), UnE (unop2, e2) ->
      unop1 = unop2 &&
      eq_expr e1 e2
  | BinE (binop1, e11, e12), BinE (binop2, e21, e22) ->
      binop1 = binop2 &&
      eq_expr e11 e21 &&
      eq_expr e12 e22
  | AccE (e1, p1), AccE (e2, p2) ->
      eq_expr e1 e2 &&
      eq_path p1 p2
  | UpdE (e11, pl1, e12), UpdE (e21, pl2, e22) ->
      eq_expr e11 e21 &&
      eq_paths pl1 pl2 &&
      eq_expr e12 e22
  | ExtE (e11, pl1, e12, d1), ExtE (e21, pl2, e22, d2) ->
      eq_expr e11 e21 &&
      eq_paths pl1 pl2 &&
      eq_expr e12 e22 &&
      d1 = d2
  | StrE r1, StrE r2 -> eq_expr_record r1 r2
  | CatE (e11, e12), CatE (e21, e22) ->
      eq_expr e11 e21 &&
      eq_expr e12 e22
  | LenE e1, LenE e2 -> eq_expr e1 e2
  | TupE el1, TupE el2 -> eq_exprs el1 el2
  | CaseE (a1, el1), CaseE (a2, el2) ->
      a1 = a2 &&
      eq_exprs el1 el2
  | CallE (i1, el1), CallE (i2, el2) ->
      i1 = i2 &&
      eq_exprs el1 el2
  | IterE (e1, il1, it1), IterE (e2, il2, it2) ->
      eq_expr e1 e2 &&
      il1 = il2 &&
      it1 = it2
  | OptE eo1, OptE eo2 -> eq_expr_opt eo1 eo2
  | ListE el1, ListE el2 -> eq_exprs el1 el2
  | InfixE (e11, a1, e12), InfixE (e21, a2, e22) ->
      eq_expr e11 e21 &&
      a1 = a2 &&
      eq_expr e12 e22
  | ArityE e1, ArityE e2 -> eq_expr e1 e2
  | FrameE (eo1, e1), FrameE (eo2, e2) ->
      eq_expr_opt eo1 eo2 &&
      eq_expr e1 e2
  | LabelE (e11, e12), LabelE (e21, e22) ->
      eq_expr e11 e21 &&
      eq_expr e12 e22
  | GetCurFrameE, GetCurFrameE
  | GetCurLabelE, GetCurLabelE
  | GetCurContextE, GetCurContextE -> true
  | ContE e1, ContE e2 -> eq_expr e1 e2
  | IsCaseOfE (e1, a1), IsCaseOfE (e2, a2) ->
      eq_expr e1 e2 &&
      a1 = a2
  | IsValidE e1, IsValidE e2 -> eq_expr e1 e2
  | ContextKindE (a1, e1), ContextKindE (a2, e2) ->
      a1 = a2 &&
      eq_expr e1 e2
  | IsDefinedE e1, IsDefinedE e2 -> eq_expr e1 e2
  | MatchE (e11, e12), MatchE (e21, e22) ->
      eq_expr e11 e21 &&
      eq_expr e12 e22
  | HasTypeE (e1, t1), HasTypeE (e2, t2) ->
      eq_expr e1 e2 &&
      t1 = t2
  | TopLabelE, TopLabelE
  | TopFrameE, TopFrameE -> true
  | TopValueE eo1, TopValueE eo2 -> eq_expr_opt eo1 eo2
  | TopValuesE e1, TopValuesE e2 -> eq_expr e1 e2
  | SubE (i1, t1), SubE (i2, t2) -> i1 = i2 && t1 = t2
  | YetE s1, YetE s2 -> s1 = s2
  | _ -> false

and eq_expr_opt eo1 eo2 =
  match eo1, eo2 with
  | Some e1, Some e2 -> eq_expr e1 e2
  | None, None -> true
  | _ -> false

and eq_expr_record r1 r2 =
  let l1 = Record.to_list r1 in
  let l2 = Record.to_list r2 in
  List.length l1 = List.length l2 &&
  List.for_all2
    (fun (a1, e1) (a2, e2) ->
      a1 = a2 &&
      eq_expr !e1 !e2)
    l1 l2

and eq_exprs el1 el2 =
  List.length el1 = List.length el2 && List.for_all2 eq_expr el1 el2


and eq_path p1 p2 =
  match p1.it, p2.it with
  | IdxP e1, IdxP e2 -> eq_expr e1 e2
  | SliceP (e11, e12), SliceP (e21, e22) ->
      eq_expr e11 e21 &&
      eq_expr e12 e22
  | DotP a1, DotP a2 -> a1 = a2
  | _ -> false

and eq_paths pl1 pl2 =
  List.length pl1 = List.length pl2 && List.for_all2 eq_path pl1 pl2


and eq_instr i1 i2 =
  match i1.it, i2.it with
  | IfI (e1, il11, il12), IfI (e2, il21, il22) ->
    eq_expr e1 e2 &&
    eq_instrs il11 il21 &&
    eq_instrs il12 il22
  | EitherI (il11, il12), EitherI (il21, il22) ->
    eq_instrs il11 il21 &&
    eq_instrs il12 il22
  | EnterI (e11, e12, il1), EnterI (e21, e22, il2) ->
    eq_expr e11 e21 &&
    eq_expr e12 e22 &&
    eq_instrs il1 il2
  | AssertI e1, AssertI e2
  | PushI e1, PushI e2
  | PopI e1, PopI e2
  | PopAllI e1, PopAllI e2 -> eq_expr e1 e2
  | LetI (e11, e12), LetI (e21, e22) ->
    eq_expr e11 e21 &&
    eq_expr e12 e22
  | TrapI, TrapI
  | NopI, NopI -> true
  | ReturnI e_opt1, ReturnI e_opt2 -> eq_expr_opt e_opt1 e_opt2
  | ExecuteI e1, ExecuteI e2
  | ExecuteSeqI e1, ExecuteSeqI e2 -> eq_expr e1 e2
  | PerformI (id1, el1), PerformI (id2, el2) ->
    id1 = id2 &&
    eq_exprs el1 el2
  | ExitI, ExitI -> true
  | ReplaceI (e11, p1, e12), ReplaceI (e21, p2, e22) ->
    eq_expr e11 e21 &&
    eq_path p1 p2 &&
    eq_expr e12 e22
  | AppendI (e11, e12), AppendI (e21, e22) ->
    eq_expr e11 e21 &&
    eq_expr e12 e22
  | OtherwiseI il1, OtherwiseI il2 -> eq_instrs il1 il2
  | YetI s1, YetI s2 -> s1 = s2
  | _ -> false

and eq_instrs il1 il2 =
  List.length il1 = List.length il2 && List.for_all2 eq_instr il1 il2
