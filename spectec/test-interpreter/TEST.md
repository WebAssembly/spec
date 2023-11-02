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
- 1649/1649 (100.00%)

===== ref_null.wast =====
- 2/2 (100.00%)

===== memory.wast =====
- 45/45 (100.00%)

===== unwind.wast =====
- 49/49 (100.00%)

===== call.wast =====
- 70/70 (100.00%)

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
- 90/90 (100.00%)

===== float_literals.wast =====
- 83/83 (100.00%)

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
- 4338/4338 (100.00%)

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
- 66/66 (100.00%)

===== traps.wast =====
- 32/32 (100.00%)

===== local_tee.wast =====
- 55/55 (100.00%)

===== f64_bitwise.wast =====
- 360/360 (100.00%)

===== memory_grow.wast =====
- 84/84 (100.00%)

===== call_indirect.wast =====
- 132/132 (100.00%)

===== load.wast =====
- 37/37 (100.00%)

===== memory_fill.wast =====
- 20/20 (100.00%)

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
- 34/34 (100.00%)

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
- 140/140 (100.00%)

===== elem.wast =====
- 37/37 (100.00%)

===== table_get.wast =====
- 9/9 (100.00%)

===== f32.wast =====
- 2500/2500 (100.00%)

===== start.wast =====
- print_i32: 1
- print_i32: 2
- print: ()
- 7/7 (100.00%)

===== float_exprs.wast =====
- 794/794 (100.00%)

===== float_memory.wast =====
- 60/60 (100.00%)

===== table_size.wast =====
- 36/36 (100.00%)

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

===== data.wast =====
- 14/14 (100.00%)

===== int_literals.wast =====
- 30/30 (100.00%)

===== address.wast =====
- 255/255 (100.00%)

===== table_grow.wast =====
- 38/38 (100.00%)

===== func_ptrs.wast =====
- print_i32: 83
- 25/25 (100.00%)

===== table_init.wast =====
- 662/662 (100.00%)

===== global.wast =====
- 58/58 (100.00%)

===== int_exprs.wast =====
- 89/89 (100.00%)

===== f64.wast =====
- 2500/2500 (100.00%)

===== br.wast =====
- 76/76 (100.00%)

===== nop.wast =====
- 83/83 (100.00%)

===== extern.wast =====
- Uncaught exception: Direct invocation failed due to No field name: STRUCT

- 0/16 (0.00%)

===== type-subtyping.wast =====
- 12/20 (60.00%)

===== array.wast =====
- Uncaught exception: Module Instantiation failed due to Failed Array.get during ReplaceE: [][0]
- 0/31 (0.00%)

===== array_init_data.wast =====
- Uncaught exception: Module Instantiation failed due to Failed Array.get during ReplaceE: [][0]
- 0/30 (0.00%)

===== struct.wast =====
- Uncaught exception: Module Instantiation failed due to Failed Array.get during ReplaceE: [][0]
- 0/19 (0.00%)

===== array_init_elem.wast =====
- Uncaught exception: Module Instantiation failed due to Failed Array.get during ReplaceE: [][1]
- 0/19 (0.00%)

===== ref_eq.wast =====
- Uncaught exception: Direct invocation failed due to No field name: STRUCT

- 0/81 (0.00%)

===== br_on_cast_fail.wast =====
- Uncaught exception: Direct invocation failed due to No field name: STRUCT

- 0/25 (0.00%)

===== array_fill.wast =====
- Uncaught exception: Module Instantiation failed due to Failed Array.get during ReplaceE: [][0]
- 0/13 (0.00%)

===== br_on_cast.wast =====
- Uncaught exception: Direct invocation failed due to No field name: STRUCT

- 0/25 (0.00%)

===== i31.wast =====
- 16/20 (80.00%)

===== array_copy.wast =====
- Uncaught exception: Module Instantiation failed due to Failed Array.get during ReplaceE: [][0]
- 0/30 (0.00%)

===== ref_cast.wast =====
- Uncaught exception: Direct invocation failed due to No field name: STRUCT

- 0/40 (0.00%)

===== ref_test.wast =====
- Uncaught exception: Direct invocation failed due to No field name: STRUCT

- 0/66 (0.00%)

Total [23807/24214] (98.32%; Normalized 85.84%)
== Complete.
```
