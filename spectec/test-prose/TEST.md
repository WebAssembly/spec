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
if ((ref_1 = REF.NULL_ref(ht_1)) /\ (ref_2 = REF.NULL_ref(ht_2)))
...Animation failed
Animation failed.
Ref_ok: `%|-%:%`(s, ref, rt)
Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype(f.MODULE_frame, rt_2))
...Animation failed
Animation failed.
Ref_ok: `%|-%:%`(s, ref, rt)
Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype(f.MODULE_frame, rt_2))
...Animation failed
Animation failed.
if (a < |$funcinst(z)|)
Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
...Animation failed
Animation failed.
if (a < |$funcinst(z)|)
Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
...Animation failed
Animation failed.
Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
if (nt = $unpacknumtype(zt))
if ($bytes($storagesize(zt), c)^n{c} = [$data(z, y).DATA_datainst][i : ((n * $storagesize(zt)) / 8)])
...Animation failed
Animation failed.
if (module = `MODULE%*%*%*%*%*%*%*%*%?%*`(TYPE(rectype)*{rectype}, import*{import}, func^n_f{func}, GLOBAL(globaltype, expr_g)^n_g{expr_g globaltype}, TABLE(tabletype, expr_t)^n_t{expr_t tabletype}, MEMORY(memtype)^n_m{memtype}, `ELEM%%*%?`(reftype, expr_e*{expr_e}, elemmode?{elemmode})^n_e{elemmode expr_e reftype}, `DATA%*%?`(byte*{byte}, datamode?{datamode})^n_d{byte datamode}, start?{start}, export*{export}))
if (fa_ex*{fa_ex} = $funcsxv(externval*{externval}))
if (ga_ex*{ga_ex} = $globalsxv(externval*{externval}))
if (ta_ex*{ta_ex} = $tablesxv(externval*{externval}))
if (ma_ex*{ma_ex} = $memsxv(externval*{externval}))
if (fa*{fa} = (|s.FUNC_store| + i_f)^(i_f<n_f){i_f})
if (ga*{ga} = (|s.GLOBAL_store| + i_g)^(i_g<n_g){i_g})
if (ta*{ta} = (|s.TABLE_store| + i_t)^(i_t<n_t){i_t})
if (ma*{ma} = (|s.MEM_store| + i_m)^(i_m<n_m){i_m})
if (ea*{ea} = (|s.ELEM_store| + i_e)^(i_e<n_e){i_e})
if (da*{da} = (|s.DATA_store| + i_d)^(i_d<n_d){i_d})
if (xi*{xi} = $instexport(fa_ex*{fa_ex} :: fa*{fa}, ga_ex*{ga_ex} :: ga*{ga}, ta_ex*{ta_ex} :: ta*{ta}, ma_ex*{ma_ex} :: ma*{ma}, export)*{export})
if (mm = {TYPE dt*{dt}, FUNC fa_ex*{fa_ex} :: fa*{fa}, GLOBAL ga_ex*{ga_ex} :: ga*{ga}, TABLE ta_ex*{ta_ex} :: ta*{ta}, MEM ma_ex*{ma_ex} :: ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT xi*{xi}})
if ((s_1, fa*{fa}) = $allocfuncs(s, mm, func^n_f{func}))
if ((s_2, ga*{ga}) = $allocglobals(s_1, globaltype^n_g{globaltype}, val_g*{val_g}))
if ((s_3, ta*{ta}) = $alloctables(s_2, tabletype^n_t{tabletype}, ref_t*{ref_t}))
if ((s_4, ma*{ma}) = $allocmems(s_3, memtype^n_m{memtype}))
if ((s_5, ea*{ea}) = $allocelems(s_4, reftype^n_e{reftype}, ref_e*{ref_e}*{ref_e}))
if ((s_6, da*{da}) = $allocdatas(s_5, byte*{byte}^n_d{byte}))
...Animation failed
...Animation failed
== IL Validation after pass animate...
== Translating to AL...
Warning: No corresponding if for
1. Otherwise:
  a. Push ref to the stack.
Warning: No corresponding if for
1. Otherwise:
  a. Push ref to the stack.
  b. Execute (BR l).
{ LOCAL: ?(val)^n ++ $default(t)*; MODULE: fi.MODULE; }
Invalid premise `Expand: `%~~%`(fi.TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))` to be AL instr.
Invalid premise `Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype(f.MODULE_frame, rt))` to be AL instr.
Warning: No corresponding if for
1. Otherwise:
  a. Push (I32.CONST 0) to the stack.
Invalid premise `Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype(f.MODULE_frame, rt))` to be AL instr.
Warning: No corresponding if for
1. Otherwise:
  a. Trap.
Invalid RulePr: 1. YetI: TODO: We do not support iter on premises other than `RulePr`.
Invalid premise `Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)*{mut zt}))` to be AL instr.
Invalid premise `Expand: `%~~%`(si.TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))` to be AL instr.
Invalid premise `Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))` to be AL instr.
Invalid premise `Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))` to be AL instr.
Invalid premise `Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))` to be AL instr.
Invalid premise `Expand: `%~~%`(ai.TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))` to be AL instr.
Invalid premise `Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))` to be AL instr.
Invalid premise `Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))` to be AL instr.
Invalid premise `Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))` to be AL instr.
Invalid premise `Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))` to be AL instr.
Invalid premise `Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)^n{mut zt}))` to be AL instr.
Invalid premise `Expand: `%~~%`($structinst(z)[a].TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))` to be AL instr.
Invalid premise `Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))` to be AL instr.
Invalid premise `Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))` to be AL instr.
Warning: No corresponding if for
1. Otherwise:
  a. Let ht be fresh_0.
  b. If fresh_1* is ht*, then:
    1) Return ht.
Invalid RulePr: 1. YetI: TODO: We do not support iter on premises other than `RulePr`.
Invalid RulePr: 1. YetI: TODO: We do not support iter on premises other than `RulePr`.
Invalid RulePr: 1. YetI: TODO: We do not support iter on premises other than `RulePr`.
Invalid RulePr: 1. YetI: TODO: We do not support iter on premises other than `RulePr`.
{ LOCAL: []; MODULE: mm; }
{ LOCAL: []; MODULE: mm; }
Invalid premise `Expand: `%~~%`(s.FUNC_store[fa].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2*{t_2})))` to be AL instr.
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2}))))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2}))))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[y], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2}))))
prem_to_instr: Invalid prem 2
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2}))))
prem_to_instr: Invalid prem 2
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2}))))
prem_to_instr: Invalid prem 2
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[y], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2}))))
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(`%%`(mut, zt)*{mut zt})))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(`%%`(mut, zt)*{mut zt})))
prem_to_instr: Invalid prem 3
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(yt*{yt})))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(yt*{yt})))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt))))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt))))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt))))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, (rt <: storagetype)))))
prem_to_instr: Invalid prem 2
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, (t <: storagetype)))))
if_expr_to_instrs: Invalid if_prem (((t = (numtype <: valtype)) \/ (t = (vectype <: valtype))))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt))))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt))))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt))))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x_2], ARRAY_comptype(`%%`(mut, zt_2))))
prem_to_instr: Invalid prem 2
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x_1], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt_1))))
prem_to_instr: Invalid prem 2
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt))))
prem_to_instrs: Invalid prem (Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt))))
if_expr_to_instrs: Invalid if_prem (((t = (numtype <: valtype)) \/ (t = (vectype <: valtype))))
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
=================
 Generated prose
=================
validation_of_UNREACHABLE
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_NOP
- The instruction is valid with type []->[].

validation_of_DROP
- The instruction is valid with type [t]->[].

validation_of_SELECT ?(t)
- The instruction is valid with type [t, t, I32]->[t].

validation_of_BLOCK bt instr*
- Under the context C with .LABEL prepended by [t_2*], instr* must be valid with type YetE (MixE ([[], [Arrow], [Star], []], TupE ([IterE (VarE "t_1", (List, ["t_1"])), IterE (VarE "x", (List, ["x"])), IterE (VarE "t_2", (List, ["t_2"]))]))).
- Under the context C, bt must be valid with type [t_1*]->[t_2*].
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_LOOP bt instr*
- Under the context C with .LABEL prepended by [t_1*], instr* must be valid with type YetE (MixE ([[], [Arrow], [Star], []], TupE ([IterE (VarE "t_1", (List, ["t_1"])), IterE (VarE "x", (List, ["x"])), IterE (VarE "t_2", (List, ["t_2"]))]))).
- Under the context C, bt must be valid with type [t_1*]->[t_2*].
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_IF bt instr_1* instr_2*
- Under the context C with .LABEL prepended by [t_2*], instr_1* must be valid with type YetE (MixE ([[], [Arrow], [Star], []], TupE ([IterE (VarE "t_1", (List, ["t_1"])), IterE (VarE "x_1", (List, ["x_1"])), IterE (VarE "t_2", (List, ["t_2"]))]))).
- Under the context C, bt must be valid with type [t_1*]->[t_2*].
- Under the context C with .LABEL prepended by [t_2*], instr_2* must be valid with type YetE (MixE ([[], [Arrow], [Star], []], TupE ([IterE (VarE "t_1", (List, ["t_1"])), IterE (VarE "x_2", (List, ["x_2"])), IterE (VarE "t_2", (List, ["t_2"]))]))).
- The instruction is valid with type [t_1* ++ [I32]]->[t_2*].

validation_of_BR l
- |C.LABEL| must be greater than l.
- Let t* be C.LABEL[l].
- The instruction is valid with type [t_1* ++ t*]->[t_2*].

validation_of_BR_IF l
- |C.LABEL| must be greater than l.
- Let t* be C.LABEL[l].
- The instruction is valid with type [t* ++ [I32]]->[t*].

