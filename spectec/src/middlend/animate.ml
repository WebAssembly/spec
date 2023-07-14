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

(* Helpers *)
let rec list_count' pred acc = function
| [] -> acc
| hd :: tl -> list_count' pred (acc + if pred hd then 1 else 0) tl
let list_count pred = list_count' pred 0

let not_ f x = not (f x)

(* free_lhs_??? are equivalent to free_??? in Il.Free module,
   except k appearing in val^k is not considered free.
   see block and loop instructions *)

let empty =
  {synid = Set.empty; relid = Set.empty; varid = Set.empty; defid = Set.empty}
let free_varid id = {empty with varid = Set.singleton id.it}

let rec free_lhs_exp e =
  match e.it with
  | VarE id -> free_varid id
  | BoolE _ | NatE _ | TextE _ -> empty
  | UnE (_, e1) | LenE e1 | TheE e1 | MixE (_, e1) | SubE (e1, _, _)
  | CallE (_, e1) | DotE (e1, _) | CaseE (_, e1) ->
    free_lhs_exp e1
  | BinE (_, e1, e2) | CmpE (_, e1, e2) | ElementsOfE (e1, e2)
  | ListBuilderE (e1, e2) | IdxE (e1, e2) | CompE (e1, e2) | CatE (e1, e2) ->
    free_list free_lhs_exp [e1; e2]
  | SliceE (e1, e2, e3) -> free_list free_lhs_exp [e1; e2; e3]
  | OptE eo -> free_opt free_lhs_exp eo
  | TupE es | ListE es -> free_list free_lhs_exp es
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) ->
    union (free_list free_lhs_exp [e1; e2]) (free_lhs_path p)
  | StrE efs -> free_list free_lhs_expfield efs
  | IterE (e1, iter) -> union (free_lhs_exp e1) (free_lhs_iterexp iter)

and free_lhs_expfield (_, e) = free_lhs_exp e

and free_lhs_path p =
  match p.it with
  | RootP -> empty
  | IdxP (p1, e) -> union (free_lhs_path p1) (free_lhs_exp e)
  | SliceP (p1, e1, e2) ->
    union (free_lhs_path p1) (union (free_lhs_exp e1) (free_lhs_exp e2))
  | DotP (p1, _) -> free_lhs_path p1

and free_lhs_iterexp (_iter, ids) = free_list free_varid ids

(* Helper for handling free-var set *)
let subset x y = Set.subset x.varid y.varid

type tag =
  | Condition
  | Assign of string list
(* type row = tag * premise * int list *)
let unwrap (_, p, _) = p

(* Check if a given premise is tight:
     all free variables in the premise is known *)
let is_tight env (tag, prem, _) = match tag with
  | Condition -> subset (free_prem prem) env
  | _ -> false

(* Check if a given premise is an assignment:
     all free variables except to-be-assigned are known *)
let is_assign env (tag, prem, _) = match tag with
  | Assign frees -> subset (diff (free_prem prem) {empty with varid = (Set.of_list frees)}) env
  | _ -> false

let best' = ref (0, [])

(* Mutual recursive functions that iteratively select condition and assignment premises,
   effectively sorting the premises as a result *)
let rec select_tight prems acc env = ( match prems with
| [] -> Some acc
| _ ->
  let (tights, non_tights) = List.partition (is_tight env) prems in
  select_assign non_tights (acc @ List.map unwrap tights) env
)
and select_assign prems acc env = ( match prems with
| [] -> Some acc
| _ ->
  let (assigns, non_assigns) = List.partition (is_assign env) prems in
  match assigns with
  | [] ->
    let len = List.length acc in
    if len > fst !best' then
      best' := (len, acc @ List.map unwrap non_assigns);
    None
  | _ ->
    let assigns' = List.map unwrap assigns in
    let new_env = assigns' |> List.map free_prem |> List.fold_left union env in
    select_tight non_assigns (acc @ assigns') new_env
)

let select_target_col rows cols =
  let count col = list_count (fun (_, _, coverings) -> List.exists ((=) col) coverings) rows in
  List.fold_left (fun (cand, cnt) c ->
    let cnt' = count c in
    if cnt' < cnt then (c, cnt') else (cand, cnt)
  ) (-1, List.length rows + 1) cols |> fst

let covers (_, _, coverings) col = List.exists ((=) col) coverings
let disjoint_row (_, _, coverings1) (_, _, coverings2) = List.for_all (fun c -> List.for_all ((<>) c) coverings1) coverings2

(* Saves best attempt of knuth, to recover from knuth failure.
   Can be removed when knuth is guaranteeded to be succeed. *)
let best = ref (0, [])

let rec knuth rows cols selected_rows = match cols with
  | [] -> [ selected_rows ]
  | _ ->
    if fst !best > List.length cols then (
      let is_condition (tag, _, _) = match tag with | Condition -> true | _ -> false in
      best:= (List.length cols, selected_rows @ List.filter is_condition rows) );
    let target_col = select_target_col rows cols in
    List.concat_map (fun r ->
      if not (covers r target_col) then [] else
        let new_rows = List.filter (disjoint_row r) rows in
        let new_cols = List.filter (not_ (covers r)) cols in
        knuth new_rows new_cols (r :: selected_rows)
    ) rows

let rec index_of acc xs x = match xs with
  | [] -> None
  | h :: t -> if h = x then Some acc else index_of (acc + 1) t x

