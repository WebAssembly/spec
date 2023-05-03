(** helper *)
let take n str =
  let len = min n (String.length str) in
  (String.sub str 0 len) ^ if len <= n then "" else "..."

let rec neg cond = match cond with
| Al.NotC c -> c
| Al.AndC (c1, c2) -> Al.OrC (neg c1, neg c2)
| Al.OrC (c1, c2) -> Al.AndC (neg c1, neg c2)
| Al.GtC (e1, e2) -> Al.LeC(e1, e2)
| Al.GeC (e1, e2) -> Al.LtC(e1, e2)
| Al.LtC (e1, e2) -> Al.GeC(e1, e2)
| Al.LeC (e1, e2) -> Al.GtC(e1, e2)
| _ -> Al.NotC cond

let list_sum = List.fold_left (+) 0

let rec count_instrs instrs = instrs |>
  List.map (function
  | Al.IfI (_, il1, il2)
  | Al.EitherI (il1, il2) -> 1 + count_instrs il1 + count_instrs il2
  | Al.OtherwiseI (il)
  | Al.WhileI (_, il)
  | Al.RepeatI (_, il) -> 1 + count_instrs il
  | _ -> 1
  ) |> list_sum

(** AL -> AL transpilers *)

(* Recursively append else block to every empty if *)
let rec insert_otherwise else_body instrs =
  let walk = insert_otherwise else_body in
  List.fold_left_map (fun visit_if inst ->
    match inst with
    | Al.IfI (c, il, []) ->
      let (_, il') = walk il in
      ( true, Al.IfI(c, il', else_body) )
    | Al.IfI (c, il1, il2) ->
      let (visit_if1, il1') = walk il1 in
      let (visit_if2, il2') = walk il2 in
      let visit_if = visit_if || visit_if1 || visit_if2 in
      ( visit_if, Al.IfI(c, il1', il2') )
    | Al.OtherwiseI (il) ->
      let (visit_if', il') = walk il in
      let visit_if = visit_if || visit_if' in
      ( visit_if, Al.OtherwiseI(il') )
    | Al.WhileI (c, il) ->
      let (visit_if', il') = walk il in
      let visit_if = visit_if || visit_if' in
      ( visit_if, Al.WhileI(c, il') )
    | Al.RepeatI (e, il) ->
      let (visit_if', il') = walk il in
      let visit_if = visit_if || visit_if' in
      ( visit_if, Al.RepeatI(e, il') )
    | Al.EitherI (il1, il2) ->
      let (visit_if1, il1') = walk il1 in
      let (visit_if2, il2') = walk il2 in
      let visit_if = visit_if || visit_if1 || visit_if2 in
      ( visit_if, Al.EitherI(il1', il2') )
    | _ -> (visit_if, inst)
  ) false instrs

(* If the latter block of instrs is a single Otherwise, merge them *)
let merge_otherwise instrs1 instrs2 = match instrs2 with
| [ Al.OtherwiseI else_body ] ->
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
  | Al.IfI (c, il1, il2) -> Al.IfI (c, infer_else il1, infer_else il2)
  | Al.OtherwiseI (il) -> Al.OtherwiseI (infer_else il)
  | Al.WhileI (c, il) -> Al.WhileI (c, infer_else il)
  | Al.RepeatI (e, il) -> Al.RepeatI (e, infer_else il)
  | Al.EitherI (il1, il2) -> Al.EitherI (infer_else il1, infer_else il2)
  | _ -> i
  in
  match (new_i, il) with
  | ( Al.IfI(c1, then_body, []), Al.IfI(c2, else_body, []) :: rest )
    when neg c1 = c2 ->
      Al.IfI(c1, then_body, else_body) :: rest
  | _ -> new_i :: il
) instrs []

let rec swap_if instr =
  let new_ = List.map swap_if in
  match instr with
  | Al.IfI (c, il, [])
  | Al.IfI (c, il, [ NopI ]) -> Al.IfI (c, new_ il, [])
  | Al.IfI (c, [ NopI ], il) -> Al.IfI (neg c, new_ il, [])
  | Al.IfI (c, il1, il2) ->
    if count_instrs il1 <= count_instrs il2 then
      Al.IfI (c, new_ il1, new_ il2)
    else
      Al.IfI (neg c, new_ il2, new_ il1)
  | Al.OtherwiseI (il) -> Al.OtherwiseI (new_ il)
  | Al.WhileI (c, il) -> Al.WhileI (c, new_ il)
  | Al.RepeatI (e, il) -> Al.RepeatI (e, new_ il)
  | Al.EitherI (il1, il2) -> Al.EitherI (new_ il1, new_ il2)
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
  | Al.IfI (c, il1, il2) ->
    let (then_il, else_il, finally_il) = unify_tail (new_ il1) (new_ il2) in
    Al.IfI (c, then_il, else_il) :: finally_il
  | Al.OtherwiseI (il) -> [ Al.OtherwiseI (new_ il) ]
  | Al.WhileI (c, il) -> [ Al.WhileI (c, new_ il) ]
  | Al.RepeatI (e, il) -> [ Al.RepeatI (e, new_ il) ]
  | Al.EitherI (il1, il2) -> [ Al.EitherI (new_ il1, new_ il2) ]
  | _ -> [instr]

let enhance_readability instrs =
  instrs
  |> infer_else
  |> List.map swap_if
  |> List.concat_map unify_if_tail


(* Hide state and make it implicit from the prose. Can be turned off. *)

let is_state = function
| Al.NameE (Al.N "z") -> true
| _ -> false

let hide_state_expr e = match e with
| Al.AppE (f, args) -> Al.AppE(f, List.filter (fun x -> not (is_state x)) args)
| _ -> e

let rec hide_state_instr instr =
  let hide_state_instrs = List.map hide_state_instr in
  match instr with
  | Al.IfI (c, t, e) -> Al.IfI (c, hide_state_instrs t, hide_state_instrs e)
  | Al.OtherwiseI (b) -> Al.OtherwiseI (hide_state_instrs b)
  | Al.WhileI (c, il) -> Al.WhileI (c, hide_state_instrs il)
  | Al.RepeatI (e, il) -> Al.RepeatI (e, hide_state_instrs il)
  | Al.EitherI (il1, il2) -> Al.EitherI (hide_state_instrs il1, hide_state_instrs il2)
  | Al.AssertI s -> Al.AssertI s
  | Al.PushI e -> Al.PushI (hide_state_expr e)
  | Al.PopI e -> Al.PopI (hide_state_expr e)
  | Al.LetI (n, e) -> Al.LetI (n, hide_state_expr e)
  | Al.TrapI -> Al.TrapI
  | Al.NopI -> Al.NopI
  | Al.ReturnI e_opt -> Al.ReturnI (Option.map hide_state_expr e_opt)
  | Al.InvokeI e -> Al.InvokeI (hide_state_expr e)
  | Al.EnterI (s, e) -> Al.EnterI (s, hide_state_expr e)
  | Al.ExecuteI (s, el) -> Al.ExecuteI (s, List.map hide_state_expr el)
  | Al.ReplaceI (e1, e2) -> Al.ReplaceI (hide_state_expr e1, hide_state_expr e2)
  | Al.JumpI e -> Al.JumpI (hide_state_expr e)
  | Al.PerformI e -> Al.PerformI (hide_state_expr e)
  | Al.YetI s -> Al.YetI s

let hide_state = function Al.Algo(name, params, body) ->
  let new_body = body |> List.map hide_state_instr in
  match params with
  | (Al.PairE (_, f), StateT) :: rest_params -> Al.Algo(
      name,
      rest_params,
      Al.LetI(f, Al.FrameE) :: new_body
    )
  | _ -> Al.Algo(name, params, new_body)
