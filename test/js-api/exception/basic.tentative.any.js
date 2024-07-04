// META: global=window,dedicatedworker,jsshell,shadowrealm
// META: script=/wasm/jsapi/wasm-module-builder.js

function assert_throws_wasm(fn, message) {
  try {
    fn();
    assert_not_reached(`expected to throw with ${message}`);
  } catch (e) {
    assert_true(e instanceof WebAssembly.Exception, `Error should be a WebAssembly.Exception with ${message}`);
  }
}

promise_test(async () => {
  const kSig_v_r = makeSig([kWasmExternRef], []);
  const builder = new WasmModuleBuilder();
  const tagIndexExternref = builder.addTag(kSig_v_r);
  builder.addFunction("throw_param", kSig_v_r)
    .addBody([
      kExprLocalGet, 0,
      kExprThrow, tagIndexExternref,
    ])
    .exportFunc();
  const buffer = builder.toBuffer();
  const {instance} = await WebAssembly.instantiate(buffer, {});
  const values = [
    undefined,
    null,
    true,
    false,
    "test",
    Symbol(),
    0,
    1,
    4.2,
    NaN,
    Infinity,
    {},
    () => {},
  ];
  for (const v of values) {
    assert_throws_wasm(() => instance.exports.throw_param(v), String(v));
  }
}, "Wasm function throws argument");

promise_test(async () => {
  const builder = new WasmModuleBuilder();
  const tagIndexAnyref = builder.addTag(kSig_v_a);
  builder.addFunction("throw_null", kSig_v_v)
    .addBody([
      kExprRefNull, kAnyFuncCode,
      kExprThrow, tagIndexAnyref,
    ])
    .exportFunc();
  const buffer = builder.toBuffer();
  const {instance} = await WebAssembly.instantiate(buffer, {});
  assert_throws_wasm(() => instance.exports.throw_null());
}, "Wasm function throws null");

promise_test(async () => {
  const builder = new WasmModuleBuilder();
  const tagIndexI32 = builder.addTag(kSig_v_i);
  builder.addFunction("throw_int", kSig_v_v)
    .addBody([
      ...wasmI32Const(7),
      kExprThrow, tagIndexI32,
    ])
    .exportFunc();
  const buffer = builder.toBuffer();
  const {instance} = await WebAssembly.instantiate(buffer, {});
  assert_throws_wasm(() => instance.exports.throw_int());
}, "Wasm function throws integer");

promise_test(async () => {
  const builder = new WasmModuleBuilder();
  const fnIndex = builder.addImport("module", "fn", kSig_v_v);
  const tagIndexExternref = builder.addTag(kSig_v_r);

  builder.addFunction("catch_exception", kSig_r_v)
    .addBody([
      kExprBlock, kWasmVoid,
        kExprBlock, kExternRefCode,
          kExprTryTable, kWasmVoid, 1,
            kCatchNoRef, tagIndexExternref, 0,
            kExprCallFunction, fnIndex,
          kExprEnd,
          kExprBr, 1,
        kExprEnd,
        kExprReturn,
      kExprEnd,
      kExprRefNull, kExternRefCode,
    ])
    .exportFunc();

  const buffer = builder.toBuffer();

  const error = new Error();
  const fn = () => { throw error };
  const {instance} = await WebAssembly.instantiate(buffer, {
    module: { fn }
  });
  assert_throws_exactly(error, () => instance.exports.catch_exception());
}, "Imported JS function throws");

promise_test(async () => {
  const builder = new WasmModuleBuilder();
  const fnIndex = builder.addImport("module", "fn", kSig_v_v);
  builder.addFunction("catch_and_rethrow", kSig_r_v)
    .addBody([
      kExprBlock, kWasmVoid,
        kExprBlock, kExnRefCode,
          kExprTryTable, kWasmVoid, 1,
            kCatchAllRef, 0,
            kExprCallFunction, fnIndex,
          kExprEnd,
          kExprBr, 1,
        kExprEnd,
        kExprThrowRef,
      kExprEnd,
      kExprRefNull, kExternRefCode,
    ])
    .exportFunc();

  const buffer = builder.toBuffer();

  const error = new Error();
  const fn = () => { throw error };
  const {instance} = await WebAssembly.instantiate(buffer, {
    module: { fn }
  });
  assert_throws_exactly(error, () => instance.exports.catch_and_rethrow());
}, "Imported JS function throws, Wasm catches and rethrows");

promise_test(async () => {
  const builder = new WasmModuleBuilder();
  const fnIndex = builder.addImport("module", "fn", kSig_v_v);
  const tagI32 = new WebAssembly.Tag({ parameters: ["i32"] });
  const tagIndexI32 = builder.addImportedTag("module", "tagI32", kSig_v_i);
  const exn = new WebAssembly.Exception(tagI32, [42]);
  const kSig_ie_v = makeSig([], [kWasmI32, kExnRefCode]);
  const sig_ie_v = builder.addType(kSig_ie_v);

  builder.addFunction("all_catch_clauses", kSig_i_v)
    .addBody([
      kExprBlock, kWasmVoid,
        kExprBlock, kExnRefCode,
          kExprBlock, sig_ie_v,
            kExprBlock, kWasmVoid,
              kExprBlock, kWasmI32,
                kExprTryTable, kWasmVoid, 4,
                  kCatchNoRef, tagIndexI32, 0,
                  kCatchAllNoRef, 1,
                  kCatchRef, tagIndexI32, 2,
                  kCatchAllRef, 3,
                  kExprCallFunction, fnIndex,
                kExprEnd,
                kExprBr, 4,
              kExprEnd,
              kExprReturn,
            kExprEnd,
            kExprBr, 2,
          kExprEnd,
          kExprDrop,
          kExprDrop,
          kExprBr, 1,
        kExprEnd,
        kExprDrop,
      kExprEnd,
      kExprI32Const, 0,
    ])
    .exportFunc();

  const buffer = builder.toBuffer();

  const fn = () => {
    throw exn;
  };
  const {instance} = await WebAssembly.instantiate(buffer, {
    module: { fn, tagI32: tagI32 }
  });
  const result = instance.exports.all_catch_clauses();
  assert_equals(result, 42);
}, "try-table uses all four kinds of catch clauses, one of which catches an exception");
