open Value

val eval_vtestop : Ast.vtestop -> vec -> bool
val eval_vunop : Ast.vunop -> vec -> vec
val eval_vbinop : Ast.vbinop -> vec -> vec -> vec
val eval_vternop : Ast.vternop -> vec -> vec -> vec -> vec
val eval_vrelop : Ast.vrelop -> vec -> vec -> vec
val eval_vcvtop : Ast.vcvtop -> vec -> vec
val eval_vshiftop : Ast.vshiftop -> vec -> num -> vec
val eval_vbitmaskop : Ast.vbitmaskop -> vec -> num
val eval_vvtestop : Ast.vvtestop -> vec -> bool
val eval_vvunop : Ast.vvunop -> vec -> vec
val eval_vvbinop : Ast.vvbinop -> vec -> vec -> vec
val eval_vvternop : Ast.vvternop -> vec -> vec -> vec -> vec
val eval_vsplatop : Ast.vsplatop -> num -> vec
val eval_vextractop : Ast.vextractop -> vec -> num
val eval_vreplaceop : Ast.vreplaceop -> vec -> num -> vec
