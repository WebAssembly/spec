{
open Parser
open Operators

let convert_pos pos =
  { Source.file = pos.Lexing.pos_fname;
    Source.line = pos.Lexing.pos_lnum;
    Source.column = pos.Lexing.pos_cnum - pos.Lexing.pos_bol
  }

let region lexbuf =
  let left = convert_pos (Lexing.lexeme_start_p lexbuf) in
  let right = convert_pos (Lexing.lexeme_end_p lexbuf) in
  {Source.left = left; Source.right = right}

let error lexbuf msg = raise (Script.Syntax (region lexbuf, msg))
let error_nest start lexbuf msg =
  lexbuf.Lexing.lex_start_p <- start;
  error lexbuf msg

let string s =
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

let value_type = function
  | "i32" -> Types.I32Type
  | "i64" -> Types.I64Type
  | "f32" -> Types.F32Type
  | "f64" -> Types.F64Type
  | _ -> assert false

let intop t i32 i64 =
  match t with
  | "i32" -> i32
  | "i64" -> i64
  | _ -> assert false

let floatop t f32 f64 =
  match t with
  | "f32" -> f32
  | "f64" -> f64
  | _ -> assert false

let numop t i32 i64 f32 f64 =
  match t with
  | "i32" -> i32
  | "i64" -> i64
  | "f32" -> f32
  | "f64" -> f64
  | _ -> assert false

let memsz sz m8 m16 m32 =
  match sz with
  | "8" -> m8
  | "16" -> m16
  | "32" -> m32
  | _ -> assert false

let ext e s u =
  match e with
  | 's' -> s
  | 'u' -> u
  | _ -> assert false

let opt = Lib.Option.get
}

let sign = '+' | '-'
let digit = ['0'-'9']
let hexdigit = ['0'-'9''a'-'f''A'-'F']
let num = digit ('_'? digit)*
let hexnum = hexdigit ('_'? hexdigit)*

let letter = ['a'-'z''A'-'Z']
let symbol =
  ['+''-''*''/''\\''^''~''=''<''>''!''?''@''#''$''%''&''|'':''`''.''\'']

let space = [' ''\t''\n''\r']
let ascii = ['\x00'-'\x7f']
let ascii_no_nl = ['\x00'-'\x09''\x0b'-'\x7f']
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

let nat = num | "0x" hexnum
let int = sign nat
let frac = num
let hexfrac = hexnum
let float =
    sign? num '.' frac?
  | sign? num ('.' frac?)? ('e' | 'E') sign? num
  | sign? "0x" hexnum '.' hexfrac?
  | sign? "0x" hexnum ('.' hexfrac?)? ('p' | 'P') sign? num
  | sign? "inf"
  | sign? "nan"
  | sign? "nan:" "0x" hexnum
