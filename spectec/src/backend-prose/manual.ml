open Al

(** Hardcoded algorithms **)

(* br *)
(* Modified DSL
  rule Step_pure/br-zero:
  ( LABEL_ n `{instr'*} val'* val^n (BR l) instr* )  ~>  val^n instr'*
  -- if l = 0
  rule Step_pure/br-succ:
  ( LABEL_ n `{instr'*} val* (BR l)) instr* )  ~>  val* (BR $(l-1))
  -- otherwise
  Note that we can safely ignore the trailing instr* because
  our Al interpreter keeps track of the point of interpretation.
*)
(* Prose
  br l
  1. If l is 0, then:
    a. Let L be the current label.
    b. Let n be the arity of L.
    c. Assert: Due to validation, there are at least n values on the top of the stack.
    d. Pop val^n from the stack.
    e. Pop val'* from the stack.
    f. Assert: Due to validation, the label L is now on the top of the stack.
    g. Pop the label from the stack.
    h. Push val^n to the stack.
    i. Jump to the continuation of L.
    j. Exit
  2. Else:
    a. Pop val* from the stack.
    b. Assert: Due to validation, the label L is now on the top of the stack.
    c. Pop the label from the stack.
    d. Push val* to the stack.
    e. Execute (br (l - 1)).
*)

let br = 
  let br_cond = EqC (NameE (N "l"), ValueE (IntV 0)) in
  let br_zero = [ 
    LetI (NameE (N "L"), GetCurLabelE);
    LetI (NameE (N "n"), ArityE (NameE (N "L")));
    AssertI "Due to validation, there are at least n values on the top of the stack";
    PopI (IterE (N "val", ListN (N "n")));
    PopI (IterE (N "val'", List));
    AssertI "Due to validation, the label L is now on the top of the stack";
    PopI (NameE (N "the label"));
    PushI (IterE (N "val", ListN (N "n")));
    JumpI (ContE (NameE (N "L")));
    ExitI (N "L")
  ]
  in
  let br_succ = [
    PopI (IterE (N "val", List));
    AssertI "Due to validation, the label L is now on the top of the stack";
    PopI (NameE (N "the label"));
    PushI (IterE (N "val", List));
    ExecuteI (WasmInstrE ("br", [ SubE (NameE (N "L"), ValueE (IntV 1)) ]))
  ]
  in
  let if_instr = IfI (br_cond, br_zero, br_succ) in
  Algo ("br", [ (NameE (N "l"), IntT) ], [ if_instr ])

let manual_algos = [ br ]
