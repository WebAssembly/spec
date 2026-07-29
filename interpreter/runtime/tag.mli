open Types

type tag
type t = tag

val alloc : tagtype -> tag
val type_of : tag -> tagtype
