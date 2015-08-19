(*
 * (c) 2015 Andreas Rossberg
 *)

type command = command' Source.phrase
and command' =
  | Define of Ast.modul
  | Invoke of string * Ast.expr list
  | AssertEqInvoke of string * Ast.expr list * Ast.expr list

type script = command list

val run : script -> unit
