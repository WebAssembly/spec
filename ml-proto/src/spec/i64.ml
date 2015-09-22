(* WebAssembly-compatible i64 implementation *)

(*
 * Unsigned comparison in terms of signed comparison.
 *)
let cmp_u x op y =
  op (Int64.add x Int64.min_int) (Int64.add y Int64.min_int)

(*
 * Unsigned division and remainder in terms of signed division; algorithm from
 * Hacker's Delight, Second Edition, by Henry S. Warren, Jr., section 9-3
 * "Unsigned Short Division from Signed Division".
 *)
let divrem_u n d =
  if d = Int64.zero then raise Numerics.IntegerDivideByZero else
  let t = Int64.shift_right d (64 - 1) in
  let n' = Int64.logand n (Int64.lognot t) in
  let q = Int64.shift_left (Int64.div (Int64.shift_right_logical n' 1) d) 1 in
  let r = Int64.sub n (Int64.mul q d) in
  if cmp_u r (<) d then
    q, r
  else
    Int64.add q Int64.one, Int64.sub r d

type t = int64

let of_int64 x = x
let to_int64 x = x

let zero = Int64.zero

let add = Int64.add
let sub = Int64.sub
let mul = Int64.mul

let div_s x y =
  if y = Int64.zero then
    raise Numerics.IntegerDivideByZero
  else if x = Int64.min_int && y = Int64.minus_one then
    raise Numerics.IntegerOverflow
  else
    Int64.div x y

let div_u x y =
  let q, r = divrem_u x y in q

let rem_s x y =
  if y = Int64.zero then
    raise Numerics.IntegerDivideByZero
  else
    Int64.rem x y

let rem_u x y =
  let q, r = divrem_u x y in r

let and_ = Int64.logand
let or_ = Int64.logor
let xor = Int64.logxor

(* WebAssembly shift counts are unmasked and unsigned *)
let shift_ok n = n >= Int64.zero && n < Int64.of_int 64

let shl x y =
  if shift_ok y then
    Int64.shift_left x (Int64.to_int y)
  else
    Int64.zero

let shr_s x y =
  Int64.shift_right x (if shift_ok y then Int64.to_int y else 64 - 1)

let shr_u x y =
  if shift_ok y then
    Int64.shift_right_logical x (Int64.to_int y)
  else
    Int64.zero

let clz x =
  Int64.of_int
  (let rec loop acc n =
    if n = Int64.zero then
      64
    else if and_ n (Int64.shift_left Int64.one (64 - 1)) <> Int64.zero then
      acc
    else
      loop (1 + acc) (Int64.shift_left n 1)
  in loop 0 x)

let ctz x =
  Int64.of_int
  (let rec loop acc n =
    if n = Int64.zero then
      64
    else if and_ n Int64.one = Int64.one then
      acc
    else
      loop (1 + acc) (Int64.shift_right_logical n 1)
  in loop 0 x)

let popcnt x =
  Int64.of_int
  (let rec loop acc i n =
    if n = Int64.zero then
      acc
    else
      let acc' = if and_ n Int64.one = Int64.one then acc + 1 else acc in
      loop acc' (i - 1) (Int64.shift_right_logical n 1)
  in loop 0 64 x)

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

let of_string = Int64.of_string
let to_string = Int64.to_string
