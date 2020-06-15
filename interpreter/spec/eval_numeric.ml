open Types
open Values


(* Runtime type errors *)

exception TypeError of int * value * value_type

let of_arg f n v =
  try f v with Value t -> raise (TypeError (n, v, t))


(* Int operators *)

module IntOp (IXX : Int.S) (Value : ValueType with type t = IXX.t) =
struct
  open Ast.IntOp

  let to_value = Value.to_value
  let of_value = of_arg Value.of_value

  let unop op =
    let f = match op with
      | Clz -> IXX.clz
      | Ctz -> IXX.ctz
      | Popcnt -> IXX.popcnt
    in fun v -> to_value (f (of_value 1 v))

  let binop op =
    let f = match op with
      | Add -> IXX.add
      | Sub -> IXX.sub
      | Mul -> IXX.mul
      | DivS -> IXX.div_s
      | DivU -> IXX.div_u
      | RemS -> IXX.rem_s
      | RemU -> IXX.rem_u
      | And -> IXX.and_
      | Or -> IXX.or_
      | Xor -> IXX.xor
      | Shl -> IXX.shl
      | ShrU -> IXX.shr_u
      | ShrS -> IXX.shr_s
      | Rotl -> IXX.rotl
      | Rotr -> IXX.rotr
    in fun v1 v2 -> to_value (f (of_value 1 v1) (of_value 2 v2))

  let testop op =
    let f = match op with
      | Eqz -> IXX.eqz
    in fun v -> f (of_value 1 v)

  let relop op =
    let f = match op with
      | Eq -> IXX.eq
      | Ne -> IXX.ne
      | LtS -> IXX.lt_s
      | LtU -> IXX.lt_u
      | LeS -> IXX.le_s
      | LeU -> IXX.le_u
      | GtS -> IXX.gt_s
      | GtU -> IXX.gt_u
      | GeS -> IXX.ge_s
      | GeU -> IXX.ge_u
    in fun v1 v2 -> f (of_value 1 v1) (of_value 2 v2)
end

module I32Op = IntOp (I32) (Values.I32Value)
module I64Op = IntOp (I64) (Values.I64Value)


(* Float operators *)

module FloatOp (FXX : Float.S) (Value : ValueType with type t = FXX.t) =
struct
  open Ast.FloatOp

  let to_value = Value.to_value
  let of_value = of_arg Value.of_value

  let unop op =
    let f = match op with
      | Neg -> FXX.neg
      | Abs -> FXX.abs
      | Sqrt  -> FXX.sqrt
      | Ceil -> FXX.ceil
      | Floor -> FXX.floor
      | Trunc -> FXX.trunc
      | Nearest -> FXX.nearest
    in fun v -> to_value (f (of_value 1 v))

  let binop op =
    let f = match op with
      | Add -> FXX.add
      | Sub -> FXX.sub
      | Mul -> FXX.mul
      | Div -> FXX.div
      | Min -> FXX.min
      | Max -> FXX.max
      | CopySign -> FXX.copysign
    in fun v1 v2 -> to_value (f (of_value 1 v1) (of_value 2 v2))

  let testop op = assert false

  let relop op =
    let f = match op with
      | Eq -> FXX.eq
      | Ne -> FXX.ne
      | Lt -> FXX.lt
      | Le -> FXX.le
      | Gt -> FXX.gt
      | Ge -> FXX.ge
    in fun v1 v2 -> f (of_value 1 v1) (of_value 2 v2)
end

module F32Op = FloatOp (F32) (Values.F32Value)
module F64Op = FloatOp (F64) (Values.F64Value)


(* Conversion operators *)

