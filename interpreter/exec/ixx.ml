exception Overflow
exception DivideByZero
exception InvalidConversion

module type RepType =
sig
  type t

  val zero : t
  val one : t
  val minus_one : t
  val max_int : t
  val min_int : t

  val abs : t -> t
  val neg : t -> t
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t (* raises DivideByZero *)
  val rem : t -> t -> t (* raises DivideByZero *)

  val logand : t -> t -> t
  val lognot : t -> t
  val logor : t -> t -> t
  val logxor : t -> t -> t
  val shift_left : t -> int -> t
  val shift_right : t -> int -> t
  val shift_right_logical : t -> int -> t

  val of_int : int -> t
  val to_int : t -> int
  val of_int64: int64 -> t
  val to_int64: t -> int64
  val to_string : t -> string
  val to_hex_string : t -> string

  val bitwidth : int
end

module type S =
sig
  type t
  type bits

  val of_bits : bits -> t
  val to_bits : t -> bits

  val zero : t

  val lognot : t -> t
  val abs : t -> t
  val neg : t -> t
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div_s : t -> t -> t (* raises IntegerDivideByZero, IntegerOverflow *)
  val div_u : t -> t -> t (* raises IntegerDivideByZero *)
  val rem_s : t -> t -> t (* raises IntegerDivideByZero *)
  val rem_u : t -> t -> t (* raises IntegerDivideByZero *)
  val avgr_u : t -> t -> t
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
  val extend_s : int -> t -> t
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

  val as_unsigned : t -> t

  (* Saturating arithmetic, used for small ints. *)
  val saturate_s : t -> t
  val saturate_u : t -> t
  val add_sat_s : t -> t -> t
  val add_sat_u : t -> t -> t
  val sub_sat_s : t -> t -> t
  val sub_sat_u : t -> t -> t
  val q15mulr_sat_s : t -> t -> t

  val of_int_s : int -> t
  val of_int_u : int -> t
  val of_string_s : string -> t
  val of_string_u : string -> t
  val of_string : string -> t
  val to_int_s : t -> int
  val to_int_u : t -> int
  val to_string_s : t -> string
  val to_string_u : t -> string
  val to_hex_string : t -> string
end

