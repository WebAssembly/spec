# Preview

```sh
$ (cd ../spec/wasm-3.0 && dune exec ../../src/exe-watsup/main.exe -- *.watsup -v -l --sideconditions --animate --prose)
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
Animation failed (binding inference).
if (|ct'*{ct'}| = |y*{y}|)
if (|ct'*{ct'}| = |y'*{y'}*{y'}|)
(if (y < |C.TYPE_context|))*{ct' y y'}
if (|y*{y}| <= 1)
(if (y < x))*{y}
(if ($unrolldt(C.TYPE_context[y]) = SUB_subtype(`FINAL%?`(?()), y'*{y'}, ct')))*{ct' y y'}
Comptype_ok: `%|-%:OK`(C, ct)
(Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}
...Animation failed (reorder)
if (|ct'*{ct'}| = |y*{y}|)
if (|ct'*{ct'}| = |y'*{y'}*{y'}|)
(if (y < |C.TYPE_context|))*{ct' y y'}
if (|y*{y}| <= 1)
(if (y < x))*{y}
(if ($unrolldt(C.TYPE_context[y]) = SUB_subtype(`FINAL%?`(?()), y'*{y'}, ct')))*{ct' y y'}
Comptype_ok: `%|-%:OK`(C, ct)
(Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}
Animation failed (binding inference).
if (|ct'*{ct'}| = |ht*{ht}|)
if (|ct'*{ct'}| = |ht'*{ht'}*{ht'}|)
if (|ht*{ht}| <= 1)
(if $before(ht, x, i))*{ht}
(if ($unrollht(C, ht) = SUBD_subtype(`FINAL%?`(?()), ht'*{ht'}, ct')))*{ct' ht ht'}
Comptype_ok: `%|-%:OK`(C, ct)
(Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}
...Animation failed (reorder)
if (|ct'*{ct'}| = |ht*{ht}|)
if (|ct'*{ct'}| = |ht'*{ht'}*{ht'}|)
if (|ht*{ht}| <= 1)
(if $before(ht, x, i))*{ht}
(if ($unrollht(C, ht) = SUBD_subtype(`FINAL%?`(?()), ht'*{ht'}, ct')))*{ct' ht ht'}
Comptype_ok: `%|-%:OK`(C, ct)
(Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}
Animation failed (binding inference).
if ((n_1 <= n_2) /\ (n_2 <= k))
...Animation failed (reorder)
if (n_1 <= n_2)
if (n_2 <= k)
Animation failed (binding inference).
Valtype_sub: `%|-%<:%`(C, t, t')
if (t' = (numtype <: valtype))
...Animation failed (reorder)
Valtype_sub: `%|-%<:%`(C, t, t')
if (t' = (numtype <: valtype))
Animation failed (binding inference).
Valtype_sub: `%|-%<:%`(C, t, t')
if (t' = (vectype <: valtype))
...Animation failed (reorder)
Valtype_sub: `%|-%<:%`(C, t, t')
if (t' = (vectype <: valtype))
Animation failed (binding inference).
Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%*%`(t_1*{t_1}, x_1*{x_1}, t_2*{t_2}))
Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%*%`(t_1*{t_1}, x_2*{x_2}, t_2*{t_2}))
...Animation failed (reorder)
Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%*%`(t_1*{t_1}, x_1*{x_1}, t_2*{t_2}))
Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%*%`(t_1*{t_1}, x_2*{x_2}, t_2*{t_2}))
Animation failed (binding inference).
(if (l < |C.LABEL_context|))*{l}
if (l' < |C.LABEL_context|)
(Resulttype_sub: `%|-%*<:%*`(C, t*{t}, C.LABEL_context[l]))*{l}
Resulttype_sub: `%|-%*<:%*`(C, t*{t}, C.LABEL_context[l'])
...Animation failed (reorder)
(if (l < |C.LABEL_context|))*{l}
if (l' < |C.LABEL_context|)
(Resulttype_sub: `%|-%*<:%*`(C, t*{t}, C.LABEL_context[l]))*{l}
Resulttype_sub: `%|-%*<:%*`(C, t*{t}, C.LABEL_context[l'])
Animation failed (binding inference).
if (x < |C.TYPE_context|)
Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
...Animation failed (reorder)
where $expanddt(C.TYPE_context[x]) = ARRAY_comptype(`%%`(`MUT%?`(?(())), zt))
if (x < |C.TYPE_context|)
Animation failed (binding inference).
if (x < |C.TYPE_context|)
if (y < |C.DATA_context|)
Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
if (t = (numtype <: valtype))
if (C.DATA_context[y] = OK)
...Animation failed (reorder)
where (numtype <: valtype) = t
if (y < |C.DATA_context|)
if (x < |C.TYPE_context|)
if ($expanddt(C.TYPE_context[x]) = ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
if (C.DATA_context[y] = OK)
Animation failed (binding inference).
if (x < |C.TYPE_context|)
if (y < |C.DATA_context|)
Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
if (t = (vectype <: valtype))
if (C.DATA_context[y] = OK)
...Animation failed (reorder)
where t = (vectype <: valtype)
if (y < |C.DATA_context|)
if (x < |C.TYPE_context|)
if ($expanddt(C.TYPE_context[x]) = ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
if (C.DATA_context[y] = OK)
== IL Validation after pass animate...
== Translating to AL...
...Animation failed (reorder)
if (a < |$funcinst(z)|)
where fi = $funcinst(z)[a]
where FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})) = $expanddt(fi.TYPE_funcinst)
where `FUNC%%*%`(y, LOCAL(t)*{t}, instr*{instr}) = fi.CODE_funcinst
where f = {LOCAL ?(val)^n{val} :: $default(t)*{t}, MODULE fi.MODULE_funcinst}
where (val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a) CALL_REF_admininstr(x?{x})] = u_0*{u_0}
...Animation failed (reorder)
if (a < |$funcinst(z)|)
where FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})) = $expanddt($funcinst(z)[a].TYPE_funcinst)
where FRAME__admininstr(k, f, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a)] :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr <: admininstr)*{instr}) = u_2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 3
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
prem_to_instr: Invalid prem 2
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

validation_of_SELECT ?([t])
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
- The instruction is valid with type [t* ++ [(REF (NULL ?(())) ht)]]->[t* ++ [(REF (NULL ?()) ht)]].

validation_of_BR_ON_NON_NULL l
- |C.LABEL| must be greater than l.
- Let t* ++ [(REF (NULL ?()) ht)] be C.LABEL[l].
- Under the context C, ht must be valid.
- The instruction is valid with type [t* ++ [(REF (NULL ?(())) ht)]]->[t*].

validation_of_BR_ON_CAST l rt_1 rt_2
- |C.LABEL| must be greater than l.
- Under the context C, rt_1 must be valid.
- Under the context C, rt_2 must be valid.
- Yet: TODO: prem_to_instrs 2
- Let t* ++ [rt] be C.LABEL[l].
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [t* ++ [rt_1]]->[t* ++ [$diffrt(rt_1, rt_2)]].

validation_of_BR_ON_CAST_FAIL l rt_1 rt_2
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
- Let (FUNC [t_1*]->[t_2*]) be $expanddt(C.FUNC[x]).
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_CALL_REF ?(x)
- |C.TYPE| must be greater than x.
- Let (FUNC [t_1*]->[t_2*]) be $expanddt(C.TYPE[x]).
- The instruction is valid with type [t_1* ++ [(REF (NULL ?(())) $idx(x))]]->[t_2*].

validation_of_CALL_INDIRECT x y
- |C.TABLE| must be greater than x.
- |C.TYPE| must be greater than y.
- Let (lim, rt) be C.TABLE[x].
- Let (FUNC [t_1*]->[t_2*]) be $expanddt(C.TYPE[y]).
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [t_1* ++ [I32]]->[t_2*].

validation_of_RETURN_CALL x
- |C.FUNC| must be greater than x.
- Let (FUNC [t_1*]->[t_2*]) be $expanddt(C.FUNC[x]).
- Yet: TODO: prem_to_instrs 2
- C.RETURN must be equal to ?(t'_2*).
- The instruction is valid with type [t_3* ++ t_1*]->[t_4*].

validation_of_RETURN_CALL_REF ?(x)
- |C.TYPE| must be greater than x.
- Let (FUNC [t_1*]->[t_2*]) be $expanddt(C.TYPE[x]).
- Yet: TODO: prem_to_instrs 2
- C.RETURN must be equal to ?(t'_2*).
- The instruction is valid with type [t_3* ++ t_1* ++ [(REF (NULL ?(())) $idx(x))]]->[t_4*].

validation_of_RETURN_CALL_INDIRECT x y
- |C.TABLE| must be greater than x.
- |C.TYPE| must be greater than y.
- Let (lim, rt) be C.TABLE[x].
- Let (FUNC [t_1*]->[t_2*]) be $expanddt(C.TYPE[y]).
- Yet: TODO: prem_to_instrs 2
- Yet: TODO: prem_to_instrs 2
- C.RETURN must be equal to ?(t'_2*).
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

validation_of_CVTOP inn_1 CONVERT inn_2 sx?
- inn_1 must be different with inn_2.
- ($size(inn_1) > $size(inn_2)) and (sx? is ?()) are equivalent.
- The instruction is valid with type [inn_2]->[inn_1].

validation_of_REF.NULL ht
- Under the context C, ht must be valid.
- The instruction is valid with type []->[(REF (NULL ?(())) ht)].

validation_of_REF.FUNC x
- |C.FUNC| must be greater than x.
- Let dt be C.FUNC[x].
- The instruction is valid with type []->[(REF (NULL ?()) dt)].

validation_of_REF.I31
- The instruction is valid with type [I32]->[(REF (NULL ?()) I31)].

validation_of_REF.IS_NULL
- The instruction is valid with type [rt]->[I32].

validation_of_REF.AS_NON_NULL
- Under the context C, ht must be valid.
- The instruction is valid with type [(REF (NULL ?(())) ht)]->[(REF (NULL ?()) ht)].

validation_of_REF.EQ
- The instruction is valid with type [(REF (NULL ?(())) EQ), (REF (NULL ?(())) EQ)]->[I32].

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
- The instruction is valid with type [(REF (NULL ?(())) I31)]->[I32].

validation_of_STRUCT.NEW x
- |C.TYPE| must be greater than x.
- Let (STRUCT (mut, zt)*) be $expanddt(C.TYPE[x]).
- |zt*| must be equal to |mut*|.
- The instruction is valid with type [$unpacktype(zt)*]->[(REF (NULL ?()) $idx(x))].

validation_of_STRUCT.NEW_DEFAULT x
- |C.TYPE| must be greater than x.
- Let (STRUCT (mut, zt)*) be $expanddt(C.TYPE[x]).
- |zt*| must be equal to |mut*|.
- Yet: TODO: prem_to_intrs 3
- |zt*| must be equal to |val*|.
- The instruction is valid with type [$unpacktype(zt)*]->[(REF (NULL ?()) $idx(x))].

validation_of_STRUCT.GET sx? x i
- |C.TYPE| must be greater than x.
- Let (STRUCT yt*) be $expanddt(C.TYPE[x]).
- |yt*| must be greater than i.
- Let (mut, zt) be yt*[i].
- (zt is $unpacktype(zt)) and (sx? is ?()) are equivalent.
- The instruction is valid with type [(REF (NULL ?(())) $idx(x))]->[$unpacktype(zt)].

validation_of_STRUCT.SET x i
- |C.TYPE| must be greater than x.
- Let (STRUCT yt*) be $expanddt(C.TYPE[x]).
- |yt*| must be greater than i.
- Let ((MUT ?(())), zt) be yt*[i].
- The instruction is valid with type [(REF (NULL ?(())) $idx(x)), $unpacktype(zt)]->[].

validation_of_ARRAY.NEW x
- |C.TYPE| must be greater than x.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPE[x]).
- The instruction is valid with type [$unpacktype(zt), I32]->[(REF (NULL ?()) $idx(x))].

validation_of_ARRAY.NEW_DEFAULT x
- |C.TYPE| must be greater than x.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPE[x]).
- Let ?(val) be $default($unpacktype(zt)).
- The instruction is valid with type [I32]->[(REF (NULL ?()) $idx(x))].

validation_of_ARRAY.NEW_FIXED x n
- |C.TYPE| must be greater than x.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPE[x]).
- The instruction is valid with type [$unpacktype(zt)]->[(REF (NULL ?()) $idx(x))].

validation_of_ARRAY.NEW_ELEM x y
- |C.TYPE| must be greater than x.
- |C.ELEM| must be greater than y.
- Let (ARRAY (mut, rt)) be $expanddt(C.TYPE[x]).
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type [I32, I32]->[(REF (NULL ?()) $idx(x))].

validation_of_ARRAY.NEW_DATA x y
- |C.TYPE| must be greater than x.
- |C.DATA| must be greater than y.
- C.DATA[y] must be equal to OK.
- Let (ARRAY (mut, t)) be $expanddt(C.TYPE[x]).
- Let numtype be t.
- The instruction is valid with type [I32, I32]->[(REF (NULL ?()) $idx(x))].

validation_of_ARRAY.GET sx? x
- |C.TYPE| must be greater than x.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPE[x]).
- (zt is $unpacktype(zt)) and (sx? is ?()) are equivalent.
- The instruction is valid with type [(REF (NULL ?(())) $idx(x)), I32]->[$unpacktype(zt)].

validation_of_ARRAY.SET x
- |C.TYPE| must be greater than x.
- Let (ARRAY ((MUT ?(())), zt)) be $expanddt(C.TYPE[x]).
- The instruction is valid with type [(REF (NULL ?(())) $idx(x)), I32, $unpacktype(zt)]->[].

validation_of_ARRAY.LEN
- Let $expanddt(C.TYPE[x]) be (ARRAY ((MUT ?(())), zt)).
- |C.TYPE| must be greater than x.
- The instruction is valid with type [(REF (NULL ?(())) ARRAY)]->[I32].

validation_of_ARRAY.FILL x
- |C.TYPE| must be greater than x.
- Let (ARRAY ((MUT ?(())), zt)) be $expanddt(C.TYPE[x]).
- The instruction is valid with type [(REF (NULL ?(())) $idx(x)), I32, $unpacktype(zt), I32]->[].

validation_of_ARRAY.COPY x_1 x_2
- |C.TYPE| must be greater than x_1.
- |C.TYPE| must be greater than x_2.
- Let (ARRAY (mut, zt_2)) be $expanddt(C.TYPE[x_2]).
- Yet: TODO: prem_to_instrs 2
- $expanddt(C.TYPE[x_1]) must be equal to (ARRAY ((MUT ?(())), zt_1)).
- The instruction is valid with type [(REF (NULL ?(())) $idx(x_1)), I32, (REF (NULL ?(())) $idx(x_2)), I32, I32]->[].

validation_of_ARRAY.INIT_ELEM x y
- |C.TYPE| must be greater than x.
- |C.ELEM| must be greater than y.
- Yet: TODO: prem_to_instrs 2
- $expanddt(C.TYPE[x]) must be equal to (ARRAY ((MUT ?(())), zt)).
- The instruction is valid with type [(REF (NULL ?(())) $idx(x)), I32, I32, I32]->[].

validation_of_ARRAY.INIT_DATA x y
- |C.DATA| must be greater than y.
- |C.TYPE| must be greater than x.
- C.DATA[y] must be equal to OK.
- Let numtype be t.
- $expanddt(C.TYPE[x]) must be equal to (ARRAY ((MUT ?(())), zt)).
- The instruction is valid with type [(REF (NULL ?(())) $idx(x)), I32, I32, I32]->[].

validation_of_EXTERN.CONVERT_ANY
- The instruction is valid with type [(REF nul ANY)]->[(REF nul EXTERN)].

validation_of_ANY.CONVERT_EXTERN
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
- Let ((MUT ?(())), t) be C.GLOBAL[x].
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

validation_of_LOAD nt (n, sx)? x { ALIGN: n_A; OFFSET: n_O; }
- |C.MEM| must be greater than x.
- (sx? is ?()) and (n? is ?()) are equivalent.
- (2 ^ n_A) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEM[x].
- The instruction is valid with type [I32]->[nt].

validation_of_STORE nt n? x { ALIGN: n_A; OFFSET: n_O; }
- |C.MEM| must be greater than x.
- (2 ^ n_A) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEM[x].
- The instruction is valid with type [I32, nt]->[].

Ki
1. Return 1024.

min u_0 u_1
1. If u_0 is 0, then:
  a. Return 0.
2. If u_1 is 0, then:
  a. Return 0.
3. Assert: Due to validation, u_0 ≥ 1.
4. Let i be (u_0 - 1).
5. Assert: Due to validation, u_1 ≥ 1.
6. Let j be (u_1 - 1).
7. Return $min(i, j).

sum u_0*
1. If u_0* is [], then:
  a. Return 0.
2. Let [n] ++ n'* be u_0*.
3. Return (n + $sum(n'*)).

test_sub_ATOM_22 n_3_ATOM_y
1. Return 0.

curried_ n_1 n_2
1. Return (n_1 + n_2).

signif u_0
1. If u_0 is 32, then:
  a. Return 23.
2. Assert: Due to validation, u_0 is 64.
3. Return 52.

expon u_0
1. If u_0 is 32, then:
  a. Return 8.
2. Assert: Due to validation, u_0 is 64.
3. Return 11.

M N
1. Return $signif(N).

E N
1. Return $expon(N).

fNzero
1. Return (POS (NORM 0 0)).

setminus1 x u_0*
1. If u_0* is [], then:
  a. Return [x].
2. Let [y_1] ++ y* be u_0*.
3. If x is y_1, then:
  a. Return [].
4. Let [y_1] ++ y* be u_0*.
5. Return $setminus1(x, y*).

setminus u_0* y*
1. If u_0* is [], then:
  a. Return [].
2. Let [x_1] ++ x* be u_0*.
3. Return $setminus1(x_1, y*) ++ $setminus(x*, y*).

free_dataidx_instr u_0
1. If u_0 is of the case MEMORY.INIT, then:
  a. Let (MEMORY.INIT x y) be u_0.
  b. Return [y].
2. If u_0 is of the case DATA.DROP, then:
  a. Let (DATA.DROP x) be u_0.
  b. Return [x].
3. Return [].

free_dataidx_instrs u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [instr] ++ instr'* be u_0*.
3. Return $free_dataidx_instr(instr) ++ $free_dataidx_instrs(instr'*).

free_dataidx_expr in*
1. Return $free_dataidx_instrs(in*).

free_dataidx_func (FUNC x loc* e)
1. Return $free_dataidx_expr(e).

free_dataidx_funcs u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [func] ++ func'* be u_0*.
3. Return $free_dataidx_func(func) ++ $free_dataidx_funcs(func'*).

concat_bytes u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [b*] ++ b'** be u_0*.
3. Return b* ++ $concat_bytes(b'**).

size u_0
1. If u_0 is I32, then:
  a. Return 32.
2. If u_0 is I64, then:
  a. Return 64.
3. If u_0 is F32, then:
  a. Return 32.
4. If u_0 is F64, then:
  a. Return 64.
5. If u_0 is V128, then:
  a. Return 128.

packedsize u_0
1. If u_0 is I8, then:
  a. Return 8.
2. Assert: Due to validation, u_0 is I16.
3. Return 16.

storagesize u_0
1. If the type of u_0 is valtype, then:
  a. Let valtype be u_0.
  b. Return $size(valtype).
2. Assert: Due to validation, the type of u_0 is packedtype.
3. Let packedtype be u_0.
4. Return $packedsize(packedtype).

unpacktype u_0
1. If the type of u_0 is valtype, then:
  a. Let valtype be u_0.
  b. Return valtype.
2. Assert: Due to validation, the type of u_0 is packedtype.
3. Return I32.

unpacknumtype u_0
1. If the type of u_0 is numtype, then:
  a. Let numtype be u_0.
  b. Return numtype.
2. Assert: Due to validation, the type of u_0 is packedtype.
3. Return I32.

sxfield u_0
1. If the type of u_0 is valtype, then:
  a. Return ?().
2. Assert: Due to validation, the type of u_0 is packedtype.
3. Return ?(S).

diffrt (REF nul_1 ht_1) (REF (NULL u_0?) ht_2)
1. If u_0? is ?(()), then:
  a. Return (REF (NULL ?()) ht_1).
2. Assert: Due to validation, u_0? is not defined.
3. Return (REF nul_1 ht_1).

idx x
1. Return (_IDX x).

subst_typevar xx u_0* u_1*
1. If u_0* is [] and u_1* is [], then:
  a. Return xx.
2. Assert: Due to validation, |u_1*| ≥ 1.
3. Let [ht_1] ++ ht'* be u_1*.
4. If |u_0*| ≥ 1, then:
  a. Let [xx_1] ++ xx'* be u_0*.
  b. If xx is xx_1, then:
    1) Return ht_1.
5. Let [ht_1] ++ ht'* be u_1*.
6. Assert: Due to validation, |u_0*| ≥ 1.
7. Let [xx_1] ++ xx'* be u_0*.
8. Return $subst_typevar(xx, xx'*, ht'*).

subst_numtype nt xx* ht*
1. Return nt.

subst_vectype vt xx* ht*
1. Return vt.

subst_packedtype pt xx* ht*
1. Return pt.

subst_heaptype u_0 xx* ht*
1. If the type of u_0 is typevar, then:
  a. Let xx' be u_0.
  b. Return $subst_typevar(xx', xx*, ht*).
2. If the type of u_0 is deftype, then:
  a. Let dt be u_0.
  b. Return $subst_deftype(dt, xx*, ht*).
3. Let ht' be u_0.
4. Return ht'.

subst_reftype (REF nul ht') xx* ht*
1. Return (REF nul $subst_heaptype(ht', xx*, ht*)).

subst_valtype u_0 xx* ht*
1. If the type of u_0 is numtype, then:
  a. Let nt be u_0.
  b. Return $subst_numtype(nt, xx*, ht*).
2. If the type of u_0 is vectype, then:
  a. Let vt be u_0.
  b. Return $subst_vectype(vt, xx*, ht*).
3. If the type of u_0 is reftype, then:
  a. Let rt be u_0.
  b. Return $subst_reftype(rt, xx*, ht*).
4. Assert: Due to validation, u_0 is BOT.
5. Return BOT.

subst_storagetype u_0 xx* ht*
1. If the type of u_0 is valtype, then:
  a. Let t be u_0.
  b. Return $subst_valtype(t, xx*, ht*).
2. Assert: Due to validation, the type of u_0 is packedtype.
3. Let pt be u_0.
4. Return $subst_packedtype(pt, xx*, ht*).

subst_fieldtype (mut, zt) xx* ht*
1. Return (mut, $subst_storagetype(zt, xx*, ht*)).

subst_comptype u_0 xx* ht*
1. If u_0 is of the case STRUCT, then:
  a. Let (STRUCT yt*) be u_0.
  b. Return (STRUCT $subst_fieldtype(yt, xx*, ht*)*).
2. If u_0 is of the case ARRAY, then:
  a. Let (ARRAY yt) be u_0.
  b. Return (ARRAY $subst_fieldtype(yt, xx*, ht*)).
3. Assert: Due to validation, u_0 is of the case FUNC.
4. Let (FUNC ft) be u_0.
5. Return (FUNC $subst_functype(ft, xx*, ht*)).

subst_subtype u_0 xx* ht*
1. If u_0 is of the case SUB, then:
  a. Let (SUB fin y* ct) be u_0.
  b. Return (SUBD fin $subst_heaptype((_IDX y), xx*, ht*)* $subst_comptype(ct, xx*, ht*)).
2. Assert: Due to validation, u_0 is of the case SUBD.
3. Let (SUBD fin ht'* ct) be u_0.
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

subst_externtype u_0 xx* ht*
1. If u_0 is of the case FUNC, then:
  a. Let (FUNC dt) be u_0.
  b. Return (FUNC $subst_deftype(dt, xx*, ht*)).
2. If u_0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be u_0.
  b. Return (GLOBAL $subst_globaltype(gt, xx*, ht*)).
3. If u_0 is of the case TABLE, then:
  a. Let (TABLE tt) be u_0.
  b. Return (TABLE $subst_tabletype(tt, xx*, ht*)).
4. Assert: Due to validation, u_0 is of the case MEM.
5. Let (MEM mt) be u_0.
6. Return (MEM $subst_memtype(mt, xx*, ht*)).

subst_all_reftype rt ht^n
1. Return $subst_reftype(rt, $idx(x)^(x<n), ht^n).

subst_all_deftype dt ht^n
1. Return $subst_deftype(dt, $idx(x)^(x<n), ht^n).

subst_all_deftypes u_0* ht*
1. If u_0* is [], then:
  a. Return [].
2. Let [dt_1] ++ dt* be u_0*.
3. Return [$subst_all_deftype(dt_1, ht*)] ++ $subst_all_deftypes(dt*, ht*).

rollrt x (REC st^n)
1. Return (REC $subst_subtype(st, $idx((x + i))^(i<n), (REC i)^(i<n))^n).

unrollrt (REC st^n)
1. Let qt be (REC st^n).
2. Return (REC $subst_subtype(st, (REC i)^(i<n), (DEF qt i)^(i<n))^n).

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

funcsxt u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [y_0] ++ et* be u_0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC dt) be y_0.
  b. Return [dt] ++ $funcsxt(et*).
4. Let [externtype] ++ et* be u_0*.
5. Return $funcsxt(et*).

globalsxt u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [y_0] ++ et* be u_0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be y_0.
  b. Return [gt] ++ $globalsxt(et*).
4. Let [externtype] ++ et* be u_0*.
5. Return $globalsxt(et*).

tablesxt u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [y_0] ++ et* be u_0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE tt) be y_0.
  b. Return [tt] ++ $tablesxt(et*).
4. Let [externtype] ++ et* be u_0*.
5. Return $tablesxt(et*).

memsxt u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [y_0] ++ et* be u_0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM mt) be y_0.
  b. Return [mt] ++ $memsxt(et*).
4. Let [externtype] ++ et* be u_0*.
5. Return $memsxt(et*).

memop0
1. Return { ALIGN: 0; OFFSET: 0; }.

signed N i
1. If 0 ≤ (2 ^ (N - 1)), then:
  a. Return i.
2. Assert: Due to validation, (2 ^ (N - 1)) ≤ i.
3. Assert: Due to validation, i < (2 ^ N).
4. Return (i - (2 ^ N)).

invsigned N i
1. Let j be $inverse_of_signed(N, i).
2. Return j.

invibytes N b*
1. Let n be $inverse_of_ibytes(N, b*).
2. Return n.

invfbytes N b*
1. Let p be $inverse_of_fbytes(N, b*).
2. Return p.

inst_reftype mm rt
1. Let dt* be mm.TYPE.
2. Return $subst_all_reftype(rt, dt*).

default u_0
1. If u_0 is I32, then:
  a. Return ?((I32.CONST 0)).
2. If u_0 is I64, then:
  a. Return ?((I64.CONST 0)).
3. If u_0 is F32, then:
  a. Return ?((F32.CONST 0)).
4. If u_0 is F64, then:
  a. Return ?((F64.CONST 0)).
5. Assert: Due to validation, u_0 is of the case REF.
6. Let (REF y_0 ht) be u_0.
7. If y_0 is (NULL ?(())), then:
  a. Return ?((REF.NULL ht)).
8. Assert: Due to validation, y_0 is (NULL ?()).
9. Return ?().

packval u_0 u_1
1. If the type of u_0 is valtype, then:
  a. Let val be u_1.
  b. Return val.
2. Assert: Due to validation, u_1 is of the case CONST.
3. Let (y_0.CONST i) be u_1.
4. Assert: Due to validation, y_0 is I32.
5. Assert: Due to validation, the type of u_0 is packedtype.
6. Let pt be u_0.
7. Return (PACK pt $wrap(32, $packedsize(pt), i)).

unpackval u_0 u_1? u_2
1. If u_1? is not defined, then:
  a. Assert: Due to validation, the type of u_0 is valtype.
  b. Assert: Due to validation, the type of u_2 is val.
  c. Let val be u_2.
  d. Return val.
2. Else:
  a. Let ?(sx) be u_1?.
  b. Assert: Due to validation, u_2 is of the case PACK.
  c. Let (PACK pt i) be u_2.
  d. Assert: Due to validation, u_0 is pt.
  e. Return (I32.CONST $ext($packedsize(pt), 32, sx, i)).

funcsxv u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [y_0] ++ xv* be u_0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcsxv(xv*).
4. Let [externval] ++ xv* be u_0*.
5. Return $funcsxv(xv*).

globalsxv u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [y_0] ++ xv* be u_0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globalsxv(xv*).
4. Let [externval] ++ xv* be u_0*.
5. Return $globalsxv(xv*).

tablesxv u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [y_0] ++ xv* be u_0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tablesxv(xv*).
4. Let [externval] ++ xv* be u_0*.
5. Return $tablesxv(xv*).

memsxv u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [y_0] ++ xv* be u_0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $memsxv(xv*).
4. Let [externval] ++ xv* be u_0*.
5. Return $memsxv(xv*).

store

frame
1. Let f be the current frame.
2. Return f.

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

moduleinst
1. Let f be the current frame.
2. Return f.MODULE.

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
2. Let i' be (|r'*| + n).
3. If i' ≤ j, then:
  a. Let ti' be { TYPE: ((i', j), rt); ELEM: r'* ++ r^n; }.
  b. Return ti'.

growmemory mi n
1. Let { TYPE: (I8 (i, j)); DATA: b*; } be mi.
2. Let i' be ((|b*| / (64 · $Ki())) + n).
3. If i' ≤ j, then:
  a. Let mi' be { TYPE: (I8 (i', j)); DATA: b* ++ 0^((n · 64) · $Ki()); }.
  b. Return mi'.

with_locals C u_0* u_1*
1. If u_0* is [] and u_1* is [], then:
  a. Return C.
2. Assert: Due to validation, |u_1*| ≥ 1.
3. Let [lt_1] ++ lt* be u_1*.
4. Assert: Due to validation, |u_0*| ≥ 1.
5. Let [x_1] ++ x* be u_0*.
6. Return $with_locals(C with .LOCAL[x_1] replaced by lt_1, x*, lt*).

clostypes u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let dt* ++ [dt_N] be u_0*.
3. Let dt'* be $clostypes(dt*).
4. Return dt'* ++ [$subst_all_deftype(dt_N, dt'*)].

clostype C dt
1. Let dt'* be $clostypes(C.TYPE).
2. Return $subst_all_deftype(dt, dt'*).

before u_0 x i
1. If the type of u_0 is deftype, then:
  a. Return YetE (BoolE true).
2. If u_0 is of the case _IDX, then:
  a. Return YetE (CmpE (VarE "typeidx", LtOp, VarE "x")).
3. Assert: Due to validation, u_0 is of the case REC.
4. Return YetE (CmpE (VarE "j", LtOp, VarE "i")).

unrollht C u_0
1. If the type of u_0 is deftype, then:
  a. Let deftype be u_0.
  b. Return $unrolldt(deftype).
2. If u_0 is of the case _IDX, then:
  a. Let (_IDX typeidx) be u_0.
  b. Return $unrolldt(C.TYPE[typeidx]).
3. Assert: Due to validation, u_0 is of the case REC.
4. Let (REC i) be u_0.
5. Return C.REC[i].

in_binop binop u_0*
1. If u_0* is [], then:
  a. Return YetE (BoolE false).
2. Let [binopIXX_1] ++ binopIXX'* be u_0*.
3. Return (YetE (CmpE (VarE "binop", EqOp, CaseE (Atom "_I", VarE "binopIXX_1"))) or $in_binop(binop, binopIXX'*)).

in_numtype nt u_0*
1. If u_0* is [], then:
  a. Return YetE (BoolE false).
2. Let [nt_1] ++ nt'* be u_0*.
3. Return (YetE (CmpE (VarE "nt", EqOp, VarE "nt_1")) or $in_numtype(nt, nt'*)).

blocktype u_1
1. If u_1 is (_RESULT ?()), then:
  a. Return []->[].
2. If u_1 is of the case _RESULT, then:
  a. Let (_RESULT y_0) be u_1.
  b. If y_0 is defined, then:
    1) Let ?(t) be y_0.
    2) Return []->[t].
3. Assert: Due to validation, u_1 is of the case _IDX.
4. Let (_IDX x) be u_1.
5. Assert: Due to validation, $expanddt($type(x)) is of the case FUNC.
6. Let (FUNC ft) be $expanddt($type(x)).
7. Return ft.

alloctypes u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let type'* ++ [type] be u_0*.
3. Let deftype'* be $alloctypes(type'*).
4. Assert: Due to validation, type is of the case TYPE.
5. Let (TYPE rectype) be type.
6. Let x be |deftype'*|.
7. Let deftype* be $subst_all_deftypes($rolldt(x, rectype), deftype'*).
8. Return deftype'* ++ deftype*.

allocfunc mm func
1. Assert: Due to validation, func is of the case FUNC.
2. Let (FUNC x local* expr) be func.
3. Let fi be { TYPE: mm.TYPE[x]; MODULE: mm; CODE: func; }.
4. Let a be |s.FUNC|.
5. Append fi to the s.FUNC.
6. Return a.

allocfuncs mm u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [func] ++ func'* be u_0*.
3. Let fa be $allocfunc(mm, func).
4. Let fa'* be $allocfuncs(mm, func'*).
5. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let gi be { TYPE: globaltype; VALUE: val; }.
2. Let a be |s.GLOBAL|.
3. Append gi to the s.GLOBAL.
4. Return a.

allocglobals u_0* u_1*
1. If u_0* is [], then:
  a. Assert: Due to validation, u_1* is [].
  b. Return [].
2. Else:
  a. Let [globaltype] ++ globaltype'* be u_0*.
  b. Assert: Due to validation, |u_1*| ≥ 1.
  c. Let [val] ++ val'* be u_1*.
  d. Let ga be $allocglobal(globaltype, val).
  e. Let ga'* be $allocglobals(globaltype'*, val'*).
  f. Return [ga] ++ ga'*.

alloctable ((i, j), rt) ref
1. Let ti be { TYPE: ((i, j), rt); ELEM: ref^i; }.
2. Let a be |s.TABLE|.
3. Append ti to the s.TABLE.
4. Return a.

alloctables u_0* u_1*
1. If u_0* is [] and u_1* is [], then:
  a. Return [].
2. Assert: Due to validation, |u_1*| ≥ 1.
3. Let [ref] ++ ref'* be u_1*.
4. Assert: Due to validation, |u_0*| ≥ 1.
5. Let [tabletype] ++ tabletype'* be u_0*.
6. Let ta be $alloctable(tabletype, ref).
7. Let ta'* be $alloctables(tabletype'*, ref'*).
8. Return [ta] ++ ta'*.

allocmem (I8 (i, j))
1. Let mi be { TYPE: (I8 (i, j)); DATA: 0^((i · 64) · $Ki()); }.
2. Let a be |s.MEM|.
3. Append mi to the s.MEM.
4. Return a.

allocmems u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [memtype] ++ memtype'* be u_0*.
3. Let ma be $allocmem(memtype).
4. Let ma'* be $allocmems(memtype'*).
5. Return [ma] ++ ma'*.

allocelem rt ref*
1. Let ei be { TYPE: rt; ELEM: ref*; }.
2. Let a be |s.ELEM|.
3. Append ei to the s.ELEM.
4. Return a.

allocelems u_0* u_1*
1. If u_0* is [] and u_1* is [], then:
  a. Return [].
2. Assert: Due to validation, |u_1*| ≥ 1.
3. Let [ref*] ++ ref'** be u_1*.
4. Assert: Due to validation, |u_0*| ≥ 1.
5. Let [rt] ++ rt'* be u_0*.
6. Let ea be $allocelem(rt, ref*).
7. Let ea'* be $allocelems(rt'*, ref'**).
8. Return [ea] ++ ea'*.

allocdata byte*
1. Let di be { DATA: byte*; }.
2. Let a be |s.DATA|.
3. Append di to the s.DATA.
4. Return a.

allocdatas u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [byte*] ++ byte'** be u_0*.
3. Let da be $allocdata(byte*).
4. Let da'* be $allocdatas(byte'**).
5. Return [da] ++ da'*.

instexport fa* ga* ta* ma* (EXPORT name u_0)
1. If u_0 is of the case FUNC, then:
  a. Let (FUNC x) be u_0.
  b. Return { NAME: name; VALUE: (FUNC fa*[x]); }.
2. If u_0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be u_0.
  b. Return { NAME: name; VALUE: (GLOBAL ga*[x]); }.
3. If u_0 is of the case TABLE, then:
  a. Let (TABLE x) be u_0.
  b. Return { NAME: name; VALUE: (TABLE ta*[x]); }.
4. Assert: Due to validation, u_0 is of the case MEM.
5. Let (MEM x) be u_0.
6. Return { NAME: name; VALUE: (MEM ma*[x]); }.

allocmodule module externval* val_g* ref_t* ref_e**
1. Let fa_ex* be $funcsxv(externval*).
2. Let ga_ex* be $globalsxv(externval*).
3. Let ma_ex* be $memsxv(externval*).
4. Let ta_ex* be $tablesxv(externval*).
5. Assert: Due to validation, module is of the case MODULE.
6. Let (MODULE type* import* func^n_f y_0 y_1 y_2 y_3 y_4 start? export*) be module.
7. Let (DATA byte* datamode)^n_d be y_4.
8. Let (ELEM reftype expr_e* elemmode)^n_e be y_3.
9. Let (MEMORY memtype)^n_m be y_2.
10. Let (TABLE tabletype expr_t)^n_t be y_1.
11. Let (GLOBAL globaltype expr_g)^n_g be y_0.
12. Let dt* be $alloctypes(type*).
13. Let fa* be (|s.FUNC| + i_f)^(i_f<n_f).
14. Let ga* be (|s.GLOBAL| + i_g)^(i_g<n_g).
15. Let ta* be (|s.TABLE| + i_t)^(i_t<n_t).
16. Let ma* be (|s.MEM| + i_m)^(i_m<n_m).
17. Let ea* be (|s.ELEM| + i_e)^(i_e<n_e).
18. Let da* be (|s.DATA| + i_d)^(i_d<n_d).
19. Let xi* be $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*.
20. Let mm be { TYPE: dt*; FUNC: fa_ex* ++ fa*; GLOBAL: ga_ex* ++ ga*; TABLE: ta_ex* ++ ta*; MEM: ma_ex* ++ ma*; ELEM: ea*; DATA: da*; EXPORT: xi*; }.
21. Let y_0 be $allocfuncs(mm, func^n_f).
22. Assert: Due to validation, y_0 is fa*.
23. Let y_0 be $allocglobals(globaltype^n_g, val_g*).
24. Assert: Due to validation, y_0 is ga*.
25. Let y_0 be $alloctables(tabletype^n_t, ref_t*).
26. Assert: Due to validation, y_0 is ta*.
27. Let y_0 be $allocmems(memtype^n_m).
28. Assert: Due to validation, y_0 is ma*.
29. Let y_0 be $allocelems(reftype^n_e, ref_e**).
30. Assert: Due to validation, y_0 is ea*.
31. Let y_0 be $allocdatas(byte*^n_d).
32. Assert: Due to validation, y_0 is da*.
33. Return mm.

concat_instr u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [instr*] ++ instr'** be u_0*.
3. Return instr* ++ $concat_instr(instr'**).

runelem (ELEM reftype expr* u_0) y
1. If u_0 is PASSIVE, then:
  a. Return [].
2. If u_0 is DECLARE, then:
  a. Return [(ELEM.DROP y)].
3. Assert: Due to validation, u_0 is of the case ACTIVE.
4. Let (ACTIVE x instr*) be u_0.
5. Return instr* ++ [(I32.CONST 0), (I32.CONST |expr*|), (TABLE.INIT x y), (ELEM.DROP y)].

rundata (DATA byte* u_0) y
1. If u_0 is PASSIVE, then:
  a. Return [].
2. Assert: Due to validation, u_0 is of the case ACTIVE.
3. Let (ACTIVE x instr*) be u_0.
4. Return instr* ++ [(I32.CONST 0), (I32.CONST |byte*|), (MEMORY.INIT x y), (DATA.DROP y)].

instantiate module externval*
1. Assert: Due to validation, module is of the case MODULE.
2. Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) be module.
3. Let n_D be |data*|.
4. Let n_E be |elem*|.
5. Let n_F be |func*|.
6. Let (START x)? be start?.
7. Let (GLOBAL globaltype expr_G)* be global*.
8. Let (TABLE tabletype expr_T)* be table*.
9. Let (ELEM reftype expr_E* elemmode)* be elem*.
10. Let instr_D* be $concat_instr($rundata(data*[j], j)^(j<n_D)).
11. Let instr_E* be $concat_instr($runelem(elem*[i], i)^(i<n_E)).
12. Let mm_init be { TYPE: $alloctypes(type*); FUNC: $funcsxv(externval*) ++ (|s.FUNC| + i_F)^(i_F<n_F); GLOBAL: $globalsxv(externval*); TABLE: []; MEM: []; ELEM: []; DATA: []; EXPORT: []; }.
13. Let z be { LOCAL: []; MODULE: mm_init; }.
14. Enter the activation of z with label [FRAME_]:
  a. Let [val_G]* be $eval_expr(expr_G)*.
15. Enter the activation of z with label [FRAME_]:
  a. Let [ref_T]* be $eval_expr(expr_T)*.
16. Enter the activation of z with label [FRAME_]:
  a. Let [ref_E]** be $eval_expr(expr_E)**.
17. Let mm be $allocmodule(module, externval*, val_G*, ref_T*, ref_E**).
18. Let f be { LOCAL: []; MODULE: mm; }.
19. Enter the activation of f with arity 0 with label [FRAME_]:
  a. Execute the sequence (instr_E*).
  b. Execute the sequence (instr_D*).
  c. If x is defined, then:
    1) Let ?(x_0) be x.
    2) Execute (CALL x_0).
20. Return mm.

invoke fa val^n
1. Let f be { LOCAL: []; MODULE: { TYPE: []; FUNC: []; GLOBAL: []; TABLE: []; MEM: []; ELEM: []; DATA: []; EXPORT: []; }; }.
2. Assert: Due to validation, $expanddt(s.FUNC[fa].TYPE) is of the case FUNC.
3. Let (FUNC y_0) be $expanddt(s.FUNC[fa].TYPE).
4. Let [t_1^n]->[t_2*] be y_0.
5. Assert: Due to validation, $funcinst()[fa].CODE is of the case FUNC.
6. Let k be |t_2*|.
7. Enter the activation of f with arity k with label [FRAME_]:
  a. Push val^n to the stack.
  b. Push (REF.FUNC_ADDR fa) to the stack.
  c. Execute (CALL_REF ?(0)).
8. Pop val^k from the stack.
9. Return val^k.

utf8 u_0
1. If |u_0| is 1, then:
  a. Let [c] be u_0.
  b. If c < 128, then:
    1) Let b be c.
    2) Return [b].
  c. If 128 ≤ c and c < 2048 and c ≥ (b_2 - 128), then:
    1) Let ((2 ^ 6) · (b_1 - 192)) be (c - (b_2 - 128)).
    2) Return [b_1, b_2].
  d. If 2048 ≤ c and c < 55296 or 57344 ≤ c and c < 65536 and c ≥ (b_3 - 128), then:
    1) Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · (b_2 - 128))) be (c - (b_3 - 128)).
    2) Return [b_1, b_2, b_3].
  e. If 65536 ≤ c and c < 69632 and c ≥ (b_4 - 128), then:
    1) Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · (b_2 - 128))) + ((2 ^ 6) · (b_3 - 128))) be (c - (b_4 - 128)).
    2) Return [b_1, b_2, b_3, b_4].
2. Let c* be u_0.
3. Return $concat_bytes($utf8([c])*).

concat_locals u_0*
1. If u_0* is [], then:
  a. Return [].
2. Let [loc*] ++ loc'** be u_0*.
3. Return loc* ++ $concat_locals(loc'**).

execution_of_UNREACHABLE
1. Trap.

execution_of_NOP
1. Do nothing.

execution_of_DROP
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Do nothing.

execution_of_SELECT t*?
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

execution_of_BR u_0
1. Let L be the current label.
2. Let n be the arity of L.
3. Let instr'* be the continuation of L.
4. Pop all values u_1* from the stack.
5. Exit current context.
6. If u_0 is 0 and |u_1*| ≥ n, then:
  a. Let val'* ++ val^n be u_1*.
  b. Push val^n to the stack.
  c. Execute the sequence (instr'*).
7. If u_0 ≥ 1, then:
  a. Let l be (u_0 - 1).
  b. Let val* be u_1*.
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

execution_of_BR_ON_NULL l
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. If val is of the case REF.NULL, then:
  a. Execute (BR l).
4. Else:
  a. Push val to the stack.

execution_of_BR_ON_NON_NULL l
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. If val is of the case REF.NULL, then:
  a. Do nothing.
4. Else:
  a. Push val to the stack.
  b. Execute (BR l).

execution_of_CALL_INDIRECT x y
1. Execute (TABLE.GET x).
2. Execute (REF.CAST (REF (NULL ?(())) $idx(y))).
3. Execute (CALL_REF ?(y)).

execution_of_RETURN_CALL_INDIRECT x y
1. Execute (TABLE.GET x).
2. Execute (REF.CAST (REF (NULL ?(())) $idx(y))).
3. Execute (RETURN_CALL_REF ?(y)).

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
3. Push (REF.I31_NUM $wrap(32, 31, i)) to the stack.

execution_of_REF.IS_NULL
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. If val is of the case REF.NULL, then:
  a. Push (I32.CONST 1) to the stack.
4. Else:
  a. Push (I32.CONST 0) to the stack.

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
5. If ref_1 is of the case REF.NULL and ref_2 is of the case REF.NULL, then:
  a. Push (I32.CONST 1) to the stack.
6. Else if ref_1 is ref_2, then:
  a. Push (I32.CONST 1) to the stack.
7. Else:
  a. Push (I32.CONST 0) to the stack.

execution_of_I31.GET sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop u_0 from the stack.
3. If u_0 is of the case REF.NULL, then:
  a. Trap.
4. If u_0 is of the case REF.I31_NUM, then:
  a. Let (REF.I31_NUM i) be u_0.
  b. Push (I32.CONST $ext(31, 32, sx, i)) to the stack.

execution_of_EXTERN.CONVERT_ANY
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop u_0 from the stack.
3. If u_0 is of the case REF.NULL, then:
  a. Push (REF.NULL EXTERN) to the stack.
4. If the type of u_0 is addrref, then:
  a. Let addrref be u_0.
  b. Push (REF.EXTERN addrref) to the stack.

execution_of_ANY.CONVERT_EXTERN
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop u_0 from the stack.
3. If u_0 is of the case REF.NULL, then:
  a. Push (REF.NULL ANY) to the stack.
4. If u_0 is of the case REF.EXTERN, then:
  a. Let (REF.EXTERN addrref) be u_0.
  b. Push addrref to the stack.

execution_of_LOCAL.TEE x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Push val to the stack.
4. Push val to the stack.
5. Execute (LOCAL.SET x).

execution_of_BLOCK bt instr*
1. Let [t_1^k]->[t_2^n] be $blocktype(bt).
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. Let L be the label_n{[]}.
5. Enter L with label instr* ++ [LABEL_]:
  a. Push val^k to the stack.

execution_of_LOOP bt instr*
1. Let [t_1^k]->[t_2^n] be $blocktype(bt).
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. Let L be the label_k{[(LOOP bt instr*)]}.
5. Enter L with label instr* ++ [LABEL_]:
  a. Push val^k to the stack.

execution_of_BR_ON_CAST l rt_1 rt_2
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. Let rt be $ref_type_of(ref).
4. If not rt matches $inst_reftype($moduleinst(), rt_2), then:
  a. Push ref to the stack.
5. Else:
  a. Push ref to the stack.
  b. Execute (BR l).

execution_of_BR_ON_CAST_FAIL l rt_1 rt_2
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. Let rt be $ref_type_of(ref).
4. If rt matches $inst_reftype($moduleinst(), rt_2), then:
  a. Push ref to the stack.
5. Else:
  a. Push ref to the stack.
  b. Execute (BR l).

execution_of_CALL x
1. Assert: Due to validation, x < |$funcaddr()|.
2. Push (REF.FUNC_ADDR $funcaddr()[x]) to the stack.
3. Execute (CALL_REF ?()).

execution_of_CALL_REF
1. YetI: TODO: It is likely that the value stack of two rules are differ.

execution_of_RETURN_CALL x
1. Assert: Due to validation, x < |$funcaddr()|.
2. Push (REF.FUNC_ADDR $funcaddr()[x]) to the stack.
3. Execute (RETURN_CALL_REF ?()).

execution_of_RETURN_CALL_REF x?
1. If not the current context is frame, then:
  a. If the current context is label, then:
    1) Pop all values val* from the stack.
    2) Exit current context.
    3) Push val* to the stack.
    4) Execute (RETURN_CALL_REF x?).
2. Else:
  a. Pop u_0 from the stack.
  b. Pop all values u_1* from the stack.
  c. Exit current context.
  d. If u_0 is of the case REF.FUNC_ADDR, then:
    1) Let (REF.FUNC_ADDR a) be u_0.
    2) If a < |$funcinst()| and $expanddt($funcinst()[a].TYPE) is of the case FUNC, then:
      a) Let (FUNC y_0) be $expanddt($funcinst()[a].TYPE).
      b) Let [t_1^n]->[t_2^m] be y_0.
      c) If |u_1*| ≥ n, then:
        1. Let val'* ++ val^n be u_1*.
        2. Push val^n to the stack.
        3. Push (REF.FUNC_ADDR a) to the stack.
        4. Execute (CALL_REF x?).
  e. If u_0 is of the case REF.NULL, then:
    1) Trap.

execution_of_REF.FUNC x
1. Assert: Due to validation, x < |$funcaddr()|.
2. Push (REF.FUNC_ADDR $funcaddr()[x]) to the stack.

execution_of_REF.TEST rt
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. Let rt' be $ref_type_of(ref).
4. If rt' matches $inst_reftype($moduleinst(), rt), then:
  a. Push (I32.CONST 1) to the stack.
5. Else:
  a. Push (I32.CONST 0) to the stack.

execution_of_REF.CAST rt
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. Let rt' be $ref_type_of(ref).
4. If not rt' matches $inst_reftype($moduleinst(), rt), then:
  a. Trap.
5. Push ref to the stack.

execution_of_STRUCT.NEW_DEFAULT x
1. Assert: Due to validation, $expanddt($type(x)) is of the case STRUCT.
2. Let (STRUCT y_0) be $expanddt($type(x)).
3. Let (mut, zt)* be y_0.
4. Assert: Due to validation, |mut*| is |zt*|.
5. Assert: Due to validation, $default($unpacktype(zt)) is defined.
6. Let ?(val)* be $default($unpacktype(zt))*.
7. Assert: Due to validation, |val*| is |zt*|.
8. Push val* to the stack.
9. Execute (STRUCT.NEW x).

execution_of_STRUCT.GET sx? x i
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop u_0 from the stack.
3. If u_0 is of the case REF.NULL, then:
  a. Trap.
4. If u_0 is of the case REF.STRUCT_ADDR, then:
  a. Let (REF.STRUCT_ADDR a) be u_0.
  b. If a < |$structinst()|, then:
    1) Let si be $structinst()[a].
    2) If i < |si.FIELD| and $expanddt(si.TYPE) is of the case STRUCT, then:
      a) Let (STRUCT y_0) be $expanddt(si.TYPE).
      b) Let (mut, zt)* be y_0.
      c) If |mut*| is |zt*| and i < |zt*|, then:
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
3. Assert: Due to validation, $expanddt($type(x)) is of the case ARRAY.
4. Let (ARRAY y_0) be $expanddt($type(x)).
5. Let (mut, zt) be y_0.
6. Assert: Due to validation, $default($unpacktype(zt)) is defined.
7. Let ?(val) be $default($unpacktype(zt)).
8. Push val^n to the stack.
9. Execute (ARRAY.NEW_FIXED x n).

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
5. Assert: Due to validation, $expanddt($type(x)) is of the case ARRAY.
6. Let (ARRAY y_0) be $expanddt($type(x)).
7. Let (mut, zt) be y_0.
8. If (i + ((n · $storagesize(zt)) / 8)) > |$data(y).DATA|, then:
  a. Trap.
9. Let $ztbytes(zt, c)^n be $inverse_of_concat_bytes($data(y).DATA[i : ((n · $storagesize(zt)) / 8)]).
10. Let nt be $unpacknumtype(zt).
11. Push (nt.CONST c)^n to the stack.
12. Execute (ARRAY.NEW_FIXED x n).

execution_of_ARRAY.GET sx? x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop u_0 from the stack.
5. If u_0 is of the case REF.NULL, then:
  a. Trap.
6. If u_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be u_0.
  b. If a < |$arrayinst()| and i ≥ |$arrayinst()[a].FIELD|, then:
    1) Trap.
  c. If i < |$arrayinst()[a].FIELD| and a < |$arrayinst()|, then:
    1) Let fv be $arrayinst()[a].FIELD[i].
    2) If $expanddt($arrayinst()[a].TYPE) is of the case ARRAY, then:
      a) Let (ARRAY y_0) be $expanddt($arrayinst()[a].TYPE).
      b) Let (mut, zt) be y_0.
      c) Push $unpackval(zt, sx?, fv) to the stack.

execution_of_ARRAY.LEN
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop u_0 from the stack.
3. If u_0 is of the case REF.NULL, then:
  a. Trap.
4. If u_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be u_0.
  b. If a < |$arrayinst()|, then:
    1) Let n be |$arrayinst()[a].FIELD|.
    2) Push (I32.CONST n) to the stack.

execution_of_ARRAY.FILL x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. Assert: Due to validation, a value is on the top of the stack.
8. Pop u_0 from the stack.
9. If u_0 is of the case REF.NULL, then:
  a. Trap.
10. If u_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be u_0.
  b. If a < |$arrayinst()| and (i + n) > |$arrayinst()[a].FIELD|, then:
    1) Trap.
  c. If n is 0, then:
    1) Do nothing.
  d. Else:
    1) Let (REF.ARRAY_ADDR a) be u_0.
    2) Push (REF.ARRAY_ADDR a) to the stack.
    3) Push (I32.CONST i) to the stack.
    4) Push val to the stack.
    5) Execute (ARRAY.SET x).
    6) Push (REF.ARRAY_ADDR a) to the stack.
    7) Push (I32.CONST (i + 1)) to the stack.
    8) Push val to the stack.
    9) Push (I32.CONST (n - 1)) to the stack.
    10) Execute (ARRAY.FILL x).

execution_of_ARRAY.COPY x_1 x_2
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i_2) from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop u_1 from the stack.
7. Assert: Due to validation, a value of value type I32 is on the top of the stack.
8. Pop (I32.CONST i_1) from the stack.
9. Assert: Due to validation, a value is on the top of the stack.
10. Pop u_0 from the stack.
11. If u_0 is of the case REF.NULL and the type of u_1 is ref, then:
  a. Trap.
12. If u_1 is of the case REF.NULL and the type of u_0 is ref, then:
  a. Trap.
13. If u_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a_1) be u_0.
  b. If u_1 is of the case REF.ARRAY_ADDR, then:
    1) If a_1 < |$arrayinst()| and (i_1 + n) > |$arrayinst()[a_1].FIELD|, then:
      a) Trap.
    2) Let (REF.ARRAY_ADDR a_2) be u_1.
    3) If a_2 < |$arrayinst()| and (i_2 + n) > |$arrayinst()[a_2].FIELD|, then:
      a) Trap.
  c. If n is 0, then:
    1) If u_1 is of the case REF.ARRAY_ADDR, then:
      a) Do nothing.
  d. Else if i_1 > i_2, then:
    1) If $expanddt($type(x_2)) is of the case ARRAY, then:
      a) Let (ARRAY y_0) be $expanddt($type(x_2)).
      b) Let (mut, zt_2) be y_0.
      c) Let (REF.ARRAY_ADDR a_1) be u_0.
      d) If u_1 is of the case REF.ARRAY_ADDR, then:
        1. Let (REF.ARRAY_ADDR a_2) be u_1.
        2. Let sx? be $sxfield(zt_2).
        3. Push (REF.ARRAY_ADDR a_1) to the stack.
        4. Push (I32.CONST ((i_1 + n) - 1)) to the stack.
        5. Push (REF.ARRAY_ADDR a_2) to the stack.
        6. Push (I32.CONST ((i_2 + n) - 1)) to the stack.
        7. Execute (ARRAY.GET sx? x_2).
        8. Execute (ARRAY.SET x_1).
        9. Push (REF.ARRAY_ADDR a_1) to the stack.
        10. Push (I32.CONST i_1) to the stack.
        11. Push (REF.ARRAY_ADDR a_2) to the stack.
        12. Push (I32.CONST i_2) to the stack.
        13. Push (I32.CONST (n - 1)) to the stack.
        14. Execute (ARRAY.COPY x_1 x_2).
  e. Else:
    1) If $expanddt($type(x_2)) is of the case ARRAY, then:
      a) Let (ARRAY y_0) be $expanddt($type(x_2)).
      b) Let (mut, zt_2) be y_0.
      c) Let (REF.ARRAY_ADDR a_1) be u_0.
      d) If u_1 is of the case REF.ARRAY_ADDR, then:
        1. Let (REF.ARRAY_ADDR a_2) be u_1.
        2. Let sx? be $sxfield(zt_2).
        3. Push (REF.ARRAY_ADDR a_1) to the stack.
        4. Push (I32.CONST i_1) to the stack.
        5. Push (REF.ARRAY_ADDR a_2) to the stack.
        6. Push (I32.CONST i_2) to the stack.
        7. Execute (ARRAY.GET sx? x_2).
        8. Execute (ARRAY.SET x_1).
        9. Push (REF.ARRAY_ADDR a_1) to the stack.
        10. Push (I32.CONST (i_1 + 1)) to the stack.
        11. Push (REF.ARRAY_ADDR a_2) to the stack.
        12. Push (I32.CONST (i_2 + 1)) to the stack.
        13. Push (I32.CONST (n - 1)) to the stack.
        14. Execute (ARRAY.COPY x_1 x_2).

execution_of_ARRAY.INIT_ELEM x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST j) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. Assert: Due to validation, a value is on the top of the stack.
8. Pop u_0 from the stack.
9. If u_0 is of the case REF.NULL, then:
  a. Trap.
10. If u_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be u_0.
  b. If a < |$arrayinst()| and (i + n) > |$arrayinst()[a].FIELD|, then:
    1) Trap.
11. If (j + n) > |$elem(y).ELEM|, then:
  a. If u_0 is of the case REF.ARRAY_ADDR, then:
    1) Trap.
  b. If n is 0 and j < |$elem(y).ELEM|, then:
    1) Let ref be $elem(y).ELEM[j].
    2) If u_0 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a) be u_0.
      b) Push (REF.ARRAY_ADDR a) to the stack.
      c) Push (I32.CONST i) to the stack.
      d) Push ref to the stack.
      e) Execute (ARRAY.SET x).
      f) Push (REF.ARRAY_ADDR a) to the stack.
      g) Push (I32.CONST (i + 1)) to the stack.
      h) Push (I32.CONST (j + 1)) to the stack.
      i) Push (I32.CONST (n - 1)) to the stack.
      j) Execute (ARRAY.INIT_ELEM x y).
12. Else if n is 0, then:
  a. If u_0 is of the case REF.ARRAY_ADDR, then:
    1) Do nothing.
13. Else:
  a. If j < |$elem(y).ELEM|, then:
    1) Let ref be $elem(y).ELEM[j].
    2) If u_0 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a) be u_0.
      b) Push (REF.ARRAY_ADDR a) to the stack.
      c) Push (I32.CONST i) to the stack.
      d) Push ref to the stack.
      e) Execute (ARRAY.SET x).
      f) Push (REF.ARRAY_ADDR a) to the stack.
      g) Push (I32.CONST (i + 1)) to the stack.
      h) Push (I32.CONST (j + 1)) to the stack.
      i) Push (I32.CONST (n - 1)) to the stack.
      j) Execute (ARRAY.INIT_ELEM x y).

execution_of_ARRAY.INIT_DATA x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST j) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. Assert: Due to validation, a value is on the top of the stack.
8. Pop u_0 from the stack.
9. If u_0 is of the case REF.NULL, then:
  a. Trap.
10. If u_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be u_0.
  b. If a < |$arrayinst()| and (i + n) > |$arrayinst()[a].FIELD|, then:
    1) Trap.
11. If $expanddt($type(x)) is not of the case ARRAY, then:
  a. If n is 0 and u_0 is of the case REF.ARRAY_ADDR, then:
    1) Do nothing.
12. Else:
  a. Let (ARRAY y_0) be $expanddt($type(x)).
  b. Let (mut, zt) be y_0.
  c. If u_0 is of the case REF.ARRAY_ADDR, then:
    1) If (j + ((n · $storagesize(zt)) / 8)) > |$data(y).DATA|, then:
      a) Trap.
    2) If n is 0, then:
      a) Do nothing.
    3) Else:
      a) Let (ARRAY y_0) be $expanddt($type(x)).
      b) Let (mut, zt) be y_0.
      c) Let (REF.ARRAY_ADDR a) be u_0.
      d) Let c be $inverse_of_ztbytes(zt, $data(y).DATA[j : ($storagesize(zt) / 8)]).
      e) Let nt be $unpacknumtype(zt).
      f) Push (REF.ARRAY_ADDR a) to the stack.
      g) Push (I32.CONST i) to the stack.
      h) Push (nt.CONST c) to the stack.
      i) Execute (ARRAY.SET x).
      j) Push (REF.ARRAY_ADDR a) to the stack.
      k) Push (I32.CONST (i + 1)) to the stack.
      l) Push (I32.CONST (j + ($storagesize(zt) / 8))) to the stack.
      m) Push (I32.CONST (n - 1)) to the stack.
      n) Execute (ARRAY.INIT_DATA x y).

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
7. If (i + n) > |$table(y).ELEM|, then:
  a. Trap.
8. If (j + n) > |$table(x).ELEM|, then:
  a. Trap.
9. If n is 0, then:
  a. Do nothing.
10. Else:
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
7. If (i + n) > |$elem(y).ELEM|, then:
  a. Trap.
8. If (j + n) > |$table(x).ELEM|, then:
  a. Trap.
9. If n is 0, then:
  a. Do nothing.
10. Else if i < |$elem(y).ELEM|, then:
  a. Push (I32.CONST j) to the stack.
  b. Push $elem(y).ELEM[i] to the stack.
  c. Execute (TABLE.SET x).
  d. Push (I32.CONST (j + 1)) to the stack.
  e. Push (I32.CONST (i + 1)) to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (TABLE.INIT x y).

execution_of_LOAD nt u_0? x mo
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If ((i + mo.OFFSET) + ($size(nt) / 8)) > |$mem(x).DATA| and u_0? is not defined, then:
  a. Trap.
4. If u_0? is not defined, then:
  a. Let c be $inverse_of_ntbytes(nt, $mem(x).DATA[(i + mo.OFFSET) : ($size(nt) / 8)]).
  b. Push (nt.CONST c) to the stack.
5. Else:
  a. Let ?(y_0) be u_0?.
  b. Let (n, sx) be y_0.
  c. If ((i + mo.OFFSET) + (n / 8)) > |$mem(x).DATA|, then:
    1) Trap.
  d. Let c be $inverse_of_ibytes(n, $mem(x).DATA[(i + mo.OFFSET) : (n / 8)]).
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
  c. Execute (STORE I32 ?(8) x $memop0()).
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
7. If (i_1 + n) > |$mem(x_1).DATA|, then:
  a. Trap.
8. If (i_2 + n) > |$mem(x_2).DATA|, then:
  a. Trap.
9. If n is 0, then:
  a. Do nothing.
10. Else:
  a. If i_1 ≤ i_2, then:
    1) Push (I32.CONST i_1) to the stack.
    2) Push (I32.CONST i_2) to the stack.
    3) Execute (LOAD I32 ?((8, U)) x_2 $memop0()).
    4) Execute (STORE I32 ?(8) x_1 $memop0()).
    5) Push (I32.CONST (i_1 + 1)) to the stack.
    6) Push (I32.CONST (i_2 + 1)) to the stack.
  b. Else:
    1) Push (I32.CONST ((i_1 + n) - 1)) to the stack.
    2) Push (I32.CONST ((i_2 + n) - 1)) to the stack.
    3) Execute (LOAD I32 ?((8, U)) x_2 $memop0()).
    4) Execute (STORE I32 ?(8) x_1 $memop0()).
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
7. If (i + n) > |$data(y).DATA|, then:
  a. Trap.
8. If (j + n) > |$mem(x).DATA|, then:
  a. Trap.
9. If n is 0, then:
  a. Do nothing.
10. Else if i < |$data(y).DATA|, then:
  a. Push (I32.CONST j) to the stack.
  b. Push (I32.CONST $data(y).DATA[i]) to the stack.
  c. Execute (STORE I32 ?(8) x $memop0()).
  d. Push (I32.CONST (j + 1)) to the stack.
  e. Push (I32.CONST (i + 1)) to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (MEMORY.INIT x y).

execution_of_STRUCT.NEW x
1. Assert: Due to validation, $expanddt($type(x)) is of the case STRUCT.
2. Let (STRUCT y_0) be $expanddt($type(x)).
3. Let (mut, zt)^n be y_0.
4. Assert: Due to validation, there are at least n values on the top of the stack.
5. Pop val^n from the stack.
6. Let si be { TYPE: $type(x); FIELD: $packval(zt, val)^n; }.
7. Push (REF.STRUCT_ADDR |$structinst()|) to the stack.
8. Perform $ext_structinst([si]).

execution_of_STRUCT.SET x i
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop u_0 from the stack.
5. If u_0 is of the case REF.NULL, then:
  a. Trap.
6. If u_0 is of the case REF.STRUCT_ADDR, then:
  a. Let (REF.STRUCT_ADDR a) be u_0.
  b. If a < |$structinst()| and $expanddt($structinst()[a].TYPE) is of the case STRUCT, then:
    1) Let (STRUCT y_0) be $expanddt($structinst()[a].TYPE).
    2) Let (mut, zt)* be y_0.
    3) If |mut*| is |zt*| and i < |zt*|, then:
      a) Let fv be $packval(zt*[i], val).
      b) Perform $with_struct(a, i, fv).

execution_of_ARRAY.NEW_FIXED x n
1. Assert: Due to validation, there are at least n values on the top of the stack.
2. Pop val^n from the stack.
3. Assert: Due to validation, $expanddt($type(x)) is of the case ARRAY.
4. Let (ARRAY y_0) be $expanddt($type(x)).
5. Let (mut, zt) be y_0.
6. Let ai be { TYPE: $type(x); FIELD: $packval(zt, val)^n; }.
7. Push (REF.ARRAY_ADDR |$arrayinst()|) to the stack.
8. Perform $ext_arrayinst([ai]).

execution_of_ARRAY.SET x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop u_0 from the stack.
7. If u_0 is of the case REF.NULL, then:
  a. Trap.
8. If u_0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be u_0.
  b. If a < |$arrayinst()|, then:
    1) If i ≥ |$arrayinst()[a].FIELD|, then:
      a) Trap.
    2) If $expanddt($arrayinst()[a].TYPE) is of the case ARRAY, then:
      a) Let (ARRAY y_0) be $expanddt($arrayinst()[a].TYPE).
      b) Let (mut, zt) be y_0.
      c) Let fv be $packval(zt, val).
      d) Perform $with_array(a, i, fv).

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
  a. Push (I32.CONST $invsigned(32, (- 1))) to the stack.

execution_of_ELEM.DROP x
1. Perform $with_elem(x, []).

execution_of_STORE nt u_0? x mo
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If ((i + mo.OFFSET) + ($size(nt) / 8)) > |$mem(x).DATA| and u_0? is not defined, then:
  a. Trap.
6. If u_0? is not defined, then:
  a. Let b* be $ntbytes(nt, c).
  b. Perform $with_mem(x, (i + mo.OFFSET), ($size(nt) / 8), b*).
7. Else:
  a. Let ?(n) be u_0?.
  b. If ((i + mo.OFFSET) + (n / 8)) > |$mem(x).DATA|, then:
    1) Trap.
  c. Let b* be $ibytes(n, $wrap($size(nt), n, c)).
  d. Perform $with_mem(x, (i + mo.OFFSET), (n / 8), b*).

execution_of_MEMORY.GROW x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Either:
  a. Let mi be $growmemory($mem(x), n).
  b. Push (I32.CONST (|$mem(x).DATA| / (64 · $Ki()))) to the stack.
  c. Perform $with_meminst(x, mi).
4. Or:
  a. Push (I32.CONST $invsigned(32, (- 1))) to the stack.

execution_of_DATA.DROP x
1. Perform $with_data(x, []).

eval_expr instr*
1. Execute the sequence (instr*).
2. Pop val from the stack.
3. Return [val].

execution_of_CALL_REF x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. If ref is of the case REF.NULL, then:
  a. Trap.
4. Assert: Due to validation, ref is of the case REF.FUNC_ADDR.
5. Let (REF.FUNC_ADDR a) be ref.
6. If a < |$funcinst()|, then:
  a. Let fi be $funcinst()[a].
  b. If fi.CODE is of the case FUNC, then:
    1) Let (FUNC y_0 y_1 instr*) be fi.CODE.
    2) Let (LOCAL t)* be y_1.
    3) If $expanddt(fi.TYPE) is of the case FUNC, then:
      a) Let (FUNC y_0) be $expanddt(fi.TYPE).
      b) Let [t_1^n]->[t_2^m] be y_0.
      c) Assert: Due to validation, there are at least n values on the top of the stack.
      d) Pop val^n from the stack.
      e) Let f be { LOCAL: ?(val)^n ++ $default(t)*; MODULE: fi.MODULE; }.
      f) Let F be the activation of f with arity m.
      g) Enter F with label [FRAME_]:
        1. Let L be the label_m{[]}.
        2. Enter L with label instr* ++ [LABEL_]:

group_bytes_by n byte*
1. Let n' be |byte*|.
2. If n' ≥ n, then:
  a. Return [byte*[0 : n]] ++ $group_bytes_by(n, byte*[n : (n' - n)]).
3. Return [].

execution_of_ARRAY.NEW_DATA x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If $expanddt($type(x)) is of the case ARRAY, then:
  a. Let (ARRAY y_0) be $expanddt($type(x)).
  b. Let (mut, zt) be y_0.
  c. If (i + ((n · $storagesize(zt)) / 8)) > |$data(y).DATA|, then:
    1) Trap.
  d. Let nt be $unpacknumtype(zt).
  e. Let b* be $data(y).DATA[i : ((n · $storagesize(zt)) / 8)].
  f. Let gb* be $group_bytes_by(($storagesize(zt) / 8), b*).
  g. Let c^n be $inverse_of_ibytes($storagesize(zt), gb)*.
  h. Push (nt.CONST c)^n to the stack.
  i. Execute (ARRAY.NEW_FIXED x n).

== Complete.
```
