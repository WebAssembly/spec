// META: global=jsshell
// META: script=/wasm/jsapi/wasm-module-builder.js

// Test for invalid wrappers
test(() => {
  assert_throws(TypeError, () => WebAssembly.promising({}),
      /Argument 0 must be a function/);
  assert_throws(TypeError, () => WebAssembly.promising(() => {}),
      /Argument 0 must be a WebAssembly exported function/);
  assert_throws(TypeError, () => WebAssembly.Suspending(() => {}),
      /WebAssembly.Suspending must be invoked with 'new'/);
  assert_throws(TypeError, () => new WebAssembly.Suspending({}),
      /Argument 0 must be a function/);
  function asmModule() {
    "use asm";
    function x(v) {
      v = v | 0;
    }
    return x;
  }
  assert_throws(TypeError, () => WebAssembly.promising(asmModule()),
      /Argument 0 must be a WebAssembly exported function/);
});

test(() => {
  let builder = new WasmModuleBuilder();
  builder.addGlobal(kWasmI32, true).exportAs('g');
  builder.addFunction("test", kSig_i_v)
      .addBody([
          kExprI32Const, 42,
          kExprGlobalSet, 0,
          kExprI32Const, 0]).exportFunc();
  let instance = builder.instantiate();
  let wrapper = WebAssembly.promising(instance.exports.test);
  wrapper();
  assert_equals(42, instance.exports.g.value);
});

promise_test(async () => {
  let builder = new WasmModuleBuilder();
  import_index = builder.addImport('m', 'import', kSig_i_i);
  builder.addFunction("test", kSig_i_i)
      .addBody([
          kExprLocalGet, 0,
          kExprCallFunction, import_index, // suspend
      ]).exportFunc();
  let js_import = WebAssembly.Suspending(() => Promise.resolve(42));
  let instance = builder.instantiate({m: {import: js_import}});
  let wrapped_export = WebAssembly.promising(instance.exports.test);
  let export_promise = wrapped_export();
  assert_true(export_promise instanceof Promise);
  assert_equals(await export_promise, 42);
}, "Suspend once");

promise_test(async () => {
  let builder = new WasmModuleBuilder();
  builder.addGlobal(kWasmI32, true).exportAs('g');
  import_index = builder.addImport('m', 'import', kSig_i_i);
  // void test() {
  //   for (i = 0; i < 5; ++i) {
  //     g = g + await import();
  //   }
  // }
  builder.addFunction("test", kSig_v_i)
      .addLocals({ i32_count: 1})
      .addBody([
          kExprI32Const, 5,
          kExprLocalSet, 1,
          kExprLoop, kWasmVoid,
            kExprLocalGet, 0,
            kExprCallFunction, import_index, // suspend
            kExprGlobalGet, 0,
            kExprI32Add,
            kExprGlobalSet, 0,
            kExprLocalGet, 1,
            kExprI32Const, 1,
            kExprI32Sub,
            kExprLocalTee, 1,
            kExprBrIf, 0,
          kExprEnd,
      ]).exportFunc();
  let i = 0;
  function js_import() {
    return Promise.resolve(++i);
  };
  let wasm_js_import = WebAssembly.Suspending(js_import);
  let instance = builder.instantiate({m: {import: wasm_js_import}});
  let wrapped_export = WebAssembly.promising(instance.exports.test);
  let export_promise = wrapped_export();
  assert_equals(instance.exports.g.value, 0);
  assert_true(export_promise instanceof Promise);
  await export_promise;
  assert_equals(instance.exports.g.value, 15);
}, "Suspend/resume in a loop");

promise_test(async ()=>{
  let builder = new WasmModuleBuilder();
  import_index = builder.addImport('m', 'import', kSig_i_v);
  builder.addFunction("test", kSig_i_v)
    .addBody([
        kExprCallFunction, import_index, // suspend
    ]).exportFunc();
  let js_import = new WebAssembly.Suspending(() => Promise.resolve(42));
  let instance = builder.instantiate({m: {import: js_import}});
  let wrapped_export = WebAssembly.promising(instance.exports.test);
  assert_equals(await wrapped_export(), 42);

  // Also try with a JS function with a mismatching arity.
  js_import = new WebAssembly.Suspending((unused) => Promise.resolve(42));
  instance = builder.instantiate({m: {import: js_import}});
  wrapped_export = WebAssembly.promising(instance.exports.test);
  assert_equals(await wrapped_export(), 42);

  // Also try with a proxy.
  js_import = new WebAssembly.Suspending(new Proxy(() => Promise.resolve(42), {}));
  instance = builder.instantiate({m: {import: js_import}});
  wrapped_export = WebAssembly.promising(instance.exports.test);
  assert_equals(await wrapped_export(), 42);
});

