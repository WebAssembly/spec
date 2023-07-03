open Ast
open Record

type action = {
  pre_instr: instr -> instr list;
  post_instr: instr -> instr list;
  pre_cond: cond -> cond;
  post_cond: cond -> cond;
  pre_expr: expr -> expr;
  post_expr: expr -> expr;
}

let id x = x
let ids x = [ x ]
let default_action = {
  pre_instr = ids;
  post_instr = ids;
  pre_cond = id;
  post_cond = id;
  pre_expr = id;
  post_expr = id;
}

let rec walk_expr f e =
  let { pre_expr = pre; post_expr = post; _ } = f in
  let new_ = walk_expr f in
  ( match pre e with
  | NumE _
  | StringE _
  | GetCurFrameE
  | GetCurLabelE
  | GetCurContextE -> e
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
  | ExtendE (e1, ps, e2, dir) -> ExtendE (new_ e1, List.map (walk_path f) ps, new_ e2, dir)
  | ReplaceE (e1, ps, e2) -> ReplaceE (new_ e1, List.map (walk_path f) ps, new_ e2)
  | ConstructE (s, el) -> ConstructE (s, List.map new_ el)
  | OptE e -> OptE (Option.map new_ e)
  | PairE (e1, e2) -> PairE (new_ e1, new_ e2)
  | ArrowE (e1, e2) -> ArrowE (new_ e1, new_ e2)
  | ArityE e' -> ArityE (new_ e')
  | FrameE (e1, e2) -> FrameE (new_ e1, new_ e2)
  | LabelE (e1, e2) -> LabelE (new_ e1, new_ e2)
  | ContE e' -> ContE (new_ e')
  | NameE n -> NameE n 
  | IterE (e, iters) -> IterE (new_ e, iters)
  | YetE _ -> e )
  |> post

and walk_path f p =
  let pre = id in
  let post = id in
  ( match pre p with
  | IndexP e -> IndexP (walk_expr f e)
  | SliceP (e1, e2) -> SliceP (walk_expr f e1, walk_expr f e2)
  | DotP _ -> p )
  |> post

let rec walk_cond f c =
  let { pre_cond = pre; post_cond = post; _ } = f in
  let new_ = walk_cond f in
  let new_e = walk_expr f in
  ( match pre c with
  | NotC inner_c -> NotC (new_ inner_c)
  | BinopC (op, c1, c2) -> BinopC (op, new_ c1, new_ c2)
  | CompareC (op, e1, e2) -> CompareC (op, new_e e1, new_e e2)
  | ContextKindC (s, e) -> ContextKindC (s, new_e e)
  | IsCaseOfC (e, s) -> IsCaseOfC (new_e e, s)
  | IsDefinedC e -> IsDefinedC (new_e e)
  | IsTopC _ -> c
  | ValidC e -> ValidC (new_e e)
  | YetC _ -> c )
  |> post

let rec walk_instr f (instr:instr) : instr list =
  let { pre_instr = pre; post_instr = post; _ } = f in
  let new_ = List.concat_map (walk_instr f) in
  let new_c = walk_cond f in
  let new_e = walk_expr f in
  pre instr
  |> List.map (function
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
  | LetI (n, e) -> LetI (new_e n, new_e e)
  | CallI (e1, n, el) -> CallI (new_e e1, n, List.map new_e el)
  | MapI (e1, n, el, il) -> MapI (new_e e1, n, List.map new_e el, il)
  | TrapI -> TrapI
  | NopI -> NopI
  | ReturnI e_opt -> ReturnI (Option.map new_e e_opt)
  | EnterI (e1, e2) -> EnterI (new_e e1, new_e e2)
  | ExecuteI e -> ExecuteI (new_e e)
  | ExecuteSeqI e -> ExecuteSeqI (new_e e)
  | JumpI e -> JumpI (new_e e)
  | PerformI (n, el) -> PerformI (n, List.map new_e el)
  | ExitNormalI n -> ExitNormalI n
  | ExitAbruptI n -> ExitAbruptI n
  | ReplaceI (e1, p, e2) -> ReplaceI (new_e e1, walk_path f p, new_e e2)
  | AppendI (e1, e2) -> AppendI (new_e e1, new_e e2)
  | AppendListI (e1, e2) -> AppendListI (new_e e1, new_e e2)
  | YetI _ -> instr )
  |> List.concat_map post

and walk_instrs f = walk_instr f |> List.concat_map

let walk f algo =
  let Algo (name, params, body) = algo in
  Algo (name, params, walk_instrs f body)
