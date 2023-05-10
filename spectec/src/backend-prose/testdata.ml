open Reference_interpreter
open Source
open Al

(* Hardcoded Data *)

let to_phrase x = (@@) x no_region
let i32 = I32.of_int_s
let i64 = I64.of_int_s
let f32 = F32.of_float
let f64 = F64.of_float

(* Hardcoded Instas *)

let yetV = StringV "DUMMY"

let addrs = ListV [|
  IntV 0; (* global address 0 *)
  IntV 1; (* global address 1 *)
  IntV 2; (* global address 2 *)
|]

let module_inst: module_inst =
  Record.empty
  |> Record.add "IMPORT" yetV
  |> Record.add "FUNC" addrs
  |> Record.add "GLOBAL" addrs
  |> Record.add "TABLE" addrs
  |> Record.add "MEM" yetV
  |> Record.add "ELEM" yetV
  |> Record.add "DATA" yetV
  |> Record.add "START" yetV
  |> Record.add "EXPORT" yetV

let get_func_insts_data () = ListV([|
  PairV (ModuleInstV module_inst, ConstructV("FUNC", [
    ArrowV(ListV[||], ListV[||]);
    ListV[||];
    yetV
  ]))
|])

let get_global_insts_data () = ListV([|
  WasmV (Values.Num (Values.F32 (f32 1.4)));
  WasmV (Values.Num (Values.F32 (f32 5.2)));
  WasmV (Values.Num (Values.I32 (i32 42)))
|])

let get_table_insts_data () = ListV([|
  ListV [|
    WasmV (Values.Ref (Values.NullRef ExternRefType));
    WasmV (Values.Ref (Values.NullRef FuncRefType));
    WasmV (Values.Ref (Values.NullRef FuncRefType))
  |];
  ListV [|
    WasmV (Values.Ref (Values.NullRef FuncRefType));
    WasmV (Values.Ref (Values.NullRef ExternRefType));
    WasmV (Values.Ref (Values.NullRef FuncRefType))
  |];
  ListV [|
    WasmV (Values.Ref (Values.NullRef FuncRefType));
    WasmV (Values.Ref (Values.NullRef FuncRefType));
    WasmV (Values.Ref (Values.NullRef ExternRefType))
  |]
|])

(* Hardcoded Store *)

let get_store_data (): store =
  Record.empty
  |> Record.add "FUNC" (get_func_insts_data ())
  |> Record.add "GLOBAL" (get_global_insts_data ())
  |> Record.add "TABLE" (get_table_insts_data ())
  |> Record.add "MEM" yetV
  |> Record.add "ELEM" yetV
  |> Record.add "DATA" yetV

let store: store ref = ref Record.empty

(* Hardcoded Frame *)

let get_locals_data () = [|
  WasmV (Values.Num (Values.I32 (i32 3)));
  WasmV (Values.Num (Values.I32 (i32 0)));
  WasmV (Values.Num (Values.I32 (i32 7)))
|]

let get_frame_data () =
  let locals = get_locals_data () in
  let r =
    Record.empty
    |> Record.add "LOCAL" (ListV locals)
    |> Record.add "MODULE" (ModuleInstV module_inst) in
  FrameV (Array.length locals, r)

(* Hardcoded Wasm Instructions *)

let binop = "binop", [
  Operators.i32_const (i32 19 |> to_phrase) |> to_phrase;
  Operators.i32_const (i32 27 |> to_phrase) |> to_phrase;
  Operators.i32_add |> to_phrase
], "46"

let testop = "testop", [
  Operators.i32_const (i32 0 |> to_phrase) |> to_phrase;
  Operators.i32_eqz |> to_phrase
], "1"

let relop1 = "relop i32", [
  Operators.i32_const (i32 1 |> to_phrase) |> to_phrase;
  Operators.i32_const (i32 3 |> to_phrase) |> to_phrase;
  Operators.i32_gt_s |> to_phrase
], "0"

let relop2 = "relop f32", [
  Operators.f32_const (f32 1.4142135 |> to_phrase) |> to_phrase;
  Operators.f32_const (f32 3.1415926 |> to_phrase) |> to_phrase;
  Operators.f32_gt |> to_phrase
], "0"

let nop = "nop", [
  Operators.i64_const (i64 0 |> to_phrase) |> to_phrase;
  Operators.nop |> to_phrase
], "0"

let drop = "drop", [
  Operators.f64_const (f64 3.1 |> to_phrase) |> to_phrase;
  Operators.f64_const (f64 5.2 |> to_phrase) |> to_phrase;
  Operators.drop |> to_phrase
], "3.100_000_000_000_000_1"

let select = "select", [
  Operators.f64_const (f64 Float.max_float |> to_phrase) |> to_phrase;
  Operators.ref_null Types.FuncRefType |> to_phrase;
  Operators.i32_const (i32 0 |> to_phrase) |> to_phrase;
  Operators.select None |> to_phrase
], "null"

let local_set = "local_set", [
  Operators.local_get (i32 2 |> to_phrase) |> to_phrase;
  Operators.i32_const (i32 1 |> to_phrase) |> to_phrase;
  Operators.i32_add |> to_phrase;
  Operators.local_set (i32 2 |> to_phrase) |> to_phrase;
  Operators.local_get (i32 2 |> to_phrase) |> to_phrase
], "8"

let local_get = "local_get", [
  Operators.local_get (i32 2 |> to_phrase) |> to_phrase
], "7"
let local_tee = "local_tee", [
  Operators.local_get (i32 0 |> to_phrase) |> to_phrase;
  Operators.local_tee (i32 1 |> to_phrase) |> to_phrase;
  Operators.local_get (i32 1 |> to_phrase) |> to_phrase;
  Operators.i32_add |> to_phrase;
], "6"

let global_set = "global_set", [
  Operators.global_get (i32 2 |> to_phrase) |> to_phrase;
  Operators.i32_const (i32 1 |> to_phrase) |> to_phrase;
  Operators.i32_add |> to_phrase;
  Operators.global_set (i32 2 |> to_phrase) |> to_phrase;
  Operators.global_get (i32 2 |> to_phrase) |> to_phrase
], "43"

let global_get1 = "global_get1", [
  Operators.global_get (i32 1 |> to_phrase) |> to_phrase
], "5.199_999_809_265_136_7"

let global_get2 = "global_get2", [
  Operators.global_get (i32 2 |> to_phrase) |> to_phrase
], "42"

let table_get = "table_get", [
  Operators.i32_const (i32 1 |> to_phrase) |> to_phrase;
  Operators.table_get (i32 2 |> to_phrase) |> to_phrase
], "null"

let call = "call", [
  Operators.call (i32 0 |> to_phrase) |> to_phrase
], "yet"

let test_cases = [
  binop; testop; relop1; relop2; nop; drop; select;
  local_set; local_get; local_tee; global_set; global_get1; global_get2; table_get;
  call
]
