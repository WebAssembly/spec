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
if (x_1 < |C.TABLE_context|)
if (x_2 < |C.TABLE_context|)
if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
if (C.TABLE_context[x_2] = `%%`(lim_2, rt))
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
Animation failed.
if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func^n_func{func}, GLOBAL(globaltype, expr_1)^n_global{expr_1 globaltype}, TABLE(tabletype)^n_table{tabletype}, MEMORY(memtype)^n_mem{memtype}, `ELEM%%*%?`(rt, expr_2*{expr_2}, elemmode?{elemmode})^n_elem{elemmode expr_2 rt}, `DATA%*%?`(byte*{byte}, datamode?{datamode})^n_data{byte datamode}, start?{start}, export*{export}))
if (fa_ex*{fa_ex} = $funcs(externval*{externval}))
if (ga_ex*{ga_ex} = $globals(externval*{externval}))
if (ta_ex*{ta_ex} = $tables(externval*{externval}))
if (ma_ex*{ma_ex} = $mems(externval*{externval}))
if (fa*{fa} = (|s.FUNC_store| + i)^(i < n_func){})
if (ga*{ga} = (|s.GLOBAL_store| + i)^(i < n_global){})
if (ta*{ta} = (|s.TABLE_store| + i)^(i < n_table){})
if (ma*{ma} = (|s.MEM_store| + i)^(i < n_mem){})
if (ea*{ea} = (|s.ELEM_store| + i)^(i < n_elem){})
if (da*{da} = (|s.DATA_store| + i)^(i < n_data){})
if (xi*{xi} = $instexport(fa_ex*{fa_ex} :: fa*{fa}, ga_ex*{ga_ex} :: ga*{ga}, ta_ex*{ta_ex} :: ta*{ta}, ma_ex*{ma_ex} :: ma*{ma}, export)*{export})
if (m = {FUNC fa_ex*{fa_ex} :: fa*{fa}, GLOBAL ga_ex*{ga_ex} :: ga*{ga}, TABLE ta_ex*{ta_ex} :: ta*{ta}, MEM ma_ex*{ma_ex} :: ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT xi*{xi}})
if ((s_1, fa*{fa}) = $allocfuncs(s, m, func^n_func{func}))
if ((s_2, ga*{ga}) = $allocglobals(s_1, globaltype^n_global{globaltype}, val*{val}))
if ((s_3, ta*{ta}) = $alloctables(s_2, tabletype^n_table{tabletype}))
if ((s_4, ma*{ma}) = $allocmems(s_3, memtype^n_mem{memtype}))
if ((s_5, ea*{ea}) = $allocelems(s_4, rt^n_elem{rt}, ref*{ref}*{ref}))
if ((s_6, da*{da}) = $allocdatas(s_5, byte*{byte}^n_data{byte}))
...Animation failed
Animation failed.
if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
if (m_init = {FUNC $funcs(externval*{externval}), GLOBAL $globals(externval*{externval}), TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
if (f_init = {LOCAL [], MODULE m_init})
(if (global = GLOBAL(globaltype, instr_1*{instr_1})))*{global globaltype instr_1}
(Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), (instr_1 <: admininstr)*{instr_1}), [(val <: admininstr)]))*{instr_1 val}
(if (elem = `ELEM%%*%?`(reftype, instr_2*{instr_2}*{instr_2}, elemmode?{elemmode})))*{elem elemmode instr_2 reftype}
(Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), (instr_2 <: admininstr)*{instr_2}), [(ref <: admininstr)]))*{instr_2 ref}*{instr_2 ref}
if ((s', m) = $allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}))
if (f = {LOCAL [], MODULE m})
if (n_elem = |elem*{elem}|)
if (instr_elem*{instr_elem}*{instr_elem} = $runelem(elem*{elem}[i], i)^(i < n_elem){})
if (n_data = |data*{data}|)
if (instr_data*{instr_data}*{instr_data} = $rundata(data*{data}[j], j)^(j < n_data){})
if (start?{start} = START(x)?{x})
...Animation failed
== IL Validation...
== Translating to AL...
Invalid premise `(if (global = GLOBAL(globaltype, instr_1*{instr_1})))*{global globaltype instr_1}` to be AL instr.
Invalid premise `(Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), (instr_2 <: admininstr)*{instr_2}), [(ref <: admininstr)]))*{instr_2 ref}*{instr_2 ref}` to be AL instr.
Invalid expression `(i < n_elem)` to be AL identifier.
Invalid expression `(j < n_data)` to be AL identifier.
Invalid premise `(where `ELEM%%*%?`(reftype, instr_2*{instr_2}*{instr_2}, elemmode?{elemmode}) = elem)*{elem elemmode instr_2 reftype}` to be AL instr.
=================
 Generated prose
=================
validation_of_unreachable
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_nop
- The instruction is valid with type []->[].

validation_of_drop
- The instruction is valid with type [t]->[].

validation_of_select ?(t)
- The instruction is valid with type [t, t, I32]->[t].

validation_of_block bt instr*
- Under the context C with .LABEL prepended by t_2*, instr* must be valid with type [t_1*]->[t_2*].
- Under the context C, bt must be valid with type [t_1*]->[t_2*].
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_loop bt instr*
- Under the context C with .LABEL prepended by t_1*, instr* must be valid with type [t_1*]->[t_2*].
- Under the context C, bt must be valid with type [t_1*]->[t_2*].
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_if bt instr_1* instr_2*
- Under the context C with .LABEL prepended by t_2*, instr_2* must be valid with type [t_1*]->[t_2*].
- Under the context C, bt must be valid with type [t_1*]->[t_2*].
- Under the context C with .LABEL prepended by t_2*, instr_1* must be valid with type [t_1*]->[t_2*].
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_br l
- |C.LABEL| must be greater than l.
- Let t* be C.LABEL[l].
- The instruction is valid with type [t_1* ++ t*]->[t_2*].

validation_of_br_if l
- |C.LABEL| must be greater than l.
- Let t* be C.LABEL[l].
- The instruction is valid with type [t* ++ [I32]]->[t*].

validation_of_br_table l* l'
- |C.LABEL| must be greater than l'.
- For all l in l*,
  - |C.LABEL| must be greater than l.
- C.LABEL[l'] must match t*.
- For all l in l*,
  - C.LABEL[l] must match t*.
- The instruction is valid with type [t_1* ++ t*]->[t_2*].

validation_of_return
- Let ?(t*) be C.RETURN.
- The instruction is valid with type [t_1* ++ t*]->[t_2*].

validation_of_call x
- |C.FUNC| must be greater than x.
- Let [t_1*]->[t_2*] be C.FUNC[x].
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_call_indirect x ft
- |C.TABLE| must be greater than x.
- Let (lim, FUNCREF) be C.TABLE[x].
- Let [t_1*]->[t_2*] be ft.
- The instruction is valid with type [t_1* ++ [I32]]->[t_2*].

validation_of_const nt c_nt
- The instruction is valid with type []->[nt].

validation_of_unop nt unop
- The instruction is valid with type [nt]->[nt].

validation_of_binop nt binop
- The instruction is valid with type [nt, nt]->[nt].

validation_of_testop nt testop
- The instruction is valid with type [nt]->[I32].

validation_of_relop nt relop
- The instruction is valid with type [nt, nt]->[I32].

validation_of_extend nt n
- n must be less than or equal to $size(nt).
- The instruction is valid with type [nt]->[nt].

validation_of_reinterpret nt_1 REINTERPRET nt_2 ?()
- nt_1 must be different with nt_2.
- $size(nt_1) must be equal to $size(nt_2).
- The instruction is valid with type [nt_2]->[nt_1].

validation_of_convert in_1 CONVERT in_2 sx?
- in_1 must be different with in_2.
- ($size(in_1) > $size(in_2)) and (sx? is ?()) are equivalent.
- The instruction is valid with type [in_2]->[in_1].

validation_of_ref.null rt
- The instruction is valid with type []->[rt].

validation_of_ref.func x
- |C.FUNC| must be greater than x.
- Let ft be C.FUNC[x].
- The instruction is valid with type []->[FUNCREF].

validation_of_ref.is_null
- The instruction is valid with type [rt]->[I32].

validation_of_local.get x
- |C.LOCAL| must be greater than x.
- Let t be C.LOCAL[x].
- The instruction is valid with type []->[t].

validation_of_local.set x
- |C.LOCAL| must be greater than x.
- Let t be C.LOCAL[x].
- The instruction is valid with type [t]->[].

validation_of_local.tee x
- |C.LOCAL| must be greater than x.
- Let t be C.LOCAL[x].
- The instruction is valid with type [t]->[t].

validation_of_global.get x
- |C.GLOBAL| must be greater than x.
- Let (mut?, t) be C.GLOBAL[x].
- The instruction is valid with type []->[t].

validation_of_global.set x
- |C.GLOBAL| must be greater than x.
- Let (MUT, t) be C.GLOBAL[x].
- The instruction is valid with type [t]->[].

validation_of_table.get x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type [I32]->[rt].

validation_of_table.set x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type [I32, rt]->[].

validation_of_table.size x
- |C.TABLE| must be greater than x.
- Let tt be C.TABLE[x].
- The instruction is valid with type []->[I32].

validation_of_table.grow x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type [rt, I32]->[I32].

validation_of_table.fill x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type [I32, rt, I32]->[].

validation_of_table.copy x_1 x_2
- |C.TABLE| must be greater than x_1.
- |C.TABLE| must be greater than x_2.
- Let (lim_1, rt) be C.TABLE[x_1].
- C.TABLE[x_2] must be equal to (lim_2, rt).
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_table.init x_1 x_2
- |C.TABLE| must be greater than x_1.
- |C.ELEM| must be greater than x_2.
- Let (lim, rt) be C.TABLE[x_1].
- C.ELEM[x_2] must be equal to rt.
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_elem.drop x
- |C.ELEM| must be greater than x.
- Let rt be C.ELEM[x].
- The instruction is valid with type []->[].

validation_of_memory.size
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type []->[I32].

validation_of_memory.grow
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type [I32]->[I32].

validation_of_memory.fill
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type [I32, I32, I32]->[I32].

validation_of_memory.copy
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type [I32, I32, I32]->[I32].

validation_of_memory.init x
- |C.MEM| must be greater than 0.
- |C.DATA| must be greater than x.
- C.DATA[x] must be equal to OK.
- Let mt be C.MEM[0].
- The instruction is valid with type [I32, I32, I32]->[I32].

validation_of_data.drop x
- |C.DATA| must be greater than x.
- C.DATA[x] must be equal to OK.
- The instruction is valid with type []->[].

validation_of_load nt [n, sx]? n_A n_O
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- (2 ^ n_A) must be less than or equal to ($size(nt) / 8).
- (sx? is ?()) and (n? is ?()) are equivalent.
- |C.MEM| must be greater than 0.
- If n is defined,
  - nt must be equal to in.
- C.MEM[0] must be equal to mt.
- The instruction is valid with type [I32]->[nt].

validation_of_store nt n? n_A n_O
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- (2 ^ n_A) must be less than or equal to ($size(nt) / 8).
- |C.MEM| must be greater than 0.
- If n is defined,
  - nt must be equal to in.
- C.MEM[0] must be equal to mt.
- The instruction is valid with type [I32, nt]->[].

Ki
1. Return 1024.

min x_0 x_1
1. If x_0 is 0, then:
  a. Let j be x_1.
  b. Return 0.
2. If x_1 is 0, then:
  a. Let i be x_0.
  b. Return 0.
3. If x_0 ≥ 1, then:
  a. Let i be (x_0 - 1).
  b. If x_1 ≥ 1, then:
    1) Let j be (x_1 - 1).
    2) Let r_0 be the result of computing $min(i, j).
    3) Return r_0.

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
1. Let f be the current frame.
2. Return s.FUNC.

