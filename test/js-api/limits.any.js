// META: global=jsshell
// META: script=/wasm/jsapi/wasm-module-builder.js
// META: timeout=long

// Static limits
const kJSEmbeddingMaxTypes = 1000000;
const kJSEmbeddingMaxFunctions = 1000000;
const kJSEmbeddingMaxImports = 100000;
const kJSEmbeddingMaxExports = 100000;
const kJSEmbeddingMaxGlobals = 1000000;
const kJSEmbeddingMaxDataSegments = 100000;

const kJSEmbeddingMaxModuleSize = 1024 * 1024 * 1024; // = 1 GiB
const kJSEmbeddingMaxFunctionSize = 7654321;
const kJSEmbeddingMaxFunctionLocals = 50000;
const kJSEmbeddingMaxFunctionParams = 1000;
const kJSEmbeddingMaxFunctionReturns = 1000;
const kJSEmbeddingMaxElementSegments = 10000000;
const kJSEmbeddingMaxTables = 100000;
const kJSEmbeddingMaxMemories = 1;

// Dynamic limits
const kJSEmbeddingMaxTableSize = 10000000;

// This function runs the {gen} function with the values {min}, {limit}, and
// {limit+1}, assuming that values below and including the limit should
// pass. {name} is used for test names.
function testLimit(name, min, limit, gen) {
  function get_buffer(count) {
    const builder = new WasmModuleBuilder();
    gen(builder, count);
    return builder.toBuffer();
  }

  const buffer_with_min = get_buffer(min);
  const buffer_with_limit = get_buffer(limit);
  const buffer_with_limit_plus_1 = get_buffer(limit + 1);

  test(() => { assert_true(WebAssembly.validate(buffer_with_min)); },
       `Validate ${name} minimum`);
  test(() => { assert_true(WebAssembly.validate(buffer_with_limit)); },
       `Validate ${name} limit`);
  test(() => { assert_false(WebAssembly.validate(buffer_with_limit_plus_1)); },
       `Validate ${name} over limit`);

  test(() => { new WebAssembly.Module(buffer_with_min); },
       `Compile ${name} minimum`);
  test(() => { new WebAssembly.Module(buffer_with_limit); },
       `Compile ${name} limit`);
  test(() => {
    assert_throws(new WebAssembly.CompileError(),
                  () => new WebAssembly.Module(buffer_with_limit_plus_1));
  }, `Compile ${name} over limit`);

  promise_test(t => { return WebAssembly.compile(buffer_with_min); },
               `Async compile ${name} minimum`);
  promise_test(t => { return WebAssembly.compile(buffer_with_limit); },
               `Async compile ${name} limit`);
  promise_test(t => {
    return promise_rejects(t, new WebAssembly.CompileError(),
                           WebAssembly.compile(buffer_with_limit_plus_1));
  }, `Async compile ${name} over limit`);
}

testLimit("types", 1, kJSEmbeddingMaxTypes, (builder, count) => {
  for (let i = 0; i < count; i++) {
    builder.addType(kSig_i_i);
  }
});

testLimit("functions", 1, kJSEmbeddingMaxFunctions, (builder, count) => {
        const type = builder.addType(kSig_v_v);
        const body = [];
        for (let i = 0; i < count; i++) {
            builder.addFunction(/*name=*/ undefined, type).addBody(body);
        }
    });

testLimit("imports", 1, kJSEmbeddingMaxImports, (builder, count) => {
  const type = builder.addType(kSig_v_v);
  for (let i = 0; i < count; i++) {
    builder.addImport("", "", type);
  }
});

testLimit("exports", 1, kJSEmbeddingMaxExports, (builder, count) => {
  const type = builder.addType(kSig_v_v);
  const f = builder.addFunction(/*name=*/ undefined, type);
  f.addBody([]);
  for (let i = 0; i < count; i++) {
    builder.addExport("f" + i, f.index);
  }
});

testLimit("globals", 1, kJSEmbeddingMaxGlobals, (builder, count) => {
  for (let i = 0; i < count; i++) {
    builder.addGlobal(kWasmI32, true);
  }
});

testLimit("data segments", 1, kJSEmbeddingMaxDataSegments, (builder, count) => {
  const data = [];
  builder.addMemory(1, 1, false, false);
  for (let i = 0; i < count; i++) {
    builder.addDataSegment(0, data);
  }
});

testLimit("function size", 2, kJSEmbeddingMaxFunctionSize, (builder, count) => {
  const type = builder.addType(kSig_v_v);
  const nops = count - 2;
  const array = new Array(nops);
  for (let i = 0; i < nops; i++)
    array[i] = kExprNop;
  builder.addFunction(undefined, type).addBody(array);
});

testLimit("function locals", 1, kJSEmbeddingMaxFunctionLocals,
          (builder, count) => {
            const type = builder.addType(kSig_v_v);
            builder.addFunction(undefined, type)
                .addLocals({i32_count : count})
                .addBody([]);
          });

testLimit("function params", 1, kJSEmbeddingMaxFunctionParams,
          (builder, count) => {
            const array = new Array(count);
            for (let i = 0; i < count; i++) {
              array[i] = kWasmI32;
            }
            const type = builder.addType({params : array, results : []});
          });

testLimit("function params+locals", 1, kJSEmbeddingMaxFunctionLocals - 2,
          (builder, count) => {
            const type = builder.addType(kSig_i_ii);
            builder.addFunction(undefined, type)
                .addLocals({i32_count : count})
                .addBody([ kExprUnreachable ]);
          });

testLimit("function returns", 0, kJSEmbeddingMaxFunctionReturns,
          (builder, count) => {
            const array = new Array(count);
            for (let i = 0; i < count; i++) {
              array[i] = kWasmI32;
            }
            const type = builder.addType({params : [], results : array});
          });

