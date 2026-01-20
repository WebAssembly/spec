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
  types : deftype list;
  tags : tagtype list;
  globals : globaltype list;
  memories : memorytype list;
  tables : tabletype list;
  funcs : deftype list;
  datas : unit list;
  elems : reftype list;
  locals : localtype list;
  labels : resulttype list;
  results : valtype list;
  refs : Free.t;
}

let empty_context =
  { types = []; tags = []; globals = []; memories = []; tables = [];
    funcs = []; datas = []; elems = []; locals = []; labels = []; results = [];
    refs = Free.empty
  }

let lookup category list x =
  try Lib.List32.nth list x.it with Failure _ ->
    error x.at ("unknown " ^ category ^ " " ^ I32.to_string_u x.it)

let type_ (c : context) x = lookup "type" c.types x
let tag (c : context) x = lookup "tag" c.tags x
let global (c : context) x = lookup "global" c.globals x
let memory (c : context) x = lookup "memory" c.memories x
let table (c : context) x = lookup "table" c.tables x
let func (c : context) x = lookup "function" c.funcs x
let data (c : context) x = lookup "data segment" c.datas x
let elem (c : context) x = lookup "elem segment" c.elems x
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

let struct_type (c : context) x =
  match expand_deftype (type_ c x) with
  | StructT fts -> fts
  | _ -> error x.at ("non-structure type " ^ I32.to_string_u x.it)

let array_type (c : context) x =
  match expand_deftype (type_ c x) with
  | ArrayT ft -> ft
  | _ -> error x.at ("non-array type " ^ I32.to_string_u x.it)

let func_type (c : context) x =
  match expand_deftype (type_ c x) with
  | FuncT (ts1, ts2) -> ts1, ts2
  | _ -> error x.at ("non-function type " ^ I32.to_string_u x.it)

let refer category (s : Free.Set.t) x =
  if not (Free.Set.mem x.it s) then
    error x.at
      ("undeclared " ^ category ^ " reference " ^ I32.to_string_u x.it)

let refer_func (c : context) x = refer "function" c.refs.Free.funcs x


let clos (c : context) subst t =
  let dts =
    List.fold_left (fun dts dt -> dts @ [subst_deftype (subst_of dts) dt])
      [] c.types
  in subst (subst_of dts) t


(* Types *)

let check_limits {min; max} range at msg =
  require (I64.le_u min range) at msg;
  match max with
  | None -> ()
  | Some max ->
    require (I64.le_u max range) at msg;
    require (I64.le_u min max) at
      "size minimum must not be greater than maximum"

let check_numtype (c : context) (t : numtype) at =
  ()

let check_vectype (c : context) (t : vectype) at =
  ()

let check_typeuse (c : context) (ut : typeuse) at =
  match ut with
  | Idx x -> let _dt = type_ c (x @@ at) in ()
  | _ -> assert false

let check_heaptype (c : context) (t : heaptype) at =
  match t with
  | AnyHT | NoneHT | EqHT | I31HT | StructHT | ArrayHT
  | FuncHT | NoFuncHT
  | ExnHT | NoExnHT
  | ExternHT | NoExternHT -> ()
  | UseHT ut -> check_typeuse c ut at
  | BotHT -> ()

let check_reftype (c : context) (t : reftype) at =
  match t with
  | (_nul, ht) -> check_heaptype c ht at

let check_valtype (c : context) (t : valtype) at =
  match t with
  | NumT t' -> check_numtype c t' at
  | VecT t' -> check_vectype c t' at
  | RefT t' -> check_reftype c t' at
  | BotT -> assert false

let check_resulttype (c : context) (ts : resulttype) at =
  List.iter (fun t -> check_valtype c t at) ts

let check_storagetype (c : context) (st : storagetype) at =
  match st with
  | ValStorageT t -> check_valtype c t at
  | PackStorageT pt -> ()

let check_fieldtype (c : context) (ft : fieldtype) at =
  match ft with
  | FieldT (_mut, st) -> check_storagetype c st at

let check_comptype (c : context) (ct : comptype) at =
  match ct with
  | StructT fts ->
    List.iter (fun ft -> check_fieldtype c ft at) fts
  | ArrayT ft ->
    check_fieldtype c ft at
  | FuncT (ts1, ts2) ->
    check_resulttype c ts1 at;
    check_resulttype c ts2 at

let check_subtype (c : context) (sut : subtype) at =
  let SubT (_fin, uts, ct) = sut in
  List.iter (fun ut -> check_typeuse c ut at) uts;
  check_comptype c ct at

