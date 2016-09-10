open Script
open Source


(* Errors & Tracing *)

module Abort = Error.Make ()
module Assert = Error.Make ()
module IO = Error.Make ()

exception Abort = Abort.Error
exception Assert = Assert.Error
exception IO = IO.Error

let trace name = if !Flags.trace then print_endline ("-- " ^ name)


(* File types *)

let binary_ext = "wasm"
let sexpr_ext = "wast"
let js_ext = "js"

let dispatch_file_ext on_binary on_sexpr on_js file =
  if Filename.check_suffix file binary_ext then
    on_binary file
  else if Filename.check_suffix file sexpr_ext then
    on_sexpr file
  else if Filename.check_suffix file js_ext then
    on_js file
  else
    raise (Sys_error (file ^ ": unrecognized file type"))


(* Output *)

let create_binary_file file m script =
  trace ("Encoding (" ^ file ^ ")...");
  let s = Encode.encode m in
  let oc = open_out_bin file in
  try
    trace "Writing...";
    output_string oc s;
    close_out oc
  with exn -> close_out oc; raise exn

let create_sexpr_file file m script =
  trace ("Formatting (" ^ file ^ ")...");
  let sexpr = Arrange.module_ m in
  let oc = open_out file in
  try
    trace "Writing...";
    Sexpr.output oc !Flags.width sexpr;
    close_out oc
  with exn -> close_out oc; raise exn

let create_js_file file m script =
  trace ("Converting (" ^ file ^ ")...");
  let js = Js.of_script script in
  let oc = open_out file in
  try
    trace "Writing...";
    output_string oc js;
    close_out oc
  with exn -> close_out oc; raise exn

let output_file =
  dispatch_file_ext create_binary_file create_sexpr_file create_js_file

let output_stdout m =
  trace "Formatting...";
  let sexpr = Arrange.module_ m in
  trace "Printing...";
  Sexpr.output stdout !Flags.width sexpr


(* Input *)

let error at category msg =
  trace ("Error: ");
  prerr_endline (Source.string_of_region at ^ ": " ^ category ^ ": " ^ msg);
  false

let input_from get_script run =
  try
    let script = get_script () in
    trace "Running...";
    run script;
    true
  with
  | Decode.Code (at, msg) -> error at "decoding error" msg
  | Parse.Syntax (at, msg) -> error at "syntax error" msg
  | Check.Invalid (at, msg) -> error at "invalid module" msg
  | Import.Unknown (at, msg) -> error at "link failure" msg
  | Eval.Link (at, msg) -> error at "link failure" msg
  | Eval.Trap (at, msg) -> error at "runtime trap" msg
  | Eval.Crash (at, msg) -> error at "runtime crash" msg
  | IO (at, msg) -> error at "i/o error" msg
  | Assert (at, msg) -> error at "assertion failure" msg
  | Abort _ -> false

let input_sexpr name lexbuf start run =
  input_from (fun _ -> Parse.parse name lexbuf start) run

let input_binary name buf run =
  let open Source in
  input_from
    (fun _ ->
      let m = Decode.decode name buf in
      [Script.Module (None, Script.Textual m @@ m.at) @@ m.at]
    ) run

let input_sexpr_file file run =
  trace ("Loading (" ^ file ^ ")...");
  let ic = open_in file in
  try
    let lexbuf = Lexing.from_channel ic in
    trace "Parsing...";
    let success = input_sexpr file lexbuf Parse.Script run in
    close_in ic;
    success
  with exn -> close_in ic; raise exn

let input_binary_file file run =
  trace ("Loading (" ^ file ^ ")...");
  let ic = open_in_bin file in
  try
    let len = in_channel_length ic in
    let buf = Bytes.make len '\x00' in
    really_input ic buf 0 len;
    trace "Decoding...";
    let success = input_binary file buf run in
    close_in ic;
    success
  with exn -> close_in ic; raise exn

let input_js_file file run =
  raise (Sys_error (file ^ ": unrecognized input file type"))

let input_file file run =
  dispatch_file_ext input_binary_file input_sexpr_file input_js_file file run

