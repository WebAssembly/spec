open Values
open Instance

exception Link of Source.region * string
exception Trap of Source.region * string
exception Crash of Source.region * string
exception Exhaustion of Source.region * string

val init : Ast.module_ -> extern list -> instance (* raises Link, Trap *)
val invoke : closure -> value list -> value list (* raises Trap *)

val eval_const : instance -> Ast.const -> value
