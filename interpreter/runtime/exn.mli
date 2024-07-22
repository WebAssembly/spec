open Types
open Value

type exn_ = Exn of Tag.t * value list

type ref_ += ExnRef of exn_

val alloc_exn : Tag.t -> value list -> exn_

val type_of_exn : exn_ -> def_type
