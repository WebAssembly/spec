open Ast

module IdSet : Set.S with type elt = string with type t = Set.Make(String).t

val free_list : ('a -> IdSet.t) -> 'a list -> IdSet.t
val free_expr : expr -> IdSet.t
val free_instr : instr -> IdSet.t
