open Types
open Value

type field =
  | ValField of value ref
  | PackField of Pack.pack_size * int ref

type aggr =
  | Struct of type_addr * Rtt.t * field list
  | Array of type_addr * Rtt.t * field list
type t = aggr

type ref_ += AggrRef of aggr

val alloc_struct : type_addr -> Rtt.t -> value list -> aggr
val alloc_array : type_addr -> Rtt.t -> value list -> aggr

val struct_type_of : aggr -> struct_type
val array_type_of : aggr -> array_type
val type_inst_of : aggr -> type_addr

val read_rtt : aggr -> Rtt.t

val read_field : field -> Pack.extension option -> value  (* raises Failure *)
val write_field : field -> value -> unit  (* raises Falure *)
