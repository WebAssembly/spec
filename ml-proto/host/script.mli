(*
 * (c) 2015 Andreas Rossberg
 *)

type command = command' Source.phrase
and command' =
  | Define of Kernel.module_
  | Invoke of string * Kernel.literal list
  | AssertInvalid of Kernel.module_ * string
  | AssertReturn of string * Kernel.literal list * Kernel.literal option
  | AssertReturnNaN of string * Kernel.literal list
  | AssertTrap of string * Kernel.literal list * string

type script = command list

exception Syntax of Source.region * string
exception AssertFailure of Source.region * string

val run : script -> unit
  (* raises Check.Invalid, Eval.Trap, Eval.Crash, Failure *)

val trace : string -> unit
