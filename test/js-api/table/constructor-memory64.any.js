// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/wasm-module-builder.js
// META: script=/wasm/jsapi/assertions.js
// META: script=/wasm/jsapi/table/assertions.js

const outOfRangeValuesI64 = [
  -1n,
  0x1_0000_0000_0000_0000n,
];

for (const value of outOfRangeValuesI64) {
  test(() => {
    assert_throws_js(TypeError, () => new WebAssembly.Table({ "element": "anyfunc", "address": "i64", "initial": value }));
  }, `Out-of-range initial i64 value in descriptor: ${format_value(value)}`);

  test(() => {
    assert_throws_js(TypeError, () => new WebAssembly.Table({ "element": "anyfunc", "address": "i64", "initial": 0n, "maximum": value }));
  }, `Out-of-range maximum i64 value in descriptor: ${format_value(value)}`);
}

test(() => {
  assert_throws_js(RangeError, () => new WebAssembly.Table({ "element": "anyfunc", "address": "i64", "initial": 10n, "maximum": 9n }));
}, "Initial value exceeds maximum (i64)");

test(() => {
  const argument = { "element": "anyfunc", "address": "i64", "initial": 0n };
  const table = new WebAssembly.Table(argument);
  assert_Table(table, { "length": 0n }, "i64");
}, "Basic (zero, i64)");

test(() => {
  const argument = { "element": "anyfunc", "address": "i64", "initial": 5n };
  const table = new WebAssembly.Table(argument);
  assert_Table(table, { "length": 5n }, "i64");
}, "Basic (non-zero, i64)");

test(() => {
  const argument = { "element": "anyfunc", "initial": 3n, "address": "i64" };
  const table = new WebAssembly.Table(argument);
  // Once this is merged with the type reflection proposal we should check the
  // address type of `table`.
  assert_equals(table.length, 3n);
}, "Table with i64 address constructor");

test(() => {
  const argument = { "element": "anyfunc", "initial": "3", "address": "i64" };
  const table = new WebAssembly.Table(argument);
  assert_equals(table.length, 3n);
}, "Table with string value for initial (i64)");

test(() => {
  const argument = { "element": "anyfunc", "initial": true, "address": "i64" };
  const table = new WebAssembly.Table(argument);
  assert_equals(table.length, 1n);
}, "Table with boolean value for initial (i64)");

test(() => {
  const argument = { "element": "anyfunc", "initial": 0n, "maximum": "3", "address": "i64" };
  const table = new WebAssembly.Table(argument);
  table.grow(3n);
  assert_equals(table.length, 3n);
}, "Table with string value for maximum (i64)");

test(() => {
  const argument = { "element": "anyfunc", "initial": 0n, "maximum": true, "address": "i64" };
  const table = new WebAssembly.Table(argument);
  table.grow(1n);
  assert_equals(table.length, 1n);
}, "Table with boolean value for maximum (i64)");
