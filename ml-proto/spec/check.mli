exception Invalid of Source.region * string

val check_module : Ast.module_ -> unit (* raise Invalid *)
