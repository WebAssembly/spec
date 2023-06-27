open Il
open Printf
open Util.Source
open Al.Ast

(** helper functions **)

let check_nop instrs = match instrs with [] -> [ NopI ] | _ -> instrs

let gen_fail_msg_of_exp exp =
  Print.string_of_exp exp |> sprintf "Invalid expression `%s` to be AL %s."

let gen_fail_msg_of_prem prem =
  Print.string_of_prem prem |> sprintf "Invalid premise `%s` to be AL %s."

let list_partition_with pred xs =
  let rec list_partition acc = function
  | [] -> acc
  | hd :: tl ->
    let same_groups, diff_groups = List.partition (fun group -> pred (List.hd group) hd) acc in
    match same_groups with
    | [] -> list_partition ([ hd ] :: acc) tl
    | [ my_group ] -> list_partition ( (hd :: my_group) :: diff_groups) tl
    | _ -> failwith "Impossible list_partiton_with: perhaps pred is not equivalence relation"
  in
  list_partition [] xs |> List.rev

(* transform z; e into e *)
let drop_state e = match e.it with
| Ast.MixE (* z; e *)
    ( [ []; [ Ast.Semicolon ]; [ Ast.Star ] ],
      { it = Ast.TupE [ { it = Ast.VarE { it = "z"; _ }; _ }; e' ]; _ } )
  -> e'
| _ -> e

(* Ast.exp -> Ast.exp list *)
let rec flatten e =
  match e.it with
  | Ast.CatE (e1, e2) -> flatten e1 @ flatten e2
  | Ast.ListE es -> List.concat_map flatten es
  | _ -> [ e ]

let flatten_rec def =
  match def.it with Ast.RecD defs -> defs | _ -> [def]

(** Translate `Ast.type` **)
let rec il_type2al_type t =
  match t.it with
  | Ast.VarT id -> (
      match id.it with
      | "n" -> IntT
      | "numtype" -> IntT
      | idx when String.ends_with ~suffix:"idx" idx -> IntT
      | numerics when String.ends_with ~suffix:"_numtype" numerics -> StringT
      | "addr" -> AddrT
      | "functype" -> TopT
      | "cvtop" -> StringT
      | "sx" -> TopT
      | "val" -> WasmValueTopT
      | "valtype" -> WasmValueTopT
      | "frame" -> FrameT
      | "store" -> StoreT
      | "state" -> StateT
      | _ ->
          (* TODO *)
          (*sprintf "%s -> %s" debug (Print.string_of_typ t) |> print_endline;*)
          TopT)
  | Ast.NatT -> IntT
  | Ast.TupT [t1; t2] -> PairT (il_type2al_type t1, il_type2al_type t2)
  | Ast.IterT (ty, _) -> ListT (il_type2al_type ty)
  | _ -> failwith ("TODO: translate il_type into al_type of " ^ Print.string_of_typ t)

let get_params winstr =
  match winstr.it with
  | Ast.CaseE (_, { it = Ast.TupE exps; _ }) -> exps
  | Ast.CaseE (_, exp) -> [ exp ]
  | _ ->
      print_endline (Print.string_of_exp winstr ^ "is not a vaild wasm instruction.");
      []

(** Translate `Ast.exp` **)

(* `Ast.exp` -> `name` *)
let rec exp2name exp =
  match exp.it with
  | Ast.VarE id -> N id.it
  | Ast.SubE (inner_exp, _, _) -> exp2name inner_exp
  | _ ->
      gen_fail_msg_of_exp exp "identifier" |> print_endline;
      N "Yet"

let iter2iter = function
  | Ast.Opt -> Opt
  | Ast.List1 -> List1
  | Ast.List -> List
  | Ast.ListN e -> ListN (exp2name e)

(* `Ast.exp` -> `expr` *)
let rec exp2expr exp =
  match exp.it with
  | Ast.NatE n -> NumE (Int64.of_int n)
  (* List *)
  | Ast.LenE inner_exp -> LengthE (exp2expr inner_exp)
  | Ast.ListE exps -> ListE (List.map exp2expr exps)
  | Ast.IdxE (exp1, exp2) ->
      AccessE (exp2expr exp1, IndexP (exp2expr exp2))
  | Ast.SliceE (exp1, exp2, exp3) ->
      AccessE (exp2expr exp1, SliceP (exp2expr exp2, exp2expr exp3))
  | Ast.CatE (exp1, exp2) -> ConcatE (exp2expr exp1, exp2expr exp2)
  (* Variable *)
  | Ast.VarE id -> NameE (N id.it, [])
  | Ast.SubE (inner_exp, _, _) -> exp2expr inner_exp
  | Ast.IterE ({ it = Ast.CallE (id, inner_exp); _ }, (iter, _)) ->
      MapE (N id.it, exp2args inner_exp, [iter2iter iter])
  | Ast.IterE ({ it = Ast.ListE [{ it = Ast.VarE id; _ }]; _}, (iter, [id']))
    when id.it = id'.it -> (* TODO: Somehow remove this hack *)
      let name = N id.it in
      NameE (name, [iter2iter iter])
  | Ast.IterE ({ it = Ast.IterE (inner_exp, (inner_iter, [ inner_id ])); _ }, (iter, [ id ])) when id.it = inner_id.it ->
      let name = exp2name inner_exp in
      assert (name = N id.it);
      NameE (name, [iter2iter inner_iter; iter2iter iter])
  | Ast.IterE (inner_exp, (iter, [ id ])) ->
      let name = exp2name inner_exp in
      assert (name = N id.it);
      NameE (name, [iter2iter iter])
  | Ast.IterE (inner_exp, (Ast.ListN times, [])) ->
      ListFillE (exp2expr inner_exp, exp2expr times)
  (* property access *)
  | Ast.DotE (inner_exp, Atom p) -> AccessE (exp2expr inner_exp, DotP p)
  (* conacatenation of records *)
  | Ast.CompE (exp1, exp2) -> ConcatE (exp2expr exp1, exp2expr exp2)
  (* extension of record field *)
  | Ast.ExtE (base, path, v) -> ExtendE (exp2expr base, path2paths path, exp2expr v)
  (* update of record field *)
  | Ast.UpdE (base, path, v) -> ReplaceE (exp2expr base, path2paths path, exp2expr v)
  (* Binary / Unary operation *)
  | Ast.UnE (Ast.MinusOp, inner_exp) -> MinusE (exp2expr inner_exp)
  | Ast.BinE (op, exp1, exp2) ->
      let lhs = exp2expr exp1 in
      let rhs = exp2expr exp2 in
      let op = match op with
      | Ast.AddOp -> Add
      | Ast.SubOp -> Sub
      | Ast.MulOp -> Mul
      | Ast.DivOp -> Div
      | Ast.ExpOp -> Exp
      | _ -> gen_fail_msg_of_exp exp "binary expression" |> failwith
      in
      BinopE (op, lhs, rhs)
  (* ConstructE *)
  | Ast.CaseE (Ast.Atom cons, arg) -> ConstructE (cons, exp2args arg)
  (* Tuple *)
  | Ast.TupE exps -> ListE (List.map exp2expr exps)
  (* Call *)
  | Ast.CallE (id, inner_exp) -> AppE (N id.it, exp2args inner_exp)
  (* Record expression *)
  | Ast.StrE expfields ->
      let f acc = function
        | Ast.Atom name, fieldexp ->
            let expr = exp2expr fieldexp in
            Record.add name expr acc
        | _ -> gen_fail_msg_of_exp exp "record expression" |> failwith
      in
      let record = List.fold_left f Record.empty expfields in
      RecordE record
  | Ast.MixE (op, e) -> (
      let exps =
        match e.it with
        | TupE exps -> exps
        | _ -> [ e ]
      in
      match (op, exps) with
      | [ []; []; [] ], [ e1; e2 ]
      | [ []; [ Ast.Semicolon ]; [] ], [ e1; e2 ]
      | [ [ Ast.LBrack ]; [ Ast.Dot2 ]; [ Ast.Quest; Ast.RBrack ]], [ e1; e2 ] ->
          PairE (exp2expr e1, exp2expr e2)
      | [ []; [ Ast.Arrow ]; [] ], [ e1; e2 ] ->
          ArrowE (exp2expr e1, exp2expr e2)
      (* Constructor *)
      | [ [ Ast.Atom "FUNC" ]; []; [ Ast.Star ]; [] ], _ ->
          ConstructE ("FUNC", List.map exp2expr exps)
      | [ [ Ast.Atom tag ] ], [] ->
          ConstructE (tag, [])
      | [ [ Ast.Atom "MUT" ]; [ Ast.Quest ]; [] ],
        [ { it = Ast.OptE (Some { it = Ast.TupE []; _ }); _}; t ] ->
          PairE (ConstructE ("MUT", []), exp2expr t)
      | [ [ Ast.Atom "MUT" ]; [ Ast.Quest ]; [] ],
        [ { it = Ast.IterE ({ it = Ast.TupE []; _ }, (Ast.Opt, [])); _}; t ] ->
          PairE (NameE (N "mut", [ Opt ]), exp2expr t)
      | [ [ Ast.Atom "MODULE" ]; [Star]; [Star]; [Star]; [Star]; [Star]; [Star]; [Star]; [Quest]; [Star] ], el ->
          ConstructE ("MODULE", List.map exp2expr el)
      | [ [ Ast.Atom "IMPORT" ]; []; []; [] ], el ->
          ConstructE ("IMPORT", List.map exp2expr el)
      | [ [ Ast.Atom "GLOBAL" ]; []; [] ], el ->
          ConstructE ("GLOBAL", List.map exp2expr el)
      | [ [ Ast.Atom "TABLE" ]; [] ], el ->
          ConstructE ("TABLE", List.map exp2expr el)
      | [ [ Ast.Atom "MEMORY" ]; [] ], el ->
          ConstructE ("MEMORY", List.map exp2expr el)
      | [ []; [ Ast.Atom "I8" ] ], el ->
          ConstructE ("I8", List.map exp2expr el)
      | [ [ Ast.Atom "ELEM" ]; []; [ Ast.Star ]; [ Ast.Quest ] ], el ->
          ConstructE ("ELEM", List.map exp2expr el)
      | [ [ Ast.Atom "DATA" ]; [ Ast.Star ]; [ Ast.Quest ] ], el ->
          ConstructE ("DATA", List.map exp2expr el)
      | [ [ Ast.Atom "START" ]; [] ], el ->
          ConstructE ("START", List.map exp2expr el)
      | [ [ Ast.Atom "EXPORT" ]; []; [] ], el ->
          ConstructE ("EXPORT", List.map exp2expr el)
      | _ -> YetE (Print.structured_string_of_exp exp))
  | Ast.OptE inner_exp -> OptE (Option.map exp2expr inner_exp)
  (* Yet *)
  | _ -> YetE (Print.string_of_exp exp)

(* `Ast.exp` -> `expr` *)
and exp2args exp =
  match exp.it with
  | Ast.TupE el -> List.map exp2expr el
  | _ -> [ exp2expr exp ]

(* `Ast.path` -> `path list` *)
and path2paths path =
  let rec path2paths' path = 
    match path.it with
    | Ast.RootP -> []
    | Ast.IdxP (p, e) -> (path2paths' p) @ [ IndexP (exp2expr e) ]
    | Ast.SliceP (p, e1, e2) -> (path2paths' p) @ [ SliceP (exp2expr e1, exp2expr e2) ] 
    | Ast.DotP (p, Atom a) -> (path2paths' p) @ [ DotP a ]
    | _ -> failwith "unreachable"
  in
  path2paths' path

(* `Ast.exp` -> `AssertI` *)
let insert_assert exp =
  match exp.it with
  | Ast.CaseE (Ast.Atom "FRAME_", _) ->
      AssertI "Due to validation, the frame F is now on the top of the stack"
  | Ast.CatE (_val', { it = Ast.CatE (_valn, _); _ }) ->
      AssertI "Due to validation, the stack contains at least one frame"
  | Ast.IterE (_, (Ast.ListN { it = VarE n; _ }, _)) ->
      AssertI
        (sprintf
           "Due to validation, there are at least %s values on the top of the \
            stack"
           n.it)
  | Ast.CaseE (Ast.Atom "LABEL_", { it = Ast.TupE [ _n; _instrs; _vals ]; _ })
    ->
      AssertI "Due to validation, the label L is now on the top of the stack"
  | Ast.CaseE
      ( Ast.Atom "CONST",
        { it = Ast.TupE (ty :: _); _ }) ->
      AssertI (
        "Due to validation, a value of value type "
        ^ Print.string_of_exp ty
        ^ " is on the top of the stack" )
  | _ -> AssertI "Due to validation, a value is on the top of the stack"

(* `Ast.exp list` -> `Ast.exp list * instr list` *)
let handle_lhs_stack =
  List.fold_left
    (fun (instrs, rest) e ->
      if List.length rest > 0 then (instrs, rest @ [ e ])
      else
        match e.it with
        | Ast.IterE (_, (ListN _, _)) -> (instrs, [ e ])
        | _ -> (instrs @ [ insert_assert e; PopI (exp2expr e) ], rest))
    ([], [])

let handle_context_winstr winstr =
  match winstr.it with
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
          LetI (NameE (N name.it, []), GetCurFrameE);
          LetI
            (NameE (N arity.it, []), ArityE (NameE (N name.it, [])));
        ]
      in
      let pop_instrs =
        match inner_exp.it with
        (* hardcoded pop instructions for "frame" reduction rule *)
        | Ast.IterE (_, _) ->
            [ insert_assert inner_exp; PopI (exp2expr inner_exp) ]
        (* hardcoded pop instructions for "return" reduction rule *)
        | Ast.CatE (_val', { it = Ast.CatE (valn, _); _ }) ->
            [
              insert_assert valn;
              PopI (exp2expr valn);
              insert_assert inner_exp;
              (* While the top of the stack is not a frame, do ... *)
              WhileI
                ( NotC
                    (CompareC
                       ( Eq, NameE (N "the top of the stack", []),
                         NameE (N "a frame", []) )),
                  [ PopI (NameE (N "the top element", [])) ] );
            ]
        | _ -> gen_fail_msg_of_exp inner_exp "Pop instruction" |> failwith
      in
      let pop_frame_instrs =
        [ insert_assert winstr; PopI (NameE (N "the frame", [])) ]
      in
      let_instrs @ pop_instrs @ pop_frame_instrs
  (* Label *)
  | Ast.CaseE
      (Ast.Atom "LABEL_", { it = Ast.TupE [ _n; _instrs; vals ]; _ }) ->
      [
        (* TODO: append Jump instr *)
        PopAllI (exp2expr vals);
        insert_assert winstr;
        PopI (NameE (N "the label", []));
      ]
  | _ -> []

let handle_context ctx values = match ctx.it, values with
  | Ast.CaseE (Ast.Atom "LABEL_", { it = Ast.TupE [ n; instrs; _hole ]; _ }), vs ->
      let first_vs, last_v = Util.Lib.List.split_last vs in
      [
        LetI (NameE (N "L", []), GetCurLabelE);
        LetI (exp2expr n, ArityE (NameE (N "L", [])));
        LetI (exp2expr instrs, ContE (NameE (N "L", [])));
        ]@ List.map (fun v -> PopI (exp2expr v)) first_vs @[
        PopAllI (exp2expr last_v);
        ExitAbruptI (N "L");
      ]
  | Ast.CaseE (Ast.Atom "FRAME_", { it = Ast.TupE [ n; _f; _hole ]; _ }), vs ->
      let first_vs, last_v = Util.Lib.List.split_last vs in
      [
        LetI (NameE (N "F", []), GetCurFrameE);
        LetI (exp2expr n, ArityE (NameE (N "F", [])));
        ]@ List.map (fun v -> PopI (exp2expr v)) first_vs @[
        PopAllI (exp2expr last_v);
        ExitAbruptI (N "F");
      ]
  | _ -> [ YetI "TODO: handle_context" ]

(* `Ast.exp` -> `instr list` *)
let rec rhs2instrs exp =
  match exp.it with
  (* Trap *)
  | Ast.CaseE (Atom "TRAP", _) -> [ TrapI ]
  (* Execute instrs *) (* TODO: doing this based on variable name is too ad-hoc. Need smarter way. *)
  | Ast.IterE ({ it = VarE id; _ }, (Ast.List, _))
  | Ast.IterE ({ it = Ast.SubE ({ it = VarE id; _ }, _, _); _}, (Ast.List, _))
    when id.it = "instr" || id.it = "instr'" ->
      [ ExecuteSeqI (exp2expr exp) ]
  (* Push *)
  | Ast.SubE _ | IterE _ -> [ PushI (exp2expr exp) ]
  | Ast.CaseE (Atom atomid, _)
    when atomid = "CONST" || atomid = "REF.FUNC_ADDR" ->
      [ PushI (exp2expr exp) ]
  (* multiple rhs' *)
  | Ast.CatE (exp1, exp2) -> rhs2instrs exp1 @ rhs2instrs exp2
  | Ast.ListE exps -> List.concat_map rhs2instrs exps
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
        PushI
          (FrameE (NameE (N arity.it, []), NameE (N fname.it, [])))
      in
      let exit_instr = ExitNormalI (N fname.it) in
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
        LabelE (NameE (N label_arity.it, []), exp2expr instrs_exp1)
      in
      match instrs_exp2.it with
      | Ast.CatE (valexp, instrsexp) ->
          [
            LetI (NameE (N "L", []), label_expr);
            PushI (NameE (N "L", []));
            PushI (exp2expr valexp);
            JumpI (exp2expr instrsexp);
            ExitNormalI (N "L");
          ]
      | _ ->
          [
            LetI (NameE (N "L", []), label_expr);
            PushI (NameE (N "L", []));
            JumpI (exp2expr instrs_exp2);
            ExitNormalI (N "L");
          ])
  (* Execute instr *)
  | Ast.CaseE (Atom atomid, argexp) ->
      [ ExecuteI (ConstructE (atomid, exp2args argexp)) ]
  | Ast.MixE
      ( [ []; [ Ast.Semicolon ]; [ Ast.Star ] ],
        (* z' ; instr'* *)
        { it = TupE [ state_exp; rhs ]; _ } ) -> (
      let push_instrs = rhs2instrs rhs in
      match state_exp.it with
      | VarE _ -> push_instrs
      | _ -> push_instrs @ [ PerformI (exp2expr state_exp) ])
  | _ -> gen_fail_msg_of_exp exp "rhs instructions" |> failwith

(* `Ast.exp` -> `cond` *)
let rec exp2cond exp =
  match exp.it with
  | Ast.CmpE (op, exp1, exp2) ->
      let lhs = exp2expr exp1 in
      let rhs = exp2expr exp2 in
      let compare_op = match op with
      | Ast.EqOp -> Eq
      | Ast.NeOp -> Ne
      | Ast.GtOp -> Gt
      | Ast.GeOp -> Ge
      | Ast.LtOp -> Lt
      | Ast.LeOp -> Le
      in
      CompareC (compare_op, lhs, rhs)
  | Ast.BinE (op, exp1, exp2) ->
      let lhs = exp2cond exp1 in
      let rhs = exp2cond exp2 in
      let binop = match op with
      | Ast.AndOp -> And
      | Ast.OrOp -> Or
      | Ast.ImplOp -> Impl
      | Ast.EquivOp -> Equiv
      | _ ->
          gen_fail_msg_of_exp exp "binary expression for condition" |> failwith
      in
      BinopC (binop, lhs, rhs)
  | _ -> gen_fail_msg_of_exp exp "condition" |> failwith

let bound_by binding e =
  match e.it with
  | Ast.IterE (_, (ListN { it = VarE { it = n; _ }; _ }, _)) ->
      if Free.Set.mem n (Free.free_exp binding).varid then
        [ insert_assert e; PopI (exp2expr e) ]
      else []
  | _ -> []

let lhs_id_ref = ref 0
let lhs_prefix = "_y"
let init_lhs_id () = lhs_id_ref := 0
let get_lhs_name () =
  let lhs_id = !lhs_id_ref in
  lhs_id_ref := (lhs_id + 1);
  NameE (N (lhs_prefix ^ (lhs_id |> string_of_int)), [])

let rec letI lhs rhs cont =
  let extract_non_names = List.fold_left_map (fun acc e -> match e with
    | NameE _ -> acc, e
    | _ ->
      let fresh = get_lhs_name() in
      [ e, fresh ] @ acc, fresh
  ) [] in
  match lhs with
  | ConstructE (tag, es) ->
    let bindings, es' = extract_non_names es in
    [
      IfI
        ( IsCaseOfC (rhs, tag),
          LetI (ConstructE (tag, es'), rhs) :: List.fold_right (fun (l, r) cont -> letI l r cont) bindings cont,
          [] );
    ]
  | ListE es ->
    let bindings, es' = extract_non_names es in
    if List.length es >= 2 then (* TODO: remove this. This is temporarily for a pure function returning stores *)
    LetI (ListE es', rhs) :: List.fold_right (fun (l, r) cont -> letI l r cont) bindings cont
    else
    [
      IfI
        ( CompareC (Eq, LengthE rhs, NumE (Int64.of_int (List.length es))),
          LetI (ListE es', rhs) :: List.fold_right (fun (l, r) cont -> letI l r cont) bindings cont,
          [] );
    ]
  | OptE None ->
    [
      IfI
        ( NotC (IsDefinedC rhs),
          cont,
          [] );
    ]
  | OptE (Some (NameE _)) ->
    [
      IfI
        ( IsDefinedC rhs,
          LetI (lhs, rhs) :: cont,
          [] );
     ]
  | OptE (Some e) ->
    let fresh = get_lhs_name() in
    [
      IfI
        ( IsDefinedC rhs,
          LetI (OptE (Some fresh), rhs) :: letI e fresh cont,
          [] );
     ]
  | BinopE (Add, a, b) ->
    [
      IfI
        ( CompareC (Ge, rhs, b),
          LetI (a, BinopE (Sub, rhs, b)) :: cont,
          [] );
    ]
  | _ -> LetI (lhs, rhs) :: cont

(** `Il.instr expr list` -> `prems -> `instr list` -> `instr list` **)
let prems2instrs remain_lhs =
  List.fold_right (fun prem instrs ->
      match prem.it with
      | Ast.IfPr exp -> [ IfI (exp2cond exp, instrs |> check_nop, []) ]
      | Ast.ElsePr -> [ OtherwiseI (instrs |> check_nop) ]
      | Ast.LetPr (exp1, exp2) ->
          let instrs' = List.concat_map (bound_by exp1) remain_lhs @ instrs in
          init_lhs_id();
          letI (exp2expr exp1) (exp2expr exp2) instrs'
      | Ast.RulePr (id, _, exp) when String.ends_with ~suffix:"_ok" id.it ->
        ( match exp2args exp with
        | [ lim ] -> [ IfI (ValidC lim, instrs |> check_nop, []) ]
        | _ -> failwith "prem_to_instr: Invalid prem"
        )
      (* Step *)
      | Ast.RulePr (
        id,
        [ []; [ Ast.SqArrow ]; _ ],
        { it = Ast.TupE [
          (* s; f; lhs *)
          { it = Ast.MixE ([ []; [ Ast.Semicolon ]; _ ], { it = Ast.TupE [
            { it = Ast.MixE ([ []; [ Ast.Semicolon ]; _ ], { it = Ast.TupE [
              { it = Ast.VarE _s; _ }; { it = Ast.VarE _f; _ }
            ]; _ }); _ };
            lhs
          ]; _ }); _ };
          (* s; f; rhs *)
          { it = Ast.MixE ([ []; [ Ast.Semicolon ]; _ ], { it = Ast.TupE [
            { it = Ast.MixE ([ []; [ Ast.Semicolon ]; _ ], { it = Ast.TupE [
              { it = Ast.VarE _(* s' *); _ }; { it = Ast.VarE _(* f' *); _ }
            ]; _ }); _ };
            rhs
          ]; _ }); _ };
        ]; _ }
      )
      | Ast.RulePr (
        id,
        [ []; [ Ast.SqArrow ]; _ ],
        { it = Ast.TupE [
          (* s; f; lhs *)
          { it = Ast.MixE ([ []; [ Ast.Semicolon ]; _ ], { it = Ast.TupE [
            { it = Ast.MixE ([ []; [ Ast.Semicolon ]; _ ], { it = Ast.TupE [
              { it = Ast.VarE _s; _ }; { it = Ast.VarE _f; _ }
            ]; _ }); _ };
            lhs
          ]; _ }); _ };
          (* s; f; rhs *)
            rhs
        ]; _ }
      ) when String.starts_with ~prefix:"Step" id.it ->
          let rec lhs_instr lhs =
            match lhs with
            | ListE el -> List.map (fun expr -> ExecuteI expr) el
            | ConcatE (e1, e2) ->
                lhs_instr e1 @ lhs_instr e2
            | NameE (N "val", _) | NameE (N "ref", _) -> [ PushI lhs ]
            | expr -> [ ExecuteSeqI expr ]
          in
          let rhs_instrs =
            match exp2expr rhs with
            | ListE [] -> []
            | ListE [ expr ] -> [ PopI expr ]
            | expr -> [ PopI expr ]
          in
          lhs_instr (exp2expr lhs) @ rhs_instrs @ instrs
      | Ast.IterPr ({ it = Ast.RulePr (
        id,
        [ []; [ Ast.SqArrow ]; _ ],
        { it = Ast.TupE [
          (* s; f; lhs *)
          { it = Ast.MixE ([ []; [ Ast.Semicolon ]; _ ], { it = Ast.TupE [
            { it = Ast.MixE ([ []; [ Ast.Semicolon ]; _ ], { it = Ast.TupE [
              { it = Ast.VarE _s; _ }; { it = Ast.VarE _f; _ }
            ]; _ }); _ };
            lhs
          ]; _ }); _ };
          (* s; f; rhs *)
            rhs
        ]; _ }
      ); _ }, (Ast.List, [ instr; ref ])) when String.starts_with ~prefix:"Step" id.it ->
          let lhs_instr =
            match exp2expr lhs with
            | NameE (name, iter) when name = N instr.it ->
                ExecuteSeqI (NameE (name, iter @ [ List ]))
            | _ -> failwith "Invalid IterPr"
          in
          let rhs_instr =
            match exp2expr rhs with
            | ListE [ NameE (name, iter) ] when name = N ref.it ->
                PopI (NameE (name, iter @ [ List ]))
            | _ -> failwith "Invalid IterPr"
          in
          [ lhs_instr; rhs_instr ] @ instrs
      | _ ->
          gen_fail_msg_of_prem prem "instr" |> print_endline;
          YetI (Il.Print.string_of_prem prem) :: instrs)

(** reduction -> `instr list` **)

let reduction2instrs remain_lhs (_, rhs, prems, _) =
  prems2instrs remain_lhs prems (rhs2instrs rhs)

(* TODO: Perhaps this should be tail recursion *)
let rec split_context_winstr name stack =
  let wrap e = e $$ no_region % (Ast.VarT ("TOP" $ no_region) $ no_region) in
  match stack with
  | [] ->
    [ ([], []), None ], Ast.CaseE (Ast.Atom (String.uppercase_ascii name), (Ast.TupE []) |> wrap) |> wrap
  | hd :: tl ->
    match hd.it with
    | Ast.CaseE (Ast.Atom name', _)
      when name = (String.lowercase_ascii name')
      || name ^ "_"  = (String.lowercase_ascii name') ->
      [ (tl, []), None ], hd
    (* Assumption: The target winstr is inside the first list-argument of this CaseE *)
    | Ast.CaseE (a, ({it = Ast.TupE args; _} as e)) ->
      let is_list e = match e.it with Ast.CatE _ | Ast.ListE _ -> true | _ -> false in
      let list_arg = List.find is_list args in
      let inner_stack = list_arg |> flatten |> List.rev in

      let context, winstr = split_context_winstr name inner_stack in

      let hole = Ast.TextE "_" |> wrap in
      let holed_args = List.map (fun x -> if x = list_arg then hole else x) args in
      let ctx = { hd with it = Ast.CaseE (a, { e with it = Ast.TupE holed_args }) } in
      let new_context = ((tl, []), Some ctx) :: context in
      new_context, winstr
    | _ ->
      let context, winstr = split_context_winstr name tl in
      let ((vs, is), c), inners = Util.Lib.List.split_hd context in
      let new_context = ((vs, hd :: is), c) :: inners in
      new_context, winstr

let rec find_type tenv exp =
  let to_NameE x = NameE (N x, []) in
  let append_iter name iter = match name with
  | NameE (n, iters) -> NameE (n, iter :: iters)
  | _ -> failwith "Unreachable" in
  match exp.it with
  | Ast.VarE id -> (
      match List.find_opt (fun (id', _, _) -> id'.it = id.it) tenv with
      | Some (_, t, []) -> (id.it |> to_NameE, il_type2al_type t)
      | Some (_, t, _) -> (id.it |> to_NameE, ListT (il_type2al_type t))
      | _ ->
          failwith
            (id.it ^ "'s type is unknown. There must be a problem in the IL."))
  | Ast.IterE (inner_exp, iter) ->
      let name, ty = find_type tenv inner_exp in
      append_iter name (iter2iter (fst iter)), ty
  | Ast.SubE (inner_exp, _, _) ->
      find_type tenv inner_exp
  | Ast.MixE ([ []; [ Ast.Semicolon ]; [] ], { it = Ast.TupE [ st; fr ]; _ })
    -> (
      match (find_type tenv st, find_type tenv fr) with
      | (s, StoreT), (f, FrameT) -> (PairE (s, f), StateT)
      | _ -> (Print.string_of_exp exp |> to_NameE, TopT))
  | _ -> (Print.string_of_exp exp |> to_NameE, TopT)

let un_unify (_, rhs, prems, binds) =
  let sub, new_prems = Util.Lib.List.split_hd prems in
  let new_binds = binds in (* TODO *)
  match sub.it with
  | Ast.LetPr (new_lhs, _) -> (new_lhs, rhs, new_prems, new_binds)
  | _ -> failwith "Unrechable un_unify"

let is_in_same_context (lhs1, _, _, _) (lhs2, _, _, _) =
  match lhs1.it, lhs2.it with
  | Ast.CaseE (atom1, _), Ast.CaseE (atom2, _) -> atom1 = atom2
  | _, _ -> false

let kind_of_context e =
  match e.it with
  | Ast.CaseE (Ast.Atom "FRAME_", _) -> "frame"
  | Ast.CaseE (Ast.Atom "LABEL_", _) -> "label"
  | _ -> "Could not get kind_of_context" ^ Print.string_of_exp e |> failwith

(** Main translation for reduction rules **)
(* `reduction_group list` -> `Backend-prose.Algo` *)
let rec reduction_group2algo (instr_name, reduction_group) =
  let (lhs, _, _, tenv) = List.hd reduction_group in
  let lhs_stack = lhs |> drop_state |> flatten |> List.rev in
  let context, winstr = split_context_winstr instr_name lhs_stack in
  let instrs = match context with
    | [(vs, []), None ] ->
      let pop_instrs, remain = handle_lhs_stack vs in
      let inner_pop_instrs = handle_context_winstr winstr in

      let instrs = match reduction_group |> Util.Lib.List.split_last with
      (* No premise for last reduction rule: either *)
      | hds, (_, rhs, [], _) when List.length hds > 0 ->
          assert (List.length remain = 0);
          let blocks = List.map (reduction2instrs []) hds in
          let either_body1 = List.fold_right Transpile.merge blocks [] in
          let either_body2 = rhs2instrs rhs |> check_nop in
          EitherI (either_body1, either_body2) |> Transpile.push_either
      (* Normal case *)
      | _ ->
          let blocks = List.map (reduction2instrs remain) reduction_group in
          List.fold_right Transpile.merge blocks [] in

      pop_instrs @ inner_pop_instrs @ instrs
    (* The target instruction is inside a context *)
    | [ ([], []), Some context ; (vs, _is), None ] ->
      let head_instrs = handle_context context vs in
      let body_instrs = List.map (reduction2instrs []) reduction_group |> List.concat in
      head_instrs @ body_instrs
    (* The target ubstruction is inside differnet contexts (i.e. return in both label and frame) *)
    | [ ([], [ _ ]), None ] ->
      let orig_group = List.map un_unify reduction_group in
      let sub_groups = list_partition_with is_in_same_context orig_group in
      let unified_sub_groups = List.map (fun g -> Il2il.unify_lhs (instr_name, g)) sub_groups in
      let lhss = List.map (function _, group -> let lhs, _, _, _ = List.hd group in lhs) unified_sub_groups in
      let sub_algos = List.map reduction_group2algo unified_sub_groups in
      List.fold_right2 (fun lhs -> function Algo (_, _, body) -> fun acc ->
        let kind = kind_of_context lhs in
        [ IfI (
          ContextKindC (kind, GetCurContextE),
          body,
          acc) ]
      ) lhss sub_algos []
    | _ ->
      [ YetI "TODO" ] in

  (* name *)
  let name = "execution_of_" ^ instr_name in
  (* params *)
  (* TODO: retieve param for return *)
  let params =
    if instr_name = "frame" || instr_name = "label"
    then []
    else
      get_params winstr |> List.map (find_type tenv)
  in
  (* body *)
  let body = instrs |> check_nop |> Transpile.enhance_readability in

  (* Algo *)
  Algo (name, params, body)

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
      let same_rules, diff_rules =
        List.partition (fun rule -> name_of_rule rule = name) t in
      let group = (name, List.map rule2tup (h :: same_rules)) in
      group :: group_rules diff_rules

(** Entry for translating reduction rules **)
let translate_rules il =
  let rules = List.concat_map extract_rules il in
  let reduction_groups : reduction_group list = group_rules rules in
  let unified_reduction_groups = List.map Il2il.unify_lhs reduction_groups in

  List.map reduction_group2algo unified_reduction_groups

(* `Ast.exp` -> `Ast.path` -> `expr` *)
let path2expr exp path =
  let rec path2expr' path =
    match path.it with
    | Ast.RootP -> exp
    | Ast.IdxP (p, e) -> Ast.IdxE (path2expr' p, e) $$ (path.at % path.note)
    | Ast.SliceP (p, e1, e2) -> Ast.SliceE (path2expr' p, e1, e2) $$ (path.at % path.note)
    | Ast.DotP (p, a) -> Ast.DotE (path2expr' p, a) $$ (path.at % path.note)
  in
  path2expr' path |> exp2expr

let exp2mutating_instr e =
  match e.it with
  | Ast.UpdE (base, path, v) -> (
      match path2expr base path with
      | AccessE (e, p) -> [ ReplaceI (e, p, exp2expr v) ]
      | _ -> failwith "Impossible: path2expr always return AccessE" )
  | Ast.ExtE (base, path, v) -> [ AppendListI (path2expr base path, exp2expr v) ]
  | Ast.VarE _ -> []
  | _ -> failwith ("TODO: exp2mutating_instr" ^ Print.string_of_exp e)

let writer2instrs clause =
  let Ast.DefD (_binds, _e1, e2, prems) = clause.it in

  prems2instrs [] prems
    (match e2.it with
    | Ast.MixE ([ []; [ Ast.Semicolon ]; [] ], { it = Ast.TupE [ new_s; new_f ]; _ }) ->
        exp2mutating_instr new_s @ exp2mutating_instr new_f
    | _ -> [])

let reader2instrs clause =
  let Ast.DefD (_binds, _e1, e2, prems) = clause.it in
  prems2instrs [] prems [ ReturnI (Option.some (exp2expr e2)) ]

(** Main translation for helper functions **)
let helpers2algo def =
  match def.it with
  | Ast.DecD (_, _, _, []) -> None
  | Ast.DecD (id, _t1, _t2, clauses) ->
      let unified_clauses = Il2il.unify_defs clauses in
      let Ast.DefD (binds, params, _, _) = (List.hd unified_clauses).it in
      let typed_params =
        (match params.it with Ast.TupE exps -> exps | _ -> [ params ])
        |> List.map (find_type binds)
      in
      let translator = if String.starts_with ~prefix:"with" id.it then writer2instrs else reader2instrs in
      let blocks = List.map translator unified_clauses in
      let algo_body = List.fold_right Transpile.merge blocks [] |> Transpile.enhance_readability in

      let algo = Algo (id.it, typed_params, algo_body) in
      Some algo
  | _ -> None

(** Entry for translating helper functions **)
let translate_helpers il = List.filter_map helpers2algo il

(** Entry **)

(* `Ast.script` -> `Algo` *)
let translate il =
  let il = List.concat_map flatten_rec il in
  let algos = translate_helpers il @ translate_rules il in

  (* Transpile *)
  (* Can be turned off *)
  List.map Transpile.transpiler algos
