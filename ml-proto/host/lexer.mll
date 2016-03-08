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

let sign = ('+' | '-')?
let num = sign digit+
let hexnum = sign "0x" hexdigit+
let int = num | hexnum
let float =
    (num '.' digit*)
  | num ('.' digit*)? ('e' | 'E') num
  | sign "0x" hexdigit+ '.'? hexdigit* 'p' sign digit+
  | sign "infinity"
  | sign "nan"
  | sign "nan:0x" hexdigit+
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
  | "block" { BLOCK }
  | "loop" { LOOP }
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

  | (nxx as t)".load"
    { LOAD (fun (o, a, e) ->
        numop t (I32_load (o, (Lib.Option.get a 4), e))
                (I64_load (o, (Lib.Option.get a 8), e))
                (F32_load (o, (Lib.Option.get a 4), e))
                (F64_load (o, (Lib.Option.get a 8), e))) }
  | (nxx as t)".store"
    { STORE (fun (o, a, e1, e2) ->
        numop t (I32_store (o, (Lib.Option.get a 4), e1, e2))
                (I64_store (o, (Lib.Option.get a 8), e1, e2))
                (F32_store (o, (Lib.Option.get a 4), e1, e2))
                (F64_store (o, (Lib.Option.get a 8), e1, e2))) }
  | (ixx as t)".load"(mem_size as sz)"_"(sign as s)
    { LOAD (fun (o, a, e) ->
        intop t
          (memsz sz
            (ext s (I32_load8_s (o, (Lib.Option.get a 1), e))
                   (I32_load8_u (o, (Lib.Option.get a 1), e)))
            (ext s (I32_load16_s (o, (Lib.Option.get a 2), e))
                   (I32_load16_u (o, (Lib.Option.get a 2), e)))
            (ext s (I32_load32_s (o, (Lib.Option.get a 4), e))
                   (I32_load32_u (o, (Lib.Option.get a 4), e))))
          (memsz sz
            (ext s (I64_load8_s (o, (Lib.Option.get a 1), e))
                   (I64_load8_u (o, (Lib.Option.get a 1), e)))
            (ext s (I64_load16_s (o, (Lib.Option.get a 2), e))
                   (I64_load16_u (o, (Lib.Option.get a 2), e)))
            (ext s (I64_load32_s (o, (Lib.Option.get a 4), e))
                   (I64_load32_u (o, (Lib.Option.get a 4), e))))) }
  | (ixx as t)".store"(mem_size as sz)
    { STORE (fun (o, a, e1, e2) ->
        intop t
          (memsz sz
            (I32_store8 (o, (Lib.Option.get a 1), e1, e2))
            (I32_store16 (o, (Lib.Option.get a 2), e1, e2))
            (I32_store32 (o, (Lib.Option.get a 4), e1, e2)))
          (memsz sz
            (I64_store8 (o, (Lib.Option.get a 1), e1, e2))
            (I64_store16 (o, (Lib.Option.get a 2), e1, e2))
            (I64_store32 (o, (Lib.Option.get a 4), e1, e2)))
        ) }

  | "offset="(digits as s) { OFFSET (Int64.of_string s) }
  | "align="(digits as s) { ALIGN (int_of_string s) }

  | (ixx as t)".clz"
    { UNARY (fun e -> intop t (I32_clz e) (I64_clz e)) }
  | (ixx as t)".ctz"
    { UNARY (fun e -> intop t (I32_ctz e) (I64_ctz e)) }
  | (ixx as t)".popcnt"
    { UNARY (fun e -> intop t (I32_popcnt e) (I64_popcnt e)) }
  | (fxx as t)".neg"
    { UNARY (fun e -> floatop t (F32_neg e) (F64_neg e)) }
  | (fxx as t)".abs"
    { UNARY (fun e -> floatop t (F32_abs e) (F64_abs e)) }
  | (fxx as t)".sqrt"
    { UNARY (fun e -> floatop t (F32_sqrt e) (F64_sqrt e)) }
  | (fxx as t)".ceil"
    { UNARY (fun e -> floatop t (F32_ceil e) (F64_ceil e)) }
  | (fxx as t)".floor"
    { UNARY (fun e -> floatop t (F32_floor e) (F64_floor e)) }
  | (fxx as t)".trunc"
    { UNARY (fun e -> floatop t (F32_trunc e) (F64_trunc e)) }
  | (fxx as t)".nearest"
    { UNARY (fun e -> floatop t (F32_nearest e) (F64_nearest e)) }

  | (ixx as t)".add"
    { BINARY (fun (e1, e2) -> intop t (I32_add (e1, e2)) (I64_add (e1, e2))) }
  | (ixx as t)".sub"
    { BINARY (fun (e1, e2) -> intop t (I32_sub (e1, e2)) (I64_sub (e1, e2))) }
  | (ixx as t)".mul"
    { BINARY (fun (e1, e2) -> intop t (I32_mul (e1, e2)) (I64_mul (e1, e2))) }
  | (ixx as t)".div_s"
    { BINARY (fun (e1, e2) ->
        intop t (I32_div_s (e1, e2)) (I64_div_s (e1, e2))) }
  | (ixx as t)".div_u"
    { BINARY (fun (e1, e2) ->
        intop t (I32_div_u (e1, e2)) (I64_div_u (e1, e2))) }
  | (ixx as t)".rem_s"
    { BINARY (fun (e1, e2) ->
        intop t (I32_rem_s (e1, e2)) (I64_rem_s (e1, e2))) }
  | (ixx as t)".rem_u"
    { BINARY (fun (e1, e2) ->
        intop t (I32_rem_u (e1, e2)) (I64_rem_u (e1, e2))) }
  | (ixx as t)".and"
    { BINARY (fun (e1, e2) -> intop t (I32_and (e1, e2)) (I64_and (e1, e2))) }
  | (ixx as t)".or"
    { BINARY (fun (e1, e2) -> intop t (I32_or (e1, e2)) (I64_or (e1, e2))) }
  | (ixx as t)".xor"
    { BINARY (fun (e1, e2) -> intop t (I32_xor (e1, e2)) (I64_xor (e1, e2))) }
  | (ixx as t)".shl"
    { BINARY (fun (e1, e2) -> intop t (I32_shl (e1, e2)) (I64_shl (e1, e2))) }
  | (ixx as t)".shr_s"
    { BINARY (fun (e1, e2) ->
        intop t (I32_shr_s (e1, e2)) (I64_shr_s (e1, e2))) }
  | (ixx as t)".shr_u"
    { BINARY (fun (e1, e2) ->
        intop t (I32_shr_u (e1, e2)) (I64_shr_u (e1, e2))) }
  | (ixx as t)".rotl"
    { BINARY (fun (e1, e2) ->
        intop t (I32_rotl (e1, e2)) (I64_rotl (e1, e2))) }
  | (ixx as t)".rotr"
    { BINARY (fun (e1, e2) ->
        intop t (I32_rotr (e1, e2)) (I64_rotr (e1, e2))) }
  | (fxx as t)".add"
    { BINARY (fun (e1, e2) -> floatop t (F32_add (e1, e2)) (F64_add (e1, e2))) }
  | (fxx as t)".sub"
    { BINARY (fun (e1, e2) -> floatop t (F32_sub (e1, e2)) (F64_sub (e1, e2))) }
  | (fxx as t)".mul"
    { BINARY (fun (e1, e2) -> floatop t (F32_mul (e1, e2)) (F64_mul (e1, e2))) }
  | (fxx as t)".div"
    { BINARY (fun (e1, e2) -> floatop t (F32_div (e1, e2)) (F64_div (e1, e2))) }
  | (fxx as t)".min"
    { BINARY (fun (e1, e2) -> floatop t (F32_min (e1, e2)) (F64_min (e1, e2))) }
  | (fxx as t)".max"
    { BINARY (fun (e1, e2) -> floatop t (F32_max (e1, e2)) (F64_max (e1, e2))) }
  | (fxx as t)".copysign"
    { BINARY (fun (e1, e2) ->
        floatop t (F32_copysign (e1, e2)) (F64_copysign (e1, e2))) }

  | (ixx as t)".eq"
    { COMPARE (fun (e1, e2) -> intop t (I32_eq (e1, e2)) (I64_eq (e1, e2))) }
  | (ixx as t)".ne"
    { COMPARE (fun (e1, e2) -> intop t (I32_ne (e1, e2)) (I64_ne (e1, e2))) }
  | (ixx as t)".lt_s"
    { COMPARE (fun (e1, e2) ->
        intop t (I32_lt_s (e1, e2)) (I64_lt_s (e1, e2))) }
  | (ixx as t)".lt_u"
    { COMPARE (fun (e1, e2) ->
        intop t (I32_lt_u (e1, e2)) (I64_lt_u (e1, e2))) }
  | (ixx as t)".le_s"
    { COMPARE (fun (e1, e2) ->
        intop t (I32_le_s (e1, e2)) (I64_le_s (e1, e2))) }
  | (ixx as t)".le_u"
    { COMPARE (fun (e1, e2) ->
        intop t (I32_le_u (e1, e2)) (I64_le_u (e1, e2))) }
  | (ixx as t)".gt_s"
    { COMPARE (fun (e1, e2) ->
        intop t (I32_gt_s (e1, e2)) (I64_gt_s (e1, e2))) }
  | (ixx as t)".gt_u"
    { COMPARE (fun (e1, e2) ->
        intop t (I32_gt_u (e1, e2)) (I64_gt_u (e1, e2))) }
  | (ixx as t)".ge_s"
    { COMPARE (fun (e1, e2) ->
        intop t (I32_ge_s (e1, e2)) (I64_ge_s (e1, e2))) }
  | (ixx as t)".ge_u"
    { COMPARE (fun (e1, e2) ->
        intop t (I32_ge_u (e1, e2)) (I64_ge_u (e1, e2))) }
  | (fxx as t)".eq"
    { COMPARE (fun (e1, e2) -> floatop t (F32_eq (e1, e2)) (F64_eq (e1, e2))) }
  | (fxx as t)".ne"
    { COMPARE (fun (e1, e2) -> floatop t (F32_ne (e1, e2)) (F64_ne (e1, e2))) }
  | (fxx as t)".lt"
    { COMPARE (fun (e1, e2) -> floatop t (F32_lt (e1, e2)) (F64_lt (e1, e2))) }
  | (fxx as t)".le"
    { COMPARE (fun (e1, e2) -> floatop t (F32_le (e1, e2)) (F64_le (e1, e2))) }
  | (fxx as t)".gt"
    { COMPARE (fun (e1, e2) -> floatop t (F32_gt (e1, e2)) (F64_gt (e1, e2))) }
  | (fxx as t)".ge"
    { COMPARE (fun (e1, e2) -> floatop t (F32_ge (e1, e2)) (F64_ge (e1, e2))) }

  | "i32.wrap/i64" { CONVERT (fun e -> I32_wrap_i64 e) }
  | "i64.extend_s/i32" { CONVERT (fun e -> I64_extend_s_i32 e) }
  | "i64.extend_u/i32" { CONVERT (fun e -> I64_extend_u_i32 e) }
  | "f32.demote/f64" { CONVERT (fun e -> F32_demote_f64 e) }
  | "f64.promote/f32" { CONVERT (fun e -> F64_promote_f32 e) }
  | (ixx as t)".trunc_s/f32"
    { CONVERT (fun e -> intop t (I32_trunc_s_f32 e) (I64_trunc_s_f32 e)) }
  | (ixx as t)".trunc_u/f32"
    { CONVERT (fun e -> intop t (I32_trunc_u_f32 e) (I64_trunc_u_f32 e)) }
  | (ixx as t)".trunc_s/f64"
    { CONVERT (fun e -> intop t (I32_trunc_s_f64 e) (I64_trunc_s_f64 e)) }
  | (ixx as t)".trunc_u/f64"
    { CONVERT (fun e -> intop t (I32_trunc_u_f64 e) (I64_trunc_u_f64 e)) }
  | (fxx as t)".convert_s/i32"
    { CONVERT (fun e -> floatop t (F32_convert_s_i32 e) (F64_convert_s_i32 e)) }
  | (fxx as t)".convert_u/i32"
    { CONVERT (fun e -> floatop t (F32_convert_u_i32 e) (F64_convert_u_i32 e)) }
  | (fxx as t)".convert_s/i64"
    { CONVERT (fun e -> floatop t (F32_convert_s_i64 e) (F64_convert_s_i64 e)) }
  | (fxx as t)".convert_u/i64"
    { CONVERT (fun e -> floatop t (F32_convert_u_i64 e) (F64_convert_u_i64 e)) }
  | "f32.reinterpret/i32" { CONVERT (fun e -> F32_reinterpret_i32 e) }
  | "f64.reinterpret/i64" { CONVERT (fun e -> F64_reinterpret_i64 e) }
  | "i32.reinterpret/f32" { CONVERT (fun e -> I32_reinterpret_f32 e) }
  | "i64.reinterpret/f64" { CONVERT (fun e -> I64_reinterpret_f64 e) }

  | "memory_size" { MEMORY_SIZE }
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

  | name as s { VAR s }

  | ";;"[^'\n']*eof { EOF }
  | ";;"[^'\n']*'\n' { Lexing.new_line lexbuf; token lexbuf }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; token lexbuf }
  | space { token lexbuf }
  | '\n' { Lexing.new_line lexbuf; token lexbuf }
  | eof { EOF }
  | _ { error lexbuf "unknown opcode" }

and comment start = parse
  | ";)" { () }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; comment start lexbuf }
  | '\n' { Lexing.new_line lexbuf; comment start lexbuf }
  | eof { error_nest start lexbuf "unclosed comment" }
  | _ { comment start lexbuf }
