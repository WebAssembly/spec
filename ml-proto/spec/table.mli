type table
type t = table

type size = int32
type index = int32

type elem = int32 option
type elem_type = Types.elem_type

exception Bounds
exception SizeOverflow
exception SizeLimit

val create : size -> size option -> table
val size : table -> size
val grow : table -> size -> unit

val load : table -> index -> elem_type -> elem
val store : table -> index -> elem -> unit
val blit : table -> index -> elem list -> unit

