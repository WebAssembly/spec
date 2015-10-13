(*
 * (c) 2015 Andreas Rossberg
 *)

type command = command' Source.phrase
and command' =
  | Define of Ast.module_
  | Invoke of string * Ast.literal list
  | AssertInvalid of Ast.module_ * string
  | AssertReturn of string * Ast.literal list * Ast.literal option
  | AssertReturnNaN of string * Ast.literal list
  | AssertTrap of string * Ast.literal list * string

type script = command list

val run : script -> unit (* raises Error.Error *)
val trace : string -> unit
