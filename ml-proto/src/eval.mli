(*
 * (c) 2015 Andreas Rossberg
 *)

type module_instance
type value = Values.value

val init : Ast.modul -> module_instance
val invoke : module_instance -> int -> value list -> value list
  (* raise Error.Error *)
val eval : Ast.expr -> value (* raise Error.Error *)
