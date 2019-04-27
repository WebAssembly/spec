(* WebAssembly-compatible type conversions to f64 implementation *)

val promote_f32 : F32.t -> F64.t
val convert_i32_s : I32.t -> F64.t
val convert_i32_u : I32.t -> F64.t
val convert_i64_s : I64.t -> F64.t
val convert_i64_u : I64.t -> F64.t
val reinterpret_i64 : I64.t -> F64.t
