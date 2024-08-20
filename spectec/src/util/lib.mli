(* Things that should be in the OCaml library... *)

module List :
sig
  val take : int -> 'a list -> 'a list (* raises Failure *)
  val drop : int -> 'a list -> 'a list (* raises Failure *)
  val split : int -> 'a list -> 'a list * 'a list (* raises Failure *)
  val split_hd : 'a list -> 'a * 'a list (* raises Failure *)
  val split_last_opt : 'a list -> ('a list * 'a) option
  val split_last : 'a list -> 'a list * 'a (* raises Failure *)
  val last_opt : 'a list -> 'a option
  val last : 'a list -> 'a (* raises Failure *)
  val nub : ('a -> 'a -> bool) -> 'a list -> 'a list
  val filter_not : ('a -> bool) -> 'a list -> 'a list
  val assoc_map : ('a -> 'b) -> ('k * 'a) list -> ('k * 'b) list
end

module Char :
sig
  val is_digit_ascii : char -> bool
  val is_uppercase_ascii : char -> bool
  val is_lowercase_ascii : char -> bool
  val is_letter_ascii : char -> bool
end

module String :
sig
  val implode : char list -> string
  val explode : string -> char list
end
