open Char

type shape = I8x16 | I16x8 | I32x4 | I64x2 | F32x4 | F64x2

let lanes shape =
  match shape with
  | I8x16 -> 16
  | I16x8 -> 8
  | I32x4 -> 4
  | I64x2 -> 2
  | F32x4 -> 4
  | F64x2 -> 2

let string_of_shape = function
  | I8x16 -> "i8x16"
  | I16x8 -> "i16x8"
  | I32x4 -> "i32x4"
  | I64x2 -> "i64x2"
  | F32x4 -> "f32x4"
  | F64x2 -> "f64x2"

module type RepType =
sig
  type t

  val make : int -> char -> t
  (* ^ bits_make ? *)
  val to_string : t -> string
  val to_hex_string : t -> string
  val bytewidth : int
  val of_strings : shape -> string list -> t

  val to_i8x16 : t -> I8.t list
  val of_i8x16 : I8.t list -> t

  val to_i16x8 : t -> I16.t list
  val of_i16x8 : I16.t list -> t

  val to_i32x4 : t -> I32.t list
  val of_i32x4 : I32.t list -> t

  val to_i64x2 : t -> I64.t list
  val of_i64x2 : I64.t list -> t

  val to_f32x4 : t -> F32.t list
  val of_f32x4 : F32.t list -> t

  val to_f64x2 : t -> F64.t list
  val of_f64x2 : F64.t list -> t
end

(* This signature defines the types and operations SIMD ints can expose. *)
module type Int =
sig
  type t
  type lane

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

(* This signature defines the types and operations SIMD floats can expose. *)
module type Float =
sig
  type t
  type lane

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

module type Vec =
sig
  type t

  val lognot : t -> t
  val and_ : t -> t -> t
  val or_ : t -> t -> t
  val xor : t -> t -> t
  val andnot : t -> t -> t
  val bitselect : t -> t -> t -> t
end

