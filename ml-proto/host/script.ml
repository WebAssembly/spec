open Source
open Instance


(* Script representation *)

type var = string Source.phrase

type definition = definition' Source.phrase
and definition' =
  | Textual of Ast.module_
  | Binary of string

type action = action' Source.phrase
and action' =
  | Invoke of var option * string * Ast.literal list
  | Get of var option * string

type command = command' Source.phrase
and command' =
  | Define of var option * definition
  | Register of string * var option
  | Action of action
  | AssertInvalid of definition * string
  | AssertUnlinkable of definition * string
  | AssertReturn of action * Ast.literal list
  | AssertReturnNaN of action
  | AssertTrap of action * string
  | Input of string
  | Output of var option * string option

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

module Map = Map.Make(String)

let registry : Instance.instance Map.t ref = ref Map.empty

let lookup module_name item_name _t =
  match Instance.export (Map.find module_name !registry) item_name with
  | Some ext -> ext
  | None -> raise Not_found

let modules : Ast.module_ Map.t ref = ref Map.empty
let instances : Instance.instance Map.t ref = ref Map.empty
let current_module : Ast.module_ option ref = ref None
let current_instance : Instance.instance option ref = ref None

let bind map x_opt y =
  match x_opt with
  | None -> ()
  | Some x -> map := Map.add x.it y !map

let get_module x_opt at =
  match x_opt, !current_module with
  | None, Some m -> m
  | None, None -> raise (Eval.Crash (at, "no module defined"))
  | Some x, _ ->
    try Map.find x.it !modules with Not_found ->
      raise (Eval.Crash (x.at, "unknown module " ^ x.it))

let get_instance x_opt at =
  match x_opt, !current_instance with
  | None, Some inst -> inst
  | None, None -> raise (Eval.Crash (at, "no module defined"))
  | Some x, _ ->
    try Map.find x.it !instances with Not_found ->
      raise (Eval.Crash (x.at, "unknown module " ^ x.it))

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
  | Invoke (x_opt, name, es) ->
    trace ("Invoking function \"" ^ name ^ "\"...");
    let inst = get_instance x_opt act.at in
    (match Instance.export inst name with
    | Some (ExternalFunc f) -> Eval.invoke f (List.map it es)
    | Some _ -> Assert.error act.at "export is not a function"
    | None -> Assert.error act.at "undefined export"
    )

 | Get (x_opt, name) ->
    trace ("Getting global \"" ^ name ^ "\"...");
    let inst = get_instance x_opt act.at in
    (match Instance.export inst name with
    | Some (ExternalGlobal v) -> [v]
    | Some _ -> Assert.error act.at "export is not a global"
    | None -> Assert.error act.at "undefined export"
    )

let run_cmd cmd =
  match cmd.it with
  | Define (x_opt, def) ->
    let m = run_def def in
    if not !Flags.unchecked then begin
      trace "Checking...";
      Check.check_module m;
      if !Flags.print_sig then begin
        trace "Signature:";
        Print.print_module_sig m
      end
    end;
    trace "Initializing...";
    let imports = Import.link m in
    let inst = Eval.init m imports in
    current_module := Some m;
    current_instance := Some inst;
    bind modules x_opt m;
    bind instances x_opt inst

  | Register (name, x_opt) ->
    trace ("Registering module \"" ^ name ^ "\"...");
    let inst = get_instance x_opt cmd.at in
    registry := Map.add name inst !registry;
    Import.register name (lookup name)

  | Action act ->
    let vs = run_action act in
    if vs <> [] then Print.print_result vs

  | AssertInvalid (def, re) ->
    trace "Asserting invalid...";
    (match
      let m = run_def def in
      Check.check_module m
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
    if not !Flags.unchecked then Check.check_module m;
    (match
      let imports = Import.link m in
      ignore (Eval.init m imports)
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

  | AssertReturn (act, es) ->
    trace ("Asserting return...");
    let got_vs = run_action act in
    let expect_vs = List.map it es in
    if got_vs <> expect_vs then begin
      print_string "Result: "; Print.print_result got_vs;
      print_string "Expect: "; Print.print_result expect_vs;
      Assert.error cmd.at "wrong return value"
    end

  | AssertReturnNaN act ->
    trace ("Asserting return...");
    let got_vs = run_action act in
    if
      match got_vs with
      | [Values.F32 got_f32] ->
        got_f32 <> F32.pos_nan && got_f32 <> F32.neg_nan
      | [Values.F64 got_f64] ->
        got_f64 <> F64.pos_nan && got_f64 <> F64.neg_nan
      | _ -> true
    then begin
      print_string "Result: "; Print.print_result got_vs;
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

  | Output (x_opt, Some file) ->
    (try !output_file file (get_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

  | Output (x_opt, None) ->
    (try !output_stdout (get_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

let dry_def def =
  match def.it with
  | Textual m -> m
  | Binary bs ->
    trace "Decoding...";
    Decode.decode "binary" bs

let dry_cmd cmd =
  match cmd.it with
  | Define (x_opt, def) ->
    let m = dry_def def in
    if not !Flags.unchecked then begin
      trace "Checking...";
      Check.check_module m;
      if !Flags.print_sig then begin
        trace "Signature:";
        Print.print_module_sig m
      end
    end;
    current_module := Some m;
    bind modules x_opt m
  | Input file ->
    (try if not (!input_file file) then Abort.error cmd.at "aborting"
    with Sys_error msg -> IO.error cmd.at msg)
  | Output (x_opt, Some file) ->
    (try !output_file file (get_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)
  | Output (x_opt, None) ->
    (try !output_stdout (get_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)
  | Register _
  | Action _
  | AssertInvalid _
  | AssertUnlinkable _
  | AssertReturn _
  | AssertReturnNaN _
  | AssertTrap _ -> ()

let run script =
  List.iter (if !Flags.dry then dry_cmd else run_cmd) script
