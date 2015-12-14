module type RepresentationType =
sig
  type t

  val default_nan : t
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

  let default_nan = Rep.default_nan
  let bare_nan = Rep.bare_nan

  let of_float = Rep.bits_of_float
  let to_float = Rep.float_of_bits

  let of_bits x = x
  let to_bits x = x

  let is_nan x =
    let xf = Rep.float_of_bits x in xf <> xf

  (*
   * When the result of an arithmetic operation is NaN, the most significant
   * bit of the significand field is set.
   *)
  let canonicalize_nan x =
    Rep.logor x Rep.default_nan

  (*
   * When the result of a binary operation is NaN, the resulting NaN is computed
   * from one of the NaN inputs, if there is one. If both are NaN, one is
   * selected nondeterminstically. If neither, we use a default NaN value.
   *)
  let determine_binary_nan x y =
    (* TODO: Do something with the nondeterminism instead of just picking x. *)
    let nan = (if is_nan x then x else
               if is_nan y then y else
               Rep.default_nan) in
    canonicalize_nan nan

  (*
   * When the result of a unary operation is NaN, the resulting NaN is computed
   * from one of the NaN input, if there it is NaN. Otherwise, we use a default
   * NaN value.
   *)
  let determine_unary_nan x =
    let nan = (if is_nan x then x else
               Rep.default_nan) in
    canonicalize_nan nan

  let binary x op y =
    let xf = to_float x in
    let yf = to_float y in
    let t = op xf yf in
    if t = t then of_float t else determine_binary_nan x y

  let unary op x =
    let t = op (to_float x) in
    if t = t then of_float t else determine_unary_nan x

  let zero = of_float 0.0

  let add x y = binary x (+.) y
  let sub x y = binary x (-.) y
  let mul x y = binary x ( *.) y
  let div x y = binary x (/.) y

  let sqrt  x = unary Pervasives.sqrt x

  let ceil  x = unary Pervasives.ceil x
  let floor x = unary Pervasives.floor x

  let trunc x =
    let xf = to_float x in
    (* preserve the sign of zero *)
    if xf = 0.0 then x else
    (* trunc is either ceil or floor depending on which one is toward zero *)
    let f = if xf < 0.0 then Pervasives.ceil xf else Pervasives.floor xf in
    let result = of_float f in
    if is_nan result then determine_unary_nan result else result

  let nearest x =
    let xf = to_float x in
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
    let result = of_float f in
    if is_nan result then determine_unary_nan result else result

  let min x y =
    let xf = to_float x in
    let yf = to_float y in
    (* min -0 0 is -0 *)
    if xf = yf then Rep.logor x y else
    if xf < yf then x else
	if xf > yf then y else
	determine_binary_nan x y

  let max x y =
    let xf = to_float x in
    let yf = to_float y in
    (* max -0 0 is 0 *)
    if xf = yf then Rep.logand x y else
    if xf > yf then x else
	if xf < yf then y else
	determine_binary_nan x y

  (* abs, neg, and copysign are purely bitwise operations, even on NaN values *)
  let abs x =
    Rep.logand x Rep.max_int

  let neg x =
    Rep.logxor x Rep.min_int

  let copysign x y =
    Rep.logor (abs x) (Rep.logand y Rep.min_int)

  let eq x y = (to_float x) =  (to_float y)
  let ne x y = (to_float x) <> (to_float y)
  let lt x y = (to_float x) <  (to_float y)
  let gt x y = (to_float x) >  (to_float y)
  let le x y = (to_float x) <= (to_float y)
  let ge x y = (to_float x) >= (to_float y)

  let of_signless_string x len =
    if x <> "nan" &&
         (len > 6) &&
           (String.sub x 0 6) = "nan:0x" then
      (let s = Rep.of_string (String.sub x 4 (len - 4)) in
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
      if is_nan a then
        ("nan:0x" ^ Rep.print_nan_significand_digits a)
      else
        (* TODO: OCaml's string_of_float is insufficient *)
        string_of_float (to_float a)
end

