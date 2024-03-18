open Al
open Ast
open Al_util
open Util

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

(*
execution_of_CALL_REF ?(x)
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop u_0 from the stack.
3. If u_0 is of the case REF.NULL, then:
  a. Trap.
4. Assert: u_0 is of the case REF.FUNC_ADDR;
4. Let (REF.FUNC_ADDR a) be u_0.
5. If a < |$funcinst()|, then:
  a. Let fi be $funcinst()[a].
  b. Assert: fi.CODE is of the case FUNC;
  1) Let (FUNC x' y_1 instr* ) be fi.CODE.
  2) Let (LOCAL t)* be y_1.
  3) Assert: $expanddt(fi.TYPE) is of the case FUNC;
  a) Let (FUNC y_0) be $expanddt(fi.TYPE).
  b) Let [t_1^n]->[t_2^m] be y_0.
  c) Assert: Due to validation, there are at least n values on the top of the stack.
  d) Pop val^n from the stack.
  e) Let f be { LOCAL: ?(val)^n ++ $default_(t)*; MODULE: fi.MODULE; }.
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
    atom_of_name "CALL_REF" "admininstr",
    [ x ],
    [
      assertI (topValueE None);
      popI ref;
      ifI (
        isCaseOfE (ref, atom_of_name "REF.NULL" "admininstr"),
        [ trapI () ],
        []
      );
      assertI (isCaseOfE (ref, atom_of_name "REF.FUNC_ADDR" "admininstr"));
      letI (caseE (atom_of_name "REF.FUNC_ADDR" "admininstr", [a]), ref);
      ifI (
        binE (LtOp, a, lenE (callE ("funcinst", []))),
        [ letI (fi, accE (callE ("funcinst", []), idxP a));
          assertI (isCaseOfE (accE (fi, dotP (atom_of_name "CODE" "code")), atom_of_name "FUNC" "func"));
          letI (caseE (atom_of_name "FUNC" "func", [y0 ; y1 ; iterE (instr, ["instr"], List)]), accE (fi, dotP (atom_of_name "CODE" "code")));
          letI (iterE (caseE (atom_of_name "LOCAL" "local", [t]), ["t"], List), y1);
          assertI (isCaseOfE (callE ("expanddt", [ accE (fi, dotP (atom_of_name "TYPE" "type")) ]), atom_of_name "FUNC" "comptype"));
          letI (caseE (atom_of_name "FUNC" "comptype", [y0]), callE ("expanddt", [ accE (fi, dotP (atom_of_name "TYPE" "type")) ]));
          letI (infixE (iterE (t1, ["t_1"], ListN (n, None)), (Il.Atom.Arrow, ""), iterE (t2, ["t_2"], ListN (m, None))), y0);
          assertI (topValuesE n);
          popI (iterE (v, ["val"], ListN(n, None)));
          letI (f, strE (Record.empty
            |> Record.add
              (atom_of_name "LOCAL" "frame")
              (catE (iterE (optE (Some v), ["val"], ListN (n, None)), iterE (callE("default_", [t]), ["t"], List)))
            |> Record.add
              (atom_of_name "MODULE" "frame")
              (accE (fi, dotP (atom_of_name "MODULE" "module")))
          ));
          letI (ff, frameE (Some m, f));
          enterI (ff, listE ([caseE (atom_of_name "FRAME_" "admininstr", [])]),
            [
            letI (ll, labelE (m, listE []));
            enterI (ll, catE (iterE (instr, ["instr"], List), listE ([caseE (atom_of_name "LABEL_" "admininstr", [])])), []);
            ]
          );
        ], []);
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

  let expanddt_with_type = callE ("expanddt", [callE ("type", [x])]) in
  let zsize = callE ("zsize", [zt]) in
  let cunpack = callE ("cunpack", [zt]) in
  (* include z or not ??? *)
  let data = callE ("data", [y]) in
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
              lenE (accE (callE ("data", [y]), dotP (atom_of_name "DATA" "datainst")))
            ),
            [ trapI () ],
            []
          );
          letI (cnn, cunpack);
          letI (
            bstar,
            accE (
              accE (data, dotP (atom_of_name "DATA" "datainst")),
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

let manual_algos = [eval_expr; call_ref; group_bytes_by; array_new_data;]

let return_instrs_of_instantiate config =
  let store, frame, rhs = config in
  [
    enterI (
      frameE (Some (numE Z.zero), frame),
      listE ([ caseE (atom_of_name "FRAME_" "admininstr", []) ]), rhs
    );
    returnI (Some (tupE [ store; varE "mm" ]))
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

let ref_type_of =
  (* TODO: some / none *)
  let null = caseV ("NULL", [ optV (Some (listV [||])) ]) in
  let nonull = caseV ("NULL", [ optV None ]) in
  let none = nullary "NONE" in
  let nofunc = nullary "NOFUNC" in
  let noextern = nullary "NOEXTERN" in

  let match_heap_type v1 v2 =
    let open Reference_interpreter in
    let ht1 = Construct.al_to_heap_type v1 in
    let ht2 = Construct.al_to_heap_type v2 in
    Match.match_ref_type [] (Types.Null, ht1) (Types.Null, ht2)
  in

  function
  (* null *)
  | [CaseV ("REF.NULL", [ ht ]) as v] ->
    if match_heap_type none ht then
      CaseV ("REF", [ null; none])
    else if match_heap_type nofunc ht then
      CaseV ("REF", [ null; nofunc])
    else if match_heap_type noextern ht then
      CaseV ("REF", [ null; noextern])
    else
      v
      |> Print.string_of_value
      |> Printf.sprintf "Invalid null reference: %s"
      |> failwith
  (* i31 *)
  | [CaseV ("REF.I31_NUM", [ _ ])] -> CaseV ("REF", [ nonull; nullary "I31"])
  (* host *)
  | [CaseV ("REF.HOST_ADDR", [ _ ])] -> CaseV ("REF", [ nonull; nullary "ANY"])
  (* array/func/struct addr *)
  | [CaseV (name, [ NumV i ])]
  when String.starts_with ~prefix:"REF." name && String.ends_with ~suffix:"_ADDR" name ->
    let field_name = String.sub name 4 (String.length name - 9) in
    let object_ = listv_nth (Ds.Store.access field_name) (Z.to_int i) in
    let dt = strv_access "TYPE" object_ in
    CaseV ("REF", [ nonull; dt])
  (* extern *)
  (* TODO: check null *)
  | [CaseV ("REF.EXTERN", [ _ ])] -> CaseV ("REF", [ nonull; nullary "EXTERN"])
  | _ -> failwith "Invalid arguments for $ref_type_of"