let string = '"' character* '"'
let name = '$' (letter | digit | '_' | symbol)+
let reserved = ([^'\"''('')'';'] # space)+  (* hack for table size *)

let ixx = "i" ("32" | "64")
let fxx = "f" ("32" | "64")
let nxx = ixx | fxx
let mixx = "i" ("8" | "16" | "32" | "64")
let mfxx = "f" ("32" | "64")
let sign = "s" | "u"
let mem_size = "8" | "16" | "32"

rule token = parse
  | "(" { LPAR }
  | ")" { RPAR }

  | nat as s { NAT s }
  | int as s { INT s }
  | float as s { FLOAT s }

  | string as s { STRING (string s) }
  | '"'character*('\n'|eof) { error lexbuf "unclosed string literal" }
  | '"'character*['\x00'-'\x09''\x0b'-'\x1f''\x7f']
    { error lexbuf "illegal control character in string literal" }
  | '"'character*'\\'_
    { error_nest (Lexing.lexeme_end_p lexbuf) lexbuf "illegal escape" }

  | (nxx as t) { VALUE_TYPE (value_type t) }
  | (nxx as t)".const"
    { let open Source in
      CONST (numop t
        (fun s -> let n = I32.of_string s.it in
          i32_const (n @@ s.at), Values.I32 n)
        (fun s -> let n = I64.of_string s.it in
          i64_const (n @@ s.at), Values.I64 n)
        (fun s -> let n = F32.of_string s.it in
          f32_const (n @@ s.at), Values.F32 n)
        (fun s -> let n = F64.of_string s.it in
          f64_const (n @@ s.at), Values.F64 n))
    }
  | "anyfunc" { ANYFUNC }
  | "mut" { MUT }

  | "nop" { NOP }
  | "unreachable" { UNREACHABLE }
  | "drop" { DROP }
  | "block" { BLOCK }
  | "loop" { LOOP }
  | "end" { END }
  | "br" { BR }
  | "br_if" { BR_IF }
  | "br_table" { BR_TABLE }
  | "return" { RETURN }
  | "if" { IF }
  | "then" { THEN }
  | "else" { ELSE }
  | "select" { SELECT }
  | "call" { CALL }
  | "call_indirect" { CALL_INDIRECT }

  | "get_local" { GET_LOCAL }
  | "set_local" { SET_LOCAL }
  | "tee_local" { TEE_LOCAL }
  | "get_global" { GET_GLOBAL }
  | "set_global" { SET_GLOBAL }

  | (nxx as t)".load"
    { LOAD (fun a o ->
        numop t (i32_load (opt a 2)) (i64_load (opt a 3))
                (f32_load (opt a 2)) (f64_load (opt a 3)) o) }
  | (nxx as t)".store"
    { STORE (fun a o ->
        numop t (i32_store (opt a 2)) (i64_store (opt a 3))
                (f32_store (opt a 2)) (f64_store (opt a 3)) o) }
  | (ixx as t)".load"(mem_size as sz)"_"(sign as s)
    { if t = "i32" && sz = "32" then error lexbuf "unknown operator";
      LOAD (fun a o ->
        intop t
          (memsz sz
            (ext s i32_load8_s i32_load8_u (opt a 0))
            (ext s i32_load16_s i32_load16_u (opt a 1))
            (fun _ -> unreachable) o)
          (memsz sz
            (ext s i64_load8_s i64_load8_u (opt a 0))
            (ext s i64_load16_s i64_load16_u (opt a 1))
            (ext s i64_load32_s i64_load32_u (opt a 2)) o)) }
  | (ixx as t)".store"(mem_size as sz)
    { if t = "i32" && sz = "32" then error lexbuf "unknown operator";
      STORE (fun a o ->
        intop t
          (memsz sz
            (i32_store8 (opt a 0))
            (i32_store16 (opt a 1))
            (fun _ -> unreachable) o)
          (memsz sz
            (i64_store8 (opt a 0))
            (i64_store16 (opt a 1))
            (i64_store32 (opt a 2)) o)) }

  | "offset="(nat as s) { OFFSET_EQ_NAT s }
  | "align="(nat as s) { ALIGN_EQ_NAT s }

  | (ixx as t)".clz" { UNARY (intop t i32_clz i64_clz) }
  | (ixx as t)".ctz" { UNARY (intop t i32_ctz i64_ctz) }
  | (ixx as t)".popcnt" { UNARY (intop t i32_popcnt i64_popcnt) }
  | (fxx as t)".neg" { UNARY (floatop t f32_neg f64_neg) }
  | (fxx as t)".abs" { UNARY (floatop t f32_abs f64_abs) }
  | (fxx as t)".sqrt" { UNARY (floatop t f32_sqrt f64_sqrt) }
  | (fxx as t)".ceil" { UNARY (floatop t f32_ceil f64_ceil) }
  | (fxx as t)".floor" { UNARY (floatop t f32_floor f64_floor) }
  | (fxx as t)".trunc" { UNARY (floatop t f32_trunc f64_trunc) }
  | (fxx as t)".nearest" { UNARY (floatop t f32_nearest f64_nearest) }

  | (ixx as t)".add" { BINARY (intop t i32_add i64_add) }
  | (ixx as t)".sub" { BINARY (intop t i32_sub i64_sub) }
  | (ixx as t)".mul" { BINARY (intop t i32_mul i64_mul) }
  | (ixx as t)".div_s" { BINARY (intop t i32_div_s i64_div_s) }
  | (ixx as t)".div_u" { BINARY (intop t i32_div_u i64_div_u) }
  | (ixx as t)".rem_s" { BINARY (intop t i32_rem_s i64_rem_s) }
  | (ixx as t)".rem_u" { BINARY (intop t i32_rem_u i64_rem_u) }
  | (ixx as t)".and" { BINARY (intop t i32_and i64_and) }
  | (ixx as t)".or" { BINARY (intop t i32_or i64_or) }
  | (ixx as t)".xor" { BINARY (intop t i32_xor i64_xor) }
  | (ixx as t)".shl" { BINARY (intop t i32_shl i64_shl) }
  | (ixx as t)".shr_s" { BINARY (intop t i32_shr_s i64_shr_s) }
  | (ixx as t)".shr_u" { BINARY (intop t i32_shr_u i64_shr_u) }
  | (ixx as t)".rotl" { BINARY (intop t i32_rotl i64_rotl) }
  | (ixx as t)".rotr" { BINARY (intop t i32_rotr i64_rotr) }
  | (fxx as t)".add" { BINARY (floatop t f32_add f64_add) }
  | (fxx as t)".sub" { BINARY (floatop t f32_sub f64_sub) }
  | (fxx as t)".mul" { BINARY (floatop t f32_mul f64_mul) }
  | (fxx as t)".div" { BINARY (floatop t f32_div f64_div) }
  | (fxx as t)".min" { BINARY (floatop t f32_min f64_min) }
  | (fxx as t)".max" { BINARY (floatop t f32_max f64_max) }
  | (fxx as t)".copysign" { BINARY (floatop t f32_copysign f64_copysign) }

  | (ixx as t)".eqz" { TEST (intop t i32_eqz i64_eqz) }

  | (ixx as t)".eq" { COMPARE (intop t i32_eq i64_eq) }
  | (ixx as t)".ne" { COMPARE (intop t i32_ne i64_ne) }
  | (ixx as t)".lt_s" { COMPARE (intop t i32_lt_s i64_lt_s) }
  | (ixx as t)".lt_u" { COMPARE (intop t i32_lt_u i64_lt_u) }
  | (ixx as t)".le_s" { COMPARE (intop t i32_le_s i64_le_s) }
  | (ixx as t)".le_u" { COMPARE (intop t i32_le_u i64_le_u) }
  | (ixx as t)".gt_s" { COMPARE (intop t i32_gt_s i64_gt_s) }
  | (ixx as t)".gt_u" { COMPARE (intop t i32_gt_u i64_gt_u) }
  | (ixx as t)".ge_s" { COMPARE (intop t i32_ge_s i64_ge_s) }
  | (ixx as t)".ge_u" { COMPARE (intop t i32_ge_u i64_ge_u) }
  | (fxx as t)".eq" { COMPARE (floatop t f32_eq f64_eq) }
  | (fxx as t)".ne" { COMPARE (floatop t f32_ne f64_ne) }
  | (fxx as t)".lt" { COMPARE (floatop t f32_lt f64_lt) }
  | (fxx as t)".le" { COMPARE (floatop t f32_le f64_le) }
  | (fxx as t)".gt" { COMPARE (floatop t f32_gt f64_gt) }
  | (fxx as t)".ge" { COMPARE (floatop t f32_ge f64_ge) }

  | "i32.wrap/i64" { CONVERT i32_wrap_i64 }
  | "i64.extend_s/i32" { CONVERT i64_extend_s_i32 }
  | "i64.extend_u/i32" { CONVERT i64_extend_u_i32 }
  | "f32.demote/f64" { CONVERT f32_demote_f64 }
  | "f64.promote/f32" { CONVERT f64_promote_f32 }
  | (ixx as t)".trunc_s/f32"
    { CONVERT (intop t i32_trunc_s_f32 i64_trunc_s_f32) }
  | (ixx as t)".trunc_u/f32"
    { CONVERT (intop t i32_trunc_u_f32 i64_trunc_u_f32) }
  | (ixx as t)".trunc_s/f64"
    { CONVERT (intop t i32_trunc_s_f64 i64_trunc_s_f64) }
  | (ixx as t)".trunc_u/f64"
    { CONVERT (intop t i32_trunc_u_f64 i64_trunc_u_f64) }
  | (fxx as t)".convert_s/i32"
    { CONVERT (floatop t f32_convert_s_i32 f64_convert_s_i32) }
  | (fxx as t)".convert_u/i32"
    { CONVERT (floatop t f32_convert_u_i32 f64_convert_u_i32) }
  | (fxx as t)".convert_s/i64"
    { CONVERT (floatop t f32_convert_s_i64 f64_convert_s_i64) }
  | (fxx as t)".convert_u/i64"
    { CONVERT (floatop t f32_convert_u_i64 f64_convert_u_i64) }
  | "f32.reinterpret/i32" { CONVERT f32_reinterpret_i32 }
  | "f64.reinterpret/i64" { CONVERT f64_reinterpret_i64 }
  | "i32.reinterpret/f32" { CONVERT i32_reinterpret_f32 }
  | "i64.reinterpret/f64" { CONVERT i64_reinterpret_f64 }

  | "current_memory" { CURRENT_MEMORY }
  | "grow_memory" { GROW_MEMORY }

  | "type" { TYPE }
  | "func" { FUNC }
  | "start" { START }
  | "param" { PARAM }
  | "result" { RESULT }
  | "local" { LOCAL }
  | "global" { GLOBAL }
  | "table" { TABLE }
  | "memory" { MEMORY }
  | "elem" { ELEM }
  | "data" { DATA }
  | "offset" { OFFSET }
  | "import" { IMPORT }
  | "export" { EXPORT }

  | "module" { MODULE }
  | "merkle" { MERKLE }
  | "binary" { BIN }
  | "quote" { QUOTE }

  | "script" { SCRIPT }
  | "register" { REGISTER }
  | "invoke" { INVOKE }
  | "get" { GET }
  | "assert_malformed" { ASSERT_MALFORMED }
  | "assert_invalid" { ASSERT_INVALID }
  | "assert_unlinkable" { ASSERT_UNLINKABLE }
  | "assert_return" { ASSERT_RETURN }
  | "assert_return_canonical_nan" { ASSERT_RETURN_CANONICAL_NAN }
  | "assert_return_arithmetic_nan" { ASSERT_RETURN_ARITHMETIC_NAN }
  | "assert_trap" { ASSERT_TRAP }
  | "assert_exhaustion" { ASSERT_EXHAUSTION }
  | "input" { INPUT }
  | "output" { OUTPUT }

  | name as s { VAR s }

  | ";;"utf8_no_nl*eof { EOF }
  | ";;"utf8_no_nl*'\n' { Lexing.new_line lexbuf; token lexbuf }
  | ";;"utf8_no_nl* { token lexbuf (* causes error on following position *) }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; token lexbuf }
  | space#'\n' { token lexbuf }
  | '\n' { Lexing.new_line lexbuf; token lexbuf }
  | eof { EOF }

  | reserved { error lexbuf "unknown operator" }
  | utf8 { error lexbuf "malformed operator" }
  | _ { error lexbuf "malformed UTF-8 encoding" }

and comment start = parse
  | ";)" { () }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; comment start lexbuf }
  | '\n' { Lexing.new_line lexbuf; comment start lexbuf }
  | eof { error_nest start lexbuf "unclosed comment" }
  | utf8 { comment start lexbuf }
  | _ { error lexbuf "malformed UTF-8 encoding" }
