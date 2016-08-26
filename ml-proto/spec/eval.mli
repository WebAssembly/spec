open Values
open Instance

exception Trap of Source.region * string
exception Crash of Source.region * string

val init : Kernel.module_ -> extern list -> instance
val invoke : instance -> string -> value list -> value option
  (* raises Trap, Crash *)
val const : Kernel.module_ -> Kernel.expr -> value
