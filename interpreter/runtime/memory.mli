open Types
open Value

type memory
type t = memory

type size = int64  (* number of pages *)
type offset = address
type count = int32

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

val page_size : int64

val alloc : memorytype -> memory (* raises Type, SizeOverflow, OutOfMemory *)
val type_of : memory -> memorytype
val addrtype_of : memory -> addrtype
val size : memory -> size
val bound : memory -> address
val grow : memory -> size -> unit
  (* raises SizeLimit, SizeOverflow, OutOfMemory *)

val load_byte : memory -> address -> int (* raises Bounds *)
val store_byte : memory -> address -> int -> unit (* raises Bounds *)
val load_bytes : memory -> address -> int -> string (* raises Bounds *)
val store_bytes : memory -> address -> string -> unit (* raises Bounds *)


(* Typed accessors *)

val load_num :
  memory -> address -> offset -> numtype -> num (* raises Bounds *)
val store_num :
  memory -> address -> offset -> num -> unit (* raises Bounds *)
val load_num_packed :
  Pack.packsize -> Pack.sx -> memory -> address -> offset -> numtype -> num
    (* raises Type, Bounds *)
val store_num_packed :
  Pack.packsize -> memory -> address -> offset -> num -> unit
    (* raises Type, Bounds *)

val load_vec :
  memory -> address -> offset -> vectype -> vec (* raises Bounds *)
val store_vec :
  memory -> address -> offset -> vec -> unit
    (* raises Type, Bounds *)
val load_vec_packed :
  Pack.packsize -> Pack.vext -> memory -> address -> offset -> vectype -> vec
    (* raises Type, Bounds *)

val load_val :
  memory -> address -> offset -> valtype -> value (* raises Type, Bounds *)
val store_val :
  memory -> address -> offset -> value -> unit (* raises Type, Bounds *)
val load_val_storage :
  memory -> address -> offset -> storagetype -> value (* raises Type, Bounds *)
val store_val_storage :
  memory -> address -> offset -> storagetype -> value -> unit (* raises Type, Bounds *)
