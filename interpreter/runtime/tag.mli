open Types

type tag
type t = tag

val alloc : tag_type -> tag
val type_of : tag -> tag_type
