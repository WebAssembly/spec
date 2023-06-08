# Preview

```sh
$ (cd ../spec && dune exec ../src/exe-watsup/main.exe -- *.watsup -v -l --sideconditions --animate --interpreter --root "..") 2>/dev/null
watsup 0.3 generator
== Parsing...
== Elaboration...
== IL Validation...
== Side condition inference
== IL Validation...
== Animate
== IL Validation...
== Translating to AL...
Invalid premise `Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])` to be AL instr.
Invalid premise `(Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}` to be AL instr.
Invalid premise `(if (l < |C.LABEL_context|))*{l}` to be AL instr.
Invalid premise `(if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}` to be AL instr.
Invalid premise `(if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}` to be AL instr.
Bubbleup semantics for br: Top of the stack is frame / label
Bubbleup semantics for return: Top of the stack is frame / label
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== sample.wast =====
- 27/27 (100.00%)

===== forward.wast =====
- 4/4 (100.00%)

===== float_misc.wast =====
- 440/440 (100.00%)

===== table_copy.wast =====
- 1649/1649 (100.00%)

===== ref_null.wast =====
- 2/2 (100.00%)

===== memory.wast =====
- 45/45 (100.00%)

===== unwind.wast =====
- 49/49 (100.00%)

===== call.wast =====
- 68/70 (97.14%)

===== local_get.wast =====
- 19/19 (100.00%)

===== fac.wast =====
- 6/6 (100.00%)

===== func.wast =====
- 96/96 (100.00%)

===== exports.wast =====
- 9/9 (100.00%)

===== local_set.wast =====
- 19/19 (100.00%)

===== linking.wast =====
- Uncaught exception: Module Instantiation failed due to Failed Array.get during AccessE
- 43/83 (51.81%)

===== float_literals.wast =====
- Uncaught exception: This test contains a binary module
- 82/83 (98.80%)

===== align.wast =====
- 48/48 (100.00%)

===== if.wast =====
- 123/123 (100.00%)

===== const.wast =====
- 300/300 (100.00%)

===== f64_cmp.wast =====
- 2400/2400 (100.00%)

===== block.wast =====
- 52/52 (100.00%)

===== labels.wast =====
- 25/25 (100.00%)

===== switch.wast =====
- 26/26 (100.00%)

===== i64.wast =====
- 384/384 (100.00%)

===== memory_copy.wast =====
- Uncaught exception: Direct invocation failed due to Failed Array.get during AccessE
- 30/4338 (0.69%)

===== stack.wast =====
- 5/5 (100.00%)

===== loop.wast =====
- 77/77 (100.00%)

===== conversions.wast =====
- 593/593 (100.00%)

===== endianness.wast =====
- 68/68 (100.00%)

===== return.wast =====
- 63/63 (100.00%)

===== store.wast =====
- 9/9 (100.00%)

===== memory_redundancy.wast =====
- 4/4 (100.00%)

===== i32.wast =====
- 374/374 (100.00%)

===== unreachable.wast =====
- 63/63 (100.00%)

===== bulk.wast =====
- Uncaught exception: Direct invocation failed due to Backend_interpreter.Exception.Timeout
- 7/66 (10.61%)

===== traps.wast =====
- 32/32 (100.00%)

===== local_tee.wast =====
- 55/55 (100.00%)

===== f64_bitwise.wast =====
- 360/360 (100.00%)

===== memory_grow.wast =====
- 75/84 (89.29%)

===== call_indirect.wast =====
- 127/132 (96.21%)

===== load.wast =====
- 37/37 (100.00%)

===== memory_fill.wast =====
- Uncaught exception: Direct invocation failed due to Backend_interpreter.Exception.Timeout
- 4/20 (20.00%)

===== memory_size.wast =====
- 29/36 (80.56%)

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
- Uncaught exception: Module Instantiation failed due to Failed Array.get during AccessE
- 4/34 (11.76%)

===== left-to-right.wast =====
- 95/95 (100.00%)

===== ref_is_null.wast =====
- 11/11 (100.00%)

===== memory_trap.wast =====
- 180/180 (100.00%)

===== br_table.wast =====
- 149/149 (100.00%)

===== select.wast =====
- 118/118 (100.00%)

===== f32_bitwise.wast =====
- 360/360 (100.00%)

===== memory_init.wast =====
- Uncaught exception: Direct invocation failed due to Failed Array.get during AccessE
- 90/140 (64.29%)

===== elem.wast =====
- Uncaught exception: Module Instantiation failed due to Failed Array.get during AccessE
- 0/25 (0.00%)

===== table_get.wast =====
- 9/9 (100.00%)

===== f32.wast =====
- 2500/2500 (100.00%)

===== start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 6/6 (100.00%)

===== float_exprs.wast =====
- 794/794 (100.00%)

===== float_memory.wast =====
- 60/60 (100.00%)

===== table_size.wast =====
- 29/36 (80.56%)

===== table_set.wast =====
- 18/18 (100.00%)

===== f32_cmp.wast =====
- 2400/2400 (100.00%)

===== br_if.wast =====
- 88/88 (100.00%)

===== ref_func.wast =====
- 8/8 (100.00%)

===== names.wast =====
- print_i32: 42
- print_i32: 123
- 482/482 (100.00%)

===== unreached-valid.wast =====
- 5/5 (100.00%)

===== table_fill.wast =====
- 35/35 (100.00%)

===== int_literals.wast =====
- 30/30 (100.00%)

===== address.wast =====
- 255/255 (100.00%)

===== table_grow.wast =====
- 36/38 (94.74%)

===== func_ptrs.wast =====
- print_i32: 83
- 25/25 (100.00%)

===== table_init.wast =====
- 662/662 (100.00%)

===== global.wast =====
- Uncaught exception: Module Instantiation failed due to Failed Array.get during AccessE
- 0/58 (0.00%)

===== int_exprs.wast =====
- 89/89 (100.00%)

===== f64.wast =====
- 2500/2500 (100.00%)

===== br.wast =====
- 76/76 (100.00%)

===== nop.wast =====
- 83/83 (100.00%)

Total [19125/23744] (80.55%; Normalized 90.49%)
== Complete.
```
