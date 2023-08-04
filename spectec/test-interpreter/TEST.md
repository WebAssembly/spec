# Preview

```sh
$ (cd ../spec && dune exec ../src/exe-watsup/main.exe -- *.watsup -v -l --sideconditions --animate --interpreter --root "..") 2>/dev/null
watsup 0.3 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions
== IL Validation...
== Running pass animate
Animation failed.
Valtype_sub: `|-%<:%`(t, t')
if ((t' = (numtype <: valtype)) \/ (t' = (vectype <: valtype)))
...Animation failed
Animation failed.
(if (l < |C.LABEL_context|))*{l}
if (l' < |C.LABEL_context|)
(Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])
...Animation failed
Animation failed.
if (0 < |C.MEM_context|)
if ((n?{n} = ?()) <=> (sx?{sx} = ?()))
if (C.MEM_context[0] = mt)
if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
(if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
if ((n?{n} = ?()) \/ (nt = (in <: numtype)))
...Animation failed
Animation failed.
if (0 < |C.MEM_context|)
if (C.MEM_context[0] = mt)
if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
(if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
if ((n?{n} = ?()) \/ (nt = (in <: numtype)))
...Animation failed
== IL Validation...
== Translating to AL...
{ LOCAL: val^k ++ $default_(t)*; MODULE: m; }
{ LOCAL: []; MODULE: m; }
{ LOCAL: []; MODULE: m_init; }
{ LOCAL: []; MODULE: m; }
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== sample.wast =====
- 27/27 (100.00%)

===== forward.wast =====
- 4/4 (100.00%)

===== float_misc.wast =====
- 440/440 (100.00%)

===== table_copy.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/1649 (0.00%)

===== ref_null.wast =====
- 2/2 (100.00%)

===== memory.wast =====
- 45/45 (100.00%)

===== unwind.wast =====
- 49/49 (100.00%)

===== call.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/70 (0.00%)

===== local_get.wast =====
- 19/19 (100.00%)

===== fac.wast =====
- 6/6 (100.00%)

===== func.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 92/96 (95.83%)

===== exports.wast =====
- 9/9 (100.00%)

===== local_set.wast =====
- 19/19 (100.00%)

===== linking.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 19/90 (21.11%)

===== float_literals.wast =====
- 83/83 (100.00%)

===== align.wast =====
- 48/48 (100.00%)

===== if.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/123 (0.00%)

===== const.wast =====
- 300/300 (100.00%)

===== f64_cmp.wast =====
- 2400/2400 (100.00%)

===== block.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/52 (0.00%)

===== labels.wast =====
- 25/25 (100.00%)

===== switch.wast =====
- 26/26 (100.00%)

===== i64.wast =====
- 384/384 (100.00%)

===== memory_copy.wast =====
- Uncaught exception: Direct invocation failed due to Backend_interpreter.Exception.Timeout
- 4100/4338 (94.51%)

===== stack.wast =====
- 5/5 (100.00%)

===== loop.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/77 (0.00%)

===== conversions.wast =====
- 593/593 (100.00%)

===== endianness.wast =====
- 68/68 (100.00%)

===== return.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/63 (0.00%)

===== store.wast =====
- 9/9 (100.00%)

===== memory_redundancy.wast =====
- 4/4 (100.00%)

===== i32.wast =====
- 374/374 (100.00%)

===== unreachable.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/63 (0.00%)

===== bulk.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/66 (0.00%)

===== traps.wast =====
- 32/32 (100.00%)

===== local_tee.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/55 (0.00%)

===== f64_bitwise.wast =====
- 360/360 (100.00%)

===== memory_grow.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 41/84 (48.81%)

===== call_indirect.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/132 (0.00%)

===== load.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/37 (0.00%)

===== memory_fill.wast =====
- Uncaught exception: Direct invocation failed due to Backend_interpreter.Exception.Timeout
- 4/20 (20.00%)

===== memory_size.wast =====
- 36/36 (100.00%)

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
- Uncaught exception: Module Instantiation failed due to No frame
- 8/34 (23.53%)

===== left-to-right.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/95 (0.00%)

===== ref_is_null.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/11 (0.00%)

===== memory_trap.wast =====
- 180/180 (100.00%)

===== br_table.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/149 (0.00%)

===== select.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/118 (0.00%)

===== f32_bitwise.wast =====
- 360/360 (100.00%)

===== memory_init.wast =====
- 140/140 (100.00%)

===== elem.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/37 (0.00%)

===== table_get.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/9 (0.00%)

===== f32.wast =====
- 2500/2500 (100.00%)

===== start.wast =====
- 0/7 (0.00%)

===== float_exprs.wast =====
- 794/794 (100.00%)

===== float_memory.wast =====
- 60/60 (100.00%)

===== table_size.wast =====
- 36/36 (100.00%)

===== table_set.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/18 (0.00%)

===== f32_cmp.wast =====
- 2400/2400 (100.00%)

===== br_if.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/88 (0.00%)

===== ref_func.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/8 (0.00%)

===== names.wast =====
- print_i32: 42
- print_i32: 123
- 482/482 (100.00%)

===== unreached-valid.wast =====
- 5/5 (100.00%)

===== table_fill.wast =====
- 35/35 (100.00%)

===== data.wast =====
- 14/14 (100.00%)

===== int_literals.wast =====
- 30/30 (100.00%)

===== address.wast =====
- 255/255 (100.00%)

===== table_grow.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 21/38 (55.26%)

===== func_ptrs.wast =====
- print_i32: 83
- Uncaught exception: Module Instantiation failed due to No frame
- 3/25 (12.00%)

===== table_init.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/662 (0.00%)

===== global.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/58 (0.00%)

===== int_exprs.wast =====
- 89/89 (100.00%)

===== f64.wast =====
- 2500/2500 (100.00%)

===== br.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/76 (0.00%)

===== nop.wast =====
- Uncaught exception: Module Instantiation failed due to Pop some values from empty stack
- 0/83 (0.00%)

Total [19535/23778] (82.16%; Normalized 60.95%)
== Complete.
```