globalinst
1. Let f be the current frame.
2. Return s.GLOBAL.

tableinst
1. Let f be the current frame.
2. Return s.TABLE.

meminst
1. Let f be the current frame.
2. Return s.MEM.

eleminst
1. Let f be the current frame.
2. Return s.ELEM.

datainst
1. Let f be the current frame.
2. Return s.DATA.

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
2. Let r_0 be the result of computing $Ki().
3. Let i' be ((|b*| / (64 · r_0)) + n).
4. Let r_1 be the result of computing $Ki().
5. Let mi' be { TYPE: (I8 (i', j)); DATA: b* ++ 0^((n · 64) · r_1); }.
6. If mi'.TYPE is valid, then:
  a. Return mi'.

funcs x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [(FUNC fa)] ++ externval'* be x_0*.
3. Let r_0 be the result of computing $funcs(externval'*).
4. Return [fa] ++ r_0.
5. Let [externval] ++ externval'* be x_0*.
6. Otherwise:
  a. Let r_1 be the result of computing $funcs(externval'*).
  b. Return r_1.

globals x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [(GLOBAL ga)] ++ externval'* be x_0*.
3. Let r_0 be the result of computing $globals(externval'*).
4. Return [ga] ++ r_0.
5. Let [externval] ++ externval'* be x_0*.
6. Otherwise:
  a. Let r_1 be the result of computing $globals(externval'*).
  b. Return r_1.

tables x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [(TABLE ta)] ++ externval'* be x_0*.
3. Let r_0 be the result of computing $tables(externval'*).
4. Return [ta] ++ r_0.
5. Let [externval] ++ externval'* be x_0*.
6. Otherwise:
  a. Let r_1 be the result of computing $tables(externval'*).
  b. Return r_1.

mems x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [(MEM ma)] ++ externval'* be x_0*.
3. Let r_0 be the result of computing $mems(externval'*).
4. Return [ma] ++ r_0.
5. Let [externval] ++ externval'* be x_0*.
6. Otherwise:
  a. Let r_1 be the result of computing $mems(externval'*).
  b. Return r_1.

instexport fa* ga* ta* ma* EXPORT(name, x_0)
1. If x_0 is of the case FUNC, then:
  a. Let (FUNC x) be x_0.
  b. Return { NAME: name; VALUE: (FUNC fa*[x]); }.
2. If x_0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be x_0.
  b. Return { NAME: name; VALUE: (GLOBAL ga*[x]); }.
3. If x_0 is of the case TABLE, then:
  a. Let (TABLE x) be x_0.
  b. Return { NAME: name; VALUE: (TABLE ta*[x]); }.
4. If x_0 is of the case MEM, then:
  a. Let (MEM x) be x_0.
  b. Return { NAME: name; VALUE: (MEM ma*[x]); }.

allocfunc m func
1. Let fi be { MODULE: m; CODE: func; }.
2. Return [s with .FUNC appended by [fi], |s.FUNC|].

allocfuncs m x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [func] ++ func'* be x_0*.
3. Let fa be the result of computing $allocfunc(m, func).
4. Let fa'* be the result of computing $allocfuncs(m, func'*).
5. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let gi be { TYPE: globaltype; VALUE: val; }.
2. Return [s with .GLOBAL appended by [gi], |s.GLOBAL|].

allocglobals x_0* x_1*
1. If x_0* is [] and x_1* is [], then:
  a. Return [].
2. Let [globaltype] ++ globaltype'* be x_0*.
3. Let [val] ++ val'* be x_1*.
4. Let ga be the result of computing $allocglobal(globaltype, val).
5. Let ga'* be the result of computing $allocglobals(globaltype'*, val'*).
6. Return [ga] ++ ga'*.

alloctable `%%`(`[%..%]`(i, j), rt)
1. Let ti be { TYPE: ((i, j), rt); ELEM: (REF.NULL rt)^i; }.
2. Return [s with .TABLE appended by [ti], |s.TABLE|].

alloctables x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [tabletype] ++ tabletype'* be x_0*.
3. Let ta be the result of computing $alloctable(tabletype).
4. Let ta'* be the result of computing $alloctables(tabletype'*).
5. Return [ta] ++ ta'*.

allocmem `%I8`(`[%..%]`(i, j))
1. Let r_0 be the result of computing $Ki().
2. Let mi be { TYPE: (I8 (i, j)); DATA: 0^((i · 64) · r_0); }.
3. Return [s with .MEM appended by [mi], |s.MEM|].

allocmems x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [memtype] ++ memtype'* be x_0*.
3. Let ma be the result of computing $allocmem(memtype).
4. Let ma'* be the result of computing $allocmems(memtype'*).
5. Return [ma] ++ ma'*.

allocelem rt ref*
1. Let ei be { TYPE: rt; ELEM: ref*; }.
2. Return [s with .ELEM appended by [ei], |s.ELEM|].

allocelems x_0* x_1*
1. If x_0* is [] and x_1* is [], then:
  a. Return [].
2. Let ref* ++ ref'** be x_1*.
3. Let [rt] ++ rt'* be x_0*.
4. Let ea be the result of computing $allocelem(rt, ref*).
5. Let ea'* be the result of computing $allocelems(rt'*, ref'**).
6. Return [ea] ++ ea'*.

allocdata byte*
1. Let di be { DATA: byte*; }.
2. Return [s with .DATA appended by [di], |s.DATA|].

allocdatas x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let byte* ++ byte'** be x_0*.
3. Let da be the result of computing $allocdata(byte*).
4. Let da'* be the result of computing $allocdatas(byte'**).
5. Return [da] ++ da'*.

allocmodule module externval* val* ref**
1. Let r_0 be the result of computing $funcs(externval*).
2. Let r_1 be the result of computing $globals(externval*).
3. Let r_2 be the result of computing $tables(externval*).
4. Let r_3 be the result of computing $mems(externval*).
5. Let r_4 be the result of computing $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*.
6. Let r_5 be the result of computing $allocfuncs(m, func^n_func).
7. Let r_6 be the result of computing $allocglobals(globaltype^n_global, val*).
8. Let r_7 be the result of computing $alloctables(tabletype^n_table).
9. Let r_8 be the result of computing $allocmems(memtype^n_mem).
10. Let r_9 be the result of computing $allocelems(rt^n_elem, ref**).
11. Let r_10 be the result of computing $allocdatas(byte*^n_data).
12. If da* is r_10 and ea* is r_9 and ma* is r_8 and ta* is r_7 and ga* is r_6 and fa* is r_5 and m is { FUNC: fa_ex* ++ fa*; GLOBAL: ga_ex* ++ ga*; TABLE: ta_ex* ++ ta*; MEM: ma_ex* ++ ma*; ELEM: ea*; DATA: da*; EXPORT: xi*; } and xi* is r_4 and da* is (|s.DATA| + i)^YetE (CmpE (VarE "i", LtOp, VarE "n_data")) and ea* is (|s.ELEM| + i)^YetE (CmpE (VarE "i", LtOp, VarE "n_elem")) and ma* is (|s.MEM| + i)^YetE (CmpE (VarE "i", LtOp, VarE "n_mem")) and ta* is (|s.TABLE| + i)^YetE (CmpE (VarE "i", LtOp, VarE "n_table")) and ga* is (|s.GLOBAL| + i)^YetE (CmpE (VarE "i", LtOp, VarE "n_global")) and fa* is (|s.FUNC| + i)^YetE (CmpE (VarE "i", LtOp, VarE "n_func")) and ma_ex* is r_3 and ta_ex* is r_2 and ga_ex* is r_1 and fa_ex* is r_0 and module is (MODULE import* func^n_func YetE (IterE (MixE ([[Atom "GLOBAL"], [], []], TupE ([VarE "globaltype", VarE "expr_1"])), (ListN (VarE "n_global"), ["expr_1", "globaltype"]))) (TABLE tabletype)^n_table (MEMORY memtype)^n_mem YetE (IterE (MixE ([[Atom "ELEM"], [], [Star], [Quest]], TupE ([VarE "rt", IterE (VarE "expr_2", (List, ["expr_2"])), IterE (VarE "elemmode", (Opt, ["elemmode"]))])), (ListN (VarE "n_elem"), ["elemmode", "expr_2", "rt"]))) YetE (IterE (MixE ([[Atom "DATA"], [Star], [Quest]], TupE ([IterE (VarE "byte", (List, ["byte"])), IterE (VarE "datamode", (Opt, ["datamode"]))])), (ListN (VarE "n_data"), ["byte", "datamode"]))) start? export*), then:
  a. Return m.

runelem `ELEM%%*%?`(reftype, expr*{expr}, x_0?{x_0}) i
1. If x_0? is not defined, then:
  a. Return [].
2. If x_0? is ?(DECLARE), then:
  a. Return [(ELEM.DROP i)].
3. If x_0? is defined, then:
  a. Let ?(_y0) be x_0?.
  b. If _y0 is of the case TABLE, then:
    1) Let (TABLE x instr*) be _y0.
    2) Let n be |expr*|.
    3) Return instr* ++ [(I32.CONST 0), (I32.CONST n), (TABLE.INIT x i), (ELEM.DROP i)].

rundata `DATA%*%?`(byte*{byte}, x_0?{x_0}) i
1. If x_0? is not defined, then:
  a. Return [].
2. Else:
  a. Let ?(_y0) be x_0?.
  b. If _y0 is of the case MEMORY, then:
    1) Let (MEMORY _y1 instr*) be _y0.
    2) Let 0 be _y1.
    3) Let n be |byte*|.
    4) Return instr* ++ [(I32.CONST 0), (I32.CONST n), (MEMORY.INIT i), (DATA.DROP i)].

