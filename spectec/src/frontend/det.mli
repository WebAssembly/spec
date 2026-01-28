open Il.Ast

include module type of Xl.Gen_free

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
val det_prem : prem -> sets
val det_arg : arg -> sets

val det_list : ('a -> sets) -> 'a list -> sets
