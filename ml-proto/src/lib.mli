(*
 * (c) 2014 Andreas Rossberg
 *)

module List :
sig
  val take : int -> 'a list -> 'a list
  val drop : int -> 'a list -> 'a list

  val last : 'a list -> 'a (* raise Failure *)
  val split_last : 'a list -> 'a list * 'a (* raise Failure *)
end
