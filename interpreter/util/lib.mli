(* Things that should be in the OCaml library... *)

type void = |

module Fun :
sig
  val id : 'a -> 'a
  val curry : ('a * 'b -> 'c) -> ('a -> 'b -> 'c)
  val uncurry : ('a -> 'b -> 'c) -> ('a * 'b -> 'c)

  val repeat : int -> ('a -> unit) -> 'a -> unit
end

module List :
sig
  val make : int -> 'a -> 'a list
  val table : int -> (int -> 'a) -> 'a list
  val take : int -> 'a list -> 'a list (* raises Failure *)
  val drop : int -> 'a list -> 'a list (* raises Failure *)

  val last : 'a list -> 'a (* raises Failure *)
  val split_last : 'a list -> 'a list * 'a (* raises Failure *)

  val index_of : 'a -> 'a list -> int option
  val index_where : ('a -> bool) -> 'a list -> int option
  val map_filter : ('a -> 'b option) -> 'a list -> 'b list
  val concat_map : ('a -> 'b list) -> 'a list -> 'b list
  val pairwise : ('a -> 'a -> 'b) -> 'a list -> 'b list
end

module List32 :
sig
  val make : int32 -> 'a -> 'a list
  val length : 'a list -> int32
  val nth : 'a list -> int32 -> 'a (* raises Failure *)
  val take : int32 -> 'a list -> 'a list (* raises Failure *)
  val drop : int32 -> 'a list -> 'a list (* raises Failure *)
  val mapi : (int32 -> 'a -> 'b) -> 'a list -> 'b list
end

module Array32 :
sig
  val make : int32 -> 'a -> 'a array
  val length : 'a array -> int32
  val get : 'a array -> int32 -> 'a
  val set : 'a array -> int32 -> 'a -> unit
  val blit : 'a array -> int32 -> 'a array -> int32 -> int32 -> unit
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

module String :
sig
  val implode : char list -> string
  val explode : string -> char list
  val split : string -> char -> string list
  val breakup : string -> int -> string list
  val find_from_opt : (char -> bool) -> string -> int -> int option
end
