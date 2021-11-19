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

let unknown lexbuf = error lexbuf ("unknown operator " ^ Lexing.lexeme lexbuf)

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

let num_type = function
  | "i32" -> Types.I32Type
  | "i64" -> Types.I64Type
  | "f32" -> Types.F32Type
  | "f64" -> Types.F64Type
  | _ -> assert false

let vec_type = function
  | "v128" -> Types.V128Type
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

let v128op s i8x16 i16x8 i32x4 i64x2 f32x4 f64x2 =
  match s with
  | "i8x16" -> i8x16
  | "i16x8" -> i16x8
  | "i32x4" -> i32x4
  | "i64x2" -> i64x2
  | "f32x4" -> f32x4
  | "f64x2" -> f64x2
  | _ -> assert false

let v128intop s i8x16 i16x8 i32x4 i64x2 =
  match s with
  | "i8x16" -> i8x16
  | "i16x8" -> i16x8
  | "i32x4" -> i32x4
  | "i64x2" -> i64x2
  | _ -> assert false

let v128floatop s f32x4 f64x2 =
  match s with
  | "f32x4" -> f32x4
  | "f64x2" -> f64x2
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

let v128_shape = function
  | "i8x16" -> V128.I8x16 ()
  | "i16x8" -> V128.I16x8 ()
  | "i32x4" -> V128.I32x4 ()
  | "i64x2" -> V128.I64x2 ()
  | "f32x4" -> V128.F32x4 ()
  | "f64x2" -> V128.F64x2 ()
  | _ -> assert false

let only shapes s lexbuf =
  if not (List.mem s shapes) then
    unknown lexbuf

let except shapes s lexbuf =
  if (List.mem s shapes) then
    unknown lexbuf
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
let reserved = (letter | digit | '_' | symbol)+
let name = '$' reserved

