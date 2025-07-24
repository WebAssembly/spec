open Ast
open Pack
open Source
open Types
open Value
open Instance


(* Errors *)

module Link = Error.Make ()
module Exception = Error.Make ()
module Trap = Error.Make ()
module Crash = Error.Make ()
module Exhaustion = Error.Make ()

exception Link = Link.Error
exception Exception = Exception.Error
exception Trap = Trap.Error
exception Crash = Crash.Error (* failure that cannot happen in valid code *)
exception Exhaustion = Exhaustion.Error

let table_error at = function
  | Table.Bounds -> "out of bounds table access"
  | Table.SizeOverflow -> "table size overflow"
  | Table.SizeLimit -> "table size limit reached"
  | Table.Type -> Crash.error at "type mismatch at table access"
  | exn -> raise exn

let memory_error at = function
  | Memory.Bounds -> "out of bounds memory access"
  | Memory.SizeOverflow -> "memory size overflow"
  | Memory.SizeLimit -> "memory size limit reached"
  | Memory.Type -> Crash.error at "type mismatch at memory access"
  | exn -> raise exn

let numeric_error at = function
  | Ixx.Overflow -> "integer overflow"
  | Ixx.DivideByZero -> "integer divide by zero"
  | Convert.InvalidConversion -> "invalid conversion to integer"
  | Value.TypeError (i, v, t) ->
    Crash.error at
      ("type error, expected " ^ string_of_numtype t ^ " as operand " ^
       string_of_int i ^ ", got " ^ string_of_numtype (type_of_num v))
  | exn -> raise exn


(* Administrative Expressions & Configurations *)

type 'a stack = 'a list

type frame =
{
  inst : moduleinst;
  locals : value option ref list;
}

type code = value stack * admininstr list

and admininstr = admininstr' phrase
and admininstr' =
  | Plain of instr'
  | Refer of ref_
  | Invoke of funcinst
  | Breaking of int32 * value stack
  | Returning of value stack
  | ReturningInvoke of value stack * funcinst
  | Throwing of Tag.t * value stack
  | Trapping of string
  | Label of int * instr list * code
  | Frame of int * frame * code
  | Handler of int * catch list * code

type config =
{
  frame : frame;
  code : code;
  budget : int;  (* to model stack overflow *)
}

let frame inst locals = {inst; locals}
let config inst vs es =
  {frame = frame inst []; code = vs, es; budget = !Flags.budget}

let plain e = Plain e.it @@ e.at

let admininstr_of_value (v : value) at : admininstr' =
  match v with
  | Num n -> Plain (Const (n @@ at))
  | Vec v -> Plain (VecConst (v @@ at))
  | Ref r -> Refer r

let is_jumping e =
  match e.it with
  | Returning _ | ReturningInvoke _ | Breaking _
  | Throwing _ | Trapping _ -> true
  | _ -> false

let lookup category list x =
  try Lib.List32.nth list x.it with Failure _ ->
    Crash.error x.at ("undefined " ^ category ^ " " ^ Int32.to_string x.it)

let type_ (inst : moduleinst) x = lookup "type" inst.types x
let tag (inst : moduleinst) x = lookup "tag" inst.tags x
let global (inst : moduleinst) x = lookup "global" inst.globals x
let memory (inst : moduleinst) x = lookup "memory" inst.memories x
let table (inst : moduleinst) x = lookup "table" inst.tables x
let func (inst : moduleinst) x = lookup "function" inst.funcs x
let data (inst : moduleinst) x = lookup "data segment" inst.datas x
let elem (inst : moduleinst) x = lookup "element segment" inst.elems x
let local (frame : frame) x = lookup "local" frame.locals x

let comp_type (inst : moduleinst) x = expand_deftype (type_ inst x)
let struct_type (inst : moduleinst) x = structtype_of_comptype  (comp_type inst x)
let array_type (inst : moduleinst) x = arraytype_of_comptype (comp_type inst x)
let func_type (inst : moduleinst) x = functype_of_comptype (comp_type inst x)

let subst_of (inst : moduleinst) = function
  | Idx x when x < Lib.List32.length inst.types ->
    Def (type_ inst (x @@ Source.no_region))
  | ut -> ut

let any_ref (inst : moduleinst) x i at =
  try Table.load (table inst x) i with Table.Bounds ->
    Trap.error at ("undefined element " ^ Int64.to_string i)

let func_ref (inst : moduleinst) x i at =
  match any_ref inst x i at with
  | FuncRef f -> f
  | NullRef _ -> Trap.error at ("uninitialized element " ^ Int64.to_string i)
  | _ -> Crash.error at ("type mismatch for element " ^ Int64.to_string i)

let blocktype (inst : moduleinst) bt at =
  match bt with
  | ValBlockType None -> InstrT ([], [], [])
  | ValBlockType (Some t) -> InstrT ([], [subst_valtype (subst_of inst) t], [])
  | VarBlockType x ->
    let FuncT (ts1, ts2) = func_type inst x in InstrT (ts1, ts2, [])