testLimit("element segments", 1, kJSEmbeddingMaxElementSegments,
          (builder, count) => {
            builder.setTableBounds(1, 1);
            const array = [];
            for (let i = 0; i < count; i++) {
              builder.addElementSegment(0, false, false, array);
            }
          });

testLimit("tables", 0, kJSEmbeddingMaxTables, (builder, count) => {
  for (let i = 0; i < count; i++) {
    builder.addImportedTable("", "", 1, 1);
  }
});

testLimit("memories", 0, kJSEmbeddingMaxMemories, (builder, count) => {
  for (let i = 0; i < count; i++) {
    builder.addImportedMemory("", "", 1, 1, false);
  }
});

const instantiationShouldFail = 1;
const instantiationShouldSucceed = 2;
// This function tries to compile and instantiate the module produced
// with {gen}. Compilation should work, an error should only happen during
// instantiation or runtime. If {instantiationResult} is
// {instantiationShouldSucceed}, then {gen} should generate a function called
// "grow" which grows the tested aspect and returns "-1" if growing fails.
function testDynamicLimit(name, instantiationResult, imports, gen) {
  const builder = new WasmModuleBuilder();
  gen(builder);
  const buffer = builder.toBuffer();

  test(() => { assert_true(WebAssembly.validate(buffer)); },
       `Validate ${name} beyond its dynamic limit`);

  test(() => { new WebAssembly.Module(buffer); },
       `Compile ${name} beyond its dynamic limit`);

  promise_test(t => { return WebAssembly.compile(buffer); },
               `Async compile ${name} beyond its dynamic limit.`);

  test(() => {
    const compiled_module = new WebAssembly.Module(buffer);
    if (instantiationResult == instantiationShouldFail) {
      assert_throws(new RangeError(),
                    () => new WebAssembly.Instance(compiled_module, imports));
    } else if (instantiationResult == instantiationShouldSucceed) {
       const instance = new WebAssembly.Instance(compiled_module, imports);
       assertEquals(-1, instance.exports.grow());
    }
  }, `Instantiate ${name} over limit`);

  promise_test(t => {
    if (instantiationResult == instantiationShouldFail) {
      return Promise.resolve();
      return promise_rejects(t, new RangeError(),
                             WebAssembly.instantiate(buffer, imports));
    } else if (instantiationResult == instantiationShouldSucceed) {
      return WebAssembly.instantiate(buffer, imports)
          .then(({instance}) => { assertEquals(-1, instance.exports.grow()); });
    } else {
      return Promise.resolve();
    }
  }, `Async instantiate ${name} over limit`);
}

testDynamicLimit("initial table size", instantiationShouldFail, {}, (builder) => {
  builder.setTableBounds(kJSEmbeddingMaxTableSize + 1, undefined);
});

testDynamicLimit(
    "maximum table size", instantiationShouldSucceed, {}, (builder) => {
      builder.setTableBounds(1, kJSEmbeddingMaxTableSize + 1);
      // table.grow requires the reference types proposal. Instead we just
      // return -1.
      builder.addFunction("grow", kSig_i_v)
          .addBody([
            ...wasmI32Const(-1)
          ])
          .exportFunc();
    });

test(() => {
  assert_throws(
      new RangeError(),
      () => new WebAssembly.Table(
          {element : "anyfunc", initial : kJSEmbeddingMaxTableSize + 1}));

  let memory = new WebAssembly.Table(
      {initial : 1, maximum : kJSEmbeddingMaxTableSize + 1, element: "anyfunc"});
  assert_throws(new RangeError(),
                () => memory.grow(kJSEmbeddingMaxTableSize));
}, `Grow WebAssembly.Table object beyond the embedder-defined limit`);

function testModuleSizeLimit(size, expectPass) {
  // We do not use `testLimit` here to avoid OOMs due to having multiple big
  // modules alive at the same time.

  // Define a WebAssembly module that consists of a single custom section which
  // has an empty name. The module size will be `size`.
  let buffer;
  try {
    buffer = new Uint8Array(size);
  } catch (e) {
    if (e instanceof RangeError) {
      // 32-bit systems may fail to allocate a big TypedArray.
      return;
    }
    throw e;
  }
  const header = [
    kWasmH0, kWasmH1, kWasmH2, kWasmH3, // magic word
    kWasmV0, kWasmV1, kWasmV2, kWasmV3, // version
    0                                   // custom section
  ];
  // We calculate the section length so that the total module size is `size`.
  // For that we have to calculate the length of the leb encoding of the section
  // length.
  const sectionLength = size - header.length -
      wasmSignedLeb(size).length;
  const lengthBytes = wasmSignedLeb(sectionLength);
  buffer.set(header);
  buffer.set(lengthBytes, header.length);

  if (expectPass) {
    test(() => {
      assert_true(WebAssembly.validate(buffer));
    }, `Validate module size limit`);
    test(() => {
      new WebAssembly.Module(buffer);
    }, `Compile module size limit`);
    promise_test(t => {
      return WebAssembly.compile(buffer);
    }, `Async compile module size limit`);
  } else {
    test(() => {
      assert_false(WebAssembly.validate(buffer));
    }, `Validate module size over limit`);
    test(() => {
      assert_throws(
          new WebAssembly.CompileError(),
          () => new WebAssembly.Module(buffer));
    }, `Compile module size over limit`);
    promise_test(t => {
      return promise_rejects(
          t, new WebAssembly.CompileError(),
          WebAssembly.compile(buffer));
    }, `Async compile module size over limit`);
  }
}

testModuleSizeLimit(kJSEmbeddingMaxModuleSize, true);
testModuleSizeLimit(kJSEmbeddingMaxModuleSize + 1, false);