concat_admininstr x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let admininstr* ++ admininstr'** be x_0*.
3. Let r_0 be the result of computing $concat_admininstr(admininstr'**).
4. Return admininstr* ++ r_0.

instantiation module externval*
1. If module is of the case MODULE, then:
  a. Let (MODULE import* func* global* table* mem* elem* data* start? export*) be module.
  b. YetI: (where `ELEM%%*%?`(reftype, instr_2*{instr_2}*{instr_2}, elemmode?{elemmode}) = elem)*{elem elemmode instr_2 reftype}.
  c. Let r_2 be the result of computing $allocmodule(module, externval*, val*, ref**).
  d. Let r_3 be the result of computing $runelem(elem*[i], i)^Yet.
  e. Let r_4 be the result of computing $rundata(data*[j], j)^Yet.
  f. If start? is (START x)? and instr_data** is r_4 and n_data is |data*| and instr_elem** is r_3 and n_elem is |elem*| and f is { LOCAL: []; MODULE: m; } and m is r_2, then:
    1) YetI: (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), (instr_2 <: admininstr)*{instr_2}), [(ref <: admininstr)]))*{instr_2 ref}*{instr_2 ref}.
    2) Execute the sequence (instr_1**).
    3) Pop val* from the stack.
    4) YetI: (if (global = GLOBAL(globaltype, instr_1*{instr_1})))*{global globaltype instr_1}.
    5) Let r_0 be the result of computing $funcs(externval*).
    6) Let r_1 be the result of computing $globals(externval*).
    7) If f_init is { LOCAL: []; MODULE: m_init; } and m_init is { FUNC: r_0; GLOBAL: r_1; TABLE: []; MEM: []; ELEM: []; DATA: []; EXPORT: []; }, then:
      a) Return YetE (MixE ([[], [Semicolon], [Star]], TupE ([MixE ([[], [Semicolon], []], TupE ([VarE "s'", VarE "f"])), CatE (CallE ("concat_admininstr", IterE (IterE (SubE (VarE "instr_elem", VarT "instr", VarT "admininstr"), (List, ["instr_elem"])), (List, ["instr_elem"]))), CatE (CallE ("concat_admininstr", IterE (IterE (SubE (VarE "instr_data", VarT "instr", VarT "admininstr"), (List, ["instr_data"])), (List, ["instr_data"]))), IterE (CaseE (Atom "CALL", VarE "x"), (Opt, ["x"]))))]))).

