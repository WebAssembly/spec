open Ast
open Util
open Source

type config = {
  pre_instr: instr -> instr list;
  post_instr: instr -> instr list;
  stop_cond_instr: instr -> bool;

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

  pre_expr = id;
  post_expr = id;
  stop_cond_expr = fls;
}

let rec walk_expr f e =
  let { pre_expr = pre; post_expr = post; stop_cond_expr = stop_cond; _ } = f in
  let new_ = walk_expr f in

  let super_walk e =
    let e' =
      match e.it with
      | NumE _
      | BoolE _
      | GetCurStateE
      | GetCurFrameE
      | GetCurLabelE
      | GetCurContextE -> e.it
      | UnE (op, e') -> UnE (op, new_ e')
      | BinE (op, e1, e2) -> BinE (op, new_ e1, new_ e2)
      | CallE (id, el) -> CallE (id, List.map new_ el)
      (* TODO: Implement walker for iter *)
      | ListE el -> ListE (List.map new_ el)
      | CatE (e1, e2) -> CatE (new_ e1, new_ e2)
      | MemE (e1, e2) -> MemE (new_ e1, new_ e2)
      | LenE e' -> LenE (new_ e')
      | StrE r -> StrE (Record.map id new_ r)
      | AccE (e, p) -> AccE (new_ e, walk_path f p)
      | ExtE (e1, ps, e2, dir) -> ExtE (new_ e1, List.map (walk_path f) ps, new_ e2, dir)
      | UpdE (e1, ps, e2) -> UpdE (new_ e1, List.map (walk_path f) ps, new_ e2)
      | CaseE (a, el) -> CaseE (a, List.map new_ el)
      | OptE e -> OptE (Option.map new_ e)
      | TupE el -> TupE (List.map new_ el)
      | InfixE (e1, a, e2) -> InfixE (new_ e1, a, new_ e2)
      | ArityE e' -> ArityE (new_ e')
      | FrameE (e1_opt, e2) -> FrameE (Option.map new_ e1_opt, new_ e2)
      | LabelE (e1, e2) -> LabelE (new_ e1, new_ e2)
      | ContE e' -> ContE (new_ e')
      | VarE id -> VarE id
      | SubE (id, t) -> SubE (id, t)
      | IterE (e, ids, iter) -> IterE (new_ e, ids, iter)
      | ContextKindE (a, e) -> ContextKindE (a, new_ e)
      | IsCaseOfE (e, a) -> IsCaseOfE (new_ e, a)
      | IsDefinedE e -> IsDefinedE (new_ e)
      | HasTypeE (e, t) -> HasTypeE(new_ e, t)
      | IsValidE e -> IsValidE (new_ e)
      | TopLabelE -> e.it
      | TopFrameE -> e.it
      | TopValueE (Some e) -> TopValueE (Some (new_ e))
      | TopValueE _ -> e.it
      | TopValuesE e -> TopValuesE (new_ e)
      | MatchE (e1, e2) -> MatchE (new_ e1, new_ e2)
      | YetE _ -> e.it
    in
    { e with it = e' }
  in

  let e1 = pre e in
  let e2 = if stop_cond e1 then e1 else super_walk e1 in
  let e3 = post e2 in
  e3

and walk_path f p =
  let pre = id in
  let post = id in

  let p' =
    ( match (pre p).it with
    | IdxP e -> IdxP (walk_expr f e)
    | SliceP (e1, e2) -> SliceP (walk_expr f e1, walk_expr f e2)
    | DotP a -> DotP a )
  in
  let p = { p with it = p' } in

  post p

let rec walk_instr f (instr:instr) : instr list =
  let { pre_instr = pre; post_instr = post; stop_cond_instr = stop_cond; _ } = f in
  let new_ = List.concat_map (walk_instr f) in
  let new_e = walk_expr f in

  let super_walk i =
    let i' =
      match i.it with
      | IfI (e, il1, il2) -> IfI (new_e e, new_ il1, new_ il2)
      | OtherwiseI il -> OtherwiseI (new_ il)
      | EitherI (il1, il2) -> EitherI (new_ il1, new_ il2)
      | AssertI e -> AssertI (new_e e)
      | PushI e -> PushI (new_e e)
      | PopI e -> PopI (new_e e)
      | PopAllI e -> PopAllI (new_e e)
      | LetI (e1, e2) -> LetI (new_e e1, new_e e2)
      | TrapI -> TrapI
      | NopI -> NopI
      | ReturnI e_opt -> ReturnI (Option.map new_e e_opt)
      | EnterI (e1, e2, il) -> EnterI (new_e e1, new_e e2, new_ il)
      | ExecuteI e -> ExecuteI (new_e e)
      | ExecuteSeqI e -> ExecuteSeqI (new_e e)
      | PerformI (id, el) -> PerformI (id, List.map new_e el)
      | ExitI _ -> i.it 
      | ReplaceI (e1, p, e2) -> ReplaceI (new_e e1, walk_path f p, new_e e2)
      | AppendI (e1, e2) -> AppendI (new_e e1, new_e e2)
      | YetI _ -> i.it in
    { i with it = i' }
  in

  let il1 = pre instr in
  let il2 = List.map (fun i -> if stop_cond i then i else super_walk i) il1 in
  let il3 = List.concat_map post il2 in
  il3

and walk_instrs f = walk_instr f |> List.concat_map

let walk f algo = match algo with
  | RuleA (a, params, body) -> RuleA (a, params, walk_instrs f body)
  | FuncA (id, params, body) -> FuncA (id, params, walk_instrs f body)
