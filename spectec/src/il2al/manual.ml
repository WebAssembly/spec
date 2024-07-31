open Util.Source
open Al
open Ast
open Al_util

type config = expr * expr * instr list

let atom_of_name name typ = El.Atom.Atom name $$ no_region % (El.Atom.info typ)
let varT id args = Il.Ast.VarT (id $ no_region, args) $ no_region
let listT ty = Il.Ast.IterT (ty, Il.Ast.List) $ no_region


let eval_expr =
  let ty_instr = varT "instr" [] in
  let ty_instrs = listT ty_instr in
  let ty_val = varT "val" [] in
  let ty_vals = listT ty_val in
  let instrs = iterE (varE "instr" ~note:ty_instr, ["instr"], List) ~note:ty_instrs in
  let result = varE "val" ~note:ty_val in

  FuncA (
    "eval_expr",
    [instrs],
    [
      executeI instrs;
      popI result;
      returnI (Some (listE [ result ] ~note:ty_vals))
    ]
  ) $ no_region

let manual_algos = [eval_expr]

let return_instrs_of_instantiate config =
  let store, frame, rhs = config in
  [
    enterI (
      frameE (Some (numE Z.zero), frame),
      listE ([ caseE (atom_of_name "FRAME_" "admininstr", []) ]), rhs
    );
    returnI (Some (tupE [ store; accE (frame, DotP (atom_of_name "MODULE" "") $ no_region) ]))
  ]
let return_instrs_of_invoke config =
  let _, frame, rhs = config in
  [
    letI (varE "k", lenE (iterE (varE "t_2", ["t_2"], List)));
    enterI (
      frameE (Some (varE "k"), frame),
      listE ([caseE (atom_of_name "FRAME_" "admininstr", [])]), rhs
    );
    popI (iterE (varE "val", ["val"], ListN (varE "k", None)));
    returnI (Some (iterE (varE "val", ["val"], ListN (varE "k", None))))
  ]


