# Preview

```sh
$ ../src/exe-spectec/main.exe ../../../_specification/wasm-3.0/*.spectec -v -l --interpreter ../test-interpreter/sample.wat addTwo 30 12 2>&1
spectec 0.5 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../test-interpreter/sample.wat =====
42
== Complete.
$ ../src/exe-spectec/main.exe ../../../_specification/wasm-3.0/*.spectec -v -l --interpreter ../test-interpreter/sample.wasm addTwo 40 2 2>&1
spectec 0.5 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../test-interpreter/sample.wasm =====
42
== Complete.
$ ../src/exe-spectec/main.exe ../../../_specification/wasm-3.0/*.spectec -v -l --interpreter ../test-interpreter/sample.wast 2>&1
spectec 0.5 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../test-interpreter/sample.wast =====
- print_i32: 10
== Complete.
$ for v in 1 2 3; do ( \
>   echo "Running test for Wasm $v.0..." && \
>   ../src/exe-spectec/main.exe ../../../_specification/wasm-$v.0/*.spectec -v -l --test-version $v --interpreter ../test-interpreter/spec-test-$v \
> ) done 2>&1
Running test for Wasm 1.0...
spectec 0.5 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../test-interpreter/spec-test-1/address.wast =====
===== ../test-interpreter/spec-test-1/align.wast =====
===== ../test-interpreter/spec-test-1/binary-leb128.wast =====
===== ../test-interpreter/spec-test-1/binary.wast =====
===== ../test-interpreter/spec-test-1/block.wast =====
===== ../test-interpreter/spec-test-1/br.wast =====
===== ../test-interpreter/spec-test-1/br_if.wast =====
===== ../test-interpreter/spec-test-1/br_table.wast =====
===== ../test-interpreter/spec-test-1/break-drop.wast =====
===== ../test-interpreter/spec-test-1/call.wast =====
===== ../test-interpreter/spec-test-1/call_indirect.wast =====
===== ../test-interpreter/spec-test-1/comments.wast =====
===== ../test-interpreter/spec-test-1/const.wast =====
===== ../test-interpreter/spec-test-1/conversions.wast =====
- Failed to parse ../test-interpreter/spec-test-1/conversions.wast

===== ../test-interpreter/spec-test-1/custom.wast =====
===== ../test-interpreter/spec-test-1/data.wast =====
- Failed to parse ../test-interpreter/spec-test-1/data.wast

===== ../test-interpreter/spec-test-1/elem.wast =====
- Failed to parse ../test-interpreter/spec-test-1/elem.wast

===== ../test-interpreter/spec-test-1/endianness.wast =====
===== ../test-interpreter/spec-test-1/exports.wast =====
===== ../test-interpreter/spec-test-1/f32.wast =====
- Failed to parse ../test-interpreter/spec-test-1/f32.wast

===== ../test-interpreter/spec-test-1/f32_bitwise.wast =====
===== ../test-interpreter/spec-test-1/f32_cmp.wast =====
===== ../test-interpreter/spec-test-1/f64.wast =====
- Failed to parse ../test-interpreter/spec-test-1/f64.wast

===== ../test-interpreter/spec-test-1/f64_bitwise.wast =====
===== ../test-interpreter/spec-test-1/f64_cmp.wast =====
===== ../test-interpreter/spec-test-1/fac.wast =====
===== ../test-interpreter/spec-test-1/float_exprs.wast =====
- Failed to parse ../test-interpreter/spec-test-1/float_exprs.wast

===== ../test-interpreter/spec-test-1/float_literals.wast =====
===== ../test-interpreter/spec-test-1/float_memory.wast =====
===== ../test-interpreter/spec-test-1/float_misc.wast =====
- Failed to parse ../test-interpreter/spec-test-1/float_misc.wast

===== ../test-interpreter/spec-test-1/forward.wast =====
===== ../test-interpreter/spec-test-1/func.wast =====
===== ../test-interpreter/spec-test-1/func_ptrs.wast =====
- print_i32: 83
===== ../test-interpreter/spec-test-1/globals.wast =====
===== ../test-interpreter/spec-test-1/i32.wast =====
===== ../test-interpreter/spec-test-1/i64.wast =====
===== ../test-interpreter/spec-test-1/if.wast =====
===== ../test-interpreter/spec-test-1/imports.wast =====
- Failed to parse ../test-interpreter/spec-test-1/imports.wast

===== ../test-interpreter/spec-test-1/inline-module.wast =====
===== ../test-interpreter/spec-test-1/int_exprs.wast =====
===== ../test-interpreter/spec-test-1/int_literals.wast =====
===== ../test-interpreter/spec-test-1/labels.wast =====
===== ../test-interpreter/spec-test-1/left-to-right.wast =====
===== ../test-interpreter/spec-test-1/linking.wast =====
===== ../test-interpreter/spec-test-1/load.wast =====
===== ../test-interpreter/spec-test-1/local_get.wast =====
===== ../test-interpreter/spec-test-1/local_set.wast =====
===== ../test-interpreter/spec-test-1/local_tee.wast =====
===== ../test-interpreter/spec-test-1/loop.wast =====
===== ../test-interpreter/spec-test-1/memory.wast =====
===== ../test-interpreter/spec-test-1/memory_grow.wast =====
===== ../test-interpreter/spec-test-1/memory_redundancy.wast =====
===== ../test-interpreter/spec-test-1/memory_size.wast =====
===== ../test-interpreter/spec-test-1/memory_trap.wast =====
===== ../test-interpreter/spec-test-1/names.wast =====
- print_i32: 42
- print_i32: 123
===== ../test-interpreter/spec-test-1/nop.wast =====
===== ../test-interpreter/spec-test-1/return.wast =====
===== ../test-interpreter/spec-test-1/select.wast =====
===== ../test-interpreter/spec-test-1/skip-stack-guard-page.wast =====
===== ../test-interpreter/spec-test-1/stack.wast =====
===== ../test-interpreter/spec-test-1/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
===== ../test-interpreter/spec-test-1/store.wast =====
===== ../test-interpreter/spec-test-1/switch.wast =====
===== ../test-interpreter/spec-test-1/token.wast =====
===== ../test-interpreter/spec-test-1/traps.wast =====
===== ../test-interpreter/spec-test-1/type.wast =====
===== ../test-interpreter/spec-test-1/unreachable.wast =====
===== ../test-interpreter/spec-test-1/unreached-invalid.wast =====
===== ../test-interpreter/spec-test-1/unwind.wast =====
===== ../test-interpreter/spec-test-1/utf8-custom-section-id.wast =====
===== ../test-interpreter/spec-test-1/utf8-import-field.wast =====
===== ../test-interpreter/spec-test-1/utf8-import-module.wast =====
===== ../test-interpreter/spec-test-1/utf8-invalid-encoding.wast =====
8 parsing fail
== Complete.
Running test for Wasm 2.0...
spectec 0.5 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../test-interpreter/spec-test-2/address.wast =====
===== ../test-interpreter/spec-test-2/align.wast =====
===== ../test-interpreter/spec-test-2/binary-leb128.wast =====
===== ../test-interpreter/spec-test-2/binary.wast =====
===== ../test-interpreter/spec-test-2/block.wast =====
===== ../test-interpreter/spec-test-2/br.wast =====
===== ../test-interpreter/spec-test-2/br_if.wast =====
===== ../test-interpreter/spec-test-2/br_table.wast =====
===== ../test-interpreter/spec-test-2/bulk.wast =====
===== ../test-interpreter/spec-test-2/call.wast =====
===== ../test-interpreter/spec-test-2/call_indirect.wast =====
===== ../test-interpreter/spec-test-2/comments.wast =====
===== ../test-interpreter/spec-test-2/const.wast =====
===== ../test-interpreter/spec-test-2/conversions.wast =====
===== ../test-interpreter/spec-test-2/custom.wast =====
===== ../test-interpreter/spec-test-2/data.wast =====
===== ../test-interpreter/spec-test-2/elem.wast =====
===== ../test-interpreter/spec-test-2/endianness.wast =====
===== ../test-interpreter/spec-test-2/exports.wast =====
===== ../test-interpreter/spec-test-2/f32.wast =====
===== ../test-interpreter/spec-test-2/f32_bitwise.wast =====
===== ../test-interpreter/spec-test-2/f32_cmp.wast =====
===== ../test-interpreter/spec-test-2/f64.wast =====
===== ../test-interpreter/spec-test-2/f64_bitwise.wast =====
===== ../test-interpreter/spec-test-2/f64_cmp.wast =====
===== ../test-interpreter/spec-test-2/fac.wast =====
===== ../test-interpreter/spec-test-2/float_exprs.wast =====
===== ../test-interpreter/spec-test-2/float_literals.wast =====
===== ../test-interpreter/spec-test-2/float_memory.wast =====
===== ../test-interpreter/spec-test-2/float_misc.wast =====
===== ../test-interpreter/spec-test-2/forward.wast =====
===== ../test-interpreter/spec-test-2/func.wast =====
===== ../test-interpreter/spec-test-2/func_ptrs.wast =====
- print_i32: 83
===== ../test-interpreter/spec-test-2/global.wast =====
===== ../test-interpreter/spec-test-2/i32.wast =====
===== ../test-interpreter/spec-test-2/i64.wast =====
===== ../test-interpreter/spec-test-2/if.wast =====
===== ../test-interpreter/spec-test-2/imports.wast =====
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
===== ../test-interpreter/spec-test-2/inline-module.wast =====
===== ../test-interpreter/spec-test-2/int_exprs.wast =====
===== ../test-interpreter/spec-test-2/int_literals.wast =====
===== ../test-interpreter/spec-test-2/labels.wast =====
===== ../test-interpreter/spec-test-2/left-to-right.wast =====
===== ../test-interpreter/spec-test-2/linking.wast =====
===== ../test-interpreter/spec-test-2/load.wast =====
===== ../test-interpreter/spec-test-2/local_get.wast =====
===== ../test-interpreter/spec-test-2/local_set.wast =====
===== ../test-interpreter/spec-test-2/local_tee.wast =====
===== ../test-interpreter/spec-test-2/loop.wast =====
===== ../test-interpreter/spec-test-2/memory.wast =====
===== ../test-interpreter/spec-test-2/memory_copy.wast =====
===== ../test-interpreter/spec-test-2/memory_fill.wast =====
===== ../test-interpreter/spec-test-2/memory_grow.wast =====
===== ../test-interpreter/spec-test-2/memory_init.wast =====
===== ../test-interpreter/spec-test-2/memory_redundancy.wast =====
===== ../test-interpreter/spec-test-2/memory_size.wast =====
===== ../test-interpreter/spec-test-2/memory_trap.wast =====
===== ../test-interpreter/spec-test-2/names.wast =====
- print_i32: 42
- print_i32: 123
===== ../test-interpreter/spec-test-2/nop.wast =====
===== ../test-interpreter/spec-test-2/ref_func.wast =====
===== ../test-interpreter/spec-test-2/ref_is_null.wast =====
===== ../test-interpreter/spec-test-2/ref_null.wast =====
===== ../test-interpreter/spec-test-2/return.wast =====
===== ../test-interpreter/spec-test-2/select.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_address.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_align.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_bit_shift.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_bitwise.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_boolean.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_const.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_conversions.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_f32x4.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_f32x4_arith.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_f32x4_cmp.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_f32x4_pmin_pmax.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_f32x4_rounding.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_f64x2.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_f64x2_arith.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_f64x2_cmp.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_f64x2_pmin_pmax.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_f64x2_rounding.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i16x8_arith.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i16x8_arith2.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i16x8_q15mulr_sat_s.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i16x8_sat_arith.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i32x4_arith.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i32x4_arith2.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i64x2_arith.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i64x2_arith2.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i8x16_arith.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i8x16_arith2.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_i8x16_sat_arith.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_lane.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_linking.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_load.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_load16_lane.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_load32_lane.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_load64_lane.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_load8_lane.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_load_extend.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_load_splat.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_load_zero.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_splat.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_store.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_store16_lane.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_store32_lane.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_store64_lane.wast =====
===== ../test-interpreter/spec-test-2/simd/simd_store8_lane.wast =====
===== ../test-interpreter/spec-test-2/skip-stack-guard-page.wast =====
===== ../test-interpreter/spec-test-2/stack.wast =====
===== ../test-interpreter/spec-test-2/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
===== ../test-interpreter/spec-test-2/store.wast =====
===== ../test-interpreter/spec-test-2/switch.wast =====
===== ../test-interpreter/spec-test-2/table-sub.wast =====
===== ../test-interpreter/spec-test-2/table.wast =====
===== ../test-interpreter/spec-test-2/table_copy.wast =====
===== ../test-interpreter/spec-test-2/table_fill.wast =====
===== ../test-interpreter/spec-test-2/table_get.wast =====
===== ../test-interpreter/spec-test-2/table_grow.wast =====
===== ../test-interpreter/spec-test-2/table_init.wast =====
===== ../test-interpreter/spec-test-2/table_set.wast =====
===== ../test-interpreter/spec-test-2/table_size.wast =====
===== ../test-interpreter/spec-test-2/token.wast =====
===== ../test-interpreter/spec-test-2/tokens.wast =====
===== ../test-interpreter/spec-test-2/traps.wast =====
===== ../test-interpreter/spec-test-2/type.wast =====
===== ../test-interpreter/spec-test-2/unreachable.wast =====
===== ../test-interpreter/spec-test-2/unreached-invalid.wast =====
===== ../test-interpreter/spec-test-2/unreached-valid.wast =====
===== ../test-interpreter/spec-test-2/unwind.wast =====
===== ../test-interpreter/spec-test-2/utf8-custom-section-id.wast =====
===== ../test-interpreter/spec-test-2/utf8-import-field.wast =====
===== ../test-interpreter/spec-test-2/utf8-import-module.wast =====
===== ../test-interpreter/spec-test-2/utf8-invalid-encoding.wast =====
== Complete.
Running test for Wasm 3.0...
spectec 0.5 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Initializing interpreter...
== Interpreting...
===== ../test-interpreter/spec-test-3/address.wast =====
===== ../test-interpreter/spec-test-3/align.wast =====
===== ../test-interpreter/spec-test-3/annotations.wast =====
===== ../test-interpreter/spec-test-3/binary-leb128.wast =====
===== ../test-interpreter/spec-test-3/binary.wast =====
===== ../test-interpreter/spec-test-3/block.wast =====
===== ../test-interpreter/spec-test-3/br.wast =====
===== ../test-interpreter/spec-test-3/br_if.wast =====
===== ../test-interpreter/spec-test-3/br_on_non_null.wast =====
===== ../test-interpreter/spec-test-3/br_on_null.wast =====
===== ../test-interpreter/spec-test-3/br_table.wast =====
===== ../test-interpreter/spec-test-3/bulk-memory/bulk.wast =====
===== ../test-interpreter/spec-test-3/bulk-memory/memory_copy.wast =====
===== ../test-interpreter/spec-test-3/bulk-memory/memory_fill.wast =====
===== ../test-interpreter/spec-test-3/bulk-memory/memory_init.wast =====
===== ../test-interpreter/spec-test-3/bulk-memory/table-sub.wast =====
===== ../test-interpreter/spec-test-3/bulk-memory/table_copy.wast =====
===== ../test-interpreter/spec-test-3/bulk-memory/table_fill.wast =====
===== ../test-interpreter/spec-test-3/bulk-memory/table_init.wast =====
===== ../test-interpreter/spec-test-3/call.wast =====
===== ../test-interpreter/spec-test-3/call_indirect.wast =====
===== ../test-interpreter/spec-test-3/call_ref.wast =====
===== ../test-interpreter/spec-test-3/comments.wast =====
===== ../test-interpreter/spec-test-3/const.wast =====
===== ../test-interpreter/spec-test-3/conversions.wast =====
===== ../test-interpreter/spec-test-3/custom.wast =====
===== ../test-interpreter/spec-test-3/data.wast =====
===== ../test-interpreter/spec-test-3/elem.wast =====
===== ../test-interpreter/spec-test-3/endianness.wast =====
===== ../test-interpreter/spec-test-3/exceptions/tag.wast =====
===== ../test-interpreter/spec-test-3/exceptions/throw.wast =====
===== ../test-interpreter/spec-test-3/exceptions/throw_ref.wast =====
===== ../test-interpreter/spec-test-3/exceptions/try_table.wast =====
===== ../test-interpreter/spec-test-3/exports.wast =====
===== ../test-interpreter/spec-test-3/f32.wast =====
===== ../test-interpreter/spec-test-3/f32_bitwise.wast =====
===== ../test-interpreter/spec-test-3/f32_cmp.wast =====
===== ../test-interpreter/spec-test-3/f64.wast =====
===== ../test-interpreter/spec-test-3/f64_bitwise.wast =====
===== ../test-interpreter/spec-test-3/f64_cmp.wast =====
===== ../test-interpreter/spec-test-3/fac.wast =====
===== ../test-interpreter/spec-test-3/float_exprs.wast =====
===== ../test-interpreter/spec-test-3/float_literals.wast =====
===== ../test-interpreter/spec-test-3/float_memory.wast =====
===== ../test-interpreter/spec-test-3/float_misc.wast =====
===== ../test-interpreter/spec-test-3/forward.wast =====
===== ../test-interpreter/spec-test-3/func.wast =====
===== ../test-interpreter/spec-test-3/func_ptrs.wast =====
- print_i32: 83
===== ../test-interpreter/spec-test-3/gc/array.wast =====
===== ../test-interpreter/spec-test-3/gc/array_copy.wast =====
===== ../test-interpreter/spec-test-3/gc/array_fill.wast =====
===== ../test-interpreter/spec-test-3/gc/array_init_data.wast =====
===== ../test-interpreter/spec-test-3/gc/array_init_elem.wast =====
===== ../test-interpreter/spec-test-3/gc/array_new_data.wast =====
===== ../test-interpreter/spec-test-3/gc/array_new_elem.wast =====
===== ../test-interpreter/spec-test-3/gc/binary-gc.wast =====
===== ../test-interpreter/spec-test-3/gc/br_on_cast.wast =====
===== ../test-interpreter/spec-test-3/gc/br_on_cast_fail.wast =====
===== ../test-interpreter/spec-test-3/gc/extern.wast =====
===== ../test-interpreter/spec-test-3/gc/i31.wast =====
===== ../test-interpreter/spec-test-3/gc/ref_cast.wast =====
===== ../test-interpreter/spec-test-3/gc/ref_eq.wast =====
===== ../test-interpreter/spec-test-3/gc/ref_test.wast =====
===== ../test-interpreter/spec-test-3/gc/struct.wast =====
===== ../test-interpreter/spec-test-3/gc/type-subtyping.wast =====
===== ../test-interpreter/spec-test-3/global.wast =====
===== ../test-interpreter/spec-test-3/i32.wast =====
===== ../test-interpreter/spec-test-3/i64.wast =====
===== ../test-interpreter/spec-test-3/id.wast =====
===== ../test-interpreter/spec-test-3/if.wast =====
===== ../test-interpreter/spec-test-3/imports.wast =====
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
===== ../test-interpreter/spec-test-3/inline-module.wast =====
===== ../test-interpreter/spec-test-3/instance.wast =====
===== ../test-interpreter/spec-test-3/int_exprs.wast =====
===== ../test-interpreter/spec-test-3/int_literals.wast =====
===== ../test-interpreter/spec-test-3/labels.wast =====
===== ../test-interpreter/spec-test-3/left-to-right.wast =====
===== ../test-interpreter/spec-test-3/linking.wast =====
===== ../test-interpreter/spec-test-3/load.wast =====
===== ../test-interpreter/spec-test-3/local_get.wast =====
===== ../test-interpreter/spec-test-3/local_init.wast =====
===== ../test-interpreter/spec-test-3/local_set.wast =====
===== ../test-interpreter/spec-test-3/local_tee.wast =====
===== ../test-interpreter/spec-test-3/loop.wast =====
===== ../test-interpreter/spec-test-3/memory.wast =====
===== ../test-interpreter/spec-test-3/memory64/address64.wast =====
===== ../test-interpreter/spec-test-3/memory64/align64.wast =====
===== ../test-interpreter/spec-test-3/memory64/binary_leb128_64.wast =====
===== ../test-interpreter/spec-test-3/memory64/bulk64.wast =====
===== ../test-interpreter/spec-test-3/memory64/call_indirect64.wast =====
===== ../test-interpreter/spec-test-3/memory64/endianness64.wast =====
===== ../test-interpreter/spec-test-3/memory64/float_memory64.wast =====
===== ../test-interpreter/spec-test-3/memory64/load64.wast =====
===== ../test-interpreter/spec-test-3/memory64/memory64-imports.wast =====
===== ../test-interpreter/spec-test-3/memory64/memory64.wast =====
===== ../test-interpreter/spec-test-3/memory64/memory_copy64.wast =====
===== ../test-interpreter/spec-test-3/memory64/memory_fill64.wast =====
===== ../test-interpreter/spec-test-3/memory64/memory_grow64.wast =====
===== ../test-interpreter/spec-test-3/memory64/memory_init64.wast =====
===== ../test-interpreter/spec-test-3/memory64/memory_redundancy64.wast =====
===== ../test-interpreter/spec-test-3/memory64/memory_trap64.wast =====
===== ../test-interpreter/spec-test-3/memory64/table64.wast =====
===== ../test-interpreter/spec-test-3/memory64/table_copy64.wast =====
===== ../test-interpreter/spec-test-3/memory64/table_copy_mixed.wast =====
===== ../test-interpreter/spec-test-3/memory64/table_fill64.wast =====
===== ../test-interpreter/spec-test-3/memory64/table_get64.wast =====
===== ../test-interpreter/spec-test-3/memory64/table_grow64.wast =====
===== ../test-interpreter/spec-test-3/memory64/table_init64.wast =====
===== ../test-interpreter/spec-test-3/memory64/table_set64.wast =====
===== ../test-interpreter/spec-test-3/memory64/table_size64.wast =====
===== ../test-interpreter/spec-test-3/memory_grow.wast =====
===== ../test-interpreter/spec-test-3/memory_redundancy.wast =====
===== ../test-interpreter/spec-test-3/memory_size.wast =====
===== ../test-interpreter/spec-test-3/memory_trap.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/address0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/address1.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/align0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/binary0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/data0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/data1.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/data_drop0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/exports0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/float_exprs0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/float_exprs1.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/float_memory0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/imports0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/imports1.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/imports2.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/imports3.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/imports4.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/linking0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/linking1.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/linking2.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/linking3.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/load0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/load1.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/load2.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory-multi.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory_copy0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory_copy1.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory_fill0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory_grow.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory_init0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory_size0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory_size1.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory_size2.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory_size3.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory_size_import.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory_trap0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/memory_trap1.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/start0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/store0.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/store1.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/store2.wast =====
===== ../test-interpreter/spec-test-3/multi-memory/traps0.wast =====
===== ../test-interpreter/spec-test-3/names.wast =====
- print_i32: 42
- print_i32: 123
===== ../test-interpreter/spec-test-3/nop.wast =====
===== ../test-interpreter/spec-test-3/obsolete-keywords.wast =====
===== ../test-interpreter/spec-test-3/ref.wast =====
===== ../test-interpreter/spec-test-3/ref_as_non_null.wast =====
===== ../test-interpreter/spec-test-3/ref_func.wast =====
===== ../test-interpreter/spec-test-3/ref_is_null.wast =====
===== ../test-interpreter/spec-test-3/ref_null.wast =====
===== ../test-interpreter/spec-test-3/relaxed-simd/i16x8_relaxed_q15mulr_s.wast =====
===== ../test-interpreter/spec-test-3/relaxed-simd/i32x4_relaxed_trunc.wast =====
===== ../test-interpreter/spec-test-3/relaxed-simd/i8x16_relaxed_swizzle.wast =====
===== ../test-interpreter/spec-test-3/relaxed-simd/relaxed_dot_product.wast =====
===== ../test-interpreter/spec-test-3/relaxed-simd/relaxed_laneselect.wast =====
===== ../test-interpreter/spec-test-3/relaxed-simd/relaxed_madd_nmadd.wast =====
===== ../test-interpreter/spec-test-3/relaxed-simd/relaxed_min_max.wast =====
===== ../test-interpreter/spec-test-3/return.wast =====
===== ../test-interpreter/spec-test-3/return_call.wast =====
===== ../test-interpreter/spec-test-3/return_call_indirect.wast =====
===== ../test-interpreter/spec-test-3/return_call_ref.wast =====
===== ../test-interpreter/spec-test-3/select.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_address.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_align.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_bit_shift.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_bitwise.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_boolean.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_const.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_conversions.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_f32x4.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_f32x4_arith.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_f32x4_cmp.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_f32x4_pmin_pmax.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_f32x4_rounding.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_f64x2.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_f64x2_arith.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_f64x2_cmp.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_f64x2_pmin_pmax.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_f64x2_rounding.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i16x8_arith.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i16x8_arith2.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i16x8_q15mulr_sat_s.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i16x8_sat_arith.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i32x4_arith.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i32x4_arith2.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f32x4.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i64x2_arith.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i64x2_arith2.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i8x16_arith.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i8x16_arith2.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_i8x16_sat_arith.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_lane.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_linking.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_load.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_load16_lane.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_load32_lane.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_load64_lane.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_load8_lane.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_load_extend.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_load_splat.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_load_zero.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_memory-multi.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_select.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_splat.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_store.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_store16_lane.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_store32_lane.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_store64_lane.wast =====
===== ../test-interpreter/spec-test-3/simd/simd_store8_lane.wast =====
===== ../test-interpreter/spec-test-3/skip-stack-guard-page.wast =====
===== ../test-interpreter/spec-test-3/stack.wast =====
===== ../test-interpreter/spec-test-3/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
===== ../test-interpreter/spec-test-3/store.wast =====
===== ../test-interpreter/spec-test-3/switch.wast =====
===== ../test-interpreter/spec-test-3/table.wast =====
===== ../test-interpreter/spec-test-3/table_get.wast =====
===== ../test-interpreter/spec-test-3/table_grow.wast =====
===== ../test-interpreter/spec-test-3/table_set.wast =====
===== ../test-interpreter/spec-test-3/table_size.wast =====
===== ../test-interpreter/spec-test-3/token.wast =====
===== ../test-interpreter/spec-test-3/traps.wast =====
===== ../test-interpreter/spec-test-3/type-canon.wast =====
===== ../test-interpreter/spec-test-3/type-equivalence.wast =====
===== ../test-interpreter/spec-test-3/type-rec.wast =====
===== ../test-interpreter/spec-test-3/type.wast =====
===== ../test-interpreter/spec-test-3/unreachable.wast =====
===== ../test-interpreter/spec-test-3/unreached-invalid.wast =====
===== ../test-interpreter/spec-test-3/unreached-valid.wast =====
===== ../test-interpreter/spec-test-3/unwind.wast =====
===== ../test-interpreter/spec-test-3/utf8-custom-section-id.wast =====
===== ../test-interpreter/spec-test-3/utf8-import-field.wast =====
===== ../test-interpreter/spec-test-3/utf8-import-module.wast =====
===== ../test-interpreter/spec-test-3/utf8-invalid-encoding.wast =====
== Complete.
```
