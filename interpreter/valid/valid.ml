open Ast
open Source
open Types


(* Errors *)

module Invalid = Error.Make ()
exception Invalid = Invalid.Error

let error = Invalid.error
let require b at s = if not b then error at s


(* Context *)

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
  labels : stack_type list;
}

let context m =
  { module_ = m; types = []; funcs = []; tables = []; memories = [];
    globals = []; locals = []; results = []; labels = [] }

let lookup category list x =
  try Lib.List32.nth list x.it with Failure _ ->
    error x.at ("unknown " ^ category ^ " " ^ Int32.to_string x.it)

let type_ (c : context) x = lookup "type" c.types x
let func (c : context) x = lookup "function" c.funcs x
let local (c : context) x = lookup "local" c.locals x
let global (c : context) x = lookup "global" c.globals x
let label (c : context) x = lookup "label" c.labels x
let table (c : context) x = lookup "table" c.tables x
let memory (c : context) x = lookup "memory" c.memories x


(* Stack typing *)

(*
 * Note: The declarative typing rules are non-deterministic, that is, they
 * have the liberty to locally "guess" the right types implied by the context.
 * In the algorithmic formulation required here, stack types are hence modelled
 * as lists of _options_ of types here, where `None` representss a locally
 * unknown type. Furthermore, an ellipses flag represents arbitrary sequences
 * of unknown types, in order to handle stack polymorphism algorithmically.
 *)

type ellipses = NoEllipses | Ellipses
type infer_stack_type = ellipses * value_type option list
type op_type = {ins : infer_stack_type; outs : infer_stack_type}

let known = List.map (fun t -> Some t)
let stack ts = (NoEllipses, known ts)
let (-~>) ts1 ts2 = {ins = NoEllipses, ts1; outs = NoEllipses, ts2}
let (-->) ts1 ts2 = {ins = NoEllipses, known ts1; outs = NoEllipses, known ts2}
let (-->...) ts1 ts2 = {ins = Ellipses, known ts1; outs = Ellipses, known ts2}

let string_of_infer_type t =
  Lib.Option.get (Lib.Option.map string_of_value_type t) "_"
let string_of_infer_types ts =
  "[" ^ String.concat " " (List.map string_of_infer_type ts) ^ "]"

let eq_ty t1 t2 = (t1 = t2 || t1 = None || t2 = None)
let check_stack ts1 ts2 at =
  require (List.length ts1 = List.length ts2 && List.for_all2 eq_ty ts1 ts2) at
    ("type mismatch: operator requires " ^ string_of_infer_types ts1 ^
     " but stack has " ^ string_of_infer_types ts2)

let pop (ell1, ts1) (ell2, ts2) at =
  let n1 = List.length ts1 in
  let n2 = List.length ts2 in
  let n = min n1 n2 in
  let n3 = if ell2 = Ellipses then (n1 - n) else 0 in
  check_stack ts1 (Lib.List.make n3 None @ Lib.List.drop (n2 - n) ts2) at;
  (ell2, if ell1 = Ellipses then [] else Lib.List.take (n2 - n) ts2)

let push (ell1, ts1) (ell2, ts2) =
  assert (ell1 = NoEllipses || ts2 = []);
  (if ell1 = Ellipses || ell2 = Ellipses then Ellipses else NoEllipses),
  ts2 @ ts1

let peek i (ell, ts) =
  try List.nth (List.rev ts) i with Failure _ -> None


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
  let size =
    match get_sz memop.sz with
    | None -> size memop.ty
    | Some sz ->
      require (memop.ty = I64Type || sz <> Memory.Mem32) at
        "memory size too big";
      Memory.mem_size sz
  in
  require (1 lsl memop.align <= size) at
    "alignment must not be larger than natural"

let check_arity n at =
  require (n <= 1) at "invalid result arity, larger than 1 is not (yet) allowed"


