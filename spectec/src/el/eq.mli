open Ast

val eq_iter : iter -> iter -> bool
val eq_exp : exp -> exp -> bool
val eq_typ : typ -> typ -> bool
val eq_param : param -> param -> bool

val eq_list : ('a -> 'a -> bool) -> 'a list -> 'a list -> bool
