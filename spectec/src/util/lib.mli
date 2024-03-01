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
end

module String :
sig
  val implode : char list -> string
  val explode : string -> char list
end
