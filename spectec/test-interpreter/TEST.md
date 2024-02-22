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
42
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
42
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
- print_i32: 10
- 30/30 (100.00%)

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
== Running pass animate...
== IL Validation after pass animate...
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
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:39.1-40.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:41.1-42.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:43.1-44.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:45.1-46.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:47.1-48.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:49.1-50.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:51.1-52.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:53.1-54.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:55.1-56.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:57.1-58.64 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:303.30-303.33"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:59.1-60.64 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:303.30-303.33"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:85.1-86.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:87.1-88.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:89.1-90.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:91.1-92.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:93.1-94.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:95.1-96.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:97.1-98.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:99.1-100.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:101.1-102.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:103.1-104.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:105.1-106.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:107.1-108.64 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:303.30-303.33"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:109.1-110.64 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:303.30-303.33"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:135.1-136.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:137.1-138.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:139.1-140.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:141.1-142.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:143.1-144.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:145.1-146.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:147.1-148.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:149.1-150.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:151.1-152.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:153.1-154.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:155.1-156.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:157.1-158.64 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:303.30-303.33"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:159.1-160.64 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:303.30-303.33"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:163.1-164.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:165.1-166.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:167.1-168.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:169.1-170.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:171.1-172.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:173.1-174.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:175.1-176.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:177.1-178.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:179.1-180.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:181.1-182.64 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:303.30-303.33"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:183.1-184.64 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:303.30-303.33"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:495.1-496.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:497.1-498.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:499.1-500.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:502.1-503.66 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:504.1-505.66 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:506.1-507.66 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:509.1-510.66 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:511.1-512.66 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:513.1-514.66 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:530.1-531.70 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:532.1-533.70 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:534.1-535.70 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:536.1-537.70 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:538.1-539.70 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:540.1-541.70 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:556.1-557.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:558.1-559.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:560.1-561.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:562.1-563.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:564.1-565.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:566.1-567.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:653.1-655.74 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:656.1-658.74 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:659.1-661.74 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:662.1-664.74 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:665.1-667.74 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:668.1-670.74 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:671.1-673.74 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:674.1-676.74 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:677.1-679.74 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:681.1-683.73 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:684.1-686.73 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:687.1-689.73 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:690.1-692.73 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:693.1-695.73 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:696.1-698.73 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:699.1-701.73 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:702.1-704.73 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:705.1-707.73 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:709.1-711.74 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:712.1-714.74 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:715.1-717.74 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:718.1-720.74 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:721.1-723.74 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:724.1-726.74 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:727.1-729.74 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:730.1-732.74 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:733.1-735.74 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:865.1-866.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:867.1-868.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:869.1-870.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:871.1-872.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:873.1-874.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:875.1-876.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:877.1-878.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:879.1-880.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:881.1-882.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:884.1-886.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:887.1-889.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:890.1-892.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:893.1-895.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:896.1-898.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:899.1-901.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:902.1-904.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:905.1-907.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:908.1-910.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:912.1-914.68 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:915.1-917.68 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:918.1-920.68 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:921.1-923.68 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:924.1-926.68 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:927.1-929.68 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:930.1-932.68 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:933.1-935.68 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:936.1-938.68 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:940.1-942.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:943.1-945.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:946.1-948.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:949.1-951.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:952.1-954.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:955.1-957.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:958.1-960.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:961.1-963.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:964.1-966.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:968.1-971.75 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:972.1-975.75 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:976.1-979.75 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:980.1-983.75 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:984.1-987.75 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_boolean.wast:988.1-991.75 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- 123/261 (47.13%)

