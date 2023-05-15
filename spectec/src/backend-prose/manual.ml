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
       a. Let val* be [].
       b. While the top of the stack is value, do:
         1) Pop val' from the stack.
         2) Let val* be [val'] ++ val*.
       c. Assert: Due to validation, the label L is now on the top of the stack.
       d. Pop the label from the stack.
       e. Push val* to the stack.
       f. Execute (br (l - 1)).
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
              (* A temporary hack to bind the popped values to val^*,
                 in a while loop, it pops a value, binds it to val',
                 then appends it to val^* *)
              LetI (IterE (N "val", List), ValueE (ListV [||]));
              WhileI
                ( TopC "value",
                  [
                    PopI (NameE (N "val'"));
                    LetI
                      ( IterE (N "val", List),
                        ConcatE
                          (ListE [| NameE (N "val'") |], IterE (N "val", List))
                      );
                  ] );
              AssertI
                "Due to validation, the label L is now on the top of the stack";
              PopI (NameE (N "the label"));
              PushI (IterE (N "val", List));
              ExecuteI
                (WasmInstrE ("br", [ SubE (NameE (N "l"), ValueE (IntV 1)) ]));
            ] );
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
  let funcaddr_iter = IterE (N "funcaddr", List) in
  let module_inst_name = N "moduleinst" in
  let module_inst_rec = Record.add "FUNC" funcaddr_iter Record.empty in

  (* Algorithm *)
  Algo (
    "alloc_module",
    [ (NameE module_name, TopT) ],
    [
      LetI (ConstructE ("MODULE", [func_iter]), NameE module_name);
      LetI (
        funcaddr_iter,
        (* dummy module instance *)
        MapE (N "alloc_func", [ NameE func_name ], List)
      );
      LetI (NameE module_inst_name, RecordE (module_inst_rec));
      ReturnI (Some (NameE module_inst_name))
    ]
  )

let manual_algos = [ br; instantiation; alloc_module ]
