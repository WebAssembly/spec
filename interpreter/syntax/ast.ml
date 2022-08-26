(*
 * Throughout the implementation we use consistent naming conventions for
 * syntactic elements, associated with the types defined here and in a few
 * other places:
 *
 *   x : idx
 *   v : value
 *   e : instr
 *   f : func
 *   m : module_
 *
 *   t : val_type
 *   s : func_type
 *   c : context / config
 *
 * These conventions mostly follow standard practice in language semantics.
 *)

(* Types *)

open Types
open Pack

type void = Lib.void


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
  type testop = |
  type relop = Eq | Ne | Lt | Gt | Le | Ge
  type cvtop = ConvertSI32 | ConvertUI32 | ConvertSI64 | ConvertUI64
             | PromoteF32 | DemoteF64
             | ReinterpretInt
end

module I32Op = IntOp
module I64Op = IntOp
module F32Op = FloatOp
module F64Op = FloatOp

module V128Op =
struct
  type itestop = AllTrue
  type iunop = Abs | Neg | Popcnt
  type funop = Abs | Neg | Sqrt | Ceil | Floor | Trunc | Nearest
  type ibinop = Add | Sub | Mul | MinS | MinU | MaxS | MaxU | AvgrU
              | AddSatS | AddSatU | SubSatS | SubSatU | DotS | Q15MulRSatS
              | ExtMulLowS | ExtMulHighS | ExtMulLowU | ExtMulHighU
              | Swizzle | Shuffle of int list | NarrowS | NarrowU
  type fbinop = Add | Sub | Mul | Div | Min | Max | Pmin | Pmax
  type irelop = Eq | Ne | LtS | LtU | LeS | LeU | GtS | GtU | GeS | GeU
  type frelop = Eq | Ne | Lt | Le | Gt | Ge
  type icvtop = ExtendLowS | ExtendLowU | ExtendHighS | ExtendHighU
              | ExtAddPairwiseS | ExtAddPairwiseU
              | TruncSatSF32x4 | TruncSatUF32x4
              | TruncSatSZeroF64x2 | TruncSatUZeroF64x2
  type fcvtop = DemoteZeroF64x2 | PromoteLowF32x4
              | ConvertSI32x4 | ConvertUI32x4
  type ishiftop = Shl | ShrS | ShrU
  type ibitmaskop = Bitmask

  type vtestop = AnyTrue
  type vunop = Not
  type vbinop = And | Or | Xor | AndNot
  type vternop = Bitselect

  type testop = (itestop, itestop, itestop, itestop, void, void) V128.laneop
  type unop = (iunop, iunop, iunop, iunop, funop, funop) V128.laneop
  type binop = (ibinop, ibinop, ibinop, ibinop, fbinop, fbinop) V128.laneop
  type relop = (irelop, irelop, irelop, irelop, frelop, frelop) V128.laneop
  type cvtop = (icvtop, icvtop, icvtop, icvtop, fcvtop, fcvtop) V128.laneop
  type shiftop = (ishiftop, ishiftop, ishiftop, ishiftop, void, void) V128.laneop
  type bitmaskop = (ibitmaskop, ibitmaskop, ibitmaskop, ibitmaskop, void, void) V128.laneop

  type nsplatop = Splat
  type 'a nextractop = Extract of int * 'a
  type nreplaceop = Replace of int

  type splatop = (nsplatop, nsplatop, nsplatop, nsplatop, nsplatop, nsplatop) V128.laneop
  type extractop = (extension nextractop, extension nextractop, unit nextractop, unit nextractop, unit nextractop, unit nextractop) V128.laneop
  type replaceop = (nreplaceop, nreplaceop, nreplaceop, nreplaceop, nreplaceop, nreplaceop) V128.laneop
end

type testop = (I32Op.testop, I64Op.testop, F32Op.testop, F64Op.testop) Value.op
type unop = (I32Op.unop, I64Op.unop, F32Op.unop, F64Op.unop) Value.op
type binop = (I32Op.binop, I64Op.binop, F32Op.binop, F64Op.binop) Value.op
type relop = (I32Op.relop, I64Op.relop, F32Op.relop, F64Op.relop) Value.op
type cvtop = (I32Op.cvtop, I64Op.cvtop, F32Op.cvtop, F64Op.cvtop) Value.op

type vec_testop = (V128Op.testop) Value.vecop
type vec_relop = (V128Op.relop) Value.vecop
type vec_unop = (V128Op.unop) Value.vecop
type vec_binop = (V128Op.binop) Value.vecop
type vec_cvtop = (V128Op.cvtop) Value.vecop
type vec_shiftop = (V128Op.shiftop) Value.vecop
type vec_bitmaskop = (V128Op.bitmaskop) Value.vecop
type vec_vtestop = (V128Op.vtestop) Value.vecop
type vec_vunop = (V128Op.vunop) Value.vecop
type vec_vbinop = (V128Op.vbinop) Value.vecop
type vec_vternop = (V128Op.vternop) Value.vecop
type vec_splatop = (V128Op.splatop) Value.vecop
type vec_extractop = (V128Op.extractop) Value.vecop
type vec_replaceop = (V128Op.replaceop) Value.vecop

type ('t, 'p) memop = {ty : 't; align : int; offset : int32; pack : 'p}
type loadop = (num_type, (pack_size * extension) option) memop
type storeop = (num_type, pack_size option) memop

type vec_loadop = (vec_type, (pack_size * vec_extension) option) memop
type vec_storeop = (vec_type, unit) memop
type vec_laneop = (vec_type, pack_size) memop * int


