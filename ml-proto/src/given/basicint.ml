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

let to_big_int_u_for size to_big_int i =
  let open Big_int in
  let value_range = Big_int.power_int_positive_int 2 size in
  let i' = to_big_int i in
  if ge_big_int i' zero_big_int then i' else add_big_int i' value_range

let of_big_int_u_for size of_big_int i =
  let open Big_int in
  let value_range = Big_int.power_int_positive_int 2 size in
  let i' = if ge_big_int i zero_big_int then i else sub_big_int i value_range
  in of_big_int i'

module BasicInt32 =
struct
  include Int32
  let size = 32
  let of_int32 i = i
  let of_int64 = Int64.to_int32
  let to_big_int_u = to_big_int_u_for size Big_int.big_int_of_int32
  let of_big_int_u = of_big_int_u_for size Big_int.int32_of_big_int
end

module BasicInt64 =
struct
  include Int64
  let size = 64
  let of_int64 i = i
  let to_big_int_u = to_big_int_u_for size Big_int.big_int_of_int64
  let of_big_int_u = of_big_int_u_for size Big_int.int64_of_big_int
end
