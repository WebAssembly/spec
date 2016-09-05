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


open Types
open Values


(* Operators *)

module IntOp =
struct
  type unop = Clz | Ctz | Popcnt
  type binop = Add | Sub | Mul | DivS | DivU | RemS | RemU
             | And | Or | Xor | Shl | ShrS | ShrU | Rotl | Rotr
  type testop = Eqz
  type relop = Eq | Ne | LtS | LtU | LeS | LeU | GtS | GtU | GeS | GeU
  type cvtop = ExtendSInt32 | ExtendUInt32 | WrapInt64
             | TruncSFloat32 | TruncUFloat32 | TruncSFloat64 | TruncUFloat64
             | ReinterpretFloat
end

module FloatOp =
struct
  type unop = Neg | Abs | Ceil | Floor | Trunc | Nearest | Sqrt
  type binop = Add | Sub | Mul | Div | Min | Max | CopySign
  type testop
  type relop = Eq | Ne | Lt | Le | Gt | Ge
  type cvtop = ConvertSInt32 | ConvertUInt32 | ConvertSInt64 | ConvertUInt64
             | PromoteFloat32 | DemoteFloat64
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

type memop = {ty : value_type; offset : Memory.offset; align : int}
type extop = {memop : memop; sz : Memory.mem_size; ext : Memory.extension}
type wrapop = {memop : memop; sz : Memory.mem_size}
type hostop =
  | CurrentMemory        (* inquire current size of linear memory *)
  | GrowMemory           (* grow linear memory *)


(* Expressions *)

type var = int Source.phrase
type literal = value Source.phrase

type expr = expr' Source.phrase
and expr' =
  | Nop                                     (* do nothing *)
  | Unreachable                             (* trap *)
  | Drop of expr                            (* forget a value *)
  | Block of expr list * expr               (* execute in sequence *)
  | Loop of expr                            (* loop header *)
  | Break of var * expr option              (* break to n-th surrounding label *)
  | BreakIf of var * expr option * expr     (* conditional break *)
  | BreakTable of var list * var * expr option * expr  (* indexed break *)
  | If of expr * expr * expr                (* conditional *)
  | Select of expr * expr * expr            (* branchless conditional *)
  | Call of var * expr list                 (* call function *)
  | CallIndirect of var * expr * expr list  (* call function through table *)
  | GetLocal of var                         (* read local variable *)
  | SetLocal of var * expr                  (* write local variable *)
  | TeeLocal of var * expr                  (* write local variable and keep value *)
  | GetGlobal of var                        (* read global variable *)
  | SetGlobal of var * expr                 (* write global variable *)
  | Load of memop * expr                    (* read memory at address *)
  | Store of memop * expr * expr            (* write memory at address *)
  | LoadExtend of extop * expr              (* read memory at address and extend *)
  | StoreWrap of wrapop * expr * expr       (* wrap and write to memory at address *)
  | Const of literal                        (* constant *)
  | Unary of unop * expr                    (* unary arithmetic operator *)
  | Binary of binop * expr * expr           (* binary arithmetic operator *)
  | Test of testop * expr                   (* arithmetic test *)
  | Compare of relop * expr * expr          (* arithmetic comparison *)
  | Convert of cvtop * expr                 (* conversion *)
  | Host of hostop * expr list              (* host interaction *)


(* Globals and Functions *)

type global = global' Source.phrase
and global' =
{
  gtype : global_type;
  value : expr;
}

type func = func' Source.phrase
and func' =
{
  ftype : var;
  locals : value_type list;
  body : expr;
}


(* Tables & Memories *)

type table = table' Source.phrase
and table' =
{
  ttype : table_type;
}

type memory = memory' Source.phrase
and memory' =
{
  mtype : memory_type;
}

type 'data segment = 'data segment' Source.phrase
and 'data segment' =
{
  index : var;
  offset : expr;
  init : 'data;
}

type table_segment = var list segment
type memory_segment = string segment


(* Modules *)

type export_kind = export_kind' Source.phrase
and export_kind' = FuncExport | TableExport | MemoryExport | GlobalExport

type export = export' Source.phrase
and export' =
{
  name : string;
  ekind : export_kind;
  item : var;
}

type import_kind = import_kind' Source.phrase
and import_kind' =
  | FuncImport of var
  | TableImport of table_type
  | MemoryImport of memory_type
  | GlobalImport of global_type

type import = import' Source.phrase
and import' =
{
  module_name : string;
  item_name : string;
  ikind : import_kind;
}

type module_ = module_' Source.phrase
and module_' =
{
  types : Types.func_type list;
  globals : global list;
  tables : table list;
  memories : memory list;
  funcs : func list;
  start : var option;
  elems : table_segment list;
  data : memory_segment list;
  imports : import list;
  exports : export list;
}
