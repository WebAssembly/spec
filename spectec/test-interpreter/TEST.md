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
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/27 (0.00%)

===== forward.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/4 (0.00%)

===== float_misc.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/440 (0.00%)

===== table_copy.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/1649 (0.00%)

===== ref_null.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/2 (0.00%)

===== memory.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/45 (0.00%)

===== unwind.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/49 (0.00%)

===== call.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/70 (0.00%)

===== local_get.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/19 (0.00%)

===== fac.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/6 (0.00%)

===== func.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/96 (0.00%)

===== exports.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/9 (0.00%)

===== local_set.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/19 (0.00%)

===== linking.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/90 (0.00%)

===== float_literals.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/83 (0.00%)

===== align.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/48 (0.00%)

===== if.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/123 (0.00%)

===== const.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/300 (0.00%)

===== f64_cmp.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/2400 (0.00%)

===== block.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/52 (0.00%)

===== labels.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/25 (0.00%)

===== switch.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/26 (0.00%)

===== i64.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/384 (0.00%)

===== memory_copy.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/4338 (0.00%)

===== stack.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/5 (0.00%)

===== loop.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/77 (0.00%)

===== conversions.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/593 (0.00%)

===== endianness.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/68 (0.00%)

===== return.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/63 (0.00%)

===== store.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/9 (0.00%)

===== memory_redundancy.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/4 (0.00%)

===== i32.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/374 (0.00%)

===== unreachable.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/63 (0.00%)

===== bulk.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/66 (0.00%)

===== traps.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/32 (0.00%)

===== local_tee.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/55 (0.00%)

===== f64_bitwise.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/360 (0.00%)

===== memory_grow.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/84 (0.00%)

===== call_indirect.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/132 (0.00%)

===== load.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/37 (0.00%)

===== memory_fill.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/20 (0.00%)

===== memory_size.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/36 (0.00%)

===== imports.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/34 (0.00%)

===== left-to-right.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/95 (0.00%)

===== ref_is_null.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/11 (0.00%)

===== memory_trap.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/180 (0.00%)

===== br_table.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/149 (0.00%)

===== select.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/118 (0.00%)

===== f32_bitwise.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/360 (0.00%)

===== memory_init.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/140 (0.00%)

===== elem.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/37 (0.00%)

===== table_get.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/9 (0.00%)

===== f32.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/2500 (0.00%)

===== start.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/7 (0.00%)

===== float_exprs.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/794 (0.00%)

===== float_memory.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/60 (0.00%)

===== table_size.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/36 (0.00%)

===== table_set.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/18 (0.00%)

===== f32_cmp.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/2400 (0.00%)

===== br_if.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/88 (0.00%)

===== ref_func.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/8 (0.00%)

===== names.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/482 (0.00%)

===== unreached-valid.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/5 (0.00%)

===== table_fill.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/35 (0.00%)

===== data.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/14 (0.00%)

===== int_literals.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/30 (0.00%)

===== address.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/255 (0.00%)

===== table_grow.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/38 (0.00%)

===== func_ptrs.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/25 (0.00%)

===== table_init.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/662 (0.00%)

===== global.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/58 (0.00%)

===== int_exprs.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/89 (0.00%)

===== f64.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/2500 (0.00%)

===== br.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/76 (0.00%)

===== nop.wast =====
- Uncaught exception: Module Instantiation failed due to TODO: interp_for
- 0/83 (0.00%)

Total [0/23778] (0.00%; Normalized 0.00%)
== Complete.
```
