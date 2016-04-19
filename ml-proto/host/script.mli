type command = command' Source.phrase
and command' =
  | Define of Ast.module_
  | Invoke of string * Kernel.literal list
  | AssertInvalid of Ast.module_ * string
  | AssertReturn of string * Kernel.literal list * Kernel.literal option
  | AssertReturnNaN of string * Kernel.literal list
  | AssertTrap of string * Kernel.literal list * string
  | Input of string
  | Output of string

type script = command list

exception Abort of Source.region * string
exception Syntax of Source.region * string
exception Assert of Source.region * string
exception IO of Source.region * string

val run : script -> unit
  (* raises Check.Invalid, Eval.Trap, Eval.Crash, Assert, IO *)

val trace : string -> unit

val input_file : (string -> bool) ref
val output_file : (string -> Ast.module_ -> unit) ref
