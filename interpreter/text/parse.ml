type 'a start =
  | Module : (Script.var option * Script.definition) start
  | Script : Script.script start
  | Script1 : Script.script start

exception Syntax = Script.Syntax


let wrap_lexbuf lexbuf =
  let open Lexing in
  let inner_refill = lexbuf.refill_buff in
  let refill_buff lexbuf =
    let oldlen = lexbuf.lex_buffer_len - lexbuf.lex_start_pos in
    inner_refill lexbuf;
    let newlen = lexbuf.lex_buffer_len - lexbuf.lex_start_pos in
    let start = lexbuf.lex_start_pos + oldlen in
    let n = newlen - oldlen in
    Buffer.add_subbytes Annot.current_source lexbuf.lex_buffer start n
  in
  let n = lexbuf.lex_buffer_len - lexbuf.lex_start_pos in
  Buffer.add_subbytes Annot.current_source lexbuf.lex_buffer lexbuf.lex_start_pos n;
  {lexbuf with refill_buff}

let parse' name lexbuf start =
  Annot.reset ();
  let lexbuf = wrap_lexbuf lexbuf in
  lexbuf.Lexing.lex_curr_p <-
    {lexbuf.Lexing.lex_curr_p with Lexing.pos_fname = name};
  try
    let result = start Lexer.token lexbuf in
    let annots = Annot.get_all () in
    if not (Annot.NameMap.is_empty annots) then
      let annot = List.hd (snd (Annot.NameMap.choose annots)) in
      raise (Custom.Syntax (annot.Source.at, "misplaced annotation"))
    else
      result
  with Syntax (region, s) ->
    let region' = if region <> Source.no_region then region else
      {Source.left = Lexer.convert_pos lexbuf.Lexing.lex_start_p;
       Source.right = Lexer.convert_pos lexbuf.Lexing.lex_curr_p} in
    raise (Syntax (region', s))

let parse (type a) name lexbuf : a start -> a = function
  | Module -> parse' name lexbuf Parser.module1
  | Script -> parse' name lexbuf Parser.script
  | Script1 -> parse' name lexbuf Parser.script1

let string_to start s =
  let lexbuf = Lexing.from_string s in
  parse "string" lexbuf start

let string_to_script s = string_to Script s
let string_to_module s = snd (string_to Module s)
