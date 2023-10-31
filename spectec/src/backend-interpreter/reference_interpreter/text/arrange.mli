open Sexpr

val instr : Ast.instr -> sexpr
val func : Ast.func -> sexpr
val module_ : Ast.module_ -> sexpr
val script : [`Textual | `Binary] -> Script.script -> sexpr list
