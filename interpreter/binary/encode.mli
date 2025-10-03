exception Code of Source.region * string

val version : int32
val encode : Ast.module_ -> string
val encode_with_custom : Ast.module_ * Custom.section list -> string
