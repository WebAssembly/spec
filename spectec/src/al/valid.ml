open Util
open Source
open Il.Ast
open Ast
open Al_util
open Print
open Walk


module Atom = El.Atom
module Eval = Il.Eval

(* Error *)

type source = string phrase

let error at msg = Error.error at "AL validation" msg
let error_valid error_kind source msg =
  error source.at
    (Printf.sprintf "%s when validating `%s`\n  %s" error_kind source.it msg)
let error_mismatch source typ1 typ2 =
  error_valid "type mismatch" source
    (Printf.sprintf "%s =/= %s"
      (Il.Print.string_of_typ typ1)
      (Il.Print.string_of_typ typ2)
    )
let error_field source typ field =
  error_valid "unknown field" source
    (Printf.sprintf "%s ∉ %s" (string_of_atom field) (Il.Print.string_of_typ typ))
let error_struct source typ =
  error_valid "invalid struct type" source (Il.Print.string_of_typ typ)
let error_tuple source typ =
  error_valid "invalid tuple type" source (Il.Print.string_of_typ typ)

(* Bound Set *)

module Set = Free.IdSet

let bound_set: Set.t ref = ref Set.empty
let add_bound_var id = bound_set := Set.add id !bound_set
let add_bound_vars expr = bound_set := Set.union (Free.free_expr expr) !bound_set
let add_bound_param arg = match arg.it with ExpA e -> add_bound_vars e | TypA _ -> ()

(* Type Env *)

module Env = Il.Env
let env: Env.t ref = ref Env.empty


let varT s = VarT (s $ no_region, []) $ no_region

let is_trivial_mixop = List.for_all (fun atoms -> List.length atoms = 0)


(* Subtyping *)

let get_deftyps (id: Il.Ast.id) (args: Il.Ast.arg list): deftyp list =
  match Env.find_opt_typ !env id with
  | Some (_, insts) ->

    let get_deftyp inst =
      let typ_of_arg arg =
        match (Eval.reduce_arg !env arg).it with
        | ExpA { it=SubE (_, typ, _); _ } -> typ
        | ExpA { note; _ } -> note
        | TypA typ -> typ
        | _ -> failwith ("TODO: " ^ Il.Print.string_of_arg (Eval.reduce_arg !env arg))
      in

      let InstD (_, inst_args, deftyp) = inst.it in
      let args' = List.map typ_of_arg args in
      let inst_args' = List.map typ_of_arg inst_args in
      if List.for_all2 (Eval.sub_typ !env) args' inst_args' then
        Some deftyp
      else
        None
    in

    (match List.find_map get_deftyp insts with
    | Some deftyp -> [deftyp]
    | None ->
      List.map (fun inst -> let InstD (_, _, deftyp) = inst.it in deftyp) insts
    )
  | None -> []

