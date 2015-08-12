(*
 * (c) 2015 Andreas Rossberg
 *)

exception Error of Source.region * string

val warn : Source.region -> string -> unit
val error : Source.region -> string -> 'a  (* raises Error *)
