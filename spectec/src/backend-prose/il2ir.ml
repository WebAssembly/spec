open Util.Source
open Il

(*let translate_expr e = match e.it with
  | Ast.VarE s -> Ir.NameE (N s.it)
  | Ast.ParenE ({ it = SeqE [{it=AtomE (Atom "\"CONST\"");_}]; _ }, false) -> Ir.YetE ""
  | _ -> Print.structured_string_of_exp e |> failwith*)

(** Translate il to ir **)

(* `Ast.exp` -> `Ir.expr` *)
let translate_expr exp = match exp.it with
  | _ -> Ir.YetE (Print.string_of_exp exp)

(* `Ast.exp` -> `Ir.AssertI` *)
let insert_assert exp = match exp.it with
  | Ast.CaseE (
    Atom "CONST",
    { it = TupE({ it = CaseE (Atom "I32", _, _); _ } :: _); _ },
    _
  ) ->
      Ir.AssertI
        "Due to validation, a value of value type i32 is on the top of the stack"
  | _ ->
      Ir.AssertI "Yet"
      (*Ir.AssertI "Due to validation, a value is on the top of the stack"*)

(* `Ast.exp` -> `Ir.instr list` *)
let rec lhs2pop exp = match exp.it with
  (* TODO: Handle bubble-up semantics *)
  | Ast.ListE exps ->
      List.rev exps
      |> List.tl
      |> List.fold_left
        (fun acc e -> insert_assert e :: Ir.PopI (Some (translate_expr e)) :: acc)
        []
  | Ast.CatE (iterexp, listexp) ->
      Ir.PopI (Some (translate_expr iterexp)) :: lhs2pop listexp
  | _ -> failwith "Unreachable"

(* `Ast.prem list` -> `Ir.instr list` *)
let prem2let prems =
  prems
  |> List.filter_map
    (function
      | { it = Ast.IfPr { it = Ast.CmpE (Ast.EqOp, exp1, exp2); _ }; _ } ->
          Some (Ir.LetI (translate_expr exp1, translate_expr exp2))
      | _ -> None)

(* `Ast.CaseE | Ast.SubE` -> `Ir.instr list` *)
let casesub2instrs exp = match exp.it with
  | Ast.CaseE (Atom "TRAP", _, _) -> [Ir.TrapI]
  | Ast.CaseE (Atom atomid, _, _)
    when atomid = "CONST" || atomid = "REF.FUNC_ADDR" ->
      [Ir.PushI (translate_expr exp)]
  | Ast.CaseE (Atom "CALL_ADDR", addrexp, _) ->
      [Ir.InvokeI (translate_expr addrexp)]
  | Ast.CaseE (Atom "FRAME_", tupexp, _) ->
      (* TODO: Insert current frame instruction at the top *)
      [Ir.LetI (Ir.NameE (Ir.N "F"), Ir.FrameE); Ir.PushI (translate_expr tupexp)]
  | Ast.CaseE (Atom "LABEL_", _, _) ->
      (* TODO *)
      [ Ir.LetI (Ir.NameE (Ir.N "L"), Ir.YetE ""); Ir.EnterI ("", YetE "") ]
  | Ast.CaseE (Atom atomid, argexp, _)
    when String.starts_with ~prefix: "TABLE." atomid ||
    atomid = "BLOCK" || atomid = "BR" || atomid = "LOCAL.SET" || atomid = "RETURN" ->
      (match argexp.it with
        | Ast.TupE (exps) ->
            let argexprs = List.map translate_expr exps in
            [Ir.ExecuteI (atomid, argexprs)]
        | _ -> [Ir.ExecuteI (atomid, [translate_expr argexp])])
  | Ast.SubE (_, _, _) -> [Ir.PushI (YetE (Print.string_of_exp exp))]
  | _ -> failwith "Unreachable"

(* `Ast.exp` -> `Ir.instr list` *)
let rec rhs2instrs exp =
  match exp.it with
    | Ast.MixE (
      [[]; [Ast.Semicolon]; [Ast.Star]],
      (* z' ; instr'* *)
      { it = TupE ([callexp; rhs]); _ }
    ) ->
      (* TODO: handle mutation *)
      let yet_instr = Ir.YetI ("Perform " ^ Print.string_of_exp callexp) in
      let push_instrs = rhs2instrs rhs in
      yet_instr :: push_instrs
    | Ast.ListE (exps) -> List.map casesub2instrs exps |> List.flatten
    | Ast.IterE (_, _) -> [Ir.PushI (YetE (Print.string_of_exp exp))]
    | Ast.CatE (exp1, exp2) ->
        rhs2instrs exp1 @ rhs2instrs exp2
    | _ -> failwith "Unreachable"

(* `Ast.prem list` -> `Ir.cond` *)
let prem2cond _prems = Ir.YetC ""

(* `reduction_group list` -> `Backend-prose.Ir.Program` *)
let reduction_group2program acc reduction_group =
  let (name, lhs, _, _) = List.hd reduction_group in

  (* DEBUG *)

  let pop_instrs = match lhs.it with
    (* z; lhs *)
    | Ast.MixE (
      [[]; [Ast.Semicolon]; [Ast.Star]],
      {it=Ast.TupE ({it=Ast.VarE {it="z"; _ }; _ } :: exp :: []); _}
    ) -> lhs2pop exp
    | _ -> lhs2pop lhs in

  let instrs = match reduction_group with
    (* one reduction rule: assignment *)
    | [(_, _, rhs, prems)] ->
        let let_instrs = prem2let prems in
        let push_instrs = rhs2instrs rhs in
        let_instrs @ push_instrs
    (* multiple reduction rules: conditions *)
    | _ ->
        List.map
          (fun (_, _, rhs, prems) ->
            let cond = prem2cond prems in
            let rhs_instrs = rhs2instrs rhs in
            Ir.IfI(cond, rhs_instrs, [])
          )
          reduction_group in

  Ir.Program (name, pop_instrs @ instrs) :: acc

(** Temporarily convert `Ast.RuleD` into `reduction_relation` **)

(* extract rules except Step/pure and Step/read *)
let extract_rules acc def = match def.it with
  | Ast.RelD (id, _, _, rules, _)
    when String.starts_with ~prefix:"Step" id.it ->
      let filter_context =
        (fun rule ->
          let Ast.RuleD (ruleid, _, _, _, _) = rule.it in
          ruleid.it <> "pure" && ruleid.it <> "read") in
      (List.filter filter_context rules) :: acc
  | _ -> acc

type reduction_group = (string * Ast.exp * Ast.exp * Ast.premise list) list

let name_of_rule rule = 
  let Ast.RuleD (id1, _, _, _, _) = rule.it in
  String.split_on_char '-' id1.it |> List.hd

let rule2tup rule =
  let Ast.RuleD (id, _, _, exp, prems) = rule.it in
  match exp.it with
    | Ast.TupE (lhs :: rhs :: []) -> (id.it, lhs, rhs, prems)
    | _ -> failwith "Unreachable"

(* group reduction rules that have same name *)
let rec group = function
  | [] -> []
  | h :: t ->
    let (reduction_group, rem) =
      List.partition
        (fun rule -> name_of_rule h = name_of_rule rule)
        t in
    List.map rule2tup (h :: reduction_group) :: (group rem)

(** Entry **)

(* `Ast.script` -> `Ir.Program` *)
let translate il =
  let rules = List.fold_left extract_rules [] il |> List.flatten in
  let reduction_groups: reduction_group list = group rules in

  List.fold_left reduction_group2program [] reduction_groups
