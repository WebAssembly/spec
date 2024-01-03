open Ast

val string_of_atom : atom -> string
val string_of_unop : unop -> string
val string_of_binop : binop -> string
val string_of_cmpop : cmpop -> string
val string_of_iter : iter -> string
val string_of_typ : typ -> string
val string_of_exp : exp -> string
val string_of_exps : string -> exp list -> string
val string_of_prem : premise -> string
val string_of_def : def -> string
val string_of_script : script -> string
