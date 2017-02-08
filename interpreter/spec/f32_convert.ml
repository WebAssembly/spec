(* WebAssembly-compatible type conversions to f32 implementation *)

let demote_f64 x =
  let xf = F64.to_float x in
  if xf = xf then F32.of_float xf else
  let nan64bits = F64.to_bits x in
  let sign_field = Int64.(shift_left (shift_right_logical nan64bits 63) 31) in
  let significand_field = Int64.(shift_right_logical (shift_left nan64bits 12) 41) in
  let fields = Int64.logor sign_field significand_field in
  let nan32bits = Int32.logor 0x7fc00000l (I32_convert.wrap_i64 fields) in
  F32.of_bits nan32bits

let convert_s_i32 x =
  F32.of_float (Int32.to_float x)

(*
 * Similar to convert_u_i64 below, the high half of the i32 range are beyond
 * the range where f32 can represent odd numbers, though we do need to adjust
 * the least significant bit to round correctly.
 *)
let convert_u_i32 x =
  F32.of_float
    Int32.(if x >= zero then to_float x else
           to_float (logor (shift_right_logical x 1) (logand x 1l)) *. 2.0)

let convert_s_i64 x =
  F32.of_float (Int64.to_float x)

(*
 * Values in the low half of the int64 range can be converted with a signed
 * conversion. The high half is beyond the range where f32 can represent odd
 * numbers, so we can shift the value right, do a conversion, and then scale it
 * back up, without worrying about losing the least-significant digit.
 *)
let convert_u_i64 x =
  F32.of_float (if x >= Int64.zero then
    Int64.to_float x
  else
    Int64.(to_float (shift_right_logical x 1) *. 2.0))

let reinterpret_i32 = F32.of_bits
