# Preliminary Benchmark

We are benchmarking 2 similar wasm modules, all exporting a 'test' function:

- vanilla: Execute a loop many times doing some arithmetic, with a very unlikely
  if branch in the middle of the loop
- branch hinting proposal: Same, but includes a metadata.code.branch_hint section with a hint that that if is unlikely

## Prerequisites

You need:

- This version of V8: https://github.com/yuri91/v8/tree/branch_hinting
- This version of Wabt: https://github.com/yuri91/wabt/tree/metadata

## Files

- `test.js`: Load the wasm modules and run benchmarks
- `test.wat`: Benchmark code in text formata

### compile to wasm

compile vanilla version:

```
wat2wasm test.wat --enable-annotations -o test.wasm
```

compile branch hinted version:

```
wat2wasm test.wat --enable-annotations --enable-code-metadata -o test_hint.wasm
```

### run the benchmark

`$D8_PATH/d8 --experimental-wasm-branch-hinting test.js`

Useful d8 options:
- `--print-wasm-code` to see the generated assembly code

