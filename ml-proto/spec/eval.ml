open Values
open Types
open Kernel
open Instance
open Source


(* Errors *)

module Link = Error.Make ()
module Trap = Error.Make ()
module Crash = Error.Make ()

exception Link = Link.Error
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

let empty_config inst = {instance = inst; locals = []; labels = []}

let lookup category list x =
  try List.nth list x.it with Failure _ ->
    Crash.error x.at ("undefined " ^ category ^ " " ^ string_of_int x.it)

let type_ inst x = lookup "type" inst.module_.it.types x
let func c x = lookup "function" c.instance.funcs x
let table c x = lookup "table" c.instance.tables x
let memory c x = lookup "memory" c.instance.memories x
let global c x = lookup "global" c.instance.globals x
let local c x = lookup "local" c.locals x
let label c x = lookup "label" c.labels x

let export inst name =
  try ExportMap.find name.it inst.exports with Not_found ->
    Crash.error name.at ("undefined export \"" ^ name.it ^ "\"")

let elem c x i t at =
  match Table.load (table c x) i t with
  | Some j -> j
  | None ->
    Trap.error at ("uninitialized element " ^ Int32.to_string i)
  | exception Table.Bounds ->
    Trap.error at ("undefined element " ^ Int32.to_string i)

let func_type_of t at =
  match t with
  | AstFunc (inst, f) -> lookup "type" (!inst).module_.it.types f.it.ftype
  | HostFunc _ -> Link.error at "invalid use of host function"

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

let int64 v at =
  match some v at with
  | Int64 i -> i
  | v -> type_error at v Int64Type

let address32 v at =
  Int64.logand (Int64.of_int32 (int32 v at)) 0xffffffffL


(* Evaluation *)

(*
 * Conventions:
 *   c  : config
 *   e  : expr
 *   eo : expr option
 *   v  : value
 *   vo : value option
 *)

