open Util.Source
open Al
open Ast
open Al_util

type config = expr * expr * instr list

let varT id args = Il.Ast.VarT (id $ no_region, args) $ no_region
let listT ty = Il.Ast.IterT (ty, Il.Ast.List) $ no_region

let expA e = ExpA e $ e.at

let eval_expr =
  let ty_instrs = listT instrT in
  let ty_vals = listT valT in
  let instrs = iter_var "instr" List instrT in
  let result = varE "val" ~note:valT in

  (* Add function definition to AL environment *)
  let param = Il.Ast.ExpP ("_" $ no_region, ty_instrs) $ no_region in
  Al.Valid.il_env :=
    Il.Env.bind_def !Al.Valid.il_env ("eval_expr" $ no_region) ([param], ty_vals, []);

  FuncA (
    "eval_expr",
    [expA instrs],
    [
      executeI instrs;
      popI result;
      returnI (Some (listE [ result ] ~note:ty_vals))
    ]
  ) $ no_region

let manual_algos = [eval_expr]

let return_instrs_of_instantiate config =
  let store, frame, rhs = config in
  let vals, instrs = rhs in
  let ty = listT admininstrT in
  let ty' = varT "moduleinst" [] in
  let ty'' = Il.Ast.TupT (List.map (fun t -> no_name, t) [store.note; ty']) $ no_region in
  [
    enterI (
      frameE (natE Z.zero ~note:natT, frame) ~note:evalctxT,
      catE (instrs, (listE [caseE ([[atom_of_name "FRAME_" "admininstr"]], []) ~note:admininstrT] ~note:ty)) ~note:ty,
      vals
    );
    returnI (Some (tupE [
      store;
      accE (frame, DotP (atom_of_name "MODULE" "") $ no_region) ~note:ty'
    ] ~note:ty''))
  ]
let return_instrs_of_invoke config =
  let _, frame, rhs = config in
  let vals, instrs = rhs in
  let arity = varE "k" ~note:natT in
  let e_vals = iter_var "val" (ListN (arity, None)) valT in
  let ty = listT admininstrT in
  let valtype = varT "valtype" [] in
  let len_expr = lenE (iter_var "t_2" List valtype) ~note:natT in
  [
    letI (arity,  len_expr);
    enterI (
      frameE (arity, frame) ~note:evalctxT,
      catE (instrs, listE [caseE ([[atom_of_name "FRAME_" "admininstr"]], []) ~note:admininstrT] ~note:ty) ~note:ty,
      vals
    );
    popI e_vals;
    returnI (Some e_vals)
  ]
