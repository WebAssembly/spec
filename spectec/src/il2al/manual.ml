open Util.Source
open Al
open Ast
open Al_util

type config = expr * expr * instr list

let atom_of_name name typ = Il.Atom.Atom name, typ

let eval_expr =
  let instrs = iterE (varE "instr", ["instr"], List) in
  let result = varE "val" in

  FuncA (
    "eval_expr",
    [instrs],
    [
      executeseqI instrs;
      popI result;
      returnI (Some (listE [ result ]))
    ]
  )

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
  )

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
  )

let manual_algos = [eval_expr; group_bytes_by; array_new_data;]

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