invocation fa val^n
1. Let m be { FUNC: []; GLOBAL: []; TABLE: []; MEM: []; ELEM: []; DATA: []; EXPORT: []; }.
2. Let f be { LOCAL: []; MODULE: m; }.
3. Let r_1 be the result of computing $funcinst().
4. If r_1[fa].CODE is of the case FUNC, then:
  a. Let r_0 be the result of computing $funcinst().
  b. Let (FUNC functype valtype* expr) be r_0[fa].CODE.
  c. Let [valtype_param^n]->[valtype_res^k] be functype.
  d. Return YetE (MixE ([[], [Semicolon], [Star]], TupE ([MixE ([[], [Semicolon], []], TupE ([VarE "s", VarE "f"])), CatE (IterE (SubE (VarE "val", VarT "val", VarT "admininstr"), (ListN (VarE "n"), ["val"])), ListE ([CaseE (Atom "CALL_ADDR", VarE "fa")]))]))).

execution_of_unreachable
1. Trap.

execution_of_nop
1. Do nothing.

execution_of_drop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.

execution_of_select t?
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val_2 from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop val_1 from the stack.
7. If c is not 0, then:
  a. Push val_1 to the stack.
8. Else:
  a. Push val_2 to the stack.

execution_of_block bt instr*
1. Let [t_1^k]->[t_2^n] be bt.
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. Let L be the label_n{[]}.
5. Push L to the stack.
6. Push val^k to the stack.
7. Jump to instr*.

