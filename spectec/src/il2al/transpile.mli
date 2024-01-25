open Al.Ast

val merge : instr list -> instr list -> instr list
val push_either :instr -> instr list
val simplify_record_concat : expr -> expr
val enhance_readability : instr list -> instr list
val remove_state : algorithm -> algorithm
val infer_assert : instr list -> instr list
val enforce_return :  instr list -> instr list
