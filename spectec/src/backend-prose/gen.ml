open Prose
open Eq

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

(* Helpers *)

let flatten_rec def =
  match def.it with
  | Ast.RecD defs -> defs
  | _ -> [ def ]

let is_context_rel def =
  match def.it with
  | Ast.RelD (_, _, { it = TupT ((_, t) :: _); _}, _) ->
    Il.Print.string_of_typ t = "context"
  | _ -> false
let is_empty_context_rel def =
  match def.it with
  | Ast.RelD (_, [ { it = El.Atom.Turnstile; _} ] :: _, _, _) -> true
  | _ -> false

let preprocess_il il =
  il
  |> List.concat_map flatten_rec

let atomize atom' = atom' $$ no_region % (El.Atom.info "")

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

(* CASE (?(())) ~> CASE
   CASE (?()) ~> () *)
let recover_optional_singleton_constructor e =
  match e.it with
  | Al.Ast.CaseE ([[atom]; [{it = El.Atom.Quest; _}]], [{it = OptE opt; _ }]) ->
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
      [[]; [{it = El.Atom.ArrowSub; _} as arrow]; []; []],
      [lhs; {it = ListE []; _}; rhs]
    ) ->
    let it = Al.Ast.CaseE ([[];[{arrow with it = El.Atom.Arrow}];[]], [lhs; rhs]) in
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
  let open El.Atom in
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
  | Ast.CmpE (op, e1, e2) ->
    let op = cmpop_to_cmpop op in
    let e1 = exp_to_expr e1 in
    let e2 = exp_to_expr e2 in
    [ match e2.it with LenE _ -> CmpS (e2, swap op, e1) | _ -> CmpS (e1, op, e2) ]
  | Ast.BinE (Ast.AndOp, e1, e2) ->
    if_expr_to_instrs e1 @ if_expr_to_instrs e2
  | Ast.BinE (Ast.OrOp, e1, e2) ->
    let cond1 = if_expr_to_instrs e1 in
    let cond2 = if_expr_to_instrs e2 in
    [ match cond1, cond2 with
      | [ CmpS ({ it = IterE ({ it = VarE name; _ }, (Opt, _)); _ }, Eq, { it = OptE None; _ }) ], _ ->
        (* ~P \/ Q is equivalent to P -> Q *)
        IfS (isDefinedE (varE name ~note:no_note) ~note:no_note, cond2)
      | [ CmpS (e1, Eq, e2) ], [ CmpS (e3, Eq, e4) ] when Al.Eq.eq_expr e1 e3 ->
        CondS (memE (e1, listE [e2; e4] ~note:(iterT e2.note List)) ~note:boolT)
      | _ ->
        CondS (exp_to_expr e)]
  | Ast.BinE (Ast.EquivOp, _, _)
  | Ast.MemE _ ->
      [ CondS (exp_to_expr e) ]
  | _ ->
      [ CmpS (exp_to_expr e, Eq, boolE true ~note:boolT) ]

let rec prem_to_instrs prem =
  match prem.it with
  | Ast.LetPr (e1, e2, _) ->
    [ LetS (exp_to_expr e1, exp_to_expr e2) ]
  | Ast.IfPr e ->
    if_expr_to_instrs e
  | Ast.RulePr (id, _, e) ->
    let rel =
      match List.find_opt (rel_has_id id) !Langs.il with
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
      | ValidRel,      [c; e]         -> [ IsValidS (try_omit c, e, []) ]
      | ValidInstrRel, [c; e; t]      -> [ IsValidS (try_omit c, e, [t]) ]
      | ValidWithRel,  [c; e; e']     -> [ IsValidS (try_omit c, e, [e']) ]
      | MatchRel,      [_; t1; t2]    -> [ MatchesS (t1, t2) ]
      | ConstRel,      [c; e]         -> [ IsConstS (try_omit c, e) ]
      | ValidConstRel, [c; e; e']     -> [ IsValidS (try_omit c, e, [e']); IsConstS (try_omit c, e) ]
      | ValidWith2Rel, [c; e; e1; e2] -> [ IsValidS (try_omit c, e, [e1; e2]) ]
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

type vrule_group =
  string * Ast.id * (Ast.exp * Ast.exp * Ast.prem list * Ast.bind list) list

(** Main translation for typing rules **)
let vrule_group_to_prose ((rule_name, rel_id, vrules): vrule_group) =
  let (winstr, t, _prems, _tenv) = vrules |> List.hd in

  (* anchor *)
  let anchor = rel_id.it ^ "/" ^ rule_name in
  (* expr *)
  let expr = exp_to_expr winstr in
  (* concl *)
  let concl = IsValidS (None, expr, [exp_to_expr t]) in
  (* prems *)
  let prems =
    vrules
    |> List.map (fun (_, _, prems, _) -> prems)
    |> List.map (List.concat_map prem_to_instrs)
    |> (function
        | [ stmts ] -> stmts
        | stmtss -> [ EitherS stmtss ])
  in

  (* Predicate *)
  RuleD (anchor, expr, concl, prems)