validation_of_BR_TABLE l* l'
- For all l in l*,
  - |C.LABEL| must be greater than l.
- |C.LABEL| must be greater than l'.
- For all l in l*,
  - Yet: TODO: prem_to_instrs 2
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [t_1* ++ t*]->[t_2*].

validation_of_BR_ON_NULL l
- |C.LABEL| must be greater than l.
- Under the context C, ht must be valid.
- Let t* be C.LABEL[l].
- The instruction is valid with type [t* ++ [(REF NULL ht)]]->[t* ++ [(REF NULL ht)]].

validation_of_BR_ON_NON_NULL l
- |C.LABEL| must be greater than l.
- Let t* ++ [(REF NULL ht)] be C.LABEL[l].
- Under the context C, ht must be valid.
- The instruction is valid with type [t* ++ [(REF NULL ht)]]->[t*].

validation_of_BR_ON_CAST l rt_1 rt_2
- |C.LABEL| must be greater than l.
- Under the context C, rt_1 must be valid.
- Under the context C, rt_2 must be valid.
- Yet: TODO: prem_to_instrs 2
- Let t* ++ [rt] be C.LABEL[l].
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [t* ++ [rt_1]]->[t* ++ [$diffrt(rt_1, rt_2)]].

validation_of_BR_ON_CAST l rt_1 rt_2
- |C.LABEL| must be greater than l.
- Under the context C, rt_1 must be valid.
- Under the context C, rt_2 must be valid.
- Yet: TODO: prem_to_instrs 2
- Let t* ++ [rt] be C.LABEL[l].
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [t* ++ [rt_1]]->[t* ++ [rt_2]].

validation_of_RETURN
- Let ?(t*) be C.RETURN.
- The instruction is valid with type [t_1* ++ t*]->[t_2*].

validation_of_CALL x
- |C.FUNC| must be greater than x.
- Yet: Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_CALL_REF x
- |C.TYPE| must be greater than x.
- Yet: Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
- The instruction is valid with type [t_1* ++ [(REF NULL $idx(x))]]->[t_2*].

validation_of_CALL_INDIRECT x y
- |C.TABLE| must be greater than x.
- |C.TYPE| must be greater than y.
- Yet: Expand: `%~~%`(C.TYPE_context[y], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
- Let (lim, rt) be C.TABLE[x].
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [t_1* ++ [I32]]->[t_2*].

validation_of_RETURN_CALL x
- |C.FUNC| must be greater than x.
- Yet: Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
- Let ?(t'_2*) be C.RETURN.
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [t_3* ++ t_1*]->[t_4*].

validation_of_RETURN_CALL_REF x
- |C.TYPE| must be greater than x.
- Yet: Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
- Let ?(t'_2*) be C.RETURN.
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [t_3* ++ t_1* ++ [(REF NULL $idx(x))]]->[t_4*].

validation_of_RETURN_CALL_INDIRECT x y
- |C.TABLE| must be greater than x.
- |C.TYPE| must be greater than y.
- Yet: Expand: `%~~%`(C.TYPE_context[y], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
- Let ?(t'_2*) be C.RETURN.
- Let (lim, rt) be C.TABLE[x].
- Yet: TODO: prem_to_instrs 2
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [t_3* ++ t_1* ++ [I32]]->[t_4*].

validation_of_CONST nt c_nt
- The instruction is valid with type []->[nt].

validation_of_UNOP nt unop
- The instruction is valid with type [nt]->[nt].

validation_of_BINOP nt binop
- The instruction is valid with type [nt, nt]->[nt].

validation_of_TESTOP nt testop
- The instruction is valid with type [nt]->[I32].

validation_of_RELOP nt relop
- The instruction is valid with type [nt, nt]->[I32].

validation_of_EXTEND nt n
- n must be less than or equal to $size(nt).
- The instruction is valid with type [nt]->[nt].

validation_of_CVTOP nt_1 REINTERPRET nt_2 ?()
- nt_1 must be different with nt_2.
- $size(nt_1) must be equal to $size(nt_2).
- The instruction is valid with type [nt_2]->[nt_1].

validation_of_CVTOP iN_1 CONVERT iN_2 sx?
- iN_1 must be different with iN_2.
- ($size(iN_1) > $size(iN_2)) and (sx? is ?()) are equivalent.
- The instruction is valid with type [iN_2]->[iN_1].

validation_of_REF.NULL ht
- Under the context C, ht must be valid.
- The instruction is valid with type []->[(REF NULL ht)].

validation_of_REF.FUNC x
- |C.FUNC| must be greater than x.
- Let dt be C.FUNC[x].
- The instruction is valid with type []->[(REF NULL dt)].

validation_of_REF.I31
- The instruction is valid with type [I32]->[(REF NULL I31)].

validation_of_REF.IS_NULL
- The instruction is valid with type [rt]->[I32].

validation_of_REF.AS_NON_NULL
- Under the context C, ht must be valid.
- The instruction is valid with type [(REF NULL ht)]->[(REF NULL ht)].

validation_of_REF.EQ
- The instruction is valid with type [(REF NULL EQ), (REF NULL EQ)]->[I32].

validation_of_REF.TEST rt
- Under the context C, rt must be valid.
- Yet: TODO: prem_to_instrs 2
- Under the context C, rt' must be valid.
- The instruction is valid with type [rt']->[I32].

validation_of_REF.CAST rt
- Under the context C, rt must be valid.
- Yet: TODO: prem_to_instrs 2
- Under the context C, rt' must be valid.
- The instruction is valid with type [rt']->[rt].

validation_of_I31.GET sx
- The instruction is valid with type [(REF NULL I31)]->[I32].

validation_of_STRUCT.NEW x
- |C.TYPE| must be greater than x.
- Yet: Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
- |zt*| must be equal to |mut*|.
- The instruction is valid with type [$unpacktype(zt)*]->[(REF NULL $idx(x))].

validation_of_STRUCT.NEW_DEFAULT x
- |C.TYPE| must be greater than x.
- Yet: Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
- |zt*| must be equal to |mut*|.
- Yet: TODO: prem_to_intrs 3
- |zt*| must be equal to |val*|.
- The instruction is valid with type [$unpacktype(zt)*]->[(REF NULL $idx(x))].

validation_of_STRUCT.GET sx? x i
- |C.TYPE| must be greater than x.
- Yet: Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(yt*{yt}))
- |yt*| must be greater than i.
- Let (mut, zt) be yt*[i].
- (zt is $unpacktype(zt)) and (sx? is ?()) are equivalent.
- The instruction is valid with type [(REF NULL $idx(x))]->[$unpacktype(zt)].

validation_of_STRUCT.SET x i
- |C.TYPE| must be greater than x.
- Yet: Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(yt*{yt}))
- |yt*| must be greater than i.
- Let (YetE (MixE ([[Atom "MUT"], [Quest]], OptE (TupE ([])))), zt) be yt*[i].
- The instruction is valid with type [(REF NULL $idx(x)), $unpacktype(zt)]->[].

validation_of_ARRAY.NEW x
- |C.TYPE| must be greater than x.
- Yet: Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))
- The instruction is valid with type [$unpacktype(zt), I32]->[(REF NULL $idx(x))].

validation_of_ARRAY.NEW_DEFAULT x
- |C.TYPE| must be greater than x.
- Yet: Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))
- Let ?(val) be $default($unpacktype(zt)).
- The instruction is valid with type [I32]->[(REF NULL $idx(x))].

validation_of_ARRAY.NEW_FIXED x n
- |C.TYPE| must be greater than x.
- Yet: Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))
- The instruction is valid with type [$unpacktype(zt)]->[(REF NULL $idx(x))].

validation_of_ARRAY.NEW_ELEM x y
- |C.TYPE| must be greater than x.
- |C.ELEM| must be greater than y.
- Yet: Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, (rt <: storagetype))))
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [I32, I32]->[(REF NULL $idx(x))].

validation_of_ARRAY.NEW_DATA x y
- |C.TYPE| must be greater than x.
- |C.DATA| must be greater than y.
- C.DATA[y] must be equal to OK.
- Yet: Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, (t <: storagetype))))
- Yet: ((t = (numtype <: valtype)) \/ (t = (vectype <: valtype)))
- The instruction is valid with type [I32, I32]->[(REF NULL $idx(x))].

validation_of_ARRAY.GET sx? x
- |C.TYPE| must be greater than x.
- Yet: Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))
- (zt is $unpacktype(zt)) and (sx? is ?()) are equivalent.
- The instruction is valid with type [(REF NULL $idx(x)), I32]->[$unpacktype(zt)].

validation_of_ARRAY.SET x
- |C.TYPE| must be greater than x.
- Yet: Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
- The instruction is valid with type [(REF NULL $idx(x)), I32, $unpacktype(zt)]->[].

validation_of_ARRAY.LEN
- The instruction is valid with type [(REF NULL ARRAY)]->[I32].

validation_of_ARRAY.FILL x
- |C.TYPE| must be greater than x.
- Yet: Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
- The instruction is valid with type [(REF NULL $idx(x)), I32, $unpacktype(zt), I32]->[].

validation_of_ARRAY.COPY x_1 x_2
- |C.TYPE| must be greater than x_1.
- |C.TYPE| must be greater than x_2.
- Yet: Expand: `%~~%`(C.TYPE_context[x_2], ARRAY_comptype(`%%`(mut, zt_2)))
- Yet: TODO: prem_to_instrs 2
- Yet: Expand: `%~~%`(C.TYPE_context[x_1], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt_1)))
- The instruction is valid with type [(REF NULL $idx(x_1)), I32, (REF NULL $idx(x_2)), I32, I32]->[].

validation_of_ARRAY.INIT_ELEM x y
- |C.TYPE| must be greater than x.
- |C.ELEM| must be greater than y.
- Yet: TODO: prem_to_instrs 2
- Yet: Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
- The instruction is valid with type [(REF NULL $idx(x)), I32, I32, I32]->[].

