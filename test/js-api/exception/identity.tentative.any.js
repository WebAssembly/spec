// META: global=window,dedicatedworker,jsshell,shadowrealm
// META: script=/wasm/jsapi/assertions.js
// META: script=/wasm/jsapi/wasm-module-builder.js

test(() => {
  const builder = new WasmModuleBuilder();

  // Tag defined in JavaScript and imported into Wasm
  const jsTag = new WebAssembly.Tag({ parameters: ["i32"] });
  const jsTagIndex = builder.addImportedTag("module", "jsTag", kSig_v_i);
  const jsTagExn = new WebAssembly.Exception(jsTag, [42]);
  const jsTagExnSamePayload = new WebAssembly.Exception(jsTag, [42]);
  const jsTagExnDiffPayload = new WebAssembly.Exception(jsTag, [53]);
  const throwJSTagExnIndex = builder.addImport("module", "throwJSTagExn", kSig_v_v);

  // Tag defined in Wasm and exported to JS
  const wasmTagIndex = builder.addTag(kSig_v_i);
  builder.addExportOfKind("wasmTag", kExternalTag, wasmTagIndex);
  const throwWasmTagExnIndex = builder.addImport("module", "throwWasmTagExn", kSig_v_v);
  // Will be assigned after an instance is created
  let wasmTagExn = null;
  let wasmTagExnSamePayload = null;
  let wasmTagExnDiffPayload = null;

  const kSig_ie_v = makeSig([], [kWasmI32, kExnRefCode]);
  const sig_ie_v = builder.addType(kSig_ie_v);

  const imports = {
    module: {
      throwJSTagExn: function() { throw jsTagExn; },
      throwWasmTagExn: function() { throw wasmTagExn; },
      jsTag: jsTag
    }
  };

  // Call a JS function that throws an exception using a JS-defined tag, catches
  // it with a 'catch_ref' instruction, and rethrows it.
  builder
    .addFunction("catch_ref_js_tag_throw_ref", kSig_v_v)
    .addBody([
      kExprBlock, kWasmVoid,
        kExprBlock, sig_ie_v,
          kExprTryTable, kWasmVoid, 1,
            kCatchRef, jsTagIndex, 0,
            kExprCallFunction, throwJSTagExnIndex,
          kExprEnd,
          kExprBr, 1,
        kExprEnd,
        kExprThrowRef,
      kExprEnd
    ])
    .exportFunc();

  // Call a JS function that throws an exception using a Wasm-defined tag,
  // catches it with a 'catch_ref' instruction, and rethrows it.
  builder
    .addFunction("catch_ref_wasm_tag_throw_ref", kSig_v_v)
    .addBody([
      kExprBlock, kWasmVoid,
        kExprBlock, sig_ie_v,
          kExprTryTable, kWasmVoid, 1,
            kCatchRef, wasmTagIndex, 0,
            kExprCallFunction, throwWasmTagExnIndex,
          kExprEnd,
          kExprBr, 1,
        kExprEnd,
        kExprThrowRef,
      kExprEnd
    ])
    .exportFunc();

  // Call a JS function that throws an exception using a JS-defined tag, catches
  // it with a 'catch_all_ref' instruction, and rethrows it.
  builder
    .addFunction("catch_all_ref_js_tag_throw_ref", kSig_v_v)
    .addBody([
      kExprBlock, kWasmVoid,
        kExprBlock, kExnRefCode,
          kExprTryTable, kWasmVoid, 1,
            kCatchAllRef, 0,
            kExprCallFunction, throwJSTagExnIndex,
          kExprEnd,
          kExprBr, 1,
        kExprEnd,
        kExprThrowRef,
      kExprEnd
    ])
    .exportFunc();

  // Call a JS function that throws an exception using a Wasm-defined tag,
  // catches it with a 'catch_all_ref' instruction, and rethrows it.
  builder
    .addFunction("catch_all_ref_wasm_tag_throw_ref", kSig_v_v)
    .addBody([
      kExprBlock, kWasmVoid,
        kExprBlock, kExnRefCode,
          kExprTryTable, kWasmVoid, 1,
            kCatchAllRef, 0,
            kExprCallFunction, throwWasmTagExnIndex,
          kExprEnd,
          kExprBr, 1,
        kExprEnd,
        kExprThrowRef,
      kExprEnd
    ])
    .exportFunc();

  // Call a JS function that throws an exception, catches it with a 'catch'
  // instruction, and returns its i32 payload.
  builder
    .addFunction("catch_js_tag_return_payload", kSig_i_v)
    .addBody([
      kExprBlock, kWasmVoid,
        kExprBlock, kWasmI32,
          kExprTryTable, kWasmVoid, 1,
            kCatchNoRef, jsTagIndex, 0,
            kExprCallFunction, throwJSTagExnIndex,
          kExprEnd,
          kExprBr, 1,
        kExprEnd,
        kExprReturn,
      kExprEnd,
      kExprI32Const, 0
    ])
    .exportFunc();

  // Call a JS function that throws an exception, catches it with a 'catch'
  // instruction, and throws a new exception using that payload.
  builder
    .addFunction("catch_js_tag_throw_payload", kSig_v_v)
    .addBody([
      kExprBlock, kWasmVoid,
        kExprBlock, kWasmI32,
          kExprTryTable, kWasmVoid, 1,
            kCatchNoRef, jsTagIndex, 0,
            kExprCallFunction, throwJSTagExnIndex,
          kExprEnd,
          kExprBr, 1,
        kExprEnd,
        kExprThrow, jsTagIndex,
      kExprEnd
    ])
    .exportFunc();

  const buffer = builder.toBuffer();

  WebAssembly.instantiate(buffer, imports).then(result => {
    // The exception object's identity should be preserved across 'rethrow's in
    // Wasm code. Do tests with a tag defined in JS.
    try {
      result.instance.exports.catch_ref_js_tag_throw_ref();
    } catch (e) {
      assert_equals(e, jsTagExn);
      // Even if they have the same payload, they are different objects, so they
      // shouldn't compare equal.
      assert_not_equals(e, jsTagExnSamePayload);
      assert_not_equals(e, jsTagExnDiffPayload);
    }
    try {
      result.instance.exports.catch_all_ref_js_tag_throw_ref();
    } catch (e) {
      assert_equals(e, jsTagExn);
      assert_not_equals(e, jsTagExnSamePayload);
      assert_not_equals(e, jsTagExnDiffPayload);
    }

    // Do the same tests with a tag defined in Wasm.
    const wasmTag = result.instance.exports.wasmTag;
    wasmTagExn = new WebAssembly.Exception(wasmTag, [42]);
    wasmTagExnSamePayload = new WebAssembly.Exception(wasmTag, [42]);
    wasmTagExnDiffPayload = new WebAssembly.Exception(wasmTag, [53]);
    try {
      result.instance.exports.catch_ref_wasm_tag_throw_ref();
    } catch (e) {
      assert_equals(e, wasmTagExn);
      assert_not_equals(e, wasmTagExnSamePayload);
      assert_not_equals(e, wasmTagExnDiffPayload);
    }
    try {
      result.instance.exports.catch_all_ref_wasm_tag_throw_ref();
    } catch (e) {
      assert_equals(e, wasmTagExn);
      assert_not_equals(e, wasmTagExnSamePayload);
      assert_not_equals(e, wasmTagExnDiffPayload);
    }

    // This function catches the exception and returns its i32 payload, which
    // should match the original payload.
    assert_equals(result.instance.exports.catch_js_tag_return_payload(), 42);

    // This function catches the exception and throws a new exception using the
    // its payload. Even if the payload is reused, the exception objects should
    // not compare equal.
    try {
      result.instance.exports.catch_js_tag_throw_payload();
    } catch (e) {
      assert_equals(e.getArg(jsTag, 0), 42);
      assert_not_equals(e, jsTagExn);
    }
  });
}, "Identity check");
