type instance
type 'a stack = 'a list
type value = Values.value
type import = value stack -> value stack

exception Trap of Source.region * string
exception Crash of Source.region * string

val init : Ast.module_ -> import list -> instance
val invoke : instance -> string -> value list -> value list
  (* raises Trap, Crash *)
