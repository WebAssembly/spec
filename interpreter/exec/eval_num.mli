open Value

val eval_unop : Ast.unop -> num -> num
val eval_binop : Ast.binop -> num -> num -> num
val eval_testop : Ast.testop -> num -> bool
val eval_relop : Ast.relop -> num -> num -> bool
val eval_cvtop : Ast.cvtop -> num -> num
