(*
 * (c) 2015 Andreas Rossberg
 *)

open Types
open Values


(* Runtime type errors *)

exception TypeError of int * value * value_type


(* Int operators *)

module type INT =
sig
  type t
  val of_value : int -> value -> t
  val to_value : t -> value
  val size : int
  val neg : t -> t
  val abs : t -> t
  val lognot : t -> t
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t
  val rem : t -> t -> t
  val logand : t -> t -> t
  val logor : t -> t -> t
  val logxor : t -> t -> t
  val shift_left : t -> int -> t
  val shift_right : t -> int -> t
  val shift_right_logical : t -> int -> t
  val to_int : t -> int
  val to_int32 : t -> int32
  val to_int64 : t -> int64
  val to_float : t -> float
  val float_of_bits : t -> float
  val to_big_int_u : t -> Big_int.big_int
  val of_big_int_u : Big_int.big_int -> t
end

let to_big_int_u_for size to_big_int i =
  let open Big_int in
  let value_range = Big_int.power_int_positive_int 2 size in
  let i' = to_big_int i in
  if ge_big_int i' zero_big_int then i' else add_big_int i' value_range

let of_big_int_u_for size of_big_int i =
  let open Big_int in
  let value_range = Big_int.power_int_positive_int 2 size in
  let i' = if ge_big_int i zero_big_int then i else sub_big_int i value_range
  in of_big_int i'

module Int32X =
struct
  include Int32
  let size = 32
  let to_int32 i = i
  let to_int64 = Int64.of_int32
  let to_value i = Int32 i
  let of_value n =
    function Int32 i -> i | v -> raise (TypeError (n, v, Int32Type))
  let value_range = Big_int.power_int_positive_int 2 32
  let to_big_int_u = to_big_int_u_for size Big_int.big_int_of_int32
  let of_big_int_u = of_big_int_u_for size Big_int.int32_of_big_int
end

module Int64X =
struct
  include Int64
  let size = 64
  let to_int64 i = i
  let to_value i = Int64 i
  let of_value n =
    function Int64 i -> i | v -> raise (TypeError (n, v, Int64Type))
  let to_big_int_u = to_big_int_u_for size Big_int.big_int_of_int64
  let of_big_int_u = of_big_int_u_for size Big_int.int64_of_big_int
end

module IntOp (IntOpSyntax : module type of Ast.IntOp()) (Int : INT) =
struct
  open IntOpSyntax
  open Big_int

  let unsigned big_op i j = big_op (Int.to_big_int_u i) (Int.to_big_int_u j)

  let unop op =
    let f = match op with
      | Neg -> Int.neg
      | Abs -> Int.abs
      | Not -> Int.lognot
      | Clz -> fun i -> i  (* TODO *)
      | Ctz -> fun i -> i  (* TODO *)
    in fun v -> Int.to_value (f (Int.of_value 1 v))

  let binop op =
    let f = match op with
      | Add -> Int.add
      | Sub -> Int.sub
      | Mul -> Int.mul
      | DivS -> Int.div
      | DivU -> fun i j -> Int.of_big_int_u (unsigned div_big_int i j)
      | ModS -> Int.rem
      | ModU -> fun i j -> Int.of_big_int_u (unsigned mod_big_int i j)
      | And -> Int.logand
      | Or -> Int.logor
      | Xor -> Int.logxor
      | Shl -> fun i j -> Int.shift_left i (Int.to_int j)
      | Shr -> fun i j -> Int.shift_right_logical i (Int.to_int j)
      | Sar -> fun i j -> Int.shift_right i (Int.to_int j)
    in fun v1 v2 -> Int.to_value (f (Int.of_value 1 v1) (Int.of_value 2 v2))

  let relop op =
    let f = match op with
      | Eq -> (=)
      | Neq -> (<>)
      | LtS -> (<)
      | LtU -> unsigned lt_big_int
      | LeS -> (<=)
      | LeU -> unsigned le_big_int
      | GtS -> (>)
      | GtU -> unsigned gt_big_int
      | GeS -> (>=)
      | GeU -> unsigned ge_big_int
    in fun v1 v2 -> f (Int.of_value 1 v1) (Int.of_value 2 v2)

  let cvt op =
    let f = match op with
      | ToInt32S -> fun i -> Int32 (Int.to_int32 i)
      | ToInt32U -> fun i -> Int32 (Int32X.of_big_int_u (Int.to_big_int_u i))
      | ToInt64S -> fun i -> Int64 (Int.to_int64 i)
      | ToInt64U -> fun i -> Int64 (Int64X.of_big_int_u (Int.to_big_int_u i))
      | ToFloat32S -> fun i -> Float32 (float32 (Int.to_float i))
      | ToFloat32U -> fun i ->
        Float32 (float32 (float_of_big_int (Int.to_big_int_u i)))
      | ToFloat64S -> fun i -> Float64 (Int.to_float i)
      | ToFloat64U -> fun i -> Float64 (float_of_big_int (Int.to_big_int_u i))
      | ToFloatCast -> fun i ->
        if Int.size = 32
        then Float32 (float32 (Int.float_of_bits i))
        else Float64 (Int.float_of_bits i)
    in fun v -> f (Int.of_value 1 v)