module type S =
sig
  type t
  type bits
  val default : t (* FIXME good name for default value? *)
  val to_string : t -> string
  val to_hex_string : t -> string
  val of_bits : bits -> t
  val to_bits : t -> bits
  val of_strings : shape -> string list -> t
  val to_i16x8 : t -> I16.t list
  val to_i32x4 : t -> I32.t list

  val of_i8x16 : I32.t list -> t
  val of_i16x8 : I32.t list -> t
  val of_i32x4 : I32.t list -> t
  val of_i64x2 : I64.t list -> t

  (* We need type t = t to ensure that all submodule types are S.t,
   * then callers don't have to change *)
  module I8x16 : Int with type t = t and type lane = I8.t
  module I16x8 : Int with type t = t and type lane = I16.t
  module I32x4 : Int with type t = t and type lane = I32.t
  module I64x2 : Int with type t = t and type lane = I64.t
  module F32x4 : Float with type t = t and type lane = F32.t
  module F64x2 : Float with type t = t and type lane = F64.t
  module V128 : Vec with type t = t
  module V8x16 : sig
    val swizzle : t -> t -> t
    val shuffle : t -> t -> int list -> t
  end
  module I8x16_convert : sig
    val narrow_s : t -> t -> t
    val narrow_u : t -> t -> t
  end
  module I16x8_convert : sig
    val narrow_s : t -> t -> t
    val narrow_u : t -> t -> t
    val widen_low_s : t -> t
    val widen_high_s : t -> t
    val widen_low_u : t -> t
    val widen_high_u : t -> t
    val extmul_low_s : t -> t -> t
    val extmul_high_s : t -> t -> t
    val extmul_low_u : t -> t -> t
    val extmul_high_u : t -> t -> t
  end
  module I32x4_convert : sig
    val trunc_sat_f32x4_s : t -> t
    val trunc_sat_f32x4_u : t -> t
    val trunc_sat_f64x2_s_zero : t -> t
    val trunc_sat_f64x2_u_zero : t -> t
    val widen_low_s : t -> t
    val widen_high_s : t -> t
    val widen_low_u : t -> t
    val widen_high_u : t -> t
    val dot_i16x8_s : t -> t -> t
    val extmul_low_s : t -> t -> t
    val extmul_high_s : t -> t -> t
    val extmul_low_u : t -> t -> t
    val extmul_high_u : t -> t -> t
  end
  module I64x2_convert : sig
    val widen_low_s : t -> t
    val widen_high_s : t -> t
    val widen_low_u : t -> t
    val widen_high_u : t -> t
    val extmul_low_s : t -> t -> t
    val extmul_high_s : t -> t -> t
    val extmul_low_u : t -> t -> t
    val extmul_high_u : t -> t -> t
  end
  module F32x4_convert : sig
    val convert_i32x4_s : t -> t
    val convert_i32x4_u : t -> t
    val demote_f64x2_zero : t -> t
  end

  module F64x2_convert : sig
    val promote_low_f32x4 : t -> t
    val convert_i32x4_s : t -> t
    val convert_i32x4_u : t -> t
  end
end

module Make (Rep : RepType) : S with type bits = Rep.t =
struct
  type t = Rep.t
  type bits = Rep.t

  let default = Rep.make Rep.bytewidth (chr 0)
  let to_string = Rep.to_string (* FIXME very very wrong *)
  let to_hex_string = Rep.to_hex_string
  let of_bits x = x
  let to_bits x = x
  let of_strings = Rep.of_strings
  let to_i16x8 = Rep.to_i16x8
  let to_i32x4 = Rep.to_i32x4

  let of_i8x16 = Rep.of_i8x16
  let of_i16x8 = Rep.of_i16x8
  let of_i32x4 = Rep.of_i32x4
  let of_i64x2 = Rep.of_i64x2

  module V128 : Vec with type t = Rep.t = struct
    type t = Rep.t
    let to_shape = Rep.to_i64x2
    let of_shape = Rep.of_i64x2
    let unop f x = of_shape (List.map f (to_shape x))
    let binop f x y = of_shape (List.map2 f (to_shape x) (to_shape y))
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


  module MakeFloat (Float : Float.S) (Convert : sig
      val to_shape : Rep.t -> Float.t list
      val of_shape : Float.t list -> Rep.t
      val num_lanes : int
    end) : Float with type t = Rep.t and type lane = Float.t =
  struct
    type t = Rep.t
    type lane = Float.t
    let unop f x = Convert.of_shape (List.map f (Convert.to_shape x))
    let unopi f x = Convert.of_shape (List.mapi f (Convert.to_shape x))
    let binop f x y = Convert.of_shape (List.map2 f (Convert.to_shape x) (Convert.to_shape y))

    let splat x = Convert.of_shape (List.init Convert.num_lanes (fun i -> x))
    let extract_lane i s = List.nth (Convert.to_shape s) i
    let replace_lane i v x = unopi (fun j y -> if j = i then x else y) v

    let all_ones = Float.of_float (Int64.float_of_bits (Int64.minus_one))
    let cmp f x y = if f x y then all_ones else Float.zero
    let eq = binop (cmp Float.eq)
    let ne = binop (cmp Float.ne)
    let lt = binop (cmp Float.lt)
    let le = binop (cmp Float.le)
    let gt = binop (cmp Float.gt)
    let ge = binop (cmp Float.ge)
    let abs = unop Float.abs
    let neg = unop Float.neg
    let sqrt = unop Float.sqrt
    let ceil = unop Float.ceil
    let floor = unop Float.floor
    let trunc = unop Float.trunc
    let nearest = unop Float.nearest
    let add = binop Float.add
    let sub = binop Float.sub
    let mul = binop Float.mul
    let div = binop Float.div
    let min = binop Float.min
    let max = binop Float.max
    let pmin = binop (fun x y -> if Float.lt y x then y else x)
    let pmax = binop (fun x y -> if Float.lt x y then y else x)
  end

  module MakeInt (Int : Int.S) (Convert : sig
      val to_shape : Rep.t -> Int.t list
      val of_shape : Int.t list -> Rep.t
      val num_lanes : int
    end) : Int with type t = Rep.t and type lane = Int.t =
  struct
    type t = Rep.t
    type lane = Int.t
    let unop f x = Convert.of_shape (List.map f (Convert.to_shape x))
    let unopi f x = Convert.of_shape (List.mapi f (Convert.to_shape x))
    let binop f x y = Convert.of_shape (List.map2 f (Convert.to_shape x) (Convert.to_shape y))

    let splat x = Convert.of_shape (List.init Convert.num_lanes (fun i -> x))
    let extract_lane_s i s = List.nth (Convert.to_shape s) i
    let extract_lane_u i s = Int.as_unsigned (extract_lane_s i s)
    let replace_lane i v x = unopi (fun j y -> if j = i then x else y) v

    let cmp f x y = if f x y then (Int.of_int_s (-1)) else Int.zero
    let eq = binop (cmp Int.eq)
    let ne = binop (cmp Int.ne)
    let lt_s = binop (cmp Int.lt_s)
    let lt_u = binop (cmp Int.lt_u)
    let le_s = binop (cmp Int.le_s)
    let le_u = binop (cmp Int.le_u)
    let gt_s = binop (cmp Int.gt_s)
    let gt_u = binop (cmp Int.gt_u)
    let ge_s = binop (cmp Int.ge_s)
    let ge_u = binop (cmp Int.ge_u)
    let abs = unop Int.abs
    let neg = unop Int.neg
    let popcnt = unop Int.popcnt
    let add = binop Int.add
    let sub = binop Int.sub
    let mul = binop Int.mul
    let choose f x y = if f x y then x else y
    let min_s = binop (choose Int.le_s)
    let min_u = binop (choose Int.le_u)
    let max_s = binop (choose Int.ge_s)
    let max_u = binop (choose Int.ge_u)
    (* The result of avgr_u will not overflow this type, but the intermediate might,
     * so have the Int type implement it so they can extend it accordingly *)
    let avgr_u = binop Int.avgr_u
    let reduceop f a s = List.fold_left (fun a b -> f a (b <> Int.zero)) a (Convert.to_shape s)
    let any_true = reduceop (||) false
    let all_true = reduceop (&&) true
    (* Extract top bits using signed-comparision with zero *)
    let bitmask x =
      let xs = Convert.to_shape x in
      let negs = List.map (fun x -> if Int.(lt_s x zero) then Int32.one else Int32.zero) xs in
      List.fold_right (fun a b -> Int32.(logor a (shift_left b 1))) negs Int32.zero
    let shl v s =
      let shift = Int.of_int_u (Int32.to_int s) in
      unop (fun a -> Int.shl a shift) v
    let shr_s v s =
      let shift = Int.of_int_u (Int32.to_int s) in
      unop (fun a -> Int.shr_s a shift) v
    let shr_u v s =
      let shift = Int.of_int_u (Int32.to_int s) in
      unop (fun a -> Int.shr_u a shift) v
    let add_sat_s = binop Int.add_sat_s
    let add_sat_u = binop Int.add_sat_u
    let sub_sat_s = binop Int.sub_sat_s
    let sub_sat_u = binop Int.sub_sat_u
    (* The intermediate will overflow lane.t, so have Int implement this. *)
    let q15mulr_sat_s = binop Int.q15mulr_sat_s
  end

  module V8x16 = struct
    let swizzle value index =
      let vs = Rep.to_i8x16 value in
      let is = Rep.to_i8x16 index in
      let select i =
        Option.(
          value
            (bind (Int32.unsigned_to_int i) (List.nth_opt vs))
            ~default:Int32.zero)
      in
      Rep.of_i8x16 (List.map select is)
    let shuffle x y imms =
      let xs = Rep.to_i8x16 x in
      let ys = Rep.to_i8x16 y in
      let joined = List.append xs ys in
      let result = List.map (fun i -> List.nth joined i) imms in
      Rep.of_i8x16 result
  end

  module I8x16 = MakeInt (I8) (struct
      let to_shape = Rep.to_i8x16
      let of_shape = Rep.of_i8x16
      let num_lanes = lanes I8x16
    end)

  module I16x8 = MakeInt (I16) (struct
      let to_shape = Rep.to_i16x8
      let of_shape = Rep.of_i16x8
      let num_lanes = lanes I16x8
    end)

  module I32x4 = MakeInt (I32) (struct
      let to_shape = Rep.to_i32x4
      let of_shape = Rep.of_i32x4
      let num_lanes = lanes I32x4
    end)

  module I64x2 = MakeInt (I64) (struct
      let to_shape = Rep.to_i64x2
      let of_shape = Rep.of_i64x2
      let num_lanes = lanes I64x2
    end)

  module F32x4 = MakeFloat (F32) (struct
      let to_shape = Rep.to_f32x4
      let of_shape = Rep.of_f32x4
      let num_lanes = lanes F32x4
    end)

  module F64x2 = MakeFloat (F64) (struct
      let to_shape = Rep.to_f64x2
      let of_shape = Rep.of_f64x2
      let num_lanes = lanes F64x2
    end)

  (* Narrow two v128 into one v128 by using to_shape on both operands,
   * concatenating them, saturating the wider type to the narrower type,
   * then of_shape to reconstruct a v128. *)
  let narrow to_shape of_shape sat_op x y =
    let xy = (to_shape x) @ (to_shape y) in
    of_shape (List.map sat_op xy)

  module I8x16_convert = struct
    let narrow_s = narrow Rep.to_i16x8 Rep.of_i8x16 I8.saturate_s
    let narrow_u = narrow Rep.to_i16x8 Rep.of_i8x16 I8.saturate_u
  end

  module I16x8_convert = struct
    let narrow_s = narrow Rep.to_i32x4 Rep.of_i16x8 I16.saturate_s
    let narrow_u = narrow Rep.to_i32x4 Rep.of_i16x8 I16.saturate_u

    let widen take_or_drop mask x =
      Rep.of_i16x8 (List.map (Int32.logand mask) (take_or_drop 8 (Rep.to_i8x16 x)))
    let widen_low_s = widen Lib.List.take 0xffffffffl
    let widen_high_s = widen Lib.List.drop 0xffffffffl
    let widen_low_u = widen Lib.List.take 0xffl
    let widen_high_u = widen Lib.List.drop 0xffl

    let extmul_low_s x y = I16x8.mul (widen_low_s x) (widen_low_s y)
    let extmul_high_s x y = I16x8.mul (widen_high_s x) (widen_high_s y)
    let extmul_low_u x y = I16x8.mul (widen_low_u x) (widen_low_u y)
    let extmul_high_u x y = I16x8.mul (widen_high_u x) (widen_high_u y)
  end

  module I32x4_convert = struct
    let convert f v = Rep.of_i32x4 (List.map f (Rep.to_f32x4 v))
    let trunc_sat_f32x4_s = convert I32_convert.trunc_sat_f32_s
    let trunc_sat_f32x4_u = convert I32_convert.trunc_sat_f32_u

    let convert_zero f v =
      Rep.(of_i32x4 I32.(zero :: zero :: (List.map f (to_f64x2 v))))
    let trunc_sat_f64x2_s_zero = convert_zero I32_convert.trunc_sat_f64_s
    let trunc_sat_f64x2_u_zero = convert_zero I32_convert.trunc_sat_f64_u

    let widen take_or_drop mask x =
      Rep.of_i32x4 (List.map (Int32.logand mask) (take_or_drop 4 (Rep.to_i16x8 x)))
    let widen_low_s = widen Lib.List.take 0xffffffffl
    let widen_high_s = widen Lib.List.drop 0xffffffffl
    let widen_low_u = widen Lib.List.take 0xffffl
    let widen_high_u = widen Lib.List.drop 0xffffl

    let dot_i16x8_s x y =
      let xs = Rep.to_i16x8 x in
      let ys = Rep.to_i16x8 y in
      let rec dot xs ys =
        match xs, ys with
        | x1::x2::xss, y1::y2::yss ->
          Int32.(add (mul x1 y1) (mul x2 y2)) :: dot xss yss
        | [], [] -> []
        | _, _ -> assert false
      in Rep.of_i32x4 (dot xs ys)

    let extmul_low_s x y = I32x4.mul (widen_low_s x) (widen_low_s y)
    let extmul_high_s x y = I32x4.mul (widen_high_s x) (widen_high_s y)
    let extmul_low_u x y = I32x4.mul (widen_low_u x) (widen_low_u y)
    let extmul_high_u x y = I32x4.mul (widen_high_u x) (widen_high_u y)
  end

  module I64x2_convert = struct
    let widen take_or_drop mask x =
      Rep.of_i64x2
        (List.map
           (fun i32 -> Int64.(logand mask (of_int32 i32)))
           (take_or_drop 2 (Rep.to_i32x4 x)))
    let widen_low_s = widen Lib.List.take 0xffffffffffffffffL
    let widen_high_s = widen Lib.List.drop 0xffffffffffffffffL
    let widen_low_u = widen Lib.List.take 0xffffffffL
    let widen_high_u = widen Lib.List.drop 0xffffffffL

    let extmul_low_s x y = I64x2.mul (widen_low_s x) (widen_low_s y)
    let extmul_high_s x y = I64x2.mul (widen_high_s x) (widen_high_s y)
    let extmul_low_u x y = I64x2.mul (widen_low_u x) (widen_low_u y)
    let extmul_high_u x y = I64x2.mul (widen_high_u x) (widen_high_u y)
  end

  module F32x4_convert = struct
    let convert f v = Rep.of_f32x4 (List.map f (Rep.to_i32x4 v))
    let convert_i32x4_s = convert F32_convert.convert_i32_s
    let convert_i32x4_u = convert F32_convert.convert_i32_u
    let demote_f64x2_zero v =
      Rep.(of_f32x4 F32.(List.map F32_convert.demote_f64 (to_f64x2 v) @ [zero; zero]))
  end

  module F64x2_convert = struct
    let convert f v = Rep.of_f64x2 (List.map f (Lib.List.take 2 (Rep.to_i32x4 v)))
    let convert_i32x4_s = convert F64_convert.convert_i32_s
    let convert_i32x4_u = convert F64_convert.convert_i32_u
    let promote_low_f32x4 v =
      Rep.(of_f64x2 (List.map F64_convert.promote_f32 (Lib.List.take 2 (to_f32x4 v))))
  end
end
