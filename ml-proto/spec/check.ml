(*
 * (c) 2015 Andreas Rossberg
 *)

open Ast
open Source
open Types


(* Errors *)

let error = Error.error
let require b at s = if not b then error at s


(* Context *)

type context =
{
  types : func_type list;
  funcs : func_type list;
  imports : func_type list;
  tables : func_type list;
  locals : value_type list;
  return : expr_type;
  labels : expr_type list;
  has_memory : bool
}

let lookup category list x =
  try List.nth list x.it with Failure _ ->
    error x.at ("unknown " ^ category ^ " " ^ string_of_int x.it)

let func c x = lookup "function" c.funcs x
let import c x = lookup "import" c.imports x
let local c x = lookup "local" c.locals x
let table c x = lookup "table" c.tables x
let label c x = lookup "label" c.labels x


(* Type comparison *)

let check_type actual expected at =
  require (expected = None || actual = expected) at
    ("type mismatch: expression has type " ^ string_of_expr_type actual ^
     " but the context requires " ^ string_of_expr_type expected)

let check_func_type actual expected at =
  require (actual = expected) at "inconsistent function type in table"


(* Type Synthesis *)

let type_value = Values.type_of
let type_unop = Values.type_of
let type_binop = Values.type_of
let type_relop = Values.type_of

