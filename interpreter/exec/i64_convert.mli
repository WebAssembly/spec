(* WebAssembly-compatible type conversions to i64 implementation *)

val extend_i32_s : I32.t -> I64.t
val extend_i32_u : I32.t -> I64.t
val trunc_f32_s : F32.t -> I64.t
val trunc_f32_u : F32.t -> I64.t
val trunc_f64_s : F64.t -> I64.t
val trunc_f64_u : F64.t -> I64.t
val trunc_sat_f32_s : F32.t -> I64.t
val trunc_sat_f32_u : F32.t -> I64.t
val trunc_sat_f64_s : F64.t -> I64.t
val trunc_sat_f64_u : F64.t -> I64.t
val reinterpret_f64 : F64.t -> I64.t