validation_of_ARRAY.INIT_DATA x y
- |C.TYPE| must be greater than x.
- |C.DATA| must be greater than y.
- C.DATA[y] must be equal to OK.
- Yet: Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
- Yet: ((t = (numtype <: valtype)) \/ (t = (vectype <: valtype)))
- The instruction is valid with type [(REF NULL $idx(x)), I32, I32, I32]->[].

validation_of_EXTERN.EXTERNALIZE
- The instruction is valid with type [(REF nul ANY)]->[(REF nul EXTERN)].

validation_of_EXTERN.INTERNALIZE
- The instruction is valid with type [(REF nul EXTERN)]->[(REF nul ANY)].

validation_of_LOCAL.GET x
- |C.LOCAL| must be greater than x.
- Let (init, t) be C.LOCAL[x].
- The instruction is valid with type []->[t].

validation_of_GLOBAL.GET x
- |C.GLOBAL| must be greater than x.
- Let (mut, t) be C.GLOBAL[x].
- The instruction is valid with type []->[t].

validation_of_GLOBAL.SET x
- |C.GLOBAL| must be greater than x.
- Let (YetE (MixE ([[Atom "MUT"], [Quest]], OptE (TupE ([])))), t) be C.GLOBAL[x].
- The instruction is valid with type [t]->[].

validation_of_TABLE.GET x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type [I32]->[rt].

validation_of_TABLE.SET x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type [I32, rt]->[].

validation_of_TABLE.SIZE x
- |C.TABLE| must be greater than x.
- Let tt be C.TABLE[x].
- The instruction is valid with type []->[I32].

validation_of_TABLE.GROW x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type [rt, I32]->[I32].

validation_of_TABLE.FILL x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type [I32, rt, I32]->[].

validation_of_TABLE.COPY x_1 x_2
- |C.TABLE| must be greater than x_1.
- |C.TABLE| must be greater than x_2.
- Let (lim_1, rt_1) be C.TABLE[x_1].
- Let (lim_2, rt_2) be C.TABLE[x_2].
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_TABLE.INIT x y
- |C.TABLE| must be greater than x.
- |C.ELEM| must be greater than y.
- Let rt_2 be C.ELEM[y].
- Let (lim, rt_1) be C.TABLE[x].
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_ELEM.DROP x
- |C.ELEM| must be greater than x.
- Let rt be C.ELEM[x].
- The instruction is valid with type []->[].

validation_of_MEMORY.SIZE x
- |C.MEM| must be greater than x.
- Let mt be C.MEM[x].
- The instruction is valid with type []->[I32].

validation_of_MEMORY.GROW x
- |C.MEM| must be greater than x.
- Let mt be C.MEM[x].
- The instruction is valid with type [I32]->[I32].

validation_of_MEMORY.FILL x
- |C.MEM| must be greater than x.
- Let mt be C.MEM[x].
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_MEMORY.COPY x_1 x_2
- |C.MEM| must be greater than x_1.
- |C.MEM| must be greater than x_2.
- Let mt_1 be C.MEM[x_1].
- Let mt_2 be C.MEM[x_2].
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_MEMORY.INIT x y
- |C.MEM| must be greater than x.
- |C.DATA| must be greater than y.
- C.DATA[y] must be equal to OK.
- Let mt be C.MEM[x].
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_DATA.DROP x
- |C.DATA| must be greater than x.
- C.DATA[x] must be equal to OK.
- The instruction is valid with type []->[].

validation_of_LOAD nt [n, sx]? x n_A n_O
- |C.MEM| must be greater than x.
- (sx? is ?()) and (n? is ?()) are equivalent.
- (2 ^ n_A) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- C.MEM[x] must be equal to mt.
- If n is defined,
  - nt must be equal to iN.
- The instruction is valid with type [I32]->[nt].

validation_of_STORE nt n? x n_A n_O
- |C.MEM| must be greater than x.
- (2 ^ n_A) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- C.MEM[x] must be equal to mt.
- If n is defined,
  - nt must be equal to iN.
- The instruction is valid with type [I32, nt]->[].

Ki
1. Return 1024.

min fresh_0 fresh_1
1. If fresh_0 is 0, then:
  a. Return 0.
2. If fresh_1 is 0, then:
  a. Return 0.
3. Assert: Due to validation, fresh_0 ≥ 1.
4. Let i be (fresh_0 - 1).
5. Assert: Due to validation, fresh_1 ≥ 1.
6. Let j be (fresh_1 - 1).
7. Return $min(i, j).

test_sub_ATOM_22 n_3_ATOM_y
1. Return 0.

curried_ n_1 n_2
1. Return (n_1 + n_2).

setminus1 x fresh_0*
1. If fresh_0* is [], then:
  a. Return [x].
2. Let [y_1] ++ y* be fresh_0*.
3. If x is y_1, then:
  a. Return [].
4. Let [y_1] ++ y* be fresh_0*.
5. Return $setminus1(x, y*).

setminus fresh_0* y*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [x_1] ++ x* be fresh_0*.
3. Return $setminus1(x_1, y*) ++ $setminus(x*, y*).

size fresh_0
1. If fresh_0 is I32, then:
  a. Return 32.
2. If fresh_0 is I64, then:
  a. Return 64.
3. If fresh_0 is F32, then:
  a. Return 32.
4. If fresh_0 is F64, then:
  a. Return 64.
5. If fresh_0 is V128, then:
  a. Return 128.

packedsize fresh_0
1. If fresh_0 is I8, then:
  a. Return 8.
2. Assert: Due to validation, fresh_0 is I16.
3. Return 16.

storagesize fresh_0
1. Let valtype be fresh_0.
2. Return $size(valtype).
3. Let packedtype be fresh_0.
4. Return $packedsize(packedtype).

unpacktype fresh_0
1. Let valtype be fresh_0.
2. Return valtype.
3. Return I32.

unpacknumtype fresh_0
1. Let numtype be fresh_0.
2. Return numtype.
3. Return I32.

sxfield fresh_0
1. Return ?().
2. Return ?(S).

diffrt (REF nul_1 ht_1) (REF NULL ht_2)
1. If fresh_0? is ?([]), then:
  a. Return (REF NULL ht_1).
2. Assert: Due to validation, fresh_0? is not defined.
3. Return (REF nul_1 ht_1).

idx x
1. Return (_IDX x).

subst_typevar xx fresh_0* fresh_1*
1. If fresh_0* is [] and fresh_1* is [], then:
  a. Return xx.
2. Assert: Due to validation, |fresh_1*| ≥ 1.
3. Let [ht_1] ++ ht'* be fresh_1*.
4. If |fresh_0*| < 1, then:
  a. Let [ht_1] ++ ht'* be fresh_1*.
  b. Assert: Due to validation, |fresh_0*| ≥ 1.
  c. Let [xx_1] ++ xx'* be fresh_0*.
  d. Return $subst_typevar(xx, xx'*, ht'*).
5. Else:
  a. Let [xx_1] ++ xx'* be fresh_0*.
  b. If xx is xx_1, then:
    1) Return ht_1.
  c. Let [ht_1] ++ ht'* be fresh_1*.
  d. Assert: Due to validation, |fresh_0*| ≥ 1.
  e. Let [xx_1] ++ xx'* be fresh_0*.
  f. Return $subst_typevar(xx, xx'*, ht'*).

subst_numtype nt xx* ht*
1. Return nt.

subst_vectype vt xx* ht*
1. Return vt.

subst_packedtype pt xx* ht*
1. Return pt.

