// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/wasm-module-builder.js
// META: script=/wasm/jsapi/assertions.js
// META: script=/wasm/jsapi/instanceTestFactory.js

function copyToSharedBuffer(buffer) {
  const sab = new SharedArrayBuffer(buffer.byteLength);
  new Uint8Array(sab).set(buffer);
  return new Uint8Array(sab);
}

function copyToResizableBuffer(buffer) {
  const rab = new ArrayBuffer(buffer.byteLength, { maxByteLength: buffer.byteLength * 2 });
  new Uint8Array(rab).set(buffer);
  return new Uint8Array(rab);
}

function copyToGrowableSharedBuffer(buffer) {
  const gsab = new SharedArrayBuffer(buffer.byteLength, { maxByteLength: buffer.byteLength * 2 });
  new Uint8Array(gsab).set(buffer);
  return new Uint8Array(gsab);
}

let emptyModuleBinary;
let emptyModuleSharedBuffer;
let emptyModuleResizableBuffer;
let emptyModuleGrowableSharedBuffer;
let invalidModuleBinary;
let invalidModuleSharedBuffer;
let invalidModuleResizableBuffer;
let invalidModuleGrowableSharedBuffer;
setup(() => {
  emptyModuleBinary = new WasmModuleBuilder().toBuffer();
  emptyModuleSharedBuffer = copyToSharedBuffer(emptyModuleBinary);
  emptyModuleResizableBuffer = copyToResizableBuffer(emptyModuleBinary);
  emptyModuleGrowableSharedBuffer = copyToGrowableSharedBuffer(emptyModuleBinary);

  invalidModuleBinary = new Uint8Array(Array.from(emptyModuleBinary).concat([0, 0]));
  invalidModuleSharedBuffer = copyToSharedBuffer(invalidModuleBinary);
  invalidModuleResizableBuffer = copyToResizableBuffer(invalidModuleBinary);
  invalidModuleGrowableSharedBuffer = copyToGrowableSharedBuffer(invalidModuleBinary);
});

promise_test(t => {
  return promise_rejects_js(t, TypeError, WebAssembly.instantiate());
}, "Missing arguments");

promise_test(() => {
  const fn = WebAssembly.instantiate;
  const thisValues = [
    undefined,
    null,
    true,
    "",
    Symbol(),
    1,
    {},
    WebAssembly,
  ];
  return Promise.all(thisValues.map(thisValue => {
    return fn.call(thisValue, emptyModuleBinary).then(assert_WebAssemblyInstantiatedSource);
  }));
}, "Branding");

promise_test(t => {
  const invalidArguments = [
    undefined,
    null,
    true,
    "",
    Symbol(),
    1,
    {},
    WebAssembly.Module,
    WebAssembly.Module.prototype,
    ArrayBuffer,
    ArrayBuffer.prototype,
    Array.from(emptyModuleBinary),
  ];
  return Promise.all(invalidArguments.map(argument => {
    return promise_rejects_js(t, TypeError, WebAssembly.instantiate(argument),
                           `instantiate(${format_value(argument)})`);
  }));
}, "Invalid arguments");

test(() => {
  const promise = WebAssembly.instantiate(emptyModuleBinary);
  assert_equals(Object.getPrototypeOf(promise), Promise.prototype, "prototype");
  assert_true(Object.isExtensible(promise), "extensibility");
}, "Promise type");

for (const [name, fn] of instanceTestFactory) {
  promise_test(() => {
    const { buffer, args, exports, verify } = fn();
    return WebAssembly.instantiate(buffer, ...args).then(result => {
      assert_WebAssemblyInstantiatedSource(result, exports);
      verify(result.instance);
    });
  }, `${name}: BufferSource argument`);

  promise_test(() => {
    const { buffer, args, exports, verify } = fn();
    const module = new WebAssembly.Module(buffer);
    return WebAssembly.instantiate(module, ...args).then(instance => {
      assert_Instance(instance, exports);
      verify(instance);
    });
  }, `${name}: Module argument`);
}

promise_test(() => {
  const builder = new WasmModuleBuilder();
  builder.addImportedGlobal("module", "global", kWasmI32);
  const buffer = builder.toBuffer();
  const order = [];

  const imports = {
    get module() {
      order.push("module getter");
      return {
        get global() {
          order.push("global getter");
          return 0;
        },
      }
    },
  };

  const expected = [
    "module getter",
    "global getter",
  ];
  const p = WebAssembly.instantiate(buffer, imports);
  assert_array_equals(order, []);
  return p.then(result => {
    assert_WebAssemblyInstantiatedSource(result);
    assert_array_equals(order, expected);
  });
}, "Synchronous options handling: Buffer argument");

promise_test(() => {
  const builder = new WasmModuleBuilder();
  builder.addImportedGlobal("module", "global", kWasmI32);
  const buffer = builder.toBuffer();
  const module = new WebAssembly.Module(buffer);
  const order = [];

  const imports = {
    get module() {
      order.push("module getter");
      return {
        get global() {
          order.push("global getter");
          return 0;
        },
      }
    },
  };

  const expected = [
    "module getter",
    "global getter",
  ];
  const p = WebAssembly.instantiate(module, imports);
  assert_array_equals(order, expected);
  return p.then(instance => assert_Instance(instance, {}));
}, "Synchronous options handling: Module argument");

promise_test(t => {
  const buffer = new Uint8Array();
  return promise_rejects_js(t, WebAssembly.CompileError, WebAssembly.instantiate(buffer));
}, "Empty buffer");

promise_test(t => {
  return promise_rejects_js(t, WebAssembly.CompileError, WebAssembly.instantiate(invalidModuleBinary));
}, "Invalid code");

promise_test(() => {
  const buffer = new WasmModuleBuilder().toBuffer();
  assert_equals(buffer[0], 0);
  const promise = WebAssembly.instantiate(buffer);
  buffer[0] = 1;
  return promise.then(assert_WebAssemblyInstantiatedSource);
}, "Changing the buffer");

promise_test(() => {
  return WebAssembly.instantiate(emptyModuleSharedBuffer).then(assert_WebAssemblyInstantiatedSource);
}, "SharedArrayBuffer-backed view");

promise_test(t => {
  return promise_rejects_js(t, WebAssembly.CompileError, WebAssembly.instantiate(invalidModuleSharedBuffer));
}, "Invalid module in SharedArrayBuffer");

promise_test(() => {
  return WebAssembly.instantiate(emptyModuleResizableBuffer).then(assert_WebAssemblyInstantiatedSource);
}, "Resizable ArrayBuffer-backed view");

promise_test(t => {
  return promise_rejects_js(t, WebAssembly.CompileError, WebAssembly.instantiate(invalidModuleResizableBuffer));
}, "Invalid module in resizable ArrayBuffer");

promise_test(() => {
  return WebAssembly.instantiate(emptyModuleGrowableSharedBuffer).then(assert_WebAssemblyInstantiatedSource);
}, "Growable SharedArrayBuffer-backed view");

promise_test(t => {
  return promise_rejects_js(t, WebAssembly.CompileError, WebAssembly.instantiate(invalidModuleGrowableSharedBuffer));
}, "Invalid module in growable SharedArrayBuffer");
