open Types
open Values

type table
type t = table

type size = int32
type index = int32

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit

val alloc : table_type -> table
val type_of : table -> table_type
val size : table -> size
val grow : table -> size -> unit (* raises SizeOverflow, SizeLimit *)

val load : table -> index -> ref_ (* raises Bounds *)
val store : table -> index -> ref_ -> unit (* raises Type, Bounds *)
val blit : table -> index -> ref_ list -> unit (* raises Bounds *)
