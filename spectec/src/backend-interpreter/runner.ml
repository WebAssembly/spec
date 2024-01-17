open Reference_interpreter
open Script
open Al.Ast
open Construct
open Source
open Util.Record

(** Helpers **)

type result =
  | Success
  | Fail
  | Ignore

let success = 1, 1
let failure = 0, 1
let pass = 0, 0

let fail expected actual =
  Printf.eprintf " Fail!\n";
  Printf.eprintf " Expected: %s\n" expected;
  Printf.eprintf " Actual  : %s\n\n" actual;
  let print_stack = false in
  if print_stack then
    Printf.eprintf " Stack: %s\n\n" (Ds.WasmContext.string_of_context_stack ());
  Fail

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
    with e -> Printf.eprintf "[Uncaught exception] %s, " (msg_of e); failure
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

module Register = Map.Make (String)
type register = value Register.t
let register: register ref = ref Register.empty

let builtin () =

  (* TODO : Change this into host fnuction instance, instead of current normal function instance *)
  let create_func_inst (name, type_tags) =
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

  let create_global_inst t v = StrV [
    "TYPE", t |> ref;
    "VALUE", v |> ref
  ] in

  let create_table_inst t elems = StrV [
    "TYPE", t |> ref;
    "ELEM", elems |> ref
  ] in

  let create_mem_inst t bytes_ = StrV [
    "TYPE", t |> ref;
    "DATA", bytes_ |> ref
  ] in

  (* Builtin functions *)
  let funcs = List.rev [
    ("print", [||]) |> create_func_inst;
    ("print_i32", [| "I32" |]) |> create_func_inst;
    ("print_i64", [| "I64" |]) |> create_func_inst;
    ("print_f32", [| "F32" |]) |> create_func_inst;
    ("print_f64", [| "F64" |]) |> create_func_inst;
    ("print_i32_f32", [| "I32"; "F32" |]) |> create_func_inst;
    ("print_f64_f64", [| "F64"; "F64" |]) |> create_func_inst
  ] in
  (* Builtin globals *)
  let globals = List.rev [
    "global_i32", 666   |> I32.of_int_u |> Numerics.i32_to_const |> create_global_inst (TextV "global_type");
    "global_i64", 666   |> I64.of_int_u |> Numerics.i64_to_const |> create_global_inst (TextV "global_type");
    "global_f32", 666.6 |> F32.of_float |> Numerics.f32_to_const |> create_global_inst (TextV "global_type");
    "global_f64", 666.6 |> F64.of_float |> Numerics.f64_to_const |> create_global_inst (TextV "global_type");
  ] in
  (* Builtin tables *)
  let nulls = CaseV ("REF.NULL", [ singleton "FUNC" ]) |> Array.make 10 in
  let tables = [
    "table",
    listV nulls
    |> create_table_inst (TupV [ TupV [ numV 10L; numV 20L ]; singleton "FUNCREF" ]);
  ] in
  (* Builtin memories *)
  let zeros = numV 0L |> Array.make 0x10000 in
  let memories = [
    "memory",
    listV zeros
    |> create_mem_inst (CaseV ("I8", [ TupV [ numV 1L; numV 2L ] ]));
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

  let module_inst =
    Record.empty
    |> Record.add "FUNC" (listV [||])
    |> Record.add "GLOBAL" (listV [||])
    |> Record.add "TABLE" (listV [||])
    |> Record.add "MEM" (listV [||])
    |> Record.add "ELEM" (listV [||])
    |> Record.add "DATA" (listV [||])
    |> Record.add "EXPORT" (listV extern) in

  StrV module_inst


let latest = ""
let get_module_name = function
  | Some name -> name.it
  | None -> latest
let find_module_inst name = Register.find name !register
let find_export name =
    match find_module_inst name with
    | StrV r ->
        begin match Record.find "EXPORT" r with
        | ListV exs -> !exs
        | _ -> failwith "Invaild module inst"
        end
    | _ -> failwith "Invalid module inst"

let extract_addr_of tag name (export: value) =
  match export with
  | StrV [ "NAME", { contents = TextV (export_name) }; "VALUE", { contents = CaseV (export_tag, [ addr ]) } ]
    when export_name = Utf8.encode name && export_tag = tag -> Some (addr)
  | _ -> None

let do_action act = match act.it with
  | Invoke (module_name_opt, name, literals) ->
    let module_name = get_module_name module_name_opt in
    let module_inst = find_module_inst module_name in
    let export_insts = match module_inst with
    | StrV r ->
        begin match Record.find "EXPORT" r with
        | ListV exs -> !exs
        | _ -> failwith "Invaild module inst"
        end
    | _ -> failwith "Invalid module inst"
    in

    let funcaddr = Array.find_map (extract_addr_of "FUNC" name) export_insts |> Option.get in

    let args = 
      literals
      |> List.map (fun (l: Script.literal) -> Construct.al_of_value l.it)
      |> listV_of_list
    in
    Printf.eprintf "[Invoking %s %s...]\n" (Utf8.encode name) (Al.Print.string_of_value args);

    Interpreter.invoke [funcaddr; args]
  | Get (module_name_opt, name) ->
    let module_name = get_module_name module_name_opt in
    let exports = find_export module_name in

    let addr = Array.find_map (extract_addr_of "GLOBAL" name) exports |> Option.get in
    let globals = (Record.find "GLOBAL" !Ds.store) in

    Printf.eprintf "[Getting %s...]\n" (Utf8.encode name);
    let got =
      match Array.get (unwrap_listv_to_array globals) (al_to_int addr) with
      | StrV r -> Record.find "VALUE" r
      | _ -> failwith "Not a Record"
    in
    listV [| got |]



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

let get_externval = function
  | CaseV ("IMPORT", [ TextV import_module_name; TextV extern_name; _ty ]) ->

      let export = find_export import_module_name in

      (* Get extern *)
      let is_matching_export export =
        match export with
        | StrV [ "NAME", { contents = TextV export_name }; "VALUE", value ]
          when export_name = extern_name -> Some !value
        | _ -> None
      in
      Array.find_map is_matching_export export |> Option.get
  | v ->
    Al.Print.string_of_value v
    |> Printf.sprintf "Invalid import: %s"
    |> failwith

let get_externvals = function
  | CaseV ("MODULE", _ :: (ListV imports) :: _) ->
      Array.map get_externval !imports |> listV
  | _ -> failwith "Invalid module"

let extract_module def = match def.it with
  | Textual m -> m
  | Encoded (name, bs) ->
    Decode.decode name bs
  | Quoted (_, s) ->
    Parse.string_to_module s

let test_assertion assertion =
  match assertion.it with
  | AssertReturn (invoke, expected) ->

    let fail_with =
      List.map (fun r -> r.it) expected
      |> Run.string_of_results
      |> fail
    in

    begin try
      (* Invoke *)
      match do_action invoke with
      | ListV arr ->
        let actual = !arr in
        assert (Array.length actual = List.length expected);
        if Array.to_list actual |> List.for_all2 check expected then
          Success
        else
          listV actual |> Al.Print.string_of_value |> fail_with
      | v ->
        Al.Print.string_of_value v
        |> Printf.sprintf "Invalid result: %s"
        |> failwith
    with e -> msg_of e |> fail_with
    end
  | AssertTrap (invoke, msg) ->
    let expected = "Trap due to " ^ msg in
    begin try
      let result = do_action invoke in
      fail expected (Al.Print.string_of_value result)
    with
      | Exception.Trap -> Success
      | e -> fail expected (Printexc.to_string e)
    end
  | AssertUninstantiable (def, msg) ->
    let expected = "Module instantiation failure due to " ^ msg in
    begin try
      let al_module = Construct.al_of_module (extract_module def) in
      let externvals = get_externvals al_module in
      Printf.eprintf "[Trying instantiating module...]\n";
      Interpreter.instantiate [ al_module ; externvals ] |> ignore;

      fail expected"Module instantiation success"
    with
      | Exception.Trap -> Success
      | e -> fail expected (Printexc.to_string e)
    end
  | _ -> Ignore (* ignore other kinds of assertions *)

let test_module module_name m =

  (* Initialize *)

  try

    (* Construct module and extern *)
    let al_module = Construct.al_of_module m in
    let externvals = get_externvals al_module in

    (* Instantiate and store exports *)
    Printf.eprintf "[Instantiating module...]\n";
    let module_inst = Interpreter.instantiate [ al_module ; externvals ] in

    (* Store module instance in the register *)
    (match module_name with
    | Some name ->
        register := Register.add name.it module_inst !register
    | None -> ());
    register := Register.add latest module_inst !register;
  with e -> "Module Instantiation failed due to " ^ msg_of e |> failwith

let test_cmd cmd =
  match cmd.it with
  | Module (module_name, def) ->
    test_module module_name (extract_module def);
    success
  | Register (name, module_name_opt) ->
    let s = Utf8.encode name in
    let module_name = match module_name_opt with
      | Some s -> s.it
      | None -> latest
    in
    let module_inst = find_module_inst module_name in
    register := Register.add s module_inst !register;
    pass
  | Action a -> (
    try
      ignore (do_action a);
      success
    with e -> "Direct invocation failed due to " ^ msg_of e |> failwith
  )
  | Assertion a -> (
    match test_assertion a with
    | Success -> success
    | _ -> failure
  )
  | Meta _ -> failwith not_supported_msg

(* Intialize store and registered modules *)
let init_tester () =
  register := Register.add "spectest" (builtin ()) Register.empty

let run_wast name script =
  init_tester ();

  Printf.printf "===== %s =====\n%!" name;
  Printf.eprintf "===========================\n\n%s\n\n" name;

  if script = [] then (
    (* TODO: print appropriate message *)
    print_runner_results name []; []
  )
  else (
    let results = List.map (try_run test_cmd) script in
    print_runner_results name results; results
  )

let is_target cmd =
  match cmd.it with
  | Assertion { it = AssertReturn _; _ }
  | Assertion { it = AssertTrap _; _ }
  | Assertion { it = AssertUninstantiable _; _ }
  | Module _ | Action _ | Register _ -> true
  | _ -> false

let rec run_file path =
  if Sys.is_directory path then
    run_dir path
  else
    match Filename.extension path with
    | ".wast" ->
      if is_long_test path then
        run_wast path []
      else
        path
        |> parse_wast
        |> List.filter is_target
        |> run_wast path
    | ".wat" -> failwith "hi"
    | ".wasm" -> failwith "hi"
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
