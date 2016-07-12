type definition = definition' Source.phrase
and definition' =
  | Textual of Ast.module_
  | Binary of string

type command = command' Source.phrase
and command' =
  | Define of definition
  | Invoke of string * Ast.literal list
  | AssertInvalid of definition * string
  | AssertReturn of string * Ast.literal list * Ast.literal list
  | AssertReturnNaN of string * Ast.literal list
  | AssertTrap of string * Ast.literal list * string
  | Input of string
  | Output of string option

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
val output_stdout : (Ast.module_ -> unit) ref
