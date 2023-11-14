module Module : sig
  type t = Script.var option * Script.definition
  val from_lexbuf : Lexing.lexbuf -> t
  val from_file : string -> t
  val from_string : string -> t
  val from_channel : in_channel -> t
end

module Script1 : sig
  type t = Script.script
  val from_lexbuf : Lexing.lexbuf -> t
  val from_file : string -> t
  val from_string : string -> t
  val from_channel : in_channel -> t
end

module Script : sig
  type t = Script.script
  val from_lexbuf : Lexing.lexbuf -> t
  val from_file : string -> t
  val from_string : string -> t
  val from_channel : in_channel -> t
end
