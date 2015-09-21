(* WebAssembly-compatible type conversions to i32 implementation *)

val wrap_i64 : int64 -> int32
val trunc_s_f32 : F32.t -> int32
val trunc_u_f32 : F32.t -> int32
val trunc_s_f64 : F64.t -> int32
val trunc_u_f64 : F64.t -> int32
val reinterpret_f32 : F32.t -> int32
