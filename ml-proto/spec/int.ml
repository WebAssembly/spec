(* WebAssembly-compatible int operations implementation *)

module type RepresentationType =
sig
  type t
  val add : t -> t -> t
  val min_int : t
  val zero : t
  val one : t
  val minus_one : t
  val neg : t -> t
  val shift_left : t -> int -> t
  val shift_right : t -> int -> t
  val logand : t -> t -> t
  val lognot : t -> t
  val logor : t -> t -> t
  val logxor : t -> t -> t
  val sub : t -> t -> t
  val div : t -> t -> t
  val mul : t -> t -> t
  val rem : t -> t -> t
  val shift_right_logical : t -> int -> t
  val of_int : int -> t
  val to_int : t -> int
  val to_string : t -> string

  val bitwidth : int
end

module type S =
sig
  type t
  type bits

  val of_bits : bits -> t
  val to_bits : t -> bits

  val zero : t

  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div_s : t -> t -> t
  val div_u : t -> t -> t
  val rem_s : t -> t -> t
  val rem_u : t -> t -> t
  val and_ : t -> t -> t
  val or_ : t -> t -> t
  val xor : t -> t -> t
  val shl : t -> t -> t
  val shr_s : t -> t -> t
  val shr_u : t -> t -> t
  val rotl : t -> t -> t
  val rotr : t -> t -> t
  val clz : t -> t
  val ctz : t -> t
  val popcnt : t -> t
  val eqz : t -> bool
  val eq : t -> t -> bool
  val ne : t -> t -> bool
  val lt_s : t -> t -> bool
  val lt_u : t -> t -> bool
  val le_s : t -> t -> bool
  val le_u : t -> t -> bool
  val gt_s : t -> t -> bool
  val gt_u : t -> t -> bool
  val ge_s : t -> t -> bool
  val ge_u : t -> t -> bool

  val of_int : int -> t
  val of_string : string -> t
  val to_string : t -> string
end

