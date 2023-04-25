(* Things that should be in the OCaml library... *)

module List :
sig
  val split_hd : 'a list -> 'a * 'a list (* raises Failure *)
  val split_last : 'a list -> 'a list * 'a (* raises Failure *)
  val nub : ('a -> 'a -> bool) -> 'a list -> 'a list
end

module String :
sig
  val implode : char list -> string
  val explode : string -> char list
end
