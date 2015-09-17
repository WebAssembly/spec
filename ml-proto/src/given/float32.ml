(* WebAssembly-compatible float32 implementation *)

(*
 * We represent float32 as its bits in an int32 so that we can be assured that
 * all the bits of NaNs are preserved in all cases where we require them to be.
 *)
type t = int32
type bits = int32

(* TODO: Do something meaningful with nondeterminism *)
let nondeterministic_nan = 0x7fc0f0f0l

let of_float = Int32.bits_of_float
let to_float = Int32.float_of_bits

(* TODO: OCaml's string_of_float and float_of_string are insufficient *)
let of_string x = of_float (float_of_string x)
let to_string x = string_of_float (to_float x)

let of_bits x = x
let to_bits x = x

(* Most arithmetic ops that return NaN return a nondeterministic NaN *)
let arith_of_bits = to_float
let bits_of_arith f = if f <> f then nondeterministic_nan else of_float f

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
  let u_or_d = um < dm || ((um = dm) && (mod_float u 2.0 = 0.0)) in
  let f = if u_or_d then u else d in
  bits_of_arith f

let min x y =
  let xf = arith_of_bits x in
  let yf = arith_of_bits y in
  (* min(-0, 0) is -0 *)
  if xf = yf then Int32.logor x y else
  if xf < yf then x else
  if xf > yf then y else
  nondeterministic_nan

let max x y =
  let xf = arith_of_bits x in
  let yf = arith_of_bits y in
  (* max(-0, 0) is 0 *)
  if xf = yf then Int32.logand x y else
  if xf > yf then x else
  if xf < yf then y else
  nondeterministic_nan

(* abs, neg, and copysign are purely bitwise operations, even on NaN values *)
let abs x =
  Int32.logand x Int32.max_int

let neg x =
  Int32.logxor x Int32.min_int

let copysign x y =
  Int32.logor (abs x) (Int32.logand y Int32.min_int)

let eq x y = (arith_of_bits x) =  (arith_of_bits y)
let ne x y = (arith_of_bits x) <> (arith_of_bits y)
let lt x y = (arith_of_bits x) <  (arith_of_bits y)
let gt x y = (arith_of_bits x) >  (arith_of_bits y)
let le x y = (arith_of_bits x) <= (arith_of_bits y)
let ge x y = (arith_of_bits x) >= (arith_of_bits y)

(* TODO: type conversion functions *)