subst_heaptype fresh_0 xx* fresh_1*
1. Let ht* be fresh_1*.
2. Let xx' be fresh_0.
3. Return $subst_typevar(xx', xx*, ht*).
4. Let dt be fresh_0.
5. Let ht* be fresh_1*.
6. Return $subst_deftype(dt, xx*, ht*).

subst_reftype (REF nul ht) xx* ht*
1. Return (REF nul $subst_heaptype(ht, xx*, ht*)).

subst_valtype fresh_0 xx* ht*
1. Let nt be fresh_0.
2. Return $subst_numtype(nt, xx*, ht*).
3. Let vt be fresh_0.
4. Return $subst_vectype(vt, xx*, ht*).
5. Let rt be fresh_0.
6. Return $subst_reftype(rt, xx*, ht*).
7. Assert: Due to validation, fresh_0 is BOT.
8. Return BOT.

subst_storagetype fresh_0 xx* ht*
1. Let t be fresh_0.
2. Return $subst_valtype(t, xx*, ht*).
3. Let pt be fresh_0.
4. Return $subst_packedtype(pt, xx*, ht*).

subst_fieldtype (mut, zt) xx* ht*
1. Return (mut, $subst_storagetype(zt, xx*, ht*)).

subst_comptype fresh_0 xx* ht*
1. If fresh_0 is of the case STRUCT, then:
  a. Let (STRUCT yt*) be fresh_0.
  b. Return (STRUCT $subst_fieldtype(yt, xx*, ht*)*).
2. If fresh_0 is of the case ARRAY, then:
  a. Let (ARRAY yt) be fresh_0.
  b. Return (ARRAY $subst_fieldtype(yt, xx*, ht*)).
3. Assert: Due to validation, fresh_0 is of the case FUNC.
4. Let (FUNC ft) be fresh_0.
5. Return (FUNC $subst_functype(ft, xx*, ht*)).

subst_subtype fresh_0 xx* ht*
1. If fresh_0 is of the case SUB, then:
  a. Let (SUB fin y* ct) be fresh_0.
  b. Return (SUBD fin $subst_heaptype((_IDX y), xx*, ht*)* $subst_comptype(ct, xx*, ht*)).
2. Assert: Due to validation, fresh_0 is of the case SUBD.
3. Let (SUBD fin ht'* ct) be fresh_0.
4. Return (SUBD fin $subst_heaptype(ht', xx*, ht*)* $subst_comptype(ct, xx*, ht*)).

subst_rectype (REC st*) xx* ht*
1. Return (REC $subst_subtype(st, xx*, ht*)*).

subst_deftype (DEF qt i) xx* ht*
1. Return (DEF $subst_rectype(qt, xx*, ht*) i).

subst_functype [t_1*]->[t_2*] xx* ht*
1. Return [$subst_valtype(t_1, xx*, ht*)*]->[$subst_valtype(t_2, xx*, ht*)*].

subst_globaltype (mut, t) xx* ht*
1. Return (mut, $subst_valtype(t, xx*, ht*)).

subst_tabletype (lim, rt) xx* ht*
1. Return (lim, $subst_reftype(rt, xx*, ht*)).

subst_memtype (I8 lim) xx* ht*
1. Return (I8 lim).

subst_externtype fresh_0 xx* ht*
1. If fresh_0 is of the case FUNC, then:
  a. Let (FUNC dt) be fresh_0.
  b. Return (FUNC $subst_deftype(dt, xx*, ht*)).
2. If fresh_0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be fresh_0.
  b. Return (GLOBAL $subst_globaltype(gt, xx*, ht*)).
3. If fresh_0 is of the case TABLE, then:
  a. Let (TABLE tt) be fresh_0.
  b. Return (TABLE $subst_tabletype(tt, xx*, ht*)).
4. Assert: Due to validation, fresh_0 is of the case MEM.
5. Let (MEM mt) be fresh_0.
6. Return (MEM $subst_memtype(mt, xx*, ht*)).

subst_all_reftype rt ht^n
1. Return $subst_reftype(rt, $idx(x)^(x<n), ht^n).

subst_all_deftype dt ht^n
1. Return $subst_deftype(dt, $idx(x)^(x<n), ht^n).

rollrt x (REC st^n)
1. Return (REC $subst_subtype(st, $idx((x + i))^(i<n), (REC i)^(i<n))^n).

unrollrt (REC st^n)
1. Return (REC $subst_subtype(st, (REC i)^(i<n), (DEF qt i)^(i<n))^n).

rolldt x qt
1. Assert: Due to validation, $rollrt(x, qt) is of the case REC.
2. Let (REC st^n) be $rollrt(x, qt).
3. Return (DEF (REC st^n) i)^(i<n).

unrolldt (DEF qt i)
1. Assert: Due to validation, $unrollrt(qt) is of the case REC.
2. Let (REC st*) be $unrollrt(qt).
3. Return st*[i].

expanddt dt
1. Assert: Due to validation, $unrolldt(dt) is of the case SUBD.
2. Let (SUBD fin ht* ct) be $unrolldt(dt).
3. Return ct.

funcsxt fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [y_0] ++ et* be fresh_0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC dt) be y_0.
  b. Return [dt] ++ $funcsxt(et*).
4. Let [externtype] ++ et* be fresh_0*.
5. Return $funcsxt(et*).

globalsxt fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [y_0] ++ et* be fresh_0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be y_0.
  b. Return [gt] ++ $globalsxt(et*).
4. Let [externtype] ++ et* be fresh_0*.
5. Return $globalsxt(et*).

tablesxt fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [y_0] ++ et* be fresh_0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE tt) be y_0.
  b. Return [tt] ++ $tablesxt(et*).
4. Let [externtype] ++ et* be fresh_0*.
5. Return $tablesxt(et*).

memsxt fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [y_0] ++ et* be fresh_0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM mt) be y_0.
  b. Return [mt] ++ $memsxt(et*).
4. Let [externtype] ++ et* be fresh_0*.
5. Return $memsxt(et*).

inst_reftype mm rt
1. Let dt* be mm.TYPE.
2. Return $subst_all_reftype(rt, dt*).

default fresh_0
1. If fresh_0 is I32, then:
  a. Return ?((I32.CONST 0)).
2. If fresh_0 is I64, then:
  a. Return ?((I64.CONST 0)).
3. If fresh_0 is F32, then:
  a. Return ?((F32.CONST 0)).
4. If fresh_0 is F64, then:
  a. Return ?((F64.CONST 0)).
5. Assert: Due to validation, fresh_0 is of the case REF.
6. Let (REF y_0 ht) be fresh_0.
7. Assert: Due to validation, y_0 is NULL.
8. Return ?((REF.NULL ht)).
9. Return ?().

packval fresh_0 fresh_1
1. Let val be fresh_1.
2. Return val.
3. Assert: Due to validation, fresh_1 is of the case CONST.
4. Let (y_0.CONST i) be fresh_1.
5. Assert: Due to validation, y_0 is I32.
6. Let pt be fresh_0.
7. Return (PACK pt $wrap(32, $packedsize(pt), i)).

unpackval fresh_0 fresh_1? fresh_2
1. If fresh_1? is not defined, then:
  a. Let val be fresh_2.
  b. Return val.
2. Let ?(sx) be fresh_1?.
3. Assert: Due to validation, fresh_2 is of the case PACK.
4. Let (PACK pt i) be fresh_2.
5. Assert: Due to validation, fresh_0 is pt.
6. Return (I32.CONST $ext($packedsize(pt), 32, sx, i)).

funcsxv fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [y_0] ++ xv* be fresh_0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcsxv(xv*).
4. Let [externval] ++ xv* be fresh_0*.
5. Return $funcsxv(xv*).

globalsxv fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [y_0] ++ xv* be fresh_0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globalsxv(xv*).
4. Let [externval] ++ xv* be fresh_0*.
5. Return $globalsxv(xv*).

tablesxv fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [y_0] ++ xv* be fresh_0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tablesxv(xv*).
4. Let [externval] ++ xv* be fresh_0*.
5. Return $tablesxv(xv*).

memsxv fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [y_0] ++ xv* be fresh_0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $memsxv(xv*).
4. Let [externval] ++ xv* be fresh_0*.
5. Return $memsxv(xv*).

funcaddr
1. Let f be the current frame.
2. Return f.MODULE.FUNC.

funcinst
1. Return s.FUNC.

globalinst
1. Return s.GLOBAL.

tableinst
1. Return s.TABLE.

meminst
1. Return s.MEM.

eleminst
1. Return s.ELEM.

datainst
1. Return s.DATA.

structinst
1. Return s.STRUCT.

arrayinst
1. Return s.ARRAY.

type x
1. Let f be the current frame.
2. Return f.MODULE.TYPE[x].

func x
1. Let f be the current frame.
2. Return s.FUNC[f.MODULE.FUNC[x]].

global x
1. Let f be the current frame.
2. Return s.GLOBAL[f.MODULE.GLOBAL[x]].

table x
1. Let f be the current frame.
2. Return s.TABLE[f.MODULE.TABLE[x]].

mem x
1. Let f be the current frame.
2. Return s.MEM[f.MODULE.MEM[x]].

elem x
1. Let f be the current frame.
2. Return s.ELEM[f.MODULE.ELEM[x]].

data x
1. Let f be the current frame.
2. Return s.DATA[f.MODULE.DATA[x]].

local x
1. Let f be the current frame.
2. Return f.LOCAL[x].

with_local x v
1. Let f be the current frame.
2. Replace f.LOCAL[x] with ?(v).

with_global x v
1. Let f be the current frame.
2. Replace s.GLOBAL[f.MODULE.GLOBAL[x]].VALUE with v.

with_table x i r
1. Let f be the current frame.
2. Replace s.TABLE[f.MODULE.TABLE[x]].ELEM[i] with r.

with_tableinst x ti
1. Let f be the current frame.
2. Replace s.TABLE[f.MODULE.TABLE[x]] with ti.

with_mem x i j b*
1. Let f be the current frame.
2. Replace s.MEM[f.MODULE.MEM[x]].DATA[i : j] with b*.

with_meminst x mi
1. Let f be the current frame.
2. Replace s.MEM[f.MODULE.MEM[x]] with mi.

with_elem x r*
1. Let f be the current frame.
2. Replace s.ELEM[f.MODULE.ELEM[x]].ELEM with r*.

with_data x b*
1. Let f be the current frame.
2. Replace s.DATA[f.MODULE.DATA[x]].DATA with b*.

with_struct a i fv
1. Replace s.STRUCT[a].FIELD[i] with fv.

with_array a i fv
1. Replace s.ARRAY[a].FIELD[i] with fv.

ext_structinst si*
1. Let f be the current frame.
2. Return (s with .STRUCT appended by si*, f).

ext_arrayinst ai*
1. Let f be the current frame.
2. Return (s with .ARRAY appended by ai*, f).

growtable ti n r
1. Let { TYPE: ((i, j), rt); ELEM: r'*; } be ti.
2. If (i + n) ≤ j, then:
  a. Let tt' be (((i + n), j), rt).
  b. Return { TYPE: tt'; ELEM: r'* ++ r^n; }.

growmemory mi n
1. Let { TYPE: (I8 (i, j)); DATA: b*; } be mi.
2. If (i + n) ≤ j, then:
  a. Let mt' be (I8 ((i + n), j)).
  b. Return { TYPE: mt'; DATA: b* ++ 0^((n · 64) · $Ki()); }.

with_locals C fresh_0* fresh_1*
1. If fresh_0* is [] and fresh_1* is [], then:
  a. Return C.
2. Assert: Due to validation, |fresh_1*| ≥ 1.
3. Let [lt_1] ++ lt* be fresh_1*.
4. Assert: Due to validation, |fresh_0*| ≥ 1.
5. Let [x_1] ++ x* be fresh_0*.
6. Return $with_locals(C with .LOCAL[x_1] replaced by lt_1, x*, lt*).

clostypes fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let dt* ++ [dt_N] be fresh_0*.
3. Let dt'* be $clostypes(dt*).
4. Return dt'* ++ [$subst_all_deftype(dt_N, dt'*)].

clostype C dt
1. Let dt'* be $clostypes(C.TYPE).
2. Return $subst_all_deftype(dt, dt'*).

before fresh_0 x i
1. Return YetE (BoolE true).
2. If fresh_0 is of the case _IDX, then:
  a. Return YetE (CmpE (VarE "typeidx", LtOp, VarE "x")).
3. Assert: Due to validation, fresh_0 is of the case REC.
4. Return YetE (CmpE (VarE "j", LtOp, VarE "i")).

unrollht C fresh_0
1. Let deftype be fresh_0.
2. Return $unrolldt(deftype).
3. If fresh_0 is of the case _IDX, then:
  a. Let (_IDX typeidx) be fresh_0.
  b. Return $unrolldt(C.TYPE[typeidx]).
4. Assert: Due to validation, fresh_0 is of the case REC.
5. Let (REC i) be fresh_0.
6. Return C.REC[i].

in_binop binop fresh_0*
1. If fresh_0* is [], then:
  a. Return YetE (BoolE false).
2. Let [binopIXX_1] ++ binopIXX'* be fresh_0*.
3. Return (YetE (CmpE (VarE "binop", EqOp, CaseE (Atom "_I", VarE "binopIXX_1"))) + $in_binop(binop, binopIXX'*)).

in_numtype nt fresh_0*
1. If fresh_0* is [], then:
  a. Return YetE (BoolE false).
2. Let [nt_1] ++ nt'* be fresh_0*.
3. Return (YetE (CmpE (VarE "nt", EqOp, VarE "nt_1")) + $in_numtype(nt, nt'*)).

allocfunc mm func
1. Assert: Due to validation, func is of the case FUNC.
2. Let (FUNC x local* expr) be func.
3. Let fi be { TYPE: mm.TYPE[x]; MODULE: mm; CODE: func; }.
4. Return [s with .FUNC appended by [fi], |s.FUNC|].

allocfuncs mm fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [func] ++ func'* be fresh_0*.
3. Let fa be $allocfunc(mm, func).
4. Let fa'* be $allocfuncs(mm, func'*).
5. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let gi be { TYPE: globaltype; VALUE: val; }.
2. Return [s with .GLOBAL appended by [gi], |s.GLOBAL|].

allocglobals fresh_0* fresh_1*
1. If fresh_0* is [], then:
  a. Assert: Due to validation, fresh_1* is [].
  b. Return [].
2. Else:
  a. Let [globaltype] ++ globaltype'* be fresh_0*.
  b. Assert: Due to validation, |fresh_1*| ≥ 1.
  c. Let [val] ++ val'* be fresh_1*.
  d. Let ga be $allocglobal(globaltype, val).
  e. Let ga'* be $allocglobals(globaltype'*, val'*).
  f. Return [ga] ++ ga'*.

alloctable ((i, j), rt) ref
1. Let ti be { TYPE: ((i, j), rt); ELEM: ref^i; }.
2. Return [s with .TABLE appended by [ti], |s.TABLE|].

alloctables fresh_0* fresh_1*
1. If fresh_0* is [] and fresh_1* is [], then:
  a. Return [].
2. Assert: Due to validation, |fresh_1*| ≥ 1.
3. Let [ref] ++ ref'* be fresh_1*.
4. Assert: Due to validation, |fresh_0*| ≥ 1.
5. Let [tabletype] ++ tabletype'* be fresh_0*.
6. Let ta be $alloctable(tabletype, ref).
7. Let ta'* be $alloctables(tabletype'*, ref'*).
8. Return [ta] ++ ta'*.

allocmem (I8 (i, j))
1. Let mi be { TYPE: (I8 (i, j)); DATA: 0^((i · 64) · $Ki()); }.
2. Return [s with .MEM appended by [mi], |s.MEM|].

allocmems fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [memtype] ++ memtype'* be fresh_0*.
3. Let ma be $allocmem(memtype).
4. Let ma'* be $allocmems(memtype'*).
5. Return [ma] ++ ma'*.

allocelem rt ref*
1. Let ei be { TYPE: rt; ELEM: ref*; }.
2. Return [s with .ELEM appended by [ei], |s.ELEM|].

allocelems fresh_0* fresh_1*
1. If fresh_0* is [] and fresh_1* is [], then:
  a. Return [].
2. Assert: Due to validation, |fresh_1*| ≥ 1.
3. Let [ref*] ++ ref'** be fresh_1*.
4. Assert: Due to validation, |fresh_0*| ≥ 1.
5. Let [rt] ++ rt'* be fresh_0*.
6. Let ea be $allocelem(rt, ref*).
7. Let ea'* be $allocelems(rt'*, ref'**).
8. Return [ea] ++ ea'*.

allocdata byte*
1. Let di be { DATA: byte*; }.
2. Return [s with .DATA appended by [di], |s.DATA|].

allocdatas fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [byte*] ++ byte'** be fresh_0*.
3. Let da be $allocdata(byte*).
4. Let da'* be $allocdatas(byte'**).
5. Return [da] ++ da'*.

instexport fa* ga* ta* ma* (EXPORT name fresh_0)
1. If fresh_0 is of the case FUNC, then:
  a. Let (FUNC x) be fresh_0.
  b. Return { NAME: name; VALUE: (FUNC fa*[x]); }.
2. If fresh_0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be fresh_0.
  b. Return { NAME: name; VALUE: (GLOBAL ga*[x]); }.
3. If fresh_0 is of the case TABLE, then:
  a. Let (TABLE x) be fresh_0.
  b. Return { NAME: name; VALUE: (TABLE ta*[x]); }.
4. Assert: Due to validation, fresh_0 is of the case MEM.
5. Let (MEM x) be fresh_0.
6. Return { NAME: name; VALUE: (MEM ma*[x]); }.

allocmodule module externval* val_g* ref_t* ref_e**
1. Return mm.

concat_instr fresh_0*
1. If fresh_0* is [], then:
  a. Return [].
2. Let [instr*] ++ instr'** be fresh_0*.
3. Return instr* ++ $concat_instr(instr'**).

runelem (ELEM reftype expr* fresh_0?) y
1. If fresh_0? is not defined, then:
  a. Return [].
2. If fresh_0? is ?(DECLARE), then:
  a. Return [(ELEM.DROP y)].
3. Assert: Due to validation, fresh_0? is defined.
4. Let ?(y_0) be fresh_0?.
5. Assert: Due to validation, y_0 is of the case TABLE.
6. Let (TABLE x instr*) be y_0.
7. Return instr* ++ [(I32.CONST 0), (I32.CONST |expr*|), (TABLE.INIT x y), (ELEM.DROP y)].

rundata (DATA byte* fresh_0?) y
1. If fresh_0? is not defined, then:
  a. Return [].
2. Let ?(y_0) be fresh_0?.
3. Assert: Due to validation, y_0 is of the case MEMORY.
4. Let (MEMORY x instr*) be y_0.
5. Return instr* ++ [(I32.CONST 0), (I32.CONST |byte*|), (MEMORY.INIT x y), (DATA.DROP y)].

instantiate module externval*
1. YetI: TODO: We do not support iter on premises other than `RulePr`.
2. YetI: TODO: We do not support iter on premises other than `RulePr`.
3. YetI: TODO: We do not support iter on premises other than `RulePr`.
4. Return YetE (MixE ([[], [Semicolon], [Star]], TupE ([MixE ([[], [Semicolon], []], TupE ([VarE "s'", VarE "f"])), CatE (IterE (SubE (VarE "instr_e", VarT "instr", VarT "admininstr"), (List, ["instr_e"])), CatE (IterE (SubE (VarE "instr_d", VarT "instr", VarT "admininstr"), (List, ["instr_d"])), IterE (CaseE (Atom "CALL", VarE "x"), (Opt, ["x"]))))]))).

invoke fa val^n
1. Let mm be { TYPE: [s.FUNC[fa].TYPE]; FUNC: []; GLOBAL: []; TABLE: []; MEM: []; ELEM: []; DATA: []; EXPORT: []; }.
2. YetI: Expand: `%~~%`(s.FUNC_store[fa].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2*{t_2}))).
3. Let f be { LOCAL: []; MODULE: mm; }.
4. Assert: Due to validation, $funcinst()[fa].CODE is of the case FUNC.
5. Return YetE (MixE ([[], [Semicolon], [Star]], TupE ([MixE ([[], [Semicolon], []], TupE ([VarE "s", VarE "f"])), CatE (IterE (SubE (VarE "val", VarT "val", VarT "admininstr"), (ListN (VarE "n"), ["val"])), ListE ([CaseE (Atom "REF.FUNC_ADDR", VarE "fa"), CaseE (Atom "CALL_REF", NatE 0)]))]))).

execution_of_UNREACHABLE
1. Trap.

execution_of_NOP
1. Do nothing.

execution_of_DROP
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.

execution_of_SELECT t?
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val_2 from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop val_1 from the stack.
7. If c is not 0, then:
  a. Push val_1 to the stack.
8. Else:
  a. Push val_2 to the stack.

execution_of_BLOCK bt instr*
1. Let [t_1^k]->[t_2^n] be bt.
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. Let L be the label_n{[]}.
5. Enter L with label instr* ++ [LABEL_]:
  a. Push val^k to the stack.

execution_of_LOOP bt instr*
1. Let [t_1^k]->[t_2^n] be bt.
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. Let L be the label_k{[(LOOP bt instr*)]}.
5. Enter L with label instr* ++ [LABEL_]:
  a. Push val^k to the stack.

execution_of_IF bt instr_1* instr_2*
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If c is not 0, then:
  a. Execute (BLOCK bt instr_1*).
4. Else:
  a. Execute (BLOCK bt instr_2*).

execution_of_LABEL_
1. Pop all values val* from the stack.
2. Assert: Due to validation, a label is now on the top of the stack.
3. Exit current context.
4. Push val* to the stack.

execution_of_BR fresh_0
1. Let L be the current label.
2. Let n be the arity of L.
3. Let instr'* be the continuation of L.
4. Pop all values fresh_1* from the stack.
5. Exit current context.
6. If fresh_0 is 0 and |fresh_1*| ≥ n, then:
  a. Let val'* ++ val^n be fresh_1*.
  b. Push val^n to the stack.
  c. Execute the sequence (instr'*).
7. If fresh_0 ≥ 1, then:
  a. Let l be (fresh_0 - 1).
  b. Let val* be fresh_1*.
  c. Push val* to the stack.
  d. Execute (BR l).

execution_of_BR_IF l
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If c is not 0, then:
  a. Execute (BR l).
4. Else:
  a. Do nothing.

execution_of_BR_TABLE l* l'
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If i < |l*|, then:
  a. Execute (BR l*[i]).
4. Else:
  a. Execute (BR l').

execution_of_CALL_INDIRECT x y
1. Execute (TABLE.GET x).
2. Execute (REF.CAST (REF NULL $idx(y))).
3. Execute (CALL_REF y).

execution_of_RETURN_CALL_INDIRECT x y
1. Execute (TABLE.GET x).
2. Execute (REF.CAST (REF NULL $idx(y))).
3. Execute (RETURN_CALL_REF y).

execution_of_FRAME_
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop val^n from the stack.
5. Assert: Due to validation, a frame is now on the top of the stack.
6. Exit current context.
7. Push val^n to the stack.

execution_of_RETURN
1. If the current context is frame, then:
  a. Let F be the current frame.
  b. Let n be the arity of F.
  c. Pop val^n from the stack.
  d. Pop all values val'* from the stack.
  e. Exit current context.
  f. Push val^n to the stack.
2. Else if the current context is label, then:
  a. Pop all values val* from the stack.
  b. Exit current context.
  c. Push val* to the stack.
  d. Execute RETURN.

execution_of_UNOP nt unop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_1) from the stack.
3. If |$unop(unop, nt, c_1)| is 1, then:
  a. Let [c] be $unop(unop, nt, c_1).
  b. Push (nt.CONST c) to the stack.
4. If $unop(unop, nt, c_1) is [], then:
  a. Trap.

execution_of_BINOP nt binop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop (nt.CONST c_1) from the stack.
5. If |$binop(binop, nt, c_1, c_2)| is 1, then:
  a. Let [c] be $binop(binop, nt, c_1, c_2).
  b. Push (nt.CONST c) to the stack.
6. If $binop(binop, nt, c_1, c_2) is [], then:
  a. Trap.

execution_of_TESTOP nt testop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_1) from the stack.
3. Let c be $testop(testop, nt, c_1).
4. Push (I32.CONST c) to the stack.

execution_of_RELOP nt relop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop (nt.CONST c_1) from the stack.
5. Let c be $relop(relop, nt, c_1, c_2).
6. Push (I32.CONST c) to the stack.

execution_of_EXTEND nt n
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Push (nt.CONST $ext(n, $size(nt), S, c)) to the stack.

execution_of_CVTOP nt_2 cvtop nt_1 sx?
1. Assert: Due to validation, a value of value type nt_1 is on the top of the stack.
2. Pop (nt_1.CONST c_1) from the stack.
3. If |$cvtop(cvtop, nt_1, nt_2, sx?, c_1)| is 1, then:
  a. Let [c] be $cvtop(cvtop, nt_1, nt_2, sx?, c_1).
  b. Push (nt_2.CONST c) to the stack.
4. If $cvtop(cvtop, nt_1, nt_2, sx?, c_1) is [], then:
  a. Trap.

execution_of_REF.I31
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. Execute (REF.I31_NUM $wrap(32, 31, i)).

execution_of_REF.IS_NULL
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. If val is not of the case REF.NULL, then:
  a. Push (I32.CONST 0) to the stack.
4. Else:
  a. Push (I32.CONST 1) to the stack.

execution_of_REF.AS_NON_NULL
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. If ref is of the case REF.NULL, then:
  a. Trap.
4. Push ref to the stack.

execution_of_REF.EQ
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref_2 from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop ref_1 from the stack.
5. Push (I32.CONST 1) to the stack.
6. If ref_1 is ref_2, then:
  a. Push (I32.CONST 1) to the stack.
7. Else:
  a. Push (I32.CONST 0) to the stack.

execution_of_I31.GET sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop fresh_0 from the stack.
3. If fresh_0 is of the case REF.NULL, then:
  a. Trap.
4. If fresh_0 is of the case REF.I31_NUM, then:
  a. Let (REF.I31_NUM i) be fresh_0.
  b. Push (I32.CONST $ext(31, 32, sx, i)) to the stack.

execution_of_EXTERN.EXTERNALIZE
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop fresh_0 from the stack.
3. If fresh_0 is of the case REF.NULL, then:
  a. Execute (REF.NULL EXTERN).
4. Let addrref be fresh_0.
5. Execute (REF.EXTERN addrref).

execution_of_EXTERN.INTERNALIZE
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop fresh_0 from the stack.
3. If fresh_0 is of the case REF.NULL, then:
  a. Execute (REF.NULL ANY).
4. If fresh_0 is of the case REF.EXTERN, then:
  a. Let (REF.EXTERN addrref) be fresh_0.
  b. Push addrref to the stack.

execution_of_LOCAL.TEE x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Push val to the stack.
4. Push val to the stack.
5. Execute (LOCAL.SET x).

execution_of_BR_ON_CAST l rt_1 rt_2
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. Push ref to the stack.
4. Execute (BR l).

execution_of_BR_ON_CAST_FAIL l rt_1 rt_2
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. Push ref to the stack.

execution_of_CALL x
1. Assert: Due to validation, x < |$funcaddr()|.
2. Execute (CALL_REF $funcaddr()[x]).

execution_of_CALL_REF
1. YetI: TODO: It is likely that the value stack of two rules are differ.

execution_of_RETURN_CALL x
1. Assert: Due to validation, x < |$funcaddr()|.
2. Execute (RETURN_CALL_REF $funcaddr()[x]).

execution_of_RETURN_CALL_REF
1. If the current context is frame, then:
  a. Pop ref from the stack.
  b. Pop val^n from the stack.
  c. Pop all values val'* from the stack.
  d. Exit current context.
  e. Push val^n to the stack.
  f. Push ref to the stack.
  g. Execute (CALL_REF x).
2. Else if the current context is label, then:
  a. Pop ref from the stack.
  b. Pop val^n from the stack.
  c. Pop all values val'* from the stack.
  d. Exit current context.
  e. Push val^n to the stack.
  f. Push ref to the stack.
  g. Execute (RETURN_CALL_REF x).

execution_of_REF.FUNC x
1. Assert: Due to validation, x < |$funcaddr()|.
2. Push (REF.FUNC_ADDR $funcaddr()[x]) to the stack.

execution_of_REF.TEST rt
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. YetI: TODO: prem_to_instr: Unsupported rule prem.

execution_of_REF.CAST rt
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. YetI: TODO: prem_to_instr: Unsupported rule prem.

execution_of_STRUCT.NEW_DEFAULT x
1. YetI: Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)*{mut zt})).
2. Assert: Due to validation, |mut*| is |zt*|.
3. YetI: TODO: We do not support iter on premises other than `RulePr`.
4. Assert: Due to validation, |val*| is |zt*|.
5. Push val* to the stack.
6. Execute (STRUCT.NEW x).

