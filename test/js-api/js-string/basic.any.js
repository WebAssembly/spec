// META: global=window,dedicatedworker,jsshell,shadowrealm
// META: script=/wasm/jsapi/assertions.js
// META: script=/wasm/jsapi/wasm-module-builder.js
// META: script=/wasm/jsapi/js-string/polyfill.js

// The list of builtins and their signatures.
let builtins;

// Generate two sets of exports, one from a polyfill implementation and another
// from the builtins provided by the host.
let polyfillExports;
let builtinExports;
setup(() => {
  // Compile a module that exports a function for each builtin that will call
  // it. We could just generate a module that re-exports the builtins, but that
  // would not catch any special codegen that could happen when direct calling
  // a known builtin function from wasm.
  const builder = new WasmModuleBuilder();
  const arrayIndex = builder.addArray(kWasmI16, true, kNoSuperType, true);
  builtins = [
    {
      name: "test",
      params: [kWasmExternRef],
      results: [kWasmI32],
    },
    {
      name: "cast",
      params: [kWasmExternRef],
      results: [wasmRefType(kWasmExternRef)],
    },
    {
      name: "fromCharCodeArray",
      params: [wasmRefNullType(arrayIndex), kWasmI32, kWasmI32],
      results: [wasmRefType(kWasmExternRef)],
    },
    {
      name: "intoCharCodeArray",
      params: [kWasmExternRef, wasmRefNullType(arrayIndex), kWasmI32],
      results: [kWasmI32],
    },
    {
      name: "fromCharCode",
      params: [kWasmI32],
      results: [wasmRefType(kWasmExternRef)],
    },
    {
      name: "fromCodePoint",
      params: [kWasmI32],
      results: [wasmRefType(kWasmExternRef)],
    },
    {
      name: "charCodeAt",
      params: [kWasmExternRef, kWasmI32],
      results: [kWasmI32],
    },
    {
      name: "codePointAt",
      params: [kWasmExternRef, kWasmI32],
      results: [kWasmI32],
    },
    {
      name: "length",
      params: [kWasmExternRef],
      results: [kWasmI32],
    },
    {
      name: "concat",
      params: [kWasmExternRef, kWasmExternRef],
      results: [wasmRefType(kWasmExternRef)],
    },
    {
      name: "substring",
      params: [kWasmExternRef, kWasmI32, kWasmI32],
      results: [wasmRefType(kWasmExternRef)],
    },
    {
      name: "equals",
      params: [kWasmExternRef, kWasmExternRef],
      results: [kWasmI32],
    },
    {
      name: "compare",
      params: [kWasmExternRef, kWasmExternRef],
      results: [kWasmI32],
    },
  ];

  // Add a function type for each builtin
  for (let builtin of builtins) {
    builtin.type = builder.addType({
      params: builtin.params,
      results: builtin.results
    });
  }

  // Add an import for each builtin
  for (let builtin of builtins) {
    builtin.importFuncIndex = builder.addImport(
      "wasm:js/string",
      builtin.name,
      builtin.type);
    builtin.importFuncIndexLegacy = builder.addImport(
      "wasm:js-string",
      builtin.name,
      builtin.type);
  }

  // Generate an exported function to call the modern builtin
  for (let builtin of builtins) {
    let func = builder.addFunction(builtin.name + "Imp", builtin.type);
    func.addLocals(builtin.params.length);
    let body = [];
    for (let i = 0; i < builtin.params.length; i++) {
      body.push(kExprLocalGet);
      body.push(...wasmSignedLeb(i));
    }
    body.push(kExprCallFunction);
    body.push(...wasmSignedLeb(builtin.importFuncIndex));
    func.addBody(body);
    func.exportAs(builtin.name);
  }

  // Generate an exported function to call the legacy builtin
  for (let builtin of builtins) {
    let func = builder.addFunction(builtin.name + "ImpLegacy", builtin.type);
    func.addLocals(builtin.params.length);
    let body = [];
    for (let i = 0; i < builtin.params.length; i++) {
      body.push(kExprLocalGet);
      body.push(...wasmSignedLeb(i));
    }
    body.push(kExprCallFunction);
    body.push(...wasmSignedLeb(builtin.importFuncIndexLegacy));
    func.addBody(body);
    func.exportAs(builtin.name + "Legacy");
  }

  const buffer = builder.toBuffer();

  // Instantiate this module using the builtins from the host
  const builtinModule = new WebAssembly.Module(buffer, {
    builtins: ["js-string", "js/string"]
  });
  const builtinInstance = new WebAssembly.Instance(builtinModule, {});
  builtinExports = builtinInstance.exports;

  // Instantiate this module using the polyfill module
  const polyfillModule = new WebAssembly.Module(buffer);
  const polyfillInstance = new WebAssembly.Instance(polyfillModule, {
    "wasm:js-string": polyfillImports,
    "wasm:js/string": polyfillImports
  });
  polyfillExports = polyfillInstance.exports;
});

