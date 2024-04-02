(* Environment *)

type env

val env : string list -> string list -> env


(* Lookups *)

val find_section : env -> string -> bool
