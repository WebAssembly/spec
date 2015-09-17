module F32 = Values.F32 
module F64 = Values.F64

(* WebAssembly-compatible type conversions to f32 implementation *)

let make_nan_nondeterministic x = F32.mul x (F32.of_float 1.)

let demote_f64 x =
  make_nan_nondeterministic (F32.of_float (F64.to_float x))

let convert_s_i32 x =
  make_nan_nondeterministic (F32.of_float (Int32.to_float x))

(*
 * Similar to convert_u_i64 below, the high half of the i32 range are beyond
 * the range where f32 can represent odd numbers.
 *)
let convert_u_i32 x =
  make_nan_nondeterministic
    (F32.of_float (if x >= Int32.zero then
       Int32.to_float x
     else
       Int32.to_float (Int32.shift_right_logical x 1) *. 2.))

let convert_s_i64 x =
  make_nan_nondeterministic (F32.of_float (Int64.to_float x))

(*
 * Values in the low half of the int64 range can be converted with a signed
 * conversion. The high half is beyond the range where f32 can represent odd
 * numbers, so we can shift the value right, do a conversion, and then scale it
 * back up, without worrying about losing the least-significant digit.
 *)
let convert_u_i64 x =
  make_nan_nondeterministic
    (F32.of_float (if x >= Int64.zero then
       Int64.to_float x
     else
       Int64.to_float (Int64.shift_right_logical x 1) *. 2.))

let reinterpret_i32 = F32.of_bits
