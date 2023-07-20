open Al
open Al.Ast

(** helper *)
let composite_instr g f x = f x |> List.map g |> List.flatten
let composite g f x = f x |> g

let take n str =
  let len = min n (String.length str) in
  String.sub str 0 len ^ if len <= n then "" else "..."

let rec neg cond =
  match cond with
  | NotC c -> c
  | BinopC (And, c1, c2) -> BinopC (Or, neg c1, neg c2)
  | BinopC (Or, c1, c2) -> BinopC (And, neg c1, neg c2)
  | CompareC (Eq, e1, e2) -> CompareC (Ne, e1, e2)
  | CompareC (Ne, e1, e2) -> CompareC (Eq, e1, e2)
  | CompareC (Gt, e1, e2) -> CompareC (Le, e1, e2)
  | CompareC (Ge, e1, e2) -> CompareC (Lt, e1, e2)
  | CompareC (Lt, e1, e2) -> CompareC (Ge, e1, e2)
  | CompareC (Le, e1, e2) -> CompareC (Gt, e1, e2)
  | _ -> NotC cond

let both_empty cond1 cond2 =
  let get_list = function
  | CompareC (Eq, e, ListE [])
  | CompareC (Eq, ListE [], e)
  | CompareC (Eq, LengthE e, NumE 0L)
  | CompareC (Le, LengthE e, NumE 0L)
  | CompareC (Lt, LengthE e, NumE 1L)
  | CompareC (Eq, NumE 0L, LengthE e)
  | CompareC (Ge, NumE 0L, LengthE e)
  | CompareC (Ge, NumE 1L, LengthE e) -> Some e
  | _ -> None in
  match get_list cond1, get_list cond2 with
  | Some e1, Some e2 -> e1 = e2
  | _ -> false

let both_non_empty cond1 cond2 =
  let get_list = function
  | CompareC (Ne, e, ListE [])
  | CompareC (Ne, ListE [], e)
  | CompareC (Ne, LengthE e, NumE 0L)
  | CompareC (Gt, LengthE e, NumE 0L)
  | CompareC (Ge, LengthE e, NumE 1L)
  | CompareC (Ne, NumE 0L, LengthE e)
  | CompareC (Lt, NumE 0L, LengthE e)
  | CompareC (Le, NumE 1L, LengthE e) -> Some e
  | _ -> None in
  match get_list cond1, get_list cond2 with
  | Some e1, Some e2 -> e1 = e2
  | _ -> false

let eq_cond cond1 cond2 =
  cond1 = cond2
  || both_empty cond1 cond2
  || both_non_empty cond1 cond2

let list_sum = List.fold_left ( + ) 0

let rec count_instrs instrs =
  instrs
  |> List.map (function
       | IfI (_, il1, il2) | EitherI (il1, il2) ->
           1 + count_instrs il1 + count_instrs il2
       | OtherwiseI il | WhileI (_, il) | ForI (_, il) | ForeachI (_, _, il) -> 1 + count_instrs il
       | TrapI | ReturnI _ -> 0
       | _ -> 1)
  |> list_sum

let rec unify_head acc l1 l2 =
  match (l1, l2) with
  | h1 :: t1, h2 :: t2 when h1 = h2 -> unify_head (h1 :: acc) t1 t2
  | _ -> (List.rev acc, l1, l2)

(** AL -> AL transpilers *)

