(*
 * (c) 2015 Andreas Rossberg
 *)

open Types
open Values


(* Runtime type errors *)

exception TypeError of int * value * value_type


(* Value unpacking *)

let i32_of_value n =
  function Int32 i -> i | v -> raise (TypeError (n, v, Int32Type))

let i64_of_value n =
  function Int64 i -> i | v -> raise (TypeError (n, v, Int64Type))

let f32_of_value n =
  function Float32 z -> z | v -> raise (TypeError (n, v, Float32Type))

let f64_of_value n =
  function Float64 z -> z | v -> raise (TypeError (n, v, Float64Type))


(* Int operators *)

module Int32Op =
struct
  open Kernel.Int32Op

  let unop op =
    let f = match op with
      | Clz -> I32.clz
      | Ctz -> I32.ctz
      | Popcnt -> I32.popcnt
    in fun v -> Int32 (f (i32_of_value 1 v))

  let binop op =
    let f = match op with
      | Add -> I32.add
      | Sub -> I32.sub
      | Mul -> I32.mul
      | DivS -> I32.div_s
      | DivU -> I32.div_u
      | RemS -> I32.rem_s
      | RemU -> I32.rem_u
      | And -> I32.and_
      | Or -> I32.or_
      | Xor -> I32.xor
      | Shl -> I32.shl
      | ShrU -> I32.shr_u
      | ShrS -> I32.shr_s
    in fun v1 v2 -> Int32 (f (i32_of_value 1 v1) (i32_of_value 2 v2))

  let relop op =
    let f = match op with
      | Eq -> I32.eq
      | Ne -> I32.ne
      | LtS -> I32.lt_s
      | LtU -> I32.lt_u
      | LeS -> I32.le_s
      | LeU -> I32.le_u
      | GtS -> I32.gt_s
      | GtU -> I32.gt_u
      | GeS -> I32.ge_s
      | GeU -> I32.ge_u
    in fun v1 v2 -> f (i32_of_value 1 v1) (i32_of_value 2 v2)

  let cvt op =
    match op with
      | WrapInt64 ->
          fun v -> Int32   (I32_convert.wrap_i64        (i64_of_value 1 v))
      | TruncSFloat32 ->
          fun v -> Int32   (I32_convert.trunc_s_f32     (f32_of_value 1 v))
      | TruncUFloat32 ->
          fun v -> Int32   (I32_convert.trunc_u_f32     (f32_of_value 1 v))
      | TruncSFloat64 ->
          fun v -> Int32   (I32_convert.trunc_s_f64     (f64_of_value 1 v))
      | TruncUFloat64 ->
          fun v -> Int32   (I32_convert.trunc_u_f64     (f64_of_value 1 v))
      | ReinterpretFloat ->
          fun v -> Int32   (I32_convert.reinterpret_f32 (f32_of_value 1 v))
      | ExtendSInt32 ->
          fun v -> raise (TypeError (1, v, Int32Type))
      | ExtendUInt32 ->
          fun v -> raise (TypeError (1, v, Int32Type))
end

module Int64Op =
struct
  open Kernel.Int64Op

  let unop op =
    let f = match op with
      | Clz -> I64.clz
      | Ctz -> I64.ctz
      | Popcnt -> I64.popcnt
    in fun v -> Int64 (f (i64_of_value 1 v))

  let binop op =
    let f = match op with
      | Add -> I64.add
      | Sub -> I64.sub
      | Mul -> I64.mul
      | DivS -> I64.div_s
      | DivU -> I64.div_u
      | RemS -> I64.rem_s
      | RemU -> I64.rem_u
      | And -> I64.and_
      | Or -> I64.or_
      | Xor -> I64.xor
      | Shl -> I64.shl
      | ShrU -> I64.shr_u
      | ShrS -> I64.shr_s
    in fun v1 v2 -> Int64 (f (i64_of_value 1 v1) (i64_of_value 2 v2))

  let relop op =
    let f = match op with
      | Eq -> I64.eq
      | Ne -> I64.ne
      | LtS -> I64.lt_s
      | LtU -> I64.lt_u
      | LeS -> I64.le_s
      | LeU -> I64.le_u
      | GtS -> I64.gt_s
      | GtU -> I64.gt_u
      | GeS -> I64.ge_s
      | GeU -> I64.ge_u
    in fun v1 v2 -> f (i64_of_value 1 v1) (i64_of_value 2 v2)

  let cvt op =
    match op with
      | ExtendSInt32 ->
          fun v -> Int64   (I64_convert.extend_s_i32    (i32_of_value 1 v))
      | ExtendUInt32 ->
          fun v -> Int64   (I64_convert.extend_u_i32    (i32_of_value 1 v))
      | TruncSFloat32 ->
          fun v -> Int64   (I64_convert.trunc_s_f32     (f32_of_value 1 v))
      | TruncUFloat32 ->
          fun v -> Int64   (I64_convert.trunc_u_f32     (f32_of_value 1 v))
      | TruncSFloat64 ->
          fun v -> Int64   (I64_convert.trunc_s_f64     (f64_of_value 1 v))
      | TruncUFloat64 ->
          fun v -> Int64   (I64_convert.trunc_u_f64     (f64_of_value 1 v))
      | ReinterpretFloat ->
          fun v -> Int64   (I64_convert.reinterpret_f64 (f64_of_value 1 v))
      | WrapInt64 ->
          fun v -> raise (TypeError (1, v, Int64Type))
