(*
 * (c) 2015 Andreas Rossberg
 *)

open Source


(* Script representation *)

type command = command' phrase
and command' =
  | Define of Ast.module_
  | Invoke of string * Ast.literal list
  | AssertInvalid of Ast.module_ * string
  | AssertReturn of string * Ast.literal list * Ast.literal option
  | AssertReturnNaN of string * Ast.literal list
  | AssertTrap of string * Ast.literal list * string

type script = command list


(* Execution *)

let trace name = if !Flags.trace then print_endline ("-- " ^ name)

let current_module : Eval.instance option ref = ref None

let get_module at = match !current_module with
  | Some m -> m
  | None -> Error.error at "no module defined to invoke"

let show_value label v = begin
  print_string (label ^ ": ");
  Print.print_value v
end

let show_result got_v = begin
  show_value "Result" got_v
end

let show_result_expect got_v expect_v = begin
  show_result got_v;
  show_value "Expect" expect_v
end

let assert_error f err re at =
  match f () with
  | exception Error.Error (_, s) ->
    if not (Str.string_match (Str.regexp re) s 0) then
      Error.error at ("failure \"" ^ s ^ "\" does not match: \"" ^ re ^ "\"")
  | _ ->
    Error.error at ("expected " ^ err)

let run_command cmd =
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

  | Invoke (name, es) ->
    trace "Invoking...";
    let m = get_module cmd.at in
    let v = Eval.invoke m name (List.map it es) in
    if v <> None then Print.print_value v

  | AssertInvalid (m, re) ->
    trace "Asserting invalid...";
    assert_error (fun () -> Check.check_module m) "invalid module" re cmd.at

  | AssertReturn (name, es, expect_e) ->
    let open Values in
    trace "Asserting return...";
    let m = get_module cmd.at in
    let got_v = Eval.invoke m name (List.map it es) in
    let expect_v = Lib.Option.map it expect_e in
    (match got_v, expect_v with
    | None, None -> ()
    | Some (Int32 got_i32), Some (Int32 expect_i32) ->
      if got_i32 <> expect_i32 then begin
        show_result_expect got_v expect_v;
        Error.error cmd.at "assert_return i32 operands are not equal"
      end
    | Some (Int64 got_i64), Some (Int64 expect_i64) ->
      if got_i64 <> expect_i64 then begin
        show_result_expect got_v expect_v;
        Error.error cmd.at "assert_return i64 operands are not equal"
      end
    | Some (Float32 got_f32), Some (Float32 expect_f32) ->
      if (F32.to_bits got_f32) <> (F32.to_bits expect_f32) then begin
        show_result_expect got_v expect_v;
        Error.error cmd.at
          "assert_return f32 operands have different bit patterns"
      end
    | Some (Float64 got_f64), Some (Float64 expect_f64) ->
      if (F64.to_bits got_f64) <> (F64.to_bits expect_f64) then begin
        show_result_expect got_v expect_v;
        Error.error cmd.at
          "assert_return f64 operands have different bit patterns"
      end
    | _, _ ->
      begin
        show_result_expect got_v expect_v;
        Error.error cmd.at "assert_return operands must be the same type"
      end
    )

  | AssertReturnNaN (name, es) ->
    let open Values in
    trace "Asserting return...";
    let m = get_module cmd.at in
    let got_v = Eval.invoke m name (List.map it es) in
    (match got_v with
    | Some (Float32 got_f32) ->
      if (F32.eq got_f32 got_f32) then begin
        show_result got_v;
        Error.error cmd.at "assert_return_nan f32 operand is not a NaN"
      end
    | Some (Float64 got_f64) ->
      if (F64.eq got_f64 got_f64) then begin
        show_result got_v;
        Error.error cmd.at "assert_return_nan f64 operand is not a NaN"
      end
    | _ ->
      begin
        show_result got_v;
        Error.error cmd.at "assert_return_nan operand must be f32 or f64"
      end
    )

  | AssertTrap (name, es, re) ->
    trace "Asserting trap...";
    let m = get_module cmd.at in
    assert_error (fun () -> Eval.invoke m name (List.map it es))
      "trap" re cmd.at

let dry_command cmd =
  match cmd.it with
  | Define m ->
    Check.check_module m;
    if !Flags.print_sig then Print.print_module_sig m
  | Invoke _
  | AssertInvalid _
  | AssertReturn _
  | AssertReturnNaN _
  | AssertTrap _ -> ()

let run script =
  List.iter (if !Flags.dry then dry_command else run_command) script
