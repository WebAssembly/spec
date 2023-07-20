open Al.Ast
open Al.Record

(** Hardcoded module algorithms **)

let instantiation =
  (* Name definition *)
  let ignore_name = NameE (N "_") in
  let module_ = NameE (N "module") in
  let externval = IterE (NameE (N "externval"), List) in
  let module_inst = NameE (N "moduleinst") in
  let frame_name = NameE (N "f") in
  let frame_rec =
    Record.empty
    |> Record.add "MODULE" module_inst
    |> Record.add "LOCAL" (ListE []) in
  let elem = IterE (NameE (N "elem"), List) in
  let data = IterE (NameE (N "data"), List) in
  let start = IterE (NameE (N "start"), Opt) in
  let mode_opt = NameE (N "mode_opt") in
  let mode = NameE (N "mode") in
  let einit = NameE (N "einit") in
  let dinit = NameE (N "dinit") in
  let idx = NameE (N "i") in
  let tableidx = NameE (N "tableidx") in
  let memidx = NameE (N "memidx") in
  let einstrs = IterE (NameE (N "einstrs"), List) in
  let dinstrs = IterE (NameE (N "dinstrs"), List) in
  let start_idx = NameE (N "start_idx") in
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
              AssertI (CompareC (Eq, memidx, NumE 0L));
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
      ReturnI (Some module_inst)
    ]
  )

let exec_expr =
  (* Name definition *)
  let instr_iter = IterE (NameE (N "instr"), List) in
  let val_name = NameE (N "val") in

  (* Algorithm *)
  Algo (
    "exec_expr",
    [ instr_iter, TopT ],
    [
      ExecuteSeqI instr_iter;
      PopI (val_name);
      ReturnI (Some val_name)
    ]
  )

let init_global =
  (* Name definition *)
  let ignore_name = NameE (N "_") in
  let global_name = NameE (N "global") in
  let instr_iter = IterE (NameE (N "instr"), List) in
  let val_name = NameE (N "val") in

  (* Algorithm *)
  Algo (
    "init_global",
    [ global_name, TopT ],
    [
      LetI (
        ConstructE ("GLOBAL", [ ignore_name; instr_iter ]),
        global_name
      );
      ExecuteSeqI instr_iter;
      PopI (val_name);
      ReturnI (Some val_name)
    ]
  )

let init_elem =
  (* Name definition *)
  let ignore_name = NameE (N "_") in
  let elem_name = NameE (N "elem") in
  let instr_name = NameE (N "instr") in
  let instr_iter = IterE (instr_name, List) in
  let ref_iter = IterE (NameE (N "ref"), List) in

  Algo (
    "init_elem",
    [ elem_name , TopT ],
    [
      LetI (
        ConstructE ("ELEM", [ ignore_name; instr_iter; ignore_name ]),
        elem_name
      );
      LetI (ref_iter, MapE (N "exec_expr", [ instr_name ], [ List ]));
      ReturnI (Some ref_iter)
    ]
  )

