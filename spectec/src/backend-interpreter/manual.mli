open Al.Ast

type config = expr * expr * instr list

val manual_algos : algorithm list
val return_instrs_of_instantiate : config -> instr list
val return_instrs_of_invoke : config -> instr list
val ref_type_of : value list -> value
