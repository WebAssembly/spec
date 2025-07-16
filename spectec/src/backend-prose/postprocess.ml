open Al.Ast
open Al.Free
open Prose
open Eq
open Il2al.Il2al_util

let unify_either def =
  let f stmt =
    match stmt with
    | EitherS sss ->
      let unified, bodies = List.fold_left (fun (commons, stmtss) s ->
        let pairs = List.map (List.partition (eq_stmt s)) stmtss in
        let fsts = List.map fst pairs in
        let snds = List.map snd pairs in
        if List.for_all (fun l -> List.length l = 1) fsts then
          s :: commons, snds
        else
          commons, stmtss
      ) ([], sss) (List.hd sss) in
      let unified = List.rev unified in
      unified @ [ EitherS bodies ]
    | _ -> [stmt]
  in
  let rec walk stmts = List.concat_map walk' stmts
  and walk' stmt =
    f stmt
    |> List.map (function
      | IfS (e, sl) -> IfS (e, walk sl)
      | ForallS (vars, sl) -> ForallS (vars, walk sl)
      | EitherS sll -> EitherS (List.map walk sll)
      | s -> s
    )
  in
  match def with
  | RuleD (anchor, s, sl) -> RuleD (anchor, s, walk sl)
  | AlgoD _ -> def

let rec free_stmt stmt =
  let (++) = IdSet.union in
  match stmt with
  | LetS (e1, e2) -> free_expr e1 ++ free_expr e2
  | CondS e -> free_expr e
  | CmpS (e1, _, e2) -> free_expr e1 ++ free_expr e2
  | IsValidS (eo, e, es, _) ->
      (match eo with Some e0 -> free_expr e0 | None -> IdSet.empty)
      ++ free_expr e ++ free_list free_expr es
  | MatchesS (e1, e2) -> free_expr e1 ++ free_expr e2
  | IsConstS (eo, e) ->
      (match eo with Some e0 -> free_expr e0 | None -> IdSet.empty)
      ++ free_expr e
  | IsDefinedS e -> free_expr e
  | IsDefaultableS (e, _) -> free_expr e
  | IfS (e, sl) -> free_expr e ++ free_list free_stmt sl
  | ForallS (pairs, sl) ->
      let pair_exprs = List.flatten (List.map (fun (e1, e2) -> [e1; e2]) pairs) in
      free_list free_expr pair_exprs ++ free_list free_stmt sl
  | EitherS sll -> free_list (free_list free_stmt) sll
  | BinS (s1, _, s2) -> free_stmt s1 ++ free_stmt s2
  | ContextS (e1, e2) -> free_expr e1 ++ free_expr e2
  | RelS (_, es) -> free_list free_expr es
  | YetS _ -> IdSet.empty