(* Expressions *)

type idx = int32 Source.phrase
type num = Value.num Source.phrase
type vec = Value.vec Source.phrase
type name = Utf8.unicode

type block_type = VarBlockType of idx | ValBlockType of val_type option

type instr = instr' Source.phrase
and instr' =
  | Unreachable                       (* trap unconditionally *)
  | Nop                               (* do nothing *)
  | Drop                              (* forget a value *)
  | Select of val_type list option    (* branchless conditional *)
  | Block of block_type * instr list  (* execute in sequence *)
  | Loop of block_type * instr list   (* loop header *)
  | If of block_type * instr list * instr list   (* conditional *)
  | Br of idx                         (* break to n-th surrounding label *)
  | BrIf of idx                       (* conditional break *)
  | BrTable of idx list * idx         (* indexed break *)
  | BrOnNull of idx                   (* break on null *)
  | BrOnNonNull of idx                (* break on non-null *)
  | Return                            (* break from function body *)
  | Call of idx                       (* call function *)
  | CallRef of idx                    (* call function through reference *)
  | CallIndirect of idx * idx         (* call function through table *)
  | ReturnCallRef of idx              (* tail call through reference *)
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
  | VecLoad of vec_loadop             (* read memory at address *)
  | VecStore of vec_storeop           (* write memory at address *)
  | VecLoadLane of vec_laneop         (* read single lane at address *)
  | VecStoreLane of vec_laneop        (* write single lane to address *)
  | MemorySize                        (* size of memory *)
  | MemoryGrow                        (* grow memory *)
  | MemoryFill                        (* fill memory range with value *)
  | MemoryCopy                        (* copy memory ranges *)
  | MemoryInit of idx                 (* initialize memory range from segment *)
  | DataDrop of idx                   (* drop passive data segment *)
  | RefNull of heap_type              (* null reference *)
  | RefIsNull                         (* null test *)
  | RefAsNonNull                      (* null cast *)
  | RefFunc of idx                    (* function reference *)
  | Const of num                      (* constant *)
  | Test of testop                    (* numeric test *)
  | Compare of relop                  (* numeric comparison *)
  | Unary of unop                     (* unary numeric operator *)
  | Binary of binop                   (* binary numeric operator *)
  | Convert of cvtop                  (* conversion *)
  | VecConst of vec                   (* constant *)
  | VecTest of vec_testop             (* vector test *)
  | VecCompare of vec_relop           (* vector comparison *)
  | VecUnary of vec_unop              (* unary vector operator *)
  | VecBinary of vec_binop            (* binary vector operator *)
  | VecConvert of vec_cvtop           (* vector conversion *)
  | VecShift of vec_shiftop           (* vector shifts *)
  | VecBitmask of vec_bitmaskop       (* vector masking *)
  | VecTestBits of vec_vtestop        (* vector bit test *)
  | VecUnaryBits of vec_vunop         (* unary bit vector operator *)
  | VecBinaryBits of vec_vbinop       (* binary bit vector operator *)
  | VecTernaryBits of vec_vternop     (* ternary bit vector operator *)
  | VecSplat of vec_splatop           (* number to vector conversion *)
  | VecExtract of vec_extractop       (* extract lane from vector *)
  | VecReplace of vec_replaceop       (* replace lane in vector *)


(* Locals, globals & Functions *)

type const = instr list Source.phrase

type local = local' Source.phrase
and local' =
{
  ltype : val_type;
}

type global = global' Source.phrase
and global' =
{
  gtype : global_type;
  ginit : const;
}

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
  tinit : const;
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

type start = start' Source.phrase
and start' =
{
  sfunc : idx;
}

type module_ = module_' Source.phrase
and module_' =
{
  types : type_ list;
  globals : global list;
  tables : table list;
  memories : memory list;
  funcs : func list;
  start : start option;
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

let func_type_of (m : module_) (x : idx) : func_type =
  as_func_def_type (Lib.List32.nth m.it.types x.it).it

let import_type_of (m : module_) (im : import) : import_type =
  let {idesc; module_name; item_name} = im.it in
  let et =
    match idesc.it with
    | FuncImport x -> ExternFuncT (func_type_of m x)
    | TableImport t -> ExternTableT t
    | MemoryImport t -> ExternMemoryT t
    | GlobalImport t -> ExternGlobalT t
  in ImportT (et, module_name, item_name)

let export_type_of (m : module_) (ex : export) : export_type =
  let {edesc; name} = ex.it in
  let its = List.map (import_type_of m) m.it.imports in
  let ets = List.map extern_type_of_import_type its in
  let open Lib.List32 in
  let et =
    match edesc.it with
    | FuncExport x ->
      let fts =
        funcs ets @ List.map (fun f -> func_type_of m f.it.ftype) m.it.funcs
      in ExternFuncT (nth fts x.it)
    | TableExport x ->
      let tts = tables ets @ List.map (fun t -> t.it.ttype) m.it.tables in
      ExternTableT (nth tts x.it)
    | MemoryExport x ->
      let mts = memories ets @ List.map (fun m -> m.it.mtype) m.it.memories in
      ExternMemoryT (nth mts x.it)
    | GlobalExport x ->
      let gts = globals ets @ List.map (fun g -> g.it.gtype) m.it.globals in
      ExternGlobalT (nth gts x.it)
  in ExportT (et, name)

let module_type_of (m : module_) : module_type =
  let dts = List.map Source.it m.it.types in
  let its = List.map (import_type_of m) m.it.imports in
  let ets = List.map (export_type_of m) m.it.exports in
  ModuleT (dts, its, ets)
