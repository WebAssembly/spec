(*
 * (c) 2015 Andreas Rossberg
 *)

type memory
type t = memory
type address = int
type size = address
type alignment = Aligned | Unaligned
type mem_type =
  | SInt8Mem | SInt16Mem | SInt32Mem | SInt64Mem
  | UInt8Mem | UInt16Mem | UInt32Mem | UInt64Mem
  | Float32Mem | Float64Mem

type segment =
{
  addr : address;
  data : string
}

exception Bounds
exception Align
exception Address

val create : size -> memory
val init : memory -> segment list -> unit
val load : memory -> alignment -> address -> mem_type -> Values.value
val store : memory -> alignment -> address -> mem_type -> Values.value -> unit

val address_of_value : Values.value -> address
