open Al.Ast

let eval_expr =
  let instrs = IterE (NameE "instr", ["instr"], List) in
  let result = NameE "val" in

  FuncA (
    "eval_expr",
    [instrs],
    [
      ExecuteSeqI instrs;
      PopI result;
      ReturnI (Some (ListE [ result ]))
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
  let name x = NameE x in
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
      AssertI (TopValueC None);
      PopI ref;
      IfI (
        IsCaseOfC (ref, ("REF.NULL", "admininstr")),
        [ TrapI ],
        []
      );
      AssertI (IsCaseOfC (ref, ("REF.FUNC_ADDR", "admininstr")));
      LetI (ConstructE (("REF.FUNC_ADDR", "admininstr"), [a]), ref);
      IfI (
        CompareC (Lt, a, LengthE (AppE ("funcinst", []))),
        [
        LetI (fi, AccessE (AppE ("funcinst", []), IndexP(a)));
        IfI (
          IsCaseOfC (AccessE (fi, DotP("CODE", "code")), ("FUNC", "func")),
          [
          LetI (ConstructE (("FUNC", "func"), [y0 ; y1 ; IterE (instr, ["instr"], List)]), AccessE (fi, DotP ("CODE", "code")));
          LetI (IterE (ConstructE (("LOCAL","local"), [t]), ["t"], List), y1);
          IfI (
            IsCaseOfC (AppE ("expanddt", [ AccessE (fi, DotP ("TYPE", "type")) ]), ("FUNC", "comptype")),
            [
            LetI (ConstructE (("FUNC", "comptype"), [y0]), AppE ("expanddt", [ AccessE (fi, DotP ("TYPE", "type")) ]));
            LetI (ArrowE (IterE (t1, ["t_1"], ListN (n, None)), IterE (t2, ["t_2"], ListN (m, None))), y0);
            AssertI (TopValuesC n);
            PopI (IterE (v, ["val"], ListN(n, None)));
            LetI (f, RecordE (Record.empty
              |> Record.add
                ("LOCAL", "frame")
                (ConcatE (IterE (OptE (Some v), ["val"], ListN (n, None)), IterE (AppE("default", [t]), ["t"], List)))
              |> Record.add
                ("MODULE", "frame")
                (AccessE (fi, DotP ("MODULE", "module")))
            ));
            LetI (ff, FrameE (Some m, f));
            EnterI (ff, ListE ([ConstructE (("FRAME_", ""), [])]),
              [
              LetI (ll, LabelE (m, ListE []));
              EnterI (ll, ConcatE (IterE (instr, ["instr"], List), ListE ([ConstructE (("LABEL_", ""), [])])), []);
              ]
            );
            ], []);
          ], []);
        ], []);
      ]
    )

(* Helper for the manual array_new.data algorithm *)

let group_bytes_by =
  let n = NameE "n" in
  let n' = NameE "n'" in

  let bytes_ = IterE (NameE "byte", ["byte"], List) in
  let bytes_left = ListE [AccessE (bytes_, SliceP (NumE 0L, n))] in
  let bytes_right = AppE 
    (
      "group_bytes_by", 
      [ n; AccessE (bytes_, SliceP (n, BinopE (Sub, n', n))) ]
    ) 
  in

  FuncA (
    "group_bytes_by",
    [n; bytes_],
    [
      LetI (n', LengthE bytes_);
      IfI (
        CompareC (Ge, n', n),
        [ ReturnI (Some (ConcatE (bytes_left, bytes_right))) ],
        []
      );
      ReturnI (Some (ListE []));
    ]
  )

let array_new_data =
  let i32 = ConstructE (("I32", "numtype"), []) in

  let x = NameE "x" in
  let y = NameE "y" in

  let n = NameE "n" in
  let i = NameE "i" in

  let y_0 = NameE "y_0" in
  let mut = NameE "mut" in
  let zt = NameE "zt" in

  let nt = NameE "nt" in

  let c = NameE "c" in

  let bstar = IterE (NameE "b", ["b"], List) in
  let gb = NameE "gb" in
  let gbstar = IterE (gb, ["gb"], List) in
  let cn = IterE (c, ["c"], ListN (n, None)) in

  let expanddt_with_type = AppE ("expanddt", [AppE ("type", [x])]) in
  let storagesize = AppE ("storagesize", [zt]) in
  let unpacknumtype = AppE ("unpacknumtype", [zt]) in
  (* include z or not ??? *)
  let data = AppE ("data", [y]) in
  let group_bytes_by = AppE ("group_bytes_by", [BinopE (Div, storagesize, NumE 8L); bstar]) in
  let inverse_of_bytes_ = IterE (AppE ("inverse_of_ibytes", [storagesize; gb]), ["gb"], List) in

  RuleA (
    ("ARRAY.NEW_DATA", "admininstr"),
    [x; y],
    [
      AssertI (TopValueC (Some i32));
      PopI (ConstructE (("CONST", "admininstr"), [i32; n]));
      AssertI (TopValueC (Some i32));
      PopI (ConstructE (("CONST", "admininstr"), [i32; i]));
      IfI (
        IsCaseOfC (expanddt_with_type, ("ARRAY", "comptype")),
        [
          LetI (ConstructE (("ARRAY", "comptype"), [y_0]), expanddt_with_type);
          LetI (PairE (mut, zt), y_0);
          IfI (
            CompareC (
              Gt,
              BinopE (Add, i, BinopE (Div, BinopE (Mul, n, storagesize), NumE 8L)),
              LengthE (AccessE (AppE ("data", [y]), DotP ("DATA", "datainst")))
            ),
            [TrapI],
            []
          );
          LetI (nt, unpacknumtype);
          LetI (
            bstar, 
            AccessE (
              AccessE (data, DotP ("DATA", "datainst")),
              SliceP (i, BinopE (Div, BinopE (Mul, n, storagesize), NumE 8L))
            )
          );
          LetI (gbstar, group_bytes_by);
          LetI (cn, inverse_of_bytes_);
          PushI (IterE (ConstructE (("CONST", "admininstr"), [nt; c]), ["c"], ListN (n, None)));
          ExecuteI (ConstructE (("ARRAY.NEW_FIXED", "admininstr"), [x; n]));
        ],
        []
      );
    ]
  )

let manual_algos = [eval_expr; call_ref; group_bytes_by; array_new_data;]
