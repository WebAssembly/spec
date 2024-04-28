open Prose
open Print
open Il
open Al.Al_util
open Il2al.Translate
open Util.Source
open Util.Error


(* Errors *)

let error at msg = error at "prose generation" msg

let print_yet_prem prem fname =
  let s = Il.Print.string_of_prem prem in
  print_yet prem.at fname ("`" ^ s ^ "`")

let print_yet_exp exp fname =
  let s = Il.Print.string_of_exp exp in
  print_yet exp.at fname ("`" ^ s ^ "`")


let cmpop_to_cmpop = function
| Ast.EqOp -> Eq
| Ast.NeOp -> Ne
| Ast.LtOp _ -> Lt
| Ast.GtOp _ -> Gt
| Ast.LeOp _ -> Le
| Ast.GeOp _ -> Ge

let swap = function Lt -> Gt | Gt -> Lt | Le -> Ge | Ge -> Le | op -> op

let transpile_expr =
  Al.Walk.walk_expr { Al.Walk.default_config with
    post_expr = Il2al.Transpile.simplify_record_concat
  }

let exp_to_expr e = translate_exp e |> transpile_expr
let exp_to_argexpr es = translate_argexp es |> List.map transpile_expr

let rec if_expr_to_instrs e =
  match e.it with
  | Ast.CmpE (op, e1, e2) ->
    let op = cmpop_to_cmpop op in
    let e1 = exp_to_expr e1 in
    let e2 = exp_to_expr e2 in
    [ match e2.it with LenE _ -> CmpI (e2, swap op, e1) | _ -> CmpI (e1, op, e2) ]
  | Ast.BinE (Ast.AndOp, e1, e2) ->
    if_expr_to_instrs e1 @ if_expr_to_instrs e2
  | Ast.BinE (Ast.OrOp, e1, e2) ->
    let neg_cond = if_expr_to_instrs e1 in
    let body = if_expr_to_instrs e2 in
    [ match neg_cond with
      | [ CmpI ({ it = IterE ({ it = VarE name; _ }, _, Opt); _ }, Eq, { it = OptE None; _ }) ] ->
        IfI (isDefinedE (varE name), body)
      | _ -> print_yet_exp e "if_expr_to_instrs"; YetI (Il.Print.string_of_exp e) ]
  | Ast.BinE (Ast.EquivOp, e1, e2) ->
      [ EquivI (exp_to_expr e1, exp_to_expr e2) ]
  | _ -> print_yet_exp e "if_expr_to_instrs"; [ YetI (Il.Print.string_of_exp e) ]

let rec prem_to_instrs prem = match prem.it with
  | Ast.LetPr (e1, e2, _) ->
    [ LetI (exp_to_expr e1, exp_to_expr e2) ]
  | Ast.IfPr e ->
    if_expr_to_instrs e
  | Ast.RulePr (id, _, e) when String.ends_with ~suffix:"_ok" id.it ->
    (match exp_to_argexpr e with
    | [c; e'; t] -> [ MustValidI (c, e', Some t) ]
    | [c; e'] -> [ MustValidI (c, e', None) ]
    | _ -> error e.at "unrecognized form of argument in rule_ok"
    )
  | Ast.RulePr (id, _, e) when String.ends_with ~suffix:"_sub" id.it ->
    (match exp_to_argexpr e with
    | [t1; t2] -> [ MustMatchI (t1, t2) ]
    | _ -> print_yet_prem prem "prem_to_instrs"; [ YetI "TODO: prem_to_instrs rule_sub" ]
    )
  | Ast.IterPr (prem, iter) ->
    (match iter with
    | Ast.Opt, [(id, _)] -> [ IfI (isDefinedE (varE id.it), prem_to_instrs prem) ]
    | Ast.(List | ListN _), [(id, _)] ->
        let name = varE id.it in
        [ ForallI (name, iterE (name, [id.it], Al.Ast.List), prem_to_instrs prem) ]
    | _ -> print_yet_prem prem "prem_to_instrs"; [ YetI "TODO: prem_to_intrs iter" ]
    )
  | _ ->
    let s = Il.Print.string_of_prem prem in
    print_yet_prem prem "prem_to_instrs"; [ YetI s ]

type vrule_group =
  string * (Ast.exp * Ast.exp * Ast.prem list * Ast.bind list) list

(** Main translation for typing rules **)
let vrule_group_to_prose ((_name, vrules): vrule_group) =
  let (winstr, t, prems, _tenv) = vrules |> List.hd in

  (* name *)
  let name = match winstr.it with
  | Ast.CaseE (({it = (Il.Atom.Atom _) as atom'; note; _}::_)::_, _) -> atom', note.def
  | _ -> assert false
  in
  (* params *)
  let params = get_params winstr |> List.map exp_to_expr in
  (* body *)
  let body = (List.concat_map prem_to_instrs prems) @ [ IsValidI (Some (exp_to_expr t)) ] in

  (* Predicate *)
  Pred (name, params, body)

let rec extract_vrules def =
  match def.it with
  | Ast.RecD defs -> List.concat_map extract_vrules defs
  | Ast.RelD (id, _, _, rules) when id.it = "Instr_ok" -> rules
  | _ -> []

let pack_vrule vrule =
  match vrule.it with
  | Ast.RuleD (_, tenv, _, exp, prems) ->
    match exp.it with
    (* c |- e : t *)
    | Ast.TupE [ _c; e; t ] -> (e, t, prems, tenv)
    | _ -> error exp.at
      (Print.string_of_exp exp
      |> Printf.sprintf "exp `%s` cannot be typing rule")

(* group typing rules that have same name *)
(* Il.rule list -> vrule_group list *)
let rec group_vrules = function
  | [] -> []
  | h :: t ->
      let name = name_of_rule h in
      let same_rules, diff_rules =
        List.partition (fun rule -> name_of_rule rule = name) t in
      let group = (name, List.map pack_vrule (h :: same_rules)) in
      group :: group_vrules diff_rules

(** Entry for generating validation prose **)
let gen_validation_prose il =
  il
  |> List.concat_map extract_vrules
  |> group_vrules
  |> List.map vrule_group_to_prose

(** Entry for generating execution prose **)
let gen_execution_prose =
  List.map
    (fun algo ->
      let handle_state = match algo with
      | Al.Ast.RuleA _ -> Il2al.Transpile.insert_state_binding
      | Al.Ast.FuncA _ -> Il2al.Transpile.remove_state
      in
      let algo =
        handle_state algo
        |> Il2al.Transpile.remove_exit
        |> Il2al.Transpile.remove_enter
      in
      Prose.Algo algo)

(** Main entry for generating prose **)
let gen_prose il al =
  let validation_prose = gen_validation_prose il in
  let execution_prose = gen_execution_prose al in
  validation_prose @ execution_prose

(** Main entry for generating stringified prose **)
let gen_string il al = string_of_prose (gen_prose il al)
