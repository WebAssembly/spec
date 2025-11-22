open Value
open Instance

exception Link of Source.region * string
exception Trap of Source.region * string
exception Crash of Source.region * string
exception Exhaustion of Source.region * string
exception Exception of Source.region * Exn.t

val init : Ast.module_ -> externinst list -> moduleinst (* raises Link, Trap, Exception *)
val invoke : funcinst -> value list -> value list (* raises Trap, Exception *)