function recordAbeforeB(){
  let AbeforeB = [];
  let setA = ()=>{
    AbeforeB.push("A")
  }
  let setB = ()=>{
    AbeforeB.push("B")
  }
  let isAbeforeB = ()=>
    AbeforeB[0]=="A" && AbeforeB[1]=="B";

  let showAbeforeB = ()=>{
    console.log(AbeforeB)
  }
  return {setA : setA, setB : setB, isAbeforeB :isAbeforeB,showAbeforeB:showAbeforeB}
}

promise_test(async () => {
  let builder = new WasmModuleBuilder();
  let AbeforeB = recordAbeforeB();
  import42_index = builder.addImport('m', 'import42', kSig_i_i);
  importSetA_index = builder.addImport('m', 'setA', kSig_v_v);
  builder.addFunction("test", kSig_i_i)
      .addBody([
          kExprLocalGet, 0,
          kExprCallFunction, import42_index, // suspend?
          kExprCallFunction, importSetA_index
      ]).exportFunc();
  let import42 = WebAssembly.Suspending(()=>Promise.resolve(42));
  let instance = builder.instantiate({m: {import42: import42,
    setA:AbeforeB.setA}});

  let wrapped_export = WebAssembly.promising(instance.exports.test);

//  AbeforeB.showAbeforeB();
  let exported_promise = wrapped_export();
//  AbeforeB.showAbeforeB();

  AbeforeB.setB();

  assert_equals(await exported_promise, 42);
//  AbeforeB.showAbeforeB();

  assert_false(AbeforeB.isAbeforeB());
}, "Make sure we actually suspend");

promise_test(async () => {
  let builder = new WasmModuleBuilder();
  let AbeforeB = recordAbeforeB();
  import42_index = builder.addImport('m', 'import42', kSig_i_i);
  importSetA_index = builder.addImport('m', 'setA', kSig_v_v);
  builder.addFunction("test", kSig_i_i)
      .addBody([
          kExprLocalGet, 0,
          kExprCallFunction, import42_index, // suspend?
          kExprCallFunction, importSetA_index
      ]).exportFunc();
  let import42 = WebAssembly.Suspending(()=>42);
  let instance = builder.instantiate({m: {import42: import42,
    setA:AbeforeB.setA}});

  let wrapped_export = WebAssembly.promising(instance.exports.test);

  let exported_promise = wrapped_export();
  AbeforeB.setB();

  assert_equals(await exported_promise, 42);
  // AbeforeB.showAbeforeB();

  assert_true(AbeforeB.isAbeforeB());
}, "Do not suspend if the import's return value is not a Promise");

test(t => {
  console.log("Throw after the first suspension");
  let tag = new WebAssembly.Tag({parameters: []});
  let builder = new WasmModuleBuilder();
  import_index = builder.addImport('m', 'import', kSig_i_i);
  tag_index = builder.addImportedTag('m', 'tag', kSig_v_v);
  builder.addFunction("test", kSig_i_i)
      .addBody([
          kExprLocalGet, 0,
          kExprCallFunction, import_index,
          kExprThrow, tag_index
      ]).exportFunc();
  function js_import() {
    return Promise.resolve();
  };
  let wasm_js_import = WebAssembly.Suspending(js_import);

  let instance = builder.instantiate({m: {import: wasm_js_import, tag: tag}});
  let wrapped_export = WebAssembly.promising(instance.exports.test);
  let export_promise = wrapped_export();
  assert_true(export_promise instanceof Promise);
  promise_rejects(t, new WebAssembly.Exception(tag, []), export_promise);
}, "Throw after the first suspension");

promise_test(async (t) => {
  console.log("Rejecting promise");
  let tag = new WebAssembly.Tag({parameters: ['i32']});
  let builder = new WasmModuleBuilder();
  import_index = builder.addImport('m', 'import', kSig_i_i);
  tag_index = builder.addImportedTag('m', 'tag', kSig_v_i);
  builder.addFunction("test", kSig_i_i)
      .addBody([
          kExprTry, kWasmI32,
          kExprLocalGet, 0,
          kExprCallFunction, import_index,
          kExprCatch, tag_index,
          kExprEnd
      ]).exportFunc();
  function js_import() {
    return Promise.reject(new WebAssembly.Exception(tag, [42]));
  };
  let wasm_js_import = WebAssembly.Suspending(js_import);

  let instance = builder.instantiate({m: {import: wasm_js_import, tag: tag}});
  let wrapped_export = WebAssembly.promising(instance.exports.test);
  let export_promise = wrapped_export();
  assert_true(export_promise instanceof Promise);
  assert_equals(await export_promise, 42);
}, "Rejecting promise");

