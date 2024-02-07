val name_of_rule : Il.Ast.rule -> string
val kwd : string -> Il.Ast.typ -> string * string
val get_params : Il.Ast.exp -> Il.Ast.exp list
val translate_expr : Il.Ast.exp -> Al.Ast.expr
val translate_args : Il.Ast.exp -> Al.Ast.expr list
val translate : Il.Ast.script -> Al.Ast.algorithm list
