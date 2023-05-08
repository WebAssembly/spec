open Al

(** helper *)
let take n str =
  let len = min n (String.length str) in
  (String.sub str 0 len) ^ if len <= n then "" else "..."

let rec neg cond = match cond with
| NotC c -> c
| AndC (c1, c2) -> OrC (neg c1, neg c2)
| OrC (c1, c2) -> AndC (neg c1, neg c2)
| GtC (e1, e2) -> LeC(e1, e2)
| GeC (e1, e2) -> LtC(e1, e2)
| LtC (e1, e2) -> GeC(e1, e2)
| LeC (e1, e2) -> GtC(e1, e2)
| _ -> NotC cond

let list_sum = List.fold_left (+) 0

let rec count_instrs instrs = instrs |>
  List.map (function
  | IfI (_, il1, il2)
  | EitherI (il1, il2) -> 1 + count_instrs il1 + count_instrs il2
  | OtherwiseI (il)
  | WhileI (_, il)
  | RepeatI (_, il) -> 1 + count_instrs il
  | _ -> 1
  ) |> list_sum

(** AL -> AL transpilers *)

(* Recursively append else block to every empty if *)
let rec insert_otherwise else_body instrs =
  let walk = insert_otherwise else_body in
  List.fold_left_map (fun visit_if inst ->
    match inst with
    | IfI (c, il, []) ->
      let (_, il') = walk il in
      ( true, IfI(c, il', else_body) )
    | IfI (c, il1, il2) ->
      let (visit_if1, il1') = walk il1 in
      let (visit_if2, il2') = walk il2 in
      let visit_if = visit_if || visit_if1 || visit_if2 in
      ( visit_if, IfI(c, il1', il2') )
    | OtherwiseI (il) ->
      let (visit_if', il') = walk il in
      let visit_if = visit_if || visit_if' in
      ( visit_if, OtherwiseI(il') )
    | WhileI (c, il) ->
      let (visit_if', il') = walk il in
      let visit_if = visit_if || visit_if' in
      ( visit_if, WhileI(c, il') )
    | RepeatI (e, il) ->
      let (visit_if', il') = walk il in
      let visit_if = visit_if || visit_if' in
      ( visit_if, RepeatI(e, il') )
    | EitherI (il1, il2) ->
      let (visit_if1, il1') = walk il1 in
      let (visit_if2, il2') = walk il2 in
      let visit_if = visit_if || visit_if1 || visit_if2 in
      ( visit_if, EitherI(il1', il2') )
    | _ -> (visit_if, inst)
  ) false instrs

(* If the latter block of instrs is a single Otherwise, merge them *)
let merge_otherwise instrs1 instrs2 = match instrs2 with
| [ OtherwiseI else_body ] ->
  let ( visit_if, merged ) = insert_otherwise else_body instrs1 in
  if not visit_if then print_endline (
    "Warning: No corresponding if for" ^
    take 100 ( Print.string_of_instrs 0 instrs2 )
  );
  merged
| _ -> instrs1 @ instrs2

(* Enhance readability of AL *)
let rec infer_else instrs = List.fold_right (fun i il ->
  let new_i = match i with
  | IfI (c, il1, il2) -> IfI (c, infer_else il1, infer_else il2)
  | OtherwiseI (il) -> OtherwiseI (infer_else il)
  | WhileI (c, il) -> WhileI (c, infer_else il)
  | RepeatI (e, il) -> RepeatI (e, infer_else il)
  | EitherI (il1, il2) -> EitherI (infer_else il1, infer_else il2)
  | _ -> i
  in
  match (new_i, il) with
  | ( IfI(c1, then_body, []), IfI(c2, else_body, []) :: rest )
    when neg c1 = c2 ->
      IfI(c1, then_body, else_body) :: rest
  | _ -> new_i :: il
) instrs []

let rec swap_if instr =
  let new_ = List.map swap_if in
  match instr with
  | IfI (c, il, [])
  | IfI (c, il, [ NopI ]) -> IfI (c, new_ il, [])
  | IfI (c, [ NopI ], il) -> IfI (neg c, new_ il, [])
  | IfI (c, il1, il2) ->
    if count_instrs il1 <= count_instrs il2 then
      IfI (c, new_ il1, new_ il2)
    else
      IfI (neg c, new_ il2, new_ il1)
  | OtherwiseI (il) -> OtherwiseI (new_ il)
  | WhileI (c, il) -> WhileI (c, new_ il)
  | RepeatI (e, il) -> RepeatI (e, new_ il)
  | EitherI (il1, il2) -> EitherI (new_ il1, new_ il2)
  | _ -> instr

let rec unify_head acc l1 l2 = match (l1, l2) with
| h1 :: t1, h2 :: t2 when h1 = h2 -> unify_head (h1 :: acc) t1 t2
| _ -> ((List.rev acc), l1, l2)

let unify_tail instrs1 instrs2 =
  let rev = List.rev in
  let (rh, rt1, rt2) = unify_head [] (rev instrs1) (rev instrs2) in
  (rev rt1, rev rt2, rev rh)

let rec unify_if_tail instr =
  let new_ = List.concat_map unify_if_tail in
  match instr with
  | IfI (c, il1, il2) ->
    let (then_il, else_il, finally_il) = unify_tail (new_ il1) (new_ il2) in
    IfI (c, then_il, else_il) :: finally_il
  | OtherwiseI (il) -> [ OtherwiseI (new_ il) ]
  | WhileI (c, il) -> [ WhileI (c, new_ il) ]
  | RepeatI (e, il) -> [ RepeatI (e, new_ il) ]
  | EitherI (il1, il2) -> [ EitherI (new_ il1, new_ il2) ]
  | _ -> [instr]

let enhance_readability instrs =
  instrs
  |> infer_else
  |> List.map swap_if
  |> List.concat_map unify_if_tail


(* Hide state and make it implicit from the prose. Can be turned off. *)

let rec walk_expr f e =
  let (_, _, f_expr) = f in
  match e with
    | ValueE v -> f_expr(ValueE v)
    | MinusE inner_e -> f_expr(MinusE (walk_expr f inner_e))
    | AddE (e1, e2) -> f_expr(AddE (walk_expr f e1, walk_expr f e2))
    | SubE (e1, e2) -> f_expr(SubE (walk_expr f e1, walk_expr f e2))
    | DivE (e1, e2) -> f_expr(DivE (walk_expr f e1, walk_expr f e2))
    | AppE (fname, args) -> f_expr(AppE (fname, walk_exprs f args))
    | IterE (n, iter) -> f_expr(IterE (n, iter))
    | LengthE inner_e -> f_expr(LengthE (walk_expr f inner_e))
    | ArityE inner_e -> f_expr(ArityE (walk_expr f inner_e))
    | FrameE -> f_expr(FrameE)
    | PropE (inner_e, s) -> f_expr(PropE (walk_expr f inner_e, s))
    | ListE (el) -> f_expr(ListE (Array.map (walk_expr f) el))
    | IndexAccessE (e1, e2) -> f_expr(IndexAccessE (walk_expr f e1, walk_expr f e2))
    | RecordE pl ->
        let walk_elem (s, e) = (s, walk_expr f e) in
        f_expr(RecordE (List.map walk_elem pl))
    | ConstE (e1, e2) -> f_expr(ConstE (walk_expr f e1, walk_expr f e2))
    | RefFuncAddrE inner_e -> f_expr(RefFuncAddrE (walk_expr f inner_e))
    | NameE n -> f_expr(NameE n)
    | YetE s -> f_expr(YetE s)
    | _ -> Print.structured_string_of_expr e |> failwith

and walk_exprs f = walk_expr f |> List.map

let rec walk_cond f c =
  let (_, f_cond, _) = f in
  match c with
    | NotC inner_c -> f_cond(NotC (walk_cond f inner_c))
    | OrC (c1, c2) -> f_cond(OrC (walk_cond f c1, walk_cond f c2))
    | EqC (e1, e2) -> f_cond(EqC (walk_expr f e1, walk_expr f e2))
    | GeC (e1, e2) -> f_cond(GeC (walk_expr f e1, walk_expr f e2))
    | GtC (e1, e2) -> f_cond(GtC (walk_expr f e1, walk_expr f e2))
    | LtC (e1, e2) -> f_cond(LtC (walk_expr f e1, walk_expr f e2))
    | LeC (e1, e2) -> f_cond(LeC (walk_expr f e1, walk_expr f e2))
    | _ -> Print.structured_string_of_cond c |> failwith

let rec walk_instr f instr =
  let (f_instr, _, _) = f in
  match instr with
    | IfI (c, t, e) -> f_instr(IfI (walk_cond f c, walk_instrs f t, walk_instrs f e))
    | OtherwiseI (b) -> f_instr(OtherwiseI (walk_instrs f b))
    | WhileI (c, il) -> f_instr(WhileI (walk_cond f c, walk_instrs f il))
    | RepeatI (e, il) -> f_instr(RepeatI (walk_expr f e, walk_instrs f il))
    | EitherI (il1, il2) -> f_instr(EitherI (walk_instrs f il1, walk_instrs f il2))
    | AssertI s -> f_instr(AssertI s)
    | PushI e -> f_instr(PushI (walk_expr f e))
    | PopI e -> f_instr(PopI (walk_expr f e))
    | LetI (n, e) -> f_instr(LetI (n, walk_expr f e))
    | TrapI -> f_instr(TrapI)
    | NopI -> f_instr(NopI)
    | ReturnI e_opt -> f_instr(ReturnI (Option.map (walk_expr f) e_opt))
    | InvokeI e -> f_instr(InvokeI (walk_expr f e))
    | EnterI (s, e) -> f_instr(EnterI (s, walk_expr f e))
    | ExecuteI (s, el) -> f_instr(ExecuteI (s, walk_exprs f el))
    | ReplaceI (e1, e2) -> f_instr(ReplaceI (walk_expr f e1, walk_expr f e2))
    | JumpI e -> f_instr(JumpI (walk_expr f e))
    | PerformI e -> f_instr(PerformI (walk_expr f e))
    | YetI s -> f_instr(YetI s)

and walk_instrs f = walk_instr f |> List.map

let walk f = function Algo(name, params, body) ->
  let new_body = walk_instrs f body in
  match params with
  | (PairE (_, f), StateT) :: rest_params -> Algo(
      name,
      rest_params,
      LetI(f, FrameE) :: new_body
    )
  | _ -> Algo(name, params, new_body)
