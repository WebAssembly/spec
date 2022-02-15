open Types
open Ast
open Value
open Script
open Source


(* Harness *)

let harness =
{|
'use strict';

let externrefs = {};
let externsym = Symbol("externref");
function externref(s) {
  if (! (s in externrefs)) externrefs[s] = {[externsym]: s};
  return externrefs[s];
}
function is_anyref(x) {
  return x !== null ? 1 : 0;
}
function is_eqref(x) {
  return x !== null ? 1 : 0;  // TODO
}
function is_i31ref(x) {
  return typeof x === "number" && (x | 0x7fffffff) === x ? 1 : 0;
}
function is_dataref(x) {
  return x !== null && typeof x !== "function" ? 1 : 0;
}
function is_funcref(x) {
  return typeof x === "function" ? 1 : 0;
}
function is_externref(x) {
  return (x !== null && externsym in x) ? 1 : 0;
}
function eq_ref(x, y) {
  return x === y ? 1 : 0;
}

let spectest = {
  externref: externref,
  is_anyref: is_anyref,
  is_eqref: is_eqref,
  is_i31ref: is_i31ref,
  is_dataref: is_dataref,
  is_funcref: is_funcref,
  is_externref: is_externref,
  eq_ref: eq_ref,
  print: console.log.bind(console),
  print_i32: console.log.bind(console),
  print_i32_f32: console.log.bind(console),
  print_f64_f64: console.log.bind(console),
  print_f32: console.log.bind(console),
  print_f64: console.log.bind(console),
  global_i32: 666,
  global_i64: 666n,
  global_f32: 666,
  global_f64: 666,
  table: new WebAssembly.Table({initial: 10, maximum: 20, element: 'anyfunc'}),
  memory: new WebAssembly.Memory({initial: 1, maximum: 2})
};

let handler = {
  get(target, prop) {
    return (prop in target) ?  target[prop] : {};
  }
};
let registry = new Proxy({spectest}, handler);

function register(name, instance) {
  registry[name] = instance.exports;
}

function module(bytes, valid = true) {
  let buffer = new ArrayBuffer(bytes.length);
  let view = new Uint8Array(buffer);
  for (let i = 0; i < bytes.length; ++i) {
    view[i] = bytes.charCodeAt(i);
  }
  let validated;
  try {
    validated = WebAssembly.validate(buffer);
  } catch (e) {
    throw new Error("Wasm validate throws");
  }
  if (validated !== valid) {
    throw new Error("Wasm validate failure" + (valid ? "" : " expected"));
  }
  return new WebAssembly.Module(buffer);
}

function instance(bytes, imports = registry) {
  return new WebAssembly.Instance(module(bytes), imports);
}

function call(instance, name, args) {
  return instance.exports[name](...args);
}

function get(instance, name) {
  let v = instance.exports[name];
  return (v instanceof WebAssembly.Global) ? v.value : v;
}

function exports(instance) {
  return {module: instance.exports, spectest: spectest};
}

function run(action) {
  action();
}

function assert_malformed(bytes) {
  try { module(bytes, false) } catch (e) {
    if (e instanceof WebAssembly.CompileError) return;
  }
  throw new Error("Wasm decoding failure expected");
}

function assert_invalid(bytes) {
  try { module(bytes, false) } catch (e) {
    if (e instanceof WebAssembly.CompileError) return;
  }
  throw new Error("Wasm validation failure expected");
}

function assert_unlinkable(bytes) {
  let mod = module(bytes);
  try { new WebAssembly.Instance(mod, registry) } catch (e) {
    if (e instanceof WebAssembly.LinkError) return;
  }
  throw new Error("Wasm linking failure expected");
}

function assert_uninstantiable(bytes) {
  let mod = module(bytes);
  try { new WebAssembly.Instance(mod, registry) } catch (e) {
    if (e instanceof WebAssembly.RuntimeError) return;
  }
  throw new Error("Wasm trap expected");
}

function assert_trap(action) {
  try { action() } catch (e) {
    if (e instanceof WebAssembly.RuntimeError) return;
  }
  throw new Error("Wasm trap expected");
}

let StackOverflow;
try { (function f() { 1 + f() })() } catch (e) { StackOverflow = e.constructor }

function assert_exhaustion(action) {
  try { action() } catch (e) {
    if (e instanceof StackOverflow) return;
  }
  throw new Error("Wasm resource exhaustion expected");
}

function assert_return(action, ...expected) {
  let actual = action();
  if (actual === undefined) {
    actual = [];
  } else if (!Array.isArray(actual)) {
    actual = [actual];
  }
  if (actual.length !== expected.length) {
    throw new Error(expected.length + " value(s) expected, got " + actual.length);
  }
  for (let i = 0; i < actual.length; ++i) {
    switch (expected[i]) {
      case "nan:canonical":
      case "nan:arithmetic":
      case "nan:any":
        // Note that JS can't reliably distinguish different NaN values,
        // so there's no good way to test that it's a canonical NaN.
        if (!Number.isNaN(actual[i])) {
          throw new Error("Wasm return value NaN expected, got " + actual[i]);
        };
        return;
      case "ref.func":
        if (typeof actual[i] !== "function") {
          throw new Error("Wasm function return value expected, got " + actual[i]);
        };
        return;
      case "ref.extern":
        if (actual[i] === null) {
          throw new Error("Wasm reference return value expected, got " + actual[i]);
        };
        return;
      case "ref.null":
        if (actual !== null) {
          throw new Error("Wasm null return value expected, got " + actual);
        };
        return;
      default:
        if (!Object.is(actual[i], expected[i])) {
          throw new Error("Wasm return value " + expected[i] + " expected, got " + actual[i]);
        };
    }
  }
}
|}


