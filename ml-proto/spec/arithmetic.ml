open Types
open Values


(* Runtime type errors *)

exception TypeError of int * value * value_type


(* Value unpacking *)

let i32_of_value n =
  function I32 i -> i | v -> raise (TypeError (n, v, I32Type))

let i64_of_value n =
  function I64 i -> i | v -> raise (TypeError (n, v, I64Type))

let f32_of_value n =
  function F32 z -> z | v -> raise (TypeError (n, v, F32Type))

let f64_of_value n =
  function F64 z -> z | v -> raise (TypeError (n, v, F64Type))


(* Int operators *)

module Int32Op =
struct
  open Ast.I32Op

  let unop op =
    let f = match op with
      | Clz -> I32.clz
      | Ctz -> I32.ctz
      | Popcnt -> I32.popcnt
    in fun v -> I32 (f (i32_of_value 1 v))

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
      | Rotl -> I32.rotl
      | Rotr -> I32.rotr
    in fun v1 v2 -> I32 (f (i32_of_value 1 v1) (i32_of_value 2 v2))

  let testop op =
    let f = match op with
      | Eqz -> I32.eqz
    in fun v -> f (i32_of_value 1 v)

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

  let cvtop op =
    match op with
      | WrapI64 ->
          fun v -> I32 (I32_convert.wrap_i64 (i64_of_value 1 v))
      | TruncSF32 ->
          fun v -> I32 (I32_convert.trunc_s_f32 (f32_of_value 1 v))
      | TruncUF32 ->
          fun v -> I32 (I32_convert.trunc_u_f32 (f32_of_value 1 v))
      | TruncSF64 ->
          fun v -> I32 (I32_convert.trunc_s_f64 (f64_of_value 1 v))
      | TruncUF64 ->
          fun v -> I32 (I32_convert.trunc_u_f64 (f64_of_value 1 v))
      | ReinterpretFloat ->
          fun v -> I32 (I32_convert.reinterpret_f32 (f32_of_value 1 v))
      | ExtendSI32 ->
          fun v -> raise (TypeError (1, v, I32Type))
      | ExtendUI32 ->
          fun v -> raise (TypeError (1, v, I32Type))
end

module Int64Op =
struct
  open Ast.I64Op

  let unop op =
    let f = match op with
      | Clz -> I64.clz
      | Ctz -> I64.ctz
      | Popcnt -> I64.popcnt
    in fun v -> I64 (f (i64_of_value 1 v))

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
      | Rotl -> I64.rotl
      | Rotr -> I64.rotr
    in fun v1 v2 -> I64 (f (i64_of_value 1 v1) (i64_of_value 2 v2))

  let testop op =
    let f = match op with
      | Eqz -> I64.eqz
    in fun v -> f (i64_of_value 1 v)

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

  let cvtop op =
    match op with
      | ExtendSI32 ->
          fun v -> I64 (I64_convert.extend_s_i32 (i32_of_value 1 v))
      | ExtendUI32 ->
          fun v -> I64 (I64_convert.extend_u_i32 (i32_of_value 1 v))
      | TruncSF32 ->
          fun v -> I64 (I64_convert.trunc_s_f32 (f32_of_value 1 v))
      | TruncUF32 ->
          fun v -> I64 (I64_convert.trunc_u_f32 (f32_of_value 1 v))
      | TruncSF64 ->
          fun v -> I64 (I64_convert.trunc_s_f64 (f64_of_value 1 v))
      | TruncUF64 ->
          fun v -> I64 (I64_convert.trunc_u_f64 (f64_of_value 1 v))
      | ReinterpretFloat ->
          fun v -> I64 (I64_convert.reinterpret_f64 (f64_of_value 1 v))
      | WrapI64 ->
          fun v -> raise (TypeError (1, v, I64Type))
end


(* Float operators *)

