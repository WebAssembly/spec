open Al.Ast

(* Environment *)

type env

val env : string list -> string list -> env


(* Lookups *)

val find_section : env -> string -> bool


(* Macro Generation *)

val macro_kwd : env -> kwd -> string * string
val macro_func : env -> id -> string * string
val gen_macro : env -> Symbol.env -> unit