(* Context *)

module NameMap = Map.Make(struct type t = Ast.name let compare = compare end)
module Map = Map.Make(String)

type exports = extern_type NameMap.t
type modules = {mutable env : exports Map.t; mutable current : int}

let exports m : exports =
  let ets = List.map (export_type_of m) m.it.exports in
  List.fold_left (fun map (ExportType (et, name)) -> NameMap.add name et map)
    NameMap.empty ets

let modules () : modules = {env = Map.empty; current = 0}

let current_var (mods : modules) = "$" ^ string_of_int mods.current
let of_var_opt (mods : modules) = function
  | None -> current_var mods
  | Some x -> x.it

let bind (mods : modules) x_opt m =
  let exports = exports m in
  mods.current <- mods.current + 1;
  mods.env <- Map.add (of_var_opt mods x_opt) exports mods.env;
  if x_opt <> None then mods.env <- Map.add (current_var mods) exports mods.env

let lookup (mods : modules) x_opt name at =
  let exports =
    try Map.find (of_var_opt mods x_opt) mods.env with Not_found ->
      raise (Eval.Crash (at, 
        if x_opt = None then "no module defined within script"
        else "unknown module " ^ of_var_opt mods x_opt ^ " within script"))
  in try NameMap.find name exports with Not_found ->
    raise (Eval.Crash (at, "unknown export \"" ^
      string_of_name name ^ "\" within module"))


(* Wrappers *)

let subject_idx = 0l
let externref_idx = 1l
let is_eqref_idx = 2l
let eq_ref_idx = 3l
let subject_type_idx = 4l

let eq_of = function
  | I32Type -> I32 I32Op.Eq
  | I64Type -> I64 I64Op.Eq
  | F32Type -> F32 F32Op.Eq
  | F64Type -> F64 F64Op.Eq

let and_of = function
  | I32Type | F32Type -> I32 I32Op.And
  | I64Type | F64Type -> I64 I64Op.And

let reinterpret_of = function
  | I32Type -> I32Type, Nop
  | I64Type -> I64Type, Nop
  | F32Type -> I32Type, Convert (I32 I32Op.ReinterpretFloat)
  | F64Type -> I64Type, Convert (I64 I64Op.ReinterpretFloat)

