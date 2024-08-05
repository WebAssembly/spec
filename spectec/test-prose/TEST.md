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
Limits_ok
- the limits (n, m) is valid with the nat k if and only if:
  - n is less than or equal to m.
  - m is less than or equal to k.

Functype_ok
- the function type (t_1* -> t_2?) is valid.

Globaltype_ok
- the global type ((MUT ()?), t) is valid.

Tabletype_ok
- the table type limits is valid if and only if:
  - the limits limits is valid with the nat ((2 ^ 32) - 1).

Memtype_ok
- the memory type limits is valid if and only if:
  - the limits limits is valid with the nat (2 ^ 16).

Externtype_ok
- the external type externtype_u0 is valid if and only if:
  - Either:
    - externtype_u0 is (FUNC functype).
    - the function type functype is valid.
  - Or:
    - externtype_u0 is (GLOBAL globaltype).
    - the global type globaltype is valid.
  - Or:
    - externtype_u0 is (TABLE tabletype).
    - the table type tabletype is valid.
  - Or:
    - externtype_u0 is (MEM memtype).
    - the memory type memtype is valid.

Limits_sub
- the limits (n_11, n_12) matches the limits (n_21, n_22) if and only if:
  - n_11 is greater than or equal to n_21.
  - n_12 is less than or equal to n_22.

Functype_sub
- the function type ft matches the function type ft.

Globaltype_sub
- the global type gt matches the global type gt.

Tabletype_sub
- the table type lim_1 matches the table type lim_2 if and only if:
  - the limits lim_1 matches the limits lim_2.

Memtype_sub
- the memory type lim_1 matches the memory type lim_2 if and only if:
  - the limits lim_1 matches the limits lim_2.

Externtype_sub
- the external type externtype_u0 matches the external type externtype_u1 if and only if:
  - Either:
    - externtype_u0 is (FUNC ft_1).
    - externtype_u1 is (FUNC ft_2).
    - the function type ft_1 matches the function type ft_2.
  - Or:
    - externtype_u0 is (GLOBAL gt_1).
    - externtype_u1 is (GLOBAL gt_2).
    - the global type gt_1 matches the global type gt_2.
  - Or:
    - externtype_u0 is (TABLE tt_1).
    - externtype_u1 is (TABLE tt_2).
    - the table type tt_1 matches the table type tt_2.
  - Or:
    - externtype_u0 is (MEM mt_1).
    - externtype_u1 is (MEM mt_2).
    - the memory type mt_1 matches the memory type mt_2.

Instr_ok/nop
- the instr NOP is valid with the function type ([] -> []).

Instr_ok/unreachable
- the instr UNREACHABLE is valid with the function type (t_1* -> t_2*).

Instr_ok/drop
- the instr DROP is valid with the function type ([t] -> []).

Instr_ok/select
- the instr SELECT is valid with the function type ([t, t, I32] -> [t]).

Instr_ok/block
- the instr (BLOCK t? instr*) is valid with the function type ([] -> t?) if and only if:
  - Under the context prepend(C.LABELS, [t?]), the instr sequence instr* is valid with the function type ([] -> t?).

Instr_ok/loop
- the instr (LOOP t? instr*) is valid with the function type ([] -> t?) if and only if:
  - Under the context prepend(C.LABELS, [?()]), the instr sequence instr* is valid with the function type ([] -> []).

Instr_ok/if
- the instr (IF t? instr_1* instr_2*) is valid with the function type ([I32] -> t?) if and only if:
  - Under the context prepend(C.LABELS, [t?]), the instr sequence instr_1* is valid with the function type ([] -> t?).
  - Under the context prepend(C.LABELS, [t?]), the instr sequence instr_2* is valid with the function type ([] -> t?).

Instr_ok/br
- the instr (BR l) is valid with the function type (t_1* ++ t? -> t_2*) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t?.

Instr_ok/br_if
- the instr (BR_IF l) is valid with the function type (t? ++ [I32] -> t?) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t?.

