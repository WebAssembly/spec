exception InvalidConversion

module I32_ =
struct
  let wrap_i64 x = Int64.to_int32 x

  let trunc_f32_s x =
    if F32.ne x x then
      raise InvalidConversion
    else
      let xf = F32.to_float x in
      if xf >= -.Int32.(to_float min_int) || xf < Int32.(to_float min_int) then
        raise Ixx.Overflow
      else
        Int32.of_float xf

  let trunc_f32_u x =
    if F32.ne x x then
      raise InvalidConversion
    else
      let xf = F32.to_float x in
      if xf >= -.Int32.(to_float min_int) *. 2.0 || xf <= -1.0 then
        raise Ixx.Overflow
      else
        Int64.(to_int32 (of_float xf))

  let trunc_f64_s x =
    if F64.ne x x then
      raise InvalidConversion
    else
      let xf = F64.to_float x in
      if xf >= -.Int32.(to_float min_int)
      || xf <= Int32.(to_float min_int) -. 1.0 then
        raise Ixx.Overflow
      else
        Int32.of_float xf

  let trunc_f64_u x =
    if F64.ne x x then
      raise InvalidConversion
    else
      let xf = F64.to_float x in
      if xf >= -.Int32.(to_float min_int) *. 2.0 || xf <= -1.0 then
        raise Ixx.Overflow
      else
        Int64.(to_int32 (of_float xf))

  let trunc_sat_f32_s x =
    if F32.ne x x then
      0l
    else
      let xf = F32.to_float x in
      if xf < Int32.(to_float min_int) then
        Int32.min_int
      else if xf >= -.Int32.(to_float min_int) then
        Int32.max_int
      else
        Int32.of_float xf

  let trunc_sat_f32_u x =
    if F32.ne x x then
      0l
    else
      let xf = F32.to_float x in
      if xf <= -1.0 then
        0l
      else if xf >= -.Int32.(to_float min_int) *. 2.0 then
        -1l
      else
        Int64.(to_int32 (of_float xf))

  let trunc_sat_f64_s x =
    if F64.ne x x then
      0l
    else
      let xf = F64.to_float x in
      if xf < Int32.(to_float min_int) then
        Int32.min_int
      else if xf >= -.Int32.(to_float min_int) then
        Int32.max_int
      else
        Int32.of_float xf

  let trunc_sat_f64_u x =
    if F64.ne x x then
      0l
    else
      let xf = F64.to_float x in
      if xf <= -1.0 then
        0l
      else if xf >= -.Int32.(to_float min_int) *. 2.0 then
        -1l
      else
        Int64.(to_int32 (of_float xf))

  let reinterpret_f32 = F32.to_bits
end

