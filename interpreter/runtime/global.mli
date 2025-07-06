open Types
open Value

type global
type t = global

exception Type
exception NotMutable

val alloc : globaltype -> value -> global  (* raises Type *)
val type_of : global -> globaltype

val load : global -> value
val store : global -> value -> unit  (* raises Type, NotMutable *)
