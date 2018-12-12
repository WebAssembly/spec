open Types
open Ast
open Script
open Source


(* Harness *)

let harness =
  "'use strict';\n" ^
  "\n" ^
  "let hostrefs = {};\n" ^
  "let hostsym = Symbol(\"hostref\");\n" ^
  "function hostref(s) {\n" ^
  "  if (! (s in hostrefs)) hostrefs[s] = {[hostsym]: s};\n" ^
  "  return hostrefs[s];\n" ^
  "}\n" ^
  "function is_hostref(x) {\n" ^
  "  return (x !== null && hostsym in x) ? 1 : 0;\n" ^
  "}\n" ^
  "function is_funcref(x) {\n" ^
  "  return typeof x === \"function\" ? 1 : 0;\n" ^
  "}\n" ^
  "\n" ^
  "let spectest = {\n" ^
  "  hostref: hostref,\n" ^
  "  is_hostref: is_hostref,\n" ^
  "  is_funcref: is_funcref,\n" ^
  "  print: console.log.bind(console),\n" ^
  "  print_i32: console.log.bind(console),\n" ^
  "  print_i32_f32: console.log.bind(console),\n" ^
  "  print_f64_f64: console.log.bind(console),\n" ^
  "  print_f32: console.log.bind(console),\n" ^
  "  print_f64: console.log.bind(console),\n" ^
  "  global_i32: 666,\n" ^
  "  global_f32: 666,\n" ^
  "  global_f64: 666,\n" ^
  "  table: new WebAssembly.Table({initial: 10, maximum: 20, element: 'anyfunc'}),\n" ^
  "  memory: new WebAssembly.Memory({initial: 1, maximum: 2})\n" ^
  "};\n" ^
  "\n" ^
  "let handler = {\n" ^
  "  get(target, prop) {\n" ^
  "    return (prop in target) ?  target[prop] : {};\n" ^
  "  }\n" ^
  "};\n" ^
  "let registry = new Proxy({spectest}, handler);\n" ^
  "\n" ^
  "function register(name, instance) {\n" ^
  "  registry[name] = instance.exports;\n" ^
  "}\n" ^
  "\n" ^
  "function module(bytes, valid = true) {\n" ^
  "  let buffer = new ArrayBuffer(bytes.length);\n" ^
  "  let view = new Uint8Array(buffer);\n" ^
  "  for (let i = 0; i < bytes.length; ++i) {\n" ^
  "    view[i] = bytes.charCodeAt(i);\n" ^
  "  }\n" ^
  "  let validated;\n" ^
  "  try {\n" ^
  "    validated = WebAssembly.validate(buffer);\n" ^
  "  } catch (e) {\n" ^
  "    throw new Error(\"Wasm validate throws\");\n" ^
  "  }\n" ^
  "  if (validated !== valid) {\n" ^
  "    throw new Error(\"Wasm validate failure\" + " ^
  "(valid ? \"\" : \" expected\"));\n" ^
  "  }\n" ^
  "  return new WebAssembly.Module(buffer);\n" ^
  "}\n" ^
  "\n" ^
  "function instance(bytes, imports = registry) {\n" ^
  "  return new WebAssembly.Instance(module(bytes), imports);\n" ^
  "}\n" ^
  "\n" ^
  "function call(instance, name, args) {\n" ^
  "  return instance.exports[name](...args);\n" ^
  "}\n" ^
  "\n" ^
  "function get(instance, name) {\n" ^
  "  let v = instance.exports[name];\n" ^
  "  return (v instanceof WebAssembly.Global) ? v.value : v;\n" ^
  "}\n" ^
  "\n" ^
  "function exports(instance) {\n" ^
  "  return {module: instance.exports, host: {ref: hostref}};\n" ^
  "}\n" ^
  "\n" ^
  "function run(action) {\n" ^
  "  action();\n" ^
  "}\n" ^
  "\n" ^
  "function assert_malformed(bytes) {\n" ^
  "  try { module(bytes, false) } catch (e) {\n" ^
  "    if (e instanceof WebAssembly.CompileError) return;\n" ^
  "  }\n" ^
  "  throw new Error(\"Wasm decoding failure expected\");\n" ^
  "}\n" ^
  "\n" ^
  "function assert_invalid(bytes) {\n" ^
  "  try { module(bytes, false) } catch (e) {\n" ^
  "    if (e instanceof WebAssembly.CompileError) return;\n" ^
  "  }\n" ^
  "  throw new Error(\"Wasm validation failure expected\");\n" ^
  "}\n" ^
  "\n" ^
  "function assert_unlinkable(bytes) {\n" ^
  "  let mod = module(bytes);\n" ^
  "  try { new WebAssembly.Instance(mod, registry) } catch (e) {\n" ^
  "    if (e instanceof WebAssembly.LinkError) return;\n" ^
  "  }\n" ^
  "  throw new Error(\"Wasm linking failure expected\");\n" ^
  "}\n" ^
  "\n" ^
  "function assert_uninstantiable(bytes) {\n" ^
  "  let mod = module(bytes);\n" ^
  "  try { new WebAssembly.Instance(mod, registry) } catch (e) {\n" ^
  "    if (e instanceof WebAssembly.RuntimeError) return;\n" ^
  "  }\n" ^
  "  throw new Error(\"Wasm trap expected\");\n" ^
  "}\n" ^
  "\n" ^
  "function assert_trap(action) {\n" ^
  "  try { action() } catch (e) {\n" ^
  "    if (e instanceof WebAssembly.RuntimeError) return;\n" ^
  "  }\n" ^
  "  throw new Error(\"Wasm trap expected\");\n" ^
  "}\n" ^
  "\n" ^
  "let StackOverflow;\n" ^
  "try { (function f() { 1 + f() })() } catch (e) { StackOverflow = e.constructor }\n" ^
  "\n" ^
  "function assert_exhaustion(action) {\n" ^
  "  try { action() } catch (e) {\n" ^
  "    if (e instanceof StackOverflow) return;\n" ^
  "  }\n" ^
  "  throw new Error(\"Wasm resource exhaustion expected\");\n" ^
  "}\n" ^
  "\n" ^
  "function assert_return(action, expected) {\n" ^
  "  let actual = action();\n" ^
  "  if (!Object.is(actual, expected)) {\n" ^
  "    throw new Error(\"Wasm return value \" + expected + \" expected, got \" + actual);\n" ^
  "  };\n" ^
  "}\n" ^
  "\n" ^
  "function assert_return_canonical_nan(action) {\n" ^
  "  let actual = action();\n" ^
  "  // Note that JS can't reliably distinguish different NaN values,\n" ^
  "  // so there's no good way to test that it's a canonical NaN.\n" ^
  "  if (!Number.isNaN(actual)) {\n" ^
  "    throw new Error(\"Wasm return value NaN expected, got \" + actual);\n" ^
  "  };\n" ^
  "}\n" ^
  "\n" ^
  "function assert_return_arithmetic_nan(action) {\n" ^
  "  // Note that JS can't reliably distinguish different NaN values,\n" ^
  "  // so there's no good way to test for specific bitpatterns here.\n" ^
  "  let actual = action();\n" ^
  "  if (!Number.isNaN(actual)) {\n" ^
  "    throw new Error(\"Wasm return value NaN expected, got \" + actual);\n" ^
  "  };\n" ^
  "}\n" ^
  "\n" ^
  "function assert_return_ref(action) {\n" ^
  "  let actual = action();\n" ^
  "  if (actual === null || typeof actual !== \"object\" && typeof actual !== \"function\") {\n" ^
  "    throw new Error(\"Wasm reference return value expected, got \" + actual);\n" ^
  "  };\n" ^
  "}\n" ^
  "\n" ^
  "function assert_return_func(action) {\n" ^
  "  let actual = action();\n" ^
  "  if (typeof actual !== \"function\") {\n" ^
  "    throw new Error(\"Wasm function return value expected, got \" + actual);\n" ^
  "  };\n" ^
  "}\n" ^
  "\n"


