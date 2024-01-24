open Al.Ast

(* TODO: Define type config *)
val manual_algos : algorithm list
val return_instrs_of_instantiate : expr * expr * instr list -> instr list
val return_instrs_of_invoke : expr * expr * instr list -> instr list
