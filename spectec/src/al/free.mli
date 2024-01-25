open Ast

module IdSet : Set.S with type elt = string

val intersection : id list -> id list -> id list

val free_expr : expr -> id list
val free_instr : instr -> id list
