open Ast

module Set : Set.S with type elt = string

type sets = {typid : Set.t; relid : Set.t; varid : Set.t; defid : Set.t}

val subset : sets -> sets -> bool
val disjoint : sets -> sets -> bool
val union : sets -> sets -> sets
val diff : sets -> sets -> sets

val free_opt : ('a -> sets) -> 'a option -> sets
val free_list : ('a -> sets) -> 'a list -> sets

val free_iter : iter -> sets
val free_typ : typ -> sets
val free_exp : exp -> sets
val free_path : path -> sets
val free_prem : premise -> sets
val free_arg : arg -> sets
val free_def : def -> sets
val free_deftyp : deftyp -> sets

val bound_typbind : id * typ -> sets
val bound_def : def -> sets
