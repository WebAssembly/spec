module IrPrint = Print
open Il
open Printf
open Util.Source


(** helper functions *)

let check_nop instrs = match instrs with
  | [] -> [Ir.NopI]
  | _ -> instrs

let gen_fail_msg_of_exp exp =
  Print.string_of_exp exp
  |> sprintf "Invalid expression `%s` to be IR %s."

let gen_fail_msg_of_prem prem =
  Print.string_of_prem prem
  |> sprintf "Invalid premise `%s` to be IR %s."

let take n str =
  let len = min n (String.length str) in
  (String.sub str 0 len) ^ if len <= n then "" else "..."

let rec neg cond = match cond with
| Ir.NotC c -> c
| Ir.AndC (c1, c2) -> Ir.OrC (neg c1, neg c2)
| Ir.OrC (c1, c2) -> Ir.AndC (neg c1, neg c2)
| Ir.GtC (e1, e2) -> Ir.LeC(e1, e2)
| Ir.GeC (e1, e2) -> Ir.LtC(e1, e2)
| Ir.LtC (e1, e2) -> Ir.GeC(e1, e2)
| Ir.LeC (e1, e2) -> Ir.GtC(e1, e2)
| _ -> Ir.NotC cond

let rec count_instrs instrs = instrs |>
  List.map (function
  | Ir.IfI (_, il1, il2)
  | Ir.EitherI (il1, il2) -> 1 + count_instrs il1 + count_instrs il2
  | Ir.OtherwiseI (il)
  | Ir.WhileI (_, il)
  | Ir.RepeatI (_, il) -> 1 + count_instrs il
  | _ -> 1
  ) |> List.fold_left (+) 0

(** Translate `Ast.type` *)
let type2ir_type t =
  match t.it with
  | Ast.NatT -> Ir.IntT
  | _ -> (* TODO *) TopT

