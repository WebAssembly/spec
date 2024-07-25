open Util
open Source
open Ast
open Print
open Walk

(* Error *)

let error at msg = Error.error at "AL validation" msg
let error_expr expr expected_typ =
  error expr.at
    (Printf.sprintf "%s is expected to be %s but has %s"
      (string_of_expr expr) expected_typ (Il.Print.string_of_typ expr.note))

(* Bound Set *)

module Set = Free.IdSet

let bound_set: Set.t ref = ref Set.empty
let add_bound_vars expr = bound_set := Set.union (Free.free_expr expr) !bound_set
let init_bound_set algo =
  bound_set := Set.empty;
  algo |> Al_util.params_of_algo |> List.iter add_bound_vars

(* Type Env *)

let typ_env: Il.Eval.env ref =
  ref Il.Eval.{ vars=Map.empty; typs=Map.empty; defs=Map.empty }

let sub_typ typ1 typ2 = Il.Eval.sub_typ !typ_env typ1 typ2
let matches typ1 typ2 = sub_typ typ1 typ2 || sub_typ typ2 typ1

(* Helper functions *)

let varT s = Il.Ast.VarT (s $ no_region, []) $ no_region

let get_base_typ typ =
  match typ.it with
  | Il.Ast.IterT (typ', _) -> typ'
  | _ -> typ

let unwrap_iter_typ typ =
  match typ.it with
  | Il.Ast.IterT (typ', _) -> typ'
  | _ -> assert (false)

let check_match expr typ =
  if not (matches expr.note typ) then
    error_expr expr (Il.Print.string_of_typ typ)

let check_num expr =
  match expr.note.it with
  | Il.Ast.NumT _ -> ()
  | _ -> error_expr expr "num"

let check_bool expr =
  match expr.note.it with
  | Il.Ast.BoolT -> ()
  | _ -> error_expr expr "bool"

let check_list expr =
  match expr.note.it with
  | Il.Ast.IterT (_, iter) when iter <> Il.Ast.Opt -> ()
  | _ -> error_expr expr "list"

let check_instr expr =
  if not (sub_typ (get_base_typ expr.note) (varT "instr")) then
    error_expr expr "instr"

let check_val expr =
  if not (sub_typ (get_base_typ expr.note) (varT "val")) then
    error_expr expr "val"

let check_context expr =
  let context_typs = [ "call frame"; "label" ] in
  match expr.note.it with
  | Il.Ast.VarT (id, []) when List.mem id.it context_typs -> ()
  | _ -> error_expr expr "context"

let check_access expr1 expr2 path =
  match path.it with
  | IdxP expr3 ->
    check_list expr2; check_num expr3;
    check_match expr1 (unwrap_iter_typ expr2.note)
  | SliceP (expr3, expr4) ->
    check_list expr2; check_num expr3; check_num expr4;
    check_match expr1 expr2.note
  | DotP atom ->
    let field = string_of_atom atom in
    let f =
      fun (e, _) -> match e.it with Il.Ast.VarE s -> s.it = field | _ -> false
    in
    (match expr2.note.it with
    | TupT etl when List.exists f etl ->
      let _typ = List.find f etl in
      ()
    | _ ->
      error expr2.at
        (Printf.sprintf "%s doesn't contain field %s"
          (string_of_expr expr2) field
        )
    )


(* Expr validation *)

let valid_expr (walker: unit_walker) (expr: expr) : unit =
  (match expr.it with
  | VarE id ->
    if not (Set.mem id !bound_set) then
      error expr.at ("free identifier " ^ id)
  | NumE _ -> check_num expr
  | BoolE _ -> check_bool expr
  | UnE (NotOp, expr') -> check_bool expr; check_bool expr'
  | UnE (MinusOp, expr') -> check_num expr; check_num expr'
  | BinE ((AddOp|SubOp|MulOp|DivOp|ModOp|ExpOp), expr1, expr2) ->
    check_num expr; check_num expr1; check_num expr2
  | BinE ((LtOp|GtOp|LeOp|GeOp), expr1, expr2) ->
    check_bool expr; check_num expr1; check_num expr2
  | BinE ((ImplOp|EquivOp|AndOp|OrOp), expr1, expr2) ->
    check_bool expr; check_bool expr1; check_bool expr2
  | BinE ((EqOp|NeOp), expr1, expr2) ->
    check_bool expr;
    (* XXX: Not sure about this rule *)
    check_match expr1 expr2.note
  | AccE (expr', path) -> check_access expr expr' path
  (* TODO *)
  | _ ->
    match expr.note.it with
    | Il.Ast.VarT (id, []) when id.it = "TODO" ->
      error expr.at (Printf.sprintf "%s's type is TODO" (string_of_expr expr))
    | _ -> ()
  );
  base_unit_walker.walk_expr walker expr


(* Instr validation *)

let valid_instr (walker: unit_walker) (instr: instr) : unit =
  print_endline (string_of_instr instr);
  (match instr.it with
  | IfI (expr, _, _) | AssertI expr -> check_bool expr
  | EnterI (expr1, expr2, _) -> check_instr expr1; check_context expr2
  | PushI expr -> check_val expr
  | PopI expr | PopAllI expr -> add_bound_vars expr; check_val expr
  | LetI (expr1, expr2) -> add_bound_vars expr1; check_match expr1 expr2.note
  | ExecuteI expr | ExecuteSeqI expr -> check_instr expr
  | ReplaceI (expr1, path, expr2) -> check_access expr2 expr1 path
  | AppendI (expr1, _expr2) -> check_list expr1
  | _ -> ()
  );
  base_unit_walker.walk_instr walker instr

let valid_algo (algo: algorithm) =
  print_endline (Al_util.name_of_algo algo);

  init_bound_set algo;
  let walker = { base_unit_walker with walk_expr=valid_expr; walk_instr=valid_instr } in
  let _ = walker.walk_algo walker algo in
  ()

let valid (script: script) =
  List.iter valid_algo script
