open Values
open Types
open Instance
open Ast
open Source


(* Errors *)

module Link = Error.Make ()
module Trap = Error.Make ()
module Exception = Error.Make ()
module Crash = Error.Make ()
module Exhaustion = Error.Make ()

exception Link = Link.Error
exception Trap = Trap.Error
exception Exception = Exception.Error
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
  | Numeric_error.IntegerOverflow -> "integer overflow"
  | Numeric_error.IntegerDivideByZero -> "integer divide by zero"
  | Numeric_error.InvalidConversionToInteger -> "invalid conversion to integer"
  | Eval_numeric.TypeError (i, v, t) ->
    Crash.error at
      ("type error, expected " ^ Types.string_of_num_type t ^ " as operand " ^
       string_of_int i ^ ", got " ^ Types.string_of_num_type (type_of_num v))
  | exn -> raise exn


(* Administrative Expressions & Configurations *)

type 'a stack = 'a list

type frame =
{
  inst : module_inst;
  locals : value ref list;
}

type code = value stack * admin_instr list

and admin_instr = admin_instr' phrase
and admin_instr' =
  | Plain of instr'
  | Refer of ref_
  | Invoke of func_inst
  | Trapping of string
  | Returning of value stack
  | Breaking of int32 * value stack
  | Throwing of Tag.t * value stack
  | Rethrowing of int32 * (admin_instr -> admin_instr)
  | Label of int32 * instr list * code
  | Frame of int32 * frame * code
  | Catch of int32 * (Tag.t * instr list) list * instr list option * code
  | Caught of int32 * Tag.t * value stack * code
  | Delegate of int32 * code
  | Delegating of int32 * Tag.t * value stack

type config =
{
  frame : frame;
  code : code;
  budget : int;  (* to model stack overflow *)
}

let frame inst locals = {inst; locals}
let config inst vs es = {frame = frame inst []; code = vs, es; budget = 300}

let plain e = Plain e.it @@ e.at

let lookup category list x =
  try Lib.List32.nth list x.it with Failure _ ->
    Crash.error x.at ("undefined " ^ category ^ " " ^ Int32.to_string x.it)

let type_ (inst : module_inst) x = lookup "type" inst.types x
let func (inst : module_inst) x = lookup "function" inst.funcs x
let table (inst : module_inst) x = lookup "table" inst.tables x
let memory (inst : module_inst) x = lookup "memory" inst.memories x
let tag (inst : module_inst) x = lookup "tag" inst.tags x
let global (inst : module_inst) x = lookup "global" inst.globals x
let elem (inst : module_inst) x = lookup "element segment" inst.elems x
let data (inst : module_inst) x = lookup "data segment" inst.datas x
let local (frame : frame) x = lookup "local" frame.locals x

let any_ref inst x i at =
  try Table.load (table inst x) i with Table.Bounds ->
    Trap.error at ("undefined element " ^ Int32.to_string i)

let func_ref inst x i at =
  match any_ref inst x i at with
  | FuncRef f -> f
  | NullRef _ -> Trap.error at ("uninitialized element " ^ Int32.to_string i)
  | _ -> Crash.error at ("type mismatch for element " ^ Int32.to_string i)

let func_type_of = function
  | Func.AstFunc (t, inst, f) -> t
  | Func.HostFunc (t, _) -> t

let block_type inst bt =
  match bt with
  | VarBlockType x -> type_ inst x
  | ValBlockType None -> FuncType ([], [])
  | ValBlockType (Some t) -> FuncType ([], [t])

