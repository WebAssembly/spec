open Al.Ast
open Construct
open Util.Record

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

(*
execution_of_CALL_REF ?(x)
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop u_0 from the stack.
3. If u_0 is of the case REF.NULL, then:
  a. Trap.
4. If u_0 is of the case REF.FUNC_ADDR, then:
4. Let (REF.FUNC_ADDR a) be u_0.
5. If a < |$funcinst()|, then:
  a. Let fi be $funcinst()[a].
  b. If fi.CODE is of the case FUNC, then:
    1) Let (FUNC x' y_1 instr* ) be fi.CODE.
    2) Let (LOCAL t)* be y_1.
    3) If $expanddt(fi.TYPE) is of the case FUNC, then:
      a) Let (FUNC y_0) be $expanddt(fi.TYPE).
      b) Let [t_1^n]->[t_2^m] be y_0.
      c) Assert: Due to validation, there are at least n values on the top of the stack.
      d) Pop val^n from the stack.
      e) Let f be { LOCAL: ?(val)^n ++ $default(t)*; MODULE: fi.MODULE; }.
      f) Let F be the activation of f with arity m.
      g) Enter F with label [FRAME_]:
        1. Let L be the label_m{[]}.
        2. Enter L with label instr* ++ [LABEL_]:

*)

let call_ref =
  (* names *)
  let x = varE "x" in
  let ref = varE "ref" in
  let a = varE "a" in
  let fi = varE "fi" in
  let y0 = varE "y_0" in
  let y1 = varE "y_1" in
  let t = varE "t" in
  let t1 = varE "t_1" in
  let t2 = varE "t_2" in
  let n = varE "n" in
  let m = varE "m" in
  let v = varE "val" in
  let f = varE "f" in
  let ff = varE "F" in
  let ll = varE "L" in
  let instr = varE "instr" in

  RuleA (
    ("CALL_REF", "admininstr"),
    [ x ],
    [
      assertI (topValueE None);
      popI ref;
      ifI (
        isCaseOfE (ref, ("REF.NULL", "admininstr")),
        [ trapI ],
        []
      );
      assertI (isCaseOfE (ref, ("REF.FUNC_ADDR", "admininstr")));
      letI (caseE (("REF.FUNC_ADDR", "admininstr"), [a]), ref);
      ifI (
        binE (LtOp, a, lenE (callE ("funcinst", []))),
        [
        letI (fi, accE (callE ("funcinst", []), idxP a));
        ifI (
          isCaseOfE (accE (fi, dotP ("CODE", "code")), ("FUNC", "func")),
          [
          letI (caseE (("FUNC", "func"), [y0 ; y1 ; iterE (instr, ["instr"], List)]), accE (fi, dotP ("CODE", "code")));
          letI (iterE (caseE (("LOCAL","local"), [t]), ["t"], List), y1);
          ifI (
            isCaseOfE (callE ("expanddt", [ accE (fi, dotP ("TYPE", "type")) ]), ("FUNC", "comptype")),
            [
            letI (caseE (("FUNC", "comptype"), [y0]), callE ("expanddt", [ accE (fi, dotP ("TYPE", "type")) ]));
            letI (arrowE (iterE (t1, ["t_1"], ListN (n, None)), iterE (t2, ["t_2"], ListN (m, None))), y0);
            assertI (topValuesE n);
            popI (iterE (v, ["val"], ListN(n, None)));
            letI (f, strE (Record.empty
              |> Record.add
                ("LOCAL", "frame")
                (catE (iterE (optE (Some v), ["val"], ListN (n, None)), iterE (callE("default", [t]), ["t"], List)))
              |> Record.add
                ("MODULE", "frame")
                (accE (fi, dotP ("MODULE", "module")))
            ));
            letI (ff, frameE (Some m, f));
            enterI (ff, listE ([caseE (("FRAME_", ""), [])]),
              [
              letI (ll, labelE (m, listE []));
              enterI (ll, catE (iterE (instr, ["instr"], List), listE ([caseE (("LABEL_", ""), [])])), []);
              ]
            );
            ], []);
          ], []);
        ], []);
      ]
    )

