open Al
open Ast
open Free
open Al_util
open Printf
open Util
open Source
open Def
open Il2al_util

module Il =
struct
  module Atom = El.Atom
  include Il
  include Ast
  include Print
  include Atom
end

(* Errors *)

let error at msg = Error.error at "prose translation" msg

let error_exp exp typ =
  error exp.at (sprintf "unexpected %s: `%s`" typ (Il.Print.string_of_exp exp))

(* Helpers *)

let check_typ_of_exp (ty: string) (exp: Il.exp) =
  match exp.note.it with
  | Il.VarT (id, []) when id.it = ty -> true
  | _ -> false

let is_state: Il.exp -> bool = check_typ_of_exp "state"
let is_store: Il.exp -> bool = check_typ_of_exp "store"
let is_frame: Il.exp -> bool = check_typ_of_exp "frame"
let is_config: Il.exp -> bool = check_typ_of_exp "config"

let split_config (exp: Il.exp): Il.exp * Il.exp =
  assert(is_config exp);
  match exp.it with
  | Il.CaseE ([[]; [{it = Il.Semicolon; _}]; []], {it = TupE [ e1; e2 ]; _})
  when is_state e1 -> e1, e2
  | _ -> assert(false)

let split_state (exp: Il.exp): Il.exp * Il.exp =
  assert(is_state exp);
  match exp.it with
  | Il.CaseE ([[]; [{it = Il.Semicolon; _}]; []], {it = TupE [ e1; e2 ]; _})
  when is_store e1 && is_frame e2 -> e1, e2
  | _ -> assert(false)

let args_of_call e =
  match e.it with
  | CallE (_, args) -> args
  | _ -> error e.at
    (sprintf "cannot get arguments of call expression `%s`" (Print.string_of_expr e))

let expr2arg e = ExpA e $ e.at
let arg2expr a =
  match a.it with
  | ExpA e -> e
  | TypA _ -> error a.at "Argument is not an expression"

(* Utils for IL *)
let is_case e =
  match e.it with
  | Il.CaseE _ -> true
  | _ -> false
let args_of_case e =
  match e.it with
  | Il.CaseE (_, { it = Il.TupE exps; _ }) -> exps
  | Il.CaseE (_, exp) -> [ exp ]
  | _ -> error e.at
    (sprintf "cannot get arguments of case expression `%s`" (Il.Print.string_of_exp e))

let context_names = [
  "FRAME_";
  "LABEL_";
  "HANDLER_";
]

let is_context exp =
  is_case exp &&
  match case_of_case exp with
  | (atom :: _) :: _ ->
    (match it atom with
    | Atom a -> List.mem a context_names
    | _ -> false)
  | _ -> false

let name_of_rule rule =
  match rule.it with
  | Il.RuleD (id, _, _, _, _) ->
    String.split_on_char '-' id.it |> List.hd

let args_of_clause clause =
  match clause.it with
  | Il.DefD (_, args, _, _) -> args

let contains_ids ids expr =
  ids
  |> IdSet.of_list
  |> IdSet.disjoint (free_expr expr)
  |> not

