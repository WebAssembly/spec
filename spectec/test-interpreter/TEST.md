# Preview

```sh
$ cd ../spec/wasm-3.0 && \
> ../../src/exe-watsup/main.exe *.watsup -v -l --interpreter ../../test-interpreter/sample.wat addTwo 30 12 2>&1
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../../test-interpreter/sample.wat =====
42
== Complete.
$ cd ../spec/wasm-3.0 && \
> ../../src/exe-watsup/main.exe *.watsup -v -l --interpreter ../../test-interpreter/sample.wasm addTwo 40 2 2>&1
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../../test-interpreter/sample.wasm =====
42
== Complete.
$ cd ../spec/wasm-3.0 && \
> ../../src/exe-watsup/main.exe *.watsup -v -l --interpreter ../../test-interpreter/sample.wast 2>&1
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../../test-interpreter/sample.wast =====
- print_i32: 10
- 30/30 (100.00%)

== Complete.
$ for v in 1 2 3; do ( \
>   echo "Running test for Wasm $v.0..." && \
>   cd ../spec/wasm-$v.0 && \
>   ../../src/exe-watsup/main.exe *.watsup -v -l --test-version $v --interpreter ../../test-interpreter/spec-test-$v \
> ) done 2>&1
Running test for Wasm 1.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../../test-interpreter/spec-test-1/address.wast =====
- 242/242 (100.00%)

===== ../../test-interpreter/spec-test-1/align.wast =====
- 73/73 (100.00%)

===== ../../test-interpreter/spec-test-1/binary-leb128.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-1/binary.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-1/block.wast =====
- 42/42 (100.00%)

===== ../../test-interpreter/spec-test-1/br.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-1/br_if.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-1/br_table.wast =====
- 147/147 (100.00%)

===== ../../test-interpreter/spec-test-1/break-drop.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-1/call.wast =====
- 62/62 (100.00%)

===== ../../test-interpreter/spec-test-1/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/comments.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-1/const.wast =====
- 638/638 (100.00%)

===== ../../test-interpreter/spec-test-1/conversions.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/conversions.wast

===== ../../test-interpreter/spec-test-1/custom.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-1/data.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/data.wast

===== ../../test-interpreter/spec-test-1/elem.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/elem.wast

===== ../../test-interpreter/spec-test-1/endianness.wast =====
- 69/69 (100.00%)

===== ../../test-interpreter/spec-test-1/exports.wast =====
- 60/60 (100.00%)

===== ../../test-interpreter/spec-test-1/f32.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/f32.wast

===== ../../test-interpreter/spec-test-1/f32_bitwise.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-1/f32_cmp.wast =====
- 2401/2401 (100.00%)

===== ../../test-interpreter/spec-test-1/f64.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/f64.wast

===== ../../test-interpreter/spec-test-1/f64_bitwise.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-1/f64_cmp.wast =====
- 2401/2401 (100.00%)

===== ../../test-interpreter/spec-test-1/fac.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-1/float_exprs.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/float_exprs.wast

===== ../../test-interpreter/spec-test-1/float_literals.wast =====
- 85/85 (100.00%)

===== ../../test-interpreter/spec-test-1/float_memory.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-1/float_misc.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/float_misc.wast

===== ../../test-interpreter/spec-test-1/forward.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-1/func.wast =====
- 76/76 (100.00%)

===== ../../test-interpreter/spec-test-1/func_ptrs.wast =====
- print_i32: 83
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-1/globals.wast =====
- 51/51 (100.00%)

===== ../../test-interpreter/spec-test-1/i32.wast =====
- 360/360 (100.00%)

===== ../../test-interpreter/spec-test-1/i64.wast =====
- 360/360 (100.00%)

===== ../../test-interpreter/spec-test-1/if.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-1/imports.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/imports.wast

===== ../../test-interpreter/spec-test-1/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-1/int_exprs.wast =====
- 108/108 (100.00%)

===== ../../test-interpreter/spec-test-1/int_literals.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-1/labels.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-1/left-to-right.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-1/linking.wast =====
- 99/99 (100.00%)

===== ../../test-interpreter/spec-test-1/load.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-1/local_get.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-1/local_set.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-1/local_tee.wast =====
- 56/56 (100.00%)

===== ../../test-interpreter/spec-test-1/loop.wast =====
- 67/67 (100.00%)

===== ../../test-interpreter/spec-test-1/memory.wast =====
- 53/53 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_redundancy.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_size.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_trap.wast =====
- 173/173 (100.00%)

===== ../../test-interpreter/spec-test-1/names.wast =====
- print_i32: 42
- print_i32: 123
- 483/483 (100.00%)

===== ../../test-interpreter/spec-test-1/nop.wast =====
- 84/84 (100.00%)

===== ../../test-interpreter/spec-test-1/return.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-1/select.wast =====
- 95/95 (100.00%)

===== ../../test-interpreter/spec-test-1/skip-stack-guard-page.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-1/stack.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-1/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-1/store.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-1/switch.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-1/token.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/traps.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-1/type.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-1/unreachable.wast =====
- 62/62 (100.00%)

===== ../../test-interpreter/spec-test-1/unreached-invalid.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/unwind.wast =====
- 50/50 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-custom-section-id.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-import-field.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-import-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-invalid-encoding.wast =====
- 0/0 (100.00%)

8 parsing fail
Total [9983/9983] (100.00%)

== Complete.
Running test for Wasm 2.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../../test-interpreter/spec-test-2/address.wast =====
- 259/259 (100.00%)

===== ../../test-interpreter/spec-test-2/align.wast =====
- 73/73 (100.00%)

===== ../../test-interpreter/spec-test-2/binary-leb128.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-2/binary.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-2/block.wast =====
- 53/53 (100.00%)

===== ../../test-interpreter/spec-test-2/br.wast =====
- 77/77 (100.00%)

===== ../../test-interpreter/spec-test-2/br_if.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-2/br_table.wast =====
- 150/150 (100.00%)

===== ../../test-interpreter/spec-test-2/bulk.wast =====
- 117/117 (100.00%)

===== ../../test-interpreter/spec-test-2/call.wast =====
- 71/71 (100.00%)

===== ../../test-interpreter/spec-test-2/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/comments.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-2/const.wast =====
- 702/702 (100.00%)

===== ../../test-interpreter/spec-test-2/conversions.wast =====
- 594/594 (100.00%)

===== ../../test-interpreter/spec-test-2/custom.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-2/data.wast =====
- 39/39 (100.00%)

===== ../../test-interpreter/spec-test-2/elem.wast =====
- 66/66 (100.00%)

===== ../../test-interpreter/spec-test-2/endianness.wast =====
- 69/69 (100.00%)

===== ../../test-interpreter/spec-test-2/exports.wast =====
- 65/65 (100.00%)

===== ../../test-interpreter/spec-test-2/f32.wast =====
- 2501/2501 (100.00%)

===== ../../test-interpreter/spec-test-2/f32_bitwise.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-2/f32_cmp.wast =====
- 2401/2401 (100.00%)

===== ../../test-interpreter/spec-test-2/f64.wast =====
- 2501/2501 (100.00%)

===== ../../test-interpreter/spec-test-2/f64_bitwise.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-2/f64_cmp.wast =====
- 2401/2401 (100.00%)

===== ../../test-interpreter/spec-test-2/fac.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-2/float_exprs.wast =====
- 900/900 (100.00%)

===== ../../test-interpreter/spec-test-2/float_literals.wast =====
- 85/85 (100.00%)

===== ../../test-interpreter/spec-test-2/float_memory.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-2/float_misc.wast =====
- 441/441 (100.00%)

===== ../../test-interpreter/spec-test-2/forward.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-2/func.wast =====
- 100/100 (100.00%)

===== ../../test-interpreter/spec-test-2/func_ptrs.wast =====
- print_i32: 83
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-2/global.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-2/i32.wast =====
- 375/375 (100.00%)

===== ../../test-interpreter/spec-test-2/i64.wast =====
- 385/385 (100.00%)

===== ../../test-interpreter/spec-test-2/if.wast =====
- 124/124 (100.00%)

===== ../../test-interpreter/spec-test-2/imports.wast =====
- print_i32: 13
- print_i32_f32: 14 42
- print_i32: 13
- print_i32: 13
- print_f32: 13
- print_i32: 13
- print_i64: 24
- print_f64_f64: 25 53
- print_i64: 24
- print_f64: 24
- print_f64: 24
- print_f64: 24
- print_i32: 13
- 88/88 (100.00%)

===== ../../test-interpreter/spec-test-2/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-2/int_exprs.wast =====
- 108/108 (100.00%)

===== ../../test-interpreter/spec-test-2/int_literals.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-2/labels.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-2/left-to-right.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-2/linking.wast =====
- 111/111 (100.00%)

===== ../../test-interpreter/spec-test-2/load.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-2/local_get.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-2/local_set.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-2/local_tee.wast =====
- 56/56 (100.00%)

===== ../../test-interpreter/spec-test-2/loop.wast =====
- 78/78 (100.00%)

===== ../../test-interpreter/spec-test-2/memory.wast =====
- 55/55 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_copy.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_fill.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_init.wast =====
- 173/173 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_redundancy.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_size.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_trap.wast =====
- 182/182 (100.00%)

===== ../../test-interpreter/spec-test-2/names.wast =====
- print_i32: 42
- print_i32: 123
- 486/486 (100.00%)

===== ../../test-interpreter/spec-test-2/nop.wast =====
- 84/84 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_func.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_is_null.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_null.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-2/return.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-2/select.wast =====
- 120/120 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_address.wast =====
- 45/45 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_align.wast =====
- 54/54 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_bit_shift.wast =====
- 213/213 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_bitwise.wast =====
- 141/141 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_boolean.wast =====
- 261/261 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_const.wast =====
- 577/577 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_conversions.wast =====
- 234/234 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4.wast =====
- 774/774 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4_arith.wast =====
- 1806/1806 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4_cmp.wast =====
- 2583/2583 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4_pmin_pmax.wast =====
- 3873/3873 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4_rounding.wast =====
- 177/177 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2.wast =====
- 795/795 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2_arith.wast =====
- 1809/1809 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2_cmp.wast =====
- 2661/2661 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2_pmin_pmax.wast =====
- 3873/3873 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2_rounding.wast =====
- 177/177 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_arith.wast =====
- 183/183 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_arith2.wast =====
- 153/153 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast =====
- 435/435 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast =====
- 105/105 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_q15mulr_sat_s.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_sat_arith.wast =====
- 206/206 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_arith.wast =====
- 183/183 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_arith2.wast =====
- 123/123 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast =====
- 435/435 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast =====
- 105/105 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast =====
- 103/103 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast =====
- 103/103 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_arith.wast =====
- 189/189 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_arith2.wast =====
- 23/23 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast =====
- 103/103 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast =====
- 105/105 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_arith.wast =====
- 123/123 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_arith2.wast =====
- 186/186 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast =====
- 415/415 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_sat_arith.wast =====
- 190/190 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast =====
- 229/229 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_lane.wast =====
- 286/286 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_linking.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load16_lane.wast =====
- 33/33 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load32_lane.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load64_lane.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load8_lane.wast =====
- 49/49 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast =====
- 86/86 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast =====
- 114/114 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_zero.wast =====
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_splat.wast =====
- 162/162 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store16_lane.wast =====
- 33/33 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store32_lane.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store64_lane.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store8_lane.wast =====
- 49/49 (100.00%)

===== ../../test-interpreter/spec-test-2/skip-stack-guard-page.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-2/stack.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-2/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-2/store.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-2/switch.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-2/table-sub.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/table.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-2/table_copy.wast =====
- 1727/1727 (100.00%)

===== ../../test-interpreter/spec-test-2/table_fill.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-2/table_get.wast =====
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-2/table_grow.wast =====
- 43/43 (100.00%)

===== ../../test-interpreter/spec-test-2/table_init.wast =====
- 712/712 (100.00%)

===== ../../test-interpreter/spec-test-2/table_set.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-2/table_size.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-2/token.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/tokens.wast =====
- 35/35 (100.00%)

===== ../../test-interpreter/spec-test-2/traps.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-2/type.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-2/unreachable.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-2/unreached-invalid.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/unreached-valid.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-2/unwind.wast =====
- 50/50 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-custom-section-id.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-import-field.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-import-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-invalid-encoding.wast =====
- 0/0 (100.00%)

Total [45187/45187] (100.00%)

== Complete.
Running test for Wasm 3.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../../test-interpreter/spec-test-3/address.wast =====
- 259/259 (100.00%)

===== ../../test-interpreter/spec-test-3/align.wast =====
- 113/113 (100.00%)

===== ../../test-interpreter/spec-test-3/annotations.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-3/binary-leb128.wast =====
- 33/33 (100.00%)

===== ../../test-interpreter/spec-test-3/binary.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/block.wast =====
- 208/208 (100.00%)

===== ../../test-interpreter/spec-test-3/br.wast =====
- 97/97 (100.00%)

===== ../../test-interpreter/spec-test-3/br_if.wast =====
- 119/119 (100.00%)

===== ../../test-interpreter/spec-test-3/br_on_non_null.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-3/br_on_null.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-3/br_table.wast =====
- 186/186 (100.00%)

===== ../../test-interpreter/spec-test-3/bulk.wast =====
- 117/117 (100.00%)

===== ../../test-interpreter/spec-test-3/call.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-3/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/call_ref.wast =====
- 35/35 (100.00%)

===== ../../test-interpreter/spec-test-3/comments.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-3/const.wast =====
- 702/702 (100.00%)

===== ../../test-interpreter/spec-test-3/conversions.wast =====
- 619/619 (100.00%)

===== ../../test-interpreter/spec-test-3/custom.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-3/data.wast =====
- 65/65 (100.00%)

===== ../../test-interpreter/spec-test-3/elem.wast =====
- 148/148 (100.00%)

===== ../../test-interpreter/spec-test-3/endianness.wast =====
- 69/69 (100.00%)

===== ../../test-interpreter/spec-test-3/exports.wast =====
- 97/97 (100.00%)

===== ../../test-interpreter/spec-test-3/f32.wast =====
- 2512/2512 (100.00%)

===== ../../test-interpreter/spec-test-3/f32_bitwise.wast =====
- 364/364 (100.00%)

===== ../../test-interpreter/spec-test-3/f32_cmp.wast =====
- 2407/2407 (100.00%)

===== ../../test-interpreter/spec-test-3/f64.wast =====
- 2512/2512 (100.00%)

===== ../../test-interpreter/spec-test-3/f64_bitwise.wast =====
- 364/364 (100.00%)

===== ../../test-interpreter/spec-test-3/f64_cmp.wast =====
- 2407/2407 (100.00%)

===== ../../test-interpreter/spec-test-3/fac.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-3/float_exprs.wast =====
- 900/900 (100.00%)

===== ../../test-interpreter/spec-test-3/float_literals.wast =====
- 101/101 (100.00%)

===== ../../test-interpreter/spec-test-3/float_memory.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-3/float_misc.wast =====
- 441/441 (100.00%)

===== ../../test-interpreter/spec-test-3/forward.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-3/func.wast =====
- 152/152 (100.00%)

===== ../../test-interpreter/spec-test-3/func_ptrs.wast =====
- print_i32: 83
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array.wast =====
- 46/46 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_copy.wast =====
- 35/35 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_fill.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_init_data.wast =====
- 33/33 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_init_elem.wast =====
- 23/23 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/binary-gc.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/br_on_cast.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/br_on_cast_fail.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/extern.wast =====
- 18/18 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/i31.wast =====
- 72/72 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_cast.wast =====
- 45/45 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_eq.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_test.wast =====
- 71/71 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/struct.wast =====
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/type-subtyping.wast =====
- 83/83 (100.00%)

===== ../../test-interpreter/spec-test-3/global.wast =====
- 116/116 (100.00%)

===== ../../test-interpreter/spec-test-3/i32.wast =====
- 458/458 (100.00%)

===== ../../test-interpreter/spec-test-3/i64.wast =====
- 414/414 (100.00%)

===== ../../test-interpreter/spec-test-3/id.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/if.wast =====
- 217/217 (100.00%)

===== ../../test-interpreter/spec-test-3/imports.wast =====
- print_i32: 13
- print_i32_f32: 14 42
- print_i32: 13
- print_i32: 13
- print_f32: 13
- print_i32: 13
- print_i64: 24
- print_f64_f64: 25 53
- print_i64: 24
- print_f64: 24
- print_f64: 24
- print_f64: 24
- print_i32: 13
- 92/92 (100.00%)

===== ../../test-interpreter/spec-test-3/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/int_exprs.wast =====
- 108/108 (100.00%)

===== ../../test-interpreter/spec-test-3/int_literals.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/labels.wast =====
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-3/left-to-right.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-3/linking.wast =====
- 111/111 (100.00%)

===== ../../test-interpreter/spec-test-3/load.wast =====
- 104/104 (100.00%)

===== ../../test-interpreter/spec-test-3/local_get.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/local_init.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-3/local_set.wast =====
- 53/53 (100.00%)

===== ../../test-interpreter/spec-test-3/local_tee.wast =====
- 98/98 (100.00%)

===== ../../test-interpreter/spec-test-3/loop.wast =====
- 105/105 (100.00%)

===== ../../test-interpreter/spec-test-3/memory-multi.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-3/memory.wast =====
- 80/80 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_copy.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_fill.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_init.wast =====
- 240/240 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_redundancy.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_size.wast =====
- 48/48 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_trap.wast =====
- 182/182 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/address0.wast =====
- 92/92 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/address1.wast =====
- 127/127 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/align0.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/binary0.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/data0.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/data1.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/data_drop0.wast =====
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/exports0.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/float_exprs0.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/float_exprs1.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/float_memory0.wast =====
- 30/30 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/imports0.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/imports1.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/imports2.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/imports3.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/imports4.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/linking0.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/linking1.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/linking2.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/linking3.wast =====
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/load0.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/load1.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/load2.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_copy0.wast =====
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_copy1.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_fill0.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_init0.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_size0.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_size1.wast =====
- 15/15 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_size2.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_size3.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_trap0.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_trap1.wast =====
- 168/168 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/start0.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/store0.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/store1.wast =====
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/traps0.wast =====
- 15/15 (100.00%)

===== ../../test-interpreter/spec-test-3/names.wast =====
- print_i32: 42
- print_i32: 123
- 486/486 (100.00%)

===== ../../test-interpreter/spec-test-3/nop.wast =====
- 88/88 (100.00%)

===== ../../test-interpreter/spec-test-3/obsolete-keywords.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/ref.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_as_non_null.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_func.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_is_null.wast =====
- 22/22 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_null.wast =====
- 34/34 (100.00%)

===== ../../test-interpreter/spec-test-3/return.wast =====
- 84/84 (100.00%)

===== ../../test-interpreter/spec-test-3/return_call.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/return_call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/return_call_ref.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/select.wast =====
- 157/157 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_address.wast =====
- 45/45 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_align.wast =====
- 66/66 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_bit_shift.wast =====
- 237/237 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_bitwise.wast =====
- 169/169 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_boolean.wast =====
- 273/273 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_const.wast =====
- 577/577 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_conversions.wast =====
- 252/252 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4.wast =====
- 782/782 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_arith.wast =====
- 1822/1822 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_cmp.wast =====
- 2601/2601 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_pmin_pmax.wast =====
- 3879/3879 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_rounding.wast =====
- 185/185 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2.wast =====
- 803/803 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_arith.wast =====
- 1825/1825 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_cmp.wast =====
- 2679/2679 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_pmin_pmax.wast =====
- 3879/3879 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_rounding.wast =====
- 185/185 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_arith.wast =====
- 194/194 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_arith2.wast =====
- 170/170 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast =====
- 465/465 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast =====
- 117/117 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_q15mulr_sat_s.wast =====
- 30/30 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_sat_arith.wast =====
- 218/218 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith.wast =====
- 194/194 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith2.wast =====
- 137/137 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast =====
- 465/465 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast =====
- 30/30 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast =====
- 117/117 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f32x4.wast =====
- 107/107 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast =====
- 107/107 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith.wast =====
- 200/200 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith2.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast =====
- 113/113 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast =====
- 117/117 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith.wast =====
- 131/131 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith2.wast =====
- 205/205 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast =====
- 445/445 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_sat_arith.wast =====
- 202/202 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast =====
- 253/253 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_lane.wast =====
- 369/369 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_linking.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast =====
- 24/24 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast =====
- 52/52 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast =====
- 98/98 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast =====
- 122/122 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_zero.wast =====
- 33/33 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_memory-multi.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_splat.wast =====
- 184/184 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store16_lane.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store32_lane.wast =====
- 24/24 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store64_lane.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store8_lane.wast =====
- 52/52 (100.00%)

===== ../../test-interpreter/spec-test-3/skip-stack-guard-page.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/stack.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-3/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/store.wast =====
- 101/101 (100.00%)

===== ../../test-interpreter/spec-test-3/switch.wast =====
- 28/28 (100.00%)

===== ../../test-interpreter/spec-test-3/table-sub.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-3/table.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/table_copy.wast =====
- 1727/1727 (100.00%)

===== ../../test-interpreter/spec-test-3/table_fill.wast =====
- 45/45 (100.00%)

===== ../../test-interpreter/spec-test-3/table_get.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/table_grow.wast =====
- 50/50 (100.00%)

===== ../../test-interpreter/spec-test-3/table_init.wast =====
- 779/779 (100.00%)

===== ../../test-interpreter/spec-test-3/table_set.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-3/table_size.wast =====
- 39/39 (100.00%)

===== ../../test-interpreter/spec-test-3/tag.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-3/throw.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/throw_ref.wast =====
- 15/15 (100.00%)

===== ../../test-interpreter/spec-test-3/token.wast =====
- 35/35 (100.00%)

===== ../../test-interpreter/spec-test-3/traps.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/try_table.wast =====
- 58/58 (100.00%)

===== ../../test-interpreter/spec-test-3/type-canon.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-3/type-equivalence.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-3/type-rec.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/type.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/unreachable.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-3/unreached-invalid.wast =====
- 121/121 (100.00%)

===== ../../test-interpreter/spec-test-3/unreached-valid.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/unwind.wast =====
- 50/50 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-custom-section-id.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-import-field.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-import-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-invalid-encoding.wast =====
- 0/0 (100.00%)

Total [49087/49087] (100.00%)

== Complete.
```
