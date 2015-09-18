(* WebAssembly-compatible type conversions to f64 implementation *)

val promote_f32 : Float32.t -> Float64.t
val convert_s_i32 : int32 -> Float64.t
val convert_u_i32 : int32 -> Float64.t
val convert_s_i64 : int64 -> Float64.t
val convert_u_i64 : int64 -> Float64.t
val reinterpret_i64 : int64 -> Float64.t
