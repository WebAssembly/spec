open Ast
open Util
open Source
open Xl

let eq_list eq l1 l2 =
  List.length l1 = List.length l2 && List.for_all2 eq l1 l2
let eq_pair eqx eqy (x1, y1) (x2, y2) =
  eqx x1 x2 && eqy y1 y2

let eq_id = (=)

let rec eq_expr e1 e2 =
  match e1.it, e2.it with
  | VarE id1, VarE id2 -> eq_id id1 id2
  | NumE n1, NumE n2 -> n1 = n2
  | BoolE b1, BoolE b2 -> b1 = b2
  | CvtE (e1, t11, t12), CvtE (e2, t21, t22) -> eq_expr e1 e2 && t11 = t21 && t12 = t22
  | UnE (unop1, e1), UnE (unop2, e2) -> unop1 = unop2 && eq_expr e1 e2
  | BinE (binop1, e11, e12), BinE (binop2, e21, e22) ->
    binop1 = binop2 && eq_expr e11 e21 && eq_expr e12 e22
  | AccE (e1, p1), AccE (e2, p2) -> eq_expr e1 e2 && eq_path p1 p2
  | UpdE (e11, pl1, e12), UpdE (e21, pl2, e22) ->
    eq_expr e11 e21 && eq_paths pl1 pl2 && eq_expr e12 e22
  | ExtE (e11, pl1, e12, d1), ExtE (e21, pl2, e22, d2) ->
    eq_expr e11 e21 && eq_paths pl1 pl2 && eq_expr e12 e22 && d1 = d2
  | StrE r1, StrE r2 -> eq_expr_record r1 r2
  | CompE (e11, e12), CompE (e21, e22) -> eq_expr e11 e21 && eq_expr e12 e22
  | CatE (e11, e12), CatE (e21, e22) -> eq_expr e11 e21 && eq_expr e12 e22
  | MemE (e11, e12), MemE (e21, e22) -> eq_expr e11 e21 && eq_expr e12 e22
  | LenE e1, LenE e2 -> eq_expr e1 e2
  | TupE el1, TupE el2 -> eq_exprs el1 el2
  | CaseE (op1, el1), CaseE (op2, el2) -> Mixop.eq op1 op2 && eq_exprs el1 el2
  | CallE (i1, al1), CallE (i2, al2) -> i1 = i2 && eq_args al1 al2
  | InvCallE (i1, nl1, al1), InvCallE (i2, nl2, al2) ->
    i1 = i2 && List.for_all2 (=) nl1 nl2 && eq_args al1 al2
  | IterE (e1, ie1), IterE (e2, ie2) ->
    eq_expr e1 e2 && eq_iterexp ie1 ie2
  | OptE eo1, OptE eo2 -> eq_expr_opt eo1 eo2
  | ListE el1, ListE el2 -> eq_exprs el1 el2
  | LiftE e1, LiftE e2 -> eq_expr e1 e2
  | GetCurStateE, GetCurStateE -> true
  | GetCurContextE i1, GetCurContextE i2 -> Option.equal (=) i1 i2
  | ChooseE e1, ChooseE e2 -> eq_expr e1 e2
  | IsCaseOfE (e1, a1), IsCaseOfE (e2, a2) -> eq_expr e1 e2 && Atom.eq a1 a2
  | IsValidE e1, IsValidE e2 -> eq_expr e1 e2
  | ContextKindE a1, ContextKindE a2 -> Atom.eq a1 a2
  | IsDefinedE e1, IsDefinedE e2 -> eq_expr e1 e2
  | MatchE (e11, e12), MatchE (e21, e22) -> eq_expr e11 e21 && eq_expr e12 e22
  | HasTypeE (e1, t1), HasTypeE (e2, t2) -> eq_expr e1 e2 && Il.Eq.eq_typ t1 t2
  | TopValueE eo1, TopValueE eo2 -> eq_expr_opt eo1 eo2
  | TopValuesE e1, TopValuesE e2 -> eq_expr e1 e2
  | SubE (i1, t1), SubE (i2, t2) -> i1 = i2 && Il.Eq.eq_typ t1 t2
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
      (fun (a1, e1) (a2, e2) -> Atom.eq a1 a2 && eq_expr e1 e2) l1 l2

