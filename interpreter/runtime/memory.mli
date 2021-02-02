open Types
open Values

type memory
type t = memory

type size = int64  (* number of pages *)
type address = int64
type offset = int64

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

val page_size : int64

val alloc : memory_type -> memory (* raises SizeOverflow, OutOfMemory *)
val type_of : memory -> memory_type
val index_of : memory -> index_type
val size : memory -> size
val bound : memory -> address
val value_of_address : index_type -> address -> value
val address_of_value : value -> address
val grow : memory -> size -> unit
  (* raises SizeLimit, SizeOverflow, OutOfMemory *)

val load_byte : memory -> address -> int (* raises Bounds *)
val store_byte : memory -> address -> int -> unit (* raises Bounds *)
val load_bytes : memory -> address -> int -> string (* raises Bounds *)
val store_bytes : memory -> address -> string -> unit (* raises Bounds *)

val load_value :
  memory -> address -> offset -> value_type -> value (* raises Bounds *)
val store_value :
  memory -> address -> offset -> value -> unit (* raises Bounds *)
val load_packed :
  pack_size -> extension -> memory -> address -> offset -> value_type -> value
    (* raises Type, Bounds *)
val store_packed :
  pack_size -> memory -> address -> offset -> value -> unit
    (* raises Type, Bounds *)
