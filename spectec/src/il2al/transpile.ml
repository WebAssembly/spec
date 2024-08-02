open Al
open Ast
open Walk
open Al_util
open Util
open Util.Source
open Util.Record

module Atom = El.Atom


(* Helpers *)

let (@@) (g: instr -> instr list) (f: instr -> instr list) (i: instr): instr list =
  f i |> List.map g |> List.flatten
let composite (g: 'a -> 'a) (f: 'a -> 'a) (x: 'a): 'a = f x |> g
let lift f x = [f x]

let take n str =
  let len = min n (String.length str) in
  String.sub str 0 len ^ if len <= n then "" else "..."

let rec neg cond =
  let cond' =
    match cond.it with
    | UnE (NotOp, c) -> c.it
    | BinE (AndOp, c1, c2) -> BinE (OrOp, neg c1, neg c2)
    | BinE (OrOp, c1, c2) -> BinE (AndOp, neg c1, neg c2)
    | BinE (EqOp, e1, e2) -> BinE (NeOp, e1, e2)
    | BinE (NeOp, e1, e2) -> BinE (EqOp, e1, e2)
    | BinE (LtOp, e1, e2) -> BinE (GeOp, e1, e2)
    | BinE (GtOp, e1, e2) -> BinE (LeOp, e1, e2)
    | BinE (LeOp, e1, e2) -> BinE (GtOp, e1, e2)
    | BinE (GeOp, e1, e2) -> BinE (LtOp, e1, e2)
    | _ -> UnE (NotOp, cond)
  in
  { cond with it = cond' }

let both_empty cond1 cond2 =
  let get_list cond =
    match cond.it with
    | BinE (EqOp, e, { it = ListE []; _ })
    | BinE (EqOp, { it = ListE []; _ }, e) -> Some e
    | BinE (EqOp, { it = LenE e; _ }, { it = NumE z; _ })
    | BinE (EqOp, { it = NumE z; _ }, { it = LenE e; _ })
    | BinE (LeOp, { it = LenE e; _ }, { it = NumE z; _ })
    | BinE (GeOp, { it = NumE z; _ }, { it = LenE e; _ }) when z = Z.zero -> Some e
    | BinE (LtOp, { it = LenE e; _ }, { it = NumE z; _ })
    | BinE (GeOp, { it = NumE z; _ }, { it = LenE e; _ }) when z = Z.one -> Some e
    | _ -> None
  in
  match get_list cond1, get_list cond2 with
  | Some e1, Some e2 -> Eq.eq_expr e1 e2
  | _ -> false

let both_non_empty cond1 cond2 =
  let get_list cond =
    match cond.it with
    | BinE (NeOp, e, { it = ListE []; _ })
    | BinE (NeOp, { it = ListE []; _ }, e) -> Some e
    | BinE (NeOp, { it = LenE e; _ }, { it = NumE z; _ })
    | BinE (NeOp, { it = NumE z; _ }, { it = LenE e; _ })
    | BinE (LtOp, { it = NumE z; _ }, { it = LenE e; _ })
    | BinE (GtOp, { it = LenE e; _ }, { it = NumE z; _ }) when z = Z.zero -> Some e
    | BinE (LeOp, { it = NumE z; _ }, { it = LenE e; _ })
    | BinE (GeOp, { it = LenE e; _ }, { it = NumE z; _ }) when z = Z.one-> Some e
    | _ -> None
  in
  match get_list cond1, get_list cond2 with
  | Some e1, Some e2 -> Eq.eq_expr e1 e2
  | _ -> false

let eq_cond cond1 cond2 =
  Eq.eq_expr cond1 cond2
  || both_empty cond1 cond2
  || both_non_empty cond1 cond2


let rec count_instrs instrs =
  instrs
  |> List.map
    (fun instr ->
      match instr.it with
      | IfI (_, il1, il2) | EitherI (il1, il2) -> 10 + count_instrs il1 + count_instrs il2
      | OtherwiseI il -> 1 + count_instrs il
      | TrapI | ReturnI _ -> 0
      | _ -> 1)
  |> List.fold_left (+) 0

let rec unify acc l1 l2 =
  match (l1, l2) with
  | h1 :: t1, h2 :: t2 when Eq.eq_instr h1 h2 -> unify (h1 :: acc) t1 t2
  | _ -> (List.rev acc, l1, l2)
let unify_head = unify []
let unify_tail l1 l2 =
  let unified, l1', l2' = unify [] (List.rev l1) (List.rev l2) in
  List.rev unified, List.rev l1', List.rev l2'


(* AL -> AL transpilers *)

(* Recursively append else block to every empty if *)
let rec insert_otherwise else_body instrs =
  let walk = insert_otherwise else_body in
  List.fold_left_map
    (fun visit_if inst ->
      let at = inst.at in
      match inst.it with
      | IfI (c, il, []) ->
        let _, il' = walk il in
        (true, ifI (c, il', else_body) ~at:at)
      | IfI (c, il1, il2) ->
        let visit_if1, il1' = walk il1 in
        let visit_if2, il2' = walk il2 in
        let visit_if = visit_if || visit_if1 || visit_if2 in
        (visit_if, ifI (c, il1', il2') ~at:at)
      | OtherwiseI il ->
        let visit_if', il' = walk il in
        let visit_if = visit_if || visit_if' in
        (visit_if, otherwiseI il' ~at:at)
      | EitherI (il1, il2) ->
        let visit_if1, il1' = walk il1 in
        let visit_if2, il2' = walk il2 in
        let visit_if = visit_if || visit_if1 || visit_if2 in
        (visit_if, eitherI (il1', il2') ~at:at)
      | _ -> (visit_if, inst))
    false instrs

(* Merge two consecutive blocks: *)
(* - If they share same prefix *)
(* - If the latter block of instrs is a single Otherwise *)
let merge instrs1 instrs2 =
  let head, tail1, tail2 = unify_head instrs1 instrs2 in
  let unified_tail =
    match tail2 with
    | [{ it = OtherwiseI else_body; _ }] ->
      let visit_if, merged = insert_otherwise else_body tail1 in
      if not visit_if then
        print_endline
          ("Warning: No corresponding if for"
          ^ take 100 (Print.string_of_instrs instrs2));
      merged
    | _ -> tail1 @ tail2
  in
  head @ unified_tail

let merge_blocks blocks = List.fold_right merge blocks []

(* Enhance readability of AL *)

let rec unify_if instrs =
  List.fold_right
    (fun i il ->
      let new_i =
        let at = i.at in
        match i.it with
        | IfI (c, il1, il2) -> ifI (c, unify_if il1, unify_if il2) ~at:at
        | OtherwiseI il -> otherwiseI (unify_if il) ~at:at
        | EitherI (il1, il2) -> eitherI (unify_if il1, unify_if il2) ~at:at
        | _ -> i
      in
      match (new_i, il) with
      | { it = IfI (c1, body1, []); at = at1; _ }, { it = IfI (c2, body2, []); at = at2; _ } :: rest
        when Eq.eq_expr c1 c2 ->
        (* Assumption: common should have no side effect (replace) *)
        let common, own_body1, own_body2 = unify_head body1 body2 in
        let body = unify_if (common @ own_body1 @ own_body2) in
        let at = over_region [ at1; at2 ] in
        ifI (c1, body, []) ~at:at :: rest
      | _ -> new_i :: il)
    instrs []

let rec infer_else instrs =
  List.fold_right
    (fun i il ->
      let new_i =
        let at = i.at in
        match i.it with
        | IfI (c, il1, il2) -> ifI (c, infer_else il1, infer_else il2) ~at:at
        | OtherwiseI il -> otherwiseI (infer_else il) ~at:at
        | EitherI (il1, il2) -> eitherI (infer_else il1, infer_else il2) ~at:at
        | _ -> i
      in
      match (new_i, il) with
      | { it = IfI (c1, then_body1, else_body1); at = at1; _ }, { it = IfI (c2, else_body2, then_body2); at = at2; _ } :: rest
        when eq_cond c1 (neg c2) ->
        let at = over_region [ at1; at2 ] in
        ifI (c1, then_body1 @ then_body2, else_body1 @ else_body2) ~at:at :: rest
      | _ -> new_i :: il)
    instrs []

let if_not_defined cond =
  let at = cond.at in
  match cond.it with
  | BinE (EqOp, e, { it = OptE None; _ }) -> unE (NotOp, isDefinedE e ~at:e.at ~note:boolT) ~at:at ~note:boolT
  | _ -> cond

let swap_if instr =
  let at = instr.at in
  match instr.it with
  | IfI (c, il, []) -> ifI (c, il, []) ~at:at
  | IfI (c, [], il) -> ifI (neg c, il, []) ~at:at
  | IfI (c, il1, il2) when count_instrs il1 > count_instrs il2 -> ifI (neg c, il2, il1) ~at:at
  | _ -> instr

let rec return_at_last = function
  | [] -> false
  | h :: t ->
    match h.it with
    | TrapI | ReturnI _ -> true
    | _ -> return_at_last t

let early_return instr =
  let at = instr.at in
  match instr.it with
  | IfI (c, il1, il2) when return_at_last il1 -> ifI (c, il1, []) ~at:at :: il2
  | _ -> [ instr ]

let unify_if_tail instr =
  let at = instr.at in
  match instr.it with
  | IfI (_, [], []) -> []
  | IfI (c, il1, il2) ->
    let t, il1', il2' = unify_tail il1 il2 in
    ifI (c, il1', il2') ~at:at :: t
  | _ -> [ instr ]

let remove_unnecessary_branch =
  let rec remove_unnecessary_branch' path_cond instr =
    let new_ = List.concat_map (remove_unnecessary_branch' path_cond) in
    let instr_at = instr.at in
    match instr.it with
    | IfI (c, il1, il2) ->
      if List.exists (eq_cond c) path_cond then il1
      else if List.exists (eq_cond (neg c)) path_cond then il2
      else
        let new_il1 = List.concat_map (remove_unnecessary_branch' (c :: path_cond)) il1 in
        let new_il2 = List.concat_map (remove_unnecessary_branch' (neg c :: path_cond)) il2 in
        [ ifI (c, new_il1, new_il2) ~at:instr_at ]
    | OtherwiseI il -> [ otherwiseI (new_ il) ~at:instr_at ]
    | EitherI (il1, il2) -> [ eitherI (new_ il1, new_ il2) ~at:instr_at ]
    | _ -> [ instr ]
  in
  remove_unnecessary_branch' []

let push_either =
  let push_either' i =
    let either_at = i.at in
    match i.it with
    | EitherI (il1, il2) ->
      (match Lib.List.split_last il1 with
      | hds, { it = IfI (c, then_body, []); at = if_at; _ } ->
        eitherI (hds @ [ ifI (c, then_body, il2) ~at:if_at ], il2) ~at:either_at
      | _ -> i)
    | _ -> i in

  Walk.walk_instr { Walk.default_config with pre_instr = lift push_either' }

let merge_three_branches i =
  let at1 = i.at in
  match i.it with
  | IfI (e1, il1, [ { it = IfI (e2, il2, il3); at = at2; _ } ]) when Eq.eq_instrs il1 il3 ->
    let at = over_region [ at1; at2 ] in
    ifI (binE (AndOp, neg e1, e2) ~note:boolT, il2, il1) ~at:at
  | _ -> i

let remove_dead_assignment il =
  let open Free in
  let (@) = IdSet.union in
  let rec remove_dead_assignment' il pair =
    List.fold_right
      (fun instr (acc, bounds) ->
        let at = instr.at in
        match instr.it with
        | IfI (e, il1, il2) ->
          let il1', bounds1 = remove_dead_assignment' il1 ([], bounds) in
          let il2', bounds2 = remove_dead_assignment' il2 ([], bounds) in
          ifI (e, il1', il2') ~at:at :: acc, bounds1 @ bounds2 @ free_expr e
        | EitherI (il1, il2) ->
          let il1', bounds1 = remove_dead_assignment' il1 ([], bounds) in
          let il2', bounds2 = remove_dead_assignment' il2 ([], bounds) in
          eitherI (il1', il2') ~at:at :: acc, bounds1 @ bounds2
        | EnterI (e1, e2, il) ->
          let il', bounds = remove_dead_assignment' il ([], bounds) in
          enterI (e1, e2, il') ~at:at :: acc, bounds @ free_expr e1 @ free_expr e2
        (* n in, Let val'* ++ val^n be val*. should be bound, not binding *)
        | LetI ({ it = CatE (e11, e12) ; _ }, e2) ->
          let bindings = free_expr e11 @ free_expr e12 in
          let get_bounds_iters e =
            match e.it with
            | IterE (_, _, ListN (e_iter, _)) -> free_expr e_iter
            | _ -> IdSet.empty
          in
          let bounds_iters = (get_bounds_iters e11) @ (get_bounds_iters e12) in
          let bindings = IdSet.diff bindings bounds_iters in
          if IdSet.(is_empty (inter bindings bounds)) then
            acc, bounds
          else
            (instr :: acc), (IdSet.diff bounds bindings) @ free_expr e2
        | LetI (e1, e2) ->
          let bindings = free_expr e1 in
          if IdSet.(is_empty (inter bindings bounds)) then
            acc, bounds
          else
            (instr :: acc), (IdSet.diff bounds bindings) @ free_expr e2
        | AssertI _ when acc = [] -> acc, bounds
        | _ ->
          instr :: acc, bounds @ free_instr instr)
      il pair
  in
  remove_dead_assignment' il ([], IdSet.empty) |> fst

let remove_sub e =
  let e' =
    match e.it with
    | SubE (n, _) -> VarE n
    | e -> e
  in
  { e with it = e' }

let rec remove_nop acc il = match il with
| [] -> List.rev acc
| i :: il' ->
  let new_ = remove_nop [] in
  let i' =
    let at = i.at in
    match i.it with
    | IfI (c, il1, il2) -> ifI (c, new_ il1, new_ il2) ~at:at
    | EitherI (il1, il2) -> eitherI (new_ il1, new_ il2) ~at:at
    | _ -> i in
  match acc with
  | { it = NopI; _ } :: acc' -> remove_nop (i' :: acc') il'
  | _ -> remove_nop (i' :: acc) il'

let simplify_record_concat expr =
  let expr' =
    match expr.it with
    | CatE (e1, e2) ->
      let nonempty e = (match e.it with ListE [] | OptE None -> false | _ -> true) in
      let remove_empty_field e =
        let e' =
          (match e.it with
          | StrE r -> StrE (Record.filter (fun _ v -> nonempty v) r)
          | e -> e)
        in
        { e with it = e' }
      in
      CatE (remove_empty_field e1, remove_empty_field e2)
    | e -> e
  in
  { expr with it = expr' }

type count = One of string | Many
module Counter = Map.Make (String)
let infer_case_assert instrs =
  let case_count = ref Counter.empty in

  let rec handle_cond c mt_then mt_else =
    match c.it with
    | IsCaseOfE (e, atom) ->
      let k = Print.string_of_expr e in
      let v = One (Print.string_of_atom atom) in
      let v_opt = Counter.find_opt k !case_count in
      let v' = if mt_else && match v_opt with None -> true | Some v' -> v = v' then v else Many in
      case_count := Counter.add k v' !case_count
    | HasTypeE ({ it = VarE id; _ }, _) ->
      case_count := Counter.add id Many !case_count
    | UnE (NotOp, c') -> handle_cond c' mt_else mt_then
    | BinE ((AndOp | OrOp), c1, c2) -> handle_cond c1 mt_then mt_else; handle_cond c2 mt_then mt_else
    | _ -> ()
  in
  let handle_if i =
    match i.it with
    | IfI (c, il1, il2) -> handle_cond c (il1 = []) (il2 = [])
    | _ -> ()
  in
  let count_cases = walk_instrs { default_config with pre_instr = (fun i -> handle_if i; [ i ]) } in
  count_cases instrs |> ignore;

  let is_single_case_check c =
    match c.it with
    | IsCaseOfE (e, _) -> (
      match Counter.find_opt (Print.string_of_expr e) !case_count with
      | None | Some Many -> false
      | _ -> true )
    | _ -> false
  in
  let rewrite_if i =
    match i.it with
    | IfI (c, il1, []) when is_single_case_check c -> assertI c ~at:i.at :: il1
    | _ -> [ i ] in
  let rec rewrite_il il =
    let il' = List.map (fun i ->
      match i.it with
      | IfI (c, il1, il2) -> ifI (c, rewrite_il il1, rewrite_il il2) ~at:i.at
      | OtherwiseI il -> otherwiseI (rewrite_il il) ~at:i.at
      | EitherI (il1, il2) -> eitherI (rewrite_il il1, rewrite_il il2) ~at:i.at
      | _ -> i
    ) il in
    match Util.Lib.List.split_last_opt il' with
    | None -> []
    | Some (hd, tl) -> hd @ rewrite_if tl
  in
  rewrite_il instrs

let rec enhance_readability instrs =
  let walk_config =
    {
      Walk.default_config with
      pre_expr = simplify_record_concat |> composite if_not_defined;
      post_instr =
        unify_if_tail @@ (lift swap_if) @@ early_return @@ (lift merge_three_branches);
    } in

  let instrs' =
    instrs
    |> remove_dead_assignment
    |> unify_if
    |> infer_else
    |> List.concat_map remove_unnecessary_branch
    |> remove_nop []
    |> infer_case_assert
    |> Walk.walk_instrs walk_config
  in

  if Eq.eq_instrs instrs instrs' then instrs else enhance_readability instrs'

let flatten_if instrs =
  let flatten_if' instr =
    let at1 = instr.at in
    match instr.it with
    | IfI (e1, [ { it = IfI (e2, il1, il2); at = at2; _ }], []) ->
      let at = over_region [ at1; at2 ] in
      ifI (binE (AndOp, e1, e2) ~at:at ~note:boolT, il1, il2) ~at:at1
    | _ -> instr
  in
  let walk_config =
    {
      Walk.default_config with
      post_instr = lift flatten_if';
    } in

  Walk.walk_instrs walk_config instrs

let rec mk_access ps base =
  match ps with
  (* TODO: type *)
  | h :: t -> accE (base, h) ~note:Al.Al_util.no_note |> mk_access t
  | [] -> base

let is_store expr = match expr.it with
  | VarE s ->
    s = "s" || String.starts_with ~prefix:"s'" s || String.starts_with ~prefix:"s_" s
  | _ -> false
let is_frame expr = match expr.it with
  | VarE f ->
    f = "f" || String.starts_with ~prefix:"f'" f || String.starts_with ~prefix:"f_" f
  | _ -> false
let is_state expr = match expr.it with
  | TupE [ s; f ] -> is_store s && is_frame f
  | VarE z ->
    z = "z" || String.starts_with ~prefix:"z'" z || String.starts_with ~prefix:"z_" z
  | _ -> false

let is_store_arg arg = match arg.it with
  | ExpA e -> is_store e
  | TypA _ -> false
let is_frame_arg arg = match arg.it with
  | ExpA e -> is_frame e
  | TypA _ -> false
let is_state_arg arg = match arg.it with
  | ExpA e -> is_state e
  | TypA _ -> false

let hide_state_args args =
  args
  |> Lib.List.filter_not is_state_arg
  |> Lib.List.filter_not is_store_arg

let hide_state_expr expr =
  let expr' =
    match expr.it with
    | CallE (f, args) -> CallE (f, hide_state_args args)
    | TupE [ s; e ] when is_store s -> e.it
    | e -> e
  in
  { expr with it = expr' }

let hide_state instr =
  let at = instr.at in
  match instr.it with
  (* Return *)
  | ReturnI (Some e) when is_state e || is_store e -> [ returnI None ~at:at ]
  (* Perform *)
  | LetI (e, { it = CallE (fname, args); _ }) when is_state e || is_store e -> [ performI (fname, hide_state_args args) ~at:at ]
  | PerformI (f, args) -> [ performI (f, hide_state_args args) ~at:at ]
  (* Append *)
  | LetI (_, { it = ExtE (s, ps, { it = ListE [ e ]; _ }, Back); note; _ } ) when is_store s ->
    let access = { (mk_access ps s) with note } in
    [ appendI (access , e) ~at:at ]
  (* Append & Return *)
  | ReturnI (Some ({ it = TupE [ { it = ExtE (s, ps, { it = ListE [ e1 ]; _ }, Back); note; _ }; e2 ]; _  })) when is_store s ->
    let addr = varE "a" ~note:e2.note in
    let access = {(mk_access ps s) with note } in
    [ letI (addr, e2) ~at:at;
      appendI (access, e1) ~at:at;
      returnI (Some addr) ~at:at ]
  (* Replace store *)
  | LetI (_, { it = UpdE (s, ps, e); note; _ })
  | ReturnI (Some ({ it = TupE [ { it = UpdE (s, ps, e); note; _ }; { it = VarE "f"; _ } ]; _ }))
  | ReturnI (Some ({ it = UpdE (s, ps, e); note; _ })) when is_store s ->
    let hs, t = Lib.List.split_last ps in
    let access = { (mk_access hs s) with note } in
    [ replaceI (access, t, e) ~at:at ]
  (* Replace frame *)
  | ReturnI (Some ({ it = TupE [ { it = VarE "s"; _ }; { it = UpdE (f, ps, e); note; _ } ]; _ })) when is_frame f ->
    let hs, t = Lib.List.split_last ps in
    let access = { (mk_access hs f) with note } in
    [ replaceI (access, t, e) ~at:at ]
  | _ -> [ instr ]

let remove_state algo =
  let walk_config =
      {
        Walk.default_config with
        pre_instr = hide_state;
        pre_expr = hide_state_expr;
      }
  in

  let algo' = Walk.walk walk_config algo in
  { algo' with it =
    match algo'.it with
    | FuncA (name, args, body) ->
      let args' =
        args
        |> Lib.List.filter_not is_state_arg
        |> Lib.List.filter_not is_store_arg
        |> Lib.List.filter_not is_frame_arg
      in
      let body' = body
        |> remove_dead_assignment
      in
      FuncA (name, args', body')
    | rule -> rule
  }

let insert_state_binding algo =
  let state_count = ref 0 in

  let count_state e =
    (match e.it with
    | VarE "z" -> state_count := !state_count + 1
    | _ -> ());
    e
  in

  let walk_config =
    {
      Walk.default_config with
      pre_expr = count_state;
    }
  in

  let algo' = Walk.walk walk_config algo in
  { algo' with it =
    match algo'.it with
    | FuncA (name, params, body) when !state_count > 0 ->
      let body = (letI (varE "z" ~note:stateT, getCurStateE () ~note:stateT)) :: body in
      FuncA (name, params, body)
    | RuleA (name, anchor, params, body) when !state_count > 0 ->
      let body = (letI (varE "z" ~note:stateT, getCurStateE () ~note:stateT)) :: body in
      RuleA (name, anchor, params, body)
    | a -> a
  }

let insert_frame_binding instrs =
  let open Free in
  let (@) = IdSet.union in
  let frame_count = ref 0 in
  let bindings = ref IdSet.empty in
  let found = ref false in

  let count_frame e =
    (match e.it with
    | VarE "f" -> frame_count := !frame_count + 1
    | _ -> ());
    e
  in

  let update_bindings i =
    frame_count := 0;
    match i.it with
    | LetI ({ it = CatE (e11, e12) ; _ }, _) ->
      let bindings' = free_expr e11 @ free_expr e12 in
      let get_bounds_iters e =
        match e.it with
        | IterE (_, _, ListN (e_iter, _)) -> free_expr e_iter
        | _ -> IdSet.empty
      in
      let bounds_iters = (get_bounds_iters e11) @ (get_bounds_iters e12) in
      bindings := IdSet.diff bindings' bounds_iters |> IdSet.union !bindings;
      [ i ]
    | LetI (e1, _) ->
      bindings := IdSet.union !bindings (free_expr e1);
      found := (not (IdSet.mem "f" !bindings)) && !frame_count > 0;
      [ i ]
    | _ -> [ i ]
  in

  let found_frame _ = !found in
  let check_free_frame i =
    found := (not (IdSet.mem "f" !bindings)) && !frame_count > 0;
    [ i ]
  in

  let walk_config =
    {
      Walk.default_config with
      pre_expr = count_frame;
      pre_instr = update_bindings;
      stop_cond_instr = found_frame;
      post_instr = check_free_frame;
    }
  in

  match Walk.walk_instrs walk_config instrs with
  | il when !found -> (letI (varE "f" ~note:frameT, getCurFrameE () ~note:frameT)) :: il
  | _ -> instrs

(* Applied for reduction rules: infer assert from if *)
let count_if instrs =
  let f instr =
    match instr.it with
    | IfI _ -> true
    | _ -> false in
  List.filter f instrs |> List.length
let rec infer_assert instrs =
  if count_if instrs = 1 then
    let hd, tl = Lib.List.split_last instrs in
    match tl.it with
    | IfI (c, il1, []) -> hd @ assertI c :: infer_assert il1
    | _ -> instrs
  else instrs

let rec enforce_return' il =
  let rev = List.rev in
  match il with
  | [] -> []
  | hd :: tl ->
    let at = hd.at in
    match hd.it with
    | ReturnI _ | TrapI -> il
    | IfI (c, il1, il2) ->
      (match enforce_return il1, enforce_return il2 with
      | [], [] -> enforce_return' tl
      | new_il, [] -> rev new_il @ (assertI c ~at:at :: tl)
      | [], new_il -> rev new_il @ (assertI (neg c) ~at:at :: tl)
      | new_il1, new_il2 -> ifI (c, new_il1, new_il2) ~at:at :: tl
      )
    | OtherwiseI il -> otherwiseI (enforce_return il) ~at:at :: tl
    | EitherI (il1, il2) ->
      (match enforce_return il1, enforce_return il2 with
      | [], [] -> enforce_return' tl
      | new_il, []
      | [], new_il -> rev new_il @ tl
      | new_il1, new_il2 -> eitherI (new_il1, new_il2) ~at:at :: tl
      )
    | _ -> enforce_return' tl

and enforce_return il = il |> List.rev |> enforce_return' |> List.rev

let contains_return il =
  let ret = ref false in
  let pre_instr = fun i -> (match i.it with ReturnI _ | TrapI -> ret := true | _ -> ()); [ i ] in
  let config = { Walk.default_config with pre_instr } in
  List.map (Walk.walk_instr config) il |> ignore;
  !ret

(* If intrs contain a return statement, make sure that every path has return statement in the end *)
let ensure_return il =
  if contains_return il then enforce_return il else il

(* ExitI to PopI *)
let remove_exit algo =
  let exit_to_pop instr =
    match instr.it with
    | ExitI ({ it = Atom.Atom "FRAME_"; _ }) ->
      popI (getCurFrameE () ~note:frameT) ~at:instr.at
    | ExitI ({ it = Atom.Atom "LABEL_"; _ }) ->
      popI (getCurLabelE () ~note:labelT) ~at:instr.at
    | _ -> instr
  in

  let walk_config =
    {
      Walk.default_config with
      pre_instr = lift exit_to_pop;
    }
  in

  Walk.walk walk_config algo

(* EnterI on FrameE to PushI *)
let remove_enter algo =
  let enter_frame_to_push_then_pop instr =
    match instr.it with
    | EnterI (
      ({ it = FrameE (Some e_arity, _); _ } as e_frame),
      { it = ListE ([ { it = CaseE ({ it = Atom.Atom "FRAME_"; _ }, []); _ } ]); _ },
      il) ->
        begin match e_arity.it with
        | NumE z when Z.to_int z = 0 ->
          pushI e_frame ~at:instr.at :: il @ [ popI e_frame ~at:instr.at ]
        | _ ->
          let ty_vals = listT valT in
          let e_tmp = iterE (varE ("val") ~note:valT, [ "val" ], List) ~note:ty_vals in
          pushI e_frame ~at:instr.at :: il @ [
            popallI e_tmp ~at:instr.at;
            popI e_frame ~at:instr.at;
            pushI e_tmp ~at:instr.at;
          ]
        end
    | EnterI (
      ({ it = FrameE (None, _); _ } as e_frame),
      { it = ListE ([ { it = CaseE ({ it = Atom.Atom "FRAME_"; _ }, []); _ } ]); _ },
      il) ->
        pushI e_frame ~at:instr.at :: il @ [ popI e_frame ~at:instr.at ]
    | _ -> [ instr ]
  in

  let enter_frame_to_push instr =
    match instr.it with
    | EnterI (e_frame, { it = ListE ([ { it = CaseE ({ it = Atom.Atom "FRAME_"; _ }, []); _ } ]); _ }, il) ->
        pushI e_frame ~at:instr.at :: il
    | _ -> [ instr ]
  in

  let enter_label_to_push instr =
    match instr.it with
    | EnterI (
      e_label,
      { it = CatE (e_instrs, { it = ListE ([ { it = CaseE ({ it = Atom.Atom "LABEL_"; _ }, []); _ } ]); _ }); note; _ },
      [ { it = PushI e_vals; _ } ]) ->
        enterI (e_label, catE (e_vals, e_instrs) ~note:note, []) ~at:instr.at
    | EnterI (
      e_label,
      { it = CatE (e_instrs, { it = ListE ([ { it = CaseE ({ it = Atom.Atom "LABEL_"; _ }, []); _ } ]); _ }); _ },
      []) ->
        enterI (e_label, e_instrs, []) ~at:instr.at
    | _ -> instr
  in

  let remove_enter' = Source.map (function
    | FuncA (name, params, body) ->
        let walk_config =
          {
            Walk.default_config with
            pre_instr = enter_frame_to_push_then_pop @@ (lift enter_label_to_push);
          }
        in
        let body = Walk.walk_instrs walk_config body in
        FuncA (name, params, body)
    | RuleA (name, anchor, params, body) ->
        let walk_config =
          {
            Walk.default_config with
            pre_instr = enter_frame_to_push @@ (lift enter_label_to_push);
          }
        in
        let body = Walk.walk_instrs walk_config body in
        RuleA (name, anchor, params, body)
  ) in

  let algo' = remove_enter' algo in
  if Eq.eq_algos algo algo' then algo else remove_enter' algo'
