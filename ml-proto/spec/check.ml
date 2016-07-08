open Kernel
open Source
open Types


(* Errors *)

module Invalid = Error.Make ()
exception Invalid = Invalid.Error

let error = Invalid.error
let require b at s = if not b then error at s


(* Type variables *)

type 'a var' = Fix of 'a | Var | Fwd of 'a var
and 'a var = 'a var' ref

let var _ = ref Var
let fix x = ref (Fix x)
let fix_list = List.map fix

let rec is_fix v =
  match !v with
  | Fix _ -> true
  | Var -> false
  | Fwd v' -> is_fix v'

let rec content v =
  match !v with
  | Fix x -> x
  | Var -> assert false
  | Fwd v' -> content v'

let rec unify f v1 v2 =
  if v1 != v2 then
  match !v1, !v2 with
  | Fwd v1', _ -> unify f v1' v2
  | _, Fwd v2' -> unify f v1 v2'
  | Var, _ -> v1 := Fwd v2
  | _, Var -> v2 := Fwd v1
  | Fix x1, Fix x2 -> f x1 x2

let rec string_of_var string_of name v =
  match !v with
  | Fix x -> string_of x
  | Var -> name
  | Fwd v' -> string_of_var string_of name v'


(* Context *)

type stack_type = value_type var list
type op_type = stack_type * stack_type var

