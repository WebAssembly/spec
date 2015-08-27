(*
 * (c) 2015 Andreas Rossberg
 *)

open Types
open Values


(* Runtime type errors *)

exception TypeError of int * value * value_type


(* Int traits *)

module type INT =
sig
  type t
  val size : int
  val max_int : t
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
  val of_int32 : int32 -> t
  val of_int64 : int64 -> t
  val to_float : t -> float
  val of_float : float -> t
  val bits_of_float : float -> t
  val to_big_int_u : t -> Big_int.big_int
  val of_big_int_u : Big_int.big_int -> t
  val to_value : t -> value
  val of_value : int -> value -> t
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
  let of_int32 i = i
  let of_int64 = Int64.to_int32
  let to_big_int_u = to_big_int_u_for size Big_int.big_int_of_int32
  let of_big_int_u = of_big_int_u_for size Big_int.int32_of_big_int
  let to_value i = Int32 i
  let of_value n =
    function Int32 i -> i | v -> raise (TypeError (n, v, Int32Type))
end

module Int64X =
struct
  include Int64
  let size = 64
  let of_int64 i = i
  let to_big_int_u = to_big_int_u_for size Big_int.big_int_of_int64
  let of_big_int_u = of_big_int_u_for size Big_int.int64_of_big_int
  let to_value i = Int64 i
  let of_value n =
    function Int64 i -> i | v -> raise (TypeError (n, v, Int64Type))
end


(* Float traits *)

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


(* Int operators *)

module IntOp (IntOpSyntax : module type of Ast.IntOp ()) (Int : INT) =
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

  let of_float_u x =
    let limit = Int.to_float Int.max_int +. 1.0 in
    if x < 0.0 || x >= 2.0 *. limit then Int.of_float 0.0 else
    if x < limit then Int.of_float x else
    Int.add (Int.of_float (x -. limit +. 1.0)) Int.max_int

  let cvt op =
    let f = match op with
      | FromInt32S -> fun v -> Int.of_int32 (Int32X.of_value 1 v)
      | FromInt32U -> fun v ->
        Int.of_big_int_u (Int32X.to_big_int_u (Int32X.of_value 1 v))
      | FromInt64S -> fun v -> Int.of_int64 (Int64X.of_value 1 v)
      | FromInt64U -> fun v ->
        Int.of_big_int_u (Int64X.to_big_int_u (Int64X.of_value 1 v))
      | FromFloat32S -> fun v -> Int.of_float (Float32X.of_value 1 v)
      | FromFloat32U -> fun v -> of_float_u (Float32X.of_value 1 v)
      | FromFloat64S -> fun v -> Int.of_float (Float64X.of_value 1 v)
      | FromFloat64U -> fun v -> of_float_u (Float64X.of_value 1 v)
      | CastFloat -> fun v ->
        if Int.size = 32
        then Int.bits_of_float (Float32X.of_value 1 v)
        else Int.bits_of_float (Float64X.of_value 1 v)
    in fun v -> Int.to_value (f v)
end

module Int32Op = IntOp (Ast.Int32Op) (Int32X)
module Int64Op = IntOp (Ast.Int64Op) (Int64X)


(* Float operators *)

module FloatOp (FloatOpSyntax : module type of Ast.FloatOp ()) (Float : FLOAT) =
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
      | FromInt32S -> fun v -> Int32.to_float (Int32X.of_value 1 v)
      | FromInt32U -> fun v ->
        Big_int.float_of_big_int (Int32X.to_big_int_u (Int32X.of_value 1 v))
      | FromInt64S -> fun v -> Int64.to_float (Int64X.of_value 1 v)
      | FromInt64U -> fun v ->
        Big_int.float_of_big_int (Int64X.to_big_int_u (Int64X.of_value 1 v))
      | FromFloat32 -> fun v -> Float32X.of_value 1 v
      | FromFloat64 -> fun v -> Float64X.of_value 1 v
      | CastInt -> fun v ->
        if Float.size = 32
        then Int32.float_of_bits (Int32X.of_value 1 v)
        else Int64.float_of_bits (Int64X.of_value 1 v)
    in fun v -> Float.to_value (f v)
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
