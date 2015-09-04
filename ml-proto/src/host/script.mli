(*
 * (c) 2015 Andreas Rossberg
 *)

type command = command' Source.phrase
and command' =
  | Define of Ast.modul
  | AssertInvalid of Ast.modul * string
  | Invoke of string * Ast.expr list
  | AssertEq of string * Ast.expr list * Ast.expr list

type script = command list

val run : script -> unit (* raises Error.Error *)
val trace : string -> unit
