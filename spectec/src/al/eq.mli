open Ast

val eq_expr : expr -> expr -> bool
val eq_exprs : expr list -> expr list -> bool

val eq_path : path -> path -> bool
val eq_paths : path list -> path list -> bool

val eq_instr : instr -> instr -> bool
val eq_instrs : instr list -> instr list -> bool
