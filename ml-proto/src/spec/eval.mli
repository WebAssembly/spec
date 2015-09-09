(*
 * (c) 2015 Andreas Rossberg
 *)

type instance
type value = Values.value
type expr_value = value option

val init : Ast.modul -> instance
val invoke : instance -> string -> value list -> expr_value
  (* raise Error.Error *)
val eval : Ast.expr -> expr_value (* raise Error.Error *)