let find_types tenv es =
  let find_type e = match e.it with
  | Ast.VarE id ->
    ( match List.find_opt (fun (id', _, _) -> id'.it = id.it) tenv with
    | Some (_, t, _) -> (id.it, type2ir_type t)
    | _ -> failwith (id.it ^ "'s type is unknown. There must be a problem in the IL.")
    )
  | _ -> (Print.string_of_exp e, Ir.TopT)
  in
  match es.it with
  | Ast.TupE es -> List.map find_type es
  | _ -> [ find_type es ]

(** Translate `Ast.exp` **)

(* `Ast.exp` -> `Ir.name` *)
let rec exp2name exp = match exp.it with
  | Ast.VarE id -> Ir.N id.it
  | Ast.SubE (inner_exp, _, _) -> exp2name inner_exp
  | _ -> gen_fail_msg_of_exp exp "identifier" |> print_endline; Ir.N "Yet"

let tmp = function
  | Ast.Opt -> Ir.Opt
  | Ast.List1 -> Ir.List1
  | Ast.List -> Ir.List
  | Ast.ListN e -> Ir.ListN (exp2name e)

(* `Ast.exp` -> `Ir.expr` *)
let rec exp2expr exp = match exp.it with
  | Ast.NatE n -> Ir.ValueE n
  (* List *)
  | Ast.LenE inner_exp -> Ir.LengthE (exp2expr inner_exp)
  | Ast.ListE exps -> Ir.ListE (List.map exp2expr exps)
  | Ast.IdxE (exp1, exp2) -> Ir.IndexAccessE (exp2expr exp1, exp2expr exp2)
  | Ast.CatE (exp1, exp2) -> Ir.ListE ([exp2expr exp1; exp2expr exp2])
  (* Variable *)
  | Ast.VarE id -> Ir.NameE (N id.it)
  | Ast.SubE (inner_exp, _, _) -> exp2expr inner_exp
  | Ast.IterE ({ it = Ast.CallE (_, _); _ }, (_, _)) ->
      Ir.YetE (Print.string_of_exp exp)
  | Ast.IterE (inner_exp, (iter, [_id])) ->
      let name = exp2name inner_exp in
      (* assert (name = Ir.N id.it); *)
      Ir.IterE (name, tmp iter)
  (* Binary / Unary operation *)
  | Ast.UnE (Ast.MinusOp, inner_exp) -> Ir.MinusE (exp2expr inner_exp)
  | Ast.BinE (op, exp1, exp2) ->
      let lhs = exp2expr exp1 in
      let rhs = exp2expr exp2 in
      begin match op with
        | Ast.AddOp -> Ir.AddE (lhs, rhs)
        | Ast.SubOp -> Ir.SubE (lhs, rhs)
        | Ast.MulOp -> Ir.MulE (lhs, rhs)
        | Ast.DivOp -> Ir.DivE (lhs, rhs)
        | _ -> gen_fail_msg_of_exp exp "binary expression" |> failwith
      end
  (* Wasm Value expressions *)
  | Ast.CaseE (Ast.Atom "REF.NULL", inner_exp, _) -> Ir.RefNullE (exp2name inner_exp)
  | Ast.CaseE (Ast.Atom "REF.FUNC_ADDR", inner_exp, _) ->
      Ir.RefFuncAddrE (exp2expr inner_exp)
  | Ast.CaseE (Ast.Atom "CONST", { it = Ast.TupE ([ty; num]); _ }, _) ->
      begin match ty.it with
        | Ast.CaseE (Ast.Atom "I32", _, _) ->
            let ty =
              Reference_interpreter.Types.NumType Reference_interpreter.Types.I32Type in
            Ir.ConstE (Ir.WasmTE (ty), exp2expr num)
        | Ast.VarE (id) -> Ir.ConstE (Ir.VarTE id.it, exp2expr num)
        | _ -> gen_fail_msg_of_exp exp "value expression" |> failwith
      end
  (* Call with multiple arguments *)
  | Ast.CallE (id, { it = Ast.TupE el; _ }) ->
      Ir.AppE(N id.it, List.map exp2expr el)
  (* Call with a single argument *)
  | Ast.CallE (id, inner_exp) ->
      Ir.AppE(N id.it, [exp2expr inner_exp])
  (* Record expression *)
  | Ast.StrE (expfields) ->
      let record =
        List.map
          (function
            | (Ast.Atom name, fieldexp) -> (name, exp2expr fieldexp)
            | _ -> gen_fail_msg_of_exp exp "record expression" |> failwith)
          expfields in
      Ir.RecordE (record)
  (* TODO: Handle MixE *)
  (* Yet *)
  | _ -> Ir.YetE (Print.string_of_exp exp)

(* `Ast.exp` -> `Ir.AssertI` *)
let insert_assert exp = match exp.it with
  | Ast.ListE ([{ it = Ast.CaseE(Ast.Atom "FRAME_", _, _); _ }]) ->
      Ir.AssertI
        "due to validation, the frame F is now on the top of the stack"
  | Ast.CatE (_val', { it = Ast.CatE (_valn, _); _ }) ->
      Ir.AssertI "due to validation, the stack contains at least one frame"
  | Ast.IterE (_, (Ast.ListN { it = VarE n; _ }, _)) ->
      Ir.AssertI
        (sprintf
          "due to validation, there are at least %s values on the top of the stack"
          n.it)
  | Ast.ListE ([{ it = Ast.CaseE (
    Ast.Atom "LABEL_",
    { it = Ast.TupE ([_n; _instrs; _vals]); _ }, _
  ); _ }]) ->
      Ir.AssertI
        "Assert: due to validation, the label L is now on the top of the stack"
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
  | Ast.CatE (iterexp, listexp) ->
      insert_assert iterexp ::
        Ir.PopI (exp2expr iterexp) ::
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
        Ir.LetI (Ir.NameE(Ir.N name.it), Ir.FrameE);
        Ir.LetI (Ir.NameE(Ir.N arity.it), Ir.ArityE (Ir.NameE (Ir.N name.it)))
      ] in
      let pop_instrs = match inner_exp.it with
        (* hardcoded pop instructions for "frame" reduction rule *)
        | Ast.IterE (_, _) ->
            insert_assert inner_exp ::
              Ir.PopI (exp2expr inner_exp) :: []
        (* hardcoded pop instructions for "return" reduction rule *)
        | Ast.CatE (_val', { it = Ast.CatE (valn, _); _ }) ->
            insert_assert valn ::
              Ir.PopI (exp2expr valn) ::
              insert_assert inner_exp ::
              (* While the top of the stack is not a frame, do ... *)
              Ir.WhileI (
                Ir.NotC (Ir.EqC (
                  Ir.NameE (Ir.N "the top of the stack"),
                  Ir.NameE (Ir.N "a frame")
                )),
                [Ir.PopI (Ir.NameE (Ir.N "the top element"))]
              ) :: []
        | _ -> gen_fail_msg_of_exp inner_exp "Pop instruction" |> failwith in
      let pop_frame_instrs =
        insert_assert exp ::
          Ir.PopI (Ir.NameE (Ir.N "the frame")) :: [] in
      let_instrs @ pop_instrs @ pop_frame_instrs
  (* Label *)
  | Ast.ListE ([{ it = Ast.CaseE (
    Ast.Atom "LABEL_",
    { it = Ast.TupE ([_n; _instrs; vals]); _ }, _
  ); _ }]) ->
      (* TODO: append Jump instr *)
      Ir.PopI (exp2expr vals) ::
        insert_assert exp ::
        Ir.PopI (Ir.NameE (N "the label")) :: []
  (* noraml list expression *)
  | Ast.ListE exps ->
      let rev = List.rev exps |> List.tl in
      List.fold_right
        (fun e acc -> insert_assert e :: Ir.PopI (exp2expr e) :: acc)
        rev
        []
  | _ -> gen_fail_msg_of_exp exp "lhs instruction" |> failwith

(* `Ast.exp` -> `Ir.instr list` *)
let rec rhs2instrs exp = match exp.it with
  (* Trap *)
  | Ast.CaseE (Atom "TRAP", _, _) -> [Ir.TrapI]
  (* Push *)
  | Ast.SubE (_, _, _) | IterE (_, _) -> [Ir.PushI (exp2expr exp)]
  | Ast.CaseE (Atom atomid, _, _)
    when atomid = "CONST" || atomid = "REF.FUNC_ADDR" ->
      [Ir.PushI (exp2expr exp)]
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
        Ir.LetI (
          Ir.NameE (Ir.N "F"),
          Ir.RecordE ([
            ("module", Ir.YetE "f.module");
            ("locals", Ir.YetE "val^n :: default_t*")
          ]));
        Ir.PushI (Ir.NameE (Ir.N (
          sprintf "the activation of F with arity %s" arity.it
        )))
        (* TODO: enter label *)
      ]
  (* TODO: Label *)
  | Ast.CaseE (Atom "LABEL_", _, _) ->
      [ Ir.LetI (Ir.NameE (Ir.N "L"), Ir.YetE ""); Ir.EnterI ("Yet", YetE "") ]
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
            [Ir.ExecuteI (atomid, argexprs)]
        | _ -> [Ir.ExecuteI (atomid, [exp2expr argexp])]
      end
  | Ast.MixE (
    [[]; [Ast.Semicolon]; [Ast.Star]],
    (* z' ; instr'* *)
    { it = TupE ([state_exp; rhs]); _ }
  ) ->
    let push_instrs = rhs2instrs rhs in
    begin match state_exp.it with
      | VarE(_) -> push_instrs
      | _ -> Ir.PerformI (exp2expr state_exp) :: push_instrs
    end
  | _ -> gen_fail_msg_of_exp exp "rhs instructions" |> failwith

(* `Ast.exp` -> `Ir.cond` *)
let rec exp2cond exp = match exp.it with
  | Ast.CmpE (op, exp1, exp2) ->
      let lhs = exp2expr exp1 in
      let rhs = exp2expr exp2 in
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



(** reduction -> `Ir.instr list` **)

let reduction2instrs (_, rhs, prems, _) =
  List.fold_right ( fun prem instrs ->
    match prem.it with
    | Ast.IfPr exp -> [ Ir.IfI (exp2cond exp, instrs |> check_nop, []) ]
    | Ast.ElsePr -> [ Ir.OtherwiseI (instrs |> check_nop) ]
    | Ast.AssignPr (exp1, exp2) -> ( match exp1.it with
      | Ast.CaseE (atom, _e, t) -> [ Ir.IfI (
          Ir.EqC (
            Ir.YetE ("typeof(" ^ (Print.string_of_exp exp2) ^ ")"),
            Ir.YetE ((Print.string_of_atom atom) ^ "_" ^ (Print.string_of_typ t))
          ),
          Ir.LetI (exp2expr exp1, exp2expr exp2) :: instrs,
          []
        ) ]
      | Ast.ListE es ->
        let rhs = exp2expr exp2 in
        [ Ir.IfI (
          Ir.EqC (
            Ir.LengthE rhs,
            Ir.ValueE (List.length es)
          ),
          Ir.LetI (exp2expr exp1, rhs) :: instrs,
          []
        ) ]
      | _ -> Ir.LetI (exp2expr exp1, exp2expr exp2) :: instrs
    )
    | _ ->
      gen_fail_msg_of_prem prem "instr" |> print_endline ;
      Ir.YetI (Il.Print.string_of_prem prem) :: instrs
  )
  prems
  (rhs2instrs rhs)


(** IR -> IR transpilers *)

(* Recursively append else block to every empty if *)
let rec insert_otherwise else_body instrs =
  let walk = insert_otherwise else_body in
  List.fold_left_map (fun visit_if inst ->
    match inst with
    | Ir.IfI (c, il, []) ->
      let (_, il') = walk il in
      ( true, Ir.IfI(c, il', else_body) )
    | Ir.IfI (c, il1, il2) ->
      let (visit_if1, il1') = walk il1 in
      let (visit_if2, il2') = walk il2 in
      let visit_if = visit_if || visit_if1 || visit_if2 in
      ( visit_if, Ir.IfI(c, il1', il2') )
    | Ir.OtherwiseI (il) ->
      let (visit_if', il') = walk il in
      let visit_if = visit_if || visit_if' in
      ( visit_if, Ir.OtherwiseI(il') )
    | Ir.WhileI (c, il) ->
      let (visit_if', il') = walk il in
      let visit_if = visit_if || visit_if' in
      ( visit_if, Ir.WhileI(c, il') )
    | Ir.RepeatI (e, il) ->
      let (visit_if', il') = walk il in
      let visit_if = visit_if || visit_if' in
      ( visit_if, Ir.RepeatI(e, il') )
    | Ir.EitherI (il1, il2) ->
      let (visit_if1, il1') = walk il1 in
      let (visit_if2, il2') = walk il2 in
      let visit_if = visit_if || visit_if1 || visit_if2 in
      ( visit_if, Ir.EitherI(il1', il2') )
    | _ -> (visit_if, inst)
  ) false instrs

(* If the latter block of instrs is a single Otherwise, merge them *)
let merge_otherwise instrs1 instrs2 = match instrs2 with
| [ Ir.OtherwiseI else_body ] ->
  let ( visit_if, merged ) = insert_otherwise else_body instrs1 in
  if not visit_if then print_endline (
    "Warning: No corresponding if for" ^
    take 100 ( IrPrint.string_of_instrs 0 instrs2 )
  );
  merged
| _ -> instrs1 @ instrs2

(* Enhance readability of IR *)
let rec infer_else instrs = List.fold_right (fun i il ->
  let new_i = match i with
  | Ir.IfI (c, il1, il2) -> Ir.IfI (c, infer_else il1, infer_else il2)
  | Ir.OtherwiseI (il) -> Ir.OtherwiseI (infer_else il)
  | Ir.WhileI (c, il) -> Ir.WhileI (c, infer_else il)
  | Ir.RepeatI (e, il) -> Ir.RepeatI (e, infer_else il)
  | Ir.EitherI (il1, il2) -> Ir.EitherI (infer_else il1, infer_else il2)
  | _ -> i
  in
  match (new_i, il) with
  | ( Ir.IfI(c1, then_body, []), Ir.IfI(c2, else_body, []) :: rest )
    when neg c1 = c2 ->
      Ir.IfI(c1, then_body, else_body) :: rest
  | _ -> new_i :: il
) instrs []

let rec swap_if instr =
  let new_ = List.map swap_if in
  match instr with
  | Ir.IfI (c, il, [])
  | Ir.IfI (c, il, [ NopI ]) -> Ir.IfI (c, new_ il, [])
  | Ir.IfI (c, [ NopI ], il) -> Ir.IfI (neg c, new_ il, [])
  | Ir.IfI (c, il1, il2) ->
    if count_instrs il1 <= count_instrs il2 then
      Ir.IfI (c, new_ il1, new_ il2)
    else
      Ir.IfI (neg c, new_ il2, new_ il1)
  | Ir.OtherwiseI (il) -> Ir.OtherwiseI (new_ il)
  | Ir.WhileI (c, il) -> Ir.WhileI (c, new_ il)
  | Ir.RepeatI (e, il) -> Ir.RepeatI (e, new_ il)
  | Ir.EitherI (il1, il2) -> Ir.EitherI (new_ il1, new_ il2)
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
  | Ir.IfI (c, il1, il2) ->
    let (then_il, else_il, finally_il) = unify_tail (new_ il1) (new_ il2) in
    Ir.IfI (c, then_il, else_il) :: finally_il
  | Ir.OtherwiseI (il) -> [ Ir.OtherwiseI (new_ il) ]
  | Ir.WhileI (c, il) -> [ Ir.WhileI (c, new_ il) ]
  | Ir.RepeatI (e, il) -> [ Ir.RepeatI (e, new_ il) ]
  | Ir.EitherI (il1, il2) -> [ Ir.EitherI (new_ il1, new_ il2) ]
  | _ -> [instr]

let enhance_readability instrs =
  instrs
  |> infer_else
  |> List.map swap_if
  |> List.concat_map unify_if_tail

(** Main translation **)

(* `reduction_group list` -> `Backend-prose.Ir.Algo` *)
let reduction_group2algo (reduction_name, reduction_group) acc =
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

  let rec top_of e = match e.it with
  | Ast.ListE es -> top_of ( es |> List.rev |> List.hd )
  | Ast.CatE (_, e) -> top_of e
  | _ -> e
  in

  let params = match (top_of lhs_stack).it with
  | CaseE(Atom iname, args, _) when
      algo_name = "frame" ||
      algo_name = "label" ||
      iname <> "FRAME_" && iname <> "LABEL_" ->
        find_types tenv args
  | _ ->
    print_endline ("Bubbleup semantics for " ^ algo_name ^ ": Top of the stack is frame / label");
    []
  in

  let pop_instrs = lhs2pop lhs_stack in

  let instrs = match reduction_group with
    (* no premise: either *)
    | [(lhs1, rhs1, [], _); (lhs2, rhs2, [], _)]
      when Print.string_of_exp lhs1 = Print.string_of_exp lhs2 ->
        let rhs_instrs1 = rhs2instrs rhs1 |> check_nop in
        let rhs_instrs2 = rhs2instrs rhs2 |> check_nop in
        [Ir.EitherI(rhs_instrs1, rhs_instrs2)]
    | _ ->
      let blocks = List.map reduction2instrs reduction_group in
      List.fold_right merge_otherwise blocks []
    in

  let body = (pop_instrs @ instrs) |> check_nop |> enhance_readability in
  Ir.Algo (algo_name, params, body) :: acc



(** Temporarily convert `Ast.RuleD` into `reduction_group`: (id, (lhs, rhs, prems, binds)+) **)

type reduction_group = string * (Ast.exp * Ast.exp * Ast.premise list * Ast.binds) list

(* extract rules except Step/pure and Step/read *)
let extract_rules def acc = match def.it with
  | Ast.RelD (id, _, _, rules)
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
  let Ast.RuleD (_, tenv, _, exp, prems) = rule.it in
  match exp.it with
    | Ast.TupE (lhs :: rhs :: []) -> (lhs, rhs, prems, tenv)
    | _ ->
        Print.string_of_exp exp
        |> sprintf "Invalid expression `%s` to be reduction rule."
        |> failwith

(* group reduction rules that have same name *)
let rec group = function
  | [] -> []
  | h :: t ->
    let name = name_of_rule h in
    let (reduction_group, rem) =
      List.partition
        (fun rule -> name = name_of_rule rule)
        t in
    (name, List.map rule2tup (h :: reduction_group)) :: (group rem)



(** Entry **)

(* `Ast.script` -> `Ir.Algo` *)
let translate il =
  let rules = List.fold_right extract_rules il [] |> List.flatten in
  let reduction_groups: reduction_group list = group rules in

  List.fold_right reduction_group2algo reduction_groups []
