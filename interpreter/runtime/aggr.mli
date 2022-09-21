open Types
open Value

type field =
  | ValField of value ref
  | PackField of Pack.pack_size * int ref

type struct_ = Struct of type_addr * field list
type array = Array of type_addr * field list

type ref_ += StructRef of struct_
type ref_ += ArrayRef of array

val alloc_struct : type_addr -> value list -> struct_
val alloc_array : type_addr -> value list -> array

val type_of_struct : struct_ -> struct_type
val type_of_array : array -> array_type
val type_inst_of_struct : struct_ -> type_addr
val type_inst_of_array : array -> type_addr

val read_field : field -> Pack.extension option -> value  (* raises Failure *)
val write_field : field -> value -> unit  (* raises Falure *)
