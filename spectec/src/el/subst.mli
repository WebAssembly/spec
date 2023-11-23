open Ast

module Map : Map.S with type key = string

type subst =
  { varid : exp Map.t;
    synid : typ Map.t;
    gramid : sym Map.t;
  }

val empty : subst

val subst_list : (subst -> 'a -> 'a) -> subst -> 'a list -> 'a list
val subst_nl_list : (subst -> 'a -> 'a) -> subst -> 'a nl_list -> 'a nl_list

val subst_iter : subst -> iter -> iter
val subst_typ : subst -> typ -> typ
val subst_exp : subst -> exp -> exp
val subst_path : subst -> path -> path
val subst_prem : subst -> premise -> premise
val subst_arg : subst -> arg -> arg
val subst_param : subst -> param -> param
