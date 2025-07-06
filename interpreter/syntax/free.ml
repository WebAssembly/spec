open Source
open Ast
open Types

module Set = Set.Make(Int32)

type t =
{
  types : Set.t;
  tags : Set.t;
  globals : Set.t;
  memories : Set.t;
  tables : Set.t;
  funcs : Set.t;
  datas : Set.t;
  elems : Set.t;
  locals : Set.t;
  labels : Set.t;
}

let empty : t =
{
  types = Set.empty;
  tags = Set.empty;
  globals = Set.empty;
  memories = Set.empty;
  tables = Set.empty;
  funcs = Set.empty;
  datas = Set.empty;
  elems = Set.empty;
  locals = Set.empty;
  labels = Set.empty;
}

let union (s1 : t) (s2 : t) : t =
{
  types = Set.union s1.types s2.types;
  tags = Set.union s1.tags s2.tags;
  globals = Set.union s1.globals s2.globals;
  memories = Set.union s1.memories s2.memories;
  tables = Set.union s1.tables s2.tables;
  funcs = Set.union s1.funcs s2.funcs;
  datas = Set.union s1.datas s2.datas;
  elems = Set.union s1.elems s2.elems;
  locals = Set.union s1.locals s2.locals;
  labels = Set.union s1.labels s2.labels;
}

let types s = {empty with types = s}
let tags s = {empty with tags = s}
let globals s = {empty with globals = s}
let memories s = {empty with memories = s}
let tables s = {empty with tables = s}
let funcs s = {empty with funcs = s}
let datas s = {empty with datas = s}
let elems s = {empty with elems = s}
let locals s = {empty with locals = s}
let labels s = {empty with labels = s}

let idx' x' = Set.singleton x'
let idx x = Set.singleton x.it
let shift s = Set.map (Int32.add (-1l)) (Set.remove 0l s)

let (++) = union
let opt free xo = Lib.Option.get (Option.map free xo) empty
let list free xs = List.fold_left union empty (List.map free xs)

let numtype = function
  | I32T | I64T | F32T | F64T -> empty

let vectype = function
  | V128T -> empty

let rec typeuse = function
  | Idx x -> types (idx' x)
  | Rec _ -> empty
  | Def dt -> deftype dt

and heaptype = function
  | AnyHT | NoneHT | EqHT
  | I31HT | StructHT | ArrayHT -> empty
  | FuncHT | NoFuncHT -> empty
  | ExnHT | NoExnHT -> empty
  | ExternHT | NoExternHT -> empty
  | UseHT x -> typeuse x
  | BotHT -> empty

and reftype = function
  | (_, t) -> heaptype t

and valtype = function
  | NumT t -> numtype t
  | VecT t -> vectype t
  | RefT t -> reftype t
  | BotT -> empty

and packtype t = empty

and storagetype = function
  | ValStorageT t -> valtype t
  | PackStorageT t -> packtype t

and fieldtype (FieldT (_mut, st)) = storagetype st

and structtype (StructT fts) = list fieldtype fts
and arraytype (ArrayT ft) = fieldtype ft
and functype (FuncT (ts1, ts2)) = list valtype ts1 ++ list valtype ts2

and comptype = function
  | StructCT st -> structtype st
  | ArrayCT at -> arraytype at
  | FuncCT ft -> functype ft

and subtype = function
  | SubT (_fin, uts, ct) -> list typeuse uts ++ comptype ct

and rectype = function
  | RecT sts -> list subtype sts

and deftype = function
  | DefT (rt, _i) -> rectype rt

let tagtype (TagT ut) = typeuse ut
let globaltype (GlobalT (_mut, t)) = valtype t
let memorytype (MemoryT (_at, _lim)) = empty
let tabletype (TableT (_at, _lim, t)) = reftype t

let externtype = function
  | ExternTagT tt -> tagtype tt
  | ExternGlobalT gt -> globaltype gt
  | ExternMemoryT mt -> memorytype mt
  | ExternTableT tt -> tabletype tt
  | ExternFuncT ut -> typeuse ut

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

let type_ t = rectype t.it
let tag t = let Tag tt = t.it in tagtype tt
let global g = let Global (gt, c) = g.it in globaltype gt ++ const c
let memory m = let Memory mt = m.it in memorytype mt
let table t = let Table (tt, c) = t.it in tabletype tt ++ const c
let local l = let Local t = l.it in valtype t
let func f =
  let Func (x, ls, es) = f.it in
  {(types (idx x) ++ list local ls ++ block es) with locals = Set.empty}

let segmentmode f m =
  match m.it with
  | Passive | Declarative -> empty
  | Active (x, c) -> f (idx x) ++ const c

let data d = let Data (_bs, mode) = d.it in segmentmode memories mode
let elem e =
  let Elem (rt, cs, mode) = e.it in
  reftype rt ++ list const cs ++ segmentmode tables mode

let start s = let Start x = s.it in funcs (idx x)

let externidx (xx : externidx) =
  match xx.it with
  | TagX x -> tags (idx x)
  | GlobalX x -> globals (idx x)
  | MemoryX x -> memories (idx x)
  | TableX x -> tables (idx x)
  | FuncX x -> funcs (idx x)

let export e = let Export (_name, xx) = e.it in externidx xx
let import i = let Import (_module_name, _item_name, xt) = i.it in externtype xt

let module_ (m : module_) =
  list type_ m.it.types ++
  list global m.it.globals ++
  list memory m.it.memories ++
  list table m.it.tables ++
  list func m.it.funcs ++
  list data m.it.datas ++
  list elem m.it.elems ++
  opt start m.it.start ++
  list import m.it.imports ++
  list export m.it.exports
