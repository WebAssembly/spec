type env

val elab : El.Ast.script -> Il.Ast.script * env (* raises Error.Error *)
val elab_exp : env -> El.Ast.exp -> El.Ast.typ -> Il.Ast.exp (* raises Error.Error *)
val elab_rel : env -> El.Ast.exp -> El.Ast.id -> Il.Ast.exp (* raises Error.Error *)