let alloc_module =
  (* Name definition *)
  let module_ = NameE (N "module") in
  let externval = IterE (NameE (N "externval"), List) in
  let import_type = NameE (N "import_type") in
  let externuse = NameE (N "externuse") in
  let index = IndexP (NameE (N "i")) in
  let extern = AccessE (externval, index) in

  let module_inst_init = NameE (N "moduleinst") in
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
  let frame_init = NameE (SubN (N "f", "init")) in
  let frame_init_rec =
    Record.empty
    |> Record.add "MODULE" module_inst_init
    |> Record.add "LOCAL" (ListE []) in
  let import_name = NameE (N "import") in
  let import_iter = IterE (import_name, List) in
  let func = NameE (N "func") in
  let func_iter = IterE (func, List) in
  let table = NameE (N "table") in
  let table_iter = IterE (table, List) in
  let global = NameE (N "global") in
  let global_iter = IterE (global, List) in
  let memory = NameE (N "memory") in
  let memory_iter = IterE (memory, List) in
  let elem = NameE (N "elem") in
  let elem_iter = IterE (elem, List) in
  let data = NameE (N "data") in
  let data_iter = IterE (data, List) in
  let export = NameE (N "export") in
  let export_iter = IterE (export, List) in
  let funcaddr_iter = IterE (NameE (N "funcaddr"), List) in
  let tableaddr_iter = IterE (NameE (N "tableaddr"), List) in
  let globaladdr_iter = IterE (NameE (N "globaladdr"), List) in
  let memoryaddr_iter = IterE (NameE (N "memoryaddr"), List) in
  let elemaddr_iter = IterE (NameE (N "elemaddr"), List) in
  let dataaddr_iter = IterE (NameE (N "dataaddr"), List) in
  let name = NameE (N "name") in

  let ignore_name = NameE (N "_") in
  let store = NameE (N "s") in
  let func' = NameE (N "func'") in

  let base = AccessE (store, DotP "FUNC") in
  let index = IndexP (NameE (N "i")) in
  let funcaddr = IndexP (AccessE (funcaddr_iter, index)) in
  let index_access = AccessE (base, funcaddr) in

  (* predefined instructions *)
  let append_if tag =
    let addr' = NameE (N (String.lowercase_ascii tag ^ "addr'")) in
    IfI (
      BinopC (And, IsCaseOfC (import_type, tag), IsCaseOfC (extern, tag)),
      [
        LetI (ConstructE (tag, [ addr' ]), extern);
        AppendI (AccessE (module_inst_init, DotP tag), addr')
      ],
      []) in
  let append_export_if tag =
    let nameE name = NameE (N name) in
    let externval = nameE "externval" in
    let exportinst = nameE "exportinst" in
    let lower_tag = String.lowercase_ascii tag in
    let idx = lower_tag ^ "idx" in
    let addr = lower_tag ^ "addr" in

    let record =
      Record.empty
      |> Record.add "NAME" name
      |> Record.add "VALUE" externval
    in

    IfI (
      IsCaseOfC (externuse, tag),
      [
        LetI (ConstructE (tag, [ nameE idx ]), externuse);
        LetI (nameE addr, AccessE (AccessE (module_inst_init, DotP tag), IndexP (nameE idx)));
        LetI (externval, ConstructE (tag, [ nameE addr ]));
        LetI (exportinst, RecordE record);
        AppendI (AccessE (module_inst_init, DotP "EXPORT"), exportinst)
      ],
      []) in

  let record =
    Record.empty
    |> Record.add "MODULE" module_inst_init
    |> Record.add "CODE" func'
  in


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
          append_if "FUNC";
          append_if "TABLE";
          append_if "MEM";
          append_if "GLOBAL"
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
        funcaddr_iter,
        [
          LetI (func', AccessE (index_access, DotP "CODE"));
          ReplaceI (base, funcaddr, RecordE record)
        ]
      );
      ForI (
        export_iter,
        [
          LetI (ConstructE ("EXPORT", [ name; externuse ]), AccessE (export_iter, index));
          append_export_if "FUNC";
          append_export_if "TABLE";
          append_export_if "MEM";
          append_export_if "GLOBAL";
        ]
      );
      ReturnI (Some module_inst_init)
    ]
  )

let alloc_func =
  (* Name definition *)
  let func = NameE (N "func") in
  let addr = NameE (N "a") in
  let store = NameE (N "s") in
  let dummy_module_inst = NameE (N "dummy_module_inst") in
  let dummy_module_rec =
    Record.empty
    |> Record.add "FUNC" (ListE [])
    |> Record.add "TABLE" (ListE []) in
  let func_inst = NameE (N "funcinst") in

  let record =
    Record.empty
    |> Record.add "MODULE" dummy_module_inst
    |> Record.add "CODE" func
  in

  (* Algorithm *)
  Algo (
    "alloc_func",
    [ func, TopT ],
    [
      LetI (addr, LengthE (AccessE (store, DotP "FUNC")));
      LetI (dummy_module_inst, RecordE dummy_module_rec);
      LetI (func_inst, RecordE record);
      AppendI (AccessE (store, DotP "FUNC"), func_inst);
      ReturnI (Some (addr))
    ]
  )

let alloc_global =
  (* Name definition *)
  let global = id "global" in
  let addr = id "a" in
  let globalinst = id "globalinst" in
  let store = id "s" in

  let record =
    Record.empty
    (* TODO: type *)
    |> Record.add "VALUE" (AppE (N "init_global", [ global ]))
  in

  (* Algorithm *)
  Algo (
    "alloc_global",
    [ global, TopT ],
    [
      LetI (addr, LengthE (AccessE (store, DotP "GLOBAL")));
      LetI (globalinst, RecordE record);
      AppendI (AccessE (store, DotP "GLOBAL"), globalinst);
      ReturnI (Some addr)
    ]
  )

let alloc_table =
  (* Name definition *)
  let table = id "table" in
  let min = id "n" in
  let max = IterE (NameE (N "m"), Opt) in
  let reftype = id "reftype" in
  let addr = id "a" in
  let store = id "s" in
  let tableinst = id "tableinst" in
  let ref_null = ConstructE ("REF.NULL", [ reftype ]) in

  let record =
    Record.empty
    |> Record.add "TYPE" (PairE (PairE (min, max), reftype))
    |> Record.add "ELEM" (ListFillE (ref_null, min))
  in

  (* Algorithm *)
  Algo (
    "alloc_table",
    [ table, TopT ],
    [
      LetI (
        ConstructE ("TABLE", [ PairE (min, max); reftype ]),
        table
      );
      LetI (addr, LengthE (AccessE (store, DotP "TABLE")));
      LetI (tableinst, RecordE record);
      AppendI (AccessE (store, DotP "TABLE"), tableinst);
      ReturnI (Some (addr))
    ]
  )

let alloc_memory =
  (* Name definition *)
  let memory = id "memory" in
  let min = id "min" in
  let max = IterE (NameE (N "max"), Opt) in
  let addr = id "a" in
  let store = id "s" in
  let memoryinst = id "memoryinst" in

  let record =
    Record.empty
    |> Record.add "TYPE" (ConstructE ("I8", [ PairE (min, max) ]))
    |> Record.add "DATA" (ListFillE (
          NumE 0L,
          BinopE (Mul, BinopE (Mul, min, NumE 64L), AppE (N "Ki", []))
        ))
  in

  (* Algorithm *)
  Algo(
    "alloc_memory",
    [ memory, TopT ],
    [
      LetI (
        ConstructE ("MEMORY", [ PairE (min, max) ]),
        memory
      );
      LetI (addr, LengthE (AccessE (store, DotP "MEM")));
      LetI (
        memoryinst,
        RecordE record
      );
      AppendI (AccessE (store, DotP "MEM"), memoryinst);
      ReturnI (Some (addr))
    ]
  )

let alloc_elem =
  (* Name definition *)
  let elem = NameE (N "elem") in
  let addr = NameE (N "a") in
  let eleminst = id "eleminst" in
  let store = NameE (N "s") in

  let record =
    Record.empty
    (* TODO :type *)
    |> Record.add "ELEM" (AppE (N "init_elem", [ elem ]))
  in

  (* Algorithm *)
  Algo (
    "alloc_elem",
    [ elem, TopT ],
    [
      LetI (addr, LengthE (AccessE (store, DotP "ELEM")));
      LetI (eleminst, RecordE record);
      AppendI (AccessE (store, DotP "ELEM"), eleminst);
      ReturnI (Some addr)
    ]
  )

let alloc_data =
  (* Name definition *)
  let ignore = NameE (N "_") in
  let data = NameE (N "data") in
  let init = NameE (N "init") in
  let addr = NameE (N "a") in
  let store = NameE (N "s") in

  let record =
    Record.empty
    |> Record.add "DATA" (id "init")
  in

  (* Algorithm *)
  Algo (
    "alloc_data",
    [ (data, TopT) ],
    [
      LetI (
        ConstructE ("DATA", [ init; ignore ]),
        data
      );
      LetI (addr, LengthE (AccessE (store, DotP "DATA")));
      LetI (id "datainst", RecordE record);
      AppendI (AccessE (store, DotP "DATA"), id "datainst");
      ReturnI (Some (addr))
    ]
  )

let invocation =
  (* Name definition *)
  let ignore = NameE (N "_") in
  let args = NameE (N "val") in
  let args_iter = IterE (args, List) in
  let funcaddr = NameE (N "funcaddr") in
  let func = NameE (N "func") in
  let store = NameE (N "s") in
  let functype = NameE (N "functype") in
  let n = N "n" in
  let m = N "m" in
  let frame = NameE (N "f") in
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
    [ (funcaddr, TopT); (args_iter, TopT) ],
    [
      LetI (
        func,
        AccessE(AccessE (AccessE (store, DotP "FUNC"), IndexP (funcaddr)), DotP "CODE")
      );
      LetI (
        ConstructE ("FUNC", [functype; ignore; ignore]),
        func
      );
      LetI (
        ArrowE (IterE (ignore, ListN n), IterE (ignore, ListN m)),
        functype
      );
      AssertI (CompareC (Eq, LengthE args_iter, NameE n));
      (* TODO *)
      LetI (frame, FrameE (NumE 0L, RecordE frame_rec));
      PushI frame;
      PushI args_iter;
      ExecuteI (ConstructE ("CALL_ADDR", [funcaddr]));
      PopI (IterE (NameE (SubN (N "val", "res")), ListN m));
      PopI frame;
      ReturnI (Some (IterE (NameE (SubN (N "val", "res")), ListN m)))
    ]
  )


let manual_algos =
  [(*
    instantiation;
    alloc_module;
    init_global;
    init_elem;
    exec_expr;
    alloc_func;
    alloc_global;
    alloc_table;
    alloc_memory;
    alloc_elem;
    alloc_data;
    invocation
  *)] |> List.map Transpile.app_remover
