open Prose
open Eq

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
  if Set.mem v frees then gen_new_var frees (v ^ "'") else v $ no_region

let flatten_rec def =
  match def.it with
  | Ast.RecD defs -> defs
  | _ -> [ def ]

let is_context_rel def =
  match def.it with
  | Ast.RelD (id, _, { it = TupT ((_, t) :: _); _}, _) ->
    Il.Print.string_of_typ t = "context" || id.it = "Expand"
  | _ -> false

let is_empty_context_rel def =
  match def.it with
  | Ast.RelD (_, [ { it = Atom.Turnstile; _} ] :: _, _, _) -> true
  | _ -> false

let extract_validation_il il =
  il
  |> List.concat_map flatten_rec
  |> List.filter (fun rel -> is_context_rel rel || is_empty_context_rel rel)

let atomize atom' = atom' $$ no_region % (Atom.info "")

let rel_has_id id rel =
  match rel.it with
  | Ast.RelD (id', _, _, _) -> id.it = id'.it
  | _ -> false

let extract_prose_hint Ast.{hintid; hintexp} =
  match hintid.it, hintexp.it with
  | "prose", TextE hint -> Some hint
  | _ -> None

let extract_rel_hint id =
  List.find_map (fun def ->
    match def.it with
    | Ast.HintD {it = RelH (id', hints); _} when id.it = id'.it ->
      List.find_map extract_prose_hint hints
    | _ -> None
  ) !Langs.il

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

(** End of helpers **)


(** There are currently 7 supported shape of a validation relation.
  * Extend this list upon introducing new shape of validation rule to the spec,
  * or shrink the list by merging and generalizing the shape.
  * 1. C? |- e : OK
  * 2. C? |- i : t (where i is a wasm instruction)
  * 3. C? |- e : e
  * 4. C? |- t <: t
  * 5. C? |- e : CONST
  * 6. C? |- e : e CONST
  * 7. C? |- e : e e
**)

type rel_kind =
  | ValidRel
  | ValidInstrRel
  | ValidWithRel
  | MatchRel
  | ConstRel
  | ValidConstRel
  | ValidWith2Rel
  | OtherRel

let get_rel_kind def =
  let open Atom in
  let valid_pattern = [[]; [atomize Turnstile]; [atomize Colon; atomize (Atom "OK")]] in
  let valid_with_pattern = [[]; [atomize Turnstile]; [atomize Colon]; []] in
  let match_pattern = [[]; [atomize Turnstile]; [atomize Sub]; []] in
  let const_pattern = [[]; [atomize Turnstile]; [atomize (Atom "CONST")]] in
  let valid_const_pattern = [[]; [atomize Turnstile]; [atomize Colon]; [atomize (Atom "CONST")]] in
  let valid_with2_pattern = [[]; [atomize Turnstile]; [atomize Colon]; []; []] in

  let has_instr_as_second typ =
    match typ.it with
    | Il.Ast.TupT [_; (_, t); _] -> Il.Print.string_of_typ t = "instr"
    | _ -> false
  in

  match def.it with
  | Ast.RelD (_, mixop, typ, _) ->
      let match_mixop pattern = Mixop.(eq mixop pattern || eq mixop (List.tl pattern)) in
      if match_mixop valid_pattern then
        ValidRel
      else if match_mixop valid_with_pattern then
        ( if has_instr_as_second typ then ValidInstrRel else ValidWithRel )
      else if match_mixop match_pattern then
        MatchRel
      else if match_mixop const_pattern then
        ConstRel
      else if match_mixop valid_const_pattern then
        ValidConstRel
      else if match_mixop valid_with2_pattern then
        ValidWith2Rel
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

let rec if_expr_to_instrs e =
  match e.it with
  | Ast.CmpE (`GtOp, _, {it = LenE ({it = DotE _; _} as arr); _}, index)
  | Ast.CmpE (`LtOp, _, index, {it = LenE ({it = DotE _; _} as arr); _}) ->
    let note =
      match arr.note.it with
      | IterT (t, _) -> t
      | _ -> arr.note
      in
    let e' = accE (exp_to_expr arr, Al.Ast.IdxP (exp_to_expr index) $ index.at) ~at:e.at ~note:note in
    [ IsDefinedS e' ]
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
  | _ -> [ CmpS (exp_to_expr e, `EqOp, boolE true ~note:boolT) ]


let ctxs = ref Map.empty

let init_ctxs () = ctxs := Map.empty

(* Hardcoded convention: Bind extension of a context to another context *)
let ctx_to_instr expr =
  let s = Al.Print.string_of_expr expr in
  match Map.find_opt s !ctxs with
  | Some ctx -> [], Some ctx
  | None ->
    let var = Al.Ast.VarE "C'" $$ expr.at % expr.note in
    ctxs := Map.add s var !ctxs;
    [ ContextS (var, expr) ], Some var

(* Hardcoded convention: "The rules implicitly assume a given context C" *)
let extract_context c =
  match c.it with
  | Al.Ast.VarE "C" -> [], None
  | Al.Ast.ExtE ({ it = VarE _; _ }, _ps, _e, _dir) -> ctx_to_instr c
  | _ -> [], Some c

let inject_ctx' c stmt =
  match stmt with
  | IsValidS (None, e, es) -> IsValidS (Some c, e, es)
  | IsConstS (None, e) -> IsConstS (Some c, e)
  | _ -> stmt

let inject_ctx c stmts =
  match extract_context c with
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
    let args = exp_to_argexpr e in
    ( match extract_rel_hint id with
    | Some hint ->
      (* Relation with prose hint *)
      [ RelS (hint, args) ]
    | None ->
      ( match get_rel_kind rel, args with
      (* contextless *)
      | ValidRel,      [e]         -> [ IsValidS (None, e, []) ]
      | ValidInstrRel, [e; t]      -> [ IsValidS (None, e, [t]) ]
      | ValidWithRel,  [e; e']     -> [ IsValidS (None, e, [e']) ]
      | MatchRel,      [t1; t2]    -> [ MatchesS (t1, t2) ]
      | ConstRel,      [e]         -> [ IsConstS (None, e) ]
      | ValidConstRel, [e; e']     -> [ IsValidS (None, e, [e']); IsConstS (None, e) ]
      | ValidWith2Rel, [e; e1; e2] -> [ IsValidS (None, e, [e1; e2]) ]
      (* context *)
      | ValidRel,      [c; e]         -> [ IsValidS (None, e, []) ] |> inject_ctx c
      | ValidInstrRel, [c; e; t]      -> [ IsValidS (None, e, [t]) ] |> inject_ctx c
      | ValidWithRel,  [c; e; e']     -> [ IsValidS (None, e, [e']) ] |> inject_ctx c
      | MatchRel,      [_; t1; t2]    -> [ MatchesS (t1, t2) ]
      | ConstRel,      [c; e]         -> [ IsConstS (None, e) ] |> inject_ctx c
      | ValidConstRel, [c; e; e']     -> [ IsValidS (None, e, [e']); IsConstS (None, e) ] |> inject_ctx c
      | ValidWith2Rel, [c; e; e1; e2] -> [ IsValidS (None, e, [e1; e2]) ] |> inject_ctx c
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

let extract_single_rule rule =
  match rule.it with
  | Ast.RuleD (_, _, _, exp, _) ->
    match exp.it with
    (* c? |- e : OK *)
    (* c? |- e CONST *)
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
    let fresh = gen_new_var frees "t" in
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
  let frees = (Free.free_rule rule).varid in
  { rule with it = match rule.it with
    | Ast.RuleD (id, bs, ops, exp, prems) ->
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
  IsValidS (None, exp_to_expr e, []))

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
let vrule_group_to_prose ((rule_name, rel_id, vrules): vrule_group) =
  prose_of_rules
    (rel_id.it ^ "/" ^ rule_name)
    (fun rule -> let winstr, t = extract_pair_rule rule in IsValidS (None, exp_to_expr winstr, [exp_to_expr t]))
    vrules
let proses_of_valid_instr_rel rel =
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
    |> List.map vrule_group_to_prose
  in

  let ungrouped_proses =
    groups
    |> List.filter (fun (_, _, rules) -> List.length rules > 1)
    |> List.concat_map (fun (_, id, rules) -> List.map (fun r -> (full_name_of_rule r, id, [r])) rules)
    |> List.map vrule_group_to_prose
  in

  grouped_proses @ ungrouped_proses

(** 3. C |- e : e **)
let proses_of_valid_with_rel = proses_of_rel (fun rule ->
  let e1, e2 = extract_pair_rule rule in
  IsValidS (None, exp_to_expr e1, [exp_to_expr e2]))

(** 4. C |- type <: type **)
let proses_of_match_rel = proses_of_rel (fun rule ->
  let e1, e2 = extract_pair_rule rule in
  MatchesS (exp_to_expr e1, exp_to_expr e2))

(** 5. C |- x CONST **)
let proses_of_const_rel = proses_of_rel (fun rule ->
  let e = extract_single_rule rule in
  IsConstS (None, exp_to_expr e))

(** 6. C |- e : e CONST **)
let proses_of_valid_const_rel _def = [] (* Do not generate prose *)

(** 7. C |- e : e e **)
let proses_of_valid_with2_rel = proses_of_rel (fun rule ->
  let e1, e2, e3 = extract_triplet_rule rule in
  IsValidS (None, exp_to_expr e1, [exp_to_expr e2; exp_to_expr e3]))

(** 8. Others **)
let proses_of_other_rel rel = ( match rel.it with
  | Ast.RelD (rel_id, mixop, args, _) ->
    "Untranslated relation " ^ rel_id.it ^ ": " ^ Print.string_of_mixop mixop ^ Print.string_of_typ args |> print_endline;
  | _ -> ());
  []

let prose_of_rel rel = match get_rel_kind rel with
  | ValidRel      -> proses_of_valid_rel rel
  | ValidInstrRel -> proses_of_valid_instr_rel rel
  | ValidWithRel  -> proses_of_valid_with_rel rel
  | MatchRel      -> proses_of_match_rel rel
  | ConstRel      -> proses_of_const_rel rel
  | ValidConstRel -> proses_of_valid_const_rel rel
  | ValidWith2Rel -> proses_of_valid_with2_rel rel
  | OtherRel      -> proses_of_other_rel rel

let prose_of_rels = List.concat_map prose_of_rel

(** Postprocess of generated prose **)
let unify_either stmts =
  let f stmt =
    match stmt with
    | EitherS sss ->
      let unified, bodies = List.fold_left (fun (commons, stmtss) s ->
        let pairs = List.map (List.partition (eq_stmt s)) stmtss in
        let fsts = List.map fst pairs in
        let snds = List.map snd pairs in
        if List.for_all (fun l -> List.length l = 1) fsts then
          s :: commons, snds
        else
          commons, stmtss
      ) ([], sss) (List.hd sss) in
      let unified = List.rev unified in
      unified @ [ EitherS bodies ]
    | _ -> [stmt]
  in
  let rec walk stmts = List.concat_map walk' stmts
  and walk' stmt =
    f stmt
    |> List.map (function
      | IfS (e, sl) -> IfS (e, walk sl)
      | ForallS (vars, sl) -> ForallS (vars, walk sl)
      | EitherS sll -> EitherS (List.map walk sll)
      | s -> s
    )
  in
  walk stmts

let postprocess_prose defs =
  List.map (fun def ->
    match def with
    | RuleD (anchor, i, il) ->
      let new_il = unify_either il in
      RuleD (anchor, i, new_il)
    | AlgoD _ -> def
  ) defs


(** Entry for generating validation prose **)
let gen_validation_prose () =
  !Langs.validation_il |> prose_of_rels

let get_state_arg_opt f =
  let arg = ref (Al.Ast.TypA (Il.Ast.BoolT $ no_region)) in
  let id = f $ no_region in
  match Il.Env.find_opt_def (Il.Env.env_of_script !Langs.il) id with
  | Some (params, _, _) ->
    let param_state = List.find_opt (
      fun param ->
        match param.it with
        | Il.Ast.ExpP (id, ({ it = VarT ({ it = "state"; _ }, _); _ } as typ)) ->
          arg := ExpA ((Al.Ast.VarE "z") $$ id.at % typ);
          true
        | _ -> false
    ) params in
    if Option.is_some param_state then (
      let param_state = Option.get param_state in
      Some {param_state with it = !arg}
    ) else None
  | None ->
    None

let recover_state algo =

  let recover_state_expr expr =
    match expr.it with
    | Al.Ast.CallE (f, args) ->
      let arg_state = get_state_arg_opt f in
      if Option.is_some arg_state then
        let answer = {expr with it = Al.Ast.CallE (f, Option.get arg_state :: args)} in
        answer
      else expr
    | _ -> expr
  in

  let recover_state_instr instr =
    match instr.it with
    | Al.Ast.PerformI (f, args) ->
      let arg_state = get_state_arg_opt f in
      if Option.is_some arg_state then
        let answer = {instr with it = Al.Ast.PerformI (f, Option.get arg_state :: args)} in
        [answer]
      else [instr]
    | _ -> [instr]
  in

  let walk_expr walker expr =
    let expr1 = recover_state_expr expr in
    Al.Walk.base_walker.walk_expr walker expr1
  in
  let walk_instr walker instr =
    let instr1 = recover_state_instr instr in
    List.concat_map (Al.Walk.base_walker.walk_instr walker) instr1
  in
  let walker = { Al.Walk.base_walker with
    walk_expr = walk_expr;
    walk_instr = walk_instr;
  }
  in
  let algo' = walker.walk_algo walker algo in
  algo'

(** Entry for generating execution prose **)
let gen_execution_prose () =
  List.map
    (fun algo ->
      let algo =
        algo
        |> recover_state
        |> Il2al.Transpile.insert_state_binding
        |> Il2al.Transpile.remove_exit
        |> Il2al.Transpile.remove_enter
      in
      AlgoD algo) !Langs.al

(** Main entry for generating prose **)
let gen_prose el il al =
  Langs.el := el;
  Langs.validation_il := extract_validation_il il;
  Langs.il := il;
  Langs.al := al;

  let validation_prose = gen_validation_prose () in
  let execution_prose = gen_execution_prose () in

  validation_prose @ execution_prose
  |> postprocess_prose

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
