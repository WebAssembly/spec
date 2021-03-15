open Values

val unop : Ast.V128Op.unop -> num -> num
val binop : Ast.V128Op.binop -> num -> num -> num
val testop : Ast.V128Op.testop -> num -> bool
val relop : Ast.V128Op.relop -> num -> num -> bool
val cvtop : Ast.V128Op.cvtop -> num -> num

val eval_ternop : Ast.V128Op.ternop -> num -> num -> num -> num
val eval_shiftop : Ast.V128Op.shiftop -> num -> num -> num
val eval_bitmaskop : Simd.shape -> num -> num
val eval_extractop : Ast.V128Op.extractop -> num -> num
val eval_replaceop : Ast.V128Op.replaceop -> num -> num -> num
