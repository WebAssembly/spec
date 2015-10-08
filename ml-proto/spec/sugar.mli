open Ast

val labelled_block : Source.region -> expr list -> expr'
val if_only : expr * expr -> expr'
val loop_seq : Source.region -> expr list -> expr'
val labelled_loop_seq : Source.region -> expr list -> expr'
val labelled_loop_seq2 : Source.region -> expr list -> expr'
val labelled_switch :
  Source.region -> value_type * expr * arm list * expr -> expr'

val case_seq : Ast.literal * Ast.expr list * bool -> Ast.arm'
val case_only : Ast.literal -> Ast.arm'

val func_body : Ast.expr list -> Ast.expr'