execution_of_STRUCT.GET sx? x i
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop fresh_0 from the stack.
3. If fresh_0 is of the case REF.NULL, then:
  a. Trap.
4. If fresh_0 is of the case REF.STRUCT_ADDR, then:
  a. Let (REF.STRUCT_ADDR a) be fresh_0.
  b. If a < |$structinst()|, then:
    1) Let si be $structinst()[a].
    2) If i < |si.FIELD|, then:
      a) YetI: Expand: `%~~%`(si.TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt})).
      b) If |mut*| is |zt*| and i < |zt*|, then:
        1. Push $unpackval(zt*[i], sx?, si.FIELD[i]) to the stack.

execution_of_ARRAY.NEW x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Push val^n to the stack.
6. Execute (ARRAY.NEW_FIXED x n).

execution_of_ARRAY.NEW_DEFAULT x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. YetI: Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt))).
4. Assert: Due to validation, $default($unpacktype(zt)) is defined.
5. Let ?(val) be $default($unpacktype(zt)).
6. Push val^n to the stack.
7. Execute (ARRAY.NEW_FIXED x n).

execution_of_ARRAY.NEW_ELEM x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If (i + n) > |$elem(y).ELEM|, then:
  a. Trap.
6. Let ref^n be $elem(y).ELEM[i : n].
7. Push ref^n to the stack.
8. Execute (ARRAY.NEW_FIXED x n).

