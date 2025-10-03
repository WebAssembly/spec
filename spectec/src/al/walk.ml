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
  | VarE _ | SubE _ | NumE _ | BoolE _ | GetCurStateE
  | GetCurContextE _ | YetE _
  | TopValueE None | ContextKindE _ -> ()

  | CvtE (e, _, _) | UnE (_, e) | LiftE e | LenE e
  | IsDefinedE e | IsCaseOfE (e, _) | HasTypeE (e, _) | IsValidE e
  | TopValueE (Some e) | TopValuesE e | ChooseE e -> walker.walk_expr walker e

  | BinE (_, e1, e2) | CompE (e1, e2) | CatE (e1, e2) | MemE (e1, e2)
  | MatchE (e1, e2) ->
    walker.walk_expr walker e1; walker.walk_expr walker e2
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
  | TrapI | FailI | NopI | ReturnI None | ExitI _ | YetI _ -> ()
  | AssertI e | ThrowI e | PushI e | PopI e | PopAllI e
  | ReturnI (Some e)| ExecuteI e | ExecuteSeqI e -> walker.walk_expr walker e
  | LetI (e1, e2) | AppendI (e1, e2) ->
    walker.walk_expr walker e1; walker.walk_expr walker e2
  | PerformI (_, al) -> List.iter (walker.walk_arg walker) al
  | ReplaceI (e1, p, e2) ->
    walker.walk_expr walker e1; walker.walk_path walker p; walker.walk_expr walker e2
  | ForEachI (xes, il) ->
    List.iter (fun (_, e) -> walker.walk_expr walker e) xes;
    List.iter (walker.walk_instr walker) il

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
  walk_instr: walker -> instr -> instr list;
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
    | NumE _ | BoolE _ | VarE _ | SubE _ | GetCurStateE
    | GetCurContextE _ | ContextKindE _ | YetE _ -> expr.it
    | CvtE (e, t1, t2) -> CvtE (walk_expr e, t1, t2)
    | UnE (op, e) -> UnE (op, walk_expr e)
    | BinE (op, e1, e2) -> BinE (op, walk_expr e1, walk_expr e2)
    | CallE (id, al) -> CallE (id, List.map walk_arg al)
    | InvCallE (id, nl, al) -> InvCallE (id, nl, List.map walk_arg al)
    | ListE el -> ListE (List.map walk_expr el)
    | CompE (e1, e2) -> CompE (walk_expr e1, walk_expr e2)
    | CatE (e1, e2) -> CatE (walk_expr e1, walk_expr e2)
    | MemE (e1, e2) -> MemE (walk_expr e1, walk_expr e2)
    | LiftE e -> LiftE (walk_expr e)
    | LenE e -> LenE (walk_expr e)
    | StrE r -> StrE (Record.map (fun x -> x) walk_expr r)
    | AccE (e, p) -> AccE (walk_expr e, walk_path p)
    | ExtE (e1, ps, e2, dir) ->
      ExtE (walk_expr e1, List.map walk_path ps, walk_expr e2, dir)
    | UpdE (e1, ps, e2) -> UpdE (walk_expr e1, List.map walk_path ps, walk_expr e2)
    | CaseE (a, el) -> CaseE (a, List.map walk_expr el)
    | OptE e -> OptE (Option.map walk_expr e)
    | TupE el -> TupE (List.map walk_expr el)
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

let walk_instr (walker: walker) (instr: instr) : instr list =
  let walk_arg  = walker.walk_arg  walker in
  let walk_path = walker.walk_path walker in
  let walk_expr = walker.walk_expr walker in
  let walk_instr = walker.walk_instr walker in
  let it =
    match instr.it with
    | IfI (e, il1, il2) ->
      IfI (walk_expr e, List.concat_map walk_instr il1, List.concat_map walk_instr il2)
    | OtherwiseI il -> OtherwiseI (List.concat_map walk_instr il)
    | EitherI (il1, il2) ->
      EitherI (List.concat_map walk_instr il1, List.concat_map walk_instr il2)
    | EnterI (e1, e2, il) ->
      EnterI (walk_expr e1, walk_expr e2, List.concat_map walk_instr il)
    | AssertI e -> AssertI (walk_expr e)
    | PushI e -> PushI (walk_expr e)
    | PopI e -> PopI (walk_expr e)
    | PopAllI e -> PopAllI (walk_expr e)
    | LetI (e1, e2) -> LetI (walk_expr e1, walk_expr e2)
    | TrapI -> TrapI
    | FailI -> FailI
    | ThrowI e -> ThrowI (walk_expr e)
    | NopI -> NopI
    | ReturnI e_opt -> ReturnI (Option.map walk_expr e_opt)
    | ExecuteI e -> ExecuteI (walk_expr e)
    | ExecuteSeqI e -> ExecuteSeqI (walk_expr e)
    | PerformI (id, al) -> PerformI (id, List.map walk_arg al)
    | ExitI _ -> instr.it
    | ReplaceI (e1, p, e2) -> ReplaceI (walk_expr e1, walk_path p, walk_expr e2)
    | AppendI (e1, e2) -> AppendI (walk_expr e1, walk_expr e2)
    | ForEachI (xes, il) -> ForEachI (List.map (fun (x, e) -> (x, walk_expr e)) xes, List.concat_map walk_instr il)
    | YetI _ -> instr.it
  in
  [{ instr with it }]

let walk_algo (walker: walker) (algo: algorithm) : algorithm =
  let walk_arg  = walker.walk_arg  walker in
  let walk_instr = walker.walk_instr walker in
  let it =
    match algo.it with
    | RuleA (name, anchor, args, instrs) ->
      RuleA (name, anchor, List.map walk_arg args, List.concat_map walk_instr instrs)
    | FuncA (name, args, instrs) ->
      FuncA (name, List.map walk_arg args, List.concat_map walk_instr instrs)
  in
  { algo with it }

let base_walker = { walk_algo; walk_instr; walk_expr; walk_path; walk_iter; walk_arg }
