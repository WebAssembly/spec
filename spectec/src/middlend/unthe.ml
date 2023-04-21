(*
This transformation removes use of the ! operator from relations, by
introducing fresh variables.

An occurrence of !(e) will be replaced with a fresh variable x of the suitable
type (and dimension), and a new condition e = ?(x) is added.

This is an alternative to to how the Sideconditions pass handles the ! operator.
If you need both, passes, run this one first.
*)

open Il.Ast

(* Errors *)
let transform (defs : script) = defs

