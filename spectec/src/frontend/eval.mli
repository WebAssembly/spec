open El.Ast

module Map : Map.S with type key = string with type 'a t = 'a Map.Make(String).t

type typ_def = (arg list * typ) list
type def_def = (arg list * exp * prem list) list
type gram_def = unit
type env = {vars : typ Map.t; typs : typ_def Map.t; defs : def_def Map.t; grams : gram_def Map.t}
type subst = El.Subst.t

val (let*) : subst option -> (subst -> subst option) -> subst option

val reduce_exp : env -> exp -> exp
val reduce_typ : env -> typ -> typ
val reduce_arg : env -> arg -> arg

val equiv_functyp : env -> param list * typ -> param list * typ -> bool
val equiv_typ : env -> typ -> typ -> bool
val sub_typ : env -> typ -> typ -> bool
val narrow_typ : env -> typ -> typ -> bool

val match_iter : env -> subst -> iter -> iter -> subst option
val match_exp : env -> subst -> exp -> exp -> subst option
val match_typ : env -> subst -> typ -> typ -> subst option
val match_arg : env -> subst -> arg -> arg -> subst option

val match_list :
  (env -> subst -> 'a -> 'a -> subst option) ->
  env -> subst -> 'a list -> 'a list -> subst option
