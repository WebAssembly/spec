open Ast

module Set : Set.S with type elt = string

type sets = {synid : Set.t; relid : Set.t; varid : Set.t; defid : Set.t}

val free_list : ('a -> sets) -> 'a list -> sets
val free_nl_list : ('a -> sets) -> 'a nl_list -> sets

val free_iter : iter -> sets
val free_typ : typ -> sets
val free_exp : exp -> sets
val free_path : path -> sets
val free_prem : premise -> sets
val free_def : def -> sets
