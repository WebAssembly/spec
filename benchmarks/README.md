# Preliminary Benchmark

We are benchmarking 2 similar wasm modules, all exporting a 'test' function:

- vanilla: Execute a loop many times doing some arithmetic, with a very unlikely
  if branch in the middle of the loop
- branch hinting proposal: Same, but includes a brancHints section with a hint that that if is unlikely


## Files

- `test.js`: Load the wasm modules and run benchmarks
- `test.wat`: Text representation for the vanilla version
- `test.wasm`: wat2wasm of test.wat
- `test_hint.wasm`: Manually modified test.wasm to use branch hinting

run the benchmark:

`$D8_PATH/d8 test.js`

Useful d8 options:
- `--print-wasm-code` to see the generated assembly code

NOTE: In order to run the branch hinting version, you need a modified v8 (see [this repo](https://github.com/yuri91/v8)).
