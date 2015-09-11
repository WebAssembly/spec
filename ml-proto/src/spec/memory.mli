(*
 * (c) 2015 Andreas Rossberg
 *)

type memory
type t = memory
type address = int
type size = address
type mem_size = int
type extension = SX | ZX | NX
type mem_type =
  Int8Mem | Int16Mem | Int32Mem | Int64Mem | Float32Mem | Float64Mem

type segment = {addr : address; data : string}

exception Type
exception Bounds
exception Address

val create : size -> memory
val init : memory -> segment list -> unit
val load : memory -> address -> mem_type -> extension -> Values.value
val store : memory -> address -> mem_type -> Values.value -> unit

val mem_size : mem_type -> mem_size
val address_of_value : Values.value -> address
