open Ast
open Util.Record

type config = {
  pre_instr: instr -> instr list;
  post_instr: instr -> instr list;
  stop_cond_instr: instr -> bool;

  pre_cond: cond -> cond;
  post_cond: cond -> cond;
  stop_cond_cond: cond -> bool;

  pre_expr: expr -> expr;
  post_expr: expr -> expr;
  stop_cond_expr: expr -> bool;
}

let id x = x
let ids x = [ x ]
let fls _ = false
let default_config = {
  pre_instr = ids;
  post_instr = ids;
  stop_cond_instr = fls;

  pre_cond = id;
  post_cond = id;
  stop_cond_cond = fls;

  pre_expr = id;
  post_expr = id;
  stop_cond_expr = fls;
}

let rec walk_expr f e =
  let { pre_expr = pre; post_expr = post; stop_cond_expr = stop_cond; _ } = f in
  let new_ = walk_expr f in

  let super_walk e = match e with
  | NumE _
  | GetCurFrameE
  | GetCurLabelE
  | GetCurContextE -> e
  | UnE (op, e') -> UnE (op, new_ e')
  | BinE (op, e1, e2) -> BinE (op, new_ e1, new_ e2)
  | AppE (fname, args) -> AppE (fname, List.map new_ args)
  (* TODO: Implement walker for iter *)
  | ListE el -> ListE (List.map (new_) el)
  | ListFillE (e1, e2) -> ListFillE (new_ e1, new_ e2)
  | ConcatE (e1, e2) -> ConcatE (new_ e1, new_ e2)
  | LengthE e' -> LengthE (new_ e')
  | RecordE r -> RecordE (Record.map new_ r)
  | AccessE (e, p) -> AccessE (new_ e, walk_path f p)
  | ExtendE (e1, ps, e2, dir) -> ExtendE (new_ e1, List.map (walk_path f) ps, new_ e2, dir)
  | ReplaceE (e1, ps, e2) -> ReplaceE (new_ e1, List.map (walk_path f) ps, new_ e2)
  | ConstructE (t, el) -> ConstructE (t, List.map new_ el)
  | OptE e -> OptE (Option.map new_ e)
  | PairE (e1, e2) -> PairE (new_ e1, new_ e2)
  | ArrowE (e1, e2) -> ArrowE (new_ e1, new_ e2)
  | ArityE e' -> ArityE (new_ e')
  | FrameE (e1_opt, e2) -> FrameE (Option.map new_ e1_opt, new_ e2)
  | LabelE (e1, e2) -> LabelE (new_ e1, new_ e2)
  | ContE e' -> ContE (new_ e')
  | VarE n -> VarE n
  | IterE (e, names, iter) -> IterE (new_ e, names, iter)
  | YetE _ -> e in

  let e1 = pre e in
  let e2 = if stop_cond e1 then e1 else super_walk e1 in
  let e3 = post e2 in
  e3

and walk_path f p =
  let pre = id in
  let post = id in
  ( match pre p with
  | IdxP e -> IdxP (walk_expr f e)
  | SliceP (e1, e2) -> SliceP (walk_expr f e1, walk_expr f e2)
  | DotP (s, note) -> DotP (s, note) )
  |> post

let rec walk_cond f c =
  let { pre_cond = pre; post_cond = post; stop_cond_cond = stop_cond; _ } = f in
  let new_ = walk_cond f in
  let new_e = walk_expr f in

  let super_walk c = match c with
  | UnC (op, inner_c) -> UnC (op, new_ inner_c)
  | BinC (op, c1, c2) -> BinC (op, new_ c1, new_ c2)
  | CmpC (op, e1, e2) -> CmpC (op, new_e e1, new_e e2)
  | ContextKindC (s, e) -> ContextKindC (s, new_e e)
  | IsCaseOfC (e, s) -> IsCaseOfC (new_e e, s)
  | IsDefinedC e -> IsDefinedC (new_e e)
  | IsValidC e -> IsValidC (new_e e)
  | TopLabelC -> c
  | TopFrameC -> c
  | TopValueC (Some e) -> TopValueC (Some (new_e e))
  | TopValueC _ -> c
  | TopValuesC e -> TopValuesC (new_e e)
  | YetC _ -> c in

  let c1 = pre c in
  let c2 = if stop_cond c1 then c1 else super_walk c1 in
  let c3 = post c2 in
  c3

let rec walk_instr f (instr:instr) : instr list =
  let { pre_instr = pre; post_instr = post; stop_cond_instr = stop_cond; _ } = f in
  let new_ = List.concat_map (walk_instr f) in
  let new_c = walk_cond f in
  let new_e = walk_expr f in

  let super_walk i = match i with
  | IfI (c, il1, il2) -> IfI (new_c c, new_ il1, new_ il2)
  | OtherwiseI il -> OtherwiseI (new_ il)
  | EitherI (il1, il2) -> EitherI (new_ il1, new_ il2)
  | AssertI c -> AssertI (new_c c)
  | PushI e -> PushI (new_e e)
  | PopI e -> PopI (new_e e)
  | PopAllI e -> PopAllI (new_e e)
  | LetI (n, e) -> LetI (new_e n, new_e e)
  | TrapI -> TrapI
  | NopI -> NopI
  | ReturnI e_opt -> ReturnI (Option.map new_e e_opt)
  | EnterI (e1, e2, il) -> EnterI (new_e e1, new_e e2, new_ il)
  | ExecuteI e -> ExecuteI (new_e e)
  | ExecuteSeqI e -> ExecuteSeqI (new_e e)
  | PerformI (n, el) -> PerformI (n, List.map new_e el)
  | ExitI -> ExitI
  | ReplaceI (e1, p, e2) -> ReplaceI (new_e e1, walk_path f p, new_e e2)
  | AppendI (e1, e2) -> AppendI (new_e e1, new_e e2)
  | YetI _ -> i in

  let il1 = pre instr in
  let il2 = List.map (fun i -> if stop_cond i then i else super_walk i) il1 in
  let il3 = List.concat_map post il2 in
  il3

and walk_instrs f = walk_instr f |> List.concat_map

let walk f algo = match algo with
  | RuleA (name, params, body) -> RuleA (name, params, walk_instrs f body)
  | FuncA (name, params, body) -> FuncA (name, params, walk_instrs f body)
