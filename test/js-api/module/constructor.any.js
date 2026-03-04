// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/wasm-module-builder.js
// META: script=/wasm/jsapi/assertions.js

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

test(() => {
  assert_function_name(WebAssembly.Module, "Module", "WebAssembly.Module");
}, "name");

test(() => {
  assert_function_length(WebAssembly.Module, 1, "WebAssembly.Module");
}, "length");

test(() => {
  assert_throws_js(TypeError, () => new WebAssembly.Module());
}, "No arguments");

test(() => {
  assert_throws_js(TypeError, () => WebAssembly.Module(emptyModuleBinary));
}, "Calling");

test(() => {
  const invalidArguments = [
    undefined,
    null,
    true,
    "test",
    Symbol(),
    7,
    NaN,
    {},
    ArrayBuffer,
    ArrayBuffer.prototype,
    Array.from(emptyModuleBinary),
  ];
  for (const argument of invalidArguments) {
    assert_throws_js(TypeError, () => new WebAssembly.Module(argument),
                     `new Module(${format_value(argument)})`);
  }
}, "Invalid arguments");

test(() => {
  const buffer = new Uint8Array();
  assert_throws_js(WebAssembly.CompileError, () => new WebAssembly.Module(buffer));
}, "Empty buffer");

test(() => {
  assert_throws_js(WebAssembly.CompileError, () => new WebAssembly.Module(invalidModuleBinary));
}, "Invalid code");

test(() => {
  const module = new WebAssembly.Module(emptyModuleBinary);
  assert_equals(Object.getPrototypeOf(module), WebAssembly.Module.prototype);
}, "Prototype");

test(() => {
  const module = new WebAssembly.Module(emptyModuleBinary);
  assert_true(Object.isExtensible(module));
}, "Extensibility");

test(() => {
  const module = new WebAssembly.Module(emptyModuleBinary, {});
  assert_equals(Object.getPrototypeOf(module), WebAssembly.Module.prototype);
}, "Stray argument");

test(() => {
  const module = new WebAssembly.Module(emptyModuleSharedBuffer);
  assert_true(module instanceof WebAssembly.Module);
}, "SharedArrayBuffer-backed view");

test(() => {
  assert_throws_js(WebAssembly.CompileError, () => new WebAssembly.Module(invalidModuleSharedBuffer));
}, "Invalid module in SharedArrayBuffer");

test(() => {
  const module = new WebAssembly.Module(emptyModuleResizableBuffer);
  assert_true(module instanceof WebAssembly.Module);
}, "Resizable ArrayBuffer-backed view");

test(() => {
  assert_throws_js(WebAssembly.CompileError, () => new WebAssembly.Module(invalidModuleResizableBuffer));
}, "Invalid module in resizable ArrayBuffer");

test(() => {
  const module = new WebAssembly.Module(emptyModuleGrowableSharedBuffer);
  assert_true(module instanceof WebAssembly.Module);
}, "Growable SharedArrayBuffer-backed view");

test(() => {
  assert_throws_js(WebAssembly.CompileError, () => new WebAssembly.Module(invalidModuleGrowableSharedBuffer));
}, "Invalid module in growable SharedArrayBuffer");
