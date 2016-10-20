open Types
open Ast
open Script
open Source


(* Harness *)

let prefix =
  "'use strict';\n" ^
  "\n" ^
  "let soft_validate = " ^ string_of_bool (not !Flags.unchecked_soft) ^ ";\n" ^
  "\n" ^
  "let spectest = {\n" ^
  "  print: print || ((...xs) => console.log(...xs)),\n" ^
  "  global: 666,\n" ^
  "  table: " ^
  "new WebAssembly.Table({initial: 10, maximum: 20, element: 'anyfunc'})," ^
  "  memory: new WebAssembly.Memory({initial: 1, maximum: 2})," ^
  "};\n" ^
  "\n" ^
  "let registry = {spectest};\n" ^
  "let $$;\n" ^
  "\n" ^
  "function register(name, instance) {\n" ^
  "  registry[name] = instance.exports;\n" ^
  "}\n" ^
  "\n" ^
  "function module(bytes) {\n" ^
  "  let buffer = new ArrayBuffer(bytes.length);\n" ^
  "  let view = new Uint8Array(buffer);\n" ^
  "  for (let i = 0; i < bytes.length; ++i) {\n" ^
  "    view[i] = bytes.charCodeAt(i);\n" ^
  "  }\n" ^
  "  return new WebAssembly.Module(buffer);\n" ^
  "}\n" ^
  "\n" ^
  "function instance(bytes, imports = registry) {\n" ^
  "  return new WebAssembly.Instance(module(bytes), imports);\n" ^
  "}\n" ^
  "\n" ^
  "function assert_malformed(bytes) {\n" ^
  "  try { module(bytes) } catch (e) {\n" ^
  "    if (e instanceof WebAssembly.CompileError) return;\n" ^
  "  }\n" ^
  "  throw new Error(\"Wasm decoding failure expected\");\n" ^
  "}\n" ^
  "\n" ^
  "function assert_invalid(bytes) {\n" ^
  "  try { module(bytes) } catch (e) {\n" ^
  "    if (e instanceof WebAssembly.CompileError) return;\n" ^
  "  }\n" ^
  "  throw new Error(\"Wasm validation failure expected\");\n" ^
  "}\n" ^
  "\n" ^
  "function assert_soft_invalid(bytes) {\n" ^
  "  try { module(bytes) } catch (e) {\n" ^
  "    if (e instanceof WebAssembly.CompileError) return;\n" ^
  "    throw new Error(\"Wasm validation failure expected\");\n" ^
  "  }\n" ^
  "  if (soft_validate)\n" ^
  "    throw new Error(\"Wasm validation failure expected\");\n" ^
  "}\n" ^
  "\n" ^
  "function assert_unlinkable(bytes) {\n" ^
  "  let mod = module(bytes);\n" ^
  "  try { new WebAssembly.Instance(mod, registry) } catch (e) {\n" ^
  "    if (e instanceof TypeError) return;\n" ^
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
  "function assert_return(action, expected) {\n" ^
  "  let actual = action();\n" ^
  "  if (actual !== expected) {\n" ^
  "    throw new Error(\"Wasm return value \" + expected + \" expected, got \" + actual);\n" ^
  "  };\n" ^
  "}\n" ^
  "\n" ^
  "function assert_return_nan(action) {\n" ^
  "  let actual = action();\n" ^
  "  if (!Number.isNaN(actual)) {\n" ^
  "    throw new Error(\"Wasm return value NaN expected, got \" + actual);\n" ^
  "  };\n" ^
  "}\n" ^
  "\n"


(* Context *)

module Map = Map.Make(String)

type exports = external_type Map.t
type modules = exports Map.t

let exports m : exports =
  List.fold_left
    (fun map exp -> Map.add exp.it.name (export_type m exp) map)
    Map.empty m.it.exports

let of_var_opt = function
  | None -> "$$"
  | Some x -> x.it

let bind (mods : modules ref) x_opt m =
	let exports = exports m in
  mods := Map.add "$$" exports (Map.add (of_var_opt x_opt) exports !mods)

let lookup (mods : modules ref) x_opt name at =
	let exports =
    try Map.find (of_var_opt x_opt) !mods with Not_found ->
      raise (Eval.Crash (at, 
         if x_opt = None then "no module defined within script"
         else "unknown module " ^ of_var_opt x_opt ^ " within script"))
  in try Map.find name exports with Not_found ->
    raise (Eval.Crash (at, "unknown export \"" ^ name ^ "\" within module"))


(* Wrappers *)

let eq_of = function
  | I32Type -> Values.I32 I32Op.Eq
  | I64Type -> Values.I64 I64Op.Eq
  | F32Type -> Values.F32 F32Op.Eq
  | F64Type -> Values.F64 F64Op.Eq

let invoke t lits at =
  [t], FuncImport (1l @@ at) @@ at,
  List.map (fun lit -> Const lit @@ at) lits @ [Call (0l @@ at) @@ at]

let get t at =
  [], GlobalImport t @@ at, [GetGlobal (0l @@ at) @@ at]

let assert_nothing ts at =
  [], []

let assert_return lits ts at =
  let test lit = 
    [ Const lit @@ at;
      Compare (eq_of (Values.type_of lit.it)) @@ at;
      Test (Values.I32 I32Op.Eqz) @@ at;
      BrIf (0l @@ at) @@ at ]
  in [], List.flatten (List.rev_map test lits)

let assert_return_nan ts at =
	let var i = Int32.of_int i @@ at in
	let init i t = [GetLocal (var i) @@ at; SetLocal (var i) @@ at] in
  let test i t =
    [ GetLocal (var i) @@ at;
      GetLocal (var i) @@ at;
      Compare (eq_of t) @@ at;
      BrIf (0l @@ at) @@ at ]
  in ts, List.flatten (List.mapi init ts @ List.mapi test ts)

