// META: global=window,dedicatedworker,jsshell,shadowrealm
// META: script=/wasm/jsapi/assertions.js
// META: script=/wasm/jsapi/wasm-module-builder.js

test(() => {
  assert_throws_js(TypeError, () => new WebAssembly.Exception(WebAssembly.JSTag, [{}]))
}, "Creating a WebAssembly.Exception with JSTag explicitly is not allowed");

promise_test(async () => {
  const builder = new WasmModuleBuilder();
  const jsTag = builder.addImportedTag("module", "JSTag", kSig_v_r);

  const throwRefFn = builder.addImport("module", "throw_ref", kSig_r_r);
  const sig_r_v = builder.addType(kSig_r_v);
  const kSig_re_v = makeSig([], [kExternRefCode, kExnRefCode]);
  const sig_re_v = builder.addType(kSig_re_v);

  // Calls throw_ref, catches an exception with 'try_table - catch JSTag', and
  // returns it
  builder.addFunction("catch_js_tag_and_return", kSig_r_r)
    .addBody([
      kExprBlock, sig_r_v,
        kExprTryTable, sig_r_v, 1,
          kCatchNoRef, jsTag, 0,
          kExprLocalGet, 0,
          kExprCallFunction, throwRefFn,
        kExprEnd,
      kExprEnd,
    ])
    .exportFunc();

  // Calls throw_ref, catches an exception with 'try_table - catch_ref JSTag',
  // and returns it
  builder.addFunction("catch_ref_js_tag_and_return", kSig_r_r)
    .addBody([
      kExprBlock, sig_re_v,
        kExprTryTable, sig_r_v, 1,
          kCatchRef, jsTag, 0,
          kExprLocalGet, 0,
          kExprCallFunction, throwRefFn,
        kExprEnd,
        kExprReturn,
      kExprEnd,
      kExprDrop,
    ])
    .exportFunc();

  // Calls throw_ref, catches an exception with 'try_table - catch_ref JSTag',
  // and rethrows it (with throw_ref)
  builder.addFunction("catch_ref_js_tag_and_throw_ref", kSig_r_r)
    .addBody([
      kExprBlock, sig_re_v,
        kExprTryTable, sig_r_v, 1,
          kCatchRef, jsTag, 0,
          kExprLocalGet, 0,
          kExprCallFunction, throwRefFn,
        kExprEnd,
        kExprReturn,
      kExprEnd,
      kExprThrowRef,
    ])
    .exportFunc();

  function throw_ref(x) {
    throw x;
  }
  const buffer = builder.toBuffer();
  const {instance} = await WebAssembly.instantiate(buffer, {
    module: { throw_ref, JSTag: WebAssembly.JSTag }
  });

  const obj = {};
  const wasmTag = new WebAssembly.Tag({parameters:['externref']});
  const exn = new WebAssembly.Exception(wasmTag, [obj]);

  // Test catch w/ return:
  // This throws obj as a JS exception so it should be caught by the program and
  // be returned as the original obj.
  assert_equals(obj, instance.exports.catch_js_tag_and_return(obj));
  // This is a WebAssembly.Exception, so the exception should just pass through
  // the program without being caught.
  assert_throws_exactly(exn, () => instance.exports.catch_js_tag_and_return(exn));

  // Test catch_ref w/ return:
  // This throws obj as a JS exception so it should be caught by the program and
  // be returned as the original obj.
  assert_equals(obj, instance.exports.catch_ref_js_tag_and_return(obj));
  // This is a WebAssembly.Exception, so the exception should just pass through
  // the program without being caught.
  assert_throws_exactly(exn, () => instance.exports.catch_ref_js_tag_and_return(exn));

  // Test catch_ref w/ throw_ref:
  // This throws obj as a JS exception so it should be caught by the program and
  // be rethrown.
  assert_throws_exactly(obj, () => instance.exports.catch_ref_js_tag_and_throw_ref(obj));
  // This is a WebAssembly.Exception, so the exception should just pass through
  // the program without being caught.
  assert_throws_exactly(exn, () => instance.exports.catch_ref_js_tag_and_throw_ref(exn));
}, "JS tag catching tests");

promise_test(async () => {
  const builder = new WasmModuleBuilder();
  const jsTag = builder.addImportedTag("module", "JSTag", kSig_v_r);

  // Throw a JS object with WebAssembly.JSTag and check that we can catch it
  // as-is from JavaScript.
  builder.addFunction("throw_js_tag", kSig_v_r)
    .addBody([
      kExprLocalGet, 0,
      kExprThrow, jsTag,
    ])
    .exportFunc();

  const buffer = builder.toBuffer();
  const {instance} = await WebAssembly.instantiate(buffer, {
    module: { JSTag: WebAssembly.JSTag }
  });

  const obj = {};
  assert_throws_exactly(obj, () => instance.exports.throw_js_tag(obj));
}, "JS tag throwing test");
