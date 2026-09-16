// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/assertions.js
// META: script=/wasm/jsapi/memory/assertions.js

const kJSEmbeddingMemoryTypeSizeLimit = 2n**37n - 1n;
const kJSEmbeddingMaxMemory64Size = 262144n; // pages (16 GiB)

test(() => {
  const memory = new WebAssembly.Memory(
      {address: "i64",
       initial: 1n,
       maximum: kJSEmbeddingMaxMemory64Size});
  assert_Memory(memory, { "size": 1, "address": "i64" });
}, `Create WebAssembly.Memory with maximum size at the runtime limit (i64)`);

test(() => {
  assert_throws(
      new RangeError(),
      () => new WebAssembly.Memory(
          {address: "i64",
           initial: kJSEmbeddingMaxMemory64Size + 1n}));
}, `Create WebAssembly.Memory with initial size over the runtime limit (i64)`);

test(() => {
  const mem = new WebAssembly.Memory(
      {address: "i64",
       initial: 1n,
       maximum: kJSEmbeddingMaxMemory64Size + 1n});
  assert_throws(
      new RangeError(),
      () => mem.grow(kJSEmbeddingMaxMemory64Size));
}, `Grow WebAssembly.Memory beyond the runtime limit (i64)`);

test(() => {
  const memory = new WebAssembly.Memory(
      {address: "i64",
       initial: 0n,
       maximum: kJSEmbeddingMemoryTypeSizeLimit});
  assert_Memory(memory, { "size": 0, "address": "i64" });
}, "Maximum at memory type size limit (i64)");

test(() => {
  assert_throws_js(RangeError,
      () => new WebAssembly.Memory(
          {address: "i64",
           initial: 0n,
           maximum: kJSEmbeddingMemoryTypeSizeLimit + 1n}));
}, "Maximum over memory type size limit (i64)");
