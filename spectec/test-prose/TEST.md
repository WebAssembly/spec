# Preview

```sh
$ (cd ../spec && dune exec ../src/exe-watsup/main.exe -- *.watsup -v -l --sideconditions --animate --prose)
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
Animation failed:if ((ref_1 = REF.NULL_ref(ht_1)) /\ (ref_2 = REF.NULL_ref(ht_2)))
Animation failed:Ref_ok: `%|-%:%`($store(z), ref, rt)
Animation failed:Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))
Animation failed:Ref_ok: `%|-%:%`($store(z), ref, rt)
Animation failed:Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))
Animation failed:if (fi.CODE_funcinst = `FUNC%%*%`(x, LOCAL(t)*{t}, instr*{instr}))
Animation failed:Expand: `%~~%`(fi.TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
Animation failed:if (f = {LOCAL ?(val)^n{val} :: $default(t)*{t}, MODULE fi.MODULE_funcinst})
Animation failed:if (a < |$funcinst(z)|)
Animation failed:Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
Animation failed:if (a < |$funcinst(z)|)
Animation failed:Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
Animation failed:Ref_ok: `%|-%:%`($store(z), ref, rt')
Animation failed:Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))
Animation failed:Ref_ok: `%|-%:%`($store(z), ref, rt')
Animation failed:Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))
Animation failed:if (|mut*{mut}| = |zt*{zt}|)
Animation failed:if (|val*{val}| = |zt*{zt}|)
Animation failed:Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
Animation failed:(if ($default($unpacktype(zt)) = ?(val)))*{val zt}
Animation failed:if (|mut*{mut}| = |zt*{zt}|)
Animation failed:if (i < |zt*{zt}|)
Animation failed:Expand: `%~~%`(si.TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
Animation failed:Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if ($default($unpacktype(zt)) = ?(val))
Animation failed:if (ref^n{ref} = $elem(z, y).ELEM_eleminst[i : n])
Animation failed:Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if ((i + ((n * $storagesize(zt)) / 8)) > |$data(z, y).DATA_datainst|)
Animation failed:Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if (nt = $unpacknumtype(zt))
Animation failed:if ($bytes($storagesize(zt), c)^n{c} = [$data(z, y).DATA_datainst][i : ((n * $storagesize(zt)) / 8)])
Animation failed:Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))
Animation failed:Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
Animation failed:if (sx?{sx} = $sxfield(zt_2))
Animation failed:Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
Animation failed:if (sx?{sx} = $sxfield(zt_2))
Animation failed:Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if ((j + ((n * $storagesize(zt)) / 8)) > |$data(z, y).DATA_datainst|)
Animation failed:Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if (nt = $unpacknumtype(zt))
Animation failed:if ($bytes($storagesize(zt), c) = $data(z, y).DATA_datainst[j : ($storagesize(zt) / 8)])
Animation failed:if ($bytes($size(nt <: valtype), c) = $mem(z, x).DATA_meminst[(i + n_O) : ($size(nt <: valtype) / 8)])
Animation failed:if ($bytes(n, c) = $mem(z, x).DATA_meminst[(i + n_O) : (n / 8)])
Animation failed:Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)^n{mut zt}))
Animation failed:if (si = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val zt}})
Animation failed:if (|mut*{mut}| = |zt*{zt}|)
Animation failed:if (i < |zt*{zt}|)
Animation failed:Expand: `%~~%`($structinst(z)[a].TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
Animation failed:if (fv = $packval(zt*{zt}[i], val))
Animation failed:Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if (ai = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val}})
Animation failed:Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))
Animation failed:if (fv = $packval(zt, val))
== IL Validation after pass animate...
== Prose Generation...
== Complete.
```
