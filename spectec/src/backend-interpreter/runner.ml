open Reference_interpreter
open Script
open Al.Ast
open Construct
open Source
open Util.Record

(** Helpers **)

(* TODO: move this function to Al_util *)
let listv_map f = function
  | ListV arr_ref -> listV (Array.map f !arr_ref)
  | _ -> failwith "Not a list"

let listv_find f = function
  | ListV arr_ref -> Array.find_opt f !arr_ref |> Option.get
  | _ -> failwith "Not a list"

let listv_nth l n =
  match l with
  | ListV arr_ref -> Array.get !arr_ref n
  | _ -> failwith "Not a list"

let casev_nth_arg n = function
  | CaseV (_, l) -> List.nth l n
  | _ -> failwith "Not a case"

let strv_access field = function
  | StrV r -> Record.find field r
  | _ -> failwith "Not a record"

let success = 1, 1
let fail = 0, 1
let pass = 0, 0

let eprint_fail_log expected actual =
  Printf.eprintf " Fail!\n";
  Printf.eprintf " Expected: %s\n" expected;
  Printf.eprintf " Actual  : %s\n\n" actual;
  let print_stack = false in
  if print_stack then
    Printf.eprintf " Stack: %s\n\n" (Ds.WasmContext.string_of_context_stack ())

let not_supported_msg = "We only support the test script with modules and assertions."

let msg_of = function
| Failure msg -> msg
| e -> Printexc.to_string e
  (* ^ " " *)
  (* ^ (String.split_on_char '\n' (Printexc.get_backtrace() ) |> List.filteri (fun i _ -> i < 2) |> String.concat "\n" ) *)

let try_run runner target =
  let start_time = Sys.time () in
  let result =
    try runner target
    with e -> Printf.eprintf "[Uncaught exception] %s, " (msg_of e); fail
  in
  result, Sys.time () -. start_time

let print_runner_results name results =
  let sum = List.fold_left (+) 0 in
  let sum_float = List.fold_left (+.) 0. in

  let l', l3 = List.split results in
  let l1, l2 = List.split l' in
  let num_success, total, execution_time = sum l1, sum l2, sum_float l3 in

  let percentage =
    if total = 0 then 100.
    else (float_of_int num_success /. float_of_int total) *. 100.
  in

  if name = "Total" then
    Printf.printf "Total [%d/%d] (%.2f%%)\n\n" num_success total percentage
  else
    Printf.printf "- %d/%d (%.2f%%)\n\n" num_success total percentage;
  Printf.eprintf "%s took %f ms.\n" name (execution_time *. 1000.)


(* string -> Script.script *)
let parse_wast file_path =
  let ic = open_in file_path in
  let lexbuf = Lexing.from_channel ic in

  let res =
    try Parse.parse file_path lexbuf Parse.Script
    with _ -> prerr_endline ("Failed to parse " ^ file_path); []
  in
  close_in ic; res

let is_long_test path =
  List.mem (Filename.basename path)
    [ "memory_copy.wast";
      "memory_fill.wast";
      "memory_grow.wast";
      "call_indirect.wast";
      "return_call.wast";
      "return_call_indirect.wast";
      "return_call_ref.wast"
    ]

(** End of helpers **)