// A helper function to assert that the behavior of two functions are the
// same. `funcA` may be a single function or an array of functions; each is
// compared against `funcB`.
function assert_same_behavior(funcA, funcB, ...params) {
  const funcsA = Array.isArray(funcA) ? funcA : [funcA];

  let resultB;
  let errB = null;
  try {
    resultB = funcB(...params);
  } catch (err) {
    errB = err;
  }

  let firstResultA;
  let firstErrA = null;
  for (let i = 0; i < funcsA.length; i++) {
    let resultA;
    let errA = null;
    try {
      resultA = funcsA[i](...params);
    } catch (err) {
      errA = err;
    }

    if (errA || errB) {
      assert_equals(errA === null, errB === null, errA ? errA.message : errB.message);
      assert_equals(Object.getPrototypeOf(errA), Object.getPrototypeOf(errB));
    }
    assert_equals(resultA, resultB);

    if (i === 0) {
      firstResultA = resultA;
      firstErrA = errA;
    }
  }

  if (firstErrA) {
    throw firstErrA;
  }
  return firstResultA;
}

function assert_throws_if(func, shouldThrow, constructor) {
  let error = null;
  try {
    func();
  } catch (e) {
    error = e;
  }
  assert_equals(error !== null, shouldThrow, "shouldThrow mismatch");
  if (shouldThrow && error !== null) {
    assert_true(error instanceof constructor);
  }
}

// Constant values used in the tests below
const testStrings = [
  "",
  "a",
  "1",
  "ab",
  "hello, world",
  "\n",
  "☺",
  "☺☺",
  String.fromCodePoint(0x10000, 0x10001)
];
const testCharCodes = [1, 2, 3, 10, 0x7f, 0xff, 0xfffe, 0xffff];
const testCodePoints = [1, 2, 3, 10, 0x7f, 0xff, 0xfffe, 0xffff, 0x10000, 0x10001];
const testExternRefValues = [
  null,
  undefined,
  true,
  false,
  {x:1337},
  ["abracadabra"],
  13.37,
  -0,
  0x7fffffff + 0.1,
  -0x7fffffff - 0.1,
  0x80000000 + 0.1,
  -0x80000000 - 0.1,
  0xffffffff + 0.1,
  -0xffffffff - 0.1,
  Number.EPSILON,
  Number.MAX_SAFE_INTEGER,
  Number.MIN_SAFE_INTEGER,
  Number.MIN_VALUE,
  Number.MAX_VALUE,
  Number.NaN,
  "hi",
  37n,
  new Number(42),
  new Boolean(true),
  Symbol("status"),
  () => 1337,
];

// Test that `test` and `cast` work on various JS values. Run all the
// other builtins and assert that they also perform equivalent type
// checks.
test(() => {
  for (let a of testExternRefValues) {
    let isString = assert_same_behavior(
      [builtinExports['test'], builtinExports['testLegacy']],
      polyfillExports['test'],
      a
    );

    assert_throws_if(() => assert_same_behavior(
        [builtinExports['cast'], builtinExports['castLegacy']],
        polyfillExports['cast'],
        a
      ), !isString, WebAssembly.RuntimeError);

    let arrayMutI16 = helperExports.createArrayMutI16(10);
    assert_throws_if(() => assert_same_behavior(
        [builtinExports['intoCharCodeArray'], builtinExports['intoCharCodeArrayLegacy']],
        polyfillExports['intoCharCodeArray'],
        a, arrayMutI16, 0
      ), !isString, WebAssembly.RuntimeError);

    assert_throws_if(() => assert_same_behavior(
        [builtinExports['charCodeAt'], builtinExports['charCodeAtLegacy']],
        polyfillExports['charCodeAt'],
        a, 0
      ), !isString, WebAssembly.RuntimeError);

    assert_throws_if(() => assert_same_behavior(
        [builtinExports['codePointAt'], builtinExports['codePointAtLegacy']],
        polyfillExports['codePointAt'],
        a, 0
      ), !isString, WebAssembly.RuntimeError);

    assert_throws_if(() => assert_same_behavior(
        [builtinExports['length'], builtinExports['lengthLegacy']],
        polyfillExports['length'],
        a
      ), !isString, WebAssembly.RuntimeError);

    assert_throws_if(() => assert_same_behavior(
        [builtinExports['concat'], builtinExports['concatLegacy']],
        polyfillExports['concat'],
        a, a
      ), !isString, WebAssembly.RuntimeError);

    assert_throws_if(() => assert_same_behavior(
        [builtinExports['substring'], builtinExports['substringLegacy']],
        polyfillExports['substring'],
        a, 0, 0
      ), !isString, WebAssembly.RuntimeError);

    assert_throws_if(() => assert_same_behavior(
        [builtinExports['equals'], builtinExports['equalsLegacy']],
        polyfillExports['equals'],
        a, a
      ), a !== null && !isString, WebAssembly.RuntimeError);

    assert_throws_if(() => assert_same_behavior(
        [builtinExports['compare'], builtinExports['compareLegacy']],
        polyfillExports['compare'],
        a, a
      ), !isString, WebAssembly.RuntimeError);
  }
});

