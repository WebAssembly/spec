exception Overflow
exception DivideByZero

module type RepType =
sig
  type t

  val bitwidth : int

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
  val of_int64 : int64 -> t
  val to_int64 : t -> int64
  val to_string : t -> string
  val to_hex_string : t -> string
end

module type T =
sig
  type t

  val bitwidth : int

  val zero : t

  val not_ : t -> t
  val abs : t -> t
  val neg : t -> t
  val clz : t -> t
  val ctz : t -> t
  val popcnt : t -> t

  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div_s : t -> t -> t (* raises DivideByZero, Overflow *)
  val div_u : t -> t -> t (* raises DivideByZero *)
  val rem_s : t -> t -> t (* raises DivideByZero *)
  val rem_u : t -> t -> t (* raises DivideByZero *)
  val avgr_u : t -> t -> t
  val and_ : t -> t -> t
  val or_ : t -> t -> t
  val xor : t -> t -> t
  val shl : t -> t -> t
  val shr_s : t -> t -> t
  val shr_u : t -> t -> t
  val rotl : t -> t -> t
  val rotr : t -> t -> t

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

  val add_sat_s : t -> t -> t
  val add_sat_u : t -> t -> t
  val sub_sat_s : t -> t -> t
  val sub_sat_u : t -> t -> t
  val q15mulr_sat_s : t -> t -> t

  val of_int_s : int -> t
  val of_int_u : int -> t
  val to_int_s : t -> int
  val to_int_u : t -> int

  val of_string_s : string -> t
  val of_string_u : string -> t
  val of_string : string -> t
  val to_string_s : t -> string
  val to_string_u : t -> string
  val to_hex_string : t -> string
end

