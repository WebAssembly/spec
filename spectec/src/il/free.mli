open Ast

module Set : Set.S with type elt = string with type t = Set.Make(String).t

type sets = {typid : Set.t; relid : Set.t; varid : Set.t; defid : Set.t; gramid : Set.t}

val empty : sets
val union : sets -> sets -> sets
val diff : sets -> sets -> sets

val subset : sets -> sets -> bool
val disjoint : sets -> sets -> bool

val free_opt : ('a -> sets) -> 'a option -> sets
val free_list : ('a -> sets) -> 'a list -> sets

val free_varid : id -> sets

val free_iter : iter -> sets
val free_typ : typ -> sets
val free_exp : exp -> sets
val free_path : path -> sets
val free_prem : prem -> sets
val free_arg : arg -> sets
val free_def : def -> sets
val free_rule : rule -> sets
val free_clause : clause -> sets
val free_prod : prod -> sets
val free_deftyp : deftyp -> sets
val free_param : param -> sets

val bound_typbind : exp * typ -> sets
val bound_bind : bind -> sets
val bound_param : param -> sets
val bound_def : def -> sets
