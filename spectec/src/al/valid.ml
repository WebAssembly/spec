open Util
open Source
open Il.Ast
open Ast
open Al_util
open Print
open Walk
open Free


module Atom = El.Atom
module IlEval = Il.Eval

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
let error_case source typ =
  error_valid "invalid case type" source (Il.Print.string_of_typ typ)


let (let*) = Option.bind

module Env = struct
  include Map.Make(String)

  type t = expr option Map.Make(String).t

  (* TODO: pass env *)
  let env: t ref = ref empty
  let add_bound_var id = env := add id None !env
  let add_bound_vars expr = IdSet.iter add_bound_var (free_expr expr)
  let add_bound_param arg =
    match arg.it with ExpA e -> add_bound_vars e | TypA _ | DefA _ -> ()
  let add_subst lhs rhs =
    let open Eval in
    env :=
      get_subst lhs rhs Subst.empty
      |> Subst.map Option.some
      |> merge (fun _ _ _ -> (* TODO *) assert (false)) !env
  let add id expr = env := add id (Some expr) !env
end

(* Type Env *)

module IlEnv = Il.Env
let il_env: IlEnv.t ref = ref IlEnv.empty


let varT s = VarT (s $ no_region, []) $ no_region

let is_trivial_mixop = List.for_all (fun atoms -> List.length atoms = 0)


(* Subtyping *)

let get_deftyps (id: Il.Ast.id) (args: Il.Ast.arg list): deftyp list =
  match IlEnv.find_opt_typ !il_env id with
  | Some (_, insts) ->
    let typ_of_arg arg =
      match (IlEval.reduce_arg !il_env arg).it with
      | ExpA { it=SubE (_, typ, _); _ } -> typ
      | ExpA { note; _ } -> note
      | TypA typ -> typ
      | a -> failwith ("TODO: " ^ Il.Print.string_of_arg (a $ arg.at))
    in
    let get_syntax_arg_name arg = 
      match arg.it with
      | Il.Ast.TypA { it=VarT (id, []); _ } -> Some id
      | _ -> None
    in
    let subst_syntax_arg subst arg inst_arg =
      let name = get_syntax_arg_name inst_arg in
      if Option.is_some name then
        let name = Option.get name in
        Il.Subst.add_typid subst name (typ_of_arg arg)
      else
        subst
    in
    let subst_inst inst =
      let InstD (binds, inst_args, deftyp) = inst.it in 
      let subst = List.fold_left2 subst_syntax_arg Il.Subst.empty args inst_args in
      let new_args = Il.Subst.subst_args subst inst_args in
      let new_deftyp = Il.Subst.subst_deftyp subst deftyp in
      { inst with it = InstD (binds, new_args, new_deftyp) }
    in
    let insts = List.map subst_inst insts in
    let get_deftyp inst =
      let InstD (_, inst_args, deftyp) = inst.it in
      let valid_arg arg inst_arg = 
        IlEval.sub_typ !il_env (typ_of_arg arg) (typ_of_arg inst_arg)
      in
      if List.for_all2 valid_arg args inst_args then
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
    typcases |> List.map (fun (_mixop, (_bs, typ, _ps), _hs) -> typ) |> unify_typs_opt
  | _ -> None

and unify_deftyps_opt : deftyp list -> typ option = function
  | [] -> None
  | [deftyp] -> unify_deftyp_opt deftyp
  | deftyp :: deftyps ->
    let* typ1 = unify_deftyp_opt deftyp in
    let* typ2 = unify_deftyps_opt deftyps in
    unify_typ_opt typ1 typ2

and unify_typ_opt (typ1: typ) (typ2: typ) : typ option =
  let typ1', typ2' = ground_typ_of typ1, ground_typ_of typ2 in
  match typ1'.it, typ2'.it with
  | VarT (id1, _), VarT (id2, _) when id1 = id2 -> Some typ1'
  | BoolT, BoolT | NumT _, NumT _ | TextT, TextT -> Some typ1'
  | TupT etl1, TupT etl2 ->
    let* etl =
      List.fold_right2
        (fun et1 et2 acc ->
          let* acc = acc in
          let* res = unify_typ_opt (snd et1) (snd et2) in
          Some ((fst et1, res) :: acc)
        )
        etl1
        etl2
        (Some [])
    in
    Some (TupT etl $ typ1.at)
  | IterT (typ1'', iter), IterT (typ2'', _) ->
    let* typ = unify_typ_opt typ1'' typ2'' in
    Some (IterT (typ, iter) $ typ1.at)
  | _ -> None