let type_cvt at = function
  | Values.Int32 cvt ->
    let open Int32Op in
    (match cvt with
    | ExtendSInt32 | ExtendUInt32 -> error at "invalid conversion"
    | WrapInt64 -> Int64Type
    | TruncSFloat32 | TruncUFloat32 | ReinterpretFloat -> Float32Type
    | TruncSFloat64 | TruncUFloat64 -> Float64Type
    ), Int32Type
  | Values.Int64 cvt ->
    let open Int64Op in
    (match cvt with
    | ExtendSInt32 | ExtendUInt32 -> Int32Type
    | WrapInt64 -> error at "invalid conversion"
    | TruncSFloat32 | TruncUFloat32 -> Float32Type
    | TruncSFloat64 | TruncUFloat64 | ReinterpretFloat -> Float64Type
    ), Int64Type
  | Values.Float32 cvt ->
    let open Float32Op in
    (match cvt with
    | ConvertSInt32 | ConvertUInt32 | ReinterpretInt -> Int32Type
    | ConvertSInt64 | ConvertUInt64 -> Int64Type
    | PromoteFloat32 -> error at "invalid conversion"
    | DemoteFloat64 -> Float64Type
    ), Float32Type
  | Values.Float64 cvt ->
    let open Float64Op in
    (match cvt with
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
  | PageSize -> ({ins = []; out = Some Int32Type}, true)
  | MemorySize -> ({ins = []; out = Some Int32Type}, true)
  | GrowMemory -> ({ins = [Int32Type]; out = None}, true)
  | HasFeature str -> ({ins = []; out = Some Int32Type}, false)


(* Type Analysis *)

(*
 * check_expr : context -> expr_type -> expr -> unit
 *
 * Conventions:
 *   c  : context
 *   e  : expr
 *   eo : expr option
 *   v  : value
 *   t  : value_type
 *   et : expr_type
 *)

let rec check_expr c et e =
  match e.it with
  | Nop ->
    check_type None et e.at

  | Block es ->
    require (es <> []) e.at "invalid block";
    let es', eN = Lib.List.split_last es in
    List.iter (check_expr c None) es';
    check_expr c et eN

  | If (e1, e2, e3) ->
    check_expr c (Some Int32Type) e1;
    check_expr c et e2;
    check_expr c et e3

  | Loop e1 ->
    check_expr c None e1

  | Label e1 ->
    let c' = {c with labels = et :: c.labels} in
    check_expr c' et e1

  | Break (x, eo) ->
    check_expr_opt c (label c x) eo e.at

  | Switch (t, e1, cs, e2) ->
    require (t = Int32Type || t = Int64Type) e.at "invalid switch type";
    (* TODO: Check that cases are unique. *)
    check_expr c (Some t) e1;
    List.iter (check_case c t et) cs;
    check_expr c et e2

  | Call (x, es) ->
    let {ins; out} = func c x in
    check_exprs c ins es;
    check_type out et e.at

  | CallImport (x, es) ->
    let {ins; out} = import c x in
    check_exprs c ins es;
    check_type out et e.at

  | CallIndirect (x, e1, es) ->
    let {ins; out} = table c x in
    check_expr c (Some Int32Type) e1;
    check_exprs c ins es;
    check_type out et e.at

  | GetLocal x ->
    check_type (Some (local c x)) et e.at

  | SetLocal (x, e1) ->
    let t = local c x in
    check_expr c (Some t) e1;
    check_type (Some t) et e.at

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
    check_expr c (Some t) e1;
    check_type (Some t) et e.at

  | Binary (binop, e1, e2) ->
    let t = type_binop binop in
    check_expr c (Some t) e1;
    check_expr c (Some t) e2;
    check_type (Some t) et e.at

  | Compare (relop, e1, e2) ->
    let t = type_relop relop in
    check_expr c (Some t) e1;
    check_expr c (Some t) e2;
    check_type (Some Int32Type) et e.at

  | Convert (cvt, e1) ->
    let t1, t = type_cvt e.at cvt in
    check_expr c (Some t1) e1;
    check_type (Some t) et e.at

  | Host (hostop, es) ->
    let ({ins; out}, hasmem) = type_hostop hostop in
    if hasmem then
      check_has_memory c e.at;
    check_exprs c ins es;
    check_type out et e.at

and check_exprs c ts es =
  let ets = List.map (fun x -> Some x) ts in
  try List.iter2 (check_expr c) ets es
  with Invalid_argument _ -> error (Source.ats es) "arity mismatch"

and check_expr_opt c et eo at =
  match eo with
  | Some e -> check_expr c et e
  | None -> check_type None et at

and check_literal c et l =
  check_type (Some (type_value l.it)) et l.at

and check_case c t et case =
  let {value = l; expr = e; fallthru} = case.it in
  check_literal c (Some t) l;
  check_expr c (if fallthru then None else et) e

and check_load c et memop e1 at =
  check_has_memory c at;
  check_align memop.align at;
  check_expr c (Some Int32Type) e1;
  check_type (Some memop.ty) et at

and check_store c et memop e1 e2 at =
  check_has_memory c at;
  check_align memop.align at;
  check_expr c (Some Int32Type) e1;
  check_expr c (Some memop.ty) e2;
  check_type (Some memop.ty) et at

and check_has_memory c at =
  require c.has_memory at "memory operators require a memory section"

and check_align align at =
  Lib.Option.app (fun a ->
    require (Lib.Int.is_power_of_two a) at "non-power-of-two alignment") align

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

let get_type types t =
  require (t.it < List.length types) t.at "type index out of bounds";
  List.nth types t.it

let check_func c f =
  let {ftype; locals; body} = f.it in
  let s = get_type c.types ftype in
  let c' = {c with locals = s.ins @ locals; return = s.out} in
  check_expr c' s.out body

let check_table funcs tables tab =
  match tab.it with
  | [] ->
    error tab.at "empty table"
  | x::xs ->
    let func x = lookup "function" funcs x in
    let s = func x in
    List.iter (fun xI -> check_func_type (func xI) s xI.at) xs;
    tables @ [s]

module NameSet = Set.Make(String)

let check_export c set ex =
  let {name; func = x} = ex.it in
  ignore (func c x);
  require (not (NameSet.mem name set)) ex.at
    "duplicate export name";
  NameSet.add name set

let check_segment size prev_end seg =
  let seg_len = Int64.of_int (String.length seg.it.Memory.data) in
  let seg_end = Int64.add seg.it.Memory.addr seg_len in
  require (seg.it.Memory.addr >= prev_end) seg.at
    "data segment not disjoint and ordered";
  require (size >= seg_end) seg.at
    "data segment does not fit memory";
  seg_end

let check_memory memory =
  let mem = memory.it in
  require (mem.initial <= mem.max) memory.at
    "initial memory size must be less than maximum";
  require (mem.max <= 4294967296L) memory.at
    "linear memory size must be less or equal to 4GiB";
  ignore (List.fold_left (check_segment mem.initial) Int64.zero mem.segments)

let check_module m =
  let {memory; types; funcs; imports; exports; tables} = m.it in
  Lib.Option.app check_memory memory;
  let func_types = List.map (fun f -> get_type types f.it.ftype) funcs in
  let c = {types;
           funcs = func_types;
           imports = List.map (fun i -> get_type types i.it.itype) imports;
           tables = List.fold_left (check_table func_types) [] tables;
           locals = [];
           return = None;
           labels = [];
           has_memory = memory <> None} in
  List.iter (check_func c) funcs;
  ignore (List.fold_left (check_export c) NameSet.empty exports)
