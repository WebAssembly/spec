(*
This transformation
1) reorders premises and
2) explicitly denotate a premise if it is an assignment.
by performing dataflow analysis.

*)

open Util
open Source
open Il.Ast
open Il.Free
open Il.Print

let debug = false
let log = if debug then print_endline else (fun _ -> ())

(* Helper for handling free-var set *)
let subset x y = Set.subset x.varid y.varid
let disjoint x y = Set.disjoint x.varid y.varid

(* Check if a given premise is tight:
     all free variables in the premise is known *)
let is_tight env prem = subset (free_prem prem) env

(* Check if a given premise is an assignment:
     is eqaulity, and all free variables in one sie of equality is known *)
let is_assign env prem = match prem.it with
| IfPr e -> ( match e.it with
  | CmpE(EqOp, l, r) ->
    if subset (free_exp l) env && disjoint (free_exp r) env then
      Either.Left (AssignPr(r, l) $ prem.at)
    else if subset (free_exp r) env && disjoint (free_exp l) env then
      Either.Left (AssignPr(l, r) $ prem.at)
    else if subset (free_exp l) env || subset (free_exp r) env then
      Either.Left prem (* TODO: bt = t1^k t2^n *)
    else
      Either.Right prem
  | _ -> Either.Right prem
  )
| _ -> Either.Right prem


(* Mutual recursive functions that iteratively select tight and assignment premises,
   effectively sorting the premises as a result *)
let rec select_tight prems acc env = ( match prems with
| [] -> acc
| _ ->
  let (tight, non_tight) = List.partition (is_tight env) prems in
  log "======== select_tight ========";
  log "tight" ;
  tight |> List.map string_of_prem |> List.iter log;
  log "------------------------------";
  log "non-tight" ;
  non_tight |> List.map string_of_prem |> List.iter log;
  log "==============================\n";
  select_assign non_tight (acc @ tight) env
)
and select_assign prems acc env = ( match prems with
| [] -> acc
| _ -> let (assign, non_assign) = List.partition_map (is_assign env) prems in
  log "======== select_assign ========";
  log "assign" ;
  assign |> List.map string_of_prem |> List.iter log;
  log "------------------------------";
  log "non-assign" ;
  non_assign |> List.map string_of_prem |> List.iter log;
  log "==============================\n";
  ( match assign with
  | [] -> failwith "Animation failed"
  | _ ->
    let new_env = assign |> List.map free_prem |> List.fold_left union env in
    select_tight non_assign (acc @ assign) new_env
  )
)

(* Animate the list of premises *)
let animate_prems lhs prems =
  let known_vars = free_exp lhs in

  let reorder prems = select_tight prems [] known_vars in
  reorder prems

(* Animate rule *)
let animate_rule r = match r.it with
  | RuleD(id, _ , _, _, _) when id.it = "pure" || id.it = "read" -> r (* TODO: remove this line *)
  | RuleD(id, binds, mixop, e, prems) -> (
    match (mixop, e.it) with
    (* lhs* ~> rhs* *)
    | ([ [] ; [Star ; SqArrow] ; [Star]] , TupE ([lhs; _rhs]))
    (* lhs ~> rhs* *)
    | ([ [] ; [SqArrow] ; [Star]] , TupE ([lhs; _rhs]))
    (* lhs ~> rhs *)
    | ([ [] ; [SqArrow] ; []] , TupE ([lhs; _rhs])) ->
      log id.it;
      Il.Print.string_of_exp lhs |> log;
      let new_prems = animate_prems lhs prems in
      RuleD(id, binds, mixop, e, new_prems) $ r.at
    | _ -> r
  )

(* Animate def it it is a relation *)
let animate_def d = match d.it with
  | RelD(id, mixop, t, rules, hints) ->
    let new_rules = List.map animate_rule rules in
    RelD(id, mixop, t, new_rules, hints) $ d.at
  | _ -> d

(* Main entry *)
let transform (defs : script) =
  List.map animate_def defs
