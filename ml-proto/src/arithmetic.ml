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
end

module IntOp (IntOpSyntax : module type of Ast.IntOp ()) (Int : INT) =
struct
  open IntOpSyntax

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
      | DivU -> fun i _ -> i  (* TODO *)
      | ModS -> Int.rem
      | ModU -> fun i _ -> i  (* TODO *)
      | And -> Int.logand
      | Or -> Int.logor
      | Xor -> Int.logxor
      | Shl -> fun x y -> Int.shift_left x (Int.to_int y)
      | Shr -> fun x y -> Int.shift_right_logical x (Int.to_int y)
      | Sar -> fun x y -> Int.shift_right x (Int.to_int y)
    in fun v1 v2 -> Int.to_value (f (Int.of_value 1 v1) (Int.of_value 2 v2))

  let relop op =
    let f = match op with
      | Eq -> (=)
      | Neq -> (<>)
      | LtS -> (<)
      | LtU -> fun _ _ -> false  (* TODO *)
      | LeS -> (<=)
      | LeU -> fun _ _ -> false  (* TODO *)
      | GtS -> (>)
      | GtU -> fun _ _ -> false  (* TODO *)
      | GeS -> (>=)
      | GeU -> fun _ _ -> false  (* TODO *)
    in fun v1 v2 -> f (Int.of_value 1 v1) (Int.of_value 2 v2)

  let cvt op =
    let f = match op with
      | ToInt32S -> fun x -> Int32 (Int.to_int32 x)
      | ToInt32U -> fun _ -> Int32 Int32.zero  (* TODO *)
      | ToInt64S -> fun x -> Int64 (Int.to_int64 x)
      | ToInt64U -> fun _ -> Int64 Int64.zero  (* TODO *)
      | ToFloat32S -> fun x -> Float32 (Int.to_float x)
      | ToFloat32U -> fun _ -> Float32 0.0  (* TODO *)
      | ToFloat64S -> fun x -> Float64 (Int.to_float x)
      | ToFloat64U -> fun _ -> Float64 0.0  (* TODO *)
      | ToFloatCast -> fun x ->
        if Int.size = 32
        then Float32 (Int.float_of_bits x)
        else Float64 (Int.float_of_bits x)
    in fun v -> f (Int.of_value 1 v)
end

module Int32X =
struct
  include Int32
  let size = 32
  let to_int32 i = i
  let to_int64 = Int64.of_int32
  let to_value i = Int32 i
  let of_value n =
    function Int32 i -> i | v -> raise (TypeError (n, v, Int32Type))
end

module Int64X =
struct
  include Int64
  let size = 64
  let to_int64 i = i
  let to_value i = Int64 i
  let of_value n =
    function Int64 i -> i | v -> raise (TypeError (n, v, Int64Type))
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

module FloatOp (FloatOpSyntax : module type of Ast.FloatOp ())
  (Float : FLOAT) =
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
      | Mod -> mod_float
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
    | ToInt32U -> fun _ -> Int32 Int32.zero  (* TODO *)
    | ToInt64S -> fun x -> Int64 (Int64.of_float x)
    | ToInt64U -> fun _ -> Int64 Int64.zero  (* TODO *)
    | ToFloat32 -> fun x -> Float32 x
    | ToFloat64 -> fun x -> Float64 x
    | ToIntCast -> fun x ->
      if Float.size = 32
      then Int32 (Int32.bits_of_float x)
      else Int64 (Int64.bits_of_float x)
    in fun v -> f (Float.of_value 1 v)
end

module Float32X =
struct
  let size = 32
  let to_value z = Float32 z
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
