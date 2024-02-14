open Reference_interpreter
open Script
open Source
open Al.Al_util
open Construct
open Util
open Ds

(* Result *)

let success = 1, 1
let fail = 0, 1
let pass = 0, 0

let num_parse_fail = ref 0

(* Excluded test files *)

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


(* Helper functions *)

let sum = List.fold_left (+) 0
let sum_float = List.fold_left (+.) 0.

let sum_results l =
  let l1, l2 = List.split l in
  sum l1, sum l2
let sum_results_with_time l =
  let l', times = List.split l in
  sum_results l', sum_float times

let try_run runner target =
  let start_time = Sys.time () in
  let result =
    try
      runner target
    with e ->
      prerr_endline (Printexc.to_string e); fail
  in
  result, Sys.time () -. start_time

let print_runner_result name result =
  let (num_success, total), execution_time = result in
  let percentage =
    if total = 0 then 100.
    else (float_of_int num_success /. float_of_int total) *. 100.
  in

  if name = "Total" then
    Printf.printf "Total [%d/%d] (%.2f%%)\n\n" num_success total percentage
  else
    Printf.printf "- %d/%d (%.2f%%)\n\n" num_success total percentage;
  Printf.eprintf "%s took %f ms.\n" name (execution_time *. 1000.)

let get_export name modulename =
  modulename
  |> Register.find
  |> strv_access "EXPORT"
  |> listv_find
    (fun export -> al_to_string (strv_access "NAME" export) = name)

let get_externval import =
  import.it.module_name
  |> Utf8.encode
  |> get_export (Utf8.encode import.it.Ast.item_name)
  |> strv_access "VALUE"

let textual_to_module textual =
  match (snd textual).it with
  | Script.Textual m -> m
  | _ -> assert false


(** Main functions **)

let invoke module_name funcname args =
  Printf.eprintf "[Invoking %s %s...]\n" funcname (Value.string_of_values args);

  let funcaddr =
    module_name
    |> get_export funcname
    |> strv_access "VALUE"
    |> casev_nth_arg 0
  in

  Interpreter.invoke [funcaddr; al_of_list al_of_value args]

let get_global_value module_name globalname =
  Printf.eprintf "[Getting %s...]\n" globalname;

  module_name
  |> get_export globalname
  |> strv_access "VALUE"
  |> casev_nth_arg 0
  |> al_to_int
  |> listv_nth (Record.find "GLOBAL" (get_store ()))
  |> strv_access "VALUE"
  |> Array.make 1
  |> listV

let instantiate module_ =
  Printf.eprintf "[Instantiating module...]\n";

  let al_module = al_of_module module_ in
  let externvals = List.map get_externval module_.it.imports in

  Interpreter.instantiate [ al_module; listV_of_list externvals ]


(** Wast runner **)

let module_of_def def =
  match def.it with
  | Textual m -> m
  | Encoded (name, bs) -> Decode.decode name bs
  | Quoted (_, s) -> Parse.Module.parse_string s |> textual_to_module

let run_action action =
  match action.it with
  | Invoke (var_opt, funcname, args) ->
    invoke (Register.get_module_name var_opt) (Utf8.encode funcname) (List.map it args)
  | Get (var_opt, globalname) ->
    get_global_value (Register.get_module_name var_opt) (Utf8.encode globalname)

let test_assertion assertion =
  match assertion.it with
  | AssertReturn (action, expected) ->
    let result = run_action action |> al_to_list al_to_value in
    Run.assert_result no_region result expected;
    success
  | AssertTrap (action, re) -> (
    try
      let result = run_action action in
      Run.assert_message assertion.at "runtime" (Al.Print.string_of_value result) re;
      fail
    with Exception.Trap -> success
  )
  | AssertUninstantiable (def, re) -> (
    try
      def |> module_of_def |> instantiate |> ignore;
      Run.assert_message assertion.at "instantiation" "module instance" re;
      fail
    with Exception.Trap -> success
  )
  (* ignore other kinds of assertions *)
  | _ -> pass

let run_command' command =
  match command.it with
  | Module (var_opt, def) ->
    def
    |> module_of_def
    |> instantiate
    |> Register.add_with_var var_opt;
    success
  | Register (modulename, var_opt) ->
    let moduleinst = Register.find (Register.get_module_name var_opt) in
    Register.add (Utf8.encode modulename) moduleinst;
    pass
  | Action a ->
    ignore (run_action a); success
  | Assertion a -> test_assertion a
  | Meta _ -> pass
let run_command = try_run run_command'

let run_wast name script =
  let script =
    (* Exclude long test *)
    if is_long_test name then []
    else script
  in

  (* Intialize builtin *)
  Register.add "spectest" (Builtin.builtin ());

  let result =
    script
    |> List.map run_command
    |> sum_results_with_time
  in
  print_runner_result name result; result


(** Wasm runner **)

let run_wasm' args module_ =
  (* Intialize builtin *)
  Register.add "spectest" (Builtin.builtin ());

  (* Instantiate *)
  module_
  |> instantiate
  |> Register.add_with_var None;

  (* TODO: Only Int32 arguments/results are acceptable *)
  match args with
  | funcname :: args' ->
    let make_value s = Value.Num (I32 (Int32.of_string s)) in

    (* Invoke *)
    invoke (Register.get_module_name None) funcname (List.map make_value args')
    (* Print invocation result *)
    |> al_to_list al_to_value
    |> Value.string_of_values
    |> print_endline;
    success
  | [] -> success
let run_wasm args = try_run (run_wasm' args)


(* Wat runner *)

let run_wat = run_wasm


(** Parse **)

let parse_file name parser_ file =
  Printf.printf "===== %s =====\n%!" name;
  Printf.eprintf "===========================\n\n%s\n\n" name;

  try
    parser_ file
  with e ->
    print_endline ("- Failed to parse " ^ name ^ "\n");
    prerr_endline ("- Failed to parse " ^ name ^ "\n");
    num_parse_fail := !num_parse_fail + 1;
    raise e


(** Runner **)

let rec run_file path args =
  if Sys.is_directory path then
    run_dir path
  else try
    (* Read file *)
    let file = In_channel.with_open_bin path In_channel.input_all in

    (* Check file extension *)
    match Filename.extension path with
    | ".wast" ->
      file
      |> parse_file path Parse.Script.parse_string
      |> run_wast path
    | ".wat" ->
      file
      |> parse_file path Parse.Module.parse_string
      |> textual_to_module
      |> run_wat args
    | ".wasm" ->
      file
      |> parse_file path (Decode.decode "wasm module")
      |> run_wasm args
    | _ -> pass, 0.
  with Decode.Code _ | Parse.Syntax _ -> pass, 0.

and run_dir path =
  path
  |> Sys.readdir
  |> Array.to_list
  |> List.sort compare
  |> List.map (fun filename -> run_file (Filename.concat path filename) [])
  |> sum_results_with_time


(** Entry **)
let run = function
  | path :: args when Sys.file_exists path ->
    (* Run file *)
    let result = run_file path args in

    (* Print result *)
    if Sys.is_directory path then (
      if !num_parse_fail <> 0 then
        print_endline ((string_of_int !num_parse_fail) ^ " parsing fail");
      print_runner_result "Total" result;
    )
  | _ -> failwith "Cannot find file to run"
