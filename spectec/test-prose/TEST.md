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
- Under the context C with .LABEL prepended by [t_2]*, instr* must be valid with type [t_1*]->[t_2*].
- Under the context C, bt must be valid with type [t_1*]->[t_2*].
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_loop bt instr*
- Under the context C with .LABEL prepended by [t_1]*, instr* must be valid with type [t_1*]->[t_2*].
- Under the context C, bt must be valid with type [t_1*]->[t_2*].
- The instruction is valid with type [t_1*]->[t_2*].

validation_of_if bt instr_1* instr_2*
- Under the context C with .LABEL prepended by [t_2]*, instr_2* must be valid with type [t_1*]->[t_2*].
- Under the context C, bt must be valid with type [t_1*]->[t_2*].
- Under the context C with .LABEL prepended by [t_2]*, instr_1* must be valid with type [t_1*]->[t_2*].
- The instruction is valid with type [t_1* ++ [I32]]->[t_2*].

validation_of_br l
- |C.LABEL| must be greater than l.
- Let t* be C.LABEL[l].
- The instruction is valid with type [t_1* ++ t*]->[t_2*].

validation_of_br_if l
- |C.LABEL| must be greater than l.
- Let t* be C.LABEL[l].
- The instruction is valid with type [t* ++ [I32]]->[t*].

validation_of_br_table l* l'
- For all l in l*,
  - |C.LABEL| must be greater than l.
- |C.LABEL| must be greater than l'.
- For all l in l*,
  - C.LABEL[l] must match t*.
- C.LABEL[l'] must match t*.
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
- Let (lim_2, rt) be C.TABLE[x_2].
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
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_memory.copy
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_memory.init x
- |C.MEM| must be greater than 0.
- |C.DATA| must be greater than x.
- C.DATA[x] must be equal to OK.
- Let mt be C.MEM[0].
- The instruction is valid with type [I32, I32, I32]->[].

validation_of_data.drop x
- |C.DATA| must be greater than x.
- C.DATA[x] must be equal to OK.
- The instruction is valid with type []->[].

validation_of_load nt [n, sx]? n_A n_O
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

validation_of_store nt n? n_A n_O
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
  a. Let j be x_1.
  b. Return 0.
2. If x_1 is 0, then:
  a. Let i be x_0.
  b. Return 0.
3. If x_0 ≥ 1, then:
  a. Let i be (x_0 - 1).
  b. If x_1 ≥ 1, then:
    1) Let j be (x_1 - 1).
    2) Return $min(i, j).

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
3. Let fa be $allocfunc(m, func).
4. Let fa'* be $allocfuncs(m, func'*).
5. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let gi be { TYPE: globaltype; VALUE: val; }.
2. Return [s with .GLOBAL appended by [gi], |s.GLOBAL|].

allocglobals x_0* x_1*
1. If x_0* is [], then:
  a. If x_1* is [], then:
    1) Return [].
2. Else:
  a. Let [globaltype] ++ globaltype'* be x_0*.
  b. If |x_1*| ≥ 1, then:
    1) Let [val] ++ val'* be x_1*.
    2) Let ga be $allocglobal(globaltype, val).
    3) Let ga'* be $allocglobals(globaltype'*, val'*).
    4) Return [ga] ++ ga'*.

alloctable `%%`(`[%..%]`(i, j), rt)
1. Let ti be { TYPE: ((i, j), rt); ELEM: (REF.NULL rt)^i; }.
2. Return [s with .TABLE appended by [ti], |s.TABLE|].

alloctables x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [tabletype] ++ tabletype'* be x_0*.
3. Let ta be $alloctable(tabletype).
4. Let ta'* be $alloctables(tabletype'*).
5. Return [ta] ++ ta'*.

