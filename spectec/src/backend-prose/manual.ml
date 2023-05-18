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
       e. While the top of the stack is value, do:
         1) Pop val' from the stack.
       f. Assert: Due to validation, the label L is now on the top of the stack.
       g. Pop the label from the stack.
       h. Push val^n to the stack.
       i. Jump to the continuation of L.
     2. Else:
       a. Pop all values val* from the stack.
       b. Assert: Due to validation, the label L is now on the top of the stack.
       c. Pop the label from the stack.
       d. Push val* to the stack.
       e. Execute (br (l - 1)).
*)

let br =
  Algo
    ( "br",
      [ (NameE (N "l"), IntT) ],
      [
        IfI
          ( EqC (NameE (N "l"), ValueE (IntV 0)),
            (* br_zero *)
            [
              LetI (NameE (N "L"), GetCurLabelE);
              LetI (NameE (N "n"), ArityE (NameE (N "L")));
              AssertI
                "Due to validation, there are at least n values on the top of \
                 the stack";
              PopI (IterE (N "val", ListN (N "n")));
              WhileI (TopC "value", [ PopI (NameE (N "val'")) ]);
              AssertI
                "Due to validation, the label L is now on the top of the stack";
              PopI (NameE (N "the label"));
              PushI (IterE (N "val", ListN (N "n")));
              JumpI (ContE (NameE (N "L")));
            ],
            (* br_succ *)
            [
              PopAllI (IterE (N "val", List));
              AssertI
                "Due to validation, the label L is now on the top of the stack";
              PopI (NameE (N "the label"));
              PushI (IterE (N "val", List));
              ExecuteI
                (WasmInstrE ("br", [ SubE (NameE (N "l"), ValueE (IntV 1)) ]));
            ] );
      ] )

