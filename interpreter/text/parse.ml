exception Syntax = Parse_error.Syntax

module type S =
sig
  type t
  val parse : string -> Lexing.lexbuf -> t
  val parse_file : string -> t
  val parse_string : string -> t
  val parse_channel : in_channel -> t
end

let provider buf () =
  let tok = Lexer.token buf in
  let start = Lexing.lexeme_start_p buf in
  let stop = Lexing.lexeme_end_p buf in
  tok, start, stop

let convert_pos buf =
  { Source.left = Lexer.convert_pos buf.Lexing.lex_start_p;
    Source.right = Lexer.convert_pos buf.Lexing.lex_curr_p
  }

let make (type a) (start : _ -> _ -> a) : (module S with type t = a) =
  (module struct
    type t = a

    let parse name buf =
      Lexing.set_filename buf name;
      try
        MenhirLib.Convert.Simplified.traditional2revised start (provider buf)
      with
      | Parser.Error ->
        raise (Syntax (convert_pos buf, "unexpected token"))
      | Syntax (region, s) when region <> Source.no_region ->
        raise (Syntax (convert_pos buf, s))

    let parse_string s =
      parse "string" (Lexing.from_string ~with_positions:true s)

    let parse_channel oc =
      parse "channel" (Lexing.from_channel ~with_positions:true oc)

    let parse_file name =
      let oc = open_in name in
      Fun.protect ~finally:(fun () -> close_in oc) (fun () ->
        parse name (Lexing.from_channel ~with_positions:true oc)
      )
  end)

module Module = (val make Parser.module1)
module Script = (val make Parser.script)
module Script1 = (val make Parser.script1)
