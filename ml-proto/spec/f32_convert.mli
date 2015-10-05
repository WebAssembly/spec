(* WebAssembly-compatible type conversions to f32 implementation *)

val demote_f64 : Values.F64.t -> Values.F32.t
val convert_s_i32 : I32.t -> Values.F32.t
val convert_u_i32 : I32.t -> Values.F32.t
val convert_s_i64 : I64.t -> Values.F32.t
val convert_u_i64 : I64.t -> Values.F32.t
val reinterpret_i32 : I32.t -> Values.F32.t
