// META: global=window,dedicatedworker,jsshell
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

  const imports = {
    module: {
      throwJSTagExn: function() { throw jsTagExn; },
      throwWasmTagExn: function() { throw wasmTagExn; },
      jsTag: jsTag
    }
  };

  // Call a JS function that throws an exception using a JS-defined tag, catches
  // it with a 'catch' instruction, and rethrows it.
  builder
    .addFunction("catch_js_tag_rethrow", kSig_v_v)
    .addBody([
      kExprTry, kWasmStmt,
        kExprCallFunction, throwJSTagExnIndex,
      kExprCatch, jsTagIndex,
        kExprDrop,
        kExprRethrow, 0x00,
      kExprEnd
    ])
    .exportFunc();

  // Call a JS function that throws an exception using a Wasm-defined tag,
  // catches it with a 'catch' instruction, and rethrows it.
  builder
    .addFunction("catch_wasm_tag_rethrow", kSig_v_v)
    .addBody([
      kExprTry, kWasmStmt,
        kExprCallFunction, throwWasmTagExnIndex,
      kExprCatch, wasmTagIndex,
        kExprDrop,
        kExprRethrow, 0x00,
      kExprEnd
    ])
    .exportFunc();

  // Call a JS function that throws an exception using a JS-defined tag, catches
  // it with a 'catch_all' instruction, and rethrows it.
  builder
    .addFunction("catch_all_js_tag_rethrow", kSig_v_v)
    .addBody([
      kExprTry, kWasmStmt,
        kExprCallFunction, throwJSTagExnIndex,
      kExprCatchAll,
        kExprRethrow, 0x00,
      kExprEnd
    ])
    .exportFunc();

  // Call a JS function that throws an exception using a Wasm-defined tag,
  // catches it with a 'catch_all' instruction, and rethrows it.
  builder
    .addFunction("catch_all_wasm_tag_rethrow", kSig_v_v)
    .addBody([
      kExprTry, kWasmStmt,
        kExprCallFunction, throwWasmTagExnIndex,
      kExprCatchAll,
        kExprRethrow, 0x00,
      kExprEnd
    ])
    .exportFunc();

  // Call a JS function that throws an exception, catches it with a 'catch'
  // instruction, and returns its i32 payload.
  builder
    .addFunction("catch_js_tag_return_payload", kSig_i_v)
    .addBody([
      kExprTry, kWasmI32,
        kExprCallFunction, throwJSTagExnIndex,
        kExprI32Const, 0x00,
      kExprCatch, jsTagIndex,
        kExprReturn,
      kExprEnd
    ])
    .exportFunc();

  // Call a JS function that throws an exception, catches it with a 'catch'
  // instruction, and throws a new exception using that payload.
  builder
    .addFunction("catch_js_tag_throw_payload", kSig_v_v)
    .addBody([
      kExprTry, kWasmStmt,
        kExprCallFunction, throwJSTagExnIndex,
      kExprCatch, jsTagIndex,
        kExprThrow, jsTagIndex,
      kExprEnd
    ])
    .exportFunc();

  const buffer = builder.toBuffer();

  WebAssembly.instantiate(buffer, imports).then(result => {
    // The exception object's identity should be preserved across 'rethrow's in
    // Wasm code. Do tests with a tag defined in JS.
    try {
      result.instance.exports.catch_js_tag_rethrow();
    } catch (e) {
      assert_equals(e, jsTagExn);
      // Even if they have the same payload, they are different objects, so they
      // shouldn't compare equal.
      assert_not_equals(e, jsTagExnSamePayload);
      assert_not_equals(e, jsTagExnDiffPayload);
    }
    try {
      result.instance.exports.catch_all_js_tag_rethrow();
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
      result.instance.exports.catch_wasm_tag_rethrow();
    } catch (e) {
      assert_equals(e, wasmTagExn);
      assert_not_equals(e, wasmTagExnSamePayload);
      assert_not_equals(e, wasmTagExnDiffPayload);
    }
    try {
      result.instance.exports.catch_all_wasm_tag_rethrow();
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
