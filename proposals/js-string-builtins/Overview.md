# JS String Builtins

## Motivation

JavaScript runtimes have a rich set of [builtin objects and primitives](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects). Some languages targeting WebAssembly may have compatible primitives and would benefit from being able to use the equivalent JavaScript primitive for their implementation. The most pressing use-case here is for languages who would like to use the JavaScript String type to implement their strings.

It is already possible to use any JavaScript or Web API from WebAssembly by importing JavaScript 'glue code' which adapts between JavaScript and WebAssembly values and calling conventions. Usually, this has a negligible performance impact and work has been done to optimize this [in runtimes when we can](https://hacks.mozilla.org/2018/10/calls-between-javascript-and-webassembly-are-finally-fast-%F0%9F%8E%89/).

However, the overhead of importing glue code is prohibitive for primitives such as Strings, ArrayBuffers, RegExp, Map, and BigInt where the desired overhead of operations is a tight sequence of inline instructions, not an indirect function call (which is typical of imported functions).

## Overview

This proposal aims to provide a minimal and general mechanism for importing specific JavaScript primitives for efficient usage in WebAssembly code.

This is done by first adding a set of builtin functions for performing JavaScript String operations. These builtin functions mirror a subset of the [JavaScript String API](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String) and adapt it to be efficiently callable without JavaScript glue code.

Then a mechanism for importing modules containing these builtins (builtin modules) is added to the WebAssembly JS-API. These modules exist in a new reserved import namespace `wasm:` that is enabled at compile-time with a flag.

These two pieces in combination allow runtimes to reliably emit optimal code sequences for JavaScript String operations within WebAssembly modules. In the future, other builtin objects or primitives can be exposed through new builtins.

## Do we need builtins?

It is already possible today to import JS builtin functions (such as String.prototoype.getCharCodeAt) from wasm modules. Instead of defining new wasm specific-builtins, we could just re-use those directly.

There are several problems with this approach.

The first problem is that existing API’s require a calling convention conversion to handle differences around the `this` value, which WebAssembly function import calls leave as `undefined`. The second problem is that certain primitive use JS operators such as `===` and `<` that cannot be imported. A third problem is that most JS builtins are extremely permissive of the types of values they accept, and it's desirable to leverage wasm's type system to remove those checks and coercions wherever we can.

It seems that creating new importable definitions that adapt existing JS primitives to WebAssembly is simpler and more flexible in the future.

## Do we need builtin modules?

There is a variety of execution techniques for WebAssembly. Some WebAssembly engines compile modules eagerly (at WebAssembly.compile), some use interpreters and dynamic tiering, and some use on-demand compilation (after instantiation) and dynamic tiering.

If we just have builtin functions, it would be possible to normally import them without any work to add builtin modules. The main issue is that imported values are not known until instantiation, and so engines that compile eagerly would be unable to generate specialized code to these imports.

It seems desirable to support a variety of execution techniques, especially because engines may support multiple depending on heuristics or change them over time.

By adding builtin modules that are in a reserved and known namespace `:wasm`, engines can know that these builtin functions are being used at `WebAssembly.compile` time and generate optimal code for them.

## Goals for builtins

Builtins should not provide any new abilities to WebAssembly that JS doesn't already have. They are intended to just wrap existing primitives in such a manner that WebAssembly can efficiently use them. In the cases the primitive already has a name, we should re-use it and not invent a new one.

The standardization of wasm builtins will be governed by the WebAssembly standards process and would exist in the JS-API document.

The bar for adding a new builtin would be that it enables significantly better code generation for an important use-case beyond what is possible with a normal import. We don't want to add a new builtin for every existing API, only ones where adapting the JavaScript API to WebAssembly and allowing inline code generation results in significantly better codegen than a plain function call.

## Function builtins

Function builtins are an instance of `WebAssembly.Function` and have a function type. One conceptualization is that they are a WebAssembly function on the outside and a JavaScript function on the inside. This combination allows efficient adaptation of primitives.

Their behavior would be defined using algorithmic steps similar to the WebIDL or EcmaScript standards. If possible, we could define them using equivalent JavaScript source code to emphasize that these do not provide any new abilities.

## Type builtins

Type builtins could be an instance of the `WebAssembly.Type` interface provided by the [type-imports](https://github.com/webassembly/type-imports) proposal. The values contained in a type builtin would be specified with a predicate.

## Builtin modules

Builtin modules provide a collection of function or type builtins that can be imported. Each builtin module has a name, such as `js-string`, and lives under the `wasm:` namespace. A full import specifier would therefore be `(import "wasm:js-string" "equals" ...)`.

The JS-API does not reserve a `wasm:` namespace today, so modules theoretically could already be using this namespace. Additionally, some users may wish to disable this feature for modules they compile so they could polyfill it. This feature is therefore opt-in on an individual builtin-module basis.

To just enabled the `js-string` module, a user would compile with:
```
WebAssembly.compile(bytes, { builtinModules: ['js-string'] });
```

The full extension to the JS-API WebIDL is:
```
dictionary WebAssemblyCompileOptions {
    optional sequence<USVString> builtinModules;
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

A wasm module that has enabled a wasm builtin module will have the specific import specifier, such as `wasm:js-string` for that module available and eagerly applied.

Concretely this means that imports that refer to that specifier will be eagerly checked for link errors at compile time, those imports will not show up in `WebAssembly.Module.imports()`, and those imports will not need to be provided at instantiation time.

When the module is instantiated, a unique instantiation of the builtin module is created. This means that re-exports of builtin functions will have different identities if they come from different instances. This is a useful property for future extensions to bind memory to builtins or evolve the types as things like type-imports or a core stringref type are added (see below).

## Feature detection

Users may wish to detect if a specific builtin module is available in their system.

A simple option is to add `WebAssembly.hasBuiltinModule(name)` method. This is likely too coarse grained though, users may wish to know if a specific function in a builtin module is available, as new ones may be added over time.

A more general option would then be to extend `WebAssembly.validate` to also take a list of builtin modules to enable, like compile does. After validating the module, the eager link checking that compile does is also performed. This would allow checking for the presence of individual parts of a builtin module.

## Polyfilling

If a user wishes to polyfill these imports for some reason, or is running on a system without a builtin module, these imports may be provided as normal through instantiation.

## JS String Builtin API

The following is an initial set of function builtins for JavaScript String. The builtin module name is `js-string`. Each example includes pseudo-code illustrating their operation and some descriptive text.

TODO: formalize these better.

[1]: This is meant to refer to what the original String.fromCharCode / String.fromCodePoint / String.prototype.charCodeAt / String.prototype.codePointAt / String.prototype.substring would do, in the absence of any monkey-patching. In a final version of this specification, we'll have to use more robust phrasing to express that; in the meantime, the given phrasing is more readable.

[2]: "array.length" is meant to express "load the array's length", in Wasm terms: (array.len (local.get $array)).

[3]: “trap” is meant to emit a wasm trap. This results in a WebAssembly.RuntimeError with the bit set that it is not catchable by exception handling.

### "wasm:js-string" "cast"

```
function cast(
  string: externref
) -> externref {
  if (typeof string !== "string")
    trap;
  return string;
}
```

### "wasm:js-string" "test"

```
function test(
  string: externref
) -> i32 {
  return typeof string === "string" ? 1 : 0;
}
```

### "wasm:js-string" "fromWtf16Array"

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

### "wasm:js-string" "fromWtf8Array"

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

### "wasm:js-string" "toWtf16Array"

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

### "wasm:js-string" "fromCharCode"

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

### "wasm:js-string" "fromCodePoint"

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

### "wasm:js-string" "charCodeAt"

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

### "wasm:js-string" "codePointAt"

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

### "wasm:js-string" "length"

```
func length(string: externref) -> i32 {
  if (typeof string !== "string")
    trap;

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
  if (typeof first !== "string")
    trap;
  if (typeof second !== "string")
    trap;

  return first.concat(second);
}
```

### "wasm:js-string" "substring"

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

### "wasm:js-string" "equals"

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

### "wasm:js-string" "compare"

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

  (; bound to memory 0 through the JS-API instantiating the builtin module ;)
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
