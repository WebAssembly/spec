open Al.Ast

let exec_expr_const =
  let instrs = IterE (NameE "instr", ["instr"], List) in
  let result = NameE "val" in

  FuncA (
    "eval_expr_const",
    [instrs],
    [
      ExecuteSeqI instrs;
      PopI result;
      ReturnI (Some (ListE [ result ]))
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
  let inverse_of_bytes_ = IterE (AppE ("inverse_of_bytes_", [storagesize; gb]), ["gb"], List) in

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

let manual_algos = [exec_expr_const; group_bytes_by; array_new_data;]
