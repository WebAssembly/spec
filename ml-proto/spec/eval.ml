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

type config =
{
  instance : instance;
  locals : value ref list;
  resources : int;
}

let resource_limit = 1000

let lookup category list x =
  try List.nth list x.it with Failure _ ->
    Crash.error x.at ("undefined " ^ category ^ " " ^ string_of_int x.it)

let type_ c x = lookup "type" c.instance.module_.it.types x
let func c x = lookup "function" c.instance.module_.it.funcs x
let import c x = lookup "import" c.instance.imports x
let global c x = lookup "global" c.instance.globals x
let local c x = lookup "local" c.locals x

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


(* Evaluation *)

(*
 * Conventions:
 *   c  : config
 *   e  : expr
 *   v  : value
 *   es : expr list
 *   vs : value list
 *)

let length32 xs = Int32.of_int (List.length xs)

let keep n (vs : value stack) at =
  try Lib.List.take n vs with Failure _ ->
    Crash.error at "stack underflow"

let drop n (vs : value stack) at =
  try Lib.List.drop n vs with Failure _ ->
    Crash.error at "stack underflow"

let rec step_expr (c : config) (vs : value stack) (e : expr)
  : value stack * expr list =
  match e.it, vs with
  | Unreachable, vs ->
    vs, [Trapping "unreachable executed" @@ e.at]

  | Nop, vs ->
    vs, []

  | Drop, v :: vs' ->
    vs', []

  | Block es, vs ->
    vs, [Label ([], [], es) @@ e.at]

  | Loop es, vs ->
    vs, [Label ([e], [], es) @@ e.at]

  | Br (n, x), vs ->
    assert false  (* abrupt *)

  | BrIf (n, x), I32 0l :: vs' ->
    drop n vs' e.at, []

  | BrIf (n, x), I32 i :: vs' ->
    vs', [Br (n, x) @@ e.at]

  | BrTable (n, xs, x), I32 i :: vs' when I32.ge_u i (length32 xs) ->
    vs', [Br (n, x) @@ e.at]

  | BrTable (n, xs, x), I32 i :: vs' ->
    vs', [Br (n, List.nth xs (Int32.to_int i)) @@ e.at]

  | Return, vs ->
    assert false  (* abrupt *)

  | If (es1, es2), I32 0l :: vs' ->
    vs', [Block es2 @@ e.at]

  | If (es1, es2), I32 i :: vs' ->
    vs', [Block es1 @@ e.at]

  | Select, I32 0l :: v2 :: v1 :: vs' ->
    v2 :: vs', []

  | Select, I32 i :: v2 :: v1 :: vs' ->
    v1 :: vs', []

  | Call x, vs ->
    if c.resources = 0 then Trap.error e.at "call stack exhausted";
    let f = func c x in
    let FuncType (ins, out) = type_ c f.it.ftype in
    let n = List.length ins in
    let m = List.length out in
    let args = List.rev (keep n vs e.at) in
    let locals = List.map default_value f.it.locals in
    drop n vs e.at, [Local (m, args @ locals, [], f.it.body) @@ e.at]

  | CallImport x, vs ->
    let x, f = import c x in
    let FuncType (ins, out) = type_ c (x @@ e.at) in
    let n = List.length ins in
    (try
      let vs' = List.rev (f (List.rev (keep n vs e.at))) in
      drop n vs e.at @ vs', []
    with Crash (_, msg) -> Crash.error e.at msg)

  | CallIndirect x, I32 i :: vs ->
    let y = elem c i AnyFuncType e.at @@ e.at in
    if type_ c x <> type_ c (func c y).it.ftype then
      Trap.error e.at "indirect call signature mismatch";
    vs, [Call y @@ e.at]

  | GetLocal x, vs ->
    !(local c x) :: vs, []

  | SetLocal x, v :: vs' ->
    local c x := v;
    vs', []

  | TeeLocal x, v :: vs' ->
    local c x := v;
    v :: vs', []

  | GetGlobal x, vs ->
    !(global c x) :: vs, []

  | SetGlobal x, v :: vs' ->
    global c x := v;
    vs', []

  | Load {offset; ty; _}, I32 i :: vs' ->
    let addr = I64_convert.extend_u_i32 i in
    (try Memory.load (memory c e.at) addr offset ty :: vs', []
    with exn -> memory_error e.at exn)

  | Store {offset; _}, v :: I32 i :: vs' ->
    let addr = I64_convert.extend_u_i32 i in
    (try Memory.store (memory c e.at) addr offset v
    with exn -> memory_error e.at exn);
    vs', []

  | LoadPacked {memop = {offset; ty; _}; sz; ext}, I32 i :: vs' ->
    let addr = I64_convert.extend_u_i32 i in
    (try Memory.load_packed (memory c e.at) addr offset sz ext ty :: vs', []
    with exn -> memory_error e.at exn)

  | StorePacked {memop = {offset; _}; sz}, v :: I32 i :: vs' ->
    let addr = I64_convert.extend_u_i32 i in
    (try Memory.store_packed (memory c e.at) addr offset sz v
    with exn -> memory_error e.at exn);
    vs', []

  | Const v, vs ->
    v.it :: vs, []

  | Unary unop, v :: vs' ->
    (try Eval_numeric.eval_unop unop v :: vs', []
    with exn -> numeric_error e.at exn)

  | Binary binop, v2 :: v1 :: vs' ->
    (try Eval_numeric.eval_binop binop v1 v2 :: vs', []
    with exn -> numeric_error e.at exn)

  | Test testop, v :: vs' ->
    (try value_of_bool (Eval_numeric.eval_testop testop v) :: vs', []
    with exn -> numeric_error e.at exn)

  | Compare relop, v2 :: v1 :: vs' ->
    (try value_of_bool (Eval_numeric.eval_relop relop v1 v2) :: vs', []
    with exn -> numeric_error e.at exn)

  | Convert cvtop, v :: vs' ->
    (try Eval_numeric.eval_cvtop cvtop v :: vs', []
    with exn -> numeric_error e.at exn)

  | CurrentMemory, vs ->
    let size = Memory.size (memory c e.at) in
    I32 (Int64.to_int32 size) :: vs, []

  | GrowMemory, I32 i :: vs' ->
    let mem = memory c e.at in
    let delta = I64_convert.extend_u_i32 i in
    let old_size = Memory.size mem in
    let new_size = Int64.add old_size delta in
    if I64.lt_u new_size old_size then
      Trap.error e.at "memory size overflow";
    (* Test whether the new size overflows the memory type.
     * Since we currently only support i32, just test that. *)
    if I64.gt_u new_size (Int64.of_int32 Int32.max_int) then
      Trap.error e.at "memory size exceeds implementation limit";
    (try Memory.grow mem delta with exn -> memory_error e.at exn);
    I32 (Int64.to_int32 old_size) :: vs', []

  | Trapping msg, vs ->
    assert false (* abrupt *)

  | Label (es_cont, vs', []), vs ->
    vs' @ vs, []

  | Label (es_cont, vs', {it = Br (n, i); _} :: es), vs when i.it = 0 ->
    keep n vs' e.at @ vs, es_cont

  | Label (es_cont, vs', {it = Br (n, i); at} :: es), vs ->
    vs', [Br (n, (i.it - 1) @@ i.at) @@ e.at]

  | Label (es_cont, vs', {it = Return; at} :: es), vs ->
    vs', [Return @@ at]

  | Label (es_cont, vs', {it = Trapping msg; at} :: es), vs ->
    [], [Trapping msg @@ at]

  | Label (es_cont, vs', e :: es), vs ->
    let vs'', es' = step_expr c vs' e in
    vs, [Label (es_cont, vs'', es' @ es) @@ e.at]

  | Local (n, vs_local, vs', []), vs ->
    vs' @ vs, []

  | Local (n, vs_local, vs', {it = Br (n', i); at} :: es), vs when i.it = 0 ->
    if n <> n' then Crash.error at "inconsistent result arity";
    keep n vs' at @ vs, []

  | Local (n, vs_local, vs', {it = Return; at} :: es), vs ->
    keep n vs' at @ vs, []

  | Local (n, vs_local, vs', {it = Trapping msg; at} :: es), vs ->
    [], [Trapping msg @@ at]

  | Local (n, vs_local, vs', e :: es), vs ->
    let c' = {c with locals = List.map ref vs_local; resources = c.resources - 1} in
    let vs'', es' = step_expr c' vs' e in
    vs, [Local (n, List.map (!) c'.locals, vs'', es' @ es) @@ e.at]

  | _, _ ->
    Crash.error e.at "type error: missing or ill-typed operand on stack"


let rec eval_block (c : config) (vs : value stack) (es : expr list) : value stack =
  match es with
  | [] -> vs
  | [{it = Trapping msg; at}] -> Trap.error at msg
  | e :: es ->
    let vs', es' = step_expr c vs e in
    eval_block c vs' (es' @ es)


(* Functions & Constants *)

let eval_func (inst : instance) (vs : value list) (x : var) : value list =
  let c = {instance = inst; locals = []; resources = resource_limit} in
  List.rev (eval_block c (List.rev vs) [Call x @@ x.at])

let eval_const inst const =
  let c = {instance = inst; locals = []; resources = resource_limit} in
  match eval_block c [] const.it with
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

