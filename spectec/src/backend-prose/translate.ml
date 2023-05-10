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

let rec flatten e = match e.it with
  | Ast.CatE (e1, e2) -> flatten e1 @ flatten e2
  | Ast.ListE es -> List.concat_map flatten es
  | _ -> [e]

let string2type s =
  Reference_interpreter.Types.NumType
    (match s with
    | "I32" -> Reference_interpreter.Types.I32Type
    | "I64" -> Reference_interpreter.Types.I64Type
    | "F32" -> Reference_interpreter.Types.F32Type
    | "F64" -> Reference_interpreter.Types.F64Type
    | _ -> s |> sprintf "Invalid type atom `%s`" |> failwith)

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
        | "frame" -> Al.FrameT
        | "store" -> Al.StoreT
        | "state" -> Al.StateT
        | _ ->
            (* TODO *)
            (*sprintf "%s -> %s" debug (Print.string_of_typ t) |> print_endline;*)
            Al.TopT
      end
  | Ast.NatT -> Al.IntT
  | _ -> failwith "Unreachable"

let rec find_type tenv exp =
  let to_NameE x = Al.NameE (Al.N x) in
  match exp.it with
  | Ast.VarE id ->
      begin match List.find_opt (fun (id', _, _) -> id'.it = id.it) tenv with
        | Some (_, t, []) -> (id.it |> to_NameE, il_type2al_type t)
        | Some (_, t, _) -> (id.it |> to_NameE, Al.ListT (il_type2al_type t))
        | _ -> failwith (id.it ^ "'s type is unknown. There must be a problem in the IL.")
      end
  | Ast.IterE (inner_exp, _) | Ast.SubE (inner_exp, _, _) ->
      find_type tenv inner_exp
  | Ast.MixE ( [[]; [Ast.Semicolon]; []], {it = Ast.TupE([st; fr]); _} ) ->
      (
        match (find_type tenv st, find_type tenv fr) with
        | ((s, StoreT), (f, FrameT)) -> (Al.PairE (s, f), Al.StateT)
        | _ -> (Print.string_of_exp exp |> to_NameE, Al.TopT)
      )
  | _ -> (Print.string_of_exp exp |> to_NameE, Al.TopT)

let get_params lhs_stack = match List.hd lhs_stack |> it with
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
  | Ast.NatE n -> Al.ValueE (Al.IntV n)
  (* List *)
  | Ast.LenE inner_exp -> Al.LengthE (exp2expr inner_exp)
  | Ast.ListE exps -> Al.ListE (List.map exp2expr exps |> Stdlib.Array.of_list)
  | Ast.IdxE (exp1, exp2) -> Al.IndexAccessE (exp2expr exp1, exp2expr exp2)
  | Ast.CatE (exp1, exp2) -> Al.ListE ([|exp2expr exp1; exp2expr exp2|])
  (* Variable *)
  | Ast.VarE id -> Al.NameE (N id.it)
  | Ast.SubE (inner_exp, _, _) -> exp2expr inner_exp
  | Ast.IterE ({ it = Ast.CallE (_, _); _ }, (_, _)) ->
      Al.YetE (Print.string_of_exp exp)
  | Ast.IterE (inner_exp, (iter, [_id])) ->
      let name = exp2name inner_exp in
      (* assert (name = Al.N id.it); *)
      Al.IterE (name, tmp iter)
  (* property access *)
  | Ast.DotE (_, inner_exp, Atom p) -> Al.PropE (exp2expr inner_exp, p)
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
        | Ast.CaseE (Ast.Atom ty_name, _, _) ->
            let ty = string2type ty_name in
            Al.ConstE (Al.ValueE (Al.WasmTypeV ty), exp2expr num)
        | Ast.VarE (id) -> Al.ConstE (Al.NameE (Al.N id.it), exp2expr num)
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
      let f acc = function
        | (Ast.Atom name, fieldexp) ->
            let expr = exp2expr fieldexp in
            Al.Record.add name expr acc
        | _ -> gen_fail_msg_of_exp exp "record expression" |> failwith in
      let record = List.fold_left f Al.Record.empty expfields in
      Al.RecordE (record)
  (* TODO: Handle MixE *)
  (* Yet *)
  | _ -> Al.YetE (Print.string_of_exp exp)

(* `Ast.exp` -> `Al.AssertI` *)
let insert_assert exp = match exp.it with
  | Ast.CaseE(Ast.Atom "FRAME_", _, _) ->
      Al.AssertI
        "Due to validation, the frame F is now on the top of the stack"
  | Ast.CatE (_val', { it = Ast.CatE (_valn, _); _ }) ->
      Al.AssertI "Due to validation, the stack contains at least one frame"
  | Ast.IterE (_, (Ast.ListN { it = VarE n; _ }, _)) ->
      Al.AssertI
        (sprintf
          "Due to validation, there are at least %s values on the top of the stack"
          n.it)
  | Ast.CaseE (
    Ast.Atom "LABEL_",
    { it = Ast.TupE ([_n; _instrs; _vals]); _ }, _
  ) ->
      Al.AssertI
        "Due to validation, the label L is now on the top of the stack"
  | Ast.CaseE (
    Ast.Atom "CONST",
    { it = Ast.TupE({ it = Ast.CaseE (Ast.Atom "I32", _, _); _ } :: _); _ },
    _
  ) ->
      Al.AssertI
        "Due to validation, a value of value type i32 is on the top of the stack"
  | _ ->
      Al.AssertI "Due to validation, a value is on the top of the stack"

(* `Ast.exp list` -> `Al.instr list` *)
(* Assumption: the target instruction is currently at the top of the stack. *)
(* The assumption does not hold for br and return *)
let lhs2pop = function
| [] -> failwith "Unreachable: empty lhs stack"
| inst :: rest -> match inst.it with
  (* Frame *)
  | Ast.CaseE(Ast.Atom "FRAME_", { it = Ast.TupE ([
      { it = Ast.VarE (arity); _ };
      { it = Ast.VarE (name); _ };
      inner_exp
    ]); _ }, _) ->  let let_instrs = [
        Al.LetI (Al.NameE(Al.N name.it), Al.GetCurFrameE);
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
      let pop_frame_instrs = [
        insert_assert inst;
        Al.PopI (Al.NameE (Al.N "the frame"))
      ] in
      (let_instrs @ pop_instrs @ pop_frame_instrs, rest)
  (* Label *)
  | Ast.CaseE (
    Ast.Atom "LABEL_",
    { it = Ast.TupE ([_n; _instrs; vals]); _ }, _
  ) ->
      ([
        (* TODO: append Jump instr *)
        Al.PopI (exp2expr vals);
        insert_assert inst;
        Al.PopI (Al.NameE (N "the label"))
      ], rest)
  (* noraml list expression *)
  | _ -> List.fold_left (fun (instrs, rest) e ->
      if List.length rest > 0 then (instrs, rest @ [e]) else
      match e.it with
      | Ast.IterE (_, (ListN _, _)) -> instrs, [e]
      | _ -> (instrs @ [insert_assert e; Al.PopI (exp2expr e)]), rest
    ) ([], []) rest

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
      { it = Ast.VarE (fname); _ };
      _inner_exp
    ]); _ }, _) ->
      [
        Al.PushI (Al.FrameE (Al.NameE (Al.N arity.it), Al.NameE (Al.N fname.it)))
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

let bound_by binding e = match e.it with
| Ast.IterE (_, (ListN {it = VarE {it = n; _}; _}, _)) ->
  if Free.Set.mem n (Free.free_exp binding).varid then
    [insert_assert e; Al.PopI (exp2expr e)]
  else
    []
| _ -> []

(** `Il.instr expr list` -> `prems -> `Al.instr list` -> `Al.instr list` **)
let prems2instrs remain_lhs =
  List.fold_right ( fun prem instrs ->
    match prem.it with
    | Ast.IfPr exp -> [ Al.IfI (exp2cond exp, instrs |> check_nop, []) ]
    | Ast.ElsePr -> [ Al.OtherwiseI (instrs |> check_nop) ]
    | Ast.AssignPr (exp1, exp2) ->
      let instrs' = (List.concat_map (bound_by exp1) remain_lhs) @ instrs in
      ( match exp1.it with
      | Ast.CaseE (atom, _e, t) -> [ Al.IfI (
          Al.EqC (
            Al.YetE ("typeof(" ^ (Print.string_of_exp exp2) ^ ")"),
            Al.YetE ((Print.string_of_atom atom) ^ "_" ^ (Print.string_of_typ t))
          ),
          Al.LetI (exp2expr exp1, exp2expr exp2) :: instrs',
          []
        ) ]
      | Ast.ListE es ->
        let rhs = exp2expr exp2 in
        [ Al.IfI (
          Al.EqC (
            Al.LengthE rhs,
            Al.ValueE (Al.IntV (List.length es))
          ),
          Al.LetI (exp2expr exp1, rhs) :: instrs',
          []
        ) ]
      | _ -> Al.LetI (exp2expr exp1, exp2expr exp2) :: instrs'
    )
    | _ ->
      gen_fail_msg_of_prem prem "instr" |> print_endline ;
      Al.YetI (Il.Print.string_of_prem prem) :: instrs
  )

(** reduction -> `Al.instr list` **)

let reduction2instrs remain_lhs (_, rhs, prems, _) =
  prems2instrs (remain_lhs) prems (rhs2instrs rhs)

(* `Ast.exp` -> `Ast.path` -> `Al.expr` *)
let path2expr exp path =
  let rec path2expr' path = match path.it with
    | Ast.RootP -> exp
    | Ast.IdxP (p, e) -> Ast.IdxE(path2expr' p, e) $ path.at
    | Ast.SliceP (p, e1, e2) -> Ast.SliceE(path2expr' p, e1, e2) $ path.at
    | Ast.DotP (p, a) -> Ast.DotE(Ast.VarT ("top" $ no_region) $ no_region, path2expr' p, a) $ path.at
  in
  path2expr' path |> exp2expr


(** Main translation for reduction rules **)

(* `reduction_group list` -> `Backend-prose.Al.Algo` *)
let reduction_group2algo (reduction_name, reduction_group) =
  let algo_name = String.split_on_char '-' reduction_name |> List.hd in
  let (lhs, _, _, tenv) = List.hd reduction_group in

  let lhs_stack = ( match lhs.it with
    (* z; lhs *)
    | Ast.MixE (
      [[]; [Ast.Semicolon]; [Ast.Star]],
      {it=Ast.TupE ({it=Ast.VarE {it="z"; _ }; _ } :: exp :: []); _}
    ) -> exp
    | _ -> lhs
  ) |> flatten |> List.rev
  in

  let (pop_instrs, remain) = lhs2pop lhs_stack in

  let instrs = match reduction_group with
    (* no premise: either *)
    | [(lhs1, rhs1, [], _); (lhs2, rhs2, [], _)]
      when Print.string_of_exp lhs1 = Print.string_of_exp lhs2 ->
        assert (List.length remain = 0);
        let rhs_instrs1 = rhs2instrs rhs1 |> check_nop in
        let rhs_instrs2 = rhs2instrs rhs2 |> check_nop in
        [Al.EitherI(rhs_instrs1, rhs_instrs2)]
    | _ ->
      let blocks = List.map (reduction2instrs remain) reduction_group in
      List.fold_right Transpile.merge_otherwise blocks []
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

  let body = (pop_instrs @ instrs) |> check_nop |> Transpile.enhance_readability in
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

let replace_with e =
  match e.it with
  | Ast.UpdE (base, path, v)
  | Ast.ExtE (base, path, v) -> [ Al.ReplaceI (path2expr base path, exp2expr v) ]
  | _ -> []

let mutator2instrs clause =
  let Ast.DefD(_binds, _e1, e2, prems) = clause.it in

  prems2instrs [] prems (
    match e2.it with
    | Ast.MixE ([[]; [Ast.Semicolon]; []], {it = Ast.TupE [new_s; new_f]; _}) ->
      replace_with new_s @ replace_with new_f
    | _ -> []
  )

let helper2instrs clause =
  let Ast.DefD(_binds, _e1, e2, prems) = clause.it in
  prems2instrs [] prems [ Al.ReturnI ( Option.some (exp2expr e2) ) ]

(** Main translation for helper functions **)

let helpers2algo def = match def.it with
  | Ast.DecD (_, _, _, []) -> None
  | Ast.DecD (id, _t1, _t2, clauses) ->
    let DefD(binds, params, _, _) = (List.hd clauses).it in
    let typed_params = ( match params.it with
    | Ast.TupE exps -> exps
    | _ -> [ params ]
    ) |> List.map (find_type binds)
    in
    let blocks = if String.starts_with ~prefix:"with" id.it then
      List.map mutator2instrs clauses
    else
      List.map helper2instrs clauses
    in
    let algo_body = List.fold_right Transpile.merge_otherwise blocks [] in

    let algo = Al.Algo(id.it, typed_params, algo_body) in
    Some algo
  | _ -> None

let translate_helpers il =
  List.filter_map helpers2algo il

(** Entry **)

(* `Ast.script` -> `Al.Algo` *)
let translate il =
  let algos = translate_helpers il @ translate_rules il in

  (* Transpile *)
  (* Can be turned off *)
  List.map Transpile.transpiler algos
