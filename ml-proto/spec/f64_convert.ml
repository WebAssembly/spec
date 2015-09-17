module F32 = Values.F32
module F64 = Values.F64

(* WebAssembly-compatible type conversions to f64 implementation *)

let make_nan_nondeterministic x = F64.mul x (F64.of_float 1.)

let promote_f32 x =
  make_nan_nondeterministic (F64.of_float (F32.to_float x))

let convert_s_i32 x =
  make_nan_nondeterministic (F64.of_float (Int32.to_float x))

(*
 * Unlike the other convert_u functions, the high half of the i32 range is
 * within the range where f32 can represent odd numbers, so we can't do the
 * shift. Instead, we can use int64 signed arithmetic.
 *)
let convert_u_i32 x =
  make_nan_nondeterministic
    (F64.of_float
       (Int64.to_float (Int64.logand (Int64.of_int32 x) 0x00000000ffffffffL)))

let convert_s_i64 x =
  make_nan_nondeterministic (F64.of_float (Int64.to_float x))

(*
 * Values in the low half of the int64 range can be converted with a signed
 * conversion. The high half is beyond the range where f64 can represent odd
 * numbers, so we can shift the value right, do a conversion, and then scale it
 * back up, without worrying about losing the least-significant digit.
 *)
let convert_u_i64 x =
  make_nan_nondeterministic
    (F64.of_float (if x >= Int64.zero then
       Int64.to_float x
     else
       Int64.to_float (Int64.shift_right_logical x 1) *. 2.))

let reinterpret_i64 = F64.of_bits
