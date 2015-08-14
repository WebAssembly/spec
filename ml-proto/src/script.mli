(*
 * (c) 2015 Andreas Rossberg
 *)

type command = command' Source.phrase
and command' =
  | Define of Ast.modul
  | Invoke of int * Ast.expr list

type script = command list

val run : script -> unit
