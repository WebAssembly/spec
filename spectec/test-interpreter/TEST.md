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
if (qt = REC_rectype(st^n{st}))
...Animation failed
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
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/28 (0.00%)

===== forward.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/4 (0.00%)

===== float_misc.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/440 (0.00%)

===== table_copy.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/1649 (0.00%)

===== ref_null.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/2 (0.00%)

===== memory.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/45 (0.00%)

===== unwind.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/49 (0.00%)

===== call.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/70 (0.00%)

===== local_get.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/19 (0.00%)

===== fac.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/6 (0.00%)

===== func.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/96 (0.00%)

===== exports.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/9 (0.00%)

===== local_set.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/19 (0.00%)

===== linking.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/90 (0.00%)

===== float_literals.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/83 (0.00%)

===== align.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/48 (0.00%)

===== if.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/123 (0.00%)

===== const.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/300 (0.00%)

===== f64_cmp.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/2400 (0.00%)

===== block.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/52 (0.00%)

===== labels.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/25 (0.00%)

===== switch.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/26 (0.00%)

===== i64.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/384 (0.00%)

===== memory_copy.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/4338 (0.00%)

===== stack.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/5 (0.00%)

===== loop.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/77 (0.00%)

===== conversions.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/593 (0.00%)

===== endianness.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/68 (0.00%)

===== return.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/63 (0.00%)

===== store.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/9 (0.00%)

===== memory_redundancy.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/4 (0.00%)

===== i32.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/374 (0.00%)

===== unreachable.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/63 (0.00%)

===== bulk.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/66 (0.00%)

===== traps.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/32 (0.00%)

===== local_tee.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/55 (0.00%)

===== f64_bitwise.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/360 (0.00%)

===== memory_grow.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/84 (0.00%)

===== call_indirect.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/132 (0.00%)

===== load.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/37 (0.00%)

===== memory_fill.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/20 (0.00%)

===== memory_size.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/36 (0.00%)

===== imports.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/34 (0.00%)

===== left-to-right.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/95 (0.00%)

===== ref_is_null.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/11 (0.00%)

===== memory_trap.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/180 (0.00%)

===== br_table.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/149 (0.00%)

===== select.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/118 (0.00%)

===== f32_bitwise.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/360 (0.00%)

===== memory_init.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/140 (0.00%)

===== elem.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/37 (0.00%)

===== table_get.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/9 (0.00%)

===== f32.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/2500 (0.00%)

===== start.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/7 (0.00%)

===== float_exprs.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/794 (0.00%)

===== float_memory.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/60 (0.00%)

===== table_size.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/36 (0.00%)

===== table_set.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/18 (0.00%)

===== f32_cmp.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/2400 (0.00%)

===== br_if.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/88 (0.00%)

===== ref_func.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/8 (0.00%)

===== names.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/482 (0.00%)

===== unreached-valid.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/5 (0.00%)

===== table_fill.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/35 (0.00%)

===== data.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/14 (0.00%)

===== int_literals.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/30 (0.00%)

===== address.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/255 (0.00%)

===== table_grow.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/38 (0.00%)

===== func_ptrs.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/25 (0.00%)

===== table_init.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/662 (0.00%)

===== global.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/58 (0.00%)

===== int_exprs.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/89 (0.00%)

===== f64.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/2500 (0.00%)

===== br.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/76 (0.00%)

===== nop.wast =====
- Uncaught exception: Module Instantiation failed due to Algorithm not found: instantiation
- 0/83 (0.00%)

Total [0/23779] (0.00%; Normalized 0.00%)
== Complete.
```