let wrap module_name item_name wrap_action wrap_assertion at =
  let itypes, ikind, action = wrap_action at in
  let locals, assertion = wrap_assertion at in
  let item = Lib.List32.length itypes @@ at in
  let types = FuncType ([], []) :: itypes in
  let imports = [{module_name; item_name; ikind} @@ at] in
  let ekind = FuncExport @@ at in
  let exports = [{name = "run"; ekind; item} @@ at] in
  let body =
    [ Block ([], action @ assertion @ [Return @@ at]) @@ at;
      Unreachable @@ at ]
  in
  let funcs = [{ftype = 0l @@ at; locals; body} @@ at] in
  let m = {empty_module with types; funcs; imports; exports} @@ at in
  Encode.encode m


let is_js_value_type = function
  | I32Type -> true
  | I64Type | F32Type | F64Type -> false

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

let of_string_with add_char s =
  let buf = Buffer.create (4 * String.length s + 2) in
  Buffer.add_char buf '\"';
  String.iter (add_char buf) s;
  Buffer.add_char buf '\"';
  Buffer.contents buf

let of_bytes = of_string_with add_hex_char
let of_string = of_string_with add_char

let of_wrapper x_opt name wrap_action wrap_assertion at =
  let x = of_var_opt x_opt in
  let bs = wrap x name wrap_action wrap_assertion at in
  "instance(" ^ of_bytes bs ^ ", " ^ "{" ^ x ^ ": " ^ x ^ ".exports})" ^
    ".exports.run()"

let of_float z =
  match string_of_float z with
  | "nan" -> "NaN"
  | "-nan" -> "-NaN"
  | "inf" -> "Infinity"
  | "-inf" -> "-Infinity"
  | s -> s

let of_literal lit =
  match lit.it with
  | Values.I32 i -> I32.to_string_s i
  | Values.I64 i -> "int64(\"" ^ I64.to_string_s i ^ "\")"
  | Values.F32 z -> of_float (F32.to_float z)
  | Values.F64 z -> of_float (F64.to_float z)

let of_definition def =
  let bs =
    match def.it with
    | Textual m -> Encode.encode m
    | Encoded (_, bs) -> bs
  in of_bytes bs

let of_action mods act =
  match act.it with
  | Invoke (x_opt, name, lits) ->
    of_var_opt x_opt ^ ".exports[" ^ of_string name ^ "]" ^
      "(" ^ String.concat ", " (List.map of_literal lits) ^ ")",
    (match lookup mods x_opt name act.at with
    | ExternalFuncType ft when not (is_js_func_type ft) ->
      let FuncType (_, out) = ft in
      Some (of_wrapper x_opt name (invoke ft lits), out)
    | _ -> None
    )
  | Get (x_opt, name) ->
    of_var_opt x_opt ^ ".exports[" ^ of_string name ^ "]",
    (match lookup mods x_opt name act.at with
    | ExternalGlobalType gt when not (is_js_global_type gt) ->
      let GlobalType (t, _) = gt in
      Some (of_wrapper x_opt name (get gt), [t])
    | _ -> None
    )

let of_return_assertion mods act js wrapper =
  match of_action mods act with
  | act_js, None -> js act_js ^ ";"
  | act_js, Some (act_wrapper, out) ->
    act_wrapper (wrapper out) act.at ^ ";  // " ^ js act_js

let of_assertion mods ass =
  match ass.it with
  | AssertMalformed (def, _) ->
    "assert_malformed(" ^ of_definition def ^ ");"
  | AssertInvalid (def, _) ->
    "assert_invalid(" ^ of_definition def ^ ");"
  | AssertSoftInvalid (def, _) ->
    "assert_soft_invalid(" ^ of_definition def ^ ");"
  | AssertUnlinkable (def, _) ->
    "assert_unlinkable(" ^ of_definition def ^ ");"
  | AssertUninstantiable (def, _) ->
    "assert_uninstantiable(" ^ of_definition def ^ ");"
  | AssertReturn (act, lits) ->
    of_return_assertion mods act
      (fun act_js ->
        "assert_return(() => " ^ act_js ^
          String.concat ", " ("" :: List.map of_literal lits) ^ ")")
      (assert_return lits)
  | AssertReturnNaN act ->
    of_return_assertion mods act
      (fun act_js -> "assert_return_nan(() => " ^ act_js ^ ")")
      assert_return_nan
  | AssertTrap (act, _) ->
    let js act_js = "assert_trap(() => " ^ act_js ^ ")" in
    match of_action mods act with
    | act_js, None -> js act_js ^ ";"
    | act_js, Some (act_wrapper, ts) ->
      js (act_wrapper (assert_nothing ts) act.at) ^ ";  // " ^ js act_js

let of_command mods cmd =
  match cmd.it with
  | Module (x_opt, def) ->
    let m =
      match def.it with
      | Textual m -> m
      | Encoded (_, bs) -> Decode.decode "binary" bs
    in bind mods x_opt m;
    (if x_opt = None then "" else "let " ^ of_var_opt x_opt ^ " = ") ^
    "$$ = instance(" ^ of_definition def ^ ");\n"
  | Register (name, x_opt) ->
    "register(" ^ of_string name ^ ", " ^ of_var_opt x_opt ^ ")\n"
  | Action act ->
    (match of_action mods act with
    | js, None -> js ^ ";\n"
    | js, Some (wrapper, ts) ->
      wrapper (assert_nothing ts) act.at ^ ";  // " ^ js ^ "\n"
    )
  | Assertion ass ->
    of_assertion mods ass ^ "\n"
  | Meta _ -> assert false

let of_script scr =
  prefix ^ String.concat "" (List.map (of_command (ref Map.empty)) scr)
