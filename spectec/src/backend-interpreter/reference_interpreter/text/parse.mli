type 'a start =
  | Module : (Script.var option * Script.definition) start
  | Script : Script.script start
  | Script1 : Script.script start

exception Syntax of Source.region * string

val parse : string -> Lexing.lexbuf -> 'a start -> 'a (* raises Syntax *)

val string_to_script : string -> Script.script (* raises Syntax *)
val string_to_definition : string -> Script.definition (* raises Syntax *)
val string_to_module : string -> Ast.module_ (* raises Syntax *)
