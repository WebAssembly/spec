open Ast

module Map : Map.S with type key = string with type 'a t = 'a Map.Make(String).t

type subst =
  { varid : exp Map.t;
    typid : typ Map.t;
    gramid : sym Map.t;
    defid : id Map.t;
  }
type t = subst

val empty : subst
val union : subst -> subst -> subst (* right overrides *)

val add_varid : subst -> id -> exp -> subst
val add_typid : subst -> id -> typ -> subst
val add_gramid : subst -> id -> sym -> subst
val add_defid : subst -> id -> id -> subst

val mem_varid : subst -> id -> bool
val mem_typid : subst -> id -> bool
val mem_gramid : subst -> id -> bool
val mem_defid : subst -> id -> bool

val subst_iter : subst -> iter -> iter
val subst_typ : subst -> typ -> typ
val subst_exp : subst -> exp -> exp
val subst_path : subst -> path -> path
val subst_prem : subst -> prem -> prem
val subst_sym : subst -> sym -> sym
val subst_arg : subst -> arg -> arg
val subst_param : subst -> param -> param

val subst_list : (subst -> 'a -> 'a) -> subst -> 'a list -> 'a list
val subst_nl_list : (subst -> 'a -> 'a) -> subst -> 'a nl_list -> 'a nl_list
