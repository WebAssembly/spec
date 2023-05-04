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

let is_state = function
  | NameE (N "z") -> true
  | _ -> false

let rec hide_state_expr e = match e with
  | LengthE inner_e -> LengthE (hide_state_expr inner_e)
  | AppE (f, args) -> AppE(f, List.filter (fun x -> not (is_state x)) args)
  | IndexAccessE (e1, e2) -> IndexAccessE (hide_state_expr e1, hide_state_expr e2)
  | ConstE (e1, e2) -> ConstE (hide_state_expr e1, hide_state_expr e2)
  | RefFuncAddrE inner_e -> RefFuncAddrE (hide_state_expr inner_e)
  | _ -> e

let rec hide_state_cond c = match c with
  | OrC (c1, c2) -> OrC (hide_state_cond c1, hide_state_cond c2)
  | GeC (e1, e2) -> GeC (hide_state_expr e1, hide_state_expr e2)
  | GtC (e1, e2) -> GtC (hide_state_expr e1, hide_state_expr e2)
  | LtC (e1, e2) -> LtC (hide_state_expr e1, hide_state_expr e2)
  | _ -> c

let rec hide_state_instr instr =
  let hide_state_instrs = List.map hide_state_instr in
  match instr with
  | IfI (c, t, e) -> IfI (hide_state_cond c, hide_state_instrs t, hide_state_instrs e)
  | OtherwiseI (b) -> OtherwiseI (hide_state_instrs b)
  | WhileI (c, il) -> WhileI (hide_state_cond c, hide_state_instrs il)
  | RepeatI (e, il) -> RepeatI (hide_state_expr e, hide_state_instrs il)
  | EitherI (il1, il2) -> EitherI (hide_state_instrs il1, hide_state_instrs il2)
  | AssertI s -> AssertI s
  | PushI e -> PushI (hide_state_expr e)
  | PopI e -> PopI (hide_state_expr e)
  | LetI (n, e) -> LetI (n, hide_state_expr e)
  | TrapI -> TrapI
  | NopI -> NopI
  | ReturnI e_opt -> ReturnI (Option.map hide_state_expr e_opt)
  | InvokeI e -> InvokeI (hide_state_expr e)
  | EnterI (s, e) -> EnterI (s, hide_state_expr e)
  | ExecuteI (s, el) -> ExecuteI (s, List.map hide_state_expr el)
  | ReplaceI (e1, e2) -> ReplaceI (hide_state_expr e1, hide_state_expr e2)
  | JumpI e -> JumpI (hide_state_expr e)
  | PerformI e -> PerformI (hide_state_expr e)
  | YetI s -> YetI s

let hide_state = function Algo(name, params, body) ->
  let new_body = body |> List.map hide_state_instr in
  match params with
  | (PairE (_, f), StateT) :: rest_params -> Algo(
      name,
      rest_params,
      LetI(f, FrameE) :: new_body
    )
  | _ -> Algo(name, params, new_body)
