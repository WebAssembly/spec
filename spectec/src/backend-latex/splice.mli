type env

val env : Config.t -> El.Ast.script -> env

val splice_string : env -> string -> string -> string (* raise Source.Error *)
val splice_file : env -> string -> unit (* raise Source.Error *)
