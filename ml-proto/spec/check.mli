(*
 * (c) 2015 Andreas Rossberg
 *)

exception Invalid of Source.region * string

val check_module : Kernel.module_ -> unit (* raise Invalid *)
