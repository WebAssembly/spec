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
- 32/32 (100.00%)

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
- 246/246 (100.00%)

===== ../../test-interpreter/spec-test-1/align.wast =====
- 98/98 (100.00%)

===== ../../test-interpreter/spec-test-1/binary-leb128.wast =====
- 50/50 (100.00%)

===== ../../test-interpreter/spec-test-1/binary.wast =====
- 32/32 (100.00%)

===== ../../test-interpreter/spec-test-1/block.wast =====
- 43/43 (100.00%)

===== ../../test-interpreter/spec-test-1/br.wast =====
- 65/65 (100.00%)

===== ../../test-interpreter/spec-test-1/br_if.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-1/br_table.wast =====
- 148/148 (100.00%)

===== ../../test-interpreter/spec-test-1/break-drop.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-1/call.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-1/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/comments.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-1/const.wast =====
- 976/976 (100.00%)

===== ../../test-interpreter/spec-test-1/conversions.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/conversions.wast

===== ../../test-interpreter/spec-test-1/custom.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-1/data.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/data.wast

===== ../../test-interpreter/spec-test-1/elem.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/elem.wast

===== ../../test-interpreter/spec-test-1/endianness.wast =====
- 70/70 (100.00%)

===== ../../test-interpreter/spec-test-1/exports.wast =====
- 114/114 (100.00%)

===== ../../test-interpreter/spec-test-1/f32.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/f32.wast

===== ../../test-interpreter/spec-test-1/f32_bitwise.wast =====
- 362/362 (100.00%)

===== ../../test-interpreter/spec-test-1/f32_cmp.wast =====
- 2402/2402 (100.00%)

===== ../../test-interpreter/spec-test-1/f64.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/f64.wast

===== ../../test-interpreter/spec-test-1/f64_bitwise.wast =====
- 362/362 (100.00%)

===== ../../test-interpreter/spec-test-1/f64_cmp.wast =====
- 2402/2402 (100.00%)

===== ../../test-interpreter/spec-test-1/fac.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-1/float_exprs.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/float_exprs.wast

===== ../../test-interpreter/spec-test-1/float_literals.wast =====
- 87/87 (100.00%)

===== ../../test-interpreter/spec-test-1/float_memory.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-1/float_misc.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/float_misc.wast

===== ../../test-interpreter/spec-test-1/forward.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-1/func.wast =====
- 79/79 (100.00%)

===== ../../test-interpreter/spec-test-1/func_ptrs.wast =====
- print_i32: 83
- 32/32 (100.00%)

===== ../../test-interpreter/spec-test-1/globals.wast =====
- 56/56 (100.00%)

===== ../../test-interpreter/spec-test-1/i32.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-1/i64.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-1/if.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-1/imports.wast =====
- Failed to parse ../../test-interpreter/spec-test-1/imports.wast

===== ../../test-interpreter/spec-test-1/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-1/int_exprs.wast =====
- 127/127 (100.00%)

===== ../../test-interpreter/spec-test-1/int_literals.wast =====
- 32/32 (100.00%)

===== ../../test-interpreter/spec-test-1/labels.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-1/left-to-right.wast =====
- 97/97 (100.00%)

===== ../../test-interpreter/spec-test-1/linking.wast =====
- 129/129 (100.00%)

===== ../../test-interpreter/spec-test-1/load.wast =====
- 39/39 (100.00%)

===== ../../test-interpreter/spec-test-1/local_get.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-1/local_set.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-1/local_tee.wast =====
- 57/57 (100.00%)

===== ../../test-interpreter/spec-test-1/loop.wast =====
- 68/68 (100.00%)

===== ../../test-interpreter/spec-test-1/memory.wast =====
- 61/61 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_redundancy.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_size.wast =====
- 44/44 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_trap.wast =====
- 175/175 (100.00%)

===== ../../test-interpreter/spec-test-1/names.wast =====
- print_i32: 42
- print_i32: 123
- 487/487 (100.00%)

