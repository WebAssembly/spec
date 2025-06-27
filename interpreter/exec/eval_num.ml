open Types
open Value


(* Int operators *)

module IntOp (IXX : Ixx.T) (Num : NumType with type t = IXX.t) =
struct
  open Ast.IntOp
  open Num

  let unop op =
    let f = match op with
      | Clz -> IXX.clz
      | Ctz -> IXX.ctz
      | Popcnt -> IXX.popcnt
      | ExtendS sz -> IXX.extend_s (8 * Pack.packed_size sz)
    in fun v -> to_num (f (of_num 1 v))

  let binop op =
    let f = match op with
      | Add -> IXX.add
      | Sub -> IXX.sub
      | Mul -> IXX.mul
      | Div S -> IXX.div_s
      | Div U -> IXX.div_u
      | Rem S -> IXX.rem_s
      | Rem U -> IXX.rem_u
      | And -> IXX.and_
      | Or -> IXX.or_
      | Xor -> IXX.xor
      | Shl -> IXX.shl
      | Shr U -> IXX.shr_u
      | Shr S -> IXX.shr_s
      | Rotl -> IXX.rotl
      | Rotr -> IXX.rotr
    in fun v1 v2 -> to_num (f (of_num 1 v1) (of_num 2 v2))

  let testop op =
    let f = match op with
      | Eqz -> IXX.eqz
    in fun v -> f (of_num 1 v)

  let relop op =
    let f = match op with
      | Eq -> IXX.eq
      | Ne -> IXX.ne
      | Lt S -> IXX.lt_s
      | Lt U -> IXX.lt_u
      | Le S -> IXX.le_s
      | Le U -> IXX.le_u
      | Gt S -> IXX.gt_s
      | Gt U -> IXX.gt_u
      | Ge S -> IXX.ge_s
      | Ge U -> IXX.ge_u
    in fun v1 v2 -> f (of_num 1 v1) (of_num 2 v2)
end

module I32Op = IntOp (I32) (I32Num)
module I64Op = IntOp (I64) (I64Num)


(* Float operators *)

module FloatOp (FXX : Fxx.T) (Num : NumType with type t = FXX.t) =
struct
  open Ast.FloatOp
  open Num

  let unop op =
    let f = match op with
      | Neg -> FXX.neg
      | Abs -> FXX.abs
      | Sqrt  -> FXX.sqrt
      | Ceil -> FXX.ceil
      | Floor -> FXX.floor
      | Trunc -> FXX.trunc
      | Nearest -> FXX.nearest
    in fun v -> to_num (f (of_num 1 v))

  let binop op =
    let f = match op with
      | Add -> FXX.add
      | Sub -> FXX.sub
      | Mul -> FXX.mul
      | Div -> FXX.div
      | Min -> FXX.min
      | Max -> FXX.max
      | CopySign -> FXX.copysign
    in fun v1 v2 -> to_num (f (of_num 1 v1) (of_num 2 v2))

  let testop op = assert false

  let relop op =
    let f = match op with
      | Eq -> FXX.eq
      | Ne -> FXX.ne
      | Lt -> FXX.lt
      | Le -> FXX.le
      | Gt -> FXX.gt
      | Ge -> FXX.ge
    in fun v1 v2 -> f (of_num 1 v1) (of_num 2 v2)
end

module F32Op = FloatOp (F32) (F32Num)
module F64Op = FloatOp (F64) (F64Num)


(* Conversion operators *)

