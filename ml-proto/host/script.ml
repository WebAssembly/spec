open Source


(* Script representation *)

type definition = definition' Source.phrase
and definition' =
  | Textual of Ast.module_
  | Binary of string

type action = action' Source.phrase
and action' =
  | Invoke of string * Kernel.literal list

type command = command' Source.phrase
and command' =
  | Define of definition
  | Action of action
  | AssertInvalid of definition * string
  | AssertUnlinkable of definition * string
  | AssertReturn of action * Kernel.literal option
  | AssertReturnNaN of action
  | AssertTrap of action * string
  | Input of string
  | Output of string option

type script = command list


(* Execution *)

module Abort = Error.Make ()
module Syntax = Error.Make ()
module Assert = Error.Make ()
module IO = Error.Make ()

exception Abort = Abort.Error
exception Syntax = Syntax.Error
exception Assert = Assert.Error
exception IO = IO.Error

let trace name = if !Flags.trace then print_endline ("-- " ^ name)

let current_module : Ast.module_ option ref = ref None
let current_instance : Instance.instance option ref = ref None

let get_module at = match !current_module with
  | Some m -> m
  | None -> raise (Eval.Crash (at, "no module defined"))

let get_instance at = match !current_instance with
  | Some m -> m
  | None -> raise (Eval.Crash (at, "no module defined"))

let input_file = ref (fun _ -> assert false)
let output_file = ref (fun _ -> assert false)
let output_stdout = ref (fun _ -> assert false)

let run_def def =
  match def.it with
  | Textual m -> m
  | Binary bs ->
    trace "Decoding...";
    Decode.decode "binary" bs 

let run_action act =
  match act.it with
  | Invoke (name, es) ->
    trace ("Invoking \"" ^ name ^ "\"...");
    let m = get_instance act.at in
    Eval.invoke m name (List.map it es)

let run_cmd cmd =
  match cmd.it with
  | Define def ->
    let m = run_def def in
    let m' = Desugar.desugar m in
    if not !Flags.unchecked then begin
      trace "Checking...";
      Check.check_module m';
      if !Flags.print_sig then begin
        trace "Signature:";
        Print.print_module_sig m'
      end
    end;
    trace "Initializing...";
    let imports = Import.link m' in
    current_module := Some m;
    current_instance := Some (Eval.init m' imports)

  | Action act ->
    let v = run_action act in
    if v <> None then Print.print_value v

  | AssertInvalid (def, re) ->
    trace "Asserting invalid...";
    (match
      let m = run_def def in
      let m' = Desugar.desugar m in
      Check.check_module m'
    with
    | exception (Decode.Code (_, msg) | Check.Invalid (_, msg)) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        Assert.error cmd.at "wrong validation error"
      end
    | _ ->
      Assert.error cmd.at "expected validation error"
    )

  | AssertUnlinkable (def, re) ->
    trace "Asserting unlinkable...";
    let m = run_def def in
    let m' = Desugar.desugar m in
    if not !Flags.unchecked then Check.check_module m';
    (match
      let imports = Import.link m' in
      ignore (Eval.init m' imports)
    with
    | exception (Import.Unknown (_, msg) | Eval.Link (_, msg)) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        Assert.error cmd.at "wrong linking error"
      end
    | _ ->
      Assert.error cmd.at "expected linking error"
    )

  | AssertReturn (act, expect) ->
    trace ("Asserting return...");
    let got_v = run_action act in
    let expect_v = Lib.Option.map it expect in
    if got_v <> expect_v then begin
      print_string "Result: "; Print.print_value got_v;
      print_string "Expect: "; Print.print_value expect_v;
      Assert.error cmd.at "wrong return value"
    end

  | AssertReturnNaN act ->
    trace ("Asserting return...");
    let got_v = run_action act in
    if
      match got_v with
      | Some (Values.Float32 got_f32) ->
              got_f32 <> F32.pos_nan && got_f32 <> F32.neg_nan
      | Some (Values.Float64 got_f64) ->
              got_f64 <> F64.pos_nan && got_f64 <> F64.neg_nan
      | _ -> true
    then begin
      print_string "Result: "; Print.print_value got_v;
      print_string "Expect: "; print_endline "nan";
      Assert.error cmd.at "wrong return value"
    end

  | AssertTrap (act, re) ->
    trace ("Asserting trap...");
    (match run_action act with
    | exception Eval.Trap (_, msg) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        Assert.error cmd.at "wrong runtime trap"
      end
    | _ ->
      Assert.error cmd.at "expected runtime trap"
    )

  | Input file ->
    (try if not (!input_file file) then Abort.error cmd.at "aborting"
    with Sys_error msg -> IO.error cmd.at msg)

  | Output (Some file) ->
    (try !output_file file (get_module cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

  | Output None ->
    (try !output_stdout (get_module cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

let dry_def def =
  match def.it with
  | Textual m -> m
  | Binary bs ->
    trace "Decoding...";
    Decode.decode "binary" bs 

let dry_cmd cmd =
  match cmd.it with
  | Define def ->
    let m = dry_def def in
    let m' = Desugar.desugar m in
    if not !Flags.unchecked then begin
      trace "Checking...";
      Check.check_module m';
      if !Flags.print_sig then begin
        trace "Signature:";
        Print.print_module_sig m'
      end
    end;
    current_module := Some m
  | Input file ->
    (try if not (!input_file file) then Abort.error cmd.at "aborting"
    with Sys_error msg -> IO.error cmd.at msg)
  | Output (Some file) ->
    (try !output_file file (get_module cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)
  | Output None ->
    (try !output_stdout (get_module cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)
  | Action _
  | AssertInvalid _
  | AssertUnlinkable _
  | AssertReturn _
  | AssertReturnNaN _
  | AssertTrap _ -> ()

let run script =
  List.iter (if !Flags.dry then dry_cmd else run_cmd) script
