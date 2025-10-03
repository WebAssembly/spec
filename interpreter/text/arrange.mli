open Sexpr

val bytes : string -> string
val string : string -> string
val name : Ast.name -> string

val break_bytes : string -> sexpr list
val break_string : string -> sexpr list

val instr : Ast.instr -> sexpr
val func : Ast.func -> sexpr
val module_ : Ast.module_ -> sexpr
val module_with_custom : Ast.module_ * Custom.section list -> sexpr
val script : [`Textual | `Binary] -> Script.script -> sexpr list
