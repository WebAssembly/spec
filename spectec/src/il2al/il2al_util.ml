open Il.Ast
open Def
open Util
open Source

let error at msg = Error.error at "prose translation" msg

let name_of_rule rule =
  match rule.it with
  | RuleD (id, _, _, _, _) ->
    String.split_on_char '-' id.it |> List.hd
let full_name_of_rule rule =
  match rule.it with
  | RuleD (id, _, _, _, _) -> id.it
let prems_of_rule rule =
  match rule.it with
  | RuleD (_, _, _, _, prems) -> prems

let lhs_of_prem pr =
  match pr.it with
  | LetPr (lhs, _, _) -> lhs
  | _ -> error pr.at "expected a LetPr"
let rhs_of_prem pr =
  match pr.it with
  | LetPr (_, rhs, _) -> rhs
  | _ -> error pr.at "expected a LetPr"
let replace_lhs lhs pr =
  let open Il.Free in
  match pr.it with
  | LetPr (lhs', rhs, _) ->
    if Il.Eq.eq_exp lhs lhs' then
      pr
    else
      { pr with it = LetPr (lhs, rhs, (free_exp lhs).varid |> Set.elements) }
  | _ -> error pr.at "expected a LetPr"

let case_of_case e =
  match e.it with
  | CaseE (mixop, _) -> mixop
  | _ -> error e.at
    (Printf.sprintf "cannot get case of case expression `%s`" (Il.Print.string_of_exp e))

let is_let_prem_with_rhs_type t prem =
  match prem.it with
  | LetPr (_, e, _) ->
    (match e.note.it with
    | VarT (id, []) -> id.it = t
    | _ -> false
    )
  | _ -> false
let is_pop : prem -> bool = is_let_prem_with_rhs_type "stackT"
let is_ctxt_prem : prem -> bool = is_let_prem_with_rhs_type "contextT"

let extract_context r =
  let _, _, prems = r in
  prems
  |> List.find_opt is_ctxt_prem
  |> Option.map lhs_of_prem (* TODO: Collect helper functions into one place *)

let extract_pops rgroup =
  (* Helpers *)
  let rec extract_pops' acc prems premss =
    match prems with
    | hd :: tl when is_pop hd ->
      let partitions = List.map (List.partition (Il.Eq.eq_prem hd)) premss in
      let fsts = List.map fst partitions in
      let snds = List.map snd partitions in

      if List.for_all (fun l -> List.length l = 1) fsts then
        extract_pops' (hd :: acc) tl snds
      else
        List.rev acc, prems :: premss
    | _ -> List.rev acc, prems :: premss
  in

  let get_prems r = let _, _, prems = r in prems in
  let set_prems r prems =
    let lhs, rhs, _ = r in
    lhs, rhs, prems
  in
  (* End of helpers *)

  let hd = List.hd rgroup in
  let tl = List.tl rgroup in

  let extracted, new_premss = extract_pops' [] (get_prems hd) (List.map get_prems tl) in
  extracted, List.map2 set_prems rgroup new_premss

let rec add eq k v = function (* add a (k,v) to an assoc list *)
  | [] -> [(k, [v])]
  | (k', vs) :: tl ->
    if eq k k' then
      (k', vs @ [v]) :: tl
    else
      (k', vs) :: add eq k v tl

let group_by_context (rs: rule_clause list): ('a option * rule_clause list) list =
  let eq_context = Option.equal (fun c1 c2 -> Il.Mixop.eq (case_of_case c1) (case_of_case c2)) in
  List.fold_left (fun acc r -> add eq_context (extract_context r) r acc) [] rs

