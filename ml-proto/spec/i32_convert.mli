(* WebAssembly-compatible type conversions to i32 implementation *)

val wrap_i64 : I64.t -> I32.t
val trunc_s_f32 : Values.F32.t -> I32.t
val trunc_u_f32 : Values.F32.t -> I32.t
val trunc_s_f64 : Values.F64.t -> I32.t
val trunc_u_f64 : Values.F64.t -> I32.t
val reinterpret_f32 : Values.F32.t -> I32.t
