open Reference_interpreter
open Script
open Source
open Al.Al_util
open Construct
open Util
open Ds


(* Errors *)

module Assert = Reference_interpreter.Error.Make ()
let _error_interpret at msg = Error.error at "interpreter" msg

(* Logging *)

let logging = ref false

let log fmt = Printf.(if !logging then fprintf stderr fmt else ifprintf stderr fmt)

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
    with
    | Exception.Error (at, msg, step) ->
      let msg' = msg ^ " (interpreting " ^ step ^ " at " ^ Source.string_of_region at ^ ")" in
      (* error_interpret at msg' *)
      prerr_endline msg';
      fail
    | Exception.Invalid (e, _) ->
      let msg = "validation failure (" ^ Printexc.to_string e ^ ")" in
      prerr_endline msg;
      fail
    | e ->
      prerr_endline (Printexc.to_string e);
      fail
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
  log "%s took %f ms.\n" name (execution_time *. 1000.)

let get_export name modulename =
  modulename
  |> Register.find
  |> strv_access "EXPORTS"
  |> listv_find
    (fun export -> al_to_string (strv_access "NAME" export) = name)

let get_externaddr import =
  import.it.module_name
  |> Utf8.encode
  |> get_export (Utf8.encode import.it.Ast.item_name)
  |> strv_access "ADDR"

let textual_to_module textual =
  match (snd textual).it with
  | Script.Textual (m, _) -> m
  | _ -> assert false

let get_export_addr name modulename =
  let vl =
    modulename
    |> get_export name
    |> strv_access "ADDR"
    |> args_of_casev
  in
  try List.hd vl with Failure _ ->
    failwith ("Function export doesn't contain function address")

(** Main functions **)

let invoke module_name funcname args =
  log "[Invoking %s %s...]\n" funcname (Value.string_of_values args);

  let funcaddr = get_export_addr funcname module_name in
  Interpreter.invoke [funcaddr; al_of_list al_of_value args]


let get_global_value module_name globalname =
  log "[Getting %s...]\n" globalname;

  let index = get_export_addr globalname module_name in
  index
  |> al_to_int
  |> listv_nth (Store.access "GLOBALS")
  |> strv_access "VALUE"
  |> Array.make 1
  |> listV

let instantiate module_ =
  log "[Instantiating module...]\n";

  match al_of_module module_, List.map get_externaddr module_.it.imports with
  | exception exn -> raise (Exception.Invalid (exn, Printexc.get_raw_backtrace ()))
  | al_module, externaddrs ->
    Interpreter.instantiate [ al_module; listV_of_list externaddrs ]


(** Wast runner **)

let module_of_def def =
  match def.it with
  | Textual (m, _) -> m
  | Encoded (name, bs) -> Decode.decode name bs.it
  | Quoted (_, s) -> Parse.Module.parse_string s.it |> textual_to_module

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
    Run.assert_results no_region result expected;
    success
  | AssertTrap (action, re) -> (
    try
      let result = run_action action in
      Run.assert_message assertion.at "runtime" (Al.Print.string_of_value result) re;
      fail
    with Exception.Trap -> success
  )
  | AssertUninstantiable (var_opt, re) -> (
    try
      Modules.find (Modules.get_module_name var_opt) |> instantiate |> ignore;
      Run.assert_message assertion.at "instantiation" "module instance" re;
      fail
    with Exception.Trap -> success
  )
  | AssertException action ->
    (match run_action action with
    | exception Exception.Throw -> success
    | _ -> Assert.error assertion.at "expected exception"
    )
  | AssertInvalid (def, re) when !Construct.version = 3 ->
    (match def |> module_of_def |> instantiate |> ignore with
    | exception Exception.Invalid _ -> success
    | _ ->
      Run.assert_message assertion.at "validation" "module instance" re;
      fail
    )
  | AssertInvalidCustom (def, re) when !Construct.version = 3 ->
    (match def |> module_of_def |> instantiate |> ignore with
    | exception Exception.Invalid _ -> success
    | _ ->
      Run.assert_message assertion.at "validation" "module instance" re;
      fail
    )
  (* ignore other kinds of assertions *)
  | _ -> pass

let run_command' command =
  match command.it with
  | Module (var_opt, def) ->
    def
    |> module_of_def
    |> Modules.add_with_var var_opt;
    success
  | Instance (var1_opt, var2_opt) ->
    Modules.find (Modules.get_module_name var2_opt)
    |> instantiate
    |> Register.add_with_var var1_opt;
    success
  | Register (modulename, var_opt) ->
    let moduleinst = Register.find (Register.get_module_name var_opt) in
    Register.add (Utf8.encode modulename) moduleinst;
    pass
  | Action a ->
    ignore (run_action a); success
  | Assertion a -> test_assertion a
  | Meta _ -> pass

let run_command command =
  let start_time = Sys.time () in
  let result =
    try
      run_command' command
    with
    | Exception.Error (at, msg, step) ->
      let msg' = msg ^ " (interpreting " ^ step ^ " at " ^ Source.string_of_region at ^ ")" in
      command.at |> string_of_region |> print_endline;
      (* error_interpret at msg' *)
      print_endline ("- Test failed at " ^ string_of_region command.at ^
        " (" ^ msg' ^ ")");
      fail
    | Exception.Invalid (e, backtrace) ->
      print_endline ("- Test failed at " ^ string_of_region command.at ^
        " (" ^ Printexc.to_string e ^ ")");
      Printexc.print_raw_backtrace stdout backtrace;
      fail
    | e ->
      print_endline ("- Test failed at " ^ string_of_region command.at ^
        " (" ^ Printexc.to_string e ^ ")");
      Printexc.print_backtrace stdout;
      fail
  in
  result, Sys.time () -. start_time

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
  log "===========================\n\n%s\n\n" name;

  try
    parser_ file
  with e ->
    let bt = Printexc.get_raw_backtrace () in
    print_endline ("- Failed to parse " ^ name ^ "\n");
    log ("- Failed to parse %s\n") name;
    num_parse_fail := !num_parse_fail + 1;
    Printexc.raise_with_backtrace e bt


(** Runner **)

let rec run_file path args =
  if Sys.is_directory path then
    run_dir path
  else try
    (* Check file extension *)
    match Filename.extension path with
    | ".wast" ->
      path
      |> parse_file path Parse.Script.parse_file
      |> run_wast path
    | ".wat" ->
      path
      |> parse_file path Parse.Module.parse_file
      |> textual_to_module
      |> run_wat args
    | ".wasm" ->
      In_channel.with_open_bin path In_channel.input_all
      |> parse_file path (Decode.decode path)
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