execution_of_loop bt instr*
1. Let [t_1^k]->[t_2^n] be bt.
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. Let L be the label_k{[(LOOP bt instr*)]}.
5. Push L to the stack.
6. Push val^k to the stack.
7. Jump to instr*.

execution_of_if bt instr_1* instr_2*
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If c is not 0, then:
  a. Execute (BLOCK bt instr_1*).
4. Else:
  a. Execute (BLOCK bt instr_2*).

execution_of_label
1. Pop all values val* from the stack.
2. Assert: Due to validation, the label L is now on the top of the stack.
3. Pop the label from the stack.
4. Push val* to the stack.

execution_of_br x_0
1. Let L be the current label.
2. Let n be the arity of L.
3. Let instr'* be the continuation of L.
4. Pop all values x_1* from the stack.
5. Exit current context.
6. If x_0 is 0, then:
  a. Let val'* ++ val^n be x_1*.
  b. Push val^n to the stack.
  c. Execute the sequence (instr'*).
7. If x_0 ≥ 1, then:
  a. Let l be (x_0 - 1).
  b. Let val* be x_1*.
  c. Push val* to the stack.
  d. Execute (BR l).

execution_of_br_if l
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If c is not 0, then:
  a. Execute (BR l).

execution_of_br_table l* l'
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If i < |l*|, then:
  a. Execute (BR l*[i]).
4. Else:
  a. Execute (BR l').

execution_of_frame
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop val^n from the stack.
5. Assert: Due to validation, the frame F is now on the top of the stack.
6. Pop the frame from the stack.
7. Push val^n to the stack.

execution_of_return
1. If the current context is frame, then:
  a. Let F be the current frame.
  b. Let n be the arity of F.
  c. Pop val^n from the stack.
  d. Pop all values val'* from the stack.
  e. Exit current context.
  f. Push val^n to the stack.
2. Else if the current context is label, then:
  a. Let L be the current label.
  b. Let k be the arity of L.
  c. Let instr'* be the continuation of L.
  d. Pop all values val* from the stack.
  e. Exit current context.
  f. Push val* to the stack.
  g. Execute RETURN.

execution_of_unop nt unop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_1) from the stack.
3. Let r_0 be the result of computing $unop(unop, nt, c_1).
4. If |r_0| is 1, then:
  a. Let [c] be the result of computing $unop(unop, nt, c_1).
  b. Push (nt.CONST c) to the stack.
5. Let r_1 be the result of computing $unop(unop, nt, c_1).
6. If r_1 is [], then:
  a. Trap.

execution_of_binop nt binop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop (nt.CONST c_1) from the stack.
5. Let r_0 be the result of computing $binop(binop, nt, c_1, c_2).
6. If |r_0| is 1, then:
  a. Let [c] be the result of computing $binop(binop, nt, c_1, c_2).
  b. Push (nt.CONST c) to the stack.
7. Let r_1 be the result of computing $binop(binop, nt, c_1, c_2).
8. If r_1 is [], then:
  a. Trap.

execution_of_testop nt testop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_1) from the stack.
3. Let c be the result of computing $testop(testop, nt, c_1).
4. Push (I32.CONST c) to the stack.

execution_of_relop nt relop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop (nt.CONST c_1) from the stack.
5. Let c be the result of computing $relop(relop, nt, c_1, c_2).
6. Push (I32.CONST c) to the stack.

execution_of_extend nt n
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Let r_0 be the result of computing $size(nt).
4. Let r_1 be the result of computing $ext(n, r_0, S, c).
5. Push (nt.CONST r_1) to the stack.

execution_of_cvtop nt_2 cvtop nt_1 sx?
1. Assert: Due to validation, a value of value type nt_1 is on the top of the stack.
2. Pop (nt_1.CONST c_1) from the stack.
3. Let r_0 be the result of computing $cvtop(nt_1, cvtop, nt_2, sx?, c_1).
4. If |r_0| is 1, then:
  a. Let [c] be the result of computing $cvtop(nt_1, cvtop, nt_2, sx?, c_1).
  b. Push (nt_2.CONST c) to the stack.
5. Let r_1 be the result of computing $cvtop(nt_1, cvtop, nt_2, sx?, c_1).
6. If r_1 is [], then:
  a. Trap.

execution_of_ref.is_null
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. If val is not of the case REF.NULL, then:
  a. Push (I32.CONST 0) to the stack.
4. Else:
  a. Let (REF.NULL rt) be val.
  b. Push (I32.CONST 1) to the stack.

execution_of_local.tee x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Push val to the stack.
4. Push val to the stack.
5. Execute (LOCAL.SET x).

