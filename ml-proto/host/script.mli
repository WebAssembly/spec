type var = string Source.phrase

type definition = definition' Source.phrase
and definition' =
  | Textual of Ast.module_
  | Binary of string

type action = action' Source.phrase
and action' =
  | Invoke of var option * string * Ast.literal list
  | Get of var option * string

type command = command' Source.phrase
and command' =
  | Define of var option * definition
  | Register of string * var option
  | Action of action
  | AssertInvalid of definition * string
  | AssertUnlinkable of definition * string
  | AssertReturn of action * Ast.literal list
  | AssertReturnNaN of action
  | AssertTrap of action * string
  | Input of string
  | Output of var option * string option

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
