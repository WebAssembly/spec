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

let br =
  Algo
    ( "br",
      [ (NameE (N "l"), IntT) ],
      [
        IfI
          ( CompareC (Eq, NameE (N "l"), ValueE (NumV 0L)),
            (* br_zero *)
            [
              LetI (NameE (N "L"), GetCurLabelE);
              LetI (NameE (N "n"), ArityE (NameE (N "L")));
              AssertI
                "Due to validation, there are at least n values on the top of \
                 the stack"; 
              PopI (IterE (N "val", ListN (N "n")));
              WhileI (IsTopC "value", [ PopI (NameE (N "val'")) ]);
              ExitAbruptI (N "L");
              PushI (IterE (N "val", ListN (N "n")));
              ExecuteSeqI (ContE (NameE (N "L")));
            ],
            (* br_succ *)
            [
              LetI (NameE (N "L"), GetCurLabelE);
              ExitAbruptI (N "L");
              ExecuteI
                (ConstructE ("BR", [ BinopE (Sub, NameE (N "l"), ValueE (NumV 1L)) ]));
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

let return =
  Algo
    ( "return",
      [],
      [
        PopAllI (IterE (N "val'", List));
        IfI (
          IsTopC "frame",
          (* return_frame *)
          [
            PopI (NameE (N "F"));
            LetI (NameE (N "n"), ArityE (NameE (N "F")));
            PushI (NameE (N "F"));
            PushI (IterE (N "val'", List));
            PopI (IterE (N "val", ListN (N "n")));
            ExitAbruptI (N "F");
            PushI (IterE (N "val", ListN (N "n")));
          ],
          (* return_label *)
          [
            PopI (NameE (N "L"));
            PushI (NameE (N "L"));
            PushI (IterE (N "val'", List));
            ExitAbruptI (N "L");
            ExecuteI (ConstructE ("RETURN", []));
          ] );
      ] )

let instantiation =
  (* Name definition *)
  let ignore_name = N "_" in
  let module_name = N "module" in
  let global_name = N "global" in
  let global_iter = IterE (global_name, List) in
  let data_name = N "data" in
  let data_iter = IterE (data_name, List) in
  let module_inst_init_name = SubN ((N "moduleinst"), "init") in
  let module_inst_init =
    Record.empty
    |> Record.add "FUNC" (ListE [||])
    |> Record.add "TABLE" (ListE [||]) in
  let frame_init_name = SubN ((N "f"), "init") in
  let frame_init_rec =
    Record.empty
    |> Record.add "MODULE" (NameE module_inst_init_name)
    |> Record.add "LOCAL" (ListE [||]) in
  let val_name = N "val" in
  let val_iter = IterE (val_name, List) in
  let module_inst_name = N "moduleinst" in
  let frame_name = N "f" in
  let frame_rec =
    Record.empty
    |> Record.add "MODULE" (NameE module_inst_name)
    |> Record.add "LOCAL" (ListE [||]) in
  let init = N "init" in
  let mode = N "mode" in
  let memidx = N "memidx" in
  let dinstrs = IterE (N "dinstrs", List) in
  let i32_type = ConstructV ("I32", []) in

  (* Algorithm *)
  Algo (
    "instantiation",
    [ (NameE module_name, TopT) ],
    [
      LetI (
        ConstructE (
          "MODULE",
          [
            NameE ignore_name;
            global_iter;
            NameE ignore_name;
            NameE ignore_name;
            NameE ignore_name;
            data_iter
          ]
        ),
        NameE module_name
      );
      LetI (NameE module_inst_init_name, RecordE module_inst_init);
      LetI (
        NameE frame_init_name,
        FrameE (ValueE (NumV 0L), RecordE frame_init_rec)
      );
      PushI (NameE frame_init_name);
      (* Global *)
      LetI (val_iter, MapE (N "exec_global", [NameE global_name], List));
      (* TODO: global & elements *)
      PopI (NameE frame_init_name);
      LetI (
        NameE module_inst_name,
        AppE (N "alloc_module", [NameE module_name; val_iter])
      );
      LetI (NameE frame_name, FrameE (ValueE (NumV 0L), RecordE frame_rec));
      PushI (NameE frame_name);
      (* TODO: element *)
      ForI (
        data_iter,
        [
          LetI (
            ConstructE ("DATA", [ NameE init; NameE mode ]),
            AccessE (data_iter, IndexP (NameE (N "i")))
          );
          IfI (
            IsDefinedC (NameE mode),
            [
              LetI (OptE (Some (ConstructE ("MEMORY", [ NameE memidx; dinstrs ]))), NameE mode);
              AssertI (CompareC (Eq, NameE memidx, ValueE (NumV 0L)) |> Print.string_of_cond);
              ExecuteSeqI dinstrs;
              ExecuteI (ConstructE ("CONST", [ ValueE i32_type; ValueE (NumV 0L) ]));
              ExecuteI (ConstructE ("CONST", [ ValueE i32_type; LengthE (NameE init) ]));
              ExecuteI (ConstructE ("MEMORY.INIT", [ NameE (N "i") ]));
              ExecuteI (ConstructE ("DATA.DROP", [ NameE (N "i") ]));
            ],
            []
          )
        ]
      );
      (* TODO: start *)
      PopI (NameE frame_name)
    ]
  )

let exec_global =
  (* Name definition *)
  let ignore_name = N "_" in
  let global_name = N "global" in
  let instr_iter = IterE (N "instr", List) in
  let val_name = N "val" in

  (* Algorithm *)
  Algo (
    "exec_global",
    [NameE global_name, TopT],
    [
      LetI (
        ConstructE ("GLOBAL", [ NameE ignore_name; instr_iter ]),
        NameE global_name
      );
      JumpI instr_iter;
      PopI (NameE val_name);
      ReturnI (Some (NameE val_name))
    ]
  )

let alloc_module =
  (* Name definition *)
  let ignore_name = N "_" in
  let module_name = N "module" in
  let val_name = N "val" in
  let val_iter = IterE (val_name, List) in
  let func_name = N "func" in
  let func_iter = IterE (func_name, List) in
  let table_name = N "table" in
  let table_iter = IterE (table_name, List) in
  let global_name = N "global" in
  let global_iter = IterE (global_name, List) in
  let memory_name = N "memory" in
  let memory_iter = IterE (memory_name, List) in
  let data_name = N "data" in
  let data_iter = IterE (data_name, List) in
  let funcaddr_iter = IterE (N "funcaddr", List) in
  let tableaddr_iter = IterE (N "tableaddr", List) in
  let globaladdr_iter = IterE (N "globaladdr", List) in
  let memoryaddr_iter = IterE (N "memoryaddr", List) in
  let dataaddr_iter = IterE (N "dataaddr", List) in
  let module_inst_name = N "moduleinst" in
  let module_inst_rec =
    Record.empty
    |> Record.add "FUNC" funcaddr_iter
    |> Record.add "TABLE" tableaddr_iter
    |> Record.add "GLOBAL" globaladdr_iter
    |> Record.add "MEM" memoryaddr_iter
    |> Record.add "DATA" dataaddr_iter
  in
  let store_name = N "s" in
  let func_name' = N "func'" in

  let base = AccessE (NameE (N "s"), DotP ("FUNC")) in
  let index = IndexP (NameE (N "i")) in
  let index_access = AccessE (base, index) in

  (* Algorithm *)
  Algo (
    "alloc_module",
    [ NameE module_name, TopT; val_iter, TopT ],
    [
      LetI (
        ConstructE (
          "MODULE",
          [
            func_iter;
            global_iter;
            table_iter;
            memory_iter;
            NameE ignore_name;
            data_iter;
          ]
        ),
        NameE module_name
      );
      LetI (
        funcaddr_iter,
        MapE (N "alloc_func", [ NameE func_name ], List)
      );
      LetI (
        tableaddr_iter,
        MapE (N "alloc_table", [ NameE table_name ], List)
      );
      LetI (
        globaladdr_iter,
        MapE (N "alloc_global", [ NameE val_name ], List)
      );
      LetI (
        memoryaddr_iter,
        MapE (N "alloc_memory", [ NameE memory_name ], List)
      );
      LetI (
        dataaddr_iter,
        MapE (N "alloc_data", [ NameE data_name ], List)
      );
      LetI (NameE module_inst_name, RecordE (module_inst_rec));
      (* TODO *)
      ForI (
        AccessE (NameE store_name, DotP "FUNC"),
        [
          LetI (PairE (NameE ignore_name, NameE func_name'), index_access);
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
  let dummy_module_rec =
    Record.empty
    |> Record.add "FUNC" (ListE [||])
    |> Record.add "TABLE" (ListE [||]) in
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

let alloc_global =
  (* Name definition *)
  let val_name = N "val" in
  let addr_name = N "a" in
  let store_name = N "s" in

  (* Algorithm *)
  Algo (
    "alloc_global",
    [NameE val_name, TopT],
    [
      LetI (NameE addr_name, LengthE (AccessE (NameE store_name, DotP "GLOBAL")));
      AppendI (NameE val_name, NameE store_name, "GLOBAL");
      ReturnI (Some (NameE addr_name))
    ]
  )

let alloc_table =
  (* Name definition *)
  let ignore_name = N "_" in
  let table_name = N "table" in
  let min = N "n" in
  let reftype = N "reftype" in
  let addr_name = N "a" in
  let store_name = N "s" in
  let tableinst_name = N "tableinst" in
  let ref_null = ConstructE ("REF.NULL", [NameE reftype]) in

  (* Algorithm *)
  Algo (
    "alloc_table",
    [ (NameE table_name, TopT) ],
    [
      LetI (
        ConstructE ("TABLE", [PairE (NameE min, NameE ignore_name); NameE reftype]),
        NameE table_name
      );
      LetI (NameE addr_name, LengthE (AccessE (NameE store_name, DotP "TABLE")));
      LetI (NameE tableinst_name, ListFillE (ref_null, NameE min));
      AppendI (NameE tableinst_name, NameE store_name, "TABLE");
      ReturnI (Some (NameE addr_name))
    ]
  )

let alloc_memory =
  (* Name definition *)
  let ignore_name = N "_" in
  let memory_name = N "memory" in
  let min_name = N "min" in
  let addr_name = N "a" in
  let store_name = N "s" in
  let memoryinst_name = N "memoryinst" in

  (* Algorithm *)
  Algo(
    "alloc_memory",
    [ (NameE memory_name, TopT) ],
    [
      LetI (
        ConstructE ("MEMORY", [ PairE (NameE min_name, NameE ignore_name) ]),
        NameE memory_name
      );
      LetI (NameE addr_name, LengthE (AccessE (NameE store_name, DotP "MEM")));
      LetI (
        NameE memoryinst_name,
        ListFillE (
          ValueE (NumV 0L),
          BinopE (Mul, BinopE (Mul, NameE min_name, ValueE (NumV (64L))), AppE (N "Ki", []))
        )
      );
      AppendI (NameE memoryinst_name, NameE store_name, "MEM");
      ReturnI (Some (NameE addr_name))
    ]
  )

let alloc_elem = "TODO"

let alloc_data =
  (* Name definition *)
  let ignore_name = N "_" in
  let data_name = N "data" in
  let init = N "init" in
  let addr_name = N "a" in
  let store_name = N "s" in

  (* Algorithm *)
  Algo (
    "alloc_data",
    [ (NameE data_name, TopT) ],
    [
      LetI (
        ConstructE ("DATA", [ NameE init; NameE ignore_name ]),
        NameE data_name
      );
      LetI (NameE addr_name, LengthE (AccessE (NameE store_name, DotP "DATA")));
      AppendI (NameE init, NameE store_name, "DATA");
      ReturnI (Some (NameE addr_name))
    ]
  )

let invocation =
  (* Name definition *)
  let ignore_name = N "_" in
  let args = N "val" in
  let args_iter = IterE (args, List) in
  let funcaddr_name = N "funcaddr" in
  let func_name = N "func" in
  let store_name = N "s" in
  let func_type_name = N "functype" in
  let n = N "n" in
  let m = N "m" in
  let frame_name = N "f" in
  let dummy_module_rec =
    Record.empty
    |> Record.add "FUNC" (ListE [||])
    |> Record.add "TABLE" (ListE [||]) in
  let frame_rec =
    Record.empty
    |> Record.add "LOCAL" (ListE [||])
    |> Record.add "MODULE" (RecordE dummy_module_rec) in

  (* Algorithm *)
  Algo (
    "invocation",
    [ (NameE funcaddr_name, TopT); (args_iter, TopT) ],
    [
      LetI (
        PairE (NameE ignore_name, NameE func_name),
        AccessE (AccessE (NameE store_name, DotP "FUNC"), IndexP (NameE funcaddr_name))
      );
      LetI (
        ConstructE ("FUNC", [NameE func_type_name; NameE ignore_name; NameE ignore_name]),
        NameE func_name
      );
      LetI (
        ArrowE (IterE (ignore_name, ListN n), IterE (ignore_name, ListN m)),
        NameE func_type_name
      );
      AssertI (CompareC (Eq, LengthE args_iter, NameE n) |> Print.string_of_cond);
      (* TODO *)
      LetI (NameE frame_name, FrameE (ValueE (NumV 0L), RecordE frame_rec));
      PushI (NameE frame_name);
      PushI (args_iter);
      ExecuteI (ConstructE ("CALL_ADDR", [NameE funcaddr_name]));
      PopI (IterE (SubN (N "val", "res"), ListN m));
      PopI (NameE frame_name);
      ReturnI (Some (IterE (SubN (N "val", "res"), ListN m)))
    ]
  )


let manual_algos =
  [
    br;
    return;
    instantiation;
    exec_global;
    alloc_module;
    alloc_func;
    alloc_global;
    alloc_table;
    alloc_memory;
    alloc_data;
    invocation
  ]