let take n (vs : 'a stack) at =
  try Lib.List.take n vs with Failure _ -> Crash.error at "stack underflow"

let drop n (vs : 'a stack) at =
  try Lib.List.drop n vs with Failure _ -> Crash.error at "stack underflow"

let split n (vs : 'a stack) at = take n vs at, drop n vs at


(* Evaluation *)

(*
 * Conventions:
 *   e  : instr
 *   v  : value
 *   es : instr list
 *   vs : value stack
 *   c : config
 *)

let oob i n j =
  I64.(lt_u (add i n) i || gt_u (add i n) j)

let mem_oob frame x i n =
  oob (addr_of_num i) (addr_of_num n) (Memory.bound (memory frame.inst x))

let data_oob frame x i n =
  oob (addr_of_num i) (addr_of_num n) (Data.size (data frame.inst x))

let table_oob frame x i n =
  oob (addr_of_num i) (addr_of_num n) (Table.size (table frame.inst x))

let elem_oob frame x i n =
  oob (addr_of_num i) (addr_of_num n) (Elem.size (elem frame.inst x))

let array_oob a i n =
  oob (Convert.I64_.extend_i32_u i) (Convert.I64_.extend_i32_u n)
    (Convert.I64_.extend_i32_u (Aggr.array_length a))

let rec step (c : config) : config =
  let vs, es = c.code in
  let e = List.hd es in
  let vs', es' =
    match e.it, vs with
    | Plain e', vs ->
      (match e', vs with
      | Unreachable, vs ->
        vs, [Trapping "unreachable executed" @@ e.at]

      | Nop, vs ->
        vs, []

      | Block (bt, es'), vs ->
        let InstrT (ts1, ts2, _xs) = blocktype c.frame.inst bt e.at in
        let n1 = List.length ts1 in
        let n2 = List.length ts2 in
        let args, vs' = split n1 vs e.at in
        vs', [Label (n2, [], (args, List.map plain es')) @@ e.at]

      | Loop (bt, es'), vs ->
        let InstrT (ts1, ts2, _xs) = blocktype c.frame.inst bt e.at in
        let n1 = List.length ts1 in
        let args, vs' = split n1 vs e.at in
        vs', [Label (n1, [e' @@ e.at], (args, List.map plain es')) @@ e.at]

      | If (bt, es1, es2), Num (I32 i) :: vs' ->
        if i = 0l then
          vs', [Plain (Block (bt, es2)) @@ e.at]
        else
          vs', [Plain (Block (bt, es1)) @@ e.at]

      | Br x, vs ->
        [], [Breaking (x.it, vs) @@ e.at]

      | BrIf x, Num (I32 i) :: vs' ->
        if i = 0l then
          vs', []
        else
          vs', [Plain (Br x) @@ e.at]

      | BrTable (xs, x), Num (I32 i) :: vs' ->
        if I32.ge_u i (Lib.List32.length xs) then
          vs', [Plain (Br x) @@ e.at]
        else
          vs', [Plain (Br (Lib.List32.nth xs i)) @@ e.at]

      | BrOnNull x, Ref (NullRef _) :: vs' ->
        vs', [Plain (Br x) @@ e.at]

      | BrOnNull x, Ref r :: vs' ->
        Ref r :: vs', []

      | BrOnNonNull x, Ref (NullRef _) :: vs' ->
        vs', []

      | BrOnNonNull x, Ref r :: vs' ->
        Ref r :: vs', [Plain (Br x) @@ e.at]

      | BrOnCast (x, _rt1, rt2), Ref r :: vs' ->
        let rt2' = subst_reftype (subst_of c.frame.inst) rt2 in
        if Match.match_reftype [] (type_of_ref r) rt2' then
          Ref r :: vs', [Plain (Br x) @@ e.at]
        else
          Ref r :: vs', []

      | BrOnCastFail (x, _rt1, rt2), Ref r :: vs' ->
        let rt2' = subst_reftype (subst_of c.frame.inst) rt2 in
        if Match.match_reftype [] (type_of_ref r) rt2' then
          Ref r :: vs', []
        else
          Ref r :: vs', [Plain (Br x) @@ e.at]

      | Return, vs ->
        [], [Returning vs @@ e.at]

      | Call x, vs ->
        vs, [Invoke (func c.frame.inst x) @@ e.at]

      | CallRef _x, Ref (NullRef _) :: vs ->
        vs, [Trapping "null function reference" @@ e.at]

      | CallRef _x, Ref (FuncRef f) :: vs ->
        vs, [Invoke f @@ e.at]

      | CallIndirect (x, y), Num i :: vs ->
        let i_64 = addr_of_num i in
        let f = func_ref c.frame.inst x i_64 e.at in
        if Match.match_deftype [] (Func.type_of f) (type_ c.frame.inst y) then
          vs, [Invoke f @@ e.at]
        else
          vs, [Trapping ("indirect call type mismatch, expected " ^
            string_of_deftype (type_ c.frame.inst y) ^ " but got " ^
            string_of_deftype (Func.type_of f)) @@ e.at]

      | ReturnCall x, vs ->
        (match (step {c with code = (vs, [Plain (Call x) @@ e.at])}).code with
        | vs', [{it = Invoke a; at}] -> vs', [ReturningInvoke (vs', a) @@ at]
        | _ -> assert false
        )

      | ReturnCallRef _x, Ref (NullRef _) :: vs ->
        vs, [Trapping "null function reference" @@ e.at]

      | ReturnCallRef x, vs ->
        (match (step {c with code = (vs, [Plain (CallRef x) @@ e.at])}).code with
        | vs', [{it = Invoke a; at}] -> vs', [ReturningInvoke (vs', a) @@ at]
        | vs', [{it = Trapping s; at}] -> vs', [Trapping s @@ at]
        | _ -> assert false
        )

      | ReturnCallIndirect (x, y), vs ->
        (match
          (step {c with code = (vs, [Plain (CallIndirect (x, y)) @@ e.at])}).code
        with
        | vs', [{it = Invoke a; at}] -> vs', [ReturningInvoke (vs', a) @@ at]
        | vs', [{it = Trapping s; at}] -> vs', [Trapping s @@ at]
        | _ -> assert false
        )

      | Throw x, vs ->
        let t = tag c.frame.inst x in
        let TagT ut = Tag.type_of t in
        let dt = deftype_of_typeuse ut in
        let FuncT (ts, _) = functype_of_comptype (expand_deftype dt) in
        let n = List.length ts in
        let args, vs' = split n vs e.at in
        vs', [Throwing (t, args) @@ e.at]

      | ThrowRef, Ref (NullRef _) :: vs ->
        vs, [Trapping "null exception reference" @@ e.at]

      | ThrowRef, Ref (Exn.(ExnRef (Exn (t, args)))) :: vs ->
        vs, [Throwing (t, args) @@ e.at]

      | TryTable (bt, cs, es'), vs ->
        let InstrT (ts1, ts2, _xs) = blocktype c.frame.inst bt e.at in
        let n1 = List.length ts1 in
        let n2 = List.length ts2 in
        let args, vs' = split n1 vs e.at in
        vs', [Handler (n2, cs, ([], [Label (n2, [], (args, List.map plain es')) @@ e.at])) @@ e.at]

      | Drop, v :: vs' ->
        vs', []

      | Select _, Num (I32 i) :: v2 :: v1 :: vs' ->
        if i = 0l then
          v2 :: vs', []
        else
          v1 :: vs', []

      | LocalGet x, vs ->
        (match !(local c.frame x) with
        | Some v ->
          v :: vs, []
        | None ->
          Crash.error e.at "read of uninitialized local"
        )

      | LocalSet x, v :: vs' ->
        local c.frame x := Some v;
        vs', []

      | LocalTee x, v :: vs' ->
        local c.frame x := Some v;
        v :: vs', []

      | GlobalGet x, vs ->
        Global.load (global c.frame.inst x) :: vs, []

      | GlobalSet x, v :: vs' ->
        (try Global.store (global c.frame.inst x) v; vs', []
        with Global.NotMutable -> Crash.error e.at "write to immutable global"
           | Global.Type -> Crash.error e.at "type mismatch at global write")

      | TableGet x, Num i :: vs' ->
        let i_64 = addr_of_num i in
        (try Ref (Table.load (table c.frame.inst x) i_64) :: vs', []
        with exn -> vs', [Trapping (table_error e.at exn) @@ e.at])

      | TableSet x, Ref r :: Num i :: vs' ->
        let i_64 = addr_of_num i in
        (try Table.store (table c.frame.inst x) i_64 r; vs', []
        with exn -> vs', [Trapping (table_error e.at exn) @@ e.at])

      | TableSize x, vs ->
        let tab = table c.frame.inst x in
        Num (num_of_addr (Table.addrtype_of tab) (Table.size tab)) :: vs, []

      | TableGrow x, Num n :: Ref r :: vs' ->
        let n_64 = addr_of_num n in
        let tab = table c.frame.inst x in
        let old_size = Table.size tab in
        let result =
          try Table.grow tab n_64 r; old_size
          with Table.SizeOverflow | Table.SizeLimit | Table.OutOfMemory -> -1L
        in Num (num_of_addr (Table.addrtype_of tab) result) :: vs', []

      | TableFill x, Num n :: Ref r :: Num i :: vs' ->
        let n_64 = addr_of_num n in
        let i_64 = addr_of_num i in
        if table_oob c.frame x i n then
          vs', [Trapping (table_error e.at Table.Bounds) @@ e.at]
        else if n_64 = 0L then
          vs', []
        else
          let _ = assert (I64.lt_u i_64 0xffff_ffff_ffff_ffffL) in
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Plain (Const (i @@ e.at));
            Refer r;
            Plain (TableSet x);
            Plain (Const (addr_add i 1L @@ e.at));
            Refer r;
            Plain (Const (addr_sub n 1L @@ e.at));
            Plain (TableFill x);
          ]

      | TableCopy (x, y), Num n :: Num s :: Num d :: vs' ->
        let n_64 = addr_of_num n in
        let s_64 = addr_of_num s in
        let d_64 = addr_of_num d in
        if table_oob c.frame x d n || table_oob c.frame y s n then
          vs', [Trapping (table_error e.at Table.Bounds) @@ e.at]
        else if n_64 = 0L then
          vs', []
        else if I64.le_u d_64 s_64 then
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Plain (Const (d @@ e.at));
            Plain (Const (s @@ e.at));
            Plain (TableGet y);
            Plain (TableSet x);
            Plain (Const (addr_add d 1L @@ e.at));
            Plain (Const (addr_add s 1L @@ e.at));
            Plain (Const (addr_sub n 1L @@ e.at));
            Plain (TableCopy (x, y));
          ]
        else (* d > s *)
          let n' = I64.sub n_64 1L in
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Plain (Const (addr_add d n' @@ e.at));
            Plain (Const (addr_add s n' @@ e.at));
            Plain (TableGet y);
            Plain (TableSet x);
            Plain (Const (d @@ e.at));
            Plain (Const (s @@ e.at));
            Plain (Const (addr_sub n 1L @@ e.at));
            Plain (TableCopy (x, y));
          ]

      | TableInit (x, y), Num n :: Num s :: Num d :: vs' ->
        let n_64 = addr_of_num n in
        let s_64 = addr_of_num s in
        if table_oob c.frame x d n || elem_oob c.frame y s n then
          vs', [Trapping (table_error e.at Table.Bounds) @@ e.at]
        else if n_64 = 0L then
          vs', []
        else
          let seg = elem c.frame.inst y in
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Plain (Const (d @@ e.at));
            Refer (Elem.load seg s_64);
            Plain (TableSet x);
            Plain (Const (addr_add d 1L @@ e.at));
            Plain (Const (addr_add s 1L @@ e.at));
            Plain (Const (addr_sub n 1L @@ e.at));
            Plain (TableInit (x, y));
          ]

      | ElemDrop x, vs ->
        let seg = elem c.frame.inst x in
        Elem.drop seg;
        vs, []

      | Load (x, {offset; ty; pack; _}), Num i :: vs' ->
        let i_64 = addr_of_num i in
        let mem = memory c.frame.inst x in
        (try
          let n =
            match pack with
            | None -> Memory.load_num mem i_64 offset ty
            | Some (sz, ext) -> Memory.load_num_packed sz ext mem i_64 offset ty
          in Num n :: vs', []
        with exn -> vs', [Trapping (memory_error e.at exn) @@ e.at])

      | Store (x, {offset; pack; _}), Num n :: Num i :: vs' ->
        let i_64 = addr_of_num i in
        let mem = memory c.frame.inst x in
        (try
          (match pack with
          | None -> Memory.store_num mem i_64 offset n
          | Some sz -> Memory.store_num_packed sz mem i_64 offset n
          );
          vs', []
        with exn -> vs', [Trapping (memory_error e.at exn) @@ e.at]);

      | VecLoad (x, {offset; ty; pack; _}), Num i :: vs' ->
        let i_64 = addr_of_num i in
        let mem = memory c.frame.inst x in
        (try
          let v =
            match pack with
            | None -> Memory.load_vec mem i_64 offset ty
            | Some (sz, ext) -> Memory.load_vec_packed sz ext mem i_64 offset ty
          in Vec v :: vs', []
        with exn -> vs', [Trapping (memory_error e.at exn) @@ e.at])

      | VecStore (x, {offset; _}), Vec v :: Num i :: vs' ->
        let i_64 = addr_of_num i in
        let mem = memory c.frame.inst x in
        (try
          Memory.store_vec mem i_64 offset v;
          vs', []
        with exn -> vs', [Trapping (memory_error e.at exn) @@ e.at]);

      | VecLoadLane (x, {offset; ty; pack; _}, j), Vec (V128 v) :: Num i :: vs' ->
        let i_64 = addr_of_num i in
        let mem = memory c.frame.inst x in
        (try
          let v =
            match pack with
            | Pack8 ->
              V128.I8x16.replace_lane j v
                (I32Num.of_num 0 (Memory.load_num_packed Pack8 S mem i_64 offset I32T))
            | Pack16 ->
              V128.I16x8.replace_lane j v
                (I32Num.of_num 0 (Memory.load_num_packed Pack16 S mem i_64 offset I32T))
            | Pack32 ->
              V128.I32x4.replace_lane j v
                (I32Num.of_num 0 (Memory.load_num mem i_64 offset I32T))
            | Pack64 ->
              V128.I64x2.replace_lane j v
                (I64Num.of_num 0 (Memory.load_num mem i_64 offset I64T))
          in Vec (V128 v) :: vs', []
        with exn -> vs', [Trapping (memory_error e.at exn) @@ e.at])

      | VecStoreLane (x, {offset; ty; pack; _}, j), Vec (V128 v) :: Num i :: vs' ->
        let i_64 = addr_of_num i in
        let mem = memory c.frame.inst x in
        (try
          (match pack with
          | Pack8 ->
            Memory.store_num_packed Pack8 mem i_64 offset (I32 (V128.I8x16.extract_lane_s j v))
          | Pack16 ->
            Memory.store_num_packed Pack16 mem i_64 offset (I32 (V128.I16x8.extract_lane_s j v))
          | Pack32 ->
            Memory.store_num mem i_64 offset (I32 (V128.I32x4.extract_lane_s j v))
          | Pack64 ->
            Memory.store_num mem i_64 offset (I64 (V128.I64x2.extract_lane_s j v))
          );
          vs', []
        with exn -> vs', [Trapping (memory_error e.at exn) @@ e.at])

      | MemorySize x, vs ->
        let mem = memory c.frame.inst x in
        Num (num_of_addr (Memory.addrtype_of mem) (Memory.size mem)) :: vs, []

      | MemoryGrow x, Num n :: vs' ->
        let n_64 = addr_of_num n in
        let mem = memory c.frame.inst x in
        let old_size = Memory.size mem in
        let result =
          try Memory.grow mem n_64; old_size
          with Memory.SizeOverflow | Memory.SizeLimit | Memory.OutOfMemory -> -1L
        in Num (num_of_addr (Memory.addrtype_of mem) result) :: vs', []

      | MemoryFill x, Num n :: Num k :: Num i :: vs' ->
        let n_64 = addr_of_num n in
        if mem_oob c.frame x i n then
          vs', [Trapping (memory_error e.at Memory.Bounds) @@ e.at]
        else if n_64 = 0L then
          vs', []
        else
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Plain (Const (i @@ e.at));
            Plain (Const (k @@ e.at));
            Plain (Store
              (x, {ty = I32T; align = 0; offset = 0L; pack = Some Pack8}));
            Plain (Const (addr_add i 1L @@ e.at));
            Plain (Const (k @@ e.at));
            Plain (Const (addr_sub n 1L @@ e.at));
            Plain (MemoryFill x);
          ]

      | MemoryCopy (x, y), Num n :: Num s :: Num d :: vs' ->
        let n_64 = addr_of_num n in
        let s_64 = addr_of_num s in
        let d_64 = addr_of_num d in
        if mem_oob c.frame x d n || mem_oob c.frame y s n then
          vs', [Trapping (memory_error e.at Memory.Bounds) @@ e.at]
        else if n_64 = 0L then
          vs', []
        else if I64.le_u d_64 s_64 then
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Plain (Const (d @@ e.at));
            Plain (Const (s @@ e.at));
            Plain (Load
              (y, {ty = I32T; align = 0; offset = 0L; pack = Some (Pack8, U)}));
            Plain (Store
              (x, {ty = I32T; align = 0; offset = 0L; pack = Some Pack8}));
            Plain (Const (addr_add d 1L @@ e.at));
            Plain (Const (addr_add s 1L @@ e.at));
            Plain (Const (addr_sub n 1L @@ e.at));
            Plain (MemoryCopy (x, y));
          ]
        else (* d > s *)
          let n' = I64.sub n_64 1L in
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Plain (Const (addr_add d n' @@ e.at));
            Plain (Const (addr_add s n' @@ e.at));
            Plain (Load
              (y, {ty = I32T; align = 0; offset = 0L; pack = Some (Pack8, U)}));
            Plain (Store
              (x, {ty = I32T; align = 0; offset = 0L; pack = Some Pack8}));
            Plain (Const (d @@ e.at));
            Plain (Const (s @@ e.at));
            Plain (Const (addr_sub n 1L @@ e.at));
            Plain (MemoryCopy (x, y));
          ]

      | MemoryInit (x, y), Num n :: Num s :: Num d :: vs' ->
        let n_64 = addr_of_num n in
        let s_64 = addr_of_num s in
        if mem_oob c.frame x d n || data_oob c.frame y s n then
          vs', [Trapping (memory_error e.at Memory.Bounds) @@ e.at]
        else if n_64 = 0L then
          vs', []
        else
          let seg = data c.frame.inst y in
          let b = Data.load_byte seg s_64 in
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Plain (Const (d @@ e.at));
            Plain (Const (I32 (I32.of_int_u (Char.code b)) @@ e.at));
            Plain (Store
              (x, {ty = I64T; align = 0; offset = 0L; pack = Some Pack8}));
            Plain (Const (addr_add d 1L @@ e.at));
            Plain (Const (addr_add s 1L @@ e.at));
            Plain (Const (addr_sub n 1L @@ e.at));
            Plain (MemoryInit (x, y));
          ]

      | DataDrop x, vs ->
        let seg = data c.frame.inst x in
        Data.drop seg;
        vs, []

      | RefNull t, vs' ->
        Ref (NullRef (subst_heaptype (subst_of c.frame.inst) t)) :: vs', []

      | RefFunc x, vs' ->
        let f = func c.frame.inst x in
        Ref (FuncRef f) :: vs', []

      | RefIsNull, Ref (NullRef _) :: vs' ->
        value_of_bool true :: vs', []

      | RefIsNull, Ref _ :: vs' ->
        value_of_bool false :: vs', []

      | RefAsNonNull, Ref (NullRef _) :: vs' ->
        vs', [Trapping "null reference" @@ e.at]

      | RefAsNonNull, Ref r :: vs' ->
        Ref r :: vs', []

      | RefTest rt, Ref r :: vs' ->
        let rt' = subst_reftype (subst_of c.frame.inst) rt in
        value_of_bool (Match.match_reftype [] (type_of_ref r) rt') :: vs', []

      | RefCast rt, Ref r :: vs' ->
        let rt' = subst_reftype (subst_of c.frame.inst) rt in
        if Match.match_reftype [] (type_of_ref r) rt' then
          Ref r :: vs', []
        else
          vs', [Trapping ("cast failure, expected " ^
            string_of_reftype rt ^ " but got " ^
            string_of_reftype (type_of_ref r)) @@ e.at]

      | RefEq, Ref r1 :: Ref r2 :: vs' ->
        value_of_bool (eq_ref r1 r2) :: vs', []

      | RefI31, Num (I32 i) :: vs' ->
        Ref (I31.I31Ref (I31.of_i32 i)) :: vs', []

      | I31Get ext, Ref (NullRef _) :: vs' ->
        vs', [Trapping "null i31 reference" @@ e.at]

      | I31Get ext, Ref (I31.I31Ref i) :: vs' ->
        Num (I32 (I31.to_i32 ext i)) :: vs', []

      | StructNew (x, initop), vs' ->
        let StructT fts = struct_type c.frame.inst x in
        let args, vs'' =
          match initop with
          | Explicit ->
            let args, vs'' = split (List.length fts) vs' e.at in
            List.rev args, vs''
          | Implicit ->
            let ts = List.map unpacked_fieldtype fts in
            try List.map Option.get (List.map default_value ts), vs'
            with Invalid_argument _ -> Crash.error e.at "non-defaultable type"
        in
        let struct_ =
          try Aggr.alloc_struct (type_ c.frame.inst x) args
          with Failure _ -> Crash.error e.at "type mismatch packing value"
        in Ref (Aggr.StructRef struct_) :: vs'', []

      | StructGet (x, y, exto), Ref (NullRef _) :: vs' ->
        vs', [Trapping "null structure reference" @@ e.at]

      | StructGet (x, y, exto), Ref Aggr.(StructRef (Struct (_, fs))) :: vs' ->
        let f =
          try Lib.List32.nth fs y.it
          with Failure _ -> Crash.error y.at "undefined field"
        in
        (try Aggr.read_field f exto :: vs', []
        with Failure _ -> Crash.error e.at "type mismatch reading field")

      | StructSet (x, y), v :: Ref (NullRef _) :: vs' ->
        vs', [Trapping "null structure reference" @@ e.at]

      | StructSet (x, y), v :: Ref Aggr.(StructRef (Struct (_, fs))) :: vs' ->
        let f =
          try Lib.List32.nth fs y.it
          with Failure _ -> Crash.error y.at "undefined field"
        in
        (try Aggr.write_field f v; vs', []
        with Failure _ -> Crash.error e.at "type mismatch writing field")

      | ArrayNew (x, initop), Num (I32 n) :: vs' ->
        let ArrayT (FieldT (_mut, st)) = array_type c.frame.inst x in
        let arg, vs'' =
          match initop with
          | Explicit -> List.hd vs', List.tl vs'
          | Implicit ->
            try Option.get (default_value (unpacked_storagetype st)), vs'
            with Invalid_argument _ -> Crash.error e.at "non-defaultable type"
        in
        let array =
          try Aggr.alloc_array (type_ c.frame.inst x) (Lib.List32.make n arg)
          with Failure _ -> Crash.error e.at "type mismatch packing value"
        in Ref (Aggr.ArrayRef array) :: vs'', []

      | ArrayNewFixed (x, n), vs' ->
        let args, vs'' = split (I32.to_int_u n) vs' e.at in
        let array =
          try Aggr.alloc_array (type_ c.frame.inst x) (List.rev args)
          with Failure _ -> Crash.error e.at "type mismatch packing value"
        in Ref (Aggr.ArrayRef array) :: vs'', []

      | ArrayNewElem (x, y), Num n :: Num s :: vs' ->
        let n_64 = addr_of_num n in
        let s_64 = addr_of_num s in
        if elem_oob c.frame y s n then
          vs', [Trapping (table_error e.at Table.Bounds) @@ e.at]
        else
          let seg = elem c.frame.inst y in
          let rs = Lib.List64.init n_64
            (fun i -> Elem.load seg (Int64.add s_64 i)) in
          let args = List.map (fun r -> Ref r) rs in
          let array =
            try Aggr.alloc_array (type_ c.frame.inst x) args
            with Failure _ -> Crash.error e.at "type mismatch packing value"
          in Ref (Aggr.ArrayRef array) :: vs', []

      | ArrayNewData (x, y), Num n :: Num s :: vs' ->
        let n_64 = addr_of_num n in
        let s_64 = addr_of_num s in
        let ArrayT (FieldT (_mut, st)) = array_type c.frame.inst x in
        let m_64 = I64.mul n_64 (I64.of_int_u (storage_size st)) in
        if data_oob c.frame y s (I64 m_64) then
          vs', [Trapping (memory_error e.at Memory.Bounds) @@ e.at]
        else
          let seg = data c.frame.inst y in
          let args = Lib.List64.init n_64
            (fun i ->
              let a = I64.(add s_64 (mul i (I64.of_int_u (storage_size st)))) in
              Data.load_val_storage seg a st
            )
          in
          let array =
            try Aggr.alloc_array (type_ c.frame.inst x) args
            with Failure _ -> Crash.error e.at "type mismatch packing value"
          in Ref (Aggr.ArrayRef array) :: vs', []

      | ArrayGet (x, exto), Num (I32 i) :: Ref (NullRef _) :: vs' ->
        vs', [Trapping "null array reference" @@ e.at]

      | ArrayGet (x, exto), Num (I32 i) :: Ref (Aggr.ArrayRef a) :: vs'
        when array_oob a i 1l ->
        vs', [Trapping "out of bounds array access" @@ e.at]

      | ArrayGet (x, exto), Num (I32 i) :: Ref Aggr.(ArrayRef (Array (_, fs))) :: vs' ->
        (try Aggr.read_field (Lib.List32.nth fs i) exto :: vs', []
        with Failure _ -> Crash.error e.at "type mismatch reading array")

      | ArraySet x, v :: Num (I32 i) :: Ref (NullRef _) :: vs' ->
        vs', [Trapping "null array reference" @@ e.at]

      | ArraySet x, v :: Num (I32 i) :: Ref (Aggr.ArrayRef a) :: vs'
        when array_oob a i 1l ->
        vs', [Trapping "out of bounds array access" @@ e.at]

      | ArraySet x, v :: Num (I32 i) :: Ref Aggr.(ArrayRef (Array (_, fs))) :: vs' ->
        (try Aggr.write_field (Lib.List32.nth fs i) v; vs', []
        with Failure _ -> Crash.error e.at "type mismatch writing array")

      | ArrayLen, Ref (NullRef _) :: vs' ->
        vs', [Trapping "null array reference" @@ e.at]

      | ArrayLen, Ref Aggr.(ArrayRef (Array (_, fs))) :: vs' ->
        Num (I32 (Lib.List32.length fs)) :: vs', []

      | ArrayCopy (x, y),
        Num _ :: Num _ :: Ref (NullRef _) :: Num _ :: Ref _ :: vs' ->
        vs', [Trapping "null array reference" @@ e.at]

      | ArrayCopy (x, y),
        Num _ :: Num _ :: Ref _ :: Num _ :: Ref (NullRef _) :: vs' ->
        vs', [Trapping "null array reference" @@ e.at]

      | ArrayCopy (x, y),
        Num (I32 n) ::
          Num (I32 s) :: Ref (Aggr.ArrayRef sa) ::
          Num (I32 d) :: Ref (Aggr.ArrayRef da) :: vs' ->
        if array_oob sa s n || array_oob da d n then
          vs', [Trapping "out of bounds array access" @@ e.at]
        else if n = 0l then
          vs', []
        else
        let exto =
          match arraytype_of_comptype (expand_deftype (Aggr.type_of_array sa)) with
          | ArrayT (FieldT (_, PackStorageT _)) -> Some U
          | _ -> None
        in
        if I32.le_u d s then
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Refer (Aggr.ArrayRef da);
            Plain (Const (I32 d @@ e.at));
            Refer (Aggr.ArrayRef sa);
            Plain (Const (I32 s @@ e.at));
            Plain (ArrayGet (y, exto));
            Plain (ArraySet x);
            Refer (Aggr.ArrayRef da);
            Plain (Const (I32 (I32.add d 1l) @@ e.at));
            Refer (Aggr.ArrayRef sa);
            Plain (Const (I32 (I32.add s 1l) @@ e.at));
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (ArrayCopy (x, y));
          ]
        else (* d > s *)
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Refer (Aggr.ArrayRef da);
            Plain (Const (I32 (I32.add d 1l) @@ e.at));
            Refer (Aggr.ArrayRef sa);
            Plain (Const (I32 (I32.add s 1l) @@ e.at));
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (ArrayCopy (x, y));
            Refer (Aggr.ArrayRef da);
            Plain (Const (I32 d @@ e.at));
            Refer (Aggr.ArrayRef sa);
            Plain (Const (I32 s @@ e.at));
            Plain (ArrayGet (y, exto));
            Plain (ArraySet x);
          ]

      | ArrayFill x, Num (I32 n) :: v :: Num (I32 i) :: Ref (NullRef _) :: vs' ->
        vs', [Trapping "null array reference" @@ e.at]

      | ArrayFill x, Num (I32 n) :: v :: Num (I32 i) :: Ref (Aggr.ArrayRef a) :: vs' ->
        if array_oob a i n then
          vs', [Trapping "out of bounds array access" @@ e.at]
        else if n = 0l then
          vs', []
        else
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Refer (Aggr.ArrayRef a);
            Plain (Const (I32 i @@ e.at));
            admininstr_of_value v e.at;
            Plain (ArraySet x);
            Refer (Aggr.ArrayRef a);
            Plain (Const (I32 (I32.add i 1l) @@ e.at));
            admininstr_of_value v e.at;
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (ArrayFill x);
          ]

      | ArrayInitData (x, y),
        Num _ :: Num _ :: Num _ :: Ref (NullRef _) :: vs' ->
        vs', [Trapping "null array reference" @@ e.at]

      | ArrayInitData (x, y),
        Num (I32 n) :: Num s :: Num (I32 d) :: Ref (Aggr.ArrayRef a) :: vs' ->
        let s_64 = addr_of_num s in
        let n_64 = Convert.I64_.extend_i32_u n in
        let ArrayT (FieldT (_mut, st)) = array_type c.frame.inst x in
        let m_64 = I64.mul n_64 (I64.of_int_u (storage_size st)) in
        if array_oob a d n then
          vs', [Trapping "out of bounds array access" @@ e.at]
        else if data_oob c.frame y s (I64 m_64) then
          vs', [Trapping (memory_error e.at Memory.Bounds) @@ e.at]
        else if n = 0l then
          vs', []
        else
          let seg = data c.frame.inst y in
          let v = Data.load_val_storage seg s_64 st in
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Refer (Aggr.ArrayRef a);
            Plain (Const (I32 d @@ e.at));
            admininstr_of_value v e.at;
            Plain (ArraySet x);
            Refer (Aggr.ArrayRef a);
            Plain (Const (I32 (I32.add d 1l) @@ e.at));
            Plain (Const (addr_add s (I64.of_int_u (storage_size st)) @@ e.at));
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (ArrayInitData (x, y));
          ]

      | ArrayInitElem (x, y),
        Num _ :: Num _ :: Num _ :: Ref (NullRef _) :: vs' ->
        vs', [Trapping "null array reference" @@ e.at]

      | ArrayInitElem (x, y),
        Num (I32 n) :: Num s :: Num (I32 d) :: Ref (Aggr.ArrayRef a) :: vs' ->
        let s_64 = addr_of_num s in
        if array_oob a d n then
          vs', [Trapping "out of bounds array access" @@ e.at]
        else if elem_oob c.frame y s (I64 (Convert.I64_.extend_i32_u n)) then
          vs', [Trapping (table_error e.at Table.Bounds) @@ e.at]
        else if n = 0l then
          vs', []
        else
          let seg = elem c.frame.inst y in
          let v = Ref (Elem.load seg s_64) in
          vs', List.map (Lib.Fun.flip (@@) e.at) [
            Refer (Aggr.ArrayRef a);
            Plain (Const (I32 d @@ e.at));
            admininstr_of_value v e.at;
            Plain (ArraySet x);
            Refer (Aggr.ArrayRef a);
            Plain (Const (I32 (I32.add d 1l) @@ e.at));
            Plain (Const (addr_add s 1L @@ e.at));
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (ArrayInitElem (x, y));
          ]

      | ExternConvert Internalize, Ref (NullRef _) :: vs' ->
        Ref (NullRef NoneHT) :: vs', []

      | ExternConvert Internalize, Ref (Extern.ExternRef r) :: vs' ->
        Ref r :: vs', []

      | ExternConvert Externalize, Ref (NullRef _) :: vs' ->
        Ref (NullRef NoExternHT) :: vs', []

      | ExternConvert Externalize, Ref r :: vs' ->
        Ref (Extern.ExternRef r) :: vs', []

      | Const n, vs ->
        Num n.it :: vs, []

      | Test testop, Num n :: vs' ->
        (try value_of_bool (Eval_num.eval_testop testop n) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | Compare relop, Num n2 :: Num n1 :: vs' ->
        (try value_of_bool (Eval_num.eval_relop relop n1 n2) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | Unary unop, Num n :: vs' ->
        (try Num (Eval_num.eval_unop unop n) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | Binary binop, Num n2 :: Num n1 :: vs' ->
        (try Num (Eval_num.eval_binop binop n1 n2) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | Convert cvtop, Num n :: vs' ->
        (try Num (Eval_num.eval_cvtop cvtop n) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecConst v, vs ->
        Vec v.it :: vs, []

      | VecTest testop, Vec n :: vs' ->
        (try value_of_bool (Eval_vec.eval_vtestop testop n) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecUnary unop, Vec n :: vs' ->
        (try Vec (Eval_vec.eval_vunop unop n) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecBinary binop, Vec n2 :: Vec n1 :: vs' ->
        (try Vec (Eval_vec.eval_vbinop binop n1 n2) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecTernary ternop, Vec v3 :: Vec v2 :: Vec v1 :: vs' ->
        (try Vec (Eval_vec.eval_vternop ternop v1 v2 v3) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecCompare relop, Vec n2 :: Vec n1 :: vs' ->
        (try Vec (Eval_vec.eval_vrelop relop n1 n2) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecConvert cvtop, Vec n :: vs' ->
        (try Vec (Eval_vec.eval_vcvtop cvtop n) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecShift shiftop, Num s :: Vec v :: vs' ->
        (try Vec (Eval_vec.eval_vshiftop shiftop v s) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecBitmask bitmaskop, Vec v :: vs' ->
        (try Num (Eval_vec.eval_vbitmaskop bitmaskop v) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecTestBits vtestop, Vec n :: vs' ->
        (try value_of_bool (Eval_vec.eval_vvtestop vtestop n) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecUnaryBits vunop, Vec n :: vs' ->
        (try Vec (Eval_vec.eval_vvunop vunop n) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecBinaryBits vbinop, Vec n2 :: Vec n1 :: vs' ->
        (try Vec (Eval_vec.eval_vvbinop vbinop n1 n2) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecTernaryBits vternop, Vec v3 :: Vec v2 :: Vec v1 :: vs' ->
        (try Vec (Eval_vec.eval_vvternop vternop v1 v2 v3) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecSplat splatop, Num n :: vs' ->
        (try Vec (Eval_vec.eval_vsplatop splatop n) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecExtract extractop, Vec v :: vs' ->
        (try Num (Eval_vec.eval_vextractop extractop v) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | VecReplace replaceop, Num r :: Vec v :: vs' ->
        (try Vec (Eval_vec.eval_vreplaceop replaceop v r) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | _ ->
        let s1 = string_of_values (List.rev vs) in
        let s2 = string_of_resulttype (List.map type_of_value (List.rev vs)) in
        Crash.error e.at
          ("missing or ill-typed operand on stack (" ^ s1 ^ " : " ^ s2 ^ ")")
      )

    | Refer r, vs ->
      Ref r :: vs, []

    | Trapping _, vs ->
      assert false

    | Returning _, vs
    | ReturningInvoke _, vs ->
      Crash.error e.at "undefined frame"

    | Breaking _, vs ->
      Crash.error e.at "undefined label"

    | Throwing _, _ ->
      assert false

    | Label (n, es0, (vs', [])), vs ->
      vs' @ vs, []

    | Label (n, es0, (vs', {it = Breaking (0l, vs0); at} :: es')), vs ->
      take n vs0 e.at @ vs, List.map plain es0

    | Label (n, es0, (vs', {it = Breaking (k, vs0); at} :: es')), vs ->
      vs, [Breaking (Int32.sub k 1l, vs0) @@ at]

    | Label (n, es0, (vs', e' :: es')), vs when is_jumping e' ->
      vs, [e']

    | Label (n, es0, code'), vs ->
      let c' = step {c with code = code'} in
      vs, [Label (n, es0, c'.code) @@ e.at]

    | Frame (n, frame', (vs', [])), vs ->
      vs' @ vs, []

    | Frame (n, frame', (vs', {it = Returning vs0; at} :: es')), vs ->
      take n vs0 e.at @ vs, []

    | Frame (n, frame', (vs', {it = ReturningInvoke (vs0, f); at} :: es')), vs ->
      let FuncT (ts1, _ts2) = functype_of_comptype (expand_deftype (Func.type_of f)) in
      take (List.length ts1) vs0 e.at @ vs, [Invoke f @@ at]

    | Frame (n, frame', (vs', e' :: es')), vs when is_jumping e' ->
      vs, [e']

    | Frame (n, frame', code'), vs ->
      let c' = step {frame = frame'; code = code'; budget = c.budget - 1} in
      vs, [Frame (n, frame', c'.code) @@ e.at]

    | Handler (n, cs, (vs', [])), vs ->
      vs' @ vs, []

    | Handler (n, {it = Catch (x1, x2); _} :: cs, (vs', {it = Throwing (a, vs0); at} :: es')), vs ->
      if a == tag c.frame.inst x1 then
        vs0 @ vs, [Plain (Br x2) @@ e.at]
      else
        vs, [Handler (n, cs, (vs', {it = Throwing (a, vs0); at} :: es')) @@ e.at]

    | Handler (n, {it = CatchRef (x1, x2); _} :: cs, (vs', {it = Throwing (a, vs0); at} :: es')), vs ->
      if a == tag c.frame.inst x1 then
        Ref Exn.(ExnRef (Exn (a, vs0))) :: vs0 @ vs, [Plain (Br x2) @@ e.at]
      else
        vs, [Handler (n, cs, (vs', {it = Throwing (a, vs0); at} :: es')) @@ e.at]

    | Handler (n, {it = CatchAll x; _} :: cs, (vs', {it = Throwing (a, vs0); at} :: es')), vs ->
      vs, [Plain (Br x) @@ e.at]

    | Handler (n, {it = CatchAllRef x; _} :: cs, (vs', {it = Throwing (a, vs0); at} :: es')), vs ->
      Ref Exn.(ExnRef (Exn (a, vs0))) :: vs, [Plain (Br x) @@ e.at]

    | Handler (n, [], (vs', {it = Throwing (a, vs0); at} :: es')), vs ->
      vs, [Throwing (a, vs0) @@ at]

    | Handler (n, cs, (vs', e' :: es')), vs when is_jumping e' ->
      vs, [e']

    | Handler (n, cs, code'), vs ->
      let c' = step {c with code = code'} in
      vs, [Handler (n, cs, c'.code) @@ e.at]

    | Invoke f, vs when c.budget = 0 ->
      Exhaustion.error e.at "call stack exhausted"

    | Invoke f, vs ->
      let FuncT (ts1, ts2) = functype_of_comptype (expand_deftype (Func.type_of f)) in
      let n1, n2 = List.length ts1, List.length ts2 in
      let args, vs' = split n1 vs e.at in
      (match f with
      | Func.AstFunc (_, inst', func) ->
        let Func (_x, ls, es) = func.it in
        let m = Lib.Promise.value inst' in
        let s = subst_of m in
        let ts = List.map (fun {it = Local t; _} -> subst_valtype s t) ls in
        let lvs = List.(rev (map Option.some args) @ map default_value ts) in
        let frame' = {inst = m; locals = List.map ref lvs} in
        let instr' = [Label (n2, [], ([], List.map plain es)) @@ func.at] in
        vs', [Frame (n2, frame', ([], instr')) @@ e.at]

      | Func.HostFunc (_, f) ->
        (try List.rev (f (List.rev args)) @ vs', []
        with Crash (_, msg) -> Crash.error e.at msg)
      )
  in {c with code = vs', es' @ List.tl es}


let rec eval (c : config) : value stack =
  match c.code with
  | vs, [] ->
    vs

  | vs, {it = Trapping msg; at} :: _ ->
    Trap.error at msg

  | vs, {it = Throwing (a, args); at} :: _ ->
    let msg = "uncaught exception with args (" ^ string_of_values args ^ ")" in
    Exception.error at msg

  | vs, es ->
    eval (step c)


(* Functions & Constants *)

let at_func = function
 | Func.AstFunc (_, _, f) -> f.at
 | Func.HostFunc _ -> no_region

let invoke (func : funcinst) (vs : value list) : value list =
  let at = at_func func in
  let FuncT (ts1, _ts2) = functype_of_comptype (expand_deftype (Func.type_of func)) in
  if List.length vs <> List.length ts1 then
    Crash.error at "wrong number of arguments";
  if not (List.for_all2 (fun v -> Match.match_valtype [] (type_of_value v)) vs ts1) then
    Crash.error at "wrong types of arguments";
  let c = config empty_moduleinst (List.rev vs) [Invoke func @@ at] in
  try List.rev (eval c) with Stack_overflow ->
    Exhaustion.error at "call stack exhausted"

let eval_const (inst : moduleinst) (const : const) : value =
  let c = config inst [] (List.map plain const.it) in
  match eval c with
  | [v] -> v
  | vs -> Crash.error const.at "wrong number of results on stack"

(* Modules *)

let init_type (inst : moduleinst) (type_ : type_) : moduleinst =
  let rt = subst_rectype (subst_of inst) type_.it in
  let x = Lib.List32.length inst.types in
  {inst with types = inst.types @ roll_deftypes x rt}

let init_import (inst : moduleinst) (ex : extern) (im : import) : moduleinst =
  let Import (module_name, item_name, xt) = im.it in
  let xt = subst_externtype (subst_of inst) xt in
  let xt' = externtype_of inst.types ex in
  if not (Match.match_externtype [] xt' xt) then
    Link.error im.at ("incompatible import type for " ^
      "\"" ^ Utf8.encode module_name ^ "\" " ^
      "\"" ^ Utf8.encode item_name ^ "\": " ^
      "expected " ^ Types.string_of_externtype xt ^
      ", got " ^ Types.string_of_externtype xt');
  match ex with
  | ExternTag tag -> {inst with tags = inst.tags @ [tag]}
  | ExternGlobal glob -> {inst with globals = inst.globals @ [glob]}
  | ExternMemory mem -> {inst with memories = inst.memories @ [mem]}
  | ExternTable tab -> {inst with tables = inst.tables @ [tab]}
  | ExternFunc func -> {inst with funcs = inst.funcs @ [func]}

let init_tag (inst : moduleinst) (tag : tag) : moduleinst =
  let Tag tt = tag.it in
  let tt' = subst_tagtype (subst_of inst) tt in
  let tag = Tag.alloc tt' in
  {inst with tags = inst.tags @ [tag]}

let init_global (inst : moduleinst) (glob : global) : moduleinst =
  let Global (gt, c) = glob.it in
  let gt' = subst_globaltype (subst_of inst) gt in
  let v = eval_const inst c in
  let glob = Global.alloc gt' v in
  {inst with globals = inst.globals @ [glob]}

let init_memory (inst : moduleinst) (mem : memory) : moduleinst =
  let Memory mt = mem.it in
  let mt' = subst_memorytype (subst_of inst) mt in
  let mem = Memory.alloc mt' in
  {inst with memories = inst.memories @ [mem]}

let init_table (inst : moduleinst) (tab : table) : moduleinst =
  let Table (tt, c) = tab.it in
  let tt' = subst_tabletype (subst_of inst) tt in
  let r =
    match eval_const inst c with
    | Ref r -> r
    | _ -> Crash.error c.at "non-reference table initializer"
  in
  let tab = Table.alloc tt' r in
  {inst with tables = inst.tables @ [tab]}

let init_func (inst : moduleinst) (f : func) : moduleinst =
  let Func (x, _, _) = f.it in
  let func = Func.alloc (type_ inst x) (Lib.Promise.make ()) f in
  {inst with funcs = inst.funcs @ [func]}

let init_data (inst : moduleinst) (data : data) : moduleinst =
  let Data (bs, _dmode) = data.it in
  let data = Data.alloc bs in
  {inst with datas = inst.datas @ [data]}

let init_elem (inst : moduleinst) (elem : elem) : moduleinst =
  let Elem (rt, cs, _emode) = elem.it in
  let elem = Elem.alloc (List.map (fun c -> as_ref (eval_const inst c)) cs) in
  {inst with elems = inst.elems @ [elem]}

let init_export (inst : moduleinst) (ex : export) : moduleinst =
  let Export (name, xx) = ex.it in
  let ext =
    match xx.it with
    | TagX x -> ExternTag (tag inst x)
    | GlobalX x -> ExternGlobal (global inst x)
    | MemoryX x -> ExternMemory (memory inst x)
    | TableX x -> ExternTable (table inst x)
    | FuncX x -> ExternFunc (func inst x)
  in
  {inst with exports = inst.exports @ [(name, ext)]}


let init_funcinst (inst : moduleinst) (func : funcinst) =
  match func with
  | Func.AstFunc (_, prom, _) when Lib.Promise.value_opt prom = None ->
    Lib.Promise.fulfill prom inst
  | _ -> ()

let run_elem i elem =
  let Elem (_rt, cs, emode) = elem.it in
  let at = emode.at in
  let x = i @@ at in
  match emode.it with
  | Passive -> []
  | Active (y, c) ->
    c.it @ [
      Const (I32 0l @@ at) @@ at;
      Const (I32 (Lib.List32.length cs) @@ at) @@ at;
      TableInit (y, x) @@ at;
      ElemDrop x @@ at
    ]
  | Declarative -> [ElemDrop x @@ at]

let run_data i data =
  let Data (bs, dmode) = data.it in
  let at = dmode.at in
  let x = i @@ at in
  match dmode.it with
  | Passive -> []
  | Active (y, c) ->
    c.it @ [
      Const (I32 0l @@ at) @@ at;
      Const (I32 (Int32.of_int (String.length bs)) @@ at) @@ at;
      MemoryInit (y, x) @@ at;
      DataDrop x @@ at
    ]
  | Declarative -> assert false

let run_start start =
  let Start x = start.it in
  [Call x @@ start.at]


let init_list f xs (inst : moduleinst) : moduleinst =
  List.fold_left f inst xs

let init_list2 f xs ys (inst : moduleinst) : moduleinst =
  List.fold_left2 f inst xs ys

let init (m : module_) (exts : extern list) : moduleinst =
  if List.length exts <> List.length m.it.imports then
    Link.error m.at "wrong number of imports provided for initialisation";
  let inst =
    empty_moduleinst
    |> init_list init_type m.it.types
    |> init_list2 init_import exts m.it.imports
    |> init_list init_tag m.it.tags
    |> init_list init_func m.it.funcs
    |> init_list init_global m.it.globals
    |> init_list init_table m.it.tables
    |> init_list init_memory m.it.memories
    |> init_list init_data m.it.datas
    |> init_list init_elem m.it.elems
    |> init_list init_export m.it.exports
  in
  List.iter (init_funcinst inst) inst.funcs;
  let es_data = List.concat (Lib.List32.mapi run_data m.it.datas) in
  let es_elem = List.concat (Lib.List32.mapi run_elem m.it.elems) in
  let es_start = Lib.Option.get (Lib.Option.map run_start m.it.start) [] in
  ignore (eval (config inst [] (List.map plain (es_elem @ es_data @ es_start))));
  inst
