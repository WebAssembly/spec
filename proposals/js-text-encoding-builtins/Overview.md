# JS Text Encoding Builtins

## Overview

Building on top of the [JS String Builtins proposal](https://github.com/WebAssembly/js-string-builtins) this proposal adds builtins for encoding and decoding UTF-8 strings in linear memory to and from JavaScript strings.

## Goals

This proposal intends to serve Wasm toolchains that store strings in UTF-8. The provided functions should not require additional memory copies on the users side nor should the user have to account for engine-specific optimizations.

A good example is [Emscripten's implementation](https://github.com/emscripten-core/emscripten/blob/2760f83517e969fc31e19c3f11b973bfad5f6951/src/lib/libstrings.js#L33-L93), which specifically optimizes string decoding for short strings. Optimizations like these should be handled by the implementer, not the user.

When encoding JS strings to linear memory, memory has to be pre-allocated on the users side. This often is implemented with various optimizations strategies to avoid the overhead of measuring the resulting UTF-8 string size. Addressing this is a non-goal of this proposal.

## API

### "wasm:text-encoding" "decodeStringFromUTF8Array"

```js
/// Decode the specified GC `array` range using UTF-8 into a JS string.
///
/// This function traps if `array` is `null`.
///
/// The range is given by [start, end). This function traps if the range is
/// outside the bounds of `array`.
func decodeStringFromUTF8Array(
  array: ref null (array (mut i8)),
  start: i32,
  end: i32
) -> (ref extern)
{
  start >>>= 0;
  end >>>= 0;

  if (array === null)
    trap();

  if (start > end ||
      end > array.length)
    trap();

  let decoder = new TextDecoder("utf-8", {
    fatal: false,
    ignoreBOM: false,
  });
  let bytesLength = end - start;
  let view = new Uint8Array(array, start, bytesLength);

  return decoder.decode(view);
}
```

### "wasm:text-encoding" "decodeStringFromUTF8Memory"

```js
/// Decode the specified `WebAssembly.Memory` range using UTF-8 into a JS string.
///
/// This function traps if `memory` is not a `WebAssembly.Memory`.
///
/// The range is given by [start, end). This function traps if the range is
/// outside the bounds of the memory.
func decodeStringFromUTF8Memory(
  memory: externref,
  start: i64,
  end: i64
) -> (ref extern)
{
  start >>>= 0;
  end >>>= 0;

  if (!(memory instanceof WebAssembly.Memory))
    trap();

  if (start > end ||
      end > memory.buffer.length)
    trap();

  let decoder = new TextDecoder("utf-8", {
    fatal: false,
    ignoreBOM: false,
  });
  let bytesLength = end - start;
  let view = new Uint8Array(memory, start, bytesLength);

  return decoder.decode(view);
}
```

### "wasm:text-encoding" "measureStringAsUTF8"

```js
/// Returns the number of bytes a JS string would occupy when encoded as UTF-8.
///
/// This function traps if `string` is not a JS string.
func measureStringAsUTF8(
  string: externref
) -> i64
{
  if (typeof string !== "string")
    trap();

  let encoder = new TextEncoder();
  let bytes = encoder.encode(string);

  return bytes.length;
}
```

### "wasm:text-encoding" "encodeStringIntoUTF8Array"

```js
/// Encode a JS string into a GC `array` using
/// the UTF-8 encoding. This uses the replacement character for unpaired
/// surrogates and so it doesn't support lossless round-tripping with
/// `decodeStringFromUTF8Array`.
///
/// Returns the number of bytes read and written.
///
/// This function traps if `array` or `string` are not a GC `array` and `string` respectively.
///
/// The memory range is given by [start, end). This function traps if the range is
/// outside the bounds of the `array`.
func encodeStringIntoUTF8Array(
  array: ref null (array (mut i8))
  string: externref,
  start: i32,
  end: i32
) -> (i32, i32)
{
  start >>>= 0;
  end >>>= 0;

  if (array === null)
    trap();

  if (typeof string !== "string")
    trap();
    
  if (start > end ||
      end > array.length)
    trap();

  let encoder = new TextEncoder();
  let bytesLength = end - start;
  let view = new Uint8Array(array, start, bytesLength);

  let { read, written } = encoder.encodeInto(view);
  return [read, written];
}
```

### "wasm:text-encoding" "encodeStringIntoUTF8Memory"

```js
/// Encode a JS string into `WebAssembly.Memory` using
/// the UTF-8 encoding. This uses the replacement character for unpaired
/// surrogates and so it doesn't support lossless round-tripping with
/// `decodeStringFromUTF8Memory`.
///
/// Returns the number of bytes read and written.
///
/// This function traps if `memory` or `string` are not `WebAssembly.Memory` and `string` respectively.
///
/// The memory range is given by [start, end). This function traps if the range is
/// outside the bounds of the memory.
func encodeStringIntoUTF8Memory(
  memory: externref
  string: externref,
  start: i64,
  end: i64
) -> (i64, i64)
{
  start >>>= 0;
  end >>>= 0;

  if (!(memory instanceof WebAssembly.Memory))
    trap();

  if (typeof string !== "string")
    trap();
    
  if (start > end ||
      end > memory.buffer.length)
    trap();

  let encoder = new TextEncoder();
  let bytesLength = end - start;
  let view = new Uint8Array(memory, start, bytesLength);

  let { read, written } = encoder.encodeInto(view);
  return [read, written];
}
```

## FAQ

### What about WTF-16 user strings?

A more appropriate proposal already exists: [Reference-Typed Strings](https://github.com/WebAssembly/stringref). Notably it does not work with linear memory to facilitate zero-copy handling of WTF-16 host strings.

### How is an `externref` for `WebAssembly.Memory` retrieved?

This is left to toolchains to figure out. Currently this is already possible by initializing `WebAssembly.Memory` in JS and importing it to Wasm. Alternatively the memory can be exported and then retrieved via an import function through `WebAssembly.Instance.exports`.

### What about worklets?

While according to the WHATWG Encoding Standard the Text Encoding API should be exposed in worklets, this is [still an unclear edge-case](https://github.com/WebAudio/web-audio-api/issues/2499). However, most of the discussion is [centered around allocating APIs](https://github.com/whatwg/encoding/issues/356) like `TextEncode.encode()`, which we don't use here.

### What about substring de/encoding?

The JS String Builtins proposal already exposes [`"wasm:js-string" "substring"`](https://github.com/WebAssembly/js-string-builtins/blob/81bfc5fb7b8277c6b7d1b0a8f6e57cb31a7bf080/proposals/js-string-builtins/Overview.md#wasmjs-string-substring). So instead of making the API more complex, we can let users extract a desirable substring.

### `"wasm:text-encoding"` vs `"wasm:js/text-encoding"`.

There is an [ongoing discussion](https://github.com/WebAssembly/esm-integration/issues/118) to change the mapping for JS builtins. Either convention works for us in this proposal.
