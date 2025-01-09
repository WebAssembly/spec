open Al.Ast

val for_interp : bool ref
val insert_nop : instr list -> instr list
val merge_blocks : instr list list -> instr list
val push_either :instr -> instr list
val simplify_record_concat : expr -> expr
val enhance_readability : instr list -> instr list
val reduce_comp: expr -> expr
val flatten_if : instr list -> instr list
val remove_state : algorithm -> algorithm
val insert_frame_binding : instr list -> instr list
val handle_frame : arg list -> instr list -> instr list
val remove_sub : expr -> expr
val infer_assert : instr list -> instr list
val ensure_return :  instr list -> instr list
val remove_exit : algorithm -> algorithm
val remove_enter : algorithm -> algorithm
