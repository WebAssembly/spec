open Il.Ast

include module type of Xl.Gen_free

val det_typ : typ -> sets
val det_exp : exp -> sets
val det_sym : sym -> sets
val det_prem : prem -> sets
val det_arg : arg -> sets

val det_list : ('a -> sets) -> 'a list -> sets