and unify_typs_opt : typ list -> typ option = function
  | [] -> None
  | [typ] -> Some typ
  | typ :: typs' ->
    let* unified_typ = unify_typs_opt typs' in
    unify_typ_opt typ unified_typ

and ground_typ_of (typ: typ) : typ =
  match typ.it with
  | VarT (id, _) when IlEnv.mem_var !il_env id ->
    let typ' = IlEnv.find_var !il_env id in
    if Il.Eq.eq_typ typ typ' then typ else ground_typ_of typ'
  (* NOTE: Consider `fN` as a `NumT` to prevent diverging ground type *)
  | VarT (id, _) when id.it = "fN" -> NumT RealT $ typ.at
  | VarT (id, args) ->
    get_deftyps id args
    |> unify_deftyps_opt
    |> Option.map ground_typ_of
    |> Option.value ~default:typ
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
  | _, _ -> IlEval.sub_typ !il_env typ1' typ2'

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
  | VarT (id, _) when IlEnv.mem_typ !il_env id ->
    let _, insts = IlEnv.find_typ !il_env id in
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

let check_opt source typ =
  match typ.it with
  | IterT (_, Opt) -> ()
  | _ -> error_mismatch source typ (varT "option")

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

let check_struct source typ =
  match typ.it with
  | VarT (id, args) -> (
    let deftyps = get_deftyps id args in
    if not (List.exists (fun deftyp -> match deftyp.it with StructT _ -> true | _ -> false) deftyps) then
      error_valid "not a struct" source (Il.Print.string_of_typ typ)
  )
  | _ -> error_valid "not a struct" source (Il.Print.string_of_typ typ)

let check_tuple source exprs typ =
  match (ground_typ_of typ).it with
  | TupT etl when List.length exprs = List.length etl ->
    let f expr (_, typ) = check_match source expr.note typ in
    List.iter2 f exprs etl
  | _ -> error_tuple source typ

