open Values
open Types
open Instance
open Ast
open Source
(* open Merkle *)

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

type admin_instr = admin_instr' phrase
and admin_instr' =
  | Plain of instr'
  | Trapped of string
  | Break of int32 * value stack
  | Label of stack_type * instr list * value stack * admin_instr list
  | Local of instance * value ref list * value stack * admin_instr list
  | Invoke of closure

(* why are locals refs???? *)

type config =
{
  locals : value ref list;
  values : value stack;
  instrs : admin_instr list;
  depth : int;   (* needed for return *)
  budget : int;  (* needed to model stack overflow *)
}

let config vs es =
  {locals = []; values = vs; instrs = es; depth = 0; budget = 300}

let plain e = Plain e.it @@ e.at

let lookup category list x =
  try Lib.List32.nth list x.it with Failure _ ->
    Crash.error x.at ("undefined " ^ category ^ " " ^ Int32.to_string x.it)

let type_ (inst : instance) x = lookup "type" inst.module_.it.types x
let func (inst : instance) x = lookup "function" inst.funcs x
let table (inst : instance) x = lookup "table" inst.tables x
let memory (inst : instance) x = lookup "memory" inst.memories x
let global (inst : instance) x = lookup "global" inst.globals x
let local (locals : value ref list) x = lookup "local" locals x

let elem inst x i at =
  match Table.load (table inst x) i with
  | Table.Uninitialized ->
    Trap.error at ("uninitialized element " ^ Int32.to_string i)
  | f -> f
  | exception Table.Bounds ->
    Trap.error at ("undefined element " ^ Int32.to_string i)

let func_elem inst x i at =
  match elem inst x i at with
  | Func f -> f
  | _ -> Crash.error at ("type mismatch for element " ^ Int32.to_string i)

let func_type_of = function
  | AstFunc (inst, f) -> (lookup "type" (!inst).module_.it.types f.it.ftype).it
  | HostFunc (t, _) -> t

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

let counter = ref 0

