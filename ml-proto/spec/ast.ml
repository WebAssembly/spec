(*
 * Throughout the implementation we use consistent naming conventions for
 * syntactic elements, associated with the types defined here and in a few
 * other places:
 *
 *   x : var
 *   v : value
 *   e : expr
 *   f : func
 *   m : module_
 *
 *   t : value_type
 *   s : func_type
 *   c : context / config
 *
 * These conventions mostly follow standard practice in language semantics.
 *)


open Values


(* Types *)

type value_type = Types.value_type


(* Operators *)

module IntOp =
struct
  type unop = Clz | Ctz | Popcnt
  type binop = Add | Sub | Mul | DivS | DivU | RemS | RemU
             | And | Or | Xor | Shl | ShrS | ShrU | Rotl | Rotr
  type testop = Eqz
  type relop = Eq | Ne | LtS | LtU | LeS | LeU | GtS | GtU | GeS | GeU
  type cvtop = ExtendSI32 | ExtendUI32 | WrapI64
             | TruncSF32 | TruncUF32 | TruncSF64 | TruncUF64
             | ReinterpretFloat
end

module FloatOp =
struct
  type unop = Neg | Abs | Ceil | Floor | Trunc | Nearest | Sqrt
  type binop = Add | Sub | Mul | Div | Min | Max | CopySign
  type testop
  type relop = Eq | Ne | Lt | Le | Gt | Ge
  type cvtop = ConvertSI32 | ConvertUI32 | ConvertSI64 | ConvertUI64
             | PromoteF32 | DemoteF64
             | ReinterpretInt
end

module I32Op = IntOp
module I64Op = IntOp
module F32Op = FloatOp
module F64Op = FloatOp

type unop = (I32Op.unop, I64Op.unop, F32Op.unop, F64Op.unop) op
type binop = (I32Op.binop, I64Op.binop, F32Op.binop, F64Op.binop) op
type testop = (I32Op.testop, I64Op.testop, F32Op.testop, F64Op.testop) op
type relop = (I32Op.relop, I64Op.relop, F32Op.relop, F64Op.relop) op
type cvtop = (I32Op.cvtop, I64Op.cvtop, F32Op.cvtop, F64Op.cvtop) op

type memop = {ty : value_type; align : int; offset : Memory.offset}
type extop = {memop : memop; sz : Memory.mem_size; ext : Memory.extension}
type wrapop = {memop : memop; sz : Memory.mem_size}


(* Expressions *)

type var = int Source.phrase
type literal = value Source.phrase

type expr = expr' Source.phrase
and expr' =
  | Unreachable                        (* trap *)
  | Nop                                (* do nothing *)
  | Drop                               (* forget a value *)
  | Select                             (* branchless conditional *)
  | Block of expr list                 (* execute in sequence *)
  | Loop of expr list                  (* loop header *)
  | Br of int * var                    (* break to n-th surrounding label *)
  | BrIf of int * var                  (* conditional break *)
  | BrTable of int * var list * var    (* indexed break *)
  | Return of int                      (* break from function body *)
  | If of expr list * expr list        (* conditional *)
  | Call of int * var                  (* call function *)
  | CallImport of int * var            (* call imported function *)
  | CallIndirect of int * var          (* call function through table *)
  | GetLocal of var                    (* read local variable *)
  | SetLocal of var                    (* write local variable *)
  | TeeLocal of var                    (* write local variable and keep value *)
  | Load of memop                      (* read memory at address *)
  | Store of memop                     (* write memory at address *)
  | LoadPacked of extop                (* read memory at address and extend *)
  | StorePacked of wrapop              (* wrap and write to memory at address *)
  | Const of literal                   (* constant *)
  | Unary of unop                      (* unary numeric operator *)
  | Binary of binop                    (* binary numeric operator *)
  | Test of testop                     (* numeric test *)
  | Compare of relop                   (* numeric comparison *)
  | Convert of cvtop                   (* conversion *)
  | CurrentMemory                      (* size of linear memory *)
  | GrowMemory                         (* grow linear memory *)
  | Label of expr * value list * expr list  (* control stack *)


(* Functions *)

type func = func' Source.phrase
and func' =
{
  ftype : var;
  locals : value_type list;
  body : expr list;
}


(* Modules *)

type memory = memory' Source.phrase
and memory' =
{
  min : Memory.size;
  max : Memory.size;
  segments : segment list;
}
and segment = Memory.segment Source.phrase

type export = export' Source.phrase
and export' =
{
  name : string;
  kind : [`Func of var | `Memory]
}

type import = import' Source.phrase
and import' =
{
  itype : var;
  module_name : string;
  func_name : string;
}

type module_ = module_' Source.phrase
and module_' =
{
  memory : memory option;
  types : Types.func_type list;
  funcs : func list;
  start : var option;
  imports : import list;
  exports : export list;
  table : var list;
}
