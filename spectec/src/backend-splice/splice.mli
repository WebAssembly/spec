type env

val env : Config.config -> string list -> string list -> El.Ast.script -> Backend_prose.Prose.prose -> env

val splice_string : env -> string -> string -> string (* raise Source.Error *)
val splice_file : env -> string -> string -> unit (* raise Source.Error *)

val warn : env -> unit
