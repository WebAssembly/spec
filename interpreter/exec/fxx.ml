module type RepType =
sig
  type t

  val bitwidth : int
  val mantissa : int

  val zero : t
  val min_int : t
  val max_int : t

  val pos_nan : t
  val neg_nan : t
  val bare_nan : t

  val bits_of_float : float -> t
  val float_of_bits : t -> float
  val of_string : string -> t
  val to_string : t -> string
  val to_hex_string : t -> string

  val lognot : t -> t
  val logand : t -> t -> t
  val logor : t -> t -> t
  val logxor : t -> t -> t
end

module type S =
sig
  type t
  type bits
  val bitwidth : int
  val mantissa : int
  val exponent : int
  val zero : t
  val pos_inf : t
  val neg_inf : t
  val pos_nan : t
  val neg_nan : t
  val is_inf : t -> bool
  val is_nan : t -> bool
  val of_float : float -> t
  val to_float : t -> float
  val of_string : string -> t
  val to_string : t -> string
  val to_hex_string : t -> string
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
end

module Make (Rep : RepType) : S with type bits = Rep.t =
struct
  let _ = assert (Rep.mantissa < Rep.bitwidth - 2)

  type t = Rep.t
  type bits = Rep.t

  let bitwidth = Rep.bitwidth
  let mantissa = Rep.mantissa
  let exponent = bitwidth - mantissa - 1

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

  let sqrt  x = unary Stdlib.sqrt x

  let ceil  x = unary Stdlib.ceil x
  let floor x = unary Stdlib.floor x

  let trunc x =
    let xf = to_float x in
    (* preserve the sign of zero *)
    if xf = 0.0 then x else
    (* trunc is either ceil or floor depending on which one is toward zero *)
    let f = if xf < 0.0 then Stdlib.ceil xf else Stdlib.floor xf in
    let result = of_float f in
    if is_nan result then determine_unary_nan result else result

  let nearest x =
    let xf = to_float x in
    (* preserve the sign of zero *)
    if xf = 0.0 then x else
    (* nearest is either ceil or floor depending on which is nearest or even *)
    let u = Stdlib.ceil xf in
    let d = Stdlib.floor xf in
    let um = abs_float (xf -. u) in
    let dm = abs_float (xf -. d) in
    let u_or_d =
      um < dm ||
      um = dm && let h = u /. 2. in Stdlib.floor h = h
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

  (* abs, neg, copysign are purely bitwise operations, even on NaN values *)
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

  (*
   * Compare mantissa of two floats in string representation (hex or dec).
   * This is a gross hack to detect rounding during parsing of floats.
   *)
  let is_hex c = ('0' <= c && c <= '9') || ('A' <= c && c <= 'F')
  let is_exp hex c = (c = if hex then 'P' else 'E')
  let at_end hex s i = (i = String.length s) || is_exp hex s.[i]

  let rec skip_non_hex s i =  (* to skip sign, 'x', '.', '_', etc. *)
    if at_end true s i || is_hex s.[i] then i else skip_non_hex s (i + 1)

  let rec skip_zeroes s i =
    let i' = skip_non_hex s i in
    if at_end true s i' || s.[i'] <> '0' then i' else skip_zeroes s (i' + 1)

  let rec compare_mantissa_str' hex s1 i1 s2 i2 =
    let i1' = skip_non_hex s1 i1 in
    let i2' = skip_non_hex s2 i2 in
    match at_end hex s1 i1', at_end hex s2 i2' with
    | true, true -> 0
    | true, false -> if at_end hex s2 (skip_zeroes s2 i2') then 0 else -1
    | false, true -> if at_end hex s1 (skip_zeroes s1 i1') then 0 else +1
    | false, false ->
      match compare s1.[i1'] s2.[i2'] with
      | 0 -> compare_mantissa_str' hex s1 (i1' + 1) s2 (i2' + 1)
      | n -> n

  let compare_mantissa_str hex s1 s2 =
    let s1' = String.uppercase_ascii s1 in
    let s2' = String.uppercase_ascii s2 in
    compare_mantissa_str' hex s1' (skip_zeroes s1' 0) s2' (skip_zeroes s2' 0)

  (*
   * Convert a string to a float in target precision by going through
   * OCaml's 64 bit floats. This may incur double rounding errors in edge
   * cases, i.e., when rounding to target precision involves a tie that
   * was created by earlier rounding during parsing to float. If both
   * end up rounding in the same direction, we would "over round".
   * This function tries to detect this case and correct accordingly.
   *)
  let float_of_string_prevent_double_rounding s =
    (* First parse to a 64 bit float. *)
    let z = float_of_string s in
    (* If value is already infinite we are done. *)
    if abs_float z = 1.0 /. 0.0 then z else
    (* Else, bit twiddling to see what rounding to target precision will do. *)
    let open Int64 in
    let bits = bits_of_float z in
    let lsb = shift_left 1L (52 - Rep.mantissa) in
    (* Check for tie, i.e. whether the bits right of target LSB are 10000... *)
    let tie = shift_right lsb 1 in
    let mask = lognot (shift_left (-1L) (52 - Rep.mantissa)) in
    (* If we have no tie, we are good. *)
    if logand bits mask <> tie then z else
    (* Else, define epsilon to be the value of the tie bit. *)
    let exp = float_of_bits (logand bits 0xfff0_0000_0000_0000L) in
    let eps = float_of_bits (logor tie (bits_of_float exp)) -. exp in
    (* Convert 64 bit float back to string to compare to input. *)
    let hex = String.contains s 'x' in
    let s' =
      if not hex then Printf.sprintf "%.*g" (String.length s) z else
      let m = logor (logand bits 0xf_ffff_ffff_ffffL) 0x10_0000_0000_0000L in
      (* Shift mantissa to match msb position in most significant hex digit *)
      let i = skip_zeroes (String.uppercase_ascii s) 0 in
      if i = String.length s then Printf.sprintf "%.*g" (String.length s) z else
      let sh =
        match s.[i] with '1' -> 0 | '2'..'3' -> 1 | '4'..'7' -> 2 | _ -> 3 in
      Printf.sprintf "%Lx" (shift_left m sh)
    in
    (* - If mantissa became larger, float was rounded up to tie already;
     *   round-to-even might round up again: sub epsilon to round down.
     * - If mantissa became smaller, float was rounded down to tie already;
     *   round-to-even migth round down again: add epsilon to round up.
     * - If tie is not the result of prior rounding, then we are good.
     *)
    match compare_mantissa_str hex s s' with
    | -1 -> z -. eps
    | +1 -> z +. eps
    | _ -> z

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
      let s' = String.concat "" (String.split_on_char '_' s) in
      let x = of_float (float_of_string_prevent_double_rounding s') in
      if is_inf x then failwith "of_string" else x

  let of_string s =
    if s = "" then
      failwith "of_string"
    else if s.[0] = '+' || s.[0] = '-' then
      let x = of_signless_string (String.sub s 1 (String.length s - 1)) in
      if s.[0] = '+' then x else neg x
    else
      of_signless_string s

  (* String conversion that groups digits for readability *)

  let is_digit c = '0' <= c && c <= '9'
  let is_hex_digit c = is_digit c || 'a' <= c && c <= 'f'

  let rec add_digits buf s i j k n =
    if i < j then begin
      if k = 0 then Buffer.add_char buf '_';
      Buffer.add_char buf s.[i];
      add_digits buf s (i + 1) j ((k + n - 1) mod n) n
    end

  let group_digits is_digit n s =
    let isnt_digit c = not (is_digit c) in
    let len = String.length s in
    let x = Lib.Option.get (Lib.String.find_from_opt ((=) 'x') s 0) 0 in
    let mant = Lib.Option.get (Lib.String.find_from_opt is_digit s x) len in
    let point = Lib.Option.get (Lib.String.find_from_opt isnt_digit s mant) len in
    let frac = Lib.Option.get (Lib.String.find_from_opt is_digit s point) len in
    let exp = Lib.Option.get (Lib.String.find_from_opt isnt_digit s frac) len in
    let buf = Buffer.create (len*(n+1)/n) in
    Buffer.add_substring buf s 0 mant;
    add_digits buf s mant point ((point - mant) mod n + n) n;
    Buffer.add_substring buf s point (frac - point);
    add_digits buf s frac exp n n;
    Buffer.add_substring buf s exp (len - exp);
    Buffer.contents buf

  let to_string' convert is_digit n x =
    (if x < Rep.zero then "-" else "") ^
    if is_nan x then
      let payload = Rep.logand (abs x) (Rep.lognot bare_nan) in
      "nan:0x" ^ group_digits is_hex_digit 4 (Rep.to_hex_string payload)
    else
      let s = convert (to_float (abs x)) in
      group_digits is_digit n
        (if s.[String.length s - 1] = '.' then s ^ "0" else s)

  let to_string = to_string' (Printf.sprintf "%.17g") is_digit 3
  let to_hex_string x =
    if is_inf x then to_string x else
    to_string' (Printf.sprintf "%h") is_hex_digit 4 x
end
