open Ast

module Set : Set.S with type elt = string with type t = Set.Make(String).t

type sets =
  { typid : Set.t;
    gramid : Set.t;
    relid : Set.t;
    varid : Set.t;
    defid : Set.t;
  }

val empty : sets
val union : sets -> sets -> sets
val inter : sets -> sets -> sets
val diff : sets -> sets -> sets

val free_list : ('a -> sets) -> 'a list -> sets
val free_nl_list : ('a -> sets) -> 'a nl_list -> sets

val free_iter : iter -> sets
val free_typ : typ -> sets
val free_typfield : typfield -> sets
val free_typcase : typcase -> sets
val free_typcon : typcon -> sets
val free_exp : exp -> sets
val free_path : path -> sets
val free_arg : arg -> sets
val free_args : arg list -> sets
val free_prem : prem -> sets
val free_prems : prem nl_list -> sets
val free_params : param list -> sets
val free_prod : prod -> sets
val free_def : def -> sets

(* A free variable is "determinate" if:
   - it occurs as an iteration variable
   - it occurs in destructuring position on the lhs
   - it occurs in destructuring position on either side of an equational premise
   - it occurs in destructuring position as an indexing operand
   - it occurs in destructuring position as the last call arg
     (this case is to handle function inverses)
  This is a pragmatic criterium, intended only for sanity checks.
*)
val det_exp : exp -> sets
val det_sym : sym -> sets
val det_prems : prem nl_list -> sets
val det_prod : prod -> sets
val det_def : def -> sets

val bound_params : param list -> sets
