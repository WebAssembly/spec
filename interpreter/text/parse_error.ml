(* This is here since both Lexer, Parser, and Parse need it,
 * but menhir cannot create a Parser that exports it. *)
exception Syntax of Source.region * string
