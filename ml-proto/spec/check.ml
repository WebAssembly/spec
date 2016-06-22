open Kernel
open Source
open Types


(* Errors *)

module Invalid = Error.Make ()
exception Invalid = Invalid.Error

let error = Invalid.error
let require b at s = if not b then error at s


(* Context *)

type expr_type_future = [`Known of expr_type | `SomeUnknown] ref

type context =
{
  types : func_type list;
  funcs : func_type list;
  imports : func_type list;
  locals : value_type list;
  return : expr_type;
  labels : expr_type_future list;
  has_memory : bool
}

let lookup category list x =
  try List.nth list x.it with Failure _ ->
    error x.at ("unknown " ^ category ^ " " ^ string_of_int x.it)

let type_ types x = lookup "function type" types x
let func c x = lookup "function" c.funcs x
let import c x = lookup "import" c.imports x
let local c x = lookup "local" c.locals x
let label c x = lookup "label" c.labels x


(* Type Unification *)

let string_of_future = function
  | `Known et -> string_of_expr_type et
  | `SomeUnknown -> "<value_type>"

let check_type actual expected at =
  if !expected = `SomeUnknown && actual <> None then expected := `Known actual;
  require (!expected = `Known actual) at
    ("type mismatch: expression has type " ^ string_of_expr_type actual ^
     " but the context requires " ^ string_of_future !expected)

let some_unknown () = ref `SomeUnknown
let known et = ref (`Known et)
let none = known None
let some t = known (Some t)
let is_some et = !et <> `Known None


(* Type Synthesis *)

let type_value = Values.type_of
let type_unop = Values.type_of
let type_binop = Values.type_of
let type_testop = Values.type_of
let type_relop = Values.type_of

let type_cvtop at = function
  | Values.Int32 cvtop ->
    let open I32Op in
    (match cvtop with
    | ExtendSInt32 | ExtendUInt32 -> error at "invalid conversion"
    | WrapInt64 -> Int64Type
    | TruncSFloat32 | TruncUFloat32 | ReinterpretFloat -> Float32Type
    | TruncSFloat64 | TruncUFloat64 -> Float64Type
    ), Int32Type
  | Values.Int64 cvtop ->
    let open I64Op in
    (match cvtop with
    | ExtendSInt32 | ExtendUInt32 -> Int32Type
    | WrapInt64 -> error at "invalid conversion"
    | TruncSFloat32 | TruncUFloat32 -> Float32Type
    | TruncSFloat64 | TruncUFloat64 | ReinterpretFloat -> Float64Type
    ), Int64Type
  | Values.Float32 cvtop ->
    let open F32Op in
    (match cvtop with
    | ConvertSInt32 | ConvertUInt32 | ReinterpretInt -> Int32Type
    | ConvertSInt64 | ConvertUInt64 -> Int64Type
    | PromoteFloat32 -> error at "invalid conversion"
    | DemoteFloat64 -> Float64Type
    ), Float32Type
  | Values.Float64 cvtop ->
    let open F64Op in
    (match cvtop with
    | ConvertSInt32 | ConvertUInt32 -> Int32Type
    | ConvertSInt64 | ConvertUInt64 | ReinterpretInt -> Int64Type
    | PromoteFloat32 -> Float32Type
    | DemoteFloat64 -> error at "invalid conversion"
    ), Float64Type

(*
 * This function returns a tuple of a func_type and a bool, with the bool
 * indicating whether the given function requires a memory declaration to be
 * present in the module.
 *)
let type_hostop = function
  | CurrentMemory -> ({ins = []; out = Some Int32Type}, true)
  | GrowMemory -> ({ins = [Int32Type]; out = Some Int32Type}, true)


(* Type Analysis *)

(*
 * check_expr : context -> expr_type_future -> expr -> unit
 *
 * Conventions:
 *   c  : context
 *   e  : expr
 *   eo : expr option
 *   v  : value
 *   t  : value_type
 *   et : expr_type_future
 *)

let rec check_expr c et e =
  match e.it with
  | Nop ->
    check_type None et e.at

  | Unreachable ->
    ()

  | Drop e1 ->
    check_expr c (some_unknown ()) e1;
    check_type None et e.at

  | Block es ->
    let c' = {c with labels = et :: c.labels} in
    check_block c' et es e.at

  | Loop es ->
    let c' = {c with labels = none :: c.labels} in
    check_block c' et es e.at

  | Break (x, eo) ->
    check_expr_opt c (label c x) eo e.at

  | BreakIf (x, eo, e1) ->
    check_expr_opt c (label c x) eo e.at;
    check_expr c (some Int32Type) e1;
    check_type None et e.at

  | BreakTable (xs, x, eo, e1) ->
    List.iter (fun x -> check_expr_opt c (label c x) eo e.at) xs;
    check_expr_opt c (label c x) eo e.at;
    check_expr c (some Int32Type) e1

  | If (e1, es1, es2) ->
    check_expr c (some Int32Type) e1;
    let c' = {c with labels = et :: c.labels} in
    check_block c' et es1 e.at;
    check_block c' et es2 e.at

  | Select (e1, e2, e3) ->
    require (is_some et) e.at "arity mismatch";
    check_expr c et e1;
    check_expr c et e2;
    check_expr c (some Int32Type) e3

  | Call (x, es) ->
    let {ins; out} = func c x in
    check_exprs c ins es e.at;
    check_type out et e.at

  | CallImport (x, es) ->
    let {ins; out} = import c x in
    check_exprs c ins es e.at;
    check_type out et e.at

  | CallIndirect (x, e1, es) ->
    let {ins; out} = type_ c.types x in
    check_expr c (some Int32Type) e1;
    check_exprs c ins es e.at;
    check_type out et e.at

  | GetLocal x ->
    check_type (Some (local c x)) et e.at

  | SetLocal (x, e1) ->
    check_expr c (some (local c x)) e1;
    check_type None et e.at

  | TeeLocal (x, e1) ->
    check_expr c (some (local c x)) e1;
    check_type (Some (local c x)) et e.at

  | Load (memop, e1) ->
    check_load c et memop e1 e.at

  | Store (memop, e1, e2) ->
    check_store c et memop e1 e2 e.at

  | LoadExtend (extendop, e1) ->
    check_mem_type extendop.memop.ty extendop.sz e.at;
    check_load c et extendop.memop e1 e.at

  | StoreWrap (wrapop, e1, e2) ->
    check_mem_type wrapop.memop.ty wrapop.sz e.at;
    check_store c et wrapop.memop e1 e2 e.at

  | Const v ->
    check_literal c et v

  | Unary (unop, e1) ->
    let t = type_unop unop in
    check_expr c (some t) e1;
    check_type (Some t) et e.at

  | Binary (binop, e1, e2) ->
    let t = type_binop binop in
    check_expr c (some t) e1;
    check_expr c (some t) e2;
    check_type (Some t) et e.at

  | Test (testop, e1) ->
    let t = type_testop testop in
    check_expr c (some t) e1;
    check_type (Some Int32Type) et e.at

  | Compare (relop, e1, e2) ->
    let t = type_relop relop in
    check_expr c (some t) e1;
    check_expr c (some t) e2;
    check_type (Some Int32Type) et e.at

  | Convert (cvtop, e1) ->
    let t1, t = type_cvtop e.at cvtop in
    check_expr c (some t1) e1;
    check_type (Some t) et e.at

  | Host (hostop, es) ->
    let {ins; out}, has_mem = type_hostop hostop in
    if has_mem then check_has_memory c e.at;
    check_exprs c ins es e.at;
    check_type out et e.at

and check_block c et es at =
  match es with
  | [] ->
    check_type None et at

  | _ ->
    let es', e = Lib.List.split_last es in 
    List.iter (check_expr c none) es';
    check_expr c et e

and check_exprs c ts es at =
  require (List.length ts = List.length es) at "arity mismatch";
  let ets = List.map some ts in
  List.iter2 (check_expr c) ets es

and check_expr_opt c et eo at =
  match is_some et, eo with
  | false, None -> ()
  | true, Some e -> check_expr c et e
  | _ -> error at "arity mismatch"

and check_literal c et l =
  check_type (Some (type_value l.it)) et l.at

and check_load c et memop e1 at =
  check_has_memory c at;
  check_memop memop at;
  check_expr c (some Int32Type) e1;
  check_type (Some memop.ty) et at

and check_store c et memop e1 e2 at =
  check_has_memory c at;
  check_memop memop at;
  check_expr c (some Int32Type) e1;
  check_expr c (some memop.ty) e2;
  check_type None et at

and check_has_memory c at =
  require c.has_memory at "memory operators require a memory section"

and check_memop memop at =
  require (memop.offset >= 0L) at "negative offset";
  require (memop.offset <= 0xffffffffL) at "offset too large";
  require (Lib.Int.is_power_of_two memop.align) at "non-power-of-two alignment";

and check_mem_type ty sz at =
  require (ty = Int64Type || sz <> Memory.Mem32) at "memory size too big"


(*
 * check_func : context -> func -> unit
 * check_module : context -> module_ -> unit
 *
 * Conventions:
 *   c : context
 *   m : module_
 *   f : func
 *   e : expr
 *   v : value
 *   t : value_type
 *   s : func_type
 *)

let check_func c f =
  let {ftype; locals; body} = f.it in
  let s = type_ c.types ftype in
  let c' = {c with locals = s.ins @ locals; return = s.out} in
  check_expr c' (known s.out) body

let check_elem c x =
  ignore (func c x)

module NameSet = Set.Make(String)

let check_export c set ex =
  let {name; kind} = ex.it in
  (match kind with
  | `Func x -> ignore (func c x)
  | `Memory -> require c.has_memory ex.at "no memory to export"
  );
  require (not (NameSet.mem name set)) ex.at "duplicate export name";
  NameSet.add name set

let check_start c start =
  Lib.Option.app (fun x ->
    let start_type = func c x in
    require (start_type.ins = []) x.at
      "start function must be nullary";
    require (start_type.out = None) x.at
      "start function must not return anything";
  ) start

let check_segment pages prev_end seg =
  let seg_len = Int64.of_int (String.length seg.it.Memory.data) in
  let seg_end = Int64.add seg.it.Memory.addr seg_len in
  require (seg.it.Memory.addr >= prev_end) seg.at
    "data segment not disjoint and ordered";
  require (Int64.mul pages Memory.page_size >= seg_end) seg.at
    "data segment does not fit memory";
  seg_end

let check_memory memory =
  let mem = memory.it in
  require (mem.min <= mem.max) memory.at
    "minimum memory pages must be less than or equal to the maximum";
  require (mem.max <= 65535L) memory.at
    "linear memory pages must be less or equal to 65535 (4GiB)";
  ignore (List.fold_left (check_segment mem.min) 0L mem.segments)

let check_module m =
  let {memory; types; funcs; start; imports; exports; table} = m.it in
  Lib.Option.app check_memory memory;
  let c = {types;
           funcs = List.map (fun f -> type_ types f.it.ftype) funcs;
           imports = List.map (fun i -> type_ types i.it.itype) imports;
           locals = [];
           return = None;
           labels = [];
           has_memory = memory <> None} in
  List.iter (check_func c) funcs;
  List.iter (check_elem c) table;
  ignore (List.fold_left (check_export c) NameSet.empty exports);
  check_start c start