let builtin () =

  (* TODO : Change this into host fnuction instance, instead of current normal function instance *)
  let create_funcinst (name, type_tags) =
    let winstr_tag = String.uppercase_ascii name in
    let code = singleton winstr_tag in
    let ptype = Array.map singleton type_tags in
    let arrow = TupV [ listV ptype; listV [||] ] in
    let ftype = CaseV ("FUNC", [ arrow ]) in
    let dt =
      CaseV ("DEF", [
        CaseV ("REC", [
          [| CaseV ("SUBD", [OptV (Some (singleton "FINAL")); listV [||]; ftype]) |] |> listV
        ]); numV 0L
      ]) in
    name, StrV [
      "TYPE", ref (if !Construct.version = 3 then dt else arrow);
      "MODULE", ref (StrV Record.empty); (* dummy module *)
      "CODE", ref (CaseV ("FUNC", [ ftype; listV [||]; listV [| code |] ]))
    ] in

  let create_globalinst t v = StrV [
    "TYPE", t |> ref;
    "VALUE", v |> ref
  ] in

  let create_tableinst t elems = StrV [
    "TYPE", t |> ref;
    "ELEM", elems |> ref
  ] in

  let create_meminst t bytes_ = StrV [
    "TYPE", t |> ref;
    "DATA", bytes_ |> ref
  ] in

  (* Builtin functions *)
  let funcs = List.rev [
    ("print", [||]) |> create_funcinst;
    ("print_i32", [| "I32" |]) |> create_funcinst;
    ("print_i64", [| "I64" |]) |> create_funcinst;
    ("print_f32", [| "F32" |]) |> create_funcinst;
    ("print_f64", [| "F64" |]) |> create_funcinst;
    ("print_i32_f32", [| "I32"; "F32" |]) |> create_funcinst;
    ("print_f64_f64", [| "F64"; "F64" |]) |> create_funcinst
  ] in
  (* Builtin globals *)
  let globals = List.rev [
    "global_i32", 666   |> I32.of_int_u |> Numerics.i32_to_const |> create_globalinst (TextV "global_type");
    "global_i64", 666   |> I64.of_int_u |> Numerics.i64_to_const |> create_globalinst (TextV "global_type");
    "global_f32", 666.6 |> F32.of_float |> Numerics.f32_to_const |> create_globalinst (TextV "global_type");
    "global_f64", 666.6 |> F64.of_float |> Numerics.f64_to_const |> create_globalinst (TextV "global_type");
  ] in
  (* Builtin tables *)
  let nulls = CaseV ("REF.NULL", [ singleton "FUNC" ]) |> Array.make 10 in
  let tables = [
    "table",
    listV nulls
    |> create_tableinst (TupV [ TupV [ numV 10L; numV 20L ]; singleton "FUNCREF" ]);
  ] in
  (* Builtin memories *)
  let zeros = numV 0L |> Array.make 0x10000 in
  let memories = [
    "memory",
    listV zeros
    |> create_meminst (CaseV ("I8", [ TupV [ numV 1L; numV 2L ] ]));
  ] in

  let append kind (name, inst) extern =

    (* Generate ExternFunc *)

    let addr =
      match Record.find kind !Ds.store with
      | ListV a -> Array.length !a |> Int64.of_int
      | _ -> failwith "Unreachable"
    in
    let new_extern =
      StrV [ "NAME", ref (TextV name); "VALUE", ref (CaseV (kind, [ numV addr ])) ]
    in

    (* Update Store *)

    (match Record.find kind !Ds.store with
    | ListV a -> a := Array.append !a [|inst|]
    | _ -> failwith "Invalid store field");

    new_extern :: extern in

  (* extern -> new_extern *)
  let func_extern = List.fold_right (append "FUNC") funcs in
  let global_extern = List.fold_right (append "GLOBAL") globals in
  let table_extern = List.fold_right (append "TABLE") tables in
  let memory_extern = List.fold_right (append "MEM") memories in

  let extern =
    []
    |> func_extern
    |> global_extern
    |> table_extern
    |> memory_extern
    |> Array.of_list in

  let moduleinst =
    Record.empty
    |> Record.add "FUNC" (listV [||])
    |> Record.add "GLOBAL" (listV [||])
    |> Record.add "TABLE" (listV [||])
    |> Record.add "MEM" (listV [||])
    |> Record.add "ELEM" (listV [||])
    |> Record.add "DATA" (listV [||])
    |> Record.add "EXPORT" (listV extern) in

  StrV moduleinst


module Register = Map.Make (String)
type register = value Register.t
let register: register ref = ref Register.empty

let latest = ""

let store_moduleinst module_name_opt moduleinst =
  register := Register.add latest moduleinst !register;
  match module_name_opt with
  | Some name -> register := Register.add name.it moduleinst !register
  | None -> ()

let module_name_of = function
  | Some name -> name.it
  | None -> latest
let find_moduleinst name = Register.find name !register

let get_export name moduleinst =
  moduleinst
  |> strv_access "EXPORT"
  |> listv_find
    (fun export -> al_to_string (strv_access "NAME" export) = name)

