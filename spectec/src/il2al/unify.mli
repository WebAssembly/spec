open Il.Ast
open Def

type env

val init_env : unit -> env
val unify : script -> rule_def list * helper_def list
val unify_rules : env -> rule list -> rule list
