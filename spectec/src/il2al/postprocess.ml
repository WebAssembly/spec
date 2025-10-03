open Al
open Xl
open Ast
open Util
open Source

let rec merge_pop_assert' instrs =
  let rec merge_helper acc = function
    (* pop unknown type then assert *)
    | ({ it = AssertI ({ it = TopValueE None; _ } as e1); _ } as i1) ::
    ({ it = PopI e2; _ } as i2) ::
    ({ it = AssertI ({ it = BinE (`EqOp, e31, e32); _ }); _ } as i3) :: il ->
      (match e2.it, e32.it with
      | CaseE ([{ it = Atom.Atom ("CONST" | "VCONST"); _ }]::_, hd::_), VarE _
      when Eq.eq_expr e31 hd ->
        let e1 = { e1 with it = TopValueE (Some e32) } in
        let i1 = { i1 with it = AssertI e1 } in
        merge_helper (i2 :: i1 :: acc) il
      | _ -> merge_helper (i1 :: acc) (i2 :: i3 :: il)
      )
    (* pop known type *)
    | ({ it = AssertI ({ it = TopValueE None; _ } as e1); _ } as i1) ::
    ({ it = PopI e2; _ } as i2) :: il ->
      (match e2.it with
      | CaseE ([{ it = Atom.Atom ("CONST" | "VCONST"); _ }]::_,
        ({ it = CaseE (_, []); _ } as hd)::_tl) ->
        let e1 = { e1 with it = TopValueE (Some hd) } in
        let i1 = { i1 with it = AssertI e1 } in
        merge_helper (i2 :: i1 :: acc) il
      | CaseE ([{ it = Atom.Atom ("CONST" | "VCONST" as cons); _ }]::_ ,
      { it = VarE _; _ }::_tl) ->
        (* HARDCODE: name of type according to constructor *)
        let vt = if cons = "CONST" then "num" else "vec" in
        let hd = VarE vt $$ no_region % (Il.Ast.VarT (vt $ no_region, []) $ no_region) in
        let e1 = { e1 with it = TopValueE (Some hd) } in
        let i1 = { i1 with it = AssertI e1 } in
        merge_helper (i2 :: i1 :: acc) il
      | VarE id ->
        let id = (
          match String.index_opt id '_' with
          | Some i -> String.sub id 0 i
          | None -> id
        ) in
        let id = (
          match String.index_opt id '\'' with
          | Some i -> String.sub id 0 i
          | None -> id
        ) in
        if id <> "val" &&
          Option.is_some (Il.Env.find_opt_typ !Al.Valid.il_env (id $ no_region)) then (
          let te = VarE id $$ no_region % (Il.Ast.VarT (id $ no_region, []) $ no_region) in
          let e1 = { e1 with it = TopValueE (Some te) } in
          let i1 = { i1 with it = AssertI e1 } in
          merge_helper (i2 :: i1 :: acc) il
        )
        else merge_helper (i1 :: acc) (i2 :: il)
      | _ -> merge_helper (i1 :: acc) (i2 :: il)
      )
    | i :: il -> merge_helper (i :: acc) il
    | [] -> List.rev acc
  in
  let instrs = merge_helper [] instrs in
  List.map (fun i ->
    let it =
      match i.it with
      | IfI (e, il1, il2) -> IfI (e, merge_pop_assert' il1, merge_pop_assert' il2)
      | EitherI (il1, il2) -> EitherI (merge_pop_assert' il1, merge_pop_assert' il2)
      | EnterI (e1, e2, il) -> EnterI (e1, e2, merge_pop_assert' il)
      | OtherwiseI (il) -> OtherwiseI (merge_pop_assert' il)
      | instr -> instr
    in
    { i with it }
  ) instrs


let merge_pop_assert algo =
  let it =
    match algo.it with
    | RuleA (name, anchor, args, instrs) ->
      RuleA (name, anchor, args, merge_pop_assert' instrs)
    | FuncA (name, args, instrs) ->
      FuncA (name, args, merge_pop_assert' instrs)
  in
  { algo with it }

let split_iter s =
  let len = String.length s in
  let rec find_last_non_iter i =
    if i > 0 && List.mem s.[i - 1] ['*'; '?'; '+'] then find_last_non_iter (i - 1)
    else i
  in
  let last = find_last_non_iter len in
  String.sub s 0 last, String.sub s last (len - last)

let replace_name old_name new_name algo =
  let replace_name' walker e =
    match e.it with
    | VarE x when x = old_name -> {e with it = VarE new_name}
    | _ -> Walk.base_walker.walk_expr walker e
  in
  let walker = {Walk.base_walker with walk_expr = replace_name'} in
  walker.walk_algo walker algo

let rewrite_nth_var prefix i algo (name, iter) =
  let expected_name = prefix ^ String.make i '\'' in
  if (name = expected_name) then
    algo
  else
    replace_name (name ^ iter) (expected_name ^ iter) algo

let get_prefix s =
  let len = String.length s in
  let rec find_last_base_name i =
    if i > 0 && List.mem s.[i - 1] ['\''; '*'; '?'; '+'] then find_last_base_name (i - 1)
    else i
  in
  let last = find_last_base_name len in
  String.sub s 0 last

let rewrite_var_group algo group =
  let prefix = get_prefix (List.hd group) in
  let splitted = List.map split_iter group in
  let sorted = List.sort compare splitted in

  match sorted with
  | [(s1, i1); (s2, i2)] when s1 = s2 && i1 = "" && (List.mem i2 ["*"; "?"; "+"]) ->
    algo
  | _ ->
    Lib.List.fold_lefti (rewrite_nth_var prefix) algo sorted

let same_prefix s1 s2 = get_prefix s1 = get_prefix s2
let group_by_prefix vars = Lib.List.group_by same_prefix (Al.Free.IdSet.elements vars)

(* Rename all x' into x *)
let simplify_var_name algo =
  algo
  |> Al.Free.free_algo
  |> group_by_prefix
  |> List.fold_left rewrite_var_group algo

let postprocess (al: Al.Ast.algorithm list) : Al.Ast.algorithm list =
  al
  |> List.map Transpile.remove_state
  |> List.map merge_pop_assert
  |> List.map simplify_var_name