module I64_ =
struct
  let extend_i32_s x = Int64.of_int32 x

  let extend_i32_u x = Int64.logand (Int64.of_int32 x) 0x0000_0000_ffff_ffffL

  let trunc_f32_s x =
    if F32.ne x x then
      raise InvalidConversion
    else
      let xf = F32.to_float x in
      if xf >= -.Int64.(to_float min_int) || xf < Int64.(to_float min_int) then
        raise Ixx.Overflow
      else
        Int64.of_float xf

  let trunc_f32_u x =
    if F32.ne x x then
      raise InvalidConversion
    else
      let xf = F32.to_float x in
      if xf >= -.Int64.(to_float min_int) *. 2.0 || xf <= -1.0 then
        raise Ixx.Overflow
      else if xf >= -.Int64.(to_float min_int) then
        Int64.(logxor (of_float (xf -. 0x1p63)) min_int)
      else
        Int64.of_float xf

  let trunc_f64_s x =
    if F64.ne x x then
      raise InvalidConversion
    else
      let xf = F64.to_float x in
      if xf >= -.Int64.(to_float min_int) || xf < Int64.(to_float min_int) then
        raise Ixx.Overflow
      else
        Int64.of_float xf

  let trunc_f64_u x =
    if F64.ne x x then
      raise InvalidConversion
    else
      let xf = F64.to_float x in
      if xf >= -.Int64.(to_float min_int) *. 2.0 || xf <= -1.0 then
        raise Ixx.Overflow
      else if xf >= -.Int64.(to_float min_int) then
        Int64.(logxor (of_float (xf -. 0x1p63)) min_int)
      else
        Int64.of_float xf

  let trunc_sat_f32_s x =
    if F32.ne x x then
      0L
    else
      let xf = F32.to_float x in
      if xf < Int64.(to_float min_int) then
        Int64.min_int
      else if xf >= -.Int64.(to_float min_int) then
        Int64.max_int
      else
        Int64.of_float xf

  let trunc_sat_f32_u x =
    if F32.ne x x then
      0L
    else
      let xf = F32.to_float x in
      if xf <= -1.0 then
        0L
      else if xf >= -.Int64.(to_float min_int) *. 2.0 then
        -1L
      else if xf >= -.Int64.(to_float min_int) then
        Int64.(logxor (of_float (xf -. 0x1p63)) min_int)
      else
        Int64.of_float xf

  let trunc_sat_f64_s x =
    if F64.ne x x then
      0L
    else
      let xf = F64.to_float x in
      if xf < Int64.(to_float min_int) then
        Int64.min_int
      else if xf >= -.Int64.(to_float min_int) then
        Int64.max_int
      else
        Int64.of_float xf

  let trunc_sat_f64_u x =
    if F64.ne x x then
      0L
    else
      let xf = F64.to_float x in
      if xf <= -1.0 then
        0L
      else if xf >= -.Int64.(to_float min_int) *. 2.0 then
        -1L
      else if xf >= -.Int64.(to_float min_int) then
        Int64.(logxor (of_float (xf -. 0x1p63)) min_int)
      else
        Int64.of_float xf

  let reinterpret_f64 = F64.to_bits
end

module F32_ =
struct
  let demote_f64 x =
    let xf = F64.to_float x in
    if xf = xf then F32.of_float xf else
    let nan64bits = F64.to_bits x in
    let sign = Int64.(shift_left (shift_right_logical nan64bits 63) 31) in
    let significand = Int64.(shift_right_logical (shift_left nan64bits 12) 41) in
    let fields = Int64.logor sign significand in
    let nan32bits = Int32.logor 0x7fc0_0000l (I32_.wrap_i64 fields) in
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
end

module F64_ =
struct
  let promote_f32 x =
    let xf = F32.to_float x in
    if xf = xf then F64.of_float xf else
    let nan32bits = I64_.extend_i32_u (F32.to_bits x) in
    let sign = Int64.(shift_left (shift_right_logical nan32bits 31) 63) in
    let significand = Int64.(shift_right_logical (shift_left nan32bits 41) 12) in
    let fields = Int64.logor sign significand in
    let nan64bits = Int64.logor 0x7ff8_0000_0000_0000L fields in
    F64.of_bits nan64bits

  let convert_i32_s x =
    F64.of_float (Int32.to_float x)

  (*
   * Unlike the other convert_u functions, the high half of the i32 range is
   * within the range where f32 can represent odd numbers, so we can't do the
   * shift. Instead, we can use int64 signed arithmetic.
   *)
  let convert_i32_u x =
    F64.of_float Int64.(to_float (logand (of_int32 x) 0x0000_0000_ffff_ffffL))

  let convert_i64_s x =
    F64.of_float (Int64.to_float x)

  (*
   * Values in the low half of the int64 range can be converted with a signed
   * conversion. The high half is beyond the range where f64 can represent odd
   * numbers, so we can shift the value right, adjust the least significant
   * bit to round correctly, do a conversion, and then scale it back up.
   *)
  let convert_i64_u x =
    F64.of_float Int64.(
      if x >= zero then to_float x else
      to_float (logor (shift_right_logical x 1) (logand x 1L)) *. 2.0
    )

  let reinterpret_i64 = F64.of_bits
end
