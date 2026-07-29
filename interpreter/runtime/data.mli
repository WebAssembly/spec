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

val load_num : data -> address -> numtype -> num (* raises Bounds *)
val load_vec : data -> address -> vectype -> vec (* raises Bounds *)
val load_val : data -> address -> valtype -> value (* raises Type, Bounds *)

val load_num_packed :
  Pack.packsize -> Pack.sx -> data -> address -> numtype -> num
    (* raises Type, Bounds *)
val load_vec_packed :
  Pack.packsize -> Pack.vext -> data -> address -> vectype -> vec
    (* raises Type, Bounds *)
val load_val_storage :
  data -> address -> storagetype -> value (* raises Type, Bounds *)
