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
  types : ctx_type list;
  funcs : ctx_type list;
  tables : table_type list;
  memories : memory_type list;
  globals : global_type list;
  elems : ref_type list;
  datas : unit list;
  locals : local_type list;
  results : val_type list;
  labels : result_type list;
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
    error x.at ("unknown " ^ category ^ " " ^ I32.to_string_u x.it)

let type_ (c : context) x = lookup "type" c.types x
let func (c : context) x = lookup "function" c.funcs x
let table (c : context) x = lookup "table" c.tables x
let memory (c : context) x = lookup "memory" c.memories x
let global (c : context) x = lookup "global" c.globals x
let elem (c : context) x = lookup "elem segment" c.elems x
let data (c : context) x = lookup "data segment" c.datas x
let local (c : context) x = lookup "local" c.locals x
let label (c : context) x = lookup "label" c.labels x

let replace category list x y =
  try Lib.List32.replace list x.it y with Failure _ ->
    error x.at ("unknown " ^ category ^ " " ^ I32.to_string_u x.it)

let init_local (c : context) x =
  let LocalT (_init, t) = local c x in
  {c with locals = replace "local" c.locals x (LocalT (Set, t))}

let init_locals (c : context) xs =
  List.fold_left init_local c xs

let func_type (c : context) x =
  match expand_ctx_type (type_ c x) with
  | DefFuncT ft -> ft
  | _ -> error x.at ("non-function type " ^ I32.to_string_u x.it)

let struct_type (c : context) x =
  match expand_ctx_type (type_ c x) with
  | DefStructT st -> st
  | _ -> error x.at ("non-structure type " ^ I32.to_string_u x.it)

let array_type (c : context) x =
  match expand_ctx_type (type_ c x) with
  | DefArrayT at -> at
  | _ -> error x.at ("non-array type " ^ I32.to_string_u x.it)

let refer category (s : Free.Set.t) x =
  if not (Free.Set.mem x.it s) then
    error x.at
      ("undeclared " ^ category ^ " reference " ^ I32.to_string_u x.it)

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

let check_vec_type (c : context) (t : vec_type) at =
  ()

let check_heap_type (c : context) (t : heap_type) at =
  match t with
  | AnyHT | NoneHT | EqHT
  | I31HT | StructHT | ArrayHT -> ()
  | FuncHT | NoFuncHT -> ()
  | ExternHT | NoExternHT -> ()
  | DefHT (StatX x) -> ignore (type_ c (x @@ at))
  | DefHT _ -> assert false
  | BotHT -> ()

let check_ref_type (c : context) (t : ref_type) at =
  match t with
  | (_nul, ht) -> check_heap_type c ht at

let check_val_type (c : context) (t : val_type) at =
  match t with
  | NumT t' -> check_num_type c t' at
  | VecT t' -> check_vec_type c t' at
  | RefT t' -> check_ref_type c t' at
  | BotT -> assert false

let check_result_type (c : context) (ts : result_type) at =
  List.iter (fun t -> check_val_type c t at) ts

let check_storage_type (c : context) (st : storage_type) at =
  match st with
  | ValStorageT t -> check_val_type c t at
  | PackStorageT p -> assert Pack.(p = Pack8 || p = Pack16)

let check_field_type (c : context) (ft : field_type) at =
  let FieldT (_mut, st) = ft in
  check_storage_type c st at

let check_struct_type (c : context) (st : struct_type) at =
  let StructT fts = st in
  List.iter (fun ft -> check_field_type c ft at) fts

let check_array_type (c : context) (rt : array_type) at =
  let ArrayT ft = rt in
  check_field_type c ft at

let check_func_type (c : context) (ft : func_type) at =
  let FuncT (ts1, ts2) = ft in
  check_result_type c ts1 at;
  check_result_type c ts2 at

let check_table_type (c : context) (tt : table_type) at =
  let TableT (lim, t) = tt in
  check_limits lim 0xffff_ffffl at "table size must be at most 2^32-1";
  check_ref_type c t at

let check_memory_type (c : context) (mt : memory_type) at =
  let MemoryT lim = mt in
  check_limits lim 0x1_0000l at
    "memory size must be at most 65536 pages (4GiB)"

let check_global_type (c : context) (gt : global_type) at =
  let GlobalT (_mut, t) = gt in
  check_val_type c t at


let check_str_type (c : context) (st : str_type) at =
  match st with
  | DefStructT st -> check_struct_type c st at
  | DefArrayT rt -> check_array_type c rt at
  | DefFuncT ft -> check_func_type c ft at

