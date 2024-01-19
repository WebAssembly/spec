open Reference_interpreter
open Script
open Source
open Al.Al_util
open Construct
open Util.Record
open Ds

(* Result *)

let success = 1, 1
let fail = 0, 1
let pass = 0, 0

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

let try_run runner target =
  let start_time = Sys.time () in
  let result =
    try
      runner target
    with e ->
      prerr_endline (Printexc.to_string e); fail
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
  | Quoted (_, s) -> Parse.string_to_module s

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
    Run.assert_result no_region result (List.map it expected);
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

let run_command command =
  match command.it with
  | Module (module_name, def) ->
    def
    |> module_of_def
    |> instantiate
    |> Register.add_with_var module_name;
    success
  | Register (modulename, var_opt) ->
    let moduleinst = Register.find (Register.get_module_name var_opt) in
    Register.add (Utf8.encode modulename) moduleinst;
    pass
  | Action a ->
    ignore (run_action a); success
  | Assertion a -> test_assertion a
  | Meta _ -> pass

let run_wast name script =
  (* Intialize builtin *)
  Register.add "spectest" (Builtin.builtin ());

  Printf.printf "===== %s =====\n%!" name;
  Printf.eprintf "===========================\n\n%s\n\n" name;

  let results = List.map (try_run run_command) script in
  print_runner_results name results; results

let parse_wast file_path =
  let ic = open_in file_path in
  let lexbuf = Lexing.from_channel ic in

  let res =
    try
      Parse.parse file_path lexbuf Parse.Script
    with _ ->
      prerr_endline ("Failed to parse " ^ file_path); []
  in
  close_in ic; res


(** Runner **)

let rec run_file path =
  if Sys.is_directory path then
    run_dir path
  else
    match Filename.extension path with
    | ".wast" ->
      if is_long_test path then
        (* Exclude long test *)
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
