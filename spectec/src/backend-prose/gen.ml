open Prose

open Il
open Xl
open Al.Al_util
open Il2al.Translate
open Il2al.Il2al_util
open Util.Source
open Util.Error


(* Errors *)

let error at msg = error at "prose generation" msg

let print_yet_prem prem fname =
  let s = Il.Print.string_of_prem prem in
  print_yet prem.at fname ("`" ^ s ^ "`")

(* Helpers *)

module Map = Map.Make(String)
module Set = Set.Make(String)

let rec gen_new_var frees v =
  if Set.mem v frees then gen_new_var frees (v ^ "'") else v

let flatten_rec def =
  match def.it with
  | Ast.RecD defs -> defs
  | _ -> [ def ]

let is_validation_helper_relation def =
  match def.it with
  | Ast.RelD (id, _, _, _) -> id.it = "Expand" || id.it = "Expand_use"
  | _ -> false
(* NOTE: Assume validation relation is `|-` *)
let is_validation_relation def =
  match def.it with
  | Ast.RelD (_, mixop, _, _) ->
    List.exists (List.exists (fun atom -> atom.it = Atom.Turnstile)) mixop
  | _ -> false

let extract_validation_il il =
  il
  |> List.concat_map flatten_rec
  |> List.filter
    (fun rel -> is_validation_relation rel || is_validation_helper_relation rel)

let atomize atom' = atom' $$ no_region % (Atom.info "")

