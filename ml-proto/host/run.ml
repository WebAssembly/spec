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
let binary_sexpr_ext = "bin.wast"
let sexpr_ext = "wast"
let js_ext = "js"

let is_binary_file_ext file = Filename.check_suffix file binary_ext

let dispatch_file_ext on_binary on_binary_sexpr on_sexpr on_js file =
  if Filename.check_suffix file binary_ext then
    on_binary file
  else if Filename.check_suffix file binary_sexpr_ext then
    on_binary_sexpr file
  else if Filename.check_suffix file sexpr_ext then
    on_sexpr file
  else if Filename.check_suffix file js_ext then
    on_js file
  else
    raise (Sys_error (file ^ ": unrecognized file type"))


(* Output *)

let create_binary_file file _ get_module =
  trace ("Encoding (" ^ file ^ ")...");
  let s = Encode.encode (get_module ()) in
  let oc = open_out_bin file in
  try
    trace "Writing...";
    output_string oc s;
    close_out oc
  with exn -> close_out oc; raise exn

let create_sexpr_file mode file get_script _ =
  trace ("Formatting (" ^ file ^ ")...");
  let sexprs = Arrange.script mode (get_script ()) in
  let oc = open_out file in
  try
    trace "Writing...";
    List.iter (Sexpr.output oc !Flags.width) sexprs;
    close_out oc
  with exn -> close_out oc; raise exn

let create_js_file file get_script _ =
  trace ("Converting (" ^ file ^ ")...");
  let js = Js.of_script (get_script ()) in
  let oc = open_out file in
  try
    trace "Writing...";
    output_string oc js;
    close_out oc
  with exn -> close_out oc; raise exn

let output_file =
  dispatch_file_ext
    create_binary_file
    (create_sexpr_file `Binary)
    (create_sexpr_file `Textual)
    create_js_file

let output_stdout get_module =
  trace "Formatting...";
  let sexpr = Arrange.module_ (get_module ()) in
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
  | Encode.Code (at, msg) -> error at "encoding error" msg
  | IO (at, msg) -> error at "i/o error" msg
  | Assert (at, msg) -> error at "assertion failure" msg
  | Abort _ -> false

let input_sexpr name lexbuf start run =
  input_from (fun _ -> Parse.parse name lexbuf start) run

let input_binary name buf run =
  let open Source in
  input_from (fun _ ->
    [Module (None, Binary (name, buf) @@ no_region) @@ no_region]) run

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
  dispatch_file_ext
    input_binary_file
    input_sexpr_file
    input_sexpr_file
    input_js_file
    file run

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

let quote : script ref = ref []
let scripts : script Map.t ref = ref Map.empty
let modules : Ast.module_ Map.t ref = ref Map.empty
let instances : Instance.instance Map.t ref = ref Map.empty
let registry : Instance.instance Map.t ref = ref Map.empty

let bind map x_opt y =
  let map' =
    match x_opt with
    | None -> !map
    | Some x -> Map.add x.it y !map
  in map := Map.add "" y map'

let lookup category map x_opt at =
  let key = match x_opt with None -> "" | Some x -> x.it in
  try Map.find key !map with Not_found ->
    IO.error at
      (if key = "" then "no " ^ category ^ " defined"
       else "unknown " ^ category ^ " " ^ key)

let lookup_script = lookup "script" scripts
let lookup_module = lookup "module" modules
let lookup_instance = lookup "module" instances

let lookup_registry module_name item_name _t =
  match Instance.export (Map.find module_name !registry) item_name with
  | Some ext -> ext
  | None -> raise Not_found


(* Running *)

let run_definition def =
  match def.it with
  | Textual m -> m
  | Binary (name, bs) ->
    trace "Decoding...";
    Decode.decode name bs

