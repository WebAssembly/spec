open Il.Ast

type rgroup = (exp * exp * (premise list)) list

val transform_expr : (exp -> exp) -> exp -> exp
val is_unified_id : string -> bool

val unify_lhs : string * rgroup -> string * rgroup
val unify_defs : clause list -> clause list
