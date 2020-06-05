(* WebAssembly-compatible type conversions to i64 implementation *)

let extend_i32_s x = Int64.of_int32 x

let extend_i32_u x = Int64.logand (Int64.of_int32 x) 0x0000_0000_ffff_ffffL

let trunc_f32_s x =
  if F32.ne x x then
    raise Numeric_error.InvalidConversionToInteger
  else
    let xf = F32.to_float x in
    if xf >= -.Int64.(to_float min_int) || xf < Int64.(to_float min_int) then
      raise Numeric_error.IntegerOverflow
    else
      Int64.of_float xf

let trunc_f32_u x =
  if F32.ne x x then
    raise Numeric_error.InvalidConversionToInteger
  else
    let xf = F32.to_float x in
    if xf >= -.Int64.(to_float min_int) *. 2.0 || xf <= -1.0 then
      raise Numeric_error.IntegerOverflow
    else if xf >= -.Int64.(to_float min_int) then
      Int64.(logxor (of_float (xf -. 0x1p63)) min_int)
    else
      Int64.of_float xf

let trunc_f64_s x =
  if F64.ne x x then
    raise Numeric_error.InvalidConversionToInteger
  else
    let xf = F64.to_float x in
    if xf >= -.Int64.(to_float min_int) || xf < Int64.(to_float min_int) then
      raise Numeric_error.IntegerOverflow
    else
      Int64.of_float xf

let trunc_f64_u x =
  if F64.ne x x then
    raise Numeric_error.InvalidConversionToInteger
  else
    let xf = F64.to_float x in
    if xf >= -.Int64.(to_float min_int) *. 2.0 || xf <= -1.0 then
      raise Numeric_error.IntegerOverflow
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
      Int64.(logxor (of_float (xf -. 9223372036854775808.0)) min_int)
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
      Int64.(logxor (of_float (xf -. 9223372036854775808.0)) min_int)
    else
      Int64.of_float xf

let reinterpret_f64 = F64.to_bits
