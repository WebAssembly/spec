open Al.Ast

(* Set module with string elements *)

module Set : Set.S with type elt = String.t

(* Map module with string keys *)

module Map : Map.S with type key = String.t


(* Environment *)

type env

val env : El.Ast.script -> env

val atoms : env -> (Set.t * Set.t) Map.t
val funcs : env -> Set.t


(* Lookups *)

val narrow_atom : env -> atom -> (string * string) option

val find_func : env -> id -> bool
