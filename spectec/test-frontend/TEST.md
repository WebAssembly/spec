# Test

```sh
$ (dune exec ../src/exe-watsup/main.exe -- test.watsup -o test.tex && cat test.tex)
[elab def] def testmixfix(testmixfix) : nat*
[elab def] def testemptyv1(variant) : nat
[elab def] def testemptyv2(variant) : nat
[elab def] def testemptyv3(variant) : nat
[elab def] def testemptyv4(variant) : nat
[elab def] def testemptyv5(variant) : nat
[elab def] def testemptyv6(variant) : nat
[elab def] def testemptyn1(notation1) : nat
[elab def] def testemptyn2(notation2) : nat
[elab def] def testemptyn3(notation3) : nat
[elab def] def testemptyn4(notation4) : nat
[elab def] def testemptyn5(notation5) : nat
[elab def] def testemptyn6(notation6) : nat
$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{testmixfix}} &::=& \{{{\mathit{nat}}^\ast}\} ~|~ [{{\mathit{nat}}^\ast}] ~|~ {\mathit{nat}} \rightarrow {\mathit{nat}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testmixfix}}(\{{{\mathit{nat}}^\ast}\}) &=& {{\mathit{nat}}^\ast} &  \\
{\mathrm{testmixfix}}([{{\mathit{nat}}^\ast}]) &=& {{\mathit{nat}}^\ast} &  \\
{\mathrm{testmixfix}}({\mathit{nat}}_{{1}} \rightarrow {\mathit{nat}}_{{2}}) &=& {\mathit{nat}}_{{1}}~{\mathit{nat}}_{{2}} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{opt}} &::=& {\mathsf{o}^?} \\
& {\mathit{list}} &::=& {\mathsf{l}^\ast} \\
& {\mathit{variant}} &::=& \mathsf{v{\scriptstyle1}}~{\mathit{opt}}~{\mathit{nat}} \\ &&|&
\mathsf{v{\scriptstyle2}}~{\mathsf{o}^?}~{\mathit{nat}} \\ &&|&
\mathsf{v{\scriptstyle3}}~{{\mathit{text}}^?}~{\mathit{nat}} \\ &&|&
\mathsf{v{\scriptstyle4}}~{\mathit{list}}~{\mathit{nat}} \\ &&|&
\mathsf{v{\scriptstyle5}}~{\mathsf{l}^\ast}~{\mathit{nat}} \\ &&|&
\mathsf{v{\scriptstyle6}}~{{\mathit{text}}^\ast}~{\mathit{nat}} \\
& {\mathit{notation{\scriptstyle1}}} &::=& {\mathit{opt}}~{\mathit{nat}} \\
& {\mathit{notation{\scriptstyle2}}} &::=& {\mathsf{o}^?}~{\mathit{nat}} \\
& {\mathit{notation{\scriptstyle3}}} &::=& {{\mathit{text}}^?}~{\mathit{nat}} \\
& {\mathit{notation{\scriptstyle4}}} &::=& {\mathit{list}}~{\mathit{nat}} \\
& {\mathit{notation{\scriptstyle5}}} &::=& {\mathsf{l}^\ast}~{\mathit{nat}} \\
& {\mathit{notation{\scriptstyle6}}} &::=& {{\mathit{text}}^\ast}~{\mathit{nat}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testemptyv{\scriptstyle1}}}(\mathsf{v{\scriptstyle1}}~{\mathit{opt}}~0) &=& 0 &  \\
{\mathrm{testemptyv{\scriptstyle1}}}(\mathsf{v{\scriptstyle1}}~\epsilon~0) &=& 0 &  \\
{\mathrm{testemptyv{\scriptstyle1}}}(\mathsf{v{\scriptstyle1}}~0) &=& 0 &  \\
{\mathrm{testemptyv{\scriptstyle1}}}(\mathsf{v{\scriptstyle1}}~\mathsf{o}~0) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testemptyv{\scriptstyle2}}}(\mathsf{v{\scriptstyle2}}~\epsilon~0) &=& 0 &  \\
{\mathrm{testemptyv{\scriptstyle2}}}(\mathsf{v{\scriptstyle2}}~0) &=& 0 &  \\
{\mathrm{testemptyv{\scriptstyle2}}}(\mathsf{v{\scriptstyle2}}~\mathsf{o}~0) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testemptyv{\scriptstyle3}}}(\mathsf{v{\scriptstyle3}}~\epsilon~0) &=& 0 &  \\
{\mathrm{testemptyv{\scriptstyle3}}}(\mathsf{v{\scriptstyle3}}~0) &=& 0 &  \\
{\mathrm{testemptyv{\scriptstyle3}}}(\mathsf{v{\scriptstyle3}}~``''~0) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testemptyv{\scriptstyle4}}}(\mathsf{v{\scriptstyle4}}~{\mathit{list}}~0) &=& 0 &  \\
{\mathrm{testemptyv{\scriptstyle4}}}(\mathsf{v{\scriptstyle4}}~\epsilon~0) &=& 0 &  \\
{\mathrm{testemptyv{\scriptstyle4}}}(\mathsf{v{\scriptstyle4}}~\mathsf{l}~0) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testemptyv{\scriptstyle5}}}(\mathsf{v{\scriptstyle5}}~\epsilon~0) &=& 0 &  \\
{\mathrm{testemptyv{\scriptstyle5}}}(\mathsf{v{\scriptstyle5}}~\mathsf{l}~0) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testemptyv{\scriptstyle6}}}(\mathsf{v{\scriptstyle6}}~\epsilon~0) &=& 0 &  \\
{\mathrm{testemptyv{\scriptstyle6}}}(\mathsf{v{\scriptstyle6}}~``''~0) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testemptyn{\scriptstyle1}}}({\mathit{opt}}~0) &=& 0 &  \\
{\mathrm{testemptyn{\scriptstyle1}}}(\epsilon~0) &=& 0 &  \\
{\mathrm{testemptyn{\scriptstyle1}}}(0) &=& 0 &  \\
{\mathrm{testemptyn{\scriptstyle1}}}(\mathsf{o}~0) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testemptyn{\scriptstyle2}}}(\epsilon~0) &=& 0 &  \\
{\mathrm{testemptyn{\scriptstyle2}}}(0) &=& 0 &  \\
{\mathrm{testemptyn{\scriptstyle2}}}(\mathsf{o}~0) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testemptyn{\scriptstyle3}}}(\epsilon~0) &=& 0 &  \\
{\mathrm{testemptyn{\scriptstyle3}}}(0) &=& 0 &  \\
{\mathrm{testemptyn{\scriptstyle3}}}(``''~0) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testemptyn{\scriptstyle4}}}({\mathit{list}}~0) &=& 0 &  \\
{\mathrm{testemptyn{\scriptstyle4}}}(\epsilon~0) &=& 0 &  \\
{\mathrm{testemptyn{\scriptstyle4}}}(\mathsf{l}~0) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testemptyn{\scriptstyle5}}}(\epsilon~0) &=& 0 &  \\
{\mathrm{testemptyn{\scriptstyle5}}}(\mathsf{l}~0) &=& 0 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testemptyn{\scriptstyle6}}}(\epsilon~0) &=& 0 &  \\
{\mathrm{testemptyn{\scriptstyle6}}}(``''~0) &=& 0 &  \\
\end{array}
$$

```


# Preview

```sh
$ (cd ../spec/wasm-3.0 && dune exec ../../src/exe-watsup/main.exe -- *.watsup -v -l --print-il)
watsup 0.4 generator
== Parsing...
== Elaboration...
[elab def] def Ki : nat
[elab def] def min(nat, nat) : nat
[elab def] def sum(nat*) : nat
[elab def] def signif(N) : nat
[elab def] def expon(N) : nat
[elab def] def M(N) : nat
[elab def] def E(N) : nat
[elab def] def fzero(N) : fN(N)
[elab def] def setminus(idx*, idx*) : idx*
[elab def] def setminus1(idx, idx*) : idx*
[elab def] def free_dataidx_instr(instr) : dataidx*
[elab def] def free_dataidx_instrs(instr*) : dataidx*
[elab def] def free_dataidx_expr(expr) : dataidx*
[elab def] def free_dataidx_func(func) : dataidx*
[elab def] def free_dataidx_funcs(func*) : dataidx*
[elab def] def concat_bytes((byte*)*) : byte*
[elab def] def size(valtype) : nat
[elab def] def packedsize(packedtype) : nat
[elab def] def storagesize(storagetype) : nat
[elab def] def unpacktype(storagetype) : valtype
[elab def] def unpacknumtype(storagetype) : numtype
[elab def] def sxfield(storagetype) : sx?
[elab def] def diffrt(reftype, reftype) : reftype
[elab def] def idx(typeidx) : typevar
[elab def] def subst_typevar(typevar, typevar*, heaptype*) : heaptype
[elab def] def subst_numtype(numtype, typevar*, heaptype*) : numtype
[elab def] def subst_vectype(vectype, typevar*, heaptype*) : vectype
[elab def] def subst_heaptype(heaptype, typevar*, heaptype*) : heaptype
[elab def] def subst_reftype(reftype, typevar*, heaptype*) : reftype
[elab def] def subst_valtype(valtype, typevar*, heaptype*) : valtype
[elab def] def subst_packedtype(packedtype, typevar*, heaptype*) : packedtype
[elab def] def subst_storagetype(storagetype, typevar*, heaptype*) : storagetype
[elab def] def subst_fieldtype(fieldtype, typevar*, heaptype*) : fieldtype
[elab def] def subst_comptype(comptype, typevar*, heaptype*) : comptype
[elab def] def subst_subtype(subtype, typevar*, heaptype*) : subtype
[elab def] def subst_rectype(rectype, typevar*, heaptype*) : rectype
[elab def] def subst_deftype(deftype, typevar*, heaptype*) : deftype
[elab def] def subst_globaltype(globaltype, typevar*, heaptype*) : globaltype
[elab def] def subst_functype(functype, typevar*, heaptype*) : functype
[elab def] def subst_tabletype(tabletype, typevar*, heaptype*) : tabletype
[elab def] def subst_memtype(memtype, typevar*, heaptype*) : memtype
[elab def] def subst_externtype(externtype, typevar*, heaptype*) : externtype
[elab def] def subst_all_reftype(reftype, heaptype*) : reftype
[elab def] def subst_all_deftype(deftype, heaptype*) : deftype
[elab def] def subst_all_deftypes(deftype*, heaptype*) : deftype*
[elab def] def rollrt(typeidx, rectype) : rectype
[elab def] def unrollrt(rectype) : rectype
[elab def] def rolldt(typeidx, rectype) : deftype*
[elab def] def unrolldt(deftype) : subtype
[elab def] def expanddt(deftype) : comptype
[elab def] def funcsxt(externtype*) : deftype*
[elab def] def globalsxt(externtype*) : globaltype*
[elab def] def tablesxt(externtype*) : tabletype*
[elab def] def memsxt(externtype*) : memtype*
[elab def] def memop0 : memop
[elab def] def s33_to_u32(s33) : u32
[elab def] def signed(N, nat) : int
[elab def] def invsigned(N, int) : nat
[elab def] def unop(unop_numtype, numtype, c) : c_numtype*
[elab def] def binop(binop_numtype, numtype, c, c) : c_numtype*
[elab def] def testop(testop_numtype, numtype, c) : c_numtype
[elab def] def relop(relop_numtype, numtype, c, c) : c_numtype
[elab def] def cvtop(cvtop, numtype, numtype, sx?, c) : c_numtype*
[elab def] def wrap(nat, nat, c) : nat
[elab def] def ext(nat, nat, sx, c) : c_numtype
[elab def] def ibytes(N, iN(N)) : byte*
[elab def] def fbytes(N, fN(N)) : byte*
[elab def] def ntbytes(numtype, c) : byte*
[elab def] def ztbytes(storagetype, c) : byte*
[elab def] def invibytes(N, byte*) : iN(N)
[elab def] def invfbytes(N, byte*) : fN(N)
[elab def] def inst_reftype(moduleinst, reftype) : reftype
[elab def] def default(valtype) : val?
[elab def] def packval(storagetype, val) : fieldval
[elab def] def unpackval(storagetype, sx?, fieldval) : val
[elab def] def funcsxv(externval*) : funcaddr*
[elab def] def globalsxv(externval*) : globaladdr*
[elab def] def tablesxv(externval*) : tableaddr*
[elab def] def memsxv(externval*) : memaddr*
[elab def] def store(state) : store
[elab def] def frame(state) : frame
[elab def] def funcaddr(state) : funcaddr*
[elab def] def funcinst(state) : funcinst*
[elab def] def globalinst(state) : globalinst*
[elab def] def tableinst(state) : tableinst*
[elab def] def meminst(state) : meminst*
[elab def] def eleminst(state) : eleminst*
[elab def] def datainst(state) : datainst*
[elab def] def structinst(state) : structinst*
[elab def] def arrayinst(state) : arrayinst*
[elab def] def moduleinst(state) : moduleinst
[elab def] def type(state, typeidx) : deftype
[elab def] def func(state, funcidx) : funcinst
[elab def] def global(state, globalidx) : globalinst
[elab def] def table(state, tableidx) : tableinst
[elab def] def mem(state, memidx) : meminst
[elab def] def elem(state, tableidx) : eleminst
[elab def] def data(state, dataidx) : datainst
[elab def] def local(state, localidx) : val?
[elab def] def with_local(state, localidx, val) : state
[elab def] def with_global(state, globalidx, val) : state
[elab def] def with_table(state, tableidx, nat, ref) : state
[elab def] def with_tableinst(state, tableidx, tableinst) : state
[elab def] def with_mem(state, memidx, nat, nat, byte*) : state
[elab def] def with_meminst(state, memidx, meminst) : state
[elab def] def with_elem(state, elemidx, ref*) : state
[elab def] def with_data(state, dataidx, byte*) : state
[elab def] def with_struct(state, structaddr, nat, fieldval) : state
[elab def] def with_array(state, arrayaddr, nat, fieldval) : state
[elab def] def ext_structinst(state, structinst*) : state
[elab def] def ext_arrayinst(state, arrayinst*) : state
[elab def] def growtable(tableinst, nat, ref) : tableinst
[elab def] def growmemory(meminst, nat) : meminst
[elab def] def with_locals(context, localidx*, localtype*) : context
[elab def] def clostype(context, deftype) : deftype
[elab def] def clostypes(deftype*) : deftype*
[elab def] def before(heaptype, typeidx, nat) : bool
[elab def] def unrollht(context, heaptype) : subtype
[elab def] def in_numtype(numtype, numtype*) : bool
[elab def] def in_binop(binop_numtype, ibinop*) : bool
[elab def] def blocktype(state, blocktype) : functype
[elab def] def alloctypes(type*) : deftype*
[elab def] def allocfunc(store, moduleinst, func) : (store, funcaddr)
[elab def] def allocfuncs(store, moduleinst, func*) : (store, funcaddr*)
[elab def] def allocglobal(store, globaltype, val) : (store, globaladdr)
[elab def] def allocglobals(store, globaltype*, val*) : (store, globaladdr*)
[elab def] def alloctable(store, tabletype, ref) : (store, tableaddr)
[elab def] def alloctables(store, tabletype*, ref*) : (store, tableaddr*)
[elab def] def allocmem(store, memtype) : (store, memaddr)
[elab def] def allocmems(store, memtype*) : (store, memaddr*)
[elab def] def allocelem(store, reftype, ref*) : (store, elemaddr)
[elab def] def allocelems(store, reftype*, (ref*)*) : (store, elemaddr*)
[elab def] def allocdata(store, byte*) : (store, dataaddr)
[elab def] def allocdatas(store, (byte*)*) : (store, dataaddr*)
[elab def] def instexport(funcaddr*, globaladdr*, tableaddr*, memaddr*, export) : exportinst
[elab def] def allocmodule(store, module, externval*, val*, ref*, (ref*)*) : (store, moduleinst)
[elab def] def concat_instr((instr*)*) : instr*
[elab def] def runelem(elem, idx) : instr*
[elab def] def rundata(data, idx) : instr*
[elab def] def instantiate(store, module, externval*) : config
[elab def] def invoke(store, funcaddr, val*) : config
[elab def] def utf8(name) : byte*
[elab def] def concat_locals((local*)*) : local*

;; 0-aux.watsup:11.1-11.15
syntax N = nat

;; 0-aux.watsup:12.1-12.15
syntax M = nat

;; 0-aux.watsup:13.1-13.15
syntax n = nat

;; 0-aux.watsup:14.1-14.15
syntax m = nat

;; 0-aux.watsup:21.1-21.14
def Ki : nat
  ;; 0-aux.watsup:22.1-22.15
  def Ki = 1024

;; 0-aux.watsup:27.1-27.25
rec {

;; 0-aux.watsup:27.1-27.25
def min : (nat, nat) -> nat
  ;; 0-aux.watsup:30.1-30.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
  ;; 0-aux.watsup:29.1-29.19
  def {i : nat} min(i, 0) = 0
  ;; 0-aux.watsup:28.1-28.19
  def {j : nat} min(0, j) = 0
}

;; 0-aux.watsup:32.1-32.21
rec {

;; 0-aux.watsup:32.1-32.21
def sum : nat* -> nat
  ;; 0-aux.watsup:34.1-34.35
  def {n : n, n'* : n*} sum([n] :: n'*{n'}) = (n + $sum(n'*{n'}))
  ;; 0-aux.watsup:33.1-33.18
  def sum([]) = 0
}

;; 1-syntax.watsup:5.1-5.85
syntax char = nat

;; 1-syntax.watsup:7.1-7.38
syntax name = char*

;; 1-syntax.watsup:18.1-18.50
syntax byte = nat

;; 1-syntax.watsup:20.1-20.61
syntax uN = nat

;; 1-syntax.watsup:21.1-21.90
syntax sN = int

;; 1-syntax.watsup:22.1-22.42
syntax iN = uN

;; 1-syntax.watsup:24.1-24.20
syntax u31 = uN

;; 1-syntax.watsup:25.1-25.20
syntax u32 = uN

;; 1-syntax.watsup:26.1-26.20
syntax u64 = uN

;; 1-syntax.watsup:27.1-27.22
syntax u128 = uN

;; 1-syntax.watsup:28.1-28.20
syntax s33 = sN

;; 1-syntax.watsup:35.1-35.21
def signif : N -> nat
  ;; 1-syntax.watsup:37.1-37.21
  def signif(64) = 52
  ;; 1-syntax.watsup:36.1-36.21
  def signif(32) = 23

;; 1-syntax.watsup:39.1-39.20
def expon : N -> nat
  ;; 1-syntax.watsup:41.1-41.20
  def expon(64) = 11
  ;; 1-syntax.watsup:40.1-40.19
  def expon(32) = 8

;; 1-syntax.watsup:43.1-43.35
def M : N -> nat
  ;; 1-syntax.watsup:44.1-44.23
  def {N : N} M(N) = $signif(N)

;; 1-syntax.watsup:46.1-46.35
def E : N -> nat
  ;; 1-syntax.watsup:47.1-47.22
  def {N : N} E(N) = $expon(N)

;; 1-syntax.watsup:53.1-57.81
syntax fmag =
  |  {N : N, n : n}NORM(m, n)
    -- if (((2 - (2 ^ ($E(N) - 1))) <= n) /\ (n <= ((2 ^ ($E(N) - 1)) - 1)))
  |  {N : N, n : n}SUBNORM(m, n)
    -- if ((2 - (2 ^ ($E(N) - 1))) = n)
  | INF
  |  {N : N, n : n}NAN(n)
    -- if ((1 <= n) /\ (n < $M(N)))

;; 1-syntax.watsup:49.1-51.34
syntax fN =
  | POS(fmag)
  | NEG(fmag)

;; 1-syntax.watsup:59.1-59.40
def fzero : N -> fN
  ;; 1-syntax.watsup:60.1-60.31
  def {N : N} fzero(N) = POS_fN(NORM_fmag(0, 0))

;; 1-syntax.watsup:62.1-62.20
syntax f32 = fN

;; 1-syntax.watsup:63.1-63.20
syntax f64 = fN

;; 1-syntax.watsup:70.1-70.36
syntax idx = u32

;; 1-syntax.watsup:72.1-72.45
syntax typeidx = idx

;; 1-syntax.watsup:73.1-73.49
syntax funcidx = idx

;; 1-syntax.watsup:74.1-74.49
syntax globalidx = idx

;; 1-syntax.watsup:75.1-75.47
syntax tableidx = idx

;; 1-syntax.watsup:76.1-76.46
syntax memidx = idx

;; 1-syntax.watsup:77.1-77.45
syntax elemidx = idx

;; 1-syntax.watsup:78.1-78.45
syntax dataidx = idx

;; 1-syntax.watsup:79.1-79.47
syntax labelidx = idx

;; 1-syntax.watsup:80.1-80.47
syntax localidx = idx

;; 1-syntax.watsup:94.1-94.19
syntax nul = `NULL%?`(()?)

;; 1-syntax.watsup:96.1-97.26
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:99.1-100.9
syntax vectype =
  | V128

;; 1-syntax.watsup:107.1-108.14
syntax absheaptype =
  | ANY
  | EQ
  | I31
  | STRUCT
  | ARRAY
  | NONE
  | FUNC
  | NOFUNC
  | EXTERN
  | NOEXTERN
  | BOT

;; 1-syntax.watsup:132.1-132.18
syntax mut = `MUT%?`(()?)

;; 1-syntax.watsup:133.1-133.20
syntax fin = `FINAL%?`(()?)

;; 1-syntax.watsup:119.1-169.54
rec {

;; 1-syntax.watsup:119.1-120.14
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | REF(nul, heaptype)
  | BOT

;; 1-syntax.watsup:126.1-127.11
syntax resulttype = valtype*

;; 1-syntax.watsup:138.1-139.25
syntax storagetype =
  | BOT
  | I32
  | I64
  | F32
  | F64
  | V128
  | REF(nul, heaptype)
  | I8
  | I16

;; 1-syntax.watsup:141.1-142.18
syntax fieldtype = `%%`(mut, storagetype)

;; 1-syntax.watsup:144.1-145.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:147.1-150.18
syntax comptype =
  | STRUCT(fieldtype*)
  | ARRAY(fieldtype)
  | FUNC(functype)

;; 1-syntax.watsup:156.1-157.17
syntax rectype =
  | REC(subtype*)

;; 1-syntax.watsup:162.1-165.12
syntax heaptype =
  | _IDX(typeidx)
  | ANY
  | EQ
  | I31
  | STRUCT
  | ARRAY
  | NONE
  | FUNC
  | NOFUNC
  | EXTERN
  | NOEXTERN
  | BOT
  | DEF(rectype, nat)
  | REC(nat)

;; 1-syntax.watsup:167.1-169.54
syntax subtype =
  | SUB(fin, typeidx*, comptype)
  | SUBD(fin, heaptype*, comptype)
}

;; 1-syntax.watsup:114.1-115.21
syntax reftype =
  | REF(nul, heaptype)

;; 1-syntax.watsup:122.1-122.40
syntax inn =
  | I32
  | I64

;; 1-syntax.watsup:123.1-123.40
syntax fnn =
  | F32
  | F64

;; 1-syntax.watsup:135.1-136.13
syntax packedtype =
  | I8
  | I16

;; 1-syntax.watsup:159.1-160.35
syntax deftype =
  | DEF(rectype, nat)

;; 1-syntax.watsup:174.1-175.16
syntax limits = `[%..%]`(u32, u32)

;; 1-syntax.watsup:177.1-178.14
syntax globaltype = `%%`(mut, valtype)

;; 1-syntax.watsup:179.1-180.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:181.1-182.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:183.1-184.10
syntax elemtype = reftype

;; 1-syntax.watsup:185.1-186.5
syntax datatype = OK

;; 1-syntax.watsup:187.1-188.69
syntax externtype =
  | FUNC(deftype)
  | GLOBAL(globaltype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:223.1-223.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:225.1-225.36
syntax iunop =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:226.1-226.67
syntax funop =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:228.1-230.66
syntax ibinop =
  | ADD
  | SUB
  | MUL
  | DIV(sx)
  | REM(sx)
  | AND
  | OR
  | XOR
  | SHL
  | SHR(sx)
  | ROTL
  | ROTR

;; 1-syntax.watsup:231.1-231.63
syntax fbinop =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:233.1-233.23
syntax itestop =
  | EQZ

;; 1-syntax.watsup:234.1-234.19
syntax ftestop =
  |

;; 1-syntax.watsup:236.1-237.112
syntax irelop =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:238.1-238.46
syntax frelop =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:241.1-241.44
syntax unop_numtype =
  | _I(iunop)
  | _F(funop)

;; 1-syntax.watsup:242.1-242.47
syntax binop_numtype =
  | _I(ibinop)
  | _F(fbinop)

;; 1-syntax.watsup:243.1-243.50
syntax testop_numtype =
  | _I(itestop)
  | _F(ftestop)

;; 1-syntax.watsup:244.1-244.47
syntax relop_numtype =
  | _I(irelop)
  | _F(frelop)

;; 1-syntax.watsup:245.1-245.53
syntax cvtop =
  | CONVERT
  | REINTERPRET
  | CONVERT_SAT

;; 1-syntax.watsup:253.1-253.68
syntax memop = {ALIGN u32, OFFSET u32}

;; 1-syntax.watsup:263.1-263.15
syntax c = nat

;; 1-syntax.watsup:264.1-264.23
syntax c_numtype = nat

;; 1-syntax.watsup:265.1-265.23
syntax c_vectype = nat

;; 1-syntax.watsup:267.1-269.17
syntax blocktype =
  | _RESULT(valtype?)
  | _IDX(funcidx)

;; 1-syntax.watsup:362.1-370.89
rec {

;; 1-syntax.watsup:362.1-370.89
syntax instr =
  | UNREACHABLE
  | NOP
  | DROP
  | SELECT(valtype*?)
  | BLOCK(blocktype, instr*)
  | LOOP(blocktype, instr*)
  | IF(blocktype, instr*, instr*)
  | BR(labelidx)
  | BR_IF(labelidx)
  | BR_TABLE(labelidx*, labelidx)
  | BR_ON_NULL(labelidx)
  | BR_ON_NON_NULL(labelidx)
  | BR_ON_CAST(labelidx, reftype, reftype)
  | BR_ON_CAST_FAIL(labelidx, reftype, reftype)
  | CALL(funcidx)
  | CALL_REF(typeidx?)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | RETURN_CALL(funcidx)
  | RETURN_CALL_REF(typeidx?)
  | RETURN_CALL_INDIRECT(tableidx, typeidx)
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(heaptype)
  | REF.I31
  | REF.FUNC(funcidx)
  | REF.IS_NULL
  | REF.AS_NON_NULL
  | REF.EQ
  | REF.TEST(reftype)
  | REF.CAST(reftype)
  | I31.GET(sx)
  | STRUCT.NEW(typeidx)
  | STRUCT.NEW_DEFAULT(typeidx)
  | STRUCT.GET(sx?, typeidx, u32)
  | STRUCT.SET(typeidx, u32)
  | ARRAY.NEW(typeidx)
  | ARRAY.NEW_DEFAULT(typeidx)
  | ARRAY.NEW_FIXED(typeidx, nat)
  | ARRAY.NEW_DATA(typeidx, dataidx)
  | ARRAY.NEW_ELEM(typeidx, elemidx)
  | ARRAY.GET(sx?, typeidx)
  | ARRAY.SET(typeidx)
  | ARRAY.LEN
  | ARRAY.FILL(typeidx)
  | ARRAY.COPY(typeidx, typeidx)
  | ARRAY.INIT_DATA(typeidx, dataidx)
  | ARRAY.INIT_ELEM(typeidx, elemidx)
  | EXTERN.CONVERT_ANY
  | ANY.CONVERT_EXTERN
  | LOCAL.GET(localidx)
  | LOCAL.SET(localidx)
  | LOCAL.TEE(localidx)
  | GLOBAL.GET(globalidx)
  | GLOBAL.SET(globalidx)
  | TABLE.GET(tableidx)
  | TABLE.SET(tableidx)
  | TABLE.SIZE(tableidx)
  | TABLE.GROW(tableidx)
  | TABLE.FILL(tableidx)
  | TABLE.COPY(tableidx, tableidx)
  | TABLE.INIT(tableidx, elemidx)
  | ELEM.DROP(elemidx)
  | MEMORY.SIZE(memidx)
  | MEMORY.GROW(memidx)
  | MEMORY.FILL(memidx)
  | MEMORY.COPY(memidx, memidx)
  | MEMORY.INIT(memidx, dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memidx, memop)
  | STORE(numtype, n?, memidx, memop)
}

;; 1-syntax.watsup:372.1-373.9
syntax expr = instr*

;; 1-syntax.watsup:385.1-385.61
syntax elemmode =
  | ACTIVE(tableidx, expr)
  | PASSIVE
  | DECLARE

;; 1-syntax.watsup:386.1-386.49
syntax datamode =
  | ACTIVE(memidx, expr)
  | PASSIVE

;; 1-syntax.watsup:388.1-389.15
syntax type = TYPE(rectype)

;; 1-syntax.watsup:390.1-391.16
syntax local = LOCAL(valtype)

;; 1-syntax.watsup:392.1-393.27
syntax func = `FUNC%%*%`(typeidx, local*, expr)

;; 1-syntax.watsup:394.1-395.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:396.1-397.23
syntax table = TABLE(tabletype, expr)

;; 1-syntax.watsup:398.1-399.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:400.1-401.30
syntax elem = `ELEM%%*%`(reftype, expr*, elemmode)

;; 1-syntax.watsup:402.1-403.22
syntax data = `DATA%*%`(byte*, datamode)

;; 1-syntax.watsup:404.1-405.16
syntax start = START(funcidx)

;; 1-syntax.watsup:407.1-408.66
syntax externidx =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:409.1-410.24
syntax export = EXPORT(name, externidx)

;; 1-syntax.watsup:411.1-412.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:414.1-415.76
syntax module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*, import*, func*, global*, table*, mem*, elem*, data*, start*, export*)

;; 2-syntax-aux.watsup:8.1-8.33
rec {

;; 2-syntax-aux.watsup:8.1-8.33
def setminus1 : (idx, idx*) -> idx*
  ;; 2-syntax-aux.watsup:15.1-15.60
  def {x : idx, y* : idx*, y_1 : idx} setminus1(x, [y_1] :: y*{y}) = $setminus1(x, y*{y})
    -- otherwise
  ;; 2-syntax-aux.watsup:14.1-14.61
  def {x : idx, y* : idx*, y_1 : idx} setminus1(x, [y_1] :: y*{y}) = []
    -- if (x = y_1)
  ;; 2-syntax-aux.watsup:13.1-13.27
  def {x : idx} setminus1(x, []) = [x]
}

;; 2-syntax-aux.watsup:7.1-7.49
rec {

;; 2-syntax-aux.watsup:7.1-7.49
def setminus : (idx*, idx*) -> idx*
  ;; 2-syntax-aux.watsup:11.1-11.66
  def {x* : idx*, x_1 : idx, y* : idx*} setminus([x_1] :: x*{x}, y*{y}) = $setminus1(x_1, y*{y}) :: $setminus(x*{x}, y*{y})
  ;; 2-syntax-aux.watsup:10.1-10.29
  def {y* : idx*} setminus([], y*{y}) = []
}

;; 2-syntax-aux.watsup:20.1-20.71
def free_dataidx_instr : instr -> dataidx*
  ;; 2-syntax-aux.watsup:23.1-23.34
  def {in : instr} free_dataidx_instr(in) = []
  ;; 2-syntax-aux.watsup:22.1-22.41
  def {x : idx} free_dataidx_instr(DATA.DROP_instr(x)) = [x]
  ;; 2-syntax-aux.watsup:21.1-21.45
  def {x : idx, y : idx} free_dataidx_instr(MEMORY.INIT_instr(x, y)) = [y]

;; 2-syntax-aux.watsup:25.1-25.73
rec {

;; 2-syntax-aux.watsup:25.1-25.73
def free_dataidx_instrs : instr* -> dataidx*
  ;; 2-syntax-aux.watsup:27.1-27.99
  def {instr : instr, instr'* : instr*} free_dataidx_instrs([instr] :: instr'*{instr'}) = $free_dataidx_instr(instr) :: $free_dataidx_instrs(instr'*{instr'})
  ;; 2-syntax-aux.watsup:26.1-26.36
  def free_dataidx_instrs([]) = []
}

;; 2-syntax-aux.watsup:29.1-29.69
def free_dataidx_expr : expr -> dataidx*
  ;; 2-syntax-aux.watsup:30.1-30.56
  def {in* : instr*} free_dataidx_expr(in*{in}) = $free_dataidx_instrs(in*{in})

;; 2-syntax-aux.watsup:32.1-32.69
def free_dataidx_func : func -> dataidx*
  ;; 2-syntax-aux.watsup:33.1-33.62
  def {e : expr, loc* : local*, x : idx} free_dataidx_func(`FUNC%%*%`(x, loc*{loc}, e)) = $free_dataidx_expr(e)

;; 2-syntax-aux.watsup:35.1-35.71
rec {

;; 2-syntax-aux.watsup:35.1-35.71
def free_dataidx_funcs : func* -> dataidx*
  ;; 2-syntax-aux.watsup:37.1-37.92
  def {func : func, func'* : func*} free_dataidx_funcs([func] :: func'*{func'}) = $free_dataidx_func(func) :: $free_dataidx_funcs(func'*{func'})
  ;; 2-syntax-aux.watsup:36.1-36.35
  def free_dataidx_funcs([]) = []
}

;; 2-syntax-aux.watsup:46.1-46.59
rec {

;; 2-syntax-aux.watsup:46.1-46.59
def concat_bytes : byte** -> byte*
  ;; 2-syntax-aux.watsup:48.1-48.58
  def {b* : byte*, b'** : byte**} concat_bytes([b*{b}] :: b'*{b'}*{b'}) = b*{b} :: $concat_bytes(b'*{b'}*{b'})
  ;; 2-syntax-aux.watsup:47.1-47.29
  def concat_bytes([]) = []
}

;; 2-syntax-aux.watsup:59.1-59.55
def size : valtype -> nat
  ;; 2-syntax-aux.watsup:64.1-64.22
  def size(V128_valtype) = 128
  ;; 2-syntax-aux.watsup:63.1-63.20
  def size(F64_valtype) = 64
  ;; 2-syntax-aux.watsup:62.1-62.20
  def size(F32_valtype) = 32
  ;; 2-syntax-aux.watsup:61.1-61.20
  def size(I64_valtype) = 64
  ;; 2-syntax-aux.watsup:60.1-60.20
  def size(I32_valtype) = 32

;; 2-syntax-aux.watsup:66.1-66.50
def packedsize : packedtype -> nat
  ;; 2-syntax-aux.watsup:68.1-68.26
  def packedsize(I16_packedtype) = 16
  ;; 2-syntax-aux.watsup:67.1-67.24
  def packedsize(I8_packedtype) = 8

;; 2-syntax-aux.watsup:70.1-70.52
def storagesize : storagetype -> nat
  ;; 2-syntax-aux.watsup:72.1-72.55
  def {packedtype : packedtype} storagesize(packedtype <: storagetype) = $packedsize(packedtype)
  ;; 2-syntax-aux.watsup:71.1-71.43
  def {valtype : valtype} storagesize(valtype <: storagetype) = $size(valtype)

;; 2-syntax-aux.watsup:77.1-77.62
def unpacktype : storagetype -> valtype
  ;; 2-syntax-aux.watsup:79.1-79.34
  def {packedtype : packedtype} unpacktype(packedtype <: storagetype) = I32_valtype
  ;; 2-syntax-aux.watsup:78.1-78.35
  def {valtype : valtype} unpacktype(valtype <: storagetype) = valtype

;; 2-syntax-aux.watsup:81.1-81.65
def unpacknumtype : storagetype -> numtype
  ;; 2-syntax-aux.watsup:83.1-83.37
  def {packedtype : packedtype} unpacknumtype(packedtype <: storagetype) = I32_numtype
  ;; 2-syntax-aux.watsup:82.1-82.38
  def {numtype : numtype} unpacknumtype(numtype <: storagetype) = numtype

;; 2-syntax-aux.watsup:85.1-85.51
def sxfield : storagetype -> sx?
  ;; 2-syntax-aux.watsup:87.1-87.29
  def {packedtype : packedtype} sxfield(packedtype <: storagetype) = ?(S_sx)
  ;; 2-syntax-aux.watsup:86.1-86.28
  def {valtype : valtype} sxfield(valtype <: storagetype) = ?()

;; 2-syntax-aux.watsup:92.1-92.59
def diffrt : (reftype, reftype) -> reftype
  ;; 2-syntax-aux.watsup:95.1-95.65
  def {ht_1 : heaptype, ht_2 : heaptype, nul_1 : nul} diffrt(REF_reftype(nul_1, ht_1), REF_reftype(`NULL%?`(?()), ht_2)) = REF_reftype(nul_1, ht_1)
  ;; 2-syntax-aux.watsup:94.1-94.64
  def {ht_1 : heaptype, ht_2 : heaptype, nul_1 : nul} diffrt(REF_reftype(nul_1, ht_1), REF_reftype(`NULL%?`(?(())), ht_2)) = REF_reftype(`NULL%?`(?()), ht_1)

;; 2-syntax-aux.watsup:100.1-100.42
syntax typevar =
  | _IDX(typeidx)
  | REC(nat)

;; 2-syntax-aux.watsup:103.1-103.42
def idx : typeidx -> typevar
  ;; 2-syntax-aux.watsup:104.1-104.21
  def {x : idx} idx(x) = _IDX_typevar(x)

;; 2-syntax-aux.watsup:109.1-109.92
rec {

;; 2-syntax-aux.watsup:109.1-109.92
def subst_typevar : (typevar, typevar*, heaptype*) -> heaptype
  ;; 2-syntax-aux.watsup:136.1-136.92
  def {ht'* : heaptype*, ht_1 : heaptype, xx : typevar, xx'* : typevar*, xx_1 : typevar} subst_typevar(xx, [xx_1] :: xx'*{xx'}, [ht_1] :: ht'*{ht'}) = $subst_typevar(xx, xx'*{xx'}, ht'*{ht'})
    -- otherwise
  ;; 2-syntax-aux.watsup:135.1-135.95
  def {ht'* : heaptype*, ht_1 : heaptype, xx : typevar, xx'* : typevar*, xx_1 : typevar} subst_typevar(xx, [xx_1] :: xx'*{xx'}, [ht_1] :: ht'*{ht'}) = ht_1
    -- if (xx = xx_1)
  ;; 2-syntax-aux.watsup:134.1-134.38
  def {xx : typevar} subst_typevar(xx, [], []) = (xx <: heaptype)
}

;; 2-syntax-aux.watsup:111.1-111.92
def subst_numtype : (numtype, typevar*, heaptype*) -> numtype
  ;; 2-syntax-aux.watsup:138.1-138.38
  def {ht* : heaptype*, nt : numtype, xx* : typevar*} subst_numtype(nt, xx*{xx}, ht*{ht}) = nt

;; 2-syntax-aux.watsup:112.1-112.92
def subst_vectype : (vectype, typevar*, heaptype*) -> vectype
  ;; 2-syntax-aux.watsup:139.1-139.38
  def {ht* : heaptype*, vt : vectype, xx* : typevar*} subst_vectype(vt, xx*{xx}, ht*{ht}) = vt

;; 2-syntax-aux.watsup:117.1-117.92
def subst_packedtype : (packedtype, typevar*, heaptype*) -> packedtype
  ;; 2-syntax-aux.watsup:152.1-152.41
  def {ht* : heaptype*, pt : packedtype, xx* : typevar*} subst_packedtype(pt, xx*{xx}, ht*{ht}) = pt

;; 2-syntax-aux.watsup:113.1-127.92
rec {

;; 2-syntax-aux.watsup:113.1-113.92
def subst_heaptype : (heaptype, typevar*, heaptype*) -> heaptype
  ;; 2-syntax-aux.watsup:143.1-143.55
  def {ht* : heaptype*, ht' : heaptype, xx* : typevar*} subst_heaptype(ht', xx*{xx}, ht*{ht}) = ht'
    -- otherwise
  ;; 2-syntax-aux.watsup:142.1-142.65
  def {dt : deftype, ht* : heaptype*, xx* : typevar*} subst_heaptype((dt <: heaptype), xx*{xx}, ht*{ht}) = ($subst_deftype(dt, xx*{xx}, ht*{ht}) <: heaptype)
  ;; 2-syntax-aux.watsup:141.1-141.67
  def {ht* : heaptype*, xx* : typevar*, xx' : typevar} subst_heaptype((xx' <: heaptype), xx*{xx}, ht*{ht}) = $subst_typevar(xx', xx*{xx}, ht*{ht})

;; 2-syntax-aux.watsup:114.1-114.92
def subst_reftype : (reftype, typevar*, heaptype*) -> reftype
  ;; 2-syntax-aux.watsup:145.1-145.85
  def {ht* : heaptype*, ht' : heaptype, nul : nul, xx* : typevar*} subst_reftype(REF_reftype(nul, ht'), xx*{xx}, ht*{ht}) = REF_reftype(nul, $subst_heaptype(ht', xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:115.1-115.92
def subst_valtype : (valtype, typevar*, heaptype*) -> valtype
  ;; 2-syntax-aux.watsup:150.1-150.40
  def {ht* : heaptype*, xx* : typevar*} subst_valtype(BOT_valtype, xx*{xx}, ht*{ht}) = BOT_valtype
  ;; 2-syntax-aux.watsup:149.1-149.64
  def {ht* : heaptype*, rt : reftype, xx* : typevar*} subst_valtype((rt <: valtype), xx*{xx}, ht*{ht}) = ($subst_reftype(rt, xx*{xx}, ht*{ht}) <: valtype)
  ;; 2-syntax-aux.watsup:148.1-148.64
  def {ht* : heaptype*, vt : vectype, xx* : typevar*} subst_valtype((vt <: valtype), xx*{xx}, ht*{ht}) = ($subst_vectype(vt, xx*{xx}, ht*{ht}) <: valtype)
  ;; 2-syntax-aux.watsup:147.1-147.64
  def {ht* : heaptype*, nt : numtype, xx* : typevar*} subst_valtype((nt <: valtype), xx*{xx}, ht*{ht}) = ($subst_numtype(nt, xx*{xx}, ht*{ht}) <: valtype)

;; 2-syntax-aux.watsup:118.1-118.92
def subst_storagetype : (storagetype, typevar*, heaptype*) -> storagetype
  ;; 2-syntax-aux.watsup:155.1-155.71
  def {ht* : heaptype*, pt : packedtype, xx* : typevar*} subst_storagetype((pt <: storagetype), xx*{xx}, ht*{ht}) = ($subst_packedtype(pt, xx*{xx}, ht*{ht}) <: storagetype)
  ;; 2-syntax-aux.watsup:154.1-154.66
  def {ht* : heaptype*, t : valtype, xx* : typevar*} subst_storagetype((t <: storagetype), xx*{xx}, ht*{ht}) = ($subst_valtype(t, xx*{xx}, ht*{ht}) <: storagetype)

;; 2-syntax-aux.watsup:119.1-119.92
def subst_fieldtype : (fieldtype, typevar*, heaptype*) -> fieldtype
  ;; 2-syntax-aux.watsup:157.1-157.80
  def {ht* : heaptype*, mut : mut, xx* : typevar*, zt : storagetype} subst_fieldtype(`%%`(mut, zt), xx*{xx}, ht*{ht}) = `%%`(mut, $subst_storagetype(zt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:121.1-121.92
def subst_comptype : (comptype, typevar*, heaptype*) -> comptype
  ;; 2-syntax-aux.watsup:161.1-161.78
  def {ft : functype, ht* : heaptype*, xx* : typevar*} subst_comptype(FUNC_comptype(ft), xx*{xx}, ht*{ht}) = FUNC_comptype($subst_functype(ft, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:160.1-160.81
  def {ht* : heaptype*, xx* : typevar*, yt : fieldtype} subst_comptype(ARRAY_comptype(yt), xx*{xx}, ht*{ht}) = ARRAY_comptype($subst_fieldtype(yt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:159.1-159.85
  def {ht* : heaptype*, xx* : typevar*, yt* : fieldtype*} subst_comptype(STRUCT_comptype(yt*{yt}), xx*{xx}, ht*{ht}) = STRUCT_comptype($subst_fieldtype(yt, xx*{xx}, ht*{ht})*{yt})

;; 2-syntax-aux.watsup:122.1-122.92
def subst_subtype : (subtype, typevar*, heaptype*) -> subtype
  ;; 2-syntax-aux.watsup:165.1-166.73
  def {ct : comptype, fin : fin, ht* : heaptype*, ht'* : heaptype*, xx* : typevar*} subst_subtype(SUBD_subtype(fin, ht'*{ht'}, ct), xx*{xx}, ht*{ht}) = SUBD_subtype(fin, $subst_heaptype(ht', xx*{xx}, ht*{ht})*{ht'}, $subst_comptype(ct, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:163.1-164.76
  def {ct : comptype, fin : fin, ht* : heaptype*, xx* : typevar*, y* : idx*} subst_subtype(SUB_subtype(fin, y*{y}, ct), xx*{xx}, ht*{ht}) = SUBD_subtype(fin, $subst_heaptype(_IDX_heaptype(y), xx*{xx}, ht*{ht})*{y}, $subst_comptype(ct, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:123.1-123.92
def subst_rectype : (rectype, typevar*, heaptype*) -> rectype
  ;; 2-syntax-aux.watsup:168.1-168.76
  def {ht* : heaptype*, st* : subtype*, xx* : typevar*} subst_rectype(REC_rectype(st*{st}), xx*{xx}, ht*{ht}) = REC_rectype($subst_subtype(st, xx*{xx}, ht*{ht})*{st})

;; 2-syntax-aux.watsup:124.1-124.92
def subst_deftype : (deftype, typevar*, heaptype*) -> deftype
  ;; 2-syntax-aux.watsup:170.1-170.78
  def {ht* : heaptype*, i : nat, qt : rectype, xx* : typevar*} subst_deftype(DEF_deftype(qt, i), xx*{xx}, ht*{ht}) = DEF_deftype($subst_rectype(qt, xx*{xx}, ht*{ht}), i)

;; 2-syntax-aux.watsup:127.1-127.92
def subst_functype : (functype, typevar*, heaptype*) -> functype
  ;; 2-syntax-aux.watsup:173.1-173.113
  def {ht* : heaptype*, t_1* : valtype*, t_2* : valtype*, xx* : typevar*} subst_functype(`%->%`(t_1*{t_1}, t_2*{t_2}), xx*{xx}, ht*{ht}) = `%->%`($subst_valtype(t_1, xx*{xx}, ht*{ht})*{t_1}, $subst_valtype(t_2, xx*{xx}, ht*{ht})*{t_2})
}

;; 2-syntax-aux.watsup:126.1-126.92
def subst_globaltype : (globaltype, typevar*, heaptype*) -> globaltype
  ;; 2-syntax-aux.watsup:172.1-172.75
  def {ht* : heaptype*, mut : mut, t : valtype, xx* : typevar*} subst_globaltype(`%%`(mut, t), xx*{xx}, ht*{ht}) = `%%`(mut, $subst_valtype(t, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:128.1-128.92
def subst_tabletype : (tabletype, typevar*, heaptype*) -> tabletype
  ;; 2-syntax-aux.watsup:175.1-175.76
  def {ht* : heaptype*, lim : limits, rt : reftype, xx* : typevar*} subst_tabletype(`%%`(lim, rt), xx*{xx}, ht*{ht}) = `%%`(lim, $subst_reftype(rt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:129.1-129.92
def subst_memtype : (memtype, typevar*, heaptype*) -> memtype
  ;; 2-syntax-aux.watsup:174.1-174.48
  def {ht* : heaptype*, lim : limits, xx* : typevar*} subst_memtype(`%I8`(lim), xx*{xx}, ht*{ht}) = `%I8`(lim)

;; 2-syntax-aux.watsup:131.1-131.92
def subst_externtype : (externtype, typevar*, heaptype*) -> externtype
  ;; 2-syntax-aux.watsup:180.1-180.77
  def {ht* : heaptype*, mt : memtype, xx* : typevar*} subst_externtype(MEM_externtype(mt), xx*{xx}, ht*{ht}) = MEM_externtype($subst_memtype(mt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:179.1-179.83
  def {ht* : heaptype*, tt : tabletype, xx* : typevar*} subst_externtype(TABLE_externtype(tt), xx*{xx}, ht*{ht}) = TABLE_externtype($subst_tabletype(tt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:178.1-178.86
  def {gt : globaltype, ht* : heaptype*, xx* : typevar*} subst_externtype(GLOBAL_externtype(gt), xx*{xx}, ht*{ht}) = GLOBAL_externtype($subst_globaltype(gt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:177.1-177.79
  def {dt : deftype, ht* : heaptype*, xx* : typevar*} subst_externtype(FUNC_externtype(dt), xx*{xx}, ht*{ht}) = FUNC_externtype($subst_deftype(dt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:183.1-183.74
def subst_all_reftype : (reftype, heaptype*) -> reftype
  ;; 2-syntax-aux.watsup:186.1-186.75
  def {ht^n : heaptype^n, n : n, rt : reftype, x^n : idx^n} subst_all_reftype(rt, ht^n{ht}) = $subst_reftype(rt, $idx(x)^(x<n){x}, ht^n{ht})

;; 2-syntax-aux.watsup:184.1-184.74
def subst_all_deftype : (deftype, heaptype*) -> deftype
  ;; 2-syntax-aux.watsup:187.1-187.75
  def {dt : deftype, ht^n : heaptype^n, n : n, x^n : idx^n} subst_all_deftype(dt, ht^n{ht}) = $subst_deftype(dt, $idx(x)^(x<n){x}, ht^n{ht})

;; 2-syntax-aux.watsup:189.1-189.77
rec {

;; 2-syntax-aux.watsup:189.1-189.77
def subst_all_deftypes : (deftype*, heaptype*) -> deftype*
  ;; 2-syntax-aux.watsup:192.1-192.101
  def {dt* : deftype*, dt_1 : deftype, ht* : heaptype*} subst_all_deftypes([dt_1] :: dt*{dt}, ht*{ht}) = [$subst_all_deftype(dt_1, ht*{ht})] :: $subst_all_deftypes(dt*{dt}, ht*{ht})
  ;; 2-syntax-aux.watsup:191.1-191.40
  def {ht* : heaptype*} subst_all_deftypes([], ht*{ht}) = []
}

;; 2-syntax-aux.watsup:197.1-197.65
def rollrt : (typeidx, rectype) -> rectype
  ;; 2-syntax-aux.watsup:206.1-206.93
  def {i^n^n : nat^n^n, n : n, st^n : subtype^n, x : idx} rollrt(x, REC_rectype(st^n{st})) = REC_rectype($subst_subtype(st, $idx(x + i)^(i<n){i}, REC_heaptype(i)^(i<n){i})^n{i st})

;; 2-syntax-aux.watsup:198.1-198.63
def unrollrt : rectype -> rectype
  ;; 2-syntax-aux.watsup:207.1-208.22
  def {i^n^n : nat^n^n, n : n, qt : rectype, st^n : subtype^n} unrollrt(REC_rectype(st^n{st})) = REC_rectype($subst_subtype(st, REC_typevar(i)^(i<n){i}, DEF_heaptype(qt, i)^(i<n){i})^n{i st})
    -- if (qt = REC_rectype(st^n{st}))

;; 2-syntax-aux.watsup:199.1-199.65
def rolldt : (typeidx, rectype) -> deftype*
  ;; 2-syntax-aux.watsup:210.1-210.79
  def {i^n : nat^n, n : n, qt : rectype, st^n : subtype^n, x : idx} rolldt(x, qt) = DEF_deftype(REC_rectype(st^n{st}), i)^(i<n){i}
    -- if ($rollrt(x, qt) = REC_rectype(st^n{st}))

;; 2-syntax-aux.watsup:200.1-200.63
def unrolldt : deftype -> subtype
  ;; 2-syntax-aux.watsup:211.1-211.77
  def {i : nat, qt : rectype, st* : subtype*} unrolldt(DEF_deftype(qt, i)) = st*{st}[i]
    -- if ($unrollrt(qt) = REC_rectype(st*{st}))

;; 2-syntax-aux.watsup:201.1-201.63
def expanddt : deftype -> comptype
  ;; 2-syntax-aux.watsup:213.1-213.85
  def {ct : comptype, dt : deftype, fin : fin, ht* : heaptype*} expanddt(dt) = ct
    -- if ($unrolldt(dt) = SUBD_subtype(fin, ht*{ht}, ct))

;; 2-syntax-aux.watsup:215.1-215.37
relation Expand: `%~~%`(deftype, comptype)
  ;; 2-syntax-aux.watsup:216.1-216.72
  rule _ {ct : comptype, dt : deftype}:
    `%~~%`(dt, ct)
    -- if ($expanddt(dt) = ct)

;; 2-syntax-aux.watsup:221.1-221.64
rec {

;; 2-syntax-aux.watsup:221.1-221.64
def funcsxt : externtype* -> deftype*
  ;; 2-syntax-aux.watsup:228.1-228.59
  def {et* : externtype*, externtype : externtype} funcsxt([externtype] :: et*{et}) = $funcsxt(et*{et})
    -- otherwise
  ;; 2-syntax-aux.watsup:227.1-227.47
  def {dt : deftype, et* : externtype*} funcsxt([FUNC_externtype(dt)] :: et*{et}) = [dt] :: $funcsxt(et*{et})
  ;; 2-syntax-aux.watsup:226.1-226.24
  def funcsxt([]) = []
}

;; 2-syntax-aux.watsup:222.1-222.66
rec {

;; 2-syntax-aux.watsup:222.1-222.66
def globalsxt : externtype* -> globaltype*
  ;; 2-syntax-aux.watsup:232.1-232.63
  def {et* : externtype*, externtype : externtype} globalsxt([externtype] :: et*{et}) = $globalsxt(et*{et})
    -- otherwise
  ;; 2-syntax-aux.watsup:231.1-231.53
  def {et* : externtype*, gt : globaltype} globalsxt([GLOBAL_externtype(gt)] :: et*{et}) = [gt] :: $globalsxt(et*{et})
  ;; 2-syntax-aux.watsup:230.1-230.26
  def globalsxt([]) = []
}

;; 2-syntax-aux.watsup:223.1-223.65
rec {

;; 2-syntax-aux.watsup:223.1-223.65
def tablesxt : externtype* -> tabletype*
  ;; 2-syntax-aux.watsup:236.1-236.61
  def {et* : externtype*, externtype : externtype} tablesxt([externtype] :: et*{et}) = $tablesxt(et*{et})
    -- otherwise
  ;; 2-syntax-aux.watsup:235.1-235.50
  def {et* : externtype*, tt : tabletype} tablesxt([TABLE_externtype(tt)] :: et*{et}) = [tt] :: $tablesxt(et*{et})
  ;; 2-syntax-aux.watsup:234.1-234.25
  def tablesxt([]) = []
}

;; 2-syntax-aux.watsup:224.1-224.63
rec {

;; 2-syntax-aux.watsup:224.1-224.63
def memsxt : externtype* -> memtype*
  ;; 2-syntax-aux.watsup:240.1-240.57
  def {et* : externtype*, externtype : externtype} memsxt([externtype] :: et*{et}) = $memsxt(et*{et})
    -- otherwise
  ;; 2-syntax-aux.watsup:239.1-239.44
  def {et* : externtype*, mt : memtype} memsxt([MEM_externtype(mt)] :: et*{et}) = [mt] :: $memsxt(et*{et})
  ;; 2-syntax-aux.watsup:238.1-238.23
  def memsxt([]) = []
}

;; 2-syntax-aux.watsup:249.1-249.33
def memop0 : memop
  ;; 2-syntax-aux.watsup:250.1-250.34
  def memop0 = {ALIGN 0, OFFSET 0}

;; 3-numerics.watsup:7.1-7.41
def s33_to_u32 : s33 -> u32

;; 3-numerics.watsup:12.1-12.57
def signed : (N, nat) -> int
  ;; 3-numerics.watsup:14.1-14.60
  def {N : N, i : nat} signed(N, i) = ((i - (2 ^ N)) <: int)
    -- if (((2 ^ (N - 1)) <= i) /\ (i < (2 ^ N)))
  ;; 3-numerics.watsup:13.1-13.54
  def {N : N, i : nat} signed(N, i) = (i <: int)
    -- if (0 <= (2 ^ (N - 1)))

;; 3-numerics.watsup:16.1-16.63
def invsigned : (N, int) -> nat
  ;; 3-numerics.watsup:17.1-17.56
  def {N : N, i : nat, j : nat} invsigned(N, (i <: int)) = j
    -- if ($signed(N, j) = (i <: int))

;; 3-numerics.watsup:22.1-22.79
def unop : (unop_numtype, numtype, c) -> c_numtype*

;; 3-numerics.watsup:23.1-23.80
def binop : (binop_numtype, numtype, c, c) -> c_numtype*

;; 3-numerics.watsup:24.1-24.79
def testop : (testop_numtype, numtype, c) -> c_numtype

;; 3-numerics.watsup:25.1-25.80
def relop : (relop_numtype, numtype, c, c) -> c_numtype

;; 3-numerics.watsup:26.1-26.90
def cvtop : (cvtop, numtype, numtype, sx?, c) -> c_numtype*

;; 3-numerics.watsup:28.1-28.88
def wrap : (nat, nat, c) -> nat

;; 3-numerics.watsup:29.1-29.91
def ext : (nat, nat, sx, c) -> c_numtype

;; 3-numerics.watsup:31.1-31.64
def ibytes : (N, iN) -> byte*

;; 3-numerics.watsup:32.1-32.64
def fbytes : (N, fN) -> byte*

;; 3-numerics.watsup:33.1-33.62
def ntbytes : (numtype, c) -> byte*

;; 3-numerics.watsup:34.1-34.62
def ztbytes : (storagetype, c) -> byte*

;; 3-numerics.watsup:36.1-36.33
def invibytes : (N, byte*) -> iN
  ;; 3-numerics.watsup:39.1-39.52
  def {N : N, b* : byte*, n : n} invibytes(N, b*{b}) = n
    -- if ($ibytes(N, n) = b*{b})

;; 3-numerics.watsup:37.1-37.33
def invfbytes : (N, byte*) -> fN
  ;; 3-numerics.watsup:40.1-40.52
  def {N : N, b* : byte*, p : fN} invfbytes(N, b*{b}) = p
    -- if ($fbytes(N, p) = b*{b})

;; 4-runtime.watsup:5.1-5.39
syntax addr = nat

;; 4-runtime.watsup:6.1-6.53
syntax funcaddr = addr

;; 4-runtime.watsup:7.1-7.53
syntax globaladdr = addr

;; 4-runtime.watsup:8.1-8.51
syntax tableaddr = addr

;; 4-runtime.watsup:9.1-9.50
syntax memaddr = addr

;; 4-runtime.watsup:10.1-10.49
syntax elemaddr = addr

;; 4-runtime.watsup:11.1-11.49
syntax dataaddr = addr

;; 4-runtime.watsup:12.1-12.49
syntax hostaddr = addr

;; 4-runtime.watsup:13.1-13.56
syntax structaddr = addr

;; 4-runtime.watsup:14.1-14.51
syntax arrayaddr = addr

;; 4-runtime.watsup:33.1-34.28
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:35.1-41.23
rec {

;; 4-runtime.watsup:35.1-41.23
syntax addrref =
  | REF.I31_NUM(u31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)
}

;; 4-runtime.watsup:42.1-44.22
syntax ref =
  | REF.I31_NUM(u31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)
  | REF.NULL(heaptype)

;; 4-runtime.watsup:45.1-46.14
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(heaptype)
  | REF.I31_NUM(u31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)

;; 4-runtime.watsup:48.1-49.22
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:58.1-59.70
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:70.1-70.26
syntax c_packedtype = nat

;; 4-runtime.watsup:90.1-92.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:105.1-113.25
syntax moduleinst = {TYPE deftype*, FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:72.1-75.16
syntax funcinst = {TYPE deftype, MODULE moduleinst, CODE func}

;; 4-runtime.watsup:76.1-78.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:79.1-81.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:82.1-84.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:85.1-87.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:88.1-89.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:94.1-95.57
syntax packedval =
  | PACK(packedtype, c_packedtype)

;; 4-runtime.watsup:96.1-97.20
syntax fieldval =
  | CONST(numtype, c_numtype)
  | REF.NULL(heaptype)
  | REF.I31_NUM(u31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)
  | PACK(packedtype, c_packedtype)

;; 4-runtime.watsup:98.1-100.22
syntax structinst = {TYPE deftype, FIELD fieldval*}

;; 4-runtime.watsup:101.1-103.22
syntax arrayinst = {TYPE deftype, FIELD fieldval*}

;; 4-runtime.watsup:132.1-140.23
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*, STRUCT structinst*, ARRAY arrayinst*}

;; 4-runtime.watsup:142.1-144.24
syntax frame = {LOCAL val?*, MODULE moduleinst}

;; 4-runtime.watsup:146.1-146.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:158.1-163.9
rec {

;; 4-runtime.watsup:158.1-163.9
syntax admininstr =
  | UNREACHABLE
  | NOP
  | DROP
  | SELECT(valtype*?)
  | BLOCK(blocktype, instr*)
  | LOOP(blocktype, instr*)
  | IF(blocktype, instr*, instr*)
  | BR(labelidx)
  | BR_IF(labelidx)
  | BR_TABLE(labelidx*, labelidx)
  | BR_ON_NULL(labelidx)
  | BR_ON_NON_NULL(labelidx)
  | BR_ON_CAST(labelidx, reftype, reftype)
  | BR_ON_CAST_FAIL(labelidx, reftype, reftype)
  | CALL(funcidx)
  | CALL_REF(typeidx?)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | RETURN_CALL(funcidx)
  | RETURN_CALL_REF(typeidx?)
  | RETURN_CALL_INDIRECT(tableidx, typeidx)
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(heaptype)
  | REF.I31
  | REF.FUNC(funcidx)
  | REF.IS_NULL
  | REF.AS_NON_NULL
  | REF.EQ
  | REF.TEST(reftype)
  | REF.CAST(reftype)
  | I31.GET(sx)
  | STRUCT.NEW(typeidx)
  | STRUCT.NEW_DEFAULT(typeidx)
  | STRUCT.GET(sx?, typeidx, u32)
  | STRUCT.SET(typeidx, u32)
  | ARRAY.NEW(typeidx)
  | ARRAY.NEW_DEFAULT(typeidx)
  | ARRAY.NEW_FIXED(typeidx, nat)
  | ARRAY.NEW_DATA(typeidx, dataidx)
  | ARRAY.NEW_ELEM(typeidx, elemidx)
  | ARRAY.GET(sx?, typeidx)
  | ARRAY.SET(typeidx)
  | ARRAY.LEN
  | ARRAY.FILL(typeidx)
  | ARRAY.COPY(typeidx, typeidx)
  | ARRAY.INIT_DATA(typeidx, dataidx)
  | ARRAY.INIT_ELEM(typeidx, elemidx)
  | EXTERN.CONVERT_ANY
  | ANY.CONVERT_EXTERN
  | LOCAL.GET(localidx)
  | LOCAL.SET(localidx)
  | LOCAL.TEE(localidx)
  | GLOBAL.GET(globalidx)
  | GLOBAL.SET(globalidx)
  | TABLE.GET(tableidx)
  | TABLE.SET(tableidx)
  | TABLE.SIZE(tableidx)
  | TABLE.GROW(tableidx)
  | TABLE.FILL(tableidx)
  | TABLE.COPY(tableidx, tableidx)
  | TABLE.INIT(tableidx, elemidx)
  | ELEM.DROP(elemidx)
  | MEMORY.SIZE(memidx)
  | MEMORY.GROW(memidx)
  | MEMORY.FILL(memidx)
  | MEMORY.COPY(memidx, memidx)
  | MEMORY.INIT(memidx, dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memidx, memop)
  | STORE(numtype, n?, memidx, memop)
  | REF.I31_NUM(u31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)
  | LABEL_(n, instr*, admininstr*)
  | FRAME_(n, frame, admininstr*)
  | TRAP
}

;; 4-runtime.watsup:147.1-147.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:165.1-168.25
rec {

;; 4-runtime.watsup:165.1-168.25
syntax E =
  | _HOLE
  | _SEQ(val*, E, instr*)
  | LABEL_(n, instr*, E)
}

;; 5-runtime-aux.watsup:7.1-7.73
def inst_reftype : (moduleinst, reftype) -> reftype
  ;; 5-runtime-aux.watsup:9.1-10.22
  def {dt* : deftype*, mm : moduleinst, rt : reftype} inst_reftype(mm, rt) = $subst_all_reftype(rt, (dt <: heaptype)*{dt})
    -- if (dt*{dt} = mm.TYPE_moduleinst)

;; 5-runtime-aux.watsup:19.1-19.52
def default : valtype -> val?
  ;; 5-runtime-aux.watsup:26.1-26.31
  def {ht : heaptype} default(REF_valtype(`NULL%?`(?()), ht)) = ?()
  ;; 5-runtime-aux.watsup:25.1-25.42
  def {ht : heaptype} default(REF_valtype(`NULL%?`(?(())), ht)) = ?(REF.NULL_val(ht))
  ;; 5-runtime-aux.watsup:24.1-24.34
  def default(F64_valtype) = ?(CONST_val(F64_numtype, 0))
  ;; 5-runtime-aux.watsup:23.1-23.34
  def default(F32_valtype) = ?(CONST_val(F32_numtype, 0))
  ;; 5-runtime-aux.watsup:22.1-22.34
  def default(I64_valtype) = ?(CONST_val(I64_numtype, 0))
  ;; 5-runtime-aux.watsup:21.1-21.34
  def default(I32_valtype) = ?(CONST_val(I32_numtype, 0))

;; 5-runtime-aux.watsup:31.1-31.73
def packval : (storagetype, val) -> fieldval
  ;; 5-runtime-aux.watsup:35.1-35.70
  def {i : nat, pt : packedtype} packval((pt <: storagetype), CONST_val(I32_numtype, i)) = PACK_fieldval(pt, $wrap(32, $packedsize(pt), i))
  ;; 5-runtime-aux.watsup:34.1-34.27
  def {t : valtype, val : val} packval((t <: storagetype), val) = (val <: fieldval)

;; 5-runtime-aux.watsup:32.1-32.83
def unpackval : (storagetype, sx?, fieldval) -> val
  ;; 5-runtime-aux.watsup:38.1-38.79
  def {i : nat, pt : packedtype, sx : sx} unpackval((pt <: storagetype), ?(sx), PACK_fieldval(pt, i)) = CONST_val(I32_numtype, $ext($packedsize(pt), 32, sx, i))
  ;; 5-runtime-aux.watsup:37.1-37.34
  def {t : valtype, val : val} unpackval((t <: storagetype), ?(), (val <: fieldval)) = val

;; 5-runtime-aux.watsup:43.1-43.62
rec {

;; 5-runtime-aux.watsup:43.1-43.62
def funcsxv : externval* -> funcaddr*
  ;; 5-runtime-aux.watsup:50.1-50.58
  def {externval : externval, xv* : externval*} funcsxv([externval] :: xv*{xv}) = $funcsxv(xv*{xv})
    -- otherwise
  ;; 5-runtime-aux.watsup:49.1-49.47
  def {fa : funcaddr, xv* : externval*} funcsxv([FUNC_externval(fa)] :: xv*{xv}) = [fa] :: $funcsxv(xv*{xv})
  ;; 5-runtime-aux.watsup:48.1-48.24
  def funcsxv([]) = []
}

;; 5-runtime-aux.watsup:44.1-44.64
rec {

;; 5-runtime-aux.watsup:44.1-44.64
def globalsxv : externval* -> globaladdr*
  ;; 5-runtime-aux.watsup:54.1-54.62
  def {externval : externval, xv* : externval*} globalsxv([externval] :: xv*{xv}) = $globalsxv(xv*{xv})
    -- otherwise
  ;; 5-runtime-aux.watsup:53.1-53.53
  def {ga : globaladdr, xv* : externval*} globalsxv([GLOBAL_externval(ga)] :: xv*{xv}) = [ga] :: $globalsxv(xv*{xv})
  ;; 5-runtime-aux.watsup:52.1-52.26
  def globalsxv([]) = []
}

;; 5-runtime-aux.watsup:45.1-45.63
rec {

;; 5-runtime-aux.watsup:45.1-45.63
def tablesxv : externval* -> tableaddr*
  ;; 5-runtime-aux.watsup:58.1-58.60
  def {externval : externval, xv* : externval*} tablesxv([externval] :: xv*{xv}) = $tablesxv(xv*{xv})
    -- otherwise
  ;; 5-runtime-aux.watsup:57.1-57.50
  def {ta : tableaddr, xv* : externval*} tablesxv([TABLE_externval(ta)] :: xv*{xv}) = [ta] :: $tablesxv(xv*{xv})
  ;; 5-runtime-aux.watsup:56.1-56.25
  def tablesxv([]) = []
}

;; 5-runtime-aux.watsup:46.1-46.61
rec {

;; 5-runtime-aux.watsup:46.1-46.61
def memsxv : externval* -> memaddr*
  ;; 5-runtime-aux.watsup:62.1-62.56
  def {externval : externval, xv* : externval*} memsxv([externval] :: xv*{xv}) = $memsxv(xv*{xv})
    -- otherwise
  ;; 5-runtime-aux.watsup:61.1-61.44
  def {ma : memaddr, xv* : externval*} memsxv([MEM_externval(ma)] :: xv*{xv}) = [ma] :: $memsxv(xv*{xv})
  ;; 5-runtime-aux.watsup:60.1-60.23
  def memsxv([]) = []
}

;; 5-runtime-aux.watsup:72.1-72.57
def store : state -> store
  ;; 5-runtime-aux.watsup:75.1-75.23
  def {f : frame, s : store} store(`%;%`(s, f)) = s

;; 5-runtime-aux.watsup:73.1-73.57
def frame : state -> frame
  ;; 5-runtime-aux.watsup:76.1-76.23
  def {f : frame, s : store} frame(`%;%`(s, f)) = f

;; 5-runtime-aux.watsup:79.1-79.63
def funcaddr : state -> funcaddr*
  ;; 5-runtime-aux.watsup:80.1-80.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 5-runtime-aux.watsup:82.1-82.56
def funcinst : state -> funcinst*
  ;; 5-runtime-aux.watsup:92.1-92.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 5-runtime-aux.watsup:83.1-83.58
def globalinst : state -> globalinst*
  ;; 5-runtime-aux.watsup:93.1-93.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 5-runtime-aux.watsup:84.1-84.57
def tableinst : state -> tableinst*
  ;; 5-runtime-aux.watsup:94.1-94.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 5-runtime-aux.watsup:85.1-85.55
def meminst : state -> meminst*
  ;; 5-runtime-aux.watsup:95.1-95.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 5-runtime-aux.watsup:86.1-86.56
def eleminst : state -> eleminst*
  ;; 5-runtime-aux.watsup:96.1-96.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 5-runtime-aux.watsup:87.1-87.56
def datainst : state -> datainst*
  ;; 5-runtime-aux.watsup:97.1-97.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 5-runtime-aux.watsup:88.1-88.58
def structinst : state -> structinst*
  ;; 5-runtime-aux.watsup:98.1-98.35
  def {f : frame, s : store} structinst(`%;%`(s, f)) = s.STRUCT_store

;; 5-runtime-aux.watsup:89.1-89.57
def arrayinst : state -> arrayinst*
  ;; 5-runtime-aux.watsup:99.1-99.33
  def {f : frame, s : store} arrayinst(`%;%`(s, f)) = s.ARRAY_store

;; 5-runtime-aux.watsup:90.1-90.58
def moduleinst : state -> moduleinst
  ;; 5-runtime-aux.watsup:100.1-100.35
  def {f : frame, s : store} moduleinst(`%;%`(s, f)) = f.MODULE_frame

;; 5-runtime-aux.watsup:102.1-102.66
def type : (state, typeidx) -> deftype
  ;; 5-runtime-aux.watsup:111.1-111.40
  def {f : frame, s : store, x : idx} type(`%;%`(s, f), x) = f.MODULE_frame.TYPE_moduleinst[x]

;; 5-runtime-aux.watsup:103.1-103.67
def func : (state, funcidx) -> funcinst
  ;; 5-runtime-aux.watsup:112.1-112.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 5-runtime-aux.watsup:104.1-104.69
def global : (state, globalidx) -> globalinst
  ;; 5-runtime-aux.watsup:113.1-113.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 5-runtime-aux.watsup:105.1-105.68
def table : (state, tableidx) -> tableinst
  ;; 5-runtime-aux.watsup:114.1-114.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 5-runtime-aux.watsup:106.1-106.66
def mem : (state, memidx) -> meminst
  ;; 5-runtime-aux.watsup:115.1-115.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 5-runtime-aux.watsup:107.1-107.67
def elem : (state, tableidx) -> eleminst
  ;; 5-runtime-aux.watsup:116.1-116.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 5-runtime-aux.watsup:108.1-108.67
def data : (state, dataidx) -> datainst
  ;; 5-runtime-aux.watsup:117.1-117.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 5-runtime-aux.watsup:109.1-109.68
def local : (state, localidx) -> val?
  ;; 5-runtime-aux.watsup:118.1-118.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 5-runtime-aux.watsup:123.1-123.88
def with_local : (state, localidx, val) -> state
  ;; 5-runtime-aux.watsup:134.1-134.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = ?(v)])

;; 5-runtime-aux.watsup:124.1-124.95
def with_global : (state, globalidx, val) -> state
  ;; 5-runtime-aux.watsup:135.1-135.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 5-runtime-aux.watsup:125.1-125.96
def with_table : (state, tableidx, nat, ref) -> state
  ;; 5-runtime-aux.watsup:136.1-136.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 5-runtime-aux.watsup:126.1-126.88
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 5-runtime-aux.watsup:137.1-137.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 5-runtime-aux.watsup:127.1-127.98
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 5-runtime-aux.watsup:138.1-138.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 5-runtime-aux.watsup:128.1-128.86
def with_meminst : (state, memidx, meminst) -> state
  ;; 5-runtime-aux.watsup:139.1-139.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 5-runtime-aux.watsup:129.1-129.92
def with_elem : (state, elemidx, ref*) -> state
  ;; 5-runtime-aux.watsup:140.1-140.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 5-runtime-aux.watsup:130.1-130.92
def with_data : (state, dataidx, byte*) -> state
  ;; 5-runtime-aux.watsup:141.1-141.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 5-runtime-aux.watsup:131.1-131.98
def with_struct : (state, structaddr, nat, fieldval) -> state
  ;; 5-runtime-aux.watsup:142.1-142.68
  def {a : addr, f : frame, fv : fieldval, i : nat, s : store} with_struct(`%;%`(s, f), a, i, fv) = `%;%`(s[STRUCT_store[a].FIELD_structinst[i] = fv], f)

;; 5-runtime-aux.watsup:132.1-132.98
def with_array : (state, arrayaddr, nat, fieldval) -> state
  ;; 5-runtime-aux.watsup:143.1-143.66
  def {a : addr, f : frame, fv : fieldval, i : nat, s : store} with_array(`%;%`(s, f), a, i, fv) = `%;%`(s[ARRAY_store[a].FIELD_arrayinst[i] = fv], f)

;; 5-runtime-aux.watsup:145.1-145.77
def ext_structinst : (state, structinst*) -> state
  ;; 5-runtime-aux.watsup:148.1-148.57
  def {f : frame, s : store, si* : structinst*} ext_structinst(`%;%`(s, f), si*{si}) = `%;%`(s[STRUCT_store =.. si*{si}], f)

;; 5-runtime-aux.watsup:146.1-146.76
def ext_arrayinst : (state, arrayinst*) -> state
  ;; 5-runtime-aux.watsup:149.1-149.55
  def {ai* : arrayinst*, f : frame, s : store} ext_arrayinst(`%;%`(s, f), ai*{ai}) = `%;%`(s[ARRAY_store =.. ai*{ai}], f)

;; 5-runtime-aux.watsup:154.1-154.62
def growtable : (tableinst, nat, ref) -> tableinst
  ;; 5-runtime-aux.watsup:157.1-161.19
  def {i : nat, i' : nat, j : nat, n : n, r : ref, r'* : ref*, rt : reftype, ti : tableinst, ti' : tableinst} growtable(ti, n, r) = ti'
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%]`(i', j), rt), ELEM r'*{r'} :: r^n{}})
    -- if (i' <= j)

;; 5-runtime-aux.watsup:155.1-155.62
def growmemory : (meminst, nat) -> meminst
  ;; 5-runtime-aux.watsup:163.1-167.19
  def {b* : byte*, i : nat, i' : nat, j : nat, mi : meminst, mi' : meminst, n : n} growmemory(mi, n) = mi'
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%]`(i', j)), DATA b*{b} :: 0^((n * 64) * $Ki){}})
    -- if (i' <= j)

;; 6-typing.watsup:5.1-6.16
syntax init =
  | SET
  | UNSET

;; 6-typing.watsup:8.1-9.15
syntax localtype = `%%`(init, valtype)

;; 6-typing.watsup:11.1-12.37
syntax instrtype = `%->%*%`(resulttype, localidx*, resulttype)

;; 6-typing.watsup:15.1-19.62
syntax context = {TYPE deftype*, REC subtype*, FUNC deftype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL localtype*, LABEL resulttype*, RETURN resulttype?}

;; 6-typing.watsup:26.1-26.86
rec {

;; 6-typing.watsup:26.1-26.86
def with_locals : (context, localidx*, localtype*) -> context
  ;; 6-typing.watsup:29.1-29.85
  def {C : context, lt* : localtype*, lt_1 : localtype, x* : idx*, x_1 : idx} with_locals(C, [x_1] :: x*{x}, [lt_1] :: lt*{lt}) = $with_locals(C[LOCAL_context[x_1] = lt_1], x*{x}, lt*{lt})
  ;; 6-typing.watsup:28.1-28.34
  def {C : context} with_locals(C, [], []) = C
}

;; 6-typing.watsup:33.1-33.65
rec {

;; 6-typing.watsup:33.1-33.65
def clostypes : deftype* -> deftype*
  ;; 6-typing.watsup:38.1-38.93
  def {dt* : deftype*, dt'* : deftype*, dt_N : deftype} clostypes(dt*{dt} :: [dt_N]) = dt'*{dt'} :: [$subst_all_deftype(dt_N, (dt' <: heaptype)*{dt'})]
    -- if (dt'*{dt'} = $clostypes(dt*{dt}))
  ;; 6-typing.watsup:37.1-37.26
  def clostypes([]) = []
}

;; 6-typing.watsup:32.1-32.65
def clostype : (context, deftype) -> deftype
  ;; 6-typing.watsup:35.1-35.84
  def {C : context, dt : deftype, dt'* : deftype*} clostype(C, dt) = $subst_all_deftype(dt, (dt' <: heaptype)*{dt'})
    -- if (dt'*{dt'} = $clostypes(C.TYPE_context))

;; 6-typing.watsup:47.1-47.71
relation Numtype_ok: `%|-%:OK`(context, numtype)
  ;; 6-typing.watsup:54.1-55.20
  rule _ {C : context, numtype : numtype}:
    `%|-%:OK`(C, numtype)

;; 6-typing.watsup:48.1-48.71
relation Vectype_ok: `%|-%:OK`(context, vectype)
  ;; 6-typing.watsup:57.1-58.20
  rule _ {C : context, vectype : vectype}:
    `%|-%:OK`(C, vectype)

;; 6-typing.watsup:49.1-49.72
relation Heaptype_ok: `%|-%:OK`(context, heaptype)
  ;; 6-typing.watsup:67.1-69.22
  rule rec {C : context, i : nat, st : subtype}:
    `%|-%:OK`(C, REC_heaptype(i))
    -- if (C.REC_context[i] = st)

  ;; 6-typing.watsup:63.1-65.23
  rule typeidx {C : context, dt : deftype, x : idx}:
    `%|-%:OK`(C, _IDX_heaptype(x))
    -- if (C.TYPE_context[x] = dt)

  ;; 6-typing.watsup:60.1-61.24
  rule abs {C : context, absheaptype : absheaptype}:
    `%|-%:OK`(C, (absheaptype <: heaptype))

;; 6-typing.watsup:50.1-50.71
relation Reftype_ok: `%|-%:OK`(context, reftype)
  ;; 6-typing.watsup:71.1-73.31
  rule _ {C : context, ht : heaptype, nul : nul}:
    `%|-%:OK`(C, REF_reftype(nul, ht))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

;; 6-typing.watsup:51.1-51.71
relation Valtype_ok: `%|-%:OK`(context, valtype)
  ;; 6-typing.watsup:87.1-88.16
  rule bot {C : context}:
    `%|-%:OK`(C, BOT_valtype)

  ;; 6-typing.watsup:83.1-85.35
  rule ref {C : context, reftype : reftype}:
    `%|-%:OK`(C, (reftype <: valtype))
    -- Reftype_ok: `%|-%:OK`(C, reftype)

  ;; 6-typing.watsup:79.1-81.35
  rule vec {C : context, vectype : vectype}:
    `%|-%:OK`(C, (vectype <: valtype))
    -- Vectype_ok: `%|-%:OK`(C, vectype)

  ;; 6-typing.watsup:75.1-77.35
  rule num {C : context, numtype : numtype}:
    `%|-%:OK`(C, (numtype <: valtype))
    -- Numtype_ok: `%|-%:OK`(C, numtype)

;; 6-typing.watsup:93.1-93.74
relation Resulttype_ok: `%|-%:OK`(context, resulttype)
  ;; 6-typing.watsup:96.1-98.32
  rule _ {C : context, t* : valtype*}:
    `%|-%:OK`(C, t*{t})
    -- (Valtype_ok: `%|-%:OK`(C, t))*{t}

;; 6-typing.watsup:94.1-94.73
relation Instrtype_ok: `%|-%:OK`(context, instrtype)
  ;; 6-typing.watsup:100.1-104.27
  rule _ {C : context, lt* : localtype*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%:OK`(C, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))
    -- Resulttype_ok: `%|-%:OK`(C, t_1*{t_1})
    -- Resulttype_ok: `%|-%:OK`(C, t_2*{t_2})
    -- (if (C.LOCAL_context[x] = lt))*{lt x}

;; 6-typing.watsup:109.1-109.84
syntax oktypeidx =
  | OK(typeidx)

;; 6-typing.watsup:110.1-110.87
syntax oktypeidxnat =
  | OK(typeidx, nat)

;; 6-typing.watsup:112.1-112.76
relation Packedtype_ok: `%|-%:OK`(context, packedtype)
  ;; 6-typing.watsup:128.1-129.23
  rule _ {C : context, packedtype : packedtype}:
    `%|-%:OK`(C, packedtype)

;; 6-typing.watsup:114.1-114.77
relation Storagetype_ok: `%|-%:OK`(context, storagetype)
  ;; 6-typing.watsup:135.1-137.41
  rule packed {C : context, packedtype : packedtype}:
    `%|-%:OK`(C, (packedtype <: storagetype))
    -- Packedtype_ok: `%|-%:OK`(C, packedtype)

  ;; 6-typing.watsup:131.1-133.35
  rule val {C : context, valtype : valtype}:
    `%|-%:OK`(C, (valtype <: storagetype))
    -- Valtype_ok: `%|-%:OK`(C, valtype)

;; 6-typing.watsup:113.1-113.75
relation Fieldtype_ok: `%|-%:OK`(context, fieldtype)
  ;; 6-typing.watsup:139.1-141.34
  rule _ {C : context, mut : mut, zt : storagetype}:
    `%|-%:OK`(C, `%%`(mut, zt))
    -- Storagetype_ok: `%|-%:OK`(C, zt)

;; 6-typing.watsup:116.1-116.74
relation Functype_ok: `%|-%:OK`(context, functype)
  ;; 6-typing.watsup:225.1-228.35
  rule _ {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:OK`(C, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_ok: `%|-%:OK`(C, t_1*{t_1})
    -- Resulttype_ok: `%|-%:OK`(C, t_2*{t_2})

;; 6-typing.watsup:115.1-115.74
relation Comptype_ok: `%|-%:OK`(context, comptype)
  ;; 6-typing.watsup:152.1-154.31
  rule func {C : context, ft : functype}:
    `%|-%:OK`(C, FUNC_comptype(ft))
    -- Functype_ok: `%|-%:OK`(C, ft)

  ;; 6-typing.watsup:148.1-150.32
  rule array {C : context, yt : fieldtype}:
    `%|-%:OK`(C, ARRAY_comptype(yt))
    -- Fieldtype_ok: `%|-%:OK`(C, yt)

  ;; 6-typing.watsup:144.1-146.35
  rule struct {C : context, yt* : fieldtype*}:
    `%|-%:OK`(C, STRUCT_comptype(yt*{yt}))
    -- (Fieldtype_ok: `%|-%:OK`(C, yt))*{yt}

;; 6-typing.watsup:391.1-391.91
relation Packedtype_sub: `%|-%<:%`(context, packedtype, packedtype)
  ;; 6-typing.watsup:398.1-399.32
  rule _ {C : context, packedtype : packedtype}:
    `%|-%<:%`(C, packedtype, packedtype)

;; 6-typing.watsup:269.1-269.78
relation Numtype_sub: `%|-%<:%`(context, numtype, numtype)
  ;; 6-typing.watsup:275.1-276.26
  rule _ {C : context, numtype : numtype}:
    `%|-%<:%`(C, numtype, numtype)

;; 6-typing.watsup:125.1-271.79
rec {

;; 6-typing.watsup:125.1-125.75
relation Deftype_sub: `%|-%<:%`(context, deftype, deftype)
  ;; 6-typing.watsup:438.1-441.40
  rule super {C : context, ct : comptype, deftype_1 : deftype, deftype_2 : deftype, fin : fin, ht : heaptype, ht_1* : heaptype*, ht_2* : heaptype*}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- if ($unrolldt(deftype_1) = SUBD_subtype(fin, ht_1*{ht_1} :: [ht] :: ht_2*{ht_2}, ct))
    -- Heaptype_sub: `%|-%<:%`(C, ht, (deftype_2 <: heaptype))

  ;; 6-typing.watsup:434.1-436.58
  rule refl {C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- if ($clostype(C, deftype_1) = $clostype(C, deftype_2))

;; 6-typing.watsup:271.1-271.79
relation Heaptype_sub: `%|-%<:%`(context, heaptype, heaptype)
  ;; 6-typing.watsup:343.1-344.23
  rule bot {C : context, heaptype : heaptype}:
    `%|-%<:%`(C, BOT_heaptype, heaptype)

  ;; 6-typing.watsup:339.1-341.43
  rule noextern {C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOEXTERN_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, EXTERN_heaptype)

  ;; 6-typing.watsup:335.1-337.41
  rule nofunc {C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOFUNC_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, FUNC_heaptype)

  ;; 6-typing.watsup:331.1-333.40
  rule none {C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NONE_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, ANY_heaptype)

  ;; 6-typing.watsup:327.1-329.48
  rule rec {C : context, ct : comptype, fin : fin, ht : heaptype, ht_1* : heaptype*, ht_2* : heaptype*, i : nat}:
    `%|-%<:%`(C, REC_heaptype(i), ht)
    -- if (C.REC_context[i] = SUBD_subtype(fin, ht_1*{ht_1} :: [ht] :: ht_2*{ht_2}, ct))

  ;; 6-typing.watsup:323.1-325.52
  rule typeidx-r {C : context, heaptype : heaptype, typeidx : typeidx}:
    `%|-%<:%`(C, heaptype, _IDX_heaptype(typeidx))
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, (C.TYPE_context[typeidx] <: heaptype))

  ;; 6-typing.watsup:319.1-321.52
  rule typeidx-l {C : context, heaptype : heaptype, typeidx : typeidx}:
    `%|-%<:%`(C, _IDX_heaptype(typeidx), heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, (C.TYPE_context[typeidx] <: heaptype), heaptype)

  ;; 6-typing.watsup:315.1-317.46
  rule def {C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, (deftype_1 <: heaptype), (deftype_2 <: heaptype))
    -- Deftype_sub: `%|-%<:%`(C, deftype_1, deftype_2)

  ;; 6-typing.watsup:311.1-313.32
  rule func {C : context, deftype : deftype, ft : functype}:
    `%|-%<:%`(C, (deftype <: heaptype), FUNC_heaptype)
    -- Expand: `%~~%`(deftype, FUNC_comptype(ft))

  ;; 6-typing.watsup:307.1-309.33
  rule array {C : context, deftype : deftype, yt : fieldtype}:
    `%|-%<:%`(C, (deftype <: heaptype), ARRAY_heaptype)
    -- Expand: `%~~%`(deftype, ARRAY_comptype(yt))

  ;; 6-typing.watsup:303.1-305.35
  rule struct {C : context, deftype : deftype, yt* : fieldtype*}:
    `%|-%<:%`(C, (deftype <: heaptype), STRUCT_heaptype)
    -- Expand: `%~~%`(deftype, STRUCT_comptype(yt*{yt}))

  ;; 6-typing.watsup:300.1-301.19
  rule array-eq {C : context}:
    `%|-%<:%`(C, ARRAY_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:297.1-298.20
  rule struct-eq {C : context}:
    `%|-%<:%`(C, STRUCT_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:294.1-295.17
  rule i31-eq {C : context}:
    `%|-%<:%`(C, I31_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:291.1-292.17
  rule eq-any {C : context}:
    `%|-%<:%`(C, EQ_heaptype, ANY_heaptype)

  ;; 6-typing.watsup:285.1-289.48
  rule trans {C : context, heaptype' : heaptype, heaptype_1 : heaptype, heaptype_2 : heaptype}:
    `%|-%<:%`(C, heaptype_1, heaptype_2)
    -- Heaptype_ok: `%|-%:OK`(C, heaptype')
    -- Heaptype_sub: `%|-%<:%`(C, heaptype_1, heaptype')
    -- Heaptype_sub: `%|-%<:%`(C, heaptype', heaptype_2)

  ;; 6-typing.watsup:282.1-283.28
  rule refl {C : context, heaptype : heaptype}:
    `%|-%<:%`(C, heaptype, heaptype)
}

;; 6-typing.watsup:272.1-272.78
relation Reftype_sub: `%|-%<:%`(context, reftype, reftype)
  ;; 6-typing.watsup:351.1-353.37
  rule null {C : context, ht_1 : heaptype, ht_2 : heaptype}:
    `%|-%<:%`(C, REF_reftype(`NULL%?`(()?{}), ht_1), REF_reftype(`NULL%?`(?(())), ht_2))
    -- Heaptype_sub: `%|-%<:%`(C, ht_1, ht_2)

  ;; 6-typing.watsup:347.1-349.37
  rule nonnull {C : context, ht_1 : heaptype, ht_2 : heaptype}:
    `%|-%<:%`(C, REF_reftype(`NULL%?`(?()), ht_1), REF_reftype(`NULL%?`(?()), ht_2))
    -- Heaptype_sub: `%|-%<:%`(C, ht_1, ht_2)

;; 6-typing.watsup:270.1-270.78
relation Vectype_sub: `%|-%<:%`(context, vectype, vectype)
  ;; 6-typing.watsup:278.1-279.26
  rule _ {C : context, vectype : vectype}:
    `%|-%<:%`(C, vectype, vectype)

;; 6-typing.watsup:273.1-273.78
relation Valtype_sub: `%|-%<:%`(context, valtype, valtype)
  ;; 6-typing.watsup:368.1-369.22
  rule bot {C : context, valtype : valtype}:
    `%|-%<:%`(C, BOT_valtype, valtype)

  ;; 6-typing.watsup:364.1-366.46
  rule ref {C : context, reftype_1 : reftype, reftype_2 : reftype}:
    `%|-%<:%`(C, (reftype_1 <: valtype), (reftype_2 <: valtype))
    -- Reftype_sub: `%|-%<:%`(C, reftype_1, reftype_2)

  ;; 6-typing.watsup:360.1-362.46
  rule vec {C : context, vectype_1 : vectype, vectype_2 : vectype}:
    `%|-%<:%`(C, (vectype_1 <: valtype), (vectype_2 <: valtype))
    -- Vectype_sub: `%|-%<:%`(C, vectype_1, vectype_2)

  ;; 6-typing.watsup:356.1-358.46
  rule num {C : context, numtype_1 : numtype, numtype_2 : numtype}:
    `%|-%<:%`(C, (numtype_1 <: valtype), (numtype_2 <: valtype))
    -- Numtype_sub: `%|-%<:%`(C, numtype_1, numtype_2)

;; 6-typing.watsup:392.1-392.92
relation Storagetype_sub: `%|-%<:%`(context, storagetype, storagetype)
  ;; 6-typing.watsup:406.1-408.55
  rule packed {C : context, packedtype_1 : packedtype, packedtype_2 : packedtype}:
    `%|-%<:%`(C, (packedtype_1 <: storagetype), (packedtype_2 <: storagetype))
    -- Packedtype_sub: `%|-%<:%`(C, packedtype_1, packedtype_2)

  ;; 6-typing.watsup:402.1-404.46
  rule val {C : context, valtype_1 : valtype, valtype_2 : valtype}:
    `%|-%<:%`(C, (valtype_1 <: storagetype), (valtype_2 <: storagetype))
    -- Valtype_sub: `%|-%<:%`(C, valtype_1, valtype_2)

;; 6-typing.watsup:393.1-393.90
relation Fieldtype_sub: `%|-%<:%`(context, fieldtype, fieldtype)
  ;; 6-typing.watsup:415.1-418.40
  rule var {C : context, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?(())), zt_1), `%%`(`MUT%?`(?(())), zt_2))
    -- Storagetype_sub: `%|-%<:%`(C, zt_1, zt_2)
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

  ;; 6-typing.watsup:411.1-413.40
  rule const {C : context, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?()), zt_1), `%%`(`MUT%?`(?()), zt_2))
    -- Storagetype_sub: `%|-%<:%`(C, zt_1, zt_2)

;; 6-typing.watsup:395.1-395.89
relation Functype_sub: `%|-%<:%`(context, functype, functype)
  ;; 6-typing.watsup:458.1-459.16
  rule _ {C : context, ft : functype}:
    `%|-%<:%`(C, ft, ft)

;; 6-typing.watsup:124.1-124.76
relation Comptype_sub: `%|-%<:%`(context, comptype, comptype)
  ;; 6-typing.watsup:429.1-431.37
  rule func {C : context, ft_1 : functype, ft_2 : functype}:
    `%|-%<:%`(C, FUNC_comptype(ft_1), FUNC_comptype(ft_2))
    -- Functype_sub: `%|-%<:%`(C, ft_1, ft_2)

  ;; 6-typing.watsup:425.1-427.38
  rule array {C : context, yt_1 : fieldtype, yt_2 : fieldtype}:
    `%|-%<:%`(C, ARRAY_comptype(yt_1), ARRAY_comptype(yt_2))
    -- Fieldtype_sub: `%|-%<:%`(C, yt_1, yt_2)

  ;; 6-typing.watsup:421.1-423.41
  rule struct {C : context, yt'_1 : fieldtype, yt_1* : fieldtype*, yt_2* : fieldtype*}:
    `%|-%<:%`(C, STRUCT_comptype(yt_1*{yt_1} :: [yt'_1]), STRUCT_comptype(yt_2*{yt_2}))
    -- (Fieldtype_sub: `%|-%<:%`(C, yt_1, yt_2))*{yt_1 yt_2}

;; 6-typing.watsup:117.1-117.73
relation Subtype_ok: `%|-%:%`(context, subtype, oktypeidx)
  ;; 6-typing.watsup:157.1-163.37
  rule _ {C : context, ct : comptype, ct'* : comptype*, fin : fin, x : idx, y* : idx*, y'** : idx**}:
    `%|-%:%`(C, SUB_subtype(fin, y*{y}, ct), OK_oktypeidx(x))
    -- if (|y*{y}| <= 1)
    -- (if (y < x))*{y}
    -- (if ($unrolldt(C.TYPE_context[y]) = SUB_subtype(`FINAL%?`(?()), y'*{y'}, ct')))*{ct' y y'}
    -- Comptype_ok: `%|-%:OK`(C, ct)
    -- (Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}

;; 6-typing.watsup:165.1-165.65
def before : (heaptype, typeidx, nat) -> bool
  ;; 6-typing.watsup:168.1-168.33
  def {i : nat, j : nat, x : idx} before(REC_heaptype(j), x, i) = (j < i)
  ;; 6-typing.watsup:167.1-167.46
  def {i : nat, typeidx : typeidx, x : idx} before(_IDX_heaptype(typeidx), x, i) = (typeidx < x)
  ;; 6-typing.watsup:166.1-166.34
  def {deftype : deftype, i : nat, x : idx} before((deftype <: heaptype), x, i) = true

;; 6-typing.watsup:170.1-170.69
def unrollht : (context, heaptype) -> subtype
  ;; 6-typing.watsup:173.1-173.35
  def {C : context, i : nat} unrollht(C, REC_heaptype(i)) = C.REC_context[i]
  ;; 6-typing.watsup:172.1-172.60
  def {C : context, typeidx : typeidx} unrollht(C, _IDX_heaptype(typeidx)) = $unrolldt(C.TYPE_context[typeidx])
  ;; 6-typing.watsup:171.1-171.47
  def {C : context, deftype : deftype} unrollht(C, (deftype <: heaptype)) = $unrolldt(deftype)

;; 6-typing.watsup:119.1-119.76
relation Subtype_ok2: `%|-%:%`(context, subtype, oktypeidxnat)
  ;; 6-typing.watsup:175.1-181.37
  rule _ {C : context, ct : comptype, ct'* : comptype*, fin : fin, ht* : heaptype*, ht'** : heaptype**, i : nat, x : idx}:
    `%|-%:%`(C, SUBD_subtype(fin, ht*{ht}, ct), OK_oktypeidxnat(x, i))
    -- if (|ht*{ht}| <= 1)
    -- (if $before(ht, x, i))*{ht}
    -- (if ($unrollht(C, ht) = SUBD_subtype(`FINAL%?`(?()), ht'*{ht'}, ct')))*{ct' ht ht'}
    -- Comptype_ok: `%|-%:OK`(C, ct)
    -- (Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}

;; 6-typing.watsup:120.1-120.76
rec {

;; 6-typing.watsup:120.1-120.76
relation Rectype_ok2: `%|-%:%`(context, rectype, oktypeidxnat)
  ;; 6-typing.watsup:199.1-202.50
  rule cons {C : context, i : nat, st* : subtype*, st_1 : subtype, x : idx}:
    `%|-%:%`(C, REC_rectype([st_1] :: st*{st}), OK_oktypeidxnat(x, i))
    -- Subtype_ok2: `%|-%:%`(C, st_1, OK_oktypeidxnat(x, i))
    -- Rectype_ok2: `%|-%:%`(C, REC_rectype(st*{st}), OK_oktypeidxnat((x + 1), (i + 1)))

  ;; 6-typing.watsup:196.1-197.24
  rule empty {C : context, i : nat, x : idx}:
    `%|-%:%`(C, REC_rectype([]), OK_oktypeidxnat(x, i))
}

;; 6-typing.watsup:118.1-118.74
rec {

;; 6-typing.watsup:118.1-118.74
relation Rectype_ok: `%|-%:%`(context, rectype, oktypeidx)
  ;; 6-typing.watsup:192.1-194.49
  rule rec2 {C : context, st* : subtype*, x : idx}:
    `%|-%:%`(C, REC_rectype(st*{st}), OK_oktypeidx(x))
    -- Rectype_ok2: `%|-%:%`(C ++ {TYPE [], REC st*{st}, FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, REC_rectype(st*{st}), OK_oktypeidxnat(x, 0))

  ;; 6-typing.watsup:187.1-190.43
  rule cons {C : context, st* : subtype*, st_1 : subtype, x : idx}:
    `%|-%:%`(C, REC_rectype([st_1] :: st*{st}), OK_oktypeidx(x))
    -- Subtype_ok: `%|-%:%`(C, st_1, OK_oktypeidx(x))
    -- Rectype_ok: `%|-%:%`(C, REC_rectype(st*{st}), OK_oktypeidx(x + 1))

  ;; 6-typing.watsup:184.1-185.23
  rule empty {C : context, x : idx}:
    `%|-%:%`(C, REC_rectype([]), OK_oktypeidx(x))
}

;; 6-typing.watsup:121.1-121.73
relation Deftype_ok: `%|-%:OK`(context, deftype)
  ;; 6-typing.watsup:205.1-209.14
  rule _ {C : context, i : nat, n : n, qt : rectype, st^n : subtype^n, x : idx}:
    `%|-%:OK`(C, DEF_deftype(qt, i))
    -- Rectype_ok: `%|-%:%`(C, qt, OK_oktypeidx(x))
    -- if (qt = REC_rectype(st^n{st}))
    -- if (i < n)

;; 6-typing.watsup:214.1-214.74
relation Limits_ok: `%|-%:%`(context, limits, nat)
  ;; 6-typing.watsup:221.1-223.24
  rule _ {C : context, k : nat, n_1 : n, n_2 : n}:
    `%|-%:%`(C, `[%..%]`(n_1, n_2), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 6-typing.watsup:215.1-215.74
relation Globaltype_ok: `%|-%:OK`(context, globaltype)
  ;; 6-typing.watsup:230.1-232.29
  rule _ {C : context, mut : mut, t : valtype}:
    `%|-%:OK`(C, `%%`(mut, t))
    -- Valtype_ok: `%|-%:OK`(C, t)

;; 6-typing.watsup:216.1-216.73
relation Tabletype_ok: `%|-%:OK`(context, tabletype)
  ;; 6-typing.watsup:234.1-237.30
  rule _ {C : context, lim : limits, rt : reftype}:
    `%|-%:OK`(C, `%%`(lim, rt))
    -- Limits_ok: `%|-%:%`(C, lim, ((2 ^ 32) - 1))
    -- Reftype_ok: `%|-%:OK`(C, rt)

;; 6-typing.watsup:217.1-217.71
relation Memtype_ok: `%|-%:OK`(context, memtype)
  ;; 6-typing.watsup:239.1-241.35
  rule _ {C : context, lim : limits}:
    `%|-%:OK`(C, `%I8`(lim))
    -- Limits_ok: `%|-%:%`(C, lim, (2 ^ 16))

;; 6-typing.watsup:218.1-218.74
relation Externtype_ok: `%|-%:OK`(context, externtype)
  ;; 6-typing.watsup:257.1-259.30
  rule mem {C : context, mt : memtype}:
    `%|-%:OK`(C, MEM_externtype(mt))
    -- Memtype_ok: `%|-%:OK`(C, mt)

  ;; 6-typing.watsup:253.1-255.32
  rule table {C : context, tt : tabletype}:
    `%|-%:OK`(C, TABLE_externtype(tt))
    -- Tabletype_ok: `%|-%:OK`(C, tt)

  ;; 6-typing.watsup:249.1-251.33
  rule global {C : context, gt : globaltype}:
    `%|-%:OK`(C, GLOBAL_externtype(gt))
    -- Globaltype_ok: `%|-%:OK`(C, gt)

  ;; 6-typing.watsup:244.1-247.27
  rule func {C : context, dt : deftype, ft : functype}:
    `%|-%:OK`(C, FUNC_externtype(dt))
    -- Deftype_ok: `%|-%:OK`(C, dt)
    -- Expand: `%~~%`(dt, FUNC_comptype(ft))

;; 6-typing.watsup:374.1-374.81
relation Resulttype_sub: `%|-%*<:%*`(context, valtype*, valtype*)
  ;; 6-typing.watsup:377.1-379.37
  rule _ {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*<:%*`(C, t_1*{t_1}, t_2*{t_2})
    -- (Valtype_sub: `%|-%<:%`(C, t_1, t_2))*{t_1 t_2}

;; 6-typing.watsup:375.1-375.80
relation Instrtype_sub: `%|-%<:%`(context, instrtype, instrtype)
  ;; 6-typing.watsup:381.1-386.30
  rule _ {C : context, t* : valtype*, t_11* : valtype*, t_12* : valtype*, t_21* : valtype*, t_22* : valtype*, x* : idx*, x_1* : idx*, x_2* : idx*}:
    `%|-%<:%`(C, `%->%*%`(t_11*{t_11}, x_1*{x_1}, t_12*{t_12}), `%->%*%`(t_21*{t_21}, x_2*{x_2}, t_22*{t_22}))
    -- Resulttype_sub: `%|-%*<:%*`(C, t_21*{t_21}, t_11*{t_11})
    -- Resulttype_sub: `%|-%*<:%*`(C, t_12*{t_12}, t_22*{t_22})
    -- if (x*{x} = $setminus(x_2*{x_2}, x_1*{x_1}))
    -- (if (C.LOCAL_context[x] = `%%`(SET_init, t)))*{t x}

;; 6-typing.watsup:446.1-446.83
relation Limits_sub: `%|-%<:%`(context, limits, limits)
  ;; 6-typing.watsup:453.1-456.21
  rule _ {C : context, n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `%|-%<:%`(C, `[%..%]`(n_11, n_12), `[%..%]`(n_21, n_22))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 6-typing.watsup:447.1-447.83
relation Globaltype_sub: `%|-%<:%`(context, globaltype, globaltype)
  ;; 6-typing.watsup:465.1-468.34
  rule var {C : context, t_1 : valtype, t_2 : valtype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?(())), t_1), `%%`(`MUT%?`(?(())), t_2))
    -- Valtype_sub: `%|-%<:%`(C, t_1, t_2)
    -- Valtype_sub: `%|-%<:%`(C, t_2, t_1)

  ;; 6-typing.watsup:461.1-463.34
  rule const {C : context, t_1 : valtype, t_2 : valtype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?()), t_1), `%%`(`MUT%?`(?()), t_2))
    -- Valtype_sub: `%|-%<:%`(C, t_1, t_2)

;; 6-typing.watsup:448.1-448.82
relation Tabletype_sub: `%|-%<:%`(context, tabletype, tabletype)
  ;; 6-typing.watsup:470.1-474.36
  rule _ {C : context, lim_1 : limits, lim_2 : limits, rt_1 : reftype, rt_2 : reftype}:
    `%|-%<:%`(C, `%%`(lim_1, rt_1), `%%`(lim_2, rt_2))
    -- Limits_sub: `%|-%<:%`(C, lim_1, lim_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_1, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

;; 6-typing.watsup:449.1-449.80
relation Memtype_sub: `%|-%<:%`(context, memtype, memtype)
  ;; 6-typing.watsup:476.1-478.37
  rule _ {C : context, lim_1 : limits, lim_2 : limits}:
    `%|-%<:%`(C, `%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `%|-%<:%`(C, lim_1, lim_2)

;; 6-typing.watsup:450.1-450.83
relation Externtype_sub: `%|-%<:%`(context, externtype, externtype)
  ;; 6-typing.watsup:493.1-495.36
  rule mem {C : context, mt_1 : memtype, mt_2 : memtype}:
    `%|-%<:%`(C, MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `%|-%<:%`(C, mt_1, mt_2)

  ;; 6-typing.watsup:489.1-491.38
  rule table {C : context, tt_1 : tabletype, tt_2 : tabletype}:
    `%|-%<:%`(C, TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `%|-%<:%`(C, tt_1, tt_2)

  ;; 6-typing.watsup:485.1-487.39
  rule global {C : context, gt_1 : globaltype, gt_2 : globaltype}:
    `%|-%<:%`(C, GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `%|-%<:%`(C, gt_1, gt_2)

  ;; 6-typing.watsup:481.1-483.36
  rule func {C : context, dt_1 : deftype, dt_2 : deftype}:
    `%|-%<:%`(C, FUNC_externtype(dt_1), FUNC_externtype(dt_2))
    -- Deftype_sub: `%|-%<:%`(C, dt_1, dt_2)

;; 6-typing.watsup:565.1-565.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 6-typing.watsup:573.1-575.34
  rule typeidx {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, _IDX_blocktype(x), ft)
    -- Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(ft))

  ;; 6-typing.watsup:570.1-571.28
  rule result {C : context, t : valtype}:
    `%|-%:%`(C, _RESULT_blocktype(?(t)), `%->%`([], [t]))

  ;; 6-typing.watsup:567.1-568.32
  rule void {C : context}:
    `%|-%:%`(C, _RESULT_blocktype(?()), `%->%`([], []))

;; 6-typing.watsup:503.1-505.74
rec {

;; 6-typing.watsup:503.1-503.67
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 6-typing.watsup:951.1-956.29
  rule store {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, x : idx}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype (nt <: valtype)], []))
    -- if (C.MEM_context[x] = mt)
    -- if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (inn <: numtype)))

  ;; 6-typing.watsup:944.1-949.29
  rule load {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?, x : idx}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [(nt <: valtype)]))
    -- if (C.MEM_context[x] = mt)
    -- if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (inn <: numtype)))

  ;; 6-typing.watsup:940.1-942.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 6-typing.watsup:935.1-938.23
  rule memory.init {C : context, mt : memtype, x : idx, y : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x, y), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[x] = mt)
    -- if (C.DATA_context[y] = OK)

  ;; 6-typing.watsup:930.1-933.26
  rule memory.copy {C : context, mt_1 : memtype, mt_2 : memtype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, MEMORY.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[x_1] = mt_1)
    -- if (C.MEM_context[x_2] = mt_2)

  ;; 6-typing.watsup:926.1-928.22
  rule memory.fill {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.FILL_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[x] = mt)

  ;; 6-typing.watsup:922.1-924.22
  rule memory.grow {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.GROW_instr(x), `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[x] = mt)

  ;; 6-typing.watsup:918.1-920.22
  rule memory.size {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[x] = mt)

  ;; 6-typing.watsup:911.1-913.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 6-typing.watsup:905.1-909.36
  rule table.init {C : context, lim : limits, rt_1 : reftype, rt_2 : reftype, x : idx, y : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x, y), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt_1))
    -- if (C.ELEM_context[y] = rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:899.1-903.36
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt_1 : reftype, rt_2 : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt_1))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt_2))
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:895.1-897.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype (rt <: valtype) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 6-typing.watsup:891.1-893.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([(rt <: valtype) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 6-typing.watsup:887.1-889.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 6-typing.watsup:883.1-885.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype (rt <: valtype)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 6-typing.watsup:879.1-881.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [(rt <: valtype)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 6-typing.watsup:872.1-874.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?(())), t))

  ;; 6-typing.watsup:868.1-870.28
  rule global.get {C : context, mut : mut, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `%%`(mut, t))

  ;; 6-typing.watsup:853.1-855.28
  rule local.get {C : context, init : init, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = `%%`(init, t))

  ;; 6-typing.watsup:847.1-848.62
  rule any.convert_extern {C : context, nul : nul}:
    `%|-%:%`(C, ANY.CONVERT_EXTERN_instr, `%->%`([REF_valtype(nul, EXTERN_heaptype)], [REF_valtype(nul, ANY_heaptype)]))

  ;; 6-typing.watsup:844.1-845.62
  rule extern.convert_any {C : context, nul : nul}:
    `%|-%:%`(C, EXTERN.CONVERT_ANY_instr, `%->%`([REF_valtype(nul, ANY_heaptype)], [REF_valtype(nul, EXTERN_heaptype)]))

  ;; 6-typing.watsup:835.1-839.23
  rule array.init_data {C : context, numtype : numtype, t : valtype, vectype : vectype, x : idx, y : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.INIT_DATA_instr(x, y), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
    -- if ((t = (numtype <: valtype)) \/ (t = (vectype <: valtype)))
    -- if (C.DATA_context[y] = OK)

  ;; 6-typing.watsup:830.1-833.43
  rule array.init_elem {C : context, x : idx, y : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.INIT_ELEM_instr(x, y), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
    -- Storagetype_sub: `%|-%<:%`(C, (C.ELEM_context[y] <: storagetype), zt)

  ;; 6-typing.watsup:824.1-828.40
  rule array.copy {C : context, mut : mut, x_1 : idx, x_2 : idx, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%:%`(C, ARRAY.COPY_instr(x_1, x_2), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x_1) <: heaptype)) I32_valtype REF_valtype(`NULL%?`(?(())), ($idx(x_2) <: heaptype)) I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x_1], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt_1)))
    -- Expand: `%~~%`(C.TYPE_context[x_2], ARRAY_comptype(`%%`(mut, zt_2)))
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

  ;; 6-typing.watsup:820.1-822.41
  rule array.fill {C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.FILL_instr(x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype $unpacktype(zt) I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:816.1-818.41
  rule array.len {C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.LEN_instr, `%->%`([REF_valtype(`NULL%?`(?(())), ARRAY_heaptype)], [I32_valtype]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:812.1-814.41
  rule array.set {C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.SET_instr(x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype $unpacktype(zt)], []))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:807.1-810.43
  rule array.get {C : context, mut : mut, sx? : sx?, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.GET_instr(sx?{sx}, x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype], [$unpacktype(zt)]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))
    -- if ((sx?{sx} = ?()) <=> (zt = ($unpacktype(zt) <: storagetype)))

  ;; 6-typing.watsup:801.1-805.23
  rule array.new_data {C : context, mut : mut, numtype : numtype, t : valtype, vectype : vectype, x : idx, y : idx}:
    `%|-%:%`(C, ARRAY.NEW_DATA_instr(x, y), `%->%`([I32_valtype I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, (t <: storagetype))))
    -- if ((t = (numtype <: valtype)) \/ (t = (vectype <: valtype)))
    -- if (C.DATA_context[y] = OK)

  ;; 6-typing.watsup:796.1-799.39
  rule array.new_elem {C : context, mut : mut, rt : reftype, x : idx, y : idx}:
    `%|-%:%`(C, ARRAY.NEW_ELEM_instr(x, y), `%->%`([I32_valtype I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, (rt <: storagetype))))
    -- Reftype_sub: `%|-%<:%`(C, C.ELEM_context[y], rt)

  ;; 6-typing.watsup:792.1-794.41
  rule array.new_fixed {C : context, mut : mut, n : n, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.NEW_FIXED_instr(x, n), `%->%`([$unpacktype(zt)], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))

  ;; 6-typing.watsup:787.1-790.40
  rule array.new_default {C : context, mut : mut, val : val, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.NEW_DEFAULT_instr(x), `%->%`([I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))
    -- if ($default($unpacktype(zt)) = ?(val))

  ;; 6-typing.watsup:783.1-785.41
  rule array.new {C : context, mut : mut, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.NEW_instr(x), `%->%`([$unpacktype(zt) I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))

  ;; 6-typing.watsup:775.1-778.24
  rule struct.set {C : context, i : nat, x : idx, yt* : fieldtype*, zt : storagetype}:
    `%|-%:%`(C, STRUCT.SET_instr(x, i), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) $unpacktype(zt)], []))
    -- Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(yt*{yt}))
    -- if (yt*{yt}[i] = `%%`(`MUT%?`(?(())), zt))

  ;; 6-typing.watsup:769.1-773.43
  rule struct.get {C : context, i : nat, mut : mut, sx? : sx?, x : idx, yt* : fieldtype*, zt : storagetype}:
    `%|-%:%`(C, STRUCT.GET_instr(sx?{sx}, x, i), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype))], [$unpacktype(zt)]))
    -- Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(yt*{yt}))
    -- if (yt*{yt}[i] = `%%`(mut, zt))
    -- if ((sx?{sx} = ?()) <=> (zt = ($unpacktype(zt) <: storagetype)))

  ;; 6-typing.watsup:764.1-767.43
  rule struct.new_default {C : context, mut* : mut*, val* : val*, x : idx, zt* : storagetype*}:
    `%|-%:%`(C, STRUCT.NEW_DEFAULT_instr(x), `%->%`($unpacktype(zt)*{zt}, [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- (if ($default($unpacktype(zt)) = ?(val)))*{val zt}

  ;; 6-typing.watsup:760.1-762.43
  rule struct.new {C : context, mut* : mut*, x : idx, zt* : storagetype*}:
    `%|-%:%`(C, STRUCT.NEW_instr(x), `%->%`($unpacktype(zt)*{zt}, [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(`%%`(mut, zt)*{mut zt}))

  ;; 6-typing.watsup:754.1-755.42
  rule i31.get {C : context, sx : sx}:
    `%|-%:%`(C, I31.GET_instr(sx), `%->%`([REF_valtype(`NULL%?`(?(())), I31_heaptype)], [I32_valtype]))

  ;; 6-typing.watsup:745.1-749.33
  rule ref.cast {C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.CAST_instr(rt), `%->%`([(rt' <: valtype)], [(rt <: valtype)]))
    -- Reftype_ok: `%|-%:OK`(C, rt)
    -- Reftype_ok: `%|-%:OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; 6-typing.watsup:739.1-743.33
  rule ref.test {C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.TEST_instr(rt), `%->%`([(rt' <: valtype)], [I32_valtype]))
    -- Reftype_ok: `%|-%:OK`(C, rt)
    -- Reftype_ok: `%|-%:OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; 6-typing.watsup:736.1-737.51
  rule ref.eq {C : context}:
    `%|-%:%`(C, REF.EQ_instr, `%->%`([REF_valtype(`NULL%?`(?(())), EQ_heaptype) REF_valtype(`NULL%?`(?(())), EQ_heaptype)], [I32_valtype]))

  ;; 6-typing.watsup:732.1-734.31
  rule ref.as_non_null {C : context, ht : heaptype}:
    `%|-%:%`(C, REF.AS_NON_NULL_instr, `%->%`([REF_valtype(`NULL%?`(?(())), ht)], [REF_valtype(`NULL%?`(?()), ht)]))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:729.1-730.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([(rt <: valtype)], [I32_valtype]))

  ;; 6-typing.watsup:726.1-727.34
  rule ref.i31 {C : context}:
    `%|-%:%`(C, REF.I31_instr, `%->%`([I32_valtype], [REF_valtype(`NULL%?`(?()), I31_heaptype)]))

  ;; 6-typing.watsup:722.1-724.23
  rule ref.func {C : context, dt : deftype, epsilon : resulttype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`(epsilon, [REF_valtype(`NULL%?`(?()), (dt <: heaptype))]))
    -- if (C.FUNC_context[x] = dt)

  ;; 6-typing.watsup:717.1-719.31
  rule ref.null {C : context, ht : heaptype}:
    `%|-%:%`(C, REF.NULL_instr(ht), `%->%`([], [REF_valtype(`NULL%?`(?(())), ht)]))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:710.1-712.24
  rule convert-f {C : context, fnn_1 : fnn, fnn_2 : fnn}:
    `%|-%:%`(C, CVTOP_instr((fnn_1 <: numtype), CONVERT_cvtop, (fnn_2 <: numtype), ?()), `%->%`([(fnn_2 <: valtype)], [(fnn_1 <: valtype)]))
    -- if (fnn_1 =/= fnn_2)

  ;; 6-typing.watsup:705.1-708.50
  rule convert-i {C : context, inn_1 : inn, inn_2 : inn, sx? : sx?}:
    `%|-%:%`(C, CVTOP_instr((inn_1 <: numtype), CONVERT_cvtop, (inn_2 <: numtype), sx?{sx}), `%->%`([(inn_2 <: valtype)], [(inn_1 <: valtype)]))
    -- if (inn_1 =/= inn_2)
    -- if ((sx?{sx} = ?()) <=> ($size(inn_1 <: valtype) > $size(inn_2 <: valtype)))

  ;; 6-typing.watsup:700.1-703.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([(nt_2 <: valtype)], [(nt_1 <: valtype)]))
    -- if (nt_1 =/= nt_2)
    -- if ($size(nt_1 <: valtype) = $size(nt_2 <: valtype))

  ;; 6-typing.watsup:696.1-698.23
  rule extend {C : context, n : n, nt : numtype}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([(nt <: valtype)], [(nt <: valtype)]))
    -- if (n <= $size(nt <: valtype))

  ;; 6-typing.watsup:692.1-693.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([(nt <: valtype) (nt <: valtype)], [I32_valtype]))

  ;; 6-typing.watsup:689.1-690.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([(nt <: valtype)], [I32_valtype]))

  ;; 6-typing.watsup:686.1-687.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([(nt <: valtype) (nt <: valtype)], [(nt <: valtype)]))

  ;; 6-typing.watsup:683.1-684.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([(nt <: valtype)], [(nt <: valtype)]))

  ;; 6-typing.watsup:680.1-681.33
  rule const {C : context, c_nt : c, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [(nt <: valtype)]))

  ;; 6-typing.watsup:669.1-675.40
  rule return_call_indirect {C : context, lim : limits, rt : reftype, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*, t_4* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, RETURN_CALL_INDIRECT_instr(x, y), `%->%`(t_3*{t_3} :: t_1*{t_1} :: [I32_valtype], t_4*{t_4}))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPE_context[y], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:663.1-667.40
  rule return_call_ref {C : context, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*, t_4* : valtype*, x : idx}:
    `%|-%:%`(C, RETURN_CALL_REF_instr(?(x)), `%->%`(t_3*{t_3} :: t_1*{t_1} :: [REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype))], t_4*{t_4}))
    -- Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:657.1-661.40
  rule return_call {C : context, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*, t_4* : valtype*, x : idx}:
    `%|-%:%`(C, RETURN_CALL_instr(x), `%->%`(t_3*{t_3} :: t_1*{t_1}, t_4*{t_4}))
    -- Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:651.1-655.46
  rule call_indirect {C : context, lim : limits, rt : reftype, t_1* : valtype*, t_2* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, y), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPE_context[y], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:647.1-649.46
  rule call_ref {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_REF_instr(?(x)), `%->%`(t_1*{t_1} :: [REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype))], t_2*{t_2}))
    -- Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:643.1-645.46
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:639.1-641.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 6-typing.watsup:628.1-634.49
  rule br_on_cast_fail {C : context, l : labelidx, rt : reftype, rt_1 : reftype, rt_2 : reftype, t* : valtype*}:
    `%|-%:%`(C, BR_ON_CAST_FAIL_instr(l, rt_1, rt_2), `%->%`(t*{t} :: [(rt_1 <: valtype)], t*{t} :: [(rt_2 <: valtype)]))
    -- if (C.LABEL_context[l] = t*{t} :: [(rt <: valtype)])
    -- Reftype_ok: `%|-%:OK`(C, rt_1)
    -- Reftype_ok: `%|-%:OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, $diffrt(rt_1, rt_2), rt)

  ;; 6-typing.watsup:620.1-626.34
  rule br_on_cast {C : context, l : labelidx, rt : reftype, rt_1 : reftype, rt_2 : reftype, t* : valtype*}:
    `%|-%:%`(C, BR_ON_CAST_instr(l, rt_1, rt_2), `%->%`(t*{t} :: [(rt_1 <: valtype)], t*{t} :: [($diffrt(rt_1, rt_2) <: valtype)]))
    -- if (C.LABEL_context[l] = t*{t} :: [(rt <: valtype)])
    -- Reftype_ok: `%|-%:OK`(C, rt_1)
    -- Reftype_ok: `%|-%:OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt)

  ;; 6-typing.watsup:615.1-618.31
  rule br_on_non_null {C : context, ht : heaptype, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_ON_NON_NULL_instr(l), `%->%`(t*{t} :: [REF_valtype(`NULL%?`(?(())), ht)], t*{t}))
    -- if (C.LABEL_context[l] = t*{t} :: [REF_valtype(`NULL%?`(?()), ht)])
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:610.1-613.31
  rule br_on_null {C : context, ht : heaptype, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_ON_NULL_instr(l), `%->%`(t*{t} :: [REF_valtype(`NULL%?`(?(())), ht)], t*{t} :: [REF_valtype(`NULL%?`(?()), ht)]))
    -- if (C.LABEL_context[l] = t*{t})
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:605.1-608.44
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `%|-%*<:%*`(C, t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `%|-%*<:%*`(C, t*{t}, C.LABEL_context[l'])

  ;; 6-typing.watsup:601.1-603.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 6-typing.watsup:597.1-599.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 6-typing.watsup:588.1-592.65
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*, x_1* : idx*, x_2* : idx*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%*%`(t_1*{t_1}, x_1*{x_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%*%`(t_1*{t_1}, x_2*{x_2}, t_2*{t_2}))

  ;; 6-typing.watsup:583.1-586.61
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1*{t_1}], RETURN ?()}, instr*{instr}, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))

  ;; 6-typing.watsup:578.1-581.61
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr*{instr}, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))

  ;; 6-typing.watsup:557.1-560.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `%|-%<:%`(C, t, t')
    -- if ((t' = (numtype <: valtype)) \/ (t' = (vectype <: valtype)))

  ;; 6-typing.watsup:554.1-555.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?([t])), `%->%`([t t I32_valtype], [t]))

  ;; 6-typing.watsup:550.1-551.23
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 6-typing.watsup:547.1-548.24
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 6-typing.watsup:544.1-545.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

;; 6-typing.watsup:504.1-504.67
relation Instrf_ok: `%|-%:%`(context, instr, instrtype)
  ;; 6-typing.watsup:861.1-863.28
  rule local.tee {C : context, init : init, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%*%`([t], [x], [t]))
    -- if (C.LOCAL_context[x] = `%%`(init, t))

  ;; 6-typing.watsup:857.1-859.28
  rule local.set {C : context, init : init, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%*%`([t], [x], []))
    -- if (C.LOCAL_context[x] = `%%`(init, t))

  ;; 6-typing.watsup:518.1-520.41
  rule instr {C : context, instr : instr, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, instr, `%->%*%`(t_1*{t_1}, [], t_2*{t_2}))
    -- Instr_ok: `%|-%:%`(C, instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

;; 6-typing.watsup:505.1-505.74
relation Instrs_ok: `%|-%*:%`(context, instr*, instrtype)
  ;; 6-typing.watsup:537.1-539.47
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%*:%`(C, instr*{instr}, `%->%*%`(t*{t} :: t_1*{t_1}, x*{x}, t*{t} :: t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C, instr*{instr}, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))

  ;; 6-typing.watsup:532.1-535.35
  rule sub {C : context, instr* : instr*, it : instrtype, it' : instrtype}:
    `%|-%*:%`(C, instr*{instr}, it')
    -- Instrs_ok: `%|-%*:%`(C, instr*{instr}, it)
    -- Instrtype_sub: `%|-%<:%`(C, it, it')

  ;; 6-typing.watsup:525.1-530.52
  rule seq {C : context, C' : context, init* : init*, instr_1 : instr, instr_2* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*, x_1* : idx*, x_2* : idx*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{instr_2}, `%->%*%`(t_1*{t_1}, x_1*{x_1} :: x_2*{x_2}, t_3*{t_3}))
    -- (if (C.LOCAL_context[x_1] = `%%`(init, t)))*{init t x_1}
    -- if (C' = $with_locals(C, x_1*{x_1}, `%%`(SET_init, t)*{t}))
    -- Instrf_ok: `%|-%:%`(C, instr_1, `%->%*%`(t_1*{t_1}, x_1*{x_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C', instr_2*{instr_2}, `%->%*%`(t_2*{t_2}, x_2*{x_2}, t_3*{t_3}))

  ;; 6-typing.watsup:522.1-523.29
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%*%`([], [], []))
}

;; 6-typing.watsup:506.1-506.72
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 6-typing.watsup:511.1-513.45
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- Instrs_ok: `%|-%*:%`(C, instr*{instr}, `%->%*%`([], [], t*{t}))

;; 6-typing.watsup:985.1-985.64
rec {

;; 6-typing.watsup:985.1-985.64
def in_binop : (binop_numtype, ibinop*) -> bool
  ;; 6-typing.watsup:987.1-987.92
  def {binop : binop_numtype, ibinop'* : ibinop*, ibinop_1 : ibinop} in_binop(binop, [ibinop_1] :: ibinop'*{ibinop'}) = ((binop = _I_binop_numtype(ibinop_1)) \/ $in_binop(binop, ibinop'*{ibinop'}))
  ;; 6-typing.watsup:986.1-986.38
  def {binop : binop_numtype, epsilon : ibinop*} in_binop(binop, epsilon) = false
}

;; 6-typing.watsup:981.1-981.63
rec {

;; 6-typing.watsup:981.1-981.63
def in_numtype : (numtype, numtype*) -> bool
  ;; 6-typing.watsup:983.1-983.68
  def {nt : numtype, nt'* : numtype*, nt_1 : numtype} in_numtype(nt, [nt_1] :: nt'*{nt'}) = ((nt = nt_1) \/ $in_numtype(nt, nt'*{nt'}))
  ;; 6-typing.watsup:982.1-982.37
  def {epsilon : numtype*, nt : numtype} in_numtype(nt, epsilon) = false
}

;; 6-typing.watsup:963.1-963.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 6-typing.watsup:989.1-992.38
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%CONST`(C, BINOP_instr(nt, binop))
    -- if $in_numtype(nt, [I32_numtype I64_numtype])
    -- if $in_binop(binop, [ADD_ibinop SUB_ibinop MUL_ibinop])

  ;; 6-typing.watsup:976.1-978.24
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?()), t))

  ;; 6-typing.watsup:973.1-974.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 6-typing.watsup:970.1-971.27
  rule ref.null {C : context, ht : heaptype}:
    `%|-%CONST`(C, REF.NULL_instr(ht))

  ;; 6-typing.watsup:967.1-968.26
  rule const {C : context, c : c, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

;; 6-typing.watsup:964.1-964.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 6-typing.watsup:995.1-996.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 6-typing.watsup:965.1-965.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 6-typing.watsup:999.1-1002.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 6-typing.watsup:1011.1-1011.73
relation Type_ok: `%|-%:%*`(context, type, deftype*)
  ;; 6-typing.watsup:1023.1-1027.53
  rule _ {C : context, dt* : deftype*, rectype : rectype, x : idx}:
    `%|-%:%*`(C, TYPE(rectype), dt*{dt})
    -- if (x = |C.TYPE_context|)
    -- if (dt*{dt} = $rolldt(x, rectype))
    -- Rectype_ok: `%|-%:%`(C[TYPE_context =.. dt*{dt}], rectype, OK_oktypeidx(x))

;; 6-typing.watsup:1013.1-1013.74
relation Local_ok: `%|-%:%`(context, local, localtype)
  ;; 6-typing.watsup:1033.1-1035.26
  rule unset {C : context, t : valtype}:
    `%|-%:%`(C, LOCAL(t), `%%`(UNSET_init, t))
    -- if ($default(t) = ?())

  ;; 6-typing.watsup:1029.1-1031.28
  rule set {C : context, t : valtype}:
    `%|-%:%`(C, LOCAL(t), `%%`(SET_init, t))
    -- if ($default(t) =/= ?())

;; 6-typing.watsup:1012.1-1012.73
relation Func_ok: `%|-%:%`(context, func, deftype)
  ;; 6-typing.watsup:1037.1-1041.82
  rule _ {C : context, expr : expr, local* : local*, lt* : localtype*, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, `FUNC%%*%`(x, local*{local}, expr), C.TYPE_context[x])
    -- Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- (Local_ok: `%|-%:%`(C, local, lt))*{local lt}
    -- Expr_ok: `%|-%:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL `%%`(SET_init, t_1)*{t_1} :: lt*{lt}, LABEL [], RETURN ?()} ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 6-typing.watsup:1014.1-1014.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 6-typing.watsup:1043.1-1047.40
  rule _ {C : context, expr : expr, gt : globaltype, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `%|-%:OK`(C, gt)
    -- if (gt = `%%`(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 6-typing.watsup:1015.1-1015.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 6-typing.watsup:1049.1-1053.41
  rule _ {C : context, expr : expr, limits : limits, rt : reftype, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt, expr), tt)
    -- Tabletype_ok: `%|-%:OK`(C, tt)
    -- if (tt = `%%`(limits, rt))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, (rt <: valtype))

;; 6-typing.watsup:1016.1-1016.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 6-typing.watsup:1055.1-1057.30
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `%|-%:OK`(C, mt)

;; 6-typing.watsup:1019.1-1019.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 6-typing.watsup:1076.1-1077.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

  ;; 6-typing.watsup:1073.1-1074.20
  rule passive {C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; 6-typing.watsup:1068.1-1071.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

;; 6-typing.watsup:1017.1-1017.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 6-typing.watsup:1059.1-1062.37
  rule _ {C : context, elemmode : elemmode, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%`(rt, expr*{expr}, elemmode), rt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, (rt <: valtype)))*{expr}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, rt)

;; 6-typing.watsup:1020.1-1020.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 6-typing.watsup:1084.1-1085.20
  rule passive {C : context}:
    `%|-%:OK`(C, PASSIVE_datamode)

  ;; 6-typing.watsup:1079.1-1082.45
  rule active {C : context, expr : expr, mt : memtype, x : idx}:
    `%|-%:OK`(C, ACTIVE_datamode(x, expr))
    -- if (C.MEM_context[x] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

;; 6-typing.watsup:1018.1-1018.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 6-typing.watsup:1064.1-1066.37
  rule _ {C : context, b* : byte*, datamode : datamode}:
    `%|-%:OK`(C, `DATA%*%`(b*{b}, datamode))
    -- Datamode_ok: `%|-%:OK`(C, datamode)

;; 6-typing.watsup:1021.1-1021.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 6-typing.watsup:1087.1-1089.44
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`([], [])))

;; 6-typing.watsup:1094.1-1094.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 6-typing.watsup:1098.1-1100.33
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `%|-%:OK`(C, xt)

;; 6-typing.watsup:1096.1-1096.83
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; 6-typing.watsup:1119.1-1121.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (C.MEM_context[x] = mt)

  ;; 6-typing.watsup:1115.1-1117.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 6-typing.watsup:1111.1-1113.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 6-typing.watsup:1107.1-1109.23
  rule func {C : context, dt : deftype, x : idx}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype(dt))
    -- if (C.FUNC_context[x] = dt)

;; 6-typing.watsup:1095.1-1095.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 6-typing.watsup:1102.1-1104.39
  rule _ {C : context, externidx : externidx, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externidx), xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 6-typing.watsup:1128.1-1128.77
rec {

;; 6-typing.watsup:1128.1-1128.77
relation Globals_ok: `%|-%*:%*`(context, global*, globaltype*)
  ;; 6-typing.watsup:1174.1-1177.54
  rule cons {C : context, global : global, global_1 : global, gt* : globaltype*, gt_1 : globaltype}:
    `%|-%*:%*`(C, [global_1] :: global*{}, [gt_1] :: gt*{gt})
    -- Global_ok: `%|-%:%`(C, global, gt_1)
    -- Globals_ok: `%|-%*:%*`(C[GLOBAL_context =.. [gt_1]], global*{}, gt*{gt})

  ;; 6-typing.watsup:1171.1-1172.17
  rule empty {C : context}:
    `%|-%*:%*`(C, [], [])
}

;; 6-typing.watsup:1127.1-1127.75
rec {

;; 6-typing.watsup:1127.1-1127.75
relation Types_ok: `%|-%*:%*`(context, type*, deftype*)
  ;; 6-typing.watsup:1166.1-1169.49
  rule cons {C : context, dt* : deftype*, dt_1 : deftype, type* : type*, type_1 : type}:
    `%|-%*:%*`(C, [type_1] :: type*{type}, dt_1*{} :: dt*{dt})
    -- Type_ok: `%|-%:%*`(C, type_1, [dt_1])
    -- Types_ok: `%|-%*:%*`(C[TYPE_context =.. dt_1*{}], type*{type}, dt*{dt})

  ;; 6-typing.watsup:1163.1-1164.17
  rule empty {C : context}:
    `%|-%*:%*`(C, [], [])
}

;; 6-typing.watsup:1126.1-1126.76
relation Module_ok: `|-%:OK`(module)
  ;; 6-typing.watsup:1137.1-1160.29
  rule _ {C : context, C' : context, data^n : data^n, dt* : deftype*, dt'* : deftype*, elem* : elem*, et* : externtype*, export* : export*, func* : func*, global* : global*, gt* : globaltype*, idt* : deftype*, igt* : globaltype*, import* : import*, imt* : memtype*, itt* : tabletype*, ixt* : externtype*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*, type* : type*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- Types_ok: `%|-%*:%*`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, type*{type}, dt'*{dt'})
    -- (Import_ok: `%|-%:%`({TYPE dt'*{dt'}, REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, import, ixt))*{import ixt}
    -- Globals_ok: `%|-%*:%*`(C', global*{global}, gt*{gt})
    -- (Table_ok: `%|-%:%`(C', table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C', mem, mt))*{mem mt}
    -- (Func_ok: `%|-%:%`(C, func, dt))*{dt func}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- (Export_ok: `%|-%:%`(C, export, et))*{et export}
    -- if (C = {TYPE dt'*{dt'}, REC [], FUNC idt*{idt} :: dt*{dt}, GLOBAL igt*{igt} :: gt*{gt}, TABLE itt*{itt} :: tt*{tt}, MEM imt*{imt} :: mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- if (C' = {TYPE dt'*{dt'}, REC [], FUNC idt*{idt} :: dt*{dt}, GLOBAL igt*{igt}, TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()})
    -- if (idt*{idt} = $funcsxt(ixt*{ixt}))
    -- if (igt*{igt} = $globalsxt(ixt*{ixt}))
    -- if (itt*{itt} = $tablesxt(ixt*{ixt}))
    -- if (imt*{imt} = $memsxt(ixt*{ixt}))

;; 7-runtime-typing.watsup:5.1-5.40
relation Ref_ok: `%|-%:%`(store, ref, reftype)
  ;; 7-runtime-typing.watsup:28.1-29.45
  rule extern {addrref : addrref, s : store}:
    `%|-%:%`(s, REF.EXTERN_ref(addrref), REF_reftype(`NULL%?`(?()), EXTERN_heaptype))

  ;; 7-runtime-typing.watsup:25.1-26.39
  rule host {a : addr, s : store}:
    `%|-%:%`(s, REF.HOST_ADDR_ref(a), REF_reftype(`NULL%?`(?()), ANY_heaptype))

  ;; 7-runtime-typing.watsup:21.1-23.28
  rule func {a : addr, dt : deftype, s : store}:
    `%|-%:%`(s, REF.FUNC_ADDR_ref(a), REF_reftype(`NULL%?`(?()), (dt <: heaptype)))
    -- if (s.FUNC_store[a].TYPE_funcinst = dt)

  ;; 7-runtime-typing.watsup:17.1-19.29
  rule array {a : addr, dt : deftype, s : store}:
    `%|-%:%`(s, REF.ARRAY_ADDR_ref(a), REF_reftype(`NULL%?`(?()), (dt <: heaptype)))
    -- if (s.ARRAY_store[a].TYPE_arrayinst = dt)

  ;; 7-runtime-typing.watsup:13.1-15.30
  rule struct {a : addr, dt : deftype, s : store}:
    `%|-%:%`(s, REF.STRUCT_ADDR_ref(a), REF_reftype(`NULL%?`(?()), (dt <: heaptype)))
    -- if (s.STRUCT_store[a].TYPE_structinst = dt)

  ;; 7-runtime-typing.watsup:10.1-11.37
  rule i31 {i : nat, s : store}:
    `%|-%:%`(s, REF.I31_NUM_ref(i), REF_reftype(`NULL%?`(?()), I31_heaptype))

  ;; 7-runtime-typing.watsup:7.1-8.35
  rule null {ht : heaptype, s : store}:
    `%|-%:%`(s, REF.NULL_ref(ht), REF_reftype(`NULL%?`(?(())), ht))

;; 8-reduction.watsup:6.1-6.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 8-reduction.watsup:552.1-553.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([(val <: admininstr) LOCAL.TEE_admininstr(x)], [(val <: admininstr) (val <: admininstr) LOCAL.SET_admininstr(x)])

  ;; 8-reduction.watsup:539.1-540.55
  rule any.convert_extern-addr {addrref : addrref}:
    `%*~>%*`([REF.EXTERN_admininstr(addrref) ANY.CONVERT_EXTERN_admininstr], [(addrref <: admininstr)])

  ;; 8-reduction.watsup:536.1-537.55
  rule any.convert_extern-null {ht : heaptype}:
    `%*~>%*`([REF.NULL_admininstr(ht) ANY.CONVERT_EXTERN_admininstr], [REF.NULL_admininstr(ANY_heaptype)])

  ;; 8-reduction.watsup:532.1-533.55
  rule extern.convert_any-addr {addrref : addrref}:
    `%*~>%*`([(addrref <: admininstr) EXTERN.CONVERT_ANY_admininstr], [REF.EXTERN_admininstr(addrref)])

  ;; 8-reduction.watsup:529.1-530.58
  rule extern.convert_any-null {ht : heaptype}:
    `%*~>%*`([REF.NULL_admininstr(ht) EXTERN.CONVERT_ANY_admininstr], [REF.NULL_admininstr(EXTERN_heaptype)])

  ;; 8-reduction.watsup:311.1-312.68
  rule i31.get-num {i : nat, sx : sx}:
    `%*~>%*`([REF.I31_NUM_admininstr(i) I31.GET_admininstr(sx)], [CONST_admininstr(I32_numtype, $ext(31, 32, sx, i))])

  ;; 8-reduction.watsup:308.1-309.39
  rule i31.get-null {ht : heaptype, sx : sx}:
    `%*~>%*`([REF.NULL_admininstr(ht) I31.GET_admininstr(sx)], [TRAP_admininstr])

  ;; 8-reduction.watsup:281.1-283.15
  rule ref.eq-false {ref_1 : ref, ref_2 : ref}:
    `%*~>%*`([(ref_1 <: admininstr) (ref_2 <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:276.1-279.22
  rule ref.eq-true {ref_1 : ref, ref_2 : ref}:
    `%*~>%*`([(ref_1 <: admininstr) (ref_2 <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- otherwise
    -- if (ref_1 = ref_2)

  ;; 8-reduction.watsup:272.1-274.55
  rule ref.eq-null {ht_1 : heaptype, ht_2 : heaptype, ref_1 : ref, ref_2 : ref}:
    `%*~>%*`([(ref_1 <: admininstr) (ref_2 <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if ((ref_1 = REF.NULL_ref(ht_1)) /\ (ref_2 = REF.NULL_ref(ht_2)))

  ;; 8-reduction.watsup:267.1-269.15
  rule ref.as_non_null-addr {ref : ref}:
    `%*~>%*`([(ref <: admininstr) REF.AS_NON_NULL_admininstr], [(ref <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup:263.1-265.28
  rule ref.as_non_null-null {ht : heaptype, ref : ref}:
    `%*~>%*`([(ref <: admininstr) REF.AS_NON_NULL_admininstr], [TRAP_admininstr])
    -- if (ref = REF.NULL_ref(ht))

  ;; 8-reduction.watsup:258.1-260.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([(val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:254.1-256.28
  rule ref.is_null-true {ht : heaptype, val : val}:
    `%*~>%*`([(val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup:250.1-251.60
  rule ref.i31 {i : nat}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) REF.I31_admininstr], [REF.I31_NUM_admininstr($wrap(32, 31, i))])

  ;; 8-reduction.watsup:240.1-242.50
  rule cvtop-trap {c_1 : c, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(cvtop, nt_1, nt_2, sx?{sx}, c_1) = [])

  ;; 8-reduction.watsup:236.1-238.48
  rule cvtop-val {c : c, c_1 : c, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(cvtop, nt_1, nt_2, sx?{sx}, c_1) = [c])

  ;; 8-reduction.watsup:232.1-233.70
  rule extend {c : c, n : n, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, $size(nt <: valtype), S_sx, c))])

  ;; 8-reduction.watsup:227.1-229.40
  rule relop {c : c, c_1 : c, c_2 : c, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 8-reduction.watsup:223.1-225.37
  rule testop {c : c, c_1 : c, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 8-reduction.watsup:218.1-220.42
  rule binop-trap {binop : binop_numtype, c_1 : c, c_2 : c, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 8-reduction.watsup:214.1-216.40
  rule binop-val {binop : binop_numtype, c : c, c_1 : c, c_2 : c, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 8-reduction.watsup:209.1-211.35
  rule unop-trap {c_1 : c, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 8-reduction.watsup:205.1-207.33
  rule unop-val {c : c, c_1 : c, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 8-reduction.watsup:199.1-200.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, (val <: admininstr)*{val} :: [RETURN_admininstr] :: (instr <: admininstr)*{instr})], (val <: admininstr)*{val} :: [RETURN_admininstr])

  ;; 8-reduction.watsup:196.1-197.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [RETURN_admininstr] :: (instr <: admininstr)*{instr})], (val <: admininstr)^n{val})

  ;; 8-reduction.watsup:193.1-194.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, (val <: admininstr)^n{val})], (val <: admininstr)^n{val})

  ;; 8-reduction.watsup:189.1-190.98
  rule return_call_indirect {x : idx, y : idx}:
    `%*~>%*`([RETURN_CALL_INDIRECT_admininstr(x, y)], [TABLE.GET_admininstr(x) REF.CAST_admininstr(REF_reftype(`NULL%?`(?(())), ($idx(y) <: heaptype))) RETURN_CALL_REF_admininstr(?(y))])

  ;; 8-reduction.watsup:186.1-187.84
  rule call_indirect-call {x : idx, y : idx}:
    `%*~>%*`([CALL_INDIRECT_admininstr(x, y)], [TABLE.GET_admininstr(x) REF.CAST_admininstr(REF_reftype(`NULL%?`(?(())), ($idx(y) <: heaptype))) CALL_REF_admininstr(?(y))])

  ;; 8-reduction.watsup:130.1-132.15
  rule br_on_non_null-addr {l : labelidx, val : val}:
    `%*~>%*`([(val <: admininstr) BR_ON_NON_NULL_admininstr(l)], [(val <: admininstr) BR_admininstr(l)])
    -- otherwise

  ;; 8-reduction.watsup:126.1-128.26
  rule br_on_non_null-null {ht : heaptype, l : labelidx, val : val}:
    `%*~>%*`([(val <: admininstr) BR_ON_NON_NULL_admininstr(l)], [])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup:121.1-123.15
  rule br_on_null-addr {l : labelidx, val : val}:
    `%*~>%*`([(val <: admininstr) BR_ON_NULL_admininstr(l)], [(val <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup:117.1-119.26
  rule br_on_null-null {ht : heaptype, l : labelidx, val : val}:
    `%*~>%*`([(val <: admininstr) BR_ON_NULL_admininstr(l)], [BR_admininstr(l)])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup:112.1-114.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 8-reduction.watsup:108.1-110.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 8-reduction.watsup:103.1-105.14
  rule br_if-false {c : c, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 8-reduction.watsup:99.1-101.16
  rule br_if-true {c : c, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 8-reduction.watsup:95.1-96.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val <: admininstr)*{val} :: [BR_admininstr(l + 1)] :: (instr <: admininstr)*{instr})], (val <: admininstr)*{val} :: [BR_admininstr(l)])

  ;; 8-reduction.watsup:92.1-93.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [BR_admininstr(0)] :: (instr <: admininstr)*{instr})], (val <: admininstr)^n{val} :: (instr' <: admininstr)*{instr'})

  ;; 8-reduction.watsup:85.1-86.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, (val <: admininstr)*{val})], (val <: admininstr)*{val})

  ;; 8-reduction.watsup:80.1-82.14
  rule if-false {bt : blocktype, c : c, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 8-reduction.watsup:76.1-78.16
  rule if-true {bt : blocktype, c : c, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 8-reduction.watsup:56.1-58.14
  rule select-false {c : c, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([(val_1 <: admininstr) (val_2 <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [(val_2 <: admininstr)])
    -- if (c = 0)

  ;; 8-reduction.watsup:52.1-54.16
  rule select-true {c : c, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([(val_1 <: admininstr) (val_2 <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [(val_1 <: admininstr)])
    -- if (c =/= 0)

  ;; 8-reduction.watsup:48.1-49.20
  rule drop {val : val}:
    `%*~>%*`([(val <: admininstr) DROP_admininstr], [])

  ;; 8-reduction.watsup:45.1-46.15
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 8-reduction.watsup:42.1-43.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

;; 8-reduction.watsup:63.1-63.73
def blocktype : (state, blocktype) -> functype
  ;; 8-reduction.watsup:66.1-66.66
  def {ft : functype, x : idx, z : state} blocktype(z, _IDX_blocktype(x)) = ft
    -- Expand: `%~~%`($type(z, x), FUNC_comptype(ft))
  ;; 8-reduction.watsup:65.1-65.40
  def {t : valtype, z : state} blocktype(z, _RESULT_blocktype(?(t))) = `%->%`([], [t])
  ;; 8-reduction.watsup:64.1-64.44
  def {z : state} blocktype(z, _RESULT_blocktype(?())) = `%->%`([], [])

;; 8-reduction.watsup:7.1-7.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 8-reduction.watsup:753.1-757.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, y).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), x, $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup:748.1-751.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:744.1-746.70
  rule memory.init-oob {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, y).DATA_datainst|) \/ ((j + n) > |$mem(z, x).DATA_meminst|))

  ;; 8-reduction.watsup:737.1-741.15
  rule memory.copy-gt {i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [CONST_admininstr(I32_numtype, ((i_1 + n) - 1)) CONST_admininstr(I32_numtype, ((i_2 + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), x_2, $memop0) STORE_admininstr(I32_numtype, ?(8), x_1, $memop0) CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr(x_1, x_2)])
    -- otherwise

  ;; 8-reduction.watsup:730.1-735.19
  rule memory.copy-le {i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) LOAD_admininstr(I32_numtype, ?((8, U_sx)), x_2, $memop0) STORE_admininstr(I32_numtype, ?(8), x_1, $memop0) CONST_admininstr(I32_numtype, (i_1 + 1)) CONST_admininstr(I32_numtype, (i_2 + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- if (i_1 <= i_2)

  ;; 8-reduction.watsup:725.1-728.14
  rule memory.copy-zero {i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:721.1-723.77
  rule memory.copy-oob {i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if (((i_1 + n) > |$mem(z, x_1).DATA_meminst|) \/ ((i_2 + n) > |$mem(z, x_2).DATA_meminst|))

  ;; 8-reduction.watsup:714.1-718.15
  rule memory.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) (val <: admininstr) STORE_admininstr(I32_numtype, ?(8), x, $memop0) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup:709.1-712.14
  rule memory.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:705.1-707.37
  rule memory.fill-oob {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:692.1-694.44
  rule memory.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:670.1-672.61
  rule load-pack-val {c : c, i : nat, mo : memop, n : n, nt : numtype, sx : sx, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), x, mo)]), [CONST_admininstr(nt, $ext(n, $size(nt <: valtype), sx, c))])
    -- if ($ibytes(n, c) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])

  ;; 8-reduction.watsup:666.1-668.51
  rule load-pack-oob {i : nat, mo : memop, n : n, nt : numtype, sx : sx, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:662.1-664.71
  rule load-num-val {c : c, i : nat, mo : memop, nt : numtype, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), x, mo)]), [CONST_admininstr(nt, c)])
    -- if ($ntbytes(nt, c) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop) : ($size(nt <: valtype) / 8)])

  ;; 8-reduction.watsup:658.1-660.59
  rule load-num-oob {i : nat, mo : memop, nt : numtype, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + ($size(nt <: valtype) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:645.1-649.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) ($elem(z, y).ELEM_eleminst[i] <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup:640.1-643.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:636.1-638.72
  rule table.init-oob {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 8-reduction.watsup:629.1-633.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup:622.1-627.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 8-reduction.watsup:617.1-620.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:613.1-615.73
  rule table.copy-oob {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 8-reduction.watsup:606.1-610.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) (val <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup:601.1-604.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:597.1-599.39
  rule table.fill-oob {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:584.1-586.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 8-reduction.watsup:571.1-573.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [($table(z, x).ELEM_tableinst[i] <: admininstr)])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:567.1-569.33
  rule table.get-oob {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:558.1-559.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [($global(z, x).VALUE_globalinst <: admininstr)])

  ;; 8-reduction.watsup:545.1-547.27
  rule local.get {val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [(val <: admininstr)])
    -- if ($local(z, x) = ?(val))

  ;; 8-reduction.watsup:517.1-524.67
  rule array.init_data-succ {a : addr, c : c, i : nat, j : nat, mut : mut, n : n, nt : numtype, x : idx, y : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (j + ($storagesize(zt) / 8))) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.INIT_DATA_admininstr(x, y)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (nt = $unpacknumtype(zt))
    -- if ($ztbytes(zt, c) = $data(z, y).DATA_datainst[j : ($storagesize(zt) / 8)])

  ;; 8-reduction.watsup:512.1-515.14
  rule array.init_data-zero {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:507.1-510.59
  rule array.init_data-oob2 {a : addr, i : nat, j : nat, mut : mut, n : n, x : idx, y : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ((j + ((n * $storagesize(zt)) / 8)) > |$data(z, y).DATA_datainst|)

  ;; 8-reduction.watsup:503.1-505.44
  rule array.init_data-oob1 {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:500.1-501.93
  rule array.init_data-null {ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:492.1-497.34
  rule array.init_elem-succ {a : addr, i : nat, j : nat, n : n, ref : ref, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (ref <: admininstr) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.INIT_ELEM_admininstr(x, y)])
    -- otherwise
    -- if (ref = $elem(z, y).ELEM_eleminst[j])

  ;; 8-reduction.watsup:487.1-490.14
  rule array.init_elem-zero {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:483.1-485.38
  rule array.init_elem-oob2 {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((j + n) > |$elem(z, y).ELEM_eleminst|)

  ;; 8-reduction.watsup:479.1-481.44
  rule array.init_elem-oob1 {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:476.1-477.93
  rule array.init_elem-null {ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:465.1-473.29
  rule array.copy-gt {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, mut : mut, n : n, sx? : sx?, x_1 : idx, x_2 : idx, z : state, zt_2 : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, ((i_1 + n) - 1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, ((i_2 + n) - 1)) ARRAY.GET_admininstr(sx?{sx}, x_2) ARRAY.SET_admininstr(x_1) REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
    -- if (sx?{sx} = $sxfield(zt_2))

  ;; 8-reduction.watsup:454.1-463.19
  rule array.copy-le {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, mut : mut, n : n, sx? : sx?, x_1 : idx, x_2 : idx, z : state, zt_2 : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) ARRAY.GET_admininstr(sx?{sx}, x_2) ARRAY.SET_admininstr(x_1) REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, (i_1 + 1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, (i_2 + 1)) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
    -- if (sx?{sx} = $sxfield(zt_2))
    -- if (i_1 <= i_2)

  ;; 8-reduction.watsup:449.1-452.14
  rule array.copy-zero {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:445.1-447.48
  rule array.copy-oob2 {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if ((i_2 + n) > |$arrayinst(z)[a_2].FIELD_arrayinst|)

  ;; 8-reduction.watsup:441.1-443.48
  rule array.copy-oob1 {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if ((i_1 + n) > |$arrayinst(z)[a_1].FIELD_arrayinst|)

  ;; 8-reduction.watsup:438.1-439.102
  rule array.copy-null2 {ht_2 : heaptype, i_1 : nat, i_2 : nat, n : n, ref : ref, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, i_1) REF.NULL_admininstr(ht_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:435.1-436.102
  rule array.copy-null1 {ht_1 : heaptype, i_1 : nat, i_2 : nat, n : n, ref : ref, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht_1) CONST_admininstr(I32_numtype, i_1) (ref <: admininstr) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:429.1-433.15
  rule array.fill-succ {a : addr, i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup:424.1-427.14
  rule array.fill-zero {a : addr, i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:420.1-422.44
  rule array.fill-oob {a : addr, i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:417.1-418.76
  rule array.fill-null {ht : heaptype, i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:412.1-414.37
  rule array.len-array {a : addr, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) ARRAY.LEN_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (n = |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:409.1-410.39
  rule array.len-null {ht : heaptype, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) ARRAY.LEN_admininstr]), [TRAP_admininstr])

  ;; 8-reduction.watsup:390.1-393.53
  rule array.get-array {a : addr, fv : fieldval, i : nat, mut : mut, sx? : sx?, x : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) ARRAY.GET_admininstr(sx?{sx}, x)]), [($unpackval(zt, sx?{sx}, fv) <: admininstr)])
    -- if (fv = $arrayinst(z)[a].FIELD_arrayinst[i])
    -- Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))

  ;; 8-reduction.watsup:386.1-388.38
  rule array.get-oob {a : addr, i : nat, sx? : sx?, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) ARRAY.GET_admininstr(sx?{sx}, x)]), [TRAP_admininstr])
    -- if (i >= |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:383.1-384.61
  rule array.get-null {ht : heaptype, i : nat, sx? : sx?, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) ARRAY.GET_admininstr(sx?{sx}, x)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:376.1-380.88
  rule array.new_data-alloc {c^n : c^n, i : nat, mut : mut, n : n, nt : numtype, x : idx, y : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_DATA_admininstr(x, y)]), CONST_admininstr(nt, c)^n{c} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (nt = $unpacknumtype(zt))
    -- if ($concat_bytes($ztbytes(zt, c)^n{c}) = $data(z, y).DATA_datainst[i : ((n * $storagesize(zt)) / 8)])

  ;; 8-reduction.watsup:371.1-374.59
  rule array.new_data-oob {i : nat, mut : mut, n : n, x : idx, y : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ((i + ((n * $storagesize(zt)) / 8)) > |$data(z, y).DATA_datainst|)

  ;; 8-reduction.watsup:366.1-368.40
  rule array.new_elem-alloc {i : nat, n : n, ref^n : ref^n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_ELEM_admininstr(x, y)]), (ref <: admininstr)^n{ref} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- if (ref^n{ref} = $elem(z, y).ELEM_eleminst[i : n])

  ;; 8-reduction.watsup:362.1-364.38
  rule array.new_elem-oob {i : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$elem(z, y).ELEM_eleminst|)

  ;; 8-reduction.watsup:351.1-354.40
  rule array.new_default {mut : mut, n : n, val : val, x : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) ARRAY.NEW_DEFAULT_admininstr(x)]), (val <: admininstr)^n{} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ($default($unpacktype(zt)) = ?(val))

  ;; 8-reduction.watsup:348.1-349.70
  rule array.new {n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [(val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.NEW_admininstr(x)]), (val <: admininstr)^n{} :: [ARRAY.NEW_FIXED_admininstr(x, n)])

  ;; 8-reduction.watsup:331.1-334.41
  rule struct.get-struct {a : addr, i : nat, mut* : mut*, si : structinst, sx? : sx?, x : idx, z : state, zt* : storagetype*}:
    `%~>%*`(`%;%*`(z, [REF.STRUCT_ADDR_admininstr(a) STRUCT.GET_admininstr(sx?{sx}, x, i)]), [($unpackval(zt*{zt}[i], sx?{sx}, si.FIELD_structinst[i]) <: admininstr)])
    -- if ($structinst(z)[a] = si)
    -- Expand: `%~~%`(si.TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))

  ;; 8-reduction.watsup:328.1-329.50
  rule struct.get-null {ht : heaptype, i : nat, sx? : sx?, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) STRUCT.GET_admininstr(sx?{sx}, x, i)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:322.1-325.43
  rule struct.new_default {mut* : mut*, val* : val*, x : idx, z : state, zt* : storagetype*}:
    `%~>%*`(`%;%*`(z, [STRUCT.NEW_DEFAULT_admininstr(x)]), (val <: admininstr)*{val} :: [STRUCT.NEW_admininstr(x)])
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- (if ($default($unpacktype(zt)) = ?(val)))*{val zt}

  ;; 8-reduction.watsup:301.1-303.15
  rule ref.cast-fail {ref : ref, rt : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) REF.CAST_admininstr(rt)]), [TRAP_admininstr])
    -- otherwise

  ;; 8-reduction.watsup:296.1-299.65
  rule ref.cast-succeed {ref : ref, rt : reftype, rt' : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) REF.CAST_admininstr(rt)]), [(ref <: admininstr)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))

  ;; 8-reduction.watsup:291.1-293.15
  rule ref.test-false {ref : ref, rt : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) REF.TEST_admininstr(rt)]), [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:286.1-289.65
  rule ref.test-true {ref : ref, rt : reftype, rt' : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) REF.TEST_admininstr(rt)]), [CONST_admininstr(I32_numtype, 1)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))

  ;; 8-reduction.watsup:247.1-248.55
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

  ;; 8-reduction.watsup:182.1-183.91
  rule return_call_ref-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*, x? : idx?, z : state}:
    `%~>%*`(`%;%*`(z, [LABEL__admininstr(k, instr'*{instr'}, (val <: admininstr)*{val} :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr <: admininstr)*{instr})]), (val <: admininstr)*{val} :: [RETURN_CALL_REF_admininstr(x?{x})])

  ;; 8-reduction.watsup:178.1-180.59
  rule return_call_ref-frame-addr {a : addr, f : frame, instr* : instr*, k : nat, m : m, n : n, t_1^n : valtype^n, t_2^m : valtype^m, val^n : val^n, val'* : val*, x? : idx?, z : state}:
    `%~>%*`(`%;%*`(z, [FRAME__admininstr(k, f, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a)] :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr <: admininstr)*{instr})]), (val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a) CALL_REF_admininstr(x?{x})])
    -- Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))

  ;; 8-reduction.watsup:175.1-176.78
  rule return_call_ref-frame-null {f : frame, ht : heaptype, instr* : instr*, k : nat, val* : val*, x? : idx?, z : state}:
    `%~>%*`(`%;%*`(z, [FRAME__admininstr(k, f, (val <: admininstr)*{val} :: [REF.NULL_admininstr(ht)] :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr <: admininstr)*{instr})]), [TRAP_admininstr])

  ;; 8-reduction.watsup:171.1-172.76
  rule return_call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [RETURN_CALL_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x]) RETURN_CALL_REF_admininstr(?())])

  ;; 8-reduction.watsup:163.1-168.59
  rule call_ref-func {a : addr, f : frame, fi : funcinst, instr* : instr*, m : m, n : n, t* : valtype*, t_1^n : valtype^n, t_2^m : valtype^m, val^n : val^n, x? : idx?, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, (val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a) CALL_REF_admininstr(x?{x})]), [FRAME__admininstr(m, f, [LABEL__admininstr(m, [], (instr <: admininstr)*{instr})])])
    -- if ($funcinst(z)[a] = fi)
    -- Expand: `%~~%`(fi.TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
    -- if (fi.CODE_funcinst = `FUNC%%*%`(y, LOCAL(t)*{t}, instr*{instr}))
    -- if (f = {LOCAL ?(val)^n{val} :: $default(t)*{t}, MODULE fi.MODULE_funcinst})

  ;; 8-reduction.watsup:160.1-161.43
  rule call_ref-null {ht : heaptype, x? : idx?, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CALL_REF_admininstr(x?{x})]), [TRAP_admininstr])

  ;; 8-reduction.watsup:157.1-158.62
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x]) CALL_REF_admininstr(?())])

  ;; 8-reduction.watsup:150.1-152.15
  rule br_on_cast_fail-fail {l : labelidx, ref : ref, rt_1 : reftype, rt_2 : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) BR_ON_CAST_FAIL_admininstr(l, rt_1, rt_2)]), [(ref <: admininstr) BR_admininstr(l)])
    -- otherwise

  ;; 8-reduction.watsup:145.1-148.66
  rule br_on_cast_fail-succeed {l : labelidx, ref : ref, rt : reftype, rt_1 : reftype, rt_2 : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) BR_ON_CAST_FAIL_admininstr(l, rt_1, rt_2)]), [(ref <: admininstr)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))

  ;; 8-reduction.watsup:140.1-142.15
  rule br_on_cast-fail {l : labelidx, ref : ref, rt_1 : reftype, rt_2 : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) BR_ON_CAST_admininstr(l, rt_1, rt_2)]), [(ref <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup:135.1-138.66
  rule br_on_cast-succeed {l : labelidx, ref : ref, rt : reftype, rt_1 : reftype, rt_2 : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) BR_ON_CAST_admininstr(l, rt_1, rt_2)]), [(ref <: admininstr) BR_admininstr(l)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))

  ;; 8-reduction.watsup:72.1-74.43
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, (val <: admininstr)^k{val} :: [LOOP_admininstr(bt, instr*{instr})]), [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], (val <: admininstr)^k{val} :: (instr <: admininstr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 8-reduction.watsup:68.1-70.43
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, (val <: admininstr)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})]), [LABEL__admininstr(n, [], (val <: admininstr)^k{val} :: (instr <: admininstr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

;; 8-reduction.watsup:5.1-5.63
relation Step: `%~>%`(config, config)
  ;; 8-reduction.watsup:760.1-761.51
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

  ;; 8-reduction.watsup:701.1-702.77
  rule memory.grow-fail {n : n, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 8-reduction.watsup:697.1-699.40
  rule memory.grow-succeed {mi : meminst, n : n, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr(x)]), `%;%*`($with_meminst(z, x, mi), [CONST_admininstr(I32_numtype, (|$mem(z, x).DATA_meminst| / (64 * $Ki)))]))
    -- if (mi = $growmemory($mem(z, x), n))

  ;; 8-reduction.watsup:687.1-689.48
  rule store-pack-val {b* : byte*, c : c, i : nat, mo : memop, n : n, nt : numtype, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), x, mo)]), `%;%*`($with_mem(z, x, (i + mo.OFFSET_memop), (n / 8), b*{b}), []))
    -- if (b*{b} = $ibytes(n, $wrap($size(nt <: valtype), n, c)))

  ;; 8-reduction.watsup:683.1-685.51
  rule store-pack-oob {c : c, i : nat, mo : memop, n : n, nt : numtype, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), x, mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:679.1-681.29
  rule store-num-val {b* : byte*, c : c, i : nat, mo : memop, nt : numtype, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), x, mo)]), `%;%*`($with_mem(z, x, (i + mo.OFFSET_memop), ($size(nt <: valtype) / 8), b*{b}), []))
    -- if (b*{b} = $ntbytes(nt, c))

  ;; 8-reduction.watsup:675.1-677.59
  rule store-num-oob {c : c, i : nat, mo : memop, nt : numtype, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), x, mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + ($size(nt <: valtype) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:652.1-653.51
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 8-reduction.watsup:593.1-594.80
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 8-reduction.watsup:589.1-591.46
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if (ti = $growtable($table(z, x), n, ref))

  ;; 8-reduction.watsup:579.1-581.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:575.1-577.33
  rule table.set-oob {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:561.1-562.58
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(val <: admininstr) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 8-reduction.watsup:549.1-550.56
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(val <: admininstr) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 8-reduction.watsup:403.1-406.31
  rule array.set-array {a : addr, fv : fieldval, i : nat, mut : mut, val : val, x : idx, z : state, zt : storagetype}:
    `%~>%`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`($with_array(z, a, i, fv), []))
    -- Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))
    -- if (fv = $packval(zt, val))

  ;; 8-reduction.watsup:399.1-401.38
  rule array.set-oob {a : addr, i : nat, val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:396.1-397.64
  rule array.set-null {ht : heaptype, i : nat, val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) (val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))

  ;; 8-reduction.watsup:356.1-359.61
  rule array.new_fixed {ai : arrayinst, mut : mut, n : n, val^n : val^n, x : idx, z : state, zt : storagetype}:
    `%~>%`(`%;%*`(z, (val <: admininstr)^n{val} :: [ARRAY.NEW_FIXED_admininstr(x, n)]), `%;%*`($ext_arrayinst(z, [ai]), [REF.ARRAY_ADDR_admininstr(|$arrayinst(z)|)]))
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (ai = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val}})

  ;; 8-reduction.watsup:340.1-343.35
  rule struct.set-struct {a : addr, fv : fieldval, i : nat, mut* : mut*, val : val, x : idx, z : state, zt* : storagetype*}:
    `%~>%`(`%;%*`(z, [REF.STRUCT_ADDR_admininstr(a) (val <: admininstr) STRUCT.SET_admininstr(x, i)]), `%;%*`($with_struct(z, a, i, fv), []))
    -- Expand: `%~~%`($structinst(z)[a].TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- if (fv = $packval(zt*{zt}[i], val))

  ;; 8-reduction.watsup:337.1-338.53
  rule struct.set-null {ht : heaptype, i : nat, val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [REF.NULL_admininstr(ht) (val <: admininstr) STRUCT.SET_admininstr(x, i)]), `%;%*`(z, [TRAP_admininstr]))

  ;; 8-reduction.watsup:317.1-320.61
  rule struct.new {mut^n : mut^n, n : n, si : structinst, val^n : val^n, x : idx, z : state, zt^n : storagetype^n}:
    `%~>%`(`%;%*`(z, (val <: admininstr)^n{val} :: [STRUCT.NEW_admininstr(x)]), `%;%*`($ext_structinst(z, [si]), [REF.STRUCT_ADDR_admininstr(|$structinst(z)|)]))
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)^n{mut zt}))
    -- if (si = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val zt}})

  ;; 8-reduction.watsup:14.1-16.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*{instr}), `%;%*`(z, (instr' <: admininstr)*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, (instr <: admininstr)*{instr}), (instr' <: admininstr)*{instr'})

  ;; 8-reduction.watsup:10.1-12.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*{instr}), `%;%*`(z, (instr' <: admininstr)*{instr'}))
    -- Step_pure: `%*~>%*`((instr <: admininstr)*{instr}, (instr' <: admininstr)*{instr'})

;; 8-reduction.watsup:8.1-8.63
rec {

;; 8-reduction.watsup:8.1-8.63
relation Steps: `%~>*%`(config, config)
  ;; 8-reduction.watsup:21.1-24.53
  rule trans {admininstr* : admininstr*, admininstr' : admininstr, admininstr''* : admininstr*, z : state, z' : state, z'' : state}:
    `%~>*%`(`%;%*`(z, admininstr*{admininstr}), `%;%*`(z'', admininstr''*{admininstr''}))
    -- Step: `%~>%`(`%;%*`(z, admininstr*{admininstr}), `%;%*`(z', admininstr'*{}))
    -- Steps: `%~>*%`(`%;%*`(z', [admininstr']), `%;%*`(z'', admininstr''*{admininstr''}))

  ;; 8-reduction.watsup:18.1-19.36
  rule refl {admininstr* : admininstr*, z : state}:
    `%~>*%`(`%;%*`(z, admininstr*{admininstr}), `%;%*`(z, admininstr*{admininstr}))
}

;; 8-reduction.watsup:29.1-29.69
relation Eval_expr: `%;%~>*%;%*`(state, expr, state, val*)
  ;; 8-reduction.watsup:31.1-33.37
  rule _ {instr* : instr*, val* : val*, z : state, z' : state}:
    `%;%~>*%;%*`(z, instr*{instr}, z', val*{val})
    -- Steps: `%~>*%`(`%;%*`(z, (instr <: admininstr)*{instr}), `%;%*`(z', (val <: admininstr)*{val}))

;; 9-module.watsup:7.1-7.34
rec {

;; 9-module.watsup:7.1-7.34
def alloctypes : type* -> deftype*
  ;; 9-module.watsup:9.1-13.24
  def {deftype* : deftype*, deftype'* : deftype*, rectype : rectype, type : type, type'* : type*, x : idx} alloctypes(type'*{type'} :: [type]) = deftype'*{deftype'} :: deftype*{deftype}
    -- if (deftype'*{deftype'} = $alloctypes(type'*{type'}))
    -- if (type = TYPE(rectype))
    -- if (deftype*{deftype} = $subst_all_deftypes($rolldt(x, rectype), (deftype' <: heaptype)*{deftype'}))
    -- if (x = |deftype'*{deftype'}|)
  ;; 9-module.watsup:8.1-8.27
  def alloctypes([]) = []
}

;; 9-module.watsup:15.1-15.60
def allocfunc : (store, moduleinst, func) -> (store, funcaddr)
  ;; 9-module.watsup:16.1-18.55
  def {expr : expr, fi : funcinst, func : func, local* : local*, mm : moduleinst, s : store, x : idx} allocfunc(s, mm, func) = (s[FUNC_store =.. [fi]], |s.FUNC_store|)
    -- if (func = `FUNC%%*%`(x, local*{local}, expr))
    -- if (fi = {TYPE mm.TYPE_moduleinst[x], MODULE mm, CODE func})

;; 9-module.watsup:20.1-20.63
rec {

;; 9-module.watsup:20.1-20.63
def allocfuncs : (store, moduleinst, func*) -> (store, funcaddr*)
  ;; 9-module.watsup:22.1-24.51
  def {fa : funcaddr, fa'* : funcaddr*, func : func, func'* : func*, mm : moduleinst, s : store, s_1 : store, s_2 : store} allocfuncs(s, mm, [func] :: func'*{func'}) = (s_2, [fa] :: fa'*{fa'})
    -- if ((s_1, fa) = $allocfunc(s, mm, func))
    -- if ((s_2, fa'*{fa'}) = $allocfuncs(s_1, mm, func'*{func'}))
  ;; 9-module.watsup:21.1-21.39
  def {mm : moduleinst, s : store} allocfuncs(s, mm, []) = (s, [])
}

;; 9-module.watsup:26.1-26.63
def allocglobal : (store, globaltype, val) -> (store, globaladdr)
  ;; 9-module.watsup:27.1-28.44
  def {gi : globalinst, globaltype : globaltype, s : store, val : val} allocglobal(s, globaltype, val) = (s[GLOBAL_store =.. [gi]], |s.GLOBAL_store|)
    -- if (gi = {TYPE globaltype, VALUE val})

;; 9-module.watsup:30.1-30.67
rec {

;; 9-module.watsup:30.1-30.67
def allocglobals : (store, globaltype*, val*) -> (store, globaladdr*)
  ;; 9-module.watsup:32.1-34.62
  def {ga : globaladdr, ga'* : globaladdr*, globaltype : globaltype, globaltype'* : globaltype*, s : store, s_1 : store, s_2 : store, val : val, val'* : val*} allocglobals(s, [globaltype] :: globaltype'*{globaltype'}, [val] :: val'*{val'}) = (s_2, [ga] :: ga'*{ga'})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga'}) = $allocglobals(s_1, globaltype'*{globaltype'}, val'*{val'}))
  ;; 9-module.watsup:31.1-31.42
  def {s : store} allocglobals(s, [], []) = (s, [])
}

;; 9-module.watsup:36.1-36.60
def alloctable : (store, tabletype, ref) -> (store, tableaddr)
  ;; 9-module.watsup:37.1-38.49
  def {i : nat, j : nat, ref : ref, rt : reftype, s : store, ti : tableinst} alloctable(s, `%%`(`[%..%]`(i, j), rt), ref) = (s[TABLE_store =.. [ti]], |s.TABLE_store|)
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM ref^i{}})

;; 9-module.watsup:40.1-40.64
rec {

;; 9-module.watsup:40.1-40.64
def alloctables : (store, tabletype*, ref*) -> (store, tableaddr*)
  ;; 9-module.watsup:42.1-44.60
  def {ref : ref, ref'* : ref*, s : store, s_1 : store, s_2 : store, ta : tableaddr, ta'* : tableaddr*, tabletype : tabletype, tabletype'* : tabletype*} alloctables(s, [tabletype] :: tabletype'*{tabletype'}, [ref] :: ref'*{ref'}) = (s_2, [ta] :: ta'*{ta'})
    -- if ((s_1, ta) = $alloctable(s, tabletype, ref))
    -- if ((s_2, ta'*{ta'}) = $alloctables(s_1, tabletype'*{tabletype'}, ref'*{ref'}))
  ;; 9-module.watsup:41.1-41.41
  def {s : store} alloctables(s, [], []) = (s, [])
}

;; 9-module.watsup:46.1-46.49
def allocmem : (store, memtype) -> (store, memaddr)
  ;; 9-module.watsup:47.1-48.62
  def {i : nat, j : nat, mi : meminst, s : store} allocmem(s, `%I8`(`[%..%]`(i, j))) = (s[MEM_store =.. [mi]], |s.MEM_store|)
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA 0^((i * 64) * $Ki){}})

;; 9-module.watsup:50.1-50.52
rec {

;; 9-module.watsup:50.1-50.52
def allocmems : (store, memtype*) -> (store, memaddr*)
  ;; 9-module.watsup:52.1-54.49
  def {ma : memaddr, ma'* : memaddr*, memtype : memtype, memtype'* : memtype*, s : store, s_1 : store, s_2 : store} allocmems(s, [memtype] :: memtype'*{memtype'}) = (s_2, [ma] :: ma'*{ma'})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma'}) = $allocmems(s_1, memtype'*{memtype'}))
  ;; 9-module.watsup:51.1-51.34
  def {s : store} allocmems(s, []) = (s, [])
}

;; 9-module.watsup:56.1-56.57
def allocelem : (store, reftype, ref*) -> (store, elemaddr)
  ;; 9-module.watsup:57.1-58.36
  def {ei : eleminst, ref* : ref*, rt : reftype, s : store} allocelem(s, rt, ref*{ref}) = (s[ELEM_store =.. [ei]], |s.ELEM_store|)
    -- if (ei = {TYPE rt, ELEM ref*{ref}})

;; 9-module.watsup:60.1-60.63
rec {

;; 9-module.watsup:60.1-60.63
def allocelems : (store, reftype*, ref**) -> (store, elemaddr*)
  ;; 9-module.watsup:62.1-64.55
  def {ea : elemaddr, ea'* : elemaddr*, ref* : ref*, ref'** : ref**, rt : reftype, rt'* : reftype*, s : store, s_1 : store, s_2 : store} allocelems(s, [rt] :: rt'*{rt'}, [ref*{ref}] :: ref'*{ref'}*{ref'}) = (s_2, [ea] :: ea'*{ea'})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref}))
    -- if ((s_2, ea'*{ea'}) = $allocelems(s_2, rt'*{rt'}, ref'*{ref'}*{ref'}))
  ;; 9-module.watsup:61.1-61.40
  def {s : store} allocelems(s, [], []) = (s, [])
}

;; 9-module.watsup:66.1-66.49
def allocdata : (store, byte*) -> (store, dataaddr)
  ;; 9-module.watsup:67.1-68.28
  def {byte* : byte*, di : datainst, s : store} allocdata(s, byte*{byte}) = (s[DATA_store =.. [di]], |s.DATA_store|)
    -- if (di = {DATA byte*{byte}})

;; 9-module.watsup:70.1-70.54
rec {

;; 9-module.watsup:70.1-70.54
def allocdatas : (store, byte**) -> (store, dataaddr*)
  ;; 9-module.watsup:72.1-74.50
  def {byte* : byte*, byte'** : byte**, da : dataaddr, da'* : dataaddr*, s : store, s_1 : store, s_2 : store} allocdatas(s, [byte*{byte}] :: byte'*{byte'}*{byte'}) = (s_2, [da] :: da'*{da'})
    -- if ((s_1, da) = $allocdata(s, byte*{byte}))
    -- if ((s_2, da'*{da'}) = $allocdatas(s_1, byte'*{byte'}*{byte'}))
  ;; 9-module.watsup:71.1-71.35
  def {s : store} allocdatas(s, []) = (s, [])
}

;; 9-module.watsup:79.1-79.83
def instexport : (funcaddr*, globaladdr*, tableaddr*, memaddr*, export) -> exportinst
  ;; 9-module.watsup:83.1-83.93
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, MEM_externidx(x))) = {NAME name, VALUE MEM_externval(ma*{ma}[x])}
  ;; 9-module.watsup:82.1-82.97
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, TABLE_externidx(x))) = {NAME name, VALUE TABLE_externval(ta*{ta}[x])}
  ;; 9-module.watsup:81.1-81.99
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, GLOBAL_externidx(x))) = {NAME name, VALUE GLOBAL_externval(ga*{ga}[x])}
  ;; 9-module.watsup:80.1-80.95
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, FUNC_externidx(x))) = {NAME name, VALUE FUNC_externval(fa*{fa}[x])}

;; 9-module.watsup:86.1-86.87
def allocmodule : (store, module, externval*, val*, ref*, ref**) -> (store, moduleinst)
  ;; 9-module.watsup:87.1-127.51
  def {byte*^n_d : byte*^n_d, da* : dataaddr*, datamode^n_d : datamode^n_d, dt* : deftype*, ea* : elemaddr*, elemmode^n_e : elemmode^n_e, export* : export*, expr_e*^n_e : expr*^n_e, expr_g^n_g : expr^n_g, expr_t^n_t : expr^n_t, externval* : externval*, fa* : funcaddr*, fa_ex* : funcaddr*, func^n_f : func^n_f, ga* : globaladdr*, ga_ex* : globaladdr*, globaltype^n_g : globaltype^n_g, i_d^n_d : nat^n_d, i_e^n_e : nat^n_e, i_f^n_f : nat^n_f, i_g^n_g : nat^n_g, i_m^n_m : nat^n_m, i_t^n_t : nat^n_t, import* : import*, ma* : memaddr*, ma_ex* : memaddr*, memtype^n_m : memtype^n_m, mm : moduleinst, module : module, n_d : n, n_e : n, n_f : n, n_g : n, n_m : n, n_t : n, ref_e** : ref**, ref_t* : ref*, reftype^n_e : reftype^n_e, s : store, s_1 : store, s_2 : store, s_3 : store, s_4 : store, s_5 : store, s_6 : store, start? : start?, ta* : tableaddr*, ta_ex* : tableaddr*, tabletype^n_t : tabletype^n_t, type* : type*, val_g* : val*, xi* : exportinst*} allocmodule(s, module, externval*{externval}, val_g*{val_g}, ref_t*{ref_t}, ref_e*{ref_e}*{ref_e}) = (s_6, mm)
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func^n_f{func}, GLOBAL(globaltype, expr_g)^n_g{expr_g globaltype}, TABLE(tabletype, expr_t)^n_t{expr_t tabletype}, MEMORY(memtype)^n_m{memtype}, `ELEM%%*%`(reftype, expr_e*{expr_e}, elemmode)^n_e{elemmode expr_e reftype}, `DATA%*%`(byte*{byte}, datamode)^n_d{byte datamode}, start?{start}, export*{export}))
    -- if (fa_ex*{fa_ex} = $funcsxv(externval*{externval}))
    -- if (ga_ex*{ga_ex} = $globalsxv(externval*{externval}))
    -- if (ta_ex*{ta_ex} = $tablesxv(externval*{externval}))
    -- if (ma_ex*{ma_ex} = $memsxv(externval*{externval}))
    -- if (fa*{fa} = (|s.FUNC_store| + i_f)^(i_f<n_f){i_f})
    -- if (ga*{ga} = (|s.GLOBAL_store| + i_g)^(i_g<n_g){i_g})
    -- if (ta*{ta} = (|s.TABLE_store| + i_t)^(i_t<n_t){i_t})
    -- if (ma*{ma} = (|s.MEM_store| + i_m)^(i_m<n_m){i_m})
    -- if (ea*{ea} = (|s.ELEM_store| + i_e)^(i_e<n_e){i_e})
    -- if (da*{da} = (|s.DATA_store| + i_d)^(i_d<n_d){i_d})
    -- if (xi*{xi} = $instexport(fa_ex*{fa_ex} :: fa*{fa}, ga_ex*{ga_ex} :: ga*{ga}, ta_ex*{ta_ex} :: ta*{ta}, ma_ex*{ma_ex} :: ma*{ma}, export)*{export})
    -- if (mm = {TYPE dt*{dt}, FUNC fa_ex*{fa_ex} :: fa*{fa}, GLOBAL ga_ex*{ga_ex} :: ga*{ga}, TABLE ta_ex*{ta_ex} :: ta*{ta}, MEM ma_ex*{ma_ex} :: ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT xi*{xi}})
    -- if (dt*{dt} = $alloctypes(type*{type}))
    -- if ((s_1, fa*{fa}) = $allocfuncs(s, mm, func^n_f{func}))
    -- if ((s_2, ga*{ga}) = $allocglobals(s_1, globaltype^n_g{globaltype}, val_g*{val_g}))
    -- if ((s_3, ta*{ta}) = $alloctables(s_2, tabletype^n_t{tabletype}, ref_t*{ref_t}))
    -- if ((s_4, ma*{ma}) = $allocmems(s_3, memtype^n_m{memtype}))
    -- if ((s_5, ea*{ea}) = $allocelems(s_4, reftype^n_e{reftype}, ref_e*{ref_e}*{ref_e}))
    -- if ((s_6, da*{da}) = $allocdatas(s_5, byte*{byte}^n_d{byte}))

;; 9-module.watsup:134.1-134.38
rec {

;; 9-module.watsup:134.1-134.38
def concat_instr : instr** -> instr*
  ;; 9-module.watsup:136.1-136.74
  def {instr* : instr*, instr'** : instr**} concat_instr([instr*{instr}] :: instr'*{instr'}*{instr'}) = instr*{instr} :: $concat_instr(instr'*{instr'}*{instr'})
  ;; 9-module.watsup:135.1-135.29
  def concat_instr([]) = []
}

;; 9-module.watsup:138.1-138.33
def runelem : (elem, idx) -> instr*
  ;; 9-module.watsup:141.1-142.77
  def {expr* : expr*, instr* : instr*, reftype : reftype, x : idx, y : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, ACTIVE_elemmode(x, instr*{instr})), y) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, |expr*{expr}|) TABLE.INIT_instr(x, y) ELEM.DROP_instr(y)]
  ;; 9-module.watsup:140.1-140.62
  def {expr* : expr*, reftype : reftype, y : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, DECLARE_elemmode), y) = [ELEM.DROP_instr(y)]
  ;; 9-module.watsup:139.1-139.52
  def {expr* : expr*, reftype : reftype, y : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, PASSIVE_elemmode), y) = []

;; 9-module.watsup:144.1-144.33
def rundata : (data, idx) -> instr*
  ;; 9-module.watsup:146.1-147.78
  def {byte* : byte*, instr* : instr*, x : idx, y : idx} rundata(`DATA%*%`(byte*{byte}, ACTIVE_datamode(x, instr*{instr})), y) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, |byte*{byte}|) MEMORY.INIT_instr(x, y) DATA.DROP_instr(y)]
  ;; 9-module.watsup:145.1-145.44
  def {byte* : byte*, y : idx} rundata(`DATA%*%`(byte*{byte}, PASSIVE_datamode), y) = []

;; 9-module.watsup:149.1-149.53
def instantiate : (store, module, externval*) -> config
  ;; 9-module.watsup:150.1-171.64
  def {data* : data*, elem* : elem*, elemmode* : elemmode*, export* : export*, expr_E** : expr**, expr_G* : expr*, expr_T* : expr*, externval* : externval*, f : frame, func* : func*, global* : global*, globaltype* : globaltype*, i^n_E : nat^n_E, i_F^n_F : nat^n_F, import* : import*, instr_D* : instr*, instr_E* : instr*, j^n_D : nat^n_D, mem* : mem*, mm : moduleinst, mm_init : moduleinst, module : module, n_D : n, n_E : n, n_F : n, ref_E** : ref**, ref_T* : ref*, reftype* : reftype*, s : store, s' : store, start? : start?, table* : table*, tabletype* : tabletype*, type* : type*, val_G* : val*, x? : idx?, z : state} instantiate(s, module, externval*{externval}) = `%;%*`(`%;%`(s', f), (instr_E <: admininstr)*{instr_E} :: (instr_D <: admininstr)*{instr_D} :: CALL_admininstr(x)?{x})
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (global*{global} = GLOBAL(globaltype, expr_G)*{expr_G globaltype})
    -- if (table*{table} = TABLE(tabletype, expr_T)*{expr_T tabletype})
    -- if (elem*{elem} = `ELEM%%*%`(reftype, expr_E*{expr_E}, elemmode)*{elemmode expr_E reftype})
    -- if (start?{start} = START(x)?{x})
    -- if (n_F = |func*{func}|)
    -- if (n_E = |elem*{elem}|)
    -- if (n_D = |data*{data}|)
    -- if (mm_init = {TYPE $alloctypes(type*{type}), FUNC $funcsxv(externval*{externval}) :: (|s.FUNC_store| + i_F)^(i_F<n_F){i_F}, GLOBAL $globalsxv(externval*{externval}), TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (z = `%;%`(s, {LOCAL [], MODULE mm_init}))
    -- (Eval_expr: `%;%~>*%;%*`(z, expr_G, z, [val_G]))*{expr_G val_G}
    -- (Eval_expr: `%;%~>*%;%*`(z, expr_T, z, [(ref_T <: val)]))*{expr_T ref_T}
    -- (Eval_expr: `%;%~>*%;%*`(z, expr_E, z, [(ref_E <: val)]))*{expr_E ref_E}*{expr_E ref_E}
    -- if ((s', mm) = $allocmodule(s, module, externval*{externval}, val_G*{val_G}, ref_T*{ref_T}, ref_E*{ref_E}*{ref_E}))
    -- if (f = {LOCAL [], MODULE mm})
    -- if (instr_E*{instr_E} = $concat_instr($runelem(elem*{elem}[i], i)^(i<n_E){i}))
    -- if (instr_D*{instr_D} = $concat_instr($rundata(data*{data}[j], j)^(j<n_D){j}))

;; 9-module.watsup:178.1-178.44
def invoke : (store, funcaddr, val*) -> config
  ;; 9-module.watsup:179.1-182.53
  def {expr : expr, f : frame, fa : funcaddr, local* : local*, n : n, s : store, t_1^n : valtype^n, t_2* : valtype*, val^n : val^n, x : idx} invoke(s, fa, val^n{val}) = `%;%*`(`%;%`(s, f), (val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(fa) CALL_REF_admininstr(?(0))])
    -- if (f = {LOCAL [], MODULE {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []}})
    -- if ($funcinst(`%;%`(s, f))[fa].CODE_funcinst = `FUNC%%*%`(x, local*{local}, expr))
    -- Expand: `%~~%`(s.FUNC_store[fa].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2*{t_2})))

;; A-binary.watsup:47.1-47.24
rec {

;; A-binary.watsup:47.1-47.24
def utf8 : name -> byte*
  ;; A-binary.watsup:52.1-52.41
  def {c* : c*} utf8(c*{c}) = $concat_bytes($utf8([c])*{c})
  ;; A-binary.watsup:51.1-51.145
  def {b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte, c : c} utf8([c]) = [b_1 b_2 b_3 b_4]
    -- if (((65536 <= c) /\ (c < 69632)) /\ (c = (((((2 ^ 18) * (b_1 - 240)) + ((2 ^ 12) * (b_2 - 128))) + ((2 ^ 6) * (b_3 - 128))) + (b_4 - 128))))
  ;; A-binary.watsup:50.1-50.144
  def {b_1 : byte, b_2 : byte, b_3 : byte, c : c} utf8([c]) = [b_1 b_2 b_3]
    -- if ((((2048 <= c) /\ (c < 55296)) \/ ((57344 <= c) /\ (c < 65536))) /\ (c = ((((2 ^ 12) * (b_1 - 224)) + ((2 ^ 6) * (b_2 - 128))) + (b_3 - 128))))
  ;; A-binary.watsup:49.1-49.93
  def {b_1 : byte, b_2 : byte, c : c} utf8([c]) = [b_1 b_2]
    -- if (((128 <= c) /\ (c < 2048)) /\ (c = (((2 ^ 6) * (b_1 - 192)) + (b_2 - 128))))
  ;; A-binary.watsup:48.1-48.44
  def {b : byte, c : c} utf8([c]) = [b]
    -- if ((c < 128) /\ (c = b))
}

;; A-binary.watsup:210.1-210.27
syntax castop = (nul, nul)

;; A-binary.watsup:303.1-303.34
syntax memidxop = (memidx, memop)

;; A-binary.watsup:665.1-665.62
rec {

;; A-binary.watsup:665.1-665.62
def concat_locals : local** -> local*
  ;; A-binary.watsup:667.1-667.68
  def {loc* : local*, loc'** : local**} concat_locals([loc*{loc}] :: loc'*{loc'}*{loc'}) = loc*{loc} :: $concat_locals(loc'*{loc'}*{loc'})
  ;; A-binary.watsup:666.1-666.30
  def concat_locals([]) = []
}

;; A-binary.watsup:670.1-670.29
syntax code = (local*, expr)

== IL Validation...
== Latex Generation...
\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{N}} &::=& {\mathit{nat}} \\
& {\mathit{M}} &::=& {\mathit{nat}} \\
& {\mathit{n}} &::=& {\mathit{nat}} \\
& {\mathit{m}} &::=& {\mathit{nat}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{Ki}} &=& 1024 &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{min}}(0, {\mathit{j}}) &=& 0 &  \\
{\mathrm{min}}({\mathit{i}}, 0) &=& 0 &  \\
{\mathrm{min}}({\mathit{i}} + 1, {\mathit{j}} + 1) &=& {\mathrm{min}}({\mathit{i}}, {\mathit{j}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{sum}}(\epsilon) &=& 0 &  \\
{\mathrm{sum}}({\mathit{n}}~{{\mathit{n}'}^\ast}) &=& {\mathit{n}} + {\mathrm{sum}}({{\mathit{n}'}^\ast}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(character)} & {\mathit{char}} &::=& \mathrm{U{+}00} ~|~ \dots ~|~ \mathrm{U{+}D7FF} ~|~ \mathrm{U{+}E000} ~|~ \dots ~|~ \mathrm{U{+}10FFFF} \\
\mbox{(name)} & {\mathit{name}} &::=& {{\mathit{char}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(byte)} & {\mathit{byte}} &::=& \mathtt{0x00} ~|~ \dots ~|~ \mathtt{0xFF} \\
\mbox{(unsigned integer)} & {\mathit{uN}}({\mathit{N}}) &::=& 0 ~|~ \dots ~|~ {2^{{\mathit{N}}}} - 1 \\
\mbox{(signed integer)} & {\mathit{sN}}({\mathit{N}}) &::=& {-{2^{{\mathit{N}} - 1}}} ~|~ \dots ~|~ {-1} ~|~ 0 ~|~ {+1} ~|~ \dots ~|~ {2^{{\mathit{N}} - 1}} - 1 \\
\mbox{(integer)} & {\mathit{iN}}({\mathit{N}}) &::=& {\mathit{uN}}({\mathit{N}}) \\
& {\mathit{u{\scriptstyle31}}} &::=& {\mathit{uN}}(31) \\
& {\mathit{u{\scriptstyle32}}} &::=& {\mathit{uN}}(32) \\
& {\mathit{u{\scriptstyle64}}} &::=& {\mathit{uN}}(64) \\
& {\mathit{u{\scriptstyle128}}} &::=& {\mathit{uN}}(128) \\
& {\mathit{s{\scriptstyle33}}} &::=& {\mathit{sN}}(33) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{signif}}(32) &=& 23 &  \\
{\mathrm{signif}}(64) &=& 52 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{expon}}(32) &=& 8 &  \\
{\mathrm{expon}}(64) &=& 11 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{M}}}_{{\mathit{N}}} &=& {\mathrm{signif}}({\mathit{N}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{E}}}_{{\mathit{N}}} &=& {\mathrm{expon}}({\mathit{N}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(floating-point number)} & {\mathit{fN}}({\mathit{N}}) &::=& {+{\mathit{fmag}}({\mathit{N}})} \\ &&|&
{-{\mathit{fmag}}({\mathit{N}})} \\
\mbox{(floating-point magnitude)} & {\mathit{fmag}}({\mathit{N}}) &::=& (1 + {\mathit{m}} \cdot {2^{{-{{\mathrm{M}}}_{{\mathit{N}}}}}}) \cdot {2^{{\mathit{n}}}} &\quad
  \mbox{if}~2 - {2^{{{\mathrm{E}}}_{{\mathit{N}}} - 1}} \leq {\mathit{n}} \leq {2^{{{\mathrm{E}}}_{{\mathit{N}}} - 1}} - 1 \\ &&|&
(0 + {\mathit{m}} \cdot {2^{{-{{\mathrm{M}}}_{{\mathit{N}}}}}}) \cdot {2^{{\mathit{n}}}} &\quad
  \mbox{if}~2 - {2^{{{\mathrm{E}}}_{{\mathit{N}}} - 1}} = {\mathit{n}} \\ &&|&
\infty \\ &&|&
{\mathsf{nan}}{({\mathit{n}})} &\quad
  \mbox{if}~1 \leq {\mathit{n}} < {{\mathrm{M}}}_{{\mathit{N}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{+0} &=& {+((1 + 0 \cdot {2^{{-{{\mathrm{M}}}_{{\mathit{N}}}}}}) \cdot {2^{0}})} &  \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{f{\scriptstyle32}}} &::=& {\mathit{fN}}(32) \\
& {\mathit{f{\scriptstyle64}}} &::=& {\mathit{fN}}(64) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(index)} & {\mathit{idx}} &::=& {\mathit{u{\scriptstyle32}}} \\
\mbox{(type index)} & {\mathit{typeidx}} &::=& {\mathit{idx}} \\
\mbox{(function index)} & {\mathit{funcidx}} &::=& {\mathit{idx}} \\
\mbox{(global index)} & {\mathit{globalidx}} &::=& {\mathit{idx}} \\
\mbox{(table index)} & {\mathit{tableidx}} &::=& {\mathit{idx}} \\
\mbox{(memory index)} & {\mathit{memidx}} &::=& {\mathit{idx}} \\
\mbox{(elem index)} & {\mathit{elemidx}} &::=& {\mathit{idx}} \\
\mbox{(data index)} & {\mathit{dataidx}} &::=& {\mathit{idx}} \\
\mbox{(label index)} & {\mathit{labelidx}} &::=& {\mathit{idx}} \\
\mbox{(local index)} & {\mathit{localidx}} &::=& {\mathit{idx}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{nul}} &::=& {\mathsf{null}^?} \\
\mbox{(number type)} & {\mathit{numtype}} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} ~|~ \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
\mbox{(vector type)} & {\mathit{vectype}} &::=& \mathsf{v{\scriptstyle128}} \\
\mbox{(abstract heap type)} & {\mathit{absheaptype}} &::=& \mathsf{any} ~|~ \mathsf{eq} ~|~ \mathsf{i{\scriptstyle31}} ~|~ \mathsf{struct} ~|~ \mathsf{array} ~|~ \mathsf{none} \\ &&|&
\mathsf{func} ~|~ \mathsf{nofunc} \\ &&|&
\mathsf{extern} ~|~ \mathsf{noextern} \\ &&|&
\mathsf{bot} \\
\mbox{(heap type)} & {\mathit{heaptype}} &::=& {\mathit{absheaptype}} \\ &&|&
{\mathit{typeidx}} \\ &&|&
\dots \\
\mbox{(reference type)} & {\mathit{reftype}} &::=& \mathsf{ref}~{\mathit{nul}}~{\mathit{heaptype}} \\
\mbox{(value type)} & {\mathit{valtype}} &::=& {\mathit{numtype}} ~|~ {\mathit{vectype}} ~|~ {\mathit{reftype}} ~|~ \mathsf{bot} \\
& {\mathsf{i}}{{\mathit{n}}} &::=& \mathsf{i{\scriptstyle32}} ~|~ \mathsf{i{\scriptstyle64}} \\
& {\mathsf{f}}{{\mathit{n}}} &::=& \mathsf{f{\scriptstyle32}} ~|~ \mathsf{f{\scriptstyle64}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(result type)} & {\mathit{resulttype}} &::=& {{\mathit{valtype}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{mut}} &::=& {\mathsf{mut}^?} \\
& {\mathit{fin}} &::=& {\mathsf{final}^?} \\
\mbox{(packed type)} & {\mathit{packedtype}} &::=& \mathsf{i{\scriptstyle8}} ~|~ \mathsf{i{\scriptstyle16}} \\
\mbox{(storage type)} & {\mathit{storagetype}} &::=& {\mathit{valtype}} ~|~ {\mathit{packedtype}} \\
\mbox{(field type)} & {\mathit{fieldtype}} &::=& {\mathit{mut}}~{\mathit{storagetype}} \\
\mbox{(function type)} & {\mathit{functype}} &::=& {\mathit{resulttype}} \rightarrow {\mathit{resulttype}} \\
\mbox{(composite type)} & {\mathit{comptype}} &::=& \mathsf{struct}~{{\mathit{fieldtype}}^\ast} \\ &&|&
\mathsf{array}~{\mathit{fieldtype}} \\ &&|&
\mathsf{func}~{\mathit{functype}} \\
\mbox{(sub type)} & {\mathit{subtype}} &::=& \mathsf{sub}~{\mathit{fin}}~{{\mathit{typeidx}}^\ast}~{\mathit{comptype}} \\ &&|&
\dots \\
\mbox{(recursive type)} & {\mathit{rectype}} &::=& \mathsf{rec}~{{\mathit{subtype}}^\ast} \\
\mbox{(defined type)} & {\mathit{deftype}} &::=& {\mathit{rectype}} . {\mathit{nat}} \\
\mbox{(heap type)} & {\mathit{heaptype}} &::=& \dots \\ &&|&
{\mathit{deftype}} \\ &&|&
\mathsf{rec}~{\mathit{nat}} \\
\mbox{(sub type)} & {\mathit{subtype}} &::=& \dots \\ &&|&
\mathsf{sub}~{\mathit{fin}}~{{\mathit{heaptype}}^\ast}~{\mathit{comptype}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(limits)} & {\mathit{limits}} &::=& [{\mathit{u{\scriptstyle32}}} .. {\mathit{u{\scriptstyle32}}}] \\
\mbox{(global type)} & {\mathit{globaltype}} &::=& {\mathit{mut}}~{\mathit{valtype}} \\
\mbox{(table type)} & {\mathit{tabletype}} &::=& {\mathit{limits}}~{\mathit{reftype}} \\
\mbox{(memory type)} & {\mathit{memtype}} &::=& {\mathit{limits}}~\mathsf{i{\scriptstyle8}} \\
\mbox{(element type)} & {\mathit{elemtype}} &::=& {\mathit{reftype}} \\
\mbox{(data type)} & {\mathit{datatype}} &::=& \mathsf{ok} \\
\mbox{(external type)} & {\mathit{externtype}} &::=& \mathsf{func}~{\mathit{deftype}} ~|~ \mathsf{global}~{\mathit{globaltype}} ~|~ \mathsf{table}~{\mathit{tabletype}} ~|~ \mathsf{mem}~{\mathit{memtype}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(signedness)} & {\mathit{sx}} &::=& \mathsf{u} ~|~ \mathsf{s} \\
& {\mathit{iunop}} &::=& \mathsf{clz} ~|~ \mathsf{ctz} ~|~ \mathsf{popcnt} \\
& {\mathit{funop}} &::=& \mathsf{abs} ~|~ \mathsf{neg} ~|~ \mathsf{sqrt} ~|~ \mathsf{ceil} ~|~ \mathsf{floor} ~|~ \mathsf{trunc} ~|~ \mathsf{nearest} \\
& {\mathit{ibinop}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ {\mathsf{div\_}}{{\mathit{sx}}} ~|~ {\mathsf{rem\_}}{{\mathit{sx}}} \\ &&|&
\mathsf{and} ~|~ \mathsf{or} ~|~ \mathsf{xor} ~|~ \mathsf{shl} ~|~ {\mathsf{shr\_}}{{\mathit{sx}}} ~|~ \mathsf{rotl} ~|~ \mathsf{rotr} \\
& {\mathit{fbinop}} &::=& \mathsf{add} ~|~ \mathsf{sub} ~|~ \mathsf{mul} ~|~ \mathsf{div} ~|~ \mathsf{min} ~|~ \mathsf{max} ~|~ \mathsf{copysign} \\
& {\mathit{itestop}} &::=& \mathsf{eqz} \\
& {\mathit{ftestop}} &::=&  \\
& {\mathit{irelop}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ {\mathsf{lt\_}}{{\mathit{sx}}} ~|~ {\mathsf{gt\_}}{{\mathit{sx}}} ~|~ {\mathsf{le\_}}{{\mathit{sx}}} ~|~ {\mathsf{ge\_}}{{\mathit{sx}}} \\
& {\mathit{frelop}} &::=& \mathsf{eq} ~|~ \mathsf{ne} ~|~ \mathsf{lt} ~|~ \mathsf{gt} ~|~ \mathsf{le} ~|~ \mathsf{ge} \\
& {\mathit{unop}}_{{\mathit{numtype}}} &::=& {\mathit{iunop}} ~|~ {\mathit{funop}} \\
& {\mathit{binop}}_{{\mathit{numtype}}} &::=& {\mathit{ibinop}} ~|~ {\mathit{fbinop}} \\
& {\mathit{testop}}_{{\mathit{numtype}}} &::=& {\mathit{itestop}} ~|~ {\mathit{ftestop}} \\
& {\mathit{relop}}_{{\mathit{numtype}}} &::=& {\mathit{irelop}} ~|~ {\mathit{frelop}} \\
& {\mathit{cvtop}} &::=& \mathsf{convert} ~|~ \mathsf{reinterpret} ~|~ \mathsf{convert\_sat} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(memory operator)} & {\mathit{memop}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{align}~{\mathit{u{\scriptstyle32}}},\; \mathsf{offset}~{\mathit{u{\scriptstyle32}}} \;\}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{c}} &::=& {\mathit{nat}} \\
& {\mathit{c}}_{{\mathit{numtype}}} &::=& {\mathit{nat}} \\
& {\mathit{c}}_{{\mathit{vectype}}} &::=& {\mathit{nat}} \\
\mbox{(block type)} & {\mathit{blocktype}} &::=& {{\mathit{valtype}}^?} \\ &&|&
{\mathit{funcidx}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(instruction)} & {\mathit{instr}} &::=& \mathsf{unreachable} \\ &&|&
\mathsf{nop} \\ &&|&
\mathsf{drop} \\ &&|&
\mathsf{select}~{({{\mathit{valtype}}^\ast})^?} \\ &&|&
\mathsf{block}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{loop}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{if}~{\mathit{blocktype}}~{{\mathit{instr}}^\ast}~\mathsf{else}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{br}~{\mathit{labelidx}} \\ &&|&
\mathsf{br\_if}~{\mathit{labelidx}} \\ &&|&
\mathsf{br\_table}~{{\mathit{labelidx}}^\ast}~{\mathit{labelidx}} \\ &&|&
\mathsf{br\_on\_null}~{\mathit{labelidx}} \\ &&|&
\mathsf{br\_on\_non\_null}~{\mathit{labelidx}} \\ &&|&
\mathsf{br\_on\_cast}~{\mathit{labelidx}}~{\mathit{reftype}}~{\mathit{reftype}} \\ &&|&
\mathsf{br\_on\_cast\_fail}~{\mathit{labelidx}}~{\mathit{reftype}}~{\mathit{reftype}} \\ &&|&
\mathsf{call}~{\mathit{funcidx}} \\ &&|&
\mathsf{call\_ref}~{{\mathit{typeidx}}^?} \\ &&|&
\mathsf{call\_indirect}~{\mathit{tableidx}}~{\mathit{typeidx}} \\ &&|&
\mathsf{return} \\ &&|&
\mathsf{return\_call}~{\mathit{funcidx}} \\ &&|&
\mathsf{return\_call\_ref}~{{\mathit{typeidx}}^?} \\ &&|&
\mathsf{return\_call\_indirect}~{\mathit{tableidx}}~{\mathit{typeidx}} \\ &&|&
{\mathit{numtype}}.\mathsf{const}~{\mathit{c}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {\mathit{unop}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {\mathit{binop}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {\mathit{testop}}_{{\mathit{numtype}}} \\ &&|&
{\mathit{numtype}} . {\mathit{relop}}_{{\mathit{numtype}}} \\ &&|&
{{\mathit{numtype}}.\mathsf{extend}}{{\mathit{n}}} \\ &&|&
{\mathit{numtype}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{numtype}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}} \\ &&|&
\mathsf{ref.null}~{\mathit{heaptype}} \\ &&|&
\mathsf{ref.i{\scriptstyle31}} \\ &&|&
\mathsf{ref.func}~{\mathit{funcidx}} \\ &&|&
\mathsf{ref.is\_null} \\ &&|&
\mathsf{ref.as\_non\_null} \\ &&|&
\mathsf{ref.eq} \\ &&|&
\mathsf{ref.test}~{\mathit{reftype}} \\ &&|&
\mathsf{ref.cast}~{\mathit{reftype}} \\ &&|&
{{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}} \\ &&|&
\mathsf{struct.new}~{\mathit{typeidx}} \\ &&|&
\mathsf{struct.new\_default}~{\mathit{typeidx}} \\ &&|&
{{\mathsf{struct.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}}~{\mathit{u{\scriptstyle32}}} \\ &&|&
\mathsf{struct.set}~{\mathit{typeidx}}~{\mathit{u{\scriptstyle32}}} \\ &&|&
\mathsf{array.new}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.new\_default}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.new\_fixed}~{\mathit{typeidx}}~{\mathit{nat}} \\ &&|&
\mathsf{array.new\_data}~{\mathit{typeidx}}~{\mathit{dataidx}} \\ &&|&
\mathsf{array.new\_elem}~{\mathit{typeidx}}~{\mathit{elemidx}} \\ &&|&
{{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.set}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.len} \\ &&|&
\mathsf{array.fill}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.copy}~{\mathit{typeidx}}~{\mathit{typeidx}} \\ &&|&
\mathsf{array.init\_data}~{\mathit{typeidx}}~{\mathit{dataidx}} \\ &&|&
\mathsf{array.init\_elem}~{\mathit{typeidx}}~{\mathit{elemidx}} \\ &&|&
\mathsf{extern.convert\_any} \\ &&|&
\mathsf{any.convert\_extern} \\ &&|&
\mathsf{local.get}~{\mathit{localidx}} \\ &&|&
\mathsf{local.set}~{\mathit{localidx}} \\ &&|&
\mathsf{local.tee}~{\mathit{localidx}} \\ &&|&
\mathsf{global.get}~{\mathit{globalidx}} \\ &&|&
\mathsf{global.set}~{\mathit{globalidx}} \\ &&|&
\mathsf{table.get}~{\mathit{tableidx}} \\ &&|&
\mathsf{table.set}~{\mathit{tableidx}} \\ &&|&
\mathsf{table.size}~{\mathit{tableidx}} \\ &&|&
\mathsf{table.grow}~{\mathit{tableidx}} \\ &&|&
\mathsf{table.fill}~{\mathit{tableidx}} \\ &&|&
\mathsf{table.copy}~{\mathit{tableidx}}~{\mathit{tableidx}} \\ &&|&
\mathsf{table.init}~{\mathit{tableidx}}~{\mathit{elemidx}} \\ &&|&
\mathsf{elem.drop}~{\mathit{elemidx}} \\ &&|&
\mathsf{memory.size}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.grow}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.fill}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.copy}~{\mathit{memidx}}~{\mathit{memidx}} \\ &&|&
\mathsf{memory.init}~{\mathit{memidx}}~{\mathit{dataidx}} \\ &&|&
\mathsf{data.drop}~{\mathit{dataidx}} \\ &&|&
{{\mathit{numtype}}.\mathsf{load}}{{({\mathit{n}}~\mathsf{\_}~{\mathit{sx}})^?}}~{\mathit{memidx}}~{\mathit{memop}} \\ &&|&
{{\mathit{numtype}}.\mathsf{store}}{{{\mathit{n}}^?}}~{\mathit{memidx}}~{\mathit{memop}} \\
\mbox{(expression)} & {\mathit{expr}} &::=& {{\mathit{instr}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{elemmode}} &::=& \mathsf{active}~{\mathit{tableidx}}~{\mathit{expr}} ~|~ \mathsf{passive} ~|~ \mathsf{declare} \\
& {\mathit{datamode}} &::=& \mathsf{active}~{\mathit{memidx}}~{\mathit{expr}} ~|~ \mathsf{passive} \\
\mbox{(type definition)} & {\mathit{type}} &::=& \mathsf{type}~{\mathit{rectype}} \\
\mbox{(local)} & {\mathit{local}} &::=& \mathsf{local}~{\mathit{valtype}} \\
\mbox{(function)} & {\mathit{func}} &::=& \mathsf{func}~{\mathit{typeidx}}~{{\mathit{local}}^\ast}~{\mathit{expr}} \\
\mbox{(global)} & {\mathit{global}} &::=& \mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}} \\
\mbox{(table)} & {\mathit{table}} &::=& \mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}} \\
\mbox{(memory)} & {\mathit{mem}} &::=& \mathsf{memory}~{\mathit{memtype}} \\
\mbox{(table segment)} & {\mathit{elem}} &::=& \mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~{\mathit{elemmode}} \\
\mbox{(memory segment)} & {\mathit{data}} &::=& \mathsf{data}~{{\mathit{byte}}^\ast}~{\mathit{datamode}} \\
\mbox{(start function)} & {\mathit{start}} &::=& \mathsf{start}~{\mathit{funcidx}} \\
\mbox{(external index)} & {\mathit{externidx}} &::=& \mathsf{func}~{\mathit{funcidx}} ~|~ \mathsf{global}~{\mathit{globalidx}} ~|~ \mathsf{table}~{\mathit{tableidx}} ~|~ \mathsf{mem}~{\mathit{memidx}} \\
\mbox{(export)} & {\mathit{export}} &::=& \mathsf{export}~{\mathit{name}}~{\mathit{externidx}} \\
\mbox{(import)} & {\mathit{import}} &::=& \mathsf{import}~{\mathit{name}}~{\mathit{name}}~{\mathit{externtype}} \\
\mbox{(module)} & {\mathit{module}} &::=& \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^\ast}~{{\mathit{export}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
\epsilon \setminus {{\mathit{y}}^\ast} &=& \epsilon &  \\
{\mathit{x}}_{{1}}~{{\mathit{x}}^\ast} \setminus {{\mathit{y}}^\ast} &=& {\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}_{{1}}, {{\mathit{y}}^\ast})~{{\mathit{x}}^\ast} \setminus {{\mathit{y}}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}, \epsilon) &=& {\mathit{x}} &  \\
{\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}, {\mathit{y}}_{{1}}~{{\mathit{y}}^\ast}) &=& \epsilon &\quad
  \mbox{if}~{\mathit{x}} = {\mathit{y}}_{{1}} \\
{\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}, {\mathit{y}}_{{1}}~{{\mathit{y}}^\ast}) &=& {\mathrm{setminus{\scriptstyle1}}}({\mathit{x}}, {{\mathit{y}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &=& {\mathit{y}} &  \\
{\mathrm{free}}_{{\mathit{dataidx}}}(\mathsf{data.drop}~{\mathit{x}}) &=& {\mathit{x}} &  \\
{\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{in}}) &=& \epsilon &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}(\epsilon) &=& \epsilon &  \\
{\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{instr}}~{{\mathit{instr}'}^\ast}) &=& {\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{instr}})~{\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{instr}'}^\ast}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{in}}^\ast}) &=& {\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{in}}^\ast}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}(\mathsf{func}~{\mathit{x}}~{{\mathit{loc}}^\ast}~{\mathit{e}}) &=& {\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{e}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{free}}_{{\mathit{dataidx}}}(\epsilon) &=& \epsilon &  \\
{\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{func}}~{{\mathit{func}'}^\ast}) &=& {\mathrm{free}}_{{\mathit{dataidx}}}({\mathit{func}})~{\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{func}'}^\ast}) &  \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{concat}}(\epsilon) &=& \epsilon &  \\
{\mathrm{concat}}(({{\mathit{b}}^\ast})~{({{\mathit{b}'}^\ast})^\ast}) &=& {{\mathit{b}}^\ast}~{\mathrm{concat}}({({{\mathit{b}'}^\ast})^\ast}) &  \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle32}}|} &=& 32 &  \\
{|\mathsf{i{\scriptstyle64}}|} &=& 64 &  \\
{|\mathsf{f{\scriptstyle32}}|} &=& 32 &  \\
{|\mathsf{f{\scriptstyle64}}|} &=& 64 &  \\
{|\mathsf{v{\scriptstyle128}}|} &=& 128 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|\mathsf{i{\scriptstyle8}}|} &=& 8 &  \\
{|\mathsf{i{\scriptstyle16}}|} &=& 16 &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{|{\mathit{valtype}}|} &=& {|{\mathit{valtype}}|} &  \\
{|{\mathit{packedtype}}|} &=& {|{\mathit{packedtype}}|} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{valtype}}) &=& {\mathit{valtype}} &  \\
{\mathrm{unpack}}({\mathit{packedtype}}) &=& \mathsf{i{\scriptstyle32}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unpack}}({\mathit{numtype}}) &=& {\mathit{numtype}} &  \\
{\mathrm{unpack}}({\mathit{packedtype}}) &=& \mathsf{i{\scriptstyle32}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{sx}}({\mathit{valtype}}) &=& \epsilon &  \\
{\mathrm{sx}}({\mathit{packedtype}}) &=& \mathsf{s} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
(\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}}) - (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}_{{2}}) &=& (\mathsf{ref}~\epsilon~{\mathit{ht}}_{{1}}) &  \\
(\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}}) - (\mathsf{ref}~\epsilon~{\mathit{ht}}_{{2}}) &=& (\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{typevar}} &::=& {\mathit{typeidx}} ~|~ \mathsf{rec}~{\mathit{nat}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{x}} &=& {\mathit{x}} &  \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{xx}}}{[\epsilon := \epsilon]} &=& {\mathit{xx}} &  \\
{{\mathit{xx}}}{[{\mathit{xx}}_{{1}}~{{\mathit{xx}'}^\ast} := {\mathit{ht}}_{{1}}~{{\mathit{ht}'}^\ast}]} &=& {\mathit{ht}}_{{1}} &\quad
  \mbox{if}~{\mathit{xx}} = {\mathit{xx}}_{{1}} \\
{{\mathit{xx}}}{[{\mathit{xx}}_{{1}}~{{\mathit{xx}'}^\ast} := {\mathit{ht}}_{{1}}~{{\mathit{ht}'}^\ast}]} &=& {{\mathit{xx}}}{[{{\mathit{xx}'}^\ast} := {{\mathit{ht}'}^\ast}]} &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{nt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{nt}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{vt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{vt}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{xx}'}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{xx}'}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{{\mathit{dt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{dt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{{\mathit{ht}'}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{ht}'} &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{ref}~{\mathit{nul}}~{\mathit{ht}'})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{ref}~{\mathit{nul}}~{{\mathit{ht}'}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{nt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{nt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{{\mathit{vt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{vt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{{\mathit{rt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{rt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{\mathsf{bot}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{bot} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{pt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{pt}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{t}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{t}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{{\mathit{pt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{pt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{mut}}~{\mathit{zt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{mut}}~{{\mathit{zt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{struct}~{{\mathit{yt}}^\ast})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{struct}~{{{\mathit{yt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]}^\ast} &  \\
{(\mathsf{array}~{\mathit{yt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{array}~{{\mathit{yt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{(\mathsf{func}~{\mathit{ft}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{func}~{{\mathit{ft}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{sub}~{\mathit{fin}}~{{\mathit{y}}^\ast}~{\mathit{ct}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{sub}~{\mathit{fin}}~{{{\mathit{y}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]}^\ast}~{{\mathit{ct}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{(\mathsf{sub}~{\mathit{fin}}~{{\mathit{ht}'}^\ast}~{\mathit{ct}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{sub}~{\mathit{fin}}~{{{\mathit{ht}'}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]}^\ast}~{{\mathit{ct}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{rec}~{{\mathit{st}}^\ast})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{rec}~{{{\mathit{st}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{qt}} . {\mathit{i}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{\mathit{qt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} . {\mathit{i}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{mut}}~{\mathit{t}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{mut}}~{{\mathit{t}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {{{\mathit{t}}_{{1}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]}^\ast} \rightarrow {{{\mathit{t}}_{{2}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{lim}}~\mathsf{i{\scriptstyle8}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{lim}}~\mathsf{i{\scriptstyle8}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{lim}}~{\mathit{rt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& {\mathit{lim}}~{{\mathit{rt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{(\mathsf{func}~{\mathit{dt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{func}~{{\mathit{dt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{(\mathsf{global}~{\mathit{gt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{global}~{{\mathit{gt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{(\mathsf{table}~{\mathit{tt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{table}~{{\mathit{tt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
{(\mathsf{mem}~{\mathit{mt}})}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &=& \mathsf{mem}~{{\mathit{mt}}}{[{{\mathit{xx}}^\ast} := {{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{rt}}}{[{ := }\;{{\mathit{ht}}^{{\mathit{n}}}}]} &=& {{\mathit{rt}}}{[{{\mathit{x}}^{{\mathit{x}}<{\mathit{n}}}} := {{\mathit{ht}}^{{\mathit{n}}}}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathit{dt}}}{[{ := }\;{{\mathit{ht}}^{{\mathit{n}}}}]} &=& {{\mathit{dt}}}{[{{\mathit{x}}^{{\mathit{x}}<{\mathit{n}}}} := {{\mathit{ht}}^{{\mathit{n}}}}]} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\epsilon}{[{ := }\;{{\mathit{ht}}^\ast}]} &=& \epsilon &  \\
{{\mathit{dt}}_{{1}}~{{\mathit{dt}}^\ast}}{[{ := }\;{{\mathit{ht}}^\ast}]} &=& {{\mathit{dt}}_{{1}}}{[{ := }\;{{\mathit{ht}}^\ast}]}~{{{\mathit{dt}}^\ast}}{[{ := }\;{{\mathit{ht}}^\ast}]} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{roll}}}_{{\mathit{x}}}(\mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}}) &=& \mathsf{rec}~{({{\mathit{st}}}{[{({\mathit{x}} + {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}} := {(\mathsf{rec}~{\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}}]})^{{\mathit{n}}}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unroll}}(\mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}}) &=& \mathsf{rec}~{({{\mathit{st}}}{[{(\mathsf{rec}~{\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}} := {({\mathit{qt}} . {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}}]})^{{\mathit{n}}}} &\quad
  \mbox{if}~{\mathit{qt}} = \mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{roll}}}_{{\mathit{x}}}({\mathit{qt}}) &=& {((\mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}}) . {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}}} &\quad
  \mbox{if}~{{\mathrm{roll}}}_{{\mathit{x}}}({\mathit{qt}}) = \mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{unroll}}({\mathit{qt}} . {\mathit{i}}) &=& {{\mathit{st}}^\ast}[{\mathit{i}}] &\quad
  \mbox{if}~{\mathrm{unroll}}({\mathit{qt}}) = \mathsf{rec}~{{\mathit{st}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{expand}}({\mathit{dt}}) &=& {\mathit{ct}} &\quad
  \mbox{if}~{\mathrm{unroll}}({\mathit{dt}}) = \mathsf{sub}~{\mathit{fin}}~{{\mathit{ht}}^\ast}~{\mathit{ct}} \\
\end{array}
$$

$\boxed{{\mathit{deftype}} \approx {\mathit{comptype}}}$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize Expand}]} \quad & {\mathit{dt}} &\approx& {\mathit{ct}} &\quad
  \mbox{if}~{\mathrm{expand}}({\mathit{dt}}) = {\mathit{ct}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{funcs}}(\epsilon) &=& \epsilon &  \\
{\mathrm{funcs}}((\mathsf{func}~{\mathit{dt}})~{{\mathit{et}}^\ast}) &=& {\mathit{dt}}~{\mathrm{funcs}}({{\mathit{et}}^\ast}) &  \\
{\mathrm{funcs}}({\mathit{externtype}}~{{\mathit{et}}^\ast}) &=& {\mathrm{funcs}}({{\mathit{et}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{globals}}(\epsilon) &=& \epsilon &  \\
{\mathrm{globals}}((\mathsf{global}~{\mathit{gt}})~{{\mathit{et}}^\ast}) &=& {\mathit{gt}}~{\mathrm{globals}}({{\mathit{et}}^\ast}) &  \\
{\mathrm{globals}}({\mathit{externtype}}~{{\mathit{et}}^\ast}) &=& {\mathrm{globals}}({{\mathit{et}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{tables}}(\epsilon) &=& \epsilon &  \\
{\mathrm{tables}}((\mathsf{table}~{\mathit{tt}})~{{\mathit{et}}^\ast}) &=& {\mathit{tt}}~{\mathrm{tables}}({{\mathit{et}}^\ast}) &  \\
{\mathrm{tables}}({\mathit{externtype}}~{{\mathit{et}}^\ast}) &=& {\mathrm{tables}}({{\mathit{et}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{mems}}(\epsilon) &=& \epsilon &  \\
{\mathrm{mems}}((\mathsf{mem}~{\mathit{mt}})~{{\mathit{et}}^\ast}) &=& {\mathit{mt}}~{\mathrm{mems}}({{\mathit{et}}^\ast}) &  \\
{\mathrm{mems}}({\mathit{externtype}}~{{\mathit{et}}^\ast}) &=& {\mathrm{mems}}({{\mathit{et}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
 &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~0,\; \mathsf{offset}~0 \}\end{array} &  \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{signed}}}_{{\mathit{N}}}({\mathit{i}}) &=& {\mathit{i}} &\quad
  \mbox{if}~0 \leq {2^{{\mathit{N}} - 1}} \\
{{\mathrm{signed}}}_{{\mathit{N}}}({\mathit{i}}) &=& {\mathit{i}} - {2^{{\mathit{N}}}} &\quad
  \mbox{if}~{2^{{\mathit{N}} - 1}} \leq {\mathit{i}} < {2^{{\mathit{N}}}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{{\mathrm{signed}}^{{-1}}}}{}}_{{\mathit{N}}}}{{\mathit{i}}} &=& {\mathit{j}} &\quad
  \mbox{if}~{{\mathrm{signed}}}_{{\mathit{N}}}({\mathit{j}}) = {\mathit{i}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{invibytes}}({\mathit{N}}, {{\mathit{b}}^\ast}) &=& {\mathit{n}} &\quad
  \mbox{if}~{{\mathrm{bytes}}}_{{{\mathit{i}}}{{\mathit{N}}}}({\mathit{n}}) = {{\mathit{b}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{invfbytes}}({\mathit{N}}, {{\mathit{b}}^\ast}) &=& {\mathit{p}} &\quad
  \mbox{if}~{{\mathrm{bytes}}}_{{{\mathit{f}}}{{\mathit{N}}}}({\mathit{p}}) = {{\mathit{b}}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(address)} & {\mathit{addr}} &::=& {\mathit{nat}} \\
\mbox{(function address)} & {\mathit{funcaddr}} &::=& {\mathit{addr}} \\
\mbox{(global address)} & {\mathit{globaladdr}} &::=& {\mathit{addr}} \\
\mbox{(table address)} & {\mathit{tableaddr}} &::=& {\mathit{addr}} \\
\mbox{(memory address)} & {\mathit{memaddr}} &::=& {\mathit{addr}} \\
\mbox{(elem address)} & {\mathit{elemaddr}} &::=& {\mathit{addr}} \\
\mbox{(data address)} & {\mathit{dataaddr}} &::=& {\mathit{addr}} \\
\mbox{(host address)} & {\mathit{hostaddr}} &::=& {\mathit{addr}} \\
\mbox{(structure address)} & {\mathit{structaddr}} &::=& {\mathit{addr}} \\
\mbox{(array address)} & {\mathit{arrayaddr}} &::=& {\mathit{addr}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(number)} & {\mathit{num}} &::=& {\mathit{numtype}}.\mathsf{const}~{\mathit{c}}_{{\mathit{numtype}}} \\
\mbox{(address reference)} & {\mathit{addrref}} &::=& \mathsf{ref.i{\scriptstyle31}}~{\mathit{u{\scriptstyle31}}} \\ &&|&
\mathsf{ref.struct}~{\mathit{structaddr}} \\ &&|&
\mathsf{ref.array}~{\mathit{arrayaddr}} \\ &&|&
\mathsf{ref.func}~{\mathit{funcaddr}} \\ &&|&
\mathsf{ref.host}~{\mathit{hostaddr}} \\ &&|&
\mathsf{ref.extern}~{\mathit{addrref}} \\
\mbox{(reference)} & {\mathit{ref}} &::=& {\mathit{addrref}} \\ &&|&
\mathsf{ref.null}~{\mathit{heaptype}} \\
\mbox{(value)} & {\mathit{val}} &::=& {\mathit{num}} ~|~ {\mathit{ref}} \\
\mbox{(result)} & {\mathit{result}} &::=& {{\mathit{val}}^\ast} ~|~ \mathsf{trap} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(external value)} & {\mathit{externval}} &::=& \mathsf{func}~{\mathit{funcaddr}} ~|~ \mathsf{global}~{\mathit{globaladdr}} ~|~ \mathsf{table}~{\mathit{tableaddr}} ~|~ \mathsf{mem}~{\mathit{memaddr}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{c}}_{{\mathit{packedtype}}} &::=& {\mathit{nat}} \\
\mbox{(function instance)} & {\mathit{funcinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \\
  \mathsf{module}~{\mathit{moduleinst}},\; \\
  \mathsf{code}~{\mathit{func}} \;\}\end{array} \\
\mbox{(global instance)} & {\mathit{globalinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{globaltype}},\; \\
  \mathsf{value}~{\mathit{val}} \;\}\end{array} \\
\mbox{(table instance)} & {\mathit{tableinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{tabletype}},\; \\
  \mathsf{elem}~{{\mathit{ref}}^\ast} \;\}\end{array} \\
\mbox{(memory instance)} & {\mathit{meminst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{memtype}},\; \\
  \mathsf{data}~{{\mathit{byte}}^\ast} \;\}\end{array} \\
\mbox{(element instance)} & {\mathit{eleminst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{elemtype}},\; \\
  \mathsf{elem}~{{\mathit{ref}}^\ast} \;\}\end{array} \\
\mbox{(data instance)} & {\mathit{datainst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{data}~{{\mathit{byte}}^\ast} \;\}\end{array} \\
\mbox{(export instance)} & {\mathit{exportinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \\
  \mathsf{value}~{\mathit{externval}} \;\}\end{array} \\
\mbox{(packed value)} & {\mathit{packedval}} &::=& {\mathit{packedtype}}.\mathsf{pack}~{\mathit{c}}_{{\mathit{packedtype}}} \\
\mbox{(field value)} & {\mathit{fieldval}} &::=& {\mathit{val}} ~|~ {\mathit{packedval}} \\
\mbox{(structure instance)} & {\mathit{structinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \\
  \mathsf{field}~{{\mathit{fieldval}}^\ast} \;\}\end{array} \\
\mbox{(array instance)} & {\mathit{arrayinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{\mathit{deftype}},\; \\
  \mathsf{field}~{{\mathit{fieldval}}^\ast} \;\}\end{array} \\
\mbox{(module instance)} & {\mathit{moduleinst}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{{\mathit{deftype}}^\ast},\; \\
  \mathsf{func}~{{\mathit{funcaddr}}^\ast},\; \\
  \mathsf{global}~{{\mathit{globaladdr}}^\ast},\; \\
  \mathsf{table}~{{\mathit{tableaddr}}^\ast},\; \\
  \mathsf{mem}~{{\mathit{memaddr}}^\ast},\; \\
  \mathsf{elem}~{{\mathit{elemaddr}}^\ast},\; \\
  \mathsf{data}~{{\mathit{dataaddr}}^\ast},\; \\
  \mathsf{export}~{{\mathit{exportinst}}^\ast} \;\}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(store)} & {\mathit{store}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{func}~{{\mathit{funcinst}}^\ast},\; \\
  \mathsf{global}~{{\mathit{globalinst}}^\ast},\; \\
  \mathsf{table}~{{\mathit{tableinst}}^\ast},\; \\
  \mathsf{mem}~{{\mathit{meminst}}^\ast},\; \\
  \mathsf{elem}~{{\mathit{eleminst}}^\ast},\; \\
  \mathsf{data}~{{\mathit{datainst}}^\ast},\; \\
  \mathsf{struct}~{{\mathit{structinst}}^\ast},\; \\
  \mathsf{array}~{{\mathit{arrayinst}}^\ast} \;\}\end{array} \\
\mbox{(frame)} & {\mathit{frame}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{local}~{({{\mathit{val}}^?})^\ast},\; \\
  \mathsf{module}~{\mathit{moduleinst}} \;\}\end{array} \\
\mbox{(state)} & {\mathit{state}} &::=& {\mathit{store}} ; {\mathit{frame}} \\
\mbox{(configuration)} & {\mathit{config}} &::=& {\mathit{state}} ; {{\mathit{instr}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(administrative instruction)} & {\mathit{instr}} &::=& {\mathit{instr}} \\ &&|&
{\mathit{addrref}} \\ &&|&
{{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}}^\ast}\}}~{{\mathit{instr}}^\ast} \\ &&|&
{{\mathsf{frame}}_{{\mathit{n}}}}{\{{\mathit{frame}}\}}~{{\mathit{instr}}^\ast} \\ &&|&
\mathsf{trap} \\
\mbox{(evaluation context)} & {\mathit{E}} &::=& [\mathsf{\_}] \\ &&|&
{{\mathit{val}}^\ast}~{\mathit{E}}~{{\mathit{instr}}^\ast} \\ &&|&
{{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}}^\ast}\}}~{\mathit{E}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{inst}}}_{{\mathit{mm}}}({\mathit{rt}}) &=& {{\mathit{rt}}}{[{ := }\;{{\mathit{dt}}^\ast}]} &\quad
  \mbox{if}~{{\mathit{dt}}^\ast} = {\mathit{mm}}.\mathsf{type} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{default}}~\mathsf{i{\scriptstyle32}} &=& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &  \\
{\mathrm{default}}~\mathsf{i{\scriptstyle64}} &=& (\mathsf{i{\scriptstyle64}}.\mathsf{const}~0) &  \\
{\mathrm{default}}~\mathsf{f{\scriptstyle32}} &=& (\mathsf{f{\scriptstyle32}}.\mathsf{const}~0) &  \\
{\mathrm{default}}~\mathsf{f{\scriptstyle64}} &=& (\mathsf{f{\scriptstyle64}}.\mathsf{const}~0) &  \\
{\mathrm{default}}~\mathsf{ref}~\mathsf{null}~{\mathit{ht}} &=& (\mathsf{ref.null}~{\mathit{ht}}) &  \\
{\mathrm{default}}~\mathsf{ref}~\epsilon~{\mathit{ht}} &=& \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{pack}}}_{{\mathit{t}}}({\mathit{val}}) &=& {\mathit{val}} &  \\
{{\mathrm{pack}}}_{{\mathit{pt}}}(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}) &=& {\mathit{pt}}.\mathsf{pack}~{{{\mathrm{wrap}}}_{(32,\, {|{\mathit{pt}}|})}}{({\mathit{i}})} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{{{\mathrm{unpack}}}_{{\mathit{t}}}^{\epsilon}}}{({\mathit{val}})} &=& {\mathit{val}} &  \\
{{{{\mathrm{unpack}}}_{{\mathit{pt}}}^{{\mathit{sx}}}}}{({\mathit{pt}}.\mathsf{pack}~{\mathit{i}})} &=& \mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{\mathrm{ext}}}_{({|{\mathit{pt}}|},\, 32)}^{{\mathit{sx}}}}}{({\mathit{i}})} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{funcs}}(\epsilon) &=& \epsilon &  \\
{\mathrm{funcs}}((\mathsf{func}~{\mathit{fa}})~{{\mathit{xv}}^\ast}) &=& {\mathit{fa}}~{\mathrm{funcs}}({{\mathit{xv}}^\ast}) &  \\
{\mathrm{funcs}}({\mathit{externval}}~{{\mathit{xv}}^\ast}) &=& {\mathrm{funcs}}({{\mathit{xv}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{globals}}(\epsilon) &=& \epsilon &  \\
{\mathrm{globals}}((\mathsf{global}~{\mathit{ga}})~{{\mathit{xv}}^\ast}) &=& {\mathit{ga}}~{\mathrm{globals}}({{\mathit{xv}}^\ast}) &  \\
{\mathrm{globals}}({\mathit{externval}}~{{\mathit{xv}}^\ast}) &=& {\mathrm{globals}}({{\mathit{xv}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{tables}}(\epsilon) &=& \epsilon &  \\
{\mathrm{tables}}((\mathsf{table}~{\mathit{ta}})~{{\mathit{xv}}^\ast}) &=& {\mathit{ta}}~{\mathrm{tables}}({{\mathit{xv}}^\ast}) &  \\
{\mathrm{tables}}({\mathit{externval}}~{{\mathit{xv}}^\ast}) &=& {\mathrm{tables}}({{\mathit{xv}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{mems}}(\epsilon) &=& \epsilon &  \\
{\mathrm{mems}}((\mathsf{mem}~{\mathit{ma}})~{{\mathit{xv}}^\ast}) &=& {\mathit{ma}}~{\mathrm{mems}}({{\mathit{xv}}^\ast}) &  \\
{\mathrm{mems}}({\mathit{externval}}~{{\mathit{xv}}^\ast}) &=& {\mathrm{mems}}({{\mathit{xv}}^\ast}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{store} &=& {\mathit{s}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{frame} &=& {\mathit{f}} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{module}.\mathsf{func} &=& {\mathit{f}}.\mathsf{module}.\mathsf{func} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{func} &=& {\mathit{s}}.\mathsf{func} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{global} &=& {\mathit{s}}.\mathsf{global} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{table} &=& {\mathit{s}}.\mathsf{table} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{mem} &=& {\mathit{s}}.\mathsf{mem} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{elem} &=& {\mathit{s}}.\mathsf{elem} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{data} &=& {\mathit{s}}.\mathsf{data} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{struct} &=& {\mathit{s}}.\mathsf{struct} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{array} &=& {\mathit{s}}.\mathsf{array} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{module} &=& {\mathit{f}}.\mathsf{module} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}}).\mathsf{type}~[{\mathit{x}}] &=& {\mathit{f}}.\mathsf{module}.\mathsf{type}[{\mathit{x}}] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{func}}{[{\mathit{x}}]} &=& {\mathit{s}}.\mathsf{func}[{\mathit{f}}.\mathsf{module}.\mathsf{func}[{\mathit{x}}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{global}}{[{\mathit{x}}]} &=& {\mathit{s}}.\mathsf{global}[{\mathit{f}}.\mathsf{module}.\mathsf{global}[{\mathit{x}}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{table}}{[{\mathit{x}}]} &=& {\mathit{s}}.\mathsf{table}[{\mathit{f}}.\mathsf{module}.\mathsf{table}[{\mathit{x}}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{mem}}{[{\mathit{x}}]} &=& {\mathit{s}}.\mathsf{mem}[{\mathit{f}}.\mathsf{module}.\mathsf{mem}[{\mathit{x}}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{elem}}{[{\mathit{x}}]} &=& {\mathit{s}}.\mathsf{elem}[{\mathit{f}}.\mathsf{module}.\mathsf{elem}[{\mathit{x}}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{data}}{[{\mathit{x}}]} &=& {\mathit{s}}.\mathsf{data}[{\mathit{f}}.\mathsf{module}.\mathsf{data}[{\mathit{x}}]] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{({\mathit{s}} ; {\mathit{f}}).\mathsf{local}}{[{\mathit{x}}]} &=& {\mathit{f}}.\mathsf{local}[{\mathit{x}}] &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{local}[{\mathit{x}}] = {\mathit{v}}] &=& {\mathit{s}} ; {\mathit{f}}[\mathsf{local}[{\mathit{x}}] = {\mathit{v}}] &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{global}[{\mathit{x}}].\mathsf{value} = {\mathit{v}}] &=& {\mathit{s}}[\mathsf{global}[{\mathit{f}}.\mathsf{module}.\mathsf{global}[{\mathit{x}}]].\mathsf{value} = {\mathit{v}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{table}[{\mathit{x}}].\mathsf{elem}[{\mathit{i}}] = {\mathit{r}}] &=& {\mathit{s}}[\mathsf{table}[{\mathit{f}}.\mathsf{module}.\mathsf{table}[{\mathit{x}}]].\mathsf{elem}[{\mathit{i}}] = {\mathit{r}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{table}[{\mathit{x}}] = {\mathit{ti}}] &=& {\mathit{s}}[\mathsf{table}[{\mathit{f}}.\mathsf{module}.\mathsf{table}[{\mathit{x}}]] = {\mathit{ti}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{mem}[{\mathit{x}}].\mathsf{data}[{\mathit{i}} : {\mathit{j}}] = {{\mathit{b}}^\ast}] &=& {\mathit{s}}[\mathsf{mem}[{\mathit{f}}.\mathsf{module}.\mathsf{mem}[{\mathit{x}}]].\mathsf{data}[{\mathit{i}} : {\mathit{j}}] = {{\mathit{b}}^\ast}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{mem}[{\mathit{x}}] = {\mathit{mi}}] &=& {\mathit{s}}[\mathsf{mem}[{\mathit{f}}.\mathsf{module}.\mathsf{mem}[{\mathit{x}}]] = {\mathit{mi}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{elem}[{\mathit{x}}].\mathsf{elem} = {{\mathit{r}}^\ast}] &=& {\mathit{s}}[\mathsf{elem}[{\mathit{f}}.\mathsf{module}.\mathsf{elem}[{\mathit{x}}]].\mathsf{elem} = {{\mathit{r}}^\ast}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{data}[{\mathit{x}}].\mathsf{data} = {{\mathit{b}}^\ast}] &=& {\mathit{s}}[\mathsf{data}[{\mathit{f}}.\mathsf{module}.\mathsf{data}[{\mathit{x}}]].\mathsf{data} = {{\mathit{b}}^\ast}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{struct}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] &=& {\mathit{s}}[\mathsf{struct}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{struct}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] &=& {\mathit{s}}[\mathsf{array}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{struct} = ..{{\mathit{si}}^\ast}] &=& {\mathit{s}}[\mathsf{struct} = ..{{\mathit{si}}^\ast}] ; {\mathit{f}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
({\mathit{s}} ; {\mathit{f}})[\mathsf{array} = ..{{\mathit{ai}}^\ast}] &=& {\mathit{s}}[\mathsf{array} = ..{{\mathit{ai}}^\ast}] ; {\mathit{f}} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{growtable}}({\mathit{ti}}, {\mathit{n}}, {\mathit{r}}) &=& {\mathit{ti}'} &\quad
  \mbox{if}~{\mathit{ti}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}} .. {\mathit{j}}]~{\mathit{rt}}),\; \mathsf{elem}~{{\mathit{r}'}^\ast} \}\end{array} \\
 &&&\quad {\land}~{\mathit{i}'} = {|{{\mathit{r}'}^\ast}|} + {\mathit{n}} \\
 &&&\quad {\land}~{\mathit{ti}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}'} .. {\mathit{j}}]~{\mathit{rt}}),\; \mathsf{elem}~{{\mathit{r}'}^\ast}~{{\mathit{r}}^{{\mathit{n}}}} \}\end{array} \\
 &&&\quad {\land}~{\mathit{i}'} \leq {\mathit{j}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{growmemory}}({\mathit{mi}}, {\mathit{n}}) &=& {\mathit{mi}'} &\quad
  \mbox{if}~{\mathit{mi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{{\mathit{b}}^\ast} \}\end{array} \\
 &&&\quad {\land}~{\mathit{i}'} = {|{{\mathit{b}}^\ast}|} / (64 \cdot {\mathrm{Ki}}) + {\mathit{n}} \\
 &&&\quad {\land}~{\mathit{mi}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}'} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{{\mathit{b}}^\ast}~{0^{{\mathit{n}} \cdot 64 \cdot {\mathrm{Ki}}}} \}\end{array} \\
 &&&\quad {\land}~{\mathit{i}'} \leq {\mathit{j}} \\
\end{array}
$$

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(initialization status)} & {\mathit{init}} &::=& \mathsf{set} ~|~ \mathsf{unset} \\
\mbox{(local type)} & {\mathit{localtype}} &::=& {\mathit{init}}~{\mathit{valtype}} \\
\mbox{(instruction type)} & {\mathit{instrtype}} &::=& {\mathit{resulttype}} \rightarrow {{\mathit{localidx}}^\ast}~{\mathit{resulttype}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
\mbox{(context)} & {\mathit{context}} &::=& \{\; \begin{array}[t]{@{}l@{}l@{}}
\mathsf{type}~{{\mathit{deftype}}^\ast},\; \mathsf{rec}~{{\mathit{subtype}}^\ast},\; \\
  \mathsf{func}~{{\mathit{deftype}}^\ast},\; \mathsf{global}~{{\mathit{globaltype}}^\ast},\; \mathsf{table}~{{\mathit{tabletype}}^\ast},\; \mathsf{mem}~{{\mathit{memtype}}^\ast},\; \\
  \mathsf{elem}~{{\mathit{elemtype}}^\ast},\; \mathsf{data}~{{\mathit{datatype}}^\ast},\; \\
  \mathsf{local}~{{\mathit{localtype}}^\ast},\; \mathsf{label}~{{\mathit{resulttype}}^\ast},\; \mathsf{return}~{{\mathit{resulttype}}^?} \;\}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{C}}[\mathsf{local}[\epsilon] = \epsilon] &=& {\mathit{C}} &  \\
{\mathit{C}}[\mathsf{local}[{\mathit{x}}_{{1}}~{{\mathit{x}}^\ast}] = {\mathit{lt}}_{{1}}~{{\mathit{lt}}^\ast}] &=& {\mathit{C}}[\mathsf{local}[{\mathit{x}}_{{1}}] = {\mathit{lt}}_{{1}}][\mathsf{local}[{{\mathit{x}}^\ast}] = {{\mathit{lt}}^\ast}] &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{clos}}~{\mathit{C}}~({\mathit{dt}}) &=& {{\mathit{dt}}}{[{ := }\;{{\mathit{dt}'}^\ast}]} &\quad
  \mbox{if}~{{\mathit{dt}'}^\ast} = {\mathrm{clos}}~{}^\ast~({\mathit{C}}.\mathsf{type}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{clos}}~{}^\ast~(\epsilon) &=& \epsilon &  \\
{\mathrm{clos}}~{}^\ast~({{\mathit{dt}}^\ast}~{\mathit{dt}}_{{\mathit{N}}}) &=& {{\mathit{dt}'}^\ast}~{{\mathit{dt}}_{{\mathit{N}}}}{[{ := }\;{{\mathit{dt}'}^\ast}]} &\quad
  \mbox{if}~{{\mathit{dt}'}^\ast} = {\mathrm{clos}}~{}^\ast~({{\mathit{dt}}^\ast}) \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{numtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{vectype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{heaptype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{reftype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{valtype}} : \mathsf{ok}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{numtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{vectype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}vec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{absheaptype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}heap{-}abs}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] = {\mathit{dt}}
}{
{\mathit{C}} \vdash {\mathit{x}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}heap{-}typeidx}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{rec}[{\mathit{i}}] = {\mathit{st}}
}{
{\mathit{C}} \vdash \mathsf{rec}~{\mathit{i}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}heap{-}rec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ht}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{ref}~{\mathit{nul}}~{\mathit{ht}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{numtype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{numtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}val{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{vectype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{vectype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}val{-}vec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{reftype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{reftype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}val{-}ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{bot} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}val{-}bot}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{resulttype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{instrtype}} : \mathsf{ok}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{t}} : \mathsf{ok})^\ast
}{
{\mathit{C}} \vdash {{\mathit{t}}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}result}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
 \qquad
(({\mathit{C}}.\mathsf{local}[{\mathit{x}}] = {\mathit{lt}}))^\ast
}{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{x}}^\ast}~{{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}instr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathsf{ok}}{({\mathit{typeidx}})} &::=& {\mathsf{ok}}{{\mathit{typeidx}}} \\
& {\mathsf{ok}}{({\mathit{typeidx}},\, {\mathit{n}})} &::=& {\mathsf{ok}}{({\mathit{typeidx}},\, {\mathit{nat}})} \\
\end{array}
$$

$\boxed{{\mathit{context}} \vdash {\mathit{packedtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{fieldtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{storagetype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{comptype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{functype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{subtype}} : {\mathsf{ok}}{({\mathit{typeidx}})}}$

$\boxed{{\mathit{context}} \vdash {\mathit{rectype}} : {\mathsf{ok}}{({\mathit{typeidx}})}}$

$\boxed{{\mathit{context}} \vdash {\mathit{subtype}} : {\mathsf{ok}}{({\mathit{typeidx}},\, {\mathit{n}})}}$

$\boxed{{\mathit{context}} \vdash {\mathit{rectype}} : {\mathsf{ok}}{({\mathit{typeidx}},\, {\mathit{n}})}}$

$\boxed{{\mathit{context}} \vdash {\mathit{deftype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{comptype}} \leq {\mathit{comptype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{deftype}} \leq {\mathit{deftype}}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{packedtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}packed}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{valtype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{valtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}storage{-}val}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{packedtype}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{packedtype}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}storage{-}packed}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{zt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{mut}}~{\mathit{zt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}field}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{yt}} : \mathsf{ok})^\ast
}{
{\mathit{C}} \vdash \mathsf{struct}~{{\mathit{yt}}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}comp{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{yt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{array}~{\mathit{yt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}comp{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ft}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{ft}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}comp{-}func}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{|{{\mathit{y}}^\ast}|} \leq 1
 \qquad
(({\mathit{y}} < {\mathit{x}}))^\ast
 \qquad
(({\mathrm{unroll}}({\mathit{C}}.\mathsf{type}[{\mathit{y}}]) = \mathsf{sub}~{{\mathit{y}'}^\ast}~{\mathit{ct}'}))^\ast
 \qquad
{\mathit{C}} \vdash {\mathit{ct}} : \mathsf{ok}
 \qquad
({\mathit{C}} \vdash {\mathit{ct}} \leq {\mathit{ct}'})^\ast
}{
{\mathit{C}} \vdash \mathsf{sub}~{\mathit{fin}}~{{\mathit{y}}^\ast}~{\mathit{ct}} : {\mathsf{ok}}{({\mathit{x}})}
} \, {[\textsc{\scriptsize K{-}sub}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{deftype}} \prec {\mathit{x}}, {\mathit{i}} &=& \mathsf{true} &  \\
{\mathit{typeidx}} \prec {\mathit{x}}, {\mathit{i}} &=& {\mathit{typeidx}} < {\mathit{x}} &  \\
\mathsf{rec}~{\mathit{j}} \prec {\mathit{x}}, {\mathit{i}} &=& {\mathit{j}} < {\mathit{i}} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{unroll}}}_{{\mathit{C}}}({\mathit{deftype}}) &=& {\mathrm{unroll}}({\mathit{deftype}}) &  \\
{{\mathrm{unroll}}}_{{\mathit{C}}}({\mathit{typeidx}}) &=& {\mathrm{unroll}}({\mathit{C}}.\mathsf{type}[{\mathit{typeidx}}]) &  \\
{{\mathrm{unroll}}}_{{\mathit{C}}}(\mathsf{rec}~{\mathit{i}}) &=& {\mathit{C}}.\mathsf{rec}[{\mathit{i}}] &  \\
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{|{{\mathit{ht}}^\ast}|} \leq 1
 \qquad
(({\mathit{ht}} \prec {\mathit{x}}, {\mathit{i}}))^\ast
 \qquad
(({{\mathrm{unroll}}}_{{\mathit{C}}}({\mathit{ht}}) = \mathsf{subd}~{{\mathit{ht}'}^\ast}~{\mathit{ct}'}))^\ast
 \qquad
{\mathit{C}} \vdash {\mathit{ct}} : \mathsf{ok}
 \qquad
({\mathit{C}} \vdash {\mathit{ct}} \leq {\mathit{ct}'})^\ast
}{
{\mathit{C}} \vdash \mathsf{sub}~{\mathit{fin}}~{{\mathit{ht}}^\ast}~{\mathit{ct}} : {\mathsf{ok}}{({\mathit{x}},\, {\mathit{i}})}
} \, {[\textsc{\scriptsize K{-}sub2}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{rec}~\epsilon : {\mathsf{ok}}{({\mathit{x}})}
} \, {[\textsc{\scriptsize K{-}rect{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{st}}_{{1}} : {\mathsf{ok}}{({\mathit{x}})}
 \qquad
{\mathit{C}} \vdash \mathsf{rec}~{{\mathit{st}}^\ast} : {\mathsf{ok}}{({\mathit{x}} + 1)}
}{
{\mathit{C}} \vdash \mathsf{rec}~{\mathit{st}}_{{1}}~{{\mathit{st}}^\ast} : {\mathsf{ok}}{({\mathit{x}})}
} \, {[\textsc{\scriptsize K{-}rect{-}cons}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}, \mathsf{rec}~{{\mathit{st}}^\ast} \vdash \mathsf{rec}~{{\mathit{st}}^\ast} : {\mathsf{ok}}{({\mathit{x}},\, 0)}
}{
{\mathit{C}} \vdash \mathsf{rec}~{{\mathit{st}}^\ast} : {\mathsf{ok}}{({\mathit{x}})}
} \, {[\textsc{\scriptsize K{-}rect{-}rec2}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{rec}~\epsilon : {\mathsf{ok}}{({\mathit{x}},\, {\mathit{i}})}
} \, {[\textsc{\scriptsize K{-}rec2{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{st}}_{{1}} : {\mathsf{ok}}{({\mathit{x}},\, {\mathit{i}})}
 \qquad
{\mathit{C}} \vdash \mathsf{rec}~{{\mathit{st}}^\ast} : {\mathsf{ok}}{({\mathit{x}} + 1,\, {\mathit{i}} + 1)}
}{
{\mathit{C}} \vdash \mathsf{rec}~{\mathit{st}}_{{1}}~{{\mathit{st}}^\ast} : {\mathsf{ok}}{({\mathit{x}},\, {\mathit{i}})}
} \, {[\textsc{\scriptsize K{-}rec2{-}cons}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{qt}} : {\mathsf{ok}}{({\mathit{x}})}
 \qquad
{\mathit{qt}} = \mathsf{rec}~{{\mathit{st}}^{{\mathit{n}}}}
 \qquad
{\mathit{i}} < {\mathit{n}}
}{
{\mathit{C}} \vdash {\mathit{qt}} . {\mathit{i}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}def}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{limits}} : {\mathit{nat}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{globaltype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{tabletype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{memtype}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{externtype}} : \mathsf{ok}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{n}}_{{1}} \leq {\mathit{n}}_{{2}} \leq {\mathit{k}}
}{
{\mathit{C}} \vdash [{\mathit{n}}_{{1}} .. {\mathit{n}}_{{2}}] : {\mathit{k}}
} \, {[\textsc{\scriptsize K{-}limits}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
}{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{t}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{mut}}~{\mathit{t}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{lim}} : {2^{32}} - 1
 \qquad
{\mathit{C}} \vdash {\mathit{rt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash {\mathit{lim}}~{\mathit{rt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{lim}} : {2^{16}}
}{
{\mathit{C}} \vdash {\mathit{lim}}~\mathsf{i{\scriptstyle8}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{dt}} : \mathsf{ok}
 \qquad
{\mathit{dt}} \approx \mathsf{func}~{\mathit{ft}}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{dt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{gt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{global}~{\mathit{gt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{tt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{table}~{\mathit{tt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{mt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{mem}~{\mathit{mt}} : \mathsf{ok}
} \, {[\textsc{\scriptsize K{-}extern{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{numtype}} \leq {\mathit{numtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{vectype}} \leq {\mathit{vectype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{heaptype}} \leq {\mathit{heaptype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{reftype}} \leq {\mathit{reftype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{valtype}} \leq {\mathit{valtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{numtype}} \leq {\mathit{numtype}}
} \, {[\textsc{\scriptsize S{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{vectype}} \leq {\mathit{vectype}}
} \, {[\textsc{\scriptsize S{-}vec}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}refl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{heaptype}'} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{heaptype}}_{{1}} \leq {\mathit{heaptype}'}
 \qquad
{\mathit{C}} \vdash {\mathit{heaptype}'} \leq {\mathit{heaptype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{heaptype}}_{{1}} \leq {\mathit{heaptype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}heap{-}trans}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{eq} \leq \mathsf{any}
} \, {[\textsc{\scriptsize S{-}heap{-}eq{-}any}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{i{\scriptstyle31}} \leq \mathsf{eq}
} \, {[\textsc{\scriptsize S{-}heap{-}i31{-}eq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{struct} \leq \mathsf{eq}
} \, {[\textsc{\scriptsize S{-}heap{-}struct{-}eq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{array} \leq \mathsf{eq}
} \, {[\textsc{\scriptsize S{-}heap{-}array{-}eq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{deftype}} \approx \mathsf{struct}~{{\mathit{yt}}^\ast}
}{
{\mathit{C}} \vdash {\mathit{deftype}} \leq \mathsf{struct}
} \, {[\textsc{\scriptsize S{-}heap{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{deftype}} \approx \mathsf{array}~{\mathit{yt}}
}{
{\mathit{C}} \vdash {\mathit{deftype}} \leq \mathsf{array}
} \, {[\textsc{\scriptsize S{-}heap{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{deftype}} \approx \mathsf{func}~{\mathit{ft}}
}{
{\mathit{C}} \vdash {\mathit{deftype}} \leq \mathsf{func}
} \, {[\textsc{\scriptsize S{-}heap{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{deftype}}_{{1}} \leq {\mathit{deftype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{deftype}}_{{1}} \leq {\mathit{deftype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}heap{-}def}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{C}}.\mathsf{type}[{\mathit{typeidx}}] \leq {\mathit{heaptype}}
}{
{\mathit{C}} \vdash {\mathit{typeidx}} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}typeidx{-}l}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq {\mathit{C}}.\mathsf{type}[{\mathit{typeidx}}]
}{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq {\mathit{typeidx}}
} \, {[\textsc{\scriptsize S{-}heap{-}typeidx{-}r}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{rec}[{\mathit{i}}] = \mathsf{sub}~{\mathit{fin}}~({{\mathit{ht}}_{{1}}^\ast}~{\mathit{ht}}~{{\mathit{ht}}_{{2}}^\ast})~{\mathit{ct}}
}{
{\mathit{C}} \vdash \mathsf{rec}~{\mathit{i}} \leq {\mathit{ht}}
} \, {[\textsc{\scriptsize S{-}heap{-}rec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq \mathsf{any}
}{
{\mathit{C}} \vdash \mathsf{none} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}none}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq \mathsf{func}
}{
{\mathit{C}} \vdash \mathsf{nofunc} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}nofunc}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{heaptype}} \leq \mathsf{extern}
}{
{\mathit{C}} \vdash \mathsf{noextern} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}noextern}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{bot} \leq {\mathit{heaptype}}
} \, {[\textsc{\scriptsize S{-}heap{-}bot}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ht}}_{{1}} \leq {\mathit{ht}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{ref}~{\mathit{ht}}_{{1}} \leq \mathsf{ref}~{\mathit{ht}}_{{2}}
} \, {[\textsc{\scriptsize S{-}ref{-}nonnull}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ht}}_{{1}} \leq {\mathit{ht}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{ref}~{\mathsf{null}^?}~{\mathit{ht}}_{{1}} \leq \mathsf{ref}~\mathsf{null}~{\mathit{ht}}_{{2}}
} \, {[\textsc{\scriptsize S{-}ref{-}null}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{numtype}}_{{1}} \leq {\mathit{numtype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{numtype}}_{{1}} \leq {\mathit{numtype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}val{-}num}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{vectype}}_{{1}} \leq {\mathit{vectype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{vectype}}_{{1}} \leq {\mathit{vectype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}val{-}vec}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{reftype}}_{{1}} \leq {\mathit{reftype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{reftype}}_{{1}} \leq {\mathit{reftype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}val{-}ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{bot} \leq {\mathit{valtype}}
} \, {[\textsc{\scriptsize S{-}val{-}bot}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {{\mathit{valtype}}^\ast} \leq {{\mathit{valtype}}^\ast}}$

$\boxed{{\mathit{context}} \vdash {\mathit{instrtype}} \leq {\mathit{instrtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{t}}_{{1}} \leq {\mathit{t}}_{{2}})^\ast
}{
{\mathit{C}} \vdash {{\mathit{t}}_{{1}}^\ast} \leq {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize S{-}result}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{t}}_{{21}}^\ast} \leq {{\mathit{t}}_{{11}}^\ast}
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{12}}^\ast} \leq {{\mathit{t}}_{{22}}^\ast}
 \qquad
{{\mathit{x}}^\ast} = {{\mathit{x}}_{{2}}^\ast} \setminus {{\mathit{x}}_{{1}}^\ast}
 \qquad
(({\mathit{C}}.\mathsf{local}[{\mathit{x}}] = \mathsf{set}~{\mathit{t}}))^\ast
}{
{\mathit{C}} \vdash {{\mathit{t}}_{{11}}^\ast} \rightarrow ({{\mathit{x}}_{{1}}^\ast})~{{\mathit{t}}_{{12}}^\ast} \leq {{\mathit{t}}_{{21}}^\ast} \rightarrow ({{\mathit{x}}_{{2}}^\ast})~{{\mathit{t}}_{{22}}^\ast}
} \, {[\textsc{\scriptsize S{-}instr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{packedtype}} \leq {\mathit{packedtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{storagetype}} \leq {\mathit{storagetype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{fieldtype}} \leq {\mathit{fieldtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{functype}} \leq {\mathit{functype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{packedtype}} \leq {\mathit{packedtype}}
} \, {[\textsc{\scriptsize S{-}packed}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{valtype}}_{{1}} \leq {\mathit{valtype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{valtype}}_{{1}} \leq {\mathit{valtype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}storage{-}val}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{packedtype}}_{{1}} \leq {\mathit{packedtype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{packedtype}}_{{1}} \leq {\mathit{packedtype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}storage{-}packed}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{zt}}_{{1}} \leq {\mathit{zt}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{zt}}_{{1}} \leq {\mathit{zt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}field{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{zt}}_{{1}} \leq {\mathit{zt}}_{{2}}
 \qquad
{\mathit{C}} \vdash {\mathit{zt}}_{{2}} \leq {\mathit{zt}}_{{1}}
}{
{\mathit{C}} \vdash \mathsf{mut}~{\mathit{zt}}_{{1}} \leq \mathsf{mut}~{\mathit{zt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}field{-}var}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{yt}}_{{1}} \leq {\mathit{yt}}_{{2}})^\ast
}{
{\mathit{C}} \vdash \mathsf{struct}~{{\mathit{yt}}_{{1}}^\ast}~{\mathit{yt}'}_{{1}} \leq \mathsf{struct}~{{\mathit{yt}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize S{-}comp{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{yt}}_{{1}} \leq {\mathit{yt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{array}~{\mathit{yt}}_{{1}} \leq \mathsf{array}~{\mathit{yt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}comp{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ft}}_{{1}} \leq {\mathit{ft}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{ft}}_{{1}} \leq \mathsf{func}~{\mathit{ft}}_{{2}}
} \, {[\textsc{\scriptsize S{-}comp{-}func}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathrm{clos}}~{\mathit{C}}~({\mathit{deftype}}_{{1}}) = {\mathrm{clos}}~{\mathit{C}}~({\mathit{deftype}}_{{2}})
}{
{\mathit{C}} \vdash {\mathit{deftype}}_{{1}} \leq {\mathit{deftype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}def{-}refl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathrm{unroll}}({\mathit{deftype}}_{{1}}) = \mathsf{sub}~{\mathit{fin}}~({{\mathit{ht}}_{{1}}^\ast}~{\mathit{ht}}~{{\mathit{ht}}_{{2}}^\ast})~{\mathit{ct}}
 \qquad
{\mathit{C}} \vdash {\mathit{ht}} \leq {\mathit{deftype}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{deftype}}_{{1}} \leq {\mathit{deftype}}_{{2}}
} \, {[\textsc{\scriptsize S{-}def{-}super}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{limits}} \leq {\mathit{limits}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{globaltype}} \leq {\mathit{globaltype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{tabletype}} \leq {\mathit{tabletype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{memtype}} \leq {\mathit{memtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{externtype}} \leq {\mathit{externtype}}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{n}}_{{11}} \geq {\mathit{n}}_{{21}}
 \qquad
{\mathit{n}}_{{12}} \leq {\mathit{n}}_{{22}}
}{
{\mathit{C}} \vdash [{\mathit{n}}_{{11}} .. {\mathit{n}}_{{12}}] \leq [{\mathit{n}}_{{21}} .. {\mathit{n}}_{{22}}]
} \, {[\textsc{\scriptsize S{-}limits}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{ft}} \leq {\mathit{ft}}
} \, {[\textsc{\scriptsize S{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{t}}_{{1}} \leq {\mathit{t}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{t}}_{{1}} \leq {\mathit{t}}_{{2}}
} \, {[\textsc{\scriptsize S{-}global{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{t}}_{{1}} \leq {\mathit{t}}_{{2}}
 \qquad
{\mathit{C}} \vdash {\mathit{t}}_{{2}} \leq {\mathit{t}}_{{1}}
}{
{\mathit{C}} \vdash \mathsf{mut}~{\mathit{t}}_{{1}} \leq \mathsf{mut}~{\mathit{t}}_{{2}}
} \, {[\textsc{\scriptsize S{-}global{-}var}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{lim}}_{{1}} \leq {\mathit{lim}}_{{2}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{1}} \leq {\mathit{rt}}_{{2}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}_{{1}}
}{
{\mathit{C}} \vdash {\mathit{lim}}_{{1}}~{\mathit{rt}}_{{1}} \leq {\mathit{lim}}_{{2}}~{\mathit{rt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{lim}}_{{1}} \leq {\mathit{lim}}_{{2}}
}{
{\mathit{C}} \vdash {\mathit{lim}}_{{1}}~\mathsf{i{\scriptstyle8}} \leq {\mathit{lim}}_{{2}}~\mathsf{i{\scriptstyle8}}
} \, {[\textsc{\scriptsize S{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{dt}}_{{1}} \leq {\mathit{dt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{dt}}_{{1}} \leq \mathsf{func}~{\mathit{dt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}extern{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{gt}}_{{1}} \leq {\mathit{gt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{global}~{\mathit{gt}}_{{1}} \leq \mathsf{global}~{\mathit{gt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}extern{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{tt}}_{{1}} \leq {\mathit{tt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{table}~{\mathit{tt}}_{{1}} \leq \mathsf{table}~{\mathit{tt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}extern{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{mt}}_{{1}} \leq {\mathit{mt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{mem}~{\mathit{mt}}_{{1}} \leq \mathsf{mem}~{\mathit{mt}}_{{2}}
} \, {[\textsc{\scriptsize S{-}extern{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{instr}} : {\mathit{functype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{instr}} : {\mathit{instrtype}}}$

$\boxed{{\mathit{context}} \vdash {{\mathit{instr}}^\ast} : {\mathit{instrtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{expr}} : {\mathit{resulttype}}}$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : \epsilon \rightarrow (\epsilon)~{{\mathit{t}}^\ast}
}{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}^\ast}
} \, {[\textsc{\scriptsize T{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{instr}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash {\mathit{instr}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow (\epsilon)~{{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}instr}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \epsilon : \epsilon \rightarrow (\epsilon)~\epsilon
} \, {[\textsc{\scriptsize T{-}instr*{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
(({\mathit{C}}.\mathsf{local}[{\mathit{x}}_{{1}}] = {\mathit{init}}~{\mathit{t}}))^\ast
 \qquad
{\mathit{C}'} = {\mathit{C}}[\mathsf{local}[{{\mathit{x}}_{{1}}^\ast}] = {(\mathsf{set}~{\mathit{t}})^\ast}]
 \qquad
{\mathit{C}} \vdash {\mathit{instr}}_{{1}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}_{{1}}^\ast})~{{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}'} \vdash {{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{2}}^\ast} \rightarrow ({{\mathit{x}}_{{2}}^\ast})~{{\mathit{t}}_{{3}}^\ast}
}{
{\mathit{C}} \vdash {\mathit{instr}}_{{1}}~{{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}_{{1}}^\ast}~{{\mathit{x}}_{{2}}^\ast})~{{\mathit{t}}_{{3}}^\ast}
} \, {[\textsc{\scriptsize T{-}instr*{-}seq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {\mathit{it}}
 \qquad
{\mathit{C}} \vdash {\mathit{it}} \leq {\mathit{it}'}
}{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {\mathit{it}'}
} \, {[\textsc{\scriptsize T{-}instr*{-}sub}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}^\ast})~{{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}^\ast}~{{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}^\ast})~({{\mathit{t}}^\ast}~{{\mathit{t}}_{{2}}^\ast})
} \, {[\textsc{\scriptsize T{-}instr*{-}frame}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{unreachable} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}unreachable}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{nop} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}nop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{drop} : {\mathit{t}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}drop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{select}~{\mathit{t}} : {\mathit{t}}~{\mathit{t}}~\mathsf{i{\scriptstyle32}} \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize T{-}select{-}expl}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{t}} \leq {\mathit{t}'}
 \qquad
{\mathit{t}'} = {\mathit{numtype}} \lor {\mathit{t}'} = {\mathit{vectype}}
}{
{\mathit{C}} \vdash \mathsf{select} : {\mathit{t}}~{\mathit{t}}~\mathsf{i{\scriptstyle32}} \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize T{-}select{-}impl}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{blocktype}} : {\mathit{functype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \epsilon : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize K{-}block{-}void}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{t}} : \epsilon \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize K{-}block{-}result}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{func}~{\mathit{ft}}
}{
{\mathit{C}} \vdash {\mathit{x}} : {\mathit{ft}}
} \, {[\textsc{\scriptsize K{-}block{-}typeidx}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{bt}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}}, \mathsf{label}~({{\mathit{t}}_{{2}}^\ast}) \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}^\ast})~{{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}block}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{bt}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}}, \mathsf{label}~({{\mathit{t}}_{{1}}^\ast}) \vdash {{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}^\ast})~{{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}loop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{bt}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}}, \mathsf{label}~({{\mathit{t}}_{{2}}^\ast}) \vdash {{\mathit{instr}}_{{1}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}_{{1}}^\ast})~{{\mathit{t}}_{{2}}^\ast}
 \qquad
{\mathit{C}}, \mathsf{label}~({{\mathit{t}}_{{2}}^\ast}) \vdash {{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{1}}^\ast} \rightarrow ({{\mathit{x}}_{{2}}^\ast})~{{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast} : {{\mathit{t}}_{{1}}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}if}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{br}~{\mathit{l}} : {{\mathit{t}}_{{1}}^\ast}~{{\mathit{t}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}br}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{br\_if}~{\mathit{l}} : {{\mathit{t}}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {{\mathit{t}}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_if}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {{\mathit{t}}^\ast} \leq {\mathit{C}}.\mathsf{label}[{\mathit{l}}])^\ast
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}^\ast} \leq {\mathit{C}}.\mathsf{label}[{\mathit{l}'}]
}{
{\mathit{C}} \vdash \mathsf{br\_table}~{{\mathit{l}}^\ast}~{\mathit{l}'} : {{\mathit{t}}_{{1}}^\ast}~{{\mathit{t}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}
 \qquad
{\mathit{C}} \vdash {\mathit{ht}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{br\_on\_null}~{\mathit{l}} : {{\mathit{t}}^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow {{\mathit{t}}^\ast}~(\mathsf{ref}~{\mathit{ht}})
} \, {[\textsc{\scriptsize T{-}br\_on\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}~(\mathsf{ref}~{\mathit{ht}})
 \qquad
{\mathit{C}} \vdash {\mathit{ht}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{br\_on\_non\_null}~{\mathit{l}} : {{\mathit{t}}^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow {{\mathit{t}}^\ast}
} \, {[\textsc{\scriptsize T{-}br\_on\_non\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{1}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}_{{1}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{br\_on\_cast}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}} : {{\mathit{t}}^\ast}~{\mathit{rt}}_{{1}} \rightarrow {{\mathit{t}}^\ast}~({\mathit{rt}}_{{1}} - {\mathit{rt}}_{{2}})
} \, {[\textsc{\scriptsize T{-}br\_on\_cast}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{label}[{\mathit{l}}] = {{\mathit{t}}^\ast}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{1}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}_{{1}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{1}} - {\mathit{rt}}_{{2}} \leq {\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{br\_on\_cast\_fail}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}} : {{\mathit{t}}^\ast}~{\mathit{rt}}_{{1}} \rightarrow {{\mathit{t}}^\ast}~{\mathit{rt}}_{{2}}
} \, {[\textsc{\scriptsize T{-}br\_on\_cast\_fail}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{return} = ({{\mathit{t}}^\ast})
}{
{\mathit{C}} \vdash \mathsf{return} : {{\mathit{t}}_{{1}}^\ast}~{{\mathit{t}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}return}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{func}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
}{
{\mathit{C}} \vdash \mathsf{call}~{\mathit{x}} : {{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}call}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
}{
{\mathit{C}} \vdash \mathsf{call\_ref}~{\mathit{x}} : {{\mathit{t}}_{{1}}^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{x}}) \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}call\_ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}} \leq (\mathsf{ref}~\mathsf{null}~\mathsf{func})
 \qquad
{\mathit{C}}.\mathsf{type}[{\mathit{y}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
}{
{\mathit{C}} \vdash \mathsf{call\_indirect}~{\mathit{x}}~{\mathit{y}} : {{\mathit{t}}_{{1}}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {{\mathit{t}}_{{2}}^\ast}
} \, {[\textsc{\scriptsize T{-}call\_indirect}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{func}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
 \qquad
{\mathit{C}}.\mathsf{return} = ({{\mathit{t}'}_{{2}}^\ast})
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} \leq {{\mathit{t}'}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{return\_call}~{\mathit{x}} : {{\mathit{t}}_{{3}}^\ast}~{{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{4}}^\ast}
} \, {[\textsc{\scriptsize T{-}return\_call}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
 \qquad
{\mathit{C}}.\mathsf{return} = ({{\mathit{t}'}_{{2}}^\ast})
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} \leq {{\mathit{t}'}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{return\_call\_ref}~{\mathit{x}} : {{\mathit{t}}_{{3}}^\ast}~{{\mathit{t}}_{{1}}^\ast}~(\mathsf{ref}~\mathsf{null}~{\mathit{x}}) \rightarrow {{\mathit{t}}_{{4}}^\ast}
} \, {[\textsc{\scriptsize T{-}return\_call\_ref}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}} \leq (\mathsf{ref}~\mathsf{null}~\mathsf{func})
 \qquad
{\mathit{C}}.\mathsf{type}[{\mathit{y}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
 \qquad
{\mathit{C}}.\mathsf{return} = ({{\mathit{t}'}_{{2}}^\ast})
 \qquad
{\mathit{C}} \vdash {{\mathit{t}}_{{2}}^\ast} \leq {{\mathit{t}'}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{return\_call\_indirect}~{\mathit{x}}~{\mathit{y}} : {{\mathit{t}}_{{3}}^\ast}~{{\mathit{t}}_{{1}}^\ast}~\mathsf{i{\scriptstyle32}} \rightarrow {{\mathit{t}}_{{4}}^\ast}
} \, {[\textsc{\scriptsize T{-}return\_call\_indirect}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{\mathit{nt}}} : \epsilon \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}} . {\mathit{unop}} : {\mathit{nt}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}unop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}} . {\mathit{binop}} : {\mathit{nt}}~{\mathit{nt}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}binop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}} . {\mathit{testop}} : {\mathit{nt}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}testop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {\mathit{nt}} . {\mathit{relop}} : {\mathit{nt}}~{\mathit{nt}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}relop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{n}} \leq {|{\mathit{nt}}|}
}{
{\mathit{C}} \vdash {{\mathit{nt}}.\mathsf{extend}}{{\mathit{n}}} : {\mathit{nt}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}extend}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{nt}}_{{1}} \neq {\mathit{nt}}_{{2}}
 \qquad
{|{\mathit{nt}}_{{1}}|} = {|{\mathit{nt}}_{{2}}|}
}{
{\mathit{C}} \vdash \mathsf{cvtop}~{\mathit{nt}}_{{1}}~\mathsf{reinterpret}~{\mathit{nt}}_{{2}} : {\mathit{nt}}_{{2}} \rightarrow {\mathit{nt}}_{{1}}
} \, {[\textsc{\scriptsize T{-}reinterpret}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathsf{i}}{{\mathit{n}}}}_{{1}} \neq {{\mathsf{i}}{{\mathit{n}}}}_{{2}}
 \qquad
{{\mathit{sx}}^?} = \epsilon \Leftrightarrow {|{{\mathsf{i}}{{\mathit{n}}}}_{{1}}|} > {|{{\mathsf{i}}{{\mathit{n}}}}_{{2}}|}
}{
{\mathit{C}} \vdash {{\mathsf{i}}{{\mathit{n}}}}_{{1}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{{{\mathsf{i}}{{\mathit{n}}}}_{{2}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}} : {{\mathsf{i}}{{\mathit{n}}}}_{{2}} \rightarrow {{\mathsf{i}}{{\mathit{n}}}}_{{1}}
} \, {[\textsc{\scriptsize T{-}convert{-}i}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{{\mathsf{f}}{{\mathit{n}}}}_{{1}} \neq {{\mathsf{f}}{{\mathit{n}}}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{cvtop}~{{\mathsf{f}}{{\mathit{n}}}}_{{1}}~\mathsf{convert}~{{\mathsf{f}}{{\mathit{n}}}}_{{2}} : {{\mathsf{f}}{{\mathit{n}}}}_{{2}} \rightarrow {{\mathsf{f}}{{\mathit{n}}}}_{{1}}
} \, {[\textsc{\scriptsize T{-}convert{-}f}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ht}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{ref.null}~{\mathit{ht}} : \epsilon \rightarrow (\mathsf{ref}~\mathsf{null}~{\mathit{ht}})
} \, {[\textsc{\scriptsize T{-}ref.null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{func}[{\mathit{x}}] = {\mathit{dt}}
}{
{\mathit{C}} \vdash \mathsf{ref.func}~{\mathit{x}} : {\mathit{epsilon}} \rightarrow (\mathsf{ref}~{\mathit{dt}})
} \, {[\textsc{\scriptsize T{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{ref.i{\scriptstyle31}} : \mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~\mathsf{i{\scriptstyle31}})
} \, {[\textsc{\scriptsize T{-}ref.i31}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{ref.is\_null} : {\mathit{rt}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}ref.is\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{ht}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{ref.as\_non\_null} : (\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \rightarrow (\mathsf{ref}~{\mathit{ht}})
} \, {[\textsc{\scriptsize T{-}ref.as\_non\_null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{ref.eq} : (\mathsf{ref}~\mathsf{null}~\mathsf{eq})~(\mathsf{ref}~\mathsf{null}~\mathsf{eq}) \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}ref.eq}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{rt}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}'} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}} \leq {\mathit{rt}'}
}{
{\mathit{C}} \vdash \mathsf{ref.test}~{\mathit{rt}} : {\mathit{rt}'} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}ref.test}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{rt}} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}'} : \mathsf{ok}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}} \leq {\mathit{rt}'}
}{
{\mathit{C}} \vdash \mathsf{ref.cast}~{\mathit{rt}} : {\mathit{rt}'} \rightarrow {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}ref.cast}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash {{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}} : (\mathsf{ref}~\mathsf{null}~\mathsf{i{\scriptstyle31}}) \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}i31.get}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast}
}{
{\mathit{C}} \vdash \mathsf{struct.new}~{\mathit{x}} : {{\mathrm{unpack}}({\mathit{zt}})^\ast} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}struct.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast}
 \qquad
(({\mathrm{default}}~{\mathrm{unpack}}({\mathit{zt}}) = {\mathit{val}}))^\ast
}{
{\mathit{C}} \vdash \mathsf{struct.new\_default}~{\mathit{x}} : {{\mathrm{unpack}}({\mathit{zt}})^\ast} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}struct.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{struct}~{{\mathit{yt}}^\ast}
 \qquad
{{\mathit{yt}}^\ast}[{\mathit{i}}] = {\mathit{mut}}~{\mathit{zt}}
 \qquad
{{\mathit{sx}}^?} = \epsilon \Leftrightarrow {\mathit{zt}} = {\mathrm{unpack}}({\mathit{zt}})
}{
{\mathit{C}} \vdash {{\mathsf{struct.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}~{\mathit{i}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}}) \rightarrow {\mathrm{unpack}}({\mathit{zt}})
} \, {[\textsc{\scriptsize T{-}struct.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{struct}~{{\mathit{yt}}^\ast}
 \qquad
{{\mathit{yt}}^\ast}[{\mathit{i}}] = \mathsf{mut}~{\mathit{zt}}
}{
{\mathit{C}} \vdash \mathsf{struct.set}~{\mathit{x}}~{\mathit{i}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~{\mathrm{unpack}}({\mathit{zt}}) \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}struct.set}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.new}~{\mathit{x}} : {\mathrm{unpack}}({\mathit{zt}})~\mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
 \qquad
{\mathrm{default}}~{\mathrm{unpack}}({\mathit{zt}}) = {\mathit{val}}
}{
{\mathit{C}} \vdash \mathsf{array.new\_default}~{\mathit{x}} : \mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_default}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}} : {\mathrm{unpack}}({\mathit{zt}}) \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_fixed}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{rt}})
 \qquad
{\mathit{C}} \vdash {\mathit{C}}.\mathsf{elem}[{\mathit{y}}] \leq {\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{array.new\_elem}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{t}})
 \qquad
{\mathit{t}} = {\mathit{numtype}} \lor {\mathit{t}} = {\mathit{vectype}}
 \qquad
{\mathit{C}}.\mathsf{data}[{\mathit{y}}] = \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{array.new\_data}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow (\mathsf{ref}~{\mathit{x}})
} \, {[\textsc{\scriptsize T{-}array.new\_data}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}})
 \qquad
{{\mathit{sx}}^?} = \epsilon \Leftrightarrow {\mathit{zt}} = {\mathrm{unpack}}({\mathit{zt}})
}{
{\mathit{C}} \vdash {{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}} \rightarrow {\mathrm{unpack}}({\mathit{zt}})
} \, {[\textsc{\scriptsize T{-}array.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.set}~{\mathit{x}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}}~{\mathrm{unpack}}({\mathit{zt}}) \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.len} : (\mathsf{ref}~\mathsf{null}~\mathsf{array}) \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}array.len}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
}{
{\mathit{C}} \vdash \mathsf{array.fill}~{\mathit{x}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}}~{\mathrm{unpack}}({\mathit{zt}})~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}_{{1}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}}_{{1}})
 \qquad
{\mathit{C}}.\mathsf{type}[{\mathit{x}}_{{2}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}_{{2}})
 \qquad
{\mathit{C}} \vdash {\mathit{zt}}_{{2}} \leq {\mathit{zt}}_{{1}}
}{
{\mathit{C}} \vdash \mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}}_{{1}})~\mathsf{i{\scriptstyle32}}~(\mathsf{ref}~\mathsf{null}~{\mathit{x}}_{{2}})~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
 \qquad
{\mathit{C}} \vdash {\mathit{C}}.\mathsf{elem}[{\mathit{y}}] \leq {\mathit{zt}}
}{
{\mathit{C}} \vdash \mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.init\_elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{array}~(\mathsf{mut}~{\mathit{zt}})
 \qquad
{\mathit{t}} = {\mathit{numtype}} \lor {\mathit{t}} = {\mathit{vectype}}
 \qquad
{\mathit{C}}.\mathsf{data}[{\mathit{y}}] = \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}} : (\mathsf{ref}~\mathsf{null}~{\mathit{x}})~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}array.init\_data}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{extern.convert\_any} : (\mathsf{ref}~{\mathit{nul}}~\mathsf{any}) \rightarrow (\mathsf{ref}~{\mathit{nul}}~\mathsf{extern})
} \, {[\textsc{\scriptsize T{-}extern.convert\_any}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{any.convert\_extern} : (\mathsf{ref}~{\mathit{nul}}~\mathsf{extern}) \rightarrow (\mathsf{ref}~{\mathit{nul}}~\mathsf{any})
} \, {[\textsc{\scriptsize T{-}any.convert\_extern}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{local}[{\mathit{x}}] = {\mathit{init}}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{local.get}~{\mathit{x}} : \epsilon \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize T{-}local.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{local}[{\mathit{x}}] = {\mathit{init}}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{local.set}~{\mathit{x}} : {\mathit{t}} \rightarrow ({\mathit{x}})~\epsilon
} \, {[\textsc{\scriptsize T{-}local.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{local}[{\mathit{x}}] = {\mathit{init}}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{local.tee}~{\mathit{x}} : {\mathit{t}} \rightarrow ({\mathit{x}})~{\mathit{t}}
} \, {[\textsc{\scriptsize T{-}local.tee}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{global}[{\mathit{x}}] = {\mathit{mut}}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{global.get}~{\mathit{x}} : \epsilon \rightarrow {\mathit{t}}
} \, {[\textsc{\scriptsize T{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{global}[{\mathit{x}}] = \mathsf{mut}~{\mathit{t}}
}{
{\mathit{C}} \vdash \mathsf{global.set}~{\mathit{x}} : {\mathit{t}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}global.set}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.get}~{\mathit{x}} : \mathsf{i{\scriptstyle32}} \rightarrow {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}table.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.set}~{\mathit{x}} : \mathsf{i{\scriptstyle32}}~{\mathit{rt}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{tt}}
}{
{\mathit{C}} \vdash \mathsf{table.size}~{\mathit{x}} : \epsilon \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}table.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.grow}~{\mathit{x}} : {\mathit{rt}}~\mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}table.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{table.fill}~{\mathit{x}} : \mathsf{i{\scriptstyle32}}~{\mathit{rt}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}_{{1}}] = {\mathit{lim}}_{{1}}~{\mathit{rt}}_{{1}}
 \qquad
{\mathit{C}}.\mathsf{table}[{\mathit{x}}_{{2}}] = {\mathit{lim}}_{{2}}~{\mathit{rt}}_{{2}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}_{{1}}
}{
{\mathit{C}} \vdash \mathsf{table.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}_{{1}}
 \qquad
{\mathit{C}}.\mathsf{elem}[{\mathit{y}}] = {\mathit{rt}}_{{2}}
 \qquad
{\mathit{C}} \vdash {\mathit{rt}}_{{2}} \leq {\mathit{rt}}_{{1}}
}{
{\mathit{C}} \vdash \mathsf{table.init}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}table.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{elem}[{\mathit{x}}] = {\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{elem.drop}~{\mathit{x}} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}elem.drop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
}{
{\mathit{C}} \vdash \mathsf{memory.size}~{\mathit{x}} : \epsilon \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.size}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
}{
{\mathit{C}} \vdash \mathsf{memory.grow}~{\mathit{x}} : \mathsf{i{\scriptstyle32}} \rightarrow \mathsf{i{\scriptstyle32}}
} \, {[\textsc{\scriptsize T{-}memory.grow}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
}{
{\mathit{C}} \vdash \mathsf{memory.fill}~{\mathit{x}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}memory.fill}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}_{{1}}] = {\mathit{mt}}_{{1}}
 \qquad
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}_{{2}}] = {\mathit{mt}}_{{2}}
}{
{\mathit{C}} \vdash \mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}memory.copy}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{\mathit{C}}.\mathsf{data}[{\mathit{y}}] = \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{memory.init}~{\mathit{x}}~{\mathit{y}} : \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle32}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}memory.init}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{data}[{\mathit{x}}] = \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{data.drop}~{\mathit{x}} : \epsilon \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}data.drop}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{n}}_{{\mathsf{a}}}}} \leq {|{\mathit{nt}}|} / 8
 \qquad
({2^{{\mathit{n}}_{{\mathsf{a}}}}} \leq {\mathit{n}} / 8 < {|{\mathit{nt}}|} / 8)^?
 \qquad
{{\mathit{n}}^?} = \epsilon \lor {\mathit{nt}} = {\mathsf{i}}{{\mathit{n}}}
}{
{\mathit{C}} \vdash {{\mathit{nt}}.\mathsf{load}}{{({\mathit{n}}~\mathsf{\_}~{\mathit{sx}})^?}}~{\mathit{x}}~\{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}}_{{\mathsf{a}}},\; \mathsf{offset}~{\mathit{n}}_{{\mathsf{o}}} \}\end{array} : \mathsf{i{\scriptstyle32}} \rightarrow {\mathit{nt}}
} \, {[\textsc{\scriptsize T{-}load}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
{2^{{\mathit{n}}_{{\mathsf{a}}}}} \leq {|{\mathit{nt}}|} / 8
 \qquad
({2^{{\mathit{n}}_{{\mathsf{a}}}}} \leq {\mathit{n}} / 8 < {|{\mathit{nt}}|} / 8)^?
 \qquad
{{\mathit{n}}^?} = \epsilon \lor {\mathit{nt}} = {\mathsf{i}}{{\mathit{n}}}
}{
{\mathit{C}} \vdash {{\mathit{nt}}.\mathsf{store}}{{{\mathit{n}}^?}}~{\mathit{x}}~\{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}}_{{\mathsf{a}}},\; \mathsf{offset}~{\mathit{n}}_{{\mathsf{o}}} \}\end{array} : \mathsf{i{\scriptstyle32}}~{\mathit{nt}} \rightarrow \epsilon
} \, {[\textsc{\scriptsize T{-}store}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{instr}}~\mathsf{const}}$

$\boxed{{\mathit{context}} \vdash {\mathit{expr}}~\mathsf{const}}$

$\boxed{{\mathit{context}} \vdash {\mathit{expr}} : {\mathit{valtype}}~\mathsf{const}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash ({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}const}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash (\mathsf{ref.func}~{\mathit{x}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}ref.func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{global}[{\mathit{x}}] = {\mathit{t}}
}{
{\mathit{C}} \vdash (\mathsf{global.get}~{\mathit{x}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}global.get}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{nt}} \in {\mathit{epsilon}} &=& \mathsf{false} &  \\
{\mathit{nt}} \in {\mathit{nt}}_{{1}}~{{\mathit{nt}'}^\ast} &=& {\mathit{nt}} = {\mathit{nt}}_{{1}} \lor {\mathit{nt}} \in {{\mathit{nt}'}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathit{binop}} \in {\mathit{epsilon}} &=& \mathsf{false} &  \\
{\mathit{binop}} \in {\mathit{ibinop}}_{{1}}~{{\mathit{ibinop}'}^\ast} &=& {\mathit{binop}} = {\mathit{ibinop}}_{{1}} \lor {\mathit{binop}} \in {{\mathit{ibinop}'}^\ast} &  \\
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{nt}} \in \mathsf{i{\scriptstyle32}}~\mathsf{i{\scriptstyle64}}
 \qquad
{\mathit{binop}} \in \mathsf{add}~\mathsf{sub}~\mathsf{mul}
}{
{\mathit{C}} \vdash ({\mathit{nt}} . {\mathit{binop}})~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}instr{-}binop}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{instr}}~\mathsf{const})^\ast
}{
{\mathit{C}} \vdash {{\mathit{instr}}^\ast}~\mathsf{const}
} \, {[\textsc{\scriptsize C{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{expr}} : {\mathit{t}}
 \qquad
{\mathit{C}} \vdash {\mathit{expr}}~\mathsf{const}
}{
{\mathit{C}} \vdash {\mathit{expr}} : {\mathit{t}}~\mathsf{const}
} \, {[\textsc{\scriptsize TC{-}expr}]}
\qquad
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{type}} : {{\mathit{deftype}}^\ast}}$

$\boxed{{\mathit{context}} \vdash {\mathit{func}} : {\mathit{deftype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{local}} : {\mathit{localtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{global}} : {\mathit{globaltype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{table}} : {\mathit{tabletype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{mem}} : {\mathit{memtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{elem}} : {\mathit{reftype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{data}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{elemmode}} : {\mathit{reftype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{datamode}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {\mathit{start}} : \mathsf{ok}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{x}} = {|{\mathit{C}}.\mathsf{type}|}
 \qquad
{{\mathit{dt}}^\ast} = {{\mathrm{roll}}}_{{\mathit{x}}}({\mathit{rectype}})
 \qquad
{\mathit{C}}[\mathsf{type} = ..{{\mathit{dt}}^\ast}] \vdash {\mathit{rectype}} : {\mathsf{ok}}{({\mathit{x}})}
}{
{\mathit{C}} \vdash \mathsf{type}~{\mathit{rectype}} : {{\mathit{dt}}^\ast}
} \, {[\textsc{\scriptsize T{-}type}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathrm{default}}~{\mathit{t}} \neq \epsilon
}{
{\mathit{C}} \vdash \mathsf{local}~{\mathit{t}} : \mathsf{set}~{\mathit{t}}
} \, {[\textsc{\scriptsize T{-}local{-}set}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathrm{default}}~{\mathit{t}} = \epsilon
}{
{\mathit{C}} \vdash \mathsf{local}~{\mathit{t}} : \mathsf{unset}~{\mathit{t}}
} \, {[\textsc{\scriptsize T{-}local{-}unset}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{type}[{\mathit{x}}] \approx \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast})
 \qquad
({\mathit{C}} \vdash {\mathit{local}} : {\mathit{lt}})^\ast
 \qquad
{\mathit{C}}, \mathsf{local}~{(\mathsf{set}~{\mathit{t}}_{{1}})^\ast}~{{\mathit{lt}}^\ast}, \mathsf{label}~({{\mathit{t}}_{{2}}^\ast}), \mathsf{return}~({{\mathit{t}}_{{2}}^\ast}) \vdash {\mathit{expr}} : {{\mathit{t}}_{{2}}^\ast}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{x}}~{{\mathit{local}}^\ast}~{\mathit{expr}} : {\mathit{C}}.\mathsf{type}[{\mathit{x}}]
} \, {[\textsc{\scriptsize T{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{gt}} : \mathsf{ok}
 \qquad
{\mathit{gt}} = {\mathit{mut}}~{\mathit{t}}
 \qquad
{\mathit{C}} \vdash {\mathit{expr}} : {\mathit{t}}~\mathsf{const}
}{
{\mathit{C}} \vdash \mathsf{global}~{\mathit{gt}}~{\mathit{expr}} : {\mathit{gt}}
} \, {[\textsc{\scriptsize T{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{tt}} : \mathsf{ok}
 \qquad
{\mathit{tt}} = {\mathit{limits}}~{\mathit{rt}}
 \qquad
{\mathit{C}} \vdash {\mathit{expr}} : {\mathit{rt}}~\mathsf{const}
}{
{\mathit{C}} \vdash \mathsf{table}~{\mathit{tt}}~{\mathit{expr}} : {\mathit{tt}}
} \, {[\textsc{\scriptsize T{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{mt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{memory}~{\mathit{mt}} : {\mathit{mt}}
} \, {[\textsc{\scriptsize T{-}mem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
({\mathit{C}} \vdash {\mathit{expr}} : {\mathit{rt}}~\mathsf{const})^\ast
 \qquad
{\mathit{C}} \vdash {\mathit{elemmode}} : {\mathit{rt}}
}{
{\mathit{C}} \vdash \mathsf{elem}~{\mathit{rt}}~{{\mathit{expr}}^\ast}~{\mathit{elemmode}} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elem}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{datamode}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{data}~{{\mathit{b}}^\ast}~{\mathit{datamode}} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}data}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{lim}}~{\mathit{rt}}
 \qquad
({\mathit{C}} \vdash {\mathit{expr}} : \mathsf{i{\scriptstyle32}}~\mathsf{const})^\ast
}{
{\mathit{C}} \vdash \mathsf{active}~{\mathit{x}}~{\mathit{expr}} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elemmode{-}active}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{passive} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elemmode{-}passive}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{declare} : {\mathit{rt}}
} \, {[\textsc{\scriptsize T{-}elemmode{-}declare}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
 \qquad
({\mathit{C}} \vdash {\mathit{expr}} : \mathsf{i{\scriptstyle32}}~\mathsf{const})^\ast
}{
{\mathit{C}} \vdash \mathsf{active}~{\mathit{x}}~{\mathit{expr}} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}datamode{-}active}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \mathsf{passive} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}datamode{-}passive}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{func}[{\mathit{x}}] \approx \mathsf{func}~(\epsilon \rightarrow \epsilon)
}{
{\mathit{C}} \vdash \mathsf{start}~{\mathit{x}} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}start}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{context}} \vdash {\mathit{import}} : {\mathit{externtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{export}} : {\mathit{externtype}}}$

$\boxed{{\mathit{context}} \vdash {\mathit{externidx}} : {\mathit{externtype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{xt}} : \mathsf{ok}
}{
{\mathit{C}} \vdash \mathsf{import}~{\mathit{name}}_{{1}}~{\mathit{name}}_{{2}}~{\mathit{xt}} : {\mathit{xt}}
} \, {[\textsc{\scriptsize T{-}import}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{externidx}} : {\mathit{xt}}
}{
{\mathit{C}} \vdash \mathsf{export}~{\mathit{name}}~{\mathit{externidx}} : {\mathit{xt}}
} \, {[\textsc{\scriptsize T{-}export}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{func}[{\mathit{x}}] = {\mathit{dt}}
}{
{\mathit{C}} \vdash \mathsf{func}~{\mathit{x}} : \mathsf{func}~{\mathit{dt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{global}[{\mathit{x}}] = {\mathit{gt}}
}{
{\mathit{C}} \vdash \mathsf{global}~{\mathit{x}} : \mathsf{global}~{\mathit{gt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}global}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{table}[{\mathit{x}}] = {\mathit{tt}}
}{
{\mathit{C}} \vdash \mathsf{table}~{\mathit{x}} : \mathsf{table}~{\mathit{tt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}table}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}}.\mathsf{mem}[{\mathit{x}}] = {\mathit{mt}}
}{
{\mathit{C}} \vdash \mathsf{mem}~{\mathit{x}} : \mathsf{mem}~{\mathit{mt}}
} \, {[\textsc{\scriptsize T{-}externidx{-}mem}]}
\qquad
\end{array}
$$

\vspace{1ex}

$\boxed{{ \vdash }\;{\mathit{module}} : \mathsf{ok}}$

$\boxed{{\mathit{context}} \vdash {{\mathit{type}}^\ast} : {{\mathit{deftype}}^\ast}}$

$\boxed{{\mathit{context}} \vdash {{\mathit{global}}^\ast} : {{\mathit{globaltype}}^\ast}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
\begin{array}{@{}c@{}}
\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {{\mathit{type}}^\ast} : {{\mathit{dt}'}^\ast}
 \qquad
(\{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{{\mathit{dt}'}^\ast} \}\end{array} \vdash {\mathit{import}} : {\mathit{ixt}})^\ast
 \\
{\mathit{C}'} \vdash {{\mathit{global}}^\ast} : {{\mathit{gt}}^\ast}
 \qquad
({\mathit{C}'} \vdash {\mathit{table}} : {\mathit{tt}})^\ast
 \qquad
({\mathit{C}'} \vdash {\mathit{mem}} : {\mathit{mt}})^\ast
 \qquad
({\mathit{C}} \vdash {\mathit{func}} : {\mathit{dt}})^\ast
 \\
({\mathit{C}} \vdash {\mathit{elem}} : {\mathit{rt}})^\ast
 \qquad
({\mathit{C}} \vdash {\mathit{data}} : \mathsf{ok})^{{\mathit{n}}}
 \qquad
({\mathit{C}} \vdash {\mathit{start}} : \mathsf{ok})^?
 \qquad
({\mathit{C}} \vdash {\mathit{export}} : {\mathit{et}})^\ast
 \\
{\mathit{C}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{{\mathit{dt}'}^\ast},\; \mathsf{func}~{{\mathit{idt}}^\ast}~{{\mathit{dt}}^\ast},\; \mathsf{global}~{{\mathit{igt}}^\ast}~{{\mathit{gt}}^\ast},\; \mathsf{table}~{{\mathit{itt}}^\ast}~{{\mathit{tt}}^\ast},\; \mathsf{mem}~{{\mathit{imt}}^\ast}~{{\mathit{mt}}^\ast},\; \mathsf{elem}~{{\mathit{rt}}^\ast},\; \mathsf{data}~{\mathsf{ok}^{{\mathit{n}}}} \}\end{array}
 \\
{\mathit{C}'} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{{\mathit{dt}'}^\ast},\; \mathsf{func}~{{\mathit{idt}}^\ast}~{{\mathit{dt}}^\ast},\; \mathsf{global}~{{\mathit{igt}}^\ast} \}\end{array}
 \\
{{\mathit{idt}}^\ast} = {\mathrm{funcs}}({{\mathit{ixt}}^\ast})
 \qquad
{{\mathit{igt}}^\ast} = {\mathrm{globals}}({{\mathit{ixt}}^\ast})
 \qquad
{{\mathit{itt}}^\ast} = {\mathrm{tables}}({{\mathit{ixt}}^\ast})
 \qquad
{{\mathit{imt}}^\ast} = {\mathrm{mems}}({{\mathit{ixt}}^\ast})
\end{array}
}{
{ \vdash }\;\mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^{{\mathit{n}}}}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} : \mathsf{ok}
} \, {[\textsc{\scriptsize T{-}module}]}
\qquad
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \epsilon : \epsilon
} \, {[\textsc{\scriptsize T{-}types{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{type}}_{{1}} : {\mathit{dt}}_{{1}}
 \qquad
{\mathit{C}}[\mathsf{type} = ..{{\mathit{dt}}_{{1}}^\ast}] \vdash {{\mathit{type}}^\ast} : {{\mathit{dt}}^\ast}
}{
{\mathit{C}} \vdash {\mathit{type}}_{{1}}~{{\mathit{type}}^\ast} : {{\mathit{dt}}_{{1}}^\ast}~{{\mathit{dt}}^\ast}
} \, {[\textsc{\scriptsize T{-}types{-}cons}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{C}} \vdash \epsilon : \epsilon
} \, {[\textsc{\scriptsize T{-}globals{-}empty}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{C}} \vdash {\mathit{global}} : {\mathit{gt}}_{{1}}
 \qquad
{\mathit{C}}[\mathsf{global} = ..{\mathit{gt}}_{{1}}] \vdash {{\mathit{global}}^\ast} : {{\mathit{gt}}^\ast}
}{
{\mathit{C}} \vdash {\mathit{global}}_{{1}}~{{\mathit{global}}^\ast} : {\mathit{gt}}_{{1}}~{{\mathit{gt}}^\ast}
} \, {[\textsc{\scriptsize T{-}globals{-}cons}]}
\qquad
\end{array}
$$

$\boxed{{\mathit{store}} \vdash {\mathit{ref}} : {\mathit{reftype}}}$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{s}} \vdash \mathsf{ref.null}~{\mathit{ht}} : (\mathsf{ref}~\mathsf{null}~{\mathit{ht}})
} \, {[\textsc{\scriptsize Ref\_ok{-}null}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{s}} \vdash \mathsf{ref.i{\scriptstyle31}}~{\mathit{i}} : (\mathsf{ref}~\epsilon~\mathsf{i{\scriptstyle31}})
} \, {[\textsc{\scriptsize Ref\_ok{-}i31}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{s}}.\mathsf{struct}[{\mathit{a}}].\mathsf{type} = {\mathit{dt}}
}{
{\mathit{s}} \vdash \mathsf{ref.struct}~{\mathit{a}} : (\mathsf{ref}~\epsilon~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_ok{-}struct}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{s}}.\mathsf{array}[{\mathit{a}}].\mathsf{type} = {\mathit{dt}}
}{
{\mathit{s}} \vdash \mathsf{ref.array}~{\mathit{a}} : (\mathsf{ref}~\epsilon~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_ok{-}array}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
{\mathit{s}}.\mathsf{func}[{\mathit{a}}].\mathsf{type} = {\mathit{dt}}
}{
{\mathit{s}} \vdash \mathsf{ref.func}~{\mathit{a}} : (\mathsf{ref}~\epsilon~{\mathit{dt}})
} \, {[\textsc{\scriptsize Ref\_ok{-}func}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{s}} \vdash \mathsf{ref.host}~{\mathit{a}} : (\mathsf{ref}~\epsilon~\mathsf{any})
} \, {[\textsc{\scriptsize Ref\_ok{-}host}]}
\qquad
\end{array}
$$

$$
\begin{array}{@{}c@{}}\displaystyle
\frac{
}{
{\mathit{s}} \vdash \mathsf{ref.extern}~{\mathit{addrref}} : (\mathsf{ref}~\epsilon~\mathsf{extern})
} \, {[\textsc{\scriptsize Ref\_ok{-}extern}]}
\qquad
\end{array}
$$

$\boxed{{\mathit{config}} \hookrightarrow {\mathit{config}}}$

$\boxed{{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}}^\ast}}$

$\boxed{{\mathit{config}} \hookrightarrow {{\mathit{instr}}^\ast}}$

$\boxed{{\mathit{config}} \hookrightarrow^\ast {\mathit{config}}}$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}pure}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow& {\mathit{z}} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~{{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
{[\textsc{\scriptsize E{-}read}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow& {\mathit{z}} ; {{\mathit{instr}'}^\ast} &\quad
  \mbox{if}~{\mathit{z}} ; {{\mathit{instr}}^\ast} \hookrightarrow {{\mathit{instr}'}^\ast} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}refl}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& {\mathit{z}} ; {{\mathit{instr}}^\ast} &  \\
{[\textsc{\scriptsize E{-}trans}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& {\mathit{z}''} ; {{{\mathit{instr}}''}^\ast} &\quad
  \mbox{if}~{\mathit{z}} ; {{\mathit{instr}}^\ast} \hookrightarrow {\mathit{z}'} ; {{{\mathit{instr}}'}^\ast} \\
 &&&&\quad {\land}~{\mathit{z}'} ; {{\mathit{instr}}'} \hookrightarrow^\ast {\mathit{z}''} ; {{{\mathit{instr}}''}^\ast} \\
\end{array}
$$

\vspace{1ex}

$\boxed{{\mathit{state}} ; {\mathit{expr}} \hookrightarrow^\ast {\mathit{state}} ; {{\mathit{val}}^\ast}}$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}expr}]} \quad & {\mathit{z}} ; {{\mathit{instr}}^\ast} &\hookrightarrow^\ast& {\mathit{z}'} ; {{\mathit{val}}^\ast} &\quad
  \mbox{if}~{\mathit{z}} ; {{\mathit{instr}}^\ast} \hookrightarrow^\ast {\mathit{z}'} ; {{\mathit{val}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}unreachable}]} \quad & \mathsf{unreachable} &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}nop}]} \quad & \mathsf{nop} &\hookrightarrow& \epsilon &  \\
{[\textsc{\scriptsize E{-}drop}]} \quad & {\mathit{val}}~\mathsf{drop} &\hookrightarrow& \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}select{-}true}]} \quad & {\mathit{val}}_{{1}}~{\mathit{val}}_{{2}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{select}~{{{\mathit{t}}^\ast}^?}) &\hookrightarrow& {\mathit{val}}_{{1}} &\quad
  \mbox{if}~{\mathit{c}} \neq 0 \\
{[\textsc{\scriptsize E{-}select{-}false}]} \quad & {\mathit{val}}_{{1}}~{\mathit{val}}_{{2}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{select}~{{{\mathit{t}}^\ast}^?}) &\hookrightarrow& {\mathit{val}}_{{2}} &\quad
  \mbox{if}~{\mathit{c}} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{{\mathrm{blocktype}}}_{{\mathit{z}}}(\epsilon) &=& \epsilon \rightarrow \epsilon &  \\
{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{t}}) &=& \epsilon \rightarrow {\mathit{t}} &  \\
{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{x}}) &=& {\mathit{ft}} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{func}~{\mathit{ft}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}block}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{k}}}}~(\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{{\mathit{n}}}}{\{\epsilon\}}~({{\mathit{val}}^{{\mathit{k}}}}, {{\mathit{instr}}^\ast})) &\quad
  \mbox{if}~{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{bt}}) = {{\mathit{t}}_{{1}}^{{\mathit{k}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{n}}}} \\
{[\textsc{\scriptsize E{-}loop}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{k}}}}~(\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}) &\hookrightarrow& ({{\mathsf{label}}_{{\mathit{k}}}}{\{\mathsf{loop}~{\mathit{bt}}~{{\mathit{instr}}^\ast}\}}~({{\mathit{val}}^{{\mathit{k}}}}, {{\mathit{instr}}^\ast})) &\quad
  \mbox{if}~{{\mathrm{blocktype}}}_{{\mathit{z}}}({\mathit{bt}}) = {{\mathit{t}}_{{1}}^{{\mathit{k}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{n}}}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}) &\quad
  \mbox{if}~{\mathit{c}} \neq 0 \\
{[\textsc{\scriptsize E{-}if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{if}~{\mathit{bt}}~{{\mathit{instr}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{instr}}_{{2}}^\ast}) &\hookrightarrow& (\mathsf{block}~{\mathit{bt}}~{{\mathit{instr}}_{{2}}^\ast}) &\quad
  \mbox{if}~{\mathit{c}} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}label{-}vals}]} \quad & ({{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}}^\ast}\}}~{{\mathit{val}}^\ast}) &\hookrightarrow& {{\mathit{val}}^\ast} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br{-}zero}]} \quad & ({{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}'}^\ast}\}}~({{\mathit{val}'}^\ast}, {{\mathit{val}}^{{\mathit{n}}}}, (\mathsf{br}~0), {{\mathit{instr}}^\ast})) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~{{\mathit{instr}'}^\ast} &  \\
{[\textsc{\scriptsize E{-}br{-}succ}]} \quad & ({{\mathsf{label}}_{{\mathit{n}}}}{\{{{\mathit{instr}'}^\ast}\}}~({{\mathit{val}}^\ast}, (\mathsf{br}~{\mathit{l}} + 1), {{\mathit{instr}}^\ast})) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{br}~{\mathit{l}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_if{-}true}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{br\_if}~{\mathit{l}}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{if}~{\mathit{c}} \neq 0 \\
{[\textsc{\scriptsize E{-}br\_if{-}false}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}})~(\mathsf{br\_if}~{\mathit{l}}) &\hookrightarrow& \epsilon &\quad
  \mbox{if}~{\mathit{c}} = 0 \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_table{-}lt}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{br\_table}~{{\mathit{l}}^\ast}~{\mathit{l}'}) &\hookrightarrow& (\mathsf{br}~{{\mathit{l}}^\ast}[{\mathit{i}}]) &\quad
  \mbox{if}~{\mathit{i}} < {|{{\mathit{l}}^\ast}|} \\
{[\textsc{\scriptsize E{-}br\_table{-}ge}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{br\_table}~{{\mathit{l}}^\ast}~{\mathit{l}'}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}'}) &\quad
  \mbox{if}~{\mathit{i}} \geq {|{{\mathit{l}}^\ast}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_null{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_null}~{\mathit{l}}) &\hookrightarrow& (\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{if}~{\mathit{val}} = \mathsf{ref.null}~{\mathit{ht}} \\
{[\textsc{\scriptsize E{-}br\_on\_null{-}addr}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_null}~{\mathit{l}}) &\hookrightarrow& {\mathit{val}} &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_non\_null{-}null}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_non\_null}~{\mathit{l}}) &\hookrightarrow& \epsilon &\quad
  \mbox{if}~{\mathit{val}} = \mathsf{ref.null}~{\mathit{ht}} \\
{[\textsc{\scriptsize E{-}br\_on\_non\_null{-}addr}]} \quad & {\mathit{val}}~(\mathsf{br\_on\_non\_null}~{\mathit{l}}) &\hookrightarrow& {\mathit{val}}~(\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_cast{-}succeed}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}}~(\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{store} \vdash {\mathit{ref}} : {\mathit{rt}} \\
 &&&&\quad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}} \leq {{\mathrm{inst}}}_{{\mathit{z}}.\mathsf{module}}({\mathit{rt}}_{{2}}) \\
{[\textsc{\scriptsize E{-}br\_on\_cast{-}fail}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}} &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}br\_on\_cast\_fail{-}succeed}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast\_fail}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{store} \vdash {\mathit{ref}} : {\mathit{rt}} \\
 &&&&\quad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}} \leq {{\mathrm{inst}}}_{{\mathit{z}}.\mathsf{module}}({\mathit{rt}}_{{2}}) \\
{[\textsc{\scriptsize E{-}br\_on\_cast\_fail{-}fail}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{br\_on\_cast\_fail}~{\mathit{l}}~{\mathit{rt}}_{{1}}~{\mathit{rt}}_{{2}}) &\hookrightarrow& {\mathit{ref}}~(\mathsf{br}~{\mathit{l}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}call}]} \quad & {\mathit{z}} ; (\mathsf{call}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.func}~{\mathit{z}}.\mathsf{module}.\mathsf{func}[{\mathit{x}}])~(\mathsf{call\_ref}) &  \\
{[\textsc{\scriptsize E{-}call\_ref{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{call\_ref}~{{\mathit{x}}^?}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}call\_ref{-}func}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{ref.func}~{\mathit{a}})~(\mathsf{call\_ref}~{{\mathit{x}}^?}) &\hookrightarrow& ({{\mathsf{frame}}_{{\mathit{m}}}}{\{{\mathit{f}}\}}~({{\mathsf{label}}_{{\mathit{m}}}}{\{\epsilon\}}~{{\mathit{instr}}^\ast})) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{func}[{\mathit{a}}] = {\mathit{fi}} \\
 &&&&\quad {\land}~{\mathit{fi}}.\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{m}}}}) \\
 &&&&\quad {\land}~{\mathit{fi}}.\mathsf{code} = \mathsf{func}~{\mathit{y}}~{(\mathsf{local}~{\mathit{t}})^\ast}~({{\mathit{instr}}^\ast}) \\
 &&&&\quad {\land}~{\mathit{f}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{local}~{{\mathit{val}}^{{\mathit{n}}}}~{({\mathrm{default}}~{\mathit{t}})^\ast},\; \mathsf{module}~{\mathit{fi}}.\mathsf{module} \}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}return\_call}]} \quad & {\mathit{z}} ; (\mathsf{return\_call}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.func}~{\mathit{z}}.\mathsf{module}.\mathsf{func}[{\mathit{x}}])~(\mathsf{return\_call\_ref}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}return\_call\_ref{-}frame{-}null}]} \quad & {\mathit{z}} ; ({{\mathsf{frame}}_{{\mathit{k}}}}{\{{\mathit{f}}\}}~({{\mathit{val}}^\ast}, (\mathsf{ref.null}~{\mathit{ht}}), (\mathsf{return\_call\_ref}~{{\mathit{x}}^?}), {{\mathit{instr}}^\ast})) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}frame{-}addr}]} \quad & {\mathit{z}} ; ({{\mathsf{frame}}_{{\mathit{k}}}}{\{{\mathit{f}}\}}~({{\mathit{val}'}^\ast}, {{\mathit{val}}^{{\mathit{n}}}}, (\mathsf{ref.func}~{\mathit{a}}), (\mathsf{return\_call\_ref}~{{\mathit{x}}^?}), {{\mathit{instr}}^\ast})) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{ref.func}~{\mathit{a}})~(\mathsf{call\_ref}~{{\mathit{x}}^?}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{func}[{\mathit{a}}].\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^{{\mathit{m}}}}) \\
{[\textsc{\scriptsize E{-}return\_call\_ref{-}label}]} \quad & {\mathit{z}} ; ({{\mathsf{label}}_{{\mathit{k}}}}{\{{{\mathit{instr}'}^\ast}\}}~({{\mathit{val}}^\ast}, (\mathsf{return\_call\_ref}~{{\mathit{x}}^?}), {{\mathit{instr}}^\ast})) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{return\_call\_ref}~{{\mathit{x}}^?}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}call\_indirect{-}call}]} \quad & (\mathsf{call\_indirect}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{table.get}~{\mathit{x}})~(\mathsf{ref.cast}~(\mathsf{ref}~\mathsf{null}~{\mathit{y}}))~(\mathsf{call\_ref}~{\mathit{y}}) &  \\
{[\textsc{\scriptsize E{-}return\_call\_indirect}]} \quad & (\mathsf{return\_call\_indirect}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{table.get}~{\mathit{x}})~(\mathsf{ref.cast}~(\mathsf{ref}~\mathsf{null}~{\mathit{y}}))~(\mathsf{return\_call\_ref}~{\mathit{y}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}frame{-}vals}]} \quad & ({{\mathsf{frame}}_{{\mathit{n}}}}{\{{\mathit{f}}\}}~{{\mathit{val}}^{{\mathit{n}}}}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}} &  \\
{[\textsc{\scriptsize E{-}return{-}frame}]} \quad & ({{\mathsf{frame}}_{{\mathit{n}}}}{\{{\mathit{f}}\}}~({{\mathit{val}'}^\ast}, {{\mathit{val}}^{{\mathit{n}}}}, \mathsf{return}, {{\mathit{instr}}^\ast})) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}} &  \\
{[\textsc{\scriptsize E{-}return{-}label}]} \quad & ({{\mathsf{label}}_{{\mathit{k}}}}{\{{{\mathit{instr}'}^\ast}\}}~({{\mathit{val}}^\ast}, \mathsf{return}, {{\mathit{instr}}^\ast})) &\hookrightarrow& {{\mathit{val}}^\ast}~\mathsf{return} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}unop{-}val}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}} . {\mathit{unop}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{{{{\mathit{unop}}}{}}_{{\mathit{nt}}}}{({\mathit{c}}_{{1}})} = {\mathit{c}} \\
{[\textsc{\scriptsize E{-}unop{-}trap}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}} . {\mathit{unop}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{{{{\mathit{unop}}}{}}_{{\mathit{nt}}}}{({\mathit{c}}_{{1}})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}binop{-}val}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{nt}} . {\mathit{binop}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{{{{\mathit{binop}}}{}}_{{\mathit{nt}}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} = {\mathit{c}} \\
{[\textsc{\scriptsize E{-}binop{-}trap}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{nt}} . {\mathit{binop}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{{{{\mathit{binop}}}{}}_{{\mathit{nt}}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}testop}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}} . {\mathit{testop}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{\mathit{c}} = {{{{\mathit{testop}}}{}}_{{\mathit{nt}}}}{({\mathit{c}}_{{1}})} \\
{[\textsc{\scriptsize E{-}relop}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}}_{{2}})~({\mathit{nt}} . {\mathit{relop}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{\mathit{c}} = {{{{\mathit{relop}}}{}}_{{\mathit{nt}}}}{({\mathit{c}}_{{1}},\, {\mathit{c}}_{{2}})} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}extend}]} \quad & ({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({{\mathit{nt}}.\mathsf{extend}}{{\mathit{n}}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{{{{\mathrm{ext}}}_{({\mathit{n}},\, {|{\mathit{nt}}|})}^{\mathsf{s}}}}{({\mathit{c}})}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}cvtop{-}val}]} \quad & ({\mathit{nt}}_{{1}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}_{{2}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{nt}}_{{1}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}) &\hookrightarrow& ({\mathit{nt}}_{{2}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{{{\mathit{cvtop}}}{{{}_{({\mathit{nt}}_{{1}},\, {\mathit{nt}}_{{2}})}^{{{\mathit{sx}}^?}}}}}{({\mathit{c}}_{{1}})} = {\mathit{c}} \\
{[\textsc{\scriptsize E{-}cvtop{-}trap}]} \quad & ({\mathit{nt}}_{{1}}.\mathsf{const}~{\mathit{c}}_{{1}})~({\mathit{nt}}_{{2}} . {{{{{\mathit{cvtop}}}{\mathsf{\_}}}{{\mathit{nt}}_{{1}}}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{{{\mathit{cvtop}}}{{{}_{({\mathit{nt}}_{{1}},\, {\mathit{nt}}_{{2}})}^{{{\mathit{sx}}^?}}}}}{({\mathit{c}}_{{1}})} = \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.func}]} \quad & {\mathit{z}} ; (\mathsf{ref.func}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.func}~{\mathit{z}}.\mathsf{module}.\mathsf{func}[{\mathit{x}}]) &  \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.i31}]} \quad & (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~\mathsf{ref.i{\scriptstyle31}} &\hookrightarrow& (\mathsf{ref.i{\scriptstyle31}}~{{{\mathrm{wrap}}}_{(32,\, 31)}}{({\mathit{i}})}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.is\_null{-}true}]} \quad & {\mathit{val}}~\mathsf{ref.is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{if}~{\mathit{val}} = (\mathsf{ref.null}~{\mathit{ht}}) \\
{[\textsc{\scriptsize E{-}ref.is\_null{-}false}]} \quad & {\mathit{val}}~\mathsf{ref.is\_null} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.as\_non\_null{-}null}]} \quad & {\mathit{ref}}~\mathsf{ref.as\_non\_null} &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{ref}} = (\mathsf{ref.null}~{\mathit{ht}}) \\
{[\textsc{\scriptsize E{-}ref.as\_non\_null{-}addr}]} \quad & {\mathit{ref}}~\mathsf{ref.as\_non\_null} &\hookrightarrow& {\mathit{ref}} &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.eq{-}null}]} \quad & {\mathit{ref}}_{{1}}~{\mathit{ref}}_{{2}}~\mathsf{ref.eq} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{if}~{\mathit{ref}}_{{1}} = \mathsf{ref.null}~{\mathit{ht}}_{{1}} \land {\mathit{ref}}_{{2}} = \mathsf{ref.null}~{\mathit{ht}}_{{2}} \\
{[\textsc{\scriptsize E{-}ref.eq{-}true}]} \quad & {\mathit{ref}}_{{1}}~{\mathit{ref}}_{{2}}~\mathsf{ref.eq} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{otherwise, if}~{\mathit{ref}}_{{1}} = {\mathit{ref}}_{{2}} \\
{[\textsc{\scriptsize E{-}ref.eq{-}false}]} \quad & {\mathit{ref}}_{{1}}~{\mathit{ref}}_{{2}}~\mathsf{ref.eq} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.test{-}true}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{ref.test}~{\mathit{rt}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~1) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{store} \vdash {\mathit{ref}} : {\mathit{rt}'} \\
 &&&&\quad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}'} \leq {{\mathrm{inst}}}_{{\mathit{z}}.\mathsf{module}}({\mathit{rt}}) \\
{[\textsc{\scriptsize E{-}ref.test{-}false}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{ref.test}~{\mathit{rt}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~0) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}ref.cast{-}succeed}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{ref.cast}~{\mathit{rt}}) &\hookrightarrow& {\mathit{ref}} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{store} \vdash {\mathit{ref}} : {\mathit{rt}'} \\
 &&&&\quad {\land}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \vdash {\mathit{rt}'} \leq {{\mathrm{inst}}}_{{\mathit{z}}.\mathsf{module}}({\mathit{rt}}) \\
{[\textsc{\scriptsize E{-}ref.cast{-}fail}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{ref.cast}~{\mathit{rt}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}i31.get{-}null}]} \quad & (\mathsf{ref.null}~{\mathit{ht}})~({{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}i31.get{-}num}]} \quad & (\mathsf{ref.i{\scriptstyle31}}~{\mathit{i}})~({{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{{\mathit{sx}}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{\mathrm{ext}}}_{(31,\, 32)}^{{\mathit{sx}}}}}{({\mathit{i}})}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.new}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{struct.new}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{struct} = ..{\mathit{si}}] ; (\mathsf{ref.struct}~{|{\mathit{z}}.\mathsf{struct}|}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^{{\mathit{n}}}} \\
 &&&&\quad {\land}~{\mathit{si}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}],\; \mathsf{field}~{({{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}}))^{{\mathit{n}}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.new\_default}]} \quad & {\mathit{z}} ; (\mathsf{struct.new\_default}~{\mathit{x}}) &\hookrightarrow& {{\mathit{val}}^\ast}~(\mathsf{struct.new}~{\mathit{x}}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast} \\
 &&&&\quad {\land}~(({\mathrm{default}}~{\mathrm{unpack}}({\mathit{zt}}) = {\mathit{val}}))^\ast \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.get{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~({{\mathsf{struct.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}struct.get{-}struct}]} \quad & {\mathit{z}} ; (\mathsf{ref.struct}~{\mathit{a}})~({{\mathsf{struct.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& {{{{\mathrm{unpack}}}_{{{\mathit{zt}}^\ast}[{\mathit{i}}]}^{{{\mathit{sx}}^?}}}}{({\mathit{si}}.\mathsf{field}[{\mathit{i}}])} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{struct}[{\mathit{a}}] = {\mathit{si}} \\
 &&&&\quad {\land}~{\mathit{si}}.\mathsf{type} \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}struct.set{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~{\mathit{val}}~(\mathsf{struct.set}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}struct.set{-}struct}]} \quad & {\mathit{z}} ; (\mathsf{ref.struct}~{\mathit{a}})~{\mathit{val}}~(\mathsf{struct.set}~{\mathit{x}}~{\mathit{i}}) &\hookrightarrow& {\mathit{z}}[\mathsf{struct}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] ; \epsilon &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{struct}[{\mathit{a}}].\mathsf{type} \approx \mathsf{struct}~{({\mathit{mut}}~{\mathit{zt}})^\ast} \\
 &&&&\quad {\land}~{\mathit{fv}} = {{\mathrm{pack}}}_{{{\mathit{zt}}^\ast}[{\mathit{i}}]}({\mathit{val}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new}]} \quad & {\mathit{z}} ; {\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new}~{\mathit{x}}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) &  \\
{[\textsc{\scriptsize E{-}array.new\_default}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_default}~{\mathit{x}}) &\hookrightarrow& {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathrm{default}}~{\mathrm{unpack}}({\mathit{zt}}) = {\mathit{val}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_fixed}]} \quad & {\mathit{z}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) &\hookrightarrow& {\mathit{z}}[\mathsf{array} = ..{\mathit{ai}}] ; (\mathsf{ref.array}~{|{\mathit{z}}.\mathsf{array}|}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{ai}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}],\; \mathsf{field}~{({{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}}))^{{\mathit{n}}}} \}\end{array} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_elem{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{elem}}{[{\mathit{y}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}array.new\_elem{-}alloc}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& {{\mathit{ref}}^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) &\quad
  \mbox{if}~{{\mathit{ref}}^{{\mathit{n}}}} = {{\mathit{z}}.\mathsf{elem}}{[{\mathit{y}}]}.\mathsf{elem}[{\mathit{i}} : {\mathit{n}}] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.new\_data{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{i}} + {\mathit{n}} \cdot {|{\mathit{zt}}|} / 8 > {|{{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}array.new\_data{-}alloc}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.new\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& {({\mathit{nt}}.\mathsf{const}~{\mathit{c}})^{{\mathit{n}}}}~(\mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}}) &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{nt}} = {\mathrm{unpack}}({\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathrm{concat}}({{{\mathrm{bytes}}}_{{\mathit{zt}}}({\mathit{c}})^{{\mathit{n}}}}) = {{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}[{\mathit{i}} : {\mathit{n}} \cdot {|{\mathit{zt}}|} / 8] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.get{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.get{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} \geq {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.get{-}array}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}) &\hookrightarrow& {{{{\mathrm{unpack}}}_{{\mathit{zt}}}^{{{\mathit{sx}}^?}}}}{({\mathit{fv}})} &\quad
  \mbox{if}~{\mathit{fv}} = {\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] \\
 &&&&\quad {\land}~{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{type} \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.set{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.set{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} \geq {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.set{-}array}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{struct}[{\mathit{a}}].\mathsf{field}[{\mathit{i}}] = {\mathit{fv}}] ; \epsilon &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{type} \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{fv}} = {{\mathrm{pack}}}_{{\mathit{zt}}}({\mathit{val}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.len{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{array.len} &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.len{-}array}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~\mathsf{array.len} &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}}) &\quad
  \mbox{if}~{\mathit{n}} = {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.fill{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.fill{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.fill{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}array.fill{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.fill}~{\mathit{x}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{array.set}~{\mathit{x}})~(\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.fill}~{\mathit{x}}) &\quad
  \mbox{otherwise} \\
{[\textsc{\scriptsize E{-}array.copy{-}null1}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~{\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.copy{-}null2}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.null}~{\mathit{ht}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.copy{-}oob1}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}}_{{1}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}_{{1}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.copy{-}oob2}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}}_{{2}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}_{{2}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.copy{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}array.copy{-}le}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}_{{2}})~(\mathsf{array.set}~{\mathit{x}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + 1)~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\quad
  \mbox{otherwise, if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}_{{2}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}_{{2}}) \\
 &&&&\quad {\land}~{{\mathit{sx}}^?} = {\mathrm{sx}}({\mathit{zt}}_{{2}}) \\
 &&&&\quad {\land}~{\mathit{i}}_{{1}} \leq {\mathit{i}}_{{2}} \\
{[\textsc{\scriptsize E{-}array.copy{-}gt}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + {\mathit{n}} - 1)~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + {\mathit{n}} - 1)~({{\mathsf{array.get}}{\mathsf{\_}}}{{{\mathit{sx}}^?}}~{\mathit{x}}_{{2}})~(\mathsf{array.set}~{\mathit{x}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{ref.array}~{\mathit{a}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\quad
  \mbox{otherwise, if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}_{{2}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}_{{2}}) \\
 &&&&\quad {\land}~{{\mathit{sx}}^?} = {\mathrm{sx}}({\mathit{zt}}_{{2}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.init\_elem{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}oob1}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}oob2}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{j}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{elem}}{[{\mathit{y}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}array.init\_elem{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{ref}}~(\mathsf{array.set}~{\mathit{x}})~(\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise, if}~{\mathit{ref}} = {{\mathit{z}}.\mathsf{elem}}{[{\mathit{y}}]}.\mathsf{elem}[{\mathit{j}}] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}array.init\_data{-}null}]} \quad & {\mathit{z}} ; (\mathsf{ref.null}~{\mathit{ht}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &  \\
{[\textsc{\scriptsize E{-}array.init\_data{-}oob1}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{\mathit{z}}.\mathsf{array}[{\mathit{a}}].\mathsf{field}|} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}oob2}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{j}} + {\mathit{n}} \cdot {|{\mathit{zt}}|} / 8 > {|{{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}array.init\_data{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}array.init\_data{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~(\mathsf{array.set}~{\mathit{x}})~(\mathsf{ref.array}~{\mathit{a}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + {|{\mathit{zt}}|} / 8)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise, if}~{\mathit{z}}.\mathsf{type}~[{\mathit{x}}] \approx \mathsf{array}~({\mathit{mut}}~{\mathit{zt}}) \\
 &&&&\quad {\land}~{\mathit{nt}} = {\mathrm{unpack}}({\mathit{zt}}) \\
 &&&&\quad {\land}~{{\mathrm{bytes}}}_{{\mathit{zt}}}({\mathit{c}}) = {{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}[{\mathit{j}} : {|{\mathit{zt}}|} / 8] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}extern.convert\_any{-}null}]} \quad & (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{extern.convert\_any} &\hookrightarrow& (\mathsf{ref.null}~\mathsf{extern}) &  \\
{[\textsc{\scriptsize E{-}extern.convert\_any{-}addr}]} \quad & {\mathit{addrref}}~\mathsf{extern.convert\_any} &\hookrightarrow& (\mathsf{ref.extern}~{\mathit{addrref}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}any.convert\_extern{-}null}]} \quad & (\mathsf{ref.null}~{\mathit{ht}})~\mathsf{any.convert\_extern} &\hookrightarrow& (\mathsf{ref.null}~\mathsf{any}) &  \\
{[\textsc{\scriptsize E{-}any.convert\_extern{-}addr}]} \quad & (\mathsf{ref.extern}~{\mathit{addrref}})~\mathsf{any.convert\_extern} &\hookrightarrow& {\mathit{addrref}} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.get}]} \quad & {\mathit{z}} ; (\mathsf{local.get}~{\mathit{x}}) &\hookrightarrow& {\mathit{val}} &\quad
  \mbox{if}~{{\mathit{z}}.\mathsf{local}}{[{\mathit{x}}]} = {\mathit{val}} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.set}]} \quad & {\mathit{z}} ; {\mathit{val}}~(\mathsf{local.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{local}[{\mathit{x}}] = {\mathit{val}}] ; \epsilon &  \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}local.tee}]} \quad & {\mathit{val}}~(\mathsf{local.tee}~{\mathit{x}}) &\hookrightarrow& {\mathit{val}}~{\mathit{val}}~(\mathsf{local.set}~{\mathit{x}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}global.get}]} \quad & {\mathit{z}} ; (\mathsf{global.get}~{\mathit{x}}) &\hookrightarrow& {{\mathit{z}}.\mathsf{global}}{[{\mathit{x}}]}.\mathsf{value} &  \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}global.set}]} \quad & {\mathit{z}} ; {\mathit{val}}~(\mathsf{global.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{global}[{\mathit{x}}].\mathsf{value} = {\mathit{val}}] ; \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.get{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{table.get}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} \geq {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.get{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{table.get}~{\mathit{x}}) &\hookrightarrow& {{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}[{\mathit{i}}] &\quad
  \mbox{if}~{\mathit{i}} < {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
\end{array}
$$

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.set{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{ref}}~(\mathsf{table.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} \geq {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.set{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{ref}}~(\mathsf{table.set}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{table}[{\mathit{x}}].\mathsf{elem}[{\mathit{i}}] = {\mathit{ref}}] ; \epsilon &\quad
  \mbox{if}~{\mathit{i}} < {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.size}]} \quad & {\mathit{z}} ; (\mathsf{table.size}~{\mathit{x}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}}) &\quad
  \mbox{if}~{|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} = {\mathit{n}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.grow{-}succeed}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{table}[{\mathit{x}}] = {\mathit{ti}}] ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|}) &\quad
  \mbox{if}~{\mathit{ti}} = {\mathrm{growtable}}({{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}, {\mathit{n}}, {\mathit{ref}}) \\
{[\textsc{\scriptsize E{-}table.grow{-}fail}]} \quad & {\mathit{z}} ; {\mathit{ref}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{{\mathrm{signed}}^{{-1}}}}{}}_{32}}{{-1}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.fill{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.fill{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.fill}~{\mathit{x}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}table.fill{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.fill}~{\mathit{x}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{table.set}~{\mathit{x}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{table.fill}~{\mathit{x}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.copy{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{y}}]}.\mathsf{elem}|} \lor {\mathit{j}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.copy{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}table.copy{-}le}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{table.get}~{\mathit{y}})~(\mathsf{table.set}~{\mathit{x}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise, if}~{\mathit{j}} \leq {\mathit{i}} \\
{[\textsc{\scriptsize E{-}table.copy{-}gt}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + {\mathit{n}} - 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + {\mathit{n}} - 1)~(\mathsf{table.get}~{\mathit{y}})~(\mathsf{table.set}~{\mathit{x}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{table.copy}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}table.init{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{elem}}{[{\mathit{y}}]}.\mathsf{elem}|} \lor {\mathit{j}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{table}}{[{\mathit{x}}]}.\mathsf{elem}|} \\
{[\textsc{\scriptsize E{-}table.init{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}table.init{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~{{\mathit{z}}.\mathsf{elem}}{[{\mathit{y}}]}.\mathsf{elem}[{\mathit{i}}]~(\mathsf{table.set}~{\mathit{x}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}elem.drop}]} \quad & {\mathit{z}} ; (\mathsf{elem.drop}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{elem}[{\mathit{x}}].\mathsf{elem} = \epsilon] ; \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}load{-}num{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {|{\mathit{nt}}|} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}load{-}num{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{\mathit{c}}) &\quad
  \mbox{if}~{{\mathrm{bytes}}}_{{\mathit{nt}}}({\mathit{c}}) = {{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {|{\mathit{nt}}|} / 8] \\
{[\textsc{\scriptsize E{-}load{-}pack{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathit{nt}}.\mathsf{load}}{({\mathit{n}}~\mathsf{\_}~{\mathit{sx}})}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{n}} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}load{-}pack{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({{\mathit{nt}}.\mathsf{load}}{({\mathit{n}}~\mathsf{\_}~{\mathit{sx}})}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& ({\mathit{nt}}.\mathsf{const}~{{{{\mathrm{ext}}}_{({\mathit{n}},\, {|{\mathit{nt}}|})}^{{\mathit{sx}}}}}{({\mathit{c}})}) &\quad
  \mbox{if}~{{\mathrm{bytes}}}_{{{\mathit{i}}}{{\mathit{n}}}}({\mathit{c}}) = {{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{n}} / 8] \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}store{-}num{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({\mathit{nt}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {|{\mathit{nt}}|} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}store{-}num{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({\mathit{nt}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& {\mathit{z}}[\mathsf{mem}[{\mathit{x}}].\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {|{\mathit{nt}}|} / 8] = {{\mathit{b}}^\ast}] ; \epsilon &\quad
  \mbox{if}~{{\mathit{b}}^\ast} = {{\mathrm{bytes}}}_{{\mathit{nt}}}({\mathit{c}}) \\
{[\textsc{\scriptsize E{-}store{-}pack{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({{\mathit{nt}}.\mathsf{store}}{{\mathit{n}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& {\mathit{z}} ; \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} + {\mathit{n}} / 8 > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}store{-}pack{-}val}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~({\mathit{nt}}.\mathsf{const}~{\mathit{c}})~({{\mathit{nt}}.\mathsf{store}}{{\mathit{n}}}~{\mathit{x}}~{\mathit{mo}}) &\hookrightarrow& {\mathit{z}}[\mathsf{mem}[{\mathit{x}}].\mathsf{data}[{\mathit{i}} + {\mathit{mo}}.\mathsf{offset} : {\mathit{n}} / 8] = {{\mathit{b}}^\ast}] ; \epsilon &\quad
  \mbox{if}~{{\mathit{b}}^\ast} = {{\mathrm{bytes}}}_{{{\mathit{i}}}{{\mathit{n}}}}({{{\mathrm{wrap}}}_{({|{\mathit{nt}}|},\, {\mathit{n}})}}{({\mathit{c}})}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.size}]} \quad & {\mathit{z}} ; (\mathsf{memory.size}~{\mathit{x}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}}) &\quad
  \mbox{if}~{\mathit{n}} \cdot 64 \cdot {\mathrm{Ki}} = {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.grow{-}succeed}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{mem}[{\mathit{x}}] = {\mathit{mi}}] ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} / (64 \cdot {\mathrm{Ki}})) &\quad
  \mbox{if}~{\mathit{mi}} = {\mathrm{growmemory}}({{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}, {\mathit{n}}) \\
{[\textsc{\scriptsize E{-}memory.grow{-}fail}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.grow}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{{{{\mathrm{signed}}^{{-1}}}}{}}_{32}}{{-1}}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.fill{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.fill}~{\mathit{x}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}memory.fill{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.fill}~{\mathit{x}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}memory.fill{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.fill}~{\mathit{x}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~{\mathit{val}}~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~{\mathit{val}}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.fill}~{\mathit{x}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.copy{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}}_{{1}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}_{{1}}]}.\mathsf{data}|} \lor {\mathit{i}}_{{2}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}_{{2}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}memory.copy{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}memory.copy{-}le}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~({\mathsf{i{\scriptstyle32}}.\mathsf{load}}{(8~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}_{{2}})~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\quad
  \mbox{otherwise, if}~{\mathit{i}}_{{1}} \leq {\mathit{i}}_{{2}} \\
{[\textsc{\scriptsize E{-}memory.copy{-}gt}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}} + {\mathit{n}} - 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}} + {\mathit{n}} - 1)~({\mathsf{i{\scriptstyle32}}.\mathsf{load}}{(8~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}_{{2}})~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{1}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}}_{{2}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}memory.init{-}oob}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \mathsf{trap} &\quad
  \mbox{if}~{\mathit{i}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}|} \lor {\mathit{j}} + {\mathit{n}} > {|{{\mathit{z}}.\mathsf{mem}}{[{\mathit{x}}]}.\mathsf{data}|} \\
{[\textsc{\scriptsize E{-}memory.init{-}zero}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& \epsilon &\quad
  \mbox{otherwise, if}~{\mathit{n}} = 0 \\
{[\textsc{\scriptsize E{-}memory.init{-}succ}]} \quad & {\mathit{z}} ; (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\hookrightarrow& (\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{{\mathit{z}}.\mathsf{data}}{[{\mathit{y}}]}.\mathsf{data}[{\mathit{i}}])~({\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}})~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{j}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{i}} + 1)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} - 1)~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}}) &\quad
  \mbox{otherwise} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}lcl@{}l@{}}
{[\textsc{\scriptsize E{-}data.drop}]} \quad & {\mathit{z}} ; (\mathsf{data.drop}~{\mathit{x}}) &\hookrightarrow& {\mathit{z}}[\mathsf{data}[{\mathit{x}}].\mathsf{data} = \epsilon] ; \epsilon &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{alloctypes}}(\epsilon) &=& \epsilon &  \\
{\mathrm{alloctypes}}({{\mathit{type}'}^\ast}~{\mathit{type}}) &=& {{\mathit{deftype}'}^\ast}~{{\mathit{deftype}}^\ast} &\quad
  \mbox{if}~{{\mathit{deftype}'}^\ast} = {\mathrm{alloctypes}}({{\mathit{type}'}^\ast}) \\
 &&&\quad {\land}~{\mathit{type}} = \mathsf{type}~{\mathit{rectype}} \\
 &&&\quad {\land}~{{\mathit{deftype}}^\ast} = {{{\mathrm{roll}}}_{{\mathit{x}}}({\mathit{rectype}})}{[{ := }\;{{\mathit{deftype}'}^\ast}]} \\
 &&&\quad {\land}~{\mathit{x}} = {|{{\mathit{deftype}'}^\ast}|} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocfunc}}({\mathit{s}}, {\mathit{mm}}, {\mathit{func}}) &=& ({\mathit{s}}[\mathsf{func} = ..{\mathit{fi}}],\, {|{\mathit{s}}.\mathsf{func}|}) &\quad
  \mbox{if}~{\mathit{func}} = \mathsf{func}~{\mathit{x}}~{{\mathit{local}}^\ast}~{\mathit{expr}} \\
 &&&\quad {\land}~{\mathit{fi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{mm}}.\mathsf{type}[{\mathit{x}}],\; \mathsf{module}~{\mathit{mm}},\; \mathsf{code}~{\mathit{func}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocfuncs}}({\mathit{s}}, {\mathit{mm}}, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocfuncs}}({\mathit{s}}, {\mathit{mm}}, {\mathit{func}}~{{\mathit{func}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{fa}}~{{\mathit{fa}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{fa}}) = {\mathrm{allocfunc}}({\mathit{s}}, {\mathit{mm}}, {\mathit{func}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{fa}'}^\ast}) = {\mathrm{allocfuncs}}({\mathit{s}}_{{1}}, {\mathit{mm}}, {{\mathit{func}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocglobal}}({\mathit{s}}, {\mathit{globaltype}}, {\mathit{val}}) &=& ({\mathit{s}}[\mathsf{global} = ..{\mathit{gi}}],\, {|{\mathit{s}}.\mathsf{global}|}) &\quad
  \mbox{if}~{\mathit{gi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{globaltype}},\; \mathsf{value}~{\mathit{val}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocglobals}}({\mathit{s}}, \epsilon, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocglobals}}({\mathit{s}}, {\mathit{globaltype}}~{{\mathit{globaltype}'}^\ast}, {\mathit{val}}~{{\mathit{val}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ga}}~{{\mathit{ga}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ga}}) = {\mathrm{allocglobal}}({\mathit{s}}, {\mathit{globaltype}}, {\mathit{val}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ga}'}^\ast}) = {\mathrm{allocglobals}}({\mathit{s}}_{{1}}, {{\mathit{globaltype}'}^\ast}, {{\mathit{val}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{alloctable}}({\mathit{s}}, [{\mathit{i}} .. {\mathit{j}}]~{\mathit{rt}}, {\mathit{ref}}) &=& ({\mathit{s}}[\mathsf{table} = ..{\mathit{ti}}],\, {|{\mathit{s}}.\mathsf{table}|}) &\quad
  \mbox{if}~{\mathit{ti}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}} .. {\mathit{j}}]~{\mathit{rt}}),\; \mathsf{elem}~{{\mathit{ref}}^{{\mathit{i}}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{alloctables}}({\mathit{s}}, \epsilon, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{alloctables}}({\mathit{s}}, {\mathit{tabletype}}~{{\mathit{tabletype}'}^\ast}, {\mathit{ref}}~{{\mathit{ref}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ta}}~{{\mathit{ta}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ta}}) = {\mathrm{alloctable}}({\mathit{s}}, {\mathit{tabletype}}, {\mathit{ref}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ta}'}^\ast}) = {\mathrm{alloctables}}({\mathit{s}}_{{1}}, {{\mathit{tabletype}'}^\ast}, {{\mathit{ref}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmem}}({\mathit{s}}, [{\mathit{i}} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}) &=& ({\mathit{s}}[\mathsf{mem} = ..{\mathit{mi}}],\, {|{\mathit{s}}.\mathsf{mem}|}) &\quad
  \mbox{if}~{\mathit{mi}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~([{\mathit{i}} .. {\mathit{j}}]~\mathsf{i{\scriptstyle8}}),\; \mathsf{data}~{0^{{\mathit{i}} \cdot 64 \cdot {\mathrm{Ki}}}} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmems}}({\mathit{s}}, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocmems}}({\mathit{s}}, {\mathit{memtype}}~{{\mathit{memtype}'}^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ma}}~{{\mathit{ma}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ma}}) = {\mathrm{allocmem}}({\mathit{s}}, {\mathit{memtype}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ma}'}^\ast}) = {\mathrm{allocmems}}({\mathit{s}}_{{1}}, {{\mathit{memtype}'}^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocelem}}({\mathit{s}}, {\mathit{rt}}, {{\mathit{ref}}^\ast}) &=& ({\mathit{s}}[\mathsf{elem} = ..{\mathit{ei}}],\, {|{\mathit{s}}.\mathsf{elem}|}) &\quad
  \mbox{if}~{\mathit{ei}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathit{rt}},\; \mathsf{elem}~{{\mathit{ref}}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocelems}}({\mathit{s}}, \epsilon, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocelems}}({\mathit{s}}, {\mathit{rt}}~{{\mathit{rt}'}^\ast}, ({{\mathit{ref}}^\ast})~{({{\mathit{ref}'}^\ast})^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{ea}}~{{\mathit{ea}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{ea}}) = {\mathrm{allocelem}}({\mathit{s}}, {\mathit{rt}}, {{\mathit{ref}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ea}'}^\ast}) = {\mathrm{allocelems}}({\mathit{s}}_{{2}}, {{\mathit{rt}'}^\ast}, {({{\mathit{ref}'}^\ast})^\ast}) \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocdata}}({\mathit{s}}, {{\mathit{byte}}^\ast}) &=& ({\mathit{s}}[\mathsf{data} = ..{\mathit{di}}],\, {|{\mathit{s}}.\mathsf{data}|}) &\quad
  \mbox{if}~{\mathit{di}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{data}~{{\mathit{byte}}^\ast} \}\end{array} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocdatas}}({\mathit{s}}, \epsilon) &=& ({\mathit{s}},\, \epsilon) &  \\
{\mathrm{allocdatas}}({\mathit{s}}, ({{\mathit{byte}}^\ast})~{({{\mathit{byte}'}^\ast})^\ast}) &=& ({\mathit{s}}_{{2}},\, {\mathit{da}}~{{\mathit{da}'}^\ast}) &\quad
  \mbox{if}~({\mathit{s}}_{{1}},\, {\mathit{da}}) = {\mathrm{allocdata}}({\mathit{s}}, {{\mathit{byte}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{da}'}^\ast}) = {\mathrm{allocdatas}}({\mathit{s}}_{{1}}, {({{\mathit{byte}'}^\ast})^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{instexport}}({{\mathit{fa}}^\ast}, {{\mathit{ga}}^\ast}, {{\mathit{ta}}^\ast}, {{\mathit{ma}}^\ast}, \mathsf{export}~{\mathit{name}}~(\mathsf{func}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{func}~{{\mathit{fa}}^\ast}[{\mathit{x}}]) \}\end{array} &  \\
{\mathrm{instexport}}({{\mathit{fa}}^\ast}, {{\mathit{ga}}^\ast}, {{\mathit{ta}}^\ast}, {{\mathit{ma}}^\ast}, \mathsf{export}~{\mathit{name}}~(\mathsf{global}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{global}~{{\mathit{ga}}^\ast}[{\mathit{x}}]) \}\end{array} &  \\
{\mathrm{instexport}}({{\mathit{fa}}^\ast}, {{\mathit{ga}}^\ast}, {{\mathit{ta}}^\ast}, {{\mathit{ma}}^\ast}, \mathsf{export}~{\mathit{name}}~(\mathsf{table}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{table}~{{\mathit{ta}}^\ast}[{\mathit{x}}]) \}\end{array} &  \\
{\mathrm{instexport}}({{\mathit{fa}}^\ast}, {{\mathit{ga}}^\ast}, {{\mathit{ta}}^\ast}, {{\mathit{ma}}^\ast}, \mathsf{export}~{\mathit{name}}~(\mathsf{mem}~{\mathit{x}})) &=& \{ \begin{array}[t]{@{}l@{}}
\mathsf{name}~{\mathit{name}},\; \mathsf{value}~(\mathsf{mem}~{{\mathit{ma}}^\ast}[{\mathit{x}}]) \}\end{array} &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{allocmodule}}({\mathit{s}}, {\mathit{module}}, {{\mathit{externval}}^\ast}, {{\mathit{val}}_{{\mathit{g}}}^\ast}, {{\mathit{ref}}_{{\mathit{t}}}^\ast}, {({{\mathit{ref}}_{{\mathit{e}}}^\ast})^\ast}) &=& ({\mathit{s}}_{{6}},\, {\mathit{mm}}) &\quad
  \mbox{if}~{\mathit{module}} = \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^{{\mathit{n}}_{{\mathit{f}}}}}~{(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}_{{\mathit{g}}})^{{\mathit{n}}_{{\mathit{g}}}}}~{(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}_{{\mathit{t}}})^{{\mathit{n}}_{{\mathit{t}}}}}~{(\mathsf{memory}~{\mathit{memtype}})^{{\mathit{n}}_{{\mathit{m}}}}}~{(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}_{{\mathit{e}}}^\ast}~{\mathit{elemmode}})^{{\mathit{n}}_{{\mathit{e}}}}}~{(\mathsf{data}~{{\mathit{byte}}^\ast}~{\mathit{datamode}})^{{\mathit{n}}_{{\mathit{d}}}}}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} \\
 &&&\quad {\land}~{{\mathit{fa}}_{{\mathit{ex}}}^\ast} = {\mathrm{funcs}}({{\mathit{externval}}^\ast}) \\
 &&&\quad {\land}~{{\mathit{ga}}_{{\mathit{ex}}}^\ast} = {\mathrm{globals}}({{\mathit{externval}}^\ast}) \\
 &&&\quad {\land}~{{\mathit{ta}}_{{\mathit{ex}}}^\ast} = {\mathrm{tables}}({{\mathit{externval}}^\ast}) \\
 &&&\quad {\land}~{{\mathit{ma}}_{{\mathit{ex}}}^\ast} = {\mathrm{mems}}({{\mathit{externval}}^\ast}) \\
 &&&\quad {\land}~{{\mathit{fa}}^\ast} = {{|{\mathit{s}}.\mathsf{func}|} + {\mathit{i}}_{{\mathit{f}}}^{{\mathit{i}}_{{\mathit{f}}}<{\mathit{n}}_{{\mathit{f}}}}} \\
 &&&\quad {\land}~{{\mathit{ga}}^\ast} = {{|{\mathit{s}}.\mathsf{global}|} + {\mathit{i}}_{{\mathit{g}}}^{{\mathit{i}}_{{\mathit{g}}}<{\mathit{n}}_{{\mathit{g}}}}} \\
 &&&\quad {\land}~{{\mathit{ta}}^\ast} = {{|{\mathit{s}}.\mathsf{table}|} + {\mathit{i}}_{{\mathit{t}}}^{{\mathit{i}}_{{\mathit{t}}}<{\mathit{n}}_{{\mathit{t}}}}} \\
 &&&\quad {\land}~{{\mathit{ma}}^\ast} = {{|{\mathit{s}}.\mathsf{mem}|} + {\mathit{i}}_{{\mathit{m}}}^{{\mathit{i}}_{{\mathit{m}}}<{\mathit{n}}_{{\mathit{m}}}}} \\
 &&&\quad {\land}~{{\mathit{ea}}^\ast} = {{|{\mathit{s}}.\mathsf{elem}|} + {\mathit{i}}_{{\mathit{e}}}^{{\mathit{i}}_{{\mathit{e}}}<{\mathit{n}}_{{\mathit{e}}}}} \\
 &&&\quad {\land}~{{\mathit{da}}^\ast} = {{|{\mathit{s}}.\mathsf{data}|} + {\mathit{i}}_{{\mathit{d}}}^{{\mathit{i}}_{{\mathit{d}}}<{\mathit{n}}_{{\mathit{d}}}}} \\
 &&&\quad {\land}~{{\mathit{xi}}^\ast} = {{\mathrm{instexport}}({{\mathit{fa}}_{{\mathit{ex}}}^\ast}~{{\mathit{fa}}^\ast}, {{\mathit{ga}}_{{\mathit{ex}}}^\ast}~{{\mathit{ga}}^\ast}, {{\mathit{ta}}_{{\mathit{ex}}}^\ast}~{{\mathit{ta}}^\ast}, {{\mathit{ma}}_{{\mathit{ex}}}^\ast}~{{\mathit{ma}}^\ast}, {\mathit{export}})^\ast} \\
 &&&\quad {\land}~{\mathit{mm}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{{\mathit{dt}}^\ast},\; \\
  \mathsf{func}~{{\mathit{fa}}_{{\mathit{ex}}}^\ast}~{{\mathit{fa}}^\ast},\; \\
  \mathsf{global}~{{\mathit{ga}}_{{\mathit{ex}}}^\ast}~{{\mathit{ga}}^\ast},\; \\
  \mathsf{table}~{{\mathit{ta}}_{{\mathit{ex}}}^\ast}~{{\mathit{ta}}^\ast},\; \\
  \mathsf{mem}~{{\mathit{ma}}_{{\mathit{ex}}}^\ast}~{{\mathit{ma}}^\ast},\; \\
  \mathsf{elem}~{{\mathit{ea}}^\ast},\; \\
  \mathsf{data}~{{\mathit{da}}^\ast},\; \\
  \mathsf{export}~{{\mathit{xi}}^\ast} \}\end{array} \\
 &&&\quad {\land}~{{\mathit{dt}}^\ast} = {\mathrm{alloctypes}}({{\mathit{type}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{1}},\, {{\mathit{fa}}^\ast}) = {\mathrm{allocfuncs}}({\mathit{s}}, {\mathit{mm}}, {{\mathit{func}}^{{\mathit{n}}_{{\mathit{f}}}}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{2}},\, {{\mathit{ga}}^\ast}) = {\mathrm{allocglobals}}({\mathit{s}}_{{1}}, {{\mathit{globaltype}}^{{\mathit{n}}_{{\mathit{g}}}}}, {{\mathit{val}}_{{\mathit{g}}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{3}},\, {{\mathit{ta}}^\ast}) = {\mathrm{alloctables}}({\mathit{s}}_{{2}}, {{\mathit{tabletype}}^{{\mathit{n}}_{{\mathit{t}}}}}, {{\mathit{ref}}_{{\mathit{t}}}^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{4}},\, {{\mathit{ma}}^\ast}) = {\mathrm{allocmems}}({\mathit{s}}_{{3}}, {{\mathit{memtype}}^{{\mathit{n}}_{{\mathit{m}}}}}) \\
 &&&\quad {\land}~({\mathit{s}}_{{5}},\, {{\mathit{ea}}^\ast}) = {\mathrm{allocelems}}({\mathit{s}}_{{4}}, {{\mathit{reftype}}^{{\mathit{n}}_{{\mathit{e}}}}}, {({{\mathit{ref}}_{{\mathit{e}}}^\ast})^\ast}) \\
 &&&\quad {\land}~({\mathit{s}}_{{6}},\, {{\mathit{da}}^\ast}) = {\mathrm{allocdatas}}({\mathit{s}}_{{5}}, {({{\mathit{byte}}^\ast})^{{\mathit{n}}_{{\mathit{d}}}}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{concat}}_{{\mathit{instr}}}(\epsilon) &=& \epsilon &  \\
{\mathrm{concat}}_{{\mathit{instr}}}(({{\mathit{instr}}^\ast})~{({{\mathit{instr}'}^\ast})^\ast}) &=& {{\mathit{instr}}^\ast}~{\mathrm{concat}}_{{\mathit{instr}}}({({{\mathit{instr}'}^\ast})^\ast}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{runelem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~(\mathsf{passive}), {\mathit{y}}) &=& \epsilon &  \\
{\mathrm{runelem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~(\mathsf{declare}), {\mathit{y}}) &=& (\mathsf{elem.drop}~{\mathit{y}}) &  \\
{\mathrm{runelem}}(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}^\ast}~(\mathsf{active}~{\mathit{x}}~{{\mathit{instr}}^\ast}), {\mathit{y}}) &=& {{\mathit{instr}}^\ast}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{expr}}^\ast}|})~(\mathsf{table.init}~{\mathit{x}}~{\mathit{y}})~(\mathsf{elem.drop}~{\mathit{y}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{rundata}}(\mathsf{data}~{{\mathit{byte}}^\ast}~(\mathsf{passive}), {\mathit{y}}) &=& \epsilon &  \\
{\mathrm{rundata}}(\mathsf{data}~{{\mathit{byte}}^\ast}~(\mathsf{active}~{\mathit{x}}~{{\mathit{instr}}^\ast}), {\mathit{y}}) &=& {{\mathit{instr}}^\ast}~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~0)~(\mathsf{i{\scriptstyle32}}.\mathsf{const}~{|{{\mathit{byte}}^\ast}|})~(\mathsf{memory.init}~{\mathit{x}}~{\mathit{y}})~(\mathsf{data.drop}~{\mathit{y}}) &  \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{instantiate}}({\mathit{s}}, {\mathit{module}}, {{\mathit{externval}}^\ast}) &=& {\mathit{s}'} ; {\mathit{f}} ; {{\mathit{instr}}_{{\mathit{E}}}^\ast}~{{\mathit{instr}}_{{\mathsf{d}}}^\ast}~{(\mathsf{call}~{\mathit{x}})^?} &\quad
  \mbox{if}~{\mathit{module}} = \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^\ast}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^\ast}~{{\mathit{start}}^?}~{{\mathit{export}}^\ast} \\
 &&&\quad {\land}~{{\mathit{global}}^\ast} = {(\mathsf{global}~{\mathit{globaltype}}~{\mathit{expr}}_{{\mathsf{g}}})^\ast} \\
 &&&\quad {\land}~{{\mathit{table}}^\ast} = {(\mathsf{table}~{\mathit{tabletype}}~{\mathit{expr}}_{{\mathsf{t}}})^\ast} \\
 &&&\quad {\land}~{{\mathit{elem}}^\ast} = {(\mathsf{elem}~{\mathit{reftype}}~{{\mathit{expr}}_{{\mathit{E}}}^\ast}~{\mathit{elemmode}})^\ast} \\
 &&&\quad {\land}~{{\mathit{start}}^?} = {(\mathsf{start}~{\mathit{x}})^?} \\
 &&&\quad {\land}~{\mathit{n}}_{{\mathsf{f}}} = {|{{\mathit{func}}^\ast}|} \\
 &&&\quad {\land}~{\mathit{n}}_{{\mathit{E}}} = {|{{\mathit{elem}}^\ast}|} \\
 &&&\quad {\land}~{\mathit{n}}_{{\mathsf{d}}} = {|{{\mathit{data}}^\ast}|} \\
 &&&\quad {\land}~{\mathit{mm}}_{{\mathit{init}}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{type}~{\mathrm{alloctypes}}({{\mathit{type}}^\ast}),\; \\
  \mathsf{func}~{\mathrm{funcs}}({{\mathit{externval}}^\ast})~{{|{\mathit{s}}.\mathsf{func}|} + {\mathit{i}}_{{\mathsf{f}}}^{{\mathit{i}}_{{\mathsf{f}}}<{\mathit{n}}_{{\mathsf{f}}}}},\; \\
  \mathsf{global}~{\mathrm{globals}}({{\mathit{externval}}^\ast}),\; \\
   \}\end{array} \\
 &&&\quad {\land}~{\mathit{z}} = {\mathit{s}} ; \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~{\mathit{mm}}_{{\mathit{init}}} \}\end{array} \\
 &&&\quad {\land}~({\mathit{z}} ; {\mathit{expr}}_{{\mathsf{g}}} \hookrightarrow^\ast {\mathit{z}} ; {\mathit{val}}_{{\mathsf{g}}})^\ast \\
 &&&\quad {\land}~({\mathit{z}} ; {\mathit{expr}}_{{\mathsf{t}}} \hookrightarrow^\ast {\mathit{z}} ; {\mathit{ref}}_{{\mathsf{t}}})^\ast \\
 &&&\quad {\land}~{({\mathit{z}} ; {\mathit{expr}}_{{\mathit{E}}} \hookrightarrow^\ast {\mathit{z}} ; {\mathit{ref}}_{{\mathit{E}}})^\ast}^\ast \\
 &&&\quad {\land}~({\mathit{s}'},\, {\mathit{mm}}) = {\mathrm{allocmodule}}({\mathit{s}}, {\mathit{module}}, {{\mathit{externval}}^\ast}, {{\mathit{val}}_{{\mathsf{g}}}^\ast}, {{\mathit{ref}}_{{\mathsf{t}}}^\ast}, {({{\mathit{ref}}_{{\mathit{E}}}^\ast})^\ast}) \\
 &&&\quad {\land}~{\mathit{f}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~{\mathit{mm}} \}\end{array} \\
 &&&\quad {\land}~{{\mathit{instr}}_{{\mathit{E}}}^\ast} = {\mathrm{concat}}_{{\mathit{instr}}}({{\mathrm{runelem}}({{\mathit{elem}}^\ast}[{\mathit{i}}], {\mathit{i}})^{{\mathit{i}}<{\mathit{n}}_{{\mathit{E}}}}}) \\
 &&&\quad {\land}~{{\mathit{instr}}_{{\mathsf{d}}}^\ast} = {\mathrm{concat}}_{{\mathit{instr}}}({{\mathrm{rundata}}({{\mathit{data}}^\ast}[{\mathit{j}}], {\mathit{j}})^{{\mathit{j}}<{\mathit{n}}_{{\mathsf{d}}}}}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{invoke}}({\mathit{s}}, {\mathit{fa}}, {{\mathit{val}}^{{\mathit{n}}}}) &=& {\mathit{s}} ; {\mathit{f}} ; {{\mathit{val}}^{{\mathit{n}}}}~(\mathsf{ref.func}~{\mathit{fa}})~(\mathsf{call\_ref}~0) &\quad
  \mbox{if}~{\mathit{f}} = \{ \begin{array}[t]{@{}l@{}}
\mathsf{module}~\{ \begin{array}[t]{@{}l@{}}
 \}\end{array} \}\end{array} \\
 &&&\quad {\land}~({\mathit{s}} ; {\mathit{f}}).\mathsf{func}[{\mathit{fa}}].\mathsf{code} = \mathsf{func}~{\mathit{x}}~{{\mathit{local}}^\ast}~{\mathit{expr}} \\
 &&&\quad {\land}~{\mathit{s}}.\mathsf{func}[{\mathit{fa}}].\mathsf{type} \approx \mathsf{func}~({{\mathit{t}}_{{1}}^{{\mathit{n}}}} \rightarrow {{\mathit{t}}_{{2}}^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{vec}}({\mathtt{X}}) &::=& {\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}}~{({\mathit{el}}{:}{\mathtt{X}})^{{\mathit{n}}}} &\Rightarrow& {{\mathit{el}}^{{\mathit{n}}}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{byte}} &::=& {\mathit{b}}{:}\mathtt{0x00} ~|~ \dots ~|~ {\mathit{b}}{:}\mathtt{0xFF} &\Rightarrow& {\mathit{b}} \\
& {{\mathtt{u}}}{{\mathit{N}}} &::=& {\mathit{n}}{:}{\mathtt{byte}} &\Rightarrow& {\mathit{n}} &\quad
  \mbox{if}~{\mathit{n}} < {2^{7}} \land {\mathit{n}} < {2^{{\mathit{N}}}} \\ &&|&
{\mathit{n}}{:}{\mathtt{byte}}~{\mathit{m}}{:}{{\mathtt{u}}}{({\mathit{N}} - 7)} &\Rightarrow& {2^{7}} \cdot {\mathit{m}} + ({\mathit{n}} - {2^{7}}) &\quad
  \mbox{if}~{\mathit{n}} \geq {2^{7}} \land {\mathit{N}} > 7 \\
& {{\mathtt{s}}}{{\mathit{N}}} &::=& {\mathit{n}}{:}{\mathtt{byte}} &\Rightarrow& {\mathit{n}} &\quad
  \mbox{if}~{\mathit{n}} < {2^{6}} \land {\mathit{n}} < {2^{{\mathit{N}} - 1}} \\ &&|&
{\mathit{n}}{:}{\mathtt{byte}} &\Rightarrow& {\mathit{n}} - {2^{7}} &\quad
  \mbox{if}~{2^{6}} \leq {\mathit{n}} < {2^{7}} \land {\mathit{n}} \geq {2^{7}} - {2^{{\mathit{N}} - 1}} \\ &&|&
{\mathit{n}}{:}{\mathtt{byte}}~{\mathit{i}}{:}{{\mathtt{u}}}{({\mathit{N}} - 7)} &\Rightarrow& {2^{7}} \cdot {\mathit{i}} + ({\mathit{n}} - {2^{7}}) &\quad
  \mbox{if}~{\mathit{n}} \geq {2^{7}} \land {\mathit{N}} > 7 \\
& {{\mathtt{i}}}{{\mathit{N}}} &::=& {\mathit{i}}{:}{{\mathtt{s}}}{{\mathit{N}}} &\Rightarrow& {{{{{\mathrm{signed}}^{{-1}}}}{}}_{{\mathit{N}}}}{{\mathit{i}}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {{\mathtt{f}}}{{\mathit{N}}} &::=& {{\mathit{b}}^\ast}{:}{{\mathtt{byte}}^{{\mathit{N}} / 8}} &\Rightarrow& {\mathrm{invfbytes}}({\mathit{N}}, {{\mathit{b}}^\ast}) \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{u{\scriptstyle32}}} &::=& {\mathit{n}}{:}{{\mathtt{u}}}{32} &\Rightarrow& {\mathit{n}} \\
& {\mathtt{u{\scriptstyle64}}} &::=& {\mathit{n}}{:}{{\mathtt{u}}}{64} &\Rightarrow& {\mathit{n}} \\
& {\mathtt{s{\scriptstyle33}}} &::=& {\mathit{i}}{:}{{\mathtt{s}}}{33} &\Rightarrow& {\mathit{i}} \\
& {\mathtt{f{\scriptstyle32}}} &::=& {\mathit{p}}{:}{{\mathtt{f}}}{32} &\Rightarrow& {\mathit{p}} \\
& {\mathtt{f{\scriptstyle64}}} &::=& {\mathit{p}}{:}{{\mathtt{f}}}{64} &\Rightarrow& {\mathit{p}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{utf{\scriptstyle8}}}({\mathit{c}}) &=& {\mathit{b}} &\quad
  \mbox{if}~{\mathit{c}} < \mathrm{U{+}80} \land {\mathit{c}} = {\mathit{b}} \\
{\mathrm{utf{\scriptstyle8}}}({\mathit{c}}) &=& {\mathit{b}}_{{1}}~{\mathit{b}}_{{2}} &\quad
  \mbox{if}~\mathrm{U{+}80} \leq {\mathit{c}} < \mathrm{U{+}0800} \land {\mathit{c}} = {2^{6}} \cdot ({\mathit{b}}_{{1}} - \mathtt{0xC0}) + ({\mathit{b}}_{{2}} - \mathtt{0x80}) \\
{\mathrm{utf{\scriptstyle8}}}({\mathit{c}}) &=& {\mathit{b}}_{{1}}~{\mathit{b}}_{{2}}~{\mathit{b}}_{{3}} &\quad
  \mbox{if}~(\mathrm{U{+}0800} \leq {\mathit{c}} < \mathrm{U{+}D800} \lor \mathrm{U{+}E000} \leq {\mathit{c}} < \mathrm{U{+}10000}) \land {\mathit{c}} = {2^{12}} \cdot ({\mathit{b}}_{{1}} - \mathtt{0xE0}) + {2^{6}} \cdot ({\mathit{b}}_{{2}} - \mathtt{0x80}) + ({\mathit{b}}_{{3}} - \mathtt{0x80}) \\
{\mathrm{utf{\scriptstyle8}}}({\mathit{c}}) &=& {\mathit{b}}_{{1}}~{\mathit{b}}_{{2}}~{\mathit{b}}_{{3}}~{\mathit{b}}_{{4}} &\quad
  \mbox{if}~(\mathrm{U{+}10000} \leq {\mathit{c}} < \mathrm{U{+}11000}) \land {\mathit{c}} = {2^{18}} \cdot ({\mathit{b}}_{{1}} - \mathtt{0xF0}) + {2^{12}} \cdot ({\mathit{b}}_{{2}} - \mathtt{0x80}) + {2^{6}} \cdot ({\mathit{b}}_{{3}} - \mathtt{0x80}) + ({\mathit{b}}_{{4}} - \mathtt{0x80}) \\
{\mathrm{utf{\scriptstyle8}}}({{\mathit{c}}^\ast}) &=& {\mathrm{concat}}({{\mathrm{utf{\scriptstyle8}}}({\mathit{c}})^\ast}) &  \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{name}} &::=& {{\mathit{b}}^\ast}{:}{\mathtt{vec}}({\mathtt{byte}}) &\Rightarrow& {\mathit{name}} &\quad
  \mbox{if}~{\mathrm{utf{\scriptstyle8}}}({\mathit{name}}) = {{\mathit{b}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{typeidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{funcidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{globalidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{tableidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{memidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{elemidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{dataidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{localidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{labelidx}} &::=& {\mathit{x}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{x}} \\
& {\mathtt{externidx}} &::=& \mathtt{0x00}~{\mathit{x}}{:}{\mathtt{funcidx}} &\Rightarrow& \mathsf{func}~{\mathit{x}} \\ &&|&
\mathtt{0x01}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table}~{\mathit{x}} \\ &&|&
\mathtt{0x02}~{\mathit{x}}{:}{\mathtt{memidx}} &\Rightarrow& \mathsf{mem}~{\mathit{x}} \\ &&|&
\mathtt{0x03}~{\mathit{x}}{:}{\mathtt{globalidx}} &\Rightarrow& \mathsf{global}~{\mathit{x}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{numtype}} &::=& \mathtt{0x7F} &\Rightarrow& \mathsf{i{\scriptstyle32}} \\ &&|&
\mathtt{0x7E} &\Rightarrow& \mathsf{i{\scriptstyle64}} \\ &&|&
\mathtt{0x7D} &\Rightarrow& \mathsf{f{\scriptstyle32}} \\ &&|&
\mathtt{0x7C} &\Rightarrow& \mathsf{f{\scriptstyle64}} \\
& {\mathtt{vectype}} &::=& \mathtt{0x7B} &\Rightarrow& \mathsf{v{\scriptstyle128}} \\
& {\mathtt{absheaptype}} &::=& \mathtt{0x73} &\Rightarrow& \mathsf{nofunc} \\ &&|&
\mathtt{0x72} &\Rightarrow& \mathsf{noextern} \\ &&|&
\mathtt{0x71} &\Rightarrow& \mathsf{none} \\ &&|&
\mathtt{0x70} &\Rightarrow& \mathsf{func} \\ &&|&
\mathtt{0x6F} &\Rightarrow& \mathsf{extern} \\ &&|&
\mathtt{0x6E} &\Rightarrow& \mathsf{any} \\ &&|&
\mathtt{0x6D} &\Rightarrow& \mathsf{eq} \\ &&|&
\mathtt{0x6C} &\Rightarrow& \mathsf{i{\scriptstyle31}} \\ &&|&
\mathtt{0x6B} &\Rightarrow& \mathsf{struct} \\ &&|&
\mathtt{0x6A} &\Rightarrow& \mathsf{array} \\
& {\mathtt{heaptype}} &::=& {\mathit{ht}}{:}{\mathtt{absheaptype}} &\Rightarrow& {\mathit{ht}} \\ &&|&
{{\mathit{x}}}{:}{\mathtt{s{\scriptstyle33}}} &\Rightarrow& {{\mathit{x}}} &\quad
  \mbox{if}~{{\mathit{x}}} \geq 0 \\
& {\mathtt{reftype}} &::=& \mathtt{0x64}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref}~{\mathit{ht}} \\ &&|&
\mathtt{0x63}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref}~\mathsf{null}~{\mathit{ht}} \\ &&|&
{\mathit{ht}}{:}{\mathtt{absheaptype}} &\Rightarrow& \mathsf{ref}~\mathsf{null}~{\mathit{ht}} \\
& {\mathtt{valtype}} &::=& {\mathit{nt}}{:}{\mathtt{numtype}} &\Rightarrow& {\mathit{nt}} \\ &&|&
{\mathit{vt}}{:}{\mathtt{vectype}} &\Rightarrow& {\mathit{vt}} \\ &&|&
{\mathit{rt}}{:}{\mathtt{reftype}} &\Rightarrow& {\mathit{rt}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{resulttype}} &::=& {{\mathit{t}}^\ast}{:}{\mathtt{vec}}({\mathtt{valtype}}) &\Rightarrow& {{\mathit{t}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{mut}} &::=& \mathtt{0x00} &\Rightarrow& \epsilon \\ &&|&
\mathtt{0x01} &\Rightarrow& \mathsf{mut} \\
& {\mathtt{packedtype}} &::=& \mathtt{0x78} &\Rightarrow& \mathsf{i{\scriptstyle8}} \\ &&|&
\mathtt{0x77} &\Rightarrow& \mathsf{i{\scriptstyle16}} \\
& {\mathtt{storagetype}} &::=& {\mathit{t}}{:}{\mathtt{valtype}} &\Rightarrow& {\mathit{t}} \\ &&|&
{\mathit{pt}}{:}{\mathtt{packedtype}} &\Rightarrow& {\mathit{pt}} \\
& {\mathtt{fieldtype}} &::=& {\mathit{zt}}{:}{\mathtt{storagetype}}~{\mathit{mut}}{:}{\mathtt{mut}} &\Rightarrow& {\mathit{mut}}~{\mathit{zt}} \\
& {\mathtt{comptype}} &::=& \mathtt{0x60}~{{\mathit{t}}_{{1}}^\ast}{:}{\mathtt{resulttype}}~{{\mathit{t}}_{{2}}^\ast}{:}{\mathtt{resulttype}} &\Rightarrow& \mathsf{func}~({{\mathit{t}}_{{1}}^\ast} \rightarrow {{\mathit{t}}_{{2}}^\ast}) \\ &&|&
\mathtt{0x59}~{{\mathit{yt}}^\ast}{:}{\mathtt{vec}}({\mathtt{fieldtype}}) &\Rightarrow& \mathsf{struct}~{{\mathit{yt}}^\ast} \\ &&|&
\mathtt{0x58}~{\mathit{yt}}{:}{\mathtt{fieldtype}} &\Rightarrow& \mathsf{array}~{\mathit{yt}} \\
& {\mathtt{subtype}} &::=& \mathtt{0x50}~{{\mathit{x}}^\ast}{:}{\mathtt{vec}}({\mathtt{typeidx}})~{\mathit{ct}}{:}{\mathtt{comptype}} &\Rightarrow& \mathsf{sub}~{{\mathit{x}}^\ast}~{\mathit{ct}} \\ &&|&
\mathtt{0x49}~{{\mathit{x}}^\ast}{:}{\mathtt{vec}}({\mathtt{typeidx}})~{\mathit{ct}}{:}{\mathtt{comptype}} &\Rightarrow& \mathsf{sub}~\mathsf{final}~{{\mathit{x}}^\ast}~{\mathit{ct}} \\ &&|&
{\mathit{ct}}{:}{\mathtt{comptype}} &\Rightarrow& \mathsf{sub}~\mathsf{final}~\epsilon~{\mathit{ct}} \\
& {\mathtt{rectype}} &::=& \mathtt{0x48}~{{\mathit{st}}^\ast}{:}{\mathtt{vec}}({\mathtt{subtype}}) &\Rightarrow& \mathsf{rec}~{{\mathit{st}}^\ast} \\ &&|&
{\mathit{st}}{:}{\mathtt{subtype}} &\Rightarrow& \mathsf{rec}~{\mathit{st}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{limits}} &::=& \mathtt{0x00}~{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& [{\mathit{n}} .. {2^{32}} - 1] \\ &&|&
\mathtt{0x01}~{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{m}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& [{\mathit{n}} .. {\mathit{m}}] \\
& {\mathtt{globaltype}} &::=& {\mathit{t}}{:}{\mathtt{valtype}}~{\mathit{mut}}{:}{\mathtt{mut}} &\Rightarrow& {\mathit{mut}}~{\mathit{t}} \\
& {\mathtt{tabletype}} &::=& {\mathit{rt}}{:}{\mathtt{reftype}}~{\mathit{lim}}{:}{\mathtt{limits}} &\Rightarrow& {\mathit{lim}}~{\mathit{rt}} \\
& {\mathtt{memtype}} &::=& {\mathit{lim}}{:}{\mathtt{limits}} &\Rightarrow& {\mathit{lim}}~\mathsf{i{\scriptstyle8}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{externtype}} &::=& \mathtt{0x00}~{\mathit{ct}}{:}{\mathtt{comptype}} &\Rightarrow& \mathsf{func}~((\mathsf{rec}~(\mathsf{sub}~\mathsf{final}~\epsilon~{\mathit{ct}})) . 0) \\ &&|&
\mathtt{0x01}~{\mathit{tt}}{:}{\mathtt{tabletype}} &\Rightarrow& \mathsf{table}~{\mathit{tt}} \\ &&|&
\mathtt{0x02}~{\mathit{mt}}{:}{\mathtt{memtype}} &\Rightarrow& \mathsf{mem}~{\mathit{mt}} \\ &&|&
\mathtt{0x03}~{\mathit{gt}}{:}{\mathtt{globaltype}} &\Rightarrow& \mathsf{global}~{\mathit{gt}} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{blocktype}} &::=& \mathtt{0x40} &\Rightarrow& \epsilon \\ &&|&
{\mathit{t}}{:}{\mathtt{valtype}} &\Rightarrow& {\mathit{t}} \\ &&|&
{\mathit{i}}{:}{\mathtt{s{\scriptstyle33}}} &\Rightarrow& {\mathit{x}} &\quad
  \mbox{if}~{\mathit{i}} \geq 0 \land {\mathit{i}} = {\mathit{x}} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \mathtt{0x00} &\Rightarrow& \mathsf{unreachable} \\ &&|&
\mathtt{0x01} &\Rightarrow& \mathsf{nop} \\ &&|&
\mathtt{0x02}~{\mathit{bt}}{:}{\mathtt{blocktype}}~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~\mathtt{0x0B} &\Rightarrow& \mathsf{block}~{\mathit{bt}}~{{\mathit{in}}^\ast} \\ &&|&
\mathtt{0x03}~{\mathit{bt}}{:}{\mathtt{blocktype}}~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~\mathtt{0x0B} &\Rightarrow& \mathsf{loop}~{\mathit{bt}}~{{\mathit{in}}^\ast} \\ &&|&
\mathtt{0x04}~{\mathit{bt}}{:}{\mathtt{blocktype}}~{({\mathit{in}}{:}{\mathtt{instr}})^\ast}~\mathtt{0x0B} &\Rightarrow& \mathsf{if}~{\mathit{bt}}~{{\mathit{in}}^\ast}~\mathsf{else}~\epsilon \\ &&|&
\mathtt{0x04}~{\mathit{bt}}{:}{\mathtt{blocktype}}~{({\mathit{in}}_{{1}}{:}{\mathtt{instr}})^\ast}~\mathtt{0x05}~{({\mathit{in}}_{{2}}{:}{\mathtt{instr}})^\ast}~\mathtt{0x0B} &\Rightarrow& \mathsf{if}~{\mathit{bt}}~{{\mathit{in}}_{{1}}^\ast}~\mathsf{else}~{{\mathit{in}}_{{2}}^\ast} \\ &&|&
\mathtt{0x0C}~{\mathit{l}}{:}{\mathtt{labelidx}} &\Rightarrow& \mathsf{br}~{\mathit{l}} \\ &&|&
\mathtt{0x0D}~{\mathit{l}}{:}{\mathtt{labelidx}} &\Rightarrow& \mathsf{br\_if}~{\mathit{l}} \\ &&|&
\mathtt{0x0E}~{{\mathit{l}}^\ast}{:}{\mathtt{vec}}({\mathtt{labelidx}})~{\mathit{l}}_{{\mathit{N}}}{:}{\mathtt{labelidx}} &\Rightarrow& \mathsf{br\_table}~{{\mathit{l}}^\ast}~{\mathit{l}}_{{\mathit{N}}} \\ &&|&
\mathtt{0x0F} &\Rightarrow& \mathsf{return} \\ &&|&
\mathtt{0x10}~{\mathit{x}}{:}{\mathtt{funcidx}} &\Rightarrow& \mathsf{call}~{\mathit{x}} \\ &&|&
\mathtt{0x11}~{\mathit{y}}{:}{\mathtt{typeidx}}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{call\_indirect}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{castop}} &::=& ({\mathit{nul}},\, {\mathit{nul}}) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{castop}} &::=& \mathtt{0x00} &\Rightarrow& (\epsilon,\, \epsilon) \\ &&|&
\mathtt{0x01} &\Rightarrow& (\mathsf{null},\, \epsilon) \\ &&|&
\mathtt{0x02} &\Rightarrow& (\epsilon,\, \mathsf{null}) \\ &&|&
\mathtt{0x03} &\Rightarrow& (\mathsf{null},\, \mathsf{null}) \\
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0xD0}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref.null}~{\mathit{ht}} \\ &&|&
\mathtt{0xD1} &\Rightarrow& \mathsf{ref.is\_null} \\ &&|&
\mathtt{0xD2}~{\mathit{x}}{:}{\mathtt{funcidx}} &\Rightarrow& \mathsf{ref.func}~{\mathit{x}} \\ &&|&
\mathtt{0xD3} &\Rightarrow& \mathsf{ref.eq} \\ &&|&
\mathtt{0xD4} &\Rightarrow& \mathsf{ref.as\_non\_null} \\ &&|&
\mathtt{0xD5}~{\mathit{l}}{:}{\mathtt{labelidx}} &\Rightarrow& \mathsf{br\_on\_null}~{\mathit{l}} \\ &&|&
\mathtt{0xD6}~{\mathit{l}}{:}{\mathtt{labelidx}} &\Rightarrow& \mathsf{br\_on\_non\_null}~{\mathit{l}} \\ &&|&
\mathtt{0xFB}~20{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref.test}~(\mathsf{ref}~{\mathit{ht}}) \\ &&|&
\mathtt{0xFB}~21{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref.test}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \\ &&|&
\mathtt{0xFB}~22{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref.cast}~(\mathsf{ref}~{\mathit{ht}}) \\ &&|&
\mathtt{0xFB}~23{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{ht}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{ref.cast}~(\mathsf{ref}~\mathsf{null}~{\mathit{ht}}) \\ &&|&
\mathtt{0xFB}~24{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{nul}}_{{1}},\, {\mathit{nul}}_{{2}}){:}{\mathtt{castop}}~{\mathit{l}}{:}{\mathtt{labelidx}}~{\mathit{ht}}_{{1}}{:}{\mathtt{heaptype}}~{\mathit{ht}}_{{2}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{br\_on\_cast}~{\mathit{l}}~(\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}})~(\mathsf{ref}~{\mathit{nul}}_{{2}}~{\mathit{ht}}_{{2}}) \\ &&|&
\mathtt{0xFB}~25{:}{\mathtt{u{\scriptstyle32}}}~({\mathit{nul}}_{{1}},\, {\mathit{nul}}_{{2}}){:}{\mathtt{castop}}~{\mathit{l}}{:}{\mathtt{labelidx}}~{\mathit{ht}}_{{1}}{:}{\mathtt{heaptype}}~{\mathit{ht}}_{{2}}{:}{\mathtt{heaptype}} &\Rightarrow& \mathsf{br\_on\_cast\_fail}~{\mathit{l}}~(\mathsf{ref}~{\mathit{nul}}_{{1}}~{\mathit{ht}}_{{1}})~(\mathsf{ref}~{\mathit{nul}}_{{2}}~{\mathit{ht}}_{{2}}) \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0xFB}~0{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{struct.new}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~1{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{struct.new\_default}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~2{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{i}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{struct.get}~{\mathit{x}}~{\mathit{i}} \\ &&|&
\mathtt{0xFB}~3{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{i}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {{\mathsf{struct.get}}{\mathsf{\_}}}{\mathsf{s}}~{\mathit{x}}~{\mathit{i}} \\ &&|&
\mathtt{0xFB}~4{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{i}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {{\mathsf{struct.get}}{\mathsf{\_}}}{\mathsf{u}}~{\mathit{x}}~{\mathit{i}} \\ &&|&
\mathtt{0xFB}~5{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{i}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{struct.set}~{\mathit{x}}~{\mathit{i}} \\ &&|&
\mathtt{0xFB}~6{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{array.new}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~7{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{array.new\_default}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~8{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{array.new\_fixed}~{\mathit{x}}~{\mathit{n}} \\ &&|&
\mathtt{0xFB}~9{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{y}}{:}{\mathtt{dataidx}} &\Rightarrow& \mathsf{array.new\_data}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0xFB}~10{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{y}}{:}{\mathtt{elemidx}} &\Rightarrow& \mathsf{array.new\_elem}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0xFB}~11{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{array.get}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~12{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& {{\mathsf{array.get}}{\mathsf{\_}}}{\mathsf{s}}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~13{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& {{\mathsf{array.get}}{\mathsf{\_}}}{\mathsf{u}}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~14{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{array.set}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~15{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{array.len} \\ &&|&
\mathtt{0xFB}~16{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{array.fill}~{\mathit{x}} \\ &&|&
\mathtt{0xFB}~17{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}_{{1}}{:}{\mathtt{typeidx}}~{\mathit{x}}_{{2}}{:}{\mathtt{typeidx}} &\Rightarrow& \mathsf{array.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} \\ &&|&
\mathtt{0xFB}~18{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{y}}{:}{\mathtt{dataidx}} &\Rightarrow& \mathsf{array.init\_data}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0xFB}~19{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{typeidx}}~{\mathit{y}}{:}{\mathtt{elemidx}} &\Rightarrow& \mathsf{array.init\_elem}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0xFB}~26{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{any.convert\_extern} \\ &&|&
\mathtt{0xFB}~27{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{extern.convert\_any} \\ &&|&
\mathtt{0xFB}~28{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{ref.i{\scriptstyle31}} \\ &&|&
\mathtt{0xFB}~29{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFB}~30{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {{\mathsf{i{\scriptstyle31}.get}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0x1A} &\Rightarrow& \mathsf{drop} \\ &&|&
\mathtt{0x1B} &\Rightarrow& \mathsf{select} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0x20}~{\mathit{x}}{:}{\mathtt{localidx}} &\Rightarrow& \mathsf{local.get}~{\mathit{x}} \\ &&|&
\mathtt{0x21}~{\mathit{x}}{:}{\mathtt{localidx}} &\Rightarrow& \mathsf{local.set}~{\mathit{x}} \\ &&|&
\mathtt{0x22}~{\mathit{x}}{:}{\mathtt{localidx}} &\Rightarrow& \mathsf{local.tee}~{\mathit{x}} \\ &&|&
\mathtt{0x23}~{\mathit{x}}{:}{\mathtt{globalidx}} &\Rightarrow& \mathsf{global.get}~{\mathit{x}} \\ &&|&
\mathtt{0x24}~{\mathit{x}}{:}{\mathtt{globalidx}} &\Rightarrow& \mathsf{global.set}~{\mathit{x}} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0x25}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.get}~{\mathit{x}} \\ &&|&
\mathtt{0x26}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.set}~{\mathit{x}} \\ &&|&
\mathtt{0xFC}~12{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{y}}{:}{\mathtt{elemidx}}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.init}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0xFC}~13{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{elemidx}} &\Rightarrow& \mathsf{elem.drop}~{\mathit{x}} \\ &&|&
\mathtt{0xFC}~14{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}_{{1}}{:}{\mathtt{tableidx}}~{\mathit{x}}_{{2}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} \\ &&|&
\mathtt{0xFC}~15{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.grow}~{\mathit{x}} \\ &&|&
\mathtt{0xFC}~16{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.size}~{\mathit{x}} \\ &&|&
\mathtt{0xFC}~17{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{tableidx}} &\Rightarrow& \mathsf{table.fill}~{\mathit{x}} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{memidxop}} &::=& ({\mathit{memidx}},\, {\mathit{memop}}) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{memop}} &::=& {\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{m}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& (0,\, \{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}},\; \mathsf{offset}~{\mathit{m}} \}\end{array}) &\quad
  \mbox{if}~{\mathit{n}} < {2^{6}} \\ &&|&
{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{memidx}}~{\mathit{m}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& ({\mathit{x}},\, \{ \begin{array}[t]{@{}l@{}}
\mathsf{align}~{\mathit{n}},\; \mathsf{offset}~{\mathit{m}} \}\end{array}) &\quad
  \mbox{if}~{2^{6}} \leq {\mathit{n}} < {2^{7}} \\
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0x28}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{i{\scriptstyle32}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x29}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{i{\scriptstyle64}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2A}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{f{\scriptstyle32}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2B}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{f{\scriptstyle64}}.\mathsf{load}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2C}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{load}}{(8~\mathsf{\_}~\mathsf{s})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2D}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{load}}{(8~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2E}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{load}}{(16~\mathsf{\_}~\mathsf{s})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x2F}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{load}}{(16~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x30}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{(8~\mathsf{\_}~\mathsf{s})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x31}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{(8~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x32}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{(16~\mathsf{\_}~\mathsf{s})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x33}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{(16~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x34}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{(32~\mathsf{\_}~\mathsf{s})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x35}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{load}}{(32~\mathsf{\_}~\mathsf{u})}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x36}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{i{\scriptstyle32}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x37}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{i{\scriptstyle64}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x38}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{f{\scriptstyle32}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x39}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& \mathsf{f{\scriptstyle64}}.\mathsf{store}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x3A}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{store}}{8}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x3B}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{store}}{16}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x3C}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{store}}{8}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x3D}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{store}}{16}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x3E}~({\mathit{x}},\, {\mathit{mo}}){:}{\mathtt{memop}} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{store}}{32}~{\mathit{x}}~{\mathit{mo}} \\ &&|&
\mathtt{0x3F}~{\mathit{x}}{:}{\mathtt{memidx}} &\Rightarrow& \mathsf{memory.size}~{\mathit{x}} \\ &&|&
\mathtt{0x40}~{\mathit{x}}{:}{\mathtt{memidx}} &\Rightarrow& \mathsf{memory.grow}~{\mathit{x}} \\ &&|&
\mathtt{0xFC}~8{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{y}}{:}{\mathtt{dataidx}}~{\mathit{x}}{:}{\mathtt{memidx}} &\Rightarrow& \mathsf{memory.init}~{\mathit{x}}~{\mathit{y}} \\ &&|&
\mathtt{0xFC}~9{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{dataidx}} &\Rightarrow& \mathsf{data.drop}~{\mathit{x}} \\ &&|&
\mathtt{0xFC}~10{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}_{{1}}{:}{\mathtt{memidx}}~{\mathit{x}}_{{2}}{:}{\mathtt{memidx}} &\Rightarrow& \mathsf{memory.copy}~{\mathit{x}}_{{1}}~{\mathit{x}}_{{2}} \\ &&|&
\mathtt{0xFC}~11{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{memidx}} &\Rightarrow& \mathsf{memory.fill}~{\mathit{x}} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0x41}~{\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle32}}.\mathsf{const}~{\mathit{n}} \\ &&|&
\mathtt{0x42}~{\mathit{n}}{:}{\mathtt{u{\scriptstyle64}}} &\Rightarrow& \mathsf{i{\scriptstyle64}}.\mathsf{const}~{\mathit{n}} \\ &&|&
\mathtt{0x45} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{eqz} \\ &&|&
\mathtt{0x46} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{eq} \\ &&|&
\mathtt{0x47} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{ne} \\ &&|&
\mathtt{0x48} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{lt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x49} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{lt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x4A} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{gt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x4B} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{gt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x4C} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{le\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x4D} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{le\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x4E} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{ge\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x4F} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{ge\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x50} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{eqz} \\ &&|&
\mathtt{0x51} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{eq} \\ &&|&
\mathtt{0x52} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{ne} \\ &&|&
\mathtt{0x53} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{lt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x54} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{lt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x55} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{gt\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x56} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{gt\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x57} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{le\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x58} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{le\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x59} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{ge\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x5A} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{ge\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x5B} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{eq} \\ &&|&
\mathtt{0x5C} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{ne} \\ &&|&
\mathtt{0x5D} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{lt} \\ &&|&
\mathtt{0x5E} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{gt} \\ &&|&
\mathtt{0x5F} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{le} \\ &&|&
\mathtt{0x60} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{ge} \\ &&|&
\mathtt{0x61} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{eq} \\ &&|&
\mathtt{0x62} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{ne} \\ &&|&
\mathtt{0x63} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{lt} \\ &&|&
\mathtt{0x64} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{gt} \\ &&|&
\mathtt{0x65} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{le} \\ &&|&
\mathtt{0x66} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{ge} \\ &&|&
\mathtt{0x67} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{clz} \\ &&|&
\mathtt{0x68} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{ctz} \\ &&|&
\mathtt{0x69} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{popcnt} \\ &&|&
\mathtt{0x6A} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{add} \\ &&|&
\mathtt{0x6B} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{sub} \\ &&|&
\mathtt{0x6C} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{mul} \\ &&|&
\mathtt{0x6D} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{div\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x6E} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{div\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x6F} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{rem\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x70} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{rem\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x71} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{and} \\ &&|&
\mathtt{0x72} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{or} \\ &&|&
\mathtt{0x73} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{xor} \\ &&|&
\mathtt{0x74} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{shl} \\ &&|&
\mathtt{0x75} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{shr\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x76} &\Rightarrow& \mathsf{i{\scriptstyle32}} . ({\mathsf{shr\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x77} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{rotl} \\ &&|&
\mathtt{0x78} &\Rightarrow& \mathsf{i{\scriptstyle32}} . \mathsf{rotr} \\ &&|&
\mathtt{0x79} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{clz} \\ &&|&
\mathtt{0x7A} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{ctz} \\ &&|&
\mathtt{0x7B} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{popcnt} \\ &&|&
\mathtt{0x7C} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{add} \\ &&|&
\mathtt{0x7D} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{sub} \\ &&|&
\mathtt{0x7E} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{mul} \\ &&|&
\mathtt{0x7F} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{div\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x80} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{div\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x81} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{rem\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x82} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{rem\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x83} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{and} \\ &&|&
\mathtt{0x84} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{or} \\ &&|&
\mathtt{0x85} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{xor} \\ &&|&
\mathtt{0x86} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{shl} \\ &&|&
\mathtt{0x87} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{shr\_}}{\mathsf{s}}) \\ &&|&
\mathtt{0x88} &\Rightarrow& \mathsf{i{\scriptstyle64}} . ({\mathsf{shr\_}}{\mathsf{u}}) \\ &&|&
\mathtt{0x89} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{rotl} \\ &&|&
\mathtt{0x8A} &\Rightarrow& \mathsf{i{\scriptstyle64}} . \mathsf{rotr} \\ &&|&
\mathtt{0x8B} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{abs} \\ &&|&
\mathtt{0x8C} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{neg} \\ &&|&
\mathtt{0x8D} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{ceil} \\ &&|&
\mathtt{0x8E} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{floor} \\ &&|&
\mathtt{0x8F} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{trunc} \\ &&|&
\mathtt{0x90} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{nearest} \\ &&|&
\mathtt{0x91} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{sqrt} \\ &&|&
\mathtt{0x92} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{add} \\ &&|&
\mathtt{0x93} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{sub} \\ &&|&
\mathtt{0x94} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{mul} \\ &&|&
\mathtt{0x95} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{div} \\ &&|&
\mathtt{0x96} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{min} \\ &&|&
\mathtt{0x97} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{max} \\ &&|&
\mathtt{0x98} &\Rightarrow& \mathsf{f{\scriptstyle32}} . \mathsf{copysign} \\ &&|&
\mathtt{0x99} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{abs} \\ &&|&
\mathtt{0x9A} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{neg} \\ &&|&
\mathtt{0x9B} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{ceil} \\ &&|&
\mathtt{0x9C} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{floor} \\ &&|&
\mathtt{0x9D} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{trunc} \\ &&|&
\mathtt{0x9E} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{nearest} \\ &&|&
\mathtt{0x9F} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{sqrt} \\ &&|&
\mathtt{0xA0} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{add} \\ &&|&
\mathtt{0xA1} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{sub} \\ &&|&
\mathtt{0xA2} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{mul} \\ &&|&
\mathtt{0xA3} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{div} \\ &&|&
\mathtt{0xA4} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{min} \\ &&|&
\mathtt{0xA5} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{max} \\ &&|&
\mathtt{0xA6} &\Rightarrow& \mathsf{f{\scriptstyle64}} . \mathsf{copysign} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{instr}} &::=& \dots \\ &&|&
\mathtt{0xA7} &\Rightarrow& \mathsf{cvtop}~\mathsf{i{\scriptstyle32}}~\mathsf{convert}~\mathsf{i{\scriptstyle64}} \\ &&|&
\mathtt{0xA8} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xA9} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xAA} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xAB} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xAC} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xAD} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xAE} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xAF} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xB0} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xB1} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xB2} &\Rightarrow& \mathsf{f{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xB3} &\Rightarrow& \mathsf{f{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xB4} &\Rightarrow& \mathsf{f{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xB5} &\Rightarrow& \mathsf{f{\scriptstyle32}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xB6} &\Rightarrow& \mathsf{cvtop}~\mathsf{f{\scriptstyle32}}~\mathsf{convert}~\mathsf{f{\scriptstyle64}} \\ &&|&
\mathtt{0xB7} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xB8} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xB9} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xBA} &\Rightarrow& \mathsf{f{\scriptstyle64}} . {{{{\mathsf{convert}}{\mathsf{\_}}}{\mathsf{i{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xBB} &\Rightarrow& \mathsf{cvtop}~\mathsf{f{\scriptstyle64}}~\mathsf{convert}~\mathsf{f{\scriptstyle32}} \\ &&|&
\mathtt{0xBC} &\Rightarrow& \mathsf{cvtop}~\mathsf{i{\scriptstyle32}}~\mathsf{reinterpret}~\mathsf{f{\scriptstyle32}} \\ &&|&
\mathtt{0xBD} &\Rightarrow& \mathsf{cvtop}~\mathsf{i{\scriptstyle64}}~\mathsf{reinterpret}~\mathsf{f{\scriptstyle64}} \\ &&|&
\mathtt{0xBE} &\Rightarrow& \mathsf{cvtop}~\mathsf{f{\scriptstyle32}}~\mathsf{reinterpret}~\mathsf{i{\scriptstyle32}} \\ &&|&
\mathtt{0xBF} &\Rightarrow& \mathsf{cvtop}~\mathsf{f{\scriptstyle64}}~\mathsf{reinterpret}~\mathsf{i{\scriptstyle64}} \\ &&|&
\mathtt{0xFC}~0{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFC}~1{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFC}~2{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFC}~3{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle32}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFC}~4{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFC}~5{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle32}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xFC}~6{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{s}} \\ &&|&
\mathtt{0xFC}~7{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& \mathsf{i{\scriptstyle64}} . {{{{\mathsf{convert\_sat}}{\mathsf{\_}}}{\mathsf{f{\scriptstyle64}}}}{\mathsf{\_}}}{\mathsf{u}} \\ &&|&
\mathtt{0xC0} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{extend}}{8} \\ &&|&
\mathtt{0xC1} &\Rightarrow& {\mathsf{i{\scriptstyle32}}.\mathsf{extend}}{16} \\ &&|&
\mathtt{0xC2} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{extend}}{8} \\ &&|&
\mathtt{0xC3} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{extend}}{16} \\ &&|&
\mathtt{0xC4} &\Rightarrow& {\mathsf{i{\scriptstyle64}}.\mathsf{extend}}{32} \\ &&|&
\dots \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{expr}} &::=& {({\mathit{in}}{:}{\mathtt{instr}})^\ast}~\mathtt{0x0B} &\Rightarrow& {{\mathit{in}}^\ast} \\
\end{array}
$$

\vspace{1ex}

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {{\mathtt{section}}}_{{\mathit{N}}}({\mathtt{X}}) &::=& {\mathit{N}}{:}{\mathtt{byte}}~{\mathit{sz}}{:}{\mathtt{u{\scriptstyle32}}}~{{\mathit{en}}^\ast}{:}{\mathtt{X}} &\Rightarrow& {{\mathit{en}}^\ast} &\quad
  \mbox{if}~{\mathit{sz}} = ||{\mathtt{X}}|| \\ &&|&
\epsilon &\Rightarrow& \epsilon \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{custom}} &::=& {\mathtt{name}}~{{\mathtt{byte}}^\ast} &\Rightarrow& () \\
& {\mathtt{customsec}} &::=& {{\mathtt{section}}}_{0}({\mathtt{custom}}) &\Rightarrow& () \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{type}} &::=& {\mathit{qt}}{:}{\mathtt{rectype}} &\Rightarrow& \mathsf{type}~{\mathit{qt}} \\
& {\mathtt{typesec}} &::=& {{\mathit{ty}}^\ast}{:}{{\mathtt{section}}}_{1}({\mathtt{vec}}({\mathtt{type}})) &\Rightarrow& {{\mathit{ty}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{import}} &::=& {\mathit{nm}}_{{1}}{:}{\mathtt{name}}~{\mathit{nm}}_{{2}}{:}{\mathtt{name}}~{\mathit{xt}}{:}{\mathtt{externtype}} &\Rightarrow& \mathsf{import}~{\mathit{nm}}_{{1}}~{\mathit{nm}}_{{2}}~{\mathit{xt}} \\
& {\mathtt{importsec}} &::=& {{\mathit{im}}^\ast}{:}{{\mathtt{section}}}_{2}({\mathtt{vec}}({\mathtt{import}})) &\Rightarrow& {{\mathit{im}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{funcsec}} &::=& {{\mathit{x}}^\ast}{:}{{\mathtt{section}}}_{3}({\mathtt{vec}}({\mathtt{typeidx}})) &\Rightarrow& {{\mathit{x}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{table}} &::=& {\mathit{tt}}{:}{\mathtt{tabletype}}~{\mathit{e}}{:}{\mathtt{expr}} &\Rightarrow& \mathsf{table}~{\mathit{tt}}~{\mathit{e}} \\
& {\mathtt{tablesec}} &::=& {{\mathit{tab}}^\ast}{:}{{\mathtt{section}}}_{4}({\mathtt{vec}}({\mathtt{table}})) &\Rightarrow& {{\mathit{tab}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{mem}} &::=& {\mathit{mt}}{:}{\mathtt{memtype}} &\Rightarrow& \mathsf{memory}~{\mathit{mt}} \\
& {\mathtt{memsec}} &::=& {{\mathit{mem}}^\ast}{:}{{\mathtt{section}}}_{5}({\mathtt{vec}}({\mathtt{mem}})) &\Rightarrow& {{\mathit{mem}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{global}} &::=& {\mathit{gt}}{:}{\mathtt{globaltype}}~{\mathit{e}}{:}{\mathtt{expr}} &\Rightarrow& \mathsf{global}~{\mathit{gt}}~{\mathit{e}} \\
& {\mathtt{globalsec}} &::=& {{\mathit{glob}}^\ast}{:}{{\mathtt{section}}}_{6}({\mathtt{vec}}({\mathtt{global}})) &\Rightarrow& {{\mathit{glob}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{export}} &::=& {\mathit{nm}}{:}{\mathtt{name}}~{\mathit{ux}}{:}{\mathtt{externidx}} &\Rightarrow& \mathsf{export}~{\mathit{nm}}~{\mathit{ux}} \\
& {\mathtt{exportsec}} &::=& {{\mathit{ex}}^\ast}{:}{{\mathtt{section}}}_{7}({\mathtt{vec}}({\mathtt{export}})) &\Rightarrow& {{\mathit{ex}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{start}} &::=& {\mathit{x}}{:}{\mathtt{funcidx}} &\Rightarrow& (\mathsf{start}~{\mathit{x}}) \\
& {\mathtt{startsec}} &::=& {{\mathit{start}}^\ast}{:}{{\mathtt{section}}}_{8}({\mathtt{start}}) &\Rightarrow& {{\mathit{start}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{elemkind}} &::=& \mathtt{0x00} &\Rightarrow& \mathsf{ref}~\mathsf{null}~\mathsf{func} \\
& {\mathtt{elem}} &::=& 0{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{e}}_{{\mathit{o}}}{:}{\mathtt{expr}}~{{\mathit{y}}^\ast}{:}{\mathtt{vec}}({\mathtt{funcidx}}) &\Rightarrow& \mathsf{elem}~(\mathsf{ref}~\mathsf{null}~\mathsf{func})~{(\mathsf{ref.func}~{\mathit{y}})^\ast}~(\mathsf{active}~0~{\mathit{e}}_{{\mathit{o}}}) \\ &&|&
1{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{rt}}{:}{\mathtt{elemkind}}~{{\mathit{y}}^\ast}{:}{\mathtt{vec}}({\mathtt{funcidx}}) &\Rightarrow& \mathsf{elem}~{\mathit{rt}}~{(\mathsf{ref.func}~{\mathit{y}})^\ast}~\mathsf{passive} \\ &&|&
2{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{tableidx}}~{\mathit{expr}}{:}{\mathtt{expr}}~{\mathit{rt}}{:}{\mathtt{elemkind}}~{{\mathit{y}}^\ast}{:}{\mathtt{vec}}({\mathtt{funcidx}}) &\Rightarrow& \mathsf{elem}~{\mathit{rt}}~{(\mathsf{ref.func}~{\mathit{y}})^\ast}~(\mathsf{active}~{\mathit{x}}~{\mathit{expr}}) \\ &&|&
3{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{rt}}{:}{\mathtt{elemkind}}~{{\mathit{y}}^\ast}{:}{\mathtt{vec}}({\mathtt{funcidx}}) &\Rightarrow& \mathsf{elem}~{\mathit{rt}}~{(\mathsf{ref.func}~{\mathit{y}})^\ast}~\mathsf{declare} \\ &&|&
4{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{e}}_{{\mathit{o}}}{:}{\mathtt{expr}}~{{\mathit{e}}^\ast}{:}{\mathtt{vec}}({\mathtt{expr}}) &\Rightarrow& \mathsf{elem}~(\mathsf{ref}~\mathsf{null}~\mathsf{func})~{{\mathit{e}}^\ast}~(\mathsf{active}~0~{\mathit{e}}_{{\mathit{o}}}) \\ &&|&
5{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{rt}}{:}{\mathtt{reftype}}~{{\mathit{e}}^\ast}{:}{\mathtt{vec}}({\mathtt{expr}}) &\Rightarrow& \mathsf{elem}~{\mathit{rt}}~{{\mathit{e}}^\ast}~\mathsf{passive} \\ &&|&
6{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{tableidx}}~{\mathit{expr}}{:}{\mathtt{expr}}~{{\mathit{e}}^\ast}{:}{\mathtt{vec}}({\mathtt{expr}}) &\Rightarrow& \mathsf{elem}~(\mathsf{ref}~\mathsf{null}~\mathsf{func})~{{\mathit{e}}^\ast}~(\mathsf{active}~{\mathit{x}}~{\mathit{expr}}) \\ &&|&
7{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{rt}}{:}{\mathtt{reftype}}~{{\mathit{e}}^\ast}{:}{\mathtt{vec}}({\mathtt{expr}}) &\Rightarrow& \mathsf{elem}~{\mathit{rt}}~{{\mathit{e}}^\ast}~\mathsf{declare} \\
& {\mathtt{elemsec}} &::=& {{\mathit{elem}}^\ast}{:}{{\mathtt{section}}}_{9}({\mathtt{vec}}({\mathtt{elem}})) &\Rightarrow& {{\mathit{elem}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{concat}}(\epsilon) &=& \epsilon &  \\
{\mathrm{concat}}(({{\mathit{loc}}^\ast})~{({{\mathit{loc}'}^\ast})^\ast}) &=& {{\mathit{loc}}^\ast}~{\mathrm{concat}}({({{\mathit{loc}'}^\ast})^\ast}) &  \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{code}} &::=& ({{\mathit{local}}^\ast},\, {\mathit{expr}}) \\
\end{array}
$$

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{locals}} &::=& {\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{t}}{:}{\mathtt{valtype}} &\Rightarrow& {(\mathsf{local}~{\mathit{t}})^{{\mathit{n}}}} \\
& {\mathtt{func}} &::=& {{{\mathit{local}}^\ast}^\ast}{:}{\mathtt{vec}}({\mathtt{locals}})~{\mathit{expr}}{:}{\mathtt{expr}} &\Rightarrow& ({\mathrm{concat}}({{{\mathit{local}}^\ast}^\ast}),\, {\mathit{expr}}) \\
& {\mathtt{code}} &::=& {\mathit{sz}}{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{code}}{:}{\mathtt{func}} &\Rightarrow& {\mathit{code}} &\quad
  \mbox{if}~{\mathit{sz}} = ||{\mathtt{func}}|| \\
& {\mathtt{codesec}} &::=& {{\mathit{code}}^\ast}{:}{{\mathtt{section}}}_{10}({\mathtt{vec}}({\mathtt{code}})) &\Rightarrow& {{\mathit{code}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{data}} &::=& 0{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{e}}{:}{\mathtt{expr}}~{{\mathit{b}}^\ast}{:}{\mathtt{vec}}({\mathtt{byte}}) &\Rightarrow& \mathsf{data}~{{\mathit{b}}^\ast}~(\mathsf{active}~0~{\mathit{e}}) \\ &&|&
1{:}{\mathtt{u{\scriptstyle32}}}~{{\mathit{b}}^\ast}{:}{\mathtt{vec}}({\mathtt{byte}}) &\Rightarrow& \mathsf{data}~{{\mathit{b}}^\ast}~\mathsf{passive} \\ &&|&
2{:}{\mathtt{u{\scriptstyle32}}}~{\mathit{x}}{:}{\mathtt{memidx}}~{\mathit{e}}{:}{\mathtt{expr}}~{{\mathit{b}}^\ast}{:}{\mathtt{vec}}({\mathtt{byte}}) &\Rightarrow& \mathsf{data}~{{\mathit{b}}^\ast}~(\mathsf{active}~{\mathit{x}}~{\mathit{e}}) \\
& {\mathtt{datasec}} &::=& {{\mathit{data}}^\ast}{:}{{\mathtt{section}}}_{11}({\mathtt{vec}}({\mathtt{data}})) &\Rightarrow& {{\mathit{data}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{datacnt}} &::=& {\mathit{n}}{:}{\mathtt{u{\scriptstyle32}}} &\Rightarrow& {\mathit{n}} \\
& {\mathtt{datacntsec}} &::=& {{\mathit{n}}^\ast}{:}{{\mathtt{section}}}_{12}({\mathtt{datacnt}}) &\Rightarrow& {{\mathit{n}}^\ast} \\
\end{array}
$$

\vspace{1ex}

$$
\begin{array}{@{}l@{}rrlll@{}l@{}}
& {\mathtt{module}} &::=& \mathtt{0x00}~\mathtt{0x61}~\mathtt{0x73}~\mathtt{0x6D}~1{:}{\mathtt{u{\scriptstyle32}}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{type}}^\ast}{:}{\mathtt{typesec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{import}}^\ast}{:}{\mathtt{importsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{typeidx}}^{{\mathit{n}}}}{:}{\mathtt{funcsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{table}}^\ast}{:}{\mathtt{tablesec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{mem}}^\ast}{:}{\mathtt{memsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{global}}^\ast}{:}{\mathtt{globalsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{export}}^\ast}{:}{\mathtt{exportsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{start}}^\ast}{:}{\mathtt{startsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{elem}}^\ast}{:}{\mathtt{elemsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{m}'}^\ast}{:}{\mathtt{datacntsec}}~{{\mathtt{customsec}}^\ast} \\ &&&{({{\mathit{local}}^\ast},\, {\mathit{expr}})^{{\mathit{n}}}}{:}{\mathtt{codesec}}~{{\mathtt{customsec}}^\ast} \\ &&&{{\mathit{data}}^{{\mathit{m}}}}{:}{\mathtt{datasec}}~{{\mathtt{customsec}}^\ast} &\Rightarrow& \mathsf{module}~{{\mathit{type}}^\ast}~{{\mathit{import}}^\ast}~{{\mathit{func}}^{{\mathit{n}}}}~{{\mathit{global}}^\ast}~{{\mathit{table}}^\ast}~{{\mathit{mem}}^\ast}~{{\mathit{elem}}^\ast}~{{\mathit{data}}^{{\mathit{m}}}}~{{\mathit{start}}^\ast}~{{\mathit{export}}^\ast} &\quad
  \mbox{if}~{{\mathit{m}'}^\ast} = \epsilon \lor {\mathrm{free}}_{{\mathit{dataidx}}}({{\mathit{func}}^{{\mathit{n}}}}) = \epsilon \\
 &&&&&&\quad {\land}~{\mathit{m}} = {\mathrm{sum}}({{\mathit{m}'}^\ast}) \\
 &&&&&&\quad {\land}~(({\mathit{func}} = \mathsf{func}~{\mathit{typeidx}}~{{\mathit{local}}^\ast}~{\mathit{expr}}))^\ast \\
\end{array}
$$


== Complete.
```
