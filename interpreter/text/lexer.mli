val loc_of_pos : Lexing.position -> Source.loc

val token : Lexing.lexbuf -> Parser.token  (* raises Source.Error *)