module Make(Rep : RepresentationType) : S with type bits = Rep.t and type t = Rep.t =
struct
  (*
   * Unsigned comparison in terms of signed comparison.
   *)
  let cmp_u x op y =
    op (Rep.add x Rep.min_int) (Rep.add y Rep.min_int)

  (*
   * Unsigned division and remainder in terms of signed division; algorithm from
   * Hacker's Delight, Second Edition, by Henry S. Warren, Jr., section 9-3
   * "Unsigned Short Division from Signed Division".
   *)
  let divrem_u n d =
    if d = Rep.zero then raise Numerics.IntegerDivideByZero else
      let t = Rep.shift_right d (Rep.bitwidth - 1) in
      let n' = Rep.logand n (Rep.lognot t) in
      let q = Rep.shift_left (Rep.div (Rep.shift_right_logical n' 1) d) 1 in
      let r = Rep.sub n (Rep.mul q d) in
      if cmp_u r (<) d then
        q, r
      else
        Rep.add q Rep.one, Rep.sub r d

  type t = Rep.t
  type bits = Rep.t

  let of_bits x = x
  let to_bits x = x

  let zero = Rep.zero

  (* add, sub, and mul are sign-agnostic and do not trap on overflow. *)
  let add = Rep.add
  let sub = Rep.sub
  let mul = Rep.mul

  (* result is truncated toward zero *)
  let div_s x y =
    if y = Rep.zero then
      raise Numerics.IntegerDivideByZero
    else if x = Rep.min_int && y = Rep.minus_one then
      raise Numerics.IntegerOverflow
    else
      Rep.div x y

  (* result is floored (which is the same as truncating, for unsigned values) *)
  let div_u x y =
    let q, r = divrem_u x y in q

  (* result has the sign of the dividend *)
  let rem_s x y =
    if y = Rep.zero then
      raise Numerics.IntegerDivideByZero
    else
      Rep.rem x y

  let rem_u x y =
    let q, r = divrem_u x y in r

  let and_ = Rep.logand
  let or_ = Rep.logor
  let xor = Rep.logxor

  (* WebAssembly's shifts mask the shift count according to the bitwidth. *)
  let shift f x y =
    f x (Rep.to_int (Rep.logand y (Rep.of_int (Rep.bitwidth - 1))))

  let shl x y =
    shift Rep.shift_left x y

  let shr_s x y =
    shift Rep.shift_right x y

  let shr_u x y =
    shift Rep.shift_right_logical x y

  (* We must mask the count to implement rotates via shifts. *)
  let clamp_rotate_count n =
    Rep.to_int (Rep.logand n (Rep.of_int (Rep.bitwidth - 1)))

  let rotl x y =
    let n = clamp_rotate_count y in
    or_ (Rep.shift_left x n) (Rep.shift_right_logical x (Rep.bitwidth - n))

  let rotr x y =
    let n = clamp_rotate_count y in
    or_ (Rep.shift_right_logical x n) (Rep.shift_left x (Rep.bitwidth - n))

  (* clz is defined for all values, including all-zeros. *)
  let clz x =
    Rep.of_int
      (let rec loop acc n =
         if n = Rep.zero then
           Rep.bitwidth
         else if and_ n (Rep.shift_left Rep.one (Rep.bitwidth - 1)) <> Rep.zero then
           acc
         else
           loop (1 + acc) (Rep.shift_left n 1)
       in loop 0 x)

  (* ctz is defined for all values, including all-zeros. *)
  let ctz x =
    Rep.of_int
      (let rec loop acc n =
         if n = Rep.zero then
           Rep.bitwidth
         else if and_ n Rep.one = Rep.one then
           acc
         else
           loop (1 + acc) (Rep.shift_right_logical n 1)
       in loop 0 x)

  let popcnt x =
    Rep.of_int
      (let rec loop acc i n =
         if n = Rep.zero then
           acc
         else
           let acc' = if and_ n Rep.one = Rep.one then acc + 1 else acc in
           loop acc' (i - 1) (Rep.shift_right_logical n 1)
       in loop 0 Rep.bitwidth x)

  let eqz x = x = Rep.zero

  let eq x y = x = y
  let ne x y = x <> y
  let lt_s x y = x < y
  let lt_u x y = cmp_u x (<) y
  let le_s x y = x <= y
  let le_u x y = cmp_u x (<=) y
  let gt_s x y = x > y
  let gt_u x y = cmp_u x (>) y
  let ge_s x y = x >= y
  let ge_u x y = cmp_u x (>=) y

  (* This implementation allows leading signs and unsigned values *)
  let of_string x =
    let len = String.length x in
    let power_of_two n = (Rep.shift_left Rep.one n) in
    let ten = (Rep.of_int 10) in
    let parse_hexdigit c =
      int_of_char c -
        if '0' <= c && '9' >= c then 0x30
        else if 'a' <= c && 'f' >= c then (0x61 - 10)
        else if 'A' <= c && 'F' >= c then (0x41 - 10)
        else assert false
    in
    let parse_hex offset sign =
      let num = ref Rep.zero in
      for i = offset to (len - 1) do
        assert (lt_u !num (power_of_two (Rep.bitwidth - 4)));
        num := Rep.logor (Rep.shift_left !num 4) (Rep.of_int (parse_hexdigit x.[i]));
      done;
      assert (sign || (le_u !num (power_of_two (Rep.bitwidth - 1))));
      !num
    in
    let parse_dec offset sign =
      let max_upper, max_lower =
        if sign then
          divrem_u Rep.minus_one ten
        else
          divrem_u (power_of_two (Rep.bitwidth - 1)) ten
      in
      let num = ref Rep.zero in
      for i = offset to (len - 1) do
        assert ('0' <= x.[i] && '9' >= x.[i]);
        let new_digit = (Rep.of_int (int_of_char x.[i] - 0x30)) in
        assert ((lt_u !num max_upper) || ((!num = max_upper) && (le_u new_digit max_lower)));
        num := (Rep.add (Rep.mul !num ten) new_digit)
      done;
      !num
    in
    let parse_int offset sign =
      if offset + 3 <= len && (String.sub x offset 2) = "0x" then
        parse_hex (offset + 2) sign
      else
        parse_dec offset sign
    in
    match x.[0] with
      | '+' -> parse_int 1 true
      | '-' -> Rep.neg (parse_int 1 false)
      | _ -> parse_int 0 true

  let to_string = Rep.to_string

  let of_int = Rep.of_int
end
