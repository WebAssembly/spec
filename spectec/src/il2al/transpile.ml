open Al
open Ast
open Walk
open Al_util
open Util
open Util.Source
open Util.Record

(** helper *)
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
    | BinE (EqOp, { it = ListE []; _ }, e)
    | BinE (EqOp, { it = LenE e; _ }, { it = NumE 0L; _ })
    | BinE (EqOp, { it = NumE 0L; _ }, { it = LenE e; _ })
    | BinE (LtOp, { it = LenE e; _ }, { it = NumE 1L; _ })
    | BinE (LeOp, { it = LenE e; _ }, { it = NumE 0L; _ })
    | BinE (GeOp, { it = NumE 0L; _ }, { it = LenE e; _ })
    | BinE (GeOp, { it = NumE 1L; _ }, { it = LenE e; _ }) -> Some e
    | _ -> None
  in
  match get_list cond1, get_list cond2 with
  | Some e1, Some e2 -> Eq.eq_expr e1 e2
  | _ -> false

let both_non_empty cond1 cond2 =
  let get_list cond =
    match cond.it with
    | BinE (NeOp, e, { it = ListE []; _ })
    | BinE (NeOp, { it = ListE []; _ }, e)
    | BinE (NeOp, { it = LenE e; _ }, { it = NumE 0L; _ })
    | BinE (NeOp, { it = NumE 0L; _ }, { it = LenE e; _ })
    | BinE (LtOp, { it = NumE 0L; _ }, { it = LenE e; _ })
    | BinE (GtOp, { it = LenE e; _ }, { it = NumE 0L; _ })
    | BinE (LeOp, { it = NumE 1L; _ }, { it = LenE e; _ })
    | BinE (GeOp, { it = LenE e; _ }, { it = NumE 1L; _ }) -> Some e
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

(** Enhance readability of AL **)

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
  | BinE (EqOp, e, { it = OptE None; _ }) -> unE (NotOp, isDefinedE e ~at:e.at) ~at:at
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
    ifI (binE (AndOp, neg e1, e2), il2, il1) ~at:at
  | _ -> i

