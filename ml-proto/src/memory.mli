(*
 * (c) 2015 Andreas Rossberg
 *)

type memory
type t = memory
type address = int
type size = address
type signed = bool option

type segment = {addr : address; data : string}

exception Type
exception Bounds
exception Address

val create : size -> memory
val init : memory -> segment list -> unit
val load : memory -> address -> size -> Types.value_type -> signed -> Values.value
val store : memory -> address -> size -> Values.value -> unit

val address_of_value : Values.value -> address
