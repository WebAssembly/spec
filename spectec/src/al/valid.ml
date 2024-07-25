open Util
open Source
open Ast
open Print
open Walk

let error at msg = Error.error at "AL validation" msg
let error_expr expr expected_typ =
  error expr.at
    (Printf.sprintf "%s is expected to be %s but has %s"
      (string_of_expr expr) expected_typ (Il.Print.string_of_typ expr.note))


(* Global env for eval *)

let typ_env: Il.Eval.env ref =
  ref Il.Eval.{ vars=Map.empty; typs=Map.empty; defs=Map.empty }

let varT s = Il.Ast.VarT (s $ no_region, []) $ no_region

let sub_typ typ1 typ2 = Il.Eval.sub_typ !typ_env typ1 typ2

let get_base_typ typ =
  match typ.it with
  | Il.Ast.IterT (typ', _) -> typ'
  | _ -> typ

let check_num expr =
  match expr.note.it with
  | Il.Ast.NumT _ -> ()
  | _ -> error_expr expr "num"

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


(* Expr *)

let valid_expr (walker: unit_walker) (expr: expr) : unit =
  (match expr.it with
  | _ ->
    match expr.note.it with
    | Il.Ast.VarT (id, []) when id.it = "TODO" ->
      error expr.at (Printf.sprintf "%s's type is TODO" (string_of_expr expr))
    | _ -> ()
  );
  base_unit_walker.walk_expr walker expr


(* Instr *)

let valid_instr (walker: unit_walker) (instr: instr) : unit =
  print_endline (string_of_instr instr);
  (match instr.it with
  | IfI (expr, _, _) | AssertI expr ->
    if expr.note.it <> Il.Ast.BoolT then error_expr expr "bool"
  | EnterI (expr1, expr2, _) ->
    check_instr expr1;
    check_context expr2
  | PushI expr | PopI expr | PopAllI expr -> check_val expr
  | LetI (expr1, expr2) ->
    if not (sub_typ expr1.note expr2.note || sub_typ expr2.note expr1.note) then
      error_expr expr2 (Il.Print.string_of_typ expr1.note)
  | ExecuteI expr | ExecuteSeqI expr -> check_instr expr;
  | ReplaceI (expr1, path, _expr2) ->
    (match path.it with
    | IdxP expr3 -> check_list expr1; check_num expr3
    | SliceP (expr3, expr4) -> check_list expr1; check_num expr3; check_num expr4
    | DotP atom ->
      (* TODO: require remove state *)
      let field = string_of_atom atom in
      let f =
        fun (e, _) ->
          match e.it with Il.Ast.VarE s -> s.it = field | _ -> false
      in
      (match expr1.note.it with
      | TupT etl when List.exists f etl -> ()
      | _ ->
        error expr1.at
          (Printf.sprintf "%s doesn't contain field %s"
            (string_of_expr expr1) field
          )
      )
    )
  | AppendI (expr1, _expr2) -> check_list expr1
  | _ -> ()
  );
  base_unit_walker.walk_instr walker instr

let valid_algo (algo: algorithm) =
  print_endline (Al_util.name_of_algo algo);
  let walker = { base_unit_walker with walk_expr=valid_expr; walk_instr=valid_instr } in
  let _ = walker.walk_algo walker algo in
  ()

let valid (script: script) = List.iter valid_algo script
