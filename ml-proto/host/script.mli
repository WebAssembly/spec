(*
 * (c) 2015 Andreas Rossberg
 *)

type command = command' Source.phrase
and command' =
  | Define of Ast.module_
  | AssertInvalid of Ast.module_ * string
  | Invoke of string * Ast.expr list
  | AssertSame of string * Ast.expr list * Ast.expr
  | AssertNaN of string * Ast.expr list
  | AssertTrap of string * Ast.expr list * string

type script = command list

val run : script -> unit (* raises Error.Error *)
val trace : string -> unit
