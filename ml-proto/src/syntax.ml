(*
 * (c) 2015 Andreas Rossberg
 *)

open Values


(* Types *)

type value_type = Types.value_type Source.phrase


(* Operators *)

module IntOp () =
struct
  type unop = Neg | Abs | Not | Clz | Ctz
  type binop = Add | Sub | Mul | DivS | DivU | ModS | ModU
             | And | Or | Xor | Shl | Shr | Sar
  type relop = Eq | Neq | LtS | LtU | LeS | LeU | GtS | GtU | GeS | GeU
  type cvt = ToInt32S | ToInt32U | ToInt64S | ToInt64U
           | ToFloat32S | ToFloat32U | ToFloat64S | ToFloat64U | ToFloatCast
end

module FloatOp () =
struct
  type unop = Neg | Abs | Ceil | Floor | Trunc | Round
  type binop = Add | Sub | Mul | Div | Mod | CopySign
  type relop = Eq | Neq | Lt | Le | Gt | Ge
  type cvt = ToInt32S | ToInt32U | ToInt64S | ToInt64U | ToIntCast
           | ToFloat32 | ToFloat64
end

module Int32Op = IntOp ()
module Int64Op = IntOp ()
module Float32Op = FloatOp ()
module Float64Op = FloatOp ()

type unop = (Int32Op.unop, Int64Op.unop, Float32Op.unop, Float64Op.unop) op
type binop = (Int32Op.binop, Int64Op.binop, Float32Op.binop, Float64Op.binop) op
type relop = (Int32Op.relop, Int64Op.relop, Float32Op.relop, Float64Op.relop) op
type cvt = (Int32Op.cvt, Int64Op.cvt, Float32Op.cvt, Float64Op.cvt) op

type dist = Near | Far
type memop = {dist : dist; align : Memory.alignment; mem : Memory.mem_type}


(* Expressions *)

type var = int Source.phrase
type literal = value Source.phrase

type expr = expr' Source.phrase
and expr' =
  | Nop
  | Block of expr list
  | If of expr * expr * expr
  | Loop of expr
  | Label of expr
  | Break of var * expr list
  | Switch of expr * arm list * expr
  | Call of var * expr list
  | Dispatch of var * expr * expr list
  | Return of expr list
  | Destruct of var list * expr
  | GetLocal of var
  | SetLocal of var * expr
  | GetGlobal of var
  | SetGlobal of var * expr
  | GetMemory of memop * expr
  | SetMemory of memop * expr * expr
  | Const of literal
  | Unary of unop * expr
  | Binary of binop * expr * expr
  | Compare of relop * expr * expr
  | Convert of cvt * expr

and arm = arm' Source.phrase
and arm' =
{
  value : literal;
  expr : expr;
  fallthru : bool
}


(* Functions and Modules *)

type func = func' Source.phrase
and func' =
{
  params : value_type list;
  results : value_type list;
  locals : value_type list;
  body : expr
}

type table = var list Source.phrase

type modul = modul' Source.phrase
and modul' =
{
  memory : int64 * int64;
  funcs : func list;
  exports : var list;
  tables : table list;
  globals : value_type list
}
