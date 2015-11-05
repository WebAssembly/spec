module type RepresentationType =
sig
  type t

  val nondeterministic_nan : t
  val bits_of_float : float -> t
  val float_of_bits : t -> float
  val of_string : string -> t
  val to_string : t -> string

  val logand : t -> t -> t
  val logor : t -> t -> t
  val logxor : t -> t -> t

  val min_int : t
  val max_int : t

  val zero : t
  val bare_nan : t
  val print_nan_significand_digits : t -> string
end

module type S =
sig
  type t
  type bits
  val of_float : float -> t
  val to_float : t -> float
  val of_string : string -> t
  val to_string : t -> string
  val of_bits : bits -> t
  val to_bits : t -> bits
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t
  val sqrt : t -> t
  val min : t -> t -> t
  val max : t -> t -> t
  val ceil : t -> t
  val floor : t -> t
  val trunc : t -> t
  val nearest : t -> t
  val abs : t -> t
  val neg : t -> t
  val copysign : t -> t -> t
  val eq : t -> t -> bool
  val ne : t -> t -> bool
  val lt : t -> t -> bool
  val le : t -> t -> bool
  val gt : t -> t -> bool
  val ge : t -> t -> bool
  val zero : t
end

module Make(Rep : RepresentationType) : S with type bits = Rep.t =
struct
  type t = Rep.t
  type bits = Rep.t

  (* TODO: Do something meaningful with nondeterminism *)
  let nondeterministic_nan = Rep.nondeterministic_nan
  let bare_nan = Rep.bare_nan

  let of_float = Rep.bits_of_float
  let to_float = Rep.float_of_bits

  let of_bits x = x
  let to_bits x = x

  (* Most arithmetic ops that return NaN return a nondeterministic NaN *)
  let arith_of_bits = to_float
  let bits_of_arith f = if f <> f then Rep.nondeterministic_nan else of_float f

  let zero = of_float 0.0

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
    let u_or_d = um < dm ||
                 (um = dm && let h = u /. 2. in Pervasives.floor h = h) in
    let f = if u_or_d then u else d in
    bits_of_arith f

  let min x y =
    let xf = arith_of_bits x in
    let yf = arith_of_bits y in
    (* min -0 0 is -0 *)
    if xf = yf then Rep.logor x y else
    if xf < yf then x else
	if xf > yf then y else
	nondeterministic_nan

  let max x y =
    let xf = arith_of_bits x in
    let yf = arith_of_bits y in
    (* max -0 0 is 0 *)
    if xf = yf then Rep.logand x y else
    if xf > yf then x else
	if xf < yf then y else
	nondeterministic_nan

  (* abs, neg, and copysign are purely bitwise operations, even on NaN values *)
  let abs x =
    Rep.logand x Rep.max_int

  let neg x =
    Rep.logxor x Rep.min_int

  let copysign x y =
    Rep.logor (abs x) (Rep.logand y Rep.min_int)

  let eq x y = (arith_of_bits x) =  (arith_of_bits y)
  let ne x y = (arith_of_bits x) <> (arith_of_bits y)
  let lt x y = (arith_of_bits x) <  (arith_of_bits y)
  let gt x y = (arith_of_bits x) >  (arith_of_bits y)
  let le x y = (arith_of_bits x) <= (arith_of_bits y)
  let ge x y = (arith_of_bits x) >= (arith_of_bits y)

  let of_signless_string x len =
    if x <> "nan" &&
         (len > 6) &&
           (String.sub x 0 6) = "nan:0x" then
      (let s = Rep.of_string (String.sub x 4 ((len - 4))) in
       if s = Rep.zero then
         raise (Failure "nan payload must not be zero")
       else if Rep.logand s bare_nan <> Rep.zero then
         raise (Failure "nan payload must not overlap with exponent bits")
       else if s < Rep.zero then
         raise (Failure "nan payload must not overlap with sign bit")
       else
         Rep.logor s bare_nan)
    else
      (* TODO: OCaml's float_of_string is insufficient *)
      of_float (float_of_string x)

  let of_string x =
    let len = String.length x in
    if len > 0 && (String.get x 0) = '-' then
      neg (of_signless_string (String.sub x 1 (len - 1)) (len - 1))
    else if len > 0 && (String.get x 0) = '+' then
      of_signless_string (String.sub x 1 (len - 1)) (len - 1)
    else
      of_signless_string x len

  let to_string x =
    (if x < Rep.zero then "-" else "") ^
      let a = abs x in
      let af = arith_of_bits a in
      if af <> af then
        ("nan:0x" ^ Rep.print_nan_significand_digits a)
      else
        (* TODO: OCaml's string_of_float is insufficient *)
        string_of_float (to_float a)

end

