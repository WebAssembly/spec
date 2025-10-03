exception Code of Source.region * string

val decode : string -> string -> Ast.module_ (* raises Code *)
val decode_with_custom : string -> string -> Ast.module_ * Custom.section list (* raises Code *)
