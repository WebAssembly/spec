// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/memory/assertions.js

test(() => {
  const argument = { "address": "i64", "initial": 0n };
  const memory = new WebAssembly.Memory(argument);
  const oldMemory = memory.buffer;
  assert_ArrayBuffer(oldMemory, { "size": 0 }, "Buffer before growing");

  const result = memory.grow(2n);
  assert_equals(result, 0n);

  const newMemory = memory.buffer;
  assert_not_equals(oldMemory, newMemory);
  assert_ArrayBuffer(oldMemory, { "detached": true }, "Old buffer after growing");
  assert_ArrayBuffer(newMemory, { "size": 2 }, "New buffer after growing");
}, "Zero initial (i64)");

test(() => {
  const argument = { "address": "i64", "initial": 3n };
  const memory = new WebAssembly.Memory(argument);
  const oldMemory = memory.buffer;
  assert_ArrayBuffer(oldMemory, { "size": 3 }, "Buffer before growing");

  const result = memory.grow(2n);
  assert_equals(result, 3n);

  const newMemory = memory.buffer;
  assert_not_equals(oldMemory, newMemory);
  assert_ArrayBuffer(oldMemory, { "detached": true }, "Old buffer after growing");
  assert_ArrayBuffer(newMemory, { "size": 5 }, "New buffer after growing");
}, "Non-zero initial (i64)");

test(() => {
  const argument = { "address": "i64", "initial": 0n, "maximum": 2n };
  const memory = new WebAssembly.Memory(argument);
  const oldMemory = memory.buffer;
  assert_ArrayBuffer(oldMemory, { "size": 0 }, "Buffer before growing");

  const result = memory.grow(2n);
  assert_equals(result, 0n);

  const newMemory = memory.buffer;
  assert_not_equals(oldMemory, newMemory);
  assert_ArrayBuffer(oldMemory, { "detached": true }, "Old buffer after growing");
  assert_ArrayBuffer(newMemory, { "size": 2 }, "New buffer after growing");
}, "Zero initial with respected maximum (i64)");

test(() => {
  const argument = { "address": "i64", "initial": 0n, "maximum": 2n };
  const memory = new WebAssembly.Memory(argument);
  const oldMemory = memory.buffer;
  assert_ArrayBuffer(oldMemory, { "size": 0 }, "Buffer before growing");

  const result = memory.grow(1n);
  assert_equals(result, 0n);

  const newMemory = memory.buffer;
  assert_not_equals(oldMemory, newMemory);
  assert_ArrayBuffer(oldMemory, { "detached": true }, "Old buffer after growing once");
  assert_ArrayBuffer(newMemory, { "size": 1 }, "New buffer after growing once");

  const result2 = memory.grow(1n);
  assert_equals(result2, 1n);

  const newestMemory = memory.buffer;
  assert_not_equals(newMemory, newestMemory);
  assert_ArrayBuffer(oldMemory, { "detached": true }, "New buffer after growing twice");
  assert_ArrayBuffer(newMemory, { "detached": true }, "New buffer after growing twice");
  assert_ArrayBuffer(newestMemory, { "size": 2 }, "Newest buffer after growing twice");
}, "Zero initial with respected maximum grown twice (i64)");

test(() => {
  const argument = { "address": "i64", "initial": 1n, "maximum": 2n };
  const memory = new WebAssembly.Memory(argument);
  const oldMemory = memory.buffer;
  assert_ArrayBuffer(oldMemory, { "size": 1 }, "Buffer before growing");

  assert_throws_js(RangeError, () => memory.grow(2n));
  assert_equals(memory.buffer, oldMemory);
  assert_ArrayBuffer(memory.buffer, { "size": 1 }, "Buffer before trying to grow");
}, "Zero initial growing too much (i64)");

const outOfRangeValuesI64 = [
  -1n,
  0x10000000000000000n,
  "0x10000000000000000",
];

for (const value of outOfRangeValuesI64) {
  test(() => {
    const argument = { "address": "i64", "initial": 0n };
    const memory = new WebAssembly.Memory(argument);
    assert_throws_js(TypeError, () => memory.grow(value));
  }, `Out-of-range i64 argument: ${format_value(value)}`);
}

