open Il
open Printf
open Util.Source

(** helper functions **)

let check_nop instrs = match instrs with [] -> [ Al.NopI ] | _ -> instrs

let gen_fail_msg_of_exp exp =
  Print.string_of_exp exp |> sprintf "Invalid expression `%s` to be AL %s."

let gen_fail_msg_of_prem prem =
  Print.string_of_prem prem |> sprintf "Invalid premise `%s` to be AL %s."

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
  | Ast.TupT [t1; t2] -> Al.PairT (il_type2al_type t1, il_type2al_type t2)
  | Ast.IterT (ty, _) -> Al.ListT (il_type2al_type ty)
  | _ -> failwith ("TODO: translate il_type into al_type of " ^ Print.string_of_typ t)

let get_params winstr =
  match winstr.it with
  | Ast.CaseE (_, { it = Ast.TupE exps; _ }) -> exps
  | Ast.CaseE (_, exp) -> [ exp ]
  | _ ->
      print_endline (Print.string_of_exp winstr ^ "is not a vaild wasm instruction.");
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

let iter2iter = function
  | Ast.Opt -> Al.Opt
  | Ast.List1 -> Al.List1
  | Ast.List -> Al.List
  | Ast.ListN e -> Al.ListN (exp2name e)

(* `Ast.exp` -> `Al.expr` *)
let rec exp2expr exp =
  match exp.it with
  | Ast.NatE n -> Al.NumE (Int64.of_int n)
  (* List *)
  | Ast.LenE inner_exp -> Al.LengthE (exp2expr inner_exp)
  | Ast.ListE exps -> Al.ListE (List.map exp2expr exps)
  | Ast.IdxE (exp1, exp2) ->
      Al.AccessE (exp2expr exp1, Al.IndexP (exp2expr exp2))
  | Ast.SliceE (exp1, exp2, exp3) ->
      Al.AccessE (exp2expr exp1, Al.SliceP (exp2expr exp2, exp2expr exp3))
  | Ast.CatE (exp1, exp2) -> Al.ConcatE (exp2expr exp1, exp2expr exp2)
  (* Variable *)
  | Ast.VarE id -> Al.NameE (N id.it, [])
  | Ast.SubE (inner_exp, _, _) -> exp2expr inner_exp
  | Ast.IterE ({ it = Ast.CallE (id, inner_exp); _ }, (iter, _)) ->
      Al.MapE (N id.it, exp2args inner_exp, [iter2iter iter])
  | Ast.IterE ({ it = Ast.ListE [{ it = Ast.VarE id; _ }]; _}, (iter, [id']))
    when id.it = id'.it -> (* TODO: Somehow remove this hack *)
      let name = Al.N id.it in
      Al.NameE (name, [iter2iter iter])
  | Ast.IterE (inner_exp, (iter, [ id ])) ->
      let name = exp2name inner_exp in
      assert (name = Al.N id.it);
      Al.NameE (name, [iter2iter iter])
  | Ast.IterE (inner_exp, (Ast.ListN times, [])) ->
      Al.ListFillE (exp2expr inner_exp, exp2expr times)
  (* property access *)
  | Ast.DotE (inner_exp, Atom p) -> Al.AccessE (exp2expr inner_exp, Al.DotP p)
  (* conacatenation of records *)
  | Ast.CompE (exp1, exp2) -> Al.ConcatE (exp2expr exp1, exp2expr exp2)
  (* Binary / Unary operation *)
  | Ast.UnE (Ast.MinusOp, inner_exp) -> Al.MinusE (exp2expr inner_exp)
  | Ast.BinE (op, exp1, exp2) ->
      let lhs = exp2expr exp1 in
      let rhs = exp2expr exp2 in
      let op = match op with
      | Ast.AddOp -> Al.Add
      | Ast.SubOp -> Al.Sub
      | Ast.MulOp -> Al.Mul
      | Ast.DivOp -> Al.Div
      | Ast.ExpOp -> Al.Exp
      | _ -> gen_fail_msg_of_exp exp "binary expression" |> failwith
      in
      Al.BinopE (op, lhs, rhs)
  (* ConstructE *)
  | Ast.CaseE (Ast.Atom cons, arg) -> Al.ConstructE (cons, exp2args arg)
  (* Tuple *)
  | Ast.TupE exps -> Al.ListE (List.map exp2expr exps)
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
      | [ []; []; [] ], [ e1; e2 ]
      | [ []; [ Ast.Semicolon ]; [] ], [ e1; e2 ] ->
          Al.PairE (exp2expr e1, exp2expr e2)
      | [ []; [ Ast.Arrow ]; [] ], [ e1; e2 ] ->
          Al.ArrowE (exp2expr e1, exp2expr e2)
      | [ [ Ast.Atom "FUNC" ]; []; [ Ast.Star ]; [] ], _ ->
          Al.ConstructE ("FUNC", List.map exp2expr exps)
      | [ [ Ast.Atom tag ] ], [] ->
          Al.ConstructE (tag, [])
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
        { it = Ast.TupE (ty :: _); _ }) ->
      Al.AssertI (
        "Due to validation, a value of value type "
        ^ Print.string_of_exp ty
        ^ " is on the top of the stack" )
  | _ -> Al.AssertI "Due to validation, a value is on the top of the stack"

(* `Ast.exp list` -> `Ast.exp list * Al.instr list` *)
let handle_lhs_stack =
  List.fold_left
    (fun (instrs, rest) e ->
      if List.length rest > 0 then (instrs, rest @ [ e ])
      else
        match e.it with
        | Ast.IterE (_, (ListN _, _)) -> (instrs, [ e ])
        | _ -> (instrs @ [ insert_assert e; Al.PopI (exp2expr e) ], rest))
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
          Al.LetI (Al.NameE (Al.N name.it, []), Al.GetCurFrameE);
          Al.LetI
            (Al.NameE (Al.N arity.it, []), Al.ArityE (Al.NameE (Al.N name.it, [])));
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
                    (Al.CompareC
                       ( Al.Eq, Al.NameE (Al.N "the top of the stack", []),
                         Al.NameE (Al.N "a frame", []) )),
                  [ Al.PopI (Al.NameE (Al.N "the top element", [])) ] );
            ]
        | _ -> gen_fail_msg_of_exp inner_exp "Pop instruction" |> failwith
      in
      let pop_frame_instrs =
        [ insert_assert winstr; Al.PopI (Al.NameE (Al.N "the frame", [])) ]
      in
      let_instrs @ pop_instrs @ pop_frame_instrs
  (* Label *)
  | Ast.CaseE
      (Ast.Atom "LABEL_", { it = Ast.TupE [ _n; _instrs; vals ]; _ }) ->
      [
        (* TODO: append Jump instr *)
        Al.PopI (exp2expr vals);
        insert_assert winstr;
        Al.PopI (Al.NameE (N "the label", []));
      ]
  | _ -> []

