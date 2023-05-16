open Reference_interpreter
open Source
open Al

(* Hardcoded Data *)

let to_phrase x = x @@ no_region
let i32 = I32.of_int_s
let i64 = I64.of_int_s
let f32 = F32.of_float
let f64 = F64.of_float

(* Hardcoded Instas *)

let yetV = StringV "DUMMY"
let i32TV = WasmTypeV (NumType I32Type)

let addrs =
  ListV
    [|
      IntV 0;
      (* global address 0 *)
      IntV 1;
      (* global address 1 *)
      IntV 2;
      (* global address 2 *)
    |]

let module_inst : module_inst =
  Record.empty |> Record.add "IMPORT" yetV |> Record.add "FUNC" addrs
  |> Record.add "GLOBAL" addrs |> Record.add "TABLE" addrs
  |> Record.add "MEM" yetV |> Record.add "ELEM" yetV |> Record.add "DATA" yetV
  |> Record.add "START" yetV |> Record.add "EXPORT" yetV

let get_func_insts_data () =
  ListV
    [|
      (* nop *)
      PairV
        ( ModuleInstV module_inst,
          ConstructV
            ("FUNC", [ ArrowV (ListV [||], ListV [||]); ListV [||]; ListV [||] ])
        );
      (* add *)
      PairV
        ( ModuleInstV module_inst,
          ConstructV
            ( "FUNC",
              [
                ArrowV (ListV [| i32TV; i32TV |], ListV [| i32TV |]);
                ListV [||];
                ListV
                  [|
                    WasmInstrV ("local.get", [ IntV 0 ]);
                    WasmInstrV ("local.get", [ IntV 1 ]);
                    WasmInstrV ("binop", [ i32TV; StringV "Add" ]);
                  |];
              ] ) );
      (* sum *)
      PairV
        ( ModuleInstV module_inst,
          ConstructV
            ( "FUNC",
              [
                ArrowV (ListV [| i32TV |], ListV [| i32TV |]);
                ListV [||];
                ListV
                  [|
                    WasmInstrV ("local.get", [ IntV 0 ]);
                    WasmInstrV
                      ( "if",
                        [
                          ArrowV (ListV [| i32TV |], ListV [| i32TV |]);
                          ListV
                            [|
                              WasmInstrV ("local.get", [ IntV 0 ]);
                              WasmInstrV ("local.get", [ IntV 0 ]);
                              WasmInstrV ("const", [ i32TV; IntV 1 ]);
                              WasmInstrV ("binop", [ i32TV; StringV "Sub" ]);
                              WasmInstrV ("call", [ IntV 2 ]);
                              WasmInstrV ("binop", [ i32TV; StringV "Add" ]);
                            |];
                          ListV [| WasmInstrV ("const", [ i32TV; IntV 0 ]) |];
                        ] );
                  |];
              ] ) );
    |]

let get_global_insts_data () =
  ListV
    [|
      WasmInstrV ("const", [ WasmTypeV (NumType F32Type); FloatV 1.4 ]);
      WasmInstrV ("const", [ WasmTypeV (NumType F32Type); FloatV 5.2 ]);
      WasmInstrV ("const", [ WasmTypeV (NumType I32Type); IntV 42 ]);
    |]

let get_table_insts_data () =
  ListV
    [|
      ListV
        [|
          WasmInstrV ("ref.null", [ WasmTypeV (RefType ExternRefType) ]);
          WasmInstrV ("ref.null", [ WasmTypeV (RefType FuncRefType) ]);
          WasmInstrV ("ref.null", [ WasmTypeV (RefType FuncRefType) ]);
        |];
      ListV
        [|
          WasmInstrV ("ref.null", [ WasmTypeV (RefType FuncRefType) ]);
          WasmInstrV ("ref.null", [ WasmTypeV (RefType ExternRefType) ]);
          WasmInstrV ("ref.null", [ WasmTypeV (RefType FuncRefType) ]);
        |];
      ListV
        [|
          WasmInstrV ("ref.null", [ WasmTypeV (RefType FuncRefType) ]);
          WasmInstrV ("ref.null", [ WasmTypeV (RefType FuncRefType) ]);
          WasmInstrV ("ref.null", [ WasmTypeV (RefType ExternRefType) ]);
        |];
    |]

(* Hardcoded Store *)

let get_store_data () : store =
  Record.empty
  |> Record.add "FUNC" (get_func_insts_data ())
  |> Record.add "GLOBAL" (get_global_insts_data ())
  |> Record.add "TABLE" (get_table_insts_data ())
  |> Record.add "MEM" yetV |> Record.add "ELEM" yetV |> Record.add "DATA" yetV

let store : store ref = ref Record.empty

(* Hardcoded Frame *)

let get_locals_data () =
  [|
    WasmInstrV ("const", [ WasmTypeV (NumType I32Type); IntV 3 ]);
    WasmInstrV ("const", [ WasmTypeV (NumType I32Type); IntV 0 ]);
    WasmInstrV ("const", [ WasmTypeV (NumType I32Type); IntV 7 ]);
  |]

