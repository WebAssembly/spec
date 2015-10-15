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

module IntOp () =
struct
  type unop = Clz | Ctz | Popcnt
  type binop = Add | Sub | Mul | DivS | DivU | RemS | RemU
             | And | Or | Xor | Shl | ShrU | ShrS
  type relop = Eq | Ne | LtS | LtU | LeS | LeU | GtS | GtU | GeS | GeU
  type cvt = ExtendSInt32 | ExtendUInt32 | WrapInt64
           | TruncSFloat32 | TruncUFloat32 | TruncSFloat64 | TruncUFloat64
           | ReinterpretFloat
end

module FloatOp () =
struct
  type unop = Neg | Abs | Ceil | Floor | Trunc | Nearest | Sqrt
  type binop = Add | Sub | Mul | Div | CopySign | Min | Max
  type relop = Eq | Ne | Lt | Le | Gt | Ge
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

type memop = {ty : value_type; offset : Memory.offset; align : int option}
type extop = {memop : memop; sz : Memory.mem_size; ext : Memory.extension}
type wrapop = {memop : memop; sz : Memory.mem_size}
type hostop =
  | PageSize           (* inquire host-defined page size *)
  | MemorySize         (* inquire current size of linear memory *)
  | GrowMemory         (* grow linear memory *)


(* Expressions *)

type var = int Source.phrase
type literal = value Source.phrase

type expr = expr' Source.phrase
and expr' =
  | Nop                                            (* do nothing *)
  | Block of expr list                             (* execute in sequence *)
  | If of expr * expr * expr                       (* conditional *)
  | Loop of expr                                   (* infinite loop *)
  | Label of expr                                  (* labelled expression *)
  | Break of var * expr option                     (* break to n-th surrounding label *)
  | Switch of value_type * expr * case list * expr (* switch, latter expr is default *)
  | Call of var * expr list                        (* call function *)
  | CallImport of var * expr list                  (* call imported function *)
  | CallIndirect of var * expr * expr list         (* call function through table *)
  | GetLocal of var                                (* read local variable *)
  | SetLocal of var * expr                         (* write local variable *)
  | Load of memop * expr                           (* read memory at address *)
  | Store of memop * expr * expr                   (* write memory at address *)
  | LoadExtend of extop * expr                     (* read memory at address and extend *)
  | StoreWrap of wrapop * expr * expr              (* wrap and write to memory at address *)
  | Const of literal                               (* constant *)
  | Unary of unop * expr                           (* unary arithmetic operator *)
  | Binary of binop * expr * expr                  (* binary arithmetic operator *)
  | Compare of relop * expr * expr                 (* arithmetic comparison *)
  | Convert of cvt * expr                          (* conversion *)
  | Host of hostop * expr list                     (* host interaction *)

and case = case' Source.phrase
and case' =
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
  ftype : var;
  locals : value_type list;
  body : expr;
}

type export = export' Source.phrase
and export' = {name : string; func : var}

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
  imports : import list;
  exports : export list;
  table : var list;
}
