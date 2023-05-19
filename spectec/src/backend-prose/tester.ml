open Reference_interpreter

(** Helpers **)

(* string -> Script.script *)
let file_to_script file_name =
  let lexbuf = Lexing.from_channel (open_in file_name) in
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
    begin try
      Interpreter.call_algo "invocation" [idx; args] |> snd
    with
      _ -> print_endline "invocation failed"; StringV "Fail"
    end
  | _ -> failwith not_supported

let test_assertion m (a: Script.assertion) =
  match a.it with
  | Script.AssertReturn (invoke, expected_result) ->
    let result = do_invoke m invoke in
    if result = ListV(expected_result |> List.map al_of_result |> Array.of_list) then
      print_endline "ok"
    else
      Print.string_of_stack !Interpreter.stack |> print_endline;
      Print.string_of_value result |> print_endline;
      print_endline "fail"
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
    begin try
      Interpreter.stack := [];
      Testdata.store := Al.Record.empty;
      Interpreter.call_algo "instantiation" [ Construct.al_of_wasm_module m ] |> ignore;
    with
      _ -> print_endline "instantiation faield"
    end;
    List.iter (fun (cmd: Script.command) -> match cmd.it with
      | Script.Assertion a -> test_assertion m a
      | _ -> failwith not_supported
    ) asserts;
  | _ -> failwith not_supported