let get_externval import =
  let extern_name = al_to_string (casev_nth_arg 1 import) in

  import
  |> casev_nth_arg 0
  |> al_to_string
  |> find_moduleinst
  |> get_export extern_name
  |> strv_access "VALUE"


(* Check invocation result *)

let f32_pos_nan = F32.to_bits F32.pos_nan |> Int64.of_int32
let f32_neg_nan = F32.to_bits F32.neg_nan |> Int64.of_int32 |> Int64.logand 0x0000_0000_ffff_ffffL
let f64_pos_nan = F64.to_bits F64.pos_nan
let f64_neg_nan = F64.to_bits F64.neg_nan

let check_nanop no actual =
  match actual with
  | CaseV ("CONST", [CaseV (t, []); NumV bits]) ->
    begin match no.it with
    | Reference_interpreter.Value.F32 CanonicalNan ->
      t = "F32" && (bits = f32_pos_nan || bits = f32_neg_nan)
    | Reference_interpreter.Value.F64 CanonicalNan ->
      t = "F64" && (bits = f64_pos_nan || bits = f64_neg_nan)
    | Reference_interpreter.Value.F32 ArithmeticNan ->
      t = "F32" && Int64.logand bits f32_pos_nan = f32_pos_nan
    | Reference_interpreter.Value.F64 ArithmeticNan ->
      t = "F64" && Int64.logand bits f64_pos_nan = f64_pos_nan
    | _ -> failwith "NaN of int is not defined"
    end
  | _ -> false

let check_reftype expected = function
  | CaseV (tag, _) ->
    begin match expected, tag with
    | Types.AnyHT, "REF.FUNC_ADDR" -> false
    | Types.ExternHT, ref
    | Types.AnyHT, ref when String.starts_with ~prefix:"REF" ref -> true
    | Types.EqHT, ("REF.I31_NUM" | "REF.STRUCT_ADDR" | "REF.ARRAY_ADDR")
    | Types.I31HT, "REF.I31_NUM"
    | Types.StructHT, "REF.STRUCT_ADDR"
    | Types.ArrayHT, "REF.ARRAY_ADDR"
    | Types.FuncHT, "REF.FUNC_ADDR" -> true
    | _ -> false
    end
  | _ -> false

let check_null = function
  | CaseV ("REF.NULL", _) -> true
  | _ -> false

let check expected actual =
  match expected.it with
  | NumResult (NumPat n) -> Construct.al_of_num n.it = actual
  | NumResult (NanPat no) -> check_nanop no actual
  | RefResult (RefPat r) -> Construct.al_of_ref r.it = actual
  | RefResult (RefTypePat ht) -> check_reftype ht actual
  | RefResult NullPat -> check_null actual
  | VecResult (VecPat V128 (s, l)) -> (
    let lanes = match s with
    | V128.I8x16 () -> List.map (fun e -> e |> Value.I32Num.to_num |> Construct.al_of_num) (actual |> Construct.al_to_vec |> function | V128 v128 -> V128.I8x16.to_lanes v128)
    | V128.I16x8 () -> List.map (fun e -> e |> Value.I32Num.to_num |> Construct.al_of_num) (actual |> Construct.al_to_vec |> function | V128 v128 -> V128.I16x8.to_lanes v128)
    | V128.I32x4 () -> List.map (fun e -> e |> Value.I32Num.to_num |> Construct.al_of_num) (actual |> Construct.al_to_vec |> function | V128 v128 -> V128.I32x4.to_lanes v128)
    | V128.I64x2 () -> List.map (fun e -> e |> Value.I64Num.to_num |> Construct.al_of_num) (actual |> Construct.al_to_vec |> function | V128 v128 -> V128.I64x2.to_lanes v128)
    | V128.F32x4 () -> List.map (fun e -> e |> Value.F32Num.to_num |> Construct.al_of_num) (actual |> Construct.al_to_vec |> function | V128 v128 -> V128.F32x4.to_lanes v128)
    | V128.F64x2 () -> List.map (fun e -> e |> Value.F64Num.to_num |> Construct.al_of_num) (actual |> Construct.al_to_vec |> function | V128 v128 -> V128.F64x2.to_lanes v128)
    in

    List.for_all2 (fun nr l -> match nr with
    | NumPat n -> Construct.al_of_num n.it = l
    | NanPat no -> check_nanop no l) l lanes
  )

