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

let list_sum = List.fold_left ( + ) 0

let rec count_instrs instrs =
  instrs
  |> List.map (function
       | IfI (_, il1, il2) | EitherI (il1, il2) ->
           1 + count_instrs il1 + count_instrs il2
       | OtherwiseI il | WhileI (_, il) -> 1 + count_instrs il
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
          IfI (c1, common @ own_body1 @ own_body2, []) :: rest
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
      | IfI (c1, then_body, []), IfI (c2, else_body, []) :: rest
        when neg c1 = c2 ->
          IfI (c1, then_body, else_body) :: rest
      | _ -> new_i :: il)
    instrs []

let if_not_defined =
  let transpile_cond = function
  | CompareC (Eq, e, OptE None) -> NotC (IsDefinedC e)
  | c -> c in
  Walk.walk_instr { Walk.default_action with post_cond = transpile_cond }

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
  Walk.walk_instr { Walk.default_action with post_instr = lift transpile_instr }

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

let push_either =
  let push_either' = fun i -> match i with
    | EitherI (il1, il2) -> ( match ( Util.Lib.List.split_last il1) with
      | hds, IfI (c, then_body, []) -> EitherI (hds @ [ IfI (c, then_body, il2) ], il2)
      | _ -> i )
    | _ -> i in

  Walk.walk_instr { Walk.default_action with pre_instr = lift push_either' }

let enhance_readability instrs =
  instrs
  |> unify_if
  |> List.concat_map if_not_defined
  |> infer_else
  |> List.concat_map swap_if
  |> List.concat_map unify_if_tail

(** Walker-based Translpiler **)
let rec mk_access ps base =
  match ps with
  | h :: t -> AccessE (base, h) |> mk_access t
  | [] -> base

(* Hide state and make it implicit from the prose. Can be turned off. *)
let hide_state_instr = function
  | ReturnI (Some (PairE (NameE (N "s", []), NameE (N "f", [])))) -> [ ReturnI None ]
  | ReturnI (Some (PairE (NameE (N s, []), NameE (N f, []))))
    when String.starts_with ~prefix:"s_" s
      && String.starts_with ~prefix:"f_" f -> [ ReturnI None ]

  | ReturnI (Some (NameE (N "s", []))) -> [ ReturnI None ]
  | ReturnI (Some (NameE (N s, [])))
    when String.starts_with ~prefix:"s_" s -> [ ReturnI None ]
  (* Perform *)
  | LetI (PairE (NameE (N s, []), NameE (N f, [])), AppE (fname, el))
    when String.starts_with ~prefix:"s_" s
      && String.starts_with ~prefix:"f_" f -> [ PerformI (AppE (fname, el)) ]
  | LetI (NameE (N s, []), AppE (fname, el))
    when String.starts_with ~prefix:"s_" s -> [ PerformI (AppE (fname, el)) ]
  (* Append *)
  | LetI (NameE (N s, []), ExtendE (e1, ps, ListE [ e2 ]))
    when String.starts_with ~prefix:"s_" s ->
      [ AppendI (mk_access ps e1, e2) ]
  (* Replace *)
  | LetI (NameE (N s, []), ReplaceE (e1, ps, e2))
    when String.starts_with ~prefix:"s_" s ->
      begin match List.rev ps with
      | h :: t -> [ ReplaceI (mk_access (List.rev t) e1, h, e2) ]
      | _ -> failwith "Invalid replace"
      end
  | i -> [ i ]

let hide_state = function
  | AppE (f, args) ->
      let new_args =
        List.filter
          (function
            | PairE (NameE (N "s", []), NameE (N "f", []))
            | NameE (N "z", []) -> false
            | PairE (NameE (N s, []), NameE (N "f", []))
              when String.starts_with ~prefix:"s_" s -> false
            | PairE (NameE (N s, []), NameE (N f, []))
              when String.starts_with ~prefix:"s_" s
              && String.starts_with ~prefix:"f_" f
                -> false
            | NameE (N "s", []) -> false
            | NameE (N s, []) when String.starts_with ~prefix:"s_" s -> false
            | _ -> true)
          args
      in
      AppE (f, new_args)
  | ListE [ NameE (N "s", []); e ]
  | ListE [ NameE (N "s'", []); e ] -> e
  | ListE [ NameE (N s, []); e ] when String.starts_with ~prefix:"s_" s -> e
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
      { Walk.default_action with
        post_instr = composite_instr hide_state_instr (lift flatten_if);
        post_expr = composite hide_state simplify_record_concat
      }
  in
  let Algo (name, params, body) = walker algo in
  match params with
  | (PairE (_, f), StateT) :: tail ->
      Algo (name, tail, LetI (f, GetCurFrameE) :: body)
  | (NameE (N "s", []), _) :: tail ->
      Algo (name, tail, body)
  | _ -> Algo(name, params, body)
