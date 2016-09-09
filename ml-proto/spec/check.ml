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
  tables : table_type list;
  memories : memory_type list;
  globals : global_type list;
  locals : value_type list;
  results : value_type list;
  labels : result_type ref list;
}

let context m =
  { module_ = m; types = []; funcs = []; tables = []; memories = [];
    globals = []; locals = []; results = []; labels = [] }

let lookup category list x =
  try Lib.List32.nth list x.it with Failure _ ->
    error x.at ("unknown " ^ category ^ " " ^ Int32.to_string x.it)

let type_ c x = lookup "type" c.types x
let func c x = lookup "function" c.funcs x
let import c x = lookup "import" c.imports x
let local c x = lookup "local" c.locals x
let global c x = lookup "global" c.globals x
let label c x = lookup "label" c.labels x
let table c x = lookup "table" c.tables x
let memory c x = lookup "memory" c.memories x


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
  ignore (memory c (0l @@ at));
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
    c.results --> Bot

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

  | CallIndirect x ->
    ignore (table c (0l @@ e.at));
    let FuncType (ins, out) = type_ c x in
    (ins @ [I32Type]) --> Stack out

  | GetLocal x ->
    [] --> Stack [local c x]

  | SetLocal x ->
    [local c x] --> Stack []

  | TeeLocal x ->
    [local c x] --> Stack [local c x]

  | GetGlobal x ->
    let GlobalType (t, mut) = global c x in
    [] --> Stack [t]

  | SetGlobal x ->
    let GlobalType (t, mut) = global c x in
    require (mut = Mutable) x.at "global is immutable";
    [t] --> Stack []

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
    ignore (memory c (0l @@ e.at));
    [] --> Stack [I32Type]

  | GrowMemory ->
    ignore (memory c (0l @@ e.at));
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
  let FuncType (ins, out) = type_ c ftype in
  check_arity (List.length out) f.at;
  let vr = known out in
  let c' = {c with locals = ins @ locals; results = out; labels = [vr]} in
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


(* Tables, Memories, & Globals *)

let check_table_type (t : table_type) at =
  let TableType ({min; max}, _) = t in
  match max with
  | None -> ()
  | Some max ->
    require (I32.le_u min max) at
      "table size minimum must not be greater than maximum"

let check_table (c : context) (tab : table) =
  let {ttype} = tab.it in
  check_table_type ttype tab.at

let check_memory_type (t : memory_type) at =
  let MemoryType {min; max} = t in
  require (I32.lt_u min 65536l) at
    "memory size must be less than 65536 pages (4GiB)";
  match max with
  | None -> ()
  | Some max ->
    require (I32.lt_u max 65536l) at
      "memory size must be less than 65536 pages (4GiB)";
    require (I32.le_u min max) at
      "memory size minimum must not be greater than maximum"

let check_memory (c : context) (mem : memory) =
  let {mtype} = mem.it in
  check_memory_type mtype mem.at

let check_table_segment c prev_end seg =
  let {index; offset; init} = seg.it in
  check_const c offset I32Type;
  let start = Values.I32Value.of_value (Eval.const c.module_ offset) in
  let len = Int32.of_int (List.length init) in
  let end_ = Int32.add start len in
  let TableType (lim, _) = table c index in
  require (I32.le_u prev_end start) seg.at
    "table segment not disjoint and ordered";
  require (I32.le_u end_ lim.min) seg.at
    "table segment does not fit into table";
  ignore (List.map (func c) init);
  end_

let check_memory_segment c prev_end seg =
  let {index; offset; init} = seg.it in
  check_const c offset I32Type;
  let start =
    Int64.of_int32 (Values.I32Value.of_value (Eval.const c.module_ offset)) in
  let len = Int64.of_int (String.length init) in
  let end_ = Int64.add start len in
  let MemoryType lim = memory c index in
  let limit = Int64.mul (Int64.of_int32 lim.min) Memory.page_size in
  require (I64.le_u prev_end start) seg.at
    "data segment not disjoint and ordered";
  require (I64.le_u end_ limit) seg.at
    "data segment does not fit into memory";
  end_

let check_global c glob =
  let {gtype; value} = glob.it in
  let GlobalType (t, mut) = gtype in
  check_const c value t;
  {c with globals = c.globals @ [gtype]}


(* Modules *)

let check_start c start =
  Lib.Option.app (fun x ->
    require (func c x = FuncType ([], [])) x.at
      "start function must not have parameters or results"
  ) start

let check_import im c =
  let {module_name = _; item_name = _; ikind} = im.it in
  match ikind.it with
  | FuncImport x ->
    {c with funcs = type_ c x :: c.funcs}
  | TableImport t ->
    check_table_type t ikind.at; {c with tables = t :: c.tables}
  | MemoryImport t ->
    check_memory_type t ikind.at; {c with memories = t :: c.memories}
  | GlobalImport t ->
    let GlobalType (_, mut) = t in
    require (mut = Immutable) ikind.at "mutable globals cannot be imported (yet)";
    {c with globals = t :: c.globals}

module NameSet = Set.Make(String)

let check_export c set ex =
  let {name; ekind; item} = ex.it in
  (match ekind.it with
  | FuncExport -> ignore (func c item)
  | TableExport -> ignore (table c item)
  | MemoryExport -> ignore (memory c item)
  | GlobalExport ->
    let GlobalType (_, mut) = global c item in
    require (mut = Immutable) ekind.at "mutable globals cannot be exported (yet)"
  );
  require (not (NameSet.mem name set)) ex.at "duplicate export name";
  NameSet.add name set

let check_module (m : module_) =
  let
    {types; imports; tables; memories; globals; funcs; start; elems; data;
     exports} = m.it in
  let c = List.fold_right check_import imports {(context m) with types} in
  let c' =
    { (List.fold_left check_global c globals) with
      funcs = c.funcs @ List.map (fun f -> type_ c f.it.ftype) funcs;
      tables = c.tables @ List.map (fun tab -> tab.it.ttype) tables;
      memories = c.memories @ List.map (fun mem -> mem.it.mtype) memories;
    }
  in
  require (List.length c'.tables <= 1) m.at "multiple tables";
  require (List.length c'.memories <= 1) m.at "multiple memories";
  List.iter (check_func c') funcs;
  List.iter (check_table c') tables;
  List.iter (check_memory c') memories;
  ignore (List.fold_left (check_table_segment c') 0l elems);
  ignore (List.fold_left (check_memory_segment c') 0L data);
  ignore (List.fold_left (check_export c') NameSet.empty exports);
  check_start c' start

