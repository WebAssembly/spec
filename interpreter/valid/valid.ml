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
  funcs : def_type list;
  tables : table_type list;
  memories : memory_type list;
  tags : tag_type list;
  globals : global_type list;
  elems : ref_type list;
  datas : unit list;
  locals : local_type list;
  results : val_type list;
  labels : result_type list;
  refs : Free.t;
}

let empty_context =
  { types = []; funcs = []; globals = []; tables = [];
    memories = []; tags = []; elems = []; datas = [];
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
let tag (c : context) x = lookup "tag" c.tags x
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
  match expand_def_type (type_ c x) with
  | DefFuncT ft -> ft
  | _ -> error x.at ("non-function type " ^ I32.to_string_u x.it)

let struct_type (c : context) x =
  match expand_def_type (type_ c x) with
  | DefStructT st -> st
  | _ -> error x.at ("non-structure type " ^ I32.to_string_u x.it)

let array_type (c : context) x =
  match expand_def_type (type_ c x) with
  | DefArrayT at -> at
  | _ -> error x.at ("non-array type " ^ I32.to_string_u x.it)

let refer category (s : Free.Set.t) x =
  if not (Free.Set.mem x.it s) then
    error x.at
      ("undeclared " ^ category ^ " reference " ^ I32.to_string_u x.it)

let refer_func (c : context) x = refer "function" c.refs.Free.funcs x


(* Types *)

let check_limits le_u {min; max} range at msg =
  require (le_u min range) at msg;
  match max with
  | None -> ()
  | Some max ->
    require (le_u max range) at msg;
    require (le_u min max) at
      "size minimum must not be greater than maximum"

let check_num_type (c : context) (t : num_type) at =
  ()

let check_vec_type (c : context) (t : vec_type) at =
  ()

let check_heap_type (c : context) (t : heap_type) at =
  match t with
  | AnyHT | NoneHT | EqHT | I31HT | StructHT | ArrayHT
  | FuncHT | NoFuncHT
  | ExnHT | NoExnHT
  | ExternHT | NoExternHT -> ()
  | VarHT (StatX x) -> let _dt = type_ c (x @@ at) in ()
  | VarHT (RecX _) | DefHT _ -> assert false
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
  match ft with
  | FieldT (_mut, st) -> check_storage_type c st at

let check_struct_type (c : context) (st : struct_type) at =
  match st with
  | StructT fts -> List.iter (fun ft -> check_field_type c ft at) fts

let check_array_type (c : context) (rt : array_type) at =
  match rt with
  | ArrayT ft -> check_field_type c ft at

let check_func_type (c : context) (ft : func_type) at =
  let FuncT (ts1, ts2) = ft in
  check_result_type c ts1 at;
  check_result_type c ts2 at

let check_table_type (c : context) (tt : table_type) at =
  let TableT (lim, it, t) = tt in
  check_ref_type c t at;
  match it with
  | I64IndexType ->
    check_limits I64.le_u lim 0xffff_ffff_ffff_ffffL at
      "table size must be at most 2^64-1"
  | I32IndexType ->
    check_limits I64.le_u lim 0xffff_ffffL at
      "table size must be at most 2^32-1"

let check_memory_type (c : context) (mt : memory_type) at =
  let MemoryT (lim, it) = mt in
  match it with
  | I32IndexType ->
    check_limits I64.le_u lim 0x1_0000L at
      "memory size must be at most 65536 pages (4GiB)"
  | I64IndexType ->
    check_limits I64.le_u lim 0x1_0000_0000_0000L at
      "memory size must be at most 48 bits of pages"

let check_global_type (c : context) (gt : global_type) at =
  let GlobalT (_mut, t) = gt in
  check_val_type c t at

let check_str_type (c : context) (st : str_type) at =
  match st with
  | DefStructT st -> check_struct_type c st at
  | DefArrayT rt -> check_array_type c rt at
  | DefFuncT ft -> check_func_type c ft at

let check_sub_type (c : context) (sut : sub_type) at =
  let SubT (_fin, hts, st) = sut in
  List.iter (fun ht -> check_heap_type c ht at) hts;
  check_str_type c st at

let check_sub_type_sub (c : context) (sut : sub_type) x at =
  let SubT (_fin, hts, st) = sut in
  List.iter (fun hti ->
    let xi = match hti with VarHT (StatX xi) -> xi | _ -> assert false in
    let SubT (fini, _, sti) = unroll_def_type (type_ c (xi @@ at)) in
    require (xi < x) at ("forward use of type " ^ I32.to_string_u xi ^
      " in sub type definition");
    require (fini = NoFinal) at ("sub type " ^ I32.to_string_u x ^
      " has final super type " ^ I32.to_string_u xi);
    require (match_str_type c.types st sti) at ("sub type " ^ I32.to_string_u x ^
      " does not match super type " ^ I32.to_string_u xi)
  ) hts

let check_rec_type (c : context) (rt : rec_type) at : context =
  let RecT sts = rt in
  let x = Lib.List32.length c.types in
  let c' = {c with types = c.types @ roll_def_types x rt} in
  List.iter (fun st -> check_sub_type c' st at) sts;
  Lib.List32.iteri
    (fun i st -> check_sub_type_sub c' st (Int32.add x i) at) sts;
  c'

let check_type (c : context) (t : type_) : context =
  check_rec_type c t.it t.at


let diff_ref_type (nul1, ht1) (nul2, ht2) =
  match nul2 with
  | Null -> (NoNull, ht1)
  | NoNull -> (nul1, ht1)


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

let match_resulttype s1 s2 (c : context) ts1 ts2 at =
  require
    ( List.length ts1 = List.length ts2 &&
      List.for_all2 (match_val_type c.types) ts1 ts2 ) at
    ("type mismatch: " ^ s2 ^ " requires " ^ string_of_result_type ts2 ^
     " but " ^ s1 ^ " has " ^ string_of_result_type ts1)

let match_stack (c : context) ts1 ts2 at =
  match_resulttype "stack" "instruction" c ts1 ts2 at

let pop c (ell1, ts1) (ell2, ts2) at =
  let n1 = List.length ts1 in
  let n2 = List.length ts2 in
  let n = min n1 n2 in
  let n3 = if ell2 = Ellipses then (n1 - n) else 0 in
  match_stack c (Lib.List.make n3 (BotT : val_type) @ Lib.List.drop (n2 - n) ts2) ts1 at;
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
  let size =
    match get_sz memop.pack with
    | None -> ty_size memop.ty
    | Some sz ->
      check_pack sz (ty_size memop.ty) at;
      Pack.packed_size sz
  in
  require (1 lsl memop.align >= 1 && 1 lsl memop.align <= size) at
    "alignment must not be larger than natural";
  let MemoryT (_lim, it) = memory c (0l @@ at) in
  if it = I32IndexType then
    require (I64.lt_u memop.offset 0x1_0000_0000L) at
      "offset out of range";
  memop.ty


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
    match_stack c ts (label c x) x.at;
    List.iter (fun x' -> match_stack c ts (label c x') x'.at) xs;
    (ts @ [NumT I32T]) -->... [], []

  | BrOnNull x ->
    let (_nul, ht) = peek_ref 0 s e.at in
    (label c x @ [RefT (Null, ht)]) --> (label c x @ [RefT (NoNull, ht)]), []

  | BrOnNonNull x ->
    let (_nul, ht) = peek_ref 0 s e.at in
    let t' = RefT (NoNull, ht) in
    require (label c x <> []) e.at
      ("type mismatch: instruction requires type " ^ string_of_val_type t' ^
       " but label has " ^ string_of_result_type (label c x));
    let ts0, t1 = Lib.List.split_last (label c x) in
    require (match_val_type c.types t' t1) e.at
      ("type mismatch: instruction requires type " ^ string_of_val_type t' ^
       " but label has " ^ string_of_result_type (label c x));
    (ts0 @ [RefT (Null, ht)]) --> ts0, []

  | BrOnCast (x, rt1, rt2) ->
    check_ref_type c rt1 e.at;
    check_ref_type c rt2 e.at;
    require
      (match_ref_type c.types rt2 rt1) e.at
      ("type mismatch on cast: type " ^ string_of_ref_type rt2 ^
       " does not match " ^ string_of_ref_type rt1);
    require (label c x <> []) e.at
      ("type mismatch: instruction requires type " ^ string_of_ref_type rt2 ^
       " but label has " ^ string_of_result_type (label c x));
    let ts0, t1 = Lib.List.split_last (label c x) in
    require (match_val_type c.types (RefT rt2) t1) e.at
      ("type mismatch: instruction requires type " ^ string_of_ref_type rt2 ^
       " but label has " ^ string_of_result_type (label c x));
    (ts0 @ [RefT rt1]) --> (ts0 @ [RefT (diff_ref_type rt1 rt2)]), []

  | BrOnCastFail (x, rt1, rt2) ->
    check_ref_type c rt1 e.at;
    check_ref_type c rt2 e.at;
    let rt1' = diff_ref_type rt1 rt2 in
    require
      (match_ref_type c.types rt2 rt1) e.at
      ("type mismatch on cast: type " ^ string_of_ref_type rt2 ^
       " does not match " ^ string_of_ref_type rt1);
    require (label c x <> []) e.at
      ("type mismatch: instruction requires type " ^ string_of_ref_type rt1' ^
       " but label has " ^ string_of_result_type (label c x));
    let ts0, t1 = Lib.List.split_last (label c x) in
    require (match_val_type c.types (RefT rt1') t1) e.at
      ("type mismatch: instruction requires type " ^ string_of_ref_type rt1' ^
       " but label has " ^ string_of_result_type (label c x));
    (ts0 @ [RefT rt1]) --> (ts0 @ [RefT rt2]), []

  | Return ->
    c.results -->... [], []

  | Call x ->
    let FuncT (ts1, ts2) = as_func_str_type (expand_def_type (func c x)) in
    ts1 --> ts2, []

  | CallRef x ->
    let FuncT (ts1, ts2) = func_type c x in
    (ts1 @ [RefT (Null, DefHT (type_ c x))]) --> ts2, []

  | CallIndirect (x, y) ->
    let TableT (lim, it, t) = table c x in
    let FuncT (ts1, ts2) = func_type c y in
    require (match_ref_type c.types t (Null, FuncHT)) x.at
      ("type mismatch: instruction requires table of function type" ^
       " but table has element type " ^ string_of_ref_type t);
    (ts1 @ [value_type_of_index_type it]) --> ts2, []

  | ReturnCall x ->
    let FuncT (ts1, ts2) = as_func_str_type (expand_def_type (func c x)) in
    require (match_result_type c.types ts2 c.results) e.at
      ("type mismatch: current function requires result type " ^
       string_of_result_type c.results ^
       " but callee returns " ^ string_of_result_type ts2);
    ts1 -->... [], []

  | ReturnCallRef x ->
    let FuncT (ts1, ts2) = func_type c x in
    require (match_result_type c.types ts2 c.results) e.at
      ("type mismatch: current function requires result type " ^
       string_of_result_type c.results ^
       " but callee returns " ^ string_of_result_type ts2);
    (ts1 @ [RefT (Null, DefHT (type_ c x))]) -->... [], []

  | ReturnCallIndirect (x, y) ->
    let TableT (_lim, it, t) = table c x in
    let FuncT (ts1, ts2) = func_type c y in
    require (match_result_type c.types ts2 c.results) e.at
      ("type mismatch: current function requires result type " ^
       string_of_result_type c.results ^
       " but callee returns " ^ string_of_result_type ts2);
    (ts1 @ [value_type_of_index_type it]) -->... [], []

  | Throw x ->
    let TagT dt = tag c x in
    let FuncT (ts1, ts2) = as_func_str_type (expand_def_type dt) in
    ts1 -->... [], []

  | ThrowRef ->
    [RefT (Null, ExnHT)] -->... [], []

  | TryTable (bt, cs, es) ->
    let InstrT (ts1, ts2, xs) as it = check_block_type c bt e.at in
    let c' = {c with labels = ts2 :: c.labels} in
    List.iter (fun ct -> check_catch c ct ts2 e.at) cs;
    check_block c' es it e.at;
    ts1 --> ts2, List.map (fun x -> x @@ e.at) xs

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
    let TableT (_lim, it, rt) = table c x in
    [value_type_of_index_type it] --> [RefT rt], []

  | TableSet x ->
    let TableT (_lim, it, rt) = table c x in
    [value_type_of_index_type it; RefT rt] --> [], []

  | TableSize x ->
    let TableT (_lim, it, _rt) = table c x in
    [] --> [value_type_of_index_type it], []

  | TableGrow x ->
    let TableT (_lim, it, rt) = table c x in
    [RefT rt; value_type_of_index_type it] --> [value_type_of_index_type it], []

  | TableFill x ->
    let TableT (_lim, it, rt) = table c x in
    [value_type_of_index_type it; RefT rt; value_type_of_index_type it] --> [], []

  | TableCopy (x, y) ->
    let TableT (_lim1, it1, t1) = table c x in
    let TableT (_lim2, it2, t2) = table c y in
    let it_min = min it1 it2 in
    require (match_ref_type c.types t2 t1) x.at
      ("type mismatch: source element type " ^ string_of_ref_type t1 ^
       " does not match destination element type " ^ string_of_ref_type t2);
    [value_type_of_index_type it1; value_type_of_index_type it2; value_type_of_index_type it_min] --> [], []

  | TableInit (x, y) ->
    let TableT (_lim1, it, t1) = table c x in
    let t2 = elem c y in
    require (match_ref_type c.types t2 t1) x.at
      ("type mismatch: element segment's type " ^ string_of_ref_type t1 ^
       " does not match table's element type " ^ string_of_ref_type t2);
    [value_type_of_index_type it; NumT I32T; NumT I32T] --> [], []

  | ElemDrop x ->
    ignore (elem c x);
    [] --> [], []

  | Load (x, memop) ->
    let MemoryT (_lim, it) = memory c x in
    let t = check_memop c memop num_size (Lib.Option.map fst) e.at in
    [value_type_of_index_type it] --> [NumT t], []

  | Store (x, memop) ->
    let MemoryT (_lim, it) = memory c x in
    let t = check_memop c memop num_size (fun sz -> sz) e.at in
    [value_type_of_index_type it; NumT t] --> [], []

  | VecLoad (x, memop) ->
    let MemoryT (_lim, it) = memory c x in
    let t = check_memop c memop vec_size (Lib.Option.map fst) e.at in
    [value_type_of_index_type it] --> [VecT t], []

  | VecStore (x, memop) ->
    let MemoryT (_lim, it) = memory c x in
    let t = check_memop c memop vec_size (fun _ -> None) e.at in
    [value_type_of_index_type it; VecT t] --> [], []

  | VecLoadLane (x, memop, i) ->
    let MemoryT (_lim, it) = memory c x in
    let t = check_memop c memop vec_size (fun sz -> Some sz) e.at in
    require (i < vec_size t / Pack.packed_size memop.pack) e.at
      "invalid lane index";
    [value_type_of_index_type it; VecT t] -->  [VecT t], []

  | VecStoreLane (x, memop, i) ->
    let MemoryT (_lim, it) = memory c x in
    let t = check_memop c memop vec_size (fun sz -> Some sz) e.at in
    require (i < vec_size t / Pack.packed_size memop.pack) e.at
      "invalid lane index";
    [value_type_of_index_type it; VecT t] -->  [], []

  | MemorySize x ->
    let MemoryT (_lim, it) = memory c x in
    [] --> [value_type_of_index_type it], []

  | MemoryGrow x ->
    let MemoryT (_lim, it) = memory c x in
    [value_type_of_index_type it] --> [value_type_of_index_type it], []

  | MemoryFill x ->
    let MemoryT (_lim, it) = memory c x in
    [value_type_of_index_type it; NumT I32T; value_type_of_index_type it] --> [], []

  | MemoryCopy (x, y)->
    let MemoryT (_lib1, it1) = memory c x in
    let MemoryT (_lib2, it2) = memory c y in
    let it_min = min it1 it2 in
    [value_type_of_index_type it1; value_type_of_index_type it2; value_type_of_index_type it_min] --> [], []

  | MemoryInit (x, y) ->
    let MemoryT (_lib, it) = memory c x in
    let () = data c y in
    [value_type_of_index_type it; NumT I32T; NumT I32T] --> [], []

  | DataDrop x ->
    let () = data c x in
    [] --> [], []

  | RefNull ht ->
    check_heap_type c ht e.at;
    [] --> [RefT (Null, ht)], []

  | RefFunc x ->
    let dt = func c x in
    refer_func c x;
    [] --> [RefT (NoNull, DefHT dt)], []

  | RefIsNull ->
    let (_nul, ht) = peek_ref 0 s e.at in
    [RefT (Null, ht)] --> [NumT I32T], []

  | RefAsNonNull ->
    let (_nul, ht) = peek_ref 0 s e.at in
    [RefT (Null, ht)] --> [RefT (NoNull, ht)], []

  | RefTest rt ->
    let (_nul, ht) = rt in
    check_ref_type c rt e.at;
    [RefT (Null, top_of_heap_type c.types ht)] --> [NumT I32T], []

  | RefCast rt ->
    let (nul, ht) = rt in
    check_ref_type c rt e.at;
    [RefT (Null, top_of_heap_type c.types ht)] --> [RefT (nul, ht)], []

  | RefEq ->
    [RefT (Null, EqHT); RefT (Null, EqHT)] --> [NumT I32T], []

  | RefI31 ->
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
    ts --> [RefT (NoNull, DefHT (type_ c x))], []

  | StructGet (x, y, exto) ->
    let StructT fts = struct_type c x in
    require (y.it < Lib.List32.length fts) y.at
      ("unknown field " ^ I32.to_string_u y.it);
    let FieldT (_mut, st) = Lib.List32.nth fts y.it in
    require ((exto <> None) == is_packed_storage_type st) y.at
      ("field is " ^ (if exto = None then "packed" else "unpacked"));
    let t = unpacked_storage_type st in
    [RefT (Null, DefHT (type_ c x))] --> [t], []

  | StructSet (x, y) ->
    let StructT fts = struct_type c x in
    require (y.it < Lib.List32.length fts) y.at
      ("unknown field " ^ I32.to_string_u y.it);
    let FieldT (mut, st) = Lib.List32.nth fts y.it in
    require (mut == Var) y.at "field is immutable";
    let t = unpacked_storage_type st in
    [RefT (Null, DefHT (type_ c x)); t] --> [], []

  | ArrayNew (x, initop) ->
    let ArrayT ft = array_type c x in
    require
      (initop = Explicit || defaultable (unpacked_field_type ft)) x.at
      "array type is not defaultable";
    let ts = if initop = Implicit then [] else [unpacked_field_type ft] in
    (ts @ [NumT I32T]) --> [RefT (NoNull, DefHT (type_ c x))], []

  | ArrayNewFixed (x, n) ->
    let ArrayT ft = array_type c x in
    let ts = Lib.List32.make n (unpacked_field_type ft) in
    ts --> [RefT (NoNull, DefHT (type_ c x))], []

  | ArrayNewElem (x, y) ->
    let ArrayT ft = array_type c x in
    let rt = elem c y in
    require (match_val_type c.types (RefT rt) (unpacked_field_type ft)) x.at
      ("type mismatch: element segment's type " ^ string_of_ref_type rt ^
       " does not match array's field type " ^ string_of_field_type ft);
    [NumT I32T; NumT I32T] --> [RefT (NoNull, DefHT (type_ c x))], []

  | ArrayNewData (x, y) ->
    let ArrayT ft = array_type c x in
    let () = data c y in
    let t = unpacked_field_type ft in
    require (is_num_type t || is_vec_type t) x.at
      "array type is not numeric or vector";
    [NumT I32T; NumT I32T] --> [RefT (NoNull, DefHT (type_ c x))], []

  | ArrayGet (x, exto) ->
    let ArrayT (FieldT (_mut, st)) = array_type c x in
    require ((exto <> None) == is_packed_storage_type st) e.at
      ("array is " ^ (if exto = None then "packed" else "unpacked"));
    let t = unpacked_storage_type st in
    [RefT (Null, DefHT (type_ c x)); NumT I32T] --> [t], []

  | ArraySet x ->
    let ArrayT (FieldT (mut, st)) = array_type c x in
    require (mut == Var) e.at "array is immutable";
    let t = unpacked_storage_type st in
    [RefT (Null, DefHT (type_ c x)); NumT I32T; t] --> [], []

  | ArrayLen ->
    [RefT (Null, ArrayHT)] --> [NumT I32T], []

  | ArrayCopy (x, y) ->
    let ArrayT (FieldT (mutd, std)) = array_type c x in
    let ArrayT (FieldT (_muts, sts)) = array_type c y in
    require (mutd = Var) e.at "array is immutable";
    require (match_storage_type c.types sts std) e.at "array types do not match";
    [RefT (Null, DefHT (type_ c x)); NumT I32T; RefT (Null, DefHT (type_ c y)); NumT I32T; NumT I32T] --> [], []

  | ArrayFill x ->
    let ArrayT (FieldT (mut, st)) = array_type c x in
    require (mut = Var) e.at "array is immutable";
    let t = unpacked_storage_type st in
    [RefT (Null, DefHT (type_ c x)); NumT I32T; t; NumT I32T] --> [], []

  | ArrayInitData (x, y) ->
    let ArrayT (FieldT (mut, st)) = array_type c x in
    require (mut = Var) e.at "array is immutable";
    let () = data c y in
    let t = unpacked_storage_type st in
    require (is_num_type t || is_vec_type t) x.at
      "array type is not numeric or vector";
    [RefT (Null, DefHT (type_ c x)); NumT I32T; NumT I32T; NumT I32T] --> [], []

  | ArrayInitElem (x, y) ->
    let ArrayT (FieldT (mut, st)) = array_type c x in
    require (mut = Var) e.at "array is immutable";
    let rt = elem c y in
    require (match_val_type c.types (RefT rt) (unpacked_storage_type st)) x.at
      ("type mismatch: element segment's type " ^ string_of_ref_type rt ^
       " does not match array's field type " ^ string_of_field_type (FieldT (mut, st)));
    [RefT (Null, DefHT (type_ c x)); NumT I32T; NumT I32T; NumT I32T] --> [], []

  | ExternConvert op ->
    let ht1, ht2 = type_externop op in
    let (nul, _ht) = peek_ref 0 s e.at in
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

  | VecTernary ternop ->
    let t = VecT (type_vec ternop) in
    [t; t; t] --> [t], []

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

and check_catch (c : context) (cc : catch) (ts : val_type list) at =
  let match_target = match_resulttype "label" "catch handler" in
  match cc.it with
  | Catch (x1, x2) ->
    let TagT dt = tag c x1 in
    let FuncT (ts1, ts2) = as_func_str_type (expand_def_type dt) in
    match_target c ts1 (label c x2) cc.at
  | CatchRef (x1, x2) ->
    let TagT dt = tag c x1 in
    let FuncT (ts1, ts2) = as_func_str_type (expand_def_type dt) in
    match_target c (ts1 @ [RefT (NoNull, ExnHT)]) (label c x2) cc.at
  | CatchAll x ->
    match_target c [] (label c x) cc.at
  | CatchAllRef x ->
    match_target c [RefT (NoNull, ExnHT)] (label c x) cc.at


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

let check_func (c : context) (f : func) : context =
  let {ftype; locals; body} = f.it in
  let _ft = func_type c ftype in
  {c with funcs = c.funcs @ [type_ c ftype]}

let check_func_body (c : context) (f : func) =
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
  | Binary (Value.I32 I32Op.(Add | Sub | Mul))
  | Binary (Value.I64 I64Op.(Add | Sub | Mul))
  | RefNull _ | RefFunc _
  | RefI31 | StructNew _ | ArrayNew _ | ArrayNewFixed _ -> true
  | GlobalGet x -> let GlobalT (mut, _t) = global c x in mut = Cons
  | _ -> false

let check_const (c : context) (const : const) (t : val_type) =
  require (List.for_all (is_const c) const.it) const.at
    "constant expression required";
  check_block c const.it (InstrT ([], [t], [])) const.at


(* Globals, Tables, Memories, Tags *)

let check_global (c : context) (glob : global) : context =
  let {gtype; ginit} = glob.it in
  let GlobalT (_mut, t) = gtype in
  check_global_type c gtype glob.at;
  check_const c ginit t;
  {c with globals = c.globals @ [gtype]}

let check_table (c : context) (tab : table) : context =
  let {ttype; tinit} = tab.it in
  let TableT (_lim, _it, rt) = ttype in
  check_table_type c ttype tab.at;
  check_const c tinit (RefT rt);
  {c with tables = c.tables @ [ttype]}

let check_memory (c : context) (mem : memory) : context =
  let {mtype} = mem.it in
  check_memory_type c mtype mem.at;
  {c with memories = c.memories @ [mtype]}

let check_tag (c : context) (t : tag) : context =
  let FuncT (_, ts2) = func_type c t.it.tgtype in
  require (ts2 = []) t.it.tgtype.at "non-empty tag result type";
  {c with tags = c.tags @ [TagT (type_ c t.it.tgtype)]}

let check_elem_mode (c : context) (t : ref_type) (mode : segment_mode) =
  match mode.it with
  | Passive -> ()
  | Active {index; offset} ->
    let TableT (_lim, it, et) = table c index in
    require (match_ref_type c.types t et) mode.at
      ("type mismatch: element segment's type " ^ string_of_ref_type t ^
       " does not match table's element type " ^ string_of_ref_type et);
    check_const c offset (value_type_of_index_type it)
  | Declarative -> ()

let check_elem (c : context) (seg : elem_segment) : context =
  let {etype; einit; emode} = seg.it in
  check_ref_type c etype seg.at;
  List.iter (fun const -> check_const c const (RefT etype)) einit;
  check_elem_mode c etype emode;
  {c with elems = c.elems @ [etype]}

let check_data_mode (c : context) (mode : segment_mode) =
  match mode.it with
  | Passive -> ()
  | Active {index; offset} ->
    let MemoryT (_, it) = memory c index in
    check_const c offset (value_type_of_index_type it)
  | Declarative -> assert false

let check_data (c : context) (seg : data_segment) : context =
  let {dinit; dmode} = seg.it in
  check_data_mode c dmode;
  {c with datas = c.datas @ [()]}


(* Modules *)

let check_start (c : context) (start : start) =
  let {sfunc} = start.it in
  let ft = as_func_str_type (expand_def_type (func c sfunc)) in
  require (ft = FuncT ([], [])) start.at
    "start function must not have parameters or results"

let check_import (c : context) (im : import) : context =
  let {module_name = _; item_name = _; idesc} = im.it in
  match idesc.it with
  | FuncImport x ->
    let _ = func_type c x in
    {c with funcs = c.funcs @ [type_ c x]}
  | GlobalImport gt ->
    check_global_type c gt idesc.at;
    {c with globals = c.globals @ [gt]}
  | TableImport tt ->
    check_table_type c tt idesc.at;
    {c with tables = c.tables @ [tt]}
  | MemoryImport mt ->
    check_memory_type c mt idesc.at;
    {c with memories = c.memories @ [mt]}
  | TagImport x ->
    let _ = func_type c x in
    {c with tags = c.tags @ [TagT (type_ c x)]}

module NameSet = Set.Make(struct type t = Ast.name let compare = compare end)

let check_export (c : context) (set : NameSet.t) (ex : export) : NameSet.t =
  let {name; edesc} = ex.it in
  (match edesc.it with
  | FuncExport x -> ignore (func c x)
  | GlobalExport x -> ignore (global c x)
  | TableExport x -> ignore (table c x)
  | MemoryExport x -> ignore (memory c x)
  | TagExport x -> ignore (tag c x)
  );
  require (not (NameSet.mem name set)) ex.at "duplicate export name";
  NameSet.add name set


let check_list f xs (c : context) : context =
  List.fold_left f c xs

let check_module (m : module_) =
  let refs = Free.module_ ({m.it with funcs = []; start = None} @@ m.at) in
  let c =
    {empty_context with refs}
    |> check_list check_type m.it.types
    |> check_list check_import m.it.imports
    |> check_list check_func m.it.funcs
    |> check_list check_table m.it.tables
    |> check_list check_memory m.it.memories
    |> check_list check_global m.it.globals
    |> check_list check_tag m.it.tags
    |> check_list check_elem m.it.elems
    |> check_list check_data m.it.datas
  in
  List.iter (check_func_body c) m.it.funcs;
  Option.iter (check_start c) m.it.start;
  ignore (List.fold_left (check_export c) NameSet.empty m.it.exports)

let check_module_with_custom ((m : module_), (cs : Custom.section list)) =
  check_module m;
  List.iter (fun (module S : Custom.Section) -> S.Handler.check m S.it) cs
