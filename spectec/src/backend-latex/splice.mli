type env

val env : Config.t -> El.Ast.script -> env

val splice_string : env -> string -> string -> string (* raise Source.Error *)
val splice_file : ?dry:bool -> env -> string -> unit (* raise Source.Error *)

val warn : env -> unit
