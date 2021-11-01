## Implementation in LLVM and various engines

| Instruction                        | LLVM [1]       | V8 [2]             | SpiderMonkey [3]   |
|------------------------------------|----------------|--------------------|--------------------|
| `relaxed i8x16.swizzle`            | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `relaxed i32x4.trunc_f32x4_s`      | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `relaxed i32x4.trunc_f32x4_u`      | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `relaxed i32x4.trunc_f64x2_s_zero` | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `relaxed i32x4.trunc_f64x2_u_zero` | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.fma`                        | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.fms`                        | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.fma`                        | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.fms`                        | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.laneselect`                 | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.laneselect`                 | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.laneselect`                 | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.laneselect`                 | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.min`                        | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.max`                        | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.min`                        | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.max`                        | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |

[1] Tip of tree LLVM as of 2021-10-28

[2] V8 9.7.75 (only implemented on x64)

[3] SpiderMonkey as of 2021-10-18 implemented on x86, x64 and Aarch64

## Name of builtins in LLVM

| Instruction                        | LLVM                                              |
|------------------------------------|---------------------------------------------------|
| `relaxed i8x16.swizzle`            | `__builtin_wasm_relaxed_swizzle_i8x16`            |
| `relaxed i32x4.trunc_f32x4_s`      | `__builtin_wasm_relaxed_trunc_s_i32x4_f32x4`      |
| `relaxed i32x4.trunc_f32x4_u`      | `__builtin_wasm_relaxed_trunc_u_i32x4_f32x4`      |
| `relaxed i32x4.trunc_f64x2_s_zero` | `__builtin_wasm_relaxed_trunc_zero_s_i32x4_f64x2` |
| `relaxed i32x4.trunc_f64x2_u_zero` | `__builtin_wasm_relaxed_trunc_zero_u_i32x4_f64x2` |
| `f32x4.fma`                        | `__builtin_wasm_fma_f32x4`                        |
| `f32x4.fms`                        | `__builtin_wasm_fms_f32x4`                        |
| `f64x2.fma`                        | `__builtin_wasm_fma_f64x2`                        |
| `f64x2.fms`                        | `__builtin_wasm_fms_f64x2`                        |
| `i8x16.laneselect`                 | `__builtin_wasm_laneselect_i8x16`                 |
| `i16x8.laneselect`                 | `__builtin_wasm_laneselect_i16x8`                 |
| `i32x4.laneselect`                 | `__builtin_wasm_laneselect_i32x4`                 |
| `i64x2.laneselect`                 | `__builtin_wasm_laneselect_i64x2`                 |
| `f32x4.min`                        | `__builtin_wasm_relaxed_min_f32x4`                |
| `f32x4.max`                        | `__builtin_wasm_relaxed_max_f32x4`                |
| `f64x2.min`                        | `__builtin_wasm_relaxed_min_f64x2`                |
| `f64x2.max`                        | `__builtin_wasm_relaxed_max_f64x2`                |
