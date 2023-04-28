module AlPrint = Print
open Il
open Printf
open Util.Source


(** helper functions *)

let check_nop instrs = match instrs with
  | [] -> [Al.NopI]
  | _ -> instrs

let gen_fail_msg_of_exp exp =
  Print.string_of_exp exp
  |> sprintf "Invalid expression `%s` to be AL %s."

let gen_fail_msg_of_prem prem =
  Print.string_of_prem prem
  |> sprintf "Invalid premise `%s` to be AL %s."

let take n str =
  let len = min n (String.length str) in
  (String.sub str 0 len) ^ if len <= n then "" else "..."

let rec neg cond = match cond with
| Al.NotC c -> c
| Al.AndC (c1, c2) -> Al.OrC (neg c1, neg c2)
| Al.OrC (c1, c2) -> Al.AndC (neg c1, neg c2)
| Al.GtC (e1, e2) -> Al.LeC(e1, e2)
| Al.GeC (e1, e2) -> Al.LtC(e1, e2)
| Al.LtC (e1, e2) -> Al.GeC(e1, e2)
| Al.LeC (e1, e2) -> Al.GtC(e1, e2)
| _ -> Al.NotC cond

let list_sum = List.fold_left (+) 0

let rec count_instrs instrs = instrs |>
  List.map (function
  | Al.IfI (_, il1, il2)
  | Al.EitherI (il1, il2) -> 1 + count_instrs il1 + count_instrs il2
  | Al.OtherwiseI (il)
  | Al.WhileI (_, il)
  | Al.RepeatI (_, il) -> 1 + count_instrs il
  | _ -> 1
  ) |> list_sum

(** Translate `Ast.type` *)
let il_type2al_type t = match t.it with
  | Ast.VarT id ->
      begin match id.it with
        | "n" -> Al.IntT
        | "numtype" -> Al.IntT
        | idx when String.ends_with ~suffix: "idx" idx -> Al.IntT
        | numerics when String.ends_with ~suffix: "_numtype" numerics -> Al.StringT
        | "addr" -> Al.AddrT
        | "functype" -> Al.TopT
        | "cvtop" -> Al.StringT
        | "sx" -> Al.TopT
        | "val" -> Al.WasmValueTopT
        | "valtype" -> Al.WasmValueTopT
        | _ ->
            (* TODO *)
            (*sprintf "%s -> %s" debug (Print.string_of_typ t) |> print_endline;*)
            Al.TopT
      end
  | _ -> failwith "Unreachable"

