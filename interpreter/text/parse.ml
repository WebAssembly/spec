exception Syntax = Parse_error.Syntax

module type S =
sig
  type t
  val parse : string -> Lexing.lexbuf -> t
  val parse_file : string -> t
  val parse_string : string -> t
  val parse_channel : in_channel -> t
end

let convert_pos lexbuf =
  { Source.left = Lexer.convert_pos lexbuf.Lexing.lex_start_p;
    Source.right = Lexer.convert_pos lexbuf.Lexing.lex_curr_p
  }

let make (type a) (start : _ -> _ -> a) : (module S with type t = a) =
  (module struct
    type t = a

    let parse name lexbuf =
      Lexing.set_filename lexbuf name;
      try start Lexer.token lexbuf with Parser.Error ->
        raise (Syntax (convert_pos lexbuf, "unexpected token"))

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
