(* Types *)

type t = string
type bits = string

type ('i8x16, 'i16x8, 'i32x4, 'i64x2, 'f32x4, 'f64x2) laneop =
  | I8x16 of 'i8x16 | I16x8 of 'i16x8 | I32x4 of 'i32x4 | I64x2 of 'i64x2
  | F32x4 of 'f32x4 | F64x2 of 'f64x2

type shape = (unit, unit, unit, unit, unit, unit) laneop


(* Basics *)

let bitwidth = 128
let bytewidth = bitwidth / 8

let zero = String.make bytewidth '\x00'
let of_bits x = x
let to_bits x = x

let num_lanes shape =
  match shape with
  | I8x16 _ -> 16
  | I16x8 _ -> 8
  | I32x4 _ -> 4
  | I64x2 _ -> 2
  | F32x4 _ -> 4
  | F64x2 _ -> 2

let type_of_lane = function
  | I8x16 _ | I16x8 _ | I32x4 _ -> Types.I32T
  | I64x2 _ -> Types.I64T
  | F32x4 _ -> Types.F32T
  | F64x2 _ -> Types.F64T


(* Shape-based operations *)

module Convert (Lane : sig type t end) =
struct
  module type S =
  sig
    val shape : shape
    val to_lanes : t -> Lane.t list
    val of_lanes : Lane.t list -> t
  end
end

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

module MakeIntShape (IXX : Ixx.S) (Cvt : Convert(IXX).S) :
  IntShape with type lane = IXX.t =
struct
  type lane = IXX.t

  let num_lanes = num_lanes Cvt.shape
  let of_lanes = Cvt.of_lanes
  let to_lanes = Cvt.to_lanes

  let unop f x = of_lanes (List.map f (to_lanes x))
  let unopi f x = of_lanes (List.mapi f (to_lanes x))
  let binop f x y = of_lanes (List.map2 f (to_lanes x) (to_lanes y))
  let reduceop f a s = List.fold_left (fun a b -> f a (b <> IXX.zero)) a (to_lanes s)
  let cmp f x y = if f x y then IXX.of_int_s (-1) else IXX.zero

  let splat x = of_lanes (List.init num_lanes (fun i -> x))
  let extract_lane_s i s = List.nth (to_lanes s) i
  let extract_lane_u i s = IXX.as_unsigned (extract_lane_s i s)
  let replace_lane i v x = unopi (fun j y -> if j = i then x else y) v

  let eq = binop (cmp IXX.eq)
  let ne = binop (cmp IXX.ne)
  let lt_s = binop (cmp IXX.lt_s)
  let lt_u = binop (cmp IXX.lt_u)
  let le_s = binop (cmp IXX.le_s)
  let le_u = binop (cmp IXX.le_u)
  let gt_s = binop (cmp IXX.gt_s)
  let gt_u = binop (cmp IXX.gt_u)
  let ge_s = binop (cmp IXX.ge_s)
  let ge_u = binop (cmp IXX.ge_u)
  let abs = unop IXX.abs
  let neg = unop IXX.neg
  let popcnt = unop IXX.popcnt
  let add = binop IXX.add
  let sub = binop IXX.sub
  let mul = binop IXX.mul
  let choose f x y = if f x y then x else y
  let min_s = binop (choose IXX.le_s)
  let min_u = binop (choose IXX.le_u)
  let max_s = binop (choose IXX.ge_s)
  let max_u = binop (choose IXX.ge_u)
  (* The result of avgr_u will not overflow this type, but the intermediate might,
   * so have the Int type implement it so they can extend it accordingly *)
  let avgr_u = binop IXX.avgr_u
  let any_true = reduceop (||) false
  let all_true = reduceop (&&) true
  (* Extract top bits using signed-comparision with zero *)
  let bitmask x =
    let xs = to_lanes x in
    let negs = List.map (fun x -> if IXX.(lt_s x zero) then Int32.one else Int32.zero) xs in
    List.fold_right (fun a b -> Int32.(logor a (shift_left b 1))) negs Int32.zero
  let shl v s =
    let shift = IXX.of_int_u (Int32.to_int s) in
    unop (fun a -> IXX.shl a shift) v
  let shr_s v s =
    let shift = IXX.of_int_u (Int32.to_int s) in
    unop (fun a -> IXX.shr_s a shift) v
  let shr_u v s =
    let shift = IXX.of_int_u (Int32.to_int s) in
    unop (fun a -> IXX.shr_u a shift) v
  let add_sat_s = binop IXX.add_sat_s
  let add_sat_u = binop IXX.add_sat_u
  let sub_sat_s = binop IXX.sub_sat_s
  let sub_sat_u = binop IXX.sub_sat_u
  (* The intermediate will overflow lane.t, so have Int implement this. *)
  let q15mulr_sat_s = binop IXX.q15mulr_sat_s
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
  val min : t -> t -> t
  val max : t -> t -> t
  val pmin : t -> t -> t
  val pmax : t -> t -> t
