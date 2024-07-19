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

(* Helpers *)

let flatten_rec def =
  match def.it with
  | Ast.RecD defs -> defs
  | _ -> [ def ]

let preprocess_prem prem = match prem.it with
  (* HARDCODE: translation of `Expand: dt ~~ ct` into `$expanddt(dt) = ct` *)
  | Ast.RulePr (
      { it = "Expand"; _ },
      [[]; [{it = Approx; _}]; []],
      { it = TupE [dt; ct]; at = tup_at; _ }
    ) ->
      let expanded_dt = { dt with it = Ast.CallE ("expanddt" $ no_region, [Ast.ExpA dt $ dt.at]); note = ct.note } in
      { prem with it = Ast.IfPr (Ast.CmpE (Ast.EqOp, expanded_dt, ct) $$ tup_at % (Ast.BoolT $ tup_at)) }
  | _ -> prem

let atomize atom' = atom' $$ no_region % (El.Atom.info "")

let cmpop_to_cmpop = function
| Ast.EqOp -> Eq
| Ast.NeOp -> Ne
| Ast.LtOp _ -> Lt
| Ast.GtOp _ -> Gt
| Ast.LeOp _ -> Le
| Ast.GeOp _ -> Ge

let swap = function Lt -> Gt | Gt -> Lt | Le -> Ge | Ge -> Le | op -> op

(* Hardcoded convention: "The rules implicitly assume a given context C" *)
let try_omit c = match c.it with
| Al.Ast.VarE "C" -> None
| _ -> Some c


(** There are currently 6 supported shape of a validation relation.
  * Extend this list upon introducing new shape of validation rule to the spec.
  * 1. C |- e : OK
  * 2. C |- t <: t
  * 3. C |- i : t (where i is a wasm instruction)
  * 4. C |- e : e
  * 5. C |- e : CONST
  * 6. Others
**)
let is_ok_rel def =
  let pattern = El.Atom.[[]; [atomize Turnstile]; [atomize Colon; atomize (Atom "OK")]] in
  match def.it with
  | Ast.RelD (_, mixop, _, _) -> Mixop.eq pattern mixop
  | _ -> false
let is_match_rel def =
  let pattern = El.Atom.[[]; [atomize Turnstile]; [atomize Sub]; []] in
  match def.it with
  | Ast.RelD (_, mixop, _, _) -> Mixop.eq pattern mixop
  | _ -> false
let is_instr_type_rel def =
  let pattern = El.Atom.[[]; [atomize Turnstile]; [atomize Colon]; []] in
  match def.it with
  | Ast.RelD (_, mixop, { it = TupT [_; (_, t); _]; _}, _) ->
    Mixop.eq pattern mixop &&
    Il.Print.string_of_typ t = "instr"
  | _ -> false
let is_valid_with_rel def =
  let pattern = El.Atom.[[]; [atomize Turnstile]; [atomize Colon]; []] in
  match def.it with
  | Ast.RelD (_, mixop, _, _) -> Mixop.eq pattern mixop
  | _ -> false
let is_const_rel def =
  let pattern = El.Atom.[[]; [atomize Turnstile]; [atomize (Atom "CONST")]] in
  match def.it with
  | Ast.RelD (_, mixop, _, _) -> Mixop.eq pattern mixop
  | _ -> false
let is_context_rel def =
  match def.it with
  | Ast.RelD (_, _, { it = TupT ((_, t) :: _); _}, _) ->
    Il.Print.string_of_typ t = "context"
  | _ -> false

let classify_rels () =
  let il = List.concat_map flatten_rec !Langs.il in
  let il = List.filter is_context_rel il in

  let ok_rels,         il = List.partition is_ok_rel il in
  let match_rels,      il = List.partition is_match_rel il in
  let instr_type_rels, il = List.partition is_instr_type_rel il in
  let valid_with_rels, il = List.partition is_valid_with_rel il in
  let const_rels,      il = List.partition is_const_rel il in
  let other_rels = il in

  (
    ok_rels,
    match_rels,
    instr_type_rels,
    valid_with_rels,
    const_rels,
    other_rels
  )


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
  | Ast.MemE (e1, e2) ->
      [ MemI (exp_to_expr e1, exp_to_expr e2) ]
  | _ -> print_yet_exp e "if_expr_to_instrs"; [ YetI (Il.Print.string_of_exp e) ]

