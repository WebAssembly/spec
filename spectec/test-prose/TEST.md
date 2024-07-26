# Preview

```sh
$ for v in 1 2 3; do ( \
>   echo "Generating prose for Wasm $v.0..." && \
>   cd ../spec/wasm-$v.0 && \
>   ../../src/exe-watsup/main.exe *.watsup -v -l --prose \
> ) done
Generating prose for Wasm 1.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Prose Generation...
=================
 Generated prose
=================
validation_of_valid_limits
- the limits (n, m) is valid with the nat k if and only if:
  - n is less than or equal to m.
  - m is less than or equal to k.

validation_of_valid_functype
- the function type (t_1* -> t_2?) is valid.

validation_of_valid_globaltype
- the global type ((MUT ()?), t) is valid.

validation_of_valid_tabletype
- the table type limits is valid if and only if:
  - the limits limits is valid with the nat ((2 ^ 32) - 1).

validation_of_valid_memtype
- the memory type limits is valid if and only if:
  - the limits limits is valid with the nat (2 ^ 16).

validation_of_valid_externtype
- the external type exter_u0 is valid if and only if:
  - Either:
    - exter_u0 is (FUNC functype).
    - the function type functype is valid.
  - Or:
    - exter_u0 is (GLOBAL globaltype).
    - the global type globaltype is valid.
  - Or:
    - exter_u0 is (TABLE tabletype).
    - the table type tabletype is valid.
  - Or:
    - exter_u0 is (MEM memtype).
    - the memory type memtype is valid.

validation_of_matching_limits
- the limits (n_11, n_12) matches the limits (n_21, n_22) if and only if:
  - n_11 is greater than or equal to n_21.
  - n_12 is less than or equal to n_22.

validation_of_matching_functype
- the function type ft matches the function type ft.

validation_of_matching_globaltype
- the global type gt matches the global type gt.

validation_of_matching_tabletype
- the table type lim_1 matches the table type lim_2 if and only if:
  - the limits lim_1 matches the limits lim_2.

validation_of_matching_memtype
- the memory type lim_1 matches the memory type lim_2 if and only if:
  - the limits lim_1 matches the limits lim_2.

validation_of_matching_externtype
- the external type exter_u0 matches the external type exter_u1 if and only if:
  - Either:
    - exter_u0 is (FUNC ft_1).
    - exter_u1 is (FUNC ft_2).
    - the function type ft_1 matches the function type ft_2.
  - Or:
    - exter_u0 is (GLOBAL gt_1).
    - exter_u1 is (GLOBAL gt_2).
    - the global type gt_1 matches the global type gt_2.
  - Or:
    - exter_u0 is (TABLE tt_1).
    - exter_u1 is (TABLE tt_2).
    - the table type tt_1 matches the table type tt_2.
  - Or:
    - exter_u0 is (MEM mt_1).
    - exter_u1 is (MEM mt_2).
    - the memory type mt_1 matches the memory type mt_2.

validation_of_NOP
- the instr NOP is valid with the function type ([] -> []).

validation_of_UNREACHABLE
- the instr UNREACHABLE is valid with the function type (t_1* -> t_2*).

validation_of_DROP
- the instr DROP is valid with the function type ([t] -> []).

validation_of_SELECT
- the instr SELECT is valid with the function type ([t, t, I32] -> [t]).

validation_of_BLOCK
- the instr (BLOCK t? instr*) is valid with the function type ([] -> t?) if and only if:
  - Under the context C with .LABELS prepended by [t?], the instr sequence instr* is valid with the function type ([] -> t?).

validation_of_LOOP
- the instr (LOOP t? instr*) is valid with the function type ([] -> t?) if and only if:
  - Under the context C with .LABELS prepended by [?()], the instr sequence instr* is valid with the function type ([] -> []).

validation_of_IF
- the instr (IF t? instr_1* instr_2*) is valid with the function type ([I32] -> t?) if and only if:
  - Under the context C with .LABELS prepended by [t?], the instr sequence instr_1* is valid with the function type ([] -> t?).
  - Under the context C with .LABELS prepended by [t?], the instr sequence instr_2* is valid with the function type ([] -> t?).

validation_of_BR
- the instr (BR l) is valid with the function type (t_1* ++ t? -> t_2*) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t?.

validation_of_BR_IF
- the instr (BR_IF l) is valid with the function type (t? ++ [I32] -> t?) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t?.

validation_of_BR_TABLE
- the instr (BR_TABLE l* l') is valid with the function type (t_1* ++ t? -> t_2*) if and only if:
  - |C.LABELS| is greater than l'.
  - For all l in l*,
    - |C.LABELS| is greater than l.
  - t? is C.LABELS[l'].
  - For all l in l*,
    - t? is C.LABELS[l].

validation_of_CALL
- the instr (CALL x) is valid with the function type (t_1* -> t_2?) if and only if:
  - |C.FUNCS| is greater than x.
  - C.FUNCS[x] is (t_1* -> t_2?).

validation_of_CALL_INDIRECT
- the instr (CALL_INDIRECT x) is valid with the function type (t_1* ++ [I32] -> t_2?) if and only if:
  - |C.TYPES| is greater than x.
  - C.TYPES[x] is (t_1* -> t_2?).

validation_of_RETURN
- the instr RETURN is valid with the function type (t_1* ++ t? -> t_2*) if and only if:
  - C.RETURN is ?(t?).

validation_of_CONST
- the instr (t.CONST c_t) is valid with the function type ([] -> [t]).

validation_of_UNOP
- the instr (UNOP t unop_t) is valid with the function type ([t] -> [t]).

validation_of_BINOP
- the instr (BINOP t binop_t) is valid with the function type ([t, t] -> [t]).

validation_of_TESTOP
- the instr (TESTOP t testop_t) is valid with the function type ([t] -> [I32]).

validation_of_RELOP
- the instr (RELOP t relop_t) is valid with the function type ([t, t] -> [I32]).

validation_of_CVTOP
- the instr (CVTOP nt_1 nt_2 REINTERPRET) is valid with the function type ([nt_2] -> [nt_1]) if and only if:
  - $size(nt_1) is $size(nt_2).

validation_of_LOCAL.GET
- the instr (LOCAL.GET x) is valid with the function type ([] -> [t]) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is t.

validation_of_LOCAL.SET
- the instr (LOCAL.SET x) is valid with the function type ([t] -> []) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is t.

validation_of_LOCAL.TEE
- the instr (LOCAL.TEE x) is valid with the function type ([t] -> [t]) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is t.

validation_of_GLOBAL.GET
- the instr (GLOBAL.GET x) is valid with the function type ([] -> [t]) if and only if:
  - |C.GLOBALS| is greater than x.
  - C.GLOBALS[x] is (mut, t).

validation_of_GLOBAL.SET
- the instr (GLOBAL.SET x) is valid with the function type ([t] -> []) if and only if:
  - |C.GLOBALS| is greater than x.
  - C.GLOBALS[x] is ((MUT ?(())), t).

validation_of_MEMORY.SIZE
- the instr MEMORY.SIZE is valid with the function type ([] -> [I32]) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.

validation_of_MEMORY.GROW
- the instr MEMORY.GROW is valid with the function type ([I32] -> [I32]) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.

validation_of_LOAD
- the instr (LOAD nt (n, sx)? memarg) is valid with the function type ([I32] -> [nt]) if and only if:
  - |C.MEMS| is greater than 0.
  - ((sx? is ?())) if and only if ((n? is ?())).
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(nt) / 8).
  - If n is defined,
    - (2 ^ memarg.ALIGN) is less than or equal to (n / 8).
    - (n / 8) is less than ($size(nt) / 8).
  - If n is defined,
    - nt is Inn.

validation_of_STORE
- the instr (STORE nt n? memarg) is valid with the function type ([I32, nt] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(nt) / 8).
  - If n is defined,
    - (2 ^ memarg.ALIGN) is less than or equal to (n / 8).
    - (n / 8) is less than ($size(nt) / 8).
  - If n is defined,
    - nt is Inn.

validation_of_valid_instr*
- the instr sequence instr_u0* is valid with the function type (valty_u1* -> valty_u2*) if and only if:
  - Either:
    - instr_u0* is [].
    - valty_u1* is [].
    - valty_u2* is [].
  - Or:
    - instr_u0* is [instr_1] ++ instr_2*.
    - valty_u1* is t_1*.
    - valty_u2* is t_3*.
    - the instr instr_1 is valid with the function type (t_1* -> t_2*).
    - the instr sequence [instr_2] is valid with the function type (t_2* -> t_3*).
  - Or:
    - instr_u0* is instr*.
    - valty_u1* is t* ++ t_1*.
    - valty_u2* is t* ++ t_2*.
    - the instr sequence instr* is valid with the function type (t_1* -> t_2*).

validation_of_valid_expr
- the expression instr* is valid with the result type t? if and only if:
  - the instr sequence instr* is valid with the function type ([] -> t?).

validation_of_const_instr
- the instr instr_u0 is constant if and only if:
  - Either:
    - instr_u0 is (t.CONST c).
  - Or:
    - instr_u0 is (GLOBAL.GET x).
    - |C.GLOBALS| is greater than x.
    - C.GLOBALS[x] is ((MUT ?()), t).

validation_of_const_expr
- the expression instr* is constant if and only if:
  - For all instr in instr*,
    - the instr instr is constant.

validation_of_valid_type
- the type (TYPE ft) is valid with the function type ft if and only if:
  - the function type ft is valid.

validation_of_valid_func
- the function (FUNC x (LOCAL t)* expr) is valid with the function type (t_1* -> t_2?) if and only if:
  - |C.TYPES| is greater than x.
  - C.TYPES[x] is (t_1* -> t_2?).
  - Under the context C with .LOCALS appended by t_1* ++ t* with .LABELS appended by [t_2?] with .RETURN appended by ?(t_2?), the expression expr is valid with the result type t_2?.

validation_of_valid_global
- the global (GLOBAL gt expr) is valid with the global type gt if and only if:
  - the global type gt is valid.
  - gt is (mut, t).
  - the expression expr is valid with the number type sequence ?(t).
  - the expression expr is constant.

validation_of_valid_table
- the table (TABLE tt) is valid with the table type tt if and only if:
  - the table type tt is valid.

validation_of_valid_mem
- the memory (MEMORY mt) is valid with the memory type mt if and only if:
  - the memory type mt is valid.

validation_of_valid_elem
- the table segment (ELEM expr x*) is valid if and only if:
  - |C.TABLES| is greater than 0.
  - |x*| is |ft*|.
  - For all x in x*,
    - |C.FUNCS| is greater than x.
  - C.TABLES[0] is lim.
  - the expression expr is valid with the number type sequence ?(I32).
  - the expression expr is constant.
  - For all ft in ft* and x in x*,
    - C.FUNCS[x] is ft.

validation_of_valid_data
- the memory segment (DATA expr b*) is valid if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is lim.
  - the expression expr is valid with the number type sequence ?(I32).
  - the expression expr is constant.

validation_of_valid_start
- the start function (START x) is valid if and only if:
  - |C.FUNCS| is greater than x.
  - C.FUNCS[x] is ([] -> []).

validation_of_valid_import
- the import (IMPORT name_1 name_2 xt) is valid with the external type xt if and only if:
  - the external type xt is valid.

validation_of_valid_externidx
- the external index exter_u0 is valid with the external type exter_u1 if and only if:
  - Either:
    - exter_u0 is (FUNC x).
    - exter_u1 is (FUNC ft).
    - |C.FUNCS| is greater than x.
    - C.FUNCS[x] is ft.
  - Or:
    - exter_u0 is (GLOBAL x).
    - exter_u1 is (GLOBAL gt).
    - |C.GLOBALS| is greater than x.
    - C.GLOBALS[x] is gt.
  - Or:
    - exter_u0 is (TABLE x).
    - exter_u1 is (TABLE tt).
    - |C.TABLES| is greater than x.
    - C.TABLES[x] is tt.
  - Or:
    - exter_u0 is (MEM x).
    - exter_u1 is (MEM mt).
    - |C.MEMS| is greater than x.
    - C.MEMS[x] is mt.

validation_of_valid_export
- the export (EXPORT name externidx) is valid with the external type xt if and only if:
  - the external index externidx is valid with the external type xt.

validation_of_valid_module
- the module (MODULE type* import* func* global* table* mem* elem* data* start? export*) is valid if and only if:
  - |type*| is |ft'*|.
  - |ixt*| is |import*|.
  - |gt*| is |global*|.
  - |func*| is |ft*|.
  - |tt*| is |table*|.
  - |mt*| is |mem*|.
  - |xt*| is |export*|.
  - For all ft' in ft'* and type in type*,
    - the type type is valid with the function type ft'.
  - For all import in import* and ixt in ixt*,
    - Under the context { TYPES: ft'*; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; LOCALS: []; LABELS: []; RETURN: ?(); }, the import import is valid with the external type ixt.
  - For all global in global* and gt in gt*,
    - Under the context C', the global global is valid with the global type gt.
  - For all ft in ft* and func in func*,
    - the function func is valid with the function type ft.
  - For all table in table* and tt in tt*,
    - the table table is valid with the table type tt.
  - For all mem in mem* and mt in mt*,
    - the memory mem is valid with the memory type mt.
  - For all elem in elem*,
    - the table segment elem is valid.
  - For all data in data*,
    - the memory segment data is valid.
  - If start is defined,
    - the start function start is valid.
  - For all export in export* and xt in xt*,
    - the export export is valid with the external type xt.
  - |tt*| is less than or equal to 1.
  - |mt*| is less than or equal to 1.
  - C is { TYPES: ft'*; FUNCS: ift* ++ ft*; GLOBALS: igt* ++ gt*; TABLES: itt* ++ tt*; MEMS: imt* ++ mt*; LOCALS: []; LABELS: []; RETURN: ?(); }.
  - C' is { TYPES: ft'*; FUNCS: ift* ++ ft*; GLOBALS: igt*; TABLES: []; MEMS: []; LOCALS: []; LABELS: []; RETURN: ?(); }.
  - ift* is $funcsxt(ixt*).
  - igt* is $globalsxt(ixt*).
  - itt* is $tablesxt(ixt*).
  - imt* is $memsxt(ixt*).

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

opt_ X_u0*
1. If (X_u0* is []), then:
  a. Return ?().
2. Assert: Due to validation, (|X_u0*| is 1).
3. Let [w] be X_u0*.
4. Return ?(w).

list_ X_u0?
1. If X_u0? is not defined, then:
  a. Return [].
2. Let ?(w) be X_u0?.
3. Return [w].

concat_ X_u0*
1. If (X_u0* is []), then:
  a. Return [].
2. Let [w*] ++ w'** be X_u0*.
3. Return w* ++ $concat_(w'**).

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
1. Return (POS (SUBNORM 0)).

fone N
1. Return (POS (NORM 1 0)).

canon_ N
1. Return (2 ^ ($signif(N) - 1)).

utf8 char_u0*
1. If (|char_u0*| is 1), then:
  a. Let [ch] be char_u0*.
  b. If (ch < 128), then:
    1) Let b be ch.
    2) Return [b].
  c. If ((128 ≤ ch) and ((ch < 2048) and (ch ≥ (b_2 - 128)))), then:
    1) Let ((2 ^ 6) · (b_1 - 192)) be (ch - (b_2 - 128)).
    2) Return [b_1, b_2].
  d. If ((((2048 ≤ ch) and (ch < 55296)) or ((57344 ≤ ch) and (ch < 65536))) and (ch ≥ (b_3 - 128))), then:
    1) Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · (b_2 - 128))) be (ch - (b_3 - 128)).
    2) Return [b_1, b_2, b_3].
  e. If ((65536 ≤ ch) and ((ch < 69632) and (ch ≥ (b_4 - 128)))), then:
    1) Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · (b_2 - 128))) + ((2 ^ 6) · (b_3 - 128))) be (ch - (b_4 - 128)).
    2) Return [b_1, b_2, b_3, b_4].
2. Let ch* be char_u0*.
3. Return $concat_($utf8([ch])*).

size valty_u0
1. If (valty_u0 is I32), then:
  a. Return 32.
2. If (valty_u0 is I64), then:
  a. Return 64.
3. If (valty_u0 is F32), then:
  a. Return 32.
4. If (valty_u0 is F64), then:
  a. Return 64.

funcsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externtype_0] ++ xt* be exter_u0*.
3. If externtype_0 is of the case FUNC, then:
  a. Let (FUNC ft) be externtype_0.
  b. Return [ft] ++ $funcsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $funcsxt(xt*).

globalsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externtype_0] ++ xt* be exter_u0*.
3. If externtype_0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be externtype_0.
  b. Return [gt] ++ $globalsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $globalsxt(xt*).

tablesxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externtype_0] ++ xt* be exter_u0*.
3. If externtype_0 is of the case TABLE, then:
  a. Let (TABLE tt) be externtype_0.
  b. Return [tt] ++ $tablesxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $tablesxt(xt*).

memsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externtype_0] ++ xt* be exter_u0*.
3. If externtype_0 is of the case MEM, then:
  a. Let (MEM mt) be externtype_0.
  b. Return [mt] ++ $memsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $memsxt(xt*).

memarg0
1. Return { ALIGN: 0; OFFSET: 0; }.

signed_ N i
1. If (0 ≤ (2 ^ (N - 1))), then:
  a. Return i.
2. Assert: Due to validation, ((2 ^ (N - 1)) ≤ i).
3. Assert: Due to validation, (i < (2 ^ N)).
4. Return (i - (2 ^ N)).

invsigned_ N ii
1. Let j be $signed__1^-1(N, ii).
2. Return j.

unop_ valty_u1 unop__u0 val__u3
1. If ((unop__u0 is CLZ) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN be val__u3.
  c. Return [$iclz_($size(Inn), iN)].
2. If ((unop__u0 is CTZ) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN be val__u3.
  c. Return [$ictz_($size(Inn), iN)].
3. If ((unop__u0 is POPCNT) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN be val__u3.
  c. Return [$ipopcnt_($size(Inn), iN)].
4. If ((unop__u0 is ABS) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN be val__u3.
  c. Return $fabs_($size(Fnn), fN).
5. If ((unop__u0 is NEG) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN be val__u3.
  c. Return $fneg_($size(Fnn), fN).
6. If ((unop__u0 is SQRT) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN be val__u3.
  c. Return $fsqrt_($size(Fnn), fN).
7. If ((unop__u0 is CEIL) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN be val__u3.
  c. Return $fceil_($size(Fnn), fN).
8. If ((unop__u0 is FLOOR) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN be val__u3.
  c. Return $ffloor_($size(Fnn), fN).
9. If ((unop__u0 is TRUNC) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN be val__u3.
  c. Return $ftrunc_($size(Fnn), fN).
10. Assert: Due to validation, (unop__u0 is NEAREST).
11. Assert: Due to validation, the type of valty_u1 is Fnn.
12. Let Fnn be valty_u1.
13. Let fN be val__u3.
14. Return $fnearest_($size(Fnn), fN).

binop_ valty_u1 binop_u0 val__u3 val__u5
1. If ((binop_u0 is ADD) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$iadd_($size(Inn), iN_1, iN_2)].
2. If ((binop_u0 is SUB) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$isub_($size(Inn), iN_1, iN_2)].
3. If ((binop_u0 is MUL) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$imul_($size(Inn), iN_1, iN_2)].
4. If the type of valty_u1 is Inn, then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. If binop_u0 is of the case DIV, then:
    1) Let (DIV sx) be binop_u0.
    2) Return $list_($idiv_($size(Inn), sx, iN_1, iN_2)).
  e. If binop_u0 is of the case REM, then:
    1) Let (REM sx) be binop_u0.
    2) Return $list_($irem_($size(Inn), sx, iN_1, iN_2)).
5. If ((binop_u0 is AND) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$iand_($size(Inn), iN_1, iN_2)].
6. If ((binop_u0 is OR) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$ior_($size(Inn), iN_1, iN_2)].
7. If ((binop_u0 is XOR) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$ixor_($size(Inn), iN_1, iN_2)].
8. If ((binop_u0 is SHL) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$ishl_($size(Inn), iN_1, iN_2)].
9. If the type of valty_u1 is Inn, then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. If binop_u0 is of the case SHR, then:
    1) Let (SHR sx) be binop_u0.
    2) Return [$ishr_($size(Inn), sx, iN_1, iN_2)].
10. If ((binop_u0 is ROTL) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$irotl_($size(Inn), iN_1, iN_2)].
11. If ((binop_u0 is ROTR) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$irotr_($size(Inn), iN_1, iN_2)].
12. If ((binop_u0 is ADD) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $fadd_($size(Fnn), fN_1, fN_2).
13. If ((binop_u0 is SUB) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $fsub_($size(Fnn), fN_1, fN_2).
14. If ((binop_u0 is MUL) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $fmul_($size(Fnn), fN_1, fN_2).
15. If ((binop_u0 is DIV) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $fdiv_($size(Fnn), fN_1, fN_2).
16. If ((binop_u0 is MIN) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $fmin_($size(Fnn), fN_1, fN_2).
17. If ((binop_u0 is MAX) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $fmax_($size(Fnn), fN_1, fN_2).
18. Assert: Due to validation, (binop_u0 is COPYSIGN).
19. Assert: Due to validation, the type of valty_u1 is Fnn.
20. Let Fnn be valty_u1.
21. Let fN_1 be val__u3.
22. Let fN_2 be val__u5.
23. Return $fcopysign_($size(Fnn), fN_1, fN_2).

testop_ Inn EQZ iN
1. Return $ieqz_($size(Inn), iN).

relop_ valty_u1 relop_u0 val__u3 val__u5
1. If ((relop_u0 is EQ) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return $ieq_($size(Inn), iN_1, iN_2).
2. If ((relop_u0 is NE) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return $ine_($size(Inn), iN_1, iN_2).
3. If the type of valty_u1 is Inn, then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. If relop_u0 is of the case LT, then:
    1) Let (LT sx) be relop_u0.
    2) Return $ilt_($size(Inn), sx, iN_1, iN_2).
  e. If relop_u0 is of the case GT, then:
    1) Let (GT sx) be relop_u0.
    2) Return $igt_($size(Inn), sx, iN_1, iN_2).
  f. If relop_u0 is of the case LE, then:
    1) Let (LE sx) be relop_u0.
    2) Return $ile_($size(Inn), sx, iN_1, iN_2).
  g. If relop_u0 is of the case GE, then:
    1) Let (GE sx) be relop_u0.
    2) Return $ige_($size(Inn), sx, iN_1, iN_2).
4. If ((relop_u0 is EQ) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $feq_($size(Fnn), fN_1, fN_2).
5. If ((relop_u0 is NE) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $fne_($size(Fnn), fN_1, fN_2).
6. If ((relop_u0 is LT) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $flt_($size(Fnn), fN_1, fN_2).
7. If ((relop_u0 is GT) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $fgt_($size(Fnn), fN_1, fN_2).
8. If ((relop_u0 is LE) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $fle_($size(Fnn), fN_1, fN_2).
9. Assert: Due to validation, (relop_u0 is GE).
10. Assert: Due to validation, the type of valty_u1 is Fnn.
11. Let Fnn be valty_u1.
12. Let fN_1 be val__u3.
13. Let fN_2 be val__u5.
14. Return $fge_($size(Fnn), fN_1, fN_2).

cvtop__ valty_u0 valty_u1 cvtop_u2 val__u4
1. If ((valty_u0 is I32) and (valty_u1 is I64)), then:
  a. Let iN be val__u4.
  b. If cvtop_u2 is of the case EXTEND, then:
    1) Let (EXTEND sx) be cvtop_u2.
    2) Return [$extend__(32, 64, sx, iN)].
2. If ((valty_u0 is I64) and ((valty_u1 is I32) and (cvtop_u2 is WRAP))), then:
  a. Let iN be val__u4.
  b. Return [$wrap__(64, 32, iN)].
3. If the type of valty_u0 is Fnn, then:
  a. Let Fnn be valty_u0.
  b. If the type of valty_u1 is Inn, then:
    1) Let Inn be valty_u1.
    2) Let fN be val__u4.
    3) If cvtop_u2 is of the case TRUNC, then:
      a) Let (TRUNC sx) be cvtop_u2.
      b) Return $list_($trunc__($size(Fnn), $size(Inn), sx, fN)).
4. If ((valty_u0 is F32) and ((valty_u1 is F64) and (cvtop_u2 is PROMOTE))), then:
  a. Let fN be val__u4.
  b. Return $promote__(32, 64, fN).
5. If ((valty_u0 is F64) and ((valty_u1 is F32) and (cvtop_u2 is DEMOTE))), then:
  a. Let fN be val__u4.
  b. Return $demote__(64, 32, fN).
6. If the type of valty_u1 is Fnn, then:
  a. Let Fnn be valty_u1.
  b. If the type of valty_u0 is Inn, then:
    1) Let Inn be valty_u0.
    2) Let iN be val__u4.
    3) If cvtop_u2 is of the case CONVERT, then:
      a) Let (CONVERT sx) be cvtop_u2.
      b) Return [$convert__($size(Inn), $size(Fnn), sx, iN)].
7. Assert: Due to validation, (cvtop_u2 is REINTERPRET).
8. If the type of valty_u1 is Fnn, then:
  a. Let Fnn be valty_u1.
  b. If the type of valty_u0 is Inn, then:
    1) Let Inn be valty_u0.
    2) Let iN be val__u4.
    3) If ($size(Inn) is $size(Fnn)), then:
      a) Return [$reinterpret__(Inn, Fnn, iN)].
9. Assert: Due to validation, the type of valty_u0 is Fnn.
10. Let Fnn be valty_u0.
11. Assert: Due to validation, the type of valty_u1 is Inn.
12. Let Inn be valty_u1.
13. Let fN be val__u4.
14. Assert: Due to validation, ($size(Inn) is $size(Fnn)).
15. Return [$reinterpret__(Fnn, Inn, fN)].

invibytes_ N b*
1. Let n be $ibytes__1^-1(N, b*).
2. Return n.

invfbytes_ N b*
1. Let p be $fbytes__1^-1(N, b*).
2. Return p.

default_ valty_u0
1. If (valty_u0 is I32), then:
  a. Return (I32.CONST 0).
2. If (valty_u0 is I64), then:
  a. Return (I64.CONST 0).
3. If (valty_u0 is F32), then:
  a. Return (F32.CONST $fzero(32)).
4. Assert: Due to validation, (valty_u0 is F64).
5. Return (F64.CONST $fzero(64)).

funcsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ xv* be exter_u0*.
3. If externval_0 is of the case FUNC, then:
  a. Let (FUNC fa) be externval_0.
  b. Return [fa] ++ $funcsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $funcsxv(xv*).

globalsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ xv* be exter_u0*.
3. If externval_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be externval_0.
  b. Return [ga] ++ $globalsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $globalsxv(xv*).

tablesxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ xv* be exter_u0*.
3. If externval_0 is of the case TABLE, then:
  a. Let (TABLE ta) be externval_0.
  b. Return [ta] ++ $tablesxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $tablesxv(xv*).

memsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ xv* be exter_u0*.
3. If externval_0 is of the case MEM, then:
  a. Let (MEM ma) be externval_0.
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
2. Return f.MODULE.FUNCS.

funcinst
1. Return s.FUNCS.

globalinst
1. Return s.GLOBALS.

tableinst
1. Return s.TABLES.

meminst
1. Return s.MEMS.

moduleinst
1. Let f be the current frame.
2. Return f.MODULE.

type x
1. Let f be the current frame.
2. Return f.MODULE.TYPES[x].

func x
1. Let f be the current frame.
2. Return s.FUNCS[f.MODULE.FUNCS[x]].

global x
1. Let f be the current frame.
2. Return s.GLOBALS[f.MODULE.GLOBALS[x]].

table x
1. Let f be the current frame.
2. Return s.TABLES[f.MODULE.TABLES[x]].

mem x
1. Let f be the current frame.
2. Return s.MEMS[f.MODULE.MEMS[x]].

local x
1. Let f be the current frame.
2. Return f.LOCALS[x].

with_local x v
1. Let f be the current frame.
2. Replace f.LOCALS[x] with v.

with_global x v
1. Let f be the current frame.
2. Replace s.GLOBALS[f.MODULE.GLOBALS[x]].VALUE with v.

with_table x i a
1. Let f be the current frame.
2. Replace s.TABLES[f.MODULE.TABLES[x]].REFS[i] with ?(a).

with_tableinst x ti
1. Let f be the current frame.
2. Replace s.TABLES[f.MODULE.TABLES[x]] with ti.

with_mem x i j b*
1. Let f be the current frame.
2. Replace s.MEMS[f.MODULE.MEMS[x]].BYTES[i : j] with b*.

with_meminst x mi
1. Let f be the current frame.
2. Replace s.MEMS[f.MODULE.MEMS[x]] with mi.

growtable ti n
1. Let { TYPE: (i, j); REFS: ?(a)*; } be ti.
2. Let i' be (|a*| + n).
3. If (i' ≤ j), then:
  a. Let ti' be { TYPE: (i', j); REFS: ?(a)* ++ ?()^n; }.
  b. Return ti'.

growmemory mi n
1. Let { TYPE: (i, j); BYTES: b*; } be mi.
2. Let i' be ((|b*| / (64 · $Ki())) + n).
3. If (i' ≤ j), then:
  a. Let mi' be { TYPE: (i', j); BYTES: b* ++ 0^(n · (64 · $Ki())); }.
  b. Return mi'.

funcs exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ externval'* be exter_u0*.
3. If externval_0 is of the case FUNC, then:
  a. Let (FUNC fa) be externval_0.
  b. Return [fa] ++ $funcs(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $funcs(externval'*).

globals exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ externval'* be exter_u0*.
3. If externval_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be externval_0.
  b. Return [ga] ++ $globals(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $globals(externval'*).

tables exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ externval'* be exter_u0*.
3. If externval_0 is of the case TABLE, then:
  a. Let (TABLE ta) be externval_0.
  b. Return [ta] ++ $tables(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $tables(externval'*).

mems exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ externval'* be exter_u0*.
3. If externval_0 is of the case MEM, then:
  a. Let (MEM ma) be externval_0.
  b. Return [ma] ++ $mems(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $mems(externval'*).

allocfunc moduleinst func
1. Assert: Due to validation, func is of the case FUNC.
2. Let (FUNC x local* expr) be func.
3. Let fi be { TYPE: moduleinst.TYPES[x]; MODULE: moduleinst; CODE: func; }.
4. Let a be |s.FUNCS|.
5. Append fi to the s.FUNCS.
6. Return a.

allocfuncs moduleinst func_u0*
1. If (func_u0* is []), then:
  a. Return [].
2. Let [func] ++ func'* be func_u0*.
3. Let fa be $allocfunc(moduleinst, func).
4. Let fa'* be $allocfuncs(moduleinst, func'*).
5. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let gi be { TYPE: globaltype; VALUE: val; }.
2. Let a be |s.GLOBALS|.
3. Append gi to the s.GLOBALS.
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
1. Let ti be { TYPE: (i, j); REFS: ?()^i; }.
2. Let a be |s.TABLES|.
3. Append ti to the s.TABLES.
4. Return a.

alloctables table_u0*
1. If (table_u0* is []), then:
  a. Return [].
2. Let [tabletype] ++ tabletype'* be table_u0*.
3. Let ta be $alloctable(tabletype).
4. Let ta'* be $alloctables(tabletype'*).
5. Return [ta] ++ ta'*.

allocmem (i, j)
1. Let mi be { TYPE: (i, j); BYTES: 0^(i · (64 · $Ki())); }.
2. Let a be |s.MEMS|.
3. Append mi to the s.MEMS.
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
6. Let (MODULE type_0 import* func^n_func global_1 table_2 mem_3 elem* data* start? export*) be module.
7. Assert: Due to validation, mem_3 is of the case MEMORY.
8. Let (MEMORY memtype)^n_mem be mem_3.
9. Assert: Due to validation, table_2 is of the case TABLE.
10. Let (TABLE tabletype)^n_table be table_2.
11. Assert: Due to validation, global_1 is of the case GLOBAL.
12. Let (GLOBAL globaltype expr_1)^n_global be global_1.
13. Assert: Due to validation, type_0 is of the case TYPE.
14. Let (TYPE ft)* be type_0.
15. Let fa* be (|s.FUNCS| + i_func)^(i_func<n_func).
16. Let ga* be (|s.GLOBALS| + i_global)^(i_global<n_global).
17. Let ta* be (|s.TABLES| + i_table)^(i_table<n_table).
18. Let ma* be (|s.MEMS| + i_mem)^(i_mem<n_mem).
19. Let xi* be $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*.
20. Let moduleinst be { TYPES: ft*; FUNCS: fa_ex* ++ fa*; GLOBALS: ga_ex* ++ ga*; TABLES: ta_ex* ++ ta*; MEMS: ma_ex* ++ ma*; EXPORTS: xi*; }.
21. Let funcaddr_0 be $allocfuncs(moduleinst, func^n_func).
22. Assert: Due to validation, (funcaddr_0 is fa*).
23. Let globaladdr_0 be $allocglobals(globaltype^n_global, val*).
24. Assert: Due to validation, (globaladdr_0 is ga*).
25. Let tableaddr_0 be $alloctables(tabletype^n_table).
26. Assert: Due to validation, (tableaddr_0 is ta*).
27. Let memaddr_0 be $allocmems(memtype^n_mem).
28. Assert: Due to validation, (memaddr_0 is ma*).
29. Return moduleinst.

initelem moduleinst u32_u0* funca_u1*
1. If ((u32_u0* is []) and (funca_u1* is [])), then:
  a. Return.
2. Assert: Due to validation, (|funca_u1*| ≥ 1).
3. Let [a*] ++ a'** be funca_u1*.
4. Assert: Due to validation, (|u32_u0*| ≥ 1).
5. Let [i] ++ i'* be u32_u0*.
6. Replace s.TABLES[moduleinst.TABLES[0]].REFS[i : |a*|] with ?(a)*.
7. Perform $initelem(moduleinst, i'*, a'**).
8. Return.

initdata moduleinst u32_u0* byte_u1*
1. If ((u32_u0* is []) and (byte_u1* is [])), then:
  a. Return.
2. Assert: Due to validation, (|byte_u1*| ≥ 1).
3. Let [b*] ++ b'** be byte_u1*.
4. Assert: Due to validation, (|u32_u0*| ≥ 1).
5. Let [i] ++ i'* be u32_u0*.
6. Replace s.MEMS[moduleinst.MEMS[0]].BYTES[i : |b*|] with b*.
7. Perform $initdata(moduleinst, i'*, b'**).
8. Return.

instantiate module externval*
1. Assert: Due to validation, module is of the case MODULE.
2. Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) be module.
3. Assert: Due to validation, type* is of the case TYPE.
4. Let (TYPE functype)* be type*.
5. Let n_F be |func*|.
6. Assert: Due to validation, start? is of the case START.
7. Let (START x')? be start?.
8. Assert: Due to validation, data* is of the case DATA.
9. Let (DATA expr_D b*)* be data*.
10. Assert: Due to validation, elem* is of the case ELEM.
11. Let (ELEM expr_E x*)* be elem*.
12. Assert: Due to validation, global* is of the case GLOBAL.
13. Let (GLOBAL globaltype expr_G)* be global*.
14. Let moduleinst_init be { TYPES: functype*; FUNCS: $funcs(externval*) ++ (|s.FUNCS| + i_F)^(i_F<n_F); GLOBALS: $globals(externval*); TABLES: []; MEMS: []; EXPORTS: []; }.
15. Let f_init be { LOCALS: []; MODULE: moduleinst_init; }.
16. Let z be f_init.
17. Push the activation of z to the stack.
18. Let [(I32.CONST i_D)]* be $eval_expr(expr_D)*.
19. Pop the activation of z from the stack.
20. Push the activation of z to the stack.
21. Let [(I32.CONST i_E)]* be $eval_expr(expr_E)*.
22. Pop the activation of z from the stack.
23. Push the activation of z to the stack.
24. Let [val]* be $eval_expr(expr_G)*.
25. Pop the activation of z from the stack.
26. Let moduleinst be $allocmodule(module, externval*, val*).
27. Let f be { LOCALS: []; MODULE: moduleinst; }.
28. Perform $initelem(moduleinst, i_E*, moduleinst.FUNCS[x]**).
29. Perform $initdata(moduleinst, i_D*, b**).
30. Push the activation of f with arity 0 to the stack.
31. If (CALL x')? is defined, then:
  a. Let ?(instr_0) be (CALL x')?.
  b. Execute the instruction instr_0.
32. Pop the activation of f with arity 0 from the stack.
33. Return f.MODULE.

invoke fa val^n
1. Let f be { LOCALS: []; MODULE: { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; EXPORTS: []; }; }.
2. Let (t_1^n -> t_2*) be $funcinst()[fa].TYPE.
3. Let k be |t_2*|.
4. Push the activation of f with arity k to the stack.
5. Push the values val^n to the stack.
6. Execute the instruction (CALL_ADDR fa).
7. Pop all values val* from the top of the stack.
8. Pop the activation of f with arity k from the stack.
9. Push the values val* to the stack.
10. Pop the values val^k from the stack.
11. Return val^k.

execution_of_UNREACHABLE
1. Trap.

execution_of_NOP
1. Do nothing.

execution_of_DROP
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Do nothing.

execution_of_SELECT
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value val_2 from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop the value val_1 from the stack.
7. If (c is not 0), then:
  a. Push the value val_1 to the stack.
8. Else:
  a. Push the value val_2 to the stack.

execution_of_IF t? instr_1* instr_2*
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute the instruction (BLOCK t? instr_1*).
4. Else:
  a. Execute the instruction (BLOCK t? instr_2*).

execution_of_LABEL_
1. Pop all values val* from the top of the stack.
2. Assert: Due to validation, a label is now on the top of the stack.
3. Pop the current label from the stack.
4. Push the values val* to the stack.

execution_of_BR n_u0
1. Pop all values val* from the top of the stack.
2. Let L be the current label.
3. Let n be the arity of L.
4. Let instr'* be the continuation of L.
5. Pop the current label from the stack.
6. Let admin_u1* be val*.
7. If ((n_u0 is 0) and (|admin_u1*| ≥ n)), then:
  a. Let val'* ++ val^n be admin_u1*.
  b. Push the values val^n to the stack.
  c. Execute the instruction instr'*.
8. If (n_u0 ≥ 1), then:
  a. Let l be (n_u0 - 1).
  b. If the type of admin_u1 is val*, then:
    1) Let val* be admin_u1*.
    2) Push the values val* to the stack.
    3) Execute the instruction (BR l).

execution_of_BR_IF l
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute the instruction (BR l).
4. Else:
  a. Do nothing.

execution_of_BR_TABLE l* l'
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST i) from the stack.
3. If (i < |l*|), then:
  a. Execute the instruction (BR l*[i]).
4. Else:
  a. Execute the instruction (BR l').

execution_of_FRAME_
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop the values val^n from the stack.
5. Assert: Due to validation, a frame is now on the top of the stack.
6. Pop the current frame from the stack.
7. Push the values val^n to the stack.

execution_of_RETURN
1. Pop all values val* from the top of the stack.
2. If a frame is now on the top of the stack, then:
  a. Let f be the current frame.
  b. Let n be the arity of f.
  c. Pop the current frame from the stack.
  d. Let val'* ++ val^n be val*.
  e. Push the values val^n to the stack.
3. Else if a label is now on the top of the stack, then:
  a. Pop the current label from the stack.
  b. Push the values val* to the stack.
  c. Execute the instruction RETURN.

execution_of_TRAP
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_UNOP t unop
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop the value (t.CONST c_1) from the stack.
3. If (|$unop_(t, unop, c_1)| ≤ 0), then:
  a. Trap.
4. Let c be an element of $unop_(t, unop, c_1).
5. Push the value (t.CONST c) to the stack.

execution_of_BINOP t binop
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop the value (t.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type t is on the top of the stack.
4. Pop the value (t.CONST c_1) from the stack.
5. If (|$binop_(t, binop, c_1, c_2)| ≤ 0), then:
  a. Trap.
6. Let c be an element of $binop_(t, binop, c_1, c_2).
7. Push the value (t.CONST c) to the stack.

execution_of_TESTOP t testop
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop the value (t.CONST c_1) from the stack.
3. Let c be $testop_(t, testop, c_1).
4. Push the value (I32.CONST c) to the stack.

execution_of_RELOP t relop
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop the value (t.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type t is on the top of the stack.
4. Pop the value (t.CONST c_1) from the stack.
5. Let c be $relop_(t, relop, c_1, c_2).
6. Push the value (I32.CONST c) to the stack.

execution_of_CVTOP t_2 t_1 cvtop
1. Assert: Due to validation, a value of value type t_1 is on the top of the stack.
2. Pop the value (t_1.CONST c_1) from the stack.
3. If (|$cvtop__(t_1, t_2, cvtop, c_1)| ≤ 0), then:
  a. Trap.
4. Let c be an element of $cvtop__(t_1, t_2, cvtop, c_1).
5. Push the value (t_2.CONST c) to the stack.

execution_of_LOCAL.TEE x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Push the value val to the stack.
4. Push the value val to the stack.
5. Execute the instruction (LOCAL.SET x).

execution_of_BLOCK t? instr*
1. If t? is not defined, then:
  a. Let n be 0.
2. Else:
  a. Let n be 1.
3. Let L be the label_n{[]}.
4. Enter instr* with label L.

execution_of_LOOP t? instr*
1. Let L be the label_0{[(LOOP t? instr*)]}.
2. Enter instr* with label L.

execution_of_CALL x
1. Let z be the current state.
2. Assert: Due to validation, (x < |$funcaddr(z)|).
3. Execute the instruction (CALL_ADDR $funcaddr(z)[x]).

execution_of_CALL_INDIRECT x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If (i ≥ |$table(z, 0).REFS|), then:
  a. Trap.
5. If $table(z, 0).REFS[i] is not defined, then:
  a. Trap.
6. Let ?(a) be $table(z, 0).REFS[i].
7. If (a ≥ |$funcinst(z)|), then:
  a. Trap.
8. If ($type(z, x) is not $funcinst(z)[a].TYPE), then:
  a. Trap.
9. Execute the instruction (CALL_ADDR a).

execution_of_CALL_ADDR a
1. Let z be the current state.
2. Assert: Due to validation, (a < |$funcinst(z)|).
3. Let { TYPE: (t_1^k -> t_2^n); MODULE: mm; CODE: func; } be $funcinst(z)[a].
4. Assert: Due to validation, there are at least k values on the top of the stack.
5. Pop the values val^k from the stack.
6. Assert: Due to validation, func is of the case FUNC.
7. Let (FUNC x local_0 instr*) be func.
8. Assert: Due to validation, local_0 is of the case LOCAL.
9. Let (LOCAL t)* be local_0.
10. Let f be { LOCALS: val^k ++ $default_(t)*; MODULE: mm; }.
11. Let F be the activation of f with arity n.
12. Push F to the stack.
13. Let L be the label_n{[]}.
14. Enter instr* with label L.

execution_of_LOCAL.GET x
1. Let z be the current state.
2. Push the value $local(z, x) to the stack.

execution_of_GLOBAL.GET x
1. Let z be the current state.
2. Push the value $global(z, x).VALUE to the stack.

execution_of_LOAD valty_u0 sz_sx_u1? ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If sz_sx_u1? is not defined, then:
  a. Let t be valty_u0.
  b. If (((i + ao.OFFSET) + ($size(t) / 8)) > |$mem(z, 0).BYTES|), then:
    1) Trap.
  c. Let c be $bytes__1^-1(t, $mem(z, 0).BYTES[(i + ao.OFFSET) : ($size(t) / 8)]).
  d. Push the value (t.CONST c) to the stack.
5. If the type of valty_u0 is Inn, then:
  a. If sz_sx_u1? is defined, then:
    1) Let ?((sz, sx)_0) be sz_sx_u1?.
    2) Let (n, sx) be (sz, sx)_0.
    3) If (((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|), then:
      a) Trap.
  b. Let Inn be valty_u0.
  c. If sz_sx_u1? is defined, then:
    1) Let ?((sz, sx)_0) be sz_sx_u1?.
    2) Let (n, sx) be (sz, sx)_0.
    3) Let c be $ibytes__1^-1(n, $mem(z, 0).BYTES[(i + ao.OFFSET) : (n / 8)]).
    4) Push the value (Inn.CONST $extend__(n, $size(Inn), sx, c)) to the stack.

execution_of_MEMORY.SIZE
1. Let z be the current state.
2. Let ((n · 64) · $Ki()) be |$mem(z, 0).BYTES|.
3. Push the value (I32.CONST n) to the stack.

execution_of_CTXT
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_LOCAL.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Perform $with_local(z, x, val).

execution_of_GLOBAL.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Perform $with_global(z, x, val).

execution_of_STORE valty_u1 sz_u2? ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type valty_u0 is on the top of the stack.
3. Pop the value (valty_u0.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If sz_u2? is not defined, then:
  a. Let t be valty_u1.
  b. If ((((i + ao.OFFSET) + ($size(t) / 8)) > |$mem(z, 0).BYTES|) and (valty_u0 is t)), then:
    1) Trap.
  c. If (valty_u0 is t), then:
    1) Let b* be $bytes_(t, c).
    2) Perform $with_mem(z, 0, (i + ao.OFFSET), ($size(t) / 8), b*).
7. Else:
  a. Let ?(n) be sz_u2?.
  b. If the type of valty_u1 is Inn, then:
    1) Let Inn be valty_u1.
    2) If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|) and (valty_u0 is Inn)), then:
      a) Trap.
    3) If (valty_u0 is Inn), then:
      a) Let b* be $ibytes_(n, $wrap__($size(Inn), n, c)).
      b) Perform $with_mem(z, 0, (i + ao.OFFSET), (n / 8), b*).

execution_of_MEMORY.GROW
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Either:
  a. Let mi be $growmemory($mem(z, 0), n).
  b. Push the value (I32.CONST (|$mem(z, 0).BYTES| / (64 · $Ki()))) to the stack.
  c. Perform $with_meminst(z, 0, mi).
5. Or:
  a. Push the value (I32.CONST $invsigned_(32, (- 1))) to the stack.

eval_expr instr*
1. Execute the instruction instr*.
2. Pop the value val from the stack.
3. Return [val].

group_bytes_by n byte*
1. Let n' be |byte*|.
2. If (n' ≥ n), then:
  a. Return [byte*[0 : n]] ++ $group_bytes_by(n, byte*[n : (n' - n)]).
3. Return [].

execution_of_ARRAY.NEW_DATA x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If $expanddt($type(z, x)) is of the case ARRAY, then:
  a. Let (ARRAY y_0) be $expanddt($type(z, x)).
  b. Let (mut, zt) be y_0.
  c. If ((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|), then:
    1) Trap.
  d. Let cnn be $cunpack(zt).
  e. Let b* be $data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)].
  f. Let gb* be $group_bytes_by(($zsize(zt) / 8), b*).
  g. Let c^n be $inverse_of_ibytes($zsize(zt), gb)*.
  h. Push the values (cnn.CONST c)^n to the stack.
  i. Execute the instruction (ARRAY.NEW_FIXED x n).
== Complete.
Generating prose for Wasm 2.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Prose Generation...
=================
 Generated prose
=================
validation_of_valid_limits
- the limits (n, m) is valid with the nat k if and only if:
  - n is less than or equal to m.
  - m is less than or equal to k.

validation_of_valid_functype
- the function type (t_1* -> t_2*) is valid.

validation_of_valid_globaltype
- the global type ((MUT ()?), t) is valid.

validation_of_valid_tabletype
- the table type (limits, reftype) is valid if and only if:
  - the limits limits is valid with the nat ((2 ^ 32) - 1).

validation_of_valid_memtype
- the memory type (PAGE limits) is valid if and only if:
  - the limits limits is valid with the nat (2 ^ 16).

validation_of_valid_externtype
- the external type exter_u0 is valid if and only if:
  - Either:
    - exter_u0 is (FUNC functype).
    - the function type functype is valid.
  - Or:
    - exter_u0 is (GLOBAL globaltype).
    - the global type globaltype is valid.
  - Or:
    - exter_u0 is (TABLE tabletype).
    - the table type tabletype is valid.
  - Or:
    - exter_u0 is (MEM memtype).
    - the memory type memtype is valid.

validation_of_matching_valtype
- the value type valty_u0 matches the value type t if and only if:
  - Either:
    - valty_u0 is t.
  - Or:
    - valty_u0 is BOT.

validation_of_matching_valtype*
- the value type sequence t_1* matches the value type sequence t_2* if and only if:
  - |t_2*| is |t_1*|.
  - For all t_1 in t_1* and t_2 in t_2*,
    - the value type t_1 matches the value type t_2.

validation_of_matching_limits
- the limits (n_11, n_12) matches the limits (n_21, n_22) if and only if:
  - n_11 is greater than or equal to n_21.
  - n_12 is less than or equal to n_22.

validation_of_matching_functype
- the function type ft matches the function type ft.

validation_of_matching_globaltype
- the global type gt matches the global type gt.

validation_of_matching_tabletype
- the table type (lim_1, rt) matches the table type (lim_2, rt) if and only if:
  - the limits lim_1 matches the limits lim_2.

validation_of_matching_memtype
- the memory type (PAGE lim_1) matches the memory type (PAGE lim_2) if and only if:
  - the limits lim_1 matches the limits lim_2.

validation_of_matching_externtype
- the external type exter_u0 matches the external type exter_u1 if and only if:
  - Either:
    - exter_u0 is (FUNC ft_1).
    - exter_u1 is (FUNC ft_2).
    - the function type ft_1 matches the function type ft_2.
  - Or:
    - exter_u0 is (GLOBAL gt_1).
    - exter_u1 is (GLOBAL gt_2).
    - the global type gt_1 matches the global type gt_2.
  - Or:
    - exter_u0 is (TABLE tt_1).
    - exter_u1 is (TABLE tt_2).
    - the table type tt_1 matches the table type tt_2.
  - Or:
    - exter_u0 is (MEM mt_1).
    - exter_u1 is (MEM mt_2).
    - the memory type mt_1 matches the memory type mt_2.

validation_of_valid_blocktype
- the block type block_u0 is valid with the function type (valty_u1* -> valty_u2*) if and only if:
  - Either:
    - block_u0 is (_RESULT valtype?).
    - valty_u1* is [].
    - valty_u2* is valtype?.
  - Or:
    - block_u0 is (_IDX typeidx).
    - valty_u1* is t_1*.
    - valty_u2* is t_2*.
    - |C.TYPES| is greater than typeidx.
    - C.TYPES[typeidx] is (t_1* -> t_2*).

validation_of_NOP
- the instr NOP is valid with the function type ([] -> []).

validation_of_UNREACHABLE
- the instr UNREACHABLE is valid with the function type (t_1* -> t_2*).

validation_of_DROP
- the instr DROP is valid with the function type ([t] -> []).

validation_of_SELECT
- the instr (SELECT ?([t])) is valid with the function type ([t, t, I32] -> [t]).

validation_of_BLOCK
- the instr (BLOCK bt instr*) is valid with the function type (t_1* -> t_2*) if and only if:
  - the block type bt is valid with the function type (t_1* -> t_2*).
  - Under the context C with .LABELS prepended by [t_2*], the instr sequence instr* is valid with the function type (t_1* -> t_2*).

validation_of_LOOP
- the instr (LOOP bt instr*) is valid with the function type (t_1* -> t_2*) if and only if:
  - the block type bt is valid with the function type (t_1* -> t_2*).
  - Under the context C with .LABELS prepended by [t_1*], the instr sequence instr* is valid with the function type (t_1* -> t_2*).

validation_of_IF
- the instr (IF bt instr_1* instr_2*) is valid with the function type (t_1* ++ [I32] -> t_2*) if and only if:
  - the block type bt is valid with the function type (t_1* -> t_2*).
  - Under the context C with .LABELS prepended by [t_2*], the instr sequence instr_1* is valid with the function type (t_1* -> t_2*).
  - Under the context C with .LABELS prepended by [t_2*], the instr sequence instr_2* is valid with the function type (t_1* -> t_2*).

validation_of_BR
- the instr (BR l) is valid with the function type (t_1* ++ t* -> t_2*) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t*.

validation_of_BR_IF
- the instr (BR_IF l) is valid with the function type (t* ++ [I32] -> t*) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t*.

validation_of_BR_TABLE
- the instr (BR_TABLE l* l') is valid with the function type (t_1* ++ t* -> t_2*) if and only if:
  - For all l in l*,
    - |C.LABELS| is greater than l.
  - |C.LABELS| is greater than l'.
  - For all l in l*,
    - the value type sequence t* matches the result type C.LABELS[l].
  - the value type sequence t* matches the result type C.LABELS[l'].

validation_of_CALL
- the instr (CALL x) is valid with the function type (t_1* -> t_2*) if and only if:
  - |C.FUNCS| is greater than x.
  - C.FUNCS[x] is (t_1* -> t_2*).

validation_of_CALL_INDIRECT
- the instr (CALL_INDIRECT x y) is valid with the function type (t_1* ++ [I32] -> t_2*) if and only if:
  - |C.TABLES| is greater than x.
  - |C.TYPES| is greater than y.
  - C.TABLES[x] is (lim, FUNCREF).
  - C.TYPES[y] is (t_1* -> t_2*).

validation_of_RETURN
- the instr RETURN is valid with the function type (t_1* ++ t* -> t_2*) if and only if:
  - C.RETURN is ?(t*).

validation_of_CONST
- the instr (nt.CONST c_nt) is valid with the function type ([] -> [nt]).

validation_of_UNOP
- the instr (UNOP nt unop_nt) is valid with the function type ([nt] -> [nt]).

validation_of_BINOP
- the instr (BINOP nt binop_nt) is valid with the function type ([nt, nt] -> [nt]).

validation_of_TESTOP
- the instr (TESTOP nt testop_nt) is valid with the function type ([nt] -> [I32]).

validation_of_RELOP
- the instr (RELOP nt relop_nt) is valid with the function type ([nt, nt] -> [I32]).

validation_of_CVTOP
- the instr (CVTOP nt_1 nt_2 REINTERPRET) is valid with the function type ([nt_2] -> [nt_1]) if and only if:
  - $size(nt_1) is $size(nt_2).

validation_of_REF.NULL
- the instr (REF.NULL rt) is valid with the function type ([] -> [rt]).

validation_of_REF.FUNC
- the instr (REF.FUNC x) is valid with the function type ([] -> [FUNCREF]) if and only if:
  - |C.FUNCS| is greater than x.
  - C.FUNCS[x] is ft.

validation_of_REF.IS_NULL
- the instr REF.IS_NULL is valid with the function type ([rt] -> [I32]).

validation_of_VCONST
- the instr (V128.CONST c) is valid with the function type ([] -> [V128]).

validation_of_VVUNOP
- the instr (VVUNOP V128 vvunop) is valid with the function type ([V128] -> [V128]).

validation_of_VVBINOP
- the instr (VVBINOP V128 vvbinop) is valid with the function type ([V128, V128] -> [V128]).

validation_of_VVTERNOP
- the instr (VVTERNOP V128 vvternop) is valid with the function type ([V128, V128, V128] -> [V128]).

validation_of_VVTESTOP
- the instr (VVTESTOP V128 vvtestop) is valid with the function type ([V128] -> [I32]).

validation_of_VUNOP
- the instr (VUNOP sh vunop_sh) is valid with the function type ([V128] -> [V128]).

validation_of_VBINOP
- the instr (VBINOP sh vbinop_sh) is valid with the function type ([V128, V128] -> [V128]).

validation_of_VTESTOP
- the instr (VTESTOP sh vtestop_sh) is valid with the function type ([V128] -> [I32]).

validation_of_VRELOP
- the instr (VRELOP sh vrelop_sh) is valid with the function type ([V128, V128] -> [V128]).

validation_of_VSHIFTOP
- the instr (VSHIFTOP sh vshiftop_sh) is valid with the function type ([V128, I32] -> [V128]).

validation_of_VBITMASK
- the instr (VBITMASK sh) is valid with the function type ([V128] -> [I32]).

validation_of_VSWIZZLE
- the instr (VSWIZZLE sh) is valid with the function type ([V128, V128] -> [V128]).

validation_of_VSHUFFLE
- the instr (VSHUFFLE sh i*) is valid with the function type ([V128, V128] -> [V128]) if and only if:
  - For all i in i*,
    - i is less than (2 · $dim(sh)).

validation_of_VSPLAT
- the instr (VSPLAT sh) is valid with the function type ([$shunpack(sh)] -> [V128]).

validation_of_VEXTRACT_LANE
- the instr (VEXTRACT_LANE sh sx? i) is valid with the function type ([V128] -> [$shunpack(sh)]) if and only if:
  - i is less than $dim(sh).

validation_of_VREPLACE_LANE
- the instr (VREPLACE_LANE sh i) is valid with the function type ([V128, $shunpack(sh)] -> [V128]) if and only if:
  - i is less than $dim(sh).

validation_of_VEXTUNOP
- the instr (VEXTUNOP sh_1 sh_2 vextunop) is valid with the function type ([V128] -> [V128]).

validation_of_VEXTBINOP
- the instr (VEXTBINOP sh_1 sh_2 vextbinop) is valid with the function type ([V128, V128] -> [V128]).

validation_of_VNARROW
- the instr (VNARROW sh_1 sh_2 sx) is valid with the function type ([V128, V128] -> [V128]).

validation_of_VCVTOP
- the instr (VCVTOP sh_1 sh_2 vcvtop hf? sx? zero?) is valid with the function type ([V128] -> [V128]).

validation_of_LOCAL.GET
- the instr (LOCAL.GET x) is valid with the function type ([] -> [t]) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is t.

validation_of_LOCAL.SET
- the instr (LOCAL.SET x) is valid with the function type ([t] -> []) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is t.

validation_of_LOCAL.TEE
- the instr (LOCAL.TEE x) is valid with the function type ([t] -> [t]) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is t.

validation_of_GLOBAL.GET
- the instr (GLOBAL.GET x) is valid with the function type ([] -> [t]) if and only if:
  - |C.GLOBALS| is greater than x.
  - C.GLOBALS[x] is (mut, t).

validation_of_GLOBAL.SET
- the instr (GLOBAL.SET x) is valid with the function type ([t] -> []) if and only if:
  - |C.GLOBALS| is greater than x.
  - C.GLOBALS[x] is ((MUT ?(())), t).

validation_of_TABLE.GET
- the instr (TABLE.GET x) is valid with the function type ([I32] -> [rt]) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

validation_of_TABLE.SET
- the instr (TABLE.SET x) is valid with the function type ([I32, rt] -> []) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

validation_of_TABLE.SIZE
- the instr (TABLE.SIZE x) is valid with the function type ([] -> [I32]) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

validation_of_TABLE.GROW
- the instr (TABLE.GROW x) is valid with the function type ([rt, I32] -> [I32]) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

validation_of_TABLE.FILL
- the instr (TABLE.FILL x) is valid with the function type ([I32, rt, I32] -> []) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

validation_of_TABLE.COPY
- the instr (TABLE.COPY x_1 x_2) is valid with the function type ([I32, I32, I32] -> []) if and only if:
  - |C.TABLES| is greater than x_1.
  - |C.TABLES| is greater than x_2.
  - C.TABLES[x_1] is (lim_1, rt).
  - C.TABLES[x_2] is (lim_2, rt).

validation_of_TABLE.INIT
- the instr (TABLE.INIT x_1 x_2) is valid with the function type ([I32, I32, I32] -> []) if and only if:
  - |C.TABLES| is greater than x_1.
  - |C.ELEMS| is greater than x_2.
  - C.TABLES[x_1] is (lim, rt).
  - C.ELEMS[x_2] is rt.

validation_of_ELEM.DROP
- the instr (ELEM.DROP x) is valid with the function type ([] -> []) if and only if:
  - |C.ELEMS| is greater than x.
  - C.ELEMS[x] is rt.

validation_of_MEMORY.SIZE
- the instr MEMORY.SIZE is valid with the function type ([] -> [I32]) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.

validation_of_MEMORY.GROW
- the instr MEMORY.GROW is valid with the function type ([I32] -> [I32]) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.

validation_of_MEMORY.FILL
- the instr MEMORY.FILL is valid with the function type ([I32, I32, I32] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.

validation_of_MEMORY.COPY
- the instr MEMORY.COPY is valid with the function type ([I32, I32, I32] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.

validation_of_MEMORY.INIT
- the instr (MEMORY.INIT x) is valid with the function type ([I32, I32, I32] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - |C.DATAS| is greater than x.
  - C.MEMS[0] is mt.
  - C.DATAS[x] is OK.

validation_of_DATA.DROP
- the instr (DATA.DROP x) is valid with the function type ([] -> []) if and only if:
  - |C.DATAS| is greater than x.
  - C.DATAS[x] is OK.

validation_of_LOAD
- the instr (LOAD nt (n, sx)? memarg) is valid with the function type ([I32] -> [nt]) if and only if:
  - |C.MEMS| is greater than 0.
  - ((sx? is ?())) if and only if ((n? is ?())).
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(nt) / 8).
  - If n is defined,
    - (2 ^ memarg.ALIGN) is less than or equal to (n / 8).
    - (n / 8) is less than ($size(nt) / 8).
  - If n is defined,
    - nt is Inn.

validation_of_STORE
- the instr (STORE nt n? memarg) is valid with the function type ([I32, nt] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(nt) / 8).
  - If n is defined,
    - (2 ^ memarg.ALIGN) is less than or equal to (n / 8).
    - (n / 8) is less than ($size(nt) / 8).
  - If n is defined,
    - nt is Inn.

validation_of_VLOAD
- the instr (VLOAD V128 ?((SHAPE M N sx)) memarg) is valid with the function type ([I32] -> [V128]) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ((M / 8) · N).

validation_of_VLOAD_LANE
- the instr (VLOAD_LANE V128 n memarg laneidx) is valid with the function type ([I32, V128] -> [V128]) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to (n / 8).
  - laneidx is less than (128 / n).

validation_of_VSTORE
- the instr (VSTORE V128 memarg) is valid with the function type ([I32, V128] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(V128) / 8).

validation_of_VSTORE_LANE
- the instr (VSTORE_LANE V128 n memarg laneidx) is valid with the function type ([I32, V128] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to (n / 8).
  - laneidx is less than (128 / n).

validation_of_valid_instr*
- the instr sequence instr_u0* is valid with the function type (valty_u1* -> valty_u2*) if and only if:
  - Either:
    - instr_u0* is [].
    - valty_u1* is [].
    - valty_u2* is [].
  - Or:
    - instr_u0* is [instr_1] ++ instr_2*.
    - valty_u1* is t_1*.
    - valty_u2* is t_3*.
    - the instr instr_1 is valid with the function type (t_1* -> t_2*).
    - the instr sequence [instr_2] is valid with the function type (t_2* -> t_3*).
  - Or:
    - instr_u0* is instr*.
    - valty_u1* is t'_1*.
    - valty_u2* is t'_2*.
    - the instr sequence instr* is valid with the function type (t_1* -> t_2*).
    - the value type sequence t'_1* matches the value type sequence t_1*.
    - the value type sequence t_2* matches the value type sequence t'_2*.
  - Or:
    - instr_u0* is instr*.
    - valty_u1* is t* ++ t_1*.
    - valty_u2* is t* ++ t_2*.
    - the instr sequence instr* is valid with the function type (t_1* -> t_2*).

validation_of_valid_expr
- the expression instr* is valid with the value type sequence t* if and only if:
  - the instr sequence instr* is valid with the function type ([] -> t*).

validation_of_const_instr
- the instr instr_u0 is constant if and only if:
  - Either:
    - instr_u0 is (nt.CONST c).
  - Or:
    - instr_u0 is (vt.CONST vc).
  - Or:
    - instr_u0 is (REF.NULL rt).
  - Or:
    - instr_u0 is (REF.FUNC x).
  - Or:
    - instr_u0 is (GLOBAL.GET x).
    - |C.GLOBALS| is greater than x.
    - C.GLOBALS[x] is ((MUT ?()), t).

validation_of_const_expr
- the expression instr* is constant if and only if:
  - For all instr in instr*,
    - the instr instr is constant.

validation_of_valid_type
- the type (TYPE ft) is valid with the function type ft if and only if:
  - the function type ft is valid.

validation_of_valid_func
- the function (FUNC x (LOCAL t)* expr) is valid with the function type (t_1* -> t_2*) if and only if:
  - |C.TYPES| is greater than x.
  - C.TYPES[x] is (t_1* -> t_2*).
  - Under the context C with .LOCALS appended by t_1* ++ t* with .LABELS appended by [t_2*] with .RETURN appended by ?(t_2*), the expression expr is valid with the value type sequence t_2*.

validation_of_valid_global
- the global (GLOBAL gt expr) is valid with the global type gt if and only if:
  - the global type gt is valid.
  - gt is (mut, t).
  - the expression expr is valid with the value type t.
  - the expression expr is constant.

validation_of_valid_table
- the table (TABLE tt) is valid with the table type tt if and only if:
  - the table type tt is valid.

validation_of_valid_mem
- the memory (MEMORY mt) is valid with the memory type mt if and only if:
  - the memory type mt is valid.

validation_of_valid_elemmode
- the elemmode elemm_u0 is valid with the reference type rt if and only if:
  - Either:
    - elemm_u0 is (ACTIVE x expr).
    - |C.TABLES| is greater than x.
    - C.TABLES[x] is (lim, rt).
    - the expression expr is valid with the value type I32.
    - the expression expr is constant.
  - Or:
    - elemm_u0 is PASSIVE.
  - Or:
    - elemm_u0 is DECLARE.

validation_of_valid_elem
- the table segment (ELEM rt expr* elemmode) is valid with the reference type rt if and only if:
  - For all expr in expr*,
    - the expression expr is valid with the value type rt.
    - the expression expr is constant.
  - the elemmode elemmode is valid with the reference type rt.

validation_of_valid_datamode
- the datamode datam_u0 is valid if and only if:
  - Either:
    - datam_u0 is (ACTIVE 0 expr).
    - |C.MEMS| is greater than 0.
    - C.MEMS[0] is mt.
    - the expression expr is valid with the value type I32.
    - the expression expr is constant.
  - Or:
    - datam_u0 is PASSIVE.

validation_of_valid_data
- the memory segment (DATA b* datamode) is valid if and only if:
  - the datamode datamode is valid.

validation_of_valid_start
- the start function (START x) is valid if and only if:
  - |C.FUNCS| is greater than x.
  - C.FUNCS[x] is ([] -> []).

validation_of_valid_import
- the import (IMPORT name_1 name_2 xt) is valid with the external type xt if and only if:
  - the external type xt is valid.

validation_of_valid_externidx
- the external index exter_u0 is valid with the external type exter_u1 if and only if:
  - Either:
    - exter_u0 is (FUNC x).
    - exter_u1 is (FUNC ft).
    - |C.FUNCS| is greater than x.
    - C.FUNCS[x] is ft.
  - Or:
    - exter_u0 is (GLOBAL x).
    - exter_u1 is (GLOBAL gt).
    - |C.GLOBALS| is greater than x.
    - C.GLOBALS[x] is gt.
  - Or:
    - exter_u0 is (TABLE x).
    - exter_u1 is (TABLE tt).
    - |C.TABLES| is greater than x.
    - C.TABLES[x] is tt.
  - Or:
    - exter_u0 is (MEM x).
    - exter_u1 is (MEM mt).
    - |C.MEMS| is greater than x.
    - C.MEMS[x] is mt.

validation_of_valid_export
- the export (EXPORT name externidx) is valid with the external type xt if and only if:
  - the external index externidx is valid with the external type xt.

validation_of_valid_module
- the module (MODULE type* import* func* global* table* mem* elem* data^n start? export*) is valid if and only if:
  - |type*| is |ft'*|.
  - |ixt*| is |import*|.
  - |gt*| is |global*|.
  - |tt*| is |table*|.
  - |mt*| is |mem*|.
  - |rt*| is |elem*|.
  - |func*| is |ft*|.
  - |xt*| is |export*|.
  - For all ft' in ft'* and type in type*,
    - the type type is valid with the function type ft'.
  - For all import in import* and ixt in ixt*,
    - Under the context { TYPES: ft'*; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; RETURN: ?(); }, the import import is valid with the external type ixt.
  - For all global in global* and gt in gt*,
    - Under the context C', the global global is valid with the global type gt.
  - For all table in table* and tt in tt*,
    - Under the context C', the table table is valid with the table type tt.
  - For all mem in mem* and mt in mt*,
    - Under the context C', the memory mem is valid with the memory type mt.
  - For all elem in elem* and rt in rt*,
    - Under the context C', the table segment elem is valid with the reference type rt.
  - For all data in data*,
    - Under the context C', the memory segment data is valid.
  - For all ft in ft* and func in func*,
    - the function func is valid with the function type ft.
  - If start is defined,
    - the start function start is valid.
  - For all export in export* and xt in xt*,
    - the export export is valid with the external type xt.
  - |mt*| is less than or equal to 1.
  - C is { TYPES: ft'*; FUNCS: ift* ++ ft*; GLOBALS: igt* ++ gt*; TABLES: itt* ++ tt*; MEMS: imt* ++ mt*; ELEMS: rt*; DATAS: OK^n; LOCALS: []; LABELS: []; RETURN: ?(); }.
  - C' is { TYPES: ft'*; FUNCS: ift* ++ ft*; GLOBALS: igt*; TABLES: itt* ++ tt*; MEMS: imt* ++ mt*; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; RETURN: ?(); }.
  - ift* is $funcsxt(ixt*).
  - igt* is $globalsxt(ixt*).
  - itt* is $tablesxt(ixt*).
  - imt* is $memsxt(ixt*).

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

opt_ X_u0*
1. If (X_u0* is []), then:
  a. Return ?().
2. Assert: Due to validation, (|X_u0*| is 1).
3. Let [w] be X_u0*.
4. Return ?(w).

list_ X_u0?
1. If X_u0? is not defined, then:
  a. Return [].
2. Let ?(w) be X_u0?.
3. Return [w].

concat_ X_u0*
1. If (X_u0* is []), then:
  a. Return [].
2. Let [w*] ++ w'** be X_u0*.
3. Return w* ++ $concat_(w'**).

setproduct2_ w_1 X_u0*
1. If (X_u0* is []), then:
  a. Return [].
2. Let [w'*] ++ w** be X_u0*.
3. Return [[w_1] ++ w'*] ++ $setproduct2_(w_1, w**).

setproduct1_ X_u0* w**
1. If (X_u0* is []), then:
  a. Return [].
2. Let [w_1] ++ w'* be X_u0*.
3. Return $setproduct2_(w_1, w**) ++ $setproduct1_(w'*, w**).

setproduct_ X_u0*
1. If (X_u0* is []), then:
  a. Return [[]].
2. Let [w_1*] ++ w** be X_u0*.
3. Return $setproduct1_(w_1*, $setproduct_(w**)).

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
1. Return (POS (SUBNORM 0)).

fone N
1. Return (POS (NORM 1 0)).

canon_ N
1. Return (2 ^ ($signif(N) - 1)).

utf8 char_u0*
1. If (|char_u0*| is 1), then:
  a. Let [ch] be char_u0*.
  b. If (ch < 128), then:
    1) Let b be ch.
    2) Return [b].
  c. If ((128 ≤ ch) and ((ch < 2048) and (ch ≥ (b_2 - 128)))), then:
    1) Let ((2 ^ 6) · (b_1 - 192)) be (ch - (b_2 - 128)).
    2) Return [b_1, b_2].
  d. If ((((2048 ≤ ch) and (ch < 55296)) or ((57344 ≤ ch) and (ch < 65536))) and (ch ≥ (b_3 - 128))), then:
    1) Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · (b_2 - 128))) be (ch - (b_3 - 128)).
    2) Return [b_1, b_2, b_3].
  e. If ((65536 ≤ ch) and ((ch < 69632) and (ch ≥ (b_4 - 128)))), then:
    1) Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · (b_2 - 128))) + ((2 ^ 6) · (b_3 - 128))) be (ch - (b_4 - 128)).
    2) Return [b_1, b_2, b_3, b_4].
2. Let ch* be char_u0*.
3. Return $concat_($utf8([ch])*).

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

isize Inn
1. Return $size(Inn).

psize packt_u0
1. If (packt_u0 is I8), then:
  a. Return 8.
2. Assert: Due to validation, (packt_u0 is I16).
3. Return 16.

lsize lanet_u0
1. If the type of lanet_u0 is numtype, then:
  a. Let numtype be lanet_u0.
  b. Return $size(numtype).
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $psize(packtype).

lanetype (Lnn X N)
1. Return Lnn.

sizenn nt
1. Return $size(nt).

sizemm lt
1. Return $lsize(lt).

zero numty_u0
1. If the type of numty_u0 is Inn, then:
  a. Return 0.
2. Assert: Due to validation, the type of numty_u0 is Fnn.
3. Let Fnn be numty_u0.
4. Return $fzero($size(Fnn)).

dim (Lnn X N)
1. Return N.

shsize (Lnn X N)
1. Return ($lsize(Lnn) · N).

concat_bytes byte_u0*
1. If (byte_u0* is []), then:
  a. Return [].
2. Let [b*] ++ b'** be byte_u0*.
3. Return b* ++ $concat_bytes(b'**).

unpack lanet_u0
1. If the type of lanet_u0 is numtype, then:
  a. Let numtype be lanet_u0.
  b. Return numtype.
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Return I32.

shunpack (Lnn X N)
1. Return $unpack(Lnn).

funcsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externtype_0] ++ xt* be exter_u0*.
3. If externtype_0 is of the case FUNC, then:
  a. Let (FUNC ft) be externtype_0.
  b. Return [ft] ++ $funcsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $funcsxt(xt*).

globalsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externtype_0] ++ xt* be exter_u0*.
3. If externtype_0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be externtype_0.
  b. Return [gt] ++ $globalsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $globalsxt(xt*).

tablesxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externtype_0] ++ xt* be exter_u0*.
3. If externtype_0 is of the case TABLE, then:
  a. Let (TABLE tt) be externtype_0.
  b. Return [tt] ++ $tablesxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $tablesxt(xt*).

memsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externtype_0] ++ xt* be exter_u0*.
3. If externtype_0 is of the case MEM, then:
  a. Let (MEM mt) be externtype_0.
  b. Return [mt] ++ $memsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $memsxt(xt*).

dataidx_instr instr_u0
1. If instr_u0 is of the case MEMORY.INIT, then:
  a. Let (MEMORY.INIT x) be instr_u0.
  b. Return [x].
2. If instr_u0 is of the case DATA.DROP, then:
  a. Let (DATA.DROP x) be instr_u0.
  b. Return [x].
3. Return [].

dataidx_instrs instr_u0*
1. If (instr_u0* is []), then:
  a. Return [].
2. Let [instr] ++ instr'* be instr_u0*.
3. Return $dataidx_instr(instr) ++ $dataidx_instrs(instr'*).

dataidx_expr in*
1. Return $dataidx_instrs(in*).

dataidx_func (FUNC x loc* e)
1. Return $dataidx_expr(e).

dataidx_funcs func_u0*
1. If (func_u0* is []), then:
  a. Return [].
2. Let [func] ++ func'* be func_u0*.
3. Return $dataidx_func(func) ++ $dataidx_funcs(func'*).

memarg0
1. Return { ALIGN: 0; OFFSET: 0; }.

signed_ N i
1. If (0 ≤ (2 ^ (N - 1))), then:
  a. Return i.
2. Assert: Due to validation, ((2 ^ (N - 1)) ≤ i).
3. Assert: Due to validation, (i < (2 ^ N)).
4. Return (i - (2 ^ N)).

invsigned_ N i
1. Let j be $signed__1^-1(N, i).
2. Return j.

unop_ numty_u1 unop__u0 num__u3
1. If ((unop__u0 is CLZ) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN be num__u3.
  c. Return [$iclz_($size(Inn), iN)].
2. If ((unop__u0 is CTZ) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN be num__u3.
  c. Return [$ictz_($size(Inn), iN)].
3. If ((unop__u0 is POPCNT) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN be num__u3.
  c. Return [$ipopcnt_($size(Inn), iN)].
4. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Assert: Due to validation, unop__u0 is of the case EXTEND.
  c. Let (EXTEND N) be unop__u0.
  d. Let iN be num__u3.
  e. Return [$extend__(N, $size(Inn), S, $wrap__($size(Inn), N, iN))].
5. If ((unop__u0 is ABS) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return $fabs_($size(Fnn), fN).
6. If ((unop__u0 is NEG) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return $fneg_($size(Fnn), fN).
7. If ((unop__u0 is SQRT) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return $fsqrt_($size(Fnn), fN).
8. If ((unop__u0 is CEIL) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return $fceil_($size(Fnn), fN).
9. If ((unop__u0 is FLOOR) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return $ffloor_($size(Fnn), fN).
10. If ((unop__u0 is TRUNC) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return $ftrunc_($size(Fnn), fN).
11. Assert: Due to validation, (unop__u0 is NEAREST).
12. Assert: Due to validation, the type of numty_u1 is Fnn.
13. Let Fnn be numty_u1.
14. Let fN be num__u3.
15. Return $fnearest_($size(Fnn), fN).

binop_ numty_u1 binop_u0 num__u3 num__u5
1. If ((binop_u0 is ADD) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$iadd_($size(Inn), iN_1, iN_2)].
2. If ((binop_u0 is SUB) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$isub_($size(Inn), iN_1, iN_2)].
3. If ((binop_u0 is MUL) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$imul_($size(Inn), iN_1, iN_2)].
4. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. If binop_u0 is of the case DIV, then:
    1) Let (DIV sx) be binop_u0.
    2) Return $list_($idiv_($size(Inn), sx, iN_1, iN_2)).
  e. If binop_u0 is of the case REM, then:
    1) Let (REM sx) be binop_u0.
    2) Return $list_($irem_($size(Inn), sx, iN_1, iN_2)).
5. If ((binop_u0 is AND) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$iand_($size(Inn), iN_1, iN_2)].
6. If ((binop_u0 is OR) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$ior_($size(Inn), iN_1, iN_2)].
7. If ((binop_u0 is XOR) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$ixor_($size(Inn), iN_1, iN_2)].
8. If ((binop_u0 is SHL) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$ishl_($size(Inn), iN_1, iN_2)].
9. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. If binop_u0 is of the case SHR, then:
    1) Let (SHR sx) be binop_u0.
    2) Return [$ishr_($size(Inn), sx, iN_1, iN_2)].
10. If ((binop_u0 is ROTL) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$irotl_($size(Inn), iN_1, iN_2)].
11. If ((binop_u0 is ROTR) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$irotr_($size(Inn), iN_1, iN_2)].
12. If ((binop_u0 is ADD) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fadd_($size(Fnn), fN_1, fN_2).
13. If ((binop_u0 is SUB) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fsub_($size(Fnn), fN_1, fN_2).
14. If ((binop_u0 is MUL) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fmul_($size(Fnn), fN_1, fN_2).
15. If ((binop_u0 is DIV) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fdiv_($size(Fnn), fN_1, fN_2).
16. If ((binop_u0 is MIN) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fmin_($size(Fnn), fN_1, fN_2).
17. If ((binop_u0 is MAX) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fmax_($size(Fnn), fN_1, fN_2).
18. Assert: Due to validation, (binop_u0 is COPYSIGN).
19. Assert: Due to validation, the type of numty_u1 is Fnn.
20. Let Fnn be numty_u1.
21. Let fN_1 be num__u3.
22. Let fN_2 be num__u5.
23. Return $fcopysign_($size(Fnn), fN_1, fN_2).

testop_ Inn EQZ iN
1. Return $ieqz_($size(Inn), iN).

relop_ numty_u1 relop_u0 num__u3 num__u5
1. If ((relop_u0 is EQ) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return $ieq_($size(Inn), iN_1, iN_2).
2. If ((relop_u0 is NE) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return $ine_($size(Inn), iN_1, iN_2).
3. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. If relop_u0 is of the case LT, then:
    1) Let (LT sx) be relop_u0.
    2) Return $ilt_($size(Inn), sx, iN_1, iN_2).
  e. If relop_u0 is of the case GT, then:
    1) Let (GT sx) be relop_u0.
    2) Return $igt_($size(Inn), sx, iN_1, iN_2).
  f. If relop_u0 is of the case LE, then:
    1) Let (LE sx) be relop_u0.
    2) Return $ile_($size(Inn), sx, iN_1, iN_2).
  g. If relop_u0 is of the case GE, then:
    1) Let (GE sx) be relop_u0.
    2) Return $ige_($size(Inn), sx, iN_1, iN_2).
4. If ((relop_u0 is EQ) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $feq_($size(Fnn), fN_1, fN_2).
5. If ((relop_u0 is NE) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fne_($size(Fnn), fN_1, fN_2).
6. If ((relop_u0 is LT) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $flt_($size(Fnn), fN_1, fN_2).
7. If ((relop_u0 is GT) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fgt_($size(Fnn), fN_1, fN_2).
8. If ((relop_u0 is LE) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fle_($size(Fnn), fN_1, fN_2).
9. Assert: Due to validation, (relop_u0 is GE).
10. Assert: Due to validation, the type of numty_u1 is Fnn.
11. Let Fnn be numty_u1.
12. Let fN_1 be num__u3.
13. Let fN_2 be num__u5.
14. Return $fge_($size(Fnn), fN_1, fN_2).

cvtop__ numty_u0 numty_u1 cvtop_u2 num__u4
1. If ((numty_u0 is I32) and (numty_u1 is I64)), then:
  a. Let iN be num__u4.
  b. If cvtop_u2 is of the case EXTEND, then:
    1) Let (EXTEND sx) be cvtop_u2.
    2) Return [$extend__(32, 64, sx, iN)].
2. If ((numty_u0 is I64) and ((numty_u1 is I32) and (cvtop_u2 is WRAP))), then:
  a. Let iN be num__u4.
  b. Return [$wrap__(64, 32, iN)].
3. If the type of numty_u0 is Fnn, then:
  a. Let Fnn be numty_u0.
  b. If the type of numty_u1 is Inn, then:
    1) Let Inn be numty_u1.
    2) Let fN be num__u4.
    3) If cvtop_u2 is of the case TRUNC, then:
      a) Let (TRUNC sx) be cvtop_u2.
      b) Return $list_($trunc__($size(Fnn), $size(Inn), sx, fN)).
    4) If cvtop_u2 is of the case TRUNC_SAT, then:
      a) Let (TRUNC_SAT sx) be cvtop_u2.
      b) Return $list_($trunc_sat__($size(Fnn), $size(Inn), sx, fN)).
4. If ((numty_u0 is F32) and ((numty_u1 is F64) and (cvtop_u2 is PROMOTE))), then:
  a. Let fN be num__u4.
  b. Return $promote__(32, 64, fN).
5. If ((numty_u0 is F64) and ((numty_u1 is F32) and (cvtop_u2 is DEMOTE))), then:
  a. Let fN be num__u4.
  b. Return $demote__(64, 32, fN).
6. If the type of numty_u1 is Fnn, then:
  a. Let Fnn be numty_u1.
  b. If the type of numty_u0 is Inn, then:
    1) Let Inn be numty_u0.
    2) Let iN be num__u4.
    3) If cvtop_u2 is of the case CONVERT, then:
      a) Let (CONVERT sx) be cvtop_u2.
      b) Return [$convert__($size(Inn), $size(Fnn), sx, iN)].
7. Assert: Due to validation, (cvtop_u2 is REINTERPRET).
8. If the type of numty_u1 is Fnn, then:
  a. Let Fnn be numty_u1.
  b. If the type of numty_u0 is Inn, then:
    1) Let Inn be numty_u0.
    2) Let iN be num__u4.
    3) If ($size(Inn) is $size(Fnn)), then:
      a) Return [$reinterpret__(Inn, Fnn, iN)].
9. Assert: Due to validation, the type of numty_u0 is Fnn.
10. Let Fnn be numty_u0.
11. Assert: Due to validation, the type of numty_u1 is Inn.
12. Let Inn be numty_u1.
13. Let fN be num__u4.
14. Assert: Due to validation, ($size(Inn) is $size(Fnn)).
15. Return [$reinterpret__(Fnn, Inn, fN)].

invibytes_ N b*
1. Let n be $ibytes__1^-1(N, b*).
2. Return n.

invfbytes_ N b*
1. Let p be $fbytes__1^-1(N, b*).
2. Return p.

packnum_ lanet_u0 c
1. If the type of lanet_u0 is numtype, then:
  a. Return c.
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $wrap__($size($unpack(packtype)), $psize(packtype), c).

unpacknum_ lanet_u0 c
1. If the type of lanet_u0 is numtype, then:
  a. Return c.
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $extend__($psize(packtype), $size($unpack(packtype)), U, c).

invlanes_ sh c*
1. Let vc be $lanes__1^-1(sh, c*).
2. Return vc.

mapinvlanes_ sh c**
1. Let c'** be $setproduct_(c**).
2. Return $invlanes_(sh, c'*)*.

half half_u0 i j
1. If (half_u0 is LOW), then:
  a. Return i.
2. Assert: Due to validation, (half_u0 is HIGH).
3. Return j.

vvunop_ V128 NOT v128
1. Return $inot_($size(V128), v128).

vvbinop_ V128 vvbin_u0 v128_1 v128_2
1. If (vvbin_u0 is AND), then:
  a. Return $iand_($size(V128), v128_1, v128_2).
2. If (vvbin_u0 is ANDNOT), then:
  a. Return $iandnot_($size(V128), v128_1, v128_2).
3. If (vvbin_u0 is OR), then:
  a. Return $ior_($size(V128), v128_1, v128_2).
4. Assert: Due to validation, (vvbin_u0 is XOR).
5. Return $ixor_($size(V128), v128_1, v128_2).

vvternop_ V128 BITSELECT v128_1 v128_2 v128_3
1. Return $ibitselect_($size(V128), v128_1, v128_2, v128_3).

vunop_ (lanet_u1 X N) vunop_u0 v128_1
1. If ((vunop_u0 is ABS) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let v128 be $invlanes_((Jnn X N), $iabs_($lsize(Jnn), lane_1)*).
  d. Return [v128].
2. If ((vunop_u0 is NEG) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let v128 be $invlanes_((Jnn X N), $ineg_($lsize(Jnn), lane_1)*).
  d. Return [v128].
3. If ((vunop_u0 is POPCNT) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let v128 be $invlanes_((Jnn X N), $ipopcnt_($lsize(Jnn), lane_1)*).
  d. Return [v128].
4. If ((vunop_u0 is ABS) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128* be $mapinvlanes_((Fnn X N), $fabs_($size(Fnn), lane_1)*).
  d. Return v128*.
5. If ((vunop_u0 is NEG) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128* be $mapinvlanes_((Fnn X N), $fneg_($size(Fnn), lane_1)*).
  d. Return v128*.
6. If ((vunop_u0 is SQRT) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128* be $mapinvlanes_((Fnn X N), $fsqrt_($size(Fnn), lane_1)*).
  d. Return v128*.
7. If ((vunop_u0 is CEIL) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128* be $mapinvlanes_((Fnn X N), $fceil_($size(Fnn), lane_1)*).
  d. Return v128*.
8. If ((vunop_u0 is FLOOR) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128* be $mapinvlanes_((Fnn X N), $ffloor_($size(Fnn), lane_1)*).
  d. Return v128*.
9. If ((vunop_u0 is TRUNC) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128* be $mapinvlanes_((Fnn X N), $ftrunc_($size(Fnn), lane_1)*).
  d. Return v128*.
10. Assert: Due to validation, (vunop_u0 is NEAREST).
11. Assert: Due to validation, the type of lanet_u1 is Fnn.
12. Let Fnn be lanet_u1.
13. Let lane_1* be $lanes_((Fnn X N), v128_1).
14. Let v128* be $mapinvlanes_((Fnn X N), $fnearest_($size(Fnn), lane_1)*).
15. Return v128*.

vbinop_ (lanet_u1 X N) vbino_u0 v128_1 v128_2
1. If ((vbino_u0 is ADD) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $iadd_($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
2. If ((vbino_u0 is SUB) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $isub_($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
3. If the type of lanet_u1 is Jnn, then:
  a. Let Jnn be lanet_u1.
  b. If vbino_u0 is of the case MIN, then:
    1) Let (MIN sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $imin_($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
  c. If vbino_u0 is of the case MAX, then:
    1) Let (MAX sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $imax_($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
  d. If vbino_u0 is of the case ADD_SAT, then:
    1) Let (ADD_SAT sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $iadd_sat_($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
  e. If vbino_u0 is of the case SUB_SAT, then:
    1) Let (SUB_SAT sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $isub_sat_($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
4. If ((vbino_u0 is MUL) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $imul_($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
5. If ((vbino_u0 is AVGR) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $iavgr_($lsize(Jnn), U, lane_1, lane_2)*).
  e. Return [v128].
6. If ((vbino_u0 is Q15MULR_SAT) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $iq15mulr_sat_($lsize(Jnn), S, lane_1, lane_2)*).
  e. Return [v128].
7. If ((vbino_u0 is ADD) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fadd_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
8. If ((vbino_u0 is SUB) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fsub_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
9. If ((vbino_u0 is MUL) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fmul_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
10. If ((vbino_u0 is DIV) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fdiv_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
11. If ((vbino_u0 is MIN) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fmin_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
12. If ((vbino_u0 is MAX) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fmax_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
13. If ((vbino_u0 is PMIN) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fpmin_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
14. Assert: Due to validation, (vbino_u0 is PMAX).
15. Assert: Due to validation, the type of lanet_u1 is Fnn.
16. Let Fnn be lanet_u1.
17. Let lane_1* be $lanes_((Fnn X N), v128_1).
18. Let lane_2* be $lanes_((Fnn X N), v128_2).
19. Let v128* be $mapinvlanes_((Fnn X N), $fpmax_($size(Fnn), lane_1, lane_2)*).
20. Return v128*.

vrelop_ (lanet_u1 X N) vrelo_u0 v128_1 v128_2
1. If ((vrelo_u0 is EQ) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let lane_3* be $extend__(1, $lsize(Jnn), S, $ieq_($lsize(Jnn), lane_1, lane_2))*.
  e. Let v128 be $invlanes_((Jnn X N), lane_3*).
  f. Return v128.
2. If ((vrelo_u0 is NE) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let lane_3* be $extend__(1, $lsize(Jnn), S, $ine_($lsize(Jnn), lane_1, lane_2))*.
  e. Let v128 be $invlanes_((Jnn X N), lane_3*).
  f. Return v128.
3. If the type of lanet_u1 is Jnn, then:
  a. Let Jnn be lanet_u1.
  b. If vrelo_u0 is of the case LT, then:
    1) Let (LT sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $extend__(1, $lsize(Jnn), S, $ilt_($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
  c. If vrelo_u0 is of the case GT, then:
    1) Let (GT sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $extend__(1, $lsize(Jnn), S, $igt_($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
  d. If vrelo_u0 is of the case LE, then:
    1) Let (LE sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $extend__(1, $lsize(Jnn), S, $ile_($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
  e. If vrelo_u0 is of the case GE, then:
    1) Let (GE sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $extend__(1, $lsize(Jnn), S, $ige_($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
4. If ((vrelo_u0 is EQ) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $extend__(1, $size(Fnn), S, $feq_($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
5. If ((vrelo_u0 is NE) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $extend__(1, $size(Fnn), S, $fne_($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
6. If ((vrelo_u0 is LT) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $extend__(1, $size(Fnn), S, $flt_($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
7. If ((vrelo_u0 is GT) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $extend__(1, $size(Fnn), S, $fgt_($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
8. If ((vrelo_u0 is LE) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $extend__(1, $size(Fnn), S, $fle_($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
9. Assert: Due to validation, (vrelo_u0 is GE).
10. Assert: Due to validation, the type of lanet_u1 is Fnn.
11. Let Fnn be lanet_u1.
12. Let lane_1* be $lanes_((Fnn X N), v128_1).
13. Let lane_2* be $lanes_((Fnn X N), v128_2).
14. Let Inn be $isize^-1($size(Fnn)).
15. Let lane_3* be $extend__(1, $size(Fnn), S, $fge_($size(Fnn), lane_1, lane_2))*.
16. Let v128 be $invlanes_((Inn X N), lane_3*).
17. Return v128.

vcvtop__ (lanet_u0 X N_1) (lanet_u1 X N_2) vcvto_u4 sx_u5? lane__u3
1. If ((lanet_u0 is I8) and ((lanet_u1 is I16) and (vcvto_u4 is EXTEND))), then:
  a. Let i8 be lane__u3.
  b. If sx_u5? is defined, then:
    1) Let ?(sx) be sx_u5?.
    2) Let i16 be $extend__(8, 16, sx, i8).
    3) Return [i16].
2. If ((lanet_u0 is I16) and ((lanet_u1 is I32) and (vcvto_u4 is EXTEND))), then:
  a. Let i16 be lane__u3.
  b. If sx_u5? is defined, then:
    1) Let ?(sx) be sx_u5?.
    2) Let i32 be $extend__(16, 32, sx, i16).
    3) Return [i32].
3. If (lanet_u0 is I32), then:
  a. If ((lanet_u1 is I64) and (vcvto_u4 is EXTEND)), then:
    1) Let i32 be lane__u3.
    2) If sx_u5? is defined, then:
      a) Let ?(sx) be sx_u5?.
      b) Let i64 be $extend__(32, 64, sx, i32).
      c) Return [i64].
  b. If ((lanet_u1 is F32) and (vcvto_u4 is CONVERT)), then:
    1) Let i32 be lane__u3.
    2) If sx_u5? is defined, then:
      a) Let ?(sx) be sx_u5?.
      b) Let f32 be $convert__(32, 32, sx, i32).
      c) Return [f32].
  c. If ((lanet_u1 is F64) and (vcvto_u4 is CONVERT)), then:
    1) Let i32 be lane__u3.
    2) If sx_u5? is defined, then:
      a) Let ?(sx) be sx_u5?.
      b) Let f64 be $convert__(32, 64, sx, i32).
      c) Return [f64].
4. If ((lanet_u0 is F32) and ((lanet_u1 is I32) and (vcvto_u4 is TRUNC_SAT))), then:
  a. Let f32 be lane__u3.
  b. If sx_u5? is defined, then:
    1) Let ?(sx) be sx_u5?.
    2) Let i32? be $trunc_sat__(32, 32, sx, f32).
    3) Return $list_(i32?).
5. If (lanet_u0 is F64), then:
  a. If ((lanet_u1 is I32) and (vcvto_u4 is TRUNC_SAT)), then:
    1) Let f64 be lane__u3.
    2) If sx_u5? is defined, then:
      a) Let ?(sx) be sx_u5?.
      b) Let i32? be $trunc_sat__(64, 32, sx, f64).
      c) Return $list_(i32?).
  b. If ((lanet_u1 is F32) and (vcvto_u4 is DEMOTE)), then:
    1) Let f64 be lane__u3.
    2) Let f32* be $demote__(64, 32, f64).
    3) Return f32*.
6. Assert: Due to validation, (lanet_u0 is F32).
7. Assert: Due to validation, (lanet_u1 is F64).
8. Assert: Due to validation, (vcvto_u4 is PROMOTE).
9. Let f32 be lane__u3.
10. Let f64* be $promote__(32, 64, f32).
11. Return f64*.

vextunop__ (Inn_1 X N_1) (Inn_2 X N_2) (EXTADD_PAIRWISE sx) c_1
1. Let ci* be $lanes_((Inn_2 X N_2), c_1).
2. Let [cj_1, cj_2]* be $concat_^-1($extend__($lsize(Inn_2), $lsize(Inn_1), sx, ci)*).
3. Let c be $invlanes_((Inn_1 X N_1), $iadd_($lsize(Inn_1), cj_1, cj_2)*).
4. Return c.

vextbinop__ (Inn_1 X N_1) (Inn_2 X N_2) vextb_u0 c_1 c_2
1. If vextb_u0 is of the case EXTMUL, then:
  a. Let (EXTMUL sx hf) be vextb_u0.
  b. Let ci_1* be $lanes_((Inn_2 X N_2), c_1)[$half(hf, 0, N_1) : N_1].
  c. Let ci_2* be $lanes_((Inn_2 X N_2), c_2)[$half(hf, 0, N_1) : N_1].
  d. Let c be $invlanes_((Inn_1 X N_1), $imul_($lsize(Inn_1), $extend__($lsize(Inn_2), $lsize(Inn_1), sx, ci_1), $extend__($lsize(Inn_2), $lsize(Inn_1), sx, ci_2))*).
  e. Return c.
2. Assert: Due to validation, (vextb_u0 is DOT).
3. Let ci_1* be $lanes_((Inn_2 X N_2), c_1).
4. Let ci_2* be $lanes_((Inn_2 X N_2), c_2).
5. Let [cj_1, cj_2]* be $concat_^-1($imul_($lsize(Inn_1), $extend__($lsize(Inn_2), $lsize(Inn_1), S, ci_1), $extend__($lsize(Inn_2), $lsize(Inn_1), S, ci_2))*).
6. Let c be $invlanes_((Inn_1 X N_1), $iadd_($lsize(Inn_1), cj_1, cj_2)*).
7. Return c.

vshiftop_ (Jnn X N) vshif_u0 lane n
1. If (vshif_u0 is SHL), then:
  a. Return $ishl_($lsize(Jnn), lane, n).
2. Assert: Due to validation, vshif_u0 is of the case SHR.
3. Let (SHR sx) be vshif_u0.
4. Return $ishr_($lsize(Jnn), sx, lane, n).

default_ valty_u0
1. If (valty_u0 is I32), then:
  a. Return (I32.CONST 0).
2. If (valty_u0 is I64), then:
  a. Return (I64.CONST 0).
3. If (valty_u0 is F32), then:
  a. Return (F32.CONST $fzero(32)).
4. If (valty_u0 is F64), then:
  a. Return (F64.CONST $fzero(64)).
5. If (valty_u0 is V128), then:
  a. Return (V128.CONST 0).
6. If (valty_u0 is FUNCREF), then:
  a. Return (REF.NULL FUNCREF).
7. Assert: Due to validation, (valty_u0 is EXTERNREF).
8. Return (REF.NULL EXTERNREF).

funcsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ xv* be exter_u0*.
3. If externval_0 is of the case FUNC, then:
  a. Let (FUNC fa) be externval_0.
  b. Return [fa] ++ $funcsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $funcsxv(xv*).

globalsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ xv* be exter_u0*.
3. If externval_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be externval_0.
  b. Return [ga] ++ $globalsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $globalsxv(xv*).

tablesxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ xv* be exter_u0*.
3. If externval_0 is of the case TABLE, then:
  a. Let (TABLE ta) be externval_0.
  b. Return [ta] ++ $tablesxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $tablesxv(xv*).

memsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ xv* be exter_u0*.
3. If externval_0 is of the case MEM, then:
  a. Let (MEM ma) be externval_0.
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
2. Return f.MODULE.FUNCS.

funcinst
1. Return s.FUNCS.

globalinst
1. Return s.GLOBALS.

tableinst
1. Return s.TABLES.

meminst
1. Return s.MEMS.

eleminst
1. Return s.ELEMS.

datainst
1. Return s.DATAS.

moduleinst
1. Let f be the current frame.
2. Return f.MODULE.

type x
1. Let f be the current frame.
2. Return f.MODULE.TYPES[x].

func x
1. Let f be the current frame.
2. Return s.FUNCS[f.MODULE.FUNCS[x]].

global x
1. Let f be the current frame.
2. Return s.GLOBALS[f.MODULE.GLOBALS[x]].

table x
1. Let f be the current frame.
2. Return s.TABLES[f.MODULE.TABLES[x]].

mem x
1. Let f be the current frame.
2. Return s.MEMS[f.MODULE.MEMS[x]].

elem x
1. Let f be the current frame.
2. Return s.ELEMS[f.MODULE.ELEMS[x]].

data x
1. Let f be the current frame.
2. Return s.DATAS[f.MODULE.DATAS[x]].

local x
1. Let f be the current frame.
2. Return f.LOCALS[x].

with_local x v
1. Let f be the current frame.
2. Replace f.LOCALS[x] with v.

with_global x v
1. Let f be the current frame.
2. Replace s.GLOBALS[f.MODULE.GLOBALS[x]].VALUE with v.

with_table x i r
1. Let f be the current frame.
2. Replace s.TABLES[f.MODULE.TABLES[x]].REFS[i] with r.

with_tableinst x ti
1. Let f be the current frame.
2. Replace s.TABLES[f.MODULE.TABLES[x]] with ti.

with_mem x i j b*
1. Let f be the current frame.
2. Replace s.MEMS[f.MODULE.MEMS[x]].BYTES[i : j] with b*.

with_meminst x mi
1. Let f be the current frame.
2. Replace s.MEMS[f.MODULE.MEMS[x]] with mi.

with_elem x r*
1. Let f be the current frame.
2. Replace s.ELEMS[f.MODULE.ELEMS[x]].REFS with r*.

with_data x b*
1. Let f be the current frame.
2. Replace s.DATAS[f.MODULE.DATAS[x]].BYTES with b*.

growtable ti n r
1. Let { TYPE: ((i, j), rt); REFS: r'*; } be ti.
2. Let i' be (|r'*| + n).
3. If (i' ≤ j), then:
  a. Let ti' be { TYPE: ((i', j), rt); REFS: r'* ++ r^n; }.
  b. Return ti'.

growmemory mi n
1. Let { TYPE: (PAGE (i, j)); BYTES: b*; } be mi.
2. Let i' be ((|b*| / (64 · $Ki())) + n).
3. If (i' ≤ j), then:
  a. Let mi' be { TYPE: (PAGE (i', j)); BYTES: b* ++ 0^(n · (64 · $Ki())); }.
  b. Return mi'.

blocktype block_u1
1. If (block_u1 is (_RESULT ?())), then:
  a. Return ([] -> []).
2. If block_u1 is of the case _RESULT, then:
  a. Let (_RESULT valtype_0) be block_u1.
  b. If valtype_0 is defined, then:
    1) Let ?(t) be valtype_0.
    2) Return ([] -> [t]).
3. Assert: Due to validation, block_u1 is of the case _IDX.
4. Let (_IDX x) be block_u1.
5. Return $type(x).

funcs exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ externval'* be exter_u0*.
3. If externval_0 is of the case FUNC, then:
  a. Let (FUNC fa) be externval_0.
  b. Return [fa] ++ $funcs(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $funcs(externval'*).

globals exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ externval'* be exter_u0*.
3. If externval_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be externval_0.
  b. Return [ga] ++ $globals(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $globals(externval'*).

tables exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ externval'* be exter_u0*.
3. If externval_0 is of the case TABLE, then:
  a. Let (TABLE ta) be externval_0.
  b. Return [ta] ++ $tables(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $tables(externval'*).

mems exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ externval'* be exter_u0*.
3. If externval_0 is of the case MEM, then:
  a. Let (MEM ma) be externval_0.
  b. Return [ma] ++ $mems(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $mems(externval'*).

allocfunc moduleinst func
1. Assert: Due to validation, func is of the case FUNC.
2. Let (FUNC x local* expr) be func.
3. Let fi be { TYPE: moduleinst.TYPES[x]; MODULE: moduleinst; CODE: func; }.
4. Let a be |s.FUNCS|.
5. Append fi to the s.FUNCS.
6. Return a.

allocfuncs moduleinst func_u0*
1. If (func_u0* is []), then:
  a. Return [].
2. Let [func] ++ func'* be func_u0*.
3. Let fa be $allocfunc(moduleinst, func).
4. Let fa'* be $allocfuncs(moduleinst, func'*).
5. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let gi be { TYPE: globaltype; VALUE: val; }.
2. Let a be |s.GLOBALS|.
3. Append gi to the s.GLOBALS.
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
1. Let ti be { TYPE: ((i, j), rt); REFS: (REF.NULL rt)^i; }.
2. Let a be |s.TABLES|.
3. Append ti to the s.TABLES.
4. Return a.

alloctables table_u0*
1. If (table_u0* is []), then:
  a. Return [].
2. Let [tabletype] ++ tabletype'* be table_u0*.
3. Let ta be $alloctable(tabletype).
4. Let ta'* be $alloctables(tabletype'*).
5. Return [ta] ++ ta'*.

allocmem (PAGE (i, j))
1. Let mi be { TYPE: (PAGE (i, j)); BYTES: 0^(i · (64 · $Ki())); }.
2. Let a be |s.MEMS|.
3. Append mi to the s.MEMS.
4. Return a.

allocmems memty_u0*
1. If (memty_u0* is []), then:
  a. Return [].
2. Let [memtype] ++ memtype'* be memty_u0*.
3. Let ma be $allocmem(memtype).
4. Let ma'* be $allocmems(memtype'*).
5. Return [ma] ++ ma'*.

allocelem rt ref*
1. Let ei be { TYPE: rt; REFS: ref*; }.
2. Let a be |s.ELEMS|.
3. Append ei to the s.ELEMS.
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
1. Let di be { BYTES: byte*; }.
2. Let a be |s.DATAS|.
3. Append di to the s.DATAS.
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
6. Let (MODULE type_0 import* func^n_func global_1 table_2 mem_3 elem_4 data_5 start? export*) be module.
7. Assert: Due to validation, data_5 is of the case DATA.
8. Let (DATA byte* datamode)^n_data be data_5.
9. Assert: Due to validation, elem_4 is of the case ELEM.
10. Let (ELEM rt expr_2* elemmode)^n_elem be elem_4.
11. Assert: Due to validation, mem_3 is of the case MEMORY.
12. Let (MEMORY memtype)^n_mem be mem_3.
13. Assert: Due to validation, table_2 is of the case TABLE.
14. Let (TABLE tabletype)^n_table be table_2.
15. Assert: Due to validation, global_1 is of the case GLOBAL.
16. Let (GLOBAL globaltype expr_1)^n_global be global_1.
17. Assert: Due to validation, type_0 is of the case TYPE.
18. Let (TYPE ft)* be type_0.
19. Let fa* be (|s.FUNCS| + i_func)^(i_func<n_func).
20. Let ga* be (|s.GLOBALS| + i_global)^(i_global<n_global).
21. Let ta* be (|s.TABLES| + i_table)^(i_table<n_table).
22. Let ma* be (|s.MEMS| + i_mem)^(i_mem<n_mem).
23. Let ea* be (|s.ELEMS| + i_elem)^(i_elem<n_elem).
24. Let da* be (|s.DATAS| + i_data)^(i_data<n_data).
25. Let xi* be $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*.
26. Let moduleinst be { TYPES: ft*; FUNCS: fa_ex* ++ fa*; GLOBALS: ga_ex* ++ ga*; TABLES: ta_ex* ++ ta*; MEMS: ma_ex* ++ ma*; ELEMS: ea*; DATAS: da*; EXPORTS: xi*; }.
27. Let funcaddr_0 be $allocfuncs(moduleinst, func^n_func).
28. Assert: Due to validation, (funcaddr_0 is fa*).
29. Let globaladdr_0 be $allocglobals(globaltype^n_global, val*).
30. Assert: Due to validation, (globaladdr_0 is ga*).
31. Let tableaddr_0 be $alloctables(tabletype^n_table).
32. Assert: Due to validation, (tableaddr_0 is ta*).
33. Let memaddr_0 be $allocmems(memtype^n_mem).
34. Assert: Due to validation, (memaddr_0 is ma*).
35. Let elemaddr_0 be $allocelems(rt^n_elem, ref**).
36. Assert: Due to validation, (elemaddr_0 is ea*).
37. Let dataaddr_0 be $allocdatas(byte*^n_data).
38. Assert: Due to validation, (dataaddr_0 is da*).
39. Return moduleinst.

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
3. Let (ACTIVE nat_0 instr*) be datam_u0.
4. Assert: Due to validation, (nat_0 is 0).
5. Let n be |byte*|.
6. Return instr* ++ [(I32.CONST 0), (I32.CONST n), (MEMORY.INIT i), (DATA.DROP i)].

instantiate module externval*
1. Assert: Due to validation, module is of the case MODULE.
2. Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) be module.
3. Assert: Due to validation, type* is of the case TYPE.
4. Let (TYPE functype)* be type*.
5. Let n_D be |data*|.
6. Let n_E be |elem*|.
7. Let n_F be |func*|.
8. Assert: Due to validation, start? is of the case START.
9. Let (START x)? be start?.
10. Assert: Due to validation, global* is of the case GLOBAL.
11. Let (GLOBAL globaltype expr_G)* be global*.
12. Assert: Due to validation, elem* is of the case ELEM.
13. Let (ELEM reftype expr_E* elemmode)* be elem*.
14. Let instr_D* be $concat_($rundata(data*[j], j)^(j<n_D)).
15. Let instr_E* be $concat_($runelem(elem*[i], i)^(i<n_E)).
16. Let moduleinst_init be { TYPES: functype*; FUNCS: $funcs(externval*) ++ (|s.FUNCS| + i_F)^(i_F<n_F); GLOBALS: $globals(externval*); TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }.
17. Let f_init be { LOCALS: []; MODULE: moduleinst_init; }.
18. Let z be f_init.
19. Push the activation of z to the stack.
20. Let [val]* be $eval_expr(expr_G)*.
21. Pop the activation of z from the stack.
22. Push the activation of z to the stack.
23. Let [ref]** be $eval_expr(expr_E)**.
24. Pop the activation of z from the stack.
25. Let moduleinst be $allocmodule(module, externval*, val*, ref**).
26. Let f be { LOCALS: []; MODULE: moduleinst; }.
27. Push the activation of f with arity 0 to the stack.
28. Execute the instruction instr_E*.
29. Execute the instruction instr_D*.
30. If (CALL x)? is defined, then:
  a. Let ?(instr_0) be (CALL x)?.
  b. Execute the instruction instr_0.
31. Pop the activation of f with arity 0 from the stack.
32. Return f.MODULE.

invoke fa val^n
1. Let f be { LOCALS: []; MODULE: { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }; }.
2. Let (t_1^n -> t_2*) be $funcinst()[fa].TYPE.
3. Let k be |t_2*|.
4. Push the activation of f with arity k to the stack.
5. Push the values val^n to the stack.
6. Execute the instruction (CALL_ADDR fa).
7. Pop all values val* from the top of the stack.
8. Pop the activation of f with arity k from the stack.
9. Push the values val* to the stack.
10. Pop the values val^k from the stack.
11. Return val^k.

execution_of_UNREACHABLE
1. Trap.

execution_of_NOP
1. Do nothing.

execution_of_DROP
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Do nothing.

execution_of_SELECT t*?
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value val_2 from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop the value val_1 from the stack.
7. If (c is not 0), then:
  a. Push the value val_1 to the stack.
8. Else:
  a. Push the value val_2 to the stack.

execution_of_IF bt instr_1* instr_2*
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute the instruction (BLOCK bt instr_1*).
4. Else:
  a. Execute the instruction (BLOCK bt instr_2*).

execution_of_LABEL_
1. Pop all values val* from the top of the stack.
2. Assert: Due to validation, a label is now on the top of the stack.
3. Pop the current label from the stack.
4. Push the values val* to the stack.

execution_of_BR n_u0
1. Pop all values val* from the top of the stack.
2. Let L be the current label.
3. Let n be the arity of L.
4. Let instr'* be the continuation of L.
5. Pop the current label from the stack.
6. Let admin_u1* be val*.
7. If ((n_u0 is 0) and (|admin_u1*| ≥ n)), then:
  a. Let val'* ++ val^n be admin_u1*.
  b. Push the values val^n to the stack.
  c. Execute the instruction instr'*.
8. If (n_u0 ≥ 1), then:
  a. Let l be (n_u0 - 1).
  b. If the type of admin_u1 is val*, then:
    1) Let val* be admin_u1*.
    2) Push the values val* to the stack.
    3) Execute the instruction (BR l).

execution_of_BR_IF l
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute the instruction (BR l).
4. Else:
  a. Do nothing.

execution_of_BR_TABLE l* l'
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST i) from the stack.
3. If (i < |l*|), then:
  a. Execute the instruction (BR l*[i]).
4. Else:
  a. Execute the instruction (BR l').

execution_of_FRAME_
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop the values val^n from the stack.
5. Assert: Due to validation, a frame is now on the top of the stack.
6. Pop the current frame from the stack.
7. Push the values val^n to the stack.

execution_of_RETURN
1. Pop all values val* from the top of the stack.
2. If a frame is now on the top of the stack, then:
  a. Let f be the current frame.
  b. Let n be the arity of f.
  c. Pop the current frame from the stack.
  d. Let val'* ++ val^n be val*.
  e. Push the values val^n to the stack.
3. Else if a label is now on the top of the stack, then:
  a. Pop the current label from the stack.
  b. Push the values val* to the stack.
  c. Execute the instruction RETURN.

execution_of_TRAP
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_UNOP nt unop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_1) from the stack.
3. If (|$unop_(nt, unop, c_1)| is 1), then:
  a. Let [c] be $unop_(nt, unop, c_1).
  b. Push the value (nt.CONST c) to the stack.
4. If ($unop_(nt, unop, c_1) is []), then:
  a. Trap.

execution_of_BINOP nt binop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop the value (nt.CONST c_1) from the stack.
5. If (|$binop_(nt, binop, c_1, c_2)| is 1), then:
  a. Let [c] be $binop_(nt, binop, c_1, c_2).
  b. Push the value (nt.CONST c) to the stack.
6. If ($binop_(nt, binop, c_1, c_2) is []), then:
  a. Trap.

execution_of_TESTOP nt testop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_1) from the stack.
3. Let c be $testop_(nt, testop, c_1).
4. Push the value (I32.CONST c) to the stack.

execution_of_RELOP nt relop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop the value (nt.CONST c_1) from the stack.
5. Let c be $relop_(nt, relop, c_1, c_2).
6. Push the value (I32.CONST c) to the stack.

execution_of_CVTOP nt_2 nt_1 cvtop
1. Assert: Due to validation, a value of value type nt_1 is on the top of the stack.
2. Pop the value (nt_1.CONST c_1) from the stack.
3. If (|$cvtop__(nt_1, nt_2, cvtop, c_1)| is 1), then:
  a. Let [c] be $cvtop__(nt_1, nt_2, cvtop, c_1).
  b. Push the value (nt_2.CONST c) to the stack.
4. If ($cvtop__(nt_1, nt_2, cvtop, c_1) is []), then:
  a. Trap.

execution_of_REF.IS_NULL
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value ref from the stack.
3. If ref is of the case REF.NULL, then:
  a. Push the value (I32.CONST 1) to the stack.
4. Else:
  a. Push the value (I32.CONST 0) to the stack.

execution_of_VVUNOP V128 vvunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $vvunop_(V128, vvunop, c_1).
4. Push the value (V128.CONST c) to the stack.

execution_of_VVBINOP V128 vvbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $vvbinop_(V128, vvbinop, c_1, c_2).
6. Push the value (V128.CONST c) to the stack.

execution_of_VVTERNOP V128 vvternop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_3) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_2) from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop the value (V128.CONST c_1) from the stack.
7. Let c be $vvternop_(V128, vvternop, c_1, c_2, c_3).
8. Push the value (V128.CONST c) to the stack.

execution_of_VVTESTOP V128 ANY_TRUE
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $ine_($size(V128), c_1, 0).
4. Push the value (I32.CONST c) to the stack.

execution_of_VUNOP sh vunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. If (|$vunop_(sh, vunop, c_1)| ≤ 0), then:
  a. Trap.
4. Let c be an element of $vunop_(sh, vunop, c_1).
5. Push the value (V128.CONST c) to the stack.

execution_of_VBINOP sh vbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. If (|$vbinop_(sh, vbinop, c_1, c_2)| ≤ 0), then:
  a. Trap.
6. Let c be an element of $vbinop_(sh, vbinop, c_1, c_2).
7. Push the value (V128.CONST c) to the stack.

execution_of_VTESTOP (Jnn X N) ALL_TRUE
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c) from the stack.
3. Let ci_1* be $lanes_((Jnn X N), c).
4. If (ci_1 is not 0)*, then:
  a. Push the value (I32.CONST 1) to the stack.
5. Else:
  a. Push the value (I32.CONST 0) to the stack.

execution_of_VRELOP sh vrelop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $vrelop_(sh, vrelop, c_1, c_2).
6. Push the value (V128.CONST c) to the stack.

execution_of_VSHIFTOP (Jnn X N) vshiftop
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c'* be $lanes_((Jnn X N), c_1).
6. Let c be $invlanes_((Jnn X N), $vshiftop_((Jnn X N), vshiftop, c', n)*).
7. Push the value (V128.CONST c) to the stack.

execution_of_VBITMASK (Jnn X N)
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c) from the stack.
3. Let ci_1* be $lanes_((Jnn X N), c).
4. Let ci be $ibits__1^-1(32, $ilt_($lsize(Jnn), S, ci_1, 0)*).
5. Push the value (I32.CONST ci) to the stack.

execution_of_VSWIZZLE (Pnn X N)
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c* be $lanes_((Pnn X N), c_1) ++ 0^(256 - N).
6. Let ci* be $lanes_((Pnn X N), c_2).
7. Assert: Due to validation, (ci*[k] < |c*|)^(k<N).
8. Assert: Due to validation, (k < |ci*|)^(k<N).
9. Let c' be $invlanes_((Pnn X N), c*[ci*[k]]^(k<N)).
10. Push the value (V128.CONST c') to the stack.

execution_of_VSHUFFLE (Pnn X N) i*
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Assert: Due to validation, (k < |i*|)^(k<N).
6. Let c'* be $lanes_((Pnn X N), c_1) ++ $lanes_((Pnn X N), c_2).
7. Assert: Due to validation, (i*[k] < |c'*|)^(k<N).
8. Let c be $invlanes_((Pnn X N), c'*[i*[k]]^(k<N)).
9. Push the value (V128.CONST c) to the stack.

execution_of_VSPLAT (Lnn X N)
1. Assert: Due to validation, a value of value type $unpack(Lnn) is on the top of the stack.
2. Pop the value (nt_0.CONST c_1) from the stack.
3. Let c be $invlanes_((Lnn X N), $packnum_(Lnn, c_1)^N).
4. Push the value (V128.CONST c) to the stack.

execution_of_VEXTRACT_LANE (lanet_u0 X N) sx_u1? i
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. If (sx_u1? is not defined and the type of lanet_u0 is numtype), then:
  a. Let nt be lanet_u0.
  b. If (i < |$lanes_((nt X N), c_1)|), then:
    1) Let c_2 be $lanes_((nt X N), c_1)[i].
    2) Push the value (nt.CONST c_2) to the stack.
4. If the type of lanet_u0 is packtype, then:
  a. Let pt be lanet_u0.
  b. If sx_u1? is defined, then:
    1) Let ?(sx) be sx_u1?.
    2) If (i < |$lanes_((pt X N), c_1)|), then:
      a) Let c_2 be $extend__($psize(pt), 32, sx, $lanes_((pt X N), c_1)[i]).
      b) Push the value (I32.CONST c_2) to the stack.

execution_of_VREPLACE_LANE (Lnn X N) i
1. Assert: Due to validation, a value of value type $unpack(Lnn) is on the top of the stack.
2. Pop the value (nt_0.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $invlanes_((Lnn X N), $lanes_((Lnn X N), c_1) with [i] replaced by $packnum_(Lnn, c_2)).
6. Push the value (V128.CONST c) to the stack.

execution_of_VEXTUNOP sh_1 sh_2 vextunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $vextunop__(sh_1, sh_2, vextunop, c_1).
4. Push the value (V128.CONST c) to the stack.

execution_of_VEXTBINOP sh_1 sh_2 vextbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $vextbinop__(sh_1, sh_2, vextbinop, c_1, c_2).
6. Push the value (V128.CONST c) to the stack.

execution_of_VNARROW (Jnn_2 X N_2) (Jnn_1 X N_1) sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let ci_1* be $lanes_((Jnn_1 X N_1), c_1).
6. Let ci_2* be $lanes_((Jnn_1 X N_1), c_2).
7. Let cj_1* be $narrow__($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_1)*.
8. Let cj_2* be $narrow__($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_2)*.
9. Let c be $invlanes_((Jnn_2 X N_2), cj_1* ++ cj_2*).
10. Push the value (V128.CONST c) to the stack.

execution_of_VCVTOP (lanet_u2 X N_2) (lanet_u3 X N_1) vcvtop half_u0? sx_u1? zero_u4?
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. If (half_u0? is not defined and zero_u4? is not defined), then:
  a. Let Lnn_1 be lanet_u3.
  b. Let Lnn_2 be lanet_u2.
  c. If sx_u1? is defined, then:
    1) Let ?(sx) be sx_u1?.
    2) Let c'* be $lanes_((Lnn_1 X N_1), c_1).
    3) If (|$mapinvlanes_((Lnn_2 X N_2), $vcvtop__((Lnn_1 X N_1), (Lnn_2 X N_2), vcvtop, ?(sx), c')*)| > 0), then:
      a) Let c be an element of $mapinvlanes_((Lnn_2 X N_2), $vcvtop__((Lnn_1 X N_1), (Lnn_2 X N_2), vcvtop, ?(sx), c')*).
      b) Push the value (V128.CONST c) to the stack.
4. If zero_u4? is not defined, then:
  a. Let Lnn_1 be lanet_u3.
  b. Let Lnn_2 be lanet_u2.
  c. If half_u0? is defined, then:
    1) Let ?(hf) be half_u0?.
    2) Let sx? be sx_u1?.
    3) Let ci* be $lanes_((Lnn_1 X N_1), c_1)[$half(hf, 0, N_2) : N_2].
    4) If (|$mapinvlanes_((Lnn_2 X N_2), $vcvtop__((Lnn_1 X N_1), (Lnn_2 X N_2), vcvtop, sx?, ci)*)| > 0), then:
      a) Let c be an element of $mapinvlanes_((Lnn_2 X N_2), $vcvtop__((Lnn_1 X N_1), (Lnn_2 X N_2), vcvtop, sx?, ci)*).
      b) Push the value (V128.CONST c) to the stack.
5. If (half_u0? is not defined and ((zero_u4? is ?(ZERO)) and the type of lanet_u3 is numtype)), then:
  a. Let nt_1 be lanet_u3.
  b. If the type of lanet_u2 is numtype, then:
    1) Let nt_2 be lanet_u2.
    2) Let sx? be sx_u1?.
    3) Let ci* be $lanes_((nt_1 X N_1), c_1).
    4) If (|$mapinvlanes_((nt_2 X N_2), $vcvtop__((nt_1 X N_1), (nt_2 X N_2), vcvtop, sx?, ci)* ++ [$zero(nt_2)]^N_1)| > 0), then:
      a) Let c be an element of $mapinvlanes_((nt_2 X N_2), $vcvtop__((nt_1 X N_1), (nt_2 X N_2), vcvtop, sx?, ci)* ++ [$zero(nt_2)]^N_1).
      b) Push the value (V128.CONST c) to the stack.

execution_of_LOCAL.TEE x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Push the value val to the stack.
4. Push the value val to the stack.
5. Execute the instruction (LOCAL.SET x).

execution_of_BLOCK bt instr*
1. Let z be the current state.
2. Let (t_1^k -> t_2^n) be $blocktype(z, bt).
3. Assert: Due to validation, there are at least k values on the top of the stack.
4. Pop the values val^k from the stack.
5. Let L be the label_n{[]}.
6. Enter val^k ++ instr* with label L.

execution_of_LOOP bt instr*
1. Let z be the current state.
2. Let (t_1^k -> t_2^n) be $blocktype(z, bt).
3. Assert: Due to validation, there are at least k values on the top of the stack.
4. Pop the values val^k from the stack.
5. Let L be the label_k{[(LOOP bt instr*)]}.
6. Enter val^k ++ instr* with label L.

execution_of_CALL x
1. Let z be the current state.
2. Assert: Due to validation, (x < |$funcaddr(z)|).
3. Execute the instruction (CALL_ADDR $funcaddr(z)[x]).

execution_of_CALL_INDIRECT x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If (i ≥ |$table(z, x).REFS|), then:
  a. Trap.
5. If $table(z, x).REFS[i] is not of the case REF.FUNC_ADDR, then:
  a. Trap.
6. Let (REF.FUNC_ADDR a) be $table(z, x).REFS[i].
7. If (a ≥ |$funcinst(z)|), then:
  a. Trap.
8. If ($type(z, y) is not $funcinst(z)[a].TYPE), then:
  a. Trap.
9. Execute the instruction (CALL_ADDR a).

execution_of_CALL_ADDR a
1. Let z be the current state.
2. Assert: Due to validation, (a < |$funcinst(z)|).
3. Let { TYPE: (t_1^k -> t_2^n); MODULE: mm; CODE: func; } be $funcinst(z)[a].
4. Assert: Due to validation, there are at least k values on the top of the stack.
5. Pop the values val^k from the stack.
6. Assert: Due to validation, func is of the case FUNC.
7. Let (FUNC x local_0 instr*) be func.
8. Assert: Due to validation, local_0 is of the case LOCAL.
9. Let (LOCAL t)* be local_0.
10. Let f be { LOCALS: val^k ++ $default_(t)*; MODULE: mm; }.
11. Let F be the activation of f with arity n.
12. Push F to the stack.
13. Let L be the label_n{[]}.
14. Enter instr* with label L.

execution_of_REF.FUNC x
1. Let z be the current state.
2. Assert: Due to validation, (x < |$funcaddr(z)|).
3. Push the value (REF.FUNC_ADDR $funcaddr(z)[x]) to the stack.

execution_of_LOCAL.GET x
1. Let z be the current state.
2. Push the value $local(z, x) to the stack.

execution_of_GLOBAL.GET x
1. Let z be the current state.
2. Push the value $global(z, x).VALUE to the stack.

execution_of_TABLE.GET x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If (i ≥ |$table(z, x).REFS|), then:
  a. Trap.
5. Push the value $table(z, x).REFS[i] to the stack.

execution_of_TABLE.SIZE x
1. Let z be the current state.
2. Let n be |$table(z, x).REFS|.
3. Push the value (I32.CONST n) to the stack.

execution_of_TABLE.FILL x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value val from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. If ((i + n) > |$table(z, x).REFS|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else:
  a. Push the value (I32.CONST i) to the stack.
  b. Push the value val to the stack.
  c. Execute the instruction (TABLE.SET x).
  d. Push the value (I32.CONST (i + 1)) to the stack.
  e. Push the value val to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (TABLE.FILL x).

execution_of_TABLE.COPY x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$table(z, y).REFS|), then:
  a. Trap.
9. If ((j + n) > |$table(z, x).REFS|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else:
  a. If (j ≤ i), then:
    1) Push the value (I32.CONST j) to the stack.
    2) Push the value (I32.CONST i) to the stack.
    3) Execute the instruction (TABLE.GET y).
    4) Execute the instruction (TABLE.SET x).
    5) Push the value (I32.CONST (j + 1)) to the stack.
    6) Push the value (I32.CONST (i + 1)) to the stack.
  b. Else:
    1) Push the value (I32.CONST ((j + n) - 1)) to the stack.
    2) Push the value (I32.CONST ((i + n) - 1)) to the stack.
    3) Execute the instruction (TABLE.GET y).
    4) Execute the instruction (TABLE.SET x).
    5) Push the value (I32.CONST j) to the stack.
    6) Push the value (I32.CONST i) to the stack.
  c. Push the value (I32.CONST (n - 1)) to the stack.
  d. Execute the instruction (TABLE.COPY x y).

execution_of_TABLE.INIT x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$elem(z, y).REFS|), then:
  a. Trap.
9. If ((j + n) > |$table(z, x).REFS|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else if (i < |$elem(z, y).REFS|), then:
  a. Push the value (I32.CONST j) to the stack.
  b. Push the value $elem(z, y).REFS[i] to the stack.
  c. Execute the instruction (TABLE.SET x).
  d. Push the value (I32.CONST (j + 1)) to the stack.
  e. Push the value (I32.CONST (i + 1)) to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (TABLE.INIT x y).

execution_of_LOAD numty_u0 sz_sx_u1? ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If sz_sx_u1? is not defined, then:
  a. Let nt be numty_u0.
  b. If (((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, 0).BYTES|), then:
    1) Trap.
  c. Let c be $nbytes__1^-1(nt, $mem(z, 0).BYTES[(i + ao.OFFSET) : ($size(nt) / 8)]).
  d. Push the value (nt.CONST c) to the stack.
5. If the type of numty_u0 is Inn, then:
  a. If sz_sx_u1? is defined, then:
    1) Let ?((sz, sx)_0) be sz_sx_u1?.
    2) Let (n, sx) be (sz, sx)_0.
    3) If (((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|), then:
      a) Trap.
  b. Let Inn be numty_u0.
  c. If sz_sx_u1? is defined, then:
    1) Let ?((sz, sx)_0) be sz_sx_u1?.
    2) Let (n, sx) be (sz, sx)_0.
    3) Let c be $ibytes__1^-1(n, $mem(z, 0).BYTES[(i + ao.OFFSET) : (n / 8)]).
    4) Push the value (Inn.CONST $extend__(n, $size(Inn), sx, c)) to the stack.

execution_of_VLOAD V128 vload_u0? ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If ((((i + ao.OFFSET) + ($size(V128) / 8)) > |$mem(z, 0).BYTES|) and vload_u0? is not defined), then:
  a. Trap.
5. If vload_u0? is not defined, then:
  a. Let c be $vbytes__1^-1(V128, $mem(z, 0).BYTES[(i + ao.OFFSET) : ($size(V128) / 8)]).
  b. Push the value (V128.CONST c) to the stack.
6. Else:
  a. Let ?(vloadop_0) be vload_u0?.
  b. If vloadop_0 is of the case SHAPE, then:
    1) Let (SHAPE M N sx) be vloadop_0.
    2) If (((i + ao.OFFSET) + ((M · N) / 8)) > |$mem(z, 0).BYTES|), then:
      a) Trap.
    3) If the type of $lsize^-1((M · 2)) is Jnn, then:
      a) Let Jnn be $lsize^-1((M · 2)).
      b) Let j^N be $ibytes__1^-1(M, $mem(z, 0).BYTES[((i + ao.OFFSET) + ((k · M) / 8)) : (M / 8)])^(k<N).
      c) Let c be $invlanes_((Jnn X N), $extend__(M, $lsize(Jnn), sx, j)^N).
      d) Push the value (V128.CONST c) to the stack.
  c. If vloadop_0 is of the case SPLAT, then:
    1) Let (SPLAT N) be vloadop_0.
    2) If (((i + ao.OFFSET) + (N / 8)) > |$mem(z, 0).BYTES|), then:
      a) Trap.
    3) Let M be (128 / N).
    4) If the type of $lsize^-1(N) is Jnn, then:
      a) Let Jnn be $lsize^-1(N).
      b) Let j be $ibytes__1^-1(N, $mem(z, 0).BYTES[(i + ao.OFFSET) : (N / 8)]).
      c) Let c be $invlanes_((Jnn X M), j^M).
      d) Push the value (V128.CONST c) to the stack.
  d. If vloadop_0 is of the case ZERO, then:
    1) Let (ZERO N) be vloadop_0.
    2) If (((i + ao.OFFSET) + (N / 8)) > |$mem(z, 0).BYTES|), then:
      a) Trap.
    3) Let j be $ibytes__1^-1(N, $mem(z, 0).BYTES[(i + ao.OFFSET) : (N / 8)]).
    4) Let c be $extend__(N, 128, U, j).
    5) Push the value (V128.CONST c) to the stack.

execution_of_VLOAD_LANE V128 N ao j
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value (V128.CONST c_1) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (((i + ao.OFFSET) + (N / 8)) > |$mem(z, 0).BYTES|), then:
  a. Trap.
7. Let M be (128 / N).
8. If the type of $lsize^-1(N) is Jnn, then:
  a. Let Jnn be $lsize^-1(N).
  b. Let k be $ibytes__1^-1(N, $mem(z, 0).BYTES[(i + ao.OFFSET) : (N / 8)]).
  c. Let c be $invlanes_((Jnn X M), $lanes_((Jnn X M), c_1) with [j] replaced by k).
  d. Push the value (V128.CONST c) to the stack.

execution_of_MEMORY.SIZE
1. Let z be the current state.
2. Let ((n · 64) · $Ki()) be |$mem(z, 0).BYTES|.
3. Push the value (I32.CONST n) to the stack.

execution_of_MEMORY.FILL
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value val from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. If ((i + n) > |$mem(z, 0).BYTES|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else:
  a. Push the value (I32.CONST i) to the stack.
  b. Push the value val to the stack.
  c. Execute the instruction (STORE I32 ?(8) $memarg0()).
  d. Push the value (I32.CONST (i + 1)) to the stack.
  e. Push the value val to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction MEMORY.FILL.

execution_of_MEMORY.COPY
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$mem(z, 0).BYTES|), then:
  a. Trap.
9. If ((j + n) > |$mem(z, 0).BYTES|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else:
  a. If (j ≤ i), then:
    1) Push the value (I32.CONST j) to the stack.
    2) Push the value (I32.CONST i) to the stack.
    3) Execute the instruction (LOAD I32 ?((8, U)) $memarg0()).
    4) Execute the instruction (STORE I32 ?(8) $memarg0()).
    5) Push the value (I32.CONST (j + 1)) to the stack.
    6) Push the value (I32.CONST (i + 1)) to the stack.
  b. Else:
    1) Push the value (I32.CONST ((j + n) - 1)) to the stack.
    2) Push the value (I32.CONST ((i + n) - 1)) to the stack.
    3) Execute the instruction (LOAD I32 ?((8, U)) $memarg0()).
    4) Execute the instruction (STORE I32 ?(8) $memarg0()).
    5) Push the value (I32.CONST j) to the stack.
    6) Push the value (I32.CONST i) to the stack.
  c. Push the value (I32.CONST (n - 1)) to the stack.
  d. Execute the instruction MEMORY.COPY.

execution_of_MEMORY.INIT x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$data(z, x).BYTES|), then:
  a. Trap.
9. If ((j + n) > |$mem(z, 0).BYTES|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else if (i < |$data(z, x).BYTES|), then:
  a. Push the value (I32.CONST j) to the stack.
  b. Push the value (I32.CONST $data(z, x).BYTES[i]) to the stack.
  c. Execute the instruction (STORE I32 ?(8) $memarg0()).
  d. Push the value (I32.CONST (j + 1)) to the stack.
  e. Push the value (I32.CONST (i + 1)) to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (MEMORY.INIT x).

execution_of_CTXT
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_LOCAL.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Perform $with_local(z, x, val).

execution_of_GLOBAL.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Perform $with_global(z, x, val).

execution_of_TABLE.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value ref from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (i ≥ |$table(z, x).REFS|), then:
  a. Trap.
7. Perform $with_table(z, x, i, ref).

execution_of_TABLE.GROW x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value ref from the stack.
6. Either:
  a. Let ti be $growtable($table(z, x), n, ref).
  b. Push the value (I32.CONST |$table(z, x).REFS|) to the stack.
  c. Perform $with_tableinst(z, x, ti).
7. Or:
  a. Push the value (I32.CONST $invsigned_(32, (- 1))) to the stack.

execution_of_ELEM.DROP x
1. Let z be the current state.
2. Perform $with_elem(z, x, []).

execution_of_STORE numty_u1 sz_u2? ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type numty_u0 is on the top of the stack.
3. Pop the value (numty_u0.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If sz_u2? is not defined, then:
  a. Let nt be numty_u1.
  b. If ((((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, 0).BYTES|) and (numty_u0 is nt)), then:
    1) Trap.
  c. If (numty_u0 is nt), then:
    1) Let b* be $nbytes_(nt, c).
    2) Perform $with_mem(z, 0, (i + ao.OFFSET), ($size(nt) / 8), b*).
7. Else:
  a. Let ?(n) be sz_u2?.
  b. If the type of numty_u1 is Inn, then:
    1) Let Inn be numty_u1.
    2) If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|) and (numty_u0 is Inn)), then:
      a) Trap.
    3) If (numty_u0 is Inn), then:
      a) Let b* be $ibytes_(n, $wrap__($size(Inn), n, c)).
      b) Perform $with_mem(z, 0, (i + ao.OFFSET), (n / 8), b*).

execution_of_VSTORE V128 ao
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value (V128.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (((i + ao.OFFSET) + ($size(V128) / 8)) > |$mem(z, 0).BYTES|), then:
  a. Trap.
7. Let b* be $vbytes_(V128, c).
8. Perform $with_mem(z, 0, (i + ao.OFFSET), ($size(V128) / 8), b*).

execution_of_VSTORE_LANE V128 N ao j
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value (V128.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (((i + ao.OFFSET) + N) > |$mem(z, 0).BYTES|), then:
  a. Trap.
7. Let M be (128 / N).
8. If the type of $lsize^-1(N) is Jnn, then:
  a. Let Jnn be $lsize^-1(N).
  b. If (j < |$lanes_((Jnn X M), c)|), then:
    1) Let b* be $ibytes_(N, $lanes_((Jnn X M), c)[j]).
    2) Perform $with_mem(z, 0, (i + ao.OFFSET), (N / 8), b*).

execution_of_MEMORY.GROW
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Either:
  a. Let mi be $growmemory($mem(z, 0), n).
  b. Push the value (I32.CONST (|$mem(z, 0).BYTES| / (64 · $Ki()))) to the stack.
  c. Perform $with_meminst(z, 0, mi).
5. Or:
  a. Push the value (I32.CONST $invsigned_(32, (- 1))) to the stack.

execution_of_DATA.DROP x
1. Let z be the current state.
2. Perform $with_data(z, x, []).

eval_expr instr*
1. Execute the instruction instr*.
2. Pop the value val from the stack.
3. Return [val].

group_bytes_by n byte*
1. Let n' be |byte*|.
2. If (n' ≥ n), then:
  a. Return [byte*[0 : n]] ++ $group_bytes_by(n, byte*[n : (n' - n)]).
3. Return [].

execution_of_ARRAY.NEW_DATA x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If $expanddt($type(z, x)) is of the case ARRAY, then:
  a. Let (ARRAY y_0) be $expanddt($type(z, x)).
  b. Let (mut, zt) be y_0.
  c. If ((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|), then:
    1) Trap.
  d. Let cnn be $cunpack(zt).
  e. Let b* be $data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)].
  f. Let gb* be $group_bytes_by(($zsize(zt) / 8), b*).
  g. Let c^n be $inverse_of_ibytes($zsize(zt), gb)*.
  h. Push the values (cnn.CONST c)^n to the stack.
  i. Execute the instruction (ARRAY.NEW_FIXED x n).
== Complete.
Generating prose for Wasm 3.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Translating to AL...
== Prose Generation...
6-typing.watsup:194.10-194.32: if_expr_to_instrs: Yet `$before(typeuse, x, i)`
6-typing.watsup:817.9-817.55: if_expr_to_instrs: Yet `(($unpack(zt) = (numtype : numtype <: valtype)) \/ ($unpack(zt) = (vectype : vectype <: valtype)))`
6-typing.watsup:851.9-851.55: if_expr_to_instrs: Yet `(($unpack(zt) = (numtype : numtype <: valtype)) \/ ($unpack(zt) = (vectype : vectype <: valtype)))`
6-typing.watsup:1309.9-1309.30: if_expr_to_instrs: Yet `$disjoint_(syntax name, nm*{nm : name})`
=================
 Generated prose
=================
validation_of_valid_numtype
- the number type numtype is valid.

validation_of_valid_vectype
- the vector type vectype is valid.

validation_of_valid_heaptype
- the heap type heapt_u0 is valid if and only if:
  - Either:
    - heapt_u0 is absheaptype.
  - Or:
    - heapt_u0 is (_IDX typeidx).
    - |C.TYPES| is greater than typeidx.
    - C.TYPES[typeidx] is dt.
  - Or:
    - heapt_u0 is (REC i).
    - |C.RECS| is greater than i.
    - C.RECS[i] is st.

validation_of_valid_reftype
- the reference type (REF (NULL ()?) heaptype) is valid if and only if:
  - the heap type heaptype is valid.

validation_of_valid_valtype
- the value type valty_u0 is valid if and only if:
  - Either:
    - valty_u0 is numtype.
    - the number type numtype is valid.
  - Or:
    - valty_u0 is vectype.
    - the vector type vectype is valid.
  - Or:
    - valty_u0 is reftype.
    - the reference type reftype is valid.
  - Or:
    - valty_u0 is BOT.

validation_of_valid_resulttype
- the value type sequence t* is valid if and only if:
  - For all t in t*,
    - the value type t is valid.

validation_of_valid_instrtype
- the instruction type (t_1* ->_ x* ++ t_2*) is valid if and only if:
  - |x*| is |lct*|.
  - For all x in x*,
    - |C.LOCALS| is greater than x.
  - the value type sequence t_1* is valid.
  - the value type sequence t_2* is valid.
  - For all lct in lct* and x in x*,
    - C.LOCALS[x] is lct.

validation_of_valid_packtype
- the packed type packtype is valid.

validation_of_valid_storagetype
- the storage type stora_u0 is valid if and only if:
  - Either:
    - stora_u0 is valtype.
    - the value type valtype is valid.
  - Or:
    - stora_u0 is packtype.
    - the packed type packtype is valid.

validation_of_valid_fieldtype
- the field type ((MUT ()?), storagetype) is valid if and only if:
  - the storage type storagetype is valid.

validation_of_valid_functype
- the function type (t_1* -> t_2*) is valid if and only if:
  - the value type sequence t_1* is valid.
  - the value type sequence t_2* is valid.

validation_of_valid_comptype
- the composite type compt_u0 is valid if and only if:
  - Either:
    - compt_u0 is (STRUCT fieldtype*).
    - For all fieldtype in fieldtype*,
      - the field type fieldtype is valid.
  - Or:
    - compt_u0 is (ARRAY fieldtype).
    - the field type fieldtype is valid.
  - Or:
    - compt_u0 is (FUNC functype).
    - the function type functype is valid.

validation_of_matching_packtype
- the packed type packtype matches the packed type packtype.

validation_of_matching_numtype
- the number type numtype matches the number type numtype.

validation_of_matching_deftype
- the defined type deftype_1 matches the defined type deftype_2 if and only if:
  - Either:
    - $clos_deftype(C, deftype_1) is $clos_deftype(C, deftype_2).
  - Or:
    - |typeuse*| is greater than i.
    - $unrolldt(deftype_1) is (SUB fin typeuse* ct).
    - the type use typeuse*[i] matches the heap type deftype_2.

validation_of_matching_heaptype
- the heap type heapt_u0 matches the heap type heapt_u1 if and only if:
  - Either:
    - heapt_u0 is heaptype.
    - heapt_u1 is heaptype.
  - Or:
    - heapt_u0 is heaptype_1.
    - heapt_u1 is heaptype_2.
    - the heap type heaptype' is valid.
    - the heap type heaptype_1 matches the heap type heaptype'.
    - the heap type heaptype' matches the heap type heaptype_2.
  - Or:
    - heapt_u0 is EQ.
    - heapt_u1 is ANY.
  - Or:
    - heapt_u0 is I31.
    - heapt_u1 is EQ.
  - Or:
    - heapt_u0 is STRUCT.
    - heapt_u1 is EQ.
  - Or:
    - heapt_u0 is ARRAY.
    - heapt_u1 is EQ.
  - Or:
    - heapt_u0 is deftype.
    - heapt_u1 is STRUCT.
    - $expanddt(deftype) is (STRUCT fieldtype*).
  - Or:
    - heapt_u0 is deftype.
    - heapt_u1 is ARRAY.
    - $expanddt(deftype) is (ARRAY fieldtype).
  - Or:
    - heapt_u0 is deftype.
    - heapt_u1 is FUNC.
    - $expanddt(deftype) is (FUNC functype).
  - Or:
    - heapt_u0 is deftype_1.
    - heapt_u1 is deftype_2.
    - the defined type deftype_1 matches the defined type deftype_2.
  - Or:
    - heapt_u0 is (_IDX typeidx).
    - heapt_u1 is heaptype.
    - |C.TYPES| is greater than typeidx.
    - the defined type C.TYPES[typeidx] matches the heap type heaptype.
  - Or:
    - heapt_u0 is heaptype.
    - heapt_u1 is (_IDX typeidx).
    - |C.TYPES| is greater than typeidx.
    - the heap type heaptype matches the defined type C.TYPES[typeidx].
  - Or:
    - heapt_u0 is (REC i).
    - heapt_u1 is typeuse*[j].
    - |C.RECS| is greater than i.
    - |typeuse*| is greater than j.
    - C.RECS[i] is (SUB fin typeuse* ct).
  - Or:
    - heapt_u0 is NONE.
    - heapt_u1 is heaptype.
    - the heap type heaptype matches the heap type ANY.
  - Or:
    - heapt_u0 is NOFUNC.
    - heapt_u1 is heaptype.
    - the heap type heaptype matches the heap type FUNC.
  - Or:
    - heapt_u0 is NOEXTERN.
    - heapt_u1 is heaptype.
    - the heap type heaptype matches the heap type EXTERN.
  - Or:
    - heapt_u0 is BOT.
    - heapt_u1 is heaptype.

validation_of_matching_reftype
- the reference type (REF (NULL _u0?) ht_1) matches the reference type (REF (NULL _u1?) ht_2) if and only if:
  - Either:
    - _u0? is ?().
    - _u1? is ?().
    - the heap type ht_1 matches the heap type ht_2.
  - Or:
    - _u0? is ()?.
    - _u1? is ?(()).
    - the heap type ht_1 matches the heap type ht_2.

validation_of_matching_vectype
- the vector type vectype matches the vector type vectype.

validation_of_matching_valtype
- the value type valty_u0 matches the value type valty_u1 if and only if:
  - Either:
    - valty_u0 is numtype_1.
    - valty_u1 is numtype_2.
    - the number type numtype_1 matches the number type numtype_2.
  - Or:
    - valty_u0 is vectype_1.
    - valty_u1 is vectype_2.
    - the vector type vectype_1 matches the vector type vectype_2.
  - Or:
    - valty_u0 is reftype_1.
    - valty_u1 is reftype_2.
    - the reference type reftype_1 matches the reference type reftype_2.
  - Or:
    - valty_u0 is BOT.
    - valty_u1 is valtype.

validation_of_matching_storagetype
- the storage type stora_u0 matches the storage type stora_u1 if and only if:
  - Either:
    - stora_u0 is valtype_1.
    - stora_u1 is valtype_2.
    - the value type valtype_1 matches the value type valtype_2.
  - Or:
    - stora_u0 is packtype_1.
    - stora_u1 is packtype_2.
    - the packed type packtype_1 matches the packed type packtype_2.

validation_of_matching_fieldtype
- the field type ((MUT _u0?), zt_1) matches the field type ((MUT _u1?), zt_2) if and only if:
  - Either:
    - _u0? is ?().
    - _u1? is ?().
    - the storage type zt_1 matches the storage type zt_2.
  - Or:
    - _u0? is ?(()).
    - _u1? is ?(()).
    - the storage type zt_1 matches the storage type zt_2.
    - the storage type zt_2 matches the storage type zt_1.

validation_of_matching_valtype*
- the value type sequence t_1* matches the value type sequence t_2* if and only if:
  - |t_2*| is |t_1*|.
  - For all t_1 in t_1* and t_2 in t_2*,
    - the value type t_1 matches the value type t_2.

validation_of_matching_functype
- the function type (t_11* -> t_12*) matches the function type (t_21* -> t_22*) if and only if:
  - the value type sequence t_21* matches the value type sequence t_11*.
  - the value type sequence t_12* matches the value type sequence t_22*.

validation_of_matching_comptype
- the composite type compt_u0 matches the composite type compt_u1 if and only if:
  - Either:
    - compt_u0 is (STRUCT yt_1* ++ [yt'_1]).
    - compt_u1 is (STRUCT yt_2*).
    - |yt_2*| is |yt_1*|.
    - For all yt_1 in yt_1* and yt_2 in yt_2*,
      - the field type yt_1 matches the field type yt_2.
  - Or:
    - compt_u0 is (ARRAY yt_1).
    - compt_u1 is (ARRAY yt_2).
    - the field type yt_1 matches the field type yt_2.
  - Or:
    - compt_u0 is (FUNC ft_1).
    - compt_u1 is (FUNC ft_2).
    - the function type ft_1 matches the function type ft_2.

validation_of_valid_subtype
- the sub type (SUB (FINAL ()?) $idx(typeidx)* comptype) is valid with the oktypeidx (OK x_0) if and only if:
  - |x*| is |comptype'*|.
  - |x'**| is |comptype'*|.
  - For all x in x*,
    - |C.TYPES| is greater than x.
  - |x*| is less than or equal to 1.
  - For all x in x*,
    - x is less than x_0.
  - For all comptype' in comptype'* and x in x* and x' in x'*,
    - $unrolldt(C.TYPES[x]) is (SUB (FINAL ?()) $idx(x')* comptype').
  - the composite type comptype is valid.
  - For all comptype' in comptype'*,
    - the composite type comptype matches the composite type comptype'.

validation_of_valid_subtype
- the sub type (SUB (FINAL ()?) typeuse* compttype) is valid with the oktypeidxnat (OK x i) if and only if:
  - |typeuse*| is |comptype'*|.
  - |typeuse'**| is |comptype'*|.
  - |typeuse*| is less than or equal to 1.
  - For all typeuse in typeuse*,
    - Yet: $before(typeuse, x, i)
  - For all comptype' in comptype'* and typeuse in typeuse* and typeuse' in typeuse'*,
    - $unrollht(C, typeuse) is (SUB (FINAL ?()) typeuse'* comptype').
  - the composite type comptype is valid.
  - For all comptype' in comptype'*,
    - the composite type comptype matches the composite type comptype'.

validation_of_valid_rectype
- the recursive type (REC subty_u0*) is valid with the oktypeidxnat (OK x i) if and only if:
  - Either:
    - subty_u0* is [].
  - Or:
    - subty_u0* is [subtype_1] ++ subtype*.
    - the sub type subtype_1 is valid with the oktypeidxnat (OK x i).
    - the recursive type (REC subtype*) is valid with the oktypeidxnat (OK (x + 1) (i + 1)).

validation_of_valid_rectype
- the recursive type (REC subty_u0*) is valid with the oktypeidx (OK x) if and only if:
  - Either:
    - subty_u0* is [].
  - Or:
    - subty_u0* is [subtype_1] ++ subtype*.
    - the sub type subtype_1 is valid with the oktypeidx (OK x).
    - the recursive type (REC subtype*) is valid with the oktypeidx (OK (x + 1)).
  - Or:
    - subty_u0* is subtype*.
    - Under the context C with .RECS prepended by subtype*, the recursive type (REC subtype*) is valid with the oktypeidxnat (OK x 0).

validation_of_valid_deftype
- the defined type (DEF rectype i) is valid if and only if:
  - the recursive type rectype is valid with the oktypeidx (OK x).
  - rectype is (REC subtype^n).
  - i is less than n.

validation_of_valid_limits
- the limits (n, m) is valid with the nat k if and only if:
  - n is less than or equal to m.
  - m is less than or equal to k.

validation_of_valid_globaltype
- the global type ((MUT ()?), t) is valid if and only if:
  - the value type t is valid.

validation_of_valid_tabletype
- the table type (limits, reftype) is valid if and only if:
  - the limits limits is valid with the nat ((2 ^ 32) - 1).
  - the reference type reftype is valid.

validation_of_valid_memtype
- the memory type (PAGE limits) is valid if and only if:
  - the limits limits is valid with the nat (2 ^ 16).

validation_of_valid_externtype
- the external type exter_u0 is valid if and only if:
  - Either:
    - exter_u0 is (FUNC deftype).
    - the defined type deftype is valid.
    - $expanddt(deftype) is (FUNC functype).
  - Or:
    - exter_u0 is (GLOBAL globaltype).
    - the global type globaltype is valid.
  - Or:
    - exter_u0 is (TABLE tabletype).
    - the table type tabletype is valid.
  - Or:
    - exter_u0 is (MEM memtype).
    - the memory type memtype is valid.

validation_of_matching_instrtype
- the instruction type (t_11* ->_ x_1* ++ t_12*) matches the instruction type (t_21* ->_ x_2* ++ t_22*) if and only if:
  - |x*| is |t*|.
  - For all x in x*,
    - |C.LOCALS| is greater than x.
  - the value type sequence t_21* matches the value type sequence t_11*.
  - the value type sequence t_12* matches the value type sequence t_22*.
  - x* is $setminus_(x_2*, x_1*).
  - For all t in t* and x in x*,
    - C.LOCALS[x] is (SET, t).

validation_of_matching_limits
- the limits (n_1, m_1) matches the limits (n_2, m_2) if and only if:
  - n_1 is greater than or equal to n_2.
  - m_1 is less than or equal to m_2.

validation_of_matching_globaltype
- the global type ((MUT _u0?), valtype_1) matches the global type ((MUT _u1?), valtype_2) if and only if:
  - Either:
    - _u0? is ?().
    - _u1? is ?().
    - the value type valtype_1 matches the value type valtype_2.
  - Or:
    - _u0? is ?(()).
    - _u1? is ?(()).
    - the value type valtype_1 matches the value type valtype_2.
    - the value type valtype_2 matches the value type valtype_1.

validation_of_matching_tabletype
- the table type (limits_1, reftype_1) matches the table type (limits_2, reftype_2) if and only if:
  - the limits limits_1 matches the limits limits_2.
  - the reference type reftype_1 matches the reference type reftype_2.
  - the reference type reftype_2 matches the reference type reftype_1.

validation_of_matching_memtype
- the memory type (PAGE limits_1) matches the memory type (PAGE limits_2) if and only if:
  - the limits limits_1 matches the limits limits_2.

validation_of_matching_externtype
- the external type exter_u0 matches the external type exter_u1 if and only if:
  - Either:
    - exter_u0 is (FUNC deftype_1).
    - exter_u1 is (FUNC deftype_2).
    - the defined type deftype_1 matches the defined type deftype_2.
  - Or:
    - exter_u0 is (GLOBAL globaltype_1).
    - exter_u1 is (GLOBAL globaltype_2).
    - the global type globaltype_1 matches the global type globaltype_2.
  - Or:
    - exter_u0 is (TABLE tabletype_1).
    - exter_u1 is (TABLE tabletype_2).
    - the table type tabletype_1 matches the table type tabletype_2.
  - Or:
    - exter_u0 is (MEM memtype_1).
    - exter_u1 is (MEM memtype_2).
    - the memory type memtype_1 matches the memory type memtype_2.

validation_of_valid_blocktype
- the block type block_u0 is valid with the instruction type (valty_u1* ->_ [] ++ valty_u2*) if and only if:
  - Either:
    - block_u0 is (_RESULT valtype?).
    - valty_u1* is [].
    - valty_u2* is valtype?.
    - If valtype is defined,
      - the value type valtype is valid.
  - Or:
    - block_u0 is (_IDX typeidx).
    - valty_u1* is t_1*.
    - valty_u2* is t_2*.
    - |C.TYPES| is greater than typeidx.
    - $expanddt(C.TYPES[typeidx]) is (FUNC (t_1* -> t_2*)).

validation_of_NOP
- the instr NOP is valid with the instruction type ([] ->_ [] ++ []).

validation_of_UNREACHABLE
- the instr UNREACHABLE is valid with the instruction type (t_1* ->_ [] ++ t_2*) if and only if:
  - the instruction type (t_1* ->_ [] ++ t_2*) is valid.

validation_of_DROP
- the instr DROP is valid with the instruction type ([t] ->_ [] ++ []) if and only if:
  - the value type t is valid.

validation_of_SELECT
- the instr (SELECT ?([t])) is valid with the instruction type ([t, t, I32] ->_ [] ++ [t]) if and only if:
  - the value type t is valid.

validation_of_BLOCK
- the instr (BLOCK bt instr*) is valid with the instruction type (t_1* ->_ [] ++ t_2*) if and only if:
  - the block type bt is valid with the instruction type (t_1* ->_ [] ++ t_2*).
  - Under the context C with .LABELS prepended by [t_2*], the instr sequence instr* is valid with the instruction type (t_1* ->_ x* ++ t_2*).

validation_of_LOOP
- the instr (LOOP bt instr*) is valid with the instruction type (t_1* ->_ [] ++ t_2*) if and only if:
  - the block type bt is valid with the instruction type (t_1* ->_ [] ++ t_2*).
  - Under the context C with .LABELS prepended by [t_1*], the instr sequence instr* is valid with the instruction type (t_1* ->_ x* ++ t_2*).

validation_of_IF
- the instr (IF bt instr_1* instr_2*) is valid with the instruction type (t_1* ++ [I32] ->_ [] ++ t_2*) if and only if:
  - the block type bt is valid with the instruction type (t_1* ->_ [] ++ t_2*).
  - Under the context C with .LABELS prepended by [t_2*], the instr sequence instr_1* is valid with the instruction type (t_1* ->_ x_1* ++ t_2*).
  - Under the context C with .LABELS prepended by [t_2*], the instr sequence instr_2* is valid with the instruction type (t_1* ->_ x_2* ++ t_2*).

validation_of_BR
- the instr (BR l) is valid with the instruction type (t_1* ++ t* ->_ [] ++ t_2*) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t*.
  - the instruction type (t_1* ->_ [] ++ t_2*) is valid.

validation_of_BR_IF
- the instr (BR_IF l) is valid with the instruction type (t* ++ [I32] ->_ [] ++ t*) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t*.

validation_of_BR_TABLE
- the instr (BR_TABLE l* l') is valid with the instruction type (t_1* ++ t* ->_ [] ++ t_2*) if and only if:
  - For all l in l*,
    - |C.LABELS| is greater than l.
  - |C.LABELS| is greater than l'.
  - For all l in l*,
    - the value type sequence t* matches the result type C.LABELS[l].
  - the value type sequence t* matches the result type C.LABELS[l'].
  - the instruction type (t_1* ->_ [] ++ t_2*) is valid.

validation_of_BR_ON_NULL
- the instr (BR_ON_NULL l) is valid with the instruction type (t* ++ [(REF (NULL ?(())) ht)] ->_ [] ++ t* ++ [(REF (NULL ?()) ht)]) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t*.
  - the heap type ht is valid.

validation_of_BR_ON_NON_NULL
- the instr (BR_ON_NON_NULL l) is valid with the instruction type (t* ++ [(REF (NULL ?(())) ht)] ->_ [] ++ t*) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t* ++ [(REF (NULL ?()) ht)].

validation_of_BR_ON_CAST
- the instr (BR_ON_CAST l rt_1 rt_2) is valid with the instruction type (t* ++ [rt_1] ->_ [] ++ t* ++ [$diffrt(rt_1, rt_2)]) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t* ++ [rt].
  - the reference type rt_1 is valid.
  - the reference type rt_2 is valid.
  - the reference type rt_2 matches the reference type rt_1.
  - the reference type rt_2 matches the reference type rt.

validation_of_BR_ON_CAST_FAIL
- the instr (BR_ON_CAST_FAIL l rt_1 rt_2) is valid with the instruction type (t* ++ [rt_1] ->_ [] ++ t* ++ [rt_2]) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t* ++ [rt].
  - the reference type rt_1 is valid.
  - the reference type rt_2 is valid.
  - the reference type rt_2 matches the reference type rt_1.
  - the reference type $diffrt(rt_1, rt_2) matches the reference type rt.

validation_of_CALL
- the instr (CALL x) is valid with the instruction type (t_1* ->_ [] ++ t_2*) if and only if:
  - |C.FUNCS| is greater than x.
  - $expanddt(C.FUNCS[x]) is (FUNC (t_1* -> t_2*)).

validation_of_CALL_REF
- the instr (CALL_REF $idx(x)) is valid with the instruction type (t_1* ++ [(REF (NULL ?(())) $idx(x))] ->_ [] ++ t_2*) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (FUNC (t_1* -> t_2*)).

validation_of_CALL_INDIRECT
- the instr (CALL_INDIRECT x $idx(y)) is valid with the instruction type (t_1* ++ [I32] ->_ [] ++ t_2*) if and only if:
  - |C.TABLES| is greater than x.
  - |C.TYPES| is greater than y.
  - C.TABLES[x] is (lim, rt).
  - the reference type rt matches the reference type (REF (NULL ?(())) FUNC).
  - $expanddt(C.TYPES[y]) is (FUNC (t_1* -> t_2*)).

validation_of_RETURN
- the instr RETURN is valid with the instruction type (t_1* ++ t* ->_ [] ++ t_2*) if and only if:
  - C.RETURN is ?(t*).
  - the instruction type (t_1* ->_ [] ++ t_2*) is valid.

validation_of_RETURN_CALL
- the instr (RETURN_CALL x) is valid with the instruction type (t_3* ++ t_1* ->_ [] ++ t_4*) if and only if:
  - |C.FUNCS| is greater than x.
  - $expanddt(C.FUNCS[x]) is (FUNC (t_1* -> t_2*)).
  - C.RETURN is ?(t'_2*).
  - the value type sequence t_2* matches the value type sequence t'_2*.
  - the instruction type (t_3* ->_ [] ++ t_4*) is valid.

validation_of_RETURN_CALL_REF
- the instr (RETURN_CALL_REF $idx(x)) is valid with the instruction type (t_3* ++ t_1* ++ [(REF (NULL ?(())) $idx(x))] ->_ [] ++ t_4*) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (FUNC (t_1* -> t_2*)).
  - C.RETURN is ?(t'_2*).
  - the value type sequence t_2* matches the value type sequence t'_2*.
  - the instruction type (t_3* ->_ [] ++ t_4*) is valid.

validation_of_RETURN_CALL_INDIRECT
- the instr (RETURN_CALL_INDIRECT x $idx(y)) is valid with the instruction type (t_3* ++ t_1* ++ [I32] ->_ [] ++ t_4*) if and only if:
  - |C.TABLES| is greater than x.
  - |C.TYPES| is greater than y.
  - C.TABLES[x] is (lim, rt).
  - the reference type rt matches the reference type (REF (NULL ?(())) FUNC).
  - $expanddt(C.TYPES[y]) is (FUNC (t_1* -> t_2*)).
  - C.RETURN is ?(t'_2*).
  - the value type sequence t_2* matches the value type sequence t'_2*.
  - the instruction type (t_3* ->_ [] ++ t_4*) is valid.

validation_of_CONST
- the instr (nt.CONST c_nt) is valid with the instruction type ([] ->_ [] ++ [nt]).

validation_of_UNOP
- the instr (UNOP nt unop_nt) is valid with the instruction type ([nt] ->_ [] ++ [nt]).

validation_of_BINOP
- the instr (BINOP nt binop_nt) is valid with the instruction type ([nt, nt] ->_ [] ++ [nt]).

validation_of_TESTOP
- the instr (TESTOP nt testop_nt) is valid with the instruction type ([nt] ->_ [] ++ [I32]).

validation_of_RELOP
- the instr (RELOP nt relop_nt) is valid with the instruction type ([nt, nt] ->_ [] ++ [I32]).

validation_of_CVTOP
- the instr (CVTOP nt_1 nt_2 cvtop) is valid with the instruction type ([nt_2] ->_ [] ++ [nt_1]).

validation_of_REF.NULL
- the instr (REF.NULL ht) is valid with the instruction type ([] ->_ [] ++ [(REF (NULL ?(())) ht)]) if and only if:
  - the heap type ht is valid.

validation_of_REF.FUNC
- the instr (REF.FUNC x) is valid with the instruction type ([] ->_ [] ++ [(REF (NULL ?()) dt)]) if and only if:
  - |C.FUNCS| is greater than x.
  - |C.REFS| is greater than 0.
  - C.FUNCS[x] is dt.
  - x is contained in C.REFS.

validation_of_REF.I31
- the instr REF.I31 is valid with the instruction type ([I32] ->_ [] ++ [(REF (NULL ?()) I31)]).

validation_of_REF.IS_NULL
- the instr REF.IS_NULL is valid with the instruction type ([(REF (NULL ?(())) ht)] ->_ [] ++ [I32]) if and only if:
  - the heap type ht is valid.

validation_of_REF.AS_NON_NULL
- the instr REF.AS_NON_NULL is valid with the instruction type ([(REF (NULL ?(())) ht)] ->_ [] ++ [(REF (NULL ?()) ht)]) if and only if:
  - the heap type ht is valid.

validation_of_REF.EQ
- the instr REF.EQ is valid with the instruction type ([(REF (NULL ?(())) EQ), (REF (NULL ?(())) EQ)] ->_ [] ++ [I32]).

validation_of_REF.TEST
- the instr (REF.TEST rt) is valid with the instruction type ([rt'] ->_ [] ++ [I32]) if and only if:
  - the reference type rt is valid.
  - the reference type rt' is valid.
  - the reference type rt matches the reference type rt'.

validation_of_REF.CAST
- the instr (REF.CAST rt) is valid with the instruction type ([rt'] ->_ [] ++ [rt]) if and only if:
  - the reference type rt is valid.
  - the reference type rt' is valid.
  - the reference type rt matches the reference type rt'.

validation_of_I31.GET
- the instr (I31.GET sx) is valid with the instruction type ([(REF (NULL ?(())) I31)] ->_ [] ++ [I32]).

validation_of_STRUCT.NEW
- the instr (STRUCT.NEW x) is valid with the instruction type ($unpack(zt)* ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - |zt*| is |mut*|.
  - $expanddt(C.TYPES[x]) is (STRUCT (mut, zt)*).

validation_of_STRUCT.NEW_DEFAULT
- the instr (STRUCT.NEW_DEFAULT x) is valid with the instruction type ([] ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - |zt*| is |mut*|.
  - |zt*| is |val*|.
  - $expanddt(C.TYPES[x]) is (STRUCT (mut, zt)*).
  - For all val in val* and zt in zt*,
    - $default_($unpack(zt)) is ?(val).

validation_of_STRUCT.GET
- the instr (STRUCT.GET sx? x i) is valid with the instruction type ([(REF (NULL ?(())) $idx(x))] ->_ [] ++ [$unpack(zt)]) if and only if:
  - |C.TYPES| is greater than x.
  - |yt*| is greater than i.
  - $expanddt(C.TYPES[x]) is (STRUCT yt*).
  - yt*[i] is (mut, zt).
  - ((zt is $unpack(zt))) if and only if ((sx? is ?())).

validation_of_STRUCT.SET
- the instr (STRUCT.SET x i) is valid with the instruction type ([(REF (NULL ?(())) $idx(x)), $unpack(zt)] ->_ [] ++ []) if and only if:
  - |C.TYPES| is greater than x.
  - |yt*| is greater than i.
  - $expanddt(C.TYPES[x]) is (STRUCT yt*).
  - yt*[i] is ((MUT ?(())), zt).

validation_of_ARRAY.NEW
- the instr (ARRAY.NEW x) is valid with the instruction type ([$unpack(zt), I32] ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY (mut, zt)).

validation_of_ARRAY.NEW_DEFAULT
- the instr (ARRAY.NEW_DEFAULT x) is valid with the instruction type ([I32] ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY (mut, zt)).
  - $default_($unpack(zt)) is ?(val).

validation_of_ARRAY.NEW_FIXED
- the instr (ARRAY.NEW_FIXED x n) is valid with the instruction type ($unpack(zt)^n ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY (mut, zt)).

validation_of_ARRAY.NEW_ELEM
- the instr (ARRAY.NEW_ELEM x y) is valid with the instruction type ([I32, I32] ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - |C.ELEMS| is greater than y.
  - $expanddt(C.TYPES[x]) is (ARRAY (mut, rt)).
  - the reference type C.ELEMS[y] matches the reference type rt.

validation_of_ARRAY.NEW_DATA
- the instr (ARRAY.NEW_DATA x y) is valid with the instruction type ([I32, I32] ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - |C.DATAS| is greater than y.
  - $expanddt(C.TYPES[x]) is (ARRAY (mut, zt)).
  - Yet: (($unpack(zt) = (numtype : numtype <: valtype)) \/ ($unpack(zt) = (vectype : vectype <: valtype)))
  - C.DATAS[y] is OK.

validation_of_ARRAY.GET
- the instr (ARRAY.GET sx? x) is valid with the instruction type ([(REF (NULL ?(())) $idx(x)), I32] ->_ [] ++ [$unpack(zt)]) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY (mut, zt)).
  - ((zt is $unpack(zt))) if and only if ((sx? is ?())).

validation_of_ARRAY.SET
- the instr (ARRAY.SET x) is valid with the instruction type ([(REF (NULL ?(())) $idx(x)), I32, $unpack(zt)] ->_ [] ++ []) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY ((MUT ?(())), zt)).

validation_of_ARRAY.LEN
- the instr ARRAY.LEN is valid with the instruction type ([(REF (NULL ?(())) ARRAY)] ->_ [] ++ [I32]) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY ((MUT ?(())), zt)).

validation_of_ARRAY.FILL
- the instr (ARRAY.FILL x) is valid with the instruction type ([(REF (NULL ?(())) $idx(x)), I32, $unpack(zt), I32] ->_ [] ++ []) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY ((MUT ?(())), zt)).

validation_of_ARRAY.COPY
- the instr (ARRAY.COPY x_1 x_2) is valid with the instruction type ([(REF (NULL ?(())) $idx(x_1)), I32, (REF (NULL ?(())) $idx(x_2)), I32, I32] ->_ [] ++ []) if and only if:
  - |C.TYPES| is greater than x_1.
  - |C.TYPES| is greater than x_2.
  - $expanddt(C.TYPES[x_1]) is (ARRAY ((MUT ?(())), zt_1)).
  - $expanddt(C.TYPES[x_2]) is (ARRAY (mut, zt_2)).
  - the storage type zt_2 matches the storage type zt_1.

validation_of_ARRAY.INIT_ELEM
- the instr (ARRAY.INIT_ELEM x y) is valid with the instruction type ([(REF (NULL ?(())) $idx(x)), I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.TYPES| is greater than x.
  - |C.ELEMS| is greater than y.
  - $expanddt(C.TYPES[x]) is (ARRAY ((MUT ?(())), zt)).
  - the element type C.ELEMS[y] matches the storage type zt.

validation_of_ARRAY.INIT_DATA
- the instr (ARRAY.INIT_DATA x y) is valid with the instruction type ([(REF (NULL ?(())) $idx(x)), I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.TYPES| is greater than x.
  - |C.DATAS| is greater than y.
  - $expanddt(C.TYPES[x]) is (ARRAY ((MUT ?(())), zt)).
  - Yet: (($unpack(zt) = (numtype : numtype <: valtype)) \/ ($unpack(zt) = (vectype : vectype <: valtype)))
  - C.DATAS[y] is OK.

validation_of_EXTERN.CONVERT_ANY
- the instr EXTERN.CONVERT_ANY is valid with the instruction type ([(REF nul ANY)] ->_ [] ++ [(REF nul EXTERN)]).

validation_of_ANY.CONVERT_EXTERN
- the instr ANY.CONVERT_EXTERN is valid with the instruction type ([(REF nul EXTERN)] ->_ [] ++ [(REF nul ANY)]).

validation_of_VCONST
- the instr (V128.CONST c) is valid with the instruction type ([] ->_ [] ++ [V128]).

validation_of_VVUNOP
- the instr (VVUNOP V128 vvunop) is valid with the instruction type ([V128] ->_ [] ++ [V128]).

validation_of_VVBINOP
- the instr (VVBINOP V128 vvbinop) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VVTERNOP
- the instr (VVTERNOP V128 vvternop) is valid with the instruction type ([V128, V128, V128] ->_ [] ++ [V128]).

validation_of_VVTESTOP
- the instr (VVTESTOP V128 vvtestop) is valid with the instruction type ([V128] ->_ [] ++ [I32]).

validation_of_VUNOP
- the instr (VUNOP sh vunop) is valid with the instruction type ([V128] ->_ [] ++ [V128]).

validation_of_VBINOP
- the instr (VBINOP sh vbinop) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VTESTOP
- the instr (VTESTOP sh vtestop) is valid with the instruction type ([V128] ->_ [] ++ [I32]).

validation_of_VRELOP
- the instr (VRELOP sh vrelop) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VSHIFTOP
- the instr (VSHIFTOP sh vshiftop) is valid with the instruction type ([V128, I32] ->_ [] ++ [V128]).

validation_of_VBITMASK
- the instr (VBITMASK sh) is valid with the instruction type ([V128] ->_ [] ++ [I32]).

validation_of_VSWIZZLE
- the instr (VSWIZZLE sh) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VSHUFFLE
- the instr (VSHUFFLE sh i*) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]) if and only if:
  - For all i in i*,
    - i is less than (2 · $dim(sh)).

validation_of_VSPLAT
- the instr (VSPLAT sh) is valid with the instruction type ([$unpackshape(sh)] ->_ [] ++ [V128]).

validation_of_VEXTRACT_LANE
- the instr (VEXTRACT_LANE sh sx? i) is valid with the instruction type ([V128] ->_ [] ++ [$unpackshape(sh)]) if and only if:
  - i is less than $dim(sh).

validation_of_VREPLACE_LANE
- the instr (VREPLACE_LANE sh i) is valid with the instruction type ([V128, $unpackshape(sh)] ->_ [] ++ [V128]) if and only if:
  - i is less than $dim(sh).

validation_of_VEXTUNOP
- the instr (VEXTUNOP sh_1 sh_2 vextunop) is valid with the instruction type ([V128] ->_ [] ++ [V128]).

validation_of_VEXTBINOP
- the instr (VEXTBINOP sh_1 sh_2 vextbinop) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VNARROW
- the instr (VNARROW sh_1 sh_2 sx) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VCVTOP
- the instr (VCVTOP sh_1 sh_2 vcvtop half? sx? zero?) is valid with the instruction type ([V128] ->_ [] ++ [V128]).

validation_of_LOCAL.GET
- the instr (LOCAL.GET x) is valid with the instruction type ([] ->_ [] ++ [t]) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is (SET, t).

validation_of_LOCAL.SET
- the instr (LOCAL.SET x) is valid with the instruction type ([t] ->_ [x] ++ []) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is (init, t).

validation_of_LOCAL.TEE
- the instr (LOCAL.TEE x) is valid with the instruction type ([t] ->_ [x] ++ [t]) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is (init, t).

validation_of_GLOBAL.GET
- the instr (GLOBAL.GET x) is valid with the instruction type ([] ->_ [] ++ [t]) if and only if:
  - |C.GLOBALS| is greater than x.
  - C.GLOBALS[x] is (mut, t).

validation_of_GLOBAL.SET
- the instr (GLOBAL.SET x) is valid with the instruction type ([t] ->_ [] ++ []) if and only if:
  - |C.GLOBALS| is greater than x.
  - C.GLOBALS[x] is ((MUT ?(())), t).

validation_of_TABLE.GET
- the instr (TABLE.GET x) is valid with the instruction type ([I32] ->_ [] ++ [rt]) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

validation_of_TABLE.SET
- the instr (TABLE.SET x) is valid with the instruction type ([I32, rt] ->_ [] ++ []) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

validation_of_TABLE.SIZE
- the instr (TABLE.SIZE x) is valid with the instruction type ([] ->_ [] ++ [I32]) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

validation_of_TABLE.GROW
- the instr (TABLE.GROW x) is valid with the instruction type ([rt, I32] ->_ [] ++ [I32]) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

validation_of_TABLE.FILL
- the instr (TABLE.FILL x) is valid with the instruction type ([I32, rt, I32] ->_ [] ++ []) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

validation_of_TABLE.COPY
- the instr (TABLE.COPY x_1 x_2) is valid with the instruction type ([I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.TABLES| is greater than x_1.
  - |C.TABLES| is greater than x_2.
  - C.TABLES[x_1] is (lim_1, rt_1).
  - C.TABLES[x_2] is (lim_2, rt_2).
  - the reference type rt_2 matches the reference type rt_1.

validation_of_TABLE.INIT
- the instr (TABLE.INIT x y) is valid with the instruction type ([I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.TABLES| is greater than x.
  - |C.ELEMS| is greater than y.
  - C.TABLES[x] is (lim, rt_1).
  - C.ELEMS[y] is rt_2.
  - the reference type rt_2 matches the reference type rt_1.

validation_of_ELEM.DROP
- the instr (ELEM.DROP x) is valid with the instruction type ([] ->_ [] ++ []) if and only if:
  - |C.ELEMS| is greater than x.
  - C.ELEMS[x] is rt.

validation_of_MEMORY.SIZE
- the instr (MEMORY.SIZE x) is valid with the instruction type ([] ->_ [] ++ [I32]) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.

validation_of_MEMORY.GROW
- the instr (MEMORY.GROW x) is valid with the instruction type ([I32] ->_ [] ++ [I32]) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.

validation_of_MEMORY.FILL
- the instr (MEMORY.FILL x) is valid with the instruction type ([I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.

validation_of_MEMORY.COPY
- the instr (MEMORY.COPY x_1 x_2) is valid with the instruction type ([I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.MEMS| is greater than x_1.
  - |C.MEMS| is greater than x_2.
  - C.MEMS[x_1] is mt_1.
  - C.MEMS[x_2] is mt_2.

validation_of_MEMORY.INIT
- the instr (MEMORY.INIT x y) is valid with the instruction type ([I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.MEMS| is greater than x.
  - |C.DATAS| is greater than y.
  - C.MEMS[x] is mt.
  - C.DATAS[y] is OK.

validation_of_DATA.DROP
- the instr (DATA.DROP x) is valid with the instruction type ([] ->_ [] ++ []) if and only if:
  - |C.DATAS| is greater than x.
  - C.DATAS[x] is OK.

validation_of_LOAD
- the instr (LOAD nt ?() x memarg) is valid with the instruction type ([I32] ->_ [] ++ [nt]) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(nt) / 8).

validation_of_STORE
- the instr (STORE nt ?() x memarg) is valid with the instruction type ([I32, nt] ->_ [] ++ []) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(nt) / 8).

validation_of_VLOAD
- the instr (VLOAD V128 ?() x memarg) is valid with the instruction type ([I32] ->_ [] ++ [V128]) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($vsize(V128) / 8).

validation_of_VLOAD_LANE
- the instr (VLOAD_LANE V128 N x memarg i) is valid with the instruction type ([I32, V128] ->_ [] ++ [V128]) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to (N / 8).
  - i is less than (128 / N).

validation_of_VSTORE
- the instr (VSTORE V128 x memarg) is valid with the instruction type ([I32, V128] ->_ [] ++ []) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($vsize(V128) / 8).

validation_of_VSTORE_LANE
- the instr (VSTORE_LANE V128 N x memarg i) is valid with the instruction type ([I32, V128] ->_ [] ++ []) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to (N / 8).
  - i is less than (128 / N).

validation_of_valid_instr*
- the instr sequence instr_u0* is valid with the instruction type instr_u4 if and only if:
  - Either:
    - instr_u0* is [].
    - instr_u4 is ([] ->_ [] ++ []).
  - Or:
    - instr_u0* is [instr_1] ++ instr_2*.
    - instr_u4 is (t_1* ->_ x_1* ++ x_2* ++ t_3*).
    - |t*| is |init*|.
    - |x_1*| is |init*|.
    - For all x_1 in x_1*,
      - |C.LOCALS| is greater than x_1.
    - the instr instr_1 is valid with the instruction type (t_1* ->_ x_1* ++ t_2*).
    - For all init in init* and t in t* and x_1 in x_1*,
      - C.LOCALS[x_1] is (init, t).
    - Under the context $with_locals(C, x_1*, (SET, t)*), the instr sequence instr_2* is valid with the instruction type (t_2* ->_ x_2* ++ t_3*).
  - Or:
    - instr_u0* is instr*.
    - instr_u4 is it'.
    - the instr sequence instr* is valid with the instruction type it.
    - the instruction type it matches the instruction type it'.
    - the instruction type it' is valid.
  - Or:
    - instr_u0* is instr*.
    - instr_u4 is (t* ++ t_1* ->_ x* ++ t* ++ t_2*).
    - the instr sequence instr* is valid with the instruction type (t_1* ->_ x* ++ t_2*).
    - the value type sequence t* is valid.

validation_of_valid_expr
- the expression instr* is valid with the value type sequence t* if and only if:
  - the instr sequence instr* is valid with the instruction type ([] ->_ [] ++ t*).

validation_of_const_instr
- the instr instr_u0 is constant if and only if:
  - Either:
    - instr_u0 is (nt.CONST c_nt).
  - Or:
    - instr_u0 is (vt.CONST c_vt).
  - Or:
    - instr_u0 is (REF.NULL ht).
  - Or:
    - instr_u0 is REF.I31.
  - Or:
    - instr_u0 is (REF.FUNC x).
  - Or:
    - instr_u0 is (STRUCT.NEW x).
  - Or:
    - instr_u0 is (STRUCT.NEW_DEFAULT x).
  - Or:
    - instr_u0 is (ARRAY.NEW x).
  - Or:
    - instr_u0 is (ARRAY.NEW_DEFAULT x).
  - Or:
    - instr_u0 is (ARRAY.NEW_FIXED x n).
  - Or:
    - instr_u0 is ANY.CONVERT_EXTERN.
  - Or:
    - instr_u0 is EXTERN.CONVERT_ANY.
  - Or:
    - instr_u0 is (GLOBAL.GET x).
    - |C.GLOBALS| is greater than x.
    - C.GLOBALS[x] is ((MUT ?()), t).
  - Or:
    - instr_u0 is (BINOP Inn binop).
    - |[I32, I64]| is greater than 0.
    - |[ADD, SUB, MUL]| is greater than 0.
    - Inn is contained in [I32, I64].
    - binop is contained in [ADD, SUB, MUL].

validation_of_const_expr
- the expression instr* is constant if and only if:
  - For all instr in instr*,
    - the instr instr is constant.

validation_of_valid_type
- the type definition (TYPE rectype) is valid with the defined type sequence dt* if and only if:
  - |C.TYPES| is x.
  - dt* is $rolldt(x, rectype).
  - Under the context C with .TYPES appended by dt*, the recursive type rectype is valid with the oktypeidx (OK x).

validation_of_valid_local
- the local (LOCAL t) is valid with the local type (init_u0, t) if and only if:
  - Either:
    - init_u0 is SET.
    - $default_(t) is different with ?().
  - Or:
    - init_u0 is UNSET.
    - $default_(t) is ?().

validation_of_valid_func
- the function (FUNC x local* expr) is valid with the defined type C.TYPES[x] if and only if:
  - |C.TYPES| is greater than x.
  - |local*| is |lct*|.
  - $expanddt(C.TYPES[x]) is (FUNC (t_1* -> t_2*)).
  - For all lct in lct* and local in local*,
    - the local local is valid with the local type lct.
  - Under the context C with .LOCALS appended by (SET, t_1)* ++ lct* with .LABELS appended by [t_2*] with .RETURN appended by ?(t_2*), the expression expr is valid with the value type sequence t_2*.

validation_of_valid_global
- the global (GLOBAL globaltype expr) is valid with the global type globaltype if and only if:
  - the global type gt is valid.
  - globaltype is (mut, t).
  - the expression expr is valid with the value type t.
  - the expression expr is constant.

validation_of_valid_table
- the table (TABLE tabletype expr) is valid with the table type tabletype if and only if:
  - the table type tt is valid.
  - tabletype is (lim, rt).
  - the expression expr is valid with the value type rt.
  - the expression expr is constant.

validation_of_valid_mem
- the memory (MEMORY memtype) is valid with the memory type memtype if and only if:
  - the memory type memtype is valid.

validation_of_valid_elemmode
- the elemmode elemm_u0 is valid with the element type rt if and only if:
  - Either:
    - elemm_u0 is (ACTIVE x expr).
    - |C.TABLES| is greater than x.
    - C.TABLES[x] is (lim, rt').
    - the reference type rt matches the reference type rt'.
    - the expression expr is valid with the value type I32.
    - the expression expr is constant.
  - Or:
    - elemm_u0 is PASSIVE.
  - Or:
    - elemm_u0 is DECLARE.

validation_of_valid_elem
- the table segment (ELEM elemtype expr* elemmode) is valid with the element type elemtype if and only if:
  - the reference type elemtype is valid.
  - For all expr in expr*,
    - the expression expr is valid with the value type elemtype.
    - the expression expr is constant.
  - the elemmode elemmode is valid with the element type elemtype.

validation_of_valid_datamode
- the datamode datam_u0 is valid with the data type OK if and only if:
  - Either:
    - datam_u0 is (ACTIVE x expr).
    - |C.MEMS| is greater than x.
    - C.MEMS[x] is mt.
    - the expression expr is valid with the value type I32.
    - the expression expr is constant.
  - Or:
    - datam_u0 is PASSIVE.

validation_of_valid_data
- the memory segment (DATA b* datamode) is valid with the data type OK if and only if:
  - the datamode datamode is valid with the data type OK.

validation_of_valid_start
- the start function (START x) is valid if and only if:
  - |C.FUNCS| is greater than x.
  - $expanddt(C.FUNCS[x]) is (FUNC ([] -> [])).

validation_of_valid_import
- the import (IMPORT name_1 name_2 xt) is valid with the external type xt if and only if:
  - the external type xt is valid.

validation_of_valid_externidx
- the external index exter_u0 is valid with the external type exter_u1 if and only if:
  - Either:
    - exter_u0 is (FUNC x).
    - exter_u1 is (FUNC dt).
    - |C.FUNCS| is greater than x.
    - C.FUNCS[x] is dt.
  - Or:
    - exter_u0 is (GLOBAL x).
    - exter_u1 is (GLOBAL gt).
    - |C.GLOBALS| is greater than x.
    - C.GLOBALS[x] is gt.
  - Or:
    - exter_u0 is (TABLE x).
    - exter_u1 is (TABLE tt).
    - |C.TABLES| is greater than x.
    - C.TABLES[x] is tt.
  - Or:
    - exter_u0 is (MEM x).
    - exter_u1 is (MEM mt).
    - |C.MEMS| is greater than x.
    - C.MEMS[x] is mt.

validation_of_valid_export
- the export (EXPORT name externidx) is valid with the name name and the external type xt if and only if:
  - the external index externidx is valid with the external type xt.

validation_of_valid_global*
- the global sequence globa_u0* is valid with the global type sequence globa_u1* if and only if:
  - Either:
    - globa_u0* is [].
    - globa_u1* is [].
  - Or:
    - globa_u0* is [global_1] ++ global*.
    - globa_u1* is [gt_1] ++ gt*.
    - the global global is valid with the global type gt_1.
    - Under the context C with .GLOBALS appended by [gt_1], the global sequence global* is valid with the global type sequence gt*.

validation_of_valid_type*
- the type definition sequence type_u0* is valid with the defined type sequence defty_u1* if and only if:
  - Either:
    - type_u0* is [].
    - defty_u1* is [].
  - Or:
    - type_u0* is [type_1] ++ type*.
    - defty_u1* is dt_1* ++ dt*.
    - the type definition type_1 is valid with the defined type sequence dt_1*.
    - Under the context C with .TYPES appended by dt_1*, the type definition sequence type* is valid with the defined type sequence dt*.

validation_of_valid_module
- the module (MODULE type* import* func* global* table* mem* elem* data* start? export*) is valid with the module type $clos_moduletype(C, (xt_I* -> xt_E*)) if and only if:
  - |xt_I*| is |import*|.
  - |tt*| is |table*|.
  - |mt*| is |mem*|.
  - |func*| is |dt*|.
  - |rt*| is |elem*|.
  - |ok*| is |data*|.
  - |nm*| is |export*|.
  - |xt_E*| is |export*|.
  - Under the context { TYPES: []; RECS: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; RETURN: ?(); REFS: []; }, the type definition sequence type* is valid with the defined type sequence dt'*.
  - For all import in import* and xt_I in xt_I*,
    - Under the context { TYPES: dt'*; RECS: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; RETURN: ?(); REFS: []; }, the import import is valid with the external type xt_I.
  - Under the context C', the global sequence global* is valid with the global type sequence gt*.
  - For all table in table* and tt in tt*,
    - Under the context C', the table table is valid with the table type tt.
  - For all mem in mem* and mt in mt*,
    - Under the context C', the memory mem is valid with the memory type mt.
  - For all dt in dt* and func in func*,
    - the function func is valid with the defined type dt.
  - For all elem in elem* and rt in rt*,
    - the table segment elem is valid with the element type rt.
  - For all data in data* and ok in ok*,
    - the memory segment data is valid with the data type ok.
  - If start is defined,
    - the start function start is valid.
  - For all export in export* and nm in nm* and xt_E in xt_E*,
    - the export export is valid with the name nm and the external type xt_E.
  - Yet: $disjoint_(syntax name, nm*{nm : name})
  - C is { TYPES: dt'*; RECS: []; FUNCS: dt_I* ++ dt*; GLOBALS: gt_I* ++ gt*; TABLES: tt_I* ++ tt*; MEMS: mt_I* ++ mt*; ELEMS: rt*; DATAS: ok*; LOCALS: []; LABELS: []; RETURN: ?(); REFS: x*; }.
  - C' is { TYPES: dt'*; RECS: []; FUNCS: dt_I* ++ dt*; GLOBALS: gt_I*; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; RETURN: ?(); REFS: x*; }.
  - x* is $funcidx_nonfuncs(YetE (`%%%%%`_nonfuncs(global*{global : global}, table*{table : table}, mem*{mem : mem}, elem*{elem : elem}, data*{data : data}))).
  - dt_I* is $funcsxt(xt_I*).
  - gt_I* is $globalsxt(xt_I*).
  - tt_I* is $tablesxt(xt_I*).
  - mt_I* is $memsxt(xt_I*).

validation_of_valid_instr*
- the instr sequence [instr_u0] is valid with the function type (valty_u1* -> valty_u3*) if and only if:
  - Either:
    - instr_u0 is (BINOP I32 ADD).
    - valty_u1* is [I32, I32].
    - valty_u3* is [I32].
  - Or:
    - instr_u0 is (GLOBAL.GET x).
    - valty_u1* is [].
    - valty_u3* is [t].
    - |C.GLOBALS| is greater than x.
    - C.GLOBALS[x] is (mut, t).
  - Or:
    - instr_u0 is (BLOCK blocktype instr*).
    - valty_u1* is t_1*.
    - valty_u3* is t_2*.
    - the block type blocktype is valid with the instruction type (t_1* ->_ [] ++ t_2*).
    - Under the context C with .LABELS prepended by [t_2*], the instr sequence instr* is valid with the function type (t_1* -> t_2*).

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

opt_ X_u0*
1. If (X_u0* is []), then:
  a. Return ?().
2. Assert: Due to validation, (|X_u0*| is 1).
3. Let [w] be X_u0*.
4. Return ?(w).

list_ X_u0?
1. If X_u0? is not defined, then:
  a. Return [].
2. Let ?(w) be X_u0?.
3. Return [w].

concat_ X_u0*
1. If (X_u0* is []), then:
  a. Return [].
2. Let [w*] ++ w'** be X_u0*.
3. Return w* ++ $concat_(w'**).

disjoint_ X_u0*
1. If (X_u0* is []), then:
  a. Return true.
2. Let [w] ++ w'* be X_u0*.
3. Return (not w <- w'* and $disjoint_(w'*)).

setminus1_ w X_u0*
1. If (X_u0* is []), then:
  a. Return [w].
2. Let [w_1] ++ w'* be X_u0*.
3. If (w is w_1), then:
  a. Return [].
4. Let [w_1] ++ w'* be X_u0*.
5. Return $setminus1_(w, w'*).

setminus_ X_u0* w*
1. If (X_u0* is []), then:
  a. Return [].
2. Let [w_1] ++ w'* be X_u0*.
3. Return $setminus1_(w_1, w*) ++ $setminus_(w'*, w*).

setproduct2_ w_1 X_u0*
1. If (X_u0* is []), then:
  a. Return [].
2. Let [w'*] ++ w** be X_u0*.
3. Return [[w_1] ++ w'*] ++ $setproduct2_(w_1, w**).

setproduct1_ X_u0* w**
1. If (X_u0* is []), then:
  a. Return [].
2. Let [w_1] ++ w'* be X_u0*.
3. Return $setproduct2_(w_1, w**) ++ $setproduct1_(w'*, w**).

setproduct_ X_u0*
1. If (X_u0* is []), then:
  a. Return [[]].
2. Let [w_1*] ++ w** be X_u0*.
3. Return $setproduct1_(w_1*, $setproduct_(w**)).

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
1. Return (POS (SUBNORM 0)).

fone N
1. Return (POS (NORM 1 0)).

canon_ N
1. Return (2 ^ ($signif(N) - 1)).

cont b
1. Assert: Due to validation, (128 < b).
2. Assert: Due to validation, (b < 192).
3. Return (b - 128).

utf8 char_u0*
1. Let ch* be char_u0*.
2. Return $concat_($utf8([ch])*).
3. Assert: Due to validation, (|char_u0*| is 1).
4. Let [ch] be char_u0*.
5. If (ch < 128), then:
  a. Let b be ch.
  b. Return [b].
6. If ((128 ≤ ch) and ((ch < 2048) and (ch ≥ $cont(b_2)))), then:
  a. Let ((2 ^ 6) · (b_1 - 192)) be (ch - $cont(b_2)).
  b. Return [b_1, b_2].
7. If ((((2048 ≤ ch) and (ch < 55296)) or ((57344 ≤ ch) and (ch < 65536))) and (ch ≥ $cont(b_3))), then:
  a. Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · $cont(b_2))) be (ch - $cont(b_3)).
  b. Return [b_1, b_2, b_3].
8. Assert: Due to validation, (65536 ≤ ch).
9. Assert: Due to validation, (ch < 69632).
10. Assert: Due to validation, (ch ≥ $cont(b_4)).
11. Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · $cont(b_2))) + ((2 ^ 6) · $cont(b_3))) be (ch - $cont(b_4)).
12. Return [b_1, b_2, b_3, b_4].

ANYREF
1. Return (REF (NULL ?(())) ANY).

EQREF
1. Return (REF (NULL ?(())) EQ).

I31REF
1. Return (REF (NULL ?(())) I31).

STRUCTREF
1. Return (REF (NULL ?(())) STRUCT).

ARRAYREF
1. Return (REF (NULL ?(())) ARRAY).

FUNCREF
1. Return (REF (NULL ?(())) FUNC).

EXTERNREF
1. Return (REF (NULL ?(())) EXTERN).

NULLREF
1. Return (REF (NULL ?(())) NONE).

NULLFUNCREF
1. Return (REF (NULL ?(())) NOFUNC).

NULLEXTERNREF
1. Return (REF (NULL ?(())) NOEXTERN).

size numty_u0
1. If (numty_u0 is I32), then:
  a. Return 32.
2. If (numty_u0 is I64), then:
  a. Return 64.
3. If (numty_u0 is F32), then:
  a. Return 32.
4. Assert: Due to validation, (numty_u0 is F64).
5. Return 64.

vsize V128
1. Return 128.

psize packt_u0
1. If (packt_u0 is I8), then:
  a. Return 8.
2. Assert: Due to validation, (packt_u0 is I16).
3. Return 16.

lsize lanet_u0
1. If the type of lanet_u0 is numtype, then:
  a. Let numtype be lanet_u0.
  b. Return $size(numtype).
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $psize(packtype).

zsize stora_u0
1. If the type of stora_u0 is numtype, then:
  a. Let numtype be stora_u0.
  b. Return $size(numtype).
2. If the type of stora_u0 is vectype, then:
  a. Let vectype be stora_u0.
  b. Return $vsize(vectype).
3. Assert: Due to validation, the type of stora_u0 is packtype.
4. Let packtype be stora_u0.
5. Return $psize(packtype).

lanetype (Lnn X N)
1. Return Lnn.

sizenn nt
1. Return $size(nt).

sizenn1 nt
1. Return $size(nt).

sizenn2 nt
1. Return $size(nt).

psizenn pt
1. Return $psize(pt).

lsizenn lt
1. Return $lsize(lt).

lsizenn1 lt
1. Return $lsize(lt).

lsizenn2 lt
1. Return $lsize(lt).

zero numty_u0
1. If the type of numty_u0 is Inn, then:
  a. Return 0.
2. Assert: Due to validation, the type of numty_u0 is Fnn.
3. Let Fnn be numty_u0.
4. Return $fzero($size(Fnn)).

dim (Lnn X N)
1. Return N.

shsize (Lnn X N)
1. Return ($lsize(Lnn) · N).

IN N_u0
1. If (N_u0 is 32), then:
  a. Return I32.
2. Assert: Due to validation, (N_u0 is 64).
3. Return I64.

FN N_u0
1. If (N_u0 is 32), then:
  a. Return F32.
2. Assert: Due to validation, (N_u0 is 64).
3. Return F64.

JN N_u0
1. If (N_u0 is 8), then:
  a. Return I8.
2. If (N_u0 is 16), then:
  a. Return I16.
3. If (N_u0 is 32), then:
  a. Return I32.
4. Assert: Due to validation, (N_u0 is 64).
5. Return I64.

lunpack lanet_u0
1. If the type of lanet_u0 is numtype, then:
  a. Let numtype be lanet_u0.
  b. Return numtype.
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Return I32.

unpack stora_u0
1. If the type of stora_u0 is valtype, then:
  a. Let valtype be stora_u0.
  b. Return valtype.
2. Assert: Due to validation, the type of stora_u0 is packtype.
3. Return I32.

nunpack stora_u0
1. If the type of stora_u0 is numtype, then:
  a. Let numtype be stora_u0.
  b. Return numtype.
2. If the type of stora_u0 is packtype, then:
  a. Return I32.

vunpack vectype
1. Return vectype.

cunpack stora_u0
1. If the type of stora_u0 is consttype, then:
  a. Let consttype be stora_u0.
  b. Return consttype.
2. If the type of stora_u0 is packtype, then:
  a. Return I32.
3. If the type of stora_u0 is lanetype, then:
  a. Let lanetype be stora_u0.
  b. Return $lunpack(lanetype).

sx stora_u0
1. If the type of stora_u0 is consttype, then:
  a. Return ?().
2. Assert: Due to validation, the type of stora_u0 is packtype.
3. Return ?(S).

const const_u0 c
1. If the type of const_u0 is numtype, then:
  a. Let numtype be const_u0.
  b. Return (numtype.CONST c).
2. Assert: Due to validation, the type of const_u0 is vectype.
3. Let vectype be const_u0.
4. Return (vectype.CONST c).

unpackshape (Lnn X N)
1. Return $lunpack(Lnn).

diffrt (REF nul1 ht_1) (REF (NULL _u0?) ht_2)
1. If (_u0? is ?(())), then:
  a. Return (REF (NULL ?()) ht_1).
2. Assert: Due to validation, _u0? is not defined.
3. Return (REF nul1 ht_1).

idx x
1. Return (_IDX x).

free_opt free_u0?
1. If free_u0? is not defined, then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
2. Let ?(free) be free_u0?.
3. Return free.

free_list free_u0*
1. If (free_u0* is []), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
2. Return YetE (free ++ $free_list(free'*{free' : free})).

free_typeidx typeidx
1. Return { TYPES: [typeidx]; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_funcidx funcidx
1. Return { TYPES: []; FUNCS: [funcidx]; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_globalidx globalidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: [globalidx]; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_tableidx tableidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: [tableidx]; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_memidx memidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: [memidx]; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_elemidx elemidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: [elemidx]; DATAS: []; LOCALS: []; LABELS: []; }.

free_dataidx dataidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: [dataidx]; LOCALS: []; LABELS: []; }.

free_localidx localidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: [localidx]; LABELS: []; }.

free_labelidx labelidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: [labelidx]; }.

free_externidx exter_u0
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC funcidx) be exter_u0.
  b. Return $free_funcidx(funcidx).
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL globalidx) be exter_u0.
  b. Return $free_globalidx(globalidx).
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE tableidx) be exter_u0.
  b. Return $free_tableidx(tableidx).
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM memidx) be exter_u0.
6. Return $free_memidx(memidx).

free_numtype numtype
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_packtype packtype
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_lanetype lanet_u0
1. If the type of lanet_u0 is numtype, then:
  a. Let numtype be lanet_u0.
  b. Return $free_numtype(numtype).
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $free_packtype(packtype).

free_vectype vectype
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_consttype const_u0
1. If the type of const_u0 is numtype, then:
  a. Let numtype be const_u0.
  b. Return $free_numtype(numtype).
2. Assert: Due to validation, the type of const_u0 is vectype.
3. Let vectype be const_u0.
4. Return $free_vectype(vectype).

free_absheaptype absheaptype
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_rectype (REC subtype*)
1. Return $free_list($free_subtype(subtype)*).

free_deftype (DEF rectype n)
1. Return $free_rectype(rectype).

free_typeuse typeu_u0
1. If typeu_u0 is of the case _IDX, then:
  a. Let (_IDX typeidx) be typeu_u0.
  b. Return $free_typeidx(typeidx).
2. If typeu_u0 is of the case REC, then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
3. Assert: Due to validation, the type of typeu_u0 is deftype.
4. Let deftype be typeu_u0.
5. Return $free_deftype(deftype).

free_heaptype heapt_u0
1. If the type of heapt_u0 is absheaptype, then:
  a. Let absheaptype be heapt_u0.
  b. Return $free_absheaptype(absheaptype).
2. Assert: Due to validation, the type of heapt_u0 is typeuse.
3. Let typeuse be heapt_u0.
4. Return $free_typeuse(typeuse).

free_reftype (REF nul heaptype)
1. Return $free_heaptype(heaptype).

free_valtype valty_u0
1. If the type of valty_u0 is numtype, then:
  a. Let numtype be valty_u0.
  b. Return $free_numtype(numtype).
2. If the type of valty_u0 is vectype, then:
  a. Let vectype be valty_u0.
  b. Return $free_vectype(vectype).
3. If the type of valty_u0 is reftype, then:
  a. Let reftype be valty_u0.
  b. Return $free_reftype(reftype).
4. Assert: Due to validation, (valty_u0 is BOT).
5. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_resulttype valtype*
1. Return $free_list($free_valtype(valtype)*).

free_storagetype stora_u0
1. If the type of stora_u0 is valtype, then:
  a. Let valtype be stora_u0.
  b. Return $free_valtype(valtype).
2. Assert: Due to validation, the type of stora_u0 is packtype.
3. Let packtype be stora_u0.
4. Return $free_packtype(packtype).

free_fieldtype (mut, storagetype)
1. Return $free_storagetype(storagetype).

free_functype (resulttype_1 -> resulttype_2)
1. Return YetE ($free_resulttype(resulttype_1) ++ $free_resulttype(resulttype_2)).

free_structtype fieldtype*
1. Return $free_list($free_fieldtype(fieldtype)*).

free_arraytype fieldtype
1. Return $free_fieldtype(fieldtype).

free_comptype compt_u0
1. If compt_u0 is of the case STRUCT, then:
  a. Let (STRUCT structtype) be compt_u0.
  b. Return $free_structtype(structtype).
2. If compt_u0 is of the case ARRAY, then:
  a. Let (ARRAY arraytype) be compt_u0.
  b. Return $free_arraytype(arraytype).
3. Assert: Due to validation, compt_u0 is of the case FUNC.
4. Let (FUNC functype) be compt_u0.
5. Return $free_functype(functype).

free_subtype (SUB fin typeuse* comptype)
1. Return YetE ($free_list($free_typeuse(typeuse)*{typeuse : typeuse}) ++ $free_comptype(comptype)).

free_globaltype (mut, valtype)
1. Return $free_valtype(valtype).

free_tabletype (limits, reftype)
1. Return $free_reftype(reftype).

free_memtype (PAGE limits)
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_elemtype reftype
1. Return $free_reftype(reftype).

free_datatype OK
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_externtype exter_u0
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC typeuse) be exter_u0.
  b. Return $free_typeuse(typeuse).
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL globaltype) be exter_u0.
  b. Return $free_globaltype(globaltype).
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE tabletype) be exter_u0.
  b. Return $free_tabletype(tabletype).
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM memtype) be exter_u0.
6. Return $free_memtype(memtype).

free_moduletype (externtype_1* -> externtype_2*)
1. Return YetE ($free_list($free_externtype(externtype_1)*{externtype_1 : externtype}) ++ $free_list($free_externtype(externtype_2)*{externtype_2 : externtype})).

free_blocktype block_u0
1. If block_u0 is of the case _RESULT, then:
  a. Let (_RESULT valtype?) be block_u0.
  b. Return $free_opt($free_valtype(valtype)?).
2. Assert: Due to validation, block_u0 is of the case _IDX.
3. Let (_IDX funcidx) be block_u0.
4. Return $free_funcidx(funcidx).

free_shape (lanetype X dim)
1. Return $free_lanetype(lanetype).

shift_labelidxs label_u0*
1. If (label_u0* is []), then:
  a. Return [].
2. Let [nat_0] ++ labelidx'* be label_u0*.
3. If (nat_0 is 0), then:
  a. Return $shift_labelidxs(labelidx'*).
4. Let [labelidx] ++ labelidx'* be label_u0*.
5. Return [(labelidx - 1)] ++ $shift_labelidxs(labelidx'*).

free_block instr*
1. Let free be $free_list($free_instr(instr)*).
2. Return free with .LABELS replaced by $shift_labelidxs(free.LABELS).

free_instr instr_u0
1. If (instr_u0 is NOP), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
2. If (instr_u0 is UNREACHABLE), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
3. If (instr_u0 is DROP), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
4. If instr_u0 is of the case SELECT, then:
  a. Let (SELECT valtype*?) be instr_u0.
  b. Return $free_opt($free_list($free_valtype(valtype)*)?).
5. If instr_u0 is of the case BLOCK, then:
  a. Return YetE ($free_blocktype(blocktype) ++ $free_block(instr*{instr : instr})).
6. If instr_u0 is of the case LOOP, then:
  a. Return YetE ($free_blocktype(blocktype) ++ $free_block(instr*{instr : instr})).
7. If instr_u0 is of the case IF, then:
  a. Return YetE ($free_blocktype(blocktype) ++ $free_block(instr_1*{instr_1 : instr}) ++ $free_block(instr_2*{instr_2 : instr})).
8. If instr_u0 is of the case BR, then:
  a. Let (BR labelidx) be instr_u0.
  b. Return $free_labelidx(labelidx).
9. If instr_u0 is of the case BR_IF, then:
  a. Let (BR_IF labelidx) be instr_u0.
  b. Return $free_labelidx(labelidx).
10. If instr_u0 is of the case BR_TABLE, then:
  a. Return YetE ($free_list($free_labelidx(labelidx)*{}) ++ $free_labelidx(labelidx)).
11. If instr_u0 is of the case BR_ON_NULL, then:
  a. Let (BR_ON_NULL labelidx) be instr_u0.
  b. Return $free_labelidx(labelidx).
12. If instr_u0 is of the case BR_ON_NON_NULL, then:
  a. Let (BR_ON_NON_NULL labelidx) be instr_u0.
  b. Return $free_labelidx(labelidx).
13. If instr_u0 is of the case BR_ON_CAST, then:
  a. Return YetE ($free_labelidx(labelidx) ++ $free_reftype(reftype_1) ++ $free_reftype(reftype_2)).
14. If instr_u0 is of the case BR_ON_CAST_FAIL, then:
  a. Return YetE ($free_labelidx(labelidx) ++ $free_reftype(reftype_1) ++ $free_reftype(reftype_2)).
15. If instr_u0 is of the case CALL, then:
  a. Let (CALL funcidx) be instr_u0.
  b. Return $free_funcidx(funcidx).
16. If instr_u0 is of the case CALL_REF, then:
  a. Let (CALL_REF typeuse) be instr_u0.
  b. Return $free_typeuse(typeuse).
17. If instr_u0 is of the case CALL_INDIRECT, then:
  a. Return YetE ($free_tableidx(tableidx) ++ $free_typeuse(typeuse)).
18. If (instr_u0 is RETURN), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
19. If instr_u0 is of the case RETURN_CALL, then:
  a. Let (RETURN_CALL funcidx) be instr_u0.
  b. Return $free_funcidx(funcidx).
20. If instr_u0 is of the case RETURN_CALL_REF, then:
  a. Let (RETURN_CALL_REF typeuse) be instr_u0.
  b. Return $free_typeuse(typeuse).
21. If instr_u0 is of the case RETURN_CALL_INDIRECT, then:
  a. Return YetE ($free_tableidx(tableidx) ++ $free_typeuse(typeuse)).
22. If instr_u0 is of the case CONST, then:
  a. Let (numtype.CONST numlit) be instr_u0.
  b. Return $free_numtype(numtype).
23. If instr_u0 is of the case UNOP, then:
  a. Let (UNOP numtype unop) be instr_u0.
  b. Return $free_numtype(numtype).
24. If instr_u0 is of the case BINOP, then:
  a. Let (BINOP numtype binop) be instr_u0.
  b. Return $free_numtype(numtype).
25. If instr_u0 is of the case TESTOP, then:
  a. Let (TESTOP numtype testop) be instr_u0.
  b. Return $free_numtype(numtype).
26. If instr_u0 is of the case RELOP, then:
  a. Let (RELOP numtype relop) be instr_u0.
  b. Return $free_numtype(numtype).
27. If instr_u0 is of the case CVTOP, then:
  a. Return YetE ($free_numtype(numtype_1) ++ $free_numtype(numtype_2)).
28. If instr_u0 is of the case VCONST, then:
  a. Let (vectype.CONST veclit) be instr_u0.
  b. Return $free_vectype(vectype).
29. If instr_u0 is of the case VVUNOP, then:
  a. Let (VVUNOP vectype vvunop) be instr_u0.
  b. Return $free_vectype(vectype).
30. If instr_u0 is of the case VVBINOP, then:
  a. Let (VVBINOP vectype vvbinop) be instr_u0.
  b. Return $free_vectype(vectype).
31. If instr_u0 is of the case VVTERNOP, then:
  a. Let (VVTERNOP vectype vvternop) be instr_u0.
  b. Return $free_vectype(vectype).
32. If instr_u0 is of the case VVTESTOP, then:
  a. Let (VVTESTOP vectype vvtestop) be instr_u0.
  b. Return $free_vectype(vectype).
33. If instr_u0 is of the case VUNOP, then:
  a. Let (VUNOP shape vunop) be instr_u0.
  b. Return $free_shape(shape).
34. If instr_u0 is of the case VBINOP, then:
  a. Let (VBINOP shape vbinop) be instr_u0.
  b. Return $free_shape(shape).
35. If instr_u0 is of the case VTESTOP, then:
  a. Let (VTESTOP shape vtestop) be instr_u0.
  b. Return $free_shape(shape).
36. If instr_u0 is of the case VRELOP, then:
  a. Let (VRELOP shape vrelop) be instr_u0.
  b. Return $free_shape(shape).
37. If instr_u0 is of the case VSHIFTOP, then:
  a. Let (VSHIFTOP ishape vshiftop) be instr_u0.
  b. Return $free_shape(ishape).
38. If instr_u0 is of the case VBITMASK, then:
  a. Let (VBITMASK ishape) be instr_u0.
  b. Return $free_shape(ishape).
39. If instr_u0 is of the case VSWIZZLE, then:
  a. Let (VSWIZZLE ishape) be instr_u0.
  b. Return $free_shape(ishape).
40. If instr_u0 is of the case VSHUFFLE, then:
  a. Let (VSHUFFLE ishape laneidx*) be instr_u0.
  b. Return $free_shape(ishape).
41. If instr_u0 is of the case VEXTUNOP, then:
  a. Return YetE ($free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape))).
42. If instr_u0 is of the case VEXTBINOP, then:
  a. Return YetE ($free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape))).
43. If instr_u0 is of the case VNARROW, then:
  a. Return YetE ($free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape))).
44. If instr_u0 is of the case VCVTOP, then:
  a. Return YetE ($free_shape(shape_1) ++ $free_shape(shape_2)).
45. If instr_u0 is of the case VSPLAT, then:
  a. Let (VSPLAT shape) be instr_u0.
  b. Return $free_shape(shape).
46. If instr_u0 is of the case VEXTRACT_LANE, then:
  a. Let (VEXTRACT_LANE shape sx? laneidx) be instr_u0.
  b. Return $free_shape(shape).
47. If instr_u0 is of the case VREPLACE_LANE, then:
  a. Let (VREPLACE_LANE shape laneidx) be instr_u0.
  b. Return $free_shape(shape).
48. If instr_u0 is of the case REF.NULL, then:
  a. Let (REF.NULL heaptype) be instr_u0.
  b. Return $free_heaptype(heaptype).
49. If (instr_u0 is REF.IS_NULL), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
50. If (instr_u0 is REF.AS_NON_NULL), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
51. If (instr_u0 is REF.EQ), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
52. If instr_u0 is of the case REF.TEST, then:
  a. Let (REF.TEST reftype) be instr_u0.
  b. Return $free_reftype(reftype).
53. If instr_u0 is of the case REF.CAST, then:
  a. Let (REF.CAST reftype) be instr_u0.
  b. Return $free_reftype(reftype).
54. If instr_u0 is of the case REF.FUNC, then:
  a. Let (REF.FUNC funcidx) be instr_u0.
  b. Return $free_funcidx(funcidx).
55. If (instr_u0 is REF.I31), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
56. If instr_u0 is of the case I31.GET, then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
57. If instr_u0 is of the case STRUCT.NEW, then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
58. If instr_u0 is of the case STRUCT.NEW_DEFAULT, then:
  a. Let (STRUCT.NEW_DEFAULT typeidx) be instr_u0.
  b. Return $free_typeidx(typeidx).
59. If instr_u0 is of the case STRUCT.GET, then:
  a. Let (STRUCT.GET sx? typeidx u32) be instr_u0.
  b. Return $free_typeidx(typeidx).
60. If instr_u0 is of the case STRUCT.SET, then:
  a. Let (STRUCT.SET typeidx u32) be instr_u0.
  b. Return $free_typeidx(typeidx).
61. If instr_u0 is of the case ARRAY.NEW, then:
  a. Let (ARRAY.NEW typeidx) be instr_u0.
  b. Return $free_typeidx(typeidx).
62. If instr_u0 is of the case ARRAY.NEW_DEFAULT, then:
  a. Let (ARRAY.NEW_DEFAULT typeidx) be instr_u0.
  b. Return $free_typeidx(typeidx).
63. If instr_u0 is of the case ARRAY.NEW_FIXED, then:
  a. Let (ARRAY.NEW_FIXED typeidx u32) be instr_u0.
  b. Return $free_typeidx(typeidx).
64. If instr_u0 is of the case ARRAY.NEW_DATA, then:
  a. Return YetE ($free_typeidx(typeidx) ++ $free_dataidx(dataidx)).
65. If instr_u0 is of the case ARRAY.NEW_ELEM, then:
  a. Return YetE ($free_typeidx(typeidx) ++ $free_elemidx(elemidx)).
66. If instr_u0 is of the case ARRAY.GET, then:
  a. Let (ARRAY.GET sx? typeidx) be instr_u0.
  b. Return $free_typeidx(typeidx).
67. If instr_u0 is of the case ARRAY.SET, then:
  a. Let (ARRAY.SET typeidx) be instr_u0.
  b. Return $free_typeidx(typeidx).
68. If (instr_u0 is ARRAY.LEN), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
69. If instr_u0 is of the case ARRAY.FILL, then:
  a. Let (ARRAY.FILL typeidx) be instr_u0.
  b. Return $free_typeidx(typeidx).
70. If instr_u0 is of the case ARRAY.COPY, then:
  a. Return YetE ($free_typeidx(typeidx_1) ++ $free_typeidx(typeidx_2)).
71. If instr_u0 is of the case ARRAY.INIT_DATA, then:
  a. Return YetE ($free_typeidx(typeidx) ++ $free_dataidx(dataidx)).
72. If instr_u0 is of the case ARRAY.INIT_ELEM, then:
  a. Return YetE ($free_typeidx(typeidx) ++ $free_elemidx(elemidx)).
73. If (instr_u0 is EXTERN.CONVERT_ANY), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
74. If (instr_u0 is ANY.CONVERT_EXTERN), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
75. If instr_u0 is of the case LOCAL.GET, then:
  a. Let (LOCAL.GET localidx) be instr_u0.
  b. Return $free_localidx(localidx).
76. If instr_u0 is of the case LOCAL.SET, then:
  a. Let (LOCAL.SET localidx) be instr_u0.
  b. Return $free_localidx(localidx).
77. If instr_u0 is of the case LOCAL.TEE, then:
  a. Let (LOCAL.TEE localidx) be instr_u0.
  b. Return $free_localidx(localidx).
78. If instr_u0 is of the case GLOBAL.GET, then:
  a. Let (GLOBAL.GET globalidx) be instr_u0.
  b. Return $free_globalidx(globalidx).
79. If instr_u0 is of the case GLOBAL.SET, then:
  a. Let (GLOBAL.SET globalidx) be instr_u0.
  b. Return $free_globalidx(globalidx).
80. If instr_u0 is of the case TABLE.GET, then:
  a. Let (TABLE.GET tableidx) be instr_u0.
  b. Return $free_tableidx(tableidx).
81. If instr_u0 is of the case TABLE.SET, then:
  a. Let (TABLE.SET tableidx) be instr_u0.
  b. Return $free_tableidx(tableidx).
82. If instr_u0 is of the case TABLE.SIZE, then:
  a. Let (TABLE.SIZE tableidx) be instr_u0.
  b. Return $free_tableidx(tableidx).
83. If instr_u0 is of the case TABLE.GROW, then:
  a. Let (TABLE.GROW tableidx) be instr_u0.
  b. Return $free_tableidx(tableidx).
84. If instr_u0 is of the case TABLE.FILL, then:
  a. Let (TABLE.FILL tableidx) be instr_u0.
  b. Return $free_tableidx(tableidx).
85. If instr_u0 is of the case TABLE.COPY, then:
  a. Return YetE ($free_tableidx(tableidx_1) ++ $free_tableidx(tableidx_2)).
86. If instr_u0 is of the case TABLE.INIT, then:
  a. Return YetE ($free_tableidx(tableidx) ++ $free_elemidx(elemidx)).
87. If instr_u0 is of the case ELEM.DROP, then:
  a. Let (ELEM.DROP elemidx) be instr_u0.
  b. Return $free_elemidx(elemidx).
88. If instr_u0 is of the case LOAD, then:
  a. Let (LOAD numtype loadop__0 memidx memarg) be instr_u0.
  b. If loadop__0 is defined, then:
    1) Return YetE ($free_numtype(numtype) ++ $free_memidx(memidx)).
89. If instr_u0 is of the case STORE, then:
  a. Return YetE ($free_numtype(numtype) ++ $free_memidx(memidx)).
90. If instr_u0 is of the case VLOAD, then:
  a. Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx)).
91. If instr_u0 is of the case VLOAD_LANE, then:
  a. Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx)).
92. If instr_u0 is of the case VSTORE, then:
  a. Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx)).
93. If instr_u0 is of the case VSTORE_LANE, then:
  a. Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx)).
94. If instr_u0 is of the case MEMORY.SIZE, then:
  a. Let (MEMORY.SIZE memidx) be instr_u0.
  b. Return $free_memidx(memidx).
95. If instr_u0 is of the case MEMORY.GROW, then:
  a. Let (MEMORY.GROW memidx) be instr_u0.
  b. Return $free_memidx(memidx).
96. If instr_u0 is of the case MEMORY.FILL, then:
  a. Let (MEMORY.FILL memidx) be instr_u0.
  b. Return $free_memidx(memidx).
97. If instr_u0 is of the case MEMORY.COPY, then:
  a. Return YetE ($free_memidx(memidx_1) ++ $free_memidx(memidx_2)).
98. If instr_u0 is of the case MEMORY.INIT, then:
  a. Return YetE ($free_memidx(memidx) ++ $free_dataidx(dataidx)).
99. Assert: Due to validation, instr_u0 is of the case DATA.DROP.
100. Let (DATA.DROP dataidx) be instr_u0.
101. Return $free_dataidx(dataidx).

free_expr instr*
1. Return $free_list($free_instr(instr)*).

free_type (TYPE rectype)
1. Return $free_rectype(rectype).

free_local (LOCAL t)
1. Return $free_valtype(t).

free_func (FUNC typeidx local* expr)
1. Return YetE ($free_typeidx(typeidx) ++ $free_list($free_local(local)*{local : local}) ++ $free_block(expr)[LOCALS_free = []]).

free_global (GLOBAL globaltype expr)
1. Return YetE ($free_globaltype(globaltype) ++ $free_expr(expr)).

free_table (TABLE tabletype expr)
1. Return YetE ($free_tabletype(tabletype) ++ $free_expr(expr)).

free_mem (MEMORY memtype)
1. Return $free_memtype(memtype).

free_elemmode elemm_u0
1. If elemm_u0 is of the case ACTIVE, then:
  a. Return YetE ($free_tableidx(tableidx) ++ $free_expr(expr)).
2. If (elemm_u0 is PASSIVE), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
3. Assert: Due to validation, (elemm_u0 is DECLARE).
4. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_datamode datam_u0
1. If datam_u0 is of the case ACTIVE, then:
  a. Return YetE ($free_memidx(memidx) ++ $free_expr(expr)).
2. Assert: Due to validation, (datam_u0 is PASSIVE).
3. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_elem (ELEM reftype expr* elemmode)
1. Return YetE ($free_reftype(reftype) ++ $free_list($free_expr(expr)*{expr : expr}) ++ $free_elemmode(elemmode)).

free_data (DATA byte* datamode)
1. Return $free_datamode(datamode).

free_start (START funcidx)
1. Return $free_funcidx(funcidx).

free_export (EXPORT name externidx)
1. Return $free_externidx(externidx).

free_import (IMPORT name_1 name_2 externtype)
1. Return $free_externtype(externtype).

free_module (MODULE type* import* func* global* table* mem* elem* data* start? export*)
1. Return YetE ($free_list($free_type(type)*{type : type}) ++ $free_list($free_import(import)*{import : import}) ++ $free_list($free_func(func)*{func : func}) ++ $free_list($free_global(global)*{global : global}) ++ $free_list($free_table(table)*{table : table}) ++ $free_list($free_mem(mem)*{mem : mem}) ++ $free_list($free_elem(elem)*{elem : elem}) ++ $free_list($free_data(data)*{data : data}) ++ $free_opt($free_start(start)?{start : start}) ++ $free_list($free_export(export)*{export : export})).

funcidx_module module
1. Return $free_module(module).FUNCS.

dataidx_funcs func*
1. Return $free_list($free_func(func)*).DATAS.

subst_typevar tv typev_u0* typeu_u1*
1. If ((typev_u0* is []) and (typeu_u1* is [])), then:
  a. Return tv.
2. Assert: Due to validation, (|typeu_u1*| ≥ 1).
3. Let [tu_1] ++ tu'* be typeu_u1*.
4. If (|typev_u0*| ≥ 1), then:
  a. Let [tv_1] ++ tv'* be typev_u0*.
  b. If (tv is tv_1), then:
    1) Return tu_1.
5. Let [tu_1] ++ tu'* be typeu_u1*.
6. Assert: Due to validation, (|typev_u0*| ≥ 1).
7. Let [tv_1] ++ tv'* be typev_u0*.
8. Return $subst_typevar(tv, tv'*, tu'*).

subst_packtype pt tv* tu*
1. Return pt.

subst_numtype nt tv* tu*
1. Return nt.

subst_vectype vt tv* tu*
1. Return vt.

subst_typeuse typeu_u0 tv* tu*
1. If the type of typeu_u0 is typevar, then:
  a. Let tv' be typeu_u0.
  b. Return $subst_typevar(tv', tv*, tu*).
2. Assert: Due to validation, the type of typeu_u0 is deftype.
3. Let dt be typeu_u0.
4. Return $subst_deftype(dt, tv*, tu*).

subst_heaptype heapt_u0 tv* tu*
1. If the type of heapt_u0 is typevar, then:
  a. Let tv' be heapt_u0.
  b. Return $subst_typevar(tv', tv*, tu*).
2. If the type of heapt_u0 is deftype, then:
  a. Let dt be heapt_u0.
  b. Return $subst_deftype(dt, tv*, tu*).
3. Let ht be heapt_u0.
4. Return ht.

subst_reftype (REF nul ht) tv* tu*
1. Return (REF nul $subst_heaptype(ht, tv*, tu*)).

subst_valtype valty_u0 tv* tu*
1. If the type of valty_u0 is numtype, then:
  a. Let nt be valty_u0.
  b. Return $subst_numtype(nt, tv*, tu*).
2. If the type of valty_u0 is vectype, then:
  a. Let vt be valty_u0.
  b. Return $subst_vectype(vt, tv*, tu*).
3. If the type of valty_u0 is reftype, then:
  a. Let rt be valty_u0.
  b. Return $subst_reftype(rt, tv*, tu*).
4. Assert: Due to validation, (valty_u0 is BOT).
5. Return BOT.

subst_storagetype stora_u0 tv* tu*
1. If the type of stora_u0 is valtype, then:
  a. Let t be stora_u0.
  b. Return $subst_valtype(t, tv*, tu*).
2. Assert: Due to validation, the type of stora_u0 is packtype.
3. Let pt be stora_u0.
4. Return $subst_packtype(pt, tv*, tu*).

subst_fieldtype (mut, zt) tv* tu*
1. Return (mut, $subst_storagetype(zt, tv*, tu*)).

subst_comptype compt_u0 tv* tu*
1. If compt_u0 is of the case STRUCT, then:
  a. Let (STRUCT yt*) be compt_u0.
  b. Return (STRUCT $subst_fieldtype(yt, tv*, tu*)*).
2. If compt_u0 is of the case ARRAY, then:
  a. Let (ARRAY yt) be compt_u0.
  b. Return (ARRAY $subst_fieldtype(yt, tv*, tu*)).
3. Assert: Due to validation, compt_u0 is of the case FUNC.
4. Let (FUNC ft) be compt_u0.
5. Return (FUNC $subst_functype(ft, tv*, tu*)).

subst_subtype (SUB fin tu'* ct) tv* tu*
1. Return (SUB fin $subst_typeuse(tu', tv*, tu*)* $subst_comptype(ct, tv*, tu*)).

subst_rectype (REC st*) tv* tu*
1. Return (REC $subst_subtype(st, tv*, tu*)*).

subst_deftype (DEF qt i) tv* tu*
1. Return (DEF $subst_rectype(qt, tv*, tu*) i).

subst_functype (t_1* -> t_2*) tv* tu*
1. Return ($subst_valtype(t_1, tv*, tu*)* -> $subst_valtype(t_2, tv*, tu*)*).

subst_globaltype (mut, t) tv* tu*
1. Return (mut, $subst_valtype(t, tv*, tu*)).

subst_tabletype (lim, rt) tv* tu*
1. Return (lim, $subst_reftype(rt, tv*, tu*)).

subst_memtype (PAGE lim) tv* tu*
1. Return (PAGE lim).

subst_externtype exter_u0 tv* tu*
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC dt) be exter_u0.
  b. Return (FUNC $subst_deftype(dt, tv*, tu*)).
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be exter_u0.
  b. Return (GLOBAL $subst_globaltype(gt, tv*, tu*)).
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE tt) be exter_u0.
  b. Return (TABLE $subst_tabletype(tt, tv*, tu*)).
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM mt) be exter_u0.
6. Return (MEM $subst_memtype(mt, tv*, tu*)).

subst_moduletype (xt_1* -> xt_2*) tv* tu*
1. Return ($subst_externtype(xt_1, tv*, tu*)* -> $subst_externtype(xt_2, tv*, tu*)*).

subst_all_valtype t tu^n
1. Return $subst_valtype(t, $idx(i)^(i<n), tu^n).

subst_all_reftype rt tu^n
1. Return $subst_reftype(rt, $idx(i)^(i<n), tu^n).

subst_all_deftype dt tu^n
1. Return $subst_deftype(dt, $idx(i)^(i<n), tu^n).

subst_all_moduletype mmt tu^n
1. Return $subst_moduletype(mmt, $idx(i)^(i<n), tu^n).

subst_all_deftypes defty_u0* tu*
1. If (defty_u0* is []), then:
  a. Return [].
2. Let [dt_1] ++ dt* be defty_u0*.
3. Return [$subst_all_deftype(dt_1, tu*)] ++ $subst_all_deftypes(dt*, tu*).

rollrt x rectype
1. Assert: Due to validation, rectype is of the case REC.
2. Let (REC subtype^n) be rectype.
3. Return (REC $subst_subtype(subtype, $idx((x + i))^(i<n), (REC i)^(i<n))^n).

unrollrt rectype
1. Assert: Due to validation, rectype is of the case REC.
2. Let (REC subtype^n) be rectype.
3. Return (REC $subst_subtype(subtype, (REC i)^(i<n), (DEF rectype i)^(i<n))^n).

rolldt x rectype
1. Assert: Due to validation, $rollrt(x, rectype) is of the case REC.
2. Let (REC subtype^n) be $rollrt(x, rectype).
3. Return (DEF (REC subtype^n) i)^(i<n).

unrolldt (DEF rectype i)
1. Assert: Due to validation, $unrollrt(rectype) is of the case REC.
2. Let (REC subtype*) be $unrollrt(rectype).
3. Return subtype*[i].

expanddt deftype
1. Assert: Due to validation, $unrolldt(deftype) is of the case SUB.
2. Let (SUB fin typeuse* comptype) be $unrolldt(deftype).
3. Return comptype.

funcsxx exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externidx_0] ++ xx* be exter_u0*.
3. If externidx_0 is of the case FUNC, then:
  a. Let (FUNC x) be externidx_0.
  b. Return [x] ++ $funcsxx(xx*).
4. Let [externidx] ++ xx* be exter_u0*.
5. Return $funcsxx(xx*).

globalsxx exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externidx_0] ++ xx* be exter_u0*.
3. If externidx_0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be externidx_0.
  b. Return [x] ++ $globalsxx(xx*).
4. Let [externidx] ++ xx* be exter_u0*.
5. Return $globalsxx(xx*).

tablesxx exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externidx_0] ++ xx* be exter_u0*.
3. If externidx_0 is of the case TABLE, then:
  a. Let (TABLE x) be externidx_0.
  b. Return [x] ++ $tablesxx(xx*).
4. Let [externidx] ++ xx* be exter_u0*.
5. Return $tablesxx(xx*).

memsxx exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externidx_0] ++ xx* be exter_u0*.
3. If externidx_0 is of the case MEM, then:
  a. Let (MEM x) be externidx_0.
  b. Return [x] ++ $memsxx(xx*).
4. Let [externidx] ++ xx* be exter_u0*.
5. Return $memsxx(xx*).

funcsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externtype_0] ++ xt* be exter_u0*.
3. If externtype_0 is of the case FUNC, then:
  a. Let (FUNC dt) be externtype_0.
  b. Return [dt] ++ $funcsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $funcsxt(xt*).

globalsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externtype_0] ++ xt* be exter_u0*.
3. If externtype_0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be externtype_0.
  b. Return [gt] ++ $globalsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $globalsxt(xt*).

tablesxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externtype_0] ++ xt* be exter_u0*.
3. If externtype_0 is of the case TABLE, then:
  a. Let (TABLE tt) be externtype_0.
  b. Return [tt] ++ $tablesxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $tablesxt(xt*).

memsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externtype_0] ++ xt* be exter_u0*.
3. If externtype_0 is of the case MEM, then:
  a. Let (MEM mt) be externtype_0.
  b. Return [mt] ++ $memsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $memsxt(xt*).

memarg0
1. Return { ALIGN: 0; OFFSET: 0; }.

signed_ N i
1. If (0 ≤ (2 ^ (N - 1))), then:
  a. Return i.
2. Assert: Due to validation, ((2 ^ (N - 1)) ≤ i).
3. Assert: Due to validation, (i < (2 ^ N)).
4. Return (i - (2 ^ N)).

invsigned_ N i
1. Let j be $signed__1^-1(N, i).
2. Return j.

unop_ numty_u1 unop__u0 num__u3
1. If ((unop__u0 is CLZ) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN be num__u3.
  c. Return [$iclz_($size(Inn), iN)].
2. If ((unop__u0 is CTZ) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN be num__u3.
  c. Return [$ictz_($size(Inn), iN)].
3. If ((unop__u0 is POPCNT) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN be num__u3.
  c. Return [$ipopcnt_($size(Inn), iN)].
4. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Assert: Due to validation, unop__u0 is of the case EXTEND.
  c. Let (EXTEND N) be unop__u0.
  d. Let iN be num__u3.
  e. Return [$extend__(N, $size(Inn), S, $wrap__($size(Inn), N, iN))].
5. If ((unop__u0 is ABS) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return $fabs_($size(Fnn), fN).
6. If ((unop__u0 is NEG) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return $fneg_($size(Fnn), fN).
7. If ((unop__u0 is SQRT) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return $fsqrt_($size(Fnn), fN).
8. If ((unop__u0 is CEIL) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return $fceil_($size(Fnn), fN).
9. If ((unop__u0 is FLOOR) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return $ffloor_($size(Fnn), fN).
10. If ((unop__u0 is TRUNC) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return $ftrunc_($size(Fnn), fN).
11. Assert: Due to validation, (unop__u0 is NEAREST).
12. Assert: Due to validation, the type of numty_u1 is Fnn.
13. Let Fnn be numty_u1.
14. Let fN be num__u3.
15. Return $fnearest_($size(Fnn), fN).

binop_ numty_u1 binop_u0 num__u3 num__u5
1. If ((binop_u0 is ADD) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$iadd_($size(Inn), iN_1, iN_2)].
2. If ((binop_u0 is SUB) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$isub_($size(Inn), iN_1, iN_2)].
3. If ((binop_u0 is MUL) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$imul_($size(Inn), iN_1, iN_2)].
4. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. If binop_u0 is of the case DIV, then:
    1) Let (DIV sx) be binop_u0.
    2) Return $list_($idiv_($size(Inn), sx, iN_1, iN_2)).
  e. If binop_u0 is of the case REM, then:
    1) Let (REM sx) be binop_u0.
    2) Return $list_($irem_($size(Inn), sx, iN_1, iN_2)).
5. If ((binop_u0 is AND) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$iand_($size(Inn), iN_1, iN_2)].
6. If ((binop_u0 is OR) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$ior_($size(Inn), iN_1, iN_2)].
7. If ((binop_u0 is XOR) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$ixor_($size(Inn), iN_1, iN_2)].
8. If ((binop_u0 is SHL) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$ishl_($size(Inn), iN_1, iN_2)].
9. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. If binop_u0 is of the case SHR, then:
    1) Let (SHR sx) be binop_u0.
    2) Return [$ishr_($size(Inn), sx, iN_1, iN_2)].
10. If ((binop_u0 is ROTL) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$irotl_($size(Inn), iN_1, iN_2)].
11. If ((binop_u0 is ROTR) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$irotr_($size(Inn), iN_1, iN_2)].
12. If ((binop_u0 is ADD) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fadd_($size(Fnn), fN_1, fN_2).
13. If ((binop_u0 is SUB) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fsub_($size(Fnn), fN_1, fN_2).
14. If ((binop_u0 is MUL) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fmul_($size(Fnn), fN_1, fN_2).
15. If ((binop_u0 is DIV) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fdiv_($size(Fnn), fN_1, fN_2).
16. If ((binop_u0 is MIN) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fmin_($size(Fnn), fN_1, fN_2).
17. If ((binop_u0 is MAX) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fmax_($size(Fnn), fN_1, fN_2).
18. Assert: Due to validation, (binop_u0 is COPYSIGN).
19. Assert: Due to validation, the type of numty_u1 is Fnn.
20. Let Fnn be numty_u1.
21. Let fN_1 be num__u3.
22. Let fN_2 be num__u5.
23. Return $fcopysign_($size(Fnn), fN_1, fN_2).

testop_ Inn EQZ iN
1. Return $ieqz_($size(Inn), iN).

relop_ numty_u1 relop_u0 num__u3 num__u5
1. If ((relop_u0 is EQ) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return $ieq_($size(Inn), iN_1, iN_2).
2. If ((relop_u0 is NE) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return $ine_($size(Inn), iN_1, iN_2).
3. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. If relop_u0 is of the case LT, then:
    1) Let (LT sx) be relop_u0.
    2) Return $ilt_($size(Inn), sx, iN_1, iN_2).
  e. If relop_u0 is of the case GT, then:
    1) Let (GT sx) be relop_u0.
    2) Return $igt_($size(Inn), sx, iN_1, iN_2).
  f. If relop_u0 is of the case LE, then:
    1) Let (LE sx) be relop_u0.
    2) Return $ile_($size(Inn), sx, iN_1, iN_2).
  g. If relop_u0 is of the case GE, then:
    1) Let (GE sx) be relop_u0.
    2) Return $ige_($size(Inn), sx, iN_1, iN_2).
4. If ((relop_u0 is EQ) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $feq_($size(Fnn), fN_1, fN_2).
5. If ((relop_u0 is NE) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fne_($size(Fnn), fN_1, fN_2).
6. If ((relop_u0 is LT) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $flt_($size(Fnn), fN_1, fN_2).
7. If ((relop_u0 is GT) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fgt_($size(Fnn), fN_1, fN_2).
8. If ((relop_u0 is LE) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fle_($size(Fnn), fN_1, fN_2).
9. Assert: Due to validation, (relop_u0 is GE).
10. Assert: Due to validation, the type of numty_u1 is Fnn.
11. Let Fnn be numty_u1.
12. Let fN_1 be num__u3.
13. Let fN_2 be num__u5.
14. Return $fge_($size(Fnn), fN_1, fN_2).

cvtop__ numty_u1 numty_u4 cvtop_u0 num__u3
1. If the type of numty_u1 is Inn, then:
  a. Let Inn_1 be numty_u1.
  b. If the type of numty_u4 is Inn, then:
    1) Let Inn_2 be numty_u4.
    2) Let iN_1 be num__u3.
    3) If cvtop_u0 is of the case EXTEND, then:
      a) Let (EXTEND sx) be cvtop_u0.
      b) Return [$extend__($sizenn1(Inn_1), $sizenn2(Inn_2), sx, iN_1)].
2. If ((cvtop_u0 is WRAP) and the type of numty_u1 is Inn), then:
  a. Let Inn_1 be numty_u1.
  b. If the type of numty_u4 is Inn, then:
    1) Let Inn_2 be numty_u4.
    2) Let iN_1 be num__u3.
    3) Return [$wrap__($sizenn1(Inn_1), $sizenn2(Inn_2), iN_1)].
3. If the type of numty_u1 is Fnn, then:
  a. Let Fnn_1 be numty_u1.
  b. If the type of numty_u4 is Inn, then:
    1) Let Inn_2 be numty_u4.
    2) Let fN_1 be num__u3.
    3) If cvtop_u0 is of the case TRUNC, then:
      a) Let (TRUNC sx) be cvtop_u0.
      b) Return $list_($trunc__($sizenn1(Fnn_1), $sizenn2(Inn_2), sx, fN_1)).
    4) If cvtop_u0 is of the case TRUNC_SAT, then:
      a) Let (TRUNC_SAT sx) be cvtop_u0.
      b) Return $list_($trunc_sat__($sizenn1(Fnn_1), $sizenn2(Inn_2), sx, fN_1)).
4. If the type of numty_u4 is Fnn, then:
  a. Let Fnn_2 be numty_u4.
  b. If the type of numty_u1 is Inn, then:
    1) Let Inn_1 be numty_u1.
    2) Let iN_1 be num__u3.
    3) If cvtop_u0 is of the case CONVERT, then:
      a) Let (CONVERT sx) be cvtop_u0.
      b) Return [$convert__($sizenn1(Inn_1), $sizenn2(Fnn_2), sx, iN_1)].
5. If ((cvtop_u0 is PROMOTE) and the type of numty_u1 is Fnn), then:
  a. Let Fnn_1 be numty_u1.
  b. If the type of numty_u4 is Fnn, then:
    1) Let Fnn_2 be numty_u4.
    2) Let fN_1 be num__u3.
    3) Return $promote__($sizenn1(Fnn_1), $sizenn2(Fnn_2), fN_1).
6. If ((cvtop_u0 is DEMOTE) and the type of numty_u1 is Fnn), then:
  a. Let Fnn_1 be numty_u1.
  b. If the type of numty_u4 is Fnn, then:
    1) Let Fnn_2 be numty_u4.
    2) Let fN_1 be num__u3.
    3) Return $demote__($sizenn1(Fnn_1), $sizenn2(Fnn_2), fN_1).
7. Assert: Due to validation, (cvtop_u0 is REINTERPRET).
8. If the type of numty_u4 is Fnn, then:
  a. Let Fnn_2 be numty_u4.
  b. If the type of numty_u1 is Inn, then:
    1) Let Inn_1 be numty_u1.
    2) Let iN_1 be num__u3.
    3) If ($size(Inn_1) is $size(Fnn_2)), then:
      a) Return [$reinterpret__(Inn_1, Fnn_2, iN_1)].
9. Assert: Due to validation, the type of numty_u1 is Fnn.
10. Let Fnn_1 be numty_u1.
11. Assert: Due to validation, the type of numty_u4 is Inn.
12. Let Inn_2 be numty_u4.
13. Let fN_1 be num__u3.
14. Assert: Due to validation, ($size(Fnn_1) is $size(Inn_2)).
15. Return [$reinterpret__(Fnn_1, Inn_2, fN_1)].

invibytes_ N b*
1. Let n be $ibytes__1^-1(N, b*).
2. Return n.

invfbytes_ N b*
1. Let p be $fbytes__1^-1(N, b*).
2. Return p.

lpacknum_ lanet_u0 c
1. If the type of lanet_u0 is numtype, then:
  a. Return c.
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $wrap__($size($lunpack(packtype)), $psize(packtype), c).

lunpacknum_ lanet_u0 c
1. If the type of lanet_u0 is numtype, then:
  a. Return c.
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $extend__($psize(packtype), $size($lunpack(packtype)), U, c).

cpacknum_ stora_u0 c
1. If the type of stora_u0 is consttype, then:
  a. Return c.
2. Assert: Due to validation, the type of stora_u0 is packtype.
3. Let packtype be stora_u0.
4. Return $wrap__($size($lunpack(packtype)), $psize(packtype), c).

cunpacknum_ stora_u0 c
1. If the type of stora_u0 is consttype, then:
  a. Return c.
2. Assert: Due to validation, the type of stora_u0 is packtype.
3. Let packtype be stora_u0.
4. Return $extend__($psize(packtype), $size($lunpack(packtype)), U, c).

invlanes_ sh c*
1. Let vc be $lanes__1^-1(sh, c*).
2. Return vc.

mapinvlanes_ sh c**
1. Let c'** be $setproduct_(c**).
2. Return $invlanes_(sh, c'*)*.

half__ (lanet_u1 X M_1) (lanet_u2 X M_2) half__u0 i j
1. If ((half__u0 is LOW) and (the type of lanet_u1 is Jnn and the type of lanet_u2 is Jnn)), then:
  a. Return i.
2. If ((half__u0 is HIGH) and (the type of lanet_u1 is Jnn and the type of lanet_u2 is Jnn)), then:
  a. Return j.
3. Assert: Due to validation, (half__u0 is LOW).
4. Assert: Due to validation, the type of lanet_u2 is Fnn.
5. Return i.

vvunop_ V128 NOT v128
1. Return [$inot_($vsize(V128), v128)].

vvbinop_ V128 vvbin_u0 v128_1 v128_2
1. If (vvbin_u0 is AND), then:
  a. Return [$iand_($vsize(V128), v128_1, v128_2)].
2. If (vvbin_u0 is ANDNOT), then:
  a. Return [$iandnot_($vsize(V128), v128_1, v128_2)].
3. If (vvbin_u0 is OR), then:
  a. Return [$ior_($vsize(V128), v128_1, v128_2)].
4. Assert: Due to validation, (vvbin_u0 is XOR).
5. Return [$ixor_($vsize(V128), v128_1, v128_2)].

vvternop_ V128 BITSELECT v128_1 v128_2 v128_3
1. Return [$ibitselect_($vsize(V128), v128_1, v128_2, v128_3)].

vunop_ (lanet_u1 X N) vunop_u0 v128_1
1. If ((vunop_u0 is ABS) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let v128 be $invlanes_((Jnn X N), $iabs_($lsize(Jnn), lane_1)*).
  d. Return [v128].
2. If ((vunop_u0 is NEG) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let v128 be $invlanes_((Jnn X N), $ineg_($lsize(Jnn), lane_1)*).
  d. Return [v128].
3. If ((vunop_u0 is POPCNT) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let v128 be $invlanes_((Jnn X N), $ipopcnt_($lsize(Jnn), lane_1)*).
  d. Return [v128].
4. If ((vunop_u0 is ABS) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128* be $mapinvlanes_((Fnn X N), $fabs_($size(Fnn), lane_1)*).
  d. Return v128*.
5. If ((vunop_u0 is NEG) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128* be $mapinvlanes_((Fnn X N), $fneg_($size(Fnn), lane_1)*).
  d. Return v128*.
6. If ((vunop_u0 is SQRT) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128* be $mapinvlanes_((Fnn X N), $fsqrt_($size(Fnn), lane_1)*).
  d. Return v128*.
7. If ((vunop_u0 is CEIL) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128* be $mapinvlanes_((Fnn X N), $fceil_($size(Fnn), lane_1)*).
  d. Return v128*.
8. If ((vunop_u0 is FLOOR) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128* be $mapinvlanes_((Fnn X N), $ffloor_($size(Fnn), lane_1)*).
  d. Return v128*.
9. If ((vunop_u0 is TRUNC) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128* be $mapinvlanes_((Fnn X N), $ftrunc_($size(Fnn), lane_1)*).
  d. Return v128*.
10. Assert: Due to validation, (vunop_u0 is NEAREST).
11. Assert: Due to validation, the type of lanet_u1 is Fnn.
12. Let Fnn be lanet_u1.
13. Let lane_1* be $lanes_((Fnn X N), v128_1).
14. Let v128* be $mapinvlanes_((Fnn X N), $fnearest_($size(Fnn), lane_1)*).
15. Return v128*.

vbinop_ (lanet_u1 X N) vbino_u0 v128_1 v128_2
1. If ((vbino_u0 is ADD) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $iadd_($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
2. If ((vbino_u0 is SUB) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $isub_($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
3. If the type of lanet_u1 is Jnn, then:
  a. Let Jnn be lanet_u1.
  b. If vbino_u0 is of the case MIN, then:
    1) Let (MIN sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $imin_($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
  c. If vbino_u0 is of the case MAX, then:
    1) Let (MAX sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $imax_($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
  d. If vbino_u0 is of the case ADD_SAT, then:
    1) Let (ADD_SAT sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $iadd_sat_($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
  e. If vbino_u0 is of the case SUB_SAT, then:
    1) Let (SUB_SAT sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $isub_sat_($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
4. If ((vbino_u0 is MUL) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $imul_($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
5. If ((vbino_u0 is AVGR) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $iavgr_($lsize(Jnn), U, lane_1, lane_2)*).
  e. Return [v128].
6. If ((vbino_u0 is Q15MULR_SAT) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $iq15mulr_sat_($lsize(Jnn), S, lane_1, lane_2)*).
  e. Return [v128].
7. If ((vbino_u0 is ADD) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fadd_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
8. If ((vbino_u0 is SUB) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fsub_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
9. If ((vbino_u0 is MUL) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fmul_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
10. If ((vbino_u0 is DIV) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fdiv_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
11. If ((vbino_u0 is MIN) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fmin_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
12. If ((vbino_u0 is MAX) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fmax_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
13. If ((vbino_u0 is PMIN) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128* be $mapinvlanes_((Fnn X N), $fpmin_($size(Fnn), lane_1, lane_2)*).
  e. Return v128*.
14. Assert: Due to validation, (vbino_u0 is PMAX).
15. Assert: Due to validation, the type of lanet_u1 is Fnn.
16. Let Fnn be lanet_u1.
17. Let lane_1* be $lanes_((Fnn X N), v128_1).
18. Let lane_2* be $lanes_((Fnn X N), v128_2).
19. Let v128* be $mapinvlanes_((Fnn X N), $fpmax_($size(Fnn), lane_1, lane_2)*).
20. Return v128*.

vrelop_ (lanet_u1 X N) vrelo_u0 v128_1 v128_2
1. If ((vrelo_u0 is EQ) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let lane_3* be $extend__(1, $lsize(Jnn), S, $ieq_($lsize(Jnn), lane_1, lane_2))*.
  e. Let v128 be $invlanes_((Jnn X N), lane_3*).
  f. Return v128.
2. If ((vrelo_u0 is NE) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let lane_3* be $extend__(1, $lsize(Jnn), S, $ine_($lsize(Jnn), lane_1, lane_2))*.
  e. Let v128 be $invlanes_((Jnn X N), lane_3*).
  f. Return v128.
3. If the type of lanet_u1 is Jnn, then:
  a. Let Jnn be lanet_u1.
  b. If vrelo_u0 is of the case LT, then:
    1) Let (LT sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $extend__(1, $lsize(Jnn), S, $ilt_($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
  c. If vrelo_u0 is of the case GT, then:
    1) Let (GT sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $extend__(1, $lsize(Jnn), S, $igt_($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
  d. If vrelo_u0 is of the case LE, then:
    1) Let (LE sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $extend__(1, $lsize(Jnn), S, $ile_($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
  e. If vrelo_u0 is of the case GE, then:
    1) Let (GE sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $extend__(1, $lsize(Jnn), S, $ige_($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
4. If ((vrelo_u0 is EQ) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. If the type of $size^-1($size(Fnn)) is Inn, then:
    1) Let Inn be $size^-1($size(Fnn)).
    2) Let lane_3* be $extend__(1, $size(Fnn), S, $feq_($size(Fnn), lane_1, lane_2))*.
    3) Let v128 be $invlanes_((Inn X N), lane_3*).
    4) Return v128.
5. If ((vrelo_u0 is NE) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $extend__(1, $size(Fnn), S, $fne_($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
6. If ((vrelo_u0 is LT) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $extend__(1, $size(Fnn), S, $flt_($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
7. If ((vrelo_u0 is GT) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $extend__(1, $size(Fnn), S, $fgt_($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
8. If ((vrelo_u0 is LE) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $extend__(1, $size(Fnn), S, $fle_($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
9. Assert: Due to validation, (vrelo_u0 is GE).
10. Assert: Due to validation, the type of lanet_u1 is Fnn.
11. Let Fnn be lanet_u1.
12. Let lane_1* be $lanes_((Fnn X N), v128_1).
13. Let lane_2* be $lanes_((Fnn X N), v128_2).
14. Let Inn be $isize^-1($size(Fnn)).
15. Let lane_3* be $extend__(1, $size(Fnn), S, $fge_($size(Fnn), lane_1, lane_2))*.
16. Let v128 be $invlanes_((Inn X N), lane_3*).
17. Return v128.

vcvtop__ (lanet_u0 X N_1) (lanet_u1 X N_2) vcvto_u6 sx_u7? lane__u3
1. If ((lanet_u0 is I8) and ((lanet_u1 is I16) and (vcvto_u6 is EXTEND))), then:
  a. Let i8 be lane__u3.
  b. If sx_u7? is defined, then:
    1) Let ?(sx) be sx_u7?.
    2) Let i16 be $extend__(8, 16, sx, i8).
    3) Return [i16].
2. If ((lanet_u0 is I16) and ((lanet_u1 is I32) and (vcvto_u6 is EXTEND))), then:
  a. Let i16 be lane__u3.
  b. If sx_u7? is defined, then:
    1) Let ?(sx) be sx_u7?.
    2) Let i32 be $extend__(16, 32, sx, i16).
    3) Return [i32].
3. If (lanet_u0 is I32), then:
  a. If ((lanet_u1 is I64) and (vcvto_u6 is EXTEND)), then:
    1) Let i32 be lane__u3.
    2) If sx_u7? is defined, then:
      a) Let ?(sx) be sx_u7?.
      b) Let i64 be $extend__(32, 64, sx, i32).
      c) Return [i64].
  b. If ((lanet_u1 is F32) and (vcvto_u6 is CONVERT)), then:
    1) Let i32 be lane__u3.
    2) If sx_u7? is defined, then:
      a) Let ?(sx) be sx_u7?.
      b) Let f32 be $convert__(32, 32, sx, i32).
      c) Return [f32].
  c. If ((lanet_u1 is F64) and (vcvto_u6 is CONVERT)), then:
    1) Let i32 be lane__u3.
    2) If sx_u7? is defined, then:
      a) Let ?(sx) be sx_u7?.
      b) Let f64 be $convert__(32, 64, sx, i32).
      c) Return [f64].
4. If ((lanet_u0 is F32) and ((lanet_u1 is I32) and (vcvto_u6 is TRUNC_SAT))), then:
  a. Let f32 be lane__u3.
  b. If sx_u7? is defined, then:
    1) Let ?(sx) be sx_u7?.
    2) Let i32? be $trunc_sat__(32, 32, sx, f32).
    3) Return $list_(i32?).
5. If (lanet_u0 is F64), then:
  a. If ((lanet_u1 is I32) and (vcvto_u6 is TRUNC_SAT)), then:
    1) Let f64 be lane__u3.
    2) If sx_u7? is defined, then:
      a) Let ?(sx) be sx_u7?.
      b) Let i32? be $trunc_sat__(64, 32, sx, f64).
      c) Return $list_(i32?).
  b. If ((lanet_u1 is F32) and (vcvto_u6 is DEMOTE)), then:
    1) Let f64 be lane__u3.
    2) Let f32* be $demote__(64, 32, f64).
    3) Return f32*.
6. Assert: Due to validation, (lanet_u0 is F32).
7. Assert: Due to validation, (lanet_u1 is F64).
8. Assert: Due to validation, (vcvto_u6 is PROMOTE).
9. Let f32 be lane__u3.
10. Let f64* be $promote__(32, 64, f32).
11. Return f64*.

vextunop__ (Jnn_1 X N_1) (Jnn_2 X N_2) (EXTADD_PAIRWISE sx) c_1
1. Let ci* be $lanes_((Jnn_1 X N_1), c_1).
2. Let [cj_1, cj_2]* be $concat_^-1($extend__($lsize(Jnn_1), $lsize(Jnn_2), sx, ci)*).
3. Let c be $invlanes_((Jnn_2 X N_2), $iadd_($lsize(Jnn_2), cj_1, cj_2)*).
4. Return c.

vextbinop__ (Jnn_1 X N_1) (Jnn_2 X N_2) vextb_u0 c_1 c_2
1. If vextb_u0 is of the case EXTMUL, then:
  a. Let (EXTMUL sx half) be vextb_u0.
  b. Let ci_1* be $lanes_((Jnn_1 X N_1), c_1)[$half__((Jnn_1 X N_1), (Jnn_2 X N_2), half, 0, N_2) : N_2].
  c. Let ci_2* be $lanes_((Jnn_1 X N_1), c_2)[$half__((Jnn_1 X N_1), (Jnn_2 X N_2), half, 0, N_2) : N_2].
  d. Let c be $invlanes_((Jnn_2 X N_2), $imul_($lsize(Jnn_2), $extend__($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_1), $extend__($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_2))*).
  e. Return c.
2. Assert: Due to validation, (vextb_u0 is DOT).
3. Let ci_1* be $lanes_((Jnn_1 X N_1), c_1).
4. Let ci_2* be $lanes_((Jnn_1 X N_1), c_2).
5. Let [cj_1, cj_2]* be $concat_^-1($imul_($lsize(Jnn_2), $extend__($lsize(Jnn_1), $lsize(Jnn_2), S, ci_1), $extend__($lsize(Jnn_1), $lsize(Jnn_2), S, ci_2))*).
6. Let c be $invlanes_((Jnn_2 X N_2), $iadd_($lsize(Jnn_2), cj_1, cj_2)*).
7. Return c.

vshiftop_ (Jnn X N) vshif_u0 lane n
1. If (vshif_u0 is SHL), then:
  a. Return $ishl_($lsize(Jnn), lane, n).
2. Assert: Due to validation, vshif_u0 is of the case SHR.
3. Let (SHR sx) be vshif_u0.
4. Return $ishr_($lsize(Jnn), sx, lane, n).

inst_valtype moduleinst t
1. Let dt* be moduleinst.TYPES.
2. Return $subst_all_valtype(t, dt*).

inst_reftype moduleinst rt
1. Let dt* be moduleinst.TYPES.
2. Return $subst_all_reftype(rt, dt*).

default_ valty_u0
1. If the type of valty_u0 is Inn, then:
  a. Let Inn be valty_u0.
  b. Return ?((Inn.CONST 0)).
2. If the type of valty_u0 is Fnn, then:
  a. Let Fnn be valty_u0.
  b. Return ?((Fnn.CONST $fzero($size(Fnn)))).
3. If the type of valty_u0 is Vnn, then:
  a. Let Vnn be valty_u0.
  b. Return ?((Vnn.CONST 0)).
4. Assert: Due to validation, valty_u0 is of the case REF.
5. Let (REF nul_0 ht) be valty_u0.
6. If (nul_0 is (NULL ?(()))), then:
  a. Return ?((REF.NULL ht)).
7. Assert: Due to validation, (nul_0 is (NULL ?())).
8. Return ?().

packfield_ stora_u0 val_u1
1. Let val be val_u1.
2. If the type of stora_u0 is valtype, then:
  a. Return val.
3. Assert: Due to validation, val_u1 is of the case CONST.
4. Let (numtype_0.CONST i) be val_u1.
5. Assert: Due to validation, (numtype_0 is I32).
6. Assert: Due to validation, the type of stora_u0 is packtype.
7. Let packtype be stora_u0.
8. Return (PACK packtype $wrap__(32, $psize(packtype), i)).

unpackfield_ stora_u0 sx_u1? field_u2
1. If sx_u1? is not defined, then:
  a. Assert: Due to validation, the type of field_u2 is val.
  b. Let val be field_u2.
  c. Assert: Due to validation, the type of stora_u0 is valtype.
  d. Return val.
2. Else:
  a. Let ?(sx) be sx_u1?.
  b. Assert: Due to validation, field_u2 is of the case PACK.
  c. Let (PACK packtype i) be field_u2.
  d. Assert: Due to validation, (stora_u0 is packtype).
  e. Return (I32.CONST $extend__($psize(packtype), 32, sx, i)).

funcsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ xv* be exter_u0*.
3. If externval_0 is of the case FUNC, then:
  a. Let (FUNC fa) be externval_0.
  b. Return [fa] ++ $funcsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $funcsxv(xv*).

globalsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ xv* be exter_u0*.
3. If externval_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be externval_0.
  b. Return [ga] ++ $globalsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $globalsxv(xv*).

tablesxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ xv* be exter_u0*.
3. If externval_0 is of the case TABLE, then:
  a. Let (TABLE ta) be externval_0.
  b. Return [ta] ++ $tablesxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $tablesxv(xv*).

memsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [externval_0] ++ xv* be exter_u0*.
3. If externval_0 is of the case MEM, then:
  a. Let (MEM ma) be externval_0.
  b. Return [ma] ++ $memsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $memsxv(xv*).

store
1. Return.

frame
1. Let f be the current frame.
2. Return f.

moduleinst
1. Let f be the current frame.
2. Return f.MODULE.

funcinst
1. Return s.FUNCS.

globalinst
1. Return s.GLOBALS.

tableinst
1. Return s.TABLES.

meminst
1. Return s.MEMS.

eleminst
1. Return s.ELEMS.

datainst
1. Return s.DATAS.

structinst
1. Return s.STRUCTS.

arrayinst
1. Return s.ARRAYS.

type x
1. Let f be the current frame.
2. Return f.MODULE.TYPES[x].

func x
1. Let f be the current frame.
2. Return s.FUNCS[f.MODULE.FUNCS[x]].

global x
1. Let f be the current frame.
2. Return s.GLOBALS[f.MODULE.GLOBALS[x]].

table x
1. Let f be the current frame.
2. Return s.TABLES[f.MODULE.TABLES[x]].

mem x
1. Let f be the current frame.
2. Return s.MEMS[f.MODULE.MEMS[x]].

elem x
1. Let f be the current frame.
2. Return s.ELEMS[f.MODULE.ELEMS[x]].

data x
1. Let f be the current frame.
2. Return s.DATAS[f.MODULE.DATAS[x]].

local x
1. Let f be the current frame.
2. Return f.LOCALS[x].

with_local x v
1. Let f be the current frame.
2. Replace f.LOCALS[x] with ?(v).

with_global x v
1. Let f be the current frame.
2. Replace s.GLOBALS[f.MODULE.GLOBALS[x]].VALUE with v.

with_table x i r
1. Let f be the current frame.
2. Replace s.TABLES[f.MODULE.TABLES[x]].REFS[i] with r.

with_tableinst x ti
1. Let f be the current frame.
2. Replace s.TABLES[f.MODULE.TABLES[x]] with ti.

with_mem x i j b*
1. Let f be the current frame.
2. Replace s.MEMS[f.MODULE.MEMS[x]].BYTES[i : j] with b*.

with_meminst x mi
1. Let f be the current frame.
2. Replace s.MEMS[f.MODULE.MEMS[x]] with mi.

with_elem x r*
1. Let f be the current frame.
2. Replace s.ELEMS[f.MODULE.ELEMS[x]].REFS with r*.

with_data x b*
1. Let f be the current frame.
2. Replace s.DATAS[f.MODULE.DATAS[x]].BYTES with b*.

with_struct a i fv
1. Let f be the current frame.
2. Replace s.STRUCTS[a].FIELDS[i] with fv.

with_array a i fv
1. Let f be the current frame.
2. Replace s.ARRAYS[a].FIELDS[i] with fv.

add_structinst si*
1. Let f be the current frame.
2. Return (s with .STRUCTS appended by si*, f).

add_arrayinst ai*
1. Let f be the current frame.
2. Return (s with .ARRAYS appended by ai*, f).

growtable tableinst n r
1. Let { TYPE: ((i, j), rt); REFS: r'*; } be tableinst.
2. If ((|r'*| + n) ≤ j), then:
  a. Let i' be (|r'*| + n).
  b. Let tableinst' be { TYPE: ((i', j), rt); REFS: r'* ++ r^n; }.
  c. Return tableinst'.

growmem meminst n
1. Let { TYPE: (PAGE (i, j)); BYTES: b*; } be meminst.
2. If (((|b*| / (64 · $Ki())) + n) ≤ j), then:
  a. Let i' be ((|b*| / (64 · $Ki())) + n).
  b. Let meminst' be { TYPE: (PAGE (i', j)); BYTES: b* ++ 0^(n · (64 · $Ki())); }.
  c. Return meminst'.

with_locals C local_u0* local_u1*
1. If ((local_u0* is []) and (local_u1* is [])), then:
  a. Return C.
2. Assert: Due to validation, (|local_u1*| ≥ 1).
3. Let [lct_1] ++ lct* be local_u1*.
4. Assert: Due to validation, (|local_u0*| ≥ 1).
5. Let [x_1] ++ x* be local_u0*.
6. Return $with_locals(C with .LOCALS[x_1] replaced by lct_1, x*, lct*).

clos_deftypes defty_u0*
1. If (defty_u0* is []), then:
  a. Return [].
2. Let dt* ++ [dt_n] be defty_u0*.
3. Let dt'* be $clos_deftypes(dt*).
4. Return dt'* ++ [$subst_all_deftype(dt_n, dt'*)].

clos_valtype C t
1. Let dt* be $clos_deftypes(C.TYPES).
2. Return $subst_all_valtype(t, dt*).

clos_deftype C dt
1. Let dt'* be $clos_deftypes(C.TYPES).
2. Return $subst_all_deftype(dt, dt'*).

clos_moduletype C mmt
1. Let dt* be $clos_deftypes(C.TYPES).
2. Return $subst_all_moduletype(mmt, dt*).

before typeu_u0 x i
1. If the type of typeu_u0 is deftype, then:
  a. Return true.
2. If typeu_u0 is of the case _IDX, then:
  a. Let (_IDX typeidx) be typeu_u0.
  b. Return (typeidx < x).
3. Assert: Due to validation, typeu_u0 is of the case REC.
4. Let (REC j) be typeu_u0.
5. Return (j < i).

unrollht C heapt_u0
1. If the type of heapt_u0 is deftype, then:
  a. Let deftype be heapt_u0.
  b. Return $unrolldt(deftype).
2. If heapt_u0 is of the case _IDX, then:
  a. Let (_IDX typeidx) be heapt_u0.
  b. Return $unrolldt(C.TYPES[typeidx]).
3. Assert: Due to validation, heapt_u0 is of the case REC.
4. Let (REC i) be heapt_u0.
5. Return C.RECS[i].

funcidx_nonfuncs YetE (`%%%%%`_nonfuncs(global*{global : global}, table*{table : table}, mem*{mem : mem}, elem*{elem : elem}, data*{data : data}))
1. Return $funcidx_module((MODULE [] [] [] global* table* mem* elem* data* ?() [])).

blocktype_ block_u0
1. If block_u0 is of the case _IDX, then:
  a. Let (_IDX x) be block_u0.
  b. Assert: Due to validation, $expanddt($type(x)) is of the case FUNC.
  c. Let (FUNC ft) be $expanddt($type(x)).
  d. Return ft.
2. Assert: Due to validation, block_u0 is of the case _RESULT.
3. Let (_RESULT t?) be block_u0.
4. Return ([] -> t?).

alloctypes type_u0*
1. If (type_u0* is []), then:
  a. Return [].
2. Let type'* ++ [type] be type_u0*.
3. Assert: Due to validation, type is of the case TYPE.
4. Let (TYPE rectype) be type.
5. Let deftype'* be $alloctypes(type'*).
6. Let x be |deftype'*|.
7. Let deftype* be $subst_all_deftypes($rolldt(x, rectype), deftype'*).
8. Return deftype'* ++ deftype*.

allocfunc deftype funccode moduleinst
1. Let funcinst be { TYPE: deftype; MODULE: moduleinst; CODE: funccode; }.
2. Let a be |s.FUNCS|.
3. Append funcinst to the s.FUNCS.
4. Return a.

allocfuncs defty_u0* funcc_u1* modul_u2*
1. If (defty_u0* is []), then:
  a. Assert: Due to validation, (funcc_u1* is []).
  b. Assert: Due to validation, (modul_u2* is []).
  c. Return [].
2. Else:
  a. Let [dt] ++ dt'* be defty_u0*.
  b. Assert: Due to validation, (|funcc_u1*| ≥ 1).
  c. Let [funccode] ++ funccode'* be funcc_u1*.
  d. Assert: Due to validation, (|modul_u2*| ≥ 1).
  e. Let [moduleinst] ++ moduleinst'* be modul_u2*.
  f. Let fa be $allocfunc(dt, funccode, moduleinst).
  g. Let fa'* be $allocfuncs(dt'*, funccode'*, moduleinst'*).
  h. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let globalinst be { TYPE: globaltype; VALUE: val; }.
2. Let a be |s.GLOBALS|.
3. Append globalinst to the s.GLOBALS.
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
1. Let tableinst be { TYPE: ((i, j), rt); REFS: ref^i; }.
2. Let a be |s.TABLES|.
3. Append tableinst to the s.TABLES.
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

allocmem (PAGE (i, j))
1. Let meminst be { TYPE: (PAGE (i, j)); BYTES: 0^(i · (64 · $Ki())); }.
2. Let a be |s.MEMS|.
3. Append meminst to the s.MEMS.
4. Return a.

allocmems memty_u0*
1. If (memty_u0* is []), then:
  a. Return [].
2. Let [memtype] ++ memtype'* be memty_u0*.
3. Let ma be $allocmem(memtype).
4. Let ma'* be $allocmems(memtype'*).
5. Return [ma] ++ ma'*.

allocelem elemtype ref*
1. Let eleminst be { TYPE: elemtype; REFS: ref*; }.
2. Let a be |s.ELEMS|.
3. Append eleminst to the s.ELEMS.
4. Return a.

allocelems elemt_u0* ref_u1*
1. If ((elemt_u0* is []) and (ref_u1* is [])), then:
  a. Return [].
2. Assert: Due to validation, (|ref_u1*| ≥ 1).
3. Let [ref*] ++ ref'** be ref_u1*.
4. Assert: Due to validation, (|elemt_u0*| ≥ 1).
5. Let [rt] ++ rt'* be elemt_u0*.
6. Let ea be $allocelem(rt, ref*).
7. Let ea'* be $allocelems(rt'*, ref'**).
8. Return [ea] ++ ea'*.

allocdata OK byte*
1. Let datainst be { BYTES: byte*; }.
2. Let a be |s.DATAS|.
3. Append datainst to the s.DATAS.
4. Return a.

allocdatas datat_u0* byte_u1*
1. If ((datat_u0* is []) and (byte_u1* is [])), then:
  a. Return [].
2. Assert: Due to validation, (|byte_u1*| ≥ 1).
3. Let [b*] ++ b'** be byte_u1*.
4. Assert: Due to validation, (|datat_u0*| ≥ 1).
5. Let [ok] ++ ok'* be datat_u0*.
6. Let da be $allocdata(ok, b*).
7. Let da'* be $allocdatas(ok'*, b'**).
8. Return [da] ++ da'*.

allocexport moduleinst (EXPORT name exter_u0)
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC x) be exter_u0.
  b. Return { NAME: name; VALUE: (FUNC moduleinst.FUNCS[x]); }.
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be exter_u0.
  b. Return { NAME: name; VALUE: (GLOBAL moduleinst.GLOBALS[x]); }.
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE x) be exter_u0.
  b. Return { NAME: name; VALUE: (TABLE moduleinst.TABLES[x]); }.
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM x) be exter_u0.
6. Return { NAME: name; VALUE: (MEM moduleinst.MEMS[x]); }.

allocexports moduleinst export*
1. Return $allocexport(moduleinst, export)*.

allocmodule module externval* val_G* ref_T* ref_E**
1. Let fa_I* be $funcsxv(externval*).
2. Let ga_I* be $globalsxv(externval*).
3. Let ma_I* be $memsxv(externval*).
4. Let ta_I* be $tablesxv(externval*).
5. Assert: Due to validation, module is of the case MODULE.
6. Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) be module.
7. Let fa* be (|s.FUNCS| + i_F)^(i_F<|func*|).
8. Let ga* be (|s.GLOBALS| + i_G)^(i_G<|global*|).
9. Let ta* be (|s.TABLES| + i_T)^(i_T<|table*|).
10. Let ma* be (|s.MEMS| + i_M)^(i_M<|mem*|).
11. Let ea* be (|s.ELEMS| + i_E)^(i_E<|elem*|).
12. Let da* be (|s.DATAS| + i_D)^(i_D<|data*|).
13. Assert: Due to validation, mem* is of the case MEMORY.
14. Let (MEMORY memtype)* be mem*.
15. Let dt* be $alloctypes(type*).
16. Assert: Due to validation, data* is of the case DATA.
17. Let (DATA byte* datamode)* be data*.
18. Assert: Due to validation, global* is of the case GLOBAL.
19. Let (GLOBAL globaltype expr_G)* be global*.
20. Assert: Due to validation, table* is of the case TABLE.
21. Let (TABLE tabletype expr_T)* be table*.
22. Assert: Due to validation, elem* is of the case ELEM.
23. Let (ELEM elemtype expr_E* elemmode)* be elem*.
24. Assert: Due to validation, func* is of the case FUNC.
25. Let (FUNC x local* expr_F)* be func*.
26. Let xi* be $allocexports({ TYPES: []; FUNCS: fa_I* ++ fa*; GLOBALS: ga_I* ++ ga*; TABLES: ta_I* ++ ta*; MEMS: ma_I* ++ ma*; ELEMS: []; DATAS: []; EXPORTS: []; }, export*).
27. Let moduleinst be { TYPES: dt*; FUNCS: fa_I* ++ fa*; GLOBALS: ga_I* ++ ga*; TABLES: ta_I* ++ ta*; MEMS: ma_I* ++ ma*; ELEMS: ea*; DATAS: da*; EXPORTS: xi*; }.
28. Let funcaddr_0 be $allocfuncs(dt*[x]*, (FUNC x local* expr_F)*, moduleinst^|func*|).
29. Assert: Due to validation, (funcaddr_0 is fa*).
30. Let globaladdr_0 be $allocglobals(globaltype*, val_G*).
31. Assert: Due to validation, (globaladdr_0 is ga*).
32. Let tableaddr_0 be $alloctables(tabletype*, ref_T*).
33. Assert: Due to validation, (tableaddr_0 is ta*).
34. Let memaddr_0 be $allocmems(memtype*).
35. Assert: Due to validation, (memaddr_0 is ma*).
36. Let elemaddr_0 be $allocelems(elemtype*, ref_E**).
37. Assert: Due to validation, (elemaddr_0 is ea*).
38. Let dataaddr_0 be $allocdatas(OK^|data*|, byte**).
39. Assert: Due to validation, (dataaddr_0 is da*).
40. Return moduleinst.

runelem_ x (ELEM rt e^n elemm_u0)
1. If (elemm_u0 is PASSIVE), then:
  a. Return [].
2. If (elemm_u0 is DECLARE), then:
  a. Return [(ELEM.DROP x)].
3. Assert: Due to validation, elemm_u0 is of the case ACTIVE.
4. Let (ACTIVE y instr*) be elemm_u0.
5. Return instr* ++ [(I32.CONST 0), (I32.CONST n), (TABLE.INIT y x), (ELEM.DROP x)].

rundata_ x (DATA b^n datam_u0)
1. If (datam_u0 is PASSIVE), then:
  a. Return [].
2. Assert: Due to validation, datam_u0 is of the case ACTIVE.
3. Let (ACTIVE y instr*) be datam_u0.
4. Return instr* ++ [(I32.CONST 0), (I32.CONST n), (MEMORY.INIT y x), (DATA.DROP x)].

instantiate module externval*
1. Let (xt_I* -> xt_E*) be $Module_ok(module).
2. Assert: Due to validation, module is of the case MODULE.
3. Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) be module.
4. Assert: Due to validation, ($Externval_type(externval) is xt_I)*.
5. Let instr_D* be $concat_($rundata_(i_D, data*[i_D])^(i_D<|data*|)).
6. Let instr_E* be $concat_($runelem_(i_E, elem*[i_E])^(i_E<|elem*|)).
7. Assert: Due to validation, start? is of the case START.
8. Let (START x)? be start?.
9. Let moduleinst_0 be { TYPES: $alloctypes(type*); FUNCS: $funcsxv(externval*) ++ (|s.FUNCS| + i_F)^(i_F<|func*|); GLOBALS: $globalsxv(externval*); TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }.
10. Assert: Due to validation, data* is of the case DATA.
11. Assert: Due to validation, global* is of the case GLOBAL.
12. Let (GLOBAL globaltype expr_G)* be global*.
13. Assert: Due to validation, table* is of the case TABLE.
14. Let (TABLE tabletype expr_T)* be table*.
15. Assert: Due to validation, elem* is of the case ELEM.
16. Let (ELEM reftype expr_E* elemmode)* be elem*.
17. Let instr_S? be (CALL x)?.
18. Let z be { LOCALS: []; MODULE: moduleinst_0; }.
19. Push the activation of z to the stack.
20. Let [val_G]* be $eval_expr(expr_G)*.
21. Pop the activation of z from the stack.
22. Push the activation of z to the stack.
23. Let [ref_T]* be $eval_expr(expr_T)*.
24. Pop the activation of z from the stack.
25. Push the activation of z to the stack.
26. Let [ref_E]** be $eval_expr(expr_E)**.
27. Pop the activation of z from the stack.
28. Let moduleinst be $allocmodule(module, externval*, val_G*, ref_T*, ref_E**).
29. Let f be { LOCALS: []; MODULE: moduleinst; }.
30. Push the activation of f with arity 0 to the stack.
31. Execute the instruction instr_E*.
32. Execute the instruction instr_D*.
33. If instr_S? is defined, then:
  a. Let ?(instr_0) be instr_S?.
  b. Execute the instruction instr_0.
34. Pop the activation of f with arity 0 from the stack.
35. Return f.MODULE.

invoke funcaddr val*
1. Let f be { LOCALS: []; MODULE: { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }; }.
2. Assert: Due to validation, $expanddt(s.FUNCS[funcaddr].TYPE) is of the case FUNC.
3. Let (FUNC functype_0) be $expanddt(s.FUNCS[funcaddr].TYPE).
4. Let (t_1* -> t_2*) be functype_0.
5. Assert: Due to validation, ($Val_type(val) is t_1)*.
6. Let k be |t_2*|.
7. Push the activation of f with arity k to the stack.
8. Push the values val* to the stack.
9. Push the value (REF.FUNC_ADDR funcaddr) to the stack.
10. Execute the instruction (CALL_REF s.FUNCS[funcaddr].TYPE).
11. Pop all values val* from the top of the stack.
12. Pop the activation of f with arity k from the stack.
13. Push the values val* to the stack.
14. Pop the values val^k from the stack.
15. Return val^k.

allocXs X_u0* Y_u1*
1. If (X_u0* is []), then:
  a. Assert: Due to validation, (Y_u1* is []).
  b. Return [].
2. Else:
  a. Let [X] ++ X'* be X_u0*.
  b. Assert: Due to validation, (|Y_u1*| ≥ 1).
  c. Let [Y] ++ Y'* be Y_u1*.
  d. Let a be $allocX(X, Y).
  e. Let a'* be $allocXs(X'*, Y'*).
  f. Return [a] ++ a'*.

execution_of_UNREACHABLE
1. Trap.

execution_of_NOP
1. Do nothing.

execution_of_DROP
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Do nothing.

execution_of_SELECT t*?
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value val_2 from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop the value val_1 from the stack.
7. If (c is not 0), then:
  a. Push the value val_1 to the stack.
8. Else:
  a. Push the value val_2 to the stack.

execution_of_IF bt instr_1* instr_2*
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute the instruction (BLOCK bt instr_1*).
4. Else:
  a. Execute the instruction (BLOCK bt instr_2*).

execution_of_LABEL_
1. Pop all values val* from the top of the stack.
2. Assert: Due to validation, a label is now on the top of the stack.
3. Pop the current label from the stack.
4. Push the values val* to the stack.

execution_of_BR l
1. Pop all values val* from the top of the stack.
2. Let L be the current label.
3. Let n be the arity of L.
4. Let instr'* be the continuation of L.
5. Pop the current label from the stack.
6. Let instr_u0* be val*.
7. If ((l is 0) and (|instr_u0*| ≥ n)), then:
  a. Let val'* ++ val^n be instr_u0*.
  b. Push the values val^n to the stack.
  c. Execute the instruction instr'*.
8. If ((l > 0) and the type of instr_u0 is val*), then:
  a. Let val* be instr_u0*.
  b. Push the values val* to the stack.
  c. Execute the instruction (BR (l - 1)).

execution_of_BR_IF l
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute the instruction (BR l).
4. Else:
  a. Do nothing.

execution_of_BR_TABLE l* l'
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST i) from the stack.
3. If (i < |l*|), then:
  a. Execute the instruction (BR l*[i]).
4. Else:
  a. Execute the instruction (BR l').

execution_of_BR_ON_NULL l
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. If val is of the case REF.NULL, then:
  a. Execute the instruction (BR l).
4. Else:
  a. Push the value val to the stack.

execution_of_BR_ON_NON_NULL l
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. If val is of the case REF.NULL, then:
  a. Do nothing.
4. Else:
  a. Push the value val to the stack.
  b. Execute the instruction (BR l).

execution_of_CALL_INDIRECT x yy
1. Execute the instruction (TABLE.GET x).
2. Execute the instruction (REF.CAST (REF (NULL ?(())) yy)).
3. Execute the instruction (CALL_REF yy).

execution_of_RETURN_CALL_INDIRECT x yy
1. Execute the instruction (TABLE.GET x).
2. Execute the instruction (REF.CAST (REF (NULL ?(())) yy)).
3. Execute the instruction (RETURN_CALL_REF yy).

execution_of_FRAME_
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop the values val^n from the stack.
5. Assert: Due to validation, a frame is now on the top of the stack.
6. Pop the current frame from the stack.
7. Push the values val^n to the stack.

execution_of_RETURN
1. Pop all values val* from the top of the stack.
2. If a frame is now on the top of the stack, then:
  a. Let f be the current frame.
  b. Let n be the arity of f.
  c. Pop the current frame from the stack.
  d. Let val'* ++ val^n be val*.
  e. Push the values val^n to the stack.
3. Else if a label is now on the top of the stack, then:
  a. Pop the current label from the stack.
  b. Push the values val* to the stack.
  c. Execute the instruction RETURN.

execution_of_TRAP
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_UNOP nt unop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_1) from the stack.
3. If (|$unop_(nt, unop, c_1)| ≤ 0), then:
  a. Trap.
4. Let c be an element of $unop_(nt, unop, c_1).
5. Push the value (nt.CONST c) to the stack.

execution_of_BINOP nt binop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop the value (nt.CONST c_1) from the stack.
5. If (|$binop_(nt, binop, c_1, c_2)| ≤ 0), then:
  a. Trap.
6. Let c be an element of $binop_(nt, binop, c_1, c_2).
7. Push the value (nt.CONST c) to the stack.

execution_of_TESTOP nt testop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_1) from the stack.
3. Let c be $testop_(nt, testop, c_1).
4. Push the value (I32.CONST c) to the stack.

execution_of_RELOP nt relop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop the value (nt.CONST c_1) from the stack.
5. Let c be $relop_(nt, relop, c_1, c_2).
6. Push the value (I32.CONST c) to the stack.

execution_of_CVTOP nt_2 nt_1 cvtop
1. Assert: Due to validation, a value of value type nt_1 is on the top of the stack.
2. Pop the value (nt_1.CONST c_1) from the stack.
3. If (|$cvtop__(nt_1, nt_2, cvtop, c_1)| ≤ 0), then:
  a. Trap.
4. Let c be an element of $cvtop__(nt_1, nt_2, cvtop, c_1).
5. Push the value (nt_2.CONST c) to the stack.

execution_of_REF.I31
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST i) from the stack.
3. Push the value (REF.I31_NUM $wrap__(32, 31, i)) to the stack.

execution_of_REF.IS_NULL
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value ref from the stack.
3. If ref is of the case REF.NULL, then:
  a. Push the value (I32.CONST 1) to the stack.
4. Else:
  a. Push the value (I32.CONST 0) to the stack.

execution_of_REF.AS_NON_NULL
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value ref from the stack.
3. If ref is of the case REF.NULL, then:
  a. Trap.
4. Push the value ref to the stack.

execution_of_REF.EQ
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value ref_2 from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value ref_1 from the stack.
5. If (ref_1 is of the case REF.NULL and ref_2 is of the case REF.NULL), then:
  a. Push the value (I32.CONST 1) to the stack.
6. Else if (ref_1 is ref_2), then:
  a. Push the value (I32.CONST 1) to the stack.
7. Else:
  a. Push the value (I32.CONST 0) to the stack.

execution_of_I31.GET sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value instr_u0 from the stack.
3. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
4. If instr_u0 is of the case REF.I31_NUM, then:
  a. Let (REF.I31_NUM i) be instr_u0.
  b. Push the value (I32.CONST $extend__(31, 32, sx, i)) to the stack.

execution_of_ARRAY.NEW x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value val from the stack.
5. Push the values val^n to the stack.
6. Execute the instruction (ARRAY.NEW_FIXED x n).

execution_of_EXTERN.CONVERT_ANY
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value instr_u0 from the stack.
3. If instr_u0 is of the case REF.NULL, then:
  a. Push the value (REF.NULL EXTERN) to the stack.
4. If the type of instr_u0 is addrref, then:
  a. Let addrref be instr_u0.
  b. Push the value (REF.EXTERN addrref) to the stack.

execution_of_ANY.CONVERT_EXTERN
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value instr_u0 from the stack.
3. If instr_u0 is of the case REF.NULL, then:
  a. Push the value (REF.NULL ANY) to the stack.
4. If instr_u0 is of the case REF.EXTERN, then:
  a. Let (REF.EXTERN addrref) be instr_u0.
  b. Push the value addrref to the stack.

execution_of_VVUNOP V128 vvunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Assert: Due to validation, (|$vvunop_(V128, vvunop, c_1)| > 0).
4. Let c be an element of $vvunop_(V128, vvunop, c_1).
5. Push the value (V128.CONST c) to the stack.

execution_of_VVBINOP V128 vvbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Assert: Due to validation, (|$vvbinop_(V128, vvbinop, c_1, c_2)| > 0).
6. Let c be an element of $vvbinop_(V128, vvbinop, c_1, c_2).
7. Push the value (V128.CONST c) to the stack.

execution_of_VVTERNOP V128 vvternop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_3) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_2) from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop the value (V128.CONST c_1) from the stack.
7. Assert: Due to validation, (|$vvternop_(V128, vvternop, c_1, c_2, c_3)| > 0).
8. Let c be an element of $vvternop_(V128, vvternop, c_1, c_2, c_3).
9. Push the value (V128.CONST c) to the stack.

execution_of_VVTESTOP V128 ANY_TRUE
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $ine_($vsize(V128), c_1, 0).
4. Push the value (I32.CONST c) to the stack.

execution_of_VUNOP sh vunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. If (|$vunop_(sh, vunop, c_1)| ≤ 0), then:
  a. Trap.
4. Let c be an element of $vunop_(sh, vunop, c_1).
5. Push the value (V128.CONST c) to the stack.

execution_of_VBINOP sh vbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. If (|$vbinop_(sh, vbinop, c_1, c_2)| ≤ 0), then:
  a. Trap.
6. Let c be an element of $vbinop_(sh, vbinop, c_1, c_2).
7. Push the value (V128.CONST c) to the stack.

execution_of_VTESTOP (Jnn X M) ALL_TRUE
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c) from the stack.
3. Let ci_1* be $lanes_((Jnn X M), c).
4. If (ci_1 is not 0)*, then:
  a. Push the value (I32.CONST 1) to the stack.
5. Else:
  a. Push the value (I32.CONST 0) to the stack.

execution_of_VRELOP sh vrelop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $vrelop_(sh, vrelop, c_1, c_2).
6. Push the value (V128.CONST c) to the stack.

execution_of_VSHIFTOP (Jnn X M) vshiftop
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c'* be $lanes_((Jnn X M), c_1).
6. Let c be $invlanes_((Jnn X M), $vshiftop_((Jnn X M), vshiftop, c', n)*).
7. Push the value (V128.CONST c) to the stack.

execution_of_VBITMASK (Jnn X M)
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c) from the stack.
3. Let ci_1* be $lanes_((Jnn X M), c).
4. Let ci be $ibits__1^-1(32, $ilt_($lsize(Jnn), S, ci_1, 0)*).
5. Push the value (I32.CONST ci) to the stack.

execution_of_VSWIZZLE (Pnn X M)
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c* be $lanes_((Pnn X M), c_1) ++ 0^(256 - M).
6. Let ci* be $lanes_((Pnn X M), c_2).
7. Assert: Due to validation, (ci*[k] < |c*|)^(k<M).
8. Assert: Due to validation, (k < |ci*|)^(k<M).
9. Let c' be $invlanes_((Pnn X M), c*[ci*[k]]^(k<M)).
10. Push the value (V128.CONST c') to the stack.

execution_of_VSHUFFLE (Pnn X M) i*
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Assert: Due to validation, (k < |i*|)^(k<M).
6. Let c'* be $lanes_((Pnn X M), c_1) ++ $lanes_((Pnn X M), c_2).
7. Assert: Due to validation, (i*[k] < |c'*|)^(k<M).
8. Let c be $invlanes_((Pnn X M), c'*[i*[k]]^(k<M)).
9. Push the value (V128.CONST c) to the stack.

execution_of_VSPLAT (Lnn X M)
1. Assert: Due to validation, a value of value type $lunpack(Lnn) is on the top of the stack.
2. Pop the value (nt_0.CONST c_1) from the stack.
3. Let c be $invlanes_((Lnn X M), $lpacknum_(Lnn, c_1)^M).
4. Push the value (V128.CONST c) to the stack.

execution_of_VEXTRACT_LANE (lanet_u0 X M) sx_u1? i
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. If (sx_u1? is not defined and the type of lanet_u0 is numtype), then:
  a. Let nt be lanet_u0.
  b. If (i < |$lanes_((nt X M), c_1)|), then:
    1) Let c_2 be $lanes_((nt X M), c_1)[i].
    2) Push the value (nt.CONST c_2) to the stack.
4. If the type of lanet_u0 is packtype, then:
  a. Let pt be lanet_u0.
  b. If sx_u1? is defined, then:
    1) Let ?(sx) be sx_u1?.
    2) If (i < |$lanes_((pt X M), c_1)|), then:
      a) Let c_2 be $extend__($psize(pt), 32, sx, $lanes_((pt X M), c_1)[i]).
      b) Push the value (I32.CONST c_2) to the stack.

execution_of_VREPLACE_LANE (Lnn X M) i
1. Assert: Due to validation, a value of value type $lunpack(Lnn) is on the top of the stack.
2. Pop the value (nt_0.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $invlanes_((Lnn X M), $lanes_((Lnn X M), c_1) with [i] replaced by $lpacknum_(Lnn, c_2)).
6. Push the value (V128.CONST c) to the stack.

execution_of_VEXTUNOP sh_2 sh_1 vextunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $vextunop__(sh_1, sh_2, vextunop, c_1).
4. Push the value (V128.CONST c) to the stack.

execution_of_VEXTBINOP sh_2 sh_1 vextbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $vextbinop__(sh_1, sh_2, vextbinop, c_1, c_2).
6. Push the value (V128.CONST c) to the stack.

execution_of_VNARROW (Jnn_2 X M_2) (Jnn_1 X M_1) sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let ci_1* be $lanes_((Jnn_1 X M_1), c_1).
6. Let ci_2* be $lanes_((Jnn_1 X M_1), c_2).
7. Let cj_1* be $narrow__($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_1)*.
8. Let cj_2* be $narrow__($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_2)*.
9. Let c be $invlanes_((Jnn_2 X M_2), cj_1* ++ cj_2*).
10. Push the value (V128.CONST c) to the stack.

execution_of_VCVTOP (lanet_u5 X n_u0) (lanet_u6 X n_u1) vcvtop half__u4? sx? zero__u13?
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. If (half__u4? is not defined and zero__u13? is not defined), then:
  a. Let Lnn_1 be lanet_u6.
  b. Let Lnn_2 be lanet_u5.
  c. Let M be n_u1.
  d. If (n_u0 is M), then:
    1) Let c'* be $lanes_((Lnn_1 X M), c_1).
    2) If (|$mapinvlanes_((Lnn_2 X M), $vcvtop__((Lnn_1 X M), (Lnn_2 X M), vcvtop, sx?, c')*)| > 0), then:
      a) Let c be an element of $mapinvlanes_((Lnn_2 X M), $vcvtop__((Lnn_1 X M), (Lnn_2 X M), vcvtop, sx?, c')*).
      b) Push the value (V128.CONST c) to the stack.
4. If zero__u13? is not defined, then:
  a. Let Lnn_1 be lanet_u6.
  b. Let Lnn_2 be lanet_u5.
  c. Let M_1 be n_u1.
  d. Let M_2 be n_u0.
  e. If half__u4? is defined, then:
    1) Let ?(half) be half__u4?.
    2) Let ci* be $lanes_((Lnn_1 X M_1), c_1)[$half__((Lnn_1 X M_1), (Lnn_2 X M_2), half, 0, M_2) : M_2].
    3) If (|$mapinvlanes_((Lnn_2 X M_2), $vcvtop__((Lnn_1 X M_1), (Lnn_2 X M_2), vcvtop, sx?, ci)*)| > 0), then:
      a) Let c be an element of $mapinvlanes_((Lnn_2 X M_2), $vcvtop__((Lnn_1 X M_1), (Lnn_2 X M_2), vcvtop, sx?, ci)*).
      b) Push the value (V128.CONST c) to the stack.
5. If half__u4? is not defined, then:
  a. Let M_1 be n_u1.
  b. Let M_2 be n_u0.
  c. If the type of lanet_u6 is numtype, then:
    1) Let nt_1 be lanet_u6.
    2) If the type of lanet_u5 is numtype, then:
      a) Let nt_2 be lanet_u5.
      b) If zero__u13? is defined, then:
        1. Let ci* be $lanes_((nt_1 X M_1), c_1).
        2. If (|$mapinvlanes_((nt_2 X M_2), $vcvtop__((nt_1 X M_1), (nt_2 X M_2), vcvtop, sx?, ci)* ++ [$zero(nt_2)]^M_1)| > 0), then:
          a. Let c be an element of $mapinvlanes_((nt_2 X M_2), $vcvtop__((nt_1 X M_1), (nt_2 X M_2), vcvtop, sx?, ci)* ++ [$zero(nt_2)]^M_1).
          b. Push the value (V128.CONST c) to the stack.

execution_of_LOCAL.TEE x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Push the value val to the stack.
4. Push the value val to the stack.
5. Execute the instruction (LOCAL.SET x).

execution_of_BLOCK bt instr*
1. Let z be the current state.
2. Let (t_1^m -> t_2^n) be $blocktype_(z, bt).
3. Assert: Due to validation, there are at least m values on the top of the stack.
4. Pop the values val^m from the stack.
5. Let L be the label_n{[]}.
6. Enter val^m ++ instr* with label L.

execution_of_LOOP bt instr*
1. Let z be the current state.
2. Let (t_1^m -> t_2^n) be $blocktype_(z, bt).
3. Assert: Due to validation, there are at least m values on the top of the stack.
4. Pop the values val^m from the stack.
5. Let L be the label_m{[(LOOP bt instr*)]}.
6. Enter val^m ++ instr* with label L.

execution_of_BR_ON_CAST l rt_1 rt_2
1. Let f be the current frame.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value ref from the stack.
4. Let rt be $Ref_type(ref).
5. If rt does not match $inst_reftype(f.MODULE, rt_2), then:
  a. Push the value ref to the stack.
6. Else:
  a. Push the value ref to the stack.
  b. Execute the instruction (BR l).

execution_of_BR_ON_CAST_FAIL l rt_1 rt_2
1. Let f be the current frame.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value ref from the stack.
4. Let rt be $Ref_type(ref).
5. If rt matches $inst_reftype(f.MODULE, rt_2), then:
  a. Push the value ref to the stack.
6. Else:
  a. Push the value ref to the stack.
  b. Execute the instruction (BR l).

execution_of_CALL x
1. Let z be the current state.
2. Assert: Due to validation, (x < |$moduleinst(z).FUNCS|).
3. Let a be $moduleinst(z).FUNCS[x].
4. Assert: Due to validation, (a < |$funcinst(z)|).
5. Push the value (REF.FUNC_ADDR a) to the stack.
6. Execute the instruction (CALL_REF $funcinst(z)[a].TYPE).

execution_of_CALL_REF yy
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value instr_u0 from the stack.
4. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
5. If instr_u0 is of the case REF.FUNC_ADDR, then:
  a. Let (REF.FUNC_ADDR a) be instr_u0.
  b. If (a < |$funcinst(z)|), then:
    1) Let fi be $funcinst(z)[a].
    2) Assert: Due to validation, fi.CODE is of the case FUNC.
    3) Let (FUNC x local_0 instr*) be fi.CODE.
    4) Assert: Due to validation, local_0 is of the case LOCAL.
    5) Let (LOCAL t)* be local_0.
    6) Assert: Due to validation, $expanddt(fi.TYPE) is of the case FUNC.
    7) Let (FUNC functype_0) be $expanddt(fi.TYPE).
    8) Let (t_1^n -> t_2^m) be functype_0.
    9) Assert: Due to validation, there are at least n values on the top of the stack.
    10) Pop the values val^n from the stack.
    11) Let f be { LOCALS: ?(val)^n ++ $default_(t)*; MODULE: fi.MODULE; }.
    12) Let F be the activation of f with arity m.
    13) Push F to the stack.
    14) Let L be the label_m{[]}.
    15) Enter instr* with label L.

execution_of_RETURN_CALL x
1. Let z be the current state.
2. Assert: Due to validation, (x < |$moduleinst(z).FUNCS|).
3. Let a be $moduleinst(z).FUNCS[x].
4. Assert: Due to validation, (a < |$funcinst(z)|).
5. Push the value (REF.FUNC_ADDR a) to the stack.
6. Execute the instruction (RETURN_CALL_REF $funcinst(z)[a].TYPE).

execution_of_RETURN_CALL_REF yy
1. Let z be the current state.
2. Pop all values val* from the top of the stack.
3. If a label is now on the top of the stack, then:
  a. Pop the current label from the stack.
  b. Push the values val* to the stack.
  c. Execute the instruction (RETURN_CALL_REF yy).
4. Else if a frame is now on the top of the stack, then:
  a. Pop the current frame from the stack.
  b. Let instr_u1* ++ instr_u0 be val*.
  c. If instr_u0 is of the case REF.FUNC_ADDR, then:
    1) Let (REF.FUNC_ADDR a) be instr_u0.
    2) If (a < |$funcinst(z)|), then:
      a) Assert: Due to validation, $expanddt($funcinst(z)[a].TYPE) is of the case FUNC.
      b) Let (FUNC functype_0) be $expanddt($funcinst(z)[a].TYPE).
      c) Let (t_1^n -> t_2^m) be functype_0.
      d) If (|instr_u1*| ≥ n), then:
        1. Let val'* ++ val^n be instr_u1*.
        2. Push the values val^n to the stack.
        3. Push the value (REF.FUNC_ADDR a) to the stack.
        4. Execute the instruction (CALL_REF yy).
  d. If (instr_u0 is of the case REF.NULL and the type of instr_u1 is val*), then:
    1) Trap.

execution_of_REF.NULL $idx(x)
1. Let z be the current state.
2. Push the value (REF.NULL $type(z, x)) to the stack.

execution_of_REF.FUNC x
1. Let z be the current state.
2. Assert: Due to validation, (x < |$moduleinst(z).FUNCS|).
3. Push the value (REF.FUNC_ADDR $moduleinst(z).FUNCS[x]) to the stack.

execution_of_REF.TEST rt
1. Let f be the current frame.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value ref from the stack.
4. Let rt' be $Ref_type(ref).
5. If rt' matches $inst_reftype(f.MODULE, rt), then:
  a. Push the value (I32.CONST 1) to the stack.
6. Else:
  a. Push the value (I32.CONST 0) to the stack.

execution_of_REF.CAST rt
1. Let f be the current frame.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value ref from the stack.
4. Let rt' be $Ref_type(ref).
5. If rt' does not match $inst_reftype(f.MODULE, rt), then:
  a. Trap.
6. Push the value ref to the stack.

execution_of_STRUCT.NEW_DEFAULT x
1. Let z be the current state.
2. Assert: Due to validation, $expanddt($type(z, x)) is of the case STRUCT.
3. Let (STRUCT fieldtype_0) be $expanddt($type(z, x)).
4. Let (mut, zt)* be fieldtype_0.
5. Assert: Due to validation, (|mut*| is |zt*|).
6. Assert: Due to validation, $default_($unpack(zt)) is defined*.
7. Let ?(val)* be $default_($unpack(zt))*.
8. Assert: Due to validation, (|val*| is |zt*|).
9. Push the values val* to the stack.
10. Execute the instruction (STRUCT.NEW x).

execution_of_STRUCT.GET sx? x i
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value instr_u0 from the stack.
4. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
5. Assert: Due to validation, $expanddt($type(z, x)) is of the case STRUCT.
6. Let (STRUCT fieldtype_0) be $expanddt($type(z, x)).
7. Let (mut, zt)* be fieldtype_0.
8. If instr_u0 is of the case REF.STRUCT_ADDR, then:
  a. Let (REF.STRUCT_ADDR a) be instr_u0.
  b. If ((i < |$structinst(z)[a].FIELDS|) and ((a < |$structinst(z)|) and ((|mut*| is |zt*|) and (i < |zt*|)))), then:
    1) Push the value $unpackfield_(zt*[i], sx?, $structinst(z)[a].FIELDS[i]) to the stack.

execution_of_ARRAY.NEW_DEFAULT x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, $expanddt($type(z, x)) is of the case ARRAY.
5. Let (ARRAY arraytype_0) be $expanddt($type(z, x)).
6. Let (mut, zt) be arraytype_0.
7. Assert: Due to validation, $default_($unpack(zt)) is defined.
8. Let ?(val) be $default_($unpack(zt)).
9. Push the values val^n to the stack.
10. Execute the instruction (ARRAY.NEW_FIXED x n).

execution_of_ARRAY.NEW_ELEM x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If ((i + n) > |$elem(z, y).REFS|), then:
  a. Trap.
7. Assert: Due to validation, (|$elem(z, y).REFS[i : n]| is n).
8. Let ref* be $elem(z, y).REFS[i : n].
9. Push the values ref^n to the stack.
10. Execute the instruction (ARRAY.NEW_FIXED x n).

execution_of_ARRAY.NEW_DATA x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, $expanddt($type(z, x)) is of the case ARRAY.
7. Let (ARRAY arraytype_0) be $expanddt($type(z, x)).
8. Let (mut, zt) be arraytype_0.
9. If ((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|), then:
  a. Trap.
10. Assert: Due to validation, (|$concat_^-1($data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)])| is n).
11. Let tmp* be $concat_^-1($data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)]).
12. Let c* be $zbytes__1^-1(zt, tmp)*.
13. Push the values $const($cunpack(zt), $cunpacknum_(zt, c))^n to the stack.
14. Execute the instruction (ARRAY.NEW_FIXED x n).

execution_of_ARRAY.GET sx? x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value instr_u0 from the stack.
6. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
7. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If ((a < |$arrayinst(z)|) and (i ≥ |$arrayinst(z)[a].FIELDS|)), then:
    1) Trap.
8. Assert: Due to validation, $expanddt($type(z, x)) is of the case ARRAY.
9. Let (ARRAY arraytype_0) be $expanddt($type(z, x)).
10. Let (mut, zt) be arraytype_0.
11. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If ((i < |$arrayinst(z)[a].FIELDS|) and (a < |$arrayinst(z)|)), then:
    1) Push the value $unpackfield_(zt, sx?, $arrayinst(z)[a].FIELDS[i]) to the stack.

execution_of_ARRAY.LEN
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value instr_u0 from the stack.
4. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
5. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If (a < |$arrayinst(z)|), then:
    1) Push the value (I32.CONST |$arrayinst(z)[a].FIELDS|) to the stack.

execution_of_ARRAY.FILL x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value val from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. Assert: Due to validation, a value is on the top of the stack.
9. Pop the value instr_u0 from the stack.
10. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
11. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If ((a < |$arrayinst(z)|) and ((i + n) > |$arrayinst(z)[a].FIELDS|)), then:
    1) Trap.
  c. If (n is 0), then:
    1) Do nothing.
  d. Else:
    1) Let (REF.ARRAY_ADDR a) be instr_u0.
    2) Push the value (REF.ARRAY_ADDR a) to the stack.
    3) Push the value (I32.CONST i) to the stack.
    4) Push the value val to the stack.
    5) Execute the instruction (ARRAY.SET x).
    6) Push the value (REF.ARRAY_ADDR a) to the stack.
    7) Push the value (I32.CONST (i + 1)) to the stack.
    8) Push the value val to the stack.
    9) Push the value (I32.CONST (n - 1)) to the stack.
    10) Execute the instruction (ARRAY.FILL x).

execution_of_ARRAY.COPY x_1 x_2
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i_2) from the stack.
6. Assert: Due to validation, a value is on the top of the stack.
7. Pop the value instr_u1 from the stack.
8. Assert: Due to validation, a value of value type I32 is on the top of the stack.
9. Pop the value (I32.CONST i_1) from the stack.
10. Assert: Due to validation, a value is on the top of the stack.
11. Pop the value instr_u0 from the stack.
12. If (instr_u0 is of the case REF.NULL and the type of instr_u1 is ref), then:
  a. Trap.
13. If (instr_u1 is of the case REF.NULL and the type of instr_u0 is ref), then:
  a. Trap.
14. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a_1) be instr_u0.
  b. If instr_u1 is of the case REF.ARRAY_ADDR, then:
    1) If ((a_1 < |$arrayinst(z)|) and ((i_1 + n) > |$arrayinst(z)[a_1].FIELDS|)), then:
      a) Trap.
    2) Let (REF.ARRAY_ADDR a_2) be instr_u1.
    3) If ((a_2 < |$arrayinst(z)|) and ((i_2 + n) > |$arrayinst(z)[a_2].FIELDS|)), then:
      a) Trap.
  c. If (n is 0), then:
    1) If instr_u1 is of the case REF.ARRAY_ADDR, then:
      a) Do nothing.
  d. Else if (i_1 > i_2), then:
    1) Assert: Due to validation, $expanddt($type(z, x_2)) is of the case ARRAY.
    2) Let (ARRAY arraytype_0) be $expanddt($type(z, x_2)).
    3) Let (mut, zt_2) be arraytype_0.
    4) Let (REF.ARRAY_ADDR a_1) be instr_u0.
    5) If instr_u1 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a_2) be instr_u1.
      b) Let sx? be $sx(zt_2).
      c) Push the value (REF.ARRAY_ADDR a_1) to the stack.
      d) Push the value (I32.CONST ((i_1 + n) - 1)) to the stack.
      e) Push the value (REF.ARRAY_ADDR a_2) to the stack.
      f) Push the value (I32.CONST ((i_2 + n) - 1)) to the stack.
      g) Execute the instruction (ARRAY.GET sx? x_2).
      h) Execute the instruction (ARRAY.SET x_1).
      i) Push the value (REF.ARRAY_ADDR a_1) to the stack.
      j) Push the value (I32.CONST i_1) to the stack.
      k) Push the value (REF.ARRAY_ADDR a_2) to the stack.
      l) Push the value (I32.CONST i_2) to the stack.
      m) Push the value (I32.CONST (n - 1)) to the stack.
      n) Execute the instruction (ARRAY.COPY x_1 x_2).
  e. Else:
    1) Assert: Due to validation, $expanddt($type(z, x_2)) is of the case ARRAY.
    2) Let (ARRAY arraytype_0) be $expanddt($type(z, x_2)).
    3) Let (mut, zt_2) be arraytype_0.
    4) Let (REF.ARRAY_ADDR a_1) be instr_u0.
    5) If instr_u1 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a_2) be instr_u1.
      b) Let sx? be $sx(zt_2).
      c) Push the value (REF.ARRAY_ADDR a_1) to the stack.
      d) Push the value (I32.CONST i_1) to the stack.
      e) Push the value (REF.ARRAY_ADDR a_2) to the stack.
      f) Push the value (I32.CONST i_2) to the stack.
      g) Execute the instruction (ARRAY.GET sx? x_2).
      h) Execute the instruction (ARRAY.SET x_1).
      i) Push the value (REF.ARRAY_ADDR a_1) to the stack.
      j) Push the value (I32.CONST (i_1 + 1)) to the stack.
      k) Push the value (REF.ARRAY_ADDR a_2) to the stack.
      l) Push the value (I32.CONST (i_2 + 1)) to the stack.
      m) Push the value (I32.CONST (n - 1)) to the stack.
      n) Execute the instruction (ARRAY.COPY x_1 x_2).

execution_of_ARRAY.INIT_ELEM x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST j) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. Assert: Due to validation, a value is on the top of the stack.
9. Pop the value instr_u0 from the stack.
10. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
11. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If ((a < |$arrayinst(z)|) and ((i + n) > |$arrayinst(z)[a].FIELDS|)), then:
    1) Trap.
12. If ((j + n) > |$elem(z, y).REFS|), then:
  a. If instr_u0 is of the case REF.ARRAY_ADDR, then:
    1) Trap.
  b. If ((n is 0) and (j < |$elem(z, y).REFS|)), then:
    1) Let ref be $elem(z, y).REFS[j].
    2) If instr_u0 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a) be instr_u0.
      b) Push the value (REF.ARRAY_ADDR a) to the stack.
      c) Push the value (I32.CONST i) to the stack.
      d) Push the value ref to the stack.
      e) Execute the instruction (ARRAY.SET x).
      f) Push the value (REF.ARRAY_ADDR a) to the stack.
      g) Push the value (I32.CONST (i + 1)) to the stack.
      h) Push the value (I32.CONST (j + 1)) to the stack.
      i) Push the value (I32.CONST (n - 1)) to the stack.
      j) Execute the instruction (ARRAY.INIT_ELEM x y).
13. Else if (n is 0), then:
  a. If instr_u0 is of the case REF.ARRAY_ADDR, then:
    1) Do nothing.
14. Else:
  a. If (j < |$elem(z, y).REFS|), then:
    1) Let ref be $elem(z, y).REFS[j].
    2) If instr_u0 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a) be instr_u0.
      b) Push the value (REF.ARRAY_ADDR a) to the stack.
      c) Push the value (I32.CONST i) to the stack.
      d) Push the value ref to the stack.
      e) Execute the instruction (ARRAY.SET x).
      f) Push the value (REF.ARRAY_ADDR a) to the stack.
      g) Push the value (I32.CONST (i + 1)) to the stack.
      h) Push the value (I32.CONST (j + 1)) to the stack.
      i) Push the value (I32.CONST (n - 1)) to the stack.
      j) Execute the instruction (ARRAY.INIT_ELEM x y).

execution_of_ARRAY.INIT_DATA x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST j) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. Assert: Due to validation, a value is on the top of the stack.
9. Pop the value instr_u0 from the stack.
10. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
11. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If ((a < |$arrayinst(z)|) and ((i + n) > |$arrayinst(z)[a].FIELDS|)), then:
    1) Trap.
12. If $expanddt($type(z, x)) is not of the case ARRAY, then:
  a. If ((n is 0) and instr_u0 is of the case REF.ARRAY_ADDR), then:
    1) Do nothing.
13. Else:
  a. Let (ARRAY arraytype_0) be $expanddt($type(z, x)).
  b. Let (mut, zt) be arraytype_0.
  c. If instr_u0 is of the case REF.ARRAY_ADDR, then:
    1) If ((j + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|), then:
      a) Trap.
    2) If (n is 0), then:
      a) Do nothing.
    3) Else:
      a) Let (ARRAY arraytype_0) be $expanddt($type(z, x)).
      b) Let (mut, zt) be arraytype_0.
      c) Let (REF.ARRAY_ADDR a) be instr_u0.
      d) Let c be $zbytes__1^-1(zt, $data(z, y).BYTES[j : ($zsize(zt) / 8)]).
      e) Push the value (REF.ARRAY_ADDR a) to the stack.
      f) Push the value (I32.CONST i) to the stack.
      g) Push the value $const($cunpack(zt), $cunpacknum_(zt, c)) to the stack.
      h) Execute the instruction (ARRAY.SET x).
      i) Push the value (REF.ARRAY_ADDR a) to the stack.
      j) Push the value (I32.CONST (i + 1)) to the stack.
      k) Push the value (I32.CONST (j + ($zsize(zt) / 8))) to the stack.
      l) Push the value (I32.CONST (n - 1)) to the stack.
      m) Execute the instruction (ARRAY.INIT_DATA x y).

execution_of_LOCAL.GET x
1. Let z be the current state.
2. Assert: Due to validation, $local(z, x) is defined.
3. Let ?(val) be $local(z, x).
4. Push the value val to the stack.

execution_of_GLOBAL.GET x
1. Let z be the current state.
2. Let val be $global(z, x).VALUE.
3. Push the value val to the stack.

execution_of_TABLE.GET x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If (i ≥ |$table(z, x).REFS|), then:
  a. Trap.
5. Push the value $table(z, x).REFS[i] to the stack.

execution_of_TABLE.SIZE x
1. Let z be the current state.
2. Let n be |$table(z, x).REFS|.
3. Push the value (I32.CONST n) to the stack.

execution_of_TABLE.FILL x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value val from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. If ((i + n) > |$table(z, x).REFS|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else:
  a. Push the value (I32.CONST i) to the stack.
  b. Push the value val to the stack.
  c. Execute the instruction (TABLE.SET x).
  d. Push the value (I32.CONST (i + 1)) to the stack.
  e. Push the value val to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (TABLE.FILL x).

execution_of_TABLE.COPY x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$table(z, y).REFS|), then:
  a. Trap.
9. If ((j + n) > |$table(z, x).REFS|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else:
  a. If (j ≤ i), then:
    1) Push the value (I32.CONST j) to the stack.
    2) Push the value (I32.CONST i) to the stack.
    3) Execute the instruction (TABLE.GET y).
    4) Execute the instruction (TABLE.SET x).
    5) Push the value (I32.CONST (j + 1)) to the stack.
    6) Push the value (I32.CONST (i + 1)) to the stack.
  b. Else:
    1) Push the value (I32.CONST ((j + n) - 1)) to the stack.
    2) Push the value (I32.CONST ((i + n) - 1)) to the stack.
    3) Execute the instruction (TABLE.GET y).
    4) Execute the instruction (TABLE.SET x).
    5) Push the value (I32.CONST j) to the stack.
    6) Push the value (I32.CONST i) to the stack.
  c. Push the value (I32.CONST (n - 1)) to the stack.
  d. Execute the instruction (TABLE.COPY x y).

execution_of_TABLE.INIT x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$elem(z, y).REFS|), then:
  a. Trap.
9. If ((j + n) > |$table(z, x).REFS|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else if (i < |$elem(z, y).REFS|), then:
  a. Push the value (I32.CONST j) to the stack.
  b. Push the value $elem(z, y).REFS[i] to the stack.
  c. Execute the instruction (TABLE.SET x).
  d. Push the value (I32.CONST (j + 1)) to the stack.
  e. Push the value (I32.CONST (i + 1)) to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (TABLE.INIT x y).

execution_of_LOAD numty_u0 loado_u2? x ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If loado_u2? is not defined, then:
  a. Let nt be numty_u0.
  b. If (((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, x).BYTES|), then:
    1) Trap.
  c. Let c be $nbytes__1^-1(nt, $mem(z, x).BYTES[(i + ao.OFFSET) : ($size(nt) / 8)]).
  d. Push the value (nt.CONST c) to the stack.
5. If the type of numty_u0 is Inn, then:
  a. If loado_u2? is defined, then:
    1) Let ?(loadop__0) be loado_u2?.
    2) Let (n, sx) be loadop__0.
    3) If (((i + ao.OFFSET) + (n / 8)) > |$mem(z, x).BYTES|), then:
      a) Trap.
  b. Let Inn be numty_u0.
  c. If loado_u2? is defined, then:
    1) Let ?(loadop__0) be loado_u2?.
    2) Let (n, sx) be loadop__0.
    3) Let c be $ibytes__1^-1(n, $mem(z, x).BYTES[(i + ao.OFFSET) : (n / 8)]).
    4) Push the value (Inn.CONST $extend__(n, $size(Inn), sx, c)) to the stack.

execution_of_VLOAD V128 vload_u0? x ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If ((((i + ao.OFFSET) + ($vsize(V128) / 8)) > |$mem(z, x).BYTES|) and vload_u0? is not defined), then:
  a. Trap.
5. If vload_u0? is not defined, then:
  a. Let c be $vbytes__1^-1(V128, $mem(z, x).BYTES[(i + ao.OFFSET) : ($vsize(V128) / 8)]).
  b. Push the value (V128.CONST c) to the stack.
6. Else:
  a. Let ?(vloadop__0) be vload_u0?.
  b. If vloadop__0 is of the case SHAPE, then:
    1) Let (SHAPE M K sx) be vloadop__0.
    2) If (((i + ao.OFFSET) + ((M · K) / 8)) > |$mem(z, x).BYTES|), then:
      a) Trap.
    3) If the type of $lsizenn^-1((M · 2)) is Jnn, then:
      a) Let Jnn be $lsizenn^-1((M · 2)).
      b) Let j^K be $ibytes__1^-1(M, $mem(z, x).BYTES[((i + ao.OFFSET) + ((k · M) / 8)) : (M / 8)])^(k<K).
      c) Let c be $invlanes_((Jnn X K), $extend__(M, $lsizenn(Jnn), sx, j)^K).
      d) Push the value (V128.CONST c) to the stack.
  c. If vloadop__0 is of the case SPLAT, then:
    1) Let (SPLAT N) be vloadop__0.
    2) If (((i + ao.OFFSET) + (N / 8)) > |$mem(z, x).BYTES|), then:
      a) Trap.
    3) Let M be (128 / N).
    4) If the type of $lsize^-1(N) is Jnn, then:
      a) Let Jnn be $lsize^-1(N).
      b) Let j be $ibytes__1^-1(N, $mem(z, x).BYTES[(i + ao.OFFSET) : (N / 8)]).
      c) Let c be $invlanes_((Jnn X M), j^M).
      d) Push the value (V128.CONST c) to the stack.
  d. If vloadop__0 is of the case ZERO, then:
    1) Let (ZERO N) be vloadop__0.
    2) If (((i + ao.OFFSET) + (N / 8)) > |$mem(z, x).BYTES|), then:
      a) Trap.
    3) Let j be $ibytes__1^-1(N, $mem(z, x).BYTES[(i + ao.OFFSET) : (N / 8)]).
    4) Let c be $extend__(N, 128, U, j).
    5) Push the value (V128.CONST c) to the stack.

execution_of_VLOAD_LANE V128 N x ao j
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value (V128.CONST c_1) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (((i + ao.OFFSET) + (N / 8)) > |$mem(z, x).BYTES|), then:
  a. Trap.
7. Let M be ($vsize(V128) / N).
8. If the type of $lsize^-1(N) is Jnn, then:
  a. Let Jnn be $lsize^-1(N).
  b. Let k be $ibytes__1^-1(N, $mem(z, x).BYTES[(i + ao.OFFSET) : (N / 8)]).
  c. Let c be $invlanes_((Jnn X M), $lanes_((Jnn X M), c_1) with [j] replaced by k).
  d. Push the value (V128.CONST c) to the stack.

execution_of_MEMORY.SIZE x
1. Let z be the current state.
2. Let (n · (64 · $Ki())) be |$mem(z, x).BYTES|.
3. Push the value (I32.CONST n) to the stack.

execution_of_MEMORY.FILL x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value val from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. If ((i + n) > |$mem(z, x).BYTES|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else:
  a. Push the value (I32.CONST i) to the stack.
  b. Push the value val to the stack.
  c. Execute the instruction (STORE I32 ?(8) x $memarg0()).
  d. Push the value (I32.CONST (i + 1)) to the stack.
  e. Push the value val to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (MEMORY.FILL x).

execution_of_MEMORY.COPY x_1 x_2
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i_2) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i_1) from the stack.
8. If ((i_1 + n) > |$mem(z, x_1).BYTES|), then:
  a. Trap.
9. If ((i_2 + n) > |$mem(z, x_2).BYTES|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else:
  a. If (i_1 ≤ i_2), then:
    1) Push the value (I32.CONST i_1) to the stack.
    2) Push the value (I32.CONST i_2) to the stack.
    3) Execute the instruction (LOAD I32 ?((8, U)) x_2 $memarg0()).
    4) Execute the instruction (STORE I32 ?(8) x_1 $memarg0()).
    5) Push the value (I32.CONST (i_1 + 1)) to the stack.
    6) Push the value (I32.CONST (i_2 + 1)) to the stack.
  b. Else:
    1) Push the value (I32.CONST ((i_1 + n) - 1)) to the stack.
    2) Push the value (I32.CONST ((i_2 + n) - 1)) to the stack.
    3) Execute the instruction (LOAD I32 ?((8, U)) x_2 $memarg0()).
    4) Execute the instruction (STORE I32 ?(8) x_1 $memarg0()).
    5) Push the value (I32.CONST i_1) to the stack.
    6) Push the value (I32.CONST i_2) to the stack.
  c. Push the value (I32.CONST (n - 1)) to the stack.
  d. Execute the instruction (MEMORY.COPY x_1 x_2).

execution_of_MEMORY.INIT x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$data(z, y).BYTES|), then:
  a. Trap.
9. If ((j + n) > |$mem(z, x).BYTES|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else if (i < |$data(z, y).BYTES|), then:
  a. Push the value (I32.CONST j) to the stack.
  b. Push the value (I32.CONST $data(z, y).BYTES[i]) to the stack.
  c. Execute the instruction (STORE I32 ?(8) x $memarg0()).
  d. Push the value (I32.CONST (j + 1)) to the stack.
  e. Push the value (I32.CONST (i + 1)) to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (MEMORY.INIT x y).

execution_of_CTXT
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_STRUCT.NEW x
1. Let z be the current state.
2. Let a be |$structinst(z)|.
3. Assert: Due to validation, $expanddt($type(z, x)) is of the case STRUCT.
4. Let (STRUCT fieldtype_0) be $expanddt($type(z, x)).
5. Let (mut, zt)^n be fieldtype_0.
6. Assert: Due to validation, there are at least n values on the top of the stack.
7. Pop the values val^n from the stack.
8. Let si be { TYPE: $type(z, x); FIELDS: $packfield_(zt, val)^n; }.
9. Push the value (REF.STRUCT_ADDR a) to the stack.
10. Perform $add_structinst(z, [si]).

execution_of_STRUCT.SET x i
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value instr_u0 from the stack.
6. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
7. Assert: Due to validation, $expanddt($type(z, x)) is of the case STRUCT.
8. Let (STRUCT fieldtype_0) be $expanddt($type(z, x)).
9. Let (mut, zt)* be fieldtype_0.
10. If instr_u0 is of the case REF.STRUCT_ADDR, then:
  a. Let (REF.STRUCT_ADDR a) be instr_u0.
  b. If ((|mut*| is |zt*|) and (i < |zt*|)), then:
    1) Perform $with_struct(z, a, i, $packfield_(zt*[i], val)).

execution_of_ARRAY.NEW_FIXED x n
1. Let z be the current state.
2. Assert: Due to validation, there are at least n values on the top of the stack.
3. Pop the values val^n from the stack.
4. Let a be |$arrayinst(z)|.
5. Assert: Due to validation, $expanddt($type(z, x)) is of the case ARRAY.
6. Let (ARRAY arraytype_0) be $expanddt($type(z, x)).
7. Let (mut, zt) be arraytype_0.
8. Let ai be { TYPE: $type(z, x); FIELDS: $packfield_(zt, val)^n; }.
9. Push the value (REF.ARRAY_ADDR a) to the stack.
10. Perform $add_arrayinst(z, [ai]).

execution_of_ARRAY.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value is on the top of the stack.
7. Pop the value instr_u0 from the stack.
8. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
9. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If ((a < |$arrayinst(z)|) and (i ≥ |$arrayinst(z)[a].FIELDS|)), then:
    1) Trap.
10. Assert: Due to validation, $expanddt($type(z, x)) is of the case ARRAY.
11. Let (ARRAY arraytype_0) be $expanddt($type(z, x)).
12. Let (mut, zt) be arraytype_0.
13. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. Perform $with_array(z, a, i, $packfield_(zt, val)).

execution_of_LOCAL.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Perform $with_local(z, x, val).

execution_of_GLOBAL.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Perform $with_global(z, x, val).

execution_of_TABLE.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value ref from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (i ≥ |$table(z, x).REFS|), then:
  a. Trap.
7. Perform $with_table(z, x, i, ref).

execution_of_TABLE.GROW x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value ref from the stack.
6. Either:
  a. Let ti be $growtable($table(z, x), n, ref).
  b. Push the value (I32.CONST |$table(z, x).REFS|) to the stack.
  c. Perform $with_tableinst(z, x, ti).
7. Or:
  a. Push the value (I32.CONST $invsigned_(32, (- 1))) to the stack.

execution_of_ELEM.DROP x
1. Let z be the current state.
2. Perform $with_elem(z, x, []).

execution_of_STORE nt sz_u1? x ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type numty_u0 is on the top of the stack.
3. Pop the value (numty_u0.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (numty_u0 is nt), then:
  a. If ((((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, x).BYTES|) and sz_u1? is not defined), then:
    1) Trap.
  b. If sz_u1? is not defined, then:
    1) Let b* be $nbytes_(nt, c).
    2) Perform $with_mem(z, x, (i + ao.OFFSET), ($size(nt) / 8), b*).
7. If the type of numty_u0 is Inn, then:
  a. If sz_u1? is defined, then:
    1) Let ?(n) be sz_u1?.
    2) If (((i + ao.OFFSET) + (n / 8)) > |$mem(z, x).BYTES|), then:
      a) Trap.
  b. Let Inn be numty_u0.
  c. If sz_u1? is defined, then:
    1) Let ?(n) be sz_u1?.
    2) Let b* be $ibytes_(n, $wrap__($size(Inn), n, c)).
    3) Perform $with_mem(z, x, (i + ao.OFFSET), (n / 8), b*).

execution_of_VSTORE V128 x ao
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value (V128.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (((i + ao.OFFSET) + ($vsize(V128) / 8)) > |$mem(z, x).BYTES|), then:
  a. Trap.
7. Let b* be $vbytes_(V128, c).
8. Perform $with_mem(z, x, (i + ao.OFFSET), ($vsize(V128) / 8), b*).

execution_of_VSTORE_LANE V128 N x ao j
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value (V128.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (((i + ao.OFFSET) + N) > |$mem(z, x).BYTES|), then:
  a. Trap.
7. Let M be (128 / N).
8. If the type of $lsize^-1(N) is Jnn, then:
  a. Let Jnn be $lsize^-1(N).
  b. If (j < |$lanes_((Jnn X M), c)|), then:
    1) Let b* be $ibytes_(N, $lanes_((Jnn X M), c)[j]).
    2) Perform $with_mem(z, x, (i + ao.OFFSET), (N / 8), b*).

execution_of_MEMORY.GROW x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Either:
  a. Let mi be $growmem($mem(z, x), n).
  b. Push the value (I32.CONST (|$mem(z, x).BYTES| / (64 · $Ki()))) to the stack.
  c. Perform $with_meminst(z, x, mi).
5. Or:
  a. Push the value (I32.CONST $invsigned_(32, (- 1))) to the stack.

execution_of_DATA.DROP x
1. Let z be the current state.
2. Perform $with_data(z, x, []).

eval_expr instr*
1. Execute the instruction instr*.
2. Pop the value val from the stack.
3. Return [val].

group_bytes_by n byte*
1. Let n' be |byte*|.
2. If (n' ≥ n), then:
  a. Return [byte*[0 : n]] ++ $group_bytes_by(n, byte*[n : (n' - n)]).
3. Return [].

execution_of_ARRAY.NEW_DATA x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If $expanddt($type(z, x)) is of the case ARRAY, then:
  a. Let (ARRAY y_0) be $expanddt($type(z, x)).
  b. Let (mut, zt) be y_0.
  c. If ((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|), then:
    1) Trap.
  d. Let cnn be $cunpack(zt).
  e. Let b* be $data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)].
  f. Let gb* be $group_bytes_by(($zsize(zt) / 8), b*).
  g. Let c^n be $inverse_of_ibytes($zsize(zt), gb)*.
  h. Push the values (cnn.CONST c)^n to the stack.
  i. Execute the instruction (ARRAY.NEW_FIXED x n).
== Complete.
```
