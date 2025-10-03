(*
free_??? are equivalent to those in Il.Free module, except
1. i in e^(i<n) is not considered free.
2. n in e^n can be not considered free, depending on flag.
3. include free functions for defs defined in def.ml.
*)
open Util
open Source
open Il.Ast
include Il.Free

let free_varid id = {empty with varid = Set.singleton id.it}
let free_defid id = {empty with defid = Set.singleton id.it}

(* TODO: Make a .mli file *)
let tmp = (+)
let (+) = union

let rec free_exp ignore_listN e =
  let f = free_exp ignore_listN in
  let fp = free_path ignore_listN in
  let fef = free_expfield ignore_listN in
  let fi = free_iterexp ignore_listN in
  let fa = free_arg ignore_listN in
  match e.it with
  | VarE id -> free_varid id
  | BoolE _ | NumE _ | TextE _ -> empty
  | CvtE (e1, _, _) | UnE (_, _, e1) | LiftE e1 | LenE e1 | TheE e1 | SubE (e1, _, _)
  | DotE (e1, _) | CaseE (_, e1) | ProjE (e1, _) | UncaseE (e1, _) ->
    f e1
  | BinE (_, _, e1, e2) | CmpE (_, _, e1, e2) | IdxE (e1, e2) | CompE (e1, e2) | MemE (e1, e2) | CatE (e1, e2) ->
    free_list f [e1; e2]
  | SliceE (e1, e2, e3) -> free_list f [e1; e2; e3]
  | OptE eo -> free_opt f eo
  | TupE es | ListE es -> free_list f es
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) ->
    free_list f [e1; e2] + fp p
  | StrE efs -> free_list fef efs
  | CallE (_, args) -> free_list fa args
  | IterE (e1, iter) ->
    let free1 = f e1 in
    let bound, free2 = fi iter in
    diff free1 bound + free2

and free_expfield ignore_listN (_, e) = free_exp ignore_listN e

and free_arg ignore_listN arg =
  let f = free_exp ignore_listN in
  match arg.it with
  | ExpA e -> f e
  | TypA _ -> empty
  | DefA id -> free_defid id
  | GramA _ -> empty

and free_path ignore_listN p =
  let f = free_exp ignore_listN in
  let fp = free_path ignore_listN in
  match p.it with
  | RootP -> empty
  | IdxP (p1, e) -> fp p1 + f e
  | SliceP (p1, e1, e2) ->
    fp p1 + f e1 + f e2
  | DotP (p1, _) -> fp p1

and free_iterexp ignore_listN (iter, xes) =
  let f = free_exp ignore_listN in
  let bound = free_list free_varid (List.map fst xes) in
  let free = free_list f (List.map snd xes) in
  match iter with
  | ListN (e, None) ->
    bound, if ignore_listN then free else free + f e
  | ListN (e, Some id) ->
    (* Do not regard i* as free *)
    let snd' = (fun (x, e) -> if Il.Eq.eq_id id x then None else Some e) in
    let free = free_list f (List.filter_map snd' xes) in
    bound + free_varid id, if ignore_listN then empty else free + f e
  | _ -> bound, free

let rec free_prem ignore_listN prem =
  let f = free_exp ignore_listN in
  let fp = free_prem ignore_listN in
  let fi = free_iterexp ignore_listN in
  match prem.it with
  | RulePr (_id, _op, e) -> f e
  | IfPr e -> f e
  | LetPr (e1, e2, _ids) -> f e1 + f e2
  | ElsePr -> empty
  | IterPr (prem', iter) ->
    let free1 = fp prem' in
    let bound, free2 = fi iter in
    diff (free1 + free2) bound


(* For unification *)

let free_rule rule =
  match rule.it with
  | RuleD (_id, _bs, _op, e, prems) ->
    List.fold_left
      (+)
      (Il.Free.free_exp e)
      (List.map Il.Free.free_prem prems)

let free_clause clause =
  match clause.it with
  | DefD (_bs, as_, e, prems) ->
    List.fold_left
      (+)
      (Il.Free.free_exp e)
      (List.map Il.Free.free_prem prems @ List.map Il.Free.free_arg as_)

let free_params params =
  List.fold_left (fun s param -> s + free_param param) empty params

let free_clauses clss =
  List.fold_left (fun s c -> s + free_clause c) empty clss

let free_rules rules =
  List.fold_left (fun s r -> s + free_rule r) empty rules

let free_rule_def rd =
  let (_, _, clauses) = rd.it in
  List.fold_left (fun s c ->
    let _, lhs, rhs, prems = c in
    List.fold_left (fun s p -> s + Il.Free.free_prem p) s prems
    |> union (Il.Free.free_exp lhs)
    |> union (Il.Free.free_exp rhs)
  ) empty clauses

let free_helper_def hd =
  let (_, clauses, _) = hd.it in
  free_clauses clauses

let (+) = tmp
