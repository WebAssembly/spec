open Types
open Value

type table
type t = table

type size = address
type offset = address

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

val alloc : table_type -> ref_ -> table (* raises Type, OutOfMemory *)
val type_of : table -> table_type
val addr_type_of : table -> addr_type
val size : table -> size
val addr_of_num : num -> address
val grow : table -> size -> ref_ -> unit
  (* raises SizeOverflow, SizeLimit, OutOfMemory *)

val load : table -> address -> ref_ (* raises Bounds *)
val store : table -> address -> ref_ -> unit (* raises Type, Bounds *)
val blit : table -> address -> ref_ list -> unit (* raises Bounds *)
