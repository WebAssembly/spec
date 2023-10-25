open Ast

val string_of_opt : string -> ('a -> string) -> string -> 'a option -> string
val string_of_list : ('a -> string) -> string -> string -> string -> 'a list -> string
val string_of_kwd : kwd -> string
val string_of_value : value -> string
val string_of_iter : iter -> string
val string_of_iters : iter list -> string
val string_of_expr : expr -> string
val string_of_cond : cond -> string
val string_of_instr : int ref -> int -> instr -> string
val string_of_instrs : int -> instr list -> string
val string_of_algorithm : algorithm -> string

val structured_string_of_value : value -> string
val structured_string_of_iter : iter -> string
val structured_string_of_expr : expr -> string
val structured_string_of_cond : cond -> string
val structured_string_of_instr : int -> instr -> string
val structured_string_of_algorithm : algorithm -> string
