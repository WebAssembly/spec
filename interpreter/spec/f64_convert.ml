(* WebAssembly-compatible type conversions to f64 implementation *)

let promote_f32 x =
  let xf = F32.to_float x in
  if xf = xf then F64.of_float xf else
  let nan32bits = I64_convert.extend_u_i32 (F32.to_bits x) in
  let sign_field = Int64.(shift_left (shift_right_logical nan32bits 31) 63) in
  let significand_field = Int64.(shift_right_logical (shift_left nan32bits 41) 12) in
  let fields = Int64.logor sign_field significand_field in
  let nan64bits = Int64.logor 0x7ff8000000000000L fields in
  F64.of_bits nan64bits

let convert_s_i32 x =
  F64.of_float (Int32.to_float x)

(*
 * Unlike the other convert_u functions, the high half of the i32 range is
 * within the range where f32 can represent odd numbers, so we can't do the
 * shift. Instead, we can use int64 signed arithmetic.
 *)
let convert_u_i32 x =
  F64.of_float Int64.(to_float (logand (of_int32 x) 0x00000000ffffffffL))

let convert_s_i64 x =
  F64.of_float (Int64.to_float x)

(*
 * Values in the low half of the int64 range can be converted with a signed
 * conversion. The high half is beyond the range where f64 can represent odd
 * numbers, so we can shift the value right, adjust the least significant
 * bit to round correctly, do a conversion, and then scale it back up.
 *)
let convert_u_i64 x =
  F64.of_float
    Int64.(if x >= zero then to_float x else
           to_float (logor (shift_right_logical x 1) (logand x 1L)) *. 2.0)

let reinterpret_i64 = F64.of_bits
