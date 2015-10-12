(*
 * (c) 2015 Andreas Rossberg
 *)

open Values
open Ast
open Source

let error = Error.error


(* Module Instances *)

type value = Values.value
type func = Ast.func
type host_params = {page_size : Memory.size}

module ExportMap = Map.Make(String)
type export_map = func ExportMap.t

type import = instance -> value list -> value option
and  instance =
{
  funcs : func list;
  imports : import list;
  exports : export_map;
  tables : func list list;
  memory : Memory.t option;
  host : host_params
}


(* Configurations *)

type label = value option -> exn

type config =
{
  module_ : instance;
  locals : value ref list;
  labels : label list
}

let lookup category list x =
  try List.nth list x.it with Failure _ ->
    error x.at ("runtime: undefined " ^ category ^ " " ^ string_of_int x.it)

let func c x = lookup "function" c.module_.funcs x
let import c x = lookup "import" c.module_.imports x
let table c x y = lookup "entry" (lookup "table" c.module_.tables x) y
let local c x = lookup "local" c.locals x
let label c x = lookup "label" c.labels x

let export m x =
  try ExportMap.find x.it m.exports
  with Not_found ->
    error x.at ("runtime: undefined export " ^ x.it)

module MakeLabel () =
struct
  exception Label of value option
  let label v = Label v
end


(* Type and memory errors *)

let memory_error at = function
  | Memory.Bounds -> error at "runtime: out of bounds memory access"
  | Memory.Address -> error at "runtime: illegal address value"
  | exn -> raise exn

let type_error at v t =
  error at
    ("runtime: type error, expected " ^ Types.string_of_value_type t ^
      ", got " ^ Types.string_of_value_type (type_of v))

let numerics_error at = function
  | Numerics.IntegerOverflow ->
      error at "runtime: integer overflow"
  | Numerics.IntegerDivideByZero ->
      error at "runtime: integer divide by zero"
  | Numerics.InvalidConversionToInteger ->
      error at "runtime: invalid conversion to integer"
  | exn -> raise exn

let some_memory c at =
  match c.module_.memory with
  | Some m -> m
  | _ -> error at "memory operation but no memory section"

let some v at =
  match v with
  | Some v -> v
  | None -> error at "runtime: expression produced no value"

let int32 v at =
  match some v at with
  | Int32 i -> i
  | v -> type_error at v Types.Int32Type

let mem_size v at =
  let i32 = int32 v at in
  let i64 = Int64.of_int32 i32 in
  Int64.shift_right_logical (Int64.shift_left i64 32) 32

