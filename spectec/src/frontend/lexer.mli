val convert_pos : Lexing.position -> Util.Source.pos

val token : Lexing.lexbuf -> Parser.token  (* raises Source.Error *)
