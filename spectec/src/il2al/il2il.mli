open Il.Ast

type rgroup = (exp * exp * (prem list)) Util.Source.phrase list

val unify_rules : rule list -> rule list
val unify_pop_and_winstr : rgroup -> rgroup
val unify_ctxt : string list -> rgroup -> rgroup
val unify_defs : clause list -> clause list
