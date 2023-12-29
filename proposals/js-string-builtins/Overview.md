# JS String Builtins

## Motivation

JavaScript runtimes have a rich set of [builtin objects and primitives](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects). Some languages targeting WebAssembly may have compatible primitives and would benefit from being able to use the equivalent JavaScript primitive for their implementation. The most pressing use-case here is for languages who would like to use the JavaScript String type to implement their strings.

It is already possible to use any JavaScript or Web API from WebAssembly by importing JavaScript 'glue code' which adapts between JavaScript and WebAssembly values and calling conventions. Usually, this has a negligible performance impact and work has been done to optimize this [in runtimes when we can](https://hacks.mozilla.org/2018/10/calls-between-javascript-and-webassembly-are-finally-fast-%F0%9F%8E%89/).

However, the overhead of importing glue code is prohibitive for primitives such as Strings, ArrayBuffers, RegExp, Map, and BigInt where the desired overhead of operations is a tight sequence of inline instructions, not an indirect function call (which is typical of imported functions).

## Overview

This proposal aims to provide a minimal and general mechanism for importing specific JavaScript primitives for efficient usage in WebAssembly code.

This is done by first adding a set of wasm builtin functions for performing JavaScript String operations. These builtin functions mirror a subset of the [JavaScript String API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) and adapt it to be efficiently callable without JavaScript glue code.

Then a mechanism for importing these wasm builtin functions is added to the WebAssembly JS-API. These builtins are grouped in modules and exist in a new reserved import namespace `wasm:` that is enabled at compile-time with a flag.

These two pieces in combination allow runtimes to reliably emit optimal code sequences for JavaScript String operations within WebAssembly modules. In the future, other JS builtin objects or JS primitives can be exposed through new wasm builtins.

## Do we need new wasm builtin functions?

It is already possible today to import JS builtin functions (such as String.prototoype.getCharCodeAt) from wasm modules. Instead of defining new wasm specific-builtins, we could just re-use those directly.

There are several problems with this approach.

The first problem is that existing API’s require a calling convention conversion to handle differences around the `this` value, which WebAssembly function import calls leave as `undefined`. The second problem is that certain primitive use JS operators such as `===` and `<` that cannot be imported. A third problem is that most JS builtins are extremely permissive of the types of values they accept, and it's desirable to leverage wasm's type system to remove those checks and coercions wherever we can.

It seems that creating new importable definitions that adapt existing JS primitives to WebAssembly is simpler and more flexible in the future.

## Do we need a new import mechanism for wasm builtin functions?

There is a variety of execution techniques for WebAssembly. Some WebAssembly engines compile modules eagerly (at WebAssembly.compile), some use interpreters and dynamic tiering, and some use on-demand compilation (after instantiation) and dynamic tiering.

If we just have builtin functions, it would be possible to normally import them normally through instantiation. However this would prevent engines from using eager compilation when builtins are in use.

It seems desirable to support a variety of execution techniques, especially because engines may support multiple depending on heuristics or change them over time.

By adding builtins that are in a reserved and known namespace (`wasm:`), engines can know that these builtin functions are being used at `WebAssembly.compile` time and generate optimal code for them.

## Goals for builtins

Builtins should not provide any new abilities to WebAssembly that JS doesn't already have. They are intended to just wrap existing primitives in such a manner that WebAssembly can efficiently use them. In the cases the primitive already has a name, we should re-use it and not invent a new one.

The standardization of wasm builtins will be governed by the WebAssembly standards process and would exist in the JS-API document.

The bar for adding a new builtin would be that it enables significantly better code generation for an important use-case beyond what is possible with a normal import. We don't want to add a new builtin for every existing API, only ones where adapting the JavaScript API to WebAssembly and allowing inline code generation results in significantly better codegen than a plain function call.

## Function builtins

Function builtins are defined with an external wasm function type, and internal JS-defined behavior. They have the same semantics as following ['create a host function'](https://webassembly.github.io/spec/js-api/#create-a-host-function) for the wasm function type and JS code given to get a wasm `funcaddr` that can be imported.

There are several implications of this:
  - Calling a function builtin from wasm will have the wasm parameters converted to JS values, and JS results converted back to wasm values.
  - Exported function builtins are wrapped using ['create a new Exported function'](https://webassembly.github.io/spec/js-api/#a-new-exported-function).
  - Function builtins must be imported with the correct type.
  - Function builtins may become `funcref`, stored in tables, etc.

## Type builtins

Type builtins could be an instance of the `WebAssembly.Type` interface provided by the [type-imports](https://github.com/webassembly/type-imports) proposal. The values contained in a type builtin would be specified with a predicate.

This proposal does not add any type builtins, as the design around type-imports is in flux.

## Using builtins

Every builtin has a name, and builtins are grouped into collections with a name that matches the interface they are mirroring.

An example import specifier could therefore be `(import "wasm:js-string" "equals" ...)`.

The JS-API does not reserve a `wasm:` namespace today, so modules theoretically could already be using this namespace. Additionally, some users may wish to disable this feature for modules they compile so they could polyfill it. This feature is therefore opt-in via flags for each interface.

To just enabled `js-string` builtins, a user would compile with:
```
WebAssembly.compile(bytes, { builtins: ['js-string'] });
```

The full extension to the JS-API WebIDL is:
```
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
};
```

A wasm module that has enabled builtins will have the specific import specifier, such as `wasm:js-string` for that interface available and eagerly applied.

Concretely this means that imports that refer to that specifier will be eagerly checked for link errors at compile time, those imports will not show up in `WebAssembly.Module.imports()`, and those imports will not need to be provided at instantiation time.

When the module is instantiated, a unique instantiation of the builtins are created. This means that re-exports of builtin functions will have different identities if they come from different instances. This is a useful property for future extensions to bind memory to builtins or evolve the types as things like type-imports or a core stringref type are added (see below).

## Feature detection

Users may wish to detect if a specific builtin is available in their system.

For this purpose, `WebAssembly.validate` is extended to take a list of builtins to enable, like compile does. After validating the module, the eager link checking that compile does is also performed. Users can inspect the result of validate on modules importing builtins to see if they are supported.

## Polyfilling

If a user wishes to polyfill these imports for some reason, or is running on a system without a builtin, these imports may be provided as normal through instantiation.

## JS String Builtin API

The following is an initial set of function builtins for JavaScript String. The builtins are exposed under `wasm:js-string`.

All below references to builtins on the Global object (e.g. `String.fromCharCode`) refer to the original version on the Global object before any modifications by user code.

The following internal helpers are defined in wasm and used by the below definitions:

```wasm
(module
  (type $array_i16 (array i16))
  (type $array_i16_mut (array (mut i16)))

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
  (func (export "array_i16_mut_set") (param (ref $array_i16_mut) i32 i32)
    local.get 0
    local.get 1
    local.get 2
    array.set $array_i16_mut
  )
)
```

### "wasm:js-string" "cast"

```
func cast(
  string: externref
) -> (ref extern) {
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
  if (string === null ||
      typeof string !== "string")
    return 0;
  return 1;
}
```

### "wasm:js-string" "fromWtf16Array"

```
/// Convert the specified range of an immutable i16 array into a String,
/// treating each i16 as an unsigned 16-bit char code.
///
/// The range is given by [start, end). This function traps if the range is
/// outside the bounds of the array.
///
/// NOTE: This function only takes an immutable i16 array defined in its own
/// recursion group.
///
/// If this is an issue for toolchains, we can look into how to relax the
/// function type while still maintaining good performance.
func fromWtf16Array(
  array: (ref null (array i16)),
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

### "wasm:js-string" "fromWtf8Array"

```
/// Convert the specified range of an immutable i8 array into a String,
/// treating the array as encoded using WTF-8.
///
/// The range is given by [start, end). This function traps if the range is
/// outside the bounds of the array.
///
/// NOTE: This function only takes an immutable i8 array defined in its own
/// recursion group.
///
/// If this is an issue for toolchains, we can look into how to relax the
/// function type while still maintaining good performance.
func fromWtf8Array(
  array: (ref null (array i8)),
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

  // This summarizes as: "decode the WTF-8 string stored at array[start:end],
  // or trap if there is no valid WTF-8 string there".
  let result = "";
  while (start < end) {
    if there is no valid wtf8-encoded code point at array[start]
      trap();
    let c be the code point at array[start];
    // [1]
    result += String.fromCodePoint(c);
    increment start by as many bytes as it took to decode c;
  }
  return result;
}
```

Note to implementers: while this is the only usage of WTF-8 in this document, it shouldn't be very burdensome to implement, because all existing strings in Wasm modules (import/export names, contents of the name section) are already in UTF-8 format, so implementations must already have decoding infrastructure for that. We need the relaxation from UTF-8 to WTF-8 to support WTF-16 based source languages, which may have unpaired surrogates in string constants in existing/legacy code.

### "wasm:js-string" "toWtf16Array"

```
/// Copy a string into a pre-allocated mutable i16 array at `start` index.
///
/// Returns the number of char codes written, which is equal to the length of
/// the string.
///
/// Traps if the string doesn't fit into the array.
func toWtf16Array(
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

  if (string === null ||
      typeof string !== "string")
    trap();

  // The following addition is safe from overflow as adding two 32-bit integers
  // cannot overflow Number.MAX_SAFE_INTEGER (2^53-1).
  if (start + string.length > array_len(array))
    trap();

  for (let i = 0; i < string.length; i++) {
    let charCode = string.charCodeAt(i);
    array_i16_mut_set(array, start + i, charCode);
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
) -> externref
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

  if (string === null ||
      typeof string !== "string")
    trap();

  // Ensure the range is ordered and within bounds to avoid the complex
  // behavior that `substring` performs when that is not the case.
  if (start > end ||
      end > string.length)
    return "";

  // [1]
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

## Future extensions

There are several extensions we can make in the future as need arrives.

### Binding memory to builtins

It may be useful to have a builtin that operates on a specific wasm memory. For JS strings, this could allow us to encode a JS string directly into linear memory.

One way we could do this, is by having the JS-API bind the first imported memory of a module to any imported builtin functions that want to operate on memory. If there is no imported memory and a builtin function that needs memory is imported, then a link error is reported.

The memory is imported as opposed to exported so that it is guaranteed to exist when the builtin imports are provided. Using a memory defined only locally would have limited flexibility and would also be exposing a potentially private memory to outside its module.

A quick example:
```
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

### UTF-8 and WTF-8 support

There are no JS builtins available to get a UTF-8 or WTF-8 view of a JS String.

One option would be to specify wasm builtins in terms of the Web TextEncoder and TextDecoder interfaces. But this is probably a 'layering' violation, and is not clear what this means on JS runtimes outside the web.

Another option around this would be to directly refer to the UTF-8/WTF-8 specs in the JS-API and write out the algorithms we need. However, this probably violates the goal of not creating a new String API.

A final option would be to get TC39 to add the methods we need to JS Strings, so that we can use them in wasm builtins. This could take some time though, and may not be possible if TC39 does not find these methods worthwile.

This needs more thought and discussion.
