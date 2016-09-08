(*
 * Throughout the implementation we use consistent naming conventions for
 * syntactic elements, associated with the types defined here and in a few
 * other places:
 *
 *   x : var
 *   v : value
 *   e : instrr
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
type elem_type = Types.elem_type


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

type 'a memop =
  {ty : value_type; align : int; offset : Memory.offset; sz : 'a option}
type loadop = (Memory.mem_size * Memory.extension) memop
type storeop = Memory.mem_size memop


(* Expressions *)

type var = int Source.phrase
type literal = value Source.phrase

type instr = instr' Source.phrase
and instr' =
  | Unreachable                       (* trap unconditionally *)
  | Nop                               (* do nothing *)
  | Drop                              (* forget a value *)
  | Select                            (* branchless conditional *)
  | Block of instr list               (* execute in sequence *)
  | Loop of instr list                (* loop header *)
  | Br of int * var                   (* break to n-th surrounding label *)
  | BrIf of int * var                 (* conditional break *)
  | BrTable of int * var list * var   (* indexed break *)
  | Return                            (* break from function body *)
  | If of instr list * instr list     (* conditional *)
  | Call of var                       (* call function *)
  | CallImport of var                 (* call imported function *)
  | CallIndirect of var               (* call function through table *)
  | GetLocal of var                   (* read local variable *)
  | SetLocal of var                   (* write local variable *)
  | TeeLocal of var                   (* write local variable and keep value *)
  | GetGlobal of var                  (* read global variable *)
  | SetGlobal of var                  (* write global variable *)
  | Load of loadop                    (* read memory at address *)
  | Store of storeop                  (* write memory at address *)
  | Const of literal                  (* constant *)
  | Unary of unop                     (* unary numeric operator *)
  | Binary of binop                   (* binary numeric operator *)
  | Test of testop                    (* numeric test *)
  | Compare of relop                  (* numeric comparison *)
  | Convert of cvtop                  (* conversion *)
  | CurrentMemory                     (* size of linear memory *)
  | GrowMemory                        (* grow linear memory *)


(* Globals & Functions *)

type const = instr list Source.phrase

type global = global' Source.phrase
and global' =
{
  gtype : Types.value_type;
  value : const;
}

type func = func' Source.phrase
and func' =
{
  ftype : var;
  locals : value_type list;
  body : instr list;
}


(* Tables & Memories *)

type 'size limits = 'size limits' Source.phrase
and 'size limits' =
{
  min : 'size;
  max : 'size option;
}

type table = table' Source.phrase
and table' =
{
  tlimits : Table.size limits;
  etype : elem_type;
}

type memory = memory' Source.phrase
and memory' =
{
  mlimits : Memory.size limits;
}

type 'data segment = 'data segment' Source.phrase
and 'data segment' =
{
  offset : const;
  init : 'data;
}

type table_segment = var list segment
type memory_segment = string segment


(* Modules *)

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
  types : Types.func_type list;
  globals : global list;
  table : table option;
  memory : memory option;
  funcs : func list;
  start : var option;
  elems : var list segment list;
  data : string segment list;
  imports : import list;
  exports : export list;
}
