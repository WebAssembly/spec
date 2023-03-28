open Util

let with_lexbuf name lexbuf start =
  let open Lexing in
  lexbuf.lex_curr_p <- {lexbuf.lex_curr_p with pos_fname = name};
  try
    start Lexer.token lexbuf
  with Source.Error (region, s) ->
    let region' = if region <> Source.no_region then region else
      {Source.left = Lexer.convert_pos lexbuf.lex_start_p;
       Source.right = Lexer.convert_pos lexbuf.lex_curr_p} in
    raise (Source.Error (region', s))

let parse_exp s =
  let lexbuf = Lexing.from_string s in
  with_lexbuf "string" lexbuf Parser.exp

let parse_script s =
  let lexbuf = Lexing.from_string s in
  with_lexbuf "string" lexbuf Parser.script

let parse_file file =
  let ic = open_in file in
  try
    Fun.protect
      (fun () -> with_lexbuf file (Lexing.from_channel ic) Parser.script)
      ~finally:(fun () -> close_in ic)
  with Sys_error msg ->
    raise (Source.Error (Source.region_of_file file, "i/o error: " ^ msg))
