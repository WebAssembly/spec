// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/wasm-module-builder.js
// META: script=/wasm/jsapi/assertions.js
// META: script=/wasm/jsapi/table/assertions.js

test(() => {
  assert_function_name(WebAssembly.Table, "Table", "WebAssembly.Table");
}, "name");

test(() => {
  assert_function_length(WebAssembly.Table, 1, "WebAssembly.Table");
}, "length");

test(() => {
  assert_throws_js(TypeError, () => new WebAssembly.Table());
}, "No arguments");

test(() => {
  const argument = { "element": "anyfunc", "initial": 0 };
  assert_throws_js(TypeError, () => WebAssembly.Table(argument));
}, "Calling");

test(() => {
  assert_throws_js(TypeError, () => new WebAssembly.Table({}));
}, "Empty descriptor");

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
                     () => new WebAssembly.Table(invalidArgument),
                     `new Table(${format_value(invalidArgument)})`);
  }
}, "Invalid descriptor argument");

test(() => {
  assert_throws_js(TypeError, () => new WebAssembly.Table({ "element": "anyfunc", "initial": undefined }));
}, "Undefined initial value in descriptor");

test(() => {
  assert_throws_js(TypeError, () => new WebAssembly.Table({ "element": undefined, "initial": 0 }));
}, "Undefined element value in descriptor");

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
    assert_throws_js(TypeError, () => new WebAssembly.Table({ "element": "anyfunc", "initial": value }));
  }, `Out-of-range initial value in descriptor: ${format_value(value)}`);

  test(() => {
    assert_throws_js(TypeError, () => new WebAssembly.Table({ "element": "anyfunc", "initial": 0, "maximum": value }));
  }, `Out-of-range maximum value in descriptor: ${format_value(value)}`);
}

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
  assert_throws_js(RangeError, () => new WebAssembly.Table({ "element": "anyfunc", "initial": 10, "maximum": 9 }));
}, "Initial value exceeds maximum");

test(() => {
  assert_throws_js(RangeError, () => new WebAssembly.Table({ "element": "anyfunc", "address": "i64", "initial": 10n, "maximum": 9n }));
}, "Initial value exceeds maximum (i64)");

test(() => {
  const argument = { "element": "anyfunc", "initial": 0 };
  const table = new WebAssembly.Table(argument);
  assert_Table(table, { "length": 0 });
}, "Basic (zero)");

test(() => {
  const argument = { "element": "anyfunc", "initial": 5 };
  const table = new WebAssembly.Table(argument);
  assert_Table(table, { "length": 5 });
}, "Basic (non-zero)");

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
  const argument = { "element": "anyfunc", "initial": 0 };
  const table = new WebAssembly.Table(argument, null, {});
  assert_Table(table, { "length": 0 });
}, "Stray argument");

test(() => {
  const proxy = new Proxy({}, {
    has(o, x) {
      assert_unreached(`Should not call [[HasProperty]] with ${x}`);
    },
    get(o, x) {
      switch (x) {
      case "element":
        return "anyfunc";
      case "initial":
      case "maximum":
        return 0;
      default:
        return undefined;
      }
    },
  });
  const table = new WebAssembly.Table(proxy);
  assert_Table(table, { "length": 0 });
}, "Proxy descriptor");

test(() => {
  const table = new WebAssembly.Table({
    "element": {
      toString() { return "anyfunc"; },
    },
    "initial": 1,
  });
  assert_Table(table, { "length": 1 });
}, "Type conversion for descriptor.element");