(* Helper for the manual array_new.data algorithm *)

let group_bytes_by =
  let n = varE "n" in
  let n' = varE "n'" in

  let bytes_ = iterE (varE "byte", ["byte"], List) in
  let bytes_left = listE [accE (bytes_, sliceP (numE 0L, n))] in
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
  let i32 = caseE (("I32", "numtype"), []) in

  let x = varE "x" in
  let y = varE "y" in

  let n = varE "n" in
  let i = varE "i" in

  let y_0 = varE "y_0" in
  let mut = varE "mut" in
  let zt = varE "zt" in

  let nt = varE "nt" in

  let c = varE "c" in

  let bstar = iterE (varE "b", ["b"], List) in
  let gb = varE "gb" in
  let gbstar = iterE (gb, ["gb"], List) in
  let cn = iterE (c, ["c"], ListN (n, None)) in

  let expanddt_with_type = callE ("expanddt", [callE ("type", [x])]) in
  let storagesize = callE ("storagesize", [zt]) in
  let unpacknumtype = callE ("unpacknumtype", [zt]) in
  (* include z or not ??? *)
  let data = callE ("data", [y]) in
  let group_bytes_by = callE ("group_bytes_by", [binE (DivOp, storagesize, numE 8L); bstar]) in
  let inverse_of_bytes_ = iterE (callE ("inverse_of_ibytes", [storagesize; gb]), ["gb"], List) in

  RuleA (
    ("ARRAY.NEW_DATA", "admininstr"),
    [x; y],
    [
      assertI (topValueE (Some i32));
      popI (caseE (("CONST", "admininstr"), [i32; n]));
      assertI (topValueE (Some i32));
      popI (caseE (("CONST", "admininstr"), [i32; i]));
      ifI (
        isCaseOfE (expanddt_with_type, ("ARRAY", "comptype")),
        [
          letI (caseE (("ARRAY", "comptype"), [y_0]), expanddt_with_type);
          letI (tupE [ mut; zt ], y_0);
          ifI (
            binE (
              GtOp,
              binE (AddOp, i, binE (DivOp, binE (MulOp, n, storagesize), numE 8L)),
              lenE (accE (callE ("data", [y]), dotP ("DATA", "datainst")))
            ),
            [trapI],
            []
          );
          letI (nt, unpacknumtype);
          letI (
            bstar,
            accE (
              accE (data, dotP ("DATA", "datainst")),
              sliceP (i, binE (DivOp, binE (MulOp, n, storagesize), numE 8L))
            )
          );
          letI (gbstar, group_bytes_by);
          letI (cn, inverse_of_bytes_);
          pushI (iterE (caseE (("CONST", "admininstr"), [nt; c]), ["c"], ListN (n, None)));
          executeI (caseE (("ARRAY.NEW_FIXED", "admininstr"), [x; n]));
        ],
        []
      );
    ]
  )

let manual_algos = [eval_expr; call_ref; group_bytes_by; array_new_data;]

let return_instrs_of_instantiate config =
  let store, frame, rhs = config in
  [
    enterI (
      frameE (Some (numE 0L), frame),
      listE ([ caseE (("FRAME_", ""), []) ]), rhs
    );
    returnI (Some (tupE [ store; varE "mm" ]))
  ]
let return_instrs_of_invoke config =
  let _, frame, rhs = config in
  [
    letI (varE "k", lenE (iterE (varE "t_2", ["t_2"], List)));
    enterI (
      frameE (Some (varE "k"), frame),
      listE ([caseE (("FRAME_", ""), [])]), rhs
    );
    popI (iterE (varE "val", ["val"], ListN (varE "k", None)));
    returnI (Some (iterE (varE "val", ["val"], ListN (varE "k", None))))
  ]
