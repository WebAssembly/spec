open Ast

val string_of_atom : atom -> string
val string_of_unop : unop -> string
val string_of_binop : binop -> string
val string_of_cmpop : cmpop -> string
val string_of_mixop : mixop -> string
val string_of_iter : iter -> string
val string_of_typ : typ -> string
val string_of_exp : exp -> string
val string_of_path : path -> string
val string_of_prem : premise -> string
val string_of_arg : arg -> string
val string_of_param : param -> string
val string_of_def : def -> string
val string_of_rule : rule -> string
val string_of_instance : id -> instance -> string
val string_of_clause : id -> clause -> string
val string_of_deftyp : deftyp -> string
val string_of_script : script -> string
