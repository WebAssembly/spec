open Types
open Values

type memory
type t = memory

type size = int32  (* number of pages *)
type address = int64
type offset = int32
type count = int32

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

val page_size : int64

val alloc : memory_type -> memory (* raises Type, SizeOverflow, OutOfMemory *)
val type_of : memory -> memory_type
val size : memory -> size
val bound : memory -> address
val grow : memory -> size -> unit
  (* raises SizeLimit, SizeOverflow, OutOfMemory *)

val load_byte : memory -> address -> int (* raises Bounds *)
val store_byte : memory -> address -> int -> unit (* raises Bounds *)
val load_bytes : memory -> address -> int -> string (* raises Bounds *)
val store_bytes : memory -> address -> string -> unit (* raises Bounds *)

val load_num :
  memory -> address -> offset -> num_type -> num (* raises Bounds *)
val store_num :
  memory -> address -> offset -> num -> unit (* raises Bounds *)
val load_num_packed :
  pack_size -> extension -> memory -> address -> offset -> num_type -> num
    (* raises Type, Bounds *)
val store_num_packed :
  pack_size -> memory -> address -> offset -> num -> unit
    (* raises Type, Bounds *)

val load_vec :
  memory -> address -> offset -> vec_type -> vec (* raises Bounds *)
val store_vec :
  memory -> address -> offset -> vec -> unit
    (* raises Type, Bounds *)
val load_vec_packed :
  pack_size -> vec_extension -> memory -> address -> offset -> vec_type -> vec
    (* raises Type, Bounds *)
