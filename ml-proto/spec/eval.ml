open Values
open Types
open Ast
open Source


(* Module Instances *)

type 'a stack = 'a list
type value = Values.value
type import = value stack -> value stack

module Map = Map.Make(String)
type 'a map = 'a Map.t

type instance =
{
  module_ : module_;
  imports : (int * import) list;
  exports : int map;
  table : Table.t option;
  memory : Memory.t option;
  globals : value ref list;
}


(* Errors *)

module Trap = Error.Make ()
module Crash = Error.Make ()

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

type eval_context = instr list * value stack * block stack * call stack
and  call_context = instr list * value stack * block stack
and block_context = instr list * value stack

and block = {target : instr list; bcontext : block_context}
and call = {locals : value list; arity : int; ccontext : call_context}

type config = {instance : instance}

let resource_limit = 1000

let lookup category list x =
  try List.nth list x.it with Failure _ ->
    Crash.error x.at ("undefined " ^ category ^ " " ^ string_of_int x.it)

let update category list x y =
  try Lib.List.take x.it list @ [y] @ Lib.List.drop (x.it + 1) list
  with Failure _ ->
    Crash.error x.at ("undefined " ^ category ^ " " ^ string_of_int x.it)

let type_ c x = lookup "type" c.instance.module_.it.types x
let func c x = lookup "function" c.instance.module_.it.funcs x
let import c x = lookup "import" c.instance.imports x
let global c x = lookup "global" c.instance.globals x

let local c x = lookup "local" c.locals x
let update_local c x v = {c with locals = update "local" c.locals x v}

let export inst name =
  try Map.find name.it inst.exports with Not_found ->
    Crash.error name.at ("undefined export \"" ^ name.it ^ "\"")

let table c at =
  match c.instance.table with
  | Some tab -> tab
  | _ -> Crash.error at "no table"

let memory c at =
  match c.instance.memory with
  | Some mem -> mem
  | _ -> Crash.error at "no memory"

let elem c i t at =
  match Table.load (table c at) i t with
  | Some j -> j
  | None ->
    Trap.error at ("undefined element " ^ Int32.to_string i)
  | exception Table.Bounds ->
    Trap.error at ("undefined element " ^ Int32.to_string i)

