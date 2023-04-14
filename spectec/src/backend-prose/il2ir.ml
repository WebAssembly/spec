open Il
open Printf
open Util.Source

let gen_fail_msg_of_exp exp =
  Print.string_of_exp exp
  |> sprintf "Invalid expression `%s` to be IR %s."

let gen_fail_msg_of_prem prem =
  Print.string_of_prem prem
  |> sprintf "Invalid premise `%s` to be IR %s."

(** Translate `Ast.exp` **)

(* `Ast.exp` -> `Ir.name *)
let rec exp2name exp = match exp.it with
  | Ast.VarE id -> Ir.N id.it
  | Ast.SubE (inner_exp, _, _) -> exp2name inner_exp
  | Ast.IterE (inner_exp, (iter, [id])) ->
      let name = exp2name inner_exp in
      assert (name = Ir.N id.it);
      let sup = begin match iter with
        | Ast.ListN nexp -> Print.string_of_exp nexp
        | _ -> Print.string_of_iter iter
      end in
      Ir.SupN (name, sup)
  | _ -> gen_fail_msg_of_exp exp "identifier" |> failwith

(* `Ast.exp` -> `Ir.expr` *)
let rec translate_expr exp = match exp.it with
  | Ast.NatE n -> Ir.ValueE n
  (* List *)
  | Ast.LenE inner_exp -> Ir.LengthE (translate_expr inner_exp)
  | Ast.ListE exps -> Ir.ListE (List.map translate_expr exps)
  | Ast.IdxE (exp1, exp2) -> Ir.IndexAccessE (translate_expr exp1, translate_expr exp2)
  (* Variable *)
  | Ast.VarE id -> Ir.NameE (N id.it)
  | Ast.SubE (inner_exp, _, _) -> translate_expr inner_exp
  | Ast.IterE (inner_exp, (iter, [id])) ->
      let name = exp2name inner_exp in
      assert (name = Ir.N id.it);
      let sup = begin match iter with
        | Ast.ListN nexp -> Print.string_of_exp nexp
        | _ -> Print.string_of_iter iter
      end in
      Ir.NameE(Ir.SupN (name, sup))
  (* Binary/Unary TODO: Missing call *)
  | Ast.UnE (Ast.MinusOp, inner_exp) -> Ir.MinusE (translate_expr inner_exp)
  | Ast.BinE (op, exp1, exp2) ->
      let lhs = translate_expr exp1 in
      let rhs = translate_expr exp2 in
      begin match op with
        | Ast.AddOp -> Ir.AddE (lhs, rhs)
        | Ast.SubOp -> Ir.SubE (lhs, rhs)
        | Ast.MulOp -> Ir.MulE (lhs, rhs)
        | Ast.DivOp -> Ir.DivE (lhs, rhs)
        | _ -> gen_fail_msg_of_exp exp "binary expression" |> failwith
      end
  (* Wasm Value expressions *)
  | Ast.CaseE (Ast.Atom "REF.NULL", inner_exp, _) -> Ir.RefNullE (exp2name inner_exp)
  | Ast.CaseE (Ast.Atom "CONST", { it = Ast.TupE ([ty; num]); _ }, _) ->
      begin match ty.it with
        | Ast.CaseE (Ast.Atom "I32", _, _) ->
            Ir.ConstE (Ir.I32T, translate_expr num)
        | Ast.VarE (id) -> Ir.ConstE (Ir.VarT id.it, translate_expr num)
        | _ -> gen_fail_msg_of_exp exp "value expression" |> failwith
      end
  (* Call with multiple arguments *)
  | Ast.CallE (id, { it = Ast.TupE el; _ }) ->
      Ir.AppE(N id.it, List.map translate_expr el)
  (* Call with a single argument *)
  | Ast.CallE (id, inner_exp) ->
      Ir.AppE(N id.it, [translate_expr inner_exp])
  | _ ->
      Ir.YetE (Print.string_of_exp exp)

(* `Ast.exp` -> `Ir.AssertI` *)
let insert_assert exp = match exp.it with
  | Ast.CaseE (
    Ast.Atom "CONST",
    { it = Ast.TupE({ it = Ast.CaseE (Ast.Atom "I32", _, _); _ } :: _); _ },
    _
  ) ->
      Ir.AssertI
        "Due to validation, a value of value type i32 is on the top of the stack"
  | _ ->
      Ir.AssertI "Due to validation, a value is on the top of the stack"

(* `Ast.exp` -> `Ir.instr list` *)
let rec lhs2pop exp = match exp.it with
  (* TODO: Handle bubble-up semantics *)
  | Ast.ListE exps ->
      let rev = List.rev exps |> List.tl in
      List.fold_right
        (fun e acc -> insert_assert e :: Ir.PopI (Some (translate_expr e)) :: acc)
        rev
        []
  | Ast.CatE (iterexp, listexp) ->
      insert_assert iterexp ::
        Ir.PopI (Some (translate_expr iterexp)) ::
        lhs2pop listexp
  | _ -> gen_fail_msg_of_exp exp "instruction" |> failwith

(* `Ast.exp` -> `Ir.instr list` *)
let rec rhs2instrs exp = match exp.it with
  | Ast.MixE (
    [[]; [Ast.Semicolon]; [Ast.Star]],
    (* z' ; instr'* *)
    { it = TupE ([callexp; rhs]); _ }
  ) ->
    let yet_instr = Ir.YetI ("Perform " ^ Print.string_of_exp callexp) in
    let push_instrs = rhs2instrs rhs in
    yet_instr :: push_instrs
  | Ast.ListE (exps) -> List.map rhs2instrs exps |> List.flatten
  | Ast.IterE (_, _) -> [Ir.PushI (translate_expr exp)]
  | Ast.CatE (exp1, exp2) ->
      rhs2instrs exp1 @ rhs2instrs exp2
  | Ast.CaseE (Atom "TRAP", _, _) -> [Ir.TrapI]
  | Ast.CaseE (Atom atomid, _, _)
    when atomid = "CONST" || atomid = "REF.FUNC_ADDR" ->
      [Ir.PushI (translate_expr exp)]
  | Ast.CaseE (Atom "FRAME_", tupexp, _) ->
      [Ir.LetI (Ir.NameE (Ir.N "F"), Ir.FrameE); Ir.PushI (translate_expr tupexp)]
  | Ast.CaseE (Atom "LABEL_", _, _) ->
      (* TODO *)
      [ Ir.LetI (Ir.NameE (Ir.N "L"), Ir.YetE ""); Ir.EnterI ("Yet", YetE "") ]
  | Ast.CaseE (Atom atomid, argexp, _)
    when String.starts_with ~prefix: "TABLE." atomid ||
    (* TODO: insert `end` in BLOCK Execute *)
    atomid = "BLOCK" || atomid = "BR" || atomid = "CALL_ADDR" ||
    atomid = "LOCAL.SET" || atomid = "RETURN" ->
      begin match argexp.it with
        | Ast.TupE (exps) ->
            let argexprs = List.map translate_expr exps in
            [Ir.ExecuteI (atomid, argexprs)]
        | _ -> [Ir.ExecuteI (atomid, [translate_expr argexp])]
      end
  | Ast.SubE (_, _, _) ->
      [Ir.PushI (translate_expr exp)]
  | _ -> gen_fail_msg_of_exp exp "rhs instructions" |> failwith

let check_nop instrs = match instrs with
  | [] -> [Ir.NopI]
  | _ -> instrs

let rec exp2cond exp = match exp.it with
  | Ast.CmpE (op, exp1, exp2) ->
      let lhs = translate_expr exp1 in
      let rhs = translate_expr exp2 in
      begin match op with
        | Ast.EqOp -> Ir.EqC (lhs, rhs)
        | Ast.NeOp -> Ir.NotC (Ir.EqC (lhs, rhs))
        | Ast.GtOp -> Ir.GtC (lhs, rhs)
        | Ast.GeOp -> Ir.GeC (lhs, rhs)
        | Ast.LtOp -> Ir.LtC (lhs, rhs)
        | Ast.LeOp -> Ir.LeC (lhs, rhs)
      end
  | Ast.BinE (op, exp1, exp2) ->
      let lhs = exp2cond exp1 in
      let rhs = exp2cond exp2 in
      begin match op with
        | Ast.AndOp -> Ir.AndC (lhs, rhs)
        | Ast.OrOp -> Ir.OrC (lhs, rhs)
        | _ -> gen_fail_msg_of_exp exp "binary expression for condition" |> failwith
      end
  | _ -> gen_fail_msg_of_exp exp "condition" |> failwith



(** Translate `Ast.premise` **)

(* `Ast.prem list` -> `Ir.instr list` *)
let prem2let prems =
  List.filter_map
    (function
      | { it = Ast.IfPr { it = Ast.CmpE (Ast.EqOp, exp1, exp2); _ }; _ } ->
          Some (Ir.LetI (translate_expr exp1, translate_expr exp2))
      | _ -> None)
    prems

(* `Ast.prem list` -> `Ir.cond` *)
let rec prem2cond prems = match prems with
  (* TODO: return, br *)
  | [] -> Ir.YetC "[]"
  | [{ it = Ast.IfPr exp; _ }] -> exp2cond exp
  | { it = Ast.IfPr exp; _ } :: t -> Ir.AndC (exp2cond exp, prem2cond t)
  | [{ it = Ast.ElsePr; _ }] -> Ir.YetC "Otherwise"
  | { it = Ast.ElsePr; _ } :: t -> Ir.AndC (Ir.YetC "Otherwise", prem2cond t)
  | prem :: _ -> gen_fail_msg_of_prem prem "condition" |> failwith



(** Main translation **)

(* `reduction_group list` -> `Backend-prose.Ir.Program` *)
let reduction_group2program reduction_group acc =
  let (reduction_name, lhs, _, _) = List.hd reduction_group in
  let program_name = String.split_on_char '-' reduction_name |> List.hd in

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
    (* multiple reduction rules: condition or assignment *)
    | _ ->
        List.map
          (fun (_, _, rhs, prems) ->
            (* TODO: distinguish condition and assignment *)
            let cond = prem2cond prems in
            let rhs_instrs = rhs2instrs rhs |> check_nop in
            Ir.IfI(cond, rhs_instrs, [])
          )
          reduction_group in

  let body = (pop_instrs @ instrs) |> check_nop in

  Ir.Program (program_name, body) :: acc



(** Temporarily convert `Ast.RuleD` into `reduction_group` **)

type reduction_group = (string * Ast.exp * Ast.exp * Ast.premise list) list

(* extract rules except Step/pure and Step/read *)
let extract_rules def acc = match def.it with
  | Ast.RelD (id, _, _, rules, _)
    when String.starts_with ~prefix:"Step" id.it ->
      let filter_context =
        (fun rule ->
          let Ast.RuleD (ruleid, _, _, _, _) = rule.it in
          ruleid.it <> "pure" && ruleid.it <> "read") in
      (List.filter filter_context rules) :: acc
  | _ -> acc

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
  let rules = List.fold_right extract_rules il [] |> List.flatten in
  let reduction_groups: reduction_group list = group rules in

  List.fold_right reduction_group2program reduction_groups []