let get_frame_data () =
  let locals = get_locals_data () in
  let r =
    Record.empty
    |> Record.add "LOCAL" (ListV locals)
    |> Record.add "MODULE" (ModuleInstV module_inst)
  in
  FrameV (Array.length locals, r)

(* Hardcoded Wasm Instructions in Reference Interpreter AST *)

let binop =
  ( "binop",
    [
      Operators.i32_const (i32 19 |> to_phrase) |> to_phrase;
      Operators.i32_const (i32 27 |> to_phrase) |> to_phrase;
      Operators.i32_add |> to_phrase;
    ],
    "46" )

let testop =
  ( "testop",
    [
      Operators.i32_const (i32 0 |> to_phrase) |> to_phrase;
      Operators.i32_eqz |> to_phrase;
    ],
    "1" )

let relop1 =
  ( "relop i32",
    [
      Operators.i32_const (i32 1 |> to_phrase) |> to_phrase;
      Operators.i32_const (i32 3 |> to_phrase) |> to_phrase;
      Operators.i32_gt_s |> to_phrase;
    ],
    "0" )

let relop2 =
  ( "relop f32",
    [
      Operators.f32_const (f32 1.4142135 |> to_phrase) |> to_phrase;
      Operators.f32_const (f32 3.1415926 |> to_phrase) |> to_phrase;
      Operators.f32_gt |> to_phrase;
    ],
    "0" )

let nop =
  ( "nop",
    [
      Operators.i64_const (i64 0 |> to_phrase) |> to_phrase;
      Operators.nop |> to_phrase;
    ],
    "0" )

let drop =
  ( "drop",
    [
      Operators.f64_const (f64 3.1 |> to_phrase) |> to_phrase;
      Operators.f64_const (f64 5.2 |> to_phrase) |> to_phrase;
      Operators.drop |> to_phrase;
    ],
    "3.1" )

let select =
  ( "select",
    [
      Operators.f64_const (f64 Float.max_float |> to_phrase) |> to_phrase;
      Operators.ref_null Types.FuncRefType |> to_phrase;
      Operators.i32_const (i32 0 |> to_phrase) |> to_phrase;
      Operators.select None |> to_phrase;
    ],
    "null" )

let local_set =
  ( "local_set",
    [
      Operators.local_get (i32 2 |> to_phrase) |> to_phrase;
      Operators.i32_const (i32 1 |> to_phrase) |> to_phrase;
      Operators.i32_add |> to_phrase;
      Operators.local_set (i32 2 |> to_phrase) |> to_phrase;
      Operators.local_get (i32 2 |> to_phrase) |> to_phrase;
    ],
    "8" )

let local_get =
  ("local_get", [ Operators.local_get (i32 2 |> to_phrase) |> to_phrase ], "7")

let local_tee =
  ( "local_tee",
    [
      Operators.local_get (i32 0 |> to_phrase) |> to_phrase;
      Operators.local_tee (i32 1 |> to_phrase) |> to_phrase;
      Operators.local_get (i32 1 |> to_phrase) |> to_phrase;
      Operators.i32_add |> to_phrase;
    ],
    "6" )

let global_set =
  ( "global_set",
    [
      Operators.global_get (i32 2 |> to_phrase) |> to_phrase;
      Operators.i32_const (i32 1 |> to_phrase) |> to_phrase;
      Operators.i32_add |> to_phrase;
      Operators.global_set (i32 2 |> to_phrase) |> to_phrase;
      Operators.global_get (i32 2 |> to_phrase) |> to_phrase;
    ],
    "43" )

let global_get1 =
  ( "global_get1",
    [ Operators.global_get (i32 1 |> to_phrase) |> to_phrase ],
    "5.2" )

let global_get2 =
  ( "global_get2",
    [ Operators.global_get (i32 2 |> to_phrase) |> to_phrase ],
    "42" )

let table_get =
  ( "table_get",
    [
      Operators.i32_const (i32 1 |> to_phrase) |> to_phrase;
      Operators.table_get (i32 2 |> to_phrase) |> to_phrase;
    ],
    "null" )

let call_nop =
  ( "call_nop",
    [
      Operators.i32_const (i32 0 |> to_phrase) |> to_phrase;
      Operators.call (i32 0 |> to_phrase) |> to_phrase;
    ],
    "0" )

let call_add =
  ( "call_add",
    [
      Operators.i32_const (i32 1 |> to_phrase) |> to_phrase;
      Operators.i32_const (i32 2 |> to_phrase) |> to_phrase;
      Operators.call (i32 1 |> to_phrase) |> to_phrase;
    ],
    "3" )

let call_sum =
  ( "call_sum",
    [
      Operators.i32_const (i32 10 |> to_phrase) |> to_phrase;
      Operators.call (i32 2 |> to_phrase) |> to_phrase;
    ],
    "55" )

let testcases_reference =
  [
    binop;
    testop;
    relop1;
    relop2;
    nop;
    drop;
    select;
    local_set;
    local_get;
    local_tee;
    global_set;
    global_get1;
    global_get2;
    table_get;
    call_nop;
    call_add;
    call_sum;
  ]

