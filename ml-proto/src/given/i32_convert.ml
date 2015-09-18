(* WebAssembly-compatible type conversions to i32 implementation *)

let wrap_i64 x = Int64.to_int32 x

let trunc_s_f32 x =
  if Float32.ne x x then
    raise Numerics.InvalidConversionToInteger
  else let xf = Float32.to_float x in
    if xf >= (Int32.to_float Int32.max_int) +. 1. ||
       xf <= (Int32.to_float Int32.min_int) -. 1. then
      raise Numerics.IntegerOverflow
    else
      Int32.of_float xf

let trunc_u_f32 x =
  if Float32.ne x x then
    raise Numerics.InvalidConversionToInteger
  else let xf = Float32.to_float x in
      if xf >= (Int32.to_float Int32.max_int) *. 2. +. 2. ||
         xf <= -1. then
      raise Numerics.IntegerOverflow
    else
      Int64.to_int32 (Int64.of_float xf)

let trunc_s_f64 x =
  if Float64.ne x x then
    raise Numerics.InvalidConversionToInteger
  else let xf = Float64.to_float x in
      if xf >= (Int32.to_float Int32.max_int) +. 1. ||
         xf <= (Int32.to_float Int32.min_int) -. 1. then
      raise Numerics.IntegerOverflow
    else
      Int32.of_float xf

let trunc_u_f64 x =
  if Float64.ne x x then
    raise Numerics.InvalidConversionToInteger
  else let xf = Float64.to_float x in
      if xf >= (Int32.to_float Int32.max_int) *. 2. +. 2. ||
         xf <= -1. then
      raise Numerics.IntegerOverflow
    else
      Int64.to_int32 (Int64.of_float xf)

let reinterpret_f32 = Float32.to_bits
