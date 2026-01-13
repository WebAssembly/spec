open Il.Ast

module Map : module type of Map.Make(String)

type dims = (Util.Source.region * iter list) Map.t
type outer = dims

val annot_varid : id -> iter list -> id

val check :
  outer ->
  param list -> arg list -> typ list -> exp list -> sym list -> prem list ->
  dims (* raises Error.Error *)

val annot_iter : dims -> iter -> iter
val annot_typ : dims -> typ -> typ
val annot_exp : dims -> exp -> exp
val annot_sym : dims -> sym -> sym
val annot_prem : dims -> prem -> prem
val annot_arg : dims -> arg -> arg
val annot_param : dims -> param -> param