async function TestNestedSuspenders(suspend) {
  console.log("nested suspending "+suspend);
  // Nest two suspenders. The call chain looks like:
  // outer (wasm) -> outer (js) -> inner (wasm) -> inner (js)
  // If 'suspend' is true, the inner JS function returns a Promise, which
  // suspends the inner wasm function, which returns a Promise, which suspends
  // the outer wasm function, which returns a Promise. The inner Promise
  // resolves first, which resumes the inner continuation. Then the outer
  // promise resolves which resumes the outer continuation.
  // If 'suspend' is false, the inner JS function returns a regular value and
  // no computation is suspended.
  let builder = new WasmModuleBuilder();
  inner_index = builder.addImport('m', 'inner', kSig_i_i);
  outer_index = builder.addImport('m', 'outer', kSig_i_i);
  builder.addFunction("outer", kSig_i_i)
      .addBody([
          kExprLocalGet, 0,
          kExprCallFunction, outer_index
      ]).exportFunc();
  builder.addFunction("inner", kSig_i_i)
      .addBody([
          kExprLocalGet, 0,
          kExprCallFunction, inner_index
      ]).exportFunc();

  let inner = WebAssembly.Suspending(() => suspend ? Promise.resolve(42) : 43);

  let export_inner;
  let outer = WebAssembly.Suspending(() => export_inner());

  let instance = builder.instantiate({m: {inner, outer}});
  export_inner = WebAssembly.promising(instance.exports.inner);
  let export_outer = WebAssembly.promising(instance.exports.outer);
  let result = export_outer();
  assert_true(result instanceof Promise);
  if(suspend)
    assert_equals(await result, 42);
  else
    assert_equals(await result, 43);
}

promise_test(async () => {
  TestNestedSuspenders(true);
}, "Test nested suspenders with suspension");

promise_test(async () => {
  TestNestedSuspenders(false);
}, "Test nested suspenders with no suspension");

test(() => {
  console.log("Call import with an invalid suspender");
  let builder = new WasmModuleBuilder();
  let import_index = builder.addImport('m', 'import', kSig_i_i);
  builder.addFunction("test", kSig_i_i)
      .addBody([
          kExprLocalGet, 0,
          kExprCallFunction, import_index, // suspend
      ]).exportFunc();
  builder.addFunction("return_suspender", kSig_i_i)
      .addBody([
          kExprLocalGet, 0
      ]).exportFunc();
  let js_import = WebAssembly.Suspending(() => Promise.resolve(42));
  let instance = builder.instantiate({m: {import: js_import}});
  let suspender = WebAssembly.promising(instance.exports.return_suspender)();
  for (s of [suspender, null, undefined, {}]) {
    assert_throws(WebAssembly.SuspendError, () => instance.exports.test(s));
  }
}, "Call import with an invalid suspender");

// Throw an exception before suspending. The export wrapper should return a
// promise rejected with the exception.
promise_test(async (t) => {
  let tag = new WebAssembly.Tag({parameters: []});
  let builder = new WasmModuleBuilder();
  tag_index = builder.addImportedTag('m', 'tag', kSig_v_v);
  builder.addFunction("test", kSig_i_v)
      .addBody([
          kExprThrow, tag_index
      ]).exportFunc();

  let instance = builder.instantiate({m: {tag: tag}});
  let wrapped_export = WebAssembly.promising(instance.exports.test);
  let export_promise = wrapped_export();

  promise_rejects(t, new WebAssembly.Exception(tag, []), export_promise);
});

// Throw an exception after the first resume event, which propagates to the
// promise wrapper.
promise_test(async (t) => {
  let tag = new WebAssembly.Tag({parameters: []});
  let builder = new WasmModuleBuilder();
  import_index = builder.addImport('m', 'import', kSig_i_v);
  tag_index = builder.addImportedTag('m', 'tag', kSig_v_v);
  builder.addFunction("test", kSig_i_v)
      .addBody([
          kExprCallFunction, import_index,
          kExprThrow, tag_index
      ]).exportFunc();
  function js_import() {
    return Promise.resolve(42);
  };
  let wasm_js_import = new WebAssembly.Suspending(js_import);

  let instance = builder.instantiate({m: {import: wasm_js_import, tag: tag}});
  let wrapped_export = WebAssembly.promising(instance.exports.test);
  let export_promise = wrapped_export();

  promise_rejects(t, new WebAssembly.Exception(tag, []), export_promise);
});

