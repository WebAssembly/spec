open Util
open Source
open Ast
open Print
open Walk


(* Error *)

let error at msg = Error.error at "AL validation" msg
let error_mismatch expr typ1 typ2 =
  error expr.at
    (Printf.sprintf "type mismatch in %s\n  %s =/= %s"
      (string_of_expr expr)
      (Il.Print.string_of_typ typ1)
      (Il.Print.string_of_typ typ2)
    )
let error_expr expr expected_typ = error_mismatch expr expr.note expected_typ

(* Bound Set *)

module Set = Free.IdSet

let bound_set: Set.t ref = ref Set.empty
let add_bound_var id = bound_set := Set.add id !bound_set
let add_bound_vars expr = bound_set := Set.union (Free.free_expr expr) !bound_set
let init_bound_set algo =
  bound_set := Set.empty;
  algo |> Al_util.params_of_algo |> List.iter add_bound_vars

(* Type Env *)

let typ_env: Il.Eval.env ref =
  ref Il.Eval.{ vars=Map.empty; typs=Map.empty; defs=Map.empty }


let varT s = Il.Ast.VarT (s $ no_region, []) $ no_region

(* Begin trash *)

let num_typs = [ "nat"; "int"; "sN"; "uN"; "byte"; "bit"; "N"; "u32"; "iN"; "lane_" ]

let is_num typ =
  match typ.it with
  | Il.Ast.NumT _ -> true
  | Il.Ast.VarT (id, _) when List.mem id.it num_typs -> true
  | _ -> List.exists (fun nt -> Il.Eval.sub_typ !typ_env typ (varT nt)) num_typs
let rec sub_typ typ1 typ2 =
  match typ1.it, typ2.it with
  | Il.Ast.IterT (typ1', _), Il.Ast.IterT (typ2', _) -> sub_typ typ1' typ2'
  | Il.Ast.VarT (id1, _), Il.Ast.VarT (id2, _) ->
    Il.Eval.sub_typ !typ_env (varT id1.it) (varT id2.it) || is_num typ1 && is_num typ2
  | _ ->
    Il.Eval.sub_typ !typ_env typ1 typ2 || is_num typ1 && is_num typ2
let matches typ1 typ2 = sub_typ typ1 typ2 || sub_typ typ2 typ1

(* End trash *)

(* Helper functions *)

let get_base_typ typ =
  match typ.it with
  | Il.Ast.IterT (typ', _) -> typ'
  | _ -> typ

let unwrap_iter_typ typ =
  match typ.it with
  | Il.Ast.IterT (typ', _) -> typ'
  | _ -> assert (false)

let check_match expr typ1 typ2 =
  if not (matches typ1 typ2) then error_mismatch expr typ1 typ2

let check_num expr =
  match expr.note.it with
  | _ when is_num expr.note -> ()
  | _ -> error_expr expr (varT "num")

let check_bool expr =
  match expr.note.it with
  | Il.Ast.BoolT -> ()
  | _ -> error_expr expr (varT "bool")

let check_list expr =
  match expr.note.it with
  | Il.Ast.IterT (_, iter) when iter <> Il.Ast.Opt -> ()
  | _ -> error_expr expr (varT "list")

let check_instr expr =
  if not (sub_typ (get_base_typ expr.note) (varT "instr")) then
    error_expr expr (varT "instr")

let check_val expr =
  if not (sub_typ (get_base_typ expr.note) (varT "val")) then
    error_expr expr (varT "val")

let check_context expr =
  let context_typs = [ "call frame"; "label" ] in
  match expr.note.it with
  | Il.Ast.VarT (id, []) when List.mem id.it context_typs -> ()
  | _ -> error_expr expr (varT "context")

let check_access expr1 expr2 path =
  match path.it with
  | IdxP expr3 ->
    check_list expr2; check_num expr3;
    check_match expr1 expr1.note (unwrap_iter_typ expr2.note)
  | SliceP (expr3, expr4) ->
    check_list expr2; check_num expr3; check_num expr4;
    check_match expr1 expr1.note expr2.note
  | DotP atom ->
    let field = string_of_atom atom in
    let f =
      fun (e, _) -> match e.it with Il.Ast.VarE s -> s.it = field | _ -> false
    in
    (match expr2.note.it with
    | TupT etl when List.exists f etl ->
      let (_, typ) = List.find f etl in
      check_match expr1 expr1.note typ
    | VarT (id, _) when Il.Eval.Map.mem id.it !typ_env.typs ->
      let f = fun (atom, _, _) -> Il.Print.string_of_atom atom = field in
      (match Il.Eval.Map.find id.it !typ_env.typs with
      | [{ it = InstD (_, _, { it = StructT tfs; _ }); _ }]
      when List.exists f tfs ->
        let _, (_, typ, _), _ = List.find f tfs in
        check_match expr1 expr1.note typ
      | _ ->
        error expr2.at
          (Printf.sprintf "%s whose type is %s doesn't contain field %s"
            (string_of_expr expr2) (Il.Print.string_of_typ expr2.note) field
          )
      )
    | _ ->
      error expr2.at
        (Printf.sprintf "%s whose type is %s doesn't contain field %s"
          (string_of_expr expr2) (Il.Print.string_of_typ expr2.note) field
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
    check_match expr1 expr1.note expr2.note
  | AccE (expr', path) -> check_access expr expr' path
  (* TODO *)
  | IterE (expr1, _, iter) ->
    let iterT typ iter' = Il.Ast.IterT (typ, iter') $ no_region in
    (match iter with
    | Opt ->
      check_match expr expr.note (iterT expr1.note Il.Ast.Opt);
    | ListN (expr2, id_opt) ->
      Option.iter add_bound_var id_opt;
      check_match expr expr.note (iterT expr1.note Il.Ast.List);
      check_num expr2
    | _ ->
      check_match expr expr.note (iterT expr1.note Il.Ast.List);
    )
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
  | PushI expr ->
    if
      not (sub_typ (get_base_typ expr.note) (varT "val")) &&
      not (sub_typ (get_base_typ expr.note) (varT "callframe"))
    then
      error_expr expr (varT "val")
  | PopI expr | PopAllI expr -> add_bound_vars expr;
    if
      not (sub_typ (get_base_typ expr.note) (varT "val")) &&
      not (sub_typ (get_base_typ expr.note) (varT "callframe"))
    then
      error_expr expr (varT "val")
  | LetI (expr1, expr2) ->
    add_bound_vars expr1;
    if not (matches expr1.note expr2.note) then
      error instr.at
        (Printf.sprintf "lhs and rhs type mismatch in %s\n  %s =/= %s"
          (string_of_instr instr)
          (Il.Print.string_of_typ expr1.note)
          (Il.Print.string_of_typ expr2.note)
        )
  | ExecuteI expr | ExecuteSeqI expr -> check_instr expr
  | ReplaceI (expr1, path, expr2) -> check_access expr2 expr1 path
  | AppendI (expr1, _expr2) -> check_list expr1
  | _ -> ()
  );
  base_unit_walker.walk_instr walker instr

let valid_algo (algo: algorithm) =
  print_string (Al_util.name_of_algo algo ^ "(");

  algo
  |> Al_util.params_of_algo
  |> List.map string_of_expr
  |> String.concat ", "
  |> print_string;
  print_endline ")";

  init_bound_set algo;
  let walker = { base_unit_walker with walk_expr=valid_expr; walk_instr=valid_instr } in
  let _ = walker.walk_algo walker algo in
  ()

let valid (script: script) =
  List.iter valid_algo script
