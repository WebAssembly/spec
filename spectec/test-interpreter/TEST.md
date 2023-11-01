# Preview

```sh
$ (cd ../spec && dune exec ../src/exe-watsup/main.exe -- *.watsup -v -l --sideconditions --animate --interpreter --root "..") 2>/dev/null
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
Animation failed.
if (|ct'*{ct'}| = |y*{y}|)
if (|ct'*{ct'}| = |y'*{y'}*{y'}|)
(if (y < |C.TYPE_context|))*{ct' y y'}
if (|y*{y}| <= 1)
(if (y < x))*{y}
(if ($unrolldt(C.TYPE_context[y]) = SUB_subtype(`FINAL%?`(?()), y'*{y'}, ct')))*{ct' y y'}
Comptype_ok: `%|-%:OK`(C, ct)
(Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}
...Animation failed
Animation failed.
if (|ct'*{ct'}| = |ht*{ht}|)
if (|ct'*{ct'}| = |ht'*{ht'}*{ht'}|)
if (|y*{y}| <= 1)
(if $before(ht, x, i))*{ht}
(if ($unrollht(C, ht) = SUBD_subtype(`FINAL%?`(?()), ht'*{ht'}, ct')))*{ct' ht ht'}
Comptype_ok: `%|-%:OK`(C, ct)
(Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}
...Animation failed
Animation failed.
if ((n_1 <= n_2) /\ (n_2 <= k))
...Animation failed
Animation failed.
Valtype_sub: `%|-%<:%`(C, t, t')
if ((t' = (numtype <: valtype)) \/ (t' = (vectype <: valtype)))
...Animation failed
Animation failed.
Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%*%`(t_1*{t_1}, x_1*{x_1}, t_2*{t_2}))
Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%*%`(t_1*{t_1}, x_2*{x_2}, t_2*{t_2}))
...Animation failed
Animation failed.
(if (l < |C.LABEL_context|))*{l}
if (l' < |C.LABEL_context|)
(Resulttype_sub: `%|-%*<:%*`(C, t*{t}, C.LABEL_context[l]))*{l}
Resulttype_sub: `%|-%*<:%*`(C, t*{t}, C.LABEL_context[l'])
...Animation failed
Animation failed.
if (x < |C.TYPE_context|)
if (y < |C.DATA_context|)
Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, (t <: storagetype))))
if ((t = (numtype <: valtype)) \/ (t = (vectype <: valtype)))
if (C.DATA_context[y] = OK)
...Animation failed
Animation failed.
if (x < |C.TYPE_context|)
Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
...Animation failed
Animation failed.
if (x < |C.TYPE_context|)
if (y < |C.DATA_context|)
Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
if ((t = (numtype <: valtype)) \/ (t = (vectype <: valtype)))
if (C.DATA_context[y] = OK)
...Animation failed
Animation failed.
if (x < |C.MEM_context|)
if ((n?{n} = ?()) <=> (sx?{sx} = ?()))
if (C.MEM_context[x] = mt)
if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
(if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
if ((n?{n} = ?()) \/ (nt = (iN <: numtype)))
...Animation failed
Animation failed.
if (x < |C.MEM_context|)
if (C.MEM_context[x] = mt)
if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
(if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
if ((n?{n} = ?()) \/ (nt = (iN <: numtype)))
...Animation failed
Animation failed.
if (a < |$funcinst(z)|)
Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
...Animation failed
Animation failed.
if (a < |$funcinst(z)|)
Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
...Animation failed
== IL Validation after pass animate...
== Translating to AL...
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== sample.wast =====
- print_i32: 10
- 28/28 (100.00%)

===== forward.wast =====
- 4/4 (100.00%)

===== float_misc.wast =====
- 440/440 (100.00%)

===== table_copy.wast =====
- 1206/1649 (73.14%)

===== ref_null.wast =====
- 2/2 (100.00%)

===== memory.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 2/45 (4.44%)

===== unwind.wast =====
- 49/49 (100.00%)

===== call.wast =====
- 62/70 (88.57%)

===== local_get.wast =====
- 13/19 (68.42%)

===== fac.wast =====
- 3/6 (50.00%)

===== func.wast =====
- 76/96 (79.17%)

===== exports.wast =====
- 9/9 (100.00%)

===== local_set.wast =====
- 13/19 (68.42%)

===== linking.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 41/90 (45.56%)

===== float_literals.wast =====
- 21/83 (25.30%)

===== align.wast =====
- 1/48 (2.08%)

===== if.wast =====
- 94/123 (76.42%)

===== const.wast =====
- 300/300 (100.00%)

===== f64_cmp.wast =====
- 2400/2400 (100.00%)

===== block.wast =====
- 42/52 (80.77%)

===== labels.wast =====
- 17/25 (68.00%)

===== switch.wast =====
- 10/26 (38.46%)

===== i64.wast =====
- 384/384 (100.00%)

===== memory_copy.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/4338 (0.00%)

===== stack.wast =====
- 0/5 (0.00%)

===== loop.wast =====
- 36/77 (46.75%)

===== conversions.wast =====
- 0/593 (0.00%)

===== endianness.wast =====
- 0/68 (0.00%)

===== return.wast =====
- 61/63 (96.83%)

===== store.wast =====
- 0/9 (0.00%)

===== memory_redundancy.wast =====
- Uncaught exception: Direct invocation failed due to Invalid DSL function call: bytes
- 0/4 (0.00%)

===== i32.wast =====
- 374/374 (100.00%)

===== unreachable.wast =====
- 61/63 (96.83%)

===== bulk.wast =====
- Uncaught exception: Direct invocation failed due to Invalid DSL function call: wrap
- 0/66 (0.00%)

===== traps.wast =====
- 24/32 (75.00%)

===== local_tee.wast =====
- 35/55 (63.64%)

===== f64_bitwise.wast =====
- 360/360 (100.00%)

===== memory_grow.wast =====
- 57/84 (67.86%)

===== call_indirect.wast =====
- 32/132 (24.24%)

===== load.wast =====
- 0/37 (0.00%)

===== memory_fill.wast =====
- Uncaught exception: Direct invocation failed due to Invalid DSL function call: wrap
- 0/20 (0.00%)

===== memory_size.wast =====
- 36/36 (100.00%)

===== imports.wast =====
- print_i32: 13
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 12/34 (35.29%)

===== left-to-right.wast =====
- 0/95 (0.00%)

===== ref_is_null.wast =====
- Uncaught exception: Direct invocation failed due to (extern (host 0))
- 2/11 (18.18%)

===== memory_trap.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 11/180 (6.11%)

===== br_table.wast =====
- 134/149 (89.93%)

===== select.wast =====
- 101/118 (85.59%)

===== f32_bitwise.wast =====
- 360/360 (100.00%)

===== memory_init.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/140 (0.00%)

===== elem.wast =====
- 18/37 (48.65%)

===== table_get.wast =====
- Uncaught exception: Direct invocation failed due to (extern (host 1))
- 0/9 (0.00%)

===== f32.wast =====
- 2500/2500 (100.00%)

===== start.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/7 (0.00%)

===== float_exprs.wast =====
- Uncaught exception: Direct invocation failed due to Invalid DSL function call: bytes
- 241/794 (30.35%)

===== float_memory.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/60 (0.00%)

===== table_size.wast =====
- 36/36 (100.00%)

===== table_set.wast =====
- 14/18 (77.78%)

===== f32_cmp.wast =====
- 2400/2400 (100.00%)

===== br_if.wast =====
- 86/88 (97.73%)

===== ref_func.wast =====
- 3/8 (37.50%)

===== names.wast =====
- print_i32: 42
- print_i32: 123
- 482/482 (100.00%)

===== unreached-valid.wast =====
- 5/5 (100.00%)

===== table_fill.wast =====
- 16/35 (45.71%)

===== data.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/14 (0.00%)

===== int_literals.wast =====
- 30/30 (100.00%)

===== address.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/255 (0.00%)

===== table_grow.wast =====
- 22/38 (57.89%)

===== func_ptrs.wast =====
- print_i32: 83
- 9/25 (36.00%)

===== table_init.wast =====
- 582/662 (87.92%)

===== global.wast =====
- 51/58 (87.93%)

===== int_exprs.wast =====
- 86/89 (96.63%)

===== f64.wast =====
- 2500/2500 (100.00%)

===== br.wast =====
- 74/76 (97.37%)

===== nop.wast =====
- 71/83 (85.54%)

Total [16139/23779] (67.87%; Normalized 58.16%)
== Complete.
```
