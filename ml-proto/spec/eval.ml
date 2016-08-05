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
  memory : Memory.t option
}


(* Errors *)

module Trap = Error.Make ()
module Crash = Error.Make ()

exception Trap = Trap.Error
exception Crash = Crash.Error (* failure that cannot happen in valid code *)

let memory_error at = function
  | Memory.Bounds -> Trap.error at "out of bounds memory access"
  | Memory.SizeOverflow -> Trap.error at "memory size overflow"
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

let type_ inst x = lookup "type" inst.module_.it.types x
let func inst x = lookup "function" inst.module_.it.funcs x
let import inst x = lookup "import" inst.imports x
let local c x = lookup "local" c.locals x

let export m name =
  try Map.find name.it m.exports with Not_found ->
    Crash.error name.at ("undefined export \"" ^ name.it ^ "\"")

let table_elem inst i at =
  try
    let j = Int32.to_int i in
    if i < 0l || i <> Int32.of_int j then raise (Failure "");
    List.nth inst.module_.it.table j
  with Failure _ ->
    Trap.error at ("undefined table index " ^ Int32.to_string i)


(* Type conversions *)

let memory c at =
  match c.instance.memory with
  | Some m -> m
  | _ -> Trap.error at "memory operation with no memory"


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
    let f = func c.instance x in
    let FuncType (ins, out) = type_ c.instance f.it.ftype in
    let n = List.length ins in
    let m = List.length out in
    let args = List.rev (keep n vs e.at) in
    let locals = List.map default_value f.it.locals in
    drop n vs e.at, [Local (m, args @ locals, [], f.it.body) @@ e.at]

  | CallImport x, vs ->
    let x, f = import c.instance x in
    let FuncType (ins, out) = type_ c.instance (x @@ e.at) in
    let n = List.length ins in
    (try
      let vs' = List.rev (f (List.rev (keep n vs e.at))) in
      drop n vs e.at @ vs', []
    with Crash (_, msg) -> Crash.error e.at msg)

  | CallIndirect x, I32 i :: vs ->
    let f = func c.instance (table_elem c.instance i e.at) in
    if x.it <> f.it.ftype.it then
      Trap.error e.at "indirect call signature mismatch";
    vs, [Call (table_elem c.instance i e.at) @@ e.at]

  | GetLocal x, vs ->
    !(local c x) :: vs, []

  | SetLocal x, v :: vs' ->
    local c x := v;
    vs', []

  | TeeLocal x, v :: vs' ->
    local c x := v;
    v :: vs', []

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
    Memory.grow mem delta;
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


(* Functions *)

let eval_func (inst : instance) (vs : value list) (x : var) : value list =
  let c = {instance = inst; locals = []; resources = resource_limit} in
  let rec loop vs es =
    match es with
    | [] -> vs
    | [{it = Trapping msg; at}] -> Trap.error at msg
    | e :: es ->
      let vs', es' = step_expr c vs e in
      loop vs' (es' @ es)
  in List.rev (loop (List.rev vs) [Call x @@ x.at])


(* Modules *)

let init_memory {it = {min; segments; _}} =
  let mem = Memory.create min in
  Memory.init mem (List.map it segments);
  mem

let add_export ex =
  let {name; kind} = ex.it in
  match kind with
  | `Func x -> Map.add name x.it
  | `Memory -> fun x -> x

let init (m : module_) imports =
  if (List.length m.it.imports <> List.length imports) then
    Crash.error m.at "mismatch in number of imports";
  let {memory; funcs; exports; start; _} = m.it in
  let inst =
    {module_ = m;
     imports = List.combine (List.map (fun imp -> imp.it.itype.it) m.it.imports) imports;
     exports = List.fold_right add_export exports Map.empty;
     memory = Lib.Option.map init_memory memory}
  in
  Lib.Option.app (fun x -> ignore (eval_func inst [] x)) start;
  inst

let invoke (inst : instance) name (vs : value list) : value list =
  eval_func inst vs (export inst (name @@ no_region) @@ no_region)
