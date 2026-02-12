(*
This transformation removes uses of the `otherwise` (`ElsePr`) premise from
inductive relations.

It only supports binary relations.

1. It figures out which rules are meant by “otherwise”:

  * All previous rules
  * Excluding those that definitely can’t apply when the present rule applies
    (decided by a simple and conservative comparision of the LHS).

2. It creates an auxillary inductive unary predicate with these rules (LHS only).
  * Note that these rules will be applied a simple naming scheme (just adding a number in front of it)
    For now to resolve naming 

3. It replaces the `ElsePr` with the negation of that rule.

*)

open Util
open Source
open Il.Ast

module StringMap = Map.Make(String)
module StringSet = Set.Make(String)

let env_ref = ref Il.Env.empty

(* Brought from Apart.ml *)

(* Looks at an expression of type list from the back and chops off all
   known _elements_, followed by the list of all list expressions.
   Returns it all in reverse order.
 *)
let rec to_snoc_list (e : exp) : exp list * exp list = match e.it with
  | ListE es -> List.rev es, []
  | CatE (e1, e2) ->
    let tailelems2, listelems2 = to_snoc_list e2 in
    if listelems2 = []
    (* Second list is fully known? Can look at first list *)
    then let tailelems1, listelems1 = to_snoc_list e1 in
        tailelems2 @ tailelems1, listelems1
    (* Second list has unknown elements, have to stop there *)
    else tailelems2, listelems2 @ [e1]
  | _ -> [], [e]

(* Taking as input a exp of type list, return all of the known elements *)
let rec get_known_elements (e : exp) : exp list = match e.it with
  | ListE es -> es
  | CatE (e1, e2) -> get_known_elements e1 @ get_known_elements e2
  | _ -> []

(* We assume the expressions to be of the same type; for ill-typed inputs
  no guarantees are made. *)