let rec find_type tenv exp = match exp.it with
  | Ast.VarE id ->
      begin match List.find_opt (fun (id', _, _) -> id'.it = id.it) tenv with
        | Some (_, t, []) -> (Al.N id.it, il_type2al_type t)
        | Some (_, t, _) -> (Al.N id.it, Al.ListT (il_type2al_type t))
        | _ -> failwith (id.it ^ "'s type is unknown. There must be a problem in the IL.")
      end
  | Ast.IterE (inner_exp, _) | Ast.SubE (inner_exp, _, _) ->
      find_type tenv inner_exp
  | _ -> (Al.N (Print.string_of_exp exp), Al.TopT)

let rec get_top_of_stack stack = match stack.it with
  | Ast.ListE exps -> exps |> List.rev |> List.hd
  | Ast.CatE (_, exp) -> get_top_of_stack exp
  | _ -> stack

let get_params lhs_stack = match get_top_of_stack lhs_stack |> it with
  | Ast.CaseE (_, { it = Ast.TupE exps; _ }, _) -> exps
  | Ast.CaseE (_, exp, _) -> [exp]
  | _ ->
    print_endline
      ("Bubbleup semantics: Top of the stack is frame / label");
    []

(** Translate `Ast.exp` **)

(* `Ast.exp` -> `Al.name` *)
let rec exp2name exp = match exp.it with
  | Ast.VarE id -> Al.N id.it
  | Ast.SubE (inner_exp, _, _) -> exp2name inner_exp
  | _ -> gen_fail_msg_of_exp exp "identifier" |> print_endline; Al.N "Yet"

let tmp = function
  | Ast.Opt -> Al.Opt
  | Ast.List1 -> Al.List1
  | Ast.List -> Al.List
  | Ast.ListN e -> Al.ListN (exp2name e)

(* `Ast.exp` -> `Al.expr` *)
let rec exp2expr exp = match exp.it with
  | Ast.NatE n -> Al.ValueE n
  (* List *)
  | Ast.LenE inner_exp -> Al.LengthE (exp2expr inner_exp)
  | Ast.ListE exps -> Al.ListE (List.map exp2expr exps)
  | Ast.IdxE (exp1, exp2) -> Al.IndexAccessE (exp2expr exp1, exp2expr exp2)
  | Ast.CatE (exp1, exp2) -> Al.ListE ([exp2expr exp1; exp2expr exp2])
  (* Variable *)
  | Ast.VarE id -> Al.NameE (N id.it)
  | Ast.SubE (inner_exp, _, _) -> exp2expr inner_exp
  | Ast.IterE ({ it = Ast.CallE (_, _); _ }, (_, _)) ->
      Al.YetE (Print.string_of_exp exp)
  | Ast.IterE (inner_exp, (iter, [_id])) ->
      let name = exp2name inner_exp in
      (* assert (name = Al.N id.it); *)
      Al.IterE (name, tmp iter)
  (* Binary / Unary operation *)
  | Ast.UnE (Ast.MinusOp, inner_exp) -> Al.MinusE (exp2expr inner_exp)
  | Ast.BinE (op, exp1, exp2) ->
      let lhs = exp2expr exp1 in
      let rhs = exp2expr exp2 in
      begin match op with
        | Ast.AddOp -> Al.AddE (lhs, rhs)
        | Ast.SubOp -> Al.SubE (lhs, rhs)
        | Ast.MulOp -> Al.MulE (lhs, rhs)
        | Ast.DivOp -> Al.DivE (lhs, rhs)
        | _ -> gen_fail_msg_of_exp exp "binary expression" |> failwith
      end
  (* Wasm Value expressions *)
  | Ast.CaseE (Ast.Atom "REF.NULL", inner_exp, _) -> Al.RefNullE (exp2name inner_exp)
  | Ast.CaseE (Ast.Atom "REF.FUNC_ADDR", inner_exp, _) ->
      Al.RefFuncAddrE (exp2expr inner_exp)
  | Ast.CaseE (Ast.Atom "CONST", { it = Ast.TupE ([ty; num]); _ }, _) ->
      begin match ty.it with
        | Ast.CaseE (Ast.Atom "I32", _, _) ->
            let ty =
              Reference_interpreter.Types.NumType Reference_interpreter.Types.I32Type in
            Al.ConstE (Al.WasmTE (ty), exp2expr num)
        | Ast.VarE (id) -> Al.ConstE (Al.VarTE id.it, exp2expr num)
        | _ -> gen_fail_msg_of_exp exp "value expression" |> failwith
      end
  (* Call with multiple arguments *)
  | Ast.CallE (id, { it = Ast.TupE el; _ }) ->
      Al.AppE(N id.it, List.map exp2expr el)
  (* Call with a single argument *)
  | Ast.CallE (id, inner_exp) ->
      Al.AppE(N id.it, [exp2expr inner_exp])
  (* Record expression *)
  | Ast.StrE (expfields) ->
      let record =
        List.map
          (function
            | (Ast.Atom name, fieldexp) -> (name, exp2expr fieldexp)
            | _ -> gen_fail_msg_of_exp exp "record expression" |> failwith)
          expfields in
      Al.RecordE (record)
  (* TODO: Handle MixE *)
  (* Yet *)
  | _ -> Al.YetE (Print.string_of_exp exp)

(* `Ast.exp` -> `Al.AssertI` *)
let insert_assert exp = match exp.it with
  | Ast.ListE ([{ it = Ast.CaseE(Ast.Atom "FRAME_", _, _); _ }]) ->
      Al.AssertI
        "due to validation, the frame F is now on the top of the stack"
  | Ast.CatE (_val', { it = Ast.CatE (_valn, _); _ }) ->
      Al.AssertI "due to validation, the stack contains at least one frame"
  | Ast.IterE (_, (Ast.ListN { it = VarE n; _ }, _)) ->
      Al.AssertI
        (sprintf
          "due to validation, there are at least %s values on the top of the stack"
          n.it)
  | Ast.ListE ([{ it = Ast.CaseE (
    Ast.Atom "LABEL_",
    { it = Ast.TupE ([_n; _instrs; _vals]); _ }, _
  ); _ }]) ->
      Al.AssertI
        "Assert: due to validation, the label L is now on the top of the stack"
  | Ast.CaseE (
    Ast.Atom "CONST",
    { it = Ast.TupE({ it = Ast.CaseE (Ast.Atom "I32", _, _); _ } :: _); _ },
    _
  ) ->
      Al.AssertI
        "Due to validation, a value of value type i32 is on the top of the stack"
  | _ ->
      Al.AssertI "Due to validation, a value is on the top of the stack"

(* `Ast.exp` -> `Al.instr list` *)
let rec lhs2pop exp = match exp.it with
  | Ast.CatE (iterexp, listexp) ->
      insert_assert iterexp ::
        Al.PopI (exp2expr iterexp) ::
        lhs2pop listexp
  (* Frame *)
  | Ast.ListE ([{
    it = Ast.CaseE(Ast.Atom "FRAME_", { it = Ast.TupE ([
      { it = Ast.VarE (arity); _ };
      { it = Ast.VarE (name); _ };
      inner_exp
    ]); _ }, _); _
  }]) ->
      let let_instrs = [
        Al.LetI (Al.NameE(Al.N name.it), Al.FrameE);
        Al.LetI (Al.NameE(Al.N arity.it), Al.ArityE (Al.NameE (Al.N name.it)))
      ] in
      let pop_instrs = match inner_exp.it with
        (* hardcoded pop instructions for "frame" reduction rule *)
        | Ast.IterE (_, _) ->
            insert_assert inner_exp ::
              Al.PopI (exp2expr inner_exp) :: []
        (* hardcoded pop instructions for "return" reduction rule *)
        | Ast.CatE (_val', { it = Ast.CatE (valn, _); _ }) ->
            insert_assert valn ::
              Al.PopI (exp2expr valn) ::
              insert_assert inner_exp ::
              (* While the top of the stack is not a frame, do ... *)
              Al.WhileI (
                Al.NotC (Al.EqC (
                  Al.NameE (Al.N "the top of the stack"),
                  Al.NameE (Al.N "a frame")
                )),
                [Al.PopI (Al.NameE (Al.N "the top element"))]
              ) :: []
        | _ -> gen_fail_msg_of_exp inner_exp "Pop instruction" |> failwith in
      let pop_frame_instrs =
        insert_assert exp ::
          Al.PopI (Al.NameE (Al.N "the frame")) :: [] in
      let_instrs @ pop_instrs @ pop_frame_instrs
  (* Label *)
  | Ast.ListE ([{ it = Ast.CaseE (
    Ast.Atom "LABEL_",
    { it = Ast.TupE ([_n; _instrs; vals]); _ }, _
  ); _ }]) ->
      (* TODO: append Jump instr *)
      Al.PopI (exp2expr vals) ::
        insert_assert exp ::
        Al.PopI (Al.NameE (N "the label")) :: []
  (* noraml list expression *)
  | Ast.ListE exps ->
      let rev = List.rev exps |> List.tl in
      List.concat_map
        (fun e -> [insert_assert e; Al.PopI (exp2expr e)])
        rev
  | _ -> gen_fail_msg_of_exp exp "lhs instruction" |> failwith

(* `Ast.exp` -> `Al.instr list` *)
let rec rhs2instrs exp = match exp.it with
  (* Trap *)
  | Ast.CaseE (Atom "TRAP", _, _) -> [Al.TrapI]
  (* Push *)
  | Ast.SubE (_, _, _) | IterE (_, _) -> [Al.PushI (exp2expr exp)]
  | Ast.CaseE (Atom atomid, _, _)
    when atomid = "CONST" || atomid = "REF.FUNC_ADDR" ->
      [Al.PushI (exp2expr exp)]
  (* multiple rhs' *)
  | Ast.CatE (exp1, exp2) -> rhs2instrs exp1 @ rhs2instrs exp2
  | Ast.ListE (exps) -> List.map rhs2instrs exps |> List.flatten
  (* Frame *)
  | Ast.CaseE(Ast.Atom "FRAME_", { it = Ast.TupE ([
      { it = Ast.VarE (arity); _ };
      { it = Ast.VarE (_name); _ };
      _inner_exp
    ]); _ }, _) ->

      [
        Al.LetI (
          Al.NameE (Al.N "F"),
          Al.RecordE ([
            ("module", Al.YetE "f.module");
            ("locals", Al.YetE "val^n :: default_t*")
          ]));
        Al.PushI (Al.NameE (Al.N (
          sprintf "the activation of F with arity %s" arity.it
        )))
        (* TODO: enter label *)
      ]
  (* TODO: Label *)
  | Ast.CaseE (Atom "LABEL_", _, _) ->
      [ Al.LetI (Al.NameE (Al.N "L"), Al.YetE ""); Al.EnterI ("Yet", YetE "") ]
  (* Execute instr *)
  | Ast.CaseE (Atom atomid, argexp, _)
    when String.starts_with ~prefix: "TABLE." atomid ||
    String.starts_with ~prefix: "MEMORY." atomid ||
    atomid = "LOAD" || atomid = "STORE" ||
    atomid = "BLOCK" || atomid = "BR" || atomid = "CALL_ADDR" ||
    atomid = "LOCAL.SET" || atomid = "RETURN" ->
      begin match argexp.it with
        | Ast.TupE (exps) ->
            let argexprs = List.map exp2expr exps in
            [Al.ExecuteI (atomid, argexprs)]
        | _ -> [Al.ExecuteI (atomid, [exp2expr argexp])]
      end
  | Ast.MixE (
    [[]; [Ast.Semicolon]; [Ast.Star]],
    (* z' ; instr'* *)
    { it = TupE ([state_exp; rhs]); _ }
  ) ->
    let push_instrs = rhs2instrs rhs in
    begin match state_exp.it with
      | VarE(_) -> push_instrs
      | _ -> Al.PerformI (exp2expr state_exp) :: push_instrs
    end
  | _ -> gen_fail_msg_of_exp exp "rhs instructions" |> failwith

(* `Ast.exp` -> `Al.cond` *)
let rec exp2cond exp = match exp.it with
  | Ast.CmpE (op, exp1, exp2) ->
      let lhs = exp2expr exp1 in
      let rhs = exp2expr exp2 in
      begin match op with
        | Ast.EqOp -> Al.EqC (lhs, rhs)
        | Ast.NeOp -> Al.NotC (Al.EqC (lhs, rhs))
        | Ast.GtOp -> Al.GtC (lhs, rhs)
        | Ast.GeOp -> Al.GeC (lhs, rhs)
        | Ast.LtOp -> Al.LtC (lhs, rhs)
        | Ast.LeOp -> Al.LeC (lhs, rhs)
      end
  | Ast.BinE (op, exp1, exp2) ->
      let lhs = exp2cond exp1 in
      let rhs = exp2cond exp2 in
      begin match op with
        | Ast.AndOp -> Al.AndC (lhs, rhs)
        | Ast.OrOp -> Al.OrC (lhs, rhs)
        | _ -> gen_fail_msg_of_exp exp "binary expression for condition" |> failwith
      end
  | _ -> gen_fail_msg_of_exp exp "condition" |> failwith



(** reduction -> `Al.instr list` **)

let reduction2instrs (_, rhs, prems, _) =
  List.fold_right ( fun prem instrs ->
    match prem.it with
    | Ast.IfPr exp -> [ Al.IfI (exp2cond exp, instrs |> check_nop, []) ]
    | Ast.ElsePr -> [ Al.OtherwiseI (instrs |> check_nop) ]
    | Ast.AssignPr (exp1, exp2) -> ( match exp1.it with
      | Ast.CaseE (atom, _e, t) -> [ Al.IfI (
          Al.EqC (
            Al.YetE ("typeof(" ^ (Print.string_of_exp exp2) ^ ")"),
            Al.YetE ((Print.string_of_atom atom) ^ "_" ^ (Print.string_of_typ t))
          ),
          Al.LetI (exp2expr exp1, exp2expr exp2) :: instrs,
          []
        ) ]
      | Ast.ListE es ->
        let rhs = exp2expr exp2 in
        [ Al.IfI (
          Al.EqC (
            Al.LengthE rhs,
            Al.ValueE (List.length es)
          ),
          Al.LetI (exp2expr exp1, rhs) :: instrs,
          []
        ) ]
      | _ -> Al.LetI (exp2expr exp1, exp2expr exp2) :: instrs
    )
    | _ ->
      gen_fail_msg_of_prem prem "instr" |> print_endline ;
      Al.YetI (Il.Print.string_of_prem prem) :: instrs
  )
  prems
  (rhs2instrs rhs)


(** AL -> AL transpilers *)

(* Recursively append else block to every empty if *)
let rec insert_otherwise else_body instrs =
  let walk = insert_otherwise else_body in
  List.fold_left_map (fun visit_if inst ->
    match inst with
    | Al.IfI (c, il, []) ->
      let (_, il') = walk il in
      ( true, Al.IfI(c, il', else_body) )
    | Al.IfI (c, il1, il2) ->
      let (visit_if1, il1') = walk il1 in
      let (visit_if2, il2') = walk il2 in
      let visit_if = visit_if || visit_if1 || visit_if2 in
      ( visit_if, Al.IfI(c, il1', il2') )
    | Al.OtherwiseI (il) ->
      let (visit_if', il') = walk il in
      let visit_if = visit_if || visit_if' in
      ( visit_if, Al.OtherwiseI(il') )
    | Al.WhileI (c, il) ->
      let (visit_if', il') = walk il in
      let visit_if = visit_if || visit_if' in
      ( visit_if, Al.WhileI(c, il') )
    | Al.RepeatI (e, il) ->
      let (visit_if', il') = walk il in
      let visit_if = visit_if || visit_if' in
      ( visit_if, Al.RepeatI(e, il') )
    | Al.EitherI (il1, il2) ->
      let (visit_if1, il1') = walk il1 in
      let (visit_if2, il2') = walk il2 in
      let visit_if = visit_if || visit_if1 || visit_if2 in
      ( visit_if, Al.EitherI(il1', il2') )
    | _ -> (visit_if, inst)
  ) false instrs

(* If the latter block of instrs is a single Otherwise, merge them *)
let merge_otherwise instrs1 instrs2 = match instrs2 with
| [ Al.OtherwiseI else_body ] ->
  let ( visit_if, merged ) = insert_otherwise else_body instrs1 in
  if not visit_if then print_endline (
    "Warning: No corresponding if for" ^
    take 100 ( AlPrint.string_of_instrs 0 instrs2 )
  );
  merged
| _ -> instrs1 @ instrs2

(* Enhance readability of AL *)
let rec infer_else instrs = List.fold_right (fun i il ->
  let new_i = match i with
  | Al.IfI (c, il1, il2) -> Al.IfI (c, infer_else il1, infer_else il2)
  | Al.OtherwiseI (il) -> Al.OtherwiseI (infer_else il)
  | Al.WhileI (c, il) -> Al.WhileI (c, infer_else il)
  | Al.RepeatI (e, il) -> Al.RepeatI (e, infer_else il)
  | Al.EitherI (il1, il2) -> Al.EitherI (infer_else il1, infer_else il2)
  | _ -> i
  in
  match (new_i, il) with
  | ( Al.IfI(c1, then_body, []), Al.IfI(c2, else_body, []) :: rest )
    when neg c1 = c2 ->
      Al.IfI(c1, then_body, else_body) :: rest
  | _ -> new_i :: il
) instrs []

let rec swap_if instr =
  let new_ = List.map swap_if in
  match instr with
  | Al.IfI (c, il, [])
  | Al.IfI (c, il, [ NopI ]) -> Al.IfI (c, new_ il, [])
  | Al.IfI (c, [ NopI ], il) -> Al.IfI (neg c, new_ il, [])
  | Al.IfI (c, il1, il2) ->
    if count_instrs il1 <= count_instrs il2 then
      Al.IfI (c, new_ il1, new_ il2)
    else
      Al.IfI (neg c, new_ il2, new_ il1)
  | Al.OtherwiseI (il) -> Al.OtherwiseI (new_ il)
  | Al.WhileI (c, il) -> Al.WhileI (c, new_ il)
  | Al.RepeatI (e, il) -> Al.RepeatI (e, new_ il)
  | Al.EitherI (il1, il2) -> Al.EitherI (new_ il1, new_ il2)
  | _ -> instr

let rec unify_head acc l1 l2 = match (l1, l2) with
| h1 :: t1, h2 :: t2 when h1 = h2 -> unify_head (h1 :: acc) t1 t2
| _ -> ((List.rev acc), l1, l2)

let unify_tail instrs1 instrs2 =
  let rev = List.rev in
  let (rh, rt1, rt2) = unify_head [] (rev instrs1) (rev instrs2) in
  (rev rt1, rev rt2, rev rh)

let rec unify_if_tail instr =
  let new_ = List.concat_map unify_if_tail in
  match instr with
  | Al.IfI (c, il1, il2) ->
    let (then_il, else_il, finally_il) = unify_tail (new_ il1) (new_ il2) in
    Al.IfI (c, then_il, else_il) :: finally_il
  | Al.OtherwiseI (il) -> [ Al.OtherwiseI (new_ il) ]
  | Al.WhileI (c, il) -> [ Al.WhileI (c, new_ il) ]
  | Al.RepeatI (e, il) -> [ Al.RepeatI (e, new_ il) ]
  | Al.EitherI (il1, il2) -> [ Al.EitherI (new_ il1, new_ il2) ]
  | _ -> [instr]

let enhance_readability instrs =
  instrs
  |> infer_else
  |> List.map swap_if
  |> List.concat_map unify_if_tail

(** Main translation for reduction rules **)

(* `reduction_group list` -> `Backend-prose.Al.Algo` *)
let reduction_group2algo (reduction_name, reduction_group) =
  let algo_name = String.split_on_char '-' reduction_name |> List.hd in
  let (lhs, _, _, tenv) = List.hd reduction_group in

  let lhs_stack = match lhs.it with
    (* z; lhs *)
    | Ast.MixE (
      [[]; [Ast.Semicolon]; [Ast.Star]],
      {it=Ast.TupE ({it=Ast.VarE {it="z"; _ }; _ } :: exp :: []); _}
    ) -> exp
    | _ -> lhs
  in

  let pop_instrs = lhs2pop lhs_stack in

  let instrs = match reduction_group with
    (* no premise: either *)
    | [(lhs1, rhs1, [], _); (lhs2, rhs2, [], _)]
      when Print.string_of_exp lhs1 = Print.string_of_exp lhs2 ->
        let rhs_instrs1 = rhs2instrs rhs1 |> check_nop in
        let rhs_instrs2 = rhs2instrs rhs2 |> check_nop in
        [Al.EitherI(rhs_instrs1, rhs_instrs2)]
    | _ ->
      let blocks = List.map reduction2instrs reduction_group in
      List.fold_right merge_otherwise blocks []
    in

  let params =
    if (algo_name = "br" || algo_name = "return") then (
      sprintf
        "Bubbleup semantics for %s: Top of the stack is frame / label"
        algo_name
      |> print_endline;
      []
    )
    else get_params lhs_stack |> List.map (find_type tenv) in

  let body = (pop_instrs @ instrs) |> check_nop |> enhance_readability in
  Al.Algo (algo_name, params, body)



(** Temporarily convert `Ast.RuleD` into `reduction_group`: (id, (lhs, rhs, prems, binds)+) **)

type reduction_group = string * (Ast.exp * Ast.exp * Ast.premise list * Ast.binds) list

(* extract rules except Step/pure and Step/read *)
let extract_rules def = match def.it with
  | Ast.RelD (id, _, _, rules)
    when String.starts_with ~prefix:"Step" id.it ->
      let filter_context =
        (fun rule ->
          let Ast.RuleD (ruleid, _, _, _, _) = rule.it in
          ruleid.it <> "pure" && ruleid.it <> "read") in
      List.filter filter_context rules
  | _ -> []

let name_of_rule rule =
  let Ast.RuleD (id1, _, _, _, _) = rule.it in
  String.split_on_char '-' id1.it |> List.hd

let rule2tup rule =
  let Ast.RuleD (_, tenv, _, exp, prems) = rule.it in
  match exp.it with
    | Ast.TupE (lhs :: rhs :: []) -> (lhs, rhs, prems, tenv)
    | _ ->
        Print.string_of_exp exp
        |> sprintf "Invalid expression `%s` to be reduction rule."
        |> failwith

(* group reduction rules that have same name *)
let rec group_rules = function
  | [] -> []
  | h :: t ->
    let name = name_of_rule h in
    let (reduction_group, rem) =
      List.partition
        (fun rule -> name_of_rule rule = name)
        t in
    (name, List.map rule2tup (h :: reduction_group)) :: (group_rules rem)

let translate_rules il =
  let rules = List.concat_map extract_rules il in
  let reduction_groups: reduction_group list = group_rules rules in

  List.map reduction_group2algo reduction_groups

(** Main translation for helper functions **)

let extract_helpers _def = []

let group_helpers _helpers = []

let helper_group2algo _helper_group = []

let translate_helpers il =
  let helpers = List.concat_map extract_helpers il in
  let helper_groups = group_helpers helpers in

  List.map reduction_group2algo helper_groups

(** Entry **)

(* `Ast.script` -> `Al.Algo` *)
let translate il = translate_helpers il @ translate_rules il
