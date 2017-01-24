This directory contains tests specific to the JavaScript API to WebAssembly, as
described in [JS.md](https://github.com/WebAssembly/design/blob/master/JS.md).

## Harness

These tests can be run in a pure JS environment (JS shell), provided a few
libraries and functions emulating the
[testharness.js](http://testthewebforward.org/docs/testharness-library.html)
library.

- The `../lib/index.js`, `../lib/wasm-constants.js` and
  `../lib/wasm-module-builder.js` must be imported first.
- A function `test(function, description)` that tries to run the function under
  a try/catch and maybe asserts in case of failure.
- A function `promise_test(function, description)` where `function` returns a
  `Promise` run by `promise_test`; a rejection means a failure here.
- Assertion functions: `assert_equals(x, y)`, `assert_true(x)`,
  `assert_false(x)`, `assert_unreached()`.
