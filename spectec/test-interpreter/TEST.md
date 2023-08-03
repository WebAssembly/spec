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
- 24/27 (88.89%)

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
- 46/49 (93.88%)

===== call.wast =====
- 47/70 (67.14%)

===== local_get.wast =====
- 18/19 (94.74%)

===== fac.wast =====
- 3/6 (50.00%)

===== func.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 53/96 (55.21%)

===== exports.wast =====
- 9/9 (100.00%)

===== local_set.wast =====
- 1/19 (5.26%)

===== linking.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 18/90 (20.00%)

===== float_literals.wast =====
- 83/83 (100.00%)

===== align.wast =====
- 48/48 (100.00%)

===== if.wast =====
- 78/123 (63.41%)

===== const.wast =====
- 300/300 (100.00%)

===== f64_cmp.wast =====
- 2400/2400 (100.00%)

===== block.wast =====
- 39/52 (75.00%)

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
- 3/5 (60.00%)

===== loop.wast =====
- 64/77 (83.12%)

===== conversions.wast =====
- 593/593 (100.00%)

===== endianness.wast =====
- 40/68 (58.82%)

===== return.wast =====
- 48/63 (76.19%)

===== store.wast =====
- 0/9 (0.00%)

===== memory_redundancy.wast =====
- 3/4 (75.00%)

===== i32.wast =====
- 374/374 (100.00%)

===== unreachable.wast =====
- 61/63 (96.83%)

===== bulk.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/66 (0.00%)

===== traps.wast =====
- 32/32 (100.00%)

===== local_tee.wast =====
- 38/55 (69.09%)

===== f64_bitwise.wast =====
- 360/360 (100.00%)

===== memory_grow.wast =====
- 64/84 (76.19%)

===== call_indirect.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/132 (0.00%)

===== load.wast =====
- 25/37 (67.57%)

===== memory_fill.wast =====
- Uncaught exception: Direct invocation failed due to Backend_interpreter.Exception.Timeout
- 4/20 (20.00%)

===== memory_size.wast =====
- 20/36 (55.56%)

===== imports.wast =====
- print_i32: 13
- print_i32: 13
- Uncaught exception: Module Instantiation failed due to No frame
- 5/34 (14.71%)

===== left-to-right.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/95 (0.00%)

===== ref_is_null.wast =====
- 10/11 (90.91%)

===== memory_trap.wast =====
- 167/180 (92.78%)

===== br_table.wast =====
- 138/149 (92.62%)

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
- 9/9 (100.00%)

===== f32.wast =====
- 2500/2500 (100.00%)

===== start.wast =====
- 0/7 (0.00%)

===== float_exprs.wast =====
- 792/794 (99.75%)

===== float_memory.wast =====
- 60/60 (100.00%)

===== table_size.wast =====
- 20/36 (55.56%)

===== table_set.wast =====
- 14/18 (77.78%)

===== f32_cmp.wast =====
- 2400/2400 (100.00%)

===== br_if.wast =====
- 62/88 (70.45%)

===== ref_func.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/8 (0.00%)

===== names.wast =====
- print_i32: 42
- 481/482 (99.79%)

===== unreached-valid.wast =====
- 5/5 (100.00%)

===== table_fill.wast =====
- 29/35 (82.86%)

===== data.wast =====
- 14/14 (100.00%)

===== int_literals.wast =====
- 30/30 (100.00%)

===== address.wast =====
- 255/255 (100.00%)

===== table_grow.wast =====
- 35/38 (92.11%)

===== func_ptrs.wast =====
- print_i32: 83
- Uncaught exception: Module Instantiation failed due to No frame
- 3/25 (12.00%)

===== table_init.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/662 (0.00%)

===== global.wast =====
- Uncaught exception: Module Instantiation failed due to No frame
- 0/58 (0.00%)

===== int_exprs.wast =====
- 89/89 (100.00%)

===== f64.wast =====
- 2500/2500 (100.00%)

===== br.wast =====
- 58/76 (76.32%)

===== nop.wast =====
- 65/83 (78.31%)

Total [20163/23778] (84.80%; Normalized 70.43%)
== Complete.
```
