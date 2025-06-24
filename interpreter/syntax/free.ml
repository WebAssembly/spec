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
  tags : Set.t;
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
  tags = Set.empty;
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
  tags = Set.union s1.tags s2.tags;
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
let tags s = {empty with tags = s}
let funcs s = {empty with funcs = s}
let elems s = {empty with elems = s}
let datas s = {empty with datas = s}
let locals s = {empty with locals = s}
let labels s = {empty with labels = s}

let idx' x' = Set.singleton x'
let idx x = Set.singleton x.it
let shift s = Set.map (Int32.add (-1l)) (Set.remove 0l s)

let (++) = union
let opt free xo = Lib.Option.get (Option.map free xo) empty
let list free xs = List.fold_left union empty (List.map free xs)

let var = function
  | IdxX x -> types (idx' x)
  | RecX _ -> empty

let numtype = function
  | I32T | I64T | F32T | F64T -> empty

let vectype = function
  | V128T -> empty

let heaptype = function
  | AnyHT | NoneHT | EqHT
  | I31HT | StructHT | ArrayHT -> empty
  | FuncHT | NoFuncHT -> empty
  | ExnHT | NoExnHT -> empty
  | ExternHT | NoExternHT -> empty
  | VarHT x -> var x
  | DefHT _ct -> empty  (* assume closed *)
  | BotHT -> empty

let reftype = function
  | (_, t) -> heaptype t

let valtype = function
  | NumT t -> numtype t
  | VecT t -> vectype t
  | RefT t -> reftype t
  | BotT -> empty

let packtype t = empty

let storagetype = function
  | ValStorageT t -> valtype t
  | PackStorageT t -> packtype t

let fieldtype (FieldT (_mut, st)) = storagetype st

let structtype (StructT fts) = list fieldtype fts
let arraytype (ArrayT ft) = fieldtype ft
let functype (FuncT (ts1, ts2)) = list valtype ts1 ++ list valtype ts2

let comptype = function
  | StructCT st -> structtype st
  | ArrayCT at -> arraytype at
  | FuncCT ft -> functype ft

let subtype = function
  | SubT (_fin, hts, ct) -> list heaptype hts ++ comptype ct

let rectype = function
  | RecT sts -> list subtype sts

let deftype = function
  | DefT (rt, _i) -> rectype rt

let globaltype (GlobalT (_mut, t)) = valtype t
let tabletype (TableT (_at, _lim, t)) = reftype t
let memorytype (MemoryT (_at, _lim)) = empty
let tagtype (TagT dt) = deftype dt

let externtype = function
  | ExternFuncT dt -> deftype dt
  | ExternTableT tt -> tabletype tt
  | ExternMemoryT mt -> memorytype mt
  | ExternGlobalT gt -> globaltype gt
  | ExternTagT tt -> tagtype tt

let blocktype = function
  | VarBlockType x -> types (idx x)
  | ValBlockType t -> opt valtype t

let rec instr (e : instr) =
  match e.it with
  | Unreachable | Nop | Drop -> empty
  | Select tso -> list valtype (Lib.Option.get tso [])
  | RefIsNull | RefAsNonNull -> empty
  | RefTest t | RefCast t -> reftype t
  | RefEq -> empty
  | RefNull t -> heaptype t
  | RefFunc x -> funcs (idx x)
  | RefI31 | I31Get _ -> empty
  | StructNew (x, _) | ArrayNew (x, _) | ArrayNewFixed (x, _) -> types (idx x)
  | ArrayNewElem (x, y) -> types (idx x) ++ elems (idx y)
  | ArrayNewData (x, y) -> types (idx x) ++ datas (idx y)
  | StructGet (x, _, _) | StructSet (x, _) -> types (idx x)
  | ArrayGet (x, _) | ArraySet x -> types (idx x)
  | ArrayLen -> empty
  | ArrayCopy (x, y) -> types (idx x) ++ types (idx y)
  | ArrayFill x -> types (idx x)
  | ArrayInitData (x, y) -> types (idx x) ++ datas (idx y)
  | ArrayInitElem (x, y) -> types (idx x) ++ elems (idx y)
  | ExternConvert _ -> empty
  | Const _ | Test _ | Compare _ | Unary _ | Binary _ | Convert _ -> empty
  | Block (bt, es) | Loop (bt, es) -> blocktype bt ++ block es
  | If (bt, es1, es2) -> blocktype bt ++ block es1 ++ block es2
  | Br x | BrIf x | BrOnNull x | BrOnNonNull x -> labels (idx x)
  | BrOnCast (x, t1, t2) | BrOnCastFail (x, t1, t2) ->
    labels (idx x) ++ reftype t1 ++ reftype t2
  | BrTable (xs, x) -> list (fun x -> labels (idx x)) (x::xs)
  | Return -> empty
  | Call x | ReturnCall x -> funcs (idx x)
  | CallRef x | ReturnCallRef x -> types (idx x)
  | CallIndirect (x, y) | ReturnCallIndirect (x, y) ->
    tables (idx x) ++ types (idx y)
  | Throw x -> tags (idx x)
  | ThrowRef -> empty
  | TryTable (bt, cs, es) -> blocktype bt ++ list catch cs ++ block es
  | LocalGet x | LocalSet x | LocalTee x -> locals (idx x)
  | GlobalGet x | GlobalSet x -> globals (idx x)
  | TableGet x | TableSet x | TableSize x | TableGrow x | TableFill x ->
    tables (idx x)
  | TableCopy (x, y) -> tables (idx x) ++ tables (idx y)
  | TableInit (x, y) -> tables (idx x) ++ elems (idx y)
  | ElemDrop x -> elems (idx x)
  | Load (x, _) | Store (x, _) | VecLoad (x, _) | VecStore (x, _)
  | VecLoadLane (x, _, _) | VecStoreLane (x, _, _)
  | MemorySize x | MemoryGrow x | MemoryFill x ->
    memories (idx x)
  | MemoryCopy (x, y) -> memories (idx x) ++ memories (idx y)
  | MemoryInit (x, y) -> memories (idx x) ++ datas (idx y)
  | DataDrop x -> datas (idx x)
  | VecConst _ | VecTest _
  | VecUnary _ | VecBinary _ | VecTernary _ | VecCompare _
  | VecConvert _ | VecShift _ | VecBitmask _
  | VecTestBits _ | VecUnaryBits _ | VecBinaryBits _ | VecTernaryBits _
  | VecSplat _ | VecExtract _ | VecReplace _ ->
    empty

and block (es : instr list) =
  let free = list instr es in {free with labels = shift free.labels}

and catch (c : catch) =
  match c.it with
  | Catch (x1, x2) | CatchRef (x1, x2) -> tags (idx x1) ++ labels (idx x2)
  | CatchAll x | CatchAllRef x -> labels (idx x)

let const (c : const) = block c.it

let global g = match g.it with Global (gt, c) -> globaltype gt ++ const c
let local l = match l.it with Local t -> valtype t
let func f = match f.it with Func (x, ls, es) ->
  {(types (idx x) ++ list local ls ++ block es) with locals = Set.empty}
let table t = match t.it with Table (tt, c) -> tabletype tt ++ const c
let memory m = match m.it with Memory mt -> memorytype mt
let tag t = match t.it with Tag x -> types (idx x)

let segmentmode f (m : segmentmode) =
  match m.it with
  | Passive | Declarative -> empty
  | Active (x, c) -> f (idx x) ++ const c

let elem (s : elem) =
  let Elem (rt, cs, mode) = s.it in
  reftype rt ++ list const cs ++ segmentmode tables mode

let data (s : data) =
  let Data (_bs, mode) = s.it in
  segmentmode memories mode

let type_ (t : type_) = rectype t.it

let exportdesc (d : exportdesc) =
  match d.it with
  | FuncExport x -> funcs (idx x)
  | TableExport x -> tables (idx x)
  | MemoryExport x -> memories (idx x)
  | GlobalExport x -> globals (idx x)
  | TagExport x -> tags (idx x)

let importdesc (d : importdesc) =
  match d.it with
  | FuncImport x -> types (idx x)
  | TableImport tt -> tabletype tt
  | MemoryImport mt -> memorytype mt
  | GlobalImport gt -> globaltype gt
  | TagImport x -> types (idx x)

let export (e : export) =
  let Export (_name, edesc) = e.it in
  exportdesc edesc

let import (i : import) =
  let Import (_module_name, _item_name, idesc) = i.it in
  importdesc idesc

let start (s : start) =
  let Start x = s.it in
  funcs (idx x)

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