execution_of_ARRAY.NEW_DATA x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. YetI: Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt))).
6. If (i + ((n · $storagesize(zt)) / 8)) > |$data(y).DATA|, then:
  a. Trap.
7. Let $bytes($storagesize(zt), c)^n be [$data(y).DATA][i : ((n · $storagesize(zt)) / 8)].
8. YetI: Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt))).
9. If nt is $unpacknumtype(zt), then:
  a. Push (nt.CONST c)^n to the stack.
  b. Execute (ARRAY.NEW_FIXED x n).

execution_of_ARRAY.GET sx? x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop fresh_0 from the stack.
5. If fresh_0 is of the case REF.NULL, then:
  a. Trap.
6. If fresh_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be fresh_0.
  b. If a < |$arrayinst()|, then:
    1) Let ai be $arrayinst()[a].
    2) If i < |ai.FIELD|, then:
      a) YetI: Expand: `%~~%`(ai.TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt))).
      b) Push $unpackval(zt, sx?, ai.FIELD[i]) to the stack.

execution_of_ARRAY.LEN
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop fresh_0 from the stack.
3. If fresh_0 is of the case REF.NULL, then:
  a. Trap.
4. If fresh_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be fresh_0.
  b. If a < |$arrayinst()|, then:
    1) Let n be |$arrayinst()[a].FIELD|.
    2) Push (I32.CONST n) to the stack.

