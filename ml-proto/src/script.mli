(*
 * (c) 2015 Andreas Rossberg
 *)

type command = command' Source.phrase
and command' =
  | Define of Syntax.modul
  | Invoke of int * Syntax.expr list

type script = command list

val run : script -> unit
