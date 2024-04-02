open Al.Ast

val merge_blocks : instr list list -> instr list
val push_either :instr -> instr list
val simplify_record_concat : expr -> expr
val enhance_readability : instr list -> instr list
val flatten_if : instr list -> instr list
val remove_state : algorithm -> algorithm
val insert_state_binding : algorithm -> algorithm
val remove_sub : expr -> expr
val infer_assert : instr list -> instr list
val ensure_return :  instr list -> instr list
val exit_to_pop : algorithm -> algorithm
