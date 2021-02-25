open Ast
open Source
open Types
open Match


(* Errors *)

module Invalid = Error.Make ()
exception Invalid = Invalid.Error

let error = Invalid.error
let require b at s = if not b then error at s


(* Context *)

type context =
{
  types : def_type list;
  funcs : syn_var list;
  tables : table_type list;
  memories : memory_type list;
  globals : global_type list;
  elems : ref_type list;
  datas : unit list;
  locals : value_type list;
  results : value_type list;
  labels : stack_type list;
  refs : Free.t;
}

let empty_context =
  { types = []; funcs = []; tables = []; memories = [];
    globals = []; elems = []; datas = [];
    locals = []; results = []; labels = [];
    refs = Free.empty
  }

let lookup category list x =
  try Lib.List32.nth list x.it with Failure _ ->
    error x.at ("unknown " ^ category ^ " " ^ Int32.to_string x.it)

let type_ (c : context) x = lookup "type" c.types x
let func_var (c : context) x = lookup "function" c.funcs x
let table (c : context) x = lookup "table" c.tables x
let memory (c : context) x = lookup "memory" c.memories x
let global (c : context) x = lookup "global" c.globals x
let elem (c : context) x = lookup "elem segment" c.elems x
let data (c : context) x = lookup "data segment" c.datas x
let local (c : context) x = lookup "local" c.locals x
let label (c : context) x = lookup "label" c.labels x

let func_type (c : context) x =
  match type_ c x with
  | FuncDefType ft -> ft

let func (c : context) x = func_type c (func_var c x @@ x.at)

let refer category (s : Free.Set.t) x =
  if not (Free.Set.mem x.it s) then
    error x.at
      ("undeclared " ^ category ^ " reference " ^ Int32.to_string x.it)

let refer_func (c : context) x = refer "function" c.refs.Free.funcs x


(* Types *)

let check_limits {min; max} range at msg =
  require (I32.le_u min range) at msg;
  match max with
  | None -> ()
  | Some max ->
    require (I32.le_u max range) at msg;
    require (I32.le_u min max) at
      "size minimum must not be greater than maximum"

let check_num_type (c : context) (t : num_type) at =
  ()

let check_heap_type (c : context) (t : heap_type) at =
  match t with
  | FuncHeapType | ExternHeapType -> ()
  | DefHeapType (SynVar x) -> ignore (type_ c (x @@ at))
  | DefHeapType (SemVar _) | BotHeapType -> assert false

