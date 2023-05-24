open Reference_interpreter
open Source
open Ast

(** Helpers **)

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

(* string -> Script.script *)
let file_to_script file_name =
  let lexbuf = Lexing.from_channel (open_in file_name) in
  Parse.parse file_name lexbuf Parse.Script

let not_supported = "We only support the test script with modules and assertions."

let al_of_result result = match result.it with
  | Script.NumResult (Script.NumPat n) -> Construct.al_of_value (Values.Num n.it)
  | Script.RefResult (Script.RefPat r) -> Construct.al_of_value (Values.Ref r.it)
  | _ -> failwith "not supported"

(** End of helpers **)

let exports = ref []

let do_invoke act = match act.it with
  | Script.Invoke (_, name, literals) ->
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
    Printf.eprintf "[Invoking %s...]\n" (string_of_name name);
    Interpreter.call_algo "invocation" [idx; args]
  | _ -> failwith not_supported

let test_assertion assertion =
  match assertion.it with
  | Script.AssertReturn (invoke, expected) ->
    let result = try do_invoke invoke with e -> StringV (Printexc.to_string e) in
    let expected_result = Al.ListV(expected |> List.map al_of_result |> Array.of_list) in
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

    Printf.eprintf "****************\n\n%s\n\n" file_name;

    file_name
    |> file_to_script
    |> List.iter (fun cmd ->
      match cmd.it with
      | Script.Module (_, {it = Script.Textual m; _}) ->
        exports := m.it.exports;
        Interpreter.stack := [];
        Interpreter.store := Al.Record.empty;
        Interpreter.call_algo "instantiation" [ Construct.al_of_module m ] |> ignore;
      | Script.Assertion a ->
          begin match test_assertion a with
            | Success ->
                total := !total + 1;
                success := !success + 1
            | Fail ->
                total := !total + 1
            | Ignore -> ()
          end
      | Action a -> do_invoke a |> ignore
      | _ -> failwith not_supported
    );
    if !total <> 0 then
      Printf.sprintf "%s: [%d/%d]" name !success !total |> print_endline
  with e ->
    Printexc.to_string e
    |> Printf.eprintf "[Uncaught exception] %s\n";
    Printf.sprintf
      "%s: [Uncaught exception in %dth assertion]"
      name
      !total
    |> print_endline


let test_all root =
  test (Filename.concat root "test-prose/sample.wast");

  let f filename = test (Filename.concat root ("test-prose/spec-test/" ^ filename)) in

  Sys.readdir (Filename.concat root "test-prose/spec-test") |> Array.iter f
