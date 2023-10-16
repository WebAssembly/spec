# Preview

```sh
$ (cd ../spec && dune exec ../src/exe-watsup/main.exe -- *.watsup -v -l --sideconditions --animate --prose)
watsup 0.3 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions
== IL Validation...
== Running pass animate
Animation failed.
Valtype_sub: `|-%<:%`(t, t')
if ((t' = (numtype <: valtype)) \/ (t' = (vectype <: valtype)))
...Animation failed
Animation failed.
(if (l < |C.LABEL_context|))*{l}
if (l' < |C.LABEL_context|)
(Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])
...Animation failed
Animation failed.
if (0 < |C.MEM_context|)
if ((n?{n} = ?()) <=> (sx?{sx} = ?()))
if (C.MEM_context[0] = mt)
if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
(if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
if ((n?{n} = ?()) \/ (nt = (in <: numtype)))
...Animation failed
Animation failed.
if (0 < |C.MEM_context|)
if (C.MEM_context[0] = mt)
if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
(if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
if ((n?{n} = ?()) \/ (nt = (in <: numtype)))
...Animation failed
== IL Validation...
== Translating to AL...
{ LOCAL: val^k ++ $default_(t)*; MODULE: m; }
{ LOCAL: []; MODULE: m; }
{ LOCAL: []; MODULE: m_init; }
{ LOCAL: []; MODULE: m; }
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
- Under the context C with .LABEL prepended by [t_2*], instr* must be valid with type [t_1*]->[t_2*].
- Under the context C, bt must be valid with type [t_1*]->[t_2*].
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_LOOP bt instr*
- Under the context C with .LABEL prepended by [t_1*], instr* must be valid with type [t_1*]->[t_2*].
- Under the context C, bt must be valid with type [t_1*]->[t_2*].
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_IF bt instr_1* instr_2*
- Under the context C with .LABEL prepended by [t_2*], instr_2* must be valid with type [t_1*]->[t_2*].
- Under the context C, bt must be valid with type [t_1*]->[t_2*].
- Under the context C with .LABEL prepended by [t_2*], instr_1* must be valid with type [t_1*]->[t_2*].
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
  - C.LABEL[l] must match t*.
- C.LABEL[l'] must match t*.
- The instruction is valid with type [t_1* ++ t*]->[t_2*].

validation_of_RETURN
- Let ?(t*) be C.RETURN.
- The instruction is valid with type [t_1* ++ t*]->[t_2*].

validation_of_CALL x
- |C.FUNC| must be greater than x.
- Let [t_1*]->[t_2*] be C.FUNC[x].
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_CALL_INDIRECT x ft
- |C.TABLE| must be greater than x.
- Let (lim, FUNCREF) be C.TABLE[x].
- Let [t_1*]->[t_2*] be ft.
- The instruction is valid with type [t_1* ++ [I32]]->[t_2*].

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

validation_of_CVTOP in_1 CONVERT in_2 sx?
- in_1 must be different with in_2.
- ($size(in_1) > $size(in_2)) and (sx? is ?()) are equivalent.
- The instruction is valid with type [in_2]->[in_1].

validation_of_REF.NULL rt
- The instruction is valid with type []->[rt].

validation_of_REF.FUNC x
- |C.FUNC| must be greater than x.
- Let ft be C.FUNC[x].
- The instruction is valid with type []->[FUNCREF].

validation_of_REF.IS_NULL
- The instruction is valid with type [rt]->[I32].

validation_of_LOCAL.GET x
- |C.LOCAL| must be greater than x.
- Let t be C.LOCAL[x].
- The instruction is valid with type []->[t].

validation_of_LOCAL.SET x
- |C.LOCAL| must be greater than x.
- Let t be C.LOCAL[x].
- The instruction is valid with type [t]->[].

validation_of_LOCAL.TEE x
- |C.LOCAL| must be greater than x.
- Let t be C.LOCAL[x].
- The instruction is valid with type [t]->[t].

validation_of_GLOBAL.GET x
- |C.GLOBAL| must be greater than x.
- Let (mut?, t) be C.GLOBAL[x].
- The instruction is valid with type []->[t].

validation_of_GLOBAL.SET x
- |C.GLOBAL| must be greater than x.
- Let (MUT, t) be C.GLOBAL[x].
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
- Let (lim_1, rt) be C.TABLE[x_1].
- Let (lim_2, rt) be C.TABLE[x_2].
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_TABLE.INIT x_1 x_2
- |C.TABLE| must be greater than x_1.
- |C.ELEM| must be greater than x_2.
- Let (lim, rt) be C.TABLE[x_1].
- C.ELEM[x_2] must be equal to rt.
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_ELEM.DROP x
- |C.ELEM| must be greater than x.
- Let rt be C.ELEM[x].
- The instruction is valid with type []->[].

validation_of_MEMORY.SIZE
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type []->[I32].

validation_of_MEMORY.GROW
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type [I32]->[I32].

validation_of_MEMORY.FILL
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_MEMORY.COPY
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_MEMORY.INIT x
- |C.MEM| must be greater than 0.
- |C.DATA| must be greater than x.
- C.DATA[x] must be equal to OK.
- Let mt be C.MEM[0].
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_DATA.DROP x
- |C.DATA| must be greater than x.
- C.DATA[x] must be equal to OK.
- The instruction is valid with type []->[].

validation_of_LOAD nt [n, sx]? n_A n_O
- |C.MEM| must be greater than 0.
- (sx? is ?()) and (n? is ?()) are equivalent.
- (2 ^ n_A) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- C.MEM[0] must be equal to mt.
- If n is defined,
  - nt must be equal to in.
- The instruction is valid with type [I32]->[nt].

validation_of_STORE nt n? n_A n_O
- |C.MEM| must be greater than 0.
- (2 ^ n_A) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- C.MEM[0] must be equal to mt.
- If n is defined,
  - nt must be equal to in.
- The instruction is valid with type [I32, nt]->[].

Ki
1. Return 1024.

min x_0 x_1
1. If x_0 is 0, then:
  a. Return 0.
2. If x_1 is 0, then:
  a. Return 0.
3. Assert: Due to validation, x_0 ≥ 1.
4. Let i be (x_0 - 1).
5. Assert: Due to validation, x_1 ≥ 1.
6. Let j be (x_1 - 1).
7. Return $min(i, j).

size x_0
1. If x_0 is I32, then:
  a. Return 32.
2. If x_0 is I64, then:
  a. Return 64.
3. If x_0 is F32, then:
  a. Return 32.
4. If x_0 is F64, then:
  a. Return 64.
5. If x_0 is V128, then:
  a. Return 128.

test_sub_ATOM_22 n_3_ATOM_y
1. Return 0.

curried_ n_1 n_2
1. Return (n_1 + n_2).

default_ x_0
1. If x_0 is I32, then:
  a. Return (I32.CONST 0).
2. If x_0 is I64, then:
  a. Return (I64.CONST 0).
3. If x_0 is F32, then:
  a. Return (F32.CONST 0).
4. If x_0 is F64, then:
  a. Return (F64.CONST 0).
5. If x_0 is FUNCREF, then:
  a. Return (REF.NULL FUNCREF).
6. If x_0 is EXTERNREF, then:
  a. Return (REF.NULL EXTERNREF).

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
2. Replace f.LOCAL[x] with v.

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

grow_table ti n r
1. Let { TYPE: ((i, j), rt); ELEM: r'*; } be ti.
2. Let i' be (|r'*| + n).
3. Let ti' be { TYPE: ((i', j), rt); ELEM: r'* ++ r^n; }.
4. If ti'.TYPE is valid, then:
  a. Return ti'.

grow_memory mi n
1. Let { TYPE: (I8 (i, j)); DATA: b*; } be mi.
2. Let i' be ((|b*| / (64 · $Ki())) + n).
3. Let mi' be { TYPE: (I8 (i', j)); DATA: b* ++ 0^((n · 64) · $Ki()); }.
4. If mi'.TYPE is valid, then:
  a. Return mi'.

funcs x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [y_0] ++ externval'* be x_0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcs(externval'*).
4. Let [externval] ++ externval'* be x_0*.
5. Return $funcs(externval'*).

globals x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [y_0] ++ externval'* be x_0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globals(externval'*).
4. Let [externval] ++ externval'* be x_0*.
5. Return $globals(externval'*).

tables x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [y_0] ++ externval'* be x_0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tables(externval'*).
4. Let [externval] ++ externval'* be x_0*.
5. Return $tables(externval'*).

mems x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [y_0] ++ externval'* be x_0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $mems(externval'*).
4. Let [externval] ++ externval'* be x_0*.
5. Return $mems(externval'*).

instexport fa* ga* ta* ma* (EXPORT name x_0)
1. If x_0 is of the case FUNC, then:
  a. Let (FUNC x) be x_0.
  b. Return { NAME: name; VALUE: (FUNC fa*[x]); }.
2. If x_0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be x_0.
  b. Return { NAME: name; VALUE: (GLOBAL ga*[x]); }.
3. If x_0 is of the case TABLE, then:
  a. Let (TABLE x) be x_0.
  b. Return { NAME: name; VALUE: (TABLE ta*[x]); }.
4. Assert: Due to validation, x_0 is of the case MEM.
5. Let (MEM x) be x_0.
6. Return { NAME: name; VALUE: (MEM ma*[x]); }.

allocfunc m func
1. Let fi be { MODULE: m; CODE: func; }.
2. Return [s with .FUNC appended by [fi], |s.FUNC|].

allocfuncs m x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [func] ++ func'* be x_0*.
3. Let fa be $allocfunc(m, func).
4. Let fa'* be $allocfuncs(m, func'*).
5. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let gi be { TYPE: globaltype; VALUE: val; }.
2. Return [s with .GLOBAL appended by [gi], |s.GLOBAL|].

allocglobals x_0* x_1*
1. If x_0* is [], then:
  a. Assert: Due to validation, x_1* is [].
  b. Return [].
2. Else:
  a. Let [globaltype] ++ globaltype'* be x_0*.
  b. Assert: Due to validation, |x_1*| ≥ 1.
  c. Let [val] ++ val'* be x_1*.
  d. Let ga be $allocglobal(globaltype, val).
  e. Let ga'* be $allocglobals(globaltype'*, val'*).
  f. Return [ga] ++ ga'*.

alloctable ((i, j), rt)
1. Let ti be { TYPE: ((i, j), rt); ELEM: (REF.NULL rt)^i; }.
2. Return [s with .TABLE appended by [ti], |s.TABLE|].

alloctables x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [tabletype] ++ tabletype'* be x_0*.
3. Let ta be $alloctable(tabletype).
4. Let ta'* be $alloctables(tabletype'*).
5. Return [ta] ++ ta'*.

allocmem (I8 (i, j))
1. Let mi be { TYPE: (I8 (i, j)); DATA: 0^((i · 64) · $Ki()); }.
2. Return [s with .MEM appended by [mi], |s.MEM|].

allocmems x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [memtype] ++ memtype'* be x_0*.
3. Let ma be $allocmem(memtype).
4. Let ma'* be $allocmems(memtype'*).
5. Return [ma] ++ ma'*.

allocelem rt ref*
1. Let ei be { TYPE: rt; ELEM: ref*; }.
2. Return [s with .ELEM appended by [ei], |s.ELEM|].

allocelems x_0* x_1*
1. If x_0* is [] and x_1* is [], then:
  a. Return [].
2. Assert: Due to validation, |x_1*| ≥ 1.
3. Let [ref*] ++ ref'** be x_1*.
4. Assert: Due to validation, |x_0*| ≥ 1.
5. Let [rt] ++ rt'* be x_0*.
6. Let ea be $allocelem(rt, ref*).
7. Let ea'* be $allocelems(rt'*, ref'**).
8. Return [ea] ++ ea'*.

allocdata byte*
1. Let di be { DATA: byte*; }.
2. Return [s with .DATA appended by [di], |s.DATA|].

allocdatas x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [byte*] ++ byte'** be x_0*.
3. Let da be $allocdata(byte*).
4. Let da'* be $allocdatas(byte'**).
5. Return [da] ++ da'*.

allocmodule module externval* val* ref**
1. Let fa_ex* be $funcs(externval*).
2. Let ga_ex* be $globals(externval*).
3. Let ma_ex* be $mems(externval*).
4. Let ta_ex* be $tables(externval*).
5. Assert: Due to validation, module is of the case MODULE.
6. Let (MODULE import* func^n_func y_0 y_1 y_2 y_3 y_4 start? export*) be module.
7. Let (DATA byte* datamode?)^n_data be y_4.
8. Let (ELEM rt expr_2* elemmode?)^n_elem be y_3.
9. Let (MEMORY memtype)^n_mem be y_2.
10. Let (TABLE tabletype)^n_table be y_1.
11. Let (GLOBAL globaltype expr_1)^n_global be y_0.
12. Let da* be (|s.DATA| + i_data)^(i_data<n_data).
13. Let ea* be (|s.ELEM| + i_elem)^(i_elem<n_elem).
14. Let ma* be (|s.MEM| + i_mem)^(i_mem<n_mem).
15. Let ta* be (|s.TABLE| + i_table)^(i_table<n_table).
16. Let ga* be (|s.GLOBAL| + i_global)^(i_global<n_global).
17. Let fa* be (|s.FUNC| + i_func)^(i_func<n_func).
18. Let xi* be $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*.
19. Let m be { FUNC: fa_ex* ++ fa*; GLOBAL: ga_ex* ++ ga*; TABLE: ta_ex* ++ ta*; MEM: ma_ex* ++ ma*; ELEM: ea*; DATA: da*; EXPORT: xi*; }.
20. Let y_0 be $allocfuncs(m, func^n_func).
21. Assert: Due to validation, y_0 is fa*.
22. Let y_0 be $allocglobals(globaltype^n_global, val*).
23. Assert: Due to validation, y_0 is ga*.
24. Let y_0 be $alloctables(tabletype^n_table).
25. Assert: Due to validation, y_0 is ta*.
26. Let y_0 be $allocmems(memtype^n_mem).
27. Assert: Due to validation, y_0 is ma*.
28. Let y_0 be $allocelems(rt^n_elem, ref**).
29. Assert: Due to validation, y_0 is ea*.
30. Let y_0 be $allocdatas(byte*^n_data).
31. Assert: Due to validation, y_0 is da*.
32. Return m.

runelem (ELEM reftype expr* x_0?) i
1. If x_0? is not defined, then:
  a. Return [].
2. If x_0? is ?(DECLARE), then:
  a. Return [(ELEM.DROP i)].
3. Assert: Due to validation, x_0? is defined.
4. Let ?(y_0) be x_0?.
5. Assert: Due to validation, y_0 is of the case TABLE.
6. Let (TABLE x instr*) be y_0.
7. Let n be |expr*|.
8. Return instr* ++ [(I32.CONST 0), (I32.CONST n), (TABLE.INIT x i), (ELEM.DROP i)].

rundata (DATA byte* x_0?) i
1. If x_0? is not defined, then:
  a. Return [].
2. Let ?(y_0) be x_0?.
3. Assert: Due to validation, y_0 is of the case MEMORY.
4. Let (MEMORY y_1 instr*) be y_0.
5. Assert: Due to validation, y_1 is 0.
6. Let n be |byte*|.
7. Return instr* ++ [(I32.CONST 0), (I32.CONST n), (MEMORY.INIT i), (DATA.DROP i)].

concat_instr x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [instr*] ++ instr'** be x_0*.
3. Return instr* ++ $concat_instr(instr'**).

instantiation module externval*
1. Assert: Due to validation, module is of the case MODULE.
2. Let (MODULE import* func^n_func global* table* mem* elem* data* start? export*) be module.
3. Let m_init be { FUNC: $funcs(externval*) ++ (|s.FUNC| + i_func)^(i_func<n_func); GLOBAL: $globals(externval*); TABLE: []; MEM: []; ELEM: []; DATA: []; EXPORT: []; }.
4. Let n_data be |data*|.
5. Let n_elem be |elem*|.
6. Let (START x)? be start?.
7. Let (GLOBAL globaltype instr_1*)* be global*.
8. Let (ELEM reftype instr_2** elemmode?)* be elem*.
9. Let f_init be { LOCAL: []; MODULE: m_init; }.
10. Let instr_data* be $concat_instr($rundata(data*[j], j)^(j<n_data)).
11. Let instr_elem* be $concat_instr($runelem(elem*[i], i)^(i<n_elem)).
12. Push the activation of f_init to the stack.
13. Let ref** be $exec_expr_const(instr_2*)**.
14. Pop the activation of f_init from the stack.
15. Push the activation of f_init to the stack.
16. Let val* be $exec_expr_const(instr_1*)*.
17. Pop the activation of f_init from the stack.
18. Let m be $allocmodule(module, externval*, val*, ref**).
19. Let f be { LOCAL: []; MODULE: m; }.
20. Push the activation of f to the stack.
21. Execute the sequence (instr_elem*).
22. Execute the sequence (instr_data*).
23. If x is defined, then:
  a. Let ?(x_0) be x.
  b. Execute (CALL x_0).
24. Pop the activation of f from the stack.
25. Return m.

invocation fa val^n
1. Let m be { FUNC: []; GLOBAL: []; TABLE: []; MEM: []; ELEM: []; DATA: []; EXPORT: []; }.
2. Let f be { LOCAL: []; MODULE: m; }.
3. Assert: Due to validation, $funcinst()[fa].CODE is of the case FUNC.
4. Let (FUNC functype valtype* expr) be $funcinst()[fa].CODE.
5. Let [valtype_param^n]->[valtype_res^k] be functype.
6. Push the activation of f to the stack.
7. Push val^n to the stack.
8. Execute (CALL_ADDR fa).
9. Pop val^k from the stack.
10. Pop the activation of f from the stack.
11. Return val^k.

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
3. Pop the label from the stack.
4. Exit current context.
5. Push val* to the stack.

execution_of_BR x_0
1. Let L be the current label.
2. Let n be the arity of L.
3. Let instr'* be the continuation of L.
4. Pop all values x_1* from the stack.
5. Exit current context.
6. If x_0 is 0 and |x_1*| ≥ n, then:
  a. Let val'* ++ val^n be x_1*.
  b. Push val^n to the stack.
  c. Execute the sequence (instr'*).
7. If x_0 ≥ 1, then:
  a. Let l be (x_0 - 1).
  b. Let val* be x_1*.
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

execution_of_FRAME_
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop val^n from the stack.
5. Assert: Due to validation, a frame is now on the top of the stack.
6. Pop the frame from the stack.
7. Exit current context.
8. Push val^n to the stack.

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
3. If |$cvtop(nt_1, cvtop, nt_2, sx?, c_1)| is 1, then:
  a. Let [c] be $cvtop(nt_1, cvtop, nt_2, sx?, c_1).
  b. Push (nt_2.CONST c) to the stack.
4. If $cvtop(nt_1, cvtop, nt_2, sx?, c_1) is [], then:
  a. Trap.

execution_of_REF.IS_NULL
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. If val is not of the case REF.NULL, then:
  a. Push (I32.CONST 0) to the stack.
4. Else:
  a. Push (I32.CONST 1) to the stack.

execution_of_LOCAL.TEE x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Push val to the stack.
4. Push val to the stack.
5. Execute (LOCAL.SET x).

execution_of_CALL x
1. Assert: Due to validation, x < |$funcaddr()|.
2. Execute (CALL_ADDR $funcaddr()[x]).

execution_of_CALL_INDIRECT x ft
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If i ≥ |$table(x).ELEM|, then:
  a. Trap.
4. If $table(x).ELEM[i] is not of the case REF.FUNC_ADDR, then:
  a. Trap.
5. Let (REF.FUNC_ADDR a) be $table(x).ELEM[i].
6. If a ≥ |$funcinst()|, then:
  a. Trap.
7. If $funcinst()[a].CODE is not of the case FUNC, then:
  a. Trap.
8. Let (FUNC ft' t* instr*) be $funcinst()[a].CODE.
9. If ft is not ft', then:
  a. Trap.
10. Execute (CALL_ADDR a).

execution_of_CALL_ADDR a
1. Assert: Due to validation, a < |$funcinst()|.
2. Let { MODULE: m; CODE: func; } be $funcinst()[a].
3. Assert: Due to validation, func is of the case FUNC.
4. Let (FUNC y_0 t* instr*) be func.
5. Let [t_1^k]->[t_2^n] be y_0.
6. Assert: Due to validation, there are at least k values on the top of the stack.
7. Pop val^k from the stack.
8. Let f be { LOCAL: val^k ++ $default_(t)*; MODULE: m; }.
9. Let F be the activation of f with arity n.
10. Enter F with label [FRAME_]:
  a. Let L be the label_n{[]}.
  b. Enter L with label instr*:

execution_of_REF.FUNC x
1. Assert: Due to validation, x < |$funcaddr()|.
2. Push (REF.FUNC_ADDR $funcaddr()[x]) to the stack.

execution_of_LOCAL.GET x
1. Push $local(x) to the stack.

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

execution_of_LOAD nt x_0? n_A n_O
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If x_0? is not defined, then:
  a. If ((i + n_O) + ($size(nt) / 8)) > |$mem(0).DATA|, then:
    1) Trap.
  b. Let c be $inverse_of_bytes_($size(nt), $mem(0).DATA[(i + n_O) : ($size(nt) / 8)]).
  c. Push (nt.CONST c) to the stack.
4. Else:
  a. Let ?(y_0) be x_0?.
  b. Let [n, sx] be y_0.
  c. If ((i + n_O) + (n / 8)) > |$mem(0).DATA|, then:
    1) Trap.
  d. Let c be $inverse_of_bytes_(n, $mem(0).DATA[(i + n_O) : (n / 8)]).
  e. Push (nt.CONST $ext(n, $size(nt), sx, c)) to the stack.

execution_of_MEMORY.SIZE
1. Let ((n · 64) · $Ki()) be |$mem(0).DATA|.
2. Push (I32.CONST n) to the stack.

execution_of_MEMORY.FILL
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. If (i + n) > |$mem(0).DATA|, then:
  a. Trap.
8. If n is 0, then:
  a. Do nothing.
9. Else:
  a. Push (I32.CONST i) to the stack.
  b. Push val to the stack.
  c. Execute (STORE I32 ?(8) 0 0).
  d. Push (I32.CONST (i + 1)) to the stack.
  e. Push val to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute MEMORY.FILL.

execution_of_MEMORY.COPY
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$mem(0).DATA| or (j + n) > |$mem(0).DATA|, then:
  a. Trap.
8. If n is 0, then:
  a. Do nothing.
9. Else:
  a. If j ≤ i, then:
    1) Push (I32.CONST j) to the stack.
    2) Push (I32.CONST i) to the stack.
    3) Execute (LOAD I32 ?([8, U]) 0 0).
    4) Execute (STORE I32 ?(8) 0 0).
    5) Push (I32.CONST (j + 1)) to the stack.
    6) Push (I32.CONST (i + 1)) to the stack.
  b. Else:
    1) Push (I32.CONST ((j + n) - 1)) to the stack.
    2) Push (I32.CONST ((i + n) - 1)) to the stack.
    3) Execute (LOAD I32 ?([8, U]) 0 0).
    4) Execute (STORE I32 ?(8) 0 0).
    5) Push (I32.CONST j) to the stack.
    6) Push (I32.CONST i) to the stack.
  c. Push (I32.CONST (n - 1)) to the stack.
  d. Execute MEMORY.COPY.

execution_of_MEMORY.INIT x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$data(x).DATA| or (j + n) > |$mem(0).DATA|, then:
  a. Trap.
8. If n is 0, then:
  a. Do nothing.
9. Else if i < |$data(x).DATA|, then:
  a. Push (I32.CONST j) to the stack.
  b. Push (I32.CONST $data(x).DATA[i]) to the stack.
  c. Execute (STORE I32 ?(8) 0 0).
  d. Push (I32.CONST (j + 1)) to the stack.
  e. Push (I32.CONST (i + 1)) to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (MEMORY.INIT x).

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
  a. Let ti be $grow_table($table(x), n, ref).
  b. Push (I32.CONST |$table(x).ELEM|) to the stack.
  c. Perform $with_tableinst(x, ti).
6. Or:
  a. Push (I32.CONST -1) to the stack.

execution_of_ELEM.DROP x
1. Perform $with_elem(x, []).

execution_of_STORE nt x_0? n_A n_O
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If x_0? is not defined, then:
  a. If ((i + n_O) + ($size(nt) / 8)) > |$mem(0).DATA|, then:
    1) Trap.
  b. Let b* be $bytes_($size(nt), c).
  c. Perform $with_mem(0, (i + n_O), ($size(nt) / 8), b*).
6. Else:
  a. Let ?(n) be x_0?.
  b. If ((i + n_O) + (n / 8)) > |$mem(0).DATA|, then:
    1) Trap.
  c. Let b* be $bytes_(n, $wrap_([$size(nt), n], c)).
  d. Perform $with_mem(0, (i + n_O), (n / 8), b*).

execution_of_MEMORY.GROW
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Either:
  a. Let mi be $grow_memory($mem(0), n).
  b. Push (I32.CONST (|$mem(0).DATA| / (64 · $Ki()))) to the stack.
  c. Perform $with_meminst(0, mi).
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
