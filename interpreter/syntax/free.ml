open Source
open Ast
open Types

module Set = Set.Make(Int32)

type t =
{
  types : Set.t;
  globals : Set.t;
  tables : Set.t;
  memories : Set.t;
  funcs : Set.t;
  elems : Set.t;
  datas : Set.t;
  locals : Set.t;
  labels : Set.t;
}

let empty : t =
{
  types = Set.empty;
  globals = Set.empty;
  tables = Set.empty;
  memories = Set.empty;
  funcs = Set.empty;
  elems = Set.empty;
  datas = Set.empty;
  locals = Set.empty;
  labels = Set.empty;
}

let union (s1 : t) (s2 : t) : t =
{
  types = Set.union s1.types s2.types;
  globals = Set.union s1.globals s2.globals;
  tables = Set.union s1.tables s2.tables;
  memories = Set.union s1.memories s2.memories;
  funcs = Set.union s1.funcs s2.funcs;
  elems = Set.union s1.elems s2.elems;
  datas = Set.union s1.datas s2.datas;
  locals = Set.union s1.locals s2.locals;
  labels = Set.union s1.labels s2.labels;
}

let types s = {empty with types = s}
let globals s = {empty with globals = s}
let tables s = {empty with tables = s}
let memories s = {empty with memories = s}
let funcs s = {empty with funcs = s}
let elems s = {empty with elems = s}
let datas s = {empty with datas = s}
let locals s = {empty with locals = s}
let labels s = {empty with labels = s}

let idx' x' = Set.singleton x'
let idx x = Set.singleton x.it
let zero = Set.singleton 0l
let shift s = Set.map (Int32.add (-1l)) (Set.remove 0l s)

let (++) = union
let opt free xo = Lib.Option.get (Option.map free xo) empty
let list free xs = List.fold_left union empty (List.map free xs)

let var_type = function
  | SynVar x -> types (idx' x)
  | SemVar _ -> assert false

let num_type = function
  | I32Type | I64Type | F32Type | F64Type -> empty

let vec_type = function
  | V128Type -> empty

let heap_type = function
  | FuncHeapType | ExternHeapType | BotHeapType -> empty
  | DefHeapType x -> var_type x

let ref_type = function
  | (_, t) -> heap_type t

let value_type = function
  | NumType t -> num_type t
  | VecType t -> vec_type t
  | RefType t -> ref_type t
  | BotType -> empty

let func_type (FuncType (ins, out)) =
  list value_type ins ++ list value_type out
let global_type (GlobalType (t, _mut)) = value_type t
let table_type (TableType (_lim, t)) = ref_type t
let memory_type (MemoryType (_lim)) = empty

let def_type = function
  | FuncDefType ft -> func_type ft

let block_type = function
  | VarBlockType x -> var_type x
  | ValBlockType t -> opt value_type t

let rec instr (e : instr) =
  match e.it with
  | Unreachable | Nop | Drop -> empty
  | Select tso -> list value_type (Lib.Option.get tso [])
  | RefIsNull | RefAsNonNull -> empty
  | RefNull t -> heap_type t
  | RefFunc x -> funcs (idx x)
  | Const _ | Test _ | Compare _ | Unary _ | Binary _ | Convert _ -> empty
  | Block (bt, es) | Loop (bt, es) -> block_type bt ++ block es
  | If (bt, es1, es2) -> block_type bt ++ block es1 ++ block es2
  | Let (bt, ts, es) ->
    let free = block_type bt ++ block es in
    {free with locals = Lib.Fun.repeat (List.length ts) shift free.locals}
  | Br x | BrIf x | BrOnNull x | BrOnNonNull x -> labels (idx x)
  | BrTable (xs, x) -> list (fun x -> labels (idx x)) (x::xs)
  | Return | CallRef | ReturnCallRef -> empty
  | Call x -> funcs (idx x)
  | CallIndirect (x, y) -> tables (idx x) ++ types (idx y)
  | FuncBind x -> types (idx x)
  | LocalGet x | LocalSet x | LocalTee x -> locals (idx x)
  | GlobalGet x | GlobalSet x -> globals (idx x)
  | TableGet x | TableSet x | TableSize x | TableGrow x | TableFill x ->
    tables (idx x)
  | TableCopy (x, y) -> tables (idx x) ++ tables (idx y)
  | TableInit (x, y) -> tables (idx x) ++ elems (idx y)
  | ElemDrop x -> elems (idx x)
  | Load _ | Store _
  | VecLoad _ | VecStore _ | VecLoadLane _ | VecStoreLane _
  | MemorySize | MemoryGrow | MemoryCopy | MemoryFill ->
    memories zero
  | VecConst _ | VecTest _ | VecUnary _ | VecBinary _ | VecCompare _
  | VecConvert _ | VecShift _ | VecBitmask _
  | VecTestBits _ | VecUnaryBits _ | VecBinaryBits _ | VecTernaryBits _
  | VecSplat _ | VecExtract _ | VecReplace _ ->
    memories zero
  | MemoryInit x -> memories zero ++ datas (idx x)
  | DataDrop x -> datas (idx x)

and block (es : instr list) =
  let free = list instr es in {free with labels = shift free.labels}

let const (c : const) = block c.it

let global (g : global) = global_type g.it.gtype ++ const g.it.ginit
let func (f : func) =
  {(types (idx f.it.ftype) ++ block f.it.body) with locals = Set.empty}
let table (t : table) = table_type t.it.ttype
let memory (m : memory) = memory_type m.it.mtype

let segment_mode f (m : segment_mode) =
  match m.it with
  | Passive | Declarative -> empty
  | Active {index; offset} -> f (idx index) ++ const offset

let elem (s : elem_segment) =
  list const s.it.einit ++ segment_mode tables s.it.emode

let data (s : data_segment) =
  segment_mode memories s.it.dmode

let type_ (t : type_) = def_type t.it

let export_desc (d : export_desc) =
  match d.it with
  | FuncExport x -> funcs (idx x)
  | TableExport x -> tables (idx x)
  | MemoryExport x -> memories (idx x)
  | GlobalExport x -> globals (idx x)

let import_desc (d : import_desc) =
  match d.it with
  | FuncImport x -> types (idx x)
  | TableImport tt -> table_type tt
  | MemoryImport mt -> memory_type mt
  | GlobalImport gt -> global_type gt

let export (e : export) = export_desc e.it.edesc
let import (i : import) = import_desc i.it.idesc

let start (s : idx) = funcs (idx s)

let module_ (m : module_) =
  list type_ m.it.types ++
  list global m.it.globals ++
  list table m.it.tables ++
  list memory m.it.memories ++
  list func m.it.funcs ++
  opt start m.it.start ++
  list elem m.it.elems ++
  list data m.it.datas ++
  list import m.it.imports ++
  list export m.it.exports