(* return *)
(* DSL
  rule Step_pure/return-frame:
  ( FRAME_ n `{f} val'* val^n RETURN instr* )  ~>  val^n
  rule Step_pure/return-label:
  ( LABEL_ k `{instr'*} val* RETURN instr* )  ~>  val* RETURN
  Note that WASM validation step (in the formal spec using evaluation context) 
  assures that there are 
  at least n values on the top of the stack before return.
*)
(* Prose
   return
    1. Let F be the current frame.
    2. Let n be the arity of F.
    3. Assert: Due to validation, there are at least n values on the top of the stack.
    4. Pop val^n from the stack.
    5. Assert: Due to validation, the stack contains at least one frame.
    6. While not the top of the stack is frame, do:
      a. Pop the top element from the stack.
    7. Assert: The top of the stack is the frame F.
    8. Pop the frame from the stack.
    9. Push val^n to the stack.
*)

let return =
  Algo
    ( "return",
      [],
      [
        LetI (NameE (N "F"), GetCurFrameE);
        LetI (NameE (N "n"), ArityE (NameE (N "F")));
        AssertI
          "Due to validation, there are at least n values on the top of the stack";
        PopI (IterE (N "val", ListN (N "n")));
        AssertI
          "Due to validation, the stack contains at least one frame";
        WhileI (NotC (TopC "frame"), [ PopI (NameE (N "the top element")) ]);
        AssertI "The top of the stack is the frame F";
        PopI (NameE (N "the frame"));
        PushI (IterE (N "val", ListN (N "n")));
      ] )

let instantiation =
  (* Name definition *)
  let module_name = N "module" in
  let module_inst_init_name = SubN ((N "moduleinst"), "init") in
  let module_inst_init = Record.add "FUNC" (ListV [||]) Record.empty in
  let frame_init_name = SubN ((N "f"), "init") in
  let frame_init_rec =
    Record.empty
    |> Record.add "MODULE" (NameE module_inst_init_name)
    |> Record.add "LOCAL" (ListE [||]) in
  let module_inst_name = N "moduleinst" in
  let frame_name = N "f" in
  let frame_rec =
    Record.empty
    |> Record.add "MODULE" (NameE module_inst_name)
    |> Record.add "LOCAL" (ListE [||]) in

  (* Algorithm *)
  Algo (
    "instantiation",
    [ (NameE module_name, TopT) ],
    [
      LetI (NameE module_inst_init_name, ValueE (ModuleInstV module_inst_init));
      LetI (
        NameE frame_init_name,
        FrameE (ValueE (IntV 0), RecordE frame_init_rec)
      );
      PushI (NameE frame_init_name);
      (* TODO: global & elements *)
      PopI (NameE frame_init_name);
      LetI (
        NameE module_inst_name,
        AppE (N "alloc_module", [NameE module_name])
      );
      LetI (NameE frame_name, FrameE (ValueE (IntV 0), RecordE frame_rec));
      PushI (NameE frame_name);
      (* TODO: element & data & start *)
      PopI (NameE frame_name)
    ]
  )

let alloc_module =
  (* Name definition *)
  let module_name = N "module" in
  let func_name = N "func" in
  let func_iter = IterE (func_name, List) in
  let table_name = N "table" in
  let table_iter = IterE (table_name, List) in
  let funcaddr_iter = IterE (N "funcaddr", List) in
  let tableaddr_iter = IterE (N "tableaddr", List) in
  let module_inst_name = N "moduleinst" in
  let module_inst_rec = Record.add "FUNC" funcaddr_iter Record.empty in
  let store_name = N "s" in
  let func_name' = N "func'" in

  let base = AccessE (NameE (N "s"), DotP ("FUNC")) in
  let index = IndexP (NameE (N "i")) in
  let index_access = AccessE (base, index) in

  (* Algorithm *)
  Algo (
    "alloc_module",
    [ (NameE module_name, TopT) ],
    [
      LetI (ConstructE ("MODULE", [ func_iter; table_iter ]), NameE module_name);
      LetI (
        funcaddr_iter,
        (* dummy module instance *)
        MapE (N "alloc_func", [ NameE func_name ], List)
      );
      LetI (
        tableaddr_iter,
        MapE (N "alloc_table", [ NameE table_name ], List)
      );
      LetI (NameE module_inst_name, RecordE (module_inst_rec));
      (* TODO *)
      ForI (
        AccessE (NameE store_name, DotP "FUNC"),
        [
          LetI (PairE (NameE (N "_"), NameE func_name'), index_access);
          ReplaceI (base, index, PairE (NameE module_inst_name, NameE func_name'))
        ]
      );
      ReturnI (Some (NameE module_inst_name))
    ]
  )

let alloc_func =
  (* Name definition *)
  let func_name = N "func" in
  let addr_name = N "a" in
  let store_name = N "s" in
  let dummy_module_inst = N "dummy_module_inst" in
  let dummy_module_rec = Record.add "FUNC" (ListE [||]) Record.empty in
  let func_inst_name = N "funcinst" in

  (* Algorithm *)
  Algo (
    "alloc_func",
    [ (NameE func_name, TopT) ],
    [
      LetI (NameE addr_name, LengthE (AccessE (NameE store_name, DotP "FUNC")));
      LetI (NameE dummy_module_inst, RecordE dummy_module_rec);
      LetI (NameE func_inst_name, PairE (NameE dummy_module_inst, NameE func_name));
      AppendI (NameE func_inst_name, NameE store_name, "FUNC");
      ReturnI (Some (NameE addr_name))
    ]
  )

let alloc_table =
  (* Name definition *)
  let table_name = N "table" in

  (* Algorithm *)
  Algo (
    "alloc_table",
    [ (NameE table_name, TopT) ],
    [
    ]
  )

let invocation =
  (* Name definition *)
  let funcaddr_name = N "funcaddr" in
  let func_inst_name = N "funcinst" in
  let store_name = N "s" in
  let frame_name = N "f" in
  let dummy_module_rec = Record.add "FUNC" (ListE [||]) Record.empty in
  let frame_rec =
    Record.empty
    |> Record.add "LOCAL" (ListE [||])
    |> Record.add "MODULE" (RecordE dummy_module_rec) in

  (* Algorithm *)
  Algo (
    "invocation",
    [ (NameE funcaddr_name, TopT) ],
    [
      LetI (
        NameE func_inst_name,
        AccessE (AccessE (NameE store_name, DotP "FUNC"), IndexP (NameE funcaddr_name))
      );
      (* TODO *)
      LetI (NameE frame_name, FrameE (ValueE (IntV 0), RecordE frame_rec));
      PushI (NameE frame_name);
      ExecuteI (WasmInstrE ("call_addr", [NameE funcaddr_name]))
    ]
  )


let manual_algos = [ br; return; instantiation; alloc_module; alloc_func; alloc_table; invocation ]
