module type RepType =
sig
  type t

  val pos_nan : t
  val neg_nan : t
  val bits_of_float : float -> t
  val float_of_bits : t -> float
  val of_string : string -> t
  val to_string : t -> string
  val to_hex_string : t -> string

  val lognot : t -> t
  val logand : t -> t -> t
  val logor : t -> t -> t
  val logxor : t -> t -> t

  val min_int : t
  val max_int : t

  val zero : t
  val bare_nan : t
end

module type S =
sig
  type t
  type bits
  val pos_nan : t
  val neg_nan : t
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

module Make (Rep : RepType) : S with type bits = Rep.t =
struct
  type t = Rep.t
  type bits = Rep.t

  let pos_inf = Rep.bits_of_float (1.0 /. 0.0)
  let neg_inf = Rep.bits_of_float (-. (1.0 /. 0.0))
  let pos_nan = Rep.pos_nan
  let neg_nan = Rep.neg_nan
  let bare_nan = Rep.bare_nan

  let of_float = Rep.bits_of_float
  let to_float = Rep.float_of_bits

  let of_bits x = x
  let to_bits x = x

  let is_inf x = x = pos_inf || x = neg_inf
  let is_nan x = let xf = Rep.float_of_bits x in xf <> xf

  (*
   * When the result of an arithmetic operation is NaN, the most significant
   * bit of the significand field is set.
   *)
  let canonicalize_nan x = Rep.logor x Rep.pos_nan

  (*
   * When the result of a binary operation is NaN, the resulting NaN is computed
   * from one of the NaN inputs, if there is one. If both are NaN, one is
   * selected nondeterminstically. If neither, we use a default NaN value.
   *)
  let determine_binary_nan x y =
    (*
     * TODO: There are two nondeterministic things we could do here. When both
     * x and y are NaN, we can nondeterministically pick which to return. And
     * when neither is NaN, we can nondeterministically pick whether to return
     * pos_nan or neg_nan.
     *)
    let nan =
      if is_nan x then x else
      if is_nan y then y else Rep.pos_nan
    in canonicalize_nan nan

  (*
   * When the result of a unary operation is NaN, the resulting NaN is computed
   * from one of the NaN input, if there it is NaN. Otherwise, we use a default
   * NaN value.
   *)
  let determine_unary_nan x =
    (*
     * TODO: There is one nondeterministic thing we could do here. When the
     * operand is not NaN, we can nondeterministically pick whether to return
     * pos_nan or neg_nan.
     *)
    let nan = if is_nan x then x else Rep.pos_nan in
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
    let u_or_d =
      um < dm ||
      um = dm && let h = u /. 2. in Pervasives.floor h = h
    in
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

  let eq x y = (to_float x = to_float y)
  let ne x y = (to_float x <> to_float y)
  let lt x y = (to_float x < to_float y)
  let gt x y = (to_float x > to_float y)
  let le x y = (to_float x <= to_float y)
  let ge x y = (to_float x >= to_float y)

  let of_signless_string s =
    if s = "inf" then
      pos_inf
    else if s = "nan" then
      pos_nan
    else if String.length s > 6 && String.sub s 0 6 = "nan:0x" then
      let x = Rep.of_string (String.sub s 4 (String.length s - 4)) in
      if x = Rep.zero then
        raise (Failure "nan payload must not be zero")
      else if Rep.logand x bare_nan <> Rep.zero then
        raise (Failure "nan payload must not overlap with exponent bits")
      else if x < Rep.zero then
        raise (Failure "nan payload must not overlap with sign bit")
      else
        Rep.logor x bare_nan
    else
      let x = of_float (float_of_string s) in
      if is_inf x then failwith "of_string" else x

  let of_string s =
    if s = "" then
      failwith "of_string"
    else if s.[0] = '+' || s.[0] = '-' then
      let x = of_signless_string (String.sub s 1 (String.length s - 1)) in
      if s.[0] = '+' then x else neg x
    else
      of_signless_string s

  let to_string x =
    (if x < Rep.zero then "-" else "") ^
    if is_nan x then
      "nan:0x" ^ Rep.to_hex_string (Rep.logand (abs x) (Rep.lognot bare_nan))
    else
      (* TODO: use sprintf "%h" once we have upgraded to OCaml 4.03 *)
      string_of_float (to_float (abs x))
end
