open Il.Ast

type rgroup = (exp * exp * (prem list)) Util.Source.phrase list

val transform_expr : (exp -> exp) -> exp -> exp
val is_unified_id : string -> bool

val unify_rules : rule list -> rule list
val unify_lhs : string * id * rgroup -> string * id * rgroup
val unify_defs : clause list -> clause list
