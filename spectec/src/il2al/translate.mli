val translate_exp : Il.Ast.exp -> Al.Ast.expr
val translate_argexp : Il.Ast.exp -> Al.Ast.expr list
val translate : Il.Ast.script -> bool -> Al.Ast.algorithm list