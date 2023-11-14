exception Syntax = Script.Syntax

module type S =
sig
  type t
  val from_lexbuf : Lexing.lexbuf -> t
  val from_file : string -> t
  val from_string : string -> t
  val from_channel : in_channel -> t
end

module type Rule =
sig
  type t
  val rule : (Lexing.lexbuf -> Parser.token) -> Lexing.lexbuf -> t
end

module Make (M : Rule) : S with type t = M.t =
struct
  type t = M.t

  let provider buf () =
    let tok = Lexer.token buf in
    let start = Lexing.lexeme_start_p buf in
    let stop = Lexing.lexeme_end_p buf in
    tok, start, stop

  let convert_pos buf =
    { Source.left = Lexer.convert_pos buf.Lexing.lex_start_p;
      Source.right = Lexer.convert_pos buf.Lexing.lex_curr_p
    }

  let from_lexbuf buf =
    try
      MenhirLib.Convert.Simplified.traditional2revised M.rule (provider buf)
    with
    | Parser.Error ->
      raise (Syntax (convert_pos buf, "unexpected token"))
    | Syntax (region, s) when region <> Source.no_region ->
      raise (Syntax (convert_pos buf, s))

  let from_string s = from_lexbuf (Lexing.from_string ~with_positions:true s)
  let from_channel c = from_lexbuf (Lexing.from_channel ~with_positions:true c)
  let from_file name =
    let chan = open_in name in
    Fun.protect ~finally:(fun () -> close_in chan) (fun () ->
      let buf = Lexing.from_channel ~with_positions:true chan in
      Lexing.set_filename buf name;
      from_lexbuf buf
    )
end

module Module = Make (struct
  type t = Script.var option * Script.definition
  let rule = Parser.module1
end)

module Script1 = Make (struct
  type t = Script.script
  let rule = Parser.script1
end)

module Script = Make (struct
  type t =  Script.script
  let rule = Parser.script
end)
