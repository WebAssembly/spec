(* WebAssembly-compatible type conversions to i32 implementation *)

val wrap_i64 : int64 -> int32
val trunc_s_f32 : Float32.t -> int32
val trunc_u_f32 : Float32.t -> int32
val trunc_s_f64 : Float64.t -> int32
val trunc_u_f64 : Float64.t -> int32
val reinterpret_f32 : Float32.t -> int32
