open Types.Dyn
open Value

type global
type t = global

exception Type
exception NotMutable

val alloc : global_type -> value -> global  (* raises Type *)
val type_of : global -> global_type

val load : global -> value
val store : global -> value -> unit  (* raises Type, NotMutable *)