promise_test(async () => {
  let tag = new WebAssembly.Tag({parameters: ['i32']});
  let builder = new WasmModuleBuilder();
  import_index = builder.addImport('m', 'import', kSig_i_v);
  tag_index = builder.addImportedTag('m', 'tag', kSig_v_i);
  builder.addFunction("test", kSig_i_v)
      .addBody([
          kExprTry, kWasmI32,
          kExprCallFunction, import_index,
          kExprCatch, tag_index,
          kExprEnd,
      ]).exportFunc();
  function js_import() {
    return Promise.reject(new WebAssembly.Exception(tag, [42]));
  };
  let wasm_js_import = new WebAssembly.Suspending(js_import);

  let instance = builder.instantiate({m: {import: wasm_js_import, tag: tag}});
  let wrapped_export = WebAssembly.promising(instance.exports.test);
  assert_equals(await wrapped_export(), 42);
});

test(() => {
  console.log("no return allowed");
  // Check that a promising function with no return is allowed.
  let builder = new WasmModuleBuilder();
  builder.addFunction("export", kSig_v_v).addBody([]).exportFunc();
  let instance = builder.instantiate();
  let export_wrapper = WebAssembly.promising(instance.exports.export);
  assert_true(export_wrapper instanceof Function);
});

promise_test(async (t) => {
  let builder = new WasmModuleBuilder();
  builder.addFunction("test", kSig_i_v)
      .addBody([
          kExprCallFunction, 0
          ]).exportFunc();
  let instance = builder.instantiate();
  let wrapper = WebAssembly.promising(instance.exports.test);

  promise_rejects(t, new Error(), wrapper(), /Maximum call stack size exceeded/);
});

promise_test(async (t) => {
  // The call stack of this test looks like:
  // export1 -> import1 -> export2 -> import2
  // Where export1 is "promising" and import2 is "suspending". Returning a
  // promise from import2 should trap because of the JS import in the middle.
  let builder = new WasmModuleBuilder();
  let import1_index = builder.addImport("m", "import1", kSig_i_v);
  let import2_index = builder.addImport("m", "import2", kSig_i_v);
  builder.addFunction("export1", kSig_i_v)
      .addBody([
          // export1 -> import1 (unwrapped)
          kExprCallFunction, import1_index,
      ]).exportFunc();
  builder.addFunction("export2", kSig_i_v)
      .addBody([
          // export2 -> import2 (suspending)
          kExprCallFunction, import2_index,
      ]).exportFunc();
  let instance;
  function import1() {
    // import1 -> export2 (unwrapped)
    instance.exports.export2();
  }
  function import2() {
    return Promise.resolve(0);
  }
  import2 = new WebAssembly.Suspending(import2);
  instance = builder.instantiate(
      {'m':
        {'import1': import1,
         'import2': import2
        }});
  // export1 (promising)
  let wrapper = WebAssembly.promising(instance.exports.export1);
  promise_rejects(t, new WebAssembly.SuspendError(), wrapper());
});

promise_test(async () => {
  let builder1 = new WasmModuleBuilder();
  import_index = builder1.addImport('m', 'import', kSig_i_v);
  builder1.addFunction("f", kSig_i_v)
      .addBody([
          kExprCallFunction, import_index, // suspend
          kExprI32Const, 1,
          kExprI32Add,
      ]).exportFunc();
  let js_import = new WebAssembly.Suspending(() => Promise.resolve(1));
  let instance1 = builder1.instantiate({m: {import: js_import}});
  let builder2 = new WasmModuleBuilder();
  import_index = builder2.addImport('m', 'import', kSig_i_v);
  builder2.addFunction("main", kSig_i_v)
      .addBody([
          kExprCallFunction, import_index,
          kExprI32Const, 1,
          kExprI32Add,
      ]).exportFunc();
  let instance2 = builder2.instantiate({m: {import: instance1.exports.f}});
  let wrapped_export = WebAssembly.promising(instance2.exports.main);
  assert_equals(await wrapped_export(), 3);
});

test(() => {
  let builder = new WasmModuleBuilder();
  let js_tag = builder.addImportedTag("", "tag", kSig_v_r);
  try_sig_index = builder.addType(kSig_i_v);

  let promise42 = new WebAssembly.Suspending(() => Promise.resolve(42));
  let kPromise42Ref = builder.addImport("", "promise42", kSig_i_v);

  builder.addFunction("test", kSig_i_v)
    .addBody([
      kExprTry, try_sig_index,
        kExprCallFunction, kPromise42Ref,
        kExprReturn,  // If there was no trap or exception, return
      kExprCatch, js_tag,
        kExprI32Const, 43,
        kExprReturn,
      kExprEnd,
    ])
    .exportFunc();

  let instance = builder.instantiate({"": {
      promise42: promise42,
      tag: WebAssembly.JSTag,
  }});

  assert_equals(43, instance.exports.test());
},"catch the bad suspension");