(*
 * Conventions:
 *   c  : context
 *   e  : instr
 *   es : instr list
 *   v  : value
 *   t  : value_type var
 *   ts : stack_type
 *   x  : variable
 *
 * Note: To deal with the non-determinism in some of the declarative rules,
 * the function takes the current stack `s` as an additional argument, allowing
 * it to "peek" when it would otherwise have to guess an input type.
 *
 * Furthermore, stack-polymorphic types are given with the `-->...` operator:
 * a type `ts1 -->... ts2` expresses any type `(ts1' @ ts1) -> (ts2' @ ts2)`
 * where `ts1'` and `ts2'` would be chosen non-deterministically in the
 * declarative typing rules.
 *)

let type_instr (c : context) (e : instr) (s : infer_stack_type) : op_type =
  match e.it with
  | Unreachable ->
    [] -->... []

  | Nop ->
    [] --> []

  | Block (ts, es) ->
    [] --> ts

  | Loop (ts, es) ->
    [] --> ts

  | If (ts, es1, es2) ->
    [I32Type] --> ts

  | Br x ->
    [] -->... []

  | BrIf x ->
    [I32Type] --> []

  | BrTable (xs, x) ->
    [I32Type] -->... []

  | Return ->
    c.results -->... []

  | Call x ->
    let FuncType (ins, out) = func c x in
    (* prerr_endline ("Call " ^ Int32.to_string (x.it) ^ "  " ^ string_of_infer_types (List.map (fun x -> Some x) ins) ^ ", " ^ string_of_infer_types (List.map (fun x -> Some x) out)); *)
    ins --> out

  | CallIndirect x ->
    ignore (table c (0l @@ e.at));
    let FuncType (ins, out) = type_ c x in
    (ins @ [I32Type]) --> out

  | Drop ->
    [peek 0 s] -~> []

  | Select ->
    let t = peek 1 s in
    [t; t; Some I32Type] -~> [t]

  | GetLocal x ->
    [] --> [local c x]

  | SetLocal x ->
    [local c x] --> []

  | TeeLocal x ->
    [local c x] --> [local c x]

  | GetGlobal x ->
    let GlobalType (t, mut) = global c x in
    [] --> [t]

  | SetGlobal x ->
    let GlobalType (t, mut) = global c x in
    require (mut = Mutable) x.at "global is immutable";
    [t] --> []

  | Load memop ->
    check_memop c memop (Lib.Option.map fst) e.at;
    [I32Type] --> [memop.ty]

  | Store memop ->
    check_memop c memop (fun sz -> sz) e.at;
    [I32Type; memop.ty] --> []

  | CurrentMemory ->
    ignore (memory c (0l @@ e.at));
    [] --> [I32Type]

  | GrowMemory ->
    ignore (memory c (0l @@ e.at));
    [I32Type] --> [I32Type]

  | Const v ->
    let t = type_value v.it in
    [] --> [t]

  | Test testop ->
    let t = type_testop testop in
    [t] --> [I32Type]

  | Compare relop ->
    let t = type_relop relop in
    [t; t] --> [I32Type]

  | Unary unop ->
    let t = type_unop unop in
    [t] --> [t]

  | Binary binop ->
    let t = type_binop binop in
    [t; t] --> [t]

  | Convert cvtop ->
    let t1, t2 = type_cvtop e.at cvtop in
    [t1] --> [t2]

let rec type_seq (c : context) (es : instr list) : infer_stack_type =
  match es with
  | [] ->
    stack []
  | _ ->
    let es', e = Lib.List.split_last es in
    let s = type_seq c es' in
    let {ins; outs} = type_instr c e s in
    let res = push outs (pop ins s e.at) in
    (* prerr_endline (string_of_infer_types (snd res)); *)
    res

