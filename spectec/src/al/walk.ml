open Ast
open Util
open Source


(* Unit walker *)

type unit_walker = {
  walk_algo: unit_walker -> algorithm -> unit;
  walk_instr: unit_walker -> instr -> unit;
  walk_expr: unit_walker -> expr -> unit;
  walk_path: unit_walker -> path -> unit;
  walk_iter: unit_walker -> iter -> unit;
  walk_arg: unit_walker -> arg -> unit;
}

let walk_arg (walker: unit_walker) (arg: arg) : unit =
  match arg.it with
  | ExpA e -> walker.walk_expr walker e
  | TypA _
  | DefA _ -> ()

let walk_iter (walker: unit_walker) (iter: iter) : unit =
  match iter with
  | Opt | List | List1 -> ()
  | ListN (e, _) -> walker.walk_expr walker e

let walk_path (walker: unit_walker) (path: path) : unit =
  match path.it with
  | IdxP e -> walker.walk_expr walker e
  | SliceP (e1, e2) -> walker.walk_expr walker e1; walker.walk_expr walker e2
  | DotP _ -> ()

let walk_expr (walker: unit_walker) (expr: expr) : unit =
  match expr.it with
  | VarE _ | SubE _ | NumE _ | BoolE _ | GetCurStateE | GetCurLabelE
  | GetCurContextE | GetCurFrameE | YetE _ | TopLabelE | TopFrameE
  | TopValueE None | ContextKindE _ -> ()

  | UnE (_, e) | LenE e | ArityE e | ContE e
  | IsDefinedE e | IsCaseOfE (e, _) | HasTypeE (e, _) | IsValidE e
  | TopValueE (Some e) | TopValuesE e | ChooseE e -> walker.walk_expr walker e
  
  | BinE (_, e1, e2) | CompE (e1, e2) | CatE (e1, e2) | MemE (e1, e2)
  | LabelE (e1, e2) | MatchE (e1, e2) ->
    walker.walk_expr walker e1; walker.walk_expr walker e2
  | FrameE (e_opt, e) ->
    Option.iter (walker.walk_expr walker) e_opt; walker.walk_expr walker e
  | CallE (_, al) | InvCallE (_, _, al) ->
    List.iter (walker.walk_arg walker) al
  | TupE el | ListE el | CaseE (_, el) ->
    List.iter (walker.walk_expr walker) el
  | StrE r -> List.iter (fun (_, e) -> walker.walk_expr walker !e) r
  | AccE (e, p) -> walker.walk_expr walker e; walk_path walker p
  | ExtE (e1, ps, e2, _) | UpdE (e1, ps, e2) ->
    walker.walk_expr walker e1; List.iter (walk_path walker) ps;
    walker.walk_expr walker e2
  | OptE e_opt -> Option.iter (walker.walk_expr walker) e_opt
  | IterE (e, (iter, xes)) ->
    walker.walk_expr walker e;
    walker.walk_iter walker iter;
    List.iter (fun (_, e) -> walker.walk_expr walker e) xes

let walk_instr (walker: unit_walker) (instr: instr) : unit =
  match instr.it with
  | IfI (e, il1, il2) ->
    walker.walk_expr walker e;
    List.iter (walker.walk_instr walker) il1; List.iter (walker.walk_instr walker) il2
  | OtherwiseI il -> List.iter (walker.walk_instr walker) il
  | EitherI (il1, il2) ->
    List.iter (walker.walk_instr walker) il1; List.iter (walker.walk_instr walker) il2
  | EnterI (e1, e2, il) ->
    walker.walk_expr walker e1; walker.walk_expr walker e2;
    List.iter (walker.walk_instr walker) il
  | TrapI | NopI | ReturnI None | ExitI _ | YetI _ -> ()
  | AssertI e | ThrowI e | PushI e | PopI e | PopAllI e
  | ReturnI (Some e)| ExecuteI e | ExecuteSeqI e -> walker.walk_expr walker e
  | LetI (e1, e2) | AppendI (e1, e2) | FieldWiseAppendI (e1, e2) ->
    walker.walk_expr walker e1; walker.walk_expr walker e2
  | PerformI (_, al) -> List.iter (walker.walk_arg walker) al
  | ReplaceI (e1, p, e2) ->
    walker.walk_expr walker e1; walk_path walker p; walker.walk_expr walker e2

let walk_algo (walker: unit_walker) (algo: algorithm) : unit =
  match algo.it with
  | RuleA (_, _, args, instrs) ->
    List.iter (walker.walk_arg walker) args; List.iter (walker.walk_instr walker) instrs
  | FuncA (_, args, instrs) ->
    List.iter (walker.walk_arg walker) args; List.iter (walker.walk_instr walker) instrs

let base_unit_walker = { walk_algo; walk_instr; walk_expr; walk_path; walk_iter; walk_arg }