let rel_has_id id rel =
  match rel.it with
  | Ast.RelD (id', _, _, _) -> id.it = id'.it
  | _ -> false

let extract_prose_hint hintexp =
  match hintexp.it with
  | El.Ast.TextE hint -> Some hint
  | _ ->
    El.Print.string_of_exp hintexp |> print_endline;
    None

let extract_rel_hint relid hintid =
  match Prose_util.find_hint hintid relid.it with
  | Some hint -> extract_prose_hint hint
  | None -> None

let swap = function `LtOp -> `GtOp | `GtOp -> `LtOp | `LeOp -> `GeOp | `GeOp -> `LeOp | op -> op

(* CASE (?(())) ~> CASE
   CASE (?()) ~> () *)
let recover_optional_singleton_constructor e =
  match e.it with
  | Al.Ast.CaseE ([[atom]; [{it = Quest; _}]], [{it = OptE opt; _ }]) ->
    (
      match opt with
      | None   -> Al.Ast.CaseE ([[]], [])
      | Some _ -> Al.Ast.CaseE ([[atom]], [])
    ) |> (fun it -> {e with it})
  | _ -> e

(* l ->_ [] r  ~>  l -> r *)
let remove_empty_arrow_sub e =
  match e.it with
  | Al.Ast.CaseE (
      [[]; [{it = ArrowSub; _} as arrow]; []; []],
      [lhs; {it = ListE []; _}; rhs]
    ) ->
    let it = Al.Ast.CaseE ([[];[{arrow with it = Arrow}];[]], [lhs; rhs]) in
    {e with it}
  | _ -> e

let is_iter_var e =
  match e.it, e.note.it with
  | Ast.VarE id, Ast.IterT (_, List) -> String.ends_with ~suffix:"*" id.it
  | Ast.VarE id, Ast.IterT (_, List1) -> String.ends_with ~suffix:"+" id.it
  | _ -> false

let is_zero e =
  match e.it with
  | Ast.NumE n -> Num.is_zero n
  | _ -> false

let is_hidden_rule r =
  match r.it with
  | Ast.RuleD (id, _, _, _, _) -> String.starts_with ~prefix:"_" id.it

(** End of helpers **)


(** There are currently 7 supported shape of a validation relation.
  * Extend this list upon introducing new shape of validation rule to the spec,
  * or shrink the list by merging and generalizing the shape.
  * 1. C? |- e : OK
  * 2. C? |- i : t (where i is a wasm instruction)
  * 3. C? |- e : e
  * 4. C? |- t <: t
  * 5. C? |- e CONST
  * 6. C? |- e : e CONST
  * 7. C? |- e : e e
  * 8. |- e DEFAULTABLE
**)

type rel_kind =
  | ValidRel
  | ValidInstrRel of string option
  | ValidWithRel of string option
  | MatchRel
  | ConstRel
  | ValidConstRel of string option
  | ValidWith2Rel of string option
  | DefaultableRel of cmpop
  | OtherRel

let get_rel_kind def =
  let open Atom in
  let valid_pattern = [[]; [atomize Turnstile]; [atomize Colon; atomize (Atom "OK")]] in
  let valid_with_pattern = [[]; [atomize Turnstile]; [atomize Colon]; []] in
  let match_pattern = [[]; [atomize Turnstile]; [atomize Sub]; []] in
  let const_pattern = [[]; [atomize Turnstile]; [atomize (Atom "CONST")]] in
  let valid_const_pattern = [[]; [atomize Turnstile]; [atomize Colon]; [atomize (Atom "CONST")]] in
  let valid_with2_pattern = [[]; [atomize Turnstile]; [atomize Colon]; []; []] in
  let defaultable_pattern = [[]; [atomize Turnstile]; [atomize (Atom "DEFAULTABLE")]] in
  let nondefaultable_pattern = [[]; [atomize Turnstile]; [atomize (Atom "NONDEFAULTABLE")]] in

  let has_instr_as_second typ =
    match typ.it with
    | Il.Ast.TupT [_; (_, t); _] -> Il.Print.string_of_typ t = "instr"
    | _ -> false
  in
  let extract_pphint relid = extract_rel_hint relid "prosepp" in

  match def.it with
  | Ast.RelD (id, mixop, typ, _) ->
      let match_mixop pattern = Mixop.(eq mixop pattern || eq mixop (List.tl pattern)) in
      if match_mixop valid_pattern then
        ValidRel
      else if match_mixop valid_with_pattern then
        let prep_hint = extract_pphint id in
        ( if has_instr_as_second typ then ValidInstrRel prep_hint else ValidWithRel prep_hint)
      else if match_mixop match_pattern then
        MatchRel
      else if match_mixop const_pattern then
        ConstRel
      else if match_mixop valid_const_pattern then
        let prep_hint = extract_pphint id in
        ValidConstRel prep_hint
      else if match_mixop valid_with2_pattern then
        let prep_hint = extract_pphint id in
        ValidWith2Rel prep_hint
      else if match_mixop defaultable_pattern then
        DefaultableRel `EqOp
      else if match_mixop nondefaultable_pattern then
        DefaultableRel `NeOp
      else
        OtherRel
  | _ -> OtherRel

let transpile_expr =
  let (>>) f g x = x |> f |> g in
  let post_expr =
    Il2al.Transpile.simplify_record_concat
    >> Il2al.Transpile.reduce_comp
    >> recover_optional_singleton_constructor
    >> remove_empty_arrow_sub
  in
  let walk_expr walker expr =
    let expr1 = Al.Walk.base_walker.walk_expr walker expr in
    post_expr expr1
  in
  let walker = { Al.Walk.base_walker with
    walk_expr = walk_expr;
  }
  in
  walker.walk_expr walker

let exp_to_expr e = translate_exp e |> transpile_expr
let exp_to_argexpr es = translate_argexp es |> List.map transpile_expr
let rec recover_iter n ty region =
  match ty.it with
  | Ast.IterT (ty', List1) when String.ends_with ~suffix:"+" n ->
    let e' = recover_iter (String.sub n 0 (String.length n - 1)) ty' region in
    Ast.IterE (e', (Ast.List, [])) $$ region % ty
  | Ast.IterT (ty', List) when String.ends_with ~suffix:"*" n ->
    let e' = recover_iter (String.sub n 0 (String.length n - 1)) ty' region in
    Ast.IterE (e', (Ast.List, [])) $$ region % ty
  | _ -> Ast.VarE (n $ region) $$ region % ty

let itervar_to_expr e =
  match e.it with
  | Ast.VarE id -> recover_iter id.it e.note e.at
  | _ -> assert false

let rec if_expr_to_instrs e =
  match e.it with
  (* Side conditions injected in sidecondtions.ml *)
  | Ast.CmpE (`EqOp, `BoolT, ({it = LenE e1; _} as e1'), ({it = LenE e2; _ } as e2')) when is_iter_var e1 && is_iter_var e2 ->
    let expr1 = { e1' with it = Ast.LenE (itervar_to_expr e1) } |> exp_to_expr in
    let expr2 = { e2' with it = Ast.LenE (itervar_to_expr e2) } |> exp_to_expr in
    [ CmpS (expr1, `EqOp, expr2) ]
  | Ast.CmpE (`GtOp, _, {it = LenE ({it = DotE _; _} as arr); _}, index)
  | Ast.CmpE (`LtOp, _, index, {it = LenE ({it = DotE _; _} as arr); _}) ->
    if is_zero index then []
    else
      let note =
        match arr.note.it with
        | IterT (t, _) -> t
        | _ -> arr.note
        in
      let e' = accE (exp_to_expr arr, Al.Ast.IdxP (exp_to_expr index) $ index.at) ~at:e.at ~note:note in
      [ IsDefinedS e' ]
  (* Others *)
    | Ast.CmpE (op, _, e1, e2) ->
    let e1 = exp_to_expr e1 in
    let e2 = exp_to_expr e2 in
    [ match e2.it with LenE _ -> CmpS (e2, swap op, e1) | _ -> CmpS (e1, op, e2) ]
  | Ast.BinE (`AndOp, _, e1, e2) ->
    if_expr_to_instrs e1 @ if_expr_to_instrs e2
  | Ast.BinE (#Bool.binop as op, _, e1, e2) ->
    let cond1 = if_expr_to_instrs e1 in
    let cond2 = if_expr_to_instrs e2 in
    [ match op, cond1, cond2 with
      | `OrOp, [ CmpS ({ it = IterE ({ it = VarE name; _ }, (Opt, _)); _ }, `EqOp, { it = OptE None; _ }) ], _ ->
        (* ~P \/ Q is equivalent to P -> Q *)
        IfS (isDefinedE (varE name ~note:no_note) ~note:no_note, cond2)
      | _, [ stmt1 ], [ stmt2 ] -> BinS (stmt1, op, stmt2)
      | _ -> CondS (exp_to_expr e)]
  | Ast.MemE _ -> [ CondS (exp_to_expr e) ]
  | Ast.CallE (fname, _) when Prose_util.extract_call_hint fname.it <> None -> [ CondS (exp_to_expr e) ]
  | _ -> [ CmpS (exp_to_expr e, `EqOp, boolE true ~note:boolT) ]


let ctxs = ref Map.empty

let init_ctxs () = ctxs := Map.empty

(* Hardcoded convention: Bind extension of a context to another context *)
let ctx_to_instr frees expr =
  let s = Al.Print.string_of_expr expr in
  match Map.find_opt s !ctxs with
  | Some ctx -> [], Some ctx
  | None ->
    let var = Al.Ast.VarE (gen_new_var frees "C'") $$ expr.at % expr.note in
    ctxs := Map.add s var !ctxs;
    [ ContextS (var, expr) ], Some var

(* Hardcoded convention: "The rules implicitly assume a given context C or store S" *)
let extract_context frees c =
  match c.it with
  | Al.Ast.VarE ("C" | "s") -> [], None
  | Al.Ast.ExtE ({ it = VarE _; _ }, _ps, _e, _dir) -> ctx_to_instr frees c
  | _ -> [], Some c

let inject_ctx' c stmt =
  match stmt with
  | IsValidS (None, e, es, pphint) -> IsValidS (Some c, e, es, pphint)
  | IsConstS (None, e) -> IsConstS (Some c, e)
  | _ -> stmt

let inject_ctx frees c stmts =
  match extract_context frees c with
  | stmt, None -> stmt @ stmts
  | stmt, Some ctx -> stmt @ (List.map (inject_ctx' ctx) stmts)

let rec prem_to_instrs prem =
  match prem.it with
  | Ast.LetPr (e1, e2, _) ->
    [ LetS (exp_to_expr e1, exp_to_expr e2) ]
  | Ast.IfPr e ->
    if_expr_to_instrs e
  | Ast.RulePr (id, _, e) ->
    let rel =
      match List.find_opt (rel_has_id id) !Langs.validation_il with
      | Some rel -> rel
      | None -> failwith ("Unknown relation id: " ^ id.it)
    in
    let frees = (Free.free_prem prem).varid in
    let args = exp_to_argexpr e in
    ( match extract_rel_hint id "prose" with
    | Some hint ->
      (* Relation with prose hint *)
      [ RelS (hint, args) ]
    | None ->
      ( match get_rel_kind rel, args with
      (* contextless *)
      | ValidRel,      [e]         -> [ IsValidS (None, e, [], None) ]
      | ValidInstrRel pphint, [e; t]      -> [ IsValidS (None, e, [t], pphint) ]
      | ValidWithRel pphint,  [e; e']     -> [ IsValidS (None, e, [e'], pphint) ]
      | MatchRel,      [t1; t2]    -> [ MatchesS (t1, t2) ]
      | ConstRel,      [e]         -> [ IsConstS (None, e) ]
      | ValidConstRel pphint, [e; e']     -> [ IsValidS (None, e, [e'], pphint); IsConstS (None, e) ]
      | ValidWith2Rel pphint, [e; e1; e2] -> [ IsValidS (None, e, [e1; e2], pphint) ]
      | DefaultableRel cmpop, [e]        -> [ IsDefaultableS (e, cmpop) ]
      (* context *)
      | ValidRel,      [c; e]         -> [ IsValidS (None, e, [], None) ] |> inject_ctx frees c
      | ValidInstrRel pphint, [c; e; t]      -> [ IsValidS (None, e, [t], pphint) ] |> inject_ctx frees c
      | ValidWithRel pphint,  [c; e; e']     -> [ IsValidS (None, e, [e'], pphint) ] |> inject_ctx frees c
      | MatchRel,      [_; t1; t2]    -> [ MatchesS (t1, t2) ]
      | ConstRel,      [c; e]         -> [ IsConstS (None, e) ] |> inject_ctx frees c
      | ValidConstRel pphint, [c; e; e']     -> [ IsValidS (None, e, [e'], pphint); IsConstS (None, e) ] |> inject_ctx frees c
      | ValidWith2Rel pphint, [c; e; e1; e2] -> [ IsValidS (None, e, [e1; e2], pphint) ] |> inject_ctx frees c
      (* others *)
      | OtherRel,       _             -> print_yet_prem prem "prem_to_instrs"; [ YetS "TODO: prem_to_instrs for RulePr" ]
      | _,              _             -> assert false )
    )
  | Ast.IterPr (prem, iter) ->
    (match iter with
    | Ast.Opt, [(id, _)] -> [ IfS (isDefinedE (varE id.it ~note:no_note) ~note:no_note, prem_to_instrs prem) ]
    | Ast.(List | ListN _), vars ->
        let to_iter (id, _) =
          let name = varE id.it ~note:no_note in
          name, iter_var id.it List no_note
        in
        [ ForallS (List.map to_iter vars, prem_to_instrs prem) ]
    | _ -> print_yet_prem prem "prem_to_instrs"; [ YetS "TODO: prem_to_intrs iter" ]
    )
  | _ ->
    let s = Il.Print.string_of_prem prem in
    print_yet_prem prem "prem_to_instrs"; [ YetS s ]

let extract_args rule =
  match rule.it with
  | Ast.RuleD (_, _, _, exp, _) ->
    match exp.it with
    | Ast.TupE es -> es
    | _ -> [exp]


let extract_single_rule rule =
  match rule.it with
  | Ast.RuleD (_, _, _, exp, _) ->
    match exp.it with
    (* c? |- e : OK *)
    (* c? |- e CONST *)
    (* |- e DEFAULTABLE *)
    (* |- e NONDEFAULTABLE *)
    | Ast.TupE [ e ]
    | Ast.TupE [ _; e ] -> e
    | _ -> exp

let extract_pair_rule rule =
  match rule.it with
  | Ast.RuleD (_, _, _, exp, _) ->
    match exp.it with
    (* c? |- e1 <: e2 *)
    (* c? |- e : t *)
    (* c? |- e : e *)
    (* c? |- e : e CONST *)
    | Ast.TupE [ e1; e2 ]
    | Ast.TupE [ _; e1; e2 ] -> e1, e2
    | _ -> error exp.at
      (Print.string_of_exp exp
      |> Printf.sprintf "exp `%s` cannot be a rule for the double-argument relation")

let extract_triplet_rule rule =
  match rule.it with
  | Ast.RuleD (_, _, _, exp, _) ->
    match exp.it with
    (* c? |- e : e e *)
    | Ast.TupE [ e1; e2; e3 ]
    | Ast.TupE [ _; e1; e2; e3 ] -> e1, e2, e3
    | _ -> error exp.at
      (Print.string_of_exp exp
      |> Printf.sprintf "exp `%s` cannot be a rule for the triple-argument relation")


let collect_non_trivial frees m exp =
  match exp.it with
  | Ast.CallE (_, _) ->
    let name = Al.Al_util.typ_to_var_name exp.note in
    (* HARDCODE: t: valtype *)
    let name = if name = "valtype" then "t" else name in
    let fresh = (gen_new_var frees name) $ no_region in
    let var = Ast.VarE fresh $$ exp.at % exp.note in
    m := Map.add fresh.it (var, exp) !m;
    var
  | Ast.IterE ({ it = Ast.VarE id; _ }, (((Ast.List | Ast.List1), _) as ie)) when Map.mem id.it !m ->
    let (_, exp') = Map.find id.it !m in
    m := Map.add id.it (exp, {exp with it = Ast.IterE (exp', ie)}) !m;
    exp
  | _ -> exp

let preprocess_exp frees m exp =
  let open Il2al.Il_walk in
  let transformer = { base_transformer with
    transform_exp = collect_non_trivial frees m;
  } in
  transform_exp transformer exp

let preprocess_rule m rule =
  { rule with it = match rule.it with
    | Ast.RuleD (id, bs, ops, exp, prems) ->
      let frees = Free.(union (free_rule rule) (free_list bound_bind bs)).varid in
      Ast.RuleD (id, bs, ops, preprocess_exp frees m exp, prems)}

let postprocess_rules m rule =
  let binds = Map.fold (fun _ (v, e) acc ->
    LetS (exp_to_expr v, exp_to_expr e) :: acc) !m []
  in
  match rule with
  | RuleD (anchor, concl, prems) -> RuleD (anchor, concl, prems @ binds)
  | _ -> assert false

(** Main translation for rules **)
let prose_of_rules name mk_concl rules =
  let bindings = ref Map.empty in
  let rule =
    List.hd rules
    |> preprocess_rule bindings
  in
  init_ctxs ();

  (* anchor *)
  let anchor = name in
  (* concl *)
  let concl = mk_concl rule in
  (* prems *)
  let prems = (
    rules
    |> List.map prems_of_rule
    |> List.map (List.concat_map prem_to_instrs)
    |> (function
        | [ stmts ] -> stmts
        | stmtss -> [ EitherS stmtss ])
  ) in

  RuleD (anchor, concl, prems)
  |> postprocess_rules bindings


let proses_of_rel mk_concl def =
  match def.it with
  | Ast.RelD (rel_id, _, _, rules) ->
    let rules = List.filter (fun r -> not (is_hidden_rule r)) rules in
    let frees = (Il2al.Free.free_rules rules).varid in
    let unified_rules = Il2al.Unify.(unify_rules (init_env frees) rules) in
    let merged_prose = prose_of_rules rel_id.it mk_concl unified_rules in
    let unmerged_proses = if List.length rules < 2 then [] else
      List.map (fun r -> prose_of_rules (rel_id.it ^ "/" ^ name_of_rule r) mk_concl [r]) rules
    in

    merged_prose :: unmerged_proses
  | _ -> assert false

(** 1. C |- expr : OK *)
let proses_of_valid_rel = proses_of_rel (fun rule ->
  let e = extract_single_rule rule in
  IsValidS (None, exp_to_expr e, [], None))

(** 2. C |- instr : type **)
(* Validation prose for instructions are not grouped according to relation name
   (which will result in grouping the entire rules),
   but according to instr name *)
type vrule_group =
  string * Ast.id * Ast.rule list
let rec extract_vrules def =
  match def.it with
  | Ast.RecD defs -> List.concat_map extract_vrules defs
  | Ast.RelD (id, _, _, rules) when id.it = "Instr_ok" ->
      List.map (fun rule -> (id, rule)) rules
  | _ -> []
(* group typing rules that have same name *)
(* (Il.id * Il.rule) list -> vrule_group list *)
let rec group_vrules = function
  | [] -> []
  | h :: t ->
      let (rel_id, rule) = h in
      let rule_name = name_of_rule rule in
      let same_rules, diff_rules =
        List.partition (fun (_, rule) -> name_of_rule rule = rule_name) t in
      let same_rules = List.map snd same_rules in
      let group = (rule_name, rel_id, rule :: same_rules) in
      group :: group_vrules diff_rules
let vrule_group_to_prose pphint ((rule_name, rel_id, vrules): vrule_group) =
  prose_of_rules
    (rel_id.it ^ "/" ^ rule_name)
    (fun rule -> let winstr, t = extract_pair_rule rule in IsValidS (None, exp_to_expr winstr, [exp_to_expr t], pphint))
    vrules
let proses_of_valid_instr_rel pphint rel =
  let groups = rel
    |> extract_vrules
    |> group_vrules
  in

  let grouped_proses =
    groups
    |> List.map (fun (name, id, rules) ->
        let frees = (Il2al.Free.free_rules rules).varid in
        name, id, Il2al.Unify.(unify_rules (init_env frees) rules
      ))
    |> List.map (vrule_group_to_prose pphint)
  in

  let ungrouped_proses =
    groups
    |> List.filter (fun (_, _, rules) -> List.length rules > 1)
    |> List.concat_map (fun (_, id, rules) -> List.map (fun r -> (full_name_of_rule r, id, [r])) rules)
    |> List.map (vrule_group_to_prose pphint)
  in

  grouped_proses @ ungrouped_proses

(** 3. C |- expr : expr **)
let proses_of_valid_with_rel pphint = proses_of_rel (fun rule ->
  let e1, e2 = extract_pair_rule rule in
  IsValidS (None, exp_to_expr e1, [exp_to_expr e2], pphint))

(** 4. C |- type <: type **)
let proses_of_match_rel = proses_of_rel (fun rule ->
  let e1, e2 = extract_pair_rule rule in
  MatchesS (exp_to_expr e1, exp_to_expr e2))

(** 5. C |- expr CONST **)
let proses_of_const_rel = proses_of_rel (fun rule ->
  let e = extract_single_rule rule in
  IsConstS (None, exp_to_expr e))

(** 6. C |- expr : expr CONST **)
let proses_of_valid_const_rel _phint _def = [] (* Do not generate prose *)

(** 7. C |- expr : expr expr **)
let proses_of_valid_with2_rel pphint = proses_of_rel (fun rule ->
  let e1, e2, e3 = extract_triplet_rule rule in
  IsValidS (None, exp_to_expr e1, [exp_to_expr e2; exp_to_expr e3], pphint))

(** 8. |- expr DEFAULTABLE(NONDEFAULTABLE) **)
let proses_of_defaultable_rel cmpop = proses_of_rel (fun rule ->
  let e = extract_single_rule rule in
  IsDefaultableS (exp_to_expr e, cmpop))

(** 9. Others **)
let proses_of_other_rel rel =
  match rel.it with
  | Ast.RelD (rel_id, mixop, args, _) ->
    (match extract_rel_hint rel_id "prose" with
    | Some hint ->
      (* Relation with prose hint *)
      proses_of_rel (fun rule ->
        let args = extract_args rule in
        RelS (hint, List.map exp_to_expr args)
      ) rel
    | None ->
      "Untranslated relation "
      ^ rel_id.it
      ^ ": "
      ^ Print.string_of_mixop mixop
      ^ Print.string_of_typ args
      |> print_endline;
      []
    )
  | _ -> assert false (* RelD expected *)

let prose_of_rel rel = match get_rel_kind rel with
  | ValidRel      -> proses_of_valid_rel rel
  | ValidInstrRel pphint -> proses_of_valid_instr_rel pphint rel
  | ValidWithRel pphint -> proses_of_valid_with_rel pphint rel
  | MatchRel      -> proses_of_match_rel rel
  | ConstRel      -> proses_of_const_rel rel
  | ValidConstRel pphint -> proses_of_valid_const_rel pphint rel
  | ValidWith2Rel pphint -> proses_of_valid_with2_rel pphint rel
  | DefaultableRel cmpop -> proses_of_defaultable_rel cmpop rel
  | OtherRel      -> proses_of_other_rel rel

let prose_of_rels = List.concat_map prose_of_rel

(** Entry for generating validation prose **)
let gen_validation_prose () =
  !Langs.validation_il |> prose_of_rels

let insert_state_binding algo =
  let open Al.Ast in
  let z_binding = ref 0 in
  let state_count = ref 0 in

  let count_state e =
    (match e.it with
    | VarE "z" -> state_count := !state_count + 1
    | _ -> ());
  in

  let check_z_binding i =
    (match i.it with
    | LetI (e, _) when e.it = VarE "z" -> z_binding := !z_binding + 1
    | _ -> ());
  in

  let walk_expr walker expr =
    if (!z_binding = 0 && !state_count = 0) then (
      count_state expr;
      Al.Walk.base_walker.walk_expr walker expr
    )
    else expr
  in
  let walk_instr walker instr =
    if (!z_binding = 0 && !state_count = 0) then (
      check_z_binding instr;
      Al.Walk.base_walker.walk_instr walker instr
    )
    else [instr]
  in
  let walker = { Al.Walk.base_walker with walk_expr; walk_instr } in
  let _ = walker.walk_algo walker algo in
  if !state_count > 0 then (
    match algo.it with
    | RuleA (name, anchor, params, body) ->
      let body = (letI (varE "z" ~note:stateT, getCurStateE () ~note:stateT)) :: body in
      { algo with it = RuleA (name, anchor, params, body) }
    | _ -> algo
  )
  else algo

(** Entry for generating execution prose **)
let gen_execution_prose () =
  List.map
    (fun algo ->
      let algo =
        algo
        |> insert_state_binding
        |> Il2al.Transpile.remove_exit
        |> Il2al.Transpile.remove_enter
        |> Il2al.Transpile.prosify_control_frame
      in
      AlgoD algo) !Langs.al

(** Main entry for generating prose **)
let gen_prose el il al =
  Langs.el := el;
  Langs.validation_il := extract_validation_il il;
  Langs.il := il;
  Langs.al := al;
  Prose_util.init_hintenv !Langs.el;

  let validation_prose = gen_validation_prose () in
  let execution_prose = gen_execution_prose () in

  validation_prose @ execution_prose
  |> Postprocess.postprocess_prose

(** Main entry for generating stringified prose **)
let gen_string cfg_latex cfg_prose el il al =
  let env_latex = Backend_latex.Render.env cfg_latex el in
  let prose = gen_prose el il al in
  let env_prose = Render.env cfg_prose [] [] env_latex in
  Render.render_prose env_prose prose

(** Main entry for generating prose file **)
let gen_file cfg_latex cfg_prose file el il al =
  let prose = gen_string cfg_latex cfg_prose el il al in
  let oc = Out_channel.open_text file in
  Fun.protect (fun () -> Out_channel.output_string oc prose)
    ~finally:(fun () -> Out_channel.close oc)
