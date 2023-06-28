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
Animation failed:
  Valtype_sub: `|-%<:%`(t, t')
  if ((t' = (numtype <: valtype)) \/ (t' = (vectype <: valtype)))
Animation failed:
  (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
  Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])
Animation failed: if (C.TABLE_context[x_2] = `%%`(lim_2, rt))
Animation failed:
  if ((n?{n} = ?()) \/ (nt = (in <: numtype)))
Animation failed:
  if ((n?{n} = ?()) \/ (nt = (in <: numtype)))
Animation failed: if (functype = `%->%`(valtype*{valtype}, valtype'*{valtype'}))
Animation failed: if ($funcinst(`%;%`(s, f))[fa].CODE_funcinst = `FUNC%%*%`(functype, valtype*{valtype}, expr))
Animation failed: if (functype = `%->%`(valtype*{valtype}, valtype'*{valtype'}))
== IL Validation...
== Translating to AL...
Animation failed: if (_x1*{_x1} = (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val})
== Initializing AL interprter with generated AL...
== Interpreting AL...
===== sample.wast =====
- 22/27 (81.48%)

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
- 8/49 (16.33%)

===== call.wast =====
- 64/70 (91.43%)

===== local_get.wast =====
- 15/19 (78.95%)

===== fac.wast =====
- 2/6 (33.33%)

===== func.wast =====
- 52/96 (54.17%)

===== exports.wast =====
- 6/9 (66.67%)

===== local_set.wast =====
- 15/19 (78.95%)

===== linking.wast =====
- 90/90 (100.00%)

===== float_literals.wast =====
- 83/83 (100.00%)

===== align.wast =====
- 2/48 (4.17%)

===== if.wast =====
- 92/123 (74.80%)

===== const.wast =====
- 300/300 (100.00%)

===== f64_cmp.wast =====
- 2400/2400 (100.00%)

===== block.wast =====
- 37/52 (71.15%)

===== labels.wast =====
- 3/25 (12.00%)

===== switch.wast =====
- 0/26 (0.00%)

===== i64.wast =====
- 384/384 (100.00%)

===== memory_copy.wast =====
- 4099/4338 (94.49%)

===== stack.wast =====
- 2/5 (40.00%)

===== loop.wast =====
- 34/77 (44.16%)

===== conversions.wast =====
- 593/593 (100.00%)

===== endianness.wast =====
- 68/68 (100.00%)

===== return.wast =====
- 10/63 (15.87%)

===== store.wast =====
- 5/9 (55.56%)

===== memory_redundancy.wast =====
- 4/4 (100.00%)

===== i32.wast =====
- 374/374 (100.00%)

===== unreachable.wast =====
- 61/63 (96.83%)

===== bulk.wast =====
- 66/66 (100.00%)

===== traps.wast =====
- 32/32 (100.00%)

===== local_tee.wast =====
- 47/55 (85.45%)

===== f64_bitwise.wast =====
- 360/360 (100.00%)

===== memory_grow.wast =====
- 67/84 (79.76%)

===== call_indirect.wast =====
- 126/132 (95.45%)

===== load.wast =====
- 31/37 (83.78%)

===== memory_fill.wast =====
- 6/20 (30.00%)

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
- 94/95 (98.95%)

===== ref_is_null.wast =====
- 11/11 (100.00%)

===== memory_trap.wast =====
- 179/180 (99.44%)

===== br_table.wast =====
- 2/149 (1.34%)

===== select.wast =====
- 107/118 (90.68%)

===== f32_bitwise.wast =====
- 360/360 (100.00%)

===== memory_init.wast =====
- 134/140 (95.71%)

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
- 1/7 (14.29%)

===== float_exprs.wast =====
- Uncaught exception: Direct invocation failed due to Not_found
- 322/794 (40.55%)

===== float_memory.wast =====
- 60/60 (100.00%)

===== table_size.wast =====
- 36/36 (100.00%)

===== table_set.wast =====
- 18/18 (100.00%)

===== f32_cmp.wast =====
- 2400/2400 (100.00%)

===== br_if.wast =====
- 12/88 (13.64%)

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
- 8/30 (26.67%)

===== address.wast =====
- 255/255 (100.00%)

===== table_grow.wast =====
- 35/38 (92.11%)

===== func_ptrs.wast =====
- print_i32: 83
- 25/25 (100.00%)

===== table_init.wast =====
- 662/662 (100.00%)

===== global.wast =====
- 52/58 (89.66%)

===== int_exprs.wast =====
- 89/89 (100.00%)

===== f64.wast =====
- 2500/2500 (100.00%)

===== br.wast =====
- 2/76 (2.63%)

===== nop.wast =====
- 72/83 (86.75%)

Total [22296/23778] (93.77%; Normalized 79.16%)
== Complete.
```
