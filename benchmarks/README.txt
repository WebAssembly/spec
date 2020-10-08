test.js - Loader, passes 1 import to the wasm module
test.wat - Text representation for the non-optimized version
test.wasm - wat2wasm of test.wat
test_brnull.wasm - Manually modified test.wasm to use br_on_null
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
