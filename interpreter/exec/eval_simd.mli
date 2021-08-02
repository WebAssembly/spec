open Values

val eval_testop : Ast.simd_testop -> simd -> bool
val eval_unop : Ast.simd_unop -> simd -> simd
val eval_binop : Ast.simd_binop -> simd -> simd -> simd
val eval_vtestop : Ast.simd_vtestop -> simd -> bool
val eval_vunop : Ast.simd_vunop -> simd -> simd
val eval_vbinop : Ast.simd_vbinop -> simd -> simd -> simd
val eval_vternop : Ast.simd_vternop -> simd -> simd -> simd -> simd
val eval_shiftop : Ast.simd_shiftop -> simd -> num -> simd
val eval_bitmaskop : Ast.simd_bitmaskop -> simd -> num
val eval_cvtop : Ast.simd_cvtop -> num -> simd
val eval_extractop : Ast.simd_extractop -> simd -> num
val eval_replaceop : Ast.simd_replaceop -> simd -> num -> simd
