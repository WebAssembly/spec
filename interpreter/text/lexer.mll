{
open Parser
open Operators
open Source

let convert_pos pos =
  { file = pos.Lexing.pos_fname;
    line = pos.Lexing.pos_lnum;
    column = pos.Lexing.pos_cnum - pos.Lexing.pos_bol
  }

let region lexbuf =
  let left = convert_pos (Lexing.lexeme_start_p lexbuf) in
  let right = convert_pos (Lexing.lexeme_end_p lexbuf) in
  {left = left; right = right}

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

let idchar = letter | digit | '_' | symbol
let name = idchar+
let id = '$' name

let keyword = ['a'-'z'] (letter | digit | '_' | '.' | ':')+
let reserved = name | ',' | ';' | '[' | ']' | '{' | '}'

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

  | keyword as s
    { match s with
      | "i32" -> NUM_TYPE Types.I32Type
      | "i64" -> NUM_TYPE Types.I64Type
      | "f32" -> NUM_TYPE Types.F32Type
      | "f64" -> NUM_TYPE Types.F64Type
      | "extern" -> EXTERN
      | "externref" -> EXTERNREF
      | "funcref" -> FUNCREF
      | "mut" -> MUT

      | "nop" -> NOP
      | "unreachable" -> UNREACHABLE
      | "drop" -> DROP
      | "block" -> BLOCK
      | "loop" -> LOOP
      | "end" -> END
      | "br" -> BR
      | "br_if" -> BR_IF
      | "br_table" -> BR_TABLE
      | "return" -> RETURN
      | "if" -> IF
      | "then" -> THEN
      | "else" -> ELSE
      | "select" -> SELECT
      | "call" -> CALL
      | "call_indirect" -> CALL_INDIRECT

      | "local.get" -> LOCAL_GET
      | "local.set" -> LOCAL_SET
      | "local.tee" -> LOCAL_TEE
      | "global.get" -> GLOBAL_GET
      | "global.set" -> GLOBAL_SET

      | "table.get" -> TABLE_GET
      | "table.set" -> TABLE_SET
      | "table.size" -> TABLE_SIZE
      | "table.grow" -> TABLE_GROW
      | "table.fill" -> TABLE_FILL
      | "table.copy" -> TABLE_COPY
      | "table.init" -> TABLE_INIT
      | "elem.drop" -> ELEM_DROP

      | "memory.size" -> MEMORY_SIZE
      | "memory.grow" -> MEMORY_GROW
      | "memory.fill" -> MEMORY_FILL
      | "memory.copy" -> MEMORY_COPY
      | "memory.init" -> MEMORY_INIT
      | "data.drop" -> DATA_DROP

      | "i32.load" -> LOAD (fun a o -> i32_load (opt a 2) o)
      | "i64.load" -> LOAD (fun a o -> i64_load (opt a 3) o)
      | "f32.load" -> LOAD (fun a o -> f32_load (opt a 2) o)
      | "f64.load" -> LOAD (fun a o -> f64_load (opt a 3) o)
      | "i32.store" -> STORE (fun a o -> i32_store (opt a 2) o)
      | "i64.store" -> STORE (fun a o -> i64_store (opt a 3) o)
      | "f32.store" -> STORE (fun a o -> f32_store (opt a 2) o)
      | "f64.store" -> STORE (fun a o -> f64_store (opt a 3) o)

      | "i32.load8_u" -> LOAD (fun a o -> i32_load8_u (opt a 0) o)
      | "i32.load8_s" -> LOAD (fun a o -> i32_load8_s (opt a 0) o)
      | "i32.load16_u" -> LOAD (fun a o -> i32_load16_u (opt a 1) o)
      | "i32.load16_s" -> LOAD (fun a o -> i32_load16_s (opt a 1) o)
      | "i64.load8_u" -> LOAD (fun a o -> i64_load8_u (opt a 0) o)
      | "i64.load8_s" -> LOAD (fun a o -> i64_load8_s (opt a 0) o)
      | "i64.load16_u" -> LOAD (fun a o -> i64_load16_u (opt a 1) o)
      | "i64.load16_s" -> LOAD (fun a o -> i64_load16_s (opt a 1) o)
      | "i64.load32_u" -> LOAD (fun a o -> i64_load32_u (opt a 2) o)
      | "i64.load32_s" -> LOAD (fun a o -> i64_load32_s (opt a 2) o)

      | "i32.store8" -> LOAD (fun a o -> i32_store8 (opt a 0) o)
      | "i32.store16" -> LOAD (fun a o -> i32_store16 (opt a 1) o)
      | "i64.store8" -> LOAD (fun a o -> i64_store8 (opt a 0) o)
      | "i64.store16" -> LOAD (fun a o -> i64_store16 (opt a 1) o)
      | "i64.store32" -> LOAD (fun a o -> i64_store32 (opt a 2) o)

      | "i32.const" ->
        CONST (fun s ->
          let n = I32.of_string s.it in i32_const (n @@ s.at), Values.I32 n)
      | "i64.const" ->
        CONST (fun s ->
          let n = I64.of_string s.it in i64_const (n @@ s.at), Values.I64 n)
      | "f32.const" ->
        CONST (fun s ->
          let n = F32.of_string s.it in f32_const (n @@ s.at), Values.F32 n)
      | "f64.const" ->
        CONST (fun s ->
          let n = F64.of_string s.it in f64_const (n @@ s.at), Values.F64 n)

      | "ref.null" -> REF_NULL
      | "ref.func" -> REF_FUNC
      | "ref.extern" -> REF_EXTERN
      | "ref.is_null" -> REF_IS_NULL

      | "i32.clz" -> UNARY i32_clz
      | "i32.ctz" -> UNARY i32_ctz
      | "i32.popcnt" -> UNARY i32_popcnt
      | "i32.extend8_s" -> UNARY i32_extend8_s
      | "i32.extend16_s" -> UNARY i32_extend16_s
      | "i64.clz" -> UNARY i64_clz
      | "i64.ctz" -> UNARY i64_ctz
      | "i64.popcnt" -> UNARY i64_popcnt
      | "i64.extend8_s" -> UNARY i64_extend8_s
      | "i64.extend16_s" -> UNARY i64_extend16_s
      | "i64.extend32_s" -> UNARY i64_extend32_s

      | "f32.neg" -> UNARY f32_neg
      | "f32.abs" -> UNARY f32_abs
      | "f32.sqrt" -> UNARY f32_sqrt
      | "f32.ceil" -> UNARY f32_ceil
      | "f32.floor" -> UNARY f32_floor
      | "f32.trunc" -> UNARY f32_trunc
      | "f32.nearest" -> UNARY f32_nearest
      | "f64.neg" -> UNARY f64_neg
      | "f64.abs" -> UNARY f64_abs
      | "f64.sqrt" -> UNARY f64_sqrt
      | "f64.ceil" -> UNARY f64_ceil
      | "f64.floor" -> UNARY f64_floor
      | "f64.trunc" -> UNARY f64_trunc
      | "f64.nearest" -> UNARY f64_nearest

      | "i32.add" -> BINARY i32_add
      | "i32.sub" -> BINARY i32_sub
      | "i32.mul" -> BINARY i32_mul
      | "i32.div_u" -> BINARY i32_div_u
      | "i32.div_s" -> BINARY i32_div_s
      | "i32.rem_u" -> BINARY i32_rem_u
      | "i32.rem_s" -> BINARY i32_rem_s
      | "i32.and" -> BINARY i32_and
      | "i32.or" -> BINARY i32_or
      | "i32.xor" -> BINARY i32_xor
      | "i32.shl" -> BINARY i32_shl
      | "i32.shr_u" -> BINARY i32_shr_u
      | "i32.shr_s" -> BINARY i32_shr_s
      | "i32.rotl" -> BINARY i32_rotl
      | "i32.rotr" -> BINARY i32_rotr
      | "i64.add" -> BINARY i64_add
      | "i64.sub" -> BINARY i64_sub
      | "i64.mul" -> BINARY i64_mul
      | "i64.div_u" -> BINARY i64_div_u
      | "i64.div_s" -> BINARY i64_div_s
      | "i64.rem_u" -> BINARY i64_rem_u
      | "i64.rem_s" -> BINARY i64_rem_s
      | "i64.and" -> BINARY i64_and
      | "i64.or" -> BINARY i64_or
      | "i64.xor" -> BINARY i64_xor
      | "i64.shl" -> BINARY i64_shl
      | "i64.shr_u" -> BINARY i64_shr_u
      | "i64.shr_s" -> BINARY i64_shr_s
      | "i64.rotl" -> BINARY i64_rotl
      | "i64.rotr" -> BINARY i64_rotr

      | "f32.add" -> BINARY f32_add
      | "f32.sub" -> BINARY f32_sub
      | "f32.mul" -> BINARY f32_mul
      | "f32.div" -> BINARY f32_div
      | "f32.min" -> BINARY f32_min
      | "f32.max" -> BINARY f32_max
      | "f32.copysign" -> BINARY f32_copysign
      | "f64.add" -> BINARY f64_add
      | "f64.sub" -> BINARY f64_sub
      | "f64.mul" -> BINARY f64_mul
      | "f64.div" -> BINARY f64_div
      | "f64.min" -> BINARY f64_min
      | "f64.max" -> BINARY f64_max
      | "f64.copysign" -> BINARY f64_copysign

      | "i32.eqz" -> TEST i32_eqz
      | "i64.eqz" -> TEST i64_eqz

      | "i32.eq" -> COMPARE i32_eq
      | "i32.ne" -> COMPARE i32_ne
      | "i32.lt_u" -> COMPARE i32_lt_u
      | "i32.lt_s" -> COMPARE i32_lt_s
      | "i32.le_u" -> COMPARE i32_le_u
      | "i32.le_s" -> COMPARE i32_le_s
      | "i32.gt_u" -> COMPARE i32_gt_u
      | "i32.gt_s" -> COMPARE i32_gt_s
      | "i32.ge_u" -> COMPARE i32_ge_u
      | "i32.ge_s" -> COMPARE i32_ge_s
      | "i64.eq" -> COMPARE i64_eq
      | "i64.ne" -> COMPARE i64_ne
      | "i64.lt_u" -> COMPARE i64_lt_u
      | "i64.lt_s" -> COMPARE i64_lt_s
      | "i64.le_u" -> COMPARE i64_le_u
      | "i64.le_s" -> COMPARE i64_le_s
      | "i64.gt_u" -> COMPARE i64_gt_u
      | "i64.gt_s" -> COMPARE i64_gt_s
      | "i64.ge_u" -> COMPARE i64_ge_u
      | "i64.ge_s" -> COMPARE i64_ge_s

      | "f32.eq" -> COMPARE f32_eq
      | "f32.ne" -> COMPARE f32_ne
      | "f32.lt" -> COMPARE f32_lt
      | "f32.le" -> COMPARE f32_le
      | "f32.gt" -> COMPARE f32_gt
      | "f32.ge" -> COMPARE f32_ge
      | "f64.eq" -> COMPARE f64_eq
      | "f64.ne" -> COMPARE f64_ne
      | "f64.lt" -> COMPARE f64_lt
      | "f64.le" -> COMPARE f64_le
      | "f64.gt" -> COMPARE f64_gt
      | "f64.ge" -> COMPARE f64_ge

      | "i32.wrap_i64" -> CONVERT i32_wrap_i64
      | "i64.extend_i32_s" -> CONVERT i64_extend_i32_s
      | "i64.extend_i32_u" -> CONVERT i64_extend_i32_u
      | "f32.demote_f64" -> CONVERT f32_demote_f64
      | "f64.promote_f32" -> CONVERT f64_promote_f32
      | "i32.trunc_f32_u" -> CONVERT i32_trunc_f32_u
      | "i32.trunc_f32_s" -> CONVERT i32_trunc_f32_s
      | "i64.trunc_f32_u" -> CONVERT i64_trunc_f32_u
      | "i64.trunc_f32_s" -> CONVERT i64_trunc_f32_s
      | "i32.trunc_f64_u" -> CONVERT i32_trunc_f64_u
      | "i32.trunc_f64_s" -> CONVERT i32_trunc_f64_s
      | "i64.trunc_f64_u" -> CONVERT i64_trunc_f64_u
      | "i64.trunc_f64_s" -> CONVERT i64_trunc_f64_s
      | "i32.trunc_sat_f32_u" -> CONVERT i32_trunc_sat_f32_u
      | "i32.trunc_sat_f32_s" -> CONVERT i32_trunc_sat_f32_s
      | "i64.trunc_sat_f32_u" -> CONVERT i64_trunc_sat_f32_u
      | "i64.trunc_sat_f32_s" -> CONVERT i64_trunc_sat_f32_s
      | "i32.trunc_sat_f64_u" -> CONVERT i32_trunc_sat_f64_u
      | "i32.trunc_sat_f64_s" -> CONVERT i32_trunc_sat_f64_s
      | "i64.trunc_sat_f64_u" -> CONVERT i64_trunc_sat_f64_u
      | "i64.trunc_sat_f64_s" -> CONVERT i64_trunc_sat_f64_s
      | "f32.convert_i32_u" -> CONVERT f32_convert_i32_u
      | "f32.convert_i32_s" -> CONVERT f32_convert_i32_s
      | "f64.convert_i32_u" -> CONVERT f64_convert_i32_u
      | "f64.convert_i32_s" -> CONVERT f64_convert_i32_s
      | "f32.convert_i64_u" -> CONVERT f32_convert_i64_u
      | "f32.convert_i64_s" -> CONVERT f32_convert_i64_s
      | "f64.convert_i64_u" -> CONVERT f64_convert_i64_u
      | "f64.convert_i64_s" -> CONVERT f64_convert_i64_s
      | "f32.reinterpret_i32" -> CONVERT f32_reinterpret_i32
      | "f64.reinterpret_i64" -> CONVERT f64_reinterpret_i64
      | "i32.reinterpret_f32" -> CONVERT i32_reinterpret_f32
      | "i64.reinterpret_f64" -> CONVERT i64_reinterpret_f64

      | "type" -> TYPE
      | "func" -> FUNC
      | "param" -> PARAM
      | "result" -> RESULT
      | "start" -> START
      | "local" -> LOCAL
      | "global" -> GLOBAL
      | "table" -> TABLE
      | "memory" -> MEMORY
      | "elem" -> ELEM
      | "data" -> DATA
      | "declare" -> DECLARE
      | "offset" -> OFFSET
      | "item" -> ITEM
      | "import" -> IMPORT
      | "export" -> EXPORT

      | "module" -> MODULE
      | "binary" -> BIN
      | "quote" -> QUOTE

      | "script" -> SCRIPT
      | "register" -> REGISTER
      | "invoke" -> INVOKE
      | "get" -> GET
      | "assert_malformed" -> ASSERT_MALFORMED
      | "assert_invalid" -> ASSERT_INVALID
      | "assert_unlinkable" -> ASSERT_UNLINKABLE
      | "assert_return" -> ASSERT_RETURN
      | "assert_trap" -> ASSERT_TRAP
      | "assert_exhaustion" -> ASSERT_EXHAUSTION
      | "nan:canonical" -> NAN Script.CanonicalNan
      | "nan:arithmetic" -> NAN Script.ArithmeticNan
      | "input" -> INPUT
      | "output" -> OUTPUT

      | _ -> error lexbuf "unknown operator"
    }

  | "offset="(nat as s) { OFFSET_EQ_NAT s }
  | "align="(nat as s) { ALIGN_EQ_NAT s }

  | id as s { VAR s }

  | "(@"name { annot (Lexing.lexeme_start_p lexbuf) lexbuf; token lexbuf }
  | "(@" { error lexbuf "malformed annotation id" }

  | ";;"utf8_no_nl*eof { EOF }
  | ";;"utf8_no_nl*'\n' { Lexing.new_line lexbuf; token lexbuf }
  | ";;"utf8_no_nl* { token lexbuf (* causes error on following position *) }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; token lexbuf }
  | space#'\n' { token lexbuf }
  | '\n' { Lexing.new_line lexbuf; token lexbuf }
  | eof { EOF }

  | reserved { error lexbuf "unknown operator" }
  | utf8 { error lexbuf "illegal character" }
  | _ { error lexbuf "malformed UTF-8 encoding" }