execution_of_call x
1. Let r_1 be the result of computing $funcaddr().
2. If x < |r_1|, then:
  a. Let r_0 be the result of computing $funcaddr().
  b. Execute (CALL_ADDR r_0[x]).

execution_of_call_indirect x ft
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. Let r_5 be the result of computing $table(x).
4. If i ≥ |r_5.ELEM|, then:
  a. Trap.
5. Else:
  a. Let r_4 be the result of computing $table(x).
  b. If r_4.ELEM[i] is not of the case REF.FUNC_ADDR, then:
    1) Trap.
  c. Else:
    1) Let r_0 be the result of computing $table(x).
    2) Let (REF.FUNC_ADDR a) be r_0.ELEM[i].
    3) Let r_3 be the result of computing $funcinst().
    4) If a ≥ |r_3|, then:
      a) Trap.
    5) Else:
      a) Let r_2 be the result of computing $funcinst().
      b) If r_2[a].CODE is not of the case FUNC, then:
        1. Trap.
      c) Else:
        1. Let r_1 be the result of computing $funcinst().
        2. Let (FUNC ft' t* instr*) be r_1[a].CODE.
        3. If ft is ft', then:
          a. Execute (CALL_ADDR a).
        4. Else:
          a. Trap.

execution_of_call_addr a
1. Let r_2 be the result of computing $funcinst().
2. If a < |r_2|, then:
  a. Let r_0 be the result of computing $funcinst().
  b. Let { MODULE: m; CODE: func; } be r_0[a].
  c. If func is of the case FUNC, then:
    1) Let (FUNC _y0 t* instr*) be func.
    2) Let [t_1^k]->[t_2^n] be _y0.
    3) Assert: Due to validation, there are at least k values on the top of the stack.
    4) Pop val^k from the stack.
    5) Let r_1 be the result of computing $default_(t)*.
    6) Let f be { LOCAL: val^k ++ r_1; MODULE: m; }.
    7) Push the activation of f with arity n to the stack.
    8) Let L be the label_n{[]}.
    9) Push L to the stack.
    10) Jump to instr*.

execution_of_ref.func x
1. Let r_1 be the result of computing $funcaddr().
2. If x < |r_1|, then:
  a. Let r_0 be the result of computing $funcaddr().
  b. Push (REF.FUNC_ADDR r_0[x]) to the stack.

execution_of_local.get x
1. Let r_0 be the result of computing $local(x).
2. Push r_0 to the stack.

execution_of_global.get x
1. Let r_0 be the result of computing $global(x).
2. Push r_0.VALUE to the stack.

execution_of_table.get x
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. Let r_1 be the result of computing $table(x).
4. If i ≥ |r_1.ELEM|, then:
  a. Trap.
5. Else:
  a. Let r_0 be the result of computing $table(x).
  b. Push r_0.ELEM[i] to the stack.

execution_of_table.size x
1. Let r_0 be the result of computing $table(x).
2. Let n be |r_0.ELEM|.
3. Push (I32.CONST n) to the stack.

execution_of_table.fill x
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. Let r_0 be the result of computing $table(x).
8. If (i + n) > |r_0.ELEM|, then:
  a. Trap.
9. Else if n is not 0, then:
  a. Push (I32.CONST i) to the stack.
  b. Push val to the stack.
  c. Execute (TABLE.SET x).
  d. Push (I32.CONST (i + 1)) to the stack.
  e. Push val to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (TABLE.FILL x).

execution_of_table.copy x y
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. Let r_0 be the result of computing $table(x).
8. Let r_1 be the result of computing $table(y).
9. If (i + n) > |r_1.ELEM| or (j + n) > |r_0.ELEM|, then:
  a. Trap.
10. Else if n is not 0, then:
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

execution_of_table.init x y
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. Let r_2 be the result of computing $table(x).
8. Let r_3 be the result of computing $elem(y).
9. If (i + n) > |r_3.ELEM| or (j + n) > |r_2.ELEM|, then:
  a. Trap.
10. Else:
  a. Let r_1 be the result of computing $elem(y).
  b. If n is not 0 and i < |r_1.ELEM|, then:
    1) Push (I32.CONST j) to the stack.
    2) Let r_0 be the result of computing $elem(y).
    3) Push r_0.ELEM[i] to the stack.
    4) Execute (TABLE.SET x).
    5) Push (I32.CONST (j + 1)) to the stack.
    6) Push (I32.CONST (i + 1)) to the stack.
    7) Push (I32.CONST (n - 1)) to the stack.
    8) Execute (TABLE.INIT x y).

execution_of_load nt x_0? n_A n_O
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If x_0? is not defined, then:
  a. Let r_4 be the result of computing $mem(0).
  b. Let r_5 be the result of computing $size(nt).
  c. If ((i + n_O) + (r_5 / 8)) > |r_4.DATA|, then:
    1) Trap.
  d. Let r_6 be the result of computing $size(nt).
  e. Let r_7 be the result of computing $size(nt).
  f. Let r_8 be the result of computing $mem(0).
  g. Let c be the result of computing $inverse_of_bytes_(r_6, r_8.DATA[(i + n_O) : (r_7 / 8)]).
  h. Push (nt.CONST c) to the stack.
4. Else:
  a. Let ?(_y0) be x_0?.
  b. Let [n, sx] be _y0.
  c. Let r_0 be the result of computing $mem(0).
  d. If ((i + n_O) + (n / 8)) > |r_0.DATA|, then:
    1) Trap.
  e. Let r_1 be the result of computing $mem(0).
  f. Let c be the result of computing $inverse_of_bytes_(n, r_1.DATA[(i + n_O) : (n / 8)]).
  g. Let r_2 be the result of computing $size(nt).
  h. Let r_3 be the result of computing $ext(n, r_2, sx, c).
  i. Push (nt.CONST r_3) to the stack.

execution_of_memory.size
1. Let r_0 be the result of computing $mem(0).
2. Let r_1 be the result of computing $Ki().
3. Let ((n · 64) · r_1) be |r_0.DATA|.
4. Push (I32.CONST n) to the stack.

