(* WebAssembly-compatible type conversions to i64 implementation *)

val extend_s_i32 : I32.t -> I64.t
val extend_u_i32 : I32.t -> I64.t
val trunc_s_f32 : F32.t -> I64.t
val trunc_u_f32 : F32.t -> I64.t
val trunc_s_f64 : F64.t -> I64.t
val trunc_u_f64 : F64.t -> I64.t
val reinterpret_f64 : F64.t -> I64.t
