(* WebAssembly-compatible type conversions to i64 implementation *)

val extend_s_i32 : int32 -> int64
val extend_u_i32 : int32 -> int64
val trunc_s_f32 : F32.t -> int64
val trunc_u_f32 : F32.t -> int64
val trunc_s_f64 : F64.t -> int64
val trunc_u_f64 : F64.t -> int64
val reinterpret_f64 : F64.t -> int64
