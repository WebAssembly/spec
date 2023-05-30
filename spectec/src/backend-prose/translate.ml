module AlPrint = Print
open Il
open Printf
open Util.Source

(** helper functions *)

let check_nop instrs = match instrs with [] -> [ Al.NopI ] | _ -> instrs

let gen_fail_msg_of_exp exp =
  Print.string_of_exp exp |> sprintf "Invalid expression `%s` to be AL %s."

let gen_fail_msg_of_prem prem =
  Print.string_of_prem prem |> sprintf "Invalid premise `%s` to be AL %s."

let rec flatten e =
  match e.it with
  | Ast.CatE (e1, e2) -> flatten e1 @ flatten e2
  | Ast.ListE es -> List.concat_map flatten es
  | _ -> [ e ]

let string2type s =
  let open Reference_interpreter.Types in
  match s with
  | "I32" -> NumType I32Type
  | "I64" -> NumType I64Type
  | "F32" -> NumType F32Type
  | "F64" -> NumType F64Type
  | "V128" -> VecType V128Type
  | "FUNCREF" -> RefType FuncRefType
  | "EXTERNREF" -> RefType ExternRefType
  | _ -> s |> sprintf "Invalid type atom `%s`" |> failwith

(** Translate `Ast.type` *)
let il_type2al_type t =
  match t.it with
  | Ast.VarT id -> (
      match id.it with
      | "n" -> Al.IntT
      | "numtype" -> Al.IntT
      | idx when String.ends_with ~suffix:"idx" idx -> Al.IntT
      | numerics when String.ends_with ~suffix:"_numtype" numerics -> Al.StringT
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
          Al.TopT)
  | Ast.NatT -> Al.IntT
  | _ -> failwith "Unreachable"

