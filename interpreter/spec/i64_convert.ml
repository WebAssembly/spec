(* WebAssembly-compatible type conversions to i64 implementation *)

let extend_s_i32 x = Int64.of_int32 x

let extend_u_i32 x = Int64.logand (Int64.of_int32 x) 0x00000000ffffffffL

let trunc_s_f32 x =
  if F32.ne x x then
    raise Numeric_error.InvalidConversionToInteger
  else
    let xf = F32.to_float x in
    if xf >= -.Int64.(to_float min_int) || xf < Int64.(to_float min_int) then
      raise Numeric_error.IntegerOverflow
    else
      Int64.of_float xf

let trunc_u_f32 x =
  if F32.ne x x then
    raise Numeric_error.InvalidConversionToInteger
  else
    let xf = F32.to_float x in
    if xf >= -.Int64.(to_float min_int) *. 2.0 || xf <= -1.0 then
      raise Numeric_error.IntegerOverflow
    else if xf >= -.Int64.(to_float min_int) then
      Int64.(logxor (of_float (xf -. 9223372036854775808.0)) min_int)
    else
      Int64.of_float xf

let trunc_s_f64 x =
  if F64.ne x x then
    raise Numeric_error.InvalidConversionToInteger
  else
    let xf = F64.to_float x in
    if xf >= -.Int64.(to_float min_int) || xf < Int64.(to_float min_int) then
      raise Numeric_error.IntegerOverflow
    else
      Int64.of_float xf

let trunc_u_f64 x =
  if F64.ne x x then
    raise Numeric_error.InvalidConversionToInteger
  else
    let xf = F64.to_float x in
    if xf >= -.Int64.(to_float min_int) *. 2.0 || xf <= -1.0 then
      raise Numeric_error.IntegerOverflow
    else if xf >= -.Int64.(to_float min_int) then
      Int64.(logxor (of_float (xf -. 9223372036854775808.0)) min_int)
    else
      Int64.of_float xf

let reinterpret_f64 = F64.to_bits