===== ../../test-interpreter/spec-test-1/nop.wast =====
- 85/85 (100.00%)

===== ../../test-interpreter/spec-test-1/return.wast =====
- 65/65 (100.00%)

===== ../../test-interpreter/spec-test-1/select.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-1/skip-stack-guard-page.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-1/stack.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-1/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 22/22 (100.00%)

===== ../../test-interpreter/spec-test-1/store.wast =====
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-1/switch.wast =====
- 28/28 (100.00%)

===== ../../test-interpreter/spec-test-1/token.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/traps.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-1/type.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-1/unreachable.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-1/unreached-invalid.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/unwind.wast =====
- 51/51 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-custom-section-id.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-import-field.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-import-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-invalid-encoding.wast =====
- 0/0 (100.00%)

8 parsing fail
Total [10584/10584] (100.00%)

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
- 263/263 (100.00%)

===== ../../test-interpreter/spec-test-2/align.wast =====
- 98/98 (100.00%)

===== ../../test-interpreter/spec-test-2/binary-leb128.wast =====
- 52/52 (100.00%)

===== ../../test-interpreter/spec-test-2/binary.wast =====
- 76/76 (100.00%)

===== ../../test-interpreter/spec-test-2/block.wast =====
- 54/54 (100.00%)

===== ../../test-interpreter/spec-test-2/br.wast =====
- 78/78 (100.00%)

===== ../../test-interpreter/spec-test-2/br_if.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-2/br_table.wast =====
- 151/151 (100.00%)

===== ../../test-interpreter/spec-test-2/bulk.wast =====
- 130/130 (100.00%)

===== ../../test-interpreter/spec-test-2/call.wast =====
- 72/72 (100.00%)

===== ../../test-interpreter/spec-test-2/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/comments.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-2/const.wast =====
- 1104/1104 (100.00%)

===== ../../test-interpreter/spec-test-2/conversions.wast =====
- 595/595 (100.00%)

===== ../../test-interpreter/spec-test-2/custom.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-2/data.wast =====
- 78/78 (100.00%)

===== ../../test-interpreter/spec-test-2/elem.wast =====
- 107/107 (100.00%)

===== ../../test-interpreter/spec-test-2/endianness.wast =====
- 70/70 (100.00%)

===== ../../test-interpreter/spec-test-2/exports.wast =====
- 121/121 (100.00%)

===== ../../test-interpreter/spec-test-2/f32.wast =====
- 2502/2502 (100.00%)

===== ../../test-interpreter/spec-test-2/f32_bitwise.wast =====
- 362/362 (100.00%)

===== ../../test-interpreter/spec-test-2/f32_cmp.wast =====
- 2402/2402 (100.00%)

===== ../../test-interpreter/spec-test-2/f64.wast =====
- 2502/2502 (100.00%)

===== ../../test-interpreter/spec-test-2/f64_bitwise.wast =====
- 362/362 (100.00%)

===== ../../test-interpreter/spec-test-2/f64_cmp.wast =====
- 2402/2402 (100.00%)

===== ../../test-interpreter/spec-test-2/fac.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-2/float_exprs.wast =====
- 996/996 (100.00%)

===== ../../test-interpreter/spec-test-2/float_literals.wast =====
- 87/87 (100.00%)

===== ../../test-interpreter/spec-test-2/float_memory.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-2/float_misc.wast =====
- 442/442 (100.00%)

===== ../../test-interpreter/spec-test-2/forward.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-2/func.wast =====
- 104/104 (100.00%)

===== ../../test-interpreter/spec-test-2/func_ptrs.wast =====
- print_i32: 83
- 32/32 (100.00%)

===== ../../test-interpreter/spec-test-2/global.wast =====
- 68/68 (100.00%)

===== ../../test-interpreter/spec-test-2/i32.wast =====
- 376/376 (100.00%)

===== ../../test-interpreter/spec-test-2/i64.wast =====
- 386/386 (100.00%)

===== ../../test-interpreter/spec-test-2/if.wast =====
- 125/125 (100.00%)

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
- 213/213 (100.00%)

