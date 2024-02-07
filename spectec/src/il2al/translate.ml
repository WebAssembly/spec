open Al
open Ast
open Free
open Al_util
open Printf
open Backend_interpreter.Manual
open Util
open Source

module Il = struct include Il include Ast include Print end


(* Helpers *)

let fail_on_exp exp typ_msg =
  sprintf "Invalid expression `%s` to be %s."
    (Il.Print.string_of_exp exp) typ_msg
  |> failwith

let list_partition_with pred xs =
  let rec list_partition acc = function
  | [] -> acc
  | hd :: tl ->
    let same_groups, diff_groups = List.partition (fun group -> pred (List.hd group) hd) acc in
    match same_groups with
    | [] -> list_partition ([ hd ] :: acc) tl
    | [ my_group ] -> list_partition ( (hd :: my_group) :: diff_groups) tl
    | _ -> failwith "Impossible list_partiton_with: perhaps pred is not equivalence relation"
  in
  list_partition [] xs |> List.rev

let name_of_rule rule =
  let Il.RuleD (id1, _, _, _, _) = rule.it in
  String.split_on_char '-' id1.it |> List.hd

let lower = String.lowercase_ascii
let upper = String.uppercase_ascii

let disjoint xs ys = List.for_all (fun x -> List.for_all ((<>) x) ys) xs

let update_opt v opt_ref = match !opt_ref with
  | None -> opt_ref := Some v
  | Some _ -> ()

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