(* Context *)

module NameMap = Map.Make(struct type t = Ast.name let compare = compare end)
module Map = Map.Make(String)

type exports = extern_type NameMap.t
type modules = {mutable env : exports Map.t; mutable current : int}

let exports m : exports =
  List.fold_left
    (fun map exp -> NameMap.add exp.it.name (export_type m exp) map)
    NameMap.empty m.it.exports

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
let hostref_idx = 1l
let _is_hostref_idx = 2l
let is_funcref_idx = 3l
let eq_ref_idx = 4l
let subject_type_idx = 5l

let eq_of = function
  | I32Type -> Values.I32 I32Op.Eq
  | I64Type -> Values.I64 I64Op.Eq
  | F32Type -> Values.F32 F32Op.Eq
  | F64Type -> Values.F64 F64Op.Eq

let and_of = function
  | I32Type | F32Type -> Values.I32 I32Op.And
  | I64Type | F64Type -> Values.I64 I64Op.And

let reinterpret_of = function
  | I32Type -> I32Type, Nop
  | I64Type -> I64Type, Nop
  | F32Type -> I32Type, Convert (Values.I32 I32Op.ReinterpretFloat)
  | F64Type -> I64Type, Convert (Values.I64 I64Op.ReinterpretFloat)

let canonical_nan_of = function
  | I32Type | F32Type -> Values.I32 (F32.to_bits F32.pos_nan)
  | I64Type | F64Type -> Values.I64 (F64.to_bits F64.pos_nan)

let abs_mask_of = function
  | I32Type | F32Type -> Values.I32 Int32.max_int
  | I64Type | F64Type -> Values.I64 Int64.max_int

let value v =
  match v.it with
  | Values.Num num -> [Const (num @@ v.at) @@ v.at]
  | Values.Ref Values.NullRef -> [RefNull @@ v.at]
  | Values.Ref (HostRef n) ->
    [Const (Values.I32 n @@ v.at) @@ v.at; Call (hostref_idx @@ v.at) @@ v.at]
  | Values.Ref _ -> assert false

