open Script
open Source


(* Harness *)

let prefix =
  "'use strict';\n" ^
  "\n" ^
  "let spectest = {\n" ^
  "  print: print || ((...xs) => console.log(...xs)),\n" ^
  "  global: 666,\n" ^
  "};\n" ^  (* TODO: table, memory *)
  "\n" ^
  "let registry = {spectest: spectest};\n" ^
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
  "function instance(bytes) {\n" ^
  "  return new WebAssembly.Instance(module(bytes), registry);\n" ^
  "}\n" ^
  "\n" ^
  "function assert_malformed(bytes) {\n" ^
  "  try { module(bytes) } catch (e) { return }\n" ^
  "  throw new Error(\"Wasm decoding failure expected\");\n" ^
  "}\n" ^
  "\n" ^
  "function assert_invalid(bytes) {\n" ^
  "  try { module(bytes) } catch (e) { return }\n" ^
  "  throw new Error(\"Wasm validation failure expected\");\n" ^
  "}\n" ^
  "\n" ^
  "function assert_unlinkable(bytes) {\n" ^
  "  let mod = module(bytes);\n" ^
  "  try { instance(mod, registry) } catch (e) { return }\n" ^
  "  throw new Error(\"Wasm linking failure expected\");\n" ^
  "}\n" ^
  "\n" ^
  "function assert_trap(action) {\n" ^
  "  try { action() } catch (e) { return }\n" ^
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
  "function assert_return(action) {\n" ^
  "  let actual = action();\n" ^
  "  if (!actual.isNaN()) {\n" ^
  "    throw new Error(\"Wasm return value NaN expected, got \" + actual);\n" ^
  "  };\n" ^
  "}\n" ^
  "\n"


(* Script conversion *)

let of_hex n =
  assert (0 <= n && n < 16);
  if n < 10
  then Char.chr (n + Char.code '0')
  else Char.chr (n - 10 + Char.code 'a')

let of_bytes s =
  let buf = Buffer.create (4 * String.length s + 2) in
  Buffer.add_char buf '\"';
  for i = 0 to String.length s - 1 do
    Buffer.add_string buf "\\x";
    Buffer.add_char buf (of_hex (Char.code s.[i] / 16));
    Buffer.add_char buf (of_hex (Char.code s.[i] mod 16));
  done;
  Buffer.add_char buf '\"';
  Buffer.contents buf

let of_literal lit =
  match lit.it with
  | Values.I32 i -> I32.to_string i
  | Values.I64 i -> I64.to_string i  (* TODO *)
  | Values.F32 z -> F32.to_string z
  | Values.F64 z -> F64.to_string z

let of_var_opt = function
  | None -> "$$"
  | Some x -> x.it

let of_definition def =
  let bs =
    match def.it with
    | Textual m -> Encode.encode m
    | Binary (_, bs) -> bs
  in of_bytes bs

let of_action act =
  match act.it with
  | Invoke (x_opt, name, lits) ->
    of_var_opt x_opt ^ ".export[\"" ^ name ^ "\"]" ^
      "(" ^ String.concat ", " (List.map of_literal lits) ^ ")"
  | Get (x_opt, name) ->
    of_var_opt x_opt ^ ".export[\"" ^ name ^ "\"]"

let of_assertion ass =
  match ass.it with
  | AssertMalformed (def, _) ->
    "assert_malformed(" ^ of_definition def ^ ")"
  | AssertInvalid (def, _) ->
    "assert_invalid(" ^ of_definition def ^ ")"
  | AssertUnlinkable (def, _) ->
    "assert_unlinkable(" ^ of_definition def ^ ")"
  | AssertReturn (act, lits) ->
    "assert_return(() => " ^ of_action act ^ ", " ^
      String.concat ", " (List.map of_literal lits) ^ ")"
  | AssertReturnNaN act ->
    "assert_return_nan(() => " ^ of_action act ^ ")"
  | AssertTrap (act, _) ->
    "assert_trap(() => " ^ of_action act ^ ")"

let of_command cmd =
  match cmd.it with
  | Module (x_opt, def) ->
    (if x_opt <> None then "let " else "") ^
    of_var_opt x_opt ^ " = module(" ^ of_definition def ^ ");\n"
  | Register (name, x_opt) ->
    "register(" ^ name ^ ", " ^ of_var_opt x_opt ^ ")\n"
  | Action act ->
    of_action act ^ ";\n"
  | Assertion ass ->
    of_assertion ass ^ ";\n"
  | Meta _ -> assert false

let of_script scr =
  prefix ^ String.concat "" (List.map of_command scr)
