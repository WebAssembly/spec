// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/wasm-module-builder.js

let exports = {};
setup(() => {
  const builder = new WasmModuleBuilder();

  builder.addTable(wasmRefType(kWasmAnyRef), 10, 20, [...wasmI32Const(42), ...GCInstr(kExprRefI31)])
    .exportAs("tableAnyNonNullable");
  builder.addTable(wasmRefNullType(kWasmAnyRef), 10, 20)
    .exportAs("tableAnyNullable");

  const buffer = builder.toBuffer();
  const module = new WebAssembly.Module(buffer);
  const instance = new WebAssembly.Instance(module, {});
  exports = instance.exports;
});

test(() => {
  exports.tableAnyNullable.grow(5);
  for (let i = 0; i < 5; i++)
    assert_equals(exports.tableAnyNullable.get(10 + i), null);
}, "grow (nullable anyref)");

test(() => {
  assert_throws_js(TypeError, () => { exports.tableAnyNonNullable.grow(5); });
  exports.tableAnyNonNullable.grow(5, "foo");
  for (let i = 0; i < 5; i++)
    assert_equals(exports.tableAnyNonNullable.get(10 + i), "foo");
}, "grow (non-nullable anyref)");

test(() => {
  for (let i = 0; i < exports.tableAnyNullable.length; i++) {
    exports.tableAnyNullable.set(i);
    assert_equals(exports.tableAnyNullable.get(i), null);
  }
}, "set (nullable anyref)");

test(() => {
  for (let i = 0; i < exports.tableAnyNonNullable.length; i++) {
    assert_throws_js(TypeError, () => { exports.tableAnyNonNullable.set(i); });
  }
}, "set (non-nullable anyref)");