let rec unify_deftyp_opt (deftyp: deftyp) : typ option =
  match deftyp.it with
  | AliasT typ -> Some typ
  | StructT _ -> None
  | VariantT typcases
  when List.for_all (fun (mixop', _, _) -> is_trivial_mixop mixop') typcases ->
    (match typcases with
    | (_, (_, typ, _), _) :: _
    when
      typcases
      |> List.map (fun (_, (_, typ', _), _) -> unify_opt typ typ')
      |> List.for_all Option.is_some
    -> Some typ
    | _ -> None
    )
  | _ -> None

and unify_opt (typ1: typ) (typ2: typ) : typ option =
  let typ1', typ2' = ground_typ_of typ1, ground_typ_of typ2 in
  match typ1'.it, typ2'.it with
  | VarT (id1, _), VarT (id2, _) when id1 = id2 -> Some (ground_typ_of typ1)
  | BoolT, BoolT | NumT _, NumT _ | TextT, TextT -> Some typ1
  | TupT etl1, TupT etl2 ->
    let (let*) = Option.bind in
    let etl =
      List.fold_right2
        (fun et1 et2 acc ->
          let* acc = acc in
          let* res = unify_opt (snd et1) (snd et2) in
          Some ((fst et1, res) :: acc)
        )
        etl1
        etl2
        (Some [])
    in
    Option.map (fun etl -> TupT etl $ typ1.at) etl
  | IterT (typ1'', iter), IterT (typ2'', _) ->
    Option.map (fun typ -> IterT (typ, iter) $ typ1.at) (unify_opt typ1'' typ2'')
  | _ -> None

and ground_typ_of (typ: typ) : typ =
  match typ.it with
  | VarT (id, _) when Env.mem_var !env id ->
    let typ', iters = Env.find_var !env id in
    (* TODO: local var type contains iter *)
    assert (iters = []);
    if Il.Eq.eq_typ typ typ' then typ else ground_typ_of typ'
  (* NOTE: Consider `fN` as a `NumT` to prevent diverging ground type *)
  | VarT (id, _) when id.it = "fN" -> NumT RealT $ typ.at
  | VarT (id, args) ->
    let typ_opts = List.map unify_deftyp_opt (get_deftyps id args) in
    if List.for_all Option.is_some typ_opts then
      match List.map Option.get typ_opts with
      | typ' :: typs
      when List.for_all Option.is_some (List.map (unify_opt typ') typs) ->
        ground_typ_of typ'
      | _ -> typ
    else
      typ
  | TupT [_, typ'] -> ground_typ_of typ'
  | IterT (typ', iter) -> IterT (ground_typ_of typ', iter) $ typ.at
  | _ -> typ

let is_num typ =
  match (ground_typ_of typ).it with
  | NumT _ -> true
  | _ -> false

let rec sub_typ typ1 typ2 =
  let typ1', typ2' = ground_typ_of typ1, ground_typ_of typ2 in
  match typ1'.it, typ2'.it with
  | IterT (typ1'', _), IterT (typ2'', _) -> sub_typ typ1'' typ2''
  | NumT _, NumT _ -> true
  | _, _ -> Eval.sub_typ !env typ1' typ2'

let rec matches typ1 typ2 =
  match (ground_typ_of typ1).it, (ground_typ_of typ2).it with
  | IterT (typ1', _), IterT (typ2', _) -> matches typ1' typ2'
  | VarT (id1, _), VarT (id2, _) when id1.it = id2.it -> true
  | _ -> sub_typ typ1 typ2 || sub_typ typ2 typ1


(* Helper functions *)

let get_base_typ typ =
  match typ.it with
  | IterT (typ', _) -> typ'
  | _ -> typ

let unwrap_iter_typ typ =
  match typ.it with
  | IterT (typ', _) -> typ'
  | _ -> assert (false)


let rec get_typfields_of_inst (inst: inst) : typfield list =
  let InstD (_, _, dt) = inst.it in
  match dt.it with
  | StructT typfields -> typfields
  | AliasT typ -> get_typfields typ
  | VariantT [mixop, (_, typ, _), _] when is_trivial_mixop mixop ->
    get_typfields typ
  (* TODO: some variants of struct type *)
  | VariantT _ -> []

and get_typfields (typ: typ) : typfield list =
  match typ.it with
  | VarT (id, _) when Env.mem_typ !env id ->
    let _, insts = Env.find_typ !env id in
    List.concat_map get_typfields_of_inst insts
  | _ -> []


let check_match source typ1 typ2 =
  if not (matches typ1 typ2) then error_mismatch source typ1 typ2

let check_num source typ =
  if not (is_num typ) then error_mismatch source typ (varT "num")

let check_bool source typ =
  match (get_base_typ typ).it with
  | BoolT -> ()
  | _ -> error_mismatch source typ (varT "bool")

let check_list source typ =
  match typ.it with
  | IterT (_, iter) when iter <> Opt -> ()
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
  | VarT (id, []) when List.mem id.it context_typs -> ()
  | _ -> error_mismatch source typ (varT "context")

let check_field source source_typ expr_record typfield =
  let atom, (_, typ, _), _ = typfield in
  (* TODO: Use record api *)
  let f e = e |> fst |> Atom.eq atom in
  match List.find_opt f expr_record with
  | Some (_, expr_ref) -> check_match source !expr_ref.note typ
  | None -> error_field source source_typ atom

let check_tuple source exprs typ =
  match (ground_typ_of typ).it with
  | TupT etl when List.length exprs = List.length etl ->
    let f expr (_, typ) = check_match source expr.note typ in
    List.iter2 f exprs etl
  | _ -> error_tuple source typ

let check_call source id args result_typ =
  match Env.find_opt_def !env (id $ no_region) with
  | Some (params, typ, _) ->
    (* TODO: Use local environment *)
    (* Store global enviroment *)
    let global_env = !env in

    let check_arg arg param =
      match arg.it, param.it with
      | ExpA expr, ExpP (_, typ') -> check_match source expr.note typ'
      (* Add local variable typ *)
      | TypA typ1, TypP id -> env := Env.bind_var !env id (typ1, [])
      | _ ->
        error_valid "argument type mismatch" source
          (Printf.sprintf "  %s =/= %s"
            (string_of_arg arg)
            (Il.Print.string_of_param param)
          )
    in
    List.iter2 check_arg args params;
    check_match source result_typ typ;

    (* Reset global enviroment *)
    env := global_env
  | None -> error_valid "no function definition" source ""

let access (source: source) (typ: typ) (path: path) : typ =
  match path.it with
  | IdxP expr ->
    check_list source typ; check_num source expr.note; unwrap_iter_typ typ
  | SliceP (expr3, expr4) ->
    check_list source typ;
    check_num source expr3.note;
    check_num source expr4.note;
    typ
  | DotP atom ->
    let typfields = get_typfields typ in
    match List.find_opt (fun (field, _, _) -> Atom.eq field atom) typfields with
    | Some (_, (_, typ', _), _) -> typ'
    | None -> error_field source typ atom



(* Expr validation *)

let valid_expr (walker: unit_walker) (expr: expr) : unit =
  let source = string_of_expr expr $ expr.at in
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
  | StrE r ->
    let typfields = get_typfields expr.note in
    List.iter (check_field source expr.note r) typfields
  | CatE (expr1, expr2) ->
    check_list source expr1.note; check_list source expr2.note;
    check_match source expr.note expr1.note; check_match source expr1.note expr2.note
  | MemE (expr1, expr2) ->
    check_bool source expr.note;
    check_match source expr2.note (iterT expr1.note List)
  | LenE expr' ->
    check_list source expr'.note; check_num source expr.note
  | TupE exprs -> check_tuple source exprs expr.note
  | CaseE _ -> () (* TODO *)
  | CallE (id, args) -> check_call source id args expr.note
  (* TODO *)
  | IterE (expr1, _, iter) ->
    if not (expr1.note.it = BoolT && expr.note.it = BoolT) then
      (match iter with
      | Opt ->
        check_match source expr.note (iterT expr1.note Opt);
      | ListN (expr2, id_opt) ->
        Option.iter add_bound_var id_opt;
        check_match source expr.note (iterT expr1.note List);
        check_num source expr2.note
      | _ ->
        check_match source expr.note (iterT expr1.note List);
      )
  | _ ->
    match expr.note.it with
    | VarT (id, []) when id.it = "TODO" ->
      error expr.at (Printf.sprintf "%s's type is TODO" (string_of_expr expr))
    | _ -> ()
  );
  (Option.get walker.super).walk_expr walker expr


(* Instr validation *)

let valid_instr (walker: unit_walker) (instr: instr) : unit =
  print_endline (string_of_instr instr);
  let source = string_of_instr instr $ instr.at in
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
  (Option.get walker.super).walk_instr walker instr

let init algo =
  let params = Al_util.params_of_algo algo in

  bound_set := Set.empty;
  List.iter add_bound_param params


let valid_algo (algo: algorithm) =

  print_string (Al_util.name_of_algo algo ^ "(");

  algo
  |> Al_util.params_of_algo
  |> List.map string_of_arg
  |> String.concat ", "
  |> print_string;
  print_endline ")";

  init algo;
  let walker =
    { base_unit_walker with
      super = Some base_unit_walker;
      walk_expr = valid_expr;
      walk_instr = valid_instr
    }
  in
  walker.walk_algo walker algo

let valid (script: script) =
  List.iter valid_algo script
