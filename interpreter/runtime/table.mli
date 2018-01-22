open Types

type table
type t = table

type size = int32
type index = int32

type elem = ..
type elem += Uninitialized

exception Bounds
exception SizeOverflow
exception SizeLimit

val alloc : table_type -> table
val type_of : table -> table_type
val size : table -> size
val grow : table -> size -> unit (* raises SizeOverflow, SizeLimit *)

val load : table -> index -> elem (* raises Bounds *)
val store : table -> index -> elem -> unit (* raises Bounds *)
val blit : table -> index -> elem list -> unit (* raises Bounds *)
