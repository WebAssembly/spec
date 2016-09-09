(* Things that should be in the OCaml library... *)

module Fun :
sig
  val repeat : int -> ('a -> unit) -> 'a -> unit
end

module List :
sig
  val make : int -> 'a -> 'a list
  val table : int -> (int -> 'a) -> 'a list
  val take : int -> 'a list -> 'a list (* raise Failure *)
  val drop : int -> 'a list -> 'a list (* raise Failure *)

  val length32 : 'a list -> int32
  val nth32 : 'a list -> int32 -> 'a (* raise Failure *)

  val last : 'a list -> 'a (* raise Failure *)
  val split_last : 'a list -> 'a list * 'a (* raise Failure *)

  val index_of : 'a -> 'a list -> int option
end

module Option :
sig
  val get : 'a option -> 'a -> 'a
  val map : ('a -> 'b) -> 'a option -> 'b option
  val app : ('a -> unit) -> 'a option -> unit
end

module Int :
sig
  val is_power_of_two : int -> bool
end

module Int64 :
sig
  val is_power_of_two : int64 -> bool
end

module String :
sig
  val breakup : string -> int -> string list
end
