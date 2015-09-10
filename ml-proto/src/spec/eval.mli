(*
 * (c) 2015 Andreas Rossberg
 *)

type instance
type value = Values.value

val init : Ast.modul -> instance
val invoke : instance -> string -> value list -> value list
  (* raise Error.Error *)
val eval : Ast.expr -> value (* raise Error.Error *)