module Make (Rep : RepType) : T with type t = Rep.t =
struct
  type t = Rep.t

  let bitwidth = Rep.bitwidth


  (* Constants *)

  let zero = Rep.of_int 0
  let one = Rep.of_int 1
  let minus_one = Rep.of_int (-1)
  let ten = Rep.of_int 10

  let min_int = Rep.shift_left minus_one (bitwidth - 1)
  let max_int = Rep.logxor min_int minus_one


  (* Sign and zero extension for formats with wider representation *)

  let sx i =
    let k = 64 - bitwidth in
    Rep.of_int64 Int64.(shift_right (shift_left (Rep.to_int64 i) k) k)
 
  let zx i =
    let mask = Int64.shift_right_logical (-1L) (64 - bitwidth) in
    Rep.of_int64 Int64.(logand (Rep.to_int64 i) mask)


  (* Integer conversion *)

  let to_int_s = Rep.to_int
  let to_int_u i = Rep.to_int (zx i)

  let of_int_s = Rep.of_int
  let of_int_u i =
    Rep.(logand (of_int i) (logor (shift_left (of_int Int.max_int) 1) one))


  (* Tests and comparisons *)

  let cmp_u op i j = op (Rep.add i Rep.min_int) (Rep.add j Rep.min_int)

  let eqz i = i = zero

  let eq i j = i = j
  let ne i j = i <> j
  let lt_s i j = i < j
  let lt_u i j = cmp_u (<) i j
  let le_s i j = i <= j
  let le_u i j = cmp_u (<=) i j
  let gt_s i j = i > j
  let gt_u i j = cmp_u (>) i j
  let ge_s i j = i >= j
  let ge_u i j = cmp_u (>=) i j


  (* Bit operators *)

  let not_ = Rep.lognot
  let and_ = Rep.logand
  let or_ = Rep.logor
  let xor = Rep.logxor

  let shift j =  (* Mask shift count according to bitwidth *)
    Rep.(to_int (logand j (of_int (bitwidth - 1))))

  let shl i j = sx (Rep.shift_left i (shift j))
  let shr_s i j = Rep.shift_right i (shift j)
  let shr_u i j = sx (Rep.shift_right_logical (zx i) (shift j))

  let rotl i j =
    sx (Rep.logor
      (Rep.shift_left i (shift j))
      (Rep.shift_right_logical i (bitwidth - shift j))
    )

  let rotr i j =
    sx (Rep.logor
      (Rep.shift_right_logical i (shift j))
      (Rep.shift_left i (bitwidth - shift j))
    )

  let clz i =
    let rec loop i acc =
      if i = zero then
        bitwidth
      else if and_ i Rep.(shift_left one (bitwidth - 1)) = zero then
        loop (Rep.shift_left i 1) (acc + 1)
      else
        acc
    in Rep.of_int (loop i 0)

  let ctz i =
    let rec loop i acc =
      if i = zero then
        bitwidth
      else if and_ i one = one then
        acc
      else
        loop (Rep.shift_right_logical i 1) (acc + 1)
    in Rep.of_int (loop i 0)

  let popcnt i =
    let rec loop n i acc =
      if n = 0 then
        acc
      else
        loop (n - 1) (Rep.shift_right_logical i 1)
          (if and_ i one = one then acc + 1 else acc)
    in Rep.of_int (loop bitwidth i 0)


  (* Arithmetic operators *)

  let abs = Rep.abs
  let neg = Rep.neg

  let add i j = sx (Rep.add i j)
  let sub i j = sx (Rep.sub i j)
  let mul i j = sx (Rep.mul i j)

  let div_s i j =
    if j = zero then
      raise DivideByZero
    else if i = min_int && j = minus_one then
      raise Overflow
    else
      Rep.div i j

  let rem_s i j =
    if j = zero then
      raise DivideByZero
    else
      Rep.rem i j

  (* Hacker's Delight, Second Edition, by Henry S. Warren, Jr., section 9-3
   * "Unsigned Short Division from Signed Division" *)
  let divrem_u i j =
    if j = zero then raise DivideByZero else
    let t = Rep.shift_right j (bitwidth - 1) in
    let i' = Rep.(logand i (lognot t)) in
    let q = Rep.(shift_left (div (shift_right_logical i' 1) j) 1) in
    let r = Rep.(sub i (mul q j)) in
    if cmp_u (<) r j then
      q, r
    else
      Rep.add q one, Rep.sub r j

  let div_u i j = fst (divrem_u i j)
  let rem_u i j = snd (divrem_u i j)

  let avgr_u i j =
    let open Int64 in
    let mask = shift_right_logical minus_one (64 - bitwidth) in
    let i64 = logand mask (Rep.to_int64 i) in
    let j64 = logand mask (Rep.to_int64 j) in
    Rep.of_int64 (div (add (add i64 j64) one) (of_int 2))

  let extend_s n i =
    let k = bitwidth - n in
    Rep.(shift_right (shift_left i k) k)


  (* Saturating arithmetics *)

  let sat_s i = sx (min (max i min_int) max_int)
  let sat_u i = sx (min (max i zero) (zx minus_one))

  let add_int i j = assert (bitwidth <= 32); Rep.(of_int (to_int i + to_int j))
  let sub_int i j = assert (bitwidth <= 32); Rep.(of_int (to_int i - to_int j))

  let add_sat_s i j = sat_s (add_int i j)
  let add_sat_u i j = sat_u (add_int (zx i) (zx j))
  let sub_sat_s i j = sat_s (sub_int i j)
  let sub_sat_u i j = sat_u (sub_int (zx i) (zx j))

  let q15mulr_sat_s i j =
    (* Int64.mul can overflow int64 when both are int32 min,
     * but this is only used by i16x8, so we are fine for now. *)
    assert (bitwidth <= 16);
    let i64 = Rep.to_int64 i in
    let j64 = Rep.to_int64 j in
    sat_s (Rep.of_int64 Int64.((shift_right (add (mul i64 j64) 0x4000L) 15)))


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

  let max_upper, max_lower = divrem_u minus_one ten

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
    let sign = Rep.(shift_left one (bitwidth - 1)) in
    let mask = Rep.(shift_left minus_one (bitwidth - 1)) in
    let upper = Rep.logand parsed mask in
    require (upper = zero || upper = mask || upper = sign);
    sx parsed

  let of_string_s s =
    let n = of_string s in
    require (s.[0] = '-' || ge_s n zero);
    n

  let of_string_u s =
    let n = of_string s in
    require (s.[0] <> '+' && s.[0] <> '-');
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
    if i >= zero then
      group_digits 3 (Rep.to_string i)
    else
      group_digits 3 (Rep.to_string (div_u i ten) ^ Rep.to_string (rem_u i ten))

  let to_hex_string i = "0x" ^ group_digits 4 (Rep.to_hex_string (zx i))
end
