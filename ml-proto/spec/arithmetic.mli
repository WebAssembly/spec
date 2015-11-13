open Values

exception TypeError of int * value * Types.value_type

val eval_unop : Ast.unop -> value -> value
val eval_binop : Ast.binop -> value -> value -> value
val eval_relop : Ast.relop -> value -> value -> bool
val eval_cvt : Ast.cvt -> value -> value
