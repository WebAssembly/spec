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
- 21/28 (75.00%)

===== forward.wast =====
- 4/4 (100.00%)

===== float_misc.wast =====
- 440/440 (100.00%)

===== table_copy.wast =====
- 25/1649 (1.52%)

===== ref_null.wast =====
- 2/2 (100.00%)

===== memory.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/45 (0.00%)

===== unwind.wast =====
- 49/49 (100.00%)

===== call.wast =====
- 61/70 (87.14%)

===== local_get.wast =====
- 13/19 (68.42%)

===== fac.wast =====
- 2/6 (33.33%)

===== func.wast =====
- 69/96 (71.88%)

===== exports.wast =====
- 9/9 (100.00%)

===== local_set.wast =====
- 13/19 (68.42%)

===== linking.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 28/90 (31.11%)

===== float_literals.wast =====
- 21/83 (25.30%)

===== align.wast =====
- 0/48 (0.00%)

===== if.wast =====
- 67/123 (54.47%)

===== const.wast =====
- 300/300 (100.00%)

===== f64_cmp.wast =====
- 2400/2400 (100.00%)

===== block.wast =====
- 29/52 (55.77%)

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
- 25/77 (32.47%)

===== conversions.wast =====
- 0/593 (0.00%)

===== endianness.wast =====
- 0/68 (0.00%)

===== return.wast =====
- 61/63 (96.83%)

===== store.wast =====
- 0/9 (0.00%)

===== memory_redundancy.wast =====
- Uncaught exception: Direct invocation failed due to Invalid_argument("List.fold_right2")
- 0/4 (0.00%)

===== i32.wast =====
- 374/374 (100.00%)

===== unreachable.wast =====
- 61/63 (96.83%)

===== bulk.wast =====
- Uncaught exception: Direct invocation failed due to Invalid_argument("List.fold_right2")
- 0/66 (0.00%)

===== traps.wast =====
- 10/32 (31.25%)

===== local_tee.wast =====
- 34/55 (61.82%)

===== f64_bitwise.wast =====
- 360/360 (100.00%)

===== memory_grow.wast =====
- 0/84 (0.00%)

===== call_indirect.wast =====
- 20/132 (15.15%)

===== load.wast =====
- 0/37 (0.00%)

===== memory_fill.wast =====
- Uncaught exception: Direct invocation failed due to Invalid_argument("List.fold_right2")
- 0/20 (0.00%)

===== memory_size.wast =====
- 0/36 (0.00%)

===== imports.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 7/34 (20.59%)

===== left-to-right.wast =====
- 0/95 (0.00%)

===== ref_is_null.wast =====
- Uncaught exception: Direct invocation failed due to (extern (host 0))
- 2/11 (18.18%)

===== memory_trap.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/180 (0.00%)

===== br_table.wast =====
- 134/149 (89.93%)

===== select.wast =====
- 99/118 (83.90%)

===== f32_bitwise.wast =====
- 360/360 (100.00%)

===== memory_init.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/140 (0.00%)

===== elem.wast =====
- 17/37 (45.95%)

===== table_get.wast =====
- Uncaught exception: Direct invocation failed due to (extern (host 1))
- 0/9 (0.00%)

===== f32.wast =====
- 2500/2500 (100.00%)

===== start.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/7 (0.00%)

===== float_exprs.wast =====
- Uncaught exception: Direct invocation failed due to Invalid_argument("List.fold_right2")
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
- 481/482 (99.79%)

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
- Uncaught exception: Direct invocation failed due to No field name: TYPE

- 3/25 (12.00%)

===== table_init.wast =====
- 18/662 (2.72%)

===== global.wast =====
- 50/58 (86.21%)

===== int_exprs.wast =====
- 86/89 (96.63%)

===== f64.wast =====
- 2500/2500 (100.00%)

===== br.wast =====
- 73/76 (96.05%)

===== nop.wast =====
- 68/83 (81.93%)

Total [14160/23779] (59.55%; Normalized 50.59%)
== Complete.
```
