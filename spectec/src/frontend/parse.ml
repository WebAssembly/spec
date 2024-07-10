open Util

let with_lexbuf name lexbuf start =
  let open Lexing in
  lexbuf.lex_curr_p <- {lexbuf.lex_curr_p with pos_fname = name};
  try
    start Lexer.token lexbuf
  with Parser.Error ->
    raise (Error.Error (Lexer.region lexbuf, "syntax error: unexpected token"))

let parse_typ s =
  let lexbuf = Lexing.from_string s in
  with_lexbuf "(string)" lexbuf Parser.typ_eof

let parse_exp s =
  let lexbuf = Lexing.from_string s in
  with_lexbuf "(string)" lexbuf Parser.exp_eof

let parse_sym s =
  let lexbuf = Lexing.from_string s in
  with_lexbuf "(string)" lexbuf Parser.sym_eof

let parse_script s =
  let lexbuf = Lexing.from_string s in
  with_lexbuf "(string)" lexbuf Parser.script

let parse_file file =
  let ic = open_in file in
  try
    Fun.protect
      (fun () -> with_lexbuf file (Lexing.from_channel ic) Parser.script)
      ~finally:(fun () -> close_in ic)
  with Sys_error msg ->
    raise (Error.Error (Source.region_of_file file, "i/o error: " ^ msg))
