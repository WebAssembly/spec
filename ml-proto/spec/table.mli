type table
type t = table

type size = int32
type index = int32

type elem = exn option
type elem_type = Types.elem_type
type 'a limits = 'a Types.limits

exception Bounds
exception SizeOverflow
exception SizeLimit

val create : size limits -> table
val size : table -> size
val limits : table -> size limits
val grow : table -> size -> unit

val load : table -> index -> elem_type -> elem
val store : table -> index -> elem -> unit
val blit : table -> index -> elem list -> unit

