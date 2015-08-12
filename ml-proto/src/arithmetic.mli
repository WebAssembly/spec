(*
 * (c) 2015 Andreas Rossberg
 *)

open Types

exception TypeError of int * value * value_type

val eval_unop : Syntax.unop -> value -> value
val eval_binop : Syntax.binop -> value -> value -> value
val eval_relop : Syntax.relop -> value -> value -> bool
val eval_cvt : Syntax.cvt -> value -> value
