{
open Parser
open Ast

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

let text s =
  let b = Buffer.create (String.length s) in
  let i = ref 1 in
  while !i < String.length s - 1 do
    let c = if s.[!i] <> '\\' then s.[!i] else
      match (incr i; s.[!i]) with
      | 'n' -> '\n'
      | 't' -> '\t'
      | '\\' -> '\\'
      | '\'' -> '\''
      | '\"' -> '\"'
      | d ->
        incr i;
        Char.chr (int_of_string ("0x" ^ String.make 1 d ^ String.make 1 s.[!i]))
    in Buffer.add_char b c;
    incr i
  done;
  Buffer.contents b

let value_type = function
  | "i32" -> Types.Int32Type
  | "i64" -> Types.Int64Type
  | "f32" -> Types.Float32Type
  | "f64" -> Types.Float64Type
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

let space = [' ''\t']
let digit = ['0'-'9']
let hexdigit = ['0'-'9''a'-'f''A'-'F']
let letter = ['a'-'z''A'-'Z']
let symbol = ['+''-''*''/''\\''^''~''=''<''>''!''?''@''#''$''%''&''|'':''`''.']
let tick = '\''
let escape = ['n''t''\\''\'''\"']
let character =
  [^'"''\\''\x00'-'\x1f''\x7f'] | '\\'escape | '\\'hexdigit hexdigit

let sign = ('+' | '-')
let num = digit+
let hexnum = "0x" hexdigit+
let nat = num | hexnum
let int = sign nat
let float =
    sign? num '.' digit*
  | sign? num ('.' digit*)? ('e' | 'E') sign? num
  | sign? "0x" hexdigit+ '.'? hexdigit* 'p' sign? digit+
  | sign? "inf"
  | sign? "infinity"
  | sign? "nan"
  | sign? "nan:0x" hexdigit+
let text = '"' character* '"'
let name = '$' (letter | digit | '_' | tick | symbol)+

let ixx = "i" ("32" | "64")
let fxx = "f" ("32" | "64")
let nxx = ixx | fxx
let mixx = "i" ("8" | "16" | "32" | "64")
let mfxx = "f" ("32" | "64")
let sign = "s" | "u"
let digits = digit+
let mem_size = "8" | "16" | "32"

rule token = parse
  | "(" { LPAR }
  | ")" { RPAR }
  | nat as s { NAT s }
  | int as s { INT s }
  | float as s { FLOAT s }
  | text as s { TEXT (text s) }
  | '"'character*('\n'|eof) { error lexbuf "unclosed text literal" }
  | '"'character*['\x00'-'\x09''\x0b'-'\x1f''\x7f']
    { error lexbuf "illegal control character in text literal" }
  | '"'character*'\\'_
    { error_nest (Lexing.lexeme_end_p lexbuf) lexbuf "illegal escape" }

  | (nxx as t) { VALUE_TYPE (value_type t) }
  | (nxx as t)".const"
    { let open Source in
      CONST (numop t
        (fun s -> let n = I32.of_string s.it in
          I32_const (n @@ s.at), Values.Int32 n)
        (fun s -> let n = I64.of_string s.it in
          I64_const (n @@ s.at), Values.Int64 n)
        (fun s -> let n = F32.of_string s.it in
          F32_const (n @@ s.at), Values.Float32 n)
        (fun s -> let n = F64.of_string s.it in
          F64_const (n @@ s.at), Values.Float64 n))
    }

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
  | "call_import" { CALL_IMPORT }
  | "call_indirect" { CALL_INDIRECT }

  | "get_local" { GET_LOCAL }
  | "set_local" { SET_LOCAL }
  | "tee_local" { TEE_LOCAL }

  | (nxx as t)".load"
    { LOAD (fun (o, a) ->
        numop t (I32_load (o, opt a 4)) (I64_load (o, opt a 8))
                (F32_load (o, opt a 4)) (F64_load (o, opt a 8))) }
  | (nxx as t)".store"
    { STORE (fun (o, a) ->
        numop t (I32_store (o, opt a 4)) (I64_store (o, opt a 8))
                (F32_store (o, opt a 4)) (F64_store (o, opt a 8))) }
  | (ixx as t)".load"(mem_size as sz)"_"(sign as s)
    { if t = "i32" && sz = "32" then error lexbuf "unknown operator";
      LOAD (fun (o, a) ->
        intop t
          (memsz sz
            (ext s (I32_load8_s (o, opt a 1)) (I32_load8_u (o, opt a 1)))
            (ext s (I32_load16_s (o, opt a 2)) (I32_load16_u (o, opt a 2)))
            Unreachable)
          (memsz sz
            (ext s (I64_load8_s (o, opt a 1)) (I64_load8_u (o, opt a 1)))
            (ext s (I64_load16_s (o, opt a 2)) (I64_load16_u (o, opt a 2)))
            (ext s (I64_load32_s (o, opt a 4)) (I64_load32_u (o, opt a 4))))) }
  | (ixx as t)".store"(mem_size as sz)
    { if t = "i32" && sz = "32" then error lexbuf "unknown operator";
      STORE (fun (o, a) ->
        intop t
          (memsz sz
            (I32_store8 (o, opt a 1))
            (I32_store16 (o, opt a 2))
            Unreachable)
          (memsz sz
            (I64_store8 (o, opt a 1))
            (I64_store16 (o, opt a 2))
            (I64_store32 (o, opt a 4)))) }

  | "offset="(digits as s) { OFFSET (Int64.of_string s) }
  | "align="(digits as s) { ALIGN (int_of_string s) }

  | (ixx as t)".clz" { UNARY (intop t I32_clz I64_clz) }
  | (ixx as t)".ctz" { UNARY (intop t I32_ctz I64_ctz) }
  | (ixx as t)".popcnt" { UNARY (intop t I32_popcnt I64_popcnt) }
  | (fxx as t)".neg" { UNARY (floatop t F32_neg F64_neg) }
  | (fxx as t)".abs" { UNARY (floatop t F32_abs F64_abs) }
  | (fxx as t)".sqrt" { UNARY (floatop t F32_sqrt F64_sqrt) }
  | (fxx as t)".ceil" { UNARY (floatop t F32_ceil F64_ceil) }
  | (fxx as t)".floor" { UNARY (floatop t F32_floor F64_floor) }
  | (fxx as t)".trunc" { UNARY (floatop t F32_trunc F64_trunc) }
  | (fxx as t)".nearest" { UNARY (floatop t F32_nearest F64_nearest) }

  | (ixx as t)".add" { BINARY (intop t I32_add I64_add) }
  | (ixx as t)".sub" { BINARY (intop t I32_sub I64_sub) }
  | (ixx as t)".mul" { BINARY (intop t I32_mul I64_mul) }
  | (ixx as t)".div_s" { BINARY (intop t I32_div_s I64_div_s) }
  | (ixx as t)".div_u" { BINARY (intop t I32_div_u I64_div_u) }
  | (ixx as t)".rem_s" { BINARY (intop t I32_rem_s I64_rem_s) }
  | (ixx as t)".rem_u" { BINARY (intop t I32_rem_u I64_rem_u) }
  | (ixx as t)".and" { BINARY (intop t I32_and I64_and) }
  | (ixx as t)".or" { BINARY (intop t I32_or I64_or) }
  | (ixx as t)".xor" { BINARY (intop t I32_xor I64_xor) }
  | (ixx as t)".shl" { BINARY (intop t I32_shl I64_shl) }
  | (ixx as t)".shr_s" { BINARY (intop t I32_shr_s I64_shr_s) }
  | (ixx as t)".shr_u" { BINARY (intop t I32_shr_u I64_shr_u) }
  | (ixx as t)".rotl" { BINARY (intop t I32_rotl I64_rotl) }
  | (ixx as t)".rotr" { BINARY (intop t I32_rotr I64_rotr) }
  | (fxx as t)".add" { BINARY (floatop t F32_add F64_add) }
  | (fxx as t)".sub" { BINARY (floatop t F32_sub F64_sub) }
  | (fxx as t)".mul" { BINARY (floatop t F32_mul F64_mul) }
  | (fxx as t)".div" { BINARY (floatop t F32_div F64_div) }
  | (fxx as t)".min" { BINARY (floatop t F32_min F64_min) }
  | (fxx as t)".max" { BINARY (floatop t F32_max F64_max) }
  | (fxx as t)".copysign" { BINARY (floatop t F32_copysign F64_copysign) }

  | (ixx as t)".eqz" { TEST (intop t I32_eqz I64_eqz) }

  | (ixx as t)".eq" { COMPARE (intop t I32_eq I64_eq) }
  | (ixx as t)".ne" { COMPARE (intop t I32_ne I64_ne) }
  | (ixx as t)".lt_s" { COMPARE (intop t I32_lt_s I64_lt_s) }
  | (ixx as t)".lt_u" { COMPARE (intop t I32_lt_u I64_lt_u) }
  | (ixx as t)".le_s" { COMPARE (intop t I32_le_s I64_le_s) }
  | (ixx as t)".le_u" { COMPARE (intop t I32_le_u I64_le_u) }
  | (ixx as t)".gt_s" { COMPARE (intop t I32_gt_s I64_gt_s) }
  | (ixx as t)".gt_u" { COMPARE (intop t I32_gt_u I64_gt_u) }
  | (ixx as t)".ge_s" { COMPARE (intop t I32_ge_s I64_ge_s) }
  | (ixx as t)".ge_u" { COMPARE (intop t I32_ge_u I64_ge_u) }
  | (fxx as t)".eq" { COMPARE (floatop t F32_eq F64_eq) }
  | (fxx as t)".ne" { COMPARE (floatop t F32_ne F64_ne) }
  | (fxx as t)".lt" { COMPARE (floatop t F32_lt F64_lt) }
  | (fxx as t)".le" { COMPARE (floatop t F32_le F64_le) }
  | (fxx as t)".gt" { COMPARE (floatop t F32_gt F64_gt) }
  | (fxx as t)".ge" { COMPARE (floatop t F32_ge F64_ge) }

  | "i32.wrap/i64" { CONVERT I32_wrap_i64 }
  | "i64.extend_s/i32" { CONVERT I64_extend_s_i32 }
  | "i64.extend_u/i32" { CONVERT I64_extend_u_i32 }
  | "f32.demote/f64" { CONVERT F32_demote_f64 }
  | "f64.promote/f32" { CONVERT F64_promote_f32 }
  | (ixx as t)".trunc_s/f32"
    { CONVERT (intop t I32_trunc_s_f32 I64_trunc_s_f32) }
  | (ixx as t)".trunc_u/f32"
    { CONVERT (intop t I32_trunc_u_f32 I64_trunc_u_f32) }
  | (ixx as t)".trunc_s/f64"
    { CONVERT (intop t I32_trunc_s_f64 I64_trunc_s_f64) }
  | (ixx as t)".trunc_u/f64"
    { CONVERT (intop t I32_trunc_u_f64 I64_trunc_u_f64) }
  | (fxx as t)".convert_s/i32"
    { CONVERT (floatop t F32_convert_s_i32 F64_convert_s_i32) }
  | (fxx as t)".convert_u/i32"
    { CONVERT (floatop t F32_convert_u_i32 F64_convert_u_i32) }
  | (fxx as t)".convert_s/i64"
    { CONVERT (floatop t F32_convert_s_i64 F64_convert_s_i64) }
  | (fxx as t)".convert_u/i64"
    { CONVERT (floatop t F32_convert_u_i64 F64_convert_u_i64) }
  | "f32.reinterpret/i32" { CONVERT F32_reinterpret_i32 }
  | "f64.reinterpret/i64" { CONVERT F64_reinterpret_i64 }
  | "i32.reinterpret/f32" { CONVERT I32_reinterpret_f32 }
  | "i64.reinterpret/f64" { CONVERT I64_reinterpret_f64 }

  | "current_memory" { CURRENT_MEMORY }
  | "grow_memory" { GROW_MEMORY }

  | "type" { TYPE }
  | "func" { FUNC }
  | "start" { START }
  | "param" { PARAM }
  | "result" { RESULT }
  | "local" { LOCAL }
  | "module" { MODULE }
  | "memory" { MEMORY }
  | "segment" { SEGMENT }
  | "import" { IMPORT }
  | "export" { EXPORT }
  | "table" { TABLE }

  | "assert_invalid" { ASSERT_INVALID }
  | "assert_return" { ASSERT_RETURN }
  | "assert_return_nan" { ASSERT_RETURN_NAN }
  | "assert_trap" { ASSERT_TRAP }
  | "invoke" { INVOKE }
  | "input" { INPUT }
  | "output" { OUTPUT }

  | name as s { VAR s }

  | ";;"[^'\n']*eof { EOF }
  | ";;"[^'\n']*'\n' { Lexing.new_line lexbuf; token lexbuf }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; token lexbuf }
  | space { token lexbuf }
  | '\n' { Lexing.new_line lexbuf; token lexbuf }
  | eof { EOF }
  | _ { error lexbuf "unknown operator" }

and comment start = parse
  | ";)" { () }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; comment start lexbuf }
  | '\n' { Lexing.new_line lexbuf; comment start lexbuf }
  | eof { error_nest start lexbuf "unclosed comment" }
  | _ { comment start lexbuf }
