open Il.Ast

type reduction_group = (exp * exp * (prem list)) list

val transform_expr : (exp -> exp) -> exp -> exp
val is_unified_id : string -> bool

val unify_lhs : string * reduction_group -> string * reduction_group
val unify_defs : clause list -> clause list