execution_of_ARRAY.FILL x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST fresh_1) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. Assert: Due to validation, a value is on the top of the stack.
8. Pop fresh_0 from the stack.
9. If fresh_0 is of the case REF.NULL, then:
  a. Trap.
10. If fresh_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be fresh_0.
  b. Let n be fresh_1.
  c. If a < |$arrayinst()| and (i + n) > |$arrayinst()[a].FIELD|, then:
    1) Trap.
11. Otherwise:
  a. If fresh_1 is 0 and fresh_0 is of the case REF.ARRAY_ADDR, then:
    1) Let (REF.ARRAY_ADDR a) be fresh_0.
12. If fresh_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be fresh_0.
  b. If fresh_1 ≥ 1, then:
    1) Let n be (fresh_1 - 1).
    2) Execute (REF.ARRAY_ADDR a).
    3) Push (I32.CONST i) to the stack.
    4) Push val to the stack.
    5) Execute (ARRAY.SET x).
    6) Execute (REF.ARRAY_ADDR a).
    7) Push (I32.CONST (i + 1)) to the stack.
    8) Push val to the stack.
    9) Push (I32.CONST n) to the stack.
    10) Execute (ARRAY.FILL x).

execution_of_ARRAY.COPY x_1 x_2
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST fresh_2) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i_2) from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop fresh_1 from the stack.
7. Assert: Due to validation, a value of value type I32 is on the top of the stack.
8. Pop (I32.CONST i_1) from the stack.
9. Assert: Due to validation, a value is on the top of the stack.
10. Pop fresh_0 from the stack.
11. If fresh_0 is of the case REF.NULL, then:
  a. Trap.
12. If fresh_1 is of the case REF.NULL, then:
  a. Trap.
13. If fresh_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a_1) be fresh_0.
  b. If fresh_1 is of the case REF.ARRAY_ADDR, then:
    1) Let (REF.ARRAY_ADDR a_2) be fresh_1.
    2) Let n be fresh_2.
    3) If a_1 < |$arrayinst()| and (i_1 + n) > |$arrayinst()[a_1].FIELD|, then:
      a) Trap.
    4) If a_2 < |$arrayinst()| and (i_2 + n) > |$arrayinst()[a_2].FIELD|, then:
      a) Trap.
14. Otherwise:
  a. If fresh_2 is 0 and fresh_0 is of the case REF.ARRAY_ADDR, then:
    1) Let (REF.ARRAY_ADDR a_1) be fresh_0.
    2) If fresh_1 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a_2) be fresh_1.
15. If fresh_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a_1) be fresh_0.
  b. If fresh_1 is of the case REF.ARRAY_ADDR, then:
    1) Let (REF.ARRAY_ADDR a_2) be fresh_1.
    2) If fresh_2 ≥ 1, then:
      a) Let n be (fresh_2 - 1).
      b) If i_1 ≤ i_2, then:
        1. YetI: Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2))).
        2. Let sx? be $sxfield(zt_2).
        3. Execute (REF.ARRAY_ADDR a_1).
        4. Push (I32.CONST i_1) to the stack.
        5. Execute (REF.ARRAY_ADDR a_2).
        6. Push (I32.CONST i_2) to the stack.
        7. Execute (ARRAY.GET sx? x).
        8. Execute (ARRAY.SET x).
        9. Execute (REF.ARRAY_ADDR a_1).
        10. Push (I32.CONST (i_1 + 1)) to the stack.
        11. Execute (REF.ARRAY_ADDR a_2).
        12. Push (I32.CONST (i_2 + 1)) to the stack.
      c) Else:
        1. YetI: Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2))).
        2. Let sx? be $sxfield(zt_2).
        3. Execute (REF.ARRAY_ADDR a_1).
        4. Push (I32.CONST (i_1 + n)) to the stack.
        5. Execute (REF.ARRAY_ADDR a_2).
        6. Push (I32.CONST (i_2 + n)) to the stack.
        7. Execute (ARRAY.GET sx? x).
        8. Execute (ARRAY.SET x).
        9. Execute (REF.ARRAY_ADDR a_1).
        10. Push (I32.CONST i_1) to the stack.
        11. Execute (REF.ARRAY_ADDR a_2).
        12. Push (I32.CONST i_2) to the stack.
      d) Push (I32.CONST n) to the stack.
      e) Execute (ARRAY.COPY x_1 x_2).

execution_of_ARRAY.INIT_ELEM x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST fresh_1) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST j) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. Assert: Due to validation, a value is on the top of the stack.
8. Pop fresh_0 from the stack.
9. If fresh_0 is of the case REF.NULL, then:
  a. Trap.
10. If fresh_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be fresh_0.
  b. Let n be fresh_1.
  c. If a < |$arrayinst()| and (i + n) > |$arrayinst()[a].FIELD|, then:
    1) Trap.
11. If fresh_0 is not of the case REF.ARRAY_ADDR, then:
  a. If fresh_1 is 0 and fresh_0 is of the case REF.ARRAY_ADDR, then:
    1) Let (REF.ARRAY_ADDR a) be fresh_0.
    2) If fresh_1 ≥ 1, then:
      a) Let n be (fresh_1 - 1).
      b) If j < |$elem(y).ELEM|, then:
        1. Let ref be $elem(y).ELEM[j].
        2. Execute (REF.ARRAY_ADDR a).
        3. Push (I32.CONST i) to the stack.
        4. Push ref to the stack.
        5. Execute (ARRAY.SET x).
        6. Execute (REF.ARRAY_ADDR a).
        7. Push (I32.CONST (i + 1)) to the stack.
        8. Push (I32.CONST (j + 1)) to the stack.
        9. Push (I32.CONST n) to the stack.
        10. Execute (ARRAY.INIT_ELEM x y).
12. Else:
  a. Let n be fresh_1.
  b. If (j + n) > |$elem(y).ELEM|, then:
    1) Trap.
  c. If fresh_1 is 0, then:
  d. Else:
    1) Let (REF.ARRAY_ADDR a) be fresh_0.
    2) If fresh_1 ≥ 1, then:
      a) Let n be (fresh_1 - 1).
      b) If j < |$elem(y).ELEM|, then:
        1. Let ref be $elem(y).ELEM[j].
        2. Execute (REF.ARRAY_ADDR a).
        3. Push (I32.CONST i) to the stack.
        4. Push ref to the stack.
        5. Execute (ARRAY.SET x).
        6. Execute (REF.ARRAY_ADDR a).
        7. Push (I32.CONST (i + 1)) to the stack.
        8. Push (I32.CONST (j + 1)) to the stack.
        9. Push (I32.CONST n) to the stack.
        10. Execute (ARRAY.INIT_ELEM x y).

execution_of_ARRAY.INIT_DATA x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST fresh_1) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST j) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. Assert: Due to validation, a value is on the top of the stack.
8. Pop fresh_0 from the stack.
9. If fresh_0 is of the case REF.NULL, then:
  a. Trap.
10. If fresh_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be fresh_0.
  b. Let n be fresh_1.
  c. If a < |$arrayinst()| and (i + n) > |$arrayinst()[a].FIELD|, then:
    1) Trap.
11. If fresh_0 is not of the case REF.ARRAY_ADDR, then:
  a. If fresh_1 is 0 and fresh_0 is of the case REF.ARRAY_ADDR, then:
    1) Let (REF.ARRAY_ADDR a) be fresh_0.
    2) If fresh_1 ≥ 1, then:
      a) Let n be (fresh_1 - 1).
      b) YetI: Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt))).
      c) Let c be $inverse_of_bytes($storagesize(zt), $data(y).DATA[j : ($storagesize(zt) / 8)]).
      d) Let nt be $unpacknumtype(zt).
      e) Execute (REF.ARRAY_ADDR a).
      f) Push (I32.CONST i) to the stack.
      g) Push (nt.CONST c) to the stack.
      h) Execute (ARRAY.SET x).
      i) Execute (REF.ARRAY_ADDR a).
      j) Push (I32.CONST (i + 1)) to the stack.
      k) Push (I32.CONST (j + 1)) to the stack.
      l) Push (I32.CONST n) to the stack.
      m) Execute (ARRAY.INIT_DATA x y).
12. Else:
  a. Let n be fresh_1.
  b. YetI: Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt))).
  c. If (j + ((n · $storagesize(zt)) / 8)) > |$data(y).DATA|, then:
    1) Trap.
  d. If fresh_1 is 0, then:
  e. Else:
    1) Let (REF.ARRAY_ADDR a) be fresh_0.
    2) If fresh_1 ≥ 1, then:
      a) Let n be (fresh_1 - 1).
      b) YetI: Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt))).
      c) Let c be $inverse_of_bytes($storagesize(zt), $data(y).DATA[j : ($storagesize(zt) / 8)]).
      d) Let nt be $unpacknumtype(zt).
      e) Execute (REF.ARRAY_ADDR a).
      f) Push (I32.CONST i) to the stack.
      g) Push (nt.CONST c) to the stack.
      h) Execute (ARRAY.SET x).
      i) Execute (REF.ARRAY_ADDR a).
      j) Push (I32.CONST (i + 1)) to the stack.
      k) Push (I32.CONST (j + 1)) to the stack.
      l) Push (I32.CONST n) to the stack.
      m) Execute (ARRAY.INIT_DATA x y).

