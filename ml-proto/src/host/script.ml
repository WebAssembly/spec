(*
 * (c) 2015 Andreas Rossberg
 *)

open Source
open Types
open Memory
open Values

(* Script representation *)

type command = command' phrase
and command' =
  | Define of Ast.modul
  | AssertInvalid of Ast.modul * string
  | Invoke of string * Ast.expr list
  | AssertEq of string * Ast.expr list * Ast.expr
  | AssertTrap of string * Ast.expr list * string
  | AssertHeapEq of int * string

type script = command list


(* Execution *)

let trace name = if !Flags.trace then print_endline ("-- " ^ name)

let current_module : Eval.instance option ref = ref None

let eval_args es at =
  let evs = List.map Eval.eval es in
  let reject_none = function
    | Some v -> v
    | None -> Error.error at "unexpected () value" in
  List.map reject_none evs

let assert_error f err re at =
  match f () with
  | exception Error.Error (_, s) ->
    if not (Str.string_match (Str.regexp re) s 0) then
      Error.error at ("failure \"" ^ s ^ "\" does not match: \"" ^ re ^ "\"")
  | _ ->
    Error.error at ("expected " ^ err)

let rec run_command cmd =
  match cmd.it with
  | Define m ->
    trace "Checking...";
    Check.check_module m;
    if !Flags.print_sig then begin
      trace "Signature:";
      Print.print_module_sig m
    end;
    trace "Initializing...";
    let imports = Builtins.match_imports m.it.Ast.imports in
    let host_params = {Eval.page_size = Params.page_size} in
    current_module := Some (Eval.init m imports host_params)

  | AssertInvalid (m, re) ->
    trace "Checking invalid...";
    assert_error (fun () -> Check.check_module m) "invalid module" re cmd.at

  | Invoke (name, es) ->
    trace "Invoking...";
    let m = match !current_module with
      | Some m -> m
      | None -> Error.error cmd.at "no module defined to invoke"
    in
    let vs = eval_args es cmd.at in
    let v = Eval.invoke m name vs in
    if v <> None then Print.print_value v

  | AssertEq (name, arg_es, expect_e) ->
    trace "Assert invoking...";
    let m = match !current_module with
      | Some m -> m
      | None -> Error.error cmd.at "no module defined to invoke"
    in
    let arg_vs = eval_args arg_es cmd.at in
    let got_v = Eval.invoke m name arg_vs in
    let expect_v = Eval.eval expect_e in
    if got_v <> expect_v then begin
      print_string "Result: ";
      Print.print_value got_v;
      print_string "Expect: ";
      Print.print_value expect_v;
      Error.error cmd.at "assertion failed"
    end

  | AssertTrap (name, es, re) ->
    trace "Assert trap invoking...";
    let m = match !current_module with
      | Some m -> m
      | None -> Error.error cmd.at "no module defined to invoke"
    in
    let vs = eval_args es cmd.at in
    assert_error (fun () -> Eval.invoke m name vs) "trap" re cmd.at

  | AssertHeapEq (offset, expected) ->
    let m = match !current_module with
      | Some m -> m
      | None -> Error.error cmd.at "no module defined to examine heap"
    in
    let count = String.length expected in
    let mem = Eval.memory_for_module m in
    let actual = memory_as_string mem offset count in

    for i = 0 to count - 1 do
      let expected_ch = expected.[i] in
      let actual_ch = actual.[i] in

      if expected_ch <> actual_ch then begin
        print_string "Result: \"";
        
        for j = 0 to count - 1 do
          let ch = actual.[j] in
          print_string (Char.escaped ch);
        done;

        print_string "\"\nExpect: \"";

        for j = 0 to count - 1 do
          let ch = expected.[j] in
          print_string (Char.escaped ch);
        done;

        print_string "\"\n";
        Error.error cmd.at "heap assertion failed"
      end
    done;

and char_at_memory_offset m base offset =
  let code = match Memory.load_extend m (base + offset) Mem8 ZX Int32Type with
    | Int32 i -> Int32.to_int i
    | _ -> assert false
  in
  assert (code >= 0);
  assert (code <= 255);
  Char.chr code

and memory_as_string m offset count =
  let result = Buffer.create count in
  for i = 0 to count - 1 do
    Buffer.add_char result (char_at_memory_offset m offset i);
  done;
  Buffer.contents result

let dry_command cmd =
  match cmd.it with
  | Define m ->
    Check.check_module m;
    if !Flags.print_sig then Print.print_module_sig m
  | AssertInvalid _ -> ()
  | Invoke _ -> ()
  | AssertEq _ -> ()
  | AssertTrap _ -> ()
  | AssertHeapEq _ -> ()

let run script =
  List.iter (if !Flags.dry then dry_command else run_command) script
