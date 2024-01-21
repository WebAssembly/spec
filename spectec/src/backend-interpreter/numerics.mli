open Al.Ast

val i32_to_const : int32 -> value
val i64_to_const : int64 -> value
val f32_to_const : Reference_interpreter.F32.t -> value
val f64_to_const : Reference_interpreter.F64.t -> value

val call_numerics : string -> value list -> value
val mem : string -> bool
