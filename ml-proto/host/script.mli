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

exception Syntax of Source.region * string
exception AssertFailure of Source.region * string

val run : script -> unit
  (* raises Check.Invalid, Eval.Trap, Eval.Crash, Failure *)

val trace : string -> unit
