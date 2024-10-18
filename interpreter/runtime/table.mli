open Types
open Value

type table
type t = table

type size = int64
type index = int64
type count = int32

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

val alloc : table_type -> ref_ -> table (* raises Type, OutOfMemory *)
val type_of : table -> table_type
val addr_type_of : table -> addr_type
val size : table -> size
val index_of_num : num -> index
val grow : table -> size -> ref_ -> unit
  (* raises SizeOverflow, SizeLimit, OutOfMemory *)

val load : table -> index -> ref_ (* raises Bounds *)
val store : table -> index -> ref_ -> unit (* raises Type, Bounds *)
val blit : table -> index -> ref_ list -> unit (* raises Bounds *)
