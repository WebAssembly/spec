open Ast
open Source
open Types


(* Errors *)

module Invalid = Error.Make ()
exception Invalid = Invalid.Error

let error = Invalid.error
let require b at s = if not b then error at s

let result_error at r1 r2 =
  error at
    ("type mismatch: operator requires " ^ string_of_result_type r1 ^
     " but stack has " ^ string_of_result_type r2)


(* Context *)

type op_type = stack_type * result_type

type context =
{
  types : func_type list;
  funcs : func_type list;
  imports : func_type list;
  locals : value_type list;
  return : value_type list;
  labels : result_type ref list;
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


(* Join *)

let join r1 r2 at =
  match r1, r2 with
  | Bot, r | r, Bot -> r
  | r1, r2 when r1 = r2 -> r1
  | _ -> result_error at r1 r2

let unknown () = ref Bot
let known ts = ref (Stack ts)
let unify v ts at = v := join !v (Stack ts) at


(* Type Synthesis *)

let type_value = Values.type_of
let type_unop = Values.type_of
let type_binop = Values.type_of
let type_testop = Values.type_of
let type_relop = Values.type_of

let type_cvtop at = function
  | Values.I32 cvtop ->
    let open I32Op in
    (match cvtop with
    | ExtendSI32 | ExtendUI32 -> error at "invalid conversion"
    | WrapI64 -> I64Type
    | TruncSF32 | TruncUF32 | ReinterpretFloat -> F32Type
    | TruncSF64 | TruncUF64 -> F64Type
    ), I32Type
  | Values.I64 cvtop ->
    let open I64Op in
    (match cvtop with
    | ExtendSI32 | ExtendUI32 -> I32Type
    | WrapI64 -> error at "invalid conversion"
    | TruncSF32 | TruncUF32 -> F32Type
    | TruncSF64 | TruncUF64 | ReinterpretFloat -> F64Type
    ), I64Type
  | Values.F32 cvtop ->
    let open F32Op in
    (match cvtop with
    | ConvertSI32 | ConvertUI32 | ReinterpretInt -> I32Type
    | ConvertSI64 | ConvertUI64 -> I64Type
    | PromoteF32 -> error at "invalid conversion"
    | DemoteF64 -> F64Type
    ), F32Type
  | Values.F64 cvtop ->
    let open F64Op in
    (match cvtop with
    | ConvertSI32 | ConvertUI32 -> I32Type
    | ConvertSI64 | ConvertUI64 | ReinterpretInt -> I64Type
    | PromoteF32 -> F32Type
    | DemoteF64 -> error at "invalid conversion"
    ), F64Type


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

let (-->) ts r = ts, r

let peek i ts =
  try List.nth ts i with Failure _ -> I32Type

let peek_n n ts =
  let m = min n (List.length ts) in
  Lib.List.take m ts @ Lib.List.make (n - m) I32Type

let rec check_expr (c : context) (e : expr) (stack : stack_type) : op_type =
  match e.it with
  | Unreachable ->
    [] --> Bot

  | Nop ->
    [] --> Stack []

  | Drop ->
    [peek 0 stack] --> Stack []

  | Block es ->
    let vr = unknown () in
    let c' = {c with labels = vr :: c.labels} in
    let r = check_block c' es in
    check_result_arity r e.at;
    [] --> join !vr r e.at

  | Loop es ->
    let c' = {c with labels = known [] :: c.labels} in
    let r = check_block c' es in
    check_result_arity r e.at;
    [] --> r

  | Br (n, x) ->
    check_arity n e.at;
    let ts = peek_n n stack in
    unify (label c x) ts e.at;
    ts --> Bot

  | BrIf (n, x) ->
    check_arity n e.at;
    let ts = List.tl (peek_n (n + 1) stack) in
    unify (label c x) ts e.at;
    (ts @ [I32Type]) --> Stack []

  | BrTable (n, xs, x) ->
    check_arity n e.at;
    let ts = List.tl (peek_n (n + 1) stack) in
    unify (label c x) ts x.at;
    List.iter (fun x' -> unify (label c x') ts x'.at) xs;
    (ts @ [I32Type]) --> Bot

  | Return ->
    c.return --> Bot

  | If (es1, es2) ->
    let vr = unknown () in
    let c' = {c with labels = vr :: c.labels} in
    let r1 = check_block c' es1 in
    let r2 = check_block c' es2 in
    let r = join r1 r2 e.at in
    check_result_arity r e.at;
    [I32Type] --> join !vr r e.at

  | Select ->
    let t = peek 1 stack in
    [t; t; I32Type] --> Stack [t]

  | Call x ->
    let FuncType (ins, out) = func c x in
    ins --> Stack out

  | CallImport x ->
    let FuncType (ins, out) = import c x in
    ins --> Stack out

  | CallIndirect x ->
    let FuncType (ins, out) = type_ c.types x in
    (ins @ [I32Type]) --> Stack out

  | GetLocal x ->
    [] --> Stack [local c x]

  | SetLocal x ->
    [local c x] --> Stack []

  | TeeLocal x ->
    [local c x] --> Stack [local c x]

  | Load memop ->
    check_memop c memop e.at;
    [I32Type] --> Stack [memop.ty]

  | Store memop ->
    check_memop c memop e.at;
    [I32Type; memop.ty] --> Stack []

  | LoadPacked {memop; sz; _} ->
    check_memop c memop e.at;
    check_mem_size memop.ty sz e.at;
    [I32Type] --> Stack [memop.ty]

  | StorePacked {memop; sz} ->
    check_memop c memop e.at;
    check_mem_size memop.ty sz e.at;
    [I32Type; memop.ty] --> Stack []

  | Const v ->
    let t = type_value v.it in
    [] --> Stack [t]

  | Unary unop ->
    let t = type_unop unop in
    [t] --> Stack [t]

  | Binary binop ->
    let t = type_binop binop in
    [t; t] --> Stack [t]

  | Test testop ->
    let t = type_testop testop in
    [t] --> Stack [I32Type]

  | Compare relop ->
    let t = type_relop relop in
    [t; t] --> Stack [I32Type]

  | Convert cvtop ->
    let t1, t2 = type_cvtop e.at cvtop in
    [t1] --> Stack [t2]

  | CurrentMemory ->
    [] --> Stack [I32Type]

  | GrowMemory ->
    [I32Type] --> Stack [I32Type]

  | Trapping msg ->
    [] --> Bot

  | Label (es0, vs, es) ->
    let vr = unknown () in
    let c' = {c with labels = vr :: c.labels} in
    let r1 = check_block c' es0 in
    let ves = List.rev (List.map (fun v -> Const (v @@ e.at) @@ e.at) vs) in
    let r2 = check_block c' (ves @ es) in
    [] --> join !vr (join r1 r2 e.at) e.at

  | Local (n, vs0, vs, es) ->
    let locals = List.map Values.type_of vs0 in
    let vr = unknown () in
    let c' = {c with locals; labels = vr :: c.labels} in
    let ves = List.rev (List.map (fun v -> Const (v @@ e.at) @@ e.at) vs) in
    let r = check_block c' (ves @ es) in
    match join !vr r e.at with
    | Stack ts when List.length ts <> n ->
      error e.at "arity mismatch for local result"
    | r' -> [] --> r'

and check_block (c : context) (es : expr list) : result_type =
  match es with
  | [] ->
    Stack []

  | _ ->
    let es', e = Lib.List.split_last es in
    let r1 = check_block c es' in
    match r1 with
    | Bot -> Bot
    | Stack ts0 ->
      let ts2, r2 = check_expr c e (List.rev ts0) in
      let n1 = max (List.length ts0 - List.length ts2) 0 in
      let ts1 = Lib.List.take n1 ts0 in
      let ts2' = Lib.List.drop n1 ts0 in
      if ts2 <> ts2' then result_error e.at (Stack ts2) (Stack ts2');
      match r2 with
      | Bot -> Bot
      | Stack ts3 -> Stack (ts1 @ ts3)

and check_memop c memop at =
  require c.has_memory at "memory operator require a memory section";
  require (memop.offset >= 0L) at "negative offset";
  require (memop.offset <= 0xffffffffL) at "offset too large";
  require (Lib.Int.is_power_of_two memop.align) at "non-power-of-two alignment";

and check_mem_size ty sz at =
  require (ty = I64Type || sz <> Memory.Mem32) at "memory size too big"

and check_arity n at =
  require (n <= 1) at "invalid result arity, larger than 1 is not (yet) allowed"

and check_result_arity r at =
  match r with
  | Stack ts -> check_arity (List.length ts) at
  | Bot -> ()


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
  check_arity (List.length out) f.at;
  let vr = known out in
  let c' = {c with locals = ins @ locals; return = out; labels = [vr]} in
  let r = check_block c' body in
  ignore (join !vr r f.at)

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
