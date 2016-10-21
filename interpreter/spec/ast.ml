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

open Types


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

type unop = (I32Op.unop, I64Op.unop, F32Op.unop, F64Op.unop) Values.op
type binop = (I32Op.binop, I64Op.binop, F32Op.binop, F64Op.binop) Values.op
type testop = (I32Op.testop, I64Op.testop, F32Op.testop, F64Op.testop) Values.op
type relop = (I32Op.relop, I64Op.relop, F32Op.relop, F64Op.relop) Values.op
type cvtop = (I32Op.cvtop, I64Op.cvtop, F32Op.cvtop, F64Op.cvtop) Values.op

type 'a memop =
  {ty : value_type; align : int; offset : Memory.offset; sz : 'a option}
type loadop = (Memory.mem_size * Memory.extension) memop
type storeop = Memory.mem_size memop


(* Expressions *)

type var = int32 Source.phrase
type literal = Values.value Source.phrase

type instr = instr' Source.phrase
and instr' =
  | Unreachable                       (* trap unconditionally *)
  | Nop                               (* do nothing *)
  | Drop                              (* forget a value *)
  | Select                            (* branchless conditional *)
  | Block of stack_type * instr list  (* execute in sequence *)
  | Loop of stack_type * instr list   (* loop header *)
  | Br of var                         (* break to n-th surrounding label *)
  | BrIf of var                       (* conditional break *)
  | BrTable of var list * var         (* indexed break *)
  | Return                            (* break from function body *)
  | If of stack_type * instr list * instr list  (* conditional *)
  | Call of var                       (* call function *)
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
  gtype : global_type;
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
  offset : const;
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
  types : func_type list;
  globals : global list;
  tables : table list;
  memories : memory list;
  funcs : func list;
  start : var option;
  elems : var list segment list;
  data : string segment list;
  imports : import list;
  exports : export list;
}


(* Auxiliary functions *)

let empty_module =
{
  types = [];
  globals = [];
  tables = [];
  memories = [];
  funcs = [];
  start = None;
  elems  = [];
  data = [];
  imports = [];
  exports = [];
}

open Source

let import_type (m : module_) (ekind : export_kind) (item : var)
  : int32 * external_type option =
  let rec loop i (ims : import list) =
    let i' = Int32.sub i 1l in
    match ims with
    | [] -> i, None
    | im::ims' ->
    match im.it.ikind.it, ekind.it with
    | FuncImport x, FuncExport ->
      if i = 0l
      then i, Some (ExternalFuncType (Lib.List32.nth m.it.types x.it))
      else loop i' ims'
    | TableImport t, TableExport ->
      if i = 0l then i, Some (ExternalTableType t) else loop i' ims'
    | MemoryImport t, MemoryExport ->
      if i = 0l then i, Some (ExternalMemoryType t) else loop i' ims'
    | GlobalImport t, GlobalExport ->
      if i = 0l then i, Some (ExternalGlobalType t) else loop i' ims'
    | _ -> loop i ims'
  in loop item.it m.it.imports

let export_type (m : module_) (ex : export) : external_type =
  let {ekind; item; _} = ex.it in
  match import_type m ekind item with
  | _, Some t -> t
  | n, None ->
  match ekind.it with
  | FuncExport ->
    ExternalFuncType
      (Lib.List32.nth m.it.types (Lib.List32.nth m.it.funcs n).it.ftype.it)
  | TableExport -> ExternalTableType (Lib.List32.nth m.it.tables n).it.ttype
  | MemoryExport -> ExternalMemoryType (Lib.List32.nth m.it.memories n).it.mtype
  | GlobalExport -> ExternalGlobalType (Lib.List32.nth m.it.globals n).it.gtype
