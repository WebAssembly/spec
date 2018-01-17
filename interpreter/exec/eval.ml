open Values
open Types
open Instance
open Ast
open Source


(* Errors *)

module Link = Error.Make ()
module Trap = Error.Make ()
module Crash = Error.Make ()
module Exhaustion = Error.Make ()

exception Link = Link.Error
exception Trap = Trap.Error
exception Crash = Crash.Error (* failure that cannot happen in valid code *)
exception Exhaustion = Exhaustion.Error

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
      ("type error, expected " ^ Types.string_of_value_type t ^ " as operand " ^
       string_of_int i ^ ", got " ^ Types.string_of_value_type (type_of v))
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
  | Trapped of string
  | Break of int32 * value stack
  | Label of stack_type * instr list * code
  | Frame of frame * code
  | Invoke of func_inst

type config =
{
  frame : frame;
  code : code;
  depth : int;   (* needed for return *)
  budget : int;  (* needed to model stack overflow *)
}

let frame inst locals = {inst; locals}
let config inst vs es =
  {frame = frame inst []; code = vs, es; depth = 0; budget = 300}

let plain e = Plain e.it @@ e.at

let lookup category list x =
  try Lib.List32.nth list x.it with Failure _ ->
    Crash.error x.at ("undefined " ^ category ^ " " ^ Int32.to_string x.it)

let type_ (inst : module_inst) x = lookup "type" inst.types x
let func (inst : module_inst) x = lookup "function" inst.funcs x
let table (inst : module_inst) x = lookup "table" inst.tables x
let memory (inst : module_inst) x = lookup "memory" inst.memories x
let global (inst : module_inst) x = lookup "global" inst.globals x
let local (frame : frame) x = lookup "local" frame.locals x

let elem inst x i at =
  match Table.load (table inst x) i with
  | Table.Uninitialized ->
    Trap.error at ("uninitialized element " ^ Int32.to_string i)
  | f -> f
  | exception Table.Bounds ->
    Trap.error at ("undefined element " ^ Int32.to_string i)

let func_elem inst x i at =
  match elem inst x i at with
  | FuncElem f -> f
  | _ -> Crash.error at ("type mismatch for element " ^ Int32.to_string i)