let handle_context ctx values = match ctx.it, values with
  | Ast.CaseE (Ast.Atom "LABEL_", { it = Ast.TupE [ n; instrs; _vals ]; _ }), [ v ] ->
      [
        Al.LetI (NameE (N "L", []), GetCurLabelE);
        Al.LetI (exp2expr n, ArityE (NameE (N "L", [])));
        Al.LetI (exp2expr instrs, ContE (NameE (N "L", [])));
        Al.PopAllI (exp2expr v);
        Al.ExitAbruptI (N "L");
      ]
  | _ -> [ Al.YetI "TODO: handle_context" ]

(* `Ast.exp` -> `Al.instr list` *)
let rec rhs2instrs exp =
  match exp.it with
  (* Trap *)
  | Ast.CaseE (Atom "TRAP", _) -> [ Al.TrapI ]
  (* Execute instrs *) (* TODO: doing this based on variable name is too ad-hoc. Need smarter way. *)
  | Ast.IterE ({ it = VarE id; _ }, (Ast.List, _))
  | Ast.IterE ({ it = Ast.SubE ({ it = VarE id; _ }, _, _); _}, (Ast.List, _))
    when id.it = "instr" || id.it = "instr'" ->
      [ Al.ExecuteSeqI (exp2expr exp) ]
  (* Push *)
  | Ast.SubE _ | IterE _ -> [ Al.PushI (exp2expr exp) ]
  | Ast.CaseE (Atom atomid, _)
    when atomid = "CONST" || atomid = "REF.FUNC_ADDR" ->
      [ Al.PushI (exp2expr exp) ]
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
        Al.PushI
          (Al.FrameE (Al.NameE (Al.N arity.it, []), Al.NameE (Al.N fname.it, [])))
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
        Al.LabelE (Al.NameE (Al.N label_arity.it, []), exp2expr instrs_exp1)
      in
      match instrs_exp2.it with
      | Ast.CatE (valexp, instrsexp) ->
          [
            Al.LetI (Al.NameE (Al.N "L", []), label_expr);
            Al.PushI (Al.NameE (Al.N "L", []));
            Al.PushI (exp2expr valexp);
            Al.JumpI (exp2expr instrsexp);
            Al.ExitNormalI (Al.N "L");
          ]
      | _ ->
          [
            Al.LetI (Al.NameE (Al.N "L", []), label_expr);
            Al.PushI (Al.NameE (Al.N "L", []));
            Al.JumpI (exp2expr instrs_exp2);
            Al.ExitNormalI (Al.N "L");
          ])
  (* Execute instr *)
  | Ast.CaseE (Atom atomid, argexp) ->
      [ Al.ExecuteI (Al.ConstructE (atomid, exp2args argexp)) ]
  | Ast.MixE
      ( [ []; [ Ast.Semicolon ]; [ Ast.Star ] ],
        (* z' ; instr'* *)
        { it = TupE [ state_exp; rhs ]; _ } ) -> (
      let push_instrs = rhs2instrs rhs in
      match state_exp.it with
      | VarE _ -> push_instrs
      | _ -> push_instrs @ [ Al.PerformI (exp2expr state_exp) ])
  | _ -> gen_fail_msg_of_exp exp "rhs instructions" |> failwith

