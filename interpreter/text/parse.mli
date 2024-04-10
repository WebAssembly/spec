exception Syntax of Source.region * string

module type S =
sig
  type t
  val parse : string -> Lexing.lexbuf -> t
  val parse_file : string -> t
  val parse_string : ?offset:Source.region -> string -> t
  val parse_channel : in_channel -> t
end

module Module : S with type t = Script.var option * Script.definition
module Script1 : S with type t = Script.script
module Script : S with type t = Script.script
