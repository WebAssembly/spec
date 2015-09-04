(*
 * (c) 2015 Andreas Rossberg
 *)

type memory
type t = memory
type address = int
type size = address
type mem_size = int
type mem_type =
  | SInt8Mem | SInt16Mem | SInt32Mem | SInt64Mem
  | UInt8Mem | UInt16Mem | UInt32Mem | UInt64Mem
  | Float32Mem | Float64Mem

type segment = {addr : address; data : string}

exception Type
exception Bounds
exception Address

val create : size -> memory
val init : memory -> segment list -> unit
val load : memory -> address -> mem_type -> Types.value_type -> Values.value
val store : memory -> address -> mem_type -> Values.value -> unit

val mem_size : mem_type -> mem_size
val address_of_value : Values.value -> address
