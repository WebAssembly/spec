open Types
open Value

type t = exn_
and exn_ = Exn of Tag.t * value list

type ref_ += ExnRef of exn_

val alloc_exn : Tag.t -> value list -> exn_

val type_of : exn_ -> deftype