module Float32Op =
struct
  open Ast.F32Op

  let unop op =
    let f = match op with
      | Neg -> F32.neg
      | Abs -> F32.abs
      | Sqrt  -> F32.sqrt
      | Ceil -> F32.ceil
      | Floor -> F32.floor
      | Trunc -> F32.trunc
      | Nearest -> F32.nearest
    in fun v -> F32 (f (f32_of_value 1 v))

  let binop op =
    let f = match op with
      | Add -> F32.add
      | Sub -> F32.sub
      | Mul -> F32.mul
      | Div -> F32.div
      | Min -> F32.min
      | Max -> F32.max
      | CopySign -> F32.copysign
    in fun v1 v2 -> F32 (f (f32_of_value 1 v1) (f32_of_value 2 v2))

  let testop op = assert false

  let relop op =
    let f = match op with
      | Eq -> F32.eq
      | Ne -> F32.ne
      | Lt -> F32.lt
      | Le -> F32.le
      | Gt -> F32.gt
      | Ge -> F32.ge
    in fun v1 v2 -> f (f32_of_value 1 v1) (f32_of_value 2 v2)

  let cvtop op =
    match op with
      | DemoteF64 ->
          fun v -> F32 (F32_convert.demote_f64 (f64_of_value 1 v))
      | ConvertSI32 ->
          fun v -> F32 (F32_convert.convert_s_i32 (i32_of_value 1 v))
      | ConvertUI32 ->
          fun v -> F32 (F32_convert.convert_u_i32 (i32_of_value 1 v))
      | ConvertSI64 ->
          fun v -> F32 (F32_convert.convert_s_i64 (i64_of_value 1 v))
      | ConvertUI64 ->
          fun v -> F32 (F32_convert.convert_u_i64 (i64_of_value 1 v))
      | ReinterpretInt ->
          fun v -> F32 (F32_convert.reinterpret_i32 (i32_of_value 1 v))
      | PromoteF32 ->
          fun v -> raise (TypeError (1, v, F32Type))
end

module Float64Op =
struct
  open Ast.F64Op

  let unop op =
    let f = match op with
      | Neg -> F64.neg
      | Abs -> F64.abs
      | Sqrt  -> F64.sqrt
      | Ceil -> F64.ceil
      | Floor -> F64.floor
      | Trunc -> F64.trunc
      | Nearest -> F64.nearest
    in fun v -> F64 (f (f64_of_value 1 v))

  let binop op =
    let f = match op with
      | Add -> F64.add
      | Sub -> F64.sub
      | Mul -> F64.mul
      | Div -> F64.div
      | Min -> F64.min
      | Max -> F64.max
      | CopySign -> F64.copysign
    in fun v1 v2 -> F64 (f (f64_of_value 1 v1) (f64_of_value 2 v2))

  let testop op = assert false

  let relop op =
    let f = match op with
      | Eq -> F64.eq
      | Ne -> F64.ne
      | Lt -> F64.lt
      | Le -> F64.le
      | Gt -> F64.gt
      | Ge -> F64.ge
    in fun v1 v2 -> f (f64_of_value 1 v1) (f64_of_value 2 v2)

  let cvtop op =
    match op with
      | PromoteF32 ->
          fun v -> F64 (F64_convert.promote_f32 (f32_of_value 1 v))
      | ConvertSI32 ->
          fun v -> F64 (F64_convert.convert_s_i32 (i32_of_value 1 v))
      | ConvertUI32 ->
          fun v -> F64 (F64_convert.convert_u_i32 (i32_of_value 1 v))
      | ConvertSI64 ->
          fun v -> F64 (F64_convert.convert_s_i64 (i64_of_value 1 v))
      | ConvertUI64 ->
          fun v -> F64 (F64_convert.convert_u_i64 (i64_of_value 1 v))
      | ReinterpretInt ->
          fun v -> F64 (F64_convert.reinterpret_i64 (i64_of_value 1 v))
      | DemoteF64 ->
          fun v -> raise (TypeError (1, v, F64Type))
end


(* Dispatch *)

let op i32 i64 f32 f64 = function
  | I32 x -> i32 x
  | I64 x -> i64 x
  | F32 x -> f32 x
  | F64 x -> f64 x

let eval_unop = op Int32Op.unop Int64Op.unop Float32Op.unop Float64Op.unop
let eval_binop = op Int32Op.binop Int64Op.binop Float32Op.binop Float64Op.binop
let eval_testop = op Int32Op.testop Int64Op.testop Float32Op.testop Float64Op.testop
let eval_relop = op Int32Op.relop Int64Op.relop Float32Op.relop Float64Op.relop
let eval_cvtop = op Int32Op.cvtop Int64Op.cvtop Float32Op.cvtop Float64Op.cvtop