(* TODO: Refactor above codes *)

(** Main functions **)

let invoke module_name funcname args =
  Printf.eprintf "[Invoking %s %s...]\n" funcname (Value.string_of_values args);

  let funcaddr =
    module_name
    |> find_moduleinst
    |> get_export funcname
    |> strv_access "VALUE"
    |> casev_nth_arg 0
  in

  Interpreter.invoke [funcaddr; al_of_list al_of_value args]

let get_global_value module_name globalname =
  Printf.eprintf "[Getting %s...]\n" globalname;

  module_name
  |> find_moduleinst
  |> get_export globalname
  |> strv_access "VALUE"
  |> casev_nth_arg 0
  |> al_to_int
  |> listv_nth (Record.find "GLOBAL" !Ds.store)
  |> strv_access "VALUE"
  |> Array.make 1
  |> listV

let instantiate def =
  let module_ =
    match def.it with
    | Textual m -> m
    | Encoded (name, bs) -> Decode.decode name bs
    | Quoted (_, s) -> Parse.string_to_module s
  in
  (* Construct module and extern *)
  let al_module = al_of_module module_ in
  let externvals = al_module |> casev_nth_arg 1 |> listv_map get_externval in

  (* Instantiate and store exports *)
  Printf.eprintf "[Instantiating module...]\n";
  Interpreter.instantiate [ al_module ; externvals ]


(** Wast runner **)

let run_action action =
  match action.it with
  | Invoke (name_opt, funcname, args) ->
    invoke (module_name_of name_opt) (Utf8.encode funcname) (List.map it args)
  | Get (name_opt, globalname) ->
    get_global_value (module_name_of name_opt) (Utf8.encode globalname)

let test_assertion assertion =
  match assertion.it with
  | AssertReturn (action, expected) ->

    (* TODO: not unwrap ListV *)
    let result = run_action action in
    let actual = unwrap_listv_to_list result in

    assert (List.length actual = List.length expected);
    if List.for_all2 check expected actual then
      success
    else
      (* TODO: print fail message in check *)
      fail
  | AssertTrap (action, msg) -> (
    try
      action
      |> run_action
      |> Al.Print.string_of_value
      |> eprint_fail_log ("Trap due to " ^ msg);
      fail
    with Exception.Trap -> success
  )
  | AssertUninstantiable (def, _) -> (
    try
      ignore (instantiate def); fail
    with Exception.Trap -> success
  )
  (* ignore other kinds of assertions *)
  | _ -> pass

let run_cmd cmd =
  match cmd.it with
  | Module (module_name, def) ->
    def
    |> instantiate
    |> store_moduleinst module_name;
    success
  | Register (modulename, name_opt) ->
    let moduleinst = Register.find (module_name_of name_opt) !register in
    register := Register.add (Utf8.encode modulename) moduleinst !register;
    pass
  | Action a ->
    ignore (run_action a); success
  | Assertion a -> test_assertion a
  | Meta _ -> failwith not_supported_msg

let run_wast name script =
  (* Intialize builtin *)
  register := Register.add "spectest" (builtin ()) Register.empty;

  Printf.printf "===== %s =====\n%!" name;
  Printf.eprintf "===========================\n\n%s\n\n" name;

  if script = [] then (
    (* TODO: print appropriate message *)
    print_runner_results name []; []
  )
  else (
    let results = List.map (try_run run_cmd) script in
    print_runner_results name results; results
  )


(** Runner **)

let rec run_file path =
  if Sys.is_directory path then
    run_dir path
  else
    match Filename.extension path with
    | ".wast" ->
      if is_long_test path then
        run_wast path []
      else
        path |> parse_wast |> run_wast path
    | ".wat" -> failwith "TODO"
    | ".wasm" -> failwith "TODO"
    | _ -> []

and run_dir path =
  path
  |> Sys.readdir
  |> Array.to_list
  |> List.sort compare
  |> List.concat_map
    (fun filename -> run_file (Filename.concat path filename))


(** Entry **)
let run path =
  if Sys.file_exists path then (
    let results = run_file path in
    if Sys.is_directory path then print_runner_results "Total" results;
  )
  else failwith ("No such file: " ^ path)
