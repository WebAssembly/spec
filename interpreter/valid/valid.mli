exception Invalid of Source.region * string

val check_module : Ast.module_ -> unit (* raises Invalid *)
val check_module_with_custom : Ast.module_ * Custom.section list -> unit (* raises Invalid, Custom.Check *)
