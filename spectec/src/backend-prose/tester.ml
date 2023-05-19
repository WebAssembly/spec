open Reference_interpreter

(** Helpers **)

(* string -> Script.script *)
let file_to_script file_name =
  (* TODO: Better file resolving *)
  let lexbuf = try
    Lexing.from_channel (open_in file_name)
  with
    | _ -> Lexing.from_channel (open_in ("../" ^ file_name))
  in
  Parse.parse file_name lexbuf Parse.Script

let not_supported = "We only support the test script with module in the first entry, and assertions in rest entries."

let al_of_result (result: Script.result) = match result.it with
  | Script.NumResult (Script.NumPat n) -> Construct.al_of_wasm_value (Values.Num n.it)
  | Script.RefResult (Script.RefPat r) -> Construct.al_of_wasm_value (Values.Ref r.it)
  | _ -> failwith "not supported"

(** End of helpers **)

let do_invoke m (i: Script.action) = match i.it with
  | Script.Invoke (_, name, literals) ->
    let _f_name = Ast.string_of_name name in
    let idx = ignore m; Al.IntV 0 in (* TODO *)
    let args = Al.ListV (
      literals
      |> List.map (fun (l: Script.literal) -> Construct.al_of_wasm_value l.it)
      |> Array.of_list
    ) in
    Interpreter.call_algo "invocation" [idx; args] |> snd
  | _ -> failwith not_supported

let test_assertion m (a: Script.assertion) =
  match a.it with
  | Script.AssertReturn (invoke, expected) ->
    let expected_result = Al.ListV(expected |> List.map al_of_result |> Array.of_list) in
    let result = do_invoke m invoke in
    if result = expected_result then
      print_endline "ok"
    else begin
      Print.string_of_stack !Interpreter.stack |> print_endline;
      "Expected: " ^ Print.string_of_value expected_result |> print_endline;
      "Actual: " ^ Print.string_of_value result |> print_endline;
      print_endline "fail"
    end
  | Script.AssertTrap (invoke, _msg) ->
    begin try
      let _ = do_invoke m invoke in
      print_endline "fail"
    with
      | _ -> print_endline "ok"
    end
  | _ -> failwith not_supported

(** Entry **)
let test file_name =
  let script = file_to_script file_name in
  match script with
  | {it = Script.Module (_, {it = Script.Textual m; _}); _} :: asserts ->
    Interpreter.stack := [];
    Testdata.store := Al.Record.empty;
    Interpreter.call_algo "instantiation" [ Construct.al_of_wasm_module m ] |> ignore;
    List.iter (fun (cmd: Script.command) -> match cmd.it with
      | Script.Assertion a -> test_assertion m a
      | _ -> failwith not_supported
    ) asserts;
  | _ -> failwith not_supported
