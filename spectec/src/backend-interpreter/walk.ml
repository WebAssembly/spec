open Al

let rec walk_expr f e =
  let _, _, f_expr = f in
  let new_ = walk_expr f in
  ( match e with
  | NumE _
  | StringE _
  | GetCurFrameE
  | GetCurLabelE -> e
  | MinusE e' -> MinusE (new_ e')
  | BinopE (op, e1, e2) -> BinopE (op, new_ e1, new_ e2)
  | AppE (fname, args) -> AppE (fname, List.map new_ args)
  (* TODO: Implement walker for iter *)
  | MapE (fname, args, iter) -> MapE (fname, List.map new_ args, iter)
  | ListE el -> ListE (List.map (new_) el)
  | ListFillE (e1, e2) -> ListFillE (new_ e1, new_ e2)
  | ConcatE (e1, e2) -> ConcatE (new_ e1, new_ e2)
  | LengthE e' -> LengthE (new_ e')
  | RecordE r -> RecordE (Record.map new_ r)
  | AccessE (e, p) -> AccessE (new_ e, walk_path f p)
  | ConstructE (s, el) -> ConstructE (s, List.map new_ el)
  | OptE e -> OptE (Option.map new_ e)
  | PairE (e1, e2) -> PairE (new_ e1, new_ e2)
  | ArrowE (e1, e2) -> ArrowE (new_ e1, new_ e2)
  | ArityE e' -> ArityE (new_ e')
  | FrameE (e1, e2) -> FrameE (new_ e1, new_ e2)
  | LabelE (e1, e2) -> LabelE (new_ e1, new_ e2)
  | ContE e' -> ContE (new_ e')
  | NameE (n, iters) -> NameE (n, iters)
  | YetE _ -> e )
  |> f_expr

and walk_path f p =
  let f_path p = p in (* TODO *)
  ( match p with
  | IndexP e -> IndexP (walk_expr f e)
  | SliceP (e1, e2) -> SliceP (walk_expr f e1, walk_expr f e2)
  | DotP _ -> p )
  |> f_path

let rec walk_cond f c =
  let _, f_cond, _ = f in
  let new_ = walk_cond f in
  let new_e = walk_expr f in
  ( match c with
  | NotC inner_c -> NotC (new_ inner_c)
  | BinopC (op, c1, c2) -> BinopC (op, new_ c1, new_ c2)
  | CompareC (op, e1, e2) -> CompareC (op, new_e e1, new_e e2)
  | IsCaseOfC (e, s) -> IsCaseOfC (new_e e, s)
  | IsDefinedC e -> IsDefinedC (new_e e)
  | IsTopC _
  | YetC _ -> c )
  |> f_cond

let rec walk_instr f instr =
  let f_instr, _, _ = f in
  let new_ = List.map (walk_instr f) in
  let new_c = walk_cond f in
  let new_e = walk_expr f in
  ( match instr with
  | IfI (c, il1, il2) -> IfI (new_c c, new_ il1, new_ il2)
  | OtherwiseI il -> OtherwiseI (new_ il)
  | WhileI (c, il) -> WhileI (new_c c, new_ il)
  | EitherI (il1, il2) -> EitherI (new_ il1, new_ il2)
  | ForI (e, il) -> ForI (new_e e, new_ il)
  | ForeachI (e1, e2, il) -> ForeachI (new_e e1, new_e e2, new_ il)
  | AssertI s -> AssertI s
  | PushI e -> PushI (new_e e)
  | PopI e -> PopI (new_e e)
  | PopAllI e -> PopAllI (new_e e)
  | LetI (n, e) -> LetI (n, new_e e)
  | TrapI -> TrapI
  | NopI -> NopI
  | ReturnI e_opt -> ReturnI (Option.map new_e e_opt)
  | EnterI (e1, e2) -> EnterI (new_e e1, new_e e2)
  | ExecuteI e -> ExecuteI (new_e e)
  | ExecuteSeqI e -> ExecuteSeqI (new_e e)
  | JumpI e -> JumpI (new_e e)
  | PerformI e -> PerformI (new_e e)
  | ExitNormalI n -> ExitNormalI n
  | ExitAbruptI n -> ExitAbruptI n
  | ReplaceI (e1, p, e2) -> ReplaceI (new_e e1, walk_path f p, new_e e2)
  | AppendI (e1, e2) -> AppendI (new_e e1, new_e e2)
  | AppendListI (e1, e2) -> AppendListI (new_e e1, new_e e2)
  | YetI _ -> instr )
  |> f_instr

and walk_instrs f = walk_instr f |> List.map

let walk f = function
  | Algo (name, params, body) -> (
      let new_body = walk_instrs f body in
      match params with
      | (PairE (_, f), StateT) :: rest_params ->
          Algo (name, rest_params, LetI (f, GetCurFrameE) :: new_body)
      | _ -> Algo (name, params, new_body))
