(*
 * (c) 2015 Andreas Rossberg
 *)

type memory
type t = memory
type address = int
type alignment = Aligned | Unaligned
type mem_type =
  | SInt8Mem | SInt16Mem | SInt32Mem | SInt64Mem
  | UInt8Mem | UInt16Mem | UInt32Mem | UInt64Mem
  | Float32Mem | Float64Mem

exception Bounds
exception Align
exception Address

val create : int -> memory
val load : memory -> alignment -> address -> mem_type -> Types.value
val store : memory -> alignment -> address -> mem_type -> Types.value -> unit

val address_of_value : Types.value -> address
