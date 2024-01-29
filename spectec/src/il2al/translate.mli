val name_of_rule : Il.Ast.rule -> string
val name2kwd : string -> Il.Ast.typ -> string * string
val get_params : Il.Ast.exp -> Il.Ast.exp list
val exp2expr : Il.Ast.exp -> Al.Ast.expr
val exp2args : Il.Ast.exp -> Al.Ast.expr list
val translate : Il.Ast.script -> Al.Ast.algorithm list