module Make (Rep : RepType) : S with type bits = Rep.t and type t = Rep.t =
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
    if d = Rep.zero then raise DivideByZero else
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
  let one = Rep.one
  let ten = Rep.of_int 10

  let lognot = Rep.lognot
  let abs = Rep.abs
  let neg = Rep.neg

  (* If bit (bitwidth - 1) is set, sx will sign-extend t to maintain the
   * invariant that small ints are stored sign-extended inside a wider int. *)
  let sx x =
    let i = 64 - Rep.bitwidth in
    Rep.of_int64 Int64.(shift_right (shift_left (Rep.to_int64 x) i) i)

  (* add, sub, and mul are sign-agnostic and do not trap on overflow. *)
  let add x y = sx (Rep.add x y)
  let sub x y = sx (Rep.sub x y)

  let mul x y = sx (Rep.mul x y)

  (* We don't override min_int and max_int since those are used
   * by other functions (like parsing), and rely on it being
   * min/max for int32 *)
  (* The smallest signed |bitwidth|-bits int. *)
  let low_int = Rep.shift_left Rep.minus_one (Rep.bitwidth - 1)
  (* The largest signed |bitwidth|-bits int. *)
  let high_int = Rep.logxor low_int Rep.minus_one

  (* result is truncated toward zero *)
  let div_s x y =
    if y = Rep.zero then
      raise DivideByZero
    else if x = low_int && y = Rep.minus_one then
      raise Overflow
    else
      Rep.div x y

  (* result is floored (which is the same as truncating for unsigned values) *)
  let div_u x y =
    let q, r = divrem_u x y in q

  (* result has the sign of the dividend *)
  let rem_s x y =
    if y = Rep.zero then
      raise DivideByZero
    else
      Rep.rem x y

  let rem_u x y =
    let q, r = divrem_u x y in r

  let avgr_u x y =
    let open Int64 in
    (* Mask with bottom #bitwidth bits set *)
    let mask = shift_right_logical minus_one (64 - Rep.bitwidth) in
    let x64 = logand mask (Rep.to_int64 x) in
    let y64 = logand mask (Rep.to_int64 y) in
    Rep.of_int64 (div (add (add x64 y64) one) (of_int 2))

  let and_ = Rep.logand
  let or_ = Rep.logor
  let xor = Rep.logxor

  (* WebAssembly's shifts mask the shift count according to the bitwidth. *)
  let shift f x y =
    f x Rep.(to_int (logand y (of_int (bitwidth - 1))))

  let shl x y =
    sx (shift Rep.shift_left x y)

  let shr_s x y =
    shift Rep.shift_right x y

  (* Check if we are storing smaller ints. *)
  let needs_extend = shl one (Rep.of_int (Rep.bitwidth - 1)) <> Rep.min_int

  (*
   * When Int is used to store a smaller int, it is stored in signed extended
   * form. Some instructions require the unsigned form, which requires masking
   * away the top 32-bitwidth bits.
   *)
  let as_unsigned x =
    if not needs_extend then x else
    (* Mask with bottom #bitwidth bits set *)
    let mask = Rep.(shift_right_logical minus_one (32 - bitwidth)) in
    Rep.logand x mask

  let shr_u x y =
    sx (shift Rep.shift_right_logical (as_unsigned x) y)

  (* We must mask the count to implement rotates via shifts. *)
  let clamp_rotate_count n =
    Rep.to_int (Rep.logand n (Rep.of_int (Rep.bitwidth - 1)))

  let rotl x y =
    let n = clamp_rotate_count y in
    or_ (shl x (Rep.of_int n)) (shr_u x (Rep.of_int (Rep.bitwidth - n)))

  let rotr x y =
    let n = clamp_rotate_count y in
    or_ (shr_u x (Rep.of_int n)) (shl x (Rep.of_int (Rep.bitwidth - n)))

  (* clz is defined for all values, including all-zeros. *)
  let clz x =
    let rec loop acc n =
      if n = Rep.zero then
        Rep.bitwidth
      else if and_ n (Rep.shift_left Rep.one (Rep.bitwidth - 1)) = zero then
        loop (1 + acc) (Rep.shift_left n 1)
      else
        acc
    in Rep.of_int (loop 0 x)

  (* ctz is defined for all values, including all-zeros. *)
  let ctz x =
    let rec loop acc n =
      if n = Rep.zero then
        Rep.bitwidth
      else if and_ n Rep.one = Rep.one then
        acc
      else
        loop (1 + acc) (Rep.shift_right_logical n 1)
    in Rep.of_int (loop 0 x)

  let popcnt x =
    let rec loop acc i n =
      if i = 0 then
        acc
      else
        let acc' = if and_ n Rep.one = Rep.one then acc + 1 else acc in
        loop acc' (i - 1) (Rep.shift_right_logical n 1)
    in Rep.of_int (loop 0 Rep.bitwidth x)

  let extend_s n x =
    let shift = Rep.bitwidth - n in
    Rep.shift_right (Rep.shift_left x shift) shift

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

  let saturate_s x = sx (min (max x low_int) high_int)
  let saturate_u x = sx (min (max x Rep.zero) (as_unsigned Rep.minus_one))

  (* add/sub for int, used for higher-precision arithmetic for I8 and I16 *)
  let add_int x y =
    assert (Rep.bitwidth < 32);
    Rep.(of_int ((to_int x) + (to_int y)))

  let sub_int x y =
    assert (Rep.bitwidth < 32);
    Rep.(of_int ((to_int x) - (to_int y)))

  let add_sat_s x y = saturate_s (add_int x y)
  let add_sat_u x y = saturate_u (add_int (as_unsigned x) (as_unsigned y))
  let sub_sat_s x y = saturate_s (sub_int x y)
  let sub_sat_u x y = saturate_u (sub_int (as_unsigned x) (as_unsigned y))

  let q15mulr_sat_s x y =
    (* mul x64 y64 can overflow int64 when both are int32 min, but this is only
     * used by i16x8, so we are fine for now. *)
    assert (Rep.bitwidth < 32);
    let x64 = Rep.to_int64 x in
    let y64 = Rep.to_int64 y in
    saturate_s (Rep.of_int64 Int64.((shift_right (add (mul x64 y64) 0x4000L) 15)))

  let to_int_s = Rep.to_int
  let to_int_u i = Rep.to_int i land ((Rep.to_int Rep.max_int lsl 1) lor 1)

  let of_int_s = Rep.of_int
  let of_int_u i = and_ (Rep.of_int i) (or_ (shl (Rep.of_int max_int) one) one)

  (* String conversion that allows leading signs and unsigned values *)

  let require b = if not b then failwith "of_string"

  let dec_digit = function
    | '0' .. '9' as c -> Char.code c - Char.code '0'
    | _ -> failwith "of_string"

  let hex_digit = function
    | '0' .. '9' as c ->  Char.code c - Char.code '0'
    | 'a' .. 'f' as c ->  0xa + Char.code c - Char.code 'a'
    | 'A' .. 'F' as c ->  0xa + Char.code c - Char.code 'A'
    | _ ->  failwith "of_string"

  let max_upper, max_lower = divrem_u Rep.minus_one ten

  let sign_extend i =
    (* This module is used with I32 and I64, but the bitwidth can be less
     * than that, e.g. for I16. When used for smaller integers, the stored value
     * needs to be signed extended, e.g. parsing -1 into a I16 (backed by Int32)
     * should have all high bits set. We can do that by logor with a mask,
     * where the mask is minus_one left shifted by bitwidth. But if bitwidth
     * matches the number of bits of Rep, the shift will be incorrect.
     *   -1 (Int32) << 32 = -1
     * Then the logor will be also wrong. So we check and bail out early.
     * *)
    if not needs_extend then i else
    let sign_bit = Rep.logand (Rep.of_int (1 lsl (Rep.bitwidth - 1))) i in
    if sign_bit = Rep.zero then i else
    (* Build a sign-extension mask *)
    let sign_mask = (Rep.shift_left Rep.minus_one Rep.bitwidth) in
    Rep.logor sign_mask i

  let of_string s =
    let open Rep in
    let len = String.length s in
    let rec parse_hex i num =
      if i = len then num else
      if s.[i] = '_' then parse_hex (i + 1) num else
      let digit = of_int (hex_digit s.[i]) in
      require (le_u num (shr_u minus_one (of_int 4)));
      parse_hex (i + 1) (logor (shift_left num 4) digit)
    in
    let rec parse_dec i num =
      if i = len then num else
      if s.[i] = '_' then parse_dec (i + 1) num else
      let digit = of_int (dec_digit s.[i]) in
      require (lt_u num max_upper || num = max_upper && le_u digit max_lower);
      parse_dec (i + 1) (add (mul num ten) digit)
    in
    let parse_int i =
      require (len - i > 0);
      if i + 2 <= len && s.[i] = '0' && s.[i + 1] = 'x'
      then parse_hex (i + 2) zero
      else parse_dec i zero
    in
    require (len > 0);
    let parsed =
      match s.[0] with
      | '+' -> parse_int 1
      | '-' ->
        let n = parse_int 1 in
        require (ge_s (sub n one) minus_one);
        Rep.neg n
      | _ -> parse_int 0
    in
    let n = sign_extend parsed in
    require (low_int <= n && n <= high_int);
    n

  let of_string_s s =
    let n = of_string s in
    require (s.[0] = '-' || ge_s n Rep.zero);
    n

  let of_string_u s =
    let n = of_string s in
    require (s.[0] != '+' && s.[0] != '-');
    n

  (* String conversion that groups digits for readability *)

  let rec add_digits buf s i j k n =
    if i < j then begin
      if k = 0 then Buffer.add_char buf '_';
      Buffer.add_char buf s.[i];
      add_digits buf s (i + 1) j ((k + n - 1) mod n) n
    end

  let group_digits n s =
    let len = String.length s in
    let num = if s.[0] = '-' then 1 else 0 in
    let buf = Buffer.create (len*(n+1)/n) in
    Buffer.add_substring buf s 0 num;
    add_digits buf s num len ((len - num) mod n + n) n;
    Buffer.contents buf

  let to_string_s i = group_digits 3 (Rep.to_string i)
  let to_string_u i =
    if i >= Rep.zero then
      group_digits 3 (Rep.to_string i)
    else
      group_digits 3 (Rep.to_string (div_u i ten) ^ Rep.to_string (rem_u i ten))

  let to_hex_string i = "0x" ^ group_digits 4 (Rep.to_hex_string i)
end
