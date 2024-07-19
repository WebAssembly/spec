open Ast

module IdSet : Set.S with type elt = string

val free_list : ('a -> IdSet.t) -> 'a list -> IdSet.t
val free_expr : expr -> IdSet.t
val free_instr : instr -> IdSet.t
