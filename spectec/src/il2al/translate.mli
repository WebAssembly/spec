val name_of_rule : Il.Ast.rule -> string
val translate_exp : Il.Ast.exp -> Al.Ast.expr
val translate_argexp : Il.Ast.exp -> Al.Ast.expr list
val translate : Il.Ast.script -> Al.Ast.algorithm list
