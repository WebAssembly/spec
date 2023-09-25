{
open Parser
open Util

let convert_pos pos =
  Source.{
    file = pos.Lexing.pos_fname;
    line = pos.Lexing.pos_lnum;
    column = pos.Lexing.pos_cnum - pos.Lexing.pos_bol
  }

let region lexbuf =
  let left = convert_pos (Lexing.lexeme_start_p lexbuf) in
  let right = convert_pos (Lexing.lexeme_end_p lexbuf) in
  Source.{left = left; right = right}

let error lexbuf msg = raise (Source.Error (region lexbuf, msg))
let error_nest start lexbuf msg =
  lexbuf.Lexing.lex_start_p <- start;
  error lexbuf msg

let nat lexbuf s =
  try
    let n = int_of_string s in
    if n >= 0 then n else raise (Failure "")
  with Failure _ -> error lexbuf "nat literal out of range"

let text _lexbuf s =
  let b = Buffer.create (String.length s) in
  let i = ref 1 in
  while !i < String.length s - 1 do
    let c = if s.[!i] <> '\\' then s.[!i] else
      match (incr i; s.[!i]) with
      | 'n' -> '\n'
      | 'r' -> '\r'
      | 't' -> '\t'
      | '\\' -> '\\'
      | '\'' -> '\''
      | '\"' -> '\"'
      | 'u' ->
        let j = !i + 2 in
        i := String.index_from s j '}';
        let n = int_of_string ("0x" ^ String.sub s j (!i - j)) in
        let bs = Utf8.encode [n] in
        Buffer.add_substring b bs 0 (String.length bs - 1);
        bs.[String.length bs - 1]
      | h ->
        incr i;
        Char.chr (int_of_string ("0x" ^ String.make 1 h ^ String.make 1 s.[!i]))
    in Buffer.add_char b c;
    incr i
  done;
  Buffer.contents b

let is_var s =
  (* Glorious hack to access parser state! *)
  let s = [|UPID s; EOF|] in
  let i = ref (-1) in
  Parser.check_atom (fun _ -> incr i; s.(!i)) (Lexing.from_string "")

}

let sign = '+' | '-'
let digit = ['0'-'9']
let hexdigit = ['0'-'9''a'-'f''A'-'F']
let num = digit ('_'? digit)*
let hexnum = hexdigit ('_'? hexdigit)*
let nat = num | "0x" hexnum
let int = sign nat

let upletter = ['A'-'Z']
let loletter = ['a'-'z']
let letter = upletter | loletter
let idchar = letter | digit | '_' | '\''

let upid = (upletter | '_') idchar*
let loid = (loletter | '`') idchar*
let id = upid | loid
let atomid = upid
let typid = loid
let expid = loid
let defid = id
let metaid = id

let symbol =
  ['+''-''*''/''\\''^''~''=''<''>''!''?''@''#''$''%''&''|'':''`''.''\'']

let space = [' ''\t''\n''\r']
let control = ['\x00'-'\x1f'] # space
let ascii = ['\x00'-'\x7f']
let ascii_no_nl = ascii # '\x0a'
let utf8cont = ['\x80'-'\xbf']
let utf8enc =
    ['\xc2'-'\xdf'] utf8cont
  | ['\xe0'] ['\xa0'-'\xbf'] utf8cont
  | ['\xed'] ['\x80'-'\x9f'] utf8cont
  | ['\xe1'-'\xec''\xee'-'\xef'] utf8cont utf8cont
  | ['\xf0'] ['\x90'-'\xbf'] utf8cont utf8cont
  | ['\xf4'] ['\x80'-'\x8f'] utf8cont utf8cont
  | ['\xf1'-'\xf3'] utf8cont utf8cont utf8cont
let utf8 = ascii | utf8enc
let utf8_no_nl = ascii_no_nl | utf8enc

let escape = ['n''r''t''\\''\'''\"']
let character =
    [^'"''\\''\x00'-'\x1f''\x7f'-'\xff']
  | utf8enc
  | '\\'escape
  | '\\'hexdigit hexdigit
  | "\\u{" hexnum '}'
let text = '"' character* '"'

let indent = [' ''\t']
let line_comment = ";;"utf8_no_nl*

