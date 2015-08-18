(*
 * (c) 2015 Andreas Rossberg
 *)

open Source

(* Script representation *)

type command = command' phrase
and command' =
  | Define of Ast.modul
  | Invoke of int * Ast.expr list
  | AssertEqInvoke of int * Ast.expr list * Ast.expr list

type script = command list


(* Execution *)

let current_module : Eval.module_instance option ref = ref None

let trace name = if !Flags.trace then print_endline ("-- " ^ name)

let run_command cmd =
  try
    match cmd.it with
    | Define m ->
      trace "Checking...";
      Check.check_module m;
      if !Flags.print_sig then begin
        trace "Signature:";
        Print.print_module_sig m
      end;
      trace "Initializing...";
      current_module := Some (Eval.init m)
    | Invoke (i, es) ->
      trace "Invoking...";
      let m = match !current_module with
        | Some m -> m
        | None -> Error.error cmd.at "no module defined to invoke"
      in
      let vs = List.map Eval.eval es in
      let vs' = Eval.invoke m i vs in
      if vs' <> [] then Print.print_values vs'
    | AssertEqInvoke (i, arg_es, expect_es) ->
      trace "Assert invoking...";
      let m = match !current_module with
        | Some m -> m
        | None -> Error.error cmd.at "no module defined to invoke"
      in
      let arg_vs = List.map Eval.eval arg_es in
      let got_vs = Eval.invoke m i arg_vs in
      let expect_vs = List.map Eval.eval expect_es in
      if got_vs <> expect_vs then begin
        print_string "Result: ";
        Print.print_values got_vs;
        print_string "Expect: ";
        Print.print_values expect_vs;
        Error.error cmd.at "assertion failed"
      end;
  with Error.Error (at, s) ->
    trace "Error:";
    prerr_endline (Source.string_of_region at ^ ": " ^ s)

let dry_command cmd =
  match cmd.it with
  | Define m ->
    Check.check_module m;
    if !Flags.print_sig then Print.print_module_sig m
  | Invoke _ -> ()
  | AssertEqInvoke _ -> ()

let run script =
  List.iter (if !Flags.dry then dry_command else run_command) script
