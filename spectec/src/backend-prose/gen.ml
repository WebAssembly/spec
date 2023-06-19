open Prose
open Print
open Il
open Backend_interpreter.Translate
open Util.Source

let cmpop_to_cmpop = function
| Ast.EqOp -> Eq
| Ast.NeOp -> Ne
| Ast.LtOp -> Lt
| Ast.GtOp -> Gt
| Ast.LeOp -> Le
| Ast.GeOp -> Ge

let swap = function Lt -> Gt | Gt -> Lt | Le -> Ge | Ge -> Le | op -> op

let iter_to_iter = function
| Ast.Opt, [id] -> "If " ^ id.it ^ " is defined,"
| Ast.List, [id] -> "For all " ^ id.it ^ " in " ^ id.it ^ "*,"
| _ -> "For all ...,"

let transpile_expr =
  Backend_interpreter.Walk.walk_expr { Backend_interpreter.Walk.default_action with
    post_expr = Backend_interpreter.Transpile.simplify_record_concat
  }

let exp_to_expr e = exp2expr e |> transpile_expr
let exp_to_args es = exp2args es |> List.map transpile_expr

let rec if_expr_to_instrs e =
  let fail _ =
    let s = Il.Print.string_of_exp e in
    print_endline ("if_expr_to_instrs: Invalid if_prem (" ^ s ^ ")");
    YetI s in
  match e.it with
  | Ast.CmpE (op, e1, e2) ->
    let op = cmpop_to_cmpop op in
    let e1 = exp_to_expr e1 in
    let e2 = exp_to_expr e2 in
    [ match e2 with LengthE _ -> CmpI (e2, swap op, e1) | _ -> CmpI (e1, op, e2) ]
  | Ast.BinE (Ast.AndOp, e1, e2) ->
    if_expr_to_instrs e1 @ if_expr_to_instrs e2
  | Ast.BinE (Ast.OrOp, e1, e2) ->
    let neg_cond = if_expr_to_instrs e1 in
    let body = if_expr_to_instrs e2 in
    [ match neg_cond with
      | [ CmpI (NameE (N name, [Opt]), Eq, OptE None) ] -> ForallI ("If " ^ name ^ " is defind,", body)
      | _ -> fail() ]
  | Ast.BinE (Ast.EquivOp, e1, e2) ->
      [ EquivI (exp2cond e1, exp2cond e2) ]
  | _ -> [ fail() ]

let rec prem_to_instrs prem = match prem.it with
  | Ast.LetPr (e1, e2) ->
    [ LetI (exp_to_expr e1, exp_to_expr e2) ]
  | Ast.IfPr e ->
    if_expr_to_instrs e
  | Ast.RulePr (id, _, exp) when String.ends_with ~suffix:"_ok" id.it ->
    ( match exp_to_args exp with
    | [c; e; t] -> [ MustValidI (c, e, Some t) ]
    | [c; e] -> [ MustValidI (c, e, None) ]
    | _ -> failwith "prem_to_instr: Invalid prem"
    )
  | Ast.RulePr (id, _, exp) when String.ends_with ~suffix:"_sub" id.it ->
    ( match exp_to_args exp with
    | [t1; t2] -> [ MustMatchI (t1, t2) ]
    | _ -> failwith "prem_to_instr: Invalid prem"
    )
  | Ast.IterPr (prem, iter) ->
    [ ForallI (iter_to_iter iter, prem_to_instrs prem) ]
  | _ ->
    let s = Il.Print.string_of_prem prem in
    print_endline ("prem_to_instrs: Invalid prem (" ^ s ^ ")");
    [ YetI s ]

type vrule_group =
  string * (Ast.exp * Ast.exp * Ast.premise list * Ast.binds) list

(** Main translation for typing rules **)
let vrule_group_to_prose ((instr_name, vrules): vrule_group) =
  let (e, t, prems, _tenv) = vrules |> List.hd in

  (* name *)
  let name = "validation_of_" ^ instr_name in
  (* params *)
  let params = get_params e |> List.map exp_to_expr in
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
  let (Ast.RuleD (_, tenv, _, exp, prems)) = vrule.it in
  match exp.it with
  (* c |- e : t *)
  | Ast.TupE [ _c; e; t ] -> (e, t, prems, tenv)
  | _ ->
      Print.string_of_exp exp
      |> Printf.sprintf "Invalid expression `%s` to be typing rule."
      |> failwith

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
let gen_execution_prose = List.map (fun algo -> Prose.Algo algo)

(** Main entry for generating prose **)
let gen_prose il al =
  let validation_prose = gen_validation_prose il in
  let execution_prose = gen_execution_prose al in
  validation_prose @ execution_prose

(** Main entry for generating stringified prose **)
let gen_string il al = string_of_prose (gen_prose il al)