let rec extract_vrules def =
  match def.it with
  | Ast.RecD defs -> List.concat_map extract_vrules defs
  | Ast.RelD (id, _, _, rules) when id.it = "Instr_ok" ->
      List.map (fun rule -> (id, rule)) rules
  | _ -> []

let pack_single_rule rule =
  match rule.it with
  | Ast.RuleD (_, tenv, _, exp, prems) ->
    match exp.it with
    (* c? |- e : OK *)
    (* c? |- e CONST *)
    | Ast.TupE [ e ] -> (e, prems, tenv)
    | Ast.TupE [ _; e ] -> (e, prems, tenv)
    | _ -> (exp, prems, tenv)

let pack_pair_rule rule =
  match rule.it with
  | Ast.RuleD (_, tenv, _, exp, prems) ->
    match exp.it with
    (* c? |- e1 <: e2 *)
    (* c? |- e : t *)
    (* c? |- e : e *)
    (* c? |- e : e CONST *)
    | Ast.TupE [ e1; e2 ] -> (e1, e2, prems, tenv)
    | Ast.TupE [ _; e1; e2 ] -> (e1, e2, prems, tenv)
    | _ -> error exp.at
      (Print.string_of_exp exp
      |> Printf.sprintf "exp `%s` cannot be a rule for the double-argument relation")

let pack_triplet_rule rule =
  match rule.it with
  | Ast.RuleD (_, tenv, _, exp, prems) ->
    match exp.it with
    (* c? |- e : e e *)
    | Ast.TupE [ e1; e2; e3 ] -> (e1, e2, e3, prems, tenv)
    | Ast.TupE [ _; e1; e2; e3 ] -> (e1, e2, e3, prems, tenv)
    | _ -> error exp.at
      (Print.string_of_exp exp
      |> Printf.sprintf "exp `%s` cannot be a rule for the triple-argument relation")


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
      let group = (rule_name, rel_id, List.map pack_pair_rule (rule :: same_rules |> Il2al.Unify.unify_rules)) in
      group :: group_vrules diff_rules

(* TODO: The codes below are too repetitive. Should be factored. *)

(** 1. C |- expr : OK *)
let prose_of_valid_rules rel_id rules =
  let rule = List.hd rules in
  let (e, _, _) = pack_single_rule rule in

  (* anchor *)
  let anchor = rel_id.it in
  (* expr *)
  let expr = exp_to_expr e in
  (* concl *)
  let concl = IsValidS (None, expr, []) in
  (* prems *)
  let prems = (
    rules
    |> List.map pack_single_rule
    |> List.map (fun (_, prems, _) -> prems)
    |> List.map (List.concat_map prem_to_instrs)
    |> (function
        | [ stmts ] -> stmts
        | stmtss -> [ EitherS stmtss ])
  ) in

  RuleD (anchor, expr, concl, prems)


let prose_of_valid_rel def =
  match def.it with
  | Ast.RelD (rel_id, _, _, rules) -> prose_of_valid_rules rel_id (Il2al.Unify.unify_rules rules)
  | _ -> assert false

(** 2. C |- instr : type **)
let proses_of_valid_instr_rel rel =
  rel
  |> extract_vrules
  |> group_vrules
  |> List.map vrule_group_to_prose

(** 3. C |- e : e **)
let prose_of_valid_with_rules rel_id rules =
  let rule = List.hd rules in
  let (e1, e2, _, _) = pack_pair_rule rule in

  (* anchor *)
  let anchor = rel_id.it in
  (* expr *)
  let expr = exp_to_expr e1 in
  (* concl *)
  let concl = IsValidS (None, expr, [exp_to_expr e2]) in
  (* prems *)
  let prems = (
    rules
    |> List.map pack_pair_rule
    |> List.map (fun (_, _, prems, _) -> prems)
    |> List.map (List.concat_map prem_to_instrs)
    |> (function
        | [ stmts ] -> stmts
        | stmtss -> [ EitherS stmtss ])
  ) in

  RuleD (anchor, expr, concl, prems)

let prose_of_valid_with_rel def =
  match def.it with
  | Ast.RelD (rel_id, _, _, rules) -> prose_of_valid_with_rules rel_id (Il2al.Unify.unify_rules rules)
  | _ -> assert false