module I32CvtOp =
struct
  open Ast.IntOp

  let cvtop op v =
    match op with
    | WrapI64 -> I32 (I32_convert.wrap_i64 (I64Op.of_value 1 v))
    | TruncSF32 -> I32 (I32_convert.trunc_s_f32 (F32Op.of_value 1 v))
    | TruncUF32 -> I32 (I32_convert.trunc_u_f32 (F32Op.of_value 1 v))
    | TruncSF64 -> I32 (I32_convert.trunc_s_f64 (F64Op.of_value 1 v))
    | TruncUF64 -> I32 (I32_convert.trunc_u_f64 (F64Op.of_value 1 v))
    | ReinterpretFloat -> I32 (I32_convert.reinterpret_f32 (F32Op.of_value 1 v))
    | ExtendSI32 -> raise (TypeError (1, v, I32Type))
    | ExtendUI32 -> raise (TypeError (1, v, I32Type))
end

module I64CvtOp =
struct
  open Ast.IntOp

  let cvtop op v =
    match op with
    | ExtendSI32 -> I64 (I64_convert.extend_s_i32 (I32Op.of_value 1 v))
    | ExtendUI32 -> I64 (I64_convert.extend_u_i32 (I32Op.of_value 1 v))
    | TruncSF32 -> I64 (I64_convert.trunc_s_f32 (F32Op.of_value 1 v))
    | TruncUF32 -> I64 (I64_convert.trunc_u_f32 (F32Op.of_value 1 v))
    | TruncSF64 -> I64 (I64_convert.trunc_s_f64 (F64Op.of_value 1 v))
    | TruncUF64 -> I64 (I64_convert.trunc_u_f64 (F64Op.of_value 1 v))
    | ReinterpretFloat -> I64 (I64_convert.reinterpret_f64 (F64Op.of_value 1 v))
    | WrapI64 -> raise (TypeError (1, v, I64Type))
end

module F32CvtOp =
struct
  open Ast.FloatOp

  let cvtop op v =
    match op with
    | DemoteF64 -> F32 (F32_convert.demote_f64 (F64Op.of_value 1 v))
    | ConvertSI32 -> F32 (F32_convert.convert_s_i32 (I32Op.of_value 1 v))
    | ConvertUI32 -> F32 (F32_convert.convert_u_i32 (I32Op.of_value 1 v))
    | ConvertSI64 -> F32 (F32_convert.convert_s_i64 (I64Op.of_value 1 v))
    | ConvertUI64 -> F32 (F32_convert.convert_u_i64 (I64Op.of_value 1 v))
    | ReinterpretInt -> F32 (F32_convert.reinterpret_i32 (I32Op.of_value 1 v))
    | PromoteF32 -> raise (TypeError (1, v, F32Type))
end

module F64CvtOp =
struct
  open Ast.FloatOp

  let cvtop op v =
    match op with
    | PromoteF32 -> F64 (F64_convert.promote_f32 (F32Op.of_value 1 v))
    | ConvertSI32 -> F64 (F64_convert.convert_s_i32 (I32Op.of_value 1 v))
    | ConvertUI32 -> F64 (F64_convert.convert_u_i32 (I32Op.of_value 1 v))
    | ConvertSI64 -> F64 (F64_convert.convert_s_i64 (I64Op.of_value 1 v))
    | ConvertUI64 -> F64 (F64_convert.convert_u_i64 (I64Op.of_value 1 v))
    | ReinterpretInt -> F64 (F64_convert.reinterpret_i64 (I64Op.of_value 1 v))
    | DemoteF64 -> raise (TypeError (1, v, F64Type))
end


(* Dispatch *)

let op i32 i64 f32 f64 = function
  | I32 x -> i32 x
  | I64 x -> i64 x
  | F32 x -> f32 x
  | F64 x -> f64 x

let eval_unop = op I32Op.unop I64Op.unop F32Op.unop F64Op.unop
let eval_binop = op I32Op.binop I64Op.binop F32Op.binop F64Op.binop
let eval_testop = op I32Op.testop I64Op.testop F32Op.testop F64Op.testop
let eval_relop = op I32Op.relop I64Op.relop F32Op.relop F64Op.relop
let eval_cvtop = op I32CvtOp.cvtop I64CvtOp.cvtop F32CvtOp.cvtop F64CvtOp.cvtop
