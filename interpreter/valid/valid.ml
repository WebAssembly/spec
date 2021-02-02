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
  types : func_type list;
  funcs : func_type list;
  tables : table_type list;
  memories : memory_type list;
  globals : global_type list;
  locals : value_type list;
  results : value_type list;
  labels : stack_type list;
}

let empty_context =
  { types = []; funcs = []; tables = []; memories = [];
    globals = []; locals = []; results = []; labels = [] }

let lookup category list x =
  try Lib.List32.nth list x.it with Failure _ ->
    error x.at ("unknown " ^ category ^ " " ^ Int32.to_string x.it)

let type_ (c : context) x = lookup "type" c.types x
let func (c : context) x = lookup "function" c.funcs x
let table (c : context) x = lookup "table" c.tables x
let memory (c : context) x = lookup "memory" c.memories x
let global (c : context) x = lookup "global" c.globals x
let local (c : context) x = lookup "local" c.locals x
let label (c : context) x = lookup "label" c.labels x


(* Stack typing *)

(*
 * Note: The declarative typing rules are non-deterministic, that is, they
 * have the liberty to locally "guess" the right types implied by the context.
 * In the algorithmic formulation required here, stack types are hence modelled
 * as lists of _options_ of types, where `None` represents a locally
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
    | TruncSF32 | TruncUF32 | TruncSatSF32 | TruncSatUF32
    | ReinterpretFloat -> F32Type
    | TruncSF64 | TruncUF64 | TruncSatSF64 | TruncSatUF64 -> F64Type
    ), I32Type
  | Values.I64 cvtop ->
    let open I64Op in
    (match cvtop with
    | ExtendSI32 | ExtendUI32 -> I32Type
    | WrapI64 -> error at "invalid conversion"
    | TruncSF32 | TruncUF32 | TruncSatSF32 | TruncSatUF32 -> F32Type
    | TruncSF64 | TruncUF64 | TruncSatSF64 | TruncSatUF64
    | ReinterpretFloat -> F64Type
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

let check_pack sz t at =
  require (packed_size sz < size t) at "invalid sign extension"

let check_unop unop at =
  match unop with
  | Values.I32 (IntOp.ExtendS sz) | Values.I64 (IntOp.ExtendS sz) ->
    check_pack sz (Values.type_of unop) at
  | _ -> ()

let check_memop (c : context) (memop : 'a memop) get_sz at =
  let MemoryType (lim, it) = memory c (0l @@ at) in
  let size =
    match get_sz memop.sz with
    | None -> size memop.ty
    | Some sz ->
      check_pack sz memop.ty at;
      packed_size sz
  in
  require (1 lsl memop.align <= size) at
    "alignment must not be larger than natural";
  if it = I32IndexType then
    require (I64.lt_u memop.offset 0x1_0000_0000L) at
      "offset out of range";
  it


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

let check_block_type (c : context) (bt : block_type) : func_type =
  match bt with
  | VarBlockType x -> type_ c x
  | ValBlockType None -> FuncType ([], [])
  | ValBlockType (Some t) -> FuncType ([], [t])

let rec check_instr (c : context) (e : instr) (s : infer_stack_type) : op_type =
  match e.it with
  | Unreachable ->
    [] -->... []

  | Nop ->
    [] --> []

  | Drop ->
    [peek 0 s] -~> []

  | Select ->
    let t = peek 1 s in
    [t; t; Some I32Type] -~> [t]

  | Block (bt, es) ->
    let FuncType (ts1, ts2) as ft = check_block_type c bt in
    check_block {c with labels = ts2 :: c.labels} es ft e.at;
    ts1 --> ts2

  | Loop (bt, es) ->
    let FuncType (ts1, ts2) as ft = check_block_type c bt in
    check_block {c with labels = ts1 :: c.labels} es ft e.at;
    ts1 --> ts2

  | If (bt, es1, es2) ->
    let FuncType (ts1, ts2) as ft = check_block_type c bt in
    check_block {c with labels = ts2 :: c.labels} es1 ft e.at;
    check_block {c with labels = ts2 :: c.labels} es2 ft e.at;
    (ts1 @ [I32Type]) --> ts2

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

  | LocalGet x ->
    [] --> [local c x]

  | LocalSet x ->
    [local c x] --> []

  | LocalTee x ->
    [local c x] --> [local c x]

  | GlobalGet x ->
    let GlobalType (t, mut) = global c x in
    [] --> [t]

  | GlobalSet x ->
    let GlobalType (t, mut) = global c x in
    require (mut = Mutable) x.at "global is immutable";
    [t] --> []

  | Load memop ->
    let it = check_memop c memop (Lib.Option.map fst) e.at in
    [value_type_of_index_type it] --> [memop.ty]

  | Store memop ->
    let it = check_memop c memop (fun sz -> sz) e.at in
    [value_type_of_index_type it; memop.ty] --> []

  | MemorySize ->
    let MemoryType (_, it) = memory c (0l @@ e.at) in
    [] --> [value_type_of_index_type it]

  | MemoryGrow ->
    let MemoryType (_, it) = memory c (0l @@ e.at) in
    [value_type_of_index_type it] --> [value_type_of_index_type it]

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
    check_unop unop e.at;
    let t = type_unop unop in
    [t] --> [t]

  | Binary binop ->
    let t = type_binop binop in
    [t; t] --> [t]

  | Convert cvtop ->
    let t1, t2 = type_cvtop e.at cvtop in
    [t1] --> [t2]

and check_seq (c : context) (s : infer_stack_type) (es : instr list)
  : infer_stack_type =
  match es with
  | [] ->
    s

  | _ ->
    let es', e = Lib.List.split_last es in
    let s' = check_seq c s es' in
    let {ins; outs} = check_instr c e s' in
    push outs (pop ins s' e.at)

and check_block (c : context) (es : instr list) (ft : func_type) at =
  let FuncType (ts1, ts2) = ft in
  let s = check_seq c (stack ts1) es in
  let s' = pop (stack ts2) s at in
  require (snd s' = []) at
    ("type mismatch: block requires " ^ string_of_stack_type ts2 ^
     " but stack has " ^ string_of_infer_types (snd s))


(* Types *)

let check_limits le_u {min; max} range at msg =
  require (le_u min range) at msg;
  match max with
  | None -> ()
  | Some max ->
    require (le_u max range) at msg;
    require (le_u min max) at
      "size minimum must not be greater than maximum"

let check_value_type (t : value_type) at =
  ()

let check_func_type (ft : func_type) at =
  let FuncType (ins, out) = ft in
  List.iter (fun t -> check_value_type t at) ins;
  List.iter (fun t -> check_value_type t at) out

let check_table_type (tt : table_type) at =
  let TableType (lim, _) = tt in
  check_limits I32.le_u lim 0xffff_ffffl at "table size must be at most 2^32-1"

let check_memory_type (mt : memory_type) at =
  let MemoryType (lim, it) = mt in
  match it with
  | I32IndexType ->
    check_limits I64.le_u lim 0x1_0000L at
      "memory size must be at most 65536 pages (4GiB)"
  | I64IndexType ->
    check_limits I64.le_u lim 0x1_0000_0000_0000L at
      "memory size must be at most 48 bits of pages"

let check_global_type (gt : global_type) at =
  let GlobalType (t, mut) = gt in
  check_value_type t at


let check_type (t : type_) =
  check_func_type t.it t.at


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

let check_func (c : context) (f : func) =
  let {ftype; locals; body} = f.it in
  let FuncType (ins, out) = type_ c ftype in
  let c' = {c with locals = ins @ locals; results = out; labels = [out]} in
  check_block c' body (FuncType ([], out)) f.at


let is_const (c : context) (e : instr) =
  match e.it with
  | Const _ -> true
  | GlobalGet x -> let GlobalType (_, mut) = global c x in mut = Immutable
  | _ -> false

let check_const (c : context) (const : const) (t : value_type) =
  require (List.for_all (is_const c) const.it) const.at
    "constant expression required";
  check_block c const.it (FuncType ([], [t])) const.at


(* Tables, Memories, & Globals *)

let check_table (c : context) (tab : table) =
  let {ttype} = tab.it in
  check_table_type ttype tab.at

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
  | TableImport tt ->
    check_table_type tt idesc.at;
    {c with tables = tt :: c.tables}
  | MemoryImport mt ->
    check_memory_type mt idesc.at;
    {c with memories = mt :: c.memories}
  | GlobalImport gt ->
    check_global_type gt idesc.at;
    {c with globals = gt :: c.globals}

module NameSet = Set.Make(struct type t = Ast.name let compare = compare end)

let check_export (c : context) (set : NameSet.t) (ex : export) : NameSet.t =
  let {name; edesc} = ex.it in
  (match edesc.it with
  | FuncExport x -> ignore (func c x)
  | TableExport x -> ignore (table c x)
  | MemoryExport x -> ignore (memory c x)
  | GlobalExport x -> ignore (global c x)
  );
  require (not (NameSet.mem name set)) ex.at "duplicate export name";
  NameSet.add name set

let check_module (m : module_) =
  let
    { types; imports; tables; memories; globals; funcs; start; elems; data;
      exports } = m.it
  in
  let c0 =
    List.fold_right check_import imports
      {empty_context with types = List.map (fun ty -> ty.it) types}
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
