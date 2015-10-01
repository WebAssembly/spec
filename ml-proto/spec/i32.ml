(* WebAssembly-compatible i32 implementation *)

(*
 * Unsigned comparison in terms of signed comparison.
 *)
let cmp_u x op y =
  op (Int32.add x Int32.min_int) (Int32.add y Int32.min_int)

(*
 * Unsigned division and remainder in terms of signed division; algorithm from
 * Hacker's Delight, Second Edition, by Henry S. Warren, Jr., section 9-3
 * "Unsigned Short Division from Signed Division".
 *)
let divrem_u n d =
  if d = Int32.zero then raise Numerics.IntegerDivideByZero else
  let t = Int32.shift_right d (32 - 1) in
  let n' = Int32.logand n (Int32.lognot t) in
  let q = Int32.shift_left (Int32.div (Int32.shift_right_logical n' 1) d) 1 in
  let r = Int32.sub n (Int32.mul q d) in
  if cmp_u r (<) d then
    q, r
  else
    Int32.add q Int32.one, Int32.sub r d

type t = int32

let of_int32 x = x
let to_int32 x = x

let zero = Int32.zero

let add = Int32.add
let sub = Int32.sub
let mul = Int32.mul

let div_s x y =
  if y = Int32.zero then
    raise Numerics.IntegerDivideByZero
  else if x = Int32.min_int && y = Int32.minus_one then
    raise Numerics.IntegerOverflow
  else
    Int32.div x y

let div_u x y =
  let q, r = divrem_u x y in q

let rem_s x y =
  if y = Int32.zero then
    raise Numerics.IntegerDivideByZero
  else
    Int32.rem x y

let rem_u x y =
  let q, r = divrem_u x y in r

let and_ = Int32.logand
let or_ = Int32.logor
let xor = Int32.logxor

(* WebAssembly shift counts are unmasked and unsigned *)
let shift_ok n = n >= Int32.zero && n < Int32.of_int 32

let shl x y =
  if shift_ok y then
    Int32.shift_left x (Int32.to_int y)
  else
    Int32.zero

let shr_s x y =
  Int32.shift_right x (if shift_ok y then Int32.to_int y else 32 - 1)

let shr_u x y =
  if shift_ok y then
    Int32.shift_right_logical x (Int32.to_int y)
  else
    Int32.zero

let clz x =
  Int32.of_int
  (let rec loop acc n =
    if n = Int32.zero then
      32
    else if and_ n (Int32.shift_left Int32.one (32 - 1)) <> Int32.zero then
      acc
    else
      loop (1 + acc) (Int32.shift_left n 1)
  in loop 0 x)

let ctz x =
  Int32.of_int
  (let rec loop acc n =
    if n = Int32.zero then
      32
    else if and_ n Int32.one = Int32.one then
      acc
    else
      loop (1 + acc) (Int32.shift_right_logical n 1)
  in loop 0 x)

let popcnt x =
  Int32.of_int
  (let rec loop acc i n =
    if n = Int32.zero then
      acc
    else
      let acc' = if and_ n Int32.one = Int32.one then acc + 1 else acc in
      loop acc' (i - 1) (Int32.shift_right_logical n 1)
  in loop 0 32 x)

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

let of_string = Int32.of_string
let to_string = Int32.to_string