(* `Ast.exp` -> `Al.cond` *)
let rec exp2cond exp =
  match exp.it with
  | Ast.CmpE (op, exp1, exp2) ->
      let lhs = exp2expr exp1 in
      let rhs = exp2expr exp2 in
      let compare_op = match op with
      | Ast.EqOp -> Al.Eq
      | Ast.NeOp -> Al.Ne
      | Ast.GtOp -> Al.Gt
      | Ast.GeOp -> Al.Ge
      | Ast.LtOp -> Al.Lt
      | Ast.LeOp -> Al.Le
      in
      Al.CompareC (compare_op, lhs, rhs)
  | Ast.BinE (op, exp1, exp2) ->
      let lhs = exp2cond exp1 in
      let rhs = exp2cond exp2 in
      let binop = match op with
      | Ast.AndOp -> Al.And
      | Ast.OrOp -> Al.Or
      | Ast.ImplOp -> Al.Impl
      | Ast.EquivOp -> Al.Equiv
      | _ ->
          gen_fail_msg_of_exp exp "binary expression for condition" |> failwith
      in
      Al.BinopC (binop, lhs, rhs)
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
      | Ast.LetPr (exp1, exp2) -> (
          let instrs' = List.concat_map (bound_by exp1) remain_lhs @ instrs in
          match exp1.it with
          | Ast.CaseE (Ast.Atom tag, {it = Ast.TupE []; _}) ->
              [
                Al.IfI
                  ( Al.IsCaseOfC (exp2expr exp2, tag),
                    instrs',
                    [] );
              ]
          | Ast.CaseE (Ast.Atom tag, _) ->
              [
                Al.IfI
                  ( Al.IsCaseOfC (exp2expr exp2, tag),
                    Al.LetI (exp2expr exp1, exp2expr exp2) :: instrs',
                    [] );
              ]
          | Ast.ListE es ->
              let rhs = exp2expr exp2 in
              [
                Al.IfI
                  ( Al.CompareC (Al.Eq, Al.LengthE rhs, Al.NumE (Int64.of_int (List.length es))),
                    Al.LetI (exp2expr exp1, rhs) :: instrs',
                    [] );
              ]
          | Ast.OptE None ->
              [
                Al.IfI
                  ( Al.NotC (Al.IsDefinedC (exp2expr exp2)),
                    instrs',
                    [] );
              ]
          | Ast.OptE (Some _) ->
              let rhs = exp2expr exp2 in
              [
                Al.IfI
                  ( Al.IsDefinedC rhs,
                    Al.LetI (exp2expr exp1, rhs) :: instrs',
                    [] );
               ]
          | Ast.BinE (Ast.AddOp, l, r) ->
              let rhs = exp2expr exp2 in
              let sub = exp2expr r in
              [
                Al.IfI
                  ( Al.CompareC (Al.Ge, rhs, sub),
                    Al.LetI (exp2expr l, Al.BinopE (Al.Sub, rhs, sub)) :: instrs',
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
    | Ast.DotP (p, a) -> Ast.DotE (path2expr' p, a) $$ (path.at % path.note)
  in
  path2expr' path |> exp2expr

(* TODO: Perhaps this should be tail recursion *)
let rec extract_winstr name stack =
  let wrap e = e $$ no_region % (Ast.VarT ("TOP" $ no_region) $ no_region) in
  match stack with
  | [] ->
    print_endline ("Failed to extract the instruction " ^ name ^ " from the stack.");
    [ ([], []), None ], Ast.CaseE (Ast.Atom (String.uppercase_ascii name), (Ast.ListE []) |> wrap) |> wrap
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

      let context, winstr = extract_winstr name inner_stack in

      let hole = Ast.TextE "_" |> wrap in
      let holed_args = List.map (fun x -> if x = list_arg then hole else x) args in
      let ctx = { hd with it = Ast.CaseE (a, { e with it = Ast.TupE holed_args }) } in
      let new_context = ((tl, []), Some ctx) :: context in
      new_context, winstr
    | _ ->
      let context, winstr = extract_winstr name tl in
      let ((vs, is), c), inners = Util.Lib.List.split_hd context in
      let new_context = ((vs, hd :: is), c) :: inners in
      new_context, winstr

let rec find_type tenv exp =
  let to_NameE x = Al.NameE (Al.N x, []) in
  let append_iter name iter = match name with
  | Al.NameE (n, iters) -> Al.NameE (n, iter :: iters)
  | _ -> failwith "Unreachable" in
  match exp.it with
  | Ast.VarE id -> (
      match List.find_opt (fun (id', _, _) -> id'.it = id.it) tenv with
      | Some (_, t, []) -> (id.it |> to_NameE, il_type2al_type t)
      | Some (_, t, _) -> (id.it |> to_NameE, Al.ListT (il_type2al_type t))
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
      | (s, StoreT), (f, FrameT) -> (Al.PairE (s, f), Al.StateT)
      | _ -> (Print.string_of_exp exp |> to_NameE, Al.TopT))
  | _ -> (Print.string_of_exp exp |> to_NameE, Al.TopT)

(** Main translation for reduction rules **)
(* `reduction_group list` -> `Backend-prose.Al.Algo` *)
let reduction_group2algo (instr_name, reduction_group) =
  let (lhs, _, _, tenv) = List.hd reduction_group in
  let lhs_stack = lhs |> drop_state |> flatten |> List.rev in
  let context, winstr = extract_winstr instr_name lhs_stack in
  let instrs = match context with
    | [(vs, []), None ] ->
      let pop_instrs, remain = handle_lhs_stack vs in
      let inner_pop_instrs = handle_context_winstr winstr in

      let instrs = match reduction_group with
      (* no premise: either *)
      | [ (lhs1, rhs1, [], _); (lhs2, rhs2, [], _) ]
        when Print.string_of_exp lhs1 = Print.string_of_exp lhs2 ->
          assert (List.length remain = 0);
          let rhs_instrs1 = rhs2instrs rhs1 |> check_nop in
          let rhs_instrs2 = rhs2instrs rhs2 |> check_nop in
          [ Al.EitherI (rhs_instrs1, rhs_instrs2) ]
      | _ ->
          let blocks = List.map (reduction2instrs remain) reduction_group in
          List.fold_right Transpile.merge_otherwise blocks [] in

      pop_instrs @ inner_pop_instrs @ instrs
    | [ ([], []), Some context ; (vs, _is), None ] ->
      let head_instrs = handle_context context vs in
      let body_instrs = List.map (reduction2instrs []) reduction_group |> List.concat in
      head_instrs @ body_instrs
    | _ ->
      [ YetI "TODO" ] in

  (* name *)
  let name = "execution_of_" ^ instr_name in
  (* params *)
  let params = get_params winstr |> List.map (find_type tenv) in
  (* body *)
  let body = instrs |> check_nop |> Transpile.enhance_readability in

  (* Algo *)
  Al.Algo (name, params, body)

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

let exp2mutating_instr e =
  match e.it with
  | Ast.UpdE (base, path, v) -> (
      match path2expr base path with
      | Al.AccessE (e, p) -> [ Al.ReplaceI (e, p, exp2expr v) ]
      | _ -> failwith "Impossible: path2expr always return AccessE" )
  | Ast.ExtE (base, path, v) -> [ Al.AppendListI (path2expr base path, exp2expr v) ]
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
  prems2instrs [] prems [ Al.ReturnI (Option.some (exp2expr e2)) ]

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
      let algo_body = List.fold_right Transpile.merge_otherwise blocks [] in

      let algo = Al.Algo (id.it, typed_params, algo_body) in
      Some algo
  | _ -> None

(** Entry for translating helper functions **)
let translate_helpers il = List.filter_map helpers2algo il

(** Entry **)

(* `Ast.script` -> `Al.Algo` *)
let translate il =
  let il = List.concat_map flatten_rec il in
  let algos = translate_helpers il @ translate_rules il in

  (* Transpile *)
  (* Can be turned off *)
  List.map Transpile.transpiler algos
