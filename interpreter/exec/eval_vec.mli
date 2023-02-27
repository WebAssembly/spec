open Values

val eval_testop : Ast.vec_testop -> vec -> bool
val eval_unop : Ast.vec_unop -> vec -> vec
val eval_binop : Ast.vec_binop -> vec -> vec -> vec
val eval_ternop : Ast.vec_ternop -> vec -> vec -> vec -> vec
val eval_relop : Ast.vec_relop -> vec -> vec -> vec
val eval_cvtop : Ast.vec_cvtop -> vec -> vec
val eval_shiftop : Ast.vec_shiftop -> vec -> num -> vec
val eval_bitmaskop : Ast.vec_bitmaskop -> vec -> num
val eval_vtestop : Ast.vec_vtestop -> vec -> bool
val eval_vunop : Ast.vec_vunop -> vec -> vec
val eval_vbinop : Ast.vec_vbinop -> vec -> vec -> vec
val eval_vternop : Ast.vec_vternop -> vec -> vec -> vec -> vec
val eval_splatop : Ast.vec_splatop -> num -> vec
val eval_extractop : Ast.vec_extractop -> vec -> num
val eval_replaceop : Ast.vec_replaceop -> vec -> num -> vec