let ixx = "i" ("32" | "64")
let fxx = "f" ("32" | "64")
let nxx = ixx | fxx
let vxxx = "v128"
let mixx = "i" ("8" | "16" | "32" | "64")
let mfxx = "f" ("32" | "64")
let sign = "s" | "u"
let mem_size = "8" | "16" | "32"
let v128_int_shape = "i8x16" | "i16x8" | "i32x4" | "i64x2"
let v128_float_shape = "f32x4" | "f64x2"
let v128_shape = v128_int_shape | v128_float_shape

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

  | "extern" { EXTERN }
  | "externref" { EXTERNREF }
  | "funcref" { FUNCREF }
  | nxx as t { NUM_TYPE (num_type t) }
  | vxxx as t { VEC_TYPE (vec_type t) }
  | "mut" { MUT }

  | v128_shape as s { VEC_SHAPE (v128_shape s) }

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
  | vxxx".const"
    { let open Source in
      VEC_CONST
        (fun shape ss at ->
          let v = V128.of_strings shape (List.map (fun s -> s.it) ss) in
          (v128_const (v @@ at), Values.V128 v))
    }
  | "ref.null" { REF_NULL }
  | "ref.func" { REF_FUNC }
  | "ref.extern" { REF_EXTERN }
  | "ref.is_null" { REF_IS_NULL }

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

  | "local.get" { LOCAL_GET }
  | "local.set" { LOCAL_SET }
  | "local.tee" { LOCAL_TEE }
  | "global.get" { GLOBAL_GET }
  | "global.set" { GLOBAL_SET }

  | "table.get" { TABLE_GET }
  | "table.set" { TABLE_SET }
  | "table.size" { TABLE_SIZE }
  | "table.grow" { TABLE_GROW }
  | "table.fill" { TABLE_FILL }
  | "table.copy" { TABLE_COPY }
  | "table.init" { TABLE_INIT }
  | "elem.drop" { ELEM_DROP }

  | "memory.size" { MEMORY_SIZE }
  | "memory.grow" { MEMORY_GROW }
  | "memory.fill" { MEMORY_FILL }
  | "memory.copy" { MEMORY_COPY }
  | "memory.init" { MEMORY_INIT }
  | "data.drop" { DATA_DROP }

  | (nxx as t)".load"
    { LOAD (fun x a o ->
        numop t (i32_load x (opt a 2)) (i64_load x (opt a 3))
                (f32_load x (opt a 2)) (f64_load x (opt a 3)) o) }
  | (nxx as t)".store"
    { STORE (fun x a o ->
        numop t (i32_store x (opt a 2)) (i64_store x (opt a 3))
                (f32_store x (opt a 2)) (f64_store x (opt a 3)) o) }
  | (ixx as t)".load"(mem_size as sz)"_"(sign as s)
    { if t = "i32" && sz = "32" then unknown lexbuf;
      LOAD (fun x a o ->
        intop t
          (memsz sz
            (ext s i32_load8_s i32_load8_u x (opt a 0))
            (ext s i32_load16_s i32_load16_u x (opt a 1))
            (fun _ -> unreachable) o)
          (memsz sz
            (ext s i64_load8_s i64_load8_u x (opt a 0))
            (ext s i64_load16_s i64_load16_u x (opt a 1))
            (ext s i64_load32_s i64_load32_u x (opt a 2)) o)) }
  | (ixx as t)".store"(mem_size as sz)
    { if t = "i32" && sz = "32" then unknown lexbuf;
      STORE (fun x a o ->
        intop t
          (memsz sz
            (i32_store8 x (opt a 0))
            (i32_store16 x (opt a 1))
            (fun _ -> unreachable) o)
          (memsz sz
            (i64_store8 x (opt a 0))
            (i64_store16 x (opt a 1))
            (i64_store32 x (opt a 2)) o)) }
  | "v128.load"
    { VEC_LOAD (fun x a o -> (v128_load x (opt a 4)) o) }
  | "v128.store"
    { VEC_STORE (fun x a o -> (v128_store x (opt a 4)) o) }
  | "v128.load8x8_"(sign as s)
    { VEC_LOAD (fun x a o -> (ext s v128_load8x8_s v128_load8x8_u x (opt a 3)) o) }
  | "v128.load16x4_"(sign as s)
    { VEC_LOAD (fun x a o -> (ext s v128_load16x4_s v128_load16x4_u x (opt a 3)) o) }
  | "v128.load32x2_"(sign as s)
    { VEC_LOAD (fun x a o -> (ext s v128_load32x2_s v128_load32x2_u x (opt a 3)) o) }
  | "v128.load8_splat"
    { VEC_LOAD (fun x a o -> (v128_load8_splat x (opt a 0)) o) }
  | "v128.load16_splat"
    { VEC_LOAD (fun x a o -> (v128_load16_splat x (opt a 1)) o) }
  | "v128.load32_splat"
    { VEC_LOAD (fun x a o -> (v128_load32_splat x (opt a 2)) o) }
  | "v128.load64_splat"
    { VEC_LOAD (fun x a o -> (v128_load64_splat x (opt a 3)) o) }
  | "v128.load32_zero"
    { VEC_LOAD (fun x a o -> (v128_load32_zero x (opt a 2)) o) }
  | "v128.load64_zero"
    { VEC_LOAD (fun x a o -> (v128_load64_zero x (opt a 3)) o) }
  | "v128.load8_lane"
    { VEC_LOAD_LANE (fun x a o i -> (v128_load8_lane x (opt a 0)) o i) }
  | "v128.load16_lane"
    { VEC_LOAD_LANE (fun x a o i -> (v128_load16_lane x (opt a 1)) o i) }
  | "v128.load32_lane"
    { VEC_LOAD_LANE (fun x a o i -> (v128_load32_lane x (opt a 2)) o i) }
  | "v128.load64_lane"
    { VEC_LOAD_LANE (fun x a o i -> (v128_load64_lane x (opt a 3)) o i) }
  | "v128.store8_lane"
    { VEC_STORE_LANE (fun x a o i -> (v128_store8_lane x (opt a 0)) o i) }
  | "v128.store16_lane"
    { VEC_STORE_LANE (fun x a o i -> (v128_store16_lane x (opt a 1)) o i) }
  | "v128.store32_lane"
    { VEC_STORE_LANE (fun x a o i -> (v128_store32_lane x (opt a 2)) o i) }
  | "v128.store64_lane"
    { VEC_STORE_LANE (fun x a o i -> (v128_store64_lane x (opt a 3)) o i) }

  | "offset="(nat as s) { OFFSET_EQ_NAT s }
  | "align="(nat as s) { ALIGN_EQ_NAT s }

  | (ixx as t)".clz" { UNARY (intop t i32_clz i64_clz) }
  | (ixx as t)".ctz" { UNARY (intop t i32_ctz i64_ctz) }
  | (ixx as t)".popcnt" { UNARY (intop t i32_popcnt i64_popcnt) }
  | (ixx as t)".extend8_s" { UNARY (intop t i32_extend8_s i64_extend8_s) }
  | (ixx as t)".extend16_s" { UNARY (intop t i32_extend16_s i64_extend16_s) }
  | "i64.extend32_s" { UNARY i64_extend32_s }
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

  | "i32.wrap_i64" { CONVERT i32_wrap_i64 }
  | "i64.extend_i32_s" { CONVERT i64_extend_i32_s }
  | "i64.extend_i32_u" { CONVERT i64_extend_i32_u }
  | "f32.demote_f64" { CONVERT f32_demote_f64 }
  | "f64.promote_f32" { CONVERT f64_promote_f32 }
  | (ixx as t)".trunc_f32_s"
    { CONVERT (intop t i32_trunc_f32_s i64_trunc_f32_s) }
  | (ixx as t)".trunc_f32_u"
    { CONVERT (intop t i32_trunc_f32_u i64_trunc_f32_u) }
  | (ixx as t)".trunc_f64_s"
    { CONVERT (intop t i32_trunc_f64_s i64_trunc_f64_s) }
  | (ixx as t)".trunc_f64_u"
    { CONVERT (intop t i32_trunc_f64_u i64_trunc_f64_u) }
  | (ixx as t)".trunc_sat_f32_s"
    { CONVERT (intop t i32_trunc_sat_f32_s i64_trunc_sat_f32_s) }
  | (ixx as t)".trunc_sat_f32_u"
    { CONVERT (intop t i32_trunc_sat_f32_u i64_trunc_sat_f32_u) }
  | (ixx as t)".trunc_sat_f64_s"
    { CONVERT (intop t i32_trunc_sat_f64_s i64_trunc_sat_f64_s) }
  | (ixx as t)".trunc_sat_f64_u"
    { CONVERT (intop t i32_trunc_sat_f64_u i64_trunc_sat_f64_u) }
  | (fxx as t)".convert_i32_s"
    { CONVERT (floatop t f32_convert_i32_s f64_convert_i32_s) }
  | (fxx as t)".convert_i32_u"
    { CONVERT (floatop t f32_convert_i32_u f64_convert_i32_u) }
  | (fxx as t)".convert_i64_s"
    { CONVERT (floatop t f32_convert_i64_s f64_convert_i64_s) }
  | (fxx as t)".convert_i64_u"
    { CONVERT (floatop t f32_convert_i64_u f64_convert_i64_u) }
  | "f32.reinterpret_i32" { CONVERT f32_reinterpret_i32 }
  | "f64.reinterpret_i64" { CONVERT f64_reinterpret_i64 }
  | "i32.reinterpret_f32" { CONVERT i32_reinterpret_f32 }
  | "i64.reinterpret_f64" { CONVERT i64_reinterpret_f64 }

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
  | "declare" { DECLARE }
  | "offset" { OFFSET }
  | "item" { ITEM }
  | "import" { IMPORT }
  | "export" { EXPORT }

  | "module" { MODULE }
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
  | "assert_trap" { ASSERT_TRAP }
  | "assert_exhaustion" { ASSERT_EXHAUSTION }
  | "nan:canonical" { NAN Script.CanonicalNan }
  | "nan:arithmetic" { NAN Script.ArithmeticNan }
  | "input" { INPUT }
  | "output" { OUTPUT }

  | vxxx".not" { VEC_UNARY v128_not }
  | vxxx".and" { VEC_UNARY v128_and }
  | vxxx".andnot" { VEC_UNARY v128_andnot }
  | vxxx".or" { VEC_UNARY v128_or }
  | vxxx".xor" { VEC_UNARY v128_xor }
  | vxxx".bitselect" { VEC_TERNARY v128_bitselect }
  | vxxx".any_true" { VEC_TEST (v128_any_true) }

  | (v128_shape as s)".neg"
    { VEC_UNARY
        (v128op s i8x16_neg i16x8_neg i32x4_neg i64x2_neg f32x4_neg f64x2_neg) }
  | (v128_float_shape as s)".sqrt"
    { VEC_UNARY (v128floatop s f32x4_sqrt f64x2_sqrt) }
  | (v128_float_shape as s)".ceil"
    { VEC_UNARY (v128floatop s f32x4_ceil f64x2_ceil) }
  | (v128_float_shape as s)".floor"
    { VEC_UNARY (v128floatop s f32x4_floor f64x2_floor) }
  | (v128_float_shape as s)".trunc"
    { VEC_UNARY (v128floatop s f32x4_trunc f64x2_trunc) }
  | (v128_float_shape as s)".nearest"
    { VEC_UNARY (v128floatop s f32x4_nearest f64x2_nearest) }
  | (v128_shape as s)".abs"
    { VEC_UNARY
        (v128op s i8x16_abs i16x8_abs i32x4_abs i64x2_abs f32x4_abs f64x2_abs) }
  | "i8x16.popcnt" { VEC_UNARY i8x16_popcnt }
  | (v128_int_shape as s)".avgr_u"
    { only ["i8x16"; "i16x8"] s lexbuf;
      VEC_UNARY (v128intop s i8x16_avgr_u i16x8_avgr_u unreachable unreachable) }
  | "i32x4.trunc_sat_f32x4_"(sign as s)
    { VEC_UNARY (ext s i32x4_trunc_sat_f32x4_s i32x4_trunc_sat_f32x4_u) }
  | "i32x4.trunc_sat_f64x2_"(sign as s)"_zero"
    { VEC_UNARY (ext s i32x4_trunc_sat_f64x2_s_zero i32x4_trunc_sat_f64x2_u_zero) }
  | "f64x2.promote_low_f32x4"
    { VEC_UNARY f64x2_promote_low_f32x4 }
  | "f32x4.demote_f64x2_zero"
    { VEC_UNARY f32x4_demote_f64x2_zero }
  | "f32x4.convert_i32x4_"(sign as s)
    { VEC_UNARY (ext s f32x4_convert_i32x4_s f32x4_convert_i32x4_u) }
  | "f64x2.convert_low_i32x4_"(sign as s)
    { VEC_UNARY (ext s f64x2_convert_low_i32x4_s f64x2_convert_low_i32x4_u) }
  | "i16x8.extadd_pairwise_i8x16_"(sign as s)
    { VEC_UNARY (ext s i16x8_extadd_pairwise_i8x16_s i16x8_extadd_pairwise_i8x16_u) }
  | "i32x4.extadd_pairwise_i16x8_"(sign as s)
    { VEC_UNARY (ext s i32x4_extadd_pairwise_i16x8_s i32x4_extadd_pairwise_i16x8_u) }

  | (v128_shape as s)".eq"
    { VEC_BINARY (v128op s i8x16_eq i16x8_eq i32x4_eq i64x2_eq f32x4_eq f64x2_eq) }
  | (v128_shape as s)".ne"
    { VEC_BINARY (v128op s i8x16_ne i16x8_ne i32x4_ne i64x2_ne f32x4_ne f64x2_ne) }
  | (v128_int_shape as s)".lt_s"
    { VEC_BINARY (v128intop s i8x16_lt_s i16x8_lt_s i32x4_lt_s i64x2_lt_s) }
  | (v128_int_shape as s)".lt_u"
    { except ["i64x2"] s lexbuf;
      VEC_BINARY (v128intop s i8x16_lt_u i16x8_lt_u i32x4_lt_u unreachable) }
  | (v128_int_shape as s)".le_s"
    { VEC_BINARY (v128intop s i8x16_le_s i16x8_le_s i32x4_le_s i64x2_le_s) }
  | (v128_int_shape as s)".le_u"
    { except ["i64x2"] s lexbuf;
      VEC_BINARY (v128intop s i8x16_le_u i16x8_le_u i32x4_le_u unreachable) }
  | (v128_int_shape as s)".gt_s"
    { VEC_BINARY (v128intop s i8x16_gt_s i16x8_gt_s i32x4_gt_s i64x2_gt_s) }
  | (v128_int_shape as s)".gt_u"
    { except ["i64x2"] s lexbuf;
      VEC_BINARY (v128intop s i8x16_gt_u i16x8_gt_u i32x4_gt_u unreachable) }
  | (v128_int_shape as s)".ge_s"
    { VEC_BINARY (v128intop s i8x16_ge_s i16x8_ge_s i32x4_ge_s i64x2_ge_s) }
  | (v128_int_shape as s)".ge_u"
    { except ["i64x2"] s lexbuf;
      VEC_BINARY (v128intop s i8x16_ge_u i16x8_ge_u i32x4_ge_u unreachable) }
  | (v128_float_shape as s)".lt" { VEC_BINARY (v128floatop s f32x4_lt f64x2_lt) }
  | (v128_float_shape as s)".le" { VEC_BINARY (v128floatop s f32x4_le f64x2_le) }
  | (v128_float_shape as s)".gt" { VEC_BINARY (v128floatop s f32x4_gt f64x2_gt) }
  | (v128_float_shape as s)".ge" { VEC_BINARY (v128floatop s f32x4_ge f64x2_ge) }
  | "i8x16.swizzle" { VEC_BINARY i8x16_swizzle }

  | (v128_shape as s)".add"
    { VEC_BINARY
        (v128op s i8x16_add i16x8_add i32x4_add i64x2_add f32x4_add f64x2_add) }
  | (v128_shape as s)".sub"
    { VEC_BINARY
        (v128op s i8x16_sub i16x8_sub i32x4_sub i64x2_sub f32x4_sub f64x2_sub) }
  | (v128_shape as s)".min_s"
    { only ["i8x16"; "i16x8"; "i32x4"] s lexbuf;
      VEC_BINARY
        (v128op s i8x16_min_s i16x8_min_s i32x4_min_s unreachable
                  unreachable unreachable) }
  | (v128_shape as s)".min_u"
    { only ["i8x16"; "i16x8"; "i32x4"] s lexbuf;
      VEC_BINARY
        (v128op s i8x16_min_u i16x8_min_u i32x4_min_u unreachable
                  unreachable unreachable) }
  | (v128_shape as s)".max_s"
    { only ["i8x16"; "i16x8"; "i32x4"] s lexbuf;
      VEC_BINARY
        (v128op s i8x16_max_s i16x8_max_s i32x4_max_s unreachable
                  unreachable unreachable) }
  | (v128_shape as s)".max_u"
    { only ["i8x16"; "i16x8"; "i32x4"] s lexbuf;
      VEC_BINARY
        (v128op s i8x16_max_u i16x8_max_u i32x4_max_u unreachable
                  unreachable unreachable) }
  | (v128_shape as s)".mul"
    { only ["i16x8"; "i32x4"; "i64x2"; "f32x4"; "f64x2"] s lexbuf;
      VEC_BINARY
        (v128op s unreachable i16x8_mul i32x4_mul i64x2_mul f32x4_mul f64x2_mul) }
  | (v128_float_shape as s)".div"
    { VEC_BINARY (v128floatop s f32x4_div f64x2_div) }
  | (v128_float_shape as s)".min"
    { VEC_BINARY (v128floatop s f32x4_min f64x2_min) }
  | (v128_float_shape as s)".max"
    { VEC_BINARY (v128floatop s f32x4_max f64x2_max) }
  | (v128_float_shape as s)".pmin"
    { VEC_BINARY (v128floatop s f32x4_pmin f64x2_pmin) }
  | (v128_float_shape as s)".pmax"
    { VEC_BINARY (v128floatop s f32x4_pmax f64x2_pmax) }
  | "i8x16.add_sat_"(sign as s)
    { VEC_BINARY (ext s i8x16_add_sat_s i8x16_add_sat_u) }
  | "i8x16.sub_sat_"(sign as s)
    { VEC_BINARY (ext s i8x16_sub_sat_s i8x16_sub_sat_u) }
  | "i16x8.add_sat_"(sign as s)
    { VEC_BINARY (ext s i16x8_add_sat_s i16x8_add_sat_u) }
  | "i16x8.sub_sat_"(sign as s)
    { VEC_BINARY (ext s i16x8_sub_sat_s i16x8_sub_sat_u) }
  | "i32x4.dot_i16x8_s"
    { VEC_BINARY i32x4_dot_i16x8_s }
  | "i8x16.narrow_i16x8_"(sign as s)
    { VEC_BINARY (ext s i8x16_narrow_i16x8_s i8x16_narrow_i16x8_u) }
  | "i16x8.narrow_i32x4_"(sign as s)
    { VEC_BINARY (ext s i16x8_narrow_i32x4_s i16x8_narrow_i32x4_u) }
  | "i16x8.extend_low_i8x16_"(sign as s)
    { VEC_UNARY (ext s i16x8_extend_low_i8x16_s i16x8_extend_low_i8x16_u) }
  | "i16x8.extend_high_i8x16_"(sign as s)
    { VEC_UNARY (ext s i16x8_extend_high_i8x16_s i16x8_extend_high_i8x16_u) }
  | "i32x4.extend_low_i16x8_"(sign as s)
    { VEC_UNARY (ext s i32x4_extend_low_i16x8_s i32x4_extend_low_i16x8_u) }
  | "i32x4.extend_high_i16x8_"(sign as s)
    { VEC_UNARY (ext s i32x4_extend_high_i16x8_s i32x4_extend_high_i16x8_u) }
  | "i64x2.extend_low_i32x4_"(sign as s)
    { VEC_UNARY (ext s i64x2_extend_low_i32x4_s i64x2_extend_low_i32x4_u) }
  | "i64x2.extend_high_i32x4_"(sign as s)
    { VEC_UNARY (ext s i64x2_extend_high_i32x4_s i64x2_extend_high_i32x4_u) }
  | "i16x8.extmul_low_i8x16_"(sign as s)
    { VEC_BINARY (ext s i16x8_extmul_low_i8x16_s i16x8_extmul_low_i8x16_u) }
  | "i16x8.extmul_high_i8x16_"(sign as s)
    { VEC_BINARY (ext s i16x8_extmul_high_i8x16_s i16x8_extmul_high_i8x16_u) }
  | "i32x4.extmul_low_i16x8_"(sign as s)
    { VEC_BINARY (ext s i32x4_extmul_low_i16x8_s i32x4_extmul_low_i16x8_u) }
  | "i32x4.extmul_high_i16x8_"(sign as s)
    { VEC_BINARY (ext s i32x4_extmul_high_i16x8_s i32x4_extmul_high_i16x8_u) }
  | "i64x2.extmul_low_i32x4_"(sign as s)
    { VEC_BINARY (ext s i64x2_extmul_low_i32x4_s i64x2_extmul_low_i32x4_u) }
  | "i64x2.extmul_high_i32x4_"(sign as s)
    { VEC_BINARY (ext s i64x2_extmul_high_i32x4_s i64x2_extmul_high_i32x4_u) }
  | "i16x8.q15mulr_sat_s"
    { VEC_BINARY i16x8_q15mulr_sat_s }

  | (v128_int_shape as s)".all_true"
    { VEC_TEST
        (v128intop s i8x16_all_true i16x8_all_true i32x4_all_true i64x2_all_true) }
  | (v128_int_shape as s)".bitmask"
    { VEC_BITMASK
        (v128intop s i8x16_bitmask i16x8_bitmask i32x4_bitmask i64x2_bitmask) }
  | (v128_int_shape as s)".shl"
    { VEC_SHIFT (v128intop s i8x16_shl i16x8_shl i32x4_shl i64x2_shl) }
  | (v128_int_shape as s)".shr_s"
    { VEC_SHIFT (v128intop s i8x16_shr_s i16x8_shr_s i32x4_shr_s i64x2_shr_s) }
  | (v128_int_shape as s)".shr_u"
    { VEC_SHIFT (v128intop s i8x16_shr_u i16x8_shr_u i32x4_shr_u i64x2_shr_u) }
  | "i8x16.shuffle" { VEC_SHUFFLE }

  | (v128_shape as s)".splat"
    { VEC_SPLAT (v128op s i8x16_splat i16x8_splat i32x4_splat
                           i64x2_splat f32x4_splat f64x2_splat) }
  | (v128_shape as s)".extract_lane"
    { except ["i8x16"; "i16x8"] s lexbuf;
      VEC_EXTRACT (fun i ->
        v128op s
          (fun _ -> unreachable) (fun _ -> unreachable)
          i32x4_extract_lane i64x2_extract_lane
          f32x4_extract_lane f64x2_extract_lane i) }
  | (("i8x16"|"i16x8") as t)".extract_lane_"(sign as s)
    { VEC_EXTRACT (fun i ->
        if t = "i8x16"
        then ext s i8x16_extract_lane_s i8x16_extract_lane_u i
        else ext s i16x8_extract_lane_s i16x8_extract_lane_u i )}
  | (v128_shape as s)".replace_lane"
    { VEC_REPLACE
        (v128op s i8x16_replace_lane i16x8_replace_lane i32x4_replace_lane
                  i64x2_replace_lane f32x4_replace_lane f64x2_replace_lane) }

  | name as s { VAR s }

  | ";;"utf8_no_nl*eof { EOF }
  | ";;"utf8_no_nl*'\n' { Lexing.new_line lexbuf; token lexbuf }
  | ";;"utf8_no_nl* { token lexbuf (* causes error on following position *) }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; token lexbuf }
  | space#'\n' { token lexbuf }
  | '\n' { Lexing.new_line lexbuf; token lexbuf }
  | eof { EOF }

  | reserved { unknown lexbuf }
  | utf8 { error lexbuf "malformed operator" }
  | _ { error lexbuf "malformed UTF-8 encoding" }

and comment start = parse
  | ";)" { () }
  | "(;" { comment (Lexing.lexeme_start_p lexbuf) lexbuf; comment start lexbuf }
  | '\n' { Lexing.new_line lexbuf; comment start lexbuf }
  | eof { error_nest start lexbuf "unclosed comment" }
  | utf8 { comment start lexbuf }
  | _ { error lexbuf "malformed UTF-8 encoding" }
