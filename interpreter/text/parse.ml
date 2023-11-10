module Make (M : sig
  type t

  val rule : (Lexing.lexbuf -> Parser.token) -> Lexing.lexbuf -> t

end) = struct

  type nonrec t = M.t

  let from_lexbuf =
    let parser = MenhirLib.Convert.Simplified.traditional2revised M.rule in
    fun buf ->
      let provider () =
        let tok = Lexer.token buf in
        let start = Lexing.lexeme_start_p buf in
        let stop = Lexing.lexeme_end_p buf in
        tok, start, stop
      in
      try parser provider with
      | Parser.Error ->
          let left = Lexer.convert_pos buf.Lexing.lex_start_p in
          let right = Lexer.convert_pos buf.Lexing.lex_curr_p in
          let region = { Source.left; right } in
          raise (Script.Syntax (region, "unexpected token"))
      | Script.Syntax (region, s) as exn ->
          if region <> Source.no_region then raise exn
          else
            let region' = {
              Source.left = Lexer.convert_pos buf.Lexing.lex_start_p;
              Source.right = Lexer.convert_pos buf.Lexing.lex_curr_p }
            in
            raise (Script.Syntax (region', s))

  let from_file filename =
    let chan = open_in filename in
      Fun.protect ~finally:(fun () -> close_in chan)
      (fun () ->
        let lb = Lexing.from_channel ~with_positions:true chan in
        Lexing.set_filename lb filename;
      from_lexbuf lb)

  let from_string s = from_lexbuf (Lexing.from_string ~with_positions:true s)

  let from_channel c = from_lexbuf (Lexing.from_channel ~with_positions:true c)
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
