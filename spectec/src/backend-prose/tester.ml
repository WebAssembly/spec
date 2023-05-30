open Reference_interpreter
open Source
open Ast

(** flag **)
let test_name = ref ""

(** Helpers **)

let contains substring str =
  let regex = Str.regexp_string substring in
  try
    ignore (Str.search_forward regex str 0);
    true
  with Not_found ->
    false

type result =
  | Success
  | Fail
  | Ignore

let fail expected actual =
  Printf.eprintf " Fail!\n";
  Printf.eprintf " Expected: %s\n" expected;
  Printf.eprintf " Actual: %s\n\n" actual;
  let print_stack = false in
  if print_stack then
    Printf.eprintf " Stack: %s\n\n" (Print.string_of_stack !Interpreter.stack)

let not_supported_msg = "We only support the test script with modules and assertions."

let msg_of = function Failure msg -> msg | e -> Printexc.to_string e

(* string -> Script.script *)
let file_to_script file_name =
  let lexbuf = Lexing.from_channel (open_in file_name) in
  Parse.parse file_name lexbuf Parse.Script

let al_of_result result = match result.it with
  | Script.NumResult (Script.NumPat n) -> Construct.al_of_value (Values.Num n.it)
  | Script.RefResult (Script.RefPat r) -> Construct.al_of_value (Values.Ref r.it)
  | _ -> StringV "TODO"

(** End of helpers **)

let exports = ref []

let do_invoke act = match act.it with
  | Script.Invoke (None, name, literals) ->
    let extract_idx (export: Ast.export) = if export.it.name = name then
      match export.it.edesc.it with
      | FuncExport x -> Some (Al.IntV (Int32.to_int x.it))
      | _ -> None
    else
      None
    in
    let idx = List.find_map extract_idx !exports |> Option.get in
    let args = Al.ListV (
      literals
      |> List.map (fun (l: Script.literal) -> Construct.al_of_value l.it)
      |> Array.of_list
    ) in
    Interpreter.cnt := 0;
    Printf.eprintf "[Invoking %s...]\n%!" (string_of_name name);
    Interpreter.call_algo "invocation" [idx; args]
  | _ -> failwith "Currently, we only support calling function in the lastly defined module"

let test_assertion assertion =
  match assertion.it with
  | Script.AssertReturn (invoke, expected) ->
    let result = try do_invoke invoke with e -> StringV (msg_of e) in
    let expected_result = try Al.ListV(expected |> List.map al_of_result |> Array.of_list) with e -> StringV ("Failed during al_of_result: " ^ msg_of e) in
    if result <> expected_result then begin
      fail (Print.string_of_value expected_result) (Print.string_of_value result);
      Fail
    end else Success
  | Script.AssertTrap (invoke, _msg) ->
    begin try
      let result = do_invoke invoke in
      fail "Trap" (Print.string_of_value result);
      Fail
    with
      | Interpreter.Trap -> Success
      | e -> fail "Trap" (Printexc.to_string e); Fail
    end
  | _ -> Ignore (* ignore other kinds of assertions *)

(** Entry **)
let test file_name =

  let start_idx = String.rindex file_name '/' + 1 in
  let length = String.length file_name - start_idx in
  let name = String.sub file_name start_idx length in

  let total = ref 0 in
  let success = ref 0 in

  try

    Printf.eprintf "===========================\n\n%s\n\n" file_name;

    file_name
    |> file_to_script
    |> List.iter (fun cmd ->
      match cmd.it with
      | Script.Module (_, {it = Script.Textual m; _}) ->
        Interpreter.cnt := 0;
        exports := m.it.exports;
        Interpreter.stack := [];
        Interpreter.store := Al.Record.empty;
        ( try
          Interpreter.call_algo "instantiation" [ Construct.al_of_module m ] |> ignore
        with e -> "Module Instantiation failed due to " ^ msg_of e |> failwith )
      | Script.Module _ -> failwith "This test contains a binary module"
      | Script.Register _ -> failwith "This test contains a (register ...) command"
      | Script.Action a -> (try do_invoke a |> ignore with e -> "Direct invocation failed due to " ^ msg_of e |> failwith)
      | Script.Assertion a ->
          begin match test_assertion a with
            | Success ->
                total := !total + 1;
                success := !success + 1
            | Fail ->
                total := !total + 1
            | Ignore -> ()
          end
      | Script.Meta _ -> failwith not_supported_msg
    );
    if !total <> 0 then
      let percentage = (float_of_int !success /. float_of_int !total) *. 100. in
      Printf.sprintf "%s: [%d/%d] (%.2f%%)" name !success !total percentage |> print_endline;
      (!success, !total, percentage)
    else
      (0, 0, 0.)
  with
  | e ->
    let msg = msg_of e in
    Printf.eprintf "[Uncaught exception] %s\n" msg;
    Printf.sprintf
      "%s: [Uncaught exception in %dth assertion: %s]"
      name
      !total
      msg
      |> print_endline;
    if !total <> 0 then
      let percentage = (float_of_int !success /. float_of_int !total) *. 100. in
      (!success, !total, percentage)
    else
      (0, 0, 0.)

let test_all root =
  let sample = test (Filename.concat root "test-prose/sample.wast") in

  let f filename = if contains !test_name filename then
    test (Filename.concat root ("test-prose/spec-test/" ^ filename))
  else
    (0, 0, 0.)
  in

  let tests = Sys.readdir (Filename.concat root "test-prose/spec-test") in
  let results = Array.append [| sample |] (Array.map f tests) in

  let success, total, percentage, count = Array.fold_left 
    (fun acc result -> 
      let (success_acc, total_acc, percentage_acc, count_acc) = acc in
      let (success, total, percentage) = result in
      if (total <> 0) then 
        (success_acc + success, total_acc + total, percentage_acc +. percentage, count_acc + 1)
      else
        acc)
    (0, 0, 0., 0) results
  in
  let percentage_norm = percentage /. float_of_int count in
  let percentage = (float_of_int success /. float_of_int total) *. 100. in 

  Printf.sprintf "Total [%d/%d] (%.2f%%; Normalized %.2f%%)" success total percentage percentage_norm |> print_endline
