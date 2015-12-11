open Source


(* Script representation *)

type 'm command = 'm command' Source.phrase
and 'm command' =
  | Define of 'm
  | Invoke of string * Kernel.literal list
  | AssertInvalid of 'm * string
  | AssertReturn of string * Kernel.literal list * Kernel.literal option
  | AssertReturnNaN of string * Kernel.literal list
  | AssertTrap of string * Kernel.literal list * string

type script = Ast.module_ command list
type script' = Kernel.module_ command list


(* Desugaring *)

let rec desugar_cmd c = desugar_cmd' c.it @@ c.at
and desugar_cmd' = function
  | Define m -> Define (Desugar.desugar m)
  | Invoke (s, ls) -> Invoke (s, ls)
  | AssertInvalid (m, r) -> AssertInvalid (Desugar.desugar m, r)
  | AssertReturn (s, ls, lo) -> AssertReturn (s, ls, lo)
  | AssertReturnNaN (s, ls) -> AssertReturnNaN (s, ls)
  | AssertTrap (s, ls, r) -> AssertTrap (s, ls, r)

let desugar = List.map desugar_cmd


(* Execution *)

module Syntax = Error.Make ()
module AssertFailure = Error.Make ()

exception Syntax = Syntax.Error
exception AssertFailure = AssertFailure.Error  (* assert command failure *)

let trace name = if !Flags.trace then print_endline ("-- " ^ name)

let current_module : Eval.instance option ref = ref None

let get_module at = match !current_module with
  | Some m -> m
  | None -> raise (Eval.Crash (at, "no module defined to invoke"))


let run_cmd cmd =
  match cmd.it with
  | Define m ->
    trace "Checking...";
    Check.check_module m;
    if !Flags.print_sig then begin
      trace "Signature:";
      Print.print_module_sig m
    end;
    trace "Initializing...";
    let imports = Builtins.match_imports m in
    current_module := Some (Eval.init m imports)

  | Invoke (name, es) ->
    trace "Invoking...";
    let m = get_module cmd.at in
    let v = Eval.invoke m name (List.map it es) in
    if v <> None then Print.print_value v

  | AssertInvalid (m, re) ->
    trace "Asserting invalid...";
    (match Check.check_module m with
    | exception Check.Invalid (_, msg) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        AssertFailure.error cmd.at "wrong validation error"
      end
    | _ ->
      AssertFailure.error cmd.at "expected validation error"
    )

  | AssertReturn (name, es, expect_e) ->
    trace "Asserting return...";
    let m = get_module cmd.at in
    let got_v = Eval.invoke m name (List.map it es) in
    let expect_v = Lib.Option.map it expect_e in
    if got_v <> expect_v then begin
      print_string "Result: "; Print.print_value got_v;
      print_string "Expect: "; Print.print_value expect_v;
      AssertFailure.error cmd.at "wrong return value"
    end

  | AssertReturnNaN (name, es) ->
    trace "Asserting return...";
    let m = get_module cmd.at in
    let got_v = Eval.invoke m name (List.map it es) in
    if
      match got_v with
      | Some (Values.Float32 got_f32) -> F32.eq got_f32 got_f32
      | Some (Values.Float64 got_f64) -> F64.eq got_f64 got_f64
      | _ -> true
    then begin
      print_string "Result: "; Print.print_value got_v;
      print_string "Expect: "; print_endline "nan";
      AssertFailure.error cmd.at "wrong return value"
    end

  | AssertTrap (name, es, re) ->
    trace "Asserting trap...";
    let m = get_module cmd.at in
    (match Eval.invoke m name (List.map it es) with
    | exception Eval.Trap (_, msg) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        AssertFailure.error cmd.at "wrong runtime trap"
      end
    | _ ->
      AssertFailure.error cmd.at "expected runtime trap"
    )

let dry_cmd cmd =
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
  List.iter (if !Flags.dry then dry_cmd else run_cmd) script
