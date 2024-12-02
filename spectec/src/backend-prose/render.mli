open Prose


(* Environment *)

type env

val env : Config.config -> string list -> string list -> Backend_latex.Render.env -> env


(* Generators *)

val render_expr : env -> expr -> string
val render_instr : env -> Al.Ast.id -> int ref -> int -> Al.Ast.instr -> string
val render_stmt : env -> int -> stmt -> string
val render_def : env -> def -> string
val render_prose : env -> prose -> string