let rec find_type tenv exp =
  let to_NameE x = Al.NameE (Al.N x) in
  match exp.it with
  | Ast.VarE id -> (
      match List.find_opt (fun (id', _, _) -> id'.it = id.it) tenv with
      | Some (_, t, []) -> (id.it |> to_NameE, il_type2al_type t)
      | Some (_, t, _) -> (id.it |> to_NameE, Al.ListT (il_type2al_type t))
      | _ ->
          failwith
            (id.it ^ "'s type is unknown. There must be a problem in the IL."))
  | Ast.IterE (inner_exp, _) | Ast.SubE (inner_exp, _, _) ->
      find_type tenv inner_exp
  | Ast.MixE ([ []; [ Ast.Semicolon ]; [] ], { it = Ast.TupE [ st; fr ]; _ })
    -> (
      match (find_type tenv st, find_type tenv fr) with
      | (s, StoreT), (f, FrameT) -> (Al.PairE (s, f), Al.StateT)
      | _ -> (Print.string_of_exp exp |> to_NameE, Al.TopT))
  | _ -> (Print.string_of_exp exp |> to_NameE, Al.TopT)

let get_params lhs_stack =
  match List.hd lhs_stack |> it with
  | Ast.CaseE (_, { it = Ast.TupE exps; _ }) -> exps
  | Ast.CaseE (_, exp) -> [ exp ]
  | _ ->
      print_endline "Bubbleup semantics: Top of the stack is frame / label";
      []

(** Translate `Ast.exp` **)

(* `Ast.exp` -> `Al.name` *)
let rec exp2name exp =
  match exp.it with
  | Ast.VarE id -> Al.N id.it
  | Ast.SubE (inner_exp, _, _) -> exp2name inner_exp
  | _ ->
      gen_fail_msg_of_exp exp "identifier" |> print_endline;
      Al.N "Yet"

let tmp = function
  | Ast.Opt -> Al.Opt
  | Ast.List1 -> Al.List1
  | Ast.List -> Al.List
  | Ast.ListN e -> Al.ListN (exp2name e)

(* `Ast.exp` -> `Al.expr` *)
let rec exp2expr exp =
  match exp.it with
  | Ast.NatE n -> Al.ValueE (Al.IntV n)
  (* List *)
  | Ast.LenE inner_exp -> Al.LengthE (exp2expr inner_exp)
  | Ast.ListE exps -> Al.ListE (List.map exp2expr exps |> Stdlib.Array.of_list)
  | Ast.IdxE (exp1, exp2) ->
      Al.AccessE (exp2expr exp1, Al.IndexP (exp2expr exp2))
  | Ast.SliceE (exp1, exp2, exp3) ->
      Al.AccessE (exp2expr exp1, Al.SliceP (exp2expr exp2, exp2expr exp3))
  | Ast.CatE (exp1, exp2) -> Al.ConcatE (exp2expr exp1, exp2expr exp2)
  (* Variable *)
  | Ast.VarE id -> Al.NameE (N id.it)
  | Ast.SubE (inner_exp, _, _) -> exp2expr inner_exp
  | Ast.IterE ({ it = Ast.CallE (id, inner_exp); _ }, (iter, _)) ->
      Al.MapE (N id.it, exp2args inner_exp, tmp iter)
  | Ast.IterE (inner_exp, (iter, [ _id ])) ->
      let name = exp2name inner_exp in
      (* assert (name = Al.N id.it); *)
      Al.IterE (name, tmp iter)
  | Ast.IterE (inner_exp, (Ast.ListN times, [])) ->
      Al.ListFillE (exp2expr inner_exp, exp2expr times)
  (* property access *)
  | Ast.DotE (inner_exp, Atom p) -> Al.AccessE (exp2expr inner_exp, Al.DotP p)
  (* Binary / Unary operation *)
  | Ast.UnE (Ast.MinusOp, inner_exp) -> Al.MinusE (exp2expr inner_exp)
  | Ast.BinE (op, exp1, exp2) -> (
      let lhs = exp2expr exp1 in
      let rhs = exp2expr exp2 in
      match op with
      | Ast.AddOp -> Al.AddE (lhs, rhs)
      | Ast.SubOp -> Al.SubE (lhs, rhs)
      | Ast.MulOp -> Al.MulE (lhs, rhs)
      | Ast.DivOp -> Al.DivE (lhs, rhs)
      | _ -> gen_fail_msg_of_exp exp "binary expression" |> failwith)
  (* Wasm Value expressions *)
  | Ast.CaseE (Ast.Atom "REF.NULL", inner_exp) ->
      Al.RefNullE (exp2name inner_exp)
  | Ast.CaseE (Ast.Atom "REF.FUNC_ADDR", inner_exp) ->
      Al.RefFuncAddrE (exp2expr inner_exp)
  | Ast.CaseE (Ast.Atom "CONST", { it = Ast.TupE [ ty; num ]; _ }) -> (
      match ty.it with
      | Ast.CaseE (Ast.Atom ty_name, _) ->
          let ty = string2type ty_name in
          let open Reference_interpreter.Types in
          let v = match ty, exp2expr num with
          | NumType F32Type, Al.ValueE (Al.IntV n)
          | NumType F64Type, Al.ValueE (Al.IntV n) -> Al.ValueE (Al.FloatV (float_of_int n))
          | _, v -> v
          in
          Al.ConstE (Al.ValueE (Al.WasmTypeV ty), v)
      | Ast.VarE id -> Al.ConstE (Al.NameE (Al.N id.it), exp2expr num)
      | _ -> gen_fail_msg_of_exp exp "value expression" |> failwith)
  | Ast.CaseE (Ast.Atom typ, e)
      when Eq.eq_typ e.note (Ast.VarT ("valtype" $ no_region) $ no_region)
      || Eq.eq_typ e.note (Ast.VarT ("numtype" $ no_region) $ no_region) ->
        Al.ValueE (Al.WasmTypeV (string2type typ))
  (* Wasm Instruction *)
  | Ast.CaseE (Ast.Atom "LOOP", { it = Ast.TupE exps; _ }) ->
      Al.WasmInstrE ("loop", List.map exp2expr exps)
  (* ConstructE *)
  | Ast.CaseE (Ast.Atom cons, { it = Ast.TupE args; _ }) ->
      Al.ConstructE (cons, List.map exp2expr args)
  | Ast.CaseE (Ast.Atom cons, arg) -> Al.ConstructE (cons, [ exp2expr arg ])
  (* Tuple *)
  | Ast.TupE exps -> Al.ListE (List.map exp2expr exps |> Array.of_list)
  (* Call *)
  | Ast.CallE (id, inner_exp) -> Al.AppE (N id.it, exp2args inner_exp)
  (* Record expression *)
  | Ast.StrE expfields ->
      let f acc = function
        | Ast.Atom name, fieldexp ->
            let expr = exp2expr fieldexp in
            Al.Record.add name expr acc
        | _ -> gen_fail_msg_of_exp exp "record expression" |> failwith
      in
      let record = List.fold_left f Al.Record.empty expfields in
      Al.RecordE record
  (* TODO: Handle MixE *)
  | Ast.MixE (op, { it = Ast.TupE exps; _ }) -> (
      match (op, exps) with
      | [ []; [ Ast.Semicolon ]; [] ], [ e1; e2 ] ->
          Al.PairE (exp2expr e1, exp2expr e2)
      | [ []; [ Ast.Arrow ]; [] ], [ e1; e2 ] ->
          Al.ArrowE (exp2expr e1, exp2expr e2)
      | [ [ Ast.Atom "FUNC" ]; []; [ Ast.Star ]; [] ], _ ->
          Al.ConstructE ("FUNC", List.map exp2expr exps)
      | _ -> Al.YetE (Print.structured_string_of_exp exp))
  | Ast.OptE inner_exp -> Al.OptE (Option.map exp2expr inner_exp)
  (* Yet *)
  | _ -> Al.YetE (Print.string_of_exp exp)

(* `Ast.exp` -> `Al.expr` *)
and exp2args exp =
  match exp.it with
  | Ast.TupE el -> List.map exp2expr el
  | _ -> [ exp2expr exp ]

(* `Ast.exp` -> `Al.AssertI` *)
let insert_assert exp =
  match exp.it with
  | Ast.CaseE (Ast.Atom "FRAME_", _) ->
      Al.AssertI "Due to validation, the frame F is now on the top of the stack"
  | Ast.CatE (_val', { it = Ast.CatE (_valn, _); _ }) ->
      Al.AssertI "Due to validation, the stack contains at least one frame"
  | Ast.IterE (_, (Ast.ListN { it = VarE n; _ }, _)) ->
      Al.AssertI
        (sprintf
           "Due to validation, there are at least %s values on the top of the \
            stack"
           n.it)
  | Ast.CaseE (Ast.Atom "LABEL_", { it = Ast.TupE [ _n; _instrs; _vals ]; _ })
    ->
      Al.AssertI "Due to validation, the label L is now on the top of the stack"
  | Ast.CaseE
      ( Ast.Atom "CONST",
        { it = Ast.TupE ({ it = Ast.CaseE (Ast.Atom "I32", _); _ } :: _); _ }) ->
      Al.AssertI
        "Due to validation, a value of value type i32 is on the top of the \
         stack"
  | _ -> Al.AssertI "Due to validation, a value is on the top of the stack"

(* `Ast.exp list` -> `Al.instr list` *)
(* Assumption: the target instruction is currently at the top of the stack. *)
(* The assumption does not hold for br and return *)
let lhs2pop = function
  | [] -> failwith "Unreachable: empty lhs stack"
  | inst :: rest -> (
      match inst.it with
      (* Frame *)
      | Ast.CaseE
          ( Ast.Atom "FRAME_",
            {
              it =
                Ast.TupE
                  [
                    { it = Ast.VarE arity; _ };
                    { it = Ast.VarE name; _ };
                    inner_exp;
                  ];
              _;
            }) ->
          let let_instrs =
            [
              Al.LetI (Al.NameE (Al.N name.it), Al.GetCurFrameE);
              Al.LetI
                (Al.NameE (Al.N arity.it), Al.ArityE (Al.NameE (Al.N name.it)));
            ]
          in
          let pop_instrs =
            match inner_exp.it with
            (* hardcoded pop instructions for "frame" reduction rule *)
            | Ast.IterE (_, _) ->
                [ insert_assert inner_exp; Al.PopI (exp2expr inner_exp) ]
            (* hardcoded pop instructions for "return" reduction rule *)
            | Ast.CatE (_val', { it = Ast.CatE (valn, _); _ }) ->
                [
                  insert_assert valn;
                  Al.PopI (exp2expr valn);
                  insert_assert inner_exp;
                  (* While the top of the stack is not a frame, do ... *)
                  Al.WhileI
                    ( Al.NotC
                        (Al.EqC
                           ( Al.NameE (Al.N "the top of the stack"),
                             Al.NameE (Al.N "a frame") )),
                      [ Al.PopI (Al.NameE (Al.N "the top element")) ] );
                ]
            | _ -> gen_fail_msg_of_exp inner_exp "Pop instruction" |> failwith
          in
          let pop_frame_instrs =
            [ insert_assert inst; Al.PopI (Al.NameE (Al.N "the frame")) ]
          in
          (let_instrs @ pop_instrs @ pop_frame_instrs, rest)
      (* Label *)
      | Ast.CaseE
          (Ast.Atom "LABEL_", { it = Ast.TupE [ _n; _instrs; vals ]; _ }) ->
          ( [
              (* TODO: append Jump instr *)
              Al.PopI (exp2expr vals);
              insert_assert inst;
              Al.PopI (Al.NameE (N "the label"));
            ],
            rest )
      (* noraml list expression *)
      | _ ->
          List.fold_left
            (fun (instrs, rest) e ->
              if List.length rest > 0 then (instrs, rest @ [ e ])
              else
                match e.it with
                | Ast.IterE (_, (ListN _, _)) -> (instrs, [ e ])
                | _ -> (instrs @ [ insert_assert e; Al.PopI (exp2expr e) ], rest))
            ([], []) rest)

(* `Ast.exp` -> `Al.instr list` *)
let rec rhs2instrs exp =
  match exp.it with
  (* Trap *)
  | Ast.CaseE (Atom "TRAP", _) -> [ Al.TrapI ]
  (* Push *)
  | Ast.SubE (_, _, _) | IterE (_, _) -> [ Al.PushI (exp2expr exp) ]
  | Ast.CaseE (Atom atomid, _)
    when atomid = "CONST" || atomid = "REF.FUNC_ADDR" ->
      [ Al.PushI (exp2expr exp) ]
  (* multiple rhs' *)
  | Ast.CatE (exp1, exp2) -> rhs2instrs exp1 @ rhs2instrs exp2
  | Ast.ListE exps -> List.map rhs2instrs exps |> List.flatten
  (* Frame *)
  | Ast.CaseE
      ( Ast.Atom "FRAME_",
        {
          it =
            Ast.TupE
              [
                { it = Ast.VarE arity; _ };
                { it = Ast.VarE fname; _ };
                { it = Ast.ListE [ labelexp ]; _ };
              ];
          _;
        }) ->
      let push_instr =
        Al.PushI
          (Al.FrameE (Al.NameE (Al.N arity.it), Al.NameE (Al.N fname.it)))
      in
      let exit_instr = Al.ExitNormalI (Al.N fname.it) in
      (push_instr :: rhs2instrs labelexp) @ [ exit_instr ]
  (* TODO: Label *)
  | Ast.CaseE
      ( Atom "LABEL_",
        {
          it =
            Ast.TupE
              [ { it = Ast.VarE label_arity; _ }; instrs_exp1; instrs_exp2 ];
          _;
        }) -> (
      let label_expr =
        Al.LabelE (Al.NameE (Al.N label_arity.it), exp2expr instrs_exp1)
      in
      match instrs_exp2.it with
      | Ast.CatE (valexp, instrsexp) ->
          [
            Al.LetI (Al.NameE (Al.N "L"), label_expr);
            Al.PushI (Al.NameE (Al.N "L"));
            Al.PushI (exp2expr valexp);
            Al.JumpI (exp2expr instrsexp);
            Al.ExitNormalI (Al.N "L");
          ]
      | _ ->
          [
            Al.LetI (Al.NameE (Al.N "L"), label_expr);
            Al.PushI (Al.NameE (Al.N "L"));
            Al.JumpI (exp2expr instrs_exp2);
            Al.ExitNormalI (Al.N "L");
          ])
  (* Execute instr *)
  | Ast.CaseE (Atom atomid, argexp)
    when String.starts_with ~prefix:"TABLE." atomid
         || String.starts_with ~prefix:"MEMORY." atomid
         || atomid = "LOAD" || atomid = "STORE" || atomid = "BLOCK"
         || atomid = "BR" || atomid = "CALL_ADDR" || atomid = "LOCAL.SET"
         || atomid = "RETURN" ->
      let lower_id = String.lowercase_ascii atomid in
      let args =
        match argexp.it with
        | Ast.TupE exps -> List.map exp2expr exps
        | _ -> [ exp2expr argexp ]
      in
      [ Al.ExecuteI (Al.WasmInstrE (lower_id, args)) ]
  | Ast.MixE
      ( [ []; [ Ast.Semicolon ]; [ Ast.Star ] ],
        (* z' ; instr'* *)
        { it = TupE [ state_exp; rhs ]; _ } ) -> (
      let push_instrs = rhs2instrs rhs in
      match state_exp.it with
      | VarE _ -> push_instrs
      | _ -> Al.PerformI (exp2expr state_exp) :: push_instrs)
  | _ -> gen_fail_msg_of_exp exp "rhs instructions" |> failwith

(* `Ast.exp` -> `Al.cond` *)
let rec exp2cond exp =
  match exp.it with
  | Ast.CmpE (op, exp1, exp2) -> (
      let lhs = exp2expr exp1 in
      let rhs = exp2expr exp2 in
      match op with
      | Ast.EqOp -> Al.EqC (lhs, rhs)
      | Ast.NeOp -> Al.NotC (Al.EqC (lhs, rhs))
      | Ast.GtOp -> Al.GtC (lhs, rhs)
      | Ast.GeOp -> Al.GeC (lhs, rhs)
      | Ast.LtOp -> Al.LtC (lhs, rhs)
      | Ast.LeOp -> Al.LeC (lhs, rhs))
  | Ast.BinE (op, exp1, exp2) -> (
      let lhs = exp2cond exp1 in
      let rhs = exp2cond exp2 in
      match op with
      | Ast.AndOp -> Al.AndC (lhs, rhs)
      | Ast.OrOp -> Al.OrC (lhs, rhs)
      | _ ->
          gen_fail_msg_of_exp exp "binary expression for condition" |> failwith)
  | _ -> gen_fail_msg_of_exp exp "condition" |> failwith

let bound_by binding e =
  match e.it with
  | Ast.IterE (_, (ListN { it = VarE { it = n; _ }; _ }, _)) ->
      if Free.Set.mem n (Free.free_exp binding).varid then
        [ insert_assert e; Al.PopI (exp2expr e) ]
      else []
  | _ -> []

(** `Il.instr expr list` -> `prems -> `Al.instr list` -> `Al.instr list` **)
let prems2instrs remain_lhs =
  List.fold_right (fun prem instrs ->
      match prem.it with
      | Ast.IfPr exp -> [ Al.IfI (exp2cond exp, instrs |> check_nop, []) ]
      | Ast.ElsePr -> [ Al.OtherwiseI (instrs |> check_nop) ]
      | Ast.AssignPr (exp1, exp2) -> (
          let instrs' = List.concat_map (bound_by exp1) remain_lhs @ instrs in
          match exp1.it with
          | Ast.CaseE (atom, e) ->
              [
                Al.IfI
                  ( Al.CaseOfC
                      ( exp2expr exp2,
                        Print.string_of_atom atom ^ "_" ^ Print.string_of_typ e.note
                      ),
                    Al.LetI (exp2expr exp1, exp2expr exp2) :: instrs',
                    [] );
              ]
          | Ast.ListE es ->
              let rhs = exp2expr exp2 in
              [
                Al.IfI
                  ( Al.EqC (Al.LengthE rhs, Al.ValueE (Al.IntV (List.length es))),
                    Al.LetI (exp2expr exp1, rhs) :: instrs',
                    [] );
              ]
          | Ast.OptE None ->
              [
                Al.IfI
                  ( Al.NotC (Al.DefinedC (exp2expr exp2)),
                    instrs',
                    [] );
              ]
          | Ast.OptE (Some _) ->
              let rhs = exp2expr exp2 in
              [
                Al.IfI
                  ( Al.DefinedC rhs,
                    Al.LetI (exp2expr exp1, rhs) :: instrs',
                    [] );
              ]
          | _ -> Al.LetI (exp2expr exp1, exp2expr exp2) :: instrs')
      | _ ->
          gen_fail_msg_of_prem prem "instr" |> print_endline;
          Al.YetI (Il.Print.string_of_prem prem) :: instrs)

(** reduction -> `Al.instr list` **)

let reduction2instrs remain_lhs (_, rhs, prems, _) =
  prems2instrs remain_lhs prems (rhs2instrs rhs)

(* `Ast.exp` -> `Ast.path` -> `Al.expr` *)
let path2expr exp path =
  let rec path2expr' path =
    match path.it with
    | Ast.RootP -> exp
    | Ast.IdxP (p, e) -> Ast.IdxE (path2expr' p, e) $$ (path.at % path.note)
    | Ast.SliceP (p, e1, e2) -> Ast.SliceE (path2expr' p, e1, e2) $$ (path.at % path.note)
    | Ast.DotP (p, a) ->
        Ast.DotE (path2expr' p, a)
        $$ (path.at % path.note)
  in
  path2expr' path |> exp2expr

(** Main translation for reduction rules **)

(* `reduction_group list` -> `Backend-prose.Al.Algo` *)
let reduction_group2algo (reduction_name, reduction_group) =
  let algo_name = String.split_on_char '-' reduction_name |> List.hd in
  let lhs, _, _, tenv = List.hd reduction_group in

  let lhs_stack =
    (match lhs.it with
    (* z; lhs *)
    | Ast.MixE
        ( [ []; [ Ast.Semicolon ]; [ Ast.Star ] ],
          { it = Ast.TupE [ { it = Ast.VarE { it = "z"; _ }; _ }; exp ]; _ } )
      ->
        exp
    | _ -> lhs)
    |> flatten |> List.rev
  in

  let pop_instrs, remain = lhs2pop lhs_stack in

  let instrs =
    match reduction_group with
    (* no premise: either *)
    | [ (lhs1, rhs1, [], _); (lhs2, rhs2, [], _) ]
      when Print.string_of_exp lhs1 = Print.string_of_exp lhs2 ->
        assert (List.length remain = 0);
        let rhs_instrs1 = rhs2instrs rhs1 |> check_nop in
        let rhs_instrs2 = rhs2instrs rhs2 |> check_nop in
        [ Al.EitherI (rhs_instrs1, rhs_instrs2) ]
    | _ ->
        let blocks = List.map (reduction2instrs remain) reduction_group in
        List.fold_right Transpile.merge_otherwise blocks []
  in

  let params =
    if algo_name = "br" || algo_name = "return" then (
      sprintf "Bubbleup semantics for %s: Top of the stack is frame / label"
        algo_name
      |> print_endline;
      [])
    else get_params lhs_stack |> List.map (find_type tenv)
  in

  let body =
    pop_instrs @ instrs |> check_nop |> Transpile.enhance_readability
  in
  Al.Algo (algo_name, params, body)

(** Temporarily convert `Ast.RuleD` into `reduction_group`: (id, (lhs, rhs, prems, binds)+) **)

type reduction_group =
  string * (Ast.exp * Ast.exp * Ast.premise list * Ast.binds) list

(* extract rules except Step/pure and Step/read *)
let extract_rules def =
  match def.it with
  | Ast.RelD (id, _, _, rules) when String.starts_with ~prefix:"Step" id.it ->
      let filter_context rule =
        let (Ast.RuleD (ruleid, _, _, _, _)) = rule.it in
        ruleid.it <> "pure" && ruleid.it <> "read"
      in
      List.filter filter_context rules
  | _ -> []

let name_of_rule rule =
  let (Ast.RuleD (id1, _, _, _, _)) = rule.it in
  String.split_on_char '-' id1.it |> List.hd

let rule2tup rule =
  let (Ast.RuleD (_, tenv, _, exp, prems)) = rule.it in
  match exp.it with
  | Ast.TupE [ lhs; rhs ] -> (lhs, rhs, prems, tenv)
  | _ ->
      Print.string_of_exp exp
      |> sprintf "Invalid expression `%s` to be reduction rule."
      |> failwith

(* group reduction rules that have same name *)
let rec group_rules = function
  | [] -> []
  | h :: t ->
      let name = name_of_rule h in
      let reduction_group, rem =
        List.partition (fun rule -> name_of_rule rule = name) t
      in
      (name, List.map rule2tup (h :: reduction_group)) :: group_rules rem


(** Unifying lhs **)
let _unified_id = ref 0
let init_unified_id () = _unified_id := 0
let get_unified_id () = let i = !_unified_id in _unified_id := (i+1); i
let gen_new_unified () = Ast.VarE ("unified" ^ (string_of_int (get_unified_id())) $ no_region)

let rec overlap e1 e2 = if Eq.eq_exp e1 e2 then e1 else
  let open Ast in
  ( match e1.it, e2.it with
  | VarE id, _ when String.starts_with ~prefix:"unified" id.it -> e1.it
  | UnE (unop1, e1), UnE (unop2, e2) when unop1 = unop2 ->
      UnE (unop1, overlap e1 e2)
  | BinE (binop1, e1, e1'), BinE (binop2, e2, e2') when binop1 = binop2 ->
      BinE (binop1, overlap e1 e2, overlap e1' e2')
  | CmpE (cmpop1, e1, e1'), CmpE (cmpop2, e2, e2') when cmpop1 = cmpop2 ->
      CmpE (cmpop1, overlap e1 e2, overlap e1' e2')
  | IdxE (e1, e1'), IdxE (e2, e2') ->
      IdxE (overlap e1 e2, overlap e1' e2')
  | SliceE (e1, e1', e1''), SliceE (e2, e2', e2'') ->
      SliceE (overlap e1 e2, overlap e1' e2', overlap e1'' e2'')
  | UpdE (e1, path1, e1'), UpdE (e2, path2, e2') when Eq.eq_path path1 path2 ->
      UpdE (overlap e1 e2, path1, overlap e1' e2')
  | ExtE (e1, path1, e1'), ExtE (e2, path2, e2') when Eq.eq_path path1 path2 ->
      ExtE (overlap e1 e2, path1, overlap e1' e2')
  | StrE efs1, StrE efs2 when List.map fst efs1 = List.map fst efs2 ->
      StrE (List.map2 (fun (a1, e1) (_, e2) -> (a1, overlap e1 e2)) efs1 efs2)
  | DotE (e1, atom1), DotE (e2, atom2) when atom1 = atom2 ->
      DotE (overlap e1 e2, atom1)
  | CompE (e1, e1'), CompE (e2, e2') ->
      CompE (overlap e1 e2, overlap e1' e2')
  | LenE e1, LenE e2 ->
      LenE (overlap e1 e2)
  | TupE es1, TupE es2 when List.length es1 = List.length es2 ->
      TupE (List.map2 overlap es1 es2)
  | MixE (mixop1, e1), MixE (mixop2, e2) when mixop1 = mixop2 ->
      MixE (mixop1, overlap e1 e2)
  | CallE (id1, e1), CallE (id2, e2) when Eq.eq_id id1 id2->
      CallE (id1, overlap e1 e2)
  | IterE (e1, itere1), IterE (e2, itere2) when Eq.eq_iterexp itere1 itere2 ->
      IterE (overlap e1 e2, itere1)
  | OptE (Some e1), OptE (Some e2) ->
      OptE (Some (overlap e1 e2))
  | TheE e1, TheE e2 ->
      TheE (overlap e1 e2)
  | ListE es1, ListE es2 when List.length es1 = List.length es2 ->
      ListE (List.map2 overlap es1 es2)
  | CatE (e1, e1'), CatE (e2, e2') ->
      CatE (overlap e1 e2, overlap e1' e2')
  | CaseE (atom1, e1), CaseE (atom2, e2) when atom1 = atom2 ->
      CaseE (atom1, overlap e1 e2)
  | SubE (e1, typ1, typ1'), SubE (e2, typ2, typ2') when Eq.eq_typ typ1 typ2 && Eq.eq_typ typ1' typ2' ->
      SubE (overlap e1 e2, typ1, typ1')
  | _ -> gen_new_unified() ) $$ (e1.at % e1.note)

let pairwise_concat (a,b) (c,d) = (a@c, b@d)

let rec collect_unified template e = if Eq.eq_exp template e then [], [] else match template.it, e.it with
  | VarE id, _ when String.starts_with ~prefix:"unified" id.it ->
    [Ast.AssignPr (e, Ast.VarE id $$ (no_region % template.note)) $ no_region],
    [id, (* TODO *) Ast.VarT ("TOP" $ no_region) $ no_region, []]
  (* one e *)
  | UnE (_, e1), UnE (_, e2)
  | DotE (e1, _), DotE (e2, _)
  | LenE e1, LenE e2
  | MixE (_, e1), MixE (_, e2)
  | CallE (_, e1), CallE (_, e2)
  | IterE (e1, _), IterE (e2, _)
  | OptE (Some e1), OptE (Some e2)
  | TheE e1, TheE e2
  | CaseE (_, e1), CaseE (_, e2)
  | SubE (e1, _, _), SubE (e2, _, _) -> collect_unified e1 e2
  (* two e *)
  | BinE (_, e1, e1'), BinE (_, e2, e2')
  | CmpE (_, e1, e1'), CmpE (_, e2, e2')
  | IdxE (e1, e1'), IdxE (e2, e2')
  | UpdE (e1, _, e1'), UpdE (e2, _, e2')
  | ExtE (e1, _, e1'), ExtE (e2, _, e2')
  | CompE (e1, e1'), CompE (e2, e2')
  | CatE (e1, e1'), CatE (e2, e2') -> pairwise_concat (collect_unified e1 e2) (collect_unified e1' e2')
  (* others *)
  | SliceE (e1, e1', e1''), SliceE (e2, e2', e2'') ->
      pairwise_concat (pairwise_concat (collect_unified e1 e2) (collect_unified e1' e2')) (collect_unified e1'' e2'')
  | StrE efs1, StrE efs2 ->
      List.fold_left2 (fun acc (_, e1) (_, e2) -> pairwise_concat acc (collect_unified e1 e2)) ([], []) efs1 efs2
  | TupE es1, TupE es2
  | ListE es1, ListE es2 ->
      List.fold_left2 (fun acc e1 e2 -> pairwise_concat acc (collect_unified e1 e2)) ([], []) es1 es2
  | _ -> failwith "Impossible"

let apply_template template (lhs, rhs, prems, binds) =
  let (new_prems, new_binds) = collect_unified template lhs in
  (template, rhs, new_prems @ prems, binds @ new_binds)

let unify_lhs (reduction_name, reduction_group) =
  init_unified_id();
  let lhs_group = List.map (function (lhs, _, _, _) -> lhs) reduction_group in
  let hd = List.hd lhs_group in
  let tl = List.tl lhs_group in
  let template = List.fold_left overlap hd tl in
  let new_reduction_group = List.map (apply_template template) reduction_group in
  (reduction_name, new_reduction_group)

let translate_rules il =
  let rules = List.concat_map extract_rules il in
  let reduction_groups : reduction_group list = group_rules rules in
  let unified_reduction_groups = List.map unify_lhs reduction_groups in

  List.map reduction_group2algo unified_reduction_groups

let replace_with e =
  match e.it with
  | Ast.UpdE (base, path, v) | Ast.ExtE (base, path, v) -> (
      match path2expr base path with
      | Al.AccessE (e, p) -> [ Al.ReplaceI (e, p, exp2expr v) ]
      | _ -> failwith "Impossible: path2expr always return AccessE")
  | _ -> []

let mutator2instrs clause =
  let (Ast.DefD (_binds, _e1, e2, prems)) = clause.it in

  prems2instrs [] prems
    (match e2.it with
    | Ast.MixE
        ([ []; [ Ast.Semicolon ]; [] ], { it = Ast.TupE [ new_s; new_f ]; _ })
      ->
        replace_with new_s @ replace_with new_f
    | _ -> [])

let helper2instrs clause =
  let (Ast.DefD (_binds, _e1, e2, prems)) = clause.it in
  prems2instrs [] prems [ Al.ReturnI (Option.some (exp2expr e2)) ]

(** Main translation for helper functions **)

let helpers2algo def =
  match def.it with
  | Ast.DecD (_, _, _, []) -> None
  | Ast.DecD (id, _t1, _t2, clauses) ->
      let (DefD (binds, params, _, _)) = (List.hd clauses).it in
      let typed_params =
        (match params.it with Ast.TupE exps -> exps | _ -> [ params ])
        |> List.map (find_type binds)
      in
      let blocks =
        if String.starts_with ~prefix:"with" id.it then
          List.map mutator2instrs clauses
        else List.map helper2instrs clauses
      in
      let algo_body = List.fold_right Transpile.merge_otherwise blocks [] in

      let algo = Al.Algo (id.it, typed_params, algo_body) in
      Some algo
  | _ -> None

let translate_helpers il = List.filter_map helpers2algo il

(** Entry **)

(* `Ast.script` -> `Al.Algo` *)
let translate il =
  let algos = translate_helpers il @ translate_rules il in

  (* Transpile *)
  (* Can be turned off *)
  List.map Transpile.transpiler algos