allocmem `%I8`(`[%..%]`(i, j))
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
2. If |x_1*| ≥ 1, then:
  a. Let [ref*] ++ ref'** be x_1*.
  b. If |x_0*| ≥ 1, then:
    1) Let [rt] ++ rt'* be x_0*.
    2) Let ea be $allocelem(rt, ref*).
    3) Let ea'* be $allocelems(rt'*, ref'**).
    4) Return [ea] ++ ea'*.

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
1. Let i be 0.
2. Let fa_ex* be $funcs(externval*).
3. Let ga_ex* be $globals(externval*).
4. Let ma_ex* be $mems(externval*).
5. Let ta_ex* be $tables(externval*).
6. If module is of the case MODULE, then:
  a. Let (MODULE import* func^n_func y_0 y_1 y_2 y_3 y_4 start? export*) be module.
  b. Let (DATA byte* datamode?)^n_data be y_4.
  c. Let (ELEM rt expr_2* elemmode?)^n_elem be y_3.
  d. Let (MEMORY memtype)^n_mem be y_2.
  e. Let (TABLE tabletype)^n_table be y_1.
  f. Let (GLOBAL globaltype expr_1)^n_global be y_0.
  g. Let da* be (|s.DATA| + i)^(i<n_data).
  h. Let ea* be (|s.ELEM| + i)^(i<n_elem).
  i. Let ma* be (|s.MEM| + i)^(i<n_mem).
  j. Let ta* be (|s.TABLE| + i)^(i<n_table).
  k. Let ga* be (|s.GLOBAL| + i)^(i<n_global).
  l. Let fa* be (|s.FUNC| + i)^(i<n_func).
  m. Let xi* be $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*.
  n. Let m be { FUNC: fa_ex* ++ fa*; GLOBAL: ga_ex* ++ ga*; TABLE: ta_ex* ++ ta*; MEM: ma_ex* ++ ma*; ELEM: ea*; DATA: da*; EXPORT: xi*; }.
  o. Let y_0* be $allocfuncs(m, func^n_func).
  p. If y_0* is fa*, then:
    1) Let y_0* be $allocglobals(globaltype^n_global, val*).
    2) If y_0* is ga*, then:
      a) Let y_0* be $alloctables(tabletype^n_table).
      b) If y_0* is ta*, then:
        1. Let y_0* be $allocmems(memtype^n_mem).
        2. If y_0* is ma*, then:
          a. Let y_0* be $allocelems(rt^n_elem, ref**).
          b. If y_0* is ea*, then:
            1) Let y_0* be $allocdatas(byte*^n_data).
            2) If y_0* is da*, then:
              a) Return m.

runelem `ELEM%%*%?`(reftype, expr*{expr}, x_0?{x_0}) i
1. If x_0? is not defined, then:
  a. Return [].
2. If x_0? is ?(DECLARE), then:
  a. Return [(ELEM.DROP i)].
3. If x_0? is defined, then:
  a. Let ?(y_0) be x_0?.
  b. If y_0 is of the case TABLE, then:
    1) Let (TABLE x instr*) be y_0.
    2) Let n be |expr*|.
    3) Return instr* ++ [(I32.CONST 0), (I32.CONST n), (TABLE.INIT x i), (ELEM.DROP i)].

rundata `DATA%*%?`(byte*{byte}, x_0?{x_0}) i
1. If x_0? is not defined, then:
  a. Return [].
2. Let ?(y_0) be x_0?.
3. If y_0 is of the case MEMORY, then:
  a. Let (MEMORY y_1 instr*) be y_0.
  b. Let 0 be y_1.
  c. Let n be |byte*|.
  d. Return instr* ++ [(I32.CONST 0), (I32.CONST n), (MEMORY.INIT i), (DATA.DROP i)].

concat_instr x_0*
1. If x_0* is [], then:
  a. Return [].
