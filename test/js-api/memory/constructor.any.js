// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/assertions.js
// META: script=/wasm/jsapi/memory/assertions.js

test(() => {
  assert_function_name(WebAssembly.Memory, "Memory", "WebAssembly.Memory");
}, "name");

test(() => {
  assert_function_length(WebAssembly.Memory, 1, "WebAssembly.Memory");
}, "length");

test(() => {
  assert_throws_js(TypeError, () => new WebAssembly.Memory());
}, "No arguments");

test(() => {
  const argument = { "initial": 0 };
  assert_throws_js(TypeError, () => WebAssembly.Memory(argument));
}, "Calling");

test(() => {
  const invalidArguments = [
    undefined,
    null,
    false,
    true,
    "",
    "test",
    Symbol(),
    1,
    NaN,
    {},
  ];
  for (const invalidArgument of invalidArguments) {
    assert_throws_js(TypeError,
                     () => new WebAssembly.Memory(invalidArgument),
                     `new Memory(${format_value(invalidArgument)})`);
  }
}, "Invalid descriptor argument");

test(() => {
  assert_throws_js(TypeError, () => new WebAssembly.Memory({ "initial": undefined }));
}, "Undefined initial value in descriptor");

const outOfRangeValues = [
  NaN,
  Infinity,
  -Infinity,
  -1,
  0x100000000,
  0x1000000000,
];

for (const value of outOfRangeValues) {
  test(() => {
    assert_throws_js(TypeError, () => new WebAssembly.Memory({ "initial": value }));
  }, `Out-of-range initial value in descriptor: ${format_value(value)}`);

  test(() => {
    assert_throws_js(TypeError, () => new WebAssembly.Memory({ "initial": 0, "maximum": value }));
  }, `Out-of-range maximum value in descriptor: ${format_value(value)}`);
}

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
  assert_throws_js(RangeError, () => new WebAssembly.Memory({ "initial": 10, "maximum": 9 }));
}, "Initial value exceeds maximum");

test(() => {
  assert_throws_js(RangeError, () => new WebAssembly.Memory({ "address": "i64", "initial": 10n, "maximum": 9n }));
}, "Initial value exceeds maximum (i64)");

test(() => {
  const proxy = new Proxy({}, {
    has(o, x) {
      assert_unreached(`Should not call [[HasProperty]] with ${x}`);
    },
    get(o, x) {
      // Due to the requirement not to supply both minimum and initial, we need to ignore one of them.
      switch (x) {
        case "shared":
          return false;
        case "initial":
        case "maximum":
          return 0;
        case "address":
          return "i32";
        default:
          return undefined;
      }
    },
  });
  new WebAssembly.Memory(proxy);
}, "Proxy descriptor");

test(() => {
  const order = [];

  new WebAssembly.Memory({
    get maximum() {
      order.push("maximum");
      return {
        valueOf() {
          order.push("maximum valueOf");
          return 1;
        },
      };
    },

    get initial() {
      order.push("initial");
      return {
        valueOf() {
          order.push("initial valueOf");
          return 1;
        },
      };
    },

    get address() {
      order.push("address");
      return {
        toString() {
          order.push("address toString");
          return "i32";
        },
      };
    },
  });

  assert_array_equals(order, [
    "address",
    "address toString",
    "initial",
    "initial valueOf",
    "maximum",
    "maximum valueOf",
  ]);
}, "Order of evaluation for descriptor");

test(() => {
  const argument = { "initial": 0 };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 0 });
}, "Zero initial");

test(() => {
  const argument = { "initial": 4 };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 4 });
}, "Non-zero initial");

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
  const argument = { "initial": 0 };
  const memory = new WebAssembly.Memory(argument, {});
  assert_Memory(memory, { "size": 0 });
}, "Stray argument");

test(() => {
  const argument = { "initial": 1 };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 1, "address": "i32" });
}, "Memory with address parameter omitted");

test(() => {
  const argument = { "initial": 1, "address": "i32" };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 1, "address": "i32" });
}, "Memory with i32 address constructor");

test(() => {
  const argument = { "initial": 1n, "address": "i64" };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 1, "address": "i64" });
}, "Memory with i64 address constructor");

test(() => {
  const argument = { "initial": "3" };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 3 });
}, "Memory with string value for initial");

test(() => {
  const argument = { "address": "i64", "initial": "3" };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 3, "address": "i64" });
}, "Memory with string value for initial (i64)");

test(() => {
  const argument = { "initial": true };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 1 });
}, "Memory with boolean value for initial");

test(() => {
  const argument = { "address": "i64", "initial": true };
  const memory = new WebAssembly.Memory(argument);
  assert_Memory(memory, { "size": 1, "address": "i64" });
}, "Memory with boolean value for initial (i64)");

test(() => {
  assert_throws_js(TypeError, () => new WebAssembly.Memory({ "initial": 1, "address": "none" }));
}, "Unknown memory address");
