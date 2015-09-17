(* WebAssembly-compatible type conversions to f64 implementation *)

val promote_f32 : Values.F32.t -> Values.F64.t
val convert_s_i32 : I32.t -> Values.F64.t
val convert_u_i32 : I32.t -> Values.F64.t
val convert_s_i64 : I64.t -> Values.F64.t
val convert_u_i64 : I64.t -> Values.F64.t
val reinterpret_i64 : I64.t -> Values.F64.t
