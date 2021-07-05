open Types

type tag = {ty : func_type}
type t = tag

val alloc : func_type -> tag
val type_of : tag -> func_type