type context =
{
  types : func_type list;
  funcs : func_type list;
  imports : func_type list;
  locals : value_type list;
  return : value_type list;
  labels : stack_type var list;
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

let string_of_value_type_var = string_of_var string_of_value_type "?"
let string_of_stack_type = function
  | [t] -> string_of_value_type_var t
  | ts -> "(" ^ String.concat " " (List.map string_of_value_type_var ts) ^ ")"


exception Unify

let unify_value_type vt1 vt2 =
  unify (fun t1 t2 -> if t1 <> t2 then raise Unify) vt1 vt2

let unify_stack_type vts1 vts2 at =
  try unify (List.iter2 unify_value_type) vts1 vts2
  with Unify | Invalid_argument _ ->
    error at
      ("stack mismatch: required " ^ string_of_stack_type (content vts1) ^
       " but have " ^ string_of_stack_type (content vts2))


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


(* Type Analysis *)

(*
 * check_expr : context -> expr_type_future -> expr -> unit
 *
 * Conventions:
 *   c  : context
 *   e  : expr
 *   es : expr list
 *   v  : value
 *   t  : value_type var
 *   ts : stack_type
 *)

let (-->) ts1 ts2 = ts1, ts2

let rec check_expr (c : context) (e : expr) : op_type =
  match e.it with
  | Unreachable ->
    [] --> var ()

  | Nop ->
    [] --> fix []

  | Drop ->
    [var ()] --> fix []

  | Block es ->
    let ts = var () in
    let c' = {c with labels = ts :: c.labels} in
    let ts' = check_block c' es e.at in
    unify_stack_type ts ts' e.at;
    [] --> ts'

  | Loop es ->
    let c' = {c with labels = fix [] :: c.labels} in
    let ts = check_block c' es e.at in
    [] --> ts

  | Label (e0, vs, es) ->
    let ts = var () in
    let c' = {c with labels = ts :: c.labels} in
    let ts1 = check_block c' [e0] e.at in
    let ts2 = check_block c'
      (List.rev (List.map (fun v -> Const (v @@ e.at) @@ e.at) vs) @ es) e.at in
    unify_stack_type ts ts1 e.at;
    unify_stack_type ts ts2 e.at;
    [] --> ts

  | Break (n, x) ->
    let ts = Lib.List.table n var in
    unify_stack_type (label c x) (fix ts) e.at;
    ts --> var ()

  | BreakIf (n, x) ->
    let ts = Lib.List.table n var in
    unify_stack_type (label c x) (fix ts) e.at;
    (ts @ [fix Int32Type]) --> fix []

  | BreakTable (n, xs, x) ->
    let ts = Lib.List.table n var in
    unify_stack_type (label c x) (fix ts) e.at;
    List.iter (fun x -> unify_stack_type (label c x) (fix ts) e.at) xs;
    (ts @ [fix Int32Type]) --> var ()

  | Return n ->
    require (List.length c.return = n) e.at "arity mismatch";
    fix_list c.return --> var ()

  | If (es1, es2) ->
    let ts1 = check_block c es1 e.at in
    let ts2 = check_block c es2 e.at in
    unify_stack_type ts1 ts2 e.at;
    [fix Int32Type] --> ts1

  | Select ->
    let t = var () in
    [t; t; fix Int32Type] --> fix [t]

  | Call (n, x) ->
    let FuncType (ins, out) = func c x in
    require (List.length ins = n) e.at "arity mismatch";
    fix_list ins --> fix (fix_list out)

  | CallImport (n, x) ->
    let FuncType (ins, out) = import c x in
    require (List.length ins = n) e.at "arity mismatch";
    fix_list ins --> fix (fix_list out)

  | CallIndirect (n, x) ->
    let FuncType (ins, out) = type_ c.types x in
    require (List.length ins = n) e.at "arity mismatch";
    fix_list (ins @ [Int32Type]) --> fix (fix_list out)

  | GetLocal x ->
    [] --> fix [fix (local c x)]

  | SetLocal x ->
    [fix (local c x)] --> fix []

  | TeeLocal x ->
    [fix (local c x)] --> fix [fix (local c x)]

  | Load memop ->
    check_memop c memop e.at;
    [fix Int32Type] --> fix [fix memop.ty]

  | Store memop ->
    check_memop c memop e.at;
    [fix Int32Type; fix memop.ty] --> fix []

  | LoadPacked {memop; sz; _} ->
    check_memop c memop e.at;
    check_mem_size memop.ty sz e.at;
    [fix Int32Type] --> fix [fix memop.ty]

  | StorePacked {memop; sz} ->
    check_memop c memop e.at;
    check_mem_size memop.ty sz e.at;
    [fix Int32Type; fix memop.ty] --> fix []

  | Const v ->
    [] --> fix [fix (type_value v.it)]

  | Unary unop ->
    let t = type_unop unop in
    [fix t] --> fix [fix t]

  | Binary binop ->
    let t = type_binop binop in
    [fix t; fix t] --> fix [fix t]

  | Test testop ->
    let t = type_testop testop in
    [fix t] --> fix [fix Int32Type]

  | Compare relop ->
    let t = type_relop relop in
    [fix t; fix t] --> fix [fix Int32Type]

  | Convert cvtop ->
    let t1, t2 = type_cvtop e.at cvtop in
    [fix t1] --> fix [fix t2]

  | CurrentMemory ->
    [] --> fix [fix Int32Type]

  | GrowMemory ->
    [fix Int32Type] --> fix [fix Int32Type]

and check_block (c : context) (es : expr list) at : stack_type var =
  match es with
  | [] ->
    fix []

  | _ ->
    let es', e = Lib.List.split_last es in 
    let vts0 = check_block c es' at in
    if not (is_fix vts0) then var () else
    let ts0 = content vts0 in
    let ts2, vts3 = check_expr c e in
    let n1 = max (List.length ts0 - List.length ts2) 0 in
    let ts1 = Lib.List.take n1 ts0 in
    let ts2' = Lib.List.drop n1 ts0 in
    unify_stack_type (fix ts2) (fix ts2') at;
    if not (is_fix vts3) then var () else
    let ts3 = content vts3 in
    fix (ts1 @ ts3)


and check_memop c memop at =
  require c.has_memory at "memory operator require a memory section";
  require (memop.offset >= 0L) at "negative offset";
  require (memop.offset <= 0xffffffffL) at "offset too large";
  require (Lib.Int.is_power_of_two memop.align) at "non-power-of-two alignment";

and check_mem_size ty sz at =
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
  let FuncType (ins, out) = type_ c.types ftype in
  let c' = {c with locals = ins @ locals; return = out; labels = []} in
  let ts = check_block c' body f.at in
  unify_stack_type (fix (fix_list out)) ts f.at

let check_elem c x =
  ignore (func c x)

module NameSet = Set.Make(String)

let check_export c set ex =
  let {name; kind} = ex.it in
  (match kind with
  | `Func x -> ignore (func c x)
  | `Memory ->
    require c.has_memory ex.at "memory export requires a memory section"
  );
  require (not (NameSet.mem name set)) ex.at "duplicate export name";
  NameSet.add name set

let check_start c start =
  Lib.Option.app (fun x ->
    require (func c x = FuncType ([], [])) x.at "start function must be nullary"
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
           return = [];
           labels = [];
           has_memory = memory <> None} in
  List.iter (check_func c) funcs;
  List.iter (check_elem c) table;
  ignore (List.fold_left (check_export c) NameSet.empty exports);
  check_start c start