let rec check_instr (c : context) (e : instr) (s : infer_stack_type) : op_type =
  match e.it with
  | Unreachable ->
    [] -->... []

  | Nop ->
    [] --> []

  | Block (ts, es) ->
    check_arity (List.length ts) e.at;
    check_block {c with labels = ts :: c.labels} es ts e.at;
    [] --> ts

  | Loop (ts, es) ->
    check_arity (List.length ts) e.at;
    check_block {c with labels = [] :: c.labels} es ts e.at;
    [] --> ts

  | If (ts, es1, es2) ->
    check_arity (List.length ts) e.at;
    check_block {c with labels = ts :: c.labels} es1 ts e.at;
    check_block {c with labels = ts :: c.labels} es2 ts e.at;
    [I32Type] --> ts

  | Br x ->
    label c x -->... []

  | BrIf x ->
    (label c x @ [I32Type]) --> label c x

  | BrTable (xs, x) ->
    let ts = label c x in
    List.iter (fun x' -> check_stack (known ts) (known (label c x')) x'.at) xs;
    (label c x @ [I32Type]) -->... []

  | Return ->
    c.results -->... []

  | Call x ->
    let FuncType (ins, out) = func c x in
    ins --> out

  | CallIndirect x ->
    ignore (table c (0l @@ e.at));
    let FuncType (ins, out) = type_ c x in
    (ins @ [I32Type]) --> out

  | Drop ->
    [peek 0 s] -~> []

  | Select ->
    let t = peek 1 s in
    [t; t; Some I32Type] -~> [t]

  | GetLocal x ->
    [] --> [local c x]

  | SetLocal x ->
    [local c x] --> []

  | TeeLocal x ->
    [local c x] --> [local c x]

  | GetGlobal x ->
    let GlobalType (t, mut) = global c x in
    [] --> [t]

  | SetGlobal x ->
    let GlobalType (t, mut) = global c x in
    require (mut = Mutable) x.at "global is immutable";
    [t] --> []

  | Load memop ->
    check_memop c memop (Lib.Option.map fst) e.at;
    [I32Type] --> [memop.ty]

  | Store memop ->
    check_memop c memop (fun sz -> sz) e.at;
    [I32Type; memop.ty] --> []

  | CurrentMemory ->
    ignore (memory c (0l @@ e.at));
    [] --> [I32Type]

  | GrowMemory ->
    ignore (memory c (0l @@ e.at));
    [I32Type] --> [I32Type]

  | Const v ->
    let t = type_value v.it in
    [] --> [t]

  | Test testop ->
    let t = type_testop testop in
    [t] --> [I32Type]

  | Compare relop ->
    let t = type_relop relop in
    [t; t] --> [I32Type]

  | Unary unop ->
    let t = type_unop unop in
    [t] --> [t]

  | Binary binop ->
    let t = type_binop binop in
    [t; t] --> [t]

  | Convert cvtop ->
    let t1, t2 = type_cvtop e.at cvtop in
    [t1] --> [t2]

and check_seq (c : context) (es : instr list) : infer_stack_type =
  match es with
  | [] ->
    stack []

  | _ ->
    let es', e = Lib.List.split_last es in
    let s = check_seq c es' in
    let {ins; outs} = check_instr c e s in
    push outs (pop ins s e.at)

and check_block (c : context) (es : instr list) (ts : stack_type) at =
  let s = check_seq c es in
  let s' = pop (stack ts) s at in
  require (snd s' = []) at
    ("type mismatch: operator requires " ^ string_of_stack_type ts ^
     " but stack has " ^ string_of_infer_types (snd s))


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
 *   x : variable
 *)

let check_type (t : type_) =
  let FuncType (ins, out) = t.it in
  check_arity (List.length out) t.at

let check_func (c : context) (f : func) =
  let {ftype; locals; body} = f.it in
  let FuncType (ins, out) = type_ c ftype in
  let c' = {c with locals = ins @ locals; results = out; labels = [out]} in
  check_block c' body out f.at


let is_const (c : context) (e : instr) =
  match e.it with
  | Const _ -> true
  | GetGlobal x -> let GlobalType (_, mut) = global c x in mut = Immutable
  | _ -> false

let check_const (c : context) (const : const) (t : value_type) =
  require (List.for_all (is_const c) const.it) const.at
    "constant expression required";
  check_block c const.it [t] const.at


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
  require (I32.le_u min 65536l) at
    "memory size must be at most 65536 pages (4GiB)";
  match max with
  | None -> ()
  | Some max ->
    require (I32.le_u max 65536l) at
      "memory size must be at most 65536 pages (4GiB)";
    require (I32.le_u min max) at
      "memory size minimum must not be greater than maximum"

let check_memory (c : context) (mem : memory) =
  let {mtype} = mem.it in
  check_memory_type mtype mem.at

