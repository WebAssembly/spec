
open Types
open Value

type field =
  | ValueField of value ref
  | PackedField of pack_size * int ref

type data =
  | Struct of sem_var * Rtt.t * field list
  | Array of sem_var * Rtt.t * field list
type t = data

type ref_ += DataRef of data

val alloc_struct : sem_var -> Rtt.t -> value list -> data
val alloc_array : sem_var -> Rtt.t -> value list -> data

val struct_type_of : data -> struct_type
val array_type_of : data -> array_type
val type_inst_of : data -> sem_var

val read_rtt : data -> Rtt.t

val read_field : field -> extension option -> value  (* raises Failure *)
val write_field : field -> value -> unit  (* raises Falure *)
