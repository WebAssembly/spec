(* WebAssembly-compatible type conversions to f32 implementation *)

let make_nan_nondeterministic x = F32.mul x (F32.of_float 1.)

let demote_f64 x =
  make_nan_nondeterministic (F32.of_float (F64.to_float x))

let convert_s_i32 x =
  make_nan_nondeterministic (F32.of_float (Int32.to_float x))

let convert_u_i32 x =
  make_nan_nondeterministic
    (F32.of_float (if x >= Int32.zero then
       Int32.to_float x
     else
       Int32.to_float (Int32.shift_right_logical x 1) *. 2.))

let convert_s_i64 x =
  make_nan_nondeterministic (F32.of_float (Int64.to_float x))

let convert_u_i64 x =
  make_nan_nondeterministic
    (F32.of_float (if x >= Int64.zero then
       Int64.to_float x
     else
       Int64.to_float (Int64.shift_right_logical x 1) *. 2.))

let reinterpret_i32 = F32.of_bits
