open Ast

module Set : Set.S with type elt = string

val free_varid_exp : exp -> Set.t
val free_defid_exp : exp -> Set.t

val free_synid_typ : typ -> Set.t
val free_synid_deftyp : deftyp -> Set.t

val free_synid_def : def -> Set.t
val free_relid_def : def -> Set.t
val free_varid_def : def -> Set.t
val free_defid_def : def -> Set.t
