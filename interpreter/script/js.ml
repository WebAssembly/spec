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
  print_i64: console.log.bind(console),
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
  return instance;
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
    let error;
    skip: if (valid) {
      try {
        new WebAssembly.Module(buffer);
      } catch (e) {
        error = ": " + e;
        break skip;
      }
      throw new Error("Wasm compile does not throw, although validation failed");
    } else {
      error = " expected";
    }
    throw new Error("Wasm validate failure" + error);
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
  let global = instance.exports[name];
  if (v instanceof WebAssembly.Global) return v.value;
  throw new Error("Wasm global expected");
}

function set(instance, name, arg) {
  let global = instance.exports[name];
  if (v instanceof WebAssembly.Global) {
    try {
      v.value = arg; return;
    } catch (e) {}
  }
  throw new Error("Wasm mutable global expected");
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


(* Errors & Tracing *)

module Error = Error.Make ()

exception Error = Error.Error


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
let var_opt (mods : modules) = function
  | None -> current_var mods
  | Some x -> x.it

let bind (mods : modules) x_opt m =
  let exports = exports m in
  mods.current <- mods.current + 1;
  mods.env <- Map.add (var_opt mods x_opt) exports mods.env;
  if x_opt <> None then mods.env <- Map.add (current_var mods) exports mods.env

let lookup (mods : modules) x_opt name at =
  let exports =
    try Map.find (var_opt mods x_opt) mods.env with Not_found ->
      Error.error at 
        (if x_opt = None then "no module defined within script"
         else "unknown module " ^ var_opt mods x_opt ^ " within script")
  in try NameMap.find name exports with Not_found ->
    Error.error at ("unknown export \"" ^
      string_of_name name ^ "\" within module")

let lookup_func (mods : modules) x_opt name at =
  match lookup mods x_opt name at with
  | ExternFuncType ft -> ft
  | _ ->
    Error.error at ("export \"" ^
      string_of_name name ^ "\" is not a function")

let lookup_global (mods : modules) x_opt name at =
  match lookup mods x_opt name at with
  | ExternGlobalType gt -> gt
  | _ ->
    Error.error at ("export \"" ^
      string_of_name name ^ "\" is not a global")


(* Dependencies for Wasm wrappers *)

type deps =
  { mutable dtypes : func_type list;
    mutable descs : (import_desc' * int32) NameMap.t Map.t;
    func_idx : int32 ref;
    global_idx : int32 ref;
  }

let new_deps () =
  { dtypes = []; descs = Map.empty;
    func_idx = ref 0l; global_idx = ref 0l }

let dep deps x name idxr idesc =
  let nmap =
    match Map.find_opt x deps.descs with
    | Some nmap -> nmap
    | None -> NameMap.empty
  in
  match NameMap.find_opt name nmap with
  | Some (_, idx) -> idx
  | None ->
    let idx = !idxr in
    deps.descs <-
      Map.add x (NameMap.add name (idesc, idx) nmap) deps.descs;
    idxr := Int32.add idx 1l;
    idx

let dep_type deps ft =
  match Lib.List.index_of ft deps.dtypes with
  | Some i -> Int32.of_int i
  | None ->
    let idx = Lib.List32.length deps.dtypes in
    deps.dtypes <- deps.dtypes @ [ft];
    idx

let dep_global deps x name gt =
  dep deps x name deps.global_idx (GlobalImport gt)

let dep_func deps x name ft =
  dep deps x name deps.func_idx
    (FuncImport (dep_type deps ft @@ Source.no_region))

let dep_spectest deps name ft =
  dep_func deps "spectest" (Utf8.decode name) ft

let dep_spectest_externref deps =
  dep_spectest deps "externref"
    (FuncType ([NumType I32Type], [RefType ExternRefType]))
let dep_spectest_is_externref deps =
  dep_spectest deps "is_externref"
    (FuncType ([RefType ExternRefType], [NumType I32Type]))
let dep_spectest_is_funcref deps =
  dep_spectest deps "is_funcref"
    (FuncType ([RefType FuncRefType], [NumType I32Type]))
let dep_spectest_eq_externref deps =
  dep_spectest deps "eq_externref"
    (FuncType ([RefType ExternRefType; RefType ExternRefType], [NumType I32Type]))
let _dep_spectest_eq_funcref deps =
  dep_spectest deps "eq_funcref"
    (FuncType ([RefType FuncRefType; RefType FuncRefType], [NumType I32Type]))


(* Script conversion to Wasm wrappers *)

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

let nan_bitmask_of = function
  | CanonicalNan -> abs_mask_of
  | ArithmeticNan -> canonical_nan_of


let wasm_literal deps lit : instr list =
  match lit.it with
  | Values.Num n -> [Const (n @@ lit.at) @@ lit.at]
  | Values.Vec s -> [VecConst (s @@ lit.at) @@ lit.at]
  | Values.Ref (Values.NullRef t) -> [RefNull t @@ lit.at]
  | Values.Ref (ExternRef n) ->
    let externref_idx = dep_spectest_externref deps in
    [ Const (Values.I32 n @@ lit.at) @@ lit.at;
      Call (externref_idx @@ lit.at) @@ lit.at;
    ]
  | Values.Ref _ -> assert false

let rec wasm_action mods deps act : instr list * value_type list =
  match act.it with
  | Invoke (x_opt, name, args) ->
    let FuncType (_, ts2) as ft = lookup_func mods x_opt name act.at in
    let idx = dep_func deps (var_opt mods x_opt) name ft in
    List.concat_map (wasm_argument mods deps) args @
    [Call (idx @@ act.at) @@ act.at], ts2
  | Get (x_opt, name) ->
    let GlobalType (t, _) as gt = lookup_global mods x_opt name act.at in
    let idx = dep_global deps (var_opt mods x_opt) name gt in
    [GlobalGet (idx @@ act.at) @@ act.at], [t]
  | Set (x_opt, name, arg) ->
    let GlobalType (t, _) as gt = lookup_global mods x_opt name act.at in
    let idx = dep_global deps (var_opt mods x_opt) name gt in
    wasm_argument mods deps arg @
    [GlobalSet (idx @@ act.at) @@ act.at], []

and wasm_argument mods deps arg : instr list =
  match arg.it with
  | LiteralArg lit -> wasm_literal deps lit
  | ActionArg act -> fst (wasm_action mods deps act)

let wasm_result deps res : instr list =
  let at = res.at in
  match res.it with
  | NumResult (NumPat {it = num; at = at'}) ->
    let t', reinterpret = reinterpret_of (Values.type_of_num num) in
    [ reinterpret @@ at;
      Const (num @@ at')  @@ at;
      reinterpret @@ at;
      Compare (eq_of t') @@ at;
      Test (Values.I32 I32Op.Eqz) @@ at;
      BrIf (0l @@ at) @@ at;
    ]
  | NumResult (NanPat nanop) ->
    let open Values in
    let nan = match nanop.it with F32 n | F64 n -> n | I32 _ | I64 _ -> . in
    let t = Values.type_of_num nanop.it in
    let t', reinterpret = reinterpret_of t in
    [ reinterpret @@ at;
      Const (nan_bitmask_of nan t' @@ at) @@ at;
      Binary (and_of t') @@ at;
      Const (canonical_nan_of t' @@ at) @@ at;
      Compare (eq_of t') @@ at;
      Test (Values.I32 I32Op.Eqz) @@ at;
      BrIf (0l @@ at) @@ at;
    ]
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
    let mask, expected =
      match shape with
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
      BrIf (0l @@ at) @@ at;
    ]
  | RefResult (RefPat {it = Values.NullRef t; _}) ->
    [ RefIsNull @@ at;
      Test (Values.I32 I32Op.Eqz) @@ at;
      BrIf (0l @@ at) @@ at;
    ]
  | RefResult (RefPat {it = ExternRef n; _}) ->
    let externref_idx = dep_spectest_externref deps in
    let eq_externref_idx = dep_spectest_eq_externref deps in
    [ Const (Values.I32 n @@ at) @@ at;
      Call (externref_idx @@ at) @@ at;
      Call (eq_externref_idx @@ at)  @@ at;
      Test (Values.I32 I32Op.Eqz) @@ at;
      BrIf (0l @@ at) @@ at;
    ]
  | RefResult (RefPat _) ->
    assert false
  | RefResult (RefTypePat t) ->
    let is_ref_idx =
      match t with
      | FuncRefType -> dep_spectest_is_funcref deps
      | ExternRefType -> dep_spectest_is_externref deps
    in
    [ Call (is_ref_idx @@ at) @@ at;
      Test (Values.I32 I32Op.Eqz) @@ at;
      BrIf (0l @@ at) @@ at;
    ]

let wasm_assertion mods deps ass : instr list * value_type list =
  match ass.it with
  | AssertReturn (act, ress) ->
    [ Block (ValBlockType None,
        fst (wasm_action mods deps act) @
        List.concat_map (wasm_result deps) (List.rev ress) @
        [Return @@ ass.at]
      ) @@ ass.at;
      Unreachable @@ ass.at;
    ], []
  | _ -> assert false

let wasm_module mk_code mods phrase : string =
  let at = phrase.at in
  let deps = new_deps () in
  let body, ts = mk_code mods deps phrase in
  let ftype = dep_type deps (FuncType ([], ts)) @@ at in
  let types = List.map (fun ft -> ft @@ at) deps.dtypes in
  let imports =
    Map.bindings deps.descs |>
    List.concat_map (fun (x, nmap) ->
      NameMap.bindings nmap |>
      List.map (fun (item_name, (idesc', idx)) ->
        let idesc = idesc' @@ at in
        idx, {module_name = Utf8.decode x; item_name; idesc} @@ at
      )
    ) |>
    List.sort compare |> List.map snd |> List.sort compare
  in
  let edesc = FuncExport (!(deps.func_idx) @@ at) @@ at in
  let exports = [{name = Utf8.decode "run"; edesc} @@ at] in
  let funcs = [{ftype; locals = []; body} @@ at] in
  let m = {empty_module with types; funcs; imports; exports} @@ at in
  Encode.encode m


(* Script conversion to plain JS *)

exception UnsupportedByJs

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

let js_string_with iter add_char s =
  let buf = Buffer.create 256 in
  Buffer.add_char buf '\"';
  iter (add_char buf) s;
  Buffer.add_char buf '\"';
  Buffer.contents buf

let js_bytes = js_string_with String.iter add_hex_char
let js_name = js_string_with List.iter add_unicode_char

let js_float z =
  match string_of_float z with
  | "nan" -> "NaN"
  | "-nan" -> "-NaN"
  | "inf" -> "Infinity"
  | "-inf" -> "-Infinity"
  | s -> s

let js_num n =
  let open Values in
  match n with
  | I32 i -> I32.to_string_s i
  | I64 i -> I64.to_string_s i ^ "n"
  | F32 z -> js_float (F32.to_float z)
  | F64 z -> js_float (F64.to_float z)

let js_vec v =
  raise UnsupportedByJs

let js_ref r =
  let open Values in
  match r with
  | NullRef _ -> "null"
  | ExternRef n -> "externref(" ^ Int32.to_string n ^ ")"
  | _ -> raise UnsupportedByJs

let js_literal lit =
  let open Values in
  match lit.it with
  | Num n -> js_num n
  | Vec v -> js_vec v
  | Ref r -> js_ref r

let js_num_pat = function
  | NumPat num ->
    if num = num then js_num num.it else raise UnsupportedByJs (* NaN *)
  | NanPat nanop -> raise UnsupportedByJs

let js_vec_pat = function
  | VecPat _ -> raise UnsupportedByJs

let js_ref_pat = function
  | RefPat r -> js_ref r.it
  | RefTypePat t -> "\"ref." ^ string_of_refed_type t ^ "\""

let js_result res =
  match res.it with
  | NumResult np -> js_num_pat np
  | VecResult vp -> js_vec_pat vp
  | RefResult rp -> js_ref_pat rp

let rec js_definition def =
  match def.it with
  | Textual m -> js_bytes (Encode.encode m)
  | Encoded (_, bs) -> js_bytes bs
  | Quoted (_, s) ->
    try js_definition (Parse.string_to_module s) with Parse.Syntax _ ->
      js_bytes "<malformed quote>"

let rec js_action mods act =
  match act.it with
  | Invoke (x_opt, name, args) ->
    "call(" ^ var_opt mods x_opt ^ ", " ^ js_name name ^ ", " ^
      "[" ^ String.concat ", " (List.map (js_argument mods) args) ^
      "].flat())"
  | Get (x_opt, name) ->
    "get(" ^ var_opt mods x_opt ^ ", " ^ js_name name ^ ")"
  | Set (x_opt, name, arg) ->
    "set(" ^ var_opt mods x_opt ^ ", " ^ js_name name ^ ", " ^
      js_argument mods arg ^ ")"

and js_argument mods arg =
  match arg.it with
  | LiteralArg lit -> js_literal lit
  | ActionArg act -> js_action mods act

let js_run_wasm bs =
  "call(instance(" ^ js_bytes bs ^ ", registry), \"run\", [])"

let js_or_wasm_action mods act =
  try js_action mods act
  with UnsupportedByJs -> js_run_wasm (wasm_module wasm_action mods act)
^ "\n/*\n" ^ Sexpr.to_string 80 (Arrange.module_ (Decode.decode "wrapper" (wasm_module wasm_action mods act))) ^ "*/\n"

let js_assertion mods ass =
  match ass.it with
  | AssertMalformed (def, _) ->
    "assert_malformed(" ^ js_definition def ^ ")"
  | AssertInvalid (def, _) ->
    "assert_invalid(" ^ js_definition def ^ ")"
  | AssertUnlinkable (def, _) ->
    "assert_unlinkable(" ^ js_definition def ^ ")"
  | AssertUninstantiable (def, _) ->
    "assert_uninstantiable(" ^ js_definition def ^ ")"
  | AssertReturn (act, ress) ->
    (try
      let js_ress = List.map js_result ress in
      "assert_return(() => " ^ js_or_wasm_action mods act ^
        String.concat ", " ("" :: js_ress) ^ ")"
    with UnsupportedByJs ->
      js_run_wasm (wasm_module wasm_assertion mods ass)
^ "\n/*\n" ^ Sexpr.to_string 80 (Arrange.module_ (Decode.decode "wrapper" (wasm_module wasm_assertion mods ass))) ^ "*/\n"
    )
  | AssertTrap (act, _) ->
    "assert_trap(() => " ^ js_or_wasm_action mods act ^ ")"
  | AssertExhaustion (act, _) ->
    "assert_exhaustion(() => " ^ js_or_wasm_action mods act ^ ")"

let js_command mods cmd =
  "\n// " ^ Filename.basename cmd.at.left.file ^
    ":" ^ string_of_int cmd.at.left.line ^ "\n" ^
  match cmd.it with
  | Module (x_opt, def) ->
    let rec unquote def =
      match def.it with
      | Textual m -> m
      | Encoded (_, bs) -> Decode.decode "binary" bs
      | Quoted (_, s) -> unquote (Parse.string_to_module s)
    in
    bind mods x_opt (unquote def);
    let xi = current_var mods in
    "let " ^ current_var mods ^
      " = register(\"" ^ xi ^ "\", instance(" ^ js_definition def ^ "));\n" ^
    ( if x_opt = None then "" else
      let x = var_opt mods x_opt in
      "let " ^ x ^ " = register(\"" ^ x ^ "\", " ^ xi ^ ");\n"
    )
  | Register (name, x_opt) ->
    "register(" ^ js_name name ^ ", " ^ var_opt mods x_opt ^ ");\n"
  | Action act ->
    js_or_wasm_action mods act ^ ";\n"
  | Assertion ass ->
    js_assertion mods ass ^ ";\n"
  | Meta _ -> assert false

let of_script scr =
  (if !Flags.harness then harness else "") ^
  String.concat "" (List.map (js_command (modules ())) scr)