(* Insert `target` at the innermost if instruction *)
let rec insert_instrs target il =
  match Util.Lib.List.split_last_opt il with
  | Some ([], { it = OtherwiseI il'; _ }) -> [ otherwiseI (il' @ Transpile.insert_nop target) ]
  | Some (h, { it = IfI (cond, il', []); _ }) ->
    h @ [ ifI (cond, insert_instrs (Transpile.insert_nop target) il' , []) ]
  | _ -> il @ target

(* Insert `target` at the else-branch of innermost if instruction *)
let rec insert_instrs_to_else target il =
  match Util.Lib.List.split_last_opt il with
  | Some (h, { it = IfI (cond, il1, il2); _ }) ->
    h @ [ ifI (cond, il1, insert_instrs_to_else target il2) ]
  | _ -> il @ target

let has_branch = List.exists (fun i ->
  match i.it with
  | IfI _
  | OtherwiseI _ -> true
  | _ -> false
)
let is_winstr_prem = is_let_prem_with_rhs_type "inputT"

let lhs_of_prem pr =
  match pr.it with
  | Il.LetPr (lhs, _, _) -> lhs
  | _ -> Error.error pr.at "prose translation" "expected a LetPr"

let rec is_wasm_value e =
  (* TODO: use hint? *)
  match e.it with
  | Il.SubE (e, _, _) -> is_wasm_value e
  | Il.CaseE ([{it = Atom id; _}]::_, _) when
    List.mem id [
      "CONST";
      "VCONST";
      "REF.I31_NUM";
      "REF.STRUCT_ADDR";
      "REF.ARRAY_ADDR";
      "REF.EXN_ADDR";
      "REF.FUNC_ADDR";
      "REF.HOST_ADDR";
      "REF.EXTERN";
      "REF.NULL"
    ] -> true
  | Il.CallE (id, _) when id.it = "const" -> true
  | _ -> Valid.sub_typ e.note valT
let is_wasm_instr e =
  (* TODO: use hint? *)
  Valid.sub_typ e.note instrT || Valid.sub_typ e.note admininstrT

let split_vals (exp: Il.exp): Il.exp list * Il.exp list =
  (* ASSUMPTION: exp is of the form v* i* *)
  let rec spread_cat e =
    match e.it with
    | Il.CatE (e1, e2) -> spread_cat e1 @ spread_cat e2
    | Il.ListE es -> List.map (fun e' -> {e' with it = Il.ListE [e']; note = e.note}) es
    | _ -> [e]
  in
  let is_wasm_values e =
    match e.it with
    | Il.IterE (e, _) -> is_wasm_value e
    | Il.ListE es -> List.for_all is_wasm_value es
    | _ -> false
  in

  spread_cat exp
  |> List.partition is_wasm_values

let concat_exprs es =
  match es with
  | [] -> assert false
  | hd :: tl -> List.fold_left (fun e1 e2 ->
    catE (e1, e2) ~at:(over_region [e1.at; e2.at]) ~note:hd.note
  ) hd tl

(** Translation *)

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
  let note = exp.note in
  match exp.it with
  | Il.NatE n -> numE n ~at:at ~note:note
  | Il.BoolE b -> boolE b ~at:at ~note:note
  (* List *)
  | Il.LenE inner_exp -> lenE (translate_exp inner_exp) ~at:at ~note:note
  | Il.ListE exps -> listE (List.map translate_exp exps) ~at:at ~note:note
  | Il.IdxE (exp1, exp2) ->
    accE (translate_exp exp1, idxP (translate_exp exp2)) ~at:at ~note:note
  | Il.SliceE (exp1, exp2, exp3) ->
    accE (translate_exp exp1, sliceP (translate_exp exp2, translate_exp exp3)) ~at:at ~note:note
  | Il.CatE (exp1, exp2) -> catE (translate_exp exp1, translate_exp exp2) ~at:at ~note:note
  (* Variable *)
  | Il.VarE id -> varE id.it ~at:at ~note:note
  | Il.SubE ({ it = Il.VarE id; _}, t, _) -> subE (id.it, t) ~at:at ~note:note
  | Il.SubE (inner_exp, _, _) -> translate_exp inner_exp
  | Il.IterE (inner_exp, (iter, ids)) ->
    let names = List.map (fun (id, _) -> id.it) ids in
    iterE (translate_exp inner_exp, names, translate_iter iter) ~at:at ~note:note
  (* property access *)
  | Il.DotE (inner_exp, ({it = Atom _; _} as atom)) ->
    accE (translate_exp inner_exp, dotP atom) ~at:at ~note:note
  (* concatenation of records *)
  | Il.CompE (exp1, exp2) -> compE (translate_exp exp1, translate_exp exp2) ~at:at ~note:note
  (* extension of record field *)
  | Il.ExtE (base, path, v) -> extE (translate_exp base, translate_path path, translate_exp v, Back) ~at:at ~note:note
  (* update of record field *)
  | Il.UpdE (base, path, v) -> updE (translate_exp base, translate_path path, translate_exp v) ~at:at ~note:note
  (* Binary / Unary operation *)
  | Il.UnE (op, exp) ->
    let exp' = translate_exp exp in
    let op = match op with
    | Il.NotOp -> NotOp
    | Il.MinusOp _ -> MinusOp
    | _ -> error_exp exp "AL unary expression"
    in
    unE (op, exp') ~at:at ~note:note
  | Il.BinE (op, exp1, exp2) ->
    let lhs = translate_exp exp1 in
    let rhs = translate_exp exp2 in
    let op =
      match op with
      | Il.AddOp _ -> AddOp
      | Il.SubOp _ -> SubOp
      | Il.MulOp _ -> MulOp
      | Il.DivOp _ -> DivOp
      | Il.ModOp _ -> ModOp
      | Il.ExpOp _ -> ExpOp
      | Il.AndOp -> AndOp
      | Il.OrOp -> OrOp
      | Il.ImplOp -> ImplOp
      | Il.EquivOp -> EquivOp
    in
    binE (op, lhs, rhs) ~at:at ~note:note
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
    binE (compare_op, lhs, rhs) ~at:at ~note:note
  (* Set operation *)
  | Il.MemE (exp1, exp2) ->
    let lhs = translate_exp exp1 in
    let rhs = translate_exp exp2 in
    memE (lhs, rhs) ~at:at ~note:note
  (* Tuple *)
  | Il.TupE [e] -> translate_exp e
  | Il.TupE exps -> tupE (List.map translate_exp exps) ~at:at ~note:note
  (* Call *)
  | Il.CallE (id, args) -> callE (id.it, translate_args args) ~at:at ~note:note
  (* Record expression *)
  | Il.StrE expfields ->
    let f acc = function
      | {it = Il.Atom _; _} as atom, fieldexp ->
        let expr = translate_exp fieldexp in
        Record.add atom expr acc
      | _ -> error_exp exp "AL record expression"
    in
    let record = List.fold_left f Record.empty expfields in
    strE record ~at:at ~note:note
  (* CaseE *)
  | Il.CaseE (op, e) -> (
    let exps =
      match e.it with
      | TupE exps -> exps
      | _ -> [ e ]
    in
    match (op, exps) with
    (* Constructor *)
    (* TODO: Need a better way to convert these CaseE into ConstructE *)
    (* TODO: type *)
    | [ []; [] ], [ e1 ] -> translate_exp e1
    | [ []; []; [] ], [ e1; e2 ]
    | [ [{it = Il.LBrack; _}]; [{it = Il.Dot2; _}]; [{it = Il.RBrack; _}] ], [ e1; e2 ]
    | [ []; [{it = Il.Semicolon; _}]; [] ], [ e1; e2 ] ->
      tupE [ translate_exp e1; translate_exp e2 ] ~at:at ~note:note
    | _, _ when List.length op = List.length exps + 1 ->
      caseE (op, translate_argexp e) ~at:at ~note:note
    | _ -> yetE (Il.Print.string_of_exp exp) ~at:at ~note:note
    )
  | Il.UncaseE (e, op) ->
    (match op with
    | [ []; [] ] -> translate_exp e
    | _ -> yetE (Il.Print.string_of_exp exp) ~at:at ~note:note
    )
  | Il.ProjE (e, 0) -> translate_exp e
  | Il.OptE inner_exp -> optE (Option.map translate_exp inner_exp) ~at:at ~note:note
  | Il.TheE e -> (
    match note.it with
    | Il.IterT (typ, _) -> chooseE (translate_exp e)  ~at:at ~note:typ
    | _ -> error_exp exp "TheE"
  )
  (* Yet *)
  | _ -> yetE (Il.Print.string_of_exp exp) ~at:at ~note:note

(* `Il.exp` -> `expr list` *)
and translate_argexp exp =
  match exp.it with
  | Il.TupE el -> List.map translate_exp el
  | _ -> [ translate_exp exp ]

(* `Il.arg list` -> `expr list` *)
and translate_args args = List.concat_map ( fun arg ->
  match arg.it with
  | Il.ExpA e -> [ ExpA (translate_exp e) $ arg.at ]
  | Il.TypA typ -> [ TypA typ $ arg.at ]
  | Il.DefA _ -> [] (* TODO: handle functions *)
  | Il.GramA _ -> [] ) args

(* `Il.path` -> `path list` *)
and translate_path path =
  let rec translate_path' path =
    let at = path.at in
    match path.it with
    | Il.RootP -> []
    | Il.IdxP (p, e) -> (translate_path' p) @ [ idxP (translate_exp e) ~at:at ]
    | Il.SliceP (p, e1, e2) -> (translate_path' p) @ [ sliceP (translate_exp e1, translate_exp e2) ~at:at ]
    | Il.DotP (p, ({it = Atom _; _} as atom)) ->
      (translate_path' p) @ [ dotP atom ~at:at ]
    | _ -> assert false
  in
  translate_path' path

let insert_assert exp =
  let at = exp.at in
  match exp.it with
  | Il.CaseE ([{it = Il.Atom "FRAME_"; _}]::_, _) ->
    assertI (topFrameE () ~note:boolT) ~at:at
  | Il.IterE (_, (Il.ListN (e, None), _)) ->
    assertI (topValuesE (translate_exp e) ~at:at ~note:boolT) ~at:at
  | Il.CaseE ([{it = Il.Atom "LABEL_"; _}]::_, { it = Il.TupE [ _n; _instrs; _vals ]; _ }) ->
    assertI (topLabelE () ~at:at ~note:boolT) ~at:at
  | Il.CaseE ([{it = Il.Atom "HANDLER_"; _}]::_, _) ->
    assertI (yetE "a handler is now on the top of the stack" ~at:at ~note:boolT) ~at:at
  | Il.CaseE ([{it = Il.Atom "CONST"; _}]::_, { it = Il.TupE (ty' :: _); _ }) ->
    assertI (topValueE (Some (translate_exp ty')) ~note:boolT) ~at:at
  | _ ->
    assertI (topValueE None ~note:boolT) ~at:at

let cond_of_pop_value e =
  let at = e.at in
  let bt = boolT in
  match e.it with
  | CaseE (op, [t; _]) ->
    (match get_atom op with
    | Some {it = Il.Atom "CONST"; _} -> topValueE (Some t) ~note:bt
    | Some {it = Il.Atom "VCONST"; _} -> topValueE (Some t) ~note:bt
    | _ -> topValueE None ~note:bt
    )
  | GetCurFrameE ->
    topFrameE () ~at:at ~note:bt
  | GetCurLabelE ->
    topLabelE () ~at:at ~note:bt
  (* TODO: Remove this when pops is done *)
  | IterE (_, _, ListN (e', _)) ->
    topValuesE e' ~at:at ~note:bt
  | _ ->
    topValueE None ~note:bt

let post_process_of_pop i =
  let at = i.at in

  match i.it with
  | PopI e -> assertI (cond_of_pop_value e) ~at:at :: [i]
  | PopAllI _ -> [i]
  | _ -> error at "not PopI nor PopallI"

(* TODO: remove this *)
let insert_pop' e =
  let valsT = listT valT in
  let pop =
    match e.it with
    | Il.ListE [e'] ->
      popI { (translate_exp e') with note = valT } ~at:e'.at
    | Il.ListE es ->
      popsI { (translate_exp e) with note = valsT } (Some (es |> List.length |> Z.of_int |> numE)) ~at:e.at
    | Il.IterE (_, (Il.ListN (e', None), _)) ->
      popsI { (translate_exp e) with note = valsT } (Some (translate_exp e')) ~at:e.at
    | _ ->
      popsI { (translate_exp e) with note = valsT } None ~at:e.at
  in
  post_process_of_pop pop

let insert_pop e e_n =
  let valsT = listT valT in
  let pop =
    match e.it, e_n.it with
    | ListE [e'], _ ->
      popI { e' with note = valT } ~at:e'.at
    | _, NumE z when z = Z.minus_one ->
      popAllI { e with note = valsT } ~at:e.at
    | _ ->
      popsI { e with note = valsT } (Some e_n) ~at:e.at
  in
  post_process_of_pop pop

let rec translate_rhs exp =
  let at = exp.at in
  match exp.it with
  (* Trap *)
  | Il.CaseE ([{it = Atom "TRAP"; _}]::_, _) -> [ trapI () ~at:at ]
  (* Context *)
  | _ when is_context exp -> translate_context_rhs exp
  (* Config *)
  | _ when is_config exp ->
    let state, rhs = split_config exp in
    (match state.it with
    | Il.CallE (f, ae) ->
      let perform_instr       = performI (f.it, translate_args ae) ~at:state.at in
      let push_or_exec_instrs = translate_rhs rhs in
      (match Lib.List.last_opt push_or_exec_instrs with
      | Some { it = ExecuteI _; _ } ->
        [ perform_instr ] @ push_or_exec_instrs
      | _ -> (* HARDCODE: TABLE.GROW *)
        push_or_exec_instrs @ [ perform_instr ])
    | _ -> translate_rhs rhs
    )
  (* Recursive case *)
  | Il.SubE (inner_exp, _, _) -> translate_rhs inner_exp
  | Il.CatE (e1, e2) -> translate_rhs e1 @ translate_rhs e2
  | Il.ListE es -> List.concat_map translate_rhs es
  | Il.IterE (inner_exp, (Opt, _itl)) ->
    (* NOTE: Assume that no other iter is nested for Opt *)
    (* TODO: better name using type *)
    let tmp_name = Il.VarE ("instr_0" $ no_region) $$ no_region % inner_exp.note in
    [ ifI (
      isDefinedE (translate_exp exp) ~note:boolT,
      letI (OptE (Some (translate_exp tmp_name)) $$ exp.at % exp.note, translate_exp exp) ~at:at :: translate_rhs tmp_name,
      []
    ) ~at:at ]
  | Il.IterE (inner_exp, (iter, itl)) ->
    let iter_ids = itl |> List.map fst |> List.map it in
    let walk_expr _walker (expr: expr): expr =
      let typ = Il.IterT (expr.note, Il.List) $ no_region in
      IterE (expr, iter_ids, translate_iter iter) $$ exp.at % typ
    in
    let walker = { Walk.base_walker with walk_expr } in

    let instrs = translate_rhs inner_exp in
    List.concat_map (walker.walk_instr walker) instrs
  (* Value *)
  | _ when is_wasm_value exp -> [ pushI {(translate_exp exp) with note = valT} ]
  (* Instr *)
  | _ when is_wasm_instr exp -> [ executeI (translate_exp exp) ]
  | _ -> error_exp exp "expression on rhs of reduction"

and translate_context_rhs exp =
  let at = exp.at in
  let note = exp.note in
  let notes = listT note in

  let case = case_of_case exp in
  let atom = case |> List.hd |> List.hd in
  let args = args_of_case exp in
  let case' = case |> Lib.List.split_last |> fst in

  match atom.it, args with
  | Il.Atom "FRAME_", [exp1; exp2; exp3] ->
    let e1 = translate_exp exp1 in (* arity *)
    let e2 = translate_exp exp2 in (* frame *)
    let e3 = translate_rhs exp3 in (* label *)

    let eF = varE "F"             ~at:at ~note:callframeT in (* frame id *)
    let ef = frameE (Some e1, e2) ~at:at ~note:callframeT in (* frame *)

    let e' = caseE ([[atom]], []) ~note:note in
    [
      letI (eF, ef) ~at:at;
      enterI (eF, listE [e'] ~note:notes, e3) ~at:at;
    ]
  | Il.Atom "LABEL_", [exp1; exp2; exp3] ->
    let e1 = translate_exp exp1 in (* arity *)
    let e2 = translate_exp exp2 in (* cont *)
    let e3 = translate_exp exp3 in (* instrs *)

    let eL = varE "L"        ~at:at ~note:labelT in (* label id *)
    let el = labelE (e1, e2) ~at:at ~note:labelT in (* label *)

    let at' = exp3.at in
    let note' = exp3.note in
    let exp'' = listE ([caseE ([[atom]], []) ~note:note]) ~at:at' ~note:note' in
    (match exp3.it with
    | Il.CatE (ve, ie) ->
      [
        letI (eL, el) ~at:at;
        enterI (eL, catE (translate_exp ie, exp'') ~note:note', [pushI (translate_exp ve)]) ~at:at';
      ]
    | _ ->
      [
        letI (eL, el) ~at:at;
        enterI (eL, catE(e3, exp'') ~note:note', []) ~at:at';
      ]
    )
  | Il.Atom "HANDLER_", [exp1; exp2; exp3] ->
    (match exp3.it with
    | ListE [ctxt] when is_context ctxt ->
      (* TODO: This case is very similar to Frame. Perhaps it can be generalized? *)
      let e1 = translate_exp exp1 in (* arity *)
      let e2 = translate_exp exp2 in (* catch *)
      let e3 = translate_rhs exp3 in (* label *)

      let eH = varE "H"                ~at:at ~note:handlerT in (* handler id *)
      let eh = caseE (case', [e1; e2]) ~at:at ~note:handlerT in (* handler *)

      let e' = caseE ([[atom]], []) ~note:note in
      [
        letI (eH, eh) ~at:at;
        enterI (eH, listE [e'] ~note:notes, e3) ~at:at;
      ]
    | _ ->
      (* TODO: This case is very similar to Label. Perhaps it can be generalized? *)
      let e1 = translate_exp exp1 in (* arity *)
      let e2 = translate_exp exp2 in (* catch *)
      let e3 = translate_exp exp3 in (* instrs *)

      let eH = varE "H"                ~at:at ~note:handlerT in (* handler id *)
      let eh = caseE (case', [e1; e2]) ~at:at ~note:handlerT in (* handler *)

      let at' = exp3.at in
      let note' = exp3.note in
      let exp' = caseE ([[atom]], []) ~note:note in
      let exp'' = listE ([exp']) ~at:at' ~note:note' in

      (match exp3.it with
      | Il.ListE [ve; ie] -> (* HARDCODE *)
        [
          letI (eH, eh) ~at:at;
          enterI (eH, listE [translate_exp ie; exp'] ~note:note', [pushI (translate_exp ve)]) ~at:at';
        ]
      | _ ->
        [
          letI (eH, eh) ~at:at;
          enterI (eH, catE(e3, exp'') ~note:note', []) ~at:at';
        ]
      )
    )
  | _ -> error at ("unrecognized context: " ^ (Il.Print.string_of_atom atom))


(* Handle pattern matching *)

let lhs_id_ref = ref 0
(* let lhs_prefix = "y_" *)
let init_lhs_id () = lhs_id_ref := 0
let get_lhs_name e =
  let lhs_id = !lhs_id_ref in
  lhs_id_ref := (lhs_id + 1);
  varE (typ_to_var_name e.note ^ "_" ^ string_of_int lhs_id) ~note:e.note


(* Helper functions *)
let rec contains_name e = match e.it with
  | VarE _ | SubE _ -> true
  | IterE (e', _, _) -> contains_name e'
  | _ -> false

let extract_non_names =
  List.fold_left_map (fun acc e ->
    if contains_name e then acc, e
    else
      let fresh = get_lhs_name e in
      [ e, fresh ] @ acc, fresh
  ) []

let contains_diff target_ns e =
  let free_ns = free_expr e in
  not (IdSet.is_empty free_ns) && IdSet.disjoint free_ns target_ns

let handle_partial_bindings lhs rhs ids =
  match lhs.it with
  | CallE (_, _) -> lhs, rhs, []
  | _ ->
    let conds = ref [] in
    let target_ns = IdSet.of_list ids in
    let pre_expr = (fun e ->
      if not (contains_diff target_ns e) then
        e
      else (
        let new_e = get_lhs_name e in
        conds := !conds @ [ BinE (EqOp, new_e, e) $$ no_region % boolT ];
        new_e
      )
    ) in
    let walk_expr walker expr = 
      let stop_cond_expr = contains_diff target_ns in
      let expr1 = pre_expr expr in
      if stop_cond_expr expr1 then expr1 else Al.Walk.base_walker.walk_expr walker expr1
    in
    let walker = {Al.Walk.base_walker with walk_expr = walk_expr} in
    let new_lhs = walker.walk_expr walker lhs in
    new_lhs, rhs, List.fold_left (fun il c -> [ ifI (c, il, []) ]) [] !conds

let rec translate_bindings ids bindings =
  List.fold_right (fun (l, r) cont ->
    match l with
    | _ when IdSet.is_empty (free_expr l) ->
      [ ifI (BinE (EqOp, r, l) $$ no_region % boolT, [], []) ]
    | _ -> insert_instrs cont (handle_special_lhs l r ids)
  ) bindings []

and call_lhs_to_inverse_call_rhs lhs rhs free_ids =

  (* Get CallE fields *)

  let f, args =
    match lhs.it with
    | CallE (f, args) -> f, args
    | _ -> assert (false);
  in

  (* Helper functions *)
  let contains_free a =
    match a.it with
    | ExpA e -> contains_ids free_ids e
    | TypA _ -> false
  in
  let rhs2args e =
    (match e.it with
    | TupE el -> el
    | _ -> [ e ]
    ) |> List.map expr2arg
  in
  let args2lhs args =
    let es = List.map arg2expr args in
    if List.length es = 1 then
      List.hd es
    else
      let typ = Il.TupT (List.map (fun e -> no_name, e.note) es) $ no_region in
      TupE es $$ no_region % typ
  in

  (* All arguments are free *)

  if List.for_all contains_free args then
    let new_lhs = args2lhs args in
    let indices = List.init (List.length args) Option.some in
    let new_rhs =
      InvCallE (f, indices, rhs2args rhs) $$ lhs.at % new_lhs.note
    in
    new_lhs, new_rhs

  (* Some arguments are free  *)

  else if List.exists contains_free args then
    (* Distinguish free arguments and bound arguments *)
    let free_args_with_index, bound_args =
      args
      |> List.mapi (fun i arg ->
          if contains_free arg then Some (arg, i), None
          else None, Some arg
        )
      |> List.split
    in
    let bound_args = List.filter_map (fun x -> x) bound_args in
    let indices = List.map (Option.map snd) free_args_with_index in
    let free_args =
      free_args_with_index
      |> List.filter_map (Option.map fst)
    in

    (* Free argument become new lhs & InvCallE become new rhs *)
    let new_lhs = args2lhs free_args in
    let new_rhs =
      InvCallE (f, indices, bound_args @ rhs2args rhs) $$ lhs.at % new_lhs.note
    in
    new_lhs, new_rhs

  (* No argument is free *)

  else
    Print.string_of_expr lhs
    |> sprintf "lhs expression %s doesn't contain free variable"
    |> error lhs.at

and handle_call_lhs lhs rhs free_ids =

  (* Helper function *)

  let matches typ1 typ2 = Valid.sub_typ typ1 typ2 || Valid.sub_typ typ2 typ1 in

  (* LHS type and RHS type are the same: normal inverse function *)

  if matches lhs.note rhs.note then
    let new_lhs, new_rhs = call_lhs_to_inverse_call_rhs lhs rhs free_ids in
    handle_special_lhs new_lhs new_rhs free_ids

  (* RHS has more iter: it is in map translation process *)

  else

    let rec get_base_typ_and_iters typ1 typ2 =
      match typ1.it, typ2.it with
      | _, Il.IterT (typ2', iter) when not (matches typ1 typ2) ->
        let base_typ, iters = get_base_typ_and_iters typ1 typ2' in
        base_typ, iter :: iters
      | _, _ when matches typ1 typ2 -> typ2, []
      | _ ->
        error lhs.at
          (sprintf "lhs type %s mismatch with rhs type %s"
            (Il.string_of_typ lhs.note) (Il.string_of_typ rhs.note)
          )
    in

    let base_typ, map_iters =  get_base_typ_and_iters lhs.note rhs.note in
    (* TODO: Better name using type *)
    let var_name = typ_to_var_name base_typ in
    let var_expr = VarE var_name $$ no_region % base_typ in
    let to_iter_expr =
      List.fold_right
        (fun iter e ->
          let iter_typ = Il.IterT (e.note, iter) $ no_region in
          IterE (e, [var_name], translate_iter iter) $$ e.at % iter_typ
        )
        map_iters
    in

    let new_lhs, new_rhs = call_lhs_to_inverse_call_rhs lhs var_expr free_ids in
    (* Introduce new variable for map *)
    let let_instr = letI (to_iter_expr var_expr, rhs) in
    let_instr :: handle_special_lhs new_lhs (to_iter_expr new_rhs) free_ids

and handle_iter_lhs lhs rhs free_ids =

  (* Get IterE fields *)

  let inner_lhs, iter_ids, iter =
    match lhs.it with
    | IterE (inner_lhs, iter_ids, iter) ->
      inner_lhs, iter_ids, iter
    | _ -> assert (false);
  in

  (* Helper functions *)

  let iter_ids_of (expr: expr): string list =
    expr
    |> free_expr
    |> IdSet.inter (IdSet.of_list iter_ids)
    |> IdSet.elements
  in
  let walk_expr (walker: Walk.walker) (expr: expr): expr =
    if contains_ids iter_ids expr then
      let iter', typ =
        match iter with
        | Opt -> iter, Il.IterT (expr.note, Il.Opt) $ no_region
        | ListN (expr', None) when not (contains_ids free_ids expr') ->
          List, Il.IterT (expr.note, Il.List) $ no_region
        | _ -> iter, Il.IterT (expr.note, Il.List) $ no_region
      in
      IterE (expr, iter_ids_of expr, iter') $$ lhs.at % typ
    else
      (Option.get walker.super).walk_expr walker expr
  in

  (* Translate inner lhs *)

  let instrs = handle_special_lhs inner_lhs rhs free_ids in

  (* Iter injection *)

  let walker = { Walk.base_walker with super = Some Walk.base_walker; walk_expr } in
  let instrs' = List.concat_map (walker.walk_instr walker) instrs in

  (* Add ListN condition *)
  match iter with
  | ListN (expr, None) when not (contains_ids free_ids expr) ->
    let at = over_region [ lhs.at; rhs.at ] in
    assertI (BinE (EqOp, lenE rhs ~note:expr.note, expr) $$ at % boolT) :: instrs'
  | _ -> instrs'

and handle_special_lhs lhs rhs free_ids =
  let at = over_region [ lhs.at; rhs.at ] in
  match lhs.it with
  (* Handle encoded premises generated by `encode.ml` *)
  | _ when (Il.Print.string_of_typ rhs.note) = "inputT" -> []
  | _ when (Il.Print.string_of_typ rhs.note) = "stateT" -> []
  | _ when (Il.Print.string_of_typ rhs.note) = "unusedT" -> []
  | _ when (Il.Print.string_of_typ rhs.note) = "contextT" -> []
  | TupE [e; _stack] when (Il.Print.string_of_typ rhs.note) = "stackT" ->
    let args = args_of_call rhs in
    let pop_num = List.hd args |> arg2expr in
    insert_pop e pop_num
  (* Handle inverse function call *)
  | CallE _ -> handle_call_lhs lhs rhs free_ids
  (* Handle iterator *)
  | IterE _ -> handle_iter_lhs lhs rhs free_ids
  (* Handle subtyping *)
  | SubE (s, t) ->
    let rec inject_hasType expr =
      match expr.it with
      | IterE (inner_expr, ids, iter) ->
        IterE (inject_hasType inner_expr, ids, iter) $$ expr.at % boolT
      | _ -> HasTypeE (expr, t) $$ rhs.at % boolT
    in
    [ ifI (
      inject_hasType rhs,
      [ letI (VarE s $$ lhs.at % lhs.note, rhs) ~at:at ],
      []
    )]
  (* Normal cases *)
  | CaseE (op, es) ->
    let tag = get_atom op |> Option.get in
    let bindings, es' = extract_non_names es in
    let rec inject_isCaseOf expr =
      match expr.it with
      | IterE (inner_expr, ids, iter) ->
        IterE (inject_isCaseOf inner_expr, ids, iter) $$ expr.at % boolT
      | _ -> IsCaseOfE (expr, tag) $$ rhs.at % boolT
    in
    (match tag with
    | { it = Il.Atom _; _} ->
      [ ifI (
        inject_isCaseOf rhs,
        letI (caseE (op, es') ~at:lhs.at ~note:lhs.note, rhs) ~at:at
        :: translate_bindings free_ids bindings,
        []
      )]
    | _ ->
      letI (caseE (op, es') ~at:lhs.at ~note:lhs.note, rhs) ~at:at
      :: translate_bindings free_ids bindings)
  | ListE es ->
    let bindings, es' = extract_non_names es in
    if List.length es >= 2 then (* TODO: remove this. This is temporarily for a pure function returning stores *)
      letI (listE es' ~at:lhs.at ~note:lhs.note, rhs) ~at:at :: translate_bindings free_ids bindings
    else
      [
        ifI
          ( binE (EqOp, lenE rhs ~note:natT, numE (Z.of_int (List.length es)) ~note:natT) ~note:boolT,
            letI (listE es' ~at:lhs.at ~note:lhs.note, rhs) ~at:at :: translate_bindings free_ids bindings,
            [] );
      ]
  | OptE None ->
    [
      ifI
        ( unE (NotOp, isDefinedE rhs ~note:boolT) ~note:boolT,
          [],
          [] );
    ]
  | OptE (Some ({ it = VarE _; _ })) ->
    [
      ifI
        ( isDefinedE rhs ~note:boolT,
          [letI (lhs, rhs) ~at:at],
          [] );
     ]
  | OptE (Some e) ->
    let fresh = get_lhs_name e in
    [
      ifI
        ( isDefinedE rhs ~note:boolT,
          letI (optE (Some fresh) ~at:lhs.at ~note:lhs.note, rhs) ~at:at :: handle_special_lhs e fresh free_ids,
          [] );
     ]
  | BinE (AddOp, a, b) ->
    [
      ifI
        ( binE (GeOp, rhs, b) ~note:boolT,
          [letI (a, binE (SubOp, rhs, b) ~at:at ~note:natT) ~at:at],
          [] );
    ]
  | CatE (prefix, suffix) ->
    let handle_list e =
      match e.it with
      | ListE es ->
        let bindings', es' = extract_non_names es in
        Some (numE (Z.of_int (List.length es)) ~note:natT), bindings', listE es' ~note:e.note
      | IterE (({ it = VarE _; _ } | { it = SubE _; _ }), _, ListN (e', None)) ->
        Some e', [], e
      | _ ->
        None, [], e in
    let length_p, bindings_p, prefix' = handle_list prefix in
    let length_s, bindings_s, suffix' = handle_list suffix in
    (* TODO: This condition should be injected by sideconditions pass *)
    let cond = match length_p, length_s with
      | None, None -> yetE ("Nondeterministic assignment target: " ^ Al.Print.string_of_expr lhs) ~note:boolT
      | Some l, None
      | None, Some l -> binE (GeOp, lenE rhs ~note:l.note, l) ~note:boolT
      | Some l1, Some l2 -> binE (EqOp, lenE rhs ~note:l1.note, binE (AddOp, l1, l2) ~note:natT) ~note:boolT
    in
    [
      ifI
        ( cond,
          letI (catE (prefix', suffix') ~at:lhs.at ~note:lhs.note, rhs) ~at:at
            :: translate_bindings free_ids (bindings_p @ bindings_s),
          [] );
    ]
  | _ -> [letI (lhs, rhs) ~at:at]

let translate_letpr lhs rhs ids =
  (* Translate *)
  let al_lhs, al_rhs = translate_exp lhs, translate_exp rhs in

  (* Handle partial bindings *)
  let al_lhs', al_rhs', cond_instrs = handle_partial_bindings al_lhs al_rhs ids in

  (* Construct binding instructions *)
  let instrs = handle_special_lhs al_lhs' al_rhs' ids in

  (* Insert conditions *)
  if List.length cond_instrs = 0 then instrs
  else insert_instrs cond_instrs instrs


(* HARDCODE: Translate each RulePr manually based on their names *)
let translate_rulepr id exp =
  let at = id.at in
  let expA e = ExpA e $ e.at in
  match id.it, translate_argexp exp with
  | "Eval_expr", [z; is; z'; vs] ->
    (* Note: State is automatically converted into frame by remove_state *)
    (* Note: Push/pop is automatically inserted by handle_frame *)
    let lhs = tupE [z'; vs] ~at:(over_region [z'.at; vs.at]) ~note:vs.note in
    let rhs = callE ("eval_expr", [ expA z; expA is ]) ~note:vs.note in
    [ letI (lhs, rhs) ~at:at ]
  (* ".*_sub" *)
  | name, [_C; rt1; rt2]
    when String.ends_with ~suffix:"_sub" name ->
    [ ifI (matchE (rt1, rt2) ~at:at ~note:boolT, [], []) ~at:at ]
  (* ".*_ok" *)
  | name, el when String.ends_with ~suffix: "_ok" name ->
    (match el with
    | [_; e; t] | [e; t] -> [ assertI (callE (name, [expA e; expA t]) ~at:at ~note:boolT) ~at:at]
    | _ -> error_exp exp "unrecognized form of argument in rule_ok"
    )
  (* ".*_const" *)
  | name, el
    when String.ends_with ~suffix: "_const" name ->
    [ assertI (callE (name, el |> List.map expA) ~at:at ~note:boolT) ~at:at]
  | _ ->
    print_yet exp.at "translate_rulepr" ("`" ^ Il.Print.string_of_exp exp ^ "`");
    [ yetI ("TODO: translate_rulepr " ^ id.it) ~at:at ]

let rec translate_iterpr pr (iter, ids) =
  let instrs = translate_prem pr in
  let iter', ids' = translate_iter iter, IdSet.of_list (List.map (fun (id, _) -> id.it) ids) in
  let lhs_iter = match iter' with | ListN (e, _) -> ListN (e, None) | _ -> iter' in

  let handle_iter_ty ty =
    match iter' with
    | Opt -> iterT ty Il.Opt
    | List | List1 | ListN _ when ty <> boolT -> listT ty
    | _ -> ty
  in

  let distribute_iter lhs rhs =
    let lhs_ids = IdSet.elements (IdSet.inter (free_expr lhs) ids') in
    let rhs_ids = IdSet.elements (IdSet.inter (free_expr rhs) ids') in
    let ty = handle_iter_ty lhs.note in
    let ty' = handle_iter_ty rhs.note in

    assert (List.length (lhs_ids @ rhs_ids) > 0);
    iterE (lhs, lhs_ids, lhs_iter) ~at:lhs.at ~note:ty, iterE (rhs, rhs_ids, iter') ~at:rhs.at ~note:ty'
  in

  let post_instr i =
    let at = i.at in
    match i.it with
    | LetI (lhs, rhs) -> [letI (distribute_iter lhs rhs) ~at:at]
    | IfI (cond, il1, il2) ->
        let cond_ids = IdSet.elements (IdSet.inter (free_expr cond) ids') in
        let ty = handle_iter_ty cond.note in
        [ifI (iterE (cond, cond_ids, iter') ~at:cond.at ~note:ty, il1, il2) ~at:at]
    | _ -> [i]
  in
  let walk_instr walker instr = 
    let instr1 = Al.Walk.base_walker.walk_instr walker instr in
    List.concat_map post_instr instr1
  in
  let walker = {Al.Walk.base_walker with walk_instr = walk_instr} in
  List.concat_map (walker.walk_instr walker) instrs

and translate_prem prem =
  let at = prem.at in
  match prem.it with
  | Il.IfPr exp -> [ ifI (translate_exp exp, [], []) ~at:at ]
  | Il.ElsePr -> [ otherwiseI [] ~at:at ]
  | Il.LetPr (exp1, exp2, ids) ->
    init_lhs_id ();
    translate_letpr exp1 exp2 ids
  | Il.RulePr (id, _, exp) -> translate_rulepr id exp
  | Il.IterPr (pr, exp) -> translate_iterpr pr exp


(* `premise list` -> `instr list` (return instructions) -> `instr list` *)
let translate_prems =
  List.fold_right (fun prem il -> translate_prem prem |> insert_instrs il)

(* s; f; e -> `expr * expr * instr list * expr list` *)
let get_config_return_instrs name exp at =
  assert(is_config exp);
  let state, rhs = split_config exp in
  let store, f = split_state state in
  let vals, instrs = split_vals rhs in

  let config =
    translate_exp store,
    translate_exp f,
    (
      List.concat_map translate_rhs vals,
      List.map translate_exp instrs |> concat_exprs
    )
  in
  (* HARDCODE: hardcoding required for config returning helper functions *)
  match name with
  | "instantiate" -> Manual.return_instrs_of_instantiate config
  | "invoke" -> Manual.return_instrs_of_invoke config
  | _ ->
    error at
      (sprintf "Helper function that returns config requires hardcoding: %s" name)

let translate_helper_body name clause =
  let Il.DefD (_, _, exp, prems) = clause.it in
  let return_instrs =
    if is_config exp then
      get_config_return_instrs name exp clause.at
    else
      [ returnI (Some (translate_exp exp)) ~at:exp.at ]
  in
  translate_prems prems return_instrs

(* Main translation for helper functions *)
let translate_helper helper =
  let id, clauses, partial = helper.it in
  let name = id.it in
  let args = List.hd clauses |> args_of_clause in
  let walk_expr walker expr = 
    let expr1 = Transpile.remove_sub expr in
    Al.Walk.base_walker.walk_expr walker expr1
  in
  let walker = { Walk.base_walker with
    walk_expr = walk_expr;
  }
  in
  let params =
    args
    |> translate_args
    |> List.map (walker.walk_arg walker)
  in
  let blocks = List.map (translate_helper_body name) clauses in
  let body =
    Transpile.merge_blocks blocks
    (* |> Transpile.insert_frame_binding *)
    |> Transpile.handle_frame params
    |> List.concat_map (walker.walk_instr walker)
    |> Transpile.enhance_readability
    |> (if partial = Partial then Fun.id else Transpile.ensure_return)
    |> Transpile.flatten_if in

   FuncA (name, params, body) $ helper.at


let extract_winstr r at =
  let _, _, prems = r in
  match List.find_opt is_winstr_prem prems with
  | Some p -> lhs_of_prem p (* TODO: Collect helper functions into one place *)
  | None -> error at "Failed to extract the target wasm instruction"

let exit_context context_opt instrs =
  match context_opt with
  | None -> instrs
  | Some instr -> instr :: instrs

(* `reduction` -> `instr list` *)
let translate_reduction ?(context_opt=None) reduction =
  let _, rhs, prems = reduction in

  (* Translate rhs *)
  translate_rhs rhs
  (* Exit context *)
  |> exit_context context_opt
  |> Transpile.insert_nop
  (* Translate premises *)
  |> translate_prems prems


let translate_context_winstr winstr =
  if not (is_context winstr) then [] else

  let at = winstr.at in
  let kind = case_of_case winstr |> List.hd |> List.hd in
  let args = args_of_case winstr in

  match kind.it with
  (* Frame *)
  | Il.Atom "FRAME_" ->
    (match args with
    | [arity; name; inner_exp] ->
      [
        letI (translate_exp name, getCurFrameE () ~note:name.note) ~at:at;
        letI (translate_exp arity, arityE (translate_exp name) ~note:arity.note) ~at:at;
        insert_assert inner_exp;
      ]
      @ insert_pop' (inner_exp) @
      [
        insert_assert winstr;
        exitI kind ~at:at
      ]
    | _ -> error_exp winstr "wrong argument of frame"
    )
  (* Label, Handler *)
  | _ ->
    (* ASSUMPTION: the last arg is the inner stack of this context *)
    let vals = Lib.List.last args in
    [
      (* TODO: append Jump instr *)
      popAllI ({ (translate_exp vals) with note=(listT valT)}) ~at:vals.at;
      insert_assert winstr;
      exitI kind ~at:at
    ]

let translate_context ctx =
  let at = ctx.at in

  match ctx.it with
  | Il.CaseE ([{it = Il.Atom "LABEL_"; at=at'; _} as atom]::_, { it = Il.TupE [ n; instrs ]; _ }) ->
    let label = VarE "L" $$ at' % labelT in
    [
      letI (label, getCurLabelE () ~note:labelT) ~at:at;
      letI (translate_exp n, arityE label ~note:n.note) ~at:at;
      letI (translate_exp instrs, contE label ~note:instrs.note) ~at:at;
    ],
    exitI atom ~at:at
  | Il.CaseE ([{it = Il.Atom "FRAME_"; _} as atom]::_, { it = Il.TupE [ n; f ]; _ }) ->
    let frame = translate_exp f in
    [
      letI (frame, getCurFrameE () ~note:frameT) ~at:at;
      letI (translate_exp n, arityE frame ~note:n.note) ~at:at;
    ],
    exitI atom ~at:at
  | Il.CaseE ([atom]::_, _) ->
    [
      letI (translate_exp ctx, getCurContextE () ~note:ctx.note) ~at:at;
    ],
    exitI atom ~at:at
  | _ -> [ yetI "TODO: translate_context" ~at:at ], yetI "TODO: translate_context"



let rec translate_rgroup' (rule: rule_def) =
  let instr_name, _, rgroup = rule.it in
  let pops, rgroup' = extract_pops rgroup in
  let subgroups = group_by_context rgroup' in

  let blocks = List.map (fun (k, (subgroup: rule_clause list)) ->
    match k with
    (* Normal case *)
    | None ->
      let winstr = extract_winstr (List.hd subgroup) rule.at in
      let inner_pop_instrs = translate_context_winstr winstr in
      let blocks = List.map translate_reduction subgroup in
      let instrs =
        match blocks with
        | [b1; b2] when not (has_branch b1 || has_branch b2) -> [ eitherI (b1, b2) ] (* Either case *)
        | _ -> Transpile.merge_blocks blocks
      in
      k, inner_pop_instrs @ instrs
    (* Context case *)
    | Some _ ->
      let pops, u_group = extract_pops subgroup in
      let ctxt = extract_context (List.hd u_group) |> Option.get in
      let atom = case_of_case ctxt |> List.hd |> List.hd in
      let cond = ContextKindE atom $$ atom.at % boolT in
      let head_instrs, middle_instr = translate_context ctxt in
      let is_otherwise = function [{it = OtherwiseI _; _}] -> true | _ -> false in
      let body_instrs =
        List.map (translate_reduction ~context_opt:(Some middle_instr)) u_group
        (* TODO: Consider inserting otherwise to normal case also *)
        |> List.mapi (fun i instrs -> if i = 0 || is_otherwise instrs then instrs else [otherwiseI instrs])
        |> Transpile.merge_blocks
        |> translate_prems pops in
      k, [
        ifI (
          cond,
          head_instrs @ body_instrs,
          []
        )
      ]
  ) subgroups in

  let normal_block_opt, ctxt_blocks =
    match List.hd blocks with
    | (Some _, _) -> None, blocks
    | (None, b) -> Some b, List.tl blocks
  in

  (* HARDCODE: Insert ThrowI if the current wasm instruction is throw_ref *)
  let throw_block = if instr_name <> "throw_ref" then [] else
    match List.hd pops |> lhs_of_prem |> it with
    | TupE (e :: _) -> [throwI (translate_exp e)]
    | _ -> assert false
  in

  let ctxt_block = match ctxt_blocks with
  | [] -> []
  | _ ->
    let valTs = listT valT in
    let e_vals = iterE (subE ("val", valT) ~note:valT, [ "val" ], List) ~note:valTs in
    let instr_popall = popAllI e_vals in
    let instr_push = pushI e_vals in

    instr_popall ::
    List.fold_right (fun instrs acc ->
      assert (List.length instrs = 1);
      let if_instr = List.hd instrs in
      match if_instr.it with
      | IfI (c, instrs1, []) -> [{if_instr with it = IfI (c, instr_push :: instrs1, acc)}]
      | _ -> assert false
    ) (List.map snd ctxt_blocks) throw_block
  in

  let body_instrs =
    match normal_block_opt, ctxt_block with
    | None, b -> b
    | Some b1, b2 ->
      (* Assert: b1 must have the else-less IfI as inner most instruction *)
      insert_instrs_to_else b2 b1
  in

  translate_prems pops body_instrs

(* Main translation for reduction rules
 * `rgroup` -> `Al.Algo` *)

and translate_rgroup (rule: rule_def) =

  let instr_name, rel_id, rgroup = rule.it in
  let winstr = extract_winstr (List.hd rgroup) rule.at in
  let instrs = translate_rgroup' rule in

  let name =
    match case_of_case winstr with
    | (atom :: _) :: _ -> atom
    | _ -> assert false
  in
  let anchor = rel_id.it ^ "/" ^ instr_name in
  let al_params =
    if List.mem instr_name ["frame"; "label"; "handler"] then [] else
    args_of_case winstr
    |> List.map translate_exp
    |> List.map (fun e -> ExpA e $ e.at)
  in
  (* TODO: refactor transpiles *)
  let walk_expr walker expr = 
    let expr1 = Transpile.remove_sub expr in
    Al.Walk.base_walker.walk_expr walker expr1
  in
  let walker = { Walk.base_walker with
    walk_expr = walk_expr;
  }
  in
  let al_params' = List.map (walker.walk_arg walker) al_params
  in
  let body =
    instrs
    |> Transpile.insert_frame_binding
    |> Transpile.insert_nop
    |> List.concat_map (walker.walk_instr walker)
    |> Transpile.enhance_readability
    |> Transpile.infer_assert
    |> Transpile.flatten_if
  in

  RuleA (name, anchor, al_params', body) $ rule.at


(* Entry *)
let translate il =
  let rules, helpers = Preprocess.preprocess il in
  let al =
    List.map translate_rgroup rules @ List.map translate_helper helpers
  in
  List.map Transpile.remove_state al
  
