open Util.Source
open Al
open Ast
open Al_util
open Il2al_util

type config = expr * expr * instr list

let varT id args = Il.Ast.VarT (id $ no_region, args) $ no_region
let listT ty = Il.Ast.IterT (ty, Il.Ast.List) $ no_region

let expA e = ExpA e $ e.at

let eval_expr =
  let open Xl.Atom in
  let ty_instrs = listT instrT in
  let ty_vals = listT valT in
  let instrs = iter_var "instr" List instrT in
  let result = varE "val" ~note:valT in

  (* Add function definition to AL environment *)
  let param = Il.Ast.ExpP ("_" $ no_region, ty_instrs) $ no_region in
  Al.Valid.il_env :=
    Il.Env.bind_def !Al.Valid.il_env ("Eval_expr" $ no_region) ([param], ty_vals, []);

  RuleA (
    Atom "Eval_expr" $$ no_region % {def=""; case=""},
    "Eval_expr",
    [expA instrs],
    [
      executeSeqI instrs;
      popI result;
      returnI (Some (listE [ result ] ~note:ty_vals))
    ]
  ) $ no_region

let manual_algos = [eval_expr]

let return_instrs_of_instantiate _idset config =
  let store, frame, rhs = config in
  let ty' = varT "moduleinst" [] in
  let ty'' = Il.Ast.TupT (List.map (fun t -> no_name, t) [store.note; ty']) $ no_region in

  pushI (frameE (natE Z.zero ~note:natT, frame) ~note:evalctxT) ::
    rhs @
    [
      popI (frameE (natE Z.zero ~note:natT, frame) ~note:evalctxT);
      returnI (Some (tupE [
        store;
        accE (frame, DotP (atom_of_name "MODULE" "") $ no_region) ~note:ty'
      ] ~note:ty''))
    ]
let return_instrs_of_invoke idset config =
  let _, frame, rhs = config in
  let arity_name = introduce_fresh_variable ~prefix:"k" idset natT in
  let arity = varE arity_name ~note:natT in
  let valtype = varT "valtype" [] in
  let len_expr = lenE (iter_var "t_2" List valtype) ~note:natT in

  let var_name =
    iterT valT (ListN (Il.Ast.VarE (arity_name $ no_region) $$ no_region % natT, None))
    |> introduce_fresh_variable idset in
  let e_vals = iter_var var_name (ListN (arity, None)) valT in

  letI (arity,  len_expr) ::
    pushI (frameE (arity, frame) ~note:evalctxT) ::
    rhs @
    [ popI e_vals;
      popI (frameE (arity, frame) ~note:evalctxT);
      returnI (Some e_vals)
    ]
