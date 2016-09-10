let js_prefix =
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
