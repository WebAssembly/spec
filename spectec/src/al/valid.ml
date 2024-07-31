open Util
open Source
open Ast
open Al_util
open Print
open Walk


(* Error *)

let error at msg = Error.error at "AL validation" msg
let error_valid error_kind (source, at) msg =
  error at (Printf.sprintf "%s when validating `%s`\n  %s" error_kind source msg)
let error_mismatch source typ1 typ2 =
  error_valid "type mismatch" source
    (Printf.sprintf "%s =/= %s"
      (Il.Print.string_of_typ typ1)
      (Il.Print.string_of_typ typ2)
    )
let error_field source typ field =
  error_valid "unknown field" source
    (Printf.sprintf "%s ∉ %s" field (Il.Print.string_of_typ typ))
let error_struct source typ =
  error_valid "invalid struct type" source (Il.Print.string_of_typ typ)
let error_tuple source typ =
  error_valid "invalid tuple type" source (Il.Print.string_of_typ typ)

(* Bound Set *)

module Set = Free.IdSet

let bound_set: Set.t ref = ref Set.empty
let add_bound_var id = bound_set := Set.add id !bound_set
let add_bound_vars expr = bound_set := Set.union (Free.free_expr expr) !bound_set
let add_bound_vars_of_arg arg = match arg.it with ExpA e -> add_bound_vars e | TypA -> ()
let init_bound_set algo =
  bound_set := Set.empty;
  algo |> Al_util.params_of_algo |> List.iter add_bound_vars_of_arg

(* Type Env *)

module Env = Il.Env
let env: Env.t ref = ref Env.empty


let varT s = Il.Ast.VarT (s $ no_region, []) $ no_region

(* TODO: Generalize subtyping for numbers *)

let num_typs = [ "nat"; "int"; "sN"; "uN"; "byte"; "bit"; "N"; "u32"; "iN"; "lane_" ]

let is_num typ =
  match typ.it with
  | Il.Ast.NumT _ -> true
  | Il.Ast.VarT (id, _) when List.mem id.it num_typs -> true
  | _ -> List.exists (fun nt -> Il.Eval.sub_typ !env typ (varT nt)) num_typs
let rec sub_typ typ1 typ2 =
  match typ1.it, typ2.it with
  | Il.Ast.IterT (typ1', _), Il.Ast.IterT (typ2', _) -> sub_typ typ1' typ2'
  | Il.Ast.VarT (id1, _), Il.Ast.VarT (id2, _) ->
    Il.Eval.sub_typ !env (varT id1.it) (varT id2.it) || is_num typ1 && is_num typ2
  | _ ->
    Il.Eval.sub_typ !env typ1 typ2 || is_num typ1 && is_num typ2
let matches typ1 typ2 = sub_typ typ1 typ2 || sub_typ typ2 typ1


(* Helper functions *)

