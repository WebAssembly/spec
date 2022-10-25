open Values

type elem
type t = elem

val alloc : ref_ list -> elem
val size : elem -> Table.size
val load : elem -> Table.index -> ref_
val drop : elem -> unit
