type 'm command = 'm command' Source.phrase
and 'm command' =
  | Define of 'm
  | Invoke of string * Kernel.literal list
  | AssertInvalid of 'm * string
  | AssertReturn of string * Kernel.literal list * Kernel.literal option
  | AssertReturnNaN of string * Kernel.literal list
  | AssertTrap of string * Kernel.literal list * string

type script = Ast.module_ command list
type script' = Kernel.module_ command list

val desugar : script -> script'

exception Syntax of Source.region * string
exception AssertFailure of Source.region * string

val run : script' -> unit
  (* raises Check.Invalid, Eval.Trap, Eval.Crash, Failure *)

val trace : string -> unit
