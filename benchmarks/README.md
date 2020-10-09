# Preliminary Benchmark

Idea: use `br_on_null` to "simulate" the branch hinting instruction.
This works because currently v8 assumes that the branch will not be taken when it
encounters a `br_on_null`, and puts the target of the branch in a "deferred" block
(if the `br_on_null` is the only way to reach the target).

The result is similar to what we expect a `branch_hint` instruction before a normal branch would do.

This simple test case features a hot loop with a condition in the middle which is almost always false.
It is around 30% faster when using `br_on_null`, compared to a normal `br_if`.

Since standard tools like wat2wasm don't work with `br_on_null` yet, the binary wasm had to be manually patched
to make the optimized version.

## Files

- `test.js`: Loader, passes 1 import to the wasm module
- `test.wat`: Text representation for the non-optimized version
- `test.wasm`: wat2wasm of test.wat
- `test_brnull.wasm`: Manually modified test.wasm to use br_on_null
	- Locals have been changed from i32/i64/f64 -> i32/optref 0
		- The number of locals have decreased from 3 -> 2
		- The optref local require 1 "memory index", not sure what that actually does
		- The optref is null-initialized, we can then use br_on_null which is guaranteed to be taken
	- The pointless block + branch in the original code is converted to br_on_null
		- The idea is to make the "deferred" block reachable only by br_on_null

test.js will run test.wasm by default, you can edit the file to run the optimized version

$D8_PATH/d8 --experimental-wasm-gc --experimental-wasm-typed_funcref test.js

Useful d8 options:
	- --print-wasm-code to see the generated assembly code
	- --trace-wasm-ast-end=100 to dump the AST of the wasm file, since normal dump tools do not work with br_on_null
