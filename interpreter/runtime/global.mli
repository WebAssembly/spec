open Types
open Values

type global
type t = global

exception NotMutable

val alloc : global_type -> value -> global
val type_of : global -> global_type

val load : global -> value
val store : global -> value -> unit  (* raises NotMutable *)