===== ../../test-interpreter/spec-test-2/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-2/int_exprs.wast =====
- 127/127 (100.00%)

===== ../../test-interpreter/spec-test-2/int_literals.wast =====
- 32/32 (100.00%)

===== ../../test-interpreter/spec-test-2/labels.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-2/left-to-right.wast =====
- 97/97 (100.00%)

===== ../../test-interpreter/spec-test-2/linking.wast =====
- 151/151 (100.00%)

===== ../../test-interpreter/spec-test-2/load.wast =====
- 39/39 (100.00%)

===== ../../test-interpreter/spec-test-2/local_get.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-2/local_set.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-2/local_tee.wast =====
- 57/57 (100.00%)

===== ../../test-interpreter/spec-test-2/loop.wast =====
- 79/79 (100.00%)

===== ../../test-interpreter/spec-test-2/memory.wast =====
- 65/65 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_copy.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_fill.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_init.wast =====
- 197/197 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_redundancy.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_size.wast =====
- 44/44 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_trap.wast =====
- 184/184 (100.00%)

===== ../../test-interpreter/spec-test-2/names.wast =====
- print_i32: 42
- print_i32: 123
- 490/490 (100.00%)

===== ../../test-interpreter/spec-test-2/nop.wast =====
- 85/85 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_func.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_is_null.wast =====
- 15/15 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_null.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-2/return.wast =====
- 65/65 (100.00%)

===== ../../test-interpreter/spec-test-2/select.wast =====
- 122/122 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_address.wast =====
- 48/48 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_align.wast =====
- 100/100 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_bit_shift.wast =====
- 215/215 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_bitwise.wast =====
- 143/143 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_boolean.wast =====
- 263/263 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_const.wast =====
- 889/889 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_conversions.wast =====
- 236/236 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4.wast =====
- 776/776 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4_arith.wast =====
- 1809/1809 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4_cmp.wast =====
- 2585/2585 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4_pmin_pmax.wast =====
- 3874/3874 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f32x4_rounding.wast =====
- 178/178 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2.wast =====
- 797/797 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2_arith.wast =====
- 1812/1812 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2_cmp.wast =====
- 2663/2663 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2_pmin_pmax.wast =====
- 3874/3874 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_f64x2_rounding.wast =====
- 178/178 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_arith.wast =====
- 185/185 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_arith2.wast =====
- 155/155 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast =====
- 437/437 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
- 18/18 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast =====
- 106/106 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_q15mulr_sat_s.wast =====
- 28/28 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_sat_arith.wast =====
- 208/208 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_arith.wast =====
- 185/185 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_arith2.wast =====
- 125/125 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast =====
- 437/437 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast =====
- 28/28 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
- 18/18 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast =====
- 106/106 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast =====
- 104/104 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast =====
- 104/104 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_arith.wast =====
- 191/191 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_arith2.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast =====
- 104/104 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast =====
- 106/106 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_arith.wast =====
- 125/125 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_arith2.wast =====
- 188/188 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast =====
- 417/417 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_sat_arith.wast =====
- 192/192 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast =====
- 230/230 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_lane.wast =====
- 298/298 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_linking.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load.wast =====
- 45/45 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load16_lane.wast =====
- 34/34 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load32_lane.wast =====
- 22/22 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load64_lane.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load8_lane.wast =====
- 50/50 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast =====
- 88/88 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast =====
- 116/116 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_zero.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_splat.wast =====
- 166/166 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store16_lane.wast =====
- 34/34 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store32_lane.wast =====
- 22/22 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store64_lane.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_store8_lane.wast =====
- 50/50 (100.00%)

===== ../../test-interpreter/spec-test-2/skip-stack-guard-page.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-2/stack.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-2/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 22/22 (100.00%)

===== ../../test-interpreter/spec-test-2/store.wast =====
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-2/switch.wast =====
- 28/28 (100.00%)

