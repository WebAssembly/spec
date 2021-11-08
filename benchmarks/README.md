# Preliminary Benchmark

We are benchmarking 2 similar wasm modules, all exporting a 'test' function:

- vanilla: Execute a loop many times doing some arithmetic, with a very unlikely
  if branch in the middle of the loop
- branch hinting proposal: Same, but includes a brancHints section with a hint that that if is unlikely


## Files

- `test.js`: Load the wasm modules and run benchmarks
- `test.wat`: Text representation for the vanilla version
- `test.wasm`: `wat2wasm test.wat -o test.wasm`
- `test_hint.wasm`: `wat2wasm --enable-code-annotations --enable-annotations test_hint.wat -o test_hint.wasm`

run the benchmark:

`$D8_PATH/d8 --experimental-wasm-branch-hinting test.js`

Useful d8 options:
- `--print-wasm-code` to see the generated assembly code

