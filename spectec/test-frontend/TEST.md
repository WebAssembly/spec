# Test

```sh
$ (dune exec ../src/exe-watsup/main.exe -- test.watsup -o test.tex && cat test.tex)
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
$ (cd ../spec/wasm-3.0 && dune exec ../../src/exe-watsup/main.exe -- *.watsup -v -l --print-il --check)
watsup 0.4 generator
== Parsing...
== Elaboration...

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
  ;; 0-aux.watsup:28.1-28.19
  def {j : nat} min(0, j) = 0
  ;; 0-aux.watsup:29.1-29.19
  def {i : nat} min(i, 0) = 0
  ;; 0-aux.watsup:30.1-30.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 0-aux.watsup:32.1-32.21
rec {

;; 0-aux.watsup:32.1-32.21
def sum : nat* -> nat
  ;; 0-aux.watsup:33.1-33.18
  def sum([]) = 0
  ;; 0-aux.watsup:34.1-34.35
  def {n : n, n'* : n*} sum([n] :: n'*{n'}) = (n + $sum(n'*{n'}))
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

;; 1-syntax.watsup:24.1-24.18
syntax u8 = uN

;; 1-syntax.watsup:25.1-25.20
syntax u31 = uN

;; 1-syntax.watsup:26.1-26.20
syntax u32 = uN

;; 1-syntax.watsup:27.1-27.20
syntax u64 = uN

;; 1-syntax.watsup:28.1-28.22
syntax u128 = uN

;; 1-syntax.watsup:29.1-29.20
syntax s33 = sN

;; 1-syntax.watsup:36.1-36.21
def signif : N -> nat
  ;; 1-syntax.watsup:37.1-37.21
  def signif(32) = 23
  ;; 1-syntax.watsup:38.1-38.21
  def signif(64) = 52

;; 1-syntax.watsup:40.1-40.20
def expon : N -> nat
  ;; 1-syntax.watsup:41.1-41.19
  def expon(32) = 8
  ;; 1-syntax.watsup:42.1-42.20
  def expon(64) = 11

;; 1-syntax.watsup:44.1-44.35
def M : N -> nat
  ;; 1-syntax.watsup:45.1-45.23
  def {N : N} M(N) = $signif(N)

;; 1-syntax.watsup:47.1-47.35
def E : N -> nat
  ;; 1-syntax.watsup:48.1-48.22
  def {N : N} E(N) = $expon(N)

;; 1-syntax.watsup:54.1-58.81
syntax fmag =
  |  {N : N, n : n}NORM(m, n)
    -- if (((2 - (2 ^ ($E(N) - 1))) <= n) /\ (n <= ((2 ^ ($E(N) - 1)) - 1)))
  |  {N : N, n : n}SUBNORM(m, n)
    -- if ((2 - (2 ^ ($E(N) - 1))) = n)
  | INF
  |  {N : N, n : n}NAN(n)
    -- if ((1 <= n) /\ (n < $M(N)))

;; 1-syntax.watsup:50.1-52.34
syntax fN =
  | POS(fmag)
  | NEG(fmag)

;; 1-syntax.watsup:60.1-60.40
def fzero : N -> fN
  ;; 1-syntax.watsup:61.1-61.31
  def {N : N} fzero(N) = POS_fN(NORM_fmag(0, 0))

;; 1-syntax.watsup:63.1-63.20
syntax f32 = fN

;; 1-syntax.watsup:64.1-64.20
syntax f64 = fN

;; 1-syntax.watsup:71.1-71.36
syntax idx = u32

;; 1-syntax.watsup:72.1-72.44
syntax laneidx = u8

;; 1-syntax.watsup:74.1-74.45
syntax typeidx = idx

;; 1-syntax.watsup:75.1-75.49
syntax funcidx = idx

;; 1-syntax.watsup:76.1-76.49
syntax globalidx = idx

;; 1-syntax.watsup:77.1-77.47
syntax tableidx = idx

;; 1-syntax.watsup:78.1-78.46
syntax memidx = idx

;; 1-syntax.watsup:79.1-79.45
syntax elemidx = idx

;; 1-syntax.watsup:80.1-80.45
syntax dataidx = idx

;; 1-syntax.watsup:81.1-81.47
syntax labelidx = idx

;; 1-syntax.watsup:82.1-82.47
syntax localidx = idx

;; 1-syntax.watsup:96.1-96.19
syntax nul = `NULL%?`(()?)

;; 1-syntax.watsup:98.1-99.26
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:101.1-102.9
syntax vectype =
  | V128

;; 1-syntax.watsup:109.1-110.14
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

;; 1-syntax.watsup:134.1-134.18
syntax mut = `MUT%?`(()?)

;; 1-syntax.watsup:135.1-135.20
syntax fin = `FINAL%?`(()?)

;; 1-syntax.watsup:121.1-171.54
rec {

;; 1-syntax.watsup:121.1-122.14
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | REF(nul, heaptype)
  | BOT

;; 1-syntax.watsup:128.1-129.11
syntax resulttype = valtype*

;; 1-syntax.watsup:140.1-141.25
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

;; 1-syntax.watsup:143.1-144.18
syntax fieldtype = `%%`(mut, storagetype)

;; 1-syntax.watsup:146.1-147.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:149.1-152.18
syntax comptype =
  | STRUCT(fieldtype*)
  | ARRAY(fieldtype)
  | FUNC(functype)

;; 1-syntax.watsup:158.1-159.17
syntax rectype =
  | REC(subtype*)

;; 1-syntax.watsup:164.1-167.12
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

;; 1-syntax.watsup:169.1-171.54
syntax subtype =
  | SUB(fin, typeidx*, comptype)
  | SUBD(fin, heaptype*, comptype)
}

;; 1-syntax.watsup:116.1-117.21
syntax reftype =
  | REF(nul, heaptype)

;; 1-syntax.watsup:124.1-124.40
syntax inn =
  | I32
  | I64

;; 1-syntax.watsup:125.1-125.40
syntax fnn =
  | F32
  | F64

;; 1-syntax.watsup:137.1-138.13
syntax packedtype =
  | I8
  | I16

;; 1-syntax.watsup:161.1-162.35
syntax deftype =
  | DEF(rectype, nat)

;; 1-syntax.watsup:176.1-177.16
syntax limits = `[%..%]`(u32, u32)

;; 1-syntax.watsup:179.1-180.14
syntax globaltype = `%%`(mut, valtype)

;; 1-syntax.watsup:181.1-182.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:183.1-184.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:185.1-186.10
syntax elemtype = reftype

;; 1-syntax.watsup:187.1-188.5
syntax datatype = OK

;; 1-syntax.watsup:189.1-190.69
syntax externtype =
  | FUNC(deftype)
  | GLOBAL(globaltype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:227.1-227.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:229.1-229.36
syntax iunop =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:230.1-230.67
syntax funop =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:232.1-234.66
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

;; 1-syntax.watsup:235.1-235.63
syntax fbinop =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:237.1-237.23
syntax itestop =
  | EQZ

;; 1-syntax.watsup:238.1-238.19
syntax ftestop =
  |

;; 1-syntax.watsup:240.1-241.112
syntax irelop =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:242.1-242.46
syntax frelop =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:245.1-245.44
syntax unop_numtype =
  | _I(iunop)
  | _F(funop)

;; 1-syntax.watsup:246.1-246.47
syntax binop_numtype =
  | _I(ibinop)
  | _F(fbinop)

;; 1-syntax.watsup:247.1-247.50
syntax testop_numtype =
  | _I(itestop)
  | _F(ftestop)

;; 1-syntax.watsup:248.1-248.47
syntax relop_numtype =
  | _I(irelop)
  | _F(frelop)

;; 1-syntax.watsup:249.1-249.53
syntax cvtop =
  | CONVERT
  | REINTERPRET
  | CONVERT_SAT

;; 1-syntax.watsup:259.1-259.24
syntax unopVVXX =
  | NOT

;; 1-syntax.watsup:260.1-260.45
syntax binopVVXX =
  | AND
  | ANDNOT
  | OR
  | XOR

;; 1-syntax.watsup:261.1-261.32
syntax ternopVVXX =
  | BITSELECT

;; 1-syntax.watsup:262.1-262.31
syntax testopVVXX =
  | ANY_TRUE

;; 1-syntax.watsup:263.1-263.31
syntax testopVIXX =
  | ALL_TRUE

;; 1-syntax.watsup:264.1-264.61
syntax relopVIXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:265.1-265.49
syntax relopVFXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:266.1-266.30
syntax unopVIXX =
  | ABS
  | NEG

;; 1-syntax.watsup:267.1-267.41
syntax binopVIXX =
  | ADD
  | SUB
  | SWIZZLE

;; 1-syntax.watsup:268.1-268.40
syntax minmaxopVIXX =
  | MIN(sx)
  | MAX(sx)

;; 1-syntax.watsup:269.1-269.48
syntax satbinopVIXX =
  | ADD_SAT(sx)
  | SUB_SAT(sx)

;; 1-syntax.watsup:270.1-270.36
syntax shiftopVIXX =
  | SHL
  | SHR(sx)

;; 1-syntax.watsup:271.1-271.70
syntax unopVFXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:272.1-272.69
syntax binopVFXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | PMIN
  | PMAX

;; 1-syntax.watsup:274.1-274.36
syntax viunop =
  | ABS
  | NEG
  | POPCNT

;; 1-syntax.watsup:275.1-275.90
syntax vibinop =
  | ADD
  | SUB
  | SWIZZLE
  | MIN(sx)
  | MAX(sx)
  | ADD_SAT(sx)
  | SUB_SAT(sx)
  | MUL
  | AVGR_U
  | Q15MULR_SAT_S

;; 1-syntax.watsup:277.1-277.38
syntax unop_vvectype =
  | _VV(unopVVXX)

;; 1-syntax.watsup:278.1-278.40
syntax binop_vvectype =
  | _VV(binopVVXX)

;; 1-syntax.watsup:279.1-279.42
syntax ternop_vvectype =
  | _VV(ternopVVXX)

;; 1-syntax.watsup:280.1-280.42
syntax testop_vvectype =
  | _VV(testopVVXX)

;; 1-syntax.watsup:282.1-282.43
syntax shiftop_vectype =
  | _VI(shiftopVIXX)

;; 1-syntax.watsup:283.1-283.50
syntax unop_vectype =
  | _VI(viunop)
  | _VF(unopVFXX)

;; 1-syntax.watsup:284.1-284.53
syntax binop_vectype =
  | _VI(vibinop)
  | _VF(binopVFXX)

;; 1-syntax.watsup:285.1-285.41
syntax testop_vectype =
  | _VI(testopVIXX)

;; 1-syntax.watsup:286.1-286.55
syntax relop_vectype =
  | _VI(relopVIXX)
  | _VF(relopVFXX)

;; 1-syntax.watsup:287.1-287.73
syntax cvtop_vectype =
  | EXTEND
  | TRUNC_SAT
  | CONVERT
  | DEMOTE
  | PROMOTE

;; 1-syntax.watsup:305.1-305.68
syntax memop = {ALIGN u32, OFFSET u32}

;; 1-syntax.watsup:315.1-315.15
syntax c = nat

;; 1-syntax.watsup:316.1-316.23
syntax c_numtype = nat

;; 1-syntax.watsup:317.1-317.23
syntax c_vectype = nat

;; 1-syntax.watsup:320.1-322.17
syntax blocktype =
  | _RESULT(valtype?)
  | _IDX(funcidx)

;; 1-syntax.watsup:363.1-363.27
syntax half =
  | LOW
  | HIGH

;; 1-syntax.watsup:361.1-361.45
syntax lanesize = nat

;; 1-syntax.watsup:360.1-360.64
syntax lanetype =
  | I8
  | I16
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:362.1-362.54
syntax shape = `%X%`(lanetype, lanesize)

;; 1-syntax.watsup:452.1-452.29
syntax packshape = `%X%`(nat, nat)

;; 1-syntax.watsup:453.1-456.44
syntax vloadop =
  | SHAPE(packshape, sx)
  | SPLAT(nat)
  | ZERO(nat)

;; 1-syntax.watsup:364.1-364.20
syntax zero = `ZERO%?`(()?)

;; 1-syntax.watsup:458.1-470.78
rec {

;; 1-syntax.watsup:458.1-470.78
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
  | VVCONST(vectype, c_vectype)
  | VVUNOP(vectype, unop_vvectype)
  | VVBINOP(vectype, binop_vvectype)
  | VVTERNOP(vectype, ternop_vvectype)
  | VVTESTOP(vectype, testop_vvectype)
  | VSWIZZLE(shape)
  | VSHUFFLE(shape, laneidx*)
  | VSPLAT(shape)
  | VEXTRACT_LANE(shape, sx?, laneidx)
  | VREPLACE_LANE(shape, laneidx)
  | VUNOP(shape, unop_vectype)
  | VBINOP(shape, binop_vectype)
  | VRELOP(shape, relop_vectype)
  | VISHIFTOP(shape, shiftop_vectype)
  | VALL_TRUE(shape)
  | VBITMASK(shape)
  | VNARROW(shape, shape, sx)
  | VCVTOP(shape, cvtop_vectype, half?, shape, sx?, zero)
  | VEXTMUL(shape, half, shape, sx)
  | VDOT(shape, shape, sx)
  | VEXTADD_PAIRWISE(shape, shape, sx)
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
  | VLOAD(vloadop?, memidx, memop)
  | VLOAD_LANE(n, memidx, memop, laneidx)
  | VSTORE(memidx, memop)
  | VSTORE_LANE(n, memidx, memop, laneidx)
}

;; 1-syntax.watsup:472.1-473.9
syntax expr = instr*

;; 1-syntax.watsup:485.1-485.61
syntax elemmode =
  | ACTIVE(tableidx, expr)
  | PASSIVE
  | DECLARE

;; 1-syntax.watsup:486.1-486.49
syntax datamode =
  | ACTIVE(memidx, expr)
  | PASSIVE

;; 1-syntax.watsup:488.1-489.15
syntax type = TYPE(rectype)

;; 1-syntax.watsup:490.1-491.16
syntax local = LOCAL(valtype)

;; 1-syntax.watsup:492.1-493.27
syntax func = `FUNC%%*%`(typeidx, local*, expr)

;; 1-syntax.watsup:494.1-495.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:496.1-497.23
syntax table = TABLE(tabletype, expr)

;; 1-syntax.watsup:498.1-499.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:500.1-501.30
syntax elem = `ELEM%%*%`(reftype, expr*, elemmode)

;; 1-syntax.watsup:502.1-503.22
syntax data = `DATA%*%`(byte*, datamode)

;; 1-syntax.watsup:504.1-505.16
syntax start = START(funcidx)

;; 1-syntax.watsup:507.1-508.66
syntax externidx =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:509.1-510.24
syntax export = EXPORT(name, externidx)

;; 1-syntax.watsup:511.1-512.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:514.1-515.76
syntax module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*, import*, func*, global*, table*, mem*, elem*, data*, start*, export*)

;; 2-syntax-aux.watsup:8.1-8.33
rec {

;; 2-syntax-aux.watsup:8.1-8.33
def setminus1 : (idx, idx*) -> idx*
  ;; 2-syntax-aux.watsup:13.1-13.27
  def {x : idx} setminus1(x, []) = [x]
  ;; 2-syntax-aux.watsup:14.1-14.61
  def {x : idx, y* : idx*, y_1 : idx} setminus1(x, [y_1] :: y*{y}) = []
    -- if (x = y_1)
  ;; 2-syntax-aux.watsup:15.1-15.60
  def {x : idx, y* : idx*, y_1 : idx} setminus1(x, [y_1] :: y*{y}) = $setminus1(x, y*{y})
    -- otherwise
}

;; 2-syntax-aux.watsup:7.1-7.49
rec {

;; 2-syntax-aux.watsup:7.1-7.49
def setminus : (idx*, idx*) -> idx*
  ;; 2-syntax-aux.watsup:10.1-10.29
  def {y* : idx*} setminus([], y*{y}) = []
  ;; 2-syntax-aux.watsup:11.1-11.66
  def {x* : idx*, x_1 : idx, y* : idx*} setminus([x_1] :: x*{x}, y*{y}) = $setminus1(x_1, y*{y}) :: $setminus(x*{x}, y*{y})
}

;; 2-syntax-aux.watsup:20.1-20.71
def free_dataidx_instr : instr -> dataidx*
  ;; 2-syntax-aux.watsup:21.1-21.45
  def {x : idx, y : idx} free_dataidx_instr(MEMORY.INIT_instr(x, y)) = [y]
  ;; 2-syntax-aux.watsup:22.1-22.41
  def {x : idx} free_dataidx_instr(DATA.DROP_instr(x)) = [x]
  ;; 2-syntax-aux.watsup:23.1-23.34
  def {in : instr} free_dataidx_instr(in) = []

;; 2-syntax-aux.watsup:25.1-25.73
rec {

;; 2-syntax-aux.watsup:25.1-25.73
def free_dataidx_instrs : instr* -> dataidx*
  ;; 2-syntax-aux.watsup:26.1-26.36
  def free_dataidx_instrs([]) = []
  ;; 2-syntax-aux.watsup:27.1-27.99
  def {instr : instr, instr'* : instr*} free_dataidx_instrs([instr] :: instr'*{instr'}) = $free_dataidx_instr(instr) :: $free_dataidx_instrs(instr'*{instr'})
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
  ;; 2-syntax-aux.watsup:36.1-36.35
  def free_dataidx_funcs([]) = []
  ;; 2-syntax-aux.watsup:37.1-37.92
  def {func : func, func'* : func*} free_dataidx_funcs([func] :: func'*{func'}) = $free_dataidx_func(func) :: $free_dataidx_funcs(func'*{func'})
}

;; 2-syntax-aux.watsup:46.1-46.59
rec {

;; 2-syntax-aux.watsup:46.1-46.59
def concat_bytes : byte** -> byte*
  ;; 2-syntax-aux.watsup:47.1-47.29
  def concat_bytes([]) = []
  ;; 2-syntax-aux.watsup:48.1-48.58
  def {b* : byte*, b'** : byte**} concat_bytes([b*{b}] :: b'*{b'}*{b'}) = b*{b} :: $concat_bytes(b'*{b'}*{b'})
}

;; 2-syntax-aux.watsup:59.1-59.55
def size : valtype -> nat
  ;; 2-syntax-aux.watsup:60.1-60.20
  def size(I32_valtype) = 32
  ;; 2-syntax-aux.watsup:61.1-61.20
  def size(I64_valtype) = 64
  ;; 2-syntax-aux.watsup:62.1-62.20
  def size(F32_valtype) = 32
  ;; 2-syntax-aux.watsup:63.1-63.20
  def size(F64_valtype) = 64
  ;; 2-syntax-aux.watsup:64.1-64.22
  def size(V128_valtype) = 128

;; 2-syntax-aux.watsup:66.1-66.50
def packedsize : packedtype -> nat
  ;; 2-syntax-aux.watsup:67.1-67.24
  def packedsize(I8_packedtype) = 8
  ;; 2-syntax-aux.watsup:68.1-68.26
  def packedsize(I16_packedtype) = 16

;; 2-syntax-aux.watsup:70.1-70.52
def storagesize : storagetype -> nat
  ;; 2-syntax-aux.watsup:71.1-71.43
  def {valtype : valtype} storagesize(valtype <: storagetype) = $size(valtype)
  ;; 2-syntax-aux.watsup:72.1-72.55
  def {packedtype : packedtype} storagesize(packedtype <: storagetype) = $packedsize(packedtype)

;; 2-syntax-aux.watsup:74.1-74.46
def lanesize : lanetype -> nat
  ;; 2-syntax-aux.watsup:75.1-75.40
  def {numtype : numtype} lanesize(numtype <: lanetype) = $size(numtype <: valtype)
  ;; 2-syntax-aux.watsup:76.1-76.52
  def {packedtype : packedtype} lanesize(packedtype <: lanetype) = $packedsize(packedtype)

;; 2-syntax-aux.watsup:81.1-81.62
def unpacktype : storagetype -> valtype
  ;; 2-syntax-aux.watsup:82.1-82.35
  def {valtype : valtype} unpacktype(valtype <: storagetype) = valtype
  ;; 2-syntax-aux.watsup:83.1-83.34
  def {packedtype : packedtype} unpacktype(packedtype <: storagetype) = I32_valtype

;; 2-syntax-aux.watsup:85.1-85.65
def unpacknumtype : storagetype -> numtype
  ;; 2-syntax-aux.watsup:86.1-86.38
  def {numtype : numtype} unpacknumtype(numtype <: storagetype) = numtype
  ;; 2-syntax-aux.watsup:87.1-87.37
  def {packedtype : packedtype} unpacknumtype(packedtype <: storagetype) = I32_numtype

;; 2-syntax-aux.watsup:89.1-89.51
def sxfield : storagetype -> sx?
  ;; 2-syntax-aux.watsup:90.1-90.28
  def {valtype : valtype} sxfield(valtype <: storagetype) = ?()
  ;; 2-syntax-aux.watsup:91.1-91.29
  def {packedtype : packedtype} sxfield(packedtype <: storagetype) = ?(S_sx)

;; 2-syntax-aux.watsup:96.1-96.59
def diffrt : (reftype, reftype) -> reftype
  ;; 2-syntax-aux.watsup:98.1-98.64
  def {ht_1 : heaptype, ht_2 : heaptype, nul_1 : nul} diffrt(REF_reftype(nul_1, ht_1), REF_reftype(`NULL%?`(?(())), ht_2)) = REF_reftype(`NULL%?`(?()), ht_1)
  ;; 2-syntax-aux.watsup:99.1-99.65
  def {ht_1 : heaptype, ht_2 : heaptype, nul_1 : nul} diffrt(REF_reftype(nul_1, ht_1), REF_reftype(`NULL%?`(?()), ht_2)) = REF_reftype(nul_1, ht_1)

;; 2-syntax-aux.watsup:104.1-104.42
syntax typevar =
  | _IDX(typeidx)
  | REC(nat)

;; 2-syntax-aux.watsup:107.1-107.42
def idx : typeidx -> typevar
  ;; 2-syntax-aux.watsup:108.1-108.21
  def {x : idx} idx(x) = _IDX_typevar(x)

;; 2-syntax-aux.watsup:113.1-113.92
rec {

;; 2-syntax-aux.watsup:113.1-113.92
def subst_typevar : (typevar, typevar*, heaptype*) -> heaptype
  ;; 2-syntax-aux.watsup:138.1-138.38
  def {xx : typevar} subst_typevar(xx, [], []) = (xx <: heaptype)
  ;; 2-syntax-aux.watsup:139.1-139.95
  def {ht'* : heaptype*, ht_1 : heaptype, xx : typevar, xx'* : typevar*, xx_1 : typevar} subst_typevar(xx, [xx_1] :: xx'*{xx'}, [ht_1] :: ht'*{ht'}) = ht_1
    -- if (xx = xx_1)
  ;; 2-syntax-aux.watsup:140.1-140.92
  def {ht'* : heaptype*, ht_1 : heaptype, xx : typevar, xx'* : typevar*, xx_1 : typevar} subst_typevar(xx, [xx_1] :: xx'*{xx'}, [ht_1] :: ht'*{ht'}) = $subst_typevar(xx, xx'*{xx'}, ht'*{ht'})
    -- otherwise
}

;; 2-syntax-aux.watsup:115.1-115.92
def subst_numtype : (numtype, typevar*, heaptype*) -> numtype
  ;; 2-syntax-aux.watsup:142.1-142.38
  def {ht* : heaptype*, nt : numtype, xx* : typevar*} subst_numtype(nt, xx*{xx}, ht*{ht}) = nt

;; 2-syntax-aux.watsup:116.1-116.92
def subst_vectype : (vectype, typevar*, heaptype*) -> vectype
  ;; 2-syntax-aux.watsup:143.1-143.38
  def {ht* : heaptype*, vt : vectype, xx* : typevar*} subst_vectype(vt, xx*{xx}, ht*{ht}) = vt

;; 2-syntax-aux.watsup:121.1-121.92
def subst_packedtype : (packedtype, typevar*, heaptype*) -> packedtype
  ;; 2-syntax-aux.watsup:156.1-156.41
  def {ht* : heaptype*, pt : packedtype, xx* : typevar*} subst_packedtype(pt, xx*{xx}, ht*{ht}) = pt

;; 2-syntax-aux.watsup:117.1-131.92
rec {

;; 2-syntax-aux.watsup:117.1-117.92
def subst_heaptype : (heaptype, typevar*, heaptype*) -> heaptype
  ;; 2-syntax-aux.watsup:145.1-145.67
  def {ht* : heaptype*, xx* : typevar*, xx' : typevar} subst_heaptype((xx' <: heaptype), xx*{xx}, ht*{ht}) = $subst_typevar(xx', xx*{xx}, ht*{ht})
  ;; 2-syntax-aux.watsup:146.1-146.65
  def {dt : deftype, ht* : heaptype*, xx* : typevar*} subst_heaptype((dt <: heaptype), xx*{xx}, ht*{ht}) = ($subst_deftype(dt, xx*{xx}, ht*{ht}) <: heaptype)
  ;; 2-syntax-aux.watsup:147.1-147.55
  def {ht* : heaptype*, ht' : heaptype, xx* : typevar*} subst_heaptype(ht', xx*{xx}, ht*{ht}) = ht'
    -- otherwise

;; 2-syntax-aux.watsup:118.1-118.92
def subst_reftype : (reftype, typevar*, heaptype*) -> reftype
  ;; 2-syntax-aux.watsup:149.1-149.85
  def {ht* : heaptype*, ht' : heaptype, nul : nul, xx* : typevar*} subst_reftype(REF_reftype(nul, ht'), xx*{xx}, ht*{ht}) = REF_reftype(nul, $subst_heaptype(ht', xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:119.1-119.92
def subst_valtype : (valtype, typevar*, heaptype*) -> valtype
  ;; 2-syntax-aux.watsup:151.1-151.64
  def {ht* : heaptype*, nt : numtype, xx* : typevar*} subst_valtype((nt <: valtype), xx*{xx}, ht*{ht}) = ($subst_numtype(nt, xx*{xx}, ht*{ht}) <: valtype)
  ;; 2-syntax-aux.watsup:152.1-152.64
  def {ht* : heaptype*, vt : vectype, xx* : typevar*} subst_valtype((vt <: valtype), xx*{xx}, ht*{ht}) = ($subst_vectype(vt, xx*{xx}, ht*{ht}) <: valtype)
  ;; 2-syntax-aux.watsup:153.1-153.64
  def {ht* : heaptype*, rt : reftype, xx* : typevar*} subst_valtype((rt <: valtype), xx*{xx}, ht*{ht}) = ($subst_reftype(rt, xx*{xx}, ht*{ht}) <: valtype)
  ;; 2-syntax-aux.watsup:154.1-154.40
  def {ht* : heaptype*, xx* : typevar*} subst_valtype(BOT_valtype, xx*{xx}, ht*{ht}) = BOT_valtype

;; 2-syntax-aux.watsup:122.1-122.92
def subst_storagetype : (storagetype, typevar*, heaptype*) -> storagetype
  ;; 2-syntax-aux.watsup:158.1-158.66
  def {ht* : heaptype*, t : valtype, xx* : typevar*} subst_storagetype((t <: storagetype), xx*{xx}, ht*{ht}) = ($subst_valtype(t, xx*{xx}, ht*{ht}) <: storagetype)
  ;; 2-syntax-aux.watsup:159.1-159.71
  def {ht* : heaptype*, pt : packedtype, xx* : typevar*} subst_storagetype((pt <: storagetype), xx*{xx}, ht*{ht}) = ($subst_packedtype(pt, xx*{xx}, ht*{ht}) <: storagetype)

;; 2-syntax-aux.watsup:123.1-123.92
def subst_fieldtype : (fieldtype, typevar*, heaptype*) -> fieldtype
  ;; 2-syntax-aux.watsup:161.1-161.80
  def {ht* : heaptype*, mut : mut, xx* : typevar*, zt : storagetype} subst_fieldtype(`%%`(mut, zt), xx*{xx}, ht*{ht}) = `%%`(mut, $subst_storagetype(zt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:125.1-125.92
def subst_comptype : (comptype, typevar*, heaptype*) -> comptype
  ;; 2-syntax-aux.watsup:163.1-163.85
  def {ht* : heaptype*, xx* : typevar*, yt* : fieldtype*} subst_comptype(STRUCT_comptype(yt*{yt}), xx*{xx}, ht*{ht}) = STRUCT_comptype($subst_fieldtype(yt, xx*{xx}, ht*{ht})*{yt})
  ;; 2-syntax-aux.watsup:164.1-164.81
  def {ht* : heaptype*, xx* : typevar*, yt : fieldtype} subst_comptype(ARRAY_comptype(yt), xx*{xx}, ht*{ht}) = ARRAY_comptype($subst_fieldtype(yt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:165.1-165.78
  def {ft : functype, ht* : heaptype*, xx* : typevar*} subst_comptype(FUNC_comptype(ft), xx*{xx}, ht*{ht}) = FUNC_comptype($subst_functype(ft, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:126.1-126.92
def subst_subtype : (subtype, typevar*, heaptype*) -> subtype
  ;; 2-syntax-aux.watsup:167.1-168.76
  def {ct : comptype, fin : fin, ht* : heaptype*, xx* : typevar*, y* : idx*} subst_subtype(SUB_subtype(fin, y*{y}, ct), xx*{xx}, ht*{ht}) = SUBD_subtype(fin, $subst_heaptype(_IDX_heaptype(y), xx*{xx}, ht*{ht})*{y}, $subst_comptype(ct, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:169.1-170.73
  def {ct : comptype, fin : fin, ht* : heaptype*, ht'* : heaptype*, xx* : typevar*} subst_subtype(SUBD_subtype(fin, ht'*{ht'}, ct), xx*{xx}, ht*{ht}) = SUBD_subtype(fin, $subst_heaptype(ht', xx*{xx}, ht*{ht})*{ht'}, $subst_comptype(ct, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:127.1-127.92
def subst_rectype : (rectype, typevar*, heaptype*) -> rectype
  ;; 2-syntax-aux.watsup:172.1-172.76
  def {ht* : heaptype*, st* : subtype*, xx* : typevar*} subst_rectype(REC_rectype(st*{st}), xx*{xx}, ht*{ht}) = REC_rectype($subst_subtype(st, xx*{xx}, ht*{ht})*{st})

;; 2-syntax-aux.watsup:128.1-128.92
def subst_deftype : (deftype, typevar*, heaptype*) -> deftype
  ;; 2-syntax-aux.watsup:174.1-174.78
  def {ht* : heaptype*, i : nat, qt : rectype, xx* : typevar*} subst_deftype(DEF_deftype(qt, i), xx*{xx}, ht*{ht}) = DEF_deftype($subst_rectype(qt, xx*{xx}, ht*{ht}), i)

;; 2-syntax-aux.watsup:131.1-131.92
def subst_functype : (functype, typevar*, heaptype*) -> functype
  ;; 2-syntax-aux.watsup:177.1-177.113
  def {ht* : heaptype*, t_1* : valtype*, t_2* : valtype*, xx* : typevar*} subst_functype(`%->%`(t_1*{t_1}, t_2*{t_2}), xx*{xx}, ht*{ht}) = `%->%`($subst_valtype(t_1, xx*{xx}, ht*{ht})*{t_1}, $subst_valtype(t_2, xx*{xx}, ht*{ht})*{t_2})
}

;; 2-syntax-aux.watsup:130.1-130.92
def subst_globaltype : (globaltype, typevar*, heaptype*) -> globaltype
  ;; 2-syntax-aux.watsup:176.1-176.75
  def {ht* : heaptype*, mut : mut, t : valtype, xx* : typevar*} subst_globaltype(`%%`(mut, t), xx*{xx}, ht*{ht}) = `%%`(mut, $subst_valtype(t, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:132.1-132.92
def subst_tabletype : (tabletype, typevar*, heaptype*) -> tabletype
  ;; 2-syntax-aux.watsup:179.1-179.76
  def {ht* : heaptype*, lim : limits, rt : reftype, xx* : typevar*} subst_tabletype(`%%`(lim, rt), xx*{xx}, ht*{ht}) = `%%`(lim, $subst_reftype(rt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:133.1-133.92
def subst_memtype : (memtype, typevar*, heaptype*) -> memtype
  ;; 2-syntax-aux.watsup:178.1-178.48
  def {ht* : heaptype*, lim : limits, xx* : typevar*} subst_memtype(`%I8`(lim), xx*{xx}, ht*{ht}) = `%I8`(lim)

;; 2-syntax-aux.watsup:135.1-135.92
def subst_externtype : (externtype, typevar*, heaptype*) -> externtype
  ;; 2-syntax-aux.watsup:181.1-181.79
  def {dt : deftype, ht* : heaptype*, xx* : typevar*} subst_externtype(FUNC_externtype(dt), xx*{xx}, ht*{ht}) = FUNC_externtype($subst_deftype(dt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:182.1-182.86
  def {gt : globaltype, ht* : heaptype*, xx* : typevar*} subst_externtype(GLOBAL_externtype(gt), xx*{xx}, ht*{ht}) = GLOBAL_externtype($subst_globaltype(gt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:183.1-183.83
  def {ht* : heaptype*, tt : tabletype, xx* : typevar*} subst_externtype(TABLE_externtype(tt), xx*{xx}, ht*{ht}) = TABLE_externtype($subst_tabletype(tt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:184.1-184.77
  def {ht* : heaptype*, mt : memtype, xx* : typevar*} subst_externtype(MEM_externtype(mt), xx*{xx}, ht*{ht}) = MEM_externtype($subst_memtype(mt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:187.1-187.74
def subst_all_reftype : (reftype, heaptype*) -> reftype
  ;; 2-syntax-aux.watsup:190.1-190.75
  def {ht^n : heaptype^n, n : n, rt : reftype, x^n : idx^n} subst_all_reftype(rt, ht^n{ht}) = $subst_reftype(rt, $idx(x)^(x<n){x}, ht^n{ht})

;; 2-syntax-aux.watsup:188.1-188.74
def subst_all_deftype : (deftype, heaptype*) -> deftype
  ;; 2-syntax-aux.watsup:191.1-191.75
  def {dt : deftype, ht^n : heaptype^n, n : n, x^n : idx^n} subst_all_deftype(dt, ht^n{ht}) = $subst_deftype(dt, $idx(x)^(x<n){x}, ht^n{ht})

;; 2-syntax-aux.watsup:193.1-193.77
rec {

;; 2-syntax-aux.watsup:193.1-193.77
def subst_all_deftypes : (deftype*, heaptype*) -> deftype*
  ;; 2-syntax-aux.watsup:195.1-195.40
  def {ht* : heaptype*} subst_all_deftypes([], ht*{ht}) = []
  ;; 2-syntax-aux.watsup:196.1-196.101
  def {dt* : deftype*, dt_1 : deftype, ht* : heaptype*} subst_all_deftypes([dt_1] :: dt*{dt}, ht*{ht}) = [$subst_all_deftype(dt_1, ht*{ht})] :: $subst_all_deftypes(dt*{dt}, ht*{ht})
}

;; 2-syntax-aux.watsup:201.1-201.65
def rollrt : (typeidx, rectype) -> rectype
  ;; 2-syntax-aux.watsup:210.1-210.93
  def {i^n : nat^n, n : n, st^n : subtype^n, x : idx} rollrt(x, REC_rectype(st^n{st})) = REC_rectype($subst_subtype(st, $idx(x + i)^(i<n){i}, REC_heaptype(i)^(i<n){i})^n{st})

;; 2-syntax-aux.watsup:202.1-202.63
def unrollrt : rectype -> rectype
  ;; 2-syntax-aux.watsup:211.1-212.22
  def {i^n : nat^n, n : n, qt : rectype, st^n : subtype^n} unrollrt(REC_rectype(st^n{st})) = REC_rectype($subst_subtype(st, REC_typevar(i)^(i<n){i}, DEF_heaptype(qt, i)^(i<n){i})^n{st})
    -- if (qt = REC_rectype(st^n{st}))

;; 2-syntax-aux.watsup:203.1-203.65
def rolldt : (typeidx, rectype) -> deftype*
  ;; 2-syntax-aux.watsup:214.1-214.79
  def {i^n : nat^n, n : n, qt : rectype, st^n : subtype^n, x : idx} rolldt(x, qt) = DEF_deftype(REC_rectype(st^n{st}), i)^(i<n){i}
    -- if ($rollrt(x, qt) = REC_rectype(st^n{st}))

;; 2-syntax-aux.watsup:204.1-204.63
def unrolldt : deftype -> subtype
  ;; 2-syntax-aux.watsup:215.1-215.77
  def {i : nat, qt : rectype, st* : subtype*} unrolldt(DEF_deftype(qt, i)) = st*{st}[i]
    -- if ($unrollrt(qt) = REC_rectype(st*{st}))

;; 2-syntax-aux.watsup:205.1-205.63
def expanddt : deftype -> comptype
  ;; 2-syntax-aux.watsup:217.1-217.85
  def {ct : comptype, dt : deftype, fin : fin, ht* : heaptype*} expanddt(dt) = ct
    -- if ($unrolldt(dt) = SUBD_subtype(fin, ht*{ht}, ct))

;; 2-syntax-aux.watsup:219.1-219.37
relation Expand: `%~~%`(deftype, comptype)
  ;; 2-syntax-aux.watsup:220.1-220.72
  rule _ {ct : comptype, dt : deftype}:
    `%~~%`(dt, ct)
    -- if ($expanddt(dt) = ct)

;; 2-syntax-aux.watsup:225.1-225.64
rec {

;; 2-syntax-aux.watsup:225.1-225.64
def funcsxt : externtype* -> deftype*
  ;; 2-syntax-aux.watsup:230.1-230.24
  def funcsxt([]) = []
  ;; 2-syntax-aux.watsup:231.1-231.47
  def {dt : deftype, et* : externtype*} funcsxt([FUNC_externtype(dt)] :: et*{et}) = [dt] :: $funcsxt(et*{et})
  ;; 2-syntax-aux.watsup:232.1-232.59
  def {et* : externtype*, externtype : externtype} funcsxt([externtype] :: et*{et}) = $funcsxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup:226.1-226.66
rec {

;; 2-syntax-aux.watsup:226.1-226.66
def globalsxt : externtype* -> globaltype*
  ;; 2-syntax-aux.watsup:234.1-234.26
  def globalsxt([]) = []
  ;; 2-syntax-aux.watsup:235.1-235.53
  def {et* : externtype*, gt : globaltype} globalsxt([GLOBAL_externtype(gt)] :: et*{et}) = [gt] :: $globalsxt(et*{et})
  ;; 2-syntax-aux.watsup:236.1-236.63
  def {et* : externtype*, externtype : externtype} globalsxt([externtype] :: et*{et}) = $globalsxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup:227.1-227.65
rec {

;; 2-syntax-aux.watsup:227.1-227.65
def tablesxt : externtype* -> tabletype*
  ;; 2-syntax-aux.watsup:238.1-238.25
  def tablesxt([]) = []
  ;; 2-syntax-aux.watsup:239.1-239.50
  def {et* : externtype*, tt : tabletype} tablesxt([TABLE_externtype(tt)] :: et*{et}) = [tt] :: $tablesxt(et*{et})
  ;; 2-syntax-aux.watsup:240.1-240.61
  def {et* : externtype*, externtype : externtype} tablesxt([externtype] :: et*{et}) = $tablesxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup:228.1-228.63
rec {

;; 2-syntax-aux.watsup:228.1-228.63
def memsxt : externtype* -> memtype*
  ;; 2-syntax-aux.watsup:242.1-242.23
  def memsxt([]) = []
  ;; 2-syntax-aux.watsup:243.1-243.44
  def {et* : externtype*, mt : memtype} memsxt([MEM_externtype(mt)] :: et*{et}) = [mt] :: $memsxt(et*{et})
  ;; 2-syntax-aux.watsup:244.1-244.57
  def {et* : externtype*, externtype : externtype} memsxt([externtype] :: et*{et}) = $memsxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup:253.1-253.33
def memop0 : memop
  ;; 2-syntax-aux.watsup:254.1-254.34
  def memop0 = {ALIGN 0, OFFSET 0}

;; 3-numerics.watsup:7.1-7.41
def s33_to_u32 : s33 -> u32

;; 3-numerics.watsup:12.1-12.57
def signed : (N, nat) -> int
  ;; 3-numerics.watsup:13.1-13.54
  def {N : N, i : nat} signed(N, i) = (i <: int)
    -- if (0 <= (2 ^ (N - 1)))
  ;; 3-numerics.watsup:14.1-14.60
  def {N : N, i : nat} signed(N, i) = ((i - (2 ^ N)) <: int)
    -- if (((2 ^ (N - 1)) <= i) /\ (i < (2 ^ N)))

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

;; 3-numerics.watsup:33.1-33.67
def ntbytes : (numtype, c_numtype) -> byte*

;; 3-numerics.watsup:34.1-34.67
def vtbytes : (vectype, c_vectype) -> byte*

;; 3-numerics.watsup:35.1-35.62
def ztbytes : (storagetype, c) -> byte*

;; 3-numerics.watsup:37.1-37.33
def invibytes : (N, byte*) -> iN
  ;; 3-numerics.watsup:40.1-40.52
  def {N : N, b* : byte*, n : n} invibytes(N, b*{b}) = n
    -- if ($ibytes(N, n) = b*{b})

;; 3-numerics.watsup:38.1-38.33
def invfbytes : (N, byte*) -> fN
  ;; 3-numerics.watsup:41.1-41.52
  def {N : N, b* : byte*, p : fN} invfbytes(N, b*{b}) = p
    -- if ($fbytes(N, p) = b*{b})

;; 3-numerics.watsup:43.1-43.23
def iadd : (N, c, c) -> c

;; 3-numerics.watsup:44.1-44.23
def imul : (N, c, c) -> c

;; 3-numerics.watsup:45.1-45.30
def ine : (N, c, c) -> c_numtype

;; 3-numerics.watsup:46.1-46.34
def ilt : (sx, N, c, c) -> c_numtype

;; 3-numerics.watsup:48.1-48.58
def lanes : (shape, c_vectype) -> c*

;; 3-numerics.watsup:49.1-49.29
def narrow : (N, N, sx, c) -> c

;; 3-numerics.watsup:50.1-50.22
def ibits : (N, N) -> c*

;; 3-numerics.watsup:52.1-52.31
def unpacked : shape -> numtype
  ;; 3-numerics.watsup:53.1-53.30
  def {lns : lanesize, pt : packedtype} unpacked(`%X%`((pt <: lanetype), lns)) = I32_numtype
  ;; 3-numerics.watsup:54.1-54.29
  def {lns : lanesize, nt : numtype} unpacked(`%X%`((nt <: lanetype), lns)) = nt

;; 3-numerics.watsup:56.1-56.27
def dim : shape -> lanesize
  ;; 3-numerics.watsup:57.1-57.26
  def {lns : lanesize, lnt : lanetype} dim(`%X%`(lnt, lns)) = lns

;; 3-numerics.watsup:59.1-59.34
def halfop : (half, nat, nat) -> nat
  ;; 3-numerics.watsup:60.1-60.27
  def {i : nat, j : nat} halfop(LOW_half, i, j) = i
  ;; 3-numerics.watsup:61.1-61.28
  def {i : nat, j : nat} halfop(HIGH_half, i, j) = j

;; 3-numerics.watsup:63.1-63.28
def ishape : nat -> lanetype
  ;; 3-numerics.watsup:64.1-64.20
  def ishape(8) = I8_lanetype
  ;; 3-numerics.watsup:65.1-65.22
  def ishape(16) = I16_lanetype
  ;; 3-numerics.watsup:66.1-66.22
  def ishape(32) = I32_lanetype
  ;; 3-numerics.watsup:67.1-67.22
  def ishape(64) = I64_lanetype

;; 3-numerics.watsup:69.1-69.107
def vvunop : (unop_vvectype, vectype, c_vectype) -> c_vectype

;; 3-numerics.watsup:70.1-70.108
def vvbinop : (binop_vvectype, vectype, c_vectype, c_vectype) -> c_vectype

;; 3-numerics.watsup:71.1-71.111
def vvternop : (ternop_vvectype, vectype, c_vectype, c_vectype, c_vectype) -> c_vectype

;; 3-numerics.watsup:73.1-73.107
def vunop : (unop_vectype, shape, c_vectype) -> c_vectype

;; 3-numerics.watsup:74.1-74.108
def vbinop : (binop_vectype, shape, c_vectype, c_vectype) -> c_vectype*

;; 3-numerics.watsup:75.1-75.108
def vrelop : (relop_vectype, shape, c, c) -> c_numtype

;; 3-numerics.watsup:76.1-76.108
def vishiftop : (shiftop_vectype, lanetype, c, c) -> c

;; 3-numerics.watsup:77.1-77.118
def vcvtop : (cvtop_vectype, N, N, sx?, c) -> c

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

;; 4-runtime.watsup:33.1-34.56
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:35.1-36.56
syntax vec =
  | VVCONST(vectype, c_vectype)

;; 4-runtime.watsup:37.1-43.23
rec {

;; 4-runtime.watsup:37.1-43.23
syntax addrref =
  | REF.I31_NUM(u31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)
}

;; 4-runtime.watsup:44.1-46.22
syntax ref =
  | REF.I31_NUM(u31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)
  | REF.NULL(heaptype)

;; 4-runtime.watsup:47.1-48.20
syntax val =
  | CONST(numtype, c_numtype)
  | VVCONST(vectype, c_vectype)
  | REF.NULL(heaptype)
  | REF.I31_NUM(u31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)

;; 4-runtime.watsup:50.1-51.22
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:60.1-61.70
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:72.1-72.26
syntax c_packedtype = nat

;; 4-runtime.watsup:92.1-94.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:107.1-115.25
syntax moduleinst = {TYPE deftype*, FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:74.1-77.16
syntax funcinst = {TYPE deftype, MODULE moduleinst, CODE func}

;; 4-runtime.watsup:78.1-80.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:81.1-83.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:84.1-86.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:87.1-89.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:90.1-91.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:96.1-97.57
syntax packedval =
  | PACK(packedtype, c_packedtype)

;; 4-runtime.watsup:98.1-99.20
syntax fieldval =
  | CONST(numtype, c_numtype)
  | VVCONST(vectype, c_vectype)
  | REF.NULL(heaptype)
  | REF.I31_NUM(u31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)
  | PACK(packedtype, c_packedtype)

;; 4-runtime.watsup:100.1-102.22
syntax structinst = {TYPE deftype, FIELD fieldval*}

;; 4-runtime.watsup:103.1-105.22
syntax arrayinst = {TYPE deftype, FIELD fieldval*}

;; 4-runtime.watsup:134.1-142.23
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*, STRUCT structinst*, ARRAY arrayinst*}

;; 4-runtime.watsup:144.1-146.24
syntax frame = {LOCAL val?*, MODULE moduleinst}

;; 4-runtime.watsup:148.1-148.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:160.1-165.9
rec {

;; 4-runtime.watsup:160.1-165.9
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
  | VVCONST(vectype, c_vectype)
  | VVUNOP(vectype, unop_vvectype)
  | VVBINOP(vectype, binop_vvectype)
  | VVTERNOP(vectype, ternop_vvectype)
  | VVTESTOP(vectype, testop_vvectype)
  | VSWIZZLE(shape)
  | VSHUFFLE(shape, laneidx*)
  | VSPLAT(shape)
  | VEXTRACT_LANE(shape, sx?, laneidx)
  | VREPLACE_LANE(shape, laneidx)
  | VUNOP(shape, unop_vectype)
  | VBINOP(shape, binop_vectype)
  | VRELOP(shape, relop_vectype)
  | VISHIFTOP(shape, shiftop_vectype)
  | VALL_TRUE(shape)
  | VBITMASK(shape)
  | VNARROW(shape, shape, sx)
  | VCVTOP(shape, cvtop_vectype, half?, shape, sx?, zero)
  | VEXTMUL(shape, half, shape, sx)
  | VDOT(shape, shape, sx)
  | VEXTADD_PAIRWISE(shape, shape, sx)
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
  | VLOAD(vloadop?, memidx, memop)
  | VLOAD_LANE(n, memidx, memop, laneidx)
  | VSTORE(memidx, memop)
  | VSTORE_LANE(n, memidx, memop, laneidx)
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

;; 4-runtime.watsup:149.1-149.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:167.1-170.25
rec {

;; 4-runtime.watsup:167.1-170.25
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
  ;; 5-runtime-aux.watsup:21.1-21.34
  def default(I32_valtype) = ?(CONST_val(I32_numtype, 0))
  ;; 5-runtime-aux.watsup:22.1-22.34
  def default(I64_valtype) = ?(CONST_val(I64_numtype, 0))
  ;; 5-runtime-aux.watsup:23.1-23.34
  def default(F32_valtype) = ?(CONST_val(F32_numtype, 0))
  ;; 5-runtime-aux.watsup:24.1-24.34
  def default(F64_valtype) = ?(CONST_val(F64_numtype, 0))
  ;; 5-runtime-aux.watsup:25.1-25.38
  def default(V128_valtype) = ?(VVCONST_val(V128_vectype, 0))
  ;; 5-runtime-aux.watsup:26.1-26.42
  def {ht : heaptype} default(REF_valtype(`NULL%?`(?(())), ht)) = ?(REF.NULL_val(ht))
  ;; 5-runtime-aux.watsup:27.1-27.31
  def {ht : heaptype} default(REF_valtype(`NULL%?`(?()), ht)) = ?()

;; 5-runtime-aux.watsup:32.1-32.73
def packval : (storagetype, val) -> fieldval
  ;; 5-runtime-aux.watsup:35.1-35.27
  def {t : valtype, val : val} packval((t <: storagetype), val) = (val <: fieldval)
  ;; 5-runtime-aux.watsup:36.1-36.70
  def {i : nat, pt : packedtype} packval((pt <: storagetype), CONST_val(I32_numtype, i)) = PACK_fieldval(pt, $wrap(32, $packedsize(pt), i))

;; 5-runtime-aux.watsup:33.1-33.83
def unpackval : (storagetype, sx?, fieldval) -> val
  ;; 5-runtime-aux.watsup:38.1-38.34
  def {t : valtype, val : val} unpackval((t <: storagetype), ?(), (val <: fieldval)) = val
  ;; 5-runtime-aux.watsup:39.1-39.79
  def {i : nat, pt : packedtype, sx : sx} unpackval((pt <: storagetype), ?(sx), PACK_fieldval(pt, i)) = CONST_val(I32_numtype, $ext($packedsize(pt), 32, sx, i))

;; 5-runtime-aux.watsup:44.1-44.62
rec {

;; 5-runtime-aux.watsup:44.1-44.62
def funcsxv : externval* -> funcaddr*
  ;; 5-runtime-aux.watsup:49.1-49.24
  def funcsxv([]) = []
  ;; 5-runtime-aux.watsup:50.1-50.47
  def {fa : funcaddr, xv* : externval*} funcsxv([FUNC_externval(fa)] :: xv*{xv}) = [fa] :: $funcsxv(xv*{xv})
  ;; 5-runtime-aux.watsup:51.1-51.58
  def {externval : externval, xv* : externval*} funcsxv([externval] :: xv*{xv}) = $funcsxv(xv*{xv})
    -- otherwise
}

;; 5-runtime-aux.watsup:45.1-45.64
rec {

;; 5-runtime-aux.watsup:45.1-45.64
def globalsxv : externval* -> globaladdr*
  ;; 5-runtime-aux.watsup:53.1-53.26
  def globalsxv([]) = []
  ;; 5-runtime-aux.watsup:54.1-54.53
  def {ga : globaladdr, xv* : externval*} globalsxv([GLOBAL_externval(ga)] :: xv*{xv}) = [ga] :: $globalsxv(xv*{xv})
  ;; 5-runtime-aux.watsup:55.1-55.62
  def {externval : externval, xv* : externval*} globalsxv([externval] :: xv*{xv}) = $globalsxv(xv*{xv})
    -- otherwise
}

;; 5-runtime-aux.watsup:46.1-46.63
rec {

;; 5-runtime-aux.watsup:46.1-46.63
def tablesxv : externval* -> tableaddr*
  ;; 5-runtime-aux.watsup:57.1-57.25
  def tablesxv([]) = []
  ;; 5-runtime-aux.watsup:58.1-58.50
  def {ta : tableaddr, xv* : externval*} tablesxv([TABLE_externval(ta)] :: xv*{xv}) = [ta] :: $tablesxv(xv*{xv})
  ;; 5-runtime-aux.watsup:59.1-59.60
  def {externval : externval, xv* : externval*} tablesxv([externval] :: xv*{xv}) = $tablesxv(xv*{xv})
    -- otherwise
}

;; 5-runtime-aux.watsup:47.1-47.61
rec {

;; 5-runtime-aux.watsup:47.1-47.61
def memsxv : externval* -> memaddr*
  ;; 5-runtime-aux.watsup:61.1-61.23
  def memsxv([]) = []
  ;; 5-runtime-aux.watsup:62.1-62.44
  def {ma : memaddr, xv* : externval*} memsxv([MEM_externval(ma)] :: xv*{xv}) = [ma] :: $memsxv(xv*{xv})
  ;; 5-runtime-aux.watsup:63.1-63.56
  def {externval : externval, xv* : externval*} memsxv([externval] :: xv*{xv}) = $memsxv(xv*{xv})
    -- otherwise
}

;; 5-runtime-aux.watsup:73.1-73.57
def store : state -> store
  ;; 5-runtime-aux.watsup:76.1-76.23
  def {f : frame, s : store} store(`%;%`(s, f)) = s

;; 5-runtime-aux.watsup:74.1-74.57
def frame : state -> frame
  ;; 5-runtime-aux.watsup:77.1-77.23
  def {f : frame, s : store} frame(`%;%`(s, f)) = f

;; 5-runtime-aux.watsup:80.1-80.63
def funcaddr : state -> funcaddr*
  ;; 5-runtime-aux.watsup:81.1-81.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 5-runtime-aux.watsup:83.1-83.56
def funcinst : state -> funcinst*
  ;; 5-runtime-aux.watsup:93.1-93.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 5-runtime-aux.watsup:84.1-84.58
def globalinst : state -> globalinst*
  ;; 5-runtime-aux.watsup:94.1-94.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 5-runtime-aux.watsup:85.1-85.57
def tableinst : state -> tableinst*
  ;; 5-runtime-aux.watsup:95.1-95.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 5-runtime-aux.watsup:86.1-86.55
def meminst : state -> meminst*
  ;; 5-runtime-aux.watsup:96.1-96.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 5-runtime-aux.watsup:87.1-87.56
def eleminst : state -> eleminst*
  ;; 5-runtime-aux.watsup:97.1-97.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 5-runtime-aux.watsup:88.1-88.56
def datainst : state -> datainst*
  ;; 5-runtime-aux.watsup:98.1-98.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 5-runtime-aux.watsup:89.1-89.58
def structinst : state -> structinst*
  ;; 5-runtime-aux.watsup:99.1-99.35
  def {f : frame, s : store} structinst(`%;%`(s, f)) = s.STRUCT_store

;; 5-runtime-aux.watsup:90.1-90.57
def arrayinst : state -> arrayinst*
  ;; 5-runtime-aux.watsup:100.1-100.33
  def {f : frame, s : store} arrayinst(`%;%`(s, f)) = s.ARRAY_store

;; 5-runtime-aux.watsup:91.1-91.58
def moduleinst : state -> moduleinst
  ;; 5-runtime-aux.watsup:101.1-101.35
  def {f : frame, s : store} moduleinst(`%;%`(s, f)) = f.MODULE_frame

;; 5-runtime-aux.watsup:103.1-103.66
def type : (state, typeidx) -> deftype
  ;; 5-runtime-aux.watsup:112.1-112.40
  def {f : frame, s : store, x : idx} type(`%;%`(s, f), x) = f.MODULE_frame.TYPE_moduleinst[x]

;; 5-runtime-aux.watsup:104.1-104.67
def func : (state, funcidx) -> funcinst
  ;; 5-runtime-aux.watsup:113.1-113.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 5-runtime-aux.watsup:105.1-105.69
def global : (state, globalidx) -> globalinst
  ;; 5-runtime-aux.watsup:114.1-114.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 5-runtime-aux.watsup:106.1-106.68
def table : (state, tableidx) -> tableinst
  ;; 5-runtime-aux.watsup:115.1-115.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 5-runtime-aux.watsup:107.1-107.66
def mem : (state, memidx) -> meminst
  ;; 5-runtime-aux.watsup:116.1-116.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 5-runtime-aux.watsup:108.1-108.67
def elem : (state, tableidx) -> eleminst
  ;; 5-runtime-aux.watsup:117.1-117.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 5-runtime-aux.watsup:109.1-109.67
def data : (state, dataidx) -> datainst
  ;; 5-runtime-aux.watsup:118.1-118.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 5-runtime-aux.watsup:110.1-110.68
def local : (state, localidx) -> val?
  ;; 5-runtime-aux.watsup:119.1-119.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 5-runtime-aux.watsup:124.1-124.88
def with_local : (state, localidx, val) -> state
  ;; 5-runtime-aux.watsup:135.1-135.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = ?(v)])

;; 5-runtime-aux.watsup:125.1-125.95
def with_global : (state, globalidx, val) -> state
  ;; 5-runtime-aux.watsup:136.1-136.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 5-runtime-aux.watsup:126.1-126.96
def with_table : (state, tableidx, nat, ref) -> state
  ;; 5-runtime-aux.watsup:137.1-137.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 5-runtime-aux.watsup:127.1-127.88
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 5-runtime-aux.watsup:138.1-138.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 5-runtime-aux.watsup:128.1-128.98
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 5-runtime-aux.watsup:139.1-139.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 5-runtime-aux.watsup:129.1-129.86
def with_meminst : (state, memidx, meminst) -> state
  ;; 5-runtime-aux.watsup:140.1-140.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 5-runtime-aux.watsup:130.1-130.92
def with_elem : (state, elemidx, ref*) -> state
  ;; 5-runtime-aux.watsup:141.1-141.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 5-runtime-aux.watsup:131.1-131.92
def with_data : (state, dataidx, byte*) -> state
  ;; 5-runtime-aux.watsup:142.1-142.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 5-runtime-aux.watsup:132.1-132.98
def with_struct : (state, structaddr, nat, fieldval) -> state
  ;; 5-runtime-aux.watsup:143.1-143.68
  def {a : addr, f : frame, fv : fieldval, i : nat, s : store} with_struct(`%;%`(s, f), a, i, fv) = `%;%`(s[STRUCT_store[a].FIELD_structinst[i] = fv], f)

;; 5-runtime-aux.watsup:133.1-133.98
def with_array : (state, arrayaddr, nat, fieldval) -> state
  ;; 5-runtime-aux.watsup:144.1-144.66
  def {a : addr, f : frame, fv : fieldval, i : nat, s : store} with_array(`%;%`(s, f), a, i, fv) = `%;%`(s[ARRAY_store[a].FIELD_arrayinst[i] = fv], f)

;; 5-runtime-aux.watsup:146.1-146.77
def ext_structinst : (state, structinst*) -> state
  ;; 5-runtime-aux.watsup:149.1-149.57
  def {f : frame, s : store, si* : structinst*} ext_structinst(`%;%`(s, f), si*{si}) = `%;%`(s[STRUCT_store =.. si*{si}], f)

;; 5-runtime-aux.watsup:147.1-147.76
def ext_arrayinst : (state, arrayinst*) -> state
  ;; 5-runtime-aux.watsup:150.1-150.55
  def {ai* : arrayinst*, f : frame, s : store} ext_arrayinst(`%;%`(s, f), ai*{ai}) = `%;%`(s[ARRAY_store =.. ai*{ai}], f)

;; 5-runtime-aux.watsup:155.1-155.62
def growtable : (tableinst, nat, ref) -> tableinst
  ;; 5-runtime-aux.watsup:158.1-162.19
  def {i : nat, i' : nat, j : nat, n : n, r : ref, r'* : ref*, rt : reftype, ti : tableinst, ti' : tableinst} growtable(ti, n, r) = ti'
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%]`(i', j), rt), ELEM r'*{r'} :: r^n{}})
    -- if (i' <= j)

;; 5-runtime-aux.watsup:156.1-156.62
def growmemory : (meminst, nat) -> meminst
  ;; 5-runtime-aux.watsup:164.1-168.19
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
  ;; 6-typing.watsup:28.1-28.34
  def {C : context} with_locals(C, [], []) = C
  ;; 6-typing.watsup:29.1-29.85
  def {C : context, lt* : localtype*, lt_1 : localtype, x* : idx*, x_1 : idx} with_locals(C, [x_1] :: x*{x}, [lt_1] :: lt*{lt}) = $with_locals(C[LOCAL_context[x_1] = lt_1], x*{x}, lt*{lt})
}

;; 6-typing.watsup:33.1-33.65
rec {

;; 6-typing.watsup:33.1-33.65
def clostypes : deftype* -> deftype*
  ;; 6-typing.watsup:37.1-37.26
  def clostypes([]) = []
  ;; 6-typing.watsup:38.1-38.93
  def {dt* : deftype*, dt'* : deftype*, dt_N : deftype} clostypes(dt*{dt} :: [dt_N]) = dt'*{dt'} :: [$subst_all_deftype(dt_N, (dt' <: heaptype)*{dt'})]
    -- if (dt'*{dt'} = $clostypes(dt*{dt}))
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
  ;; 6-typing.watsup:60.1-61.24
  rule abs {C : context, absheaptype : absheaptype}:
    `%|-%:OK`(C, (absheaptype <: heaptype))

  ;; 6-typing.watsup:63.1-65.23
  rule typeidx {C : context, dt : deftype, x : idx}:
    `%|-%:OK`(C, _IDX_heaptype(x))
    -- if (C.TYPE_context[x] = dt)

  ;; 6-typing.watsup:67.1-69.22
  rule rec {C : context, i : nat, st : subtype}:
    `%|-%:OK`(C, REC_heaptype(i))
    -- if (C.REC_context[i] = st)

;; 6-typing.watsup:50.1-50.71
relation Reftype_ok: `%|-%:OK`(context, reftype)
  ;; 6-typing.watsup:71.1-73.31
  rule _ {C : context, ht : heaptype, nul : nul}:
    `%|-%:OK`(C, REF_reftype(nul, ht))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

;; 6-typing.watsup:51.1-51.71
relation Valtype_ok: `%|-%:OK`(context, valtype)
  ;; 6-typing.watsup:75.1-77.35
  rule num {C : context, numtype : numtype}:
    `%|-%:OK`(C, (numtype <: valtype))
    -- Numtype_ok: `%|-%:OK`(C, numtype)

  ;; 6-typing.watsup:79.1-81.35
  rule vec {C : context, vectype : vectype}:
    `%|-%:OK`(C, (vectype <: valtype))
    -- Vectype_ok: `%|-%:OK`(C, vectype)

  ;; 6-typing.watsup:83.1-85.35
  rule ref {C : context, reftype : reftype}:
    `%|-%:OK`(C, (reftype <: valtype))
    -- Reftype_ok: `%|-%:OK`(C, reftype)

  ;; 6-typing.watsup:87.1-88.16
  rule bot {C : context}:
    `%|-%:OK`(C, BOT_valtype)

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
  ;; 6-typing.watsup:131.1-133.35
  rule val {C : context, valtype : valtype}:
    `%|-%:OK`(C, (valtype <: storagetype))
    -- Valtype_ok: `%|-%:OK`(C, valtype)

  ;; 6-typing.watsup:135.1-137.41
  rule packed {C : context, packedtype : packedtype}:
    `%|-%:OK`(C, (packedtype <: storagetype))
    -- Packedtype_ok: `%|-%:OK`(C, packedtype)

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
  ;; 6-typing.watsup:144.1-146.35
  rule struct {C : context, yt* : fieldtype*}:
    `%|-%:OK`(C, STRUCT_comptype(yt*{yt}))
    -- (Fieldtype_ok: `%|-%:OK`(C, yt))*{yt}

  ;; 6-typing.watsup:148.1-150.32
  rule array {C : context, yt : fieldtype}:
    `%|-%:OK`(C, ARRAY_comptype(yt))
    -- Fieldtype_ok: `%|-%:OK`(C, yt)

  ;; 6-typing.watsup:152.1-154.31
  rule func {C : context, ft : functype}:
    `%|-%:OK`(C, FUNC_comptype(ft))
    -- Functype_ok: `%|-%:OK`(C, ft)

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
  ;; 6-typing.watsup:434.1-436.58
  rule refl {C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- if ($clostype(C, deftype_1) = $clostype(C, deftype_2))

  ;; 6-typing.watsup:438.1-441.40
  rule super {C : context, ct : comptype, deftype_1 : deftype, deftype_2 : deftype, fin : fin, ht : heaptype, ht_1* : heaptype*, ht_2* : heaptype*}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- if ($unrolldt(deftype_1) = SUBD_subtype(fin, ht_1*{ht_1} :: [ht] :: ht_2*{ht_2}, ct))
    -- Heaptype_sub: `%|-%<:%`(C, ht, (deftype_2 <: heaptype))

;; 6-typing.watsup:271.1-271.79
relation Heaptype_sub: `%|-%<:%`(context, heaptype, heaptype)
  ;; 6-typing.watsup:282.1-283.28
  rule refl {C : context, heaptype : heaptype}:
    `%|-%<:%`(C, heaptype, heaptype)

  ;; 6-typing.watsup:285.1-289.48
  rule trans {C : context, heaptype' : heaptype, heaptype_1 : heaptype, heaptype_2 : heaptype}:
    `%|-%<:%`(C, heaptype_1, heaptype_2)
    -- Heaptype_ok: `%|-%:OK`(C, heaptype')
    -- Heaptype_sub: `%|-%<:%`(C, heaptype_1, heaptype')
    -- Heaptype_sub: `%|-%<:%`(C, heaptype', heaptype_2)

  ;; 6-typing.watsup:291.1-292.17
  rule eq-any {C : context}:
    `%|-%<:%`(C, EQ_heaptype, ANY_heaptype)

  ;; 6-typing.watsup:294.1-295.17
  rule i31-eq {C : context}:
    `%|-%<:%`(C, I31_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:297.1-298.20
  rule struct-eq {C : context}:
    `%|-%<:%`(C, STRUCT_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:300.1-301.19
  rule array-eq {C : context}:
    `%|-%<:%`(C, ARRAY_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:303.1-305.35
  rule struct {C : context, deftype : deftype, yt* : fieldtype*}:
    `%|-%<:%`(C, (deftype <: heaptype), STRUCT_heaptype)
    -- Expand: `%~~%`(deftype, STRUCT_comptype(yt*{yt}))

  ;; 6-typing.watsup:307.1-309.33
  rule array {C : context, deftype : deftype, yt : fieldtype}:
    `%|-%<:%`(C, (deftype <: heaptype), ARRAY_heaptype)
    -- Expand: `%~~%`(deftype, ARRAY_comptype(yt))

  ;; 6-typing.watsup:311.1-313.32
  rule func {C : context, deftype : deftype, ft : functype}:
    `%|-%<:%`(C, (deftype <: heaptype), FUNC_heaptype)
    -- Expand: `%~~%`(deftype, FUNC_comptype(ft))

  ;; 6-typing.watsup:315.1-317.46
  rule def {C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, (deftype_1 <: heaptype), (deftype_2 <: heaptype))
    -- Deftype_sub: `%|-%<:%`(C, deftype_1, deftype_2)

  ;; 6-typing.watsup:319.1-321.52
  rule typeidx-l {C : context, heaptype : heaptype, typeidx : typeidx}:
    `%|-%<:%`(C, _IDX_heaptype(typeidx), heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, (C.TYPE_context[typeidx] <: heaptype), heaptype)

  ;; 6-typing.watsup:323.1-325.52
  rule typeidx-r {C : context, heaptype : heaptype, typeidx : typeidx}:
    `%|-%<:%`(C, heaptype, _IDX_heaptype(typeidx))
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, (C.TYPE_context[typeidx] <: heaptype))

  ;; 6-typing.watsup:327.1-329.48
  rule rec {C : context, ct : comptype, fin : fin, ht : heaptype, ht_1* : heaptype*, ht_2* : heaptype*, i : nat}:
    `%|-%<:%`(C, REC_heaptype(i), ht)
    -- if (C.REC_context[i] = SUBD_subtype(fin, ht_1*{ht_1} :: [ht] :: ht_2*{ht_2}, ct))

  ;; 6-typing.watsup:331.1-333.40
  rule none {C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NONE_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, ANY_heaptype)

  ;; 6-typing.watsup:335.1-337.41
  rule nofunc {C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOFUNC_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, FUNC_heaptype)

  ;; 6-typing.watsup:339.1-341.43
  rule noextern {C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOEXTERN_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, EXTERN_heaptype)

  ;; 6-typing.watsup:343.1-344.23
  rule bot {C : context, heaptype : heaptype}:
    `%|-%<:%`(C, BOT_heaptype, heaptype)
}

;; 6-typing.watsup:272.1-272.78
relation Reftype_sub: `%|-%<:%`(context, reftype, reftype)
  ;; 6-typing.watsup:347.1-349.37
  rule nonnull {C : context, ht_1 : heaptype, ht_2 : heaptype}:
    `%|-%<:%`(C, REF_reftype(`NULL%?`(?()), ht_1), REF_reftype(`NULL%?`(?()), ht_2))
    -- Heaptype_sub: `%|-%<:%`(C, ht_1, ht_2)

  ;; 6-typing.watsup:351.1-353.37
  rule null {C : context, ht_1 : heaptype, ht_2 : heaptype}:
    `%|-%<:%`(C, REF_reftype(`NULL%?`(()?{}), ht_1), REF_reftype(`NULL%?`(?(())), ht_2))
    -- Heaptype_sub: `%|-%<:%`(C, ht_1, ht_2)

;; 6-typing.watsup:270.1-270.78
relation Vectype_sub: `%|-%<:%`(context, vectype, vectype)
  ;; 6-typing.watsup:278.1-279.26
  rule _ {C : context, vectype : vectype}:
    `%|-%<:%`(C, vectype, vectype)

;; 6-typing.watsup:273.1-273.78
relation Valtype_sub: `%|-%<:%`(context, valtype, valtype)
  ;; 6-typing.watsup:356.1-358.46
  rule num {C : context, numtype_1 : numtype, numtype_2 : numtype}:
    `%|-%<:%`(C, (numtype_1 <: valtype), (numtype_2 <: valtype))
    -- Numtype_sub: `%|-%<:%`(C, numtype_1, numtype_2)

  ;; 6-typing.watsup:360.1-362.46
  rule vec {C : context, vectype_1 : vectype, vectype_2 : vectype}:
    `%|-%<:%`(C, (vectype_1 <: valtype), (vectype_2 <: valtype))
    -- Vectype_sub: `%|-%<:%`(C, vectype_1, vectype_2)

  ;; 6-typing.watsup:364.1-366.46
  rule ref {C : context, reftype_1 : reftype, reftype_2 : reftype}:
    `%|-%<:%`(C, (reftype_1 <: valtype), (reftype_2 <: valtype))
    -- Reftype_sub: `%|-%<:%`(C, reftype_1, reftype_2)

  ;; 6-typing.watsup:368.1-369.22
  rule bot {C : context, valtype : valtype}:
    `%|-%<:%`(C, BOT_valtype, valtype)

;; 6-typing.watsup:392.1-392.92
relation Storagetype_sub: `%|-%<:%`(context, storagetype, storagetype)
  ;; 6-typing.watsup:402.1-404.46
  rule val {C : context, valtype_1 : valtype, valtype_2 : valtype}:
    `%|-%<:%`(C, (valtype_1 <: storagetype), (valtype_2 <: storagetype))
    -- Valtype_sub: `%|-%<:%`(C, valtype_1, valtype_2)

  ;; 6-typing.watsup:406.1-408.55
  rule packed {C : context, packedtype_1 : packedtype, packedtype_2 : packedtype}:
    `%|-%<:%`(C, (packedtype_1 <: storagetype), (packedtype_2 <: storagetype))
    -- Packedtype_sub: `%|-%<:%`(C, packedtype_1, packedtype_2)

;; 6-typing.watsup:393.1-393.90
relation Fieldtype_sub: `%|-%<:%`(context, fieldtype, fieldtype)
  ;; 6-typing.watsup:411.1-413.40
  rule const {C : context, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?()), zt_1), `%%`(`MUT%?`(?()), zt_2))
    -- Storagetype_sub: `%|-%<:%`(C, zt_1, zt_2)

  ;; 6-typing.watsup:415.1-418.40
  rule var {C : context, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?(())), zt_1), `%%`(`MUT%?`(?(())), zt_2))
    -- Storagetype_sub: `%|-%<:%`(C, zt_1, zt_2)
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

;; 6-typing.watsup:395.1-395.89
relation Functype_sub: `%|-%<:%`(context, functype, functype)
  ;; 6-typing.watsup:458.1-459.16
  rule _ {C : context, ft : functype}:
    `%|-%<:%`(C, ft, ft)

;; 6-typing.watsup:124.1-124.76
relation Comptype_sub: `%|-%<:%`(context, comptype, comptype)
  ;; 6-typing.watsup:421.1-423.41
  rule struct {C : context, yt'_1 : fieldtype, yt_1* : fieldtype*, yt_2* : fieldtype*}:
    `%|-%<:%`(C, STRUCT_comptype(yt_1*{yt_1} :: [yt'_1]), STRUCT_comptype(yt_2*{yt_2}))
    -- (Fieldtype_sub: `%|-%<:%`(C, yt_1, yt_2))*{yt_1 yt_2}

  ;; 6-typing.watsup:425.1-427.38
  rule array {C : context, yt_1 : fieldtype, yt_2 : fieldtype}:
    `%|-%<:%`(C, ARRAY_comptype(yt_1), ARRAY_comptype(yt_2))
    -- Fieldtype_sub: `%|-%<:%`(C, yt_1, yt_2)

  ;; 6-typing.watsup:429.1-431.37
  rule func {C : context, ft_1 : functype, ft_2 : functype}:
    `%|-%<:%`(C, FUNC_comptype(ft_1), FUNC_comptype(ft_2))
    -- Functype_sub: `%|-%<:%`(C, ft_1, ft_2)

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
  ;; 6-typing.watsup:166.1-166.34
  def {deftype : deftype, i : nat, x : idx} before((deftype <: heaptype), x, i) = true
  ;; 6-typing.watsup:167.1-167.46
  def {i : nat, typeidx : typeidx, x : idx} before(_IDX_heaptype(typeidx), x, i) = (typeidx < x)
  ;; 6-typing.watsup:168.1-168.33
  def {i : nat, j : nat, x : idx} before(REC_heaptype(j), x, i) = (j < i)

;; 6-typing.watsup:170.1-170.69
def unrollht : (context, heaptype) -> subtype
  ;; 6-typing.watsup:171.1-171.47
  def {C : context, deftype : deftype} unrollht(C, (deftype <: heaptype)) = $unrolldt(deftype)
  ;; 6-typing.watsup:172.1-172.60
  def {C : context, typeidx : typeidx} unrollht(C, _IDX_heaptype(typeidx)) = $unrolldt(C.TYPE_context[typeidx])
  ;; 6-typing.watsup:173.1-173.35
  def {C : context, i : nat} unrollht(C, REC_heaptype(i)) = C.REC_context[i]

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
  ;; 6-typing.watsup:196.1-197.24
  rule empty {C : context, i : nat, x : idx}:
    `%|-%:%`(C, REC_rectype([]), OK_oktypeidxnat(x, i))

  ;; 6-typing.watsup:199.1-202.50
  rule cons {C : context, i : nat, st* : subtype*, st_1 : subtype, x : idx}:
    `%|-%:%`(C, REC_rectype([st_1] :: st*{st}), OK_oktypeidxnat(x, i))
    -- Subtype_ok2: `%|-%:%`(C, st_1, OK_oktypeidxnat(x, i))
    -- Rectype_ok2: `%|-%:%`(C, REC_rectype(st*{st}), OK_oktypeidxnat((x + 1), (i + 1)))
}

;; 6-typing.watsup:118.1-118.74
rec {

;; 6-typing.watsup:118.1-118.74
relation Rectype_ok: `%|-%:%`(context, rectype, oktypeidx)
  ;; 6-typing.watsup:184.1-185.23
  rule empty {C : context, x : idx}:
    `%|-%:%`(C, REC_rectype([]), OK_oktypeidx(x))

  ;; 6-typing.watsup:187.1-190.43
  rule cons {C : context, st* : subtype*, st_1 : subtype, x : idx}:
    `%|-%:%`(C, REC_rectype([st_1] :: st*{st}), OK_oktypeidx(x))
    -- Subtype_ok: `%|-%:%`(C, st_1, OK_oktypeidx(x))
    -- Rectype_ok: `%|-%:%`(C, REC_rectype(st*{st}), OK_oktypeidx(x + 1))

  ;; 6-typing.watsup:192.1-194.49
  rule rec2 {C : context, st* : subtype*, x : idx}:
    `%|-%:%`(C, REC_rectype(st*{st}), OK_oktypeidx(x))
    -- Rectype_ok2: `%|-%:%`(C ++ {TYPE [], REC st*{st}, FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, REC_rectype(st*{st}), OK_oktypeidxnat(x, 0))
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
  ;; 6-typing.watsup:244.1-247.27
  rule func {C : context, dt : deftype, ft : functype}:
    `%|-%:OK`(C, FUNC_externtype(dt))
    -- Deftype_ok: `%|-%:OK`(C, dt)
    -- Expand: `%~~%`(dt, FUNC_comptype(ft))

  ;; 6-typing.watsup:249.1-251.33
  rule global {C : context, gt : globaltype}:
    `%|-%:OK`(C, GLOBAL_externtype(gt))
    -- Globaltype_ok: `%|-%:OK`(C, gt)

  ;; 6-typing.watsup:253.1-255.32
  rule table {C : context, tt : tabletype}:
    `%|-%:OK`(C, TABLE_externtype(tt))
    -- Tabletype_ok: `%|-%:OK`(C, tt)

  ;; 6-typing.watsup:257.1-259.30
  rule mem {C : context, mt : memtype}:
    `%|-%:OK`(C, MEM_externtype(mt))
    -- Memtype_ok: `%|-%:OK`(C, mt)

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
  ;; 6-typing.watsup:461.1-463.34
  rule const {C : context, t_1 : valtype, t_2 : valtype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?()), t_1), `%%`(`MUT%?`(?()), t_2))
    -- Valtype_sub: `%|-%<:%`(C, t_1, t_2)

  ;; 6-typing.watsup:465.1-468.34
  rule var {C : context, t_1 : valtype, t_2 : valtype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?(())), t_1), `%%`(`MUT%?`(?(())), t_2))
    -- Valtype_sub: `%|-%<:%`(C, t_1, t_2)
    -- Valtype_sub: `%|-%<:%`(C, t_2, t_1)

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
  ;; 6-typing.watsup:481.1-483.36
  rule func {C : context, dt_1 : deftype, dt_2 : deftype}:
    `%|-%<:%`(C, FUNC_externtype(dt_1), FUNC_externtype(dt_2))
    -- Deftype_sub: `%|-%<:%`(C, dt_1, dt_2)

  ;; 6-typing.watsup:485.1-487.39
  rule global {C : context, gt_1 : globaltype, gt_2 : globaltype}:
    `%|-%<:%`(C, GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `%|-%<:%`(C, gt_1, gt_2)

  ;; 6-typing.watsup:489.1-491.38
  rule table {C : context, tt_1 : tabletype, tt_2 : tabletype}:
    `%|-%<:%`(C, TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `%|-%<:%`(C, tt_1, tt_2)

  ;; 6-typing.watsup:493.1-495.36
  rule mem {C : context, mt_1 : memtype, mt_2 : memtype}:
    `%|-%<:%`(C, MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `%|-%<:%`(C, mt_1, mt_2)

;; 6-typing.watsup:565.1-565.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 6-typing.watsup:567.1-568.32
  rule void {C : context}:
    `%|-%:%`(C, _RESULT_blocktype(?()), `%->%`([], []))

  ;; 6-typing.watsup:570.1-571.28
  rule result {C : context, t : valtype}:
    `%|-%:%`(C, _RESULT_blocktype(?(t)), `%->%`([], [t]))

  ;; 6-typing.watsup:573.1-575.34
  rule typeidx {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, _IDX_blocktype(x), ft)
    -- Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(ft))

;; 6-typing.watsup:503.1-505.74
rec {

;; 6-typing.watsup:503.1-503.67
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 6-typing.watsup:544.1-545.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 6-typing.watsup:547.1-548.24
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 6-typing.watsup:550.1-551.23
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 6-typing.watsup:554.1-555.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?([t])), `%->%`([t t I32_valtype], [t]))

  ;; 6-typing.watsup:557.1-560.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `%|-%<:%`(C, t, t')
    -- if ((t' = (numtype <: valtype)) \/ (t' = (vectype <: valtype)))

  ;; 6-typing.watsup:578.1-581.61
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr*{instr}, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))

  ;; 6-typing.watsup:583.1-586.61
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1*{t_1}], RETURN ?()}, instr*{instr}, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))

  ;; 6-typing.watsup:588.1-592.65
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*, x_1* : idx*, x_2* : idx*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%*%`(t_1*{t_1}, x_1*{x_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%*%`(t_1*{t_1}, x_2*{x_2}, t_2*{t_2}))

  ;; 6-typing.watsup:597.1-599.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 6-typing.watsup:601.1-603.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 6-typing.watsup:605.1-608.44
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `%|-%*<:%*`(C, t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `%|-%*<:%*`(C, t*{t}, C.LABEL_context[l'])

  ;; 6-typing.watsup:610.1-613.31
  rule br_on_null {C : context, ht : heaptype, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_ON_NULL_instr(l), `%->%`(t*{t} :: [REF_valtype(`NULL%?`(?(())), ht)], t*{t} :: [REF_valtype(`NULL%?`(?()), ht)]))
    -- if (C.LABEL_context[l] = t*{t})
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:615.1-618.31
  rule br_on_non_null {C : context, ht : heaptype, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_ON_NON_NULL_instr(l), `%->%`(t*{t} :: [REF_valtype(`NULL%?`(?(())), ht)], t*{t}))
    -- if (C.LABEL_context[l] = t*{t} :: [REF_valtype(`NULL%?`(?()), ht)])
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:620.1-626.34
  rule br_on_cast {C : context, l : labelidx, rt : reftype, rt_1 : reftype, rt_2 : reftype, t* : valtype*}:
    `%|-%:%`(C, BR_ON_CAST_instr(l, rt_1, rt_2), `%->%`(t*{t} :: [(rt_1 <: valtype)], t*{t} :: [($diffrt(rt_1, rt_2) <: valtype)]))
    -- if (C.LABEL_context[l] = t*{t} :: [(rt <: valtype)])
    -- Reftype_ok: `%|-%:OK`(C, rt_1)
    -- Reftype_ok: `%|-%:OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt)

  ;; 6-typing.watsup:628.1-634.49
  rule br_on_cast_fail {C : context, l : labelidx, rt : reftype, rt_1 : reftype, rt_2 : reftype, t* : valtype*}:
    `%|-%:%`(C, BR_ON_CAST_FAIL_instr(l, rt_1, rt_2), `%->%`(t*{t} :: [(rt_1 <: valtype)], t*{t} :: [(rt_2 <: valtype)]))
    -- if (C.LABEL_context[l] = t*{t} :: [(rt <: valtype)])
    -- Reftype_ok: `%|-%:OK`(C, rt_1)
    -- Reftype_ok: `%|-%:OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, $diffrt(rt_1, rt_2), rt)

  ;; 6-typing.watsup:639.1-641.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 6-typing.watsup:643.1-645.46
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:647.1-649.46
  rule call_ref {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_REF_instr(?(x)), `%->%`(t_1*{t_1} :: [REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype))], t_2*{t_2}))
    -- Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:651.1-655.46
  rule call_indirect {C : context, lim : limits, rt : reftype, t_1* : valtype*, t_2* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, y), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPE_context[y], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:657.1-661.40
  rule return_call {C : context, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*, t_4* : valtype*, x : idx}:
    `%|-%:%`(C, RETURN_CALL_instr(x), `%->%`(t_3*{t_3} :: t_1*{t_1}, t_4*{t_4}))
    -- Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:663.1-667.40
  rule return_call_ref {C : context, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*, t_4* : valtype*, x : idx}:
    `%|-%:%`(C, RETURN_CALL_REF_instr(?(x)), `%->%`(t_3*{t_3} :: t_1*{t_1} :: [REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype))], t_4*{t_4}))
    -- Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:669.1-675.40
  rule return_call_indirect {C : context, lim : limits, rt : reftype, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*, t_4* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, RETURN_CALL_INDIRECT_instr(x, y), `%->%`(t_3*{t_3} :: t_1*{t_1} :: [I32_valtype], t_4*{t_4}))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPE_context[y], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:680.1-681.33
  rule const {C : context, c_nt : c, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [(nt <: valtype)]))

  ;; 6-typing.watsup:683.1-684.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([(nt <: valtype)], [(nt <: valtype)]))

  ;; 6-typing.watsup:686.1-687.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([(nt <: valtype) (nt <: valtype)], [(nt <: valtype)]))

  ;; 6-typing.watsup:689.1-690.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([(nt <: valtype)], [I32_valtype]))

  ;; 6-typing.watsup:692.1-693.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([(nt <: valtype) (nt <: valtype)], [I32_valtype]))

  ;; 6-typing.watsup:696.1-698.23
  rule extend {C : context, n : n, nt : numtype}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([(nt <: valtype)], [(nt <: valtype)]))
    -- if (n <= $size(nt <: valtype))

  ;; 6-typing.watsup:700.1-703.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([(nt_2 <: valtype)], [(nt_1 <: valtype)]))
    -- if (nt_1 =/= nt_2)
    -- if ($size(nt_1 <: valtype) = $size(nt_2 <: valtype))

  ;; 6-typing.watsup:705.1-708.50
  rule convert-i {C : context, inn_1 : inn, inn_2 : inn, sx? : sx?}:
    `%|-%:%`(C, CVTOP_instr((inn_1 <: numtype), CONVERT_cvtop, (inn_2 <: numtype), sx?{sx}), `%->%`([(inn_2 <: valtype)], [(inn_1 <: valtype)]))
    -- if (inn_1 =/= inn_2)
    -- if ((sx?{sx} = ?()) <=> ($size(inn_1 <: valtype) > $size(inn_2 <: valtype)))

  ;; 6-typing.watsup:710.1-712.24
  rule convert-f {C : context, fnn_1 : fnn, fnn_2 : fnn}:
    `%|-%:%`(C, CVTOP_instr((fnn_1 <: numtype), CONVERT_cvtop, (fnn_2 <: numtype), ?()), `%->%`([(fnn_2 <: valtype)], [(fnn_1 <: valtype)]))
    -- if (fnn_1 =/= fnn_2)

  ;; 6-typing.watsup:717.1-719.31
  rule ref.null {C : context, ht : heaptype}:
    `%|-%:%`(C, REF.NULL_instr(ht), `%->%`([], [REF_valtype(`NULL%?`(?(())), ht)]))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:722.1-724.23
  rule ref.func {C : context, dt : deftype, epsilon : resulttype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`(epsilon, [REF_valtype(`NULL%?`(?()), (dt <: heaptype))]))
    -- if (C.FUNC_context[x] = dt)

  ;; 6-typing.watsup:726.1-727.34
  rule ref.i31 {C : context}:
    `%|-%:%`(C, REF.I31_instr, `%->%`([I32_valtype], [REF_valtype(`NULL%?`(?()), I31_heaptype)]))

  ;; 6-typing.watsup:729.1-730.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([(rt <: valtype)], [I32_valtype]))

  ;; 6-typing.watsup:732.1-734.31
  rule ref.as_non_null {C : context, ht : heaptype}:
    `%|-%:%`(C, REF.AS_NON_NULL_instr, `%->%`([REF_valtype(`NULL%?`(?(())), ht)], [REF_valtype(`NULL%?`(?()), ht)]))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:736.1-737.51
  rule ref.eq {C : context}:
    `%|-%:%`(C, REF.EQ_instr, `%->%`([REF_valtype(`NULL%?`(?(())), EQ_heaptype) REF_valtype(`NULL%?`(?(())), EQ_heaptype)], [I32_valtype]))

  ;; 6-typing.watsup:739.1-743.33
  rule ref.test {C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.TEST_instr(rt), `%->%`([(rt' <: valtype)], [I32_valtype]))
    -- Reftype_ok: `%|-%:OK`(C, rt)
    -- Reftype_ok: `%|-%:OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; 6-typing.watsup:745.1-749.33
  rule ref.cast {C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.CAST_instr(rt), `%->%`([(rt' <: valtype)], [(rt <: valtype)]))
    -- Reftype_ok: `%|-%:OK`(C, rt)
    -- Reftype_ok: `%|-%:OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; 6-typing.watsup:754.1-755.42
  rule i31.get {C : context, sx : sx}:
    `%|-%:%`(C, I31.GET_instr(sx), `%->%`([REF_valtype(`NULL%?`(?(())), I31_heaptype)], [I32_valtype]))

  ;; 6-typing.watsup:760.1-762.43
  rule struct.new {C : context, mut* : mut*, x : idx, zt* : storagetype*}:
    `%|-%:%`(C, STRUCT.NEW_instr(x), `%->%`($unpacktype(zt)*{zt}, [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(`%%`(mut, zt)*{mut zt}))

  ;; 6-typing.watsup:764.1-767.43
  rule struct.new_default {C : context, mut* : mut*, val* : val*, x : idx, zt* : storagetype*}:
    `%|-%:%`(C, STRUCT.NEW_DEFAULT_instr(x), `%->%`($unpacktype(zt)*{zt}, [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- (if ($default($unpacktype(zt)) = ?(val)))*{val zt}

  ;; 6-typing.watsup:769.1-773.43
  rule struct.get {C : context, i : nat, mut : mut, sx? : sx?, x : idx, yt* : fieldtype*, zt : storagetype}:
    `%|-%:%`(C, STRUCT.GET_instr(sx?{sx}, x, i), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype))], [$unpacktype(zt)]))
    -- Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(yt*{yt}))
    -- if (yt*{yt}[i] = `%%`(mut, zt))
    -- if ((sx?{sx} = ?()) <=> (zt = ($unpacktype(zt) <: storagetype)))

  ;; 6-typing.watsup:775.1-778.24
  rule struct.set {C : context, i : nat, x : idx, yt* : fieldtype*, zt : storagetype}:
    `%|-%:%`(C, STRUCT.SET_instr(x, i), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) $unpacktype(zt)], []))
    -- Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(yt*{yt}))
    -- if (yt*{yt}[i] = `%%`(`MUT%?`(?(())), zt))

  ;; 6-typing.watsup:783.1-785.41
  rule array.new {C : context, mut : mut, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.NEW_instr(x), `%->%`([$unpacktype(zt) I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))

  ;; 6-typing.watsup:787.1-790.40
  rule array.new_default {C : context, mut : mut, val : val, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.NEW_DEFAULT_instr(x), `%->%`([I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))
    -- if ($default($unpacktype(zt)) = ?(val))

  ;; 6-typing.watsup:792.1-794.41
  rule array.new_fixed {C : context, mut : mut, n : n, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.NEW_FIXED_instr(x, n), `%->%`([$unpacktype(zt)], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))

  ;; 6-typing.watsup:796.1-799.39
  rule array.new_elem {C : context, mut : mut, rt : reftype, x : idx, y : idx}:
    `%|-%:%`(C, ARRAY.NEW_ELEM_instr(x, y), `%->%`([I32_valtype I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, (rt <: storagetype))))
    -- Reftype_sub: `%|-%<:%`(C, C.ELEM_context[y], rt)

  ;; 6-typing.watsup:801.1-805.23
  rule array.new_data {C : context, mut : mut, numtype : numtype, t : valtype, vectype : vectype, x : idx, y : idx}:
    `%|-%:%`(C, ARRAY.NEW_DATA_instr(x, y), `%->%`([I32_valtype I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, (t <: storagetype))))
    -- if ((t = (numtype <: valtype)) \/ (t = (vectype <: valtype)))
    -- if (C.DATA_context[y] = OK)

  ;; 6-typing.watsup:807.1-810.43
  rule array.get {C : context, mut : mut, sx? : sx?, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.GET_instr(sx?{sx}, x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype], [$unpacktype(zt)]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))
    -- if ((sx?{sx} = ?()) <=> (zt = ($unpacktype(zt) <: storagetype)))

  ;; 6-typing.watsup:812.1-814.41
  rule array.set {C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.SET_instr(x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype $unpacktype(zt)], []))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:816.1-818.41
  rule array.len {C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.LEN_instr, `%->%`([REF_valtype(`NULL%?`(?(())), ARRAY_heaptype)], [I32_valtype]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:820.1-822.41
  rule array.fill {C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.FILL_instr(x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype $unpacktype(zt) I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:824.1-828.40
  rule array.copy {C : context, mut : mut, x_1 : idx, x_2 : idx, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%:%`(C, ARRAY.COPY_instr(x_1, x_2), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x_1) <: heaptype)) I32_valtype REF_valtype(`NULL%?`(?(())), ($idx(x_2) <: heaptype)) I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x_1], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt_1)))
    -- Expand: `%~~%`(C.TYPE_context[x_2], ARRAY_comptype(`%%`(mut, zt_2)))
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

  ;; 6-typing.watsup:830.1-833.43
  rule array.init_elem {C : context, x : idx, y : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.INIT_ELEM_instr(x, y), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
    -- Storagetype_sub: `%|-%<:%`(C, (C.ELEM_context[y] <: storagetype), zt)

  ;; 6-typing.watsup:835.1-839.23
  rule array.init_data {C : context, numtype : numtype, t : valtype, vectype : vectype, x : idx, y : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.INIT_DATA_instr(x, y), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
    -- if ((t = (numtype <: valtype)) \/ (t = (vectype <: valtype)))
    -- if (C.DATA_context[y] = OK)

  ;; 6-typing.watsup:844.1-845.62
  rule extern.convert_any {C : context, nul : nul}:
    `%|-%:%`(C, EXTERN.CONVERT_ANY_instr, `%->%`([REF_valtype(nul, ANY_heaptype)], [REF_valtype(nul, EXTERN_heaptype)]))

  ;; 6-typing.watsup:847.1-848.62
  rule any.convert_extern {C : context, nul : nul}:
    `%|-%:%`(C, ANY.CONVERT_EXTERN_instr, `%->%`([REF_valtype(nul, EXTERN_heaptype)], [REF_valtype(nul, ANY_heaptype)]))

  ;; 6-typing.watsup:853.1-854.39
  rule vvconst {C : context, c_vt : c}:
    `%|-%:%`(C, VVCONST_instr(V128_vectype, c_vt), `%->%`([], [V128_valtype]))

  ;; 6-typing.watsup:856.1-857.39
  rule vvunop {C : context, vt : vectype, vvunop : unop_vvectype}:
    `%|-%:%`(C, VVUNOP_instr(vt, vvunop), `%->%`([V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:859.1-860.46
  rule vvbinop {C : context, vt : vectype, vvbinop : binop_vvectype}:
    `%|-%:%`(C, VVBINOP_instr(vt, vvbinop), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:862.1-863.53
  rule vvternop {C : context, vt : vectype, vvternop : ternop_vvectype}:
    `%|-%:%`(C, VVTERNOP_instr(vt, vvternop), `%->%`([V128_valtype V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:865.1-866.42
  rule vvtestop {C : context, vt : vectype, vvtestop : testop_vvectype}:
    `%|-%:%`(C, VVTESTOP_instr(vt, vvtestop), `%->%`([V128_valtype], [I32_valtype]))

  ;; 6-typing.watsup:868.1-869.39
  rule vswizzle {C : context, sh : shape}:
    `%|-%:%`(C, VSWIZZLE_instr(sh), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:871.1-873.35
  rule vshuffle {C : context, laneidx* : laneidx*, sh : shape}:
    `%|-%:%`(C, VSHUFFLE_instr(sh, laneidx*{laneidx}), `%->%`([V128_valtype V128_valtype], [V128_valtype]))
    -- (if (laneidx < ($dim(sh) * 2)))*{laneidx}

  ;; 6-typing.watsup:875.1-876.41
  rule vsplat {C : context, sh : shape}:
    `%|-%:%`(C, VSPLAT_instr(sh), `%->%`([($unpacked(sh) <: valtype)], [V128_valtype]))

  ;; 6-typing.watsup:878.1-880.27
  rule vextract_lane {C : context, laneidx : laneidx, sh : shape, sx? : sx?}:
    `%|-%:%`(C, VEXTRACT_LANE_instr(sh, sx?{sx}, laneidx), `%->%`([V128_valtype], [($unpacked(sh) <: valtype)]))
    -- if (laneidx < $dim(sh))

  ;; 6-typing.watsup:882.1-884.27
  rule vreplace_lane {C : context, laneidx : laneidx, sh : shape}:
    `%|-%:%`(C, VREPLACE_LANE_instr(sh, laneidx), `%->%`([V128_valtype ($unpacked(sh) <: valtype)], [V128_valtype]))
    -- if (laneidx < $dim(sh))

  ;; 6-typing.watsup:886.1-887.37
  rule vunop {C : context, sh : shape, vunop : unop_vectype}:
    `%|-%:%`(C, VUNOP_instr(sh, vunop), `%->%`([V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:889.1-890.44
  rule vbinop {C : context, sh : shape, vbinop : binop_vectype}:
    `%|-%:%`(C, VBINOP_instr(sh, vbinop), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:892.1-893.44
  rule vrelop {C : context, sh : shape, vrelop : relop_vectype}:
    `%|-%:%`(C, VRELOP_instr(sh, vrelop), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:895.1-896.49
  rule vishiftop {C : context, sh : shape, vishiftop : shiftop_vectype}:
    `%|-%:%`(C, VISHIFTOP_instr(sh, vishiftop), `%->%`([V128_valtype I32_valtype], [V128_valtype]))

  ;; 6-typing.watsup:898.1-899.34
  rule vtestop {C : context, sh : shape}:
    `%|-%:%`(C, VALL_TRUE_instr(sh), `%->%`([V128_valtype], [I32_valtype]))

  ;; 6-typing.watsup:901.1-902.55
  rule vcvtop {C : context, hf? : half?, sh : shape, sx? : sx?, vcvtop : cvtop_vectype, zero : zero}:
    `%|-%:%`(C, VCVTOP_instr(sh, vcvtop, hf?{hf}, sh, sx?{sx}, zero), `%->%`([V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:904.1-905.44
  rule vnarrow {C : context, sh : shape, sx : sx}:
    `%|-%:%`(C, VNARROW_instr(sh, sh, sx), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:907.1-908.33
  rule vbitmask {C : context, sh : shape}:
    `%|-%:%`(C, VBITMASK_instr(sh), `%->%`([V128_valtype], [I32_valtype]))

  ;; 6-typing.watsup:910.1-911.41
  rule vdot {C : context, sh : shape, sx : sx}:
    `%|-%:%`(C, VDOT_instr(sh, sh, sx), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:913.1-914.49
  rule vextmul {C : context, half : half, sh : shape, sx : sx}:
    `%|-%:%`(C, VEXTMUL_instr(sh, half, sh, sx), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:916.1-917.48
  rule vextadd_pairwise {C : context, sh : shape, sx : sx}:
    `%|-%:%`(C, VEXTADD_PAIRWISE_instr(sh, sh, sx), `%->%`([V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:922.1-924.28
  rule local.get {C : context, init : init, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = `%%`(init, t))

  ;; 6-typing.watsup:937.1-939.28
  rule global.get {C : context, mut : mut, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `%%`(mut, t))

  ;; 6-typing.watsup:941.1-943.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?(())), t))

  ;; 6-typing.watsup:948.1-950.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [(rt <: valtype)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 6-typing.watsup:952.1-954.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype (rt <: valtype)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 6-typing.watsup:956.1-958.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 6-typing.watsup:960.1-962.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([(rt <: valtype) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 6-typing.watsup:964.1-966.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype (rt <: valtype) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 6-typing.watsup:968.1-972.36
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt_1 : reftype, rt_2 : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt_1))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt_2))
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:974.1-978.36
  rule table.init {C : context, lim : limits, rt_1 : reftype, rt_2 : reftype, x : idx, y : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x, y), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt_1))
    -- if (C.ELEM_context[y] = rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:980.1-982.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 6-typing.watsup:987.1-989.22
  rule memory.size {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[x] = mt)

  ;; 6-typing.watsup:991.1-993.22
  rule memory.grow {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.GROW_instr(x), `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[x] = mt)

  ;; 6-typing.watsup:995.1-997.22
  rule memory.fill {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.FILL_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[x] = mt)

  ;; 6-typing.watsup:999.1-1002.26
  rule memory.copy {C : context, mt_1 : memtype, mt_2 : memtype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, MEMORY.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[x_1] = mt_1)
    -- if (C.MEM_context[x_2] = mt_2)

  ;; 6-typing.watsup:1004.1-1007.23
  rule memory.init {C : context, mt : memtype, x : idx, y : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x, y), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[x] = mt)
    -- if (C.DATA_context[y] = OK)

  ;; 6-typing.watsup:1009.1-1011.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 6-typing.watsup:1013.1-1018.29
  rule load {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?, x : idx}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [(nt <: valtype)]))
    -- if (C.MEM_context[x] = mt)
    -- if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (inn <: numtype)))

  ;; 6-typing.watsup:1020.1-1025.29
  rule store {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, x : idx}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype (nt <: valtype)], []))
    -- if (C.MEM_context[x] = mt)
    -- if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (inn <: numtype)))

  ;; 6-typing.watsup:1027.1-1030.30
  rule vload {C : context, M : M, N : N, mt : memtype, n_A : n, n_O : n, sx : sx, x : idx}:
    `%|-%:%`(C, VLOAD_instr(?(SHAPE_vloadop(`%X%`(M, N), sx)), x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [V128_valtype]))
    -- if (C.MEM_context[x] = mt)
    -- if ((2 ^ n_A) <= ((M / 8) * N))

  ;; 6-typing.watsup:1032.1-1035.26
  rule vload-splat {C : context, mt : memtype, n : n, n_A : n, n_O : n, x : idx}:
    `%|-%:%`(C, VLOAD_instr(?(SPLAT_vloadop(n)), x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [V128_valtype]))
    -- if (C.MEM_context[x] = mt)
    -- if ((2 ^ n_A) <= (n / 8))

  ;; 6-typing.watsup:1037.1-1040.25
  rule vload-zero {C : context, mt : memtype, n : n, n_A : n, n_O : n, x : idx}:
    `%|-%:%`(C, VLOAD_instr(?(ZERO_vloadop(n)), x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [V128_valtype]))
    -- if (C.MEM_context[x] = mt)
    -- if ((2 ^ n_A) < (n / 8))

  ;; 6-typing.watsup:1042.1-1046.29
  rule vload_lane {C : context, laneidx : laneidx, mt : memtype, n : n, n_A : n, n_O : n, x : idx}:
    `%|-%:%`(C, VLOAD_LANE_instr(n, x, {ALIGN n_A, OFFSET n_O}, laneidx), `%->%`([I32_valtype V128_valtype], [V128_valtype]))
    -- if (C.MEM_context[x] = mt)
    -- if ((2 ^ n_A) < (n / 8))
    -- if (laneidx < (128 / n))

  ;; 6-typing.watsup:1048.1-1051.36
  rule vstore {C : context, mt : memtype, n_A : n, n_O : n, x : idx}:
    `%|-%:%`(C, VSTORE_instr(x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype V128_valtype], []))
    -- if (C.MEM_context[x] = mt)
    -- if ((2 ^ n_A) <= ($size(V128_valtype) / 8))

  ;; 6-typing.watsup:1053.1-1057.29
  rule vstore_lane {C : context, laneidx : laneidx, mt : memtype, n : n, n_A : n, n_O : n, x : idx}:
    `%|-%:%`(C, VSTORE_LANE_instr(n, x, {ALIGN n_A, OFFSET n_O}, laneidx), `%->%`([I32_valtype V128_valtype], []))
    -- if (C.MEM_context[x] = mt)
    -- if ((2 ^ n_A) < (n / 8))
    -- if (laneidx < (128 / n))

;; 6-typing.watsup:504.1-504.67
relation Instrf_ok: `%|-%:%`(context, instr, instrtype)
  ;; 6-typing.watsup:518.1-520.41
  rule instr {C : context, instr : instr, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, instr, `%->%*%`(t_1*{t_1}, [], t_2*{t_2}))
    -- Instr_ok: `%|-%:%`(C, instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 6-typing.watsup:926.1-928.28
  rule local.set {C : context, init : init, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%*%`([t], [x], []))
    -- if (C.LOCAL_context[x] = `%%`(init, t))

  ;; 6-typing.watsup:930.1-932.28
  rule local.tee {C : context, init : init, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%*%`([t], [x], [t]))
    -- if (C.LOCAL_context[x] = `%%`(init, t))

;; 6-typing.watsup:505.1-505.74
relation Instrs_ok: `%|-%*:%`(context, instr*, instrtype)
  ;; 6-typing.watsup:522.1-523.29
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%*%`([], [], []))

  ;; 6-typing.watsup:525.1-530.52
  rule seq {C : context, C' : context, init* : init*, instr_1 : instr, instr_2* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*, x_1* : idx*, x_2* : idx*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{instr_2}, `%->%*%`(t_1*{t_1}, x_1*{x_1} :: x_2*{x_2}, t_3*{t_3}))
    -- (if (C.LOCAL_context[x_1] = `%%`(init, t)))*{init t x_1}
    -- if (C' = $with_locals(C, x_1*{x_1}, `%%`(SET_init, t)*{t}))
    -- Instrf_ok: `%|-%:%`(C, instr_1, `%->%*%`(t_1*{t_1}, x_1*{x_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C', instr_2*{instr_2}, `%->%*%`(t_2*{t_2}, x_2*{x_2}, t_3*{t_3}))

  ;; 6-typing.watsup:532.1-535.35
  rule sub {C : context, instr* : instr*, it : instrtype, it' : instrtype}:
    `%|-%*:%`(C, instr*{instr}, it')
    -- Instrs_ok: `%|-%*:%`(C, instr*{instr}, it)
    -- Instrtype_sub: `%|-%<:%`(C, it, it')

  ;; 6-typing.watsup:537.1-539.47
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%*:%`(C, instr*{instr}, `%->%*%`(t*{t} :: t_1*{t_1}, x*{x}, t*{t} :: t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C, instr*{instr}, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))
}

;; 6-typing.watsup:506.1-506.72
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 6-typing.watsup:511.1-513.45
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- Instrs_ok: `%|-%*:%`(C, instr*{instr}, `%->%*%`([], [], t*{t}))

;; 6-typing.watsup:1088.1-1088.64
rec {

;; 6-typing.watsup:1088.1-1088.64
def in_binop : (binop_numtype, ibinop*) -> bool
  ;; 6-typing.watsup:1089.1-1089.38
  def {binop : binop_numtype, epsilon : ibinop*} in_binop(binop, epsilon) = false
  ;; 6-typing.watsup:1090.1-1090.92
  def {binop : binop_numtype, ibinop'* : ibinop*, ibinop_1 : ibinop} in_binop(binop, [ibinop_1] :: ibinop'*{ibinop'}) = ((binop = _I_binop_numtype(ibinop_1)) \/ $in_binop(binop, ibinop'*{ibinop'}))
}

;; 6-typing.watsup:1084.1-1084.63
rec {

;; 6-typing.watsup:1084.1-1084.63
def in_numtype : (numtype, numtype*) -> bool
  ;; 6-typing.watsup:1085.1-1085.37
  def {epsilon : numtype*, nt : numtype} in_numtype(nt, epsilon) = false
  ;; 6-typing.watsup:1086.1-1086.68
  def {nt : numtype, nt'* : numtype*, nt_1 : numtype} in_numtype(nt, [nt_1] :: nt'*{nt'}) = ((nt = nt_1) \/ $in_numtype(nt, nt'*{nt'}))
}

;; 6-typing.watsup:1063.1-1063.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 6-typing.watsup:1067.1-1068.26
  rule const {C : context, c : c, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 6-typing.watsup:1070.1-1071.31
  rule vvconst {C : context, c_vt : c, vt : vectype}:
    `%|-%CONST`(C, VVCONST_instr(vt, c_vt))

  ;; 6-typing.watsup:1073.1-1074.27
  rule ref.null {C : context, ht : heaptype}:
    `%|-%CONST`(C, REF.NULL_instr(ht))

  ;; 6-typing.watsup:1076.1-1077.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 6-typing.watsup:1079.1-1081.24
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?()), t))

  ;; 6-typing.watsup:1092.1-1095.38
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%CONST`(C, BINOP_instr(nt, binop))
    -- if $in_numtype(nt, [I32_numtype I64_numtype])
    -- if $in_binop(binop, [ADD_ibinop SUB_ibinop MUL_ibinop])

;; 6-typing.watsup:1064.1-1064.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 6-typing.watsup:1098.1-1099.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 6-typing.watsup:1065.1-1065.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 6-typing.watsup:1102.1-1105.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 6-typing.watsup:1114.1-1114.73
relation Type_ok: `%|-%:%*`(context, type, deftype*)
  ;; 6-typing.watsup:1126.1-1130.53
  rule _ {C : context, dt* : deftype*, rectype : rectype, x : idx}:
    `%|-%:%*`(C, TYPE(rectype), dt*{dt})
    -- if (x = |C.TYPE_context|)
    -- if (dt*{dt} = $rolldt(x, rectype))
    -- Rectype_ok: `%|-%:%`(C[TYPE_context =.. dt*{dt}], rectype, OK_oktypeidx(x))

;; 6-typing.watsup:1116.1-1116.74
relation Local_ok: `%|-%:%`(context, local, localtype)
  ;; 6-typing.watsup:1132.1-1134.28
  rule set {C : context, t : valtype}:
    `%|-%:%`(C, LOCAL(t), `%%`(SET_init, t))
    -- if ($default(t) =/= ?())

  ;; 6-typing.watsup:1136.1-1138.26
  rule unset {C : context, t : valtype}:
    `%|-%:%`(C, LOCAL(t), `%%`(UNSET_init, t))
    -- if ($default(t) = ?())

;; 6-typing.watsup:1115.1-1115.73
relation Func_ok: `%|-%:%`(context, func, deftype)
  ;; 6-typing.watsup:1140.1-1144.82
  rule _ {C : context, expr : expr, local* : local*, lt* : localtype*, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, `FUNC%%*%`(x, local*{local}, expr), C.TYPE_context[x])
    -- Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- (Local_ok: `%|-%:%`(C, local, lt))*{local lt}
    -- Expr_ok: `%|-%:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL `%%`(SET_init, t_1)*{t_1} :: lt*{lt}, LABEL [], RETURN ?()} ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 6-typing.watsup:1117.1-1117.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 6-typing.watsup:1146.1-1150.40
  rule _ {C : context, expr : expr, gt : globaltype, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `%|-%:OK`(C, gt)
    -- if (gt = `%%`(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 6-typing.watsup:1118.1-1118.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 6-typing.watsup:1152.1-1156.41
  rule _ {C : context, expr : expr, limits : limits, rt : reftype, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt, expr), tt)
    -- Tabletype_ok: `%|-%:OK`(C, tt)
    -- if (tt = `%%`(limits, rt))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, (rt <: valtype))

;; 6-typing.watsup:1119.1-1119.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 6-typing.watsup:1158.1-1160.30
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `%|-%:OK`(C, mt)

;; 6-typing.watsup:1122.1-1122.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 6-typing.watsup:1171.1-1174.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 6-typing.watsup:1176.1-1177.20
  rule passive {C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; 6-typing.watsup:1179.1-1180.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 6-typing.watsup:1120.1-1120.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 6-typing.watsup:1162.1-1165.37
  rule _ {C : context, elemmode : elemmode, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%`(rt, expr*{expr}, elemmode), rt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, (rt <: valtype)))*{expr}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, rt)

;; 6-typing.watsup:1123.1-1123.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 6-typing.watsup:1182.1-1185.45
  rule active {C : context, expr : expr, mt : memtype, x : idx}:
    `%|-%:OK`(C, ACTIVE_datamode(x, expr))
    -- if (C.MEM_context[x] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 6-typing.watsup:1187.1-1188.20
  rule passive {C : context}:
    `%|-%:OK`(C, PASSIVE_datamode)

;; 6-typing.watsup:1121.1-1121.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 6-typing.watsup:1167.1-1169.37
  rule _ {C : context, b* : byte*, datamode : datamode}:
    `%|-%:OK`(C, `DATA%*%`(b*{b}, datamode))
    -- Datamode_ok: `%|-%:OK`(C, datamode)

;; 6-typing.watsup:1124.1-1124.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 6-typing.watsup:1190.1-1192.44
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`([], [])))

;; 6-typing.watsup:1197.1-1197.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 6-typing.watsup:1201.1-1203.33
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `%|-%:OK`(C, xt)

;; 6-typing.watsup:1199.1-1199.83
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; 6-typing.watsup:1210.1-1212.23
  rule func {C : context, dt : deftype, x : idx}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype(dt))
    -- if (C.FUNC_context[x] = dt)

  ;; 6-typing.watsup:1214.1-1216.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 6-typing.watsup:1218.1-1220.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 6-typing.watsup:1222.1-1224.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (C.MEM_context[x] = mt)

;; 6-typing.watsup:1198.1-1198.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 6-typing.watsup:1205.1-1207.39
  rule _ {C : context, externidx : externidx, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externidx), xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 6-typing.watsup:1231.1-1231.77
rec {

;; 6-typing.watsup:1231.1-1231.77
relation Globals_ok: `%|-%*:%*`(context, global*, globaltype*)
  ;; 6-typing.watsup:1274.1-1275.17
  rule empty {C : context}:
    `%|-%*:%*`(C, [], [])

  ;; 6-typing.watsup:1277.1-1280.54
  rule cons {C : context, global : global, global_1 : global, gt* : globaltype*, gt_1 : globaltype}:
    `%|-%*:%*`(C, [global_1] :: global*{}, [gt_1] :: gt*{gt})
    -- Global_ok: `%|-%:%`(C, global, gt_1)
    -- Globals_ok: `%|-%*:%*`(C[GLOBAL_context =.. [gt_1]], global*{}, gt*{gt})
}

;; 6-typing.watsup:1230.1-1230.75
rec {

;; 6-typing.watsup:1230.1-1230.75
relation Types_ok: `%|-%*:%*`(context, type*, deftype*)
  ;; 6-typing.watsup:1266.1-1267.17
  rule empty {C : context}:
    `%|-%*:%*`(C, [], [])

  ;; 6-typing.watsup:1269.1-1272.49
  rule cons {C : context, dt* : deftype*, dt_1 : deftype, type* : type*, type_1 : type}:
    `%|-%*:%*`(C, [type_1] :: type*{type}, dt_1*{} :: dt*{dt})
    -- Type_ok: `%|-%:%*`(C, type_1, [dt_1])
    -- Types_ok: `%|-%*:%*`(C[TYPE_context =.. dt_1*{}], type*{type}, dt*{dt})
}

;; 6-typing.watsup:1229.1-1229.76
relation Module_ok: `|-%:OK`(module)
  ;; 6-typing.watsup:1240.1-1263.29
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
  ;; 7-runtime-typing.watsup:7.1-8.35
  rule null {ht : heaptype, s : store}:
    `%|-%:%`(s, REF.NULL_ref(ht), REF_reftype(`NULL%?`(?(())), ht))

  ;; 7-runtime-typing.watsup:10.1-11.37
  rule i31 {i : nat, s : store}:
    `%|-%:%`(s, REF.I31_NUM_ref(i), REF_reftype(`NULL%?`(?()), I31_heaptype))

  ;; 7-runtime-typing.watsup:13.1-15.30
  rule struct {a : addr, dt : deftype, s : store}:
    `%|-%:%`(s, REF.STRUCT_ADDR_ref(a), REF_reftype(`NULL%?`(?()), (dt <: heaptype)))
    -- if (s.STRUCT_store[a].TYPE_structinst = dt)

  ;; 7-runtime-typing.watsup:17.1-19.29
  rule array {a : addr, dt : deftype, s : store}:
    `%|-%:%`(s, REF.ARRAY_ADDR_ref(a), REF_reftype(`NULL%?`(?()), (dt <: heaptype)))
    -- if (s.ARRAY_store[a].TYPE_arrayinst = dt)

  ;; 7-runtime-typing.watsup:21.1-23.28
  rule func {a : addr, dt : deftype, s : store}:
    `%|-%:%`(s, REF.FUNC_ADDR_ref(a), REF_reftype(`NULL%?`(?()), (dt <: heaptype)))
    -- if (s.FUNC_store[a].TYPE_funcinst = dt)

  ;; 7-runtime-typing.watsup:25.1-26.39
  rule host {a : addr, s : store}:
    `%|-%:%`(s, REF.HOST_ADDR_ref(a), REF_reftype(`NULL%?`(?()), ANY_heaptype))

  ;; 7-runtime-typing.watsup:28.1-29.45
  rule extern {addrref : addrref, s : store}:
    `%|-%:%`(s, REF.EXTERN_ref(addrref), REF_reftype(`NULL%?`(?()), EXTERN_heaptype))

;; 8-reduction.watsup:560.1-560.22
def vzero : c_vectype

;; 8-reduction.watsup:6.1-6.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 8-reduction.watsup:42.1-43.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 8-reduction.watsup:45.1-46.15
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 8-reduction.watsup:48.1-49.20
  rule drop {val : val}:
    `%*~>%*`([(val <: admininstr) DROP_admininstr], [])

  ;; 8-reduction.watsup:52.1-54.16
  rule select-true {c : c, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([(val_1 <: admininstr) (val_2 <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [(val_1 <: admininstr)])
    -- if (c =/= 0)

  ;; 8-reduction.watsup:56.1-58.14
  rule select-false {c : c, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([(val_1 <: admininstr) (val_2 <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [(val_2 <: admininstr)])
    -- if (c = 0)

  ;; 8-reduction.watsup:76.1-78.16
  rule if-true {bt : blocktype, c : c, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 8-reduction.watsup:80.1-82.14
  rule if-false {bt : blocktype, c : c, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 8-reduction.watsup:85.1-86.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, (val <: admininstr)*{val})], (val <: admininstr)*{val})

  ;; 8-reduction.watsup:92.1-93.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [BR_admininstr(0)] :: (instr <: admininstr)*{instr})], (val <: admininstr)^n{val} :: (instr' <: admininstr)*{instr'})

  ;; 8-reduction.watsup:95.1-96.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val <: admininstr)*{val} :: [BR_admininstr(l + 1)] :: (instr <: admininstr)*{instr})], (val <: admininstr)*{val} :: [BR_admininstr(l)])

  ;; 8-reduction.watsup:99.1-101.16
  rule br_if-true {c : c, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 8-reduction.watsup:103.1-105.14
  rule br_if-false {c : c, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 8-reduction.watsup:108.1-110.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 8-reduction.watsup:112.1-114.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 8-reduction.watsup:117.1-119.26
  rule br_on_null-null {ht : heaptype, l : labelidx, val : val}:
    `%*~>%*`([(val <: admininstr) BR_ON_NULL_admininstr(l)], [BR_admininstr(l)])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup:121.1-123.15
  rule br_on_null-addr {l : labelidx, val : val}:
    `%*~>%*`([(val <: admininstr) BR_ON_NULL_admininstr(l)], [(val <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup:126.1-128.26
  rule br_on_non_null-null {ht : heaptype, l : labelidx, val : val}:
    `%*~>%*`([(val <: admininstr) BR_ON_NON_NULL_admininstr(l)], [])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup:130.1-132.15
  rule br_on_non_null-addr {l : labelidx, val : val}:
    `%*~>%*`([(val <: admininstr) BR_ON_NON_NULL_admininstr(l)], [(val <: admininstr) BR_admininstr(l)])
    -- otherwise

  ;; 8-reduction.watsup:186.1-187.84
  rule call_indirect-call {x : idx, y : idx}:
    `%*~>%*`([CALL_INDIRECT_admininstr(x, y)], [TABLE.GET_admininstr(x) REF.CAST_admininstr(REF_reftype(`NULL%?`(?(())), ($idx(y) <: heaptype))) CALL_REF_admininstr(?(y))])

  ;; 8-reduction.watsup:189.1-190.98
  rule return_call_indirect {x : idx, y : idx}:
    `%*~>%*`([RETURN_CALL_INDIRECT_admininstr(x, y)], [TABLE.GET_admininstr(x) REF.CAST_admininstr(REF_reftype(`NULL%?`(?(())), ($idx(y) <: heaptype))) RETURN_CALL_REF_admininstr(?(y))])

  ;; 8-reduction.watsup:193.1-194.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, (val <: admininstr)^n{val})], (val <: admininstr)^n{val})

  ;; 8-reduction.watsup:196.1-197.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [RETURN_admininstr] :: (instr <: admininstr)*{instr})], (val <: admininstr)^n{val})

  ;; 8-reduction.watsup:199.1-200.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, (val <: admininstr)*{val} :: [RETURN_admininstr] :: (instr <: admininstr)*{instr})], (val <: admininstr)*{val} :: [RETURN_admininstr])

  ;; 8-reduction.watsup:205.1-207.33
  rule unop-val {c : c, c_1 : c, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 8-reduction.watsup:209.1-211.35
  rule unop-trap {c_1 : c, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 8-reduction.watsup:214.1-216.40
  rule binop-val {binop : binop_numtype, c : c, c_1 : c, c_2 : c, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 8-reduction.watsup:218.1-220.42
  rule binop-trap {binop : binop_numtype, c_1 : c, c_2 : c, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 8-reduction.watsup:223.1-225.37
  rule testop {c : c, c_1 : c, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 8-reduction.watsup:227.1-229.40
  rule relop {c : c, c_1 : c, c_2 : c, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 8-reduction.watsup:232.1-233.70
  rule extend {c : c, n : n, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, $size(nt <: valtype), S_sx, c))])

  ;; 8-reduction.watsup:236.1-238.48
  rule cvtop-val {c : c, c_1 : c, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(cvtop, nt_1, nt_2, sx?{sx}, c_1) = [c])

  ;; 8-reduction.watsup:240.1-242.50
  rule cvtop-trap {c_1 : c, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(cvtop, nt_1, nt_2, sx?{sx}, c_1) = [])

  ;; 8-reduction.watsup:250.1-251.60
  rule ref.i31 {i : nat}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) REF.I31_admininstr], [REF.I31_NUM_admininstr($wrap(32, 31, i))])

  ;; 8-reduction.watsup:254.1-256.28
  rule ref.is_null-true {ht : heaptype, val : val}:
    `%*~>%*`([(val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup:258.1-260.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([(val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:263.1-265.28
  rule ref.as_non_null-null {ht : heaptype, ref : ref}:
    `%*~>%*`([(ref <: admininstr) REF.AS_NON_NULL_admininstr], [TRAP_admininstr])
    -- if (ref = REF.NULL_ref(ht))

  ;; 8-reduction.watsup:267.1-269.15
  rule ref.as_non_null-addr {ref : ref}:
    `%*~>%*`([(ref <: admininstr) REF.AS_NON_NULL_admininstr], [(ref <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup:272.1-274.55
  rule ref.eq-null {ht_1 : heaptype, ht_2 : heaptype, ref_1 : ref, ref_2 : ref}:
    `%*~>%*`([(ref_1 <: admininstr) (ref_2 <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if ((ref_1 = REF.NULL_ref(ht_1)) /\ (ref_2 = REF.NULL_ref(ht_2)))

  ;; 8-reduction.watsup:276.1-279.22
  rule ref.eq-true {ref_1 : ref, ref_2 : ref}:
    `%*~>%*`([(ref_1 <: admininstr) (ref_2 <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- otherwise
    -- if (ref_1 = ref_2)

  ;; 8-reduction.watsup:281.1-283.15
  rule ref.eq-false {ref_1 : ref, ref_2 : ref}:
    `%*~>%*`([(ref_1 <: admininstr) (ref_2 <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:308.1-309.39
  rule i31.get-null {ht : heaptype, sx : sx}:
    `%*~>%*`([REF.NULL_admininstr(ht) I31.GET_admininstr(sx)], [TRAP_admininstr])

  ;; 8-reduction.watsup:311.1-312.68
  rule i31.get-num {i : nat, sx : sx}:
    `%*~>%*`([REF.I31_NUM_admininstr(i) I31.GET_admininstr(sx)], [CONST_admininstr(I32_numtype, $ext(31, 32, sx, i))])

  ;; 8-reduction.watsup:529.1-530.58
  rule extern.convert_any-null {ht : heaptype}:
    `%*~>%*`([REF.NULL_admininstr(ht) EXTERN.CONVERT_ANY_admininstr], [REF.NULL_admininstr(EXTERN_heaptype)])

  ;; 8-reduction.watsup:532.1-533.55
  rule extern.convert_any-addr {addrref : addrref}:
    `%*~>%*`([(addrref <: admininstr) EXTERN.CONVERT_ANY_admininstr], [REF.EXTERN_admininstr(addrref)])

  ;; 8-reduction.watsup:536.1-537.55
  rule any.convert_extern-null {ht : heaptype}:
    `%*~>%*`([REF.NULL_admininstr(ht) ANY.CONVERT_EXTERN_admininstr], [REF.NULL_admininstr(ANY_heaptype)])

  ;; 8-reduction.watsup:539.1-540.55
  rule any.convert_extern-addr {addrref : addrref}:
    `%*~>%*`([REF.EXTERN_admininstr(addrref) ANY.CONVERT_EXTERN_admininstr], [(addrref <: admininstr)])

  ;; 8-reduction.watsup:545.1-547.41
  rule vvunop {cv : c_vectype, cv_1 : c_vectype, vvunop : unop_vvectype}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VVUNOP_admininstr(V128_vectype, vvunop)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if ($vvunop(vvunop, V128_vectype, cv_1) = cv)

  ;; 8-reduction.watsup:550.1-552.49
  rule vvbinop {cv : c_vectype, cv_1 : c_vectype, cv_2 : c_vectype, vvbinop : binop_vvectype}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VVCONST_admininstr(V128_vectype, cv_2) VVBINOP_admininstr(V128_vectype, vvbinop)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if ($vvbinop(vvbinop, V128_vectype, cv_1, cv_2) = cv)

  ;; 8-reduction.watsup:555.1-557.57
  rule vvternop {cv : c_vectype, cv_1 : c_vectype, cv_2 : c_vectype, cv_3 : c_vectype, vvternop : ternop_vvectype}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VVCONST_admininstr(V128_vectype, cv_2) VVCONST_admininstr(V128_vectype, cv_3) VVTERNOP_admininstr(V128_vectype, vvternop)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if ($vvternop(vvternop, V128_vectype, cv_1, cv_2, cv_3) = cv)

  ;; 8-reduction.watsup:561.1-563.36
  rule vvtestop {cv_1 : c_vectype, i : nat}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VVTESTOP_admininstr(V128_vectype, _VV_testop_vvectype(ANY_TRUE_testopVVXX))], [CONST_admininstr(I32_numtype, i)])
    -- if (i = $ine(128, cv_1, $vzero))

  ;; 8-reduction.watsup:566.1-571.47
  rule vswizzle {c* : c*, cv' : c_vectype, cv_1 : c_vectype, cv_2 : c_vectype, i* : nat*, k^lns : nat^lns, lns : lanesize, lnt : lanetype, sh : shape}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VVCONST_admininstr(V128_vectype, cv_2) VSWIZZLE_admininstr(sh)], [VVCONST_admininstr(V128_vectype, cv')])
    -- if (sh = `%X%`(lnt, lns))
    -- if (i*{i} = $lanes(sh, cv_2))
    -- if (c*{c} = $lanes(sh, cv_1) :: 0^(256 - lns){})
    -- if ($lanes(sh, cv') = c*{c}[i*{i}[k]]^(k<lns){k})

  ;; 8-reduction.watsup:574.1-578.52
  rule vshuffle {cv : c_vectype, cv_1 : c_vectype, cv_2 : c_vectype, i* : nat*, k^lns : nat^lns, laneidx* : laneidx*, lns : lanesize, lnt : lanetype, sh : shape}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VVCONST_admininstr(V128_vectype, cv_2) VSHUFFLE_admininstr(sh, laneidx*{laneidx})], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (sh = `%X%`(lnt, lns))
    -- if (i*{i} = $lanes(sh, cv_1) :: $lanes(sh, cv_2))
    -- if ($lanes(sh, cv) = i*{i}[laneidx*{laneidx}[k]]^(k<lns){k})

  ;; 8-reduction.watsup:581.1-584.38
  rule vsplat {c_1 : c, cv : c_vectype, nt : numtype, sh : shape}:
    `%*~>%*`([CONST_admininstr(nt, c_1) VSPLAT_admininstr(sh)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (nt = $unpacked(sh))
    -- if ($lanes(sh, cv) = c_1^$dim(sh){})

  ;; 8-reduction.watsup:587.1-591.76
  rule vextract_lane-num {c_2 : c, cv_1 : c_vectype, laneidx : laneidx, lns : lanesize, lnt : lanetype, nt : numtype, sh : shape}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VEXTRACT_LANE_admininstr(sh, ?(), laneidx)], [CONST_admininstr(nt, c_2)])
    -- if (nt = $unpacked(sh))
    -- if (sh = `%X%`(lnt, lns))
    -- if (c_2 = $ext($lanesize(lnt), $size(nt <: valtype), U_sx, $lanes(sh, cv_1)[laneidx]))

  ;; 8-reduction.watsup:593.1-597.77
  rule vextract_lane-pack {c_2 : c, cv_1 : c_vectype, laneidx : laneidx, lns : lanesize, lnt : lanetype, nt : numtype, sh : shape, sx : sx}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VEXTRACT_LANE_admininstr(sh, ?(sx), laneidx)], [CONST_admininstr(nt, c_2)])
    -- if (nt = $unpacked(sh))
    -- if (sh = `%X%`(lnt, lns))
    -- if (c_2 = $ext($lanesize(lnt), $size(nt <: valtype), sx, $lanes(sh, cv_1)[laneidx]))

  ;; 8-reduction.watsup:600.1-603.47
  rule vreplace_lane {c_2 : c, cv : c_vectype, cv_1 : c_vectype, i* : nat*, laneidx : laneidx, nt : numtype, sh : shape}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) CONST_admininstr(nt, c_2) VREPLACE_LANE_admininstr(sh, laneidx)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (i*{i} = $lanes(sh, cv_1))
    -- if ($lanes(sh, cv) = i*{i}[[laneidx] = c_2])

  ;; 8-reduction.watsup:606.1-608.37
  rule vunop {cv : c_vectype, cv_1 : c_vectype, sh : shape, vunop : unop_vectype}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VUNOP_admininstr(sh, vunop)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (cv = $vunop(vunop, sh, cv_1))

  ;; 8-reduction.watsup:611.1-613.45
  rule vbinop-val {cv : c_vectype, cv_1 : c_vectype, cv_2 : c_vectype, sh : shape, vbinop : binop_vectype}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VVCONST_admininstr(V128_vectype, cv_2) VBINOP_admininstr(sh, vbinop)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if ($vbinop(vbinop, sh, cv_1, cv_2) = [cv])

  ;; 8-reduction.watsup:615.1-617.46
  rule vbinop-trap {cv_1 : c_vectype, cv_2 : c_vectype, sh : shape, vbinop : binop_vectype}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VVCONST_admininstr(V128_vectype, cv_2) VBINOP_admininstr(sh, vbinop)], [TRAP_admininstr])
    -- if ($vbinop(vbinop, sh, cv_1, cv_2) = [])

  ;; 8-reduction.watsup:620.1-625.80
  rule vrelop {cv : c_vectype, cv_1 : c_vectype, cv_2 : c_vectype, i* : nat*, j* : nat*, lns : lanesize, lnt : lanetype, sh : shape, vrelop : relop_vectype}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VVCONST_admininstr(V128_vectype, cv_2) VRELOP_admininstr(sh, vrelop)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (i*{i} = $lanes(sh, cv_1))
    -- if (j*{j} = $lanes(sh, cv_2))
    -- if (sh = `%X%`(lnt, lns))
    -- if ($lanes(sh, cv) = $ext(1, $lanesize(lnt), S_sx, $vrelop(vrelop, sh, i, j))*{i j})

  ;; 8-reduction.watsup:628.1-632.59
  rule vishiftop {cv : c_vectype, cv_1 : c_vectype, i* : nat*, lns : lanesize, lnt : lanetype, n : n, sh : shape, vishiftop : shiftop_vectype}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) CONST_admininstr(I32_numtype, n) VISHIFTOP_admininstr(sh, vishiftop)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (sh = `%X%`(lnt, lns))
    -- if (i*{i} = $lanes(sh, cv_1))
    -- if ($lanes(sh, cv) = $vishiftop(vishiftop, lnt, i, n)*{i})

  ;; 8-reduction.watsup:635.1-638.24
  rule vall_true-true {cv : c_vectype, i_1* : nat*, sh : shape}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv) VALL_TRUE_admininstr(sh)], [CONST_admininstr(I32_numtype, 1)])
    -- if (i_1*{i_1} = $lanes(sh, cv))
    -- (if (i_1 =/= 0))*{i_1}

  ;; 8-reduction.watsup:640.1-642.15
  rule vall_true-false {cv : c_vectype, sh : shape}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv) VALL_TRUE_admininstr(sh)], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:645.1-649.60
  rule vbitmask {cv : c_vectype, i : nat, i_1^lns : nat^lns, lns : lanesize, lnt : lanetype, sh : shape}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv) VBITMASK_admininstr(sh)], [CONST_admininstr(I32_numtype, i)])
    -- if (sh = `%X%`(lnt, lns))
    -- if (i_1^lns{i_1} = $lanes(sh, cv))
    -- if ($ibits(32, i) = $ilt(S_sx, $lanesize(lnt), i_1, 0)^lns{i_1})

  ;; 8-reduction.watsup:652.1-660.47
  rule vnarrow {cv : c_vectype, cv_1 : c_vectype, cv_2 : c_vectype, i_1^lns_1 : nat^lns_1, i_2^lns_1 : nat^lns_1, lns_1 : lanesize, lns_2 : lanesize, lnt_1 : lanetype, lnt_2 : lanetype, n_1^lns_1 : n^lns_1, n_2^lns_1 : n^lns_1, sh_1 : shape, sh_2 : shape, sx : sx}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VVCONST_admininstr(V128_vectype, cv_2) VNARROW_admininstr(sh_2, sh_1, sx)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (sh_1 = `%X%`(lnt_1, lns_1))
    -- if (sh_2 = `%X%`(lnt_2, lns_2))
    -- if (i_1^lns_1{i_1} = $lanes(sh_1, cv_1))
    -- if (i_2^lns_1{i_2} = $lanes(sh_1, cv_2))
    -- if (n_1^lns_1{n_1} = $narrow($lanesize(lnt_1), $lanesize(lnt_2), sx, i_1)^lns_1{i_1})
    -- if (n_2^lns_1{n_2} = $narrow($lanesize(lnt_1), $lanesize(lnt_2), sx, i_2)^lns_1{i_2})
    -- if ($lanes(sh_2, cv) = n_1^lns_1{n_1} :: n_2^lns_1{n_2})

  ;; 8-reduction.watsup:663.1-668.87
  rule vcvtop-normal {cv : c_vectype, cv_1 : c_vectype, i* : nat*, lns_1 : lanesize, lns_2 : lanesize, lnt_1 : lanetype, lnt_2 : lanetype, sh_1 : shape, sh_2 : shape, sx : sx, vcvtop : cvtop_vectype}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VCVTOP_admininstr(sh_2, vcvtop, ?(), sh_1, ?(sx), `ZERO%?`(?()))], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (sh_1 = `%X%`(lnt_1, lns_1))
    -- if (sh_2 = `%X%`(lnt_2, lns_2))
    -- if (i*{i} = $lanes(sh_1, cv_1))
    -- if ($lanes(sh_2, cv) = $vcvtop(vcvtop, $lanesize(lnt_1), $lanesize(lnt_2), ?(sx), i)*{i})

  ;; 8-reduction.watsup:671.1-676.88
  rule vcvtop-half {cv : c_vectype, cv_1 : c_vectype, hf : half, i* : nat*, lns_1 : lanesize, lns_2 : lanesize, lnt_1 : lanetype, lnt_2 : lanetype, sh_1 : shape, sh_2 : shape, sx? : sx?, vcvtop : cvtop_vectype}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VCVTOP_admininstr(sh_2, vcvtop, ?(hf), sh_1, sx?{sx}, `ZERO%?`(?()))], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (sh_1 = `%X%`(lnt_1, lns_1))
    -- if (sh_2 = `%X%`(lnt_2, lns_2))
    -- if (i*{i} = $lanes(sh_1, cv_1)[$halfop(hf, 0, lns_2) : lns_2])
    -- if ($lanes(sh_2, cv) = $vcvtop(vcvtop, $lanesize(lnt_1), $lanesize(lnt_2), sx?{sx}, i)*{i})

  ;; 8-reduction.watsup:679.1-684.96
  rule vcvtop-zero {cv : c_vectype, cv_1 : c_vectype, i* : nat*, lns_1 : lanesize, lns_2 : lanesize, lnt_1 : lanetype, lnt_2 : lanetype, sh_1 : shape, sh_2 : shape, sx? : sx?, vcvtop : cvtop_vectype}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VCVTOP_admininstr(sh_2, vcvtop, ?(), sh_1, sx?{sx}, `ZERO%?`(?(())))], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (sh_1 = `%X%`(lnt_1, lns_1))
    -- if (sh_2 = `%X%`(lnt_2, lns_2))
    -- if (i*{i} = $lanes(sh_1, cv_1))
    -- if ($lanes(sh_2, cv) = $vcvtop(vcvtop, $lanesize(lnt_1), $lanesize(lnt_2), sx?{sx}, i)*{i} :: 0^lns_1{})

  ;; 8-reduction.watsup:687.1-697.31
  rule vdot {cv : c_vectype, cv_1 : c_vectype, cv_2 : c_vectype, i_1 : nat, i_2 : nat, j'* : nat*, j_1* : nat*, j_2* : nat*, k' : nat, k_1^k' : nat^k', k_2^k' : nat^k', lns_1 : lanesize, lns_2 : lanesize, lnt_1 : lanetype, lnt_2 : lanetype, sh_1 : shape, sh_2 : shape}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VVCONST_admininstr(V128_vectype, cv_2) VDOT_admininstr(sh_1, sh_2, S_sx)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (sh_1 = `%X%`(lnt_1, lns_1))
    -- if (sh_2 = `%X%`(lnt_2, lns_2))
    -- if (i_1 = $lanesize(lnt_1))
    -- if (i_2 = $lanesize(lnt_2))
    -- if (k_1^k'{k_1} = $lanes(sh_2, cv_1))
    -- if (k_2^k'{k_2} = $lanes(sh_2, cv_2))
    -- if ($concat_bytes([j_1 j_2]*{j_1 j_2}) = $imul(i_1, $ext(i_2, i_1, S_sx, k_1), $ext(i_2, i_1, S_sx, k_2))^k'{k_1 k_2})
    -- if (j'*{j'} = $iadd(i_1, j_1, j_2)*{j_1 j_2})
    -- if ($lanes(sh_1, cv) = j'*{j'})

  ;; 8-reduction.watsup:700.1-706.151
  rule vextmul {cv : c_vectype, cv_1 : c_vectype, cv_2 : c_vectype, hf : half, i^k : nat^k, j^k : nat^k, k : nat, lns_1 : lanesize, lns_2 : lanesize, lnt_1 : lanetype, lnt_2 : lanetype, sh_1 : shape, sh_2 : shape, sx : sx}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VVCONST_admininstr(V128_vectype, cv_2) VEXTMUL_admininstr(sh_2, hf, sh_1, sx)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (sh_1 = `%X%`(lnt_1, lns_1))
    -- if (sh_2 = `%X%`(lnt_2, lns_2))
    -- if (i^k{i} = $lanes(sh_1, cv_1)[$halfop(hf, 0, lns_2) : lns_2])
    -- if (j^k{j} = $lanes(sh_1, cv_2)[$halfop(hf, 0, lns_2) : lns_2])
    -- if ($lanes(sh_2, cv) = $imul($lanesize(lnt_2), $ext($lanesize(lnt_1), $lanesize(lnt_2), sx, i), $ext($lanesize(lnt_1), $lanesize(lnt_2), sx, j))^k{i j})

  ;; 8-reduction.watsup:709.1-716.30
  rule vextadd_pairwise {cv : c_vectype, cv_1 : c_vectype, i^k : nat^k, i_1* : nat*, i_2* : nat*, j* : nat*, k : nat, lns_1 : lanesize, lns_2 : lanesize, lnt_1 : lanetype, lnt_2 : lanetype, sh_1 : shape, sh_2 : shape, sx : sx}:
    `%*~>%*`([VVCONST_admininstr(V128_vectype, cv_1) VEXTADD_PAIRWISE_admininstr(sh_2, sh_1, sx)], [VVCONST_admininstr(V128_vectype, cv)])
    -- if (sh_1 = `%X%`(lnt_1, lns_1))
    -- if (sh_2 = `%X%`(lnt_2, lns_2))
    -- if (i^k{i} = $lanes(sh_1, cv_1))
    -- if ($concat_bytes([i_1 i_2]*{i_1 i_2}) = $ext($lanesize(lnt_1), $lanesize(lnt_2), sx, i)^k{i})
    -- if (j*{j} = $iadd($lanesize(lnt_2), i_1, i_2)*{i_1 i_2})
    -- if ($lanes(sh_2, cv) = j*{j})

  ;; 8-reduction.watsup:729.1-730.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([(val <: admininstr) LOCAL.TEE_admininstr(x)], [(val <: admininstr) (val <: admininstr) LOCAL.SET_admininstr(x)])

;; 8-reduction.watsup:63.1-63.73
def blocktype : (state, blocktype) -> functype
  ;; 8-reduction.watsup:64.1-64.44
  def {z : state} blocktype(z, _RESULT_blocktype(?())) = `%->%`([], [])
  ;; 8-reduction.watsup:65.1-65.40
  def {t : valtype, z : state} blocktype(z, _RESULT_blocktype(?(t))) = `%->%`([], [t])
  ;; 8-reduction.watsup:66.1-66.66
  def {ft : functype, x : idx, z : state} blocktype(z, _IDX_blocktype(x)) = ft
    -- Expand: `%~~%`($type(z, x), FUNC_comptype(ft))

;; 8-reduction.watsup:7.1-7.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 8-reduction.watsup:68.1-70.43
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, (val <: admininstr)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})]), [LABEL__admininstr(n, [], (val <: admininstr)^k{val} :: (instr <: admininstr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 8-reduction.watsup:72.1-74.43
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, (val <: admininstr)^k{val} :: [LOOP_admininstr(bt, instr*{instr})]), [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], (val <: admininstr)^k{val} :: (instr <: admininstr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 8-reduction.watsup:135.1-138.66
  rule br_on_cast-succeed {l : labelidx, ref : ref, rt : reftype, rt_1 : reftype, rt_2 : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) BR_ON_CAST_admininstr(l, rt_1, rt_2)]), [(ref <: admininstr) BR_admininstr(l)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))

  ;; 8-reduction.watsup:140.1-142.15
  rule br_on_cast-fail {l : labelidx, ref : ref, rt_1 : reftype, rt_2 : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) BR_ON_CAST_admininstr(l, rt_1, rt_2)]), [(ref <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup:145.1-148.66
  rule br_on_cast_fail-succeed {l : labelidx, ref : ref, rt : reftype, rt_1 : reftype, rt_2 : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) BR_ON_CAST_FAIL_admininstr(l, rt_1, rt_2)]), [(ref <: admininstr)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))

  ;; 8-reduction.watsup:150.1-152.15
  rule br_on_cast_fail-fail {l : labelidx, ref : ref, rt_1 : reftype, rt_2 : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) BR_ON_CAST_FAIL_admininstr(l, rt_1, rt_2)]), [(ref <: admininstr) BR_admininstr(l)])
    -- otherwise

  ;; 8-reduction.watsup:157.1-158.62
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x]) CALL_REF_admininstr(?())])

  ;; 8-reduction.watsup:160.1-161.43
  rule call_ref-null {ht : heaptype, x? : idx?, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CALL_REF_admininstr(x?{x})]), [TRAP_admininstr])

  ;; 8-reduction.watsup:163.1-168.59
  rule call_ref-func {a : addr, f : frame, fi : funcinst, instr* : instr*, m : m, n : n, t* : valtype*, t_1^n : valtype^n, t_2^m : valtype^m, val^n : val^n, x? : idx?, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, (val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a) CALL_REF_admininstr(x?{x})]), [FRAME__admininstr(m, f, [LABEL__admininstr(m, [], (instr <: admininstr)*{instr})])])
    -- if ($funcinst(z)[a] = fi)
    -- Expand: `%~~%`(fi.TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
    -- if (fi.CODE_funcinst = `FUNC%%*%`(y, LOCAL(t)*{t}, instr*{instr}))
    -- if (f = {LOCAL ?(val)^n{val} :: $default(t)*{t}, MODULE fi.MODULE_funcinst})

  ;; 8-reduction.watsup:171.1-172.76
  rule return_call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [RETURN_CALL_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x]) RETURN_CALL_REF_admininstr(?())])

  ;; 8-reduction.watsup:175.1-176.78
  rule return_call_ref-frame-null {f : frame, ht : heaptype, instr* : instr*, k : nat, val* : val*, x? : idx?, z : state}:
    `%~>%*`(`%;%*`(z, [FRAME__admininstr(k, f, (val <: admininstr)*{val} :: [REF.NULL_admininstr(ht)] :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr <: admininstr)*{instr})]), [TRAP_admininstr])

  ;; 8-reduction.watsup:178.1-180.59
  rule return_call_ref-frame-addr {a : addr, f : frame, instr* : instr*, k : nat, m : m, n : n, t_1^n : valtype^n, t_2^m : valtype^m, val^n : val^n, val'* : val*, x? : idx?, z : state}:
    `%~>%*`(`%;%*`(z, [FRAME__admininstr(k, f, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a)] :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr <: admininstr)*{instr})]), (val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a) CALL_REF_admininstr(x?{x})])
    -- Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))

  ;; 8-reduction.watsup:182.1-183.91
  rule return_call_ref-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*, x? : idx?, z : state}:
    `%~>%*`(`%;%*`(z, [LABEL__admininstr(k, instr'*{instr'}, (val <: admininstr)*{val} :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr <: admininstr)*{instr})]), (val <: admininstr)*{val} :: [RETURN_CALL_REF_admininstr(x?{x})])

  ;; 8-reduction.watsup:247.1-248.55
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

  ;; 8-reduction.watsup:286.1-289.65
  rule ref.test-true {ref : ref, rt : reftype, rt' : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) REF.TEST_admininstr(rt)]), [CONST_admininstr(I32_numtype, 1)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))

  ;; 8-reduction.watsup:291.1-293.15
  rule ref.test-false {ref : ref, rt : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) REF.TEST_admininstr(rt)]), [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:296.1-299.65
  rule ref.cast-succeed {ref : ref, rt : reftype, rt' : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) REF.CAST_admininstr(rt)]), [(ref <: admininstr)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))

  ;; 8-reduction.watsup:301.1-303.15
  rule ref.cast-fail {ref : ref, rt : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) REF.CAST_admininstr(rt)]), [TRAP_admininstr])
    -- otherwise

  ;; 8-reduction.watsup:322.1-325.43
  rule struct.new_default {mut* : mut*, val* : val*, x : idx, z : state, zt* : storagetype*}:
    `%~>%*`(`%;%*`(z, [STRUCT.NEW_DEFAULT_admininstr(x)]), (val <: admininstr)*{val} :: [STRUCT.NEW_admininstr(x)])
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- (if ($default($unpacktype(zt)) = ?(val)))*{val zt}

  ;; 8-reduction.watsup:328.1-329.50
  rule struct.get-null {ht : heaptype, i : nat, sx? : sx?, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) STRUCT.GET_admininstr(sx?{sx}, x, i)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:331.1-334.41
  rule struct.get-struct {a : addr, i : nat, mut* : mut*, si : structinst, sx? : sx?, x : idx, z : state, zt* : storagetype*}:
    `%~>%*`(`%;%*`(z, [REF.STRUCT_ADDR_admininstr(a) STRUCT.GET_admininstr(sx?{sx}, x, i)]), [($unpackval(zt*{zt}[i], sx?{sx}, si.FIELD_structinst[i]) <: admininstr)])
    -- if ($structinst(z)[a] = si)
    -- Expand: `%~~%`(si.TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))

  ;; 8-reduction.watsup:348.1-349.70
  rule array.new {n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [(val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.NEW_admininstr(x)]), (val <: admininstr)^n{} :: [ARRAY.NEW_FIXED_admininstr(x, n)])

  ;; 8-reduction.watsup:351.1-354.40
  rule array.new_default {mut : mut, n : n, val : val, x : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) ARRAY.NEW_DEFAULT_admininstr(x)]), (val <: admininstr)^n{} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ($default($unpacktype(zt)) = ?(val))

  ;; 8-reduction.watsup:362.1-364.38
  rule array.new_elem-oob {i : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$elem(z, y).ELEM_eleminst|)

  ;; 8-reduction.watsup:366.1-368.40
  rule array.new_elem-alloc {i : nat, n : n, ref^n : ref^n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_ELEM_admininstr(x, y)]), (ref <: admininstr)^n{ref} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- if (ref^n{ref} = $elem(z, y).ELEM_eleminst[i : n])

  ;; 8-reduction.watsup:371.1-374.59
  rule array.new_data-oob {i : nat, mut : mut, n : n, x : idx, y : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ((i + ((n * $storagesize(zt)) / 8)) > |$data(z, y).DATA_datainst|)

  ;; 8-reduction.watsup:376.1-380.88
  rule array.new_data-alloc {c^n : c^n, i : nat, mut : mut, n : n, nt : numtype, x : idx, y : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_DATA_admininstr(x, y)]), CONST_admininstr(nt, c)^n{c} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (nt = $unpacknumtype(zt))
    -- if ($concat_bytes($ztbytes(zt, c)^n{c}) = $data(z, y).DATA_datainst[i : ((n * $storagesize(zt)) / 8)])

  ;; 8-reduction.watsup:383.1-384.61
  rule array.get-null {ht : heaptype, i : nat, sx? : sx?, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) ARRAY.GET_admininstr(sx?{sx}, x)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:386.1-388.38
  rule array.get-oob {a : addr, i : nat, sx? : sx?, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) ARRAY.GET_admininstr(sx?{sx}, x)]), [TRAP_admininstr])
    -- if (i >= |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:390.1-393.53
  rule array.get-array {a : addr, fv : fieldval, i : nat, mut : mut, sx? : sx?, x : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) ARRAY.GET_admininstr(sx?{sx}, x)]), [($unpackval(zt, sx?{sx}, fv) <: admininstr)])
    -- if (fv = $arrayinst(z)[a].FIELD_arrayinst[i])
    -- Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))

  ;; 8-reduction.watsup:409.1-410.39
  rule array.len-null {ht : heaptype, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) ARRAY.LEN_admininstr]), [TRAP_admininstr])

  ;; 8-reduction.watsup:412.1-414.37
  rule array.len-array {a : addr, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) ARRAY.LEN_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (n = |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:417.1-418.76
  rule array.fill-null {ht : heaptype, i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:420.1-422.44
  rule array.fill-oob {a : addr, i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:424.1-427.14
  rule array.fill-zero {a : addr, i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:429.1-433.15
  rule array.fill-succ {a : addr, i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup:435.1-436.102
  rule array.copy-null1 {ht_1 : heaptype, i_1 : nat, i_2 : nat, n : n, ref : ref, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht_1) CONST_admininstr(I32_numtype, i_1) (ref <: admininstr) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:438.1-439.102
  rule array.copy-null2 {ht_2 : heaptype, i_1 : nat, i_2 : nat, n : n, ref : ref, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, i_1) REF.NULL_admininstr(ht_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:441.1-443.48
  rule array.copy-oob1 {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if ((i_1 + n) > |$arrayinst(z)[a_1].FIELD_arrayinst|)

  ;; 8-reduction.watsup:445.1-447.48
  rule array.copy-oob2 {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if ((i_2 + n) > |$arrayinst(z)[a_2].FIELD_arrayinst|)

  ;; 8-reduction.watsup:449.1-452.14
  rule array.copy-zero {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:454.1-463.19
  rule array.copy-le {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, mut : mut, n : n, sx? : sx?, x_1 : idx, x_2 : idx, z : state, zt_2 : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) ARRAY.GET_admininstr(sx?{sx}, x_2) ARRAY.SET_admininstr(x_1) REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, (i_1 + 1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, (i_2 + 1)) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
    -- if (sx?{sx} = $sxfield(zt_2))
    -- if (i_1 <= i_2)

  ;; 8-reduction.watsup:465.1-473.29
  rule array.copy-gt {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, mut : mut, n : n, sx? : sx?, x_1 : idx, x_2 : idx, z : state, zt_2 : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, ((i_1 + n) - 1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, ((i_2 + n) - 1)) ARRAY.GET_admininstr(sx?{sx}, x_2) ARRAY.SET_admininstr(x_1) REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
    -- if (sx?{sx} = $sxfield(zt_2))

  ;; 8-reduction.watsup:476.1-477.93
  rule array.init_elem-null {ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:479.1-481.44
  rule array.init_elem-oob1 {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:483.1-485.38
  rule array.init_elem-oob2 {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((j + n) > |$elem(z, y).ELEM_eleminst|)

  ;; 8-reduction.watsup:487.1-490.14
  rule array.init_elem-zero {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:492.1-497.34
  rule array.init_elem-succ {a : addr, i : nat, j : nat, n : n, ref : ref, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (ref <: admininstr) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.INIT_ELEM_admininstr(x, y)])
    -- otherwise
    -- if (ref = $elem(z, y).ELEM_eleminst[j])

  ;; 8-reduction.watsup:500.1-501.93
  rule array.init_data-null {ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:503.1-505.44
  rule array.init_data-oob1 {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:507.1-510.59
  rule array.init_data-oob2 {a : addr, i : nat, j : nat, mut : mut, n : n, x : idx, y : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ((j + ((n * $storagesize(zt)) / 8)) > |$data(z, y).DATA_datainst|)

  ;; 8-reduction.watsup:512.1-515.14
  rule array.init_data-zero {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:517.1-524.67
  rule array.init_data-succ {a : addr, c : c, i : nat, j : nat, mut : mut, n : n, nt : numtype, x : idx, y : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (j + ($storagesize(zt) / 8))) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.INIT_DATA_admininstr(x, y)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (nt = $unpacknumtype(zt))
    -- if ($ztbytes(zt, c) = $data(z, y).DATA_datainst[j : ($storagesize(zt) / 8)])

  ;; 8-reduction.watsup:722.1-724.27
  rule local.get {val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [(val <: admininstr)])
    -- if ($local(z, x) = ?(val))

  ;; 8-reduction.watsup:735.1-736.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [($global(z, x).VALUE_globalinst <: admininstr)])

  ;; 8-reduction.watsup:744.1-746.33
  rule table.get-oob {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:748.1-750.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [($table(z, x).ELEM_tableinst[i] <: admininstr)])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:761.1-763.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 8-reduction.watsup:774.1-776.39
  rule table.fill-oob {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:778.1-781.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:783.1-787.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) (val <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup:790.1-792.73
  rule table.copy-oob {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 8-reduction.watsup:794.1-797.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:799.1-804.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 8-reduction.watsup:806.1-810.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup:813.1-815.72
  rule table.init-oob {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 8-reduction.watsup:817.1-820.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:822.1-826.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) ($elem(z, y).ELEM_eleminst[i] <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup:835.1-837.59
  rule load-num-oob {i : nat, mo : memop, nt : numtype, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + ($size(nt <: valtype) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:839.1-841.71
  rule load-num-val {c : c, i : nat, mo : memop, nt : numtype, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), x, mo)]), [CONST_admininstr(nt, c)])
    -- if ($ntbytes(nt, c) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop) : ($size(nt <: valtype) / 8)])

  ;; 8-reduction.watsup:843.1-845.51
  rule load-pack-oob {i : nat, mo : memop, n : n, nt : numtype, sx : sx, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:847.1-849.61
  rule load-pack-val {c : c, i : nat, mo : memop, n : n, nt : numtype, sx : sx, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), x, mo)]), [CONST_admininstr(nt, $ext(n, $size(nt <: valtype), sx, c))])
    -- if ($ibytes(n, c) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])

  ;; 8-reduction.watsup:851.1-853.61
  rule vload-oob {i : nat, mo : memop, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + ($size(V128_valtype) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:855.1-857.76
  rule vload-val {cv : c_vectype, i : nat, mo : memop, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(), x, mo)]), [VVCONST_admininstr(V128_vectype, cv)])
    -- if ($vtbytes(V128_vectype, cv) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop) : ($size(V128_valtype) / 8)])

  ;; 8-reduction.watsup:859.1-861.55
  rule vload-shape-oob {M : M, N : N, i : nat, mo : memop, sx : sx, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(SHAPE_vloadop(`%X%`(M, N), sx)), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + ((M * N) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:863.1-866.71
  rule vload-shape-val {M : M, N : N, cv : c_vectype, i : nat, k^N : nat^N, m^N : m^N, mo : memop, sx : sx, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(SHAPE_vloadop(`%X%`(M, N), sx)), x, mo)]), [VVCONST_admininstr(V128_vectype, cv)])
    -- (if ($ibytes(M, m) = $mem(z, x).DATA_meminst[((i + mo.OFFSET_memop) + ((k * M) / 8)) : (M / 8)]))^(k<N){k m}
    -- if ($lanes(`%X%`($ishape(M * 2), N), cv) = $ext(M, (M * 2), sx, m)^N{m})

  ;; 8-reduction.watsup:868.1-870.51
  rule vload-splat-oob {i : nat, mo : memop, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(SPLAT_vloadop(n)), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:872.1-876.41
  rule vload-splat-val {cv : c_vectype, i : nat, l : labelidx, m : m, mo : memop, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(SPLAT_vloadop(n)), x, mo)]), [VVCONST_admininstr(V128_vectype, cv)])
    -- if ($ibytes(n, m) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])
    -- if (l = (128 / n))
    -- if ($lanes(`%X%`($ishape(n), l), cv) = m^l{})

  ;; 8-reduction.watsup:878.1-880.51
  rule vload-zero-oob {i : nat, mo : memop, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(ZERO_vloadop(n)), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:882.1-885.32
  rule vload-zero-val {c : c, cv : c_vectype, i : nat, mo : memop, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(ZERO_vloadop(n)), x, mo)]), [VVCONST_admininstr(V128_vectype, cv)])
    -- if ($ibytes(n, c) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])
    -- if (cv = $ext(128, n, U_sx, c))

  ;; 8-reduction.watsup:887.1-889.51
  rule vload_lane-oob {cv_1 : c_vectype, i : nat, laneidx : laneidx, mo : memop, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VVCONST_admininstr(V128_vectype, cv_1) VLOAD_LANE_admininstr(n, x, mo, laneidx)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:891.1-895.57
  rule vload_lane-val {cv : c_vectype, cv_1 : c_vectype, i : nat, laneidx : laneidx, m : m, mo : memop, n : n, sh : shape, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VVCONST_admininstr(V128_vectype, cv_1) VLOAD_LANE_admininstr(n, x, mo, laneidx)]), [VVCONST_admininstr(V128_vectype, cv)])
    -- if ($ibytes(n, m) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])
    -- if (sh = `%X%`($ishape(n), (128 / n)))
    -- if ($lanes(sh, cv) = $lanes(sh, cv_1)[[laneidx] = m])

  ;; 8-reduction.watsup:931.1-933.44
  rule memory.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:944.1-946.37
  rule memory.fill-oob {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:948.1-951.14
  rule memory.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:953.1-957.15
  rule memory.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) (val <: admininstr) STORE_admininstr(I32_numtype, ?(8), x, $memop0) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup:960.1-962.77
  rule memory.copy-oob {i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if (((i_1 + n) > |$mem(z, x_1).DATA_meminst|) \/ ((i_2 + n) > |$mem(z, x_2).DATA_meminst|))

  ;; 8-reduction.watsup:964.1-967.14
  rule memory.copy-zero {i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:969.1-974.19
  rule memory.copy-le {i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) LOAD_admininstr(I32_numtype, ?((8, U_sx)), x_2, $memop0) STORE_admininstr(I32_numtype, ?(8), x_1, $memop0) CONST_admininstr(I32_numtype, (i_1 + 1)) CONST_admininstr(I32_numtype, (i_2 + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- if (i_1 <= i_2)

  ;; 8-reduction.watsup:976.1-980.15
  rule memory.copy-gt {i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [CONST_admininstr(I32_numtype, ((i_1 + n) - 1)) CONST_admininstr(I32_numtype, ((i_2 + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), x_2, $memop0) STORE_admininstr(I32_numtype, ?(8), x_1, $memop0) CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr(x_1, x_2)])
    -- otherwise

  ;; 8-reduction.watsup:983.1-985.70
  rule memory.init-oob {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, y).DATA_datainst|) \/ ((j + n) > |$mem(z, x).DATA_meminst|))

  ;; 8-reduction.watsup:987.1-990.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:992.1-996.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, y).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), x, $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x, y)])
    -- otherwise

;; 8-reduction.watsup:5.1-5.63
relation Step: `%~>%`(config, config)
  ;; 8-reduction.watsup:10.1-12.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*{instr}), `%;%*`(z, (instr' <: admininstr)*{instr'}))
    -- Step_pure: `%*~>%*`((instr <: admininstr)*{instr}, (instr' <: admininstr)*{instr'})

  ;; 8-reduction.watsup:14.1-16.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*{instr}), `%;%*`(z, (instr' <: admininstr)*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, (instr <: admininstr)*{instr}), (instr' <: admininstr)*{instr'})

  ;; 8-reduction.watsup:317.1-320.61
  rule struct.new {mut^n : mut^n, n : n, si : structinst, val^n : val^n, x : idx, z : state, zt^n : storagetype^n}:
    `%~>%`(`%;%*`(z, (val <: admininstr)^n{val} :: [STRUCT.NEW_admininstr(x)]), `%;%*`($ext_structinst(z, [si]), [REF.STRUCT_ADDR_admininstr(|$structinst(z)|)]))
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)^n{mut zt}))
    -- if (si = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val zt}})

  ;; 8-reduction.watsup:337.1-338.53
  rule struct.set-null {ht : heaptype, i : nat, val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [REF.NULL_admininstr(ht) (val <: admininstr) STRUCT.SET_admininstr(x, i)]), `%;%*`(z, [TRAP_admininstr]))

  ;; 8-reduction.watsup:340.1-343.35
  rule struct.set-struct {a : addr, fv : fieldval, i : nat, mut* : mut*, val : val, x : idx, z : state, zt* : storagetype*}:
    `%~>%`(`%;%*`(z, [REF.STRUCT_ADDR_admininstr(a) (val <: admininstr) STRUCT.SET_admininstr(x, i)]), `%;%*`($with_struct(z, a, i, fv), []))
    -- Expand: `%~~%`($structinst(z)[a].TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- if (fv = $packval(zt*{zt}[i], val))

  ;; 8-reduction.watsup:356.1-359.61
  rule array.new_fixed {ai : arrayinst, mut : mut, n : n, val^n : val^n, x : idx, z : state, zt : storagetype}:
    `%~>%`(`%;%*`(z, (val <: admininstr)^n{val} :: [ARRAY.NEW_FIXED_admininstr(x, n)]), `%;%*`($ext_arrayinst(z, [ai]), [REF.ARRAY_ADDR_admininstr(|$arrayinst(z)|)]))
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (ai = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val}})

  ;; 8-reduction.watsup:396.1-397.64
  rule array.set-null {ht : heaptype, i : nat, val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) (val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))

  ;; 8-reduction.watsup:399.1-401.38
  rule array.set-oob {a : addr, i : nat, val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:403.1-406.31
  rule array.set-array {a : addr, fv : fieldval, i : nat, mut : mut, val : val, x : idx, z : state, zt : storagetype}:
    `%~>%`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`($with_array(z, a, i, fv), []))
    -- Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))
    -- if (fv = $packval(zt, val))

  ;; 8-reduction.watsup:726.1-727.56
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(val <: admininstr) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 8-reduction.watsup:738.1-739.58
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(val <: admininstr) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 8-reduction.watsup:752.1-754.33
  rule table.set-oob {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:756.1-758.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:766.1-768.46
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if (ti = $growtable($table(z, x), n, ref))

  ;; 8-reduction.watsup:770.1-771.80
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 8-reduction.watsup:829.1-830.51
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 8-reduction.watsup:898.1-900.59
  rule store-num-oob {c : c, i : nat, mo : memop, nt : numtype, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), x, mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + ($size(nt <: valtype) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:902.1-904.29
  rule store-num-val {b* : byte*, c : c, i : nat, mo : memop, nt : numtype, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), x, mo)]), `%;%*`($with_mem(z, x, (i + mo.OFFSET_memop), ($size(nt <: valtype) / 8), b*{b}), []))
    -- if (b*{b} = $ntbytes(nt, c))

  ;; 8-reduction.watsup:906.1-908.51
  rule store-pack-oob {c : c, i : nat, mo : memop, n : n, nt : numtype, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), x, mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:910.1-912.48
  rule store-pack-val {b* : byte*, c : c, i : nat, mo : memop, n : n, nt : numtype, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), x, mo)]), `%;%*`($with_mem(z, x, (i + mo.OFFSET_memop), (n / 8), b*{b}), []))
    -- if (b*{b} = $ibytes(n, $wrap($size(nt <: valtype), n, c)))

  ;; 8-reduction.watsup:914.1-916.61
  rule vstore-oob {cv : c_vectype, i : nat, mo : memop, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VVCONST_admininstr(V128_vectype, cv) VSTORE_admininstr(x, mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + ($size(V128_valtype) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:918.1-920.32
  rule vstore-val {b* : byte*, cv : c_vectype, i : nat, mo : memop, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VVCONST_admininstr(V128_vectype, cv) VSTORE_admininstr(x, mo)]), `%;%*`($with_mem(z, x, (i + mo.OFFSET_memop), ($size(V128_valtype) / 8), b*{b}), []))
    -- if (b*{b} = $vtbytes(V128_vectype, cv))

  ;; 8-reduction.watsup:922.1-924.49
  rule vstore_lane-oob {cv : c_vectype, i : nat, laneidx : laneidx, mo : memop, n : n, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VVCONST_admininstr(V128_vectype, cv) VSTORE_LANE_admininstr(n, x, mo, laneidx)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + n) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:926.1-928.68
  rule vstore_lane-val {b* : byte*, cv : c_vectype, i : nat, laneidx : laneidx, mo : memop, n : n, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VVCONST_admininstr(V128_vectype, cv) VSTORE_LANE_admininstr(n, x, mo, laneidx)]), `%;%*`($with_mem(z, x, (i + mo.OFFSET_memop), (n / 8), b*{b}), []))
    -- if (b*{b} = $ibytes(n, $lanes(`%X%`($ishape(n), (128 / n)), cv)[laneidx]))

  ;; 8-reduction.watsup:936.1-938.40
  rule memory.grow-succeed {mi : meminst, n : n, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr(x)]), `%;%*`($with_meminst(z, x, mi), [CONST_admininstr(I32_numtype, (|$mem(z, x).DATA_meminst| / (64 * $Ki)))]))
    -- if (mi = $growmemory($mem(z, x), n))

  ;; 8-reduction.watsup:940.1-941.77
  rule memory.grow-fail {n : n, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 8-reduction.watsup:999.1-1000.51
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 8-reduction.watsup:8.1-8.63
rec {

;; 8-reduction.watsup:8.1-8.63
relation Steps: `%~>*%`(config, config)
  ;; 8-reduction.watsup:18.1-19.36
  rule refl {admininstr* : admininstr*, z : state}:
    `%~>*%`(`%;%*`(z, admininstr*{admininstr}), `%;%*`(z, admininstr*{admininstr}))

  ;; 8-reduction.watsup:21.1-24.53
  rule trans {admininstr* : admininstr*, admininstr' : admininstr, admininstr''* : admininstr*, z : state, z' : state, z'' : state}:
    `%~>*%`(`%;%*`(z, admininstr*{admininstr}), `%;%*`(z'', admininstr''*{admininstr''}))
    -- Step: `%~>%`(`%;%*`(z, admininstr*{admininstr}), `%;%*`(z', admininstr'*{}))
    -- Steps: `%~>*%`(`%;%*`(z', [admininstr']), `%;%*`(z'', admininstr''*{admininstr''}))
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
  ;; 9-module.watsup:8.1-8.27
  def alloctypes([]) = []
  ;; 9-module.watsup:9.1-13.24
  def {deftype* : deftype*, deftype'* : deftype*, rectype : rectype, type : type, type'* : type*, x : idx} alloctypes(type'*{type'} :: [type]) = deftype'*{deftype'} :: deftype*{deftype}
    -- if (deftype'*{deftype'} = $alloctypes(type'*{type'}))
    -- if (type = TYPE(rectype))
    -- if (deftype*{deftype} = $subst_all_deftypes($rolldt(x, rectype), (deftype' <: heaptype)*{deftype'}))
    -- if (x = |deftype'*{deftype'}|)
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
  ;; 9-module.watsup:21.1-21.39
  def {mm : moduleinst, s : store} allocfuncs(s, mm, []) = (s, [])
  ;; 9-module.watsup:22.1-24.51
  def {fa : funcaddr, fa'* : funcaddr*, func : func, func'* : func*, mm : moduleinst, s : store, s_1 : store, s_2 : store} allocfuncs(s, mm, [func] :: func'*{func'}) = (s_2, [fa] :: fa'*{fa'})
    -- if ((s_1, fa) = $allocfunc(s, mm, func))
    -- if ((s_2, fa'*{fa'}) = $allocfuncs(s_1, mm, func'*{func'}))
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
  ;; 9-module.watsup:31.1-31.42
  def {s : store} allocglobals(s, [], []) = (s, [])
  ;; 9-module.watsup:32.1-34.62
  def {ga : globaladdr, ga'* : globaladdr*, globaltype : globaltype, globaltype'* : globaltype*, s : store, s_1 : store, s_2 : store, val : val, val'* : val*} allocglobals(s, [globaltype] :: globaltype'*{globaltype'}, [val] :: val'*{val'}) = (s_2, [ga] :: ga'*{ga'})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga'}) = $allocglobals(s_1, globaltype'*{globaltype'}, val'*{val'}))
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
  ;; 9-module.watsup:41.1-41.41
  def {s : store} alloctables(s, [], []) = (s, [])
  ;; 9-module.watsup:42.1-44.60
  def {ref : ref, ref'* : ref*, s : store, s_1 : store, s_2 : store, ta : tableaddr, ta'* : tableaddr*, tabletype : tabletype, tabletype'* : tabletype*} alloctables(s, [tabletype] :: tabletype'*{tabletype'}, [ref] :: ref'*{ref'}) = (s_2, [ta] :: ta'*{ta'})
    -- if ((s_1, ta) = $alloctable(s, tabletype, ref))
    -- if ((s_2, ta'*{ta'}) = $alloctables(s_1, tabletype'*{tabletype'}, ref'*{ref'}))
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
  ;; 9-module.watsup:51.1-51.34
  def {s : store} allocmems(s, []) = (s, [])
  ;; 9-module.watsup:52.1-54.49
  def {ma : memaddr, ma'* : memaddr*, memtype : memtype, memtype'* : memtype*, s : store, s_1 : store, s_2 : store} allocmems(s, [memtype] :: memtype'*{memtype'}) = (s_2, [ma] :: ma'*{ma'})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma'}) = $allocmems(s_1, memtype'*{memtype'}))
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
  ;; 9-module.watsup:61.1-61.40
  def {s : store} allocelems(s, [], []) = (s, [])
  ;; 9-module.watsup:62.1-64.55
  def {ea : elemaddr, ea'* : elemaddr*, ref* : ref*, ref'** : ref**, rt : reftype, rt'* : reftype*, s : store, s_1 : store, s_2 : store} allocelems(s, [rt] :: rt'*{rt'}, [ref*{ref}] :: ref'*{ref'}*{ref'}) = (s_2, [ea] :: ea'*{ea'})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref}))
    -- if ((s_2, ea'*{ea'}) = $allocelems(s_2, rt'*{rt'}, ref'*{ref'}*{ref'}))
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
  ;; 9-module.watsup:71.1-71.35
  def {s : store} allocdatas(s, []) = (s, [])
  ;; 9-module.watsup:72.1-74.50
  def {byte* : byte*, byte'** : byte**, da : dataaddr, da'* : dataaddr*, s : store, s_1 : store, s_2 : store} allocdatas(s, [byte*{byte}] :: byte'*{byte'}*{byte'}) = (s_2, [da] :: da'*{da'})
    -- if ((s_1, da) = $allocdata(s, byte*{byte}))
    -- if ((s_2, da'*{da'}) = $allocdatas(s_1, byte'*{byte'}*{byte'}))
}

;; 9-module.watsup:79.1-79.83
def instexport : (funcaddr*, globaladdr*, tableaddr*, memaddr*, export) -> exportinst
  ;; 9-module.watsup:80.1-80.95
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, FUNC_externidx(x))) = {NAME name, VALUE FUNC_externval(fa*{fa}[x])}
  ;; 9-module.watsup:81.1-81.99
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, GLOBAL_externidx(x))) = {NAME name, VALUE GLOBAL_externval(ga*{ga}[x])}
  ;; 9-module.watsup:82.1-82.97
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, TABLE_externidx(x))) = {NAME name, VALUE TABLE_externval(ta*{ta}[x])}
  ;; 9-module.watsup:83.1-83.93
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, MEM_externidx(x))) = {NAME name, VALUE MEM_externval(ma*{ma}[x])}

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
  ;; 9-module.watsup:135.1-135.29
  def concat_instr([]) = []
  ;; 9-module.watsup:136.1-136.74
  def {instr* : instr*, instr'** : instr**} concat_instr([instr*{instr}] :: instr'*{instr'}*{instr'}) = instr*{instr} :: $concat_instr(instr'*{instr'}*{instr'})
}

