# Preview

```sh
$ for v in 1 2 3; do ( \
>   echo "Running test for Wasm $v.0..." && \
>   cd ../spec/wasm-$v.0 && \
>   dune exec ../../src/exe-watsup/main.exe -- *.watsup -v -l --sideconditions --animate --interpreter --root "../.." --test-version $v \
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
===== sample.wast =====
- print_i32: 10
- 21/28 (75.00%)

===== address.wast =====
- 238/238 (100.00%)

===== align.wast =====
- 48/48 (100.00%)

===== block.wast =====
- 41/41 (100.00%)

===== br.wast =====
- 63/63 (100.00%)

===== br_if.wast =====
- 88/88 (100.00%)

===== br_table.wast =====
- 146/146 (100.00%)

===== break-drop.wast =====
- 3/3 (100.00%)

===== call.wast =====
- 61/61 (100.00%)

===== const.wast =====
- 300/300 (100.00%)

===== endianness.wast =====
- 68/68 (100.00%)

===== exports.wast =====
- 6/6 (100.00%)

===== f32_bitwise.wast =====
- 360/360 (100.00%)

===== f32_cmp.wast =====
- 2400/2400 (100.00%)

===== f64_bitwise.wast =====
- 360/360 (100.00%)

===== f64_cmp.wast =====
- 2400/2400 (100.00%)

===== fac.wast =====
- 5/5 (100.00%)

===== float_literals.wast =====
- 83/83 (100.00%)

===== float_memory.wast =====
- 84/84 (100.00%)

===== forward.wast =====
- 4/4 (100.00%)

===== func.wast =====
- 73/73 (100.00%)

===== func_ptrs.wast =====
- print_i32: 83
- 26/26 (100.00%)

===== globals.wast =====
- 46/46 (100.00%)

===== i32.wast =====
- 359/359 (100.00%)

===== i64.wast =====
- 359/359 (100.00%)

===== if.wast =====
- 88/88 (100.00%)

===== int_exprs.wast =====
- 89/89 (100.00%)

===== int_literals.wast =====
- 30/30 (100.00%)

===== labels.wast =====
- 25/25 (100.00%)

===== left-to-right.wast =====
- 95/95 (100.00%)

===== linking.wast =====
- 82/82 (100.00%)

===== load.wast =====
- 37/37 (100.00%)

===== local_get.wast =====
- 19/19 (100.00%)

===== local_set.wast =====
- 19/19 (100.00%)

===== local_tee.wast =====
- 55/55 (100.00%)

===== loop.wast =====
- 66/66 (100.00%)

===== memory.wast =====
- 45/45 (100.00%)

===== memory_redundancy.wast =====
- 7/7 (100.00%)

===== memory_size.wast =====
- 36/36 (100.00%)

===== memory_trap.wast =====
- 171/171 (100.00%)

===== names.wast =====
- print_i32: 42
- print_i32: 123
- 479/479 (100.00%)

===== nop.wast =====
- 83/83 (100.00%)

===== return.wast =====
- 63/63 (100.00%)

===== select.wast =====
- 94/94 (100.00%)

===== stack.wast =====
- 3/3 (100.00%)

===== start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 11/11 (100.00%)

===== store.wast =====
- 9/9 (100.00%)

===== switch.wast =====
- 26/26 (100.00%)

===== traps.wast =====
- 32/32 (100.00%)

===== unreachable.wast =====
- 61/61 (100.00%)

===== unwind.wast =====
- 49/49 (100.00%)

Total [9416/9423] (99.93%; Normalized 99.51%)
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
===== sample.wast =====
- print_i32: 10
- 28/28 (100.00%)

===== address.wast =====
- 255/255 (100.00%)

===== align.wast =====
- 48/48 (100.00%)

===== block.wast =====
- 52/52 (100.00%)

===== br.wast =====
- 76/76 (100.00%)

===== br_if.wast =====
- 88/88 (100.00%)

===== br_table.wast =====
- 149/149 (100.00%)

===== bulk.wast =====
- 104/104 (100.00%)

===== call.wast =====
- 70/70 (100.00%)

===== const.wast =====
- 300/300 (100.00%)

===== conversions.wast =====
- 593/593 (100.00%)

===== data.wast =====
- 14/14 (100.00%)

===== elem.wast =====
- 37/37 (100.00%)

===== endianness.wast =====
- 68/68 (100.00%)

===== exports.wast =====
- 9/9 (100.00%)

===== f32.wast =====
- 2500/2500 (100.00%)

===== f32_bitwise.wast =====
- 360/360 (100.00%)

===== f32_cmp.wast =====
- 2400/2400 (100.00%)

===== f64.wast =====
- 2500/2500 (100.00%)

===== f64_bitwise.wast =====
- 360/360 (100.00%)

===== f64_cmp.wast =====
- 2400/2400 (100.00%)

===== fac.wast =====
- 6/6 (100.00%)

===== float_exprs.wast =====
- 804/804 (100.00%)

===== float_literals.wast =====
- 83/83 (100.00%)

===== float_memory.wast =====
- 84/84 (100.00%)

===== float_misc.wast =====
- 440/440 (100.00%)

===== forward.wast =====
- 4/4 (100.00%)

===== func.wast =====
- 96/96 (100.00%)

===== func_ptrs.wast =====
- print_i32: 83
- 26/26 (100.00%)

===== global.wast =====
- 58/58 (100.00%)

===== i32.wast =====
- 374/374 (100.00%)

===== i64.wast =====
- 384/384 (100.00%)

===== if.wast =====
- 123/123 (100.00%)

===== imports.wast =====
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

===== int_exprs.wast =====
- 89/89 (100.00%)

===== int_literals.wast =====
- 30/30 (100.00%)

===== labels.wast =====
- 25/25 (100.00%)

===== left-to-right.wast =====
- 95/95 (100.00%)

===== linking.wast =====
- 90/90 (100.00%)

===== load.wast =====
- 37/37 (100.00%)

===== local_get.wast =====
- 19/19 (100.00%)

===== local_set.wast =====
- 19/19 (100.00%)

===== local_tee.wast =====
- 55/55 (100.00%)

===== loop.wast =====
- 77/77 (100.00%)

===== memory.wast =====
- 45/45 (100.00%)

===== memory_init.wast =====
- 149/149 (100.00%)

===== memory_redundancy.wast =====
- 7/7 (100.00%)

===== memory_size.wast =====
- 36/36 (100.00%)

===== memory_trap.wast =====
- 180/180 (100.00%)

===== names.wast =====
- print_i32: 42
- print_i32: 123
- 482/482 (100.00%)

===== nop.wast =====
- 83/83 (100.00%)

===== ref_func.wast =====
- 10/10 (100.00%)

===== ref_is_null.wast =====
- 13/13 (100.00%)

===== ref_null.wast =====
- 2/2 (100.00%)

===== return.wast =====
- 63/63 (100.00%)

===== select.wast =====
- 118/118 (100.00%)

===== stack.wast =====
- 5/5 (100.00%)

===== start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 11/11 (100.00%)

===== store.wast =====
- 9/9 (100.00%)

===== switch.wast =====
- 26/26 (100.00%)

===== table_copy.wast =====
- 1675/1675 (100.00%)

===== table_fill.wast =====
- 35/35 (100.00%)

===== table_get.wast =====
- 10/10 (100.00%)

===== table_grow.wast =====
- 38/38 (100.00%)

===== table_init.wast =====
- 677/677 (100.00%)

===== table_set.wast =====
- 18/18 (100.00%)

===== table_size.wast =====
- 36/36 (100.00%)

===== traps.wast =====
- 32/32 (100.00%)

===== unreachable.wast =====
- 63/63 (100.00%)

===== unreached-valid.wast =====
- 5/5 (100.00%)

===== unwind.wast =====
- 49/49 (100.00%)

Total [19340/19340] (100.00%; Normalized 100.00%)
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
===== sample.wast =====
- print_i32: 10
- 28/28 (100.00%)

===== address.wast =====
- 255/255 (100.00%)

===== align.wast =====
- 48/48 (100.00%)

===== block.wast =====
- 52/52 (100.00%)

===== br.wast =====
- 76/76 (100.00%)

===== br_if.wast =====
- 88/88 (100.00%)

===== br_table.wast =====
- 149/149 (100.00%)

===== bulk.wast =====
- 104/104 (100.00%)

===== call.wast =====
- 70/70 (100.00%)

===== const.wast =====
- 300/300 (100.00%)

===== conversions.wast =====
- 593/593 (100.00%)

===== data.wast =====
- 14/14 (100.00%)

===== elem.wast =====
- 37/37 (100.00%)

===== endianness.wast =====
- 68/68 (100.00%)

===== exports.wast =====
- 9/9 (100.00%)

===== f32.wast =====
- 2500/2500 (100.00%)

===== f32_bitwise.wast =====
- 360/360 (100.00%)

===== f32_cmp.wast =====
- 2400/2400 (100.00%)

===== f64.wast =====
- 2500/2500 (100.00%)

===== f64_bitwise.wast =====
- 360/360 (100.00%)

===== f64_cmp.wast =====
- 2400/2400 (100.00%)

===== fac.wast =====
- 6/6 (100.00%)

===== float_exprs.wast =====
- 804/804 (100.00%)

===== float_literals.wast =====
- 83/83 (100.00%)

===== float_memory.wast =====
- 84/84 (100.00%)

===== float_misc.wast =====
- 440/440 (100.00%)

===== forward.wast =====
- 4/4 (100.00%)

===== func.wast =====
- 96/96 (100.00%)

===== func_ptrs.wast =====
- print_i32: 83
- 26/26 (100.00%)

===== br_on_non_null.wast =====
- 6/6 (100.00%)

===== br_on_null.wast =====
- 6/6 (100.00%)

===== call_ref.wast =====
- 27/27 (100.00%)

===== ref_as_non_null.wast =====
- 4/4 (100.00%)

===== array.wast =====
- 31/31 (100.00%)

===== array_copy.wast =====
- 30/30 (100.00%)

===== array_fill.wast =====
- 13/13 (100.00%)

===== array_init_data.wast =====
- 30/30 (100.00%)

===== array_init_elem.wast =====
- 19/19 (100.00%)

===== br_on_cast.wast =====
- 28/28 (100.00%)

===== br_on_cast_fail.wast =====
- 28/28 (100.00%)

===== extern.wast =====
- 17/17 (100.00%)

===== i31.wast =====
- 20/20 (100.00%)

===== ref_cast.wast =====
- 43/43 (100.00%)

===== ref_eq.wast =====
- 82/82 (100.00%)

===== ref_test.wast =====
- 69/69 (100.00%)

===== struct.wast =====
- 19/19 (100.00%)

===== type-subtyping.wast =====
- 20/20 (100.00%)

===== global.wast =====
- 58/58 (100.00%)

===== i32.wast =====
- 374/374 (100.00%)

===== i64.wast =====
- 384/384 (100.00%)

===== if.wast =====
- 123/123 (100.00%)

===== imports.wast =====
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

===== int_exprs.wast =====
- 89/89 (100.00%)

===== int_literals.wast =====
- 30/30 (100.00%)

===== labels.wast =====
- 25/25 (100.00%)

===== left-to-right.wast =====
- 95/95 (100.00%)

===== linking.wast =====
- 90/90 (100.00%)

===== load.wast =====
- 37/37 (100.00%)

===== local_get.wast =====
- 19/19 (100.00%)

===== local_set.wast =====
- 19/19 (100.00%)

===== local_tee.wast =====
- 55/55 (100.00%)

===== loop.wast =====
- 77/77 (100.00%)

===== memory.wast =====
- 45/45 (100.00%)

===== memory_init.wast =====
- 149/149 (100.00%)

===== memory_redundancy.wast =====
- 7/7 (100.00%)

===== memory_size.wast =====
- 36/36 (100.00%)

===== memory_trap.wast =====
- 180/180 (100.00%)

===== names.wast =====
- print_i32: 42
- print_i32: 123
- 482/482 (100.00%)

===== nop.wast =====
- 83/83 (100.00%)

===== ref_func.wast =====
- 10/10 (100.00%)

===== ref_is_null.wast =====
- 13/13 (100.00%)

===== ref_null.wast =====
- 2/2 (100.00%)

===== return.wast =====
- 63/63 (100.00%)

===== select.wast =====
- 118/118 (100.00%)

===== simd_address.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 0/42 (0.00%)

===== simd_align.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 0/8 (0.00%)

===== simd_bit_shift.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 134/211 (63.51%)

===== simd_bitwise.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 126/139 (90.65%)

===== simd_boolean.wast =====
- 251/259 (96.91%)

===== simd_const.wast =====
- 265/265 (100.00%)

===== simd_conversions.wast =====
- 0/232 (0.00%)

===== simd_f32x4.wast =====
- 608/772 (78.76%)

===== simd_f32x4_arith.wast =====
- 1193/1803 (66.17%)

===== simd_f32x4_cmp.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 2568/2581 (99.50%)

===== simd_f32x4_pmin_pmax.wast =====
- 3872/3872 (100.00%)

===== simd_f32x4_rounding.wast =====
- 160/176 (90.91%)

===== simd_f64x2.wast =====
- 627/793 (79.07%)

===== simd_f64x2_arith.wast =====
- 1194/1806 (66.11%)

===== simd_f64x2_cmp.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 2646/2659 (99.51%)

===== simd_f64x2_pmin_pmax.wast =====
- 3872/3872 (100.00%)

===== simd_f64x2_rounding.wast =====
- 160/176 (90.91%)

===== simd_i16x8_arith.wast =====
- 181/181 (100.00%)

===== simd_i16x8_arith2.wast =====
- 151/151 (100.00%)

===== simd_i16x8_cmp.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 420/433 (97.00%)

===== simd_i16x8_extadd_pairwise_i8x16.wast =====
- 0/16 (0.00%)

===== simd_i16x8_extmul_i8x16.wast =====
- 0/104 (0.00%)

===== simd_i16x8_q15mulr_sat_s.wast =====
- 26/26 (100.00%)

===== simd_i16x8_sat_arith.wast =====
- 204/204 (100.00%)

===== simd_i32x4_arith.wast =====
- 181/181 (100.00%)

===== simd_i32x4_arith2.wast =====
- 121/121 (100.00%)

===== simd_i32x4_cmp.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 420/433 (97.00%)

===== simd_i32x4_dot_i16x8.wast =====
- 0/26 (0.00%)

===== simd_i32x4_extadd_pairwise_i16x8.wast =====
- 0/16 (0.00%)

===== simd_i32x4_extmul_i16x8.wast =====
- 0/104 (0.00%)

===== simd_i32x4_trunc_sat_f32x4.wast =====
- 0/102 (0.00%)

===== simd_i32x4_trunc_sat_f64x2.wast =====
- 0/102 (0.00%)

===== simd_i64x2_arith.wast =====
- 187/187 (100.00%)

===== simd_i64x2_arith2.wast =====
- 21/21 (100.00%)

===== simd_i64x2_cmp.wast =====
- 102/102 (100.00%)

===== simd_i64x2_extmul_i32x4.wast =====
- 0/104 (0.00%)

===== simd_i8x16_arith.wast =====
- 121/121 (100.00%)

===== simd_i8x16_arith2.wast =====
- 184/184 (100.00%)

===== simd_i8x16_cmp.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 400/413 (96.85%)

===== simd_i8x16_sat_arith.wast =====
- 188/188 (100.00%)

===== simd_int_to_int_extend.wast =====
- 0/228 (0.00%)

===== simd_lane.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 112/274 (40.88%)

===== simd_load.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 0/17 (0.00%)

===== simd_load16_lane.wast =====
- 0/32 (0.00%)

===== simd_load32_lane.wast =====
- 0/20 (0.00%)

===== simd_load64_lane.wast =====
- 0/12 (0.00%)

===== simd_load8_lane.wast =====
- 0/48 (0.00%)

===== simd_load_extend.wast =====
- 12/84 (14.29%)

===== simd_load_splat.wast =====
- 112/112 (100.00%)

===== simd_load_zero.wast =====
- 27/27 (100.00%)

===== simd_splat.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 102/158 (64.56%)

===== simd_store.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid_argument("option is None")
- 0/17 (0.00%)

===== simd_store16_lane.wast =====
- 0/32 (0.00%)

===== simd_store32_lane.wast =====
- 0/20 (0.00%)

===== simd_store64_lane.wast =====
- 0/12 (0.00%)

===== simd_store8_lane.wast =====
- 0/48 (0.00%)

===== stack.wast =====
- 5/5 (100.00%)

===== start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 11/11 (100.00%)

===== store.wast =====
- 9/9 (100.00%)

===== switch.wast =====
- 26/26 (100.00%)

===== table_copy.wast =====
- 1675/1675 (100.00%)

===== table_fill.wast =====
- 35/35 (100.00%)

===== table_get.wast =====
- 10/10 (100.00%)

===== table_grow.wast =====
- 38/38 (100.00%)

===== table_init.wast =====
- 677/677 (100.00%)

===== table_set.wast =====
- 18/18 (100.00%)

===== table_size.wast =====
- 36/36 (100.00%)

===== traps.wast =====
- 32/32 (100.00%)

===== unreachable.wast =====
- 63/63 (100.00%)

===== unreached-valid.wast =====
- 5/5 (100.00%)

===== unwind.wast =====
- 49/49 (100.00%)

Total [40780/44159] (92.35%; Normalized 82.29%)
== Complete.
```
