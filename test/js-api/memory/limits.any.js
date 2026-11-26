// META: global=window,dedicatedworker,jsshell
// META: script=/wasm/jsapi/memory/assertions.js

// For memory32 the maximum size is the upper bound on Int32, so we cannot
// really test out-of-bounds values the same way we can for memory64.

const kJSEmbeddingMaxMemory32Size = 65536; // pages (4 GiB)

test(() => {
  const memory = new WebAssembly.Memory(
      {initial: 1,
       maximum: kJSEmbeddingMaxMemory32Size});
  assert_Memory(memory, { "size": 1 });
}, `Create WebAssembly.Memory with maximum size at the runtime limit`);

test(() => {
  assert_throws(
      new RangeError(),
      () => new WebAssembly.Memory(
          {initial: kJSEmbeddingMaxMemory32Size + 1}));
}, `Create WebAssembly.Memory with initial size out of bounds`);

test(() => {
  const mem = new WebAssembly.Memory(
      {initial: 1,
       maximum: kJSEmbeddingMaxMemory32Size});
  assert_throws(
      new RangeError(),
      () => mem.grow(kJSEmbeddingMaxMemory32Size));
}, `Grow WebAssembly.Memory beyond the runtime limit`);
