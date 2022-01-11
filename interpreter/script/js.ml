open Types
open Ast
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
function is_externref(x) {
  return (x !== null && externsym in x) ? 1 : 0;
}
function is_funcref(x) {
  return typeof x === "function" ? 1 : 0;
}
function eq_externref(x, y) {
  return x === y ? 1 : 0;
}
function eq_funcref(x, y) {
  return x === y ? 1 : 0;
}

let spectest = {
  externref: externref,
  is_externref: is_externref,
  is_funcref: is_funcref,
  eq_externref: eq_externref,
  eq_funcref: eq_funcref,
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
let externref_idx = 1l
let is_externref_idx = 2l
let is_funcref_idx = 3l
let eq_externref_idx = 4l
let _eq_funcref_idx = 5l
let subject_type_idx = 6l

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
  | Values.Num n -> [Const (n @@ v.at) @@ v.at]
  | Values.Vec s -> [VecConst (s @@ v.at) @@ v.at]
  | Values.Ref (Values.NullRef t) -> [RefNull t @@ v.at]
  | Values.Ref (ExternRef n) ->
    [Const (Values.I32 n @@ v.at) @@ v.at; Call (externref_idx @@ v.at) @@ v.at]
  | Values.Ref _ -> assert false

let invoke ft vs at =
  [ft @@ at], FuncImport (subject_type_idx @@ at) @@ at,
  List.concat (List.map value vs) @ [Call (subject_idx @@ at) @@ at]

let get t at =
  [], GlobalImport t @@ at, [GlobalGet (subject_idx @@ at) @@ at]

let run _ts _at =
  [], []

let assert_return ress _ts at =
  let test res =
    let nan_bitmask_of = function
      | CanonicalNan -> abs_mask_of (* must only differ from the canonical NaN in its sign bit *)
      | ArithmeticNan -> canonical_nan_of (* can be any NaN that's one everywhere the canonical NaN is one *)
    in
    match res.it with
    | NumResult (NumPat {it = num; at = at'}) ->
      let t', reinterpret = reinterpret_of (Values.type_of_num num) in
      [ reinterpret @@ at;
        Const (num @@ at')  @@ at;
        reinterpret @@ at;
        Compare (eq_of t') @@ at;
        Test (Values.I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | NumResult (NanPat nanop) ->
      let nan =
        match nanop.it with
        | Values.I32 _ | Values.I64 _ -> .
        | Values.F32 n | Values.F64 n -> n
      in
      let t = Values.type_of_num nanop.it in
      let t', reinterpret = reinterpret_of t in
      [ reinterpret @@ at;
        Const (nan_bitmask_of nan t' @@ at) @@ at;
        Binary (and_of t') @@ at;
        Const (canonical_nan_of t' @@ at) @@ at;
        Compare (eq_of t') @@ at;
        Test (Values.I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | VecResult (VecPat (Values.V128 (shape, pats))) ->
      let open Values in
      (* VecResult is a list of NumPat or LitPat. For float shapes, we can have a mix of literals
       * and NaNs. For NaNs, we need to mask it and compare with a canonical NaN. To simplify
       * comparison, we build masks even for literals (will just be all set), collect them into
       * a v128, then compare the entire 128 bits.
       *)
      let mask_and_canonical = function
        | NumPat {it = I32 _ as i; _} -> I32 (Int32.minus_one), i
        | NumPat {it = I64 _ as i; _} -> I64 (Int64.minus_one), i
        | NumPat {it = F32 f; _} ->
          I32 (Int32.minus_one), I32 (I32_convert.reinterpret_f32 f)
        | NumPat {it = F64 f; _} ->
          I64 (Int64.minus_one), I64 (I64_convert.reinterpret_f64 f)
        | NanPat {it = F32 nan; _} ->
          nan_bitmask_of nan I32Type, canonical_nan_of I32Type
        | NanPat {it = F64 nan; _} ->
          nan_bitmask_of nan I64Type, canonical_nan_of I64Type
        | _ -> .
      in
      let masks, canons = List.split (List.map (fun p -> mask_and_canonical p) pats) in
      let all_ones = V128.I32x4.of_lanes (List.init 4 (fun _ -> Int32.minus_one)) in
      let mask, expected = match shape with
        | V128.I8x16 () ->
          all_ones, V128.I8x16.of_lanes (List.map (I32Num.of_num 0) canons)
        | V128.I16x8 () ->
          all_ones, V128.I16x8.of_lanes (List.map (I32Num.of_num 0) canons)
        | V128.I32x4 () ->
          all_ones, V128.I32x4.of_lanes (List.map (I32Num.of_num 0) canons)
        | V128.I64x2 () ->
          all_ones, V128.I64x2.of_lanes (List.map (I64Num.of_num 0) canons)
        | V128.F32x4 () ->
          V128.I32x4.of_lanes (List.map (I32Num.of_num 0) masks),
          V128.I32x4.of_lanes (List.map (I32Num.of_num 0) canons)
        | V128.F64x2 () ->
          V128.I64x2.of_lanes (List.map (I64Num.of_num 0) masks),
          V128.I64x2.of_lanes (List.map (I64Num.of_num 0) canons)
      in
      [ VecConst (V128 mask @@ at) @@ at;
        VecBinaryBits (V128 V128Op.And) @@ at;
        VecConst (V128 expected @@ at) @@ at;
        VecCompare (V128 (V128.I8x16 V128Op.Eq)) @@ at;
        (* If all lanes are non-zero, then they are equal *)
        VecTest (V128 (V128.I8x16 V128Op.AllTrue)) @@ at;
        Test (I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | RefResult (RefPat {it = Values.NullRef _t; _}) ->
      [ RefIsNull @@ at;
        Test (Values.I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | RefResult (RefPat {it = ExternRef n; _}) ->
      [ Const (Values.I32 n @@ at) @@ at;
        Call (externref_idx @@ at) @@ at;
        Call (eq_externref_idx @@ at)  @@ at;
        Test (Values.I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | RefResult (RefPat _) ->
      assert false
    | RefResult (RefTypePat t) ->
      let is_ref_idx =
        match t with
        | FuncRefType -> is_funcref_idx
        | ExternRefType -> is_externref_idx
      in
      [ Call (is_ref_idx @@ at) @@ at;
        Test (Values.I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
  in [], List.flatten (List.rev_map test ress)

let wrap item_name wrap_action wrap_assertion at =
  let itypes, idesc, action = wrap_action at in
  let locals, assertion = wrap_assertion at in
  let types =
    (FuncType ([], []) @@ at) ::
    (FuncType ([NumType I32Type], [RefType ExternRefType]) @@ at) ::
    (FuncType ([RefType ExternRefType], [NumType I32Type]) @@ at) ::
    (FuncType ([RefType FuncRefType], [NumType I32Type]) @@ at) ::
    (FuncType ([RefType ExternRefType; RefType ExternRefType], [NumType I32Type]) @@ at) ::
    (FuncType ([RefType FuncRefType; RefType FuncRefType], [NumType I32Type]) @@ at) ::
    itypes
  in
  let imports =
    [ {module_name = Utf8.decode "module"; item_name; idesc} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "externref";
       idesc = FuncImport (1l @@ at) @@ at} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "is_externref";
       idesc = FuncImport (2l @@ at) @@ at} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "is_funcref";
       idesc = FuncImport (3l @@ at) @@ at} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "eq_externref";
       idesc = FuncImport (4l @@ at) @@ at} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "eq_funcref";
       idesc = FuncImport (5l @@ at) @@ at} @@ at ]
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
  | VecType _t -> false
  | RefType _t -> true

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

let of_num n =
  let open Values in
  match n with
  | I32 i -> I32.to_string_s i
  | I64 i -> "int64(\"" ^ I64.to_string_s i ^ "\")"
  | F32 z -> of_float (F32.to_float z)
  | F64 z -> of_float (F64.to_float z)

let of_vec v =
  let open Values in
  match v with
  | V128 v -> "v128(\"" ^ V128.to_string v ^ "\")"

let of_ref r =
  let open Values in
  match r with
  | NullRef _ -> "null"
  | ExternRef n -> "externref(" ^ Int32.to_string n ^ ")"
  | _ -> assert false

let of_value v =
  let open Values in
  match v.it with
  | Num n -> of_num n
  | Vec v -> of_vec v
  | Ref r -> of_ref r

let of_nan = function
  | CanonicalNan -> "\"nan:canonical\""
  | ArithmeticNan -> "\"nan:arithmetic\""

let of_num_pat = function
  | NumPat num -> of_num num.it
  | NanPat nanop ->
    match nanop.it with
    | Values.I32 _ | Values.I64 _ -> .
    | Values.F32 n | Values.F64 n -> of_nan n

let of_vec_pat = function
  | VecPat (Values.V128 (_shape, pats)) ->
    Printf.sprintf "v128(\"%s\")" (String.concat " " (List.map of_num_pat pats))

let of_ref_pat = function
  | RefPat r -> of_ref r.it
  | RefTypePat t -> "\"ref." ^ string_of_refed_type t ^ "\""

let of_result res =
  match res.it with
  | NumResult np -> of_num_pat np
  | VecResult vp -> of_vec_pat vp
  | RefResult rp -> of_ref_pat rp

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
