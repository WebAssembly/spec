open Al.Ast
open Construct
open Util.Record

let eval_expr =
  let instrs = IterE (VarE "instr", ["instr"], List) in
  let result = VarE "val" in

  FuncA (
    "eval_expr",
    [instrs],
    [
      executeseqI instrs;
      popI result;
      returnI (Some (ListE [ result ]))
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
  let name x = VarE x in
  let x = name "x" in
  let ref = name "ref" in
  let a = name "a" in
  let fi = name "fi" in
  let y0 = name "y_0" in
  let y1 = name "y_1" in
  let t = name "t" in
  let t1 = name "t_1" in
  let t2 = name "t_2" in
  let n = name "n" in
  let m = name "m" in
  let v = name "val" in
  let f = name "f" in
  let ff = name "F" in
  let ll = name "L" in
  let instr = name "instr" in

  RuleA (
    ("CALL_REF", "admininstr"),
    [ x ],
    [
      assertI (TopValueC None);
      popI ref;
      ifI (
        IsCaseOfC (ref, ("REF.NULL", "admininstr")),
        [ trapI ],
        []
      );
      assertI (IsCaseOfC (ref, ("REF.FUNC_ADDR", "admininstr")));
      letI (CaseE (("REF.FUNC_ADDR", "admininstr"), [a]), ref);
      ifI (
        CmpC (LtOp, a, LenE (CallE ("funcinst", []))),
        [
        letI (fi, AccE (CallE ("funcinst", []), IdxP a));
        ifI (
          IsCaseOfC (AccE (fi, DotP("CODE", "code")), ("FUNC", "func")),
          [
          letI (CaseE (("FUNC", "func"), [y0 ; y1 ; IterE (instr, ["instr"], List)]), AccE (fi, DotP ("CODE", "code")));
          letI (IterE (CaseE (("LOCAL","local"), [t]), ["t"], List), y1);
          ifI (
            IsCaseOfC (CallE ("expanddt", [ AccE (fi, DotP ("TYPE", "type")) ]), ("FUNC", "comptype")),
            [
            letI (CaseE (("FUNC", "comptype"), [y0]), CallE ("expanddt", [ AccE (fi, DotP ("TYPE", "type")) ]));
            letI (ArrowE (IterE (t1, ["t_1"], ListN (n, None)), IterE (t2, ["t_2"], ListN (m, None))), y0);
            assertI (TopValuesC n);
            popI (IterE (v, ["val"], ListN(n, None)));
            letI (f, StrE (Record.empty
              |> Record.add
                ("LOCAL", "frame")
                (CatE (IterE (OptE (Some v), ["val"], ListN (n, None)), IterE (CallE("default", [t]), ["t"], List)))
              |> Record.add
                ("MODULE", "frame")
                (AccE (fi, DotP ("MODULE", "module")))
            ));
            letI (ff, FrameE (Some m, f));
            enterI (ff, ListE ([CaseE (("FRAME_", ""), [])]),
              [
              letI (ll, LabelE (m, ListE []));
              enterI (ll, CatE (IterE (instr, ["instr"], List), ListE ([CaseE (("LABEL_", ""), [])])), []);
              ]
            );
            ], []);
          ], []);
        ], []);
      ]
    )

(* Helper for the manual array_new.data algorithm *)

let group_bytes_by =
  let n = VarE "n" in
  let n' = VarE "n'" in

  let bytes_ = IterE (VarE "byte", ["byte"], List) in
  let bytes_left = ListE [AccE (bytes_, SliceP (NumE 0L, n))] in
  let bytes_right = CallE 
    (
      "group_bytes_by", 
      [ n; AccE (bytes_, SliceP (n, BinE (SubOp, n', n))) ]
    ) 
  in

  FuncA (
    "group_bytes_by",
    [n; bytes_],
    [
      letI (n', LenE bytes_);
      ifI (
        CmpC (GeOp, n', n),
        [ returnI (Some (CatE (bytes_left, bytes_right))) ],
        []
      );
      returnI (Some (ListE []));
    ]
  )

let array_new_data =
  let i32 = CaseE (("I32", "numtype"), []) in

  let x = VarE "x" in
  let y = VarE "y" in

  let n = VarE "n" in
  let i = VarE "i" in

  let y_0 = VarE "y_0" in
  let mut = VarE "mut" in
  let zt = VarE "zt" in

  let nt = VarE "nt" in

  let c = VarE "c" in

  let bstar = IterE (VarE "b", ["b"], List) in
  let gb = VarE "gb" in
  let gbstar = IterE (gb, ["gb"], List) in
  let cn = IterE (c, ["c"], ListN (n, None)) in

  let expanddt_with_type = CallE ("expanddt", [CallE ("type", [x])]) in
  let storagesize = CallE ("storagesize", [zt]) in
  let unpacknumtype = CallE ("unpacknumtype", [zt]) in
  (* include z or not ??? *)
  let data = CallE ("data", [y]) in
  let group_bytes_by = CallE ("group_bytes_by", [BinE (DivOp, storagesize, NumE 8L); bstar]) in
  let inverse_of_bytes_ = IterE (CallE ("inverse_of_ibytes", [storagesize; gb]), ["gb"], List) in

  RuleA (
    ("ARRAY.NEW_DATA", "admininstr"),
    [x; y],
    [
      assertI (TopValueC (Some i32));
      popI (CaseE (("CONST", "admininstr"), [i32; n]));
      assertI (TopValueC (Some i32));
      popI (CaseE (("CONST", "admininstr"), [i32; i]));
      ifI (
        IsCaseOfC (expanddt_with_type, ("ARRAY", "comptype")),
        [
          letI (CaseE (("ARRAY", "comptype"), [y_0]), expanddt_with_type);
          letI (TupE [ mut; zt ], y_0);
          ifI (
            CmpC (
              GtOp,
              BinE (AddOp, i, BinE (DivOp, BinE (MulOp, n, storagesize), NumE 8L)),
              LenE (AccE (CallE ("data", [y]), DotP ("DATA", "datainst")))
            ),
            [trapI],
            []
          );
          letI (nt, unpacknumtype);
          letI (
            bstar, 
            AccE (
              AccE (data, DotP ("DATA", "datainst")),
              SliceP (i, BinE (DivOp, BinE (MulOp, n, storagesize), NumE 8L))
            )
          );
          letI (gbstar, group_bytes_by);
          letI (cn, inverse_of_bytes_);
          pushI (IterE (CaseE (("CONST", "admininstr"), [nt; c]), ["c"], ListN (n, None)));
          executeI (CaseE (("ARRAY.NEW_FIXED", "admininstr"), [x; n]));
        ],
        []
      );
    ]
  )

let manual_algos = [eval_expr; call_ref; group_bytes_by; array_new_data;]
