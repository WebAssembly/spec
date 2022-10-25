## Implementation in LLVM and various engines

| Instruction                           | LLVM [1]       | V8 [2]             | SpiderMonkey [3]   |
|---------------------------------------|----------------|--------------------|--------------------|
| `i8x16.relaxed_swizzle`               | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.relaxed_trunc_f32x4_s`         | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.relaxed_trunc_f32x4_u`         | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.relaxed_trunc_f64x2_s_zero`    | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.relaxed_trunc_f64x2_u_zero`    | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.relaxed_madd`                  | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.relaxed_nmadd`                 | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.relaxed_madd`                  | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.relaxed_nmadd`                 | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i8x16.relaxed_laneselect`            | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.relaxed_laneselect`            | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i32x4.relaxed_laneselect`            | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i64x2.relaxed_laneselect`            | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.relaxed_min`                   | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f32x4.relaxed_max`                   | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.relaxed_min`                   | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `f64x2.relaxed_max`                   | -mrelaxed-simd | :heavy_check_mark: | :heavy_check_mark: |
| `i16x8.relaxed_q15mulr_s`             | -mrelaxed-simd |                    |                    |
| `i16x8.relaxed_dot_i8x16_i7x16_s`     | -mrelaxed-simd |                    |                    |
| `i32x4.relaxed_dot_i8x16_i7x16_add_s` | -mrelaxed-simd |                    |                    |
| `f32x4.relaxed_dot_bf16x8_add_f32x4`  | -mrelaxed-simd |                    |                    |


[1] Tip of tree LLVM as of 2021-10-28

[2] V8 9.7.75 (only implemented on x64)

[3] SpiderMonkey as of 2021-10-18 implemented on x86, x64 and Aarch64

## Name of builtins in LLVM

| Instruction                           | LLVM                                              |
|---------------------------------------|---------------------------------------------------|
| `i8x16.relaxed_swizzle`               | `__builtin_wasm_relaxed_swizzle_i8x16`            |
| `i32x4.relaxed_trunc_f32x4_s`         | `__builtin_wasm_relaxed_trunc_s_i32x4_f32x4`      |
| `i32x4.relaxed_trunc_f32x4_u`         | `__builtin_wasm_relaxed_trunc_u_i32x4_f32x4`      |
| `i32x4.relaxed_trunc_f64x2_s_zero`    | `__builtin_wasm_relaxed_trunc_zero_s_i32x4_f64x2` |
| `i32x4.relaxed_trunc_f64x2_u_zero`    | `__builtin_wasm_relaxed_trunc_zero_u_i32x4_f64x2` |
| `f32x4.relaxed_madd`                  | `__builtin_wasm_fma_f32x4`                        |
| `f32x4.relaxed_nmadd`                 | `__builtin_wasm_fnma_f32x4`                       |
| `f64x2.relaxed_madd`                  | `__builtin_wasm_fma_f64x2`                        |
| `f64x2.relaxed_nmadd`                 | `__builtin_wasm_fnma_f64x2`                       |
| `i8x16.relaxed_laneselect`            | `__builtin_wasm_laneselect_i8x16`                 |
| `i16x8.relaxed_laneselect`            | `__builtin_wasm_laneselect_i16x8`                 |
| `i32x4.relaxed_laneselect`            | `__builtin_wasm_laneselect_i32x4`                 |
| `i64x2.relaxed_laneselect`            | `__builtin_wasm_laneselect_i64x2`                 |
| `f32x4.relaxed_min`                   | `__builtin_wasm_relaxed_min_f32x4`                |
| `f32x4.relaxed_max`                   | `__builtin_wasm_relaxed_max_f32x4`                |
| `f64x2.relaxed_min`                   | `__builtin_wasm_relaxed_min_f64x2`                |
| `f64x2.relaxed_max`                   | `__builtin_wasm_relaxed_max_f64x2`                |
| `i16x8.relaxed_q15mulr_s`             | `__builtin_wasm_relaxed_q15mulr_s_i16x8`          |
| `i16x8.relaxed_dot_i8x16_i7x16_s`     | `__builtin_wasm_dot_i8x16_i7x16_s_i16x8`          |
| `i32x4.relaxed_dot_i8x16_i7x16_add_s` | `__builtin_wasm_dot_i8x16_i7x16_add_s_i32x4`      |
| `f32x4.relaxed_dot_bf16x8_add_f32x4`  | `__builtin_wasm_relaxed_dot_bf16x8_add_f32_f32x4` |
