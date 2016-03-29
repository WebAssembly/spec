open Flags

let configure () =
  Import.register "spectest" Spectest.lookup;
  Import.register "env" Env.lookup

let banner () =
  print_endline (name ^ " " ^ version ^ " spec interpreter")

let parse name lexbuf start =
  lexbuf.Lexing.lex_curr_p <-
    {lexbuf.Lexing.lex_curr_p with Lexing.pos_fname = name};
  try start Lexer.token lexbuf with Script.Syntax (region, s) ->
    let region' = if region <> Source.no_region then region else
      {Source.left = Lexer.convert_pos lexbuf.Lexing.lex_start_p;
       Source.right = Lexer.convert_pos lexbuf.Lexing.lex_curr_p} in
    raise (Script.Syntax (region', s))

let error at category msg =
  Script.trace ("Error (" ^ category ^ "): ");
  prerr_endline (Source.string_of_region at ^ ": " ^ msg);
  false

let process file lexbuf start =
  if !Flags.print_sig then print_endline ("File: " ^ file ^ "\n");
  try
    let script = parse file lexbuf start in
    Script.trace "Desugaring...";
    let script' = Script.desugar script in
    Script.trace "Running...";
    Script.run script';
    true
  with
  | Script.Syntax (at, msg) -> error at "syntax error" msg
  | Script.AssertFailure (at, msg) -> error at "assertion failure" msg
  | Check.Invalid (at, msg) -> error at "invalid module" msg
  | Eval.Trap (at, msg) -> error at "runtime trap" msg
  | Eval.Crash (at, msg) -> error at "runtime crash" msg
  | Import.Unknown (at, msg) -> error at "unknown import" msg

let process_file file =
  Script.trace ("Loading (" ^ file ^ ")...");
  let ic = open_in file in
  try
    let lexbuf = Lexing.from_channel ic in
    Script.trace "Parsing...";
    let success = process file lexbuf Parser.script in
    close_in ic;
    if not success then exit 1
  with exn -> close_in ic; raise exn

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
  if n = 1 then continuing := false else Script.trace "Parsing...";
  n

let rec process_stdin () =
  banner ();
  let lexbuf = Lexing.from_function lexbuf_stdin in
  let rec loop () =
    let success = process "stdin" lexbuf Parser.script1 in
    if not success then Lexing.flush_input lexbuf;
    if Lexing.(lexbuf.lex_curr_pos >= lexbuf.lex_buffer_len - 1) then
      continuing := false;
    loop ()
  in
  try loop () with End_of_file ->
    print_endline "";
    Script.trace "Bye."

let usage = "Usage: " ^ name ^ " [option] [file ...]"
let argspec = Arg.align
[
  "-", Arg.Set Flags.interactive,
    " run interactively (default if no files given)";
  "-s", Arg.Set Flags.print_sig, " print module summary";
  "-d", Arg.Set Flags.dry, " dry, do not run program";
  "-t", Arg.Set Flags.trace, " trace execution";
  "-v", Arg.Unit banner, " show version"
]

let () =
  Printexc.record_backtrace true;
  try
    configure ();
    let files = ref [] in
    Arg.parse argspec (fun file -> files := !files @ [file]) usage;
    if !files = [] then Flags.interactive := true;
    List.iter process_file !files;
    if !Flags.interactive then process_stdin ()
  with exn ->
    flush_all ();
    prerr_endline
      (Sys.argv.(0) ^ ": uncaught exception " ^ Printexc.to_string exn);
    Printexc.print_backtrace stderr;
    exit 2
