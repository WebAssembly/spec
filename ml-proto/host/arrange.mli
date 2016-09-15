open Sexpr

val func_type : Types.func_type -> sexpr

val instr : Ast.instr -> sexpr
val module_ : Ast.module_ -> sexpr
val script : [`Textual | `Binary] -> Script.script -> sexpr list
