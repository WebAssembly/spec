open Util.Source
open Al.Ast
open Al.Free
let (++) = IdSet.union
open Prose
open Eq
open Il2al.Il2al_util

(** Helpers **)

(* Apply (f: stmt list -> stmt list) recursively *)
let lift f sl =
  List.map (function
    | IfS (e, ss) -> IfS (e, f ss)
    | ForallS (ees, ss) -> ForallS (ees, f ss)
    | EitherS (sss) -> EitherS (List.map f sss)
    | s -> s
  ) (f sl)

(* Family of walkers *)
let walk_stmt_acc_lift (f: 'a -> stmt -> ('a * stmt list)) (init: 'a) (ss: stmt list) : stmt list =
  let rec aux init ss =
    List.fold_left_map (fun acc s ->
      let s' =
        match s with
        | ForallS (ees, ss) -> ForallS (ees, aux acc ss)
        | IfS (e, ss) -> IfS (e, aux acc ss)
        | EitherS (sss) -> EitherS (List.map (aux acc) sss)
        | _ -> s
      in

      f acc s'
    ) init ss |> snd |> List.concat
  in
  aux init ss

let walk_stmt_acc (f: 'a -> stmt -> ('a *stmt)) =
  let f' acc s = let (acc', s') = f acc s in (acc', [s']) in
  walk_stmt_acc_lift f'

let walk_stmt_lift (f: stmt -> stmt list) =
  let f' _ s = ((), f s) in
  walk_stmt_acc_lift f' ()

let walk_stmt (f: stmt -> stmt) =
  let f' _ s = ((), f s) in
  walk_stmt_acc f' ()

let reversify walk sl = List.rev (walk (List.rev sl))

let reverse_walk_stmt_acc_lift f acc = reversify (walk_stmt_acc_lift f acc)
let reverse_walk_stmt_acc f acc      = reversify (walk_stmt_acc f acc)
let reverse_walk_stmt_lift f         = reversify (walk_stmt_lift f)
let reverse_walk_stmt f              = reversify (walk_stmt f)

let fold_stmt (f: stmt list -> stmt -> stmt list) ss =
  let rec aux ss =
    List.fold_left (fun acc s ->
      let s' =
        match s with
        | ForallS (ees, ss) -> ForallS (ees, aux ss)
        | IfS (e, ss) -> IfS (e, aux ss)
        | EitherS (sss) -> EitherS (List.map aux sss)
        | _ -> s
      in

      f acc s'
    ) [] ss
  in
  aux ss

let (let*) = Option.bind

(** End of Helpers **)

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
  | IsConcatS (e1, e2) -> free_expr e1 ++ free_expr e2
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
  | IsConcatS (e1, e2) -> IsConcatS (re e1, re e2)
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

let rec extract_simple_var e =
  match e.it with
  | VarE x -> Some [x]
  | IterE (e', (_, [x, {it = VarE x'; _}])) ->
    let* r = extract_simple_var e' in
    if List.hd r = x then
      Some (x' :: r)
    else
      None
  | _ -> None

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
        | CmpS (e1, `EqOp, e2) ->
          (match extract_simple_var e1, extract_simple_var e2 with
          | Some (x1 :: _ as l1), Some (x2 :: _ as l2)
            when List.length l1 = List.length l2 && Al.Free.IdSet.(mem x1 frees && not (mem x2 frees)) ->
            let tl' = List.fold_left2 (fun acc x1 x2 ->
              List.map (replace_name_stmt x2 x1) acc
            ) tl l1 l2 in
            remove_simple_binding' acc tl'
          | Some (x2 :: _ as l2), Some (x1 :: _ as l1)
            when List.length l1 = List.length l2 && Al.Free.IdSet.(mem x1 frees && not (mem x2 frees)) ->
            let tl' = List.fold_left2 (fun acc x1 x2 ->
              List.map (replace_name_stmt x2 x1) acc
            ) tl l1 l2 in
            remove_simple_binding' acc tl'
          | _ -> remove_simple_binding' (hd :: acc) tl
          )
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
      | CmpS ({it = LenE _; _}, `EqOp, {it = LenE _; _}) -> []
      | _ -> [s]
    in

    RuleD (a, s, walk_stmt_lift ok sl)
  | AlgoD _ -> def

let restructure_forall def =
  match def with
  | RuleD (a, s, sl) ->
    let frees = free_stmt s in

    (* 1. Factor-out output vars *)
    let sl1 = walk_stmt_acc_lift (fun frees s ->
      frees ++ (free_stmt s),
      match s with
      | ForallS (ees, ss) when List.length ees > 1 ->
        let is_known_iter e =
          match e.it with
          | IterE (_, (_, [_, {it = VarE x; _}])) -> IdSet.mem x frees
          | _ -> false
        in
        let knowns, unknowns = List.partition (fun (_, e) -> is_known_iter e) ees in
        ForallS (knowns, ss) :: List.map (fun (e1, e2) -> IsConcatS (e2, e1)) unknowns
      | _ -> [s]
    ) frees sl in

    (* 2. Merge foralls with same iters *)
    let rec eq_ees ees1 ees2 =
      match ees1, ees2 with
      | [], [] -> true
      | (e1, e1') :: ees1, (e2, e2') :: ees2 -> Al.Eq.eq_expr e1 e2 && Al.Eq.eq_expr e1' e2' && eq_ees ees1 ees2
      | _ -> false
    in
    let sl2 = fold_stmt (fun acc s ->
      match (List.rev acc), s with
      | ForallS (ees1, ss1) :: tl, ForallS (ees2, ss2) when eq_ees ees1 ees2 ->
        List.rev (ForallS (ees1, ss1 @ ss2) :: tl)
      | _ ->
        acc @ [s]
    ) sl1
    in

    (* 3. Remove unnecessary concats *)
    let sl3 = reverse_walk_stmt_acc_lift (fun frees s ->
      match s with
      | IsConcatS ({it = IterE (_, (_, [_, {it = VarE x; _}])); _}, _) when not (IdSet.mem x frees) -> frees, []
      | _ -> frees ++ (free_stmt s), [s]
    ) frees sl2 in

    RuleD (a, s, sl3)
  | AlgoD _ -> def

let remove_dead_binding def =
  match def with
  | RuleD (anchor, s, (_ :: _ as sl)) ->
    let freq_map: (string * int) list ref = ref [] in
    let update_freq_map frees =
      IdSet.iter (fun x ->
        match List.assoc_opt x !freq_map with
        | None -> freq_map := (x, 1) :: !freq_map
        | Some i -> freq_map := (x, 1+i) :: (List.remove_assoc x !freq_map)
      ) frees
    in
    let rec handle_stmts ss = List.iter handle_stmt ss
    and handle_stmt s =
      (match s with
      | EitherS sss -> List.iter handle_stmts sss
      | IfS (e, ss) ->
        let frees = free_expr e in
        update_freq_map frees;
        handle_stmts ss
      | ForallS (ees, ss) ->
        let frees = List.map (fun (_, e) -> free_expr e) ees |> List.fold_left (++) IdSet.empty in
        update_freq_map frees;
        handle_stmts ss
      | _ ->
        let frees = free_stmt s in
        update_freq_map frees
      )
    in

    handle_stmts (s :: sl);

    let is_single (x, i) = if i = 1 then Some x else None in
    let single_vars = List.filter_map is_single !freq_map in

    let sl' = walk_stmt_lift (fun s ->
      match s with
      | CmpS ({it = VarE x; _}, `EqOp, _) when List.mem x single_vars -> []
      | CmpS (_, `EqOp, {it = VarE x; _}) when List.mem x single_vars -> []
      | LetS ({it = VarE x; _}, _) when List.mem x single_vars -> []
      | _ -> [s]
    ) sl in

    RuleD (anchor, s, sl')
  | _ -> def

let has_subexpr_expr e ee =
  let flag = ref false in
  let base = Al.Walk.base_unit_walker in
  let walk_expr w e' = if Al.Eq.eq_expr e e' then flag := true else base.walk_expr w e' in
  let walker = {Al.Walk.base_unit_walker with walk_expr} in
  walker.walk_expr walker ee;
  !flag

let rec has_subexpr e s =
  let fe = has_subexpr_expr e in
  let fes = List.exists fe in
  let fs = has_subexpr e in
  let fss = List.exists fs in
  match s with
  | LetS (e1, e2)
  | CmpS (e1, _, e2)
  | MatchesS (e1, e2)
  | IsConcatS (e1, e2)
  | ContextS (e1, e2) -> fe e1 || fe e2
  | CondS e
  | IsDefinedS e
  | IsDefaultableS (e, _) -> fe e
  | IsValidS (None, e, es, _) -> fe e || fes es
  | IsValidS (Some e0, e1, es, _) -> fe e0 || fe e1 || fes es
  | IsConstS (None, e') -> fe e'
  | IsConstS (Some e, e') -> fe e || fe e'
  | IfS (e, sl) -> fe e || fss sl
  | ForallS (pairs, sl) ->
      let pair_exprs = List.flatten (List.map (fun (e1, e2) -> [e1; e2]) pairs) in
      fes pair_exprs || fss sl
  | EitherS sll -> List.exists fss sll
  | BinS (s1, _, s2) -> fs s1 || fs s2
  | RelS (_, es) -> fes es
  | YetS _ -> false

let rec insert_if f x xs =
  match xs with
  | [] -> [x]
  | hd :: tl ->
    if f hd then x :: xs else hd :: (insert_if f x tl)

let prioritize_length_check def =
  match def with
  | RuleD (anchor, s, sl) ->
    let sl' = fold_stmt (fun acc s ->
      match s with
      | CmpS ({it = LenE base; _}, `GtOp, index) ->
        let no_typ = (Il.Ast.VarT ("" $ no_region, []) $ no_region) in
        let e = AccE (base, IdxP index $ no_region) $$ no_region % no_typ in
        insert_if (has_subexpr e) s acc
      | _ -> acc @ [s]
    ) sl in
    RuleD (anchor, s, sl')
  | AlgoD _ -> def

let string_drop_last s =
  let l = String.length s in
  String.sub s 0 (l-1)

let rec dedup eq = function
  | [] -> []
  | hd :: tl ->
    if List.exists (eq hd) tl then dedup eq tl else hd :: dedup eq tl


let handle_allocxs def =
  match def with
  | AlgoD algo ->
    let name = Al.Al_util.name_of_algo algo in
    let walk_instr walker i =
      match i.it with
      | LetI (e1, e2) ->
        (match e1.it, e2.it with
        | IterE (e', (List, _)), CallE (fname, args) when Prose_util.is_allocxs fname && fname <> name ->
          let fname' = string_drop_last fname in
          let store, tl = Util.Lib.List.split_hd args in
          let iters, tl' = List.fold_left_map (fun acc arg ->
            match arg.it with
            | ExpA ({it = IterE (arg', (_, xes)); _}) ->
              let arg' = {arg with it = ExpA arg'} in
              acc @ xes, arg'
            | _ -> Util.Error.error arg.at "prose postprocessing" "IterE expected as a non-first argument of allocXs"
          ) [] tl in
          let iters' = dedup (fun (x1, _) (x2, _) -> x1 = x2) iters in
          let args' = store :: tl' in
          let e2' = {e2 with it = CallE (fname', args')} in

          Al.Al_util.
          [
            letI (e1, listE [] ~note:e1.note);
            forEachI (iters', [
              letI (e', e2');
              appendI(e1, e')
            ])
          ]
        | _ -> [i]
        )
      | _ -> Al.Walk.base_walker.walk_instr walker i
    in
    let walker = {Al.Walk.base_walker with walk_instr} in
    let algo' = walker.walk_algo walker algo in
    AlgoD algo'
  | _ -> def


let postprocess_prose defs =
  List.map (fun def ->
    def
    |> unify_either
    |> remove_simple_binding
    |> rename_param
    |> remove_same_len_check
    |> restructure_forall
    |> remove_dead_binding
    |> prioritize_length_check
    |> handle_allocxs
  ) defs
