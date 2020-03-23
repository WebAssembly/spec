(*
 * Throughout the implementation we use consistent naming conventions for
 * syntactic elements, associated with the types defined here and in a few
 * other places:
 *
 *   x : idx
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
  type relop = Eq | Ne | LtS | LtU | GtS | GtU | LeS | LeU | GeS | GeU
  type cvtop = ExtendSI32 | ExtendUI32 | WrapI64
             | TruncSF32 | TruncUF32 | TruncSF64 | TruncUF64
             | ReinterpretFloat
end

module FloatOp =
struct
  type unop = Neg | Abs | Ceil | Floor | Trunc | Nearest | Sqrt
  type binop = Add | Sub | Mul | Div | Min | Max | CopySign
  type testop
  type relop = Eq | Ne | Lt | Gt | Le | Ge
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

type 'a memop = {ty : num_type; align : int; offset : int32; sz : 'a option}
type loadop = (Memory.pack_size * Memory.extension) memop
type storeop = Memory.pack_size memop


(* Expressions *)

type idx = int32 Source.phrase
type num = Values.num Source.phrase
type name = int list

type instr = instr' Source.phrase
and instr' =
  | Unreachable                       (* trap unconditionally *)
  | Nop                               (* do nothing *)
  | Drop                              (* forget a value *)
  | Select of value_type list option  (* branchless conditional *)
  | Block of stack_type * instr list  (* execute in sequence *)
  | Loop of stack_type * instr list   (* loop header *)
  | If of stack_type * instr list * instr list  (* conditional *)
  | Br of idx                         (* break to n-th surrounding label *)
  | BrIf of idx                       (* conditional break *)
  | BrTable of idx list * idx         (* indexed break *)
  | Return                            (* break from function body *)
  | Call of idx                       (* call function *)
  | CallRef                           (* call function through reference *)
  | CallIndirect of idx * idx         (* call function through table *)
  | ReturnCallRef                     (* tail call through reference *)
  | LocalGet of idx                   (* read local idxiable *)
  | LocalSet of idx                   (* write local idxiable *)
  | LocalTee of idx                   (* write local idxiable and keep value *)
  | GlobalGet of idx                  (* read global idxiable *)
  | GlobalSet of idx                  (* write global idxiable *)
  | TableGet of idx                   (* read table element *)
  | TableSet of idx                   (* write table element *)
  | TableSize of idx                  (* size of table *)
  | TableGrow of idx                  (* grow table *)
  | TableFill of idx                  (* fill table with unique value *)
  | TableCopy of idx * idx            (* copy table range *)
  | TableInit of idx * idx            (* initialize table range from segment *)
  | ElemDrop of idx                   (* drop passive element segment *)
  | Load of loadop                    (* read memory at address *)
  | Store of storeop                  (* write memory at address *)
  | MemorySize                        (* size of memory *)
  | MemoryGrow                        (* grow memory *)
  | MemoryFill                        (* fill memory range with value *)
  | MemoryCopy                        (* copy memory ranges *)
  | MemoryInit of idx                 (* initialize memory range from segment *)
  | DataDrop of idx                   (* drop passive data segment *)
  | RefNull                           (* null reference *)
  | RefIsNull                         (* null test *)
  | RefFunc of idx                    (* function reference *)
  | Const of num                      (* constant *)
  | Test of testop                    (* numeric test *)
  | Compare of relop                  (* numeric comparison *)
  | Unary of unop                     (* unary numeric operator *)
  | Binary of binop                   (* binary numeric operator *)
  | Convert of cvtop                  (* conversion *)


(* Globals & Functions *)

type const = instr list Source.phrase

type global = global' Source.phrase
and global' =
{
  gtype : global_type;
  ginit : const;
}

type local = local' Source.phrase
and local' = value_type

type func = func' Source.phrase
and func' =
{
  ftype : idx;
  locals : local list;
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

type segment_mode = segment_mode' Source.phrase
and segment_mode' =
  | Passive
  | Active of {index : idx; offset : const}
  | Declarative

type elem_segment = elem_segment' Source.phrase
and elem_segment' =
{
  etype : ref_type;
  einit : const list;
  emode : segment_mode;
}

type data_segment = data_segment' Source.phrase
and data_segment' =
{
  dinit : string;
  dmode : segment_mode;
}


(* Modules *)

type type_ = def_type Source.phrase

type export_desc = export_desc' Source.phrase
and export_desc' =
  | FuncExport of idx
  | TableExport of idx
  | MemoryExport of idx
  | GlobalExport of idx

type export = export' Source.phrase
and export' =
{
  name : name;
  edesc : export_desc;
}

type import_desc = import_desc' Source.phrase
and import_desc' =
  | FuncImport of idx
  | TableImport of table_type
  | MemoryImport of memory_type
  | GlobalImport of global_type

type import = import' Source.phrase
and import' =
{
  module_name : name;
  item_name : name;
  idesc : import_desc;
}

type module_ = module_' Source.phrase
and module_' =
{
  types : type_ list;
  globals : global list;
  tables : table list;
  memories : memory list;
  funcs : func list;
  start : idx option;
  elems : elem_segment list;
  datas : data_segment list;
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
  elems = [];
  datas = [];
  imports = [];
  exports = [];
}

open Source

let func_type_for (m : module_) (x : idx) : func_type =
  as_func_def_type (Lib.List32.nth m.it.types x.it).it

let import_type (m : module_) (im : import) : extern_type =
  let {idesc; _} = im.it in
  match idesc.it with
  | FuncImport x -> ExternFuncType (func_type_for m x)
  | TableImport t -> ExternTableType t
  | MemoryImport t -> ExternMemoryType t
  | GlobalImport t -> ExternGlobalType t

let export_type (m : module_) (ex : export) : extern_type =
  let {edesc; _} = ex.it in
  let its = List.map (import_type m) m.it.imports in
  let open Lib.List32 in
  match edesc.it with
  | FuncExport x ->
    let fts =
      funcs its @ List.map (fun f -> func_type_for m f.it.ftype) m.it.funcs
    in ExternFuncType (nth fts x.it)
  | TableExport x ->
    let tts = tables its @ List.map (fun t -> t.it.ttype) m.it.tables in
    ExternTableType (nth tts x.it)
  | MemoryExport x ->
    let mts = memories its @ List.map (fun m -> m.it.mtype) m.it.memories in
    ExternMemoryType (nth mts x.it)
  | GlobalExport x ->
    let gts = globals its @ List.map (fun g -> g.it.gtype) m.it.globals in
    ExternGlobalType (nth gts x.it)

let string_of_name n =
  let b = Buffer.create 16 in
  let escape uc =
    if uc < 0x20 || uc >= 0x7f then
      Buffer.add_string b (Printf.sprintf "\\u{%02x}" uc)
    else begin
      let c = Char.chr uc in
      if c = '\"' || c = '\\' then Buffer.add_char b '\\';
      Buffer.add_char b c
    end
  in
  List.iter escape n;
  Buffer.contents b

