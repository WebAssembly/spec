open Al

let rec walk_expr f e =
  let _, _, f_expr = f in
  match e with
  | NumE n -> f_expr (NumE n)
  | StringE s -> f_expr (StringE s)
  | MinusE inner_e -> f_expr (MinusE (walk_expr f inner_e))
  | BinopE (op, e1, e2) -> f_expr (BinopE (op, walk_expr f e1, walk_expr f e2))
  | AppE (fname, args) -> f_expr (AppE (fname, walk_exprs f args))
  (* TODO: Implement walker for iter *)
  | MapE (fname, args, iter) -> f_expr (MapE (fname, walk_exprs f args, iter))
  | LengthE inner_e -> f_expr (LengthE (walk_expr f inner_e))
  | ArityE inner_e -> f_expr (ArityE (walk_expr f inner_e))
  | GetCurFrameE -> f_expr GetCurFrameE
  | FrameE (e1, e2) -> f_expr (FrameE (walk_expr f e1, walk_expr f e2))
  | ConcatE (e1, e2) -> f_expr (ConcatE (walk_expr f e1, walk_expr f e2))
  | ListE el -> f_expr (ListE (Array.map (walk_expr f) el))
  | ListFillE (e1, e2) -> f_expr (ListFillE (walk_expr f e1, walk_expr f e2))
  | AccessE (e, p) -> f_expr (AccessE (walk_expr f e, walk_path f p))
  | RecordE r -> f_expr (RecordE (Record.map (fun e -> walk_expr f !e |> ref) r))
  | OptE e -> f_expr (OptE (Option.map (walk_expr f) e))
  | ArrowE (e1, e2) -> f_expr (ArrowE (f_expr e1, f_expr e2))
  | LabelE (e1, e2) -> f_expr (LabelE (f_expr e1, f_expr e2))
  | ConstructE (s, el) -> f_expr (ConstructE (s, walk_exprs f el))
  | NameE (n, iters) -> f_expr (NameE (n, iters))
  | YetE s -> f_expr (YetE s)
  | _ ->
      "Walker is not implemented for " ^ Print.structured_string_of_expr e
      |> failwith

and walk_exprs f = walk_expr f |> List.map

and walk_path f p =
  let f_path p = p in
  (* TODO *)
  match p with
  | IndexP e -> f_path (IndexP (walk_expr f e))
  | SliceP (e1, e2) -> f_path (SliceP (walk_expr f e1, walk_expr f e2))
  | DotP _ -> f_path p

let rec walk_cond f c =
  let _, f_cond, _ = f in
  match c with
  | NotC inner_c -> f_cond (NotC (walk_cond f inner_c))
  | BinopC (op, c1, c2) -> f_cond (BinopC (op, walk_cond f c1, walk_cond f c2))
  | CompareC (op, e1, e2) -> f_cond (CompareC (op, walk_expr f e1, walk_expr f e2))
  | IsCaseOfC (e, c) -> f_cond (IsCaseOfC (walk_expr f e, c))
  | IsDefinedC e -> f_cond (IsDefinedC (walk_expr f e))
  | _ -> Print.structured_string_of_cond c |> failwith

let rec walk_instr f instr =
  let f_instr, _, _ = f in
  match instr with
  | IfI (c, t, e) ->
      f_instr (IfI (walk_cond f c, walk_instrs f t, walk_instrs f e))
  | OtherwiseI b -> f_instr (OtherwiseI (walk_instrs f b))
  | WhileI (c, il) -> f_instr (WhileI (walk_cond f c, walk_instrs f il))
  | EitherI (il1, il2) ->
      f_instr (EitherI (walk_instrs f il1, walk_instrs f il2))
  | ForI (e, il) -> f_instr (ForI (walk_expr f e, walk_instrs f il))
  | ForeachI (e1, e2, il) -> f_instr (ForeachI (walk_expr f e1, walk_expr f e2, walk_instrs f il))
  | AssertI s -> f_instr (AssertI s)
  | PushI e -> f_instr (PushI (walk_expr f e))
  | PopI e -> f_instr (PopI (walk_expr f e))
  | PopAllI e -> f_instr (PopAllI (walk_expr f e))
  | LetI (n, e) -> f_instr (LetI (n, walk_expr f e))
  | TrapI -> f_instr TrapI
  | NopI -> f_instr NopI
  | ReturnI e_opt -> f_instr (ReturnI (Option.map (walk_expr f) e_opt))
  | EnterI (e1, e2) -> f_instr (EnterI (walk_expr f e1, walk_expr f e2))
  | ExecuteI e -> f_instr (ExecuteI (walk_expr f e))
  | ExecuteSeqI e -> f_instr (ExecuteSeqI (walk_expr f e))
  | ReplaceI (e1, p, e2) ->
      f_instr (ReplaceI (walk_expr f e1, walk_path f p, walk_expr f e2))
  | JumpI e -> f_instr (JumpI (walk_expr f e))
  | PerformI e -> f_instr (PerformI (walk_expr f e))
  | ExitNormalI n -> f_instr (ExitNormalI n)
  | ExitAbruptI n -> f_instr (ExitAbruptI n)
  | AppendI (e1, e2, s) -> f_instr (AppendI (walk_expr f e1, walk_expr f e2, s))
  | ValidI (e1, e2, eo) -> f_instr (ValidI (walk_expr f e1, walk_expr f e2, Option.map (walk_expr f) eo))
  | YetI s -> f_instr (YetI s)

and walk_instrs f = walk_instr f |> List.map

let walk f = function
  | Algo (name, params, body) -> (
      let new_body = walk_instrs f body in
      match params with
      | (PairE (_, f), StateT) :: rest_params ->
          Algo (name, rest_params, LetI (f, GetCurFrameE) :: new_body)
      | _ -> Algo (name, params, new_body))
