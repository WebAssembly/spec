open Source


(* Script representation *)

type definition = definition' Source.phrase
and definition' =
  | Textual of Ast.module_
  | Binary of string

type command = command' Source.phrase
and command' =
  | Define of definition
  | Invoke of string * Kernel.literal list
  | AssertInvalid of definition * string
  | AssertReturn of string * Kernel.literal list * Kernel.literal option
  | AssertReturnNaN of string * Kernel.literal list
  | AssertTrap of string * Kernel.literal list * string
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
    current_module := Some m;
    trace "Initializing...";
    let imports = Import.link m' in
    current_instance := Some (Eval.init m' imports)

  | Invoke (name, es) ->
    trace ("Invoking \"" ^ name ^ "\"...");
    let m = get_instance cmd.at in
    let v = Eval.invoke m name (List.map it es) in
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

  | AssertReturn (name, es, expect_e) ->
    trace ("Asserting return \"" ^ name ^ "\"...");
    let m = get_instance cmd.at in
    let got_v = Eval.invoke m name (List.map it es) in
    let expect_v = Lib.Option.map it expect_e in
    if got_v <> expect_v then begin
      print_string "Result: "; Print.print_value got_v;
      print_string "Expect: "; Print.print_value expect_v;
      Assert.error cmd.at "wrong return value"
    end

  | AssertReturnNaN (name, es) ->
    trace ("Asserting return \"" ^ name ^ "\"...");
    let m = get_instance cmd.at in
    let got_v = Eval.invoke m name (List.map it es) in
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

  | AssertTrap (name, es, re) ->
    trace ("Asserting trap \"" ^ name ^ "\"...");
    let m = get_instance cmd.at in
    (match Eval.invoke m name (List.map it es) with
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
  | Invoke _
  | AssertInvalid _
  | AssertReturn _
  | AssertReturnNaN _
  | AssertTrap _ -> ()

let run script =
  List.iter (if !Flags.dry then dry_cmd else run_cmd) script