end

module MakeFloatShape (FXX : Fxx.S) (Cvt : Convert(FXX).S) :
  FloatShape with type lane = FXX.t =
struct
  type lane = FXX.t

  let num_lanes = num_lanes Cvt.shape
  let of_lanes = Cvt.of_lanes
  let to_lanes = Cvt.to_lanes

  let unop f x = of_lanes (List.map f (to_lanes x))
  let unopi f x = of_lanes (List.mapi f (to_lanes x))
  let binop f x y = of_lanes (List.map2 f (to_lanes x) (to_lanes y))
  let all_ones = FXX.of_float (Int64.float_of_bits (Int64.minus_one))
  let cmp f x y = if f x y then all_ones else FXX.zero

  let splat x = of_lanes (List.init num_lanes (fun i -> x))
  let extract_lane i s = List.nth (to_lanes s) i
  let replace_lane i v x = unopi (fun j y -> if j = i then x else y) v

  let eq = binop (cmp FXX.eq)
  let ne = binop (cmp FXX.ne)
  let lt = binop (cmp FXX.lt)
  let le = binop (cmp FXX.le)
  let gt = binop (cmp FXX.gt)
  let ge = binop (cmp FXX.ge)
  let abs = unop FXX.abs
  let neg = unop FXX.neg
  let sqrt = unop FXX.sqrt
  let ceil = unop FXX.ceil
  let floor = unop FXX.floor
  let trunc = unop FXX.trunc
  let nearest = unop FXX.nearest
  let add = binop FXX.add
  let sub = binop FXX.sub
  let mul = binop FXX.mul
  let div = binop FXX.div
  let min = binop FXX.min
  let max = binop FXX.max
  let pmin = binop (fun x y -> if FXX.lt y x then y else x)
  let pmax = binop (fun x y -> if FXX.lt x y then y else x)
end

module I8x16 = MakeIntShape (I8)
  (struct
    let shape = I8x16 ()
    let to_lanes s =
      List.init 16 (fun i -> Int32.of_int (Bytes.get_int8 (Bytes.of_string s) i))
    let of_lanes fs =
      assert (List.length fs = 16);
      let b = Bytes.create bytewidth in
      List.iteri (fun i f -> Bytes.set_int8 b i (Int32.to_int f)) fs;
      Bytes.to_string b
  end)

module I16x8 = MakeIntShape (I16)
  (struct
    let shape = I16x8 ()
    let to_lanes s =
      List.init 8 (fun i -> Int32.of_int (Bytes.get_int16_le (Bytes.of_string s) (i*2)))
    let of_lanes fs =
      assert (List.length fs = 8);
      let b = Bytes.create bytewidth in
      List.iteri (fun i f -> Bytes.set_int16_le b (i*2) (Int32.to_int f)) fs;
      Bytes.to_string b
  end)

module I32x4 = MakeIntShape (I32)
  (struct
    let shape = I32x4 ()
    let to_lanes s =
      List.init 4 (fun i -> I32.of_bits (Bytes.get_int32_le (Bytes.of_string s) (i*4)))
    let of_lanes fs =
      assert (List.length fs = 4);
      let b = Bytes.create bytewidth in
      List.iteri (fun i f -> Bytes.set_int32_le b (i*4) (I32.to_bits f)) fs;
      Bytes.to_string b
  end)

module I64x2 = MakeIntShape (I64)
  (struct
    let shape = I64x2 ()
    let to_lanes s =
      List.init 2 (fun i -> I64.of_bits (Bytes.get_int64_le (Bytes.of_string s) (i*8)))
    let of_lanes fs =
      assert (List.length fs = 2);
      let b = Bytes.create bytewidth in
      List.iteri (fun i f -> Bytes.set_int64_le b (i*8) (I64.to_bits f)) fs;
      Bytes.to_string b
  end)

module F32x4 = MakeFloatShape (F32)
  (struct
    let shape = F32x4 ()
    let to_lanes s =
      List.init 4 (fun i -> F32.of_bits (Bytes.get_int32_le (Bytes.of_string s) (i*4)))
    let of_lanes fs =
      assert (List.length fs = 4);
      let b = Bytes.create bytewidth in
      List.iteri (fun i f -> Bytes.set_int32_le b (i*4) (F32.to_bits f)) fs;
      Bytes.to_string b
  end)