execution_of_LOCAL.GET x
1. Assert: Due to validation, $local(x) is defined.
2. Let ?(val) be $local(x).
3. Push val to the stack.

execution_of_GLOBAL.GET x
1. Push $global(x).VALUE to the stack.

execution_of_TABLE.GET x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If i ≥ |$table(x).ELEM|, then:
  a. Trap.
4. Push $table(x).ELEM[i] to the stack.

execution_of_TABLE.SIZE x
1. Let n be |$table(x).ELEM|.
2. Push (I32.CONST n) to the stack.

execution_of_TABLE.FILL x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. If (i + n) > |$table(x).ELEM|, then:
  a. Trap.
8. If n is 0, then:
  a. Do nothing.
9. Else:
  a. Push (I32.CONST i) to the stack.
  b. Push val to the stack.
  c. Execute (TABLE.SET x).
  d. Push (I32.CONST (i + 1)) to the stack.
  e. Push val to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (TABLE.FILL x).

execution_of_TABLE.COPY x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$table(y).ELEM| or (j + n) > |$table(x).ELEM|, then:
  a. Trap.
8. If n is 0, then:
  a. Do nothing.
9. Else:
  a. If j ≤ i, then:
    1) Push (I32.CONST j) to the stack.
    2) Push (I32.CONST i) to the stack.
    3) Execute (TABLE.GET y).
    4) Execute (TABLE.SET x).
    5) Push (I32.CONST (j + 1)) to the stack.
    6) Push (I32.CONST (i + 1)) to the stack.
  b. Else:
    1) Push (I32.CONST ((j + n) - 1)) to the stack.
    2) Push (I32.CONST ((i + n) - 1)) to the stack.
    3) Execute (TABLE.GET y).
    4) Execute (TABLE.SET x).
    5) Push (I32.CONST j) to the stack.
    6) Push (I32.CONST i) to the stack.
  c. Push (I32.CONST (n - 1)) to the stack.
  d. Execute (TABLE.COPY x y).

execution_of_TABLE.INIT x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$elem(y).ELEM| or (j + n) > |$table(x).ELEM|, then:
  a. Trap.
8. If n is 0, then:
  a. Do nothing.
9. Else if i < |$elem(y).ELEM|, then:
  a. Push (I32.CONST j) to the stack.
  b. Push $elem(y).ELEM[i] to the stack.
  c. Execute (TABLE.SET x).
  d. Push (I32.CONST (j + 1)) to the stack.
  e. Push (I32.CONST (i + 1)) to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (TABLE.INIT x y).

execution_of_LOAD nt fresh_0? x n_A n_O
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If fresh_0? is not defined, then:
  a. If ((i + n_O) + ($size(nt) / 8)) > |$mem(x).DATA|, then:
    1) Trap.
  b. Let c be $inverse_of_bytes($size(nt), $mem(x).DATA[(i + n_O) : ($size(nt) / 8)]).
  c. Push (nt.CONST c) to the stack.
4. Else:
  a. Let ?(y_0) be fresh_0?.
  b. Let [n, sx] be y_0.
  c. If ((i + n_O) + (n / 8)) > |$mem(x).DATA|, then:
    1) Trap.
  d. Let c be $inverse_of_bytes(n, $mem(x).DATA[(i + n_O) : (n / 8)]).
  e. Push (nt.CONST $ext(n, $size(nt), sx, c)) to the stack.

execution_of_MEMORY.SIZE x
1. Let ((n · 64) · $Ki()) be |$mem(x).DATA|.
2. Push (I32.CONST n) to the stack.

execution_of_MEMORY.FILL x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. If (i + n) > |$mem(x).DATA|, then:
  a. Trap.
8. If n is 0, then:
  a. Do nothing.
9. Else:
  a. Push (I32.CONST i) to the stack.
  b. Push val to the stack.
  c. Execute (STORE I32 ?(8) x 0 0).
  d. Push (I32.CONST (i + 1)) to the stack.
  e. Push val to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (MEMORY.FILL x).

execution_of_MEMORY.COPY x_1 x_2
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i_2) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i_1) from the stack.
7. If (i_1 + n) > |$mem(x_1).DATA| or (i_2 + n) > |$mem(x_2).DATA|, then:
  a. Trap.
8. If n is 0, then:
  a. Do nothing.
9. Else:
  a. If i_1 ≤ i_2, then:
    1) Push (I32.CONST i_1) to the stack.
    2) Push (I32.CONST i_2) to the stack.
    3) Execute (LOAD I32 ?([8, U]) x_2 0 0).
    4) Execute (STORE I32 ?(8) x_1 0 0).
    5) Push (I32.CONST (i_1 + 1)) to the stack.
    6) Push (I32.CONST (i_2 + 1)) to the stack.
  b. Else:
    1) Push (I32.CONST ((i_1 + n) - 1)) to the stack.
    2) Push (I32.CONST ((i_2 + n) - 1)) to the stack.
    3) Execute (LOAD I32 ?([8, U]) x_2 0 0).
    4) Execute (STORE I32 ?(8) x_1 0 0).
    5) Push (I32.CONST i_1) to the stack.
    6) Push (I32.CONST i_2) to the stack.
  c. Push (I32.CONST (n - 1)) to the stack.
  d. Execute (MEMORY.COPY x_1 x_2).

execution_of_MEMORY.INIT x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$data(y).DATA| or (j + n) > |$mem(x).DATA|, then:
  a. Trap.
8. If n is 0, then:
  a. Do nothing.
9. Else if i < |$data(y).DATA|, then:
  a. Push (I32.CONST j) to the stack.
  b. Push (I32.CONST $data(y).DATA[i]) to the stack.
  c. Execute (STORE I32 ?(8) x 0 0).
  d. Push (I32.CONST (j + 1)) to the stack.
  e. Push (I32.CONST (i + 1)) to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (MEMORY.INIT x y).

execution_of_STRUCT.NEW x
1. YetI: Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)^n{mut zt})).
2. Let si be { TYPE: $type(x); FIELD: $packval(zt, val)^n; }.
3. Execute (REF.STRUCT_ADDR |$structinst()|).
4. Perform $ext_structinst([si]).

execution_of_STRUCT.SET x i
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop fresh_0 from the stack.
5. If fresh_0 is of the case REF.NULL, then:
  a. Trap.
6. If fresh_0 is of the case REF.STRUCT_ADDR, then:
  a. Let (REF.STRUCT_ADDR a) be fresh_0.
  b. If a < |$structinst()|, then:
    1) YetI: Expand: `%~~%`($structinst(z)[a].TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt})).
    2) If |mut*| is |zt*| and i < |zt*|, then:
      a) Let fv be $packval(zt*[i], val).
      b) Perform $with_struct(a, i, fv).

execution_of_ARRAY.NEW_FIXED x n
1. YetI: Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt))).
2. Let ai be { TYPE: $type(x); FIELD: $packval(zt, val)^n; }.
3. Execute (REF.ARRAY_ADDR |$arrayinst()|).
4. Perform $ext_arrayinst([ai]).

execution_of_ARRAY.SET x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop fresh_0 from the stack.
5. If fresh_0 is of the case REF.NULL, then:
  a. Trap.
6. If fresh_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be fresh_0.
  b. If a < |$arrayinst()|, then:
    1) YetI: Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt))).
    2) Let fv be $packval(zt, val).
    3) Perform $with_array(a, i, fv).

execution_of_LOCAL.SET x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Perform $with_local(x, val).

execution_of_GLOBAL.SET x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Perform $with_global(x, val).

execution_of_TABLE.SET x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If i ≥ |$table(x).ELEM|, then:
  a. Trap.
6. Perform $with_table(x, i, ref).

execution_of_TABLE.GROW x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop ref from the stack.
5. Either:
  a. Let ti be $growtable($table(x), n, ref).
  b. Push (I32.CONST |$table(x).ELEM|) to the stack.
  c. Perform $with_tableinst(x, ti).
6. Or:
  a. Push (I32.CONST -1) to the stack.

execution_of_ELEM.DROP x
1. Perform $with_elem(x, []).

execution_of_STORE nt fresh_0? x n_A n_O
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If fresh_0? is not defined, then:
  a. If ((i + n_O) + ($size(nt) / 8)) > |$mem(x).DATA|, then:
    1) Trap.
  b. Let b* be $bytes($size(nt), c).
  c. Perform $with_mem(x, (i + n_O), ($size(nt) / 8), b*).
6. Else:
  a. Let ?(n) be fresh_0?.
  b. If ((i + n_O) + (n / 8)) > |$mem(x).DATA|, then:
    1) Trap.
  c. Let b* be $bytes(n, $wrap($size(nt), n, c)).
  d. Perform $with_mem(x, (i + n_O), (n / 8), b*).

execution_of_MEMORY.GROW x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Either:
  a. Let mi be $growmemory($mem(x), n).
  b. Push (I32.CONST (|$mem(0).DATA| / (64 · $Ki()))) to the stack.
  c. Perform $with_meminst(x, mi).
4. Or:
  a. Push (I32.CONST -1) to the stack.

execution_of_DATA.DROP x
1. Perform $with_data(x, []).

exec_expr_const instr*
1. Execute the sequence (instr*).
2. Pop val from the stack.
3. Return val.

== Complete.
```
