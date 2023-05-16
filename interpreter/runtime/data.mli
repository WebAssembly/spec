open Types
open Value

type data
type t = data
type address = Memory.address

exception Type
exception Bounds

val alloc : string -> data
val size : data -> address
val load : data -> address -> char
val bytes : data -> string
val drop : data -> unit

val load_num : data -> address -> num_type -> num (* raises Bounds *)
val load_vec : data -> address -> vec_type -> vec (* raises Bounds *)
val load_val : data -> address -> val_type -> value (* raises Type, Bounds *)
val load_num_packed :
  Pack.pack_size -> Pack.extension -> data -> address -> num_type -> num
    (* raises Type, Bounds *)
val load_field : data -> address -> storage_type -> value (* raises Typr, Bounds *)
