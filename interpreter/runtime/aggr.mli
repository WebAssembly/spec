open Types
open Value

type field =
  | ValField of value ref
  | PackField of Pack.pack_size * int ref

type struct_ = Struct of def_type * field list
type array = Array of def_type * field list

type ref_ += StructRef of struct_
type ref_ += ArrayRef of array

val alloc_struct : def_type -> value list -> struct_
val alloc_array : def_type -> value list -> array

val type_of_struct : struct_ -> def_type
val type_of_array : array -> def_type

val read_field : field -> Pack.extension option -> value  (* raises Failure *)
val write_field : field -> value -> unit  (* raises Falure *)

val array_length : array -> int32
