open Types
open Values

type memory
type t = memory

type size = int32  (* number of pages *)
type address = int64
type offset = int32

type mem_size = Mem8 | Mem16 | Mem32
type extension = SX | ZX

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

val page_size : int64
val mem_size : mem_size -> int

val alloc : memory_type -> memory (* raises SizeOverflow, OutOfMemory *)
val type_of : memory -> memory_type
val size : memory -> size
val bound : memory -> address
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
  mem_size -> extension -> memory -> address -> offset -> value_type -> value
    (* raises Type, Bounds *)
val store_packed :
  mem_size -> memory -> address -> offset -> value -> unit
    (* raises Type, Bounds *)
