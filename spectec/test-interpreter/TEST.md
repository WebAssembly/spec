# Preview

```sh
$ cd ../spec/wasm-3.0 && \
> dune exec ../../src/exe-watsup/main.exe -- *.watsup -v -l --interpreter ../../test-interpreter/sample.wast 2> /dev/null
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== ../../test-interpreter/sample.wast =====
- print_i32: 10
- 28/28 (100.00%)

== Complete.
$ for v in 1 2 3; do ( \
>   echo "Running test for Wasm $v.0..." && \
>   cd ../spec/wasm-$v.0 && \
>   dune exec ../../src/exe-watsup/main.exe -- *.watsup -v -l --interpreter ../../test-interpreter/spec-test-$v --test-version $v \
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
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== ../../test-interpreter/spec-test-1/address.wast =====
- 238/238 (100.00%)

===== ../../test-interpreter/spec-test-1/align.wast =====
- 48/48 (100.00%)

===== ../../test-interpreter/spec-test-1/binary-leb128.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/binary.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/block.wast =====
- 41/41 (100.00%)

===== ../../test-interpreter/spec-test-1/br.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-1/br_if.wast =====
- 88/88 (100.00%)

===== ../../test-interpreter/spec-test-1/br_table.wast =====
- 146/146 (100.00%)

===== ../../test-interpreter/spec-test-1/break-drop.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-1/call.wast =====
- 61/61 (100.00%)

===== ../../test-interpreter/spec-test-1/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/comments.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/const.wast =====
- 300/300 (100.00%)

===== ../../test-interpreter/spec-test-1/conversions.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/custom.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/data.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/elem.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/endianness.wast =====
- 68/68 (100.00%)

===== ../../test-interpreter/spec-test-1/exports.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-1/f32.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/f32_bitwise.wast =====
- 360/360 (100.00%)

===== ../../test-interpreter/spec-test-1/f32_cmp.wast =====
- 2400/2400 (100.00%)

===== ../../test-interpreter/spec-test-1/f64.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/f64_bitwise.wast =====
- 360/360 (100.00%)

===== ../../test-interpreter/spec-test-1/f64_cmp.wast =====
- 2400/2400 (100.00%)

===== ../../test-interpreter/spec-test-1/fac.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-1/float_exprs.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/float_literals.wast =====
- 83/83 (100.00%)

===== ../../test-interpreter/spec-test-1/float_memory.wast =====
- 84/84 (100.00%)

===== ../../test-interpreter/spec-test-1/float_misc.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/forward.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-1/func.wast =====
- 73/73 (100.00%)

===== ../../test-interpreter/spec-test-1/func_ptrs.wast =====
- print_i32: 83
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-1/globals.wast =====
- 46/46 (100.00%)

===== ../../test-interpreter/spec-test-1/i32.wast =====
- 359/359 (100.00%)

===== ../../test-interpreter/spec-test-1/i64.wast =====
- 359/359 (100.00%)

===== ../../test-interpreter/spec-test-1/if.wast =====
- 88/88 (100.00%)

===== ../../test-interpreter/spec-test-1/imports.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/inline-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/int_exprs.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-1/int_literals.wast =====
- 30/30 (100.00%)

===== ../../test-interpreter/spec-test-1/labels.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-1/left-to-right.wast =====
- 95/95 (100.00%)

===== ../../test-interpreter/spec-test-1/linking.wast =====
- 82/82 (100.00%)

===== ../../test-interpreter/spec-test-1/load.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-1/local_get.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-1/local_set.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-1/local_tee.wast =====
- 55/55 (100.00%)

===== ../../test-interpreter/spec-test-1/loop.wast =====
- 66/66 (100.00%)

===== ../../test-interpreter/spec-test-1/memory.wast =====
- 45/45 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_redundancy.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_size.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-1/memory_trap.wast =====
- 171/171 (100.00%)

===== ../../test-interpreter/spec-test-1/names.wast =====
- print_i32: 42
- print_i32: 123
- 479/479 (100.00%)

===== ../../test-interpreter/spec-test-1/nop.wast =====
- 83/83 (100.00%)

===== ../../test-interpreter/spec-test-1/return.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-1/select.wast =====
- 94/94 (100.00%)

===== ../../test-interpreter/spec-test-1/skip-stack-guard-page.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/stack.wast =====
- 3/3 (100.00%)

===== ../../test-interpreter/spec-test-1/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-1/store.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-1/switch.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-1/token.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/traps.wast =====
- 32/32 (100.00%)

===== ../../test-interpreter/spec-test-1/type.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/unreachable.wast =====
- 61/61 (100.00%)

===== ../../test-interpreter/spec-test-1/unreached-invalid.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/unwind.wast =====
- 49/49 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-custom-section-id.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-import-field.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-import-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-1/utf8-invalid-encoding.wast =====
- 0/0 (100.00%)

Total [9395/9395] (100.00%)
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
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== ../../test-interpreter/spec-test-2/address.wast =====
- 255/255 (100.00%)

===== ../../test-interpreter/spec-test-2/align.wast =====
- 48/48 (100.00%)

===== ../../test-interpreter/spec-test-2/binary-leb128.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/binary.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/block.wast =====
- 52/52 (100.00%)

===== ../../test-interpreter/spec-test-2/br.wast =====
- 76/76 (100.00%)

===== ../../test-interpreter/spec-test-2/br_if.wast =====
- 88/88 (100.00%)

===== ../../test-interpreter/spec-test-2/br_table.wast =====
- 149/149 (100.00%)

===== ../../test-interpreter/spec-test-2/bulk.wast =====
- 104/104 (100.00%)

===== ../../test-interpreter/spec-test-2/call.wast =====
- 70/70 (100.00%)

===== ../../test-interpreter/spec-test-2/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/comments.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/const.wast =====
- 300/300 (100.00%)

===== ../../test-interpreter/spec-test-2/conversions.wast =====
- 593/593 (100.00%)

===== ../../test-interpreter/spec-test-2/custom.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/data.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-2/elem.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-2/endianness.wast =====
- 68/68 (100.00%)

===== ../../test-interpreter/spec-test-2/exports.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-2/f32.wast =====
- 2500/2500 (100.00%)

===== ../../test-interpreter/spec-test-2/f32_bitwise.wast =====
- 360/360 (100.00%)

===== ../../test-interpreter/spec-test-2/f32_cmp.wast =====
- 2400/2400 (100.00%)

===== ../../test-interpreter/spec-test-2/f64.wast =====
- 2500/2500 (100.00%)

===== ../../test-interpreter/spec-test-2/f64_bitwise.wast =====
- 360/360 (100.00%)

===== ../../test-interpreter/spec-test-2/f64_cmp.wast =====
- 2400/2400 (100.00%)

===== ../../test-interpreter/spec-test-2/fac.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-2/float_exprs.wast =====
- 804/804 (100.00%)

===== ../../test-interpreter/spec-test-2/float_literals.wast =====
- 83/83 (100.00%)

===== ../../test-interpreter/spec-test-2/float_memory.wast =====
- 84/84 (100.00%)

===== ../../test-interpreter/spec-test-2/float_misc.wast =====
- 440/440 (100.00%)

===== ../../test-interpreter/spec-test-2/forward.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-2/func.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-2/func_ptrs.wast =====
- print_i32: 83
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-2/global.wast =====
- 58/58 (100.00%)

===== ../../test-interpreter/spec-test-2/i32.wast =====
- 374/374 (100.00%)

===== ../../test-interpreter/spec-test-2/i64.wast =====
- 384/384 (100.00%)

===== ../../test-interpreter/spec-test-2/if.wast =====
- 123/123 (100.00%)

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
- 34/34 (100.00%)

===== ../../test-interpreter/spec-test-2/inline-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/int_exprs.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-2/int_literals.wast =====
- 30/30 (100.00%)

===== ../../test-interpreter/spec-test-2/labels.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-2/left-to-right.wast =====
- 95/95 (100.00%)

===== ../../test-interpreter/spec-test-2/linking.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-2/load.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-2/local_get.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-2/local_set.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-2/local_tee.wast =====
- 55/55 (100.00%)

===== ../../test-interpreter/spec-test-2/loop.wast =====
- 77/77 (100.00%)

===== ../../test-interpreter/spec-test-2/memory.wast =====
- 45/45 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_copy.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_fill.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_init.wast =====
- 149/149 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_redundancy.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_size.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-2/memory_trap.wast =====
- 180/180 (100.00%)

===== ../../test-interpreter/spec-test-2/names.wast =====
- print_i32: 42
- print_i32: 123
- 482/482 (100.00%)

===== ../../test-interpreter/spec-test-2/nop.wast =====
- 83/83 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_func.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_is_null.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-2/ref_null.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-2/return.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-2/select.wast =====
- 118/118 (100.00%)

===== ../../test-interpreter/spec-test-2/skip-stack-guard-page.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/stack.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-2/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-2/store.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-2/switch.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-2/table-sub.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/table.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/table_copy.wast =====
- 1675/1675 (100.00%)

===== ../../test-interpreter/spec-test-2/table_fill.wast =====
- 35/35 (100.00%)

===== ../../test-interpreter/spec-test-2/table_get.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-2/table_grow.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-2/table_init.wast =====
- 677/677 (100.00%)

===== ../../test-interpreter/spec-test-2/table_set.wast =====
- 18/18 (100.00%)

===== ../../test-interpreter/spec-test-2/table_size.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-2/token.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/tokens.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/traps.wast =====
- 32/32 (100.00%)

===== ../../test-interpreter/spec-test-2/type.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/unreachable.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-2/unreached-invalid.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/unreached-valid.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-2/unwind.wast =====
- 49/49 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-custom-section-id.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-import-field.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-import-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-2/utf8-invalid-encoding.wast =====
- 0/0 (100.00%)

Total [19312/19312] (100.00%)
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
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== ../../test-interpreter/spec-test-3/address.wast =====
- 255/255 (100.00%)

===== ../../test-interpreter/spec-test-3/align.wast =====
- 48/48 (100.00%)

===== ../../test-interpreter/spec-test-3/binary-leb128.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/binary.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/block.wast =====
- 52/52 (100.00%)

===== ../../test-interpreter/spec-test-3/br.wast =====
- 76/76 (100.00%)

===== ../../test-interpreter/spec-test-3/br_if.wast =====
- 88/88 (100.00%)

===== ../../test-interpreter/spec-test-3/br_table.wast =====
- 149/149 (100.00%)

===== ../../test-interpreter/spec-test-3/bulk.wast =====
- 104/104 (100.00%)

===== ../../test-interpreter/spec-test-3/call.wast =====
- 70/70 (100.00%)

===== ../../test-interpreter/spec-test-3/call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/comments.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/const.wast =====
- 300/300 (100.00%)

===== ../../test-interpreter/spec-test-3/conversions.wast =====
- 593/593 (100.00%)

===== ../../test-interpreter/spec-test-3/custom.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/data.wast =====
- 14/14 (100.00%)

===== ../../test-interpreter/spec-test-3/elem.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-3/endianness.wast =====
- 68/68 (100.00%)

===== ../../test-interpreter/spec-test-3/exports.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/f32.wast =====
- 2500/2500 (100.00%)

===== ../../test-interpreter/spec-test-3/f32_bitwise.wast =====
- 360/360 (100.00%)

===== ../../test-interpreter/spec-test-3/f32_cmp.wast =====
- 2400/2400 (100.00%)

===== ../../test-interpreter/spec-test-3/f64.wast =====
- 2500/2500 (100.00%)

===== ../../test-interpreter/spec-test-3/f64_bitwise.wast =====
- 360/360 (100.00%)

===== ../../test-interpreter/spec-test-3/f64_cmp.wast =====
- 2400/2400 (100.00%)

===== ../../test-interpreter/spec-test-3/fac.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-3/float_exprs.wast =====
- 804/804 (100.00%)

===== ../../test-interpreter/spec-test-3/float_literals.wast =====
- 83/83 (100.00%)

===== ../../test-interpreter/spec-test-3/float_memory.wast =====
- 84/84 (100.00%)

===== ../../test-interpreter/spec-test-3/float_misc.wast =====
- 440/440 (100.00%)

===== ../../test-interpreter/spec-test-3/forward.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-3/func.wast =====
- 96/96 (100.00%)

===== ../../test-interpreter/spec-test-3/func_ptrs.wast =====
- print_i32: 83
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/br_on_non_null.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/br_on_null.wast =====
- 6/6 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/call_ref.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/ref_as_non_null.wast =====
- 4/4 (100.00%)

===== ../../test-interpreter/spec-test-3/function-references/return_call_ref.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array.wast =====
- 31/31 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_copy.wast =====
- 30/30 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_fill.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_init_data.wast =====
- 30/30 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/array_init_elem.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/binary-gc.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/br_on_cast.wast =====
- 28/28 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/br_on_cast_fail.wast =====
- 28/28 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/extern.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/i31.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_cast.wast =====
- 43/43 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_eq.wast =====
- 82/82 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/ref_test.wast =====
- 69/69 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/struct.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/gc/type-subtyping.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-3/global.wast =====
- 58/58 (100.00%)

===== ../../test-interpreter/spec-test-3/i32.wast =====
- 374/374 (100.00%)

===== ../../test-interpreter/spec-test-3/i64.wast =====
- 384/384 (100.00%)

===== ../../test-interpreter/spec-test-3/if.wast =====
- 123/123 (100.00%)

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
- 34/34 (100.00%)

===== ../../test-interpreter/spec-test-3/inline-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/int_exprs.wast =====
- 89/89 (100.00%)

===== ../../test-interpreter/spec-test-3/int_literals.wast =====
- 30/30 (100.00%)

===== ../../test-interpreter/spec-test-3/labels.wast =====
- 25/25 (100.00%)

===== ../../test-interpreter/spec-test-3/left-to-right.wast =====
- 95/95 (100.00%)

===== ../../test-interpreter/spec-test-3/linking.wast =====
- 90/90 (100.00%)

===== ../../test-interpreter/spec-test-3/load.wast =====
- 37/37 (100.00%)

===== ../../test-interpreter/spec-test-3/local_get.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/local_set.wast =====
- 19/19 (100.00%)

===== ../../test-interpreter/spec-test-3/local_tee.wast =====
- 55/55 (100.00%)

===== ../../test-interpreter/spec-test-3/loop.wast =====
- 77/77 (100.00%)

===== ../../test-interpreter/spec-test-3/memory.wast =====
- 45/45 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_copy.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_fill.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_grow.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_init.wast =====
- 149/149 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_redundancy.wast =====
- 7/7 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_size.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/memory_trap.wast =====
- 180/180 (100.00%)

===== ../../test-interpreter/spec-test-3/names.wast =====
- print_i32: 42
- print_i32: 123
- 482/482 (100.00%)

===== ../../test-interpreter/spec-test-3/nop.wast =====
- 83/83 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_func.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_is_null.wast =====
- 13/13 (100.00%)

===== ../../test-interpreter/spec-test-3/ref_null.wast =====
- 2/2 (100.00%)

===== ../../test-interpreter/spec-test-3/return.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-3/select.wast =====
- 118/118 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_address.wast =====
- 42/42 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_align.wast =====
- 8/8 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_bit_shift.wast =====
- 211/211 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_bitwise.wast =====
- 139/139 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_boolean.wast =====
- 259/259 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_const.wast =====
- 265/265 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_conversions.wast =====
- 232/232 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4.wast =====
- 772/772 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_arith.wast =====
- 1803/1803 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_cmp.wast =====
- 2581/2581 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_pmin_pmax.wast =====
- 3872/3872 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f32x4_rounding.wast =====
- 176/176 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2.wast =====
- 793/793 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_arith.wast =====
- 1806/1806 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_cmp.wast =====
- 2659/2659 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_pmin_pmax.wast =====
- 3872/3872 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_f64x2_rounding.wast =====
- 176/176 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_arith.wast =====
- 181/181 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_arith2.wast =====
- 151/151 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_cmp.wast =====
- 433/433 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extadd_pairwise_i8x16.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_extmul_i8x16.wast =====
- 104/104 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_q15mulr_sat_s.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i16x8_sat_arith.wast =====
- 204/204 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith.wast =====
- 181/181 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_arith2.wast =====
- 121/121 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_cmp.wast =====
- 433/433 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_dot_i16x8.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extadd_pairwise_i16x8.wast =====
- 16/16 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_extmul_i16x8.wast =====
- 104/104 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f32x4.wast =====
- 102/102 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i32x4_trunc_sat_f64x2.wast =====
- 102/102 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith.wast =====
- 187/187 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_arith2.wast =====
- 21/21 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_cmp.wast =====
- 102/102 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i64x2_extmul_i32x4.wast =====
- 104/104 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith.wast =====
- 121/121 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_arith2.wast =====
- 184/184 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_cmp.wast =====
- 413/413 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_i8x16_sat_arith.wast =====
- 188/188 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_int_to_int_extend.wast =====
- 228/228 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_lane.wast =====
- 274/274 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_linking.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load16_lane.wast =====
- 32/32 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load32_lane.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load64_lane.wast =====
- 12/12 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load8_lane.wast =====
- 48/48 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_extend.wast =====
- 84/84 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_splat.wast =====
- 112/112 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_load_zero.wast =====
- 27/27 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_splat.wast =====
- 158/158 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store.wast =====
- 17/17 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store16_lane.wast =====
- 32/32 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store32_lane.wast =====
- 20/20 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store64_lane.wast =====
- 12/12 (100.00%)

===== ../../test-interpreter/spec-test-3/simd/simd_store8_lane.wast =====
- 48/48 (100.00%)

===== ../../test-interpreter/spec-test-3/skip-stack-guard-page.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/stack.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-3/start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 11/11 (100.00%)

===== ../../test-interpreter/spec-test-3/store.wast =====
- 9/9 (100.00%)

===== ../../test-interpreter/spec-test-3/switch.wast =====
- 26/26 (100.00%)

===== ../../test-interpreter/spec-test-3/table-sub.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/table.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/table_copy.wast =====
- 1675/1675 (100.00%)

===== ../../test-interpreter/spec-test-3/table_fill.wast =====
- 35/35 (100.00%)

===== ../../test-interpreter/spec-test-3/table_get.wast =====
- 10/10 (100.00%)

===== ../../test-interpreter/spec-test-3/table_grow.wast =====
- 38/38 (100.00%)

===== ../../test-interpreter/spec-test-3/table_init.wast =====
- 677/677 (100.00%)

===== ../../test-interpreter/spec-test-3/table_set.wast =====
- 18/18 (100.00%)

===== ../../test-interpreter/spec-test-3/table_size.wast =====
- 36/36 (100.00%)

===== ../../test-interpreter/spec-test-3/tail-call/return_call.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/tail-call/return_call_indirect.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/token.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/tokens.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/traps.wast =====
- 32/32 (100.00%)

===== ../../test-interpreter/spec-test-3/type.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/unreachable.wast =====
- 63/63 (100.00%)

===== ../../test-interpreter/spec-test-3/unreached-invalid.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/unreached-valid.wast =====
- 5/5 (100.00%)

===== ../../test-interpreter/spec-test-3/unwind.wast =====
- 49/49 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-custom-section-id.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-import-field.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-import-module.wast =====
- 0/0 (100.00%)

===== ../../test-interpreter/spec-test-3/utf8-invalid-encoding.wast =====
- 0/0 (100.00%)

Total [44131/44131] (100.00%)
== Complete.
```