module F64x2 = MakeFloatShape (F64)
  (struct
    let shape = F64x2 ()
    let to_lanes s =
      List.init 2 (fun i -> F64.of_bits (Bytes.get_int64_le (Bytes.of_string s) (i*8)))
    let of_lanes fs =
      assert (List.length fs = 2);
      let b = Bytes.create bytewidth in
      List.iteri (fun i f -> Bytes.set_int64_le b (i*8) (F64.to_bits f)) fs;
      Bytes.to_string b
  end)


(* Special shapes *)

module V1x128 =
struct
  let unop f x = I64x2.of_lanes (List.map f (I64x2.to_lanes x))
  let binop f x y =
    I64x2.of_lanes (List.map2 f (I64x2.to_lanes x) (I64x2.to_lanes y))

  let lognot = unop I64.lognot
  let and_ = binop I64.and_
  let or_ = binop I64.or_
  let xor = binop I64.xor
  let andnot = binop (fun x y -> I64.and_ x (I64.lognot y))

  let bitselect v1 v2 c =
    let v2_andnot_c = andnot v2 c in
    let v1_and_c = binop I64.and_ v1 c in
    binop I64.or_ v1_and_c v2_andnot_c
end

module V8x16 =
struct
  let swizzle v1 v2 =
    let ns = I8x16.to_lanes v1 in
    let is = I8x16.to_lanes v2 in
    let select i =
      Option.value (List.nth_opt ns (I32.to_int_u i)) ~default: I32.zero
    in I8x16.of_lanes (List.map select is)

  let shuffle v1 v2 is =
    let ns = I8x16.to_lanes v1 @ I8x16.to_lanes v2 in
    I8x16.of_lanes (List.map (List.nth ns) is)
end


(* Conversions *)

let narrow to_lanes of_lanes sat_op x y =
  let xy = to_lanes x @ to_lanes y in
  of_lanes (List.map sat_op xy)

module I8x16_convert =
struct
  let narrow_s = narrow I16x8.to_lanes I8x16.of_lanes I8.saturate_s
  let narrow_u = narrow I16x8.to_lanes I8x16.of_lanes I8.saturate_u
end

module I16x8_convert =
struct
  let narrow_s = narrow I32x4.to_lanes I16x8.of_lanes I16.saturate_s
  let narrow_u = narrow I32x4.to_lanes I16x8.of_lanes I16.saturate_u

  let ext_s = Int32.logand 0xffffffffl
  let ext_u = Int32.logand 0xffl

  let extend take_or_drop ext x =
    I16x8.of_lanes (List.map ext (take_or_drop 8 (I8x16.to_lanes x)))
  let extend_low_s = extend Lib.List.take ext_s
  let extend_high_s = extend Lib.List.drop ext_s
  let extend_low_u = extend Lib.List.take ext_u
  let extend_high_u = extend Lib.List.drop ext_u

  let extmul_low_s x y = I16x8.mul (extend_low_s x) (extend_low_s y)
  let extmul_high_s x y = I16x8.mul (extend_high_s x) (extend_high_s y)
  let extmul_low_u x y = I16x8.mul (extend_low_u x) (extend_low_u y)
  let extmul_high_u x y = I16x8.mul (extend_high_u x) (extend_high_u y)

  let extadd ext x y = Int32.add (ext x) (ext y)
  let extadd_pairwise_s x =
    I16x8.of_lanes (Lib.List.pairwise (extadd ext_s) (I8x16.to_lanes x))
  let extadd_pairwise_u x =
    I16x8.of_lanes (Lib.List.pairwise (extadd ext_u) (I8x16.to_lanes x))
end