let take n (vs : 'a stack) at =
  try Lib.List.take n vs with Failure _ -> Crash.error at "stack underflow"

let drop n (vs : 'a stack) at =
  try Lib.List.drop n vs with Failure _ -> Crash.error at "stack underflow"


(* Evaluation *)

(*
 * Conventions:
 *   e  : instr
 *   v  : value
 *   es : instr list
 *   vs : value stack
 *   c : config
 *)

let rec step (c : config) : config =
  let {frame; code = vs, es; _} = c in
  let e = List.hd es in
  let vs', es' =
    match e.it, vs with
    | Plain e', vs ->
      (match e', vs with
      | Unreachable, vs ->
        vs, [Trapped "unreachable executed" @@ e.at]

      | Nop, vs ->
        vs, []

      | Block (ts, es'), vs ->
        vs, [Label (ts, [], ([], List.map plain es')) @@ e.at]

      | Loop (ts, es'), vs ->
        vs, [Label ([], [e' @@ e.at], ([], List.map plain es')) @@ e.at]

      | If (ts, es1, es2), I32 0l :: vs' ->
        vs', [Plain (Block (ts, es2)) @@ e.at]

      | If (ts, es1, es2), I32 i :: vs' ->
        vs', [Plain (Block (ts, es1)) @@ e.at]

      | Br x, vs ->
        [], [Break (x.it, vs) @@ e.at]

      | BrIf x, I32 0l :: vs' ->
        vs', []

      | BrIf x, I32 i :: vs' ->
        vs', [Plain (Br x) @@ e.at]

      | BrTable (xs, x), I32 i :: vs' when I32.ge_u i (Lib.List32.length xs) ->
        vs', [Plain (Br x) @@ e.at]

      | BrTable (xs, x), I32 i :: vs' ->
        vs', [Plain (Br (Lib.List32.nth xs i)) @@ e.at]

      | Return, vs ->
        vs, [Plain (Br ((Int32.of_int (c.depth - 1)) @@ e.at)) @@ e.at]

      | Call x, vs ->
        vs, [Invoke (func frame.inst x) @@ e.at]

      | CallIndirect x, I32 i :: vs ->
        let func = func_elem frame.inst (0l @@ e.at) i e.at in
        if type_ frame.inst x <> Func.type_of func then
          Trap.error e.at "indirect call signature mismatch";
        vs, [Invoke func @@ e.at]

      | Drop, v :: vs' ->
        vs', []

      | Select, I32 0l :: v2 :: v1 :: vs' ->
        v2 :: vs', []

      | Select, I32 i :: v2 :: v1 :: vs' ->
        v1 :: vs', []

      | GetLocal x, vs ->
        !(local frame x) :: vs, []

      | SetLocal x, v :: vs' ->
        local frame x := v;
        vs', []

      | TeeLocal x, v :: vs' ->
        local frame x := v;
        v :: vs', []

      | GetGlobal x, vs ->
        Global.load (global frame.inst x) :: vs, []

      | SetGlobal x, v :: vs' ->
        (try Global.store (global frame.inst x) v; vs', []
        with Global.NotMutable -> Crash.error e.at "write to immutable global"
           | Global.Type -> Crash.error e.at "type mismatch at global write")

      | Load {offset; ty; sz; _}, I32 i :: vs' ->
        let mem = memory frame.inst (0l @@ e.at) in
        let addr = I64_convert.extend_u_i32 i in
        (try
          let v =
            match sz with
            | None -> Memory.load_value mem addr offset ty
            | Some (sz, ext) -> Memory.load_packed sz ext mem addr offset ty
          in v :: vs', []
        with exn -> vs', [Trapped (memory_error e.at exn) @@ e.at])

      | Store {offset; sz; _}, v :: I32 i :: vs' ->
        let mem = memory frame.inst (0l @@ e.at) in
        let addr = I64_convert.extend_u_i32 i in
        (try
          (match sz with
          | None -> Memory.store_value mem addr offset v
          | Some sz -> Memory.store_packed sz mem addr offset v
          );
          vs', []
        with exn -> vs', [Trapped (memory_error e.at exn) @@ e.at]);

      | CurrentMemory, vs ->
        let mem = memory frame.inst (0l @@ e.at) in
        I32 (Memory.size mem) :: vs, []

      | GrowMemory, I32 delta :: vs' ->
        let mem = memory frame.inst (0l @@ e.at) in
        let old_size = Memory.size mem in
        let result =
          try Memory.grow mem delta; old_size
          with Memory.SizeOverflow | Memory.SizeLimit | Memory.OutOfMemory -> -1l
        in I32 result :: vs', []

      | Const v, vs ->
        v.it :: vs, []

      | Test testop, v :: vs' ->
        (try value_of_bool (Eval_numeric.eval_testop testop v) :: vs', []
        with exn -> vs', [Trapped (numeric_error e.at exn) @@ e.at])

      | Compare relop, v2 :: v1 :: vs' ->
        (try value_of_bool (Eval_numeric.eval_relop relop v1 v2) :: vs', []
        with exn -> vs', [Trapped (numeric_error e.at exn) @@ e.at])

      | Unary unop, v :: vs' ->
        (try Eval_numeric.eval_unop unop v :: vs', []
        with exn -> vs', [Trapped (numeric_error e.at exn) @@ e.at])

      | Binary binop, v2 :: v1 :: vs' ->
        (try Eval_numeric.eval_binop binop v1 v2 :: vs', []
        with exn -> vs', [Trapped (numeric_error e.at exn) @@ e.at])

      | Convert cvtop, v :: vs' ->
        (try Eval_numeric.eval_cvtop cvtop v :: vs', []
        with exn -> vs', [Trapped (numeric_error e.at exn) @@ e.at])

      | _ ->
        let s1 = string_of_values (List.rev vs) in
        let s2 = string_of_value_types (List.map type_of (List.rev vs)) in
        Crash.error e.at
          ("missing or ill-typed operand on stack (" ^ s1 ^ " : " ^ s2 ^ ")")
      )

    | Trapped msg, vs ->
      assert false

    | Break (k, vs'), vs ->
      Crash.error e.at "undefined label"

    | Label (ts, es0, (vs', [])), vs ->
      vs' @ vs, []

    | Label (ts, es0, (vs', {it = Trapped msg; at} :: es')), vs ->
      vs, [Trapped msg @@ at]

    | Label (ts, es0, (vs', {it = Break (0l, vs0); at} :: es')), vs ->
      take (List.length ts) vs0 e.at @ vs, List.map plain es0

    | Label (ts, es0, (vs', {it = Break (k, vs0); at} :: es')), vs ->
      vs, [Break (Int32.sub k 1l, vs0) @@ at]

    | Label (ts, es0, code'), vs ->
      let c' = step {c with code = code'; depth = c.depth + 1} in
      vs, [Label (ts, es0, c'.code) @@ e.at]

    | Frame (frame', (vs', [])), vs ->
      vs' @ vs, []

    | Frame (frame', (vs', {it = Trapped msg; at} :: es')), vs ->
      vs, [Trapped msg @@ at]

    | Frame (frame', code'), vs ->
      let c' = step {frame = frame'; code = code'; depth = 0; budget = c.budget - 1} in
      vs, [Frame (c'.frame, c'.code) @@ e.at]

    | Invoke func, vs when c.budget = 0 ->
      Exhaustion.error e.at "call stack exhausted"

    | Invoke func, vs ->
      let FuncType (ins, out) = Func.type_of func in
      let n = List.length ins in
      let args, vs' = take n vs e.at, drop n vs e.at in
      (match func with
      | Func.AstFunc (t, inst', f) ->
        let locals' = List.rev args @ List.map default_value f.it.locals in
        let code' = [], [Plain (Block (out, f.it.body)) @@ f.at] in
        let frame' = {inst = !inst'; locals = List.map ref locals'} in
        vs', [Frame (frame', code') @@ e.at]

      | Func.HostFunc (t, f) ->
        try List.rev (f (List.rev args)) @ vs', []
        with Crash (_, msg) -> Crash.error e.at msg
      )
  in {c with code = vs', es' @ List.tl es}


let rec eval (c : config) : value stack =
  match c.code with
  | vs, [] ->
    vs

  | vs, {it = Trapped msg; at} :: _ ->
    Trap.error at msg

  | vs, es ->
    eval (step c)


(* Functions & Constants *)

let invoke (func : func_inst) (vs : value list) : value list =
  let at = match func with Func.AstFunc (_,_, f) -> f.at | _ -> no_region in
  let FuncType (ins, out) = Func.type_of func in
  if List.length vs <> List.length ins then
    Crash.error at "wrong number of arguments";
  let c = config empty_module_inst (List.rev vs) [Invoke func @@ at] in
  try List.rev (eval c) with Stack_overflow ->
    Exhaustion.error at "call stack exhausted"

let eval_const (inst : module_inst) (const : const) : value =
  let c = config inst [] (List.map plain const.it) in
  match eval c with
  | [v] -> v
  | vs -> Crash.error const.at "wrong number of results on stack"

let i32 (v : value) at =
  match v with
  | I32 i -> i
  | _ -> Crash.error at "type error: i32 value expected"


(* Modules *)

let create_func (inst : module_inst) (f : func) : func_inst =
  Func.alloc (type_ inst f.it.ftype) (ref inst) f

let create_table (inst : module_inst) (tab : table) : table_inst =
  let {ttype} = tab.it in
  Table.alloc ttype

let create_memory (inst : module_inst) (mem : memory) : memory_inst =
  let {mtype} = mem.it in
  Memory.alloc mtype

let create_global (inst : module_inst) (glob : global) : global_inst =
  let {gtype; value} = glob.it in
  let v = eval_const inst value in
  Global.alloc gtype v

let create_export (inst : module_inst) (ex : export) : export_inst =
  let {name; edesc} = ex.it in
  let ext =
    match edesc.it with
    | FuncExport x -> ExternFunc (func inst x)
    | TableExport x -> ExternTable (table inst x)
    | MemoryExport x -> ExternMemory (memory inst x)
    | GlobalExport x -> ExternGlobal (global inst x)
  in name, ext


let init_func (inst : module_inst) (func : func_inst) =
  match func with
  | Func.AstFunc (_, inst_ref, _) -> inst_ref := inst
  | _ -> assert false

let init_table (inst : module_inst) (seg : table_segment) =
  let {index; offset = const; init} = seg.it in
  let tab = table inst index in
  let offset = i32 (eval_const inst const) const.at in
  let end_ = Int32.(add offset (of_int (List.length init))) in
  let bound = Table.size tab in
  if I32.lt_u bound end_ || I32.lt_u end_ offset then
    Link.error seg.at "elements segment does not fit table";
  fun () ->
    Table.blit tab offset (List.map (fun x -> FuncElem (func inst x)) init)

let init_memory (inst : module_inst) (seg : memory_segment) =
  let {index; offset = const; init} = seg.it in
  let mem = memory inst index in
  let offset' = i32 (eval_const inst const) const.at in
  let offset = I64_convert.extend_u_i32 offset' in
  let end_ = Int64.(add offset (of_int (String.length init))) in
  let bound = Memory.bound mem in
  if I64.lt_u bound end_ || I64.lt_u end_ offset then
    Link.error seg.at "data segment does not fit memory";
  fun () -> Memory.store_bytes mem offset init


let add_import (m : module_) (ext : extern) (im : import) (inst : module_inst)
  : module_inst =
  if not (match_extern_type (extern_type_of ext) (import_type m im)) then
    Link.error im.at "incompatible import type";
  match ext with
  | ExternFunc func -> {inst with funcs = func :: inst.funcs}
  | ExternTable tab -> {inst with tables = tab :: inst.tables}
  | ExternMemory mem -> {inst with memories = mem :: inst.memories}
  | ExternGlobal glob -> {inst with globals = glob :: inst.globals}

let init (m : module_) (exts : extern list) : module_inst =
  let
    { imports; tables; memories; globals; funcs; types;
      exports; elems; data; start
    } = m.it
  in
  if List.length exts <> List.length imports then
    Link.error m.at "wrong number of imports provided for initialisation";
  let inst0 =
    { (List.fold_right2 (add_import m) exts imports empty_module_inst) with
      types = List.map (fun type_ -> type_.it) types }
  in
  let fs = List.map (create_func inst0) funcs in
  let inst =
    { inst0 with
      funcs = inst0.funcs @ fs;
      tables = inst0.tables @ List.map (create_table inst0) tables;
      memories = inst0.memories @ List.map (create_memory inst0) memories;
      globals = inst0.globals @ List.map (create_global inst0) globals;
    }
  in
  List.iter (init_func inst) fs;
  let init_elems = List.map (init_table inst) elems in
  let init_datas = List.map (init_memory inst) data in
  List.iter (fun f -> f ()) init_elems;
  List.iter (fun f -> f ()) init_datas;
  Lib.Option.app (fun x -> ignore (invoke (func inst x) [])) start;
  {inst with exports = List.map (create_export inst) exports}
