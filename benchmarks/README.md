# Preliminary Benchmark

We are benchmarking 3 similar wasm modules, all exporting a 'test' function:

- vanilla: Execute a loop many times doing some arithmetic, with a very unlikely
  if branch in the middle of the loop
- branch hinting proposal: Same, but use a branch hinting instruction to signal that
  the branch is unlikely
- br_on_null hack: similar to the previous one, but does not require a modified v8,
  because the br_on_null instruction already considers the null case unlikely. This requires some extra code to setup the branch compared to the branch hinting proposal

Since standard tools like wat2wasm don't work with `br_on_null` yet, let alone branch hinting, the modules had to be manually patched to make the optimized versions.

## Files

- `test.js`: Load the wasm modules and run benchmarks
- `test.wat`: Text representation for the vanilla version
- `test.wasm`: wat2wasm of test.wat
- `test_brnull.wasm`: Manually modified test.wasm to use br_on_null
- `test_hint.wasm`: Manually modified test.wasm to use branch hinting (temporary opcode 0x16)

run the benchmark:

`$D8_PATH/d8 --experimental-wasm-gc --experimental-wasm-typed_funcref test.js`

Useful d8 options:
	- --print-wasm-code to see the generated assembly code
	- --trace-wasm-ast-end=100 to dump the AST of the wasm file, since normal dump tools do not work with br_on_null

NOTE: In order to run the branch hinting version, you need a modified v8 (see [this repo](https://github.com/yuri91/v8/tree/branch_hinting)).

If you don't want to do that, just comment that entry and test only the br_on_null version (results are similar but a bit worse due to the extra overhead).