module I32CvtOp =
struct
  open Ast.IntOp

  let cvtop op v =
    let i = match op with
      | WrapI64 -> Convert.I32_.wrap_i64 (I64Num.of_num 1 v)
      | TruncF32 S -> Convert.I32_.trunc_f32_s (F32Num.of_num 1 v)
      | TruncF32 U -> Convert.I32_.trunc_f32_u (F32Num.of_num 1 v)
      | TruncF64 S -> Convert.I32_.trunc_f64_s (F64Num.of_num 1 v)
      | TruncF64 U -> Convert.I32_.trunc_f64_u (F64Num.of_num 1 v)
      | TruncSatF32 S -> Convert.I32_.trunc_sat_f32_s (F32Num.of_num 1 v)
      | TruncSatF32 U -> Convert.I32_.trunc_sat_f32_u (F32Num.of_num 1 v)
      | TruncSatF64 S -> Convert.I32_.trunc_sat_f64_s (F64Num.of_num 1 v)
      | TruncSatF64 U -> Convert.I32_.trunc_sat_f64_u (F64Num.of_num 1 v)
      | ReinterpretFloat -> Convert.I32_.reinterpret_f32 (F32Num.of_num 1 v)
      | ExtendI32 _ -> raise (TypeError (1, v, I32T))
    in I32Num.to_num i
end

module I64CvtOp =
struct
  open Ast.IntOp

  let cvtop op v =
    let i = match op with
      | ExtendI32 S -> Convert.I64_.extend_i32_s (I32Num.of_num 1 v)
      | ExtendI32 U -> Convert.I64_.extend_i32_u (I32Num.of_num 1 v)
      | TruncF32 S -> Convert.I64_.trunc_f32_s (F32Num.of_num 1 v)
      | TruncF32 U -> Convert.I64_.trunc_f32_u (F32Num.of_num 1 v)
      | TruncF64 S -> Convert.I64_.trunc_f64_s (F64Num.of_num 1 v)
      | TruncF64 U -> Convert.I64_.trunc_f64_u (F64Num.of_num 1 v)
      | TruncSatF32 S -> Convert.I64_.trunc_sat_f32_s (F32Num.of_num 1 v)
      | TruncSatF32 U -> Convert.I64_.trunc_sat_f32_u (F32Num.of_num 1 v)
      | TruncSatF64 S -> Convert.I64_.trunc_sat_f64_s (F64Num.of_num 1 v)
      | TruncSatF64 U -> Convert.I64_.trunc_sat_f64_u (F64Num.of_num 1 v)
      | ReinterpretFloat -> Convert.I64_.reinterpret_f64 (F64Num.of_num 1 v)
      | WrapI64 -> raise (TypeError (1, v, I64T))
    in I64Num.to_num i
end

module F32CvtOp =
struct
  open Ast.FloatOp

  let cvtop op v =
    let z = match op with
      | DemoteF64 -> Convert.F32_.demote_f64 (F64Num.of_num 1 v)
      | ConvertI32 S -> Convert.F32_.convert_i32_s (I32Num.of_num 1 v)
      | ConvertI32 U -> Convert.F32_.convert_i32_u (I32Num.of_num 1 v)
      | ConvertI64 S -> Convert.F32_.convert_i64_s (I64Num.of_num 1 v)
      | ConvertI64 U -> Convert.F32_.convert_i64_u (I64Num.of_num 1 v)
      | ReinterpretInt -> Convert.F32_.reinterpret_i32 (I32Num.of_num 1 v)
      | PromoteF32 -> raise (TypeError (1, v, F32T))
    in F32Num.to_num z
end

module F64CvtOp =
struct
  open Ast.FloatOp

  let cvtop op v =
    let z = match op with
      | PromoteF32 -> Convert.F64_.promote_f32 (F32Num.of_num 1 v)
      | ConvertI32 S -> Convert.F64_.convert_i32_s (I32Num.of_num 1 v)
      | ConvertI32 U -> Convert.F64_.convert_i32_u (I32Num.of_num 1 v)
      | ConvertI64 S -> Convert.F64_.convert_i64_s (I64Num.of_num 1 v)
      | ConvertI64 U -> Convert.F64_.convert_i64_u (I64Num.of_num 1 v)
      | ReinterpretInt -> Convert.F64_.reinterpret_i64 (I64Num.of_num 1 v)
      | DemoteF64 -> raise (TypeError (1, v, F64T))
    in F64Num.to_num z
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
