// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/table/assertions.js

const kJSEmbeddingMaxTable32Size = 10000000;

test(() => {
  const table = new WebAssembly.Table(
      {element: "anyfunc", initial: 1, maximum: kJSEmbeddingMaxTable32Size + 1});
  assert_Table(table, { length: 1 })
}, `Create WebAssembly.Table with maximum size at the runtime limit`);

test(() => {
  assert_throws(
      new RangeError(),
      () => new WebAssembly.Table(
          {element: "anyfunc", initial: kJSEmbeddingMaxTable32Size + 1}));
}, `Create WebAssembly.Table with initial size over the runtime limit`);

test(() => {
  let table = new WebAssembly.Table(
      {element: "anyfunc", initial: 1,
       maximum: kJSEmbeddingMaxTable32Size + 1});
  assert_throws(new RangeError(),
                () => table.grow(kJSEmbeddingMaxTable32Size));
}, `Grow WebAssembly.Table object beyond the runtime limit`);