Instr_ok/br_table
- the instr (BR_TABLE l* l') is valid with the function type (t_1* ++ t? -> t_2*) if and only if:
  - |C.LABELS| is greater than l'.
  - For all l in l*,
    - |C.LABELS| is greater than l.
  - t? is C.LABELS[l'].
  - For all l in l*,
    - t? is C.LABELS[l].

Instr_ok/call
- the instr (CALL x) is valid with the function type (t_1* -> t_2?) if and only if:
  - |C.FUNCS| is greater than x.
  - C.FUNCS[x] is (t_1* -> t_2?).

Instr_ok/call_indirect
- the instr (CALL_INDIRECT x) is valid with the function type (t_1* ++ [I32] -> t_2?) if and only if:
  - |C.TYPES| is greater than x.
  - C.TYPES[x] is (t_1* -> t_2?).

Instr_ok/return
- the instr RETURN is valid with the function type (t_1* ++ t? -> t_2*) if and only if:
  - C.RETURN is ?(t?).

Instr_ok/const
- the instr (t.CONST c_t) is valid with the function type ([] -> [t]).

Instr_ok/unop
- the instr (UNOP t unop_t) is valid with the function type ([t] -> [t]).

Instr_ok/binop
- the instr (BINOP t binop_t) is valid with the function type ([t, t] -> [t]).

Instr_ok/testop
- the instr (TESTOP t testop_t) is valid with the function type ([t] -> [I32]).

Instr_ok/relop
- the instr (RELOP t relop_t) is valid with the function type ([t, t] -> [I32]).

Instr_ok/cvtop
- the instr (CVTOP nt_1 nt_2 REINTERPRET) is valid with the function type ([nt_2] -> [nt_1]) if and only if:
  - $size(nt_1) is $size(nt_2).

Instr_ok/local.get
- the instr (LOCAL.GET x) is valid with the function type ([] -> [t]) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is t.

Instr_ok/local.set
- the instr (LOCAL.SET x) is valid with the function type ([t] -> []) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is t.

Instr_ok/local.tee
- the instr (LOCAL.TEE x) is valid with the function type ([t] -> [t]) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is t.

Instr_ok/global.get
- the instr (GLOBAL.GET x) is valid with the function type ([] -> [t]) if and only if:
  - |C.GLOBALS| is greater than x.
  - C.GLOBALS[x] is (mut, t).

Instr_ok/global.set
- the instr (GLOBAL.SET x) is valid with the function type ([t] -> []) if and only if:
  - |C.GLOBALS| is greater than x.
  - C.GLOBALS[x] is ((MUT ?(())), t).

Instr_ok/memory.size
- the instr MEMORY.SIZE is valid with the function type ([] -> [I32]) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.

Instr_ok/memory.grow
- the instr MEMORY.GROW is valid with the function type ([I32] -> [I32]) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.

Instr_ok/load
- the instr (LOAD nt (n, sx)? memarg) is valid with the function type ([I32] -> [nt]) if and only if:
  - |C.MEMS| is greater than 0.
  - ((sx? == ?())) if and only if ((n? == ?())).
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(nt) / 8).
  - If n != None,
    - (2 ^ memarg.ALIGN) is less than or equal to (n / 8).
    - (n / 8) is less than ($size(nt) / 8).
  - If n != None,
    - nt is Inn.

Instr_ok/store
- the instr (STORE nt n? memarg) is valid with the function type ([I32, nt] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(nt) / 8).
  - If n != None,
    - (2 ^ memarg.ALIGN) is less than or equal to (n / 8).
    - (n / 8) is less than ($size(nt) / 8).
  - If n != None,
    - nt is Inn.

Instrs_ok
- the instr sequence instr_u0* is valid with the function type (valtype_u1* -> valtype_u2*) if and only if:
  - Either:
    - instr_u0* is [].
    - valtype_u1* is [].
    - valtype_u2* is [].
  - Or:
    - instr_u0* is [instr_1] ++ instr_2*.
    - valtype_u1* is t_1*.
    - valtype_u2* is t_3*.
    - the instr instr_1 is valid with the function type (t_1* -> t_2*).
    - the instr sequence [instr_2] is valid with the function type (t_2* -> t_3*).
  - Or:
    - instr_u0* is instr*.
    - valtype_u1* is t* ++ t_1*.
    - valtype_u2* is t* ++ t_2*.
    - the instr sequence instr* is valid with the function type (t_1* -> t_2*).

Expr_ok
- the expression instr* is valid with the result type t? if and only if:
  - the instr sequence instr* is valid with the function type ([] -> t?).

Instr_const
- the instr instr_u0 is constant if and only if:
  - Either:
    - instr_u0 is (t.CONST c).
  - Or:
    - instr_u0 is (GLOBAL.GET x).
    - |C.GLOBALS| is greater than x.
    - C.GLOBALS[x] is ((MUT ?()), t).

Expr_const
- the expression instr* is constant if and only if:
  - For all instr in instr*,
    - the instr instr is constant.

Type_ok
- the type (TYPE ft) is valid with the function type ft if and only if:
  - the function type ft is valid.

Func_ok
- the function (FUNC x (LOCAL t)* expr) is valid with the function type (t_1* -> t_2?) if and only if:
  - |C.TYPES| is greater than x.
  - C.TYPES[x] is (t_1* -> t_2?).
  - Under the context append(append(append(C.LOCALS, t_1* ++ t*).LABELS, [t_2?]).RETURN, ?(t_2?)), the expression expr is valid with the result type t_2?.

Global_ok
- the global (GLOBAL gt expr) is valid with the global type gt if and only if:
  - the global type gt is valid.
  - gt is (mut, t).
  - the expression expr is valid with the number type sequence ?(t).
  - the expression expr is constant.

Table_ok
- the table (TABLE tt) is valid with the table type tt if and only if:
  - the table type tt is valid.

Mem_ok
- the memory (MEMORY mt) is valid with the memory type mt if and only if:
  - the memory type mt is valid.

Elem_ok
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

Data_ok
- the memory segment (DATA expr b*) is valid if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is lim.
  - the expression expr is valid with the number type sequence ?(I32).
  - the expression expr is constant.

Start_ok
- the start function (START x) is valid if and only if:
  - |C.FUNCS| is greater than x.
  - C.FUNCS[x] is ([] -> []).

Import_ok
- the import (IMPORT name_1 name_2 xt) is valid with the external type xt if and only if:
  - the external type xt is valid.

Externidx_ok
- the external index externidx_u0 is valid with the external type externtype_u1 if and only if:
  - Either:
    - externidx_u0 is (FUNC x).
    - externtype_u1 is (FUNC ft).
    - |C.FUNCS| is greater than x.
    - C.FUNCS[x] is ft.
  - Or:
    - externidx_u0 is (GLOBAL x).
    - externtype_u1 is (GLOBAL gt).
    - |C.GLOBALS| is greater than x.
    - C.GLOBALS[x] is gt.
  - Or:
    - externidx_u0 is (TABLE x).
    - externtype_u1 is (TABLE tt).
    - |C.TABLES| is greater than x.
    - C.TABLES[x] is tt.
  - Or:
    - externidx_u0 is (MEM x).
    - externtype_u1 is (MEM mt).
    - |C.MEMS| is greater than x.
    - C.MEMS[x] is mt.

Export_ok
- the export (EXPORT name externidx) is valid with the external type xt if and only if:
  - the external index externidx is valid with the external type xt.

Module_ok
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
  - If start != None,
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

Ki {
 Return 1024
}

min n_u0 n_u1 {
 If ((n_u0 == 0)) {
   Return 0
 }
 If ((n_u1 == 0)) {
   Return 0
 }
 Assert((n_u0 ≥ 1))
 Let i = (n_u0 - 1)
 Assert((n_u1 ≥ 1))
 Let j = (n_u1 - 1)
 Return $min(i, j)
}

sum n_u0* {
 If ((n_u0* == [])) {
   Return 0
 }
 Let [n] ++ n'* = n_u0*
 Return (n + $sum(n'*))
}

opt_ X X_u0* {
 If ((X_u0* == [])) {
   Return ?()
 }
 Assert((|X_u0*| == 1))
 Let [w] = X_u0*
 Return ?(w)
}

list_ X X_u0? {
 If (!(X_u0? != None)) {
   Return []
 }
 Let ?(w) = X_u0?
 Return [w]
}

concat_ X X_u0* {
 If ((X_u0* == [])) {
   Return []
 }
 Let [w*] ++ w'** = X_u0*
 Return w* ++ $concat_(X, w'**)
}

signif N_u0 {
 If ((N_u0 == 32)) {
   Return 23
 }
 Assert((N_u0 == 64))
 Return 52
}

expon N_u0 {
 If ((N_u0 == 32)) {
   Return 8
 }
 Assert((N_u0 == 64))
 Return 11
}

M N {
 Return $signif(N)
}

E N {
 Return $expon(N)
}

fzero N {
 Return (POS (SUBNORM 0))
}

fone N {
 Return (POS (NORM 1 0))
}

canon_ N {
 Return (2 ^ ($signif(N) - 1))
}

size valtype_u0 {
 If ((valtype_u0 == I32)) {
   Return 32
 }
 If ((valtype_u0 == I64)) {
   Return 64
 }
 If ((valtype_u0 == F32)) {
   Return 32
 }
 If ((valtype_u0 == F64)) {
   Return 64
 }
}

funcsxt externtype_u0* {
 If ((externtype_u0* == [])) {
   Return []
 }
 Let [externtype_0] ++ xt* = externtype_u0*
 If (case(externtype_0) == FUNC) {
   Let (FUNC ft) = externtype_0
   Return [ft] ++ $funcsxt(xt*)
 }
 Let [externtype] ++ xt* = externtype_u0*
 Return $funcsxt(xt*)
}

globalsxt externtype_u0* {
 If ((externtype_u0* == [])) {
   Return []
 }
 Let [externtype_0] ++ xt* = externtype_u0*
 If (case(externtype_0) == GLOBAL) {
   Let (GLOBAL gt) = externtype_0
   Return [gt] ++ $globalsxt(xt*)
 }
 Let [externtype] ++ xt* = externtype_u0*
 Return $globalsxt(xt*)
}

tablesxt externtype_u0* {
 If ((externtype_u0* == [])) {
   Return []
 }
 Let [externtype_0] ++ xt* = externtype_u0*
 If (case(externtype_0) == TABLE) {
   Let (TABLE tt) = externtype_0
   Return [tt] ++ $tablesxt(xt*)
 }
 Let [externtype] ++ xt* = externtype_u0*
 Return $tablesxt(xt*)
}

memsxt externtype_u0* {
 If ((externtype_u0* == [])) {
   Return []
 }
 Let [externtype_0] ++ xt* = externtype_u0*
 If (case(externtype_0) == MEM) {
   Let (MEM mt) = externtype_0
   Return [mt] ++ $memsxt(xt*)
 }
 Let [externtype] ++ xt* = externtype_u0*
 Return $memsxt(xt*)
}

memarg0 {
 Return { ALIGN: 0; OFFSET: 0; }
}

signed_ N i {
 If ((0 ≤ (2 ^ (N - 1)))) {
   Return i
 }
 Assert(((2 ^ (N - 1)) ≤ i))
 Assert((i < (2 ^ N)))
 Return (i - (2 ^ N))
}

invsigned_ N ii {
 Let j = $signed__1^-1(N, ii)
 Return j
}

unop_ valtype_u1 unop__u0 val__u3 {
 If (((unop__u0 == CLZ) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN = val__u3
   Return [$iclz_($size(Inn), iN)]
 }
 If (((unop__u0 == CTZ) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN = val__u3
   Return [$ictz_($size(Inn), iN)]
 }
 If (((unop__u0 == POPCNT) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN = val__u3
   Return [$ipopcnt_($size(Inn), iN)]
 }
 If (((unop__u0 == ABS) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN = val__u3
   Return $fabs_($size(Fnn), fN)
 }
 If (((unop__u0 == NEG) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN = val__u3
   Return $fneg_($size(Fnn), fN)
 }
 If (((unop__u0 == SQRT) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN = val__u3
   Return $fsqrt_($size(Fnn), fN)
 }
 If (((unop__u0 == CEIL) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN = val__u3
   Return $fceil_($size(Fnn), fN)
 }
 If (((unop__u0 == FLOOR) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN = val__u3
   Return $ffloor_($size(Fnn), fN)
 }
 If (((unop__u0 == TRUNC) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN = val__u3
   Return $ftrunc_($size(Fnn), fN)
 }
 Assert((unop__u0 == NEAREST))
 Assert(type(valtype_u1) == Fnn)
 Let Fnn = valtype_u1
 Let fN = val__u3
 Return $fnearest_($size(Fnn), fN)
}

binop_ valtype_u1 binop__u0 val__u3 val__u5 {
 If (((binop__u0 == ADD) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$iadd_($size(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == SUB) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$isub_($size(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == MUL) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$imul_($size(Inn), iN_1, iN_2)]
 }
 If (type(valtype_u1) == Inn) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   If (case(binop__u0) == DIV) {
     Let (DIV sx) = binop__u0
     Return $list_(val_((Inn : Inn <: valtype)), $idiv_($size(Inn), sx, iN_1, iN_2))
   }
   If (case(binop__u0) == REM) {
     Let (REM sx) = binop__u0
     Return $list_(val_((Inn : Inn <: valtype)), $irem_($size(Inn), sx, iN_1, iN_2))
   }
 }
 If (((binop__u0 == AND) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$iand_($size(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == OR) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$ior_($size(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == XOR) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$ixor_($size(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == SHL) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$ishl_($size(Inn), iN_1, iN_2)]
 }
 If (type(valtype_u1) == Inn) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   If (case(binop__u0) == SHR) {
     Let (SHR sx) = binop__u0
     Return [$ishr_($size(Inn), sx, iN_1, iN_2)]
   }
 }
 If (((binop__u0 == ROTL) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$irotl_($size(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == ROTR) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$irotr_($size(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == ADD) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $fadd_($size(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == SUB) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $fsub_($size(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == MUL) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $fmul_($size(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == DIV) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $fdiv_($size(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == MIN) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $fmin_($size(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == MAX) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $fmax_($size(Fnn), fN_1, fN_2)
 }
 Assert((binop__u0 == COPYSIGN))
 Assert(type(valtype_u1) == Fnn)
 Let Fnn = valtype_u1
 Let fN_1 = val__u3
 Let fN_2 = val__u5
 Return $fcopysign_($size(Fnn), fN_1, fN_2)
}

testop_ Inn EQZ iN {
 Return $ieqz_($size(Inn), iN)
}

relop_ valtype_u1 relop__u0 val__u3 val__u5 {
 If (((relop__u0 == EQ) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return $ieq_($size(Inn), iN_1, iN_2)
 }
 If (((relop__u0 == NE) && type(valtype_u1) == Inn)) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return $ine_($size(Inn), iN_1, iN_2)
 }
 If (type(valtype_u1) == Inn) {
   Let Inn = valtype_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   If (case(relop__u0) == LT) {
     Let (LT sx) = relop__u0
     Return $ilt_($size(Inn), sx, iN_1, iN_2)
   }
   If (case(relop__u0) == GT) {
     Let (GT sx) = relop__u0
     Return $igt_($size(Inn), sx, iN_1, iN_2)
   }
   If (case(relop__u0) == LE) {
     Let (LE sx) = relop__u0
     Return $ile_($size(Inn), sx, iN_1, iN_2)
   }
   If (case(relop__u0) == GE) {
     Let (GE sx) = relop__u0
     Return $ige_($size(Inn), sx, iN_1, iN_2)
   }
 }
 If (((relop__u0 == EQ) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $feq_($size(Fnn), fN_1, fN_2)
 }
 If (((relop__u0 == NE) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $fne_($size(Fnn), fN_1, fN_2)
 }
 If (((relop__u0 == LT) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $flt_($size(Fnn), fN_1, fN_2)
 }
 If (((relop__u0 == GT) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $fgt_($size(Fnn), fN_1, fN_2)
 }
 If (((relop__u0 == LE) && type(valtype_u1) == Fnn)) {
   Let Fnn = valtype_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $fle_($size(Fnn), fN_1, fN_2)
 }
 Assert((relop__u0 == GE))
 Assert(type(valtype_u1) == Fnn)
 Let Fnn = valtype_u1
 Let fN_1 = val__u3
 Let fN_2 = val__u5
 Return $fge_($size(Fnn), fN_1, fN_2)
}

cvtop__ valtype_u0 valtype_u1 cvtop_u2 val__u4 {
 If (((valtype_u0 == I32) && (valtype_u1 == I64))) {
   Let iN = val__u4
   If (case(cvtop_u2) == EXTEND) {
     Let (EXTEND sx) = cvtop_u2
     Return [$extend__(32, 64, sx, iN)]
   }
 }
 If (((valtype_u0 == I64) && ((valtype_u1 == I32) && (cvtop_u2 == WRAP)))) {
   Let iN = val__u4
   Return [$wrap__(64, 32, iN)]
 }
 If (type(valtype_u0) == Fnn) {
   Let Fnn = valtype_u0
   If (type(valtype_u1) == Inn) {
     Let Inn = valtype_u1
     Let fN = val__u4
     If (case(cvtop_u2) == TRUNC) {
       Let (TRUNC sx) = cvtop_u2
       Return $list_(val_((Inn : Inn <: valtype)), $trunc__($size(Fnn), $size(Inn), sx, fN))
     }
   }
 }
 If (((valtype_u0 == F32) && ((valtype_u1 == F64) && (cvtop_u2 == PROMOTE)))) {
   Let fN = val__u4
   Return $promote__(32, 64, fN)
 }
 If (((valtype_u0 == F64) && ((valtype_u1 == F32) && (cvtop_u2 == DEMOTE)))) {
   Let fN = val__u4
   Return $demote__(64, 32, fN)
 }
 If (type(valtype_u1) == Fnn) {
   Let Fnn = valtype_u1
   If (type(valtype_u0) == Inn) {
     Let Inn = valtype_u0
     Let iN = val__u4
     If (case(cvtop_u2) == CONVERT) {
       Let (CONVERT sx) = cvtop_u2
       Return [$convert__($size(Inn), $size(Fnn), sx, iN)]
     }
   }
 }
 Assert((cvtop_u2 == REINTERPRET))
 If (type(valtype_u1) == Fnn) {
   Let Fnn = valtype_u1
   If (type(valtype_u0) == Inn) {
     Let Inn = valtype_u0
     Let iN = val__u4
     If (($size(Inn) == $size(Fnn))) {
       Return [$reinterpret__(Inn, Fnn, iN)]
     }
   }
 }
 Assert(type(valtype_u0) == Fnn)
 Let Fnn = valtype_u0
 Assert(type(valtype_u1) == Inn)
 Let Inn = valtype_u1
 Let fN = val__u4
 Assert(($size(Inn) == $size(Fnn)))
 Return [$reinterpret__(Fnn, Inn, fN)]
}

invibytes_ N b* {
 Let n = $ibytes__1^-1(N, b*)
 Return n
}

invfbytes_ N b* {
 Let p = $fbytes__1^-1(N, b*)
 Return p
}

default_ valtype_u0 {
 If ((valtype_u0 == I32)) {
   Return (I32.CONST 0)
 }
 If ((valtype_u0 == I64)) {
   Return (I64.CONST 0)
 }
 If ((valtype_u0 == F32)) {
   Return (F32.CONST $fzero(32))
 }
 Assert((valtype_u0 == F64))
 Return (F64.CONST $fzero(64))
}

funcsxv externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ xv* = externval_u0*
 If (case(externval_0) == FUNC) {
   Let (FUNC fa) = externval_0
   Return [fa] ++ $funcsxv(xv*)
 }
 Let [externval] ++ xv* = externval_u0*
 Return $funcsxv(xv*)
}

globalsxv externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ xv* = externval_u0*
 If (case(externval_0) == GLOBAL) {
   Let (GLOBAL ga) = externval_0
   Return [ga] ++ $globalsxv(xv*)
 }
 Let [externval] ++ xv* = externval_u0*
 Return $globalsxv(xv*)
}

tablesxv externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ xv* = externval_u0*
 If (case(externval_0) == TABLE) {
   Let (TABLE ta) = externval_0
   Return [ta] ++ $tablesxv(xv*)
 }
 Let [externval] ++ xv* = externval_u0*
 Return $tablesxv(xv*)
}

memsxv externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ xv* = externval_u0*
 If (case(externval_0) == MEM) {
   Let (MEM ma) = externval_0
   Return [ma] ++ $memsxv(xv*)
 }
 Let [externval] ++ xv* = externval_u0*
 Return $memsxv(xv*)
}

store {
 Return
}

frame {
 Let f = current_frame()
 Return f
}

funcaddr {
 Let f = current_frame()
 Return f.MODULE.FUNCS
}

funcinst {
 Return s.FUNCS
}

globalinst {
 Return s.GLOBALS
}

tableinst {
 Return s.TABLES
}

meminst {
 Return s.MEMS
}

moduleinst {
 Let f = current_frame()
 Return f.MODULE
}

type x {
 Let f = current_frame()
 Return f.MODULE.TYPES[x]
}

func x {
 Let f = current_frame()
 Return s.FUNCS[f.MODULE.FUNCS[x]]
}

global x {
 Let f = current_frame()
 Return s.GLOBALS[f.MODULE.GLOBALS[x]]
}

table x {
 Let f = current_frame()
 Return s.TABLES[f.MODULE.TABLES[x]]
}

mem x {
 Let f = current_frame()
 Return s.MEMS[f.MODULE.MEMS[x]]
}

local x {
 Let f = current_frame()
 Return f.LOCALS[x]
}

with_local x v {
 Let f = current_frame()
 f.LOCALS[x] := v
}

with_global x v {
 Let f = current_frame()
 s.GLOBALS[f.MODULE.GLOBALS[x]].VALUE := v
}

with_table x i a {
 Let f = current_frame()
 s.TABLES[f.MODULE.TABLES[x]].REFS[i] := ?(a)
}

with_tableinst x ti {
 Let f = current_frame()
 s.TABLES[f.MODULE.TABLES[x]] := ti
}

with_mem x i j b* {
 Let f = current_frame()
 s.MEMS[f.MODULE.MEMS[x]].BYTES[i : j] := b*
}

with_meminst x mi {
 Let f = current_frame()
 s.MEMS[f.MODULE.MEMS[x]] := mi
}

growtable ti n {
 Let { TYPE: (i, j); REFS: ?(a)*; } = ti
 Let i' = (|a*| + n)
 If ((i' ≤ j)) {
   Let ti' = { TYPE: (i', j); REFS: ?(a)* ++ ?()^n; }
   Return ti'
 }
}

growmemory mi n {
 Let { TYPE: (i, j); BYTES: b*; } = mi
 Let i' = ((|b*| / (64 · $Ki())) + n)
 If ((i' ≤ j)) {
   Let mi' = { TYPE: (i', j); BYTES: b* ++ 0^(n · (64 · $Ki())); }
   Return mi'
 }
}

funcs externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ externval'* = externval_u0*
 If (case(externval_0) == FUNC) {
   Let (FUNC fa) = externval_0
   Return [fa] ++ $funcs(externval'*)
 }
 Let [externval] ++ externval'* = externval_u0*
 Return $funcs(externval'*)
}

globals externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ externval'* = externval_u0*
 If (case(externval_0) == GLOBAL) {
   Let (GLOBAL ga) = externval_0
   Return [ga] ++ $globals(externval'*)
 }
 Let [externval] ++ externval'* = externval_u0*
 Return $globals(externval'*)
}

tables externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ externval'* = externval_u0*
 If (case(externval_0) == TABLE) {
   Let (TABLE ta) = externval_0
   Return [ta] ++ $tables(externval'*)
 }
 Let [externval] ++ externval'* = externval_u0*
 Return $tables(externval'*)
}

mems externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ externval'* = externval_u0*
 If (case(externval_0) == MEM) {
   Let (MEM ma) = externval_0
   Return [ma] ++ $mems(externval'*)
 }
 Let [externval] ++ externval'* = externval_u0*
 Return $mems(externval'*)
}

allocfunc moduleinst func {
 Assert(case(func) == FUNC)
 Let (FUNC x local* expr) = func
 Let fi = { TYPE: moduleinst.TYPES[x]; MODULE: moduleinst; CODE: func; }
 Let a = |s.FUNCS|
 fi :+ s.FUNCS
 Return a
}

allocfuncs moduleinst func_u0* {
 If ((func_u0* == [])) {
   Return []
 }
 Let [func] ++ func'* = func_u0*
 Let fa = $allocfunc(moduleinst, func)
 Let fa'* = $allocfuncs(moduleinst, func'*)
 Return [fa] ++ fa'*
}

allocglobal globaltype val {
 Let gi = { TYPE: globaltype; VALUE: val; }
 Let a = |s.GLOBALS|
 gi :+ s.GLOBALS
 Return a
}

allocglobals globaltype_u0* val_u1* {
 If ((globaltype_u0* == [])) {
   Assert((val_u1* == []))
   Return []
 }
 Else {
   Let [globaltype] ++ globaltype'* = globaltype_u0*
   Assert((|val_u1*| ≥ 1))
   Let [val] ++ val'* = val_u1*
   Let ga = $allocglobal(globaltype, val)
   Let ga'* = $allocglobals(globaltype'*, val'*)
   Return [ga] ++ ga'*
 }
}

alloctable (i, j) {
 Let ti = { TYPE: (i, j); REFS: ?()^i; }
 Let a = |s.TABLES|
 ti :+ s.TABLES
 Return a
}

alloctables tabletype_u0* {
 If ((tabletype_u0* == [])) {
   Return []
 }
 Let [tabletype] ++ tabletype'* = tabletype_u0*
 Let ta = $alloctable(tabletype)
 Let ta'* = $alloctables(tabletype'*)
 Return [ta] ++ ta'*
}

allocmem (i, j) {
 Let mi = { TYPE: (i, j); BYTES: 0^(i · (64 · $Ki())); }
 Let a = |s.MEMS|
 mi :+ s.MEMS
 Return a
}

allocmems memtype_u0* {
 If ((memtype_u0* == [])) {
   Return []
 }
 Let [memtype] ++ memtype'* = memtype_u0*
 Let ma = $allocmem(memtype)
 Let ma'* = $allocmems(memtype'*)
 Return [ma] ++ ma'*
}

instexport fa* ga* ta* ma* (EXPORT name externidx_u0) {
 If (case(externidx_u0) == FUNC) {
   Let (FUNC x) = externidx_u0
   Return { NAME: name; VALUE: (FUNC fa*[x]); }
 }
 If (case(externidx_u0) == GLOBAL) {
   Let (GLOBAL x) = externidx_u0
   Return { NAME: name; VALUE: (GLOBAL ga*[x]); }
 }
 If (case(externidx_u0) == TABLE) {
   Let (TABLE x) = externidx_u0
   Return { NAME: name; VALUE: (TABLE ta*[x]); }
 }
 Assert(case(externidx_u0) == MEM)
 Let (MEM x) = externidx_u0
 Return { NAME: name; VALUE: (MEM ma*[x]); }
}

allocmodule module externval* val* {
 Let fa_ex* = $funcs(externval*)
 Let ga_ex* = $globals(externval*)
 Let ma_ex* = $mems(externval*)
 Let ta_ex* = $tables(externval*)
 Assert(case(module) == MODULE)
 Let (MODULE type_0 import* func^n_func global_1 table_2 mem_3 elem* data* start? export*) = module
 Assert(case(mem_3) == MEMORY)
 Let (MEMORY memtype)^n_mem = mem_3
 Assert(case(table_2) == TABLE)
 Let (TABLE tabletype)^n_table = table_2
 Assert(case(global_1) == GLOBAL)
 Let (GLOBAL globaltype expr_1)^n_global = global_1
 Assert(case(type_0) == TYPE)
 Let (TYPE ft)* = type_0
 Let fa* = (|s.FUNCS| + i_func)^(i_func<n_func)
 Let ga* = (|s.GLOBALS| + i_global)^(i_global<n_global)
 Let ta* = (|s.TABLES| + i_table)^(i_table<n_table)
 Let ma* = (|s.MEMS| + i_mem)^(i_mem<n_mem)
 Let xi* = $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*
 Let moduleinst = { TYPES: ft*; FUNCS: fa_ex* ++ fa*; GLOBALS: ga_ex* ++ ga*; TABLES: ta_ex* ++ ta*; MEMS: ma_ex* ++ ma*; EXPORTS: xi*; }
 Let funcaddr_0 = $allocfuncs(moduleinst, func^n_func)
 Assert((funcaddr_0 == fa*))
 Let globaladdr_0 = $allocglobals(globaltype^n_global, val*)
 Assert((globaladdr_0 == ga*))
 Let tableaddr_0 = $alloctables(tabletype^n_table)
 Assert((tableaddr_0 == ta*))
 Let memaddr_0 = $allocmems(memtype^n_mem)
 Assert((memaddr_0 == ma*))
 Return moduleinst
}

initelem moduleinst u32_u0* funcaddr_u1* {
 If (((u32_u0* == []) && (funcaddr_u1* == []))) {
   Return
 }
 Assert((|funcaddr_u1*| ≥ 1))
 Let [a*] ++ a'** = funcaddr_u1*
 Assert((|u32_u0*| ≥ 1))
 Let [i] ++ i'* = u32_u0*
 s.TABLES[moduleinst.TABLES[0]].REFS[i : |a*|] := ?(a)*
 $initelem(moduleinst, i'*, a'**)
 Return
}

initdata moduleinst u32_u0* byte_u1* {
 If (((u32_u0* == []) && (byte_u1* == []))) {
   Return
 }
 Assert((|byte_u1*| ≥ 1))
 Let [b*] ++ b'** = byte_u1*
 Assert((|u32_u0*| ≥ 1))
 Let [i] ++ i'* = u32_u0*
 s.MEMS[moduleinst.MEMS[0]].BYTES[i : |b*|] := b*
 $initdata(moduleinst, i'*, b'**)
 Return
}

instantiate module externval* {
 Assert(case(module) == MODULE)
 Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) = module
 Assert(case(type) == TYPE*)
 Let (TYPE functype)* = type*
 Let n_F = |func*|
 Assert(case(start) == START?)
 Let (START x')? = start?
 Assert(case(data) == DATA*)
 Let (DATA expr_D b*)* = data*
 Assert(case(elem) == ELEM*)
 Let (ELEM expr_E x*)* = elem*
 Assert(case(global) == GLOBAL*)
 Let (GLOBAL globaltype expr_G)* = global*
 Let moduleinst_init = { TYPES: functype*; FUNCS: $funcs(externval*) ++ (|s.FUNCS| + i_F)^(i_F<n_F); GLOBALS: $globals(externval*); TABLES: []; MEMS: []; EXPORTS: []; }
 Let f_init = { LOCALS: []; MODULE: moduleinst_init; }
 Let z = f_init
 Push(callframe(z))
 Let [(I32.CONST i_D)]* = $eval_expr(expr_D)*
 Pop(callframe(_f))
 Push(callframe(z))
 Let [(I32.CONST i_E)]* = $eval_expr(expr_E)*
 Pop(callframe(_f))
 Push(callframe(z))
 Let [val]* = $eval_expr(expr_G)*
 Pop(callframe(_f))
 Let moduleinst = $allocmodule(module, externval*, val*)
 Let f = { LOCALS: []; MODULE: moduleinst; }
 $initelem(moduleinst, i_E*, moduleinst.FUNCS[x]**)
 $initdata(moduleinst, i_D*, b**)
 Push(callframe(0, f))
 If ((CALL x')? != None) {
   Let ?(instr_0) = (CALL x')?
   Execute instr_0
 }
 Pop(callframe(0, f))
 Return f.MODULE
}

invoke fa val^n {
 Let f = { LOCALS: []; MODULE: { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; EXPORTS: []; }; }
 Push(callframe(f))
 Let (t_1^n -> t_2*) = $funcinst()[fa].TYPE
 Pop(callframe(_f))
 Let k = |t_2*|
 Push(callframe(k, f))
 Push(val^n)
 Execute (CALL_ADDR fa)
 Pop_all(val*)
 Pop(callframe(k, f))
 Push(val*)
 Pop(val^k)
 Return val^k
}

Step_pure/unreachable {
 Trap
}

Step_pure/nop {
 Nop
}

Step_pure/drop {
 Assert(top_value())
 Pop(val)
 Nop
}

Step_pure/select {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 Assert(top_value())
 Pop(val_2)
 Assert(top_value())
 Pop(val_1)
 If ((c != 0)) {
   Push(val_1)
 }
 Else {
   Push(val_2)
 }
}

Step_pure/if t? instr_1* instr_2* {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 If ((c != 0)) {
   Execute (BLOCK t? instr_1*)
 }
 Else {
   Execute (BLOCK t? instr_2*)
 }
}

Step_pure/label {
 Pop_all(val*)
 Assert(top_label())
 Pop(current_label())
 Push(val*)
}

Step_pure/br n_u0 {
 Pop_all(val*)
 Let L = current_label()
 Let n = arity(L)
 Let instr'* = cont(L)
 Pop(current_label())
 Let admininstr_u1* = val*
 If (((n_u0 == 0) && (|admininstr_u1*| ≥ n))) {
   Let val'* ++ val^n = admininstr_u1*
   Push(val^n)
   Execute instr'*
 }
 If ((n_u0 ≥ 1)) {
   Let l = (n_u0 - 1)
   If (type(admininstr_u1) == val*) {
     Let val* = admininstr_u1*
     Push(val*)
     Execute (BR l)
   }
 }
}

Step_pure/br_if l {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 If ((c != 0)) {
   Execute (BR l)
 }
 Else {
   Nop
 }
}

Step_pure/br_table l* l' {
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i < |l*|)) {
   Execute (BR l*[i])
 }
 Else {
   Execute (BR l')
 }
}

Step_pure/frame {
 Let f = current_frame()
 Let n = arity(f)
 Assert(top_values(n))
 Assert(top_values(n))
 Pop(val^n)
 Assert(top_frame())
 Pop(current_frame())
 Push(val^n)
}

Step_pure/return {
 Pop_all(val*)
 If (top_frame()) {
   Let f = current_frame()
   Let n = arity(f)
   Pop(current_frame())
   Let val'* ++ val^n = val*
   Push(val^n)
 }
 Else if (top_label()) {
   Pop(current_label())
   Push(val*)
   Execute RETURN
 }
}

Step_pure/trap {
 YetI: TODO: It is likely that the value stack of two rules are different.
}

Step_pure/unop t unop {
 Assert(top_value(t))
 Pop((t.CONST c_1))
 If ((|$unop_(t, unop, c_1)| ≤ 0)) {
   Trap
 }
 Let c = choose($unop_(t, unop, c_1))
 Push((t.CONST c))
}

Step_pure/binop t binop {
 Assert(top_value(t))
 Pop((t.CONST c_2))
 Assert(top_value(t))
 Pop((t.CONST c_1))
 If ((|$binop_(t, binop, c_1, c_2)| ≤ 0)) {
   Trap
 }
 Let c = choose($binop_(t, binop, c_1, c_2))
 Push((t.CONST c))
}

Step_pure/testop t testop {
 Assert(top_value(t))
 Pop((t.CONST c_1))
 Let c = $testop_(t, testop, c_1)
 Push((I32.CONST c))
}

Step_pure/relop t relop {
 Assert(top_value(t))
 Pop((t.CONST c_2))
 Assert(top_value(t))
 Pop((t.CONST c_1))
 Let c = $relop_(t, relop, c_1, c_2)
 Push((I32.CONST c))
}

Step_pure/cvtop t_2 t_1 cvtop {
 Assert(top_value(t_1))
 Pop((t_1.CONST c_1))
 If ((|$cvtop__(t_1, t_2, cvtop, c_1)| ≤ 0)) {
   Trap
 }
 Let c = choose($cvtop__(t_1, t_2, cvtop, c_1))
 Push((t_2.CONST c))
}

Step_pure/local.tee x {
 Assert(top_value())
 Pop(val)
 Push(val)
 Push(val)
 Execute (LOCAL.SET x)
}

Step_read/block t? instr* {
 If (!(t? != None)) {
   Let n = 0
 }
 Else {
   Let n = 1
 }
 Let L = label(n, [])
 Enter (L, instr*) {
 }
}

Step_read/loop t? instr* {
 Let L = label(0, [(LOOP t? instr*)])
 Enter (L, instr*) {
 }
}

Step_read/call x {
 Let z = current_state()
 Assert((x < |$funcaddr(z)|))
 Execute (CALL_ADDR $funcaddr(z)[x])
}

Step_read/call_indirect x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i ≥ |$table(z, 0).REFS|)) {
   Trap
 }
 If (!($table(z, 0).REFS[i] != None)) {
   Trap
 }
 Let ?(a) = $table(z, 0).REFS[i]
 If ((a ≥ |$funcinst(z)|)) {
   Trap
 }
 If (($type(z, x) != $funcinst(z)[a].TYPE)) {
   Trap
 }
 Execute (CALL_ADDR a)
}

Step_read/call_addr a {
 Let z = current_state()
 Assert((a < |$funcinst(z)|))
 Let { TYPE: (t_1^k -> t_2^n); MODULE: mm; CODE: func; } = $funcinst(z)[a]
 Assert(top_values(k))
 Pop(val^k)
 Assert(case(func) == FUNC)
 Let (FUNC x local_0 instr*) = func
 Assert(case(local_0) == LOCAL)
 Let (LOCAL t)* = local_0
 Let f = { LOCALS: val^k ++ $default_(t)*; MODULE: mm; }
 Let F = callframe(n, f)
 Push(F)
 Let L = label(n, [])
 Enter (L, instr*) {
 }
}

Step_read/local.get x {
 Let z = current_state()
 Push($local(z, x))
}

Step_read/global.get x {
 Let z = current_state()
 Push($global(z, x).VALUE)
}

Step_read/load valtype_u0 sz_sx_u1? ao {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (!(sz_sx_u1? != None)) {
   Let t = valtype_u0
   If ((((i + ao.OFFSET) + ($size(t) / 8)) > |$mem(z, 0).BYTES|)) {
     Trap
   }
   Let c = $bytes__1^-1(t, $mem(z, 0).BYTES[(i + ao.OFFSET) : ($size(t) / 8)])
   Push((t.CONST c))
 }
 If (type(valtype_u0) == Inn) {
   If (sz_sx_u1? != None) {
     Let ?(sz_sx_0) = sz_sx_u1?
     Let (n, sx) = sz_sx_0
     If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|)) {
       Trap
     }
   }
   Let Inn = valtype_u0
   If (sz_sx_u1? != None) {
     Let ?(sz_sx_0) = sz_sx_u1?
     Let (n, sx) = sz_sx_0
     Let c = $ibytes__1^-1(n, $mem(z, 0).BYTES[(i + ao.OFFSET) : (n / 8)])
     Push((Inn.CONST $extend__(n, $size(Inn), sx, c)))
   }
 }
}

Step_read/memory.size {
 Let z = current_state()
 Let ((n · 64) · $Ki()) = |$mem(z, 0).BYTES|
 Push((I32.CONST n))
}

Step/ctxt {
 YetI: TODO: It is likely that the value stack of two rules are different.
}

Step/local.set x {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 $with_local(z, x, val)
}

Step/global.set x {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 $with_global(z, x, val)
}

Step/store valtype_u1 sz_u2? ao {
 Let z = current_state()
 Assert(top_value(valtype_u0))
 Pop((valtype_u0.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (!(sz_u2? != None)) {
   Let t = valtype_u1
   If ((valtype_u0 == t)) {
     If ((((i + ao.OFFSET) + ($size(t) / 8)) > |$mem(z, 0).BYTES|)) {
       Trap
     }
     Let b* = $bytes_(t, c)
     $with_mem(z, 0, (i + ao.OFFSET), ($size(t) / 8), b*)
   }
 }
 Else {
   Let ?(n) = sz_u2?
   If (type(valtype_u1) == Inn) {
     Let Inn = valtype_u1
     If ((valtype_u0 == Inn)) {
       If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|)) {
         Trap
       }
       Let b* = $ibytes_(n, $wrap__($size(Inn), n, c))
       $with_mem(z, 0, (i + ao.OFFSET), (n / 8), b*)
     }
   }
 }
}

Step/memory.grow {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Either {
   Let mi = $growmemory($mem(z, 0), n)
   Push((I32.CONST (|$mem(z, 0).BYTES| / (64 · $Ki()))))
   $with_meminst(z, 0, mi)
 }
 Or {
   Push((I32.CONST $invsigned_(32, -(1))))
 }
}

eval_expr instr* {
 Execute instr*
 Pop(val)
 Return [val]
}
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
Limits_ok
- the limits (n, m) is valid with the nat k if and only if:
  - n is less than or equal to m.
  - m is less than or equal to k.

Functype_ok
- the function type (t_1* -> t_2*) is valid.

Globaltype_ok
- the global type ((MUT ()?), t) is valid.

Tabletype_ok
- the table type (limits, reftype) is valid if and only if:
  - the limits limits is valid with the nat ((2 ^ 32) - 1).

Memtype_ok
- the memory type (PAGE limits) is valid if and only if:
  - the limits limits is valid with the nat (2 ^ 16).

Externtype_ok
- the external type externtype_u0 is valid if and only if:
  - Either:
    - externtype_u0 is (FUNC functype).
    - the function type functype is valid.
  - Or:
    - externtype_u0 is (GLOBAL globaltype).
    - the global type globaltype is valid.
  - Or:
    - externtype_u0 is (TABLE tabletype).
    - the table type tabletype is valid.
  - Or:
    - externtype_u0 is (MEM memtype).
    - the memory type memtype is valid.

Valtype_sub
- the value type valtype_u0 matches the value type t if and only if:
  - Either:
    - valtype_u0 is t.
  - Or:
    - valtype_u0 is BOT.

Resulttype_sub
- the value type sequence t_1* matches the value type sequence t_2* if and only if:
  - |t_2*| is |t_1*|.
  - For all t_1 in t_1* and t_2 in t_2*,
    - the value type t_1 matches the value type t_2.

Limits_sub
- the limits (n_11, n_12) matches the limits (n_21, n_22) if and only if:
  - n_11 is greater than or equal to n_21.
  - n_12 is less than or equal to n_22.

Functype_sub
- the function type ft matches the function type ft.

Globaltype_sub
- the global type gt matches the global type gt.

Tabletype_sub
- the table type (lim_1, rt) matches the table type (lim_2, rt) if and only if:
  - the limits lim_1 matches the limits lim_2.

Memtype_sub
- the memory type (PAGE lim_1) matches the memory type (PAGE lim_2) if and only if:
  - the limits lim_1 matches the limits lim_2.

Externtype_sub
- the external type externtype_u0 matches the external type externtype_u1 if and only if:
  - Either:
    - externtype_u0 is (FUNC ft_1).
    - externtype_u1 is (FUNC ft_2).
    - the function type ft_1 matches the function type ft_2.
  - Or:
    - externtype_u0 is (GLOBAL gt_1).
    - externtype_u1 is (GLOBAL gt_2).
    - the global type gt_1 matches the global type gt_2.
  - Or:
    - externtype_u0 is (TABLE tt_1).
    - externtype_u1 is (TABLE tt_2).
    - the table type tt_1 matches the table type tt_2.
  - Or:
    - externtype_u0 is (MEM mt_1).
    - externtype_u1 is (MEM mt_2).
    - the memory type mt_1 matches the memory type mt_2.

Blocktype_ok
- the block type blocktype_u0 is valid with the function type (valtype_u1* -> valtype_u2*) if and only if:
  - Either:
    - blocktype_u0 is (_RESULT valtype?).
    - valtype_u1* is [].
    - valtype_u2* is valtype?.
  - Or:
    - blocktype_u0 is (_IDX typeidx).
    - valtype_u1* is t_1*.
    - valtype_u2* is t_2*.
    - |C.TYPES| is greater than typeidx.
    - C.TYPES[typeidx] is (t_1* -> t_2*).

Instr_ok/nop
- the instr NOP is valid with the function type ([] -> []).

Instr_ok/unreachable
- the instr UNREACHABLE is valid with the function type (t_1* -> t_2*).

Instr_ok/drop
- the instr DROP is valid with the function type ([t] -> []).

Instr_ok/select
- the instr (SELECT ?([t])) is valid with the function type ([t, t, I32] -> [t]).

Instr_ok/block
- the instr (BLOCK bt instr*) is valid with the function type (t_1* -> t_2*) if and only if:
  - the block type bt is valid with the function type (t_1* -> t_2*).
  - Under the context prepend(C.LABELS, [t_2*]), the instr sequence instr* is valid with the function type (t_1* -> t_2*).

Instr_ok/loop
- the instr (LOOP bt instr*) is valid with the function type (t_1* -> t_2*) if and only if:
  - the block type bt is valid with the function type (t_1* -> t_2*).
  - Under the context prepend(C.LABELS, [t_1*]), the instr sequence instr* is valid with the function type (t_1* -> t_2*).

Instr_ok/if
- the instr (IF bt instr_1* instr_2*) is valid with the function type (t_1* ++ [I32] -> t_2*) if and only if:
  - the block type bt is valid with the function type (t_1* -> t_2*).
  - Under the context prepend(C.LABELS, [t_2*]), the instr sequence instr_1* is valid with the function type (t_1* -> t_2*).
  - Under the context prepend(C.LABELS, [t_2*]), the instr sequence instr_2* is valid with the function type (t_1* -> t_2*).

Instr_ok/br
- the instr (BR l) is valid with the function type (t_1* ++ t* -> t_2*) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t*.

Instr_ok/br_if
- the instr (BR_IF l) is valid with the function type (t* ++ [I32] -> t*) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t*.

Instr_ok/br_table
- the instr (BR_TABLE l* l') is valid with the function type (t_1* ++ t* -> t_2*) if and only if:
  - For all l in l*,
    - |C.LABELS| is greater than l.
  - |C.LABELS| is greater than l'.
  - For all l in l*,
    - the value type sequence t* matches the result type C.LABELS[l].
  - the value type sequence t* matches the result type C.LABELS[l'].

Instr_ok/call
- the instr (CALL x) is valid with the function type (t_1* -> t_2*) if and only if:
  - |C.FUNCS| is greater than x.
  - C.FUNCS[x] is (t_1* -> t_2*).

Instr_ok/call_indirect
- the instr (CALL_INDIRECT x y) is valid with the function type (t_1* ++ [I32] -> t_2*) if and only if:
  - |C.TABLES| is greater than x.
  - |C.TYPES| is greater than y.
  - C.TABLES[x] is (lim, FUNCREF).
  - C.TYPES[y] is (t_1* -> t_2*).

Instr_ok/return
- the instr RETURN is valid with the function type (t_1* ++ t* -> t_2*) if and only if:
  - C.RETURN is ?(t*).

Instr_ok/const
- the instr (nt.CONST c_nt) is valid with the function type ([] -> [nt]).

Instr_ok/unop
- the instr (UNOP nt unop_nt) is valid with the function type ([nt] -> [nt]).

Instr_ok/binop
- the instr (BINOP nt binop_nt) is valid with the function type ([nt, nt] -> [nt]).

Instr_ok/testop
- the instr (TESTOP nt testop_nt) is valid with the function type ([nt] -> [I32]).

Instr_ok/relop
- the instr (RELOP nt relop_nt) is valid with the function type ([nt, nt] -> [I32]).

Instr_ok/cvtop
- the instr (CVTOP nt_1 nt_2 REINTERPRET) is valid with the function type ([nt_2] -> [nt_1]) if and only if:
  - $size(nt_1) is $size(nt_2).

Instr_ok/ref.null
- the instr (REF.NULL rt) is valid with the function type ([] -> [rt]).

Instr_ok/ref.func
- the instr (REF.FUNC x) is valid with the function type ([] -> [FUNCREF]) if and only if:
  - |C.FUNCS| is greater than x.
  - C.FUNCS[x] is ft.

Instr_ok/ref.is_null
- the instr REF.IS_NULL is valid with the function type ([rt] -> [I32]).

Instr_ok/vconst
- the instr (V128.CONST c) is valid with the function type ([] -> [V128]).

Instr_ok/vvunop
- the instr (VVUNOP V128 vvunop) is valid with the function type ([V128] -> [V128]).

Instr_ok/vvbinop
- the instr (VVBINOP V128 vvbinop) is valid with the function type ([V128, V128] -> [V128]).

Instr_ok/vvternop
- the instr (VVTERNOP V128 vvternop) is valid with the function type ([V128, V128, V128] -> [V128]).

Instr_ok/vvtestop
- the instr (VVTESTOP V128 vvtestop) is valid with the function type ([V128] -> [I32]).

Instr_ok/vunop
- the instr (VUNOP sh vunop_sh) is valid with the function type ([V128] -> [V128]).

Instr_ok/vbinop
- the instr (VBINOP sh vbinop_sh) is valid with the function type ([V128, V128] -> [V128]).

Instr_ok/vtestop
- the instr (VTESTOP sh vtestop_sh) is valid with the function type ([V128] -> [I32]).

Instr_ok/vrelop
- the instr (VRELOP sh vrelop_sh) is valid with the function type ([V128, V128] -> [V128]).

Instr_ok/vshiftop
- the instr (VSHIFTOP sh vshiftop_sh) is valid with the function type ([V128, I32] -> [V128]).

Instr_ok/vbitmask
- the instr (VBITMASK sh) is valid with the function type ([V128] -> [I32]).

Instr_ok/vswizzle
- the instr (VSWIZZLE sh) is valid with the function type ([V128, V128] -> [V128]).

Instr_ok/vshuffle
- the instr (VSHUFFLE sh i*) is valid with the function type ([V128, V128] -> [V128]) if and only if:
  - For all i in i*,
    - i is less than (2 · $dim(sh)).

Instr_ok/vsplat
- the instr (VSPLAT sh) is valid with the function type ([$shunpack(sh)] -> [V128]).

Instr_ok/vextract_lane
- the instr (VEXTRACT_LANE sh sx? i) is valid with the function type ([V128] -> [$shunpack(sh)]) if and only if:
  - i is less than $dim(sh).

Instr_ok/vreplace_lane
- the instr (VREPLACE_LANE sh i) is valid with the function type ([V128, $shunpack(sh)] -> [V128]) if and only if:
  - i is less than $dim(sh).

Instr_ok/vextunop
- the instr (VEXTUNOP sh_1 sh_2 vextunop) is valid with the function type ([V128] -> [V128]).

Instr_ok/vextbinop
- the instr (VEXTBINOP sh_1 sh_2 vextbinop) is valid with the function type ([V128, V128] -> [V128]).

Instr_ok/vnarrow
- the instr (VNARROW sh_1 sh_2 sx) is valid with the function type ([V128, V128] -> [V128]).

Instr_ok/vcvtop
- the instr (VCVTOP sh_1 sh_2 vcvtop hf? zero?) is valid with the function type ([V128] -> [V128]).

Instr_ok/local.get
- the instr (LOCAL.GET x) is valid with the function type ([] -> [t]) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is t.

Instr_ok/local.set
- the instr (LOCAL.SET x) is valid with the function type ([t] -> []) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is t.

Instr_ok/local.tee
- the instr (LOCAL.TEE x) is valid with the function type ([t] -> [t]) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is t.

Instr_ok/global.get
- the instr (GLOBAL.GET x) is valid with the function type ([] -> [t]) if and only if:
  - |C.GLOBALS| is greater than x.
  - C.GLOBALS[x] is (mut, t).

Instr_ok/global.set
- the instr (GLOBAL.SET x) is valid with the function type ([t] -> []) if and only if:
  - |C.GLOBALS| is greater than x.
  - C.GLOBALS[x] is ((MUT ?(())), t).

Instr_ok/table.get
- the instr (TABLE.GET x) is valid with the function type ([I32] -> [rt]) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

Instr_ok/table.set
- the instr (TABLE.SET x) is valid with the function type ([I32, rt] -> []) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

Instr_ok/table.size
- the instr (TABLE.SIZE x) is valid with the function type ([] -> [I32]) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

Instr_ok/table.grow
- the instr (TABLE.GROW x) is valid with the function type ([rt, I32] -> [I32]) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

Instr_ok/table.fill
- the instr (TABLE.FILL x) is valid with the function type ([I32, rt, I32] -> []) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

Instr_ok/table.copy
- the instr (TABLE.COPY x_1 x_2) is valid with the function type ([I32, I32, I32] -> []) if and only if:
  - |C.TABLES| is greater than x_1.
  - |C.TABLES| is greater than x_2.
  - C.TABLES[x_1] is (lim_1, rt).
  - C.TABLES[x_2] is (lim_2, rt).

Instr_ok/table.init
- the instr (TABLE.INIT x_1 x_2) is valid with the function type ([I32, I32, I32] -> []) if and only if:
  - |C.TABLES| is greater than x_1.
  - |C.ELEMS| is greater than x_2.
  - C.TABLES[x_1] is (lim, rt).
  - C.ELEMS[x_2] is rt.

Instr_ok/elem.drop
- the instr (ELEM.DROP x) is valid with the function type ([] -> []) if and only if:
  - |C.ELEMS| is greater than x.
  - C.ELEMS[x] is rt.

Instr_ok/memory.size
- the instr MEMORY.SIZE is valid with the function type ([] -> [I32]) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.

Instr_ok/memory.grow
- the instr MEMORY.GROW is valid with the function type ([I32] -> [I32]) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.

Instr_ok/memory.fill
- the instr MEMORY.FILL is valid with the function type ([I32, I32, I32] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.

Instr_ok/memory.copy
- the instr MEMORY.COPY is valid with the function type ([I32, I32, I32] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.

Instr_ok/memory.init
- the instr (MEMORY.INIT x) is valid with the function type ([I32, I32, I32] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - |C.DATAS| is greater than x.
  - C.MEMS[0] is mt.
  - C.DATAS[x] is OK.

Instr_ok/data.drop
- the instr (DATA.DROP x) is valid with the function type ([] -> []) if and only if:
  - |C.DATAS| is greater than x.
  - C.DATAS[x] is OK.

Instr_ok/load
- the instr (LOAD nt (n, sx)? memarg) is valid with the function type ([I32] -> [nt]) if and only if:
  - |C.MEMS| is greater than 0.
  - ((sx? == ?())) if and only if ((n? == ?())).
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(nt) / 8).
  - If n != None,
    - (2 ^ memarg.ALIGN) is less than or equal to (n / 8).
    - (n / 8) is less than ($size(nt) / 8).
  - If n != None,
    - nt is Inn.

Instr_ok/store
- the instr (STORE nt n? memarg) is valid with the function type ([I32, nt] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(nt) / 8).
  - If n != None,
    - (2 ^ memarg.ALIGN) is less than or equal to (n / 8).
    - (n / 8) is less than ($size(nt) / 8).
  - If n != None,
    - nt is Inn.

Instr_ok/vload
- the instr (VLOAD V128 ?((SHAPE M N sx)) memarg) is valid with the function type ([I32] -> [V128]) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ((M / 8) · N).

Instr_ok/vload_lane
- the instr (VLOAD_LANE V128 n memarg laneidx) is valid with the function type ([I32, V128] -> [V128]) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to (n / 8).
  - laneidx is less than (128 / n).

Instr_ok/vstore
- the instr (VSTORE V128 memarg) is valid with the function type ([I32, V128] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(V128) / 8).

Instr_ok/vstore_lane
- the instr (VSTORE_LANE V128 n memarg laneidx) is valid with the function type ([I32, V128] -> []) if and only if:
  - |C.MEMS| is greater than 0.
  - C.MEMS[0] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to (n / 8).
  - laneidx is less than (128 / n).

Instrs_ok
- the instr sequence instr_u0* is valid with the function type (valtype_u1* -> valtype_u2*) if and only if:
  - Either:
    - instr_u0* is [].
    - valtype_u1* is [].
    - valtype_u2* is [].
  - Or:
    - instr_u0* is [instr_1] ++ instr_2*.
    - valtype_u1* is t_1*.
    - valtype_u2* is t_3*.
    - the instr instr_1 is valid with the function type (t_1* -> t_2*).
    - the instr sequence [instr_2] is valid with the function type (t_2* -> t_3*).
  - Or:
    - instr_u0* is instr*.
    - valtype_u1* is t'_1*.
    - valtype_u2* is t'_2*.
    - the instr sequence instr* is valid with the function type (t_1* -> t_2*).
    - the value type sequence t'_1* matches the value type sequence t_1*.
    - the value type sequence t_2* matches the value type sequence t'_2*.
  - Or:
    - instr_u0* is instr*.
    - valtype_u1* is t* ++ t_1*.
    - valtype_u2* is t* ++ t_2*.
    - the instr sequence instr* is valid with the function type (t_1* -> t_2*).

Expr_ok
- the expression instr* is valid with the value type sequence t* if and only if:
  - the instr sequence instr* is valid with the function type ([] -> t*).

Instr_const
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

Expr_const
- the expression instr* is constant if and only if:
  - For all instr in instr*,
    - the instr instr is constant.

Type_ok
- the type (TYPE ft) is valid with the function type ft if and only if:
  - the function type ft is valid.

Func_ok
- the function (FUNC x (LOCAL t)* expr) is valid with the function type (t_1* -> t_2*) if and only if:
  - |C.TYPES| is greater than x.
  - C.TYPES[x] is (t_1* -> t_2*).
  - Under the context append(append(append(C.LOCALS, t_1* ++ t*).LABELS, [t_2*]).RETURN, ?(t_2*)), the expression expr is valid with the value type sequence t_2*.

Global_ok
- the global (GLOBAL gt expr) is valid with the global type gt if and only if:
  - the global type gt is valid.
  - gt is (mut, t).
  - the expression expr is valid with the value type t.
  - the expression expr is constant.

Table_ok
- the table (TABLE tt) is valid with the table type tt if and only if:
  - the table type tt is valid.

Mem_ok
- the memory (MEMORY mt) is valid with the memory type mt if and only if:
  - the memory type mt is valid.

Elemmode_ok
- the elemmode elemmode_u0 is valid with the reference type rt if and only if:
  - Either:
    - elemmode_u0 is (ACTIVE x expr).
    - |C.TABLES| is greater than x.
    - C.TABLES[x] is (lim, rt).
    - the expression expr is valid with the value type I32.
    - the expression expr is constant.
  - Or:
    - elemmode_u0 is PASSIVE.
  - Or:
    - elemmode_u0 is DECLARE.

Elem_ok
- the table segment (ELEM rt expr* elemmode) is valid with the reference type rt if and only if:
  - For all expr in expr*,
    - the expression expr is valid with the value type rt.
    - the expression expr is constant.
  - the elemmode elemmode is valid with the reference type rt.

Datamode_ok
- the datamode datamode_u0 is valid if and only if:
  - Either:
    - datamode_u0 is (ACTIVE 0 expr).
    - |C.MEMS| is greater than 0.
    - C.MEMS[0] is mt.
    - the expression expr is valid with the value type I32.
    - the expression expr is constant.
  - Or:
    - datamode_u0 is PASSIVE.

Data_ok
- the memory segment (DATA b* datamode) is valid if and only if:
  - the datamode datamode is valid.

Start_ok
- the start function (START x) is valid if and only if:
  - |C.FUNCS| is greater than x.
  - C.FUNCS[x] is ([] -> []).

Import_ok
- the import (IMPORT name_1 name_2 xt) is valid with the external type xt if and only if:
  - the external type xt is valid.

Externidx_ok
- the external index externidx_u0 is valid with the external type externtype_u1 if and only if:
  - Either:
    - externidx_u0 is (FUNC x).
    - externtype_u1 is (FUNC ft).
    - |C.FUNCS| is greater than x.
    - C.FUNCS[x] is ft.
  - Or:
    - externidx_u0 is (GLOBAL x).
    - externtype_u1 is (GLOBAL gt).
    - |C.GLOBALS| is greater than x.
    - C.GLOBALS[x] is gt.
  - Or:
    - externidx_u0 is (TABLE x).
    - externtype_u1 is (TABLE tt).
    - |C.TABLES| is greater than x.
    - C.TABLES[x] is tt.
  - Or:
    - externidx_u0 is (MEM x).
    - externtype_u1 is (MEM mt).
    - |C.MEMS| is greater than x.
    - C.MEMS[x] is mt.

Export_ok
- the export (EXPORT name externidx) is valid with the external type xt if and only if:
  - the external index externidx is valid with the external type xt.

Module_ok
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
  - If start != None,
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

Ki {
 Return 1024
}

min n_u0 n_u1 {
 If ((n_u0 == 0)) {
   Return 0
 }
 If ((n_u1 == 0)) {
   Return 0
 }
 Assert((n_u0 ≥ 1))
 Let i = (n_u0 - 1)
 Assert((n_u1 ≥ 1))
 Let j = (n_u1 - 1)
 Return $min(i, j)
}

sum n_u0* {
 If ((n_u0* == [])) {
   Return 0
 }
 Let [n] ++ n'* = n_u0*
 Return (n + $sum(n'*))
}

opt_ X X_u0* {
 If ((X_u0* == [])) {
   Return ?()
 }
 Assert((|X_u0*| == 1))
 Let [w] = X_u0*
 Return ?(w)
}

list_ X X_u0? {
 If (!(X_u0? != None)) {
   Return []
 }
 Let ?(w) = X_u0?
 Return [w]
}

concat_ X X_u0* {
 If ((X_u0* == [])) {
   Return []
 }
 Let [w*] ++ w'** = X_u0*
 Return w* ++ $concat_(X, w'**)
}

setproduct2_ X w_1 X_u0* {
 If ((X_u0* == [])) {
   Return []
 }
 Let [w'*] ++ w** = X_u0*
 Return [[w_1] ++ w'*] ++ $setproduct2_(X, w_1, w**)
}

setproduct1_ X X_u0* w** {
 If ((X_u0* == [])) {
   Return []
 }
 Let [w_1] ++ w'* = X_u0*
 Return $setproduct2_(X, w_1, w**) ++ $setproduct1_(X, w'*, w**)
}

setproduct_ X X_u0* {
 If ((X_u0* == [])) {
   Return [[]]
 }
 Let [w_1*] ++ w** = X_u0*
 Return $setproduct1_(X, w_1*, $setproduct_(X, w**))
}

signif N_u0 {
 If ((N_u0 == 32)) {
   Return 23
 }
 Assert((N_u0 == 64))
 Return 52
}

expon N_u0 {
 If ((N_u0 == 32)) {
   Return 8
 }
 Assert((N_u0 == 64))
 Return 11
}

M N {
 Return $signif(N)
}

E N {
 Return $expon(N)
}

fzero N {
 Return (POS (SUBNORM 0))
}

fone N {
 Return (POS (NORM 1 0))
}

canon_ N {
 Return (2 ^ ($signif(N) - 1))
}

size valtype_u0 {
 If ((valtype_u0 == I32)) {
   Return 32
 }
 If ((valtype_u0 == I64)) {
   Return 64
 }
 If ((valtype_u0 == F32)) {
   Return 32
 }
 If ((valtype_u0 == F64)) {
   Return 64
 }
 If ((valtype_u0 == V128)) {
   Return 128
 }
}

isize Inn {
 Return $size(Inn)
}

psize packtype_u0 {
 If ((packtype_u0 == I8)) {
   Return 8
 }
 Assert((packtype_u0 == I16))
 Return 16
}

lsize lanetype_u0 {
 If (type(lanetype_u0) == numtype) {
   Let numtype = lanetype_u0
   Return $size(numtype)
 }
 Assert(type(lanetype_u0) == packtype)
 Let packtype = lanetype_u0
 Return $psize(packtype)
}

lanetype (Lnn X N) {
 Return Lnn
}

sizenn nt {
 Return $size(nt)
}

sizenn1 nt {
 Return $size(nt)
}

sizenn2 nt {
 Return $size(nt)
}

lsizenn lt {
 Return $lsize(lt)
}

lsizenn1 lt {
 Return $lsize(lt)
}

lsizenn2 lt {
 Return $lsize(lt)
}

zero numtype_u0 {
 If (type(numtype_u0) == Inn) {
   Return 0
 }
 Assert(type(numtype_u0) == Fnn)
 Let Fnn = numtype_u0
 Return $fzero($size(Fnn))
}

dim (Lnn X N) {
 Return N
}

shsize (Lnn X N) {
 Return ($lsize(Lnn) · N)
}

concat_bytes byte_u0* {
 If ((byte_u0* == [])) {
   Return []
 }
 Let [b*] ++ b'** = byte_u0*
 Return b* ++ $concat_bytes(b'**)
}

unpack lanetype_u0 {
 If (type(lanetype_u0) == numtype) {
   Let numtype = lanetype_u0
   Return numtype
 }
 Assert(type(lanetype_u0) == packtype)
 Return I32
}

shunpack (Lnn X N) {
 Return $unpack(Lnn)
}

funcsxt externtype_u0* {
 If ((externtype_u0* == [])) {
   Return []
 }
 Let [externtype_0] ++ xt* = externtype_u0*
 If (case(externtype_0) == FUNC) {
   Let (FUNC ft) = externtype_0
   Return [ft] ++ $funcsxt(xt*)
 }
 Let [externtype] ++ xt* = externtype_u0*
 Return $funcsxt(xt*)
}

globalsxt externtype_u0* {
 If ((externtype_u0* == [])) {
   Return []
 }
 Let [externtype_0] ++ xt* = externtype_u0*
 If (case(externtype_0) == GLOBAL) {
   Let (GLOBAL gt) = externtype_0
   Return [gt] ++ $globalsxt(xt*)
 }
 Let [externtype] ++ xt* = externtype_u0*
 Return $globalsxt(xt*)
}

tablesxt externtype_u0* {
 If ((externtype_u0* == [])) {
   Return []
 }
 Let [externtype_0] ++ xt* = externtype_u0*
 If (case(externtype_0) == TABLE) {
   Let (TABLE tt) = externtype_0
   Return [tt] ++ $tablesxt(xt*)
 }
 Let [externtype] ++ xt* = externtype_u0*
 Return $tablesxt(xt*)
}

memsxt externtype_u0* {
 If ((externtype_u0* == [])) {
   Return []
 }
 Let [externtype_0] ++ xt* = externtype_u0*
 If (case(externtype_0) == MEM) {
   Let (MEM mt) = externtype_0
   Return [mt] ++ $memsxt(xt*)
 }
 Let [externtype] ++ xt* = externtype_u0*
 Return $memsxt(xt*)
}

dataidx_instr instr_u0 {
 If (case(instr_u0) == MEMORY.INIT) {
   Let (MEMORY.INIT x) = instr_u0
   Return [x]
 }
 If (case(instr_u0) == DATA.DROP) {
   Let (DATA.DROP x) = instr_u0
   Return [x]
 }
 Return []
}

dataidx_instrs instr_u0* {
 If ((instr_u0* == [])) {
   Return []
 }
 Let [instr] ++ instr'* = instr_u0*
 Return $dataidx_instr(instr) ++ $dataidx_instrs(instr'*)
}

dataidx_expr in* {
 Return $dataidx_instrs(in*)
}

dataidx_func (FUNC x loc* e) {
 Return $dataidx_expr(e)
}

dataidx_funcs func_u0* {
 If ((func_u0* == [])) {
   Return []
 }
 Let [func] ++ func'* = func_u0*
 Return $dataidx_func(func) ++ $dataidx_funcs(func'*)
}

memarg0 {
 Return { ALIGN: 0; OFFSET: 0; }
}

signed_ N i {
 If ((0 ≤ (2 ^ (N - 1)))) {
   Return i
 }
 Assert(((2 ^ (N - 1)) ≤ i))
 Assert((i < (2 ^ N)))
 Return (i - (2 ^ N))
}

invsigned_ N i {
 Let j = $signed__1^-1(N, i)
 Return j
}

unop_ numtype_u1 unop__u0 num__u3 {
 If (((unop__u0 == CLZ) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN = num__u3
   Return [$iclz_($sizenn(Inn), iN)]
 }
 If (((unop__u0 == CTZ) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN = num__u3
   Return [$ictz_($sizenn(Inn), iN)]
 }
 If (((unop__u0 == POPCNT) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN = num__u3
   Return [$ipopcnt_($sizenn(Inn), iN)]
 }
 If (type(numtype_u1) == Inn) {
   Let Inn = numtype_u1
   Assert(case(unop__u0) == EXTEND)
   Let (EXTEND M) = unop__u0
   Let iN = num__u3
   Return [$extend__(M, $sizenn(Inn), S, $wrap__($sizenn(Inn), M, iN))]
 }
 If (((unop__u0 == ABS) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN = num__u3
   Return $fabs_($sizenn(Fnn), fN)
 }
 If (((unop__u0 == NEG) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN = num__u3
   Return $fneg_($sizenn(Fnn), fN)
 }
 If (((unop__u0 == SQRT) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN = num__u3
   Return $fsqrt_($sizenn(Fnn), fN)
 }
 If (((unop__u0 == CEIL) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN = num__u3
   Return $fceil_($sizenn(Fnn), fN)
 }
 If (((unop__u0 == FLOOR) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN = num__u3
   Return $ffloor_($sizenn(Fnn), fN)
 }
 If (((unop__u0 == TRUNC) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN = num__u3
   Return $ftrunc_($sizenn(Fnn), fN)
 }
 Assert((unop__u0 == NEAREST))
 Assert(type(numtype_u1) == Fnn)
 Let Fnn = numtype_u1
 Let fN = num__u3
 Return $fnearest_($sizenn(Fnn), fN)
}

binop_ numtype_u1 binop__u0 num__u3 num__u5 {
 If (((binop__u0 == ADD) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$iadd_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == SUB) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$isub_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == MUL) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$imul_($sizenn(Inn), iN_1, iN_2)]
 }
 If (type(numtype_u1) == Inn) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   If (case(binop__u0) == DIV) {
     Let (DIV sx) = binop__u0
     Return $list_(num_((Inn : Inn <: numtype)), $idiv_($sizenn(Inn), sx, iN_1, iN_2))
   }
   If (case(binop__u0) == REM) {
     Let (REM sx) = binop__u0
     Return $list_(num_((Inn : Inn <: numtype)), $irem_($sizenn(Inn), sx, iN_1, iN_2))
   }
 }
 If (((binop__u0 == AND) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$iand_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == OR) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$ior_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == XOR) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$ixor_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == SHL) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$ishl_($sizenn(Inn), iN_1, iN_2)]
 }
 If (type(numtype_u1) == Inn) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   If (case(binop__u0) == SHR) {
     Let (SHR sx) = binop__u0
     Return [$ishr_($sizenn(Inn), sx, iN_1, iN_2)]
   }
 }
 If (((binop__u0 == ROTL) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$irotl_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == ROTR) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$irotr_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == ADD) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fadd_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == SUB) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fsub_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == MUL) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fmul_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == DIV) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fdiv_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == MIN) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fmin_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == MAX) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fmax_($sizenn(Fnn), fN_1, fN_2)
 }
 Assert((binop__u0 == COPYSIGN))
 Assert(type(numtype_u1) == Fnn)
 Let Fnn = numtype_u1
 Let fN_1 = num__u3
 Let fN_2 = num__u5
 Return $fcopysign_($sizenn(Fnn), fN_1, fN_2)
}

testop_ Inn EQZ iN {
 Return $ieqz_($sizenn(Inn), iN)
}

relop_ numtype_u1 relop__u0 num__u3 num__u5 {
 If (((relop__u0 == EQ) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return $ieq_($sizenn(Inn), iN_1, iN_2)
 }
 If (((relop__u0 == NE) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return $ine_($sizenn(Inn), iN_1, iN_2)
 }
 If (type(numtype_u1) == Inn) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   If (case(relop__u0) == LT) {
     Let (LT sx) = relop__u0
     Return $ilt_($sizenn(Inn), sx, iN_1, iN_2)
   }
   If (case(relop__u0) == GT) {
     Let (GT sx) = relop__u0
     Return $igt_($sizenn(Inn), sx, iN_1, iN_2)
   }
   If (case(relop__u0) == LE) {
     Let (LE sx) = relop__u0
     Return $ile_($sizenn(Inn), sx, iN_1, iN_2)
   }
   If (case(relop__u0) == GE) {
     Let (GE sx) = relop__u0
     Return $ige_($sizenn(Inn), sx, iN_1, iN_2)
   }
 }
 If (((relop__u0 == EQ) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $feq_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((relop__u0 == NE) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fne_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((relop__u0 == LT) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $flt_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((relop__u0 == GT) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fgt_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((relop__u0 == LE) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fle_($sizenn(Fnn), fN_1, fN_2)
 }
 Assert((relop__u0 == GE))
 Assert(type(numtype_u1) == Fnn)
 Let Fnn = numtype_u1
 Let fN_1 = num__u3
 Let fN_2 = num__u5
 Return $fge_($sizenn(Fnn), fN_1, fN_2)
}

cvtop__ numtype_u1 numtype_u4 cvtop_u0 num__u3 {
 If (type(numtype_u1) == Inn) {
   Let Inn_1 = numtype_u1
   If (type(numtype_u4) == Inn) {
     Let Inn_2 = numtype_u4
     Let iN_1 = num__u3
     If (case(cvtop_u0) == EXTEND) {
       Let (EXTEND sx) = cvtop_u0
       Return [$extend__($sizenn1(Inn_1), $sizenn2(Inn_2), sx, iN_1)]
     }
   }
 }
 If (((cvtop_u0 == WRAP) && type(numtype_u1) == Inn)) {
   Let Inn_1 = numtype_u1
   If (type(numtype_u4) == Inn) {
     Let Inn_2 = numtype_u4
     Let iN_1 = num__u3
     Return [$wrap__($sizenn1(Inn_1), $sizenn2(Inn_2), iN_1)]
   }
 }
 If (type(numtype_u1) == Fnn) {
   Let Fnn_1 = numtype_u1
   If (type(numtype_u4) == Inn) {
     Let Inn_2 = numtype_u4
     Let fN_1 = num__u3
     If (case(cvtop_u0) == TRUNC) {
       Let (TRUNC sx) = cvtop_u0
       Return $list_(num_((Inn_2 : Inn <: numtype)), $trunc__($sizenn1(Fnn_1), $sizenn2(Inn_2), sx, fN_1))
     }
     If (case(cvtop_u0) == TRUNC_SAT) {
       Let (TRUNC_SAT sx) = cvtop_u0
       Return $list_(num_((Inn_2 : Inn <: numtype)), $trunc_sat__($sizenn1(Fnn_1), $sizenn2(Inn_2), sx, fN_1))
     }
   }
 }
 If (type(numtype_u4) == Fnn) {
   Let Fnn_2 = numtype_u4
   If (type(numtype_u1) == Inn) {
     Let Inn_1 = numtype_u1
     Let iN_1 = num__u3
     If (case(cvtop_u0) == CONVERT) {
       Let (CONVERT sx) = cvtop_u0
       Return [$convert__($sizenn1(Inn_1), $sizenn2(Fnn_2), sx, iN_1)]
     }
   }
 }
 If (((cvtop_u0 == PROMOTE) && type(numtype_u1) == Fnn)) {
   Let Fnn_1 = numtype_u1
   If (type(numtype_u4) == Fnn) {
     Let Fnn_2 = numtype_u4
     Let fN_1 = num__u3
     Return $promote__($sizenn1(Fnn_1), $sizenn2(Fnn_2), fN_1)
   }
 }
 If (((cvtop_u0 == DEMOTE) && type(numtype_u1) == Fnn)) {
   Let Fnn_1 = numtype_u1
   If (type(numtype_u4) == Fnn) {
     Let Fnn_2 = numtype_u4
     Let fN_1 = num__u3
     Return $demote__($sizenn1(Fnn_1), $sizenn2(Fnn_2), fN_1)
   }
 }
 Assert((cvtop_u0 == REINTERPRET))
 If (type(numtype_u4) == Fnn) {
   Let Fnn_2 = numtype_u4
   If (type(numtype_u1) == Inn) {
     Let Inn_1 = numtype_u1
     Let iN_1 = num__u3
     If (($size(Inn_1) == $size(Fnn_2))) {
       Return [$reinterpret__(Inn_1, Fnn_2, iN_1)]
     }
   }
 }
 Assert(type(numtype_u1) == Fnn)
 Let Fnn_1 = numtype_u1
 Assert(type(numtype_u4) == Inn)
 Let Inn_2 = numtype_u4
 Let fN_1 = num__u3
 Assert(($size(Fnn_1) == $size(Inn_2)))
 Return [$reinterpret__(Fnn_1, Inn_2, fN_1)]
}

invibytes_ N b* {
 Let n = $ibytes__1^-1(N, b*)
 Return n
}

invfbytes_ N b* {
 Let p = $fbytes__1^-1(N, b*)
 Return p
}

packnum_ lanetype_u0 c {
 If (type(lanetype_u0) == numtype) {
   Return c
 }
 Assert(type(lanetype_u0) == packtype)
 Let packtype = lanetype_u0
 Return $wrap__($size($unpack(packtype)), $psize(packtype), c)
}

unpacknum_ lanetype_u0 c {
 If (type(lanetype_u0) == numtype) {
   Return c
 }
 Assert(type(lanetype_u0) == packtype)
 Let packtype = lanetype_u0
 Return $extend__($psize(packtype), $size($unpack(packtype)), U, c)
}

invlanes_ sh c* {
 Let vc = $lanes__1^-1(sh, c*)
 Return vc
}

half half_u0 i j {
 If ((half_u0 == LOW)) {
   Return i
 }
 Assert((half_u0 == HIGH))
 Return j
}

vvunop_ V128 NOT v128 {
 Return $inot_($size(V128), v128)
}

vvbinop_ V128 vvbinop_u0 v128_1 v128_2 {
 If ((vvbinop_u0 == AND)) {
   Return $iand_($size(V128), v128_1, v128_2)
 }
 If ((vvbinop_u0 == ANDNOT)) {
   Return $iandnot_($size(V128), v128_1, v128_2)
 }
 If ((vvbinop_u0 == OR)) {
   Return $ior_($size(V128), v128_1, v128_2)
 }
 Assert((vvbinop_u0 == XOR))
 Return $ixor_($size(V128), v128_1, v128_2)
}

vvternop_ V128 BITSELECT v128_1 v128_2 v128_3 {
 Return $ibitselect_($size(V128), v128_1, v128_2, v128_3)
}

vunop_ (lanetype_u1 X M) vunop__u0 v128_1 {
 If (((vunop__u0 == ABS) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let v128 = $invlanes_((Jnn X M), $iabs_($lsizenn(Jnn), lane_1)*)
   Return [v128]
 }
 If (((vunop__u0 == NEG) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let v128 = $invlanes_((Jnn X M), $ineg_($lsizenn(Jnn), lane_1)*)
   Return [v128]
 }
 If (((vunop__u0 == POPCNT) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let v128 = $invlanes_((Jnn X M), $ipopcnt_($lsizenn(Jnn), lane_1)*)
   Return [v128]
 }
 If (((vunop__u0 == ABS) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fabs_($sizenn(Fnn), lane_1)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vunop__u0 == NEG) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fneg_($sizenn(Fnn), lane_1)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vunop__u0 == SQRT) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fsqrt_($sizenn(Fnn), lane_1)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vunop__u0 == CEIL) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fceil_($sizenn(Fnn), lane_1)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vunop__u0 == FLOOR) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $ffloor_($sizenn(Fnn), lane_1)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vunop__u0 == TRUNC) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $ftrunc_($sizenn(Fnn), lane_1)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 Assert((vunop__u0 == NEAREST))
 Assert(type(lanetype_u1) == Fnn)
 Let Fnn = lanetype_u1
 Let lane_1* = $lanes_((Fnn X M), v128_1)
 Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fnearest_($sizenn(Fnn), lane_1)*)
 Let v128* = $invlanes_((Fnn X M), lane*)*
 Return v128*
}

vbinop_ (lanetype_u1 X M) vbinop__u0 v128_1 v128_2 {
 If (((vbinop__u0 == ADD) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let v128 = $invlanes_((Jnn X M), $iadd_($lsizenn(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbinop__u0 == SUB) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let v128 = $invlanes_((Jnn X M), $isub_($lsizenn(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (type(lanetype_u1) == Jnn) {
   Let Jnn = lanetype_u1
   If (case(vbinop__u0) == MIN) {
     Let (MIN sx) = vbinop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let v128 = $invlanes_((Jnn X M), $imin_($lsizenn(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
   If (case(vbinop__u0) == MAX) {
     Let (MAX sx) = vbinop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let v128 = $invlanes_((Jnn X M), $imax_($lsizenn(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
   If (case(vbinop__u0) == ADD_SAT) {
     Let (ADD_SAT sx) = vbinop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let v128 = $invlanes_((Jnn X M), $iadd_sat_($lsizenn(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
   If (case(vbinop__u0) == SUB_SAT) {
     Let (SUB_SAT sx) = vbinop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let v128 = $invlanes_((Jnn X M), $isub_sat_($lsizenn(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
 }
 If (((vbinop__u0 == MUL) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let v128 = $invlanes_((Jnn X M), $imul_($lsizenn(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbinop__u0 == AVGR) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let v128 = $invlanes_((Jnn X M), $iavgr_($lsizenn(Jnn), U, lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbinop__u0 == Q15MULR_SAT) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let v128 = $invlanes_((Jnn X M), $iq15mulr_sat_($lsizenn(Jnn), S, lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbinop__u0 == ADD) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fadd_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vbinop__u0 == SUB) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fsub_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vbinop__u0 == MUL) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fmul_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vbinop__u0 == DIV) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fdiv_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vbinop__u0 == MIN) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fmin_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vbinop__u0 == MAX) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fmax_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vbinop__u0 == PMIN) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fpmin_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 Assert((vbinop__u0 == PMAX))
 Assert(type(lanetype_u1) == Fnn)
 Let Fnn = lanetype_u1
 Let lane_1* = $lanes_((Fnn X M), v128_1)
 Let lane_2* = $lanes_((Fnn X M), v128_2)
 Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fpmax_($sizenn(Fnn), lane_1, lane_2)*)
 Let v128* = $invlanes_((Fnn X M), lane*)*
 Return v128*
}

vrelop_ (lanetype_u1 X M) vrelop__u0 v128_1 v128_2 {
 If (((vrelop__u0 == EQ) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let lane_3* = $extend__(1, $lsizenn(Jnn), S, $ieq_($lsizenn(Jnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Jnn X M), lane_3*)
   Return v128
 }
 If (((vrelop__u0 == NE) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let lane_3* = $extend__(1, $lsizenn(Jnn), S, $ine_($lsizenn(Jnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Jnn X M), lane_3*)
   Return v128
 }
 If (type(lanetype_u1) == Jnn) {
   Let Jnn = lanetype_u1
   If (case(vrelop__u0) == LT) {
     Let (LT sx) = vrelop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let lane_3* = $extend__(1, $lsizenn(Jnn), S, $ilt_($lsizenn(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X M), lane_3*)
     Return v128
   }
   If (case(vrelop__u0) == GT) {
     Let (GT sx) = vrelop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let lane_3* = $extend__(1, $lsizenn(Jnn), S, $igt_($lsizenn(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X M), lane_3*)
     Return v128
   }
   If (case(vrelop__u0) == LE) {
     Let (LE sx) = vrelop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let lane_3* = $extend__(1, $lsizenn(Jnn), S, $ile_($lsizenn(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X M), lane_3*)
     Return v128
   }
   If (case(vrelop__u0) == GE) {
     Let (GE sx) = vrelop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let lane_3* = $extend__(1, $lsizenn(Jnn), S, $ige_($lsizenn(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X M), lane_3*)
     Return v128
   }
 }
 If (((vrelop__u0 == EQ) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let Inn = $isize^-1($size(Fnn))
   Let lane_3* = $extend__(1, $sizenn(Fnn), S, $feq_($sizenn(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X M), lane_3*)
   Return v128
 }
 If (((vrelop__u0 == NE) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let Inn = $isize^-1($size(Fnn))
   Let lane_3* = $extend__(1, $sizenn(Fnn), S, $fne_($sizenn(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X M), lane_3*)
   Return v128
 }
 If (((vrelop__u0 == LT) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let Inn = $isize^-1($size(Fnn))
   Let lane_3* = $extend__(1, $sizenn(Fnn), S, $flt_($sizenn(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X M), lane_3*)
   Return v128
 }
 If (((vrelop__u0 == GT) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let Inn = $isize^-1($size(Fnn))
   Let lane_3* = $extend__(1, $sizenn(Fnn), S, $fgt_($sizenn(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X M), lane_3*)
   Return v128
 }
 If (((vrelop__u0 == LE) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let Inn = $isize^-1($size(Fnn))
   Let lane_3* = $extend__(1, $sizenn(Fnn), S, $fle_($sizenn(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X M), lane_3*)
   Return v128
 }
 Assert((vrelop__u0 == GE))
 Assert(type(lanetype_u1) == Fnn)
 Let Fnn = lanetype_u1
 Let lane_1* = $lanes_((Fnn X M), v128_1)
 Let lane_2* = $lanes_((Fnn X M), v128_2)
 Let Inn = $isize^-1($size(Fnn))
 Let lane_3* = $extend__(1, $sizenn(Fnn), S, $fge_($sizenn(Fnn), lane_1, lane_2))*
 Let v128 = $invlanes_((Inn X M), lane_3*)
 Return v128
}

vcvtop__ (lanetype_u2 X M_1) (lanetype_u0 X M_2) vcvtop_u1 lane__u4 {
 If (type(lanetype_u2) == Jnn) {
   Let Jnn_1 = lanetype_u2
   If (type(lanetype_u0) == Jnn) {
     Let Jnn_2 = lanetype_u0
     Let iN_1 = lane__u4
     If (case(vcvtop_u1) == EXTEND) {
       Let (EXTEND sx) = vcvtop_u1
       Let iN_2 = $extend__($lsizenn1(Jnn_1), $lsizenn2(Jnn_2), sx, iN_1)
       Return [iN_2]
     }
   }
 }
 If (type(lanetype_u0) == Fnn) {
   Let Fnn_2 = lanetype_u0
   If (type(lanetype_u2) == Jnn) {
     Let Jnn_1 = lanetype_u2
     Let iN_1 = lane__u4
     If (case(vcvtop_u1) == CONVERT) {
       Let (CONVERT sx) = vcvtop_u1
       Let fN_2 = $convert__($lsizenn1(Jnn_1), $lsizenn2(Fnn_2), sx, iN_1)
       Return [fN_2]
     }
   }
 }
 If (type(lanetype_u2) == Fnn) {
   Let Fnn_1 = lanetype_u2
   If (type(lanetype_u0) == Inn) {
     Let Inn_2 = lanetype_u0
     Let fN_1 = lane__u4
     If (case(vcvtop_u1) == TRUNC_SAT) {
       Let (TRUNC_SAT sx) = vcvtop_u1
       Let iN_2? = $trunc_sat__($lsizenn1(Fnn_1), $lsizenn2(Inn_2), sx, fN_1)
       Return $list_(lane_((Inn_2 : Inn <: lanetype)), iN_2?)
     }
   }
 }
 If (((vcvtop_u1 == DEMOTE) && type(lanetype_u2) == Fnn)) {
   Let Fnn_1 = lanetype_u2
   If (type(lanetype_u0) == Fnn) {
     Let Fnn_2 = lanetype_u0
     Let fN_1 = lane__u4
     Let fN_2* = $demote__($lsizenn1(Fnn_1), $lsizenn2(Fnn_2), fN_1)
     Return fN_2*
   }
 }
 Assert((vcvtop_u1 == PROMOTE))
 Assert(type(lanetype_u2) == Fnn)
 Let Fnn_1 = lanetype_u2
 Assert(type(lanetype_u0) == Fnn)
 Let Fnn_2 = lanetype_u0
 Let fN_1 = lane__u4
 Let fN_2* = $promote__($lsizenn1(Fnn_1), $lsizenn2(Fnn_2), fN_1)
 Return fN_2*
}

vextunop__ (Inn_1 X M_1) (Inn_2 X M_2) (EXTADD_PAIRWISE sx) c_1 {
 Let ci* = $lanes_((Inn_2 X M_2), c_1)
 Let [cj_1, cj_2]* = $concat__1^-1(iN($lsizenn1((Inn_1 : Inn <: lanetype))), $extend__($lsizenn2(Inn_2), $lsizenn1(Inn_1), sx, ci)*)
 Let c = $invlanes_((Inn_1 X M_1), $iadd_($lsizenn1(Inn_1), cj_1, cj_2)*)
 Return c
}

vextbinop__ (Inn_1 X M_1) (Inn_2 X M_2) vextbinop__u0 c_1 c_2 {
 If (case(vextbinop__u0) == EXTMUL) {
   Let (EXTMUL sx hf) = vextbinop__u0
   Let ci_1* = $lanes_((Inn_2 X M_2), c_1)[$half(hf, 0, M_1) : M_1]
   Let ci_2* = $lanes_((Inn_2 X M_2), c_2)[$half(hf, 0, M_1) : M_1]
   Let c = $invlanes_((Inn_1 X M_1), $imul_($lsizenn1(Inn_1), $extend__($lsizenn2(Inn_2), $lsizenn1(Inn_1), sx, ci_1), $extend__($lsizenn2(Inn_2), $lsizenn1(Inn_1), sx, ci_2))*)
   Return c
 }
 Assert((vextbinop__u0 == DOT))
 Let ci_1* = $lanes_((Inn_2 X M_2), c_1)
 Let ci_2* = $lanes_((Inn_2 X M_2), c_2)
 Let [cj_1, cj_2]* = $concat__1^-1(iN($lsizenn1((Inn_1 : Inn <: lanetype))), $imul_($lsizenn1(Inn_1), $extend__($lsizenn2(Inn_2), $lsizenn1(Inn_1), S, ci_1), $extend__($lsizenn2(Inn_2), $lsizenn1(Inn_1), S, ci_2))*)
 Let c = $invlanes_((Inn_1 X M_1), $iadd_($lsizenn1(Inn_1), cj_1, cj_2)*)
 Return c
}

vshiftop_ (Jnn X M) vshiftop__u0 lane n {
 If ((vshiftop__u0 == SHL)) {
   Return $ishl_($lsizenn(Jnn), lane, n)
 }
 Assert(case(vshiftop__u0) == SHR)
 Let (SHR sx) = vshiftop__u0
 Return $ishr_($lsizenn(Jnn), sx, lane, n)
}

default_ valtype_u0 {
 If ((valtype_u0 == I32)) {
   Return (I32.CONST 0)
 }
 If ((valtype_u0 == I64)) {
   Return (I64.CONST 0)
 }
 If ((valtype_u0 == F32)) {
   Return (F32.CONST $fzero(32))
 }
 If ((valtype_u0 == F64)) {
   Return (F64.CONST $fzero(64))
 }
 If ((valtype_u0 == V128)) {
   Return (V128.CONST 0)
 }
 If ((valtype_u0 == FUNCREF)) {
   Return (REF.NULL FUNCREF)
 }
 Assert((valtype_u0 == EXTERNREF))
 Return (REF.NULL EXTERNREF)
}

funcsxv externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ xv* = externval_u0*
 If (case(externval_0) == FUNC) {
   Let (FUNC fa) = externval_0
   Return [fa] ++ $funcsxv(xv*)
 }
 Let [externval] ++ xv* = externval_u0*
 Return $funcsxv(xv*)
}

globalsxv externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ xv* = externval_u0*
 If (case(externval_0) == GLOBAL) {
   Let (GLOBAL ga) = externval_0
   Return [ga] ++ $globalsxv(xv*)
 }
 Let [externval] ++ xv* = externval_u0*
 Return $globalsxv(xv*)
}

tablesxv externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ xv* = externval_u0*
 If (case(externval_0) == TABLE) {
   Let (TABLE ta) = externval_0
   Return [ta] ++ $tablesxv(xv*)
 }
 Let [externval] ++ xv* = externval_u0*
 Return $tablesxv(xv*)
}

memsxv externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ xv* = externval_u0*
 If (case(externval_0) == MEM) {
   Let (MEM ma) = externval_0
   Return [ma] ++ $memsxv(xv*)
 }
 Let [externval] ++ xv* = externval_u0*
 Return $memsxv(xv*)
}

store {
 Return
}

frame {
 Let f = current_frame()
 Return f
}

funcaddr {
 Let f = current_frame()
 Return f.MODULE.FUNCS
}

funcinst {
 Return s.FUNCS
}

globalinst {
 Return s.GLOBALS
}

tableinst {
 Return s.TABLES
}

meminst {
 Return s.MEMS
}

eleminst {
 Return s.ELEMS
}

datainst {
 Return s.DATAS
}

moduleinst {
 Let f = current_frame()
 Return f.MODULE
}

type x {
 Let f = current_frame()
 Return f.MODULE.TYPES[x]
}

func x {
 Let f = current_frame()
 Return s.FUNCS[f.MODULE.FUNCS[x]]
}

global x {
 Let f = current_frame()
 Return s.GLOBALS[f.MODULE.GLOBALS[x]]
}

table x {
 Let f = current_frame()
 Return s.TABLES[f.MODULE.TABLES[x]]
}

mem x {
 Let f = current_frame()
 Return s.MEMS[f.MODULE.MEMS[x]]
}

elem x {
 Let f = current_frame()
 Return s.ELEMS[f.MODULE.ELEMS[x]]
}

data x {
 Let f = current_frame()
 Return s.DATAS[f.MODULE.DATAS[x]]
}

local x {
 Let f = current_frame()
 Return f.LOCALS[x]
}

with_local x v {
 Let f = current_frame()
 f.LOCALS[x] := v
}

with_global x v {
 Let f = current_frame()
 s.GLOBALS[f.MODULE.GLOBALS[x]].VALUE := v
}

with_table x i r {
 Let f = current_frame()
 s.TABLES[f.MODULE.TABLES[x]].REFS[i] := r
}

with_tableinst x ti {
 Let f = current_frame()
 s.TABLES[f.MODULE.TABLES[x]] := ti
}

with_mem x i j b* {
 Let f = current_frame()
 s.MEMS[f.MODULE.MEMS[x]].BYTES[i : j] := b*
}

with_meminst x mi {
 Let f = current_frame()
 s.MEMS[f.MODULE.MEMS[x]] := mi
}

with_elem x r* {
 Let f = current_frame()
 s.ELEMS[f.MODULE.ELEMS[x]].REFS := r*
}

with_data x b* {
 Let f = current_frame()
 s.DATAS[f.MODULE.DATAS[x]].BYTES := b*
}

growtable ti n r {
 Let { TYPE: ((i, j), rt); REFS: r'*; } = ti
 Let i' = (|r'*| + n)
 If ((i' ≤ j)) {
   Let ti' = { TYPE: ((i', j), rt); REFS: r'* ++ r^n; }
   Return ti'
 }
}

growmemory mi n {
 Let { TYPE: (PAGE (i, j)); BYTES: b*; } = mi
 Let i' = ((|b*| / (64 · $Ki())) + n)
 If ((i' ≤ j)) {
   Let mi' = { TYPE: (PAGE (i', j)); BYTES: b* ++ 0^(n · (64 · $Ki())); }
   Return mi'
 }
}

blocktype blocktype_u1 {
 If ((blocktype_u1 == (_RESULT ?()))) {
   Return ([] -> [])
 }
 If (case(blocktype_u1) == _RESULT) {
   Let (_RESULT valtype_0) = blocktype_u1
   If (valtype_0 != None) {
     Let ?(t) = valtype_0
     Return ([] -> [t])
   }
 }
 Assert(case(blocktype_u1) == _IDX)
 Let (_IDX x) = blocktype_u1
 Return $type(x)
}

funcs externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ externval'* = externval_u0*
 If (case(externval_0) == FUNC) {
   Let (FUNC fa) = externval_0
   Return [fa] ++ $funcs(externval'*)
 }
 Let [externval] ++ externval'* = externval_u0*
 Return $funcs(externval'*)
}

globals externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ externval'* = externval_u0*
 If (case(externval_0) == GLOBAL) {
   Let (GLOBAL ga) = externval_0
   Return [ga] ++ $globals(externval'*)
 }
 Let [externval] ++ externval'* = externval_u0*
 Return $globals(externval'*)
}

tables externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ externval'* = externval_u0*
 If (case(externval_0) == TABLE) {
   Let (TABLE ta) = externval_0
   Return [ta] ++ $tables(externval'*)
 }
 Let [externval] ++ externval'* = externval_u0*
 Return $tables(externval'*)
}

mems externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ externval'* = externval_u0*
 If (case(externval_0) == MEM) {
   Let (MEM ma) = externval_0
   Return [ma] ++ $mems(externval'*)
 }
 Let [externval] ++ externval'* = externval_u0*
 Return $mems(externval'*)
}

allocfunc moduleinst func {
 Assert(case(func) == FUNC)
 Let (FUNC x local* expr) = func
 Let fi = { TYPE: moduleinst.TYPES[x]; MODULE: moduleinst; CODE: func; }
 Let a = |s.FUNCS|
 fi :+ s.FUNCS
 Return a
}

allocfuncs moduleinst func_u0* {
 If ((func_u0* == [])) {
   Return []
 }
 Let [func] ++ func'* = func_u0*
 Let fa = $allocfunc(moduleinst, func)
 Let fa'* = $allocfuncs(moduleinst, func'*)
 Return [fa] ++ fa'*
}

allocglobal globaltype val {
 Let gi = { TYPE: globaltype; VALUE: val; }
 Let a = |s.GLOBALS|
 gi :+ s.GLOBALS
 Return a
}

allocglobals globaltype_u0* val_u1* {
 If ((globaltype_u0* == [])) {
   Assert((val_u1* == []))
   Return []
 }
 Else {
   Let [globaltype] ++ globaltype'* = globaltype_u0*
   Assert((|val_u1*| ≥ 1))
   Let [val] ++ val'* = val_u1*
   Let ga = $allocglobal(globaltype, val)
   Let ga'* = $allocglobals(globaltype'*, val'*)
   Return [ga] ++ ga'*
 }
}

alloctable ((i, j), rt) {
 Let ti = { TYPE: ((i, j), rt); REFS: (REF.NULL rt)^i; }
 Let a = |s.TABLES|
 ti :+ s.TABLES
 Return a
}

alloctables tabletype_u0* {
 If ((tabletype_u0* == [])) {
   Return []
 }
 Let [tabletype] ++ tabletype'* = tabletype_u0*
 Let ta = $alloctable(tabletype)
 Let ta'* = $alloctables(tabletype'*)
 Return [ta] ++ ta'*
}

allocmem (PAGE (i, j)) {
 Let mi = { TYPE: (PAGE (i, j)); BYTES: 0^(i · (64 · $Ki())); }
 Let a = |s.MEMS|
 mi :+ s.MEMS
 Return a
}

allocmems memtype_u0* {
 If ((memtype_u0* == [])) {
   Return []
 }
 Let [memtype] ++ memtype'* = memtype_u0*
 Let ma = $allocmem(memtype)
 Let ma'* = $allocmems(memtype'*)
 Return [ma] ++ ma'*
}

allocelem rt ref* {
 Let ei = { TYPE: rt; REFS: ref*; }
 Let a = |s.ELEMS|
 ei :+ s.ELEMS
 Return a
}

allocelems reftype_u0* ref_u1* {
 If (((reftype_u0* == []) && (ref_u1* == []))) {
   Return []
 }
 Assert((|ref_u1*| ≥ 1))
 Let [ref*] ++ ref'** = ref_u1*
 Assert((|reftype_u0*| ≥ 1))
 Let [rt] ++ rt'* = reftype_u0*
 Let ea = $allocelem(rt, ref*)
 Let ea'* = $allocelems(rt'*, ref'**)
 Return [ea] ++ ea'*
}

allocdata byte* {
 Let di = { BYTES: byte*; }
 Let a = |s.DATAS|
 di :+ s.DATAS
 Return a
}

allocdatas byte_u0* {
 If ((byte_u0* == [])) {
   Return []
 }
 Let [byte*] ++ byte'** = byte_u0*
 Let da = $allocdata(byte*)
 Let da'* = $allocdatas(byte'**)
 Return [da] ++ da'*
}

instexport fa* ga* ta* ma* (EXPORT name externidx_u0) {
 If (case(externidx_u0) == FUNC) {
   Let (FUNC x) = externidx_u0
   Return { NAME: name; VALUE: (FUNC fa*[x]); }
 }
 If (case(externidx_u0) == GLOBAL) {
   Let (GLOBAL x) = externidx_u0
   Return { NAME: name; VALUE: (GLOBAL ga*[x]); }
 }
 If (case(externidx_u0) == TABLE) {
   Let (TABLE x) = externidx_u0
   Return { NAME: name; VALUE: (TABLE ta*[x]); }
 }
 Assert(case(externidx_u0) == MEM)
 Let (MEM x) = externidx_u0
 Return { NAME: name; VALUE: (MEM ma*[x]); }
}

allocmodule module externval* val* ref** {
 Let fa_ex* = $funcs(externval*)
 Let ga_ex* = $globals(externval*)
 Let ma_ex* = $mems(externval*)
 Let ta_ex* = $tables(externval*)
 Assert(case(module) == MODULE)
 Let (MODULE type_0 import* func^n_func global_1 table_2 mem_3 elem_4 data_5 start? export*) = module
 Assert(case(data_5) == DATA)
 Let (DATA byte* datamode)^n_data = data_5
 Assert(case(elem_4) == ELEM)
 Let (ELEM rt expr_2* elemmode)^n_elem = elem_4
 Assert(case(mem_3) == MEMORY)
 Let (MEMORY memtype)^n_mem = mem_3
 Assert(case(table_2) == TABLE)
 Let (TABLE tabletype)^n_table = table_2
 Assert(case(global_1) == GLOBAL)
 Let (GLOBAL globaltype expr_1)^n_global = global_1
 Assert(case(type_0) == TYPE)
 Let (TYPE ft)* = type_0
 Let fa* = (|s.FUNCS| + i_func)^(i_func<n_func)
 Let ga* = (|s.GLOBALS| + i_global)^(i_global<n_global)
 Let ta* = (|s.TABLES| + i_table)^(i_table<n_table)
 Let ma* = (|s.MEMS| + i_mem)^(i_mem<n_mem)
 Let ea* = (|s.ELEMS| + i_elem)^(i_elem<n_elem)
 Let da* = (|s.DATAS| + i_data)^(i_data<n_data)
 Let xi* = $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*
 Let moduleinst = { TYPES: ft*; FUNCS: fa_ex* ++ fa*; GLOBALS: ga_ex* ++ ga*; TABLES: ta_ex* ++ ta*; MEMS: ma_ex* ++ ma*; ELEMS: ea*; DATAS: da*; EXPORTS: xi*; }
 Let funcaddr_0 = $allocfuncs(moduleinst, func^n_func)
 Assert((funcaddr_0 == fa*))
 Let globaladdr_0 = $allocglobals(globaltype^n_global, val*)
 Assert((globaladdr_0 == ga*))
 Let tableaddr_0 = $alloctables(tabletype^n_table)
 Assert((tableaddr_0 == ta*))
 Let memaddr_0 = $allocmems(memtype^n_mem)
 Assert((memaddr_0 == ma*))
 Let elemaddr_0 = $allocelems(rt^n_elem, ref**)
 Assert((elemaddr_0 == ea*))
 Let dataaddr_0 = $allocdatas(byte*^n_data)
 Assert((dataaddr_0 == da*))
 Return moduleinst
}

runelem (ELEM reftype expr* elemmode_u0) i {
 If ((elemmode_u0 == PASSIVE)) {
   Return []
 }
 If ((elemmode_u0 == DECLARE)) {
   Return [(ELEM.DROP i)]
 }
 Assert(case(elemmode_u0) == ACTIVE)
 Let (ACTIVE x instr*) = elemmode_u0
 Let n = |expr*|
 Return instr* ++ [(I32.CONST 0), (I32.CONST n), (TABLE.INIT x i), (ELEM.DROP i)]
}

rundata (DATA byte* datamode_u0) i {
 If ((datamode_u0 == PASSIVE)) {
   Return []
 }
 Assert(case(datamode_u0) == ACTIVE)
 Let (ACTIVE n_0 instr*) = datamode_u0
 Assert((n_0 == 0))
 Let n = |byte*|
 Return instr* ++ [(I32.CONST 0), (I32.CONST n), (MEMORY.INIT i), (DATA.DROP i)]
}

instantiate module externval* {
 Assert(case(module) == MODULE)
 Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) = module
 Assert(case(type) == TYPE*)
 Let (TYPE functype)* = type*
 Let n_D = |data*|
 Let n_E = |elem*|
 Let n_F = |func*|
 Assert(case(start) == START?)
 Let (START x)? = start?
 Assert(case(global) == GLOBAL*)
 Let (GLOBAL globaltype expr_G)* = global*
 Assert(case(elem) == ELEM*)
 Let (ELEM reftype expr_E* elemmode)* = elem*
 Let instr_D* = $concat_(instr, $rundata(data*[j], j)^(j<n_D))
 Let instr_E* = $concat_(instr, $runelem(elem*[i], i)^(i<n_E))
 Let moduleinst_init = { TYPES: functype*; FUNCS: $funcs(externval*) ++ (|s.FUNCS| + i_F)^(i_F<n_F); GLOBALS: $globals(externval*); TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }
 Let f_init = { LOCALS: []; MODULE: moduleinst_init; }
 Let z = f_init
 Push(callframe(z))
 Let [val]* = $eval_expr(expr_G)*
 Pop(callframe(_f))
 Push(callframe(z))
 Let [ref]** = $eval_expr(expr_E)**
 Pop(callframe(_f))
 Let moduleinst = $allocmodule(module, externval*, val*, ref**)
 Let f = { LOCALS: []; MODULE: moduleinst; }
 Push(callframe(0, f))
 Execute instr_E*
 Execute instr_D*
 If ((CALL x)? != None) {
   Let ?(instr_0) = (CALL x)?
   Execute instr_0
 }
 Pop(callframe(0, f))
 Return f.MODULE
}

invoke fa val^n {
 Let f = { LOCALS: []; MODULE: { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }; }
 Push(callframe(f))
 Let (t_1^n -> t_2*) = $funcinst()[fa].TYPE
 Pop(callframe(_f))
 Let k = |t_2*|
 Push(callframe(k, f))
 Push(val^n)
 Execute (CALL_ADDR fa)
 Pop_all(val*)
 Pop(callframe(k, f))
 Push(val*)
 Pop(val^k)
 Return val^k
}

Step_pure/unreachable {
 Trap
}

Step_pure/nop {
 Nop
}

Step_pure/drop {
 Assert(top_value())
 Pop(val)
 Nop
}

Step_pure/select t*? {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 Assert(top_value())
 Pop(val_2)
 Assert(top_value())
 Pop(val_1)
 If ((c != 0)) {
   Push(val_1)
 }
 Else {
   Push(val_2)
 }
}

Step_pure/if bt instr_1* instr_2* {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 If ((c != 0)) {
   Execute (BLOCK bt instr_1*)
 }
 Else {
   Execute (BLOCK bt instr_2*)
 }
}

Step_pure/label {
 Pop_all(val*)
 Assert(top_label())
 Pop(current_label())
 Push(val*)
}

Step_pure/br n_u0 {
 Pop_all(val*)
 Let L = current_label()
 Let n = arity(L)
 Let instr'* = cont(L)
 Pop(current_label())
 Let admininstr_u1* = val*
 If (((n_u0 == 0) && (|admininstr_u1*| ≥ n))) {
   Let val'* ++ val^n = admininstr_u1*
   Push(val^n)
   Execute instr'*
 }
 If ((n_u0 ≥ 1)) {
   Let l = (n_u0 - 1)
   If (type(admininstr_u1) == val*) {
     Let val* = admininstr_u1*
     Push(val*)
     Execute (BR l)
   }
 }
}

Step_pure/br_if l {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 If ((c != 0)) {
   Execute (BR l)
 }
 Else {
   Nop
 }
}

Step_pure/br_table l* l' {
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i < |l*|)) {
   Execute (BR l*[i])
 }
 Else {
   Execute (BR l')
 }
}

Step_pure/frame {
 Let f = current_frame()
 Let n = arity(f)
 Assert(top_values(n))
 Assert(top_values(n))
 Pop(val^n)
 Assert(top_frame())
 Pop(current_frame())
 Push(val^n)
}

Step_pure/return {
 Pop_all(val*)
 If (top_frame()) {
   Let f = current_frame()
   Let n = arity(f)
   Pop(current_frame())
   Let val'* ++ val^n = val*
   Push(val^n)
 }
 Else if (top_label()) {
   Pop(current_label())
   Push(val*)
   Execute RETURN
 }
}

Step_pure/trap {
 YetI: TODO: It is likely that the value stack of two rules are different.
}

Step_pure/unop nt unop {
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 If ((|$unop_(nt, unop, c_1)| ≤ 0)) {
   Trap
 }
 Let c = choose($unop_(nt, unop, c_1))
 Push((nt.CONST c))
}

Step_pure/binop nt binop {
 Assert(top_value(nt))
 Pop((nt.CONST c_2))
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 If ((|$binop_(nt, binop, c_1, c_2)| ≤ 0)) {
   Trap
 }
 Let c = choose($binop_(nt, binop, c_1, c_2))
 Push((nt.CONST c))
}

Step_pure/testop nt testop {
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 Let c = $testop_(nt, testop, c_1)
 Push((I32.CONST c))
}

Step_pure/relop nt relop {
 Assert(top_value(nt))
 Pop((nt.CONST c_2))
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 Let c = $relop_(nt, relop, c_1, c_2)
 Push((I32.CONST c))
}

Step_pure/cvtop nt_2 nt_1 cvtop {
 Assert(top_value(nt_1))
 Pop((nt_1.CONST c_1))
 If ((|$cvtop__(nt_1, nt_2, cvtop, c_1)| ≤ 0)) {
   Trap
 }
 Let c = choose($cvtop__(nt_1, nt_2, cvtop, c_1))
 Push((nt_2.CONST c))
}

Step_pure/ref.is_null {
 Assert(top_value())
 Pop(ref)
 If (case(ref) == REF.NULL) {
   Push((I32.CONST 1))
 }
 Else {
   Push((I32.CONST 0))
 }
}

Step_pure/vvunop V128 vvunop {
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $vvunop_(V128, vvunop, c_1)
 Push((V128.CONST c))
}

Step_pure/vvbinop V128 vvbinop {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $vvbinop_(V128, vvbinop, c_1, c_2)
 Push((V128.CONST c))
}

Step_pure/vvternop V128 vvternop {
 Assert(top_value(V128))
 Pop((V128.CONST c_3))
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $vvternop_(V128, vvternop, c_1, c_2, c_3)
 Push((V128.CONST c))
}

Step_pure/vvtestop V128 ANY_TRUE {
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $ine_($size(V128), c_1, 0)
 Push((I32.CONST c))
}

Step_pure/vunop sh vunop {
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 If ((|$vunop_(sh, vunop, c_1)| ≤ 0)) {
   Trap
 }
 Let c = choose($vunop_(sh, vunop, c_1))
 Push((V128.CONST c))
}

Step_pure/vbinop sh vbinop {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 If ((|$vbinop_(sh, vbinop, c_1, c_2)| ≤ 0)) {
   Trap
 }
 Let c = choose($vbinop_(sh, vbinop, c_1, c_2))
 Push((V128.CONST c))
}

Step_pure/vtestop (Jnn X N) ALL_TRUE {
 Assert(top_value(V128))
 Pop((V128.CONST c))
 Let ci_1* = $lanes_((Jnn X N), c)
 If ((ci_1 != 0)*) {
   Push((I32.CONST 1))
 }
 Else {
   Push((I32.CONST 0))
 }
}

Step_pure/vrelop sh vrelop {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $vrelop_(sh, vrelop, c_1, c_2)
 Push((V128.CONST c))
}

Step_pure/vshiftop (Jnn X N) vshiftop {
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c'* = $lanes_((Jnn X N), c_1)
 Let c = $invlanes_((Jnn X N), $vshiftop_((Jnn X N), vshiftop, c', n)*)
 Push((V128.CONST c))
}

Step_pure/vbitmask (Jnn X N) {
 Assert(top_value(V128))
 Pop((V128.CONST c))
 Let ci_1* = $lanes_((Jnn X N), c)
 Let ci = $ibits__1^-1(32, $ilt_($lsize(Jnn), S, ci_1, 0)*)
 Push((I32.CONST ci))
}

Step_pure/vswizzle (Pnn X M) {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c'* = $lanes_((Pnn X M), c_1) ++ 0^(256 - M)
 Let ci* = $lanes_((Pnn X M), c_2)
 Assert((ci*[k] < |c'*|)^(k<M))
 Assert((k < |ci*|)^(k<M))
 Let c = $invlanes_((Pnn X M), c'*[ci*[k]]^(k<M))
 Push((V128.CONST c))
}

Step_pure/vshuffle (Pnn X N) i* {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Assert((k < |i*|)^(k<N))
 Let c'* = $lanes_((Pnn X N), c_1) ++ $lanes_((Pnn X N), c_2)
 Assert((i*[k] < |c'*|)^(k<N))
 Let c = $invlanes_((Pnn X N), c'*[i*[k]]^(k<N))
 Push((V128.CONST c))
}

Step_pure/vsplat (Lnn X N) {
 Let nt_0 = $unpack(Lnn)
 Assert(top_value(nt_0))
 Pop((nt_0.CONST c_1))
 Let c = $invlanes_((Lnn X N), $packnum_(Lnn, c_1)^N)
 Push((V128.CONST c))
}

Step_pure/vextract_lane (lanetype_u0 X N) sx_u1? i {
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 If ((!(sx_u1? != None) && type(lanetype_u0) == numtype)) {
   Let nt = lanetype_u0
   If ((i < |$lanes_((nt X N), c_1)|)) {
     Let c_2 = $lanes_((nt X N), c_1)[i]
     Push((nt.CONST c_2))
   }
 }
 If (type(lanetype_u0) == packtype) {
   Let pt = lanetype_u0
   If (sx_u1? != None) {
     Let ?(sx) = sx_u1?
     If ((i < |$lanes_((pt X N), c_1)|)) {
       Let c_2 = $extend__($psize(pt), 32, sx, $lanes_((pt X N), c_1)[i])
       Push((I32.CONST c_2))
     }
   }
 }
}

Step_pure/vreplace_lane (Lnn X N) i {
 Let nt_0 = $unpack(Lnn)
 Assert(top_value(nt_0))
 Pop((nt_0.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $invlanes_((Lnn X N), update($lanes_((Lnn X N), c_1)[i], $packnum_(Lnn, c_2)))
 Push((V128.CONST c))
}

Step_pure/vextunop sh_1 sh_2 vextunop {
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $vextunop__(sh_1, sh_2, vextunop, c_1)
 Push((V128.CONST c))
}

Step_pure/vextbinop sh_1 sh_2 vextbinop {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $vextbinop__(sh_1, sh_2, vextbinop, c_1, c_2)
 Push((V128.CONST c))
}

Step_pure/vnarrow (Jnn_2 X N_2) (Jnn_1 X N_1) sx {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let ci_1* = $lanes_((Jnn_1 X N_1), c_1)
 Let ci_2* = $lanes_((Jnn_1 X N_1), c_2)
 Let cj_1* = $narrow__($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_1)*
 Let cj_2* = $narrow__($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_2)*
 Let c = $invlanes_((Jnn_2 X N_2), cj_1* ++ cj_2*)
 Push((V128.CONST c))
}

Step_pure/vcvtop (lanetype_u3 X n_u0) (lanetype_u4 X n_u1) vcvtop half_u2? zero_u5? {
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 If ((!(half_u2? != None) && !(zero_u5? != None))) {
   Let Lnn_1 = lanetype_u4
   Let Lnn_2 = lanetype_u3
   Let M = n_u1
   If ((n_u0 == M)) {
     Let ci* = $lanes_((Lnn_1 X M), c_1)
     Let cj** = $setproduct_(lane_(Lnn_2), $vcvtop__((Lnn_1 X M), (Lnn_2 X M), vcvtop, ci)*)
     If ((|$invlanes_((Lnn_2 X M), cj*)*| > 0)) {
       Let c = choose($invlanes_((Lnn_2 X M), cj*)*)
       Push((V128.CONST c))
     }
   }
 }
 If (!(zero_u5? != None)) {
   Let Lnn_1 = lanetype_u4
   Let Lnn_2 = lanetype_u3
   Let M_1 = n_u1
   Let M_2 = n_u0
   If (half_u2? != None) {
     Let ?(half) = half_u2?
     Let ci* = $lanes_((Lnn_1 X M_1), c_1)[$half(half, 0, M_2) : M_2]
     Let cj** = $setproduct_(lane_(Lnn_2), $vcvtop__((Lnn_1 X M_1), (Lnn_2 X M_2), vcvtop, ci)*)
     If ((|$invlanes_((Lnn_2 X M_2), cj*)*| > 0)) {
       Let c = choose($invlanes_((Lnn_2 X M_2), cj*)*)
       Push((V128.CONST c))
     }
   }
 }
 If (!(half_u2? != None)) {
   Let M_1 = n_u1
   Let M_2 = n_u0
   If (type(lanetype_u4) == numtype) {
     Let nt_1 = lanetype_u4
     If (type(lanetype_u3) == numtype) {
       Let nt_2 = lanetype_u3
       If (zero_u5? != None) {
         Let ci* = $lanes_((nt_1 X M_1), c_1)
         Let cj** = $setproduct_(lane_((nt_2 : numtype <: lanetype)), $vcvtop__((nt_1 X M_1), (nt_2 X M_2), vcvtop, ci)* ++ [$zero(nt_2)]^M_1)
         If ((|$invlanes_((nt_2 X M_2), cj*)*| > 0)) {
           Let c = choose($invlanes_((nt_2 X M_2), cj*)*)
           Push((V128.CONST c))
         }
       }
     }
   }
 }
}

Step_pure/local.tee x {
 Assert(top_value())
 Pop(val)
 Push(val)
 Push(val)
 Execute (LOCAL.SET x)
}

Step_read/block bt instr* {
 Let z = current_state()
 Let (t_1^k -> t_2^n) = $blocktype(z, bt)
 Assert(top_values(k))
 Pop(val^k)
 Let L = label(n, [])
 Enter (L, val^k ++ instr*) {
 }
}

Step_read/loop bt instr* {
 Let z = current_state()
 Let (t_1^k -> t_2^n) = $blocktype(z, bt)
 Assert(top_values(k))
 Pop(val^k)
 Let L = label(k, [(LOOP bt instr*)])
 Enter (L, val^k ++ instr*) {
 }
}

Step_read/call x {
 Let z = current_state()
 Assert((x < |$funcaddr(z)|))
 Execute (CALL_ADDR $funcaddr(z)[x])
}

Step_read/call_indirect x y {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i ≥ |$table(z, x).REFS|)) {
   Trap
 }
 If (!(case($table(z, x).REFS[i]) == REF.FUNC_ADDR)) {
   Trap
 }
 Let (REF.FUNC_ADDR a) = $table(z, x).REFS[i]
 If ((a ≥ |$funcinst(z)|)) {
   Trap
 }
 If (($type(z, y) != $funcinst(z)[a].TYPE)) {
   Trap
 }
 Execute (CALL_ADDR a)
}

Step_read/call_addr a {
 Let z = current_state()
 Assert((a < |$funcinst(z)|))
 Let { TYPE: (t_1^k -> t_2^n); MODULE: mm; CODE: func; } = $funcinst(z)[a]
 Assert(top_values(k))
 Pop(val^k)
 Assert(case(func) == FUNC)
 Let (FUNC x local_0 instr*) = func
 Assert(case(local_0) == LOCAL)
 Let (LOCAL t)* = local_0
 Let f = { LOCALS: val^k ++ $default_(t)*; MODULE: mm; }
 Let F = callframe(n, f)
 Push(F)
 Let L = label(n, [])
 Enter (L, instr*) {
 }
}

Step_read/ref.func x {
 Let z = current_state()
 Assert((x < |$funcaddr(z)|))
 Push((REF.FUNC_ADDR $funcaddr(z)[x]))
}

Step_read/local.get x {
 Let z = current_state()
 Push($local(z, x))
}

Step_read/global.get x {
 Let z = current_state()
 Push($global(z, x).VALUE)
}

Step_read/table.get x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i ≥ |$table(z, x).REFS|)) {
   Trap
 }
 Push($table(z, x).REFS[i])
}

Step_read/table.size x {
 Let z = current_state()
 Let n = |$table(z, x).REFS|
 Push((I32.CONST n))
}

Step_read/table.fill x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(val)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((i + n) > |$table(z, x).REFS|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   Push((I32.CONST i))
   Push(val)
   Execute (TABLE.SET x)
   Push((I32.CONST (i + 1)))
   Push(val)
   Push((I32.CONST (n - 1)))
   Execute (TABLE.FILL x)
 }
}

Step_read/table.copy x y {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$table(z, y).REFS|)) {
   Trap
 }
 If (((j + n) > |$table(z, x).REFS|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   If ((j ≤ i)) {
     Push((I32.CONST j))
     Push((I32.CONST i))
     Execute (TABLE.GET y)
     Execute (TABLE.SET x)
     Push((I32.CONST (j + 1)))
     Push((I32.CONST (i + 1)))
   }
   Else {
     Push((I32.CONST ((j + n) - 1)))
     Push((I32.CONST ((i + n) - 1)))
     Execute (TABLE.GET y)
     Execute (TABLE.SET x)
     Push((I32.CONST j))
     Push((I32.CONST i))
   }
   Push((I32.CONST (n - 1)))
   Execute (TABLE.COPY x y)
 }
}

Step_read/table.init x y {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$elem(z, y).REFS|)) {
   Trap
 }
 If (((j + n) > |$table(z, x).REFS|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else if ((i < |$elem(z, y).REFS|)) {
   Push((I32.CONST j))
   Push($elem(z, y).REFS[i])
   Execute (TABLE.SET x)
   Push((I32.CONST (j + 1)))
   Push((I32.CONST (i + 1)))
   Push((I32.CONST (n - 1)))
   Execute (TABLE.INIT x y)
 }
}

Step_read/load numtype_u0 sz_sx_u1? ao {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (!(sz_sx_u1? != None)) {
   Let nt = numtype_u0
   If ((((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, 0).BYTES|)) {
     Trap
   }
   Let c = $nbytes__1^-1(nt, $mem(z, 0).BYTES[(i + ao.OFFSET) : ($size(nt) / 8)])
   Push((nt.CONST c))
 }
 If (type(numtype_u0) == Inn) {
   If (sz_sx_u1? != None) {
     Let ?(sz_sx_0) = sz_sx_u1?
     Let (n, sx) = sz_sx_0
     If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|)) {
       Trap
     }
   }
   Let Inn = numtype_u0
   If (sz_sx_u1? != None) {
     Let ?(sz_sx_0) = sz_sx_u1?
     Let (n, sx) = sz_sx_0
     Let c = $ibytes__1^-1(n, $mem(z, 0).BYTES[(i + ao.OFFSET) : (n / 8)])
     Push((Inn.CONST $extend__(n, $size(Inn), sx, c)))
   }
 }
}

Step_read/vload V128 vloadop_u0? ao {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (!(vloadop_u0? != None)) {
   If ((((i + ao.OFFSET) + ($size(V128) / 8)) > |$mem(z, 0).BYTES|)) {
     Trap
   }
   Let c = $vbytes__1^-1(V128, $mem(z, 0).BYTES[(i + ao.OFFSET) : ($size(V128) / 8)])
   Push((V128.CONST c))
 }
 Else {
   Let ?(vloadop_0) = vloadop_u0?
   If (case(vloadop_0) == SHAPE) {
     Let (SHAPE M N sx) = vloadop_0
     If ((((i + ao.OFFSET) + ((M · N) / 8)) > |$mem(z, 0).BYTES|)) {
       Trap
     }
     If (type($lsize^-1((M · 2))) == Jnn) {
       Let Jnn = $lsize^-1((M · 2))
       Let j^N = $ibytes__1^-1(M, $mem(z, 0).BYTES[((i + ao.OFFSET) + ((k · M) / 8)) : (M / 8)])^(k<N)
       Let c = $invlanes_((Jnn X N), $extend__(M, $lsize(Jnn), sx, j)^N)
       Push((V128.CONST c))
     }
   }
   If (case(vloadop_0) == SPLAT) {
     Let (SPLAT N) = vloadop_0
     If ((((i + ao.OFFSET) + (N / 8)) > |$mem(z, 0).BYTES|)) {
       Trap
     }
     Let M = (128 / N)
     If (type($lsize^-1(N)) == Jnn) {
       Let Jnn = $lsize^-1(N)
       Let j = $ibytes__1^-1(N, $mem(z, 0).BYTES[(i + ao.OFFSET) : (N / 8)])
       Let c = $invlanes_((Jnn X M), j^M)
       Push((V128.CONST c))
     }
   }
   If (case(vloadop_0) == ZERO) {
     Let (ZERO N) = vloadop_0
     If ((((i + ao.OFFSET) + (N / 8)) > |$mem(z, 0).BYTES|)) {
       Trap
     }
     Let j = $ibytes__1^-1(N, $mem(z, 0).BYTES[(i + ao.OFFSET) : (N / 8)])
     Let c = $extend__(N, 128, U, j)
     Push((V128.CONST c))
   }
 }
}

Step_read/vload_lane V128 N ao j {
 Let z = current_state()
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((((i + ao.OFFSET) + (N / 8)) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 Let M = (128 / N)
 If (type($lsize^-1(N)) == Jnn) {
   Let Jnn = $lsize^-1(N)
   Let k = $ibytes__1^-1(N, $mem(z, 0).BYTES[(i + ao.OFFSET) : (N / 8)])
   Let c = $invlanes_((Jnn X M), update($lanes_((Jnn X M), c_1)[j], k))
   Push((V128.CONST c))
 }
}

Step_read/memory.size {
 Let z = current_state()
 Let ((n · 64) · $Ki()) = |$mem(z, 0).BYTES|
 Push((I32.CONST n))
}

Step_read/memory.fill {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(val)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((i + n) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   Push((I32.CONST i))
   Push(val)
   Execute (STORE I32 ?(8) $memarg0())
   Push((I32.CONST (i + 1)))
   Push(val)
   Push((I32.CONST (n - 1)))
   Execute MEMORY.FILL
 }
}

Step_read/memory.copy {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 If (((j + n) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   If ((j ≤ i)) {
     Push((I32.CONST j))
     Push((I32.CONST i))
     Execute (LOAD I32 ?((8, U)) $memarg0())
     Execute (STORE I32 ?(8) $memarg0())
     Push((I32.CONST (j + 1)))
     Push((I32.CONST (i + 1)))
   }
   Else {
     Push((I32.CONST ((j + n) - 1)))
     Push((I32.CONST ((i + n) - 1)))
     Execute (LOAD I32 ?((8, U)) $memarg0())
     Execute (STORE I32 ?(8) $memarg0())
     Push((I32.CONST j))
     Push((I32.CONST i))
   }
   Push((I32.CONST (n - 1)))
   Execute MEMORY.COPY
 }
}

Step_read/memory.init x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$data(z, x).BYTES|)) {
   Trap
 }
 If (((j + n) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else if ((i < |$data(z, x).BYTES|)) {
   Push((I32.CONST j))
   Push((I32.CONST $data(z, x).BYTES[i]))
   Execute (STORE I32 ?(8) $memarg0())
   Push((I32.CONST (j + 1)))
   Push((I32.CONST (i + 1)))
   Push((I32.CONST (n - 1)))
   Execute (MEMORY.INIT x)
 }
}

Step/ctxt {
 YetI: TODO: It is likely that the value stack of two rules are different.
}

Step/local.set x {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 $with_local(z, x, val)
}

Step/global.set x {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 $with_global(z, x, val)
}

Step/table.set x {
 Let z = current_state()
 Assert(top_value())
 Pop(ref)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i ≥ |$table(z, x).REFS|)) {
   Trap
 }
 $with_table(z, x, i, ref)
}

Step/table.grow x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(ref)
 Either {
   Let ti = $growtable($table(z, x), n, ref)
   Push((I32.CONST |$table(z, x).REFS|))
   $with_tableinst(z, x, ti)
 }
 Or {
   Push((I32.CONST $invsigned_(32, -(1))))
 }
}

Step/elem.drop x {
 Let z = current_state()
 $with_elem(z, x, [])
}

Step/store numtype_u1 sz_u2? ao {
 Let z = current_state()
 Assert(top_value(numtype_u0))
 Pop((numtype_u0.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (!(sz_u2? != None)) {
   Let nt = numtype_u1
   If ((numtype_u0 == nt)) {
     If ((((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, 0).BYTES|)) {
       Trap
     }
     Let b* = $nbytes_(nt, c)
     $with_mem(z, 0, (i + ao.OFFSET), ($size(nt) / 8), b*)
   }
 }
 Else {
   Let ?(n) = sz_u2?
   If (type(numtype_u1) == Inn) {
     Let Inn = numtype_u1
     If ((numtype_u0 == Inn)) {
       If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|)) {
         Trap
       }
       Let b* = $ibytes_(n, $wrap__($size(Inn), n, c))
       $with_mem(z, 0, (i + ao.OFFSET), (n / 8), b*)
     }
   }
 }
}

Step/vstore V128 ao {
 Let z = current_state()
 Assert(top_value(V128))
 Pop((V128.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((((i + ao.OFFSET) + ($size(V128) / 8)) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 Let b* = $vbytes_(V128, c)
 $with_mem(z, 0, (i + ao.OFFSET), ($size(V128) / 8), b*)
}

Step/vstore_lane V128 N ao j {
 Let z = current_state()
 Assert(top_value(V128))
 Pop((V128.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((((i + ao.OFFSET) + N) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 Let M = (128 / N)
 If (type($lsize^-1(N)) == Jnn) {
   Let Jnn = $lsize^-1(N)
   If ((j < |$lanes_((Jnn X M), c)|)) {
     Let b* = $ibytes_(N, $lanes_((Jnn X M), c)[j])
     $with_mem(z, 0, (i + ao.OFFSET), (N / 8), b*)
   }
 }
}

Step/memory.grow {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Either {
   Let mi = $growmemory($mem(z, 0), n)
   Push((I32.CONST (|$mem(z, 0).BYTES| / (64 · $Ki()))))
   $with_meminst(z, 0, mi)
 }
 Or {
   Push((I32.CONST $invsigned_(32, -(1))))
 }
}

Step/data.drop x {
 Let z = current_state()
 $with_data(z, x, [])
}

eval_expr instr* {
 Execute instr*
 Pop(val)
 Return [val]
}
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
Numtype_ok
- the number type numtype is valid.

Vectype_ok
- the vector type vectype is valid.

Heaptype_ok
- the heap type heaptype_u0 is valid if and only if:
  - Either:
    - heaptype_u0 is absheaptype.
  - Or:
    - heaptype_u0 is (_IDX typeidx).
    - |C.TYPES| is greater than typeidx.
    - C.TYPES[typeidx] is dt.
  - Or:
    - heaptype_u0 is (REC i).
    - |C.RECS| is greater than i.
    - C.RECS[i] is st.

Reftype_ok
- the reference type (REF (NULL ()?) heaptype) is valid if and only if:
  - the heap type heaptype is valid.

Valtype_ok
- the value type valtype_u0 is valid if and only if:
  - Either:
    - valtype_u0 is numtype.
    - the number type numtype is valid.
  - Or:
    - valtype_u0 is vectype.
    - the vector type vectype is valid.
  - Or:
    - valtype_u0 is reftype.
    - the reference type reftype is valid.
  - Or:
    - valtype_u0 is BOT.

Resulttype_ok
- the value type sequence t* is valid if and only if:
  - For all t in t*,
    - the value type t is valid.

Instrtype_ok
- the instruction type (t_1* ->_ x* ++ t_2*) is valid if and only if:
  - |x*| is |lct*|.
  - For all x in x*,
    - |C.LOCALS| is greater than x.
  - the value type sequence t_1* is valid.
  - the value type sequence t_2* is valid.
  - For all lct in lct* and x in x*,
    - C.LOCALS[x] is lct.

Packtype_ok
- the packed type packtype is valid.

Storagetype_ok
- the storage type storagetype_u0 is valid if and only if:
  - Either:
    - storagetype_u0 is valtype.
    - the value type valtype is valid.
  - Or:
    - storagetype_u0 is packtype.
    - the packed type packtype is valid.

Fieldtype_ok
- the field type ((MUT ()?), storagetype) is valid if and only if:
  - the storage type storagetype is valid.

Functype_ok
- the function type (t_1* -> t_2*) is valid if and only if:
  - the value type sequence t_1* is valid.
  - the value type sequence t_2* is valid.

Comptype_ok
- the composite type comptype_u0 is valid if and only if:
  - Either:
    - comptype_u0 is (STRUCT fieldtype*).
    - For all fieldtype in fieldtype*,
      - the field type fieldtype is valid.
  - Or:
    - comptype_u0 is (ARRAY fieldtype).
    - the field type fieldtype is valid.
  - Or:
    - comptype_u0 is (FUNC functype).
    - the function type functype is valid.

Packtype_sub
- the packed type packtype matches the packed type packtype.

Numtype_sub
- the number type numtype matches the number type numtype.

Deftype_sub
- the defined type deftype_1 matches the defined type deftype_2 if and only if:
  - Either:
    - $clos_deftype(C, deftype_1) is $clos_deftype(C, deftype_2).
  - Or:
    - |typeuse*| is greater than i.
    - $unrolldt(deftype_1) is (SUB fin typeuse* ct).
    - the type use typeuse*[i] matches the heap type deftype_2.

Heaptype_sub
- the heap type heaptype_u0 matches the heap type heaptype_u1 if and only if:
  - Either:
    - heaptype_u0 is heaptype.
    - heaptype_u1 is heaptype.
  - Or:
    - heaptype_u0 is heaptype_1.
    - heaptype_u1 is heaptype_2.
    - the heap type heaptype' is valid.
    - the heap type heaptype_1 matches the heap type heaptype'.
    - the heap type heaptype' matches the heap type heaptype_2.
  - Or:
    - heaptype_u0 is EQ.
    - heaptype_u1 is ANY.
  - Or:
    - heaptype_u0 is I31.
    - heaptype_u1 is EQ.
  - Or:
    - heaptype_u0 is STRUCT.
    - heaptype_u1 is EQ.
  - Or:
    - heaptype_u0 is ARRAY.
    - heaptype_u1 is EQ.
  - Or:
    - heaptype_u0 is deftype.
    - heaptype_u1 is STRUCT.
    - $expanddt(deftype) is (STRUCT fieldtype*).
  - Or:
    - heaptype_u0 is deftype.
    - heaptype_u1 is ARRAY.
    - $expanddt(deftype) is (ARRAY fieldtype).
  - Or:
    - heaptype_u0 is deftype.
    - heaptype_u1 is FUNC.
    - $expanddt(deftype) is (FUNC functype).
  - Or:
    - heaptype_u0 is deftype_1.
    - heaptype_u1 is deftype_2.
    - the defined type deftype_1 matches the defined type deftype_2.
  - Or:
    - heaptype_u0 is (_IDX typeidx).
    - heaptype_u1 is heaptype.
    - |C.TYPES| is greater than typeidx.
    - the defined type C.TYPES[typeidx] matches the heap type heaptype.
  - Or:
    - heaptype_u0 is heaptype.
    - heaptype_u1 is (_IDX typeidx).
    - |C.TYPES| is greater than typeidx.
    - the heap type heaptype matches the defined type C.TYPES[typeidx].
  - Or:
    - heaptype_u0 is (REC i).
    - heaptype_u1 is typeuse*[j].
    - |C.RECS| is greater than i.
    - |typeuse*| is greater than j.
    - C.RECS[i] is (SUB fin typeuse* ct).
  - Or:
    - heaptype_u0 is NONE.
    - heaptype_u1 is heaptype.
    - the heap type heaptype matches the heap type ANY.
  - Or:
    - heaptype_u0 is NOFUNC.
    - heaptype_u1 is heaptype.
    - the heap type heaptype matches the heap type FUNC.
  - Or:
    - heaptype_u0 is NOEXTERN.
    - heaptype_u1 is heaptype.
    - the heap type heaptype matches the heap type EXTERN.
  - Or:
    - heaptype_u0 is BOT.
    - heaptype_u1 is heaptype.

Reftype_sub
- the reference type (REF (NULL _u0?) ht_1) matches the reference type (REF (NULL _u1?) ht_2) if and only if:
  - Either:
    - _u0? is ?().
    - _u1? is ?().
    - the heap type ht_1 matches the heap type ht_2.
  - Or:
    - _u0? is ()?.
    - _u1? is ?(()).
    - the heap type ht_1 matches the heap type ht_2.

Vectype_sub
- the vector type vectype matches the vector type vectype.

Valtype_sub
- the value type valtype_u0 matches the value type valtype_u1 if and only if:
  - Either:
    - valtype_u0 is numtype_1.
    - valtype_u1 is numtype_2.
    - the number type numtype_1 matches the number type numtype_2.
  - Or:
    - valtype_u0 is vectype_1.
    - valtype_u1 is vectype_2.
    - the vector type vectype_1 matches the vector type vectype_2.
  - Or:
    - valtype_u0 is reftype_1.
    - valtype_u1 is reftype_2.
    - the reference type reftype_1 matches the reference type reftype_2.
  - Or:
    - valtype_u0 is BOT.
    - valtype_u1 is valtype.

Storagetype_sub
- the storage type storagetype_u0 matches the storage type storagetype_u1 if and only if:
  - Either:
    - storagetype_u0 is valtype_1.
    - storagetype_u1 is valtype_2.
    - the value type valtype_1 matches the value type valtype_2.
  - Or:
    - storagetype_u0 is packtype_1.
    - storagetype_u1 is packtype_2.
    - the packed type packtype_1 matches the packed type packtype_2.

Fieldtype_sub
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

Resulttype_sub
- the value type sequence t_1* matches the value type sequence t_2* if and only if:
  - |t_2*| is |t_1*|.
  - For all t_1 in t_1* and t_2 in t_2*,
    - the value type t_1 matches the value type t_2.

Functype_sub
- the function type (t_11* -> t_12*) matches the function type (t_21* -> t_22*) if and only if:
  - the value type sequence t_21* matches the value type sequence t_11*.
  - the value type sequence t_12* matches the value type sequence t_22*.

Comptype_sub
- the composite type comptype_u0 matches the composite type comptype_u1 if and only if:
  - Either:
    - comptype_u0 is (STRUCT yt_1* ++ [yt'_1]).
    - comptype_u1 is (STRUCT yt_2*).
    - |yt_2*| is |yt_1*|.
    - For all yt_1 in yt_1* and yt_2 in yt_2*,
      - the field type yt_1 matches the field type yt_2.
  - Or:
    - comptype_u0 is (ARRAY yt_1).
    - comptype_u1 is (ARRAY yt_2).
    - the field type yt_1 matches the field type yt_2.
  - Or:
    - comptype_u0 is (FUNC ft_1).
    - comptype_u1 is (FUNC ft_2).
    - the function type ft_1 matches the function type ft_2.

Subtype_ok
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

Subtype_ok2
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

Rectype_ok2
- the recursive type (REC subtype_u0*) is valid with the oktypeidxnat (OK x i) if and only if:
  - Either:
    - subtype_u0* is [].
  - Or:
    - subtype_u0* is [subtype_1] ++ subtype*.
    - the sub type subtype_1 is valid with the oktypeidxnat (OK x i).
    - the recursive type (REC subtype*) is valid with the oktypeidxnat (OK (x + 1) (i + 1)).

Rectype_ok
- the recursive type (REC subtype_u0*) is valid with the oktypeidx (OK x) if and only if:
  - Either:
    - subtype_u0* is [].
  - Or:
    - subtype_u0* is [subtype_1] ++ subtype*.
    - the sub type subtype_1 is valid with the oktypeidx (OK x).
    - the recursive type (REC subtype*) is valid with the oktypeidx (OK (x + 1)).
  - Or:
    - subtype_u0* is subtype*.
    - Under the context prepend(C.RECS, subtype*), the recursive type (REC subtype*) is valid with the oktypeidxnat (OK x 0).

Deftype_ok
- the defined type (DEF rectype i) is valid if and only if:
  - the recursive type rectype is valid with the oktypeidx (OK x).
  - rectype is (REC subtype^n).
  - i is less than n.

Limits_ok
- the limits (n, m) is valid with the nat k if and only if:
  - n is less than or equal to m.
  - m is less than or equal to k.

Globaltype_ok
- the global type ((MUT ()?), t) is valid if and only if:
  - the value type t is valid.

Tabletype_ok
- the table type (limits, reftype) is valid if and only if:
  - the limits limits is valid with the nat ((2 ^ 32) - 1).
  - the reference type reftype is valid.

Memtype_ok
- the memory type (PAGE limits) is valid if and only if:
  - the limits limits is valid with the nat (2 ^ 16).

Externtype_ok
- the external type externtype_u0 is valid if and only if:
  - Either:
    - externtype_u0 is (FUNC deftype).
    - the defined type deftype is valid.
    - $expanddt(deftype) is (FUNC functype).
  - Or:
    - externtype_u0 is (GLOBAL globaltype).
    - the global type globaltype is valid.
  - Or:
    - externtype_u0 is (TABLE tabletype).
    - the table type tabletype is valid.
  - Or:
    - externtype_u0 is (MEM memtype).
    - the memory type memtype is valid.

Instrtype_sub
- the instruction type (t_11* ->_ x_1* ++ t_12*) matches the instruction type (t_21* ->_ x_2* ++ t_22*) if and only if:
  - |x*| is |t*|.
  - For all x in x*,
    - |C.LOCALS| is greater than x.
  - the value type sequence t_21* matches the value type sequence t_11*.
  - the value type sequence t_12* matches the value type sequence t_22*.
  - x* is $setminus_(localidx, x_2*, x_1*).
  - For all t in t* and x in x*,
    - C.LOCALS[x] is (SET, t).

Limits_sub
- the limits (n_1, m_1) matches the limits (n_2, m_2) if and only if:
  - n_1 is greater than or equal to n_2.
  - m_1 is less than or equal to m_2.

Globaltype_sub
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

Tabletype_sub
- the table type (limits_1, reftype_1) matches the table type (limits_2, reftype_2) if and only if:
  - the limits limits_1 matches the limits limits_2.
  - the reference type reftype_1 matches the reference type reftype_2.
  - the reference type reftype_2 matches the reference type reftype_1.

Memtype_sub
- the memory type (PAGE limits_1) matches the memory type (PAGE limits_2) if and only if:
  - the limits limits_1 matches the limits limits_2.

Externtype_sub
- the external type externtype_u0 matches the external type externtype_u1 if and only if:
  - Either:
    - externtype_u0 is (FUNC deftype_1).
    - externtype_u1 is (FUNC deftype_2).
    - the defined type deftype_1 matches the defined type deftype_2.
  - Or:
    - externtype_u0 is (GLOBAL globaltype_1).
    - externtype_u1 is (GLOBAL globaltype_2).
    - the global type globaltype_1 matches the global type globaltype_2.
  - Or:
    - externtype_u0 is (TABLE tabletype_1).
    - externtype_u1 is (TABLE tabletype_2).
    - the table type tabletype_1 matches the table type tabletype_2.
  - Or:
    - externtype_u0 is (MEM memtype_1).
    - externtype_u1 is (MEM memtype_2).
    - the memory type memtype_1 matches the memory type memtype_2.

Blocktype_ok
- the block type blocktype_u0 is valid with the instruction type (valtype_u1* ->_ [] ++ valtype_u2*) if and only if:
  - Either:
    - blocktype_u0 is (_RESULT valtype?).
    - valtype_u1* is [].
    - valtype_u2* is valtype?.
    - If valtype != None,
      - the value type valtype is valid.
  - Or:
    - blocktype_u0 is (_IDX typeidx).
    - valtype_u1* is t_1*.
    - valtype_u2* is t_2*.
    - |C.TYPES| is greater than typeidx.
    - $expanddt(C.TYPES[typeidx]) is (FUNC (t_1* -> t_2*)).

Instr_ok/nop
- the instr NOP is valid with the instruction type ([] ->_ [] ++ []).

Instr_ok/unreachable
- the instr UNREACHABLE is valid with the instruction type (t_1* ->_ [] ++ t_2*) if and only if:
  - the instruction type (t_1* ->_ [] ++ t_2*) is valid.

Instr_ok/drop
- the instr DROP is valid with the instruction type ([t] ->_ [] ++ []) if and only if:
  - the value type t is valid.

Instr_ok/select
- the instr (SELECT ?([t])) is valid with the instruction type ([t, t, I32] ->_ [] ++ [t]) if and only if:
  - the value type t is valid.

Instr_ok/block
- the instr (BLOCK bt instr*) is valid with the instruction type (t_1* ->_ [] ++ t_2*) if and only if:
  - the block type bt is valid with the instruction type (t_1* ->_ [] ++ t_2*).
  - Under the context prepend(C.LABELS, [t_2*]), the instr sequence instr* is valid with the instruction type (t_1* ->_ x* ++ t_2*).

Instr_ok/loop
- the instr (LOOP bt instr*) is valid with the instruction type (t_1* ->_ [] ++ t_2*) if and only if:
  - the block type bt is valid with the instruction type (t_1* ->_ [] ++ t_2*).
  - Under the context prepend(C.LABELS, [t_1*]), the instr sequence instr* is valid with the instruction type (t_1* ->_ x* ++ t_2*).

Instr_ok/if
- the instr (IF bt instr_1* instr_2*) is valid with the instruction type (t_1* ++ [I32] ->_ [] ++ t_2*) if and only if:
  - the block type bt is valid with the instruction type (t_1* ->_ [] ++ t_2*).
  - Under the context prepend(C.LABELS, [t_2*]), the instr sequence instr_1* is valid with the instruction type (t_1* ->_ x_1* ++ t_2*).
  - Under the context prepend(C.LABELS, [t_2*]), the instr sequence instr_2* is valid with the instruction type (t_1* ->_ x_2* ++ t_2*).

Instr_ok/br
- the instr (BR l) is valid with the instruction type (t_1* ++ t* ->_ [] ++ t_2*) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t*.
  - the instruction type (t_1* ->_ [] ++ t_2*) is valid.

Instr_ok/br_if
- the instr (BR_IF l) is valid with the instruction type (t* ++ [I32] ->_ [] ++ t*) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t*.

Instr_ok/br_table
- the instr (BR_TABLE l* l') is valid with the instruction type (t_1* ++ t* ->_ [] ++ t_2*) if and only if:
  - For all l in l*,
    - |C.LABELS| is greater than l.
  - |C.LABELS| is greater than l'.
  - For all l in l*,
    - the value type sequence t* matches the result type C.LABELS[l].
  - the value type sequence t* matches the result type C.LABELS[l'].
  - the instruction type (t_1* ->_ [] ++ t_2*) is valid.

Instr_ok/br_on_null
- the instr (BR_ON_NULL l) is valid with the instruction type (t* ++ [(REF (NULL ?(())) ht)] ->_ [] ++ t* ++ [(REF (NULL ?()) ht)]) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t*.
  - the heap type ht is valid.

Instr_ok/br_on_non_null
- the instr (BR_ON_NON_NULL l) is valid with the instruction type (t* ++ [(REF (NULL ?(())) ht)] ->_ [] ++ t*) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t* ++ [(REF (NULL ?()) ht)].

Instr_ok/br_on_cast
- the instr (BR_ON_CAST l rt_1 rt_2) is valid with the instruction type (t* ++ [rt_1] ->_ [] ++ t* ++ [$diffrt(rt_1, rt_2)]) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t* ++ [rt].
  - the reference type rt_1 is valid.
  - the reference type rt_2 is valid.
  - the reference type rt_2 matches the reference type rt_1.
  - the reference type rt_2 matches the reference type rt.

Instr_ok/br_on_cast_fail
- the instr (BR_ON_CAST_FAIL l rt_1 rt_2) is valid with the instruction type (t* ++ [rt_1] ->_ [] ++ t* ++ [rt_2]) if and only if:
  - |C.LABELS| is greater than l.
  - C.LABELS[l] is t* ++ [rt].
  - the reference type rt_1 is valid.
  - the reference type rt_2 is valid.
  - the reference type rt_2 matches the reference type rt_1.
  - the reference type $diffrt(rt_1, rt_2) matches the reference type rt.

Instr_ok/call
- the instr (CALL x) is valid with the instruction type (t_1* ->_ [] ++ t_2*) if and only if:
  - |C.FUNCS| is greater than x.
  - $expanddt(C.FUNCS[x]) is (FUNC (t_1* -> t_2*)).

Instr_ok/call_ref
- the instr (CALL_REF $idx(x)) is valid with the instruction type (t_1* ++ [(REF (NULL ?(())) $idx(x))] ->_ [] ++ t_2*) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (FUNC (t_1* -> t_2*)).

Instr_ok/call_indirect
- the instr (CALL_INDIRECT x $idx(y)) is valid with the instruction type (t_1* ++ [I32] ->_ [] ++ t_2*) if and only if:
  - |C.TABLES| is greater than x.
  - |C.TYPES| is greater than y.
  - C.TABLES[x] is (lim, rt).
  - the reference type rt matches the reference type (REF (NULL ?(())) FUNC).
  - $expanddt(C.TYPES[y]) is (FUNC (t_1* -> t_2*)).

Instr_ok/return
- the instr RETURN is valid with the instruction type (t_1* ++ t* ->_ [] ++ t_2*) if and only if:
  - C.RETURN is ?(t*).
  - the instruction type (t_1* ->_ [] ++ t_2*) is valid.

Instr_ok/return_call
- the instr (RETURN_CALL x) is valid with the instruction type (t_3* ++ t_1* ->_ [] ++ t_4*) if and only if:
  - |C.FUNCS| is greater than x.
  - $expanddt(C.FUNCS[x]) is (FUNC (t_1* -> t_2*)).
  - C.RETURN is ?(t'_2*).
  - the value type sequence t_2* matches the value type sequence t'_2*.
  - the instruction type (t_3* ->_ [] ++ t_4*) is valid.

Instr_ok/return_call_ref
- the instr (RETURN_CALL_REF $idx(x)) is valid with the instruction type (t_3* ++ t_1* ++ [(REF (NULL ?(())) $idx(x))] ->_ [] ++ t_4*) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (FUNC (t_1* -> t_2*)).
  - C.RETURN is ?(t'_2*).
  - the value type sequence t_2* matches the value type sequence t'_2*.
  - the instruction type (t_3* ->_ [] ++ t_4*) is valid.

Instr_ok/return_call_indirect
- the instr (RETURN_CALL_INDIRECT x $idx(y)) is valid with the instruction type (t_3* ++ t_1* ++ [I32] ->_ [] ++ t_4*) if and only if:
  - |C.TABLES| is greater than x.
  - |C.TYPES| is greater than y.
  - C.TABLES[x] is (lim, rt).
  - the reference type rt matches the reference type (REF (NULL ?(())) FUNC).
  - $expanddt(C.TYPES[y]) is (FUNC (t_1* -> t_2*)).
  - C.RETURN is ?(t'_2*).
  - the value type sequence t_2* matches the value type sequence t'_2*.
  - the instruction type (t_3* ->_ [] ++ t_4*) is valid.

Instr_ok/const
- the instr (nt.CONST c_nt) is valid with the instruction type ([] ->_ [] ++ [nt]).

Instr_ok/unop
- the instr (UNOP nt unop_nt) is valid with the instruction type ([nt] ->_ [] ++ [nt]).

Instr_ok/binop
- the instr (BINOP nt binop_nt) is valid with the instruction type ([nt, nt] ->_ [] ++ [nt]).

Instr_ok/testop
- the instr (TESTOP nt testop_nt) is valid with the instruction type ([nt] ->_ [] ++ [I32]).

Instr_ok/relop
- the instr (RELOP nt relop_nt) is valid with the instruction type ([nt, nt] ->_ [] ++ [I32]).

Instr_ok/cvtop
- the instr (CVTOP nt_1 nt_2 cvtop) is valid with the instruction type ([nt_2] ->_ [] ++ [nt_1]).

Instr_ok/ref.null
- the instr (REF.NULL ht) is valid with the instruction type ([] ->_ [] ++ [(REF (NULL ?(())) ht)]) if and only if:
  - the heap type ht is valid.

Instr_ok/ref.func
- the instr (REF.FUNC x) is valid with the instruction type ([] ->_ [] ++ [(REF (NULL ?()) dt)]) if and only if:
  - |C.FUNCS| is greater than x.
  - |C.REFS| is greater than 0.
  - C.FUNCS[x] is dt.
  - x is contained in C.REFS.

Instr_ok/ref.i31
- the instr REF.I31 is valid with the instruction type ([I32] ->_ [] ++ [(REF (NULL ?()) I31)]).

Instr_ok/ref.is_null
- the instr REF.IS_NULL is valid with the instruction type ([(REF (NULL ?(())) ht)] ->_ [] ++ [I32]) if and only if:
  - the heap type ht is valid.

Instr_ok/ref.as_non_null
- the instr REF.AS_NON_NULL is valid with the instruction type ([(REF (NULL ?(())) ht)] ->_ [] ++ [(REF (NULL ?()) ht)]) if and only if:
  - the heap type ht is valid.

Instr_ok/ref.eq
- the instr REF.EQ is valid with the instruction type ([(REF (NULL ?(())) EQ), (REF (NULL ?(())) EQ)] ->_ [] ++ [I32]).

Instr_ok/ref.test
- the instr (REF.TEST rt) is valid with the instruction type ([rt'] ->_ [] ++ [I32]) if and only if:
  - the reference type rt is valid.
  - the reference type rt' is valid.
  - the reference type rt matches the reference type rt'.

Instr_ok/ref.cast
- the instr (REF.CAST rt) is valid with the instruction type ([rt'] ->_ [] ++ [rt]) if and only if:
  - the reference type rt is valid.
  - the reference type rt' is valid.
  - the reference type rt matches the reference type rt'.

Instr_ok/i31.get
- the instr (I31.GET sx) is valid with the instruction type ([(REF (NULL ?(())) I31)] ->_ [] ++ [I32]).

Instr_ok/struct.new
- the instr (STRUCT.NEW x) is valid with the instruction type ($unpack(zt)* ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - |zt*| is |mut*|.
  - $expanddt(C.TYPES[x]) is (STRUCT (mut, zt)*).

Instr_ok/struct.new_default
- the instr (STRUCT.NEW_DEFAULT x) is valid with the instruction type ([] ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - |zt*| is |mut*|.
  - |zt*| is |val*|.
  - $expanddt(C.TYPES[x]) is (STRUCT (mut, zt)*).
  - For all val in val* and zt in zt*,
    - $default_($unpack(zt)) is ?(val).

Instr_ok/struct.get
- the instr (STRUCT.GET sx? x i) is valid with the instruction type ([(REF (NULL ?(())) $idx(x))] ->_ [] ++ [$unpack(zt)]) if and only if:
  - |C.TYPES| is greater than x.
  - |yt*| is greater than i.
  - $expanddt(C.TYPES[x]) is (STRUCT yt*).
  - yt*[i] is (mut, zt).
  - ((zt == $unpack(zt))) if and only if ((sx? == ?())).

Instr_ok/struct.set
- the instr (STRUCT.SET x i) is valid with the instruction type ([(REF (NULL ?(())) $idx(x)), $unpack(zt)] ->_ [] ++ []) if and only if:
  - |C.TYPES| is greater than x.
  - |yt*| is greater than i.
  - $expanddt(C.TYPES[x]) is (STRUCT yt*).
  - yt*[i] is ((MUT ?(())), zt).

Instr_ok/array.new
- the instr (ARRAY.NEW x) is valid with the instruction type ([$unpack(zt), I32] ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY (mut, zt)).

Instr_ok/array.new_default
- the instr (ARRAY.NEW_DEFAULT x) is valid with the instruction type ([I32] ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY (mut, zt)).
  - $default_($unpack(zt)) is ?(val).

Instr_ok/array.new_fixed
- the instr (ARRAY.NEW_FIXED x n) is valid with the instruction type ($unpack(zt)^n ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY (mut, zt)).

Instr_ok/array.new_elem
- the instr (ARRAY.NEW_ELEM x y) is valid with the instruction type ([I32, I32] ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - |C.ELEMS| is greater than y.
  - $expanddt(C.TYPES[x]) is (ARRAY (mut, rt)).
  - the reference type C.ELEMS[y] matches the reference type rt.

Instr_ok/array.new_data
- the instr (ARRAY.NEW_DATA x y) is valid with the instruction type ([I32, I32] ->_ [] ++ [(REF (NULL ?()) $idx(x))]) if and only if:
  - |C.TYPES| is greater than x.
  - |C.DATAS| is greater than y.
  - $expanddt(C.TYPES[x]) is (ARRAY (mut, zt)).
  - Yet: (($unpack(zt) = (numtype : numtype <: valtype)) \/ ($unpack(zt) = (vectype : vectype <: valtype)))
  - C.DATAS[y] is OK.

Instr_ok/array.get
- the instr (ARRAY.GET sx? x) is valid with the instruction type ([(REF (NULL ?(())) $idx(x)), I32] ->_ [] ++ [$unpack(zt)]) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY (mut, zt)).
  - ((zt == $unpack(zt))) if and only if ((sx? == ?())).

Instr_ok/array.set
- the instr (ARRAY.SET x) is valid with the instruction type ([(REF (NULL ?(())) $idx(x)), I32, $unpack(zt)] ->_ [] ++ []) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY ((MUT ?(())), zt)).

Instr_ok/array.len
- the instr ARRAY.LEN is valid with the instruction type ([(REF (NULL ?(())) ARRAY)] ->_ [] ++ [I32]) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY ((MUT ?(())), zt)).

Instr_ok/array.fill
- the instr (ARRAY.FILL x) is valid with the instruction type ([(REF (NULL ?(())) $idx(x)), I32, $unpack(zt), I32] ->_ [] ++ []) if and only if:
  - |C.TYPES| is greater than x.
  - $expanddt(C.TYPES[x]) is (ARRAY ((MUT ?(())), zt)).

Instr_ok/array.copy
- the instr (ARRAY.COPY x_1 x_2) is valid with the instruction type ([(REF (NULL ?(())) $idx(x_1)), I32, (REF (NULL ?(())) $idx(x_2)), I32, I32] ->_ [] ++ []) if and only if:
  - |C.TYPES| is greater than x_1.
  - |C.TYPES| is greater than x_2.
  - $expanddt(C.TYPES[x_1]) is (ARRAY ((MUT ?(())), zt_1)).
  - $expanddt(C.TYPES[x_2]) is (ARRAY (mut, zt_2)).
  - the storage type zt_2 matches the storage type zt_1.

Instr_ok/array.init_elem
- the instr (ARRAY.INIT_ELEM x y) is valid with the instruction type ([(REF (NULL ?(())) $idx(x)), I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.TYPES| is greater than x.
  - |C.ELEMS| is greater than y.
  - $expanddt(C.TYPES[x]) is (ARRAY ((MUT ?(())), zt)).
  - the element type C.ELEMS[y] matches the storage type zt.

Instr_ok/array.init_data
- the instr (ARRAY.INIT_DATA x y) is valid with the instruction type ([(REF (NULL ?(())) $idx(x)), I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.TYPES| is greater than x.
  - |C.DATAS| is greater than y.
  - $expanddt(C.TYPES[x]) is (ARRAY ((MUT ?(())), zt)).
  - Yet: (($unpack(zt) = (numtype : numtype <: valtype)) \/ ($unpack(zt) = (vectype : vectype <: valtype)))
  - C.DATAS[y] is OK.

Instr_ok/extern.convert_any
- the instr EXTERN.CONVERT_ANY is valid with the instruction type ([(REF nul ANY)] ->_ [] ++ [(REF nul EXTERN)]).

Instr_ok/any.convert_extern
- the instr ANY.CONVERT_EXTERN is valid with the instruction type ([(REF nul EXTERN)] ->_ [] ++ [(REF nul ANY)]).

Instr_ok/vconst
- the instr (V128.CONST c) is valid with the instruction type ([] ->_ [] ++ [V128]).

Instr_ok/vvunop
- the instr (VVUNOP V128 vvunop) is valid with the instruction type ([V128] ->_ [] ++ [V128]).

Instr_ok/vvbinop
- the instr (VVBINOP V128 vvbinop) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]).

Instr_ok/vvternop
- the instr (VVTERNOP V128 vvternop) is valid with the instruction type ([V128, V128, V128] ->_ [] ++ [V128]).

Instr_ok/vvtestop
- the instr (VVTESTOP V128 vvtestop) is valid with the instruction type ([V128] ->_ [] ++ [I32]).

Instr_ok/vunop
- the instr (VUNOP sh vunop) is valid with the instruction type ([V128] ->_ [] ++ [V128]).

Instr_ok/vbinop
- the instr (VBINOP sh vbinop) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]).

Instr_ok/vtestop
- the instr (VTESTOP sh vtestop) is valid with the instruction type ([V128] ->_ [] ++ [I32]).

Instr_ok/vrelop
- the instr (VRELOP sh vrelop) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]).

Instr_ok/vshiftop
- the instr (VSHIFTOP sh vshiftop) is valid with the instruction type ([V128, I32] ->_ [] ++ [V128]).

Instr_ok/vbitmask
- the instr (VBITMASK sh) is valid with the instruction type ([V128] ->_ [] ++ [I32]).

Instr_ok/vswizzle
- the instr (VSWIZZLE sh) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]).

Instr_ok/vshuffle
- the instr (VSHUFFLE sh i*) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]) if and only if:
  - For all i in i*,
    - i is less than (2 · $dim(sh)).

Instr_ok/vsplat
- the instr (VSPLAT sh) is valid with the instruction type ([$unpackshape(sh)] ->_ [] ++ [V128]).

Instr_ok/vextract_lane
- the instr (VEXTRACT_LANE sh sx? i) is valid with the instruction type ([V128] ->_ [] ++ [$unpackshape(sh)]) if and only if:
  - i is less than $dim(sh).

Instr_ok/vreplace_lane
- the instr (VREPLACE_LANE sh i) is valid with the instruction type ([V128, $unpackshape(sh)] ->_ [] ++ [V128]) if and only if:
  - i is less than $dim(sh).

Instr_ok/vextunop
- the instr (VEXTUNOP sh_1 sh_2 vextunop) is valid with the instruction type ([V128] ->_ [] ++ [V128]).

Instr_ok/vextbinop
- the instr (VEXTBINOP sh_1 sh_2 vextbinop) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]).

Instr_ok/vnarrow
- the instr (VNARROW sh_1 sh_2 sx) is valid with the instruction type ([V128, V128] ->_ [] ++ [V128]).

Instr_ok/vcvtop
- the instr (VCVTOP sh_1 sh_2 vcvtop half? zero?) is valid with the instruction type ([V128] ->_ [] ++ [V128]).

Instr_ok/local.get
- the instr (LOCAL.GET x) is valid with the instruction type ([] ->_ [] ++ [t]) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is (SET, t).

Instr_ok/local.set
- the instr (LOCAL.SET x) is valid with the instruction type ([t] ->_ [x] ++ []) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is (init, t).

Instr_ok/local.tee
- the instr (LOCAL.TEE x) is valid with the instruction type ([t] ->_ [x] ++ [t]) if and only if:
  - |C.LOCALS| is greater than x.
  - C.LOCALS[x] is (init, t).

Instr_ok/global.get
- the instr (GLOBAL.GET x) is valid with the instruction type ([] ->_ [] ++ [t]) if and only if:
  - |C.GLOBALS| is greater than x.
  - C.GLOBALS[x] is (mut, t).

Instr_ok/global.set
- the instr (GLOBAL.SET x) is valid with the instruction type ([t] ->_ [] ++ []) if and only if:
  - |C.GLOBALS| is greater than x.
  - C.GLOBALS[x] is ((MUT ?(())), t).

Instr_ok/table.get
- the instr (TABLE.GET x) is valid with the instruction type ([I32] ->_ [] ++ [rt]) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

Instr_ok/table.set
- the instr (TABLE.SET x) is valid with the instruction type ([I32, rt] ->_ [] ++ []) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

Instr_ok/table.size
- the instr (TABLE.SIZE x) is valid with the instruction type ([] ->_ [] ++ [I32]) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

Instr_ok/table.grow
- the instr (TABLE.GROW x) is valid with the instruction type ([rt, I32] ->_ [] ++ [I32]) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

Instr_ok/table.fill
- the instr (TABLE.FILL x) is valid with the instruction type ([I32, rt, I32] ->_ [] ++ []) if and only if:
  - |C.TABLES| is greater than x.
  - C.TABLES[x] is (lim, rt).

Instr_ok/table.copy
- the instr (TABLE.COPY x_1 x_2) is valid with the instruction type ([I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.TABLES| is greater than x_1.
  - |C.TABLES| is greater than x_2.
  - C.TABLES[x_1] is (lim_1, rt_1).
  - C.TABLES[x_2] is (lim_2, rt_2).
  - the reference type rt_2 matches the reference type rt_1.

Instr_ok/table.init
- the instr (TABLE.INIT x y) is valid with the instruction type ([I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.TABLES| is greater than x.
  - |C.ELEMS| is greater than y.
  - C.TABLES[x] is (lim, rt_1).
  - C.ELEMS[y] is rt_2.
  - the reference type rt_2 matches the reference type rt_1.

Instr_ok/elem.drop
- the instr (ELEM.DROP x) is valid with the instruction type ([] ->_ [] ++ []) if and only if:
  - |C.ELEMS| is greater than x.
  - C.ELEMS[x] is rt.

Instr_ok/memory.size
- the instr (MEMORY.SIZE x) is valid with the instruction type ([] ->_ [] ++ [I32]) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.

Instr_ok/memory.grow
- the instr (MEMORY.GROW x) is valid with the instruction type ([I32] ->_ [] ++ [I32]) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.

Instr_ok/memory.fill
- the instr (MEMORY.FILL x) is valid with the instruction type ([I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.

Instr_ok/memory.copy
- the instr (MEMORY.COPY x_1 x_2) is valid with the instruction type ([I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.MEMS| is greater than x_1.
  - |C.MEMS| is greater than x_2.
  - C.MEMS[x_1] is mt_1.
  - C.MEMS[x_2] is mt_2.

Instr_ok/memory.init
- the instr (MEMORY.INIT x y) is valid with the instruction type ([I32, I32, I32] ->_ [] ++ []) if and only if:
  - |C.MEMS| is greater than x.
  - |C.DATAS| is greater than y.
  - C.MEMS[x] is mt.
  - C.DATAS[y] is OK.

Instr_ok/data.drop
- the instr (DATA.DROP x) is valid with the instruction type ([] ->_ [] ++ []) if and only if:
  - |C.DATAS| is greater than x.
  - C.DATAS[x] is OK.

Instr_ok/load
- the instr (LOAD nt ?() x memarg) is valid with the instruction type ([I32] ->_ [] ++ [nt]) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(nt) / 8).

Instr_ok/store
- the instr (STORE nt ?() x memarg) is valid with the instruction type ([I32, nt] ->_ [] ++ []) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($size(nt) / 8).

Instr_ok/vload
- the instr (VLOAD V128 ?() x memarg) is valid with the instruction type ([I32] ->_ [] ++ [V128]) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($vsize(V128) / 8).

Instr_ok/vload_lane
- the instr (VLOAD_LANE V128 N x memarg i) is valid with the instruction type ([I32, V128] ->_ [] ++ [V128]) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to (N / 8).
  - i is less than (128 / N).

Instr_ok/vstore
- the instr (VSTORE V128 x memarg) is valid with the instruction type ([I32, V128] ->_ [] ++ []) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to ($vsize(V128) / 8).

Instr_ok/vstore_lane
- the instr (VSTORE_LANE V128 N x memarg i) is valid with the instruction type ([I32, V128] ->_ [] ++ []) if and only if:
  - |C.MEMS| is greater than x.
  - C.MEMS[x] is mt.
  - (2 ^ memarg.ALIGN) is less than or equal to (N / 8).
  - i is less than (128 / N).

Instrs_ok
- the instr sequence instr_u0* is valid with the instruction type instrtype_u4 if and only if:
  - Either:
    - instr_u0* is [].
    - instrtype_u4 is ([] ->_ [] ++ []).
  - Or:
    - instr_u0* is [instr_1] ++ instr_2*.
    - instrtype_u4 is (t_1* ->_ x_1* ++ x_2* ++ t_3*).
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
    - instrtype_u4 is it'.
    - the instr sequence instr* is valid with the instruction type it.
    - the instruction type it matches the instruction type it'.
    - the instruction type it' is valid.
  - Or:
    - instr_u0* is instr*.
    - instrtype_u4 is (t* ++ t_1* ->_ x* ++ t* ++ t_2*).
    - the instr sequence instr* is valid with the instruction type (t_1* ->_ x* ++ t_2*).
    - the value type sequence t* is valid.

Expr_ok
- the expression instr* is valid with the value type sequence t* if and only if:
  - the instr sequence instr* is valid with the instruction type ([] ->_ [] ++ t*).

Instr_const
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

Expr_const
- the expression instr* is constant if and only if:
  - For all instr in instr*,
    - the instr instr is constant.

Type_ok
- the type definition (TYPE rectype) is valid with the defined type sequence dt* if and only if:
  - |C.TYPES| is x.
  - dt* is $rolldt(x, rectype).
  - Under the context append(C.TYPES, dt*), the recursive type rectype is valid with the oktypeidx (OK x).

Local_ok
- the local (LOCAL t) is valid with the local type (init_u0, t) if and only if:
  - Either:
    - init_u0 is SET.
    - $default_(t) is different with ?().
  - Or:
    - init_u0 is UNSET.
    - $default_(t) is ?().

Func_ok
- the function (FUNC x local* expr) is valid with the defined type C.TYPES[x] if and only if:
  - |C.TYPES| is greater than x.
  - |local*| is |lct*|.
  - $expanddt(C.TYPES[x]) is (FUNC (t_1* -> t_2*)).
  - For all lct in lct* and local in local*,
    - the local local is valid with the local type lct.
  - Under the context append(append(append(C.LOCALS, (SET, t_1)* ++ lct*).LABELS, [t_2*]).RETURN, ?(t_2*)), the expression expr is valid with the value type sequence t_2*.

Global_ok
- the global (GLOBAL globaltype expr) is valid with the global type globaltype if and only if:
  - the global type gt is valid.
  - globaltype is (mut, t).
  - the expression expr is valid with the value type t.
  - the expression expr is constant.

Table_ok
- the table (TABLE tabletype expr) is valid with the table type tabletype if and only if:
  - the table type tt is valid.
  - tabletype is (lim, rt).
  - the expression expr is valid with the value type rt.
  - the expression expr is constant.

Mem_ok
- the memory (MEMORY memtype) is valid with the memory type memtype if and only if:
  - the memory type memtype is valid.

Elemmode_ok
- the elemmode elemmode_u0 is valid with the element type rt if and only if:
  - Either:
    - elemmode_u0 is (ACTIVE x expr).
    - |C.TABLES| is greater than x.
    - C.TABLES[x] is (lim, rt').
    - the reference type rt matches the reference type rt'.
    - the expression expr is valid with the value type I32.
    - the expression expr is constant.
  - Or:
    - elemmode_u0 is PASSIVE.
  - Or:
    - elemmode_u0 is DECLARE.

Elem_ok
- the table segment (ELEM elemtype expr* elemmode) is valid with the element type elemtype if and only if:
  - the reference type elemtype is valid.
  - For all expr in expr*,
    - the expression expr is valid with the value type elemtype.
    - the expression expr is constant.
  - the elemmode elemmode is valid with the element type elemtype.

Datamode_ok
- the datamode datamode_u0 is valid with the data type OK if and only if:
  - Either:
    - datamode_u0 is (ACTIVE x expr).
    - |C.MEMS| is greater than x.
    - C.MEMS[x] is mt.
    - the expression expr is valid with the value type I32.
    - the expression expr is constant.
  - Or:
    - datamode_u0 is PASSIVE.

Data_ok
- the memory segment (DATA b* datamode) is valid with the data type OK if and only if:
  - the datamode datamode is valid with the data type OK.

Start_ok
- the start function (START x) is valid if and only if:
  - |C.FUNCS| is greater than x.
  - $expanddt(C.FUNCS[x]) is (FUNC ([] -> [])).

Import_ok
- the import (IMPORT name_1 name_2 xt) is valid with the external type xt if and only if:
  - the external type xt is valid.

Externidx_ok
- the external index externidx_u0 is valid with the external type externtype_u1 if and only if:
  - Either:
    - externidx_u0 is (FUNC x).
    - externtype_u1 is (FUNC dt).
    - |C.FUNCS| is greater than x.
    - C.FUNCS[x] is dt.
  - Or:
    - externidx_u0 is (GLOBAL x).
    - externtype_u1 is (GLOBAL gt).
    - |C.GLOBALS| is greater than x.
    - C.GLOBALS[x] is gt.
  - Or:
    - externidx_u0 is (TABLE x).
    - externtype_u1 is (TABLE tt).
    - |C.TABLES| is greater than x.
    - C.TABLES[x] is tt.
  - Or:
    - externidx_u0 is (MEM x).
    - externtype_u1 is (MEM mt).
    - |C.MEMS| is greater than x.
    - C.MEMS[x] is mt.

Export_ok
- the export (EXPORT name externidx) is valid with the name name and the external type xt if and only if:
  - the external index externidx is valid with the external type xt.

Globals_ok
- the global sequence global_u0* is valid with the global type sequence globaltype_u1* if and only if:
  - Either:
    - global_u0* is [].
    - globaltype_u1* is [].
  - Or:
    - global_u0* is [global_1] ++ global*.
    - globaltype_u1* is [gt_1] ++ gt*.
    - the global global is valid with the global type gt_1.
    - Under the context append(C.GLOBALS, [gt_1]), the global sequence global* is valid with the global type sequence gt*.

Types_ok
- the type definition sequence type_u0* is valid with the defined type sequence deftype_u1* if and only if:
  - Either:
    - type_u0* is [].
    - deftype_u1* is [].
  - Or:
    - type_u0* is [type_1] ++ type*.
    - deftype_u1* is dt_1* ++ dt*.
    - the type definition type_1 is valid with the defined type sequence dt_1*.
    - Under the context append(C.TYPES, dt_1*), the type definition sequence type* is valid with the defined type sequence dt*.

Module_ok
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
  - If start != None,
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

NotationTypingInstrScheme
- the instr sequence [instr_u0] is valid with the function type (valtype_u1* -> valtype_u3*) if and only if:
  - Either:
    - instr_u0 is (BINOP I32 ADD).
    - valtype_u1* is [I32, I32].
    - valtype_u3* is [I32].
  - Or:
    - instr_u0 is (GLOBAL.GET x).
    - valtype_u1* is [].
    - valtype_u3* is [t].
    - |C.GLOBALS| is greater than x.
    - C.GLOBALS[x] is (mut, t).
  - Or:
    - instr_u0 is (BLOCK blocktype instr*).
    - valtype_u1* is t_1*.
    - valtype_u3* is t_2*.
    - the block type blocktype is valid with the instruction type (t_1* ->_ [] ++ t_2*).
    - Under the context prepend(C.LABELS, [t_2*]), the instr sequence instr* is valid with the function type (t_1* -> t_2*).

Ki {
 Return 1024
}

min n_u0 n_u1 {
 If ((n_u0 == 0)) {
   Return 0
 }
 If ((n_u1 == 0)) {
   Return 0
 }
 Assert((n_u0 ≥ 1))
 Let i = (n_u0 - 1)
 Assert((n_u1 ≥ 1))
 Let j = (n_u1 - 1)
 Return $min(i, j)
}

sum n_u0* {
 If ((n_u0* == [])) {
   Return 0
 }
 Let [n] ++ n'* = n_u0*
 Return (n + $sum(n'*))
}

opt_ X X_u0* {
 If ((X_u0* == [])) {
   Return ?()
 }
 Assert((|X_u0*| == 1))
 Let [w] = X_u0*
 Return ?(w)
}

list_ X X_u0? {
 If (!(X_u0? != None)) {
   Return []
 }
 Let ?(w) = X_u0?
 Return [w]
}

concat_ X X_u0* {
 If ((X_u0* == [])) {
   Return []
 }
 Let [w*] ++ w'** = X_u0*
 Return w* ++ $concat_(X, w'**)
}

concatn_ X X_u0* n {
 If ((X_u0* == [])) {
   Return []
 }
 Let [w^n] ++ w'^n* = X_u0*
 Return w^n ++ $concatn_(X, w'^n*, n)
}

disjoint_ X X_u0* {
 If ((X_u0* == [])) {
   Return true
 }
 Let [w] ++ w'* = X_u0*
 Return (!(w <- w'*) && $disjoint_(X, w'*))
}

setminus1_ X w X_u0* {
 If ((X_u0* == [])) {
   Return [w]
 }
 Let [w_1] ++ w'* = X_u0*
 If ((w == w_1)) {
   Return []
 }
 Let [w_1] ++ w'* = X_u0*
 Return $setminus1_(X, w, w'*)
}

setminus_ X X_u0* w* {
 If ((X_u0* == [])) {
   Return []
 }
 Let [w_1] ++ w'* = X_u0*
 Return $setminus1_(X, w_1, w*) ++ $setminus_(X, w'*, w*)
}

setproduct2_ X w_1 X_u0* {
 If ((X_u0* == [])) {
   Return []
 }
 Let [w'*] ++ w** = X_u0*
 Return [[w_1] ++ w'*] ++ $setproduct2_(X, w_1, w**)
}

setproduct1_ X X_u0* w** {
 If ((X_u0* == [])) {
   Return []
 }
 Let [w_1] ++ w'* = X_u0*
 Return $setproduct2_(X, w_1, w**) ++ $setproduct1_(X, w'*, w**)
}

setproduct_ X X_u0* {
 If ((X_u0* == [])) {
   Return [[]]
 }
 Let [w_1*] ++ w** = X_u0*
 Return $setproduct1_(X, w_1*, $setproduct_(X, w**))
}

signif N_u0 {
 If ((N_u0 == 32)) {
   Return 23
 }
 Assert((N_u0 == 64))
 Return 52
}

expon N_u0 {
 If ((N_u0 == 32)) {
   Return 8
 }
 Assert((N_u0 == 64))
 Return 11
}

M N {
 Return $signif(N)
}

E N {
 Return $expon(N)
}

fzero N {
 Return (POS (SUBNORM 0))
}

fone N {
 Return (POS (NORM 1 0))
}

canon_ N {
 Return (2 ^ ($signif(N) - 1))
}

cont b {
 Assert((128 < b))
 Assert((b < 192))
 Return (b - 128)
}

ANYREF {
 Return (REF (NULL ?(())) ANY)
}

EQREF {
 Return (REF (NULL ?(())) EQ)
}

I31REF {
 Return (REF (NULL ?(())) I31)
}

STRUCTREF {
 Return (REF (NULL ?(())) STRUCT)
}

ARRAYREF {
 Return (REF (NULL ?(())) ARRAY)
}

FUNCREF {
 Return (REF (NULL ?(())) FUNC)
}

EXTERNREF {
 Return (REF (NULL ?(())) EXTERN)
}

NULLREF {
 Return (REF (NULL ?(())) NONE)
}

NULLFUNCREF {
 Return (REF (NULL ?(())) NOFUNC)
}

NULLEXTERNREF {
 Return (REF (NULL ?(())) NOEXTERN)
}

size numtype_u0 {
 If ((numtype_u0 == I32)) {
   Return 32
 }
 If ((numtype_u0 == I64)) {
   Return 64
 }
 If ((numtype_u0 == F32)) {
   Return 32
 }
 Assert((numtype_u0 == F64))
 Return 64
}

vsize V128 {
 Return 128
}

psize packtype_u0 {
 If ((packtype_u0 == I8)) {
   Return 8
 }
 Assert((packtype_u0 == I16))
 Return 16
}

lsize lanetype_u0 {
 If (type(lanetype_u0) == numtype) {
   Let numtype = lanetype_u0
   Return $size(numtype)
 }
 Assert(type(lanetype_u0) == packtype)
 Let packtype = lanetype_u0
 Return $psize(packtype)
}

zsize storagetype_u0 {
 If (type(storagetype_u0) == numtype) {
   Let numtype = storagetype_u0
   Return $size(numtype)
 }
 If (type(storagetype_u0) == vectype) {
   Let vectype = storagetype_u0
   Return $vsize(vectype)
 }
 Assert(type(storagetype_u0) == packtype)
 Let packtype = storagetype_u0
 Return $psize(packtype)
}

lanetype (Lnn X N) {
 Return Lnn
}

sizenn nt {
 Return $size(nt)
}

sizenn1 nt {
 Return $size(nt)
}

sizenn2 nt {
 Return $size(nt)
}

psizenn pt {
 Return $psize(pt)
}

lsizenn lt {
 Return $lsize(lt)
}

lsizenn1 lt {
 Return $lsize(lt)
}

lsizenn2 lt {
 Return $lsize(lt)
}

zero numtype_u0 {
 If (type(numtype_u0) == Inn) {
   Return 0
 }
 Assert(type(numtype_u0) == Fnn)
 Let Fnn = numtype_u0
 Return $fzero($size(Fnn))
}

dim (Lnn X N) {
 Return N
}

shsize (Lnn X N) {
 Return ($lsize(Lnn) · N)
}

IN N_u0 {
 If ((N_u0 == 32)) {
   Return I32
 }
 Assert((N_u0 == 64))
 Return I64
}

FN N_u0 {
 If ((N_u0 == 32)) {
   Return F32
 }
 Assert((N_u0 == 64))
 Return F64
}

JN N_u0 {
 If ((N_u0 == 8)) {
   Return I8
 }
 If ((N_u0 == 16)) {
   Return I16
 }
 If ((N_u0 == 32)) {
   Return I32
 }
 Assert((N_u0 == 64))
 Return I64
}

lunpack lanetype_u0 {
 If (type(lanetype_u0) == numtype) {
   Let numtype = lanetype_u0
   Return numtype
 }
 Assert(type(lanetype_u0) == packtype)
 Return I32
}

unpack storagetype_u0 {
 If (type(storagetype_u0) == valtype) {
   Let valtype = storagetype_u0
   Return valtype
 }
 Assert(type(storagetype_u0) == packtype)
 Return I32
}

nunpack storagetype_u0 {
 If (type(storagetype_u0) == numtype) {
   Let numtype = storagetype_u0
   Return numtype
 }
 If (type(storagetype_u0) == packtype) {
   Return I32
 }
}

vunpack vectype {
 Return vectype
}

cunpack storagetype_u0 {
 If (type(storagetype_u0) == consttype) {
   Let consttype = storagetype_u0
   Return consttype
 }
 If (type(storagetype_u0) == packtype) {
   Return I32
 }
 If (type(storagetype_u0) == lanetype) {
   Let lanetype = storagetype_u0
   Return $lunpack(lanetype)
 }
}

sx storagetype_u0 {
 If (type(storagetype_u0) == consttype) {
   Return ?()
 }
 Assert(type(storagetype_u0) == packtype)
 Return ?(S)
}

const consttype_u0 c {
 If (type(consttype_u0) == numtype) {
   Let numtype = consttype_u0
   Return (numtype.CONST c)
 }
 Assert(type(consttype_u0) == vectype)
 Let vectype = consttype_u0
 Return (vectype.CONST c)
}

unpackshape (Lnn X N) {
 Return $lunpack(Lnn)
}

diffrt (REF nul1 ht_1) (REF (NULL _u0?) ht_2) {
 If ((_u0? == ?(()))) {
   Return (REF (NULL ?()) ht_1)
 }
 Assert(!(_u0? != None))
 Return (REF nul1 ht_1)
}

idx x {
 Return (_IDX x)
}

free_opt free_u0? {
 If (!(free_u0? != None)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 Let ?(free) = free_u0?
 Return free
}

free_list free_u0* {
 If ((free_u0* == [])) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 Return YetE (free ++ $free_list(free'*{free' : free}))
}

free_typeidx typeidx {
 Return { TYPES: [typeidx]; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_funcidx funcidx {
 Return { TYPES: []; FUNCS: [funcidx]; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_globalidx globalidx {
 Return { TYPES: []; FUNCS: []; GLOBALS: [globalidx]; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_tableidx tableidx {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: [tableidx]; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_memidx memidx {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: [memidx]; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_elemidx elemidx {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: [elemidx]; DATAS: []; LOCALS: []; LABELS: []; }
}

free_dataidx dataidx {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: [dataidx]; LOCALS: []; LABELS: []; }
}

free_localidx localidx {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: [localidx]; LABELS: []; }
}

free_labelidx labelidx {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: [labelidx]; }
}

free_externidx externidx_u0 {
 If (case(externidx_u0) == FUNC) {
   Let (FUNC funcidx) = externidx_u0
   Return $free_funcidx(funcidx)
 }
 If (case(externidx_u0) == GLOBAL) {
   Let (GLOBAL globalidx) = externidx_u0
   Return $free_globalidx(globalidx)
 }
 If (case(externidx_u0) == TABLE) {
   Let (TABLE tableidx) = externidx_u0
   Return $free_tableidx(tableidx)
 }
 Assert(case(externidx_u0) == MEM)
 Let (MEM memidx) = externidx_u0
 Return $free_memidx(memidx)
}

free_numtype numtype {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_packtype packtype {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_lanetype lanetype_u0 {
 If (type(lanetype_u0) == numtype) {
   Let numtype = lanetype_u0
   Return $free_numtype(numtype)
 }
 Assert(type(lanetype_u0) == packtype)
 Let packtype = lanetype_u0
 Return $free_packtype(packtype)
}

free_vectype vectype {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_consttype consttype_u0 {
 If (type(consttype_u0) == numtype) {
   Let numtype = consttype_u0
   Return $free_numtype(numtype)
 }
 Assert(type(consttype_u0) == vectype)
 Let vectype = consttype_u0
 Return $free_vectype(vectype)
}

free_absheaptype absheaptype {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_rectype (REC subtype*) {
 Return $free_list($free_subtype(subtype)*)
}

free_deftype (DEF rectype n) {
 Return $free_rectype(rectype)
}

free_typeuse typeuse_u0 {
 If (case(typeuse_u0) == _IDX) {
   Let (_IDX typeidx) = typeuse_u0
   Return $free_typeidx(typeidx)
 }
 If (case(typeuse_u0) == REC) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 Assert(type(typeuse_u0) == deftype)
 Let deftype = typeuse_u0
 Return $free_deftype(deftype)
}

free_heaptype heaptype_u0 {
 If (type(heaptype_u0) == absheaptype) {
   Let absheaptype = heaptype_u0
   Return $free_absheaptype(absheaptype)
 }
 Assert(type(heaptype_u0) == typeuse)
 Let typeuse = heaptype_u0
 Return $free_typeuse(typeuse)
}

free_reftype (REF nul heaptype) {
 Return $free_heaptype(heaptype)
}

free_valtype valtype_u0 {
 If (type(valtype_u0) == numtype) {
   Let numtype = valtype_u0
   Return $free_numtype(numtype)
 }
 If (type(valtype_u0) == vectype) {
   Let vectype = valtype_u0
   Return $free_vectype(vectype)
 }
 If (type(valtype_u0) == reftype) {
   Let reftype = valtype_u0
   Return $free_reftype(reftype)
 }
 Assert((valtype_u0 == BOT))
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_resulttype valtype* {
 Return $free_list($free_valtype(valtype)*)
}

free_storagetype storagetype_u0 {
 If (type(storagetype_u0) == valtype) {
   Let valtype = storagetype_u0
   Return $free_valtype(valtype)
 }
 Assert(type(storagetype_u0) == packtype)
 Let packtype = storagetype_u0
 Return $free_packtype(packtype)
}

free_fieldtype (mut, storagetype) {
 Return $free_storagetype(storagetype)
}

free_functype (resulttype_1 -> resulttype_2) {
 Return YetE ($free_resulttype(resulttype_1) ++ $free_resulttype(resulttype_2))
}

free_structtype fieldtype* {
 Return $free_list($free_fieldtype(fieldtype)*)
}

free_arraytype fieldtype {
 Return $free_fieldtype(fieldtype)
}

free_comptype comptype_u0 {
 If (case(comptype_u0) == STRUCT) {
   Let (STRUCT structtype) = comptype_u0
   Return $free_structtype(structtype)
 }
 If (case(comptype_u0) == ARRAY) {
   Let (ARRAY arraytype) = comptype_u0
   Return $free_arraytype(arraytype)
 }
 Assert(case(comptype_u0) == FUNC)
 Let (FUNC functype) = comptype_u0
 Return $free_functype(functype)
}

free_subtype (SUB fin typeuse* comptype) {
 Return YetE ($free_list($free_typeuse(typeuse)*{typeuse : typeuse}) ++ $free_comptype(comptype))
}

free_globaltype (mut, valtype) {
 Return $free_valtype(valtype)
}

free_tabletype (limits, reftype) {
 Return $free_reftype(reftype)
}

free_memtype (PAGE limits) {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_elemtype reftype {
 Return $free_reftype(reftype)
}

free_datatype OK {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_externtype externtype_u0 {
 If (case(externtype_u0) == FUNC) {
   Let (FUNC typeuse) = externtype_u0
   Return $free_typeuse(typeuse)
 }
 If (case(externtype_u0) == GLOBAL) {
   Let (GLOBAL globaltype) = externtype_u0
   Return $free_globaltype(globaltype)
 }
 If (case(externtype_u0) == TABLE) {
   Let (TABLE tabletype) = externtype_u0
   Return $free_tabletype(tabletype)
 }
 Assert(case(externtype_u0) == MEM)
 Let (MEM memtype) = externtype_u0
 Return $free_memtype(memtype)
}

free_moduletype (externtype_1* -> externtype_2*) {
 Return YetE ($free_list($free_externtype(externtype_1)*{externtype_1 : externtype}) ++ $free_list($free_externtype(externtype_2)*{externtype_2 : externtype}))
}

free_blocktype blocktype_u0 {
 If (case(blocktype_u0) == _RESULT) {
   Let (_RESULT valtype?) = blocktype_u0
   Return $free_opt($free_valtype(valtype)?)
 }
 Assert(case(blocktype_u0) == _IDX)
 Let (_IDX funcidx) = blocktype_u0
 Return $free_funcidx(funcidx)
}

free_shape (lanetype X dim) {
 Return $free_lanetype(lanetype)
}

shift_labelidxs labelidx_u0* {
 If ((labelidx_u0* == [])) {
   Return []
 }
 Let [n_0] ++ labelidx'* = labelidx_u0*
 If ((n_0 == 0)) {
   Return $shift_labelidxs(labelidx'*)
 }
 Let [labelidx] ++ labelidx'* = labelidx_u0*
 Return [(labelidx - 1)] ++ $shift_labelidxs(labelidx'*)
}

free_block instr* {
 Let free = $free_list($free_instr(instr)*)
 Return update(free.LABELS, $shift_labelidxs(free.LABELS))
}

free_instr instr_u0 {
 If ((instr_u0 == NOP)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If ((instr_u0 == UNREACHABLE)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If ((instr_u0 == DROP)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == SELECT) {
   Let (SELECT valtype*?) = instr_u0
   Return $free_opt($free_list($free_valtype(valtype)*)?)
 }
 If (case(instr_u0) == BLOCK) {
   Return YetE ($free_blocktype(blocktype) ++ $free_block(instr*{instr : instr}))
 }
 If (case(instr_u0) == LOOP) {
   Return YetE ($free_blocktype(blocktype) ++ $free_block(instr*{instr : instr}))
 }
 If (case(instr_u0) == IF) {
   Return YetE ($free_blocktype(blocktype) ++ $free_block(instr_1*{instr_1 : instr}) ++ $free_block(instr_2*{instr_2 : instr}))
 }
 If (case(instr_u0) == BR) {
   Let (BR labelidx) = instr_u0
   Return $free_labelidx(labelidx)
 }
 If (case(instr_u0) == BR_IF) {
   Let (BR_IF labelidx) = instr_u0
   Return $free_labelidx(labelidx)
 }
 If (case(instr_u0) == BR_TABLE) {
   Return YetE ($free_list($free_labelidx(labelidx)*{}) ++ $free_labelidx(labelidx))
 }
 If (case(instr_u0) == BR_ON_NULL) {
   Let (BR_ON_NULL labelidx) = instr_u0
   Return $free_labelidx(labelidx)
 }
 If (case(instr_u0) == BR_ON_NON_NULL) {
   Let (BR_ON_NON_NULL labelidx) = instr_u0
   Return $free_labelidx(labelidx)
 }
 If (case(instr_u0) == BR_ON_CAST) {
   Return YetE ($free_labelidx(labelidx) ++ $free_reftype(reftype_1) ++ $free_reftype(reftype_2))
 }
 If (case(instr_u0) == BR_ON_CAST_FAIL) {
   Return YetE ($free_labelidx(labelidx) ++ $free_reftype(reftype_1) ++ $free_reftype(reftype_2))
 }
 If (case(instr_u0) == CALL) {
   Let (CALL funcidx) = instr_u0
   Return $free_funcidx(funcidx)
 }
 If (case(instr_u0) == CALL_REF) {
   Let (CALL_REF typeuse) = instr_u0
   Return $free_typeuse(typeuse)
 }
 If (case(instr_u0) == CALL_INDIRECT) {
   Return YetE ($free_tableidx(tableidx) ++ $free_typeuse(typeuse))
 }
 If ((instr_u0 == RETURN)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == RETURN_CALL) {
   Let (RETURN_CALL funcidx) = instr_u0
   Return $free_funcidx(funcidx)
 }
 If (case(instr_u0) == RETURN_CALL_REF) {
   Let (RETURN_CALL_REF typeuse) = instr_u0
   Return $free_typeuse(typeuse)
 }
 If (case(instr_u0) == RETURN_CALL_INDIRECT) {
   Return YetE ($free_tableidx(tableidx) ++ $free_typeuse(typeuse))
 }
 If (case(instr_u0) == CONST) {
   Let (numtype.CONST numlit) = instr_u0
   Return $free_numtype(numtype)
 }
 If (case(instr_u0) == UNOP) {
   Let (UNOP numtype unop) = instr_u0
   Return $free_numtype(numtype)
 }
 If (case(instr_u0) == BINOP) {
   Let (BINOP numtype binop) = instr_u0
   Return $free_numtype(numtype)
 }
 If (case(instr_u0) == TESTOP) {
   Let (TESTOP numtype testop) = instr_u0
   Return $free_numtype(numtype)
 }
 If (case(instr_u0) == RELOP) {
   Let (RELOP numtype relop) = instr_u0
   Return $free_numtype(numtype)
 }
 If (case(instr_u0) == CVTOP) {
   Return YetE ($free_numtype(numtype_1) ++ $free_numtype(numtype_2))
 }
 If (case(instr_u0) == VCONST) {
   Let (vectype.CONST veclit) = instr_u0
   Return $free_vectype(vectype)
 }
 If (case(instr_u0) == VVUNOP) {
   Let (VVUNOP vectype vvunop) = instr_u0
   Return $free_vectype(vectype)
 }
 If (case(instr_u0) == VVBINOP) {
   Let (VVBINOP vectype vvbinop) = instr_u0
   Return $free_vectype(vectype)
 }
 If (case(instr_u0) == VVTERNOP) {
   Let (VVTERNOP vectype vvternop) = instr_u0
   Return $free_vectype(vectype)
 }
 If (case(instr_u0) == VVTESTOP) {
   Let (VVTESTOP vectype vvtestop) = instr_u0
   Return $free_vectype(vectype)
 }
 If (case(instr_u0) == VUNOP) {
   Let (VUNOP shape vunop) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == VBINOP) {
   Let (VBINOP shape vbinop) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == VTESTOP) {
   Let (VTESTOP shape vtestop) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == VRELOP) {
   Let (VRELOP shape vrelop) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == VSHIFTOP) {
   Let (VSHIFTOP ishape vshiftop) = instr_u0
   Return $free_shape(ishape)
 }
 If (case(instr_u0) == VBITMASK) {
   Let (VBITMASK ishape) = instr_u0
   Return $free_shape(ishape)
 }
 If (case(instr_u0) == VSWIZZLE) {
   Let (VSWIZZLE ishape) = instr_u0
   Return $free_shape(ishape)
 }
 If (case(instr_u0) == VSHUFFLE) {
   Let (VSHUFFLE ishape laneidx*) = instr_u0
   Return $free_shape(ishape)
 }
 If (case(instr_u0) == VEXTUNOP) {
   Return YetE ($free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape)))
 }
 If (case(instr_u0) == VEXTBINOP) {
   Return YetE ($free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape)))
 }
 If (case(instr_u0) == VNARROW) {
   Return YetE ($free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape)))
 }
 If (case(instr_u0) == VCVTOP) {
   Return YetE ($free_shape(shape_1) ++ $free_shape(shape_2))
 }
 If (case(instr_u0) == VSPLAT) {
   Let (VSPLAT shape) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == VEXTRACT_LANE) {
   Let (VEXTRACT_LANE shape sx? laneidx) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == VREPLACE_LANE) {
   Let (VREPLACE_LANE shape laneidx) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == REF.NULL) {
   Let (REF.NULL heaptype) = instr_u0
   Return $free_heaptype(heaptype)
 }
 If ((instr_u0 == REF.IS_NULL)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If ((instr_u0 == REF.AS_NON_NULL)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If ((instr_u0 == REF.EQ)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == REF.TEST) {
   Let (REF.TEST reftype) = instr_u0
   Return $free_reftype(reftype)
 }
 If (case(instr_u0) == REF.CAST) {
   Let (REF.CAST reftype) = instr_u0
   Return $free_reftype(reftype)
 }
 If (case(instr_u0) == REF.FUNC) {
   Let (REF.FUNC funcidx) = instr_u0
   Return $free_funcidx(funcidx)
 }
 If ((instr_u0 == REF.I31)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == I31.GET) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == STRUCT.NEW) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == STRUCT.NEW_DEFAULT) {
   Let (STRUCT.NEW_DEFAULT typeidx) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == STRUCT.GET) {
   Let (STRUCT.GET sx? typeidx u32) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == STRUCT.SET) {
   Let (STRUCT.SET typeidx u32) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == ARRAY.NEW) {
   Let (ARRAY.NEW typeidx) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == ARRAY.NEW_DEFAULT) {
   Let (ARRAY.NEW_DEFAULT typeidx) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == ARRAY.NEW_FIXED) {
   Let (ARRAY.NEW_FIXED typeidx u32) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == ARRAY.NEW_DATA) {
   Return YetE ($free_typeidx(typeidx) ++ $free_dataidx(dataidx))
 }
 If (case(instr_u0) == ARRAY.NEW_ELEM) {
   Return YetE ($free_typeidx(typeidx) ++ $free_elemidx(elemidx))
 }
 If (case(instr_u0) == ARRAY.GET) {
   Let (ARRAY.GET sx? typeidx) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == ARRAY.SET) {
   Let (ARRAY.SET typeidx) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If ((instr_u0 == ARRAY.LEN)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == ARRAY.FILL) {
   Let (ARRAY.FILL typeidx) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == ARRAY.COPY) {
   Return YetE ($free_typeidx(typeidx_1) ++ $free_typeidx(typeidx_2))
 }
 If (case(instr_u0) == ARRAY.INIT_DATA) {
   Return YetE ($free_typeidx(typeidx) ++ $free_dataidx(dataidx))
 }
 If (case(instr_u0) == ARRAY.INIT_ELEM) {
   Return YetE ($free_typeidx(typeidx) ++ $free_elemidx(elemidx))
 }
 If ((instr_u0 == EXTERN.CONVERT_ANY)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If ((instr_u0 == ANY.CONVERT_EXTERN)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == LOCAL.GET) {
   Let (LOCAL.GET localidx) = instr_u0
   Return $free_localidx(localidx)
 }
 If (case(instr_u0) == LOCAL.SET) {
   Let (LOCAL.SET localidx) = instr_u0
   Return $free_localidx(localidx)
 }
 If (case(instr_u0) == LOCAL.TEE) {
   Let (LOCAL.TEE localidx) = instr_u0
   Return $free_localidx(localidx)
 }
 If (case(instr_u0) == GLOBAL.GET) {
   Let (GLOBAL.GET globalidx) = instr_u0
   Return $free_globalidx(globalidx)
 }
 If (case(instr_u0) == GLOBAL.SET) {
   Let (GLOBAL.SET globalidx) = instr_u0
   Return $free_globalidx(globalidx)
 }
 If (case(instr_u0) == TABLE.GET) {
   Let (TABLE.GET tableidx) = instr_u0
   Return $free_tableidx(tableidx)
 }
 If (case(instr_u0) == TABLE.SET) {
   Let (TABLE.SET tableidx) = instr_u0
   Return $free_tableidx(tableidx)
 }
 If (case(instr_u0) == TABLE.SIZE) {
   Let (TABLE.SIZE tableidx) = instr_u0
   Return $free_tableidx(tableidx)
 }
 If (case(instr_u0) == TABLE.GROW) {
   Let (TABLE.GROW tableidx) = instr_u0
   Return $free_tableidx(tableidx)
 }
 If (case(instr_u0) == TABLE.FILL) {
   Let (TABLE.FILL tableidx) = instr_u0
   Return $free_tableidx(tableidx)
 }
 If (case(instr_u0) == TABLE.COPY) {
   Return YetE ($free_tableidx(tableidx_1) ++ $free_tableidx(tableidx_2))
 }
 If (case(instr_u0) == TABLE.INIT) {
   Return YetE ($free_tableidx(tableidx) ++ $free_elemidx(elemidx))
 }
 If (case(instr_u0) == ELEM.DROP) {
   Let (ELEM.DROP elemidx) = instr_u0
   Return $free_elemidx(elemidx)
 }
 If (case(instr_u0) == LOAD) {
   Let (LOAD numtype loadop__0 memidx memarg) = instr_u0
   If (loadop__0 != None) {
     Return YetE ($free_numtype(numtype) ++ $free_memidx(memidx))
   }
 }
 If (case(instr_u0) == STORE) {
   Return YetE ($free_numtype(numtype) ++ $free_memidx(memidx))
 }
 If (case(instr_u0) == VLOAD) {
   Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx))
 }
 If (case(instr_u0) == VLOAD_LANE) {
   Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx))
 }
 If (case(instr_u0) == VSTORE) {
   Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx))
 }
 If (case(instr_u0) == VSTORE_LANE) {
   Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx))
 }
 If (case(instr_u0) == MEMORY.SIZE) {
   Let (MEMORY.SIZE memidx) = instr_u0
   Return $free_memidx(memidx)
 }
 If (case(instr_u0) == MEMORY.GROW) {
   Let (MEMORY.GROW memidx) = instr_u0
   Return $free_memidx(memidx)
 }
 If (case(instr_u0) == MEMORY.FILL) {
   Let (MEMORY.FILL memidx) = instr_u0
   Return $free_memidx(memidx)
 }
 If (case(instr_u0) == MEMORY.COPY) {
   Return YetE ($free_memidx(memidx_1) ++ $free_memidx(memidx_2))
 }
 If (case(instr_u0) == MEMORY.INIT) {
   Return YetE ($free_memidx(memidx) ++ $free_dataidx(dataidx))
 }
 Assert(case(instr_u0) == DATA.DROP)
 Let (DATA.DROP dataidx) = instr_u0
 Return $free_dataidx(dataidx)
}

free_expr instr* {
 Return $free_list($free_instr(instr)*)
}

free_type (TYPE rectype) {
 Return $free_rectype(rectype)
}

free_local (LOCAL t) {
 Return $free_valtype(t)
}

free_func (FUNC typeidx local* expr) {
 Return YetE ($free_typeidx(typeidx) ++ $free_list($free_local(local)*{local : local}) ++ $free_block(expr)[LOCALS_free = []])
}

free_global (GLOBAL globaltype expr) {
 Return YetE ($free_globaltype(globaltype) ++ $free_expr(expr))
}

free_table (TABLE tabletype expr) {
 Return YetE ($free_tabletype(tabletype) ++ $free_expr(expr))
}

free_mem (MEMORY memtype) {
 Return $free_memtype(memtype)
}

free_elemmode elemmode_u0 {
 If (case(elemmode_u0) == ACTIVE) {
   Return YetE ($free_tableidx(tableidx) ++ $free_expr(expr))
 }
 If ((elemmode_u0 == PASSIVE)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 Assert((elemmode_u0 == DECLARE))
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_datamode datamode_u0 {
 If (case(datamode_u0) == ACTIVE) {
   Return YetE ($free_memidx(memidx) ++ $free_expr(expr))
 }
 Assert((datamode_u0 == PASSIVE))
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_elem (ELEM reftype expr* elemmode) {
 Return YetE ($free_reftype(reftype) ++ $free_list($free_expr(expr)*{expr : expr}) ++ $free_elemmode(elemmode))
}

free_data (DATA byte* datamode) {
 Return $free_datamode(datamode)
}

free_start (START funcidx) {
 Return $free_funcidx(funcidx)
}

free_export (EXPORT name externidx) {
 Return $free_externidx(externidx)
}

free_import (IMPORT name_1 name_2 externtype) {
 Return $free_externtype(externtype)
}

free_module (MODULE type* import* func* global* table* mem* elem* data* start? export*) {
 Return YetE ($free_list($free_type(type)*{type : type}) ++ $free_list($free_import(import)*{import : import}) ++ $free_list($free_func(func)*{func : func}) ++ $free_list($free_global(global)*{global : global}) ++ $free_list($free_table(table)*{table : table}) ++ $free_list($free_mem(mem)*{mem : mem}) ++ $free_list($free_elem(elem)*{elem : elem}) ++ $free_list($free_data(data)*{data : data}) ++ $free_opt($free_start(start)?{start : start}) ++ $free_list($free_export(export)*{export : export}))
}

funcidx_module module {
 Return $free_module(module).FUNCS
}

dataidx_funcs func* {
 Return $free_list($free_func(func)*).DATAS
}

subst_typevar tv typevar_u0* typeuse_u1* {
 If (((typevar_u0* == []) && (typeuse_u1* == []))) {
   Return tv
 }
 Assert((|typeuse_u1*| ≥ 1))
 Let [tu_1] ++ tu'* = typeuse_u1*
 If ((|typevar_u0*| ≥ 1)) {
   Let [tv_1] ++ tv'* = typevar_u0*
   If ((tv == tv_1)) {
     Return tu_1
   }
 }
 Let [tu_1] ++ tu'* = typeuse_u1*
 Assert((|typevar_u0*| ≥ 1))
 Let [tv_1] ++ tv'* = typevar_u0*
 Return $subst_typevar(tv, tv'*, tu'*)
}

subst_packtype pt tv* tu* {
 Return pt
}

subst_numtype nt tv* tu* {
 Return nt
}

subst_vectype vt tv* tu* {
 Return vt
}

subst_typeuse typeuse_u0 tv* tu* {
 If (type(typeuse_u0) == typevar) {
   Let tv' = typeuse_u0
   Return $subst_typevar(tv', tv*, tu*)
 }
 Assert(type(typeuse_u0) == deftype)
 Let dt = typeuse_u0
 Return $subst_deftype(dt, tv*, tu*)
}

subst_heaptype heaptype_u0 tv* tu* {
 If (type(heaptype_u0) == typevar) {
   Let tv' = heaptype_u0
   Return $subst_typevar(tv', tv*, tu*)
 }
 If (type(heaptype_u0) == deftype) {
   Let dt = heaptype_u0
   Return $subst_deftype(dt, tv*, tu*)
 }
 Let ht = heaptype_u0
 Return ht
}

subst_reftype (REF nul ht) tv* tu* {
 Return (REF nul $subst_heaptype(ht, tv*, tu*))
}

subst_valtype valtype_u0 tv* tu* {
 If (type(valtype_u0) == numtype) {
   Let nt = valtype_u0
   Return $subst_numtype(nt, tv*, tu*)
 }
 If (type(valtype_u0) == vectype) {
   Let vt = valtype_u0
   Return $subst_vectype(vt, tv*, tu*)
 }
 If (type(valtype_u0) == reftype) {
   Let rt = valtype_u0
   Return $subst_reftype(rt, tv*, tu*)
 }
 Assert((valtype_u0 == BOT))
 Return BOT
}

subst_storagetype storagetype_u0 tv* tu* {
 If (type(storagetype_u0) == valtype) {
   Let t = storagetype_u0
   Return $subst_valtype(t, tv*, tu*)
 }
 Assert(type(storagetype_u0) == packtype)
 Let pt = storagetype_u0
 Return $subst_packtype(pt, tv*, tu*)
}

subst_fieldtype (mut, zt) tv* tu* {
 Return (mut, $subst_storagetype(zt, tv*, tu*))
}

subst_comptype comptype_u0 tv* tu* {
 If (case(comptype_u0) == STRUCT) {
   Let (STRUCT yt*) = comptype_u0
   Return (STRUCT $subst_fieldtype(yt, tv*, tu*)*)
 }
 If (case(comptype_u0) == ARRAY) {
   Let (ARRAY yt) = comptype_u0
   Return (ARRAY $subst_fieldtype(yt, tv*, tu*))
 }
 Assert(case(comptype_u0) == FUNC)
 Let (FUNC ft) = comptype_u0
 Return (FUNC $subst_functype(ft, tv*, tu*))
}

subst_subtype (SUB fin tu'* ct) tv* tu* {
 Return (SUB fin $subst_typeuse(tu', tv*, tu*)* $subst_comptype(ct, tv*, tu*))
}

subst_rectype (REC st*) tv* tu* {
 Return (REC $subst_subtype(st, tv*, tu*)*)
}

subst_deftype (DEF qt i) tv* tu* {
 Return (DEF $subst_rectype(qt, tv*, tu*) i)
}

subst_functype (t_1* -> t_2*) tv* tu* {
 Return ($subst_valtype(t_1, tv*, tu*)* -> $subst_valtype(t_2, tv*, tu*)*)
}

subst_globaltype (mut, t) tv* tu* {
 Return (mut, $subst_valtype(t, tv*, tu*))
}

subst_tabletype (lim, rt) tv* tu* {
 Return (lim, $subst_reftype(rt, tv*, tu*))
}

subst_memtype (PAGE lim) tv* tu* {
 Return (PAGE lim)
}

subst_externtype externtype_u0 tv* tu* {
 If (case(externtype_u0) == FUNC) {
   Let (FUNC dt) = externtype_u0
   Return (FUNC $subst_deftype(dt, tv*, tu*))
 }
 If (case(externtype_u0) == GLOBAL) {
   Let (GLOBAL gt) = externtype_u0
   Return (GLOBAL $subst_globaltype(gt, tv*, tu*))
 }
 If (case(externtype_u0) == TABLE) {
   Let (TABLE tt) = externtype_u0
   Return (TABLE $subst_tabletype(tt, tv*, tu*))
 }
 Assert(case(externtype_u0) == MEM)
 Let (MEM mt) = externtype_u0
 Return (MEM $subst_memtype(mt, tv*, tu*))
}

subst_moduletype (xt_1* -> xt_2*) tv* tu* {
 Return ($subst_externtype(xt_1, tv*, tu*)* -> $subst_externtype(xt_2, tv*, tu*)*)
}

subst_all_valtype t tu^n {
 Return $subst_valtype(t, $idx(i)^(i<n), tu^n)
}

subst_all_reftype rt tu^n {
 Return $subst_reftype(rt, $idx(i)^(i<n), tu^n)
}

subst_all_deftype dt tu^n {
 Return $subst_deftype(dt, $idx(i)^(i<n), tu^n)
}

subst_all_moduletype mmt tu^n {
 Return $subst_moduletype(mmt, $idx(i)^(i<n), tu^n)
}

subst_all_deftypes deftype_u0* tu* {
 If ((deftype_u0* == [])) {
   Return []
 }
 Let [dt_1] ++ dt* = deftype_u0*
 Return [$subst_all_deftype(dt_1, tu*)] ++ $subst_all_deftypes(dt*, tu*)
}

rollrt x rectype {
 Assert(case(rectype) == REC)
 Let (REC subtype^n) = rectype
 Return (REC $subst_subtype(subtype, $idx((x + i))^(i<n), (REC i)^(i<n))^n)
}

unrollrt rectype {
 Assert(case(rectype) == REC)
 Let (REC subtype^n) = rectype
 Return (REC $subst_subtype(subtype, (REC i)^(i<n), (DEF rectype i)^(i<n))^n)
}

rolldt x rectype {
 Assert(case($rollrt(x, rectype)) == REC)
 Let (REC subtype^n) = $rollrt(x, rectype)
 Return (DEF (REC subtype^n) i)^(i<n)
}

unrolldt (DEF rectype i) {
 Assert(case($unrollrt(rectype)) == REC)
 Let (REC subtype*) = $unrollrt(rectype)
 Return subtype*[i]
}

expanddt deftype {
 Assert(case($unrolldt(deftype)) == SUB)
 Let (SUB fin typeuse* comptype) = $unrolldt(deftype)
 Return comptype
}

funcsxx externidx_u0* {
 If ((externidx_u0* == [])) {
   Return []
 }
 Let [externidx_0] ++ xx* = externidx_u0*
 If (case(externidx_0) == FUNC) {
   Let (FUNC x) = externidx_0
   Return [x] ++ $funcsxx(xx*)
 }
 Let [externidx] ++ xx* = externidx_u0*
 Return $funcsxx(xx*)
}

globalsxx externidx_u0* {
 If ((externidx_u0* == [])) {
   Return []
 }
 Let [externidx_0] ++ xx* = externidx_u0*
 If (case(externidx_0) == GLOBAL) {
   Let (GLOBAL x) = externidx_0
   Return [x] ++ $globalsxx(xx*)
 }
 Let [externidx] ++ xx* = externidx_u0*
 Return $globalsxx(xx*)
}

tablesxx externidx_u0* {
 If ((externidx_u0* == [])) {
   Return []
 }
 Let [externidx_0] ++ xx* = externidx_u0*
 If (case(externidx_0) == TABLE) {
   Let (TABLE x) = externidx_0
   Return [x] ++ $tablesxx(xx*)
 }
 Let [externidx] ++ xx* = externidx_u0*
 Return $tablesxx(xx*)
}

memsxx externidx_u0* {
 If ((externidx_u0* == [])) {
   Return []
 }
 Let [externidx_0] ++ xx* = externidx_u0*
 If (case(externidx_0) == MEM) {
   Let (MEM x) = externidx_0
   Return [x] ++ $memsxx(xx*)
 }
 Let [externidx] ++ xx* = externidx_u0*
 Return $memsxx(xx*)
}

funcsxt externtype_u0* {
 If ((externtype_u0* == [])) {
   Return []
 }
 Let [externtype_0] ++ xt* = externtype_u0*
 If (case(externtype_0) == FUNC) {
   Let (FUNC dt) = externtype_0
   Return [dt] ++ $funcsxt(xt*)
 }
 Let [externtype] ++ xt* = externtype_u0*
 Return $funcsxt(xt*)
}

globalsxt externtype_u0* {
 If ((externtype_u0* == [])) {
   Return []
 }
 Let [externtype_0] ++ xt* = externtype_u0*
 If (case(externtype_0) == GLOBAL) {
   Let (GLOBAL gt) = externtype_0
   Return [gt] ++ $globalsxt(xt*)
 }
 Let [externtype] ++ xt* = externtype_u0*
 Return $globalsxt(xt*)
}

tablesxt externtype_u0* {
 If ((externtype_u0* == [])) {
   Return []
 }
 Let [externtype_0] ++ xt* = externtype_u0*
 If (case(externtype_0) == TABLE) {
   Let (TABLE tt) = externtype_0
   Return [tt] ++ $tablesxt(xt*)
 }
 Let [externtype] ++ xt* = externtype_u0*
 Return $tablesxt(xt*)
}

memsxt externtype_u0* {
 If ((externtype_u0* == [])) {
   Return []
 }
 Let [externtype_0] ++ xt* = externtype_u0*
 If (case(externtype_0) == MEM) {
   Let (MEM mt) = externtype_0
   Return [mt] ++ $memsxt(xt*)
 }
 Let [externtype] ++ xt* = externtype_u0*
 Return $memsxt(xt*)
}

memarg0 {
 Return { ALIGN: 0; OFFSET: 0; }
}

signed_ N i {
 If ((0 ≤ (2 ^ (N - 1)))) {
   Return i
 }
 Assert(((2 ^ (N - 1)) ≤ i))
 Assert((i < (2 ^ N)))
 Return (i - (2 ^ N))
}

invsigned_ N i {
 Let j = $signed__1^-1(N, i)
 Return j
}

unop_ numtype_u1 unop__u0 num__u3 {
 If (((unop__u0 == CLZ) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN = num__u3
   Return [$iclz_($sizenn(Inn), iN)]
 }
 If (((unop__u0 == CTZ) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN = num__u3
   Return [$ictz_($sizenn(Inn), iN)]
 }
 If (((unop__u0 == POPCNT) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN = num__u3
   Return [$ipopcnt_($sizenn(Inn), iN)]
 }
 If (type(numtype_u1) == Inn) {
   Let Inn = numtype_u1
   Assert(case(unop__u0) == EXTEND)
   Let (EXTEND M) = unop__u0
   Let iN = num__u3
   Return [$extend__(M, $sizenn(Inn), S, $wrap__($sizenn(Inn), M, iN))]
 }
 If (((unop__u0 == ABS) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN = num__u3
   Return $fabs_($sizenn(Fnn), fN)
 }
 If (((unop__u0 == NEG) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN = num__u3
   Return $fneg_($sizenn(Fnn), fN)
 }
 If (((unop__u0 == SQRT) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN = num__u3
   Return $fsqrt_($sizenn(Fnn), fN)
 }
 If (((unop__u0 == CEIL) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN = num__u3
   Return $fceil_($sizenn(Fnn), fN)
 }
 If (((unop__u0 == FLOOR) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN = num__u3
   Return $ffloor_($sizenn(Fnn), fN)
 }
 If (((unop__u0 == TRUNC) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN = num__u3
   Return $ftrunc_($sizenn(Fnn), fN)
 }
 Assert((unop__u0 == NEAREST))
 Assert(type(numtype_u1) == Fnn)
 Let Fnn = numtype_u1
 Let fN = num__u3
 Return $fnearest_($sizenn(Fnn), fN)
}

binop_ numtype_u1 binop__u0 num__u3 num__u5 {
 If (((binop__u0 == ADD) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$iadd_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == SUB) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$isub_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == MUL) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$imul_($sizenn(Inn), iN_1, iN_2)]
 }
 If (type(numtype_u1) == Inn) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   If (case(binop__u0) == DIV) {
     Let (DIV sx) = binop__u0
     Return $list_(num_((Inn : Inn <: numtype)), $idiv_($sizenn(Inn), sx, iN_1, iN_2))
   }
   If (case(binop__u0) == REM) {
     Let (REM sx) = binop__u0
     Return $list_(num_((Inn : Inn <: numtype)), $irem_($sizenn(Inn), sx, iN_1, iN_2))
   }
 }
 If (((binop__u0 == AND) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$iand_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == OR) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$ior_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == XOR) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$ixor_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == SHL) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$ishl_($sizenn(Inn), iN_1, iN_2)]
 }
 If (type(numtype_u1) == Inn) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   If (case(binop__u0) == SHR) {
     Let (SHR sx) = binop__u0
     Return [$ishr_($sizenn(Inn), sx, iN_1, iN_2)]
   }
 }
 If (((binop__u0 == ROTL) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$irotl_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == ROTR) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$irotr_($sizenn(Inn), iN_1, iN_2)]
 }
 If (((binop__u0 == ADD) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fadd_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == SUB) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fsub_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == MUL) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fmul_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == DIV) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fdiv_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == MIN) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fmin_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((binop__u0 == MAX) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fmax_($sizenn(Fnn), fN_1, fN_2)
 }
 Assert((binop__u0 == COPYSIGN))
 Assert(type(numtype_u1) == Fnn)
 Let Fnn = numtype_u1
 Let fN_1 = num__u3
 Let fN_2 = num__u5
 Return $fcopysign_($sizenn(Fnn), fN_1, fN_2)
}

testop_ Inn EQZ iN {
 Return $ieqz_($sizenn(Inn), iN)
}

relop_ numtype_u1 relop__u0 num__u3 num__u5 {
 If (((relop__u0 == EQ) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return $ieq_($sizenn(Inn), iN_1, iN_2)
 }
 If (((relop__u0 == NE) && type(numtype_u1) == Inn)) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return $ine_($sizenn(Inn), iN_1, iN_2)
 }
 If (type(numtype_u1) == Inn) {
   Let Inn = numtype_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   If (case(relop__u0) == LT) {
     Let (LT sx) = relop__u0
     Return $ilt_($sizenn(Inn), sx, iN_1, iN_2)
   }
   If (case(relop__u0) == GT) {
     Let (GT sx) = relop__u0
     Return $igt_($sizenn(Inn), sx, iN_1, iN_2)
   }
   If (case(relop__u0) == LE) {
     Let (LE sx) = relop__u0
     Return $ile_($sizenn(Inn), sx, iN_1, iN_2)
   }
   If (case(relop__u0) == GE) {
     Let (GE sx) = relop__u0
     Return $ige_($sizenn(Inn), sx, iN_1, iN_2)
   }
 }
 If (((relop__u0 == EQ) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $feq_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((relop__u0 == NE) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fne_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((relop__u0 == LT) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $flt_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((relop__u0 == GT) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fgt_($sizenn(Fnn), fN_1, fN_2)
 }
 If (((relop__u0 == LE) && type(numtype_u1) == Fnn)) {
   Let Fnn = numtype_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fle_($sizenn(Fnn), fN_1, fN_2)
 }
 Assert((relop__u0 == GE))
 Assert(type(numtype_u1) == Fnn)
 Let Fnn = numtype_u1
 Let fN_1 = num__u3
 Let fN_2 = num__u5
 Return $fge_($sizenn(Fnn), fN_1, fN_2)
}

cvtop__ numtype_u1 numtype_u4 cvtop___u0 num__u3 {
 If (type(numtype_u1) == Inn) {
   Let Inn_1 = numtype_u1
   If (type(numtype_u4) == Inn) {
     Let Inn_2 = numtype_u4
     Let iN_1 = num__u3
     If (case(cvtop___u0) == EXTEND) {
       Let (EXTEND sx) = cvtop___u0
       Return [$extend__($sizenn1(Inn_1), $sizenn2(Inn_2), sx, iN_1)]
     }
   }
 }
 If (((cvtop___u0 == WRAP) && type(numtype_u1) == Inn)) {
   Let Inn_1 = numtype_u1
   If (type(numtype_u4) == Inn) {
     Let Inn_2 = numtype_u4
     Let iN_1 = num__u3
     Return [$wrap__($sizenn1(Inn_1), $sizenn2(Inn_2), iN_1)]
   }
 }
 If (type(numtype_u1) == Fnn) {
   Let Fnn_1 = numtype_u1
   If (type(numtype_u4) == Inn) {
     Let Inn_2 = numtype_u4
     Let fN_1 = num__u3
     If (case(cvtop___u0) == TRUNC) {
       Let (TRUNC sx) = cvtop___u0
       Return $list_(num_((Inn_2 : Inn <: numtype)), $trunc__($sizenn1(Fnn_1), $sizenn2(Inn_2), sx, fN_1))
     }
     If (case(cvtop___u0) == TRUNC_SAT) {
       Let (TRUNC_SAT sx) = cvtop___u0
       Return $list_(num_((Inn_2 : Inn <: numtype)), $trunc_sat__($sizenn1(Fnn_1), $sizenn2(Inn_2), sx, fN_1))
     }
   }
 }
 If (type(numtype_u4) == Fnn) {
   Let Fnn_2 = numtype_u4
   If (type(numtype_u1) == Inn) {
     Let Inn_1 = numtype_u1
     Let iN_1 = num__u3
     If (case(cvtop___u0) == CONVERT) {
       Let (CONVERT sx) = cvtop___u0
       Return [$convert__($sizenn1(Inn_1), $sizenn2(Fnn_2), sx, iN_1)]
     }
   }
 }
 If (((cvtop___u0 == PROMOTE) && type(numtype_u1) == Fnn)) {
   Let Fnn_1 = numtype_u1
   If (type(numtype_u4) == Fnn) {
     Let Fnn_2 = numtype_u4
     Let fN_1 = num__u3
     Return $promote__($sizenn1(Fnn_1), $sizenn2(Fnn_2), fN_1)
   }
 }
 If (((cvtop___u0 == DEMOTE) && type(numtype_u1) == Fnn)) {
   Let Fnn_1 = numtype_u1
   If (type(numtype_u4) == Fnn) {
     Let Fnn_2 = numtype_u4
     Let fN_1 = num__u3
     Return $demote__($sizenn1(Fnn_1), $sizenn2(Fnn_2), fN_1)
   }
 }
 Assert((cvtop___u0 == REINTERPRET))
 If (type(numtype_u4) == Fnn) {
   Let Fnn_2 = numtype_u4
   If (type(numtype_u1) == Inn) {
     Let Inn_1 = numtype_u1
     Let iN_1 = num__u3
     If (($size(Inn_1) == $size(Fnn_2))) {
       Return [$reinterpret__(Inn_1, Fnn_2, iN_1)]
     }
   }
 }
 Assert(type(numtype_u1) == Fnn)
 Let Fnn_1 = numtype_u1
 Assert(type(numtype_u4) == Inn)
 Let Inn_2 = numtype_u4
 Let fN_1 = num__u3
 Assert(($size(Fnn_1) == $size(Inn_2)))
 Return [$reinterpret__(Fnn_1, Inn_2, fN_1)]
}

invibytes_ N b* {
 Let n = $ibytes__1^-1(N, b*)
 Return n
}

invfbytes_ N b* {
 Let p = $fbytes__1^-1(N, b*)
 Return p
}

lpacknum_ lanetype_u0 c {
 If (type(lanetype_u0) == numtype) {
   Return c
 }
 Assert(type(lanetype_u0) == packtype)
 Let packtype = lanetype_u0
 Return $wrap__($size($lunpack(packtype)), $psize(packtype), c)
}

lunpacknum_ lanetype_u0 c {
 If (type(lanetype_u0) == numtype) {
   Return c
 }
 Assert(type(lanetype_u0) == packtype)
 Let packtype = lanetype_u0
 Return $extend__($psize(packtype), $size($lunpack(packtype)), U, c)
}

cpacknum_ storagetype_u0 c {
 If (type(storagetype_u0) == consttype) {
   Return c
 }
 Assert(type(storagetype_u0) == packtype)
 Let packtype = storagetype_u0
 Return $wrap__($size($lunpack(packtype)), $psize(packtype), c)
}

cunpacknum_ storagetype_u0 c {
 If (type(storagetype_u0) == consttype) {
   Return c
 }
 Assert(type(storagetype_u0) == packtype)
 Let packtype = storagetype_u0
 Return $extend__($psize(packtype), $size($lunpack(packtype)), U, c)
}

invlanes_ sh c* {
 Let vc = $lanes__1^-1(sh, c*)
 Return vc
}

half__ (lanetype_u1 X M_1) (lanetype_u2 X M_2) half___u0 i j {
 If (((half___u0 == LOW) && (type(lanetype_u1) == Jnn && type(lanetype_u2) == Jnn))) {
   Return i
 }
 If (((half___u0 == HIGH) && (type(lanetype_u1) == Jnn && type(lanetype_u2) == Jnn))) {
   Return j
 }
 Assert((half___u0 == LOW))
 Assert(type(lanetype_u2) == Fnn)
 Return i
}

vvunop_ V128 NOT v128 {
 Return [$inot_($vsize(V128), v128)]
}

vvbinop_ V128 vvbinop_u0 v128_1 v128_2 {
 If ((vvbinop_u0 == AND)) {
   Return [$iand_($vsize(V128), v128_1, v128_2)]
 }
 If ((vvbinop_u0 == ANDNOT)) {
   Return [$iandnot_($vsize(V128), v128_1, v128_2)]
 }
 If ((vvbinop_u0 == OR)) {
   Return [$ior_($vsize(V128), v128_1, v128_2)]
 }
 Assert((vvbinop_u0 == XOR))
 Return [$ixor_($vsize(V128), v128_1, v128_2)]
}

vvternop_ V128 BITSELECT v128_1 v128_2 v128_3 {
 Return [$ibitselect_($vsize(V128), v128_1, v128_2, v128_3)]
}

vunop_ (lanetype_u1 X M) vunop__u0 v128_1 {
 If (((vunop__u0 == ABS) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let v128 = $invlanes_((Jnn X M), $iabs_($lsizenn(Jnn), lane_1)*)
   Return [v128]
 }
 If (((vunop__u0 == NEG) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let v128 = $invlanes_((Jnn X M), $ineg_($lsizenn(Jnn), lane_1)*)
   Return [v128]
 }
 If (((vunop__u0 == POPCNT) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let v128 = $invlanes_((Jnn X M), $ipopcnt_($lsizenn(Jnn), lane_1)*)
   Return [v128]
 }
 If (((vunop__u0 == ABS) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fabs_($sizenn(Fnn), lane_1)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vunop__u0 == NEG) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fneg_($sizenn(Fnn), lane_1)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vunop__u0 == SQRT) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fsqrt_($sizenn(Fnn), lane_1)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vunop__u0 == CEIL) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fceil_($sizenn(Fnn), lane_1)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vunop__u0 == FLOOR) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $ffloor_($sizenn(Fnn), lane_1)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vunop__u0 == TRUNC) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $ftrunc_($sizenn(Fnn), lane_1)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 Assert((vunop__u0 == NEAREST))
 Assert(type(lanetype_u1) == Fnn)
 Let Fnn = lanetype_u1
 Let lane_1* = $lanes_((Fnn X M), v128_1)
 Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fnearest_($sizenn(Fnn), lane_1)*)
 Let v128* = $invlanes_((Fnn X M), lane*)*
 Return v128*
}

vbinop_ (lanetype_u1 X M) vbinop__u0 v128_1 v128_2 {
 If (((vbinop__u0 == ADD) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let v128 = $invlanes_((Jnn X M), $iadd_($lsizenn(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbinop__u0 == SUB) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let v128 = $invlanes_((Jnn X M), $isub_($lsizenn(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (type(lanetype_u1) == Jnn) {
   Let Jnn = lanetype_u1
   If (case(vbinop__u0) == MIN) {
     Let (MIN sx) = vbinop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let v128 = $invlanes_((Jnn X M), $imin_($lsizenn(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
   If (case(vbinop__u0) == MAX) {
     Let (MAX sx) = vbinop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let v128 = $invlanes_((Jnn X M), $imax_($lsizenn(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
   If (case(vbinop__u0) == ADD_SAT) {
     Let (ADD_SAT sx) = vbinop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let v128 = $invlanes_((Jnn X M), $iadd_sat_($lsizenn(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
   If (case(vbinop__u0) == SUB_SAT) {
     Let (SUB_SAT sx) = vbinop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let v128 = $invlanes_((Jnn X M), $isub_sat_($lsizenn(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
 }
 If (((vbinop__u0 == MUL) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let v128 = $invlanes_((Jnn X M), $imul_($lsizenn(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbinop__u0 == AVGR) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let v128 = $invlanes_((Jnn X M), $iavgr_($lsizenn(Jnn), U, lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbinop__u0 == Q15MULR_SAT) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let v128 = $invlanes_((Jnn X M), $iq15mulr_sat_($lsizenn(Jnn), S, lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbinop__u0 == ADD) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fadd_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vbinop__u0 == SUB) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fsub_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vbinop__u0 == MUL) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fmul_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vbinop__u0 == DIV) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fdiv_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vbinop__u0 == MIN) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fmin_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vbinop__u0 == MAX) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fmax_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 If (((vbinop__u0 == PMIN) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fpmin_($sizenn(Fnn), lane_1, lane_2)*)
   Let v128* = $invlanes_((Fnn X M), lane*)*
   Return v128*
 }
 Assert((vbinop__u0 == PMAX))
 Assert(type(lanetype_u1) == Fnn)
 Let Fnn = lanetype_u1
 Let lane_1* = $lanes_((Fnn X M), v128_1)
 Let lane_2* = $lanes_((Fnn X M), v128_2)
 Let lane** = $setproduct_(lane_((Fnn : Fnn <: lanetype)), $fpmax_($sizenn(Fnn), lane_1, lane_2)*)
 Let v128* = $invlanes_((Fnn X M), lane*)*
 Return v128*
}

vrelop_ (lanetype_u1 X M) vrelop__u0 v128_1 v128_2 {
 If (((vrelop__u0 == EQ) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let lane* = $extend__(1, $lsizenn(Jnn), S, $ieq_($lsizenn(Jnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Jnn X M), lane*)
   Return v128
 }
 If (((vrelop__u0 == NE) && type(lanetype_u1) == Jnn)) {
   Let Jnn = lanetype_u1
   Let lane_1* = $lanes_((Jnn X M), v128_1)
   Let lane_2* = $lanes_((Jnn X M), v128_2)
   Let lane* = $extend__(1, $lsizenn(Jnn), S, $ine_($lsizenn(Jnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Jnn X M), lane*)
   Return v128
 }
 If (type(lanetype_u1) == Jnn) {
   Let Jnn = lanetype_u1
   If (case(vrelop__u0) == LT) {
     Let (LT sx) = vrelop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let lane* = $extend__(1, $lsizenn(Jnn), S, $ilt_($lsizenn(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X M), lane*)
     Return v128
   }
   If (case(vrelop__u0) == GT) {
     Let (GT sx) = vrelop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let lane* = $extend__(1, $lsizenn(Jnn), S, $igt_($lsizenn(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X M), lane*)
     Return v128
   }
   If (case(vrelop__u0) == LE) {
     Let (LE sx) = vrelop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let lane* = $extend__(1, $lsizenn(Jnn), S, $ile_($lsizenn(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X M), lane*)
     Return v128
   }
   If (case(vrelop__u0) == GE) {
     Let (GE sx) = vrelop__u0
     Let lane_1* = $lanes_((Jnn X M), v128_1)
     Let lane_2* = $lanes_((Jnn X M), v128_2)
     Let lane* = $extend__(1, $lsizenn(Jnn), S, $ige_($lsizenn(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X M), lane*)
     Return v128
   }
 }
 If (((vrelop__u0 == EQ) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   If (type($size^-1($size(Fnn))) == Inn) {
     Let Inn = $size^-1($size(Fnn))
     Let lane* = $extend__(1, $sizenn(Fnn), S, $feq_($sizenn(Fnn), lane_1, lane_2))*
     Let v128 = $invlanes_((Inn X M), lane*)
     Return v128
   }
 }
 If (((vrelop__u0 == NE) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let Inn = $isize^-1($size(Fnn))
   Let lane* = $extend__(1, $sizenn(Fnn), S, $fne_($sizenn(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X M), lane*)
   Return v128
 }
 If (((vrelop__u0 == LT) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let Inn = $isize^-1($size(Fnn))
   Let lane* = $extend__(1, $sizenn(Fnn), S, $flt_($sizenn(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X M), lane*)
   Return v128
 }
 If (((vrelop__u0 == GT) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let Inn = $isize^-1($size(Fnn))
   Let lane* = $extend__(1, $sizenn(Fnn), S, $fgt_($sizenn(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X M), lane*)
   Return v128
 }
 If (((vrelop__u0 == LE) && type(lanetype_u1) == Fnn)) {
   Let Fnn = lanetype_u1
   Let lane_1* = $lanes_((Fnn X M), v128_1)
   Let lane_2* = $lanes_((Fnn X M), v128_2)
   Let Inn = $isize^-1($size(Fnn))
   Let lane* = $extend__(1, $sizenn(Fnn), S, $fle_($sizenn(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X M), lane*)
   Return v128
 }
 Assert((vrelop__u0 == GE))
 Assert(type(lanetype_u1) == Fnn)
 Let Fnn = lanetype_u1
 Let lane_1* = $lanes_((Fnn X M), v128_1)
 Let lane_2* = $lanes_((Fnn X M), v128_2)
 Let Inn = $isize^-1($size(Fnn))
 Let lane* = $extend__(1, $sizenn(Fnn), S, $fge_($sizenn(Fnn), lane_1, lane_2))*
 Let v128 = $invlanes_((Inn X M), lane*)
 Return v128
}

vcvtop__ (lanetype_u3 X M_1) (lanetype_u0 X M_2) vcvtop___u2 lane__u5 {
 If (type(lanetype_u3) == Jnn) {
   Let Jnn_1 = lanetype_u3
   If (type(lanetype_u0) == Jnn) {
     Let Jnn_2 = lanetype_u0
     Let iN_1 = lane__u5
     If (case(vcvtop___u2) == EXTEND) {
       Let (EXTEND sx) = vcvtop___u2
       Let iN_2 = $extend__($lsizenn1(Jnn_1), $lsizenn2(Jnn_2), sx, iN_1)
       Return [iN_2]
     }
   }
 }
 If (type(lanetype_u0) == Fnn) {
   Let Fnn_2 = lanetype_u0
   If (type(lanetype_u3) == Jnn) {
     Let Jnn_1 = lanetype_u3
     Let iN_1 = lane__u5
     If (case(vcvtop___u2) == CONVERT) {
       Let (CONVERT sx) = vcvtop___u2
       Let fN_2 = $convert__($lsizenn1(Jnn_1), $lsizenn2(Fnn_2), sx, iN_1)
       Return [fN_2]
     }
   }
 }
 If (type(lanetype_u3) == Fnn) {
   Let Fnn_1 = lanetype_u3
   If (type(lanetype_u0) == Inn) {
     Let Inn_2 = lanetype_u0
     Let fN_1 = lane__u5
     If (case(vcvtop___u2) == TRUNC_SAT) {
       Let (TRUNC_SAT sx) = vcvtop___u2
       Let iN_2? = $trunc_sat__($lsizenn1(Fnn_1), $lsizenn2(Inn_2), sx, fN_1)
       Return $list_(lane_((Inn_2 : Inn <: lanetype)), iN_2?)
     }
   }
 }
 If (((vcvtop___u2 == DEMOTE) && type(lanetype_u3) == Fnn)) {
   Let Fnn_1 = lanetype_u3
   If (type(lanetype_u0) == Fnn) {
     Let Fnn_2 = lanetype_u0
     Let fN_1 = lane__u5
     Let fN_2* = $demote__($lsizenn1(Fnn_1), $lsizenn2(Fnn_2), fN_1)
     Return fN_2*
   }
 }
 Assert((vcvtop___u2 == PROMOTE))
 Assert(type(lanetype_u3) == Fnn)
 Let Fnn_1 = lanetype_u3
 Assert(type(lanetype_u0) == Fnn)
 Let Fnn_2 = lanetype_u0
 Let fN_1 = lane__u5
 Let fN_2* = $promote__($lsizenn1(Fnn_1), $lsizenn2(Fnn_2), fN_1)
 Return fN_2*
}

vextunop__ (Jnn_1 X M_1) (Jnn_2 X M_2) (EXTADD_PAIRWISE sx) c_1 {
 Let ci* = $lanes_((Jnn_1 X M_1), c_1)
 Let [cj_1, cj_2]* = $concat__1^-1(iN($lsizenn2((Jnn_2 : Jnn <: lanetype))), $extend__($lsizenn1(Jnn_1), $lsizenn2(Jnn_2), sx, ci)*)
 Let c = $invlanes_((Jnn_2 X M_2), $iadd_($lsizenn2(Jnn_2), cj_1, cj_2)*)
 Return c
}

vextbinop__ (Jnn_1 X M_1) (Jnn_2 X M_2) vextbinop___u0 c_1 c_2 {
 If (case(vextbinop___u0) == EXTMUL) {
   Let (EXTMUL sx half) = vextbinop___u0
   Let ci_1* = $lanes_((Jnn_1 X M_1), c_1)[$half__((Jnn_1 X M_1), (Jnn_2 X M_2), half, 0, M_2) : M_2]
   Let ci_2* = $lanes_((Jnn_1 X M_1), c_2)[$half__((Jnn_1 X M_1), (Jnn_2 X M_2), half, 0, M_2) : M_2]
   Let c = $invlanes_((Jnn_2 X M_2), $imul_($lsizenn2(Jnn_2), $extend__($lsizenn1(Jnn_1), $lsizenn2(Jnn_2), sx, ci_1), $extend__($lsizenn1(Jnn_1), $lsizenn2(Jnn_2), sx, ci_2))*)
   Return c
 }
 Assert((vextbinop___u0 == DOT))
 Let ci_1* = $lanes_((Jnn_1 X M_1), c_1)
 Let ci_2* = $lanes_((Jnn_1 X M_1), c_2)
 Let [cj_1, cj_2]* = $concat__1^-1(iN($lsizenn2((Jnn_2 : Jnn <: lanetype))), $imul_($lsizenn2(Jnn_2), $extend__($lsizenn1(Jnn_1), $lsizenn2(Jnn_2), S, ci_1), $extend__($lsizenn1(Jnn_1), $lsizenn2(Jnn_2), S, ci_2))*)
 Let c = $invlanes_((Jnn_2 X M_2), $iadd_($lsizenn2(Jnn_2), cj_1, cj_2)*)
 Return c
}

vshiftop_ (Jnn X M) vshiftop__u0 lane n {
 If ((vshiftop__u0 == SHL)) {
   Return $ishl_($lsizenn(Jnn), lane, n)
 }
 Assert(case(vshiftop__u0) == SHR)
 Let (SHR sx) = vshiftop__u0
 Return $ishr_($lsizenn(Jnn), sx, lane, n)
}

inst_valtype moduleinst t {
 Let dt* = moduleinst.TYPES
 Return $subst_all_valtype(t, dt*)
}

inst_reftype moduleinst rt {
 Let dt* = moduleinst.TYPES
 Return $subst_all_reftype(rt, dt*)
}

default_ valtype_u0 {
 If (type(valtype_u0) == Inn) {
   Let Inn = valtype_u0
   Return ?((Inn.CONST 0))
 }
 If (type(valtype_u0) == Fnn) {
   Let Fnn = valtype_u0
   Return ?((Fnn.CONST $fzero($size(Fnn))))
 }
 If (type(valtype_u0) == Vnn) {
   Let Vnn = valtype_u0
   Return ?((Vnn.CONST 0))
 }
 Assert(case(valtype_u0) == REF)
 Let (REF nul_0 ht) = valtype_u0
 If ((nul_0 == (NULL ?(())))) {
   Return ?((REF.NULL ht))
 }
 Assert((nul_0 == (NULL ?())))
 Return ?()
}

packfield_ storagetype_u0 val_u1 {
 Let val = val_u1
 If (type(storagetype_u0) == valtype) {
   Return val
 }
 Assert(case(val_u1) == CONST)
 Let (numtype_0.CONST i) = val_u1
 Assert((numtype_0 == I32))
 Assert(type(storagetype_u0) == packtype)
 Let packtype = storagetype_u0
 Return (PACK packtype $wrap__(32, $psize(packtype), i))
}

unpackfield_ storagetype_u0 sx_u1? fieldval_u2 {
 If (!(sx_u1? != None)) {
   Assert(type(fieldval_u2) == val)
   Let val = fieldval_u2
   Assert(type(storagetype_u0) == valtype)
   Return val
 }
 Else {
   Let ?(sx) = sx_u1?
   Assert(case(fieldval_u2) == PACK)
   Let (PACK packtype i) = fieldval_u2
   Assert((storagetype_u0 == packtype))
   Return (I32.CONST $extend__($psize(packtype), 32, sx, i))
 }
}

funcsxv externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ xv* = externval_u0*
 If (case(externval_0) == FUNC) {
   Let (FUNC fa) = externval_0
   Return [fa] ++ $funcsxv(xv*)
 }
 Let [externval] ++ xv* = externval_u0*
 Return $funcsxv(xv*)
}

globalsxv externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ xv* = externval_u0*
 If (case(externval_0) == GLOBAL) {
   Let (GLOBAL ga) = externval_0
   Return [ga] ++ $globalsxv(xv*)
 }
 Let [externval] ++ xv* = externval_u0*
 Return $globalsxv(xv*)
}

tablesxv externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ xv* = externval_u0*
 If (case(externval_0) == TABLE) {
   Let (TABLE ta) = externval_0
   Return [ta] ++ $tablesxv(xv*)
 }
 Let [externval] ++ xv* = externval_u0*
 Return $tablesxv(xv*)
}

memsxv externval_u0* {
 If ((externval_u0* == [])) {
   Return []
 }
 Let [externval_0] ++ xv* = externval_u0*
 If (case(externval_0) == MEM) {
   Let (MEM ma) = externval_0
   Return [ma] ++ $memsxv(xv*)
 }
 Let [externval] ++ xv* = externval_u0*
 Return $memsxv(xv*)
}

store {
 Return
}

frame {
 Let f = current_frame()
 Return f
}

moduleinst {
 Let f = current_frame()
 Return f.MODULE
}

funcinst {
 Return s.FUNCS
}

globalinst {
 Return s.GLOBALS
}

tableinst {
 Return s.TABLES
}

meminst {
 Return s.MEMS
}

eleminst {
 Return s.ELEMS
}

datainst {
 Return s.DATAS
}

structinst {
 Return s.STRUCTS
}

arrayinst {
 Return s.ARRAYS
}

type x {
 Let f = current_frame()
 Return f.MODULE.TYPES[x]
}

func x {
 Let f = current_frame()
 Return s.FUNCS[f.MODULE.FUNCS[x]]
}

global x {
 Let f = current_frame()
 Return s.GLOBALS[f.MODULE.GLOBALS[x]]
}

table x {
 Let f = current_frame()
 Return s.TABLES[f.MODULE.TABLES[x]]
}

mem x {
 Let f = current_frame()
 Return s.MEMS[f.MODULE.MEMS[x]]
}

elem x {
 Let f = current_frame()
 Return s.ELEMS[f.MODULE.ELEMS[x]]
}

data x {
 Let f = current_frame()
 Return s.DATAS[f.MODULE.DATAS[x]]
}

local x {
 Let f = current_frame()
 Return f.LOCALS[x]
}

with_local x v {
 Let f = current_frame()
 f.LOCALS[x] := ?(v)
}

with_global x v {
 Let f = current_frame()
 s.GLOBALS[f.MODULE.GLOBALS[x]].VALUE := v
}

with_table x i r {
 Let f = current_frame()
 s.TABLES[f.MODULE.TABLES[x]].REFS[i] := r
}

with_tableinst x ti {
 Let f = current_frame()
 s.TABLES[f.MODULE.TABLES[x]] := ti
}

with_mem x i j b* {
 Let f = current_frame()
 s.MEMS[f.MODULE.MEMS[x]].BYTES[i : j] := b*
}

with_meminst x mi {
 Let f = current_frame()
 s.MEMS[f.MODULE.MEMS[x]] := mi
}

with_elem x r* {
 Let f = current_frame()
 s.ELEMS[f.MODULE.ELEMS[x]].REFS := r*
}

with_data x b* {
 Let f = current_frame()
 s.DATAS[f.MODULE.DATAS[x]].BYTES := b*
}

with_struct a i fv {
 s.STRUCTS[a].FIELDS[i] := fv
}

with_array a i fv {
 s.ARRAYS[a].FIELDS[i] := fv
}

add_structinst si* {
 Let f = current_frame()
 Return (append(s.STRUCTS, si*), f)
}

add_arrayinst ai* {
 Let f = current_frame()
 Return (append(s.ARRAYS, ai*), f)
}

growtable tableinst n r {
 Let { TYPE: ((i, j), rt); REFS: r'*; } = tableinst
 If (((|r'*| + n) ≤ j)) {
   Let i' = (|r'*| + n)
   Let tableinst' = { TYPE: ((i', j), rt); REFS: r'* ++ r^n; }
   Return tableinst'
 }
}

growmem meminst n {
 Let { TYPE: (PAGE (i, j)); BYTES: b*; } = meminst
 If ((((|b*| / (64 · $Ki())) + n) ≤ j)) {
   Let i' = ((|b*| / (64 · $Ki())) + n)
   Let meminst' = { TYPE: (PAGE (i', j)); BYTES: b* ++ 0^(n · (64 · $Ki())); }
   Return meminst'
 }
}

blocktype_ blocktype_u0 {
 If (case(blocktype_u0) == _IDX) {
   Let (_IDX x) = blocktype_u0
   Assert(case($expanddt($type(x))) == FUNC)
   Let (FUNC ft) = $expanddt($type(x))
   Return ft
 }
 Assert(case(blocktype_u0) == _RESULT)
 Let (_RESULT t?) = blocktype_u0
 Return ([] -> t?)
}

alloctypes type_u0* {
 If ((type_u0* == [])) {
   Return []
 }
 Let type'* ++ [type] = type_u0*
 Assert(case(type) == TYPE)
 Let (TYPE rectype) = type
 Let deftype'* = $alloctypes(type'*)
 Let x = |deftype'*|
 Let deftype* = $subst_all_deftypes($rolldt(x, rectype), deftype'*)
 Return deftype'* ++ deftype*
}

allocfunc deftype funccode moduleinst {
 Let funcinst = { TYPE: deftype; MODULE: moduleinst; CODE: funccode; }
 Let a = |s.FUNCS|
 funcinst :+ s.FUNCS
 Return a
}

allocfuncs deftype_u0* funccode_u1* moduleinst_u2* {
 If ((deftype_u0* == [])) {
   Assert((funccode_u1* == []))
   Assert((moduleinst_u2* == []))
   Return []
 }
 Else {
   Let [dt] ++ dt'* = deftype_u0*
   Assert((|funccode_u1*| ≥ 1))
   Let [funccode] ++ funccode'* = funccode_u1*
   Assert((|moduleinst_u2*| ≥ 1))
   Let [moduleinst] ++ moduleinst'* = moduleinst_u2*
   Let fa = $allocfunc(dt, funccode, moduleinst)
   Let fa'* = $allocfuncs(dt'*, funccode'*, moduleinst'*)
   Return [fa] ++ fa'*
 }
}

allocglobal globaltype val {
 Let globalinst = { TYPE: globaltype; VALUE: val; }
 Let a = |s.GLOBALS|
 globalinst :+ s.GLOBALS
 Return a
}

allocglobals globaltype_u0* val_u1* {
 If ((globaltype_u0* == [])) {
   Assert((val_u1* == []))
   Return []
 }
 Else {
   Let [globaltype] ++ globaltype'* = globaltype_u0*
   Assert((|val_u1*| ≥ 1))
   Let [val] ++ val'* = val_u1*
   Let ga = $allocglobal(globaltype, val)
   Let ga'* = $allocglobals(globaltype'*, val'*)
   Return [ga] ++ ga'*
 }
}

alloctable ((i, j), rt) ref {
 Let tableinst = { TYPE: ((i, j), rt); REFS: ref^i; }
 Let a = |s.TABLES|
 tableinst :+ s.TABLES
 Return a
}

alloctables tabletype_u0* ref_u1* {
 If (((tabletype_u0* == []) && (ref_u1* == []))) {
   Return []
 }
 Assert((|ref_u1*| ≥ 1))
 Let [ref] ++ ref'* = ref_u1*
 Assert((|tabletype_u0*| ≥ 1))
 Let [tabletype] ++ tabletype'* = tabletype_u0*
 Let ta = $alloctable(tabletype, ref)
 Let ta'* = $alloctables(tabletype'*, ref'*)
 Return [ta] ++ ta'*
}

allocmem (PAGE (i, j)) {
 Let meminst = { TYPE: (PAGE (i, j)); BYTES: 0^(i · (64 · $Ki())); }
 Let a = |s.MEMS|
 meminst :+ s.MEMS
 Return a
}

allocmems memtype_u0* {
 If ((memtype_u0* == [])) {
   Return []
 }
 Let [memtype] ++ memtype'* = memtype_u0*
 Let ma = $allocmem(memtype)
 Let ma'* = $allocmems(memtype'*)
 Return [ma] ++ ma'*
}

allocelem elemtype ref* {
 Let eleminst = { TYPE: elemtype; REFS: ref*; }
 Let a = |s.ELEMS|
 eleminst :+ s.ELEMS
 Return a
}

allocelems elemtype_u0* ref_u1* {
 If (((elemtype_u0* == []) && (ref_u1* == []))) {
   Return []
 }
 Assert((|ref_u1*| ≥ 1))
 Let [ref*] ++ ref'** = ref_u1*
 Assert((|elemtype_u0*| ≥ 1))
 Let [rt] ++ rt'* = elemtype_u0*
 Let ea = $allocelem(rt, ref*)
 Let ea'* = $allocelems(rt'*, ref'**)
 Return [ea] ++ ea'*
}

allocdata OK byte* {
 Let datainst = { BYTES: byte*; }
 Let a = |s.DATAS|
 datainst :+ s.DATAS
 Return a
}

allocdatas datatype_u0* byte_u1* {
 If (((datatype_u0* == []) && (byte_u1* == []))) {
   Return []
 }
 Assert((|byte_u1*| ≥ 1))
 Let [b*] ++ b'** = byte_u1*
 Assert((|datatype_u0*| ≥ 1))
 Let [ok] ++ ok'* = datatype_u0*
 Let da = $allocdata(ok, b*)
 Let da'* = $allocdatas(ok'*, b'**)
 Return [da] ++ da'*
}

allocexport moduleinst (EXPORT name externidx_u0) {
 If (case(externidx_u0) == FUNC) {
   Let (FUNC x) = externidx_u0
   Return { NAME: name; VALUE: (FUNC moduleinst.FUNCS[x]); }
 }
 If (case(externidx_u0) == GLOBAL) {
   Let (GLOBAL x) = externidx_u0
   Return { NAME: name; VALUE: (GLOBAL moduleinst.GLOBALS[x]); }
 }
 If (case(externidx_u0) == TABLE) {
   Let (TABLE x) = externidx_u0
   Return { NAME: name; VALUE: (TABLE moduleinst.TABLES[x]); }
 }
 Assert(case(externidx_u0) == MEM)
 Let (MEM x) = externidx_u0
 Return { NAME: name; VALUE: (MEM moduleinst.MEMS[x]); }
}

allocexports moduleinst export* {
 Return $allocexport(moduleinst, export)*
}

allocmodule module externval* val_G* ref_T* ref_E** {
 Let fa_I* = $funcsxv(externval*)
 Let ga_I* = $globalsxv(externval*)
 Let ma_I* = $memsxv(externval*)
 Let ta_I* = $tablesxv(externval*)
 Assert(case(module) == MODULE)
 Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) = module
 Let fa* = (|s.FUNCS| + i_F)^(i_F<|func*|)
 Let ga* = (|s.GLOBALS| + i_G)^(i_G<|global*|)
 Let ta* = (|s.TABLES| + i_T)^(i_T<|table*|)
 Let ma* = (|s.MEMS| + i_M)^(i_M<|mem*|)
 Let ea* = (|s.ELEMS| + i_E)^(i_E<|elem*|)
 Let da* = (|s.DATAS| + i_D)^(i_D<|data*|)
 Assert(case(mem) == MEMORY*)
 Let (MEMORY memtype)* = mem*
 Let dt* = $alloctypes(type*)
 Assert(case(data) == DATA*)
 Let (DATA byte* datamode)* = data*
 Assert(case(global) == GLOBAL*)
 Let (GLOBAL globaltype expr_G)* = global*
 Assert(case(table) == TABLE*)
 Let (TABLE tabletype expr_T)* = table*
 Assert(case(elem) == ELEM*)
 Let (ELEM elemtype expr_E* elemmode)* = elem*
 Assert(case(func) == FUNC*)
 Let (FUNC x local* expr_F)* = func*
 Let xi* = $allocexports({ TYPES: []; FUNCS: fa_I* ++ fa*; GLOBALS: ga_I* ++ ga*; TABLES: ta_I* ++ ta*; MEMS: ma_I* ++ ma*; ELEMS: []; DATAS: []; EXPORTS: []; }, export*)
 Let moduleinst = { TYPES: dt*; FUNCS: fa_I* ++ fa*; GLOBALS: ga_I* ++ ga*; TABLES: ta_I* ++ ta*; MEMS: ma_I* ++ ma*; ELEMS: ea*; DATAS: da*; EXPORTS: xi*; }
 Let funcaddr_0 = $allocfuncs(dt*[x]*, (FUNC x local* expr_F)*, moduleinst^|func*|)
 Assert((funcaddr_0 == fa*))
 Let globaladdr_0 = $allocglobals(globaltype*, val_G*)
 Assert((globaladdr_0 == ga*))
 Let tableaddr_0 = $alloctables(tabletype*, ref_T*)
 Assert((tableaddr_0 == ta*))
 Let memaddr_0 = $allocmems(memtype*)
 Assert((memaddr_0 == ma*))
 Let elemaddr_0 = $allocelems(elemtype*, ref_E**)
 Assert((elemaddr_0 == ea*))
 Let dataaddr_0 = $allocdatas(OK^|data*|, byte**)
 Assert((dataaddr_0 == da*))
 Return moduleinst
}

runelem_ x (ELEM rt e^n elemmode_u0) {
 If ((elemmode_u0 == PASSIVE)) {
   Return []
 }
 If ((elemmode_u0 == DECLARE)) {
   Return [(ELEM.DROP x)]
 }
 Assert(case(elemmode_u0) == ACTIVE)
 Let (ACTIVE y instr*) = elemmode_u0
 Return instr* ++ [(I32.CONST 0), (I32.CONST n), (TABLE.INIT y x), (ELEM.DROP x)]
}

rundata_ x (DATA b^n datamode_u0) {
 If ((datamode_u0 == PASSIVE)) {
   Return []
 }
 Assert(case(datamode_u0) == ACTIVE)
 Let (ACTIVE y instr*) = datamode_u0
 Return instr* ++ [(I32.CONST 0), (I32.CONST n), (MEMORY.INIT y x), (DATA.DROP x)]
}

evalglobals globaltype_u0* expr_u1* {
 Let z = current_frame()
 If (((globaltype_u0* == []) && (expr_u1* == []))) {
   Return []
 }
 Assert((|expr_u1*| ≥ 1))
 Let [expr] ++ expr'* = expr_u1*
 Assert((|globaltype_u0*| ≥ 1))
 Let [gt] ++ gt'* = globaltype_u0*
 Let [val] = $eval_expr(expr)
 Let f = z
 Let a = $allocglobal(gt, val)
 a :+ f.MODULE.GLOBALS
 Let val'* = $evalglobals(gt'*, expr'*)
 Return [val] ++ val'*
}

instantiate module externval* {
 Let (xt_I* -> xt_E*) = $Module_ok(module)
 Assert(case(module) == MODULE)
 Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) = module
 Assert(($Externval_type(externval) == xt_I)*)
 Let instr_D* = $concat_(instr, $rundata_(i_D, data*[i_D])^(i_D<|data*|))
 Let instr_E* = $concat_(instr, $runelem_(i_E, elem*[i_E])^(i_E<|elem*|))
 Assert(case(start) == START?)
 Let (START x)? = start?
 Let moduleinst_0 = { TYPES: $alloctypes(type*); FUNCS: $funcsxv(externval*) ++ (|s.FUNCS| + i_F)^(i_F<|func*|); GLOBALS: $globalsxv(externval*); TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }
 Assert(case(data) == DATA*)
 Assert(case(table) == TABLE*)
 Let (TABLE tabletype expr_T)* = table*
 Assert(case(global) == GLOBAL*)
 Let (GLOBAL globaltype expr_G)* = global*
 Assert(case(elem) == ELEM*)
 Let (ELEM reftype expr_E* elemmode)* = elem*
 Let instr_S? = (CALL x)?
 Let z = { LOCALS: []; MODULE: moduleinst_0; }
 Push(callframe(z))
 Let val_G* = $evalglobals(globaltype*, expr_G*)
 Pop(callframe(z'))
 Push(callframe(z'))
 Let [ref_T]* = $eval_expr(expr_T)*
 Pop(callframe(_f))
 Push(callframe(z'))
 Let [ref_E]** = $eval_expr(expr_E)**
 Pop(callframe(_f))
 Let moduleinst = $allocmodule(module, externval*, val_G*, ref_T*, ref_E**)
 Let f = { LOCALS: []; MODULE: moduleinst; }
 Push(callframe(0, f))
 Execute instr_E*
 Execute instr_D*
 If (instr_S? != None) {
   Let ?(instr_0) = instr_S?
   Execute instr_0
 }
 Pop(callframe(0, f))
 Return f.MODULE
}

invoke funcaddr val* {
 Let f = { LOCALS: []; MODULE: { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }; }
 Assert(case($expanddt(s.FUNCS[funcaddr].TYPE)) == FUNC)
 Let (FUNC functype_0) = $expanddt(s.FUNCS[funcaddr].TYPE)
 Let (t_1* -> t_2*) = functype_0
 Assert(($Val_type(val) == t_1)*)
 Let k = |t_2*|
 Push(callframe(k, f))
 Push(val*)
 Push((REF.FUNC_ADDR funcaddr))
 Execute (CALL_REF s.FUNCS[funcaddr].TYPE)
 Pop_all(val*)
 Pop(callframe(k, f))
 Push(val*)
 Pop(val^k)
 Return val^k
}

allocXs X Y X_u0* Y_u1* {
 If ((X_u0* == [])) {
   Assert((Y_u1* == []))
   Return []
 }
 Else {
   Let [X] ++ X'* = X_u0*
   Assert((|Y_u1*| ≥ 1))
   Let [Y] ++ Y'* = Y_u1*
   Let a = $allocX(X, Y, X, Y)
   Let a'* = $allocXs(X, Y, X'*, Y'*)
   Return [a] ++ a'*
 }
}

var X {
 Return 0
}

Step_pure/unreachable {
 Trap
}

Step_pure/nop {
 Nop
}

Step_pure/drop {
 Assert(top_value())
 Pop(val)
 Nop
}

Step_pure/select t*? {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 Assert(top_value())
 Pop(val_2)
 Assert(top_value())
 Pop(val_1)
 If ((c != 0)) {
   Push(val_1)
 }
 Else {
   Push(val_2)
 }
}

Step_pure/if bt instr_1* instr_2* {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 If ((c != 0)) {
   Execute (BLOCK bt instr_1*)
 }
 Else {
   Execute (BLOCK bt instr_2*)
 }
}

Step_pure/label {
 Pop_all(val*)
 Assert(top_label())
 Pop(current_label())
 Push(val*)
}

Step_pure/br l {
 Pop_all(val*)
 Let L = current_label()
 Let n = arity(L)
 Let instr'* = cont(L)
 Pop(current_label())
 Let instr_u0* = val*
 If ((|instr_u0*| ≥ n)) {
   Let val'* ++ val^n = instr_u0*
   If ((l == 0)) {
     Push(val^n)
     Execute instr'*
   }
 }
 If (type(instr_u0) == val*) {
   Let val* = instr_u0*
   If ((l > 0)) {
     Push(val*)
     Execute (BR (l - 1))
   }
 }
}

Step_pure/br_if l {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 If ((c != 0)) {
   Execute (BR l)
 }
 Else {
   Nop
 }
}

Step_pure/br_table l* l' {
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i < |l*|)) {
   Execute (BR l*[i])
 }
 Else {
   Execute (BR l')
 }
}

Step_pure/br_on_null l {
 Assert(top_value())
 Pop(val)
 If (case(val) == REF.NULL) {
   Execute (BR l)
 }
 Else {
   Push(val)
 }
}

Step_pure/br_on_non_null l {
 Assert(top_value())
 Pop(val)
 If (case(val) == REF.NULL) {
   Nop
 }
 Else {
   Push(val)
   Execute (BR l)
 }
}

Step_pure/call_indirect x yy {
 Execute (TABLE.GET x)
 Execute (REF.CAST (REF (NULL ?(())) yy))
 Execute (CALL_REF yy)
}

Step_pure/return_call_indirect x yy {
 Execute (TABLE.GET x)
 Execute (REF.CAST (REF (NULL ?(())) yy))
 Execute (RETURN_CALL_REF yy)
}

Step_pure/frame {
 Let f = current_frame()
 Let n = arity(f)
 Assert(top_values(n))
 Assert(top_values(n))
 Pop(val^n)
 Assert(top_frame())
 Pop(current_frame())
 Push(val^n)
}

Step_pure/return {
 Pop_all(val*)
 If (top_frame()) {
   Let f = current_frame()
   Let n = arity(f)
   Pop(current_frame())
   Let val'* ++ val^n = val*
   Push(val^n)
 }
 Else if (top_label()) {
   Pop(current_label())
   Push(val*)
   Execute RETURN
 }
}

Step_pure/trap {
 YetI: TODO: It is likely that the value stack of two rules are different.
}

Step_pure/unop nt unop {
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 If ((|$unop_(nt, unop, c_1)| ≤ 0)) {
   Trap
 }
 Let c = choose($unop_(nt, unop, c_1))
 Push((nt.CONST c))
}

Step_pure/binop nt binop {
 Assert(top_value(nt))
 Pop((nt.CONST c_2))
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 If ((|$binop_(nt, binop, c_1, c_2)| ≤ 0)) {
   Trap
 }
 Let c = choose($binop_(nt, binop, c_1, c_2))
 Push((nt.CONST c))
}

Step_pure/testop nt testop {
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 Let c = $testop_(nt, testop, c_1)
 Push((I32.CONST c))
}

Step_pure/relop nt relop {
 Assert(top_value(nt))
 Pop((nt.CONST c_2))
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 Let c = $relop_(nt, relop, c_1, c_2)
 Push((I32.CONST c))
}

Step_pure/cvtop nt_2 nt_1 cvtop {
 Assert(top_value(nt_1))
 Pop((nt_1.CONST c_1))
 If ((|$cvtop__(nt_1, nt_2, cvtop, c_1)| ≤ 0)) {
   Trap
 }
 Let c = choose($cvtop__(nt_1, nt_2, cvtop, c_1))
 Push((nt_2.CONST c))
}

Step_pure/ref.i31 {
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Push((REF.I31_NUM $wrap__(32, 31, i)))
}

Step_pure/ref.is_null {
 Assert(top_value())
 Pop(ref)
 If (case(ref) == REF.NULL) {
   Push((I32.CONST 1))
 }
 Else {
   Push((I32.CONST 0))
 }
}

Step_pure/ref.as_non_null {
 Assert(top_value())
 Pop(ref)
 If (case(ref) == REF.NULL) {
   Trap
 }
 Push(ref)
}

Step_pure/ref.eq {
 Assert(top_value())
 Pop(ref_2)
 Assert(top_value())
 Pop(ref_1)
 If ((case(ref_1) == REF.NULL && case(ref_2) == REF.NULL)) {
   Push((I32.CONST 1))
 }
 Else if ((ref_1 == ref_2)) {
   Push((I32.CONST 1))
 }
 Else {
   Push((I32.CONST 0))
 }
}

Step_pure/i31.get sx {
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.I31_NUM) {
   Let (REF.I31_NUM i) = instr_u0
   Push((I32.CONST $extend__(31, 32, sx, i)))
 }
}

Step_pure/array.new x {
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(val)
 Push(val^n)
 Execute (ARRAY.NEW_FIXED x n)
}

Step_pure/extern.convert_any {
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Push((REF.NULL EXTERN))
 }
 If (type(instr_u0) == addrref) {
   Let addrref = instr_u0
   Push((REF.EXTERN addrref))
 }
}

Step_pure/any.convert_extern {
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Push((REF.NULL ANY))
 }
 If (case(instr_u0) == REF.EXTERN) {
   Let (REF.EXTERN addrref) = instr_u0
   Push(addrref)
 }
}

Step_pure/vvunop V128 vvunop {
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Assert((|$vvunop_(V128, vvunop, c_1)| > 0))
 Let c = choose($vvunop_(V128, vvunop, c_1))
 Push((V128.CONST c))
}

Step_pure/vvbinop V128 vvbinop {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Assert((|$vvbinop_(V128, vvbinop, c_1, c_2)| > 0))
 Let c = choose($vvbinop_(V128, vvbinop, c_1, c_2))
 Push((V128.CONST c))
}

Step_pure/vvternop V128 vvternop {
 Assert(top_value(V128))
 Pop((V128.CONST c_3))
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Assert((|$vvternop_(V128, vvternop, c_1, c_2, c_3)| > 0))
 Let c = choose($vvternop_(V128, vvternop, c_1, c_2, c_3))
 Push((V128.CONST c))
}

Step_pure/vvtestop V128 ANY_TRUE {
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $ine_($vsize(V128), c_1, 0)
 Push((I32.CONST c))
}

Step_pure/vunop sh vunop {
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 If ((|$vunop_(sh, vunop, c_1)| ≤ 0)) {
   Trap
 }
 Let c = choose($vunop_(sh, vunop, c_1))
 Push((V128.CONST c))
}

Step_pure/vbinop sh vbinop {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 If ((|$vbinop_(sh, vbinop, c_1, c_2)| ≤ 0)) {
   Trap
 }
 Let c = choose($vbinop_(sh, vbinop, c_1, c_2))
 Push((V128.CONST c))
}

Step_pure/vtestop (Jnn X M) ALL_TRUE {
 Assert(top_value(V128))
 Pop((V128.CONST c))
 Let ci_1* = $lanes_((Jnn X M), c)
 If ((ci_1 != 0)*) {
   Push((I32.CONST 1))
 }
 Else {
   Push((I32.CONST 0))
 }
}

Step_pure/vrelop sh vrelop {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $vrelop_(sh, vrelop, c_1, c_2)
 Push((V128.CONST c))
}

Step_pure/vshiftop (Jnn X M) vshiftop {
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c'* = $lanes_((Jnn X M), c_1)
 Let c = $invlanes_((Jnn X M), $vshiftop_((Jnn X M), vshiftop, c', n)*)
 Push((V128.CONST c))
}

Step_pure/vbitmask (Jnn X M) {
 Assert(top_value(V128))
 Pop((V128.CONST c))
 Let ci_1* = $lanes_((Jnn X M), c)
 Let ci = $ibits__1^-1(32, $ilt_($lsize(Jnn), S, ci_1, 0)*)
 Push((I32.CONST ci))
}

Step_pure/vswizzle (Pnn X M) {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c'* = $lanes_((Pnn X M), c_1) ++ 0^(256 - M)
 Let ci* = $lanes_((Pnn X M), c_2)
 Assert((ci*[k] < |c'*|)^(k<M))
 Assert((k < |ci*|)^(k<M))
 Let c = $invlanes_((Pnn X M), c'*[ci*[k]]^(k<M))
 Push((V128.CONST c))
}

Step_pure/vshuffle (Pnn X M) i* {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Assert((k < |i*|)^(k<M))
 Let c'* = $lanes_((Pnn X M), c_1) ++ $lanes_((Pnn X M), c_2)
 Assert((i*[k] < |c'*|)^(k<M))
 Let c = $invlanes_((Pnn X M), c'*[i*[k]]^(k<M))
 Push((V128.CONST c))
}

Step_pure/vsplat (Lnn X M) {
 Let nt_0 = $lunpack(Lnn)
 Assert(top_value(nt_0))
 Pop((nt_0.CONST c_1))
 Let c = $invlanes_((Lnn X M), $lpacknum_(Lnn, c_1)^M)
 Push((V128.CONST c))
}

Step_pure/vextract_lane (lanetype_u0 X M) sx_u1? i {
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 If ((!(sx_u1? != None) && type(lanetype_u0) == numtype)) {
   Let nt = lanetype_u0
   If ((i < |$lanes_((nt X M), c_1)|)) {
     Let c_2 = $lanes_((nt X M), c_1)[i]
     Push((nt.CONST c_2))
   }
 }
 If (type(lanetype_u0) == packtype) {
   Let pt = lanetype_u0
   If (sx_u1? != None) {
     Let ?(sx) = sx_u1?
     If ((i < |$lanes_((pt X M), c_1)|)) {
       Let c_2 = $extend__($psize(pt), 32, sx, $lanes_((pt X M), c_1)[i])
       Push((I32.CONST c_2))
     }
   }
 }
}

Step_pure/vreplace_lane (Lnn X M) i {
 Let nt_0 = $lunpack(Lnn)
 Assert(top_value(nt_0))
 Pop((nt_0.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $invlanes_((Lnn X M), update($lanes_((Lnn X M), c_1)[i], $lpacknum_(Lnn, c_2)))
 Push((V128.CONST c))
}

Step_pure/vextunop sh_2 sh_1 vextunop {
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $vextunop__(sh_1, sh_2, vextunop, c_1)
 Push((V128.CONST c))
}

Step_pure/vextbinop sh_2 sh_1 vextbinop {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let c = $vextbinop__(sh_1, sh_2, vextbinop, c_1, c_2)
 Push((V128.CONST c))
}

Step_pure/vnarrow (Jnn_2 X M_2) (Jnn_1 X M_1) sx {
 Assert(top_value(V128))
 Pop((V128.CONST c_2))
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Let ci_1* = $lanes_((Jnn_1 X M_1), c_1)
 Let ci_2* = $lanes_((Jnn_1 X M_1), c_2)
 Let cj_1* = $narrow__($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_1)*
 Let cj_2* = $narrow__($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_2)*
 Let c = $invlanes_((Jnn_2 X M_2), cj_1* ++ cj_2*)
 Push((V128.CONST c))
}

Step_pure/vcvtop (lanetype_u5 X n_u0) (lanetype_u6 X n_u1) vcvtop half___u4? zero___u13? {
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 If ((!(half___u4? != None) && !(zero___u13? != None))) {
   Let Lnn_1 = lanetype_u6
   Let Lnn_2 = lanetype_u5
   Let M = n_u1
   If ((n_u0 == M)) {
     Let ci* = $lanes_((Lnn_1 X M), c_1)
     Let cj** = $setproduct_(lane_(Lnn_2), $vcvtop__((Lnn_1 X M), (Lnn_2 X M), vcvtop, ci)*)
     If ((|$invlanes_((Lnn_2 X M), cj*)*| > 0)) {
       Let c = choose($invlanes_((Lnn_2 X M), cj*)*)
       Push((V128.CONST c))
     }
   }
 }
 If (!(zero___u13? != None)) {
   Let Lnn_1 = lanetype_u6
   Let Lnn_2 = lanetype_u5
   Let M_1 = n_u1
   Let M_2 = n_u0
   If (half___u4? != None) {
     Let ?(half) = half___u4?
     Let ci* = $lanes_((Lnn_1 X M_1), c_1)[$half__((Lnn_1 X M_1), (Lnn_2 X M_2), half, 0, M_2) : M_2]
     Let cj** = $setproduct_(lane_(Lnn_2), $vcvtop__((Lnn_1 X M_1), (Lnn_2 X M_2), vcvtop, ci)*)
     If ((|$invlanes_((Lnn_2 X M_2), cj*)*| > 0)) {
       Let c = choose($invlanes_((Lnn_2 X M_2), cj*)*)
       Push((V128.CONST c))
     }
   }
 }
 If (!(half___u4? != None)) {
   Let M_1 = n_u1
   Let M_2 = n_u0
   If (type(lanetype_u6) == numtype) {
     Let nt_1 = lanetype_u6
     If (type(lanetype_u5) == numtype) {
       Let nt_2 = lanetype_u5
       If (zero___u13? != None) {
         Let ci* = $lanes_((nt_1 X M_1), c_1)
         Let cj** = $setproduct_(lane_((nt_2 : numtype <: lanetype)), $vcvtop__((nt_1 X M_1), (nt_2 X M_2), vcvtop, ci)* ++ [$zero(nt_2)]^M_1)
         If ((|$invlanes_((nt_2 X M_2), cj*)*| > 0)) {
           Let c = choose($invlanes_((nt_2 X M_2), cj*)*)
           Push((V128.CONST c))
         }
       }
     }
   }
 }
}

Step_pure/local.tee x {
 Assert(top_value())
 Pop(val)
 Push(val)
 Push(val)
 Execute (LOCAL.SET x)
}

Step_read/block bt instr* {
 Let z = current_state()
 Let (t_1^m -> t_2^n) = $blocktype_(z, bt)
 Assert(top_values(m))
 Pop(val^m)
 Let L = label(n, [])
 Enter (L, val^m ++ instr*) {
 }
}

Step_read/loop bt instr* {
 Let z = current_state()
 Let (t_1^m -> t_2^n) = $blocktype_(z, bt)
 Assert(top_values(m))
 Pop(val^m)
 Let L = label(m, [(LOOP bt instr*)])
 Enter (L, val^m ++ instr*) {
 }
}

Step_read/br_on_cast l rt_1 rt_2 {
 Let f = current_frame()
 Assert(top_value())
 Pop(ref)
 Let rt = $Ref_type(ref)
 If (!(rt <: $inst_reftype(f.MODULE, rt_2))) {
   Push(ref)
 }
 Else {
   Push(ref)
   Execute (BR l)
 }
}

Step_read/br_on_cast_fail l rt_1 rt_2 {
 Let f = current_frame()
 Assert(top_value())
 Pop(ref)
 Let rt = $Ref_type(ref)
 If (rt <: $inst_reftype(f.MODULE, rt_2)) {
   Push(ref)
 }
 Else {
   Push(ref)
   Execute (BR l)
 }
}

Step_read/call x {
 Let z = current_state()
 Assert((x < |$moduleinst(z).FUNCS|))
 Let a = $moduleinst(z).FUNCS[x]
 Assert((a < |$funcinst(z)|))
 Push((REF.FUNC_ADDR a))
 Execute (CALL_REF $funcinst(z)[a].TYPE)
}

Step_read/call_ref yy {
 Let z = current_state()
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.FUNC_ADDR) {
   Let (REF.FUNC_ADDR a) = instr_u0
   If ((a < |$funcinst(z)|)) {
     Let fi = $funcinst(z)[a]
     Assert(case(fi.CODE) == FUNC)
     Let (FUNC x local_0 instr*) = fi.CODE
     Assert(case(local_0) == LOCAL)
     Let (LOCAL t)* = local_0
     Assert(case($expanddt(fi.TYPE)) == FUNC)
     Let (FUNC functype_0) = $expanddt(fi.TYPE)
     Let (t_1^n -> t_2^m) = functype_0
     Assert(top_values(n))
     Pop(val^n)
     Let f = { LOCALS: ?(val)^n ++ $default_(t)*; MODULE: fi.MODULE; }
     Let F = callframe(m, f)
     Push(F)
     Let L = label(m, [])
     Enter (L, instr*) {
     }
   }
 }
}

Step_read/return_call x {
 Let z = current_state()
 Assert((x < |$moduleinst(z).FUNCS|))
 Let a = $moduleinst(z).FUNCS[x]
 Assert((a < |$funcinst(z)|))
 Push((REF.FUNC_ADDR a))
 Execute (RETURN_CALL_REF $funcinst(z)[a].TYPE)
}

Step_read/return_call_ref yy {
 Let z = current_state()
 Pop_all(val*)
 If (top_label()) {
   Pop(current_label())
   Push(val*)
   Execute (RETURN_CALL_REF yy)
 }
 Else if (top_frame()) {
   Pop(current_frame())
   Let instr_u1* ++ [instr_u0] = val*
   If (case(instr_u0) == REF.FUNC_ADDR) {
     Let (REF.FUNC_ADDR a) = instr_u0
     If ((|instr_u1*| ≥ n)) {
       Let val'* ++ val^n = instr_u1*
       If ((a < |$funcinst(z)|)) {
         Assert(case($expanddt($funcinst(z)[a].TYPE)) == FUNC)
         Let (FUNC functype_0) = $expanddt($funcinst(z)[a].TYPE)
         Let (t_1^n -> t_2^m) = functype_0
         Push(val^n)
         Push((REF.FUNC_ADDR a))
         Execute (CALL_REF yy)
       }
     }
   }
   If ((case(instr_u0) == REF.NULL && type(instr_u1) == val*)) {
     Trap
   }
 }
}

Step_read/ref.null $idx(x) {
 Let z = current_state()
 Push((REF.NULL $type(z, x)))
}

Step_read/ref.func x {
 Let z = current_state()
 Assert((x < |$moduleinst(z).FUNCS|))
 Push((REF.FUNC_ADDR $moduleinst(z).FUNCS[x]))
}

Step_read/ref.test rt {
 Let f = current_frame()
 Assert(top_value())
 Pop(ref)
 Let rt' = $Ref_type(ref)
 If (rt' <: $inst_reftype(f.MODULE, rt)) {
   Push((I32.CONST 1))
 }
 Else {
   Push((I32.CONST 0))
 }
}

Step_read/ref.cast rt {
 Let f = current_frame()
 Assert(top_value())
 Pop(ref)
 Let rt' = $Ref_type(ref)
 If (!(rt' <: $inst_reftype(f.MODULE, rt))) {
   Trap
 }
 Push(ref)
}

Step_read/struct.new_default x {
 Let z = current_state()
 Assert(case($expanddt($type(z, x))) == STRUCT)
 Let (STRUCT fieldtype_0) = $expanddt($type(z, x))
 Let (mut, zt)* = fieldtype_0
 Assert((|mut*| == |zt*|))
 Assert($default_($unpack(zt)) != None*)
 Let ?(val)* = $default_($unpack(zt))*
 Assert((|val*| == |zt*|))
 Push(val*)
 Execute (STRUCT.NEW x)
}

Step_read/struct.get sx? x i {
 Let z = current_state()
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.STRUCT_ADDR) {
   Let (REF.STRUCT_ADDR a) = instr_u0
   If (((i < |$structinst(z)[a].FIELDS|) && (a < |$structinst(z)|))) {
     Assert(case($expanddt($type(z, x))) == STRUCT)
     Let (STRUCT fieldtype_0) = $expanddt($type(z, x))
     Let (mut, zt)* = fieldtype_0
     If (((|mut*| == |zt*|) && (i < |zt*|))) {
       Push($unpackfield_(zt*[i], sx?, $structinst(z)[a].FIELDS[i]))
     }
   }
 }
}

Step_read/array.new_default x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(case($expanddt($type(z, x))) == ARRAY)
 Let (ARRAY arraytype_0) = $expanddt($type(z, x))
 Let (mut, zt) = arraytype_0
 Assert($default_($unpack(zt)) != None)
 Let ?(val) = $default_($unpack(zt))
 Push(val^n)
 Execute (ARRAY.NEW_FIXED x n)
}

Step_read/array.new_elem x y {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((i + n) > |$elem(z, y).REFS|)) {
   Trap
 }
 Assert((|$elem(z, y).REFS[i : n]| == n))
 Let ref* = $elem(z, y).REFS[i : n]
 Push(ref^n)
 Execute (ARRAY.NEW_FIXED x n)
}

Step_read/array.new_data x y {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(case($expanddt($type(z, x))) == ARRAY)
 Let (ARRAY arraytype_0) = $expanddt($type(z, x))
 Let (mut, zt) = arraytype_0
 If (((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|)) {
   Trap
 }
 Assert((|$concatn__1^-1(byte, ($zsize(zt) / 8), $data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)])| == n))
 Let byte* = $concatn__1^-1(byte, ($zsize(zt) / 8), $data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)])
 Let c* = $zbytes__1^-1(zt, byte)*
 Push($const($cunpack(zt), $cunpacknum_(zt, c))^n)
 Execute (ARRAY.NEW_FIXED x n)
}

Step_read/array.get sx? x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If (((a < |$arrayinst(z)|) && (i ≥ |$arrayinst(z)[a].FIELDS|))) {
     Trap
   }
   If (((i < |$arrayinst(z)[a].FIELDS|) && (a < |$arrayinst(z)|))) {
     Assert(case($expanddt($type(z, x))) == ARRAY)
     Let (ARRAY arraytype_0) = $expanddt($type(z, x))
     Let (mut, zt) = arraytype_0
     Push($unpackfield_(zt, sx?, $arrayinst(z)[a].FIELDS[i]))
   }
 }
}

Step_read/array.len {
 Let z = current_state()
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If ((a < |$arrayinst(z)|)) {
     Push((I32.CONST |$arrayinst(z)[a].FIELDS|))
   }
 }
}

Step_read/array.fill x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(val)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If (((a < |$arrayinst(z)|) && ((i + n) > |$arrayinst(z)[a].FIELDS|))) {
     Trap
   }
   If ((n == 0)) {
     Nop
   }
   Else {
     Let (REF.ARRAY_ADDR a) = instr_u0
     Push((REF.ARRAY_ADDR a))
     Push((I32.CONST i))
     Push(val)
     Execute (ARRAY.SET x)
     Push((REF.ARRAY_ADDR a))
     Push((I32.CONST (i + 1)))
     Push(val)
     Push((I32.CONST (n - 1)))
     Execute (ARRAY.FILL x)
   }
 }
}

Step_read/array.copy x_1 x_2 {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i_2))
 Assert(top_value())
 Pop(instr_u1)
 Assert(top_value(I32))
 Pop((I32.CONST i_1))
 Assert(top_value())
 Pop(instr_u0)
 If ((case(instr_u0) == REF.NULL && type(instr_u1) == ref)) {
   Trap
 }
 If ((case(instr_u1) == REF.NULL && type(instr_u0) == ref)) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a_1) = instr_u0
   If (case(instr_u1) == REF.ARRAY_ADDR) {
     If (((a_1 < |$arrayinst(z)|) && ((i_1 + n) > |$arrayinst(z)[a_1].FIELDS|))) {
       Trap
     }
     Let (REF.ARRAY_ADDR a_2) = instr_u1
     If (((a_2 < |$arrayinst(z)|) && ((i_2 + n) > |$arrayinst(z)[a_2].FIELDS|))) {
       Trap
     }
   }
   If ((case(instr_u1) == REF.ARRAY_ADDR && (n == 0))) {
     Nop
   }
   Else {
     Let (REF.ARRAY_ADDR a_1) = instr_u0
     If (case(instr_u1) == REF.ARRAY_ADDR) {
       Let (REF.ARRAY_ADDR a_2) = instr_u1
       If (((i_1 ≤ i_2) && case($expanddt($type(z, x_2))) == ARRAY)) {
         Let (ARRAY arraytype_0) = $expanddt($type(z, x_2))
         Let (mut, zt_2) = arraytype_0
         Let sx? = $sx(zt_2)
         Push((REF.ARRAY_ADDR a_1))
         Push((I32.CONST i_1))
         Push((REF.ARRAY_ADDR a_2))
         Push((I32.CONST i_2))
         Execute (ARRAY.GET sx? x_2)
         Execute (ARRAY.SET x_1)
         Push((REF.ARRAY_ADDR a_1))
         Push((I32.CONST (i_1 + 1)))
         Push((REF.ARRAY_ADDR a_2))
         Push((I32.CONST (i_2 + 1)))
         Push((I32.CONST (n - 1)))
         Execute (ARRAY.COPY x_1 x_2)
       }
       Else {
         Let (REF.ARRAY_ADDR a_1) = instr_u0
         Let (REF.ARRAY_ADDR a_2) = instr_u1
         If (case($expanddt($type(z, x_2))) == ARRAY) {
           Let (ARRAY arraytype_0) = $expanddt($type(z, x_2))
           Let (mut, zt_2) = arraytype_0
           Let sx? = $sx(zt_2)
           Push((REF.ARRAY_ADDR a_1))
           Push((I32.CONST ((i_1 + n) - 1)))
           Push((REF.ARRAY_ADDR a_2))
           Push((I32.CONST ((i_2 + n) - 1)))
           Execute (ARRAY.GET sx? x_2)
           Execute (ARRAY.SET x_1)
           Push((REF.ARRAY_ADDR a_1))
           Push((I32.CONST i_1))
           Push((REF.ARRAY_ADDR a_2))
           Push((I32.CONST i_2))
           Push((I32.CONST (n - 1)))
           Execute (ARRAY.COPY x_1 x_2)
         }
       }
     }
   }
 }
}

Step_read/array.init_elem x y {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If (((a < |$arrayinst(z)|) && ((i + n) > |$arrayinst(z)[a].FIELDS|))) {
     Trap
   }
   If (((j + n) > |$elem(z, y).REFS|)) {
     Trap
   }
   If ((n == 0)) {
     Nop
   }
   Else {
     Let (REF.ARRAY_ADDR a) = instr_u0
     If ((j < |$elem(z, y).REFS|)) {
       Let ref = $elem(z, y).REFS[j]
       Push((REF.ARRAY_ADDR a))
       Push((I32.CONST i))
       Push(ref)
       Execute (ARRAY.SET x)
       Push((REF.ARRAY_ADDR a))
       Push((I32.CONST (i + 1)))
       Push((I32.CONST (j + 1)))
       Push((I32.CONST (n - 1)))
       Execute (ARRAY.INIT_ELEM x y)
     }
   }
 }
}

Step_read/array.init_data x y {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If (((a < |$arrayinst(z)|) && ((i + n) > |$arrayinst(z)[a].FIELDS|))) {
     Trap
   }
   If (case($expanddt($type(z, x))) == ARRAY) {
     Let (ARRAY arraytype_0) = $expanddt($type(z, x))
     Let (mut, zt) = arraytype_0
     If (((j + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|)) {
       Trap
     }
   }
   If ((n == 0)) {
     Nop
   }
   Else {
     Let (REF.ARRAY_ADDR a) = instr_u0
     Assert(case($expanddt($type(z, x))) == ARRAY)
     Let (ARRAY arraytype_0) = $expanddt($type(z, x))
     Let (mut, zt) = arraytype_0
     Let c = $zbytes__1^-1(zt, $data(z, y).BYTES[j : ($zsize(zt) / 8)])
     Push((REF.ARRAY_ADDR a))
     Push((I32.CONST i))
     Push($const($cunpack(zt), $cunpacknum_(zt, c)))
     Execute (ARRAY.SET x)
     Push((REF.ARRAY_ADDR a))
     Push((I32.CONST (i + 1)))
     Push((I32.CONST (j + ($zsize(zt) / 8))))
     Push((I32.CONST (n - 1)))
     Execute (ARRAY.INIT_DATA x y)
   }
 }
}

Step_read/local.get x {
 Let z = current_state()
 Assert($local(z, x) != None)
 Let ?(val) = $local(z, x)
 Push(val)
}

Step_read/global.get x {
 Let z = current_state()
 Let val = $global(z, x).VALUE
 Push(val)
}

Step_read/table.get x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i ≥ |$table(z, x).REFS|)) {
   Trap
 }
 Push($table(z, x).REFS[i])
}

Step_read/table.size x {
 Let z = current_state()
 Let n = |$table(z, x).REFS|
 Push((I32.CONST n))
}

Step_read/table.fill x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(val)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((i + n) > |$table(z, x).REFS|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   Push((I32.CONST i))
   Push(val)
   Execute (TABLE.SET x)
   Push((I32.CONST (i + 1)))
   Push(val)
   Push((I32.CONST (n - 1)))
   Execute (TABLE.FILL x)
 }
}

Step_read/table.copy x y {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$table(z, y).REFS|)) {
   Trap
 }
 If (((j + n) > |$table(z, x).REFS|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   If ((j ≤ i)) {
     Push((I32.CONST j))
     Push((I32.CONST i))
     Execute (TABLE.GET y)
     Execute (TABLE.SET x)
     Push((I32.CONST (j + 1)))
     Push((I32.CONST (i + 1)))
   }
   Else {
     Push((I32.CONST ((j + n) - 1)))
     Push((I32.CONST ((i + n) - 1)))
     Execute (TABLE.GET y)
     Execute (TABLE.SET x)
     Push((I32.CONST j))
     Push((I32.CONST i))
   }
   Push((I32.CONST (n - 1)))
   Execute (TABLE.COPY x y)
 }
}

Step_read/table.init x y {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$elem(z, y).REFS|)) {
   Trap
 }
 If (((j + n) > |$table(z, x).REFS|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else if ((i < |$elem(z, y).REFS|)) {
   Push((I32.CONST j))
   Push($elem(z, y).REFS[i])
   Execute (TABLE.SET x)
   Push((I32.CONST (j + 1)))
   Push((I32.CONST (i + 1)))
   Push((I32.CONST (n - 1)))
   Execute (TABLE.INIT x y)
 }
}

Step_read/load numtype_u0 loadop__u2? x ao {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (!(loadop__u2? != None)) {
   Let nt = numtype_u0
   If ((((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, x).BYTES|)) {
     Trap
   }
   Let c = $nbytes__1^-1(nt, $mem(z, x).BYTES[(i + ao.OFFSET) : ($size(nt) / 8)])
   Push((nt.CONST c))
 }
 If (type(numtype_u0) == Inn) {
   If (loadop__u2? != None) {
     Let ?(loadop__0) = loadop__u2?
     Let (n, sx) = loadop__0
     If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, x).BYTES|)) {
       Trap
     }
   }
   Let Inn = numtype_u0
   If (loadop__u2? != None) {
     Let ?(loadop__0) = loadop__u2?
     Let (n, sx) = loadop__0
     Let c = $ibytes__1^-1(n, $mem(z, x).BYTES[(i + ao.OFFSET) : (n / 8)])
     Push((Inn.CONST $extend__(n, $size(Inn), sx, c)))
   }
 }
}

Step_read/vload V128 vloadop__u0? x ao {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (!(vloadop__u0? != None)) {
   If ((((i + ao.OFFSET) + ($vsize(V128) / 8)) > |$mem(z, x).BYTES|)) {
     Trap
   }
   Let c = $vbytes__1^-1(V128, $mem(z, x).BYTES[(i + ao.OFFSET) : ($vsize(V128) / 8)])
   Push((V128.CONST c))
 }
 Else {
   Let ?(vloadop__0) = vloadop__u0?
   If (case(vloadop__0) == SHAPE) {
     Let (SHAPE M K sx) = vloadop__0
     If ((((i + ao.OFFSET) + ((M · K) / 8)) > |$mem(z, x).BYTES|)) {
       Trap
     }
     If (type($lsizenn^-1((M · 2))) == Jnn) {
       Let Jnn = $lsizenn^-1((M · 2))
       Let j^K = $ibytes__1^-1(M, $mem(z, x).BYTES[((i + ao.OFFSET) + ((k · M) / 8)) : (M / 8)])^(k<K)
       Let c = $invlanes_((Jnn X K), $extend__(M, $lsizenn(Jnn), sx, j)^K)
       Push((V128.CONST c))
     }
   }
   If (case(vloadop__0) == SPLAT) {
     Let (SPLAT N) = vloadop__0
     If ((((i + ao.OFFSET) + (N / 8)) > |$mem(z, x).BYTES|)) {
       Trap
     }
     Let M = (128 / N)
     If (type($lsize^-1(N)) == Jnn) {
       Let Jnn = $lsize^-1(N)
       Let j = $ibytes__1^-1(N, $mem(z, x).BYTES[(i + ao.OFFSET) : (N / 8)])
       Let c = $invlanes_((Jnn X M), j^M)
       Push((V128.CONST c))
     }
   }
   If (case(vloadop__0) == ZERO) {
     Let (ZERO N) = vloadop__0
     If ((((i + ao.OFFSET) + (N / 8)) > |$mem(z, x).BYTES|)) {
       Trap
     }
     Let j = $ibytes__1^-1(N, $mem(z, x).BYTES[(i + ao.OFFSET) : (N / 8)])
     Let c = $extend__(N, 128, U, j)
     Push((V128.CONST c))
   }
 }
}

Step_read/vload_lane V128 N x ao j {
 Let z = current_state()
 Assert(top_value(V128))
 Pop((V128.CONST c_1))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((((i + ao.OFFSET) + (N / 8)) > |$mem(z, x).BYTES|)) {
   Trap
 }
 Let M = ($vsize(V128) / N)
 If (type($lsize^-1(N)) == Jnn) {
   Let Jnn = $lsize^-1(N)
   Let k = $ibytes__1^-1(N, $mem(z, x).BYTES[(i + ao.OFFSET) : (N / 8)])
   Let c = $invlanes_((Jnn X M), update($lanes_((Jnn X M), c_1)[j], k))
   Push((V128.CONST c))
 }
}

Step_read/memory.size x {
 Let z = current_state()
 Let (n · (64 · $Ki())) = |$mem(z, x).BYTES|
 Push((I32.CONST n))
}

Step_read/memory.fill x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(val)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((i + n) > |$mem(z, x).BYTES|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   Push((I32.CONST i))
   Push(val)
   Execute (STORE I32 ?(8) x $memarg0())
   Push((I32.CONST (i + 1)))
   Push(val)
   Push((I32.CONST (n - 1)))
   Execute (MEMORY.FILL x)
 }
}

Step_read/memory.copy x_1 x_2 {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i_2))
 Assert(top_value(I32))
 Pop((I32.CONST i_1))
 If (((i_1 + n) > |$mem(z, x_1).BYTES|)) {
   Trap
 }
 If (((i_2 + n) > |$mem(z, x_2).BYTES|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   If ((i_1 ≤ i_2)) {
     Push((I32.CONST i_1))
     Push((I32.CONST i_2))
     Execute (LOAD I32 ?((8, U)) x_2 $memarg0())
     Execute (STORE I32 ?(8) x_1 $memarg0())
     Push((I32.CONST (i_1 + 1)))
     Push((I32.CONST (i_2 + 1)))
   }
   Else {
     Push((I32.CONST ((i_1 + n) - 1)))
     Push((I32.CONST ((i_2 + n) - 1)))
     Execute (LOAD I32 ?((8, U)) x_2 $memarg0())
     Execute (STORE I32 ?(8) x_1 $memarg0())
     Push((I32.CONST i_1))
     Push((I32.CONST i_2))
   }
   Push((I32.CONST (n - 1)))
   Execute (MEMORY.COPY x_1 x_2)
 }
}

Step_read/memory.init x y {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$data(z, y).BYTES|)) {
   Trap
 }
 If (((j + n) > |$mem(z, x).BYTES|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else if ((i < |$data(z, y).BYTES|)) {
   Push((I32.CONST j))
   Push((I32.CONST $data(z, y).BYTES[i]))
   Execute (STORE I32 ?(8) x $memarg0())
   Push((I32.CONST (j + 1)))
   Push((I32.CONST (i + 1)))
   Push((I32.CONST (n - 1)))
   Execute (MEMORY.INIT x y)
 }
}

Step/ctxt {
 YetI: TODO: It is likely that the value stack of two rules are different.
}

Step/struct.new x {
 Let z = current_state()
 Let a = |$structinst(z)|
 Assert(case($expanddt($type(z, x))) == STRUCT)
 Let (STRUCT fieldtype_0) = $expanddt($type(z, x))
 Let (mut, zt)^n = fieldtype_0
 Assert(top_values(n))
 Pop(val^n)
 Let si = { TYPE: $type(z, x); FIELDS: $packfield_(zt, val)^n; }
 Push((REF.STRUCT_ADDR a))
 $add_structinst(z, [si])
}

Step/struct.set x i {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.STRUCT_ADDR) {
   Let (REF.STRUCT_ADDR a) = instr_u0
   Assert(case($expanddt($type(z, x))) == STRUCT)
   Let (STRUCT fieldtype_0) = $expanddt($type(z, x))
   Let (mut, zt)* = fieldtype_0
   If (((|mut*| == |zt*|) && (i < |zt*|))) {
     $with_struct(z, a, i, $packfield_(zt*[i], val))
   }
 }
}

Step/array.new_fixed x n {
 Let z = current_state()
 Assert(top_values(n))
 Pop(val^n)
 Let a = |$arrayinst(z)|
 Assert(case($expanddt($type(z, x))) == ARRAY)
 Let (ARRAY arraytype_0) = $expanddt($type(z, x))
 Let (mut, zt) = arraytype_0
 Let ai = { TYPE: $type(z, x); FIELDS: $packfield_(zt, val)^n; }
 Push((REF.ARRAY_ADDR a))
 $add_arrayinst(z, [ai])
}

Step/array.set x {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If (((a < |$arrayinst(z)|) && (i ≥ |$arrayinst(z)[a].FIELDS|))) {
     Trap
   }
   Assert(case($expanddt($type(z, x))) == ARRAY)
   Let (ARRAY arraytype_0) = $expanddt($type(z, x))
   Let (mut, zt) = arraytype_0
   $with_array(z, a, i, $packfield_(zt, val))
 }
}

Step/local.set x {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 $with_local(z, x, val)
}

Step/global.set x {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 $with_global(z, x, val)
}

Step/table.set x {
 Let z = current_state()
 Assert(top_value())
 Pop(ref)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i ≥ |$table(z, x).REFS|)) {
   Trap
 }
 $with_table(z, x, i, ref)
}

Step/table.grow x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(ref)
 Either {
   Let ti = $growtable($table(z, x), n, ref)
   Push((I32.CONST |$table(z, x).REFS|))
   $with_tableinst(z, x, ti)
 }
 Or {
   Push((I32.CONST $invsigned_(32, -(1))))
 }
}

Step/elem.drop x {
 Let z = current_state()
 $with_elem(z, x, [])
}

Step/store nt sz_u1? x ao {
 Let z = current_state()
 Assert(top_value(numtype_u0))
 Pop((numtype_u0.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((numtype_u0 == nt) && !(sz_u1? != None))) {
   If ((((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, x).BYTES|)) {
     Trap
   }
   Let b* = $nbytes_(nt, c)
   $with_mem(z, x, (i + ao.OFFSET), ($size(nt) / 8), b*)
 }
 If (type(numtype_u0) == Inn) {
   If (sz_u1? != None) {
     Let ?(n) = sz_u1?
     If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, x).BYTES|)) {
       Trap
     }
   }
   Let Inn = numtype_u0
   If (sz_u1? != None) {
     Let ?(n) = sz_u1?
     Let b* = $ibytes_(n, $wrap__($size(Inn), n, c))
     $with_mem(z, x, (i + ao.OFFSET), (n / 8), b*)
   }
 }
}

Step/vstore V128 x ao {
 Let z = current_state()
 Assert(top_value(V128))
 Pop((V128.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((((i + ao.OFFSET) + ($vsize(V128) / 8)) > |$mem(z, x).BYTES|)) {
   Trap
 }
 Let b* = $vbytes_(V128, c)
 $with_mem(z, x, (i + ao.OFFSET), ($vsize(V128) / 8), b*)
}

Step/vstore_lane V128 N x ao j {
 Let z = current_state()
 Assert(top_value(V128))
 Pop((V128.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((((i + ao.OFFSET) + N) > |$mem(z, x).BYTES|)) {
   Trap
 }
 Let M = (128 / N)
 If (type($lsize^-1(N)) == Jnn) {
   Let Jnn = $lsize^-1(N)
   If ((j < |$lanes_((Jnn X M), c)|)) {
     Let b* = $ibytes_(N, $lanes_((Jnn X M), c)[j])
     $with_mem(z, x, (i + ao.OFFSET), (N / 8), b*)
   }
 }
}

Step/memory.grow x {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Either {
   Let mi = $growmem($mem(z, x), n)
   Push((I32.CONST (|$mem(z, x).BYTES| / (64 · $Ki()))))
   $with_meminst(z, x, mi)
 }
 Or {
   Push((I32.CONST $invsigned_(32, -(1))))
 }
}

Step/data.drop x {
 Let z = current_state()
 $with_data(z, x, [])
}

eval_expr instr* {
 Execute instr*
 Pop(val)
 Return [val]
}
== Complete.
```
