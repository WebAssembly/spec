open Types

type event = {ty : func_type}
type t = event

val alloc : func_type -> event
val type_of : event -> func_type
