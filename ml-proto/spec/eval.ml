open Values
open Types
open Instance
open Ast
open Source


(* Errors *)

module Link = Error.Make ()
module Trap = Error.Make ()
module Crash = Error.Make ()

exception Link = Link.Error
exception Trap = Trap.Error
exception Crash = Crash.Error (* failure that cannot happen in valid code *)

let memory_error at = function
  | Memory.Bounds -> Trap.error at "out of bounds memory access"
  | Memory.SizeOverflow -> Trap.error at "memory size overflow"
  | Memory.SizeLimit -> Trap.error at "memory size limit reached"
  | Memory.Type -> Crash.error at "type mismatch at memory access"
  | exn -> raise exn

let numeric_error at = function
  | Eval_numeric.TypeError (i, v, t) ->
    Crash.error at
      ("type error, expected " ^ Types.string_of_value_type t ^ " as operand " ^
       string_of_int i ^ ", got " ^ Types.string_of_value_type (type_of v))
  | Numeric_error.IntegerOverflow ->
    Trap.error at "integer overflow"
  | Numeric_error.IntegerDivideByZero ->
    Trap.error at "integer divide by zero"
  | Numeric_error.InvalidConversionToInteger ->
    Trap.error at "invalid conversion to integer"
  | exn -> raise exn


(* Configurations *)

(*
 * Execution is defined by how instructions transform a program configuration.
 * Configurations are given in the form of evaluation contexts that are split up
 * into four parts:
 *
 * es : instr list  - the remaining instructions (in the current block)
 * vs : value stack - the operand stack (local to the current block)
 * bs : block stack - the control stack (local to the current function call)
 * cs : call stack  - the activation stack
 *
 * This organisation allows to easy indexing into the control stack, in
 * particular. An instruction may modify each of the three stacks.
 *
 * Blocks and call frames do not only hold information relevant to the
 * respective block or function (such as locals and result arity), they also
 * save the previous instruction list, value stack, and for calls, block stack,
 * which are restored once the block or function terminates. A real interpreter
 * would typically use one contiguous stack for each part and rather save
 * only stack heights on block or function entry. Saving the entire stacks
 * instead avoids computing stack heights in the semantics.
 *)

type 'a stack = 'a list

type eval_context = instr list * value stack * block stack * call stack
and  call_context = instr list * value stack * block stack
and block_context = instr list * value stack

and block = {target : instr list; barity : int; bcontext : block_context}
and call = {instance : instance; locals : value list; carity : int;
  ccontext : call_context}

let resource_limit = 1000

let lookup category list x =
  try Lib.List32.nth list x.it with Failure _ ->
    Crash.error x.at ("undefined " ^ category ^ " " ^ Int32.to_string x.it)

let update category list x y =
  try Lib.List32.take x.it list @ y :: Lib.List32.drop (Int32.add x.it 1l) list
  with Failure _ ->
    Crash.error x.at ("undefined " ^ category ^ " " ^ Int32.to_string x.it)

let local c x = lookup "local" c.locals x
let update_local c x v = {c with locals = update "local" c.locals x v}

let type_ inst x = lookup "type" inst.module_.it.types x
let func inst x = lookup "function" inst.Instance.funcs x
let table inst x = lookup "table" inst.Instance.tables x
let memory inst x = lookup "memory" inst.Instance.memories x
let global inst x = lookup "global" inst.Instance.globals x

let elem inst x i t at =
  match Table.load (table inst x) i t with
  | Table.Uninitialized ->
    Trap.error at ("uninitialized element " ^ Int32.to_string i)
  | f -> f
  | exception Table.Bounds ->
    Trap.error at ("undefined element " ^ Int32.to_string i)

let func_elem inst x i at =
  match elem inst x i AnyFuncType at with
  | Func f -> f
  | _ -> Crash.error at ("type mismatch for element " ^ Int32.to_string i)

let func_type_of t =
  match t with
  | AstFunc (inst, f) -> lookup "type" (!inst).module_.it.types f.it.ftype
  | HostFunc (t, _) -> t

