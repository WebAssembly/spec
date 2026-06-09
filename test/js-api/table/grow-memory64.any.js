// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/wasm-module-builder.js
// META: script=assertions.js

test(() => {
  const argument = { "element": "anyfunc", "address": "i64", "initial": 5n };
  const table = new WebAssembly.Table(argument);
  assert_equal_to_array(table, nulls(5), "before", "i64");

  const result = table.grow(3n);
  assert_equals(result, 5n);
  assert_equal_to_array(table, nulls(8), "after", "i64");
}, "Basic i64");

test(() => {
  const argument = { "element": "anyfunc", "address": "i64", "initial": 3n, "maximum": 5n };
  const table = new WebAssembly.Table(argument);
  assert_equal_to_array(table, nulls(3), "before", "i64");

  const result = table.grow(2n);
  assert_equals(result, 3n);
  assert_equal_to_array(table, nulls(5), "after", "i64");
}, "Reached maximum (i64)");


test(() => {
  const argument = { "element": "anyfunc", "address": "i64", "initial": 2n, "maximum": 5n };
  const table = new WebAssembly.Table(argument);
  assert_equal_to_array(table, nulls(2), "before", "i64");

  assert_throws_js(RangeError, () => table.grow(4n));
  assert_equal_to_array(table, nulls(2), "after", "i64");
}, "Exceeded maximum (i64)");

const outOfRangeValuesI64 = [
  -1n,
  0x10000000000000000n,
  "0x10000000000000000",
];

for (const value of outOfRangeValuesI64) {
  test(() => {
    const argument = { "element": "anyfunc", "address": "i64", "initial": 1n };
    const table = new WebAssembly.Table(argument);
    assert_throws_js(TypeError, () => table.grow(value));
  }, `Out-of-range i64 argument: ${format_value(value)}`);
}