rule token = parse
  | "(" { LPAR }
  | ")" { RPAR }
  | "[" { LBRACK }
  | "]" { RBRACK }
  | "{" { LBRACE }
  | "}" { RBRACE }
  | ":" { COLON }
  | ";" { SEMICOLON }
  | "," { COMMA }
  | "." { DOT }
  | ".." { DOTDOT }
  | "..." { DOTDOTDOT }
  | "|" { BAR }
  | "--" { DASH }

  | "," indent* line_comment? '\n'
    { Lexing.new_line lexbuf; COMMA_NL }
  | line_comment? '\n' indent* "|"[' ''\t']
    { Lexing.new_line lexbuf; NL_BAR }
  | line_comment? '\n' indent* '\n' (indent* line_comment '\n')* indent* "--"
    { Lexing.new_line lexbuf; Lexing.new_line lexbuf; NL_NL_DASH }
  | line_comment? '\n' indent* '\n' indent* '\n'
    { Lexing.new_line lexbuf; Lexing.new_line lexbuf; Lexing.new_line lexbuf;
      NL_NL_NL }

  | "=" { EQ }
  | "=/=" { NE }
  | "<" { LT }
  | ">" { GT }
  | "<=" { LE }
  | ">=" { GE }
  | "~~" { APPROX }
  | "<:" { SUB }
  | ":=" { ASSIGN }
  | "=.." { EQDOT2 }

  | "~" { NOT }
  | "/\\" { AND }
  | "\\/" { OR }

  | "?" { QUEST }
  | "+" { PLUS }
  | "-" { MINUS }
  | "*" { STAR }
  | "/" { SLASH }
  | "\\" { BACKSLASH }
  | "^" { UP }
  | "++" { COMPOSE }

  | "in" { IN }
  | "->" { ARROW }
  | "=>" { ARROW2 }
  | "<=>" { DARROW2 }
  | "~>" { SQARROW }
  | "~>*" { SQARROWSTAR }
  | "<<" { PREC }
  | ">>" { SUCC }
  | "|-" { TURNSTILE }
  | "-|" { TILESTURN }

  | "$" { DOLLAR }

  | "_|_" { BOT }
  | "%" { HOLE }
  | "%%" { MULTIHOLE }
  | "#" { FUSE }

  | "`" { TICK }

  | "bool" { BOOL }
  | "nat" { NAT }
  | "text" { TEXT }

  | "syntax" { SYNTAX }
  | "relation" { RELATION }
  | "rule" { RULE }
  | "var" { VAR }
  | "def" { DEF }

  | "if" { IF }
  | "otherwise" { OTHERWISE }
  | "hint" { HINT }

  | "epsilon" { EPSILON }
  | "true" { BOOLLIT true }
  | "false" { BOOLLIT false }
  | nat as s { NATLIT (nat lexbuf s) }
  | text as s { TEXTLIT (text lexbuf s) }
  | '"'character*('\n'|eof) { error lexbuf "unclosed text literal" }
  | '"'character*['\x00'-'\x09''\x0b'-'\x1f''\x7f']
    { error lexbuf "illegal control character in text literal" }
  | '"'character*'\\'_
    { error_nest (Lexing.lexeme_end_p lexbuf) lexbuf "illegal escape" }

  | upid as s { if is_var s then LOID s else UPID s }
  | loid as s { LOID s }
  | "."(id as s) { DOTID s }

  | ";;"utf8_no_nl*eof { EOF }
  | ";;"utf8_no_nl*'\n' { Lexing.new_line lexbuf; token lexbuf }
  | ";;"utf8_no_nl* { token lexbuf (* causes error on following position *) }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; token lexbuf }
  | space#'\n' { token lexbuf }
  | '\n' { Lexing.new_line lexbuf; token lexbuf }
  | eof { EOF }

  | control { error lexbuf "misplaced control character" }
  | utf8enc { error lexbuf "misplaced unicode character" }
  | _ { error lexbuf "malformed token or UTF-8 encoding" }

and comment start = parse
  | ";)" { () }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; comment start lexbuf }
  | '\n' { Lexing.new_line lexbuf; comment start lexbuf }
  | utf8_no_nl { comment start lexbuf }
  | eof { error_nest start lexbuf "unclosed comment" }
  | _ { error lexbuf "malformed UTF-8 encoding" }
