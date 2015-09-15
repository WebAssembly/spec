(* WebAssembly-compatible floating point implementation *)

module type BASIC_FLOAT = sig
  type t
  type bits

  val size : int

  val of_float : float -> t
  val to_float : t -> float
  val of_bits : bits -> t
  val to_bits : t -> bits
  val of_string : string -> t
  val to_string : t -> string

  val zero : t

  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t
  val sqrt : t -> t
  val ceil : t -> t
  val floor : t -> t
  val trunc : t -> t
  val nearest : t -> t
  val min : t -> t -> t
  val max : t -> t -> t
  val abs : t -> t
  val neg : t -> t
  val copysign : t -> t -> t
  val eq : t -> t -> bool
  val ne : t -> t -> bool
  val lt : t -> t -> bool
  val le : t -> t -> bool
  val gt : t -> t -> bool
  val ge : t -> t -> bool
end

module BasicFloat32 : BASIC_FLOAT
module BasicFloat64 : BASIC_FLOAT
