open Al.Ast

val error_typ_value : string -> string -> value -> 'a
val error_values : string -> value list -> 'a

val call_numerics : string -> value list -> value
val mem : string -> bool
