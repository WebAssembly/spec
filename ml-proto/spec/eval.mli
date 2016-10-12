open Values
open Instance

exception Link of Source.region * string
exception Trap of Source.region * string
exception Crash of Source.region * string

val init : Ast.module_ -> extern list -> instance
val invoke : closure -> value list -> value list (* raises Trap *)