let run_action act =
  match act.it with
  | Invoke (x_opt, name, es) ->
    trace ("Invoking function \"" ^ name ^ "\"...");
    let inst = lookup_instance x_opt act.at in
    (match Instance.export inst name with
    | Some (Instance.ExternalFunc f) -> Eval.invoke f (List.map it es)
    | Some _ -> Assert.error act.at "export is not a function"
    | None -> Assert.error act.at "undefined export"
    )

 | Get (x_opt, name) ->
    trace ("Getting global \"" ^ name ^ "\"...");
    let inst = lookup_instance x_opt act.at in
    (match Instance.export inst name with
    | Some (Instance.ExternalGlobal v) -> [v]
    | Some _ -> Assert.error act.at "export is not a global"
    | None -> Assert.error act.at "undefined export"
    )

let run_assertion ass =
  match ass.it with
  | AssertMalformed (def, re) ->
    trace "Asserting malformed...";
    (match
      ignore (run_definition def)
    with
    | exception Decode.Code (_, msg) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        Assert.error ass.at "wrong decoding error"
      end
    | _ ->
      Assert.error ass.at "expected decoding error"
    )

  | AssertInvalid (def, re)
  | AssertSoftInvalid (def, re) ->
    let active =
      match ass.it with
      | AssertSoftInvalid _ -> not !Flags.unchecked_soft
      | _ -> true
    in
    trace ("Asserting " ^ (if active then "" else "soft ") ^ "invalid...");
    (match
      let m = run_definition def in
      Check.check_module m
    with
    | exception Check.Invalid (_, msg) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        Assert.error ass.at "wrong validation error"
      end
    | _ ->
      if active then Assert.error ass.at "expected validation error"
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
  | Module (x_opt, def) ->
    quote := cmd :: !quote;
    let m = run_definition def in
    if not !Flags.unchecked then begin
      trace "Checking...";
      Check.check_module m;
      if !Flags.print_sig then begin
        trace "Signature:";
        Print.print_module_sig m
      end
    end;
    bind scripts x_opt [cmd];
    bind modules x_opt m;
    if not !Flags.dry then begin
      trace "Initializing...";
      let imports = Import.link m in
      let inst = Eval.init m imports in
      bind instances x_opt inst
    end

  | Register (name, x_opt) ->
    quote := cmd :: !quote;
    if not !Flags.dry then begin
      trace ("Registering module \"" ^ name ^ "\"...");
      let inst = lookup_instance x_opt cmd.at in
      registry := Map.add name inst !registry;
      Import.register name (lookup_registry name)
    end

  | Action act ->
    quote := cmd :: !quote;
    if not !Flags.dry then begin
      let vs = run_action act in
      if vs <> [] then Print.print_result vs
    end

  | Assertion ass ->
    quote := cmd :: !quote;
    if not !Flags.dry then begin
      run_assertion ass
    end

  | Meta cmd ->
    run_meta cmd

and run_meta cmd =
  match cmd.it with
  | Script (x_opt, script) ->
    run_quote_script script;
    bind scripts x_opt (lookup_script None cmd.at)

  | Input (x_opt, file) ->
    (try if not (input_file file run_quote_script) then
      Abort.error cmd.at "aborting"
    with Sys_error msg -> IO.error cmd.at msg);
    bind scripts x_opt (lookup_script None cmd.at);
    if x_opt <> None then begin
      bind modules x_opt (lookup_module None cmd.at);
      if not !Flags.dry then begin
        bind instances x_opt (lookup_instance None cmd.at)
      end
    end

  | Output (x_opt, Some file) ->
    (try
      output_file file
        (fun () -> lookup_script x_opt cmd.at)
        (fun () -> lookup_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

  | Output (x_opt, None) ->
    (try output_stdout (fun () -> lookup_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

and run_script script =
  List.iter run_command script

and run_quote_script script =
  let save_quote = !quote in
  quote := [];
  (try run_script script with exn -> quote := save_quote; raise exn);
  bind scripts None (List.rev !quote);
  quote := !quote @ save_quote

let run_file file = input_file file run_script
let run_string string = input_string string run_script
let run_stdin () = input_stdin run_script
