open Values
open Types
open Kernel
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
  imports : import list;
  exports : func map;
  memory : Memory.t option
}


(* Errors *)

module Trap = Error.Make ()
module Crash = Error.Make ()

exception Trap = Trap.Error
exception Crash = Crash.Error
  (* A crash is an execution failure that cannot legally happen in checked
   * code; it indicates an internal inconsistency in the spec. *)

let memory_error at = function
  | Memory.Bounds -> Trap.error at "out of bounds memory access"
  | Memory.SizeOverflow -> Trap.error at "memory size overflow"
  | exn -> raise exn

let arithmetic_error at = function
  | Arithmetic.TypeError (i, v, t) ->
    Crash.error at
      ("type error, expected " ^ Types.string_of_value_type t ^ " as operand " ^
       string_of_int i ^ ", got " ^ Types.string_of_value_type (type_of v))
  | Numerics.IntegerOverflow ->
    Trap.error at "integer overflow"
  | Numerics.IntegerDivideByZero ->
    Trap.error at "integer divide by zero"
  | Numerics.InvalidConversionToInteger ->
    Trap.error at "invalid conversion to integer"
  | exn -> raise exn


(* Configurations *)

type config =
{
  instance : instance;
  locals : value ref list
}

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
    assert false  (* abrupt *)

  | Nop, vs ->
    vs, []

  | Drop, v :: vs' ->
    vs', []

  | Block es, vs ->
    vs, [Label (Nop @@ e.at, [], es) @@ e.at]

  | Loop es, vs ->
    vs, [Label (e, [], es) @@ e.at]

  | Break (n, x), vs ->
    assert false  (* abrupt *)

  | BreakIf (n, x), Int32 0l :: vs' ->
    drop n vs' e.at, []

  | BreakIf (n, x), Int32 i :: vs' ->
    vs', [Break (n, x) @@ e.at]

  | BreakTable (n, xs, x), Int32 i :: vs' when I32.ge_u i (length32 xs) ->
    vs', [Break (n, x) @@ e.at]

  | BreakTable (n, xs, x), Int32 i :: vs' ->
    vs', [Break (n, List.nth xs (Int32.to_int i)) @@ e.at]

  | Return n, vs ->
    assert false  (* abrupt *)

  | If (es1, es2), Int32 0l :: vs' ->
    (* TODO(stack): remove if labels
    vs', es2
    *)
    vs', [Block es2 @@ e.at]

  | If (es1, es2), Int32 i :: vs' ->
    (* TODO(stack): remove if labels
    vs', es1
    *)
    vs', [Block es1 @@ e.at]

  | Select, Int32 0l :: v2 :: v1 :: vs' ->
    v2 :: vs', []

  | Select, Int32 i :: v2 :: v1 :: vs' ->
    v1 :: vs', []

  | Call (n, x), vs ->
    eval_func c.instance vs n (func c.instance x), []

  | CallImport (n, x), vs ->
    (try
      let vs' = List.rev (import c.instance x (List.rev (keep n vs e.at))) in
      drop n vs e.at @ vs', []
    with Crash (_, msg) -> Crash.error e.at msg)

  | CallIndirect (n, x), Int32 i :: vs ->
    let f = func c.instance (table_elem c.instance i e.at) in
    if x.it <> f.it.ftype.it then
      Trap.error e.at "indirect call signature mismatch";
    eval_func c.instance vs n f, []

  | GetLocal x, vs ->
    !(local c x) :: vs, []

  | SetLocal x, v :: vs' ->
    local c x := v;
    vs', []

  | TeeLocal x, v :: vs' ->
    local c x := v;
    v :: vs', []

  | Load {offset; ty; _}, Int32 i :: vs' ->
    let addr = I64_convert.extend_u_i32 i in
    (try Memory.load (memory c e.at) addr offset ty :: vs', []
    with exn -> memory_error e.at exn)

  | Store {offset; _}, v :: Int32 i :: vs' ->
    let addr = I64_convert.extend_u_i32 i in
    (try Memory.store (memory c e.at) addr offset v; vs', []
    with exn -> memory_error e.at exn);

  | LoadPacked {memop = {offset; ty; _}; sz; ext}, Int32 i :: vs' ->
    let addr = I64_convert.extend_u_i32 i in
    (try Memory.load_packed (memory c e.at) addr offset sz ext ty :: vs', []
    with exn -> memory_error e.at exn)

  | StorePacked {memop = {offset; _}; sz}, v :: Int32 i :: vs' ->
    let addr = I64_convert.extend_u_i32 i in
    (try Memory.store_packed (memory c e.at) addr offset sz v; vs', []
    with exn -> memory_error e.at exn)

  | Const v, vs ->
    v.it :: vs, []

  | Unary unop, v :: vs' ->
    (try Arithmetic.eval_unop unop v :: vs', []
    with exn -> arithmetic_error e.at exn)

  | Binary binop, v2 :: v1 :: vs' ->
    (try Arithmetic.eval_binop binop v1 v2 :: vs', []
    with exn -> arithmetic_error e.at exn)

  | Test testop, v :: vs' ->
    (try value_of_bool (Arithmetic.eval_testop testop v) :: vs', []
    with exn -> arithmetic_error e.at exn)

  | Compare relop, v2 :: v1 :: vs' ->
    (try value_of_bool (Arithmetic.eval_relop relop v1 v2) :: vs', []
    with exn -> arithmetic_error e.at exn)

  | Convert cvtop, v :: vs' ->
    (try Arithmetic.eval_cvtop cvtop v :: vs', []
    with exn -> arithmetic_error e.at exn)

  | CurrentMemory, vs ->
    let size = Memory.size (memory c e.at) in
    Int32 (Int64.to_int32 size) :: vs, []

  | GrowMemory, Int32 i :: vs' ->
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
    Int32 (Int64.to_int32 old_size) :: vs', []

  | Label (e_cont, vs', []), vs ->
    vs' @ vs, []

  | Label (e_cont, vs', {it = Break (n, i); _} :: es), vs when i.it = 0 ->
    keep n vs' e.at @ vs, [e_cont]

  | Label (e_cont, vs', {it = Break (n, i); at} :: es), vs ->
    keep n vs' e.at @ vs, [Break (n, (i.it-1) @@ i.at) @@ e.at]

  | Label (e_cont, vs', {it = Return n; at} :: es), vs ->
    keep n vs' e.at @ vs, [Return n @@ at]

  | Label (e_cont, vs', {it = Unreachable; at} :: es), vs ->
    [], [Unreachable @@ at]

  | Label (e_cont, vs', e :: es), vs ->
    let vs'', es' = step_expr c vs' e in
    vs, [Label (e_cont, vs'', es' @ es) @@ e.at]

  | _, _ ->
    Crash.error e.at "type error: missing or ill-typed operand on stack"

and eval_func (inst : instance) (vs : value stack) n (f : func) : value stack =
  let args = List.map ref (List.rev (keep n vs f.at)) in
  let vars = List.map (fun t -> ref (default_value t)) f.it.locals in
  let c = {instance = inst; locals = args @ vars} in
  eval_body c [] [Label (Nop @@ f.at, [], f.it.body) @@ f.at] @ drop n vs f.at

and eval_body (c : config) (vs : value stack) (es : expr list) : value stack =
  match es with
  | [] -> vs
  | [{it = Return n}] -> assert (List.length vs = n); vs
  | [{it = Unreachable; at}] -> Trap.error at "unreachable executed" (*TODO*)
  | [{it = Break (n, i); at}] -> Crash.error at "unknown label"
  | e :: es ->
    let vs', es' = step_expr c [] e in
    eval_body c vs' (es' @ es)

(*TODO: Small-step calls
type expr = ... | Func of value ref list * expr list

  | Call x, vs ->
    let f = ... in
    let locals = ... in
    vs, [Func (locals, [Label (Nop @@ e.at, [], f.it.body)]) @@ e.at]

  | Func (locals, []), vs ->
    vs, []

  | Func (locals, [{it = Return n}]), vs ->
    assert (List.length vs >= n);
    vs, []

  | Func (locals, [{it = Unreachable} as e]), vs ->
    assert (vs = []);
    [], [e]

  | Func (locals, [{it = Break (n, i); at} ]), vs ->
    Crash.error at "unknown label"

  | Func (locals, e :: es), vs ->
    assert (es = []);
    let vs', es' = step_expr c [] e in
    vs' @ vs, [Func (locals, es' @ es) @@ e.at]

OR

type expr = ... | Func of value ref list * value stack * expr list

  | Call x, vs ->
    let f = ... in
    let locals = ... in
    vs, [Func (locals, [], f.it.body) @@ e.at]

  | Func (locals, vs', []), vs ->
    vs' @ vs, []

  | Func (locals, vs', {it = Return n; at} :: es), vs ->
    keep n vs' at @ vs, []

  | Func (locals, vs', {it = Unreachable} as e :: es), vs ->
    [], [e]

  | Func (locals, vs', {it = Break (n, i); at} :: es), vs ->
    Crash.error at "unknown label"

  | Func (locals, vs', e :: es), vs ->
    let vs'', es' = step_expr {c with locals} vs' e in
    vs, [Func (locals, vs'', es' @ es) @@ e.at]
*)

(* Modules *)

let init_memory {it = {min; segments; _}} =
  let mem = Memory.create min in
  Memory.init mem (List.map it segments);
  mem

let add_export funcs ex =
  let {name; kind} = ex.it in
  match kind with
  | `Func x -> Map.add name (List.nth funcs x.it)
  | `Memory -> fun x -> x

let init (m : module_) imports =
  if (List.length m.it.imports <> List.length imports) then
    Crash.error m.at "mismatch in number of imports";
  let {memory; funcs; exports; start; _} = m.it in
  let inst =
    {module_ = m;
     imports;
     exports = List.fold_right (add_export funcs) exports Map.empty;
     memory = Lib.Option.map init_memory memory}
  in
  Lib.Option.app (fun x -> ignore (eval_func inst [] 0 (func inst x))) start;
  inst

let invoke (inst : instance) name (vs : value list) : value list =
  try List.rev (eval_func inst (List.rev vs) (List.length vs) (export inst (name @@ no_region)))
  with Stack_overflow -> Trap.error Source.no_region "call stack exhausted"
