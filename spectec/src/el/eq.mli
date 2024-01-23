open Ast

val eq_iter : iter -> iter -> bool
val eq_exp : exp -> exp -> bool
val eq_typ : typ -> typ -> bool
val eq_sym : sym -> sym -> bool
val eq_arg : arg -> arg -> bool
val eq_param : param -> param -> bool
val eq_prem : premise -> premise -> bool

val eq_opt : ('a -> 'a -> bool) -> 'a option -> 'a option -> bool
val eq_list : ('a -> 'a -> bool) -> 'a list -> 'a list -> bool
val eq_nl_list : ('a -> 'a -> bool) -> 'a nl_list -> 'a nl_list -> bool
