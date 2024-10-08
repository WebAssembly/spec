(* Types *)

type t
type bits = string

type ('i8x16, 'i16x8, 'i32x4, 'i64x2, 'f32x4, 'f64x2) laneop =
  | I8x16 of 'i8x16 | I16x8 of 'i16x8 | I32x4 of 'i32x4 | I64x2 of 'i64x2
  | F32x4 of 'f32x4 | F64x2 of 'f64x2

type shape = (unit, unit, unit, unit, unit, unit) laneop


(* Basics *)

val bitwidth : int

val num_lanes : ('a, 'b, 'c, 'd, 'e, 'f) laneop -> int
val type_of_lane : ('a, 'b, 'c, 'd, 'e, 'f) laneop -> Types.num_type
val string_of_shape : ('a, 'b, 'c, 'd, 'e, 'f) laneop -> string

val zero : t
val of_bits : bits -> t
val to_bits : t -> bits


(* String conversion *)

val to_string : t -> string
val to_hex_string : t -> string
val of_strings : shape -> string list -> t


(* Shape-based operations *)

module type IntShape =
sig
  type lane

  val num_lanes : int
  val to_lanes : t -> lane list
  val of_lanes : lane list -> t

  val splat : lane -> t
  val extract_lane_s : int -> t -> lane
  val extract_lane_u : int -> t -> lane
  val replace_lane : int -> t -> lane -> t

  val eq : t -> t -> t
  val ne : t -> t -> t
  val lt_s : t -> t -> t
  val lt_u : t -> t -> t
  val le_s : t -> t -> t
  val le_u : t -> t -> t
  val gt_s : t -> t -> t
  val gt_u : t -> t -> t
  val ge_s : t -> t -> t
  val ge_u : t -> t -> t
  val abs : t -> t
  val neg : t -> t
  val popcnt : t -> t
  val add : t -> t -> t
  val sub : t -> t -> t
  val min_s : t -> t -> t
  val min_u : t -> t -> t
  val max_s : t -> t -> t
  val max_u : t -> t -> t
  val mul : t -> t -> t
  val avgr_u : t -> t -> t
  val any_true : t -> bool
  val all_true : t -> bool
  val bitmask : t -> Int32.t
  val shl : t -> I32.t -> t
  val shr_s : t -> I32.t -> t
  val shr_u : t -> I32.t -> t
  val add_sat_s : t -> t -> t
  val add_sat_u : t -> t -> t
  val sub_sat_s : t -> t -> t
  val sub_sat_u : t -> t -> t
  val q15mulr_sat_s : t -> t -> t
end

module type FloatShape =
sig
  type lane

  val num_lanes : int
  val to_lanes : t -> lane list
  val of_lanes : lane list -> t

  val splat : lane -> t
  val extract_lane : int -> t -> lane
  val replace_lane : int -> t -> lane -> t

  val eq : t -> t -> t
  val ne : t -> t -> t
  val lt : t -> t -> t
  val le : t -> t -> t
  val gt : t -> t -> t
  val ge : t -> t -> t
  val abs : t -> t
  val neg : t -> t
  val sqrt : t -> t
  val ceil : t -> t
  val floor : t -> t
  val trunc : t -> t
  val nearest : t -> t
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t
  val fma : t -> t -> t -> t
  val fnma : t -> t -> t -> t
  val min : t -> t -> t
  val max : t -> t -> t
  val pmin : t -> t -> t
  val pmax : t -> t -> t
end

module I8x16 : IntShape with type lane = I8.t
module I16x8 : IntShape with type lane = I16.t
module I32x4 : IntShape with type lane = I32.t
module I64x2 : IntShape with type lane = I64.t
module F32x4 : FloatShape with type lane = F32.t
module F64x2 : FloatShape with type lane = F64.t


(* Special shapes *)

module V1x128 :
sig
  val lognot : t -> t
  val and_ : t -> t -> t
  val or_ : t -> t -> t
  val xor : t -> t -> t
  val andnot : t -> t -> t
  val bitselect : t -> t -> t -> t
end

module V8x16 :
sig
  val swizzle : t -> t -> t
  val shuffle : t -> t -> int list -> t
end


(* Conversions *)

module I8x16_convert :
sig
  val narrow_s : t -> t -> t
  val narrow_u : t -> t -> t
end

module I16x8_convert :
sig
  val narrow_s : t -> t -> t
  val narrow_u : t -> t -> t
  val extend_low_s : t -> t
  val extend_high_s : t -> t
  val extend_low_u : t -> t
  val extend_high_u : t -> t
  val extmul_low_s : t -> t -> t
  val extmul_high_s : t -> t -> t
  val extmul_low_u : t -> t -> t
  val extmul_high_u : t -> t -> t
  val extadd_pairwise_s : t -> t
  val extadd_pairwise_u : t -> t
  val dot_s : t -> t -> t
end

module I32x4_convert :
sig
  val trunc_sat_f32x4_s : t -> t
  val trunc_sat_f32x4_u : t -> t
  val trunc_sat_f64x2_s_zero : t -> t
  val trunc_sat_f64x2_u_zero : t -> t
  val extend_low_s : t -> t
  val extend_high_s : t -> t
  val extend_low_u : t -> t
  val extend_high_u : t -> t
  val dot_s : t -> t -> t
  val dot_s_accum : t -> t -> t -> t
  val extmul_low_s : t -> t -> t
  val extmul_high_s : t -> t -> t
  val extmul_low_u : t -> t -> t
  val extmul_high_u : t -> t -> t
  val extadd_pairwise_s : t -> t
  val extadd_pairwise_u : t -> t
end

module I64x2_convert :
sig
  val extend_low_s : t -> t
  val extend_high_s : t -> t
  val extend_low_u : t -> t
  val extend_high_u : t -> t
  val extmul_low_s : t -> t -> t
  val extmul_high_s : t -> t -> t
  val extmul_low_u : t -> t -> t
  val extmul_high_u : t -> t -> t
end

module F32x4_convert :
sig
  val convert_i32x4_s : t -> t
  val convert_i32x4_u : t -> t
  val demote_f64x2_zero : t -> t
end

module F64x2_convert :
sig
  val promote_low_f32x4 : t -> t
  val convert_i32x4_s : t -> t
  val convert_i32x4_u : t -> t
end
