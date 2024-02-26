open Al
open Ast
open Free
open Al_util
open Printf
open Backend_interpreter.Manual
open Util
open Source

module Il = struct include Il include Ast include Print end


(* Errors *)

let error at msg = Error.error at "translate" msg

let error_exp exp typ =
  error exp.at (sprintf "Invalid exp `%s` to be %s" (Il.Print.string_of_exp exp) typ)

(* Helpers *)

let is_state expr = match expr.it with
  | Il.VarE z ->
    z.it = "z" || String.starts_with ~prefix:"z'" z.it || String.starts_with ~prefix:"z_" z.it
  | _ -> false

let is_store expr = match expr.it with
  | Il.VarE s ->
    s.it = "s" || String.starts_with ~prefix:"s'" s.it || String.starts_with ~prefix:"s_" s.it
  | _ -> false

let is_frame expr = match expr.it with
  | Il.VarE f ->
    f.it = "f" || String.starts_with ~prefix:"f'" f.it || String.starts_with ~prefix:"f_" f.it
  | _ -> false

let is_list expr = match expr.it with
  | Il.CatE _ | Il.ListE _ -> true
  | _ -> false

(* transform z; e into e *)
let split_state e =
  let state_instr = [ letI (varE "f", getCurFrameE ()) ] in
  match e.it with
  (* z; e *)
  | Il.MixE ([ []; [ Il.Semicolon ]; [ Il.Star ] ], { it = Il.TupE [ state; e' ]; _ })
    when is_state state -> state_instr, e'
  (* s; f; e *)
  | Il.MixE
    ( [ []; [ Il.Semicolon ]; [ Il.Star ] ],
      { it = Il.TupE [ { it = Il.MixE (
        [[]; [ Il.Semicolon ]; []],
        { it = Il.TupE [ store; frame ]; _ }
      ); _ }; e' ]; _ } )
    when is_store store && is_frame frame -> state_instr, e'
  | _ -> [], e

let rec flatten e =
  match e.it with
  | Il.CatE (e1, e2) -> flatten e1 @ flatten e2
  | Il.ListE es -> List.concat_map flatten es
  | _ -> [ e ]

let flatten_rec def =
  match def.it with
  | Il.RecD defs -> defs
  | _ -> [ def ]

let get_params winstr =
  match winstr.it with
  | Il.CaseE (_, { it = Il.TupE exps; _ }) -> exps
  | Il.CaseE (_, exp) -> [ exp ]
  | _ -> error_exp winstr "a valid wasm instruction"

let lhs_of_rgroup rgroup =
  let (lhs, _, _) = List.hd rgroup in
  lhs

let name_of_rule rule =
  let Il.RuleD (id1, _, _, _, _) = rule.it in
  String.split_on_char '-' id1.it |> List.hd

let lower = String.lowercase_ascii
let upper = String.uppercase_ascii
let kwd name note = name, Il.Print.string_of_typ note
let wrap typ e = e $$ no_region % typ

let top = Il.VarT ("TOP" $ no_region, []) $ no_region
let hole = Il.TextE "_" |> wrap top


(* `Il.iter` -> `iter` *)
let rec translate_iter = function
  | Il.Opt -> Opt
  | Il.List1 -> List1
  | Il.List -> List
  | Il.ListN (e, id_opt) ->
    ListN (translate_exp e, Option.map (fun id -> id.it) id_opt)

(* `Il.exp` -> `expr` *)
and translate_exp exp =
  let at = exp.at in
  match exp.it with
  | Il.NatE n -> numE n ~at:at
  | Il.BoolE b -> boolE b ~at:at
  (* List *)
  | Il.LenE inner_exp -> lenE (translate_exp inner_exp) ~at:at
  | Il.ListE exps -> listE (List.map translate_exp exps) ~at:at
  | Il.IdxE (exp1, exp2) ->
    accE (translate_exp exp1, idxP (translate_exp exp2)) ~at:at
  | Il.SliceE (exp1, exp2, exp3) ->
    accE (translate_exp exp1, sliceP (translate_exp exp2, translate_exp exp3)) ~at:at
  | Il.CatE (exp1, exp2) -> catE (translate_exp exp1, translate_exp exp2) ~at:at
  (* Variable *)
  | Il.VarE id -> varE id.it ~at:at
  | Il.SubE ({ it = Il.VarE id; _}, { it = VarT (t, _); _ }, _) -> subE (id.it, t.it) ~at:at
  | Il.SubE (inner_exp, _, _) -> translate_exp inner_exp
  | Il.IterE (inner_exp, (iter, ids)) ->
    let names = List.map (fun id -> id.it) ids in
    iterE (translate_exp inner_exp, names, translate_iter iter) ~at:at
  (* property access *)
  | Il.DotE (inner_exp, Atom p) ->
    accE (translate_exp inner_exp, dotP (kwd p inner_exp.note)) ~at:at
  (* conacatenation of records *)
  | Il.CompE (inner_exp, { it = Il.StrE expfields; _ }) ->
    (* assumption: CompE is only used for prepending to validation context *)
    let nonempty e = (match e.it with ListE [] | OptE None -> false | _ -> true) in
    List.fold_left
      (fun acc extend_exp -> match extend_exp with
      | Il.Atom name, fieldexp ->
        let extend_expr = translate_exp fieldexp in
        if nonempty extend_expr then
          extE (acc, [ dotP (kwd name inner_exp.note) ], extend_expr, Front) ~at:at
        else
          acc
      | _ -> error_exp exp "AL record expression")
      (translate_exp inner_exp) expfields
  (* extension of record field *)
  | Il.ExtE (base, path, v) -> extE (translate_exp base, translate_path path, translate_exp v, Back) ~at:at
  (* update of record field *)
  | Il.UpdE (base, path, v) -> updE (translate_exp base, translate_path path, translate_exp v) ~at:at
  (* Binary / Unary operation *)
  | Il.UnE (op, exp) ->
    let exp' = translate_exp exp in
    let op = match op with
    | Il.NotOp -> NotOp
    | Il.MinusOp _ -> MinusOp
    | _ -> error_exp exp "AL unary expression"
    in
    unE (op, exp') ~at:at
  | Il.BinE (op, exp1, exp2) ->
    let lhs = translate_exp exp1 in
    let rhs = translate_exp exp2 in
    let op =
      match op with
      | Il.AddOp _ -> AddOp
      | Il.SubOp _ -> SubOp
      | Il.MulOp _ -> MulOp
      | Il.DivOp _ -> DivOp
      | Il.ExpOp _ -> ExpOp
      | Il.AndOp -> AndOp
      | Il.OrOp -> OrOp
      | Il.ImplOp -> ImplOp
      | Il.EquivOp -> EquivOp
    in
    binE (op, lhs, rhs) ~at:at
  | Il.CmpE (op, exp1, exp2) ->
    let lhs = translate_exp exp1 in
    let rhs = translate_exp exp2 in
    let compare_op =
      match op with
      | Il.EqOp -> EqOp
      | Il.NeOp -> NeOp
      | Il.LtOp _ -> LtOp
      | Il.GtOp _ -> GtOp
      | Il.LeOp _ -> LeOp
      | Il.GeOp _ -> GeOp
    in
    binE (compare_op, lhs, rhs) ~at:at
  (* CaseE *)
  | Il.CaseE (Il.Atom cons, argexp) -> caseE (kwd cons exp.note, translate_argexp argexp) ~at:at
  (* Tuple *)
  | Il.TupE exps -> tupE (List.map translate_exp exps) ~at:at
  (* Call *)
  | Il.CallE (id, args) -> callE (id.it, translate_args args) ~at:at
  (* Record expression *)
  | Il.StrE expfields ->
    let f acc = function
      | Il.Atom name, fieldexp ->
        let expr = translate_exp fieldexp in
        Record.add (kwd name exp.note) expr acc
      | _ -> error_exp exp "AL record expression"
    in
    let record = List.fold_left f Record.empty expfields in
    strE record ~at:at
  | Il.MixE (op, e) -> (
    let exps =
      match e.it with
      | TupE exps -> exps
      | _ -> [ e ]
    in
    match (op, exps) with
    | [ []; []; [] ], [ e1; e2 ]
    | [ []; [ Il.Semicolon ]; [] ], [ e1; e2 ]
    | [ []; [ Il.Semicolon ]; [ Il.Star ] ], [ e1; e2 ]
    | [ [ Il.LBrack ]; [ Il.Dot2 ]; [ Il.RBrack ]], [ e1; e2 ] ->
      tupE [ translate_exp e1; translate_exp e2 ] ~at:at
    | [ []; [ Il.Star; atom ]; [ Il.Star ] ], [ e1; e2 ]
    | [ []; [ atom ]; [] ], [ e1; e2 ] ->
      infixE (translate_exp e1, Il.Print.string_of_atom atom, translate_exp e2) ~at:at
    | [ []; [ Il.Arrow ]; [ Il.Star ]; [] ], [ e1; e2; e3 ] -> (* HARDCODE *)
      infixE (translate_exp e1, "->", catE (translate_exp e2, translate_exp e3)) ~at:at
    (* Constructor *)
    (* TODO: Need a better way to convert these CaseE into ConstructE *)
    | [ [ Il.Atom "FUNC" ]; []; [ Il.Star ]; [] ], _ ->
      caseE (("FUNC", "func"), List.map translate_exp exps) ~at:at
    | [ [ Il.Atom "OK" ] ], [] ->
      caseE (("OK", "datatype"), []) ~at:at
    | [ [ Il.Atom "MUT" ]; [ Il.Quest ]; [] ],
      [ { it = Il.OptE (Some { it = Il.TupE []; _ }); _}; t ] ->
      tupE [ caseE (("MUT", "globaltype"), []); translate_exp t ] ~at:at
    | [ [ Il.Atom "MUT" ]; [ Il.Quest ]; [] ],
      [ { it = Il.IterE ({ it = Il.TupE []; _ }, (Il.Opt, [])); _}; t ] ->
      tupE [ iterE (varE "mut", ["mut"], Opt); translate_exp t ] ~at:at
    | [ Il.Atom "MODULE" ] :: _, el ->
      caseE (("MODULE", "module"), List.map translate_exp el) ~at:at
    | [ [ Il.Atom "IMPORT" ]; []; []; [] ], el ->
      caseE (("IMPORT", "import"), List.map translate_exp el) ~at:at
    | [ [ Il.Atom "GLOBAL" ]; []; [] ], el ->
      caseE (("GLOBAL", "global"), List.map translate_exp el) ~at:at
    | [ Il.Atom "TABLE" ] :: _, el ->
      caseE (("TABLE", "table"), List.map translate_exp el) ~at:at
    | [ [ Il.Atom "MEMORY" ]; [] ], el ->
      caseE (("MEMORY", "mem"), List.map translate_exp el) ~at:at
    | [ []; [ Il.Atom "I8" ] ], el ->
      caseE (("I8", "memtype"), List.map translate_exp el) ~at:at
    | [ [ Il.Atom "ELEM" ]; []; [ Il.Star ]; [] ], el ->
      caseE (("ELEM", "elem"), List.map translate_exp el) ~at:at
    | [ [ Il.Atom "DATA" ]; [ Il.Star ]; [] ], el ->
      caseE (("DATA", "data"), List.map translate_exp el) ~at:at
    | [ [ Il.Atom "START" ]; [] ], el ->
      caseE (("START", "start"), List.map translate_exp el) ~at:at
    | [ [ Il.Atom "EXPORT" ]; []; [] ], el ->
      caseE (("EXPORT", "export"), List.map translate_exp el) ~at:at
    | [ [ Il.Atom "NULL" ]; [ Il.Quest ] ], el ->
      caseE (("NULL", "nul"), List.map translate_exp el) ~at:at
    | [ Il.Atom name ] :: ll, el
      when List.for_all (fun l -> l = [] || l = [ Il.Star ] || l = [ Il.Quest ]) ll ->
      caseE ((name, lower name), List.map translate_exp el) ~at:at
    | _ -> yetE (Il.Print.string_of_exp exp) ~at:at)
  | Il.OptE inner_exp -> optE (Option.map translate_exp inner_exp) ~at:at
  (* Yet *)
  | _ -> yetE (Il.Print.string_of_exp exp) ~at:at

(* `Il.exp` -> `expr list` *)
and translate_argexp exp =
  match exp.it with
  | Il.TupE el -> List.map translate_exp el
  | _ -> [ translate_exp exp ]

(* `Il.arg list` -> `expr list` *)
and translate_args args = List.concat_map ( fun arg ->
  match arg.it with
  | Il.ExpA el -> [ translate_exp el ]
  | Il.TypA _ -> [] ) args

(* `Il.path` -> `path list` *)
and translate_path path =
  let rec translate_path' path =
    let at = path.at in
    match path.it with
    | Il.RootP -> []
    | Il.IdxP (p, e) -> (translate_path' p) @ [ idxP (translate_exp e) ~at:at ]
    | Il.SliceP (p, e1, e2) -> (translate_path' p) @ [ sliceP (translate_exp e1, translate_exp e2) ~at:at ]
    | Il.DotP (p, Atom a) ->
      (translate_path' p) @ [ dotP (kwd a p.note) ~at:at ]
    | _ -> assert false
  in
  translate_path' path

let insert_assert exp =
  let at = exp.at in
  match exp.it with
  | Il.CaseE (Il.Atom "FRAME_", _) -> assertI (topFrameE ()) ~at:at
  | Il.IterE (_, (Il.ListN (e, None), _)) ->
    assertI (topValuesE (translate_exp e) ~at:at) ~at:at
  | Il.CaseE (Il.Atom "LABEL_", { it = Il.TupE [ _n; _instrs; _vals ]; _ })
    -> assertI (topLabelE () ~at:at) ~at:at
  | Il.CaseE ( Il.Atom "CONST", { it = Il.TupE (ty :: _); _ })
    -> assertI (topValueE (Some (translate_exp ty)) ~at:at) ~at:at
  | _ -> assertI (topValueE None) ~at:at

let insert_pop e = [ insert_assert e; popI (translate_exp e) ~at:e.at ]

let insert_nop instrs = match instrs with [] -> [ nopI () ] | _ -> instrs


(* Assume that only the iter variable is unbound *)
let is_unbound vars e =
  match e.it with
  | Il.IterE (_, (ListN (e', _), _))
    when not (Il.Free.subset (Il.Free.free_exp e') vars) -> true
  | _ -> false

let get_unbound e =
  match e.it with
  | Il.IterE (_, (ListN ({ it = VarE id; _ }, _), _)) -> id.it
  | _ -> error_exp e "Invalid deferred expression"


let rec translate_rhs exp =
  let at = exp.at in
  match exp.it with
  (* Trap *)
  | Il.CaseE (Atom "TRAP", _) -> [ trapI () ~at:at ]
  (* Execute instrs
   * TODO: doing this based on variable name is too ad-hoc. Need smarter way. *)
  | Il.IterE ({ it = VarE id; _ }, (Il.List, _))
  | Il.IterE ({ it = SubE ({ it = VarE id; _ }, _, _); _}, (Il.List, _))
    when String.starts_with ~prefix:"instr" id.it ->
    [ executeseqI (translate_exp exp) ~at:at ]
  | Il.IterE ({ it = CaseE (Atom id', _); note = note; _ }, (Opt, [ id ]))
    when id' = "CALL" ->
    let new_name = varE (id.it ^ "_0") in
    [ ifI (isDefinedE (varE id.it),
      [
        letI (optE (Some new_name), varE id.it) ~at:at;
        executeI (caseE (kwd id' note, [ new_name ])) ~at:at
      ],
      []) ~at:at ]
  (* Push *)
  | Il.SubE _ | IterE _ -> [ pushI (translate_exp exp) ~at:at ]
  | Il.CaseE (Atom id, _) when List.mem id [
      (* TODO: Consider automating this *)
      "CONST";
      "VCONST";
      "REF.I31_NUM";
      "REF.STRUCT_ADDR";
      "REF.ARRAY_ADDR";
      "REF.FUNC_ADDR";
      "REF.HOST_ADDR";
      "REF.EXTERN";
      "REF.NULL"
    ] -> [ pushI (translate_exp exp) ~at:at ]
  (* multiple rhs' *)
  | Il.CatE (e1, e2) -> translate_rhs e1 @ translate_rhs e2
  | Il.ListE es -> List.concat_map translate_rhs es
  (* Frame *)
  | Il.CaseE (
      Il.Atom "FRAME_",
      { it =
        Il.TupE [
          { it = Il.VarE arity; _ };
          { it = Il.VarE fid; _ };
          { it = Il.ListE [ le ]; _ };
        ];
        _;
      }
    ) ->
    [
      letI (varE "F", frameE (Some (varE arity.it), varE fid.it)) ~at:at;
      enterI (varE "F", listE ([caseE (("FRAME_", "admininstr"), [])]), translate_rhs le) ~at:at;
    ]
  (* TODO: Label *)
  | Il.CaseE (
      Atom "LABEL_",
      { it = Il.TupE [ arity; e1; e2 ]; _; }
    ) ->
    (
    let le = labelE (translate_exp arity, translate_exp e1) ~at:at in
    let at = e2.at in
    match e2.it with
    | Il.CatE (ve, ie) ->
      [
        letI (varE "L", le) ~at:at;
        enterI (varE "L", catE (translate_exp ie, listE ([caseE (("LABEL_", "admininstr"), [])])), [pushI (translate_exp ve)]) ~at:at;
      ]
    | _ ->
      [
        letI (varE "L", le) ~at:at;
        enterI (varE "L", catE(translate_exp e2, listE ([caseE (("LABEL_", "admininstr"), [])])), []) ~at:at;
      ]
    )
  (* Execute instr *)
  | Il.CaseE (Atom atomid, argexp) ->
      [ executeI (caseE (kwd atomid exp.note, translate_argexp argexp)) ~at:at ]
  | Il.MixE
    ( [ []; [ Il.Semicolon ]; [ Il.Star ] ],
      (* z' ; instr'* *)
      { it = TupE [ se; rhs ]; _ } ) -> (
    let push_instrs = translate_rhs rhs in
    let at = se.at in
    match se.it with
    | Il.MixE ([ []; [ Il.Semicolon ]; [] ], _)
    | Il.VarE _ -> push_instrs
    | Il.CallE (f, ae) -> push_instrs @ [ performI (f.it, translate_args ae) ~at:at ]
    | _ -> error_exp se "Invalid new state" )
  | _ -> error_exp exp "AL rhs instructions"


let lhs_id_ref = ref 0
let lhs_prefix = "y_"
let init_lhs_id () = lhs_id_ref := 0
let get_lhs_name () =
  let lhs_id = !lhs_id_ref in
  lhs_id_ref := (lhs_id + 1);
  varE (lhs_prefix ^ (lhs_id |> string_of_int))


let rec contains_name e = match e.it with
  | VarE _ | SubE _ -> true
  | IterE (e', _, _) -> contains_name e'
  | _ -> false

let extract_non_names =
  List.fold_left_map (fun acc e ->
    if contains_name e then acc, e
    else
      let fresh = get_lhs_name () in
      [ e, fresh ] @ acc, fresh
  ) []

let contains_diff target_ns e =
  let free_ns = free_expr e in
  not (IdSet.is_empty free_ns) && IdSet.disjoint free_ns target_ns

let extract_diff lhs rhs ids cont =
  let at = lhs.at in
  match lhs.it with
  (* TODO: Make this actually consider the targets *)
  | CallE (f, args) ->
    let hds, tl = Util.Lib.List.split_last args in
    let new_lhs = tl in
    let new_rhs = callE ("inverse_of_" ^ f, hds @ [ rhs ]) ~at:at in
    new_lhs, new_rhs, cont
  | _ ->
    let conds = ref [] in
    let target_ns = IdSet.of_list (List.map it ids) in
    let pre_expr = (fun e ->
      if not (contains_diff target_ns e) then
        e
      else
        let new_e = get_lhs_name () in
        conds := !conds @ [ binE (EqOp, new_e, e) ];
        new_e
    ) in
    let walker = Al.Walk.walk_expr { Al.Walk.default_config with
      pre_expr;
      stop_cond_expr = contains_diff target_ns;
    } in
    let new_lhs = walker lhs in
    new_lhs, rhs, List.fold_right (fun c il -> [ ifI (c, il, []) ]) !conds cont


let rec translate_bindings ids cont bindings =
  List.fold_right (fun (l, r) cont ->
    match l with
    | _ when IdSet.is_empty (free_expr l) -> [ ifI (binE (EqOp, r, l), cont, []) ]
    | _ -> translate_letpr l r ids cont
  ) bindings cont


and translate_letpr lhs rhs ids cont =
  let lhs, rhs, cont = extract_diff lhs rhs ids cont in
  let lhs_at = lhs.at in
  let rhs_at = rhs.at in
  let at = over_region [ lhs_at; rhs_at ] in
  match lhs.it with
  | CaseE (tag, es) ->
    let bindings, es' = extract_non_names es in
    [
      ifI (
        isCaseOfE (rhs, tag),
        letI (caseE (tag, es') ~at:lhs_at, rhs) ~at:at :: translate_bindings ids cont bindings,
        []
      );
    ]
  | ListE es ->
    let bindings, es' = extract_non_names es in
    if List.length es >= 2 then (* TODO: remove this. This is temporarily for a pure function returning stores *)
    letI (listE es' ~at:lhs_at, rhs) ~at:at :: translate_bindings ids cont bindings
    else
    [
      ifI
        ( binE (EqOp, lenE rhs, numE (Z.of_int (List.length es))),
          letI (listE es' ~at:lhs_at, rhs) ~at:at :: translate_bindings ids cont bindings,
          [] );
    ]
  | OptE None ->
    [
      ifI
        ( unE (NotOp, isDefinedE rhs),
          cont,
          [] );
    ]
  | OptE (Some ({ it = VarE _; _ })) ->
    [
      ifI
        ( isDefinedE rhs,
          letI (lhs, rhs) ~at:at :: cont,
          [] );
     ]
  | OptE (Some e) ->
    let fresh = get_lhs_name() in
    [
      ifI
        ( isDefinedE rhs,
          letI (optE (Some fresh) ~at:lhs_at, rhs) ~at:at :: translate_letpr e fresh ids cont,
          [] );
     ]
  | BinE (AddOp, a, b) ->
    [
      ifI
        ( binE (GeOp, rhs, b),
          letI (a, binE (SubOp, rhs, b) ~at:at) ~at:at :: cont,
          [] );
    ]
  | CatE (prefix, suffix) ->
    let handle_list e =
      match e.it with
      | ListE es ->
        let bindings', es' = extract_non_names es in
        Some (numE (Z.of_int (List.length es))), bindings', listE es'
      | IterE (({ it = VarE _; _ } | { it = SubE _; _ }), _, ListN (e', None)) ->
        Some e', [], e
      | _ ->
        None, [], e in
    let length_p, bindings_p, prefix' = handle_list prefix in
    let length_s, bindings_s, suffix' = handle_list suffix in
    (* TODO: This condition should be injected by sideconditions pass *)
    let cond = match length_p, length_s with
      | None, None -> yetE ("Nondeterministic assignment target: " ^ Al.Print.string_of_expr lhs)
      | Some l, None
      | None, Some l -> binE (GeOp, lenE rhs, l)
      | Some l1, Some l2 -> binE (EqOp, lenE rhs, binE (AddOp, l1, l2))
    in
    [
      ifI
        ( cond,
          letI (catE (prefix', suffix') ~at:lhs_at, rhs) ~at:at
            :: translate_bindings ids cont (bindings_p @ bindings_s),
          [] );
    ]
  | SubE (s, t) ->
    [
      ifI
        ( hasTypeE (rhs, t),
          letI (varE s ~at:lhs_at, rhs) ~at:at :: cont,
          [] )
    ]
  | VarE s when s = "f" || String.starts_with ~prefix:"f_" s ->
    letI (lhs, rhs) ~at:at :: cont
  | VarE s when s = "s" || String.starts_with ~prefix:"s'" s -> (* HARDCODE: hide state *)
    ( match rhs.it with
    | CallE (func, args) -> performI (func, args) ~at:rhs_at :: cont
    | _ -> letI (lhs, rhs) ~at:at :: cont )
  | _ -> letI (lhs, rhs) ~at:at :: cont

(* HARDCODE: Translate each RulePr manually based on their names *)
let translate_rulepr id exp =
  let at = id.at in
  match id.it, translate_argexp exp with
  | "Eval_expr", [z; lhs; _; rhs] ->
    [
      (* TODO: not pushing store without store remover transpiler *)
      pushI (frameE (None, z));
      letI (rhs, callE ("eval_expr", [ lhs ])) ~at:at;
      popI (frameE (None, z));
    ]
  | "Ref_ok", [_s; ref; rt] ->
    [ letI (rt, callE ("ref_type_of", [ ref ]) ~at:at) ~at:at ]
  | "Reftype_sub", [_C; rt1; rt2] ->
    [ ifI (matchE (rt1, rt2) ~at:at, [], []) ~at:at ]
  | _ ->
    Error.print_yet exp.at "translate_rulepr" (Il.Print.string_of_exp exp);
    [ yetI ("TODO: Unsupported rule premise:" ^ id.it) ~at:at ]

let rec translate_iterpr pr (iter, ids) =
  let instrs = translate_prem pr in
  let iter', ids' = translate_iter iter, IdSet.of_list (List.map it ids) in
  let lhs_iter = match iter' with | ListN (e, _) -> ListN (e, None) | _ -> iter' in

  let distribute_iter lhs rhs =
    let lhs_ids = IdSet.elements (IdSet.inter (free_expr lhs) ids') in
    let rhs_ids = IdSet.elements (IdSet.inter (free_expr rhs) ids') in

    assert (List.length (lhs_ids @ rhs_ids) > 0);
    iterE (lhs, lhs_ids, lhs_iter) ~at:lhs.at, iterE (rhs, rhs_ids, iter') ~at:rhs.at
  in

  let post_instr i =
    let at = i.at in
    match i.it with
    | LetI (lhs, rhs) -> [ letI (distribute_iter lhs rhs) ~at:at ]
    | IfI (cond, il1, il2) ->
        let cond_ids = IdSet.elements (IdSet.inter (free_expr cond) ids') in
        [ ifI (iterE (cond, cond_ids, iter') ~at:cond.at, il1, il2) ~at:at ]
    | _ -> [ i ]
  in
  let walk_config = { Al.Walk.default_config with post_instr } in
  Al.Walk.walk_instrs walk_config instrs

and translate_prem prem =
  let at = prem.at in
  match prem.it with
  | Il.IfPr exp -> [ ifI (translate_exp exp, [], []) ~at:at ]
  | Il.ElsePr -> [ otherwiseI [] ~at:at ]
  | Il.LetPr (exp1, exp2, ids) ->
    init_lhs_id ();
    translate_letpr (translate_exp exp1) (translate_exp exp2) ids []
  | Il.RulePr (id, _, exp) -> translate_rulepr id exp
  | Il.IterPr (pr, exp) -> translate_iterpr pr exp


(* Insert `target` at the innermost if instruction *)
let rec insert_instrs target il =
  match Util.Lib.List.split_last_opt il with
  | [], Some { it = OtherwiseI il'; _ } -> [ otherwiseI (il' @ insert_nop target) ]
  | h, Some { it = IfI (cond, il', []); _ } ->
    h @ [ ifI (cond, insert_instrs (insert_nop target) il' , []) ]
  | _ -> il @ target


(* `premise list` -> `instr list` (return instructions) -> `instr list` *)
let translate_prems =
  List.fold_right (fun prem il -> translate_prem prem |> insert_instrs il)


let get_tup_exps c =
  match c.it with
  | Il.MixE ([ []; [ Il.Semicolon ]; _ ], tup) ->
    (match tup.it with
    | Il.TupE [ e1; e2 ] -> e1, e2
    | _ -> error_exp c "Invalid config"
    )
  | _ -> error_exp c "Invalid config"


(* s; f; e -> `expr * expr * instr list` *)
let translate_config config =
  let state, e = get_tup_exps config in
  let sto, f = get_tup_exps state in

  if is_store sto && is_frame f then
    translate_exp sto, translate_exp f, translate_rhs e
  else
    error_exp config "Invalid config"

let translate_helper_body name clause =
  let Il.DefD (_, _, re, prems) = clause.it in
  (* TODO: Remove hack *)
  let return_instrs =
    if name = "instantiate" then
      translate_config re |> return_instrs_of_instantiate
    else if name = "invoke" then
      translate_config re |> return_instrs_of_invoke
    else
      [ returnI (Some (translate_exp re)) ]
  in
  translate_prems prems return_instrs


(* Main translation for helper functions *)
let translate_helper partial_funcs def =
  match def.it with
  | Il.DecD (id, _, _, clauses) when List.length clauses > 0 ->
    let name = id.it in
    let unified_clauses = Il2il.unify_defs clauses in
    let Il.DefD (_, args, _, _) = List.hd unified_clauses |> it in
    let params =
      args
      |> translate_args
      |> List.map
        Walk.(walk_expr { default_config with pre_expr = Transpile.remove_sub })
    in
    let blocks = List.map (translate_helper_body name) unified_clauses in
    let body =
      blocks
      |> Transpile.merge_blocks
      |> Transpile.enhance_readability
      |> if List.mem id partial_funcs then Fun.id else Transpile.ensure_return in

    Some (FuncA (name, params, body))
  | _ -> None


(* Translating helper functions *)
let translate_helpers il =
  (* Get list of partial functions *)
  let get_partial_func def =
    let is_partial_hint hint = hint.Il.hintid.it = "partial" in
    match def.it with
    | Il.HintD { it = Il.DecH (id, hints); _ } when List.exists is_partial_hint hints ->
      Some (id)
    | _ -> None
  in
  let partial_funcs = List.filter_map get_partial_func il in

  List.filter_map (translate_helper partial_funcs) il


let rec kind_of_context e =
  match e.it with
  | Il.CaseE (Il.Atom "FRAME_", _) -> ("frame", "admininstr")
  | Il.CaseE (Il.Atom "LABEL_", _) -> ("label", "admininstr")
  | Il.ListE [ e' ]
  | Il.MixE (_ (* ; *), e')
  | Il.TupE [_ (* z *); e'] -> kind_of_context e'
  | _ -> error_exp e "Could not get kind_of_context"

let in_same_context (lhs1, _, _) (lhs2, _, _) =
  kind_of_context lhs1 = kind_of_context lhs2

let group_contexts xs =
  List.fold_left (fun acc x ->
    let g1, g2 = List.partition (fun g -> in_same_context (List.hd g) x) acc in
    match g1 with
    | [] -> [ x ] :: acc
    | [ g ] -> (x :: g) :: g2
    | _ -> failwith "group_contexts: perhaps in_same_context is not equivalence relation"
    ) [] xs |> List.rev

let un_unify (lhs, rhs, prems) =
  let new_lhs, new_prems = List.fold_left (fun (lhs, ps) p ->
    match p.it with
    | Il.LetPr (e1, ({ it = Il.VarE uvar; _} as u), _) when Il2il.is_unified_id uvar.it ->
      let new_lhs = Il2il.transform_expr (fun e2 -> if Il.Eq.eq_exp e2 u then e1 else e2) lhs in
      new_lhs, ps
    | _ -> lhs, ps @ [ p ]
  ) (lhs, []) prems in
  new_lhs, rhs, new_prems

let insert_deferred = function
  | None -> Fun.id
  | Some exp ->
    (* Translate deferred lhs *)
    let deferred_instrs = insert_pop exp in

    (* Find unbound variable *)
    let unbound_variable = get_unbound exp in

    (* Insert the translated instructions right after the binding *)
    let f instr =
      match instr.it with
      | LetI (lhs, _) when free_expr lhs |> IdSet.mem unbound_variable ->
        instr :: deferred_instrs
      | _ -> [ instr ] in

    let walk_config = { Al.Walk.default_config with post_instr = f } in
    Al.Walk.walk_instrs walk_config

(* `reduction` -> `instr list` *)
let translate_reduction deferred reduction =
  let _, rhs, prems = reduction in

  (* Translate rhs *)
  translate_rhs rhs
  |> insert_nop
  (* Translate premises *)
  |> translate_prems prems
  (* Translate and insert deferred pop instructions *)
  |> insert_deferred deferred


let insert_pop_winstr vars = function
  | h :: t when is_unbound vars h -> List.concat_map insert_pop t, Some h
  | vs -> List.concat_map insert_pop vs, None

let translate_context_winstr winstr =
  let at = winstr.at in
  match winstr.it with
  (* Frame *)
  | Il.CaseE (Il.Atom "FRAME_", args) ->
    (match args.it with
    | Il.TupE [arity; name; inner_exp] ->
      [
        letI (translate_exp name, getCurFrameE ()) ~at:at;
        letI (translate_exp arity, arityE (translate_exp name)) ~at:at;
        insert_assert inner_exp;
        popI (translate_exp inner_exp) ~at:at;
        insert_assert winstr;
        exitI () ~at:at
      ]
    | _ -> error_exp winstr "frame"
    )
  (* Label *)
  | Il.CaseE (Il.Atom "LABEL_", { it = Il.TupE [ _n; _instrs; vals ]; _ }) ->
    [
      (* TODO: append Jump instr *)
      popallI (translate_exp vals) ~at:at;
      insert_assert winstr;
      exitI () ~at:at
    ]
  | _ -> []

let translate_context ctx vs =
  let at = ctx.at in
  let first_vs, last_v = Util.Lib.List.split_last vs in
  match ctx.it with
  | Il.CaseE (Il.Atom "LABEL_", { it = Il.TupE [ n; instrs; _hole ]; _ }) ->
    [
      letI (varE "L", getCurLabelE ()) ~at:at;
      letI (translate_exp n, arityE (varE "L")) ~at:at;
      letI (translate_exp instrs, contE (varE "L")) ~at:at;
    ] @ List.map (fun v -> popI (translate_exp v) ~at:at) first_vs @
    [
      popallI (translate_exp last_v) ~at:at;
      exitI () ~at:at
    ]
  | Il.CaseE (Il.Atom "FRAME_", { it = Il.TupE [ n; _f; _hole ]; _ }) ->
    [
      letI (varE "F", getCurFrameE ()) ~at:at;
      letI (translate_exp n, arityE (varE "F")) ~at:at;
    ] @ List.map (fun v -> popI (translate_exp v)) first_vs @
    [
      popallI (translate_exp last_v) ~at:at;
      exitI () ~at:at
    ]
  | _ -> [ yetI "TODO: translate_context" ~at:at ]

let translate_context_rgroup lhss sub_algos inner_params =
  List.fold_right2 (fun lhs algo acc ->
    match algo with
    | RuleA (_, params, body) ->
      if Option.is_none !inner_params then inner_params := Some params;
      let kind = kind_of_context lhs in
      [ ifI (
        contextKindE (kind, getCurContextE ()),
        body,
        acc ) ]
    | _ -> failwith "unreachable")
  lhss sub_algos []


let rec split_lhs_stack' ?(note : Il.typ option) name stack ctxs instrs =
  let target = upper name in
  match stack with
  | [] ->
    let typ = Option.get note in
    let winstr = Il.CaseE (Il.Atom (target), (Il.TupE []) |> wrap top) |> wrap typ in
    ctxs @ [ ([], instrs), None ], winstr
  | hd :: tl ->
    match hd.it with
    | Il.CaseE (Il.Atom name', _) when name' = target || name' = target ^ "_"
      -> ctxs @ [ (tl, instrs), None ], hd
    | Il.CaseE (a, ({it = Il.TupE args; _} as e)) ->
      let list_arg = List.find is_list args in
      let inner_stack = list_arg |> flatten |> List.rev in
      let holed_args = List.map (fun x -> if x = list_arg then hole else x) args in
      let ctx = { hd with it = Il.CaseE (a, { e with it = Il.TupE holed_args }) } in

      split_lhs_stack' name inner_stack (ctxs @ [ ((tl, instrs), Some ctx) ]) []
    | _ ->
      split_lhs_stack' ~note:(hd.note) name tl ctxs (hd :: instrs)

let split_lhs_stack name stack = split_lhs_stack' name stack [] []


let rec translate_rgroup' context winstr instr_name rgroup =
  let inner_params = ref None in
  let instrs =
    match context with
    | [ (vs, []), None ] ->
      let pop_instrs, defer_opt = vs |> insert_pop_winstr (Il.Free.free_exp winstr) in
      let inner_pop_instrs = translate_context_winstr winstr in

      let instrs' =
        match rgroup |> Util.Lib.List.split_last with
        (* Either case: No premise for the last reduction rule *)
        | hds, (_, rhs, []) when List.length hds > 0 ->
          assert (defer_opt = None);
          let blocks = List.map (translate_reduction None) hds in
          let body1 = Transpile.merge_blocks blocks in
          let body2 = translate_rhs rhs |> insert_nop in
          eitherI (body1, body2) |> Transpile.push_either
        (* Normal case *)
        | _ ->
          let blocks = List.map (translate_reduction defer_opt) rgroup in
          Transpile.merge_blocks blocks
      in

      pop_instrs @ inner_pop_instrs @ instrs'
    (* The target instruction is inside a context *)
    | [ ([], []), Some context ; (vs, _is), None ] ->
      let head_instrs = translate_context context vs in
      let body_instrs = List.map (translate_reduction None) rgroup |> List.concat in
      head_instrs @ body_instrs
    (* The target instruction is inside different contexts (i.e. return in both label and frame) *)
    | [ ([], [ _ ]), None ] ->
      (try
      let unified_sub_groups =
        rgroup
        |> List.map un_unify
        |> group_contexts
        |> List.map (fun g -> Il2il.unify_lhs (instr_name, g)) in

      let lhss = List.map (fun (_, g) -> lhs_of_rgroup g) unified_sub_groups in
      let sub_algos = List.map translate_rgroup unified_sub_groups in
      translate_context_rgroup lhss sub_algos inner_params

      with _ -> [ yetI "TODO: It is likely that the value stack of two rules are different" ])
    | _ -> [ yetI "TODO" ] in
  !inner_params, instrs


(* Main translation for reduction rules
 * `rgroup` -> `Backend-prose.Algo` *)
and translate_rgroup (instr_name, rgroup) =
  let lhs, _, _ = List.hd rgroup in
  let state_instr, lhs_pure = split_state lhs in
  let lhs_stack = lhs_pure |> flatten |> List.rev in
  let context, winstr = split_lhs_stack instr_name lhs_stack in

  let inner_params, instrs = translate_rgroup' context winstr instr_name rgroup in

  let winstr_name =
    match winstr.it with
    | Il.CaseE (Il.Atom winstr_name, _) -> winstr_name
    | _ -> failwith "unreachable"
  in
  let kwd = kwd winstr_name winstr.note in
  let al_params =
    match inner_params with
    | None ->
      if instr_name = "frame" || instr_name = "label"
      then []
      else
        get_params winstr |> List.map translate_exp
    | Some params -> params
  in
  (* TODO: refactor transpiles *)
  let al_params' =
    List.map
      Walk.(walk_expr { default_config with pre_expr = Transpile.remove_sub })
      al_params
  in
  let body =
    state_instr @ instrs
    |> insert_nop
    |> Transpile.enhance_readability
    |> Transpile.infer_assert
  in
  RuleA (kwd, al_params', body)


let rule_to_tup rule =
  let Il.RuleD (_, _, _, exp, prems) = rule.it in
  match exp.it with
  | Il.TupE [ lhs; rhs ] -> lhs, rhs, prems
  | _ -> error_exp exp "reduction rule"


(* group reduction rules that have same name *)
let rec group_rules = function
  | [] -> []
  | h :: t ->
    let name = name_of_rule h in
    let t1, t2 =
      List.partition (fun rule -> name_of_rule rule = name) t in
    let grouped_rules = (h :: t1) |> List.map rule_to_tup in
    (name, grouped_rules) :: group_rules t2

(* extract rules except Steps/..., Step/pure and Step/read *)
let extract_rules def =
  match def.it with
  | Il.RelD (id, _, _, rules) when String.starts_with ~prefix:"Step" id.it ->
    let condition rule =
      let Il.RuleD (id', _, _, _, _) = rule.it in
      id.it <> "Steps" && id'.it <> "pure" && id'.it <> "read"
    in
    List.filter condition rules
  | _ -> []

(* Translating reduction rules *)
let translate_rules il =
  (* Extract rules *)
  il
  |> List.concat_map extract_rules
  (* Group rules that have the same names *)
  |> group_rules
  (* Unify lhs *)
  |> List.map Il2il.unify_lhs
  (* Translate reduction group into algorithm *)
  |> List.map translate_rgroup


(* Entry *)
let translate il =
  let il = List.concat_map flatten_rec il in
  let algos = translate_helpers il @ translate_rules il in

  (* Transpile *)
  (* Can be turned off *)
  List.map Transpile.remove_state algos