// Test that `fromCharCode` works on various char codes
test(() => {
  for (let a of testCharCodes) {
    assert_same_behavior(
      [builtinExports['fromCharCode'], builtinExports['fromCharCodeLegacy']],
      polyfillExports['fromCharCode'],
      a
    );
  }
});

// Test that `fromCodePoint` works on various code points
test(() => {
  for (let a of testCodePoints) {
    assert_same_behavior(
      [builtinExports['fromCodePoint'], builtinExports['fromCodePointLegacy']],
      polyfillExports['fromCodePoint'],
      a
    );
  }
});

// Perform tests on various strings
test(() => {
  for (let a of testStrings) {
    let length = assert_same_behavior(
      [builtinExports['length'], builtinExports['lengthLegacy']],
      polyfillExports['length'],
      a
    );

    for (let i = 0; i < length; i++) {
      let charCode = assert_same_behavior(
        [builtinExports['charCodeAt'], builtinExports['charCodeAtLegacy']],
        polyfillExports['charCodeAt'],
        a, i
      );
    }

    for (let i = 0; i < length; i++) {
      let charCode = assert_same_behavior(
        [builtinExports['codePointAt'], builtinExports['codePointAtLegacy']],
        polyfillExports['codePointAt'],
        a, i
      );
    }

    let arrayMutI16 = helperExports.createArrayMutI16(length);
    assert_same_behavior(
      [builtinExports['intoCharCodeArray'], builtinExports['intoCharCodeArrayLegacy']],
      polyfillExports['intoCharCodeArray'],
      a, arrayMutI16, 0
    );

    assert_same_behavior(
      [builtinExports['fromCharCodeArray'], builtinExports['fromCharCodeArrayLegacy']],
      polyfillExports['fromCharCodeArray'],
      arrayMutI16, 0, length
    );

    for (let i = 0; i < length; i++) {
      for (let j = 0; j < length; j++) {
        assert_same_behavior(
          [builtinExports['substring'], builtinExports['substringLegacy']],
          polyfillExports['substring'],
          a, i, j
        );
      }
    }
  }
});

// Test various binary operations
test(() => {
  for (let a of testStrings) {
    for (let b of testStrings) {
      assert_same_behavior(
        [builtinExports['concat'], builtinExports['concatLegacy']],
        polyfillExports['concat'],
        a, b
      );

      assert_same_behavior(
        [builtinExports['equals'], builtinExports['equalsLegacy']],
        polyfillExports['equals'],
        a, b
      );

      assert_same_behavior(
        [builtinExports['compare'], builtinExports['compareLegacy']],
        polyfillExports['compare'],
        a, b
      );
    }
  }
});

// Test that incorrect import types are rejected, even if they have correct
// signatures.
test(() => {
  for (let builtin of builtins) {
    const builder = new WasmModuleBuilder();
    // The type is wrong because it is in a nontrivial rec group.
    const typeIndex = builder.nextTypeIndex();
    builder.startRecGroup();
    builder.addType({
      params: builtin.params,
      results: builtin.results
    });
    builder.addStruct([]);
    builder.endRecGroup();

    builder.addImport(
      "wasm:js-string",
      builtin.name,
      typeIndex);

    const buffer = builder.toBuffer();

    // Validation should fail.
    assert_false(WebAssembly.validate(buffer, { builtins: ["js-string"] }));

    // Compilation should fail.
    assert_throws_js(WebAssembly.CompileError, () => {
      new WebAssembly.Module(buffer, { builtins: ["js-string"] });
    });
  }
}, "Incorrect types");
