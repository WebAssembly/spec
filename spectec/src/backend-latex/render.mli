open El.Ast


(* Environment *)

type env

val env : Config.t -> El.Ast.script -> env


(* Generators *)

val render_atom : env -> atom -> string
val render_typ : env -> typ -> string
val render_exp : env -> exp -> string
val render_def : env -> def -> string
val render_defs : env -> def list -> string
val render_deftyp : env -> deftyp -> string
val render_nottyp : env -> nottyp -> string
val render_script : env -> script -> string
