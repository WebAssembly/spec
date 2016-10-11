type table
type t = table

type size = int32
type index = int32

type elem = ..
type elem += Uninitialized
type elem_type = Types.elem_type
type 'a limits = 'a Types.limits

exception Bounds
exception SizeOverflow
exception SizeLimit

val create : elem_type -> size limits -> table
val elem_type : table -> elem_type
val size : table -> size
val limits : table -> size limits
val grow : table -> size -> unit

val load : table -> index -> elem
val store : table -> index -> elem -> unit
val blit : table -> index -> elem list -> unit
