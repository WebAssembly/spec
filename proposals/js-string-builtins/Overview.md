# JS String Builtins

## Motivation

JavaScript runtimes have a rich set of [builtin objects and primitives](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects). Some languages targeting WebAssembly may have compatible primitives and would benefit from being able to use the equivalent JavaScript primitive for their implementation. The most pressing use-case here is for languages who would like to use the JavaScript [`String`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) type to implement their strings.

It is already possible to use any JavaScript or Web API from WebAssembly by importing JavaScript 'glue code' which adapts between JavaScript and WebAssembly values and calling conventions. Usually, this has a negligible performance impact and work has been done to [optimize this in runtimes when we can](https://hacks.mozilla.org/2018/10/calls-between-javascript-and-webassembly-are-finally-fast-%F0%9F%8E%89/).

However, the overhead of importing glue code is prohibitive for primitives such as [`String`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String), [`ArrayBuffer`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer), [`RegExp`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp), [`Map`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map), and [`BigInt`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt) where the desired overhead of operations is a tight sequence of inline instructions, not an indirect function call (which is typical of imported functions).

## Overview

This proposal aims to provide a minimal and general mechanism for importing specific JavaScript primitives for efficient usage in WebAssembly code.

This is done by first adding a set of Wasm builtin functions for performing JavaScript String operations. These builtin functions mirror a subset of the [JavaScript String API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) and adapt it to be efficiently callable without JavaScript glue code.

Then a mechanism for importing these Wasm builtin functions is added to the WebAssembly JS-API. These builtins are grouped in modules and exist in a new reserved import namespace `wasm:` that is enabled at compile-time with a flag.

These two pieces in combination allow runtimes to reliably emit optimal code sequences for JavaScript string operations within WebAssembly modules. In the future, other JS builtin objects or JS primitives can be exposed through new Wasm builtins.

## Do we need new Wasm builtin functions?

It is already possible today to import JS builtin functions (such as [`String.prototoype.charCodeAt()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/charCodeAt)) from Wasm modules. Instead of defining new Wasm specific-builtins, we could just re-use those directly.

There are several problems with this approach.

The first problem is that existing APIs require a calling convention conversion to handle differences around the `this` value, which WebAssembly function import calls leave as `undefined`. The second problem is that certain primitives use JS operators such as `===` and `<` that cannot be imported. A third problem is that most JS builtins are extremely permissive of the types of values they accept, and it's desirable to leverage Wasm's type system to remove those checks and coercions wherever we can.

It seems that creating new importable definitions that adapt existing JS primitives to WebAssembly is simpler and more flexible in the future.

## Do we need a new import mechanism for Wasm builtin functions?

There is a variety of execution techniques for WebAssembly. Some WebAssembly engines compile modules eagerly (at `WebAssembly.compile()`), some use interpreters and dynamic tiering, and some use on-demand compilation (after instantiation) and dynamic tiering.

If we just have builtin functions, it would be possible to normally import them through instantiation. However this would prevent engines from using eager compilation when builtins are in use.

It seems desirable to support a variety of execution techniques, especially because engines may support multiple depending on heuristics or change them over time.

By adding builtins that are in a reserved and known namespace (`wasm:`), engines can know that these builtin functions are being used at `WebAssembly.compile()` time and generate optimal code for them.

## Goals for builtins

Builtins should not provide any new abilities to WebAssembly that JS doesn't already have. They are intended to just wrap existing primitives in such a manner that WebAssembly can efficiently use them. In the cases the primitive already has a name, we should re-use it and not invent a new one.

Most builtins should be simple and do little work outside of calling into the JS functionality to do the operation. The one exception is for operations that convert between a JS primitive and a Wasm primitive, such as between JS strings/arrays/linear memory. In this case, the builtin may need some non-trivial code to perform the operation and it's still expected that the operation is just semantically copying information and not substantially transforming it into a new interpretation.

The standardization of Wasm builtins will be governed by the WebAssembly standards process and would exist in the JS-API document.

The bar for adding a new builtin would be that it enables significantly better code generation for an important use-case beyond what is possible with a normal import. We don't want to add a new builtin for every existing API, only ones where adapting the JavaScript API to WebAssembly and allowing inline code generation results in significantly better codegen than a plain function call.

## Function builtins

Function builtins are defined with an external Wasm function type, and internal JS-defined behavior. They have the same semantics as following ['create a host function'](https://webassembly.github.io/spec/js-api/#create-a-host-function) for the Wasm function type and JS code given to get a wasm `funcaddr` that can be imported.

There are several implications of this:
  - Calling a function builtin from Wasm will have the Wasm parameters converted to JS values, and JS results converted back to Wasm values.
  - Exported function builtins are wrapped using ['create a new Exported function'](https://webassembly.github.io/spec/js-api/#a-new-exported-function).
  - Function builtins must be imported with the correct type.
  - Function builtins may become `funcref`, stored in tables, etc.

The `name of the WebAssembly function` JS-API procedure is extended to return the import field name for builtin functions, not an index value.

## Type builtins

Type builtins could be an instance of the `WebAssembly.Type` interface provided by the [type-imports](https://github.com/WebAssembly/proposal-type-imports) proposal. The values contained in a type builtin would be specified with a predicate.

This proposal does not add any type builtins, as the design around type-imports is in flux.

## Using builtins

Every builtin has a name, and builtins are grouped into collections with a name that matches the interface they are mirroring.

An example import specifier could therefore be `(import "wasm:js-string" "equals" ...)`.

The JS-API does not reserve a `wasm:` namespace today, so modules theoretically could already be using this namespace. Additionally, some users may wish to disable this feature for modules they compile so they could polyfill it. This feature is therefore opt-in via flags for each interface.

To just enabled `js-string` builtins, a user would compile with:

```js
WebAssembly.compile(bytes, { builtins: ['js-string'] });
```

The full extension to the JS-API WebIDL is:

```idl
dictionary WebAssemblyCompileOptions {
    optional sequence<USVString> builtins;
}

[LegacyNamespace=WebAssembly, Exposed=*]
interface Module {
  constructor(BufferSource bytes, optional WebAssemblyCompileOptions options);
  ...
}

[Exposed=*]
namespace WebAssembly {
    # Validate accepts compile options for feature detection.
    # See below for details.
    boolean validate(
      BufferSource bytes,
      optional WebAssemblyCompileOptions options);

    # Async compile accepts compile options.
    Promise<Module> compile(
      BufferSource bytes,
      optional WebAssemblyCompileOptions options);

    # Async instantiate overload with bytes parameters does accept compile
    # options.
    Promise<WebAssemblyInstantiatedSource> instantiate(
      BufferSource bytes,
      optional object importObject,
      optional WebAssemblyCompileOptions options
    );

    # Async instantiate overload with module parameter does not accept compile
    # options and remains the same.
    Promise<Instance> instantiate(
      Module moduleObject,
      optional object importObject
    );

    # Async streaming compile accepts compile options.
    Promise<Module> compileStreaming(
      Promise<Response> source,
      optional WebAssemblyCompileOptions options);

    # Async streaming compile and instantiate accepts compile options after
    # imports.
    Promise<WebAssemblyInstantiatedSource> instantiateStreaming(
      Promise<Response> source,
      optional object importObject,
      optional WebAssemblyCompileOptions options);
};
```

A Wasm module that has enabled builtins will have the specific import specifier, such as `wasm:js-string` for that interface available and eagerly applied.

Concretely this means that imports that refer to that specifier will be eagerly checked for link errors at compile time, those imports will not show up in `WebAssembly.Module.imports()`, and those imports will not need to be provided at instantiation time. No property lookup on the instantiation imports object will be done for those imports.

When the module is instantiated, a unique instantiation of the builtins is created. This means that re-exports of builtin functions will have different identities if they come from different instances. This is a useful property for future extensions to bind memory to builtins or evolve the types as things like type-imports or a core stringref type are added (see below).

## Progressive enhancement

For engines that don't support builtins, any compile options passed to the JS-API will be ignored (due to WebIDL rules for extra parameters). For engines that do support builtins, any imports that refer to a builtin are not looked up on the instantiation import object.

Together this means that it's safe for users to request builtins while still providing a polyfill for backup behavior and the optimal path will be chosen.

## Feature detection

Users may wish to detect if a specific builtin is available in their system.

For this purpose, `WebAssembly.validate()` is extended to take a list of builtins to enable, like `compile()` does. After validating the module, the eager link checking that `compile()` does is also performed. Users can validate a module that deliberately imports a builtin operation with an incorrect signature and infer support for that particular builtin if validation reports a link error.

## Polyfilling

If a user wishes to polyfill these imports for some reason, or is running on a system without a builtin, these imports may be provided as normal through instantiation.

## UTF8/WTF8 support

As stated above in 'goals for builtins', builtins are intended to just wrap existing primitives and not invent new functionality.

JS Strings are semantically a sequence of 16-bit code units (referred to as char codes in method naming), and there are no builtin operations on them to acquire a UTF-8 or WTF-8 view. This makes it difficult to write Wasm builtins for these encodings without introducing significant new logic to them.

There is the Encoding API for `TextEncoder`/`TextDecoder` which can be used for UTF-8 support. However, this is technically a separate spec from JS and may not be available on all JS engines (in practice it's available widely). This proposal exposes UTF-8 data conversions using this API under separate `wasm:text-encoder` `wasm:text-decoder` interfaces which are available when the host implements these interfaces.

## String constants

String constants may be defined in JS and made available to Wasm through a variety of means.

The simplest way is to have a module import each string as an immutable global. This can work for small amounts of strings, but has a high cost for when the number of string constants is very large.

This proposal adds an extension to the JS-API compile routine to support optimized 'imported string constants' to address this use-case.

The `WebAssemblyCompileOptions` dictionary is extended with a `USVString? importedStringConstants` flag.

```
partial dictionary WebAssemblyCompileOptions {
    USVString? importedStringConstants;
}
```

When this is set to a non-null value, the module may import globals of the form `(import "%importedStringConstants%" "%stringConstant%"" (global ...))`, and the JS-API will use the provided `%stringConstant%` import field name to be the value of the global. This allows for any UTF-8 string to be imported with minimal overhead.

### Example

```wasm
(module
  (global (import "strings" "my string constant") (ref extern))
  (export "constant" (global 0))
)
```

```js
let instance = WebAssembly.instantiate(bytes, {importedStringConstants: "strings"});

// The global is automatically populated with the string constant
assertEq(instance.exports.constant.value, "my string constant");
```

### Details

When `importedStringConstants` is non-null, the specified string becomes the `imported string namespace`.

During the ['compile a module'](https://webassembly.github.io/spec/js-api/index.html#compile-a-webassembly-module) step of the JS-API, the imports of the module are examined to see which refer to the imported string namespace. If an import refers to the imported string namespace, then the import type is [matched](https://webassembly.github.io/spec/core/valid/types.html#globals) against an extern type of `(global (ref extern))`. If an import fails to match, then 'compile a module' fails. The resulting module is associated with the imported string namespace for use during instantiation.

During the ['read the imports'](https://webassembly.github.io/spec/js-api/index.html#read-the-imports) step of the JS-API, if the module has an imported string namespace, then every import that refers to this namespace has a global created to hold the string constant specified in the import field. This global is added to the imports object. If all imports in a module are from the imported string namespace, no import object needs to be provided.

When the imports object is used during ['instantiate a module'](https://webassembly.github.io/spec/js-api/index.html#instantiate-the-core-of-a-webassembly-module), these implicitly created globals should never cause a link error due to the eager matching done in 'compile a module'.

## JS String Builtin API

The following is an initial set of function builtins for JavaScript String. The builtins are exposed under `wasm:js-string`.

All below references to builtins on the Global object (e.g., `String.fromCharCode()`) refer to the original version on the Global object before any modifications by user code.

The following internal helpers are defined in Wasm and are used by the below definitions:

```wasm
(module
  (type $array_i16 (array (mut i16)))

  (func (export "trap")
    unreachable
  )
  (func (export "array_len") (param arrayref) (result i32)
    local.get 0
    array.len
  )
  (func (export "array_i16_get") (param (ref $array_i16) i32) (result i32)
    local.get 0
    local.get 1
    array.get_u $array_i16
  )
  (func (export "array_i16_set") (param (ref $array_i16) i32 i32)
    local.get 0
    local.get 1
    local.get 2
    array.set $array_i16
  )
)
```

### "wasm:js-string" "cast"

```
func cast(
  string: externref
) -> (ref extern) {
  // Technically a partially redundant test, but want to be clear the null is
  // not allowed.
  if (string === null ||
      typeof string !== "string")
    trap();

  return string;
}
```

### "wasm:js-string" "test"

```
func test(
  string: externref
) -> i32 {
  // Technically a partially redundant test, but want to be clear the null is
  // not allowed.
  if (string === null ||
      typeof string !== "string")
    return 0;
  return 1;
}
```

### "wasm:js-string" "fromCharCodeArray"

```
/// Convert the specified range of a mutable i16 array into a String,
/// treating each i16 as an unsigned 16-bit char code.
///
/// The range is given by [start, end). This function traps if the range is
/// outside the bounds of the array.
///
/// NOTE: This function only takes a mutable i16 array defined in its own
/// recursion group.
///
/// If this is an issue for toolchains, we can look into how to relax the
/// function type while still maintaining good performance.
func fromCharCodeArray(
  array: (ref null (array (mut i16))),
  start: i32,
  end: i32
) -> (ref extern)
{
  // NOTE: `start` and `end` are interpreted as signed 32-bit integers when
  // converted to JS values using standard conversions. Reinterpret them as
  // unsigned here.
  start >>>= 0;
  end >>>= 0;

  if (array === null)
    trap();

  if (start > end ||
      end > array_len(array))
    trap();

  let result = "";
  for(let i = start; i < end; i++) {
    let charCode = array_i16_get(array, i);
    result += String.fromCharCode(charCode);
  }
  return result;
}
```

### "wasm:js-string" "intoCharCodeArray"

```
/// Copy a string into a pre-allocated mutable i16 array at `start` index.
///
/// Returns the number of char codes written, which is equal to the length of
/// the string.
///
/// Traps if the string doesn't fit into the array.
func intoCharCodeArray(
  string: externref,
  array: (ref null (array (mut i16))),
  start: i32
) -> i32
{
  // NOTE: `start` is interpreted as a signed 32-bit integer when converted
  // to a JS value using standard conversions. Reinterpret as unsigned here.
  start >>>= 0;

  if (array === null)
    trap();

  // Technically a partially redundant test, but want to be clear the null is
  // not allowed.
  if (string === null ||
      typeof string !== "string")
    trap();

  // The following addition is safe from overflow as adding two 32-bit integers
  // cannot overflow Number.MAX_SAFE_INTEGER (2^53-1).
  if (start + string.length > array_len(array))
    trap();

  for (let i = 0; i < string.length; i++) {
    let charCode = string.charCodeAt(i);
    array_i16_set(array, start + i, charCode);
  }
  return string.length;
}
```

### "wasm:js-string" "fromCharCode"

```
func fromCharCode(
  charCode: i32
) -> (ref extern)
{
  // NOTE: `charCode` is interpreted as a signed 32-bit integer when converted
  // to a JS value using standard conversions. Reinterpret as unsigned here.
  charCode >>>= 0;

  return String.fromCharCode(charCode);
}
```

### "wasm:js-string" "fromCodePoint"

```
func fromCodePoint(
  codePoint: i32
) -> (ref extern)
{
  // NOTE: `codePoint` is interpreted as a signed 32-bit integer when converted
  // to a JS value using standard conversions. Reinterpret as unsigned here.
  codePoint >>>= 0;

  // fromCodePoint will throw a RangeError for values outside of this range,
  // eagerly check for this an present as a wasm trap.
  if (codePoint > 0x10FFFF)
    trap();

  return String.fromCodePoint(codePoint);
}
```

### "wasm:js-string" "charCodeAt"

```
func charCodeAt(
  string: externref,
  index: i32
) -> i32
{
  // NOTE: `index` is interpreted as a signed 32-bit integer when converted to
  // a JS value using standard conversions. Reinterpret as unsigned here.
  index >>>= 0;

  // Technically a partially redundant test, but want to be clear the null is
  // not allowed.
  if (string === null ||
      typeof string !== "string")
    trap();

  if (index >= string.length)
    trap();

  return string.charCodeAt(index);
}
```

### "wasm:js-string" "codePointAt"

```
func codePointAt(
  string: externref,
  index: i32
) -> i32
{
  // NOTE: `index` is interpreted as a signed 32-bit integer when converted to
  // a JS value using standard conversions. Reinterpret as unsigned here.
  index >>>= 0;

  // Technically a partially redundant test, but want to be clear the null is
  // not allowed.
  if (string === null ||
      typeof string !== "string")
    trap();

  if (index >= string.length)
    trap();

  return string.codePointAt(index);
}
```

### "wasm:js-string" "length"

```
func length(string: externref) -> i32 {
  // Technically a partially redundant test, but want to be clear the null is
  // not allowed.
  if (string === null ||
      typeof string !== "string")
    trap();

  return string.length;
}
```

### "wasm:js-string" "concat"

```
func concat(
  first: externref,
  second: externref
) -> (ref extern)
{
  if (first === null ||
      typeof first !== "string")
    trap();
  if (second === null ||
      typeof second !== "string")
    trap();

  return first.concat(second);
}
```

### "wasm:js-string" "substring"

```
func substring(
  string: externref,
  start: i32,
  end: i32
) -> (ref extern)
{
  // NOTE: `start` and `end` are interpreted as signed 32-bit integers when
  // converted to JS values using standard conversions. Reinterpret them as
  // unsigned here.
  start >>>= 0;
  end >>>= 0;

  // Technically a partially redundant test, but want to be clear the null is
  // not allowed.
  if (string === null ||
      typeof string !== "string")
    trap();

  // Ensure the range is ordered to avoid the complex behavior that `substring`
  // performs when that is not the case.
  if (start > end ||
      start > string.length)
    return "";

  // If end > string.length, `substring` is specified to clamp it
  // start is guaranteed to be at least zero (as it is unsigned), so there will
  // not be any clamping of start.
  return string.substring(start, end);
}
```

### "wasm:js-string" "equals"

```
func equals(
  first: externref,
  second: externref
) -> i32
{
  // Explicitly allow null strings to be compared for equality as that is
  // meaningful.
  if (first !== null &&
      typeof first !== "string")
    trap();
  if (second !== null &&
      typeof second !== "string")
    trap();
  return first === second ? 1 : 0;
}
```

### "wasm:js-string" "compare"

```
function compare(
  first: externref,
  second: externref
) -> i32
{
  // Explicitly do not allow null strings to be compared, as there is no
  // meaningful ordering given by the JS `<` operator.
  if (first === null ||
      typeof first !== "string")
    trap();
  if (second === null ||
      typeof second !== "string")
    trap();

  if (first === second)
    return 0;
  return first < second ? -1 : 1;
}
```

## Encoding API

The following is an initial set of function builtins for the [`TextEncoder`](https://encoding.spec.whatwg.org/#interface-textencoder) and the [`TextDecoder`](https://encoding.spec.whatwg.org/#interface-textdecoder) interfaces. These builtins are exposed under `wasm:text-encoder` and `wasm:text-decoder`, respectively.

All below references to builtins on the Global object (e.g. `String.fromCharCode()`) refer to the original version on the Global object before any modifications by user code.

The following internal helpers are defined in Wasm and used by the below definitions:

```wasm
(module
  (type $array_i8 (array (mut i8)))

  (func (export "unreachable")
    unreachable
  )
  (func (export "array_len") (param arrayref) (result i32)
    local.get 0
    array.len
  )
  (func (export "array_i8_get") (param (ref $array_i8) i32) (result i32)
    local.get 0
    local.get 1
    array.get_u $array_i8
  )
  (func (export "array_i8_new") (param i32) (result (ref $array_i8))
    local.get 0
    array.new_default $array_i8
  )
  (func (export "array_i8_set") (param (ref $array_i8) i32 i32)
    local.get 0
    local.get 1
    local.get 2
    array.set $array_i8
  )
)
```

```js
// Triggers a wasm trap, which will generate a WebAssembly.RuntimeError that is
// uncatchable to WebAssembly with an implementation defined message.
function trap() {
  // Directly constructing and throwing a WebAssembly.RuntimeError will yield
  // an exception that is catchable by the WebAssembly exception-handling
  // proposal. Workaround this by executing an unreachable trap and
  // modifying it. The final spec will probably use a non-polyfillable
  // intrinsic to get this exactly right.
  try {
    unreachable();
  } catch (err) {
    // Wasm trap error messages are not defined by the JS-API spec currently.
    err.message = IMPL_DEFINED;
    throw err;
  }
}
```

### "wasm:text-decoder" "decodeStringFromUTF8Array"

```
/// Decode the specified range of an i8 array using UTF-8 into a string.
///
/// The range is given by [start, end). This function traps if the range is
/// outside the bounds of the array.
///
/// NOTE: This function only takes an immutable i8 array defined in its own
/// recursion group.
///
/// If this is an issue for toolchains, we can look into how to relax the
/// function type while still maintaining good performance.
func decodeStringFromUTF8Array(
  array: (ref null (array (mut i8))),
  start: i32,
  end: i32
) -> (ref extern)
{
  // NOTE: `start` and `end` are interpreted as signed 32-bit integers when
  // converted to JS values using standard conversions. Reinterpret them as
  // unsigned here.
  start >>>= 0;
  end >>>= 0;

  if (array === null)
    trap();

  if (start > end ||
      end > array_len(array))
    trap();

  // Inialize a UTF-8 decoder with the default options
  let decoder = new TextDecoder("utf-8", {
    fatal: false,
    ignoreBOM: false,
  });

  // Copy the wasm array into a Uint8Array for decoding
  let bytesLength = end - start;
  let bytes = new Uint8Array(bytesLength);
  for (let i = start; i < end; i++) {
    bytes[i - start] = array_i8_get(array, i);
  }

  return decoder.decode(bytes);
}
```

### "wasm:text-encoder" "measureStringAsUTF8"

```
/// Returns the number of bytes string would take when encoded as UTF-8.
///
/// Traps if the length of the UTF-8 encoded string doesn't fit into an i32
func measureStringAsUTF8(
  string: externref
) -> i32
{
  // Technically a partially redundant test, but want to be clear the null is
  // not allowed.
  if (string === null ||
      typeof string !== "string")
    trap();

  // Encode the string into bytes using UTF-8
  let encoder = new TextEncoder();
  let bytes = encoder.encode(string);

  // Trap if the number of bytes is larger than can fit into an i32
  if (bytes.length > 0xffff_ffff) {
    trap();
  }
  return bytes.length;
}
```

### "wasm:text-encoder" "encodeStringIntoUTF8Array"

```
/// Encode a string into a pre-allocated mutable i8 array at `start` index using
/// the UTF-8 encoding. This uses the replacement character for unpaired
/// surrogates and so it doesn't support lossless round-tripping with
/// `decodeStringFromUTF8Array`.
///
/// Returns the number of bytes written.
///
/// Traps if the string doesn't fit into the array.
func encodeStringIntoUTF8Array(
  string: externref,
  array: (ref null (array (mut i8))),
  start: i32
) -> i32
{
  // NOTE: `start` is interpreted as a signed 32-bit integer when converted
  // to a JS value using standard conversions. Reinterpret as unsigned here.
  start >>>= 0;

  if (array === null)
    trap();

  // Technically a partially redundant test, but want to be clear the null is
  // not allowed.
  if (string === null ||
      typeof string !== "string")
    trap();

  // Encode the string into bytes using UTF-8
  let encoder = new TextEncoder();
  let bytes = encoder.encode(string);

  // The following addition is safe from overflow as adding two 32-bit integers
  // cannot overflow Number.MAX_SAFE_INTEGER (2^53-1).
  if (start + bytes.length > array_len(array))
    trap();

  for (let i = 0; i < bytes.length; i++) {
    array_i8_set(array, start + i, bytes[i]);
  }

  return bytes.length;
}
```

### "wasm:text-encoder" "encodeStringToUTF8Array"

```
/// Encode a string into a new mutable i8 array using UTF-8.
////
/// This uses the replacement character for unpaired surrogates and so it
/// doesn't support lossless round-tripping with `decodeStringFromUTF8Array`.
func encodeStringToUTF8Array(
  string: externref
) -> (ref (array (mut i8)))
{
  // Technically a partially redundant test, but want to be clear the null is
  // not allowed.
  if (string === null ||
      typeof string !== "string")
    trap();

  // Encode the string into bytes using UTF-8
  let encoder = new TextEncoder();
  let bytes = encoder.encode(string);

  let array = array_i8_new(bytes.length);
  for (let i = 0; i < bytes.length; i++) {
    array_i8_set(array, i, bytes[i]);
  }
  return array;
}
```

## Future extensions

There are several extensions we can make in the future as need arrives.

### Binding memory to builtins

It may be useful to have a builtin that operates on a specific Wasm memory. For JS strings, this could allow us to encode a JS string directly into linear memory.

One way we could do this is by having the JS-API bind the first imported memory of a module to any imported builtin functions that want to operate on memory. If there is no imported memory and a builtin function that needs memory is imported, then a link error is reported.

The memory is imported as opposed to exported so that it is guaranteed to exist when the builtin imports are provided. Using a memory defined only locally would have limited flexibility and would also be exposing a potentially private memory to outside its module.

A quick example:

```wasm
(module
  (; memory 0 ;)
  (import ... (memory ...))

  (; bound to memory 0 through the JS-API instantiating the builtins ;)
  (import "wasm:js-string" "encodeStringToMemoryUTF16" (func ...))
)
```

Because the `wasm:js-string` module is instantiated when the module using it is instantiated, the imported memory will be around to be provided to both modules.

If multi-memory is in use and the desired memory to bind with is not the first import, then we could consider parsing the imports to determine which memory is needed for which builtin. For example, `encodeStringToMemoryUTF16.2` for binding to memory 2.

### Better function types to avoid runtime checks

The initial set of JS String Builtins are typed to use `externref` for wherever a JS String is needed. This can lead to runtime checks that should be avoidable. Optimizing compilers can probably get rid of some of these, but not all.

In the future, we could have type imports or a core stringref type. In this event, it would be desirable to use those in the function types to avoid unnecessary runtime checks.

The difficulty is how to do this in a backwards compatible way. If we, for example, changed the type of a builtin from `[externref] -> []` to `(ref null 0) -> []`, we would break old code that imported it with the externref parameter.

One option would be to version the name of the function builtins, and add a new one for the more advanced type signature.

Another option to do this would be to extend the JS-API to inspect the function types used when importing these builtins to determine whether to provide it the 'advanced type' version or the 'basic type' version. This would be a heuristic, something like checking if the type refers to a type import or not.