module I32x4_convert =
struct
  let convert f v = I32x4.of_lanes (List.map f (F32x4.to_lanes v))
  let trunc_sat_f32x4_s = convert I32_convert.trunc_sat_f32_s
  let trunc_sat_f32x4_u = convert I32_convert.trunc_sat_f32_u

  let convert_zero f v =
    I32x4.of_lanes (List.map f (F64x2.to_lanes v) @ I32.[zero; zero])
  let trunc_sat_f64x2_s_zero = convert_zero I32_convert.trunc_sat_f64_s
  let trunc_sat_f64x2_u_zero = convert_zero I32_convert.trunc_sat_f64_u

  let ext_s = Int32.logand 0xffffffffl
  let ext_u = Int32.logand 0xffffl

  let extend take_or_drop ext x =
    I32x4.of_lanes (List.map ext (take_or_drop 4 (I16x8.to_lanes x)))
  let extend_low_s = extend Lib.List.take ext_s
  let extend_high_s = extend Lib.List.drop ext_s
  let extend_low_u = extend Lib.List.take ext_u
  let extend_high_u = extend Lib.List.drop ext_u

  let dot_s x y =
    let xs = I16x8.to_lanes x in
    let ys = I16x8.to_lanes y in
    let rec dot xs ys =
      match xs, ys with
      | x1::x2::xss, y1::y2::yss ->
        Int32.(add (mul x1 y1) (mul x2 y2)) :: dot xss yss
      | [], [] -> []
      | _, _ -> assert false
    in I32x4.of_lanes (dot xs ys)

  let extmul_low_s x y = I32x4.mul (extend_low_s x) (extend_low_s y)
  let extmul_high_s x y = I32x4.mul (extend_high_s x) (extend_high_s y)
  let extmul_low_u x y = I32x4.mul (extend_low_u x) (extend_low_u y)
  let extmul_high_u x y = I32x4.mul (extend_high_u x) (extend_high_u y)

  let extadd ext x y = Int32.add (ext x) (ext y)
  let extadd_pairwise_s x =
    I32x4.of_lanes (Lib.List.pairwise (extadd ext_s) (I16x8.to_lanes x))
  let extadd_pairwise_u x =
    I32x4.of_lanes (Lib.List.pairwise (extadd ext_u) (I16x8.to_lanes x))
end

module I64x2_convert =
struct
  let ext_s = Int64.logand 0xffffffffffffffffL
  let ext_u = Int64.logand 0xffffffffL

  let extend take_or_drop ext x =
    I64x2.of_lanes
      (List.map
        (fun i32 -> ext (Int64.of_int32 i32))
        (take_or_drop 2 (I32x4.to_lanes x)))
  let extend_low_s = extend Lib.List.take ext_s
  let extend_high_s = extend Lib.List.drop ext_s
  let extend_low_u = extend Lib.List.take ext_u
  let extend_high_u = extend Lib.List.drop ext_u

  let extmul_low_s x y = I64x2.mul (extend_low_s x) (extend_low_s y)
  let extmul_high_s x y = I64x2.mul (extend_high_s x) (extend_high_s y)
  let extmul_low_u x y = I64x2.mul (extend_low_u x) (extend_low_u y)
  let extmul_high_u x y = I64x2.mul (extend_high_u x) (extend_high_u y)
end

module F32x4_convert =
struct
  let convert f v = F32x4.of_lanes (List.map f (I32x4.to_lanes v))
  let convert_i32x4_s = convert F32_convert.convert_i32_s
  let convert_i32x4_u = convert F32_convert.convert_i32_u
  let demote_f64x2_zero v =
    F32x4.of_lanes
      (List.map F32_convert.demote_f64 (F64x2.to_lanes v) @ F32.[zero; zero])
end

module F64x2_convert =
struct
  let convert f v =
    F64x2.of_lanes (List.map f (Lib.List.take 2 (I32x4.to_lanes v)))
  let convert_i32x4_s = convert F64_convert.convert_i32_s
  let convert_i32x4_u = convert F64_convert.convert_i32_u
  let promote_low_f32x4 v =
    F64x2.of_lanes
      (List.map F64_convert.promote_f32 (Lib.List.take 2 (F32x4.to_lanes v)))
end


(* String conversion *)

let to_string s =
  String.concat " " (List.map I32.to_string_s (I32x4.to_lanes s))

let to_hex_string s =
  String.concat " " (List.map I32.to_hex_string (I32x4.to_lanes s))

let of_strings shape ss =
  if List.length ss <> num_lanes shape then
    invalid_arg "wrong length";
  let open Bytes in
  let b = create bytewidth in
  (match shape with
  | I8x16 () ->
    List.iteri (fun i s -> set_uint8 b i (I8.to_int_u (I8.of_string s))) ss
  | I16x8 () ->
    List.iteri (fun i s -> set_int16_le b (i * 2) (I16.to_int_u (I16.of_string s))) ss
  | I32x4 () ->
    List.iteri (fun i s -> set_int32_le b (i * 4) (I32.of_string s)) ss
  | I64x2 () ->
    List.iteri (fun i s -> set_int64_le b (i * 8) (I64.of_string s)) ss
  | F32x4 () ->
    List.iteri (fun i s -> set_int32_le b (i * 4) (F32.to_bits (F32.of_string s))) ss
  | F64x2 () ->
    List.iteri (fun i s -> set_int64_le b (i * 8) (F64.to_bits (F64.of_string s))) ss
  );
  to_string b


let string_of_shape = function
  | I8x16 _ -> "i8x16"
  | I16x8 _ -> "i16x8"
  | I32x4 _ -> "i32x4"
  | I64x2 _ -> "i64x2"
  | F32x4 _ -> "f32x4"
  | F64x2 _ -> "f64x2"