let rec eval_expr (c : config) (e : expr) : value option =
  match e.it with
  | Nop ->
    None

  | Unreachable ->
    Trap.error e.at "unreachable executed"

  | Drop e ->
    ignore (eval_expr c e);
    None

  | Block (es, e) ->
    let module L = MakeLabel () in
    let c' = {c with labels = L.label :: c.labels} in
    (try
      List.iter (fun eI -> ignore (eval_expr c' eI)) es;
      eval_expr c' e
    with L.Label vo -> vo)

  | Loop e1 ->
    let module L = MakeLabel () in
    let c' = {c with labels = L.label :: c.labels} in
    (try eval_expr c' e1 with L.Label _ -> eval_expr c e)

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

  | If (e1, e2, e3) ->
    let i = int32 (eval_expr c e1) e1.at in
    eval_expr c (if i <> 0l then e2 else e3)

  | Select (e1, e2, e3) ->
    let v1 = some (eval_expr c e1) e1.at in
    let v2 = some (eval_expr c e2) e2.at in
    let cond = int32 (eval_expr c e3) e3.at in
    Some (if cond <> 0l then v1 else v2)

  | Call (x, es) ->
    let vs = List.map (fun vo -> some (eval_expr c vo) vo.at) es in
    eval_func (func c x) vs e.at

  | CallIndirect (x, e1, es) ->
    let i = int32 (eval_expr c e1) e1.at in
    let vs = List.map (fun vo -> some (eval_expr c vo) vo.at) es in
    let f = func c (elem c (0 @@ e.at) i AnyFuncType e1.at @@ e1.at) in
    if type_ c.instance x <> func_type_of f e1.at then
      Trap.error e1.at "indirect call signature mismatch";
    eval_func f vs e.at

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

  | GetGlobal x ->
    Some !(global c x)

  | SetGlobal (x, e1) ->
    let v1 = some (eval_expr c e1) e1.at in
    global c x := v1;
    None

  | Load ({ty; offset; align = _}, e1) ->
    let mem = memory c (0 @@ e.at) in
    let v1 = address32 (eval_expr c e1) e1.at in
    (try Some (Memory.load mem v1 offset ty)
      with exn -> memory_error e.at exn)

  | Store ({ty = _; offset; align = _}, e1, e2) ->
    let mem = memory c (0 @@ e.at) in
    let v1 = address32 (eval_expr c e1) e1.at in
    let v2 = some (eval_expr c e2) e2.at in
    (try Memory.store mem v1 offset v2
      with exn -> memory_error e.at exn);
    None

  | LoadExtend ({memop = {ty; offset; align = _}; sz; ext}, e1) ->
    let mem = memory c (0 @@ e.at) in
    let v1 = address32 (eval_expr c e1) e1.at in
    (try Some (Memory.load_extend mem v1 offset sz ext ty)
      with exn -> memory_error e.at exn)

  | StoreWrap ({memop = {ty; offset; align = _}; sz}, e1, e2) ->
    let mem = memory c (0 @@ e.at) in
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

and eval_expr_opt c = function
  | Some e -> eval_expr c e
  | None -> None

and eval_func func vs at =
  match func with
  | AstFunc (inst, f) ->
    if List.length vs <> List.length (func_type_of func at).ins then
      Crash.error at "function called with wrong number of arguments";
    let args = List.map ref vs in
    let vars = List.map (fun t -> ref (default_value t)) f.it.locals in
    let locals = args @ vars in
    eval_expr {(empty_config !inst) with locals} f.it.body

  | HostFunc f ->
    try f vs with Crash (_, msg) -> Crash.error at msg


(* Host operators *)

and eval_hostop c hostop vs at =
  match hostop, vs with
  | CurrentMemory, [] ->
    let mem = memory c (0 @@ at) in
    let size = Memory.size mem in
    Some (Int32 size)

  | GrowMemory, [v] ->
    let mem = memory c (0 @@ at) in
    let delta = int32 v at in
    let old_size = Memory.size mem in
    let result =
      try Memory.grow mem delta; old_size
      with Memory.SizeOverflow | Memory.SizeLimit | Memory.OutOfMemory -> -1l
    in Some (Int32 result)

  | _, _ ->
    Crash.error at "invalid invocation of host operator"


(* Modules *)

let create_func m f =
  AstFunc (ref (instance m), f)

let create_table tab =
  let {tlimits = lim; _} = tab.it in
  Table.create lim

let create_memory mem =
  let {mlimits = lim} = mem.it in
  Memory.create lim

let create_global glob =
  let {gtype = t; _} = glob.it in
  ref (default_value t)

let init_func c f =
  match f with
  | AstFunc (inst, _) -> inst := c.instance
  | _ -> assert false

let non_host_func c x =
  ignore (func_type_of (func c x) x.at);
  Some x.it

let init_table c seg =
  let {index; offset = e; init} = seg.it in
  let tab = table c index in
  let offset = int32 (eval_expr c e) e.at in
  Table.blit tab offset (List.map (non_host_func c) init)

let init_memory c seg =
  let {index; offset = e; init} = seg.it in
  let mem = memory c index in
  let offset = Int64.of_int32 (int32 (eval_expr c e) e.at) in
  Memory.blit mem offset init

let init_global c ref glob =
  let {value = e; _} = glob.it in
  ref := some (eval_expr c e) e.at

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
  | ExternalFunc f, FuncImport x ->
    (match f with
    | AstFunc _ when func_type_of f x.at <> type_ inst x ->
      Link.error imp.it.ikind.at "type mismatch";
    | _ -> ()
    );
    {inst with funcs = f :: inst.funcs}
  | ExternalTable t, TableImport (lim, _) ->
    (* TODO: no checking of element type? *)
    check_limits (Table.limits t) lim imp.it.ikind.at;
    {inst with tables = t :: inst.tables}
  | ExternalMemory m, MemoryImport lim ->
    check_limits (Memory.limits m) lim imp.it.ikind.at;
    {inst with memories = m :: inst.memories}
  | ExternalGlobal g, GlobalImport _ ->
    (* TODO: no checking of value type? *)
    {inst with globals = ref g :: inst.globals}
  | _ ->
    Link.error imp.it.ikind.at "type mismatch"

let add_export c ex map =
  let {name; ekind; item} = ex.it in
  let ext =
    match ekind.it with
    | FuncExport -> ExternalFunc (func c item)
    | TableExport -> ExternalTable (table c item)
    | MemoryExport -> ExternalMemory (memory c item)
    | GlobalExport -> ExternalGlobal !(global c item)
  in ExportMap.add name ext map

let init m externals =
  let
    { imports; tables; memories; globals; funcs;
      exports; elems; data; start } = m.it
  in
  assert (List.length externals = List.length imports);  (* TODO: better exception? *)
  let fs = List.map (create_func m) funcs in
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
  let c = empty_config inst in
  List.iter (init_func c) fs;
  List.iter (init_table c) elems;
  List.iter (init_memory c) data;
  List.iter2 (init_global c) gs globals;
  Lib.Option.app (fun x -> ignore (eval_func (func c x) [] x.at)) start;
  {inst with exports = List.fold_right (add_export c) exports inst.exports}

let invoke inst name vs =
  match export inst (name @@ no_region) with
  | ExternalFunc f ->
    (try eval_func f vs no_region
    with Stack_overflow -> Trap.error no_region "call stack exhausted")
  | _ ->
    Crash.error no_region ("export \"" ^ name ^ "\" is not a function")

let const m e =
  some (eval_expr (empty_config (instance m)) e) e.at