and annot start = parse
  | ")" { () }
  | "(" { annot (Lexing.lexeme_start_p lexbuf) lexbuf; annot start lexbuf }

  | reserved { annot start lexbuf }
  | nat { annot start lexbuf }
  | int { annot start lexbuf }
  | float { annot start lexbuf }
  | id { annot start lexbuf }
  | string { annot start lexbuf }
  | '"'character*('\n'|eof) { error lexbuf "unclosed string literal" }
  | '"'character*['\x00'-'\x09''\x0b'-'\x1f''\x7f']
    { error lexbuf "illegal control character in string literal" }
  | '"'character*'\\'_
    { error_nest (Lexing.lexeme_end_p lexbuf) lexbuf "illegal escape" }

  | (";;"utf8_no_nl*)? eof { error_nest start lexbuf "unclosed annotation" }
  | ";;"utf8_no_nl*'\n' { Lexing.new_line lexbuf; annot start lexbuf }
  | ";;"utf8_no_nl* { annot start lexbuf (* error on following position *) }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; annot start lexbuf }
  | space#'\n' { annot start lexbuf }
  | '\n' { Lexing.new_line lexbuf; annot start lexbuf }
  | eof { error_nest start lexbuf "unclosed annotation" }
  | utf8 { error lexbuf "illegal character" }
  | _ { error lexbuf "malformed UTF-8 encoding" }

and comment start = parse
  | ";)" { () }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; comment start lexbuf }
  | '\n' { Lexing.new_line lexbuf; comment start lexbuf }
  | eof { error_nest start lexbuf "unclosed comment" }
  | utf8 { comment start lexbuf }
  | _ { error lexbuf "malformed UTF-8 encoding" }
