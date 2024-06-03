# GC MVP JS API

This document describes the proposed changes to the
[WebAssembly JS API spec](http://webassembly.github.io/spec/js-api/) that are
associated with the [changes to the WebAssembly core spec](MVP.md).

## Goals

The goal of the MVP JS API is to be as simple as possible, providing just enough
expressivity to serve as the foundation for interop between JS and Wasm GC.
Making it easy to access, manipulate, and extend Wasm GC objects from
hand-written JS is left as future work. For now, require using the established
pattern of exporting accessor functions to interact with Wasm data from JS.

## Explanation

WebAssembly GC objects are exposed to JS via opaque exotic object wrappers. The
wrapper object internally holds a reference to the underlying WasmGC object to
facilitate identity-preserving round-tripping from WebAssembly to JS and back.
The wrapper object serves only to opaquely reference the underlying WebAssembly
value and does not support inspecting or modifying the value in any way. The
wrapper object also cannot be extended with new JS properties. The wrapper
objects supports the following JS operations:

 - `GetPrototypeOf`: returns `null`.
 - `SetPrototypeOf`: returns `false` (and does not set a prototype).
 - `IsExtensible`: returns `false`.
 - `PreventExtensions`: returns `false`.
 - `GetOwnProperty`: returns `undefined`.
 - `DefineOwnProperty`: returns `false`.
 - `HasProperty`: returns `false`.
 - `Get`: returns `undefined`.
 - `Set`: throws a `TypeError`.
 - `Delete`: throws a `TypeError`.
 - `OwnPropertyKeys`: returns an empty list.

These operations may be extended in the future to support more useful ways of
interacting with Wasm GC objects from JS.

When a non-null internal reference value (i.e. a value with of any subtype of
`anyref`) is passed out to JS, the `ToJSValue` algorithm will implicitly call
`extern.externalize` on it to get a JS value. Similarly, when a JS value is
passed into WebAssembly in a location that expects an internal reference, the
`ToWebAssemblyValue` algorithm will implicitly call `extern.internalize` on it
to get an internal reference. `ToWebAssemblyValue` will then cast the internal
reference to the specific expected type, and if that fails, it will throw a
`TypeError`. JS `null` converts to and is converted from WebAssembly `null`
values.

In JS hosts, `extern.internalize` will behave differently depending on the JS
value that is being internalized:

 - If the value is a number and is an integer in signed i31 range, it will be
   converted to an i31 reference.
 - If the value is a wrapper for an exported GC object, the wrapped internal
   reference is returned.
 - Otherwise if it is some other JS value, it will be internalized as an opaque
   reference that cannot be downcast from anyref.

Similarly, `extern.externalize` will behave differently depending on the
internal reference value that is being externalized:

 - If the value is an i31 reference, convert it to a JS number.
 - If the value is a struct or array reference, create a JS wrapper for it,
   reusing any pre-existing wrapper to ensure bidirectional identity
   preservation.
 - Otherwise if the reference is an internalized host reference, return the
   original external host reference.

_TODO: avoid having to patch the behavior of `extern.internalize` and
`extern.internalize` by converting to/from JS numbers separately._

## Implementation-defined Limits

The following limits will be added to the Implementation-defined Limits
[section](https://webassembly.github.io/spec/js-api/index.html#limits) of the JS
API.

 - The maximum number of recursion groups is 1000000. (The maximum number of
   individual types remains unchanged and is also 1000000.)
 - The maximum number of struct fields is 10000.
 - The maximum number of operands to `array.new_fixed` is 10000.
 - The maximum length of a supertype chain is 63. (A type declared with no
   supertypes has a supertype chain of length 0)
