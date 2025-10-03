exception InvalidConversion

module I8_ :
sig
  val wrap_i16 : I16.t -> I8.t
  val wrap_i32 : I32.t -> I8.t
  val narrow_sat_i16_s : I16.t -> I8.t
  val narrow_sat_i16_u : I16.t -> I8.t
  val narrow_sat_i32_s : I32.t -> I8.t
  val narrow_sat_i32_u : I32.t -> I8.t
end

module I16_ :
sig
  val extend_i8_s : I8.t -> I16.t
  val extend_i8_u : I8.t -> I16.t
  val wrap_i32 : I32.t -> I16.t
  val narrow_sat_i32_s : I32.t -> I16.t
  val narrow_sat_i32_u : I32.t -> I16.t
end

module I32_ :
sig
  val extend_i8_s : I8.t -> I32.t
  val extend_i8_u : I8.t -> I32.t
  val extend_i16_s : I16.t -> I32.t
  val extend_i16_u : I16.t -> I32.t
  val wrap_i64 : I64.t -> I32.t
  val narrow_sat_i64_s : I64.t -> I32.t
  val narrow_sat_i64_u : I64.t -> I32.t
  val trunc_f32_s : F32.t -> I32.t
  val trunc_f32_u : F32.t -> I32.t
  val trunc_f64_s : F64.t -> I32.t
  val trunc_f64_u : F64.t -> I32.t
  val trunc_sat_f32_s : F32.t -> I32.t
  val trunc_sat_f32_u : F32.t -> I32.t
  val trunc_sat_f64_s : F64.t -> I32.t
  val trunc_sat_f64_u : F64.t -> I32.t
  val reinterpret_f32 : F32.t -> I32.t
end

module I64_ :
sig
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
end

module F32_ :
sig
  val demote_f64 : F64.t -> F32.t
  val convert_i32_s : I32.t -> F32.t
  val convert_i32_u : I32.t -> F32.t
  val convert_i64_s : I64.t -> F32.t
  val convert_i64_u : I64.t -> F32.t
  val reinterpret_i32 : I32.t -> F32.t
end

module F64_ :
sig
  val promote_f32 : F32.t -> F64.t
  val convert_i32_s : I32.t -> F64.t
  val convert_i32_u : I32.t -> F64.t
  val convert_i64_s : I64.t -> F64.t
  val convert_i64_u : I64.t -> F64.t
  val reinterpret_i64 : I64.t -> F64.t
end