and eq_exprs el1 el2 = eq_list eq_expr el1 el2


and eq_iter i1 i2 =
  match i1, i2 with
  | Opt, Opt -> true
  | List, List -> true
  | List1, List1 -> true
  | ListN (e1, id_opt1), ListN (e2, id_opt2) -> eq_expr e1 e2 && Option.equal eq_id id_opt1 id_opt2
  | _ -> false


and eq_path p1 p2 =
  match p1.it, p2.it with
  | IdxP e1, IdxP e2 -> eq_expr e1 e2
  | SliceP (e11, e12), SliceP (e21, e22) -> eq_expr e11 e21 && eq_expr e12 e22
  | DotP a1, DotP a2 -> Atom.eq a1 a2
  | _ -> false

and eq_paths pl1 pl2 = eq_list eq_path pl1 pl2


and eq_arg a1 a2 =
  match a1.it, a2.it with
  | ExpA e1, ExpA e2 -> eq_expr e1 e2
  | TypA typ1, TypA typ2 -> Il.Eq.eq_typ typ1 typ2
  | DefA id1, DefA id2 -> id1 = id2
  | _ -> false

and eq_args al1 al2 = eq_list eq_arg al1 al2


and eq_iterexp (iter1, xes1) (iter2, xes2) =
  eq_iter iter1 iter2 && eq_list (eq_pair eq_id eq_expr) xes1 xes2


let rec eq_instr i1 i2 =
  match i1.it, i2.it with
  | IfI (e1, il11, il12), IfI (e2, il21, il22) ->
    eq_expr e1 e2 && eq_instrs il11 il21 && eq_instrs il12 il22
  | EitherI (il11, il12), EitherI (il21, il22) ->
    eq_instrs il11 il21 && eq_instrs il12 il22
  | EnterI (e11, e12, il1), EnterI (e21, e22, il2) ->
    eq_expr e11 e21 && eq_expr e12 e22 && eq_instrs il1 il2
  | AssertI e1, AssertI e2
  | ThrowI e1, ThrowI e2
  | PushI e1, PushI e2
  | PopI e1, PopI e2
  | PopAllI e1, PopAllI e2 -> eq_expr e1 e2
  | LetI (e11, e12), LetI (e21, e22) -> eq_expr e11 e21 && eq_expr e12 e22
  | TrapI, TrapI
  | FailI, FailI
  | NopI, NopI -> true
  | ReturnI e_opt1, ReturnI e_opt2 -> eq_expr_opt e_opt1 e_opt2
  | ExecuteI e1, ExecuteI e2
  | ExecuteSeqI e1, ExecuteSeqI e2 -> eq_expr e1 e2
  | PerformI (id1, al1), PerformI (id2, al2) -> eq_id id1 id2 && eq_args al1 al2
  | ExitI a1, ExitI a2 -> Atom.eq a1 a2
  | ReplaceI (e11, p1, e12), ReplaceI (e21, p2, e22) ->
    eq_expr e11 e21 && eq_path p1 p2 && eq_expr e12 e22
  | AppendI (e11, e12), AppendI (e21, e22) -> eq_expr e11 e21 && eq_expr e12 e22
  | FieldWiseAppendI (e11, e12),FieldWiseAppendI (e21, e22) -> eq_expr e11 e21 && eq_expr e12 e22
  | OtherwiseI il1, OtherwiseI il2 -> eq_instrs il1 il2
  | YetI s1, YetI s2 -> s1 = s2
  | _ -> false

and eq_instrs il1 il2 = eq_list eq_instr il1 il2


let eq_algos al1 al2 =
  match al1.it, al2.it with
  | RuleA (a1, an1, al1, il1), RuleA (a2, an2, al2, il2) ->
    Atom.eq a1 a2 && an1 = an2 && eq_args al1 al2 && eq_instrs il1 il2
  | FuncA (i1, al1, il1), FuncA (i2, al2, il2) ->
    i1 = i2 && eq_args al1 al2 && eq_instrs il1 il2
  | _ -> false
