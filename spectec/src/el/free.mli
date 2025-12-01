open Ast

include module type of Xl.Gen_free

val free_nl_elem : ('a -> sets) -> 'a nl_elem -> sets
val free_nl_list : ('a -> sets) -> 'a nl_list -> sets

val free_iter : iter -> sets
val free_typ : typ -> sets
val free_typfield : typfield -> sets
val free_typcase : typcase -> sets
val free_typcon : typcon -> sets
val free_exp : exp -> sets
val free_path : path -> sets
val free_arg : arg -> sets
val free_prem : prem -> sets
val free_param : param -> sets
val free_prod : prod -> sets
val free_def : def -> sets

val free_prems : prem nl_list -> sets
val free_args : arg list -> sets
val free_params : param list -> sets

(* A free variable is "determinate" if:
   - it occurs as an iteration variable
   - it occurs in destructuring position on the lhs
   - it occurs in destructuring position on either side of an equational premise
   - it occurs in destructuring position as an indexing operand
   - it occurs in destructuring position as the last call arg
     (this case is to handle function inverses)
  This is a pragmatic criterium, intended only for sanity checks.
*)
val det_typ : typ -> sets
val det_exp : exp -> sets
val det_sym : sym -> sets
val det_prems : prem nl_list -> sets
val det_prod : prod -> sets
val det_def : def -> sets

val bound_params : param list -> sets