execution_of_memory.fill
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. Let r_0 be the result of computing $mem(0).
8. If (i + n) > |r_0.DATA|, then:
  a. Trap.
9. Else if n is not 0, then:
  a. Push (I32.CONST i) to the stack.
  b. Push val to the stack.
  c. Execute (STORE I32 ?(8) 0 0).
  d. Push (I32.CONST (i + 1)) to the stack.
  e. Push val to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute MEMORY.FILL.

execution_of_memory.copy
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. Let r_0 be the result of computing $mem(0).
8. Let r_1 be the result of computing $mem(0).
9. If (i + n) > |r_1.DATA| or (j + n) > |r_0.DATA|, then:
  a. Trap.
10. Else if n is not 0, then:
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

execution_of_memory.init x
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. Let r_2 be the result of computing $mem(0).
8. Let r_3 be the result of computing $data(x).
9. If (i + n) > |r_3.DATA| or (j + n) > |r_2.DATA|, then:
  a. Trap.
10. Else:
  a. Let r_1 be the result of computing $data(x).
  b. If n is not 0 and i < |r_1.DATA|, then:
    1) Push (I32.CONST j) to the stack.
    2) Let r_0 be the result of computing $data(x).
    3) Push (I32.CONST r_0.DATA[i]) to the stack.
    4) Execute (STORE I32 ?(8) 0 0).
    5) Push (I32.CONST (j + 1)) to the stack.
    6) Push (I32.CONST (i + 1)) to the stack.
    7) Push (I32.CONST (n - 1)) to the stack.
    8) Execute (MEMORY.INIT x).

execution_of_local.set x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Perform $with_local(x, val).

execution_of_global.set x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Perform $with_global(x, val).

execution_of_table.set x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Let r_0 be the result of computing $table(x).
6. If i ≥ |r_0.ELEM|, then:
  a. Trap.
7. Else:
  a. Perform $with_table(x, i, ref).

execution_of_table.grow x
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop ref from the stack.
5. Either:
  a. Let r_0 be the result of computing $table(x).
  b. Let ti be the result of computing $grow_table(r_0, n, ref).
  c. Let r_1 be the result of computing $table(x).
  d. Push (I32.CONST |r_1.ELEM|) to the stack.
  e. Perform $with_tableinst(x, ti).
6. Or:
  a. Push (I32.CONST -1) to the stack.

execution_of_elem.drop x
1. Perform $with_elem(x, []).

execution_of_store nt x_0? n_A n_O
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If x_0? is not defined, then:
  a. Let r_3 be the result of computing $mem(0).
  b. Let r_4 be the result of computing $size(nt).
  c. If ((i + n_O) + (r_4 / 8)) > |r_3.DATA|, then:
    1) Trap.
  d. Let r_5 be the result of computing $size(nt).
  e. Let b* be the result of computing $bytes_(r_5, c).
  f. Let r_6 be the result of computing $size(nt).
  g. Perform $with_mem(0, (i + n_O), (r_6 / 8), b*).
6. Else:
  a. Let ?(n) be x_0?.
  b. Let r_0 be the result of computing $mem(0).
  c. If ((i + n_O) + (n / 8)) > |r_0.DATA|, then:
    1) Trap.
  d. Let r_1 be the result of computing $size(nt).
  e. Let r_2 be the result of computing $wrap_([r_1, n], c).
  f. Let b* be the result of computing $bytes_(n, r_2).
  g. Perform $with_mem(0, (i + n_O), (n / 8), b*).

execution_of_memory.grow
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Either:
  a. Let r_0 be the result of computing $mem(0).
  b. Let mi be the result of computing $grow_memory(r_0, n).
  c. Let r_1 be the result of computing $Ki().
  d. Let r_2 be the result of computing $mem(0).
  e. Push (I32.CONST (|r_2.DATA| / (64 · r_1))) to the stack.
  f. Perform $with_meminst(0, mi).
4. Or:
  a. Push (I32.CONST -1) to the stack.

execution_of_data.drop x
1. Perform $with_data(x, []).

instantiation module externval*
1. Let (MODULE _ _ _ _ _ elem* data* start? _) be module.
2. Let moduleinst be the result of computing $alloc_module(module, externval*).
3. Let f be the activation of { MODULE: moduleinst; LOCAL: []; } with arity 0.
4. Push f to the stack.
5. For i in range |elem*|:
  a. Let (ELEM _ einit mode_opt) be elem*[i].
  b. If mode_opt is defined, then:
    1) Let ?(mode) be mode_opt.
    2) If mode is of the case TABLE, then:
      a) Let (TABLE tableidx einstrs*) be mode.
      b) Execute the sequence (einstrs*).
      c) Execute (I32.CONST 0).
      d) Execute (I32.CONST |einit|).
      e) Execute (TABLE.INIT tableidx i).
      f) Execute (ELEM.DROP i).
    3) If mode is of the case DECLARE, then:
      a) Execute (ELEM.DROP i).
6. For i in range |data*|:
  a. Let (DATA dinit mode) be data*[i].
  b. If mode is defined, then:
    1) Let ?((MEMORY memidx dinstrs*)) be mode.
    2) Assert: memidx is 0.
    3) Execute the sequence (dinstrs*).
    4) Execute (I32.CONST 0).
    5) Execute (I32.CONST |dinit|).
    6) Execute (MEMORY.INIT i).
    7) Execute (DATA.DROP i).
7. If start? is defined, then:
  a. Let ?((START start_idx)) be start?.
  b. Execute (CALL start_idx).
8. Pop f from the stack.
9. Return moduleinst.

