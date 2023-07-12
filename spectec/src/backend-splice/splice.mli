type env

val env : Backend_latex.Config.t -> El.Ast.script -> Il.Ast.script -> Al.Ast.algorithm list -> env

val gen_macro : env -> unit

val splice_string : env -> string -> string -> string (* raise Source.Error *)
val splice_file : env -> string -> string -> unit (* raise Source.Error *)

val warn : env -> unit
