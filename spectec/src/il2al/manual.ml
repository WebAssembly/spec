open Util.Source
open Al
open Ast
open Al_util

type config = expr * expr * instr list

let atom_of_name name typ = El.Atom.Atom name $$ no_region % (El.Atom.info typ)
let varT id args = Il.Ast.VarT (id $ no_region, args) $ no_region
let listT ty = Il.Ast.IterT (ty, Il.Ast.List) $ no_region

let eval_expr =
  let ty_instrs = listT instrT in
  let ty_vals = listT valT in
  let instrs = iterE (varE "instr" ~note:instrT, ["instr"], List) ~note:ty_instrs in
  let result = varE "val" ~note:valT in

  FuncA (
    "eval_expr",
    [instrs],
    [
      executeI instrs;
      popI result;
      returnI (Some (listE [ result ] ~note:ty_vals))
    ]
  ) $ no_region

(* Helper for the manual array_new.data algorithm *)

let group_bytes_by =
  let n = varE "n" in
  let n' = varE "n'" in

  let bytes_ = iterE (varE "byte", ["byte"], List) in
  let bytes_left = listE [accE (bytes_, sliceP (numE Z.zero, n))] in
  let bytes_right = callE
    (
      "group_bytes_by",
      [ n; accE (bytes_, sliceP (n, binE (SubOp, n', n))) ]
    )
  in

  FuncA (
    "group_bytes_by",
    [n; bytes_],
    [
      letI (n', lenE bytes_);
      ifI (
        binE (GeOp, n', n),
        [ returnI (Some (catE (bytes_left, bytes_right))) ],
        []
      );
      returnI (Some (listE []));
    ]
  ) $ no_region

let array_new_data =
  let i32 = caseE (atom_of_name "I32" "numtype", []) in

  let x = varE "x" in
  let y = varE "y" in
  let z = varE "z" in

  let n = varE "n" in
  let i = varE "i" in

  let y_0 = varE "y_0" in
  let mut = varE "mut" in
  let zt = varE "zt" in

  let cnn = varE "cnn" in

  let c = varE "c" in

  let bstar = iterE (varE "b", ["b"], List) in
  let gb = varE "gb" in
  let gbstar = iterE (gb, ["gb"], List) in
  let cn = iterE (c, ["c"], ListN (n, None)) in

  let expanddt_with_type = callE ("expanddt", [callE ("type", [z; x])]) in
  let zsize = callE ("zsize", [zt]) in
  let cunpack = callE ("cunpack", [zt]) in
  let data = callE ("data", [z; y]) in
  let group_bytes_by = callE ("group_bytes_by", [binE (DivOp, zsize, numE (Z.of_int 8)); bstar]) in
  let inverse_of_bytes_ = iterE (callE ("inverse_of_ibytes", [zsize; gb]), ["gb"], List) in

  RuleA (
    atom_of_name "ARRAY.NEW_DATA" "admininstr",
    [x; y],
    [
      assertI (topValueE (Some i32));
      popI (caseE (atom_of_name "CONST" "admininstr", [i32; n]));
      assertI (topValueE (Some i32));
      popI (caseE (atom_of_name "CONST" "admininstr", [i32; i]));
      ifI (
        isCaseOfE (expanddt_with_type, atom_of_name "ARRAY" "comptype"),
        [
          letI (caseE (atom_of_name "ARRAY" "comptype", [y_0]), expanddt_with_type);
          letI (tupE [ mut; zt ], y_0);
          ifI (
            binE (
              GtOp,
              binE (AddOp, i, binE (DivOp, binE (MulOp, n, zsize), numE (Z.of_int 8))),
              lenE (accE (callE ("data", [z; y]), dotP (atom_of_name "BYTES" "datainst")))
            ),
            [ trapI () ],
            []
          );
          letI (cnn, cunpack);
          letI (
            bstar,
            accE (
              accE (data, dotP (atom_of_name "BYTES" "datainst")),
              sliceP (i, binE (DivOp, binE (MulOp, n, zsize), numE (Z.of_int 8)))
            )
          );
          letI (gbstar, group_bytes_by);
          letI (cn, inverse_of_bytes_);
          pushI (iterE (caseE (atom_of_name "CONST" "admininstr", [cnn; c]), ["c"], ListN (n, None)));
          executeI (caseE (atom_of_name "ARRAY.NEW_FIXED" "admininstr", [x; n]));
        ],
        []
      );
    ]
  ) $ no_region

let manual_algos = [eval_expr; group_bytes_by; array_new_data;]

let return_instrs_of_instantiate config =
  let store, frame, rhs = config in
  let ty = listT admininstrT in
  let ty' = varT "moduleinst" [] in
  let ty'' = Il.Ast.TupT (List.map (fun t -> no_name, t) [store.note; ty']) $ no_region in
  [
    enterI (
      frameE (Some (numE Z.zero ~note:natT), frame) ~note:callframeT,
      listE ([ caseE (atom_of_name "FRAME_" "admininstr", []) ~note:admininstrT]) ~note:ty,
      rhs
    );
    returnI (Some (tupE [
      store;
      accE (frame, DotP (atom_of_name "MODULE" "") $ no_region) ~note:ty'
    ] ~note:ty''))
  ]
let return_instrs_of_invoke config =
  let _, frame, rhs = config in
  let arity = varE "k" ~note:natT in
  let value = varE "val" ~note:valT in
  let ty = listT admininstrT in
  let ty' = listnT valT (Il.Ast.VarE ("k" $ no_region) $$ no_region % natT) in
  [
    letI (arity, lenE (iterE (varE "t_2", ["t_2"], List)) ~note:natT);
    enterI (
      frameE (Some (arity), frame) ~note:callframeT,
      listE ([caseE (atom_of_name "FRAME_" "admininstr", []) ~note:admininstrT]) ~note:ty,
      rhs
    );
    popI (iterE (value, ["val"], ListN (arity, None)) ~note:ty');
    returnI (Some (iterE (value, ["val"], ListN (arity, None)) ~note:ty'))
  ]


