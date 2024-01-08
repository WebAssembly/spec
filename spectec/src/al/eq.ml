open Ast
open Util.Source

let rec eq_instr i1 i2 =
  match i1.it, i2.it with
  | IfI (c1, il11, il12), IfI (c2, il21, il22) ->
    c1 = c2 &&
    eq_instrs il11 il21 && 
    eq_instrs il12 il22
  | EitherI (il11, il12), EitherI (il21, il22) ->
    eq_instrs il11 il21 && 
    eq_instrs il12 il22
  | EnterI (e11, e12, il1), EnterI (e21, e22, il2) ->
    e11 = e21 && e12 = e22 &&
    eq_instrs il1 il2
  | AssertI c1, AssertI c2 -> c1 = c2
  | PushI e1, PushI e2
  | PopI e1, PopI e2
  | PopAllI e1, PopAllI e2
  | ExecuteI e1, ExecuteI e2
  | ExecuteSeqI e1, ExecuteSeqI e2 -> e1 = e2
  | LetI (e11, e12), LetI (e21, e22)
  | AppendI (e11, e12), AppendI (e21, e22) ->
    e11 = e21 && e12 = e22
  | ReturnI e_opt1, ReturnI e_opt2 -> e_opt1 = e_opt2
  | PerformI (id1, el1), PerformI (id2, el2) ->
    id1 = id2 && el1 = el2
  | ReplaceI (e11, p1, e12), ReplaceI (e21, p2, e22) ->
    e11 = e21 && e12 = e22 && p1 = p2
  | OtherwiseI il1, OtherwiseI il2 ->
    eq_instrs il1 il2
  | YetI s1, YetI s2 -> s1 = s2
  | TrapI, TrapI | ExitI, ExitI | NopI, NopI -> true
  | _ -> false

and eq_instrs il1 il2 =
  List.length il1 = List.length il2 && List.for_all2 eq_instr il1 il2