let canonical_nan_of = function
  | I32Type | F32Type -> I32 (F32.to_bits F32.pos_nan)
  | I64Type | F64Type -> I64 (F64.to_bits F64.pos_nan)

let abs_mask_of = function
  | I32Type | F32Type -> I32 Int32.max_int
  | I64Type | F64Type -> I64 Int64.max_int

let value v =
  match v.it with
  | Num num -> [Const (num @@ v.at) @@ v.at]
  | Ref (NullRef t) -> [RefNull t @@ v.at]
  | Ref (ExternRef n) ->
    [Const (I32 n @@ v.at) @@ v.at; Call (externref_idx @@ v.at) @@ v.at]
  | Ref _ -> assert false

let invoke ft vs at =
  let dt = RecDefType [SubType ([], FuncDefType ft)] in
  [dt @@ at], FuncImport (subject_type_idx @@ at) @@ at,
  List.concat (List.map value vs) @ [Call (subject_idx @@ at) @@ at]

let get t at =
  [], GlobalImport t @@ at, [GlobalGet (subject_idx @@ at) @@ at]

let run ts at =
  [], []

let assert_return ress ts at =
  let test (res, t) =
    match res.it with
    | LitResult {it = Num num; at = at'} ->
      let t', reinterpret = reinterpret_of (type_of_num num) in
      [ reinterpret @@ at;
        Const (num @@ at')  @@ at;
        reinterpret @@ at;
        Compare (eq_of t') @@ at;
        Test (I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | LitResult {it = Ref (NullRef t); _} ->
      [ RefTest NullOp @@ at;
        Test (I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | LitResult {it = Ref (ExternRef n); _} ->
      [ Const (I32 n @@ at) @@ at;
        Call (externref_idx @@ at) @@ at;
        Call (eq_ref_idx @@ at)  @@ at;
        Test (I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | LitResult {it = Ref _; _} ->
      assert false
    | NanResult nanop ->
      let nan =
        match nanop.it with
        | I32 _ | I64 _ -> assert false
        | F32 n | F64 n -> n
      in
      let nan_bitmask_of =
        match nan with
        | CanonicalNan -> abs_mask_of (* must only differ from the canonical NaN in its sign bit *)
        | ArithmeticNan -> canonical_nan_of (* can be any NaN that's one everywhere the canonical NaN is one *)
      in
      let t = type_of_num nanop.it in
      let t', reinterpret = reinterpret_of t in
      [ reinterpret @@ at;
        Const (nan_bitmask_of t' @@ at) @@ at;
        Binary (and_of t') @@ at;
        Const (canonical_nan_of t' @@ at) @@ at;
        Compare (eq_of t') @@ at;
        Test (I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | RefResult t ->
      let is_ref =
        match t with
        | AnyHeapType -> Const (I32 1l @@ at)
        | EqHeapType -> Call (is_eqref_idx @@ at)
        | I31HeapType -> RefTest I31Op
        | DataHeapType -> RefTest DataOp
        | ArrayHeapType -> RefTest ArrayOp
        | FuncHeapType -> RefTest FuncOp
        | DefHeapType _ -> Const (I32 1l @@ at) (* TODO *)
        | RttHeapType _ -> Const (I32 1l @@ at) (* TODO *)
        | BotHeapType -> assert false
      in
      [ is_ref @@ at;
        Test (I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | NullResult ->
      (match t with
      | RefType _ ->
        [ BrCast (0l @@ at, NullOp) @@ at ]
      | _ ->
        [ Br (0l @@ at) @@ at ]
      )
  in [], List.flatten (List.rev_map test (List.combine ress ts))

let i32_type = NumType I32Type
let anyref_type = RefType (Nullable, AnyHeapType)
let eqref_type = RefType (Nullable, EqHeapType)
let func_def_type ins out at =
  RecDefType [SubType ([], FuncDefType (FuncType (ins, out)))] @@ at

let wrap item_name wrap_action wrap_assertion at =
  let itypes, idesc, action = wrap_action at in
  let locals, assertion = wrap_assertion at in
  let types =
    func_def_type [] [] at ::
    func_def_type [i32_type] [anyref_type] at ::
    func_def_type [anyref_type] [i32_type] at ::
    func_def_type [eqref_type; eqref_type] [i32_type] at ::
    itypes
  in
  let imports =
    [ {module_name = Utf8.decode "module"; item_name; idesc} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "externref";
       idesc = FuncImport (1l @@ at) @@ at} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "is_eqref";
       idesc = FuncImport (2l @@ at) @@ at} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "eq_ref";
       idesc = FuncImport (3l @@ at) @@ at} @@ at;
    ]
  in
  let item =
    List.fold_left
      (fun i im ->
        match im.it.idesc.it with FuncImport _ -> Int32.add i 1l | _ -> i
      ) 0l imports @@ at
  in
  let edesc = FuncExport item @@ at in
  let exports = [{name = Utf8.decode "run"; edesc} @@ at] in
  let body =
    [ Block (ValBlockType None, action @ assertion @ [Return @@ at]) @@ at;
      Unreachable @@ at ]
  in
  let funcs = [{ftype = 0l @@ at; locals; body} @@ at] in
  let m = {empty_module with types; funcs; imports; exports} @@ at in
  Encode.encode m


let is_js_num_type = function
  | I32Type -> true
  | I64Type | F32Type | F64Type -> false

let is_js_value_type = function
  | NumType t -> is_js_num_type t
  | RefType t -> true
  | BotType -> assert false

let is_js_global_type = function
  | GlobalType (t, mut) -> is_js_value_type t && mut = Immutable

let is_js_func_type = function
  | FuncType (ins, out) -> List.for_all is_js_value_type (ins @ out)


(* Script conversion *)

let add_hex_char buf c = Printf.bprintf buf "\\x%02x" (Char.code c)
let add_char buf c =
  if c < '\x20' || c >= '\x7f' then
    add_hex_char buf c
  else begin
    if c = '\"' || c = '\\' then Buffer.add_char buf '\\';
    Buffer.add_char buf c
  end
let add_unicode_char buf uc =
  if uc < 0x20 || uc >= 0x7f then
    Printf.bprintf buf "\\u{%02x}" uc
  else
    add_char buf (Char.chr uc)

let of_string_with iter add_char s =
  let buf = Buffer.create 256 in
  Buffer.add_char buf '\"';
  iter (add_char buf) s;
  Buffer.add_char buf '\"';
  Buffer.contents buf

let of_bytes = of_string_with String.iter add_hex_char
let of_name = of_string_with List.iter add_unicode_char

let of_float z =
  match string_of_float z with
  | "nan" -> "NaN"
  | "-nan" -> "-NaN"
  | "inf" -> "Infinity"
  | "-inf" -> "-Infinity"
  | s -> s

let of_value v =
  match v.it with
  | Num (I32 i) -> I32.to_string_s i
  | Num (I64 i) -> "int64(\"" ^ I64.to_string_s i ^ "\")"
  | Num (F32 z) -> of_float (F32.to_float z)
  | Num (F64 z) -> of_float (F64.to_float z)
  | Ref (NullRef _) -> "null"
  | Ref (ExternRef n) -> "externref(" ^ Int32.to_string n ^ ")"
  | _ -> assert false

let of_nan = function
  | CanonicalNan -> "\"nan:canonical\""
  | ArithmeticNan -> "\"nan:arithmetic\""

let of_result res =
  match res.it with
  | LitResult value -> of_value value
  | NanResult nanop ->
    (match nanop.it with
    | I32 _ | I64 _ -> assert false
    | F32 n | F64 n -> of_nan n
    )
  | RefResult t -> "\"ref." ^ string_of_heap_type t ^ "\""
  | NullResult -> "\"ref.null\""

let rec of_definition def =
  match def.it with
  | Textual m -> of_bytes (Encode.encode m)
  | Encoded (_, bs) -> of_bytes bs
  | Quoted (_, s) ->
    try of_definition (Parse.string_to_module s) with Parse.Syntax _ ->
      of_bytes "<malformed quote>"

let of_wrapper mods x_opt name wrap_action wrap_assertion at =
  let x = of_var_opt mods x_opt in
  let bs = wrap name wrap_action wrap_assertion at in
  "call(instance(" ^ of_bytes bs ^ ", " ^
    "exports(" ^ x ^ ")), " ^ " \"run\", [])"

let of_action mods act =
  match act.it with
  | Invoke (x_opt, name, vs) ->
    "call(" ^ of_var_opt mods x_opt ^ ", " ^ of_name name ^ ", " ^
      "[" ^ String.concat ", " (List.map of_value vs) ^ "])",
    (match lookup mods x_opt name act.at with
    | ExternFuncType ft when not (is_js_func_type ft) ->
      let FuncType (_, out) = ft in
      Some (of_wrapper mods x_opt name (invoke ft vs), out)
    | _ -> None
    )
  | Get (x_opt, name) ->
    "get(" ^ of_var_opt mods x_opt ^ ", " ^ of_name name ^ ")",
    (match lookup mods x_opt name act.at with
    | ExternGlobalType gt when not (is_js_global_type gt) ->
      let GlobalType (t, _) = gt in
      Some (of_wrapper mods x_opt name (get gt), [t])
    | _ -> None
    )

let of_assertion' mods act name args wrapper_opt =
  let act_js, act_wrapper_opt = of_action mods act in
  let js = name ^ "(() => " ^ act_js ^ String.concat ", " ("" :: args) ^ ")" in
  match act_wrapper_opt with
  | None -> js ^ ";"
  | Some (act_wrapper, out) ->
    let run_name, wrapper =
      match wrapper_opt with
      | None -> name, run
      | Some wrapper -> "run", wrapper
    in run_name ^ "(() => " ^ act_wrapper (wrapper out) act.at ^ ");  // " ^ js

let of_assertion mods ass =
  match ass.it with
  | AssertMalformed (def, _) ->
    "assert_malformed(" ^ of_definition def ^ ");"
  | AssertInvalid (def, _) ->
    "assert_invalid(" ^ of_definition def ^ ");"
  | AssertUnlinkable (def, _) ->
    "assert_unlinkable(" ^ of_definition def ^ ");"
  | AssertUninstantiable (def, _) ->
    "assert_uninstantiable(" ^ of_definition def ^ ");"
  | AssertReturn (act, ress) ->
    of_assertion' mods act "assert_return" (List.map of_result ress)
      (Some (assert_return ress))
  | AssertTrap (act, _) ->
    of_assertion' mods act "assert_trap" [] None
  | AssertExhaustion (act, _) ->
    of_assertion' mods act "assert_exhaustion" [] None

let of_command mods cmd =
  "\n// " ^ Filename.basename cmd.at.left.file ^
    ":" ^ string_of_int cmd.at.left.line ^ "\n" ^
  match cmd.it with
  | Module (x_opt, def) ->
    let rec unquote def =
      match def.it with
      | Textual m -> m
      | Encoded (_, bs) -> Decode.decode "binary" bs
      | Quoted (_, s) -> unquote (Parse.string_to_module s)
    in bind mods x_opt (unquote def);
    "let " ^ current_var mods ^ " = instance(" ^ of_definition def ^ ");\n" ^
    (if x_opt = None then "" else
    "let " ^ of_var_opt mods x_opt ^ " = " ^ current_var mods ^ ";\n")
  | Register (name, x_opt) ->
    "register(" ^ of_name name ^ ", " ^ of_var_opt mods x_opt ^ ")\n"
  | Action act ->
    of_assertion' mods act "run" [] None ^ "\n"
  | Assertion ass ->
    of_assertion mods ass ^ "\n"
  | Meta _ -> assert false

let of_script scr =
  (if !Flags.harness then harness else "") ^
  String.concat "" (List.map (of_command (modules ())) scr)
