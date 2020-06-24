(* WebAssembly-compatible type conversions to f32 implementation *)

let demote_f64 x =
  let xf = F64.to_float x in
  if xf = xf then F32.of_float xf else
  let nan64bits = F64.to_bits x in
  let sign_field = Int64.(shift_left (shift_right_logical nan64bits 63) 31) in
  let significand_field = Int64.(shift_right_logical (shift_left nan64bits 12) 41) in
  let fields = Int64.logor sign_field significand_field in
  let nan32bits = Int32.logor 0x7fc0_0000l (I32_convert.wrap_i64 fields) in
  F32.of_bits nan32bits

let convert_i32_s x =
  F32.of_float (Int32.to_float x)

(*
 * Similar to convert_i64_u below, the high half of the i32 range are beyond
 * the range where f32 can represent odd numbers, though we do need to adjust
 * the least significant bit to round correctly.
 *)
let convert_i32_u x =
  F32.of_float Int32.(
    if x >= zero then to_float x else
    to_float (logor (shift_right_logical x 1) (logand x 1l)) *. 2.0
  )

(*
 * Values that are too large would get rounded when represented in f64,
 * but double rounding via i64->f64->f32 can produce inaccurate results.
 * Hence, for large values we shift right but make sure to accumulate the lost
 * bits in the least significant bit, such that rounding still is correct.
 *)
let convert_i64_s x =
  F32.of_float Int64.(
    if abs x < 0x10_0000_0000_0000L then to_float x else
    let r = if logand x 0xfffL = 0L then 0L else 1L in
    to_float (logor (shift_right x 12) r) *. 0x1p12
  )

let convert_i64_u x =
  F32.of_float Int64.(
    if I64.lt_u x 0x10_0000_0000_0000L then to_float x else
    let r = if logand x 0xfffL = 0L then 0L else 1L in
    to_float (logor (shift_right_logical x 12) r) *. 0x1p12
  )

let reinterpret_i32 = F32.of_bits
