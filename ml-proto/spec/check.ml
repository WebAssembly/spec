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
  module_ : module_;
  types : func_type list;
  funcs : func_type list;
  imports : func_type list;
  locals : value_type list;
  globals : value_type list;
  return : value_type list;
  labels : result_type ref list;
  table : Table.size option;
  memory : Memory.size option;
}

let lookup category list x =
  try List.nth list x.it with Failure _ ->
    error x.at ("unknown " ^ category ^ " " ^ string_of_int x.it)

let type_ types x = lookup "function type" types x
let func c x = lookup "function" c.funcs x
let import c x = lookup "import" c.imports x
let local c x = lookup "local" c.locals x
let global c x = lookup "global" c.globals x
let label c x = lookup "label" c.labels x

let lookup_size category opt at =
  match opt with
  | Some n -> n
  | None -> error at ("no " ^ category ^ " defined")

let table c at = lookup_size "table" c.table at
let memory c at = lookup_size "memory" c.memory at


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


(* Expressions *)

let check_memop (c : context) (memop : 'a memop) get_sz at =
  ignore (memory c at);
  require (memop.offset >= 0L) at "negative offset";
  require (memop.offset <= 0xffffffffL) at "offset too large";
  require (Lib.Int.is_power_of_two memop.align) at
    "alignment must be a power of two";
  let size =
    match get_sz memop.sz with
    | None -> size memop.ty
    | Some sz ->
      require (memop.ty = I64Type || sz <> Memory.Mem32) at
        "memory size too big";
      Memory.mem_size sz
  in
  require (memop.align <= size) at "alignment must not be larger than natural"

let check_arity n at =
  require (n <= 1) at "invalid result arity, larger than 1 is not (yet) allowed"

let check_result_arity r at =
  match r with
  | Stack ts -> check_arity (List.length ts) at
  | Bot -> ()

(*
 * check_instr : context -> instr -> stack_type -> unit
 *
 * Conventions:
 *   c  : context
 *   e  : instr
 *   es : instr list
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

let rec check_instr (c : context) (e : instr) (stack : stack_type) : op_type =
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
    ignore (table c e.at);
    let FuncType (ins, out) = type_ c.types x in
    (ins @ [I32Type]) --> Stack out

  | GetLocal x ->
    [] --> Stack [local c x]

  | SetLocal x ->
    [local c x] --> Stack []

  | TeeLocal x ->
    [local c x] --> Stack [local c x]

  | GetGlobal x ->
    [] --> Stack [global c x]

  | SetGlobal x ->
    [global c x] --> Stack []

  | Load memop ->
    check_memop c memop (Lib.Option.map fst) e.at;
    [I32Type] --> Stack [memop.ty]

  | Store memop ->
    check_memop c memop (fun sz -> sz) e.at;
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
    ignore (memory c e.at);
    [] --> Stack [I32Type]

  | GrowMemory ->
    ignore (memory c e.at);
    [I32Type] --> Stack [I32Type]

and check_block (c : context) (es : instr list) : result_type =
  match es with
  | [] ->
    Stack []

  | _ ->
    let es', e = Lib.List.split_last es in
    let r1 = check_block c es' in
    match r1 with
    | Bot -> Bot
    | Stack ts0 ->
      let ts2, r2 = check_instr c e (List.rev ts0) in
      let n1 = max (List.length ts0 - List.length ts2) 0 in
      let ts1 = Lib.List.take n1 ts0 in
      let ts2' = Lib.List.drop n1 ts0 in
      if ts2 <> ts2' then result_error e.at (Stack ts2) (Stack ts2');
      match r2 with
      | Bot -> Bot
      | Stack ts3 -> Stack (ts1 @ ts3)


(* Functions & Constants *)

(*
 * check_func : context -> func -> unit
 * check_module : context -> module_ -> unit
 *
 * Conventions:
 *   c : context
 *   m : module_
 *   f : func
 *   e : instr
 *   v : value
 *   t : value_type
 *   s : func_type
 *)

let check_func (c : context) (f : func) =
  let {ftype; locals; body} = f.it in
  let FuncType (ins, out) = type_ c.types ftype in
  check_arity (List.length out) f.at;
  let vr = known out in
  let c' = {c with locals = ins @ locals; return = out; labels = [vr]} in
  let r = check_block c' body in
  ignore (join !vr r f.at)


let is_const e =
  match e.it with
  | Const _ | GetGlobal _ -> true
  | _ -> false

let check_const (c : context) (const : const) (t : value_type) =
  require (List.for_all is_const const.it) const.at
    "constant expression required";
  match check_block c const.it with
  | Stack [t'] when t = t' -> ()
  | r -> result_error const.at (Stack [t]) r


(* Tables & Memories *)

let check_table_limits (lim : Table.size limits) =
  let {min; max} = lim.it in
  match max with
  | None -> ()
  | Some max ->
    require (I32.le_u min max) lim.at
      "table size minimum must not be greater than maximum"

let check_table (c : context) (tab : table) =
  let {tlimits = lim; etype = t} = tab.it in
  check_table_limits lim

let check_memory_limits (lim : Memory.size limits) =
  let {min; max} = lim.it in
  require (I32.lt_u min 65536l) lim.at
    "memory size must be less than 65536 pages (4GiB)";
  match max with
  | None -> ()
  | Some max ->
    require (I32.lt_u max 65536l) lim.at
      "memory size must be less than 65536 pages (4GiB)";
    require (I32.le_u min max) lim.at
      "memory size minimum must not be greater than maximum"

let check_memory (c : context) (mem : memory) =
  let {mlimits = lim} = mem.it in
  check_memory_limits lim

let check_table_segment c prev_end seg =
  let {offset; init} = seg.it in
  check_const c offset I32Type;
  let start = Values.I32Value.of_value (Eval.const c.module_ offset) in
  let len = Int32.of_int (List.length init) in
  let end_ = Int32.add start len in
  require (I32.le_u prev_end start) seg.at
    "table segment not disjoint and ordered";
  require (I32.le_u end_ (table c seg.at)) seg.at
    "table segment does not fit memory";
  ignore (List.map (func c) init);
  end_

let check_memory_segment c prev_end seg =
  let {offset; init} = seg.it in
  check_const c offset I32Type;
  let start =
    Int64.of_int32 (Values.I32Value.of_value (Eval.const c.module_ offset)) in
  let len = Int64.of_int (String.length init) in
  let end_ = Int64.add start len in
  let limit = Int64.mul (Int64.of_int32 (memory c seg.at)) Memory.page_size in
  require (I64.le_u prev_end start) seg.at
    "data segment not disjoint and ordered";
  require (I64.le_u end_ limit) seg.at
    "data segment does not fit memory";
  end_


(* Modules *)

let check_global c g =
  let {gtype; value} = g.it in
  check_const c value gtype

let check_start c start =
  Lib.Option.app (fun x ->
    require (func c x = FuncType ([], [])) x.at
      "start function must not have parameters or results"
  ) start

module NameSet = Set.Make(String)

let check_export c set ex =
  let {name; kind} = ex.it in
  (match kind with
  | `Func x -> ignore (func c x)
  | `Memory -> ignore (memory c ex.at)
  );
  require (not (NameSet.mem name set)) ex.at "duplicate export name";
  NameSet.add name set

let check_module m =
  let
    {types; table; memory; globals; funcs; start; elems; data;
     imports; exports} = m.it in
  let c =
    {
      module_ = m;
      types;
      funcs = List.map (fun f -> type_ types f.it.ftype) funcs;
      imports = List.map (fun i -> type_ types i.it.itype) imports;
      globals = [];
      locals = [];
      return = [];
      labels = [];
      table = Lib.Option.map (fun tab -> tab.it.tlimits.it.min) table;  
      memory = Lib.Option.map (fun mem -> mem.it.mlimits.it.min) memory;
    }
  in
  List.iter (check_global c) globals;
  let c' = {c with globals = List.map (fun g -> g.it.gtype) globals} in
  List.iter (check_func c') funcs;
  Lib.Option.app (check_table c') table;
  Lib.Option.app (check_memory c') memory;
  ignore (List.fold_left (check_export c') NameSet.empty exports);
  ignore (List.fold_left (check_table_segment c') 0l elems);
  ignore (List.fold_left (check_memory_segment c') 0L data);
  check_start c' start