;; 9-module.watsup:138.1-138.33
def runelem : (elem, idx) -> instr*
  ;; 9-module.watsup:139.1-139.52
  def {expr* : expr*, reftype : reftype, y : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, PASSIVE_elemmode), y) = []
  ;; 9-module.watsup:140.1-140.62
  def {expr* : expr*, reftype : reftype, y : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, DECLARE_elemmode), y) = [ELEM.DROP_instr(y)]
  ;; 9-module.watsup:141.1-142.77
  def {expr* : expr*, instr* : instr*, reftype : reftype, x : idx, y : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, ACTIVE_elemmode(x, instr*{instr})), y) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, |expr*{expr}|) TABLE.INIT_instr(x, y) ELEM.DROP_instr(y)]

;; 9-module.watsup:144.1-144.33
def rundata : (data, idx) -> instr*
  ;; 9-module.watsup:145.1-145.44
  def {byte* : byte*, y : idx} rundata(`DATA%*%`(byte*{byte}, PASSIVE_datamode), y) = []
  ;; 9-module.watsup:146.1-147.78
  def {byte* : byte*, instr* : instr*, x : idx, y : idx} rundata(`DATA%*%`(byte*{byte}, ACTIVE_datamode(x, instr*{instr})), y) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, |byte*{byte}|) MEMORY.INIT_instr(x, y) DATA.DROP_instr(y)]

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
  ;; A-binary.watsup:48.1-48.44
  def {b : byte, c : c} utf8([c]) = [b]
    -- if ((c < 128) /\ (c = b))
  ;; A-binary.watsup:49.1-49.93
  def {b_1 : byte, b_2 : byte, c : c} utf8([c]) = [b_1 b_2]
    -- if (((128 <= c) /\ (c < 2048)) /\ (c = (((2 ^ 6) * (b_1 - 192)) + (b_2 - 128))))
  ;; A-binary.watsup:50.1-50.144
  def {b_1 : byte, b_2 : byte, b_3 : byte, c : c} utf8([c]) = [b_1 b_2 b_3]
    -- if ((((2048 <= c) /\ (c < 55296)) \/ ((57344 <= c) /\ (c < 65536))) /\ (c = ((((2 ^ 12) * (b_1 - 224)) + ((2 ^ 6) * (b_2 - 128))) + (b_3 - 128))))
  ;; A-binary.watsup:51.1-51.145
  def {b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte, c : c} utf8([c]) = [b_1 b_2 b_3 b_4]
    -- if (((65536 <= c) /\ (c < 69632)) /\ (c = (((((2 ^ 18) * (b_1 - 240)) + ((2 ^ 12) * (b_2 - 128))) + ((2 ^ 6) * (b_3 - 128))) + (b_4 - 128))))
  ;; A-binary.watsup:52.1-52.41
  def {c* : c*} utf8(c*{c}) = $concat_bytes($utf8([c])*{c})
}

;; A-binary.watsup:210.1-210.27
syntax castop = (nul, nul)

;; A-binary.watsup:303.1-303.34
syntax memidxop = (memidx, memop)

;; A-binary.watsup:665.1-665.62
rec {

;; A-binary.watsup:665.1-665.62
def concat_locals : local** -> local*
  ;; A-binary.watsup:666.1-666.30
  def concat_locals([]) = []
  ;; A-binary.watsup:667.1-667.68
  def {loc* : local*, loc'** : local**} concat_locals([loc*{loc}] :: loc'*{loc'}*{loc'}) = loc*{loc} :: $concat_locals(loc'*{loc'}*{loc'})
}

;; A-binary.watsup:670.1-670.29
syntax code = (local*, expr)

;; C-conventions.watsup:7.1-7.15
syntax A = nat

;; C-conventions.watsup:9.1-9.35
syntax sym = A

== IL Validation...
== Complete.
```