let take n (vs : 'a stack) at =
  try Lib.List32.take n vs with Failure _ -> Crash.error at "stack underflow"

let drop n (vs : 'a stack) at =
  try Lib.List32.drop n vs with Failure _ -> Crash.error at "stack underflow"


(* Evaluation *)

(*
 * Conventions:
 *   e  : instr
 *   v  : value
 *   es : instr list
 *   vs : value stack
 *   c : config
 *)

let mem_oob frame x i n =
  I64.gt_u (I64.add (I64_convert.extend_i32_u i) (I64_convert.extend_i32_u n))
    (Memory.bound (memory frame.inst x))

let data_oob frame x i n =
  I64.gt_u (I64.add (I64_convert.extend_i32_u i) (I64_convert.extend_i32_u n))
    (I64.of_int_u (String.length !(data frame.inst x)))

let table_oob frame x i n =
  I64.gt_u (I64.add (I64_convert.extend_i32_u i) (I64_convert.extend_i32_u n))
    (I64_convert.extend_i32_u (Table.size (table frame.inst x)))

let elem_oob frame x i n =
  I64.gt_u (I64.add (I64_convert.extend_i32_u i) (I64_convert.extend_i32_u n))
    (I64.of_int_u (List.length !(elem frame.inst x)))

let rec step (c : config) : config =
  let {frame; code = vs, es; _} = c in
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
        let FuncType (ts1, ts2) = block_type frame.inst bt in
        let n1 = Lib.List32.length ts1 in
        let n2 = Lib.List32.length ts2 in
        let args, vs' = take n1 vs e.at, drop n1 vs e.at in
        vs', [Label (n2, [], (args, List.map plain es')) @@ e.at]

      | Loop (bt, es'), vs ->
        let FuncType (ts1, ts2) = block_type frame.inst bt in
        let n1 = Lib.List32.length ts1 in
        let args, vs' = take n1 vs e.at, drop n1 vs e.at in
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

      | Return, vs ->
        [], [Returning vs @@ e.at]

      | Call x, vs ->
        vs, [Invoke (func frame.inst x) @@ e.at]

      | CallIndirect (x, y), Num (I32 i) :: vs ->
        let func = func_ref frame.inst x i e.at in
        if type_ frame.inst y <> Func.type_of func then
          vs, [Trapping "indirect call type mismatch" @@ e.at]
        else
          vs, [Invoke func @@ e.at]

      | Throw x, vs ->
        let t = tag frame.inst x in
        let FuncType (ts, _) = Tag.type_of t in
        let n = Lib.List32.length ts in
        let args, vs' = take n vs e.at, drop n vs e.at in
        vs', [Throwing (t, args) @@ e.at]

      | Rethrow x, vs ->
        vs, [Rethrowing (x.it, fun e -> e) @@ e.at]

      | TryCatch (bt, es', cts, ca), vs ->
        let FuncType (ts1, ts2) = block_type frame.inst bt in
        let n1 = Lib.List32.length ts1 in
        let n2 = Lib.List32.length ts2 in
        let args, vs' = take n1 vs e.at, drop n1 vs e.at in
        let cts' = List.map (fun (x, es'') -> ((tag frame.inst x), es'')) cts in
        vs', [Label (n2, [], ([], [Catch (n2, cts', ca, (args, List.map plain es')) @@ e.at])) @@ e.at]

      | TryDelegate (bt, es', x), vs ->
        let FuncType (ts1, ts2) = block_type frame.inst bt in
        let n1 = Lib.List32.length ts1 in
        let n2 = Lib.List32.length ts2 in
        let args, vs' = take n1 vs e.at, drop n1 vs e.at in
        let k = Int32.succ x.it in
        vs', [Label (n2, [], ([], [Delegate (k, (args, List.map plain es')) @@ e.at])) @@ e.at]

      | Drop, v :: vs' ->
        vs', []

      | Select _, Num (I32 i) :: v2 :: v1 :: vs' ->
        if i = 0l then
          v2 :: vs', []
        else
          v1 :: vs', []

      | LocalGet x, vs ->
        !(local frame x) :: vs, []

      | LocalSet x, v :: vs' ->
        local frame x := v;
        vs', []

      | LocalTee x, v :: vs' ->
        local frame x := v;
        v :: vs', []

      | GlobalGet x, vs ->
        Global.load (global frame.inst x) :: vs, []

      | GlobalSet x, v :: vs' ->
        (try Global.store (global frame.inst x) v; vs', []
        with Global.NotMutable -> Crash.error e.at "write to immutable global"
           | Global.Type -> Crash.error e.at "type mismatch at global write")

      | TableGet x, Num (I32 i) :: vs' ->
        (try Ref (Table.load (table frame.inst x) i) :: vs', []
        with exn -> vs', [Trapping (table_error e.at exn) @@ e.at])

      | TableSet x, Ref r :: Num (I32 i) :: vs' ->
        (try Table.store (table frame.inst x) i r; vs', []
        with exn -> vs', [Trapping (table_error e.at exn) @@ e.at])

      | TableSize x, vs ->
        Num (I32 (Table.size (table frame.inst x))) :: vs, []

      | TableGrow x, Num (I32 delta) :: Ref r :: vs' ->
        let tab = table frame.inst x in
        let old_size = Table.size tab in
        let result =
          try Table.grow tab delta r; old_size
          with Table.SizeOverflow | Table.SizeLimit | Table.OutOfMemory -> -1l
        in Num (I32 result) :: vs', []

      | TableFill x, Num (I32 n) :: Ref r :: Num (I32 i) :: vs' ->
        if table_oob frame x i n then
          vs', [Trapping (table_error e.at Table.Bounds) @@ e.at]
        else if n = 0l then
          vs', []
        else
          let _ = assert (I32.lt_u i 0xffff_ffffl) in
          vs', List.map (at e.at) [
            Plain (Const (I32 i @@ e.at));
            Refer r;
            Plain (TableSet x);
            Plain (Const (I32 (I32.add i 1l) @@ e.at));
            Refer r;
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (TableFill x);
          ]

      | TableCopy (x, y), Num (I32 n) :: Num (I32 s) :: Num (I32 d) :: vs' ->
        if table_oob frame x d n || table_oob frame y s n then
          vs', [Trapping (table_error e.at Table.Bounds) @@ e.at]
        else if n = 0l then
          vs', []
        else if I32.le_u d s then
          vs', List.map (at e.at) [
            Plain (Const (I32 d @@ e.at));
            Plain (Const (I32 s @@ e.at));
            Plain (TableGet y);
            Plain (TableSet x);
            Plain (Const (I32 (I32.add d 1l) @@ e.at));
            Plain (Const (I32 (I32.add s 1l) @@ e.at));
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (TableCopy (x, y));
          ]
        else (* d > s *)
          vs', List.map (at e.at) [
            Plain (Const (I32 (I32.add d 1l) @@ e.at));
            Plain (Const (I32 (I32.add s 1l) @@ e.at));
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (TableCopy (x, y));
            Plain (Const (I32 d @@ e.at));
            Plain (Const (I32 s @@ e.at));
            Plain (TableGet y);
            Plain (TableSet x);
          ]

      | TableInit (x, y), Num (I32 n) :: Num (I32 s) :: Num (I32 d) :: vs' ->
        if table_oob frame x d n || elem_oob frame y s n then
          vs', [Trapping (table_error e.at Table.Bounds) @@ e.at]
        else if n = 0l then
          vs', []
        else
          let seg = !(elem frame.inst y) in
          vs', List.map (at e.at) [
            Plain (Const (I32 d @@ e.at));
            Refer (List.nth seg (Int32.to_int s));
            Plain (TableSet x);
            Plain (Const (I32 (I32.add d 1l) @@ e.at));
            Plain (Const (I32 (I32.add s 1l) @@ e.at));
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (TableInit (x, y));
          ]

      | ElemDrop x, vs ->
        let seg = elem frame.inst x in
        seg := [];
        vs, []

      | Load {offset; ty; sz; _}, Num (I32 i) :: vs' ->
        let mem = memory frame.inst (0l @@ e.at) in
        let a = I64_convert.extend_i32_u i in
        (try
          let n =
            match sz with
            | None -> Memory.load_num mem a offset ty
            | Some (sz, ext) -> Memory.load_packed sz ext mem a offset ty
          in Num n :: vs', []
        with exn -> vs', [Trapping (memory_error e.at exn) @@ e.at])

      | Store {offset; sz; _}, Num n :: Num (I32 i) :: vs' ->
        let mem = memory frame.inst (0l @@ e.at) in
        let a = I64_convert.extend_i32_u i in
        (try
          (match sz with
          | None -> Memory.store_num mem a offset n
          | Some sz -> Memory.store_packed sz mem a offset n
          );
          vs', []
        with exn -> vs', [Trapping (memory_error e.at exn) @@ e.at]);
      | MemorySize, vs ->
        let mem = memory frame.inst (0l @@ e.at) in
        Num (I32 (Memory.size mem)) :: vs, []

      | MemoryGrow, Num (I32 delta) :: vs' ->
        let mem = memory frame.inst (0l @@ e.at) in
        let old_size = Memory.size mem in
        let result =
          try Memory.grow mem delta; old_size
          with Memory.SizeOverflow | Memory.SizeLimit | Memory.OutOfMemory -> -1l
        in Num (I32 result) :: vs', []

      | MemoryFill, Num (I32 n) :: Num k :: Num (I32 i) :: vs' ->
        if mem_oob frame (0l @@ e.at) i n then
          vs', [Trapping (memory_error e.at Memory.Bounds) @@ e.at]
        else if n = 0l then
          vs', []
        else
          vs', List.map (at e.at) [
            Plain (Const (I32 i @@ e.at));
            Plain (Const (k @@ e.at));
            Plain (Store
              {ty = I32Type; align = 0; offset = 0l; sz = Some Pack8});
            Plain (Const (I32 (I32.add i 1l) @@ e.at));
            Plain (Const (k @@ e.at));
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (MemoryFill);
          ]

      | MemoryCopy, Num (I32 n) :: Num (I32 s) :: Num (I32 d) :: vs' ->
        if mem_oob frame (0l @@ e.at) s n || mem_oob frame (0l @@ e.at) d n then
          vs', [Trapping (memory_error e.at Memory.Bounds) @@ e.at]
        else if n = 0l then
          vs', []
        else if I32.le_u d s then
          vs', List.map (at e.at) [
            Plain (Const (I32 d @@ e.at));
            Plain (Const (I32 s @@ e.at));
            Plain (Load
              {ty = I32Type; align = 0; offset = 0l; sz = Some (Pack8, ZX)});
            Plain (Store
              {ty = I32Type; align = 0; offset = 0l; sz = Some Pack8});
            Plain (Const (I32 (I32.add d 1l) @@ e.at));
            Plain (Const (I32 (I32.add s 1l) @@ e.at));
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (MemoryCopy);
          ]
        else (* d > s *)
          vs', List.map (at e.at) [
            Plain (Const (I32 (I32.add d 1l) @@ e.at));
            Plain (Const (I32 (I32.add s 1l) @@ e.at));
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (MemoryCopy);
            Plain (Const (I32 d @@ e.at));
            Plain (Const (I32 s @@ e.at));
            Plain (Load
              {ty = I32Type; align = 0; offset = 0l; sz = Some (Pack8, ZX)});
            Plain (Store
              {ty = I32Type; align = 0; offset = 0l; sz = Some Pack8});
          ]

      | MemoryInit x, Num (I32 n) :: Num (I32 s) :: Num (I32 d) :: vs' ->
        if mem_oob frame (0l @@ e.at) d n || data_oob frame x s n then
          vs', [Trapping (memory_error e.at Memory.Bounds) @@ e.at]
        else if n = 0l then
          vs', []
        else
          let seg = !(data frame.inst x) in
          let b = Int32.of_int (Char.code seg.[Int32.to_int s]) in
          vs', List.map (at e.at) [
            Plain (Const (I32 d @@ e.at));
            Plain (Const (I32 b @@ e.at));
            Plain (Store
              {ty = I32Type; align = 0; offset = 0l; sz = Some Pack8});
            Plain (Const (I32 (I32.add d 1l) @@ e.at));
            Plain (Const (I32 (I32.add s 1l) @@ e.at));
            Plain (Const (I32 (I32.sub n 1l) @@ e.at));
            Plain (MemoryInit x);
          ]

      | DataDrop x, vs ->
        let seg = data frame.inst x in
        seg := "";
        vs, []

      | RefNull t, vs' ->
        Ref (NullRef t) :: vs', []

      | RefIsNull, Ref r :: vs' ->
        (match r with
        | NullRef _ ->
          Num (I32 1l) :: vs', []
        | _ ->
          Num (I32 0l) :: vs', []
        )

      | RefFunc x, vs' ->
        let f = func frame.inst x in
        Ref (FuncRef f) :: vs', []

      | Const n, vs ->
        Num n.it :: vs, []

      | Test testop, Num n :: vs' ->
        (try value_of_bool (Eval_numeric.eval_testop testop n) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | Compare relop, Num n2 :: Num n1 :: vs' ->
        (try value_of_bool (Eval_numeric.eval_relop relop n1 n2) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | Unary unop, Num n :: vs' ->
        (try Num (Eval_numeric.eval_unop unop n) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | Binary binop, Num n2 :: Num n1 :: vs' ->
        (try Num (Eval_numeric.eval_binop binop n1 n2) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | Convert cvtop, Num n :: vs' ->
        (try Num (Eval_numeric.eval_cvtop cvtop n) :: vs', []
        with exn -> vs', [Trapping (numeric_error e.at exn) @@ e.at])

      | _ ->
        let s1 = string_of_values (List.rev vs) in
        let s2 = string_of_value_types (List.map type_of_value (List.rev vs)) in
        Crash.error e.at
          ("missing or ill-typed operand on stack (" ^ s1 ^ " : " ^ s2 ^ ")")
      )

    | Refer r, vs ->
      Ref r :: vs, []

    | Trapping msg, vs ->
      assert false

    | Returning vs', vs ->
      Crash.error e.at "undefined frame"

    | Breaking (k, vs'), vs ->
      Crash.error e.at "undefined label"

    | Throwing _, _ ->
      assert false

    | Rethrowing _, _ ->
      Crash.error e.at "undefined catch label"

    | Delegating _, _ ->
      Crash.error e.at "undefined delegate label"

    | Label (n, es0, (vs', [])), vs ->
      vs' @ vs, []

    | Label (n, es0, (vs', {it = Trapping msg; at} :: es')), vs ->
      vs, [Trapping msg @@ at]

    | Label (n, es0, (vs', {it = Returning vs0; at} :: es')), vs ->
      vs, [Returning vs0 @@ at]

    | Label (n, es0, (vs', {it = Breaking (0l, vs0); at} :: es')), vs ->
      take n vs0 e.at @ vs, List.map plain es0

    | Label (n, es0, (vs', {it = Breaking (k, vs0); at} :: es')), vs ->
      vs, [Breaking (Int32.sub k 1l, vs0) @@ at]

    | Label (n, es0, (vs', {it = Throwing (a, vs0); at} :: es')), vs ->
      vs, [Throwing (a, vs0) @@ at]

    | Label (n, es0, (vs', {it = Delegating (0l, a, vs0); at} :: es')), vs ->
      vs, [Throwing (a, vs0) @@ at]

    | Label (n, es0, (vs', {it = Delegating (k, a, vs0); at} :: es')), vs ->
      vs, [Delegating (Int32.sub k 1l, a, vs0) @@ at]

    | Label (n, es0, (vs', {it = Rethrowing (k, cont); at} :: es')), vs ->
      vs, [Rethrowing (Int32.sub k 1l, (fun e -> Label (n, es0, (vs', cont e :: es')) @@ e.at)) @@ at]

    | Label (n, es0, code'), vs ->
      let c' = step {c with code = code'} in
      vs, [Label (n, es0, c'.code) @@ e.at]

    | Frame (n, frame', (vs', [])), vs ->
      vs' @ vs, []

    | Frame (n, frame', (vs', {it = Trapping msg; at} :: es')), vs ->
      vs, [Trapping msg @@ at]

    | Frame (n, frame', (vs', {it = Returning vs0; at} :: es')), vs ->
      take n vs0 e.at @ vs, []

    | Frame (n, frame', (vs', {it = Throwing (a, vs0); at} :: es')), vs ->
      vs, [Throwing (a, vs0) @@ at]

    | Frame (n, frame', code'), vs ->
      let c' = step {frame = frame'; code = code'; budget = c.budget - 1} in
      vs, [Frame (n, c'.frame, c'.code) @@ e.at]

    | Catch (n, cts, ca, (vs', [])), vs ->
      vs' @ vs, []

    | Catch (n, cts, ca, (vs', {it = Delegating (0l, a, vs0); at} :: es')), vs ->
      vs, [Catch (n, cts, ca, (vs', (Throwing (a, vs0) @@ at) :: es')) @@ e.at]

    | Catch (n, cts, ca, (vs', ({it = Trapping _ | Breaking _ | Returning _ | Delegating _; at} as e) :: es')), vs ->
      vs, [e]

    | Catch (n, cts, ca, (vs', {it = Rethrowing (k, cont); at} :: es')), vs ->
      vs, [Rethrowing (k, (fun e -> Catch (n, cts, ca, (vs', (cont e) :: es')) @@ e.at)) @@ at]

    | Catch (n, (a', es'') :: cts, ca, (vs', {it = Throwing (a, vs0); at} :: es')), vs ->
      if a == a' then
        vs, [Caught (n, a, vs0, (vs0, List.map plain es'')) @@ at]
      else
        vs, [Catch (n, cts, ca, (vs', {it = Throwing (a, vs0); at} :: es')) @@ e.at]

    | Catch (n, [], Some es'', (vs', {it = Throwing (a, vs0); at} :: es')), vs ->
      vs, [Caught (n, a, vs0, (vs0, List.map plain es'')) @@ at]

    | Catch (n, [], None, (vs', {it = Throwing (a, vs0); at} :: es')), vs ->
      vs, [Throwing (a, vs0) @@ at]

    | Catch (n, cts, ca, code'), vs ->
      let c' = step {c with code = code'} in
      vs, [Catch (n, cts, ca, c'.code) @@ e.at]

    | Caught (n, a, vs0, (vs', [])), vs ->
      vs' @ vs, []

    | Caught (n, a, vs0, (vs', ({it = Trapping _ | Breaking _ | Returning _ | Throwing _ | Delegating _; at} as e) :: es')), vs ->
      vs, [e]

    | Caught (n, a, vs0, (vs', {it = Rethrowing (0l, cont); at} :: es')), vs ->
      vs, [Caught (n, a, vs0, (vs', (cont (Throwing (a, vs0) @@ at)) :: es')) @@ e.at]

    | Caught (n, a, vs0, (vs', {it = Rethrowing (k, cont); at} :: es')), vs ->
      vs, [Rethrowing (k, (fun e -> Caught (n, a, vs0, (vs', (cont e) :: es')) @@ e.at)) @@ at]

    | Caught (n, a, vs0, code'), vs ->
      let c' = step {c with code = code'} in
      vs, [Caught (n, a, vs0, c'.code) @@ e.at]

    | Delegate (l, (vs', [])), vs ->
      vs' @ vs, []

    | Delegate (l, (vs', ({it = Trapping _ | Breaking _ | Returning _ | Rethrowing _ | Delegating _; at} as e) :: es')), vs ->
      vs, [e]

    | Delegate (l, (vs', {it = Throwing (a, vs0); at} :: es')), vs ->
      vs, [Delegating (l, a, vs0) @@ e.at]

    | Delegate (l, code'), vs ->
      let c' = step {c with code = code'} in
      vs, [Delegate (l, c'.code) @@ e.at]

    | Invoke func, vs when c.budget = 0 ->
      Exhaustion.error e.at "call stack exhausted"

    | Invoke func, vs ->
      let FuncType (ins, out) = func_type_of func in
      let n1, n2 = Lib.List32.length ins, Lib.List32.length out in
      let args, vs' = take n1 vs e.at, drop n1 vs e.at in
      (match func with
      | Func.AstFunc (t, inst', f) ->
        let locals' = List.rev args @ List.map default_value f.it.locals in
        let frame' = {inst = !inst'; locals = List.map ref locals'} in
        let instr' = [Label (n2, [], ([], List.map plain f.it.body)) @@ f.at] in
        vs', [Frame (n2, frame', ([], instr')) @@ e.at]

      | Func.HostFunc (t, f) ->
        try List.rev (f (List.rev args)) @ vs', []
        with Crash (_, msg) -> Crash.error e.at msg
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

let invoke (func : func_inst) (vs : value list) : value list =
  let at = match func with Func.AstFunc (_, _, f) -> f.at | _ -> no_region in
  let FuncType (ins, out) = Func.type_of func in
  if List.length vs <> List.length ins then
    Crash.error at "wrong number of arguments";
  if not (List.for_all2 (fun v -> (=) (type_of_value v)) vs ins) then
    Crash.error at "wrong types of arguments";
  let c = config empty_module_inst (List.rev vs) [Invoke func @@ at] in
  try List.rev (eval c) with Stack_overflow ->
    Exhaustion.error at "call stack exhausted"

let eval_const (inst : module_inst) (const : const) : value =
  let c = config inst [] (List.map plain const.it) in
  match eval c with
  | [v] -> v
  | vs -> Crash.error const.at "wrong number of results on stack"


(* Modules *)

let create_func (inst : module_inst) (f : func) : func_inst =
  Func.alloc (type_ inst f.it.ftype) (ref inst) f

let create_table (inst : module_inst) (tab : table) : table_inst =
  let {ttype} = tab.it in
  let TableType (_lim, t) = ttype in
  Table.alloc ttype (NullRef t)

let create_memory (inst : module_inst) (mem : memory) : memory_inst =
  let {mtype} = mem.it in
  Memory.alloc mtype

let create_tag (inst : module_inst) (t : tag) : tag_inst =
  Tag.alloc (type_ inst t.it.tgtype)

let create_global (inst : module_inst) (glob : global) : global_inst =
  let {gtype; ginit} = glob.it in
  let v = eval_const inst ginit in
  Global.alloc gtype v

let create_export (inst : module_inst) (ex : export) : export_inst =
  let {name; edesc} = ex.it in
  let ext =
    match edesc.it with
    | FuncExport x -> ExternFunc (func inst x)
    | TableExport x -> ExternTable (table inst x)
    | MemoryExport x -> ExternMemory (memory inst x)
    | GlobalExport x -> ExternGlobal (global inst x)
    | TagExport x -> ExternTag (tag inst x)
  in (name, ext)

let create_elem (inst : module_inst) (seg : elem_segment) : elem_inst =
  let {etype; einit; _} = seg.it in
  ref (List.map (fun c -> as_ref (eval_const inst c)) einit)

let create_data (inst : module_inst) (seg : data_segment) : data_inst =
  let {dinit; _} = seg.it in
  ref dinit


let add_import (m : module_) (ext : extern) (im : import) (inst : module_inst)
  : module_inst =
  if not (match_extern_type (extern_type_of ext) (import_type m im)) then
    Link.error im.at ("incompatible import type for " ^
      "\"" ^ Utf8.encode im.it.module_name ^ "\" " ^
      "\"" ^ Utf8.encode im.it.item_name ^ "\": " ^
      "expected " ^ Types.string_of_extern_type (import_type m im) ^
      ", got " ^ Types.string_of_extern_type (extern_type_of ext));
  match ext with
  | ExternFunc func -> {inst with funcs = func :: inst.funcs}
  | ExternTable tab -> {inst with tables = tab :: inst.tables}
  | ExternMemory mem -> {inst with memories = mem :: inst.memories}
  | ExternTag tag -> {inst with tags = tag :: inst.tags}
  | ExternGlobal glob -> {inst with globals = glob :: inst.globals}

let init_func (inst : module_inst) (func : func_inst) =
  match func with
  | Func.AstFunc (_, inst_ref, _) -> inst_ref := inst
  | _ -> assert false

let run_elem i elem =
  let at = elem.it.emode.at in
  let x = i @@ at in
  match elem.it.emode.it with
  | Passive -> []
  | Active {index; offset} ->
    offset.it @ [
      Const (I32 0l @@ at) @@ at;
      Const (I32 (Lib.List32.length elem.it.einit) @@ at) @@ at;
      TableInit (index, x) @@ at;
      ElemDrop x @@ at
    ]
  | Declarative ->
    [ElemDrop x @@ at]

let run_data i data =
  let at = data.it.dmode.at in
  let x = i @@ at in
  match data.it.dmode.it with
  | Passive -> []
  | Active {index; offset} ->
    assert (index.it = 0l);
    offset.it @ [
      Const (I32 0l @@ at) @@ at;
      Const (I32 (Int32.of_int (String.length data.it.dinit)) @@ at) @@ at;
      MemoryInit x @@ at;
      DataDrop x @@ at
    ]
  | Declarative -> assert false

let run_start start =
  [Call start @@ start.at]

let init (m : module_) (exts : extern list) : module_inst =
  let
    { imports; tables; memories; tags; globals; funcs; types;
      exports; elems; datas; start
    } = m.it
  in
  if List.length exts <> List.length imports then
    Link.error m.at "wrong number of imports provided for initialisation";
  let inst0 =
    { (List.fold_right2 (add_import m) exts imports empty_module_inst) with
      types = List.map (fun type_ -> type_.it) types }
  in
  let fs = List.map (create_func inst0) funcs in
  let inst1 = {inst0 with funcs = inst0.funcs @ fs} in
  let inst2 =
    { inst1 with
      tables = inst1.tables @ List.map (create_table inst1) tables;
      memories = inst1.memories @ List.map (create_memory inst1) memories;
      tags = inst1.tags @ List.map (create_tag inst1) tags;
      globals = inst1.globals @ List.map (create_global inst1) globals;
    }
  in
  let inst =
    { inst2 with
      exports = List.map (create_export inst2) exports;
      elems = List.map (create_elem inst2) elems;
      datas = List.map (create_data inst2) datas;
    }
  in
  List.iter (init_func inst) fs;
  let es_elem = List.concat (Lib.List32.mapi run_elem elems) in
  let es_data = List.concat (Lib.List32.mapi run_data datas) in
  let es_start = Lib.Option.get (Lib.Option.map run_start start) [] in
  ignore (eval (config inst [] (List.map plain (es_elem @ es_data @ es_start))));
  inst
