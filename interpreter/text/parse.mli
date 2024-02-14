exception Syntax of Source.region * string

module type S =
sig
  type t
  val parse : string -> Lexing.lexbuf -> t (* raises Syntax *)
  val parse_file : string -> t (* raises Syntax *)
  val parse_string : string -> t (* raises Syntax *)
  val parse_channel : in_channel -> t (* raises Syntax *)
end

module Module : S with type t = Script.var option * Script.definition
module Script1 : S with type t = Script.script
module Script : S with type t = Script.script