let free_exp_list e = (free_exp e).varid |> Set.elements

let rec powset = function
| [] -> [ [] ]
| hd :: tl -> List.concat_map (fun pow -> [ hd :: pow ; pow ]) (powset tl)

let large_enough_powset xs =
  let yss = powset xs in
  let n = List.length xs in
  (* Assumption: Allowing one variable to be known *)
  (* TODO: Increase this limit by reducing execution time *)
  List.filter ( fun ys -> (n - 1) <= List.length ys ) yss

let is_not_lhs = function
| LenE _ | IterE (_, (IndexedListN _, _)) -> true
| _ -> false

let rows_of_eq vars p_tot_num i l r at =
  if (is_not_lhs l.it) then [] else
  free_exp_list l
  |> large_enough_powset
  |> List.filter_map (fun frees ->
    let covering_vars = List.filter_map (index_of p_tot_num vars) frees in
    if List.length frees = List.length covering_vars then (
      Some (Assign frees, LetPr (l, r, frees) $ at, [i] @ covering_vars) )
    else
      None
  )

let rec rows_of_prem vars p_tot_num i p = match p.it with
  | IfPr e -> ( match e.it with
      | CmpE(EqOp, l, r) ->
        [ Condition, p, [i] ]
        @ rows_of_eq vars p_tot_num i l r p.at
        @ rows_of_eq vars p_tot_num i r l p.at
      | _ ->
        [ Condition, p, [i] ]
      )
  | RulePr (_, _, { it = TupE args; _ }) ->
    (* Assumpton: the only possible assigned-value is the last arg (i.e. ... |- lhs ) *)
    let _, l = Util.Lib.List.split_last args in
    let frees = (free_exp_list l) in
    [
      Condition, p, [i];
      Assign frees, p, [i] @ List.filter_map (index_of p_tot_num vars) (free_exp_list l)
    ]
  | IterPr (p', iter) ->
    let to_iter (tag, p', coverings) = tag, IterPr (p', iter) $ p.at, coverings in
    List.map to_iter (rows_of_prem vars p_tot_num i p')
  | _ -> [ Condition, p, [i] ]

let build_matrix prems known_vars =
  let all_vars = prems |> List.map free_prem |> List.fold_left union empty in
  let unknown_vars = (diff all_vars known_vars).varid |> Set.elements in
  let prem_num = List.length prems in

  let rows = List.mapi (rows_of_prem unknown_vars prem_num) prems |> List.concat in
  let cols = List.init (prem_num + List.length unknown_vars) (fun i -> i) in
  rows, cols

(* Animate the list of premises *)
let animate_prems known_vars prems =
  (* Set --otherwise prem to be the first prem (if any) *)
  let (other, non_other) = List.partition (function {it = ElsePr; _} -> true | _ -> false) prems in
  let rows, cols = build_matrix non_other known_vars in
  best := (List.length cols + 1, []);
  let candidates = match knuth rows cols [] with
    | [] ->
      print_endline "Animation failed.";
      prems |> List.map Il.Print.string_of_prem |> String.concat "\n" |> print_endline;
      [ snd !best ]
    | xs -> List.map List.rev xs in
  best' := (0, []);
  match List.find_map (fun cand -> select_tight cand other known_vars) candidates with
  | None ->
    print_endline "...Animation failed";
    snd !best'
  | Some x -> x

(* Animate rule *)
let animate_rule r = match r.it with
  | RuleD(id, _ , _, _, _) when id.it = "pure" || id.it = "read" -> r (* TODO: remove this line *)
  | RuleD(id, binds, mixop, args, prems) -> (
    match (mixop, args.it) with
    (* c |- e : t *)
    | ([ [] ; [Turnstile] ; [Colon] ; []] , TupE ([c; e; _t])) ->
      let new_prems = animate_prems (union (free_exp c) (free_exp e)) prems in
      RuleD(id, binds, mixop, args, new_prems) $ r.at
    (* lhs* ~> rhs* *)
    | ([ [] ; [Star ; SqArrow] ; [Star]] , TupE ([lhs; _rhs]))
    (* lhs ~> rhs* *)
    | ([ [] ; [SqArrow] ; [Star]] , TupE ([lhs; _rhs]))
    (* lhs ~> rhs *)
    | ([ [] ; [SqArrow] ; []] , TupE ([lhs; _rhs])) ->
      let new_prems = animate_prems (free_lhs_exp lhs) prems in
      RuleD(id, binds, mixop, args, new_prems) $ r.at
    | _ -> r
  )

(* Animate clause *)
let animate_clause c = match c.it with
  | DefD (binds, e1, e2, prems) ->
    let new_prems = animate_prems (free_lhs_exp e1) prems in
    DefD (binds, e1, e2, new_prems) $ c.at

(* Animate defs *)
let rec animate_def d = match d.it with
  | RelD (id, mixop, t, rules) ->
    let new_rules = List.map animate_rule rules in
    RelD (id, mixop, t, new_rules) $ d.at
  | DecD (id, t1, t2, clauses) ->
    let new_clauses = List.map animate_clause clauses in
    DecD (id, t1, t2, new_clauses) $ d.at
  | RecD ds -> RecD (List.map animate_def ds) $ d.at
  | _ -> d

(* Main entry *)
let transform (defs : script) =
  List.map animate_def defs