(* Hardcoded Wasm Instructions in WASM Values *)

let block =
  ( "block",
    [
      WasmInstrV ("const", [ i32TV; IntV 1 ]);
      WasmInstrV ("const", [ i32TV; IntV 2 ]);
      WasmInstrV
        ( "block",
          [
            ArrowV (ListV [| i32TV; i32TV |], ListV [| i32TV |]);
            ListV [| WasmInstrV ("binop", [ i32TV; StringV "Sub" ]) |];
          ] );
    ],
    "-1" )

let br_zero =
  ( "br_zero",
    [
      WasmInstrV ("const", [ i32TV; IntV 1 ]);
      WasmInstrV
        ( "block",
          [
            ArrowV (ListV [| i32TV |], ListV [| i32TV |]);
            ListV
              [|
                WasmInstrV ("const", [ i32TV; IntV 32 ]);
                WasmInstrV ("const", [ i32TV; IntV 42 ]);
                WasmInstrV ("br", [ IntV 0 ]);
                WasmInstrV ("const", [ i32TV; IntV 52 ]);
              |];
          ] );
      WasmInstrV ("const", [ i32TV; IntV 1 ]);
      WasmInstrV ("binop", [ i32TV; StringV "Add" ]);
    ],
    "43" )

let br_succ =
  ( "br_succ",
    [
      WasmInstrV ("const", [ i32TV; IntV 1 ]);
      WasmInstrV
        ( "block",
          [
            ArrowV (ListV [| i32TV |], ListV [| i32TV |]);
            ListV
              [|
                WasmInstrV ("const", [ i32TV; IntV 32 ]);
                WasmInstrV
                  ( "block",
                    [
                      ArrowV (ListV [| i32TV; i32TV |], ListV [| i32TV |]);
                      ListV
                        [|
                          WasmInstrV ("const", [ i32TV; IntV 42 ]);
                          WasmInstrV ("br", [ IntV 1 ]);
                          WasmInstrV ("const", [ i32TV; IntV 52 ]);
                        |];
                    ] );
              |];
          ] );
      WasmInstrV ("const", [ i32TV; IntV 1 ]);
      WasmInstrV ("binop", [ i32TV; StringV "Add" ]);
    ],
    "43" )

let if_true =
  ( "if_true",
    [
      WasmInstrV ("const", [ i32TV; IntV 42 ]);
      WasmInstrV ("const", [ i32TV; IntV 1 ]);
      WasmInstrV
        ( "if",
          [
            ArrowV (ListV [| i32TV |], ListV [| i32TV |]);
            ListV
              [|
                WasmInstrV ("const", [ i32TV; IntV 2 ]);
                WasmInstrV ("binop", [ i32TV; StringV "Add" ]);
              |];
            ListV 
              [| 
                WasmInstrV ("const", [ i32TV; IntV 3 ]);
                WasmInstrV ("binop", [ i32TV; StringV "Add" ]);
              |];
          ] );
    ],
    "44" )

let if_false =
  ( "if_false",
    [
      WasmInstrV ("const", [ i32TV; IntV 42 ]);
      WasmInstrV ("const", [ i32TV; IntV 0 ]);
      WasmInstrV
        ( "if",
          [
            ArrowV (ListV [| i32TV |], ListV [| i32TV |]);
            ListV
              [|
                WasmInstrV ("const", [ i32TV; IntV 2 ]);
                WasmInstrV ("binop", [ i32TV; StringV "Add" ]);
              |];
            ListV 
              [| 
                WasmInstrV ("const", [ i32TV; IntV 3 ]);
                WasmInstrV ("binop", [ i32TV; StringV "Add" ]);
              |];
          ] );
    ],
    "45" )

let testcases_wasm_value = [ block; br_zero; br_succ; if_true; if_false; ]

(* Printer of final result *)
let string_of_result v =
  match v with
  | WasmInstrV ("const", [ _; n ]) -> Print.string_of_value n
  | WasmInstrV ("ref.null", _) -> "null"
  | _ -> Print.string_of_value v ^ "is not a wasm value."

(* Module tests *)

let wasm_func_skeleton : Ast.func' =
  { Ast.ftype = Int32.of_int 0 |> to_phrase; Ast.locals = []; Ast.body = [] }

let wasm_module_skeleton : Ast.module_' =
  let default_type = Types.FuncType ([], []) |> to_phrase in
  {
    Ast.types = [default_type];
    Ast.globals = [];
    Ast.tables = [];
    Ast.memories = [];
    Ast.funcs = [];
    Ast.start = None;
    Ast.elems = [];
    Ast.datas = [];
    Ast.imports = [];
    Ast.exports = [];
  }

let gen_module_testcase testcase =
  let name, wl, expected_result = testcase in
  let wasm_func = { wasm_func_skeleton with Ast.body = wl } |> to_phrase in
  let wasm_module =
    { wasm_module_skeleton with Ast.funcs = [ wasm_func ] } |> to_phrase
  in
  (name, wasm_module, expected_result)

let testcases_module = List.map gen_module_testcase testcases_reference