let get_base_typ typ =
  match typ.it with
  | Il.Ast.IterT (typ', _) -> typ'
  | _ -> typ

let unwrap_iter_typ typ =
  match typ.it with
  | Il.Ast.IterT (typ', _) -> typ'
  | _ -> assert (false)

let check_match source typ1 typ2 =
  if not (matches typ1 typ2) then error_mismatch source typ1 typ2

let check_num source typ =
  if not (is_num typ) then error_mismatch source typ (varT "num")

let check_bool source typ =
  match typ.it with
  | Il.Ast.BoolT -> ()
  | _ -> error_mismatch source typ (varT "bool")

let check_list source typ =
  match typ.it with
  | Il.Ast.IterT (_, iter) when iter <> Il.Ast.Opt -> ()
  | _ -> error_mismatch source typ (varT "list")

(* TODO: use hint *)
let check_instr source typ =
  let typ = get_base_typ typ in
  if
    not (sub_typ typ (varT "instr")) &&
    not (sub_typ typ (varT "admininstr"))
  then
    error_mismatch source typ (varT "instr")

let check_val source typ =
  if not (sub_typ (get_base_typ typ) (varT "val")) then
    error_mismatch source typ (varT "val")

let check_context source typ =
  let context_typs = [ "callframe"; "label" ] in
  match typ.it with
  | Il.Ast.VarT (id, []) when List.mem id.it context_typs -> ()
  | _ -> error_mismatch source typ (varT "context")

let check_field source source_typ expr_record atom typ =
  (* TODO: Use record api *)
  let f e = El.Atom.eq (fst e) atom in
  let expr =
    try List.find f expr_record |> snd |> (!)
    with _ -> error_field source source_typ (El.Print.string_of_atom atom)
  in
  check_match source expr.note typ

let rec check_struct source struct_ typ =
  let open Il.Ast in
  match typ.it with
  | VarT (id, _) when Env.mem_typ !env id ->
    (match Env.find_typ !env id with
    | _, [{ it = InstD (_, _, { it = StructT tfs; _ }); _ }] ->
      List.iter
        (fun (a, (_, typ', _), _) -> check_field source typ struct_ a typ')
        tfs
    | _, [{ it = InstD (_, _, { it = AliasT typ'; _ }); _ }] ->
      check_struct source struct_ typ'
    | _, [{ it = InstD (_, _, { it = VariantT tcs; _ }); _ }] ->
      let is_valid_struct typecase =
        let _, (_, typ', _), _ = typecase in
        try check_struct source struct_ typ'; true with _ -> false
      in
      if not (List.exists is_valid_struct tcs) then error_struct source typ
    | _ -> error_struct source typ
    )
  | _ -> error_struct source typ

let rec check_tuple source exprs typ =
  let open Il.Ast in
  match typ.it with
  | TupT etl when List.length exprs = List.length etl ->
    let f expr (_, typ) = check_match source expr.note typ in
    List.iter2 f exprs etl
  | VarT (id, _) when Env.mem_typ !env id ->
    (match Env.find_typ !env id with
    | _, [{ it = InstD (_, _, { it = AliasT typ'; _ }); _ }] ->
      check_tuple source exprs typ'
    | _, [{ it = InstD (_, _, { it = VariantT tcs; _ }); _ }] ->
      let is_valid_tuple typecase =
        let _, (_, typ', _), _ = typecase in
        try check_tuple source exprs typ'; true with _ -> false
      in
      if not (List.exists is_valid_tuple tcs) then error_tuple source typ
    | _ -> error_tuple source typ
    )
  | _ -> error_tuple source typ

let rec access_field source typ field =
  let open Il.Ast in
  let valid_field =
    fun (e, _) -> match e.it with VarE s -> s.it = field | _ -> false
  in
  match typ.it with
  | TupT etl when List.exists valid_field etl ->
    (* XXX: Not sure about this rule *)
    let (_, typ') = List.find valid_field etl in
    typ'
  | VarT (id, _) when Env.mem_typ !env id ->
    let valid_field = fun (atom, _, _) -> Il.Print.string_of_atom atom = field in
    (match Env.find_typ !env id with
    | _, [{ it = InstD (_, _, { it = StructT tfs; _ }); _ }]
    when List.exists valid_field tfs ->
      let _, (_, typ', _), _ = List.find valid_field tfs in
      typ'
    | _, [{ it = InstD (_, _, { it = AliasT typ'; _ }); _ }] ->
      access_field source typ' field
    | _, [{ it = InstD (_, _, { it = VariantT tcs; _ }); _ }] ->
      let try_access_field typecase =
        let _, (_, typ', _), _ = typecase in
        try Some (access_field source typ' field) with _ -> None
      in
      (match List.find_map try_access_field tcs with
      | Some typ'' -> typ''
      | None -> error_field source typ field
      )
    | _ -> error_field source typ field
    )
  | _ -> error_field source typ field

let access source typ path =
  match path.it with
  | IdxP expr ->
    check_list source typ; check_num source expr.note;
    unwrap_iter_typ typ
  | SliceP (expr3, expr4) ->
    check_list source typ; check_num source expr3.note; check_num source expr4.note;
    typ
  | DotP atom -> access_field source typ (string_of_atom atom)



(* Expr validation *)

let valid_expr (walker: unit_walker) (expr: expr) : unit =
  let source = string_of_expr expr, expr.at in
  (match expr.it with
  | VarE id ->
    if not (Set.mem id !bound_set) then error expr.at ("free identifier " ^ id)
  | UnE (NotOp, expr') ->
    check_bool source expr.note; check_bool source expr'.note
  | UnE (MinusOp, expr') ->
    check_num source expr.note; check_num source expr'.note
  | BinE ((AddOp|SubOp|MulOp|DivOp|ModOp|ExpOp), expr1, expr2) ->
    check_num source expr.note;
    check_num source expr1.note; check_num source expr2.note
  | BinE ((LtOp|GtOp|LeOp|GeOp), expr1, expr2) ->
    check_bool source expr.note;
    check_num source expr1.note; check_num source expr2.note
  | BinE ((ImplOp|EquivOp|AndOp|OrOp), expr1, expr2) ->
    check_bool source expr.note;
    check_bool source expr1.note; check_bool source expr2.note
  | BinE ((EqOp|NeOp), expr1, expr2) ->
    check_bool source expr.note;
    (* XXX: Not sure about this rule *)
    check_match source expr1.note expr2.note
  | AccE (expr', path) ->
    access source expr'.note path |> check_match source expr.note
  | UpdE (expr1, pl, expr2) | ExtE (expr1, pl, expr2, _) ->
    check_match source expr.note expr1.note;
    List.fold_left (access source) expr1.note pl |> check_match source expr2.note
  | StrE r -> check_struct source r expr.note
  | CatE (expr1, expr2) ->
    check_list source expr1.note; check_list source expr2.note;
    check_match source expr.note expr1.note; check_match source expr1.note expr2.note
  | MemE (expr1, expr2) ->
    check_bool source expr.note;
    check_match source expr2.note (iterT expr1.note Il.Ast.List)
  | LenE expr' ->
    check_list source expr'.note; check_num source expr.note
  | TupE exprs -> check_tuple source exprs expr.note
  (* TODO *)
  | IterE (expr1, _, iter) ->
    if not (expr1.note.it = Il.Ast.BoolT && expr.note.it = BoolT) then
      (match iter with
      | Opt ->
        check_match source expr.note (iterT expr1.note Il.Ast.Opt);
      | ListN (expr2, id_opt) ->
        Option.iter add_bound_var id_opt;
        check_match source expr.note (iterT expr1.note Il.Ast.List);
        check_num source expr2.note
      | _ ->
        check_match source expr.note (iterT expr1.note Il.Ast.List);
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
  let source = string_of_instr instr, instr.at in
  (match instr.it with
  | IfI (expr, _, _) | AssertI expr -> check_bool source expr.note
  | EnterI (expr1, expr2, _) ->
    check_context source expr1.note; check_instr source expr2.note
  | PushI expr ->
    if
      not (sub_typ (get_base_typ expr.note) (varT "val")) &&
      not (sub_typ (get_base_typ expr.note) (varT "callframe"))
    then
      error_mismatch source (get_base_typ expr.note) (varT "val")
  | PopI expr | PopAllI expr -> add_bound_vars expr;
    if
      not (sub_typ (get_base_typ expr.note) (varT "val")) &&
      not (sub_typ (get_base_typ expr.note) (varT "callframe"))
    then
      error_mismatch source (get_base_typ expr.note) (varT "val")
  | LetI (expr1, expr2) ->
    add_bound_vars expr1; check_match source expr1.note expr2.note
  | ExecuteI expr | ExecuteSeqI expr -> check_instr source expr.note
  | ReplaceI (expr1, path, expr2) ->
    access source expr1.note path |> check_match source expr2.note
  | AppendI (expr1, _expr2) -> check_list source expr1.note
  | _ -> ()
  );
  base_unit_walker.walk_instr walker instr

let valid_algo (algo: algorithm) =
  print_string (Al_util.name_of_algo algo ^ "(");

  algo
  |> Al_util.params_of_algo
  |> List.map string_of_arg
  |> String.concat ", "
  |> print_string;
  print_endline ")";

  init_bound_set algo;
  let walker = { base_unit_walker with walk_expr=valid_expr; walk_instr=valid_instr } in
  walker.walk_algo walker algo

let valid (script: script) =
  List.iter valid_algo script
