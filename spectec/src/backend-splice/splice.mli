type env

val env : Backend_latex.Config.t -> El.Ast.script -> env

val splice_string : env -> string -> string -> string (* raise Source.Error *)
val splice_file : env -> string -> string -> unit (* raise Source.Error *)

val warn : env -> unit