test(() => {
  const order = [];

  new WebAssembly.Table({
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

    get element() {
      order.push("element");
      return {
        toString() {
          order.push("element toString");
          return "anyfunc";
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
    "element",
    "element toString",
    "address",
    "address toString",
    "initial",
    "initial valueOf",
    "maximum",
    "maximum valueOf",
  ]);
}, "Order of evaluation for descriptor");

test(() => {
  const testObject = {};
  const argument = { "element": "externref", "initial": 3 };
  const table = new WebAssembly.Table(argument, testObject);
  assert_equals(table.length, 3);
  assert_equals(table.get(0), testObject);
  assert_equals(table.get(1), testObject);
  assert_equals(table.get(2), testObject);
}, "initialize externref table with default value");

test(() => {
  const argument = { "element": "i32", "initial": 3 };
  assert_throws_js(TypeError, () => new WebAssembly.Table(argument));
}, "initialize table with a wrong element value");

test(() => {
  const builder = new WasmModuleBuilder();
  builder
    .addFunction("fn", kSig_v_v)
    .addBody([])
    .exportFunc();
  const bin = builder.toBuffer();
  const fn = new WebAssembly.Instance(new WebAssembly.Module(bin)).exports.fn;
  const argument = { "element": "anyfunc", "initial": 3 };
  const table = new WebAssembly.Table(argument, fn);
  assert_equals(table.length, 3);
  assert_equals(table.get(0), fn);
  assert_equals(table.get(1), fn);
  assert_equals(table.get(2), fn);
}, "initialize anyfunc table with default value");

test(() => {
  const argument = { "element": "anyfunc", "initial": 3 };
  assert_throws_js(TypeError, () => new WebAssembly.Table(argument, {}));
  assert_throws_js(TypeError, () => new WebAssembly.Table(argument, "cannot be used as a wasm function"));
  assert_throws_js(TypeError, () => new WebAssembly.Table(argument, 37));
}, "initialize anyfunc table with a bad default value");

test(() => {
  const argument = { "element": "anyfunc", "initial": 3, "address": "i32" };
  const table = new WebAssembly.Table(argument);
  // Once this is merged with the type reflection proposal we should check the
  // address type of `table`.
  assert_equals(table.length, 3);
}, "Table with i32 address constructor");

test(() => {
  const argument = { "element": "anyfunc", "initial": 3n, "address": "i64" };
  const table = new WebAssembly.Table(argument);
  // Once this is merged with the type reflection proposal we should check the
  // address type of `table`.
  assert_equals(table.length, 3n);
}, "Table with i64 address constructor");

test(() => {
  const argument = { "element": "anyfunc", "initial": "3", "address": "i32" };
  const table = new WebAssembly.Table(argument);
  assert_equals(table.length, 3);
}, "Table with string value for initial");

test(() => {
  const argument = { "element": "anyfunc", "initial": "3", "address": "i64" };
  const table = new WebAssembly.Table(argument);
  assert_equals(table.length, 3n);
}, "Table with string value for initial (i64)");

test(() => {
  const argument = { "element": "anyfunc", "initial": true, "address": "i32" };
  const table = new WebAssembly.Table(argument);
  assert_equals(table.length, 1);
}, "Table with boolean value for initial");

test(() => {
  const argument = { "element": "anyfunc", "initial": true, "address": "i64" };
  const table = new WebAssembly.Table(argument);
  assert_equals(table.length, 1n);
}, "Table with boolean value for initial (i64)");

test(() => {
  const argument = { "element": "anyfunc", "initial": 0, "maximum": "3", "address": "i32" };
  const table = new WebAssembly.Table(argument);
  table.grow(3);
  assert_equals(table.length, 3);
}, "Table with string value for maximum");

test(() => {
  const argument = { "element": "anyfunc", "initial": 0n, "maximum": "3", "address": "i64" };
  const table = new WebAssembly.Table(argument);
  table.grow(3n);
  assert_equals(table.length, 3n);
}, "Table with string value for maximum (i64)");

test(() => {
  const argument = { "element": "anyfunc", "initial": 0, "maximum": true, "address": "i32" };
  const table = new WebAssembly.Table(argument);
  table.grow(1);
  assert_equals(table.length, 1);
}, "Table with boolean value for maximum");

test(() => {
  const argument = { "element": "anyfunc", "initial": 0n, "maximum": true, "address": "i64" };
  const table = new WebAssembly.Table(argument);
  table.grow(1n);
  assert_equals(table.length, 1n);
}, "Table with boolean value for maximum (i64)");

test(() => {
  const argument = { "element": "anyfunc", "initial": 3, "address": "unknown" };
  assert_throws_js(TypeError, () => new WebAssembly.Table(argument));
}, "Unknown table address");

test(() => {
  const argument = { "element": "i32", "initial": 3n };
  assert_throws_js(TypeError, () => new WebAssembly.Table(argument));
}, "initialize table with a wrong initial type");

test(() => {
  const argument = { "element": "i32", "initial": 3, "maximum": 10n };
  assert_throws_js(TypeError, () => new WebAssembly.Table(argument));
}, "initialize table with a wrong maximum type");

test(() => {
  const argument = { "element": "i32", "initial": 3 };
  assert_throws_js(TypeError, () => new WebAssembly.Table(argument));
}, "initialize table with a wrong initial type (i64)");

test(() => {
  const argument = { "element": "i32", "initial": 3n, "maximum": 10 };
  assert_throws_js(TypeError, () => new WebAssembly.Table(argument));
}, "initialize table with a wrong maximum type (i64)");