let rec step (inst : instance) (c : config) : config =
  incr counter;
  let e = List.hd c.instrs in
  let vs', es' =
    match e.it, c.values with
    | Plain e', vs ->
      (match e', vs with
      | Unreachable, vs ->
        vs, [Trapped "unreachable executed" @@ e.at]

      | Nop, vs ->
        vs, []

      | Block (ts, es'), vs ->
        vs, [Label (ts, [], [], List.map plain es') @@ e.at]

      | Loop (ts, es'), vs ->
        vs, [Label ([], [e' @@ e.at], [], List.map plain es') @@ e.at]

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
        vs, [Invoke (func inst x) @@ e.at]

      | CallIndirect x, I32 i :: vs ->
        let clos = func_elem inst (0l @@ e.at) i e.at in
        if (type_ inst x).it <> func_type_of clos then
          Trap.error e.at "indirect call signature mismatch";
        vs, [Invoke clos @@ e.at]

      | Drop, v :: vs' ->
        vs', []

      | Select, I32 0l :: v2 :: v1 :: vs' ->
        v2 :: vs', []

      | Select, I32 i :: v2 :: v1 :: vs' ->
        v1 :: vs', []

      | GetLocal x, vs ->
        !(local c.locals x) :: vs, []

      | SetLocal x, v :: vs' ->
        local c.locals x := v;
        vs', []

      | TeeLocal x, v :: vs' ->
        local c.locals x := v;
        v :: vs', []

      | GetGlobal x, vs ->
        !(global inst x) :: vs, []

      | SetGlobal x, v :: vs' ->
        global inst x := v;
        vs', []

      | Load {offset; ty; sz; _}, I32 i :: vs' ->
        let mem = memory inst (0l @@ e.at) in
        let addr = I64_convert.extend_u_i32 i in
        (try
          let v =
            match sz with
            | None -> Memory.load mem addr offset ty
            | Some (sz, ext) -> Memory.load_packed sz ext mem addr offset ty
          in v :: vs', []
        with exn -> vs', [Trapped (memory_error e.at exn) @@ e.at])

      | Store {offset; sz; _}, v :: I32 i :: vs' ->
        let mem = memory inst (0l @@ e.at) in
        let addr = I64_convert.extend_u_i32 i in
        (try
          (match sz with
          | None -> Memory.store mem addr offset v
          | Some sz -> Memory.store_packed sz mem addr offset v
          );
          vs', []
        with exn -> vs', [Trapped (memory_error e.at exn) @@ e.at]);

      | CurrentMemory, vs ->
        let mem = memory inst (0l @@ e.at) in
        I32 (Memory.size mem) :: vs, []

      | GrowMemory, I32 delta :: vs' ->
        let mem = memory inst (0l @@ e.at) in
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

    | Label (ts, es0, vs', []), vs ->
      vs' @ vs, []

    | Label (ts, es0, vs', {it = Trapped msg; at} :: es'), vs ->
      vs, [Trapped msg @@ at]

    | Label (ts, es0, vs', {it = Break (0l, vs0); at} :: es'), vs ->
      take (List.length ts) vs0 e.at @ vs, List.map plain es0

    | Label (ts, es0, vs', {it = Break (k, vs0); at} :: es'), vs ->
      vs, [Break (Int32.sub k 1l, vs0) @@ at]

    | Label (ts, es0, values, instrs), vs ->
      let c' = step inst {c with values; instrs; depth = c.depth + 1} in
      vs, [Label (ts, es0, c'.values, c'.instrs) @@ e.at]

    | Local (inst', locals, vs', []), vs ->
      vs' @ vs, []

    | Local (inst', locals, vs', {it = Trapped msg; at} :: es'), vs ->
      vs, [Trapped msg @@ at]

    | Local (inst', locals, values, instrs), vs ->
      let c' = step inst' {locals; values; instrs; depth = 0; budget = c.budget - 1} in
      vs, [Local (inst', c'.locals, c'.values, c'.instrs) @@ e.at]

    | Invoke clos, vs when c.budget = 0 ->
      Exhaustion.error e.at "call stack exhausted"

    | Invoke clos, vs ->
      let FuncType (ins, out) = func_type_of clos in
      let n = List.length ins in
      let args, vs' = take n vs e.at, drop n vs e.at in
      (match clos with
      | AstFunc (inst', f) ->
        let locals' = List.rev args @ List.map default_value f.it.locals in
        let instrs' = [Plain (Block (out, f.it.body)) @@ f.at] in
        vs', [Local (!inst', List.map ref locals', [], instrs') @@ e.at]

      | HostFunc (t, f) ->
        try List.rev (f (List.rev args)) @ vs', []
        with Crash (_, msg) -> Crash.error e.at msg
      )
  in {c with values = vs'; instrs = es' @ List.tl c.instrs}


let rec eval (inst : instance) (c : config) : value stack =
  match c.instrs with
  | [] ->
    c.values

  | {it = Trapped msg; at} :: _ ->
    Trap.error at msg

  | es ->
    eval inst (step inst c)


(* Functions & Constants *)

let invoke (clos : closure) (vs : value list) : value list =
  let at = match clos with AstFunc (_, f) -> f.at | HostFunc _ -> no_region in
  let FuncType (ins, out) = func_type_of clos in
  if List.length vs <> List.length ins then
    Crash.error at "wrong number of arguments";
  let inst = instance (empty_module @@ at) in
  let c = config (List.rev vs) [Invoke clos @@ at] in
  try List.rev (eval inst c)
  with Stack_overflow -> Exhaustion.error at "call stack exhausted"

let eval_const (inst : instance) (const : const) : value =
  let c = config [] (List.map plain const.it) in
  match eval inst c with
  | [v] -> v
  | vs -> Crash.error const.at "wrong number of results on stack"

let i32 (v : value) at =
  match v with
  | I32 i -> i
  | _ -> Crash.error at "type error: i32 value expected"


(* Modules *)

let create_closure (m : module_) (f : func) =
  AstFunc (ref (instance m), f)

let create_table (tab : table) =
  let {ttype = TableType (lim, t)} = tab.it in
  Table.create t lim

let create_memory (mem : memory) =
  let {mtype = MemoryType lim} = mem.it in
  Memory.create lim

let create_global (glob : global) =
  let {gtype = GlobalType (t, _); _} = glob.it in
  ref (default_value t)

let init_closure (inst : instance) (clos : closure) =
  match clos with
  | AstFunc (inst_ref, _) -> inst_ref := inst
  | _ -> assert false

let init_table (inst : instance) (seg : table_segment) =
  let {index; offset = const; init} = seg.it in
  let tab = table inst index in
  let offset = i32 (eval_const inst const) const.at in
  let end_ = Int32.(add offset (of_int (List.length init))) in
  let bound = Table.size tab in
  if I32.lt_u bound end_ || I32.lt_u end_ offset then
    Link.error seg.at "elements segment does not fit table";
  fun () -> Table.blit tab offset (List.map (fun x -> Func (func inst x)) init)

let init_memory (inst : instance) (seg : memory_segment) =
  let {index; offset = const; init} = seg.it in
  let mem = memory inst index in
  let offset' = i32 (eval_const inst const) const.at in
  let offset = I64_convert.extend_u_i32 offset' in
  let end_ = Int64.(add offset (of_int (String.length init))) in
  let bound = Memory.bound mem in
  if I64.lt_u bound end_ || I64.lt_u end_ offset then
    Link.error seg.at "data segment does not fit memory";
  fun () -> Memory.blit mem offset init

let init_global (inst : instance) (ref : value ref) (glob : global) =
  let {value; _} = glob.it in
  ref := eval_const inst value

let check_limits actual expected at =
  if I32.lt_u actual.min expected.min then
    Link.error at "actual size smaller than declared";
  if
    match actual.max, expected.max with
    | _, None -> false
    | None, Some _ -> true
    | Some i, Some j -> I32.gt_u i j
  then Link.error at "maximum size larger than declared"

let add_import (ext : extern) (im : import) (inst : instance) : instance =
  let {idesc; _} = im.it in
  match ext, idesc.it with
  | ExternalFunc clos, FuncImport x when func_type_of clos = (type_ inst x).it ->
    {inst with funcs = clos :: inst.funcs}
  | ExternalTable tab, TableImport (TableType (lim, t))
    when Table.elem_type tab = t ->
    check_limits (Table.limits tab) lim idesc.at;
    {inst with tables = tab :: inst.tables}
  | ExternalMemory mem, MemoryImport (MemoryType lim) ->
    check_limits (Memory.limits mem) lim idesc.at;
    {inst with memories = mem :: inst.memories}
  | ExternalGlobal v, GlobalImport (GlobalType (t, _)) when type_of v = t ->
    {inst with globals = ref v :: inst.globals}
  | _ ->
    Link.error idesc.at "type mismatch"

let add_export (inst : instance) (ex : export) (map : extern ExportMap.t)
  : extern ExportMap.t =
  let {name; edesc} = ex.it in
  let ext =
    match edesc.it with
    | FuncExport x -> ExternalFunc (func inst x)
    | TableExport x -> ExternalTable (table inst x)
    | MemoryExport x -> ExternalMemory (memory inst x)
    | GlobalExport x -> ExternalGlobal !(global inst x)
  in ExportMap.add name ext map

let init (m : module_) (exts : extern list) : instance =
  let
    { imports; tables; memories; globals; funcs;
      exports; elems; data; start; _
    } = m.it
  in
  if List.length exts <> List.length imports then
    Link.error m.at "wrong number of imports provided for initialisation";
  let fs = List.map (create_closure m) funcs in
  let gs = List.map create_global globals in
  let inst =
    List.fold_right2 add_import exts imports
      { (instance m) with
        funcs = fs;
        tables = List.map create_table tables;
        memories = List.map create_memory memories;
        globals = gs;
      }
  in
  List.iter2 (init_global inst) gs globals;
  List.iter (init_closure inst) fs;
  let init_elems = List.map (init_table inst) elems in
  let init_datas = List.map (init_memory inst) data in
  List.iter (fun f -> f ()) init_elems;
  List.iter (fun f -> f ()) init_datas;
  Lib.Option.app (fun x -> ignore (invoke (func inst x) [])) start;
  {inst with exports = List.fold_right (add_export inst) exports inst.exports}
