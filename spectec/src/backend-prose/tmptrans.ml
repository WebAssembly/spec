open Util.Source
open Il

(*let translate_expr e = match e.it with
  | Ast.VarE s -> Ir.NameE (N s.it)
  | Ast.ParenE ({ it = SeqE [{it=AtomE (Atom "\"CONST\"");_}]; _ }, false) -> Ir.YetE ""
  | _ -> Print.structured_string_of_exp e |> failwith*)

(** Translate il to ir **)

(* `Ast.exp` -> `Ir.Expr` *)
let translate_expr exp = match exp.it with
  | _ -> Ir.YetE (Print.string_of_exp exp)

(* `Ast.exp` -> `Ir.AssertI` *)
let translate_assert exp = match exp.it with
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
let translate_pop exp = match exp.it with
  | Ast.ListE exps ->
      List.rev exps
      |> List.tl
      |> List.fold_left
        (fun acc e -> translate_assert e :: Ir.PopI (Some (translate_expr e)) :: acc)
        []
  | Ast.CatE (_e1, _e2) -> [Ir.YetI "Bubble-up semantics."]
  | _ -> failwith "Unreachable"

(* `reduction_relation list` -> `Backend-prose.Ir.Program` *)
let translate_reduction acc rels =
  (* DEBUG *)
  let (name, lhs, _rhs, _prems) = List.hd rels in

  let pop_instrs = match lhs.it with
    (* z; lhs *)
    | Ast.MixE (
      [[]; [Ast.Semicolon]; [Ast.Star]],
      {it=Ast.TupE ({it=Ast.VarE {it="z"; _ }; _ } :: exp :: []); _}
    ) -> translate_pop exp
    | _ -> translate_pop lhs in

  Ir.Program (name, pop_instrs) :: acc

(** Temporarily convert `Ast.RuleD` into `reduction_relation` **)

type reduction_relation = (string * Ast.exp * Ast.exp * Ast.premise list)

let name_of_rule rule = 
  let Ast.RuleD (id1, _, _, _, _) = rule.it in
  String.split_on_char '-' id1.it |> List.hd

let rule2rel rule =
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
    List.map rule2rel (h :: reduction_group) :: (group rem)

let extract_reductions acc def = match def.it with
  | Ast.RelD(id, _, _, rules, _)
    when String.starts_with ~prefix:"Step_" id.it -> group rules :: acc
  | _ -> acc

(** Entry **)

(* `Ast.script` -> `Ir.Program` *)
let translate el =
  (* extract reduction rules from dsl *)
  let reductions: reduction_relation list list =
    List.fold_left extract_reductions [] el
    |> List.flatten in

  List.fold_left translate_reduction [] reductions
