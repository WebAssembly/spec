open Reference_interpreter
open Source
open Al

(** Helper **)
let _get_module textual = match textual.it with
  | Script.Textual m -> m
  | _ -> failwith "Failed to get module"

(* string -> Ast.module_ *)
let string_to_module code =
  Parse.string_to_module code |> _get_module

(* string -> Ast.module_ *)
let file_to_module file_name =
  let lexbuf = Lexing.from_channel (open_in file_name) in
  Parse.parse file_name lexbuf Parse.Module |> snd |> _get_module

(** Temporal hacks:
 ** These are temporary helper functions for refactoring, and eventually should be removed **)
(* Ast.module_ -> Ast.instr list *)
let module_to_instrs (m: Ast.module_) =
  (m.it.funcs |> List.hd).it.body
(* string -> Ast.instr list *)
let string_to_instrs code = code |> string_to_module |> module_to_instrs

(* string -> Al.ConstructV("FUNC", ..) *)
let string_to_func code =
  let m = string_to_module code in
  let f = m.it.funcs |> List.hd in
  Construct.al_of_wasm_func m f

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
          "(module(func))" |> string_to_func
        );
      (* add *)
      PairV
        ( ModuleInstV module_inst,
          "(module(func (param i32 i32) (result i32)
              (local.get 0)
              (local.get 1)
              (i32.add)
            ))" |> string_to_func
        );
      (* sum *)
      PairV
        ( ModuleInstV module_inst,
          "(module(func (param i32) (result i32)
              (local.get 0)
              (if (result i32) ( then
                local.get 0
                local.get 0
                i32.const 1
                i32.sub
                call 2
                i32.add
              ) ( else
                i32.const 0
              ))
            ))" |> string_to_func
          );
      (* return_frame *)
      PairV
        ( ModuleInstV module_inst,
          "(module(func (param i32 i32) (result i32)
              (local.get 0)
              (local.get 1)
              (i32.add)
              (return)
              (i32.const -1)
              (i32.add)
            ))" |> string_to_func
        );
      (* return_label *)
      PairV
        ( ModuleInstV module_inst,
          "(module(func (param i32 i32) (result i32)
              (local.get 0)
              (local.get 1)
              (block (param i32 i32) (result i32)
                i32.add
                return
                br 1
              )
              (i32.const -1)
              (i32.add)
            ))" |> string_to_func
        );
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
    "(module (func (result i32)
       (i32.const 19)
       (i32.const 27)
       (i32.add)
      ))" |> string_to_instrs,
    "46" )

let testop =
  ( "testop",
    "(module (func (result i32)
       (i32.const 0)
       (i32.eqz)
      ))" |> string_to_instrs,
    "1" )

let relop1 =
  ( "relop i32",
    "(module (func (result i32)
       (i32.const 1)
       (i32.const 3)
       (i32.gt_s)
      ))" |> string_to_instrs,
    "0" )

let relop2 =
  ( "relop f32",
    "(module (func (result i32)
       (f32.const 1.4142135)
       (f32.const 3.1415926)
       (f32.gt)
      ))" |> string_to_instrs,
    "0" )

let nop =
  ( "nop",
    "(module (func (result i32)
       (i64.const 0)
       (nop)
      ))" |> string_to_instrs,
    "0" )

let drop =
  ( "drop",
    "(module (func (result f64)
       (f64.const 3.1)
       (f64.const 5.2)
       (drop)
      ))" |> string_to_instrs,
    "3.1" )

let select =
  ( "select",
    "(module (func (result funcref)
       (f64.const 1.7976931348623157E+308)
       (ref.null func)
       (i32.const 0)
       (select)
      ))" |> string_to_instrs,
    "null" )

let local_set =
  ( "local_set",
    "(module (func (result i32)
        (local.get 2)
        (i32.const 1)
        (i32.add)
        (local.set 2)
        (local.get 2)
      ))" |> string_to_instrs,
    "8" )

let local_get =
  ("local_get",
    "(module (func (result i32)
        (local.get 2)
      ))" |> string_to_instrs,
  "7")

let local_tee =
  ( "local_tee",
    "(module (func (result i32)
        (local.get 0)
        (local.tee 1)
        (local.get 1)
        (i32.add)
      ))" |> string_to_instrs,
    "6" )

let global_set =
  ( "global_set",
    "(module (func (result i32)
        (global.get 2)
        (i32.const 1)
        (i32.add)
        (global.set 2)
        (global.get 2)
      ))" |> string_to_instrs,
    "43" )

let global_get1 =
  ( "global_get1",
    "(module (func (result f32)
        (global.get 1)
      ))" |> string_to_instrs,
    "5.2" )

let global_get2 =
  ( "global_get2",
    "(module (func (result i32)
        (global.get 2)
      ))" |> string_to_instrs,
    "42" )

let table_get =
  ( "table_get",
    "(module (func (result funcref)
        (i32.const 1)
        (table.get 2)
      ))" |> string_to_instrs,
    "null" )

let call_nop =
  ( "call_nop",
    "(module (func (result i32)
        (i32.const 0)
        (call 0)
      ))" |> string_to_instrs,
    "0" )

let call_add =
  ( "call_add",
    "(module (func (result i32)
        (i32.const 1)
        (i32.const 2)
        (call 1)
      ))" |> string_to_instrs,
    "3" )

let call_sum =
  ( "call_sum",
    "(module (func (result i32)
        (i32.const 10)
        (call 2)
      ))" |> string_to_instrs,
    "55" )

let call_add_return_frame =
  ( "call_add_return_frame",
    "(module (func (result i32)
        (i32.const 1)
        (i32.const 2)
        (call 3)
      ))" |> string_to_instrs,
    "3" )

let call_add_return_label =
  ( "call_add_return_label",
    "(module (func (result i32)
        (i32.const 1)
        (i32.const 2)
        (call 4)
      ))" |> string_to_instrs,
    "3" )

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
    (* call_nop; Temporaily commented *)
    call_add;
    call_sum;
    call_add_return_frame;
    call_add_return_label;
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
  let default_type =
    Types.FuncType ([NumType I32Type; NumType I32Type; NumType I32Type], [])
    |> to_phrase
  in
  let table_type =
    Types.TableType ({ Types.min = Int32.of_int 3; Types.max = None }, FuncRefType) in
  let table = { Ast.ttype = table_type } |> to_phrase in
  {
    Ast.types = [default_type];
    Ast.globals = [];
    Ast.tables = [ table; table; table ];
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