(* Recursively append else block to every empty if *)
let rec insert_otherwise else_body instrs =
  let walk = insert_otherwise else_body in
  List.fold_left_map
    (fun visit_if inst ->
      match inst with
      | IfI (c, il, []) ->
          let _, il' = walk il in
          (true, IfI (c, il', else_body))
      | IfI (c, il1, il2) ->
          let visit_if1, il1' = walk il1 in
          let visit_if2, il2' = walk il2 in
          let visit_if = visit_if || visit_if1 || visit_if2 in
          (visit_if, IfI (c, il1', il2'))
      | OtherwiseI il ->
          let visit_if', il' = walk il in
          let visit_if = visit_if || visit_if' in
          (visit_if, OtherwiseI il')
      | WhileI (c, il) ->
          let visit_if', il' = walk il in
          let visit_if = visit_if || visit_if' in
          (visit_if, WhileI (c, il'))
      | EitherI (il1, il2) ->
          let visit_if1, il1' = walk il1 in
          let visit_if2, il2' = walk il2 in
          let visit_if = visit_if || visit_if1 || visit_if2 in
          (visit_if, EitherI (il1', il2'))
      | ForI (e, il) ->
          let visit_if', il' = walk il in
          let visit_if = visit_if || visit_if' in
          (visit_if, ForI (e, il'))
      | ForeachI (e1, e2, il) ->
          let visit_if', il' = walk il in
          let visit_if = visit_if || visit_if' in
          (visit_if, ForeachI (e1, e2, il'))
      | _ -> (visit_if, inst))
    false instrs

(* Merge two consecutive blocks: *)
(* - If they share same prefix *)
(* - If the latter block of instrs is a single Otherwise *)
let merge instrs1 instrs2 =
  let head, tail1, tail2 = unify_head [] instrs1 instrs2 in
  head @ match tail2 with
  | [ OtherwiseI else_body ] ->
      let visit_if, merged = insert_otherwise else_body tail1 in
      if not visit_if then
        print_endline
          ("Warning: No corresponding if for"
          ^ take 100 (Print.string_of_instrs 0 instrs2));
      merged
  | _ -> tail1 @ tail2

(** Enhance readability of AL **)

let rec unify_if instrs =
  List.fold_right
    (fun i il ->
      let new_i =
        match i with
        | IfI (c, il1, il2) -> IfI (c, unify_if il1, unify_if il2)
        | OtherwiseI il -> OtherwiseI (unify_if il)
        | WhileI (c, il) -> WhileI (c, unify_if il)
        | EitherI (il1, il2) -> EitherI (unify_if il1, unify_if il2)
        | ForI (e, il) -> ForI (e, unify_if il)
        | ForeachI (e1, e2, il) -> ForeachI (e1, e2, unify_if il)
        | _ -> i
      in
      match (new_i, il) with
      | IfI (c1, body1, []), IfI (c2, body2, []) :: rest
        when c1 = c2 ->
          (* Assumption: common should have no side effect (replace) *)
          let common, own_body1, own_body2 = unify_head [] body1 body2 in
          let body = unify_if (common @ own_body1 @ own_body2) in
          IfI (c1, body, []) :: rest
      | _ -> new_i :: il)
    instrs []

let rec infer_else instrs =
  List.fold_right
    (fun i il ->
      let new_i =
        match i with
        | IfI (c, il1, il2) -> IfI (c, infer_else il1, infer_else il2)
        | OtherwiseI il -> OtherwiseI (infer_else il)
        | WhileI (c, il) -> WhileI (c, infer_else il)
        | EitherI (il1, il2) -> EitherI (infer_else il1, infer_else il2)
        | ForI (e, il) -> ForI (e, infer_else il)
        | ForeachI (e1, e2, il) -> ForeachI (e1, e2, infer_else il)
        | _ -> i
      in
      match (new_i, il) with
      | IfI (c1, then_body1, else_body1), IfI (c2, else_body2, then_body2) :: rest
        when eq_cond c1 (neg c2) ->
          IfI (c1, then_body1 @ then_body2, else_body1 @ else_body2) :: rest
      | _ -> new_i :: il)
    instrs []

let if_not_defined =
  let transpile_cond = function
  | CompareC (Eq, e, OptE None) -> NotC (IsDefinedC e)
  | c -> c in
  Walk.walk_instr { Walk.default_config with post_cond = transpile_cond }

let lift f x = [f x]

let swap_if =
  let transpile_instr = function
  | IfI (c, il, [ ])
  | IfI (c, il, [ NopI ]) -> IfI (c, il, [])
  | IfI (c, [ NopI ], il) -> IfI (neg c, il, [])
  | IfI (c, il1, il2) ->
      if count_instrs il1 <= count_instrs il2 then
        IfI (c, il1, il2)
      else
        IfI (neg c, il2, il1)
  | i -> i in
  Walk.walk_instr { Walk.default_config with post_instr = lift transpile_instr }

let rec return_at_last = function
| [] -> false
| [ TrapI ] | [ ReturnI _ ] -> true
| _ :: tl -> return_at_last tl

let early_return = Walk.walk_instr { Walk.default_config with post_instr =
  function
  | IfI (c, il1, il2) as i ->
    if return_at_last il1 then IfI (c, il1, []) :: il2 else [ i ]
  | i -> [i]
}

let unify_tail instrs1 instrs2 =
  let rev = List.rev in
  let rh, rt1, rt2 = unify_head [] (rev instrs1) (rev instrs2) in
  (rev rt1, rev rt2, rev rh)

let rec unify_if_tail instr =
  let new_ = List.concat_map unify_if_tail in
  match instr with
  | IfI (c, il1, il2) ->
      let then_il, else_il, finally_il = unify_tail (new_ il1) (new_ il2) in
      IfI (c, then_il, else_il) :: finally_il
  | OtherwiseI il -> [ OtherwiseI (new_ il) ]
  | WhileI (c, il) -> [ WhileI (c, new_ il) ]
  | EitherI (il1, il2) -> [ EitherI (new_ il1, new_ il2) ]
  | ForI (e, il) -> [ ForI (e, new_ il) ]
  | ForeachI (e1, e2, il) -> [ ForeachI (e1, e2, new_ il) ]
  | _ -> [ instr ]

let rec remove_unnecessary_branch path_cond instr =
  let new_ = List.concat_map (remove_unnecessary_branch path_cond) in
  match instr with
  | IfI (c, il1, il2) ->
    if List.exists (eq_cond c) path_cond then
      il1
    else if List.exists (eq_cond (neg c)) path_cond then
      il2
    else
      let new_il1 = List.concat_map (remove_unnecessary_branch (c :: path_cond)) il1 in
      let new_il2 = List.concat_map (remove_unnecessary_branch ((neg c) :: path_cond)) il2 in
      [ IfI (c, new_il1, new_il2) ]
  | OtherwiseI il -> [ OtherwiseI (new_ il) ]
  | WhileI (c, il) -> [ WhileI (c, new_ il) ]
  | EitherI (il1, il2) -> [ EitherI (new_ il1, new_ il2) ]
  | ForI (e, il) -> [ ForI (e, new_ il) ]
  | ForeachI (e1, e2, il) -> [ ForeachI (e1, e2, new_ il) ]
  | _ -> [ instr ]

let push_either =
  let push_either' = fun i -> match i with
    | EitherI (il1, il2) -> ( match ( Util.Lib.List.split_last il1) with
      | hds, IfI (c, then_body, []) -> EitherI (hds @ [ IfI (c, then_body, il2) ], il2)
      | _ -> i )
    | _ -> i in

  Walk.walk_instr { Walk.default_config with pre_instr = lift push_either' }

let enhance_readability instrs =
  instrs
  |> unify_if
  |> List.concat_map if_not_defined
  |> infer_else
  |> List.concat_map unify_if_tail
  |> List.concat_map (remove_unnecessary_branch [])
  |> List.concat_map swap_if
  |> List.concat_map early_return

(** Walker-based Translpiler **)
let rec mk_access ps base =
  match ps with
  | h :: t -> AccessE (base, h) |> mk_access t
  | [] -> base

(* Hide state and make it implicit from the prose. Can be turned off. *)
let hide_state_args = List.filter (function
  | PairE (NameE (N "s"), NameE (N "f"))
  | NameE (N "z") -> false
  | PairE (NameE (N s), NameE (N "f"))
    when String.starts_with ~prefix:"s_" s -> false
  | PairE (NameE (N s), NameE (N f))
    when String.starts_with ~prefix:"s_" s
    && String.starts_with ~prefix:"f_" f
      -> false
  | NameE (N "s") -> false
  | NameE (N s) when String.starts_with ~prefix:"s_" s -> false
  | _ -> true)

let hide_state_instr = function
  | ReturnI (Some (PairE (ReplaceE (e1, pl, e2), NameE (N "f"))))
  | ReturnI (Some (PairE (NameE (N "s"), ReplaceE (e1, pl, e2)))) ->
      let rpl = List.rev pl in
      let target =
        List.tl rpl
        |> List.fold_right
          (fun p acc -> AccessE (acc, p))
      in
      [ ReplaceI (target e1, List.hd rpl, e2) ]
  | ReturnI (Some (PairE (NameE (N "s"), NameE (N "f")))) -> []
  | ReturnI (Some (PairE ((NameE (N s)), NameE (N f))))
    when String.starts_with ~prefix:"s_" s
      && String.starts_with ~prefix:"f_" f -> []

  | ReturnI (Some (NameE (N "s"))) -> []
  | ReturnI (Some (NameE (N s)))
    when String.starts_with ~prefix:"s_" s -> []
  (* Perform *)
  | LetI (PairE (NameE (N s), NameE (N f)), AppE (fname, el))
    when String.starts_with ~prefix:"s_" s
      && String.starts_with ~prefix:"f_" f -> [ PerformI (fname, el) ]
  | LetI (NameE (N s), AppE (fname, el))
    when String.starts_with ~prefix:"s_" s -> [ PerformI (fname, el) ]
  (* Append *)
  | LetI (NameE (N s), ExtendE (e1, ps, ListE [ e2 ], Back) )
    when String.starts_with ~prefix:"s_" s ->
      [ AppendI (mk_access ps e1, e2) ]
  (* Replace *)
  | LetI (NameE (N s), ReplaceE (e1, ps, e2))
    when String.starts_with ~prefix:"s_" s ->
      begin match List.rev ps with
      | h :: t -> [ ReplaceI (mk_access (List.rev t) e1, h, e2) ]
      | _ -> failwith "Invalid replace"
      end
  | CallI (lhs, f, args, iters) -> [ CallI (lhs, f, hide_state_args args, iters) ]
  | PerformI (f, args) -> [ PerformI (f, hide_state_args args) ]
  | i -> [ i ]


let hide_state = function
  | AppE (f, args) -> AppE (f, hide_state_args args)
  | ListE [ NameE (N "s"); e ]
  | ListE [ NameE (N "s'"); e ] -> e
  | ListE [ NameE (N s); e ] when String.starts_with ~prefix:"s_" s -> e
  | e -> e

let simplify_record_concat = function
  | ConcatE (e1, e2) ->
    let nonempty = function ListE [] | OptE None -> false | _ -> true in
    let remove_empty_field = function
      | RecordE r -> RecordE (Record.filter (fun _ v -> nonempty v) r)
      | e -> e in
    ConcatE (remove_empty_field e1, remove_empty_field e2)
  | e -> e

let flatten_if = function
  | IfI (c1, [IfI (c2, il1, il2)], []) -> IfI (BinopC (And, c1, c2), il1, il2)
  | i -> i

let transpiler algo =
  let walker =
    Walk.walk
      { Walk.default_config with
        post_instr = composite_instr hide_state_instr (lift flatten_if);
        post_expr = composite hide_state simplify_record_concat
      }
  in
  let Algo (name, params, body) = walker algo in
  match params with
  | (PairE (_, f), StateT) :: tail ->
      Algo (name, tail, LetI (f, GetCurFrameE) :: body)
  | (NameE (N "s"), _) :: tail ->
      Algo (name, tail, body)
  | _ -> Algo(name, params, body)

(* Remove AppE / MapE *)
let app_remover algo =
  let to_call = function
    | LetI (lhs, AppE (f, args)) -> CallI (lhs, f, args, [])
    | LetI (lhs, MapE (f, args, iters)) -> CallI (lhs, f, args, iters)
    | i -> i in
  let stack = ref [] in
  let pre i =
    stack := ref [] :: !stack;
    [ to_call i ] in
  let post i =
    let extra = List.rev !(List.hd !stack) in
    stack := List.tl !stack;
    extra @ [i] in

  let call_id = ref 0 in
  let call_prefix = "r_" in
  let get_fresh () =
    let id = !call_id in
    call_id := id + 1;
    NameE (N (call_prefix ^ (string_of_int id))) in
  let replace_call e = match e with
    | AppE (f, args) ->
      let fresh = get_fresh () in
      let instrs = List.hd !stack in
      instrs := CallI (fresh, f, args, []) :: !instrs;
      fresh
    | MapE (f, args, iters) ->
      let fresh = get_fresh () in
      let instrs = List.hd !stack in
      instrs := CallI (fresh, f, args, iters) :: !instrs;
      fresh
    | _ -> e in

  Walk.walk { Walk.default_config with
    pre_instr = pre;
    post_instr = post;
    post_expr = replace_call;
  } algo

let iter_rule names iter =
  let rec name_of_iter =
    function
    | IterE (e, _) -> name_of_iter e
    | NameE (N name) -> name
    | _ -> failwith "Not an iter of variable"
  in

  let post_expr =
    function
    | NameE (N name) as e when List.mem name names -> IterE (e, iter)
    | AppE (fname, el) as e ->
        begin match List.rev el with
        | IterE (inner_e, inner_iter) :: t
          when List.mem (name_of_iter inner_e) names ->
            MapE (fname, inner_e :: t |> List.rev, [ inner_iter ])
        | _ -> e
        end
    | MapE (fname, el, iters) as e ->
        begin match List.rev el with
        | IterE (inner_e, inner_iter) :: t
          when List.mem (name_of_iter inner_e) names ->
            MapE (fname, inner_e :: t |> List.rev, inner_iter :: iters)
        | _ -> e
        end
    | e -> e
  in

  Walk.walk_instr { Walk.default_config with
    (* pre_expr = pre_expr;*)
    post_expr = post_expr;
  }

let rec enforce_return_r rinstrs =
  let rev = List.rev in
  match rinstrs with
  | [] -> []
  | tl :: hd -> match tl with
    | ReturnI _ | TrapI -> rinstrs
    | IfI (c, il1, il2) ->
      ( match enforce_return' il1, enforce_return' il2 with
      | [], [] -> enforce_return_r hd
      | new_il, [] -> rev new_il @ (AssertI c :: hd)
      | [], new_il -> rev new_il @ (AssertI (neg c) :: hd)
      | new_il1, new_il2 -> IfI (c, new_il1, new_il2) :: hd )
    | OtherwiseI il -> OtherwiseI (enforce_return' il) :: hd
    | EitherI (il1, il2) ->
      ( match enforce_return' il1, enforce_return' il2 with
      | [], [] -> enforce_return_r hd
      | new_il, []
      | [], new_il -> rev new_il @ hd
      | new_il1, new_il2 -> EitherI (new_il1, new_il2) :: hd )
    | WhileI (_, il)
    | ForI (_, il)
    | ForeachI (_, _, il) ->
      ( match enforce_return' il with
      | [] -> enforce_return_r hd
      | _ -> rinstrs ) (* body of these statements should not change, even if last instr is not return *)
    | _ -> enforce_return_r hd
and enforce_return' instrs = instrs |> List.rev |> enforce_return_r |> List.rev

let contains_return il =
  let ret = ref false in
  List.map (Walk.walk_instr { Walk.default_config with
    pre_instr = (fun i ->
      ( match i with | ReturnI _ | TrapI -> ret := true | _ -> () );
      [ i ]
    )
  }) il |> ignore;
  !ret

(** If intrs contain a return statement, make sure that every path has return statement in the end **)
let enforce_return instrs =
  if contains_return instrs then enforce_return' instrs else instrs
