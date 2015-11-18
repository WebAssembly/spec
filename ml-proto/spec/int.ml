(* WebAssembly-compatible int operations implementation *)

module type RepresentationType =
sig
  type t
  val add : t -> t -> t
  val min_int : t
  val zero : t
  val one : t
  val minus_one : t
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
  val of_string : string -> t
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
  val clz : t -> t
  val ctz : t -> t
  val popcnt : t -> t
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

  let add = Rep.add
  let sub = Rep.sub
  let mul = Rep.mul

  let div_s x y =
    if y = Rep.zero then
      raise Numerics.IntegerDivideByZero
    else if x = Rep.min_int && y = Rep.minus_one then
      raise Numerics.IntegerOverflow
    else
      Rep.div x y

  let div_u x y =
    let q, r = divrem_u x y in q

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

  (* WebAssembly's shifts mask the shift count to according to the bitwidth. *)
  let shift f x y =
    f x (Rep.to_int (Rep.logand y (Rep.of_int (Rep.bitwidth - 1))))

  let shl x y =
    shift Rep.shift_left x y

  let shr_s x y =
    shift Rep.shift_right x y

  let shr_u x y =
    shift Rep.shift_right_logical x y

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

  let of_string = Rep.of_string
  let to_string = Rep.to_string

  let of_int = Rep.of_int
end
