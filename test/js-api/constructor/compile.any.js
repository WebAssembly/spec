// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/wasm-module-builder.js

function assert_Module(module) {
  assert_equals(Object.getPrototypeOf(module), WebAssembly.Module.prototype,
                "Prototype");
  assert_true(Object.isExtensible(module), "Extensibility");
}

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
  return promise_rejects_js(t, TypeError, WebAssembly.compile());
}, "Missing argument");

promise_test(t => {
  const invalidArguments = [
    undefined,
    null,
    true,
    "",
    Symbol(),
    1,
    {},
    ArrayBuffer,
    ArrayBuffer.prototype,
    Array.from(emptyModuleBinary),
  ];
  return Promise.all(invalidArguments.map(argument => {
    return promise_rejects_js(t, TypeError, WebAssembly.compile(argument),
                           `compile(${format_value(argument)})`);
  }));
}, "Invalid arguments");

promise_test(() => {
  const fn = WebAssembly.compile;
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
    return fn.call(thisValue, emptyModuleBinary).then(assert_Module);
  }));
}, "Branding");

test(() => {
  const promise = WebAssembly.compile(emptyModuleBinary);
  assert_equals(Object.getPrototypeOf(promise), Promise.prototype, "prototype");
  assert_true(Object.isExtensible(promise), "extensibility");
}, "Promise type");

promise_test(t => {
  const buffer = new Uint8Array();
  return promise_rejects_js(t, WebAssembly.CompileError, WebAssembly.compile(buffer));
}, "Empty buffer");

promise_test(t => {
  return promise_rejects_js(t, WebAssembly.CompileError, WebAssembly.compile(invalidModuleBinary));
}, "Invalid code");

promise_test(() => {
  return WebAssembly.compile(emptyModuleBinary).then(assert_Module);
}, "Result type");

promise_test(() => {
  return WebAssembly.compile(emptyModuleBinary, {}).then(assert_Module);
}, "Stray argument");

promise_test(() => {
  const buffer = new WasmModuleBuilder().toBuffer();
  assert_equals(buffer[0], 0);
  const promise = WebAssembly.compile(buffer);
  buffer[0] = 1;
  return promise.then(assert_Module);
}, "Changing the buffer");

promise_test(() => {
  return WebAssembly.compile(emptyModuleSharedBuffer).then(assert_Module);
}, "SharedArrayBuffer-backed view");

promise_test(t => {
  return promise_rejects_js(t, WebAssembly.CompileError, WebAssembly.compile(invalidModuleSharedBuffer));
}, "Invalid module in SharedArrayBuffer");

promise_test(() => {
  return WebAssembly.compile(emptyModuleResizableBuffer).then(assert_Module);
}, "Resizable ArrayBuffer-backed view");

promise_test(t => {
  return promise_rejects_js(t, WebAssembly.CompileError, WebAssembly.compile(invalidModuleResizableBuffer));
}, "Invalid module in resizable ArrayBuffer");

promise_test(() => {
  return WebAssembly.compile(emptyModuleGrowableSharedBuffer).then(assert_Module);
}, "Growable SharedArrayBuffer-backed view");

promise_test(t => {
  return promise_rejects_js(t, WebAssembly.CompileError, WebAssembly.compile(invalidModuleGrowableSharedBuffer));
}, "Invalid module in growable SharedArrayBuffer");