end

module Int32Op = IntOp (Ast.Int32Op) (Int32X)
module Int64Op = IntOp (Ast.Int64Op) (Int64X)


(* Float operators *)

module type FLOAT =
sig
  val size : int
  val of_value : int -> value -> float
  val to_value : float -> value
end

module Float32X =
struct
  let size = 32
  let to_value z = Float32 (float32 z)
  let of_value n =
    function Float32 z -> z | v -> raise (TypeError (n, v, Float32Type))
end

module Float64X =
struct
  let size = 64
  let to_value z = Float64 z
  let of_value n =
    function Float64 z -> z | v -> raise (TypeError (n, v, Float64Type))
end

module FloatOp (FloatOpSyntax : module type of Ast.FloatOp()) (Float : FLOAT) =
struct
  open FloatOpSyntax

  let unop op =
    let f = match op with
      | Neg -> (~-.)
      | Abs -> abs_float
      | Ceil -> ceil
      | Floor -> floor
      | Trunc -> fun _ -> 0.0  (* TODO *)
      | Round -> fun _ -> 0.0  (* TODO *)
    in fun v -> Float.to_value (f (Float.of_value 1 v))

  let binop op =
    let f = match op with
      | Add -> (+.)
      | Sub -> (-.)
      | Mul -> ( *.)
      | Div -> (/.)
      | CopySign -> copysign
    in
    fun v1 v2 -> Float.to_value (f (Float.of_value 1 v1) (Float.of_value 2 v2))

  let relop op =
    let f = match op with
      | Eq -> (=)
      | Neq -> (<>)
      | Lt -> (<)
      | Le -> (<=)
      | Gt -> (>)
      | Ge -> (>=)
    in fun v1 v2 -> f (Float.of_value 1 v1) (Float.of_value 2 v2)

  let cvt op =
    let f = match op with
    | ToInt32S -> fun x -> Int32 (Int32.of_float x)
    | ToInt32U -> fun x ->
      let limit = Int32.to_float Int32.max_int +. 1.0 in
      let i =
        if x < 0.0 || x >= 2.0 *. limit then Int32.zero else
        if x < limit then Int32.of_float x else
        Int32.add (Int32.of_float (x -. limit +. 1.0)) Int32.max_int
      in Int32 i
    | ToInt64S -> fun x -> Int64 (Int64.of_float x)
    | ToInt64U -> fun x ->
      let limit = Int64.to_float Int64.max_int +. 1.0 in
      let i =
        if x < 0.0 || x >= 2.0 *. limit then Int64.zero else
        if x < limit then Int64.of_float x else
        Int64.add (Int64.of_float (x -. limit +. 1.0)) Int64.max_int
      in Int64 i
    | ToFloat32 -> fun x -> Float32 (float32 x)
    | ToFloat64 -> fun x -> Float64 x
    | ToIntCast -> fun x ->
      if Float.size = 32
      then Int32 (Int32.bits_of_float x)
      else Int64 (Int64.bits_of_float x)
    in fun v -> f (Float.of_value 1 v)
end

module Float32Op = FloatOp (Ast.Float32Op) (Float32X)
module Float64Op = FloatOp (Ast.Float64Op) (Float64X)


(* Dispatch *)

let op i32 i64 f32 f64 = function
  | Int32 x -> i32 x
  | Int64 x -> i64 x
  | Float32 x -> f32 x
  | Float64 x -> f64 x

let eval_unop = op Int32Op.unop Int64Op.unop Float32Op.unop Float64Op.unop
let eval_binop = op Int32Op.binop Int64Op.binop Float32Op.binop Float64Op.binop
let eval_relop = op Int32Op.relop Int64Op.relop Float32Op.relop Float64Op.relop
let eval_cvt = op Int32Op.cvt Int64Op.cvt Float32Op.cvt Float64Op.cvt