let callstack_exhaustion at =
  error at ("runtime: callstack exhausted")


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

  | Block es ->
    let es', eN = Lib.List.split_last es in
    List.iter (fun eI -> ignore (eval_expr c eI)) es';
    eval_expr c eN

  | If (e1, e2, e3) ->
    let i = int32 (eval_expr c e1) e1.at in
    eval_expr c (if i <> Int32.zero then e2 else e3)

  | Loop e1 ->
    ignore (eval_expr c e1);
    eval_expr c e

  | Label e1 ->
    let module L = MakeLabel () in
    let c' = {c with labels = L.label :: c.labels} in
    (try eval_expr c' e1 with L.Label vo -> vo)

  | Break (x, eo) ->
    raise (label c x (eval_expr_option c eo))

  | Switch (_t, e1, cs, e2) ->
    let vo = some (eval_expr c e1) e1.at in
    (match List.fold_left (eval_case c vo) `Seek cs with
    | `Seek | `Fallthru -> eval_expr c e2
    | `Done vs -> vs
    )

  | Call (x, es) ->
    let vs = List.map (fun vo -> some (eval_expr c vo) vo.at) es in
    eval_func c.module_ (func c x) vs

  | CallImport (x, es) ->
    let vs = List.map (fun ev -> some (eval_expr c ev) ev.at) es in
    (import c x) c.module_ vs

  | CallIndirect (x, e1, es) ->
    let i = int32 (eval_expr c e1) e1.at in
    let vs = List.map (fun vo -> some (eval_expr c vo) vo.at) es in
    (* TODO: The conversion to int could overflow. *)
    eval_func c.module_ (table c x (Int32.to_int i @@ e1.at)) vs

  | GetLocal x ->
    Some !(local c x)

  | SetLocal (x, e1) ->
    let v1 = some (eval_expr c e1) e1.at in
    local c x := v1;
    Some v1

  | Load ({ty; align = _}, e1) ->
    let mem = some_memory c e.at in
    let v1 = mem_size (eval_expr c e1) e1.at in
    (try Some (Memory.load mem v1 ty) with exn -> memory_error e.at exn)

  | Store ({ty = _; align = _}, e1, e2) ->
    let mem = some_memory c e.at in
    let v1 = mem_size (eval_expr c e1) e1.at in
    let v2 = some (eval_expr c e2) e2.at in
    (try Memory.store mem v1 v2 with exn -> memory_error e.at exn);
    Some v2

  | LoadExtend ({memop = {ty; align = _}; sz; ext}, e1) ->
    let mem = some_memory c e.at in
    let v1 = mem_size (eval_expr c e1) e1.at in
    (try Some (Memory.load_extend mem v1 sz ext ty) with exn -> memory_error e.at exn)

  | StoreWrap ({memop = {ty; align = _}; sz}, e1, e2) ->
    let mem = some_memory c e.at in
    let v1 = mem_size (eval_expr c e1) e1.at in
    let v2 = some (eval_expr c e2) e2.at in
    (try Memory.store_wrap mem v1 sz v2 with exn -> memory_error e.at exn);
    Some v2

  | Const v ->
    Some v.it

  | Unary (unop, e1) ->
    let v1 = some (eval_expr c e1) e1.at in
    (try Some (Arithmetic.eval_unop unop v1)
    with
      | Arithmetic.TypeError (_, v, t) -> type_error e1.at v t
      | exn -> numerics_error e.at exn)

  | Binary (binop, e1, e2) ->
    let v1 = some (eval_expr c e1) e1.at in
    let v2 = some (eval_expr c e2) e2.at in
    (try Some (Arithmetic.eval_binop binop v1 v2)
    with
      | Arithmetic.TypeError (i, v, t) ->
          type_error (if i = 1 then e1 else e2).at v t
      | exn -> numerics_error e.at exn)

  | Compare (relop, e1, e2) ->
    let v1 = some (eval_expr c e1) e1.at in
    let v2 = some (eval_expr c e2) e2.at in
    (try
      let b = Arithmetic.eval_relop relop v1 v2 in
      Some (Int32 Int32.(if b then one else zero))
    with Arithmetic.TypeError (i, v, t) ->
      type_error (if i = 1 then e1 else e2).at v t)

  | Convert (cvt, e1) ->
    let v1 = some (eval_expr c e1) e1.at in
    (try Some (Arithmetic.eval_cvt cvt v1)
    with
      | Arithmetic.TypeError (_, v, t) -> type_error e1.at v t
      | exn -> numerics_error e.at exn)

  | PageSize ->
    Some (Int32 (Int64.to_int32 c.module_.host.page_size))

  | MemorySize ->
    let mem = some_memory c e.at in
    let i64 = Memory.size mem in
    assert (i64 < Int64.of_int32 (Int32.max_int));
    Some (Int32 (Int64.to_int32 i64))

  | ResizeMemory e ->
    let mem = some_memory c e.at in
    let sz = mem_size (eval_expr c e) e.at in
    if (Int64.rem sz c.module_.host.page_size) <> 0L then
      error e.at "runtime: resize_memory operand not multiple of page_size";
    Memory.resize mem sz;
    None

and eval_expr_option c eo =
  match eo with
  | Some e -> eval_expr c e
  | None -> None

and eval_case c vo stage case =
  let {value; expr = e; fallthru} = case.it in
  match stage, vo = value.it with
  | `Seek, true | `Fallthru, _ ->
    if fallthru
    then (ignore (eval_expr c e); `Fallthru)
    else `Done (eval_expr c e)
  | `Seek, false | `Done _, _ ->
    stage

and eval_func (m : instance) (f : func) (evs : value list) =
  let args = List.map ref evs in
  let vars = List.map (fun t -> ref (default_value t.it)) f.it.locals in
  let locals = args @ vars in
  let c = {module_ = m; locals; labels = []} in
  eval_expr c f.it.body


(* Modules *)

let init_memory {it = {initial; segments; _}} =
  let mem = Memory.create initial in
  Memory.init mem (List.map it segments);
  mem

let init m imports host =
  assert (List.length imports = List.length m.it.Ast.imports);
  assert (host.page_size > 0L);
  assert (Lib.Int64.is_power_of_two host.page_size);
  let {Ast.exports; tables; funcs; memory; _} = m.it in
  let memory' = Lib.Option.map init_memory memory in
  let func x = List.nth funcs x.it in
  let export ex = ExportMap.add ex.it.name (func ex.it.func) in
  let exports = List.fold_right export exports ExportMap.empty in
  let tables = List.map (fun tab -> List.map func tab.it) tables in
  {funcs; imports; exports; tables; memory = memory'; host}

let invoke m name vs =
  try
    let f = export m (name @@ no_region) in
    assert (List.length vs = List.length f.it.params);
    eval_func m f vs
  with Stack_overflow -> callstack_exhaustion no_region

(* This function is not part of the spec. *)
let host_eval e =
  let f = {params = []; result = None; locals = []; body = e} @@ no_region in
  let exports = ExportMap.singleton "eval" f in
  let host = {page_size = 1L} in
  let m = {imports = []; exports; tables = []; funcs = [f]; memory = None; host} in
  eval_func m f []

let memory_for_module at m =
  match m.memory with
  | Some mem ->
    mem
  | _ ->
    error at "Module has no memory";
