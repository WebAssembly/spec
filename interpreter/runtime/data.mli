type data
type t = data

val alloc : string -> data
val size : data -> Memory.address
val load : data -> Memory.address -> char
val drop : data -> unit
