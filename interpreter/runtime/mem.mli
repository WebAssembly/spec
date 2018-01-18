open Types
open Values

type mem
type t = mem

type size = int32  (* number of pages *)
type address = int64
type offset = int32

type packed_size = Pack8 | Pack16 | Pack32
type extension = SX | ZX

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

val page_size : int64
val packed_size : packed_size -> int

val alloc : mem_type -> mem (* raises SizeOverflow, OutOfMemory *)
val type_of : mem -> mem_type
val size : mem -> size
val bound : mem -> address
val grow : mem -> size -> unit
  (* raises SizeLimit, SizeOverflow, OutOfMemory *)

val load_byte : mem -> address -> int (* raises Bounds *)
val store_byte : mem -> address -> int -> unit (* raises Bounds *)
val load_bytes : mem -> address -> int -> string (* raises Bounds *)
val store_bytes : mem -> address -> string -> unit (* raises Bounds *)

val load_value :
  mem -> address -> offset -> value_type -> value (* raises Bounds *)
val store_value :
  mem -> address -> offset -> value -> unit (* raises Bounds *)
val load_packed :
  packed_size -> extension -> mem -> address -> offset -> value_type -> value
    (* raises Type, Bounds *)
val store_packed :
  packed_size -> mem -> address -> offset -> value -> unit
    (* raises Type, Bounds *)
