open Ast

val fresh_typid : string -> string
val fresh_varid : string -> string
val fresh_defid : string -> string
val fresh_gramid : string -> string

val refresh_typid : id -> id
val refresh_varid : id -> id
val refresh_defid : id -> id
val refresh_gramid : id -> id

val refresh_quants : quant list -> quant list * Subst.t
