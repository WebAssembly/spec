open Al
open Al.Ast
open Util
open Util.Record
open Construct

(** helper *)
let composite_instr g f x = f x |> List.map g |> List.flatten
let composite g f x = f x |> g

let take n str =
  let len = min n (String.length str) in
  String.sub str 0 len ^ if len <= n then "" else "..."

let rec neg cond =
  match cond with
  | UnC (NotOp, c) -> c
  | BinC (AndOp, c1, c2) -> BinC (OrOp, neg c1, neg c2)
  | BinC (OrOp, c1, c2) -> BinC (AndOp, neg c1, neg c2)
  | CmpC (EqOp, e1, e2) -> CmpC (NeOp, e1, e2)
  | CmpC (NeOp, e1, e2) -> CmpC (EqOp, e1, e2)
  | CmpC (LtOp, e1, e2) -> CmpC (GeOp, e1, e2)
  | CmpC (GtOp, e1, e2) -> CmpC (LeOp, e1, e2)
  | CmpC (LeOp, e1, e2) -> CmpC (GtOp, e1, e2)
  | CmpC (GeOp, e1, e2) -> CmpC (LtOp, e1, e2)
  | _ -> UnC (NotOp, cond)

let both_empty cond1 cond2 =
  let get_list = function
  | CmpC (EqOp, e, ListE [])
  | CmpC (EqOp, ListE [], e)
  | CmpC (EqOp, LenE e, NumE 0L)
  | CmpC (EqOp, NumE 0L, LenE e)
  | CmpC (LtOp, LenE e, NumE 1L)
  | CmpC (LeOp, LenE e, NumE 0L)
  | CmpC (GeOp, NumE 0L, LenE e)
  | CmpC (GeOp, NumE 1L, LenE e) -> Some e
  | _ -> None in
  match get_list cond1, get_list cond2 with
  | Some e1, Some e2 -> e1 = e2
  | _ -> false

let both_non_empty cond1 cond2 =
  let get_list = function
  | CmpC (NeOp, e, ListE [])
  | CmpC (NeOp, ListE [], e)
  | CmpC (NeOp, LenE e, NumE 0L)
  | CmpC (NeOp, NumE 0L, LenE e)
  | CmpC (LtOp, NumE 0L, LenE e)
  | CmpC (GtOp, LenE e, NumE 0L)
  | CmpC (LeOp, NumE 1L, LenE e)
  | CmpC (GeOp, LenE e, NumE 1L) -> Some e
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
  List.map
    (fun instr ->
      match instr.it with
      | IfI (_, il1, il2) | EitherI (il1, il2) ->
          10 + count_instrs il1 + count_instrs il2
      | OtherwiseI il -> 1 + count_instrs il
      | TrapI | ReturnI _ -> 0
      | _ -> 1)
    instrs
  |> list_sum

let rec unify_head acc l1 l2 =
  match (l1, l2) with
  | h1 :: t1, h2 :: t2 when Eq.instr h1 h2 -> unify_head (h1 :: acc) t1 t2
  | _ -> (List.rev acc, l1, l2)

let intersect_list xs ys = List.filter (fun x -> List.mem x ys) xs
let diff_list xs ys = Lib.List.filter_not (fun x -> List.mem x ys) xs

let dedup l =
  let rec aux acc = function
    | [] -> List.rev acc
    | x :: xs ->
      if List.mem x acc then
        aux acc xs
      else
        aux (x :: acc) xs
  in
  aux [] l

(** AL -> AL transpilers *)