let rec prem_to_instrs prem =
  let prem = preprocess_prem prem in
  match prem.it with
  | Ast.LetPr (e1, e2, _) ->
    [ LetI (exp_to_expr e1, exp_to_expr e2) ]
  | Ast.IfPr e ->
    if_expr_to_instrs e
  | Ast.RulePr (id, _, e) when String.ends_with ~suffix:"_ok" id.it ->
    (match exp_to_argexpr e with
    | [c; e'; t] -> [ IsValidI (try_omit c, e', Some t) ]
    | [c; e'] -> [ IsValidI (try_omit c, e', None) ]
    | _ -> [ YetI "TODO: unrecognized form of argument in rule_ok" ]
    )
  | Ast.RulePr (id, _, e) when String.ends_with ~suffix:"_sub" id.it ->
    (match exp_to_argexpr e with
    | [_; t1; t2]
    | [t1; t2] -> [ MatchesI (t1, t2) ]
    | _ -> print_yet_prem prem "prem_to_instrs"; [ YetI "TODO: prem_to_instrs rule_sub" ]
    )
  | Ast.IterPr (prem, iter) ->
    (match iter with
    | Ast.Opt, [(id, _)] -> [ IfI (isDefinedE (varE id.it), prem_to_instrs prem) ]
    | Ast.(List | ListN _), vars ->
        let to_iter (id, _) =
          let name = varE id.it in
          name, iterE (name, [id.it], Al.Ast.List)
        in
        [ ForallI (List.map to_iter vars, prem_to_instrs prem) ]
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
  | Ast.CaseE (({it = (El.Atom.Atom name); _}::_)::_, _) -> name
  | _ -> assert false
  in
  (* expr *)
  let expr = exp_to_expr winstr in
  (* concl *)
  let concl = IsValidI (None, expr, Some (exp_to_expr t)) in
  (* prems *)
  let prems = (List.concat_map prem_to_instrs prems) in

  (* Predicate *)
  Iff (name, expr, concl, prems)

let rec extract_vrules def =
  match def.it with
  | Ast.RecD defs -> List.concat_map extract_vrules defs
  | Ast.RelD (id, _, _, rules) when id.it = "Instr_ok" -> rules
  | _ -> []

let pack_single_rule rule =
  match rule.it with
  | Ast.RuleD (_, tenv, _, exp, prems) ->
    match exp.it with
    (* c |- e : OK *)
    (* c |- e CONST *)
    | Ast.TupE [ _c; e ] -> (e, prems, tenv)
    | _ -> error exp.at
      (Print.string_of_exp exp
      |> Printf.sprintf "exp `%s` cannot be a rule for the single-argument relation")

let pack_pair_rule rule =
  match rule.it with
  | Ast.RuleD (_, tenv, _, exp, prems) ->
    match exp.it with
    (* c |- e1 <: e2 *)
    (* c |- e : t *)
    (* c |- e : e *)
    | Ast.TupE [ _c; e1; e2 ] -> (e1, e2, prems, tenv)
    | _ -> error exp.at
      (Print.string_of_exp exp
      |> Printf.sprintf "exp `%s` cannot be a rule for the double-argument relation")


(* group typing rules that have same name *)
(* Il.rule list -> vrule_group list *)
let rec group_vrules = function
  | [] -> []
  | h :: t ->
      let name = name_of_rule h in
      let same_rules, diff_rules =
        List.partition (fun rule -> name_of_rule rule = name) t in
      let group = (name, List.map pack_pair_rule (h :: same_rules)) in
      group :: group_vrules diff_rules

(** 1. C |- expr : OK *)
let prose_of_ok_rules rules =
  let rule = List.hd rules in
  let (e, _, _) = pack_single_rule rule in
  let typ = Print.string_of_typ e.note in

  (* name *)
  let name = "valid_" ^ typ in
  (* expr *)
  let expr = exp_to_expr e in
  (* concl *)
  let concl = IsValidI (None, expr, None) in
  (* prems *)
  let prems = (
    rules
    |> List.map pack_single_rule
    |> List.map (fun (_, prems, _) -> prems)
    |> List.map (List.concat_map prem_to_instrs)
    |> (function
        | [ instrs ] -> instrs
        | instrss -> [ EitherI instrss ])
  ) in

  Iff (name, expr, concl, prems)
let prose_of_ok_rel def =
  match def.it with
  | Ast.RelD (_, _, _, rules) -> prose_of_ok_rules (Il2al.Il2il.unify_rules rules)
  | _ -> assert false
let prose_of_ok_rels = List.map prose_of_ok_rel

(** 2. C |- type <: type **)
let prose_of_match_rules rules =
  let rule = List.hd rules in
  let (e1, e2, _, _) = pack_pair_rule rule in
  let typ = Print.string_of_typ e1.note in

  (* name *)
  let name = "matching_" ^ typ in
  (* expr *)
  let expr = exp_to_expr e1 in
  (* concl *)
  let concl = MatchesI (expr, exp_to_expr e2) in
  (* prems *)
  let prems = (
    rules
    |> List.map pack_pair_rule
    |> List.map (fun (_, _, prems, _) -> prems)
    |> List.map (List.concat_map prem_to_instrs)
    |> (function
        | [ instrs ] -> instrs
        | instrss -> [ EitherI instrss ])
  ) in

  Iff (name, expr, concl, prems)
let prose_of_match_rel def =
  match def.it with
  | Ast.RelD (_, _, _, rules) -> prose_of_match_rules (Il2al.Il2il.unify_rules rules)
  | _ -> assert false
let prose_of_match_rels = List.map prose_of_match_rel

(** 3. C |- instr : type **)
let prose_of_instr_type_rels rels =
  rels
  |> List.concat_map extract_vrules
  |> group_vrules
  |> List.map vrule_group_to_prose

(** 4. C |- e : e **)
let prose_of_valid_with_rules rules =
  let rule = List.hd rules in
  let (e1, e2, _, _) = pack_pair_rule rule in
  let typ = Print.string_of_typ e1.note in

  (* name *)
  let name = "valid_" ^ typ in
  (* expr *)
  let expr = exp_to_expr e1 in
  (* concl *)
  let concl = IsValidI (None, expr, Some(exp_to_expr e2)) in
  (* prems *)
  let prems = (
    rules
    |> List.map pack_pair_rule
    |> List.map (fun (_, _, prems, _) -> prems)
    |> List.map (List.concat_map prem_to_instrs)
    |> (function
        | [ instrs ] -> instrs
        | instrss -> [ EitherI instrss ])
  ) in

  Iff (name, expr, concl, prems)
let prose_of_valid_with_rel def =
  match def.it with
  | Ast.RelD (_, _, _, rules) -> prose_of_valid_with_rules (Il2al.Il2il.unify_rules rules)
  | _ -> assert false
let prose_of_valid_with_rels = List.map prose_of_valid_with_rel

(** 5. C |- x CONST **)
let prose_of_const_rules rules =
  let rule = List.hd rules in
  let (e, _, _) = pack_single_rule rule in
  let typ = Print.string_of_typ e.note in

  (* name *)
  let name = "const_" ^ typ in
  (* expr *)
  let expr = exp_to_expr e in
  (* concl *)
  let concl = IsConstI (None, expr) in
  (* prems *)
  let prems = (
    rules
    |> List.map pack_single_rule
    |> List.map (fun (_, prems, _) -> prems)
    |> List.map (List.concat_map prem_to_instrs)
    |> (function
        | [ instrs ] -> instrs
        | instrss -> [ EitherI instrss ])
  ) in

  Iff (name, expr, concl, prems)
let prose_of_const_rel def =
  match def.it with
  | Ast.RelD (_, _, _, rules) -> prose_of_const_rules (Il2al.Il2il.unify_rules rules)
  | _ -> assert false
let prose_of_const_rels = List.map prose_of_const_rel

(** 6. Others **)
let prose_of_other_rels rels = List.iter (fun rel -> match rel.it with
  | Ast.RelD (id, mixop, args, _) -> "other_relation " ^ id.it ^ ": " ^ Print.string_of_mixop mixop ^ Print.string_of_typ args |> print_endline;
  | _ -> ()) rels;
  []

(** Entry for generating validation prose **)
let gen_validation_prose () =
  let (
    ok_rels,
    match_rels,
    instr_type_rels,
    valid_with_rels,
    const_rels,
    other_rels
  ) = classify_rels () in

  prose_of_ok_rels           ok_rels
  @ prose_of_match_rels      match_rels
  @ prose_of_instr_type_rels instr_type_rels
  @ prose_of_valid_with_rels valid_with_rels
  @ prose_of_const_rels      const_rels
  @ prose_of_other_rels      other_rels

(** Entry for generating execution prose **)
let gen_execution_prose () =
  List.map
    (fun algo ->
      let handle_state = match algo.it with
      | Al.Ast.RuleA _ -> Il2al.Transpile.insert_state_binding
      | Al.Ast.FuncA _ -> Il2al.Transpile.remove_state
      in
      let algo =
        handle_state algo
        |> Il2al.Transpile.remove_exit
        |> Il2al.Transpile.remove_enter
      in
      Prose.Algo algo) !Langs.al

(** Main entry for generating prose **)
let gen_prose el il al =
  Langs.el := el;
  Langs.il := il;
  Langs.al := al;

  let validation_prose = gen_validation_prose () in
  let execution_prose = gen_execution_prose () in

  validation_prose @ execution_prose

(** Main entry for generating stringified prose **)
let gen_string el il al = string_of_prose (gen_prose el il al)
