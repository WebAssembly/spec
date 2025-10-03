val translate_exp : Il.Ast.exp -> Al.Ast.expr
val translate_argexp : Il.Ast.exp -> Al.Ast.expr list
val translate_args : Il.Ast.arg list -> Al.Ast.arg list
val translate : Il.Ast.script -> bool -> Al.Ast.algorithm list
