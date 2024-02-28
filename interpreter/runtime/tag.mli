open Types

type tag = {ty : tag_type}
type t = tag

val alloc : tag_type -> tag
val type_of : tag -> tag_type
