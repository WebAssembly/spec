open El.Ast


(* Environment *)

type env

val env : Config.t -> El.Ast.script -> env
val env_with_config : env -> Config.t -> env
val config : env -> Config.t

val with_syntax_decoration : bool -> env -> env
val with_grammar_decoration : bool -> env -> env
val with_rule_decoration : bool -> env -> env
val without_macros : bool -> env -> env


(* Generators *)

val render_atom : env -> atom -> string
val render_typ : env -> typ -> string
val render_exp : env -> exp -> string
val render_sym : env -> sym -> string
val render_arg : env -> arg -> string
val render_def : env -> def -> string
val render_defs : env -> def list -> string
val render_script : env -> script -> string
