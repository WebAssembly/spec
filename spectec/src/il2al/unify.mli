open Il.Ast
open Def

type env

val rename : bool ref

val init_env : Free.sets -> env
val unify : script -> rule_def list * helper_def list
val unify_rules : env -> rule list -> rule list
