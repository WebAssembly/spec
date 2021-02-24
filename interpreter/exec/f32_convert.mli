(* WebAssembly-compatible type conversions to f32 implementation *)

val demote_f64 : F64.t -> F32.t
val convert_i32_s : I32.t -> F32.t
val convert_i32_u : I32.t -> F32.t
val convert_i64_s : I64.t -> F32.t
val convert_i64_u : I64.t -> F32.t
val reinterpret_i32 : I32.t -> F32.t