2. Let [instr*] ++ instr'** be x_0*.
3. Return instr* ++ $concat_instr(instr'**).

instantiation module externval*
1. Let i be 0.
2. Let j be 0.
3. Let m_init be { FUNC: $funcs(externval*); GLOBAL: $globals(externval*); TABLE: []; MEM: []; ELEM: []; DATA: []; EXPORT: []; }.
4. If module is of the case MODULE, then:
  a. Let (MODULE import* func* global* table* mem* elem* data* start? export*) be module.
  b. Let f_init be { LOCAL: []; MODULE: m_init; }.
  c. Let n_data be |data*|.
  d. Let n_elem be |elem*|.
  e. Let (START x)? be start?.
  f. Let (GLOBAL globaltype instr_1*)* be global*.
  g. Let (ELEM reftype instr_2** elemmode?)* be elem*.
  h. Let instr_data* be $concat_instr($rundata(data*[j], j)^(j<n_data)).
  i. Let instr_elem* be $concat_instr($runelem(elem*[i], i)^(i<n_elem)).
  j. Let ref** be $exec_expr_const(instr_2*)**.
  k. Let val* be $exec_expr_const(instr_1*)*.
  l. Let m be $allocmodule(module, externval*, val*, ref**).
  m. Let f be { LOCAL: []; MODULE: m; }.
  n. Execute the sequence (instr_elem*).
  o. Execute the sequence (instr_data*).
  p. If x is defined, then:
    1) Execute (CALL x).

invocation fa val^n
1. Let m be { FUNC: []; GLOBAL: []; TABLE: []; MEM: []; ELEM: []; DATA: []; EXPORT: []; }.
2. Let f be { LOCAL: []; MODULE: m; }.
3. If $funcinst()[fa].CODE is of the case FUNC, then:
  a. Let (FUNC functype valtype* expr) be $funcinst()[fa].CODE.
  b. Let [valtype_param^n]->[valtype_res^k] be functype.
  c. Push val^n to the stack.
  d. Execute (CALL_ADDR fa).

execution_of_unreachable
1. Trap.

execution_of_nop
1. Do nothing.

execution_of_drop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.

execution_of_select t?
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
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If c is not 0, then:
  a. Execute (BLOCK bt instr_1*).
4. Else:
  a. Execute (BLOCK bt instr_2*).

execution_of_label
1. Pop all values val* from the stack.
2. Assert: Due to validation, a label is now on the top of the stack.
3. Pop the label from the stack.
4. Push val* to the stack.

execution_of_br x_0
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

execution_of_br_if l
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If c is not 0, then:
  a. Execute (BR l).

execution_of_br_table l* l'
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
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
5. Assert: Due to validation, a frame is now on the top of the stack.
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
3. If |$unop(unop, nt, c_1)| is 1, then:
  a. Let [c] be $unop(unop, nt, c_1).
  b. Push (nt.CONST c) to the stack.
4. If $unop(unop, nt, c_1) is [], then:
  a. Trap.

execution_of_binop nt binop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop (nt.CONST c_1) from the stack.
5. If |$binop(binop, nt, c_1, c_2)| is 1, then:
  a. Let [c] be $binop(binop, nt, c_1, c_2).
  b. Push (nt.CONST c) to the stack.
6. If $binop(binop, nt, c_1, c_2) is [], then:
  a. Trap.

execution_of_testop nt testop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_1) from the stack.
3. Let c be $testop(testop, nt, c_1).
4. Push (I32.CONST c) to the stack.

execution_of_relop nt relop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop (nt.CONST c_1) from the stack.
5. Let c be $relop(relop, nt, c_1, c_2).
6. Push (I32.CONST c) to the stack.

execution_of_extend nt n
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Push (nt.CONST $ext(n, $size(nt), S, c)) to the stack.

execution_of_cvtop nt_2 cvtop nt_1 sx?
1. Assert: Due to validation, a value of value type nt_1 is on the top of the stack.
2. Pop (nt_1.CONST c_1) from the stack.
3. If |$cvtop(nt_1, cvtop, nt_2, sx?, c_1)| is 1, then:
  a. Let [c] be $cvtop(nt_1, cvtop, nt_2, sx?, c_1).
  b. Push (nt_2.CONST c) to the stack.
4. If $cvtop(nt_1, cvtop, nt_2, sx?, c_1) is [], then:
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
1. If x < |$funcaddr()|, then:
  a. Execute (CALL_ADDR $funcaddr()[x]).

execution_of_call_indirect x ft
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

execution_of_call_addr a
1. If a < |$funcinst()|, then:
  a. Let { MODULE: m; CODE: func; } be $funcinst()[a].
  b. If func is of the case FUNC, then:
    1) Let (FUNC y_0 t* instr*) be func.
    2) Let [t_1^k]->[t_2^n] be y_0.
    3) Assert: Due to validation, there are at least k values on the top of the stack.
    4) Pop val^k from the stack.
    5) Let f be { LOCAL: val^k ++ $default_(t)*; MODULE: m; }.
    6) Push the activation of f with arity n to the stack.
    7) Let L be the label_n{[]}.
    8) Push L to the stack.
    9) Jump to instr*.

