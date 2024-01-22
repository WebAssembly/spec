# Preview

```sh
$ for v in 1 2 3; do ( \
>   echo "Generating prose for Wasm $v.0..." && \
>   cd ../spec/wasm-$v.0 && \
>   dune exec ../../src/exe-watsup/main.exe -- *.watsup -v -l --prose \
> ) done
Generating prose for Wasm 1.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
=================
 Generated prose
=================
validation_of_UNREACHABLE
- The instruction is valid with type (t_1* -> t_2*).

validation_of_NOP
- The instruction is valid with type ([] -> []).

validation_of_DROP
- The instruction is valid with type ([t] -> []).

validation_of_SELECT ?()
- The instruction is valid with type ([t, t, I32] -> [t]).

validation_of_BLOCK t? instr*
- Under the context C with .LABEL prepended by [t?], instr* must be valid with type ([] -> t?).
- The instruction is valid with type ([] -> t?).

validation_of_LOOP t? instr*
- Under the context C with .LABEL prepended by [?()], instr* must be valid with type ([] -> []).
- The instruction is valid with type ([] -> t?).

validation_of_IF t? instr_1* instr_2*
- Under the context C with .LABEL prepended by [t?], instr_1* must be valid with type ([] -> t?).
- Under the context C with .LABEL prepended by [t?], instr_2* must be valid with type ([] -> t?).
- The instruction is valid with type ([I32] -> t?).

validation_of_BR l
- |C.LABEL| must be greater than l.
- Let t? be C.LABEL[l].
- The instruction is valid with type (t_1* ++ t? -> t_2*).

validation_of_BR_IF l
- |C.LABEL| must be greater than l.
- Let t? be C.LABEL[l].
- The instruction is valid with type (t? ++ [I32] -> t?).

validation_of_BR_TABLE l* l'
- |C.LABEL| must be greater than l'.
- For all l in l*,
  - |C.LABEL| must be greater than l.
- For all l in l*,
  - Let t? be C.LABEL[l].
- t? must be equal to C.LABEL[l'].
- The instruction is valid with type (t_1* ++ t? -> t_2*).

validation_of_RETURN
- Let ?(t?) be C.RETURN.
- The instruction is valid with type (t_1* ++ t? -> t_2*).

validation_of_CALL x
- |C.FUNC| must be greater than x.
- Let (t_1* -> t_2?) be C.FUNC[x].
- The instruction is valid with type (t_1* -> t_2?).

validation_of_CALL_INDIRECT x
- |C.TYPE| must be greater than x.
- Let (t_1* -> t_2?) be C.TYPE[x].
- The instruction is valid with type (t_1* ++ [I32] -> t_2?).

validation_of_CONST t c_t
- The instruction is valid with type ([] -> [t]).

validation_of_UNOP t unop
- The instruction is valid with type ([t] -> [t]).

validation_of_BINOP t binop
- The instruction is valid with type ([t, t] -> [t]).

validation_of_TESTOP t testop
- The instruction is valid with type ([t] -> [I32]).

validation_of_RELOP t relop
- The instruction is valid with type ([t, t] -> [I32]).

validation_of_CVTOP t_1 REINTERPRET t_2 ?()
- t_1 must be different with t_2.
- $size(t_1) must be equal to $size(t_2).
- The instruction is valid with type ([t_2] -> [t_1]).

validation_of_CVTOP inn_1 CONVERT inn_2 sx?
- inn_1 must be different with inn_2.
- (($size(inn_1) > $size(inn_2))) and ((sx? is ?())) are equivalent.
- The instruction is valid with type ([inn_2] -> [inn_1]).

validation_of_LOCAL.GET x
- |C.LOCAL| must be greater than x.
- Let t be C.LOCAL[x].
- The instruction is valid with type ([] -> [t]).

validation_of_LOCAL.SET x
- |C.LOCAL| must be greater than x.
- Let t be C.LOCAL[x].
- The instruction is valid with type ([t] -> []).

validation_of_LOCAL.TEE x
- |C.LOCAL| must be greater than x.
- Let t be C.LOCAL[x].
- The instruction is valid with type ([t] -> [t]).

validation_of_GLOBAL.GET x
- |C.GLOBAL| must be greater than x.
- Let (mut, t) be C.GLOBAL[x].
- The instruction is valid with type ([] -> [t]).

validation_of_GLOBAL.SET x
- |C.GLOBAL| must be greater than x.
- Let ((MUT ?(())), t) be C.GLOBAL[x].
- The instruction is valid with type ([t] -> []).

validation_of_MEMORY.SIZE
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type ([] -> [I32]).

validation_of_MEMORY.GROW
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type ([I32] -> [I32]).

validation_of_LOAD t (n, sx)? { ALIGN: n_A; OFFSET: n_O; }
- |C.MEM| must be greater than 0.
- ((sx? is ?())) and ((n? is ?())) are equivalent.
- (2 ^ n_A) must be less than or equal to ($size(t) / 8).
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(t) / 8).
- n? must be equal to ?().
- Let mt be C.MEM[0].
- The instruction is valid with type ([I32] -> [t]).

validation_of_STORE t n? { ALIGN: n_A; OFFSET: n_O; }
- |C.MEM| must be greater than 0.
- (2 ^ n_A) must be less than or equal to ($size(t) / 8).
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(t) / 8).
- n? must be equal to ?().
- Let mt be C.MEM[0].
- The instruction is valid with type ([I32, t] -> []).

Ki
1. Return 1024.

min n_u0 n_u1
1. If (n_u0 is 0), then:
  a. Return 0.
2. If (n_u1 is 0), then:
  a. Return 0.
3. Assert: Due to validation, (n_u0 ≥ 1).
4. Let i be (n_u0 - 1).
5. Assert: Due to validation, (n_u1 ≥ 1).
6. Let j be (n_u1 - 1).
7. Return $min(i, j).

sum n_u0*
1. If (n_u0* is []), then:
  a. Return 0.
2. Let [n] ++ n'* be n_u0*.
3. Return (n + $sum(n'*)).

signif N_u0
1. If (N_u0 is 32), then:
  a. Return 23.
2. Assert: Due to validation, (N_u0 is 64).
3. Return 52.

expon N_u0
1. If (N_u0 is 32), then:
  a. Return 8.
2. Assert: Due to validation, (N_u0 is 64).
3. Return 11.

M N
1. Return $signif(N).

E N
1. Return $expon(N).

fzero N
1. Return (POS (NORM 0 0)).

size valty_u0
1. If (valty_u0 is I32), then:
  a. Return 32.
2. If (valty_u0 is I64), then:
  a. Return 64.
3. If (valty_u0 is F32), then:
  a. Return 32.
4. If (valty_u0 is F64), then:
  a. Return 64.

memop0
1. Return { ALIGN: 0; OFFSET: 0; }.

signed N i
1. If (0 ≤ (2 ^ (N - 1))), then:
  a. Return i.
2. Assert: Due to validation, ((2 ^ (N - 1)) ≤ i).
3. Assert: Due to validation, (i < (2 ^ N)).
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

default valty_u0
1. If (valty_u0 is I32), then:
  a. Return (I32.CONST 0).
2. If (valty_u0 is I64), then:
  a. Return (I64.CONST 0).
3. If (valty_u0 is F32), then:
  a. Return (F32.CONST 0).
4. Assert: Due to validation, (valty_u0 is F64).
5. Return (F64.CONST 0).

funcsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $funcsxv(xv*).

globalsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globalsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $globalsxv(xv*).

tablesxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tablesxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $tablesxv(xv*).

memsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $memsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $memsxv(xv*).

store
1. Return.

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

local x
1. Let f be the current frame.
2. Return f.LOCAL[x].

with_local x v
1. Let f be the current frame.
2. Replace f.LOCAL[x] with v.

with_global x v
1. Let f be the current frame.
2. Replace s.GLOBAL[f.MODULE.GLOBAL[x]].VALUE with v.

with_table x i a
1. Let f be the current frame.
2. Replace s.TABLE[f.MODULE.TABLE[x]].ELEM[i] with ?(a).

with_tableinst x ti
1. Let f be the current frame.
2. Replace s.TABLE[f.MODULE.TABLE[x]] with ti.

with_mem x i j b*
1. Let f be the current frame.
2. Replace s.MEM[f.MODULE.MEM[x]].DATA[i : j] with b*.

with_meminst x mi
1. Let f be the current frame.
2. Replace s.MEM[f.MODULE.MEM[x]] with mi.

growtable ti n
1. Let { TYPE: (i, j); ELEM: ?(a)*; } be ti.
2. Let i' be (|a*| + n).
3. If (i' ≤ j), then:
  a. Let ti' be { TYPE: (i', j); ELEM: ?(a)* ++ ?()^n; }.
  b. Return ti'.

growmemory mi n
1. Let { TYPE: (i, j); DATA: b*; } be mi.
2. Let i' be ((|b*| / (64 · $Ki())) + n).
3. If (i' ≤ j), then:
  a. Let mi' be { TYPE: (i', j); DATA: b* ++ 0^((n · 64) · $Ki()); }.
  b. Return mi'.

funcs exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcs(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $funcs(externval'*).

globals exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globals(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $globals(externval'*).

tables exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tables(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $tables(externval'*).

mems exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $mems(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $mems(externval'*).

allocfunc mm func
1. Assert: Due to validation, func is of the case FUNC.
2. Let (FUNC x local* expr) be func.
3. Let fi be { TYPE: mm.TYPE[x]; MODULE: mm; CODE: func; }.
4. Let a be |s.FUNC|.
5. Append fi to the s.FUNC.
6. Return a.

allocfuncs mm func_u0*
1. If (func_u0* is []), then:
  a. Return [].
2. Let [func] ++ func'* be func_u0*.
3. Let fa be $allocfunc(mm, func).
4. Let fa'* be $allocfuncs(mm, func'*).
5. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let gi be { TYPE: globaltype; VALUE: val; }.
2. Let a be |s.GLOBAL|.
3. Append gi to the s.GLOBAL.
4. Return a.

allocglobals globa_u0* val_u1*
1. If (globa_u0* is []), then:
  a. Assert: Due to validation, (val_u1* is []).
  b. Return [].
2. Else:
  a. Let [globaltype] ++ globaltype'* be globa_u0*.
  b. Assert: Due to validation, (|val_u1*| ≥ 1).
  c. Let [val] ++ val'* be val_u1*.
  d. Let ga be $allocglobal(globaltype, val).
  e. Let ga'* be $allocglobals(globaltype'*, val'*).
  f. Return [ga] ++ ga'*.

alloctable (i, j)
1. Let ti be { TYPE: (i, j); ELEM: ?()^i; }.
2. Let a be |s.TABLE|.
3. Append ti to the s.TABLE.
4. Return a.

alloctables table_u0*
1. If (table_u0* is []), then:
  a. Return [].
2. Let [tabletype] ++ tabletype'* be table_u0*.
3. Let ta be $alloctable(tabletype).
4. Let ta'* be $alloctables(tabletype'*).
5. Return [ta] ++ ta'*.

allocmem (i, j)
1. Let mi be { TYPE: (i, j); DATA: 0^((i · 64) · $Ki()); }.
2. Let a be |s.MEM|.
3. Append mi to the s.MEM.
4. Return a.

allocmems memty_u0*
1. If (memty_u0* is []), then:
  a. Return [].
2. Let [memtype] ++ memtype'* be memty_u0*.
3. Let ma be $allocmem(memtype).
4. Let ma'* be $allocmems(memtype'*).
5. Return [ma] ++ ma'*.

instexport fa* ga* ta* ma* (EXPORT name exter_u0)
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC x) be exter_u0.
  b. Return { NAME: name; VALUE: (FUNC fa*[x]); }.
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be exter_u0.
  b. Return { NAME: name; VALUE: (GLOBAL ga*[x]); }.
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE x) be exter_u0.
  b. Return { NAME: name; VALUE: (TABLE ta*[x]); }.
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM x) be exter_u0.
6. Return { NAME: name; VALUE: (MEM ma*[x]); }.

allocmodule module externval* val*
1. Let fa_ex* be $funcs(externval*).
2. Let ga_ex* be $globals(externval*).
3. Let ma_ex* be $mems(externval*).
4. Let ta_ex* be $tables(externval*).
5. Assert: Due to validation, module is of the case MODULE.
6. Let (MODULE y_0 import* func^n_func y_1 y_2 y_3 elem* data* start? export*) be module.
7. Let (MEMORY memtype)^n_mem be y_3.
8. Let (TABLE tabletype)^n_table be y_2.
9. Let (GLOBAL globaltype expr_1)^n_global be y_1.
10. Let (TYPE ft)* be y_0.
11. Let fa* be (|s.FUNC| + i_func)^(i_func<n_func).
12. Let ga* be (|s.GLOBAL| + i_global)^(i_global<n_global).
13. Let ta* be (|s.TABLE| + i_table)^(i_table<n_table).
14. Let ma* be (|s.MEM| + i_mem)^(i_mem<n_mem).
15. Let xi* be $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*.
16. Let mm be { TYPE: ft*; FUNC: fa_ex* ++ fa*; GLOBAL: ga_ex* ++ ga*; TABLE: ta_ex* ++ ta*; MEM: ma_ex* ++ ma*; EXPORT: xi*; }.
17. Let y_0 be $allocfuncs(mm, func^n_func).
18. Assert: Due to validation, (y_0 is fa*).
19. Let y_0 be $allocglobals(globaltype^n_global, val*).
20. Assert: Due to validation, (y_0 is ga*).
21. Let y_0 be $alloctables(tabletype^n_table).
22. Assert: Due to validation, (y_0 is ta*).
23. Let y_0 be $allocmems(memtype^n_mem).
24. Assert: Due to validation, (y_0 is ma*).
25. Return mm.

concat_instr instr_u0*
1. If (instr_u0* is []), then:
  a. Return [].
2. Let [instr*] ++ instr'** be instr_u0*.
3. Return instr* ++ $concat_instr(instr'**).

initelem mm u32_u0* funca_u1*
1. If ((u32_u0* is []) and (funca_u1* is [])), then:
  a. Return.
2. Assert: Due to validation, (|funca_u1*| ≥ 1).
3. Let [a*] ++ a'** be funca_u1*.
4. Assert: Due to validation, (|u32_u0*| ≥ 1).
5. Let [i] ++ i'* be u32_u0*.
6. Replace s.TABLE[mm.TABLE[0]].ELEM[i : |a*|] with ?(a)*.
7. Perform $initelem(mm, i'*, a'**).
8. Return.

initdata mm u32_u0* byte_u1*
1. If ((u32_u0* is []) and (byte_u1* is [])), then:
  a. Return.
2. Assert: Due to validation, (|byte_u1*| ≥ 1).
3. Let [b*] ++ b'** be byte_u1*.
4. Assert: Due to validation, (|u32_u0*| ≥ 1).
5. Let [i] ++ i'* be u32_u0*.
6. Replace s.MEM[mm.MEM[0]].DATA[i : |b*|] with b*.
7. Perform $initdata(mm, i'*, b'**).
8. Return.

instantiate module externval*
1. Assert: Due to validation, module is of the case MODULE.
2. Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) be module.
3. Let (TYPE functype)* be type*.
4. Let n_F be |func*|.
5. Let (START x')? be start?.
6. Let (DATA expr_D b*)* be data*.
7. Let (ELEM expr_E x*)* be elem*.
8. Let (GLOBAL globaltype expr_G)* be global*.
9. Let mm_init be { TYPE: functype*; FUNC: $funcs(externval*) ++ (|s.FUNC| + i_F)^(i_F<n_F); GLOBAL: $globals(externval*); TABLE: []; MEM: []; EXPORT: []; }.
10. Let f_init be { LOCAL: []; MODULE: mm_init; }.
11. Let z be f_init.
12. Enter the activation of z with label [FRAME_]:
  a. Let [(I32.CONST i_D)]* be $eval_expr(expr_D)*.
13. Enter the activation of z with label [FRAME_]:
  a. Let [(I32.CONST i_E)]* be $eval_expr(expr_E)*.
14. Enter the activation of z with label [FRAME_]:
  a. Let [val]* be $eval_expr(expr_G)*.
15. Let mm be $allocmodule(module, externval*, val*).
16. Let f be { LOCAL: []; MODULE: mm; }.
17. Perform $initelem(mm, i_E*, mm.FUNC[x]**).
18. Perform $initdata(mm, i_D*, b**).
19. Enter the activation of f with arity 0 with label [FRAME_]:
  a. If x' is defined, then:
    1) Let ?(x'_0) be x'.
    2) Execute (CALL x'_0).
20. Return mm.

invoke fa val^n
1. Let f be { LOCAL: []; MODULE: { TYPE: []; FUNC: []; GLOBAL: []; TABLE: []; MEM: []; EXPORT: []; }; }.
2. Let (t_1^n -> t_2*) be $funcinst()[fa].TYPE.
3. Let k be |t_2*|.
4. Enter the activation of f with arity k with label [FRAME_]:
  a. Push val^n to the stack.
  b. Execute (CALL_ADDR fa).
5. Pop val^k from the stack.
6. Return val^k.

concat_bytes byte_u0*
1. If (byte_u0* is []), then:
  a. Return [].
2. Let [b*] ++ b'** be byte_u0*.
3. Return b* ++ $concat_bytes(b'**).

utf8 name_u0
1. If (|name_u0| is 1), then:
  a. Let [c] be name_u0.
  b. If (c < 128), then:
    1) Let b be c.
    2) Return [b].
  c. If ((128 ≤ c) and ((c < 2048) and (c ≥ (b_2 - 128)))), then:
    1) Let ((2 ^ 6) · (b_1 - 192)) be (c - (b_2 - 128)).
    2) Return [b_1, b_2].
  d. If ((((2048 ≤ c) and (c < 55296)) or ((57344 ≤ c) and (c < 65536))) and (c ≥ (b_3 - 128))), then:
    1) Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · (b_2 - 128))) be (c - (b_3 - 128)).
    2) Return [b_1, b_2, b_3].
  e. If ((65536 ≤ c) and ((c < 69632) and (c ≥ (b_4 - 128)))), then:
    1) Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · (b_2 - 128))) + ((2 ^ 6) · (b_3 - 128))) be (c - (b_4 - 128)).
    2) Return [b_1, b_2, b_3, b_4].
2. Let c* be name_u0.
3. Return $concat_bytes($utf8([c])*).

concat_locals local_u0*
1. If (local_u0* is []), then:
  a. Return [].
2. Let [loc*] ++ loc'** be local_u0*.
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
7. If (c is not 0), then:
  a. Push val_1 to the stack.
8. Else:
  a. Push val_2 to the stack.

execution_of_IF t? instr_1* instr_2*
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute (BLOCK t? instr_1*).
4. Else:
  a. Execute (BLOCK t? instr_2*).

execution_of_LABEL_
1. Pop all values val* from the stack.
2. Assert: Due to validation, a label is now on the top of the stack.
3. Exit current context.
4. Push val* to the stack.

execution_of_BR label_u0
1. Let L be the current label.
2. Let n be the arity of L.
3. Let instr'* be the continuation of L.
4. Pop all values admin_u1* from the stack.
5. Exit current context.
6. If ((label_u0 is 0) and (|admin_u1*| ≥ n)), then:
  a. Let val'* ++ val^n be admin_u1*.
  b. Push val^n to the stack.
  c. Execute the sequence (instr'*).
7. If (label_u0 ≥ 1), then:
  a. Let l be (label_u0 - 1).
  b. Let val* be admin_u1*.
  c. Push val* to the stack.
  d. Execute (BR l).

execution_of_BR_IF l
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute (BR l).
4. Else:
  a. Do nothing.

execution_of_BR_TABLE l* l'
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If (i < |l*|), then:
  a. Execute (BR l*[i]).
4. Else:
  a. Execute (BR l').

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

execution_of_UNOP t unop
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop (t.CONST c_1) from the stack.
3. If (|$unop(unop, t, c_1)| is 1), then:
  a. Let [c] be $unop(unop, t, c_1).
  b. Push (t.CONST c) to the stack.
4. If ($unop(unop, t, c_1) is []), then:
  a. Trap.

execution_of_BINOP t binop
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop (t.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type t is on the top of the stack.
4. Pop (t.CONST c_1) from the stack.
5. If (|$binop(binop, t, c_1, c_2)| is 1), then:
  a. Let [c] be $binop(binop, t, c_1, c_2).
  b. Push (t.CONST c) to the stack.
6. If ($binop(binop, t, c_1, c_2) is []), then:
  a. Trap.

execution_of_TESTOP t testop
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop (t.CONST c_1) from the stack.
3. Let c be $testop(testop, t, c_1).
4. Push (I32.CONST c) to the stack.

execution_of_RELOP t relop
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop (t.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type t is on the top of the stack.
4. Pop (t.CONST c_1) from the stack.
5. Let c be $relop(relop, t, c_1, c_2).
6. Push (I32.CONST c) to the stack.

execution_of_CVTOP t_2 cvtop t_1 sx?
1. Assert: Due to validation, a value of value type t_1 is on the top of the stack.
2. Pop (t_1.CONST c_1) from the stack.
3. If (|$cvtop(cvtop, t_1, t_2, sx?, c_1)| is 1), then:
  a. Let [c] be $cvtop(cvtop, t_1, t_2, sx?, c_1).
  b. Push (t_2.CONST c) to the stack.
4. If ($cvtop(cvtop, t_1, t_2, sx?, c_1) is []), then:
  a. Trap.

execution_of_LOCAL.TEE x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Push val to the stack.
4. Push val to the stack.
5. Execute (LOCAL.SET x).

execution_of_BLOCK t? instr*
1. If t? is not defined, then:
  a. Let n be 0.
2. Else:
  a. Let n be 1.
3. Let L be the label_n{[]}.
4. Enter L with label instr* ++ [LABEL_]:

execution_of_LOOP t? instr*
1. Let L be the label_0{[(LOOP t? instr*)]}.
2. Enter L with label instr* ++ [LABEL_]:

execution_of_CALL x
1. Assert: Due to validation, (x < |$funcaddr()|).
2. Execute (CALL_ADDR $funcaddr()[x]).

execution_of_CALL_INDIRECT x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If (i ≥ |$table(0).ELEM|), then:
  a. Trap.
4. If $table(0).ELEM[i] is not defined, then:
  a. Trap.
5. Let ?(a) be $table(0).ELEM[i].
6. If (a ≥ |$funcinst()|), then:
  a. Trap.
7. If ($type(x) is not $funcinst()[a].TYPE), then:
  a. Trap.
8. Execute (CALL_ADDR a).

execution_of_CALL_ADDR a
1. Assert: Due to validation, (a < |$funcinst()|).
2. Let { TYPE: (t_1^k -> t_2^n); MODULE: mm; CODE: func; } be $funcinst()[a].
3. Assert: Due to validation, there are at least k values on the top of the stack.
4. Pop val^k from the stack.
5. Assert: Due to validation, func is of the case FUNC.
6. Let (FUNC x y_0 instr*) be func.
7. Let (LOCAL t)* be y_0.
8. Let f be { LOCAL: val^k ++ $default(t)*; MODULE: mm; }.
9. Let F be the activation of f with arity n.
10. Enter F with label [FRAME_]:
  a. Let L be the label_n{[]}.
  b. Enter L with label instr* ++ [LABEL_]:

execution_of_LOCAL.GET x
1. Push $local(x) to the stack.

execution_of_GLOBAL.GET x
1. Push $global(x).VALUE to the stack.

execution_of_LOAD t n_sx_u0? mo
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If ((((i + mo.OFFSET) + ($size(t) / 8)) > |$mem(0).DATA|) and n_sx_u0? is not defined), then:
  a. Trap.
4. If n_sx_u0? is not defined, then:
  a. Let c be $inverse_of_bytes(t, $mem(0).DATA[(i + mo.OFFSET) : ($size(t) / 8)]).
  b. Push (t.CONST c) to the stack.
5. Else:
  a. Let ?(y_0) be n_sx_u0?.
  b. Let (n, sx) be y_0.
  c. If (((i + mo.OFFSET) + (n / 8)) > |$mem(0).DATA|), then:
    1) Trap.
  d. Let c be $inverse_of_ibytes(n, $mem(0).DATA[(i + mo.OFFSET) : (n / 8)]).
  e. Push (t.CONST $ext(n, $size(t), sx, c)) to the stack.

execution_of_MEMORY.SIZE
1. Let ((n · 64) · $Ki()) be |$mem(0).DATA|.
2. Push (I32.CONST n) to the stack.

execution_of_LOCAL.SET x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Perform $with_local(x, val).

execution_of_GLOBAL.SET x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Perform $with_global(x, val).

execution_of_STORE t n_u0? mo
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop (t.CONST c) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If ((((i + mo.OFFSET) + ($size(t) / 8)) > |$mem(0).DATA|) and n_u0? is not defined), then:
  a. Trap.
6. If n_u0? is not defined, then:
  a. Let b* be $bytes(t, c).
  b. Perform $with_mem(0, (i + mo.OFFSET), ($size(t) / 8), b*).
7. Else:
  a. Let ?(n) be n_u0?.
  b. If (((i + mo.OFFSET) + (n / 8)) > |$mem(0).DATA|), then:
    1) Trap.
  c. Let b* be $ibytes(n, $wrap($size(t), n, c)).
  d. Perform $with_mem(0, (i + mo.OFFSET), (n / 8), b*).

execution_of_MEMORY.GROW
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Either:
  a. Let mi be $growmemory($mem(0), n).
  b. Push (I32.CONST (|$mem(0).DATA| / (64 · $Ki()))) to the stack.
  c. Perform $with_meminst(0, mi).
4. Or:
  a. Push (I32.CONST $invsigned(32, (- 1))) to the stack.

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
6. If (a < |$funcinst()|), then:
  a. Let fi be $funcinst()[a].
  b. Assert: Due to validation, fi.CODE is of the case FUNC.
  c. Let (FUNC y_0 y_1 instr*) be fi.CODE.
  d. Let (LOCAL t)* be y_1.
  e. Assert: Due to validation, $expanddt(fi.TYPE) is of the case FUNC.
  f. Let (FUNC y_0) be $expanddt(fi.TYPE).
  g. Let (t_1^n -> t_2^m) be y_0.
  h. Assert: Due to validation, there are at least n values on the top of the stack.
  i. Pop val^n from the stack.
  j. Let f be { LOCAL: ?(val)^n ++ $default(t)*; MODULE: fi.MODULE; }.
  k. Let F be the activation of f with arity m.
  l. Enter F with label [FRAME_]:
    1) Let L be the label_m{[]}.
    2) Enter L with label instr* ++ [LABEL_]:

group_bytes_by n byte*
1. Let n' be |byte*|.
2. If (n' ≥ n), then:
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
  c. If ((i + ((n · $storagesize(zt)) / 8)) > |$data(y).DATA|), then:
    1) Trap.
  d. Let nt be $unpacknumtype(zt).
  e. Let b* be $data(y).DATA[i : ((n · $storagesize(zt)) / 8)].
  f. Let gb* be $group_bytes_by(($storagesize(zt) / 8), b*).
  g. Let c^n be $inverse_of_ibytes($storagesize(zt), gb)*.
  h. Push (nt.CONST c)^n to the stack.
  i. Execute (ARRAY.NEW_FIXED x n).

== Complete.
Generating prose for Wasm 2.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
=================
 Generated prose
=================
validation_of_UNREACHABLE
- The instruction is valid with type (t_1* -> t_2*).

validation_of_NOP
- The instruction is valid with type ([] -> []).

validation_of_DROP
- The instruction is valid with type ([t] -> []).

validation_of_SELECT ?([t])
- The instruction is valid with type ([t, t, I32] -> [t]).

validation_of_BLOCK bt instr*
- Under the context C with .LABEL prepended by [t_2*], instr* must be valid with type (t_1* -> t_2*).
- Under the context C, bt must be valid with type (t_1* -> t_2*).
- The instruction is valid with type (t_1* -> t_2*).

validation_of_LOOP bt instr*
- Under the context C with .LABEL prepended by [t_1*], instr* must be valid with type (t_1* -> t_2*).
- Under the context C, bt must be valid with type (t_1* -> t_2*).
- The instruction is valid with type (t_1* -> t_2*).

validation_of_IF bt instr_1* instr_2*
- Under the context C with .LABEL prepended by [t_2*], instr_2* must be valid with type (t_1* -> t_2*).
- Under the context C, bt must be valid with type (t_1* -> t_2*).
- Under the context C with .LABEL prepended by [t_2*], instr_1* must be valid with type (t_1* -> t_2*).
- The instruction is valid with type (t_1* ++ [I32] -> t_2*).

validation_of_BR l
- |C.LABEL| must be greater than l.
- Let t* be C.LABEL[l].
- The instruction is valid with type (t_1* ++ t* -> t_2*).

validation_of_BR_IF l
- |C.LABEL| must be greater than l.
- Let t* be C.LABEL[l].
- The instruction is valid with type (t* ++ [I32] -> t*).

validation_of_BR_TABLE l* l'
- For all l in l*,
  - |C.LABEL| must be greater than l.
- |C.LABEL| must be greater than l'.
- For all l in l*,
  - C.LABEL[l] must match t*.
- C.LABEL[l'] must match t*.
- The instruction is valid with type (t_1* ++ t* -> t_2*).

validation_of_RETURN
- Let ?(t*) be C.RETURN.
- The instruction is valid with type (t_1* ++ t* -> t_2*).

validation_of_CALL x
- |C.FUNC| must be greater than x.
- Let (t_1* -> t_2*) be C.FUNC[x].
- The instruction is valid with type (t_1* -> t_2*).

validation_of_CALL_INDIRECT x y
- |C.TABLE| must be greater than x.
- |C.TYPE| must be greater than y.
- Let (lim, FUNCREF) be C.TABLE[x].
- Let (t_1* -> t_2*) be C.TYPE[y].
- The instruction is valid with type (t_1* ++ [I32] -> t_2*).

validation_of_CONST nt c_nt
- The instruction is valid with type ([] -> [nt]).

validation_of_UNOP nt unop
- The instruction is valid with type ([nt] -> [nt]).

validation_of_BINOP nt binop
- The instruction is valid with type ([nt, nt] -> [nt]).

validation_of_TESTOP nt testop
- The instruction is valid with type ([nt] -> [I32]).

validation_of_RELOP nt relop
- The instruction is valid with type ([nt, nt] -> [I32]).

validation_of_EXTEND nt n
- n must be less than or equal to $size(nt).
- The instruction is valid with type ([nt] -> [nt]).

validation_of_CVTOP nt_1 REINTERPRET nt_2 ?()
- nt_1 must be different with nt_2.
- $size(nt_1) must be equal to $size(nt_2).
- The instruction is valid with type ([nt_2] -> [nt_1]).

validation_of_CVTOP inn_1 CONVERT inn_2 sx?
- inn_1 must be different with inn_2.
- (($size(inn_1) > $size(inn_2))) and ((sx? is ?())) are equivalent.
- The instruction is valid with type ([inn_2] -> [inn_1]).

validation_of_REF.NULL rt
- The instruction is valid with type ([] -> [rt]).

validation_of_REF.FUNC x
- |C.FUNC| must be greater than x.
- Let ft be C.FUNC[x].
- The instruction is valid with type ([] -> [FUNCREF]).

validation_of_REF.IS_NULL
- The instruction is valid with type ([rt] -> [I32]).

validation_of_LOCAL.GET x
- |C.LOCAL| must be greater than x.
- Let t be C.LOCAL[x].
- The instruction is valid with type ([] -> [t]).

validation_of_LOCAL.SET x
- |C.LOCAL| must be greater than x.
- Let t be C.LOCAL[x].
- The instruction is valid with type ([t] -> []).

validation_of_LOCAL.TEE x
- |C.LOCAL| must be greater than x.
- Let t be C.LOCAL[x].
- The instruction is valid with type ([t] -> [t]).

validation_of_GLOBAL.GET x
- |C.GLOBAL| must be greater than x.
- Let (mut, t) be C.GLOBAL[x].
- The instruction is valid with type ([] -> [t]).

validation_of_GLOBAL.SET x
- |C.GLOBAL| must be greater than x.
- Let ((MUT ?(())), t) be C.GLOBAL[x].
- The instruction is valid with type ([t] -> []).

validation_of_TABLE.GET x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type ([I32] -> [rt]).

validation_of_TABLE.SET x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type ([I32, rt] -> []).

validation_of_TABLE.SIZE x
- |C.TABLE| must be greater than x.
- Let tt be C.TABLE[x].
- The instruction is valid with type ([] -> [I32]).

validation_of_TABLE.GROW x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type ([rt, I32] -> [I32]).

validation_of_TABLE.FILL x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type ([I32, rt, I32] -> []).

validation_of_TABLE.COPY x_1 x_2
- |C.TABLE| must be greater than x_1.
- |C.TABLE| must be greater than x_2.
- Let (lim_1, rt) be C.TABLE[x_1].
- Let (lim_2, rt) be C.TABLE[x_2].
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_TABLE.INIT x_1 x_2
- |C.TABLE| must be greater than x_1.
- |C.ELEM| must be greater than x_2.
- Let (lim, rt) be C.TABLE[x_1].
- C.ELEM[x_2] must be equal to rt.
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_ELEM.DROP x
- |C.ELEM| must be greater than x.
- Let rt be C.ELEM[x].
- The instruction is valid with type ([] -> []).

validation_of_MEMORY.SIZE
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type ([] -> [I32]).

validation_of_MEMORY.GROW
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type ([I32] -> [I32]).

validation_of_MEMORY.FILL
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_MEMORY.COPY
- |C.MEM| must be greater than 0.
- Let mt be C.MEM[0].
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_MEMORY.INIT x
- |C.MEM| must be greater than 0.
- |C.DATA| must be greater than x.
- C.DATA[x] must be equal to OK.
- Let mt be C.MEM[0].
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_DATA.DROP x
- |C.DATA| must be greater than x.
- C.DATA[x] must be equal to OK.
- The instruction is valid with type ([] -> []).

validation_of_LOAD nt (n, sx)? { ALIGN: n_A; OFFSET: n_O; }
- |C.MEM| must be greater than 0.
- ((sx? is ?())) and ((n? is ?())) are equivalent.
- (2 ^ n_A) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEM[0].
- The instruction is valid with type ([I32] -> [nt]).

validation_of_STORE nt n? { ALIGN: n_A; OFFSET: n_O; }
- |C.MEM| must be greater than 0.
- (2 ^ n_A) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEM[0].
- The instruction is valid with type ([I32, nt] -> []).

Ki
1. Return 1024.

min n_u0 n_u1
1. If (n_u0 is 0), then:
  a. Return 0.
2. If (n_u1 is 0), then:
  a. Return 0.
3. Assert: Due to validation, (n_u0 ≥ 1).
4. Let i be (n_u0 - 1).
5. Assert: Due to validation, (n_u1 ≥ 1).
6. Let j be (n_u1 - 1).
7. Return $min(i, j).

sum n_u0*
1. If (n_u0* is []), then:
  a. Return 0.
2. Let [n] ++ n'* be n_u0*.
3. Return (n + $sum(n'*)).

signif N_u0
1. If (N_u0 is 32), then:
  a. Return 23.
2. Assert: Due to validation, (N_u0 is 64).
3. Return 52.

expon N_u0
1. If (N_u0 is 32), then:
  a. Return 8.
2. Assert: Due to validation, (N_u0 is 64).
3. Return 11.

M N
1. Return $signif(N).

E N
1. Return $expon(N).

fzero N
1. Return (POS (NORM 0 0)).

size valty_u0
1. If (valty_u0 is I32), then:
  a. Return 32.
2. If (valty_u0 is I64), then:
  a. Return 64.
3. If (valty_u0 is F32), then:
  a. Return 32.
4. If (valty_u0 is F64), then:
  a. Return 64.
5. If (valty_u0 is V128), then:
  a. Return 128.

free_dataidx_instr instr_u0
1. If instr_u0 is of the case MEMORY.INIT, then:
  a. Let (MEMORY.INIT x) be instr_u0.
  b. Return [x].
2. If instr_u0 is of the case DATA.DROP, then:
  a. Let (DATA.DROP x) be instr_u0.
  b. Return [x].
3. Return [].

free_dataidx_instrs instr_u0*
1. If (instr_u0* is []), then:
  a. Return [].
2. Let [instr] ++ instr'* be instr_u0*.
3. Return $free_dataidx_instr(instr) ++ $free_dataidx_instrs(instr'*).

free_dataidx_expr in*
1. Return $free_dataidx_instrs(in*).

free_dataidx_func (FUNC x loc* e)
1. Return $free_dataidx_expr(e).

free_dataidx_funcs func_u0*
1. If (func_u0* is []), then:
  a. Return [].
2. Let [func] ++ func'* be func_u0*.
3. Return $free_dataidx_func(func) ++ $free_dataidx_funcs(func'*).

memop0
1. Return { ALIGN: 0; OFFSET: 0; }.

signed N i
1. If (0 ≤ (2 ^ (N - 1))), then:
  a. Return i.
2. Assert: Due to validation, ((2 ^ (N - 1)) ≤ i).
3. Assert: Due to validation, (i < (2 ^ N)).
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

default valty_u0
1. If (valty_u0 is I32), then:
  a. Return (I32.CONST 0).
2. If (valty_u0 is I64), then:
  a. Return (I64.CONST 0).
3. If (valty_u0 is F32), then:
  a. Return (F32.CONST 0).
4. If (valty_u0 is F64), then:
  a. Return (F64.CONST 0).
5. If (valty_u0 is FUNCREF), then:
  a. Return (REF.NULL FUNCREF).
6. Assert: Due to validation, (valty_u0 is EXTERNREF).
7. Return (REF.NULL EXTERNREF).

funcsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $funcsxv(xv*).

globalsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globalsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $globalsxv(xv*).

tablesxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tablesxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $tablesxv(xv*).

memsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $memsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $memsxv(xv*).

store
1. Return.

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

growtable ti n r
1. Let { TYPE: ((i, j), rt); ELEM: r'*; } be ti.
2. Let i' be (|r'*| + n).
3. If (i' ≤ j), then:
  a. Let ti' be { TYPE: ((i', j), rt); ELEM: r'* ++ r^n; }.
  b. Return ti'.

growmemory mi n
1. Let { TYPE: (I8 (i, j)); DATA: b*; } be mi.
2. Let i' be ((|b*| / (64 · $Ki())) + n).
3. If (i' ≤ j), then:
  a. Let mi' be { TYPE: (I8 (i', j)); DATA: b* ++ 0^((n · 64) · $Ki()); }.
  b. Return mi'.

blocktype block_u1
1. If (block_u1 is (_RESULT ?())), then:
  a. Return ([] -> []).
2. If block_u1 is of the case _RESULT, then:
  a. Let (_RESULT y_0) be block_u1.
  b. If y_0 is defined, then:
    1) Let ?(t) be y_0.
    2) Return ([] -> [t]).
3. Assert: Due to validation, block_u1 is of the case _IDX.
4. Let (_IDX x) be block_u1.
5. Return $type(x).

funcs exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcs(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $funcs(externval'*).

globals exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globals(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $globals(externval'*).

tables exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tables(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $tables(externval'*).

mems exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $mems(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $mems(externval'*).

allocfunc mm func
1. Assert: Due to validation, func is of the case FUNC.
2. Let (FUNC x local* expr) be func.
3. Let fi be { TYPE: mm.TYPE[x]; MODULE: mm; CODE: func; }.
4. Let a be |s.FUNC|.
5. Append fi to the s.FUNC.
6. Return a.

allocfuncs mm func_u0*
1. If (func_u0* is []), then:
  a. Return [].
2. Let [func] ++ func'* be func_u0*.
3. Let fa be $allocfunc(mm, func).
4. Let fa'* be $allocfuncs(mm, func'*).
5. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let gi be { TYPE: globaltype; VALUE: val; }.
2. Let a be |s.GLOBAL|.
3. Append gi to the s.GLOBAL.
4. Return a.

allocglobals globa_u0* val_u1*
1. If (globa_u0* is []), then:
  a. Assert: Due to validation, (val_u1* is []).
  b. Return [].
2. Else:
  a. Let [globaltype] ++ globaltype'* be globa_u0*.
  b. Assert: Due to validation, (|val_u1*| ≥ 1).
  c. Let [val] ++ val'* be val_u1*.
  d. Let ga be $allocglobal(globaltype, val).
  e. Let ga'* be $allocglobals(globaltype'*, val'*).
  f. Return [ga] ++ ga'*.

alloctable ((i, j), rt)
1. Let ti be { TYPE: ((i, j), rt); ELEM: (REF.NULL rt)^i; }.
2. Let a be |s.TABLE|.
3. Append ti to the s.TABLE.
4. Return a.

alloctables table_u0*
1. If (table_u0* is []), then:
  a. Return [].
2. Let [tabletype] ++ tabletype'* be table_u0*.
3. Let ta be $alloctable(tabletype).
4. Let ta'* be $alloctables(tabletype'*).
5. Return [ta] ++ ta'*.

allocmem (I8 (i, j))
1. Let mi be { TYPE: (I8 (i, j)); DATA: 0^((i · 64) · $Ki()); }.
2. Let a be |s.MEM|.
3. Append mi to the s.MEM.
4. Return a.

allocmems memty_u0*
1. If (memty_u0* is []), then:
  a. Return [].
2. Let [memtype] ++ memtype'* be memty_u0*.
3. Let ma be $allocmem(memtype).
4. Let ma'* be $allocmems(memtype'*).
5. Return [ma] ++ ma'*.

allocelem rt ref*
1. Let ei be { TYPE: rt; ELEM: ref*; }.
2. Let a be |s.ELEM|.
3. Append ei to the s.ELEM.
4. Return a.

allocelems refty_u0* ref_u1*
1. If ((refty_u0* is []) and (ref_u1* is [])), then:
  a. Return [].
2. Assert: Due to validation, (|ref_u1*| ≥ 1).
3. Let [ref*] ++ ref'** be ref_u1*.
4. Assert: Due to validation, (|refty_u0*| ≥ 1).
5. Let [rt] ++ rt'* be refty_u0*.
6. Let ea be $allocelem(rt, ref*).
7. Let ea'* be $allocelems(rt'*, ref'**).
8. Return [ea] ++ ea'*.

allocdata byte*
1. Let di be { DATA: byte*; }.
2. Let a be |s.DATA|.
3. Append di to the s.DATA.
4. Return a.

allocdatas byte_u0*
1. If (byte_u0* is []), then:
  a. Return [].
2. Let [byte*] ++ byte'** be byte_u0*.
3. Let da be $allocdata(byte*).
4. Let da'* be $allocdatas(byte'**).
5. Return [da] ++ da'*.

instexport fa* ga* ta* ma* (EXPORT name exter_u0)
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC x) be exter_u0.
  b. Return { NAME: name; VALUE: (FUNC fa*[x]); }.
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be exter_u0.
  b. Return { NAME: name; VALUE: (GLOBAL ga*[x]); }.
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE x) be exter_u0.
  b. Return { NAME: name; VALUE: (TABLE ta*[x]); }.
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM x) be exter_u0.
6. Return { NAME: name; VALUE: (MEM ma*[x]); }.

allocmodule module externval* val* ref**
1. Let fa_ex* be $funcs(externval*).
2. Let ga_ex* be $globals(externval*).
3. Let ma_ex* be $mems(externval*).
4. Let ta_ex* be $tables(externval*).
5. Assert: Due to validation, module is of the case MODULE.
6. Let (MODULE y_0 import* func^n_func y_1 y_2 y_3 y_4 y_5 start? export*) be module.
7. Let (DATA byte* datamode)^n_data be y_5.
8. Let (ELEM rt expr_2* elemmode)^n_elem be y_4.
9. Let (MEMORY memtype)^n_mem be y_3.
10. Let (TABLE tabletype)^n_table be y_2.
11. Let (GLOBAL globaltype expr_1)^n_global be y_1.
12. Let (TYPE ft)* be y_0.
13. Let fa* be (|s.FUNC| + i_func)^(i_func<n_func).
14. Let ga* be (|s.GLOBAL| + i_global)^(i_global<n_global).
15. Let ta* be (|s.TABLE| + i_table)^(i_table<n_table).
16. Let ma* be (|s.MEM| + i_mem)^(i_mem<n_mem).
17. Let ea* be (|s.ELEM| + i_elem)^(i_elem<n_elem).
18. Let da* be (|s.DATA| + i_data)^(i_data<n_data).
19. Let xi* be $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*.
20. Let mm be { TYPE: ft*; FUNC: fa_ex* ++ fa*; GLOBAL: ga_ex* ++ ga*; TABLE: ta_ex* ++ ta*; MEM: ma_ex* ++ ma*; ELEM: ea*; DATA: da*; EXPORT: xi*; }.
21. Let y_0 be $allocfuncs(mm, func^n_func).
22. Assert: Due to validation, (y_0 is fa*).
23. Let y_0 be $allocglobals(globaltype^n_global, val*).
24. Assert: Due to validation, (y_0 is ga*).
25. Let y_0 be $alloctables(tabletype^n_table).
26. Assert: Due to validation, (y_0 is ta*).
27. Let y_0 be $allocmems(memtype^n_mem).
28. Assert: Due to validation, (y_0 is ma*).
29. Let y_0 be $allocelems(rt^n_elem, ref**).
30. Assert: Due to validation, (y_0 is ea*).
31. Let y_0 be $allocdatas(byte*^n_data).
32. Assert: Due to validation, (y_0 is da*).
33. Return mm.

concat_instr instr_u0*
1. If (instr_u0* is []), then:
  a. Return [].
2. Let [instr*] ++ instr'** be instr_u0*.
3. Return instr* ++ $concat_instr(instr'**).

runelem (ELEM reftype expr* elemm_u0) i
1. If (elemm_u0 is PASSIVE), then:
  a. Return [].
2. If (elemm_u0 is DECLARE), then:
  a. Return [(ELEM.DROP i)].
3. Assert: Due to validation, elemm_u0 is of the case ACTIVE.
4. Let (ACTIVE x instr*) be elemm_u0.
5. Let n be |expr*|.
6. Return instr* ++ [(I32.CONST 0), (I32.CONST n), (TABLE.INIT x i), (ELEM.DROP i)].

rundata (DATA byte* datam_u0) i
1. If (datam_u0 is PASSIVE), then:
  a. Return [].
2. Assert: Due to validation, datam_u0 is of the case ACTIVE.
3. Let (ACTIVE y_0 instr*) be datam_u0.
4. Assert: Due to validation, (y_0 is 0).
5. Let n be |byte*|.
6. Return instr* ++ [(I32.CONST 0), (I32.CONST n), (MEMORY.INIT i), (DATA.DROP i)].

instantiate module externval*
1. Assert: Due to validation, module is of the case MODULE.
2. Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) be module.
3. Let (TYPE functype)* be type*.
4. Let n_D be |data*|.
5. Let n_E be |elem*|.
6. Let n_F be |func*|.
7. Let (START x)? be start?.
8. Let (GLOBAL globaltype expr_G)* be global*.
9. Let (ELEM reftype expr_E* elemmode)* be elem*.
10. Let instr_D* be $concat_instr($rundata(data*[j], j)^(j<n_D)).
11. Let instr_E* be $concat_instr($runelem(elem*[i], i)^(i<n_E)).
12. Let mm_init be { TYPE: functype*; FUNC: $funcs(externval*) ++ (|s.FUNC| + i_F)^(i_F<n_F); GLOBAL: $globals(externval*); TABLE: []; MEM: []; ELEM: []; DATA: []; EXPORT: []; }.
13. Let f_init be { LOCAL: []; MODULE: mm_init; }.
14. Let z be f_init.
15. Enter the activation of z with label [FRAME_]:
  a. Let [val]* be $eval_expr(expr_G)*.
16. Enter the activation of z with label [FRAME_]:
  a. Let [ref]** be $eval_expr(expr_E)**.
17. Let mm be $allocmodule(module, externval*, val*, ref**).
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
2. Let (t_1^n -> t_2*) be $funcinst()[fa].TYPE.
3. Let k be |t_2*|.
4. Enter the activation of f with arity k with label [FRAME_]:
  a. Push val^n to the stack.
  b. Execute (CALL_ADDR fa).
5. Pop val^k from the stack.
6. Return val^k.

concat_bytes byte_u0*
1. If (byte_u0* is []), then:
  a. Return [].
2. Let [b*] ++ b'** be byte_u0*.
3. Return b* ++ $concat_bytes(b'**).

utf8 name_u0
1. If (|name_u0| is 1), then:
  a. Let [c] be name_u0.
  b. If (c < 128), then:
    1) Let b be c.
    2) Return [b].
  c. If ((128 ≤ c) and ((c < 2048) and (c ≥ (b_2 - 128)))), then:
    1) Let ((2 ^ 6) · (b_1 - 192)) be (c - (b_2 - 128)).
    2) Return [b_1, b_2].
  d. If ((((2048 ≤ c) and (c < 55296)) or ((57344 ≤ c) and (c < 65536))) and (c ≥ (b_3 - 128))), then:
    1) Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · (b_2 - 128))) be (c - (b_3 - 128)).
    2) Return [b_1, b_2, b_3].
  e. If ((65536 ≤ c) and ((c < 69632) and (c ≥ (b_4 - 128)))), then:
    1) Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · (b_2 - 128))) + ((2 ^ 6) · (b_3 - 128))) be (c - (b_4 - 128)).
    2) Return [b_1, b_2, b_3, b_4].
2. Let c* be name_u0.
3. Return $concat_bytes($utf8([c])*).

concat_locals local_u0*
1. If (local_u0* is []), then:
  a. Return [].
2. Let [loc*] ++ loc'** be local_u0*.
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
7. If (c is not 0), then:
  a. Push val_1 to the stack.
8. Else:
  a. Push val_2 to the stack.

execution_of_IF bt instr_1* instr_2*
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute (BLOCK bt instr_1*).
4. Else:
  a. Execute (BLOCK bt instr_2*).

execution_of_LABEL_
1. Pop all values val* from the stack.
2. Assert: Due to validation, a label is now on the top of the stack.
3. Exit current context.
4. Push val* to the stack.

execution_of_BR label_u0
1. Let L be the current label.
2. Let n be the arity of L.
3. Let instr'* be the continuation of L.
4. Pop all values admin_u1* from the stack.
5. Exit current context.
6. If ((label_u0 is 0) and (|admin_u1*| ≥ n)), then:
  a. Let val'* ++ val^n be admin_u1*.
  b. Push val^n to the stack.
  c. Execute the sequence (instr'*).
7. If (label_u0 ≥ 1), then:
  a. Let l be (label_u0 - 1).
  b. Let val* be admin_u1*.
  c. Push val* to the stack.
  d. Execute (BR l).

execution_of_BR_IF l
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute (BR l).
4. Else:
  a. Do nothing.

execution_of_BR_TABLE l* l'
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If (i < |l*|), then:
  a. Execute (BR l*[i]).
4. Else:
  a. Execute (BR l').

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
3. If (|$unop(unop, nt, c_1)| is 1), then:
  a. Let [c] be $unop(unop, nt, c_1).
  b. Push (nt.CONST c) to the stack.
4. If ($unop(unop, nt, c_1) is []), then:
  a. Trap.

execution_of_BINOP nt binop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop (nt.CONST c_1) from the stack.
5. If (|$binop(binop, nt, c_1, c_2)| is 1), then:
  a. Let [c] be $binop(binop, nt, c_1, c_2).
  b. Push (nt.CONST c) to the stack.
6. If ($binop(binop, nt, c_1, c_2) is []), then:
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
3. If (|$cvtop(cvtop, nt_1, nt_2, sx?, c_1)| is 1), then:
  a. Let [c] be $cvtop(cvtop, nt_1, nt_2, sx?, c_1).
  b. Push (nt_2.CONST c) to the stack.
4. If ($cvtop(cvtop, nt_1, nt_2, sx?, c_1) is []), then:
  a. Trap.

execution_of_REF.IS_NULL
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. If val is of the case REF.NULL, then:
  a. Push (I32.CONST 1) to the stack.
4. Else:
  a. Push (I32.CONST 0) to the stack.

execution_of_LOCAL.TEE x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Push val to the stack.
4. Push val to the stack.
5. Execute (LOCAL.SET x).

execution_of_BLOCK bt instr*
1. Let (t_1^k -> t_2^n) be $blocktype(bt).
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. Let L be the label_n{[]}.
5. Enter L with label instr* ++ [LABEL_]:
  a. Push val^k to the stack.

execution_of_LOOP bt instr*
1. Let (t_1^k -> t_2^n) be $blocktype(bt).
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. Let L be the label_k{[(LOOP bt instr*)]}.
5. Enter L with label instr* ++ [LABEL_]:
  a. Push val^k to the stack.

execution_of_CALL x
1. Assert: Due to validation, (x < |$funcaddr()|).
2. Execute (CALL_ADDR $funcaddr()[x]).

execution_of_CALL_INDIRECT x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If (i ≥ |$table(x).ELEM|), then:
  a. Trap.
4. If $table(x).ELEM[i] is not of the case REF.FUNC_ADDR, then:
  a. Trap.
5. Let (REF.FUNC_ADDR a) be $table(x).ELEM[i].
6. If (a ≥ |$funcinst()|), then:
  a. Trap.
7. If ($type(y) is not $funcinst()[a].TYPE), then:
  a. Trap.
8. Execute (CALL_ADDR a).

execution_of_CALL_ADDR a
1. Assert: Due to validation, (a < |$funcinst()|).
2. Let { TYPE: (t_1^k -> t_2^n); MODULE: mm; CODE: func; } be $funcinst()[a].
3. Assert: Due to validation, there are at least k values on the top of the stack.
4. Pop val^k from the stack.
5. Assert: Due to validation, func is of the case FUNC.
6. Let (FUNC x y_0 instr*) be func.
7. Let (LOCAL t)* be y_0.
8. Let f be { LOCAL: val^k ++ $default(t)*; MODULE: mm; }.
9. Let F be the activation of f with arity n.
10. Enter F with label [FRAME_]:
  a. Let L be the label_n{[]}.
  b. Enter L with label instr* ++ [LABEL_]:

execution_of_REF.FUNC x
1. Assert: Due to validation, (x < |$funcaddr()|).
2. Push (REF.FUNC_ADDR $funcaddr()[x]) to the stack.

execution_of_LOCAL.GET x
1. Push $local(x) to the stack.

execution_of_GLOBAL.GET x
1. Push $global(x).VALUE to the stack.

execution_of_TABLE.GET x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If (i ≥ |$table(x).ELEM|), then:
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
7. If ((i + n) > |$table(x).ELEM|), then:
  a. Trap.
8. If (n is 0), then:
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
7. If ((i + n) > |$table(y).ELEM|), then:
  a. Trap.
8. If ((j + n) > |$table(x).ELEM|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else:
  a. If (j ≤ i), then:
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
7. If ((i + n) > |$elem(y).ELEM|), then:
  a. Trap.
8. If ((j + n) > |$table(x).ELEM|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else if (i < |$elem(y).ELEM|), then:
  a. Push (I32.CONST j) to the stack.
  b. Push $elem(y).ELEM[i] to the stack.
  c. Execute (TABLE.SET x).
  d. Push (I32.CONST (j + 1)) to the stack.
  e. Push (I32.CONST (i + 1)) to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (TABLE.INIT x y).

execution_of_LOAD nt n_sx_u0? mo
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If ((((i + mo.OFFSET) + ($size(nt) / 8)) > |$mem(0).DATA|) and n_sx_u0? is not defined), then:
  a. Trap.
4. If n_sx_u0? is not defined, then:
  a. Let c be $inverse_of_ntbytes(nt, $mem(0).DATA[(i + mo.OFFSET) : ($size(nt) / 8)]).
  b. Push (nt.CONST c) to the stack.
5. Else:
  a. Let ?(y_0) be n_sx_u0?.
  b. Let (n, sx) be y_0.
  c. If (((i + mo.OFFSET) + (n / 8)) > |$mem(0).DATA|), then:
    1) Trap.
  d. Let c be $inverse_of_ibytes(n, $mem(0).DATA[(i + mo.OFFSET) : (n / 8)]).
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
7. If ((i + n) > |$mem(0).DATA|), then:
  a. Trap.
8. If (n is 0), then:
  a. Do nothing.
9. Else:
  a. Push (I32.CONST i) to the stack.
  b. Push val to the stack.
  c. Execute (STORE I32 ?(8) $memop0()).
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
7. If ((i + n) > |$mem(0).DATA|), then:
  a. Trap.
8. If ((j + n) > |$mem(0).DATA|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else:
  a. If (j ≤ i), then:
    1) Push (I32.CONST j) to the stack.
    2) Push (I32.CONST i) to the stack.
    3) Execute (LOAD I32 ?((8, U)) $memop0()).
    4) Execute (STORE I32 ?(8) $memop0()).
    5) Push (I32.CONST (j + 1)) to the stack.
    6) Push (I32.CONST (i + 1)) to the stack.
  b. Else:
    1) Push (I32.CONST ((j + n) - 1)) to the stack.
    2) Push (I32.CONST ((i + n) - 1)) to the stack.
    3) Execute (LOAD I32 ?((8, U)) $memop0()).
    4) Execute (STORE I32 ?(8) $memop0()).
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
7. If ((i + n) > |$data(x).DATA|), then:
  a. Trap.
8. If ((j + n) > |$mem(0).DATA|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else if (i < |$data(x).DATA|), then:
  a. Push (I32.CONST j) to the stack.
  b. Push (I32.CONST $data(x).DATA[i]) to the stack.
  c. Execute (STORE I32 ?(8) $memop0()).
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
5. If (i ≥ |$table(x).ELEM|), then:
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

execution_of_STORE nt n_u0? mo
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If ((((i + mo.OFFSET) + ($size(nt) / 8)) > |$mem(0).DATA|) and n_u0? is not defined), then:
  a. Trap.
6. If n_u0? is not defined, then:
  a. Let b* be $ntbytes(nt, c).
  b. Perform $with_mem(0, (i + mo.OFFSET), ($size(nt) / 8), b*).
7. Else:
  a. Let ?(n) be n_u0?.
  b. If (((i + mo.OFFSET) + (n / 8)) > |$mem(0).DATA|), then:
    1) Trap.
  c. Let b* be $ibytes(n, $wrap($size(nt), n, c)).
  d. Perform $with_mem(0, (i + mo.OFFSET), (n / 8), b*).

execution_of_MEMORY.GROW
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Either:
  a. Let mi be $growmemory($mem(0), n).
  b. Push (I32.CONST (|$mem(0).DATA| / (64 · $Ki()))) to the stack.
  c. Perform $with_meminst(0, mi).
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
6. If (a < |$funcinst()|), then:
  a. Let fi be $funcinst()[a].
  b. Assert: Due to validation, fi.CODE is of the case FUNC.
  c. Let (FUNC y_0 y_1 instr*) be fi.CODE.
  d. Let (LOCAL t)* be y_1.
  e. Assert: Due to validation, $expanddt(fi.TYPE) is of the case FUNC.
  f. Let (FUNC y_0) be $expanddt(fi.TYPE).
  g. Let (t_1^n -> t_2^m) be y_0.
  h. Assert: Due to validation, there are at least n values on the top of the stack.
  i. Pop val^n from the stack.
  j. Let f be { LOCAL: ?(val)^n ++ $default(t)*; MODULE: fi.MODULE; }.
  k. Let F be the activation of f with arity m.
  l. Enter F with label [FRAME_]:
    1) Let L be the label_m{[]}.
    2) Enter L with label instr* ++ [LABEL_]:

group_bytes_by n byte*
1. Let n' be |byte*|.
2. If (n' ≥ n), then:
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
  c. If ((i + ((n · $storagesize(zt)) / 8)) > |$data(y).DATA|), then:
    1) Trap.
  d. Let nt be $unpacknumtype(zt).
  e. Let b* be $data(y).DATA[i : ((n · $storagesize(zt)) / 8)].
  f. Let gb* be $group_bytes_by(($storagesize(zt) / 8), b*).
  g. Let c^n be $inverse_of_ibytes($storagesize(zt), gb)*.
  h. Push (nt.CONST c)^n to the stack.
  i. Execute (ARRAY.NEW_FIXED x n).

== Complete.
Generating prose for Wasm 3.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
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
- The instruction is valid with type (t_1* -> t_2*).

validation_of_NOP
- The instruction is valid with type ([] -> []).

validation_of_DROP
- The instruction is valid with type ([t] -> []).

validation_of_SELECT ?([t])
- The instruction is valid with type ([t, t, I32] -> [t]).

validation_of_BLOCK bt instr*
- Under the context C with .LABEL prepended by [t_2*], instr* must be valid with type YetE (MixE ([[], [Arrow], [Star], []], TupE ([IterE (VarE "t_1", (List, ["t_1"])), IterE (VarE "x", (List, ["x"])), IterE (VarE "t_2", (List, ["t_2"]))]))).
- Under the context C, bt must be valid with type (t_1* -> t_2*).
- The instruction is valid with type (t_1* -> t_2*).

validation_of_LOOP bt instr*
- Under the context C with .LABEL prepended by [t_1*], instr* must be valid with type YetE (MixE ([[], [Arrow], [Star], []], TupE ([IterE (VarE "t_1", (List, ["t_1"])), IterE (VarE "x", (List, ["x"])), IterE (VarE "t_2", (List, ["t_2"]))]))).
- Under the context C, bt must be valid with type (t_1* -> t_2*).
- The instruction is valid with type (t_1* -> t_2*).

validation_of_IF bt instr_1* instr_2*
- Under the context C with .LABEL prepended by [t_2*], instr_1* must be valid with type YetE (MixE ([[], [Arrow], [Star], []], TupE ([IterE (VarE "t_1", (List, ["t_1"])), IterE (VarE "x_1", (List, ["x_1"])), IterE (VarE "t_2", (List, ["t_2"]))]))).
- Under the context C, bt must be valid with type (t_1* -> t_2*).
- Under the context C with .LABEL prepended by [t_2*], instr_2* must be valid with type YetE (MixE ([[], [Arrow], [Star], []], TupE ([IterE (VarE "t_1", (List, ["t_1"])), IterE (VarE "x_2", (List, ["x_2"])), IterE (VarE "t_2", (List, ["t_2"]))]))).
- The instruction is valid with type (t_1* ++ [I32] -> t_2*).

validation_of_BR l
- |C.LABEL| must be greater than l.
- Let t* be C.LABEL[l].
- The instruction is valid with type (t_1* ++ t* -> t_2*).

validation_of_BR_IF l
- |C.LABEL| must be greater than l.
- Let t* be C.LABEL[l].
- The instruction is valid with type (t* ++ [I32] -> t*).

validation_of_BR_TABLE l* l'
- For all l in l*,
  - |C.LABEL| must be greater than l.
- |C.LABEL| must be greater than l'.
- For all l in l*,
  - Yet: TODO: prem_to_instrs 2
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type (t_1* ++ t* -> t_2*).

validation_of_BR_ON_NULL l
- |C.LABEL| must be greater than l.
- Under the context C, ht must be valid.
- Let t* be C.LABEL[l].
- The instruction is valid with type (t* ++ [(REF (NULL ?(())) ht)] -> t* ++ [(REF (NULL ?()) ht)]).

validation_of_BR_ON_NON_NULL l
- |C.LABEL| must be greater than l.
- Let t* ++ [(REF (NULL ?()) ht)] be C.LABEL[l].
- Under the context C, ht must be valid.
- The instruction is valid with type (t* ++ [(REF (NULL ?(())) ht)] -> t*).

validation_of_BR_ON_CAST l rt_1 rt_2
- |C.LABEL| must be greater than l.
- Under the context C, rt_1 must be valid.
- Under the context C, rt_2 must be valid.
- Yet: TODO: prem_to_instrs 2
- Let t* ++ [rt] be C.LABEL[l].
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type (t* ++ [rt_1] -> t* ++ [$diffrt(rt_1, rt_2)]).

validation_of_BR_ON_CAST_FAIL l rt_1 rt_2
- |C.LABEL| must be greater than l.
- Under the context C, rt_1 must be valid.
- Under the context C, rt_2 must be valid.
- Yet: TODO: prem_to_instrs 2
- Let t* ++ [rt] be C.LABEL[l].
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type (t* ++ [rt_1] -> t* ++ [rt_2]).

validation_of_RETURN
- Let ?(t*) be C.RETURN.
- The instruction is valid with type (t_1* ++ t* -> t_2*).

validation_of_CALL x
- |C.FUNC| must be greater than x.
- Let (FUNC (t_1* -> t_2*)) be $expanddt(C.FUNC[x]).
- The instruction is valid with type (t_1* -> t_2*).

validation_of_CALL_REF ?(x)
- |C.TYPE| must be greater than x.
- Let (FUNC (t_1* -> t_2*)) be $expanddt(C.TYPE[x]).
- The instruction is valid with type (t_1* ++ [(REF (NULL ?(())) $idx(x))] -> t_2*).

validation_of_CALL_INDIRECT x y
- |C.TABLE| must be greater than x.
- |C.TYPE| must be greater than y.
- Let (lim, rt) be C.TABLE[x].
- Let (FUNC (t_1* -> t_2*)) be $expanddt(C.TYPE[y]).
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type (t_1* ++ [I32] -> t_2*).

validation_of_RETURN_CALL x
- |C.FUNC| must be greater than x.
- Let (FUNC (t_1* -> t_2*)) be $expanddt(C.FUNC[x]).
- Yet: TODO: prem_to_instrs 2
- C.RETURN must be equal to ?(t'_2*).
- The instruction is valid with type (t_3* ++ t_1* -> t_4*).

validation_of_RETURN_CALL_REF ?(x)
- |C.TYPE| must be greater than x.
- Let (FUNC (t_1* -> t_2*)) be $expanddt(C.TYPE[x]).
- Yet: TODO: prem_to_instrs 2
- C.RETURN must be equal to ?(t'_2*).
- The instruction is valid with type (t_3* ++ t_1* ++ [(REF (NULL ?(())) $idx(x))] -> t_4*).

validation_of_RETURN_CALL_INDIRECT x y
- |C.TABLE| must be greater than x.
- |C.TYPE| must be greater than y.
- Let (lim, rt) be C.TABLE[x].
- Let (FUNC (t_1* -> t_2*)) be $expanddt(C.TYPE[y]).
- Yet: TODO: prem_to_instrs 2
- Yet: TODO: prem_to_instrs 2
- C.RETURN must be equal to ?(t'_2*).
- The instruction is valid with type (t_3* ++ t_1* ++ [I32] -> t_4*).

validation_of_CONST nt c_nt
- The instruction is valid with type ([] -> [nt]).

validation_of_UNOP nt unop
- The instruction is valid with type ([nt] -> [nt]).

validation_of_BINOP nt binop
- The instruction is valid with type ([nt, nt] -> [nt]).

validation_of_TESTOP nt testop
- The instruction is valid with type ([nt] -> [I32]).

validation_of_RELOP nt relop
- The instruction is valid with type ([nt, nt] -> [I32]).

validation_of_EXTEND nt n
- n must be less than or equal to $size(nt).
- The instruction is valid with type ([nt] -> [nt]).

validation_of_CVTOP nt_1 REINTERPRET nt_2 ?()
- nt_1 must be different with nt_2.
- $size(nt_1) must be equal to $size(nt_2).
- The instruction is valid with type ([nt_2] -> [nt_1]).

validation_of_CVTOP inn_1 CONVERT inn_2 sx?
- inn_1 must be different with inn_2.
- (($size(inn_1) > $size(inn_2))) and ((sx? is ?())) are equivalent.
- The instruction is valid with type ([inn_2] -> [inn_1]).

validation_of_REF.NULL ht
- Under the context C, ht must be valid.
- The instruction is valid with type ([] -> [(REF (NULL ?(())) ht)]).

validation_of_REF.FUNC x
- |C.FUNC| must be greater than x.
- Let dt be C.FUNC[x].
- The instruction is valid with type (epsilon -> [(REF (NULL ?()) dt)]).

validation_of_REF.I31
- The instruction is valid with type ([I32] -> [(REF (NULL ?()) I31)]).

validation_of_REF.IS_NULL
- The instruction is valid with type ([rt] -> [I32]).

validation_of_REF.AS_NON_NULL
- Under the context C, ht must be valid.
- The instruction is valid with type ([(REF (NULL ?(())) ht)] -> [(REF (NULL ?()) ht)]).

validation_of_REF.EQ
- The instruction is valid with type ([(REF (NULL ?(())) EQ), (REF (NULL ?(())) EQ)] -> [I32]).

validation_of_REF.TEST rt
- Under the context C, rt must be valid.
- Yet: TODO: prem_to_instrs 2
- Under the context C, rt' must be valid.
- The instruction is valid with type ([rt'] -> [I32]).

validation_of_REF.CAST rt
- Under the context C, rt must be valid.
- Yet: TODO: prem_to_instrs 2
- Under the context C, rt' must be valid.
- The instruction is valid with type ([rt'] -> [rt]).

validation_of_I31.GET sx
- The instruction is valid with type ([(REF (NULL ?(())) I31)] -> [I32]).

validation_of_VVCONST V128 c_vt
- The instruction is valid with type ([] -> [V128]).

validation_of_VVUNOP vt vvunop
- The instruction is valid with type ([V128] -> [V128]).

validation_of_VVBINOP vt vvbinop
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_VVTERNOP vt vvternop
- The instruction is valid with type ([V128, V128, V128] -> [V128]).

validation_of_VVTESTOP vt vvtestop
- The instruction is valid with type ([V128] -> [I32]).

validation_of_SWIZZLE sh
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_SHUFFLE sh laneidx*
- For all laneidx in laneidx*,
  - laneidx must be less than ($dim(sh) · 2).
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_SPLAT sh
- The instruction is valid with type ([$unpacked(sh)] -> [V128]).

validation_of_EXTRACT_LANE sh sx? laneidx
- laneidx must be less than $dim(sh).
- The instruction is valid with type ([V128] -> [$unpacked(sh)]).

validation_of_REPLACE_LANE sh laneidx
- laneidx must be less than $dim(sh).
- The instruction is valid with type ([V128, $unpacked(sh)] -> [V128]).

validation_of_VUNOP sh vunop
- The instruction is valid with type ([V128] -> [V128]).

validation_of_VBINOP sh vbinop
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_VRELOP sh vrelop
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_VISHIFTOP sh vishiftop
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_ALL_TRUE sh
- The instruction is valid with type ([V128] -> [I32]).

validation_of_VCVTOP sh vcvtop hf? sh sx? zero
- The instruction is valid with type ([V128] -> [V128]).

validation_of_NARROW sh sh sx
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_BITMASK sh
- The instruction is valid with type ([V128] -> [I32]).

validation_of_DOT sh sh sx
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_EXTMUL sh half sh sx
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_EXTADD_PAIRWISE sh sh sx
- The instruction is valid with type ([V128] -> [V128]).

validation_of_STRUCT.NEW x
- |C.TYPE| must be greater than x.
- Let (STRUCT (mut, zt)*) be $expanddt(C.TYPE[x]).
- |zt*| must be equal to |mut*|.
- The instruction is valid with type ($unpacktype(zt)* -> [(REF (NULL ?()) $idx(x))]).

validation_of_STRUCT.NEW_DEFAULT x
- |C.TYPE| must be greater than x.
- Let (STRUCT (mut, zt)*) be $expanddt(C.TYPE[x]).
- |zt*| must be equal to |mut*|.
- Yet: TODO: prem_to_intrs 3
- |zt*| must be equal to |val*|.
- The instruction is valid with type ($unpacktype(zt)* -> [(REF (NULL ?()) $idx(x))]).

validation_of_STRUCT.GET sx? x i
- |C.TYPE| must be greater than x.
- Let (STRUCT yt*) be $expanddt(C.TYPE[x]).
- |yt*| must be greater than i.
- Let (mut, zt) be yt*[i].
- ((zt is $unpacktype(zt))) and ((sx? is ?())) are equivalent.
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x))] -> [$unpacktype(zt)]).

validation_of_STRUCT.SET x i
- |C.TYPE| must be greater than x.
- Let (STRUCT yt*) be $expanddt(C.TYPE[x]).
- |yt*| must be greater than i.
- Let ((MUT ?(())), zt) be yt*[i].
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x)), $unpacktype(zt)] -> []).

validation_of_ARRAY.NEW x
- |C.TYPE| must be greater than x.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPE[x]).
- The instruction is valid with type ([$unpacktype(zt), I32] -> [(REF (NULL ?()) $idx(x))]).

validation_of_ARRAY.NEW_DEFAULT x
- |C.TYPE| must be greater than x.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPE[x]).
- Let ?(val) be $default($unpacktype(zt)).
- The instruction is valid with type ([I32] -> [(REF (NULL ?()) $idx(x))]).

validation_of_ARRAY.NEW_FIXED x n
- |C.TYPE| must be greater than x.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPE[x]).
- The instruction is valid with type ([$unpacktype(zt)] -> [(REF (NULL ?()) $idx(x))]).

validation_of_ARRAY.NEW_ELEM x y
- |C.TYPE| must be greater than x.
- |C.ELEM| must be greater than y.
- Let (ARRAY (mut, rt)) be $expanddt(C.TYPE[x]).
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type ([I32, I32] -> [(REF (NULL ?()) $idx(x))]).

validation_of_ARRAY.NEW_DATA x y
- |C.TYPE| must be greater than x.
- |C.DATA| must be greater than y.
- C.DATA[y] must be equal to OK.
- Let (ARRAY (mut, t)) be $expanddt(C.TYPE[x]).
- Let numtype be t.
- The instruction is valid with type ([I32, I32] -> [(REF (NULL ?()) $idx(x))]).

validation_of_ARRAY.GET sx? x
- |C.TYPE| must be greater than x.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPE[x]).
- ((zt is $unpacktype(zt))) and ((sx? is ?())) are equivalent.
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x)), I32] -> [$unpacktype(zt)]).

validation_of_ARRAY.SET x
- |C.TYPE| must be greater than x.
- Let (ARRAY ((MUT ?(())), zt)) be $expanddt(C.TYPE[x]).
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x)), I32, $unpacktype(zt)] -> []).

validation_of_ARRAY.LEN
- Let $expanddt(C.TYPE[x]) be (ARRAY ((MUT ?(())), zt)).
- |C.TYPE| must be greater than x.
- The instruction is valid with type ([(REF (NULL ?(())) ARRAY)] -> [I32]).

validation_of_ARRAY.FILL x
- |C.TYPE| must be greater than x.
- Let (ARRAY ((MUT ?(())), zt)) be $expanddt(C.TYPE[x]).
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x)), I32, $unpacktype(zt), I32] -> []).

validation_of_ARRAY.COPY x_1 x_2
- |C.TYPE| must be greater than x_1.
- |C.TYPE| must be greater than x_2.
- Let (ARRAY (mut, zt_2)) be $expanddt(C.TYPE[x_2]).
- Yet: TODO: prem_to_instrs 2
- $expanddt(C.TYPE[x_1]) must be equal to (ARRAY ((MUT ?(())), zt_1)).
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x_1)), I32, (REF (NULL ?(())) $idx(x_2)), I32, I32] -> []).

validation_of_ARRAY.INIT_ELEM x y
- |C.TYPE| must be greater than x.
- |C.ELEM| must be greater than y.
- Yet: TODO: prem_to_instrs 2
- $expanddt(C.TYPE[x]) must be equal to (ARRAY ((MUT ?(())), zt)).
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x)), I32, I32, I32] -> []).

validation_of_ARRAY.INIT_DATA x y
- |C.DATA| must be greater than y.
- |C.TYPE| must be greater than x.
- C.DATA[y] must be equal to OK.
- Let numtype be t.
- $expanddt(C.TYPE[x]) must be equal to (ARRAY ((MUT ?(())), zt)).
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x)), I32, I32, I32] -> []).

validation_of_EXTERN.CONVERT_ANY
- The instruction is valid with type ([(REF nul ANY)] -> [(REF nul EXTERN)]).

validation_of_ANY.CONVERT_EXTERN
- The instruction is valid with type ([(REF nul EXTERN)] -> [(REF nul ANY)]).

validation_of_LOCAL.GET x
- |C.LOCAL| must be greater than x.
- Let (init, t) be C.LOCAL[x].
- The instruction is valid with type ([] -> [t]).

validation_of_GLOBAL.GET x
- |C.GLOBAL| must be greater than x.
- Let (mut, t) be C.GLOBAL[x].
- The instruction is valid with type ([] -> [t]).

validation_of_GLOBAL.SET x
- |C.GLOBAL| must be greater than x.
- Let ((MUT ?(())), t) be C.GLOBAL[x].
- The instruction is valid with type ([t] -> []).

validation_of_TABLE.GET x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type ([I32] -> [rt]).

validation_of_TABLE.SET x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type ([I32, rt] -> []).

validation_of_TABLE.SIZE x
- |C.TABLE| must be greater than x.
- Let tt be C.TABLE[x].
- The instruction is valid with type ([] -> [I32]).

validation_of_TABLE.GROW x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type ([rt, I32] -> [I32]).

validation_of_TABLE.FILL x
- |C.TABLE| must be greater than x.
- Let (lim, rt) be C.TABLE[x].
- The instruction is valid with type ([I32, rt, I32] -> []).

validation_of_TABLE.COPY x_1 x_2
- |C.TABLE| must be greater than x_1.
- |C.TABLE| must be greater than x_2.
- Let (lim_1, rt_1) be C.TABLE[x_1].
- Let (lim_2, rt_2) be C.TABLE[x_2].
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_TABLE.INIT x y
- |C.TABLE| must be greater than x.
- |C.ELEM| must be greater than y.
- Let rt_2 be C.ELEM[y].
- Let (lim, rt_1) be C.TABLE[x].
- Yet: TODO: prem_to_instrs 2
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_ELEM.DROP x
- |C.ELEM| must be greater than x.
- Let rt be C.ELEM[x].
- The instruction is valid with type ([] -> []).

validation_of_MEMORY.SIZE x
- |C.MEM| must be greater than x.
- Let mt be C.MEM[x].
- The instruction is valid with type ([] -> [I32]).

validation_of_MEMORY.GROW x
- |C.MEM| must be greater than x.
- Let mt be C.MEM[x].
- The instruction is valid with type ([I32] -> [I32]).

validation_of_MEMORY.FILL x
- |C.MEM| must be greater than x.
- Let mt be C.MEM[x].
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_MEMORY.COPY x_1 x_2
- |C.MEM| must be greater than x_1.
- |C.MEM| must be greater than x_2.
- Let mt_1 be C.MEM[x_1].
- Let mt_2 be C.MEM[x_2].
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_MEMORY.INIT x y
- |C.MEM| must be greater than x.
- |C.DATA| must be greater than y.
- C.DATA[y] must be equal to OK.
- Let mt be C.MEM[x].
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_DATA.DROP x
- |C.DATA| must be greater than x.
- C.DATA[x] must be equal to OK.
- The instruction is valid with type ([] -> []).

validation_of_LOAD nt (n, sx)? x { ALIGN: n_A; OFFSET: n_O; }
- |C.MEM| must be greater than x.
- ((sx? is ?())) and ((n? is ?())) are equivalent.
- (2 ^ n_A) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEM[x].
- The instruction is valid with type ([I32] -> [nt]).

validation_of_STORE nt n? x { ALIGN: n_A; OFFSET: n_O; }
- |C.MEM| must be greater than x.
- (2 ^ n_A) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ n_A) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEM[x].
- The instruction is valid with type ([I32, nt] -> []).

validation_of_VLOAD (SHAPE (PACKSHAPE psl psr) sx) x { ALIGN: n_A; OFFSET: n_O; }
- |C.MEM| must be greater than x.
- (2 ^ n_A) must be less than or equal to ((psl / 8) · psr).
- Let mt be C.MEM[x].
- The instruction is valid with type ([I32] -> [V128]).

validation_of_VLOAD_LANE n x { ALIGN: n_A; OFFSET: n_O; } laneidx
- |C.MEM| must be greater than x.
- (2 ^ n_A) must be less than (n / 8).
- laneidx must be less than (128 / n).
- Let mt be C.MEM[x].
- The instruction is valid with type ([I32, V128] -> [V128]).

validation_of_VSTORE x { ALIGN: n_A; OFFSET: n_O; }
- |C.MEM| must be greater than x.
- (2 ^ n_A) must be less than or equal to ($size(V128) / 8).
- Let mt be C.MEM[x].
- The instruction is valid with type ([I32, V128] -> []).

validation_of_VSTORE_LANE n x { ALIGN: n_A; OFFSET: n_O; } laneidx
- |C.MEM| must be greater than x.
- (2 ^ n_A) must be less than (n / 8).
- laneidx must be less than (128 / n).
- Let mt be C.MEM[x].
- The instruction is valid with type ([I32, V128] -> []).

Ki
1. Return 1024.

min n_u0 n_u1
1. If (n_u0 is 0), then:
  a. Return 0.
2. If (n_u1 is 0), then:
  a. Return 0.
3. Assert: Due to validation, (n_u0 ≥ 1).
4. Let i be (n_u0 - 1).
5. Assert: Due to validation, (n_u1 ≥ 1).
6. Let j be (n_u1 - 1).
7. Return $min(i, j).

sum n_u0*
1. If (n_u0* is []), then:
  a. Return 0.
2. Let [n] ++ n'* be n_u0*.
3. Return (n + $sum(n'*)).

signif N_u0
1. If (N_u0 is 32), then:
  a. Return 23.
2. Assert: Due to validation, (N_u0 is 64).
3. Return 52.

expon N_u0
1. If (N_u0 is 32), then:
  a. Return 8.
2. Assert: Due to validation, (N_u0 is 64).
3. Return 11.

M N
1. Return $signif(N).

E N
1. Return $expon(N).

fzero N
1. Return (POS (NORM 0 0)).

setminus1 x idx_u0*
1. If (idx_u0* is []), then:
  a. Return [x].
2. Let [y_1] ++ y* be idx_u0*.
3. If (x is y_1), then:
  a. Return [].
4. Let [y_1] ++ y* be idx_u0*.
5. Return $setminus1(x, y*).

setminus idx_u0* y*
1. If (idx_u0* is []), then:
  a. Return [].
2. Let [x_1] ++ x* be idx_u0*.
3. Return $setminus1(x_1, y*) ++ $setminus(x*, y*).

free_dataidx_instr instr_u0
1. If instr_u0 is of the case MEMORY.INIT, then:
  a. Let (MEMORY.INIT x y) be instr_u0.
  b. Return [y].
2. If instr_u0 is of the case DATA.DROP, then:
  a. Let (DATA.DROP x) be instr_u0.
  b. Return [x].
3. Return [].

free_dataidx_instrs instr_u0*
1. If (instr_u0* is []), then:
  a. Return [].
2. Let [instr] ++ instr'* be instr_u0*.
3. Return $free_dataidx_instr(instr) ++ $free_dataidx_instrs(instr'*).

free_dataidx_expr in*
1. Return $free_dataidx_instrs(in*).

free_dataidx_func (FUNC x loc* e)
1. Return $free_dataidx_expr(e).

free_dataidx_funcs func_u0*
1. If (func_u0* is []), then:
  a. Return [].
2. Let [func] ++ func'* be func_u0*.
3. Return $free_dataidx_func(func) ++ $free_dataidx_funcs(func'*).

concat_bytes byte_u0*
1. If (byte_u0* is []), then:
  a. Return [].
2. Let [b*] ++ b'** be byte_u0*.
3. Return b* ++ $concat_bytes(b'**).

size valty_u0
1. If (valty_u0 is I32), then:
  a. Return 32.
2. If (valty_u0 is I64), then:
  a. Return 64.
3. If (valty_u0 is F32), then:
  a. Return 32.
4. If (valty_u0 is F64), then:
  a. Return 64.
5. If (valty_u0 is V128), then:
  a. Return 128.

packedsize packe_u0
1. If (packe_u0 is I8), then:
  a. Return 8.
2. Assert: Due to validation, (packe_u0 is I16).
3. Return 16.

storagesize stora_u0
1. If the type of stora_u0 is valtype, then:
  a. Let valtype be stora_u0.
  b. Return $size(valtype).
2. Assert: Due to validation, the type of stora_u0 is packedtype.
3. Let packedtype be stora_u0.
4. Return $packedsize(packedtype).

unpacktype stora_u0
1. If the type of stora_u0 is valtype, then:
  a. Let valtype be stora_u0.
  b. Return valtype.
2. Assert: Due to validation, the type of stora_u0 is packedtype.
3. Return I32.

unpacknumtype stora_u0
1. If the type of stora_u0 is numtype, then:
  a. Let numtype be stora_u0.
  b. Return numtype.
2. Assert: Due to validation, the type of stora_u0 is packedtype.
3. Return I32.

sxfield stora_u0
1. If the type of stora_u0 is valtype, then:
  a. Return ?().
2. Assert: Due to validation, the type of stora_u0 is packedtype.
3. Return ?(S).

diffrt (REF nul_1 ht_1) (REF (NULL _u0?) ht_2)
1. If (_u0? is ?(())), then:
  a. Return (REF (NULL ?()) ht_1).
2. Assert: Due to validation, _u0? is not defined.
3. Return (REF nul_1 ht_1).

idx x
1. Return (_IDX x).

subst_typevar xx typev_u0* heapt_u1*
1. If ((typev_u0* is []) and (heapt_u1* is [])), then:
  a. Return xx.
2. Assert: Due to validation, (|heapt_u1*| ≥ 1).
3. Let [ht_1] ++ ht'* be heapt_u1*.
4. If (|typev_u0*| ≥ 1), then:
  a. Let [xx_1] ++ xx'* be typev_u0*.
  b. If (xx is xx_1), then:
    1) Return ht_1.
5. Let [ht_1] ++ ht'* be heapt_u1*.
6. Assert: Due to validation, (|typev_u0*| ≥ 1).
7. Let [xx_1] ++ xx'* be typev_u0*.
8. Return $subst_typevar(xx, xx'*, ht'*).

subst_numtype nt xx* ht*
1. Return nt.

subst_vectype vt xx* ht*
1. Return vt.

subst_packedtype pt xx* ht*
1. Return pt.

subst_heaptype heapt_u0 xx* ht*
1. If the type of heapt_u0 is typevar, then:
  a. Let xx' be heapt_u0.
  b. Return $subst_typevar(xx', xx*, ht*).
2. If the type of heapt_u0 is deftype, then:
  a. Let dt be heapt_u0.
  b. Return $subst_deftype(dt, xx*, ht*).
3. Let ht' be heapt_u0.
4. Return ht'.

subst_reftype (REF nul ht') xx* ht*
1. Return (REF nul $subst_heaptype(ht', xx*, ht*)).

subst_valtype valty_u0 xx* ht*
1. If the type of valty_u0 is numtype, then:
  a. Let nt be valty_u0.
  b. Return $subst_numtype(nt, xx*, ht*).
2. If the type of valty_u0 is vectype, then:
  a. Let vt be valty_u0.
  b. Return $subst_vectype(vt, xx*, ht*).
3. If the type of valty_u0 is reftype, then:
  a. Let rt be valty_u0.
  b. Return $subst_reftype(rt, xx*, ht*).
4. Assert: Due to validation, (valty_u0 is BOT).
5. Return BOT.

subst_storagetype stora_u0 xx* ht*
1. If the type of stora_u0 is valtype, then:
  a. Let t be stora_u0.
  b. Return $subst_valtype(t, xx*, ht*).
2. Assert: Due to validation, the type of stora_u0 is packedtype.
3. Let pt be stora_u0.
4. Return $subst_packedtype(pt, xx*, ht*).

subst_fieldtype (mut, zt) xx* ht*
1. Return (mut, $subst_storagetype(zt, xx*, ht*)).

subst_comptype compt_u0 xx* ht*
1. If compt_u0 is of the case STRUCT, then:
  a. Let (STRUCT yt*) be compt_u0.
  b. Return (STRUCT $subst_fieldtype(yt, xx*, ht*)*).
2. If compt_u0 is of the case ARRAY, then:
  a. Let (ARRAY yt) be compt_u0.
  b. Return (ARRAY $subst_fieldtype(yt, xx*, ht*)).
3. Assert: Due to validation, compt_u0 is of the case FUNC.
4. Let (FUNC ft) be compt_u0.
5. Return (FUNC $subst_functype(ft, xx*, ht*)).

subst_subtype subty_u0 xx* ht*
1. If subty_u0 is of the case SUB, then:
  a. Let (SUB fin y* ct) be subty_u0.
  b. Return (SUBD fin $subst_heaptype((_IDX y), xx*, ht*)* $subst_comptype(ct, xx*, ht*)).
2. Assert: Due to validation, subty_u0 is of the case SUBD.
3. Let (SUBD fin ht'* ct) be subty_u0.
4. Return (SUBD fin $subst_heaptype(ht', xx*, ht*)* $subst_comptype(ct, xx*, ht*)).

subst_rectype (REC st*) xx* ht*
1. Return (REC $subst_subtype(st, xx*, ht*)*).

subst_deftype (DEF qt i) xx* ht*
1. Return (DEF $subst_rectype(qt, xx*, ht*) i).

subst_functype (t_1* -> t_2*) xx* ht*
1. Return ($subst_valtype(t_1, xx*, ht*)* -> $subst_valtype(t_2, xx*, ht*)*).

subst_globaltype (mut, t) xx* ht*
1. Return (mut, $subst_valtype(t, xx*, ht*)).

subst_tabletype (lim, rt) xx* ht*
1. Return (lim, $subst_reftype(rt, xx*, ht*)).

subst_memtype (I8 lim) xx* ht*
1. Return (I8 lim).

subst_externtype exter_u0 xx* ht*
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC dt) be exter_u0.
  b. Return (FUNC $subst_deftype(dt, xx*, ht*)).
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be exter_u0.
  b. Return (GLOBAL $subst_globaltype(gt, xx*, ht*)).
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE tt) be exter_u0.
  b. Return (TABLE $subst_tabletype(tt, xx*, ht*)).
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM mt) be exter_u0.
6. Return (MEM $subst_memtype(mt, xx*, ht*)).

subst_all_reftype rt ht^n
1. Return $subst_reftype(rt, $idx(x)^(x<n), ht^n).

subst_all_deftype dt ht^n
1. Return $subst_deftype(dt, $idx(x)^(x<n), ht^n).

subst_all_deftypes defty_u0* ht*
1. If (defty_u0* is []), then:
  a. Return [].
2. Let [dt_1] ++ dt* be defty_u0*.
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

funcsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ et* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC dt) be y_0.
  b. Return [dt] ++ $funcsxt(et*).
4. Let [externtype] ++ et* be exter_u0*.
5. Return $funcsxt(et*).

globalsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ et* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be y_0.
  b. Return [gt] ++ $globalsxt(et*).
4. Let [externtype] ++ et* be exter_u0*.
5. Return $globalsxt(et*).

tablesxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ et* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE tt) be y_0.
  b. Return [tt] ++ $tablesxt(et*).
4. Let [externtype] ++ et* be exter_u0*.
5. Return $tablesxt(et*).

memsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ et* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM mt) be y_0.
  b. Return [mt] ++ $memsxt(et*).
4. Let [externtype] ++ et* be exter_u0*.
5. Return $memsxt(et*).

memarg0
1. Return { ALIGN: 0; OFFSET: 0; }.

signed N i
1. If (0 ≤ (2 ^ (N - 1))), then:
  a. Return i.
2. Assert: Due to validation, ((2 ^ (N - 1)) ≤ i).
3. Assert: Due to validation, (i < (2 ^ N)).
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

unpacked (lanet_u0 X lns)
1. If the type of lanet_u0 is packedtype, then:
  a. Return I32.
2. Assert: Due to validation, the type of lanet_u0 is numtype.
3. Let nt be lanet_u0.
4. Return nt.

dim (lnt X lns)
1. Return lns.

halfop half_u0 i j
1. If (half_u0 is LOW), then:
  a. Return i.
2. Assert: Due to validation, (half_u0 is HIGH).
3. Return j.

ishape n_u0
1. If (n_u0 is 8), then:
  a. Return I8.
2. If (n_u0 is 16), then:
  a. Return I16.
3. If (n_u0 is 32), then:
  a. Return I32.
4. Assert: Due to validation, (n_u0 is 64).
5. Return I64.

inst_reftype mm rt
1. Let dt* be mm.TYPE.
2. Return $subst_all_reftype(rt, dt*).

default valty_u0
1. If (valty_u0 is I32), then:
  a. Return ?((I32.CONST 0)).
2. If (valty_u0 is I64), then:
  a. Return ?((I64.CONST 0)).
3. If (valty_u0 is F32), then:
  a. Return ?((F32.CONST 0)).
4. If (valty_u0 is F64), then:
  a. Return ?((F64.CONST 0)).
5. If (valty_u0 is V128), then:
  a. Return ?((VVCONST V128 0)).
6. Assert: Due to validation, valty_u0 is of the case REF.
7. Let (REF y_0 ht) be valty_u0.
8. If (y_0 is (NULL ?(()))), then:
  a. Return ?((REF.NULL ht)).
9. Assert: Due to validation, (y_0 is (NULL ?())).
10. Return ?().

packval stora_u0 val_u1
1. If the type of stora_u0 is valtype, then:
  a. Let val be val_u1.
  b. Return val.
2. Assert: Due to validation, val_u1 is of the case CONST.
3. Let (y_0.CONST i) be val_u1.
4. Assert: Due to validation, (y_0 is I32).
5. Assert: Due to validation, the type of stora_u0 is packedtype.
6. Let pt be stora_u0.
7. Return (PACK pt $wrap(32, $packedsize(pt), i)).

unpackval stora_u0 sx_u1? field_u2
1. If sx_u1? is not defined, then:
  a. Assert: Due to validation, the type of stora_u0 is valtype.
  b. Assert: Due to validation, the type of field_u2 is val.
  c. Let val be field_u2.
  d. Return val.
2. Else:
  a. Let ?(sx) be sx_u1?.
  b. Assert: Due to validation, field_u2 is of the case PACK.
  c. Let (PACK pt i) be field_u2.
  d. Assert: Due to validation, (stora_u0 is pt).
  e. Return (I32.CONST $ext($packedsize(pt), 32, sx, i)).

funcsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $funcsxv(xv*).

globalsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globalsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $globalsxv(xv*).

tablesxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tablesxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $tablesxv(xv*).

memsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $memsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $memsxv(xv*).

store
1. Return.

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
3. If (i' ≤ j), then:
  a. Let ti' be { TYPE: ((i', j), rt); ELEM: r'* ++ r^n; }.
  b. Return ti'.

growmemory mi n
1. Let { TYPE: (I8 (i, j)); DATA: b*; } be mi.
2. Let i' be ((|b*| / (64 · $Ki())) + n).
3. If (i' ≤ j), then:
  a. Let mi' be { TYPE: (I8 (i', j)); DATA: b* ++ 0^((n · 64) · $Ki()); }.
  b. Return mi'.

with_locals C local_u0* local_u1*
1. If ((local_u0* is []) and (local_u1* is [])), then:
  a. Return C.
2. Assert: Due to validation, (|local_u1*| ≥ 1).
3. Let [lt_1] ++ lt* be local_u1*.
4. Assert: Due to validation, (|local_u0*| ≥ 1).
5. Let [x_1] ++ x* be local_u0*.
6. Return $with_locals(C with .LOCAL[x_1] replaced by lt_1, x*, lt*).

clostypes defty_u0*
1. If (defty_u0* is []), then:
  a. Return [].
2. Let dt* ++ [dt_N] be defty_u0*.
3. Let dt'* be $clostypes(dt*).
4. Return dt'* ++ [$subst_all_deftype(dt_N, dt'*)].

clostype C dt
1. Let dt'* be $clostypes(C.TYPE).
2. Return $subst_all_deftype(dt, dt'*).

before heapt_u0 x i
1. If the type of heapt_u0 is deftype, then:
  a. Return true.
2. If heapt_u0 is of the case _IDX, then:
  a. Let (_IDX typeidx) be heapt_u0.
  b. Return (typeidx < x).
3. Assert: Due to validation, heapt_u0 is of the case REC.
4. Let (REC j) be heapt_u0.
5. Return (j < i).

unrollht C heapt_u0
1. If the type of heapt_u0 is deftype, then:
  a. Let deftype be heapt_u0.
  b. Return $unrolldt(deftype).
2. If heapt_u0 is of the case _IDX, then:
  a. Let (_IDX typeidx) be heapt_u0.
  b. Return $unrolldt(C.TYPE[typeidx]).
3. Assert: Due to validation, heapt_u0 is of the case REC.
4. Let (REC i) be heapt_u0.
5. Return C.REC[i].

in_binop binop ibino_u0*
1. Return false.
2. Assert: Due to validation, (|ibino_u0*| ≥ 1).
3. Let [ibinop_1] ++ ibinop'* be ibino_u0*.
4. Return ((binop is (_I ibinop_1)) or $in_binop(binop, ibinop'*)).

in_numtype nt numty_u0*
1. Return false.
2. Assert: Due to validation, (|numty_u0*| ≥ 1).
3. Let [nt_1] ++ nt'* be numty_u0*.
4. Return ((nt is nt_1) or $in_numtype(nt, nt'*)).

blocktype block_u1
1. If (block_u1 is (_RESULT ?())), then:
  a. Return ([] -> []).
2. If block_u1 is of the case _RESULT, then:
  a. Let (_RESULT y_0) be block_u1.
  b. If y_0 is defined, then:
    1) Let ?(t) be y_0.
    2) Return ([] -> [t]).
3. Assert: Due to validation, block_u1 is of the case _IDX.
4. Let (_IDX x) be block_u1.
5. Assert: Due to validation, $expanddt($type(x)) is of the case FUNC.
6. Let (FUNC ft) be $expanddt($type(x)).
7. Return ft.

alloctypes type_u0*
1. If (type_u0* is []), then:
  a. Return [].
2. Let type'* ++ [type] be type_u0*.
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

allocfuncs mm func_u0*
1. If (func_u0* is []), then:
  a. Return [].
2. Let [func] ++ func'* be func_u0*.
3. Let fa be $allocfunc(mm, func).
4. Let fa'* be $allocfuncs(mm, func'*).
5. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let gi be { TYPE: globaltype; VALUE: val; }.
2. Let a be |s.GLOBAL|.
3. Append gi to the s.GLOBAL.
4. Return a.

allocglobals globa_u0* val_u1*
1. If (globa_u0* is []), then:
  a. Assert: Due to validation, (val_u1* is []).
  b. Return [].
2. Else:
  a. Let [globaltype] ++ globaltype'* be globa_u0*.
  b. Assert: Due to validation, (|val_u1*| ≥ 1).
  c. Let [val] ++ val'* be val_u1*.
  d. Let ga be $allocglobal(globaltype, val).
  e. Let ga'* be $allocglobals(globaltype'*, val'*).
  f. Return [ga] ++ ga'*.

alloctable ((i, j), rt) ref
1. Let ti be { TYPE: ((i, j), rt); ELEM: ref^i; }.
2. Let a be |s.TABLE|.
3. Append ti to the s.TABLE.
4. Return a.

alloctables table_u0* ref_u1*
1. If ((table_u0* is []) and (ref_u1* is [])), then:
  a. Return [].
2. Assert: Due to validation, (|ref_u1*| ≥ 1).
3. Let [ref] ++ ref'* be ref_u1*.
4. Assert: Due to validation, (|table_u0*| ≥ 1).
5. Let [tabletype] ++ tabletype'* be table_u0*.
6. Let ta be $alloctable(tabletype, ref).
7. Let ta'* be $alloctables(tabletype'*, ref'*).
8. Return [ta] ++ ta'*.

allocmem (I8 (i, j))
1. Let mi be { TYPE: (I8 (i, j)); DATA: 0^((i · 64) · $Ki()); }.
2. Let a be |s.MEM|.
3. Append mi to the s.MEM.
4. Return a.

allocmems memty_u0*
1. If (memty_u0* is []), then:
  a. Return [].
2. Let [memtype] ++ memtype'* be memty_u0*.
3. Let ma be $allocmem(memtype).
4. Let ma'* be $allocmems(memtype'*).
5. Return [ma] ++ ma'*.

allocelem rt ref*
1. Let ei be { TYPE: rt; ELEM: ref*; }.
2. Let a be |s.ELEM|.
3. Append ei to the s.ELEM.
4. Return a.

allocelems refty_u0* ref_u1*
1. If ((refty_u0* is []) and (ref_u1* is [])), then:
  a. Return [].
2. Assert: Due to validation, (|ref_u1*| ≥ 1).
3. Let [ref*] ++ ref'** be ref_u1*.
4. Assert: Due to validation, (|refty_u0*| ≥ 1).
5. Let [rt] ++ rt'* be refty_u0*.
6. Let ea be $allocelem(rt, ref*).
7. Let ea'* be $allocelems(rt'*, ref'**).
8. Return [ea] ++ ea'*.

allocdata byte*
1. Let di be { DATA: byte*; }.
2. Let a be |s.DATA|.
3. Append di to the s.DATA.
4. Return a.

allocdatas byte_u0*
1. If (byte_u0* is []), then:
  a. Return [].
2. Let [byte*] ++ byte'** be byte_u0*.
3. Let da be $allocdata(byte*).
4. Let da'* be $allocdatas(byte'**).
5. Return [da] ++ da'*.

instexport fa* ga* ta* ma* (EXPORT name exter_u0)
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC x) be exter_u0.
  b. Return { NAME: name; VALUE: (FUNC fa*[x]); }.
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be exter_u0.
  b. Return { NAME: name; VALUE: (GLOBAL ga*[x]); }.
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE x) be exter_u0.
  b. Return { NAME: name; VALUE: (TABLE ta*[x]); }.
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM x) be exter_u0.
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
22. Assert: Due to validation, (y_0 is fa*).
23. Let y_0 be $allocglobals(globaltype^n_g, val_g*).
24. Assert: Due to validation, (y_0 is ga*).
25. Let y_0 be $alloctables(tabletype^n_t, ref_t*).
26. Assert: Due to validation, (y_0 is ta*).
27. Let y_0 be $allocmems(memtype^n_m).
28. Assert: Due to validation, (y_0 is ma*).
29. Let y_0 be $allocelems(reftype^n_e, ref_e**).
30. Assert: Due to validation, (y_0 is ea*).
31. Let y_0 be $allocdatas(byte*^n_d).
32. Assert: Due to validation, (y_0 is da*).
33. Return mm.

concat_instr instr_u0*
1. If (instr_u0* is []), then:
  a. Return [].
2. Let [instr*] ++ instr'** be instr_u0*.
3. Return instr* ++ $concat_instr(instr'**).

runelem (ELEM reftype expr* elemm_u0) y
1. If (elemm_u0 is PASSIVE), then:
  a. Return [].
2. If (elemm_u0 is DECLARE), then:
  a. Return [(ELEM.DROP y)].
3. Assert: Due to validation, elemm_u0 is of the case ACTIVE.
4. Let (ACTIVE x instr*) be elemm_u0.
5. Return instr* ++ [(I32.CONST 0), (I32.CONST |expr*|), (TABLE.INIT x y), (ELEM.DROP y)].

rundata (DATA byte* datam_u0) y
1. If (datam_u0 is PASSIVE), then:
  a. Return [].
2. Assert: Due to validation, datam_u0 is of the case ACTIVE.
3. Let (ACTIVE x instr*) be datam_u0.
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
4. Let (t_1^n -> t_2*) be y_0.
5. Assert: Due to validation, $funcinst()[fa].CODE is of the case FUNC.
6. Let k be |t_2*|.
7. Enter the activation of f with arity k with label [FRAME_]:
  a. Push val^n to the stack.
  b. Push (REF.FUNC_ADDR fa) to the stack.
  c. Execute (CALL_REF ?(0)).
8. Pop val^k from the stack.
9. Return val^k.

utf8 name_u0
1. If (|name_u0| is 1), then:
  a. Let [c] be name_u0.
  b. If (c < 128), then:
    1) Let b be c.
    2) Return [b].
  c. If ((128 ≤ c) and ((c < 2048) and (c ≥ (b_2 - 128)))), then:
    1) Let ((2 ^ 6) · (b_1 - 192)) be (c - (b_2 - 128)).
    2) Return [b_1, b_2].
  d. If ((((2048 ≤ c) and (c < 55296)) or ((57344 ≤ c) and (c < 65536))) and (c ≥ (b_3 - 128))), then:
    1) Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · (b_2 - 128))) be (c - (b_3 - 128)).
    2) Return [b_1, b_2, b_3].
  e. If ((65536 ≤ c) and ((c < 69632) and (c ≥ (b_4 - 128)))), then:
    1) Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · (b_2 - 128))) + ((2 ^ 6) · (b_3 - 128))) be (c - (b_4 - 128)).
    2) Return [b_1, b_2, b_3, b_4].
2. Let c* be name_u0.
3. Return $concat_bytes($utf8([c])*).

concat_locals local_u0*
1. If (local_u0* is []), then:
  a. Return [].
2. Let [loc*] ++ loc'** be local_u0*.
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
7. If (c is not 0), then:
  a. Push val_1 to the stack.
8. Else:
  a. Push val_2 to the stack.

execution_of_IF bt instr_1* instr_2*
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute (BLOCK bt instr_1*).
4. Else:
  a. Execute (BLOCK bt instr_2*).

execution_of_LABEL_
1. Pop all values val* from the stack.
2. Assert: Due to validation, a label is now on the top of the stack.
3. Exit current context.
4. Push val* to the stack.

execution_of_BR label_u0
1. Let L be the current label.
2. Let n be the arity of L.
3. Let instr'* be the continuation of L.
4. Pop all values admin_u1* from the stack.
5. Exit current context.
6. If ((label_u0 is 0) and (|admin_u1*| ≥ n)), then:
  a. Let val'* ++ val^n be admin_u1*.
  b. Push val^n to the stack.
  c. Execute the sequence (instr'*).
7. If (label_u0 ≥ 1), then:
  a. Let l be (label_u0 - 1).
  b. Let val* be admin_u1*.
  c. Push val* to the stack.
  d. Execute (BR l).

execution_of_BR_IF l
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute (BR l).
4. Else:
  a. Do nothing.

execution_of_BR_TABLE l* l'
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If (i < |l*|), then:
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
3. If (|$unop(unop, nt, c_1)| is 1), then:
  a. Let [c] be $unop(unop, nt, c_1).
  b. Push (nt.CONST c) to the stack.
4. If ($unop(unop, nt, c_1) is []), then:
  a. Trap.

execution_of_BINOP nt binop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop (nt.CONST c_1) from the stack.
5. If (|$binop(binop, nt, c_1, c_2)| is 1), then:
  a. Let [c] be $binop(binop, nt, c_1, c_2).
  b. Push (nt.CONST c) to the stack.
6. If ($binop(binop, nt, c_1, c_2) is []), then:
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
3. If (|$cvtop(cvtop, nt_1, nt_2, sx?, c_1)| is 1), then:
  a. Let [c] be $cvtop(cvtop, nt_1, nt_2, sx?, c_1).
  b. Push (nt_2.CONST c) to the stack.
4. If ($cvtop(cvtop, nt_1, nt_2, sx?, c_1) is []), then:
  a. Trap.

execution_of_VVUNOP V128 vvunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_1) from the stack.
3. Let cv be $vvunop(vvunop, V128, cv_1).
4. Push (VVCONST V128 cv) to the stack.

execution_of_VVBINOP V128 vvbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop (VVCONST V128 cv_1) from the stack.
5. Let cv be $vvbinop(vvbinop, V128, cv_1, cv_2).
6. Push (VVCONST V128 cv) to the stack.

execution_of_VVTERNOP V128 vvternop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_3) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop (VVCONST V128 cv_2) from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop (VVCONST V128 cv_1) from the stack.
7. Let cv be $vvternop(vvternop, V128, cv_1, cv_2, cv_3).
8. Push (VVCONST V128 cv) to the stack.

execution_of_VVTESTOP V128 (_VV ANY_TRUE)
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_1) from the stack.
3. Let i be $ine(128, cv_1, $vzero()).
4. Push (I32.CONST i) to the stack.

execution_of_SWIZZLE sh
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop (VVCONST V128 cv_1) from the stack.
5. Let i* be $lanes(sh, cv_2).
6. Let (lnt X lns) be sh.
7. Assert: Due to validation, (k < |i*|)^(k<lns).
8. Let c* be $lanes(sh, cv_1) ++ 0^(256 - lns).
9. Assert: Due to validation, (i*[k] < |c*|)^(k<lns).
10. Let cv' be $inverse_of_lanes(sh, c*[i*[k]]^(k<lns)).
11. Push (VVCONST V128 cv') to the stack.

execution_of_SHUFFLE sh laneidx*
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop (VVCONST V128 cv_1) from the stack.
5. Let i* be $lanes(sh, cv_1) ++ $lanes(sh, cv_2).
6. Let (lnt X lns) be sh.
7. Assert: Due to validation, (laneidx*[k] < |i*|)^(k<lns).
8. Assert: Due to validation, (k < |laneidx*|)^(k<lns).
9. Let cv be $inverse_of_lanes(sh, i*[laneidx*[k]]^(k<lns)).
10. Push (VVCONST V128 cv) to the stack.

execution_of_SPLAT sh
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_1) from the stack.
3. Assert: Due to validation, (nt is $unpacked(sh)).
4. Let cv be $inverse_of_lanes(sh, c_1^$dim(sh)).
5. Push (VVCONST V128 cv) to the stack.

execution_of_EXTRACT_LANE sh sx_u0? laneidx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_1) from the stack.
3. Assert: Due to validation, (laneidx < |$lanes(sh, cv_1)|).
4. If sx_u0? is not defined, then:
  a. Let nt be $unpacked(sh).
  b. Let (lnt X lns) be sh.
  c. Let c_2 be $ext($storagesize(lnt), $storagesize(nt), U, $lanes(sh, cv_1)[laneidx]).
  d. Push (nt.CONST c_2) to the stack.
5. Let nt be $unpacked(sh).
6. Let (lnt X lns) be sh.
7. If sx_u0? is defined, then:
  a. Let ?(sx) be sx_u0?.
  b. Let c_2 be $ext($storagesize(lnt), $storagesize(nt), sx, $lanes(sh, cv_1)[laneidx]).
  c. Push (nt.CONST c_2) to the stack.

execution_of_REPLACE_LANE sh laneidx
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop (VVCONST V128 cv_1) from the stack.
5. Let i* be $lanes(sh, cv_1).
6. Let cv be $inverse_of_lanes(sh, i* with [laneidx] replaced by c_2).
7. Push (VVCONST V128 cv) to the stack.

execution_of_VUNOP sh vunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_1) from the stack.
3. Let cv be $vunop(vunop, sh, cv_1).
4. Push (VVCONST V128 cv) to the stack.

execution_of_VBINOP sh vbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop (VVCONST V128 cv_1) from the stack.
5. If (|$vbinop(vbinop, sh, cv_1, cv_2)| is 1), then:
  a. Let [cv] be $vbinop(vbinop, sh, cv_1, cv_2).
  b. Push (VVCONST V128 cv) to the stack.
6. If ($vbinop(vbinop, sh, cv_1, cv_2) is []), then:
  a. Trap.

execution_of_VRELOP sh vrelop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop (VVCONST V128 cv_1) from the stack.
5. Let i* be $lanes(sh, cv_1).
6. Let j* be $lanes(sh, cv_2).
7. Let (lnt X lns) be sh.
8. Assert: Due to validation, (|i*| is |j*|).
9. Let cv be $inverse_of_lanes(sh, $ext(1, $storagesize(lnt), S, $vrelop(vrelop, sh, i, j))*).
10. Push (VVCONST V128 cv) to the stack.

execution_of_VISHIFTOP sh vishiftop
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop (VVCONST V128 cv_1) from the stack.
5. Let i* be $lanes(sh, cv_1).
6. Let (lnt X lns) be sh.
7. Let cv be $inverse_of_lanes(sh, $vishiftop(vishiftop, lnt, i, n)*).
8. Push (VVCONST V128 cv) to the stack.

execution_of_ALL_TRUE sh
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv) from the stack.
3. Let i_1* be $lanes(sh, cv).
4. If (i_1 is not 0)*, then:
  a. Push (I32.CONST 1) to the stack.
5. Else:
  a. Push (I32.CONST 0) to the stack.

execution_of_BITMASK sh
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv) from the stack.
3. Let i_1^lns be $lanes(sh, cv).
4. Let (lnt X y_0) be sh.
5. Assert: Due to validation, (y_0 is lns).
6. Let i be $inverse_of_ibits(32, $ilt(S, $storagesize(lnt), i_1, 0)^lns).
7. Push (I32.CONST i) to the stack.

execution_of_NARROW sh_2 sh_1 sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop (VVCONST V128 cv_1) from the stack.
5. Let (lnt_2 X lns_2) be sh_2.
6. Let i_1^lns_1 be $lanes(sh_1, cv_1).
7. Let i_2^lns_1 be $lanes(sh_1, cv_2).
8. Let (lnt_1 X y_0) be sh_1.
9. Assert: Due to validation, (y_0 is lns_1).
10. Let n_1^lns_1 be $narrow($storagesize(lnt_1), $storagesize(lnt_2), sx, i_1)^lns_1.
11. Let n_2^lns_1 be $narrow($storagesize(lnt_1), $storagesize(lnt_2), sx, i_2)^lns_1.
12. Let cv be $inverse_of_lanes(sh_2, n_1^lns_1 ++ n_2^lns_1).
13. Push (VVCONST V128 cv) to the stack.

execution_of_VCVTOP sh_2 vcvtop half_u0? sh_1 sx_u1? (ZERO _u2?)
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_1) from the stack.
3. If (half_u0? is not defined and _u2? is not defined), then:
  a. Let i* be $lanes(sh_1, cv_1).
  b. Let (lnt_1 X lns_1) be sh_1.
  c. Let (lnt_2 X lns_2) be sh_2.
  d. If sx_u1? is defined, then:
    1) Let ?(sx) be sx_u1?.
    2) Let cv be $inverse_of_lanes(sh_2, $vcvtop(vcvtop, $storagesize(lnt_1), $storagesize(lnt_2), ?(sx), i)*).
    3) Push (VVCONST V128 cv) to the stack.
4. If _u2? is not defined, then:
  a. Let (lnt_1 X lns_1) be sh_1.
  b. Let (lnt_2 X lns_2) be sh_2.
  c. If half_u0? is defined, then:
    1) Let ?(hf) be half_u0?.
    2) Let sx? be sx_u1?.
    3) Let i* be $lanes(sh_1, cv_1)[$halfop(hf, 0, lns_2) : lns_2].
    4) Let cv be $inverse_of_lanes(sh_2, $vcvtop(vcvtop, $storagesize(lnt_1), $storagesize(lnt_2), sx?, i)*).
    5) Push (VVCONST V128 cv) to the stack.
5. If (half_u0? is not defined and (_u2? is ?(()))), then:
  a. Let i* be $lanes(sh_1, cv_1).
  b. Let (lnt_1 X lns_1) be sh_1.
  c. Let (lnt_2 X lns_2) be sh_2.
  d. Let sx? be sx_u1?.
  e. Let cv be $inverse_of_lanes(sh_2, $vcvtop(vcvtop, $storagesize(lnt_1), $storagesize(lnt_2), sx?, i)* ++ 0^lns_1).
  f. Push (VVCONST V128 cv) to the stack.

execution_of_DOT sh_1 sh_2 S
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop (VVCONST V128 cv_1) from the stack.
5. Let k_1^k' be $lanes(sh_2, cv_1).
6. Let (lnt_1 X lns_1) be sh_1.
7. Let (lnt_2 X lns_2) be sh_2.
8. Let i_1 be $storagesize(lnt_1).
9. Let i_2 be $storagesize(lnt_2).
10. Let k_2^k' be $lanes(sh_2, cv_2).
11. Let [j_1, j_2]* be $inverse_of_concat_bytes($imul(i_1, $ext(i_2, i_1, S, k_1), $ext(i_2, i_1, S, k_2))^k').
12. Assert: Due to validation, (|j_1*| is |j_2*|).
13. Let j'* be $iadd(i_1, j_1, j_2)*.
14. Let cv be $inverse_of_lanes(sh_1, j'*).
15. Push (VVCONST V128 cv) to the stack.

execution_of_EXTMUL sh_2 hf sh_1 sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop (VVCONST V128 cv_1) from the stack.
5. Let (lnt_1 X lns_1) be sh_1.
6. Let (lnt_2 X lns_2) be sh_2.
7. Let i^k be $lanes(sh_1, cv_1)[$halfop(hf, 0, lns_2) : lns_2].
8. Let j^k be $lanes(sh_1, cv_2)[$halfop(hf, 0, lns_2) : lns_2].
9. Let cv be $inverse_of_lanes(sh_2, $imul($storagesize(lnt_2), $ext($storagesize(lnt_1), $storagesize(lnt_2), sx, i), $ext($storagesize(lnt_1), $storagesize(lnt_2), sx, j))^k).
10. Push (VVCONST V128 cv) to the stack.

execution_of_EXTADD_PAIRWISE sh_2 sh_1 sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_1) from the stack.
3. Let i^k be $lanes(sh_1, cv_1).
4. Let (lnt_1 X lns_1) be sh_1.
5. Let (lnt_2 X lns_2) be sh_2.
6. Let [i_1, i_2]* be $inverse_of_concat_bytes($ext($storagesize(lnt_1), $storagesize(lnt_2), sx, i)^k).
7. Assert: Due to validation, (|i_1*| is |i_2*|).
8. Let j* be $iadd($storagesize(lnt_2), i_1, i_2)*.
9. Let cv be $inverse_of_lanes(sh_2, j*).
10. Push (VVCONST V128 cv) to the stack.

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
5. If (ref_1 is of the case REF.NULL and ref_2 is of the case REF.NULL), then:
  a. Push (I32.CONST 1) to the stack.
6. Else if (ref_1 is ref_2), then:
  a. Push (I32.CONST 1) to the stack.
7. Else:
  a. Push (I32.CONST 0) to the stack.

execution_of_I31.GET sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop admin_u0 from the stack.
3. If admin_u0 is of the case REF.NULL, then:
  a. Trap.
4. If admin_u0 is of the case REF.I31_NUM, then:
  a. Let (REF.I31_NUM i) be admin_u0.
  b. Push (I32.CONST $ext(31, 32, sx, i)) to the stack.

execution_of_EXTERN.CONVERT_ANY
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop admin_u0 from the stack.
3. If admin_u0 is of the case REF.NULL, then:
  a. Push (REF.NULL EXTERN) to the stack.
4. If the type of admin_u0 is addrref, then:
  a. Let addrref be admin_u0.
  b. Push (REF.EXTERN addrref) to the stack.

execution_of_ANY.CONVERT_EXTERN
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop admin_u0 from the stack.
3. If admin_u0 is of the case REF.NULL, then:
  a. Push (REF.NULL ANY) to the stack.
4. If admin_u0 is of the case REF.EXTERN, then:
  a. Let (REF.EXTERN addrref) be admin_u0.
  b. Push addrref to the stack.

execution_of_LOCAL.TEE x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Push val to the stack.
4. Push val to the stack.
5. Execute (LOCAL.SET x).

execution_of_BLOCK bt instr*
1. Let (t_1^k -> t_2^n) be $blocktype(bt).
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. Let L be the label_n{[]}.
5. Enter L with label instr* ++ [LABEL_]:
  a. Push val^k to the stack.

execution_of_LOOP bt instr*
1. Let (t_1^k -> t_2^n) be $blocktype(bt).
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
1. Assert: Due to validation, (x < |$funcaddr()|).
2. Push (REF.FUNC_ADDR $funcaddr()[x]) to the stack.
3. Execute (CALL_REF ?()).

execution_of_CALL_REF
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_RETURN_CALL x
1. Assert: Due to validation, (x < |$funcaddr()|).
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
  a. Pop admin_u0 from the stack.
  b. Pop all values admin_u1* from the stack.
  c. Exit current context.
  d. If admin_u0 is of the case REF.FUNC_ADDR, then:
    1) Let (REF.FUNC_ADDR a) be admin_u0.
    2) If (a < |$funcinst()|), then:
      a) Assert: Due to validation, $expanddt($funcinst()[a].TYPE) is of the case FUNC.
      b) Let (FUNC y_0) be $expanddt($funcinst()[a].TYPE).
      c) Let (t_1^n -> t_2^m) be y_0.
      d) If (|admin_u1*| ≥ n), then:
        1. Let val'* ++ val^n be admin_u1*.
        2. Push val^n to the stack.
        3. Push (REF.FUNC_ADDR a) to the stack.
        4. Execute (CALL_REF x?).
  e. If admin_u0 is of the case REF.NULL, then:
    1) Trap.

execution_of_REF.FUNC x
1. Assert: Due to validation, (x < |$funcaddr()|).
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
4. Assert: Due to validation, (|mut*| is |zt*|).
5. Assert: Due to validation, $default($unpacktype(zt)) is defined*.
6. Let ?(val)* be $default($unpacktype(zt))*.
7. Assert: Due to validation, (|val*| is |zt*|).
8. Push val* to the stack.
9. Execute (STRUCT.NEW x).

execution_of_STRUCT.GET sx? x i
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop admin_u0 from the stack.
3. If admin_u0 is of the case REF.NULL, then:
  a. Trap.
4. If admin_u0 is of the case REF.STRUCT_ADDR, then:
  a. Let (REF.STRUCT_ADDR a) be admin_u0.
  b. If (a < |$structinst()|), then:
    1) Let si be $structinst()[a].
    2) If (i < |si.FIELD|), then:
      a) Assert: Due to validation, $expanddt(si.TYPE) is of the case STRUCT.
      b) Let (STRUCT y_0) be $expanddt(si.TYPE).
      c) Let (mut, zt)* be y_0.
      d) If ((|mut*| is |zt*|) and (i < |zt*|)), then:
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
5. If ((i + n) > |$elem(y).ELEM|), then:
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
8. If ((i + ((n · $storagesize(zt)) / 8)) > |$data(y).DATA|), then:
  a. Trap.
9. Let $ztbytes(zt, c)^n be $inverse_of_concat_bytes($data(y).DATA[i : ((n · $storagesize(zt)) / 8)]).
10. Let nt be $unpacknumtype(zt).
11. Push (nt.CONST c)^n to the stack.
12. Execute (ARRAY.NEW_FIXED x n).

execution_of_ARRAY.GET sx? x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop admin_u0 from the stack.
5. If admin_u0 is of the case REF.NULL, then:
  a. Trap.
6. If admin_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be admin_u0.
  b. If ((a < |$arrayinst()|) and (i ≥ |$arrayinst()[a].FIELD|)), then:
    1) Trap.
  c. If ((i < |$arrayinst()[a].FIELD|) and (a < |$arrayinst()|)), then:
    1) Let fv be $arrayinst()[a].FIELD[i].
    2) Assert: Due to validation, $expanddt($arrayinst()[a].TYPE) is of the case ARRAY.
    3) Let (ARRAY y_0) be $expanddt($arrayinst()[a].TYPE).
    4) Let (mut, zt) be y_0.
    5) Push $unpackval(zt, sx?, fv) to the stack.

execution_of_ARRAY.LEN
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop admin_u0 from the stack.
3. If admin_u0 is of the case REF.NULL, then:
  a. Trap.
4. If admin_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be admin_u0.
  b. If (a < |$arrayinst()|), then:
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
8. Pop admin_u0 from the stack.
9. If admin_u0 is of the case REF.NULL, then:
  a. Trap.
10. If admin_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be admin_u0.
  b. If ((a < |$arrayinst()|) and ((i + n) > |$arrayinst()[a].FIELD|)), then:
    1) Trap.
  c. If (n is 0), then:
    1) Do nothing.
  d. Else:
    1) Let (REF.ARRAY_ADDR a) be admin_u0.
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
6. Pop admin_u1 from the stack.
7. Assert: Due to validation, a value of value type I32 is on the top of the stack.
8. Pop (I32.CONST i_1) from the stack.
9. Assert: Due to validation, a value is on the top of the stack.
10. Pop admin_u0 from the stack.
11. If (admin_u0 is of the case REF.NULL and the type of admin_u1 is ref), then:
  a. Trap.
12. If (admin_u1 is of the case REF.NULL and the type of admin_u0 is ref), then:
  a. Trap.
13. If admin_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a_1) be admin_u0.
  b. If admin_u1 is of the case REF.ARRAY_ADDR, then:
    1) If ((a_1 < |$arrayinst()|) and ((i_1 + n) > |$arrayinst()[a_1].FIELD|)), then:
      a) Trap.
    2) Let (REF.ARRAY_ADDR a_2) be admin_u1.
    3) If ((a_2 < |$arrayinst()|) and ((i_2 + n) > |$arrayinst()[a_2].FIELD|)), then:
      a) Trap.
  c. If (n is 0), then:
    1) If admin_u1 is of the case REF.ARRAY_ADDR, then:
      a) Do nothing.
  d. Else if (i_1 > i_2), then:
    1) Assert: Due to validation, $expanddt($type(x_2)) is of the case ARRAY.
    2) Let (ARRAY y_0) be $expanddt($type(x_2)).
    3) Let (mut, zt_2) be y_0.
    4) Let (REF.ARRAY_ADDR a_1) be admin_u0.
    5) If admin_u1 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a_2) be admin_u1.
      b) Let sx? be $sxfield(zt_2).
      c) Push (REF.ARRAY_ADDR a_1) to the stack.
      d) Push (I32.CONST ((i_1 + n) - 1)) to the stack.
      e) Push (REF.ARRAY_ADDR a_2) to the stack.
      f) Push (I32.CONST ((i_2 + n) - 1)) to the stack.
      g) Execute (ARRAY.GET sx? x_2).
      h) Execute (ARRAY.SET x_1).
      i) Push (REF.ARRAY_ADDR a_1) to the stack.
      j) Push (I32.CONST i_1) to the stack.
      k) Push (REF.ARRAY_ADDR a_2) to the stack.
      l) Push (I32.CONST i_2) to the stack.
      m) Push (I32.CONST (n - 1)) to the stack.
      n) Execute (ARRAY.COPY x_1 x_2).
  e. Else:
    1) Assert: Due to validation, $expanddt($type(x_2)) is of the case ARRAY.
    2) Let (ARRAY y_0) be $expanddt($type(x_2)).
    3) Let (mut, zt_2) be y_0.
    4) Let (REF.ARRAY_ADDR a_1) be admin_u0.
    5) If admin_u1 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a_2) be admin_u1.
      b) Let sx? be $sxfield(zt_2).
      c) Push (REF.ARRAY_ADDR a_1) to the stack.
      d) Push (I32.CONST i_1) to the stack.
      e) Push (REF.ARRAY_ADDR a_2) to the stack.
      f) Push (I32.CONST i_2) to the stack.
      g) Execute (ARRAY.GET sx? x_2).
      h) Execute (ARRAY.SET x_1).
      i) Push (REF.ARRAY_ADDR a_1) to the stack.
      j) Push (I32.CONST (i_1 + 1)) to the stack.
      k) Push (REF.ARRAY_ADDR a_2) to the stack.
      l) Push (I32.CONST (i_2 + 1)) to the stack.
      m) Push (I32.CONST (n - 1)) to the stack.
      n) Execute (ARRAY.COPY x_1 x_2).

execution_of_ARRAY.INIT_ELEM x y
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST j) from the stack.
5. Assert: Due to validation, a value of value type I32 is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. Assert: Due to validation, a value is on the top of the stack.
8. Pop admin_u0 from the stack.
9. If admin_u0 is of the case REF.NULL, then:
  a. Trap.
10. If admin_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be admin_u0.
  b. If ((a < |$arrayinst()|) and ((i + n) > |$arrayinst()[a].FIELD|)), then:
    1) Trap.
11. If ((j + n) > |$elem(y).ELEM|), then:
  a. If admin_u0 is of the case REF.ARRAY_ADDR, then:
    1) Trap.
  b. If ((n is 0) and (j < |$elem(y).ELEM|)), then:
    1) Let ref be $elem(y).ELEM[j].
    2) If admin_u0 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a) be admin_u0.
      b) Push (REF.ARRAY_ADDR a) to the stack.
      c) Push (I32.CONST i) to the stack.
      d) Push ref to the stack.
      e) Execute (ARRAY.SET x).
      f) Push (REF.ARRAY_ADDR a) to the stack.
      g) Push (I32.CONST (i + 1)) to the stack.
      h) Push (I32.CONST (j + 1)) to the stack.
      i) Push (I32.CONST (n - 1)) to the stack.
      j) Execute (ARRAY.INIT_ELEM x y).
12. Else if (n is 0), then:
  a. If admin_u0 is of the case REF.ARRAY_ADDR, then:
    1) Do nothing.
13. Else:
  a. If (j < |$elem(y).ELEM|), then:
    1) Let ref be $elem(y).ELEM[j].
    2) If admin_u0 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a) be admin_u0.
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
8. Pop admin_u0 from the stack.
9. If admin_u0 is of the case REF.NULL, then:
  a. Trap.
10. If admin_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be admin_u0.
  b. If ((a < |$arrayinst()|) and ((i + n) > |$arrayinst()[a].FIELD|)), then:
    1) Trap.
11. If $expanddt($type(x)) is not of the case ARRAY, then:
  a. If ((n is 0) and admin_u0 is of the case REF.ARRAY_ADDR), then:
    1) Do nothing.
12. Else:
  a. Let (ARRAY y_0) be $expanddt($type(x)).
  b. Let (mut, zt) be y_0.
  c. If admin_u0 is of the case REF.ARRAY_ADDR, then:
    1) If ((j + ((n · $storagesize(zt)) / 8)) > |$data(y).DATA|), then:
      a) Trap.
    2) If (n is 0), then:
      a) Do nothing.
    3) Else:
      a) Let (ARRAY y_0) be $expanddt($type(x)).
      b) Let (mut, zt) be y_0.
      c) Let (REF.ARRAY_ADDR a) be admin_u0.
      d) Let nt be $unpacknumtype(zt).
      e) Let c be $inverse_of_ztbytes(zt, $data(y).DATA[j : ($storagesize(zt) / 8)]).
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
3. If (i ≥ |$table(x).ELEM|), then:
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
7. If ((i + n) > |$table(x).ELEM|), then:
  a. Trap.
8. If (n is 0), then:
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
7. If ((i + n) > |$table(y).ELEM|), then:
  a. Trap.
8. If ((j + n) > |$table(x).ELEM|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else:
  a. If (j ≤ i), then:
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
7. If ((i + n) > |$elem(y).ELEM|), then:
  a. Trap.
8. If ((j + n) > |$table(x).ELEM|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else if (i < |$elem(y).ELEM|), then:
  a. Push (I32.CONST j) to the stack.
  b. Push $elem(y).ELEM[i] to the stack.
  c. Execute (TABLE.SET x).
  d. Push (I32.CONST (j + 1)) to the stack.
  e. Push (I32.CONST (i + 1)) to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (TABLE.INIT x y).

execution_of_LOAD nt n_sx_u0? x marg
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If ((((i + marg.OFFSET) + ($size(nt) / 8)) > |$mem(x).DATA|) and n_sx_u0? is not defined), then:
  a. Trap.
4. If n_sx_u0? is not defined, then:
  a. Let c be $inverse_of_ntbytes(nt, $mem(x).DATA[(i + marg.OFFSET) : ($size(nt) / 8)]).
  b. Push (nt.CONST c) to the stack.
5. Else:
  a. Let ?(y_0) be n_sx_u0?.
  b. Let (n, sx) be y_0.
  c. If (((i + marg.OFFSET) + (n / 8)) > |$mem(x).DATA|), then:
    1) Trap.
  d. Let c be $inverse_of_ibytes(n, $mem(x).DATA[(i + marg.OFFSET) : (n / 8)]).
  e. Push (nt.CONST $ext(n, $size(nt), sx, c)) to the stack.

execution_of_VLOAD vload_u0 x marg
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If ((((i + marg.OFFSET) + ($size(V128) / 8)) > |$mem(x).DATA|) and (vload_u0 is _LOAD)), then:
  a. Trap.
4. If (vload_u0 is _LOAD), then:
  a. Let cv be $inverse_of_vtbytes(V128, $mem(x).DATA[(i + marg.OFFSET) : ($size(V128) / 8)]).
  b. Push (VVCONST V128 cv) to the stack.
5. If vload_u0 is of the case SHAPE, then:
  a. Let (SHAPE y_0 sx) be vload_u0.
  b. Assert: Due to validation, y_0 is of the case PACKSHAPE.
  c. Let (PACKSHAPE psl psr) be y_0.
  d. If (((i + marg.OFFSET) + ((psl · psr) / 8)) > |$mem(x).DATA|), then:
    1) Trap.
  e. Let m^psr be $inverse_of_ibytes(psl, $mem(x).DATA[((i + marg.OFFSET) + ((k · psl) / 8)) : (psl / 8)])^(k<psr).
  f. Let cv be $inverse_of_lanes(($ishape((psl · 2)) X psr), $ext(psl, (psl · 2), sx, m)^psr).
  g. Push (VVCONST V128 cv) to the stack.
6. If vload_u0 is of the case SPLAT, then:
  a. Let (SPLAT n) be vload_u0.
  b. If (((i + marg.OFFSET) + (n / 8)) > |$mem(x).DATA|), then:
    1) Trap.
  c. Let l be (128 / n).
  d. Let m be $inverse_of_ibytes(n, $mem(x).DATA[(i + marg.OFFSET) : (n / 8)]).
  e. Let cv be $inverse_of_lanes(($ishape(n) X l), m^l).
  f. Push (VVCONST V128 cv) to the stack.
7. If vload_u0 is of the case ZERO, then:
  a. Let (ZERO n) be vload_u0.
  b. If (((i + marg.OFFSET) + (n / 8)) > |$mem(x).DATA|), then:
    1) Trap.
  c. Let c be $inverse_of_ibytes(n, $mem(x).DATA[(i + marg.OFFSET) : (n / 8)]).
  d. Let cv be $ext(128, n, U, c).
  e. Push (VVCONST V128 cv) to the stack.

execution_of_VLOAD_LANE n x marg laneidx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv_1) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If (((i + marg.OFFSET) + (n / 8)) > |$mem(x).DATA|), then:
  a. Trap.
6. Let sh be ($ishape(n) X (128 / n)).
7. Let m be $inverse_of_ibytes(n, $mem(x).DATA[(i + marg.OFFSET) : (n / 8)]).
8. Let cv be $inverse_of_lanes(sh, $lanes(sh, cv_1) with [laneidx] replaced by m).
9. Push (VVCONST V128 cv) to the stack.

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
7. If ((i + n) > |$mem(x).DATA|), then:
  a. Trap.
8. If (n is 0), then:
  a. Do nothing.
9. Else:
  a. Push (I32.CONST i) to the stack.
  b. Push val to the stack.
  c. Execute (STORE I32 ?(8) x $memarg0()).
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
7. If ((i_1 + n) > |$mem(x_1).DATA|), then:
  a. Trap.
8. If ((i_2 + n) > |$mem(x_2).DATA|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else:
  a. If (i_1 ≤ i_2), then:
    1) Push (I32.CONST i_1) to the stack.
    2) Push (I32.CONST i_2) to the stack.
    3) Execute (LOAD I32 ?((8, U)) x_2 $memarg0()).
    4) Execute (STORE I32 ?(8) x_1 $memarg0()).
    5) Push (I32.CONST (i_1 + 1)) to the stack.
    6) Push (I32.CONST (i_2 + 1)) to the stack.
  b. Else:
    1) Push (I32.CONST ((i_1 + n) - 1)) to the stack.
    2) Push (I32.CONST ((i_2 + n) - 1)) to the stack.
    3) Execute (LOAD I32 ?((8, U)) x_2 $memarg0()).
    4) Execute (STORE I32 ?(8) x_1 $memarg0()).
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
7. If ((i + n) > |$data(y).DATA|), then:
  a. Trap.
8. If ((j + n) > |$mem(x).DATA|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else if (i < |$data(y).DATA|), then:
  a. Push (I32.CONST j) to the stack.
  b. Push (I32.CONST $data(y).DATA[i]) to the stack.
  c. Execute (STORE I32 ?(8) x $memarg0()).
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
4. Pop admin_u0 from the stack.
5. If admin_u0 is of the case REF.NULL, then:
  a. Trap.
6. If admin_u0 is of the case REF.STRUCT_ADDR, then:
  a. Let (REF.STRUCT_ADDR a) be admin_u0.
  b. If (a < |$structinst()|), then:
    1) Assert: Due to validation, $expanddt($structinst()[a].TYPE) is of the case STRUCT.
    2) Let (STRUCT y_0) be $expanddt($structinst()[a].TYPE).
    3) Let (mut, zt)* be y_0.
    4) If ((|mut*| is |zt*|) and (i < |zt*|)), then:
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
6. Pop admin_u0 from the stack.
7. If admin_u0 is of the case REF.NULL, then:
  a. Trap.
8. If admin_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be admin_u0.
  b. If (a < |$arrayinst()|), then:
    1) If (i ≥ |$arrayinst()[a].FIELD|), then:
      a) Trap.
    2) Assert: Due to validation, $expanddt($arrayinst()[a].TYPE) is of the case ARRAY.
    3) Let (ARRAY y_0) be $expanddt($arrayinst()[a].TYPE).
    4) Let (mut, zt) be y_0.
    5) Let fv be $packval(zt, val).
    6) Perform $with_array(a, i, fv).

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
5. If (i ≥ |$table(x).ELEM|), then:
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

execution_of_STORE nt n_u0? x marg
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If ((((i + marg.OFFSET) + ($size(nt) / 8)) > |$mem(x).DATA|) and n_u0? is not defined), then:
  a. Trap.
6. If n_u0? is not defined, then:
  a. Let b* be $ntbytes(nt, c).
  b. Perform $with_mem(x, (i + marg.OFFSET), ($size(nt) / 8), b*).
7. Else:
  a. Let ?(n) be n_u0?.
  b. If (((i + marg.OFFSET) + (n / 8)) > |$mem(x).DATA|), then:
    1) Trap.
  c. Let b* be $ibytes(n, $wrap($size(nt), n, c)).
  d. Perform $with_mem(x, (i + marg.OFFSET), (n / 8), b*).

execution_of_VSTORE x marg
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If (((i + marg.OFFSET) + ($size(V128) / 8)) > |$mem(x).DATA|), then:
  a. Trap.
6. Let b* be $vtbytes(V128, cv).
7. Perform $with_mem(x, (i + marg.OFFSET), ($size(V128) / 8), b*).

execution_of_VSTORE_LANE n x marg laneidx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop (VVCONST V128 cv) from the stack.
3. Assert: Due to validation, a value of value type I32 is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If (((i + marg.OFFSET) + n) > |$mem(x).DATA|), then:
  a. Trap.
6. If (laneidx < |$lanes(($ishape(n) X (128 / n)), cv)|), then:
  a. Let b* be $ibytes(n, $lanes(($ishape(n) X (128 / n)), cv)[laneidx]).
  b. Perform $with_mem(x, (i + marg.OFFSET), (n / 8), b*).

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
6. If (a < |$funcinst()|), then:
  a. Let fi be $funcinst()[a].
  b. Assert: Due to validation, fi.CODE is of the case FUNC.
  c. Let (FUNC y_0 y_1 instr*) be fi.CODE.
  d. Let (LOCAL t)* be y_1.
  e. Assert: Due to validation, $expanddt(fi.TYPE) is of the case FUNC.
  f. Let (FUNC y_0) be $expanddt(fi.TYPE).
  g. Let (t_1^n -> t_2^m) be y_0.
  h. Assert: Due to validation, there are at least n values on the top of the stack.
  i. Pop val^n from the stack.
  j. Let f be { LOCAL: ?(val)^n ++ $default(t)*; MODULE: fi.MODULE; }.
  k. Let F be the activation of f with arity m.
  l. Enter F with label [FRAME_]:
    1) Let L be the label_m{[]}.
    2) Enter L with label instr* ++ [LABEL_]:

group_bytes_by n byte*
1. Let n' be |byte*|.
2. If (n' ≥ n), then:
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
  c. If ((i + ((n · $storagesize(zt)) / 8)) > |$data(y).DATA|), then:
    1) Trap.
  d. Let nt be $unpacknumtype(zt).
  e. Let b* be $data(y).DATA[i : ((n · $storagesize(zt)) / 8)].
  f. Let gb* be $group_bytes_by(($storagesize(zt) / 8), b*).
  g. Let c^n be $inverse_of_ibytes($storagesize(zt), gb)*.
  h. Push (nt.CONST c)^n to the stack.
  i. Execute (ARRAY.NEW_FIXED x n).

== Complete.
```
