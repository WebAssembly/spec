open Util

let parse_lexbuf name lexbuf =
  let open Lexing in
  lexbuf.lex_curr_p <- {lexbuf.lex_curr_p with pos_fname = name};
  try
    Parser.script Lexer.token lexbuf
  with Source.Error (region, s) ->
    let region' = if region <> Source.no_region then region else
      {Source.left = Lexer.convert_pos lexbuf.lex_start_p;
       Source.right = Lexer.convert_pos lexbuf.lex_curr_p} in
    raise (Source.Error (region', s))

let parse_string s =
  let lexbuf = Lexing.from_string s in
  parse_lexbuf "string" lexbuf

let parse_file file =
  let ic = open_in file in
  try
    let lexbuf = Lexing.from_channel ic in
    let ast = parse_lexbuf file lexbuf in
    close_in ic;
    ast
  with exn -> close_in ic; raise exn
