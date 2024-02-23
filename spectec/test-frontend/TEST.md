# Test

```sh
$ (../src/exe-watsup/main.exe test.watsup -o test.tex && cat test.tex)
$$
\begin{array}{@{}lrrl@{}l@{}}
& {\mathit{testmixfix}} &::=& \{{{\mathit{nat}}^\ast}\} ~|~ {}[{{\mathit{nat}}^\ast}] ~|~ {\mathit{nat}} \rightarrow {\mathit{nat}} \\
\end{array}
$$

$$
\begin{array}{@{}lcl@{}l@{}}
{\mathrm{testmixfix}}(\{{{\mathit{nat}}^\ast}\}) &=& {{\mathit{nat}}^\ast} &  \\
{\mathrm{testmixfix}}({}[{{\mathit{nat}}^\ast}]) &=& {{\mathit{nat}}^\ast} &  \\
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
$ (cd ../spec/wasm-3.0 && ../../src/exe-watsup/main.exe *.watsup -v -l --print-il --check)
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
def $Ki : nat
  ;; 0-aux.watsup:22.1-22.15
  def $Ki = 1024

;; 0-aux.watsup:27.1-27.25
rec {

;; 0-aux.watsup:27.1-27.25
def $min(nat : nat, nat : nat) : nat
  ;; 0-aux.watsup:28.1-28.19
  def $min{j : nat}(0, j) = 0
  ;; 0-aux.watsup:29.1-29.19
  def $min{i : nat}(i, 0) = 0
  ;; 0-aux.watsup:30.1-30.38
  def $min{i : nat, j : nat}((i + 1), (j + 1)) = $min(i, j)
}

;; 0-aux.watsup:32.1-32.21
rec {

;; 0-aux.watsup:32.1-32.21
def $sum(nat*) : nat
  ;; 0-aux.watsup:33.1-33.18
  def $sum([]) = 0
  ;; 0-aux.watsup:34.1-34.35
  def $sum{n : n, n'* : n*}([n] :: n'*{n'}) = (n + $sum(n'*{n'}))
}

;; 0-aux.watsup:39.1-39.59
rec {

;; 0-aux.watsup:39.1-39.59
def $concat_(syntax X, X**) : X*
  ;; 0-aux.watsup:40.1-40.34
  def $concat_{syntax X}(syntax X, []) = []
  ;; 0-aux.watsup:41.1-41.61
  def $concat_{syntax X, w* : X*, w'** : X**}(syntax X, [w*{w}] :: w'*{w'}*{w'}) = w*{w} :: $concat_(syntax X, w'*{w'}*{w'})
}

;; 1-syntax.watsup:6.1-6.27
syntax list{syntax X}(syntax X) = X*

;; 1-syntax.watsup:13.1-13.85
syntax char = nat

;; 1-syntax.watsup:16.1-16.38
syntax name = char*

;; 1-syntax.watsup:27.1-27.36
syntax bit = nat

;; 1-syntax.watsup:28.1-28.50
syntax byte = nat

;; 1-syntax.watsup:30.1-31.18
syntax uN{N : N}(N) = nat

;; 1-syntax.watsup:32.1-33.49
syntax sN{N : N}(N) = int

;; 1-syntax.watsup:34.1-35.8
syntax iN{N : N}(N) = uN(N)

;; 1-syntax.watsup:37.1-37.18
syntax u8 = uN(8)

;; 1-syntax.watsup:38.1-38.20
syntax u16 = uN(16)

;; 1-syntax.watsup:39.1-39.20
syntax u31 = uN(31)

;; 1-syntax.watsup:40.1-40.20
syntax u32 = uN(32)

;; 1-syntax.watsup:41.1-41.20
syntax u64 = uN(64)

;; 1-syntax.watsup:42.1-42.22
syntax u128 = uN(128)

;; 1-syntax.watsup:43.1-43.20
syntax s33 = sN(33)

;; 1-syntax.watsup:50.1-50.21
def $signif(N : N) : nat
  ;; 1-syntax.watsup:51.1-51.21
  def $signif(32) = 23
  ;; 1-syntax.watsup:52.1-52.21
  def $signif(64) = 52

;; 1-syntax.watsup:54.1-54.20
def $expon(N : N) : nat
  ;; 1-syntax.watsup:55.1-55.19
  def $expon(32) = 8
  ;; 1-syntax.watsup:56.1-56.20
  def $expon(64) = 11

;; 1-syntax.watsup:58.1-58.30
def $M(N : N) : nat
  ;; 1-syntax.watsup:59.1-59.23
  def $M{N : N}(N) = $signif(N)

;; 1-syntax.watsup:61.1-61.30
def $E(N : N) : nat
  ;; 1-syntax.watsup:62.1-62.22
  def $E{N : N}(N) = $expon(N)

;; 1-syntax.watsup:68.1-72.83
syntax fNmag{N : N}(N) =
  | NORM{m : m, n : n}(m : m, n : n)
    -- if ((m < (2 ^ $M(N))) /\ (((2 - (2 ^ ($E(N) - 1))) <= n) /\ (n <= ((2 ^ ($E(N) - 1)) - 1))))
  | SUBNORM{m : m, N : N, n : n}(m : m)
    -- if ((m < (2 ^ $M(N))) /\ ((2 - (2 ^ ($E(N) - 1))) = n))
  | INF
  | NAN{m : m}(m : m)
    -- if ((1 <= m) /\ (m < (2 ^ $M(N))))

;; 1-syntax.watsup:64.1-66.35
syntax fN{N : N}(N) =
  | POS(fNmag : fNmag(N))
  | NEG(fNmag : fNmag(N))

;; 1-syntax.watsup:74.1-74.20
syntax f32 = fN(32)

;; 1-syntax.watsup:75.1-75.20
syntax f64 = fN(64)

;; 1-syntax.watsup:77.1-77.39
def $fzero(N : N) : fN(N)
  ;; 1-syntax.watsup:78.1-78.32
  def $fzero{N : N}(N) = POS_fN(N)(SUBNORM_fNmag(N)(0))

;; 1-syntax.watsup:80.1-80.39
def $fone(N : N) : fN(N)
  ;; 1-syntax.watsup:81.1-81.30
  def $fone{N : N}(N) = POS_fN(N)(NORM_fNmag(N)(1, 0))

;; 1-syntax.watsup:83.1-83.21
def $canon_(N : N) : nat
  ;; 1-syntax.watsup:84.1-84.37
  def $canon_{N : N}(N) = (2 ^ ($signif(N) - 1))

;; 1-syntax.watsup:89.1-90.8
syntax vN{N : N}(N) = iN(N)

;; 1-syntax.watsup:97.1-97.36
syntax idx = u32

;; 1-syntax.watsup:98.1-98.44
syntax laneidx = u8

;; 1-syntax.watsup:100.1-100.45
syntax typeidx = idx

;; 1-syntax.watsup:101.1-101.49
syntax funcidx = idx

;; 1-syntax.watsup:102.1-102.49
syntax globalidx = idx

;; 1-syntax.watsup:103.1-103.47
syntax tableidx = idx

;; 1-syntax.watsup:104.1-104.46
syntax memidx = idx

;; 1-syntax.watsup:105.1-105.45
syntax elemidx = idx

;; 1-syntax.watsup:106.1-106.45
syntax dataidx = idx

;; 1-syntax.watsup:107.1-107.47
syntax labelidx = idx

;; 1-syntax.watsup:108.1-108.47
syntax localidx = idx

;; 1-syntax.watsup:123.1-123.19
syntax nul = `NULL%?`(()?)

;; 1-syntax.watsup:125.1-126.26
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:128.1-129.9
syntax vectype =
  | V128

;; 1-syntax.watsup:136.1-137.14
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

;; 1-syntax.watsup:172.1-172.18
syntax mut = `MUT%?`(()?)

;; 1-syntax.watsup:173.1-173.20
syntax fin = `FINAL%?`(()?)

;; 1-syntax.watsup:146.1-199.26
rec {

;; 1-syntax.watsup:146.1-147.14
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | REF(nul : nul, heaptype : heaptype)
  | BOT

;; 1-syntax.watsup:154.1-155.16
syntax resulttype = list(syntax valtype)

;; 1-syntax.watsup:162.1-162.68
syntax storagetype =
  | BOT
  | I32
  | I64
  | F32
  | F64
  | V128
  | REF(nul : nul, heaptype : heaptype)
  | I8
  | I16

;; 1-syntax.watsup:175.1-176.18
syntax fieldtype = `%%`(mut, storagetype)

;; 1-syntax.watsup:178.1-178.70
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:179.1-179.64
syntax structtype = list(syntax fieldtype)

;; 1-syntax.watsup:180.1-180.53
syntax arraytype = fieldtype

;; 1-syntax.watsup:182.1-185.18
syntax comptype =
  | STRUCT(structtype : structtype)
  | ARRAY(arraytype : arraytype)
  | FUNC(functype : functype)

;; 1-syntax.watsup:189.1-190.60
syntax subtype =
  | SUB(fin : fin, typeidx*, comptype : comptype)
  | SUBD(fin : fin, heaptype*, comptype : comptype)

;; 1-syntax.watsup:192.1-193.22
syntax rectype =
  | REC(list : list(syntax subtype))

;; 1-syntax.watsup:198.1-199.26
syntax heaptype =
  | _IDX(typeidx : typeidx)
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
  | DEF(rectype : rectype, nat)
  | REC(n : n)
}

;; 1-syntax.watsup:141.1-142.21
syntax reftype =
  | REF(nul : nul, heaptype : heaptype)

;; 1-syntax.watsup:149.1-149.40
syntax inn =
  | I32
  | I64

;; 1-syntax.watsup:150.1-150.40
syntax fnn =
  | F32
  | F64

;; 1-syntax.watsup:151.1-151.35
syntax vnn =
  | V128

;; 1-syntax.watsup:160.1-160.54
syntax packtype =
  | I8
  | I16

;; 1-syntax.watsup:161.1-161.62
syntax lanetype =
  | I32
  | I64
  | F32
  | F64
  | I8
  | I16

;; 1-syntax.watsup:164.1-164.39
syntax pnn =
  | I8
  | I16

;; 1-syntax.watsup:165.1-165.44
syntax lnn =
  | I32
  | I64
  | F32
  | F64
  | I8
  | I16

;; 1-syntax.watsup:166.1-166.40
syntax imm =
  | I32
  | I64
  | I8
  | I16

;; 1-syntax.watsup:195.1-196.35
syntax deftype =
  | DEF(rectype : rectype, nat)

;; 1-syntax.watsup:204.1-205.16
syntax limits = `[%..%]`(u32, u32)

;; 1-syntax.watsup:207.1-208.14
syntax globaltype = `%%`(mut, valtype)

;; 1-syntax.watsup:209.1-210.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:211.1-212.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:213.1-214.10
syntax elemtype = reftype

;; 1-syntax.watsup:215.1-216.5
syntax datatype = OK

;; 1-syntax.watsup:217.1-218.69
syntax externtype =
  | FUNC(deftype : deftype)
  | GLOBAL(globaltype : globaltype)
  | TABLE(tabletype : tabletype)
  | MEM(memtype : memtype)

;; 1-syntax.watsup:255.1-255.60
def $size(valtype : valtype) : nat
  ;; 2-syntax-aux.watsup:53.1-53.20
  def $size(I32_valtype) = 32
  ;; 2-syntax-aux.watsup:54.1-54.20
  def $size(I64_valtype) = 64
  ;; 2-syntax-aux.watsup:55.1-55.20
  def $size(F32_valtype) = 32
  ;; 2-syntax-aux.watsup:56.1-56.20
  def $size(F64_valtype) = 64
  ;; 2-syntax-aux.watsup:57.1-57.22
  def $size(V128_valtype) = 128

;; 1-syntax.watsup:256.1-256.46
def $psize(packtype : packtype) : nat
  ;; 2-syntax-aux.watsup:59.1-59.19
  def $psize(I8_packtype) = 8
  ;; 2-syntax-aux.watsup:60.1-60.21
  def $psize(I16_packtype) = 16

;; 1-syntax.watsup:257.1-257.46
def $lsize(lanetype : lanetype) : nat
  ;; 2-syntax-aux.watsup:62.1-62.37
  def $lsize{numtype : numtype}((numtype : numtype <: lanetype)) = $size((numtype : numtype <: valtype))
  ;; 2-syntax-aux.watsup:63.1-63.40
  def $lsize{packtype : packtype}((packtype : packtype <: lanetype)) = $psize(packtype)

;; 1-syntax.watsup:258.1-258.46
def $zsize(storagetype : storagetype) : nat
  ;; 2-syntax-aux.watsup:65.1-65.37
  def $zsize{valtype : valtype}((valtype : valtype <: storagetype)) = $size(valtype)
  ;; 2-syntax-aux.watsup:66.1-66.40
  def $zsize{packtype : packtype}((packtype : packtype <: storagetype)) = $psize(packtype)

;; 1-syntax.watsup:312.1-312.55
syntax dim = nat

;; 1-syntax.watsup:313.1-313.49
syntax shape = `%X%`(lanetype, dim)

;; 1-syntax.watsup:259.1-259.32
def $lanetype(shape : shape) : lanetype
  ;; 2-syntax-aux.watsup:94.1-94.29
  def $lanetype{lnn : lnn, N : N}(`%X%`(lnn, N)) = lnn

;; 1-syntax.watsup:261.1-261.21
syntax num_(numtype : numtype)
  ;; 1-syntax.watsup:262.1-262.34
  syntax num_{inn : inn}((inn : inn <: numtype)) = iN($size((inn : inn <: valtype)))


  ;; 1-syntax.watsup:263.1-263.34
  syntax num_{fnn : fnn}((fnn : fnn <: numtype)) = fN($size((fnn : fnn <: valtype)))


;; 1-syntax.watsup:265.1-265.36
syntax pack_{pnn : pnn}(pnn) = iN($psize(pnn))

;; 1-syntax.watsup:267.1-267.23
syntax lane_(lanetype : lanetype)
  ;; 1-syntax.watsup:268.1-268.38
  syntax lane_{numtype : numtype}((numtype : numtype <: lanetype)) = num_(numtype)


  ;; 1-syntax.watsup:269.1-269.41
  syntax lane_{packtype : packtype}((packtype : packtype <: lanetype)) = pack_(packtype)


  ;; 1-syntax.watsup:270.1-270.36
  syntax lane_{imm : imm}((imm : imm <: lanetype)) = iN($lsize((imm : imm <: lanetype)))


;; 1-syntax.watsup:272.1-272.34
syntax vec_{vnn : vnn}(vnn) = vN($size((vnn : vnn <: valtype)))

;; 1-syntax.watsup:274.1-274.26
syntax zval_(storagetype : storagetype)
  ;; 1-syntax.watsup:275.1-275.38
  syntax zval_{numtype : numtype}((numtype : numtype <: storagetype)) = num_(numtype)


  ;; 1-syntax.watsup:276.1-276.38
  syntax zval_{vectype : vectype}((vectype : vectype <: storagetype)) = vec_(vectype)


  ;; 1-syntax.watsup:277.1-277.41
  syntax zval_{packtype : packtype}((packtype : packtype <: storagetype)) = pack_(packtype)


;; 1-syntax.watsup:282.1-282.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:284.1-284.22
syntax unop_(numtype : numtype)
  ;; 1-syntax.watsup:285.1-285.52
  syntax unop_{inn : inn}((inn : inn <: numtype)) =
  | CLZ
  | CTZ
  | POPCNT
  | EXTEND(n : n)


  ;; 1-syntax.watsup:286.1-286.72
  syntax unop_{fnn : fnn}((fnn : fnn <: numtype)) =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST


;; 1-syntax.watsup:288.1-288.23
syntax binop_(numtype : numtype)
  ;; 1-syntax.watsup:289.1-291.66
  syntax binop_{inn : inn}((inn : inn <: numtype)) =
  | ADD
  | SUB
  | MUL
  | DIV(sx : sx)
  | REM(sx : sx)
  | AND
  | OR
  | XOR
  | SHL
  | SHR(sx : sx)
  | ROTL
  | ROTR


  ;; 1-syntax.watsup:292.1-293.49
  syntax binop_{fnn : fnn}((fnn : fnn <: numtype)) =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN


;; 1-syntax.watsup:295.1-295.24
syntax testop_(numtype : numtype)
  ;; 1-syntax.watsup:296.1-296.28
  syntax testop_{inn : inn}((inn : inn <: numtype)) =
  | EQZ


  ;; 1-syntax.watsup:297.1-297.24
  syntax testop_{fnn : fnn}((fnn : fnn <: numtype)) =
  |


;; 1-syntax.watsup:299.1-299.23
syntax relop_(numtype : numtype)
  ;; 1-syntax.watsup:300.1-303.52
  syntax relop_{inn : inn}((inn : inn <: numtype)) =
  | EQ
  | NE
  | LT(sx : sx)
  | GT(sx : sx)
  | LE(sx : sx)
  | GE(sx : sx)


  ;; 1-syntax.watsup:304.1-305.32
  syntax relop_{fnn : fnn}((fnn : fnn <: numtype)) =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE


;; 1-syntax.watsup:307.1-307.53
syntax cvtop =
  | CONVERT
  | REINTERPRET
  | CONVERT_SAT

;; 1-syntax.watsup:314.1-314.45
syntax ishape = `%X%`(imm, dim)

;; 1-syntax.watsup:315.1-315.45
syntax fshape = `%X%`(fnn, dim)

;; 1-syntax.watsup:316.1-316.45
syntax pshape = `%X%`(pnn, dim)

;; 1-syntax.watsup:318.1-318.22
def $dim(shape : shape) : dim
  ;; 2-syntax-aux.watsup:97.1-97.22
  def $dim{lnn : lnn, N : N}(`%X%`(lnn, N)) = N

;; 1-syntax.watsup:319.1-319.41
def $shsize(shape : shape) : nat
  ;; 2-syntax-aux.watsup:100.1-100.42
  def $shsize{lnn : lnn, N : N}(`%X%`(lnn, N)) = ($lsize(lnn) * N)

;; 1-syntax.watsup:321.1-321.22
syntax vvunop =
  | NOT

;; 1-syntax.watsup:322.1-322.43
syntax vvbinop =
  | AND
  | ANDNOT
  | OR
  | XOR

;; 1-syntax.watsup:323.1-323.30
syntax vvternop =
  | BITSELECT

;; 1-syntax.watsup:324.1-324.29
syntax vvtestop =
  | ANY_TRUE

;; 1-syntax.watsup:326.1-326.21
syntax vunop_(shape : shape)
  ;; 1-syntax.watsup:327.1-327.61
  syntax vunop_{imm : imm, N : N}(`%X%`((imm : imm <: lanetype), N)) =
  | ABS
  | NEG
  | POPCNT{imm : imm}
    -- if (imm = I8_imm)


  ;; 1-syntax.watsup:328.1-328.77
  syntax vunop_{fnn : fnn, N : N}(`%X%`((fnn : fnn <: lanetype), N)) =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST


;; 1-syntax.watsup:330.1-330.22
syntax vbinop_(shape : shape)
  ;; 1-syntax.watsup:331.1-340.43
  syntax vbinop_{imm : imm, N : N}(`%X%`((imm : imm <: lanetype), N)) =
  | ADD
  | SUB
  | ADD_SAT(sx : sx)
    -- if ($lsize((imm : imm <: lanetype)) <= 16)
  | SUB_SAT(sx : sx)
    -- if ($lsize((imm : imm <: lanetype)) <= 16)
  | MUL
    -- if ($lsize((imm : imm <: lanetype)) >= 16)
  | AVGR_U
    -- if ($lsize((imm : imm <: lanetype)) <= 16)
  | Q15MULR_SAT_S{imm : imm}
    -- if ($lsize((imm : imm <: lanetype)) = 16)
  | MIN(sx : sx)
    -- if ($lsize((imm : imm <: lanetype)) <= 32)
  | MAX(sx : sx)
    -- if ($lsize((imm : imm <: lanetype)) <= 32)


  ;; 1-syntax.watsup:341.1-341.76
  syntax vbinop_{fnn : fnn, N : N}(`%X%`((fnn : fnn <: lanetype), N)) =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | PMIN
  | PMAX


;; 1-syntax.watsup:343.1-343.23
syntax vtestop_(shape : shape)
  ;; 1-syntax.watsup:344.1-344.38
  syntax vtestop_{imm : imm, N : N}(`%X%`((imm : imm <: lanetype), N)) =
  | ALL_TRUE


  ;; 1-syntax.watsup:345.1-345.29
  syntax vtestop_{fnn : fnn, N : N}(`%X%`((fnn : fnn <: lanetype), N)) =
  |


;; 1-syntax.watsup:347.1-347.22
syntax vrelop_(shape : shape)
  ;; 1-syntax.watsup:348.1-348.68
  syntax vrelop_{imm : imm, N : N}(`%X%`((imm : imm <: lanetype), N)) =
  | EQ
  | NE
  | LT(sx : sx)
  | GT(sx : sx)
  | LE(sx : sx)
  | GE(sx : sx)


  ;; 1-syntax.watsup:349.1-349.56
  syntax vrelop_{fnn : fnn, N : N}(`%X%`((fnn : fnn <: lanetype), N)) =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE


;; 1-syntax.watsup:351.1-351.66
syntax vcvtop =
  | EXTEND
  | TRUNC_SAT
  | CONVERT
  | DEMOTE
  | PROMOTE

;; 1-syntax.watsup:362.1-362.25
syntax vshiftop_{imm : imm, N : N}(`%X%`(imm, N)) =
  | SHL
  | SHR(sx : sx)

;; 1-syntax.watsup:365.1-365.66
syntax vextunop_{imm_1 : imm, N_1 : N, imm_2 : imm, N_2 : N}(`%X%`(imm_1, N_1), `%X%`(imm_2, N_2)) =
  | EXTADD_PAIRWISE
    -- if ((16 <= $lsize((imm_1 : imm <: lanetype))) /\ ($lsize((imm_1 : imm <: lanetype)) <= 32))

;; 1-syntax.watsup:429.1-429.50
syntax half =
  | LOW
  | HIGH

;; 1-syntax.watsup:368.1-368.68
syntax vextbinop_{imm_1 : imm, N_1 : N, imm_2 : imm, N_2 : N}(`%X%`(imm_1, N_1), `%X%`(imm_2, N_2)) =
  | EXTMUL(half : half)
  | DOT{imm_1 : imm}
    -- if ($lsize((imm_1 : imm <: lanetype)) = 32)

;; 1-syntax.watsup:376.1-376.68
syntax memop =
{
  ALIGN u32,
  OFFSET u32
}

;; 1-syntax.watsup:378.1-381.44
syntax vloadop =
  | SHAPE(nat, nat, sx : sx)
  | SPLAT(nat)
  | ZERO(nat)

;; 1-syntax.watsup:390.1-392.17
syntax blocktype =
  | _RESULT(valtype?)
  | _IDX(funcidx : funcidx)

;; 1-syntax.watsup:430.1-430.20
syntax zero = `ZERO%?`(()?)

;; 1-syntax.watsup:517.1-529.78
rec {

;; 1-syntax.watsup:517.1-529.78
syntax instr =
  | UNREACHABLE
  | NOP
  | DROP
  | SELECT(valtype*?)
  | BLOCK(blocktype : blocktype, instr*)
  | LOOP(blocktype : blocktype, instr*)
  | IF(blocktype : blocktype, instr*, instr*)
  | BR(labelidx : labelidx)
  | BR_IF(labelidx : labelidx)
  | BR_TABLE(labelidx*, labelidx : labelidx)
  | BR_ON_NULL(labelidx : labelidx)
  | BR_ON_NON_NULL(labelidx : labelidx)
  | BR_ON_CAST(labelidx : labelidx, reftype : reftype, reftype : reftype)
  | BR_ON_CAST_FAIL(labelidx : labelidx, reftype : reftype, reftype : reftype)
  | CALL(funcidx : funcidx)
  | CALL_REF(typeidx?)
  | CALL_INDIRECT(tableidx : tableidx, typeidx : typeidx)
  | RETURN
  | RETURN_CALL(funcidx : funcidx)
  | RETURN_CALL_REF(typeidx?)
  | RETURN_CALL_INDIRECT(tableidx : tableidx, typeidx : typeidx)
  | CONST(numtype : numtype, num_ : num_(numtype))
  | UNOP(numtype : numtype, unop_ : unop_(numtype))
  | BINOP(numtype : numtype, binop_ : binop_(numtype))
  | TESTOP(numtype : numtype, testop_ : testop_(numtype))
  | RELOP(numtype : numtype, relop_ : relop_(numtype))
  | CVTOP(numtype : numtype, cvtop : cvtop, numtype : numtype, sx?)
  | VCONST(vectype : vectype, vec_ : vec_(vectype))
  | VVUNOP(vectype : vectype, vvunop : vvunop)
  | VVBINOP(vectype : vectype, vvbinop : vvbinop)
  | VVTERNOP(vectype : vectype, vvternop : vvternop)
  | VVTESTOP(vectype : vectype, vvtestop : vvtestop)
  | VSWIZZLE{ishape : ishape}(ishape : ishape)
    -- if (ishape = `%X%`(I8_imm, 16))
  | VSHUFFLE{ishape : ishape, laneidx* : laneidx*}(ishape : ishape, laneidx*)
    -- if ((ishape = `%X%`(I8_imm, 16)) /\ (|laneidx*{laneidx}| = ($dim((ishape : ishape <: shape)) : dim <: nat)))
  | VSPLAT(shape : shape)
  | VEXTRACT_LANE{shape : shape, numtype : numtype, sx? : sx?}(shape : shape, sx?, laneidx : laneidx)
    -- if (($lanetype(shape) = (numtype : numtype <: lanetype)) <=> (sx?{sx} = ?()))
  | VREPLACE_LANE(shape : shape, laneidx : laneidx)
  | VUNOP(shape : shape, vunop_ : vunop_(shape))
  | VBINOP(shape : shape, vbinop_ : vbinop_(shape))
  | VTESTOP(shape : shape, vtestop_ : vtestop_(shape))
  | VRELOP(shape : shape, vrelop_ : vrelop_(shape))
  | VSHIFTOP(ishape : ishape, vshiftop_ : vshiftop_(ishape))
  | VBITMASK(ishape : ishape)
  | VCVTOP(shape : shape, vcvtop : vcvtop, half?, shape : shape, sx?, zero : zero)
  | VNARROW(ishape : ishape, ishape : ishape, sx : sx)
  | VEXTUNOP{imm_1 : imm, imm_2 : imm}(ishape_1 : ishape, ishape_2 : ishape, vextunop_ : vextunop_(ishape_1, ishape_2), sx : sx)
    -- if ($lsize((imm_1 : imm <: lanetype)) = (2 * $lsize((imm_2 : imm <: lanetype))))
  | VEXTBINOP{imm_1 : imm, imm_2 : imm}(ishape_1 : ishape, ishape_2 : ishape, vextbinop_ : vextbinop_(ishape_1, ishape_2), sx : sx)
    -- if ($lsize((imm_1 : imm <: lanetype)) = (2 * $lsize((imm_2 : imm <: lanetype))))
  | REF.NULL(heaptype : heaptype)
  | REF.I31
  | REF.FUNC(funcidx : funcidx)
  | REF.IS_NULL
  | REF.AS_NON_NULL
  | REF.EQ
  | REF.TEST(reftype : reftype)
  | REF.CAST(reftype : reftype)
  | I31.GET(sx : sx)
  | STRUCT.NEW(typeidx : typeidx)
  | STRUCT.NEW_DEFAULT(typeidx : typeidx)
  | STRUCT.GET(sx?, typeidx : typeidx, u32 : u32)
  | STRUCT.SET(typeidx : typeidx, u32 : u32)
  | ARRAY.NEW(typeidx : typeidx)
  | ARRAY.NEW_DEFAULT(typeidx : typeidx)
  | ARRAY.NEW_FIXED(typeidx : typeidx, nat)
  | ARRAY.NEW_DATA(typeidx : typeidx, dataidx : dataidx)
  | ARRAY.NEW_ELEM(typeidx : typeidx, elemidx : elemidx)
  | ARRAY.GET(sx?, typeidx : typeidx)
  | ARRAY.SET(typeidx : typeidx)
  | ARRAY.LEN
  | ARRAY.FILL(typeidx : typeidx)
  | ARRAY.COPY(typeidx : typeidx, typeidx : typeidx)
  | ARRAY.INIT_DATA(typeidx : typeidx, dataidx : dataidx)
  | ARRAY.INIT_ELEM(typeidx : typeidx, elemidx : elemidx)
  | EXTERN.CONVERT_ANY
  | ANY.CONVERT_EXTERN
  | LOCAL.GET(localidx : localidx)
  | LOCAL.SET(localidx : localidx)
  | LOCAL.TEE(localidx : localidx)
  | GLOBAL.GET(globalidx : globalidx)
  | GLOBAL.SET(globalidx : globalidx)
  | TABLE.GET(tableidx : tableidx)
  | TABLE.SET(tableidx : tableidx)
  | TABLE.SIZE(tableidx : tableidx)
  | TABLE.GROW(tableidx : tableidx)
  | TABLE.FILL(tableidx : tableidx)
  | TABLE.COPY(tableidx : tableidx, tableidx : tableidx)
  | TABLE.INIT(tableidx : tableidx, elemidx : elemidx)
  | ELEM.DROP(elemidx : elemidx)
  | MEMORY.SIZE(memidx : memidx)
  | MEMORY.GROW(memidx : memidx)
  | MEMORY.FILL(memidx : memidx)
  | MEMORY.COPY(memidx : memidx, memidx : memidx)
  | MEMORY.INIT(memidx : memidx, dataidx : dataidx)
  | DATA.DROP(dataidx : dataidx)
  | LOAD(numtype : numtype, (n, sx)?, memidx : memidx, memop : memop)
  | STORE(numtype : numtype, n?, memidx : memidx, memop : memop)
  | VLOAD(vloadop?, memidx : memidx, memop : memop)
  | VLOAD_LANE(n : n, memidx : memidx, memop : memop, laneidx : laneidx)
  | VSTORE(memidx : memidx, memop : memop)
  | VSTORE_LANE(n : n, memidx : memidx, memop : memop, laneidx : laneidx)
}

;; 1-syntax.watsup:531.1-532.9
syntax expr = instr*

;; 1-syntax.watsup:544.1-544.61
syntax elemmode =
  | ACTIVE(tableidx : tableidx, expr : expr)
  | PASSIVE
  | DECLARE

;; 1-syntax.watsup:545.1-545.49
syntax datamode =
  | ACTIVE(memidx : memidx, expr : expr)
  | PASSIVE

;; 1-syntax.watsup:547.1-548.15
syntax type = TYPE(rectype)

;; 1-syntax.watsup:549.1-550.16
syntax local = LOCAL(valtype)

;; 1-syntax.watsup:551.1-552.27
syntax func = `FUNC%%*%`(typeidx, local*, expr)

;; 1-syntax.watsup:553.1-554.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:555.1-556.23
syntax table = TABLE(tabletype, expr)

;; 1-syntax.watsup:557.1-558.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:559.1-560.30
syntax elem = `ELEM%%*%`(reftype, expr*, elemmode)

;; 1-syntax.watsup:561.1-562.22
syntax data = `DATA%*%`(byte*, datamode)

;; 1-syntax.watsup:563.1-564.16
syntax start = START(funcidx)

;; 1-syntax.watsup:566.1-567.66
syntax externidx =
  | FUNC(funcidx : funcidx)
  | GLOBAL(globalidx : globalidx)
  | TABLE(tableidx : tableidx)
  | MEM(memidx : memidx)

;; 1-syntax.watsup:568.1-569.24
syntax export = EXPORT(name, externidx)

;; 1-syntax.watsup:570.1-571.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:573.1-574.76
syntax module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*, import*, func*, global*, table*, mem*, elem*, data*, start*, export*)

;; 2-syntax-aux.watsup:8.1-8.33
rec {

;; 2-syntax-aux.watsup:8.1-8.33
def $setminus1(idx : idx, idx*) : idx*
  ;; 2-syntax-aux.watsup:13.1-13.27
  def $setminus1{x : idx}(x, []) = [x]
  ;; 2-syntax-aux.watsup:14.1-14.61
  def $setminus1{x : idx, y_1 : idx, y* : idx*}(x, [y_1] :: y*{y}) = []
    -- if (x = y_1)
  ;; 2-syntax-aux.watsup:15.1-15.60
  def $setminus1{x : idx, y_1 : idx, y* : idx*}(x, [y_1] :: y*{y}) = $setminus1(x, y*{y})
    -- otherwise
}

;; 2-syntax-aux.watsup:7.1-7.49
rec {

;; 2-syntax-aux.watsup:7.1-7.49
def $setminus(idx*, idx*) : idx*
  ;; 2-syntax-aux.watsup:10.1-10.29
  def $setminus{y* : idx*}([], y*{y}) = []
  ;; 2-syntax-aux.watsup:11.1-11.66
  def $setminus{x_1 : idx, x* : idx*, y* : idx*}([x_1] :: x*{x}, y*{y}) = $setminus1(x_1, y*{y}) :: $setminus(x*{x}, y*{y})
}

;; 2-syntax-aux.watsup:20.1-20.71
def $free_dataidx_instr(instr : instr) : dataidx*
  ;; 2-syntax-aux.watsup:21.1-21.45
  def $free_dataidx_instr{x : idx, y : idx}(MEMORY.INIT_instr(x, y)) = [y]
  ;; 2-syntax-aux.watsup:22.1-22.41
  def $free_dataidx_instr{x : idx}(DATA.DROP_instr(x)) = [x]
  ;; 2-syntax-aux.watsup:23.1-23.34
  def $free_dataidx_instr{in : instr}(in) = []

;; 2-syntax-aux.watsup:25.1-25.73
rec {

;; 2-syntax-aux.watsup:25.1-25.73
def $free_dataidx_instrs(instr*) : dataidx*
  ;; 2-syntax-aux.watsup:26.1-26.36
  def $free_dataidx_instrs([]) = []
  ;; 2-syntax-aux.watsup:27.1-27.99
  def $free_dataidx_instrs{instr : instr, instr'* : instr*}([instr] :: instr'*{instr'}) = $free_dataidx_instr(instr) :: $free_dataidx_instrs(instr'*{instr'})
}

;; 2-syntax-aux.watsup:29.1-29.69
def $free_dataidx_expr(expr : expr) : dataidx*
  ;; 2-syntax-aux.watsup:30.1-30.56
  def $free_dataidx_expr{in* : instr*}(in*{in}) = $free_dataidx_instrs(in*{in})

;; 2-syntax-aux.watsup:32.1-32.69
def $free_dataidx_func(func : func) : dataidx*
  ;; 2-syntax-aux.watsup:33.1-33.62
  def $free_dataidx_func{x : idx, loc* : local*, e : expr}(`FUNC%%*%`(x, loc*{loc}, e)) = $free_dataidx_expr(e)

;; 2-syntax-aux.watsup:35.1-35.71
rec {

;; 2-syntax-aux.watsup:35.1-35.71
def $free_dataidx_funcs(func*) : dataidx*
  ;; 2-syntax-aux.watsup:36.1-36.35
  def $free_dataidx_funcs([]) = []
  ;; 2-syntax-aux.watsup:37.1-37.92
  def $free_dataidx_funcs{func : func, func'* : func*}([func] :: func'*{func'}) = $free_dataidx_func(func) :: $free_dataidx_funcs(func'*{func'})
}

;; 2-syntax-aux.watsup:71.1-71.56
def $lunpack(lanetype : lanetype) : numtype
  ;; 2-syntax-aux.watsup:72.1-72.32
  def $lunpack{numtype : numtype}((numtype : numtype <: lanetype)) = numtype
  ;; 2-syntax-aux.watsup:73.1-73.29
  def $lunpack{packtype : packtype}((packtype : packtype <: lanetype)) = I32_numtype

;; 2-syntax-aux.watsup:75.1-75.58
def $unpack(storagetype : storagetype) : valtype
  ;; 2-syntax-aux.watsup:76.1-76.31
  def $unpack{valtype : valtype}((valtype : valtype <: storagetype)) = valtype
  ;; 2-syntax-aux.watsup:77.1-77.28
  def $unpack{packtype : packtype}((packtype : packtype <: storagetype)) = I32_valtype

;; 2-syntax-aux.watsup:79.1-79.73
def $nunpack(storagetype : storagetype) : numtype
  ;; 2-syntax-aux.watsup:80.1-80.32
  def $nunpack{numtype : numtype}((numtype : numtype <: storagetype)) = numtype
  ;; 2-syntax-aux.watsup:81.1-81.29
  def $nunpack{packtype : packtype}((packtype : packtype <: storagetype)) = I32_numtype

;; 2-syntax-aux.watsup:83.1-83.73
def $vunpack(storagetype : storagetype) : vectype
  ;; 2-syntax-aux.watsup:84.1-84.32
  def $vunpack{vectype : vectype}((vectype : vectype <: storagetype)) = vectype

;; 2-syntax-aux.watsup:86.1-86.51
def $sxfield(storagetype : storagetype) : sx?
  ;; 2-syntax-aux.watsup:87.1-87.28
  def $sxfield{valtype : valtype}((valtype : valtype <: storagetype)) = ?()
  ;; 2-syntax-aux.watsup:88.1-88.27
  def $sxfield{packtype : packtype}((packtype : packtype <: storagetype)) = ?(S_sx)

;; 2-syntax-aux.watsup:105.1-105.59
def $diffrt(reftype : reftype, reftype : reftype) : reftype
  ;; 2-syntax-aux.watsup:107.1-107.64
  def $diffrt{nul_1 : nul, ht_1 : heaptype, ht_2 : heaptype}(REF_reftype(nul_1, ht_1), REF_reftype(`NULL%?`(?(())), ht_2)) = REF_reftype(`NULL%?`(?()), ht_1)
  ;; 2-syntax-aux.watsup:108.1-108.65
  def $diffrt{nul_1 : nul, ht_1 : heaptype, ht_2 : heaptype}(REF_reftype(nul_1, ht_1), REF_reftype(`NULL%?`(?()), ht_2)) = REF_reftype(nul_1, ht_1)

;; 2-syntax-aux.watsup:113.1-113.42
syntax typevar =
  | _IDX(typeidx : typeidx)
  | REC(nat)

;; 2-syntax-aux.watsup:116.1-116.42
def $idx(typeidx : typeidx) : typevar
  ;; 2-syntax-aux.watsup:117.1-117.21
  def $idx{x : idx}(x) = _IDX_typevar(x)

;; 2-syntax-aux.watsup:122.1-122.92
rec {

;; 2-syntax-aux.watsup:122.1-122.92
def $subst_typevar(typevar : typevar, typevar*, heaptype*) : heaptype
  ;; 2-syntax-aux.watsup:147.1-147.38
  def $subst_typevar{xx : typevar}(xx, [], []) = (xx : typevar <: heaptype)
  ;; 2-syntax-aux.watsup:148.1-148.95
  def $subst_typevar{xx : typevar, xx_1 : typevar, xx'* : typevar*, ht_1 : heaptype, ht'* : heaptype*}(xx, [xx_1] :: xx'*{xx'}, [ht_1] :: ht'*{ht'}) = ht_1
    -- if (xx = xx_1)
  ;; 2-syntax-aux.watsup:149.1-149.92
  def $subst_typevar{xx : typevar, xx_1 : typevar, xx'* : typevar*, ht_1 : heaptype, ht'* : heaptype*}(xx, [xx_1] :: xx'*{xx'}, [ht_1] :: ht'*{ht'}) = $subst_typevar(xx, xx'*{xx'}, ht'*{ht'})
    -- otherwise
}

;; 2-syntax-aux.watsup:124.1-124.92
def $subst_numtype(numtype : numtype, typevar*, heaptype*) : numtype
  ;; 2-syntax-aux.watsup:151.1-151.38
  def $subst_numtype{nt : numtype, xx* : typevar*, ht* : heaptype*}(nt, xx*{xx}, ht*{ht}) = nt

;; 2-syntax-aux.watsup:125.1-125.92
def $subst_vectype(vectype : vectype, typevar*, heaptype*) : vectype
  ;; 2-syntax-aux.watsup:152.1-152.38
  def $subst_vectype{vt : vectype, xx* : typevar*, ht* : heaptype*}(vt, xx*{xx}, ht*{ht}) = vt

;; 2-syntax-aux.watsup:130.1-130.92
def $subst_packtype(packtype : packtype, typevar*, heaptype*) : packtype
  ;; 2-syntax-aux.watsup:165.1-165.39
  def $subst_packtype{pt : packtype, xx* : typevar*, ht* : heaptype*}(pt, xx*{xx}, ht*{ht}) = pt

;; 2-syntax-aux.watsup:126.1-140.92
rec {

;; 2-syntax-aux.watsup:126.1-126.92
def $subst_heaptype(heaptype : heaptype, typevar*, heaptype*) : heaptype
  ;; 2-syntax-aux.watsup:154.1-154.67
  def $subst_heaptype{xx' : typevar, xx* : typevar*, ht* : heaptype*}((xx' : typevar <: heaptype), xx*{xx}, ht*{ht}) = $subst_typevar(xx', xx*{xx}, ht*{ht})
  ;; 2-syntax-aux.watsup:155.1-155.65
  def $subst_heaptype{dt : deftype, xx* : typevar*, ht* : heaptype*}((dt : deftype <: heaptype), xx*{xx}, ht*{ht}) = ($subst_deftype(dt, xx*{xx}, ht*{ht}) : deftype <: heaptype)
  ;; 2-syntax-aux.watsup:156.1-156.55
  def $subst_heaptype{ht' : heaptype, xx* : typevar*, ht* : heaptype*}(ht', xx*{xx}, ht*{ht}) = ht'
    -- otherwise

;; 2-syntax-aux.watsup:127.1-127.92
def $subst_reftype(reftype : reftype, typevar*, heaptype*) : reftype
  ;; 2-syntax-aux.watsup:158.1-158.85
  def $subst_reftype{nul : nul, ht' : heaptype, xx* : typevar*, ht* : heaptype*}(REF_reftype(nul, ht'), xx*{xx}, ht*{ht}) = REF_reftype(nul, $subst_heaptype(ht', xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:128.1-128.92
def $subst_valtype(valtype : valtype, typevar*, heaptype*) : valtype
  ;; 2-syntax-aux.watsup:160.1-160.64
  def $subst_valtype{nt : numtype, xx* : typevar*, ht* : heaptype*}((nt : numtype <: valtype), xx*{xx}, ht*{ht}) = ($subst_numtype(nt, xx*{xx}, ht*{ht}) : numtype <: valtype)
  ;; 2-syntax-aux.watsup:161.1-161.64
  def $subst_valtype{vt : vectype, xx* : typevar*, ht* : heaptype*}((vt : vectype <: valtype), xx*{xx}, ht*{ht}) = ($subst_vectype(vt, xx*{xx}, ht*{ht}) : vectype <: valtype)
  ;; 2-syntax-aux.watsup:162.1-162.64
  def $subst_valtype{rt : reftype, xx* : typevar*, ht* : heaptype*}((rt : reftype <: valtype), xx*{xx}, ht*{ht}) = ($subst_reftype(rt, xx*{xx}, ht*{ht}) : reftype <: valtype)
  ;; 2-syntax-aux.watsup:163.1-163.40
  def $subst_valtype{xx* : typevar*, ht* : heaptype*}(BOT_valtype, xx*{xx}, ht*{ht}) = BOT_valtype

;; 2-syntax-aux.watsup:131.1-131.92
def $subst_storagetype(storagetype : storagetype, typevar*, heaptype*) : storagetype
  ;; 2-syntax-aux.watsup:167.1-167.66
  def $subst_storagetype{t : valtype, xx* : typevar*, ht* : heaptype*}((t : valtype <: storagetype), xx*{xx}, ht*{ht}) = ($subst_valtype(t, xx*{xx}, ht*{ht}) : valtype <: storagetype)
  ;; 2-syntax-aux.watsup:168.1-168.69
  def $subst_storagetype{pt : packtype, xx* : typevar*, ht* : heaptype*}((pt : packtype <: storagetype), xx*{xx}, ht*{ht}) = ($subst_packtype(pt, xx*{xx}, ht*{ht}) : packtype <: storagetype)

;; 2-syntax-aux.watsup:132.1-132.92
def $subst_fieldtype(fieldtype : fieldtype, typevar*, heaptype*) : fieldtype
  ;; 2-syntax-aux.watsup:170.1-170.80
  def $subst_fieldtype{mut : mut, zt : storagetype, xx* : typevar*, ht* : heaptype*}(`%%`(mut, zt), xx*{xx}, ht*{ht}) = `%%`(mut, $subst_storagetype(zt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:134.1-134.92
def $subst_comptype(comptype : comptype, typevar*, heaptype*) : comptype
  ;; 2-syntax-aux.watsup:172.1-172.85
  def $subst_comptype{yt* : fieldtype*, xx* : typevar*, ht* : heaptype*}(STRUCT_comptype(yt*{yt}), xx*{xx}, ht*{ht}) = STRUCT_comptype($subst_fieldtype(yt, xx*{xx}, ht*{ht})*{yt})
  ;; 2-syntax-aux.watsup:173.1-173.81
  def $subst_comptype{yt : fieldtype, xx* : typevar*, ht* : heaptype*}(ARRAY_comptype(yt), xx*{xx}, ht*{ht}) = ARRAY_comptype($subst_fieldtype(yt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:174.1-174.78
  def $subst_comptype{ft : functype, xx* : typevar*, ht* : heaptype*}(FUNC_comptype(ft), xx*{xx}, ht*{ht}) = FUNC_comptype($subst_functype(ft, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:135.1-135.92
def $subst_subtype(subtype : subtype, typevar*, heaptype*) : subtype
  ;; 2-syntax-aux.watsup:176.1-177.76
  def $subst_subtype{fin : fin, y* : idx*, ct : comptype, xx* : typevar*, ht* : heaptype*}(SUB_subtype(fin, y*{y}, ct), xx*{xx}, ht*{ht}) = SUBD_subtype(fin, $subst_heaptype(_IDX_heaptype(y), xx*{xx}, ht*{ht})*{y}, $subst_comptype(ct, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:178.1-179.73
  def $subst_subtype{fin : fin, ht'* : heaptype*, ct : comptype, xx* : typevar*, ht* : heaptype*}(SUBD_subtype(fin, ht'*{ht'}, ct), xx*{xx}, ht*{ht}) = SUBD_subtype(fin, $subst_heaptype(ht', xx*{xx}, ht*{ht})*{ht'}, $subst_comptype(ct, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:136.1-136.92
def $subst_rectype(rectype : rectype, typevar*, heaptype*) : rectype
  ;; 2-syntax-aux.watsup:181.1-181.76
  def $subst_rectype{st* : subtype*, xx* : typevar*, ht* : heaptype*}(REC_rectype(st*{st}), xx*{xx}, ht*{ht}) = REC_rectype($subst_subtype(st, xx*{xx}, ht*{ht})*{st})

;; 2-syntax-aux.watsup:137.1-137.92
def $subst_deftype(deftype : deftype, typevar*, heaptype*) : deftype
  ;; 2-syntax-aux.watsup:183.1-183.78
  def $subst_deftype{qt : rectype, i : nat, xx* : typevar*, ht* : heaptype*}(DEF_deftype(qt, i), xx*{xx}, ht*{ht}) = DEF_deftype($subst_rectype(qt, xx*{xx}, ht*{ht}), i)

;; 2-syntax-aux.watsup:140.1-140.92
def $subst_functype(functype : functype, typevar*, heaptype*) : functype
  ;; 2-syntax-aux.watsup:186.1-186.113
  def $subst_functype{t_1* : valtype*, t_2* : valtype*, xx* : typevar*, ht* : heaptype*}(`%->%`(t_1*{t_1}, t_2*{t_2}), xx*{xx}, ht*{ht}) = `%->%`($subst_valtype(t_1, xx*{xx}, ht*{ht})*{t_1}, $subst_valtype(t_2, xx*{xx}, ht*{ht})*{t_2})
}

;; 2-syntax-aux.watsup:139.1-139.92
def $subst_globaltype(globaltype : globaltype, typevar*, heaptype*) : globaltype
  ;; 2-syntax-aux.watsup:185.1-185.75
  def $subst_globaltype{mut : mut, t : valtype, xx* : typevar*, ht* : heaptype*}(`%%`(mut, t), xx*{xx}, ht*{ht}) = `%%`(mut, $subst_valtype(t, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:141.1-141.92
def $subst_tabletype(tabletype : tabletype, typevar*, heaptype*) : tabletype
  ;; 2-syntax-aux.watsup:188.1-188.76
  def $subst_tabletype{lim : limits, rt : reftype, xx* : typevar*, ht* : heaptype*}(`%%`(lim, rt), xx*{xx}, ht*{ht}) = `%%`(lim, $subst_reftype(rt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:142.1-142.92
def $subst_memtype(memtype : memtype, typevar*, heaptype*) : memtype
  ;; 2-syntax-aux.watsup:187.1-187.48
  def $subst_memtype{lim : limits, xx* : typevar*, ht* : heaptype*}(`%I8`(lim), xx*{xx}, ht*{ht}) = `%I8`(lim)

;; 2-syntax-aux.watsup:144.1-144.92
def $subst_externtype(externtype : externtype, typevar*, heaptype*) : externtype
  ;; 2-syntax-aux.watsup:190.1-190.79
  def $subst_externtype{dt : deftype, xx* : typevar*, ht* : heaptype*}(FUNC_externtype(dt), xx*{xx}, ht*{ht}) = FUNC_externtype($subst_deftype(dt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:191.1-191.86
  def $subst_externtype{gt : globaltype, xx* : typevar*, ht* : heaptype*}(GLOBAL_externtype(gt), xx*{xx}, ht*{ht}) = GLOBAL_externtype($subst_globaltype(gt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:192.1-192.83
  def $subst_externtype{tt : tabletype, xx* : typevar*, ht* : heaptype*}(TABLE_externtype(tt), xx*{xx}, ht*{ht}) = TABLE_externtype($subst_tabletype(tt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:193.1-193.77
  def $subst_externtype{mt : memtype, xx* : typevar*, ht* : heaptype*}(MEM_externtype(mt), xx*{xx}, ht*{ht}) = MEM_externtype($subst_memtype(mt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:196.1-196.74
def $subst_all_reftype(reftype : reftype, heaptype*) : reftype
  ;; 2-syntax-aux.watsup:199.1-199.75
  def $subst_all_reftype{rt : reftype, ht^n : heaptype^n, n : n, x^n : idx^n}(rt, ht^n{ht}) = $subst_reftype(rt, $idx(x)^(x<n){x}, ht^n{ht})

;; 2-syntax-aux.watsup:197.1-197.74
def $subst_all_deftype(deftype : deftype, heaptype*) : deftype
  ;; 2-syntax-aux.watsup:200.1-200.75
  def $subst_all_deftype{dt : deftype, ht^n : heaptype^n, n : n, x^n : idx^n}(dt, ht^n{ht}) = $subst_deftype(dt, $idx(x)^(x<n){x}, ht^n{ht})

;; 2-syntax-aux.watsup:202.1-202.77
rec {

;; 2-syntax-aux.watsup:202.1-202.77
def $subst_all_deftypes(deftype*, heaptype*) : deftype*
  ;; 2-syntax-aux.watsup:204.1-204.40
  def $subst_all_deftypes{ht* : heaptype*}([], ht*{ht}) = []
  ;; 2-syntax-aux.watsup:205.1-205.101
  def $subst_all_deftypes{dt_1 : deftype, dt* : deftype*, ht* : heaptype*}([dt_1] :: dt*{dt}, ht*{ht}) = [$subst_all_deftype(dt_1, ht*{ht})] :: $subst_all_deftypes(dt*{dt}, ht*{ht})
}

;; 2-syntax-aux.watsup:210.1-210.65
def $rollrt(typeidx : typeidx, rectype : rectype) : rectype
  ;; 2-syntax-aux.watsup:219.1-219.93
  def $rollrt{x : idx, st^n : subtype^n, n : n, i^n : nat^n}(x, REC_rectype(st^n{st})) = REC_rectype($subst_subtype(st, $idx(((x : uN(32) <: nat) + i))^(i<n){i}, REC_heaptype(i)^(i<n){i})^n{st})

;; 2-syntax-aux.watsup:211.1-211.63
def $unrollrt(rectype : rectype) : rectype
  ;; 2-syntax-aux.watsup:220.1-221.22
  def $unrollrt{st^n : subtype^n, n : n, i^n : nat^n, qt : rectype}(REC_rectype(st^n{st})) = REC_rectype($subst_subtype(st, REC_typevar(i)^(i<n){i}, DEF_heaptype(qt, i)^(i<n){i})^n{st})
    -- if (qt = REC_rectype(st^n{st}))

;; 2-syntax-aux.watsup:212.1-212.65
def $rolldt(typeidx : typeidx, rectype : rectype) : deftype*
  ;; 2-syntax-aux.watsup:223.1-223.79
  def $rolldt{x : idx, qt : rectype, st^n : subtype^n, n : n, i^n : nat^n}(x, qt) = DEF_deftype(REC_rectype(st^n{st}), i)^(i<n){i}
    -- if ($rollrt(x, qt) = REC_rectype(st^n{st}))

;; 2-syntax-aux.watsup:213.1-213.63
def $unrolldt(deftype : deftype) : subtype
  ;; 2-syntax-aux.watsup:224.1-224.77
  def $unrolldt{qt : rectype, i : nat, st* : subtype*}(DEF_deftype(qt, i)) = st*{st}[i]
    -- if ($unrollrt(qt) = REC_rectype(st*{st}))

;; 2-syntax-aux.watsup:214.1-214.63
def $expanddt(deftype : deftype) : comptype
  ;; 2-syntax-aux.watsup:226.1-226.85
  def $expanddt{dt : deftype, ct : comptype, fin : fin, ht* : heaptype*}(dt) = ct
    -- if ($unrolldt(dt) = SUBD_subtype(fin, ht*{ht}, ct))

;; 2-syntax-aux.watsup:228.1-228.37
relation Expand: `%~~%`(deftype, comptype)
  ;; 2-syntax-aux.watsup:229.1-229.72
  rule _{dt : deftype, ct : comptype}:
    `%~~%`(dt, ct)
    -- if ($expanddt(dt) = ct)

;; 2-syntax-aux.watsup:235.1-235.64
rec {

;; 2-syntax-aux.watsup:235.1-235.64
def $funcsxt(externtype*) : deftype*
  ;; 2-syntax-aux.watsup:240.1-240.24
  def $funcsxt([]) = []
  ;; 2-syntax-aux.watsup:241.1-241.47
  def $funcsxt{dt : deftype, et* : externtype*}([FUNC_externtype(dt)] :: et*{et}) = [dt] :: $funcsxt(et*{et})
  ;; 2-syntax-aux.watsup:242.1-242.59
  def $funcsxt{externtype : externtype, et* : externtype*}([externtype] :: et*{et}) = $funcsxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup:236.1-236.66
rec {

;; 2-syntax-aux.watsup:236.1-236.66
def $globalsxt(externtype*) : globaltype*
  ;; 2-syntax-aux.watsup:244.1-244.26
  def $globalsxt([]) = []
  ;; 2-syntax-aux.watsup:245.1-245.53
  def $globalsxt{gt : globaltype, et* : externtype*}([GLOBAL_externtype(gt)] :: et*{et}) = [gt] :: $globalsxt(et*{et})
  ;; 2-syntax-aux.watsup:246.1-246.63
  def $globalsxt{externtype : externtype, et* : externtype*}([externtype] :: et*{et}) = $globalsxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup:237.1-237.65
rec {

;; 2-syntax-aux.watsup:237.1-237.65
def $tablesxt(externtype*) : tabletype*
  ;; 2-syntax-aux.watsup:248.1-248.25
  def $tablesxt([]) = []
  ;; 2-syntax-aux.watsup:249.1-249.50
  def $tablesxt{tt : tabletype, et* : externtype*}([TABLE_externtype(tt)] :: et*{et}) = [tt] :: $tablesxt(et*{et})
  ;; 2-syntax-aux.watsup:250.1-250.61
  def $tablesxt{externtype : externtype, et* : externtype*}([externtype] :: et*{et}) = $tablesxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup:238.1-238.63
rec {

;; 2-syntax-aux.watsup:238.1-238.63
def $memsxt(externtype*) : memtype*
  ;; 2-syntax-aux.watsup:252.1-252.23
  def $memsxt([]) = []
  ;; 2-syntax-aux.watsup:253.1-253.44
  def $memsxt{mt : memtype, et* : externtype*}([MEM_externtype(mt)] :: et*{et}) = [mt] :: $memsxt(et*{et})
  ;; 2-syntax-aux.watsup:254.1-254.57
  def $memsxt{externtype : externtype, et* : externtype*}([externtype] :: et*{et}) = $memsxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup:263.1-263.33
def $memop0 : memop
  ;; 2-syntax-aux.watsup:264.1-264.34
  def $memop0 = {ALIGN 0, OFFSET 0}

;; 3-numerics.watsup:7.1-7.41
def $s33_to_u32(s33 : s33) : u32

;; 3-numerics.watsup:12.1-12.57
def $signed(N : N, nat : nat) : int
  ;; 3-numerics.watsup:13.1-13.54
  def $signed{N : N, i : nat}(N, i) = (i : nat <: int)
    -- if (0 <= (2 ^ (N - 1)))
  ;; 3-numerics.watsup:14.1-14.60
  def $signed{N : N, i : nat}(N, i) = ((i - (2 ^ N)) : nat <: int)
    -- if (((2 ^ (N - 1)) <= i) /\ (i < (2 ^ N)))

;; 3-numerics.watsup:16.1-16.63
def $invsigned(N : N, int : int) : nat
  ;; 3-numerics.watsup:17.1-17.56
  def $invsigned{N : N, i : nat, j : nat}(N, (i : nat <: int)) = j
    -- if ($signed(N, j) = (i : nat <: int))

;; 3-numerics.watsup:34.1-34.86
def $ext(M : M, N : N, sx : sx, iN : iN(M)) : iN(N)

;; 3-numerics.watsup:91.1-91.62
def $fabs(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup:94.1-94.63
def $fceil(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup:95.1-95.64
def $ffloor(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup:97.1-97.66
def $fnearest(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup:92.1-92.62
def $fneg(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup:93.1-93.63
def $fsqrt(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup:96.1-96.64
def $ftrunc(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup:73.1-73.62
def $iclz(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup:74.1-74.62
def $ictz(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup:75.1-75.65
def $ipopcnt(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup:33.1-33.83
def $wrap(M : M, N : N, iN : iN(M)) : iN(N)

;; 3-numerics.watsup:22.1-23.29
def $unop(numtype : numtype, unop_ : unop_(numtype), num_ : num_(numtype)) : num_(numtype)*
  ;; 3-numerics.watsup:118.1-118.48
  def $unop{inn : inn, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), CLZ_unop_((inn : inn <: numtype)), iN) = [$iclz($size((inn : inn <: valtype)), iN)]
  ;; 3-numerics.watsup:119.1-119.48
  def $unop{inn : inn, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), CTZ_unop_((inn : inn <: numtype)), iN) = [$ictz($size((inn : inn <: valtype)), iN)]
  ;; 3-numerics.watsup:120.1-120.54
  def $unop{inn : inn, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), POPCNT_unop_((inn : inn <: numtype)), iN) = [$ipopcnt($size((inn : inn <: valtype)), iN)]
  ;; 3-numerics.watsup:121.1-121.80
  def $unop{inn : inn, N : N, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), EXTEND_unop_((inn : inn <: numtype))(N), iN) = [$ext(N, $size((inn : inn <: valtype)), S_sx, $wrap($size((inn : inn <: valtype)), N, iN))]
  ;; 3-numerics.watsup:138.1-138.48
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), ABS_unop_((fnn : fnn <: numtype)), fN) = [$fabs($size((fnn : fnn <: valtype)), fN)]
  ;; 3-numerics.watsup:139.1-139.48
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), NEG_unop_((fnn : fnn <: numtype)), fN) = [$fneg($size((fnn : fnn <: valtype)), fN)]
  ;; 3-numerics.watsup:140.1-140.50
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), SQRT_unop_((fnn : fnn <: numtype)), fN) = [$fsqrt($size((fnn : fnn <: valtype)), fN)]
  ;; 3-numerics.watsup:141.1-141.50
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), CEIL_unop_((fnn : fnn <: numtype)), fN) = [$fceil($size((fnn : fnn <: valtype)), fN)]
  ;; 3-numerics.watsup:142.1-142.52
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), FLOOR_unop_((fnn : fnn <: numtype)), fN) = [$ffloor($size((fnn : fnn <: valtype)), fN)]
  ;; 3-numerics.watsup:143.1-143.52
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), TRUNC_unop_((fnn : fnn <: numtype)), fN) = [$ftrunc($size((fnn : fnn <: valtype)), fN)]
  ;; 3-numerics.watsup:144.1-144.56
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), NEAREST_unop_((fnn : fnn <: numtype)), fN) = [$fnearest($size((fnn : fnn <: valtype)), fN)]

;; 3-numerics.watsup:84.1-84.64
def $fadd(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup:90.1-90.69
def $fcopysign(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup:87.1-87.64
def $fdiv(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup:89.1-89.64
def $fmax(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup:88.1-88.64
def $fmin(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup:86.1-86.64
def $fmul(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup:85.1-85.64
def $fsub(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup:60.1-60.64
def $iadd(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup:66.1-66.64
def $iand(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup:63.1-63.68
def $idiv(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup:62.1-62.64
def $imul(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup:67.1-67.63
def $ior(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup:64.1-64.68
def $irem(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup:71.1-71.65
def $irotl(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup:72.1-72.65
def $irotr(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup:69.1-69.64
def $ishl(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup:70.1-70.68
def $ishr(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup:61.1-61.64
def $isub(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup:68.1-68.64
def $ixor(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup:24.1-25.31
def $binop(numtype : numtype, binop_ : binop_(numtype), num_ : num_(numtype), num_ : num_(numtype)) : num_(numtype)*
  ;; 3-numerics.watsup:106.1-106.65
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), ADD_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$iadd($size((inn : inn <: valtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup:107.1-107.65
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), SUB_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$isub($size((inn : inn <: valtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup:108.1-108.65
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), MUL_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$imul($size((inn : inn <: valtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup:109.1-109.72
  def $binop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), DIV_binop_((inn : inn <: numtype))(sx), iN_1, iN_2) = [$idiv($size((inn : inn <: valtype)), sx, iN_1, iN_2)]
  ;; 3-numerics.watsup:110.1-110.72
  def $binop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), REM_binop_((inn : inn <: numtype))(sx), iN_1, iN_2) = [$irem($size((inn : inn <: valtype)), sx, iN_1, iN_2)]
  ;; 3-numerics.watsup:111.1-111.65
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), AND_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$iand($size((inn : inn <: valtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup:112.1-112.63
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), OR_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$ior($size((inn : inn <: valtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup:113.1-113.65
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), XOR_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$ixor($size((inn : inn <: valtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup:114.1-114.65
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), SHL_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$ishl($size((inn : inn <: valtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup:115.1-115.72
  def $binop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), SHR_binop_((inn : inn <: numtype))(sx), iN_1, iN_2) = [$ishr($size((inn : inn <: valtype)), sx, iN_1, iN_2)]
  ;; 3-numerics.watsup:116.1-116.67
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), ROTL_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$irotl($size((inn : inn <: valtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup:117.1-117.67
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), ROTR_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$irotr($size((inn : inn <: valtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup:130.1-130.65
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), ADD_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fadd($size((fnn : fnn <: valtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup:131.1-131.65
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), SUB_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fsub($size((fnn : fnn <: valtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup:132.1-132.65
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), MUL_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fmul($size((fnn : fnn <: valtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup:133.1-133.65
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), DIV_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fdiv($size((fnn : fnn <: valtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup:134.1-134.65
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), MIN_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fmin($size((fnn : fnn <: valtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup:135.1-135.65
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), MAX_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fmax($size((fnn : fnn <: valtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup:136.1-136.75
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), COPYSIGN_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fcopysign($size((fnn : fnn <: valtype)), fN_1, fN_2)]

;; 3-numerics.watsup:76.1-76.62
def $ieqz(N : N, iN : iN(N)) : u32

;; 3-numerics.watsup:26.1-27.29
def $testop(numtype : numtype, testop_ : testop_(numtype), num_ : num_(numtype)) : num_(I32_numtype)
  ;; 3-numerics.watsup:122.1-122.50
  def $testop{inn : inn, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), EQZ_testop_((inn : inn <: numtype)), iN) = $ieqz($size((inn : inn <: valtype)), iN)

;; 3-numerics.watsup:98.1-98.63
def $feq(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup:103.1-103.63
def $fge(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup:101.1-101.63
def $fgt(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup:102.1-102.63
def $fle(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup:100.1-100.63
def $flt(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup:99.1-99.63
def $fne(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup:77.1-77.63
def $ieq(N : N, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup:82.1-82.67
def $ige(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup:80.1-80.67
def $igt(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup:81.1-81.67
def $ile(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup:79.1-79.67
def $ilt(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup:78.1-78.63
def $ine(N : N, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup:28.1-29.31
def $relop(numtype : numtype, relop_ : relop_(numtype), num_ : num_(numtype), num_ : num_(numtype)) : num_(I32_numtype)
  ;; 3-numerics.watsup:123.1-123.63
  def $relop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), EQ_relop_((inn : inn <: numtype)), iN_1, iN_2) = $ieq($size((inn : inn <: valtype)), iN_1, iN_2)
  ;; 3-numerics.watsup:124.1-124.63
  def $relop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), NE_relop_((inn : inn <: numtype)), iN_1, iN_2) = $ine($size((inn : inn <: valtype)), iN_1, iN_2)
  ;; 3-numerics.watsup:125.1-125.70
  def $relop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), LT_relop_((inn : inn <: numtype))(sx), iN_1, iN_2) = $ilt($size((inn : inn <: valtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup:126.1-126.70
  def $relop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), GT_relop_((inn : inn <: numtype))(sx), iN_1, iN_2) = $igt($size((inn : inn <: valtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup:127.1-127.70
  def $relop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), LE_relop_((inn : inn <: numtype))(sx), iN_1, iN_2) = $ile($size((inn : inn <: valtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup:128.1-128.70
  def $relop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), GE_relop_((inn : inn <: numtype))(sx), iN_1, iN_2) = $ige($size((inn : inn <: valtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup:146.1-146.63
  def $relop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), EQ_relop_((fnn : fnn <: numtype)), fN_1, fN_2) = $feq($size((fnn : fnn <: valtype)), fN_1, fN_2)
  ;; 3-numerics.watsup:147.1-147.63
  def $relop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), NE_relop_((fnn : fnn <: numtype)), fN_1, fN_2) = $fne($size((fnn : fnn <: valtype)), fN_1, fN_2)
  ;; 3-numerics.watsup:148.1-148.63
  def $relop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), LT_relop_((fnn : fnn <: numtype)), fN_1, fN_2) = $flt($size((fnn : fnn <: valtype)), fN_1, fN_2)
  ;; 3-numerics.watsup:149.1-149.63
  def $relop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), GT_relop_((fnn : fnn <: numtype)), fN_1, fN_2) = $fgt($size((fnn : fnn <: valtype)), fN_1, fN_2)
  ;; 3-numerics.watsup:150.1-150.63
  def $relop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), LE_relop_((fnn : fnn <: numtype)), fN_1, fN_2) = $fle($size((fnn : fnn <: valtype)), fN_1, fN_2)
  ;; 3-numerics.watsup:151.1-151.63
  def $relop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), GE_relop_((fnn : fnn <: numtype)), fN_1, fN_2) = $fge($size((fnn : fnn <: valtype)), fN_1, fN_2)

;; 3-numerics.watsup:39.1-39.90
def $convert(M : M, N : N, sx : sx, iN : iN(M)) : fN(N)

;; 3-numerics.watsup:37.1-37.85
def $demote(M : M, N : N, fN : fN(M)) : fN(N)

;; 3-numerics.watsup:38.1-38.86
def $promote(M : M, N : N, fN : fN(M)) : fN(N)

;; 3-numerics.watsup:41.1-42.35
def $reinterpret(numtype_1 : numtype, numtype_2 : numtype, num_ : num_(numtype_1)) : num_(numtype_2)

;; 3-numerics.watsup:35.1-35.88
def $trunc(M : M, N : N, sx : sx, fN : fN(M)) : iN(N)

;; 3-numerics.watsup:36.1-36.92
def $trunc_sat(M : M, N : N, sx : sx, fN : fN(M)) : iN(N)

;; 3-numerics.watsup:30.1-31.42
def $cvtop(numtype_1 : numtype, numtype_2 : numtype, cvtop : cvtop, sx?, num_ : num_(numtype_1)) : num_(numtype_2)*
  ;; 3-numerics.watsup:153.1-153.61
  def $cvtop{sx : sx, iN : num_(I32_numtype)}(I32_numtype, I64_numtype, CONVERT_cvtop, ?(sx), iN) = [$ext(32, 64, sx, iN)]
  ;; 3-numerics.watsup:154.1-154.59
  def $cvtop{sx? : sx?, iN : num_(I64_numtype)}(I64_numtype, I32_numtype, CONVERT_cvtop, sx?{sx}, iN) = [$wrap(64, 32, iN)]
  ;; 3-numerics.watsup:155.1-155.79
  def $cvtop{fnn : fnn, inn : inn, sx : sx, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), (inn : inn <: numtype), CONVERT_cvtop, ?(sx), fN) = [$trunc($size((fnn : fnn <: valtype)), $size((inn : inn <: valtype)), sx, fN)]
  ;; 3-numerics.watsup:156.1-156.87
  def $cvtop{fnn : fnn, inn : inn, sx : sx, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), (inn : inn <: numtype), CONVERT_SAT_cvtop, ?(sx), fN) = [$trunc_sat($size((fnn : fnn <: valtype)), $size((inn : inn <: valtype)), sx, fN)]
  ;; 3-numerics.watsup:157.1-157.62
  def $cvtop{sx? : sx?, fN : num_(F32_numtype)}(F32_numtype, F64_numtype, CONVERT_cvtop, sx?{sx}, fN) = [$promote(32, 64, fN)]
  ;; 3-numerics.watsup:158.1-158.61
  def $cvtop{sx? : sx?, fN : num_(F64_numtype)}(F64_numtype, F32_numtype, CONVERT_cvtop, sx?{sx}, fN) = [$demote(64, 32, fN)]
  ;; 3-numerics.watsup:159.1-159.81
  def $cvtop{inn : inn, fnn : fnn, sx : sx, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), (fnn : fnn <: numtype), CONVERT_cvtop, ?(sx), iN) = [$convert($size((inn : inn <: valtype)), $size((fnn : fnn <: valtype)), sx, iN)]
  ;; 3-numerics.watsup:160.1-160.102
  def $cvtop{inn : inn, fnn : fnn, sx? : sx?, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), (fnn : fnn <: numtype), REINTERPRET_cvtop, sx?{sx}, iN) = [$reinterpret((inn : inn <: numtype), (fnn : fnn <: numtype), iN)]
    -- if ($size((inn : inn <: valtype)) = $size((fnn : fnn <: valtype)))
  ;; 3-numerics.watsup:161.1-161.102
  def $cvtop{fnn : fnn, inn : inn, sx? : sx?, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), (inn : inn <: numtype), REINTERPRET_cvtop, sx?{sx}, fN) = [$reinterpret((fnn : fnn <: numtype), (inn : inn <: numtype), fN)]
    -- if ($size((inn : inn <: valtype)) = $size((fnn : fnn <: valtype)))

;; 3-numerics.watsup:40.1-40.87
def $narrow(M : M, N : N, sx : sx, iN : iN(M)) : iN(N)

;; 3-numerics.watsup:44.1-44.77
def $ibits(N : N, iN : iN(N)) : bit*

;; 3-numerics.watsup:45.1-45.77
def $fbits(N : N, fN : fN(N)) : bit*

;; 3-numerics.watsup:46.1-46.78
def $ibytes(N : N, iN : iN(N)) : byte*

;; 3-numerics.watsup:47.1-47.78
def $fbytes(N : N, fN : fN(N)) : byte*

;; 3-numerics.watsup:48.1-48.76
def $nbytes(numtype : numtype, num_ : num_(numtype)) : byte*

;; 3-numerics.watsup:49.1-49.76
def $vbytes(vectype : vectype, vec_ : vec_(vectype)) : byte*

;; 3-numerics.watsup:50.1-50.78
def $zbytes(storagetype : storagetype, zval_ : zval_(storagetype)) : byte*

;; 3-numerics.watsup:53.1-53.33
def $invibytes(N : N, byte*) : iN(N)
  ;; 3-numerics.watsup:56.1-56.52
  def $invibytes{N : N, b* : byte*, n : n}(N, b*{b}) = n
    -- if ($ibytes(N, n) = b*{b})

;; 3-numerics.watsup:54.1-54.33
def $invfbytes(N : N, byte*) : fN(N)
  ;; 3-numerics.watsup:57.1-57.52
  def $invfbytes{N : N, b* : byte*, p : fN(N)}(N, b*{b}) = p
    -- if ($fbytes(N, p) = b*{b})

;; 3-numerics.watsup:65.1-65.62
def $inot(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup:166.1-167.27
def $packnum(lanetype : lanetype, num_ : num_($lunpack(lanetype))) : lane_(lanetype)
  ;; 3-numerics.watsup:168.1-168.29
  def $packnum{numtype : numtype, c : num_($lunpack((numtype : numtype <: lanetype)))}((numtype : numtype <: lanetype), c) = c
  ;; 3-numerics.watsup:169.1-169.82
  def $packnum{packtype : packtype, c : num_($lunpack((packtype : packtype <: lanetype)))}((packtype : packtype <: lanetype), c) = $wrap($size(($lunpack((packtype : packtype <: lanetype)) : numtype <: valtype)), $psize(packtype), c)

;; 3-numerics.watsup:171.1-172.29
def $unpacknum(lanetype : lanetype, lane_ : lane_(lanetype)) : num_($lunpack(lanetype))
  ;; 3-numerics.watsup:173.1-173.31
  def $unpacknum{numtype : numtype, c : lane_((numtype : numtype <: lanetype))}((numtype : numtype <: lanetype), c) = c
  ;; 3-numerics.watsup:174.1-174.86
  def $unpacknum{packtype : packtype, c : lane_((packtype : packtype <: lanetype))}((packtype : packtype <: lanetype), c) = $ext($psize(packtype), $size(($lunpack((packtype : packtype <: lanetype)) : numtype <: valtype)), U_sx, c)

;; 3-numerics.watsup:179.1-180.28
def $lanes_(shape : shape, vec_ : vec_(V128_vnn)) : lane_($lanetype(shape))*

;; 3-numerics.watsup:182.1-183.36
def $invlanes_(shape : shape, lane_($lanetype(shape))*) : vec_(V128_vnn)
  ;; 3-numerics.watsup:184.1-184.56
  def $invlanes_{sh : shape, c* : lane_($lanetype(sh))*, vc : vec_(V128_vnn)}(sh, c*{c}) = vc
    -- if (c*{c} = $lanes_(sh, vc))

;; 3-numerics.watsup:186.1-186.34
def $halfop(half : half, nat : nat, nat : nat) : nat
  ;; 3-numerics.watsup:187.1-187.27
  def $halfop{i : nat, j : nat}(LOW_half, i, j) = i
  ;; 3-numerics.watsup:188.1-188.28
  def $halfop{i : nat, j : nat}(HIGH_half, i, j) = j

;; 3-numerics.watsup:191.1-192.29
def $vvunop(vectype : vectype, vvunop : vvunop, vec_ : vec_(vectype)) : vec_(vectype)

;; 3-numerics.watsup:193.1-194.31
def $vvbinop(vectype : vectype, vvbinop : vvbinop, vec_ : vec_(vectype), vec_ : vec_(vectype)) : vec_(vectype)

;; 3-numerics.watsup:195.1-196.35
def $vvternop(vectype : vectype, vvternop : vvternop, vec_ : vec_(vectype), vec_ : vec_(vectype), vec_ : vec_(vectype)) : vec_(vectype)

;; 3-numerics.watsup:199.1-200.29
def $vunop(shape : shape, vunop_ : vunop_(shape), vec_ : vec_(V128_vnn)) : vec_(V128_vnn)

;; 3-numerics.watsup:201.1-202.31
def $vbinop(shape : shape, vbinop_ : vbinop_(shape), vec_ : vec_(V128_vnn), vec_ : vec_(V128_vnn)) : vec_(V128_vnn)*

;; 3-numerics.watsup:203.1-204.31
def $vrelop(shape : shape, vrelop_ : vrelop_(shape), vec_ : vec_(V128_vnn), vec_ : vec_(V128_vnn)) : vec_(V128_vnn)

;; 3-numerics.watsup:206.1-207.42
def $vcvtop(shape_1 : shape, shape_2 : shape, vcvtop : vcvtop, sx?, lane_ : lane_($lanetype(shape_1))) : lane_($lanetype(shape_2))

;; 3-numerics.watsup:209.1-210.42
def $vextunop(ishape_1 : ishape, ishape_2 : ishape, vextunop_ : vextunop_(ishape_1, ishape_2), sx : sx, vec_ : vec_(V128_vnn)) : vec_(V128_vnn)

;; 3-numerics.watsup:211.1-212.45
def $vextbinop(ishape_1 : ishape, ishape_2 : ishape, vextbinop_ : vextbinop_(ishape_1, ishape_2), sx : sx, vec_ : vec_(V128_vnn), vec_ : vec_(V128_vnn)) : vec_(V128_vnn)

;; 3-numerics.watsup:215.1-216.31
def $vishiftop(ishape : ishape, vshiftop_ : vshiftop_(ishape), lane_ : lane_($lanetype((ishape : ishape <: shape))), u32 : u32) : lane_($lanetype((ishape : ishape <: shape)))

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

;; 4-runtime.watsup:33.1-34.62
syntax num =
  | CONST(numtype : numtype, num_ : num_(numtype))

;; 4-runtime.watsup:35.1-36.62
syntax vec =
  | VCONST(vectype : vectype, vec_ : vec_(vectype))

;; 4-runtime.watsup:37.1-43.23
rec {

;; 4-runtime.watsup:37.1-43.23
syntax addrref =
  | REF.I31_NUM(u31 : u31)
  | REF.STRUCT_ADDR(structaddr : structaddr)
  | REF.ARRAY_ADDR(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR(funcaddr : funcaddr)
  | REF.HOST_ADDR(hostaddr : hostaddr)
  | REF.EXTERN(addrref : addrref)
}

;; 4-runtime.watsup:44.1-46.22
syntax ref =
  | REF.I31_NUM(u31 : u31)
  | REF.STRUCT_ADDR(structaddr : structaddr)
  | REF.ARRAY_ADDR(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR(funcaddr : funcaddr)
  | REF.HOST_ADDR(hostaddr : hostaddr)
  | REF.EXTERN(addrref : addrref)
  | REF.NULL(heaptype : heaptype)

;; 4-runtime.watsup:47.1-48.20
syntax val =
  | CONST(numtype : numtype, num_ : num_(numtype))
  | VCONST(vectype : vectype, vec_ : vec_(vectype))
  | REF.NULL(heaptype : heaptype)
  | REF.I31_NUM(u31 : u31)
  | REF.STRUCT_ADDR(structaddr : structaddr)
  | REF.ARRAY_ADDR(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR(funcaddr : funcaddr)
  | REF.HOST_ADDR(hostaddr : hostaddr)
  | REF.EXTERN(addrref : addrref)

;; 4-runtime.watsup:50.1-51.22
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:60.1-61.70
syntax externval =
  | FUNC(funcaddr : funcaddr)
  | GLOBAL(globaladdr : globaladdr)
  | TABLE(tableaddr : tableaddr)
  | MEM(memaddr : memaddr)

;; 4-runtime.watsup:90.1-92.22
syntax exportinst =
{
  NAME name,
  VALUE externval
}

;; 4-runtime.watsup:105.1-113.25
syntax moduleinst =
{
  TYPE deftype*,
  FUNC funcaddr*,
  GLOBAL globaladdr*,
  TABLE tableaddr*,
  MEM memaddr*,
  ELEM elemaddr*,
  DATA dataaddr*,
  EXPORT exportinst*
}

;; 4-runtime.watsup:72.1-75.16
syntax funcinst =
{
  TYPE deftype,
  MODULE moduleinst,
  CODE func
}

;; 4-runtime.watsup:76.1-78.16
syntax globalinst =
{
  TYPE globaltype,
  VALUE val
}

;; 4-runtime.watsup:79.1-81.16
syntax tableinst =
{
  TYPE tabletype,
  ELEM ref*
}

;; 4-runtime.watsup:82.1-84.17
syntax meminst =
{
  TYPE memtype,
  DATA byte*
}

;; 4-runtime.watsup:85.1-87.16
syntax eleminst =
{
  TYPE elemtype,
  ELEM ref*
}

;; 4-runtime.watsup:88.1-89.17
syntax datainst =
{
  DATA byte*
}

;; 4-runtime.watsup:94.1-95.57
syntax packval =
  | PACK(packtype : packtype, pack_ : pack_(packtype))

;; 4-runtime.watsup:96.1-97.18
syntax fieldval =
  | CONST(numtype : numtype, num_ : num_(numtype))
  | VCONST(vectype : vectype, vec_ : vec_(vectype))
  | REF.NULL(heaptype : heaptype)
  | REF.I31_NUM(u31 : u31)
  | REF.STRUCT_ADDR(structaddr : structaddr)
  | REF.ARRAY_ADDR(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR(funcaddr : funcaddr)
  | REF.HOST_ADDR(hostaddr : hostaddr)
  | REF.EXTERN(addrref : addrref)
  | PACK(packtype : packtype, pack_ : pack_(packtype))

;; 4-runtime.watsup:98.1-100.22
syntax structinst =
{
  TYPE deftype,
  FIELD fieldval*
}

;; 4-runtime.watsup:101.1-103.22
syntax arrayinst =
{
  TYPE deftype,
  FIELD fieldval*
}

;; 4-runtime.watsup:132.1-140.23
syntax store =
{
  FUNC funcinst*,
  GLOBAL globalinst*,
  TABLE tableinst*,
  MEM meminst*,
  ELEM eleminst*,
  DATA datainst*,
  STRUCT structinst*,
  ARRAY arrayinst*
}

;; 4-runtime.watsup:142.1-144.24
syntax frame =
{
  LOCAL val?*,
  MODULE moduleinst
}

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
  | BLOCK(blocktype : blocktype, instr*)
  | LOOP(blocktype : blocktype, instr*)
  | IF(blocktype : blocktype, instr*, instr*)
  | BR(labelidx : labelidx)
  | BR_IF(labelidx : labelidx)
  | BR_TABLE(labelidx*, labelidx : labelidx)
  | BR_ON_NULL(labelidx : labelidx)
  | BR_ON_NON_NULL(labelidx : labelidx)
  | BR_ON_CAST(labelidx : labelidx, reftype : reftype, reftype : reftype)
  | BR_ON_CAST_FAIL(labelidx : labelidx, reftype : reftype, reftype : reftype)
  | CALL(funcidx : funcidx)
  | CALL_REF(typeidx?)
  | CALL_INDIRECT(tableidx : tableidx, typeidx : typeidx)
  | RETURN
  | RETURN_CALL(funcidx : funcidx)
  | RETURN_CALL_REF(typeidx?)
  | RETURN_CALL_INDIRECT(tableidx : tableidx, typeidx : typeidx)
  | CONST(numtype : numtype, num_ : num_(numtype))
  | UNOP(numtype : numtype, unop_ : unop_(numtype))
  | BINOP(numtype : numtype, binop_ : binop_(numtype))
  | TESTOP(numtype : numtype, testop_ : testop_(numtype))
  | RELOP(numtype : numtype, relop_ : relop_(numtype))
  | CVTOP(numtype : numtype, cvtop : cvtop, numtype : numtype, sx?)
  | VCONST(vectype : vectype, vec_ : vec_(vectype))
  | VVUNOP(vectype : vectype, vvunop : vvunop)
  | VVBINOP(vectype : vectype, vvbinop : vvbinop)
  | VVTERNOP(vectype : vectype, vvternop : vvternop)
  | VVTESTOP(vectype : vectype, vvtestop : vvtestop)
  | VSWIZZLE{ishape : ishape}(ishape : ishape)
    -- if (ishape = `%X%`(I8_imm, 16))
  | VSHUFFLE{ishape : ishape, laneidx* : laneidx*}(ishape : ishape, laneidx*)
    -- if ((ishape = `%X%`(I8_imm, 16)) /\ (|laneidx*{laneidx}| = ($dim((ishape : ishape <: shape)) : dim <: nat)))
  | VSPLAT(shape : shape)
  | VEXTRACT_LANE{shape : shape, numtype : numtype, sx? : sx?}(shape : shape, sx?, laneidx : laneidx)
    -- if (($lanetype(shape) = (numtype : numtype <: lanetype)) <=> (sx?{sx} = ?()))
  | VREPLACE_LANE(shape : shape, laneidx : laneidx)
  | VUNOP(shape : shape, vunop_ : vunop_(shape))
  | VBINOP(shape : shape, vbinop_ : vbinop_(shape))
  | VTESTOP(shape : shape, vtestop_ : vtestop_(shape))
  | VRELOP(shape : shape, vrelop_ : vrelop_(shape))
  | VSHIFTOP(ishape : ishape, vshiftop_ : vshiftop_(ishape))
  | VBITMASK(ishape : ishape)
  | VCVTOP(shape : shape, vcvtop : vcvtop, half?, shape : shape, sx?, zero : zero)
  | VNARROW(ishape : ishape, ishape : ishape, sx : sx)
  | VEXTUNOP{imm_1 : imm, imm_2 : imm}(ishape_1 : ishape, ishape_2 : ishape, vextunop_ : vextunop_(ishape_1, ishape_2), sx : sx)
    -- if ($lsize((imm_1 : imm <: lanetype)) = (2 * $lsize((imm_2 : imm <: lanetype))))
  | VEXTBINOP{imm_1 : imm, imm_2 : imm}(ishape_1 : ishape, ishape_2 : ishape, vextbinop_ : vextbinop_(ishape_1, ishape_2), sx : sx)
    -- if ($lsize((imm_1 : imm <: lanetype)) = (2 * $lsize((imm_2 : imm <: lanetype))))
  | REF.NULL(heaptype : heaptype)
  | REF.I31
  | REF.FUNC(funcidx : funcidx)
  | REF.IS_NULL
  | REF.AS_NON_NULL
  | REF.EQ
  | REF.TEST(reftype : reftype)
  | REF.CAST(reftype : reftype)
  | I31.GET(sx : sx)
  | STRUCT.NEW(typeidx : typeidx)
  | STRUCT.NEW_DEFAULT(typeidx : typeidx)
  | STRUCT.GET(sx?, typeidx : typeidx, u32 : u32)
  | STRUCT.SET(typeidx : typeidx, u32 : u32)
  | ARRAY.NEW(typeidx : typeidx)
  | ARRAY.NEW_DEFAULT(typeidx : typeidx)
  | ARRAY.NEW_FIXED(typeidx : typeidx, nat)
  | ARRAY.NEW_DATA(typeidx : typeidx, dataidx : dataidx)
  | ARRAY.NEW_ELEM(typeidx : typeidx, elemidx : elemidx)
  | ARRAY.GET(sx?, typeidx : typeidx)
  | ARRAY.SET(typeidx : typeidx)
  | ARRAY.LEN
  | ARRAY.FILL(typeidx : typeidx)
  | ARRAY.COPY(typeidx : typeidx, typeidx : typeidx)
  | ARRAY.INIT_DATA(typeidx : typeidx, dataidx : dataidx)
  | ARRAY.INIT_ELEM(typeidx : typeidx, elemidx : elemidx)
  | EXTERN.CONVERT_ANY
  | ANY.CONVERT_EXTERN
  | LOCAL.GET(localidx : localidx)
  | LOCAL.SET(localidx : localidx)
  | LOCAL.TEE(localidx : localidx)
  | GLOBAL.GET(globalidx : globalidx)
  | GLOBAL.SET(globalidx : globalidx)
  | TABLE.GET(tableidx : tableidx)
  | TABLE.SET(tableidx : tableidx)
  | TABLE.SIZE(tableidx : tableidx)
  | TABLE.GROW(tableidx : tableidx)
  | TABLE.FILL(tableidx : tableidx)
  | TABLE.COPY(tableidx : tableidx, tableidx : tableidx)
  | TABLE.INIT(tableidx : tableidx, elemidx : elemidx)
  | ELEM.DROP(elemidx : elemidx)
  | MEMORY.SIZE(memidx : memidx)
  | MEMORY.GROW(memidx : memidx)
  | MEMORY.FILL(memidx : memidx)
  | MEMORY.COPY(memidx : memidx, memidx : memidx)
  | MEMORY.INIT(memidx : memidx, dataidx : dataidx)
  | DATA.DROP(dataidx : dataidx)
  | LOAD(numtype : numtype, (n, sx)?, memidx : memidx, memop : memop)
  | STORE(numtype : numtype, n?, memidx : memidx, memop : memop)
  | VLOAD(vloadop?, memidx : memidx, memop : memop)
  | VLOAD_LANE(n : n, memidx : memidx, memop : memop, laneidx : laneidx)
  | VSTORE(memidx : memidx, memop : memop)
  | VSTORE_LANE(n : n, memidx : memidx, memop : memop, laneidx : laneidx)
  | REF.I31_NUM(u31 : u31)
  | REF.STRUCT_ADDR(structaddr : structaddr)
  | REF.ARRAY_ADDR(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR(funcaddr : funcaddr)
  | REF.HOST_ADDR(hostaddr : hostaddr)
  | REF.EXTERN(addrref : addrref)
  | LABEL_(n : n, instr*, admininstr*)
  | FRAME_(n : n, frame : frame, admininstr*)
  | TRAP
}

;; 4-runtime.watsup:147.1-147.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:165.1-168.25
rec {

;; 4-runtime.watsup:165.1-168.25
syntax E =
  | _HOLE
  | _SEQ(val*, E : E, instr*)
  | LABEL_(n : n, instr*, E : E)
}

;; 5-runtime-aux.watsup:7.1-7.73
def $inst_reftype(moduleinst : moduleinst, reftype : reftype) : reftype
  ;; 5-runtime-aux.watsup:9.1-10.22
  def $inst_reftype{mm : moduleinst, rt : reftype, dt* : deftype*}(mm, rt) = $subst_all_reftype(rt, (dt : deftype <: heaptype)*{dt})
    -- if (dt*{dt} = mm.TYPE_moduleinst)

;; 5-runtime-aux.watsup:19.1-19.52
def $default(valtype : valtype) : val?
  ;; 5-runtime-aux.watsup:21.1-21.34
  def $default(I32_valtype) = ?(CONST_val(I32_numtype, 0))
  ;; 5-runtime-aux.watsup:22.1-22.34
  def $default(I64_valtype) = ?(CONST_val(I64_numtype, 0))
  ;; 5-runtime-aux.watsup:23.1-23.43
  def $default(F32_valtype) = ?(CONST_val(F32_numtype, $fzero(32)))
  ;; 5-runtime-aux.watsup:24.1-24.43
  def $default(F64_valtype) = ?(CONST_val(F64_numtype, $fzero(64)))
  ;; 5-runtime-aux.watsup:25.1-25.37
  def $default(V128_valtype) = ?(VCONST_val(V128_vectype, 0))
  ;; 5-runtime-aux.watsup:26.1-26.42
  def $default{ht : heaptype}(REF_valtype(`NULL%?`(?(())), ht)) = ?(REF.NULL_val(ht))
  ;; 5-runtime-aux.watsup:27.1-27.31
  def $default{ht : heaptype}(REF_valtype(`NULL%?`(?()), ht)) = ?()

;; 5-runtime-aux.watsup:32.1-32.73
def $packval(storagetype : storagetype, val : val) : fieldval
  ;; 5-runtime-aux.watsup:35.1-35.27
  def $packval{t : valtype, val : val}((t : valtype <: storagetype), val) = (val : val <: fieldval)
  ;; 5-runtime-aux.watsup:36.1-36.65
  def $packval{pt : packtype, i : nat}((pt : packtype <: storagetype), CONST_val(I32_numtype, i)) = PACK_fieldval(pt, $wrap(32, $psize(pt), i))

;; 5-runtime-aux.watsup:33.1-33.83
def $unpackval(storagetype : storagetype, sx?, fieldval : fieldval) : val
  ;; 5-runtime-aux.watsup:38.1-38.34
  def $unpackval{t : valtype, val : val}((t : valtype <: storagetype), ?(), (val : val <: fieldval)) = val
  ;; 5-runtime-aux.watsup:39.1-39.74
  def $unpackval{pt : packtype, sx : sx, i : nat}((pt : packtype <: storagetype), ?(sx), PACK_fieldval(pt, i)) = CONST_val(I32_numtype, $ext($psize(pt), 32, sx, i))

;; 5-runtime-aux.watsup:44.1-44.62
rec {

;; 5-runtime-aux.watsup:44.1-44.62
def $funcsxv(externval*) : funcaddr*
  ;; 5-runtime-aux.watsup:49.1-49.24
  def $funcsxv([]) = []
  ;; 5-runtime-aux.watsup:50.1-50.47
  def $funcsxv{fa : funcaddr, xv* : externval*}([FUNC_externval(fa)] :: xv*{xv}) = [fa] :: $funcsxv(xv*{xv})
  ;; 5-runtime-aux.watsup:51.1-51.58
  def $funcsxv{externval : externval, xv* : externval*}([externval] :: xv*{xv}) = $funcsxv(xv*{xv})
    -- otherwise
}

;; 5-runtime-aux.watsup:45.1-45.64
rec {

;; 5-runtime-aux.watsup:45.1-45.64
def $globalsxv(externval*) : globaladdr*
  ;; 5-runtime-aux.watsup:53.1-53.26
  def $globalsxv([]) = []
  ;; 5-runtime-aux.watsup:54.1-54.53
  def $globalsxv{ga : globaladdr, xv* : externval*}([GLOBAL_externval(ga)] :: xv*{xv}) = [ga] :: $globalsxv(xv*{xv})
  ;; 5-runtime-aux.watsup:55.1-55.62
  def $globalsxv{externval : externval, xv* : externval*}([externval] :: xv*{xv}) = $globalsxv(xv*{xv})
    -- otherwise
}

;; 5-runtime-aux.watsup:46.1-46.63
rec {

;; 5-runtime-aux.watsup:46.1-46.63
def $tablesxv(externval*) : tableaddr*
  ;; 5-runtime-aux.watsup:57.1-57.25
  def $tablesxv([]) = []
  ;; 5-runtime-aux.watsup:58.1-58.50
  def $tablesxv{ta : tableaddr, xv* : externval*}([TABLE_externval(ta)] :: xv*{xv}) = [ta] :: $tablesxv(xv*{xv})
  ;; 5-runtime-aux.watsup:59.1-59.60
  def $tablesxv{externval : externval, xv* : externval*}([externval] :: xv*{xv}) = $tablesxv(xv*{xv})
    -- otherwise
}

;; 5-runtime-aux.watsup:47.1-47.61
rec {

;; 5-runtime-aux.watsup:47.1-47.61
def $memsxv(externval*) : memaddr*
  ;; 5-runtime-aux.watsup:61.1-61.23
  def $memsxv([]) = []
  ;; 5-runtime-aux.watsup:62.1-62.44
  def $memsxv{ma : memaddr, xv* : externval*}([MEM_externval(ma)] :: xv*{xv}) = [ma] :: $memsxv(xv*{xv})
  ;; 5-runtime-aux.watsup:63.1-63.56
  def $memsxv{externval : externval, xv* : externval*}([externval] :: xv*{xv}) = $memsxv(xv*{xv})
    -- otherwise
}

;; 5-runtime-aux.watsup:72.1-72.57
def $store(state : state) : store
  ;; 5-runtime-aux.watsup:75.1-75.23
  def $store{s : store, f : frame}(`%;%`(s, f)) = s

;; 5-runtime-aux.watsup:73.1-73.57
def $frame(state : state) : frame
  ;; 5-runtime-aux.watsup:76.1-76.23
  def $frame{s : store, f : frame}(`%;%`(s, f)) = f

;; 5-runtime-aux.watsup:79.1-79.63
def $funcaddr(state : state) : funcaddr*
  ;; 5-runtime-aux.watsup:80.1-80.38
  def $funcaddr{s : store, f : frame}(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 5-runtime-aux.watsup:82.1-82.56
def $funcinst(state : state) : funcinst*
  ;; 5-runtime-aux.watsup:92.1-92.31
  def $funcinst{s : store, f : frame}(`%;%`(s, f)) = s.FUNC_store

;; 5-runtime-aux.watsup:83.1-83.58
def $globalinst(state : state) : globalinst*
  ;; 5-runtime-aux.watsup:93.1-93.35
  def $globalinst{s : store, f : frame}(`%;%`(s, f)) = s.GLOBAL_store

;; 5-runtime-aux.watsup:84.1-84.57
def $tableinst(state : state) : tableinst*
  ;; 5-runtime-aux.watsup:94.1-94.33
  def $tableinst{s : store, f : frame}(`%;%`(s, f)) = s.TABLE_store

;; 5-runtime-aux.watsup:85.1-85.55
def $meminst(state : state) : meminst*
  ;; 5-runtime-aux.watsup:95.1-95.29
  def $meminst{s : store, f : frame}(`%;%`(s, f)) = s.MEM_store

;; 5-runtime-aux.watsup:86.1-86.56
def $eleminst(state : state) : eleminst*
  ;; 5-runtime-aux.watsup:96.1-96.31
  def $eleminst{s : store, f : frame}(`%;%`(s, f)) = s.ELEM_store

;; 5-runtime-aux.watsup:87.1-87.56
def $datainst(state : state) : datainst*
  ;; 5-runtime-aux.watsup:97.1-97.31
  def $datainst{s : store, f : frame}(`%;%`(s, f)) = s.DATA_store

;; 5-runtime-aux.watsup:88.1-88.58
def $structinst(state : state) : structinst*
  ;; 5-runtime-aux.watsup:98.1-98.35
  def $structinst{s : store, f : frame}(`%;%`(s, f)) = s.STRUCT_store

;; 5-runtime-aux.watsup:89.1-89.57
def $arrayinst(state : state) : arrayinst*
  ;; 5-runtime-aux.watsup:99.1-99.33
  def $arrayinst{s : store, f : frame}(`%;%`(s, f)) = s.ARRAY_store

;; 5-runtime-aux.watsup:90.1-90.58
def $moduleinst(state : state) : moduleinst
  ;; 5-runtime-aux.watsup:100.1-100.35
  def $moduleinst{s : store, f : frame}(`%;%`(s, f)) = f.MODULE_frame

;; 5-runtime-aux.watsup:102.1-102.66
def $type(state : state, typeidx : typeidx) : deftype
  ;; 5-runtime-aux.watsup:111.1-111.40
  def $type{s : store, f : frame, x : idx}(`%;%`(s, f), x) = f.MODULE_frame.TYPE_moduleinst[(x : uN(32) <: nat)]

;; 5-runtime-aux.watsup:103.1-103.67
def $func(state : state, funcidx : funcidx) : funcinst
  ;; 5-runtime-aux.watsup:112.1-112.48
  def $func{s : store, f : frame, x : idx}(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[(x : uN(32) <: nat)]]

;; 5-runtime-aux.watsup:104.1-104.69
def $global(state : state, globalidx : globalidx) : globalinst
  ;; 5-runtime-aux.watsup:113.1-113.54
  def $global{s : store, f : frame, x : idx}(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[(x : uN(32) <: nat)]]

;; 5-runtime-aux.watsup:105.1-105.68
def $table(state : state, tableidx : tableidx) : tableinst
  ;; 5-runtime-aux.watsup:114.1-114.51
  def $table{s : store, f : frame, x : idx}(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[(x : uN(32) <: nat)]]

;; 5-runtime-aux.watsup:106.1-106.66
def $mem(state : state, memidx : memidx) : meminst
  ;; 5-runtime-aux.watsup:115.1-115.45
  def $mem{s : store, f : frame, x : idx}(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[(x : uN(32) <: nat)]]

;; 5-runtime-aux.watsup:107.1-107.67
def $elem(state : state, tableidx : tableidx) : eleminst
  ;; 5-runtime-aux.watsup:116.1-116.48
  def $elem{s : store, f : frame, x : idx}(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[(x : uN(32) <: nat)]]

;; 5-runtime-aux.watsup:108.1-108.67
def $data(state : state, dataidx : dataidx) : datainst
  ;; 5-runtime-aux.watsup:117.1-117.48
  def $data{s : store, f : frame, x : idx}(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[(x : uN(32) <: nat)]]

;; 5-runtime-aux.watsup:109.1-109.68
def $local(state : state, localidx : localidx) : val?
  ;; 5-runtime-aux.watsup:118.1-118.35
  def $local{s : store, f : frame, x : idx}(`%;%`(s, f), x) = f.LOCAL_frame[(x : uN(32) <: nat)]

;; 5-runtime-aux.watsup:123.1-123.88
def $with_local(state : state, localidx : localidx, val : val) : state
  ;; 5-runtime-aux.watsup:134.1-134.52
  def $with_local{s : store, f : frame, x : idx, v : val}(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[(x : uN(32) <: nat)] = ?(v)])

;; 5-runtime-aux.watsup:124.1-124.95
def $with_global(state : state, globalidx : globalidx, val : val) : state
  ;; 5-runtime-aux.watsup:135.1-135.77
  def $with_global{s : store, f : frame, x : idx, v : val}(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[(x : uN(32) <: nat)]].VALUE_globalinst = v], f)

;; 5-runtime-aux.watsup:125.1-125.96
def $with_table(state : state, tableidx : tableidx, nat : nat, ref : ref) : state
  ;; 5-runtime-aux.watsup:136.1-136.79
  def $with_table{s : store, f : frame, x : idx, i : nat, r : ref}(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[(x : uN(32) <: nat)]].ELEM_tableinst[i] = r], f)

;; 5-runtime-aux.watsup:126.1-126.88
def $with_tableinst(state : state, tableidx : tableidx, tableinst : tableinst) : state
  ;; 5-runtime-aux.watsup:137.1-137.74
  def $with_tableinst{s : store, f : frame, x : idx, ti : tableinst}(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[(x : uN(32) <: nat)]] = ti], f)

;; 5-runtime-aux.watsup:127.1-127.98
def $with_mem(state : state, memidx : memidx, nat : nat, nat : nat, byte*) : state
  ;; 5-runtime-aux.watsup:138.1-138.82
  def $with_mem{s : store, f : frame, x : idx, i : nat, j : nat, b* : byte*}(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[(x : uN(32) <: nat)]].DATA_meminst[i : j] = b*{b}], f)

;; 5-runtime-aux.watsup:128.1-128.86
def $with_meminst(state : state, memidx : memidx, meminst : meminst) : state
  ;; 5-runtime-aux.watsup:139.1-139.68
  def $with_meminst{s : store, f : frame, x : idx, mi : meminst}(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[(x : uN(32) <: nat)]] = mi], f)

;; 5-runtime-aux.watsup:129.1-129.92
def $with_elem(state : state, elemidx : elemidx, ref*) : state
  ;; 5-runtime-aux.watsup:140.1-140.72
  def $with_elem{s : store, f : frame, x : idx, r* : ref*}(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[(x : uN(32) <: nat)]].ELEM_eleminst = r*{r}], f)

;; 5-runtime-aux.watsup:130.1-130.92
def $with_data(state : state, dataidx : dataidx, byte*) : state
  ;; 5-runtime-aux.watsup:141.1-141.72
  def $with_data{s : store, f : frame, x : idx, b* : byte*}(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[(x : uN(32) <: nat)]].DATA_datainst = b*{b}], f)

;; 5-runtime-aux.watsup:131.1-131.98
def $with_struct(state : state, structaddr : structaddr, nat : nat, fieldval : fieldval) : state
  ;; 5-runtime-aux.watsup:142.1-142.68
  def $with_struct{s : store, f : frame, a : addr, i : nat, fv : fieldval}(`%;%`(s, f), a, i, fv) = `%;%`(s[STRUCT_store[a].FIELD_structinst[i] = fv], f)

;; 5-runtime-aux.watsup:132.1-132.98
def $with_array(state : state, arrayaddr : arrayaddr, nat : nat, fieldval : fieldval) : state
  ;; 5-runtime-aux.watsup:143.1-143.66
  def $with_array{s : store, f : frame, a : addr, i : nat, fv : fieldval}(`%;%`(s, f), a, i, fv) = `%;%`(s[ARRAY_store[a].FIELD_arrayinst[i] = fv], f)

;; 5-runtime-aux.watsup:145.1-145.77
def $ext_structinst(state : state, structinst*) : state
  ;; 5-runtime-aux.watsup:148.1-148.57
  def $ext_structinst{s : store, f : frame, si* : structinst*}(`%;%`(s, f), si*{si}) = `%;%`(s[STRUCT_store =.. si*{si}], f)

;; 5-runtime-aux.watsup:146.1-146.76
def $ext_arrayinst(state : state, arrayinst*) : state
  ;; 5-runtime-aux.watsup:149.1-149.55
  def $ext_arrayinst{s : store, f : frame, ai* : arrayinst*}(`%;%`(s, f), ai*{ai}) = `%;%`(s[ARRAY_store =.. ai*{ai}], f)

;; 5-runtime-aux.watsup:154.1-154.62
def $growtable(tableinst : tableinst, nat : nat, ref : ref) : tableinst
  ;; 5-runtime-aux.watsup:157.1-161.19
  def $growtable{ti : tableinst, n : n, r : ref, ti' : tableinst, i : nat, j : nat, rt : reftype, r'* : ref*, i' : nat}(ti, n, r) = ti'
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%]`(i', j), rt), ELEM r'*{r'} :: r^n{}})
    -- if (i' <= j)

;; 5-runtime-aux.watsup:155.1-155.62
def $growmemory(meminst : meminst, nat : nat) : meminst
  ;; 5-runtime-aux.watsup:163.1-167.19
  def $growmemory{mi : meminst, n : n, mi' : meminst, i : nat, j : nat, b* : byte*, i' : nat}(mi, n) = mi'
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
syntax context =
{
  TYPE deftype*,
  REC subtype*,
  FUNC deftype*,
  GLOBAL globaltype*,
  TABLE tabletype*,
  MEM memtype*,
  ELEM elemtype*,
  DATA datatype*,
  LOCAL localtype*,
  LABEL resulttype*,
  RETURN resulttype?
}

;; 6-typing.watsup:26.1-26.86
rec {

;; 6-typing.watsup:26.1-26.86
def $with_locals(context : context, localidx*, localtype*) : context
  ;; 6-typing.watsup:28.1-28.34
  def $with_locals{C : context}(C, [], []) = C
  ;; 6-typing.watsup:29.1-29.85
  def $with_locals{C : context, x_1 : idx, x* : idx*, lt_1 : localtype, lt* : localtype*}(C, [x_1] :: x*{x}, [lt_1] :: lt*{lt}) = $with_locals(C[LOCAL_context[(x_1 : uN(32) <: nat)] = lt_1], x*{x}, lt*{lt})
}

;; 6-typing.watsup:33.1-33.65
rec {

;; 6-typing.watsup:33.1-33.65
def $clostypes(deftype*) : deftype*
  ;; 6-typing.watsup:37.1-37.26
  def $clostypes([]) = []
  ;; 6-typing.watsup:38.1-38.93
  def $clostypes{dt* : deftype*, dt_N : deftype, dt'* : deftype*}(dt*{dt} :: [dt_N]) = dt'*{dt'} :: [$subst_all_deftype(dt_N, (dt' : deftype <: heaptype)*{dt'})]
    -- if (dt'*{dt'} = $clostypes(dt*{dt}))
}

;; 6-typing.watsup:32.1-32.65
def $clostype(context : context, deftype : deftype) : deftype
  ;; 6-typing.watsup:35.1-35.84
  def $clostype{C : context, dt : deftype, dt'* : deftype*}(C, dt) = $subst_all_deftype(dt, (dt' : deftype <: heaptype)*{dt'})
    -- if (dt'*{dt'} = $clostypes(C.TYPE_context))

;; 6-typing.watsup:47.1-47.71
relation Numtype_ok: `%|-%:_OK`(context, numtype)
  ;; 6-typing.watsup:54.1-55.20
  rule _{C : context, numtype : numtype}:
    `%|-%:_OK`(C, numtype)

;; 6-typing.watsup:48.1-48.71
relation Vectype_ok: `%|-%:_OK`(context, vectype)
  ;; 6-typing.watsup:57.1-58.20
  rule _{C : context, vectype : vectype}:
    `%|-%:_OK`(C, vectype)

;; 6-typing.watsup:49.1-49.72
relation Heaptype_ok: `%|-%:_OK`(context, heaptype)
  ;; 6-typing.watsup:60.1-61.24
  rule abs{C : context, absheaptype : absheaptype}:
    `%|-%:_OK`(C, (absheaptype : absheaptype <: heaptype))

  ;; 6-typing.watsup:63.1-65.23
  rule typeidx{C : context, x : idx, dt : deftype}:
    `%|-%:_OK`(C, _IDX_heaptype(x))
    -- if (C.TYPE_context[(x : uN(32) <: nat)] = dt)

  ;; 6-typing.watsup:67.1-69.22
  rule rec{C : context, i : nat, st : subtype}:
    `%|-%:_OK`(C, REC_heaptype(i))
    -- if (C.REC_context[i] = st)

;; 6-typing.watsup:50.1-50.71
relation Reftype_ok: `%|-%:_OK`(context, reftype)
  ;; 6-typing.watsup:71.1-73.31
  rule _{C : context, nul : nul, ht : heaptype}:
    `%|-%:_OK`(C, REF_reftype(nul, ht))
    -- Heaptype_ok: `%|-%:_OK`(C, ht)

;; 6-typing.watsup:51.1-51.71
relation Valtype_ok: `%|-%:_OK`(context, valtype)
  ;; 6-typing.watsup:75.1-77.35
  rule num{C : context, numtype : numtype}:
    `%|-%:_OK`(C, (numtype : numtype <: valtype))
    -- Numtype_ok: `%|-%:_OK`(C, numtype)

  ;; 6-typing.watsup:79.1-81.35
  rule vec{C : context, vectype : vectype}:
    `%|-%:_OK`(C, (vectype : vectype <: valtype))
    -- Vectype_ok: `%|-%:_OK`(C, vectype)

  ;; 6-typing.watsup:83.1-85.35
  rule ref{C : context, reftype : reftype}:
    `%|-%:_OK`(C, (reftype : reftype <: valtype))
    -- Reftype_ok: `%|-%:_OK`(C, reftype)

  ;; 6-typing.watsup:87.1-88.16
  rule bot{C : context}:
    `%|-%:_OK`(C, BOT_valtype)

;; 6-typing.watsup:93.1-93.74
relation Resulttype_ok: `%|-%:_OK`(context, resulttype)
  ;; 6-typing.watsup:96.1-98.32
  rule _{C : context, t* : valtype*}:
    `%|-%:_OK`(C, t*{t})
    -- (Valtype_ok: `%|-%:_OK`(C, t))*{t}

;; 6-typing.watsup:94.1-94.73
relation Instrtype_ok: `%|-%:_OK`(context, instrtype)
  ;; 6-typing.watsup:100.1-104.27
  rule _{C : context, t_1* : valtype*, x* : idx*, t_2* : valtype*, lt* : localtype*}:
    `%|-%:_OK`(C, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))
    -- Resulttype_ok: `%|-%:_OK`(C, t_1*{t_1})
    -- Resulttype_ok: `%|-%:_OK`(C, t_2*{t_2})
    -- (if (C.LOCAL_context[(x : uN(32) <: nat)] = lt))*{lt x}

;; 6-typing.watsup:109.1-109.84
syntax oktypeidx =
  | OK(typeidx : typeidx)

;; 6-typing.watsup:110.1-110.87
syntax oktypeidxnat =
  | OK(typeidx : typeidx, nat)

;; 6-typing.watsup:112.1-112.74
relation Packtype_ok: `%|-%:_OK`(context, packtype)
  ;; 6-typing.watsup:128.1-129.21
  rule _{C : context, packtype : packtype}:
    `%|-%:_OK`(C, packtype)

;; 6-typing.watsup:114.1-114.77
relation Storagetype_ok: `%|-%:_OK`(context, storagetype)
  ;; 6-typing.watsup:131.1-133.35
  rule val{C : context, valtype : valtype}:
    `%|-%:_OK`(C, (valtype : valtype <: storagetype))
    -- Valtype_ok: `%|-%:_OK`(C, valtype)

  ;; 6-typing.watsup:135.1-137.37
  rule pack{C : context, packtype : packtype}:
    `%|-%:_OK`(C, (packtype : packtype <: storagetype))
    -- Packtype_ok: `%|-%:_OK`(C, packtype)

;; 6-typing.watsup:113.1-113.75
relation Fieldtype_ok: `%|-%:_OK`(context, fieldtype)
  ;; 6-typing.watsup:139.1-141.34
  rule _{C : context, mut : mut, zt : storagetype}:
    `%|-%:_OK`(C, `%%`(mut, zt))
    -- Storagetype_ok: `%|-%:_OK`(C, zt)

;; 6-typing.watsup:116.1-116.74
relation Functype_ok: `%|-%:_OK`(context, functype)
  ;; 6-typing.watsup:225.1-228.35
  rule _{C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:_OK`(C, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_ok: `%|-%:_OK`(C, t_1*{t_1})
    -- Resulttype_ok: `%|-%:_OK`(C, t_2*{t_2})

;; 6-typing.watsup:115.1-115.74
relation Comptype_ok: `%|-%:_OK`(context, comptype)
  ;; 6-typing.watsup:144.1-146.35
  rule struct{C : context, yt* : fieldtype*}:
    `%|-%:_OK`(C, STRUCT_comptype(yt*{yt}))
    -- (Fieldtype_ok: `%|-%:_OK`(C, yt))*{yt}

  ;; 6-typing.watsup:148.1-150.32
  rule array{C : context, yt : fieldtype}:
    `%|-%:_OK`(C, ARRAY_comptype(yt))
    -- Fieldtype_ok: `%|-%:_OK`(C, yt)

  ;; 6-typing.watsup:152.1-154.31
  rule func{C : context, ft : functype}:
    `%|-%:_OK`(C, FUNC_comptype(ft))
    -- Functype_ok: `%|-%:_OK`(C, ft)

;; 6-typing.watsup:391.1-391.89
relation Packtype_sub: `%|-%<:%`(context, packtype, packtype)
  ;; 6-typing.watsup:398.1-399.28
  rule _{C : context, packtype : packtype}:
    `%|-%<:%`(C, packtype, packtype)

;; 6-typing.watsup:269.1-269.78
relation Numtype_sub: `%|-%<:%`(context, numtype, numtype)
  ;; 6-typing.watsup:275.1-276.26
  rule _{C : context, numtype : numtype}:
    `%|-%<:%`(C, numtype, numtype)

;; 6-typing.watsup:125.1-271.79
rec {

;; 6-typing.watsup:125.1-125.75
relation Deftype_sub: `%|-%<:%`(context, deftype, deftype)
  ;; 6-typing.watsup:434.1-436.58
  rule refl{C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- if ($clostype(C, deftype_1) = $clostype(C, deftype_2))

  ;; 6-typing.watsup:438.1-441.40
  rule super{C : context, deftype_1 : deftype, deftype_2 : deftype, fin : fin, ht_1* : heaptype*, ht : heaptype, ht_2* : heaptype*, ct : comptype}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- if ($unrolldt(deftype_1) = SUBD_subtype(fin, ht_1*{ht_1} :: [ht] :: ht_2*{ht_2}, ct))
    -- Heaptype_sub: `%|-%<:%`(C, ht, (deftype_2 : deftype <: heaptype))

;; 6-typing.watsup:271.1-271.79
relation Heaptype_sub: `%|-%<:%`(context, heaptype, heaptype)
  ;; 6-typing.watsup:282.1-283.28
  rule refl{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, heaptype, heaptype)

  ;; 6-typing.watsup:285.1-289.48
  rule trans{C : context, heaptype_1 : heaptype, heaptype_2 : heaptype, heaptype' : heaptype}:
    `%|-%<:%`(C, heaptype_1, heaptype_2)
    -- Heaptype_ok: `%|-%:_OK`(C, heaptype')
    -- Heaptype_sub: `%|-%<:%`(C, heaptype_1, heaptype')
    -- Heaptype_sub: `%|-%<:%`(C, heaptype', heaptype_2)

  ;; 6-typing.watsup:291.1-292.17
  rule eq-any{C : context}:
    `%|-%<:%`(C, EQ_heaptype, ANY_heaptype)

  ;; 6-typing.watsup:294.1-295.17
  rule i31-eq{C : context}:
    `%|-%<:%`(C, I31_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:297.1-298.20
  rule struct-eq{C : context}:
    `%|-%<:%`(C, STRUCT_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:300.1-301.19
  rule array-eq{C : context}:
    `%|-%<:%`(C, ARRAY_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:303.1-305.35
  rule struct{C : context, deftype : deftype, yt* : fieldtype*}:
    `%|-%<:%`(C, (deftype : deftype <: heaptype), STRUCT_heaptype)
    -- Expand: `%~~%`(deftype, STRUCT_comptype(yt*{yt}))

  ;; 6-typing.watsup:307.1-309.33
  rule array{C : context, deftype : deftype, yt : fieldtype}:
    `%|-%<:%`(C, (deftype : deftype <: heaptype), ARRAY_heaptype)
    -- Expand: `%~~%`(deftype, ARRAY_comptype(yt))

  ;; 6-typing.watsup:311.1-313.32
  rule func{C : context, deftype : deftype, ft : functype}:
    `%|-%<:%`(C, (deftype : deftype <: heaptype), FUNC_heaptype)
    -- Expand: `%~~%`(deftype, FUNC_comptype(ft))

  ;; 6-typing.watsup:315.1-317.46
  rule def{C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, (deftype_1 : deftype <: heaptype), (deftype_2 : deftype <: heaptype))
    -- Deftype_sub: `%|-%<:%`(C, deftype_1, deftype_2)

  ;; 6-typing.watsup:319.1-321.52
  rule typeidx-l{C : context, typeidx : typeidx, heaptype : heaptype}:
    `%|-%<:%`(C, _IDX_heaptype(typeidx), heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, (C.TYPE_context[(typeidx : uN(32) <: nat)] : deftype <: heaptype), heaptype)

  ;; 6-typing.watsup:323.1-325.52
  rule typeidx-r{C : context, heaptype : heaptype, typeidx : typeidx}:
    `%|-%<:%`(C, heaptype, _IDX_heaptype(typeidx))
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, (C.TYPE_context[(typeidx : uN(32) <: nat)] : deftype <: heaptype))

  ;; 6-typing.watsup:327.1-329.48
  rule rec{C : context, i : nat, ht : heaptype, fin : fin, ht_1* : heaptype*, ht_2* : heaptype*, ct : comptype}:
    `%|-%<:%`(C, REC_heaptype(i), ht)
    -- if (C.REC_context[i] = SUBD_subtype(fin, ht_1*{ht_1} :: [ht] :: ht_2*{ht_2}, ct))

  ;; 6-typing.watsup:331.1-333.40
  rule none{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NONE_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, ANY_heaptype)

  ;; 6-typing.watsup:335.1-337.41
  rule nofunc{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOFUNC_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, FUNC_heaptype)

  ;; 6-typing.watsup:339.1-341.43
  rule noextern{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOEXTERN_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, EXTERN_heaptype)

  ;; 6-typing.watsup:343.1-344.23
  rule bot{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, BOT_heaptype, heaptype)
}

;; 6-typing.watsup:272.1-272.78
relation Reftype_sub: `%|-%<:%`(context, reftype, reftype)
  ;; 6-typing.watsup:347.1-349.37
  rule nonnull{C : context, ht_1 : heaptype, ht_2 : heaptype}:
    `%|-%<:%`(C, REF_reftype(`NULL%?`(?()), ht_1), REF_reftype(`NULL%?`(?()), ht_2))
    -- Heaptype_sub: `%|-%<:%`(C, ht_1, ht_2)

  ;; 6-typing.watsup:351.1-353.37
  rule null{C : context, ht_1 : heaptype, ht_2 : heaptype}:
    `%|-%<:%`(C, REF_reftype(`NULL%?`(()?{}), ht_1), REF_reftype(`NULL%?`(?(())), ht_2))
    -- Heaptype_sub: `%|-%<:%`(C, ht_1, ht_2)

;; 6-typing.watsup:270.1-270.78
relation Vectype_sub: `%|-%<:%`(context, vectype, vectype)
  ;; 6-typing.watsup:278.1-279.26
  rule _{C : context, vectype : vectype}:
    `%|-%<:%`(C, vectype, vectype)

;; 6-typing.watsup:273.1-273.78
relation Valtype_sub: `%|-%<:%`(context, valtype, valtype)
  ;; 6-typing.watsup:356.1-358.46
  rule num{C : context, numtype_1 : numtype, numtype_2 : numtype}:
    `%|-%<:%`(C, (numtype_1 : numtype <: valtype), (numtype_2 : numtype <: valtype))
    -- Numtype_sub: `%|-%<:%`(C, numtype_1, numtype_2)

  ;; 6-typing.watsup:360.1-362.46
  rule vec{C : context, vectype_1 : vectype, vectype_2 : vectype}:
    `%|-%<:%`(C, (vectype_1 : vectype <: valtype), (vectype_2 : vectype <: valtype))
    -- Vectype_sub: `%|-%<:%`(C, vectype_1, vectype_2)

  ;; 6-typing.watsup:364.1-366.46
  rule ref{C : context, reftype_1 : reftype, reftype_2 : reftype}:
    `%|-%<:%`(C, (reftype_1 : reftype <: valtype), (reftype_2 : reftype <: valtype))
    -- Reftype_sub: `%|-%<:%`(C, reftype_1, reftype_2)

  ;; 6-typing.watsup:368.1-369.22
  rule bot{C : context, valtype : valtype}:
    `%|-%<:%`(C, BOT_valtype, valtype)

;; 6-typing.watsup:392.1-392.92
relation Storagetype_sub: `%|-%<:%`(context, storagetype, storagetype)
  ;; 6-typing.watsup:402.1-404.46
  rule val{C : context, valtype_1 : valtype, valtype_2 : valtype}:
    `%|-%<:%`(C, (valtype_1 : valtype <: storagetype), (valtype_2 : valtype <: storagetype))
    -- Valtype_sub: `%|-%<:%`(C, valtype_1, valtype_2)

  ;; 6-typing.watsup:406.1-408.49
  rule pack{C : context, packtype_1 : packtype, packtype_2 : packtype}:
    `%|-%<:%`(C, (packtype_1 : packtype <: storagetype), (packtype_2 : packtype <: storagetype))
    -- Packtype_sub: `%|-%<:%`(C, packtype_1, packtype_2)

;; 6-typing.watsup:393.1-393.90
relation Fieldtype_sub: `%|-%<:%`(context, fieldtype, fieldtype)
  ;; 6-typing.watsup:411.1-413.40
  rule const{C : context, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?()), zt_1), `%%`(`MUT%?`(?()), zt_2))
    -- Storagetype_sub: `%|-%<:%`(C, zt_1, zt_2)

  ;; 6-typing.watsup:415.1-418.40
  rule var{C : context, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?(())), zt_1), `%%`(`MUT%?`(?(())), zt_2))
    -- Storagetype_sub: `%|-%<:%`(C, zt_1, zt_2)
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

;; 6-typing.watsup:395.1-395.89
relation Functype_sub: `%|-%<:%`(context, functype, functype)
  ;; 6-typing.watsup:458.1-459.16
  rule _{C : context, ft : functype}:
    `%|-%<:%`(C, ft, ft)

;; 6-typing.watsup:124.1-124.76
relation Comptype_sub: `%|-%<:%`(context, comptype, comptype)
  ;; 6-typing.watsup:421.1-423.41
  rule struct{C : context, yt_1* : fieldtype*, yt'_1 : fieldtype, yt_2* : fieldtype*}:
    `%|-%<:%`(C, STRUCT_comptype(yt_1*{yt_1} :: [yt'_1]), STRUCT_comptype(yt_2*{yt_2}))
    -- (Fieldtype_sub: `%|-%<:%`(C, yt_1, yt_2))*{yt_1 yt_2}

  ;; 6-typing.watsup:425.1-427.38
  rule array{C : context, yt_1 : fieldtype, yt_2 : fieldtype}:
    `%|-%<:%`(C, ARRAY_comptype(yt_1), ARRAY_comptype(yt_2))
    -- Fieldtype_sub: `%|-%<:%`(C, yt_1, yt_2)

  ;; 6-typing.watsup:429.1-431.37
  rule func{C : context, ft_1 : functype, ft_2 : functype}:
    `%|-%<:%`(C, FUNC_comptype(ft_1), FUNC_comptype(ft_2))
    -- Functype_sub: `%|-%<:%`(C, ft_1, ft_2)

;; 6-typing.watsup:117.1-117.73
relation Subtype_ok: `%|-%:%`(context, subtype, oktypeidx)
  ;; 6-typing.watsup:157.1-163.37
  rule _{C : context, fin : fin, y* : idx*, ct : comptype, x : idx, y'** : idx**, ct'* : comptype*}:
    `%|-%:%`(C, SUB_subtype(fin, y*{y}, ct), OK_oktypeidx(x))
    -- if (|y*{y}| <= 1)
    -- (if ((y : uN(32) <: nat) < (x : uN(32) <: nat)))*{y}
    -- (if ($unrolldt(C.TYPE_context[(y : uN(32) <: nat)]) = SUB_subtype(`FINAL%?`(?()), y'*{y'}, ct')))*{ct' y y'}
    -- Comptype_ok: `%|-%:_OK`(C, ct)
    -- (Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}

;; 6-typing.watsup:165.1-165.65
def $before(heaptype : heaptype, typeidx : typeidx, nat : nat) : bool
  ;; 6-typing.watsup:166.1-166.34
  def $before{deftype : deftype, x : idx, i : nat}((deftype : deftype <: heaptype), x, i) = true
  ;; 6-typing.watsup:167.1-167.46
  def $before{typeidx : typeidx, x : idx, i : nat}(_IDX_heaptype(typeidx), x, i) = ((typeidx : uN(32) <: nat) < (x : uN(32) <: nat))
  ;; 6-typing.watsup:168.1-168.33
  def $before{j : nat, x : idx, i : nat}(REC_heaptype(j), x, i) = (j < i)

;; 6-typing.watsup:170.1-170.69
def $unrollht(context : context, heaptype : heaptype) : subtype
  ;; 6-typing.watsup:171.1-171.47
  def $unrollht{C : context, deftype : deftype}(C, (deftype : deftype <: heaptype)) = $unrolldt(deftype)
  ;; 6-typing.watsup:172.1-172.60
  def $unrollht{C : context, typeidx : typeidx}(C, _IDX_heaptype(typeidx)) = $unrolldt(C.TYPE_context[(typeidx : uN(32) <: nat)])
  ;; 6-typing.watsup:173.1-173.35
  def $unrollht{C : context, i : nat}(C, REC_heaptype(i)) = C.REC_context[i]

;; 6-typing.watsup:119.1-119.76
relation Subtype_ok2: `%|-%:%`(context, subtype, oktypeidxnat)
  ;; 6-typing.watsup:175.1-181.37
  rule _{C : context, fin : fin, ht* : heaptype*, ct : comptype, x : idx, i : nat, ht'** : heaptype**, ct'* : comptype*}:
    `%|-%:%`(C, SUBD_subtype(fin, ht*{ht}, ct), OK_oktypeidxnat(x, i))
    -- if (|ht*{ht}| <= 1)
    -- (if $before(ht, x, i))*{ht}
    -- (if ($unrollht(C, ht) = SUBD_subtype(`FINAL%?`(?()), ht'*{ht'}, ct')))*{ct' ht ht'}
    -- Comptype_ok: `%|-%:_OK`(C, ct)
    -- (Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}

;; 6-typing.watsup:120.1-120.76
rec {

;; 6-typing.watsup:120.1-120.76
relation Rectype_ok2: `%|-%:%`(context, rectype, oktypeidxnat)
  ;; 6-typing.watsup:196.1-197.24
  rule empty{C : context, x : idx, i : nat}:
    `%|-%:%`(C, REC_rectype([]), OK_oktypeidxnat(x, i))

  ;; 6-typing.watsup:199.1-202.50
  rule cons{C : context, st_1 : subtype, st* : subtype*, x : idx, i : nat}:
    `%|-%:%`(C, REC_rectype([st_1] :: st*{st}), OK_oktypeidxnat(x, i))
    -- Subtype_ok2: `%|-%:%`(C, st_1, OK_oktypeidxnat(x, i))
    -- Rectype_ok2: `%|-%:%`(C, REC_rectype(st*{st}), OK_oktypeidxnat(((x : uN(32) <: nat) + 1), (i + 1)))
}

;; 6-typing.watsup:118.1-118.74
rec {

;; 6-typing.watsup:118.1-118.74
relation Rectype_ok: `%|-%:%`(context, rectype, oktypeidx)
  ;; 6-typing.watsup:184.1-185.23
  rule empty{C : context, x : idx}:
    `%|-%:%`(C, REC_rectype([]), OK_oktypeidx(x))

  ;; 6-typing.watsup:187.1-190.43
  rule cons{C : context, st_1 : subtype, st* : subtype*, x : idx}:
    `%|-%:%`(C, REC_rectype([st_1] :: st*{st}), OK_oktypeidx(x))
    -- Subtype_ok: `%|-%:%`(C, st_1, OK_oktypeidx(x))
    -- Rectype_ok: `%|-%:%`(C, REC_rectype(st*{st}), OK_oktypeidx(((x : uN(32) <: nat) + 1)))

  ;; 6-typing.watsup:192.1-194.49
  rule rec2{C : context, st* : subtype*, x : idx}:
    `%|-%:%`(C, REC_rectype(st*{st}), OK_oktypeidx(x))
    -- Rectype_ok2: `%|-%:%`(C ++ {TYPE [], REC st*{st}, FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, REC_rectype(st*{st}), OK_oktypeidxnat(x, 0))
}

;; 6-typing.watsup:121.1-121.73
relation Deftype_ok: `%|-%:_OK`(context, deftype)
  ;; 6-typing.watsup:205.1-209.14
  rule _{C : context, qt : rectype, i : nat, x : idx, st^n : subtype^n, n : n}:
    `%|-%:_OK`(C, DEF_deftype(qt, i))
    -- Rectype_ok: `%|-%:%`(C, qt, OK_oktypeidx(x))
    -- if (qt = REC_rectype(st^n{st}))
    -- if (i < n)

;; 6-typing.watsup:214.1-214.74
relation Limits_ok: `%|-%:%`(context, limits, nat)
  ;; 6-typing.watsup:221.1-223.24
  rule _{C : context, n_1 : n, n_2 : n, k : nat}:
    `%|-%:%`(C, `[%..%]`(n_1, n_2), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 6-typing.watsup:215.1-215.74
relation Globaltype_ok: `%|-%:_OK`(context, globaltype)
  ;; 6-typing.watsup:230.1-232.29
  rule _{C : context, mut : mut, t : valtype}:
    `%|-%:_OK`(C, `%%`(mut, t))
    -- Valtype_ok: `%|-%:_OK`(C, t)

;; 6-typing.watsup:216.1-216.73
relation Tabletype_ok: `%|-%:_OK`(context, tabletype)
  ;; 6-typing.watsup:234.1-237.30
  rule _{C : context, lim : limits, rt : reftype}:
    `%|-%:_OK`(C, `%%`(lim, rt))
    -- Limits_ok: `%|-%:%`(C, lim, ((2 ^ 32) - 1))
    -- Reftype_ok: `%|-%:_OK`(C, rt)

;; 6-typing.watsup:217.1-217.71
relation Memtype_ok: `%|-%:_OK`(context, memtype)
  ;; 6-typing.watsup:239.1-241.35
  rule _{C : context, lim : limits}:
    `%|-%:_OK`(C, `%I8`(lim))
    -- Limits_ok: `%|-%:%`(C, lim, (2 ^ 16))

;; 6-typing.watsup:218.1-218.74
relation Externtype_ok: `%|-%:_OK`(context, externtype)
  ;; 6-typing.watsup:244.1-247.27
  rule func{C : context, dt : deftype, ft : functype}:
    `%|-%:_OK`(C, FUNC_externtype(dt))
    -- Deftype_ok: `%|-%:_OK`(C, dt)
    -- Expand: `%~~%`(dt, FUNC_comptype(ft))

  ;; 6-typing.watsup:249.1-251.33
  rule global{C : context, gt : globaltype}:
    `%|-%:_OK`(C, GLOBAL_externtype(gt))
    -- Globaltype_ok: `%|-%:_OK`(C, gt)

  ;; 6-typing.watsup:253.1-255.32
  rule table{C : context, tt : tabletype}:
    `%|-%:_OK`(C, TABLE_externtype(tt))
    -- Tabletype_ok: `%|-%:_OK`(C, tt)

  ;; 6-typing.watsup:257.1-259.30
  rule mem{C : context, mt : memtype}:
    `%|-%:_OK`(C, MEM_externtype(mt))
    -- Memtype_ok: `%|-%:_OK`(C, mt)

;; 6-typing.watsup:374.1-374.81
relation Resulttype_sub: `%|-%*_<:%*`(context, valtype*, valtype*)
  ;; 6-typing.watsup:377.1-379.37
  rule _{C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*_<:%*`(C, t_1*{t_1}, t_2*{t_2})
    -- (Valtype_sub: `%|-%<:%`(C, t_1, t_2))*{t_1 t_2}

;; 6-typing.watsup:375.1-375.80
relation Instrtype_sub: `%|-%<:%`(context, instrtype, instrtype)
  ;; 6-typing.watsup:381.1-386.30
  rule _{C : context, t_11* : valtype*, x_1* : idx*, t_12* : valtype*, t_21* : valtype*, x_2* : idx*, t_22* : valtype*, x* : idx*, t* : valtype*}:
    `%|-%<:%`(C, `%->%*%`(t_11*{t_11}, x_1*{x_1}, t_12*{t_12}), `%->%*%`(t_21*{t_21}, x_2*{x_2}, t_22*{t_22}))
    -- Resulttype_sub: `%|-%*_<:%*`(C, t_21*{t_21}, t_11*{t_11})
    -- Resulttype_sub: `%|-%*_<:%*`(C, t_12*{t_12}, t_22*{t_22})
    -- if (x*{x} = $setminus(x_2*{x_2}, x_1*{x_1}))
    -- (if (C.LOCAL_context[(x : uN(32) <: nat)] = `%%`(SET_init, t)))*{t x}

;; 6-typing.watsup:446.1-446.83
relation Limits_sub: `%|-%<:%`(context, limits, limits)
  ;; 6-typing.watsup:453.1-456.21
  rule _{C : context, n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `%|-%<:%`(C, `[%..%]`(n_11, n_12), `[%..%]`(n_21, n_22))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 6-typing.watsup:447.1-447.83
relation Globaltype_sub: `%|-%<:%`(context, globaltype, globaltype)
  ;; 6-typing.watsup:461.1-463.34
  rule const{C : context, t_1 : valtype, t_2 : valtype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?()), t_1), `%%`(`MUT%?`(?()), t_2))
    -- Valtype_sub: `%|-%<:%`(C, t_1, t_2)

  ;; 6-typing.watsup:465.1-468.34
  rule var{C : context, t_1 : valtype, t_2 : valtype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?(())), t_1), `%%`(`MUT%?`(?(())), t_2))
    -- Valtype_sub: `%|-%<:%`(C, t_1, t_2)
    -- Valtype_sub: `%|-%<:%`(C, t_2, t_1)

;; 6-typing.watsup:448.1-448.82
relation Tabletype_sub: `%|-%<:%`(context, tabletype, tabletype)
  ;; 6-typing.watsup:470.1-474.36
  rule _{C : context, lim_1 : limits, rt_1 : reftype, lim_2 : limits, rt_2 : reftype}:
    `%|-%<:%`(C, `%%`(lim_1, rt_1), `%%`(lim_2, rt_2))
    -- Limits_sub: `%|-%<:%`(C, lim_1, lim_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_1, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

;; 6-typing.watsup:449.1-449.80
relation Memtype_sub: `%|-%<:%`(context, memtype, memtype)
  ;; 6-typing.watsup:476.1-478.37
  rule _{C : context, lim_1 : limits, lim_2 : limits}:
    `%|-%<:%`(C, `%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `%|-%<:%`(C, lim_1, lim_2)

;; 6-typing.watsup:450.1-450.83
relation Externtype_sub: `%|-%<:%`(context, externtype, externtype)
  ;; 6-typing.watsup:481.1-483.36
  rule func{C : context, dt_1 : deftype, dt_2 : deftype}:
    `%|-%<:%`(C, FUNC_externtype(dt_1), FUNC_externtype(dt_2))
    -- Deftype_sub: `%|-%<:%`(C, dt_1, dt_2)

  ;; 6-typing.watsup:485.1-487.39
  rule global{C : context, gt_1 : globaltype, gt_2 : globaltype}:
    `%|-%<:%`(C, GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `%|-%<:%`(C, gt_1, gt_2)

  ;; 6-typing.watsup:489.1-491.38
  rule table{C : context, tt_1 : tabletype, tt_2 : tabletype}:
    `%|-%<:%`(C, TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `%|-%<:%`(C, tt_1, tt_2)

  ;; 6-typing.watsup:493.1-495.36
  rule mem{C : context, mt_1 : memtype, mt_2 : memtype}:
    `%|-%<:%`(C, MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `%|-%<:%`(C, mt_1, mt_2)

;; 6-typing.watsup:565.1-565.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 6-typing.watsup:567.1-568.32
  rule void{C : context}:
    `%|-%:%`(C, _RESULT_blocktype(?()), `%->%`([], []))

  ;; 6-typing.watsup:570.1-571.28
  rule result{C : context, t : valtype}:
    `%|-%:%`(C, _RESULT_blocktype(?(t)), `%->%`([], [t]))

  ;; 6-typing.watsup:573.1-575.34
  rule typeidx{C : context, x : idx, ft : functype}:
    `%|-%:%`(C, _IDX_blocktype(x), ft)
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], FUNC_comptype(ft))

;; 6-typing.watsup:503.1-505.74
rec {

;; 6-typing.watsup:503.1-503.67
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 6-typing.watsup:544.1-545.34
  rule unreachable{C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 6-typing.watsup:547.1-548.24
  rule nop{C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 6-typing.watsup:550.1-551.23
  rule drop{C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 6-typing.watsup:554.1-555.31
  rule select-expl{C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?([t])), `%->%`([t t I32_valtype], [t]))

  ;; 6-typing.watsup:557.1-560.37
  rule select-impl{C : context, t : valtype, t' : valtype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `%|-%<:%`(C, t, t')
    -- if ((t' = (numtype : numtype <: valtype)) \/ (t' = (vectype : vectype <: valtype)))

  ;; 6-typing.watsup:578.1-581.61
  rule block{C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*_:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr*{instr}, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))

  ;; 6-typing.watsup:583.1-586.61
  rule loop{C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*_:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1*{t_1}], RETURN ?()}, instr*{instr}, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))

  ;; 6-typing.watsup:588.1-592.65
  rule if{C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*, x_1* : idx*, x_2* : idx*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*_:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%*%`(t_1*{t_1}, x_1*{x_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*_:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%*%`(t_1*{t_1}, x_2*{x_2}, t_2*{t_2}))

  ;; 6-typing.watsup:597.1-599.24
  rule br{C : context, l : labelidx, t_1* : valtype*, t* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[(l : uN(32) <: nat)] = t*{t})

  ;; 6-typing.watsup:601.1-603.24
  rule br_if{C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[(l : uN(32) <: nat)] = t*{t})

  ;; 6-typing.watsup:605.1-608.44
  rule br_table{C : context, l* : labelidx*, l' : labelidx, t_1* : valtype*, t* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `%|-%*_<:%*`(C, t*{t}, C.LABEL_context[(l : uN(32) <: nat)]))*{l}
    -- Resulttype_sub: `%|-%*_<:%*`(C, t*{t}, C.LABEL_context[(l' : uN(32) <: nat)])

  ;; 6-typing.watsup:610.1-613.31
  rule br_on_null{C : context, l : labelidx, t* : valtype*, ht : heaptype}:
    `%|-%:%`(C, BR_ON_NULL_instr(l), `%->%`(t*{t} :: [REF_valtype(`NULL%?`(?(())), ht)], t*{t} :: [REF_valtype(`NULL%?`(?()), ht)]))
    -- if (C.LABEL_context[(l : uN(32) <: nat)] = t*{t})
    -- Heaptype_ok: `%|-%:_OK`(C, ht)

  ;; 6-typing.watsup:615.1-618.31
  rule br_on_non_null{C : context, l : labelidx, t* : valtype*, ht : heaptype}:
    `%|-%:%`(C, BR_ON_NON_NULL_instr(l), `%->%`(t*{t} :: [REF_valtype(`NULL%?`(?(())), ht)], t*{t}))
    -- if (C.LABEL_context[(l : uN(32) <: nat)] = t*{t} :: [REF_valtype(`NULL%?`(?()), ht)])
    -- Heaptype_ok: `%|-%:_OK`(C, ht)

  ;; 6-typing.watsup:620.1-626.34
  rule br_on_cast{C : context, l : labelidx, rt_1 : reftype, rt_2 : reftype, t* : valtype*, rt : reftype}:
    `%|-%:%`(C, BR_ON_CAST_instr(l, rt_1, rt_2), `%->%`(t*{t} :: [(rt_1 : reftype <: valtype)], t*{t} :: [($diffrt(rt_1, rt_2) : reftype <: valtype)]))
    -- if (C.LABEL_context[(l : uN(32) <: nat)] = t*{t} :: [(rt : reftype <: valtype)])
    -- Reftype_ok: `%|-%:_OK`(C, rt_1)
    -- Reftype_ok: `%|-%:_OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt)

  ;; 6-typing.watsup:628.1-634.49
  rule br_on_cast_fail{C : context, l : labelidx, rt_1 : reftype, rt_2 : reftype, t* : valtype*, rt : reftype}:
    `%|-%:%`(C, BR_ON_CAST_FAIL_instr(l, rt_1, rt_2), `%->%`(t*{t} :: [(rt_1 : reftype <: valtype)], t*{t} :: [(rt_2 : reftype <: valtype)]))
    -- if (C.LABEL_context[(l : uN(32) <: nat)] = t*{t} :: [(rt : reftype <: valtype)])
    -- Reftype_ok: `%|-%:_OK`(C, rt_1)
    -- Reftype_ok: `%|-%:_OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, $diffrt(rt_1, rt_2), rt)

  ;; 6-typing.watsup:639.1-641.24
  rule return{C : context, t_1* : valtype*, t* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 6-typing.watsup:643.1-645.46
  rule call{C : context, x : idx, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Expand: `%~~%`(C.FUNC_context[(x : uN(32) <: nat)], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:647.1-649.46
  rule call_ref{C : context, x : idx, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, CALL_REF_instr(?(x)), `%->%`(t_1*{t_1} :: [REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype))], t_2*{t_2}))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:651.1-655.46
  rule call_indirect{C : context, x : idx, y : idx, t_1* : valtype*, t_2* : valtype*, lim : limits, rt : reftype}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, y), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[(x : uN(32) <: nat)] = `%%`(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPE_context[(y : uN(32) <: nat)], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:657.1-661.40
  rule return_call{C : context, x : idx, t_3* : valtype*, t_1* : valtype*, t_4* : valtype*, t_2* : valtype*, t'_2* : valtype*}:
    `%|-%:%`(C, RETURN_CALL_instr(x), `%->%`(t_3*{t_3} :: t_1*{t_1}, t_4*{t_4}))
    -- Expand: `%~~%`(C.FUNC_context[(x : uN(32) <: nat)], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*_<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:663.1-667.40
  rule return_call_ref{C : context, x : idx, t_3* : valtype*, t_1* : valtype*, t_4* : valtype*, t_2* : valtype*, t'_2* : valtype*}:
    `%|-%:%`(C, RETURN_CALL_REF_instr(?(x)), `%->%`(t_3*{t_3} :: t_1*{t_1} :: [REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype))], t_4*{t_4}))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*_<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:669.1-675.40
  rule return_call_indirect{C : context, x : idx, y : idx, t_3* : valtype*, t_1* : valtype*, t_4* : valtype*, lim : limits, rt : reftype, t_2* : valtype*, t'_2* : valtype*}:
    `%|-%:%`(C, RETURN_CALL_INDIRECT_instr(x, y), `%->%`(t_3*{t_3} :: t_1*{t_1} :: [I32_valtype], t_4*{t_4}))
    -- if (C.TABLE_context[(x : uN(32) <: nat)] = `%%`(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPE_context[(y : uN(32) <: nat)], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*_<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:680.1-681.33
  rule const{C : context, nt : numtype, c_nt : num_(nt)}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [(nt : numtype <: valtype)]))

  ;; 6-typing.watsup:683.1-684.34
  rule unop{C : context, nt : numtype, unop_nt : unop_(nt)}:
    `%|-%:%`(C, UNOP_instr(nt, unop_nt), `%->%`([(nt : numtype <: valtype)], [(nt : numtype <: valtype)]))

  ;; 6-typing.watsup:686.1-687.39
  rule binop{C : context, nt : numtype, binop_nt : binop_(nt)}:
    `%|-%:%`(C, BINOP_instr(nt, binop_nt), `%->%`([(nt : numtype <: valtype) (nt : numtype <: valtype)], [(nt : numtype <: valtype)]))

  ;; 6-typing.watsup:689.1-690.39
  rule testop{C : context, nt : numtype, testop_nt : testop_(nt)}:
    `%|-%:%`(C, TESTOP_instr(nt, testop_nt), `%->%`([(nt : numtype <: valtype)], [I32_valtype]))

  ;; 6-typing.watsup:692.1-693.40
  rule relop{C : context, nt : numtype, relop_nt : relop_(nt)}:
    `%|-%:%`(C, RELOP_instr(nt, relop_nt), `%->%`([(nt : numtype <: valtype) (nt : numtype <: valtype)], [I32_valtype]))

  ;; 6-typing.watsup:696.1-699.34
  rule reinterpret{C : context, nt_1 : numtype, nt_2 : numtype}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([(nt_2 : numtype <: valtype)], [(nt_1 : numtype <: valtype)]))
    -- if (nt_1 =/= nt_2)
    -- if ($size((nt_1 : numtype <: valtype)) = $size((nt_2 : numtype <: valtype)))

  ;; 6-typing.watsup:701.1-704.50
  rule convert-i{C : context, inn_1 : inn, inn_2 : inn, sx? : sx?}:
    `%|-%:%`(C, CVTOP_instr((inn_1 : inn <: numtype), CONVERT_cvtop, (inn_2 : inn <: numtype), sx?{sx}), `%->%`([(inn_2 : inn <: valtype)], [(inn_1 : inn <: valtype)]))
    -- if (inn_1 =/= inn_2)
    -- if ((sx?{sx} = ?()) <=> ($size((inn_1 : inn <: valtype)) > $size((inn_2 : inn <: valtype))))

  ;; 6-typing.watsup:706.1-708.24
  rule convert-f{C : context, fnn_1 : fnn, fnn_2 : fnn}:
    `%|-%:%`(C, CVTOP_instr((fnn_1 : fnn <: numtype), CONVERT_cvtop, (fnn_2 : fnn <: numtype), ?()), `%->%`([(fnn_2 : fnn <: valtype)], [(fnn_1 : fnn <: valtype)]))
    -- if (fnn_1 =/= fnn_2)

  ;; 6-typing.watsup:713.1-715.31
  rule ref.null{C : context, ht : heaptype}:
    `%|-%:%`(C, REF.NULL_instr(ht), `%->%`([], [REF_valtype(`NULL%?`(?(())), ht)]))
    -- Heaptype_ok: `%|-%:_OK`(C, ht)

  ;; 6-typing.watsup:718.1-720.23
  rule ref.func{C : context, x : idx, epsilon : resulttype, dt : deftype}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`(epsilon, [REF_valtype(`NULL%?`(?()), (dt : deftype <: heaptype))]))
    -- if (C.FUNC_context[(x : uN(32) <: nat)] = dt)

  ;; 6-typing.watsup:722.1-723.34
  rule ref.i31{C : context}:
    `%|-%:%`(C, REF.I31_instr, `%->%`([I32_valtype], [REF_valtype(`NULL%?`(?()), I31_heaptype)]))

  ;; 6-typing.watsup:725.1-726.31
  rule ref.is_null{C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([(rt : reftype <: valtype)], [I32_valtype]))

  ;; 6-typing.watsup:728.1-730.31
  rule ref.as_non_null{C : context, ht : heaptype}:
    `%|-%:%`(C, REF.AS_NON_NULL_instr, `%->%`([REF_valtype(`NULL%?`(?(())), ht)], [REF_valtype(`NULL%?`(?()), ht)]))
    -- Heaptype_ok: `%|-%:_OK`(C, ht)

  ;; 6-typing.watsup:732.1-733.51
  rule ref.eq{C : context}:
    `%|-%:%`(C, REF.EQ_instr, `%->%`([REF_valtype(`NULL%?`(?(())), EQ_heaptype) REF_valtype(`NULL%?`(?(())), EQ_heaptype)], [I32_valtype]))

  ;; 6-typing.watsup:735.1-739.33
  rule ref.test{C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.TEST_instr(rt), `%->%`([(rt' : reftype <: valtype)], [I32_valtype]))
    -- Reftype_ok: `%|-%:_OK`(C, rt)
    -- Reftype_ok: `%|-%:_OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; 6-typing.watsup:741.1-745.33
  rule ref.cast{C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.CAST_instr(rt), `%->%`([(rt' : reftype <: valtype)], [(rt : reftype <: valtype)]))
    -- Reftype_ok: `%|-%:_OK`(C, rt)
    -- Reftype_ok: `%|-%:_OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; 6-typing.watsup:750.1-751.42
  rule i31.get{C : context, sx : sx}:
    `%|-%:%`(C, I31.GET_instr(sx), `%->%`([REF_valtype(`NULL%?`(?(())), I31_heaptype)], [I32_valtype]))

  ;; 6-typing.watsup:756.1-758.43
  rule struct.new{C : context, x : idx, zt* : storagetype*, mut* : mut*}:
    `%|-%:%`(C, STRUCT.NEW_instr(x), `%->%`($unpack(zt)*{zt}, [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], STRUCT_comptype(`%%`(mut, zt)*{mut zt}))

  ;; 6-typing.watsup:760.1-763.39
  rule struct.new_default{C : context, x : idx, zt* : storagetype*, mut* : mut*, val* : val*}:
    `%|-%:%`(C, STRUCT.NEW_DEFAULT_instr(x), `%->%`($unpack(zt)*{zt}, [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- (if ($default($unpack(zt)) = ?(val)))*{val zt}

  ;; 6-typing.watsup:765.1-769.39
  rule struct.get{C : context, sx? : sx?, x : idx, i : nat, zt : storagetype, yt* : fieldtype*, mut : mut}:
    `%|-%:%`(C, STRUCT.GET_instr(sx?{sx}, x, i), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype))], [$unpack(zt)]))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], STRUCT_comptype(yt*{yt}))
    -- if (yt*{yt}[i] = `%%`(mut, zt))
    -- if ((sx?{sx} = ?()) <=> (zt = ($unpack(zt) : valtype <: storagetype)))

  ;; 6-typing.watsup:771.1-774.24
  rule struct.set{C : context, x : idx, i : nat, zt : storagetype, yt* : fieldtype*}:
    `%|-%:%`(C, STRUCT.SET_instr(x, i), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype)) $unpack(zt)], []))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], STRUCT_comptype(yt*{yt}))
    -- if (yt*{yt}[i] = `%%`(`MUT%?`(?(())), zt))

  ;; 6-typing.watsup:779.1-781.41
  rule array.new{C : context, x : idx, zt : storagetype, mut : mut}:
    `%|-%:%`(C, ARRAY.NEW_instr(x), `%->%`([$unpack(zt) I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], ARRAY_comptype(`%%`(mut, zt)))

  ;; 6-typing.watsup:783.1-786.36
  rule array.new_default{C : context, x : idx, mut : mut, zt : storagetype, val : val}:
    `%|-%:%`(C, ARRAY.NEW_DEFAULT_instr(x), `%->%`([I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], ARRAY_comptype(`%%`(mut, zt)))
    -- if ($default($unpack(zt)) = ?(val))

  ;; 6-typing.watsup:788.1-790.41
  rule array.new_fixed{C : context, x : idx, n : n, zt : storagetype, mut : mut}:
    `%|-%:%`(C, ARRAY.NEW_FIXED_instr(x, n), `%->%`([$unpack(zt)], [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], ARRAY_comptype(`%%`(mut, zt)))

  ;; 6-typing.watsup:792.1-795.39
  rule array.new_elem{C : context, x : idx, y : idx, mut : mut, rt : reftype}:
    `%|-%:%`(C, ARRAY.NEW_ELEM_instr(x, y), `%->%`([I32_valtype I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], ARRAY_comptype(`%%`(mut, (rt : reftype <: storagetype))))
    -- Reftype_sub: `%|-%<:%`(C, C.ELEM_context[(y : uN(32) <: nat)], rt)

  ;; 6-typing.watsup:797.1-801.23
  rule array.new_data{C : context, x : idx, y : idx, mut : mut, t : valtype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, ARRAY.NEW_DATA_instr(x, y), `%->%`([I32_valtype I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], ARRAY_comptype(`%%`(mut, (t : valtype <: storagetype))))
    -- if ((t = (numtype : numtype <: valtype)) \/ (t = (vectype : vectype <: valtype)))
    -- if (C.DATA_context[(y : uN(32) <: nat)] = OK)

  ;; 6-typing.watsup:803.1-806.39
  rule array.get{C : context, sx? : sx?, x : idx, zt : storagetype, mut : mut}:
    `%|-%:%`(C, ARRAY.GET_instr(sx?{sx}, x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype], [$unpack(zt)]))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], ARRAY_comptype(`%%`(mut, zt)))
    -- if ((sx?{sx} = ?()) <=> (zt = ($unpack(zt) : valtype <: storagetype)))

  ;; 6-typing.watsup:808.1-810.41
  rule array.set{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.SET_instr(x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype $unpack(zt)], []))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:812.1-814.41
  rule array.len{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.LEN_instr, `%->%`([REF_valtype(`NULL%?`(?(())), ARRAY_heaptype)], [I32_valtype]))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:816.1-818.41
  rule array.fill{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.FILL_instr(x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype $unpack(zt) I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:820.1-824.40
  rule array.copy{C : context, x_1 : idx, x_2 : idx, zt_1 : storagetype, mut : mut, zt_2 : storagetype}:
    `%|-%:%`(C, ARRAY.COPY_instr(x_1, x_2), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x_1) : typevar <: heaptype)) I32_valtype REF_valtype(`NULL%?`(?(())), ($idx(x_2) : typevar <: heaptype)) I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[(x_1 : uN(32) <: nat)], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt_1)))
    -- Expand: `%~~%`(C.TYPE_context[(x_2 : uN(32) <: nat)], ARRAY_comptype(`%%`(mut, zt_2)))
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

  ;; 6-typing.watsup:826.1-829.43
  rule array.init_elem{C : context, x : idx, y : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.INIT_ELEM_instr(x, y), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
    -- Storagetype_sub: `%|-%<:%`(C, (C.ELEM_context[(y : uN(32) <: nat)] : reftype <: storagetype), zt)

  ;; 6-typing.watsup:831.1-835.23
  rule array.init_data{C : context, x : idx, y : idx, zt : storagetype, t : valtype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, ARRAY.INIT_DATA_instr(x, y), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
    -- if ((t = (numtype : numtype <: valtype)) \/ (t = (vectype : vectype <: valtype)))
    -- if (C.DATA_context[(y : uN(32) <: nat)] = OK)

  ;; 6-typing.watsup:840.1-841.62
  rule extern.convert_any{C : context, nul : nul}:
    `%|-%:%`(C, EXTERN.CONVERT_ANY_instr, `%->%`([REF_valtype(nul, ANY_heaptype)], [REF_valtype(nul, EXTERN_heaptype)]))

  ;; 6-typing.watsup:843.1-844.62
  rule any.convert_extern{C : context, nul : nul}:
    `%|-%:%`(C, ANY.CONVERT_EXTERN_instr, `%->%`([REF_valtype(nul, EXTERN_heaptype)], [REF_valtype(nul, ANY_heaptype)]))

  ;; 6-typing.watsup:849.1-850.35
  rule vconst{C : context, c : vec_(V128_vnn)}:
    `%|-%:%`(C, VCONST_instr(V128_vectype, c), `%->%`([], [V128_valtype]))

  ;; 6-typing.watsup:852.1-853.41
  rule vvunop{C : context, vvunop : vvunop}:
    `%|-%:%`(C, VVUNOP_instr(V128_vectype, vvunop), `%->%`([V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:855.1-856.48
  rule vvbinop{C : context, vvbinop : vvbinop}:
    `%|-%:%`(C, VVBINOP_instr(V128_vectype, vvbinop), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:858.1-859.55
  rule vvternop{C : context, vvternop : vvternop}:
    `%|-%:%`(C, VVTERNOP_instr(V128_vectype, vvternop), `%->%`([V128_valtype V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:861.1-862.44
  rule vvtestop{C : context, vvtestop : vvtestop}:
    `%|-%:%`(C, VVTESTOP_instr(V128_vectype, vvtestop), `%->%`([V128_valtype], [I32_valtype]))

  ;; 6-typing.watsup:864.1-865.33
  rule vbitmask{C : context, sh : ishape}:
    `%|-%:%`(C, VBITMASK_instr(sh), `%->%`([V128_valtype], [I32_valtype]))

  ;; 6-typing.watsup:867.1-868.39
  rule vswizzle{C : context, sh : ishape}:
    `%|-%:%`(C, VSWIZZLE_instr(sh), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:870.1-872.22
  rule vshuffle{C : context, imm : imm, N : N, i* : nat*}:
    `%|-%:%`(C, VSHUFFLE_instr(`%X%`(imm, N), i*{i}), `%->%`([V128_valtype V128_valtype], [V128_valtype]))
    -- (if (i < (N * 2)))*{i}

  ;; 6-typing.watsup:874.1-875.48
  rule vsplat{C : context, lnn : lnn, N : N}:
    `%|-%:%`(C, VSPLAT_instr(`%X%`(lnn, N)), `%->%`([($lunpack(lnn) : numtype <: valtype)], [V128_valtype]))

  ;; 6-typing.watsup:878.1-880.14
  rule vextract_lane{C : context, lnn : lnn, N : N, sx? : sx?, i : nat}:
    `%|-%:%`(C, VEXTRACT_LANE_instr(`%X%`(lnn, N), sx?{sx}, i), `%->%`([V128_valtype], [($lunpack(lnn) : numtype <: valtype)]))
    -- if (i < N)

  ;; 6-typing.watsup:882.1-884.14
  rule vreplace_lane{C : context, lnn : lnn, N : N, i : nat}:
    `%|-%:%`(C, VREPLACE_LANE_instr(`%X%`(lnn, N), i), `%->%`([V128_valtype ($lunpack(lnn) : numtype <: valtype)], [V128_valtype]))
    -- if (i < N)

  ;; 6-typing.watsup:886.1-887.40
  rule vunop{C : context, sh : shape, vunop_sh : vunop_(sh)}:
    `%|-%:%`(C, VUNOP_instr(sh, vunop_sh), `%->%`([V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:889.1-890.47
  rule vbinop{C : context, sh : shape, vbinop_sh : vbinop_(sh)}:
    `%|-%:%`(C, VBINOP_instr(sh, vbinop_sh), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:892.1-893.43
  rule vtestop{C : context, sh : shape, vtestop_sh : vtestop_(sh)}:
    `%|-%:%`(C, VTESTOP_instr(sh, vtestop_sh), `%->%`([V128_valtype], [I32_valtype]))

  ;; 6-typing.watsup:895.1-896.47
  rule vrelop{C : context, sh : shape, vrelop_sh : vrelop_(sh)}:
    `%|-%:%`(C, VRELOP_instr(sh, vrelop_sh), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:898.1-899.50
  rule vshiftop{C : context, sh : ishape, vshiftop_sh : vshiftop_(sh)}:
    `%|-%:%`(C, VSHIFTOP_instr(sh, vshiftop_sh), `%->%`([V128_valtype I32_valtype], [V128_valtype]))

  ;; 6-typing.watsup:902.1-903.55
  rule vcvtop{C : context, sh : shape, vcvtop : vcvtop, hf? : half?, sx? : sx?, zero : zero}:
    `%|-%:%`(C, VCVTOP_instr(sh, vcvtop, hf?{hf}, sh, sx?{sx}, zero), `%->%`([V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:905.1-906.44
  rule vnarrow{C : context, sh : ishape, sx : sx}:
    `%|-%:%`(C, VNARROW_instr(sh, sh, sx), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:908.1-909.49
  rule vextunop{C : context, sh : ishape, vextunop : vextunop_(sh, sh), sx : sx}:
    `%|-%:%`(C, VEXTUNOP_instr(sh, sh, vextunop, sx), `%->%`([V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:911.1-912.56
  rule vextbinop{C : context, sh : ishape, vextbinop : vextbinop_(sh, sh), sx : sx}:
    `%|-%:%`(C, VEXTBINOP_instr(sh, sh, vextbinop, sx), `%->%`([V128_valtype V128_valtype], [V128_valtype]))

  ;; 6-typing.watsup:914.1-915.33
  rule vbitmask{C : context, sh : ishape}:
    `%|-%:%`(C, VBITMASK_instr(sh), `%->%`([V128_valtype], [I32_valtype]))

  ;; 6-typing.watsup:920.1-922.28
  rule local.get{C : context, x : idx, t : valtype, init : init}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[(x : uN(32) <: nat)] = `%%`(init, t))

  ;; 6-typing.watsup:935.1-937.28
  rule global.get{C : context, x : idx, t : valtype, mut : mut}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[(x : uN(32) <: nat)] = `%%`(mut, t))

  ;; 6-typing.watsup:939.1-941.28
  rule global.set{C : context, x : idx, t : valtype}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[(x : uN(32) <: nat)] = `%%`(`MUT%?`(?(())), t))

  ;; 6-typing.watsup:946.1-948.28
  rule table.get{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [(rt : reftype <: valtype)]))
    -- if (C.TABLE_context[(x : uN(32) <: nat)] = `%%`(lim, rt))

  ;; 6-typing.watsup:950.1-952.28
  rule table.set{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype (rt : reftype <: valtype)], []))
    -- if (C.TABLE_context[(x : uN(32) <: nat)] = `%%`(lim, rt))

  ;; 6-typing.watsup:954.1-956.24
  rule table.size{C : context, x : idx, tt : tabletype}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[(x : uN(32) <: nat)] = tt)

  ;; 6-typing.watsup:958.1-960.28
  rule table.grow{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([(rt : reftype <: valtype) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[(x : uN(32) <: nat)] = `%%`(lim, rt))

  ;; 6-typing.watsup:962.1-964.28
  rule table.fill{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype (rt : reftype <: valtype) I32_valtype], []))
    -- if (C.TABLE_context[(x : uN(32) <: nat)] = `%%`(lim, rt))

  ;; 6-typing.watsup:966.1-970.36
  rule table.copy{C : context, x_1 : idx, x_2 : idx, lim_1 : limits, rt_1 : reftype, lim_2 : limits, rt_2 : reftype}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[(x_1 : uN(32) <: nat)] = `%%`(lim_1, rt_1))
    -- if (C.TABLE_context[(x_2 : uN(32) <: nat)] = `%%`(lim_2, rt_2))
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:972.1-976.36
  rule table.init{C : context, x : idx, y : idx, lim : limits, rt_1 : reftype, rt_2 : reftype}:
    `%|-%:%`(C, TABLE.INIT_instr(x, y), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[(x : uN(32) <: nat)] = `%%`(lim, rt_1))
    -- if (C.ELEM_context[(y : uN(32) <: nat)] = rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:978.1-980.23
  rule elem.drop{C : context, x : idx, rt : reftype}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[(x : uN(32) <: nat)] = rt)

  ;; 6-typing.watsup:985.1-987.22
  rule memory.size{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)

  ;; 6-typing.watsup:989.1-991.22
  rule memory.grow{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr(x), `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)

  ;; 6-typing.watsup:993.1-995.22
  rule memory.fill{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)

  ;; 6-typing.watsup:997.1-1000.26
  rule memory.copy{C : context, x_1 : idx, x_2 : idx, mt_1 : memtype, mt_2 : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[(x_1 : uN(32) <: nat)] = mt_1)
    -- if (C.MEM_context[(x_2 : uN(32) <: nat)] = mt_2)

  ;; 6-typing.watsup:1002.1-1005.23
  rule memory.init{C : context, x : idx, y : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.INIT_instr(x, y), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)
    -- if (C.DATA_context[(y : uN(32) <: nat)] = OK)

  ;; 6-typing.watsup:1007.1-1009.23
  rule data.drop{C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[(x : uN(32) <: nat)] = OK)

  ;; 6-typing.watsup:1011.1-1016.29
  rule load{C : context, nt : numtype, n? : n?, sx? : sx?, x : idx, n_A : n, n_O : n, mt : memtype, inn : inn}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [(nt : numtype <: valtype)]))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)
    -- if ((2 ^ n_A) <= ($size((nt : numtype <: valtype)) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size((nt : numtype <: valtype)) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (inn : inn <: numtype)))

  ;; 6-typing.watsup:1018.1-1023.29
  rule store{C : context, nt : numtype, n? : n?, x : idx, n_A : n, n_O : n, mt : memtype, inn : inn}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype (nt : numtype <: valtype)], []))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)
    -- if ((2 ^ n_A) <= ($size((nt : numtype <: valtype)) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size((nt : numtype <: valtype)) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (inn : inn <: numtype)))

  ;; 6-typing.watsup:1025.1-1028.30
  rule vload{C : context, M : M, N : N, sx : sx, x : idx, n_A : n, n_O : n, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(?(SHAPE_vloadop(M, N, sx)), x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [V128_valtype]))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)
    -- if ((2 ^ n_A) <= ((M / 8) * N))

  ;; 6-typing.watsup:1030.1-1033.26
  rule vload-splat{C : context, n : n, x : idx, n_A : n, n_O : n, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(?(SPLAT_vloadop(n)), x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [V128_valtype]))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)
    -- if ((2 ^ n_A) <= (n / 8))

  ;; 6-typing.watsup:1035.1-1038.25
  rule vload-zero{C : context, n : n, x : idx, n_A : n, n_O : n, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(?(ZERO_vloadop(n)), x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [V128_valtype]))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)
    -- if ((2 ^ n_A) < (n / 8))

  ;; 6-typing.watsup:1040.1-1044.29
  rule vload_lane{C : context, n : n, x : idx, n_A : n, n_O : n, laneidx : laneidx, mt : memtype}:
    `%|-%:%`(C, VLOAD_LANE_instr(n, x, {ALIGN n_A, OFFSET n_O}, laneidx), `%->%`([I32_valtype V128_valtype], [V128_valtype]))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)
    -- if ((2 ^ n_A) < (n / 8))
    -- if ((laneidx : uN(8) <: nat) < (128 / n))

  ;; 6-typing.watsup:1046.1-1049.36
  rule vstore{C : context, x : idx, n_A : n, n_O : n, mt : memtype}:
    `%|-%:%`(C, VSTORE_instr(x, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype V128_valtype], []))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)
    -- if ((2 ^ n_A) <= ($size(V128_valtype) / 8))

  ;; 6-typing.watsup:1051.1-1055.29
  rule vstore_lane{C : context, n : n, x : idx, n_A : n, n_O : n, laneidx : laneidx, mt : memtype}:
    `%|-%:%`(C, VSTORE_LANE_instr(n, x, {ALIGN n_A, OFFSET n_O}, laneidx), `%->%`([I32_valtype V128_valtype], []))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)
    -- if ((2 ^ n_A) < (n / 8))
    -- if ((laneidx : uN(8) <: nat) < (128 / n))

;; 6-typing.watsup:504.1-504.67
relation Instrf_ok: `%|-%:%`(context, instr, instrtype)
  ;; 6-typing.watsup:518.1-520.41
  rule instr{C : context, instr : instr, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, instr, `%->%*%`(t_1*{t_1}, [], t_2*{t_2}))
    -- Instr_ok: `%|-%:%`(C, instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 6-typing.watsup:924.1-926.28
  rule local.set{C : context, x : idx, t : valtype, init : init}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%*%`([t], [x], []))
    -- if (C.LOCAL_context[(x : uN(32) <: nat)] = `%%`(init, t))

  ;; 6-typing.watsup:928.1-930.28
  rule local.tee{C : context, x : idx, t : valtype, init : init}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%*%`([t], [x], [t]))
    -- if (C.LOCAL_context[(x : uN(32) <: nat)] = `%%`(init, t))

;; 6-typing.watsup:505.1-505.74
relation Instrs_ok: `%|-%*_:%`(context, instr*, instrtype)
  ;; 6-typing.watsup:522.1-523.29
  rule empty{C : context}:
    `%|-%*_:%`(C, [], `%->%*%`([], [], []))

  ;; 6-typing.watsup:525.1-530.52
  rule seq{C : context, instr_1 : instr, instr_2* : instr*, t_1* : valtype*, x_1* : idx*, x_2* : idx*, t_3* : valtype*, init* : init*, t* : valtype*, C' : context, t_2* : valtype*}:
    `%|-%*_:%`(C, [instr_1] :: instr_2*{instr_2}, `%->%*%`(t_1*{t_1}, x_1*{x_1} :: x_2*{x_2}, t_3*{t_3}))
    -- (if (C.LOCAL_context[(x_1 : uN(32) <: nat)] = `%%`(init, t)))*{init t x_1}
    -- if (C' = $with_locals(C, x_1*{x_1}, `%%`(SET_init, t)*{t}))
    -- Instrf_ok: `%|-%:%`(C, instr_1, `%->%*%`(t_1*{t_1}, x_1*{x_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*_:%`(C', instr_2*{instr_2}, `%->%*%`(t_2*{t_2}, x_2*{x_2}, t_3*{t_3}))

  ;; 6-typing.watsup:532.1-535.35
  rule sub{C : context, instr* : instr*, it' : instrtype, it : instrtype}:
    `%|-%*_:%`(C, instr*{instr}, it')
    -- Instrs_ok: `%|-%*_:%`(C, instr*{instr}, it)
    -- Instrtype_sub: `%|-%<:%`(C, it, it')

  ;; 6-typing.watsup:537.1-539.47
  rule frame{C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, x* : idx*, t_2* : valtype*}:
    `%|-%*_:%`(C, instr*{instr}, `%->%*%`(t*{t} :: t_1*{t_1}, x*{x}, t*{t} :: t_2*{t_2}))
    -- Instrs_ok: `%|-%*_:%`(C, instr*{instr}, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))
}

;; 6-typing.watsup:506.1-506.72
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 6-typing.watsup:511.1-513.45
  rule _{C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- Instrs_ok: `%|-%*_:%`(C, instr*{instr}, `%->%*%`([], [], t*{t}))

;; 6-typing.watsup:1086.1-1086.86
rec {

;; 6-typing.watsup:1086.1-1086.86
def $in_binop(numtype : numtype, binop_ : binop_(numtype), binop_(numtype)*) : bool
  ;; 6-typing.watsup:1087.1-1087.42
  def $in_binop{nt : numtype, binop : binop_(nt), epsilon : binop_(nt)*}(nt, binop, epsilon) = false
  ;; 6-typing.watsup:1088.1-1088.99
  def $in_binop{nt : numtype, binop : binop_(nt), ibinop_1 : binop_(nt), ibinop'* : binop_(nt)*}(nt, binop, [ibinop_1] :: ibinop'*{ibinop'}) = ((binop = ibinop_1) \/ $in_binop(nt, binop, ibinop'*{ibinop'}))
}

;; 6-typing.watsup:1082.1-1082.63
rec {

;; 6-typing.watsup:1082.1-1082.63
def $in_numtype(numtype : numtype, numtype*) : bool
  ;; 6-typing.watsup:1083.1-1083.37
  def $in_numtype{nt : numtype, epsilon : numtype*}(nt, epsilon) = false
  ;; 6-typing.watsup:1084.1-1084.68
  def $in_numtype{nt : numtype, nt_1 : numtype, nt'* : numtype*}(nt, [nt_1] :: nt'*{nt'}) = ((nt = nt_1) \/ $in_numtype(nt, nt'*{nt'}))
}

;; 6-typing.watsup:1061.1-1061.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 6-typing.watsup:1065.1-1066.26
  rule const{C : context, nt : numtype, c : num_(nt)}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 6-typing.watsup:1068.1-1069.30
  rule vvconst{C : context, vt : vectype, c_vt : vec_(vt)}:
    `%|-%CONST`(C, VCONST_instr(vt, c_vt))

  ;; 6-typing.watsup:1071.1-1072.27
  rule ref.null{C : context, ht : heaptype}:
    `%|-%CONST`(C, REF.NULL_instr(ht))

  ;; 6-typing.watsup:1074.1-1075.26
  rule ref.func{C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 6-typing.watsup:1077.1-1079.24
  rule global.get{C : context, x : idx, t : valtype}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[(x : uN(32) <: nat)] = `%%`(`MUT%?`(?()), t))

  ;; 6-typing.watsup:1090.1-1093.43
  rule binop{C : context, inn : inn, binop : binop_((inn : inn <: numtype))}:
    `%|-%CONST`(C, BINOP_instr((inn : inn <: numtype), binop))
    -- if $in_numtype((inn : inn <: numtype), [I32_numtype I64_numtype])
    -- if $in_binop((inn : inn <: numtype), binop, [ADD_binop_((inn : inn <: numtype)) SUB_binop_((inn : inn <: numtype)) MUL_binop_((inn : inn <: numtype))])

;; 6-typing.watsup:1062.1-1062.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 6-typing.watsup:1096.1-1097.38
  rule _{C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 6-typing.watsup:1063.1-1063.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 6-typing.watsup:1100.1-1103.33
  rule _{C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 6-typing.watsup:1112.1-1112.73
relation Type_ok: `%|-%:%*`(context, type, deftype*)
  ;; 6-typing.watsup:1124.1-1128.53
  rule _{C : context, rectype : rectype, dt* : deftype*, x : idx}:
    `%|-%:%*`(C, TYPE(rectype), dt*{dt})
    -- if (x = |C.TYPE_context|)
    -- if (dt*{dt} = $rolldt(x, rectype))
    -- Rectype_ok: `%|-%:%`(C[TYPE_context =.. dt*{dt}], rectype, OK_oktypeidx(x))

;; 6-typing.watsup:1114.1-1114.74
relation Local_ok: `%|-%:%`(context, local, localtype)
  ;; 6-typing.watsup:1130.1-1132.28
  rule set{C : context, t : valtype}:
    `%|-%:%`(C, LOCAL(t), `%%`(SET_init, t))
    -- if ($default(t) =/= ?())

  ;; 6-typing.watsup:1134.1-1136.26
  rule unset{C : context, t : valtype}:
    `%|-%:%`(C, LOCAL(t), `%%`(UNSET_init, t))
    -- if ($default(t) = ?())

;; 6-typing.watsup:1113.1-1113.73
relation Func_ok: `%|-%:%`(context, func, deftype)
  ;; 6-typing.watsup:1138.1-1142.82
  rule _{C : context, x : idx, local* : local*, expr : expr, t_1* : valtype*, t_2* : valtype*, lt* : localtype*}:
    `%|-%:%`(C, `FUNC%%*%`(x, local*{local}, expr), C.TYPE_context[(x : uN(32) <: nat)])
    -- Expand: `%~~%`(C.TYPE_context[(x : uN(32) <: nat)], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- (Local_ok: `%|-%:%`(C, local, lt))*{local lt}
    -- Expr_ok: `%|-%:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL `%%`(SET_init, t_1)*{t_1} :: lt*{lt}, LABEL [], RETURN ?()} ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 6-typing.watsup:1115.1-1115.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 6-typing.watsup:1144.1-1148.40
  rule _{C : context, gt : globaltype, expr : expr, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `%|-%:_OK`(C, gt)
    -- if (gt = `%%`(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 6-typing.watsup:1116.1-1116.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 6-typing.watsup:1150.1-1154.41
  rule _{C : context, tt : tabletype, expr : expr, limits : limits, rt : reftype}:
    `%|-%:%`(C, TABLE(tt, expr), tt)
    -- Tabletype_ok: `%|-%:_OK`(C, tt)
    -- if (tt = `%%`(limits, rt))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, (rt : reftype <: valtype))

;; 6-typing.watsup:1117.1-1117.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 6-typing.watsup:1156.1-1158.30
  rule _{C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `%|-%:_OK`(C, mt)

;; 6-typing.watsup:1120.1-1120.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 6-typing.watsup:1169.1-1172.45
  rule active{C : context, x : idx, expr : expr, rt : reftype, lim : limits}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[(x : uN(32) <: nat)] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 6-typing.watsup:1174.1-1175.20
  rule passive{C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; 6-typing.watsup:1177.1-1178.20
  rule declare{C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 6-typing.watsup:1118.1-1118.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 6-typing.watsup:1160.1-1163.37
  rule _{C : context, rt : reftype, expr* : expr*, elemmode : elemmode}:
    `%|-%:%`(C, `ELEM%%*%`(rt, expr*{expr}, elemmode), rt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, (rt : reftype <: valtype)))*{expr}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, rt)

;; 6-typing.watsup:1121.1-1121.77
relation Datamode_ok: `%|-%:_OK`(context, datamode)
  ;; 6-typing.watsup:1180.1-1183.45
  rule active{C : context, x : idx, expr : expr, mt : memtype}:
    `%|-%:_OK`(C, ACTIVE_datamode(x, expr))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 6-typing.watsup:1185.1-1186.20
  rule passive{C : context}:
    `%|-%:_OK`(C, PASSIVE_datamode)

;; 6-typing.watsup:1119.1-1119.73
relation Data_ok: `%|-%:_OK`(context, data)
  ;; 6-typing.watsup:1165.1-1167.37
  rule _{C : context, b* : byte*, datamode : datamode}:
    `%|-%:_OK`(C, `DATA%*%`(b*{b}, datamode))
    -- Datamode_ok: `%|-%:_OK`(C, datamode)

;; 6-typing.watsup:1122.1-1122.74
relation Start_ok: `%|-%:_OK`(context, start)
  ;; 6-typing.watsup:1188.1-1190.44
  rule _{C : context, x : idx}:
    `%|-%:_OK`(C, START(x))
    -- Expand: `%~~%`(C.FUNC_context[(x : uN(32) <: nat)], FUNC_comptype(`%->%`([], [])))

;; 6-typing.watsup:1195.1-1195.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 6-typing.watsup:1199.1-1201.33
  rule _{C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `%|-%:_OK`(C, xt)

;; 6-typing.watsup:1197.1-1197.83
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; 6-typing.watsup:1208.1-1210.23
  rule func{C : context, x : idx, dt : deftype}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype(dt))
    -- if (C.FUNC_context[(x : uN(32) <: nat)] = dt)

  ;; 6-typing.watsup:1212.1-1214.25
  rule global{C : context, x : idx, gt : globaltype}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[(x : uN(32) <: nat)] = gt)

  ;; 6-typing.watsup:1216.1-1218.24
  rule table{C : context, x : idx, tt : tabletype}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[(x : uN(32) <: nat)] = tt)

  ;; 6-typing.watsup:1220.1-1222.22
  rule mem{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (C.MEM_context[(x : uN(32) <: nat)] = mt)

;; 6-typing.watsup:1196.1-1196.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 6-typing.watsup:1203.1-1205.39
  rule _{C : context, name : name, externidx : externidx, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externidx), xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 6-typing.watsup:1229.1-1229.77
rec {

;; 6-typing.watsup:1229.1-1229.77
relation Globals_ok: `%|-%*_:%*`(context, global*, globaltype*)
  ;; 6-typing.watsup:1272.1-1273.17
  rule empty{C : context}:
    `%|-%*_:%*`(C, [], [])

  ;; 6-typing.watsup:1275.1-1278.54
  rule cons{C : context, global_1 : global, global : global, gt_1 : globaltype, gt* : globaltype*}:
    `%|-%*_:%*`(C, [global_1] :: global*{}, [gt_1] :: gt*{gt})
    -- Global_ok: `%|-%:%`(C, global, gt_1)
    -- Globals_ok: `%|-%*_:%*`(C[GLOBAL_context =.. [gt_1]], global*{}, gt*{gt})
}

;; 6-typing.watsup:1228.1-1228.75
rec {

;; 6-typing.watsup:1228.1-1228.75
relation Types_ok: `%|-%*_:%*`(context, type*, deftype*)
  ;; 6-typing.watsup:1264.1-1265.17
  rule empty{C : context}:
    `%|-%*_:%*`(C, [], [])

  ;; 6-typing.watsup:1267.1-1270.49
  rule cons{C : context, type_1 : type, type* : type*, dt_1 : deftype, dt* : deftype*}:
    `%|-%*_:%*`(C, [type_1] :: type*{type}, dt_1*{} :: dt*{dt})
    -- Type_ok: `%|-%:%*`(C, type_1, [dt_1])
    -- Types_ok: `%|-%*_:%*`(C[TYPE_context =.. dt_1*{}], type*{type}, dt*{dt})
}

;; 6-typing.watsup:1227.1-1227.76
relation Module_ok: `|-%:_OK`(module)
  ;; 6-typing.watsup:1238.1-1261.29
  rule _{type* : type*, import* : import*, func* : func*, global* : global*, table* : table*, mem* : mem*, elem* : elem*, data^n : data^n, n : n, start? : start?, export* : export*, dt'* : deftype*, ixt* : externtype*, C' : context, gt* : globaltype*, tt* : tabletype*, mt* : memtype*, C : context, dt* : deftype*, rt* : reftype*, et* : externtype*, idt* : deftype*, igt* : globaltype*, itt* : tabletype*, imt* : memtype*}:
    `|-%:_OK`(`MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- Types_ok: `%|-%*_:%*`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, type*{type}, dt'*{dt'})
    -- (Import_ok: `%|-%:%`({TYPE dt'*{dt'}, REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, import, ixt))*{import ixt}
    -- Globals_ok: `%|-%*_:%*`(C', global*{global}, gt*{gt})
    -- (Table_ok: `%|-%:%`(C', table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C', mem, mt))*{mem mt}
    -- (Func_ok: `%|-%:%`(C, func, dt))*{dt func}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:_OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:_OK`(C, start))?{start}
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
  rule null{s : store, ht : heaptype}:
    `%|-%:%`(s, REF.NULL_ref(ht), REF_reftype(`NULL%?`(?(())), ht))

  ;; 7-runtime-typing.watsup:10.1-11.37
  rule i31{s : store, i : nat}:
    `%|-%:%`(s, REF.I31_NUM_ref(i), REF_reftype(`NULL%?`(?()), I31_heaptype))

  ;; 7-runtime-typing.watsup:13.1-15.30
  rule struct{s : store, a : addr, dt : deftype}:
    `%|-%:%`(s, REF.STRUCT_ADDR_ref(a), REF_reftype(`NULL%?`(?()), (dt : deftype <: heaptype)))
    -- if (s.STRUCT_store[a].TYPE_structinst = dt)

  ;; 7-runtime-typing.watsup:17.1-19.29
  rule array{s : store, a : addr, dt : deftype}:
    `%|-%:%`(s, REF.ARRAY_ADDR_ref(a), REF_reftype(`NULL%?`(?()), (dt : deftype <: heaptype)))
    -- if (s.ARRAY_store[a].TYPE_arrayinst = dt)

  ;; 7-runtime-typing.watsup:21.1-23.28
  rule func{s : store, a : addr, dt : deftype}:
    `%|-%:%`(s, REF.FUNC_ADDR_ref(a), REF_reftype(`NULL%?`(?()), (dt : deftype <: heaptype)))
    -- if (s.FUNC_store[a].TYPE_funcinst = dt)

  ;; 7-runtime-typing.watsup:25.1-26.39
  rule host{s : store, a : addr}:
    `%|-%:%`(s, REF.HOST_ADDR_ref(a), REF_reftype(`NULL%?`(?()), ANY_heaptype))

  ;; 7-runtime-typing.watsup:28.1-29.45
  rule extern{s : store, addrref : addrref}:
    `%|-%:%`(s, REF.EXTERN_ref(addrref), REF_reftype(`NULL%?`(?()), EXTERN_heaptype))

;; 8-reduction.watsup:6.1-6.63
relation Step_pure: `%*_~>%*`(admininstr*, admininstr*)
  ;; 8-reduction.watsup:42.1-43.24
  rule unreachable:
    `%*_~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 8-reduction.watsup:45.1-46.15
  rule nop:
    `%*_~>%*`([NOP_admininstr], [])

  ;; 8-reduction.watsup:48.1-49.20
  rule drop{val : val}:
    `%*_~>%*`([(val : val <: admininstr) DROP_admininstr], [])

  ;; 8-reduction.watsup:52.1-54.16
  rule select-true{val_1 : val, val_2 : val, c : num_(I32_numtype), t*? : valtype*?}:
    `%*_~>%*`([(val_1 : val <: admininstr) (val_2 : val <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [(val_1 : val <: admininstr)])
    -- if (c =/= 0)

  ;; 8-reduction.watsup:56.1-58.14
  rule select-false{val_1 : val, val_2 : val, c : num_(I32_numtype), t*? : valtype*?}:
    `%*_~>%*`([(val_1 : val <: admininstr) (val_2 : val <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [(val_2 : val <: admininstr)])
    -- if (c = 0)

  ;; 8-reduction.watsup:76.1-78.16
  rule if-true{c : num_(I32_numtype), bt : blocktype, instr_1* : instr*, instr_2* : instr*}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 8-reduction.watsup:80.1-82.14
  rule if-false{c : num_(I32_numtype), bt : blocktype, instr_1* : instr*, instr_2* : instr*}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 8-reduction.watsup:85.1-86.38
  rule label-vals{n : n, instr* : instr*, val* : val*}:
    `%*_~>%*`([LABEL__admininstr(n, instr*{instr}, (val : val <: admininstr)*{val})], (val : val <: admininstr)*{val})

  ;; 8-reduction.watsup:92.1-93.69
  rule br-zero{n : n, instr'* : instr*, val'* : val*, val^n : val^n, instr* : instr*}:
    `%*_~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val' : val <: admininstr)*{val'} :: (val : val <: admininstr)^n{val} :: [BR_admininstr(0)] :: (instr : instr <: admininstr)*{instr})], (val : val <: admininstr)^n{val} :: (instr' : instr <: admininstr)*{instr'})

  ;; 8-reduction.watsup:95.1-96.65
  rule br-succ{n : n, instr'* : instr*, val* : val*, l : labelidx, instr* : instr*}:
    `%*_~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val : val <: admininstr)*{val} :: [BR_admininstr(((l : uN(32) <: nat) + 1))] :: (instr : instr <: admininstr)*{instr})], (val : val <: admininstr)*{val} :: [BR_admininstr(l)])

  ;; 8-reduction.watsup:99.1-101.16
  rule br_if-true{c : num_(I32_numtype), l : labelidx}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 8-reduction.watsup:103.1-105.14
  rule br_if-false{c : num_(I32_numtype), l : labelidx}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 8-reduction.watsup:108.1-110.17
  rule br_table-lt{i : nat, l* : labelidx*, l' : labelidx}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 8-reduction.watsup:112.1-114.18
  rule br_table-ge{i : nat, l* : labelidx*, l' : labelidx}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 8-reduction.watsup:117.1-119.26
  rule br_on_null-null{val : val, l : labelidx, ht : heaptype}:
    `%*_~>%*`([(val : val <: admininstr) BR_ON_NULL_admininstr(l)], [BR_admininstr(l)])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup:121.1-123.15
  rule br_on_null-addr{val : val, l : labelidx}:
    `%*_~>%*`([(val : val <: admininstr) BR_ON_NULL_admininstr(l)], [(val : val <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup:126.1-128.26
  rule br_on_non_null-null{val : val, l : labelidx, ht : heaptype}:
    `%*_~>%*`([(val : val <: admininstr) BR_ON_NON_NULL_admininstr(l)], [])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup:130.1-132.15
  rule br_on_non_null-addr{val : val, l : labelidx}:
    `%*_~>%*`([(val : val <: admininstr) BR_ON_NON_NULL_admininstr(l)], [(val : val <: admininstr) BR_admininstr(l)])
    -- otherwise

  ;; 8-reduction.watsup:186.1-187.84
  rule call_indirect-call{x : idx, y : idx}:
    `%*_~>%*`([CALL_INDIRECT_admininstr(x, y)], [TABLE.GET_admininstr(x) REF.CAST_admininstr(REF_reftype(`NULL%?`(?(())), ($idx(y) : typevar <: heaptype))) CALL_REF_admininstr(?(y))])

  ;; 8-reduction.watsup:189.1-190.98
  rule return_call_indirect{x : idx, y : idx}:
    `%*_~>%*`([RETURN_CALL_INDIRECT_admininstr(x, y)], [TABLE.GET_admininstr(x) REF.CAST_admininstr(REF_reftype(`NULL%?`(?(())), ($idx(y) : typevar <: heaptype))) RETURN_CALL_REF_admininstr(?(y))])

  ;; 8-reduction.watsup:193.1-194.35
  rule frame-vals{n : n, f : frame, val^n : val^n}:
    `%*_~>%*`([FRAME__admininstr(n, f, (val : val <: admininstr)^n{val})], (val : val <: admininstr)^n{val})

  ;; 8-reduction.watsup:196.1-197.55
  rule return-frame{n : n, f : frame, val'* : val*, val^n : val^n, instr* : instr*}:
    `%*_~>%*`([FRAME__admininstr(n, f, (val' : val <: admininstr)*{val'} :: (val : val <: admininstr)^n{val} :: [RETURN_admininstr] :: (instr : instr <: admininstr)*{instr})], (val : val <: admininstr)^n{val})

  ;; 8-reduction.watsup:199.1-200.60
  rule return-label{k : nat, instr'* : instr*, val* : val*, instr* : instr*}:
    `%*_~>%*`([LABEL__admininstr(k, instr'*{instr'}, (val : val <: admininstr)*{val} :: [RETURN_admininstr] :: (instr : instr <: admininstr)*{instr})], (val : val <: admininstr)*{val} :: [RETURN_admininstr])

  ;; 8-reduction.watsup:205.1-207.33
  rule unop-val{nt : numtype, c_1 : num_(nt), unop : unop_(nt), c : num_(nt)}:
    `%*_~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(nt, unop, c_1) = [c])

  ;; 8-reduction.watsup:209.1-211.35
  rule unop-trap{nt : numtype, c_1 : num_(nt), unop : unop_(nt)}:
    `%*_~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(nt, unop, c_1) = [])

  ;; 8-reduction.watsup:214.1-216.40
  rule binop-val{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), binop : binop_(nt), c : num_(nt)}:
    `%*_~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(nt, binop, c_1, c_2) = [c])

  ;; 8-reduction.watsup:218.1-220.42
  rule binop-trap{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), binop : binop_(nt)}:
    `%*_~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(nt, binop, c_1, c_2) = [])

  ;; 8-reduction.watsup:223.1-225.37
  rule testop{nt : numtype, c_1 : num_(nt), testop : testop_(nt), c : num_(I32_numtype)}:
    `%*_~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(nt, testop, c_1))

  ;; 8-reduction.watsup:227.1-229.40
  rule relop{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), relop : relop_(nt), c : num_(I32_numtype)}:
    `%*_~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(nt, relop, c_1, c_2))

  ;; 8-reduction.watsup:232.1-234.48
  rule cvtop-val{nt_1 : numtype, c_1 : num_(nt_1), nt_2 : numtype, cvtop : cvtop, sx? : sx?, c : num_(nt_2)}:
    `%*_~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, nt_2, cvtop, sx?{sx}, c_1) = [c])

  ;; 8-reduction.watsup:236.1-238.50
  rule cvtop-trap{nt_1 : numtype, c_1 : num_(nt_1), nt_2 : numtype, cvtop : cvtop, sx? : sx?}:
    `%*_~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, nt_2, cvtop, sx?{sx}, c_1) = [])

  ;; 8-reduction.watsup:246.1-247.60
  rule ref.i31{i : nat}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, i) REF.I31_admininstr], [REF.I31_NUM_admininstr($wrap(32, 31, i))])

  ;; 8-reduction.watsup:250.1-252.28
  rule ref.is_null-true{val : val, ht : heaptype}:
    `%*_~>%*`([(val : val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup:254.1-256.15
  rule ref.is_null-false{val : val}:
    `%*_~>%*`([(val : val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:259.1-261.28
  rule ref.as_non_null-null{ref : ref, ht : heaptype}:
    `%*_~>%*`([(ref : ref <: admininstr) REF.AS_NON_NULL_admininstr], [TRAP_admininstr])
    -- if (ref = REF.NULL_ref(ht))

  ;; 8-reduction.watsup:263.1-265.15
  rule ref.as_non_null-addr{ref : ref}:
    `%*_~>%*`([(ref : ref <: admininstr) REF.AS_NON_NULL_admininstr], [(ref : ref <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup:268.1-270.55
  rule ref.eq-null{ref_1 : ref, ref_2 : ref, ht_1 : heaptype, ht_2 : heaptype}:
    `%*_~>%*`([(ref_1 : ref <: admininstr) (ref_2 : ref <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if ((ref_1 = REF.NULL_ref(ht_1)) /\ (ref_2 = REF.NULL_ref(ht_2)))

  ;; 8-reduction.watsup:272.1-275.22
  rule ref.eq-true{ref_1 : ref, ref_2 : ref}:
    `%*_~>%*`([(ref_1 : ref <: admininstr) (ref_2 : ref <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- otherwise
    -- if (ref_1 = ref_2)

  ;; 8-reduction.watsup:277.1-279.15
  rule ref.eq-false{ref_1 : ref, ref_2 : ref}:
    `%*_~>%*`([(ref_1 : ref <: admininstr) (ref_2 : ref <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:304.1-305.39
  rule i31.get-null{ht : heaptype, sx : sx}:
    `%*_~>%*`([REF.NULL_admininstr(ht) I31.GET_admininstr(sx)], [TRAP_admininstr])

  ;; 8-reduction.watsup:307.1-308.68
  rule i31.get-num{i : nat, sx : sx}:
    `%*_~>%*`([REF.I31_NUM_admininstr(i) I31.GET_admininstr(sx)], [CONST_admininstr(I32_numtype, $ext(31, 32, sx, i))])

  ;; 8-reduction.watsup:542.1-543.58
  rule extern.convert_any-null{ht : heaptype}:
    `%*_~>%*`([REF.NULL_admininstr(ht) EXTERN.CONVERT_ANY_admininstr], [REF.NULL_admininstr(EXTERN_heaptype)])

  ;; 8-reduction.watsup:545.1-546.55
  rule extern.convert_any-addr{addrref : addrref}:
    `%*_~>%*`([(addrref : addrref <: admininstr) EXTERN.CONVERT_ANY_admininstr], [REF.EXTERN_admininstr(addrref)])

  ;; 8-reduction.watsup:549.1-550.55
  rule any.convert_extern-null{ht : heaptype}:
    `%*_~>%*`([REF.NULL_admininstr(ht) ANY.CONVERT_EXTERN_admininstr], [REF.NULL_admininstr(ANY_heaptype)])

  ;; 8-reduction.watsup:552.1-553.55
  rule any.convert_extern-addr{addrref : addrref}:
    `%*_~>%*`([REF.EXTERN_admininstr(addrref) ANY.CONVERT_EXTERN_admininstr], [(addrref : addrref <: admininstr)])

  ;; 8-reduction.watsup:558.1-560.39
  rule vvunop{c_1 : vec_(V128_vnn), vvunop : vvunop, c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VVUNOP_admininstr(V128_vectype, vvunop)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vvunop(V128_vectype, vvunop, c_1) = c)

  ;; 8-reduction.watsup:563.1-565.46
  rule vvbinop{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), vvbinop : vvbinop, c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VVBINOP_admininstr(V128_vectype, vvbinop)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vvbinop(V128_vectype, vvbinop, c_1, c_2) = c)

  ;; 8-reduction.watsup:568.1-570.53
  rule vvternop{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), c_3 : vec_(V128_vnn), vvternop : vvternop, c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VCONST_admininstr(V128_vectype, c_3) VVTERNOP_admininstr(V128_vectype, vvternop)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vvternop(V128_vectype, vvternop, c_1, c_2, c_3) = c)

  ;; 8-reduction.watsup:573.1-575.38
  rule vvtestop{c_1 : vec_(V128_vnn), c : num_(I32_numtype)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VVTESTOP_admininstr(V128_vectype, ANY_TRUE_vvtestop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $ine($size(V128_valtype), c_1, 0))

  ;; 8-reduction.watsup:578.1-583.54
  rule vswizzle{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), inn : inn, N : N, c' : vec_(V128_vnn), c : iN($size((inn : inn <: valtype))), ci* : lane_($lanetype(`%X%`((inn : inn <: lanetype), N)))*, k^N : nat^N}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VSWIZZLE_admininstr(`%X%`((inn : inn <: imm), N))], [VCONST_admininstr(V128_vectype, c')])
    -- if (ci*{ci} = $lanes_(`%X%`((inn : inn <: lanetype), N), c_2))
    -- if (c*{} = $lanes_(`%X%`((inn : inn <: lanetype), N), c_1) :: 0^(256 - N){})
    -- if (c' = $invlanes_(`%X%`((inn : inn <: lanetype), N), c*{}[(ci*{ci}[k] : lane_($lanetype(`%X%`((inn : inn <: lanetype), N))) <: nat)]^(k<N){k}))

  ;; 8-reduction.watsup:586.1-590.53
  rule vshuffle{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), inn : inn, N : N, i* : nat*, c : vec_(V128_vnn), c' : iN($size((inn : inn <: valtype))), k^N : nat^N}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VSHUFFLE_admininstr(`%X%`((inn : inn <: imm), N), i*{i})], [VCONST_admininstr(V128_vectype, c)])
    -- if (c'*{} = $lanes_(`%X%`((inn : inn <: lanetype), N), c_1) :: $lanes_(`%X%`((inn : inn <: lanetype), N), c_2))
    -- if (c = $invlanes_(`%X%`((inn : inn <: lanetype), N), c'*{}[i*{i}[k]]^(k<N){k}))

  ;; 8-reduction.watsup:593.1-595.54
  rule vsplat{lnn : lnn, c_1 : num_($lunpack(lnn)), N : N, c : vec_(V128_vnn)}:
    `%*_~>%*`([CONST_admininstr($lunpack(lnn), c_1) VSPLAT_admininstr(`%X%`(lnn, N))], [VCONST_admininstr(V128_vectype, c)])
    -- if (c = $invlanes_(`%X%`(lnn, N), $packnum(lnn, c_1)^N{}))

  ;; 8-reduction.watsup:598.1-600.38
  rule vextract_lane-num{c_1 : vec_(V128_vnn), nt : numtype, N : N, i : nat, c_2 : num_(nt)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VEXTRACT_LANE_admininstr(`%X%`((nt : numtype <: lanetype), N), ?(), i)], [CONST_admininstr(nt, c_2)])
    -- if (c_2 = $lanes_(`%X%`((nt : numtype <: lanetype), N), c_1)[i])

  ;; 8-reduction.watsup:602.1-604.64
  rule vextract_lane-pack{c_1 : vec_(V128_vnn), pt : packtype, N : N, sx : sx, i : nat, c_2 : num_(I32_numtype)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VEXTRACT_LANE_admininstr(`%X%`((pt : packtype <: lanetype), N), ?(sx), i)], [CONST_admininstr(I32_numtype, c_2)])
    -- if (c_2 = $ext($psize(pt), 32, sx, $lanes_(`%X%`((pt : packtype <: lanetype), N), c_1)[i]))

  ;; 8-reduction.watsup:607.1-609.81
  rule vreplace_lane{c_1 : vec_(V128_vnn), lnn : lnn, c_2 : num_($lunpack(lnn)), N : N, i : nat, c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) CONST_admininstr($lunpack(lnn), c_2) VREPLACE_LANE_admininstr(`%X%`(lnn, N), i)], [VCONST_admininstr(V128_vectype, c)])
    -- if (c = $invlanes_(`%X%`(lnn, N), $lanes_(`%X%`(lnn, N), c_1)[[i] = $packnum(lnn, c_2)]))

  ;; 8-reduction.watsup:612.1-614.35
  rule vunop{c_1 : vec_(V128_vnn), sh : shape, vunop : vunop_(sh), c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VUNOP_admininstr(sh, vunop)], [VCONST_admininstr(V128_vectype, c)])
    -- if (c = $vunop(sh, vunop, c_1))

  ;; 8-reduction.watsup:617.1-619.42
  rule vbinop-val{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), sh : shape, vbinop : vbinop_(sh), c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VBINOP_admininstr(sh, vbinop)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vbinop(sh, vbinop, c_1, c_2) = [c])

  ;; 8-reduction.watsup:621.1-623.44
  rule vbinop-trap{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), sh : shape, vbinop : vbinop_(sh)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VBINOP_admininstr(sh, vbinop)], [TRAP_admininstr])
    -- if ($vbinop(sh, vbinop, c_1, c_2) = [])

  ;; 8-reduction.watsup:626.1-628.42
  rule vrelop{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), sh : shape, vrelop : vrelop_(sh), c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VRELOP_admininstr(sh, vrelop)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vrelop(sh, vrelop, c_1, c_2) = c)

  ;; 8-reduction.watsup:636.1-639.71
  rule vshiftop{c_1 : vec_(V128_vnn), n : n, imm : imm, N : N, vshiftop : vshiftop_(`%X%`(imm, N)), c : vec_(V128_vnn), c'* : lane_($lanetype(`%X%`((imm : imm <: lanetype), N)))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) CONST_admininstr(I32_numtype, n) VSHIFTOP_admininstr(`%X%`(imm, N), vshiftop)], [VCONST_admininstr(V128_vectype, c)])
    -- if (c'*{c'} = $lanes_(`%X%`((imm : imm <: lanetype), N), c_1))
    -- if (c = $invlanes_(`%X%`((imm : imm <: lanetype), N), $vishiftop(`%X%`(imm, N), vshiftop, c', n)*{c'}))

  ;; 8-reduction.watsup:643.1-646.25
  rule vtestop-true{c : vec_(V128_vnn), inn : inn, N : N, ci_1* : lane_($lanetype(`%X%`((inn : inn <: lanetype), N)))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c) VTESTOP_admininstr(`%X%`((inn : inn <: lanetype), N), ALL_TRUE_vtestop_(`%X%`((inn : inn <: lanetype), N)))], [CONST_admininstr(I32_numtype, 1)])
    -- if (ci_1*{ci_1} = $lanes_(`%X%`((inn : inn <: lanetype), N), c))
    -- (if (ci_1 =/= (0 : nat <: lane_($lanetype(`%X%`((inn : inn <: lanetype), N))))))*{ci_1}

  ;; 8-reduction.watsup:648.1-650.15
  rule vtestop-false{c : vec_(V128_vnn), inn : inn, N : N}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c) VTESTOP_admininstr(`%X%`((inn : inn <: lanetype), N), ALL_TRUE_vtestop_(`%X%`((inn : inn <: lanetype), N)))], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:653.1-656.55
  rule vbitmask{c : vec_(V128_vnn), inn : inn, N : N, ci : num_(I32_numtype), ci_1* : lane_($lanetype(`%X%`((inn : inn <: lanetype), N)))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c) VBITMASK_admininstr(`%X%`((inn : inn <: imm), N))], [CONST_admininstr(I32_numtype, ci)])
    -- if (ci_1*{ci_1} = $lanes_(`%X%`((inn : inn <: lanetype), N), c))
    -- if ($ibits(32, ci) = $ilt($size((inn : inn <: valtype)), S_sx, ci_1, 0)*{ci_1})

  ;; 8-reduction.watsup:659.1-665.49
  rule vnarrow{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), inn_1 : inn, N_1 : N, inn_2 : inn, N_2 : N, sx : sx, c : vec_(V128_vnn), ci_1* : lane_($lanetype(`%X%`((inn_1 : inn <: lanetype), N_1)))*, ci_2* : lane_($lanetype(`%X%`((inn_1 : inn <: lanetype), N_1)))*, cj_1* : iN($size((inn_2 : inn <: valtype)))*, cj_2* : iN($size((inn_2 : inn <: valtype)))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VNARROW_admininstr(`%X%`((inn_1 : inn <: imm), N_1), `%X%`((inn_2 : inn <: imm), N_2), sx)], [VCONST_admininstr(V128_vectype, c)])
    -- if (ci_1*{ci_1} = $lanes_(`%X%`((inn_1 : inn <: lanetype), N_1), c_1))
    -- if (ci_2*{ci_2} = $lanes_(`%X%`((inn_1 : inn <: lanetype), N_1), c_2))
    -- if (cj_1*{cj_1} = $narrow($size((inn_1 : inn <: valtype)), $size((inn_2 : inn <: valtype)), sx, ci_1)*{ci_1})
    -- if (cj_2*{cj_2} = $narrow($size((inn_1 : inn <: valtype)), $size((inn_2 : inn <: valtype)), sx, ci_2)*{ci_2})
    -- if (c = $invlanes_(`%X%`((inn_2 : inn <: lanetype), N_2), cj_1*{cj_1} :: cj_2*{cj_2}))

  ;; 8-reduction.watsup:668.1-671.88
  rule vcvtop-normal{c_1 : vec_(V128_vnn), lnn_2 : lnn, N_2 : N, vcvtop : vcvtop, lnn_1 : lnn, N_1 : N, sx : sx, c : vec_(V128_vnn), c'* : lane_($lanetype(`%X%`(lnn_1, N_1)))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCVTOP_admininstr(`%X%`(lnn_2, N_2), vcvtop, ?(), `%X%`(lnn_1, N_1), ?(sx), `ZERO%?`(?()))], [VCONST_admininstr(V128_vectype, c)])
    -- if (c'*{c'} = $lanes_(`%X%`(lnn_1, N_1), c_1))
    -- if (c = $invlanes_(`%X%`(lnn_2, N_2), $vcvtop(`%X%`(lnn_1, N_1), `%X%`(lnn_2, N_2), vcvtop, ?(sx), c')*{c'}))

  ;; 8-reduction.watsup:674.1-677.89
  rule vcvtop-half{c_1 : vec_(V128_vnn), inn_2 : inn, N_2 : N, vcvtop : vcvtop, hf : half, inn_1 : inn, N_1 : N, sx? : sx?, c : vec_(V128_vnn), ci* : lane_($lanetype(`%X%`((inn_1 : inn <: lanetype), N_1)))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCVTOP_admininstr(`%X%`((inn_2 : inn <: lanetype), N_2), vcvtop, ?(hf), `%X%`((inn_1 : inn <: lanetype), N_1), sx?{sx}, `ZERO%?`(?()))], [VCONST_admininstr(V128_vectype, c)])
    -- if (ci*{ci} = $lanes_(`%X%`((inn_1 : inn <: lanetype), N_1), c_1)[$halfop(hf, 0, N_2) : N_2])
    -- if (c = $invlanes_(`%X%`((inn_2 : inn <: lanetype), N_2), $vcvtop(`%X%`((inn_1 : inn <: lanetype), N_1), `%X%`((inn_2 : inn <: lanetype), N_2), vcvtop, sx?{sx}, ci)*{ci}))

  ;; 8-reduction.watsup:679.1-682.95
  rule vcvtop-zero{c_1 : vec_(V128_vnn), inn_2 : inn, N_2 : N, vcvtop : vcvtop, inn_1 : inn, N_1 : N, sx? : sx?, c : vec_(V128_vnn), ci* : lane_($lanetype(`%X%`((inn_1 : inn <: lanetype), N_1)))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCVTOP_admininstr(`%X%`((inn_2 : inn <: lanetype), N_2), vcvtop, ?(), `%X%`((inn_1 : inn <: lanetype), N_1), sx?{sx}, `ZERO%?`(?(())))], [VCONST_admininstr(V128_vectype, c)])
    -- if (ci*{ci} = $lanes_(`%X%`((inn_1 : inn <: lanetype), N_1), c_1))
    -- if (c = $invlanes_(`%X%`((inn_2 : inn <: lanetype), N_2), $vcvtop(`%X%`((inn_1 : inn <: lanetype), N_1), `%X%`((inn_2 : inn <: lanetype), N_2), vcvtop, sx?{sx}, ci)*{ci} :: (0 : nat <: lane_($lanetype(`%X%`((inn_2 : inn <: lanetype), N_2))))^N_1{}))

  ;; 8-reduction.watsup:685.1-687.53
  rule vextunop{c_1 : vec_(V128_vnn), sh_1 : ishape, sh_2 : ishape, vextunop : vextunop_(sh_1, sh_2), sx : sx, c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VEXTUNOP_admininstr(sh_1, sh_2, vextunop, sx)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vextunop(sh_1, sh_2, vextunop, sx, c_1) = c)

  ;; 8-reduction.watsup:690.1-692.60
  rule vextbinop{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), sh_1 : ishape, sh_2 : ishape, vextbinop : vextbinop_(sh_1, sh_2), sx : sx, c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VEXTBINOP_admininstr(sh_1, sh_2, vextbinop, sx)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vextbinop(sh_1, sh_2, vextbinop, sx, c_1, c_2) = c)

  ;; 8-reduction.watsup:704.1-705.47
  rule local.tee{val : val, x : idx}:
    `%*_~>%*`([(val : val <: admininstr) LOCAL.TEE_admininstr(x)], [(val : val <: admininstr) (val : val <: admininstr) LOCAL.SET_admininstr(x)])

;; 8-reduction.watsup:63.1-63.73
def $blocktype(state : state, blocktype : blocktype) : functype
  ;; 8-reduction.watsup:64.1-64.44
  def $blocktype{z : state}(z, _RESULT_blocktype(?())) = `%->%`([], [])
  ;; 8-reduction.watsup:65.1-65.40
  def $blocktype{z : state, t : valtype}(z, _RESULT_blocktype(?(t))) = `%->%`([], [t])
  ;; 8-reduction.watsup:66.1-66.66
  def $blocktype{z : state, x : idx, ft : functype}(z, _IDX_blocktype(x)) = ft
    -- Expand: `%~~%`($type(z, x), FUNC_comptype(ft))

;; 8-reduction.watsup:7.1-7.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 8-reduction.watsup:68.1-70.43
  rule block{z : state, val^k : val^k, k : nat, bt : blocktype, instr* : instr*, n : n, t_1^k : valtype^k, t_2^n : valtype^n}:
    `%~>%*`(`%;%*`(z, (val : val <: admininstr)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})]), [LABEL__admininstr(n, [], (val : val <: admininstr)^k{val} :: (instr : instr <: admininstr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 8-reduction.watsup:72.1-74.43
  rule loop{z : state, val^k : val^k, k : nat, bt : blocktype, instr* : instr*, t_1^k : valtype^k, t_2^n : valtype^n, n : n}:
    `%~>%*`(`%;%*`(z, (val : val <: admininstr)^k{val} :: [LOOP_admininstr(bt, instr*{instr})]), [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], (val : val <: admininstr)^k{val} :: (instr : instr <: admininstr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 8-reduction.watsup:135.1-138.66
  rule br_on_cast-succeed{z : state, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype, rt : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) BR_ON_CAST_admininstr(l, rt_1, rt_2)]), [(ref : ref <: admininstr) BR_admininstr(l)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))

  ;; 8-reduction.watsup:140.1-142.15
  rule br_on_cast-fail{z : state, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) BR_ON_CAST_admininstr(l, rt_1, rt_2)]), [(ref : ref <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup:145.1-148.66
  rule br_on_cast_fail-succeed{z : state, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype, rt : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) BR_ON_CAST_FAIL_admininstr(l, rt_1, rt_2)]), [(ref : ref <: admininstr)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))

  ;; 8-reduction.watsup:150.1-152.15
  rule br_on_cast_fail-fail{z : state, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) BR_ON_CAST_FAIL_admininstr(l, rt_1, rt_2)]), [(ref : ref <: admininstr) BR_admininstr(l)])
    -- otherwise

  ;; 8-reduction.watsup:157.1-158.62
  rule call{z : state, x : idx}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[(x : uN(32) <: nat)]) CALL_REF_admininstr(?())])

  ;; 8-reduction.watsup:160.1-161.43
  rule call_ref-null{z : state, ht : heaptype, x? : idx?}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CALL_REF_admininstr(x?{x})]), [TRAP_admininstr])

  ;; 8-reduction.watsup:163.1-168.59
  rule call_ref-func{z : state, val^n : val^n, n : n, a : addr, x? : idx?, m : m, f : frame, instr* : instr*, fi : funcinst, t_1^n : valtype^n, t_2^m : valtype^m, y : idx, t* : valtype*}:
    `%~>%*`(`%;%*`(z, (val : val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a) CALL_REF_admininstr(x?{x})]), [FRAME__admininstr(m, f, [LABEL__admininstr(m, [], (instr : instr <: admininstr)*{instr})])])
    -- if ($funcinst(z)[a] = fi)
    -- Expand: `%~~%`(fi.TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
    -- if (fi.CODE_funcinst = `FUNC%%*%`(y, LOCAL(t)*{t}, instr*{instr}))
    -- if (f = {LOCAL ?(val)^n{val} :: $default(t)*{t}, MODULE fi.MODULE_funcinst})

  ;; 8-reduction.watsup:171.1-172.76
  rule return_call{z : state, x : idx}:
    `%~>%*`(`%;%*`(z, [RETURN_CALL_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[(x : uN(32) <: nat)]) RETURN_CALL_REF_admininstr(?())])

  ;; 8-reduction.watsup:175.1-176.91
  rule return_call_ref-label{z : state, k : nat, instr'* : instr*, val* : val*, x? : idx?, instr* : instr*}:
    `%~>%*`(`%;%*`(z, [LABEL__admininstr(k, instr'*{instr'}, (val : val <: admininstr)*{val} :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr : instr <: admininstr)*{instr})]), (val : val <: admininstr)*{val} :: [RETURN_CALL_REF_admininstr(x?{x})])

  ;; 8-reduction.watsup:178.1-180.59
  rule return_call_ref-frame-addr{z : state, k : nat, f : frame, val'* : val*, val^n : val^n, n : n, a : addr, x? : idx?, instr* : instr*, t_1^n : valtype^n, t_2^m : valtype^m, m : m}:
    `%~>%*`(`%;%*`(z, [FRAME__admininstr(k, f, (val' : val <: admininstr)*{val'} :: (val : val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a)] :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr : instr <: admininstr)*{instr})]), (val : val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a) CALL_REF_admininstr(x?{x})])
    -- Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))

  ;; 8-reduction.watsup:182.1-183.78
  rule return_call_ref-frame-null{z : state, k : nat, f : frame, val* : val*, ht : heaptype, x? : idx?, instr* : instr*}:
    `%~>%*`(`%;%*`(z, [FRAME__admininstr(k, f, (val : val <: admininstr)*{val} :: [REF.NULL_admininstr(ht)] :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr : instr <: admininstr)*{instr})]), [TRAP_admininstr])

  ;; 8-reduction.watsup:243.1-244.55
  rule ref.func{z : state, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[(x : uN(32) <: nat)])])

  ;; 8-reduction.watsup:282.1-285.65
  rule ref.test-true{z : state, ref : ref, rt : reftype, rt' : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) REF.TEST_admininstr(rt)]), [CONST_admininstr(I32_numtype, 1)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))

  ;; 8-reduction.watsup:287.1-289.15
  rule ref.test-false{z : state, ref : ref, rt : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) REF.TEST_admininstr(rt)]), [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:292.1-295.65
  rule ref.cast-succeed{z : state, ref : ref, rt : reftype, rt' : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) REF.CAST_admininstr(rt)]), [(ref : ref <: admininstr)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))

  ;; 8-reduction.watsup:297.1-299.15
  rule ref.cast-fail{z : state, ref : ref, rt : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) REF.CAST_admininstr(rt)]), [TRAP_admininstr])
    -- otherwise

  ;; 8-reduction.watsup:318.1-321.39
  rule struct.new_default{z : state, x : idx, val* : val*, mut* : mut*, zt* : storagetype*}:
    `%~>%*`(`%;%*`(z, [STRUCT.NEW_DEFAULT_admininstr(x)]), (val : val <: admininstr)*{val} :: [STRUCT.NEW_admininstr(x)])
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- (if ($default($unpack(zt)) = ?(val)))*{val zt}

  ;; 8-reduction.watsup:324.1-325.50
  rule struct.get-null{z : state, ht : heaptype, sx? : sx?, x : idx, i : nat}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) STRUCT.GET_admininstr(sx?{sx}, x, i)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:327.1-330.41
  rule struct.get-struct{z : state, a : addr, sx? : sx?, x : idx, i : nat, zt* : storagetype*, si : structinst, mut* : mut*}:
    `%~>%*`(`%;%*`(z, [REF.STRUCT_ADDR_admininstr(a) STRUCT.GET_admininstr(sx?{sx}, x, i)]), [($unpackval(zt*{zt}[i], sx?{sx}, si.FIELD_structinst[i]) : val <: admininstr)])
    -- if ($structinst(z)[a] = si)
    -- Expand: `%~~%`(si.TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))

  ;; 8-reduction.watsup:344.1-345.70
  rule array.new{z : state, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [(val : val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.NEW_admininstr(x)]), (val : val <: admininstr)^n{} :: [ARRAY.NEW_FIXED_admininstr(x, n)])

  ;; 8-reduction.watsup:347.1-350.36
  rule array.new_default{z : state, n : n, x : idx, val : val, mut : mut, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) ARRAY.NEW_DEFAULT_admininstr(x)]), (val : val <: admininstr)^n{} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ($default($unpack(zt)) = ?(val))

  ;; 8-reduction.watsup:358.1-360.38
  rule array.new_elem-oob{z : state, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$elem(z, y).ELEM_eleminst|)

  ;; 8-reduction.watsup:362.1-364.40
  rule array.new_elem-alloc{z : state, i : nat, n : n, x : idx, y : idx, ref^n : ref^n}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_ELEM_admininstr(x, y)]), (ref : ref <: admininstr)^n{ref} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- if (ref^n{ref} = $elem(z, y).ELEM_eleminst[i : n])

  ;; 8-reduction.watsup:367.1-370.53
  rule array.new_data-oob{z : state, i : nat, n : n, x : idx, y : idx, mut : mut, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ((i + ((n * $zsize(zt)) / 8)) > |$data(z, y).DATA_datainst|)

  ;; 8-reduction.watsup:372.1-376.82
  rule array.new_data-num{z : state, i : nat, n : n, x : idx, y : idx, nt : numtype, c^n : num_(nt)^n, mut : mut, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_DATA_admininstr(x, y)]), CONST_admininstr(nt, c)^n{c} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (nt = $nunpack(zt))
    -- if ($concat_(syntax byte, $nbytes(nt, c)^n{c}) = $data(z, y).DATA_datainst[i : ((n * $zsize(zt)) / 8)])

  ;; 8-reduction.watsup:379.1-383.82
  rule array.new_data-vec{z : state, i : nat, n : n, x : idx, y : idx, vt : vectype, c^n : vec_(vt)^n, mut : mut, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_DATA_admininstr(x, y)]), VCONST_admininstr(vt, c)^n{c} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (vt = $vunpack(zt))
    -- if ($concat_(syntax byte, $vbytes(vt, c)^n{c}) = $data(z, y).DATA_datainst[i : ((n * $zsize(zt)) / 8)])

  ;; 8-reduction.watsup:386.1-387.61
  rule array.get-null{z : state, ht : heaptype, i : nat, sx? : sx?, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) ARRAY.GET_admininstr(sx?{sx}, x)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:389.1-391.38
  rule array.get-oob{z : state, a : addr, i : nat, sx? : sx?, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) ARRAY.GET_admininstr(sx?{sx}, x)]), [TRAP_admininstr])
    -- if (i >= |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:393.1-396.53
  rule array.get-array{z : state, a : addr, i : nat, sx? : sx?, x : idx, zt : storagetype, fv : fieldval, mut : mut}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) ARRAY.GET_admininstr(sx?{sx}, x)]), [($unpackval(zt, sx?{sx}, fv) : val <: admininstr)])
    -- if (fv = $arrayinst(z)[a].FIELD_arrayinst[i])
    -- Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))

  ;; 8-reduction.watsup:412.1-413.39
  rule array.len-null{z : state, ht : heaptype}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) ARRAY.LEN_admininstr]), [TRAP_admininstr])

  ;; 8-reduction.watsup:415.1-417.37
  rule array.len-array{z : state, a : addr, n : n}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) ARRAY.LEN_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (n = |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:420.1-421.76
  rule array.fill-null{z : state, ht : heaptype, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) (val : val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:423.1-425.44
  rule array.fill-oob{z : state, a : addr, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val : val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:427.1-430.14
  rule array.fill-zero{z : state, a : addr, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val : val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:432.1-436.15
  rule array.fill-succ{z : state, a : addr, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val : val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val : val <: admininstr) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) (val : val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup:438.1-439.102
  rule array.copy-null1{z : state, ht_1 : heaptype, i_1 : nat, ref : ref, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht_1) CONST_admininstr(I32_numtype, i_1) (ref : ref <: admininstr) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:441.1-442.102
  rule array.copy-null2{z : state, ref : ref, i_1 : nat, ht_2 : heaptype, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) CONST_admininstr(I32_numtype, i_1) REF.NULL_admininstr(ht_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:444.1-446.48
  rule array.copy-oob1{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if ((i_1 + n) > |$arrayinst(z)[a_1].FIELD_arrayinst|)

  ;; 8-reduction.watsup:448.1-450.48
  rule array.copy-oob2{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if ((i_2 + n) > |$arrayinst(z)[a_2].FIELD_arrayinst|)

  ;; 8-reduction.watsup:452.1-455.14
  rule array.copy-zero{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:457.1-466.19
  rule array.copy-le{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx, sx? : sx?, mut : mut, zt_2 : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) ARRAY.GET_admininstr(sx?{sx}, x_2) ARRAY.SET_admininstr(x_1) REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, (i_1 + 1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, (i_2 + 1)) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
    -- if (sx?{sx} = $sxfield(zt_2))
    -- if (i_1 <= i_2)

  ;; 8-reduction.watsup:468.1-476.29
  rule array.copy-gt{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx, sx? : sx?, mut : mut, zt_2 : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, ((i_1 + n) - 1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, ((i_2 + n) - 1)) ARRAY.GET_admininstr(sx?{sx}, x_2) ARRAY.SET_admininstr(x_1) REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
    -- if (sx?{sx} = $sxfield(zt_2))

  ;; 8-reduction.watsup:479.1-480.93
  rule array.init_elem-null{z : state, ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:482.1-484.44
  rule array.init_elem-oob1{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:486.1-488.38
  rule array.init_elem-oob2{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((j + n) > |$elem(z, y).ELEM_eleminst|)

  ;; 8-reduction.watsup:490.1-493.14
  rule array.init_elem-zero{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:495.1-500.34
  rule array.init_elem-succ{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, ref : ref}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (ref : ref <: admininstr) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.INIT_ELEM_admininstr(x, y)])
    -- otherwise
    -- if (ref = $elem(z, y).ELEM_eleminst[j])

  ;; 8-reduction.watsup:503.1-504.93
  rule array.init_data-null{z : state, ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:506.1-508.44
  rule array.init_data-oob1{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:510.1-513.53
  rule array.init_data-oob2{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, mut : mut, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ((j + ((n * $zsize(zt)) / 8)) > |$data(z, y).DATA_datainst|)

  ;; 8-reduction.watsup:515.1-518.14
  rule array.init_data-zero{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:520.1-527.60
  rule array.init_data-num{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, nt : numtype, c : num_(nt), zt : storagetype, mut : mut}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (j + ($zsize(zt) / 8))) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.INIT_DATA_admininstr(x, y)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (nt = $nunpack(zt))
    -- if ($nbytes(nt, c) = $data(z, y).DATA_datainst[j : ($zsize(zt) / 8)])

  ;; 8-reduction.watsup:530.1-537.60
  rule array.init_data-num{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, vt : vectype, c : vec_(vt), zt : storagetype, mut : mut}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) VCONST_admininstr(vt, c) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (j + ($zsize(zt) / 8))) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.INIT_DATA_admininstr(x, y)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (vt = $vunpack((vt : vectype <: storagetype)))
    -- if ($vbytes(vt, c) = $data(z, y).DATA_datainst[j : ($zsize(zt) / 8)])

  ;; 8-reduction.watsup:697.1-699.27
  rule local.get{z : state, x : idx, val : val}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [(val : val <: admininstr)])
    -- if ($local(z, x) = ?(val))

  ;; 8-reduction.watsup:710.1-711.45
  rule global.get{z : state, x : idx}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [($global(z, x).VALUE_globalinst : val <: admininstr)])

  ;; 8-reduction.watsup:719.1-721.33
  rule table.get-oob{z : state, i : nat, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:723.1-725.32
  rule table.get-val{z : state, i : nat, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [($table(z, x).ELEM_tableinst[i] : ref <: admininstr)])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:736.1-738.32
  rule table.size{z : state, x : idx, n : n}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 8-reduction.watsup:749.1-751.39
  rule table.fill-oob{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val : val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:753.1-756.14
  rule table.fill-zero{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val : val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:758.1-762.15
  rule table.fill-succ{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val : val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) (val : val <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) (val : val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup:765.1-767.73
  rule table.copy-oob{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 8-reduction.watsup:769.1-772.14
  rule table.copy-zero{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:774.1-779.15
  rule table.copy-le{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 8-reduction.watsup:781.1-785.15
  rule table.copy-gt{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup:788.1-790.72
  rule table.init-oob{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 8-reduction.watsup:792.1-795.14
  rule table.init-zero{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:797.1-801.15
  rule table.init-succ{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) ($elem(z, y).ELEM_eleminst[i] : ref <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup:810.1-812.59
  rule load-num-oob{z : state, i : nat, nt : numtype, x : idx, mo : memop}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), x, mo)]), [TRAP_admininstr])
    -- if (((i + (mo.OFFSET_memop : uN(32) <: nat)) + ($size((nt : numtype <: valtype)) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:814.1-816.70
  rule load-num-val{z : state, i : nat, nt : numtype, x : idx, mo : memop, c : num_(nt)}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), x, mo)]), [CONST_admininstr(nt, c)])
    -- if ($nbytes(nt, c) = $mem(z, x).DATA_meminst[(i + (mo.OFFSET_memop : uN(32) <: nat)) : ($size((nt : numtype <: valtype)) / 8)])

  ;; 8-reduction.watsup:818.1-820.51
  rule load-pack-oob{z : state, i : nat, inn : inn, n : n, sx : sx, x : idx, mo : memop}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr((inn : inn <: numtype), ?((n, sx)), x, mo)]), [TRAP_admininstr])
    -- if (((i + (mo.OFFSET_memop : uN(32) <: nat)) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:822.1-824.61
  rule load-pack-val{z : state, i : nat, inn : inn, n : n, sx : sx, x : idx, mo : memop, c : iN(n)}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr((inn : inn <: numtype), ?((n, sx)), x, mo)]), [CONST_admininstr((inn : inn <: numtype), $ext(n, $size((inn : inn <: valtype)), sx, c))])
    -- if ($ibytes(n, c) = $mem(z, x).DATA_meminst[(i + (mo.OFFSET_memop : uN(32) <: nat)) : (n / 8)])

  ;; 8-reduction.watsup:826.1-828.61
  rule vload-oob{z : state, i : nat, x : idx, mo : memop}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(), x, mo)]), [TRAP_admininstr])
    -- if (((i + (mo.OFFSET_memop : uN(32) <: nat)) + ($size(V128_valtype) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:830.1-832.74
  rule vload-val{z : state, i : nat, x : idx, mo : memop, c : vec_(V128_vnn)}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(), x, mo)]), [VCONST_admininstr(V128_vectype, c)])
    -- if ($vbytes(V128_vectype, c) = $mem(z, x).DATA_meminst[(i + (mo.OFFSET_memop : uN(32) <: nat)) : ($size(V128_valtype) / 8)])

  ;; 8-reduction.watsup:835.1-837.55
  rule vload-shape-oob{z : state, i : nat, M : M, N : N, sx : sx, x : idx, mo : memop}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(SHAPE_vloadop(M, N, sx)), x, mo)]), [TRAP_admininstr])
    -- if (((i + (mo.OFFSET_memop : uN(32) <: nat)) + ((M * N) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:839.1-843.62
  rule vload-shape-val{z : state, i : nat, M : M, N : N, sx : sx, x : idx, mo : memop, c : vec_(V128_vnn), j^N : nat^N, k^N : nat^N, inn : inn}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(SHAPE_vloadop(M, N, sx)), x, mo)]), [VCONST_admininstr(V128_vectype, c)])
    -- (if ($ibytes(M, j) = $mem(z, x).DATA_meminst[((i + (mo.OFFSET_memop : uN(32) <: nat)) + ((k * M) / 8)) : (M / 8)]))^(k<N){j k}
    -- if ($size((inn : inn <: valtype)) = (M * 2))
    -- if (c = $invlanes_(`%X%`((inn : inn <: lanetype), N), $ext(M, $size((inn : inn <: valtype)), sx, j)^N{j}))

  ;; 8-reduction.watsup:846.1-848.51
  rule vload-splat-oob{z : state, i : nat, N : N, x : idx, mo : memop}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(SPLAT_vloadop(N)), x, mo)]), [TRAP_admininstr])
    -- if (((i + (mo.OFFSET_memop : uN(32) <: nat)) + (N / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:850.1-855.36
  rule vload-splat-val{z : state, i : nat, N : N, x : idx, mo : memop, c : vec_(V128_vnn), j : nat, imm : imm, M : M}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(SPLAT_vloadop(N)), x, mo)]), [VCONST_admininstr(V128_vectype, c)])
    -- if ($ibytes(N, j) = $mem(z, x).DATA_meminst[(i + (mo.OFFSET_memop : uN(32) <: nat)) : (N / 8)])
    -- if (N = $lsize((imm : imm <: lanetype)))
    -- if (M = (128 / N))
    -- if (c = $invlanes_(`%X%`((imm : imm <: lanetype), M), (j : nat <: lane_($lanetype(`%X%`((imm : imm <: lanetype), M))))*{}))

  ;; 8-reduction.watsup:858.1-860.51
  rule vload-zero-oob{z : state, i : nat, N : N, x : idx, mo : memop}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(ZERO_vloadop(N)), x, mo)]), [TRAP_admininstr])
    -- if (((i + (mo.OFFSET_memop : uN(32) <: nat)) + (N / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:862.1-865.31
  rule vload-zero-val{z : state, i : nat, N : N, x : idx, mo : memop, c : vec_(V128_vnn), j : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VLOAD_admininstr(?(ZERO_vloadop(N)), x, mo)]), [VCONST_admininstr(V128_vectype, c)])
    -- if ($ibytes(N, j) = $mem(z, x).DATA_meminst[(i + (mo.OFFSET_memop : uN(32) <: nat)) : (N / 8)])
    -- if (c = $ext(N, 128, U_sx, j))

  ;; 8-reduction.watsup:868.1-870.51
  rule vload_lane-oob{z : state, i : nat, vt : vectype, c_1 : vec_(vt), N : N, x : idx, mo : memop, j : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VCONST_admininstr(vt, c_1) VLOAD_LANE_admininstr(N, x, mo, j)]), [TRAP_admininstr])
    -- if (((i + (mo.OFFSET_memop : uN(32) <: nat)) + (N / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:872.1-877.64
  rule vload_lane-val{z : state, i : nat, vt : vectype, c_1 : vec_(vt), N : N, x : idx, mo : memop, j : nat, c : vec_(vt), k : nat, imm : imm, M : M}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VCONST_admininstr(vt, c_1) VLOAD_LANE_admininstr(N, x, mo, j)]), [VCONST_admininstr(vt, c)])
    -- if ($ibytes(N, k) = $mem(z, x).DATA_meminst[(i + (mo.OFFSET_memop : uN(32) <: nat)) : (N / 8)])
    -- if (N = $lsize((imm : imm <: lanetype)))
    -- if (M = ($size((vt : vectype <: valtype)) / N))
    -- if (c = $invlanes_(`%X%`((imm : imm <: lanetype), M), $lanes_(`%X%`((imm : imm <: lanetype), M), c_1)[[j] = (k : nat <: lane_($lanetype(`%X%`((imm : imm <: lanetype), M))))]))

  ;; 8-reduction.watsup:916.1-918.44
  rule memory.size{z : state, x : idx, n : n}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:929.1-931.37
  rule memory.fill-oob{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val : val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:933.1-936.14
  rule memory.fill-zero{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val : val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:938.1-942.15
  rule memory.fill-succ{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val : val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) (val : val <: admininstr) STORE_admininstr(I32_numtype, ?(8), x, $memop0) CONST_admininstr(I32_numtype, (i + 1)) (val : val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup:945.1-947.77
  rule memory.copy-oob{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if (((i_1 + n) > |$mem(z, x_1).DATA_meminst|) \/ ((i_2 + n) > |$mem(z, x_2).DATA_meminst|))

  ;; 8-reduction.watsup:949.1-952.14
  rule memory.copy-zero{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:954.1-959.19
  rule memory.copy-le{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) LOAD_admininstr(I32_numtype, ?((8, U_sx)), x_2, $memop0) STORE_admininstr(I32_numtype, ?(8), x_1, $memop0) CONST_admininstr(I32_numtype, (i_1 + 1)) CONST_admininstr(I32_numtype, (i_2 + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- if (i_1 <= i_2)

  ;; 8-reduction.watsup:961.1-965.15
  rule memory.copy-gt{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [CONST_admininstr(I32_numtype, ((i_1 + n) - 1)) CONST_admininstr(I32_numtype, ((i_2 + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), x_2, $memop0) STORE_admininstr(I32_numtype, ?(8), x_1, $memop0) CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr(x_1, x_2)])
    -- otherwise

  ;; 8-reduction.watsup:968.1-970.70
  rule memory.init-oob{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, y).DATA_datainst|) \/ ((j + n) > |$mem(z, x).DATA_meminst|))

  ;; 8-reduction.watsup:972.1-975.14
  rule memory.init-zero{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:977.1-981.15
  rule memory.init-succ{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, y).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), x, $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x, y)])
    -- otherwise

;; 8-reduction.watsup:5.1-5.63
relation Step: `%~>%`(config, config)
  ;; 8-reduction.watsup:10.1-12.34
  rule pure{z : state, instr* : instr*, instr'* : instr*}:
    `%~>%`(`%;%*`(z, (instr : instr <: admininstr)*{instr}), `%;%*`(z, (instr' : instr <: admininstr)*{instr'}))
    -- Step_pure: `%*_~>%*`((instr : instr <: admininstr)*{instr}, (instr' : instr <: admininstr)*{instr'})

  ;; 8-reduction.watsup:14.1-16.37
  rule read{z : state, instr* : instr*, instr'* : instr*}:
    `%~>%`(`%;%*`(z, (instr : instr <: admininstr)*{instr}), `%;%*`(z, (instr' : instr <: admininstr)*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, (instr : instr <: admininstr)*{instr}), (instr' : instr <: admininstr)*{instr'})

  ;; 8-reduction.watsup:313.1-316.61
  rule struct.new{z : state, val^n : val^n, n : n, x : idx, si : structinst, mut^n : mut^n, zt^n : storagetype^n}:
    `%~>%`(`%;%*`(z, (val : val <: admininstr)^n{val} :: [STRUCT.NEW_admininstr(x)]), `%;%*`($ext_structinst(z, [si]), [REF.STRUCT_ADDR_admininstr(|$structinst(z)|)]))
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)^n{mut zt}))
    -- if (si = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val zt}})

  ;; 8-reduction.watsup:333.1-334.53
  rule struct.set-null{z : state, ht : heaptype, val : val, x : idx, i : nat}:
    `%~>%`(`%;%*`(z, [REF.NULL_admininstr(ht) (val : val <: admininstr) STRUCT.SET_admininstr(x, i)]), `%;%*`(z, [TRAP_admininstr]))

  ;; 8-reduction.watsup:336.1-339.35
  rule struct.set-struct{z : state, a : addr, val : val, x : idx, i : nat, fv : fieldval, mut* : mut*, zt* : storagetype*}:
    `%~>%`(`%;%*`(z, [REF.STRUCT_ADDR_admininstr(a) (val : val <: admininstr) STRUCT.SET_admininstr(x, i)]), `%;%*`($with_struct(z, a, i, fv), []))
    -- Expand: `%~~%`($structinst(z)[a].TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- if (fv = $packval(zt*{zt}[i], val))

  ;; 8-reduction.watsup:352.1-355.61
  rule array.new_fixed{z : state, val^n : val^n, n : n, x : idx, ai : arrayinst, mut : mut, zt : storagetype}:
    `%~>%`(`%;%*`(z, (val : val <: admininstr)^n{val} :: [ARRAY.NEW_FIXED_admininstr(x, n)]), `%;%*`($ext_arrayinst(z, [ai]), [REF.ARRAY_ADDR_admininstr(|$arrayinst(z)|)]))
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (ai = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val}})

  ;; 8-reduction.watsup:399.1-400.64
  rule array.set-null{z : state, ht : heaptype, i : nat, val : val, x : idx}:
    `%~>%`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) (val : val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))

  ;; 8-reduction.watsup:402.1-404.38
  rule array.set-oob{z : state, a : addr, i : nat, val : val, x : idx}:
    `%~>%`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val : val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:406.1-409.31
  rule array.set-array{z : state, a : addr, i : nat, val : val, x : idx, fv : fieldval, mut : mut, zt : storagetype}:
    `%~>%`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val : val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`($with_array(z, a, i, fv), []))
    -- Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))
    -- if (fv = $packval(zt, val))

  ;; 8-reduction.watsup:701.1-702.56
  rule local.set{z : state, val : val, x : idx}:
    `%~>%`(`%;%*`(z, [(val : val <: admininstr) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 8-reduction.watsup:713.1-714.58
  rule global.set{z : state, val : val, x : idx}:
    `%~>%`(`%;%*`(z, [(val : val <: admininstr) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 8-reduction.watsup:727.1-729.33
  rule table.set-oob{z : state, i : nat, ref : ref, x : idx}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref : ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:731.1-733.32
  rule table.set-val{z : state, i : nat, ref : ref, x : idx}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref : ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:741.1-743.46
  rule table.grow-succeed{z : state, ref : ref, n : n, x : idx, ti : tableinst}:
    `%~>%`(`%;%*`(z, [(ref : ref <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if (ti = $growtable($table(z, x), n, ref))

  ;; 8-reduction.watsup:745.1-746.80
  rule table.grow-fail{z : state, ref : ref, n : n, x : idx}:
    `%~>%`(`%;%*`(z, [(ref : ref <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 : nat <: int)))]))

  ;; 8-reduction.watsup:804.1-805.51
  rule elem.drop{z : state, x : idx}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 8-reduction.watsup:880.1-882.59
  rule store-num-oob{z : state, i : nat, nt : numtype, c : num_(nt), x : idx, mo : memop}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), x, mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + (mo.OFFSET_memop : uN(32) <: nat)) + ($size((nt : numtype <: valtype)) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:884.1-886.28
  rule store-num-val{z : state, i : nat, nt : numtype, c : num_(nt), x : idx, mo : memop, b* : byte*}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), x, mo)]), `%;%*`($with_mem(z, x, (i + (mo.OFFSET_memop : uN(32) <: nat)), ($size((nt : numtype <: valtype)) / 8), b*{b}), []))
    -- if (b*{b} = $nbytes(nt, c))

  ;; 8-reduction.watsup:888.1-890.51
  rule store-pack-oob{z : state, i : nat, inn : inn, c : num_((inn : inn <: numtype)), nt : numtype, n : n, x : idx, mo : memop}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr((inn : inn <: numtype), c) STORE_admininstr(nt, ?(n), x, mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + (mo.OFFSET_memop : uN(32) <: nat)) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:892.1-894.49
  rule store-pack-val{z : state, i : nat, inn : inn, c : num_((inn : inn <: numtype)), nt : numtype, n : n, x : idx, mo : memop, b* : byte*}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr((inn : inn <: numtype), c) STORE_admininstr(nt, ?(n), x, mo)]), `%;%*`($with_mem(z, x, (i + (mo.OFFSET_memop : uN(32) <: nat)), (n / 8), b*{b}), []))
    -- if (b*{b} = $ibytes(n, $wrap($size((inn : inn <: valtype)), n, c)))

  ;; 8-reduction.watsup:896.1-898.61
  rule vstore-oob{z : state, i : nat, c : vec_(V128_vnn), x : idx, mo : memop}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VCONST_admininstr(V128_vectype, c) VSTORE_admininstr(x, mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + (mo.OFFSET_memop : uN(32) <: nat)) + ($size(V128_valtype) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:900.1-902.30
  rule vstore-val{z : state, i : nat, c : vec_(V128_vnn), x : idx, mo : memop, b* : byte*}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VCONST_admininstr(V128_vectype, c) VSTORE_admininstr(x, mo)]), `%;%*`($with_mem(z, x, (i + (mo.OFFSET_memop : uN(32) <: nat)), ($size(V128_valtype) / 8), b*{b}), []))
    -- if (b*{b} = $vbytes(V128_vectype, c))

  ;; 8-reduction.watsup:905.1-907.49
  rule vstore_lane-oob{z : state, i : nat, c : vec_(V128_vnn), N : N, x : idx, mo : memop, j : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VCONST_admininstr(V128_vectype, c) VSTORE_LANE_admininstr(N, x, mo, j)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + (mo.OFFSET_memop : uN(32) <: nat)) + N) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:909.1-913.48
  rule vstore_lane-val{z : state, i : nat, c : vec_(V128_vnn), N : N, x : idx, mo : memop, j : nat, b* : byte*, imm : imm, M : M}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) VCONST_admininstr(V128_vectype, c) VSTORE_LANE_admininstr(N, x, mo, j)]), `%;%*`($with_mem(z, x, (i + (mo.OFFSET_memop : uN(32) <: nat)), (N / 8), b*{b}), []))
    -- if (N = $lsize((imm : imm <: lanetype)))
    -- if (M = (128 / N))
    -- if (b*{b} = $ibytes(N, $lanes_(`%X%`((imm : imm <: lanetype), M), c)[j]))

  ;; 8-reduction.watsup:921.1-923.40
  rule memory.grow-succeed{z : state, n : n, x : idx, mi : meminst}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr(x)]), `%;%*`($with_meminst(z, x, mi), [CONST_admininstr(I32_numtype, (|$mem(z, x).DATA_meminst| / (64 * $Ki)))]))
    -- if (mi = $growmemory($mem(z, x), n))

  ;; 8-reduction.watsup:925.1-926.77
  rule memory.grow-fail{z : state, n : n, x : idx}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 : nat <: int)))]))

  ;; 8-reduction.watsup:984.1-985.51
  rule data.drop{z : state, x : idx}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 8-reduction.watsup:8.1-8.63
rec {

;; 8-reduction.watsup:8.1-8.63
relation Steps: `%~>*%`(config, config)
  ;; 8-reduction.watsup:18.1-19.36
  rule refl{z : state, admininstr* : admininstr*}:
    `%~>*%`(`%;%*`(z, admininstr*{admininstr}), `%;%*`(z, admininstr*{admininstr}))

  ;; 8-reduction.watsup:21.1-24.53
  rule trans{z : state, admininstr* : admininstr*, z'' : state, admininstr''* : admininstr*, z' : state, admininstr' : admininstr}:
    `%~>*%`(`%;%*`(z, admininstr*{admininstr}), `%;%*`(z'', admininstr''*{admininstr''}))
    -- Step: `%~>%`(`%;%*`(z, admininstr*{admininstr}), `%;%*`(z', admininstr'*{}))
    -- Steps: `%~>*%`(`%;%*`(z', [admininstr']), `%;%*`(z'', admininstr''*{admininstr''}))
}

;; 8-reduction.watsup:29.1-29.69
relation Eval_expr: `%;%~>*%;%*`(state, expr, state, val*)
  ;; 8-reduction.watsup:31.1-33.37
  rule _{z : state, instr* : instr*, z' : state, val* : val*}:
    `%;%~>*%;%*`(z, instr*{instr}, z', val*{val})
    -- Steps: `%~>*%`(`%;%*`(z, (instr : instr <: admininstr)*{instr}), `%;%*`(z', (val : val <: admininstr)*{val}))

;; 9-module.watsup:7.1-7.34
rec {

;; 9-module.watsup:7.1-7.34
def $alloctypes(type*) : deftype*
  ;; 9-module.watsup:8.1-8.27
  def $alloctypes([]) = []
  ;; 9-module.watsup:9.1-13.24
  def $alloctypes{type'* : type*, type : type, deftype'* : deftype*, deftype* : deftype*, rectype : rectype, x : idx}(type'*{type'} :: [type]) = deftype'*{deftype'} :: deftype*{deftype}
    -- if (deftype'*{deftype'} = $alloctypes(type'*{type'}))
    -- if (type = TYPE(rectype))
    -- if (deftype*{deftype} = $subst_all_deftypes($rolldt(x, rectype), (deftype' : deftype <: heaptype)*{deftype'}))
    -- if (x = |deftype'*{deftype'}|)
}

;; 9-module.watsup:15.1-15.60
def $allocfunc(store : store, moduleinst : moduleinst, func : func) : (store, funcaddr)
  ;; 9-module.watsup:16.1-18.55
  def $allocfunc{s : store, mm : moduleinst, func : func, fi : funcinst, x : idx, local* : local*, expr : expr}(s, mm, func) = (s[FUNC_store =.. [fi]], |s.FUNC_store|)
    -- if (func = `FUNC%%*%`(x, local*{local}, expr))
    -- if (fi = {TYPE mm.TYPE_moduleinst[(x : uN(32) <: nat)], MODULE mm, CODE func})

;; 9-module.watsup:20.1-20.63
rec {

;; 9-module.watsup:20.1-20.63
def $allocfuncs(store : store, moduleinst : moduleinst, func*) : (store, funcaddr*)
  ;; 9-module.watsup:21.1-21.39
  def $allocfuncs{s : store, mm : moduleinst}(s, mm, []) = (s, [])
  ;; 9-module.watsup:22.1-24.51
  def $allocfuncs{s : store, mm : moduleinst, func : func, func'* : func*, s_2 : store, fa : funcaddr, fa'* : funcaddr*, s_1 : store}(s, mm, [func] :: func'*{func'}) = (s_2, [fa] :: fa'*{fa'})
    -- if ((s_1, fa) = $allocfunc(s, mm, func))
    -- if ((s_2, fa'*{fa'}) = $allocfuncs(s_1, mm, func'*{func'}))
}

;; 9-module.watsup:26.1-26.63
def $allocglobal(store : store, globaltype : globaltype, val : val) : (store, globaladdr)
  ;; 9-module.watsup:27.1-28.44
  def $allocglobal{s : store, globaltype : globaltype, val : val, gi : globalinst}(s, globaltype, val) = (s[GLOBAL_store =.. [gi]], |s.GLOBAL_store|)
    -- if (gi = {TYPE globaltype, VALUE val})

;; 9-module.watsup:30.1-30.67
rec {

;; 9-module.watsup:30.1-30.67
def $allocglobals(store : store, globaltype*, val*) : (store, globaladdr*)
  ;; 9-module.watsup:31.1-31.42
  def $allocglobals{s : store}(s, [], []) = (s, [])
  ;; 9-module.watsup:32.1-34.62
  def $allocglobals{s : store, globaltype : globaltype, globaltype'* : globaltype*, val : val, val'* : val*, s_2 : store, ga : globaladdr, ga'* : globaladdr*, s_1 : store}(s, [globaltype] :: globaltype'*{globaltype'}, [val] :: val'*{val'}) = (s_2, [ga] :: ga'*{ga'})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga'}) = $allocglobals(s_1, globaltype'*{globaltype'}, val'*{val'}))
}

;; 9-module.watsup:36.1-36.60
def $alloctable(store : store, tabletype : tabletype, ref : ref) : (store, tableaddr)
  ;; 9-module.watsup:37.1-38.49
  def $alloctable{s : store, i : nat, j : nat, rt : reftype, ref : ref, ti : tableinst}(s, `%%`(`[%..%]`(i, j), rt), ref) = (s[TABLE_store =.. [ti]], |s.TABLE_store|)
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM ref^i{}})

;; 9-module.watsup:40.1-40.64
rec {

;; 9-module.watsup:40.1-40.64
def $alloctables(store : store, tabletype*, ref*) : (store, tableaddr*)
  ;; 9-module.watsup:41.1-41.41
  def $alloctables{s : store}(s, [], []) = (s, [])
  ;; 9-module.watsup:42.1-44.60
  def $alloctables{s : store, tabletype : tabletype, tabletype'* : tabletype*, ref : ref, ref'* : ref*, s_2 : store, ta : tableaddr, ta'* : tableaddr*, s_1 : store}(s, [tabletype] :: tabletype'*{tabletype'}, [ref] :: ref'*{ref'}) = (s_2, [ta] :: ta'*{ta'})
    -- if ((s_1, ta) = $alloctable(s, tabletype, ref))
    -- if ((s_2, ta'*{ta'}) = $alloctables(s_1, tabletype'*{tabletype'}, ref'*{ref'}))
}

;; 9-module.watsup:46.1-46.49
def $allocmem(store : store, memtype : memtype) : (store, memaddr)
  ;; 9-module.watsup:47.1-48.62
  def $allocmem{s : store, i : nat, j : nat, mi : meminst}(s, `%I8`(`[%..%]`(i, j))) = (s[MEM_store =.. [mi]], |s.MEM_store|)
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA 0^((i * 64) * $Ki){}})

;; 9-module.watsup:50.1-50.52
rec {

;; 9-module.watsup:50.1-50.52
def $allocmems(store : store, memtype*) : (store, memaddr*)
  ;; 9-module.watsup:51.1-51.34
  def $allocmems{s : store}(s, []) = (s, [])
  ;; 9-module.watsup:52.1-54.49
  def $allocmems{s : store, memtype : memtype, memtype'* : memtype*, s_2 : store, ma : memaddr, ma'* : memaddr*, s_1 : store}(s, [memtype] :: memtype'*{memtype'}) = (s_2, [ma] :: ma'*{ma'})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma'}) = $allocmems(s_1, memtype'*{memtype'}))
}

;; 9-module.watsup:56.1-56.57
def $allocelem(store : store, reftype : reftype, ref*) : (store, elemaddr)
  ;; 9-module.watsup:57.1-58.36
  def $allocelem{s : store, rt : reftype, ref* : ref*, ei : eleminst}(s, rt, ref*{ref}) = (s[ELEM_store =.. [ei]], |s.ELEM_store|)
    -- if (ei = {TYPE rt, ELEM ref*{ref}})

;; 9-module.watsup:60.1-60.63
rec {

;; 9-module.watsup:60.1-60.63
def $allocelems(store : store, reftype*, ref**) : (store, elemaddr*)
  ;; 9-module.watsup:61.1-61.40
  def $allocelems{s : store}(s, [], []) = (s, [])
  ;; 9-module.watsup:62.1-64.55
  def $allocelems{s : store, rt : reftype, rt'* : reftype*, ref* : ref*, ref'** : ref**, s_2 : store, ea : elemaddr, ea'* : elemaddr*, s_1 : store}(s, [rt] :: rt'*{rt'}, [ref*{ref}] :: ref'*{ref'}*{ref'}) = (s_2, [ea] :: ea'*{ea'})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref}))
    -- if ((s_2, ea'*{ea'}) = $allocelems(s_2, rt'*{rt'}, ref'*{ref'}*{ref'}))
}

;; 9-module.watsup:66.1-66.49
def $allocdata(store : store, byte*) : (store, dataaddr)
  ;; 9-module.watsup:67.1-68.28
  def $allocdata{s : store, byte* : byte*, di : datainst}(s, byte*{byte}) = (s[DATA_store =.. [di]], |s.DATA_store|)
    -- if (di = {DATA byte*{byte}})

;; 9-module.watsup:70.1-70.54
rec {

;; 9-module.watsup:70.1-70.54
def $allocdatas(store : store, byte**) : (store, dataaddr*)
  ;; 9-module.watsup:71.1-71.35
  def $allocdatas{s : store}(s, []) = (s, [])
  ;; 9-module.watsup:72.1-74.50
  def $allocdatas{s : store, byte* : byte*, byte'** : byte**, s_2 : store, da : dataaddr, da'* : dataaddr*, s_1 : store}(s, [byte*{byte}] :: byte'*{byte'}*{byte'}) = (s_2, [da] :: da'*{da'})
    -- if ((s_1, da) = $allocdata(s, byte*{byte}))
    -- if ((s_2, da'*{da'}) = $allocdatas(s_1, byte'*{byte'}*{byte'}))
}

;; 9-module.watsup:79.1-79.83
def $instexport(funcaddr*, globaladdr*, tableaddr*, memaddr*, export : export) : exportinst
  ;; 9-module.watsup:80.1-80.95
  def $instexport{fa* : funcaddr*, ga* : globaladdr*, ta* : tableaddr*, ma* : memaddr*, name : name, x : idx}(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, FUNC_externidx(x))) = {NAME name, VALUE FUNC_externval(fa*{fa}[(x : uN(32) <: nat)])}
  ;; 9-module.watsup:81.1-81.99
  def $instexport{fa* : funcaddr*, ga* : globaladdr*, ta* : tableaddr*, ma* : memaddr*, name : name, x : idx}(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, GLOBAL_externidx(x))) = {NAME name, VALUE GLOBAL_externval(ga*{ga}[(x : uN(32) <: nat)])}
  ;; 9-module.watsup:82.1-82.97
  def $instexport{fa* : funcaddr*, ga* : globaladdr*, ta* : tableaddr*, ma* : memaddr*, name : name, x : idx}(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, TABLE_externidx(x))) = {NAME name, VALUE TABLE_externval(ta*{ta}[(x : uN(32) <: nat)])}
  ;; 9-module.watsup:83.1-83.93
  def $instexport{fa* : funcaddr*, ga* : globaladdr*, ta* : tableaddr*, ma* : memaddr*, name : name, x : idx}(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, MEM_externidx(x))) = {NAME name, VALUE MEM_externval(ma*{ma}[(x : uN(32) <: nat)])}

;; 9-module.watsup:86.1-86.87
def $allocmodule(store : store, module : module, externval*, val*, ref*, ref**) : (store, moduleinst)
  ;; 9-module.watsup:87.1-127.51
  def $allocmodule{s : store, module : module, externval* : externval*, val_g* : val*, ref_t* : ref*, ref_e** : ref**, s_6 : store, mm : moduleinst, type* : type*, import* : import*, func^n_f : func^n_f, n_f : n, globaltype^n_g : globaltype^n_g, expr_g^n_g : expr^n_g, n_g : n, tabletype^n_t : tabletype^n_t, expr_t^n_t : expr^n_t, n_t : n, memtype^n_m : memtype^n_m, n_m : n, reftype^n_e : reftype^n_e, expr_e*^n_e : expr*^n_e, elemmode^n_e : elemmode^n_e, n_e : n, byte*^n_d : byte*^n_d, datamode^n_d : datamode^n_d, n_d : n, start? : start?, export* : export*, fa_ex* : funcaddr*, ga_ex* : globaladdr*, ta_ex* : tableaddr*, ma_ex* : memaddr*, fa* : funcaddr*, i_f^n_f : nat^n_f, ga* : globaladdr*, i_g^n_g : nat^n_g, ta* : tableaddr*, i_t^n_t : nat^n_t, ma* : memaddr*, i_m^n_m : nat^n_m, ea* : elemaddr*, i_e^n_e : nat^n_e, da* : dataaddr*, i_d^n_d : nat^n_d, xi* : exportinst*, dt* : deftype*, s_1 : store, s_2 : store, s_3 : store, s_4 : store, s_5 : store}(s, module, externval*{externval}, val_g*{val_g}, ref_t*{ref_t}, ref_e*{ref_e}*{ref_e}) = (s_6, mm)
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

;; 9-module.watsup:134.1-134.33
def $runelem(elem : elem, idx : idx) : instr*
  ;; 9-module.watsup:135.1-135.52
  def $runelem{reftype : reftype, expr* : expr*, y : idx}(`ELEM%%*%`(reftype, expr*{expr}, PASSIVE_elemmode), y) = []
  ;; 9-module.watsup:136.1-136.62
  def $runelem{reftype : reftype, expr* : expr*, y : idx}(`ELEM%%*%`(reftype, expr*{expr}, DECLARE_elemmode), y) = [ELEM.DROP_instr(y)]
  ;; 9-module.watsup:137.1-138.77
  def $runelem{reftype : reftype, expr* : expr*, x : idx, instr* : instr*, y : idx}(`ELEM%%*%`(reftype, expr*{expr}, ACTIVE_elemmode(x, instr*{instr})), y) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, |expr*{expr}|) TABLE.INIT_instr(x, y) ELEM.DROP_instr(y)]

;; 9-module.watsup:140.1-140.33
def $rundata(data : data, idx : idx) : instr*
  ;; 9-module.watsup:141.1-141.44
  def $rundata{byte* : byte*, y : idx}(`DATA%*%`(byte*{byte}, PASSIVE_datamode), y) = []
  ;; 9-module.watsup:142.1-143.78
  def $rundata{byte* : byte*, x : idx, instr* : instr*, y : idx}(`DATA%*%`(byte*{byte}, ACTIVE_datamode(x, instr*{instr})), y) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, |byte*{byte}|) MEMORY.INIT_instr(x, y) DATA.DROP_instr(y)]

;; 9-module.watsup:145.1-145.53
def $instantiate(store : store, module : module, externval*) : config
  ;; 9-module.watsup:146.1-167.66
  def $instantiate{s : store, module : module, externval* : externval*, s' : store, f : frame, instr_E* : instr*, instr_D* : instr*, x? : idx?, type* : type*, import* : import*, func* : func*, global* : global*, table* : table*, mem* : mem*, elem* : elem*, data* : data*, start? : start?, export* : export*, globaltype* : globaltype*, expr_G* : expr*, tabletype* : tabletype*, expr_T* : expr*, reftype* : reftype*, expr_E** : expr**, elemmode* : elemmode*, n_F : n, n_E : n, n_D : n, mm_init : moduleinst, i_F^n_F : nat^n_F, z : state, val_G* : val*, ref_T* : ref*, ref_E** : ref**, mm : moduleinst, i^n_E : nat^n_E, j^n_D : nat^n_D}(s, module, externval*{externval}) = `%;%*`(`%;%`(s', f), (instr_E : instr <: admininstr)*{instr_E} :: (instr_D : instr <: admininstr)*{instr_D} :: CALL_admininstr(x)?{x})
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
    -- (Eval_expr: `%;%~>*%;%*`(z, expr_T, z, [(ref_T : ref <: val)]))*{expr_T ref_T}
    -- (Eval_expr: `%;%~>*%;%*`(z, expr_E, z, [(ref_E : ref <: val)]))*{expr_E ref_E}*{expr_E ref_E}
    -- if ((s', mm) = $allocmodule(s, module, externval*{externval}, val_G*{val_G}, ref_T*{ref_T}, ref_E*{ref_E}*{ref_E}))
    -- if (f = {LOCAL [], MODULE mm})
    -- if (instr_E*{instr_E} = $concat_(syntax instr, $runelem(elem*{elem}[i], i)^(i<n_E){i}))
    -- if (instr_D*{instr_D} = $concat_(syntax instr, $rundata(data*{data}[j], j)^(j<n_D){j}))

;; 9-module.watsup:174.1-174.44
def $invoke(store : store, funcaddr : funcaddr, val*) : config
  ;; 9-module.watsup:175.1-178.53
  def $invoke{s : store, fa : funcaddr, val^n : val^n, n : n, f : frame, x : idx, local* : local*, expr : expr, t_1^n : valtype^n, t_2* : valtype*}(s, fa, val^n{val}) = `%;%*`(`%;%`(s, f), (val : val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(fa) CALL_REF_admininstr(?(0))])
    -- if (f = {LOCAL [], MODULE {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []}})
    -- if ($funcinst(`%;%`(s, f))[fa].CODE_funcinst = `FUNC%%*%`(x, local*{local}, expr))
    -- Expand: `%~~%`(s.FUNC_store[fa].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2*{t_2})))

;; A-binary.watsup:49.1-49.24
rec {

;; A-binary.watsup:49.1-49.24
def $utf8(name : name) : byte*
  ;; A-binary.watsup:50.1-50.47
  def $utf8{ch : nat, b : byte}([ch]) = [b]
    -- if ((ch < 128) /\ (ch = (b : byte <: nat)))
  ;; A-binary.watsup:51.1-51.96
  def $utf8{ch : nat, b_1 : byte, b_2 : byte}([ch]) = [b_1 b_2]
    -- if (((128 <= ch) /\ (ch < 2048)) /\ (ch = (((2 ^ 6) * ((b_1 : byte <: nat) - 192)) + ((b_2 : byte <: nat) - 128))))
  ;; A-binary.watsup:52.1-52.148
  def $utf8{ch : nat, b_1 : byte, b_2 : byte, b_3 : byte}([ch]) = [b_1 b_2 b_3]
    -- if ((((2048 <= ch) /\ (ch < 55296)) \/ ((57344 <= ch) /\ (ch < 65536))) /\ (ch = ((((2 ^ 12) * ((b_1 : byte <: nat) - 224)) + ((2 ^ 6) * ((b_2 : byte <: nat) - 128))) + ((b_3 : byte <: nat) - 128))))
  ;; A-binary.watsup:53.1-53.148
  def $utf8{ch : nat, b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte}([ch]) = [b_1 b_2 b_3 b_4]
    -- if (((65536 <= ch) /\ (ch < 69632)) /\ (ch = (((((2 ^ 18) * ((b_1 : byte <: nat) - 240)) + ((2 ^ 12) * ((b_2 : byte <: nat) - 128))) + ((2 ^ 6) * ((b_3 : byte <: nat) - 128))) + ((b_4 : byte <: nat) - 128))))
  ;; A-binary.watsup:54.1-54.44
  def $utf8{ch* : nat*}(ch*{ch}) = $concat_(syntax byte, $utf8([ch])*{ch})
}

;; A-binary.watsup:212.1-212.27
syntax castop = (nul, nul)

;; A-binary.watsup:305.1-305.34
syntax memidxop = (memidx, memop)

;; A-binary.watsup:961.1-961.29
syntax code = (local*, expr)

;; C-conventions.watsup:7.1-7.15
syntax A = nat

;; C-conventions.watsup:8.1-8.15
syntax B = nat

;; C-conventions.watsup:10.1-10.62
syntax sym =
  | _FIRST(A_1 : A)
  | _DOTS
  | _LAST(A_n : A)

;; C-conventions.watsup:12.1-12.51
syntax symsplit =
  | _FIRST(A_1 : A)
  | _LAST(A_2 : A)

;; C-conventions.watsup:14.1-14.41
syntax recorddots = `...`

;; C-conventions.watsup:15.1-18.36
syntax record =
{
  FIELD_1 A,
  FIELD_2 A,
  DOTS recorddots
}

;; C-conventions.watsup:20.1-23.36
syntax recordstar =
{
  FIELD_1 A*,
  FIELD_2 A*,
  DOTS recorddots
}

;; C-conventions.watsup:25.1-25.58
syntax recordeq = `%++%=%`(recordstar, recordstar, recordstar)

;; C-conventions.watsup:27.1-27.56
syntax pth =
  | PTHSYNTAX

;; C-conventions.watsup:29.1-34.4
syntax pthaux =
{
  PTH (),
  I_PTH (),
  FIELD_PTH (),
  DOT_FIELD_PTH ()
}

== IL Validation...
== Complete.
```