execution_of_ref.func x
1. If x < |$funcaddr()|, then:
  a. Push (REF.FUNC_ADDR $funcaddr()[x]) to the stack.

execution_of_local.get x
1. Push $local(x) to the stack.

execution_of_global.get x
1. Push $global(x).VALUE to the stack.

execution_of_table.get x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If i ≥ |$table(x).ELEM|, then:
  a. Trap.
4. Push $table(x).ELEM[i] to the stack.

execution_of_table.size x
1. Let n be |$table(x).ELEM|.
2. Push (I32.CONST n) to the stack.

execution_of_table.fill x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. If (i + n) > |$table(x).ELEM|, then:
  a. Trap.
8. If n is not 0, then:
  a. Push (I32.CONST i) to the stack.
  b. Push val to the stack.
  c. Execute (TABLE.SET x).
  d. Push (I32.CONST (i + 1)) to the stack.
  e. Push val to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (TABLE.FILL x).

execution_of_table.copy x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$table(y).ELEM| or (j + n) > |$table(x).ELEM|, then:
  a. Trap.
8. If n is not 0, then:
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
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$elem(y).ELEM| or (j + n) > |$table(x).ELEM|, then:
  a. Trap.
8. If n is not 0 and i < |$elem(y).ELEM|, then:
  a. Push (I32.CONST j) to the stack.
  b. Push $elem(y).ELEM[i] to the stack.
  c. Execute (TABLE.SET x).
  d. Push (I32.CONST (j + 1)) to the stack.
  e. Push (I32.CONST (i + 1)) to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (TABLE.INIT x y).

execution_of_load nt x_0? n_A n_O
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

execution_of_memory.size
1. Let ((n · 64) · $Ki()) be |$mem(0).DATA|.
2. Push (I32.CONST n) to the stack.

execution_of_memory.fill
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. If (i + n) > |$mem(0).DATA|, then:
  a. Trap.
8. If n is not 0, then:
  a. Push (I32.CONST i) to the stack.
  b. Push val to the stack.
  c. Execute (STORE I32 ?(8) 0 0).
  d. Push (I32.CONST (i + 1)) to the stack.
  e. Push val to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute MEMORY.FILL.

execution_of_memory.copy
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$mem(0).DATA| or (j + n) > |$mem(0).DATA|, then:
  a. Trap.
8. If n is not 0, then:
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
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$data(x).DATA| or (j + n) > |$mem(0).DATA|, then:
  a. Trap.
8. If n is not 0 and i < |$data(x).DATA|, then:
  a. Push (I32.CONST j) to the stack.
  b. Push (I32.CONST $data(x).DATA[i]) to the stack.
  c. Execute (STORE I32 ?(8) 0 0).
  d. Push (I32.CONST (j + 1)) to the stack.
  e. Push (I32.CONST (i + 1)) to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (MEMORY.INIT x).

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
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If i ≥ |$table(x).ELEM|, then:
  a. Trap.
6. Perform $with_table(x, i, ref).

execution_of_table.grow x
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

execution_of_elem.drop x
1. Perform $with_elem(x, []).

execution_of_store nt x_0? n_A n_O
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

execution_of_memory.grow
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Either:
  a. Let mi be $grow_memory($mem(0), n).
  b. Push (I32.CONST (|$mem(0).DATA| / (64 · $Ki()))) to the stack.
  c. Perform $with_meminst(0, mi).
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
    2) Assert: Due to validation, memidx is 0.
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
4. Assert: Due to validation, |val*| is n.
5. Let f be the activation of { LOCAL: []; MODULE: { FUNC: []; TABLE: []; }; } with arity 0.
6. Push f to the stack.
7. Push val* to the stack.
8. Execute (CALL_ADDR funcaddr).
9. Pop val_res^m from the stack.
10. Pop f from the stack.
11. Return val_res^m.

== Complete.
```
