open Source
open Ast

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

let var x = Set.singleton x.it
let zero = Set.singleton 0l
let shift s = Set.map (Int32.add (-1l)) (Set.remove 0l s)

let (++) = union
let list free xs = List.fold_left union empty (List.map free xs)

let rec instr (e : instr) =
  match e.it with
  | Unreachable | Nop | Drop | Select -> empty
  | Const _ | Test _ | Compare _ | Unary _ | Binary _ | Convert _ -> empty
  | Block (_, es) | Loop (_, es) -> block es
  | If (_, es1, es2) -> block es1 ++ block es2
  | Br x | BrIf x -> labels (var x)
  | BrTable (xs, x) -> list (fun x -> labels (var x)) (x::xs)
  | Return -> empty
  | Call x -> funcs (var x)
  | CallIndirect x -> types (var x) ++ tables zero
  | LocalGet x | LocalSet x | LocalTee x -> locals (var x)
  | GlobalGet x | GlobalSet x -> globals (var x)
  | Load _ | Store _ | MemorySize | MemoryGrow | MemoryCopy | MemoryFill ->
    memories zero
  | MemoryInit x -> memories zero ++ datas (var x)
  | TableCopy -> tables zero
  | TableInit x -> tables zero ++ elems (var x)
  | DataDrop x -> datas (var x)
  | ElemDrop x -> elems (var x)

and block (es : instr list) =
  let free = list instr es in {free with labels = shift free.labels}

let const (c : const) = block c.it

let global (g : global) = const g.it.value
let func (f : func) = {(block f.it.body) with locals = Set.empty}
let table (t : table) = empty
let memory (m : memory) = empty

let elem (e : elem) =
  match e.it with
  | RefNull -> empty
  | RefFunc x -> funcs (var x)

let table_segment (s : table_segment) =
  match s.it with
  | Active {index; offset; init} ->
    tables (var index) ++ const offset ++ list elem init
  | Passive {etype; data} -> list elem data

let memory_segment (s : memory_segment) =
  match s.it with
  | Active {index; offset; init} -> memories (var index) ++ const offset
  | Passive {etype; data} -> empty

let type_ (t : type_) = empty

let export_desc (d : export_desc) =
  match d.it with
  | FuncExport x -> funcs (var x)
  | TableExport x -> tables (var x)
  | MemoryExport x -> memories (var x)
  | GlobalExport x -> globals (var x)

let import_desc (d : import_desc) =
  match d.it with
  | FuncImport x -> types (var x)
  | TableImport tt -> empty
  | MemoryImport mt -> empty
  | GlobalImport gt -> empty

let export (e : export) = export_desc e.it.edesc
let import (i : import) = import_desc i.it.idesc

let start (s : var option) =
  funcs (Lib.Option.get (Lib.Option.map var s) Set.empty)

let module_ (m : module_) =
  list type_ m.it.types ++
  list global m.it.globals ++
  list table m.it.tables ++
  list memory m.it.memories ++
  list func m.it.funcs ++
  start m.it.start ++
  list table_segment m.it.elems ++
  list memory_segment m.it.datas ++
  list import m.it.imports ++
  list export m.it.exports