(** 4. C |- type <: type **)
let prose_of_match_rules rel_id rules =
  let rule = List.hd rules in
  let (e1, e2, _, _) = pack_pair_rule rule in

  (* anchor *)
  let anchor = rel_id.it in
  (* expr *)
  let expr = exp_to_expr e1 in
  (* concl *)
  let concl = MatchesS (expr, exp_to_expr e2) in
  (* prems *)
  let prems = (
    rules
    |> List.map pack_pair_rule
    |> List.map (fun (_, _, prems, _) -> prems)
    |> List.map (List.concat_map prem_to_instrs)
    |> (function
        | [ stmts ] -> stmts
        | stmtss -> [ EitherS stmtss ])
  ) in

  RuleD (anchor, expr, concl, prems)

let prose_of_match_rel def =
  match def.it with
  | Ast.RelD (rel_id, _, _, rules) -> prose_of_match_rules rel_id (Il2al.Unify.unify_rules rules)
  | _ -> assert false


(** 5. C |- x CONST **)
let prose_of_const_rules rel_id rules =
  let rule = List.hd rules in
  let (e, _, _) = pack_single_rule rule in

  (* anchor *)
  let anchor = rel_id.it in
  (* expr *)
  let expr = exp_to_expr e in
  (* concl *)
  let concl = IsConstS (None, expr) in
  (* prems *)
  let prems = (
    rules
    |> List.map pack_single_rule
    |> List.map (fun (_, prems, _) -> prems)
    |> List.map (List.concat_map prem_to_instrs)
    |> (function
        | [ stmts ] -> stmts
        | stmtss -> [ EitherS stmtss ])
  ) in

  RuleD (anchor, expr, concl, prems)

let prose_of_const_rel def =
  match def.it with
  | Ast.RelD (rel_id, _, _, rules) -> prose_of_const_rules rel_id (Il2al.Unify.unify_rules rules)
  | _ -> assert false

(** 6. C |- e : e CONST **)
let proses_of_valid_const_rel _def = [] (* Do not generate prose *)

(** 7. C |- e : e e **)
let prose_of_valid_with2_rules rel_id rules =
  let rule = List.hd rules in
  let (e1, e2, e3, _, _) = pack_triplet_rule rule in

  (* anchor *)
  let anchor = rel_id.it in
  (* expr *)
  let expr = exp_to_expr e1 in
  (* concl *)
  let concl = IsValidS (None, expr, [exp_to_expr e2; exp_to_expr e3]) in
  (* prems *)
  let prems = (
    rules
    |> List.map pack_triplet_rule
    |> List.map (fun (_, _, _, prems, _) -> prems)
    |> List.map (List.concat_map prem_to_instrs)
    |> (function
        | [ stmts ] -> stmts
        | stmtss -> [ EitherS stmtss ])
  ) in

  RuleD (anchor, expr, concl, prems)

let prose_of_valid_with2_rel def =
  match def.it with
  | Ast.RelD (rel_id, _, _, rules) -> prose_of_valid_with2_rules rel_id (Il2al.Unify.unify_rules rules)
  | _ -> assert false

(** 8. Others **)
let proses_of_other_rel rel = ( match rel.it with
  | Ast.RelD (rel_id, mixop, args, _) ->
    "Untranslated relation " ^ rel_id.it ^ ": " ^ Print.string_of_mixop mixop ^ Print.string_of_typ args |> print_endline;
  | _ -> ());
  []

let prose_of_rel rel = match get_rel_kind rel with
  | ValidRel      -> [ prose_of_valid_rel rel ]
  | ValidInstrRel -> proses_of_valid_instr_rel rel
  | ValidWithRel  -> [ prose_of_valid_with_rel rel ]
  | MatchRel      -> [ prose_of_match_rel rel ]
  | ConstRel      -> [ prose_of_const_rel rel ]
  | ValidConstRel -> proses_of_valid_const_rel rel
  | ValidWith2Rel -> [ prose_of_valid_with2_rel rel ]
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
    | RuleD (anchor, e, i, il) ->
      let new_il = unify_either il in
      RuleD (anchor, e, i, new_il)
    | AlgoD _ -> def
  ) defs


(** Entry for generating validation prose **)
let gen_validation_prose () =
  !Langs.il
  |> List.filter (fun rel -> is_context_rel rel || is_empty_context_rel rel)
  |> prose_of_rels

(** Entry for generating execution prose **)
let gen_execution_prose () =
  List.map
    (fun algo ->
      let algo =
        algo
        |> Il2al.Transpile.recover_state
        |> Il2al.Transpile.insert_state_binding
        |> Il2al.Transpile.remove_exit
        |> Il2al.Transpile.remove_enter
      in
      AlgoD algo) !Langs.al

(** Main entry for generating prose **)
let gen_prose el il al =
  Langs.el := el;
  Langs.il := preprocess_il il;
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