end


(* Float operators *)

module Float32Op =
struct
  open Kernel.Float32Op

  let unop op =
    let f = match op with
      | Neg -> F32.neg
      | Abs -> F32.abs
      | Sqrt  -> F32.sqrt
      | Ceil -> F32.ceil
      | Floor -> F32.floor
      | Trunc -> F32.trunc
      | Nearest -> F32.nearest
    in fun v -> Float32 (f (f32_of_value 1 v))

  let binop op =
    let f = match op with
      | Add -> F32.add
      | Sub -> F32.sub
      | Mul -> F32.mul
      | Div -> F32.div
      | Min -> F32.min
      | Max -> F32.max
      | CopySign -> F32.copysign
    in fun v1 v2 -> Float32 (f (f32_of_value 1 v1) (f32_of_value 2 v2))

  let relop op =
    let f = match op with
      | Eq -> F32.eq
      | Ne -> F32.ne
      | Lt -> F32.lt
      | Le -> F32.le
      | Gt -> F32.gt
      | Ge -> F32.ge
    in fun v1 v2 -> f (f32_of_value 1 v1) (f32_of_value 2 v2)

  let cvt op =
    match op with
      | DemoteFloat64 ->
          fun v -> Float32 (F32_convert.demote_f64      (f64_of_value 1 v))
      | ConvertSInt32 ->
          fun v -> Float32 (F32_convert.convert_s_i32   (i32_of_value 1 v))
      | ConvertUInt32 ->
          fun v -> Float32 (F32_convert.convert_u_i32   (i32_of_value 1 v))
      | ConvertSInt64 ->
          fun v -> Float32 (F32_convert.convert_s_i64   (i64_of_value 1 v))
      | ConvertUInt64 ->
          fun v -> Float32 (F32_convert.convert_u_i64   (i64_of_value 1 v))
      | ReinterpretInt ->
          fun v -> Float32 (F32_convert.reinterpret_i32 (i32_of_value 1 v))
      | PromoteFloat32 ->
          fun v -> raise (TypeError (1, v, Float32Type))
end

module Float64Op =
struct
  open Kernel.Float64Op

  let unop op =
    let f = match op with
      | Neg -> F64.neg
      | Abs -> F64.abs
      | Sqrt  -> F64.sqrt
      | Ceil -> F64.ceil
      | Floor -> F64.floor
      | Trunc -> F64.trunc
      | Nearest -> F64.nearest
    in fun v -> Float64 (f (f64_of_value 1 v))

  let binop op =
    let f = match op with
      | Add -> F64.add
      | Sub -> F64.sub
      | Mul -> F64.mul
      | Div -> F64.div
      | Min -> F64.min
      | Max -> F64.max
      | CopySign -> F64.copysign
    in fun v1 v2 -> Float64 (f (f64_of_value 1 v1) (f64_of_value 2 v2))

  let relop op =
    let f = match op with
      | Eq -> F64.eq
      | Ne -> F64.ne
      | Lt -> F64.lt
      | Le -> F64.le
      | Gt -> F64.gt
      | Ge -> F64.ge
    in fun v1 v2 -> f (f64_of_value 1 v1) (f64_of_value 2 v2)

  let cvt op =
    match op with
      | PromoteFloat32 ->
          fun v -> Float64 (F64_convert.promote_f32     (f32_of_value 1 v))
      | ConvertSInt32 ->
          fun v -> Float64 (F64_convert.convert_s_i32   (i32_of_value 1 v))
      | ConvertUInt32 ->
          fun v -> Float64 (F64_convert.convert_u_i32   (i32_of_value 1 v))
      | ConvertSInt64 ->
          fun v -> Float64 (F64_convert.convert_s_i64   (i64_of_value 1 v))
      | ConvertUInt64 ->
          fun v -> Float64 (F64_convert.convert_u_i64   (i64_of_value 1 v))
      | ReinterpretInt ->
          fun v -> Float64 (F64_convert.reinterpret_i64 (i64_of_value 1 v))
      | DemoteFloat64 ->
          fun v -> raise (TypeError (1, v, Float64Type))
end


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
