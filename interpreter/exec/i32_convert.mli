(* WebAssembly-compatible type conversions to i32 implementation *)

val wrap_i64 : I64.t -> I32.t
val trunc_f32_s : F32.t -> I32.t
val trunc_f32_u : F32.t -> I32.t
val trunc_f64_s : F64.t -> I32.t
val trunc_f64_u : F64.t -> I32.t
val trunc_sat_f32_s : F32.t -> I32.t
val trunc_sat_f32_u : F32.t -> I32.t
val trunc_sat_f64_s : F64.t -> I32.t
val trunc_sat_f64_u : F64.t -> I32.t
val reinterpret_f32 : F32.t -> I32.t
