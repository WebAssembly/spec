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
- 65/70 (92.86%)

===== local_get.wast =====
- 19/19 (100.00%)

===== fac.wast =====
- 6/6 (100.00%)

===== func.wast =====
- 92/96 (95.83%)

===== exports.wast =====
- 9/9 (100.00%)

===== local_set.wast =====
- 19/19 (100.00%)

===== linking.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 41/90 (45.56%)

===== float_literals.wast =====
- 83/83 (100.00%)

===== align.wast =====
- 1/48 (2.08%)

===== if.wast =====
- 112/123 (91.06%)

===== const.wast =====
- 300/300 (100.00%)

===== f64_cmp.wast =====
- 2400/2400 (100.00%)

===== block.wast =====
- 46/52 (88.46%)

===== labels.wast =====
- 25/25 (100.00%)

===== switch.wast =====
- 26/26 (100.00%)

===== i64.wast =====
- 384/384 (100.00%)

===== memory_copy.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/4338 (0.00%)

===== stack.wast =====
- 5/5 (100.00%)

===== loop.wast =====
- 71/77 (92.21%)

===== conversions.wast =====
- 593/593 (100.00%)

===== endianness.wast =====
- 0/68 (0.00%)

===== return.wast =====
- 63/63 (100.00%)

===== store.wast =====
- 0/9 (0.00%)

===== memory_redundancy.wast =====
- Uncaught exception: Direct invocation failed due to Invalid DSL function call: bytes
- 0/4 (0.00%)

===== i32.wast =====
- 374/374 (100.00%)

===== unreachable.wast =====
- 63/63 (100.00%)

===== bulk.wast =====
- Uncaught exception: Direct invocation failed due to Invalid DSL function call: wrap
- 0/66 (0.00%)

===== traps.wast =====
- 32/32 (100.00%)

===== local_tee.wast =====
- 45/55 (81.82%)

===== f64_bitwise.wast =====
- 360/360 (100.00%)

===== memory_grow.wast =====
- 60/84 (71.43%)

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
- print_i32_f32: 14 42
- print_i32: 13
- print_i32: 13
- print_f32: 13
- print_i64: 24
- print_f64_f64: 25 53
- print_i64: 24
- print_f64: 24
- print_f64: 24
- print_i32: 13
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 12/34 (35.29%)

===== left-to-right.wast =====
- 0/95 (0.00%)

===== ref_is_null.wast =====
- 11/11 (100.00%)

===== memory_trap.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 11/180 (6.11%)

===== br_table.wast =====
- 149/149 (100.00%)

===== select.wast =====
- 108/118 (91.53%)

===== f32_bitwise.wast =====
- 360/360 (100.00%)

===== memory_init.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/140 (0.00%)

===== elem.wast =====
- 23/37 (62.16%)

===== table_get.wast =====
- 9/9 (100.00%)

===== f32.wast =====
- 2500/2500 (100.00%)

===== start.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/7 (0.00%)

===== float_exprs.wast =====
- Uncaught exception: Direct invocation failed due to Invalid DSL function call: bytes
- 318/794 (40.05%)

===== float_memory.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/60 (0.00%)

===== table_size.wast =====
- 36/36 (100.00%)

===== table_set.wast =====
- 18/18 (100.00%)

===== f32_cmp.wast =====
- 2400/2400 (100.00%)

===== br_if.wast =====
- 88/88 (100.00%)

===== ref_func.wast =====
- 3/8 (37.50%)

===== names.wast =====
- print_i32: 42
- print_i32: 123
- 482/482 (100.00%)

===== unreached-valid.wast =====
- 5/5 (100.00%)

===== table_fill.wast =====
- 35/35 (100.00%)

===== data.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/14 (0.00%)

===== int_literals.wast =====
- 30/30 (100.00%)

===== address.wast =====
- Uncaught exception: Module Instantiation failed due to Invalid DSL function call: wrap
- 0/255 (0.00%)

===== table_grow.wast =====
- 38/38 (100.00%)

===== func_ptrs.wast =====
- print_i32: 83
- 9/25 (36.00%)

===== table_init.wast =====
- 582/662 (87.92%)

===== global.wast =====
- 53/58 (91.38%)

===== int_exprs.wast =====
- 89/89 (100.00%)

===== f64.wast =====
- 2500/2500 (100.00%)

===== br.wast =====
- 76/76 (100.00%)

===== nop.wast =====
- 71/83 (85.54%)

Total [17109/23779] (71.95%; Normalized 71.15%)
== Complete.
```
