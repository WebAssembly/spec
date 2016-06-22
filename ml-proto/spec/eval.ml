open Values
open Types
open Kernel
open Source


(* Module Instances *)

type value = Values.value
type import = value list -> value option

module ExportMap = Map.Make(String)
type export_map = func ExportMap.t

type instance =
{
  module_ : module_;
  imports : import list;
  exports : export_map;
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

let type_error at v t =
  Crash.error at
    ("type error, expected " ^ Types.string_of_value_type t ^
      ", got " ^ Types.string_of_value_type (type_of v))

let arithmetic_error at at_op1 at_op2 = function
  | Arithmetic.TypeError (i, v, t) ->
    type_error (if i = 1 then at_op1 else at_op2) v t
  | Numerics.IntegerOverflow ->
    Trap.error at "integer overflow"
  | Numerics.IntegerDivideByZero ->
    Trap.error at "integer divide by zero"
  | Numerics.InvalidConversionToInteger ->
    Trap.error at "invalid conversion to integer"
  | exn -> raise exn


(* Configurations *)

type label = value option -> exn

type config =
{
  instance : instance;
  locals : value ref list;
  labels : label list
}

let lookup category list x =
  try List.nth list x.it with Failure _ ->
    Crash.error x.at ("undefined " ^ category ^ " " ^ string_of_int x.it)

let type_ c x = lookup "type" c.instance.module_.it.types x
let func c x = lookup "function" c.instance.module_.it.funcs x
let import c x = lookup "import" c.instance.imports x
let local c x = lookup "local" c.locals x
let label c x = lookup "label" c.labels x

let export m name =
  try ExportMap.find name.it m.exports with Not_found ->
    Crash.error name.at ("undefined export \"" ^ name.it ^ "\"")

let table_elem c i at =
  try
    let j = Int32.to_int i in
    if i < 0l || i <> Int32.of_int j then raise (Failure "");
    List.nth c.instance.module_.it.table j
  with Failure _ ->
    Trap.error at ("undefined table index " ^ Int32.to_string i)

module MakeLabel () =
struct
  exception Label of value option
  let label v = Label v
end


(* Type conversions *)

let some v at =
  match v with
  | Some v -> v
  | None -> Crash.error at "type error, expression produced no value"

let int32 v at =
  match some v at with
  | Int32 i -> i
  | v -> type_error at v Int32Type

let address32 v at =
  Int64.logand (Int64.of_int32 (int32 v at)) 0xffffffffL

let memory c at =
  match c.instance.memory with
  | Some m -> m
  | _ -> Trap.error at "memory operation with no memory"


(* Evaluation *)

(*
 * Conventions:
 *   c  : config
 *   e  : expr
 *   eo : expr option
 *   v  : value
 *   vo : value option
 *)

let rec eval_expr (c : config) (e : expr) =
  match e.it with
  | Nop ->
    None

  | Unreachable ->
    Trap.error e.at "unreachable executed"

  | Drop e1 ->
    ignore (eval_expr c e1);
    None

  | Block es ->
    let module L = MakeLabel () in
    let c' = {c with labels = L.label :: c.labels} in
    (try eval_block c' es with L.Label vo -> vo)

  | Loop es ->
    let module L = MakeLabel () in
    let c' = {c with labels = L.label :: c.labels} in
    (try eval_block c' es with L.Label _ -> eval_expr c e)

  | Break (x, eo) ->
    raise (label c x (eval_expr_opt c eo))

  | BreakIf (x, eo, e) ->
    let v = eval_expr_opt c eo in
    let i = int32 (eval_expr c e) e.at in
    if i <> 0l then raise (label c x v) else None

  | BreakTable (xs, x, eo, e) ->
    let v = eval_expr_opt c eo in
    let i = int32 (eval_expr c e) e.at in
    if I32.lt_u i (Int32.of_int (List.length xs))
    then raise (label c (List.nth xs (Int32.to_int i)) v)
    else raise (label c x v)

  | Return eo ->
    raise (Lib.List.last c.labels (eval_expr_opt c eo))

  | If (e1, es1, es2) ->
    let i = int32 (eval_expr c e1) e1.at in
    let module L = MakeLabel () in
    let c' = {c with labels = L.label :: c.labels} in
    (try eval_block c' (if i <> 0l then es1 else es2) with L.Label vo -> vo)

  | Select (e1, e2, e3) ->
    let v1 = some (eval_expr c e1) e1.at in
    let v2 = some (eval_expr c e2) e2.at in
    let cond = int32 (eval_expr c e3) e3.at in
    Some (if cond <> 0l then v1 else v2)

  | Call (x, es) ->
    let vs = List.map (fun vo -> some (eval_expr c vo) vo.at) es in
    eval_func c.instance (func c x) vs

  | CallImport (x, es) ->
    let vs = List.map (fun ev -> some (eval_expr c ev) ev.at) es in
    (try (import c x) vs with Crash (_, msg) -> Crash.error e.at msg)

  | CallIndirect (ftype, e1, es) ->
    let i = int32 (eval_expr c e1) e1.at in
    let vs = List.map (fun vo -> some (eval_expr c vo) vo.at) es in
    let f = func c (table_elem c i e1.at) in
    if ftype.it <> f.it.ftype.it then
      Trap.error e1.at "indirect call signature mismatch";
    eval_func c.instance f vs

  | GetLocal x ->
    Some !(local c x)

  | SetLocal (x, e1) ->
    let v1 = some (eval_expr c e1) e1.at in
    local c x := v1;
    None

  | TeeLocal (x, e1) ->
    let v1 = some (eval_expr c e1) e1.at in
    local c x := v1;
    Some v1

  | Load ({ty; offset; align = _}, e1) ->
    let mem = memory c e.at in
    let v1 = address32 (eval_expr c e1) e1.at in
    (try Some (Memory.load mem v1 offset ty)
      with exn -> memory_error e.at exn)

  | Store ({ty = _; offset; align = _}, e1, e2) ->
    let mem = memory c e.at in
    let v1 = address32 (eval_expr c e1) e1.at in
    let v2 = some (eval_expr c e2) e2.at in
    (try Memory.store mem v1 offset v2
      with exn -> memory_error e.at exn);
    None

  | LoadExtend ({memop = {ty; offset; align = _}; sz; ext}, e1) ->
    let mem = memory c e.at in
    let v1 = address32 (eval_expr c e1) e1.at in
    (try Some (Memory.load_extend mem v1 offset sz ext ty)
      with exn -> memory_error e.at exn)

  | StoreWrap ({memop = {ty; offset; align = _}; sz}, e1, e2) ->
    let mem = memory c e.at in
    let v1 = address32 (eval_expr c e1) e1.at in
    let v2 = some (eval_expr c e2) e2.at in
    (try Memory.store_wrap mem v1 offset sz v2
      with exn -> memory_error e.at exn);
    None

  | Const v ->
    Some v.it

  | Unary (unop, e1) ->
    let v1 = some (eval_expr c e1) e1.at in
    (try Some (Arithmetic.eval_unop unop v1)
      with exn -> arithmetic_error e.at e1.at e1.at exn)

  | Binary (binop, e1, e2) ->
    let v1 = some (eval_expr c e1) e1.at in
    let v2 = some (eval_expr c e2) e2.at in
    (try Some (Arithmetic.eval_binop binop v1 v2)
      with exn -> arithmetic_error e.at e1.at e2.at exn)

  | Test (testop, e1) ->
    let v1 = some (eval_expr c e1) e1.at in
    (try Some (Int32 (if Arithmetic.eval_testop testop v1 then 1l else 0l))
      with exn -> arithmetic_error e.at e1.at e1.at exn)

  | Compare (relop, e1, e2) ->
    let v1 = some (eval_expr c e1) e1.at in
    let v2 = some (eval_expr c e2) e2.at in
    (try Some (Int32 (if Arithmetic.eval_relop relop v1 v2 then 1l else 0l))
      with exn -> arithmetic_error e.at e1.at e2.at exn)

  | Convert (cvtop, e1) ->
    let v1 = some (eval_expr c e1) e1.at in
    (try Some (Arithmetic.eval_cvtop cvtop v1)
      with exn -> arithmetic_error e.at e1.at e1.at exn)

  | Host (hostop, es) ->
    let vs = List.map (eval_expr c) es in
    eval_hostop c hostop vs e.at

and eval_block c = function
  | [] ->
    None

  | es ->
    let es', e = Lib.List.split_last es in
    List.iter (fun eI -> ignore (eval_expr c eI)) es';
    eval_expr c e

and eval_expr_opt c = function
  | Some e -> eval_expr c e
  | None -> None

and eval_func instance f vs =
  let args = List.map ref vs in
  let vars = List.map (fun t -> ref (default_value t)) f.it.locals in
  let locals = args @ vars in
  let module L = MakeLabel () in
  let c = {instance; locals; labels = [L.label]} in
  let ft = type_ c f.it.ftype in
  if List.length vs <> List.length ft.ins then
    Crash.error f.at "function called with wrong number of arguments";
  try eval_block c f.it.body with L.Label vo -> vo


(* Host operators *)

and eval_hostop c hostop vs at =
  match hostop, vs with
  | CurrentMemory, [] ->
    let mem = memory c at in
    let size = Memory.size mem in
    assert (I64.lt_u size (Int64.of_int32 Int32.max_int));
    Some (Int32 (Int64.to_int32 size))

  | GrowMemory, [v] ->
    let mem = memory c at in
    let delta = address32 v at in
    let old_size = Memory.size mem in
    let new_size = Int64.add old_size delta in
    if I64.lt_u new_size old_size then
      Trap.error at "memory size overflow";
    (* Test whether the new size overflows the memory type.
     * Since we currently only support i32, just test that. *)
    if I64.gt_u new_size (Int64.of_int32 Int32.max_int) then
      Trap.error at "memory size exceeds implementation limit";
    Memory.grow mem delta;
    Some (Int32 (Int64.to_int32 old_size))

  | _, _ ->
    Crash.error at "invalid invocation of host operator"


(* Modules *)

let init_memory {it = {min; segments; _}} =
  let mem = Memory.create min in
  Memory.init mem (List.map it segments);
  mem

let add_export funcs ex =
  let {name; kind} = ex.it in
  match kind with
  | `Func x -> ExportMap.add name (List.nth funcs x.it)
  | `Memory -> fun x -> x

let init m imports =
  assert (List.length imports = List.length m.it.Kernel.imports);
  let {memory; funcs; exports; start; _} = m.it in
  let instance =
    {module_ = m;
     imports;
     exports = List.fold_right (add_export funcs) exports ExportMap.empty;
     memory = Lib.Option.map init_memory memory}
  in
  Lib.Option.app
    (fun x -> ignore (eval_func instance (lookup "function" funcs x) [])) start;
  instance

let invoke instance name vs =
  try
    eval_func instance (export instance (name @@ no_region)) vs
  with Stack_overflow -> Trap.error Source.no_region "call stack exhausted"
