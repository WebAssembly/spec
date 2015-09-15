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

module type FLOAT_TRAITS = sig
  type t
  val size : int
  val nondeterministic_nan : t
end

module Float32Traits : FLOAT_TRAITS = struct
  type t = int32
  let size = 32

  (* TODO: Do something meaningful with nondeterminism *)
  let nondeterministic_nan = 0x7fc0f0f0l
end

module Float64Traits : FLOAT_TRAITS = struct
  type t = int64
  let size = 64

  (* TODO: Do something meaningful with nondeterminism *)
  let nondeterministic_nan = 0x7fff0f0f0f0f0f0fL
end

module Float (Traits : FLOAT_TRAITS) (Int : Basicint.BASIC_INT with type t = Traits.t) : BASIC_FLOAT = struct
  include Traits

  type bits = Int.t

  let of_bits x = x
  let to_bits x = x
  let of_float x = of_bits (Int.bits_of_float x)
  let to_float x = to_bits (Int.float_of_bits x)

  (* TODO: OCaml's string_of_float and float_of_string are insufficient *)
  let of_string x = of_float (float_of_string x)
  let to_string x = string_of_float (to_float x)

  let zero = of_float 0.0

  (* Most arithmetic ops that return NaN return a nondeterministic NaN *)
  let arith_of_bits = to_float
  let bits_of_arith f = if f <> f then nondeterministic_nan else of_float f

  let add x y = bits_of_arith ((arith_of_bits x) +. (arith_of_bits y))
  let sub x y = bits_of_arith ((arith_of_bits x) -. (arith_of_bits y))
  let mul x y = bits_of_arith ((arith_of_bits x) *. (arith_of_bits y))
  let div x y = bits_of_arith ((arith_of_bits x) /. (arith_of_bits y))
  let sqrt  x = bits_of_arith (Pervasives.sqrt (arith_of_bits x))

  let ceil  x = bits_of_arith (Pervasives.ceil  (arith_of_bits x))
  let floor x = bits_of_arith (Pervasives.floor (arith_of_bits x))

  let trunc x =
    let xf = arith_of_bits x in
    (* preserve the sign of zero *)
    if xf = 0.0 then x else
    (* trunc is either ceil or floor depending on which one is toward zero *)
    let f = if xf < 0.0 then Pervasives.ceil xf else Pervasives.floor xf in
    bits_of_arith f

  let nearest x =
    let xf = arith_of_bits x in
    (* preserve the sign of zero *)
    if xf = 0.0 then x else
    (* nearest is either ceil or floor depending on which is nearest or even *)
    let u = Pervasives.ceil xf in
    let d = Pervasives.floor xf in
    let um = abs_float (xf -. u) in
    let dm = abs_float (xf -. d) in
    let u_or_d = um < dm || ((um = dm) && (mod_float u 2.0 = 0.0)) in
    let f = if u_or_d then u else d in
    bits_of_arith f

  let min x y =
    let xf = arith_of_bits x in
    let yf = arith_of_bits y in
    (* min(-0, 0) is -0 *)
    if xf = 0.0 && yf = 0.0 then (Int.logor x y) else
    if xf < yf then x else
    if xf > yf then y else
    nondeterministic_nan

  let max x y =
    let xf = arith_of_bits x in
    let yf = arith_of_bits y in
    (* max(-0, 0) is 0 *)
    if xf = 0.0 && yf = 0.0 then (Int.logand x y) else
    if xf > yf then x else
    if xf < yf then y else
    nondeterministic_nan

  (* abs, neg, and copysign are purely bitwise operations, even on NaN values *)
  let abs x =
    Int.logand x Int.max_int

  let neg x =
    Int.logxor x Int.min_int

  let copysign x y =
    Int.logor (abs x) (Int.logand y Int.min_int)

  let eq x y = (arith_of_bits x) =  (arith_of_bits y)
  let ne x y = (arith_of_bits x) <> (arith_of_bits y)
  let lt x y = (arith_of_bits x) <  (arith_of_bits y)
  let gt x y = (arith_of_bits x) >  (arith_of_bits y)
  let le x y = (arith_of_bits x) <= (arith_of_bits y)
  let ge x y = (arith_of_bits x) >= (arith_of_bits y)
end

module BasicFloat32 : BASIC_FLOAT = struct
  include Float(Float32Traits) (Basicint.BasicInt32)
end

module BasicFloat64 : BASIC_FLOAT = struct
  include Float(Float64Traits) (Basicint.BasicInt64)
end
