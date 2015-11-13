type instance
type value = Values.value
type import = value list -> value option
type host_params = {
  has_feature : string -> bool
}

exception Trap of Source.region * string
exception Crash of Source.region * string

val init : Ast.module_ -> import list -> host_params -> instance
val invoke : instance -> string -> value list -> value option
  (* raises Trap, Crash *)

