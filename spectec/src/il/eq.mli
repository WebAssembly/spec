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

val eq_opt : ('a -> 'a -> bool) -> 'a option -> 'a option -> bool
val eq_list : ('a -> 'a -> bool) -> 'a list -> 'a list -> bool
