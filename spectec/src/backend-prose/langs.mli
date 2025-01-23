module Map : Map.S with type key = string

val el : El.Ast.script ref
val validation_il : Il.Ast.script ref
val il : Il.Ast.script ref
val al : Al.Ast.script ref
val rel_hints: Il.Ast.hint list Map.t ref
