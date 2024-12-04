open Value

type data
type t = data

exception Bounds

val alloc : string -> data
val size : data -> address
val drop : data -> unit

val load_byte : data -> address -> char (* raises Bounds *)
val load_bytes : data -> address -> int -> string (* raises Bounds *)


(* Typed accessors *)

open Types
open Value

val load_num : data -> address -> num_type -> num (* raises Bounds *)
val load_vec : data -> address -> vec_type -> vec (* raises Bounds *)
val load_val : data -> address -> val_type -> value (* raises Type, Bounds *)

val load_num_packed :
  Pack.pack_size -> Pack.extension -> data -> address -> num_type -> num
    (* raises Type, Bounds *)
val load_vec_packed :
  Pack.pack_size -> Pack.vec_extension -> data -> address -> vec_type -> vec
    (* raises Type, Bounds *)
val load_val_storage :
  data -> address -> storage_type -> value (* raises Type, Bounds *)
