(* WebAssembly-compatible type conversions to i32 implementation *)

let wrap_i64 x = Int64.to_int32 x

let trunc_f32_s x =
  if F32.ne x x then
    raise Numeric_error.InvalidConversionToInteger
  else
    let xf = F32.to_float x in
    if xf >= -.Int32.(to_float min_int) || xf < Int32.(to_float min_int) then
      raise Numeric_error.IntegerOverflow
    else
      Int32.of_float xf

let trunc_f32_u x =
  if F32.ne x x then
    raise Numeric_error.InvalidConversionToInteger
  else
    let xf = F32.to_float x in
    if xf >= -.Int32.(to_float min_int) *. 2.0 || xf <= -1.0 then
      raise Numeric_error.IntegerOverflow
    else
      Int64.(to_int32 (of_float xf))

let trunc_f64_s x =
  if F64.ne x x then
    raise Numeric_error.InvalidConversionToInteger
  else
    let xf = F64.to_float x in
    if xf >= -.Int32.(to_float min_int) || xf <= Int32.(to_float min_int) -. 1.0 then
      raise Numeric_error.IntegerOverflow
    else
      Int32.of_float xf

let trunc_f64_u x =
  if F64.ne x x then
    raise Numeric_error.InvalidConversionToInteger
  else
    let xf = F64.to_float x in
    if xf >= -.Int32.(to_float min_int) *. 2.0 || xf <= -1.0 then
      raise Numeric_error.IntegerOverflow
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