let take n (vs : 'a stack) at =
  try Lib.List.take n vs with Failure _ ->
    Crash.error at "stack underflow"

let drop n (vs : 'a stack) at =
  try Lib.List.drop n vs with Failure _ ->
    Crash.error at "stack underflow"


(* Evaluation *)

(*
 * Conventions:
 *   c  : config
 *   e  : instr
 *   v  : value
 *   es : instr list
 *   vs : value list
 *)

let length32 xs = Int32.of_int (List.length xs)
let nth32 xs n = List.nth xs (Int32.to_int n)

let eval_call (c : config) (f : func) (es, vs, bs, cs : eval_context) at =
  if List.length cs = resource_limit then Trap.error at "call stack exhausted";
  let FuncType (ins, out) = type_ c f.it.ftype in
  let n = List.length ins in
  let m = List.length out in
  let args = List.rev (take n vs at) in
  let locals = args @ List.map default_value f.it.locals in
  [Block f.it.body @@ f.at], [], [],
    {locals; arity = m; ccontext = es, drop n vs at, bs} :: cs

let eval_instr (c : config) (e : instr) (es, vs, bs, cs : eval_context) : eval_context =
  match e.it, vs, bs, cs with
  | Unreachable, _, _, _ ->
    Trap.error e.at "unreachable executed"

  | Nop, _, _, _ ->
    es, vs, bs, cs

  | Drop, v :: vs', _, _ ->
    es, vs', bs, cs

  | Block es', vs, bs, _ ->
    es', [], {target = []; bcontext = es, vs} :: bs, cs

  | Loop es', vs, bs, _ ->
    es', [], {target = [e]; bcontext = es, vs} :: bs, cs

  | Br (n, x), vs, bs, _ ->
    let b = List.hd (take 1 (drop x.it bs e.at) e.at) in
    let es', vs' = b.bcontext in
    b.target @ es', take n vs e.at @ vs', drop (x.it + 1) bs e.at, cs

  | BrIf (n, x), I32 0l :: vs', _, _ ->
    es, drop n vs' e.at, bs, cs

  | BrIf (n, x), I32 i :: vs', _, _ ->
    (Br (n, x) @@ e.at) :: es, vs', bs, cs

  | BrTable (n, xs, x), I32 i :: vs', _, _ when I32.ge_u i (length32 xs) ->
    (Br (n, x) @@ e.at) :: es, vs', bs, cs

  | BrTable (n, xs, x), I32 i :: vs', _, _ ->
    (Br (n, nth32 xs i) @@ e.at) :: es, vs', bs, cs

  | Return, vs, _, c :: cs' ->
    let es', vs', bs' = c.ccontext in
    es', take c.arity vs e.at @ vs', bs', cs'

  | If (es1, es2), I32 0l :: vs', _, _ ->
    (Block es2 @@ e.at) :: es, vs', bs, cs

  | If (es1, es2), I32 i :: vs', _, _ ->
    (Block es1 @@ e.at) :: es, vs', bs, cs

  | Select, I32 0l :: v2 :: v1 :: vs', _, _ ->
    es, v2 :: vs', bs, cs

  | Select, I32 i :: v2 :: v1 :: vs', _, _ ->
    es, v1 :: vs', bs, cs

  | Call x, _, _, _ ->
    eval_call c (func c x) (es, vs, bs, cs) e.at

  | CallImport x, vs, _, _ ->
    let x, f = import c x in
    let FuncType (ins, out) = type_ c (x @@ e.at) in
    let n = List.length ins in
    (try
      let vs' = List.rev (f (List.rev (take n vs e.at))) in
      es, drop n vs e.at @ vs', bs, cs
    with Crash (_, msg) -> Crash.error e.at msg)

  | CallIndirect x, I32 i :: vs, _, _ ->
    let f = func c (elem c i AnyFuncType e.at @@ e.at) in
    if type_ c x <> type_ c f.it.ftype then
      Trap.error e.at "indirect call signature mismatch";
    eval_call c f (es, vs, bs, cs) e.at

  | GetLocal x, vs, _, c :: _ ->
    es, (local c x) :: vs, bs, cs

  | SetLocal x, v :: vs', _, c :: cs' ->
    es, vs', bs, update_local c x v :: cs'

  | TeeLocal x, v :: vs', _, c :: cs' ->
    es, v :: vs', bs, update_local c x v :: cs'

  | GetGlobal x, vs, _, _ ->
    es, !(global c x) :: vs, bs, cs

  | SetGlobal x, v :: vs', _, _ ->
    global c x := v;
    es, vs', bs, cs

  | Load {offset; ty; sz; _}, I32 i :: vs', _, _ ->
    let addr = I64_convert.extend_u_i32 i in
    let v =
      try
        match sz with
        | None -> Memory.load (memory c e.at) addr offset ty
        | Some (sz, ext) ->
          Memory.load_packed sz ext (memory c e.at) addr offset ty
      with exn -> memory_error e.at exn
    in es, v :: vs', bs, cs

  | Store {offset; sz; _}, v :: I32 i :: vs', _, _ ->
    let addr = I64_convert.extend_u_i32 i in
    (try
      match sz with
      | None -> Memory.store (memory c e.at) addr offset v
      | Some sz -> Memory.store_packed sz (memory c e.at) addr offset v
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

  | CurrentMemory, vs, _, _ ->
    let size = Memory.size (memory c e.at) in
    es, I32 size :: vs, bs, cs

  | GrowMemory, I32 delta :: vs', _, _ ->
    let mem = memory c e.at in
    let old_size = Memory.size mem in
    let result =
      try Memory.grow mem delta; old_size
      with Memory.SizeOverflow | Memory.SizeLimit | Memory.OutOfMemory -> -1l
    in es, I32 result :: vs', bs, cs

  | _ ->
    Crash.error e.at "type error: missing or ill-typed operand on stack"

let rec eval_seq (conf : config) (es, vs, bs, cs : eval_context) =
  match es, bs, cs with
  | e :: es', _, _ ->
    eval_seq conf (eval_instr conf e (es', vs, bs, cs))

  | [], b :: bs', _ ->
    let es', vs' = b.bcontext in
    eval_seq conf (es', vs @ vs', bs', cs)

  | [], [], c :: cs' ->
    let es', vs', bs' = c.ccontext in
    eval_seq conf (es', vs @ vs', bs', cs')

  | [], [], [] ->
    vs


(* Functions & Constants *)

let eval_func (inst : instance) (vs : value list) (x : var) : value list =
  List.rev (eval_seq {instance = inst} ([Call x @@ x.at], List.rev vs, [], []))

let eval_const inst const =
  match eval_seq {instance = inst} (const.it, [], [], []) with
  | [v] -> v
  | _ -> Crash.error const.at "type error: wrong number of values on stack"

let const (m : module_) const =
  let inst = 
    { module_ = m; imports = []; exports = Map.empty;
      table = None; memory = None; globals = [] }
  in eval_const inst const


(* Modules *)

let offset m seg =
  (* TODO: allow referring to globals *)
  let {offset; _} = seg.it in
  try I32Value.of_value (const m offset) with Value _ ->
    Crash.error offset.at "type error: ill-typed value on stack"

let init_table m elems table =
  let {tlimits = lim; _} = table.it in
  let tab = Table.create lim.it.min lim.it.max in
  let entries xs = List.map (fun x -> Some x.it) xs in
  List.iter
    (fun seg -> Table.blit tab (offset m seg) (entries seg.it.init))
    elems;
  tab

let init_memory m data memory =
  let {mlimits = lim} = memory.it in
  let mem = Memory.create lim.it.min lim.it.max in
  List.iter
    (fun seg -> Memory.blit mem (Int64.of_int32 (offset m seg)) seg.it.init)
    data;
  mem

let init_global inst ref global =
  let {value; _} = global.it in
  (* TODO: allow referring to earlier globals *)
  ref := eval_const inst value

let add_export ex =
  let {name; kind} = ex.it in
  match kind with
  | `Func x -> Map.add name x.it
  | `Memory -> fun x -> x

let init (m : module_) imports =
  if (List.length imports <> List.length m.it.imports) then
    Crash.error m.at "mismatch in number of imports";
  let {table; memory; globals; funcs; exports; elems; data; start; _} = m.it in
  let inst =
    { module_ = m;
      imports =
        List.combine (List.map (fun imp -> imp.it.itype.it) m.it.imports)
          imports;
      exports = List.fold_right add_export exports Map.empty;
      table = Lib.Option.map (init_table m elems) table;
      memory = Lib.Option.map (init_memory m data) memory;
      globals = List.map (fun g -> ref (default_value g.it.gtype)) globals;
    }
  in
  List.iter2 (init_global inst) inst.globals globals;
  Lib.Option.app (fun x -> ignore (eval_func inst [] x)) start;
  inst

let invoke (inst : instance) name (vs : value list) : value list =
  eval_func inst vs (export inst (name @@ no_region) @@ no_region)