let rec replace_name_stmt x1 x2 stmt =
  let re = replace_name_expr x1 x2 in
  let rs = replace_name_stmt x1 x2 in
  match stmt with
  | LetS (e1, e2) -> LetS (re e1, re e2)
  | CondS e -> CondS (re e)
  | CmpS (e1, op, e2) -> CmpS (re e1, op, re e2)
  | IsValidS (eo, e, es, so) -> IsValidS (Option.map re eo, re e, List.map re es, so)
  | MatchesS (e1, e2) -> MatchesS (re e1, re e2)
  | IsConstS (eo, e) -> IsConstS (Option.map re eo, re e)
  | IsDefinedS e -> IsDefinedS (re e)
  | IsDefaultableS (e, op) -> IsDefaultableS (re e, op)
  | IfS (e, sl) -> IfS (re e, List.map rs sl)
  | ForallS (pairs, sl) ->
      let pairs' = List.map (fun (e1, e2) -> (re e1, re e2)) pairs in
      ForallS (pairs', List.map rs sl)
  | EitherS sll -> EitherS (List.map (List.map rs) sll)
  | BinS (s1, op, s2) -> BinS (rs s1, op, rs s2)
  | ContextS (e1, e2) -> ContextS (re e1, re e2)
  | RelS (name, es) -> RelS (name, List.map re es)
  | YetS s -> YetS s

let replace_name_def x1 x2 def =
  let r = replace_name_stmt x1 x2 in
  match def with
  | RuleD (anchor, s, sl) -> RuleD (anchor, r s, List.map r sl)
  | AlgoD _algo -> failwith "unreachable"

let remove_simple_binding def =
  match def with
  | RuleD (anchor, s, sl) ->
    let frees = free_stmt s in
    let rec remove_simple_binding' acc sl =
      match sl with
      | [] -> List.rev acc
      | hd :: tl ->
        match hd with
        (* Recursive cases *)
        | EitherS sll ->
          let sll' = List.map (remove_simple_binding' []) sll in
          let hd' = EitherS sll' in
          remove_simple_binding' (hd' :: acc) tl
        | IfS (e, sl) ->
          let hd' = IfS (e, remove_simple_binding' [] sl) in
          remove_simple_binding' (hd' :: acc) tl
        (* Base cases *)
        | CmpS ({it = VarE x1; _}, `EqOp, {it = VarE x2; _}) when Al.Free.IdSet.(mem x1 frees && not (mem x2 frees)) ->
          let tl' = List.map (replace_name_stmt x2 x1) tl in
          remove_simple_binding' acc tl'
        | CmpS ({it = VarE x2; _}, `EqOp, {it = VarE x1; _}) when Al.Free.IdSet.(mem x1 frees && not (mem x2 frees)) ->
          let tl' = List.map (replace_name_stmt x2 x1) tl in
          remove_simple_binding' acc tl'
        | _ -> remove_simple_binding' (hd :: acc) tl
    in
    RuleD (anchor, s, remove_simple_binding' [] sl)
  | AlgoD _ -> def

let split_iter (s:string) =
  let len = String.length s in
  let rec find_last_idx i =
    if i > 0 && List.mem s.[i - 1] ['*'; '?'; '+'] then find_last_idx (i - 1)
    else i
  in
  let last = find_last_idx len in
  String.sub s 0 last, String.sub s last (len - last)


let get_prefix (s:string) =
  let len = String.length s in
  let rec find_last_idx i =
    if i > 0 && List.mem s.[i - 1] ['\''; '*'; '?'; '+'] then find_last_idx (i - 1)
    else i
  in
  let last = find_last_idx len in
  String.sub s 0 last
let same_prefix x1 x2 = get_prefix x1 = get_prefix x2

let swap_name r (x1, x2) =
  (* TODO: atomic swap *)
  let tmp = "__TMP__" in
  r
  |> replace_name_def x1 tmp
  |> replace_name_def x2 x1
  |> replace_name_def tmp x2

let rename_param def =
  match def with
  | RuleD (_, s, _) ->
    let frees = free_stmt s in
    let groups =
      Util.Lib.List.group_by same_prefix (Al.Free.IdSet.elements frees)
      |> List.map (List.map split_iter)
      |> List.map (List.sort compare)
    in
    let is_match = match s with | MatchesS _ -> true | _ -> false in
    List.fold_left (fun r tups ->
      let names, _ = List.split tups in
      let base_name = get_prefix (List.hd names) in
      let expected_names =
        match names with
        | [_] -> [base_name]
        | _ -> List.init (List.length names) (fun i ->
          if is_match then
            base_name ^ "_" ^ string_of_int (i+1)
          else
            base_name ^ String.make i '\''
        )
      in

      let ps =
        List.combine names expected_names
        |> List.filter (fun (x, y) -> x <> y) in

      List.fold_left swap_name r ps
    ) def groups
  | AlgoD _ -> def

let remove_same_len_check def =
  match def with
  | RuleD (a, s, sl) ->
    let ok s =
      match s with
      | CmpS ({it = LenE _; _}, `EqOp, {it = LenE _; _}) -> false
      | _ -> true
    in
    RuleD (a, s, List.filter ok sl)
  | AlgoD _ -> def

let postprocess_prose defs =
  List.map (fun def ->
    def
    |> unify_either
    |> remove_simple_binding
    |> rename_param
    |> remove_same_len_check
  ) defs