(* Transform walker *)

type walker = {
  walk_algo: walker -> algorithm -> algorithm;
  walk_instr: walker -> instr -> instr;
  walk_expr: walker -> expr -> expr;
  walk_path: walker -> path -> path;
  walk_iter: walker -> iter -> iter;
  walk_arg: walker -> arg -> arg;
}

let walk_arg (walker: walker) (arg: arg) : arg =
  let walk_expr = walker.walk_expr walker in
  match arg.it with
  | ExpA e -> { arg with it = ExpA (walk_expr e) }
  | TypA _
  | DefA _ -> arg

let walk_iter (walker: walker) (iter: iter) : iter =
  let walk_expr = walker.walk_expr walker in
  match iter with
  | Opt | List | List1 -> iter
  | ListN (e, id_opt) -> ListN (walk_expr e, id_opt)

let walk_path (walker: walker) (path: path) : path =
  let walk_expr = walker.walk_expr walker in
  let it =
    match path.it with
    | IdxP e -> IdxP (walk_expr e)
    | SliceP (e1, e2) -> SliceP (walk_expr e1, walk_expr e2)
    | DotP a -> DotP a
  in
  { path with it }

let walk_expr (walker: walker) (expr: expr) : expr =
  let walk_arg  = walker.walk_arg  walker in
  let walk_iter = walker.walk_iter walker in
  let walk_path = walker.walk_path walker in
  let walk_expr = walker.walk_expr walker in
  let it =
    match expr.it with
    | NumE _ | BoolE _ | VarE _ | SubE _ | GetCurStateE | GetCurFrameE
    | GetCurLabelE | GetCurContextE | ContextKindE _ | TopLabelE | TopFrameE | YetE _ -> expr.it
    | UnE (op, e) -> UnE (op, walk_expr e)
    | BinE (op, e1, e2) -> BinE (op, walk_expr e1, walk_expr e2)
    | CallE (id, al) -> CallE (id, List.map walk_arg al)
    | InvCallE (id, nl, al) -> InvCallE (id, nl, List.map walk_arg al)
    | ListE el -> ListE (List.map walk_expr el)
    | CompE (e1, e2) -> CompE (walk_expr e1, walk_expr e2)
    | CatE (e1, e2) -> CatE (walk_expr e1, walk_expr e2)
    | MemE (e1, e2) -> MemE (walk_expr e1, walk_expr e2)
    | LenE e -> LenE (walk_expr e)
    | StrE r -> StrE (Record.map (fun x -> x) walk_expr r)
    | AccE (e, p) -> AccE (walk_expr e, walk_path p)
    | ExtE (e1, ps, e2, dir) ->
      ExtE (walk_expr e1, List.map walk_path ps, walk_expr e2, dir)
    | UpdE (e1, ps, e2) -> UpdE (walk_expr e1, List.map walk_path ps, walk_expr e2)
    | CaseE (a, el) -> CaseE (a, List.map walk_expr el)
    | OptE e -> OptE (Option.map walk_expr e)
    | TupE el -> TupE (List.map walk_expr el)
    | ArityE e -> ArityE (walk_expr e)
    | FrameE (e1_opt, e2) -> FrameE (Option.map walk_expr e1_opt, walk_expr e2)
    | LabelE (e1, e2) -> LabelE (walk_expr e1, walk_expr e2)
    | ContE e' -> ContE (walk_expr e')
    | ChooseE e' -> ChooseE (walk_expr e')
    | IterE (e, (iter, xes)) -> IterE (walk_expr e, (walk_iter iter, List.map (fun (x, e) -> (x, walk_expr e)) xes))
    | IsCaseOfE (e, a) -> IsCaseOfE (walk_expr e, a)
    | IsDefinedE e -> IsDefinedE (walk_expr e)
    | HasTypeE (e, t) -> HasTypeE(walk_expr e, t)
    | IsValidE e -> IsValidE (walk_expr e)
    | TopValueE e_opt -> TopValueE (Option.map walk_expr e_opt)
    | TopValuesE e -> TopValuesE (walk_expr e)
    | MatchE (e1, e2) -> MatchE (walk_expr e1, walk_expr e2)
  in
  { expr with it }