let input_string string run =
  trace ("Running (\"" ^ String.escaped string ^ "\")...");
  let lexbuf = Lexing.from_string string in
  trace "Parsing...";
  input_sexpr "string" lexbuf Parse.Script run


(* Interactive *)

let continuing = ref false

let lexbuf_stdin buf len =
  let prompt = if !continuing then "  " else "> " in
  print_string prompt; flush_all ();
  continuing := true;
  let rec loop i =
    if i = len then i else
    let ch = input_char stdin in
    Bytes.set buf i ch;
    if ch = '\n' then i + 1 else loop (i + 1)
  in
  let n = loop 0 in
  if n = 1 then continuing := false else trace "Parsing...";
  n

let rec input_stdin run =
  let lexbuf = Lexing.from_function lexbuf_stdin in
  let rec loop () =
    let success = input_sexpr "stdin" lexbuf Parse.Script1 run in
    if not success then Lexing.flush_input lexbuf;
    if Lexing.(lexbuf.lex_curr_pos >= lexbuf.lex_buffer_len - 1) then
      continuing := false;
    loop ()
  in
  try loop () with End_of_file ->
    print_endline "";
    trace "Bye."


(* Configuration *)

module Map = Map.Make(String)

let registry : Instance.instance Map.t ref = ref Map.empty
let quote : script ref = ref []

let lookup module_name item_name _t =
  match Instance.export (Map.find module_name !registry) item_name with
  | Some ext -> ext
  | None -> raise Not_found

let scripts : script Map.t ref = ref Map.empty
let modules : Ast.module_ Map.t ref = ref Map.empty
let instances : Instance.instance Map.t ref = ref Map.empty

let last_script : script option ref = ref None
let last_module : Ast.module_ option ref = ref None
let last_instance : Instance.instance option ref = ref None

let bind map x_opt y =
  match x_opt with
  | None -> ()
  | Some x -> map := Map.add x.it y !map

let get_script x_opt at =
  match x_opt, !last_script with
  | None, Some m -> m
  | None, None -> raise (Eval.Crash (at, "no script defined"))
  | Some x, _ ->
    try Map.find x.it !scripts with Not_found ->
      raise (Eval.Crash (x.at, "unknown script " ^ x.it))

let get_module x_opt at =
  match x_opt, !last_module with
  | None, Some m -> m
  | None, None -> raise (Eval.Crash (at, "no module defined"))
  | Some x, _ ->
    try Map.find x.it !modules with Not_found ->
      raise (Eval.Crash (x.at, "unknown module " ^ x.it))

let get_instance x_opt at =
  match x_opt, !last_instance with
  | None, Some inst -> inst
  | None, None -> raise (Eval.Crash (at, "no module defined"))
  | Some x, _ ->
    try Map.find x.it !instances with Not_found ->
      raise (Eval.Crash (x.at, "unknown module " ^ x.it))


(* Quoting *)

let quote_definition def =
  match def.it with
  | Textual m -> m
  | Binary bs ->
    trace "Decoding...";
    Decode.decode "binary" bs