let check_call source id args result_typ =
  match IlEnv.find_opt_def !il_env (id $ no_region) with
  | Some (params, typ, _) ->
    (* TODO: Use local il_environment *)
    (* Store global il_enviroment *)
    let global_il_env = !il_env in

    let check_arg arg param =
      match arg.it, param.it with
      | ExpA expr, ExpP (_, typ') -> check_match source expr.note typ'
      (* Add local variable typ *)
      | TypA typ1, TypP id -> il_env := IlEnv.bind_var !il_env id typ1
      | DefA aid, DefP (_, pparams, ptyp) ->
        (match IlEnv.find_opt_def !il_env (aid $ no_region) with
        | Some (aparams, atyp, _) -> 
          if not (IlEval.sub_typ !il_env atyp ptyp) then
            error_valid
              "argument's return type is not a subtype of parameter's return type"
              source
              (Printf.sprintf "  %s !<: %s"
                (Il.Print.string_of_typ atyp)
                (Il.Print.string_of_typ ptyp)
              );
          List.iter2 (fun aparam pparam ->
            (* TODO: only supports ExpP for param of arg/param now *)
            let typ_of_param param =  match param.it with
            | ExpP (_, typ) -> typ
            | _ ->
              error_valid "argument param is not an expression" source
                (Il.Print.string_of_param aparam);
            in

            let aptyp = typ_of_param aparam in
            let pptyp = typ_of_param pparam in

            if not (IlEval.sub_typ !il_env pptyp aptyp) then
              error_valid
                "parameter's parameter type is not a subtype of argument's return type"
                source
                (Printf.sprintf "  %s !<: %s"
                  (Il.Print.string_of_typ pptyp)
                  (Il.Print.string_of_typ aptyp)
                );
            ) aparams pparams;
        | _ -> error_valid "no function definition" source aid
        );
      | _ ->
        error_valid "argument type mismatch" source
          (Printf.sprintf "  %s =/= %s"
            (string_of_arg arg)
            (Il.Print.string_of_param param)
          )
    in
    List.iter2 check_arg args params;
    check_match source result_typ typ;

    (* Reset global il_enviroment *)
    il_env := global_il_env
  | None -> error_valid "no function definition" source ""

let check_inv_call source id indices args result_typ =
  (* Get typs from result_typ *)
  let typs =
    match result_typ.it with
    | TupT l -> l |> List.split |> snd
    | _ -> [result_typ]
  in

  (* Make arguments with typs *)
  let typ2arg typ = ExpA (VarE "" $$ no_region % typ) $ no_region in
  let free_args = List.map typ2arg typs in

  (* Merge free args and bound args *)
  let merge_args args idx =
    let free_args, bound_args, merged_args = args in
    if Option.is_some idx then
      let first_free_arg, new_free_args = Lib.List.split_hd free_args in
      new_free_args, bound_args, merged_args @ [first_free_arg]
    else
      let first_bound_arg, new_bound_args = Lib.List.split_hd bound_args in
      free_args, new_bound_args, merged_args @ [first_bound_arg]
  in
  let free_args', result_args, merged_args =
    List.fold_left merge_args (free_args, args, []) indices
  in
  (* TODO: Use error function *)
  assert (List.length free_args' = 0);

  (* Set new result typ from the last elements of args *)
  let new_result_typ =
    match result_args with
    | [arg] -> (
      match arg.it with
      | ExpA exp -> exp.note
      | a -> error_valid (Printf.sprintf "wrong result argument")
        source (Print.string_of_arg (a $ no_region))
    )
    | _ ->
      let arg2typ arg = (
        match arg.it with
        | ExpA exp -> (Il.Ast.VarE ("" $ no_region) $$ no_region % exp.note, exp.note)
        | a -> error_valid (Printf.sprintf "wrong result argument")
          source (Print.string_of_arg (a $ no_region))
      ) in
      TupT (List.map arg2typ result_args) $ no_region
  in
  check_call source id merged_args new_result_typ

let check_case source exprs typ =
  match typ.it with
  | TupT etl when List.length exprs = List.length etl ->
    let f expr (_, typ) = check_match source expr.note typ in
    List.iter2 f exprs etl
  | _ -> error_case source typ

let find_case source cases op =
  match List.find_opt (fun (op', _, _) -> Il.Mixop.eq op' op) cases with
  | Some (_op, x, _hints) -> x
  | None -> error_valid "unknown case" source (string_of_mixop op)

let get_typcases source typ =
  let dt =
    match typ.it with
    | VarT (id, args) ->
      (match get_deftyps id args with
      | [ dt ] -> dt
      | _ -> error_case source typ
      )
    | _ -> error_case source typ
  in
  match dt.it with
  | VariantT tcs -> tcs
  | _ -> error_case source typ

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
    if not (Env.mem id !Env.env) then error expr.at ("free identifier " ^ id)
  | NumE _ -> check_num source expr.note;
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
  | CompE (expr1, expr2) ->
    check_struct source expr1.note; check_struct source expr2.note;
    check_match source expr.note expr1.note; check_match source expr1.note expr2.note
  | CatE (expr1, expr2) ->
    check_list source expr1.note; check_list source expr2.note;
    check_match source expr.note expr1.note; check_match source expr1.note expr2.note
  | MemE (expr1, expr2) ->
    check_bool source expr.note;
    check_match source expr2.note (iterT expr1.note List)
  | LenE expr' ->
    check_list source expr'.note; check_num source expr.note
  | TupE exprs -> check_tuple source exprs expr.note
  | CaseE (op, exprs) ->
    let tcs = get_typcases source expr.note in
    let _binds, typ, _prems = find_case source tcs op in
    check_case source exprs typ
  | CallE (id, args) -> check_call source id args expr.note
  | InvCallE (id, indices, args) -> check_inv_call source id indices args expr.note;
  | IterE (expr1, (iter, xes)) -> (* TODO *)
    let global_env = !Env.env in
    if not (expr1.note.it = BoolT && expr.note.it = BoolT) then
      List.iter (fun (id, e) -> Env.add id e) xes;
      (match iter with
      | Opt ->
        check_match source expr.note (iterT expr1.note Opt);
      | ListN (expr2, _) ->
        check_match source expr.note (iterT expr1.note List);
        check_num source expr2.note
      | _ ->
        check_match source expr.note (iterT expr1.note List);
      );
    Env.env := global_env
  | OptE expr_opt ->
    check_opt source expr.note;
    Option.iter
      (fun expr' -> check_match source expr.note (iterT expr'.note Opt))
      expr_opt
  | ListE l ->
    check_list source expr.note;
    let elem_typ = unwrap_iter_typ expr.note in
    l
    |> List.map note
    |> List.iter (check_match source elem_typ)
  | ArityE expr1 ->
    check_num source expr.note; check_context source expr1.note
  | FrameE (expr_opt, expr1) ->
    check_context source expr.note;
    Option.iter (fun expr2 -> check_num source expr2.note) expr_opt;
    check_match source expr1.note (varT "frame")
  | LabelE (expr1, expr2) ->
    check_context source expr.note;
    check_num source expr1.note;
    check_match source expr2.note (iterT (varT "instr") List)
  | GetCurStateE | GetCurFrameE | GetCurLabelE | GetCurContextE ->
    check_context source expr.note
  | BoolE _  | IsCaseOfE _ | IsValidE _ | MatchE _ | HasTypeE _ | TopFrameE | TopLabelE ->
    check_bool source expr.note
  | ContE expr1 ->
    check_match source expr.note (iterT (varT "instr") List);
    check_match source expr1.note (varT "label")
  | ChooseE expr1 ->
    check_list source expr1.note; check_match source expr1.note (iterT expr.note List)
  | ContextKindE _ -> () (* TODO: Not used anymore *)
  | IsDefinedE expr1 ->
    check_opt source expr1.note; check_bool source expr.note
  | TopValueE expr_opt ->
    check_bool source expr.note;
    Option.iter (fun expr1 -> check_match source expr1.note (varT "valtype")) expr_opt
  | TopValuesE expr1 ->
    check_bool source expr.note; check_num source expr1.note
  | SubE _ | YetE _ -> error_valid "invalid expression" source ""
  );
  base_unit_walker.walk_expr walker expr


(* Instr validation *)

let valid_instr (walker: unit_walker) (instr: instr) : unit =
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
  | PopI expr | PopAllI expr -> Env.add_bound_vars expr;
    if
      not (sub_typ (get_base_typ expr.note) (varT "val")) &&
      not (sub_typ (get_base_typ expr.note) (varT "callframe"))
    then
      error_mismatch source (get_base_typ expr.note) (varT "val")
  | LetI (expr1, expr2) ->
    Env.add_subst expr1 expr2; check_match source expr1.note expr2.note
  | ExecuteI expr | ExecuteSeqI expr -> check_instr source expr.note
  | PerformI (id, args) -> check_call source id args (TupT [] $ no_region)
  | ReplaceI (expr1, path, expr2) ->
    access source expr1.note path |> check_match source expr2.note
  | AppendI (expr1, _expr2) -> check_list source expr1.note
  | FieldWiseAppendI (expr1, expr2) -> check_struct source expr1.note; check_struct source expr2.note
  | OtherwiseI _ | YetI _ -> error_valid "invalid instruction" source ""
  | _ -> ()
  );
  base_unit_walker.walk_instr walker instr

let init algo =
  let params = Al_util.params_of_algo algo in

  Env.add_bound_var "s";
  List.iter Env.add_bound_param params


let valid_algo (algo: algorithm) =

  algo
  |> Al_util.params_of_algo
  |> List.map string_of_arg
  |> String.concat ", "
  |> Printf.sprintf "%s(%s)" (Al_util.name_of_algo algo)
  |> print_endline;


  (* TODO: Use local il_environment *)
  (* Store global il_enviroment *)
  let global_il_env = !il_env in

  (* Add function argument to il_environment *)
  (match IlEnv.find_opt_def !il_env (Al_util.name_of_algo algo $ no_region) with
  | Some (params, _, _) -> List.iter (fun param ->
      (match param.it with
      | DefP (id, params', typ') -> il_env := IlEnv.bind_def !il_env id (params', typ', [])
      | _ -> ()
      )
    ) params;
  | _ -> ()
  );

  init algo;
  let walker =
    { base_unit_walker with
      walk_expr = valid_expr;
      walk_instr = valid_instr
    }
  in
  walker.walk_algo walker algo;

  (* Reset global il_enviroment *)
  il_env := global_il_env

let valid (script: script) =
  Lang.al := script;
  List.iter valid_algo script