let invoke ft vs at =
  [ft @@ at], FuncImport (subject_type_idx @@ at) @@ at,
  List.concat (List.map value vs) @ [Call (subject_idx @@ at) @@ at]

let get t at =
  [], GlobalImport t @@ at, [GlobalGet (subject_idx @@ at) @@ at]

let run ts at =
  [], []

let assert_return vs ts at =
  let test v =
    match v.it with
    | Values.Num num ->
      let t', reinterpret = reinterpret_of (Values.type_of_num num) in
      [ reinterpret @@ at;
        Const (num @@ v.at) @@ at;
        reinterpret @@ at;
        Compare (eq_of t') @@ at;
        Test (Values.I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | Values.Ref Values.NullRef ->
      [ RefIsNull @@ at;
        Test (Values.I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | Values.Ref (HostRef n) ->
      [ Const (Values.I32 n @@ at) @@ at;
        Call (hostref_idx @@ at) @@ at;
        Call (eq_ref_idx @@ at)  @@ at;
        Test (Values.I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | _ -> assert false
  in [], List.flatten (List.rev_map test vs)

let assert_return_nan_bitpattern nan_bitmask_of ts at =
  let test = function
    | NumType t ->
      let t', reinterpret = reinterpret_of t in
      [ reinterpret @@ at;
        Const (nan_bitmask_of t' @@ at) @@ at;
        Binary (and_of t') @@ at;
        Const (canonical_nan_of t' @@ at) @@ at;
        Compare (eq_of t') @@ at;
        Test (Values.I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | RefType _ -> [Br (0l @@ at) @@ at]
  in [], List.flatten (List.rev_map test ts)

let assert_return_canonical_nan = assert_return_nan_bitpattern abs_mask_of
let assert_return_arithmetic_nan = assert_return_nan_bitpattern canonical_nan_of

let assert_return_ref ts at =
  let test = function
    | NumType _ -> [Br (0l @@ at) @@ at]
    | RefType _ ->
      [ RefIsNull @@ at;
        BrIf (0l @@ at) @@ at ]
  in [], List.flatten (List.rev_map test ts)

let assert_return_func ts at =
  let test = function
    | NumType _ -> [Br (0l @@ at) @@ at]
    | RefType _ ->
      [ Call (is_funcref_idx @@ at) @@ at;
        Test (Values.I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
  in [], List.flatten (List.rev_map test ts)

let wrap item_name wrap_action wrap_assertion at =
  let itypes, idesc, action = wrap_action at in
  let locals, assertion = wrap_assertion at in
  let item = Lib.List32.length itypes @@ at in
  let types =
    (FuncType ([], []) @@ at) ::
    (FuncType ([NumType I32Type], [RefType AnyRefType]) @@ at) ::
    (FuncType ([RefType AnyRefType], [NumType I32Type]) @@ at) ::
    (FuncType ([RefType AnyRefType], [NumType I32Type]) @@ at) ::
    (FuncType ([RefType AnyRefType; RefType AnyRefType], [NumType I32Type]) @@ at) ::
    itypes
  in
  let imports =
    [ {module_name = Utf8.decode "module"; item_name; idesc} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "hostref";
       idesc = FuncImport (1l @@ at) @@ at} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "is_hostref";
       idesc = FuncImport (2l @@ at) @@ at} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "is_funcref";
       idesc = FuncImport (3l @@ at) @@ at} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "eq_ref";
       idesc = FuncImport (4l @@ at) @@ at} @@ at ]
  in
  let edesc = FuncExport item @@ at in
  let exports = [{name = Utf8.decode "run"; edesc} @@ at] in
  let body =
    [ Block ([], action @ assertion @ [Return @@ at]) @@ at;
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
  let open Values in
  match v.it with
  | Num (I32 i) -> I32.to_string_s i
  | Num (I64 i) -> "int64(\"" ^ I64.to_string_s i ^ "\")"
  | Num (F32 z) -> of_float (F32.to_float z)
  | Num (F64 z) -> of_float (F64.to_float z)
  | Ref NullRef -> "null"
  | Ref (HostRef n) -> "hostref(" ^ Int32.to_string n ^ ")"
  | _ -> assert false

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
  | AssertReturn (act, vs) ->
    of_assertion' mods act "assert_return" (List.map of_value vs)
      (Some (assert_return vs))
  | AssertReturnCanonicalNaN act ->
    of_assertion' mods act "assert_return_canonical_nan" []
      (Some assert_return_canonical_nan)
  | AssertReturnArithmeticNaN act ->
    of_assertion' mods act "assert_return_arithmetic_nan" []
      (Some assert_return_arithmetic_nan)
  | AssertReturnRef act ->
    of_assertion' mods act "assert_return_ref" [] (Some assert_return_ref)
  | AssertReturnFunc act ->
    of_assertion' mods act "assert_return_func" [] (Some assert_return_func)
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
