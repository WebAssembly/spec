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
== Running pass animate...
== IL Validation after pass animate...
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
== Running pass animate...
== IL Validation after pass animate...
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
> ) done 2>&1
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
- 261/261 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_const.wast =====
- 577/577 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_conversions.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:35.1-36.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:37.1-38.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:39.1-40.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:41.1-42.89 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:43.1-44.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:45.1-46.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:47.1-48.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:49.1-50.101 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:52.1-53.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:55.1-56.115 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:57.1-58.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:59.1-60.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:61.1-62.97 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:63.1-64.99 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:65.1-66.97 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:67.1-68.99 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(F32, []), NumV (4)), CaseV(PROMOTE, []), OptV (CaseV(LOW, [])), OptV, OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:73.1-74.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:75.1-76.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:77.1-78.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:79.1-80.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:81.1-82.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:83.1-84.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:85.1-86.91 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:87.1-88.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:89.1-90.105 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:91.1-92.107 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:93.1-94.91 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:95.1-96.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:97.1-98.105 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:99.1-100.107 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:101.1-102.105 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:103.1-104.107 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:105.1-106.105 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:107.1-108.107 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:109.1-110.105 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:111.1-112.107 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:113.1-114.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:115.1-116.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:117.1-118.91 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:119.1-120.105 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:121.1-122.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:123.1-124.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:125.1-126.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:127.1-128.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:129.1-130.101 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:131.1-132.101 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:133.1-134.101 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:135.1-136.101 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:137.1-138.101 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:139.1-140.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:141.1-142.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:143.1-144.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:145.1-146.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:147.1-148.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:149.1-150.105 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:151.1-152.105 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:153.1-154.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:155.1-156.107 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:157.1-158.101 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:159.1-160.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:161.1-162.101 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:163.1-164.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:165.1-166.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:167.1-168.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:169.1-170.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:171.1-172.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:173.1-174.91 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:175.1-176.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(DEMOTE, []), OptV, OptV, OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:182.1-183.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:184.1-185.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:186.1-187.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:188.1-189.119 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:190.1-191.123 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:192.1-193.127 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:194.1-195.115 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:196.1-197.115 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:200.1-201.111 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:202.1-203.115 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:204.1-205.111 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:206.1-207.115 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:208.1-209.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:213.1-214.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:215.1-216.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:217.1-218.119 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:219.1-220.119 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:221.1-222.119 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:223.1-224.127 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:225.1-226.127 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:227.1-228.127 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:229.1-230.127 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:231.1-232.127 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:233.1-234.127 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:235.1-236.127 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:237.1-238.115 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:239.1-240.119 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:243.1-244.111 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:245.1-246.111 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:247.1-248.110 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:253.1-254.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:255.1-256.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:257.1-258.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:259.1-260.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:261.1-262.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:263.1-264.91 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:269.1-270.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:271.1-272.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:273.1-274.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:275.1-276.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:277.1-278.97 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(F64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:758.1-760.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:761.1-763.88 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:764.1-766.88 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:768.1-770.124 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:771.1-773.98 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:774.1-776.125 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:777.1-779.99 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:780.1-782.88 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:783.1-785.112 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:786.1-788.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:789.1-791.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:793.1-795.108 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:796.1-798.89 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:799.1-801.109 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:802.1-804.90 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:805.1-807.85 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:808.1-810.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:811.1-813.86 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_conversions.wast:814.1-816.101 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- 106/234 (45.30%)

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
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:10.1-11.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:12.1-13.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:14.1-15.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:16.1-17.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:18.1-19.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:20.1-21.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:22.1-23.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:24.1-25.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:26.1-27.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:28.1-29.117 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:30.1-31.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:32.1-33.117 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:34.1-35.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:36.1-37.117 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:38.1-39.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:40.1-41.117 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:42.1-43.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:44.1-45.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:46.1-47.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:48.1-49.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:50.1-51.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:52.1-53.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:54.1-55.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:56.1-57.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:58.1-59.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:60.1-61.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:62.1-63.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:64.1-65.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:66.1-67.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:68.1-69.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:70.1-71.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:72.1-73.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:74.1-75.117 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:76.1-77.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:78.1-79.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:80.1-81.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:82.1-83.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:84.1-85.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:86.1-87.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:88.1-89.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:90.1-91.117 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:92.1-93.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:94.1-95.117 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:96.1-97.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:98.1-99.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:100.1-101.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:102.1-103.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:104.1-105.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:106.1-107.85 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:108.1-109.109 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:110.1-111.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:114.1-115.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:116.1-117.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:118.1-119.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:120.1-121.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:122.1-123.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:124.1-125.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:126.1-127.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:128.1-129.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:130.1-131.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:132.1-133.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:134.1-135.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:136.1-137.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:138.1-139.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:140.1-141.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:142.1-143.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:144.1-145.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:146.1-147.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:148.1-149.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:150.1-151.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:152.1-153.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:154.1-155.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:156.1-157.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:158.1-159.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:160.1-161.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:162.1-163.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:164.1-165.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:166.1-167.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:168.1-169.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:170.1-171.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:172.1-173.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:174.1-175.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:176.1-177.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:178.1-179.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:180.1-181.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:182.1-183.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:184.1-185.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:186.1-187.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:188.1-189.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:190.1-191.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:192.1-193.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:194.1-195.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:196.1-197.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:198.1-199.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:200.1-201.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:202.1-203.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:204.1-205.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:206.1-207.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:208.1-209.81 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:210.1-211.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:212.1-213.109 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f32x4.wast:214.1-215.113 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
- 1/103 (0.97%)

===== ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:10.1-11.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:12.1-13.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:14.1-15.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:16.1-17.84 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:18.1-19.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:20.1-21.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:22.1-23.84 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:24.1-25.84 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:26.1-27.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:28.1-29.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:30.1-31.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:32.1-33.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:34.1-35.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:36.1-37.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:38.1-39.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:40.1-41.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:42.1-43.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:44.1-45.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:46.1-47.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:48.1-49.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:50.1-51.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:52.1-53.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:54.1-55.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:56.1-57.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:58.1-59.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:60.1-61.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:62.1-63.84 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:64.1-65.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:66.1-67.84 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:68.1-69.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:70.1-71.84 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:72.1-73.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:74.1-75.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:76.1-77.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:78.1-79.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:80.1-81.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:82.1-83.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:84.1-85.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:86.1-87.84 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:88.1-89.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:90.1-91.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:92.1-93.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:94.1-95.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:96.1-97.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:98.1-99.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:100.1-101.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:102.1-103.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:104.1-105.84 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:106.1-107.86 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:108.1-109.98 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:110.1-111.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:114.1-115.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:116.1-117.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:118.1-119.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:120.1-121.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:122.1-123.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:124.1-125.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:126.1-127.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:128.1-129.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:130.1-131.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:132.1-133.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:134.1-135.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:136.1-137.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:138.1-139.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:140.1-141.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:142.1-143.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:144.1-145.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:146.1-147.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:148.1-149.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:150.1-151.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:152.1-153.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:154.1-155.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:156.1-157.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:158.1-159.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:160.1-161.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:162.1-163.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:164.1-165.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:166.1-167.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:168.1-169.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:170.1-171.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:172.1-173.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:174.1-175.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:176.1-177.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:178.1-179.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:180.1-181.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:182.1-183.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:184.1-185.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:186.1-187.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:188.1-189.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:190.1-191.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:192.1-193.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:194.1-195.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:196.1-197.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:198.1-199.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:200.1-201.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:202.1-203.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:204.1-205.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:206.1-207.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:208.1-209.84 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:210.1-211.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:212.1-213.98 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_i32x4_trunc_sat_f64x2.wast:214.1-215.100 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F64, []), NumV (2)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(U, [])), OptV (CaseV(ZERO, []))]))"))
- 1/103 (0.97%)

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
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:18.1-19.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:20.1-21.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:22.1-23.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:24.1-25.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:26.1-27.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:28.1-29.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:30.1-31.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:32.1-33.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:34.1-35.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:36.1-37.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:38.1-39.111 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:40.1-41.111 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:42.1-43.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:44.1-45.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:46.1-47.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:48.1-49.111 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:50.1-51.111 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:52.1-53.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:54.1-55.111 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:57.1-58.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:59.1-60.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:61.1-62.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:63.1-64.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:65.1-66.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:67.1-68.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:69.1-70.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:71.1-72.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:73.1-74.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:75.1-76.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:77.1-78.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:79.1-80.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:81.1-82.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:83.1-84.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:85.1-86.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:87.1-88.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:89.1-90.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:91.1-92.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:93.1-94.103 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:96.1-97.86 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:98.1-99.86 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:100.1-101.86 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:102.1-103.86 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:104.1-105.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:106.1-107.86 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:108.1-109.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:110.1-111.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:112.1-113.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:114.1-115.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:116.1-117.110 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:118.1-119.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:120.1-121.110 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:122.1-123.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:124.1-125.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:126.1-127.110 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:128.1-129.110 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:130.1-131.110 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:132.1-133.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:135.1-136.86 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:137.1-138.86 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:139.1-140.86 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:141.1-142.86 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:143.1-144.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:145.1-146.86 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:147.1-148.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:149.1-150.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:151.1-152.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:153.1-154.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:155.1-156.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:157.1-158.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:159.1-160.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:161.1-162.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:163.1-164.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:165.1-166.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:167.1-168.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:169.1-170.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:171.1-172.102 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I16, []), NumV (8)), TupV (CaseV(I8, []), NumV (16)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:174.1-175.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:176.1-177.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:178.1-179.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:180.1-181.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:182.1-183.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:184.1-185.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:186.1-187.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:188.1-189.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:190.1-191.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:192.1-193.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:194.1-195.99 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:196.1-197.99 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:198.1-199.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:200.1-201.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:202.1-203.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:204.1-205.99 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:206.1-207.99 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:208.1-209.83 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:210.1-211.99 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:213.1-214.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:215.1-216.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:217.1-218.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:219.1-220.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:221.1-222.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:223.1-224.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:225.1-226.79 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:227.1-228.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:229.1-230.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:231.1-232.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:233.1-234.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:235.1-236.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:237.1-238.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:239.1-240.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:241.1-242.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:243.1-244.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:245.1-246.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:247.1-248.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:249.1-250.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:252.1-253.78 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:254.1-255.78 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:256.1-257.78 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:258.1-259.78 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:260.1-261.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:262.1-263.78 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:264.1-265.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:266.1-267.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:268.1-269.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:270.1-271.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:272.1-273.98 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:274.1-275.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:276.1-277.98 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:278.1-279.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:280.1-281.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:282.1-283.98 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:284.1-285.98 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:286.1-287.98 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:288.1-289.82 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:291.1-292.78 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:293.1-294.78 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:295.1-296.78 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:297.1-298.78 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:299.1-300.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:301.1-302.78 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:303.1-304.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:305.1-306.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:307.1-308.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:309.1-310.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:311.1-312.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:313.1-314.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:315.1-316.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:317.1-318.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:319.1-320.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:321.1-322.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:323.1-324.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:325.1-326.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:327.1-328.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(I16, []), NumV (8)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:330.1-331.75 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:332.1-333.75 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:334.1-335.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:336.1-337.75 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:338.1-339.75 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:340.1-341.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:342.1-343.75 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:344.1-345.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:346.1-347.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:348.1-349.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:350.1-351.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:352.1-353.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:354.1-355.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:356.1-357.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:358.1-359.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:360.1-361.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:362.1-363.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:364.1-365.77 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:366.1-367.95 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:369.1-370.75 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:371.1-372.75 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:373.1-374.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:375.1-376.75 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:377.1-378.75 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:379.1-380.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:381.1-382.75 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:383.1-384.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:385.1-386.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:387.1-388.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:389.1-390.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:391.1-392.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:393.1-394.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:395.1-396.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:397.1-398.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:399.1-400.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:401.1-402.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:403.1-404.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:405.1-406.93 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(HIGH) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(HIGH, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:408.1-409.74 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:410.1-411.74 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:412.1-413.74 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:414.1-415.74 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:416.1-417.76 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:418.1-419.74 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:420.1-421.76 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:422.1-423.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:424.1-425.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:426.1-427.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:428.1-429.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:430.1-431.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:432.1-433.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:434.1-435.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:436.1-437.76 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:438.1-439.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:440.1-441.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:442.1-443.94 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:444.1-445.76 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:447.1-448.74 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:449.1-450.74 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:451.1-452.74 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:453.1-454.74 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:455.1-456.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:457.1-458.74 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:459.1-460.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:461.1-462.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:463.1-464.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:465.1-466.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:467.1-468.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:469.1-470.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:471.1-472.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:473.1-474.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:475.1-476.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:477.1-478.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:479.1-480.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:481.1-482.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_int_to_int_extend.wast:483.1-484.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?(LOW) (interpreting CaseV(VCVTOP, [TupV (CaseV(I64, []), NumV (2)), TupV (CaseV(I32, []), NumV (4)), CaseV(EXTEND, []), OptV (CaseV(LOW, [])), OptV (CaseV(U, [])), OptV]))"))
- 1/229 (0.44%)

===== ../../test-interpreter/spec-test-2/simd/simd_lane.wast =====
- 286/286 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_linking.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load.wast:110.1-110.92 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_load.wast:118.1-118.87 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(U, [])), OptV]))"))
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
- 86/86 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_splat.wast =====
- 114/114 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_load_zero.wast =====
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-2/simd/simd_splat.wast =====
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_splat.wast:341.1-341.129 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(F32, []), NumV (4)), TupV (CaseV(I32, []), NumV (4)), CaseV(CONVERT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- Test failed at ../../test-interpreter/spec-test-2/simd/simd_splat.wast:342.1-342.105 (Util.Error.Error(_, "interpreter error: on expr `InfixE (VarE (lanet_u3), X, VarE (N_1))` invalid assignment: on rhs ?() (interpreting CaseV(VCVTOP, [TupV (CaseV(I32, []), NumV (4)), TupV (CaseV(F32, []), NumV (4)), CaseV(TRUNC_SAT, []), OptV, OptV (CaseV(S, [])), OptV]))"))
- 160/162 (98.77%)

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

Total [44623/45187] (98.75%)

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
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_copy.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_fill.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_init_data.wast =====
- 31/31 (100.00%)

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
- 261/261 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_const.wast =====
- 577/577 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_conversions.wast =====
- 234/234 (100.00%)

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
- 435/435 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast =====
- 105/105 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_q15mulr_sat_s.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_sat_arith.wast =====
- 206/206 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith.wast =====
- 183/183 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith2.wast =====
- 123/123 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast =====
- 435/435 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast =====
- 105/105 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f32x4.wast =====
- 103/103 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast =====
- 103/103 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith.wast =====
- 189/189 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith2.wast =====
- 23/23 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast =====
- 103/103 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast =====
- 105/105 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith.wast =====
- 123/123 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith2.wast =====
- 186/186 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast =====
- 415/415 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_sat_arith.wast =====
- 190/190 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast =====
- 229/229 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_lane.wast =====
- 286/286 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_linking.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast =====
- 33/33 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast =====
- 49/49 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast =====
- 86/86 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast =====
- 114/114 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_zero.wast =====
- 29/29 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_splat.wast =====
- 162/162 (100.00%)

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

Total [45764/45764] (100.00%)

== Complete.
```