===== ../../test-interpreter/spec-test-2/table-sub.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/table.wast =====
- 18/18 (100.00%)

===== ../../test-interpreter/spec-test-2/table_copy.wast =====
- 1779/1779 (100.00%)

===== ../../test-interpreter/spec-test-2/table_fill.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-2/table_get.wast =====
- 12/12 (100.00%)

===== ../../test-interpreter/spec-test-2/table_grow.wast =====
- 48/48 (100.00%)

===== ../../test-interpreter/spec-test-2/table_init.wast =====
- 747/747 (100.00%)

===== ../../test-interpreter/spec-test-2/table_set.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-2/table_size.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-2/token.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/tokens.wast =====
- 70/70 (100.00%)

===== ../../test-interpreter/spec-test-2/traps.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-2/type.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-2/unreachable.wast =====
- 65/65 (100.00%)

===== ../../test-interpreter/spec-test-2/unreached-invalid.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/unreached-valid.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-2/unwind.wast =====
- 51/51 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-custom-section-id.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-import-field.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-import-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-invalid-encoding.wast =====
- 0/0 (100.00%)

Total [46851/46851] (100.00%)

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
- 263/263 (100.00%)

===== ../../test-interpreter/spec-test-3/align.wast =====
- 140/140 (100.00%)

===== ../../test-interpreter/spec-test-3/annotations.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-3/binary-leb128.wast =====
- 66/66 (100.00%)

===== ../../test-interpreter/spec-test-3/binary.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-3/block.wast =====
- 209/209 (100.00%)

===== ../../test-interpreter/spec-test-3/br.wast =====
- 98/98 (100.00%)

===== ../../test-interpreter/spec-test-3/br_if.wast =====
- 120/120 (100.00%)

===== ../../test-interpreter/spec-test-3/br_on_non_null.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/br_on_null.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/br_table.wast =====
- 187/187 (100.00%)

===== ../../test-interpreter/spec-test-3/bulk.wast =====
- 130/130 (100.00%)

===== ../../test-interpreter/spec-test-3/call.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-3/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/call_ref.wast =====
- 39/39 (100.00%)

===== ../../test-interpreter/spec-test-3/comments.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/const.wast =====
- 1104/1104 (100.00%)

===== ../../test-interpreter/spec-test-3/conversions.wast =====
- 620/620 (100.00%)

===== ../../test-interpreter/spec-test-3/custom.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-3/data.wast =====
- 110/110 (100.00%)

===== ../../test-interpreter/spec-test-3/elem.wast =====
- 236/236 (100.00%)

===== ../../test-interpreter/spec-test-3/endianness.wast =====
- 70/70 (100.00%)

===== ../../test-interpreter/spec-test-3/exports.wast =====
- 153/153 (100.00%)

===== ../../test-interpreter/spec-test-3/f32.wast =====
- 2513/2513 (100.00%)

===== ../../test-interpreter/spec-test-3/f32_bitwise.wast =====
- 365/365 (100.00%)

===== ../../test-interpreter/spec-test-3/f32_cmp.wast =====
- 2408/2408 (100.00%)

===== ../../test-interpreter/spec-test-3/f64.wast =====
- 2513/2513 (100.00%)

===== ../../test-interpreter/spec-test-3/f64_bitwise.wast =====
- 365/365 (100.00%)

===== ../../test-interpreter/spec-test-3/f64_cmp.wast =====
- 2408/2408 (100.00%)

===== ../../test-interpreter/spec-test-3/fac.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-3/float_exprs.wast =====
- 1025/1025 (100.00%)

===== ../../test-interpreter/spec-test-3/float_literals.wast =====
- 103/103 (100.00%)

===== ../../test-interpreter/spec-test-3/float_memory.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-3/float_misc.wast =====
- 472/472 (100.00%)

===== ../../test-interpreter/spec-test-3/forward.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-3/func.wast =====
- 156/156 (100.00%)

