open Ast

val string_of_list : ('a -> string) -> string -> 'a list -> string
val string_of_atom : atom -> string 
val string_of_value : value -> string
val string_of_values : string -> value list -> string
val string_of_iter : iter -> string
val string_of_iters : iter list -> string
val string_of_expr : expr -> string
val string_of_path : path -> string
val string_of_instr : instr -> string
val string_of_instrs : instr list -> string
val string_of_algorithm : algorithm -> string

val structured_string_of_value : value -> string
val structured_string_of_iter : iter -> string
val structured_string_of_expr : expr -> string
val structured_string_of_path : path -> string
val structured_string_of_instr : instr -> string
val structured_string_of_instrs : instr list -> string
val structured_string_of_algorithm : algorithm -> string