(* Recursively append else block to every empty if *)
let rec insert_otherwise else_body instrs =
  let walk = insert_otherwise else_body in
  List.fold_left_map
    (fun visit_if inst ->
      match inst.it with
      | IfI (c, il, []) ->
          let _, il' = walk il in
          (true, ifI (c, il', else_body))
      | IfI (c, il1, il2) ->
          let visit_if1, il1' = walk il1 in
          let visit_if2, il2' = walk il2 in
          let visit_if = visit_if || visit_if1 || visit_if2 in
          (visit_if, ifI (c, il1', il2'))
      | OtherwiseI il ->
          let visit_if', il' = walk il in
          let visit_if = visit_if || visit_if' in
          (visit_if, otherwiseI il')
      | EitherI (il1, il2) ->
          let visit_if1, il1' = walk il1 in
          let visit_if2, il2' = walk il2 in
          let visit_if = visit_if || visit_if1 || visit_if2 in
          (visit_if, eitherI (il1', il2'))
      | _ -> (visit_if, inst))
    false instrs

(* Merge two consecutive blocks: *)
(* - If they share same prefix *)
(* - If the latter block of instrs is a single Otherwise *)
let merge instrs1 instrs2 =
  let head, tail1, tail2 = unify_head [] instrs1 instrs2 in
  head @ match tail2 with
  | [{ it = OtherwiseI else_body; _ }] ->
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
        match i.it with
        | IfI (c, il1, il2) -> ifI (c, unify_if il1, unify_if il2)
        | OtherwiseI il -> otherwiseI (unify_if il)
        | EitherI (il1, il2) -> eitherI (unify_if il1, unify_if il2)
        | _ -> i
      in
      match (new_i.it, il) with
      | IfI (c1, body1, []), { it = IfI (c2, body2, []); _ } :: rest
        when c1 = c2 ->
          (* Assumption: common should have no side effect (replace) *)
          let common, own_body1, own_body2 = unify_head [] body1 body2 in
          let body = unify_if (common @ own_body1 @ own_body2) in
          ifI (c1, body, []) :: rest
      | _ -> new_i :: il)
    instrs []

let rec infer_else instrs =
  List.fold_right
    (fun i il ->
      let new_i =
        match i.it with
        | IfI (c, il1, il2) -> ifI (c, infer_else il1, infer_else il2)
        | OtherwiseI il -> otherwiseI (infer_else il)
        | EitherI (il1, il2) -> eitherI (infer_else il1, infer_else il2)
        | _ -> i
      in
      match (new_i.it, il) with
      | IfI (c1, then_body1, else_body1), { it = IfI (c2, else_body2, then_body2); _ } :: rest
        when eq_cond c1 (neg c2) ->
          ifI (c1, then_body1 @ then_body2, else_body1 @ else_body2) :: rest
      | _ -> new_i :: il)
    instrs []

let if_not_defined =
  let transpile_cond = function
  | CmpC (EqOp, e, OptE None) -> UnC (NotOp, IsDefinedC e)
  | c -> c in
  Walk.walk_instr { Walk.default_config with post_cond = transpile_cond }

let lift f x = [f x]

let swap_if =
  let transpile_instr instr =
    match instr.it with
    | IfI (c, il, []) -> ifI (c, il, [])
    | IfI (c, [], il) -> ifI (neg c, il, [])
    | IfI (c, il1, il2)
    when count_instrs il1 > count_instrs il2 -> ifI (neg c, il2, il1)
    | _ -> instr in
  Walk.walk_instr { Walk.default_config with post_instr = lift transpile_instr }

let rec return_at_last = function
  | [] -> false
  | h :: t ->
    match h.it with
    | TrapI | ReturnI _ -> true
    | _ -> return_at_last t

let early_return = Walk.walk_instr {
  Walk.default_config with post_instr =
    fun instr ->
      match instr.it with
      | IfI (c, il1, il2) when return_at_last il1 -> ifI (c, il1, []) :: il2
      | _ -> [instr]
}

let unify_tail instrs1 instrs2 =
  let rev = List.rev in
  let rh, rt1, rt2 = unify_head [] (rev instrs1) (rev instrs2) in
  (rev rt1, rev rt2, rev rh)

let rec unify_if_tail instr =
  let new_ = List.concat_map unify_if_tail in
  match instr.it with
  | IfI (_, [], []) -> []
  | IfI (c, il1, il2) ->
      let then_il, else_il, finally_il = unify_tail (new_ il1) (new_ il2) in
      ifI (c, then_il, else_il) :: finally_il
  | OtherwiseI il -> [ otherwiseI (new_ il) ]
  | EitherI (il1, il2) -> [ eitherI (new_ il1, new_ il2) ]
  | _ -> [ instr ]

let rec remove_unnecessary_branch path_cond instr =
  let new_ = List.concat_map (remove_unnecessary_branch path_cond) in
  match instr.it with
  | IfI (c, il1, il2) ->
    if List.exists (eq_cond c) path_cond then
      il1
    else if List.exists (eq_cond (neg c)) path_cond then
      il2
    else
      let new_il1 = List.concat_map (remove_unnecessary_branch (c :: path_cond)) il1 in
      let new_il2 = List.concat_map (remove_unnecessary_branch ((neg c) :: path_cond)) il2 in
      [ ifI (c, new_il1, new_il2) ]
  | OtherwiseI il -> [ otherwiseI (new_ il) ]
  | EitherI (il1, il2) -> [ eitherI (new_ il1, new_ il2) ]
  | _ -> [ instr ]

let push_either =
  let push_either' i =
    match i.it with
    | EitherI (il1, il2) -> (
      match Lib.List.split_last il1 with
      | hds, { it = IfI (c, then_body, []); _ } ->
        eitherI (hds @ [ ifI (c, then_body, il2) ], il2)
      | _ -> i)
    | _ -> i in

  Walk.walk_instr { Walk.default_config with pre_instr = lift push_either' }

let rec merge_three_branches i =
  let new_ = List.map merge_three_branches in
  match i.it with
  | IfI (c1, il1, [ { it = IfI (c2, il2, il3); _ } ]) when Eq.instrs il1 il3 ->
    ifI (BinC (AndOp, neg c1, c2), new_ il2, new_ il1)
  | IfI (c, il1, il2) -> ifI (c, new_ il1, new_ il2)
  | EitherI (il1, il2) -> eitherI (new_ il1, new_ il2)
  | _ -> i

let rec remove_dead_assignment' il pair =
  List.fold_right
    (fun instr (acc, bounds) ->
      match instr.it with
      | IfI (c, il1, il2) ->
        let il1', bounds1 = remove_dead_assignment' il1 ([], bounds) in
        let il2', bounds2 = remove_dead_assignment' il2 ([], bounds) in
        ifI (c, il1', il2') :: acc, bounds1 @ bounds2 @ Free.free_cond c
      | EitherI (il1, il2) ->
        let il1', bounds1 = remove_dead_assignment' il1 ([], bounds) in
        let il2', bounds2 = remove_dead_assignment' il2 ([], bounds) in
        eitherI (il1', il2') :: acc, bounds1 @ bounds2
      | EnterI (e1, e2, il) ->
        let il', bounds = remove_dead_assignment' il ([], bounds) in
        enterI (e1, e2, il') :: acc, bounds @ Free.free_expr e1 @ Free.free_expr e2
      | LetI (e1, e2) ->
        let bindings = (Free.free_expr e1) in
        if intersect_list bindings bounds = [] then
          acc, bounds
        else
          (instr :: acc), (diff_list bounds bindings) @ Free.free_expr e2
      | _ ->
        instr :: acc, bounds @ Free.free_instr instr)
    il pair

let remove_dead_assignment il = remove_dead_assignment' il ([], []) |> fst

let remove_sub = Walk.walk_instr { Walk.default_config with pre_expr = function
  | SubE (n, _) -> VarE n
  | e -> e
}

let rec remove_nop acc il = match il with
| [] -> List.rev acc
| i :: il' ->
  let new_ = remove_nop [] in
  let i' =
    match i.it with
    | IfI (c, il1, il2) -> ifI (c, new_ il1, new_ il2)
    | EitherI (il1, il2) -> eitherI (new_ il1, new_ il2)
    | _ -> i in
  match acc with
  | { it = NopI; _ } :: acc' -> remove_nop (i' :: acc') il'
  | _ -> remove_nop (i' :: acc) il'

let rec enhance_readability instrs =
  let new_instrs = instrs
  |> remove_dead_assignment
  |> unify_if
  |> List.concat_map if_not_defined
  |> infer_else
  |> List.concat_map unify_if_tail
  |> List.concat_map (remove_unnecessary_branch [])
  |> List.concat_map swap_if
  |> List.concat_map early_return
  |> List.map merge_three_branches
  |> List.concat_map remove_sub
  |> remove_nop []
  in
  if Eq.instrs instrs new_instrs then instrs else enhance_readability new_instrs

(** Walker-based Translpiler **)
let rec mk_access ps base =
  match ps with
  | h :: t -> AccE (base, h) |> mk_access t
  | [] -> base

let is_store = function
  | VarE s ->
    s = "s" || String.starts_with ~prefix:"s'" s || String.starts_with ~prefix:"s_" s
  | _ -> false

let is_frame = function
  | VarE f ->
    f = "f" || String.starts_with ~prefix:"f'" f || String.starts_with ~prefix:"f_" f
  | _ -> false

let is_state = function
  | TupE [ s; f ] -> is_store s && is_frame f
  | VarE z ->
    z = "z" || String.starts_with ~prefix:"z'" z || String.starts_with ~prefix:"z_" z
  | _ -> false

let hide_state_args = Lib.List.filter_not (fun arg -> is_state arg || is_store arg)

let hide_state_expr = function
  | CallE (f, args) -> CallE (f, hide_state_args args)
  | TupE [ s; e ] when is_store s && not (is_frame e) -> e
  | e -> e

let hide_state instr =
  match instr.it with
  (* Return *)
  | ReturnI (Some e) when is_state e || is_store e -> []
  (* Perform *)
  | LetI (e, CallE (fname, el)) when is_state e || is_store e -> [ performI (fname, el) ]
  | PerformI (f, args) -> [ performI (f, hide_state_args args) ]
  (* Append *)
  | LetI (_, ExtE (s, ps, ListE [ e ], Back) ) when is_store s ->
    [ appendI (mk_access ps s, e) ]
  (* Append & Return *)
  | ReturnI (Some (TupE [ ExtE (s, ps, ListE [ e1 ], Back); e2 ])) when is_store s ->
    let addr = VarE "a" in
    [ letI (addr, e2); appendI (mk_access ps s, e1); returnI (Some addr) ]
  (* Replace store *)
  | LetI (_, UpdE (s, ps, e))
  | ReturnI (Some (TupE [ UpdE (s, ps, e); VarE "f" ]))
  | ReturnI (Some (UpdE (s, ps, e))) when is_store s ->
    let hs, t = Lib.List.split_last ps in
    [ replaceI (mk_access hs s, t, e) ]
  (* Replace frame *)
  | ReturnI (Some (TupE [ VarE "s"; UpdE (f, ps, e) ])) when is_frame f ->
    let hs, t = Lib.List.split_last ps in
    [ replaceI (mk_access hs f, t, e) ]
  | _ -> [ instr ]

let simplify_record_concat = function
  | CatE (e1, e2) ->
    let nonempty = function ListE [] | OptE None -> false | _ -> true in
    let remove_empty_field = function
      | StrE r -> StrE (Record.filter (fun _ v -> nonempty v) r)
      | e -> e in
    CatE (remove_empty_field e1, remove_empty_field e2)
  | e -> e

let flatten_if instr =
  match instr.it with
  | IfI (c1, [ { it = IfI (c2, il1, il2); _ }], []) ->
    ifI (BinC (AndOp, c1, c2), il1, il2)
  | _ -> instr

let state_remover algo =
  let walker =
    Walk.walk
      { Walk.default_config with
        pre_instr = hide_state;
        post_instr = lift flatten_if;
        pre_expr = hide_state_expr;
        post_expr = simplify_record_concat
      }
  in

  match walker algo with
  | FuncA (name, params, body) -> (match params with
    | TupE [ _; VarE "f" ] :: tail ->
        FuncA (name, tail, letI (VarE "f", GetCurFrameE) :: body |> remove_dead_assignment)
    | VarE ("s" | "z") :: tail ->
        FuncA (name, tail, body)
    | _ -> FuncA(name, params, body))
  | RuleA _ as a -> a

(* Applied for reduction rules: infer assert from if *)
let rec count_if instrs = match instrs with
  | [] -> 0
  | { it = IfI _; _ } :: tl -> 1 + count_if tl
  | _ :: tl -> count_if tl
let rec infer_assert instrs =
  if count_if instrs = 1 then
    let (hd, tl) = Lib.List.split_last instrs in
    match tl.it with
    | IfI (c, il1, []) -> hd @ assertI(c) :: (il1 |> infer_assert)
    | _ -> instrs
  else instrs

let rec enforce_return_r rinstrs =
  let rev = List.rev in
  match rinstrs with
  | [] -> []
  | tl :: hd ->
    match tl.it with
    | ReturnI _ | TrapI -> rinstrs
    | IfI (c, il1, il2) ->
      ( match enforce_return' il1, enforce_return' il2 with
      | [], [] -> enforce_return_r hd
      | new_il, [] -> rev new_il @ (assertI c :: hd)
      | [], new_il -> rev new_il @ (assertI (neg c) :: hd)
      | new_il1, new_il2 -> ifI (c, new_il1, new_il2) :: hd )
    | OtherwiseI il -> otherwiseI (enforce_return' il) :: hd
    | EitherI (il1, il2) ->
      ( match enforce_return' il1, enforce_return' il2 with
      | [], [] -> enforce_return_r hd
      | new_il, []
      | [], new_il -> rev new_il @ hd
      | new_il1, new_il2 -> eitherI (new_il1, new_il2) :: hd )
    | _ -> enforce_return_r hd
and enforce_return' instrs = instrs |> List.rev |> enforce_return_r |> List.rev

let contains_return il =
  let ret = ref false in
  let config = { Walk.default_config with
    pre_instr =
      (fun i ->
        (match i.it with ReturnI _ | TrapI -> ret := true | _ -> ());
        [ i ])
  } in
  List.map (Walk.walk_instr config) il |> ignore;
  !ret

(** If intrs contain a return statement, make sure that every path has return statement in the end **)
let enforce_return instrs =
  if contains_return instrs then enforce_return' instrs else instrs