===== ../../test-interpreter/spec-test-3/func_ptrs.wast =====
- print_i32: 83
- 39/39 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array.wast =====
- 53/53 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_copy.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_fill.wast =====
- 18/18 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_init_data.wast =====
- 34/34 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_init_elem.wast =====
- 24/24 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/binary-gc.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/br_on_cast.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/br_on_cast_fail.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/extern.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/i31.wast =====
- 79/79 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_cast.wast =====
- 47/47 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_eq.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_test.wast =====
- 73/73 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/struct.wast =====
- 35/35 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/type-subtyping.wast =====
- 135/135 (100.00%)

===== ../../test-interpreter/spec-test-3/global.wast =====
- 125/125 (100.00%)

===== ../../test-interpreter/spec-test-3/i32.wast =====
- 459/459 (100.00%)

===== ../../test-interpreter/spec-test-3/i64.wast =====
- 415/415 (100.00%)

===== ../../test-interpreter/spec-test-3/id.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-3/if.wast =====
- 218/218 (100.00%)

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
- 214/214 (100.00%)

===== ../../test-interpreter/spec-test-3/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/instance.wast =====
- 23/23 (100.00%)

===== ../../test-interpreter/spec-test-3/int_exprs.wast =====
- 127/127 (100.00%)

===== ../../test-interpreter/spec-test-3/int_literals.wast =====
- 32/32 (100.00%)

===== ../../test-interpreter/spec-test-3/labels.wast =====
- 30/30 (100.00%)

===== ../../test-interpreter/spec-test-3/left-to-right.wast =====
- 97/97 (100.00%)

===== ../../test-interpreter/spec-test-3/linking.wast =====
- 182/182 (100.00%)

===== ../../test-interpreter/spec-test-3/load.wast =====
- 108/108 (100.00%)

===== ../../test-interpreter/spec-test-3/local_get.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-3/local_init.wast =====
- 12/12 (100.00%)

===== ../../test-interpreter/spec-test-3/local_set.wast =====
- 54/54 (100.00%)

===== ../../test-interpreter/spec-test-3/local_tee.wast =====
- 99/99 (100.00%)

===== ../../test-interpreter/spec-test-3/loop.wast =====
- 106/106 (100.00%)

===== ../../test-interpreter/spec-test-3/memory-multi.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-3/memory.wast =====
- 91/91 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_copy.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_fill.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_init.wast =====
- 264/264 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_redundancy.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_size.wast =====
- 54/54 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_trap.wast =====
- 184/184 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/address0.wast =====
- 93/93 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/address1.wast =====
- 128/128 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/align0.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/binary0.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/data0.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/data1.wast =====
- 28/28 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/data_drop0.wast =====
- 12/12 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/exports0.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/float_exprs0.wast =====
- 15/15 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/float_exprs1.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/float_memory0.wast =====
- 32/32 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/imports0.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/imports1.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/imports2.wast =====
- 24/24 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/imports3.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/imports4.wast =====
- 18/18 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/linking0.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/linking1.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/linking2.wast =====
- 12/12 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/linking3.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/load0.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/load1.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/load2.wast =====
- 39/39 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_copy0.wast =====
- 30/30 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_copy1.wast =====
- 15/15 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_fill0.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_init0.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_size0.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_size1.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_size2.wast =====
- 22/22 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_size3.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_trap0.wast =====
- 15/15 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/memory_trap1.wast =====
- 169/169 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/start0.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/store0.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/store1.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/multi-memory/traps0.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/names.wast =====
- print_i32: 42
- print_i32: 123
- 490/490 (100.00%)

===== ../../test-interpreter/spec-test-3/nop.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-3/obsolete-keywords.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/ref.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_as_non_null.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_func.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_is_null.wast =====
- 24/24 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_null.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/relaxed-simd/i16x8_relaxed_q15mulr_s.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-3/relaxed-simd/i32x4_relaxed_trunc.wast =====
- 18/18 (100.00%)

===== ../../test-interpreter/spec-test-3/relaxed-simd/i8x16_relaxed_swizzle.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-3/relaxed-simd/relaxed_dot_product.wast =====
- 12/12 (100.00%)