===== ../../test-interpreter/spec-test-2/simd/simd_const.wast =====
- 577/577 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_conversions.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:35.1-36.77 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:37.1-38.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:39.1-40.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:41.1-42.89 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:43.1-44.77 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:45.1-46.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:47.1-48.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:49.1-50.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:52.1-53.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:55.1-56.115 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:57.1-58.77 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:59.1-60.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:61.1-62.97 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:63.1-64.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:65.1-66.97 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:67.1-68.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:73.1-74.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:75.1-76.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:77.1-78.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:79.1-80.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:81.1-82.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:83.1-84.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:85.1-86.91 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:87.1-88.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:89.1-90.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:91.1-92.107 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:93.1-94.91 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:95.1-96.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:97.1-98.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:99.1-100.107 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:101.1-102.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:103.1-104.107 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:105.1-106.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:107.1-108.107 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:109.1-110.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:111.1-112.107 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:113.1-114.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:115.1-116.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:117.1-118.91 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:119.1-120.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:121.1-122.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:123.1-124.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:125.1-126.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:127.1-128.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:129.1-130.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:131.1-132.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:133.1-134.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:135.1-136.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:137.1-138.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:139.1-140.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:141.1-142.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:143.1-144.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:145.1-146.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:147.1-148.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:149.1-150.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:151.1-152.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:153.1-154.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:155.1-156.107 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:157.1-158.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:159.1-160.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:161.1-162.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:163.1-164.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:165.1-166.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:167.1-168.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:169.1-170.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:171.1-172.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:173.1-174.91 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:175.1-176.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:253.1-254.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:255.1-256.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:257.1-258.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:259.1-260.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:261.1-262.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:263.1-264.91 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:269.1-270.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:271.1-272.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:273.1-274.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:275.1-276.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:277.1-278.97 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:283.1-285.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:286.1-288.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:289.1-291.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:292.1-294.106 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:295.1-297.106 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:298.1-300.106 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:301.1-303.106 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:304.1-306.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:307.1-309.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:310.1-312.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:313.1-315.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:316.1-318.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:319.1-321.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:322.1-324.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:325.1-327.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:328.1-330.154 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:331.1-333.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:334.1-336.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:337.1-339.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:340.1-342.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:343.1-345.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:346.1-348.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:349.1-351.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:352.1-354.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:355.1-357.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:358.1-360.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:361.1-363.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:364.1-366.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:367.1-369.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:372.1-374.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:375.1-377.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:378.1-380.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:381.1-383.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:384.1-386.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:387.1-389.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:390.1-392.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:393.1-395.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:396.1-398.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:399.1-401.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:402.1-404.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:405.1-407.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:408.1-410.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:411.1-413.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:414.1-416.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:417.1-419.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:420.1-422.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:423.1-425.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:426.1-428.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:429.1-431.122 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:432.1-434.122 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:435.1-437.122 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:438.1-440.122 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:441.1-443.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:444.1-446.122 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:447.1-449.122 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:452.1-454.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:455.1-457.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:458.1-460.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:461.1-463.86 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:464.1-466.86 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:467.1-469.86 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:470.1-472.86 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:473.1-475.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:476.1-478.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:479.1-481.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:482.1-484.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:485.1-487.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:488.1-490.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:491.1-493.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:494.1-496.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:497.1-499.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:500.1-502.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:503.1-505.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:506.1-508.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:509.1-511.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:512.1-514.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:515.1-517.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:518.1-520.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:521.1-523.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:524.1-526.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:527.1-529.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:530.1-532.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:533.1-535.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:536.1-538.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:541.1-543.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:544.1-546.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:547.1-549.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:550.1-552.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:553.1-555.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:556.1-558.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:559.1-561.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:562.1-564.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:565.1-567.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:568.1-570.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:571.1-573.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:574.1-576.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:577.1-579.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:580.1-582.102 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:583.1-585.102 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:586.1-588.102 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:589.1-591.102 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:592.1-594.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:595.1-597.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:598.1-600.102 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:768.1-770.124 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:771.1-773.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:774.1-776.125 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:777.1-779.99 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:780.1-782.88 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:783.1-785.112 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:786.1-788.95 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:789.1-791.113 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:793.1-795.108 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:796.1-798.89 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:799.1-801.109 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:802.1-804.90 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:805.1-807.85 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:808.1-810.100 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:811.1-813.86 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:814.1-816.101 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:309.63-309.68"))
- 35/234 (14.96%)

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
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:311.1-313.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:314.1-316.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:317.1-319.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:320.1-322.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:323.1-325.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:326.1-328.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:329.1-331.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:332.1-334.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:335.1-337.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:338.1-340.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:341.1-343.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:344.1-346.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:347.1-349.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:350.1-352.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:353.1-355.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:356.1-358.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:359.1-361.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:362.1-364.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:365.1-367.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:368.1-370.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:371.1-373.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:376.1-378.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:379.1-381.70 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:382.1-384.68 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:385.1-387.70 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:388.1-390.70 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:393.1-395.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:396.1-398.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:399.1-401.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:402.1-404.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:405.1-407.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:408.1-410.68 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:411.1-413.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:416.1-418.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:419.1-421.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:422.1-424.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:425.1-427.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:428.1-430.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:431.1-433.67 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:434.1-436.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:437.1-439.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:440.1-442.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:449.1-451.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:452.1-454.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:455.1-457.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:458.1-460.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:461.1-463.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:464.1-466.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:467.1-469.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:472.1-474.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:475.1-477.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:478.1-480.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:481.1-483.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:484.1-486.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:489.1-491.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:492.1-494.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:495.1-497.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:498.1-500.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:501.1-503.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:504.1-506.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:507.1-509.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:512.1-514.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:515.1-517.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:520.1-522.74 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:523.1-525.70 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:526.1-528.69 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:529.1-531.70 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:532.1-534.70 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:537.1-539.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:540.1-542.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:543.1-545.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:546.1-548.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:549.1-551.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:552.1-554.70 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:555.1-557.74 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:560.1-562.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:563.1-565.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:566.1-568.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:569.1-571.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:572.1-574.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:575.1-577.67 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:578.1-580.74 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:581.1-583.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:584.1-586.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:593.1-595.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:596.1-598.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:599.1-601.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:602.1-604.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:605.1-607.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:608.1-610.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:611.1-613.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:616.1-618.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:619.1-621.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:622.1-624.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:625.1-627.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:628.1-630.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:633.1-635.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:636.1-638.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:639.1-641.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:642.1-644.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:645.1-647.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:648.1-650.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:651.1-653.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:656.1-658.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:659.1-661.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:664.1-666.66 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:667.1-669.70 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:670.1-672.68 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:673.1-675.70 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:676.1-678.72 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:681.1-683.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:684.1-686.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:687.1-689.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:690.1-692.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:693.1-695.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:696.1-698.70 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:699.1-701.66 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:704.1-706.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:707.1-709.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:710.1-712.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:713.1-715.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:716.1-718.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:719.1-721.72 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:722.1-724.66 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:725.1-727.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:728.1-730.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:737.1-739.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:740.1-742.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:743.1-745.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:746.1-748.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:749.1-751.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:752.1-754.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:755.1-757.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:760.1-762.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:763.1-765.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:766.1-768.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:769.1-771.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:772.1-774.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:777.1-779.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:780.1-782.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:783.1-785.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:786.1-788.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:789.1-791.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:792.1-794.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:795.1-797.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:800.1-802.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:803.1-805.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:808.1-810.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:811.1-813.70 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:814.1-816.69 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:817.1-819.70 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:820.1-822.72 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:825.1-827.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:828.1-830.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:831.1-833.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:834.1-836.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:837.1-839.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:840.1-842.72 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:843.1-845.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:848.1-850.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:851.1-853.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:854.1-856.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:857.1-859.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:860.1-862.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:863.1-865.72 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:866.1-868.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:869.1-871.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:872.1-874.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:881.1-883.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:884.1-886.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:887.1-889.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:890.1-892.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:893.1-895.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:896.1-898.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:899.1-901.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:904.1-906.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:907.1-909.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:910.1-912.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:913.1-915.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:916.1-918.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:921.1-923.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:924.1-926.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:927.1-929.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:930.1-932.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:933.1-935.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:936.1-938.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:939.1-941.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:944.1-946.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:947.1-949.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:952.1-954.74 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:955.1-957.70 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:958.1-960.72 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:961.1-963.70 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:964.1-966.68 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:969.1-971.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:972.1-974.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:975.1-977.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:978.1-980.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:981.1-983.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:984.1-986.70 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:987.1-989.74 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:992.1-994.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:995.1-997.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:998.1-1000.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1001.1-1003.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1004.1-1006.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1007.1-1009.67 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1010.1-1012.74 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1013.1-1015.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1016.1-1018.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1025.1-1027.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1028.1-1030.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1031.1-1033.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1034.1-1036.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1037.1-1039.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1040.1-1042.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1043.1-1045.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1048.1-1050.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1051.1-1053.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1054.1-1056.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1057.1-1059.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1060.1-1062.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1088.1-1090.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1091.1-1093.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1096.1-1098.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1099.1-1101.70 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1102.1-1104.71 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1105.1-1107.70 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1108.1-1110.68 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1113.1-1115.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1116.1-1118.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1119.1-1121.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1122.1-1124.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1125.1-1127.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1128.1-1130.68 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1131.1-1133.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1136.1-1138.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1139.1-1141.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1142.1-1144.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1145.1-1147.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1148.1-1150.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1151.1-1153.68 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1154.1-1156.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1157.1-1159.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1160.1-1162.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1169.1-1171.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1172.1-1174.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1175.1-1177.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1178.1-1180.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1181.1-1183.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1184.1-1186.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1187.1-1189.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1192.1-1194.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1195.1-1197.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1198.1-1200.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1201.1-1203.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1204.1-1206.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1209.1-1211.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1212.1-1214.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1215.1-1217.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1218.1-1220.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1221.1-1223.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1224.1-1226.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1227.1-1229.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1232.1-1234.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1235.1-1237.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1240.1-1242.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1243.1-1245.70 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1246.1-1248.72 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1249.1-1251.70 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1252.1-1254.72 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1257.1-1259.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1260.1-1262.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1263.1-1265.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1266.1-1268.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1269.1-1271.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1272.1-1274.72 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1275.1-1277.66 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1280.1-1282.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1283.1-1285.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1286.1-1288.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1289.1-1291.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1292.1-1294.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1295.1-1297.72 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1298.1-1300.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1301.1-1303.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1304.1-1306.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1313.1-1315.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1316.1-1318.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1319.1-1321.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1322.1-1324.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1325.1-1327.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1328.1-1330.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1331.1-1333.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1336.1-1338.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1339.1-1341.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1342.1-1344.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1345.1-1347.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1348.1-1350.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1353.1-1355.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1356.1-1358.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1359.1-1361.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1362.1-1364.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1365.1-1367.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1368.1-1370.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1371.1-1373.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1376.1-1378.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1379.1-1381.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1384.1-1386.66 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1387.1-1389.70 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1390.1-1392.71 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1393.1-1395.70 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1396.1-1398.72 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1401.1-1403.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1404.1-1406.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1407.1-1409.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1410.1-1412.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1413.1-1415.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1416.1-1418.70 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1419.1-1421.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1424.1-1426.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1427.1-1429.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1430.1-1432.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1433.1-1435.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1436.1-1438.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1439.1-1441.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1442.1-1444.66 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1445.1-1447.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1448.1-1450.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1727.1-1727.41 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1728.1-1728.41 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1729.1-1729.41 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1730.1-1730.41 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1733.1-1733.39 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1734.1-1734.39 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1735.1-1735.39 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1736.1-1736.39 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_cmp.wast:1737.1-1737.36 (Failure("Invalid virelop: LTS"))
- 97/435 (22.30%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:11.1-12.91 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:13.1-14.91 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:15.1-16.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:17.1-18.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:19.1-20.115 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:21.1-22.115 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:23.1-24.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:25.1-26.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:29.1-30.91 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:31.1-32.91 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:33.1-34.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:35.1-36.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:37.1-38.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:39.1-40.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:41.1-42.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extadd_pairwise_i8x16.wast:43.1-44.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- 1/17 (5.88%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:13.1-15.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:16.1-18.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:19.1-21.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:22.1-24.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:25.1-27.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:28.1-30.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:31.1-33.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:34.1-36.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:37.1-39.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:40.1-42.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:43.1-45.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:46.1-48.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:49.1-51.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:52.1-54.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:55.1-57.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:58.1-60.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:61.1-63.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:64.1-66.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:67.1-69.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:70.1-72.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:73.1-75.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:76.1-78.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:79.1-81.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:82.1-84.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:85.1-87.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:88.1-90.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:93.1-95.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:96.1-98.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:99.1-101.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:102.1-104.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:105.1-107.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:108.1-110.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:111.1-113.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:114.1-116.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:117.1-119.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:120.1-122.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:123.1-125.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:126.1-128.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:129.1-131.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:132.1-134.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:135.1-137.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:138.1-140.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:141.1-143.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:144.1-146.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:147.1-149.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:150.1-152.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:153.1-155.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:156.1-158.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:159.1-161.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:162.1-164.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:165.1-167.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:168.1-170.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:173.1-175.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:176.1-178.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:179.1-181.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:182.1-184.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:185.1-187.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:188.1-190.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:191.1-193.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:194.1-196.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:197.1-199.126 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:200.1-202.126 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:203.1-205.126 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:206.1-208.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:209.1-211.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:212.1-214.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:215.1-217.126 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:218.1-220.126 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:221.1-223.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:224.1-226.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:227.1-229.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:230.1-232.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:233.1-235.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:236.1-238.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:239.1-241.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:242.1-244.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:245.1-247.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:248.1-250.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:253.1-255.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:256.1-258.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:259.1-261.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:262.1-264.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:265.1-267.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:268.1-270.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:271.1-273.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:274.1-276.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:277.1-279.127 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:280.1-282.127 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:283.1-285.127 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:286.1-288.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:289.1-291.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:292.1-294.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:295.1-297.127 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:298.1-300.127 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:301.1-303.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:304.1-306.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:307.1-309.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:310.1-312.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:313.1-315.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:316.1-318.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:319.1-321.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:322.1-324.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:325.1-327.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i16x8_extmul_i8x16.wast:328.1-330.111 (Failure("Algorithm not found: VEXTMUL"))
- 1/105 (0.95%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_q15mulr_sat_s.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i16x8_sat_arith.wast =====
- 206/206 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_arith.wast =====
- 183/183 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_arith2.wast =====
- 123/123 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:311.1-313.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:314.1-316.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:317.1-319.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:320.1-322.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:323.1-325.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:326.1-328.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:329.1-331.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:334.1-336.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:337.1-339.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:340.1-342.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:343.1-345.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:346.1-348.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:351.1-353.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:354.1-356.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:357.1-359.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:360.1-362.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:363.1-365.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:366.1-368.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:369.1-371.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:374.1-376.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:377.1-379.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:382.1-384.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:385.1-387.60 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:388.1-390.59 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:391.1-393.60 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:394.1-396.59 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:399.1-401.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:402.1-404.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:405.1-407.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:408.1-410.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:411.1-413.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:414.1-416.59 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:417.1-419.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:422.1-424.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:425.1-427.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:428.1-430.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:431.1-433.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:434.1-436.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:437.1-439.60 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:440.1-442.62 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:443.1-445.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:446.1-448.62 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:455.1-457.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:458.1-460.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:461.1-463.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:464.1-466.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:467.1-469.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:470.1-472.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:473.1-475.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:478.1-480.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:481.1-483.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:484.1-486.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:487.1-489.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:490.1-492.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:495.1-497.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:498.1-500.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:501.1-503.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:504.1-506.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:507.1-509.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:510.1-512.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:513.1-515.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:518.1-520.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:521.1-523.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:526.1-528.62 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:529.1-531.60 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:532.1-534.59 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:535.1-537.60 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:538.1-540.60 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:543.1-545.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:546.1-548.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:549.1-551.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:552.1-554.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:555.1-557.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:558.1-560.59 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:561.1-563.62 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:566.1-568.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:569.1-571.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:572.1-574.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:575.1-577.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:578.1-580.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:581.1-583.60 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:584.1-586.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:587.1-589.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:590.1-592.62 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:599.1-601.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:602.1-604.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:605.1-607.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:608.1-610.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:611.1-613.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:614.1-616.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:617.1-619.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:622.1-624.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:625.1-627.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:628.1-630.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:631.1-633.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:634.1-636.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:639.1-641.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:642.1-644.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:645.1-647.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:648.1-650.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:651.1-653.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:654.1-656.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:657.1-659.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:662.1-664.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:665.1-667.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:670.1-672.58 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:673.1-675.60 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:676.1-678.59 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:679.1-681.60 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:682.1-684.60 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:687.1-689.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:690.1-692.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:693.1-695.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:696.1-698.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:699.1-701.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:702.1-704.61 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:705.1-707.58 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:710.1-712.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:713.1-715.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:716.1-718.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:719.1-721.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:722.1-724.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:725.1-727.61 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:728.1-730.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:731.1-733.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:734.1-736.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:743.1-745.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:746.1-748.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:749.1-751.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:752.1-754.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:755.1-757.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:758.1-760.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:761.1-763.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:766.1-768.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:769.1-771.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:772.1-774.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:775.1-777.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:778.1-780.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:783.1-785.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:786.1-788.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:789.1-791.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:792.1-794.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:795.1-797.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:798.1-800.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:801.1-803.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:806.1-808.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:809.1-811.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:814.1-816.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:817.1-819.60 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:820.1-822.59 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:823.1-825.60 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:826.1-828.61 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:831.1-833.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:834.1-836.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:837.1-839.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:840.1-842.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:843.1-845.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:846.1-848.61 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:849.1-851.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:854.1-856.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:857.1-859.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:860.1-862.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:863.1-865.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:866.1-868.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:869.1-871.61 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:872.1-874.58 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:875.1-877.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:878.1-880.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:887.1-889.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:890.1-892.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:893.1-895.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:896.1-898.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:899.1-901.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:902.1-904.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:905.1-907.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:910.1-912.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:913.1-915.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:916.1-918.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:919.1-921.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:922.1-924.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:927.1-929.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:930.1-932.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:933.1-935.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:936.1-938.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:939.1-941.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:942.1-944.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:945.1-947.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:950.1-952.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:953.1-955.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:958.1-960.62 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:961.1-963.60 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:964.1-966.61 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:967.1-969.60 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:970.1-972.60 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:975.1-977.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:978.1-980.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:981.1-983.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:984.1-986.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:987.1-989.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:990.1-992.59 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:993.1-995.62 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:998.1-1000.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1001.1-1003.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1004.1-1006.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1007.1-1009.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1010.1-1012.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1013.1-1015.60 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1016.1-1018.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1019.1-1021.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1022.1-1024.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1031.1-1033.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1034.1-1036.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1037.1-1039.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1040.1-1042.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1043.1-1045.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1046.1-1048.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1049.1-1051.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1054.1-1056.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1057.1-1059.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1060.1-1062.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1063.1-1065.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1066.1-1068.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1071.1-1073.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1074.1-1076.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1077.1-1079.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1080.1-1082.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1083.1-1085.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1086.1-1088.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1089.1-1091.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1094.1-1096.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1097.1-1099.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1102.1-1104.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1105.1-1107.60 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1108.1-1110.61 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1111.1-1113.60 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1114.1-1116.59 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1119.1-1121.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1122.1-1124.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1125.1-1127.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1128.1-1130.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1131.1-1133.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1134.1-1136.59 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1137.1-1139.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1142.1-1144.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1145.1-1147.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1148.1-1150.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1151.1-1153.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1154.1-1156.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1157.1-1159.59 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1160.1-1162.62 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1163.1-1165.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1166.1-1168.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1175.1-1177.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1178.1-1180.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1181.1-1183.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1184.1-1186.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1187.1-1189.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1190.1-1192.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1193.1-1195.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1198.1-1200.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1201.1-1203.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1204.1-1206.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1207.1-1209.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1210.1-1212.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1215.1-1217.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1218.1-1220.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1221.1-1223.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1224.1-1226.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1227.1-1229.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1230.1-1232.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1233.1-1235.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1238.1-1240.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1241.1-1243.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1246.1-1248.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1249.1-1251.60 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1252.1-1254.61 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1255.1-1257.60 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1258.1-1260.61 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1263.1-1265.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1266.1-1268.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1269.1-1271.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1272.1-1274.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1275.1-1277.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1278.1-1280.61 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1281.1-1283.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1286.1-1288.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1289.1-1291.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1292.1-1294.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1295.1-1297.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1298.1-1300.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1301.1-1303.61 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1304.1-1306.58 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1307.1-1309.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1310.1-1312.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1319.1-1321.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1322.1-1324.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1325.1-1327.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1328.1-1330.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1331.1-1333.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1334.1-1336.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1337.1-1339.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1342.1-1344.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1345.1-1347.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1348.1-1350.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1351.1-1353.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1354.1-1356.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1359.1-1361.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1362.1-1364.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1365.1-1367.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1368.1-1370.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1371.1-1373.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1374.1-1376.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1377.1-1379.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1382.1-1384.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1385.1-1387.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1390.1-1392.58 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1393.1-1395.60 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1396.1-1398.61 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1399.1-1401.60 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1402.1-1404.60 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1407.1-1409.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1410.1-1412.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1413.1-1415.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1416.1-1418.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1419.1-1421.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1422.1-1424.61 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1425.1-1427.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1430.1-1432.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1433.1-1435.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1436.1-1438.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1439.1-1441.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1442.1-1444.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1445.1-1447.59 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1448.1-1450.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1451.1-1453.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1454.1-1456.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1733.1-1733.41 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1734.1-1734.41 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1735.1-1735.41 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1736.1-1736.41 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1739.1-1739.39 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1740.1-1740.39 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1741.1-1741.39 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1742.1-1742.39 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_cmp.wast:1743.1-1743.36 (Failure("Invalid virelop: LTS"))
- 90/435 (20.69%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:10.1-12.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:13.1-15.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:16.1-18.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:19.1-21.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:22.1-24.75 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:25.1-27.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:28.1-30.103 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:31.1-33.103 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:34.1-36.103 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:37.1-39.103 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:40.1-42.103 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:43.1-45.87 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:46.1-48.87 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:49.1-51.91 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:52.1-54.87 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:55.1-57.87 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:58.1-60.87 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:61.1-63.107 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:64.1-66.107 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:67.1-69.107 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:70.1-72.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:73.1-75.75 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:76.1-78.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:79.1-81.91 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:82.1-84.87 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_dot_i16x8.wast:85.1-87.71 (Failure("Algorithm not found: VDOT"))
- 1/27 (3.70%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:11.1-12.83 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:13.1-14.83 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:15.1-16.87 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:17.1-18.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:19.1-20.103 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:21.1-22.103 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:23.1-24.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:25.1-26.87 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:29.1-30.83 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:31.1-32.83 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:33.1-34.103 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:35.1-36.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:37.1-38.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:39.1-40.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:41.1-42.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extadd_pairwise_i16x8.wast:43.1-44.103 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- 1/17 (5.88%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:13.1-15.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:16.1-18.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:19.1-21.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:22.1-24.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:25.1-27.82 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:28.1-30.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:31.1-33.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:34.1-36.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:37.1-39.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:40.1-42.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:43.1-45.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:46.1-48.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:49.1-51.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:52.1-54.98 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:55.1-57.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:58.1-60.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:61.1-63.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:64.1-66.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:67.1-69.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:70.1-72.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:73.1-75.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:76.1-78.82 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:79.1-81.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:82.1-84.98 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:85.1-87.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:88.1-90.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:93.1-95.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:96.1-98.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:99.1-101.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:102.1-104.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:105.1-107.83 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:108.1-110.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:111.1-113.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:114.1-116.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:117.1-119.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:120.1-122.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:123.1-125.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:126.1-128.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:129.1-131.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:132.1-134.99 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:135.1-137.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:138.1-140.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:141.1-143.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:144.1-146.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:147.1-149.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:150.1-152.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:153.1-155.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:156.1-158.83 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:159.1-161.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:162.1-164.99 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:165.1-167.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:168.1-170.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:173.1-175.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:176.1-178.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:179.1-181.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:182.1-184.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:185.1-187.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:188.1-190.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:191.1-193.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:194.1-196.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:197.1-199.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:200.1-202.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:203.1-205.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:206.1-208.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:209.1-211.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:212.1-214.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:215.1-217.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:218.1-220.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:221.1-223.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:224.1-226.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:227.1-229.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:230.1-232.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:233.1-235.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:236.1-238.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:239.1-241.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:242.1-244.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:245.1-247.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:248.1-250.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:253.1-255.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:256.1-258.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:259.1-261.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:262.1-264.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:265.1-267.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:268.1-270.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:271.1-273.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:274.1-276.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:277.1-279.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:280.1-282.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:283.1-285.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:286.1-288.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:289.1-291.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:292.1-294.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:295.1-297.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:298.1-300.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:301.1-303.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:304.1-306.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:307.1-309.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:310.1-312.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:313.1-315.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:316.1-318.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:319.1-321.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:322.1-324.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:325.1-327.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_extmul_i16x8.wast:328.1-330.103 (Failure("Algorithm not found: VEXTMUL"))
- 1/105 (0.95%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast =====
- 103/103 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:10.1-11.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:12.1-13.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:14.1-15.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:16.1-17.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:18.1-19.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:20.1-21.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:22.1-23.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:24.1-25.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:26.1-27.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:28.1-29.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:30.1-31.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:32.1-33.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:34.1-35.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:36.1-37.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:38.1-39.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:40.1-41.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:42.1-43.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:44.1-45.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:46.1-47.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:48.1-49.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:50.1-51.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:52.1-53.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:54.1-55.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:56.1-57.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:58.1-59.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:60.1-61.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:62.1-63.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:64.1-65.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:66.1-67.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:68.1-69.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:70.1-71.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:72.1-73.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:74.1-75.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:76.1-77.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:78.1-79.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:80.1-81.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:82.1-83.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:84.1-85.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:86.1-87.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:88.1-89.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:90.1-91.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:92.1-93.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:94.1-95.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:96.1-97.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:98.1-99.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:100.1-101.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:102.1-103.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:104.1-105.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:106.1-107.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:108.1-109.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:110.1-111.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:114.1-115.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:116.1-117.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:118.1-119.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:120.1-121.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:122.1-123.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:124.1-125.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:126.1-127.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:128.1-129.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:130.1-131.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:132.1-133.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:134.1-135.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:136.1-137.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:138.1-139.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:140.1-141.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:142.1-143.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:144.1-145.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:146.1-147.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:148.1-149.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:150.1-151.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:152.1-153.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:154.1-155.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:156.1-157.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:158.1-159.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:160.1-161.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:162.1-163.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:164.1-165.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:166.1-167.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:168.1-169.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:170.1-171.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:172.1-173.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:174.1-175.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:176.1-177.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:178.1-179.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:180.1-181.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:182.1-183.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:184.1-185.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:186.1-187.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:188.1-189.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:190.1-191.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:192.1-193.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:194.1-195.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:196.1-197.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:198.1-199.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:200.1-201.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:202.1-203.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:204.1-205.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:206.1-207.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:208.1-209.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:210.1-211.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:212.1-213.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:214.1-215.100 (Failure("Wasm value stack underflow"))
- 1/103 (0.97%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_arith.wast =====
- 189/189 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_arith2.wast =====
- 23/23 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:77.1-79.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:80.1-82.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:83.1-85.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:86.1-88.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:89.1-91.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:92.1-94.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:95.1-97.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:100.1-102.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:103.1-105.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:106.1-108.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:109.1-111.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:112.1-114.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:117.1-119.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:120.1-122.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:123.1-125.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:126.1-128.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:129.1-131.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:132.1-134.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:135.1-137.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:140.1-142.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:143.1-145.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:152.1-154.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:155.1-157.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:158.1-160.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:161.1-163.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:164.1-166.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:167.1-169.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:170.1-172.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:175.1-177.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:178.1-180.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:181.1-183.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:184.1-186.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:187.1-189.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:192.1-194.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:195.1-197.55 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:198.1-200.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:201.1-203.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:204.1-206.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:207.1-209.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:210.1-212.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:213.1-215.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:218.1-220.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:221.1-223.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:230.1-232.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:233.1-235.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:236.1-238.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:239.1-241.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:242.1-244.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:245.1-247.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:248.1-250.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:253.1-255.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:256.1-258.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:259.1-261.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:262.1-264.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:265.1-267.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:270.1-272.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:273.1-275.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:276.1-278.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:279.1-281.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:282.1-284.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:285.1-287.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:288.1-290.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:293.1-295.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:296.1-298.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:305.1-307.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:308.1-310.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:311.1-313.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:314.1-316.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:317.1-319.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:320.1-322.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:323.1-325.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:328.1-330.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:331.1-333.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:334.1-336.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:337.1-339.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:340.1-342.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:345.1-347.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:348.1-350.55 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:351.1-353.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:354.1-356.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:357.1-359.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:360.1-362.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:363.1-365.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:366.1-368.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:371.1-373.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_cmp.wast:374.1-376.56 (Failure("Invalid virelop: GES"))
- 17/103 (16.50%)

===== ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:13.1-15.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:16.1-18.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:19.1-21.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:22.1-24.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:25.1-27.76 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:28.1-30.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:31.1-33.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:34.1-36.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:37.1-39.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:40.1-42.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:43.1-45.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:46.1-48.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:49.1-51.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:52.1-54.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:55.1-57.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:58.1-60.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:61.1-63.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:64.1-66.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:67.1-69.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:70.1-72.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:73.1-75.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:76.1-78.76 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:79.1-81.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:82.1-84.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:85.1-87.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:88.1-90.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:93.1-95.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:96.1-98.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:99.1-101.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:102.1-104.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:105.1-107.77 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:108.1-110.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:111.1-113.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:114.1-116.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:117.1-119.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:120.1-122.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:123.1-125.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:126.1-128.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:129.1-131.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:132.1-134.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:135.1-137.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:138.1-140.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:141.1-143.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:144.1-146.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:147.1-149.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:150.1-152.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:153.1-155.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:156.1-158.77 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:159.1-161.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:162.1-164.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:165.1-167.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:168.1-170.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:173.1-175.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:176.1-178.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:179.1-181.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:182.1-184.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:185.1-187.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:188.1-190.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:191.1-193.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:194.1-196.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:197.1-199.112 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:200.1-202.112 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:203.1-205.112 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:206.1-208.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:209.1-211.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:212.1-214.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:215.1-217.112 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:218.1-220.112 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:221.1-223.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:224.1-226.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:227.1-229.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:230.1-232.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:233.1-235.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:236.1-238.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:239.1-241.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:242.1-244.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:245.1-247.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:248.1-250.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:253.1-255.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:256.1-258.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:259.1-261.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:262.1-264.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:265.1-267.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:268.1-270.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:271.1-273.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:274.1-276.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:277.1-279.113 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:280.1-282.113 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:283.1-285.113 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:286.1-288.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:289.1-291.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:292.1-294.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:295.1-297.113 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:298.1-300.113 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:301.1-303.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:304.1-306.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:307.1-309.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:310.1-312.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:313.1-315.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:316.1-318.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:319.1-321.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:322.1-324.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:325.1-327.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i64x2_extmul_i32x4.wast:328.1-330.95 (Failure("Algorithm not found: VEXTMUL"))
- 1/105 (0.95%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_arith.wast =====
- 123/123 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_arith2.wast =====
- 186/186 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:299.1-301.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:302.1-304.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:305.1-307.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:308.1-310.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:311.1-313.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:314.1-316.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:317.1-319.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:322.1-324.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:325.1-327.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:328.1-330.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:331.1-333.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:334.1-336.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:339.1-341.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:342.1-344.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:345.1-347.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:348.1-350.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:351.1-353.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:354.1-356.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:357.1-359.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:362.1-364.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:365.1-367.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:370.1-372.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:373.1-375.90 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:376.1-378.90 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:379.1-381.89 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:382.1-384.89 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:387.1-389.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:390.1-392.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:393.1-395.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:396.1-398.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:399.1-401.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:402.1-404.86 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:405.1-407.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:410.1-412.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:413.1-415.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:416.1-418.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:419.1-421.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:422.1-424.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:425.1-427.88 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:428.1-430.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:437.1-439.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:440.1-442.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:443.1-445.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:446.1-448.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:449.1-451.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:452.1-454.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:455.1-457.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:460.1-462.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:463.1-465.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:466.1-468.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:469.1-471.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:472.1-474.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:477.1-479.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:480.1-482.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:483.1-485.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:486.1-488.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:489.1-491.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:492.1-494.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:495.1-497.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:500.1-502.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:503.1-505.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:508.1-510.98 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:511.1-513.90 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:514.1-516.90 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:517.1-519.89 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:520.1-522.89 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:525.1-527.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:528.1-530.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:531.1-533.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:534.1-536.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:537.1-539.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:540.1-542.84 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:543.1-545.98 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:548.1-550.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:551.1-553.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:554.1-556.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:557.1-559.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:560.1-562.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:563.1-565.85 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:566.1-568.98 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:575.1-577.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:578.1-580.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:581.1-583.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:584.1-586.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:587.1-589.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:590.1-592.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:593.1-595.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:598.1-600.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:601.1-603.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:604.1-606.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:607.1-609.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:610.1-612.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:615.1-617.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:618.1-620.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:621.1-623.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:624.1-626.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:627.1-629.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:630.1-632.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:633.1-635.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:638.1-640.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:641.1-643.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:646.1-648.82 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:649.1-651.90 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:652.1-654.90 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:655.1-657.91 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:658.1-660.91 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:663.1-665.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:666.1-668.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:669.1-671.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:672.1-674.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:675.1-677.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:678.1-680.96 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:681.1-683.82 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:686.1-688.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:689.1-691.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:692.1-694.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:695.1-697.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:698.1-700.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:701.1-703.95 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:704.1-706.82 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:713.1-715.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:716.1-718.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:719.1-721.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:722.1-724.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:725.1-727.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:728.1-730.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:731.1-733.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:736.1-738.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:739.1-741.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:742.1-744.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:745.1-747.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:748.1-750.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:753.1-755.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:756.1-758.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:759.1-761.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:762.1-764.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:765.1-767.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:768.1-770.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:771.1-773.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:776.1-778.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:779.1-781.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:784.1-786.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:787.1-789.90 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:790.1-792.90 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:793.1-795.91 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:796.1-798.91 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:801.1-803.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:804.1-806.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:807.1-809.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:810.1-812.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:813.1-815.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:816.1-818.94 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:819.1-821.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:824.1-826.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:827.1-829.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:830.1-832.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:833.1-835.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:836.1-838.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:839.1-841.92 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:842.1-844.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:851.1-853.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:854.1-856.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:857.1-859.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:860.1-862.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:863.1-865.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:866.1-868.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:869.1-871.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:874.1-876.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:877.1-879.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:880.1-882.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:883.1-885.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:886.1-888.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:891.1-893.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:894.1-896.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:897.1-899.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:900.1-902.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:903.1-905.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:906.1-908.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:909.1-911.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:914.1-916.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:917.1-919.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:922.1-924.98 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:925.1-927.90 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:928.1-930.90 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:931.1-933.89 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:934.1-936.89 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:939.1-941.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:942.1-944.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:945.1-947.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:948.1-950.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:951.1-953.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:954.1-956.84 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:957.1-959.98 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:962.1-964.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:965.1-967.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:968.1-970.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:971.1-973.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:974.1-976.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:977.1-979.85 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:980.1-982.98 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:989.1-991.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:992.1-994.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:995.1-997.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:998.1-1000.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1001.1-1003.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1004.1-1006.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1007.1-1009.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1012.1-1014.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1015.1-1017.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1018.1-1020.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1021.1-1023.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1024.1-1026.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1029.1-1031.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1032.1-1034.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1035.1-1037.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1038.1-1040.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1041.1-1043.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1044.1-1046.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1047.1-1049.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1052.1-1054.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1055.1-1057.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1060.1-1062.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1063.1-1065.90 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1066.1-1068.90 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1069.1-1071.89 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1072.1-1074.89 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1077.1-1079.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1080.1-1082.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1083.1-1085.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1086.1-1088.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1089.1-1091.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1092.1-1094.86 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1095.1-1097.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1100.1-1102.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1103.1-1105.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1106.1-1108.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1109.1-1111.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1112.1-1114.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1115.1-1117.88 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1118.1-1120.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1127.1-1129.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1130.1-1132.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1133.1-1135.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1136.1-1138.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1139.1-1141.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1142.1-1144.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1145.1-1147.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1150.1-1152.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1153.1-1155.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1156.1-1158.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1159.1-1161.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1162.1-1164.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1167.1-1169.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1170.1-1172.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1173.1-1175.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1176.1-1178.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1179.1-1181.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1182.1-1184.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1185.1-1187.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1190.1-1192.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1193.1-1195.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1198.1-1200.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1201.1-1203.90 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1204.1-1206.90 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1207.1-1209.91 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1210.1-1212.91 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1215.1-1217.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1218.1-1220.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1221.1-1223.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1224.1-1226.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1227.1-1229.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1230.1-1232.94 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1233.1-1235.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1238.1-1240.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1241.1-1243.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1244.1-1246.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1247.1-1249.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1250.1-1252.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1253.1-1255.92 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1256.1-1258.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1265.1-1267.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1268.1-1270.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1271.1-1273.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1274.1-1276.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1277.1-1279.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1280.1-1282.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1283.1-1285.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1288.1-1290.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1291.1-1293.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1294.1-1296.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1297.1-1299.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1300.1-1302.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1305.1-1307.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1308.1-1310.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1311.1-1313.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1314.1-1316.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1317.1-1319.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1320.1-1322.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1323.1-1325.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1328.1-1330.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1331.1-1333.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1336.1-1338.82 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1339.1-1341.90 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1342.1-1344.90 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1345.1-1347.91 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1348.1-1350.91 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1353.1-1355.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1356.1-1358.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1359.1-1361.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1362.1-1364.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1365.1-1367.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1368.1-1370.96 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1371.1-1373.82 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1376.1-1378.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1379.1-1381.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1382.1-1384.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1385.1-1387.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1388.1-1390.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1391.1-1393.95 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1394.1-1396.82 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1673.1-1673.41 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1674.1-1674.41 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1675.1-1675.41 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1676.1-1676.41 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1679.1-1679.39 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1680.1-1680.39 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1681.1-1681.39 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1682.1-1682.39 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i8x16_cmp.wast:1683.1-1683.36 (Failure("Invalid virelop: LTS"))
- 86/415 (20.72%)

===== ../../test-interpreter/spec-test-2/simd/simd_i8x16_sat_arith.wast =====
- 190/190 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:18.1-19.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:20.1-21.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:22.1-23.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:24.1-25.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:26.1-27.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:28.1-29.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:30.1-31.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:32.1-33.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:34.1-35.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:36.1-37.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:38.1-39.111 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:40.1-41.111 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:42.1-43.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:44.1-45.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:46.1-47.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:48.1-49.111 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:50.1-51.111 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:52.1-53.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:54.1-55.111 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:57.1-58.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:59.1-60.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:61.1-62.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:63.1-64.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:65.1-66.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:67.1-68.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:69.1-70.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:71.1-72.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:73.1-74.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:75.1-76.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:77.1-78.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:79.1-80.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:81.1-82.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:83.1-84.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:85.1-86.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:87.1-88.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:89.1-90.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:91.1-92.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:93.1-94.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:96.1-97.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:98.1-99.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:100.1-101.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:102.1-103.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:104.1-105.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:106.1-107.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:108.1-109.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:110.1-111.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:112.1-113.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:114.1-115.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:116.1-117.110 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:118.1-119.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:120.1-121.110 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:122.1-123.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:124.1-125.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:126.1-127.110 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:128.1-129.110 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:130.1-131.110 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:132.1-133.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:135.1-136.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:137.1-138.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:139.1-140.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:141.1-142.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:143.1-144.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:145.1-146.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:147.1-148.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:149.1-150.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:151.1-152.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:153.1-154.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:155.1-156.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:157.1-158.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:159.1-160.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:161.1-162.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:163.1-164.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:165.1-166.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:167.1-168.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:169.1-170.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:171.1-172.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:174.1-175.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:176.1-177.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:178.1-179.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:180.1-181.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:182.1-183.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:184.1-185.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:186.1-187.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:188.1-189.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:190.1-191.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:192.1-193.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:194.1-195.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:196.1-197.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:198.1-199.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:200.1-201.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:202.1-203.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:204.1-205.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:206.1-207.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:208.1-209.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:210.1-211.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:213.1-214.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:215.1-216.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:217.1-218.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:219.1-220.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:221.1-222.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:223.1-224.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:225.1-226.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:227.1-228.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:229.1-230.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:231.1-232.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:233.1-234.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:235.1-236.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:237.1-238.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:239.1-240.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:241.1-242.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:243.1-244.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:245.1-246.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:247.1-248.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:249.1-250.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:252.1-253.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:254.1-255.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:256.1-257.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:258.1-259.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:260.1-261.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:262.1-263.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:264.1-265.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:266.1-267.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:268.1-269.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:270.1-271.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:272.1-273.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:274.1-275.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:276.1-277.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:278.1-279.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:280.1-281.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:282.1-283.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:284.1-285.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:286.1-287.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:288.1-289.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:291.1-292.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:293.1-294.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:295.1-296.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:297.1-298.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:299.1-300.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:301.1-302.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:303.1-304.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:305.1-306.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:307.1-308.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:309.1-310.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:311.1-312.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:313.1-314.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:315.1-316.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:317.1-318.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:319.1-320.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:321.1-322.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:323.1-324.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:325.1-326.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:327.1-328.94 (Failure("Wasm value stack underflow"))
- 77/229 (33.62%)

===== ../../test-interpreter/spec-test-2/simd/simd_lane.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:292.1-295.70 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:296.1-299.77 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:300.1-303.86 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:304.1-307.86 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:308.1-311.86 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:312.1-315.102 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:316.1-319.78 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:320.1-323.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:324.1-327.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:328.1-331.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:333.1-336.60 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:337.1-340.77 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:341.1-344.84 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:345.1-348.77 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:349.1-352.77 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:353.1-356.86 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:357.1-360.86 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:361.1-364.102 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:365.1-368.78 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:369.1-372.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:373.1-376.60 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:377.1-380.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:381.1-384.60 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:387.1-390.70 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:391.1-394.70 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:692.1-695.60 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:696.1-699.102 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:769.1-774.70 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:775.1-780.68 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:787.1-789.75 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:790.1-792.75 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:793.1-795.75 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:863.1-866.77 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_lane.wast:867.1-870.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:236.50-236.53"))
- 252/286 (88.11%)

===== ../../test-interpreter/spec-test-2/simd/simd_linking.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load.wast:44.1-44.67 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load.wast:127.1-127.134 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- 29/31 (93.55%)

===== ../../test-interpreter/spec-test-2/simd/simd_load16_lane.wast =====
- 33/33 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load32_lane.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load64_lane.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load8_lane.wast =====
- 49/49 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:163.1-163.131 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:164.1-164.131 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:165.1-165.120 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:166.1-166.120 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:167.1-167.114 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:168.1-168.114 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:169.1-169.132 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:170.1-170.132 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:171.1-171.121 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:172.1-172.121 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:173.1-173.115 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:174.1-174.115 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:175.1-175.132 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:176.1-176.132 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:177.1-177.121 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:178.1-178.121 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:179.1-179.115 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:180.1-180.115 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:183.1-183.124 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:184.1-184.124 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:185.1-185.114 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:186.1-186.114 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:187.1-187.111 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:188.1-188.111 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:192.1-192.139 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:193.1-193.138 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:194.1-194.146 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:195.1-195.147 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:196.1-196.147 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:197.1-197.139 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:198.1-198.138 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:199.1-199.146 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:200.1-200.147 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:201.1-201.147 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:203.1-203.128 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:204.1-204.127 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:205.1-205.135 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:206.1-206.136 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:207.1-207.136 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:208.1-208.128 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:209.1-209.127 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:210.1-210.135 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:211.1-211.136 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:212.1-212.136 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:214.1-214.122 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:215.1-215.121 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:216.1-216.129 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:217.1-217.130 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:218.1-218.130 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:219.1-219.122 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:220.1-220.121 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:221.1-221.129 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:222.1-222.130 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:223.1-223.130 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:367.1-367.126 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:368.1-368.126 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:369.1-369.115 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:370.1-370.115 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:371.1-371.109 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:372.1-372.109 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:373.1-373.129 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:374.1-374.129 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:375.1-375.118 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:376.1-376.118 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:377.1-377.112 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:378.1-378.112 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:379.1-379.80 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:380.1-380.80 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:381.1-381.81 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:382.1-382.81 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:383.1-383.83 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_extend.wast:384.1-384.83 (Failure("Invalid DSL function call: inverse_of_size"))
- 14/86 (16.28%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast =====
Result: 3_324 0 2_016_817_526 1_718_562_360 : [v128]
Expect: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:43.1-43.109 (Error(_, "wrong return values"))
Result: 5 16_777_216 1_733_908_480 32_568 : [v128]
Expect: 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:44.1-44.109 (Error(_, "wrong return values"))
Result: 33_093 0 33_099 0 : [v128]
Expect: 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:45.1-45.109 (Error(_, "wrong return values"))
Result: 0 0 1_730_405_064 32_568 : [v128]
Expect: 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:46.1-46.109 (Error(_, "wrong return values"))
Result: 2_303 0 1_653_540_672 21_999 : [v128]
Expect: 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:47.1-47.129 (Error(_, "wrong return values"))
Result: 191 0 1_733_661_640 32_568 : [v128]
Expect: 1_284 1_284 1_284 1_284 1_284 1_284 1_284 1_284 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:48.1-48.134 (Error(_, "wrong return values"))
Result: 1_733_616_840 32_568 0 0 : [v128]
Expect: 1_541 1_541 1_541 1_541 1_541 1_541 1_541 1_541 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:49.1-49.134 (Error(_, "wrong return values"))
Result: 1_733_578_120 32_568 3 0 : [v128]
Expect: 1_798 1_798 1_798 1_798 1_798 1_798 1_798 1_798 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:50.1-50.134 (Error(_, "wrong return values"))
Result: 1_722_508_600 32_568 0 0 : [v128]
Expect: 2_055 2_055 2_055 2_055 2_055 2_055 2_055 2_055 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:51.1-51.134 (Error(_, "wrong return values"))
Result: 195 0 1_733_482_776 32_568 : [v128]
Expect: 7_966 7_966 7_966 7_966 7_966 7_966 7_966 7_966 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:52.1-52.138 (Error(_, "wrong return values"))
Result: 1_733_438_584 32_568 3_072 0 : [v128]
Expect: 185_207_048 185_207_048 185_207_048 185_207_048 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:53.1-53.122 (Error(_, "wrong return values"))
Result: 1_733_397_648 32_568 4_096 0 : [v128]
Expect: 202_050_057 202_050_057 202_050_057 202_050_057 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:54.1-54.122 (Error(_, "wrong return values"))
Result: 6_681 0 5_120 0 : [v128]
Expect: 218_893_066 218_893_066 218_893_066 218_893_066 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:55.1-55.123 (Error(_, "wrong return values"))
Result: 4_343 0 1_650_532_560 21_999 : [v128]
Expect: 235_736_075 235_736_075 235_736_075 235_736_075 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:56.1-56.123 (Error(_, "wrong return values"))
Result: 2_048 0 1_733_276_864 32_568 : [v128]
Expect: 522_067_228 522_067_228 522_067_228 522_067_228 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:57.1-57.126 (Error(_, "wrong return values"))
Result: 0 0 1_725_278_152 32_568 : [v128]
Expect: 252_579_084 252_579_084 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:58.1-58.117 (Error(_, "wrong return values"))
Result: 1_733_197_736 32_568 1_733_197_856 32_568 : [v128]
Expect: 986_637 986_637 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:59.1-59.117 (Error(_, "wrong return values"))
Result: 12_595 83_886_080 4_096 0 : [v128]
Expect: 3_854 3_854 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:60.1-60.117 (Error(_, "wrong return values"))
Result: 1_733_120_000 32_568 2_048 0 : [v128]
Expect: 15 15 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:61.1-61.117 (Error(_, "wrong return values"))
Result: 4_095 0 2_303 0 : [v128]
Expect: 2_242_261_671_028_070_680 2_242_261_671_028_070_680 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:62.1-62.120 (Error(_, "wrong return values"))
Result: 1_649_242_048 21_999 7 33_554_432 : [v128]
Expect: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:65.1-65.106 (Error(_, "wrong return values"))
Result: 3_072 0 1_732_980_936 32_568 : [v128]
Expect: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:66.1-66.105 (Error(_, "wrong return values"))
Result: 1_653_540_672 21_999 63 0 : [v128]
Expect: 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:67.1-67.113 (Error(_, "wrong return values"))
Result: 2_303 0 1_653_540_736 21_999 : [v128]
Expect: 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:68.1-68.113 (Error(_, "wrong return values"))
Result: 116 100_663_296 4_096 0 : [v128]
Expect: 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:69.1-69.130 (Error(_, "wrong return values"))
Result: 2_048 0 1_732_733_880 32_568 : [v128]
Expect: 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:70.1-70.106 (Error(_, "wrong return values"))
Result: 205 0 2_048 0 : [v128]
Expect: 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:71.1-71.105 (Error(_, "wrong return values"))
Result: 1_732_610_288 32_568 0 0 : [v128]
Expect: 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:72.1-72.113 (Error(_, "wrong return values"))
Result: 47 0 3_324 0 : [v128]
Expect: 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:73.1-73.113 (Error(_, "wrong return values"))
Result: 1 0 2_303 0 : [v128]
Expect: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:74.1-74.114 (Error(_, "wrong return values"))
Result: 1_027 0 1_734_522_320 32_568 : [v128]
Expect: 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:75.1-75.126 (Error(_, "wrong return values"))
Result: 1_732_309_480 32_568 1_734_462_184 32_568 : [v128]
Expect: 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:76.1-76.125 (Error(_, "wrong return values"))
Result: 3_072 0 1_727_288_768 32_568 : [v128]
Expect: 256 256 256 256 256 256 256 256 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:78.1-78.130 (Error(_, "wrong return values"))
Result: 1_734_354_688 32_568 2_048 0 : [v128]
Expect: 256 256 256 256 256 256 256 256 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:79.1-79.129 (Error(_, "wrong return values"))
Result: 1 0 2_048 0 : [v128]
Expect: 513 513 513 513 513 513 513 513 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:80.1-80.137 (Error(_, "wrong return values"))
Result: 1 0 3 0 : [v128]
Expect: 770 770 770 770 770 770 770 770 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:81.1-81.137 (Error(_, "wrong return values"))
Result: 1 0 1_025 0 : [v128]
Expect: 15 15 15 15 15 15 15 15 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:82.1-82.138 (Error(_, "wrong return values"))
Result: 1_734_509_440 32_568 3_072 0 : [v128]
Expect: 513 513 513 513 513 513 513 513 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:83.1-83.130 (Error(_, "wrong return values"))
Result: 1_653_875_248 21_999 2_048 0 : [v128]
Expect: 513 513 513 513 513 513 513 513 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:84.1-84.129 (Error(_, "wrong return values"))
Result: 1_727_189_688 32_568 2_048 0 : [v128]
Expect: 770 770 770 770 770 770 770 770 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:85.1-85.137 (Error(_, "wrong return values"))
Result: 1_024 0 1 0 : [v128]
Expect: 1_027 1_027 1_027 1_027 1_027 1_027 1_027 1_027 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:86.1-86.137 (Error(_, "wrong return values"))
Result: 5_120 0 1 0 : [v128]
Expect: 0 0 0 0 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:87.1-87.138 (Error(_, "wrong return values"))
Result: 2_016_817_526 1_718_562_360 0 117_440_512 : [v128]
Expect: 7_966 7_966 7_966 7_966 7_966 7_966 7_966 7_966 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:88.1-88.134 (Error(_, "wrong return values"))
Result: 2_048 0 1_733_906_656 32_568 : [v128]
Expect: 7_966 7_966 7_966 7_966 7_966 7_966 7_966 7_966 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:89.1-89.133 (Error(_, "wrong return values"))
Result: 1 0 1_728_467_016 32_568 : [v128]
Expect: 50_462_976 50_462_976 50_462_976 50_462_976 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:91.1-91.118 (Error(_, "wrong return values"))
Result: 0 0 3_324 0 : [v128]
Expect: 50_462_976 50_462_976 50_462_976 50_462_976 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:92.1-92.117 (Error(_, "wrong return values"))
Result: 7 0 5_120 0 : [v128]
Expect: 67_305_985 67_305_985 67_305_985 67_305_985 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:93.1-93.125 (Error(_, "wrong return values"))
Result: 3_072 0 1 0 : [v128]
Expect: 84_148_994 84_148_994 84_148_994 84_148_994 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:94.1-94.125 (Error(_, "wrong return values"))
Result: 1_733_700_856 32_568 1_733_700_672 32_568 : [v128]
Expect: 15 15 15 15 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:95.1-95.126 (Error(_, "wrong return values"))
Result: 1_728_449_480 32_568 1_733_661_176 32_568 : [v128]
Expect: 67_305_985 67_305_985 67_305_985 67_305_985 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:96.1-96.118 (Error(_, "wrong return values"))
Result: 5 0 5_120 0 : [v128]
Expect: 67_305_985 67_305_985 67_305_985 67_305_985 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:97.1-97.117 (Error(_, "wrong return values"))
Result: 1_733_580_488 32_568 1_653_875_248 21_999 : [v128]
Expect: 84_148_994 84_148_994 84_148_994 84_148_994 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:98.1-98.125 (Error(_, "wrong return values"))
Result: 7 0 5_120 0 : [v128]
Expect: 100_992_003 100_992_003 100_992_003 100_992_003 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:99.1-99.125 (Error(_, "wrong return values"))
Result: 1_733_499_728 32_568 1 0 : [v128]
Expect: 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:100.1-100.126 (Error(_, "wrong return values"))
Result: 1_733_459_512 32_568 9 0 : [v128]
Expect: 522_067_228 522_067_228 522_067_228 522_067_228 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:101.1-101.122 (Error(_, "wrong return values"))
Result: 1_733_419_440 32_568 5 0 : [v128]
Expect: 522_067_228 522_067_228 522_067_228 522_067_228 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:102.1-102.121 (Error(_, "wrong return values"))
Result: 1 0 1_733_379_336 32_568 : [v128]
Expect: 506_097_522_914_230_528 506_097_522_914_230_528 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:104.1-104.112 (Error(_, "wrong return values"))
Result: 2_048 0 1_727_988_136 32_568 : [v128]
Expect: 506_097_522_914_230_528 506_097_522_914_230_528 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:105.1-105.111 (Error(_, "wrong return values"))
Result: 5 16_777_216 1_733_301_480 32_568 : [v128]
Expect: 578_437_695_752_307_201 578_437_695_752_307_201 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:106.1-106.119 (Error(_, "wrong return values"))
Result: 1_719_160_136 32_568 5_120 0 : [v128]
Expect: 650_777_868_590_383_874 650_777_868_590_383_874 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:107.1-107.119 (Error(_, "wrong return values"))
Result: 5 0 3_072 0 : [v128]
Expect: 15 15 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:108.1-108.120 (Error(_, "wrong return values"))
Result: 1 0 1_727_987_800 32_568 : [v128]
Expect: 578_437_695_752_307_201 578_437_695_752_307_201 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:109.1-109.112 (Error(_, "wrong return values"))
Result: 1_727_987_800 32_568 1_733_146_168 32_568 : [v128]
Expect: 578_437_695_752_307_201 578_437_695_752_307_201 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:110.1-110.111 (Error(_, "wrong return values"))
Result: 1 0 1_727_987_800 32_568 : [v128]
Expect: 650_777_868_590_383_874 650_777_868_590_383_874 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:111.1-111.119 (Error(_, "wrong return values"))
Result: 1_733_067_512 32_568 1 0 : [v128]
Expect: 723_118_041_428_460_547 723_118_041_428_460_547 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:112.1-112.119 (Error(_, "wrong return values"))
Result: 1_653_540_736 21_999 2 0 : [v128]
Expect: 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:113.1-113.120 (Error(_, "wrong return values"))
Result: 1_732_990_448 32_568 1_653_729_384 21_999 : [v128]
Expect: 2_242_261_671_028_070_680 2_242_261_671_028_070_680 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:114.1-114.116 (Error(_, "wrong return values"))
Result: 48 100_663_296 1_276 0 : [v128]
Expect: 2_242_261_671_028_070_680 2_242_261_671_028_070_680 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:115.1-115.115 (Error(_, "wrong return values"))
Result: 4_343 0 1_649_651_152 21_999 : [v128]
Expect: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:198.1-198.104 (Error(_, "wrong return values"))
Result: 1_734_226_712 32_568 2_048 0 : [v128]
Expect: 513 513 513 513 513 513 513 513 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:199.1-199.129 (Error(_, "wrong return values"))
Result: 4_343 0 1_649_651_248 21_999 : [v128]
Expect: 84_148_994 84_148_994 84_148_994 84_148_994 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:200.1-200.117 (Error(_, "wrong return values"))
Result: 1_649_211_888 32_568 1_734_244_616 32_568 : [v128]
Expect: 2_569 2_569 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:201.1-201.111 (Error(_, "wrong return values"))
Result: 2_048 0 1_734_075_248 32_568 : [v128]
Expect: 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:202.1-202.107 (Error(_, "wrong return values"))
Result: 3 0 5_120 0 : [v128]
Expect: 1_284 1_284 1_284 1_284 1_284 1_284 1_284 1_284 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:203.1-203.132 (Error(_, "wrong return values"))
Result: 1 0 7 0 : [v128]
Expect: 134_678_021 134_678_021 134_678_021 134_678_021 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:204.1-204.120 (Error(_, "wrong return values"))
Result: 2_048 0 1_733_904_280 32_568 : [v128]
Expect: 10 10 : [v128]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:205.1-205.114 (Error(_, "wrong return values"))
Result: 120 : [i32]
Expect: 6 : [i32]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:206.1-206.81 (Error(_, "wrong return values"))
Result: -120 : [i32]
Expect: 7 : [i32]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:207.1-207.82 (Error(_, "wrong return values"))
Result: 0 : [i32]
Expect: 8 : [i32]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:208.1-208.82 (Error(_, "wrong return values"))
Result: -16 : [i32]
Expect: 0 : [i32]
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast:209.1-209.82 (Error(_, "wrong return values"))
- 34/114 (29.82%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_zero.wast =====
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_splat.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_splat.wast:300.1-300.133 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:228.50-228.53"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_splat.wast:325.1-325.81 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_splat.wast:326.1-326.86 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_splat.wast:327.1-327.91 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_splat.wast:328.1-328.83 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:293.29-293.32"))
- 157/162 (96.91%)

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

Total [42935/45187] (95.02%)

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
- 259/259 (100.00%)

===== ../../test-interpreter/spec-test-3/align.wast =====
- 73/73 (100.00%)

===== ../../test-interpreter/spec-test-3/binary-leb128.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-3/binary.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-3/block.wast =====
- 53/53 (100.00%)

===== ../../test-interpreter/spec-test-3/br.wast =====
- 77/77 (100.00%)

===== ../../test-interpreter/spec-test-3/br_if.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-3/br_table.wast =====
- 150/150 (100.00%)

===== ../../test-interpreter/spec-test-3/bulk.wast =====
- 117/117 (100.00%)

===== ../../test-interpreter/spec-test-3/call.wast =====
- 71/71 (100.00%)

===== ../../test-interpreter/spec-test-3/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/comments.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-3/const.wast =====
- 702/702 (100.00%)

===== ../../test-interpreter/spec-test-3/conversions.wast =====
- 594/594 (100.00%)

===== ../../test-interpreter/spec-test-3/custom.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-3/data.wast =====
- 39/39 (100.00%)

===== ../../test-interpreter/spec-test-3/elem.wast =====
- 66/66 (100.00%)

===== ../../test-interpreter/spec-test-3/endianness.wast =====
- 69/69 (100.00%)

===== ../../test-interpreter/spec-test-3/exports.wast =====
- 65/65 (100.00%)

===== ../../test-interpreter/spec-test-3/f32.wast =====
- 2501/2501 (100.00%)

===== ../../test-interpreter/spec-test-3/f32_bitwise.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-3/f32_cmp.wast =====
- 2401/2401 (100.00%)

===== ../../test-interpreter/spec-test-3/f64.wast =====
- 2501/2501 (100.00%)

===== ../../test-interpreter/spec-test-3/f64_bitwise.wast =====
- 361/361 (100.00%)

===== ../../test-interpreter/spec-test-3/f64_cmp.wast =====
- 2401/2401 (100.00%)

===== ../../test-interpreter/spec-test-3/fac.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-3/float_exprs.wast =====
- 900/900 (100.00%)

===== ../../test-interpreter/spec-test-3/float_literals.wast =====
- 85/85 (100.00%)

===== ../../test-interpreter/spec-test-3/float_memory.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-3/float_misc.wast =====
- 441/441 (100.00%)

===== ../../test-interpreter/spec-test-3/forward.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-3/func.wast =====
- 100/100 (100.00%)

===== ../../test-interpreter/spec-test-3/func_ptrs.wast =====
- print_i32: 83
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/br_on_non_null.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/br_on_null.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/call_ref.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/ref_as_non_null.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/return_call_ref.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array.wast =====
- Test failed at ../../test-interpreter/spec-test-3/gc/array.wast:187.1-187.43 (Failure("Invalid DSL function call: storagesize"))
- Test failed at ../../test-interpreter/spec-test-3/gc/array.wast:188.1-188.40 (Failure("Invalid DSL function call: storagesize"))
- Test failed at ../../test-interpreter/spec-test-3/gc/array.wast:189.1-189.59 (Failure("Invalid DSL function call: storagesize"))
- Test failed at ../../test-interpreter/spec-test-3/gc/array.wast:190.1-190.77 (Failure("Invalid DSL function call: storagesize"))
- Test failed at ../../test-interpreter/spec-test-3/gc/array.wast:191.1-191.45 (Failure("Invalid DSL function call: storagesize"))
- Test failed at ../../test-interpreter/spec-test-3/gc/array.wast:193.1-193.60 (Failure("Invalid DSL function call: storagesize"))
- Test failed at ../../test-interpreter/spec-test-3/gc/array.wast:194.1-194.78 (Failure("Invalid DSL function call: storagesize"))
- 31/38 (81.58%)

===== ../../test-interpreter/spec-test-3/gc/array_copy.wast =====
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:125.1-125.53 (Failure("Invalid DSL function call: storagesize"))
Result: 10 : [i32]
Expect: 97 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:126.1-126.70 (Error(_, "wrong return values"))
Result: 10 : [i32]
Expect: 97 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:127.1-127.70 (Error(_, "wrong return values"))
Result: 0 : [i32]
Expect: 98 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:128.1-128.70 (Error(_, "wrong return values"))
Result: 0 : [i32]
Expect: 101 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:129.1-129.71 (Error(_, "wrong return values"))
Result: 0 : [i32]
Expect: 106 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:130.1-130.72 (Error(_, "wrong return values"))
Result: 0 : [i32]
Expect: 107 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:131.1-131.72 (Error(_, "wrong return values"))
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:133.1-133.53 (Failure("Invalid DSL function call: storagesize"))
Result: 10 : [i32]
Expect: 98 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:134.1-134.70 (Error(_, "wrong return values"))
Result: 10 : [i32]
Expect: 99 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:135.1-135.70 (Error(_, "wrong return values"))
Result: 0 : [i32]
Expect: 103 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:136.1-136.71 (Error(_, "wrong return values"))
Result: 0 : [i32]
Expect: 107 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:137.1-137.71 (Error(_, "wrong return values"))
Result: 0 : [i32]
Expect: 108 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:138.1-138.72 (Error(_, "wrong return values"))
Result: 0 : [i32]
Expect: 108 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_copy.wast:139.1-139.72 (Error(_, "wrong return values"))
- 17/31 (54.84%)

===== ../../test-interpreter/spec-test-3/gc/array_fill.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_init_data.wast =====
- Test failed at ../../test-interpreter/spec-test-3/gc/array_init_data.wast:95.1-95.85 (File "src/backend-interpreter/numerics.ml", line 341, characters 10-16: Assertion failed)
Result: 0 : [i32]
Expect: 99 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_init_data.wast:97.1-97.70 (Error(_, "wrong return values"))
Result: 0 : [i32]
Expect: 100 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_init_data.wast:98.1-98.71 (Error(_, "wrong return values"))
- Test failed at ../../test-interpreter/spec-test-3/gc/array_init_data.wast:101.1-101.89 (File "src/backend-interpreter/numerics.ml", line 341, characters 10-16: Assertion failed)
Result: 0 : [i32]
Expect: 26_470 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_init_data.wast:103.1-103.78 (Error(_, "wrong return values"))
Result: 0 : [i32]
Expect: 26_984 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/gc/array_init_data.wast:104.1-104.78 (Error(_, "wrong return values"))
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
- 71/71 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/struct.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/type-subtyping.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-3/global.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-3/i32.wast =====
- 375/375 (100.00%)

===== ../../test-interpreter/spec-test-3/i64.wast =====
- 385/385 (100.00%)

===== ../../test-interpreter/spec-test-3/if.wast =====
- 124/124 (100.00%)

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
- 88/88 (100.00%)

===== ../../test-interpreter/spec-test-3/inline-module.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/int_exprs.wast =====
- 108/108 (100.00%)

===== ../../test-interpreter/spec-test-3/int_literals.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/labels.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-3/left-to-right.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-3/linking.wast =====
- 111/111 (100.00%)

===== ../../test-interpreter/spec-test-3/load.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-3/local_get.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-3/local_set.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-3/local_tee.wast =====
- 56/56 (100.00%)

===== ../../test-interpreter/spec-test-3/loop.wast =====
- 78/78 (100.00%)

===== ../../test-interpreter/spec-test-3/memory.wast =====
- 55/55 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_copy.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_fill.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_init.wast =====
- 173/173 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_redundancy.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_size.wast =====
- 40/40 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_trap.wast =====
- 182/182 (100.00%)

===== ../../test-interpreter/spec-test-3/names.wast =====
- print_i32: 42
- print_i32: 123
- 486/486 (100.00%)

===== ../../test-interpreter/spec-test-3/nop.wast =====
- 84/84 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_func.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_is_null.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_null.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-3/return.wast =====
- 64/64 (100.00%)

===== ../../test-interpreter/spec-test-3/select.wast =====
- 120/120 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_address.wast =====
- 45/45 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_align.wast =====
- 54/54 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_bit_shift.wast =====
- 213/213 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_bitwise.wast =====
- 141/141 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_boolean.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:39.1-40.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:41.1-42.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:43.1-44.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:45.1-46.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:47.1-48.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:49.1-50.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:51.1-52.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:53.1-54.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:55.1-56.55 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:57.1-58.64 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:658.30-658.33"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:59.1-60.64 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:658.30-658.33"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:85.1-86.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:87.1-88.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:89.1-90.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:91.1-92.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:93.1-94.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:95.1-96.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:97.1-98.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:99.1-100.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:101.1-102.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:103.1-104.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:105.1-106.55 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:107.1-108.64 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:658.30-658.33"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:109.1-110.64 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:658.30-658.33"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:135.1-136.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:137.1-138.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:139.1-140.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:141.1-142.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:143.1-144.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:145.1-146.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:147.1-148.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:149.1-150.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:151.1-152.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:153.1-154.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:155.1-156.55 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:157.1-158.64 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:658.30-658.33"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:159.1-160.64 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:658.30-658.33"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:163.1-164.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:165.1-166.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:167.1-168.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:169.1-170.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:171.1-172.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:173.1-174.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:175.1-176.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:177.1-178.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:179.1-180.55 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:181.1-182.64 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:658.30-658.33"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:183.1-184.64 (Failure("Invalid assignment on value I64: SubE (inn,inn) @8-reduction.watsup:658.30-658.33"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:495.1-496.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:497.1-498.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:499.1-500.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:502.1-503.66 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:504.1-505.66 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:506.1-507.66 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:509.1-510.66 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:511.1-512.66 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:513.1-514.66 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:530.1-531.70 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:532.1-533.70 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:534.1-535.70 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:536.1-537.70 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:538.1-539.70 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:540.1-541.70 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:556.1-557.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:558.1-559.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:560.1-561.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:562.1-563.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:564.1-565.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:566.1-567.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:653.1-655.74 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:656.1-658.74 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:659.1-661.74 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:662.1-664.74 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:665.1-667.74 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:668.1-670.74 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:671.1-673.74 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:674.1-676.74 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:677.1-679.74 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:681.1-683.73 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:684.1-686.73 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:687.1-689.73 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:690.1-692.73 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:693.1-695.73 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:696.1-698.73 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:699.1-701.73 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:702.1-704.73 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:705.1-707.73 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:709.1-711.74 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:712.1-714.74 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:715.1-717.74 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:718.1-720.74 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:721.1-723.74 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:724.1-726.74 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:727.1-729.74 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:730.1-732.74 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:733.1-735.74 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:865.1-866.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:867.1-868.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:869.1-870.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:871.1-872.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:873.1-874.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:875.1-876.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:877.1-878.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:879.1-880.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:881.1-882.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:884.1-886.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:887.1-889.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:890.1-892.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:893.1-895.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:896.1-898.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:899.1-901.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:902.1-904.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:905.1-907.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:908.1-910.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:912.1-914.68 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:915.1-917.68 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:918.1-920.68 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:921.1-923.68 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:924.1-926.68 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:927.1-929.68 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:930.1-932.68 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:933.1-935.68 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:936.1-938.68 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:940.1-942.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:943.1-945.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:946.1-948.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:949.1-951.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:952.1-954.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:955.1-957.69 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:958.1-960.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:961.1-963.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:964.1-966.69 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:968.1-971.75 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:972.1-975.75 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:976.1-979.75 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:980.1-983.75 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:984.1-987.75 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_boolean.wast:988.1-991.75 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- 123/261 (47.13%)

===== ../../test-interpreter/spec-test-3/simd/simd_const.wast =====
- 577/577 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_conversions.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:35.1-36.77 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:37.1-38.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:39.1-40.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:41.1-42.89 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:43.1-44.77 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:45.1-46.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:47.1-48.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:49.1-50.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:52.1-53.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:55.1-56.115 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:57.1-58.77 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:59.1-60.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:61.1-62.97 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:63.1-64.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:65.1-66.97 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:67.1-68.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:73.1-74.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:75.1-76.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:77.1-78.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:79.1-80.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:81.1-82.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:83.1-84.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:85.1-86.91 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:87.1-88.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:89.1-90.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:91.1-92.107 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:93.1-94.91 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:95.1-96.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:97.1-98.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:99.1-100.107 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:101.1-102.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:103.1-104.107 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:105.1-106.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:107.1-108.107 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:109.1-110.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:111.1-112.107 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:113.1-114.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:115.1-116.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:117.1-118.91 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:119.1-120.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:121.1-122.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:123.1-124.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:125.1-126.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:127.1-128.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:129.1-130.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:131.1-132.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:133.1-134.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:135.1-136.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:137.1-138.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:139.1-140.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:141.1-142.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:143.1-144.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:145.1-146.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:147.1-148.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:149.1-150.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:151.1-152.105 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:153.1-154.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:155.1-156.107 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:157.1-158.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:159.1-160.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:161.1-162.101 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:163.1-164.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:165.1-166.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:167.1-168.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:169.1-170.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:171.1-172.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:173.1-174.91 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:175.1-176.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:253.1-254.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:255.1-256.81 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:257.1-258.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:259.1-260.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:261.1-262.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:263.1-264.91 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:269.1-270.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:271.1-272.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:273.1-274.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:275.1-276.93 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:277.1-278.97 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:283.1-285.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:286.1-288.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:289.1-291.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:292.1-294.106 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:295.1-297.106 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:298.1-300.106 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:301.1-303.106 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:304.1-306.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:307.1-309.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:310.1-312.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:313.1-315.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:316.1-318.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:319.1-321.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:322.1-324.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:325.1-327.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:328.1-330.154 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:331.1-333.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:334.1-336.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:337.1-339.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:340.1-342.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:343.1-345.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:346.1-348.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:349.1-351.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:352.1-354.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:355.1-357.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:358.1-360.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:361.1-363.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:364.1-366.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:367.1-369.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:372.1-374.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:375.1-377.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:378.1-380.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:381.1-383.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:384.1-386.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:387.1-389.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:390.1-392.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:393.1-395.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:396.1-398.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:399.1-401.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:402.1-404.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:405.1-407.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:408.1-410.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:411.1-413.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:414.1-416.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:417.1-419.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:420.1-422.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:423.1-425.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:426.1-428.146 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:429.1-431.122 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:432.1-434.122 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:435.1-437.122 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:438.1-440.122 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:441.1-443.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:444.1-446.122 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:447.1-449.122 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:452.1-454.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:455.1-457.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:458.1-460.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:461.1-463.86 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:464.1-466.86 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:467.1-469.86 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:470.1-472.86 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:473.1-475.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:476.1-478.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:479.1-481.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:482.1-484.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:485.1-487.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:488.1-490.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:491.1-493.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:494.1-496.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:497.1-499.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:500.1-502.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:503.1-505.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:506.1-508.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:509.1-511.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:512.1-514.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:515.1-517.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:518.1-520.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:521.1-523.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:524.1-526.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:527.1-529.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:530.1-532.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:533.1-535.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:536.1-538.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:541.1-543.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:544.1-546.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:547.1-549.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:550.1-552.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:553.1-555.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:556.1-558.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:559.1-561.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:562.1-564.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:565.1-567.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:568.1-570.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:571.1-573.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:574.1-576.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:577.1-579.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:580.1-582.102 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:583.1-585.102 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:586.1-588.102 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:589.1-591.102 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:592.1-594.82 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:595.1-597.122 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:598.1-600.102 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:768.1-770.124 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:771.1-773.98 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:774.1-776.125 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:777.1-779.99 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:780.1-782.88 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:783.1-785.112 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:786.1-788.95 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:789.1-791.113 (Failure("Invalid assignment on value I16: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:793.1-795.108 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:796.1-798.89 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:799.1-801.109 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:802.1-804.90 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:805.1-807.85 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:808.1-810.100 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:811.1-813.86 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_conversions.wast:814.1-816.101 (Failure("Invalid assignment on value I32: SubE (inn_2,inn) @8-reduction.watsup:664.63-664.68"))
- 35/234 (14.96%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4.wast =====
- 774/774 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_arith.wast =====
- 1806/1806 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_cmp.wast =====
- 2583/2583 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_pmin_pmax.wast =====
- 3873/3873 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_rounding.wast =====
- 177/177 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2.wast =====
- 795/795 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_arith.wast =====
- 1809/1809 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_cmp.wast =====
- 2661/2661 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_pmin_pmax.wast =====
- 3873/3873 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_rounding.wast =====
- 177/177 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_arith.wast =====
- 183/183 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_arith2.wast =====
- 153/153 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:311.1-313.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:314.1-316.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:317.1-319.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:320.1-322.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:323.1-325.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:326.1-328.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:329.1-331.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:332.1-334.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:335.1-337.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:338.1-340.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:341.1-343.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:344.1-346.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:347.1-349.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:350.1-352.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:353.1-355.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:356.1-358.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:359.1-361.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:362.1-364.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:365.1-367.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:368.1-370.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:371.1-373.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:376.1-378.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:379.1-381.70 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:382.1-384.68 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:385.1-387.70 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:388.1-390.70 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:393.1-395.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:396.1-398.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:399.1-401.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:402.1-404.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:405.1-407.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:408.1-410.68 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:411.1-413.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:416.1-418.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:419.1-421.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:422.1-424.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:425.1-427.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:428.1-430.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:431.1-433.67 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:434.1-436.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:437.1-439.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:440.1-442.66 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:449.1-451.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:452.1-454.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:455.1-457.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:458.1-460.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:461.1-463.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:464.1-466.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:467.1-469.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:472.1-474.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:475.1-477.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:478.1-480.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:481.1-483.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:484.1-486.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:489.1-491.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:492.1-494.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:495.1-497.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:498.1-500.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:501.1-503.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:504.1-506.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:507.1-509.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:512.1-514.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:515.1-517.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:520.1-522.74 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:523.1-525.70 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:526.1-528.69 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:529.1-531.70 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:532.1-534.70 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:537.1-539.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:540.1-542.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:543.1-545.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:546.1-548.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:549.1-551.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:552.1-554.70 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:555.1-557.74 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:560.1-562.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:563.1-565.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:566.1-568.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:569.1-571.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:572.1-574.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:575.1-577.67 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:578.1-580.74 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:581.1-583.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:584.1-586.66 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:593.1-595.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:596.1-598.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:599.1-601.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:602.1-604.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:605.1-607.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:608.1-610.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:611.1-613.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:616.1-618.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:619.1-621.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:622.1-624.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:625.1-627.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:628.1-630.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:633.1-635.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:636.1-638.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:639.1-641.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:642.1-644.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:645.1-647.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:648.1-650.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:651.1-653.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:656.1-658.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:659.1-661.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:664.1-666.66 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:667.1-669.70 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:670.1-672.68 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:673.1-675.70 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:676.1-678.72 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:681.1-683.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:684.1-686.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:687.1-689.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:690.1-692.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:693.1-695.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:696.1-698.70 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:699.1-701.66 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:704.1-706.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:707.1-709.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:710.1-712.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:713.1-715.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:716.1-718.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:719.1-721.72 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:722.1-724.66 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:725.1-727.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:728.1-730.74 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:737.1-739.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:740.1-742.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:743.1-745.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:746.1-748.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:749.1-751.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:752.1-754.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:755.1-757.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:760.1-762.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:763.1-765.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:766.1-768.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:769.1-771.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:772.1-774.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:777.1-779.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:780.1-782.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:783.1-785.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:786.1-788.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:789.1-791.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:792.1-794.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:795.1-797.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:800.1-802.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:803.1-805.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:808.1-810.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:811.1-813.70 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:814.1-816.69 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:817.1-819.70 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:820.1-822.72 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:825.1-827.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:828.1-830.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:831.1-833.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:834.1-836.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:837.1-839.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:840.1-842.72 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:843.1-845.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:848.1-850.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:851.1-853.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:854.1-856.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:857.1-859.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:860.1-862.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:863.1-865.72 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:866.1-868.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:869.1-871.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:872.1-874.74 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:881.1-883.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:884.1-886.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:887.1-889.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:890.1-892.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:893.1-895.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:896.1-898.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:899.1-901.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:904.1-906.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:907.1-909.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:910.1-912.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:913.1-915.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:916.1-918.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:921.1-923.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:924.1-926.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:927.1-929.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:930.1-932.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:933.1-935.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:936.1-938.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:939.1-941.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:944.1-946.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:947.1-949.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:952.1-954.74 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:955.1-957.70 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:958.1-960.72 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:961.1-963.70 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:964.1-966.68 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:969.1-971.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:972.1-974.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:975.1-977.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:978.1-980.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:981.1-983.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:984.1-986.70 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:987.1-989.74 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:992.1-994.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:995.1-997.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:998.1-1000.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1001.1-1003.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1004.1-1006.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1007.1-1009.67 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1010.1-1012.74 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1013.1-1015.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1016.1-1018.66 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1025.1-1027.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1028.1-1030.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1031.1-1033.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1034.1-1036.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1037.1-1039.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1040.1-1042.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1043.1-1045.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1048.1-1050.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1051.1-1053.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1054.1-1056.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1057.1-1059.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1060.1-1062.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1088.1-1090.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1091.1-1093.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1096.1-1098.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1099.1-1101.70 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1102.1-1104.71 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1105.1-1107.70 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1108.1-1110.68 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1113.1-1115.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1116.1-1118.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1119.1-1121.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1122.1-1124.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1125.1-1127.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1128.1-1130.68 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1131.1-1133.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1136.1-1138.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1139.1-1141.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1142.1-1144.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1145.1-1147.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1148.1-1150.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1151.1-1153.68 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1154.1-1156.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1157.1-1159.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1160.1-1162.66 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1169.1-1171.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1172.1-1174.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1175.1-1177.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1178.1-1180.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1181.1-1183.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1184.1-1186.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1187.1-1189.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1192.1-1194.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1195.1-1197.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1198.1-1200.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1201.1-1203.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1204.1-1206.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1209.1-1211.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1212.1-1214.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1215.1-1217.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1218.1-1220.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1221.1-1223.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1224.1-1226.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1227.1-1229.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1232.1-1234.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1235.1-1237.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1240.1-1242.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1243.1-1245.70 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1246.1-1248.72 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1249.1-1251.70 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1252.1-1254.72 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1257.1-1259.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1260.1-1262.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1263.1-1265.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1266.1-1268.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1269.1-1271.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1272.1-1274.72 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1275.1-1277.66 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1280.1-1282.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1283.1-1285.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1286.1-1288.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1289.1-1291.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1292.1-1294.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1295.1-1297.72 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1298.1-1300.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1301.1-1303.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1304.1-1306.74 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1313.1-1315.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1316.1-1318.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1319.1-1321.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1322.1-1324.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1325.1-1327.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1328.1-1330.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1331.1-1333.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1336.1-1338.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1339.1-1341.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1342.1-1344.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1345.1-1347.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1348.1-1350.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1353.1-1355.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1356.1-1358.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1359.1-1361.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1362.1-1364.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1365.1-1367.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1368.1-1370.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1371.1-1373.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1376.1-1378.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1379.1-1381.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1384.1-1386.66 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1387.1-1389.70 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1390.1-1392.71 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1393.1-1395.70 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1396.1-1398.72 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1401.1-1403.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1404.1-1406.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1407.1-1409.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1410.1-1412.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1413.1-1415.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1416.1-1418.70 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1419.1-1421.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1424.1-1426.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1427.1-1429.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1430.1-1432.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1433.1-1435.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1436.1-1438.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1439.1-1441.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1442.1-1444.66 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1445.1-1447.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1448.1-1450.74 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1727.1-1727.41 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1728.1-1728.41 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1729.1-1729.41 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1730.1-1730.41 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1733.1-1733.39 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1734.1-1734.39 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1735.1-1735.39 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1736.1-1736.39 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast:1737.1-1737.36 (Failure("Invalid virelop: LTS"))
- 97/435 (22.30%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:11.1-12.91 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:13.1-14.91 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:15.1-16.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:17.1-18.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:19.1-20.115 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:21.1-22.115 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:23.1-24.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:25.1-26.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:29.1-30.91 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:31.1-32.91 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:33.1-34.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:35.1-36.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:37.1-38.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:39.1-40.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:41.1-42.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast:43.1-44.107 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- 1/17 (5.88%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:13.1-15.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:16.1-18.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:19.1-21.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:22.1-24.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:25.1-27.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:28.1-30.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:31.1-33.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:34.1-36.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:37.1-39.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:40.1-42.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:43.1-45.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:46.1-48.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:49.1-51.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:52.1-54.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:55.1-57.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:58.1-60.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:61.1-63.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:64.1-66.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:67.1-69.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:70.1-72.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:73.1-75.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:76.1-78.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:79.1-81.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:82.1-84.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:85.1-87.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:88.1-90.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:93.1-95.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:96.1-98.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:99.1-101.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:102.1-104.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:105.1-107.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:108.1-110.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:111.1-113.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:114.1-116.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:117.1-119.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:120.1-122.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:123.1-125.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:126.1-128.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:129.1-131.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:132.1-134.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:135.1-137.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:138.1-140.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:141.1-143.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:144.1-146.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:147.1-149.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:150.1-152.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:153.1-155.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:156.1-158.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:159.1-161.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:162.1-164.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:165.1-167.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:168.1-170.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:173.1-175.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:176.1-178.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:179.1-181.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:182.1-184.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:185.1-187.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:188.1-190.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:191.1-193.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:194.1-196.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:197.1-199.126 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:200.1-202.126 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:203.1-205.126 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:206.1-208.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:209.1-211.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:212.1-214.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:215.1-217.126 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:218.1-220.126 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:221.1-223.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:224.1-226.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:227.1-229.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:230.1-232.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:233.1-235.86 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:236.1-238.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:239.1-241.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:242.1-244.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:245.1-247.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:248.1-250.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:253.1-255.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:256.1-258.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:259.1-261.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:262.1-264.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:265.1-267.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:268.1-270.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:271.1-273.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:274.1-276.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:277.1-279.127 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:280.1-282.127 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:283.1-285.127 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:286.1-288.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:289.1-291.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:292.1-294.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:295.1-297.127 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:298.1-300.127 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:301.1-303.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:304.1-306.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:307.1-309.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:310.1-312.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:313.1-315.87 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:316.1-318.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:319.1-321.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:322.1-324.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:325.1-327.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast:328.1-330.111 (Failure("Algorithm not found: VEXTMUL"))
- 1/105 (0.95%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_q15mulr_sat_s.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_sat_arith.wast =====
- 206/206 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith.wast =====
- 183/183 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith2.wast =====
- 123/123 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:311.1-313.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:314.1-316.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:317.1-319.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:320.1-322.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:323.1-325.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:326.1-328.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:329.1-331.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:334.1-336.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:337.1-339.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:340.1-342.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:343.1-345.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:346.1-348.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:351.1-353.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:354.1-356.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:357.1-359.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:360.1-362.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:363.1-365.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:366.1-368.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:369.1-371.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:374.1-376.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:377.1-379.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:382.1-384.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:385.1-387.60 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:388.1-390.59 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:391.1-393.60 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:394.1-396.59 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:399.1-401.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:402.1-404.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:405.1-407.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:408.1-410.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:411.1-413.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:414.1-416.59 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:417.1-419.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:422.1-424.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:425.1-427.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:428.1-430.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:431.1-433.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:434.1-436.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:437.1-439.60 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:440.1-442.62 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:443.1-445.58 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:446.1-448.62 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:455.1-457.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:458.1-460.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:461.1-463.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:464.1-466.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:467.1-469.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:470.1-472.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:473.1-475.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:478.1-480.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:481.1-483.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:484.1-486.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:487.1-489.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:490.1-492.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:495.1-497.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:498.1-500.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:501.1-503.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:504.1-506.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:507.1-509.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:510.1-512.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:513.1-515.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:518.1-520.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:521.1-523.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:526.1-528.62 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:529.1-531.60 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:532.1-534.59 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:535.1-537.60 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:538.1-540.60 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:543.1-545.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:546.1-548.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:549.1-551.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:552.1-554.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:555.1-557.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:558.1-560.59 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:561.1-563.62 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:566.1-568.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:569.1-571.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:572.1-574.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:575.1-577.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:578.1-580.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:581.1-583.60 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:584.1-586.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:587.1-589.58 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:590.1-592.62 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:599.1-601.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:602.1-604.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:605.1-607.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:608.1-610.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:611.1-613.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:614.1-616.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:617.1-619.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:622.1-624.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:625.1-627.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:628.1-630.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:631.1-633.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:634.1-636.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:639.1-641.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:642.1-644.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:645.1-647.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:648.1-650.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:651.1-653.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:654.1-656.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:657.1-659.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:662.1-664.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:665.1-667.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:670.1-672.58 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:673.1-675.60 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:676.1-678.59 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:679.1-681.60 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:682.1-684.60 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:687.1-689.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:690.1-692.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:693.1-695.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:696.1-698.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:699.1-701.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:702.1-704.61 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:705.1-707.58 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:710.1-712.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:713.1-715.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:716.1-718.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:719.1-721.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:722.1-724.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:725.1-727.61 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:728.1-730.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:731.1-733.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:734.1-736.62 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:743.1-745.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:746.1-748.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:749.1-751.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:752.1-754.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:755.1-757.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:758.1-760.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:761.1-763.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:766.1-768.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:769.1-771.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:772.1-774.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:775.1-777.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:778.1-780.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:783.1-785.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:786.1-788.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:789.1-791.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:792.1-794.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:795.1-797.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:798.1-800.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:801.1-803.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:806.1-808.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:809.1-811.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:814.1-816.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:817.1-819.60 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:820.1-822.59 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:823.1-825.60 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:826.1-828.61 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:831.1-833.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:834.1-836.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:837.1-839.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:840.1-842.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:843.1-845.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:846.1-848.61 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:849.1-851.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:854.1-856.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:857.1-859.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:860.1-862.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:863.1-865.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:866.1-868.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:869.1-871.61 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:872.1-874.58 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:875.1-877.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:878.1-880.62 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:887.1-889.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:890.1-892.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:893.1-895.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:896.1-898.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:899.1-901.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:902.1-904.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:905.1-907.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:910.1-912.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:913.1-915.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:916.1-918.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:919.1-921.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:922.1-924.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:927.1-929.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:930.1-932.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:933.1-935.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:936.1-938.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:939.1-941.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:942.1-944.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:945.1-947.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:950.1-952.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:953.1-955.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:958.1-960.62 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:961.1-963.60 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:964.1-966.61 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:967.1-969.60 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:970.1-972.60 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:975.1-977.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:978.1-980.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:981.1-983.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:984.1-986.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:987.1-989.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:990.1-992.59 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:993.1-995.62 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:998.1-1000.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1001.1-1003.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1004.1-1006.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1007.1-1009.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1010.1-1012.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1013.1-1015.60 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1016.1-1018.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1019.1-1021.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1022.1-1024.58 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1031.1-1033.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1034.1-1036.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1037.1-1039.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1040.1-1042.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1043.1-1045.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1046.1-1048.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1049.1-1051.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1054.1-1056.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1057.1-1059.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1060.1-1062.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1063.1-1065.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1066.1-1068.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1071.1-1073.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1074.1-1076.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1077.1-1079.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1080.1-1082.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1083.1-1085.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1086.1-1088.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1089.1-1091.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1094.1-1096.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1097.1-1099.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1102.1-1104.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1105.1-1107.60 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1108.1-1110.61 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1111.1-1113.60 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1114.1-1116.59 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1119.1-1121.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1122.1-1124.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1125.1-1127.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1128.1-1130.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1131.1-1133.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1134.1-1136.59 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1137.1-1139.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1142.1-1144.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1145.1-1147.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1148.1-1150.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1151.1-1153.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1154.1-1156.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1157.1-1159.59 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1160.1-1162.62 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1163.1-1165.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1166.1-1168.58 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1175.1-1177.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1178.1-1180.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1181.1-1183.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1184.1-1186.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1187.1-1189.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1190.1-1192.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1193.1-1195.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1198.1-1200.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1201.1-1203.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1204.1-1206.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1207.1-1209.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1210.1-1212.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1215.1-1217.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1218.1-1220.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1221.1-1223.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1224.1-1226.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1227.1-1229.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1230.1-1232.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1233.1-1235.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1238.1-1240.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1241.1-1243.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1246.1-1248.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1249.1-1251.60 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1252.1-1254.61 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1255.1-1257.60 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1258.1-1260.61 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1263.1-1265.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1266.1-1268.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1269.1-1271.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1272.1-1274.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1275.1-1277.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1278.1-1280.61 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1281.1-1283.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1286.1-1288.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1289.1-1291.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1292.1-1294.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1295.1-1297.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1298.1-1300.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1301.1-1303.61 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1304.1-1306.58 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1307.1-1309.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1310.1-1312.62 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1319.1-1321.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1322.1-1324.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1325.1-1327.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1328.1-1330.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1331.1-1333.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1334.1-1336.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1337.1-1339.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1342.1-1344.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1345.1-1347.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1348.1-1350.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1351.1-1353.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1354.1-1356.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1359.1-1361.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1362.1-1364.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1365.1-1367.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1368.1-1370.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1371.1-1373.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1374.1-1376.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1377.1-1379.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1382.1-1384.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1385.1-1387.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1390.1-1392.58 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1393.1-1395.60 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1396.1-1398.61 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1399.1-1401.60 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1402.1-1404.60 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1407.1-1409.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1410.1-1412.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1413.1-1415.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1416.1-1418.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1419.1-1421.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1422.1-1424.61 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1425.1-1427.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1430.1-1432.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1433.1-1435.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1436.1-1438.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1439.1-1441.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1442.1-1444.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1445.1-1447.59 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1448.1-1450.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1451.1-1453.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1454.1-1456.62 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1733.1-1733.41 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1734.1-1734.41 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1735.1-1735.41 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1736.1-1736.41 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1739.1-1739.39 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1740.1-1740.39 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1741.1-1741.39 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1742.1-1742.39 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast:1743.1-1743.36 (Failure("Invalid virelop: LTS"))
- 90/435 (20.69%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:10.1-12.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:13.1-15.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:16.1-18.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:19.1-21.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:22.1-24.75 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:25.1-27.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:28.1-30.103 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:31.1-33.103 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:34.1-36.103 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:37.1-39.103 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:40.1-42.103 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:43.1-45.87 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:46.1-48.87 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:49.1-51.91 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:52.1-54.87 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:55.1-57.87 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:58.1-60.87 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:61.1-63.107 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:64.1-66.107 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:67.1-69.107 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:70.1-72.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:73.1-75.75 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:76.1-78.71 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:79.1-81.91 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:82.1-84.87 (Failure("Algorithm not found: VDOT"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast:85.1-87.71 (Failure("Algorithm not found: VDOT"))
- 1/27 (3.70%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:11.1-12.83 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:13.1-14.83 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:15.1-16.87 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:17.1-18.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:19.1-20.103 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:21.1-22.103 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:23.1-24.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:25.1-26.87 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:29.1-30.83 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:31.1-32.83 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:33.1-34.103 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:35.1-36.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:37.1-38.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:39.1-40.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:41.1-42.99 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast:43.1-44.103 (Failure("Algorithm not found: VEXTADD_PAIRWISE"))
- 1/17 (5.88%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:13.1-15.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:16.1-18.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:19.1-21.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:22.1-24.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:25.1-27.82 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:28.1-30.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:31.1-33.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:34.1-36.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:37.1-39.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:40.1-42.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:43.1-45.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:46.1-48.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:49.1-51.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:52.1-54.98 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:55.1-57.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:58.1-60.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:61.1-63.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:64.1-66.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:67.1-69.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:70.1-72.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:73.1-75.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:76.1-78.82 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:79.1-81.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:82.1-84.98 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:85.1-87.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:88.1-90.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:93.1-95.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:96.1-98.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:99.1-101.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:102.1-104.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:105.1-107.83 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:108.1-110.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:111.1-113.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:114.1-116.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:117.1-119.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:120.1-122.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:123.1-125.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:126.1-128.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:129.1-131.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:132.1-134.99 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:135.1-137.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:138.1-140.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:141.1-143.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:144.1-146.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:147.1-149.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:150.1-152.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:153.1-155.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:156.1-158.83 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:159.1-161.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:162.1-164.99 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:165.1-167.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:168.1-170.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:173.1-175.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:176.1-178.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:179.1-181.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:182.1-184.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:185.1-187.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:188.1-190.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:191.1-193.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:194.1-196.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:197.1-199.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:200.1-202.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:203.1-205.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:206.1-208.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:209.1-211.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:212.1-214.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:215.1-217.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:218.1-220.118 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:221.1-223.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:224.1-226.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:227.1-229.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:230.1-232.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:233.1-235.78 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:236.1-238.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:239.1-241.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:242.1-244.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:245.1-247.114 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:248.1-250.102 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:253.1-255.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:256.1-258.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:259.1-261.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:262.1-264.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:265.1-267.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:268.1-270.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:271.1-273.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:274.1-276.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:277.1-279.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:280.1-282.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:283.1-285.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:286.1-288.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:289.1-291.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:292.1-294.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:295.1-297.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:298.1-300.119 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:301.1-303.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:304.1-306.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:307.1-309.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:310.1-312.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:313.1-315.79 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:316.1-318.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:319.1-321.103 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:322.1-324.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:325.1-327.115 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast:328.1-330.103 (Failure("Algorithm not found: VEXTMUL"))
- 1/105 (0.95%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f32x4.wast =====
- 103/103 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:10.1-11.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:12.1-13.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:14.1-15.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:16.1-17.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:18.1-19.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:20.1-21.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:22.1-23.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:24.1-25.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:26.1-27.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:28.1-29.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:30.1-31.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:32.1-33.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:34.1-35.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:36.1-37.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:38.1-39.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:40.1-41.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:42.1-43.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:44.1-45.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:46.1-47.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:48.1-49.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:50.1-51.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:52.1-53.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:54.1-55.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:56.1-57.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:58.1-59.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:60.1-61.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:62.1-63.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:64.1-65.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:66.1-67.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:68.1-69.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:70.1-71.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:72.1-73.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:74.1-75.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:76.1-77.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:78.1-79.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:80.1-81.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:82.1-83.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:84.1-85.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:86.1-87.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:88.1-89.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:90.1-91.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:92.1-93.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:94.1-95.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:96.1-97.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:98.1-99.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:100.1-101.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:102.1-103.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:104.1-105.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:106.1-107.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:108.1-109.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:110.1-111.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:114.1-115.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:116.1-117.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:118.1-119.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:120.1-121.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:122.1-123.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:124.1-125.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:126.1-127.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:128.1-129.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:130.1-131.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:132.1-133.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:134.1-135.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:136.1-137.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:138.1-139.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:140.1-141.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:142.1-143.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:144.1-145.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:146.1-147.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:148.1-149.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:150.1-151.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:152.1-153.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:154.1-155.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:156.1-157.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:158.1-159.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:160.1-161.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:162.1-163.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:164.1-165.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:166.1-167.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:168.1-169.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:170.1-171.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:172.1-173.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:174.1-175.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:176.1-177.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:178.1-179.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:180.1-181.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:182.1-183.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:184.1-185.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:186.1-187.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:188.1-189.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:190.1-191.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:192.1-193.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:194.1-195.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:196.1-197.100 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:198.1-199.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:200.1-201.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:202.1-203.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:204.1-205.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:206.1-207.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:208.1-209.84 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:210.1-211.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:212.1-213.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast:214.1-215.100 (Failure("Wasm value stack underflow"))
- 1/103 (0.97%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith.wast =====
- 189/189 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith2.wast =====
- 23/23 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:77.1-79.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:80.1-82.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:83.1-85.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:86.1-88.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:89.1-91.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:92.1-94.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:95.1-97.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:100.1-102.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:103.1-105.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:106.1-108.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:109.1-111.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:112.1-114.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:117.1-119.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:120.1-122.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:123.1-125.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:126.1-128.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:129.1-131.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:132.1-134.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:135.1-137.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:140.1-142.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:143.1-145.54 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:152.1-154.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:155.1-157.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:158.1-160.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:161.1-163.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:164.1-166.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:167.1-169.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:170.1-172.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:175.1-177.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:178.1-180.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:181.1-183.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:184.1-186.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:187.1-189.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:192.1-194.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:195.1-197.55 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:198.1-200.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:201.1-203.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:204.1-206.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:207.1-209.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:210.1-212.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:213.1-215.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:218.1-220.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:221.1-223.56 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:230.1-232.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:233.1-235.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:236.1-238.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:239.1-241.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:242.1-244.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:245.1-247.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:248.1-250.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:253.1-255.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:256.1-258.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:259.1-261.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:262.1-264.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:265.1-267.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:270.1-272.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:273.1-275.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:276.1-278.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:279.1-281.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:282.1-284.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:285.1-287.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:288.1-290.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:293.1-295.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:296.1-298.54 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:305.1-307.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:308.1-310.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:311.1-313.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:314.1-316.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:317.1-319.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:320.1-322.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:323.1-325.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:328.1-330.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:331.1-333.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:334.1-336.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:337.1-339.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:340.1-342.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:345.1-347.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:348.1-350.55 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:351.1-353.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:354.1-356.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:357.1-359.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:360.1-362.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:363.1-365.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:366.1-368.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:371.1-373.56 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast:374.1-376.56 (Failure("Invalid virelop: GES"))
- 17/103 (16.50%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:13.1-15.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:16.1-18.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:19.1-21.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:22.1-24.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:25.1-27.76 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:28.1-30.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:31.1-33.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:34.1-36.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:37.1-39.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:40.1-42.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:43.1-45.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:46.1-48.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:49.1-51.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:52.1-54.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:55.1-57.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:58.1-60.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:61.1-63.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:64.1-66.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:67.1-69.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:70.1-72.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:73.1-75.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:76.1-78.76 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:79.1-81.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:82.1-84.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:85.1-87.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:88.1-90.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:93.1-95.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:96.1-98.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:99.1-101.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:102.1-104.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:105.1-107.77 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:108.1-110.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:111.1-113.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:114.1-116.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:117.1-119.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:120.1-122.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:123.1-125.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:126.1-128.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:129.1-131.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:132.1-134.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:135.1-137.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:138.1-140.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:141.1-143.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:144.1-146.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:147.1-149.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:150.1-152.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:153.1-155.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:156.1-158.77 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:159.1-161.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:162.1-164.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:165.1-167.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:168.1-170.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:173.1-175.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:176.1-178.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:179.1-181.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:182.1-184.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:185.1-187.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:188.1-190.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:191.1-193.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:194.1-196.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:197.1-199.112 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:200.1-202.112 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:203.1-205.112 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:206.1-208.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:209.1-211.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:212.1-214.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:215.1-217.112 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:218.1-220.112 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:221.1-223.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:224.1-226.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:227.1-229.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:230.1-232.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:233.1-235.74 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:236.1-238.92 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:239.1-241.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:242.1-244.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:245.1-247.110 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:248.1-250.94 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:253.1-255.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:256.1-258.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:259.1-261.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:262.1-264.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:265.1-267.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:268.1-270.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:271.1-273.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:274.1-276.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:277.1-279.113 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:280.1-282.113 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:283.1-285.113 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:286.1-288.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:289.1-291.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:292.1-294.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:295.1-297.113 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:298.1-300.113 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:301.1-303.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:304.1-306.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:307.1-309.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:310.1-312.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:313.1-315.75 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:316.1-318.93 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:319.1-321.95 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:322.1-324.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:325.1-327.111 (Failure("Algorithm not found: VEXTMUL"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast:328.1-330.95 (Failure("Algorithm not found: VEXTMUL"))
- 1/105 (0.95%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith.wast =====
- 123/123 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith2.wast =====
- 186/186 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:299.1-301.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:302.1-304.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:305.1-307.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:308.1-310.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:311.1-313.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:314.1-316.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:317.1-319.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:322.1-324.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:325.1-327.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:328.1-330.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:331.1-333.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:334.1-336.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:339.1-341.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:342.1-344.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:345.1-347.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:348.1-350.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:351.1-353.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:354.1-356.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:357.1-359.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:362.1-364.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:365.1-367.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:370.1-372.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:373.1-375.90 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:376.1-378.90 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:379.1-381.89 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:382.1-384.89 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:387.1-389.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:390.1-392.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:393.1-395.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:396.1-398.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:399.1-401.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:402.1-404.86 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:405.1-407.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:410.1-412.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:413.1-415.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:416.1-418.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:419.1-421.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:422.1-424.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:425.1-427.88 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:428.1-430.82 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:437.1-439.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:440.1-442.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:443.1-445.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:446.1-448.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:449.1-451.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:452.1-454.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:455.1-457.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:460.1-462.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:463.1-465.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:466.1-468.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:469.1-471.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:472.1-474.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:477.1-479.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:480.1-482.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:483.1-485.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:486.1-488.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:489.1-491.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:492.1-494.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:495.1-497.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:500.1-502.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:503.1-505.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:508.1-510.98 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:511.1-513.90 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:514.1-516.90 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:517.1-519.89 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:520.1-522.89 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:525.1-527.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:528.1-530.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:531.1-533.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:534.1-536.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:537.1-539.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:540.1-542.84 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:543.1-545.98 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:548.1-550.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:551.1-553.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:554.1-556.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:557.1-559.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:560.1-562.82 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:563.1-565.85 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:566.1-568.98 (Failure("Invalid virelop: LTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:575.1-577.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:578.1-580.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:581.1-583.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:584.1-586.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:587.1-589.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:590.1-592.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:593.1-595.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:598.1-600.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:601.1-603.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:604.1-606.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:607.1-609.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:610.1-612.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:615.1-617.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:618.1-620.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:621.1-623.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:624.1-626.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:627.1-629.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:630.1-632.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:633.1-635.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:638.1-640.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:641.1-643.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:646.1-648.82 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:649.1-651.90 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:652.1-654.90 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:655.1-657.91 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:658.1-660.91 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:663.1-665.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:666.1-668.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:669.1-671.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:672.1-674.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:675.1-677.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:678.1-680.96 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:681.1-683.82 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:686.1-688.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:689.1-691.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:692.1-694.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:695.1-697.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:698.1-700.98 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:701.1-703.95 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:704.1-706.82 (Failure("Invalid virelop: LES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:713.1-715.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:716.1-718.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:719.1-721.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:722.1-724.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:725.1-727.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:728.1-730.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:731.1-733.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:736.1-738.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:739.1-741.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:742.1-744.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:745.1-747.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:748.1-750.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:753.1-755.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:756.1-758.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:759.1-761.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:762.1-764.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:765.1-767.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:768.1-770.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:771.1-773.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:776.1-778.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:779.1-781.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:784.1-786.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:787.1-789.90 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:790.1-792.90 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:793.1-795.91 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:796.1-798.91 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:801.1-803.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:804.1-806.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:807.1-809.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:810.1-812.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:813.1-815.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:816.1-818.94 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:819.1-821.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:824.1-826.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:827.1-829.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:830.1-832.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:833.1-835.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:836.1-838.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:839.1-841.92 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:842.1-844.98 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:851.1-853.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:854.1-856.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:857.1-859.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:860.1-862.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:863.1-865.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:866.1-868.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:869.1-871.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:874.1-876.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:877.1-879.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:880.1-882.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:883.1-885.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:886.1-888.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:891.1-893.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:894.1-896.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:897.1-899.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:900.1-902.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:903.1-905.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:906.1-908.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:909.1-911.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:914.1-916.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:917.1-919.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:922.1-924.98 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:925.1-927.90 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:928.1-930.90 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:931.1-933.89 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:934.1-936.89 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:939.1-941.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:942.1-944.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:945.1-947.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:948.1-950.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:951.1-953.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:954.1-956.84 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:957.1-959.98 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:962.1-964.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:965.1-967.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:968.1-970.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:971.1-973.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:974.1-976.82 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:977.1-979.85 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:980.1-982.98 (Failure("Invalid virelop: GTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:989.1-991.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:992.1-994.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:995.1-997.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:998.1-1000.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1001.1-1003.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1004.1-1006.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1007.1-1009.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1012.1-1014.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1015.1-1017.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1018.1-1020.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1021.1-1023.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1024.1-1026.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1029.1-1031.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1032.1-1034.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1035.1-1037.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1038.1-1040.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1041.1-1043.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1044.1-1046.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1047.1-1049.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1052.1-1054.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1055.1-1057.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1060.1-1062.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1063.1-1065.90 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1066.1-1068.90 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1069.1-1071.89 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1072.1-1074.89 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1077.1-1079.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1080.1-1082.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1083.1-1085.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1086.1-1088.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1089.1-1091.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1092.1-1094.86 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1095.1-1097.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1100.1-1102.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1103.1-1105.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1106.1-1108.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1109.1-1111.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1112.1-1114.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1115.1-1117.88 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1118.1-1120.82 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1127.1-1129.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1130.1-1132.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1133.1-1135.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1136.1-1138.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1139.1-1141.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1142.1-1144.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1145.1-1147.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1150.1-1152.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1153.1-1155.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1156.1-1158.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1159.1-1161.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1162.1-1164.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1167.1-1169.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1170.1-1172.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1173.1-1175.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1176.1-1178.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1179.1-1181.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1182.1-1184.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1185.1-1187.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1190.1-1192.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1193.1-1195.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1198.1-1200.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1201.1-1203.90 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1204.1-1206.90 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1207.1-1209.91 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1210.1-1212.91 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1215.1-1217.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1218.1-1220.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1221.1-1223.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1224.1-1226.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1227.1-1229.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1230.1-1232.94 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1233.1-1235.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1238.1-1240.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1241.1-1243.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1244.1-1246.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1247.1-1249.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1250.1-1252.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1253.1-1255.92 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1256.1-1258.98 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1265.1-1267.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1268.1-1270.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1271.1-1273.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1274.1-1276.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1277.1-1279.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1280.1-1282.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1283.1-1285.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1288.1-1290.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1291.1-1293.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1294.1-1296.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1297.1-1299.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1300.1-1302.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1305.1-1307.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1308.1-1310.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1311.1-1313.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1314.1-1316.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1317.1-1319.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1320.1-1322.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1323.1-1325.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1328.1-1330.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1331.1-1333.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1336.1-1338.82 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1339.1-1341.90 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1342.1-1344.90 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1345.1-1347.91 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1348.1-1350.91 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1353.1-1355.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1356.1-1358.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1359.1-1361.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1362.1-1364.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1365.1-1367.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1368.1-1370.96 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1371.1-1373.82 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1376.1-1378.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1379.1-1381.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1382.1-1384.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1385.1-1387.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1388.1-1390.98 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1391.1-1393.95 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1394.1-1396.82 (Failure("Invalid virelop: GEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1673.1-1673.41 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1674.1-1674.41 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1675.1-1675.41 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1676.1-1676.41 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1679.1-1679.39 (Failure("Invalid virelop: LTS"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1680.1-1680.39 (Failure("Invalid virelop: LEU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1681.1-1681.39 (Failure("Invalid virelop: GTU"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1682.1-1682.39 (Failure("Invalid virelop: GES"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast:1683.1-1683.36 (Failure("Invalid virelop: LTS"))
- 86/415 (20.72%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_sat_arith.wast =====
- 190/190 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:18.1-19.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:20.1-21.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:22.1-23.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:24.1-25.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:26.1-27.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:28.1-29.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:30.1-31.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:32.1-33.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:34.1-35.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:36.1-37.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:38.1-39.111 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:40.1-41.111 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:42.1-43.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:44.1-45.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:46.1-47.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:48.1-49.111 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:50.1-51.111 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:52.1-53.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:54.1-55.111 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:57.1-58.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:59.1-60.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:61.1-62.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:63.1-64.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:65.1-66.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:67.1-68.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:69.1-70.87 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:71.1-72.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:73.1-74.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:75.1-76.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:77.1-78.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:79.1-80.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:81.1-82.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:83.1-84.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:85.1-86.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:87.1-88.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:89.1-90.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:91.1-92.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:93.1-94.103 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:96.1-97.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:98.1-99.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:100.1-101.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:102.1-103.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:104.1-105.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:106.1-107.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:108.1-109.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:110.1-111.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:112.1-113.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:114.1-115.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:116.1-117.110 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:118.1-119.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:120.1-121.110 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:122.1-123.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:124.1-125.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:126.1-127.110 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:128.1-129.110 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:130.1-131.110 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:132.1-133.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:135.1-136.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:137.1-138.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:139.1-140.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:141.1-142.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:143.1-144.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:145.1-146.86 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:147.1-148.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:149.1-150.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:151.1-152.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:153.1-154.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:155.1-156.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:157.1-158.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:159.1-160.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:161.1-162.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:163.1-164.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:165.1-166.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:167.1-168.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:169.1-170.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:171.1-172.102 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:174.1-175.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:176.1-177.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:178.1-179.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:180.1-181.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:182.1-183.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:184.1-185.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:186.1-187.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:188.1-189.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:190.1-191.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:192.1-193.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:194.1-195.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:196.1-197.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:198.1-199.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:200.1-201.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:202.1-203.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:204.1-205.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:206.1-207.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:208.1-209.83 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:210.1-211.99 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:213.1-214.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:215.1-216.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:217.1-218.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:219.1-220.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:221.1-222.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:223.1-224.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:225.1-226.79 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:227.1-228.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:229.1-230.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:231.1-232.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:233.1-234.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:235.1-236.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:237.1-238.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:239.1-240.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:241.1-242.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:243.1-244.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:245.1-246.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:247.1-248.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:249.1-250.95 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:252.1-253.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:254.1-255.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:256.1-257.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:258.1-259.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:260.1-261.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:262.1-263.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:264.1-265.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:266.1-267.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:268.1-269.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:270.1-271.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:272.1-273.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:274.1-275.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:276.1-277.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:278.1-279.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:280.1-281.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:282.1-283.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:284.1-285.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:286.1-287.98 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:288.1-289.82 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:291.1-292.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:293.1-294.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:295.1-296.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:297.1-298.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:299.1-300.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:301.1-302.78 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:303.1-304.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:305.1-306.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:307.1-308.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:309.1-310.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:311.1-312.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:313.1-314.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:315.1-316.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:317.1-318.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:319.1-320.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:321.1-322.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:323.1-324.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:325.1-326.94 (Failure("Wasm value stack underflow"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast:327.1-328.94 (Failure("Wasm value stack underflow"))
- 77/229 (33.62%)

===== ../../test-interpreter/spec-test-3/simd/simd_lane.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:292.1-295.70 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:296.1-299.77 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:300.1-303.86 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:304.1-307.86 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:308.1-311.86 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:312.1-315.102 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:316.1-319.78 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:320.1-323.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:324.1-327.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:328.1-331.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:333.1-336.60 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:337.1-340.77 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:341.1-344.84 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:345.1-348.77 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:349.1-352.77 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:353.1-356.86 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:357.1-360.86 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:361.1-364.102 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:365.1-368.78 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:369.1-372.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:373.1-376.60 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:377.1-380.66 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:381.1-384.60 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:387.1-390.70 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:391.1-394.70 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:692.1-695.60 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:696.1-699.102 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:769.1-774.70 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:775.1-780.68 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:787.1-789.75 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:790.1-792.75 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:793.1-795.75 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:863.1-866.77 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_lane.wast:867.1-870.69 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:591.50-591.53"))
- 252/286 (88.11%)

===== ../../test-interpreter/spec-test-3/simd/simd_linking.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load.wast:44.1-44.67 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load.wast:127.1-127.134 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- 29/31 (93.55%)

===== ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:105.1-107.82 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:108.1-110.82 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:111.1-113.82 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:114.1-116.83 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:117.1-119.83 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:120.1-122.83 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:123.1-125.83 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:126.1-128.83 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:129.1-130.91 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:131.1-132.91 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:133.1-134.91 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:135.1-136.92 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:137.1-138.92 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:139.1-140.92 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:141.1-142.92 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:143.1-144.92 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:145.1-147.90 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:148.1-150.90 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:151.1-153.90 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:154.1-156.90 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:157.1-159.90 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:160.1-162.90 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:163.1-165.91 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:166.1-168.91 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:169.1-171.91 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:172.1-174.91 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:175.1-177.91 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:178.1-180.91 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:181.1-183.91 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:184.1-186.91 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:187.1-189.91 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast:190.1-192.91 (Not_found)
- 1/33 (3.03%)

===== ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:69.1-71.79 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:72.1-74.79 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:75.1-77.79 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:78.1-80.80 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:81.1-82.88 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:83.1-84.88 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:85.1-86.88 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:87.1-88.89 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:89.1-91.87 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:92.1-94.87 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:95.1-97.87 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:98.1-100.87 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:101.1-103.87 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:104.1-106.87 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:107.1-109.87 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:110.1-112.87 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:113.1-115.87 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:116.1-118.88 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:119.1-121.88 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast:122.1-124.88 (Not_found)
- 1/21 (4.76%)

===== ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast:45.1-47.85 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast:48.1-50.85 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast:51.1-52.94 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast:53.1-54.94 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast:55.1-57.93 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast:58.1-60.93 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast:61.1-63.93 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast:64.1-66.93 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast:67.1-69.93 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast:70.1-72.93 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast:73.1-75.93 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast:76.1-78.93 (Not_found)
- 1/13 (7.69%)

===== ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:153.1-155.95 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:156.1-158.95 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:159.1-161.95 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:162.1-164.95 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:165.1-167.95 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:168.1-170.95 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:171.1-173.95 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:174.1-176.95 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:177.1-179.95 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:180.1-182.95 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:183.1-185.97 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:186.1-188.97 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:189.1-191.97 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:192.1-194.97 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:195.1-197.97 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:198.1-200.97 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:201.1-202.104 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:203.1-204.104 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:205.1-206.104 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:207.1-208.104 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:209.1-210.104 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:211.1-212.104 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:213.1-214.104 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:215.1-216.104 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:217.1-218.104 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:219.1-220.104 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:221.1-222.107 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:223.1-224.107 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:225.1-226.107 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:227.1-228.107 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:229.1-230.107 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:231.1-232.107 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:233.1-235.103 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:236.1-238.103 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:239.1-241.103 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:242.1-244.103 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:245.1-247.103 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:248.1-250.103 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:251.1-253.103 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:254.1-256.103 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:257.1-259.103 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:260.1-262.103 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:263.1-265.105 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:266.1-268.105 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:269.1-271.105 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:272.1-274.105 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:275.1-277.105 (Not_found)
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast:278.1-280.105 (Not_found)
- 1/49 (2.04%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:163.1-163.131 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:164.1-164.131 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:165.1-165.120 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:166.1-166.120 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:167.1-167.114 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:168.1-168.114 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:169.1-169.132 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:170.1-170.132 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:171.1-171.121 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:172.1-172.121 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:173.1-173.115 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:174.1-174.115 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:175.1-175.132 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:176.1-176.132 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:177.1-177.121 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:178.1-178.121 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:179.1-179.115 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:180.1-180.115 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:183.1-183.124 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:184.1-184.124 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:185.1-185.114 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:186.1-186.114 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:187.1-187.111 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:188.1-188.111 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:192.1-192.139 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:193.1-193.138 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:194.1-194.146 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:195.1-195.147 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:196.1-196.147 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:197.1-197.139 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:198.1-198.138 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:199.1-199.146 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:200.1-200.147 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:201.1-201.147 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:203.1-203.128 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:204.1-204.127 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:205.1-205.135 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:206.1-206.136 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:207.1-207.136 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:208.1-208.128 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:209.1-209.127 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:210.1-210.135 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:211.1-211.136 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:212.1-212.136 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:214.1-214.122 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:215.1-215.121 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:216.1-216.129 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:217.1-217.130 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:218.1-218.130 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:219.1-219.122 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:220.1-220.121 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:221.1-221.129 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:222.1-222.130 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:223.1-223.130 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:367.1-367.126 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:368.1-368.126 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:369.1-369.115 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:370.1-370.115 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:371.1-371.109 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:372.1-372.109 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:373.1-373.129 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:374.1-374.129 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:375.1-375.118 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:376.1-376.118 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:377.1-377.112 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:378.1-378.112 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:379.1-379.80 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:380.1-380.80 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:381.1-381.81 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:382.1-382.81 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:383.1-383.83 (Failure("Invalid DSL function call: inverse_of_size"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast:384.1-384.83 (Failure("Invalid DSL function call: inverse_of_size"))
- 14/86 (16.28%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast =====
Result: 2_303 0 515_336_000 21_920 : [v128]
Expect: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:43.1-43.109 (Error(_, "wrong return values"))
Result: 3_072 0 -671_020_784 32_753 : [v128]
Expect: 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:44.1-44.109 (Error(_, "wrong return values"))
Result: 209 0 21_431 0 : [v128]
Expect: 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:45.1-45.109 (Error(_, "wrong return values"))
Result: 515_336_000 21_920 -1 268_435_455 : [v128]
Expect: 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:46.1-46.109 (Error(_, "wrong return values"))
Result: -671_306_848 32_753 589 0 : [v128]
Expect: 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:47.1-47.129 (Error(_, "wrong return values"))
Result: -671_402_856 32_753 591 0 : [v128]
Expect: 1_284 1_284 1_284 1_284 1_284 1_284 1_284 1_284 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:48.1-48.134 (Error(_, "wrong return values"))
Result: -671_483_024 32_753 1_276 0 : [v128]
Expect: 1_541 1_541 1_541 1_541 1_541 1_541 1_541 1_541 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:49.1-49.134 (Error(_, "wrong return values"))
Result: 0 0 -762_666_544 32_753 : [v128]
Expect: 1_798 1_798 1_798 1_798 1_798 1_798 1_798 1_798 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:50.1-50.134 (Error(_, "wrong return values"))
Result: 515_336_064 21_920 20_544 0 : [v128]
Expect: 2_055 2_055 2_055 2_055 2_055 2_055 2_055 2_055 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:51.1-51.134 (Error(_, "wrong return values"))
Result: 2_303 0 515_336_064 21_920 : [v128]
Expect: 7_966 7_966 7_966 7_966 7_966 7_966 7_966 7_966 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:52.1-52.138 (Error(_, "wrong return values"))
Result: 4_096 0 -672_655_632 32_753 : [v128]
Expect: 185_207_048 185_207_048 185_207_048 185_207_048 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:53.1-53.122 (Error(_, "wrong return values"))
Result: 0 0 -762_806_152 32_753 : [v128]
Expect: 202_050_057 202_050_057 202_050_057 202_050_057 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:54.1-54.122 (Error(_, "wrong return values"))
Result: 2_048 0 -671_947_376 32_753 : [v128]
Expect: 218_893_066 218_893_066 218_893_066 218_893_066 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:55.1-55.123 (Error(_, "wrong return values"))
Result: 1_952_805_734 859_125_046 51 67_108_864 : [v128]
Expect: 235_736_075 235_736_075 235_736_075 235_736_075 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:56.1-56.123 (Error(_, "wrong return values"))
Result: 3_072 0 -671_834_512 32_753 : [v128]
Expect: 522_067_228 522_067_228 522_067_228 522_067_228 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:57.1-57.126 (Error(_, "wrong return values"))
Result: 4_096 0 -671_834_512 32_753 : [v128]
Expect: 252_579_084 252_579_084 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:58.1-58.117 (Error(_, "wrong return values"))
Result: 515_336_000 21_920 4_095 0 : [v128]
Expect: 986_637 986_637 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:59.1-59.117 (Error(_, "wrong return values"))
Result: 4_096 0 -671_834_512 32_753 : [v128]
Expect: 3_854 3_854 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:60.1-60.117 (Error(_, "wrong return values"))
Result: 3 0 5_120 0 : [v128]
Expect: 15 15 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:61.1-61.117 (Error(_, "wrong return values"))
Result: 515_670_576 21_920 2_048 0 : [v128]
Expect: 2_242_261_671_028_070_680 2_242_261_671_028_070_680 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:62.1-62.120 (Error(_, "wrong return values"))
Result: -670_438_216 32_753 2_048 0 : [v128]
Expect: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:65.1-65.106 (Error(_, "wrong return values"))
Result: 515_443_048 21_920 -670_275_152 32_753 : [v128]
Expect: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:66.1-66.105 (Error(_, "wrong return values"))
Result: -670_629_872 32_753 2_048 0 : [v128]
Expect: 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:67.1-67.113 (Error(_, "wrong return values"))
Result: -670_725_896 32_753 -670_718_776 32_753 : [v128]
Expect: 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:68.1-68.113 (Error(_, "wrong return values"))
Result: 4_343 0 511_446_480 21_920 : [v128]
Expect: 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:69.1-69.130 (Error(_, "wrong return values"))
Result: -679_057_576 32_753 -846_448_152 32_753 : [v128]
Expect: 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:70.1-70.106 (Error(_, "wrong return values"))
Result: -671_013_288 32_753 1 0 : [v128]
Expect: 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:71.1-71.105 (Error(_, "wrong return values"))
Result: 515_670_576 21_920 2_048 0 : [v128]
Expect: 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:72.1-72.113 (Error(_, "wrong return values"))
Result: 3_072 0 -679_057_576 32_753 : [v128]
Expect: 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:73.1-73.113 (Error(_, "wrong return values"))
Result: -671_300_368 32_753 515_670_576 21_920 : [v128]
Expect: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:74.1-74.114 (Error(_, "wrong return values"))
Result: 2_048 0 -671_397_040 32_753 : [v128]
Expect: 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:75.1-75.126 (Error(_, "wrong return values"))
Result: 2_048 0 -671_492_136 32_753 : [v128]
Expect: 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:76.1-76.125 (Error(_, "wrong return values"))
Result: -671_587_552 32_753 2_048 0 : [v128]
Expect: 256 256 256 256 256 256 256 256 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:78.1-78.130 (Error(_, "wrong return values"))
Result: -671_666_992 32_753 515_670_576 21_920 : [v128]
Expect: 256 256 256 256 256 256 256 256 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:79.1-79.129 (Error(_, "wrong return values"))
Result: 1_024 0 -671_746_096 32_753 : [v128]
Expect: 513 513 513 513 513 513 513 513 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:80.1-80.137 (Error(_, "wrong return values"))
Result: 1 0 2_048 0 : [v128]
Expect: 770 770 770 770 770 770 770 770 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:81.1-81.137 (Error(_, "wrong return values"))
Result: -671_904_248 32_753 2_053 0 : [v128]
Expect: 15 15 15 15 15 15 15 15 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:82.1-82.138 (Error(_, "wrong return values"))
Result: 2_048 0 -671_982_912 32_753 : [v128]
Expect: 513 513 513 513 513 513 513 513 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:83.1-83.130 (Error(_, "wrong return values"))
Result: -672_468_504 32_753 -672_061_600 32_753 : [v128]
Expect: 513 513 513 513 513 513 513 513 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:84.1-84.129 (Error(_, "wrong return values"))
Result: 511_446_480 21_920 5 16_777_216 : [v128]
Expect: 770 770 770 770 770 770 770 770 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:85.1-85.137 (Error(_, "wrong return values"))
Result: -762_388_512 32_753 -672_219_752 32_753 : [v128]
Expect: 1_027 1_027 1_027 1_027 1_027 1_027 1_027 1_027 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:86.1-86.137 (Error(_, "wrong return values"))
Result: 515_707_800 21_920 -672_298_872 32_753 : [v128]
Expect: 0 0 0 0 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:87.1-87.138 (Error(_, "wrong return values"))
Result: 1 0 4_343 0 : [v128]
Expect: 7_966 7_966 7_966 7_966 7_966 7_966 7_966 7_966 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:88.1-88.134 (Error(_, "wrong return values"))
Result: 515_522_248 21_920 2_048 0 : [v128]
Expect: 7_966 7_966 7_966 7_966 7_966 7_966 7_966 7_966 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:89.1-89.133 (Error(_, "wrong return values"))
Result: -679_005_520 32_753 -846_430_584 32_753 : [v128]
Expect: 50_462_976 50_462_976 50_462_976 50_462_976 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:91.1-91.118 (Error(_, "wrong return values"))
Result: 1 0 3_072 0 : [v128]
Expect: 50_462_976 50_462_976 50_462_976 50_462_976 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:92.1-92.117 (Error(_, "wrong return values"))
Result: 2_048 0 -670_586_584 32_753 : [v128]
Expect: 67_305_985 67_305_985 67_305_985 67_305_985 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:93.1-93.125 (Error(_, "wrong return values"))
Result: 540_090_417 540_090_417 540_090_417 540_090_417 : [v128]
Expect: 84_148_994 84_148_994 84_148_994 84_148_994 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:94.1-94.125 (Error(_, "wrong return values"))
Result: 127 0 3_324 0 : [v128]
Expect: 15 15 15 15 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:95.1-95.126 (Error(_, "wrong return values"))
Result: -672_468_504 32_753 -670_806_744 32_753 : [v128]
Expect: 67_305_985 67_305_985 67_305_985 67_305_985 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:96.1-96.118 (Error(_, "wrong return values"))
Result: -675_112_032 32_753 -846_434_928 32_753 : [v128]
Expect: 67_305_985 67_305_985 67_305_985 67_305_985 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:97.1-97.117 (Error(_, "wrong return values"))
Result: 515_670_576 21_920 2_048 0 : [v128]
Expect: 84_148_994 84_148_994 84_148_994 84_148_994 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:98.1-98.125 (Error(_, "wrong return values"))
Result: -671_013_288 32_753 1 0 : [v128]
Expect: 100_992_003 100_992_003 100_992_003 100_992_003 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:99.1-99.125 (Error(_, "wrong return values"))
Result: 3 0 1_024 0 : [v128]
Expect: 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:100.1-100.126 (Error(_, "wrong return values"))
Result: 1 0 5 0 : [v128]
Expect: 522_067_228 522_067_228 522_067_228 522_067_228 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:101.1-101.122 (Error(_, "wrong return values"))
Result: -671_252_680 32_753 2_048 0 : [v128]
Expect: 522_067_228 522_067_228 522_067_228 522_067_228 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:102.1-102.121 (Error(_, "wrong return values"))
Result: 1_276 0 962_539_826 16_789_554 : [v128]
Expect: 506_097_522_914_230_528 506_097_522_914_230_528 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:104.1-104.112 (Error(_, "wrong return values"))
Result: -671_403_016 32_753 -671_402_992 32_753 : [v128]
Expect: 506_097_522_914_230_528 506_097_522_914_230_528 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:105.1-105.111 (Error(_, "wrong return values"))
Result: 515_670_672 21_920 -672_539_256 32_753 : [v128]
Expect: 578_437_695_752_307_201 578_437_695_752_307_201 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:106.1-106.119 (Error(_, "wrong return values"))
Result: -671_549_560 32_753 -671_549_072 32_753 : [v128]
Expect: 650_777_868_590_383_874 650_777_868_590_383_874 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:107.1-107.119 (Error(_, "wrong return values"))
Result: -675_204_144 32_753 -846_441_840 32_753 : [v128]
Expect: 15 15 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:108.1-108.120 (Error(_, "wrong return values"))
Result: 515_524_712 21_920 -672_468_504 32_753 : [v128]
Expect: 578_437_695_752_307_201 578_437_695_752_307_201 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:109.1-109.112 (Error(_, "wrong return values"))
Result: 1 0 3 0 : [v128]
Expect: 578_437_695_752_307_201 578_437_695_752_307_201 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:110.1-110.111 (Error(_, "wrong return values"))
Result: -762_434_312 32_753 16_636 0 : [v128]
Expect: 650_777_868_590_383_874 650_777_868_590_383_874 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:111.1-111.119 (Error(_, "wrong return values"))
Result: 2_303 0 515_336_064 21_920 : [v128]
Expect: 723_118_041_428_460_547 723_118_041_428_460_547 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:112.1-112.119 (Error(_, "wrong return values"))
Result: 1 0 3_072 0 : [v128]
Expect: 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:113.1-113.120 (Error(_, "wrong return values"))
Result: 517_364_504 21_920 4_343 0 : [v128]
Expect: 2_242_261_671_028_070_680 2_242_261_671_028_070_680 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:114.1-114.116 (Error(_, "wrong return values"))
Result: 3_072 0 -679_057_576 32_753 : [v128]
Expect: 2_242_261_671_028_070_680 2_242_261_671_028_070_680 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:115.1-115.115 (Error(_, "wrong return values"))
Result: 515_524_240 21_920 3_072 0 : [v128]
Expect: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:198.1-198.104 (Error(_, "wrong return values"))
Result: 1 0 -674_907_800 32_753 : [v128]
Expect: 513 513 513 513 513 513 513 513 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:199.1-199.129 (Error(_, "wrong return values"))
Result: -674_916_008 32_753 -670_726_776 32_753 : [v128]
Expect: 84_148_994 84_148_994 84_148_994 84_148_994 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:200.1-200.117 (Error(_, "wrong return values"))
Result: -670_807_952 32_753 515_670_576 21_920 : [v128]
Expect: 2_569 2_569 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:201.1-201.111 (Error(_, "wrong return values"))
Result: -670_881_440 32_753 1 0 : [v128]
Expect: 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:202.1-202.107 (Error(_, "wrong return values"))
Result: 515_706_328 21_920 -762_415_976 32_753 : [v128]
Expect: 1_284 1_284 1_284 1_284 1_284 1_284 1_284 1_284 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:203.1-203.132 (Error(_, "wrong return values"))
Result: -672_468_504 32_753 -671_062_064 32_753 : [v128]
Expect: 134_678_021 134_678_021 134_678_021 134_678_021 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:204.1-204.120 (Error(_, "wrong return values"))
Result: -674_907_592 32_753 -671_139_408 32_753 : [v128]
Expect: 10 10 : [v128]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:205.1-205.114 (Error(_, "wrong return values"))
Result: 1 : [i32]
Expect: 6 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:206.1-206.81 (Error(_, "wrong return values"))
Result: -64 : [i32]
Expect: 7 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:207.1-207.82 (Error(_, "wrong return values"))
Result: 16 : [i32]
Expect: 8 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:208.1-208.82 (Error(_, "wrong return values"))
Result: 1 : [i32]
Expect: 0 : [i32]
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast:209.1-209.82 (Error(_, "wrong return values"))
- 34/114 (29.82%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_zero.wast =====
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_splat.wast =====
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_splat.wast:300.1-300.133 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:583.50-583.53"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_splat.wast:325.1-325.81 (Failure("Invalid assignment on value I8: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_splat.wast:326.1-326.86 (Failure("Invalid assignment on value I16: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_splat.wast:327.1-327.91 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- Test failed at ../../test-interpreter/spec-test-3/simd/simd_splat.wast:328.1-328.83 (Failure("Invalid assignment on value I32: SubE (inn,inn) @8-reduction.watsup:648.29-648.32"))
- 157/162 (96.91%)

===== ../../test-interpreter/spec-test-3/simd/simd_store.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store16_lane.wast =====
- 33/33 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store32_lane.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store64_lane.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store8_lane.wast =====
- 49/49 (100.00%)

===== ../../test-interpreter/spec-test-3/skip-stack-guard-page.wast =====
- 1/1 (100.00%)

===== ../../test-interpreter/spec-test-3/stack.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-3/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/store.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-3/switch.wast =====
- 27/27 (100.00%)

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
- 43/43 (100.00%)

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
- 36/36 (100.00%)

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

Total [43373/45764] (94.78%)

== Complete.
```
