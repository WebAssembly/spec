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

type value_type = Types.value_type Source.phrase
type expr_type = value_type option


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

type memop = {ty : Types.value_type; align : int option}
type extendop = {memop : memop; sz : Memory.mem_size; ext : Memory.extension}
type wrapop = {memop : memop; sz : Memory.mem_size}

(* Expressions *)

type var = int Source.phrase
type literal = value Source.phrase

type expr = expr' Source.phrase
and expr' =
  | Nop                                           (* do nothing *)
  | Block of expr list                            (* execute in sequence, label at end *)
  | Loop of expr list                             (* execute in sequence, label at beginning *)
  | Br of var * expr option                       (* branch to label *)
  | BrIf of var * expr * expr option              (* branch to label if expr is true *)
  | BrUnless of var * expr * expr option          (* branch to label if expr is false *)
  | BrSwitch of value_type * expr * var * (value * var) list * expr option
  | Switch of value_type * expr * arm list * expr (* switch, latter expr is default *)
                                                  (* branch to label selected by expr *)
  | Call of var * expr list                       (* call function *)
  | CallImport of var * expr list                 (* call imported function *)
  | CallIndirect of var * expr * expr list        (* call function through table *)
  | Return of expr option                         (* return, optionally with a value *)
  | GetLocal of var                               (* read local variable *)
  | SetLocal of var * expr                        (* write local variable *)
  | Load of memop * expr                          (* read memory at address *)
  | Store of memop * expr * expr                  (* write memory at address *)
  | LoadExtend of extendop * expr                 (* read memory at address and extend *)
  | StoreWrap of wrapop * expr * expr             (* wrap and write to memory at address *)
  | Const of literal                              (* constant *)
  | Unary of unop * expr                          (* unary arithmetic operator *)
  | Binary of binop * expr * expr                 (* binary arithmetic operator *)
  | Compare of relop * expr * expr                (* arithmetic comparison *)
  | Convert of cvt * expr                         (* conversion *)
  | PageSize                                      (* return host-defined page_size *)
  | MemorySize                                    (* return current size of linear memory *)
  | ResizeMemory of expr                          (* resize linear memory *)

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

type import = import' Source.phrase
and import' =
{
  module_name : string;
  func_name : string;
  func_params : value_type list;
  func_result : expr_type;
}

type table = var list Source.phrase

type module_ = module_' Source.phrase
and module_' =
{
  memory : memory option;
  funcs : func list;
  imports : import list;
  exports : export list;
  tables : table list;
}
