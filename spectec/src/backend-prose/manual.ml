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
    ( "execution_of_br",
      [ (NameE (N "l", []), IntT) ],
      [
        IfI
          ( CompareC (Eq, NameE (N "l", []), NumE 0L),
            (* br_zero *)
            [
              LetI (NameE (N "L", []), GetCurLabelE);
              LetI (NameE (N "n", []), ArityE (NameE (N "L", [])));
              AssertI
                "Due to validation, there are at least n values on the top of \
                 the stack";
              PopI (NameE (N "val", [ListN (N "n")]));
              WhileI (IsTopC "value", [ PopI (NameE (N "val'", [])) ]);
              ExitAbruptI (N "L");
              PushI (NameE (N "val", [ListN (N "n")]));
              ExecuteSeqI (ContE (NameE (N "L", [])));
            ],
            (* br_succ *)
            [
              LetI (NameE (N "L", []), GetCurLabelE);
              ExitAbruptI (N "L");
              ExecuteI
                (ConstructE ("BR", [ BinopE (Sub, NameE (N "l", []), NumE 1L) ]));
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
    ( "execution_of_return",
      [],
      [
        PopAllI (NameE (N "val'", [List]));
        IfI (
          IsTopC "frame",
          (* return_frame *)
          [
            PopI (NameE (N "F", []));
            LetI (NameE (N "n", []), ArityE (NameE (N "F", [])));
            PushI (NameE (N "F", []));
            PushI (NameE (N "val'", [List]));
            PopI (NameE (N "val", [ListN (N "n")]));
            ExitAbruptI (N "F");
            PushI (NameE (N "val", [ListN (N "n")]));
          ],
          (* return_label *)
          [
            PopI (NameE (N "L", []));
            PushI (NameE (N "L", []));
            PushI (NameE (N "val'", [List]));
            ExitAbruptI (N "L");
            ExecuteI (ConstructE ("RETURN", []));
          ] );
      ] )

(* Module Semantics *)

let instantiation =
  (* Name definition *)
  let ignore_name = NameE (N "_", []) in
  let module_ = NameE (N "module", []) in
  let externval = NameE (N "externval", [ List ]) in
  let module_inst = NameE (N "moduleinst", []) in
  let frame_name = NameE (N "f", []) in
  let frame_rec =
    Record.empty
    |> Record.add "MODULE" module_inst
    |> Record.add "LOCAL" (ListE []) in
  let elem = NameE (N "elem", [List]) in
  let data = NameE (N "data", [List]) in
  let start = NameE (N "start", [Opt]) in
  let mode_opt = NameE (N "mode_opt", []) in
  let mode = NameE (N "mode", []) in
  let einit = NameE (N "einit", []) in
  let dinit = NameE (N "dinit", []) in
  let idx = NameE (N "i", []) in
  let tableidx = NameE (N "tableidx", []) in
  let memidx = NameE (N "memidx", []) in
  let einstrs = NameE (N "einstrs", [List]) in
  let dinstrs = NameE (N "dinstrs", [List]) in
  let start_idx = NameE (N "start_idx", []) in
  let i32_type = ConstructE ("I32", []) in

  (* Algorithm *)
  Algo (
    "instantiation",
    [ module_, TopT; externval, TopT ],
    [
      LetI (
        ConstructE (
          "MODULE",
          [ ignore_name; ignore_name; ignore_name; ignore_name; ignore_name; elem; data; start; ignore_name ]
        ),
        module_
      );
      LetI (module_inst, AppE (N "alloc_module", [ module_; externval ]));
      LetI (frame_name, FrameE (NumE 0L, RecordE frame_rec));
      PushI frame_name;
      (* Element *)
      ForI (
        elem,
        [
          LetI (ConstructE ("ELEM", [ ignore_name; einit; mode_opt ]), AccessE (elem, IndexP idx));
          IfI (
            IsDefinedC mode_opt,
            [
              LetI (OptE (Some (mode)), mode_opt);
              (* Active Element *)
              IfI (
                IsCaseOfC (mode, "TABLE"),
                [
                  LetI (ConstructE ("TABLE", [ tableidx; einstrs ]), mode);
                  ExecuteSeqI einstrs;
                  ExecuteI (ConstructE ("CONST", [ i32_type; NumE 0L ]));
                  ExecuteI (ConstructE ("CONST", [ i32_type; LengthE einit ]));
                  ExecuteI (ConstructE ("TABLE.INIT", [ tableidx; idx ]));
                  ExecuteI (ConstructE ("ELEM.DROP", [ idx ]));
                ],
                []
              );
              (* Declarative Element *)
              IfI (
                IsCaseOfC (mode, "DECLARE"),
                [ ExecuteI (ConstructE ("ELEM.DROP", [ idx ])); ],
                []
              )
            ],
            []
          )
        ]
      );
      (* Active Data *)
      ForI (
        data,
        [
          LetI (ConstructE ("DATA", [ dinit; mode ]), AccessE (data, IndexP idx));
          IfI (
            IsDefinedC mode,
            [
              LetI (OptE (Some (ConstructE ("MEMORY", [ memidx; dinstrs ]))), mode);
              AssertI (CompareC (Eq, memidx, NumE 0L) |> Print.string_of_cond);
              ExecuteSeqI dinstrs;
              ExecuteI (ConstructE ("CONST", [ i32_type; NumE 0L ]));
              ExecuteI (ConstructE ("CONST", [ i32_type; LengthE dinit ]));
              ExecuteI (ConstructE ("MEMORY.INIT", [ idx ]));
              ExecuteI (ConstructE ("DATA.DROP", [ idx ]));
            ],
            []
          )
        ]
      );
      (* Start *)
      IfI (
        IsDefinedC (start),
        [
          LetI (OptE (Some (ConstructE ("START", [ start_idx ]))), start);
          ExecuteI (ConstructE ("CALL", [ start_idx ]))
        ],
        []
      );
      PopI frame_name;
      ReturnI (Some (AccessE (module_inst, DotP "EXPORT")))
    ]
  )

let exec_expr =
  (* Name definition *)
  let instr_iter = NameE (N "instr", [List]) in
  let val_name = N "val" in

  (* Algorithm *)
  Algo (
    "exec_expr",
    [ instr_iter, TopT ],
    [
      JumpI instr_iter;
      PopI (NameE (val_name, []));
      ReturnI (Some (NameE (val_name, [])))
    ]
  )

let init_global =
  (* Name definition *)
  let ignore_name = N "_" in
  let global_name = N "global" in
  let instr_iter = NameE (N "instr", [List]) in
  let val_name = N "val" in

  (* Algorithm *)
  Algo (
    "init_global",
    [ NameE (global_name, []), TopT ],
    [
      LetI (
        ConstructE ("GLOBAL", [ NameE (ignore_name, []); instr_iter ]),
        NameE (global_name, [])
      );
      JumpI instr_iter;
      PopI (NameE (val_name, []));
      ReturnI (Some (NameE (val_name, [])))
    ]
  )

let init_elem =
  (* Name definition *)
  let ignore_name = N "_" in
  let elem_name = N "elem" in
  let instr_name = N "instr" in
  let instr_iter = NameE (instr_name, [List]) in
  let ref_iter = NameE (N "ref", [List]) in

  Algo (
    "init_elem",
    [ NameE (elem_name, []) , TopT ],
    [
      LetI (
        ConstructE ("ELEM", [ NameE (ignore_name, []); instr_iter; NameE (ignore_name, []) ]),
        NameE (elem_name, [])
      );
      LetI (ref_iter, MapE (N "exec_expr", [ NameE (instr_name, []) ], [ List ]));
      ReturnI (Some ref_iter)
    ]
  )

let alloc_module =
  (* Name definition *)
  let module_ = NameE (N "module", []) in
  let externval = NameE (N "externval", [ List ]) in
  let import_type = NameE (N "import_type", []) in
  let externuse = NameE (N "externuse", []) in
  let module_inst_init = NameE (N "moduleinst", []) in
  let module_inst_init_rec =
    Record.empty
    |> Record.add "FUNC" (ListE [])
    |> Record.add "TABLE" (ListE [])
    |> Record.add "GLOBAL" (ListE [])
    |> Record.add "MEM" (ListE [])
    |> Record.add "ELEM" (ListE [])
    |> Record.add "DATA" (ListE [])
    |> Record.add "EXPORT" (ListE [])
  in
  let frame_init = NameE (SubN ((N "f"), "init"), []) in
  let frame_init_rec =
    Record.empty
    |> Record.add "MODULE" module_inst_init
    |> Record.add "LOCAL" (ListE []) in
  let import_name = N "import" in
  let import_iter = NameE (import_name, [List]) in
  let func_name = N "func" in
  let func = NameE (func_name, []) in
  let func_iter = NameE (func_name, [List]) in
  let table_name = N "table" in
  let table = NameE (table_name, []) in
  let table_iter = NameE (table_name, [List]) in
  let global_name = N "global" in
  let global = NameE (global_name, []) in
  let global_iter = NameE (global_name, [List]) in
  let memory_name = N "memory" in
  let memory = NameE (memory_name, []) in
  let memory_iter = NameE (memory_name, [List]) in
  let elem_name = N "elem" in
  let elem = NameE (elem_name, []) in
  let elem_iter = NameE (elem_name, [List]) in
  let data_name = N "data" in
  let data = NameE (data_name, []) in
  let data_iter = NameE (data_name, [List]) in
  let export_name = N "export" in
  let export_iter = NameE (export_name, [List]) in
  let funcaddr' = NameE (N "funcaddr'", []) in
  let funcaddr_iter = NameE (N "funcaddr", [List]) in
  let tableaddr_iter = NameE (N "tableaddr", [List]) in
  let globaladdr_iter = NameE (N "globaladdr", [List]) in
  let memoryaddr_iter = NameE (N "memoryaddr", [List]) in
  let elemaddr_iter = NameE (N "elemaddr", [List]) in
  let dataaddr_iter = NameE (N "dataaddr", [List]) in

  let ignore_name = NameE (N "_", []) in
  let store = NameE (N "s", []) in
  let func' = NameE (N "func'", []) in

  let base = AccessE (NameE (N "s", []), DotP "FUNC") in
  let index = IndexP (NameE (N "i", [])) in
  let index_access = AccessE (base, index) in

  (* Algorithm *)
  Algo (
    "alloc_module",
    [ module_, TopT; externval, TopT ],
    [
      LetI (
        ConstructE (
          "MODULE",
          [
            import_iter;
            func_iter;
            global_iter;
            table_iter;
            memory_iter;
            elem_iter;
            data_iter;
            ignore_name;
            export_iter
          ]
        ),
        module_
      );
      LetI (module_inst_init, RecordE module_inst_init_rec);
      ForI (
        import_iter,
        [
          LetI (ConstructE ("IMPORT", [ ignore_name; ignore_name; import_type ]), AccessE (import_iter, index));
          LetI (ConstructE ("EXPORT", [ ignore_name; externuse ]), AccessE (externval, index));
          IfI (
            BinopC (And, IsCaseOfC (import_type, "FUNC"), IsCaseOfC (externuse, "FUNC")),
            [
              LetI (ConstructE ("FUNC", [ funcaddr' ]), externuse);
              AppendI (AccessE (module_inst_init, DotP "FUNC"), funcaddr')
            ],
            []
          )
        ]
      );
      LetI (frame_init, FrameE (NumE 0L, RecordE frame_init_rec));
      PushI frame_init;
      LetI ( funcaddr_iter, MapE (N "alloc_func", [ func ], [ List ]));
      AppendListI (AccessE (module_inst_init, DotP "FUNC"), funcaddr_iter);
      LetI (tableaddr_iter, MapE (N "alloc_table", [ table ], [ List ]));
      AppendListI (AccessE (module_inst_init, DotP "TABLE"), tableaddr_iter);
      LetI (globaladdr_iter, MapE (N "alloc_global", [ global ], [ List ]));
      AppendListI (AccessE (module_inst_init, DotP "GLOBAL"), globaladdr_iter);
      LetI (memoryaddr_iter, MapE (N "alloc_memory", [ memory ], [ List ]));
      AppendListI (AccessE (module_inst_init, DotP "MEM"), memoryaddr_iter);
      LetI (elemaddr_iter, MapE (N "alloc_elem", [ elem ], [ List ]));
      AppendListI (AccessE (module_inst_init, DotP "ELEM"), elemaddr_iter);
      LetI (dataaddr_iter, MapE (N "alloc_data", [ data ], [ List ]));
      AppendListI (AccessE (module_inst_init, DotP "DATA"), dataaddr_iter);
      PopI frame_init;
      ForI (
        AccessE (store, DotP "FUNC"),
        [
          LetI (PairE (ignore_name, func'), index_access);
          ReplaceI (base, index, PairE (module_inst_init, func'))
        ]
      );
      AppendListI (AccessE (module_inst_init, DotP "EXPORT"), export_iter);
      ReturnI (Some module_inst_init)
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
    |> Record.add "FUNC" (ListE [])
    |> Record.add "TABLE" (ListE []) in
  let func_inst_name = N "funcinst" in

  (* Algorithm *)
  Algo (
    "alloc_func",
    [ (NameE (func_name, []), TopT) ],
    [
      LetI (NameE (addr_name, []), LengthE (AccessE (NameE (store_name, []), DotP "FUNC")));
      LetI (NameE (dummy_module_inst, []), RecordE dummy_module_rec);
      LetI (NameE (func_inst_name, []), PairE (NameE (dummy_module_inst, []), NameE (func_name, [])));
      AppendI (AccessE (NameE (store_name, []), DotP "FUNC"), NameE (func_inst_name, []));
      ReturnI (Some (NameE (addr_name, [])))
    ]
  )

let alloc_global =
  (* Name definition *)
  let global = NameE (N "global", []) in
  let addr = NameE (N "a", []) in
  let val_ = NameE (N "val", []) in
  let store = NameE (N "s", []) in

  (* Algorithm *)
  Algo (
    "alloc_global",
    [ global, TopT ],
    [
      LetI (addr, LengthE (AccessE (store, DotP "GLOBAL")));
      LetI (val_, AppE (N "init_global", [ global ]));
      AppendI (AccessE (store, DotP "GLOBAL"), val_);
      ReturnI (Some addr)
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
  let ref_null = ConstructE ("REF.NULL", [NameE (reftype, [])]) in

  (* Algorithm *)
  Algo (
    "alloc_table",
    [ (NameE (table_name, []), TopT) ],
    [
      LetI (
        ConstructE ("TABLE", [PairE (NameE (min, []), NameE (ignore_name, [])); NameE (reftype, [])]),
        NameE (table_name, [])
      );
      LetI (NameE (addr_name, []), LengthE (AccessE (NameE (store_name, []), DotP "TABLE")));
      LetI (NameE (tableinst_name, []), ListFillE (ref_null, NameE (min, [])));
      AppendI (AccessE (NameE (store_name, []), DotP "TABLE"), NameE (tableinst_name, []));
      ReturnI (Some (NameE (addr_name, [])))
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
    [ (NameE (memory_name, []), TopT) ],
    [
      LetI (
        ConstructE ("MEMORY", [ PairE (NameE (min_name, []), NameE (ignore_name, [])) ]),
        NameE (memory_name, [])
      );
      LetI (NameE (addr_name, []), LengthE (AccessE (NameE (store_name, []), DotP "MEM")));
      LetI (
        NameE (memoryinst_name, []),
        ListFillE (
          NumE 0L,
          BinopE (Mul, BinopE (Mul, NameE (min_name, []), NumE 64L), AppE (N "Ki", []))
        )
      );
      AppendI (AccessE (NameE (store_name, []), DotP "MEM"), NameE (memoryinst_name, []));
      ReturnI (Some (NameE (addr_name, [])))
    ]
  )

let alloc_elem =
  (* Name definition *)
  let elem = NameE (N "elem", []) in
  let addr = NameE (N "a", []) in
  let ref = NameE (N "ref", [ List ]) in
  let store = NameE (N "s", []) in

  (* Algorithm *)
  Algo (
    "alloc_elem",
    [ elem, TopT ],
    [
      LetI (addr, LengthE (AccessE (store, DotP "ELEM")));
      LetI (ref, AppE (N "init_elem", [ elem ]));
      AppendI (AccessE (store, DotP "ELEM"), ref);
      ReturnI (Some addr)
    ]
  )

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
    [ (NameE (data_name, []), TopT) ],
    [
      LetI (
        ConstructE ("DATA", [ NameE (init, []); NameE (ignore_name, []) ]),
        NameE (data_name, [])
      );
      LetI (NameE (addr_name, []), LengthE (AccessE (NameE (store_name, []), DotP "DATA")));
      AppendI (AccessE (NameE (store_name, []), DotP "DATA"), NameE (init, []));
      ReturnI (Some (NameE (addr_name, [])))
    ]
  )

let invocation =
  (* Name definition *)
  let ignore_name = N "_" in
  let args = N "val" in
  let args_iter = NameE (args, [List]) in
  let funcaddr_name = N "funcaddr" in
  let func_name = N "func" in
  let store_name = N "s" in
  let func_type_name = N "functype" in
  let n = N "n" in
  let m = N "m" in
  let frame_name = N "f" in
  let dummy_module_rec =
    Record.empty
    |> Record.add "FUNC" (ListE [])
    |> Record.add "TABLE" (ListE []) in
  let frame_rec =
    Record.empty
    |> Record.add "LOCAL" (ListE [])
    |> Record.add "MODULE" (RecordE dummy_module_rec) in

  (* Algorithm *)
  Algo (
    "invocation",
    [ (NameE (funcaddr_name, []), TopT); (args_iter, TopT) ],
    [
      LetI (
        PairE (NameE (ignore_name, []), NameE (func_name, [])),
        AccessE (AccessE (NameE (store_name, []), DotP "FUNC"), IndexP (NameE (funcaddr_name, [])))
      );
      LetI (
        ConstructE ("FUNC", [NameE (func_type_name, []); NameE (ignore_name, []); NameE (ignore_name, [])]),
        NameE (func_name, [])
      );
      LetI (
        ArrowE (NameE (ignore_name, [ListN n]), NameE (ignore_name, [ListN m])),
        NameE (func_type_name, [])
      );
      AssertI (CompareC (Eq, LengthE args_iter, NameE (n, [])) |> Print.string_of_cond);
      (* TODO *)
      LetI (NameE (frame_name, []), FrameE (NumE 0L, RecordE frame_rec));
      PushI (NameE (frame_name, []));
      PushI (args_iter);
      ExecuteI (ConstructE ("CALL_ADDR", [NameE (funcaddr_name, [])]));
      PopI (NameE (SubN (N "val", "res"), [ListN m]));
      PopI (NameE (frame_name, []));
      ReturnI (Some (NameE (SubN (N "val", "res"), [ListN m])))
    ]
  )


let manual_algos =
  [
    br;
    return;
    instantiation;
    alloc_module;
    init_global;
    init_elem;
    exec_expr;
    alloc_func;
    alloc_table;
    alloc_global;
    alloc_memory;
    alloc_elem;
    alloc_data;
    invocation
  ]
