// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/table/assertions.js

// Same limit as table32
const kJSEmbeddingMaxTable64Size = 10000000n;

test(() => {
  const table = new WebAssembly.Table(
      {address: "i64",
       element: "anyfunc",
       initial: 1n, maximum: kJSEmbeddingMaxTable64Size + 1n});
  assert_Table(table, { length: 1n }, "i64")
}, `Create WebAssembly.Table with maximum size at the runtime limit (i64)`);

test(() => {
  assert_throws(
      new RangeError(),
      () => new WebAssembly.Table(
          {address: "i64",
           element: "anyfunc",
           initial: kJSEmbeddingMaxTable64Size + 1n}));
}, `Create WebAssembly.Table with initial size over the runtime limit (i64)`);

test(() => {
  let table = new WebAssembly.Table(
      {address: "i64",
       element: "anyfunc",
       initial: 1n, maximum: kJSEmbeddingMaxTable64Size + 1n});
  assert_throws(new RangeError(),
                () => table.grow(kJSEmbeddingMaxTable64Size));
}, `Grow WebAssembly.Table object beyond the runtime limit (i64)`);
