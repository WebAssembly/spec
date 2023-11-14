exception Syntax of Source.region * string

module type S =
sig
  type t
  val from_lexbuf : Lexing.lexbuf -> t
  val from_file : string -> t
  val from_string : string -> t
  val from_channel : in_channel -> t
end

module Module : S with type t = Script.var option * Script.definition
module Script1 : S with type t = Script.script
module Script : S with type t = Script.script
