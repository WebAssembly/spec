open Ast

include module type of Xl.Gen_free

val free_iter : iter -> sets
val free_typ : typ -> sets
val free_exp : exp -> sets
val free_path : path -> sets
val free_prem : prem -> sets
val free_arg : arg -> sets
val free_def : def -> sets
val free_rule : rule -> sets
val free_clause : clause -> sets
val free_prod : prod -> sets
val free_deftyp : deftyp -> sets
val free_quant : quant -> sets
val free_param : param -> sets

val free_prems : prem list -> sets
val free_args : arg list -> sets
val free_quants : param list -> sets
val free_params : param list -> sets

val bound_quant : quant -> sets
val bound_param : param -> sets
val bound_def : def -> sets

val bound_quants : quant list -> sets
val bound_params : param list -> sets
