type env

val env : Config.config -> string list -> string list -> Frontend.Elab.env -> El.Ast.script -> Backend_prose.Prose.prose -> env

val splice_string : env -> string -> string -> string (* raise Source.Error *)
val splice_file : ?dry:bool -> env -> string -> string -> unit (* raise Source.Error *)

val warn_math : env -> unit
val warn_prose : env -> unit
