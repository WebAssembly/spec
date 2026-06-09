open Ast

val eq_id : id -> id -> bool
val eq_atom : atom -> atom -> bool
val eq_mixop : mixop -> mixop -> bool
val eq_iter : iter -> iter -> bool
val eq_iterexp : iterexp -> iterexp -> bool
val eq_typ : typ -> typ -> bool
val eq_deftyp : deftyp -> deftyp -> bool
val eq_exp : exp -> exp -> bool
val eq_path : path -> path -> bool
val eq_sym : sym -> sym -> bool
val eq_prem : prem -> prem -> bool
val eq_arg : arg -> arg -> bool
val eq_param : param -> param -> bool

val eq_opt : ('a -> 'a -> bool) -> 'a option -> 'a option -> bool
val eq_list : ('a -> 'a -> bool) -> 'a list -> 'a list -> bool

val compare_id : id -> id -> int
val compare_atom : atom -> atom -> int
val compare_mixop : mixop -> mixop -> int
val compare_iter : iter -> iter -> int
val compare_iterexp : iterexp -> iterexp -> int
val compare_typ : typ -> typ -> int
val compare_exp : exp -> exp -> int
val compare_path : path -> path -> int
val compare_sym : sym -> sym -> int
val compare_arg : arg -> arg -> int