let walk_instr (walker: walker) (instr: instr) : instr =
  let walk_arg  = walker.walk_arg  walker in
  let walk_path = walker.walk_path walker in
  let walk_expr = walker.walk_expr walker in
  let walk_instr = walker.walk_instr walker in
  let it =
    match instr.it with
    | IfI (e, il1, il2) ->
      IfI (walk_expr e, List.map walk_instr il1, List.map walk_instr il2)
    | OtherwiseI il -> OtherwiseI (List.map walk_instr il)
    | EitherI (il1, il2) ->
      EitherI (List.map walk_instr il1, List.map walk_instr il2)
    | EnterI (e1, e2, il) ->
      EnterI (walk_expr e1, walk_expr e2, List.map walk_instr il)
    | AssertI e -> AssertI (walk_expr e)
    | PushI e -> PushI (walk_expr e)
    | PopI e -> PopI (walk_expr e)
    | PopAllI e -> PopAllI (walk_expr e)
    | LetI (e1, e2) -> LetI (walk_expr e1, walk_expr e2)
    | TrapI -> TrapI
    | ThrowI e -> ThrowI (walk_expr e)
    | NopI -> NopI
    | ReturnI e_opt -> ReturnI (Option.map walk_expr e_opt)
    | ExecuteI e -> ExecuteI (walk_expr e)
    | ExecuteSeqI e -> ExecuteSeqI (walk_expr e)
    | PerformI (id, al) -> PerformI (id, List.map walk_arg al)
    | ExitI _ -> instr.it
    | ReplaceI (e1, p, e2) -> ReplaceI (walk_expr e1, walk_path p, walk_expr e2)
    | AppendI (e1, e2) -> AppendI (walk_expr e1, walk_expr e2)
    | FieldWiseAppendI (e1, e2) -> FieldWiseAppendI (walk_expr e1, walk_expr e2)
    | YetI _ -> instr.it
  in
  { instr with it }

let walk_algo (walker: walker) (algo: algorithm) : algorithm =
  let walk_arg  = walker.walk_arg  walker in
  let walk_instr = walker.walk_instr walker in
  let it =
    match algo.it with
    | RuleA (name, anchor, args, instrs) ->
      RuleA (name, anchor, List.map walk_arg args, List.map walk_instr instrs)
    | FuncA (name, args, instrs) ->
      FuncA (name, List.map walk_arg args, List.map walk_instr instrs)
  in
  { algo with it }

let base_walker = { walk_algo; walk_instr; walk_expr; walk_path; walk_iter; walk_arg }


(* TODO: remove walker below *)

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
      | CallE (id, al) -> CallE (id, List.map (walk_arg f) al)
      | InvCallE (id, nl, el) -> InvCallE (id, nl, List.map (walk_arg f) el)
      (* TODO: Implement walker for iter *)
      | ListE el -> ListE (List.map new_ el)
      | CompE (e1, e2) -> CompE (new_ e1, new_ e2)
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
      | ArityE e' -> ArityE (new_ e')
      | FrameE (e1_opt, e2) -> FrameE (Option.map new_ e1_opt, new_ e2)
      | LabelE (e1, e2) -> LabelE (new_ e1, new_ e2)
      | ContE e' -> ContE (new_ e')
      | ChooseE e' -> ChooseE (new_ e')
      | VarE id -> VarE id
      | SubE (id, t) -> SubE (id, t)
      | IterE (e, (iter, xes)) -> IterE (new_ e, (iter, List.map (fun (x, e) -> (x, new_ e)) xes))
      | ContextKindE _ -> e.it
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

and walk_arg f a =
  match a.it with
  | ExpA e -> { a with it = ExpA (walk_expr f e) }
  | TypA _
  | DefA _ -> a

let rec walk_instr f (instr:instr) : instr list =
  let { pre_instr = pre; post_instr = post; stop_cond_instr = stop_cond; _ } = f in
  let new_ = List.concat_map (walk_instr f) in
  let new_e = walk_expr f in
  let new_a = walk_arg f in

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
      | ThrowI e -> ThrowI (new_e e)
      | NopI -> NopI
      | ReturnI e_opt -> ReturnI (Option.map new_e e_opt)
      | EnterI (e1, e2, il) -> EnterI (new_e e1, new_e e2, new_ il)
      | ExecuteI e -> ExecuteI (new_e e)
      | ExecuteSeqI e -> ExecuteSeqI (new_e e)
      | PerformI (id, al) -> PerformI (id, List.map new_a al)
      | ExitI _ -> i.it
      | ReplaceI (e1, p, e2) -> ReplaceI (new_e e1, walk_path f p, new_e e2)
      | AppendI (e1, e2) -> AppendI (new_e e1, new_e e2)
      | FieldWiseAppendI (e1, e2) -> FieldWiseAppendI (new_e e1, new_e e2)
      | YetI _ -> i.it in
    { i with it = i' }
  in

  let il1 = pre instr in
  let il2 = List.map (fun i -> if stop_cond i then i else super_walk i) il1 in
  let il3 = List.concat_map post il2 in
  il3

and walk_instrs f = walk_instr f |> List.concat_map

let walk' f algo' = match algo' with
  | RuleA (a, anchor, params, body) -> RuleA (a, anchor, params, walk_instrs f body)
  | FuncA (id, params, body) -> FuncA (id, params, walk_instrs f body)
let walk f algo = Source.map (walk' f) algo