let check_sub_type (c : context) (st : sub_type) x at =
  let SubT (xs, st) = st in
  check_str_type c st at;
  List.iter (fun xi ->
    let xi = as_stat_var xi in
    require (xi < x) at
      ("forward use of type " ^ I32.to_string_u xi ^  " in sub type definition");
    require (match_str_type c.types st (expand_ctx_type (type_ c (xi @@ at)))) at
      ("sub type " ^ I32.to_string_u x ^ " does not match super type " ^ I32.to_string_u xi)
  ) xs

let check_def_type (c : context) (dt : def_type) at : context =
  let x = Lib.List32.length c.types in
  match dt with
  | RecT sts ->
    let c' = {c with types = c.types @ ctx_types_of_def_type x dt} in
    ignore (List.fold_left (fun x st -> check_sub_type c' st x at; I32.add x 1l) x sts);
    c'

let check_type (c : context) (t : type_) : context =
  check_def_type c t.it t.at



(* Stack typing *)

(*
 * Note: The declarative typing rules are non-deterministic, that is, they
 * have the liberty to locally "guess" the right types implied by the context.
 * In the algorithmic formulation required here, stack types may hence pick
 * `BotT` as the principal choice for a locally unknown type.
 * Furthermore, an ellipses flag represents arbitrary sequences
 * of unknown types, in order to handle stack polymorphism algorithmically.
 *)

type ellipses = NoEllipses | Ellipses
type infer_result_type = ellipses * val_type list
type infer_func_type = {ins : infer_result_type; outs : infer_result_type}
type infer_instr_type = infer_func_type * idx list

let stack ts = (NoEllipses, ts)
let (-->) ts1 ts2 = {ins = NoEllipses, ts1; outs = NoEllipses, ts2}
let (-->...) ts1 ts2 = {ins = Ellipses, ts1; outs = Ellipses, ts2}

let check_stack (c : context) ts1 ts2 at =
  require
    (List.length ts1 = List.length ts2 &&
      List.for_all2 (match_val_type c.types) ts1 ts2) at
    ("type mismatch: instruction requires " ^ string_of_result_type ts2 ^
     " but stack has " ^ string_of_result_type ts1)

let pop c (ell1, ts1) (ell2, ts2) at =
  let n1 = List.length ts1 in
  let n2 = List.length ts2 in
  let n = min n1 n2 in
  let n3 = if ell2 = Ellipses then (n1 - n) else 0 in
  check_stack c (Lib.List.make n3 (BotT : val_type) @ Lib.List.drop (n2 - n) ts2) ts1 at;
  (ell2, if ell1 = Ellipses then [] else Lib.List.take (n2 - n) ts2)

let push c (ell1, ts1) (ell2, ts2) =
  assert (ell1 = NoEllipses || ts2 = []);
  (if ell1 = Ellipses || ell2 = Ellipses then Ellipses else NoEllipses),
  ts2 @ ts1

let peek i (ell, ts) : val_type =
  try List.nth (List.rev ts) i with Failure _ -> BotT

let peek_ref i (ell, ts) at : ref_type =
  match peek i (ell, ts) with
  | RefT rt -> rt
  | BotT -> (NoNull, BotHT)
  | t ->
    error at
      ("type mismatch: instruction requires reference type" ^
       " but stack has " ^ string_of_val_type t)


(* Type Synthesis *)

let type_num = Value.type_of_op
let type_vec = Value.type_of_vecop
let type_vec_lane = function
  | Value.V128 laneop -> V128.type_of_lane laneop

let type_cvtop at = function
  | Value.I32 cvtop ->
    let open I32Op in
    (match cvtop with
    | ExtendSI32 | ExtendUI32 -> error at "invalid conversion"
    | WrapI64 -> I64T
    | TruncSF32 | TruncUF32 | TruncSatSF32 | TruncSatUF32
    | ReinterpretFloat -> F32T
    | TruncSF64 | TruncUF64 | TruncSatSF64 | TruncSatUF64 -> F64T
    ), I32T
  | Value.I64 cvtop ->
    let open I64Op in
    (match cvtop with
    | ExtendSI32 | ExtendUI32 -> I32T
    | WrapI64 -> error at "invalid conversion"
    | TruncSF32 | TruncUF32 | TruncSatSF32 | TruncSatUF32 -> F32T
    | TruncSF64 | TruncUF64 | TruncSatSF64 | TruncSatUF64
    | ReinterpretFloat -> F64T
    ), I64T
  | Value.F32 cvtop ->
    let open F32Op in
    (match cvtop with
    | ConvertSI32 | ConvertUI32 | ReinterpretInt -> I32T
    | ConvertSI64 | ConvertUI64 -> I64T
    | PromoteF32 -> error at "invalid conversion"
    | DemoteF64 -> F64T
    ), F32T
  | Value.F64 cvtop ->
    let open F64Op in
    (match cvtop with
    | ConvertSI32 | ConvertUI32 -> I32T
    | ConvertSI64 | ConvertUI64 | ReinterpretInt -> I64T
    | PromoteF32 -> F32T
    | DemoteF64 -> error at "invalid conversion"
    ), F64T

let num_lanes = function
  | Value.V128 laneop -> V128.num_lanes laneop

let lane_extractop = function
  | Value.V128 extractop ->
    let open V128 in let open V128Op in
    match extractop with
    | I8x16 (Extract (i, _)) | I16x8 (Extract (i, _))
    | I32x4 (Extract (i, _)) | I64x2 (Extract (i, _))
    | F32x4 (Extract (i, _)) | F64x2 (Extract (i, _)) -> i

let lane_replaceop = function
  | Value.V128 replaceop ->
    let open V128 in let open V128Op in
    match replaceop with
    | I8x16 (Replace i) | I16x8 (Replace i)
    | I32x4 (Replace i) | I64x2 (Replace i)
    | F32x4 (Replace i) | F64x2 (Replace i) -> i

let type_externop op =
  match op with
  | Internalize -> ExternHT, AnyHT
  | Externalize -> AnyHT, ExternHT


(* Expressions *)

let check_pack sz t_sz at =
  require (Pack.packed_size sz < t_sz) at "invalid sign extension"

let check_unop unop at =
  match unop with
  | Value.I32 (IntOp.ExtendS sz) | Value.I64 (IntOp.ExtendS sz) ->
    check_pack sz (num_size (Value.type_of_op unop)) at
  | _ -> ()

let check_vec_binop binop at =
  match binop with
  | Value.(V128 (V128.I8x16 (V128Op.Shuffle is))) ->
    if List.exists ((<=) 32) is then
      error at "invalid lane index"
  | _ -> ()

let check_memop (c : context) (memop : ('t, 's) memop) ty_size get_sz at =
  let _mt = memory c (0l @@ at) in
  let size =
    match get_sz memop.pack with
    | None -> ty_size memop.ty
    | Some sz ->
      check_pack sz (ty_size memop.ty) at;
      Pack.packed_size sz
  in
  require (1 lsl memop.align <= size) at
    "alignment must not be larger than natural"


(*
 * Conventions:
 *   c  : context
 *   e  : instr
 *   es : instr list
 *   v  : value
 *   t  : val_type
 *   ts : result_type
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

let check_block_type (c : context) (bt : block_type) at : instr_type =
  match bt with
  | ValBlockType None -> InstrT ([], [], [])
  | ValBlockType (Some t) -> check_val_type c t at; InstrT ([], [t], [])
  | VarBlockType x ->
    let FuncT (ts1, ts2) = func_type c x in InstrT (ts1, ts2, [])

let rec check_instr (c : context) (e : instr) (s : infer_result_type) : infer_instr_type =
  match e.it with
  | Unreachable ->
    [] -->... [], []

  | Nop ->
    [] --> [], []

  | Drop ->
    [peek 0 s] --> [], []

  | Select None ->
    let t = peek 1 s in
    require (is_num_type t || is_vec_type t) e.at
      ("type mismatch: instruction requires numeric or vector type" ^
       " but stack has " ^ string_of_val_type t);
    [t; t; NumT I32T] --> [t], []

  | Select (Some ts) ->
    require (List.length ts = 1) e.at
      "invalid result arity other than 1 is not (yet) allowed";
    check_result_type c ts e.at;
    (ts @ ts @ [NumT I32T]) --> ts, []

  | Block (bt, es) ->
    let InstrT (ts1, ts2, xs) as it = check_block_type c bt e.at in
    check_block {c with labels = ts2 :: c.labels} es it e.at;
    ts1 --> ts2, List.map (fun x -> x @@ e.at) xs

  | Loop (bt, es) ->
    let InstrT (ts1, ts2, xs) as it = check_block_type c bt e.at in
    check_block {c with labels = ts1 :: c.labels} es it e.at;
    ts1 --> ts2, List.map (fun x -> x @@ e.at) xs

  | If (bt, es1, es2) ->
    let InstrT (ts1, ts2, xs) as it = check_block_type c bt e.at in
    check_block {c with labels = ts2 :: c.labels} es1 it e.at;
    check_block {c with labels = ts2 :: c.labels} es2 it e.at;
    (ts1 @ [NumT I32T]) --> ts2, List.map (fun x -> x @@ e.at) xs

  | Br x ->
    label c x -->... [], []

  | BrIf x ->
    (label c x @ [NumT I32T]) --> label c x, []

  | BrTable (xs, x) ->
    let n = List.length (label c x) in
    let ts = List.init n (fun i -> peek (n - i) s) in
    check_stack c ts (label c x) x.at;
    List.iter (fun x' -> check_stack c ts (label c x') x'.at) xs;
    (ts @ [NumT I32T]) -->... [], []

  | BrOnNull x ->
    let (_nul, ht) = peek_ref 0 s e.at in
    (label c x @ [RefT (Null, ht)]) --> (label c x @ [RefT (NoNull, ht)]), []

  | BrOnNonNull x ->
    let (nul, ht) = peek_ref 0 s e.at in
    let t' = RefT (NoNull, ht) in
    require (label c x <> []) e.at
      ("type mismatch: instruction requires type " ^ string_of_val_type t' ^
       " but label has " ^ string_of_result_type (label c x));
    let ts0, t1 = Lib.List.split_last (label c x) in
    require (match_val_type c.types t' t1) e.at
      ("type mismatch: instruction requires type " ^ string_of_val_type t' ^
       " but label has " ^ string_of_result_type (label c x));
    (ts0 @ [RefT (nul, ht)]) --> ts0, []

  | BrOnCast (x, rt) ->
    let (nul, ht) = rt in
    let (nul', ht') as rt' = peek_ref 0 s e.at in
    let tht = top_of_heap_type c.types ht in
    require
      (match_ref_type c.types rt' (Null, tht)) e.at
      ("type mismatch: instruction requires type " ^
        string_of_ref_type (Null, tht) ^
       " but stack has " ^ string_of_ref_type rt');
    require (label c x <> []) e.at
      ("type mismatch: instruction requires type " ^ string_of_ref_type rt ^
       " but label has " ^ string_of_result_type (label c x));
    let ts0, t1 = Lib.List.split_last (label c x) in
    require (match_val_type c.types (RefT rt) t1) e.at
      ("type mismatch: instruction requires type " ^ string_of_ref_type rt ^
       " but label has " ^ string_of_result_type (label c x));
    (ts0 @ [RefT rt']) --> (ts0 @ [RefT (inv_null nul, ht')]), []

  | BrOnCastFail (x, rt) ->
    let (nul, ht) = rt in
    let (nul', ht') as rt' = peek_ref 0 s e.at in
    let tht = top_of_heap_type c.types ht in
    require
      (match_ref_type c.types rt' (Null, tht)) e.at
      ("type mismatch: instruction requires type " ^
        string_of_ref_type (Null, tht) ^
       " but stack has " ^ string_of_ref_type rt');
    require (label c x <> []) e.at
      ("type mismatch: instruction requires type " ^ string_of_ref_type rt' ^
       " but label has " ^ string_of_result_type (label c x));
    let ts0, t1 = Lib.List.split_last (label c x) in
    require (match_val_type c.types (RefT (inv_null nul, ht')) t1) e.at
      ("type mismatch: instruction requires type " ^ string_of_ref_type (inv_null nul, ht') ^
       " but label has " ^ string_of_result_type (label c x));
    (ts0 @ [RefT rt']) --> (ts0 @ [RefT rt]), []

  | Return ->
    c.results -->... [], []

  | Call x ->
    let FuncT (ts1, ts2) = as_func_str_type (expand_ctx_type (func c x)) in
    ts1 --> ts2, []

  | CallRef x ->
    let FuncT (ts1, ts2) = func_type c x in
    (ts1 @ [RefT (Null, DefHT (StatX x.it))]) --> ts2, []

  | CallIndirect (x, y) ->
    let TableT (lim, t) = table c x in
    let FuncT (ts1, ts2) = func_type c y in
    require (match_ref_type c.types t (Null, FuncHT)) x.at
      ("type mismatch: instruction requires table of function type" ^
       " but table has element type " ^ string_of_ref_type t);
    (ts1 @ [NumT I32T]) --> ts2, []

  | ReturnCallRef x ->
    let FuncT (ts1, ts2) = func_type c x in
    require (match_result_type c.types ts2 c.results) e.at
      ("type mismatch: current function requires result type " ^
       string_of_result_type c.results ^
       " but callee returns " ^ string_of_result_type ts2);
    (ts1 @ [RefT (Null, DefHT (StatX x.it))]) -->... [], []

  | LocalGet x ->
    let LocalT (init, t) = local c x in
    require (init = Set) x.at "uninitialized local";
    [] --> [t], []

  | LocalSet x ->
    let LocalT (_init, t) = local c x in
    [t] --> [], [x]

  | LocalTee x ->
    let LocalT (_init, t) = local c x in
    [t] --> [t], [x]

  | GlobalGet x ->
    let GlobalT (_mut, t) = global c x in
    [] --> [t], []

  | GlobalSet x ->
    let GlobalT (mut, t) = global c x in
    require (mut = Var) x.at "immutable global";
    [t] --> [], []

  | TableGet x ->
    let TableT (_lim, rt) = table c x in
    [NumT I32T] --> [RefT rt], []

  | TableSet x ->
    let TableT (_lim, rt) = table c x in
    [NumT I32T; RefT rt] --> [], []

  | TableSize x ->
    let _tt = table c x in
    [] --> [NumT I32T], []

  | TableGrow x ->
    let TableT (_lim, rt) = table c x in
    [RefT rt; NumT I32T] --> [NumT I32T], []

  | TableFill x ->
    let TableT (_lim, rt) = table c x in
    [NumT I32T; RefT rt; NumT I32T] --> [], []

  | TableCopy (x, y) ->
    let TableT (_lim1, t1) = table c x in
    let TableT (_lim2, t2) = table c y in
    require (match_ref_type c.types t2 t1) x.at
      ("type mismatch: source element type " ^ string_of_ref_type t1 ^
       " does not match destination element type " ^ string_of_ref_type t2);
    [NumT I32T; NumT I32T; NumT I32T] --> [], []

  | TableInit (x, y) ->
    let TableT (_lim1, t1) = table c x in
    let t2 = elem c y in
    require (match_ref_type c.types t2 t1) x.at
      ("type mismatch: element segment's type " ^ string_of_ref_type t1 ^
       " does not match table's element type " ^ string_of_ref_type t2);
    [NumT I32T; NumT I32T; NumT I32T] --> [], []

  | ElemDrop x ->
    ignore (elem c x);
    [] --> [], []

  | Load memop ->
    check_memop c memop num_size (Lib.Option.map fst) e.at;
    [NumT I32T] --> [NumT memop.ty], []

  | Store memop ->
    check_memop c memop num_size (fun sz -> sz) e.at;
    [NumT I32T; NumT memop.ty] --> [], []

  | VecLoad memop ->
    check_memop c memop vec_size (Lib.Option.map fst) e.at;
    [NumT I32T] --> [VecT memop.ty], []

  | VecStore memop ->
    check_memop c memop vec_size (fun _ -> None) e.at;
    [NumT I32T; VecT memop.ty] --> [], []

  | VecLoadLane (memop, i) ->
    check_memop c memop vec_size (fun sz -> Some sz) e.at;
    require (i < vec_size memop.ty / Pack.packed_size memop.pack) e.at
      "invalid lane index";
    [NumT I32T; VecT memop.ty] -->  [VecT memop.ty], []

  | VecStoreLane (memop, i) ->
    check_memop c memop vec_size (fun sz -> Some sz) e.at;
    require (i < vec_size memop.ty / Pack.packed_size memop.pack) e.at
      "invalid lane index";
    [NumT I32T; VecT memop.ty] -->  [], []

  | MemorySize ->
    let _mt = memory c (0l @@ e.at) in
    [] --> [NumT I32T], []

  | MemoryGrow ->
    let _mt = memory c (0l @@ e.at) in
    [NumT I32T] --> [NumT I32T], []

  | MemoryFill ->
    let _mt = memory c (0l @@ e.at) in
    [NumT I32T; NumT I32T; NumT I32T] --> [], []

  | MemoryCopy ->
    let _mt = memory c (0l @@ e.at) in
    [NumT I32T; NumT I32T; NumT I32T] --> [], []

  | MemoryInit x ->
    let _mt = memory c (0l @@ e.at) in
    let () = data c x in
    [NumT I32T; NumT I32T; NumT I32T] --> [], []

  | DataDrop x ->
    let () = data c x in
    [] --> [], []

  | RefNull ht ->
    check_heap_type c ht e.at;
    [] --> [RefT (Null, ht)], []

  | RefFunc x ->
    let y = Lib.Option.force (Lib.List32.index_of (func c x) c.types) in
    refer_func c x;
    [] --> [RefT (NoNull, DefHT (StatX y))], []

  | RefIsNull ->
    let (_, ht) = peek_ref 0 s e.at in
    [RefT (Null, ht)] --> [NumT I32T], []

  | RefAsNonNull ->
    let (_, ht) = peek_ref 0 s e.at in
    [RefT (Null, ht)] --> [RefT (NoNull, ht)], []

  | RefTest rt ->
    check_ref_type c rt e.at;
    let (_nul, ht) = rt in
    [RefT (Null, top_of_heap_type c.types ht)] --> [NumT I32T], []

  | RefCast rt ->
    check_ref_type c rt e.at;
    let (nul, ht) = rt in
    [RefT (Null, top_of_heap_type c.types ht)] --> [RefT (nul, ht)], []

  | RefEq ->
    [RefT (Null, EqHT); RefT (Null, EqHT)] --> [NumT I32T], []

  | I31New ->
    [NumT I32T] --> [RefT (NoNull, I31HT)], []

  | I31Get ext ->
    [RefT (Null, I31HT)] --> [NumT I32T], []

  | StructNew (x, initop) ->
    let StructT fts = struct_type c x in
    require
      ( initop = Explicit || List.for_all (fun ft ->
          defaultable (unpacked_field_type ft)) fts ) x.at
      "field type is not defaultable";
    let ts = if initop = Implicit then [] else List.map unpacked_field_type fts in
    ts --> [RefT (NoNull, DefHT (StatX x.it))], []

  | StructGet (x, y, exto) ->
    let StructT fts = struct_type c x in
    require (y.it < Lib.List32.length fts) y.at
      ("unknown field " ^ I32.to_string_u y.it);
    let FieldT (_mut, st) = Lib.List32.nth fts y.it in
    require ((exto <> None) == is_packed_storage_type st) y.at
      ("field is " ^ (if exto = None then "packed" else "unpacked"));
    let t = unpacked_storage_type st in
    [RefT (Null, DefHT (StatX x.it))] --> [t], []

  | StructSet (x, y) ->
    let StructT fts = struct_type c x in
    require (y.it < Lib.List32.length fts) y.at
      ("unknown field " ^ I32.to_string_u y.it);
    let FieldT (mut, st) = Lib.List32.nth fts y.it in
    require (mut == Var) y.at "field is immutable";
    let t = unpacked_storage_type st in
    [RefT (Null, DefHT (StatX x.it)); t] --> [], []

  | ArrayNew (x, initop) ->
    let ArrayT ft = array_type c x in
    require
      (initop = Explicit || defaultable (unpacked_field_type ft)) x.at
      "array type is not defaultable";
    let ts = if initop = Implicit then [] else [unpacked_field_type ft] in
    (ts @ [NumT I32T]) --> [RefT (NoNull, DefHT (StatX x.it))], []

  | ArrayNewFixed (x, n) ->
    let ArrayT ft = array_type c x in
    let ts = Lib.List32.make n (unpacked_field_type ft) in
    ts --> [RefT (NoNull, DefHT (StatX x.it))], []

  | ArrayNewElem (x, y) ->
    let ArrayT ft = array_type c x in
    let rt = elem c y in
    require (match_val_type c.types (RefT rt) (unpacked_field_type ft)) x.at
      ("type mismatch: element segment's type " ^ string_of_ref_type rt ^
       " does not match array's field type " ^ string_of_field_type ft);
    [NumT I32T; NumT I32T] --> [RefT (NoNull, DefHT (StatX x.it))], []

  | ArrayNewData (x, y) ->
    let ArrayT ft = array_type c x in
    let () = data c y in
    let t = unpacked_field_type ft in
    require (is_num_type t || is_vec_type t) x.at
      "array type is not numeric or vector";
    [NumT I32T; NumT I32T] --> [RefT (NoNull, DefHT (StatX x.it))], []

  | ArrayGet (x, exto) ->
    let ArrayT (FieldT (_mut, st)) = array_type c x in
    require ((exto <> None) == is_packed_storage_type st) e.at
      ("array is " ^ (if exto = None then "packed" else "unpacked"));
    let t = unpacked_storage_type st in
    [RefT (Null, DefHT (StatX x.it)); NumT I32T] --> [t], []

  | ArraySet x ->
    let ArrayT (FieldT (mut, st)) = array_type c x in
    require (mut == Var) e.at "array is immutable";
    let t = unpacked_storage_type st in
    [RefT (Null, DefHT (StatX x.it)); NumT I32T; t] --> [], []

  | ArrayLen ->
    [RefT (Null, ArrayHT)] --> [NumT I32T], []

  | ExternConvert op ->
    let ht1, ht2 = type_externop op in
    let (nul, _ht) as rt = peek_ref 0 s e.at in
    [RefT (nul, ht1)] --> [RefT (nul, ht2)], []

  | Const v ->
    let t = NumT (type_num v.it) in
    [] --> [t], []

  | Test testop ->
    let t = NumT (type_num testop) in
    [t] --> [NumT I32T], []

  | Compare relop ->
    let t = NumT (type_num relop) in
    [t; t] --> [NumT I32T], []

  | Unary unop ->
    check_unop unop e.at;
    let t = NumT (type_num unop) in
    [t] --> [t], []

  | Binary binop ->
    let t = NumT (type_num binop) in
    [t; t] --> [t], []

  | Convert cvtop ->
    let t1, t2 = type_cvtop e.at cvtop in
    [NumT t1] --> [NumT t2], []

  | VecConst v ->
    let t = VecT (type_vec v.it) in
    [] --> [t], []

  | VecTest testop ->
    let t = VecT (type_vec testop) in
    [t] --> [NumT I32T], []

  | VecUnary unop ->
    let t = VecT (type_vec unop) in
    [t] --> [t], []

  | VecBinary binop ->
    check_vec_binop binop e.at;
    let t = VecT (type_vec binop) in
    [t; t] --> [t], []

  | VecCompare relop ->
    let t = VecT (type_vec relop) in
    [t; t] --> [t], []

  | VecConvert cvtop ->
    let t = VecT (type_vec cvtop) in
    [t] --> [t], []

  | VecShift shiftop ->
    let t = VecT (type_vec shiftop) in
    [t; NumT I32T] --> [t], []

  | VecBitmask bitmaskop ->
    let t = VecT (type_vec bitmaskop) in
    [t] --> [NumT I32T], []

  | VecTestBits vtestop ->
    let t = VecT (type_vec vtestop) in
    [t] --> [NumT I32T], []

  | VecUnaryBits vunop ->
    let t = VecT (type_vec vunop) in
    [t] --> [t], []

  | VecBinaryBits vbinop ->
    let t = VecT (type_vec vbinop) in
    [t; t] --> [t], []

  | VecTernaryBits vternop ->
    let t = VecT (type_vec vternop) in
    [t; t; t] --> [t], []

  | VecSplat splatop ->
    let t1 = NumT (type_vec_lane splatop) in
    let t2 = VecT (type_vec splatop) in
    [t1] --> [t2], []

  | VecExtract extractop ->
    let t1 = VecT (type_vec extractop) in
    let t2 = NumT (type_vec_lane extractop) in
    require (lane_extractop extractop < num_lanes extractop) e.at
      "invalid lane index";
    [t1] --> [t2], []

  | VecReplace replaceop ->
    let t1 = VecT (type_vec replaceop) in
    let t2 = NumT (type_vec_lane replaceop) in
    require (lane_replaceop replaceop < num_lanes replaceop) e.at
      "invalid lane index";
    [t1; t2] --> [t1], []

and check_seq (c : context) (s : infer_result_type) (es : instr list)
  : infer_result_type * idx list =
  match es with
  | [] ->
    s, []

  | e::es' ->
    let {ins; outs}, xs = check_instr c e s in
    check_seq (init_locals c xs) (push c outs (pop c ins s e.at)) es'

and check_block (c : context) (es : instr list) (it : instr_type) at =
  let InstrT (ts1, ts2, _xs) = it in
  let s, xs' = check_seq c (stack ts1) es in
  let s' = pop c (stack ts2) s at in
  require (snd s' = []) at
    ("type mismatch: block requires " ^ string_of_result_type ts2 ^
     " but stack has " ^ string_of_result_type (snd s))


(* Functions & Constants *)

(*
 * Conventions:
 *   c : context
 *   m : module_
 *   f : func
 *   e : instr
 *   v : value
 *   t : val_type
 *   s : func_type
 *   x : variable
 *)

let check_local (c : context) (loc : local) : local_type =
  check_val_type c loc.it.ltype loc.at;
  let init = if defaultable loc.it.ltype then Set else Unset in
  LocalT (init, loc.it.ltype)

let check_func (c : context) (f : func) =
  let {ftype; locals; body} = f.it in
  let FuncT (ts1, ts2) = func_type c ftype in
  let lts = List.map (check_local c) locals in
  let c' =
    { c with
      locals = List.map (fun t -> LocalT (Set, t)) ts1 @ lts;
      results = ts2;
      labels = [ts2]
    }
  in check_block c' body (InstrT ([], ts2, [])) f.at


let is_const (c : context) (e : instr) =
  match e.it with
  | Const _ | VecConst _
  | RefNull _ | RefFunc _
  | I31New | StructNew _ | ArrayNew _ | ArrayNewFixed _ -> true
  | GlobalGet x -> let GlobalT (mut, _t) = global c x in mut = Cons
  | _ -> false

let check_const (c : context) (const : const) (t : val_type) =
  require (List.for_all (is_const c) const.it) const.at
    "constant expression required";
  check_block c const.it (InstrT ([], [t], [])) const.at


(* Tables, Memories, & Globals *)

let check_table (c : context) (tab : table) =
  let {ttype; tinit} = tab.it in
  check_table_type c ttype tab.at;
  let TableT (_lim, rt) = ttype in
  check_const c tinit (RefT rt)

let check_memory (c : context) (mem : memory) =
  let {mtype} = mem.it in
  check_memory_type c mtype mem.at

let check_elem_mode (c : context) (t : ref_type) (mode : segment_mode) =
  match mode.it with
  | Passive -> ()
  | Active {index; offset} ->
    let TableT (_lim, et) = table c index in
    require (match_ref_type c.types t et) mode.at
      ("type mismatch: element segment's type " ^ string_of_ref_type t ^
       " does not match table's element type " ^ string_of_ref_type et);
    check_const c offset (NumT I32T)
  | Declarative -> ()

let check_elem (c : context) (seg : elem_segment) =
  let {etype; einit; emode} = seg.it in
  check_ref_type c etype seg.at;
  List.iter (fun const -> check_const c const (RefT etype)) einit;
  check_elem_mode c etype emode

let check_data_mode (c : context) (mode : segment_mode) =
  match mode.it with
  | Passive -> ()
  | Active {index; offset} ->
    ignore (memory c index);
    check_const c offset (NumT I32T)
  | Declarative -> assert false

let check_data (c : context) (seg : data_segment) =
  let {dinit; dmode} = seg.it in
  check_data_mode c dmode

let check_global (c : context) (glob : global) : context =
  let {gtype; ginit} = glob.it in
  check_global_type c gtype glob.at;
  let GlobalT (_mut, t) = gtype in
  check_const c ginit t;
  { c with globals = c.globals @ [gtype] }


(* Modules *)

let check_start (c : context) (start : start) =
  let {sfunc} = start.it in
  let ft = as_func_str_type (expand_ctx_type (func c sfunc)) in
  require (ft = FuncT ([], [])) start.at
    "start function must not have parameters or results"

let check_import (c : context) (im : import) : context =
  let {module_name = _; item_name = _; idesc} = im.it in
  match idesc.it with
  | FuncImport x ->
    let _ = func_type c x in
    {c with funcs = c.funcs @ [type_ c x]}
  | TableImport tt ->
    check_table_type c tt idesc.at;
    {c with tables = c.tables @ [tt]}
  | MemoryImport mt ->
    check_memory_type c mt idesc.at;
    {c with memories = c.memories @ [mt]}
  | GlobalImport gt ->
    check_global_type c gt idesc.at;
    {c with globals = c.globals @ [gt]}

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
  let c0 = List.fold_left check_type empty_context types in
  let c1 = List.fold_left check_import c0 imports in
  let c2 =
    { c1 with
      funcs = c1.funcs @ List.map (fun f -> type_ c1 f.it.ftype) funcs;
      tables = c1.tables @ List.map (fun tab -> tab.it.ttype) tables;
      memories = c1.memories @ List.map (fun mem -> mem.it.mtype) memories;
      refs = Free.module_ ({m.it with funcs = []; start = None} @@ m.at);
    }
  in
  let c =
    { (List.fold_left check_global c2 globals) with
      elems = List.map (fun elem -> elem.it.etype) elems;
      datas = List.map (fun _data -> ()) datas;
    }
  in
  List.iter (check_table c) tables;
  List.iter (check_memory c) memories;
  List.iter (check_elem c) elems;
  List.iter (check_data c) datas;
  List.iter (check_func c) funcs;
  Lib.Option.app (check_start c) start;
  ignore (List.fold_left (check_export c) NameSet.empty exports);
  require (List.length c.memories <= 1) m.at
    "multiple memories are not allowed (yet)"
