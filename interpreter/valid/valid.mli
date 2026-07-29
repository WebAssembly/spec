exception Invalid of Source.region * string

val check_module : Ast.module_ -> Types.moduletype (* raises Invalid *)
val check_module_with_custom : Ast.module_ * Custom.section list -> Types.moduletype (* raises Invalid, Custom.Check *)