let take n (vs : 'a stack) at =
  try Lib.List.take n vs with Failure _ ->
    Crash.error at "stack underflow"

let drop n (vs : 'a stack) at =
  try Lib.List.drop n vs with Failure _ ->
    Crash.error at "stack underflow"

let take32 n (vs : 'a stack) at =
  try Lib.List32.take n vs with Failure _ ->
    Crash.error at "stack underflow"

let drop32 n (vs : 'a stack) at =
  try Lib.List32.drop n vs with Failure _ ->
    Crash.error at "stack underflow"


(* Evaluation *)

(*
 * Conventions:
 *   e  : instr
 *   v  : value
 *   es : instr list
 *   vs : value stack
 *   bs : block stack
 *   cs : call stack
 *)

let i32 v at =
  match v with
  | I32 i -> i
  | _ -> Crash.error at "type error: i32 value expected"

let eval_call (clos : closure) (es, vs, bs, cs : eval_context) at =
  if List.length cs = resource_limit then Trap.error at "call stack exhausted";
  let FuncType (ins, out) = func_type_of clos in
  let n = List.length ins in
  let m = List.length out in
  let args, vs' = take n vs at, drop n vs at in
  match clos with
  | AstFunc (inst, f) ->
    let locals = List.rev args @ List.map default_value f.it.locals in
    [Block (out, f.it.body) @@ f.at], [], [],
      {instance = !inst; locals; carity = m; ccontext = es, vs', bs} :: cs

  | HostFunc (t, f) ->
    try es, List.rev (f (List.rev args)) @ vs', bs, cs
    with Crash (_, msg) -> Crash.error at msg

let eval_instr (e : instr) (es, vs, bs, cs : eval_context) : eval_context =
  match e.it, vs, bs, cs with
  | Unreachable, _, _, _ ->
    Trap.error e.at "unreachable executed"

  | Nop, _, _, _ ->
    es, vs, bs, cs

  | Drop, v :: vs', _, _ ->
    es, vs', bs, cs

  | Block (ts, es'), vs, bs, _ ->
    es', [], {target = []; barity = List.length ts; bcontext = es, vs} :: bs, cs

  | Loop (ts, es'), vs, bs, _ ->
    es', [], {target = [e]; barity = 0; bcontext = es, vs} :: bs, cs

  | Br x, vs, bs, _ ->
    let bs' = drop32 x.it bs e.at in
    let b = List.hd (take 1 bs' e.at) in
    let es', vs' = b.bcontext in
    b.target @ es', take b.barity vs e.at @ vs', drop 1 bs' e.at, cs

  | BrIf x, I32 0l :: vs', _, _ ->
    es, vs', bs, cs

  | BrIf x, I32 i :: vs', _, _ ->
    (Br x @@ e.at) :: es, vs', bs, cs

  | BrTable (xs, x), I32 i :: vs', _, _
      when I32.ge_u i (Lib.List32.length xs) ->
    (Br x @@ e.at) :: es, vs', bs, cs

  | BrTable (xs, x), I32 i :: vs', _, _ ->
    (Br (Lib.List32.nth xs i) @@ e.at) :: es, vs', bs, cs

  | Return, vs, _, c :: cs' ->
    let es', vs', bs' = c.ccontext in
    es', take c.carity vs e.at @ vs', bs', cs'

  | If (ts, es1, es2), I32 0l :: vs', _, _ ->
    (Block (ts, es2) @@ e.at) :: es, vs', bs, cs

  | If (ts, es1, es2), I32 i :: vs', _, _ ->
    (Block (ts, es1) @@ e.at) :: es, vs', bs, cs

  | Select, I32 0l :: v2 :: v1 :: vs', _, _ ->
    es, v2 :: vs', bs, cs

  | Select, I32 i :: v2 :: v1 :: vs', _, _ ->
    es, v1 :: vs', bs, cs

  | Call x, _, _, c :: _ ->
    eval_call (func c.instance x) (es, vs, bs, cs) e.at

  | CallIndirect x, I32 i :: vs, _, c :: _ ->
    let clos = func_elem c.instance (0l @@ e.at) i e.at in
    if type_ c.instance x <> func_type_of clos then
      Trap.error e.at "indirect call signature mismatch";
    eval_call clos (es, vs, bs, cs) e.at

  | GetLocal x, vs, _, c :: _ ->
    es, (local c x) :: vs, bs, cs

  | SetLocal x, v :: vs', _, c :: cs' ->
    es, vs', bs, update_local c x v :: cs'

  | TeeLocal x, v :: vs', _, c :: cs' ->
    es, v :: vs', bs, update_local c x v :: cs'

  | GetGlobal x, vs, _, c :: _ ->
    es, !(global c.instance x) :: vs, bs, cs

  | SetGlobal x, v :: vs', _, c :: _ ->
    global c.instance x := v;
    es, vs', bs, cs

  | Load {offset; ty; sz; _}, I32 i :: vs', _, c :: _ ->
    let mem = memory c.instance (0l @@ e.at) in
    let addr = I64_convert.extend_u_i32 i in
    let v =
      try
        match sz with
        | None -> Memory.load mem addr offset ty
        | Some (sz, ext) -> Memory.load_packed sz ext mem addr offset ty
      with exn -> memory_error e.at exn
    in es, v :: vs', bs, cs

  | Store {offset; sz; _}, v :: I32 i :: vs', _, c :: _ ->
    let mem = memory c.instance (0l @@ e.at) in
    let addr = I64_convert.extend_u_i32 i in
    (try
      match sz with
      | None -> Memory.store mem addr offset v
      | Some sz -> Memory.store_packed sz mem addr offset v
    with exn -> memory_error e.at exn);
    es, vs', bs, cs

  | Const v, vs, _, _ ->
    es, v.it :: vs, bs, cs

  | Unary unop, v :: vs', _, _ ->
    (try es, Eval_numeric.eval_unop unop v :: vs', bs, cs
    with exn -> numeric_error e.at exn)

  | Binary binop, v2 :: v1 :: vs', _, _ ->
    (try es, Eval_numeric.eval_binop binop v1 v2 :: vs', bs, cs
    with exn -> numeric_error e.at exn)

  | Test testop, v :: vs', _, _ ->
    (try es, value_of_bool (Eval_numeric.eval_testop testop v) :: vs', bs, cs
    with exn -> numeric_error e.at exn)

  | Compare relop, v2 :: v1 :: vs', _, _ ->
    (try es, value_of_bool (Eval_numeric.eval_relop relop v1 v2) :: vs', bs, cs
    with exn -> numeric_error e.at exn)

  | Convert cvtop, v :: vs', _, _ ->
    (try es, Eval_numeric.eval_cvtop cvtop v :: vs', bs, cs
    with exn -> numeric_error e.at exn)

  | CurrentMemory, vs, _, c :: _ ->
    let mem = memory c.instance (0l @@ e.at) in
    es, I32 (Memory.size mem) :: vs, bs, cs

  | GrowMemory, I32 delta :: vs', _, c :: _ ->
    let mem = memory c.instance (0l @@ e.at) in
    let old_size = Memory.size mem in
    let result =
      try Memory.grow mem delta; old_size
      with Memory.SizeOverflow | Memory.SizeLimit | Memory.OutOfMemory -> -1l
    in es, I32 result :: vs', bs, cs

  | _ ->
    Crash.error e.at "missing or ill-typed operand on stack"

let rec eval_seq (es, vs, bs, cs : eval_context) =
  match es, bs, cs with
  | e :: es', _, _ ->
    eval_seq (eval_instr e (es', vs, bs, cs))

  | [], b :: bs', _ ->
    let es', vs' = b.bcontext in
    eval_seq (es', vs @ vs', bs', cs)

  | [], [], c :: cs' ->
    if List.length vs <> c.carity then
      Crash.error no_region "wrong number of return values on stack";
    let es', vs', bs' = c.ccontext in
    eval_seq (es', vs @ vs', bs', cs')

  | [], [], [] ->
    vs


(* Functions & Constants *)

let eval_func (clos : closure) (vs : value list) at : value list =
  let FuncType (ins, out) = func_type_of clos in
  if List.length vs <> List.length ins then
    Crash.error at "wrong number of arguments";
  List.rev (eval_seq (eval_call clos ([], List.rev vs, [], []) at))

let eval_const inst const =
  let c = {instance = inst; locals = []; carity = 1; ccontext = [], [], []} in
  List.hd (eval_seq (const.it, [], [], [c]))


(* Modules *)

let create_closure m f =
  AstFunc (ref (instance m), f)

let create_table tab =
  let {ttype = TableType (lim, t)} = tab.it in
  Table.create lim  (* TODO: elem_type *)

let create_memory mem =
  let {mtype = MemoryType lim} = mem.it in
  Memory.create lim

let create_global glob =
  let {gtype = GlobalType (t, _); _} = glob.it in
  ref (default_value t)

let init_closure inst clos =
  match clos with
  | AstFunc (inst_ref, _) -> inst_ref := inst
  | _ -> assert false

let check_elem inst seg =
  let {init; _} = seg.it in
  List.iter
    (fun x ->
      match func inst x with
      | AstFunc _ -> ()
      | HostFunc _ -> Link.error x.at "invalid use of host function"
    ) init

let init_table inst seg =
  let {index; offset = e; init} = seg.it in
  let tab = table inst index in
  let offset = i32 (eval_const inst e) e.at in
  try Table.blit tab offset (List.map (fun x -> Func (func inst x)) init)
  with Table.Bounds -> Link.error seg.at "elements segment does not fit table"

let init_memory inst seg =
  let {index; offset = e; init} = seg.it in
  let mem = memory inst index in
  let offset = i32 (eval_const inst e) e.at in
  let offset64 = Int64.logand (Int64.of_int32 offset) 0xffffffffL in
  try Memory.blit mem offset64 init
  with Memory.Bounds -> Link.error seg.at "data segment does not fit memory"

let init_global inst ref glob =
  let {value = e; _} = glob.it in
  ref := eval_const inst e

let check_limits actual expected at =
  if I32.lt_u actual.min expected.min then
    Link.error at "actual size smaller than declared";
  if
    match actual.max, expected.max with
    | _, None -> false
    | None, Some _ -> true
    | Some i, Some j -> I32.gt_u i j
  then Link.error at "maximum size larger than declared"

let add_import (ext : extern) (imp : import) (inst : instance) : instance =
  match ext, imp.it.ikind.it with
  | ExternalFunc clos, FuncImport x ->
    if func_type_of clos <> type_ inst x then
      Link.error imp.it.ikind.at "type mismatch";
    {inst with funcs = clos :: inst.funcs}
  | ExternalTable tab, TableImport (TableType (lim, _)) ->
    check_limits (Table.limits tab) lim imp.it.ikind.at;
    {inst with tables = tab :: inst.tables}
  | ExternalMemory mem, MemoryImport (MemoryType lim) ->
    check_limits (Memory.limits mem) lim imp.it.ikind.at;
    {inst with memories = mem :: inst.memories}
  | ExternalGlobal v, GlobalImport (GlobalType _) ->
    {inst with globals = ref v :: inst.globals}
  | _ ->
    Link.error imp.it.ikind.at "type mismatch"

let add_export inst ex map =
  let {name; ekind; item} = ex.it in
  let ext =
    match ekind.it with
    | FuncExport -> ExternalFunc (func inst item)
    | TableExport -> ExternalTable (table inst item)
    | MemoryExport -> ExternalMemory (memory inst item)
    | GlobalExport -> ExternalGlobal !(global inst item)
  in ExportMap.add name ext map

let init m externals =
  let
    { imports; tables; memories; globals; funcs;
      exports; elems; data; start } = m.it
  in
  if List.length externals <> List.length imports then
    Link.error m.at "wrong number of imports provided for initialisation";
  let fs = List.map (create_closure m) funcs in
  let gs = List.map create_global globals in
  let inst =
    List.fold_right2 add_import externals imports
      { (instance m) with
        funcs = fs;
        tables = List.map create_table tables;
        memories = List.map create_memory memories;
        globals = gs;
      }
  in
  List.iter2 (init_global inst) gs globals;
  List.iter (init_closure inst) fs;
  List.iter (check_elem inst) elems;
  List.iter (init_table inst) elems;
  List.iter (init_memory inst) data;
  Lib.Option.app (fun x -> ignore (eval_func (func inst x) [] x.at)) start;
  {inst with exports = List.fold_right (add_export inst) exports inst.exports}

let invoke clos vs =
  (try eval_func clos vs no_region
  with Stack_overflow -> Trap.error no_region "call stack exhausted")
