# Preview

```sh
$ cd ../spec/wasm-3.0 && \
> ../../src/exe-watsup/main.exe *.watsup -v -l --interpreter ../../test-interpreter/sample.wat addTwo 30 12 2> /dev/null
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../../test-interpreter/sample.wat =====
== Complete.
$ cd ../spec/wasm-3.0 && \
> ../../src/exe-watsup/main.exe *.watsup -v -l --interpreter ../../test-interpreter/sample.wasm addTwo 40 2 2> /dev/null
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../../test-interpreter/sample.wasm =====
== Complete.
$ cd ../spec/wasm-3.0 && \
> ../../src/exe-watsup/main.exe *.watsup -v -l --interpreter ../../test-interpreter/sample.wast 2> /dev/null
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../../test-interpreter/sample.wast =====
Result: 42 : [i32]
Expect: 43 : [i32]
- print_i32: 10
- 12/30 (40.00%)

== Complete.
$ for v in 1 2 3; do ( \
>   echo "Running test for Wasm $v.0..." && \
>   cd ../spec/wasm-$v.0 && \
>   ../../src/exe-watsup/main.exe *.watsup -v -l --test-version $v --interpreter ../../test-interpreter/spec-test-$v \
> ) done 2>/dev/null
Running test for Wasm 1.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../../test-interpreter/spec-test-1/address.wast =====
- 72/242 (29.75%)

===== ../../test-interpreter/spec-test-1/align.wast =====
- 36/73 (49.32%)

===== ../../test-interpreter/spec-test-1/binary-leb128.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-1/binary.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-1/block.wast =====
- 36/42 (85.71%)

===== ../../test-interpreter/spec-test-1/br.wast =====
- 58/64 (90.62%)

===== ../../test-interpreter/spec-test-1/br_if.wast =====
- 77/89 (86.52%)

===== ../../test-interpreter/spec-test-1/br_table.wast =====
- 116/147 (78.91%)

===== ../../test-interpreter/spec-test-1/break-drop.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-1/call.wast =====
- 34/62 (54.84%)

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
- 1/69 (1.45%)

===== ../../test-interpreter/spec-test-1/exports.wast =====
- 57/60 (95.00%)

===== ../../test-interpreter/spec-test-1/f32.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/f32.wast

===== ../../test-interpreter/spec-test-1/f32_bitwise.wast =====
- 1/361 (0.28%)

===== ../../test-interpreter/spec-test-1/f32_cmp.wast =====
- 1/2401 (0.04%)

===== ../../test-interpreter/spec-test-1/f64.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/f64.wast

===== ../../test-interpreter/spec-test-1/f64_bitwise.wast =====
- 1/361 (0.28%)

===== ../../test-interpreter/spec-test-1/f64_cmp.wast =====
- 1/2401 (0.04%)

===== ../../test-interpreter/spec-test-1/fac.wast =====
- 1/6 (16.67%)

===== ../../test-interpreter/spec-test-1/float_exprs.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/float_exprs.wast

===== ../../test-interpreter/spec-test-1/float_literals.wast =====
- 23/85 (27.06%)

===== ../../test-interpreter/spec-test-1/float_memory.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-1/float_misc.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/float_misc.wast

===== ../../test-interpreter/spec-test-1/forward.wast =====
- 1/5 (20.00%)

===== ../../test-interpreter/spec-test-1/func.wast =====
- 65/76 (85.53%)

===== ../../test-interpreter/spec-test-1/func_ptrs.wast =====
- print_i32: 83
- 27/29 (93.10%)

===== ../../test-interpreter/spec-test-1/globals.wast =====
- 48/51 (94.12%)

===== ../../test-interpreter/spec-test-1/i32.wast =====
- 1/360 (0.28%)

===== ../../test-interpreter/spec-test-1/i64.wast =====
- 1/360 (0.28%)

===== ../../test-interpreter/spec-test-1/if.wast =====
- 74/89 (83.15%)

===== ../../test-interpreter/spec-test-1/imports.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/imports.wast

===== ../../test-interpreter/spec-test-1/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-1/int_exprs.wast =====
- 19/108 (17.59%)

===== ../../test-interpreter/spec-test-1/int_literals.wast =====
- 29/31 (93.55%)

===== ../../test-interpreter/spec-test-1/labels.wast =====
- 11/26 (42.31%)

===== ../../test-interpreter/spec-test-1/left-to-right.wast =====
- 1/96 (1.04%)

===== ../../test-interpreter/spec-test-1/linking.wast =====
- 88/99 (88.89%)

===== ../../test-interpreter/spec-test-1/load.wast =====
- 30/38 (78.95%)

===== ../../test-interpreter/spec-test-1/local_get.wast =====
- 16/20 (80.00%)

===== ../../test-interpreter/spec-test-1/local_set.wast =====
- 19/20 (95.00%)

===== ../../test-interpreter/spec-test-1/local_tee.wast =====
- 45/56 (80.36%)

===== ../../test-interpreter/spec-test-1/loop.wast =====
- 33/67 (49.25%)

===== ../../test-interpreter/spec-test-1/memory.wast =====
- 11/53 (20.75%)

===== ../../test-interpreter/spec-test-1/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_redundancy.wast =====
- 7/8 (87.50%)

===== ../../test-interpreter/spec-test-1/memory_size.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_trap.wast =====
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
- 101/173 (58.38%)

===== ../../test-interpreter/spec-test-1/names.wast =====
- print_i32: 42
- print_i32: 123
- 483/483 (100.00%)

===== ../../test-interpreter/spec-test-1/nop.wast =====
- 65/84 (77.38%)

===== ../../test-interpreter/spec-test-1/return.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-1/select.wast =====
- 83/95 (87.37%)

===== ../../test-interpreter/spec-test-1/skip-stack-guard-page.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-1/stack.wast =====
- 2/5 (40.00%)

===== ../../test-interpreter/spec-test-1/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 4/16 (25.00%)

===== ../../test-interpreter/spec-test-1/store.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-1/switch.wast =====
- 8/27 (29.63%)

===== ../../test-interpreter/spec-test-1/token.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/traps.wast =====
- 8/36 (22.22%)

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
Total [2804/9983] (28.09%)

== Complete.
Running test for Wasm 2.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../../test-interpreter/spec-test-2/address.wast =====
- 23/259 (8.88%)

===== ../../test-interpreter/spec-test-2/align.wast =====
- 26/73 (35.62%)

===== ../../test-interpreter/spec-test-2/binary-leb128.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-2/binary.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-2/block.wast =====
- 35/53 (66.04%)

===== ../../test-interpreter/spec-test-2/br.wast =====
- 71/77 (92.21%)

===== ../../test-interpreter/spec-test-2/br_if.wast =====
- 77/89 (86.52%)

===== ../../test-interpreter/spec-test-2/br_table.wast =====
- 119/150 (79.33%)

===== ../../test-interpreter/spec-test-2/bulk.wast =====
- 79/117 (67.52%)

===== ../../test-interpreter/spec-test-2/call.wast =====
- 38/71 (53.52%)

===== ../../test-interpreter/spec-test-2/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/comments.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-2/const.wast =====
- 702/702 (100.00%)

===== ../../test-interpreter/spec-test-2/conversions.wast =====
- 1/594 (0.17%)

===== ../../test-interpreter/spec-test-2/custom.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-2/data.wast =====
- 39/39 (100.00%)

===== ../../test-interpreter/spec-test-2/elem.wast =====
- 66/66 (100.00%)

===== ../../test-interpreter/spec-test-2/endianness.wast =====
- 1/69 (1.45%)

===== ../../test-interpreter/spec-test-2/exports.wast =====
- 62/65 (95.38%)

===== ../../test-interpreter/spec-test-2/f32.wast =====
- 1/2501 (0.04%)

===== ../../test-interpreter/spec-test-2/f32_bitwise.wast =====
- 1/361 (0.28%)

===== ../../test-interpreter/spec-test-2/f32_cmp.wast =====
- 1/2401 (0.04%)

===== ../../test-interpreter/spec-test-2/f64.wast =====
- 1/2501 (0.04%)

===== ../../test-interpreter/spec-test-2/f64_bitwise.wast =====
- 1/361 (0.28%)

===== ../../test-interpreter/spec-test-2/f64_cmp.wast =====
- 1/2401 (0.04%)

===== ../../test-interpreter/spec-test-2/fac.wast =====
- 1/7 (14.29%)

===== ../../test-interpreter/spec-test-2/float_exprs.wast =====
- 96/900 (10.67%)

===== ../../test-interpreter/spec-test-2/float_literals.wast =====
- 23/85 (27.06%)

===== ../../test-interpreter/spec-test-2/float_memory.wast =====
- 6/90 (6.67%)

===== ../../test-interpreter/spec-test-2/float_misc.wast =====
- 1/441 (0.23%)

===== ../../test-interpreter/spec-test-2/forward.wast =====
- 1/5 (20.00%)

===== ../../test-interpreter/spec-test-2/func.wast =====
- 86/100 (86.00%)

===== ../../test-interpreter/spec-test-2/func_ptrs.wast =====
- print_i32: 83
- 27/29 (93.10%)

===== ../../test-interpreter/spec-test-2/global.wast =====
- 57/63 (90.48%)

===== ../../test-interpreter/spec-test-2/i32.wast =====
- 1/375 (0.27%)

===== ../../test-interpreter/spec-test-2/i64.wast =====
- 1/385 (0.26%)

===== ../../test-interpreter/spec-test-2/if.wast =====
- 71/124 (57.26%)

===== ../../test-interpreter/spec-test-2/imports.wast =====
- print_i32: 13
- 79/88 (89.77%)

===== ../../test-interpreter/spec-test-2/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-2/int_exprs.wast =====
- 19/108 (17.59%)

===== ../../test-interpreter/spec-test-2/int_literals.wast =====
- 29/31 (93.55%)

===== ../../test-interpreter/spec-test-2/labels.wast =====
- 11/26 (42.31%)

===== ../../test-interpreter/spec-test-2/left-to-right.wast =====
- 1/96 (1.04%)

===== ../../test-interpreter/spec-test-2/linking.wast =====
- 99/111 (89.19%)

===== ../../test-interpreter/spec-test-2/load.wast =====
- 1/38 (2.63%)

===== ../../test-interpreter/spec-test-2/local_get.wast =====
- 16/20 (80.00%)

===== ../../test-interpreter/spec-test-2/local_set.wast =====
- 19/20 (95.00%)

===== ../../test-interpreter/spec-test-2/local_tee.wast =====
- 42/56 (75.00%)

===== ../../test-interpreter/spec-test-2/loop.wast =====
- 32/78 (41.03%)

===== ../../test-interpreter/spec-test-2/memory.wast =====
- 13/55 (23.64%)

===== ../../test-interpreter/spec-test-2/memory_copy.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_fill.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_init.wast =====
- 46/173 (26.59%)

===== ../../test-interpreter/spec-test-2/memory_redundancy.wast =====
- 1/8 (12.50%)

===== ../../test-interpreter/spec-test-2/memory_size.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_trap.wast =====
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
- 103/182 (56.59%)

===== ../../test-interpreter/spec-test-2/names.wast =====
- print_i32: 42
- print_i32: 123
- 486/486 (100.00%)

===== ../../test-interpreter/spec-test-2/nop.wast =====
- 58/84 (69.05%)

===== ../../test-interpreter/spec-test-2/ref_func.wast =====
- 11/13 (84.62%)

===== ../../test-interpreter/spec-test-2/ref_is_null.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_null.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-2/return.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-2/select.wast =====
- 102/120 (85.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_address.wast =====
- 6/45 (13.33%)

===== ../../test-interpreter/spec-test-2/simd/simd_align.wast =====
- 46/54 (85.19%)

===== ../../test-interpreter/spec-test-2/simd/simd_bit_shift.wast =====
- 2/213 (0.94%)

===== ../../test-interpreter/spec-test-2/simd/simd_bitwise.wast =====
- 2/141 (1.42%)

===== ../../test-interpreter/spec-test-2/simd/simd_boolean.wast =====
- 2/261 (0.77%)

===== ../../test-interpreter/spec-test-2/simd/simd_const.wast =====
- 371/577 (64.30%)

===== ../../test-interpreter/spec-test-2/simd/simd_conversions.wast =====
- 2/234 (0.85%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4.wast =====
- 2/774 (0.26%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4_arith.wast =====
- 3/1806 (0.17%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4_cmp.wast =====
- 2/2583 (0.08%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4_pmin_pmax.wast =====
- 1/3873 (0.03%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4_rounding.wast =====
- 1/177 (0.56%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2.wast =====
- 2/795 (0.25%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2_arith.wast =====
- 3/1809 (0.17%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2_cmp.wast =====
- 2/2661 (0.08%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2_pmin_pmax.wast =====
- 1/3873 (0.03%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2_rounding.wast =====
- 1/177 (0.56%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_arith.wast =====
- 2/183 (1.09%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_arith2.wast =====
- 2/153 (1.31%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast =====
- 2/435 (0.46%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
- 1/17 (5.88%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast =====
- 1/105 (0.95%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_q15mulr_sat_s.wast =====
- 1/27 (3.70%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_sat_arith.wast =====
- 2/206 (0.97%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_arith.wast =====
- 2/183 (1.09%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_arith2.wast =====
- 2/123 (1.63%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast =====
- 2/435 (0.46%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast =====
- 1/27 (3.70%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
- 1/17 (5.88%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast =====
- 1/105 (0.95%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast =====
- 1/103 (0.97%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast =====
- 1/103 (0.97%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_arith.wast =====
- 2/189 (1.06%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_arith2.wast =====
- 2/23 (8.70%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast =====
- 1/103 (0.97%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast =====
- 1/105 (0.95%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_arith.wast =====
- 2/123 (1.63%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_arith2.wast =====
- 2/186 (1.08%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast =====
- 2/415 (0.48%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_sat_arith.wast =====
- 2/190 (1.05%)

===== ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast =====
- 1/229 (0.44%)

===== ../../test-interpreter/spec-test-2/simd/simd_lane.wast =====
- 11/286 (3.85%)

===== ../../test-interpreter/spec-test-2/simd/simd_linking.wast =====
- 0/2 (0.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load.wast =====
- 14/31 (45.16%)

===== ../../test-interpreter/spec-test-2/simd/simd_load16_lane.wast =====
- 1/33 (3.03%)

===== ../../test-interpreter/spec-test-2/simd/simd_load32_lane.wast =====
- 1/21 (4.76%)

===== ../../test-interpreter/spec-test-2/simd/simd_load64_lane.wast =====
- 1/13 (7.69%)

===== ../../test-interpreter/spec-test-2/simd/simd_load8_lane.wast =====
- 1/49 (2.04%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast =====
- 2/86 (2.33%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast =====
- 34/114 (29.82%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_zero.wast =====
- 6/29 (20.69%)

===== ../../test-interpreter/spec-test-2/simd/simd_splat.wast =====
- 3/162 (1.85%)

===== ../../test-interpreter/spec-test-2/simd/simd_store.wast =====
- 2/19 (10.53%)

===== ../../test-interpreter/spec-test-2/simd/simd_store16_lane.wast =====
- 0/33 (0.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store32_lane.wast =====
- 0/21 (0.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store64_lane.wast =====
- 0/13 (0.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store8_lane.wast =====
- 0/49 (0.00%)

===== ../../test-interpreter/spec-test-2/skip-stack-guard-page.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-2/stack.wast =====
- 2/7 (28.57%)

===== ../../test-interpreter/spec-test-2/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 4/16 (25.00%)

===== ../../test-interpreter/spec-test-2/store.wast =====
- 1/10 (10.00%)

===== ../../test-interpreter/spec-test-2/switch.wast =====
- 8/27 (29.63%)

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
- 41/43 (95.35%)

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
- 8/36 (22.22%)

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

Total [6412/45187] (14.19%)

== Complete.
Running test for Wasm 3.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../../test-interpreter/spec-test-3/address.wast =====
- 23/259 (8.88%)

===== ../../test-interpreter/spec-test-3/align.wast =====
- 26/73 (35.62%)

===== ../../test-interpreter/spec-test-3/binary-leb128.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-3/binary.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-3/block.wast =====
- 35/53 (66.04%)

===== ../../test-interpreter/spec-test-3/br.wast =====
- 71/77 (92.21%)

===== ../../test-interpreter/spec-test-3/br_if.wast =====
- 77/89 (86.52%)

===== ../../test-interpreter/spec-test-3/br_table.wast =====
- 119/150 (79.33%)

===== ../../test-interpreter/spec-test-3/bulk.wast =====
- 79/117 (67.52%)

===== ../../test-interpreter/spec-test-3/call.wast =====
- 38/71 (53.52%)

===== ../../test-interpreter/spec-test-3/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/comments.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-3/const.wast =====
- 702/702 (100.00%)

===== ../../test-interpreter/spec-test-3/conversions.wast =====
- 1/594 (0.17%)

===== ../../test-interpreter/spec-test-3/custom.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-3/data.wast =====
- 39/39 (100.00%)

===== ../../test-interpreter/spec-test-3/elem.wast =====
- 66/66 (100.00%)

===== ../../test-interpreter/spec-test-3/endianness.wast =====
- 1/69 (1.45%)

===== ../../test-interpreter/spec-test-3/exports.wast =====
- 62/65 (95.38%)

===== ../../test-interpreter/spec-test-3/f32.wast =====
- 1/2501 (0.04%)

===== ../../test-interpreter/spec-test-3/f32_bitwise.wast =====
- 1/361 (0.28%)

===== ../../test-interpreter/spec-test-3/f32_cmp.wast =====
- 1/2401 (0.04%)

===== ../../test-interpreter/spec-test-3/f64.wast =====
- 1/2501 (0.04%)

===== ../../test-interpreter/spec-test-3/f64_bitwise.wast =====
- 1/361 (0.28%)

===== ../../test-interpreter/spec-test-3/f64_cmp.wast =====
- 1/2401 (0.04%)

===== ../../test-interpreter/spec-test-3/fac.wast =====
- 1/7 (14.29%)

===== ../../test-interpreter/spec-test-3/float_exprs.wast =====
- 96/900 (10.67%)

===== ../../test-interpreter/spec-test-3/float_literals.wast =====
- 23/85 (27.06%)

===== ../../test-interpreter/spec-test-3/float_memory.wast =====
- 6/90 (6.67%)

===== ../../test-interpreter/spec-test-3/float_misc.wast =====
- 1/441 (0.23%)

===== ../../test-interpreter/spec-test-3/forward.wast =====
- 1/5 (20.00%)

===== ../../test-interpreter/spec-test-3/func.wast =====
- 86/100 (86.00%)

===== ../../test-interpreter/spec-test-3/func_ptrs.wast =====
- print_i32: 83
- 27/29 (93.10%)

===== ../../test-interpreter/spec-test-3/function-references/br_on_non_null.wast =====
- 8/9 (88.89%)

===== ../../test-interpreter/spec-test-3/function-references/br_on_null.wast =====
- 8/9 (88.89%)

===== ../../test-interpreter/spec-test-3/function-references/call_ref.wast =====
- 8/31 (25.81%)

===== ../../test-interpreter/spec-test-3/function-references/ref_as_non_null.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/return_call_ref.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array.wast =====
- 28/38 (73.68%)

===== ../../test-interpreter/spec-test-3/gc/array_copy.wast =====
Result: 10 : [i32]
Expect: 97 : [i32]
Result: 10 : [i32]
Expect: 97 : [i32]
Result: 0 : [i32]
Expect: 98 : [i32]
Result: 0 : [i32]
Expect: 101 : [i32]
Result: 0 : [i32]
Expect: 106 : [i32]
Result: 0 : [i32]
Expect: 107 : [i32]
Result: 10 : [i32]
Expect: 98 : [i32]
Result: 10 : [i32]
Expect: 99 : [i32]
Result: 0 : [i32]
Expect: 103 : [i32]
Result: 0 : [i32]
Expect: 107 : [i32]
Result: 0 : [i32]
Expect: 108 : [i32]
Result: 0 : [i32]
Expect: 108 : [i32]
- 17/31 (54.84%)

===== ../../test-interpreter/spec-test-3/gc/array_fill.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_init_data.wast =====
Result: 0 : [i32]
Expect: 99 : [i32]
Result: 0 : [i32]
Expect: 100 : [i32]
Result: 0 : [i32]
Expect: 26_470 : [i32]
Result: 0 : [i32]
Expect: 26_984 : [i32]
- 25/31 (80.65%)

===== ../../test-interpreter/spec-test-3/gc/array_init_elem.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/binary-gc.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/br_on_cast.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/br_on_cast_fail.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/extern.wast =====
- 18/18 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/i31.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_cast.wast =====
- 45/45 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_eq.wast =====
- 83/83 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_test.wast =====
- 3/71 (4.23%)

===== ../../test-interpreter/spec-test-3/gc/struct.wast =====
- 20/25 (80.00%)

===== ../../test-interpreter/spec-test-3/gc/type-subtyping.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-3/global.wast =====
- 57/63 (90.48%)

===== ../../test-interpreter/spec-test-3/i32.wast =====
- 1/375 (0.27%)

===== ../../test-interpreter/spec-test-3/i64.wast =====
- 1/385 (0.26%)

===== ../../test-interpreter/spec-test-3/if.wast =====
- 71/124 (57.26%)

===== ../../test-interpreter/spec-test-3/imports.wast =====
- print_i32: 13
- 79/88 (89.77%)

===== ../../test-interpreter/spec-test-3/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/int_exprs.wast =====
- 19/108 (17.59%)

===== ../../test-interpreter/spec-test-3/int_literals.wast =====
- 29/31 (93.55%)

===== ../../test-interpreter/spec-test-3/labels.wast =====
- 11/26 (42.31%)

===== ../../test-interpreter/spec-test-3/left-to-right.wast =====
- 1/96 (1.04%)

===== ../../test-interpreter/spec-test-3/linking.wast =====
- 99/111 (89.19%)

===== ../../test-interpreter/spec-test-3/load.wast =====
- 1/38 (2.63%)

===== ../../test-interpreter/spec-test-3/local_get.wast =====
- 16/20 (80.00%)

===== ../../test-interpreter/spec-test-3/local_set.wast =====
- 19/20 (95.00%)

===== ../../test-interpreter/spec-test-3/local_tee.wast =====
- 42/56 (75.00%)

===== ../../test-interpreter/spec-test-3/loop.wast =====
- 32/78 (41.03%)

===== ../../test-interpreter/spec-test-3/memory.wast =====
- 13/55 (23.64%)

===== ../../test-interpreter/spec-test-3/memory_copy.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_fill.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_init.wast =====
- 46/173 (26.59%)

===== ../../test-interpreter/spec-test-3/memory_redundancy.wast =====
- 1/8 (12.50%)

===== ../../test-interpreter/spec-test-3/memory_size.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_trap.wast =====
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
Result: "[]"
Expect: "out of bounds memory access"
- 103/182 (56.59%)

===== ../../test-interpreter/spec-test-3/names.wast =====
- print_i32: 42
- print_i32: 123
- 486/486 (100.00%)

===== ../../test-interpreter/spec-test-3/nop.wast =====
- 58/84 (69.05%)

===== ../../test-interpreter/spec-test-3/ref_func.wast =====
- 11/13 (84.62%)

===== ../../test-interpreter/spec-test-3/ref_is_null.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_null.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-3/return.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-3/select.wast =====
- 102/120 (85.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_address.wast =====
- 6/45 (13.33%)

===== ../../test-interpreter/spec-test-3/simd/simd_align.wast =====
- 46/54 (85.19%)

===== ../../test-interpreter/spec-test-3/simd/simd_bit_shift.wast =====
- 2/213 (0.94%)

===== ../../test-interpreter/spec-test-3/simd/simd_bitwise.wast =====
- 2/141 (1.42%)

===== ../../test-interpreter/spec-test-3/simd/simd_boolean.wast =====
- 2/261 (0.77%)

===== ../../test-interpreter/spec-test-3/simd/simd_const.wast =====
- 371/577 (64.30%)

===== ../../test-interpreter/spec-test-3/simd/simd_conversions.wast =====
- 2/234 (0.85%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4.wast =====
- 2/774 (0.26%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_arith.wast =====
- 3/1806 (0.17%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_cmp.wast =====
- 2/2583 (0.08%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_pmin_pmax.wast =====
- 1/3873 (0.03%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_rounding.wast =====
- 1/177 (0.56%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2.wast =====
- 2/795 (0.25%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_arith.wast =====
- 3/1809 (0.17%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_cmp.wast =====
- 2/2661 (0.08%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_pmin_pmax.wast =====
- 1/3873 (0.03%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_rounding.wast =====
- 1/177 (0.56%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_arith.wast =====
- 2/183 (1.09%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_arith2.wast =====
- 2/153 (1.31%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast =====
- 2/435 (0.46%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
- 1/17 (5.88%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast =====
- 1/105 (0.95%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_q15mulr_sat_s.wast =====
- 1/27 (3.70%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_sat_arith.wast =====
- 2/206 (0.97%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith.wast =====
- 2/183 (1.09%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith2.wast =====
- 2/123 (1.63%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast =====
- 2/435 (0.46%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast =====
- 1/27 (3.70%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
- 1/17 (5.88%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast =====
- 1/105 (0.95%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f32x4.wast =====
- 1/103 (0.97%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast =====
- 1/103 (0.97%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith.wast =====
- 2/189 (1.06%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith2.wast =====
- 2/23 (8.70%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast =====
- 1/103 (0.97%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast =====
- 1/105 (0.95%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith.wast =====
- 2/123 (1.63%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith2.wast =====
- 2/186 (1.08%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast =====
- 2/415 (0.48%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_sat_arith.wast =====
- 2/190 (1.05%)

===== ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast =====
- 1/229 (0.44%)

===== ../../test-interpreter/spec-test-3/simd/simd_lane.wast =====
- 11/286 (3.85%)

===== ../../test-interpreter/spec-test-3/simd/simd_linking.wast =====
- 0/2 (0.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load.wast =====
- 14/31 (45.16%)

===== ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast =====
- 1/33 (3.03%)

===== ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast =====
- 1/21 (4.76%)

===== ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast =====
- 1/13 (7.69%)

===== ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast =====
- 1/49 (2.04%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast =====
- 2/86 (2.33%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast =====
- 34/114 (29.82%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_zero.wast =====
- 6/29 (20.69%)

===== ../../test-interpreter/spec-test-3/simd/simd_splat.wast =====
- 3/162 (1.85%)

===== ../../test-interpreter/spec-test-3/simd/simd_store.wast =====
- 2/19 (10.53%)

===== ../../test-interpreter/spec-test-3/simd/simd_store16_lane.wast =====
- 0/33 (0.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store32_lane.wast =====
- 0/21 (0.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store64_lane.wast =====
- 0/13 (0.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store8_lane.wast =====
- 0/49 (0.00%)

===== ../../test-interpreter/spec-test-3/skip-stack-guard-page.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/stack.wast =====
- 2/7 (28.57%)

===== ../../test-interpreter/spec-test-3/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 4/16 (25.00%)

===== ../../test-interpreter/spec-test-3/store.wast =====
- 1/10 (10.00%)

===== ../../test-interpreter/spec-test-3/switch.wast =====
- 8/27 (29.63%)

===== ../../test-interpreter/spec-test-3/table-sub.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/table.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/table_copy.wast =====
- 1727/1727 (100.00%)

===== ../../test-interpreter/spec-test-3/table_fill.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/table_get.wast =====
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-3/table_grow.wast =====
- 41/43 (95.35%)

===== ../../test-interpreter/spec-test-3/table_init.wast =====
- 712/712 (100.00%)

===== ../../test-interpreter/spec-test-3/table_set.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/table_size.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-3/tail-call/return_call.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/tail-call/return_call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/tail-call/return_call_ref.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/token.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/tokens.wast =====
- 35/35 (100.00%)

===== ../../test-interpreter/spec-test-3/traps.wast =====
- 8/36 (22.22%)

===== ../../test-interpreter/spec-test-3/type.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/unreachable.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-3/unreached-invalid.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/unreached-valid.wast =====
- 7/7 (100.00%)

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

Total [6861/45764] (14.99%)

== Complete.
```
