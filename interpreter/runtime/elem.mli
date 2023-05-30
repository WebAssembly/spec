open Value

type elem
type t = elem

exception Bounds

val alloc : ref_ list -> elem
val size : elem -> Table.size
val load : elem -> Table.index -> ref_ (* raises Bounds *)
val drop : elem -> unit
