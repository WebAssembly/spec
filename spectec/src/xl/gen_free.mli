module Set : Set.S with type elt = string with type t = Set.Make(String).t

type id = string Util.Source.phrase

type sets = {typid : Set.t; relid : Set.t; varid : Set.t; defid : Set.t; gramid : Set.t}

val empty : sets
val union : sets -> sets -> sets
val inter : sets -> sets -> sets
val diff : sets -> sets -> sets

val ( ++ ) : sets -> sets -> sets  (* union *)
val ( ** ) : sets -> sets -> sets  (* intersection *)
val ( -- ) : sets -> sets -> sets  (* difference *)

val subset : sets -> sets -> bool
val disjoint : sets -> sets -> bool

val free_typid : id -> sets
val free_relid : id -> sets
val free_varid : id -> sets
val free_defid : id -> sets
val free_gramid : id -> sets

val bound_typid : id -> sets
val bound_relid : id -> sets
val bound_varid : id -> sets
val bound_defid : id -> sets
val bound_gramid : id -> sets

val free_empty : 'a -> sets
val free_pair : ('a -> sets) -> ('b -> sets) -> 'a * 'b -> sets
val free_opt : ('a -> sets) -> 'a option -> sets
val free_list : ('a -> sets) -> 'a list -> sets
val free_list_dep : ('a -> sets) -> ('a -> sets) -> 'a list -> sets

val bound_list : ('a -> sets) -> 'a list -> sets
