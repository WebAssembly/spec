(* File types *)

let sexpr_ext = "wast"
let binary_ext = "wasm"

let dispatch_file_ext on_sexpr on_binary file =
  if Filename.check_suffix file sexpr_ext then
    on_sexpr file
  else if Filename.check_suffix file binary_ext then
    on_binary file
  else
    raise (Sys_error (file ^ ": Unrecognized file type"))


(* Input *)

let error at category msg =
  Script.trace ("Error: ");
  prerr_endline (Source.string_of_region at ^ ": " ^ category ^ ": " ^ msg);
  false

let run_from run get_script =
  try
    let script = get_script () in
    Script.trace "Running...";
    run script;
    true
  with
  | Decode.Code (at, msg) -> error at "decoding error" msg
  | Parse.Syntax (at, msg) -> error at "syntax error" msg
  | Script.Assert (at, msg) -> error at "assertion failure" msg
  | Check.Invalid (at, msg) -> error at "invalid module" msg
  | Import.Unknown (at, msg) -> error at "link failure" msg
  | Eval.Link (at, msg) -> error at "link failure" msg
  | Eval.Trap (at, msg) -> error at "runtime trap" msg
  | Eval.Crash (at, msg) -> error at "runtime crash" msg
  | Script.IO (at, msg) -> error at "i/o error" msg
  | Script.Abort _ -> false

let run_sexpr run name lexbuf start =
  run_from run (fun _ -> Parse.parse name lexbuf start)

let run_binary run name buf =
  let open Source in
  run_from run
    (fun _ ->
      let m = Decode.decode name buf in
      [Script.Module (None, Script.Textual m @@ m.at) @@ m.at])

let run_sexpr_file file run =
  Script.trace ("Loading (" ^ file ^ ")...");
  let ic = open_in file in
  try
    let lexbuf = Lexing.from_channel ic in
    Script.trace "Parsing...";
    let success = run_sexpr run file lexbuf Parse.Script in
    close_in ic;
    success
  with exn -> close_in ic; raise exn

let run_binary_file file run =
  Script.trace ("Loading (" ^ file ^ ")...");
  let ic = open_in_bin file in
  try
    let len = in_channel_length ic in
    let buf = Bytes.make len '\x00' in
    really_input ic buf 0 len;
    Script.trace "Decoding...";
    let success = run_binary run file buf in
    close_in ic;
    success
  with exn -> close_in ic; raise exn

let run_file file =
  dispatch_file_ext run_sexpr_file run_binary_file file Script.run

let run_string string =
  Script.trace ("Running (\"" ^ String.escaped string ^ "\")...");
  let lexbuf = Lexing.from_string string in
  Script.trace "Parsing...";
  run_sexpr Script.run "string" lexbuf Parse.Script

let () = Script.input_file := dispatch_file_ext run_sexpr_file run_binary_file


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
  if n = 1 then continuing := false else Script.trace "Parsing...";
  n

let rec run_stdin () =
  let lexbuf = Lexing.from_function lexbuf_stdin in
  let rec loop () =
    let success = run_sexpr Script.run "stdin" lexbuf Parse.Script1 in
    if not success then Lexing.flush_input lexbuf;
    if Lexing.(lexbuf.lex_curr_pos >= lexbuf.lex_buffer_len - 1) then
      continuing := false;
    loop ()
  in
  try loop () with End_of_file ->
    print_endline "";
    Script.trace "Bye."