alloc_module module externval*
1. Let (MODULE import* func* global* table* memory* elem* data* _ export*) be module.
2. Let moduleinst be { FUNC: []; TABLE: []; GLOBAL: []; MEM: []; ELEM: []; DATA: []; EXPORT: []; }.
3. For i in range |import*|:
  a. Let (IMPORT _ _ import_type) be import*[i].
  b. If import_type is of the case FUNC and externval*[i] is of the case FUNC, then:
    1) Let (FUNC funcaddr') be externval*[i].
    2) Append funcaddr' to the moduleinst.FUNC.
  c. If import_type is of the case TABLE and externval*[i] is of the case TABLE, then:
    1) Let (TABLE tableaddr') be externval*[i].
    2) Append tableaddr' to the moduleinst.TABLE.
  d. If import_type is of the case MEM and externval*[i] is of the case MEM, then:
    1) Let (MEM memaddr') be externval*[i].
    2) Append memaddr' to the moduleinst.MEM.
  e. If import_type is of the case GLOBAL and externval*[i] is of the case GLOBAL, then:
    1) Let (GLOBAL globaladdr') be externval*[i].
    2) Append globaladdr' to the moduleinst.GLOBAL.
4. Let f_init be the activation of { MODULE: moduleinst; LOCAL: []; } with arity 0.
5. Push f_init to the stack.
6. Let funcaddr* be the result of computing $alloc_func(func)*.
7. Append the sequence funcaddr* to the moduleinst.FUNC.
8. Let tableaddr* be the result of computing $alloc_table(table)*.
9. Append the sequence tableaddr* to the moduleinst.TABLE.
10. Let globaladdr* be the result of computing $alloc_global(global)*.
11. Append the sequence globaladdr* to the moduleinst.GLOBAL.
12. Let memoryaddr* be the result of computing $alloc_memory(memory)*.
13. Append the sequence memoryaddr* to the moduleinst.MEM.
14. Let elemaddr* be the result of computing $alloc_elem(elem)*.
15. Append the sequence elemaddr* to the moduleinst.ELEM.
16. Let dataaddr* be the result of computing $alloc_data(data)*.
17. Append the sequence dataaddr* to the moduleinst.DATA.
18. Pop f_init from the stack.
19. For i in range |funcaddr*|:
  a. Let func' be s.FUNC[funcaddr*[i]].CODE.
  b. Replace s.FUNC[funcaddr*[i]] with { MODULE: moduleinst; CODE: func'; }.
20. For i in range |export*|:
  a. Let (EXPORT name externuse) be export*[i].
  b. If externuse is of the case FUNC, then:
    1) Let (FUNC funcidx) be externuse.
    2) Let funcaddr be moduleinst.FUNC[funcidx].
    3) Let externval be (FUNC funcaddr).
    4) Let exportinst be { NAME: name; VALUE: externval; }.
    5) Append exportinst to the moduleinst.EXPORT.
  c. If externuse is of the case TABLE, then:
    1) Let (TABLE tableidx) be externuse.
    2) Let tableaddr be moduleinst.TABLE[tableidx].
    3) Let externval be (TABLE tableaddr).
    4) Let exportinst be { NAME: name; VALUE: externval; }.
    5) Append exportinst to the moduleinst.EXPORT.
  d. If externuse is of the case MEM, then:
    1) Let (MEM memidx) be externuse.
    2) Let memaddr be moduleinst.MEM[memidx].
    3) Let externval be (MEM memaddr).
    4) Let exportinst be { NAME: name; VALUE: externval; }.
    5) Append exportinst to the moduleinst.EXPORT.
  e. If externuse is of the case GLOBAL, then:
    1) Let (GLOBAL globalidx) be externuse.
    2) Let globaladdr be moduleinst.GLOBAL[globalidx].
    3) Let externval be (GLOBAL globaladdr).
    4) Let exportinst be { NAME: name; VALUE: externval; }.
    5) Append exportinst to the moduleinst.EXPORT.
21. Return moduleinst.

init_global global
1. Let (GLOBAL _ instr*) be global.
2. Execute the sequence (instr*).
3. Pop val from the stack.
4. Return val.

init_elem elem
1. Let (ELEM _ instr* _) be elem.
2. Let ref* be the result of computing $exec_expr(instr)*.
3. Return ref*.

exec_expr instr*
1. Execute the sequence (instr*).
2. Pop val from the stack.
3. Return val.

alloc_func func
1. Let a be |s.FUNC|.
2. Let dummy_module_inst be { FUNC: []; TABLE: []; }.
3. Let funcinst be { MODULE: dummy_module_inst; CODE: func; }.
4. Append funcinst to the s.FUNC.
5. Return a.

alloc_global global
1. Let a be |s.GLOBAL|.
2. Let r_0 be the result of computing $init_global(global).
3. Let globalinst be { VALUE: r_0; }.
4. Append globalinst to the s.GLOBAL.
5. Return a.

alloc_table table
1. Let (TABLE (n, m?) reftype) be table.
2. Let a be |s.TABLE|.
3. Let tableinst be { TYPE: ((n, m?), reftype); ELEM: (REF.NULL reftype)^n; }.
4. Append tableinst to the s.TABLE.
5. Return a.

alloc_memory memory
1. Let (MEMORY (min, max?)) be memory.
2. Let a be |s.MEM|.
3. Let r_0 be the result of computing $Ki().
4. Let memoryinst be { TYPE: (I8 (min, max?)); DATA: 0^((min · 64) · r_0); }.
5. Append memoryinst to the s.MEM.
6. Return a.

alloc_elem elem
1. Let a be |s.ELEM|.
2. Let r_0 be the result of computing $init_elem(elem).
3. Let eleminst be { ELEM: r_0; }.
4. Append eleminst to the s.ELEM.
5. Return a.

alloc_data data
1. Let (DATA init _) be data.
2. Let a be |s.DATA|.
3. Let datainst be { DATA: init; }.
4. Append datainst to the s.DATA.
5. Return a.

invocation funcaddr val*
1. Let func be s.FUNC[funcaddr].CODE.
2. Let (FUNC functype _ _) be func.
3. Let [_^n]->[_^m] be functype.
4. Assert: |val*| is n.
5. Let f be the activation of { LOCAL: []; MODULE: { FUNC: []; TABLE: []; }; } with arity 0.
6. Push f to the stack.
7. Push val* to the stack.
8. Execute (CALL_ADDR funcaddr).
9. Pop val_res^m from the stack.
10. Pop f from the stack.
11. Return val_res^m.

== Complete.
```
