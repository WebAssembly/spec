open Values

exception TypeError of int * value * Types.value_type

val eval_unop : Kernel.unop -> value -> value
val eval_binop : Kernel.binop -> value -> value -> value
val eval_relop : Kernel.relop -> value -> value -> bool
val eval_cvt : Kernel.cvt -> value -> value
