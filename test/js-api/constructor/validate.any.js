// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/wasm-module-builder.js

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
  assert_throws_js(TypeError, () => WebAssembly.validate());
}, "Missing argument");

test(() => {
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
  for (const argument of invalidArguments) {
    assert_throws_js(TypeError, () => WebAssembly.validate(argument),
                     `validate(${format_value(argument)})`);
  }
}, "Invalid arguments");

test(() => {
  const fn = WebAssembly.validate;
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
  for (const thisValue of thisValues) {
    assert_true(fn.call(thisValue, emptyModuleBinary), `this=${format_value(thisValue)}`);
  }
}, "Branding");

const modules = [
  // Incomplete header.
  [[], false],
  [[0x00], false],
  [[0x00, 0x61], false],
  [[0x00, 0x61, 0x73], false],
  [[0x00, 0x61, 0x73, 0x6d], false],
  [[0x00, 0x61, 0x73, 0x6d, 0x01], false],
  [[0x00, 0x61, 0x73, 0x6d, 0x01, 0x00], false],
  [[0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00], false],

  // Complete header.
  [[0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00], true],

  // Invalid version.
  [[0x00, 0x61, 0x73, 0x6d, 0x00, 0x00, 0x00, 0x00], false],
  [[0x00, 0x61, 0x73, 0x6d, 0x02, 0x00, 0x00, 0x00], false],

  // Nameless custom section.
  [[0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00], false],

  // Custom section with empty name.
  [[0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00], true],

  // Custom section with name "a".
  [[0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00, 0x00, 0x02, 0x01, 0x61], true],
];
const bufferTypes = [
  Uint8Array,
  Int8Array,
  Uint16Array,
  Int16Array,
  Uint32Array,
  Int32Array,
];
for (const [module, expected] of modules) {
  const name = module.map(n => n.toString(16)).join(" ");
  for (const bufferType of bufferTypes) {
    if (module.length % bufferType.BYTES_PER_ELEMENT === 0) {
      test(() => {
        const bytes = new Uint8Array(module);
        const moduleBuffer = new bufferType(bytes.buffer);
        assert_equals(WebAssembly.validate(moduleBuffer), expected);
      }, `Validating module [${name}] in ${bufferType.name}`);
    }
  }
}

test(() => {
  assert_true(WebAssembly.validate(emptyModuleBinary, {}));
}, "Stray argument");

test(() => {
  assert_true(WebAssembly.validate(emptyModuleSharedBuffer));
}, "SharedArrayBuffer-backed view");

test(() => {
  assert_false(WebAssembly.validate(invalidModuleSharedBuffer));
}, "Invalid module in SharedArrayBuffer");

test(() => {
  assert_true(WebAssembly.validate(emptyModuleResizableBuffer));
}, "Resizable ArrayBuffer-backed view");

test(() => {
  assert_false(WebAssembly.validate(invalidModuleResizableBuffer));
}, "Invalid module in resizable ArrayBuffer");

test(() => {
  assert_true(WebAssembly.validate(emptyModuleGrowableSharedBuffer));
}, "Growable SharedArrayBuffer-backed view");

test(() => {
  assert_false(WebAssembly.validate(invalidModuleGrowableSharedBuffer));
}, "Invalid module in growable SharedArrayBuffer");
