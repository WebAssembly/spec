open Types
open Ast
open Value
open Script
open Source


(* Harness *)

let harness =
{|
'use strict';

let hostrefs = {};
let hostsym = Symbol("hostref");
function hostref(s) {
  if (! (s in hostrefs)) hostrefs[s] = {[hostsym]: s};
  return hostrefs[s];
}
function eq_ref(x, y) {
  return x === y ? 1 : 0;
}

let spectest = {
  hostref: hostref,
  eq_ref: eq_ref,
  print: console.log.bind(console),
  print_i32: console.log.bind(console),
  print_i64: console.log.bind(console),
  print_i32_f32: console.log.bind(console),
  print_f64_f64: console.log.bind(console),
  print_f32: console.log.bind(console),
  print_f64: console.log.bind(console),
  global_i32: 666,
  global_i64: 666n,
  global_f32: 666.6,
  global_f64: 666.6,
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

function instance(mod, imports = registry) {
  return new WebAssembly.Instance(mod, imports);
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

function assert_malformed_custom(bytes) {
  return;
}

function assert_invalid(bytes) {
  try { module(bytes, false) } catch (e) {
    if (e instanceof WebAssembly.CompileError) return;
  }
  throw new Error("Wasm validation failure expected");
}

function assert_invalid_custom(bytes) {
  return;
}

function assert_unlinkable(mod) {
  try { new WebAssembly.Instance(mod, registry) } catch (e) {
    if (e instanceof WebAssembly.LinkError) return;
  }
  throw new Error("Wasm linking failure expected");
}

function assert_uninstantiable(mod) {
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

function assert_exception(action) {
  try { action() } catch (e) { return; }
  throw new Error("exception expected");
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
      case "ref.i31":
        if (typeof actual[i] !== "number" || (actual[i] & 0x7fffffff) !== actual[i]) {
          throw new Error("Wasm i31 return value expected, got " + actual[i]);
        };
        return;
      case "ref.any":
      case "ref.eq":
      case "ref.struct":
      case "ref.array":
        // For now, JS can't distinguish exported Wasm GC values,
        // so we only test for object.
        if (typeof actual[i] !== "object") {
          throw new Error("Wasm function return value expected, got " + actual[i]);
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
        if (actual[i] !== null) {
          throw new Error("Wasm null return value expected, got " + actual[i]);
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
type env =
  { mutable mods : exports Map.t;
    mutable insts : exports Map.t;
    mutable current_mod : int;
    mutable current_inst : int;
  }

let exports m : exports =
  let ModuleT (_, ets) = module_type_of m in
  List.fold_left (fun map (ExportT (et, name)) -> NameMap.add name et map)
    NameMap.empty ets

let env () : env =
  { mods = Map.empty;
    insts = Map.empty;
    current_mod = 0;
    current_inst = 0;
  }

let current_mod (env : env) = "$$" ^ string_of_int env.current_mod
let of_mod_opt (env : env) = function
  | None -> current_mod env
  | Some x -> x.it

let current_inst (env : env) = "$" ^ string_of_int env.current_inst
let of_inst_opt (env : env) = function
  | None -> current_inst env
  | Some x -> x.it

let bind_mod (env : env) x_opt m =
  let exports = exports m in
  env.current_mod <- env.current_mod + 1;
  env.mods <- Map.add (of_mod_opt env x_opt) exports env.mods;
  if x_opt <> None then env.mods <- Map.add (current_mod env) exports env.mods

let bind_inst (env : env) x_opt exports =
  env.current_inst <- env.current_inst + 1;
  env.insts <- Map.add (of_inst_opt env x_opt) exports env.insts;
  if x_opt <> None then env.insts <- Map.add (current_inst env) exports env.insts

let find_mod (env : env) x_opt at =
  try Map.find (of_mod_opt env x_opt) env.mods with Not_found ->
    raise (Eval.Crash (at,
      if x_opt = None then "no module defined within script"
      else "unknown module " ^ of_mod_opt env x_opt ^ " within script"))

let find_inst (env : env) x_opt at =
  try Map.find (of_inst_opt env x_opt) env.insts with Not_found ->
    raise (Eval.Crash (at,
      if x_opt = None then "no module instance defined within script"
      else "unknown module instance " ^ of_inst_opt env x_opt ^ " within script"))

let lookup_export (env : env) x_opt name at =
  let exports = find_inst env x_opt at in
  try NameMap.find name exports with Not_found ->
    raise (Eval.Crash (at, "unknown export \"" ^
      string_of_name name ^ "\" within module isntance"))


(* Wrappers *)

let subject_idx = 0l
let hostref_idx = 1l
let eq_ref_idx = 2l
let subject_type_idx = 3l

let eq_of = function
  | I32T -> I32 I32Op.Eq
  | I64T -> I64 I64Op.Eq
  | F32T -> F32 F32Op.Eq
  | F64T -> F64 F64Op.Eq

let and_of = function
  | I32T | F32T -> I32 I32Op.And
  | I64T | F64T -> I64 I64Op.And

let reinterpret_of = function
  | I32T -> I32T, Nop
  | I64T -> I64T, Nop
  | F32T -> I32T, Convert (I32 I32Op.ReinterpretFloat)
  | F64T -> I64T, Convert (I64 I64Op.ReinterpretFloat)

let canonical_nan_of = function
  | I32T | F32T -> I32 (F32.to_bits F32.pos_nan)
  | I64T | F64T -> I64 (F64.to_bits F64.pos_nan)

let abs_mask_of = function
  | I32T | F32T -> I32 Int32.max_int
  | I64T | F64T -> I64 Int64.max_int

let value v =
  match v.it with
  | Num n -> [Const (n @@ v.at) @@ v.at]
  | Vec s -> [VecConst (s @@ v.at) @@ v.at]
  | Ref (NullRef ht) -> [RefNull (Match.bot_of_heap_type [] ht) @@ v.at]
  | Ref (Extern.ExternRef (HostRef n)) ->
    [Const (I32 n @@ v.at) @@ v.at; Call (hostref_idx @@ v.at) @@ v.at]
  | Ref _ -> assert false

let invoke ft vs at =
  let dt = RecT [SubT (Final, [], DefFuncT ft)] in
  [dt @@ at], FuncImport (subject_type_idx @@ at) @@ at,
  List.concat (List.map value vs) @ [Call (subject_idx @@ at) @@ at]

let get t at =
  [], GlobalImport t @@ at, [GlobalGet (subject_idx @@ at) @@ at]

let run ts at =
  [], []

let nan_bitmask_of = function
  | CanonicalNan -> abs_mask_of  (* differ from canonical NaN in sign bit *)
  | ArithmeticNan -> canonical_nan_of  (* 1 everywhere canonical NaN is *)

let type_of_num_pat = function
  | NumPat num -> Value.type_of_num num.it
  | NanPat op -> Value.type_of_op op.it

let type_of_vec_pat = function
  | VecPat vec -> Value.type_of_vec vec

let type_of_ref_pat = function
  | RefPat ref -> type_of_ref ref.it
  | RefTypePat ht -> (NoNull, ht)
  | NullPat -> (Null, BotHT)

let type_of_result res =
  match res.it with
  | NumResult pat -> NumT (type_of_num_pat pat)
  | VecResult pat -> VecT (type_of_vec_pat pat)
  | RefResult pat -> RefT (type_of_ref_pat pat)

let assert_return ress ts at =
  let test (res, t) =
    if not (Match.match_val_type [] t (type_of_result res)) then
      [ Br (0l @@ at) @@ at ]
    else
    match res.it with
    | NumResult (NumPat {it = num; at = at'}) ->
      let t', reinterpret = reinterpret_of (Value.type_of_op num) in
      [ reinterpret @@ at;
        Const (num @@ at')  @@ at;
        reinterpret @@ at;
        Compare (eq_of t') @@ at;
        Test (I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | NumResult (NanPat nanop) ->
      let nan =
        match nanop.it with
        | Value.I32 _ | Value.I64 _ -> .
        | Value.F32 n | Value.F64 n -> n
      in
      let t', reinterpret = reinterpret_of (Value.type_of_op nanop.it) in
      [ reinterpret @@ at;
        Const (nan_bitmask_of nan t' @@ at) @@ at;
        Binary (and_of t') @@ at;
        Const (canonical_nan_of t' @@ at) @@ at;
        Compare (eq_of t') @@ at;
        Test (I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | VecResult (VecPat (Value.V128 (shape, pats))) ->
      let open Value in
      let mask_and_canonical = function
        | NumPat {it = I32 _ as i; _} -> I32 (Int32.minus_one), i
        | NumPat {it = I64 _ as i; _} -> I64 (Int64.minus_one), i
        | NumPat {it = F32 f; _} ->
          I32 (Int32.minus_one), I32 (I32_convert.reinterpret_f32 f)
        | NumPat {it = F64 f; _} ->
          I64 (Int64.minus_one), I64 (I64_convert.reinterpret_f64 f)
        | NanPat {it = F32 nan; _} ->
          nan_bitmask_of nan I32T, canonical_nan_of I32T
        | NanPat {it = F64 nan; _} ->
          nan_bitmask_of nan I64T, canonical_nan_of I64T
        | _ -> .
      in
      let masks, canons =
        List.split (List.map (fun p -> mask_and_canonical p) pats) in
      let all_ones =
        V128.I32x4.of_lanes (List.init 4 (fun _ -> Int32.minus_one)) in
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
    | RefResult (RefPat {it = NullRef _; _}) ->
      [ RefIsNull @@ at;
        Test (Value.I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | RefResult (RefPat {it = HostRef n; _}) ->
      [ Const (Value.I32 n @@ at) @@ at;
        Call (hostref_idx @@ at) @@ at;
        Call (eq_ref_idx @@ at)  @@ at;
        Test (Value.I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | RefResult (RefPat _) ->
      assert false
    | RefResult (RefTypePat (ExnHT | ExternHT)) ->
      [ BrOnNull (0l @@ at) @@ at ]
    | RefResult (RefTypePat t) ->
      [ RefTest (NoNull, t) @@ at;
        Test (I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
    | RefResult NullPat ->
      [ RefIsNull @@ at;
        Test (I32 I32Op.Eqz) @@ at;
        BrIf (0l @@ at) @@ at ]
  in [], List.flatten (List.rev_map test (List.combine ress ts))

let i32 = NumT I32T
let anyref = RefT (Null, AnyHT)
let eqref = RefT (Null, EqHT)
let func_rec_type ts1 ts2 at =
  RecT [SubT (Final, [], DefFuncT (FuncT (ts1, ts2)))] @@ at

let wrap item_name wrap_action wrap_assertion at =
  let itypes, idesc, action = wrap_action at in
  let locals, assertion = wrap_assertion at in
  let types =
    func_rec_type [] [] at ::
    func_rec_type [i32] [anyref] at ::
    func_rec_type [eqref; eqref] [i32] at ::
    itypes
  in
  let imports =
    [ {module_name = Utf8.decode "module"; item_name; idesc} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "hostref";
       idesc = FuncImport (1l @@ at) @@ at} @@ at;
      {module_name = Utf8.decode "spectest"; item_name = Utf8.decode "eq_ref";
       idesc = FuncImport (2l @@ at) @@ at} @@ at;
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
  | I32T -> true
  | I64T | F32T | F64T -> false

let is_js_vec_type = function
  | _ -> false

let is_js_ref_type = function
  | (_, ExnHT) -> false
  | _ -> true

let is_js_val_type = function
  | NumT t -> is_js_num_type t
  | VecT t -> is_js_vec_type t
  | RefT t -> is_js_ref_type t
  | BotT -> assert false

let is_js_global_type = function
  | GlobalT (mut, t) -> is_js_val_type t && mut = Cons

let is_js_func_type = function
  | FuncT (ts1, ts2) -> List.for_all is_js_val_type (ts1 @ ts2)


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
  let open Value in
  match n with
  | I32 i -> I32.to_string_s i
  | I64 i -> "int64(\"" ^ I64.to_string_s i ^ "\")"
  | F32 z -> of_float (F32.to_float z)
  | F64 z -> of_float (F64.to_float z)

let of_vec v =
  let open Value in
  match v with
  | V128 v -> "v128(\"" ^ V128.to_string v ^ "\")"

let of_ref r =
  let open Value in
  match r with
  | NullRef _ -> "null"
  | HostRef n | Extern.ExternRef (HostRef n) -> "hostref(" ^ Int32.to_string n ^ ")"
  | _ -> assert false

let of_value v =
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
    | Value.I32 _ | Value.I64 _ -> .
    | Value.F32 n | Value.F64 n -> of_nan n

let of_vec_pat = function
  | VecPat (Value.V128 (shape, pats)) ->
    Printf.sprintf "v128(\"%s\")" (String.concat " " (List.map of_num_pat pats))

let of_ref_pat = function
  | RefPat r -> of_ref r.it
  | RefTypePat t -> "\"ref." ^ string_of_heap_type t ^ "\""
  | NullPat -> "\"ref.null\""

let of_result res =
  match res.it with
  | NumResult np -> of_num_pat np
  | VecResult vp -> of_vec_pat vp
  | RefResult rp -> of_ref_pat rp

let rec of_definition def =
  match def.it with
  | Textual (m, _) -> of_bytes (Encode.encode m)
  | Encoded (_, bs) -> of_bytes bs.it
  | Quoted (_, s) ->
    try of_definition (snd (Parse.Module.parse_string ~offset:s.at s.it))
    with Parse.Syntax _ | Custom.Syntax _ -> of_bytes "<malformed quote>"

let of_instance env x_opt =
  "instance(" ^ of_mod_opt env x_opt ^ ")"

let of_wrapper env x_opt name wrap_action wrap_assertion at =
  let x = of_inst_opt env x_opt in
  let bs = wrap name wrap_action wrap_assertion at in
  "call(instance(module(" ^ of_bytes bs ^ "), " ^
    "exports(" ^ x ^ ")), " ^ " \"run\", [])"

let of_action env act =
  match act.it with
  | Invoke (x_opt, name, vs) ->
    "call(" ^ of_inst_opt env x_opt ^ ", " ^ of_name name ^ ", " ^
      "[" ^ String.concat ", " (List.map of_value vs) ^ "])",
    (match lookup_export env x_opt name act.at with
    | ExternFuncT dt ->
      let FuncT (_, out) as ft = as_func_str_type (expand_def_type dt) in
      if is_js_func_type ft then
        None
      else
        Some (of_wrapper env x_opt name (invoke ft vs), out)
    | _ -> None
    )
  | Get (x_opt, name) ->
    "get(" ^ of_inst_opt env x_opt ^ ", " ^ of_name name ^ ")",
    (match lookup_export env x_opt name act.at with
    | ExternGlobalT gt when not (is_js_global_type gt) ->
      let GlobalT (_, t) = gt in
      Some (of_wrapper env x_opt name (get gt), [t])
    | _ -> None
    )

let of_assertion' env act name args wrapper_opt =
  let act_js, act_wrapper_opt = of_action env act in
  let js = name ^ "(() => " ^ act_js ^ String.concat ", " ("" :: args) ^ ")" in
  match act_wrapper_opt with
  | None -> js ^ ";"
  | Some (act_wrapper, out) ->
    let run_name, wrapper =
      match wrapper_opt with
      | None -> name, run
      | Some wrapper -> "run", wrapper
    in run_name ^ "(() => " ^ act_wrapper (wrapper out) act.at ^ ");  // " ^ js

let of_assertion env ass =
  match ass.it with
  | AssertMalformed (def, _) ->
    "assert_malformed(" ^ of_definition def ^ ");"
  | AssertMalformedCustom (def, _) ->
    "assert_malformed_custom(" ^ of_definition def ^ ");"
  | AssertInvalid (def, _) ->
    "assert_invalid(" ^ of_definition def ^ ");"
  | AssertInvalidCustom (def, _) ->
    "assert_invalid_custom(" ^ of_definition def ^ ");"
  | AssertUnlinkable (x_opt, _) ->
    "assert_unlinkable(" ^ of_instance env x_opt ^ ");"
  | AssertUninstantiable (x_opt, _) ->
    "assert_uninstantiable(" ^ of_instance env x_opt ^ ");"
  | AssertReturn (act, ress) ->
    of_assertion' env act "assert_return" (List.map of_result ress)
      (Some (assert_return ress))
  | AssertTrap (act, _) ->
    of_assertion' env act "assert_trap" [] None
  | AssertExhaustion (act, _) ->
    of_assertion' env act "assert_exhaustion" [] None
  | AssertException act ->
    of_assertion' env act "assert_exception" [] None

let of_command env cmd =
  "\n// " ^ Filename.basename cmd.at.left.file ^
    ":" ^ string_of_int cmd.at.left.line ^ "\n" ^
  match cmd.it with
  | Module (x_opt, def) ->
    let rec unquote def =
      match def.it with
      | Textual (m, _) -> m
      | Encoded (name, bs) -> Decode.decode name bs.it
      | Quoted (_, s) ->
        unquote (snd (Parse.Module.parse_string ~offset:s.at s.it))
    in bind_mod env x_opt (unquote def);
    "let " ^ current_mod env ^ " = " ^ of_definition def ^ ";\n" ^
    (if x_opt = None then "" else
    "let " ^ of_mod_opt env x_opt ^ " = " ^ current_mod env ^ ";\n")
  | Instance (x1_opt, x2_opt) ->
    let exports = find_mod env x2_opt cmd.at in
    bind_inst env x1_opt exports;
    "let " ^ current_inst env ^ " = instance(" ^ of_mod_opt env x2_opt ^ ");\n" ^
    (if x1_opt = None then "" else
    "let " ^ of_inst_opt env x1_opt ^ " = " ^ current_inst env ^ ";\n")
  | Register (name, x_opt) ->
    "register(" ^ of_name name ^ ", " ^ of_inst_opt env x_opt ^ ")\n"
  | Action act ->
    of_assertion' env act "run" [] None ^ "\n"
  | Assertion ass ->
    of_assertion env ass ^ "\n"
  | Meta _ -> assert false

let of_script scr =
  (if !Flags.harness then harness else "") ^
  String.concat "" (List.map (of_command (env ())) scr)