let check_subtype_sub (c : context) (sut : subtype) x at =
  let SubT (_fin, uts, ct) = sut in
  List.iter (fun uti ->
    let xi = idx_of_typeuse uti in
    let SubT (fini, _, cti) = unroll_deftype (type_ c (xi @@ at)) in
    require (xi < x) at ("forward use of type " ^ I32.to_string_u xi ^
      " in sub type definition");
    require (fini = NoFinal) at ("sub type " ^ I32.to_string_u x ^
      " has final super type " ^ I32.to_string_u xi);
    require (match_comptype c.types ct cti) at ("sub type " ^ I32.to_string_u x ^
      " does not match super type " ^ I32.to_string_u xi)
  ) uts

let check_rectype (c : context) (rt : rectype) at : context =
  let RecT sts = rt in
  let x = Lib.List32.length c.types in
  let c' = {c with types = c.types @ roll_deftypes x rt} in
  List.iter (fun st -> check_subtype c' st at) sts;
  Lib.List32.iteri
    (fun i st -> check_subtype_sub c' st (Int32.add x i) at) sts;
  c'


let check_tagtype (c : context) (tt : tagtype) at =
  let TagT ut = tt in
  let (ts1, ts2) = func_type c (idx_of_typeuse ut @@ at) in
  require (ts2 = []) at "non-empty tag result type";
  ()

let check_globaltype (c : context) (gt : globaltype) at =
  let GlobalT (_mut, t) = gt in
  check_valtype c t at

let check_memorytype (c : context) (mt : memorytype) at =
  let MemoryT (at_, lim) = mt in
  let sz, s =
    match at_ with
    | I32AT -> 0x1_0000L, "2^16 pages (4 GiB) for i32"
    | I64AT -> 0x1_0000_0000_0000L, "2^48 pages (256 TiB) for i64"
  in
  check_limits lim sz at ("memory size must be at most " ^ s)

let check_tabletype (c : context) (tt : tabletype) at =
  let TableT (at_, lim, t) = tt in
  check_reftype c t at;
  let sz, s =
    match at_ with
    | I32AT -> 0xffff_ffffL, "2^32-1 for i32"
    | I64AT -> 0xffff_ffff_ffff_ffffL, "2^64-1 for i64"
  in
  check_limits lim sz at ("table size must be at most " ^ s)

let check_externtype (c : context) (xt : externtype) at =
  match xt with
  | ExternTagT tt ->
    check_tagtype c tt at
  | ExternGlobalT gt ->
    check_globaltype c gt at
  | ExternMemoryT mt ->
    check_memorytype c mt at
  | ExternTableT tt ->
    check_tabletype c tt at
  | ExternFuncT ut ->
    let _ft = func_type c (idx_of_typeuse ut @@ at) in ()


let diff_reftype (nul1, ht1) (nul2, ht2) =
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
type infer_resulttype = ellipses * valtype list
type infer_functype = {ins : infer_resulttype; outs : infer_resulttype}
type infer_instrtype = infer_functype * idx list

let stack ts = (NoEllipses, ts)
let (-->) ts1 ts2 = {ins = NoEllipses, ts1; outs = NoEllipses, ts2}
let (-->...) ts1 ts2 = {ins = Ellipses, ts1; outs = Ellipses, ts2}

let match_result_type s1 s2 (c : context) ts1 ts2 at =
  require
    ( List.length ts1 = List.length ts2 &&
      List.for_all2 (match_valtype c.types) ts1 ts2 ) at
    ("type mismatch: " ^ s2 ^ " requires " ^ string_of_resulttype ts2 ^
     " but " ^ s1 ^ " has " ^ string_of_resulttype ts1)

let match_stack (c : context) ts1 ts2 at =
  match_result_type "stack" "instruction" c ts1 ts2 at

let pop c (ell1, ts1) (ell2, ts2) at =
  let n1 = List.length ts1 in
  let n2 = List.length ts2 in
  let n = min n1 n2 in
  let n3 = if ell2 = Ellipses then (n1 - n) else 0 in
  match_stack c (Lib.List.make n3 (BotT : valtype) @ Lib.List.drop (n2 - n) ts2) ts1 at;
  (ell2, if ell1 = Ellipses then [] else Lib.List.take (n2 - n) ts2)

let push c (ell1, ts1) (ell2, ts2) =
  assert (ell1 = NoEllipses || ts2 = []);
  (if ell1 = Ellipses || ell2 = Ellipses then Ellipses else NoEllipses),
  ts2 @ ts1

let peek i (ell, ts) : valtype =
  try List.nth (List.rev ts) i with Failure _ -> BotT

let peek_ref i (ell, ts) at : reftype =
  match peek i (ell, ts) with
  | RefT rt -> rt
  | BotT -> (NoNull, BotHT)
  | t ->
    error at
      ("type mismatch: instruction requires reference type" ^
       " but stack has " ^ string_of_valtype t)


(* Type Synthesis *)

let type_num = Value.type_of_op
let type_vec = Value.type_of_vecop
let type_vec_lane = function
  | Value.V128 laneop -> V128.type_of_lane laneop

let type_cvtop at = function
  | Value.I32 cvtop ->
    let open I32Op in
    (match cvtop with
    | ExtendI32 _ -> error at "invalid conversion"
    | WrapI64 -> I64T
    | TruncF32 _ | TruncSatF32 _ | ReinterpretFloat -> F32T
    | TruncF64 _ | TruncSatF64 _ -> F64T
    ), I32T
  | Value.I64 cvtop ->
    let open I64Op in
    (match cvtop with
    | ExtendI32 _ -> I32T
    | WrapI64 -> error at "invalid conversion"
    | TruncF32 _ | TruncSatF32 _ -> F32T
    | TruncF64 _ | TruncSatF64 _ | ReinterpretFloat -> F64T
    ), I64T
  | Value.F32 cvtop ->
    let open F32Op in
    (match cvtop with
    | ConvertI32 _ | ReinterpretInt -> I32T
    | ConvertI64 _ -> I64T
    | PromoteF32 -> error at "invalid conversion"
    | DemoteF64 -> F64T
    ), F32T
  | Value.F64 cvtop ->
    let open F64Op in
    (match cvtop with
    | ConvertI32 _ -> I32T
    | ConvertI64 _ | ReinterpretInt -> I64T
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
    if List.exists (fun i -> I8.to_int_u i >= 32) is then
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
  let MemoryT (at_, _lim) = memory c (0l @@ at) in
  if at_ = I32AT then
    require (I64.lt_u memop.offset 0x1_0000_0000L) at
      "offset out of range";
  memop.ty


(*
 * Conventions:
 *   c  : context
 *   e  : instr
 *   es : instr list
 *   v  : value
 *   t  : valtype
 *   ts : resulttype
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

let check_blocktype (c : context) (bt : blocktype) at : instrtype =
  match bt with
  | ValBlockType None -> InstrT ([], [], [])
  | ValBlockType (Some t) -> check_valtype c t at; InstrT ([], [t], [])
  | VarBlockType x ->
    let (ts1, ts2) = func_type c x in InstrT (ts1, ts2, [])

let rec check_instr (c : context) (e : instr) (s : infer_resulttype) : infer_instrtype =
  match e.it with
  | Unreachable ->
    [] -->... [], []

  | Nop ->
    [] --> [], []

  | Drop ->
    [peek 0 s] --> [], []

  | Select None ->
    let t = peek 1 s in
    require (is_numtype t || is_vectype t) e.at
      ("type mismatch: instruction requires numeric or vector type" ^
       " but stack has " ^ string_of_valtype t);
    [t; t; NumT I32T] --> [t], []

  | Select (Some ts) ->
    require (List.length ts = 1) e.at
      "invalid result arity other than 1 is not (yet) allowed";
    check_resulttype c ts e.at;
    (ts @ ts @ [NumT I32T]) --> ts, []

  | Block (bt, es) ->
    let InstrT (ts1, ts2, xs) as it = check_blocktype c bt e.at in
    check_block {c with labels = ts2 :: c.labels} es it e.at;
    ts1 --> ts2, List.map (fun x -> x @@ e.at) xs

  | Loop (bt, es) ->
    let InstrT (ts1, ts2, xs) as it = check_blocktype c bt e.at in
    check_block {c with labels = ts1 :: c.labels} es it e.at;
    ts1 --> ts2, List.map (fun x -> x @@ e.at) xs

  | If (bt, es1, es2) ->
    let InstrT (ts1, ts2, xs) as it = check_blocktype c bt e.at in
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
    require (label c x <> []) e.at
      ("type mismatch: instruction requires reference type" ^
       " but label has " ^ string_of_resulttype (label c x));
    let ts0, t1 = Lib.List.split_last (label c x) in
    require (is_reftype t1) e.at
      ("type mismatch: instruction requires reference type" ^
       " but label has " ^ string_of_valtype t1);
    let ht = match t1 with RefT (_nul, ht) -> ht | _ -> assert false in
    (ts0 @ [RefT (Null, ht)]) --> ts0, []

  | BrOnCast (x, rt1, rt2) ->
    check_reftype c rt1 e.at;
    check_reftype c rt2 e.at;
    require
      (match_reftype c.types rt2 rt1) e.at
      ("type mismatch on cast: type " ^ string_of_reftype rt2 ^
       " does not match " ^ string_of_reftype rt1);
    require (label c x <> []) e.at
      ("type mismatch: instruction requires type " ^ string_of_reftype rt2 ^
       " but label has " ^ string_of_resulttype (label c x));
    let ts0, t1 = Lib.List.split_last (label c x) in
    require (match_valtype c.types (RefT rt2) t1) e.at
      ("type mismatch: instruction requires type " ^ string_of_reftype rt2 ^
       " but label has " ^ string_of_resulttype (label c x));
    (ts0 @ [RefT rt1]) --> (ts0 @ [RefT (diff_reftype rt1 rt2)]), []

  | BrOnCastFail (x, rt1, rt2) ->
    check_reftype c rt1 e.at;
    check_reftype c rt2 e.at;
    let rt1' = diff_reftype rt1 rt2 in
    require
      (match_reftype c.types rt2 rt1) e.at
      ("type mismatch on cast: type " ^ string_of_reftype rt2 ^
       " does not match " ^ string_of_reftype rt1);
    require (label c x <> []) e.at
      ("type mismatch: instruction requires type " ^ string_of_reftype rt1' ^
       " but label has " ^ string_of_resulttype (label c x));
    let ts0, t1 = Lib.List.split_last (label c x) in
    require (match_valtype c.types (RefT rt1') t1) e.at
      ("type mismatch: instruction requires type " ^ string_of_reftype rt1' ^
       " but label has " ^ string_of_resulttype (label c x));
    (ts0 @ [RefT rt1]) --> (ts0 @ [RefT rt2]), []

  | Return ->
    c.results -->... [], []

  | Call x ->
    let (ts1, ts2) = functype_of_comptype (expand_deftype (func c x)) in
    ts1 --> ts2, []

  | CallRef x ->
    let (ts1, ts2) = func_type c x in
    (ts1 @ [RefT (Null, UseHT (Def (type_ c x)))]) --> ts2, []

  | CallIndirect (x, y) ->
    let TableT (at, _lim, t) = table c x in
    let (ts1, ts2) = func_type c y in
    require (match_reftype c.types t (Null, FuncHT)) x.at
      ("type mismatch: instruction requires table of function type" ^
       " but table has element type " ^ string_of_reftype t);
    (ts1 @ [NumT (numtype_of_addrtype at)]) --> ts2, []

  | ReturnCall x ->
    let (ts1, ts2) = functype_of_comptype (expand_deftype (func c x)) in
    require (match_resulttype c.types ts2 c.results) e.at
      ("type mismatch: current function requires result type " ^
       string_of_resulttype c.results ^
       " but callee returns " ^ string_of_resulttype ts2);
    ts1 -->... [], []

  | ReturnCallRef x ->
    let (ts1, ts2) = func_type c x in
    require (match_resulttype c.types ts2 c.results) e.at
      ("type mismatch: current function requires result type " ^
       string_of_resulttype c.results ^
       " but callee returns " ^ string_of_resulttype ts2);
    (ts1 @ [RefT (Null, UseHT (Def (type_ c x)))]) -->... [], []

  | ReturnCallIndirect (x, y) ->
    let TableT (at, _lim, t) = table c x in
    let (ts1, ts2) = func_type c y in
    require (match_reftype c.types t (Null, FuncHT)) x.at
      ("type mismatch: instruction requires table of function type" ^
       " but table has element type " ^ string_of_reftype t);
    require (match_resulttype c.types ts2 c.results) e.at
      ("type mismatch: current function requires result type " ^
       string_of_resulttype c.results ^
       " but callee returns " ^ string_of_resulttype ts2);
    (ts1 @ [NumT (numtype_of_addrtype at)]) -->... [], []

  | Throw x ->
    let TagT ut = tag c x in
    let dt = deftype_of_typeuse ut in
    let (ts1, ts2) = functype_of_comptype (expand_deftype dt) in
    ts1 -->... [], []

  | ThrowRef ->
    [RefT (Null, ExnHT)] -->... [], []

  | TryTable (bt, cs, es) ->
    let InstrT (ts1, ts2, xs) as it = check_blocktype c bt e.at in
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
    let TableT (at, _lim, rt) = table c x in
    [NumT (numtype_of_addrtype at)] --> [RefT rt], []

  | TableSet x ->
    let TableT (at, _lim, rt) = table c x in
    [NumT (numtype_of_addrtype at); RefT rt] --> [], []

  | TableSize x ->
    let TableT (at, _lim, _rt) = table c x in
    [] --> [NumT (numtype_of_addrtype at)], []

  | TableGrow x ->
    let TableT (at, _lim, rt) = table c x in
    [RefT rt; NumT (numtype_of_addrtype at)] -->
      [NumT (numtype_of_addrtype at)], []

  | TableFill x ->
    let TableT (at, _lim, rt) = table c x in
    [NumT (numtype_of_addrtype at); RefT rt; 
      NumT (numtype_of_addrtype at)] --> [], []

  | TableCopy (x, y) ->
    let TableT (at1, _lim1, t1) = table c x in
    let TableT (at2, _lim2, t2) = table c y in
    require (match_reftype c.types t2 t1) x.at
      ("type mismatch: source element type " ^ string_of_reftype t1 ^
       " does not match destination element type " ^ string_of_reftype t2);
    [NumT (numtype_of_addrtype at1); NumT (numtype_of_addrtype at2);
      NumT (numtype_of_addrtype (min at1 at2))] --> [], []

  | TableInit (x, y) ->
    let TableT (at, _lim1, t1) = table c x in
    let t2 = elem c y in
    require (match_reftype c.types t2 t1) x.at
      ("type mismatch: element segment's type " ^ string_of_reftype t1 ^
       " does not match table's element type " ^ string_of_reftype t2);
    [NumT (numtype_of_addrtype at); NumT I32T; NumT I32T] --> [], []

  | ElemDrop x ->
    ignore (elem c x);
    [] --> [], []

  | Load (x, memop) ->
    let MemoryT (at, _lim) = memory c x in
    let t = check_memop c memop num_size (Lib.Option.map fst) e.at in
    [NumT (numtype_of_addrtype at)] --> [NumT t], []

  | Store (x, memop) ->
    let MemoryT (at, _lim) = memory c x in
    let t = check_memop c memop num_size (fun sz -> sz) e.at in
    [NumT (numtype_of_addrtype at); NumT t] --> [], []

  | VecLoad (x, memop) ->
    let MemoryT (at, _lim) = memory c x in
    let t = check_memop c memop vec_size (Lib.Option.map fst) e.at in
    [NumT (numtype_of_addrtype at)] --> [VecT t], []

  | VecStore (x, memop) ->
    let MemoryT (at, _lim) = memory c x in
    let t = check_memop c memop vec_size (fun _ -> None) e.at in
    [NumT (numtype_of_addrtype at); VecT t] --> [], []

  | VecLoadLane (x, memop, i) ->
    let MemoryT (at, _lim) = memory c x in
    let t = check_memop c memop vec_size (fun sz -> Some sz) e.at in
    require (I8.to_int_u i < vec_size t / Pack.packed_size memop.pack) e.at
      "invalid lane index";
    [NumT (numtype_of_addrtype at); VecT t] -->  [VecT t], []

  | VecStoreLane (x, memop, i) ->
    let MemoryT (at, _lim) = memory c x in
    let t = check_memop c memop vec_size (fun sz -> Some sz) e.at in
    require (I8.to_int_u i < vec_size t / Pack.packed_size memop.pack) e.at
      "invalid lane index";
    [NumT (numtype_of_addrtype at); VecT t] -->  [], []

  | MemorySize x ->
    let MemoryT (at, _lim) = memory c x in
    [] --> [NumT (numtype_of_addrtype at)], []

  | MemoryGrow x ->
    let MemoryT (at, _lim) = memory c x in
    [NumT (numtype_of_addrtype at)] --> [NumT (numtype_of_addrtype at)], []

  | MemoryFill x ->
    let MemoryT (at, _lim) = memory c x in
    [NumT (numtype_of_addrtype at); NumT I32T;
      NumT (numtype_of_addrtype at)] --> [], []

  | MemoryCopy (x, y)->
    let MemoryT (at1, _lib1) = memory c x in
    let MemoryT (at2, _lib2) = memory c y in
    [NumT (numtype_of_addrtype at1); NumT (numtype_of_addrtype at2);
      NumT (numtype_of_addrtype (min at1 at2))] --> [], []

  | MemoryInit (x, y) ->
    let MemoryT (at, _lib) = memory c x in
    let () = data c y in
    [NumT (numtype_of_addrtype at); NumT I32T; NumT I32T] --> [], []

  | DataDrop x ->
    let () = data c x in
    [] --> [], []

  | RefNull ht ->
    check_heaptype c ht e.at;
    [] --> [RefT (Null, ht)], []

  | RefFunc x ->
    let dt = func c x in
    refer_func c x;
    [] --> [RefT (NoNull, UseHT (Def dt))], []

  | RefIsNull ->
    let (_nul, ht) = peek_ref 0 s e.at in
    [RefT (Null, ht)] --> [NumT I32T], []

  | RefAsNonNull ->
    let (_nul, ht) = peek_ref 0 s e.at in
    [RefT (Null, ht)] --> [RefT (NoNull, ht)], []

  | RefTest rt ->
    let (_nul, ht) = rt in
    check_reftype c rt e.at;
    [RefT (Null, top_of_heaptype c.types ht)] --> [NumT I32T], []

  | RefCast rt ->
    let (nul, ht) = rt in
    check_reftype c rt e.at;
    [RefT (Null, top_of_heaptype c.types ht)] --> [RefT (nul, ht)], []

  | RefEq ->
    [RefT (Null, EqHT); RefT (Null, EqHT)] --> [NumT I32T], []

  | RefI31 ->
    [NumT I32T] --> [RefT (NoNull, I31HT)], []

  | I31Get ext ->
    [RefT (Null, I31HT)] --> [NumT I32T], []

  | StructNew (x, initop) ->
    let fts = struct_type c x in
    require
      ( initop = Explicit || List.for_all (fun ft ->
          defaultable (unpacked_fieldtype ft)) fts ) x.at
      "field type is not defaultable";
    let ts = if initop = Implicit then [] else List.map unpacked_fieldtype fts in
    ts --> [RefT (NoNull, UseHT (Def (type_ c x)))], []

  | StructGet (x, i, exto) ->
    let fts = struct_type c x in
    require (i < Lib.List32.length fts) e.at
      ("unknown field " ^ I32.to_string_u i);
    let FieldT (_mut, st) = Lib.List32.nth fts i in
    require ((exto <> None) == is_packed_storagetype st) e.at
      ("field is " ^ (if exto = None then "packed" else "unpacked"));
    let t = unpacked_storagetype st in
    [RefT (Null, UseHT (Def (type_ c x)))] --> [t], []

  | StructSet (x, i) ->
    let fts = struct_type c x in
    require (i < Lib.List32.length fts) e.at
      ("unknown field " ^ I32.to_string_u i);
    let FieldT (mut, st) = Lib.List32.nth fts i in
    require (mut == Var) e.at "immutable field";
    let t = unpacked_storagetype st in
    [RefT (Null, UseHT (Def (type_ c x))); t] --> [], []

  | ArrayNew (x, initop) ->
    let ft = array_type c x in
    require
      (initop = Explicit || defaultable (unpacked_fieldtype ft)) x.at
      "array type is not defaultable";
    let ts = if initop = Implicit then [] else [unpacked_fieldtype ft] in
    (ts @ [NumT I32T]) --> [RefT (NoNull, UseHT (Def (type_ c x)))], []

  | ArrayNewFixed (x, n) ->
    let ft = array_type c x in
    let ts = Lib.List32.make n (unpacked_fieldtype ft) in
    ts --> [RefT (NoNull, UseHT (Def (type_ c x)))], []

  | ArrayNewElem (x, y) ->
    let ft = array_type c x in
    let rt = elem c y in
    require (match_valtype c.types (RefT rt) (unpacked_fieldtype ft)) x.at
      ("type mismatch: element segment's type " ^ string_of_reftype rt ^
       " does not match array's field type " ^ string_of_fieldtype ft);
    [NumT I32T; NumT I32T] --> [RefT (NoNull, UseHT (Def (type_ c x)))], []

  | ArrayNewData (x, y) ->
    let ft = array_type c x in
    let () = data c y in
    let t = unpacked_fieldtype ft in
    require (is_numtype t || is_vectype t) x.at
      "array type is not numeric or vector";
    [NumT I32T; NumT I32T] --> [RefT (NoNull, UseHT (Def (type_ c x)))], []

  | ArrayGet (x, exto) ->
    let FieldT (_mut, st) = array_type c x in
    require ((exto <> None) == is_packed_storagetype st) e.at
      ("array is " ^ (if exto = None then "packed" else "unpacked"));
    let t = unpacked_storagetype st in
    [RefT (Null, UseHT (Def (type_ c x))); NumT I32T] --> [t], []

  | ArraySet x ->
    let FieldT (mut, st) = array_type c x in
    require (mut == Var) e.at "immutable array";
    let t = unpacked_storagetype st in
    [RefT (Null, UseHT (Def (type_ c x))); NumT I32T; t] --> [], []

  | ArrayLen ->
    [RefT (Null, ArrayHT)] --> [NumT I32T], []

  | ArrayCopy (x, y) ->
    let FieldT (mutd, std) = array_type c x in
    let FieldT (_muts, sts) = array_type c y in
    require (mutd = Var) e.at "immutable array";
    require (match_storagetype c.types sts std) e.at "array types do not match";
    [RefT (Null, UseHT (Def (type_ c x))); NumT I32T; RefT (Null, UseHT (Def (type_ c y))); NumT I32T; NumT I32T] --> [], []

  | ArrayFill x ->
    let FieldT (mut, st) = array_type c x in
    require (mut = Var) e.at "immutable array";
    let t = unpacked_storagetype st in
    [RefT (Null, UseHT (Def (type_ c x))); NumT I32T; t; NumT I32T] --> [], []

  | ArrayInitData (x, y) ->
    let FieldT (mut, st) = array_type c x in
    require (mut = Var) e.at "immutable array";
    let () = data c y in
    let t = unpacked_storagetype st in
    require (is_numtype t || is_vectype t) x.at
      "array type is not numeric or vector";
    [RefT (Null, UseHT (Def (type_ c x))); NumT I32T; NumT I32T; NumT I32T] --> [], []

  | ArrayInitElem (x, y) ->
    let FieldT (mut, st) = array_type c x in
    require (mut = Var) e.at "immutable array";
    let rt = elem c y in
    require (match_valtype c.types (RefT rt) (unpacked_storagetype st)) x.at
      ("type mismatch: element segment's type " ^ string_of_reftype rt ^
       " does not match array's field type " ^ string_of_fieldtype (FieldT (mut, st)));
    [RefT (Null, UseHT (Def (type_ c x))); NumT I32T; NumT I32T; NumT I32T] --> [], []

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
    require (I8.to_int_u (lane_extractop extractop) < num_lanes extractop) e.at
      "invalid lane index";
    [t1] --> [t2], []

  | VecReplace replaceop ->
    let t1 = VecT (type_vec replaceop) in
    let t2 = NumT (type_vec_lane replaceop) in
    require (I8.to_int_u (lane_replaceop replaceop) < num_lanes replaceop) e.at
      "invalid lane index";
    [t1; t2] --> [t1], []

and check_instrs (c : context) (s : infer_resulttype) (es : instr list)
  : infer_resulttype * idx list =
  match es with
  | [] ->
    s, []
  | e::es' ->
    let {ins; outs}, xs = check_instr c e s in
    check_instrs (init_locals c xs) (push c outs (pop c ins s e.at)) es'

and check_block (c : context) (es : instr list) (it : instrtype) at =
  let InstrT (ts1, ts2, _xs) = it in
  let s, xs' = check_instrs c (stack ts1) es in
  let s' = pop c (stack ts2) s at in
  require (snd s' = []) at
    ("type mismatch: block requires " ^ string_of_resulttype ts2 ^
     " but stack has " ^ string_of_resulttype (snd s))

and check_catch (c : context) (cc : catch) (ts : valtype list) at =
  let match_target = match_result_type "label" "catch handler" in
  match cc.it with
  | Catch (x1, x2) ->
    let TagT ut = tag c x1 in
    let dt = deftype_of_typeuse ut in
    let (ts1, ts2) = functype_of_comptype (expand_deftype dt) in
    match_target c ts1 (label c x2) cc.at
  | CatchRef (x1, x2) ->
    let TagT ut = tag c x1 in
    let dt = deftype_of_typeuse ut in
    let (ts1, ts2) = functype_of_comptype (expand_deftype dt) in
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
 *   t : valtype
 *   s : functype
 *   x : variable
 *)

let check_local (c : context) (loc : local) : localtype =
  let Local t = loc.it in
  check_valtype c t loc.at;
  let init = if defaultable t then Set else Unset in
  LocalT (init, t)

let check_func (c : context) (f : func) : context =
  let Func (x, _ls, _es) = f.it in
  let _ft = func_type c x in
  {c with funcs = c.funcs @ [type_ c x]}

let check_func_body (c : context) (f : func) =
  let Func (x, ls, es) = f.it in
  let (ts1, ts2) = func_type c x in
  let lts = List.map (check_local c) ls in
  let c' =
    { c with
      locals = List.map (fun t -> LocalT (Set, t)) ts1 @ lts;
      results = ts2;
      labels = [ts2]
    }
  in check_block c' es (InstrT ([], ts2, [])) f.at

let is_const (c : context) (e : instr) =
  match e.it with
  | Const _ | VecConst _
  | Binary (Value.I32 I32Op.(Add | Sub | Mul))
  | Binary (Value.I64 I64Op.(Add | Sub | Mul))
  | RefNull _ | RefFunc _ | RefI31
  | StructNew _ | ArrayNew _ | ArrayNewFixed _
  | ExternConvert _ -> true
  | GlobalGet x -> let GlobalT (mut, _t) = global c x in mut = Cons
  | _ -> false

let check_const (c : context) (const : const) (t : valtype) =
  require (List.for_all (is_const c) const.it) const.at
    "constant expression required";
  check_block c const.it (InstrT ([], [t], [])) const.at


(* Tags, Globals, Memories, Tables *)

let check_tag (c : context) (tag : tag) : context =
  let Tag tt = tag.it in
  check_tagtype c tt tag.at;
  {c with tags = c.tags @ [subst_tagtype (subst_of c.types) tt]}

let check_global (c : context) (glob : global) : context =
  let Global (gt, const) = glob.it in
  let GlobalT (_mut, t) = gt in
  check_globaltype c gt glob.at;
  check_const c const t;
  {c with globals = c.globals @ [gt]}

let check_memory (c : context) (mem : memory) : context =
  let Memory mt = mem.it in
  check_memorytype c mt mem.at;
  {c with memories = c.memories @ [mt]}

let check_table (c : context) (tab : table) : context =
  let Table (tt, const) = tab.it in
  let TableT (_at, _lim, rt) = tt in
  check_tabletype c tt tab.at;
  check_const c const (RefT rt);
  {c with tables = c.tables @ [tt]}

let check_datamode (c : context) (mode : segmentmode) =
  match mode.it with
  | Passive -> ()
  | Active (x, offset) ->
    let MemoryT (at, _) = memory c x in
    check_const c offset (NumT (numtype_of_addrtype at))
  | Declarative -> assert false

let check_data (c : context) (data : data) : context =
  let Data (_bs, dmode) = data.it in
  check_datamode c dmode;
  {c with datas = c.datas @ [()]}

let check_elemmode (c : context) (t : reftype) (mode : segmentmode) =
  match mode.it with
  | Passive -> ()
  | Active (x, offset) ->
    let TableT (at, _lim, rt) = table c x in
    require (match_reftype c.types t rt) mode.at
      ("type mismatch: element segment's type " ^ string_of_reftype t ^
       " does not match table's element type " ^ string_of_reftype rt);
    check_const c offset (NumT (numtype_of_addrtype at))
  | Declarative -> ()

let check_elem (c : context) (elem : elem) : context =
  let Elem (rt, cs, emode) = elem.it in
  check_reftype c rt elem.at;
  List.iter (fun const -> check_const c const (RefT rt)) cs;
  check_elemmode c rt emode;
  {c with elems = c.elems @ [rt]}


(* Modules *)

let check_type (c : context) (t : type_) : context =
  check_rectype c t.it t.at

let check_start (c : context) (start : start) =
  let Start x = start.it in
  let ft = functype_of_comptype (expand_deftype (func c x)) in
  require (ft = ([], [])) start.at
    "start function must not have parameters or results"

let check_import (c : context) (im : import) : context =
  let Import (_module_name, _item_name, xt) = im.it in
  check_externtype c xt im.at;
  match subst_externtype (subst_of c.types) xt with
  | ExternTagT tt -> {c with tags = c.tags @ [tt]}
  | ExternGlobalT gt -> {c with globals = c.globals @ [gt]}
  | ExternMemoryT mt -> {c with memories = c.memories @ [mt]}
  | ExternTableT tt -> {c with tables = c.tables @ [tt]}
  | ExternFuncT ut -> {c with funcs = c.funcs @ [deftype_of_typeuse ut]}

module NameSet = Set.Make(struct type t = Ast.name let compare = compare end)

let check_export (c : context) (ex : export) : exporttype =
  let Export (name, xx) = ex.it in
  let xt =
    match xx.it with
    | TagX x -> ExternTagT (tag c x)
    | GlobalX x -> ExternGlobalT (global c x)
    | MemoryX x -> ExternMemoryT (memory c x)
    | TableX x -> ExternTableT (table c x)
    | FuncX x -> ExternFuncT (Def (func c x))
  in ExportT (name, xt)

let check_list f xs (c : context) : context =
  List.fold_left f c xs

let check_names (names : name list) at =
  ignore (
    List.fold_left (fun set name ->
      require (not (NameSet.mem name set)) at
        ("duplicate export name \"" ^ string_of_name name ^ "\"");
      NameSet.add name set
    ) NameSet.empty names
  )

let check_module (m : module_) : moduletype =
  let refs = Free.module_ ({m.it with funcs = []; start = None} @@ m.at) in
  let c =
    {empty_context with refs}
    |> check_list check_type m.it.types
    |> check_list check_import m.it.imports
    |> check_list check_tag m.it.tags
    |> check_list check_func m.it.funcs
    |> check_list check_memory m.it.memories
    |> check_list check_table m.it.tables
    |> check_list check_global m.it.globals
    |> check_list check_data m.it.datas
    |> check_list check_elem m.it.elems
  in
  List.iter (check_func_body c) m.it.funcs;
  Option.iter (check_start c) m.it.start;
  let its = List.map (fun {it = Import (mnm, nm, xt); _} -> ImportT (mnm, nm, xt)) m.it.imports in
  let ets = List.map (check_export c) m.it.exports in
  check_names (List.map (fun (ExportT (nm, _xt)) -> nm) ets) m.at;
  clos c subst_moduletype (ModuleT (its, ets))


let check_module_with_custom ((m : module_), (cs : Custom.section list))
  : moduletype =
  let mt = check_module m in
  List.iter (fun (module S : Custom.Section) -> S.Handler.check m S.it) cs;
  mt
