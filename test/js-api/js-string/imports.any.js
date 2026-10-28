// META: global=window,dedicatedworker,jsshell,shadowrealm
// META: script=/wasm/jsapi/wasm-module-builder.js

test(() => {
  let builder = new WasmModuleBuilder();

  // Import a string constant
  builder.addImportedGlobal("constants", "constant", kWasmExternRef, false);

  // Import a builtin function
  builder.addImport(
    "wasm:js-string",
    "test",
    {params: [kWasmExternRef], results: [kWasmI32]});

  let buffer = builder.toBuffer();
  let module = new WebAssembly.Module(buffer, {
    builtins: ["js-string"],
    importedStringConstants: "constants"
  });
  let imports = WebAssembly.Module.imports(module);

  // All imports that refer to a builtin module are suppressed from import
  // reflection.
  assert_equals(imports.length, 0);
});

function moduleWithBuiltin() {
  const builder = new WasmModuleBuilder();
  builder.addImport(
    "wasm:js-string",
    "test",
    {params: [kWasmExternRef], results: [kWasmI32]});
  return new WebAssembly.Module(builder.toBuffer(), {builtins: ["js-string"]});
}

test(() => {
  const instance = new WebAssembly.Instance(moduleWithBuiltin());
  assert_equals(typeof instance.exports, "object");
}, "A builtin-only module can be instantiated without an importObject");

test(() => {
  const instance = new WebAssembly.Instance(moduleWithBuiltin(), undefined);
  assert_equals(typeof instance.exports, "object");
}, "A builtin-only module can be instantiated with undefined importObject");

promise_test(async () => {
  const instance = await WebAssembly.instantiate(moduleWithBuiltin());
  assert_equals(typeof instance.exports, "object");
}, "WebAssembly.instantiate accepts a builtin-only module without an importObject");

test(() => {
  const builder = new WasmModuleBuilder();
  builder.addImportedGlobal("strings", "hi", kWasmExternRef, false);
  builder.addExportOfKind("hi", kExternalGlobal, 0);
  const module = new WebAssembly.Module(builder.toBuffer(), {
    importedStringConstants: "strings",
  });
  const instance = new WebAssembly.Instance(module);
  assert_equals(instance.exports.hi.value, "hi");
}, "Imported string constants do not require an importObject");

test(() => {
  const builder = new WasmModuleBuilder();
  builder.addImport(
    "wasm:js-string",
    "test",
    {params: [kWasmExternRef], results: [kWasmI32]});
  builder.addImport("env", "f", {params: [], results: []});
  const module = new WebAssembly.Module(builder.toBuffer(), {builtins: ["js-string"]});
  assert_throws_js(TypeError, () => new WebAssembly.Instance(module));
}, "A non-builtin import still requires an importObject");

test(() => {
  const builder = new WasmModuleBuilder();
  builder.addImport("wasm:js-string", "not-a-builtin", {params: [], results: []});
  const module = new WebAssembly.Module(builder.toBuffer(), {builtins: ["js-string"]});
  assert_throws_js(TypeError, () => new WebAssembly.Instance(module));
}, "An unknown import from a builtin module requires an importObject");
