(*
 * (c) 2015 Andreas Rossberg
 *)

(*
 * Throughout the implementation we use consistent naming conventions for
 * syntactic elements, associated with the types defined here and in a few
 * other places:
 *
 *   x : var
 *   v : value
 *   e : expr
 *   f : func
 *   m : modul
 *
 *   t : value_type
 *   s : func_type
 *   c : context / config
 *
 * These conventions mostly follow standard practice in language semantics.
 *)


open Values


(* Types *)

type value_type = Types.value_type Source.phrase
type expr_type = value_type option


(* Operators *)

module IntOp () =
struct
  type unop = Clz | Ctz | Popcnt
  type binop = Add | Sub | Mul | DivS | DivU | RemS | RemU
             | And | Or | Xor | Shl | Shr | Sar
  type relop = Eq | Neq | LtS | LtU | LeS | LeU | GtS | GtU | GeS | GeU
  type cvt = ExtendSInt32 | ExtendUInt32 | WrapInt64
           | TruncSFloat32 | TruncUFloat32 | TruncSFloat64 | TruncUFloat64
           | ReinterpretFloat
end

module FloatOp () =
struct
  type unop = Neg | Abs | Ceil | Floor | Trunc | Nearest | Sqrt
  type binop = Add | Sub | Mul | Div | CopySign | Min | Max
  type relop = Eq | Neq | Lt | Le | Gt | Ge
  type cvt = ConvertSInt32 | ConvertUInt32 | ConvertSInt64 | ConvertUInt64
           | PromoteFloat32 | DemoteFloat64
           | ReinterpretInt
end

module Int32Op = IntOp ()
module Int64Op = IntOp ()
module Float32Op = FloatOp ()
module Float64Op = FloatOp ()

type unop = (Int32Op.unop, Int64Op.unop, Float32Op.unop, Float64Op.unop) op
type binop = (Int32Op.binop, Int64Op.binop, Float32Op.binop, Float64Op.binop) op
type relop = (Int32Op.relop, Int64Op.relop, Float32Op.relop, Float64Op.relop) op
type cvt = (Int32Op.cvt, Int64Op.cvt, Float32Op.cvt, Float64Op.cvt) op

type memop = {ty : Types.value_type; mem : Memory.mem_type; align : int}


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
  | Break of var * expr option
  | Switch of value_type * expr * arm list * expr
  | Call of var * expr list
  | CallIndirect of var * expr * expr list
  | Return of expr option
  | GetLocal of var
  | SetLocal of var * expr
  | LoadGlobal of var
  | StoreGlobal of var * expr
  | Load of memop * expr
  | Store of memop * expr * expr
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

type memory = memory' Source.phrase
and memory' =
{
  initial : Memory.size;
  max : Memory.size;
  segments : segment list;
}
and segment = Memory.segment Source.phrase

type func = func' Source.phrase
and func' =
{
  params : value_type list;
  result : expr_type;
  locals : value_type list;
  body : expr
}

type export = export' Source.phrase
and export' = {name : string; func : var}

type table = var list Source.phrase

type modul = modul' Source.phrase
and modul' =
{
  memory : memory option;
  funcs : func list;
  exports : export list;
  tables : table list;
  globals : value_type list
}
