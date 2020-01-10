open Char

type shape = I8x16 | I16x8 | I32x4 | I64x2 | F32x4 | F64x2

let lanes shape =
  match shape with
  | I8x16 -> 16
  | I16x8 -> 8
  | I32x4 -> 4
  | I64x2 -> 2
  | F32x4 -> 4
  | F64x2 -> 2

module type RepType =
sig
  type t

  val make : int -> char -> t
  (* ^ bits_make ? *)
  val to_string : t -> string
  val bytewidth : int
  val of_strings : shape -> string list -> t
end

module type S =
sig
  type t
  type bits
  val default : t (* FIXME good name for default value? *)
  val to_string : t -> string
  val of_bits : bits -> t
  val to_bits : t -> bits
  val of_strings : shape -> string list -> t
end

module Make (Rep : RepType) : S with type bits = Rep.t =
struct
  type t = Rep.t
  type bits = Rep.t

  let default = Rep.make Rep.bytewidth (chr 0)
  let to_string = Rep.to_string (* FIXME very very wrong *)
  let of_bits x = x
  let to_bits x = x
  let of_strings = Rep.of_strings
end
