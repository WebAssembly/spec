open Values
open Instance

exception Link of Source.region * string
exception Trap of Source.region * string
exception Crash of Source.region * string

val init : Kernel.module_ -> extern list -> instance
val invoke : func -> value list -> value option  (* raises Trap *)
val const : Kernel.module_ -> Kernel.expr -> value
