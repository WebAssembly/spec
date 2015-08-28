(*
 * (c) 2014 Andreas Rossberg
 *)

(* Things that should be in the OCaml library... *)

module List :
sig
  val take : int -> 'a list -> 'a list
  val drop : int -> 'a list -> 'a list

  val last : 'a list -> 'a (* raise Failure *)
  val split_last : 'a list -> 'a list * 'a (* raise Failure *)
end

module Option :
sig
  val map : ('a -> 'b) -> 'a option -> 'b option
  val app : ('a -> unit) -> 'a option -> unit
end

val is_power_of_two : int -> bool