===== ../../test-interpreter/spec-test-3/relaxed-simd/relaxed_laneselect.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/relaxed-simd/relaxed_madd_nmadd.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-3/relaxed-simd/relaxed_min_max.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-3/return.wast =====
- 85/85 (100.00%)

===== ../../test-interpreter/spec-test-3/return_call.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/return_call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/return_call_ref.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/select.wast =====
- 160/160 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_address.wast =====
- 48/48 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_align.wast =====
- 112/112 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_bit_shift.wast =====
- 239/239 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_bitwise.wast =====
- 171/171 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_boolean.wast =====
- 275/275 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_const.wast =====
- 889/889 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_conversions.wast =====
- 254/254 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4.wast =====
- 784/784 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_arith.wast =====
- 1825/1825 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_cmp.wast =====
- 2603/2603 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_pmin_pmax.wast =====
- 3880/3880 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_rounding.wast =====
- 186/186 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2.wast =====
- 805/805 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_arith.wast =====
- 1828/1828 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_cmp.wast =====
- 2681/2681 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_pmin_pmax.wast =====
- 3880/3880 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_rounding.wast =====
- 186/186 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_arith.wast =====
- 196/196 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_arith2.wast =====
- 172/172 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast =====
- 467/467 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
- 22/22 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast =====
- 118/118 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_q15mulr_sat_s.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_sat_arith.wast =====
- 220/220 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith.wast =====
- 196/196 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith2.wast =====
- 139/139 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast =====
- 467/467 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
- 22/22 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast =====
- 118/118 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f32x4.wast =====
- 108/108 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast =====
- 108/108 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith.wast =====
- 202/202 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith2.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast =====
- 114/114 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast =====
- 118/118 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith.wast =====
- 133/133 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith2.wast =====
- 207/207 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast =====
- 447/447 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_sat_arith.wast =====
- 204/204 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast =====
- 254/254 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_lane.wast =====
- 381/381 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_linking.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load.wast =====
- 50/50 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast =====
- 53/53 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast =====
- 100/100 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast =====
- 124/124 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_zero.wast =====
- 35/35 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_memory-multi.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_splat.wast =====
- 188/188 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store16_lane.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store32_lane.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store64_lane.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store8_lane.wast =====
- 53/53 (100.00%)

===== ../../test-interpreter/spec-test-3/skip-stack-guard-page.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-3/stack.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-3/store.wast =====
- 108/108 (100.00%)

===== ../../test-interpreter/spec-test-3/switch.wast =====
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-3/table-sub.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-3/table.wast =====
- 53/53 (100.00%)

===== ../../test-interpreter/spec-test-3/table_copy.wast =====
- 1779/1779 (100.00%)

===== ../../test-interpreter/spec-test-3/table_fill.wast =====
- 46/46 (100.00%)

===== ../../test-interpreter/spec-test-3/table_get.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/table_grow.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-3/table_init.wast =====
- 814/814 (100.00%)

===== ../../test-interpreter/spec-test-3/table_set.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-3/table_size.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-3/tag.wast =====
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-3/throw.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/throw_ref.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/token.wast =====
- 70/70 (100.00%)

===== ../../test-interpreter/spec-test-3/traps.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-3/try_table.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-3/type-canon.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-3/type-equivalence.wast =====
- 47/47 (100.00%)

===== ../../test-interpreter/spec-test-3/type-rec.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-3/type.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-3/unreachable.wast =====
- 65/65 (100.00%)

===== ../../test-interpreter/spec-test-3/unreached-invalid.wast =====
- 121/121 (100.00%)

===== ../../test-interpreter/spec-test-3/unreached-valid.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/unwind.wast =====
- 51/51 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-custom-section-id.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-import-field.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-import-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-invalid-encoding.wast =====
- 0/0 (100.00%)

Total [51321/51321] (100.00%)

== Complete.
```