let remove_dead_assignment il =
  let rec remove_dead_assignment' il pair =
    List.fold_right
      (fun instr (acc, bounds) ->
        let at = instr.at in
        match instr.it with
        | IfI (e, il1, il2) ->
          let il1', bounds1 = remove_dead_assignment' il1 ([], bounds) in
          let il2', bounds2 = remove_dead_assignment' il2 ([], bounds) in
          ifI (e, il1', il2') ~at:at :: acc, bounds1 @ bounds2 @ Free.free_expr e
        | EitherI (il1, il2) ->
          let il1', bounds1 = remove_dead_assignment' il1 ([], bounds) in
          let il2', bounds2 = remove_dead_assignment' il2 ([], bounds) in
          eitherI (il1', il2') ~at:at :: acc, bounds1 @ bounds2
        | EnterI (e1, e2, il) ->
          let il', bounds = remove_dead_assignment' il ([], bounds) in
          enterI (e1, e2, il') ~at:at :: acc, bounds @ Free.free_expr e1 @ Free.free_expr e2
        | LetI (e1, e2) ->
          let bindings = (Free.free_expr e1) in
          if intersect_list bindings bounds = [] then
            acc, bounds
          else
            (instr :: acc), (diff_list bounds bindings) @ Free.free_expr e2
        | AssertI _ when acc = [] -> acc, bounds
        | _ ->
          instr :: acc, bounds @ Free.free_instr instr)
      il pair
  in
  remove_dead_assignment' il ([], []) |> fst

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

let flatten_if instr =
  let at1 = instr.at in
  match instr.it with
  | IfI (e1, [ { it = IfI (e2, il1, il2); at = at2; _ }], []) ->
    let at = over_region [ at1; at2 ] in
    ifI (binE (AndOp, e1, e2) ~at:at, il1, il2) ~at:at1
  | _ -> instr

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
    | IsCaseOfE (e, kwd) ->
      let k = Print.string_of_expr e in
      let v = One (fst kwd) in
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
    | _, None -> []
    | hd, Some tl -> hd @ rewrite_if tl
  in
  rewrite_il instrs

let rec enhance_readability instrs =
  let walk_config =
    {
      Walk.default_config with
      pre_expr = composite remove_sub simplify_record_concat |> composite if_not_defined;
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

let rec mk_access ps base =
  match ps with
  | h :: t -> accE (base, h) |> mk_access t
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

let hide_state_args = Lib.List.filter_not (fun arg -> is_state arg || is_store arg)

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
  | LetI (_, { it = ExtE (s, ps, { it = ListE [ e ]; _ }, Back); _ } ) when is_store s ->
    [ appendI (mk_access ps s, e) ~at:at ]
  (* Append & Return *)
  | ReturnI (Some ({ it = TupE [ { it = ExtE (s, ps, { it = ListE [ e1 ]; _ }, Back); _ }; e2 ]; _  })) when is_store s ->
    let addr = varE "a" in
    [ letI (addr, e2) ~at:at;
      appendI (mk_access ps s, e1) ~at:at;
      returnI (Some addr) ~at:at ]
  (* Replace store *)
  | LetI (_, { it = UpdE (s, ps, e); _ })
  | ReturnI (Some ({ it = TupE [ { it = UpdE (s, ps, e); _ }; { it = VarE "f"; _ } ]; _ }))
  | ReturnI (Some ({ it = UpdE (s, ps, e); _ })) when is_store s ->
    let hs, t = Lib.List.split_last ps in
    [ replaceI (mk_access hs s, t, e) ~at:at ]
  (* Replace frame *)
  | ReturnI (Some ({ it = TupE [ { it = VarE "s"; _ }; { it = UpdE (f, ps, e); _ } ]; _ })) when is_frame f ->
    let hs, t = Lib.List.split_last ps in
    [ replaceI (mk_access hs f, t, e) ~at:at ]
  | _ -> [ instr ]

let state_remover algo =
  let walk_config =
      {
        Walk.default_config with
        pre_instr = hide_state;
        (* TODO: move `flaten_if` to enhance_readability *)
        post_instr = lift flatten_if;
        pre_expr = hide_state_expr;
      }
  in

  match Walk.walk walk_config algo with
  | FuncA (name, params, body) -> (match params with
    | { it = TupE [ _; { it = VarE "f"; _ } ]; _ } :: tail ->
        FuncA (name, tail, letI (varE "f", getCurFrameE ()) :: body |> remove_dead_assignment)
    | { it = VarE ("s" | "z"); _ } :: tail ->
        FuncA (name, tail, body)
    | _ -> FuncA(name, params, body))
  | RuleA _ as a -> a

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

let rec enforce_return_r rinstrs =
  let rev = List.rev in
  match rinstrs with
  | [] -> []
  | tl :: hd ->
    let at = tl.at in
    match tl.it with
    | ReturnI _ | TrapI -> rinstrs
    | IfI (c, il1, il2) ->
      ( match enforce_return' il1, enforce_return' il2 with
      | [], [] -> enforce_return_r hd
      | new_il, [] -> rev new_il @ (assertI c ~at:at :: hd)
      | [], new_il -> rev new_il @ (assertI (neg c) ~at:at :: hd)
      | new_il1, new_il2 -> ifI (c, new_il1, new_il2) ~at:at :: hd )
    | OtherwiseI il -> otherwiseI (enforce_return' il) ~at:at :: hd
    | EitherI (il1, il2) ->
      ( match enforce_return' il1, enforce_return' il2 with
      | [], [] -> enforce_return_r hd
      | new_il, []
      | [], new_il -> rev new_il @ hd
      | new_il1, new_il2 -> eitherI (new_il1, new_il2) ~at:at :: hd )
    | _ -> enforce_return_r hd
and enforce_return' instrs = instrs |> List.rev |> enforce_return_r |> List.rev

let contains_return il =
  let ret = ref false in
  let config =
    {
      Walk.default_config with
      pre_instr =
        (fun i -> (match i.it with ReturnI _ | TrapI -> ret := true | _ -> ()); [ i ])
    } in
  List.map (Walk.walk_instr config) il |> ignore;
  !ret

(** If intrs contain a return statement, make sure that every path has return statement in the end **)
let enforce_return instrs =
  if contains_return instrs then enforce_return' instrs else instrs