(* transform z; e into e *)
let drop_state e =
  match e.it with
  (* z; e *)
  | Il.MixE ([ []; [ Il.Semicolon ]; [ Il.Star ] ], { it = Il.TupE [ state; e' ]; _ })
    when is_state state -> e'
  (* s; f; e *)
  | Il.MixE
    ( [ []; [ Il.Semicolon ]; [ Il.Star ] ],
      { it = Il.TupE [ { it = Il.MixE (
        [[]; [ Il.Semicolon ]; []],
        { it = Il.TupE [ store; frame ]; _ }
      ); _ }; e' ]; _ } )
    when is_store store && is_frame frame -> e'
  | _ -> e

let rec flatten e =
  match e.it with
  | Il.CatE (e1, e2) -> flatten e1 @ flatten e2
  | Il.ListE es -> List.concat_map flatten es
  | _ -> [ e ]

let flatten_rec def =
  match def.it with
  | Il.RecD defs -> defs
  | _ -> [def]

let get_params winstr =
  match winstr.it with
  | Il.CaseE (_, { it = Il.TupE exps; _ }) -> exps
  | Il.CaseE (_, exp) -> [ exp ]
  | _ ->
      print_endline (Il.Print.string_of_exp winstr ^ "is not a vaild wasm instruction.");
      []

let kwd name note = name, Il.Print.string_of_typ note


(* `Il.iter` -> `iter` *)
let rec translate_iter = function
  | Il.Opt -> Opt
  | Il.List1 -> List1
  | Il.List -> List
  | Il.ListN (e, id_opt) ->
    ListN (translate_expr e, Option.map (fun id -> id.it) id_opt)

(* `Il.exp` -> `expr` *)
and translate_expr exp =
  let at = exp.at in
  match exp.it with
  | Il.NatE n -> numE (Int64.of_int n) ~at:at
  | Il.BoolE b -> boolE b ~at:at
  (* List *)
  | Il.LenE inner_exp -> lenE (translate_expr inner_exp) ~at:at
  | Il.ListE exps -> listE (List.map translate_expr exps) ~at:at
  | Il.IdxE (exp1, exp2) ->
      accE (translate_expr exp1, idxP (translate_expr exp2)) ~at:at
  | Il.SliceE (exp1, exp2, exp3) ->
      accE (translate_expr exp1, sliceP (translate_expr exp2, translate_expr exp3)) ~at:at
  | Il.CatE (exp1, exp2) -> catE (translate_expr exp1, translate_expr exp2) ~at:at
  (* Variable *)
  | Il.VarE id -> varE id.it ~at:at
  | Il.SubE ({ it = Il.VarE id; _}, { it = VarT (t, _); _ }, _) -> subE (id.it, t.it) ~at:at
  | Il.SubE (inner_exp, _, _) -> translate_expr inner_exp
  | Il.IterE (inner_exp, (iter, ids)) ->
      let names = List.map (fun id -> id.it) ids in
      iterE (translate_expr inner_exp, names, translate_iter iter) ~at:at
  (* property access *)
  | Il.DotE (inner_exp, Atom p) ->
      accE (translate_expr inner_exp, dotP (kwd p inner_exp.note)) ~at:at
  (* conacatenation of records *)
  | Il.CompE (inner_exp, { it = Il.StrE expfields; _ }) ->
      (* assumption: CompE is only used for prepending to validation context *)
      let nonempty e = (match e.it with ListE [] | OptE None -> false | _ -> true) in
      List.fold_left
        (fun acc extend_exp -> match extend_exp with
        | Il.Atom name, fieldexp ->
            let extend_expr = translate_expr fieldexp in
            if nonempty extend_expr then
              extE (acc, [ dotP (kwd name inner_exp.note) ], extend_expr, Front) ~at:at
            else
              acc
        | _ -> fail_on_exp exp "AL record expression")
        (translate_expr inner_exp) expfields
  (* extension of record field *)
  | Il.ExtE (base, path, v) -> extE (translate_expr base, translate_path path, translate_expr v, Back) ~at:at
  (* update of record field *)
  | Il.UpdE (base, path, v) -> updE (translate_expr base, translate_path path, translate_expr v) ~at:at
  (* Binary / Unary operation *)
  | Il.UnE (op, exp) ->
      let exp' = translate_expr exp in
      let op = match op with
      | Il.NotOp -> NotOp
      | Il.MinusOp _ -> MinusOp
      | _ -> fail_on_exp exp "AL unary expression"
      in
      unE (op, exp') ~at:at
  | Il.BinE (op, exp1, exp2) ->
    let lhs = translate_expr exp1 in
    let rhs = translate_expr exp2 in
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
    let lhs = translate_expr exp1 in
    let rhs = translate_expr exp2 in
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
  | Il.CaseE (Il.Atom cons, argexp) -> caseE (kwd cons exp.note, translate_argexpr argexp) ~at:at
  (* Tuple *)
  | Il.TupE exps -> tupE (List.map translate_expr exps) ~at:at
  (* Call *)
  | Il.CallE (id, args) -> callE (id.it, translate_args args) ~at:at
  (* Record expression *)
  | Il.StrE expfields ->
      let f acc = function
        | Il.Atom name, fieldexp ->
            let expr = translate_expr fieldexp in
            Record.add (kwd name exp.note) expr acc
        | _ -> fail_on_exp exp "AL record expression"
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
          tupE [ translate_expr e1; translate_expr e2 ] ~at:at
      | [ []; [ Il.Star; atom ]; [ Il.Star ] ], [ e1; e2 ]
      | [ []; [ atom ]; [] ], [ e1; e2 ] ->
          infixE (translate_expr e1, Il.Print.string_of_atom atom, translate_expr e2) ~at:at
      | [ []; [ Il.Arrow ]; [ Il.Star ]; [] ], [ e1; e2; e3 ] -> (* HARDCODE *)
          infixE (translate_expr e1, "->", catE (translate_expr e2, translate_expr e3)) ~at:at
      (* Constructor *)
      (* TODO: Need a better way to convert these CaseE into ConsturctE *)
      | [ [ Il.Atom "FUNC" ]; []; [ Il.Star ]; [] ], _ ->
          caseE (("FUNC", "func"), List.map translate_expr exps) ~at:at
      | [ [ Il.Atom "OK" ] ], [] ->
          caseE (("OK", "datatype"), []) ~at:at
      | [ [ Il.Atom "MUT" ]; [ Il.Quest ]; [] ],
        [ { it = Il.OptE (Some { it = Il.TupE []; _ }); _}; t ] ->
          tupE [ caseE (("MUT", "globaltype"), []); translate_expr t ] ~at:at
      | [ [ Il.Atom "MUT" ]; [ Il.Quest ]; [] ],
        [ { it = Il.IterE ({ it = Il.TupE []; _ }, (Il.Opt, [])); _}; t ] ->
          tupE [ iterE (varE "mut", ["mut"], Opt); translate_expr t ] ~at:at
      | [ Il.Atom "MODULE" ] :: _, el ->
          caseE (("MODULE", "module"), List.map translate_expr el) ~at:at
      | [ [ Il.Atom "IMPORT" ]; []; []; [] ], el ->
          caseE (("IMPORT", "import"), List.map translate_expr el) ~at:at
      | [ [ Il.Atom "GLOBAL" ]; []; [] ], el ->
          caseE (("GLOBAL", "global"), List.map translate_expr el) ~at:at
      | [ Il.Atom "TABLE" ] :: _, el ->
          caseE (("TABLE", "table"), List.map translate_expr el) ~at:at
      | [ [ Il.Atom "MEMORY" ]; [] ], el ->
          caseE (("MEMORY", "mem"), List.map translate_expr el) ~at:at
      | [ []; [ Il.Atom "I8" ] ], el ->
          caseE (("I8", "memtype"), List.map translate_expr el) ~at:at
      | [ [ Il.Atom "ELEM" ]; []; [ Il.Star ]; [] ], el ->
          caseE (("ELEM", "elem"), List.map translate_expr el) ~at:at
      | [ [ Il.Atom "DATA" ]; [ Il.Star ]; [] ], el ->
          caseE (("DATA", "data"), List.map translate_expr el) ~at:at
      | [ [ Il.Atom "START" ]; [] ], el ->
          caseE (("START", "start"), List.map translate_expr el) ~at:at
      | [ [ Il.Atom "EXPORT" ]; []; [] ], el ->
          caseE (("EXPORT", "export"), List.map translate_expr el) ~at:at
      | [ [ Il.Atom "NULL" ]; [ Il.Quest ] ], el ->
          caseE (("NULL", "nul"), List.map translate_expr el) ~at:at
      | [ Il.Atom name ] :: ll, el
        when List.for_all (fun l -> l = [] || l = [ Il.Star ] || l = [ Il.Quest ]) ll ->
          caseE ((name, lower name), List.map translate_expr el) ~at:at
      | _ -> yetE (Il.Print.string_of_exp exp) ~at:at)
  | Il.OptE inner_exp -> optE (Option.map translate_expr inner_exp) ~at:at
  (* Yet *)
  | _ -> yetE (Il.Print.string_of_exp exp) ~at:at

(* `Il.exp` -> `expr list` *)
and translate_argexpr exp =
  match exp.it with
  | Il.TupE el -> List.map translate_expr el
  | _ -> [ translate_expr exp ]

(* `Il.arg list` -> `expr list` *)
and translate_args args = List.concat_map ( fun arg ->
  match arg.it with
  | Il.ExpA el -> [ translate_expr el ]
  | Il.TypA _ -> [] ) args

(* `Il.path` -> `path list` *)
and translate_path path =
  let rec translate_path' path =
    let at = path.at in
    match path.it with
    | Il.RootP -> []
    | Il.IdxP (p, e) -> (translate_path' p) @ [ idxP (translate_expr e) ~at:at ]
    | Il.SliceP (p, e1, e2) -> (translate_path' p) @ [ sliceP (translate_expr e1, translate_expr e2) ~at:at ]
    | Il.DotP (p, Atom a) ->
        (translate_path' p) @ [ dotP (kwd a p.note) ~at:at ]
    | _ -> failwith "unreachable"
  in
  translate_path' path

let insert_assert exp =
  let at = exp.at in
  match exp.it with
  | Il.CaseE (Il.Atom "FRAME_", _) -> assertI (topFrameE ()) ~at:at
  | Il.IterE (_, (Il.ListN (e, None), _)) ->
    assertI (topValuesE (translate_expr e) ~at:at) ~at:at
  | Il.CaseE (Il.Atom "LABEL_", { it = Il.TupE [ _n; _instrs; _vals ]; _ })
    -> assertI (topLabelE () ~at:at) ~at:at
  | Il.CaseE ( Il.Atom "CONST", { it = Il.TupE (ty :: _); _ })
    -> assertI (topValueE (Some (translate_expr ty)) ~at:at) ~at:at
  | _ -> assertI (topValueE None) ~at:at

let insert_pop e = [ insert_assert e; popI (translate_expr e) ~at:e.at ]

let insert_nop instrs = match instrs with [] -> [ nopI () ] | _ -> instrs


(* Assume that only the iter variable is unbound *)
let is_unbound vars e =
  match e.it with
  | Il.IterE (_, (ListN (n, _), _))
    when not (Il.Free.subset (Il.Free.free_exp n) vars) -> true
  | _ -> false

let get_unbound e =
  match e.it with
  | Il.IterE (_, (ListN ({ it = VarE n; _ }, _), _)) -> n.it
  | _ -> failwith "Invalid deferred expression"

(* `Il.exp list` -> `instr list * Il.exp list` *)
let handle_lhs_stack vars = function
  | h :: t when is_unbound vars h -> List.concat_map insert_pop t, Some h
  | vs -> List.concat_map insert_pop vs, None

let handle_context_winstr winstr =
  let at = winstr.at in
  match winstr.it with
  (* Frame *)
  | Il.CaseE (Il.Atom "FRAME_", args) ->
    ( match args.it with
    | Il.TupE [arity; name; inner_exp] ->
      [
        letI (translate_expr name, getCurFrameE ()) ~at:at;
        letI (translate_expr arity, arityE (translate_expr name)) ~at:at;
        insert_assert inner_exp;
        popI (translate_expr inner_exp) ~at:at;
        insert_assert winstr;
        exitI () ~at:at
      ]
    | _ -> failwith "Invalid frame")
  (* Label *)
  | Il.CaseE (Il.Atom "LABEL_", { it = Il.TupE [ _n; _instrs; vals ]; _ }) ->
    [
      (* TODO: append Jump instr *)
      popallI (translate_expr vals) ~at:at;
      insert_assert winstr;
      exitI () ~at:at
    ]
  | _ -> []

let handle_context ctx values =
  let at = ctx.at in
  match ctx.it, values with
  | Il.CaseE (Il.Atom "LABEL_", { it = Il.TupE [ n; instrs; _hole ]; _ }), vs ->
    let first_vs, last_v = Util.Lib.List.split_last vs in
    [
      letI (varE "L", getCurLabelE ()) ~at:at;
      letI (translate_expr n, arityE (varE "L")) ~at:at;
      letI (translate_expr instrs, contE (varE "L")) ~at:at;
    ] @ List.map (fun v -> popI (translate_expr v) ~at:at) first_vs @
    [
      popallI (translate_expr last_v) ~at:at;
      exitI () ~at:at
    ]
  | Il.CaseE (Il.Atom "FRAME_", { it = Il.TupE [ n; _f; _hole ]; _ }), vs ->
    let first_vs, last_v = Util.Lib.List.split_last vs in
    [
      letI (varE "F", getCurFrameE ()) ~at:at;
      letI (translate_expr n, arityE (varE "F")) ~at:at;
    ] @ List.map (fun v -> popI (translate_expr v)) first_vs @
    [
      popallI (translate_expr last_v) ~at:at;
      exitI () ~at:at
    ]
  | _ -> [ yetI "TODO: handle_context" ~at:at ]

(* `Il.exp` -> `instr list` *)
let rec rhs_to_instrs exp =
  let at = exp.at in
  match exp.it with
  (* Trap *)
  | Il.CaseE (Atom "TRAP", _) -> [ trapI () ~at:at ]
  (* Execute instrs *) (* TODO: doing this based on variable name is too ad-hoc. Need smarter way. *)
  | Il.IterE ({ it = VarE id; _ }, (Il.List, _))
  | Il.IterE ({ it = SubE ({ it = VarE id; _ }, _, _); _}, (Il.List, _))
    when String.starts_with ~prefix:"instr" id.it ->
      [ executeseqI (translate_expr exp) ~at:at ]
  | Il.IterE ({ it = CaseE (Atom atomid, _); note = note; _ }, (Opt, [ id ]))
    when atomid = "CALL" ->
      let new_name = varE (id.it ^ "_0") in
      [ ifI (isDefinedE (varE id.it),
        [
          letI (optE (Some new_name), varE id.it) ~at:at;
          executeI (caseE (kwd atomid note, [ new_name ])) ~at:at
        ],
        []) ~at:at ]
  (* Push *)
  | Il.SubE _ | IterE _ -> [ pushI (translate_expr exp) ~at:at ]
  | Il.CaseE (Atom atomid, _) when List.mem atomid [
      (* TODO: Consider automating this *)
      "CONST";
      "VVCONST";
      "REF.I31_NUM";
      "REF.STRUCT_ADDR";
      "REF.ARRAY_ADDR";
      "REF.FUNC_ADDR";
      "REF.HOST_ADDR";
      "REF.EXTERN";
      "REF.NULL"
    ] -> [ pushI (translate_expr exp) ~at:at ]
  (* multiple rhs' *)
  | Il.CatE (exp1, exp2) -> rhs_to_instrs exp1 @ rhs_to_instrs exp2
  | Il.ListE exps -> List.concat_map rhs_to_instrs exps
  (* Frame *)
  | Il.CaseE
      ( Il.Atom "FRAME_",
        {
          it =
            Il.TupE
              [
                { it = Il.VarE arity; _ };
                { it = Il.VarE fname; _ };
                { it = Il.ListE [ labelexp ]; _ };
              ];
          _;
        }) ->
          [
            letI (varE "F", frameE (Some (varE arity.it), varE fname.it)) ~at:at;
            enterI (varE "F", listE ([caseE (("FRAME_", "admininstr"), [])]), rhs_to_instrs labelexp) ~at:at;
          ]
  (* TODO: Label *)
  | Il.CaseE
      ( Atom "LABEL_",
        {
          it =
            Il.TupE
              [ label_arity; instrs_exp1; instrs_exp2 ];
          _;
        }) -> (
      let label_expr =
        labelE (translate_expr label_arity, translate_expr instrs_exp1) ~at:at
      in
      let at = instrs_exp2.at in
      match instrs_exp2.it with
      | Il.CatE (valexp, instrsexp) ->
          [
            letI (varE "L", label_expr) ~at:at;
            enterI (varE "L", catE (translate_expr instrsexp, listE ([caseE (("LABEL_", "admininstr"), [])])), [pushI (translate_expr valexp)]) ~at:at;
          ]
      | _ ->
          [
            letI (varE "L", label_expr) ~at:at;
            enterI (varE "L", catE(translate_expr instrs_exp2, listE ([caseE (("LABEL_", "admininstr"), [])])), []) ~at:at;
          ])
  (* Execute instr *)
  | Il.CaseE (Atom atomid, argexp) ->
      [ executeI (caseE (kwd atomid exp.note, translate_argexpr argexp)) ~at:at ]
  | Il.MixE
      ( [ []; [ Il.Semicolon ]; [ Il.Star ] ],
        (* z' ; instr'* *)
        { it = TupE [ state_exp; rhs ]; _ } ) -> (
      let push_instrs = rhs_to_instrs rhs in
      let at = state_exp.at in
      match state_exp.it with
      | Il.MixE ([ []; [ Il.Semicolon ]; [] ], _)
      | Il.VarE _ -> push_instrs
      | Il.CallE (f, args) -> push_instrs @ [ performI (f.it, translate_args args) ~at:at ]
      | _ -> failwith "Invalid new state" )
  | _ -> fail_on_exp exp "AL rhs instructions"


(* s; f; e -> `expr * expr * instr list` *)
let translate_config config =
  match config.it with
  | Il.MixE ([ []; [ Il.Semicolon ]; _ ], tup1) ->
    (match tup1.it with
    | Il.TupE [ state; exp ] ->
      (match state.it with
      | Il.MixE ([ []; [ Il.Semicolon ]; _ ], tup2) ->
        (match tup2.it with
        | Il.TupE [ store; frame ]
        when is_store store && is_frame frame ->
          translate_expr store, translate_expr frame, rhs_to_instrs exp
        | _ -> failwith "Invalid config")
      | _ -> failwith "Invalid config")
    | _ -> failwith "Invalid config")
  | _ -> failwith "Invalid config"


let lhs_id_ref = ref 0
let lhs_prefix = "y_"
let init_lhs_id () = lhs_id_ref := 0
let get_lhs_name () =
  let lhs_id = !lhs_id_ref in
  lhs_id_ref := (lhs_id + 1);
  varE (lhs_prefix ^ (lhs_id |> string_of_int))

let extract_bound_names lhs rhs targets cont =
  let at = lhs.at in
  match lhs.it with
  (* TODO: Make this actually consider the targets *)
  | CallE (f, args) ->
    let front_args, last_arg = Util.Lib.List.split_last args in
    let new_lhs = last_arg in
    let new_rhs = callE ("inverse_of_" ^ f, front_args @ [ rhs ]) ~at:at in
    new_lhs, new_rhs, cont
  | _ ->
    let contains_bound_name e =
      let names = free_expr e in
      names > [] && disjoint names targets in
    let traverse e =
      let conds_ref = ref [] in
      let walker = Al.Walk.walk_expr { Al.Walk.default_config with
        pre_expr = (fun e ->
          if not (contains_bound_name e) then
            e
          else
            let new_e = get_lhs_name () in
            conds_ref := !conds_ref @ [ binE (EqOp, new_e, e) ];
            new_e
        );
        stop_cond_expr = contains_bound_name;
      } in
      let new_e = walker e in
      new_e, !conds_ref in
    let new_lhs, conds = traverse lhs in
    new_lhs, rhs, List.fold_right (fun c il -> [ ifI (c, il, []) ]) conds cont

let rec expr_to_let lhs rhs targets cont =
  let lhs, rhs, cont = extract_bound_names lhs rhs targets cont in
  let rec has_name e = match e.it with
    | VarE _ | SubE _ -> true
    | IterE (inner_exp, _, _) -> has_name inner_exp
    | _ -> false
  in
  let extract_non_names = List.fold_left_map (fun acc e ->
    if has_name e then acc, e
    else
      let fresh = get_lhs_name () in
      [ e, fresh ] @ acc, fresh
  ) [] in
  let translate_bindings bindings =
    List.fold_right (fun (l, r) cont ->
      match l with
      | _ when free_expr l = [] -> [ ifI (binE (EqOp, r, l), cont, []) ]
      | _ -> expr_to_let l r targets cont
    ) bindings cont
  in
  let lhs_at = lhs.at in
  let rhs_at = rhs.at in
  let at = over_region [ lhs_at; rhs_at ] in
  match lhs.it with
  | CaseE (tag, es) ->
    let bindings, es' = extract_non_names es in
    [
      ifI (
        isCaseOfE (rhs, tag),
        letI (caseE (tag, es') ~at:lhs_at, rhs) ~at:at :: translate_bindings bindings,
        []
      );
    ]
  | ListE es ->
    let bindings, es' = extract_non_names es in
    if List.length es >= 2 then (* TODO: remove this. This is temporarily for a pure function returning stores *)
    letI (listE es' ~at:lhs_at, rhs) ~at:at :: translate_bindings bindings
    else
    [
      ifI
        ( binE (EqOp, lenE rhs, numE (Int64.of_int (List.length es))),
          letI (listE es' ~at:lhs_at, rhs) ~at:at :: translate_bindings bindings,
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
          letI (optE (Some fresh) ~at:lhs_at, rhs) ~at:at :: expr_to_let e fresh targets cont,
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
        Some (numE (Int64.of_int (List.length es))), bindings', listE es'
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
            :: translate_bindings (bindings_p @ bindings_s),
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
let rulepr_to_instrs id exp =
  let instr =
    let at = id.at in
    match id.it, translate_argexpr exp with
    | "Eval_expr", [_; lhs; _z; rhs] ->
      (* TODO: Name of f..? *)
      enterI (
        frameE (None, varE "z"),
        listE [caseE (("FRAME_", "admininstr"), [])],
        [ letI (rhs, callE ("eval_expr", [ lhs ])) ]
      ) ~at:at
    | "Step_read", [ { it = TupE [ { it = TupE [ _s; f ]; _ }; lhs ]; _ }; rhs] ->
      enterI (
        frameE (None, f),
        listE [caseE (("FRAME_", "admininstr"), [])],
        [ letI (rhs, callE ("eval_expr", [ lhs ])) ]
      ) ~at:at
    | "Ref_ok", [_s; ref; rt] ->
      letI (rt, callE ("ref_type_of", [ ref ]) ~at:at) ~at:at
    | "Reftype_sub", [_C; rt1; rt2] ->
      ifI (matchE (rt1, rt2) ~at:at, [], []) ~at:at
    | _ -> prerr_endline (Il.Print.string_of_exp exp); yetI ("TODO: Unsupported rule premise:" ^ id.it) ~at:at
  in
  [ instr ]

let rec interpr_to_instrs pr (iter, ids) =
  let instrs = prem_to_instrs pr in
  let iter', ids' = translate_iter iter, List.map it ids in
  let lhs_iter = match iter' with | ListN (e, _) -> ListN (e, None) | _ -> iter' in

  let distribute_iter lhs rhs =
    let lhs_ids = intersection (free_expr lhs) ids' in
    let rhs_ids = intersection (free_expr rhs) ids' in

    assert (List.length (lhs_ids @ rhs_ids) > 0);
    iterE (lhs, lhs_ids, lhs_iter) ~at:lhs.at, iterE (rhs, rhs_ids, iter') ~at:rhs.at
  in

  let f i =
    let at = i.at in
    match i.it with
    | LetI (lhs, rhs) -> [ letI (distribute_iter lhs rhs) ~at:at ]
    | IfI (cond, il1, il2) ->
        let cond_ids = intersection (free_expr cond) ids' in
        [ ifI (iterE (cond, cond_ids, iter') ~at:cond.at, il1, il2) ~at:at ]
    | _ -> [ i ]
  in
  let walk_config = { Al.Walk.default_config with post_instr = f } in
  Al.Walk.walk_instrs walk_config instrs

and prem_to_instrs prem =
  let at = prem.at in
  match prem.it with
  | Il.IfPr exp -> [ ifI (translate_expr exp, [], []) ~at:at ]
  | Il.ElsePr -> [ otherwiseI [] ~at:at ]
  | Il.LetPr (exp1, exp2, ids) ->
    init_lhs_id ();
    let targets = List.map it ids in
    expr_to_let (translate_expr exp1) (translate_expr exp2) targets []
  | Il.RulePr (id, _, exp) -> rulepr_to_instrs id exp
  | Il.IterPr (pr, iterexp) -> interpr_to_instrs pr iterexp


(* Insert `target` at the innermost if instruction *)
let rec insert_instrs target il =
  match Util.Lib.List.split_last_opt il with
  | [], Some { it = OtherwiseI il'; _ } -> [ otherwiseI (il' @ insert_nop target) ]
  | h, Some { it = IfI (cond, il', []); _ } ->
    h @ [ ifI (cond, insert_instrs (insert_nop target) il' , []) ]
  | _ -> il @ target


(* `premise list` -> `instr list` (return instructions) -> `instr list` *)
let prems_to_instrs =
  List.fold_right (fun prem il -> prem_to_instrs prem |> insert_instrs il)


let helper_to_instrs name clause =
  let Il.DefD (_, _, return_value, prems) = clause.it in

  let return_instrs =
    if name = "instantiate" then
      translate_config return_value |> return_instrs_of_instantiate
    else if name = "invoke" then
      translate_config return_value |> return_instrs_of_invoke
    else
      [ returnI (Some (translate_expr return_value)) ]
  in

  prems_to_instrs prems return_instrs


(* Main translation for helper functions *)
let helpers_to_algo partial_funcs def =
  match def.it with
  | Il.DecD (id, _, _, clauses) when List.length clauses > 0->
    let name = id.it in
    let unified_clauses = Il2il.unify_defs clauses in
    let Il.DefD (_, args, _, _) = List.hd unified_clauses |> it in
    let al_params = translate_args args in
    let blocks = List.map (helper_to_instrs name) unified_clauses in
    let body =
      List.fold_right Transpile.merge blocks []
      |> Transpile.enhance_readability
      |> if List.mem id partial_funcs then Fun.id else Transpile.enforce_return in

    let algo = FuncA (name, al_params, body) in
    Some algo
  | _ -> None


(* Translating helper functions *)
let translate_helpers il =
  (* Get list of partial functions *)
  let get_partial_func_name def =
    let is_partial_hint hint = hint.Il.hintid.it = "partial" in
    match def.it with
    | Il.HintD { it = Il.DecH (id, hints); _ } when List.exists is_partial_hint hints ->
      Some (id)
    | _ -> None
  in
  let partial_funcs = List.filter_map get_partial_func_name il in

  List.filter_map (helpers_to_algo partial_funcs) il


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
      | LetI (lhs, _) when free_expr lhs |> List.mem unbound_variable ->
        instr :: deferred_instrs
      | _ -> [ instr ] in

    let walk_config = { Al.Walk.default_config with post_instr = f } in
    Al.Walk.walk_instrs walk_config


(* `reduction_group` -> `instr list` *)
let reduction_group_to_instrs deferred reduction =
  let _, rhs, prems = reduction in

  (* Translate rhs *)
  rhs_to_instrs rhs
  |> insert_nop
  (* Translate premises *)
  |> prems_to_instrs prems
  (* Translate and insert deferred pop instructions *)
  |> insert_deferred deferred

(* TODO: Perhaps this should be tail recursion *)
let rec split_context_winstr ?(note : Il.typ option) name stack =
  let top = Il.VarT ("TOP" $ no_region, []) $ no_region in
  let wrap typ e = e $$ no_region % typ in
  match stack with
  | [] ->
    let typ = Option.get note in
    [ ([], []), None ], Il.CaseE (Il.Atom (upper name), (Il.TupE []) |> wrap top) |> wrap typ
  | hd :: tl ->
    match hd.it with
    | Il.CaseE (Il.Atom name', _)
      when name = (lower name') || name ^ "_"  = (lower name')
      -> [ (tl, []), None ], hd
    (* Assumption: The target winstr is inside the first list-argument of this CaseE *)
    | Il.CaseE (a, ({it = Il.TupE args; _} as e)) ->
      let is_list e = match e.it with Il.CatE _ | Il.ListE _ -> true | _ -> false in
      let list_arg = List.find is_list args in
      let inner_stack = list_arg |> flatten |> List.rev in

      let context, winstr = split_context_winstr name inner_stack in

      let hole = Il.TextE "_" |> wrap top in
      let holed_args = List.map (fun x -> if x = list_arg then hole else x) args in
      let ctx = { hd with it = Il.CaseE (a, { e with it = Il.TupE holed_args }) } in
      let new_context = ((tl, []), Some ctx) :: context in
      new_context, winstr
    | _ ->
      let context, winstr = split_context_winstr ~note:(hd.note) name tl in
      let ((vs, is), c), inners = Util.Lib.List.split_hd context in
      let new_context = ((vs, hd :: is), c) :: inners in
      new_context, winstr

let un_unify (lhs, rhs, prems) =
  let new_lhs, new_prems = List.fold_left (fun (lhs, pl) p -> match p.it with
  | Il.LetPr (sub, ({ it = Il.VarE uvar; _} as u), _) when Il2il.is_unified_id uvar.it ->
    let new_lhs = Il2il.transform_expr (fun e -> if Il.Eq.eq_exp e u then sub else e) lhs in
    new_lhs, pl
  | _ ->
    lhs, pl @ [p]
  ) (lhs, []) prems in

  new_lhs, rhs, new_prems

let rec kind_of_context e =
  match e.it with
  | Il.CaseE (Il.Atom "FRAME_", _) -> ("frame", "admininstr")
  | Il.CaseE (Il.Atom "LABEL_", _) -> ("label", "admininstr")
  | Il.ListE [ e' ]
  | Il.MixE (_ (* ; *), e')
  | Il.TupE [_ (* z *); e'] -> kind_of_context e'
  | _ -> "Could not get kind_of_context" ^ Il.Print.string_of_exp e |> failwith

let is_in_same_context (lhs1, _, _) (lhs2, _, _) =
  kind_of_context lhs1 = kind_of_context lhs2


(* Main translation for reduction rules
 * `reduction_group list` -> `Backend-prose.Algo` *)
let rec reduction_group_to_algo (instr_name, reduction_group) =
  let lhs, _, _ = List.hd reduction_group in
  let lhs_instrs = drop_state lhs in
  let lhs_stack = lhs_instrs |> flatten |> List.rev in
  let context, winstr = split_context_winstr instr_name lhs_stack in
  let state_instr = if (lhs != lhs_instrs) then [ letI (varE "f", getCurFrameE ()) ] else [] in
  let inner_params = ref None in
  let instrs =
    match context with
    | [(vs, []), None ] ->
      let pop_instrs, defer_opt = vs |> handle_lhs_stack (Il.Free.free_exp winstr) in
      let inner_pop_instrs = handle_context_winstr winstr in

      let instrs' =
        match reduction_group |> Util.Lib.List.split_last with
        (* Either case: No premise for the last reduction rule *)
        | hds, (_, rhs, []) when List.length hds > 0 ->
          assert (defer_opt = None);
          let blocks = List.map (reduction_group_to_instrs None) hds in
          let body1 = List.fold_right Transpile.merge blocks [] in
          let body2 = rhs_to_instrs rhs |> insert_nop in
          eitherI (body1, body2) |> Transpile.push_either
        (* Normal case *)
        | _ ->
          let blocks = List.map (reduction_group_to_instrs defer_opt) reduction_group in
          List.fold_right Transpile.merge blocks []
      in

      pop_instrs @ inner_pop_instrs @ instrs'
    (* The target instruction is inside a context *)
    | [ ([], []), Some context ; (vs, _is), None ] ->
      let head_instrs = handle_context context vs in
      let body_instrs = List.map (reduction_group_to_instrs None) reduction_group |> List.concat in
      head_instrs @ body_instrs
    (* The target instruction is inside different contexts (i.e. return in both label and frame) *)
    | [ ([], [ _ ]), None ] -> ( try
      let orig_group = List.map un_unify reduction_group in
      let sub_groups = list_partition_with is_in_same_context orig_group in
      let unified_sub_groups = List.map (fun g -> Il2il.unify_lhs (instr_name, g)) sub_groups in
      let lhss = List.map (function _, group -> let lhs, _, _ = List.hd group in lhs) unified_sub_groups in
      let sub_algos = List.map reduction_group_to_algo unified_sub_groups in
      List.fold_right2 (fun lhs -> function
        | RuleA (_, params, body) -> fun acc ->
          inner_params |> update_opt params;
          let kind = kind_of_context lhs in
          [ ifI (
            contextKindE (kind, getCurContextE ()),
            body,
            acc) ]
        | _ -> failwith "unreachable")
      lhss sub_algos []
      with
      | _ -> [ yetI "TODO: It is likely that the value stack of two rules are different" ]
      )
    | _ ->
      [ yetI "TODO" ] in

  (* name *)
  let winstr_name =
    match winstr.it with
    | Il.CaseE (Il.Atom winstr_name, _) -> winstr_name
    | _ -> failwith "unreachable"
  in
  let name = kwd winstr_name winstr.note in
  (* params *)
  let al_params =
    match !inner_params with
    | None ->
      if instr_name = "frame" || instr_name = "label"
      then []
      else
        get_params winstr |> List.map translate_expr
    | Some params -> params
  in
  (* body *)
  let body =
    state_instr @ instrs
    |> insert_nop
    |> Transpile.enhance_readability
    |> Transpile.infer_assert
  in

  (* Algo *)
  RuleA (name, al_params, body)

let rule_to_tup rule =
  let Il.RuleD (_, _, _, exp, prems) = rule.it in
  match exp.it with
  | Il.TupE [ lhs; rhs ] -> lhs, rhs, prems
  | _ -> fail_on_exp exp "reduction rule"

(* group reduction rules that have same name *)
let rec group_rules = function
  | [] -> []
  | h :: t ->
    let name = name_of_rule h in
    let t1, t2 =
      List.partition (fun rule -> name_of_rule rule = name) t in
    let grouped_rules = (h :: t1) |> List.map rule_to_tup  in
    (name, grouped_rules) :: group_rules t2

(* extract rules except Steps/..., Step/pure and Step/read *)
let extract_rules def =
  match def.it with
  | Il.RelD (id, _, _, rules) when String.starts_with ~prefix:"Step" id.it ->
    let condition rule =
      let Il.RuleD (ruleid, _, _, _, _) = rule.it in
      id.it <> "Steps" && ruleid.it <> "pure" && ruleid.it <> "read"
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
  |> List.map reduction_group_to_algo


(* Entry *)
let translate il =
  let il = List.concat_map flatten_rec il in
  let algos = translate_helpers il @ translate_rules il in

  (* Transpile *)
  (* Can be turned off *)
  List.map Transpile.remove_state algos