let rec quote_command cmd =
  match cmd.it with
  | Script (x_opt, script) ->
    let save_quote = !quote in
    quote := [];
    quote_script script;
    let script' = List.rev !quote in
    last_script := Some script';
    bind scripts x_opt script';
    quote := !quote @ save_quote

  | Module (x_opt, def) ->
    let m = quote_definition def in
    last_script := Some [cmd];
    last_module := Some m;
    bind scripts x_opt [cmd];
    bind modules x_opt m;
    quote := cmd :: !quote

  | Register _
  | Action _
  | Assertion _ ->
    quote := cmd :: !quote

  | Input file ->
    (try if not (input_file file quote_script) then
      Abort.error cmd.at "aborting"
    with Sys_error msg -> IO.error cmd.at msg)

  | Output (x_opt, Some file) ->
    (try output_file file (get_module x_opt cmd.at) (get_script x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

  | Output (x_opt, None) ->
    (try output_stdout (get_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

and quote_script cmds =
  let save_scripts = !scripts in
  List.iter quote_command cmds;
  scripts := save_scripts


(* Running *)

let run_definition def =
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
    | Some (Instance.ExternalFunc f) -> Eval.invoke f (List.map it es)
    | Some _ -> Assert.error act.at "export is not a function"
    | None -> Assert.error act.at "undefined export"
    )

 | Get (x_opt, name) ->
    trace ("Getting global \"" ^ name ^ "\"...");
    let inst = get_instance x_opt act.at in
    (match Instance.export inst name with
    | Some (Instance.ExternalGlobal v) -> [v]
    | Some _ -> Assert.error act.at "export is not a global"
    | None -> Assert.error act.at "undefined export"
    )

let run_assertion ass =
  match ass.it with
  | AssertInvalid (def, re) ->
    trace "Asserting invalid...";
    (match
      let m = run_definition def in
      Check.check_module m
    with
    | exception (Decode.Code (_, msg) | Check.Invalid (_, msg)) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        Assert.error ass.at "wrong validation error"
      end
    | _ ->
      Assert.error ass.at "expected validation error"
    )

  | AssertUnlinkable (def, re) ->
    trace "Asserting unlinkable...";
    let m = run_definition def in
    if not !Flags.unchecked then Check.check_module m;
    (match
      let imports = Import.link m in
      ignore (Eval.init m imports)
    with
    | exception (Import.Unknown (_, msg) | Eval.Link (_, msg)) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        Assert.error ass.at "wrong linking error"
      end
    | _ ->
      Assert.error ass.at "expected linking error"
    )

  | AssertReturn (act, es) ->
    trace ("Asserting return...");
    let got_vs = run_action act in
    let expect_vs = List.map it es in
    if got_vs <> expect_vs then begin
      print_string "Result: "; Print.print_result got_vs;
      print_string "Expect: "; Print.print_result expect_vs;
      Assert.error ass.at "wrong return values"
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
      Assert.error ass.at "wrong return value"
    end

  | AssertTrap (act, re) ->
    trace ("Asserting trap...");
    (match run_action act with
    | exception Eval.Trap (_, msg) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        Assert.error ass.at "wrong runtime trap"
      end
    | _ ->
      Assert.error ass.at "expected runtime trap"
    )

let rec run_command cmd =
  match cmd.it with
  | Script (x_opt, script) ->
    assert (!quote = []);
    quote_script script;
    let script' = List.rev !quote in
    quote := [];
    last_script := Some script';
    bind scripts x_opt script'

  | Module (x_opt, def) ->
    let m = run_definition def in
    if not !Flags.unchecked then begin
      trace "Checking...";
      Check.check_module m;
      if !Flags.print_sig then begin
        trace "Signature:";
        Print.print_module_sig m
      end
    end;
    last_script := Some [cmd];
    last_module := Some m;
    bind scripts x_opt [cmd];
    bind modules x_opt m;
    if not !Flags.dry then begin
      trace "Initializing...";
      let imports = Import.link m in
      let inst = Eval.init m imports in
      last_instance := Some inst;
      bind instances x_opt inst
    end

  | Register (name, x_opt) ->
    if not !Flags.dry then begin
      trace ("Registering module \"" ^ name ^ "\"...");
      let inst = get_instance x_opt cmd.at in
      registry := Map.add name inst !registry;
      Import.register name (lookup name)
    end

  | Action act ->
    if not !Flags.dry then begin
      let vs = run_action act in
      if vs <> [] then Print.print_result vs
    end

  | Assertion ass ->
    if not !Flags.dry then begin
      run_assertion ass
    end

  | Input file ->
    (try if not (input_file file run_script) then Abort.error cmd.at "aborting"
    with Sys_error msg -> IO.error cmd.at msg)

  | Output (x_opt, Some file) ->
    (try output_file file (get_module x_opt cmd.at) (get_script x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

  | Output (x_opt, None) ->
    (try output_stdout (get_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

and run_script script =
  List.iter run_command script

let run_file file = input_file file run_script
let run_string str = input_string str run_script
let run_stdin () = input_stdin run_script
