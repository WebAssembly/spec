# JS String Builtins

## Motivation

JavaScript runtimes have a rich set of [builtin objects and primitives](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects). Some languages targeting WebAssembly may have compatible primitives and would benefit from being able to use the equivalent JavaScript primitive for their implementation. The most pressing use-case here is for languages who would like to use the JavaScript String type to implement their strings.

It is already possible to use any JavaScript or Web API from WebAssembly by importing JavaScript 'glue code' which adapts between JavaScript and WebAssembly values and calling conventions. Usually, this has a negligible performance impact and work has been done to optimize this [in runtimes when we can](https://hacks.mozilla.org/2018/10/calls-between-javascript-and-webassembly-are-finally-fast-%F0%9F%8E%89/).

However, the overhead of importing glue code is prohibitive for primitives such as Strings, ArrayBuffers, RegExp, Map, and BigInt where the desired overhead of operations is a tight sequence of inline instructions, not an indirect function call (which is typical of imported functions).

## Overview

This proposal aims to provide a minimal and general mechanism for importing specific JavaScript primitives for efficient usage in WebAssembly code.

This is done by first adding a mechanism for providing import values at compile-time. This makes it possible for Web runtimes to reliably specialize compiled code to the import value provided. This must be done carefully to not break certain invariants and optimizations that Web runtimes currently rely on.

Then, it adds a set of builtin functions for performing JavaScript String operations. These builtin functions mirror a subset of the [JavaScript String API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) and adapt it to be efficiently callable without JavaScript glue code. 

These two pieces in combination allow runtimes to reliably emit optimal code sequences for JavaScript String operations within WebAssembly modules. In the future, other builtin objects or primitives can be exposed through new builtins.

## Compile-time imports

Today, imports are provided when instantiating a module. This prevents web runtimes from being able to know anything about an import (beyond the type specified in the module) while compiling, without either speculation or deferring compilation until instantiation or later. This makes it difficult to optimize for a specific import when compiling a module.

Speculation and deferred compilation are useful techniques, but should not be necessary to efficiently use specific JavaScript primitives from WebAssembly code on the Web.

This proposal modifies the WebAssembly JS-API methods for compilation to optionally accept an object that specifies certain import values earlier than instantiation. There are several constraints to keep in mind before fully describing the API.

### Constraints

#### Modules can be shared across web workers using postMessage

Not all import values are shareable across workers. We must be able to send shareable import values across workers, and reject unshareable values.

It’s possible that we could disable sharing modules that have any compile-time imports for an initial version, but this would need to be solved in the fullness of time.

#### Compiled modules can be serialized to the network cache

Web engines can cache optimized code in a network cache entry keyed off of a HTTP fetch request. If the optimized code is specialized to runtime provided import values, we will need to expand the cache key to include those values. There is a risk that specializing to keys that change every page load could effectively disable code caching.

#### Decoding the imports section can happen on a different thread from the imports object

Parsing and compiling a module can happen on background threads which cannot perform property lookups on an imports object.

#### Reading from the imports object requires knowing the keys

See [‘read the imports’](https://webassembly.github.io/spec/js-api/index.html#read-the-imports). Import value lookup is performed using JavaScript ‘get property’ which requires knowledge of the key you’re looking up. It’s not possible to pull all possible values from the imports object eagerly as it may be a JavaScript proxy or other exotic object which does not provide iteration over all possible keys.

#### We should standardize the web interfaces that can be specialized to

Specializing to an import can be critical to the runtime performance of the module. We should provide strong guarantees about when specialization happens and to which imports.

#### Do not conflict with future core wasm features

Do our best to not conflict with potential future wasm proposals, such as pre-imports, staged compilation, module linking, or the component model. Make minimal or no changes to the core specification.

###  Modifications

#### Add a WebIDL attribute for `shareable`

This attribute is to be used on WebAssembly builtins, and possibly other Web interfaces in the future. They can be used with the [structured clone](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Structured_clone_algorithm) algorithm, and as compile-time imports.

As they are well defined for structured clone, they are valid to be sent through postMessage. We may prevent them from being stored in user-facing persistent storage, such as IndexedDB. This is the situation with modules, as well.

#### Modify the JS-API compilation methods to accept optional options

```
dictionary WebAssemblyImportValue {
    required USVString module;
    required USVString name;
    required any value;
}
dictionary WebAssemblyCompileOptions {
    optional sequence<WebAssemblyImportValue> imports;
}

interface Module {
  constructor(BufferSource bytes, optional WebAssemblyCompileOptions options);
  ...
}

namespace WebAssembly {
	Promise<Module> compile(
BufferSource bytes,
optional WebAssemblyCompileOptions options);
	...
};

```

The `imports` field is a list of import values to apply when compiling. It is not the same kind of imports object as used when instantiating, due to the above mentioned design constraints around threading and ‘get property’.

Every import key of ‘module’ and ‘name’ must be specified at most once, or else a `LinkError` will be thrown. Every value provided must have the `shareable` WebIDL attribute.

A module compiled with `imports` extends the [‘Compile a WebAssembly module’](https://webassembly.github.io/spec/js-api/index.html#compile-a-webassembly-module) algorithm to check that the import values are compatible with the module. This could be expressed with a new embedding function `module_validate_imports(module, externval)` which only performs import matching and does not mutate the store. Any issues are reported with a `LinkError`.

The provided import values are stored in the module object. Any import provided at compile-time does not need to be provided during instantiation. The `WebAssembly.Module.imports()` static method will also exclude listing these imports.

Any provided import value may be specialized to when compiling the module if the engine deems it profitable. It is expected that standardized WebAssembly builtins will be guaranteed to be specialized to if they are exposed by an engine.

Because every `shareable` value is valid for structured clone, the compiled module can always be sent with `postMessage`. `shareable` values are also expected to be safe to be cached by the browser in the network cache.

### Open Questions

#### Should we throw LinkError for importing a non `shareable` value

The above proposal throws a `LinkError` if you import a non `shareable` value. It could be possible to import a non `shareable` value if we were to prevent that module from being sent with postMessage. Web engines with module caching would likely not specialize on those values to keep the resulting module cacheable.

#### Is there a better design for the compile-time imports object?

Having a different structure for the two different kinds of imports is very unfortunate.

One option proposed is to have the same kind of imports object as instantiation, but limit the recognized values to properties that are iterable. This would simplify the API, but might lead to confusion as the import objects look identical but are not treated the same.

## Builtins

### Do we need builtins?

Now that we have a method for providing imports at compile-time, we need to decide what we're actually importing.

One interesting option would be for engines to pattern match on import values to well-known API’s. You could imagine an engine recognizing an import to `String.prototype.charCodeAt` and emitting efficient code generation for it.

There are two main problems with this approach.

The first problem is that existing API’s require a calling convention conversion to handle differences around the `this` value, which WebAssembly function import calls leave as `undefined`. The second problem is that certain primitive use JS operators such as `===` and `<` that cannot be imported.

It's possible that we could extend the [js-types](https://github.com/webassembly/js-types) `WebAssembly.Function` API to handle the `this` parameter. However, at this point the pattern matching will become more than one level deep, which becomes increasingly fragile.

It seems that creating new importable definitions that adapt existing JS primitives to WebAssembly is simpler and more flexible in the future.

### What is a builtin?

A builtin is a definition on the WebAssembly namespace that can be imported by a module and provides efficient access to a JavaScript or Web primitive. There will be two types of builtins, functions and types. Type builtins will only become available with the [type-imports proposal](https://github.com/webassembly/type-imports).

Builtins do not provide any new abilities to WebAssembly. They merely wrap existing primitives in such a manner that WebAssembly can efficiently use them.

The standardization of builtins will be governed by the WebAssembly standards process and would exist in the JS-API document.

The bar for adding a new builtin would be that it enables significantly better code generation for an important use-case beyond what is possible with a normal import. We don't want to add a new builtin for every existing API, only ones where adapting the JavaScript API to WebAssembly and allowing inline code generation results in significantly better codegen than a plain function call.

### Function builtins

Function builtins would be an instance of `WebAssembly.Function` and have a function type. One conceptualization is that they are a WebAssembly function on the outside and a JavaScript function on the inside. This combination allows efficient adaptation of primitives.

Their behavior would be defined using algorithmic steps similar to the WebIDL or EcmaScript standards. If possible, we could define them using equivalent JavaScript source code to emphasize that these do not provide any new abilities.

### Type builtins

Type builtins would be an instance of the `WebAssembly.Type` interface provided by the [type-imports](https://github.com/webassembly/type-imports) proposal. The values contained in a type builtin would be specified with a predicate.

## JS String Builtin API

The following is an initial set of function builtins for JavaScript String. They are defined on a `String` namespace in `WebAssembly` namespace. Each example includes pseudo-code illustrating their operation and some descriptive text.

TODO: formalize these better.

[1]: This is meant to refer to what the original String.fromCharCode / String.fromCodePoint / String.prototype.charCodeAt / String.prototype.codePointAt / String.prototype.substring would do, in the absence of any monkey-patching. In a final version of this specification, we'll have to use more robust phrasing to express that; in the meantime, the given phrasing is more readable.

[2]: "array.length" is meant to express "load the array's length", in Wasm terms: (array.len (local.get $array)).

[3]: “trap” is meant to emit a wasm trap. This results in a WebAssembly.RuntimeError with the bit set that it is not catchable by exception handling.

### WebAssembly.String.fromWtf16Array

```
func fromWtf16Array(
  array: (ref null (array i16)),
  start: i32,
  end: i32
) -> (ref extern)
{
  start = ToUint32(start);
  end = ToUint32(end);

  // [2]
  if (end > array.length || start > end)
    trap;

  let result = "";
  for(let i = start; i < end; i++) {
    // [1], [4]
    result += String.fromCharCode(array[i]);
  }
  return result;
}
```

[4]: "array[i]" is meant to express "load the i-th element of the array", in Wasm terms: (array.get_u $i16-array-type (local.get $array) (local.get $i)) for an appropriate $i16-array-type.

Note: This function takes an i16 array defined in its own recursion group. If this is an issue for a toolchain, we can look into how to relax the function type while still maintaining good performance.

### WebAssembly.String.fromWtf8Array

```
func fromWtf8Array(
  array: (ref null (array i8)),
  start: i32,
  end: i32
) -> (ref extern)
{
  start = ToUint32(start);
  end = ToUint32(end);

  // [2]
  if (end > array.length || start > end)
    trap;

  // This summarizes as: "decode the WTF-8 string stored at array[start:end],
  // or trap if there is no valid WTF-8 string there".
  let result = "";
  while (start < end) {
    if there is no valid wtf8-encoded code point at array[start]
      trap;
    let c be the code point at array[start];
    // [1]
    result += String.fromCodePoint(c);
    increment start by as many bytes as it took to decode c;
  }
  return result;
}
```

Note to implementers: while this is the only usage of WTF-8 in this document, it shouldn't be very burdensome to implement, because all existing strings in Wasm modules (import/export names, contents of the name section) are already in UTF-8 format, so implementations must already have decoding infrastructure for that. We need the relaxation from UTF-8 to WTF-8 to support WTF-16 based source languages, which may have unpaired surrogates in string constants in existing/legacy code.

### WebAssembly.String.toWtf16Array

"start" is the index in the array where the first codeunit of the string will be written.

Returns the number of codeunits written. Traps if the string doesn't fit into the array.

```
func toWtf16Array(
  string: externref,
  array: (ref null (array (mut i16))),
  start: i32
) -> i32
{
  if (typeof string !== "string")
    trap;

  start = ToUint32(start);

  if (start + string.length > array.length)
    trap;

  for (let i = 0; i < string.length; i++) {
    // [4], [5]
    array[start + i] = string.charCodeAt(i);
  }
  return string.length;
}
```

[4]: "array[i] = …" is meant to express "store the value … as the i-th element of the array", in Wasm terms: (array.set $i16-array-type (local.get $array) (local.get $i) (…)) for an appropriate $i16-array-type.

### WebAssembly.String.fromCharCode

```
func fromCharCode(
  charCode: i32
) -> (ref extern)
{
  charCode = ToUint32(charCode);
  return String.fromCharCode(charCode);  // [1], [4]
}
```
[4]: Any charCode > 0xFFFF values are implicitly truncated.

### WebAssembly.String.fromCodePoint

```
func fromCodePoint(
  codePoint: i32
) -> (ref extern)
{
  codePoint = ToUint32(codePoint);
  if (codePoint > 0x10FFFF)
    trap;

  return String.fromCodePoint(codePoint);  // [1]
}
```

### WebAssembly.String.charCodeAt

```
func charCodeAt(
  string: externref,
  index: i32
) -> i32
{
  if (typeof string !== "string")
    trap;

  index = ToUint32(index);
  if (index >= string.length)
    trap;

  return string.charCodeAt(index);  // [1]
}
```

### WebAssembly.String.codePointAt

```
func codePointAt(
  string: externref,
  index: i32
) -> i32
{
  if (typeof string !== "string")
    trap;

  index = ToUint32(index);
  if (index >= string.length)
    trap;

  return string.codePointAt(index);  // [1]
}
```

### WebAssembly.String.length

```
func length(string: externref) -> i32 {
  if (typeof string !== "string")
    trap;

  return string.length;
}
```

### WebAssembly.String.concatenate

```
func concatenate(
  first: externref,
  second: externref
) -> externref
{
  if (typeof first !== "string")
    trap;
  if (typeof second !== "string")
    trap;

  return first + second;
}
```

### WebAssembly.String.substring

```
func substring(
  string: externref,
  startIndex: i32,
  endIndex: i32
) -> (ref extern)
{
  if (typeof string !== "string")
    trap;

  startIndex = ToUint32(startIndex);
  endIndex = ToUint32(endIndex);
  if (startIndex > string.length ||
      startIndex > endIndex)
    return "";

  // [1]
  return string.substring(startIndex, endIndex);
}
```

Note: We could consider allowing negative start/end indices, and adding them to the string's length to compute the effective indices, like String.prototype.slice does it. Is one of these behaviors more convenient for common use cases? Arguably it is more fitting with Wasm's style to only accept obviously-valid (i.e. in-bounds) parameters, and leave it to calling code to decide whether other values (positive out-of-bounds and/or negative) can occur at all, and if yes, how to handle them (map into bounds somehow, or reject).
Note: Taking that thought one step further, we could consider throwing exceptions when startIndex > endIndex or startIndex > string.length or endIndex > string.length. If we do so, we should keep in mind that allowing empty slices (startIndex == endIndex) can be useful when this situation arises dynamically in string-processing algorithms. It is unlikely that throwing instead of returning an empty string in these cases would offer performance benefits.

### WebAssembly.String.equals

```
func equals(
  first: externref,
  second: externref
) -> i32
{
  if (first !== null && typeof first !== "string")
    trap;
  if (second !== null && typeof second !== "string")
    trap;
  return first === second ? 1 : 0;
}
```

### WebAssembly.String.compare

```
function compare(
  first: externref,
  second: externref
) -> i32
{
  if (typeof first !== "string")
    trap;
  if (typeof second !== "string")
    trap;

  if (first === second)
    return 0;
  return first < second ? -1 : 1;
}
```
