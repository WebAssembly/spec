(*
 * Throughout the implementation we use consistent naming conventions for
 * syntactic elements, associated with the types defined here and in a few
 * other places:
 *
 *   x : var
 *   v : value
 *   e : instr
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
  type unop = Clz | Ctz | Popcnt | ExtendS of pack_size
  type binop = Add | Sub | Mul | DivS | DivU | RemS | RemU
             | And | Or | Xor | Shl | ShrS | ShrU | Rotl | Rotr
  type testop = Eqz
  type relop = Eq | Ne | LtS | LtU | GtS | GtU | LeS | LeU | GeS | GeU
  type cvtop = ExtendSI32 | ExtendUI32 | WrapI64
             | TruncSF32 | TruncUF32 | TruncSF64 | TruncUF64
             | TruncSatSF32 | TruncSatUF32 | TruncSatSF64 | TruncSatUF64
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
type loadop = (pack_size * extension) memop
type storeop = pack_size memop


(* Expressions *)

type var = int32 Source.phrase
type num = Values.num Source.phrase
type name = int list

type block_type = VarBlockType of var | ValBlockType of value_type option

type instr = instr' Source.phrase
and instr' =
  | Unreachable                       (* trap unconditionally *)
  | Nop                               (* do nothing *)
  | Drop                              (* forget a value *)
  | Select of value_type list option  (* branchless conditional *)
  | Block of block_type * instr list  (* execute in sequence *)
  | Loop of block_type * instr list   (* loop header *)
  | If of block_type * instr list * instr list  (* conditional *)
  | Br of var                         (* break to n-th surrounding label *)
  | BrIf of var                       (* conditional break *)
  | BrTable of var list * var         (* indexed break *)
  | Return                            (* break from function body *)
  | Call of var                       (* call function *)
  | CallIndirect of var * var         (* call function through table *)
  | LocalGet of var                   (* read local variable *)
  | LocalSet of var                   (* write local variable *)
  | LocalTee of var                   (* write local variable and keep value *)
  | GlobalGet of var                  (* read global variable *)
  | GlobalSet of var                  (* write global variable *)
  | TableGet of var                   (* read table element *)
  | TableSet of var                   (* write table element *)
  | TableSize of var                  (* size of table *)
  | TableGrow of var                  (* grow table *)
  | TableFill of var                  (* fill table range with value *)
  | TableCopy of var * var            (* copy table range *)
  | TableInit of var * var            (* initialize table range from segment *)
  | ElemDrop of var                   (* drop passive element segment *)
  | Load of loadop                    (* read memory at address *)
  | Store of storeop                  (* write memory at address *)
  | MemorySize                        (* size of memory *)
  | MemoryGrow                        (* grow memory *)
  | MemoryFill                        (* fill memory range with value *)
  | MemoryCopy                        (* copy memory ranges *)
  | MemoryInit of var                 (* initialize memory range from segment *)
  | DataDrop of var                   (* drop passive data segment *)
  | RefNull of ref_type               (* null reference *)
  | RefFunc of var                    (* function reference *)
  | RefIsNull                         (* null test *)
  | Const of num                      (* constant *)
  | Test of testop                    (* numeric test *)
  | Compare of relop                  (* numeric comparison *)
  | Unary of unop                     (* unary numeric operator *)
  | Binary of binop                   (* binary numeric operator *)
  | Convert of cvtop                  (* conversion *)
  | TryCatch of block_type * instr list * (* try *)
                (var * instr list) list * (* catch exception with tag *)
                instr list option     (* catch_all *)
  | TryDelegate of block_type * instr list * (* try *)
                   var                (* delegate to outer handler *)
  | Throw of var                      (* throw exception *)
  | Rethrow of var                    (* rethrow exception *)


(* Globals & Functions *)

type const = instr list Source.phrase

type global = global' Source.phrase
and global' =
{
  gtype : global_type;
  ginit : const;
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

type tag = tag' Source.phrase
and tag' =
{
  tgtype : var;
}


type segment_mode = segment_mode' Source.phrase
and segment_mode' =
  | Passive
  | Active of {index : var; offset : const}
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

type type_ = func_type Source.phrase

type export_desc = export_desc' Source.phrase
and export_desc' =
  | FuncExport of var
  | TableExport of var
  | MemoryExport of var
  | GlobalExport of var
  | TagExport of var

type export = export' Source.phrase
and export' =
{
  name : name;
  edesc : export_desc;
}

type import_desc = import_desc' Source.phrase
and import_desc' =
  | FuncImport of var
  | TableImport of table_type
  | MemoryImport of memory_type
  | GlobalImport of global_type
  | TagImport of var

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
  tags : tag list;
  funcs : func list;
  start : var option;
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
  tags = [];
  funcs = [];
  start = None;
  elems = [];
  datas = [];
  imports = [];
  exports = [];
}

open Source

let func_type_for (m : module_) (x : var) : func_type =
  (Lib.List32.nth m.it.types x.it).it

let import_type (m : module_) (im : import) : extern_type =
  let {idesc; _} = im.it in
  match idesc.it with
  | FuncImport x -> ExternFuncType (func_type_for m x)
  | TableImport t -> ExternTableType t
  | MemoryImport t -> ExternMemoryType t
  | TagImport x -> ExternTagType (func_type_for m x)
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
  | TagExport x ->
    let tts =
      tags its @ List.map (fun t -> func_type_for m t.it.tgtype) m.it.tags
    in ExternTagType (nth tts x.it)

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