let check_elem (c : context) (seg : table_segment) =
  let {index; offset; init} = seg.it in
  check_const c offset I32Type;
  ignore (table c index);
  ignore (List.map (func c) init)

let check_data (c : context) (seg : memory_segment) =
  let {index; offset; init} = seg.it in
  check_const c offset I32Type;
  ignore (memory c index)

let check_global (c : context) (glob : global) =
  let {gtype; value} = glob.it in
  let GlobalType (t, mut) = gtype in
  check_const c value t


(* Modules *)

let check_start (c : context) (start : var option) =
  Lib.Option.app (fun x ->
    require (func c x = FuncType ([], [])) x.at
      "start function must not have parameters or results"
  ) start

let check_import (im : import) (c : context) : context =
  let {module_name = _; item_name = _; idesc} = im.it in
  match idesc.it with
  | FuncImport x ->
    {c with funcs = type_ c x :: c.funcs}
  | TableImport t ->
    check_table_type t idesc.at; {c with tables = t :: c.tables}
  | MemoryImport t ->
    check_memory_type t idesc.at; {c with memories = t :: c.memories}
  | GlobalImport t ->
    let GlobalType (_, mut) = t in
    require (mut = Immutable) idesc.at
      "mutable globals cannot be imported (yet)";
    {c with globals = t :: c.globals}

module NameSet = Set.Make(struct type t = Ast.name let compare = compare end)

let check_export (c : context) (set : NameSet.t) (ex : export) : NameSet.t =
  let {name; edesc} = ex.it in
  (match edesc.it with
  | FuncExport x -> ignore (func c x)
  | TableExport x -> ignore (table c x)
  | MemoryExport x -> ignore (memory c x)
  | GlobalExport x ->
    let GlobalType (_, mut) = global c x in
    require (mut = Immutable) edesc.at
      "mutable globals cannot be exported (yet)"
  );
  require (not (NameSet.mem name set)) ex.at ("duplicate export name " ^ Utf8.encode name);
  NameSet.add name set

let check_module (m : module_) =
  let
    { types; imports; tables; memories; globals; funcs; start; elems; data;
      exports } = m.it
  in
  let c0 =
    List.fold_right check_import imports
      {(context m) with types = List.map (fun ty -> ty.it) types}
  in
  let c1 =
    { c0 with
      funcs = c0.funcs @ List.map (fun f -> type_ c0 f.it.ftype) funcs;
      tables = c0.tables @ List.map (fun tab -> tab.it.ttype) tables;
      memories = c0.memories @ List.map (fun mem -> mem.it.mtype) memories;
    }
  in
  let c =
    { c1 with globals = c1.globals @ List.map (fun g -> g.it.gtype) globals }
  in
  List.iter check_type types;
  List.iter (check_global c1) globals;
  List.iter (check_table c1) tables;
  List.iter (check_memory c1) memories;
  List.iter (check_elem c1) elems;
  List.iter (check_data c1) data;
  List.iter (check_func c) funcs;
  check_start c start;
  ignore (List.fold_left (check_export c) NameSet.empty exports);
  require (List.length c.tables <= 1) m.at
    "multiple tables are not allowed (yet)";
  require (List.length c.memories <= 1) m.at
    "multiple memories are not allowed (yet)"

let module_context (m : module_) =
  let
    { types; imports; tables; memories; globals; funcs; start; elems; data;
      exports } = m.it
  in
  let c0 =
    List.fold_right check_import imports
      {(context m) with types = List.map (fun ty -> ty.it) types}
  in
  let c1 =
    { c0 with
      funcs = c0.funcs @ List.map (fun f -> type_ c0 f.it.ftype) funcs;
      tables = c0.tables @ List.map (fun tab -> tab.it.ttype) tables;
      memories = c0.memories @ List.map (fun mem -> mem.it.mtype) memories;
    }
  in
  { c1 with globals = c1.globals @ List.map (fun g -> g.it.gtype) globals }


let func_context (c : context) (f : func) =
  let {ftype; locals; body} = f.it in
  let FuncType (ins, out) = type_ c ftype in
  {c with locals = ins @ locals; results = out; labels = [out]}

