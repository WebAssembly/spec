open Reference_interpreter
open Source
open Ast

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

let al_of_result result = match result.it with
  | Script.NumResult (Script.NumPat n) -> Construct.al_of_wasm_value (Values.Num n.it)
  | Script.RefResult (Script.RefPat r) -> Construct.al_of_wasm_value (Values.Ref r.it)
  | _ -> failwith "not supported"

(** End of helpers **)

let do_invoke m act = match act.it with
  | Script.Invoke (_, name, literals) ->
    let extract_idx (export: Ast.export) = if export.it.name = name then
      match export.it.edesc.it with
      | FuncExport x -> Some (Al.IntV (Int32.to_int x.it))
      | _ -> None
    else
      None
    in
    let idx = List.find_map extract_idx m.it.exports |> Option.get in
    let args = Al.ListV (
      literals
      |> List.map (fun (l: Script.literal) -> Construct.al_of_wasm_value l.it)
      |> Array.of_list
    ) in
    print_endline ("[Invoking " ^ string_of_name name ^ "...]");
    Interpreter.call_algo "invocation" [idx; args]
  | _ -> failwith not_supported

let test_assertion m assertion =
  match assertion.it with
  | Script.AssertReturn (invoke, expected) ->
    let expected_result = Al.ListV(expected |> List.map al_of_result |> Array.of_list) in
    let result = try do_invoke m invoke with e -> StringV (Printexc.to_string e) in
    if result <> expected_result then begin
      (* Print.string_of_stack !Interpreter.stack |> print_endline; *)
      print_endline " Fail!";
      " Expected: " ^ Print.string_of_value expected_result |> print_endline;
      " Actual: " ^ Print.string_of_value result |> print_endline;
      print_endline ""
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
