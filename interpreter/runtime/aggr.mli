open Types
open Value

type field =
  | ValField of value ref
  | PackField of packtype * int ref

type struct_ = Struct of deftype * field list
type array = Array of deftype * field list

type ref_ += StructRef of struct_
type ref_ += ArrayRef of array

val alloc_struct : deftype -> value list -> struct_
val alloc_array : deftype -> value list -> array

val type_of_struct : struct_ -> deftype
val type_of_array : array -> deftype

val read_field : field -> Pack.sx option -> value  (* raises Failure *)
val write_field : field -> value -> unit  (* raises Falure *)

val array_length : array -> int32
