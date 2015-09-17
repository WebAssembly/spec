(*
 * (c) 2015 Andreas Rossberg
 *)

let name = "wasm"
let version = "0.1"

let load file =
  let f = open_in file in
  let size = in_channel_length f + 1 in
  let buf = Bytes.create size in
  let rec loop () =
    let len = input f buf 0 size in
    let source = Bytes.sub_string buf 0 len in
    if len == 0 then source else source ^ loop ()
  in
  let source = loop () in
  close_in f;
  source

let parse name source =
  let lexbuf = Lexing.from_string source in
  lexbuf.Lexing.lex_curr_p <-
    {lexbuf.Lexing.lex_curr_p with Lexing.pos_fname = name};
  try Parser.script Lexer.token lexbuf with Error.Error (region, s) ->
    let region' = if region <> Source.no_region then region else
      {Source.left = Lexer.convert_pos lexbuf.Lexing.lex_start_p;
       Source.right = Lexer.convert_pos lexbuf.Lexing.lex_curr_p} in
    raise (Error.Error (region', s))

let process file source =
  try
    Script.trace "Parsing...";
    let script = parse file source in
    Script.trace "Running...";
    Script.run script;
    true
  with Error.Error (at, s) ->
    Script.trace "Error:";
    prerr_endline (Source.string_of_region at ^ ": " ^ s);
    false

let process_file file =
  Script.trace ("Loading (" ^ file ^ ")...");
  let source = load file in
  if not (process file source) then exit 1

let rec process_stdin () =
  print_string (name ^ "> "); flush_all ();
  match try Some (input_line stdin) with End_of_file -> None with
  | None ->
    print_endline "";
    Script.trace "Bye."
  | Some source ->
    ignore (process "stdin" source);
    process_stdin ()

let greet () =
  print_endline ("Version " ^ version)

let usage = "Usage: " ^ name ^ " [option] [file ...]"
let argspec = Arg.align
[
  "-", Arg.Set Flags.interactive,
    " run interactively (default if no files given)";
  "-s", Arg.Set Flags.print_sig, " show module signatures";
  "-d", Arg.Set Flags.dry, " dry, do not run program";
  "-t", Arg.Set Flags.trace, " trace execution";
  "-v", Arg.Unit greet, " show version"
]

let () =
  Printexc.record_backtrace true;
  try
    let files = ref [] in
    Arg.parse argspec (fun file -> files := !files @ [file]) usage;
    if !files = [] then Flags.interactive := true;
    List.iter process_file !files;
    if !Flags.interactive then process_stdin ()
  with exn ->
    flush stdout;
    prerr_endline
      (Sys.argv.(0) ^ ": uncaught exception " ^ Printexc.to_string exn);
    Printexc.print_backtrace stderr;
    exit 2
