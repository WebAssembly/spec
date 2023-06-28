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
- 24/27 (88.89%)

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
- 20/49 (40.82%)

===== call.wast =====
- 66/70 (94.29%)

===== local_get.wast =====
- 16/19 (84.21%)

===== fac.wast =====
- 2/6 (33.33%)

===== func.wast =====
- 69/96 (71.88%)

===== exports.wast =====
- 9/9 (100.00%)

===== local_set.wast =====
- 16/19 (84.21%)

===== linking.wast =====
- 90/90 (100.00%)

===== float_literals.wast =====
- 83/83 (100.00%)

===== align.wast =====
- 2/48 (4.17%)

===== if.wast =====
- 114/123 (92.68%)

===== const.wast =====
- 300/300 (100.00%)

===== f64_cmp.wast =====
- 2400/2400 (100.00%)

===== block.wast =====
- 46/52 (88.46%)

===== labels.wast =====
- 9/25 (36.00%)

===== switch.wast =====
- 0/26 (0.00%)

===== i64.wast =====
- 384/384 (100.00%)

===== memory_copy.wast =====
- Uncaught exception: Direct invocation failed due to Backend_interpreter.Exception.Timeout
- 4096/4338 (94.42%)

===== stack.wast =====
- 2/5 (40.00%)

===== loop.wast =====
- 36/77 (46.75%)

===== conversions.wast =====
- 593/593 (100.00%)

===== endianness.wast =====
- 68/68 (100.00%)

===== return.wast =====
- 43/63 (68.25%)

===== store.wast =====
- 6/9 (66.67%)

===== memory_redundancy.wast =====
- 4/4 (100.00%)

===== i32.wast =====
- 374/374 (100.00%)

===== unreachable.wast =====
- 62/63 (98.41%)

===== bulk.wast =====
- Uncaught exception: Direct invocation failed due to Backend_interpreter.Exception.Timeout
- 7/66 (10.61%)

===== traps.wast =====
- 32/32 (100.00%)

===== local_tee.wast =====
- 49/55 (89.09%)

===== f64_bitwise.wast =====
- 360/360 (100.00%)

===== memory_grow.wast =====
- 69/84 (82.14%)

===== call_indirect.wast =====
- 124/132 (93.94%)

===== load.wast =====
- 33/37 (89.19%)

===== memory_fill.wast =====
- Uncaught exception: Direct invocation failed due to Backend_interpreter.Exception.Timeout
- 3/20 (15.00%)

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
- 8/149 (5.37%)

===== select.wast =====
- 110/118 (93.22%)

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
- 7/7 (100.00%)

===== float_exprs.wast =====
- Uncaught exception: Direct invocation failed due to Pop some values from empty stack
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
- 15/88 (17.05%)

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
- 35/38 (92.11%)

===== func_ptrs.wast =====
- print_i32: 83
- 25/25 (100.00%)

===== table_init.wast =====
- 662/662 (100.00%)

===== global.wast =====
- 54/58 (93.10%)

===== int_exprs.wast =====
- 89/89 (100.00%)

===== f64.wast =====
- 2500/2500 (100.00%)

===== br.wast =====
- 68/76 (89.47%)

===== nop.wast =====
- 75/83 (90.36%)

Total [22458/23778] (94.45%; Normalized 84.38%)
== Complete.
```
