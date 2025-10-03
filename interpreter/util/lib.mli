(* Things that should be in the OCaml library... *)

type void = |

module Fun :
sig
  val id : 'a -> 'a
  val flip : ('a -> 'b -> 'c) -> ('b -> 'a -> 'c)
  val curry : ('a * 'b -> 'c) -> ('a -> 'b -> 'c)
  val uncurry : ('a -> 'b -> 'c) -> ('a * 'b -> 'c)

  val repeat : int -> ('a -> 'a) -> 'a -> 'a
end

module List :
sig
  val make : int -> 'a -> 'a list
  val take : int -> 'a list -> 'a list (* raises Failure *)
  val drop : int -> 'a list -> 'a list (* raises Failure *)
  val split : int -> 'a list -> 'a list * 'a list (* raises Failure *)

  val lead : 'a list -> 'a list (* raises Failure *)
  val last : 'a list -> 'a (* raises Failure *)
  val split_last : 'a list -> 'a list * 'a (* raises Failure *)

  val index_of : 'a -> 'a list -> int option
  val index_where : ('a -> bool) -> 'a list -> int option

  val map3 : ('a -> 'b -> 'c -> 'd) -> 'a list -> 'b list -> 'c list -> 'd list
  val map_pairwise : ('a -> 'a -> 'b) -> 'a list -> 'b list
end

module List32 :
sig
  val init : int32 -> (int32 -> 'a) -> 'a list
  val make : int32 -> 'a -> 'a list
  val length : 'a list -> int32
  val nth : 'a list -> int32 -> 'a (* raises Failure *)
  val replace : 'a list -> int32 -> 'a -> 'a list (* raises Failure *)
  val take : int32 -> 'a list -> 'a list (* raises Failure *)
  val drop : int32 -> 'a list -> 'a list (* raises Failure *)
  val iteri : (int32 -> 'a -> unit) -> 'a list -> unit
  val mapi : (int32 -> 'a -> 'b) -> 'a list -> 'b list

  val index_of : 'a -> 'a list -> int32 option
  val index_where : ('a -> bool) -> 'a list -> int32 option
end

module List64 :
sig
  val init : int64 -> (int64 -> 'a) -> 'a list
  val make : int64 -> 'a -> 'a list
  val length : 'a list -> int64
  val nth : 'a list -> int64 -> 'a (* raises Failure *)
  val take : int64 -> 'a list -> 'a list (* raises Failure *)
  val drop : int64 -> 'a list -> 'a list (* raises Failure *)
  val mapi : (int64 -> 'a -> 'b) -> 'a list -> 'b list
end

module Array64 :
sig
  val make : int64 -> 'a -> 'a array
  val length : 'a array -> int64
  val get : 'a array -> int64 -> 'a
  val set : 'a array -> int64 -> 'a -> unit
  val blit : 'a array -> int64 -> 'a array -> int64 -> int64 -> unit
end

module Bigarray :
sig
  open Bigarray

  module Array1_64 :
  sig
    val create : ('a, 'b) kind -> 'c layout -> int64 -> ('a, 'b, 'c) Array1.t
    val dim : ('a, 'b, 'c) Array1.t -> int64
    val get : ('a, 'b, 'c) Array1.t -> int64 -> 'a
    val set : ('a, 'b, 'c) Array1.t -> int64 -> 'a -> unit
    val sub : ('a, 'b, 'c) Array1.t -> int64 -> int64 -> ('a, 'b, 'c) Array1.t
  end
end

module Option :
sig
  val get : 'a option -> 'a -> 'a
  val force : 'a option -> 'a (* raises Invalid_argument *)
  val map : ('a -> 'b) -> 'a option -> 'b option
  val app : ('a -> unit) -> 'a option -> unit
end

module Int :
sig
  val log2 : int -> int
  val is_power_of_two : int -> bool
end

module Int32 :
sig
  val log2 : int32 -> int32
  val is_power_of_two : int32 -> bool
end

module Int64 :
sig
  val log2 : int64 -> int64
  val log2_unsigned : int64 -> int64
  val is_power_of_two : int64 -> bool
  val is_power_of_two_unsigned : int64 -> bool
end

module Char :
sig
  val is_digit_ascii : char -> bool
  val is_uppercase_ascii : char -> bool
  val is_lowercase_ascii : char -> bool
  val is_letter_ascii : char -> bool
  val is_alphanum_ascii : char -> bool
end

module String :
sig
  val implode : char list -> string
  val explode : string -> char list
  val split : string -> char -> string list
  val breakup : string -> int -> string list
  val find_from_opt : (char -> bool) -> string -> int -> int option
end

module Promise :
sig
  type 'a t
  exception Promise
  val make : unit -> 'a t
  val fulfill : 'a t -> 'a -> unit
  val value : 'a t -> 'a
  val value_opt : 'a t -> 'a option
end