let check_ref_type (c : context) (t : ref_type) at =
  match t with
  | (_nul, t') -> check_heap_type c t' at

let check_value_type (c : context) (t : value_type) at =
  match t with
  | NumType t' -> check_num_type c t' at
  | RefType t' -> check_ref_type c t' at
  | BotType -> ()

let check_func_type (c : context) (ft : func_type) at =
  let FuncType (ts1, ts2) = ft in
  List.iter (fun t -> check_value_type c t at) ts1;
  List.iter (fun t -> check_value_type c t at) ts2

let check_table_type (c : context) (tt : table_type) at =
  let TableType (lim, t) = tt in
  check_limits lim 0xffff_ffffl at "table size must be at most 2^32-1";
  check_ref_type c t at;
  require (defaultable_ref_type t) at "non-defaultable element type"

let check_memory_type (c : context) (mt : memory_type) at =
  let MemoryType lim = mt in
  check_limits lim 0x1_0000l at
    "memory size must be at most 65536 pages (4GiB)"

let check_global_type (c : context) (gt : global_type) at =
  let GlobalType (t, mut) = gt in
  check_value_type c t at

let check_def_type (c : context) (dt : def_type) at =
  match dt with
  | FuncDefType ft -> check_func_type c ft at


let check_type (c : context) (t : type_) =
  check_def_type c t.it t.at


(* Stack typing *)

(*
 * Note: The declarative typing rules are non-deterministic, that is, they
 * have the liberty to locally "guess" the right types implied by the context.
 * In the algorithmic formulation required here, stack types may hence pick
 * `BotType` as the principal choice for a locally unknown type.
 * Furthermore, an ellipses flag represents arbitrary sequences
 * of unknown types, in order to handle stack polymorphism algorithmically.
 *)

type ellipses = NoEllipses | Ellipses
type infer_stack_type = ellipses * value_type list
type op_type = {ins : infer_stack_type; outs : infer_stack_type}

let stack ts = (NoEllipses, ts)
let (-->) ts1 ts2 = {ins = NoEllipses, ts1; outs = NoEllipses, ts2}
let (-->...) ts1 ts2 = {ins = Ellipses, ts1; outs = Ellipses, ts2}

let check_stack (c : context) ts1 ts2 at =
  require
    (List.length ts1 = List.length ts2 &&
      List.for_all2 (match_value_type c.types []) ts1 ts2) at
    ("type mismatch: instruction requires " ^ string_of_stack_type ts2 ^
     " but stack has " ^ string_of_stack_type ts1)

let pop c (ell1, ts1) (ell2, ts2) at =
  let n1 = List.length ts1 in
  let n2 = List.length ts2 in
  let n = min n1 n2 in
  let n3 = if ell2 = Ellipses then (n1 - n) else 0 in
  check_stack c (Lib.List.make n3 BotType @ Lib.List.drop (n2 - n) ts2) ts1 at;
  (ell2, if ell1 = Ellipses then [] else Lib.List.take (n2 - n) ts2)

let push c (ell1, ts1) (ell2, ts2) =
  assert (ell1 = NoEllipses || ts2 = []);
  (if ell1 = Ellipses || ell2 = Ellipses then Ellipses else NoEllipses),
  ts2 @ ts1

let peek i (ell, ts) =
  try List.nth (List.rev ts) i with Failure _ -> BotType

let peek_num i (ell, ts) at =
  let t = peek i (ell, ts) in
  require (is_num_type t) at
    ("type mismatch: instruction requires numeric type" ^
     " but stack has " ^ string_of_value_type t);
  t

let peek_ref i (ell, ts) at =
  match peek i (ell, ts) with
  | RefType rt -> rt
  | BotType -> (NonNullable, BotHeapType)
  | t ->
    error at
      ("type mismatch: instruction requires reference type" ^
       " but stack has " ^ string_of_value_type t)


(* Type Synthesis *)

let type_num = Value.type_of_num
let type_unop = Value.type_of_num
let type_binop = Value.type_of_num
let type_testop = Value.type_of_num
let type_relop = Value.type_of_num

let type_cvtop at = function
  | Value.I32 cvtop ->
    let open I32Op in
    (match cvtop with
    | ExtendSI32 | ExtendUI32 -> error at "invalid conversion"
    | WrapI64 -> I64Type
    | TruncSF32 | TruncUF32 | TruncSatSF32 | TruncSatUF32
    | ReinterpretFloat -> F32Type
    | TruncSF64 | TruncUF64 | TruncSatSF64 | TruncSatUF64 -> F64Type
    ), I32Type
  | Value.I64 cvtop ->
    let open I64Op in
    (match cvtop with
    | ExtendSI32 | ExtendUI32 -> I32Type
    | WrapI64 -> error at "invalid conversion"
    | TruncSF32 | TruncUF32 | TruncSatSF32 | TruncSatUF32 -> F32Type
    | TruncSF64 | TruncUF64 | TruncSatSF64 | TruncSatUF64
    | ReinterpretFloat -> F64Type
    ), I64Type
  | Value.F32 cvtop ->
    let open F32Op in
    (match cvtop with
    | ConvertSI32 | ConvertUI32 | ReinterpretInt -> I32Type
    | ConvertSI64 | ConvertUI64 -> I64Type
    | PromoteF32 -> error at "invalid conversion"
    | DemoteF64 -> F64Type
    ), F32Type
  | Value.F64 cvtop ->
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
  | Value.I32 (IntOp.ExtendS sz) | Value.I64 (IntOp.ExtendS sz) ->
    check_pack sz (Value.type_of_num unop) at
  | _ -> ()

let check_memop (c : context) (memop : 'a memop) get_sz at =
  let _mt = memory c (0l @@ at) in
  let size =
    match get_sz memop.sz with
    | None -> size memop.ty
    | Some sz ->
      check_pack sz memop.ty at;
      packed_size sz
  in
  require (1 lsl memop.align <= size) at
    "alignment must not be larger than natural"


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

let check_block_type (c : context) (bt : block_type) at : func_type =
  match bt with
  | ValBlockType None -> FuncType ([], [])
  | ValBlockType (Some t) -> check_value_type c t at; FuncType ([], [t])
  | VarBlockType (SynVar x) -> func_type c (x @@ at)
  | VarBlockType (SemVar _) -> assert false

let check_local (c : context) (defaults : bool) (t : local) =
  check_value_type c t.it t.at;
  require (not defaults || defaultable_value_type t.it) t.at
    "non-defaultable local type"

let rec check_instr (c : context) (e : instr) (s : infer_stack_type) : op_type =
  match e.it with
  | Unreachable ->
    [] -->... []

  | Nop ->
    [] --> []

  | Drop ->
    [peek 0 s] --> []

  | Select None ->
    let t = peek_num 1 s e.at in
    [t; t; NumType I32Type] --> [t]

  | Select (Some ts) ->
    require (List.length ts = 1) e.at "invalid result arity other than 1 is not (yet) allowed";
    List.iter (fun t -> check_value_type c t e.at) ts;
    (ts @ ts @ [NumType I32Type]) --> ts

  | Block (bt, es) ->
    let FuncType (ts1, ts2) as ft = check_block_type c bt e.at in
    check_block {c with labels = ts2 :: c.labels} es ft e.at;
    ts1 --> ts2

  | Loop (bt, es) ->
    let FuncType (ts1, ts2) as ft = check_block_type c bt e.at in
    check_block {c with labels = ts1 :: c.labels} es ft e.at;
    ts1 --> ts2

  | If (bt, es1, es2) ->
    let FuncType (ts1, ts2) as ft = check_block_type c bt e.at in
    check_block {c with labels = ts2 :: c.labels} es1 ft e.at;
    check_block {c with labels = ts2 :: c.labels} es2 ft e.at;
    (ts1 @ [NumType I32Type]) --> ts2

  | Let (bt, locals, es) ->
    let FuncType (ts1, ts2) as ft = check_block_type c bt e.at in
    List.iter (check_local c false) locals;
    let c' =
      { c with
        labels = ts2 :: c.labels;
        locals = List.map Source.it locals @ c.locals;
      }
    in check_block c' es ft e.at;
    (ts1 @ List.map Source.it locals) --> ts2

  | Br x ->
    label c x -->... []

  | BrIf x ->
    (label c x @ [NumType I32Type]) --> label c x

  | BrTable (xs, x) ->
    let n = List.length (label c x) in
    let ts = Lib.List.table n (fun i -> peek (n - i) s) in
    check_stack c ts (label c x) x.at;
    List.iter (fun x' -> check_stack c ts (label c x') x'.at) xs;
    (ts @ [NumType I32Type]) -->... []

  | BrOnNull x ->
    let (_, t) = peek_ref 0 s e.at in
    (label c x @ [RefType (Nullable, t)]) -->
      (label c x @ [RefType (NonNullable, t)])

  | Return ->
    c.results -->... []

  | Call x ->
    let FuncType (ts1, ts2) = func c x in
    ts1 --> ts2

  | CallRef ->
    (match peek_ref 0 s e.at with
    | (nul, DefHeapType (SynVar x)) ->
      let FuncType (ts1, ts2) = func_type c (x @@ e.at) in
      (ts1 @ [RefType (nul, DefHeapType (SynVar x))]) --> ts2
    | (_, BotHeapType) ->
      [] -->... []
    | _ -> assert false
    )

  | CallIndirect (x, y) ->
    let TableType (lim, t) = table c x in
    let FuncType (ts1, ts2) = func_type c y in
    require (match_ref_type c.types [] t (Nullable, FuncHeapType)) x.at
      ("type mismatch: instruction requires table of function type" ^
       " but table has element type " ^ string_of_ref_type t);
    (ts1 @ [NumType I32Type]) --> ts2

  | ReturnCallRef ->
    (match peek_ref 0 s e.at with
    | (nul, DefHeapType (SynVar x)) ->
      let FuncType (ts1, ts2) = func_type c (x @@ e.at) in
      require (match_stack_type c.types [] ts2 c.results) e.at
        ("type mismatch: current function requires result type " ^
         string_of_stack_type c.results ^
         " but callee returns " ^ string_of_stack_type ts2);
      (ts1 @ [RefType (nul, DefHeapType (SynVar x))]) -->... []
    | (_, BotHeapType) ->
      [] -->... []
    | rt ->
      error e.at
        ("type mismatch: instruction requires function reference type" ^
         " but stack has " ^ string_of_value_type (RefType rt))
    )

  | FuncBind x ->
    (match peek_ref 0 s e.at with
    | (nul, DefHeapType (SynVar y)) ->
      let FuncType (ts1, ts2) = func_type c (y @@ e.at) in
      let FuncType (ts1', _) as ft' = func_type c x in
      require (List.length ts1 >= List.length ts1') x.at
        "type mismatch in function arguments";
      let ts11, ts12 = Lib.List.split (List.length ts1 - List.length ts1') ts1 in
      require (match_func_type c.types [] (FuncType (ts12, ts2)) ft') e.at
        "type mismatch in function type";
      (ts11 @ [RefType (nul, DefHeapType (SynVar y))]) -->
        [RefType (NonNullable, DefHeapType (SynVar x.it))]
    | (_, BotHeapType) ->
      [] -->... [RefType (NonNullable, DefHeapType (SynVar x.it))]
    | rt ->
      error e.at
        ("type mismatch: instruction requires function reference type" ^
         " but stack has " ^ string_of_value_type (RefType rt))
    )

  | LocalGet x ->
    [] --> [local c x]

  | LocalSet x ->
    [local c x] --> []

  | LocalTee x ->
    [local c x] --> [local c x]

  | GlobalGet x ->
    let GlobalType (t, _mut) = global c x in
    [] --> [t]

  | GlobalSet x ->
    let GlobalType (t, mut) = global c x in
    require (mut = Mutable) x.at "global is immutable";
    [t] --> []

  | TableGet x ->
    let TableType (_lim, t) = table c x in
    [NumType I32Type] --> [RefType t]

  | TableSet x ->
    let TableType (_lim, t) = table c x in
    [NumType I32Type; RefType t] --> []

  | TableSize x ->
    let _tt = table c x in
    [] --> [NumType I32Type]

  | TableGrow x ->
    let TableType (_lim, t) = table c x in
    [RefType t; NumType I32Type] --> [NumType I32Type]

  | TableFill x ->
    let TableType (_lim, t) = table c x in
    [NumType I32Type; RefType t; NumType I32Type] --> []

  | TableCopy (x, y) ->
    let TableType (_lim1, t1) = table c x in
    let TableType (_lim2, t2) = table c y in
    require (match_ref_type c.types [] t2 t1) x.at
      ("type mismatch: source element type " ^ string_of_ref_type t1 ^
       " does not match destination element type " ^ string_of_ref_type t2);
    [NumType I32Type; NumType I32Type; NumType I32Type] --> []

  | TableInit (x, y) ->
    let TableType (_lim1, t1) = table c x in
    let t2 = elem c y in
    require (match_ref_type c.types [] t2 t1) x.at
      ("type mismatch: element segment's type " ^ string_of_ref_type t1 ^
       " does not match table's element type " ^ string_of_ref_type t2);
    [NumType I32Type; NumType I32Type; NumType I32Type] --> []

  | ElemDrop x ->
    ignore (elem c x);
    [] --> []

  | Load memop ->
    check_memop c memop (Lib.Option.map fst) e.at;
    [NumType I32Type] --> [NumType memop.ty]

  | Store memop ->
    check_memop c memop (fun sz -> sz) e.at;
    [NumType I32Type; NumType memop.ty] --> []

  | MemorySize ->
    let _mt = memory c (0l @@ e.at) in
    [] --> [NumType I32Type]

  | MemoryGrow ->
    let _mt = memory c (0l @@ e.at) in
    [NumType I32Type] --> [NumType I32Type]

  | MemoryFill ->
    ignore (memory c (0l @@ e.at));
    [NumType I32Type; NumType I32Type; NumType I32Type] --> []

  | MemoryCopy ->
    ignore (memory c (0l @@ e.at));
    [NumType I32Type; NumType I32Type; NumType I32Type] --> []

  | MemoryInit x ->
    ignore (memory c (0l @@ e.at));
    ignore (data c x);
    [NumType I32Type; NumType I32Type; NumType I32Type] --> []

  | DataDrop x ->
    ignore (data c x);
    [] --> []

  | RefNull t ->
    check_heap_type c t e.at;
    [] --> [RefType (Nullable, t)]

  | RefIsNull ->
    let rt = peek_ref 0 s e.at in
    [RefType rt] --> [NumType I32Type]

  | RefAsNonNull ->
    let (_, t) = peek_ref 0 s e.at in
    [RefType (Nullable, t)] --> [RefType (NonNullable, t)]

  | RefFunc x ->
    let y = func_var c x in
    refer_func c x;
    [] --> [RefType (NonNullable, DefHeapType (SynVar y))]

  | Const v ->
    let t = NumType (type_num v.it) in
    [] --> [t]

  | Test testop ->
    let t = NumType (type_testop testop) in
    [t] --> [NumType I32Type]

  | Compare relop ->
    let t = NumType (type_relop relop) in
    [t; t] --> [NumType I32Type]

  | Unary unop ->
    check_unop unop e.at;
    let t = NumType (type_unop unop) in
    [t] --> [t]

  | Binary binop ->
    let t = NumType (type_binop binop) in
    [t; t] --> [t]

  | Convert cvtop ->
    let t1, t2 = type_cvtop e.at cvtop in
    [NumType t1] --> [NumType t2]

and check_seq (c : context) (s : infer_stack_type) (es : instr list)
  : infer_stack_type =
  match es with
  | [] ->
    s

  | _ ->
    let es', e = Lib.List.split_last es in
    let s' = check_seq c s es' in
    let {ins; outs} = check_instr c e s' in
    push c outs (pop c ins s' e.at)

and check_block (c : context) (es : instr list) (ft : func_type) at =
  let FuncType (ts1, ts2) = ft in
  let s = check_seq c (stack ts1) es in
  let s' = pop c (stack ts2) s at in
  require (snd s' = []) at
    ("type mismatch: block requires " ^ string_of_stack_type ts2 ^
     " but stack has " ^ string_of_stack_type (snd s))


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
  let FuncType (ts1, ts2) = func_type c ftype in
  List.iter (check_local c true) locals;
  let c' =
    { c with
      locals = ts1 @ List.map Source.it locals;
      results = ts2;
      labels = [ts2]
    }
  in check_block c' body (FuncType ([], ts2)) f.at


let is_const (c : context) (e : instr) =
  match e.it with
  | RefNull _
  | RefFunc _
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
  check_table_type c ttype tab.at

let check_memory (c : context) (mem : memory) =
  let {mtype} = mem.it in
  check_memory_type c mtype mem.at

let check_elem_mode (c : context) (t : ref_type) (mode : segment_mode) =
  match mode.it with
  | Passive -> ()
  | Active {index; offset} ->
    let TableType (_, et) = table c index in
    require (match_ref_type c.types [] t et) mode.at
      ("type mismatch: element segment's type " ^ string_of_ref_type t ^
       " does not match table's element type " ^ string_of_ref_type et);
    check_const c offset (NumType I32Type)
  | Declarative -> ()

let check_elem (c : context) (seg : elem_segment) =
  let {etype; einit; emode} = seg.it in
  check_ref_type c etype seg.at;
  List.iter (fun const -> check_const c const (RefType etype)) einit;
  check_elem_mode c etype emode

let check_data_mode (c : context) (mode : segment_mode) =
  match mode.it with
  | Passive -> ()
  | Active {index; offset} ->
    ignore (memory c index);
    check_const c offset (NumType I32Type)
  | Declarative -> assert false

let check_data (c : context) (seg : data_segment) =
  let {dinit; dmode} = seg.it in
  check_data_mode c dmode

let check_global (c : context) (glob : global) =
  let {gtype; ginit} = glob.it in
  check_global_type c gtype glob.at;
  let GlobalType (t, mut) = gtype in
  check_const c ginit t


(* Modules *)

let check_start (c : context) (start : idx option) =
  Lib.Option.app (fun x ->
    require (func c x = FuncType ([], [])) x.at
      "start function must not have parameters or results"
  ) start

let check_import (im : import) (c : context) : context =
  let {module_name = _; item_name = _; idesc} = im.it in
  match idesc.it with
  | FuncImport x ->
    ignore (func_type c x);
    {c with funcs = x.it :: c.funcs}
  | TableImport tt ->
    check_table_type c tt idesc.at;
    {c with tables = tt :: c.tables}
  | MemoryImport mt ->
    check_memory_type c mt idesc.at;
    {c with memories = mt :: c.memories}
  | GlobalImport gt ->
    check_global_type c gt idesc.at;
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
    { types; imports; tables; memories; globals; funcs; start; elems; datas;
      exports } = m.it
  in
  let c0 =
    List.fold_right check_import imports
      { empty_context with
        refs = Free.module_ ({m.it with funcs = []; start = None} @@ m.at);
        types = List.map (fun ty -> ty.it) types;
      }
  in
  let c1 =
    { c0 with
      funcs = c0.funcs @ List.map (fun f -> ignore (func_type c0 f.it.ftype); f.it.ftype.it) funcs;
      tables = c0.tables @ List.map (fun tab -> tab.it.ttype) tables;
      memories = c0.memories @ List.map (fun mem -> mem.it.mtype) memories;
      elems = List.map (fun elem -> elem.it.etype) elems;
      datas = List.map (fun _data -> ()) datas;
    }
  in
  let c =
    { c1 with globals = c1.globals @ List.map (fun g -> g.it.gtype) globals }
  in
  List.iter (check_type c1) types;
  List.iter (check_global c1) globals;
  List.iter (check_table c1) tables;
  List.iter (check_memory c1) memories;
  List.iter (check_elem c1) elems;
  List.iter (check_data c1) datas;
  List.iter (check_func c) funcs;
  check_start c start;
  ignore (List.fold_left (check_export c) NameSet.empty exports);
  require (List.length c.memories <= 1) m.at
    "multiple memories are not allowed (yet)"
