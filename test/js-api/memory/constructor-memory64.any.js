// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/assertions.js
// META: script=/wasm/jsapi/memory/assertions.js

const outOfRangeValuesI64 = [
  -1n,
  0x1_0000_0000_0000_0000n,
];

for (const value of outOfRangeValuesI64) {
  test(() => {
    assert_throws_js(TypeError, () => new WebAssembly.Memory({ "address": "i64", "initial": value }));
  }, `Out-of-range initial i64 value in descriptor: ${format_value(value)}`);

  test(() => {
    assert_throws_js(TypeError, () => new WebAssembly.Memory({ "address": "i64", "initial": 0n, "maximum": value }));
  }, `Out-of-range maximum i64 value in descriptor: ${format_value(value)}`);
}

test(() => {
  assert_throws_js(RangeError, () => new WebAssembly.Memory({ "address": "i64", "initial": 10n, "maximum": 9n }));
}, "Initial value exceeds maximum (i64)");

test(() => {
  const argument = { "address": "i64", "initial": 0n };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 0, "address": "i64" });
}, "Zero initial (i64)");

test(() => {
  const argument = { "address": "i64", "initial": 4n };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 4, "address": "i64" });
}, "Non-zero initial (i64)");

test(() => {
  const argument = { "initial": 1n, "address": "i64" };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 1, "address": "i64" });
}, "Memory with i64 address constructor");

test(() => {
  const argument = { "address": "i64", "initial": "3" };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 3, "address": "i64" });
}, "Memory with string value for initial (i64)");

test(() => {
  const argument = { "address": "i64", "initial": true };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 1, "address": "i64" });
}, "Memory with boolean value for initial (i64)");