let rec apart (e1 : exp) (e2: exp) : bool =
  if Il.Eq.eq_exp e1 e2 then false else
  match e1.it, e2.it with
  (* A literal is never a literal of other type *)
  | NumE n1, NumE n2 -> not (n1 = n2)
  | BoolE b1, BoolE b2 -> not (b1 = b2)
  | TextE t1, TextE t2 -> not (t1 = t2)
  | CaseE (m1, exp1), CaseE (m2, exp2) ->
    not (m1 = m2) || apart exp1 exp2
  | TupE es1, TupE es2 when List.length es1 = List.length es2 ->
    List.exists2 apart es1 es2
  | (CatE _ | ListE _), (CatE _ | ListE _) ->
    list_exp_apart e1 e2
  | SubE (e1, _, _), SubE (e2, _, _) -> apart e1 e2
  (* Check if the specific case exists in the subtype *)
  | CaseE (m, _), SubE (_, {it = VarT (id, _); _}, _)
  | SubE (_, {it = VarT (id, _); _}, _), CaseE (m, _) ->
    begin match Il.Env.find_opt_typ !env_ref id with
    | Some (_, insts) -> 
      List.find_opt (fun inst -> match inst.it with
      | InstD (_, _, {it = VariantT typcases; _}) ->
        List.find_opt (fun (m', _, _) -> 
          Il.Eq.eq_mixop m m'
        ) typcases |> Option.is_some
      | _ -> false
      ) insts |> Option.is_none
    | None -> false
    end
  (* We do not know anything about variables and functions *)
  | _ , _ -> false (* conservative *)

(* Two list expressions are apart if either their manifest tail elements are apart *)
and list_exp_apart e1 e2 = 
  let (tailelems1, listelems1), (tailelems2, listelems2) = (to_snoc_list e1), (to_snoc_list e2) in
  snoc_list_apart (tailelems1, listelems1) (tailelems2, listelems2) ||
  
  (* Final attempt - check pairwise its known elements IF one of the lists is completely known *)
  match listelems1, listelems2 with
  | [], [] -> false (* Should have been covered by snoc_list_apart *)
  | [], _ -> 
    let k_e2 = get_known_elements e2 in
    List.exists (fun e2' -> List.for_all (fun e1' -> apart e1' e2') tailelems1) k_e2
  | _, [] ->
    let k_e1 = get_known_elements e1 in
    List.exists (fun e2' -> List.for_all (fun e1' -> apart e1' e2') tailelems2) k_e1
  | _, _ -> false (* Can't tell *)

and snoc_list_apart (tailelems1, listelems1) (tailelems2, listelems2) =
  match tailelems1, listelems1, tailelems2, listelems2 with
  (* If the heads are apart, the lists are apart *)
  | e1 :: e1s, _, e2 :: e2s, _ -> apart e1 e2 || snoc_list_apart (e1s, listelems1) (e2s, listelems2)
  (* If one list is definitely empty and the other list definitely isn't *)
  | [], [], _ :: _, _ -> false
  | _ :: _, _, [], [] -> false
  (* Else, can't tell *)
  | _, _, _, _ -> false

(* Errors *)

let error at msg = Error.error at "else removal" msg

let unary_mixfix : mixop = Xl.Mixop.Arg ()

(* Generates a fresh name if necessary, and goes up to a maximum which then it will return an error*)
let generate_next_rule_name ids rule =
  let start = 0 in
  let max = 100 in
  let rec go id c =
    if max <= c then error rule.at "Reached max variable generation" else
    let name = id ^ "_" ^ Int.to_string c in 
    if (StringSet.mem name ids) 
      then go id (c + 1) 
      else name
  in
  (match rule.it with
    | RuleD (id, quants, mixop, exp, prems) -> RuleD (go id.it start $ id.at, quants, mixop, exp, prems) 
  ) $ rule.at

let is_else prem = prem.it = ElsePr

let get_rule_id rule = 
  match rule.it with
    | RuleD (id, _, _, _, _) -> id.it

let replace_else aux_name lhs prem = match prem.it with
  | ElsePr -> NegPr (RulePr (aux_name, [], unary_mixfix, lhs) $ prem.at) $ prem.at
  | _ -> prem

let unarize rule = match rule.it with 
  | RuleD (rid, quants, _mixop, exp, prems) ->
    let lhs = match exp.it with
      | TupE [lhs; _] -> lhs
      | _ -> error exp.at "expected manifest pair"
    in
    { rule with it = RuleD (rid, quants, unary_mixfix, lhs, prems) }

let not_apart lhs rule = match rule.it with
  | RuleD (_, _, _, lhs2, _) -> not (apart lhs lhs2)

let rec go hint_map used_names at id mixop typ typ1 prev_rules : rule list -> def list = function
  | [] -> [ RelD (id, [], mixop, typ, List.rev prev_rules) $ at ]
  | r :: rules -> match r.it with
    | RuleD (rid, quants, rmixop, exp, prems) ->
      if List.exists is_else prems
      then
        let lhs = match exp.it with
          | TupE [lhs; _] -> lhs
          | _ -> error exp.at "expected manifest pair"
        in
        let aux_name = id.it ^ "_before_" ^ rid.it $ rid.at in
        let applicable_prev_rules = prev_rules
          |> List.map unarize
          |> List.filter (not_apart lhs)
          |> List.map (generate_next_rule_name used_names)
        in
        let ids_used = applicable_prev_rules 
          |> List.map get_rule_id 
          |> StringSet.of_list 
        in 
        if applicable_prev_rules = [] then (error id.at "Could not find any applicable rule") 
        else
        [ RelD (aux_name, [], unary_mixfix, typ1, applicable_prev_rules) $ r.at ] @
        let extra_hintdef = match (StringMap.find_opt id.it hint_map) with
          | Some hints -> [ HintD (RelH (aux_name, hints) $ at) $ at ]
          | _ -> []
        in
        let prems' = List.map (replace_else aux_name lhs) prems in
        let rule' = { r with it = RuleD (rid, quants, rmixop, exp, prems') } in
        extra_hintdef @
        go hint_map (StringSet.union ids_used used_names) at id mixop typ typ1 (rule' :: prev_rules) rules
      else
        go hint_map used_names at id mixop typ typ1 (r :: prev_rules) rules

let rec t_def (hint_map : (hint list) StringMap.t) (def : def) : def list = match def.it with
  | RecD defs -> [ { def with it = RecD (List.concat_map (t_def hint_map) defs) } ]
  | RelD (id, [], mixop, typ, rules) -> begin match typ.it with
    | TupT [(_exp1, typ1); (_exp2, _typ2)] ->
      go hint_map StringSet.empty def.at id mixop typ typ1 [] rules
    | _ -> [ def ]
    end
  | _ -> [ def ]

(* Put more valid hints if needed *)
let valid_hint (hint : hint) : bool = 
  hint.hintid.it = "prefix"

let collect_hints (hint_map : (hint list) StringMap.t ref) (def : def) : unit = 
  match def.it with
  | HintD {it = RelH (id, hints); _} -> 
    let applicable_hints = List.filter valid_hint hints in
    if applicable_hints = [] then () else 
    hint_map := StringMap.add id.it applicable_hints !hint_map
  | _ -> ()

let transform (defs : script) =
  let hint_map = ref StringMap.empty in
  env_ref := Il.Env.env_of_script defs; 
  List.iter (collect_hints hint_map) defs;
  List.concat_map (t_def !hint_map) defs