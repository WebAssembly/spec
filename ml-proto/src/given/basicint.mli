(* WebAssembly-compatible integer implementation *)

module type BASIC_INT =
sig
  type t
  val size : int
  val max_int : t
  val min_int : t
  val neg : t -> t
  val abs : t -> t
  val lognot : t -> t
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t
  val rem : t -> t -> t
  val logand : t -> t -> t
  val logor : t -> t -> t
  val logxor : t -> t -> t
  (* TODO: type should be t -> t -> t for wasm *)
  val shift_left : t -> int -> t
  val shift_right : t -> int -> t
  val shift_right_logical : t -> int -> t

  (* TODO obviate these *)
  val to_float : t -> float
  val of_float : float -> t
  val bits_of_float : float -> t
  val float_of_bits : t -> float

  val to_big_int_u : t -> Big_int.big_int
  val of_big_int_u : Big_int.big_int -> t
end

module BasicInt32 : BASIC_INT
module BasicInt64 : BASIC_INT
