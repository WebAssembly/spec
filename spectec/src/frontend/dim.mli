open Il.Ast

module Env : Map.S with type key = string

type outer = id list
type env = iter list Env.t

val annot_varid : id -> iter list -> id

val check_def : def -> env (* raises Error.Error *)
val check_inst : outer -> arg list -> deftyp -> env (* raises Error.Error *)
val check_prod : outer -> sym -> exp -> prem list -> env (* raises Error.Error *)
val check_abbr : outer -> sym -> sym -> prem list -> env (* raises Error.Error *)
val check_deftyp : outer -> typ list -> prem list -> env (* raises Error.Error *)

val annot_iter : env -> iter -> iter
val annot_exp : env -> exp -> exp
val annot_sym : env -> sym -> sym
val annot_arg : env -> arg -> arg
val annot_prem : env -> prem -> prem
val annot_inst : env -> inst -> inst
