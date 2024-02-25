# Test

```sh
$ (../src/exe-watsup/main.exe test.watsup -o test.tex && cat test.tex)
cat: test.tex: No such file or directory
[1]
```


# Preview

```sh
$ (cd ../spec/wasm-3.0 && ../../src/exe-watsup/main.exe *.watsup -v -l --print-il --print-no-pos --check)
watsup 0.4 generator
== Parsing...
== Elaboration...

;; 0-aux.watsup
syntax N = nat

;; 0-aux.watsup
syntax M = nat

;; 0-aux.watsup
syntax n = nat

;; 0-aux.watsup
syntax m = nat

;; 0-aux.watsup
def $Ki : nat
  ;; 0-aux.watsup
  def $Ki = 1024

;; 0-aux.watsup
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

;; 0-aux.watsup
rec {

;; 0-aux.watsup:32.1-32.21
def $sum(nat*) : nat
  ;; 0-aux.watsup:33.1-33.18
  def $sum([]) = 0
  ;; 0-aux.watsup:34.1-34.35
  def $sum{n : n, n'* : n*}([n] :: n'*{n'}) = (n + $sum(n'*{n'}))
}

;; 0-aux.watsup
rec {

;; 0-aux.watsup:39.1-39.59
def $concat_(syntax X, X**) : X*
  ;; 0-aux.watsup:40.1-40.34
  def $concat_{syntax X}(syntax X, []) = []
  ;; 0-aux.watsup:41.1-41.61
  def $concat_{syntax X, w* : X*, w'** : X**}(syntax X, [w*{w}] :: w'*{w'}*{w'}) = w*{w} :: $concat_(syntax X, w'*{w'}*{w'})
}

;; 1-syntax.watsup
syntax list{syntax X}(syntax X) = X*

;; 1-syntax.watsup
syntax char = `%`{i : nat}(i : nat)
    -- if (((i >= 0) /\ (i <= 55295)) \/ ((i >= 57344) /\ (i <= 1114111)))

;; 1-syntax.watsup
syntax name = char*

;; 1-syntax.watsup
syntax bit = `%`{i : nat}(i : nat)
    -- if ((i = 0) \/ (i = 1))

;; 1-syntax.watsup
syntax byte = `%`{i : nat}(i : nat)
    -- if ((i >= 0) /\ (i <= 255))

;; 1-syntax.watsup
syntax uN{N : N}(N) = `%`{i : nat}(i : nat)
    -- if ((i >= 0) /\ (i <= ((2 ^ N) - 1)))

;; 1-syntax.watsup
syntax sN{N : N}(N) = `%`{i : int}(i : int)
    -- if ((((i >= - ((2 ^ (N - 1)) : nat <: int)) /\ (i <= - (1 : nat <: int))) \/ (i = (0 : nat <: int))) \/ ((i >= + (1 : nat <: int)) /\ (i <= (((2 ^ (N - 1)) - 1) : nat <: int))))

;; 1-syntax.watsup
syntax iN{N : N}(N) = uN(N)

;; 1-syntax.watsup
syntax u8 = uN(8)

;; 1-syntax.watsup
syntax u16 = uN(16)

;; 1-syntax.watsup
syntax u31 = uN(31)

;; 1-syntax.watsup
syntax u32 = uN(32)

;; 1-syntax.watsup
syntax u64 = uN(64)

;; 1-syntax.watsup
syntax u128 = uN(128)

;; 1-syntax.watsup
syntax s33 = sN(33)

;; 1-syntax.watsup
def $signif(N : N) : nat
  ;; 1-syntax.watsup
  def $signif(32) = 23
  ;; 1-syntax.watsup
  def $signif(64) = 52

;; 1-syntax.watsup
def $expon(N : N) : nat
  ;; 1-syntax.watsup
  def $expon(32) = 8
  ;; 1-syntax.watsup
  def $expon(64) = 11

;; 1-syntax.watsup
def $M(N : N) : nat
  ;; 1-syntax.watsup
  def $M{N : N}(N) = $signif(N)

;; 1-syntax.watsup
def $E(N : N) : nat
  ;; 1-syntax.watsup
  def $E{N : N}(N) = $expon(N)

;; 1-syntax.watsup
syntax fNmag{N : N}(N) =
  | NORM{m : m, n : n}(m : m, n : n)
    -- if ((m < (2 ^ $M(N))) /\ (((2 - (2 ^ ($E(N) - 1))) <= n) /\ (n <= ((2 ^ ($E(N) - 1)) - 1))))
  | SUBNORM{m : m, N : N, n : n}(m : m)
    -- if ((m < (2 ^ $M(N))) /\ ((2 - (2 ^ ($E(N) - 1))) = n))
  | INF
  | NAN{m : m}(m : m)
    -- if ((1 <= m) /\ (m < (2 ^ $M(N))))

;; 1-syntax.watsup
syntax fN{N : N}(N) =
  | POS(fNmag : fNmag(N))
  | NEG(fNmag : fNmag(N))

;; 1-syntax.watsup
syntax f32 = fN(32)

;; 1-syntax.watsup
syntax f64 = fN(64)

;; 1-syntax.watsup
def $fzero(N : N) : fN(N)
  ;; 1-syntax.watsup
  def $fzero{N : N}(N) = POS_fN(N)(SUBNORM_fNmag(N)(0))

;; 1-syntax.watsup
def $fone(N : N) : fN(N)
  ;; 1-syntax.watsup
  def $fone{N : N}(N) = POS_fN(N)(NORM_fNmag(N)(1, 0))

;; 1-syntax.watsup
def $canon_(N : N) : nat
  ;; 1-syntax.watsup
  def $canon_{N : N}(N) = (2 ^ ($signif(N) - 1))

;; 1-syntax.watsup
syntax vN{N : N}(N) = iN(N)

;; 1-syntax.watsup
syntax idx = u32

;; 1-syntax.watsup
syntax laneidx = u8

;; 1-syntax.watsup
syntax typeidx = idx

;; 1-syntax.watsup
syntax funcidx = idx

;; 1-syntax.watsup
syntax globalidx = idx

;; 1-syntax.watsup
syntax tableidx = idx

;; 1-syntax.watsup
syntax memidx = idx

;; 1-syntax.watsup
syntax elemidx = idx

;; 1-syntax.watsup
syntax dataidx = idx

;; 1-syntax.watsup
syntax labelidx = idx

;; 1-syntax.watsup
syntax localidx = idx

;; 1-syntax.watsup
syntax nul = `NULL%?`(()?)

;; 1-syntax.watsup
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup
syntax vectype =
  | V128

;; 1-syntax.watsup
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

;; 1-syntax.watsup
syntax mut = `MUT%?`(()?)

;; 1-syntax.watsup
syntax fin = `FINAL%?`(()?)

;; 1-syntax.watsup
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
syntax fieldtype = `%%`(mut : mut, storagetype : storagetype)

;; 1-syntax.watsup:178.1-178.70
syntax functype = `%->%`(resulttype : resulttype, resulttype : resulttype)

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
  | DEF(rectype : rectype, nat : nat)
  | REC(n : n)
}

;; 1-syntax.watsup
syntax reftype =
  | REF(nul : nul, heaptype : heaptype)

;; 1-syntax.watsup
syntax inn =
  | I32
  | I64

;; 1-syntax.watsup
syntax fnn =
  | F32
  | F64

;; 1-syntax.watsup
syntax vnn =
  | V128

;; 1-syntax.watsup
syntax packtype =
  | I8
  | I16

;; 1-syntax.watsup
syntax lanetype =
  | I32
  | I64
  | F32
  | F64
  | I8
  | I16

;; 1-syntax.watsup
syntax pnn =
  | I8
  | I16

;; 1-syntax.watsup
syntax lnn =
  | I32
  | I64
  | F32
  | F64
  | I8
  | I16

;; 1-syntax.watsup
syntax imm =
  | I32
  | I64
  | I8
  | I16

;; 1-syntax.watsup
syntax deftype =
  | DEF(rectype : rectype, nat : nat)

;; 1-syntax.watsup
syntax limits = `[%..%]`(u32 : u32, u32 : u32)

;; 1-syntax.watsup
syntax globaltype = `%%`(mut : mut, valtype : valtype)

;; 1-syntax.watsup
syntax tabletype = `%%`(limits : limits, reftype : reftype)

;; 1-syntax.watsup
syntax memtype = `%I8`(limits : limits)

;; 1-syntax.watsup
syntax elemtype = reftype

;; 1-syntax.watsup
syntax datatype = OK

;; 1-syntax.watsup
syntax externtype =
  | FUNC(deftype : deftype)
  | GLOBAL(globaltype : globaltype)
  | TABLE(tabletype : tabletype)
  | MEM(memtype : memtype)

;; 1-syntax.watsup
def $size(numtype : numtype) : nat
  ;; 2-syntax-aux.watsup
  def $size(I32_numtype) = 32
  ;; 2-syntax-aux.watsup
  def $size(I64_numtype) = 64
  ;; 2-syntax-aux.watsup
  def $size(F32_numtype) = 32
  ;; 2-syntax-aux.watsup
  def $size(F64_numtype) = 64

;; 1-syntax.watsup
def $vsize(vectype : vectype) : nat
  ;; 2-syntax-aux.watsup
  def $vsize(V128_vectype) = 128

;; 1-syntax.watsup
def $psize(packtype : packtype) : nat
  ;; 2-syntax-aux.watsup
  def $psize(I8_packtype) = 8
  ;; 2-syntax-aux.watsup
  def $psize(I16_packtype) = 16

;; 1-syntax.watsup
def $lsize(lanetype : lanetype) : nat
  ;; 2-syntax-aux.watsup
  def $lsize{numtype : numtype}((numtype : numtype <: lanetype)) = $size(numtype)
  ;; 2-syntax-aux.watsup
  def $lsize{packtype : packtype}((packtype : packtype <: lanetype)) = $psize(packtype)

;; 1-syntax.watsup
def $zsize(storagetype : storagetype) : nat
  ;; 2-syntax-aux.watsup
  def $zsize{numtype : numtype}((numtype : numtype <: storagetype)) = $size(numtype)
  ;; 2-syntax-aux.watsup
  def $zsize{vectype : vectype}((vectype : vectype <: storagetype)) = $vsize(vectype)
  ;; 2-syntax-aux.watsup
  def $zsize{packtype : packtype}((packtype : packtype <: storagetype)) = $psize(packtype)

;; 1-syntax.watsup
syntax dim = `%`{i : nat}(i : nat)
    -- if (((((i = 1) \/ (i = 2)) \/ (i = 4)) \/ (i = 8)) \/ (i = 16))

;; 1-syntax.watsup
syntax shape = `%X%`(lanetype : lanetype, dim : dim)

;; 1-syntax.watsup
def $lanetype(shape : shape) : lanetype
  ;; 2-syntax-aux.watsup
  def $lanetype{lnn : lnn, N : N}(`%X%`(lnn, `%`(N))) = lnn

;; 1-syntax.watsup
def $sizenn(numtype : numtype) : nat
  ;; 1-syntax.watsup
  def $sizenn{nt : numtype}(nt) = $size(nt)

;; 1-syntax.watsup
syntax num_(numtype : numtype)
  ;; 1-syntax.watsup
  syntax num_{inn : inn}((inn : inn <: numtype)) = iN($sizenn((inn : inn <: numtype)))


  ;; 1-syntax.watsup
  syntax num_{fnn : fnn}((fnn : fnn <: numtype)) = fN($sizenn((fnn : fnn <: numtype)))


;; 1-syntax.watsup
syntax pack_{pnn : pnn}(pnn) = iN($psize(pnn))

;; 1-syntax.watsup
syntax lane_(lanetype : lanetype)
  ;; 1-syntax.watsup
  syntax lane_{numtype : numtype}((numtype : numtype <: lanetype)) = num_(numtype)


  ;; 1-syntax.watsup
  syntax lane_{packtype : packtype}((packtype : packtype <: lanetype)) = pack_(packtype)


  ;; 1-syntax.watsup
  syntax lane_{imm : imm}((imm : imm <: lanetype)) = iN($lsize((imm : imm <: lanetype)))


;; 1-syntax.watsup
syntax vec_{vnn : vnn}(vnn) = vN($vsize(vnn))

;; 1-syntax.watsup
syntax zval_(storagetype : storagetype)
  ;; 1-syntax.watsup
  syntax zval_{numtype : numtype}((numtype : numtype <: storagetype)) = num_(numtype)


  ;; 1-syntax.watsup
  syntax zval_{vectype : vectype}((vectype : vectype <: storagetype)) = vec_(vectype)


  ;; 1-syntax.watsup
  syntax zval_{packtype : packtype}((packtype : packtype <: storagetype)) = pack_(packtype)


;; 1-syntax.watsup
syntax sx =
  | U
  | S

;; 1-syntax.watsup
syntax unop_(numtype : numtype)
  ;; 1-syntax.watsup
  syntax unop_{inn : inn}((inn : inn <: numtype)) =
  | CLZ
  | CTZ
  | POPCNT
  | EXTEND(n : n)


  ;; 1-syntax.watsup
  syntax unop_{fnn : fnn}((fnn : fnn <: numtype)) =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST


;; 1-syntax.watsup
syntax binop_(numtype : numtype)
  ;; 1-syntax.watsup
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


  ;; 1-syntax.watsup
  syntax binop_{fnn : fnn}((fnn : fnn <: numtype)) =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN


;; 1-syntax.watsup
syntax testop_{inn : inn}((inn : inn <: numtype)) =
  | EQZ

;; 1-syntax.watsup
syntax relop_(numtype : numtype)
  ;; 1-syntax.watsup
  syntax relop_{inn : inn}((inn : inn <: numtype)) =
  | EQ
  | NE
  | LT(sx : sx)
  | GT(sx : sx)
  | LE(sx : sx)
  | GE(sx : sx)


  ;; 1-syntax.watsup
  syntax relop_{fnn : fnn}((fnn : fnn <: numtype)) =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE


;; 1-syntax.watsup
syntax cvtop =
  | CONVERT
  | CONVERT_SAT
  | REINTERPRET

;; 1-syntax.watsup
syntax ishape = `%X%`(imm : imm, dim : dim)

;; 1-syntax.watsup
syntax fshape = `%X%`(fnn : fnn, dim : dim)

;; 1-syntax.watsup
syntax pshape = `%X%`(pnn : pnn, dim : dim)

;; 1-syntax.watsup
def $dim(shape : shape) : dim
  ;; 2-syntax-aux.watsup
  def $dim{lnn : lnn, N : N}(`%X%`(lnn, `%`(N))) = `%`(N)

;; 1-syntax.watsup
def $shsize(shape : shape) : nat
  ;; 2-syntax-aux.watsup
  def $shsize{lnn : lnn, N : N}(`%X%`(lnn, `%`(N))) = ($lsize(lnn) * N)

;; 1-syntax.watsup
syntax vvunop =
  | NOT

;; 1-syntax.watsup
syntax vvbinop =
  | AND
  | ANDNOT
  | OR
  | XOR

;; 1-syntax.watsup
syntax vvternop =
  | BITSELECT

;; 1-syntax.watsup
syntax vvtestop =
  | ANY_TRUE

;; 1-syntax.watsup
syntax vunop_(shape : shape)
  ;; 1-syntax.watsup
  syntax vunop_{imm : imm, N : N}(`%X%`((imm : imm <: lanetype), `%`(N))) =
  | ABS
  | NEG
  | POPCNT{imm : imm}
    -- if (imm = I8_imm)


  ;; 1-syntax.watsup
  syntax vunop_{fnn : fnn, N : N}(`%X%`((fnn : fnn <: lanetype), `%`(N))) =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST


;; 1-syntax.watsup
syntax vbinop_(shape : shape)
  ;; 1-syntax.watsup
  syntax vbinop_{imm : imm, N : N}(`%X%`((imm : imm <: lanetype), `%`(N))) =
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


  ;; 1-syntax.watsup
  syntax vbinop_{fnn : fnn, N : N}(`%X%`((fnn : fnn <: lanetype), `%`(N))) =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | PMIN
  | PMAX


;; 1-syntax.watsup
syntax vtestop_{imm : imm, N : N}(`%X%`((imm : imm <: lanetype), `%`(N))) =
  | ALL_TRUE

;; 1-syntax.watsup
syntax vrelop_(shape : shape)
  ;; 1-syntax.watsup
  syntax vrelop_{imm : imm, N : N}(`%X%`((imm : imm <: lanetype), `%`(N))) =
  | EQ
  | NE
  | LT(sx : sx)
  | GT(sx : sx)
  | LE(sx : sx)
  | GE(sx : sx)


  ;; 1-syntax.watsup
  syntax vrelop_{fnn : fnn, N : N}(`%X%`((fnn : fnn <: lanetype), `%`(N))) =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE


;; 1-syntax.watsup
syntax vcvtop =
  | EXTEND
  | TRUNC_SAT
  | CONVERT
  | DEMOTE
  | PROMOTE

;; 1-syntax.watsup
syntax vshiftop_{imm : imm, N : N}(`%X%`(imm, `%`(N))) =
  | SHL
  | SHR(sx : sx)

;; 1-syntax.watsup
syntax vextunop_{imm_1 : imm, N_1 : N, imm_2 : imm, N_2 : N}(`%X%`(imm_1, `%`(N_1)), `%X%`(imm_2, `%`(N_2))) =
  | EXTADD_PAIRWISE
    -- if ((16 <= $lsize((imm_1 : imm <: lanetype))) /\ ($lsize((imm_1 : imm <: lanetype)) <= 32))

;; 1-syntax.watsup
syntax half =
  | LOW
  | HIGH

;; 1-syntax.watsup
syntax vextbinop_{imm_1 : imm, N_1 : N, imm_2 : imm, N_2 : N}(`%X%`(imm_1, `%`(N_1)), `%X%`(imm_2, `%`(N_2))) =
  | EXTMUL(half : half)
  | DOT{imm_1 : imm}
    -- if ($lsize((imm_1 : imm <: lanetype)) = 32)

;; 1-syntax.watsup
syntax memop =
{
  ALIGN u32,
  OFFSET u32
}

;; 1-syntax.watsup
syntax vloadop =
  | SHAPE(nat : nat, nat : nat, sx : sx)
  | SPLAT(nat : nat)
  | ZERO(nat : nat)

;; 1-syntax.watsup
syntax blocktype =
  | _RESULT(valtype?)
  | _IDX(funcidx : funcidx)

;; 1-syntax.watsup
syntax zero = `ZERO%?`(()?)

;; 1-syntax.watsup
rec {

;; 1-syntax.watsup:522.1-534.78
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
  | CVTOP(numtype_1 : numtype, cvtop : cvtop, numtype_2 : numtype, sx?)
  | EXTEND(numtype : numtype, n : n)
  | VCONST(vectype : vectype, vec_ : vec_(vectype))
  | VVUNOP(vectype : vectype, vvunop : vvunop)
  | VVBINOP(vectype : vectype, vvbinop : vvbinop)
  | VVTERNOP(vectype : vectype, vvternop : vvternop)
  | VVTESTOP(vectype : vectype, vvtestop : vvtestop)
  | VSWIZZLE{ishape : ishape}(ishape : ishape)
    -- if (ishape = `%X%`(I8_imm, `%`(16)))
  | VSHUFFLE{ishape : ishape, laneidx* : laneidx*}(ishape : ishape, laneidx*)
    -- if ((ishape = `%X%`(I8_imm, `%`(16))) /\ (|laneidx*{laneidx}| = $dim((ishape : ishape <: shape)).`%`.0))
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
  | ARRAY.NEW_FIXED(typeidx : typeidx, nat : nat)
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

;; 1-syntax.watsup
syntax expr = instr*

;; 1-syntax.watsup
syntax elemmode =
  | ACTIVE(tableidx : tableidx, expr : expr)
  | PASSIVE
  | DECLARE

;; 1-syntax.watsup
syntax datamode =
  | ACTIVE(memidx : memidx, expr : expr)
  | PASSIVE

;; 1-syntax.watsup
syntax type = TYPE(rectype : rectype)

;; 1-syntax.watsup
syntax local = LOCAL(valtype : valtype)

;; 1-syntax.watsup
syntax func = `FUNC%%*%`(typeidx : typeidx, local*, expr : expr)

;; 1-syntax.watsup
syntax global = GLOBAL(globaltype : globaltype, expr : expr)

;; 1-syntax.watsup
syntax table = TABLE(tabletype : tabletype, expr : expr)

;; 1-syntax.watsup
syntax mem = MEMORY(memtype : memtype)

;; 1-syntax.watsup
syntax elem = `ELEM%%*%`(reftype : reftype, expr*, elemmode : elemmode)

;; 1-syntax.watsup
syntax data = `DATA%*%`(byte*, datamode : datamode)

;; 1-syntax.watsup
syntax start = START(funcidx : funcidx)

;; 1-syntax.watsup
syntax externidx =
  | FUNC(funcidx : funcidx)
  | GLOBAL(globalidx : globalidx)
  | TABLE(tableidx : tableidx)
  | MEM(memidx : memidx)

;; 1-syntax.watsup
syntax export = EXPORT(name : name, externidx : externidx)

;; 1-syntax.watsup
syntax import = IMPORT(name : name, name : name, externtype : externtype)

;; 1-syntax.watsup
syntax module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*, import*, func*, global*, table*, mem*, elem*, data*, start*, export*)

;; 2-syntax-aux.watsup
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

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:7.1-7.49
def $setminus(idx*, idx*) : idx*
  ;; 2-syntax-aux.watsup:10.1-10.29
  def $setminus{y* : idx*}([], y*{y}) = []
  ;; 2-syntax-aux.watsup:11.1-11.66
  def $setminus{x_1 : idx, x* : idx*, y* : idx*}([x_1] :: x*{x}, y*{y}) = $setminus1(x_1, y*{y}) :: $setminus(x*{x}, y*{y})
}

;; 2-syntax-aux.watsup
def $free_dataidx_instr(instr : instr) : dataidx*
  ;; 2-syntax-aux.watsup
  def $free_dataidx_instr{x : idx, y : idx}(MEMORY.INIT_instr(x, y)) = [y]
  ;; 2-syntax-aux.watsup
  def $free_dataidx_instr{x : idx}(DATA.DROP_instr(x)) = [x]
  ;; 2-syntax-aux.watsup
  def $free_dataidx_instr{in : instr}(in) = []

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:25.1-25.73
def $free_dataidx_instrs(instr*) : dataidx*
  ;; 2-syntax-aux.watsup:26.1-26.36
  def $free_dataidx_instrs([]) = []
  ;; 2-syntax-aux.watsup:27.1-27.99
  def $free_dataidx_instrs{instr : instr, instr'* : instr*}([instr] :: instr'*{instr'}) = $free_dataidx_instr(instr) :: $free_dataidx_instrs(instr'*{instr'})
}

;; 2-syntax-aux.watsup
def $free_dataidx_expr(expr : expr) : dataidx*
  ;; 2-syntax-aux.watsup
  def $free_dataidx_expr{in* : instr*}(in*{in}) = $free_dataidx_instrs(in*{in})

;; 2-syntax-aux.watsup
def $free_dataidx_func(func : func) : dataidx*
  ;; 2-syntax-aux.watsup
  def $free_dataidx_func{x : idx, loc* : local*, e : expr}(`FUNC%%*%`(x, loc*{loc}, e)) = $free_dataidx_expr(e)

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:35.1-35.71
def $free_dataidx_funcs(func*) : dataidx*
  ;; 2-syntax-aux.watsup:36.1-36.35
  def $free_dataidx_funcs([]) = []
  ;; 2-syntax-aux.watsup:37.1-37.92
  def $free_dataidx_funcs{func : func, func'* : func*}([func] :: func'*{func'}) = $free_dataidx_func(func) :: $free_dataidx_funcs(func'*{func'})
}

;; 2-syntax-aux.watsup
def $lunpack(lanetype : lanetype) : numtype
  ;; 2-syntax-aux.watsup
  def $lunpack{numtype : numtype}((numtype : numtype <: lanetype)) = numtype
  ;; 2-syntax-aux.watsup
  def $lunpack{packtype : packtype}((packtype : packtype <: lanetype)) = I32_numtype

;; 2-syntax-aux.watsup
def $unpack(storagetype : storagetype) : valtype
  ;; 2-syntax-aux.watsup
  def $unpack{valtype : valtype}((valtype : valtype <: storagetype)) = valtype
  ;; 2-syntax-aux.watsup
  def $unpack{packtype : packtype}((packtype : packtype <: storagetype)) = I32_valtype

;; 2-syntax-aux.watsup
def $nunpack(storagetype : storagetype) : numtype
  ;; 2-syntax-aux.watsup
  def $nunpack{numtype : numtype}((numtype : numtype <: storagetype)) = numtype
  ;; 2-syntax-aux.watsup
  def $nunpack{packtype : packtype}((packtype : packtype <: storagetype)) = I32_numtype

;; 2-syntax-aux.watsup
def $vunpack(storagetype : storagetype) : vectype
  ;; 2-syntax-aux.watsup
  def $vunpack{vectype : vectype}((vectype : vectype <: storagetype)) = vectype

;; 2-syntax-aux.watsup
def $sxfield(storagetype : storagetype) : sx?
  ;; 2-syntax-aux.watsup
  def $sxfield{valtype : valtype}((valtype : valtype <: storagetype)) = ?()
  ;; 2-syntax-aux.watsup
  def $sxfield{packtype : packtype}((packtype : packtype <: storagetype)) = ?(S_sx)

;; 2-syntax-aux.watsup
def $diffrt(reftype : reftype, reftype : reftype) : reftype
  ;; 2-syntax-aux.watsup
  def $diffrt{nul_1 : nul, ht_1 : heaptype, ht_2 : heaptype}(REF_reftype(nul_1, ht_1), REF_reftype(`NULL%?`(?(())), ht_2)) = REF_reftype(`NULL%?`(?()), ht_1)
  ;; 2-syntax-aux.watsup
  def $diffrt{nul_1 : nul, ht_1 : heaptype, ht_2 : heaptype}(REF_reftype(nul_1, ht_1), REF_reftype(`NULL%?`(?()), ht_2)) = REF_reftype(nul_1, ht_1)

;; 2-syntax-aux.watsup
syntax typevar =
  | _IDX(typeidx : typeidx)
  | REC(nat : nat)

;; 2-syntax-aux.watsup
def $idx(typeidx : typeidx) : typevar
  ;; 2-syntax-aux.watsup
  def $idx{x : idx}(x) = _IDX_typevar(x)

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:125.1-125.92
def $subst_typevar(typevar : typevar, typevar*, heaptype*) : heaptype
  ;; 2-syntax-aux.watsup:150.1-150.38
  def $subst_typevar{xx : typevar}(xx, [], []) = (xx : typevar <: heaptype)
  ;; 2-syntax-aux.watsup:151.1-151.95
  def $subst_typevar{xx : typevar, xx_1 : typevar, xx'* : typevar*, ht_1 : heaptype, ht'* : heaptype*}(xx, [xx_1] :: xx'*{xx'}, [ht_1] :: ht'*{ht'}) = ht_1
    -- if (xx = xx_1)
  ;; 2-syntax-aux.watsup:152.1-152.92
  def $subst_typevar{xx : typevar, xx_1 : typevar, xx'* : typevar*, ht_1 : heaptype, ht'* : heaptype*}(xx, [xx_1] :: xx'*{xx'}, [ht_1] :: ht'*{ht'}) = $subst_typevar(xx, xx'*{xx'}, ht'*{ht'})
    -- otherwise
}

;; 2-syntax-aux.watsup
def $subst_numtype(numtype : numtype, typevar*, heaptype*) : numtype
  ;; 2-syntax-aux.watsup
  def $subst_numtype{nt : numtype, xx* : typevar*, ht* : heaptype*}(nt, xx*{xx}, ht*{ht}) = nt

;; 2-syntax-aux.watsup
def $subst_vectype(vectype : vectype, typevar*, heaptype*) : vectype
  ;; 2-syntax-aux.watsup
  def $subst_vectype{vt : vectype, xx* : typevar*, ht* : heaptype*}(vt, xx*{xx}, ht*{ht}) = vt

;; 2-syntax-aux.watsup
def $subst_packtype(packtype : packtype, typevar*, heaptype*) : packtype
  ;; 2-syntax-aux.watsup
  def $subst_packtype{pt : packtype, xx* : typevar*, ht* : heaptype*}(pt, xx*{xx}, ht*{ht}) = pt

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:129.1-129.92
def $subst_heaptype(heaptype : heaptype, typevar*, heaptype*) : heaptype
  ;; 2-syntax-aux.watsup:157.1-157.67
  def $subst_heaptype{xx' : typevar, xx* : typevar*, ht* : heaptype*}((xx' : typevar <: heaptype), xx*{xx}, ht*{ht}) = $subst_typevar(xx', xx*{xx}, ht*{ht})
  ;; 2-syntax-aux.watsup:158.1-158.65
  def $subst_heaptype{dt : deftype, xx* : typevar*, ht* : heaptype*}((dt : deftype <: heaptype), xx*{xx}, ht*{ht}) = ($subst_deftype(dt, xx*{xx}, ht*{ht}) : deftype <: heaptype)
  ;; 2-syntax-aux.watsup:159.1-159.55
  def $subst_heaptype{ht' : heaptype, xx* : typevar*, ht* : heaptype*}(ht', xx*{xx}, ht*{ht}) = ht'
    -- otherwise

;; 2-syntax-aux.watsup:130.1-130.92
def $subst_reftype(reftype : reftype, typevar*, heaptype*) : reftype
  ;; 2-syntax-aux.watsup:161.1-161.85
  def $subst_reftype{nul : nul, ht' : heaptype, xx* : typevar*, ht* : heaptype*}(REF_reftype(nul, ht'), xx*{xx}, ht*{ht}) = REF_reftype(nul, $subst_heaptype(ht', xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:131.1-131.92
def $subst_valtype(valtype : valtype, typevar*, heaptype*) : valtype
  ;; 2-syntax-aux.watsup:163.1-163.64
  def $subst_valtype{nt : numtype, xx* : typevar*, ht* : heaptype*}((nt : numtype <: valtype), xx*{xx}, ht*{ht}) = ($subst_numtype(nt, xx*{xx}, ht*{ht}) : numtype <: valtype)
  ;; 2-syntax-aux.watsup:164.1-164.64
  def $subst_valtype{vt : vectype, xx* : typevar*, ht* : heaptype*}((vt : vectype <: valtype), xx*{xx}, ht*{ht}) = ($subst_vectype(vt, xx*{xx}, ht*{ht}) : vectype <: valtype)
  ;; 2-syntax-aux.watsup:165.1-165.64
  def $subst_valtype{rt : reftype, xx* : typevar*, ht* : heaptype*}((rt : reftype <: valtype), xx*{xx}, ht*{ht}) = ($subst_reftype(rt, xx*{xx}, ht*{ht}) : reftype <: valtype)
  ;; 2-syntax-aux.watsup:166.1-166.40
  def $subst_valtype{xx* : typevar*, ht* : heaptype*}(BOT_valtype, xx*{xx}, ht*{ht}) = BOT_valtype

;; 2-syntax-aux.watsup:134.1-134.92
def $subst_storagetype(storagetype : storagetype, typevar*, heaptype*) : storagetype
  ;; 2-syntax-aux.watsup:170.1-170.66
  def $subst_storagetype{t : valtype, xx* : typevar*, ht* : heaptype*}((t : valtype <: storagetype), xx*{xx}, ht*{ht}) = ($subst_valtype(t, xx*{xx}, ht*{ht}) : valtype <: storagetype)
  ;; 2-syntax-aux.watsup:171.1-171.69
  def $subst_storagetype{pt : packtype, xx* : typevar*, ht* : heaptype*}((pt : packtype <: storagetype), xx*{xx}, ht*{ht}) = ($subst_packtype(pt, xx*{xx}, ht*{ht}) : packtype <: storagetype)

;; 2-syntax-aux.watsup:135.1-135.92
def $subst_fieldtype(fieldtype : fieldtype, typevar*, heaptype*) : fieldtype
  ;; 2-syntax-aux.watsup:173.1-173.80
  def $subst_fieldtype{mut : mut, zt : storagetype, xx* : typevar*, ht* : heaptype*}(`%%`(mut, zt), xx*{xx}, ht*{ht}) = `%%`(mut, $subst_storagetype(zt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:137.1-137.92
def $subst_comptype(comptype : comptype, typevar*, heaptype*) : comptype
  ;; 2-syntax-aux.watsup:175.1-175.85
  def $subst_comptype{yt* : fieldtype*, xx* : typevar*, ht* : heaptype*}(STRUCT_comptype(yt*{yt}), xx*{xx}, ht*{ht}) = STRUCT_comptype($subst_fieldtype(yt, xx*{xx}, ht*{ht})*{yt})
  ;; 2-syntax-aux.watsup:176.1-176.81
  def $subst_comptype{yt : fieldtype, xx* : typevar*, ht* : heaptype*}(ARRAY_comptype(yt), xx*{xx}, ht*{ht}) = ARRAY_comptype($subst_fieldtype(yt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:177.1-177.78
  def $subst_comptype{ft : functype, xx* : typevar*, ht* : heaptype*}(FUNC_comptype(ft), xx*{xx}, ht*{ht}) = FUNC_comptype($subst_functype(ft, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:138.1-138.92
def $subst_subtype(subtype : subtype, typevar*, heaptype*) : subtype
  ;; 2-syntax-aux.watsup:179.1-180.76
  def $subst_subtype{fin : fin, y* : idx*, ct : comptype, xx* : typevar*, ht* : heaptype*}(SUB_subtype(fin, y*{y}, ct), xx*{xx}, ht*{ht}) = SUBD_subtype(fin, $subst_heaptype(_IDX_heaptype(y), xx*{xx}, ht*{ht})*{y}, $subst_comptype(ct, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:181.1-182.73
  def $subst_subtype{fin : fin, ht'* : heaptype*, ct : comptype, xx* : typevar*, ht* : heaptype*}(SUBD_subtype(fin, ht'*{ht'}, ct), xx*{xx}, ht*{ht}) = SUBD_subtype(fin, $subst_heaptype(ht', xx*{xx}, ht*{ht})*{ht'}, $subst_comptype(ct, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:139.1-139.92
def $subst_rectype(rectype : rectype, typevar*, heaptype*) : rectype
  ;; 2-syntax-aux.watsup:184.1-184.76
  def $subst_rectype{st* : subtype*, xx* : typevar*, ht* : heaptype*}(REC_rectype(st*{st}), xx*{xx}, ht*{ht}) = REC_rectype($subst_subtype(st, xx*{xx}, ht*{ht})*{st})

;; 2-syntax-aux.watsup:140.1-140.92
def $subst_deftype(deftype : deftype, typevar*, heaptype*) : deftype
  ;; 2-syntax-aux.watsup:186.1-186.78
  def $subst_deftype{qt : rectype, i : nat, xx* : typevar*, ht* : heaptype*}(DEF_deftype(qt, i), xx*{xx}, ht*{ht}) = DEF_deftype($subst_rectype(qt, xx*{xx}, ht*{ht}), i)

;; 2-syntax-aux.watsup:143.1-143.92
def $subst_functype(functype : functype, typevar*, heaptype*) : functype
  ;; 2-syntax-aux.watsup:189.1-189.113
  def $subst_functype{t_1* : valtype*, t_2* : valtype*, xx* : typevar*, ht* : heaptype*}(`%->%`(t_1*{t_1}, t_2*{t_2}), xx*{xx}, ht*{ht}) = `%->%`($subst_valtype(t_1, xx*{xx}, ht*{ht})*{t_1}, $subst_valtype(t_2, xx*{xx}, ht*{ht})*{t_2})
}

;; 2-syntax-aux.watsup
def $subst_globaltype(globaltype : globaltype, typevar*, heaptype*) : globaltype
  ;; 2-syntax-aux.watsup
  def $subst_globaltype{mut : mut, t : valtype, xx* : typevar*, ht* : heaptype*}(`%%`(mut, t), xx*{xx}, ht*{ht}) = `%%`(mut, $subst_valtype(t, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup
def $subst_tabletype(tabletype : tabletype, typevar*, heaptype*) : tabletype
  ;; 2-syntax-aux.watsup
  def $subst_tabletype{lim : limits, rt : reftype, xx* : typevar*, ht* : heaptype*}(`%%`(lim, rt), xx*{xx}, ht*{ht}) = `%%`(lim, $subst_reftype(rt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup
def $subst_memtype(memtype : memtype, typevar*, heaptype*) : memtype
  ;; 2-syntax-aux.watsup
  def $subst_memtype{lim : limits, xx* : typevar*, ht* : heaptype*}(`%I8`(lim), xx*{xx}, ht*{ht}) = `%I8`(lim)

;; 2-syntax-aux.watsup
def $subst_externtype(externtype : externtype, typevar*, heaptype*) : externtype
  ;; 2-syntax-aux.watsup
  def $subst_externtype{dt : deftype, xx* : typevar*, ht* : heaptype*}(FUNC_externtype(dt), xx*{xx}, ht*{ht}) = FUNC_externtype($subst_deftype(dt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup
  def $subst_externtype{gt : globaltype, xx* : typevar*, ht* : heaptype*}(GLOBAL_externtype(gt), xx*{xx}, ht*{ht}) = GLOBAL_externtype($subst_globaltype(gt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup
  def $subst_externtype{tt : tabletype, xx* : typevar*, ht* : heaptype*}(TABLE_externtype(tt), xx*{xx}, ht*{ht}) = TABLE_externtype($subst_tabletype(tt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup
  def $subst_externtype{mt : memtype, xx* : typevar*, ht* : heaptype*}(MEM_externtype(mt), xx*{xx}, ht*{ht}) = MEM_externtype($subst_memtype(mt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup
def $subst_all_reftype(reftype : reftype, heaptype*) : reftype
  ;; 2-syntax-aux.watsup
  def $subst_all_reftype{rt : reftype, ht^n : heaptype^n, n : n, i^n : nat^n}(rt, ht^n{ht}) = $subst_reftype(rt, $idx(`%`(i))^(i<n){i}, ht^n{ht})

;; 2-syntax-aux.watsup
def $subst_all_deftype(deftype : deftype, heaptype*) : deftype
  ;; 2-syntax-aux.watsup
  def $subst_all_deftype{dt : deftype, ht^n : heaptype^n, n : n, i^n : nat^n}(dt, ht^n{ht}) = $subst_deftype(dt, $idx(`%`(i))^(i<n){i}, ht^n{ht})

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:205.1-205.77
def $subst_all_deftypes(deftype*, heaptype*) : deftype*
  ;; 2-syntax-aux.watsup:207.1-207.40
  def $subst_all_deftypes{ht* : heaptype*}([], ht*{ht}) = []
  ;; 2-syntax-aux.watsup:208.1-208.101
  def $subst_all_deftypes{dt_1 : deftype, dt* : deftype*, ht* : heaptype*}([dt_1] :: dt*{dt}, ht*{ht}) = [$subst_all_deftype(dt_1, ht*{ht})] :: $subst_all_deftypes(dt*{dt}, ht*{ht})
}

;; 2-syntax-aux.watsup
def $rollrt(typeidx : typeidx, rectype : rectype) : rectype
  ;; 2-syntax-aux.watsup
  def $rollrt{x : idx, st^n : subtype^n, n : n, i^n : nat^n}(x, REC_rectype(st^n{st})) = REC_rectype($subst_subtype(st, $idx(`%`((x.`%`.0 + i)))^(i<n){i}, REC_heaptype(i)^(i<n){i})^n{st})

;; 2-syntax-aux.watsup
def $unrollrt(rectype : rectype) : rectype
  ;; 2-syntax-aux.watsup
  def $unrollrt{st^n : subtype^n, n : n, i^n : nat^n, qt : rectype}(REC_rectype(st^n{st})) = REC_rectype($subst_subtype(st, REC_typevar(i)^(i<n){i}, DEF_heaptype(qt, i)^(i<n){i})^n{st})
    -- if (qt = REC_rectype(st^n{st}))

;; 2-syntax-aux.watsup
def $rolldt(typeidx : typeidx, rectype : rectype) : deftype*
  ;; 2-syntax-aux.watsup
  def $rolldt{x : idx, qt : rectype, st^n : subtype^n, n : n, i^n : nat^n}(x, qt) = DEF_deftype(REC_rectype(st^n{st}), i)^(i<n){i}
    -- if ($rollrt(x, qt) = REC_rectype(st^n{st}))

;; 2-syntax-aux.watsup
def $unrolldt(deftype : deftype) : subtype
  ;; 2-syntax-aux.watsup
  def $unrolldt{qt : rectype, i : nat, st* : subtype*}(DEF_deftype(qt, i)) = st*{st}[i]
    -- if ($unrollrt(qt) = REC_rectype(st*{st}))

;; 2-syntax-aux.watsup
def $expanddt(deftype : deftype) : comptype
  ;; 2-syntax-aux.watsup
  def $expanddt{dt : deftype, ct : comptype, fin : fin, ht* : heaptype*}(dt) = ct
    -- if ($unrolldt(dt) = SUBD_subtype(fin, ht*{ht}, ct))

;; 2-syntax-aux.watsup
relation Expand: `%~~%`(deftype, comptype)
  ;; 2-syntax-aux.watsup
  rule _{dt : deftype, ct : comptype}:
    `%~~%`(dt, ct)
    -- if ($expanddt(dt) = ct)

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:238.1-238.64
def $funcsxt(externtype*) : deftype*
  ;; 2-syntax-aux.watsup:243.1-243.24
  def $funcsxt([]) = []
  ;; 2-syntax-aux.watsup:244.1-244.47
  def $funcsxt{dt : deftype, et* : externtype*}([FUNC_externtype(dt)] :: et*{et}) = [dt] :: $funcsxt(et*{et})
  ;; 2-syntax-aux.watsup:245.1-245.59
  def $funcsxt{externtype : externtype, et* : externtype*}([externtype] :: et*{et}) = $funcsxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:239.1-239.66
def $globalsxt(externtype*) : globaltype*
  ;; 2-syntax-aux.watsup:247.1-247.26
  def $globalsxt([]) = []
  ;; 2-syntax-aux.watsup:248.1-248.53
  def $globalsxt{gt : globaltype, et* : externtype*}([GLOBAL_externtype(gt)] :: et*{et}) = [gt] :: $globalsxt(et*{et})
  ;; 2-syntax-aux.watsup:249.1-249.63
  def $globalsxt{externtype : externtype, et* : externtype*}([externtype] :: et*{et}) = $globalsxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:240.1-240.65
def $tablesxt(externtype*) : tabletype*
  ;; 2-syntax-aux.watsup:251.1-251.25
  def $tablesxt([]) = []
  ;; 2-syntax-aux.watsup:252.1-252.50
  def $tablesxt{tt : tabletype, et* : externtype*}([TABLE_externtype(tt)] :: et*{et}) = [tt] :: $tablesxt(et*{et})
  ;; 2-syntax-aux.watsup:253.1-253.61
  def $tablesxt{externtype : externtype, et* : externtype*}([externtype] :: et*{et}) = $tablesxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:241.1-241.63
def $memsxt(externtype*) : memtype*
  ;; 2-syntax-aux.watsup:255.1-255.23
  def $memsxt([]) = []
  ;; 2-syntax-aux.watsup:256.1-256.44
  def $memsxt{mt : memtype, et* : externtype*}([MEM_externtype(mt)] :: et*{et}) = [mt] :: $memsxt(et*{et})
  ;; 2-syntax-aux.watsup:257.1-257.57
  def $memsxt{externtype : externtype, et* : externtype*}([externtype] :: et*{et}) = $memsxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup
def $memop0 : memop
  ;; 2-syntax-aux.watsup
  def $memop0 = {ALIGN `%`(0), OFFSET `%`(0)}

;; 3-numerics.watsup
def $s33_to_u32(s33 : s33) : u32

;; 3-numerics.watsup
def $signed(N : N, nat : nat) : int
  ;; 3-numerics.watsup
  def $signed{N : N, i : nat}(N, i) = (i : nat <: int)
    -- if (0 <= (2 ^ (N - 1)))
  ;; 3-numerics.watsup
  def $signed{N : N, i : nat}(N, i) = ((i - (2 ^ N)) : nat <: int)
    -- if (((2 ^ (N - 1)) <= i) /\ (i < (2 ^ N)))

;; 3-numerics.watsup
def $invsigned(N : N, int : int) : nat
  ;; 3-numerics.watsup
  def $invsigned{N : N, i : nat, j : nat}(N, (i : nat <: int)) = j
    -- if ($signed(N, j) = (i : nat <: int))

;; 3-numerics.watsup
def $ext(M : M, N : N, sx : sx, iN : iN(M)) : iN(N)

;; 3-numerics.watsup
def $fabs(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $fceil(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $ffloor(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $fnearest(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $fneg(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $fsqrt(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $ftrunc(N : N, fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $iclz(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ictz(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ipopcnt(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $wrap(M : M, N : N, iN : iN(M)) : iN(N)

;; 3-numerics.watsup
def $unop(numtype : numtype, unop_ : unop_(numtype), num_ : num_(numtype)) : num_(numtype)*
  ;; 3-numerics.watsup
  def $unop{inn : inn, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), CLZ_unop_((inn : inn <: numtype)), iN) = [$iclz($size((inn : inn <: numtype)), iN)]
  ;; 3-numerics.watsup
  def $unop{inn : inn, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), CTZ_unop_((inn : inn <: numtype)), iN) = [$ictz($size((inn : inn <: numtype)), iN)]
  ;; 3-numerics.watsup
  def $unop{inn : inn, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), POPCNT_unop_((inn : inn <: numtype)), iN) = [$ipopcnt($size((inn : inn <: numtype)), iN)]
  ;; 3-numerics.watsup
  def $unop{inn : inn, N : N, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), EXTEND_unop_((inn : inn <: numtype))(N), iN) = [$ext(N, $size((inn : inn <: numtype)), S_sx, $wrap($size((inn : inn <: numtype)), N, iN))]
  ;; 3-numerics.watsup
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), ABS_unop_((fnn : fnn <: numtype)), fN) = [$fabs($size((fnn : fnn <: numtype)), fN)]
  ;; 3-numerics.watsup
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), NEG_unop_((fnn : fnn <: numtype)), fN) = [$fneg($size((fnn : fnn <: numtype)), fN)]
  ;; 3-numerics.watsup
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), SQRT_unop_((fnn : fnn <: numtype)), fN) = [$fsqrt($size((fnn : fnn <: numtype)), fN)]
  ;; 3-numerics.watsup
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), CEIL_unop_((fnn : fnn <: numtype)), fN) = [$fceil($size((fnn : fnn <: numtype)), fN)]
  ;; 3-numerics.watsup
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), FLOOR_unop_((fnn : fnn <: numtype)), fN) = [$ffloor($size((fnn : fnn <: numtype)), fN)]
  ;; 3-numerics.watsup
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), TRUNC_unop_((fnn : fnn <: numtype)), fN) = [$ftrunc($size((fnn : fnn <: numtype)), fN)]
  ;; 3-numerics.watsup
  def $unop{fnn : fnn, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), NEAREST_unop_((fnn : fnn <: numtype)), fN) = [$fnearest($size((fnn : fnn <: numtype)), fN)]

;; 3-numerics.watsup
def $fadd(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $fcopysign(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $fdiv(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $fmax(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $fmin(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $fmul(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $fsub(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $iadd(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $iand(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $idiv(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $imul(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ior(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $irem(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $irotl(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $irotr(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ishl(N : N, iN : iN(N), u32 : u32) : iN(N)

;; 3-numerics.watsup
def $ishr(N : N, sx : sx, iN : iN(N), u32 : u32) : iN(N)

;; 3-numerics.watsup
def $isub(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ixor(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $binop(numtype : numtype, binop_ : binop_(numtype), num_ : num_(numtype), num_ : num_(numtype)) : num_(numtype)*
  ;; 3-numerics.watsup
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), ADD_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$iadd($size((inn : inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), SUB_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$isub($size((inn : inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), MUL_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$imul($size((inn : inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), DIV_binop_((inn : inn <: numtype))(sx), iN_1, iN_2) = [$idiv($size((inn : inn <: numtype)), sx, iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), REM_binop_((inn : inn <: numtype))(sx), iN_1, iN_2) = [$irem($size((inn : inn <: numtype)), sx, iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), AND_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$iand($size((inn : inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), OR_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$ior($size((inn : inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), XOR_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$ixor($size((inn : inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), SHL_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$ishl($size((inn : inn <: numtype)), iN_1, `%`(iN_2.`%`.0))]
  ;; 3-numerics.watsup
  def $binop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), SHR_binop_((inn : inn <: numtype))(sx), iN_1, iN_2) = [$ishr($size((inn : inn <: numtype)), sx, iN_1, `%`(iN_2.`%`.0))]
  ;; 3-numerics.watsup
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), ROTL_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$irotl($size((inn : inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), ROTR_binop_((inn : inn <: numtype)), iN_1, iN_2) = [$irotr($size((inn : inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), ADD_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fadd($size((fnn : fnn <: numtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), SUB_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fsub($size((fnn : fnn <: numtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), MUL_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fmul($size((fnn : fnn <: numtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), DIV_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fdiv($size((fnn : fnn <: numtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), MIN_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fmin($size((fnn : fnn <: numtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), MAX_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fmax($size((fnn : fnn <: numtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup
  def $binop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), COPYSIGN_binop_((fnn : fnn <: numtype)), fN_1, fN_2) = [$fcopysign($size((fnn : fnn <: numtype)), fN_1, fN_2)]

;; 3-numerics.watsup
def $ieqz(N : N, iN : iN(N)) : u32

;; 3-numerics.watsup
def $testop(numtype : numtype, testop_ : testop_(numtype), num_ : num_(numtype)) : num_(I32_numtype)
  ;; 3-numerics.watsup
  def $testop{inn : inn, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), EQZ_testop_((inn : inn <: numtype)), iN) = $ieqz($size((inn : inn <: numtype)), iN)

;; 3-numerics.watsup
def $feq(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup
def $fge(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup
def $fgt(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup
def $fle(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup
def $flt(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup
def $fne(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup
def $ieq(N : N, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup
def $ige(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup
def $igt(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup
def $ile(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup
def $ilt(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup
def $ine(N : N, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup
def $relop(numtype : numtype, relop_ : relop_(numtype), num_ : num_(numtype), num_ : num_(numtype)) : num_(I32_numtype)
  ;; 3-numerics.watsup
  def $relop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), EQ_relop_((inn : inn <: numtype)), iN_1, iN_2) = $ieq($size((inn : inn <: numtype)), iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop{inn : inn, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), NE_relop_((inn : inn <: numtype)), iN_1, iN_2) = $ine($size((inn : inn <: numtype)), iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), LT_relop_((inn : inn <: numtype))(sx), iN_1, iN_2) = $ilt($size((inn : inn <: numtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), GT_relop_((inn : inn <: numtype))(sx), iN_1, iN_2) = $igt($size((inn : inn <: numtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), LE_relop_((inn : inn <: numtype))(sx), iN_1, iN_2) = $ile($size((inn : inn <: numtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop{inn : inn, sx : sx, iN_1 : num_((inn : inn <: numtype)), iN_2 : num_((inn : inn <: numtype))}((inn : inn <: numtype), GE_relop_((inn : inn <: numtype))(sx), iN_1, iN_2) = $ige($size((inn : inn <: numtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), EQ_relop_((fnn : fnn <: numtype)), fN_1, fN_2) = $feq($size((fnn : fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), NE_relop_((fnn : fnn <: numtype)), fN_1, fN_2) = $fne($size((fnn : fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), LT_relop_((fnn : fnn <: numtype)), fN_1, fN_2) = $flt($size((fnn : fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), GT_relop_((fnn : fnn <: numtype)), fN_1, fN_2) = $fgt($size((fnn : fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), LE_relop_((fnn : fnn <: numtype)), fN_1, fN_2) = $fle($size((fnn : fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop{fnn : fnn, fN_1 : num_((fnn : fnn <: numtype)), fN_2 : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), GE_relop_((fnn : fnn <: numtype)), fN_1, fN_2) = $fge($size((fnn : fnn <: numtype)), fN_1, fN_2)

;; 3-numerics.watsup
def $convert(M : M, N : N, sx : sx, iN : iN(M)) : fN(N)

;; 3-numerics.watsup
def $demote(M : M, N : N, fN : fN(M)) : fN(N)

;; 3-numerics.watsup
def $promote(M : M, N : N, fN : fN(M)) : fN(N)

;; 3-numerics.watsup
def $reinterpret(numtype_1 : numtype, numtype_2 : numtype, num_ : num_(numtype_1)) : num_(numtype_2)

;; 3-numerics.watsup
def $trunc(M : M, N : N, sx : sx, fN : fN(M)) : iN(N)

;; 3-numerics.watsup
def $trunc_sat(M : M, N : N, sx : sx, fN : fN(M)) : iN(N)

;; 3-numerics.watsup
def $cvtop(numtype_1 : numtype, numtype_2 : numtype, cvtop : cvtop, sx?, num_ : num_(numtype_1)) : num_(numtype_2)*
  ;; 3-numerics.watsup
  def $cvtop{sx : sx, iN : num_(I32_numtype)}(I32_numtype, I64_numtype, CONVERT_cvtop, ?(sx), iN) = [$ext(32, 64, sx, iN)]
  ;; 3-numerics.watsup
  def $cvtop{sx? : sx?, iN : num_(I64_numtype)}(I64_numtype, I32_numtype, CONVERT_cvtop, sx?{sx}, iN) = [$wrap(64, 32, iN)]
  ;; 3-numerics.watsup
  def $cvtop{fnn : fnn, inn : inn, sx : sx, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), (inn : inn <: numtype), CONVERT_cvtop, ?(sx), fN) = [$trunc($size((fnn : fnn <: numtype)), $size((inn : inn <: numtype)), sx, fN)]
  ;; 3-numerics.watsup
  def $cvtop{fnn : fnn, inn : inn, sx : sx, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), (inn : inn <: numtype), CONVERT_SAT_cvtop, ?(sx), fN) = [$trunc_sat($size((fnn : fnn <: numtype)), $size((inn : inn <: numtype)), sx, fN)]
  ;; 3-numerics.watsup
  def $cvtop{sx? : sx?, fN : num_(F32_numtype)}(F32_numtype, F64_numtype, CONVERT_cvtop, sx?{sx}, fN) = [$promote(32, 64, fN)]
  ;; 3-numerics.watsup
  def $cvtop{sx? : sx?, fN : num_(F64_numtype)}(F64_numtype, F32_numtype, CONVERT_cvtop, sx?{sx}, fN) = [$demote(64, 32, fN)]
  ;; 3-numerics.watsup
  def $cvtop{inn : inn, fnn : fnn, sx : sx, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), (fnn : fnn <: numtype), CONVERT_cvtop, ?(sx), iN) = [$convert($size((inn : inn <: numtype)), $size((fnn : fnn <: numtype)), sx, iN)]
  ;; 3-numerics.watsup
  def $cvtop{inn : inn, fnn : fnn, sx? : sx?, iN : num_((inn : inn <: numtype))}((inn : inn <: numtype), (fnn : fnn <: numtype), REINTERPRET_cvtop, sx?{sx}, iN) = [$reinterpret((inn : inn <: numtype), (fnn : fnn <: numtype), iN)]
    -- if ($size((inn : inn <: numtype)) = $size((fnn : fnn <: numtype)))
  ;; 3-numerics.watsup
  def $cvtop{fnn : fnn, inn : inn, sx? : sx?, fN : num_((fnn : fnn <: numtype))}((fnn : fnn <: numtype), (inn : inn <: numtype), REINTERPRET_cvtop, sx?{sx}, fN) = [$reinterpret((fnn : fnn <: numtype), (inn : inn <: numtype), fN)]
    -- if ($size((inn : inn <: numtype)) = $size((fnn : fnn <: numtype)))

;; 3-numerics.watsup
def $narrow(M : M, N : N, sx : sx, iN : iN(M)) : iN(N)

;; 3-numerics.watsup
def $ibits(N : N, iN : iN(N)) : bit*

;; 3-numerics.watsup
def $fbits(N : N, fN : fN(N)) : bit*

;; 3-numerics.watsup
def $ibytes(N : N, iN : iN(N)) : byte*

;; 3-numerics.watsup
def $fbytes(N : N, fN : fN(N)) : byte*

;; 3-numerics.watsup
def $nbytes(numtype : numtype, num_ : num_(numtype)) : byte*

;; 3-numerics.watsup
def $vbytes(vectype : vectype, vec_ : vec_(vectype)) : byte*

;; 3-numerics.watsup
def $zbytes(storagetype : storagetype, zval_ : zval_(storagetype)) : byte*

;; 3-numerics.watsup
def $invibytes(N : N, byte*) : iN(N)
  ;; 3-numerics.watsup
  def $invibytes{N : N, b* : byte*, n : n}(N, b*{b}) = `%`(n)
    -- if ($ibytes(N, `%`(n)) = b*{b})

;; 3-numerics.watsup
def $invfbytes(N : N, byte*) : fN(N)
  ;; 3-numerics.watsup
  def $invfbytes{N : N, b* : byte*, p : fN(N)}(N, b*{b}) = p
    -- if ($fbytes(N, p) = b*{b})

;; 3-numerics.watsup
def $inot(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $iandnot(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ibitselect(N : N, iN : iN(N), iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $iabs(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ineg(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $imin(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $imax(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $iaddsat(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $isubsat(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $iavgr_u(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $iq15mulrsat_s(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $fpmin(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $fpmax(N : N, fN : fN(N), fN : fN(N)) : fN(N)

;; 3-numerics.watsup
def $packnum(lanetype : lanetype, num_ : num_($lunpack(lanetype))) : lane_(lanetype)
  ;; 3-numerics.watsup
  def $packnum{numtype : numtype, c : num_($lunpack((numtype : numtype <: lanetype)))}((numtype : numtype <: lanetype), c) = c
  ;; 3-numerics.watsup
  def $packnum{packtype : packtype, c : num_($lunpack((packtype : packtype <: lanetype)))}((packtype : packtype <: lanetype), c) = $wrap($size($lunpack((packtype : packtype <: lanetype))), $psize(packtype), c)

;; 3-numerics.watsup
def $unpacknum(lanetype : lanetype, lane_ : lane_(lanetype)) : num_($lunpack(lanetype))
  ;; 3-numerics.watsup
  def $unpacknum{numtype : numtype, c : lane_((numtype : numtype <: lanetype))}((numtype : numtype <: lanetype), c) = c
  ;; 3-numerics.watsup
  def $unpacknum{packtype : packtype, c : lane_((packtype : packtype <: lanetype))}((packtype : packtype <: lanetype), c) = $ext($psize(packtype), $size($lunpack((packtype : packtype <: lanetype))), U_sx, c)

;; 3-numerics.watsup
def $lanes_(shape : shape, vec_ : vec_(V128_vnn)) : lane_($lanetype(shape))*

;; 3-numerics.watsup
def $invlanes_(shape : shape, lane_($lanetype(shape))*) : vec_(V128_vnn)
  ;; 3-numerics.watsup
  def $invlanes_{sh : shape, c* : lane_($lanetype(sh))*, vc : vec_(V128_vnn)}(sh, c*{c}) = vc
    -- if (c*{c} = $lanes_(sh, vc))

;; 3-numerics.watsup
def $halfop(half : half, nat : nat, nat : nat) : nat
  ;; 3-numerics.watsup
  def $halfop{i : nat, j : nat}(LOW_half, i, j) = i
  ;; 3-numerics.watsup
  def $halfop{i : nat, j : nat}(HIGH_half, i, j) = j

;; 3-numerics.watsup
def $vvunop(vectype : vectype, vvunop : vvunop, vec_ : vec_(vectype)) : vec_(vectype)
  ;; 3-numerics.watsup
  def $vvunop{v128 : vec_(V128_vnn)}(V128_vectype, NOT_vvunop, v128) = $inot($vsize(V128_vectype), v128)

;; 3-numerics.watsup
def $vvbinop(vectype : vectype, vvbinop : vvbinop, vec_ : vec_(vectype), vec_ : vec_(vectype)) : vec_(vectype)
  ;; 3-numerics.watsup
  def $vvbinop{v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn)}(V128_vectype, AND_vvbinop, v128_1, v128_2) = $iand($vsize(V128_vectype), v128_1, v128_2)
  ;; 3-numerics.watsup
  def $vvbinop{v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn)}(V128_vectype, ANDNOT_vvbinop, v128_1, v128_2) = $iandnot($vsize(V128_vectype), v128_1, v128_2)
  ;; 3-numerics.watsup
  def $vvbinop{v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn)}(V128_vectype, OR_vvbinop, v128_1, v128_2) = $ior($vsize(V128_vectype), v128_1, v128_2)
  ;; 3-numerics.watsup
  def $vvbinop{v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn)}(V128_vectype, XOR_vvbinop, v128_1, v128_2) = $ixor($vsize(V128_vectype), v128_1, v128_2)

;; 3-numerics.watsup
def $vvternop(vectype : vectype, vvternop : vvternop, vec_ : vec_(vectype), vec_ : vec_(vectype), vec_ : vec_(vectype)) : vec_(vectype)
  ;; 3-numerics.watsup
  def $vvternop{v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128_3 : vec_(V128_vnn)}(V128_vectype, BITSELECT_vvternop, v128_1, v128_2, v128_3) = $ibitselect($vsize(V128_vectype), v128_1, v128_2, v128_3)

;; 3-numerics.watsup
def $vunop(shape : shape, vunop_ : vunop_(shape), vec_ : vec_(V128_vnn)) : vec_(V128_vnn)
  ;; 3-numerics.watsup
  def $vunop{imm : imm, N : N, v128_1 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}(`%X%`((imm : imm <: lanetype), `%`(N)), ABS_vunop_(`%X%`((imm : imm <: lanetype), `%`(N))), v128_1) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $iabs($lsize((imm : imm <: lanetype)), lane_1)*{lane_1}))
  ;; 3-numerics.watsup
  def $vunop{imm : imm, N : N, v128_1 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}(`%X%`((imm : imm <: lanetype), `%`(N)), NEG_vunop_(`%X%`((imm : imm <: lanetype), `%`(N))), v128_1) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $ineg($lsize((imm : imm <: lanetype)), lane_1)*{lane_1}))
  ;; 3-numerics.watsup
  def $vunop{imm : imm, N : N, v128_1 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}(`%X%`((imm : imm <: lanetype), `%`(N)), POPCNT_vunop_(`%X%`((imm : imm <: lanetype), `%`(N))), v128_1) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $ipopcnt($lsize((imm : imm <: lanetype)), lane_1)*{lane_1}))
  ;; 3-numerics.watsup
  def $vunop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), ABS_vunop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fabs($size((fnn : fnn <: numtype)), lane_1)*{lane_1}))
  ;; 3-numerics.watsup
  def $vunop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), NEG_vunop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fneg($size((fnn : fnn <: numtype)), lane_1)*{lane_1}))
  ;; 3-numerics.watsup
  def $vunop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), SQRT_vunop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fsqrt($size((fnn : fnn <: numtype)), lane_1)*{lane_1}))
  ;; 3-numerics.watsup
  def $vunop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), CEIL_vunop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fceil($size((fnn : fnn <: numtype)), lane_1)*{lane_1}))
  ;; 3-numerics.watsup
  def $vunop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), FLOOR_vunop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $ffloor($size((fnn : fnn <: numtype)), lane_1)*{lane_1}))
  ;; 3-numerics.watsup
  def $vunop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), TRUNC_vunop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $ftrunc($size((fnn : fnn <: numtype)), lane_1)*{lane_1}))
  ;; 3-numerics.watsup
  def $vunop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), NEAREST_vunop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fnearest($size((fnn : fnn <: numtype)), lane_1)*{lane_1}))

;; 3-numerics.watsup
def $vbinop(shape : shape, vbinop_ : vbinop_(shape), vec_ : vec_(V128_vnn), vec_ : vec_(V128_vnn)) : vec_(V128_vnn)*
  ;; 3-numerics.watsup
  def $vbinop{imm : imm, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}(`%X%`((imm : imm <: lanetype), `%`(N)), ADD_vbinop_(`%X%`((imm : imm <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $iadd($lsize((imm : imm <: lanetype)), lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{imm : imm, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}(`%X%`((imm : imm <: lanetype), `%`(N)), SUB_vbinop_(`%X%`((imm : imm <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $isub($lsize((imm : imm <: lanetype)), lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{imm : imm, N : N, sx : sx, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}(`%X%`((imm : imm <: lanetype), `%`(N)), MIN_vbinop_(`%X%`((imm : imm <: lanetype), `%`(N)))(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $imin($lsize((imm : imm <: lanetype)), sx, lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{imm : imm, N : N, sx : sx, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}(`%X%`((imm : imm <: lanetype), `%`(N)), MAX_vbinop_(`%X%`((imm : imm <: lanetype), `%`(N)))(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $imax($lsize((imm : imm <: lanetype)), sx, lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{imm : imm, N : N, sx : sx, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}(`%X%`((imm : imm <: lanetype), `%`(N)), ADD_SAT_vbinop_(`%X%`((imm : imm <: lanetype), `%`(N)))(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $iaddsat($lsize((imm : imm <: lanetype)), sx, lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{imm : imm, N : N, sx : sx, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}(`%X%`((imm : imm <: lanetype), `%`(N)), SUB_SAT_vbinop_(`%X%`((imm : imm <: lanetype), `%`(N)))(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $isubsat($lsize((imm : imm <: lanetype)), sx, lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{imm : imm, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}(`%X%`((imm : imm <: lanetype), `%`(N)), MUL_vbinop_(`%X%`((imm : imm <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $imul($lsize((imm : imm <: lanetype)), lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{imm : imm, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}(`%X%`((imm : imm <: lanetype), `%`(N)), AVGR_U_vbinop_(`%X%`((imm : imm <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $iavgr_u($lsize((imm : imm <: lanetype)), lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{imm : imm, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}(`%X%`((imm : imm <: lanetype), `%`(N)), Q15MULR_SAT_S_vbinop_(`%X%`((imm : imm <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $iq15mulrsat_s($lsize((imm : imm <: lanetype)), lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), ADD_vbinop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fadd($size((fnn : fnn <: numtype)), lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), SUB_vbinop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fsub($size((fnn : fnn <: numtype)), lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), MUL_vbinop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fmul($size((fnn : fnn <: numtype)), lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), DIV_vbinop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fdiv($size((fnn : fnn <: numtype)), lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), MIN_vbinop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fmin($size((fnn : fnn <: numtype)), lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), MAX_vbinop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fmax($size((fnn : fnn <: numtype)), lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), PMIN_vbinop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fpmin($size((fnn : fnn <: numtype)), lane_1, lane_2)*{lane_1 lane_2})])
  ;; 3-numerics.watsup
  def $vbinop{fnn : fnn, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn)*, lane_1* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((fnn : fnn <: lanetype), `%`(N))))*}(`%X%`((fnn : fnn <: lanetype), `%`(N)), PMAX_vbinop_(`%X%`((fnn : fnn <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`((fnn : fnn <: lanetype), `%`(N)), $fpmax($size((fnn : fnn <: numtype)), lane_1, lane_2)*{lane_1 lane_2})])

;; 3-numerics.watsup
def $vrelop(shape : shape, vrelop_ : vrelop_(shape), vec_ : vec_(V128_vnn), vec_ : vec_(V128_vnn)) : vec_(V128_vnn)
  ;; 3-numerics.watsup
  def $vrelop{imm : imm, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_3* : iN($lsize((imm : imm <: lanetype)))*}(`%X%`((imm : imm <: lanetype), `%`(N)), EQ_vrelop_(`%X%`((imm : imm <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, $lsize((imm : imm <: lanetype)), S_sx, `%`($ieq($lsize((imm : imm <: lanetype)), lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{imm : imm, N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_3* : iN($lsize((imm : imm <: lanetype)))*}(`%X%`((imm : imm <: lanetype), `%`(N)), NE_vrelop_(`%X%`((imm : imm <: lanetype), `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, $lsize((imm : imm <: lanetype)), S_sx, `%`($ine($lsize((imm : imm <: lanetype)), lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{imm : imm, N : N, sx : sx, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_3* : iN($lsize((imm : imm <: lanetype)))*}(`%X%`((imm : imm <: lanetype), `%`(N)), LT_vrelop_(`%X%`((imm : imm <: lanetype), `%`(N)))(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, $lsize((imm : imm <: lanetype)), S_sx, `%`($ilt($lsize((imm : imm <: lanetype)), sx, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{imm : imm, N : N, sx : sx, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_3* : iN($lsize((imm : imm <: lanetype)))*}(`%X%`((imm : imm <: lanetype), `%`(N)), GT_vrelop_(`%X%`((imm : imm <: lanetype), `%`(N)))(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, $lsize((imm : imm <: lanetype)), S_sx, `%`($igt($lsize((imm : imm <: lanetype)), sx, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{imm : imm, N : N, sx : sx, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_3* : iN($lsize((imm : imm <: lanetype)))*}(`%X%`((imm : imm <: lanetype), `%`(N)), LE_vrelop_(`%X%`((imm : imm <: lanetype), `%`(N)))(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, $lsize((imm : imm <: lanetype)), S_sx, `%`($ile($lsize((imm : imm <: lanetype)), sx, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{imm : imm, N : N, sx : sx, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_2* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*, lane_3* : iN($lsize((imm : imm <: lanetype)))*}(`%X%`((imm : imm <: lanetype), `%`(N)), GE_vrelop_(`%X%`((imm : imm <: lanetype), `%`(N)))(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, $lsize((imm : imm <: lanetype)), S_sx, `%`($ige($lsize((imm : imm <: lanetype)), sx, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`(F32_lanetype, `%`(N))))*, lane_2* : lane_($lanetype(`%X%`(F32_lanetype, `%`(N))))*, lane_3* : iN(32)*}(`%X%`(F32_lanetype, `%`(N)), EQ_vrelop_(`%X%`(F32_lanetype, `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`(F32_lanetype, `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`(F32_lanetype, `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, 32, S_sx, `%`($feq(32, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`(I32_lanetype, `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`(F32_lanetype, `%`(N))))*, lane_2* : lane_($lanetype(`%X%`(F32_lanetype, `%`(N))))*, lane_3* : iN(32)*}(`%X%`(F32_lanetype, `%`(N)), NE_vrelop_(`%X%`(F32_lanetype, `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`(F32_lanetype, `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`(F32_lanetype, `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, 32, S_sx, `%`($fne(32, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`(I32_lanetype, `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`(F32_lanetype, `%`(N))))*, lane_2* : lane_($lanetype(`%X%`(F32_lanetype, `%`(N))))*, lane_3* : iN(32)*}(`%X%`(F32_lanetype, `%`(N)), LT_vrelop_(`%X%`(F32_lanetype, `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`(F32_lanetype, `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`(F32_lanetype, `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, 32, S_sx, `%`($flt(32, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`(I32_lanetype, `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`(F32_lanetype, `%`(N))))*, lane_2* : lane_($lanetype(`%X%`(F32_lanetype, `%`(N))))*, lane_3* : iN(32)*}(`%X%`(F32_lanetype, `%`(N)), GT_vrelop_(`%X%`(F32_lanetype, `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`(F32_lanetype, `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`(F32_lanetype, `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, 32, S_sx, `%`($fgt(32, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`(I32_lanetype, `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`(F32_lanetype, `%`(N))))*, lane_2* : lane_($lanetype(`%X%`(F32_lanetype, `%`(N))))*, lane_3* : iN(32)*}(`%X%`(F32_lanetype, `%`(N)), LE_vrelop_(`%X%`(F32_lanetype, `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`(F32_lanetype, `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`(F32_lanetype, `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, 32, S_sx, `%`($fle(32, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`(I32_lanetype, `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`(F32_lanetype, `%`(N))))*, lane_2* : lane_($lanetype(`%X%`(F32_lanetype, `%`(N))))*, lane_3* : iN(32)*}(`%X%`(F32_lanetype, `%`(N)), GE_vrelop_(`%X%`(F32_lanetype, `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`(F32_lanetype, `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`(F32_lanetype, `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, 32, S_sx, `%`($fge(32, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`(I32_lanetype, `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`(F64_lanetype, `%`(N))))*, lane_2* : lane_($lanetype(`%X%`(F64_lanetype, `%`(N))))*, lane_3* : iN(64)*}(`%X%`(F64_lanetype, `%`(N)), EQ_vrelop_(`%X%`(F64_lanetype, `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`(F64_lanetype, `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`(F64_lanetype, `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, 64, S_sx, `%`($feq(64, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`(I64_lanetype, `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`(F64_lanetype, `%`(N))))*, lane_2* : lane_($lanetype(`%X%`(F64_lanetype, `%`(N))))*, lane_3* : iN(64)*}(`%X%`(F64_lanetype, `%`(N)), NE_vrelop_(`%X%`(F64_lanetype, `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`(F64_lanetype, `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`(F64_lanetype, `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, 64, S_sx, `%`($fne(64, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`(I64_lanetype, `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`(F64_lanetype, `%`(N))))*, lane_2* : lane_($lanetype(`%X%`(F64_lanetype, `%`(N))))*, lane_3* : iN(64)*}(`%X%`(F64_lanetype, `%`(N)), LT_vrelop_(`%X%`(F64_lanetype, `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`(F64_lanetype, `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`(F64_lanetype, `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, 64, S_sx, `%`($flt(64, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`(I64_lanetype, `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`(F64_lanetype, `%`(N))))*, lane_2* : lane_($lanetype(`%X%`(F64_lanetype, `%`(N))))*, lane_3* : iN(64)*}(`%X%`(F64_lanetype, `%`(N)), GT_vrelop_(`%X%`(F64_lanetype, `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`(F64_lanetype, `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`(F64_lanetype, `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, 64, S_sx, `%`($fgt(64, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`(I64_lanetype, `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`(F64_lanetype, `%`(N))))*, lane_2* : lane_($lanetype(`%X%`(F64_lanetype, `%`(N))))*, lane_3* : iN(64)*}(`%X%`(F64_lanetype, `%`(N)), LE_vrelop_(`%X%`(F64_lanetype, `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`(F64_lanetype, `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`(F64_lanetype, `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, 64, S_sx, `%`($fle(64, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`(I64_lanetype, `%`(N)), lane_3*{lane_3}))
  ;; 3-numerics.watsup
  def $vrelop{N : N, v128_1 : vec_(V128_vnn), v128_2 : vec_(V128_vnn), v128 : vec_(V128_vnn), lane_1* : lane_($lanetype(`%X%`(F64_lanetype, `%`(N))))*, lane_2* : lane_($lanetype(`%X%`(F64_lanetype, `%`(N))))*, lane_3* : iN(64)*}(`%X%`(F64_lanetype, `%`(N)), GE_vrelop_(`%X%`(F64_lanetype, `%`(N))), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1} = $lanes_(`%X%`(F64_lanetype, `%`(N)), v128_1))
    -- if (lane_2*{lane_2} = $lanes_(`%X%`(F64_lanetype, `%`(N)), v128_2))
    -- if (lane_3*{lane_3} = $ext(1, 64, S_sx, `%`($fge(64, lane_1, lane_2).`%`.0))*{lane_1 lane_2})
    -- if (v128 = $invlanes_(`%X%`(I64_lanetype, `%`(N)), lane_3*{lane_3}))

;; 3-numerics.watsup
def $vcvtop(shape_1 : shape, shape_2 : shape, vcvtop : vcvtop, sx?, lane_ : lane_($lanetype(shape_1))) : lane_($lanetype(shape_2))

;; 3-numerics.watsup
def $vextunop(ishape_1 : ishape, ishape_2 : ishape, vextunop_ : vextunop_(ishape_1, ishape_2), sx : sx, vec_ : vec_(V128_vnn)) : vec_(V128_vnn)

;; 3-numerics.watsup
def $vextbinop(ishape_1 : ishape, ishape_2 : ishape, vextbinop_ : vextbinop_(ishape_1, ishape_2), sx : sx, vec_ : vec_(V128_vnn), vec_ : vec_(V128_vnn)) : vec_(V128_vnn)

;; 3-numerics.watsup
def $vishiftop(ishape : ishape, vshiftop_ : vshiftop_(ishape), lane_ : lane_($lanetype((ishape : ishape <: shape))), u32 : u32) : lane_($lanetype((ishape : ishape <: shape)))
  ;; 3-numerics.watsup
  def $vishiftop{imm : imm, N : N, lane : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N)))), n : n}(`%X%`(imm, `%`(N)), SHL_vshiftop_(`%X%`(imm, `%`(N))), lane, `%`(n)) = $ishl($lsize((imm : imm <: lanetype)), lane, `%`(n))
  ;; 3-numerics.watsup
  def $vishiftop{imm : imm, N : N, sx : sx, lane : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N)))), n : n}(`%X%`(imm, `%`(N)), SHR_vshiftop_(`%X%`(imm, `%`(N)))(sx), lane, `%`(n)) = $ishr($lsize((imm : imm <: lanetype)), sx, lane, `%`(n))

;; 4-runtime.watsup
syntax addr = nat

;; 4-runtime.watsup
syntax funcaddr = addr

;; 4-runtime.watsup
syntax globaladdr = addr

;; 4-runtime.watsup
syntax tableaddr = addr

;; 4-runtime.watsup
syntax memaddr = addr

;; 4-runtime.watsup
syntax elemaddr = addr

;; 4-runtime.watsup
syntax dataaddr = addr

;; 4-runtime.watsup
syntax hostaddr = addr

;; 4-runtime.watsup
syntax structaddr = addr

;; 4-runtime.watsup
syntax arrayaddr = addr

;; 4-runtime.watsup
syntax num =
  | CONST(numtype : numtype, num_ : num_(numtype))

;; 4-runtime.watsup
syntax vec =
  | VCONST(vectype : vectype, vec_ : vec_(vectype))

;; 4-runtime.watsup
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

;; 4-runtime.watsup
syntax ref =
  | REF.I31_NUM(u31 : u31)
  | REF.STRUCT_ADDR(structaddr : structaddr)
  | REF.ARRAY_ADDR(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR(funcaddr : funcaddr)
  | REF.HOST_ADDR(hostaddr : hostaddr)
  | REF.EXTERN(addrref : addrref)
  | REF.NULL(heaptype : heaptype)

;; 4-runtime.watsup
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

;; 4-runtime.watsup
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup
syntax externval =
  | FUNC(funcaddr : funcaddr)
  | GLOBAL(globaladdr : globaladdr)
  | TABLE(tableaddr : tableaddr)
  | MEM(memaddr : memaddr)

;; 4-runtime.watsup
syntax exportinst =
{
  NAME name,
  VALUE externval
}

;; 4-runtime.watsup
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

;; 4-runtime.watsup
syntax funcinst =
{
  TYPE deftype,
  MODULE moduleinst,
  CODE func
}

;; 4-runtime.watsup
syntax globalinst =
{
  TYPE globaltype,
  VALUE val
}

;; 4-runtime.watsup
syntax tableinst =
{
  TYPE tabletype,
  ELEM ref*
}

;; 4-runtime.watsup
syntax meminst =
{
  TYPE memtype,
  DATA byte*
}

;; 4-runtime.watsup
syntax eleminst =
{
  TYPE elemtype,
  ELEM ref*
}

;; 4-runtime.watsup
syntax datainst =
{
  DATA byte*
}

;; 4-runtime.watsup
syntax packval =
  | PACK(packtype : packtype, pack_ : pack_(packtype))

;; 4-runtime.watsup
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

;; 4-runtime.watsup
syntax structinst =
{
  TYPE deftype,
  FIELD fieldval*
}

;; 4-runtime.watsup
syntax arrayinst =
{
  TYPE deftype,
  FIELD fieldval*
}

;; 4-runtime.watsup
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

;; 4-runtime.watsup
syntax frame =
{
  LOCAL val?*,
  MODULE moduleinst
}

;; 4-runtime.watsup
syntax state = `%;%`(store : store, frame : frame)

;; 4-runtime.watsup
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
  | CVTOP(numtype_1 : numtype, cvtop : cvtop, numtype_2 : numtype, sx?)
  | EXTEND(numtype : numtype, n : n)
  | VCONST(vectype : vectype, vec_ : vec_(vectype))
  | VVUNOP(vectype : vectype, vvunop : vvunop)
  | VVBINOP(vectype : vectype, vvbinop : vvbinop)
  | VVTERNOP(vectype : vectype, vvternop : vvternop)
  | VVTESTOP(vectype : vectype, vvtestop : vvtestop)
  | VSWIZZLE{ishape : ishape}(ishape : ishape)
    -- if (ishape = `%X%`(I8_imm, `%`(16)))
  | VSHUFFLE{ishape : ishape, laneidx* : laneidx*}(ishape : ishape, laneidx*)
    -- if ((ishape = `%X%`(I8_imm, `%`(16))) /\ (|laneidx*{laneidx}| = $dim((ishape : ishape <: shape)).`%`.0))
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
  | ARRAY.NEW_FIXED(typeidx : typeidx, nat : nat)
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

;; 4-runtime.watsup
syntax config = `%;%*`(state : state, admininstr*)

;; 4-runtime.watsup
rec {

;; 4-runtime.watsup:165.1-168.25
syntax E =
  | _HOLE
  | _SEQ(val*, E : E, instr*)
  | LABEL_(n : n, instr*, E : E)
}

;; 5-runtime-aux.watsup
def $inst_reftype(moduleinst : moduleinst, reftype : reftype) : reftype
  ;; 5-runtime-aux.watsup
  def $inst_reftype{mm : moduleinst, rt : reftype, dt* : deftype*}(mm, rt) = $subst_all_reftype(rt, (dt : deftype <: heaptype)*{dt})
    -- if (dt*{dt} = mm.TYPE_moduleinst)

;; 5-runtime-aux.watsup
def $default(valtype : valtype) : val?
  ;; 5-runtime-aux.watsup
  def $default(I32_valtype) = ?(CONST_val(I32_numtype, `%`(0)))
  ;; 5-runtime-aux.watsup
  def $default(I64_valtype) = ?(CONST_val(I64_numtype, `%`(0)))
  ;; 5-runtime-aux.watsup
  def $default(F32_valtype) = ?(CONST_val(F32_numtype, $fzero(32)))
  ;; 5-runtime-aux.watsup
  def $default(F64_valtype) = ?(CONST_val(F64_numtype, $fzero(64)))
  ;; 5-runtime-aux.watsup
  def $default(V128_valtype) = ?(VCONST_val(V128_vectype, `%`(0)))
  ;; 5-runtime-aux.watsup
  def $default{ht : heaptype}(REF_valtype(`NULL%?`(?(())), ht)) = ?(REF.NULL_val(ht))
  ;; 5-runtime-aux.watsup
  def $default{ht : heaptype}(REF_valtype(`NULL%?`(?()), ht)) = ?()

;; 5-runtime-aux.watsup
def $packval(storagetype : storagetype, val : val) : fieldval
  ;; 5-runtime-aux.watsup
  def $packval{t : valtype, val : val}((t : valtype <: storagetype), val) = (val : val <: fieldval)
  ;; 5-runtime-aux.watsup
  def $packval{pt : packtype, i : nat}((pt : packtype <: storagetype), CONST_val(I32_numtype, `%`(i))) = PACK_fieldval(pt, $wrap(32, $psize(pt), `%`(i)))

;; 5-runtime-aux.watsup
def $unpackval(storagetype : storagetype, sx?, fieldval : fieldval) : val
  ;; 5-runtime-aux.watsup
  def $unpackval{t : valtype, val : val}((t : valtype <: storagetype), ?(), (val : val <: fieldval)) = val
  ;; 5-runtime-aux.watsup
  def $unpackval{pt : packtype, sx : sx, i : nat}((pt : packtype <: storagetype), ?(sx), PACK_fieldval(pt, `%`(i))) = CONST_val(I32_numtype, $ext($psize(pt), 32, sx, `%`(i)))

;; 5-runtime-aux.watsup
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

;; 5-runtime-aux.watsup
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

;; 5-runtime-aux.watsup
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

;; 5-runtime-aux.watsup
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

;; 5-runtime-aux.watsup
def $store(state : state) : store
  ;; 5-runtime-aux.watsup
  def $store{s : store, f : frame}(`%;%`(s, f)) = s

;; 5-runtime-aux.watsup
def $frame(state : state) : frame
  ;; 5-runtime-aux.watsup
  def $frame{s : store, f : frame}(`%;%`(s, f)) = f

;; 5-runtime-aux.watsup
def $funcaddr(state : state) : funcaddr*
  ;; 5-runtime-aux.watsup
  def $funcaddr{s : store, f : frame}(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 5-runtime-aux.watsup
def $funcinst(state : state) : funcinst*
  ;; 5-runtime-aux.watsup
  def $funcinst{s : store, f : frame}(`%;%`(s, f)) = s.FUNC_store

;; 5-runtime-aux.watsup
def $globalinst(state : state) : globalinst*
  ;; 5-runtime-aux.watsup
  def $globalinst{s : store, f : frame}(`%;%`(s, f)) = s.GLOBAL_store

;; 5-runtime-aux.watsup
def $tableinst(state : state) : tableinst*
  ;; 5-runtime-aux.watsup
  def $tableinst{s : store, f : frame}(`%;%`(s, f)) = s.TABLE_store

;; 5-runtime-aux.watsup
def $meminst(state : state) : meminst*
  ;; 5-runtime-aux.watsup
  def $meminst{s : store, f : frame}(`%;%`(s, f)) = s.MEM_store

;; 5-runtime-aux.watsup
def $eleminst(state : state) : eleminst*
  ;; 5-runtime-aux.watsup
  def $eleminst{s : store, f : frame}(`%;%`(s, f)) = s.ELEM_store

;; 5-runtime-aux.watsup
def $datainst(state : state) : datainst*
  ;; 5-runtime-aux.watsup
  def $datainst{s : store, f : frame}(`%;%`(s, f)) = s.DATA_store

;; 5-runtime-aux.watsup
def $structinst(state : state) : structinst*
  ;; 5-runtime-aux.watsup
  def $structinst{s : store, f : frame}(`%;%`(s, f)) = s.STRUCT_store

;; 5-runtime-aux.watsup
def $arrayinst(state : state) : arrayinst*
  ;; 5-runtime-aux.watsup
  def $arrayinst{s : store, f : frame}(`%;%`(s, f)) = s.ARRAY_store

;; 5-runtime-aux.watsup
def $moduleinst(state : state) : moduleinst
  ;; 5-runtime-aux.watsup
  def $moduleinst{s : store, f : frame}(`%;%`(s, f)) = f.MODULE_frame

;; 5-runtime-aux.watsup
def $type(state : state, typeidx : typeidx) : deftype
  ;; 5-runtime-aux.watsup
  def $type{s : store, f : frame, x : idx}(`%;%`(s, f), x) = f.MODULE_frame.TYPE_moduleinst[x.`%`.0]

;; 5-runtime-aux.watsup
def $func(state : state, funcidx : funcidx) : funcinst
  ;; 5-runtime-aux.watsup
  def $func{s : store, f : frame, x : idx}(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x.`%`.0]]

;; 5-runtime-aux.watsup
def $global(state : state, globalidx : globalidx) : globalinst
  ;; 5-runtime-aux.watsup
  def $global{s : store, f : frame, x : idx}(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x.`%`.0]]

;; 5-runtime-aux.watsup
def $table(state : state, tableidx : tableidx) : tableinst
  ;; 5-runtime-aux.watsup
  def $table{s : store, f : frame, x : idx}(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x.`%`.0]]

;; 5-runtime-aux.watsup
def $mem(state : state, memidx : memidx) : meminst
  ;; 5-runtime-aux.watsup
  def $mem{s : store, f : frame, x : idx}(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x.`%`.0]]

;; 5-runtime-aux.watsup
def $elem(state : state, tableidx : tableidx) : eleminst
  ;; 5-runtime-aux.watsup
  def $elem{s : store, f : frame, x : idx}(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x.`%`.0]]

;; 5-runtime-aux.watsup
def $data(state : state, dataidx : dataidx) : datainst
  ;; 5-runtime-aux.watsup
  def $data{s : store, f : frame, x : idx}(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x.`%`.0]]

;; 5-runtime-aux.watsup
def $local(state : state, localidx : localidx) : val?
  ;; 5-runtime-aux.watsup
  def $local{s : store, f : frame, x : idx}(`%;%`(s, f), x) = f.LOCAL_frame[x.`%`.0]

;; 5-runtime-aux.watsup
def $with_local(state : state, localidx : localidx, val : val) : state
  ;; 5-runtime-aux.watsup
  def $with_local{s : store, f : frame, x : idx, v : val}(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x.`%`.0] = ?(v)])

;; 5-runtime-aux.watsup
def $with_global(state : state, globalidx : globalidx, val : val) : state
  ;; 5-runtime-aux.watsup
  def $with_global{s : store, f : frame, x : idx, v : val}(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x.`%`.0]].VALUE_globalinst = v], f)

;; 5-runtime-aux.watsup
def $with_table(state : state, tableidx : tableidx, nat : nat, ref : ref) : state
  ;; 5-runtime-aux.watsup
  def $with_table{s : store, f : frame, x : idx, i : nat, r : ref}(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x.`%`.0]].ELEM_tableinst[i] = r], f)

;; 5-runtime-aux.watsup
def $with_tableinst(state : state, tableidx : tableidx, tableinst : tableinst) : state
  ;; 5-runtime-aux.watsup
  def $with_tableinst{s : store, f : frame, x : idx, ti : tableinst}(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x.`%`.0]] = ti], f)

;; 5-runtime-aux.watsup
def $with_mem(state : state, memidx : memidx, nat : nat, nat : nat, byte*) : state
  ;; 5-runtime-aux.watsup
  def $with_mem{s : store, f : frame, x : idx, i : nat, j : nat, b* : byte*}(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x.`%`.0]].DATA_meminst[i : j] = b*{b}], f)

;; 5-runtime-aux.watsup
def $with_meminst(state : state, memidx : memidx, meminst : meminst) : state
  ;; 5-runtime-aux.watsup
  def $with_meminst{s : store, f : frame, x : idx, mi : meminst}(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x.`%`.0]] = mi], f)

;; 5-runtime-aux.watsup
def $with_elem(state : state, elemidx : elemidx, ref*) : state
  ;; 5-runtime-aux.watsup
  def $with_elem{s : store, f : frame, x : idx, r* : ref*}(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x.`%`.0]].ELEM_eleminst = r*{r}], f)

;; 5-runtime-aux.watsup
def $with_data(state : state, dataidx : dataidx, byte*) : state
  ;; 5-runtime-aux.watsup
  def $with_data{s : store, f : frame, x : idx, b* : byte*}(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x.`%`.0]].DATA_datainst = b*{b}], f)

;; 5-runtime-aux.watsup
def $with_struct(state : state, structaddr : structaddr, nat : nat, fieldval : fieldval) : state
  ;; 5-runtime-aux.watsup
  def $with_struct{s : store, f : frame, a : addr, i : nat, fv : fieldval}(`%;%`(s, f), a, i, fv) = `%;%`(s[STRUCT_store[a].FIELD_structinst[i] = fv], f)

;; 5-runtime-aux.watsup
def $with_array(state : state, arrayaddr : arrayaddr, nat : nat, fieldval : fieldval) : state
  ;; 5-runtime-aux.watsup
  def $with_array{s : store, f : frame, a : addr, i : nat, fv : fieldval}(`%;%`(s, f), a, i, fv) = `%;%`(s[ARRAY_store[a].FIELD_arrayinst[i] = fv], f)

;; 5-runtime-aux.watsup
def $ext_structinst(state : state, structinst*) : state
  ;; 5-runtime-aux.watsup
  def $ext_structinst{s : store, f : frame, si* : structinst*}(`%;%`(s, f), si*{si}) = `%;%`(s[STRUCT_store =.. si*{si}], f)

;; 5-runtime-aux.watsup
def $ext_arrayinst(state : state, arrayinst*) : state
  ;; 5-runtime-aux.watsup
  def $ext_arrayinst{s : store, f : frame, ai* : arrayinst*}(`%;%`(s, f), ai*{ai}) = `%;%`(s[ARRAY_store =.. ai*{ai}], f)

;; 5-runtime-aux.watsup
def $growtable(tableinst : tableinst, nat : nat, ref : ref) : tableinst
  ;; 5-runtime-aux.watsup
  def $growtable{ti : tableinst, n : n, r : ref, ti' : tableinst, i : nat, j : nat, rt : reftype, r'* : ref*, i' : nat}(ti, n, r) = ti'
    -- if (ti = {TYPE `%%`(`[%..%]`(`%`(i), `%`(j)), rt), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%]`(`%`(i'), `%`(j)), rt), ELEM r'*{r'} :: r^n{}})
    -- if (i' <= j)

;; 5-runtime-aux.watsup
def $growmemory(meminst : meminst, nat : nat) : meminst
  ;; 5-runtime-aux.watsup
  def $growmemory{mi : meminst, n : n, mi' : meminst, i : nat, j : nat, b* : byte*, i' : nat}(mi, n) = mi'
    -- if (mi = {TYPE `%I8`(`[%..%]`(`%`(i), `%`(j))), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%]`(`%`(i'), `%`(j))), DATA b*{b} :: `%`(0)^((n * 64) * $Ki){}})
    -- if (i' <= j)

;; 6-typing.watsup
syntax init =
  | SET
  | UNSET

;; 6-typing.watsup
syntax localtype = `%%`(init : init, valtype : valtype)

;; 6-typing.watsup
syntax instrtype = `%->%*%`(resulttype : resulttype, localidx*, resulttype : resulttype)

;; 6-typing.watsup
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

;; 6-typing.watsup
rec {

;; 6-typing.watsup:26.1-26.86
def $with_locals(context : context, localidx*, localtype*) : context
  ;; 6-typing.watsup:28.1-28.34
  def $with_locals{C : context}(C, [], []) = C
  ;; 6-typing.watsup:29.1-29.85
  def $with_locals{C : context, x_1 : idx, x* : idx*, lt_1 : localtype, lt* : localtype*}(C, [x_1] :: x*{x}, [lt_1] :: lt*{lt}) = $with_locals(C[LOCAL_context[x_1.`%`.0] = lt_1], x*{x}, lt*{lt})
}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:33.1-33.65
def $clostypes(deftype*) : deftype*
  ;; 6-typing.watsup:37.1-37.26
  def $clostypes([]) = []
  ;; 6-typing.watsup:38.1-38.93
  def $clostypes{dt* : deftype*, dt_N : deftype, dt'* : deftype*}(dt*{dt} :: [dt_N]) = dt'*{dt'} :: [$subst_all_deftype(dt_N, (dt' : deftype <: heaptype)*{dt'})]
    -- if (dt'*{dt'} = $clostypes(dt*{dt}))
}

;; 6-typing.watsup
def $clostype(context : context, deftype : deftype) : deftype
  ;; 6-typing.watsup
  def $clostype{C : context, dt : deftype, dt'* : deftype*}(C, dt) = $subst_all_deftype(dt, (dt' : deftype <: heaptype)*{dt'})
    -- if (dt'*{dt'} = $clostypes(C.TYPE_context))

;; 6-typing.watsup
relation Numtype_ok: `%|-%:_OK`(context, numtype)
  ;; 6-typing.watsup
  rule _{C : context, numtype : numtype}:
    `%|-%:_OK`(C, numtype)

;; 6-typing.watsup
relation Vectype_ok: `%|-%:_OK`(context, vectype)
  ;; 6-typing.watsup
  rule _{C : context, vectype : vectype}:
    `%|-%:_OK`(C, vectype)

;; 6-typing.watsup
relation Heaptype_ok: `%|-%:_OK`(context, heaptype)
  ;; 6-typing.watsup
  rule abs{C : context, absheaptype : absheaptype}:
    `%|-%:_OK`(C, (absheaptype : absheaptype <: heaptype))

  ;; 6-typing.watsup
  rule typeidx{C : context, x : idx, dt : deftype}:
    `%|-%:_OK`(C, _IDX_heaptype(x))
    -- if (C.TYPE_context[x.`%`.0] = dt)

  ;; 6-typing.watsup
  rule rec{C : context, i : nat, st : subtype}:
    `%|-%:_OK`(C, REC_heaptype(i))
    -- if (C.REC_context[i] = st)

;; 6-typing.watsup
relation Reftype_ok: `%|-%:_OK`(context, reftype)
  ;; 6-typing.watsup
  rule _{C : context, nul : nul, ht : heaptype}:
    `%|-%:_OK`(C, REF_reftype(nul, ht))
    -- Heaptype_ok: `%|-%:_OK`(C, ht)

;; 6-typing.watsup
relation Valtype_ok: `%|-%:_OK`(context, valtype)
  ;; 6-typing.watsup
  rule num{C : context, numtype : numtype}:
    `%|-%:_OK`(C, (numtype : numtype <: valtype))
    -- Numtype_ok: `%|-%:_OK`(C, numtype)

  ;; 6-typing.watsup
  rule vec{C : context, vectype : vectype}:
    `%|-%:_OK`(C, (vectype : vectype <: valtype))
    -- Vectype_ok: `%|-%:_OK`(C, vectype)

  ;; 6-typing.watsup
  rule ref{C : context, reftype : reftype}:
    `%|-%:_OK`(C, (reftype : reftype <: valtype))
    -- Reftype_ok: `%|-%:_OK`(C, reftype)

  ;; 6-typing.watsup
  rule bot{C : context}:
    `%|-%:_OK`(C, BOT_valtype)

;; 6-typing.watsup
relation Resulttype_ok: `%|-%:_OK`(context, resulttype)
  ;; 6-typing.watsup
  rule _{C : context, t* : valtype*}:
    `%|-%:_OK`(C, t*{t})
    -- (Valtype_ok: `%|-%:_OK`(C, t))*{t}

;; 6-typing.watsup
relation Instrtype_ok: `%|-%:_OK`(context, instrtype)
  ;; 6-typing.watsup
  rule _{C : context, t_1* : valtype*, x* : idx*, t_2* : valtype*, lt* : localtype*}:
    `%|-%:_OK`(C, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))
    -- Resulttype_ok: `%|-%:_OK`(C, t_1*{t_1})
    -- Resulttype_ok: `%|-%:_OK`(C, t_2*{t_2})
    -- (if (C.LOCAL_context[x.`%`.0] = lt))*{lt x}

;; 6-typing.watsup
syntax oktypeidx =
  | OK(typeidx : typeidx)

;; 6-typing.watsup
syntax oktypeidxnat =
  | OK(typeidx : typeidx, nat : nat)

;; 6-typing.watsup
relation Packtype_ok: `%|-%:_OK`(context, packtype)
  ;; 6-typing.watsup
  rule _{C : context, packtype : packtype}:
    `%|-%:_OK`(C, packtype)

;; 6-typing.watsup
relation Storagetype_ok: `%|-%:_OK`(context, storagetype)
  ;; 6-typing.watsup
  rule val{C : context, valtype : valtype}:
    `%|-%:_OK`(C, (valtype : valtype <: storagetype))
    -- Valtype_ok: `%|-%:_OK`(C, valtype)

  ;; 6-typing.watsup
  rule pack{C : context, packtype : packtype}:
    `%|-%:_OK`(C, (packtype : packtype <: storagetype))
    -- Packtype_ok: `%|-%:_OK`(C, packtype)

;; 6-typing.watsup
relation Fieldtype_ok: `%|-%:_OK`(context, fieldtype)
  ;; 6-typing.watsup
  rule _{C : context, mut : mut, zt : storagetype}:
    `%|-%:_OK`(C, `%%`(mut, zt))
    -- Storagetype_ok: `%|-%:_OK`(C, zt)

;; 6-typing.watsup
relation Functype_ok: `%|-%:_OK`(context, functype)
  ;; 6-typing.watsup
  rule _{C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:_OK`(C, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_ok: `%|-%:_OK`(C, t_1*{t_1})
    -- Resulttype_ok: `%|-%:_OK`(C, t_2*{t_2})

;; 6-typing.watsup
relation Comptype_ok: `%|-%:_OK`(context, comptype)
  ;; 6-typing.watsup
  rule struct{C : context, yt* : fieldtype*}:
    `%|-%:_OK`(C, STRUCT_comptype(yt*{yt}))
    -- (Fieldtype_ok: `%|-%:_OK`(C, yt))*{yt}

  ;; 6-typing.watsup
  rule array{C : context, yt : fieldtype}:
    `%|-%:_OK`(C, ARRAY_comptype(yt))
    -- Fieldtype_ok: `%|-%:_OK`(C, yt)

  ;; 6-typing.watsup
  rule func{C : context, ft : functype}:
    `%|-%:_OK`(C, FUNC_comptype(ft))
    -- Functype_ok: `%|-%:_OK`(C, ft)

;; 6-typing.watsup
relation Packtype_sub: `%|-%<:%`(context, packtype, packtype)
  ;; 6-typing.watsup
  rule _{C : context, packtype : packtype}:
    `%|-%<:%`(C, packtype, packtype)

;; 6-typing.watsup
relation Numtype_sub: `%|-%<:%`(context, numtype, numtype)
  ;; 6-typing.watsup
  rule _{C : context, numtype : numtype}:
    `%|-%<:%`(C, numtype, numtype)

;; 6-typing.watsup
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
    -- Heaptype_sub: `%|-%<:%`(C, (C.TYPE_context[typeidx.`%`.0] : deftype <: heaptype), heaptype)

  ;; 6-typing.watsup:323.1-325.52
  rule typeidx-r{C : context, heaptype : heaptype, typeidx : typeidx}:
    `%|-%<:%`(C, heaptype, _IDX_heaptype(typeidx))
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, (C.TYPE_context[typeidx.`%`.0] : deftype <: heaptype))

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

;; 6-typing.watsup
relation Reftype_sub: `%|-%<:%`(context, reftype, reftype)
  ;; 6-typing.watsup
  rule nonnull{C : context, ht_1 : heaptype, ht_2 : heaptype}:
    `%|-%<:%`(C, REF_reftype(`NULL%?`(?()), ht_1), REF_reftype(`NULL%?`(?()), ht_2))
    -- Heaptype_sub: `%|-%<:%`(C, ht_1, ht_2)

  ;; 6-typing.watsup
  rule null{C : context, ht_1 : heaptype, ht_2 : heaptype}:
    `%|-%<:%`(C, REF_reftype(`NULL%?`(()?{}), ht_1), REF_reftype(`NULL%?`(?(())), ht_2))
    -- Heaptype_sub: `%|-%<:%`(C, ht_1, ht_2)

;; 6-typing.watsup
relation Vectype_sub: `%|-%<:%`(context, vectype, vectype)
  ;; 6-typing.watsup
  rule _{C : context, vectype : vectype}:
    `%|-%<:%`(C, vectype, vectype)

;; 6-typing.watsup
relation Valtype_sub: `%|-%<:%`(context, valtype, valtype)
  ;; 6-typing.watsup
  rule num{C : context, numtype_1 : numtype, numtype_2 : numtype}:
    `%|-%<:%`(C, (numtype_1 : numtype <: valtype), (numtype_2 : numtype <: valtype))
    -- Numtype_sub: `%|-%<:%`(C, numtype_1, numtype_2)

  ;; 6-typing.watsup
  rule vec{C : context, vectype_1 : vectype, vectype_2 : vectype}:
    `%|-%<:%`(C, (vectype_1 : vectype <: valtype), (vectype_2 : vectype <: valtype))
    -- Vectype_sub: `%|-%<:%`(C, vectype_1, vectype_2)

  ;; 6-typing.watsup
  rule ref{C : context, reftype_1 : reftype, reftype_2 : reftype}:
    `%|-%<:%`(C, (reftype_1 : reftype <: valtype), (reftype_2 : reftype <: valtype))
    -- Reftype_sub: `%|-%<:%`(C, reftype_1, reftype_2)

  ;; 6-typing.watsup
  rule bot{C : context, valtype : valtype}:
    `%|-%<:%`(C, BOT_valtype, valtype)

;; 6-typing.watsup
relation Storagetype_sub: `%|-%<:%`(context, storagetype, storagetype)
  ;; 6-typing.watsup
  rule val{C : context, valtype_1 : valtype, valtype_2 : valtype}:
    `%|-%<:%`(C, (valtype_1 : valtype <: storagetype), (valtype_2 : valtype <: storagetype))
    -- Valtype_sub: `%|-%<:%`(C, valtype_1, valtype_2)

  ;; 6-typing.watsup
  rule pack{C : context, packtype_1 : packtype, packtype_2 : packtype}:
    `%|-%<:%`(C, (packtype_1 : packtype <: storagetype), (packtype_2 : packtype <: storagetype))
    -- Packtype_sub: `%|-%<:%`(C, packtype_1, packtype_2)

;; 6-typing.watsup
relation Fieldtype_sub: `%|-%<:%`(context, fieldtype, fieldtype)
  ;; 6-typing.watsup
  rule const{C : context, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?()), zt_1), `%%`(`MUT%?`(?()), zt_2))
    -- Storagetype_sub: `%|-%<:%`(C, zt_1, zt_2)

  ;; 6-typing.watsup
  rule var{C : context, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?(())), zt_1), `%%`(`MUT%?`(?(())), zt_2))
    -- Storagetype_sub: `%|-%<:%`(C, zt_1, zt_2)
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

;; 6-typing.watsup
relation Functype_sub: `%|-%<:%`(context, functype, functype)
  ;; 6-typing.watsup
  rule _{C : context, ft : functype}:
    `%|-%<:%`(C, ft, ft)

;; 6-typing.watsup
relation Comptype_sub: `%|-%<:%`(context, comptype, comptype)
  ;; 6-typing.watsup
  rule struct{C : context, yt_1* : fieldtype*, yt'_1 : fieldtype, yt_2* : fieldtype*}:
    `%|-%<:%`(C, STRUCT_comptype(yt_1*{yt_1} :: [yt'_1]), STRUCT_comptype(yt_2*{yt_2}))
    -- (Fieldtype_sub: `%|-%<:%`(C, yt_1, yt_2))*{yt_1 yt_2}

  ;; 6-typing.watsup
  rule array{C : context, yt_1 : fieldtype, yt_2 : fieldtype}:
    `%|-%<:%`(C, ARRAY_comptype(yt_1), ARRAY_comptype(yt_2))
    -- Fieldtype_sub: `%|-%<:%`(C, yt_1, yt_2)

  ;; 6-typing.watsup
  rule func{C : context, ft_1 : functype, ft_2 : functype}:
    `%|-%<:%`(C, FUNC_comptype(ft_1), FUNC_comptype(ft_2))
    -- Functype_sub: `%|-%<:%`(C, ft_1, ft_2)

;; 6-typing.watsup
relation Subtype_ok: `%|-%:%`(context, subtype, oktypeidx)
  ;; 6-typing.watsup
  rule _{C : context, fin : fin, y* : idx*, ct : comptype, x : idx, y'** : idx**, ct'* : comptype*}:
    `%|-%:%`(C, SUB_subtype(fin, y*{y}, ct), OK_oktypeidx(x))
    -- if (|y*{y}| <= 1)
    -- (if (y.`%`.0 < x.`%`.0))*{y}
    -- (if ($unrolldt(C.TYPE_context[y.`%`.0]) = SUB_subtype(`FINAL%?`(?()), y'*{y'}, ct')))*{ct' y y'}
    -- Comptype_ok: `%|-%:_OK`(C, ct)
    -- (Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}

;; 6-typing.watsup
def $before(heaptype : heaptype, typeidx : typeidx, nat : nat) : bool
  ;; 6-typing.watsup
  def $before{deftype : deftype, x : idx, i : nat}((deftype : deftype <: heaptype), x, i) = true
  ;; 6-typing.watsup
  def $before{typeidx : typeidx, x : idx, i : nat}(_IDX_heaptype(typeidx), x, i) = (typeidx.`%`.0 < x.`%`.0)
  ;; 6-typing.watsup
  def $before{j : nat, x : idx, i : nat}(REC_heaptype(j), x, i) = (j < i)

;; 6-typing.watsup
def $unrollht(context : context, heaptype : heaptype) : subtype
  ;; 6-typing.watsup
  def $unrollht{C : context, deftype : deftype}(C, (deftype : deftype <: heaptype)) = $unrolldt(deftype)
  ;; 6-typing.watsup
  def $unrollht{C : context, typeidx : typeidx}(C, _IDX_heaptype(typeidx)) = $unrolldt(C.TYPE_context[typeidx.`%`.0])
  ;; 6-typing.watsup
  def $unrollht{C : context, i : nat}(C, REC_heaptype(i)) = C.REC_context[i]

;; 6-typing.watsup
relation Subtype_ok2: `%|-%:%`(context, subtype, oktypeidxnat)
  ;; 6-typing.watsup
  rule _{C : context, fin : fin, ht* : heaptype*, ct : comptype, x : idx, i : nat, ht'** : heaptype**, ct'* : comptype*}:
    `%|-%:%`(C, SUBD_subtype(fin, ht*{ht}, ct), OK_oktypeidxnat(x, i))
    -- if (|ht*{ht}| <= 1)
    -- (if $before(ht, x, i))*{ht}
    -- (if ($unrollht(C, ht) = SUBD_subtype(`FINAL%?`(?()), ht'*{ht'}, ct')))*{ct' ht ht'}
    -- Comptype_ok: `%|-%:_OK`(C, ct)
    -- (Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}

;; 6-typing.watsup
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
    -- Rectype_ok2: `%|-%:%`(C, REC_rectype(st*{st}), OK_oktypeidxnat(`%`((x.`%`.0 + 1)), (i + 1)))
}

;; 6-typing.watsup
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
    -- Rectype_ok: `%|-%:%`(C, REC_rectype(st*{st}), OK_oktypeidx(`%`((x.`%`.0 + 1))))

  ;; 6-typing.watsup:192.1-194.49
  rule rec2{C : context, st* : subtype*, x : idx}:
    `%|-%:%`(C, REC_rectype(st*{st}), OK_oktypeidx(x))
    -- Rectype_ok2: `%|-%:%`(C ++ {TYPE [], REC st*{st}, FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, REC_rectype(st*{st}), OK_oktypeidxnat(x, 0))
}

;; 6-typing.watsup
relation Deftype_ok: `%|-%:_OK`(context, deftype)
  ;; 6-typing.watsup
  rule _{C : context, qt : rectype, i : nat, x : idx, st^n : subtype^n, n : n}:
    `%|-%:_OK`(C, DEF_deftype(qt, i))
    -- Rectype_ok: `%|-%:%`(C, qt, OK_oktypeidx(x))
    -- if (qt = REC_rectype(st^n{st}))
    -- if (i < n)

;; 6-typing.watsup
relation Limits_ok: `%|-%:%`(context, limits, nat)
  ;; 6-typing.watsup
  rule _{C : context, n_1 : n, n_2 : n, k : nat}:
    `%|-%:%`(C, `[%..%]`(`%`(n_1), `%`(n_2)), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 6-typing.watsup
relation Globaltype_ok: `%|-%:_OK`(context, globaltype)
  ;; 6-typing.watsup
  rule _{C : context, mut : mut, t : valtype}:
    `%|-%:_OK`(C, `%%`(mut, t))
    -- Valtype_ok: `%|-%:_OK`(C, t)

;; 6-typing.watsup
relation Tabletype_ok: `%|-%:_OK`(context, tabletype)
  ;; 6-typing.watsup
  rule _{C : context, lim : limits, rt : reftype}:
    `%|-%:_OK`(C, `%%`(lim, rt))
    -- Limits_ok: `%|-%:%`(C, lim, ((2 ^ 32) - 1))
    -- Reftype_ok: `%|-%:_OK`(C, rt)

;; 6-typing.watsup
relation Memtype_ok: `%|-%:_OK`(context, memtype)
  ;; 6-typing.watsup
  rule _{C : context, lim : limits}:
    `%|-%:_OK`(C, `%I8`(lim))
    -- Limits_ok: `%|-%:%`(C, lim, (2 ^ 16))

;; 6-typing.watsup
relation Externtype_ok: `%|-%:_OK`(context, externtype)
  ;; 6-typing.watsup
  rule func{C : context, dt : deftype, ft : functype}:
    `%|-%:_OK`(C, FUNC_externtype(dt))
    -- Deftype_ok: `%|-%:_OK`(C, dt)
    -- Expand: `%~~%`(dt, FUNC_comptype(ft))

  ;; 6-typing.watsup
  rule global{C : context, gt : globaltype}:
    `%|-%:_OK`(C, GLOBAL_externtype(gt))
    -- Globaltype_ok: `%|-%:_OK`(C, gt)

  ;; 6-typing.watsup
  rule table{C : context, tt : tabletype}:
    `%|-%:_OK`(C, TABLE_externtype(tt))
    -- Tabletype_ok: `%|-%:_OK`(C, tt)

  ;; 6-typing.watsup
  rule mem{C : context, mt : memtype}:
    `%|-%:_OK`(C, MEM_externtype(mt))
    -- Memtype_ok: `%|-%:_OK`(C, mt)

;; 6-typing.watsup
relation Resulttype_sub: `%|-%*_<:%*`(context, valtype*, valtype*)
  ;; 6-typing.watsup
  rule _{C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*_<:%*`(C, t_1*{t_1}, t_2*{t_2})
    -- (Valtype_sub: `%|-%<:%`(C, t_1, t_2))*{t_1 t_2}

;; 6-typing.watsup
relation Instrtype_sub: `%|-%<:%`(context, instrtype, instrtype)
  ;; 6-typing.watsup
  rule _{C : context, t_11* : valtype*, x_1* : idx*, t_12* : valtype*, t_21* : valtype*, x_2* : idx*, t_22* : valtype*, x* : idx*, t* : valtype*}:
    `%|-%<:%`(C, `%->%*%`(t_11*{t_11}, x_1*{x_1}, t_12*{t_12}), `%->%*%`(t_21*{t_21}, x_2*{x_2}, t_22*{t_22}))
    -- Resulttype_sub: `%|-%*_<:%*`(C, t_21*{t_21}, t_11*{t_11})
    -- Resulttype_sub: `%|-%*_<:%*`(C, t_12*{t_12}, t_22*{t_22})
    -- if (x*{x} = $setminus(x_2*{x_2}, x_1*{x_1}))
    -- (if (C.LOCAL_context[x.`%`.0] = `%%`(SET_init, t)))*{t x}

;; 6-typing.watsup
relation Limits_sub: `%|-%<:%`(context, limits, limits)
  ;; 6-typing.watsup
  rule _{C : context, n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `%|-%<:%`(C, `[%..%]`(`%`(n_11), `%`(n_12)), `[%..%]`(`%`(n_21), `%`(n_22)))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 6-typing.watsup
relation Globaltype_sub: `%|-%<:%`(context, globaltype, globaltype)
  ;; 6-typing.watsup
  rule const{C : context, t_1 : valtype, t_2 : valtype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?()), t_1), `%%`(`MUT%?`(?()), t_2))
    -- Valtype_sub: `%|-%<:%`(C, t_1, t_2)

  ;; 6-typing.watsup
  rule var{C : context, t_1 : valtype, t_2 : valtype}:
    `%|-%<:%`(C, `%%`(`MUT%?`(?(())), t_1), `%%`(`MUT%?`(?(())), t_2))
    -- Valtype_sub: `%|-%<:%`(C, t_1, t_2)
    -- Valtype_sub: `%|-%<:%`(C, t_2, t_1)

;; 6-typing.watsup
relation Tabletype_sub: `%|-%<:%`(context, tabletype, tabletype)
  ;; 6-typing.watsup
  rule _{C : context, lim_1 : limits, rt_1 : reftype, lim_2 : limits, rt_2 : reftype}:
    `%|-%<:%`(C, `%%`(lim_1, rt_1), `%%`(lim_2, rt_2))
    -- Limits_sub: `%|-%<:%`(C, lim_1, lim_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_1, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

;; 6-typing.watsup
relation Memtype_sub: `%|-%<:%`(context, memtype, memtype)
  ;; 6-typing.watsup
  rule _{C : context, lim_1 : limits, lim_2 : limits}:
    `%|-%<:%`(C, `%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `%|-%<:%`(C, lim_1, lim_2)

;; 6-typing.watsup
relation Externtype_sub: `%|-%<:%`(context, externtype, externtype)
  ;; 6-typing.watsup
  rule func{C : context, dt_1 : deftype, dt_2 : deftype}:
    `%|-%<:%`(C, FUNC_externtype(dt_1), FUNC_externtype(dt_2))
    -- Deftype_sub: `%|-%<:%`(C, dt_1, dt_2)

  ;; 6-typing.watsup
  rule global{C : context, gt_1 : globaltype, gt_2 : globaltype}:
    `%|-%<:%`(C, GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `%|-%<:%`(C, gt_1, gt_2)

  ;; 6-typing.watsup
  rule table{C : context, tt_1 : tabletype, tt_2 : tabletype}:
    `%|-%<:%`(C, TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `%|-%<:%`(C, tt_1, tt_2)

  ;; 6-typing.watsup
  rule mem{C : context, mt_1 : memtype, mt_2 : memtype}:
    `%|-%<:%`(C, MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `%|-%<:%`(C, mt_1, mt_2)

;; 6-typing.watsup
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 6-typing.watsup
  rule void{C : context}:
    `%|-%:%`(C, _RESULT_blocktype(?()), `%->%`([], []))

  ;; 6-typing.watsup
  rule result{C : context, t : valtype}:
    `%|-%:%`(C, _RESULT_blocktype(?(t)), `%->%`([], [t]))

  ;; 6-typing.watsup
  rule typeidx{C : context, x : idx, ft : functype}:
    `%|-%:%`(C, _IDX_blocktype(x), ft)
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], FUNC_comptype(ft))

;; 6-typing.watsup
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
    -- if (C.LABEL_context[l.`%`.0] = t*{t})

  ;; 6-typing.watsup:601.1-603.24
  rule br_if{C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l.`%`.0] = t*{t})

  ;; 6-typing.watsup:605.1-608.44
  rule br_table{C : context, l* : labelidx*, l' : labelidx, t_1* : valtype*, t* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `%|-%*_<:%*`(C, t*{t}, C.LABEL_context[l.`%`.0]))*{l}
    -- Resulttype_sub: `%|-%*_<:%*`(C, t*{t}, C.LABEL_context[l'.`%`.0])

  ;; 6-typing.watsup:610.1-613.31
  rule br_on_null{C : context, l : labelidx, t* : valtype*, ht : heaptype}:
    `%|-%:%`(C, BR_ON_NULL_instr(l), `%->%`(t*{t} :: [REF_valtype(`NULL%?`(?(())), ht)], t*{t} :: [REF_valtype(`NULL%?`(?()), ht)]))
    -- if (C.LABEL_context[l.`%`.0] = t*{t})
    -- Heaptype_ok: `%|-%:_OK`(C, ht)

  ;; 6-typing.watsup:615.1-618.31
  rule br_on_non_null{C : context, l : labelidx, t* : valtype*, ht : heaptype}:
    `%|-%:%`(C, BR_ON_NON_NULL_instr(l), `%->%`(t*{t} :: [REF_valtype(`NULL%?`(?(())), ht)], t*{t}))
    -- if (C.LABEL_context[l.`%`.0] = t*{t} :: [REF_valtype(`NULL%?`(?()), ht)])
    -- Heaptype_ok: `%|-%:_OK`(C, ht)

  ;; 6-typing.watsup:620.1-626.34
  rule br_on_cast{C : context, l : labelidx, rt_1 : reftype, rt_2 : reftype, t* : valtype*, rt : reftype}:
    `%|-%:%`(C, BR_ON_CAST_instr(l, rt_1, rt_2), `%->%`(t*{t} :: [(rt_1 : reftype <: valtype)], t*{t} :: [($diffrt(rt_1, rt_2) : reftype <: valtype)]))
    -- if (C.LABEL_context[l.`%`.0] = t*{t} :: [(rt : reftype <: valtype)])
    -- Reftype_ok: `%|-%:_OK`(C, rt_1)
    -- Reftype_ok: `%|-%:_OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt)

  ;; 6-typing.watsup:628.1-634.49
  rule br_on_cast_fail{C : context, l : labelidx, rt_1 : reftype, rt_2 : reftype, t* : valtype*, rt : reftype}:
    `%|-%:%`(C, BR_ON_CAST_FAIL_instr(l, rt_1, rt_2), `%->%`(t*{t} :: [(rt_1 : reftype <: valtype)], t*{t} :: [(rt_2 : reftype <: valtype)]))
    -- if (C.LABEL_context[l.`%`.0] = t*{t} :: [(rt : reftype <: valtype)])
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
    -- Expand: `%~~%`(C.FUNC_context[x.`%`.0], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:647.1-649.46
  rule call_ref{C : context, x : idx, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, CALL_REF_instr(?(x)), `%->%`(t_1*{t_1} :: [REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype))], t_2*{t_2}))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:651.1-655.46
  rule call_indirect{C : context, x : idx, y : idx, t_1* : valtype*, t_2* : valtype*, lim : limits, rt : reftype}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, y), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x.`%`.0] = `%%`(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPE_context[y.`%`.0], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:657.1-661.40
  rule return_call{C : context, x : idx, t_3* : valtype*, t_1* : valtype*, t_4* : valtype*, t_2* : valtype*, t'_2* : valtype*}:
    `%|-%:%`(C, RETURN_CALL_instr(x), `%->%`(t_3*{t_3} :: t_1*{t_1}, t_4*{t_4}))
    -- Expand: `%~~%`(C.FUNC_context[x.`%`.0], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*_<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:663.1-667.40
  rule return_call_ref{C : context, x : idx, t_3* : valtype*, t_1* : valtype*, t_4* : valtype*, t_2* : valtype*, t'_2* : valtype*}:
    `%|-%:%`(C, RETURN_CALL_REF_instr(?(x)), `%->%`(t_3*{t_3} :: t_1*{t_1} :: [REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype))], t_4*{t_4}))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*_<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:669.1-675.40
  rule return_call_indirect{C : context, x : idx, y : idx, t_3* : valtype*, t_1* : valtype*, t_4* : valtype*, lim : limits, rt : reftype, t_2* : valtype*, t'_2* : valtype*}:
    `%|-%:%`(C, RETURN_CALL_INDIRECT_instr(x, y), `%->%`(t_3*{t_3} :: t_1*{t_1} :: [I32_valtype], t_4*{t_4}))
    -- if (C.TABLE_context[x.`%`.0] = `%%`(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPE_context[y.`%`.0], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
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
    -- if ($size(nt_1) = $size(nt_2))

  ;; 6-typing.watsup:701.1-704.50
  rule convert-i{C : context, inn_1 : inn, inn_2 : inn, sx? : sx?}:
    `%|-%:%`(C, CVTOP_instr((inn_1 : inn <: numtype), CONVERT_cvtop, (inn_2 : inn <: numtype), sx?{sx}), `%->%`([(inn_2 : inn <: valtype)], [(inn_1 : inn <: valtype)]))
    -- if (inn_1 =/= inn_2)
    -- if ((sx?{sx} = ?()) <=> ($size((inn_1 : inn <: numtype)) > $size((inn_2 : inn <: numtype))))

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
    -- if (C.FUNC_context[x.`%`.0] = dt)

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
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], STRUCT_comptype(`%%`(mut, zt)*{mut zt}))

  ;; 6-typing.watsup:760.1-763.39
  rule struct.new_default{C : context, x : idx, zt* : storagetype*, mut* : mut*, val* : val*}:
    `%|-%:%`(C, STRUCT.NEW_DEFAULT_instr(x), `%->%`($unpack(zt)*{zt}, [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- (if ($default($unpack(zt)) = ?(val)))*{val zt}

  ;; 6-typing.watsup:765.1-769.39
  rule struct.get{C : context, sx? : sx?, x : idx, i : nat, zt : storagetype, yt* : fieldtype*, mut : mut}:
    `%|-%:%`(C, STRUCT.GET_instr(sx?{sx}, x, `%`(i)), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype))], [$unpack(zt)]))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], STRUCT_comptype(yt*{yt}))
    -- if (yt*{yt}[i] = `%%`(mut, zt))
    -- if ((sx?{sx} = ?()) <=> (zt = ($unpack(zt) : valtype <: storagetype)))

  ;; 6-typing.watsup:771.1-774.24
  rule struct.set{C : context, x : idx, i : nat, zt : storagetype, yt* : fieldtype*}:
    `%|-%:%`(C, STRUCT.SET_instr(x, `%`(i)), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype)) $unpack(zt)], []))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], STRUCT_comptype(yt*{yt}))
    -- if (yt*{yt}[i] = `%%`(`MUT%?`(?(())), zt))

  ;; 6-typing.watsup:779.1-781.41
  rule array.new{C : context, x : idx, zt : storagetype, mut : mut}:
    `%|-%:%`(C, ARRAY.NEW_instr(x), `%->%`([$unpack(zt) I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], ARRAY_comptype(`%%`(mut, zt)))

  ;; 6-typing.watsup:783.1-786.36
  rule array.new_default{C : context, x : idx, mut : mut, zt : storagetype, val : val}:
    `%|-%:%`(C, ARRAY.NEW_DEFAULT_instr(x), `%->%`([I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], ARRAY_comptype(`%%`(mut, zt)))
    -- if ($default($unpack(zt)) = ?(val))

  ;; 6-typing.watsup:788.1-790.41
  rule array.new_fixed{C : context, x : idx, n : n, zt : storagetype, mut : mut}:
    `%|-%:%`(C, ARRAY.NEW_FIXED_instr(x, n), `%->%`([$unpack(zt)], [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], ARRAY_comptype(`%%`(mut, zt)))

  ;; 6-typing.watsup:792.1-795.39
  rule array.new_elem{C : context, x : idx, y : idx, mut : mut, rt : reftype}:
    `%|-%:%`(C, ARRAY.NEW_ELEM_instr(x, y), `%->%`([I32_valtype I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], ARRAY_comptype(`%%`(mut, (rt : reftype <: storagetype))))
    -- Reftype_sub: `%|-%<:%`(C, C.ELEM_context[y.`%`.0], rt)

  ;; 6-typing.watsup:797.1-801.23
  rule array.new_data{C : context, x : idx, y : idx, mut : mut, t : valtype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, ARRAY.NEW_DATA_instr(x, y), `%->%`([I32_valtype I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) : typevar <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], ARRAY_comptype(`%%`(mut, (t : valtype <: storagetype))))
    -- if ((t = (numtype : numtype <: valtype)) \/ (t = (vectype : vectype <: valtype)))
    -- if (C.DATA_context[y.`%`.0] = OK)

  ;; 6-typing.watsup:803.1-806.39
  rule array.get{C : context, sx? : sx?, x : idx, zt : storagetype, mut : mut}:
    `%|-%:%`(C, ARRAY.GET_instr(sx?{sx}, x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype], [$unpack(zt)]))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], ARRAY_comptype(`%%`(mut, zt)))
    -- if ((sx?{sx} = ?()) <=> (zt = ($unpack(zt) : valtype <: storagetype)))

  ;; 6-typing.watsup:808.1-810.41
  rule array.set{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.SET_instr(x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype $unpack(zt)], []))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:812.1-814.41
  rule array.len{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.LEN_instr, `%->%`([REF_valtype(`NULL%?`(?(())), ARRAY_heaptype)], [I32_valtype]))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:816.1-818.41
  rule array.fill{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.FILL_instr(x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype $unpack(zt) I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:820.1-824.40
  rule array.copy{C : context, x_1 : idx, x_2 : idx, zt_1 : storagetype, mut : mut, zt_2 : storagetype}:
    `%|-%:%`(C, ARRAY.COPY_instr(x_1, x_2), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x_1) : typevar <: heaptype)) I32_valtype REF_valtype(`NULL%?`(?(())), ($idx(x_2) : typevar <: heaptype)) I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x_1.`%`.0], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt_1)))
    -- Expand: `%~~%`(C.TYPE_context[x_2.`%`.0], ARRAY_comptype(`%%`(mut, zt_2)))
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

  ;; 6-typing.watsup:826.1-829.43
  rule array.init_elem{C : context, x : idx, y : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.INIT_ELEM_instr(x, y), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
    -- Storagetype_sub: `%|-%<:%`(C, (C.ELEM_context[y.`%`.0] : reftype <: storagetype), zt)

  ;; 6-typing.watsup:831.1-835.23
  rule array.init_data{C : context, x : idx, y : idx, zt : storagetype, t : valtype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, ARRAY.INIT_DATA_instr(x, y), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
    -- if ((t = (numtype : numtype <: valtype)) \/ (t = (vectype : vectype <: valtype)))
    -- if (C.DATA_context[y.`%`.0] = OK)

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
    `%|-%:%`(C, VSHUFFLE_instr(`%X%`(imm, `%`(N)), `%`(i)*{i}), `%->%`([V128_valtype V128_valtype], [V128_valtype]))
    -- (if (i < (N * 2)))*{i}

  ;; 6-typing.watsup:874.1-875.48
  rule vsplat{C : context, lnn : lnn, N : N}:
    `%|-%:%`(C, VSPLAT_instr(`%X%`(lnn, `%`(N))), `%->%`([($lunpack(lnn) : numtype <: valtype)], [V128_valtype]))

  ;; 6-typing.watsup:878.1-880.14
  rule vextract_lane{C : context, lnn : lnn, N : N, sx? : sx?, i : nat}:
    `%|-%:%`(C, VEXTRACT_LANE_instr(`%X%`(lnn, `%`(N)), sx?{sx}, `%`(i)), `%->%`([V128_valtype], [($lunpack(lnn) : numtype <: valtype)]))
    -- if (i < N)

  ;; 6-typing.watsup:882.1-884.14
  rule vreplace_lane{C : context, lnn : lnn, N : N, i : nat}:
    `%|-%:%`(C, VREPLACE_LANE_instr(`%X%`(lnn, `%`(N)), `%`(i)), `%->%`([V128_valtype ($lunpack(lnn) : numtype <: valtype)], [V128_valtype]))
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
    -- if (C.LOCAL_context[x.`%`.0] = `%%`(init, t))

  ;; 6-typing.watsup:935.1-937.28
  rule global.get{C : context, x : idx, t : valtype, mut : mut}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x.`%`.0] = `%%`(mut, t))

  ;; 6-typing.watsup:939.1-941.28
  rule global.set{C : context, x : idx, t : valtype}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x.`%`.0] = `%%`(`MUT%?`(?(())), t))

  ;; 6-typing.watsup:946.1-948.28
  rule table.get{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [(rt : reftype <: valtype)]))
    -- if (C.TABLE_context[x.`%`.0] = `%%`(lim, rt))

  ;; 6-typing.watsup:950.1-952.28
  rule table.set{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype (rt : reftype <: valtype)], []))
    -- if (C.TABLE_context[x.`%`.0] = `%%`(lim, rt))

  ;; 6-typing.watsup:954.1-956.24
  rule table.size{C : context, x : idx, tt : tabletype}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x.`%`.0] = tt)

  ;; 6-typing.watsup:958.1-960.28
  rule table.grow{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([(rt : reftype <: valtype) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x.`%`.0] = `%%`(lim, rt))

  ;; 6-typing.watsup:962.1-964.28
  rule table.fill{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype (rt : reftype <: valtype) I32_valtype], []))
    -- if (C.TABLE_context[x.`%`.0] = `%%`(lim, rt))

  ;; 6-typing.watsup:966.1-970.36
  rule table.copy{C : context, x_1 : idx, x_2 : idx, lim_1 : limits, rt_1 : reftype, lim_2 : limits, rt_2 : reftype}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1.`%`.0] = `%%`(lim_1, rt_1))
    -- if (C.TABLE_context[x_2.`%`.0] = `%%`(lim_2, rt_2))
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:972.1-976.36
  rule table.init{C : context, x : idx, y : idx, lim : limits, rt_1 : reftype, rt_2 : reftype}:
    `%|-%:%`(C, TABLE.INIT_instr(x, y), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x.`%`.0] = `%%`(lim, rt_1))
    -- if (C.ELEM_context[y.`%`.0] = rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:978.1-980.23
  rule elem.drop{C : context, x : idx, rt : reftype}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x.`%`.0] = rt)

  ;; 6-typing.watsup:985.1-987.22
  rule memory.size{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[x.`%`.0] = mt)

  ;; 6-typing.watsup:989.1-991.22
  rule memory.grow{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr(x), `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[x.`%`.0] = mt)

  ;; 6-typing.watsup:993.1-995.22
  rule memory.fill{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[x.`%`.0] = mt)

  ;; 6-typing.watsup:997.1-1000.26
  rule memory.copy{C : context, x_1 : idx, x_2 : idx, mt_1 : memtype, mt_2 : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[x_1.`%`.0] = mt_1)
    -- if (C.MEM_context[x_2.`%`.0] = mt_2)

  ;; 6-typing.watsup:1002.1-1005.23
  rule memory.init{C : context, x : idx, y : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.INIT_instr(x, y), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[x.`%`.0] = mt)
    -- if (C.DATA_context[y.`%`.0] = OK)

  ;; 6-typing.watsup:1007.1-1009.23
  rule data.drop{C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x.`%`.0] = OK)

  ;; 6-typing.watsup:1011.1-1016.29
  rule load{C : context, nt : numtype, n? : n?, sx? : sx?, x : idx, n_A : n, n_O : n, mt : memtype, inn : inn}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, x, {ALIGN `%`(n_A), OFFSET `%`(n_O)}), `%->%`([I32_valtype], [(nt : numtype <: valtype)]))
    -- if (C.MEM_context[x.`%`.0] = mt)
    -- if ((2 ^ n_A) <= ($size(nt) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (inn : inn <: numtype)))

  ;; 6-typing.watsup:1018.1-1023.29
  rule store{C : context, nt : numtype, n? : n?, x : idx, n_A : n, n_O : n, mt : memtype, inn : inn}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, x, {ALIGN `%`(n_A), OFFSET `%`(n_O)}), `%->%`([I32_valtype (nt : numtype <: valtype)], []))
    -- if (C.MEM_context[x.`%`.0] = mt)
    -- if ((2 ^ n_A) <= ($size(nt) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (inn : inn <: numtype)))

  ;; 6-typing.watsup:1025.1-1028.30
  rule vload{C : context, M : M, N : N, sx : sx, x : idx, n_A : n, n_O : n, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(?(SHAPE_vloadop(M, N, sx)), x, {ALIGN `%`(n_A), OFFSET `%`(n_O)}), `%->%`([I32_valtype], [V128_valtype]))
    -- if (C.MEM_context[x.`%`.0] = mt)
    -- if ((2 ^ n_A) <= ((M / 8) * N))

  ;; 6-typing.watsup:1030.1-1033.26
  rule vload-splat{C : context, n : n, x : idx, n_A : n, n_O : n, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(?(SPLAT_vloadop(n)), x, {ALIGN `%`(n_A), OFFSET `%`(n_O)}), `%->%`([I32_valtype], [V128_valtype]))
    -- if (C.MEM_context[x.`%`.0] = mt)
    -- if ((2 ^ n_A) <= (n / 8))

  ;; 6-typing.watsup:1035.1-1038.25
  rule vload-zero{C : context, n : n, x : idx, n_A : n, n_O : n, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(?(ZERO_vloadop(n)), x, {ALIGN `%`(n_A), OFFSET `%`(n_O)}), `%->%`([I32_valtype], [V128_valtype]))
    -- if (C.MEM_context[x.`%`.0] = mt)
    -- if ((2 ^ n_A) < (n / 8))

  ;; 6-typing.watsup:1040.1-1044.29
  rule vload_lane{C : context, n : n, x : idx, n_A : n, n_O : n, laneidx : laneidx, mt : memtype}:
    `%|-%:%`(C, VLOAD_LANE_instr(n, x, {ALIGN `%`(n_A), OFFSET `%`(n_O)}, laneidx), `%->%`([I32_valtype V128_valtype], [V128_valtype]))
    -- if (C.MEM_context[x.`%`.0] = mt)
    -- if ((2 ^ n_A) < (n / 8))
    -- if (laneidx.`%`.0 < (128 / n))

  ;; 6-typing.watsup:1046.1-1049.37
  rule vstore{C : context, x : idx, n_A : n, n_O : n, mt : memtype}:
    `%|-%:%`(C, VSTORE_instr(x, {ALIGN `%`(n_A), OFFSET `%`(n_O)}), `%->%`([I32_valtype V128_valtype], []))
    -- if (C.MEM_context[x.`%`.0] = mt)
    -- if ((2 ^ n_A) <= ($vsize(V128_vectype) / 8))

  ;; 6-typing.watsup:1051.1-1055.29
  rule vstore_lane{C : context, n : n, x : idx, n_A : n, n_O : n, laneidx : laneidx, mt : memtype}:
    `%|-%:%`(C, VSTORE_LANE_instr(n, x, {ALIGN `%`(n_A), OFFSET `%`(n_O)}, laneidx), `%->%`([I32_valtype V128_valtype], []))
    -- if (C.MEM_context[x.`%`.0] = mt)
    -- if ((2 ^ n_A) < (n / 8))
    -- if (laneidx.`%`.0 < (128 / n))

;; 6-typing.watsup:504.1-504.67
relation Instrf_ok: `%|-%:%`(context, instr, instrtype)
  ;; 6-typing.watsup:518.1-520.41
  rule instr{C : context, instr : instr, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, instr, `%->%*%`(t_1*{t_1}, [], t_2*{t_2}))
    -- Instr_ok: `%|-%:%`(C, instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 6-typing.watsup:924.1-926.28
  rule local.set{C : context, x : idx, t : valtype, init : init}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%*%`([t], [x], []))
    -- if (C.LOCAL_context[x.`%`.0] = `%%`(init, t))

  ;; 6-typing.watsup:928.1-930.28
  rule local.tee{C : context, x : idx, t : valtype, init : init}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%*%`([t], [x], [t]))
    -- if (C.LOCAL_context[x.`%`.0] = `%%`(init, t))

;; 6-typing.watsup:505.1-505.74
relation Instrs_ok: `%|-%*_:%`(context, instr*, instrtype)
  ;; 6-typing.watsup:522.1-523.29
  rule empty{C : context}:
    `%|-%*_:%`(C, [], `%->%*%`([], [], []))

  ;; 6-typing.watsup:525.1-530.52
  rule seq{C : context, instr_1 : instr, instr_2* : instr*, t_1* : valtype*, x_1* : idx*, x_2* : idx*, t_3* : valtype*, init* : init*, t* : valtype*, C' : context, t_2* : valtype*}:
    `%|-%*_:%`(C, [instr_1] :: instr_2*{instr_2}, `%->%*%`(t_1*{t_1}, x_1*{x_1} :: x_2*{x_2}, t_3*{t_3}))
    -- (if (C.LOCAL_context[x_1.`%`.0] = `%%`(init, t)))*{init t x_1}
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

;; 6-typing.watsup
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 6-typing.watsup
  rule _{C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- Instrs_ok: `%|-%*_:%`(C, instr*{instr}, `%->%*%`([], [], t*{t}))

;; 6-typing.watsup
rec {

;; 6-typing.watsup:1086.1-1086.86
def $in_binop(numtype : numtype, binop_ : binop_(numtype), binop_(numtype)*) : bool
  ;; 6-typing.watsup:1087.1-1087.42
  def $in_binop{nt : numtype, binop : binop_(nt), epsilon : binop_(nt)*}(nt, binop, epsilon) = false
  ;; 6-typing.watsup:1088.1-1088.99
  def $in_binop{nt : numtype, binop : binop_(nt), ibinop_1 : binop_(nt), ibinop'* : binop_(nt)*}(nt, binop, [ibinop_1] :: ibinop'*{ibinop'}) = ((binop = ibinop_1) \/ $in_binop(nt, binop, ibinop'*{ibinop'}))
}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:1082.1-1082.63
def $in_numtype(numtype : numtype, numtype*) : bool
  ;; 6-typing.watsup:1083.1-1083.37
  def $in_numtype{nt : numtype, epsilon : numtype*}(nt, epsilon) = false
  ;; 6-typing.watsup:1084.1-1084.68
  def $in_numtype{nt : numtype, nt_1 : numtype, nt'* : numtype*}(nt, [nt_1] :: nt'*{nt'}) = ((nt = nt_1) \/ $in_numtype(nt, nt'*{nt'}))
}

;; 6-typing.watsup
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 6-typing.watsup
  rule const{C : context, nt : numtype, c : num_(nt)}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 6-typing.watsup
  rule vvconst{C : context, vt : vectype, c_vt : vec_(vt)}:
    `%|-%CONST`(C, VCONST_instr(vt, c_vt))

  ;; 6-typing.watsup
  rule ref.null{C : context, ht : heaptype}:
    `%|-%CONST`(C, REF.NULL_instr(ht))

  ;; 6-typing.watsup
  rule ref.func{C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 6-typing.watsup
  rule global.get{C : context, x : idx, t : valtype}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x.`%`.0] = `%%`(`MUT%?`(?()), t))

  ;; 6-typing.watsup
  rule binop{C : context, inn : inn, binop : binop_((inn : inn <: numtype))}:
    `%|-%CONST`(C, BINOP_instr((inn : inn <: numtype), binop))
    -- if $in_numtype((inn : inn <: numtype), [I32_numtype I64_numtype])
    -- if $in_binop((inn : inn <: numtype), binop, [ADD_binop_((inn : inn <: numtype)) SUB_binop_((inn : inn <: numtype)) MUL_binop_((inn : inn <: numtype))])

;; 6-typing.watsup
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 6-typing.watsup
  rule _{C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 6-typing.watsup
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 6-typing.watsup
  rule _{C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 6-typing.watsup
relation Type_ok: `%|-%:%*`(context, type, deftype*)
  ;; 6-typing.watsup
  rule _{C : context, rectype : rectype, dt* : deftype*, x : idx}:
    `%|-%:%*`(C, TYPE(rectype), dt*{dt})
    -- if (x = `%`(|C.TYPE_context|))
    -- if (dt*{dt} = $rolldt(x, rectype))
    -- Rectype_ok: `%|-%:%`(C[TYPE_context =.. dt*{dt}], rectype, OK_oktypeidx(x))

;; 6-typing.watsup
relation Local_ok: `%|-%:%`(context, local, localtype)
  ;; 6-typing.watsup
  rule set{C : context, t : valtype}:
    `%|-%:%`(C, LOCAL(t), `%%`(SET_init, t))
    -- if ($default(t) =/= ?())

  ;; 6-typing.watsup
  rule unset{C : context, t : valtype}:
    `%|-%:%`(C, LOCAL(t), `%%`(UNSET_init, t))
    -- if ($default(t) = ?())

;; 6-typing.watsup
relation Func_ok: `%|-%:%`(context, func, deftype)
  ;; 6-typing.watsup
  rule _{C : context, x : idx, local* : local*, expr : expr, t_1* : valtype*, t_2* : valtype*, lt* : localtype*}:
    `%|-%:%`(C, `FUNC%%*%`(x, local*{local}, expr), C.TYPE_context[x.`%`.0])
    -- Expand: `%~~%`(C.TYPE_context[x.`%`.0], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- (Local_ok: `%|-%:%`(C, local, lt))*{local lt}
    -- Expr_ok: `%|-%:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL `%%`(SET_init, t_1)*{t_1} :: lt*{lt}, LABEL [], RETURN ?()} ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 6-typing.watsup
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 6-typing.watsup
  rule _{C : context, gt : globaltype, expr : expr, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `%|-%:_OK`(C, gt)
    -- if (gt = `%%`(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 6-typing.watsup
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 6-typing.watsup
  rule _{C : context, tt : tabletype, expr : expr, limits : limits, rt : reftype}:
    `%|-%:%`(C, TABLE(tt, expr), tt)
    -- Tabletype_ok: `%|-%:_OK`(C, tt)
    -- if (tt = `%%`(limits, rt))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, (rt : reftype <: valtype))

;; 6-typing.watsup
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 6-typing.watsup
  rule _{C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `%|-%:_OK`(C, mt)

;; 6-typing.watsup
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 6-typing.watsup
  rule active{C : context, x : idx, expr : expr, rt : reftype, lim : limits}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x.`%`.0] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 6-typing.watsup
  rule passive{C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; 6-typing.watsup
  rule declare{C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 6-typing.watsup
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 6-typing.watsup
  rule _{C : context, rt : reftype, expr* : expr*, elemmode : elemmode}:
    `%|-%:%`(C, `ELEM%%*%`(rt, expr*{expr}, elemmode), rt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, (rt : reftype <: valtype)))*{expr}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, rt)

;; 6-typing.watsup
relation Datamode_ok: `%|-%:_OK`(context, datamode)
  ;; 6-typing.watsup
  rule active{C : context, x : idx, expr : expr, mt : memtype}:
    `%|-%:_OK`(C, ACTIVE_datamode(x, expr))
    -- if (C.MEM_context[x.`%`.0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 6-typing.watsup
  rule passive{C : context}:
    `%|-%:_OK`(C, PASSIVE_datamode)

;; 6-typing.watsup
relation Data_ok: `%|-%:_OK`(context, data)
  ;; 6-typing.watsup
  rule _{C : context, b* : byte*, datamode : datamode}:
    `%|-%:_OK`(C, `DATA%*%`(b*{b}, datamode))
    -- Datamode_ok: `%|-%:_OK`(C, datamode)

;; 6-typing.watsup
relation Start_ok: `%|-%:_OK`(context, start)
  ;; 6-typing.watsup
  rule _{C : context, x : idx}:
    `%|-%:_OK`(C, START(x))
    -- Expand: `%~~%`(C.FUNC_context[x.`%`.0], FUNC_comptype(`%->%`([], [])))

;; 6-typing.watsup
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 6-typing.watsup
  rule _{C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `%|-%:_OK`(C, xt)

;; 6-typing.watsup
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; 6-typing.watsup
  rule func{C : context, x : idx, dt : deftype}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype(dt))
    -- if (C.FUNC_context[x.`%`.0] = dt)

  ;; 6-typing.watsup
  rule global{C : context, x : idx, gt : globaltype}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x.`%`.0] = gt)

  ;; 6-typing.watsup
  rule table{C : context, x : idx, tt : tabletype}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x.`%`.0] = tt)

  ;; 6-typing.watsup
  rule mem{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (C.MEM_context[x.`%`.0] = mt)

;; 6-typing.watsup
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 6-typing.watsup
  rule _{C : context, name : name, externidx : externidx, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externidx), xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 6-typing.watsup
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

;; 6-typing.watsup
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

;; 6-typing.watsup
relation Module_ok: `|-%:_OK`(module)
  ;; 6-typing.watsup
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

;; 7-runtime-typing.watsup
relation Ref_ok: `%|-%:%`(store, ref, reftype)
  ;; 7-runtime-typing.watsup
  rule null{s : store, ht : heaptype}:
    `%|-%:%`(s, REF.NULL_ref(ht), REF_reftype(`NULL%?`(?(())), ht))

  ;; 7-runtime-typing.watsup
  rule i31{s : store, i : nat}:
    `%|-%:%`(s, REF.I31_NUM_ref(`%`(i)), REF_reftype(`NULL%?`(?()), I31_heaptype))

  ;; 7-runtime-typing.watsup
  rule struct{s : store, a : addr, dt : deftype}:
    `%|-%:%`(s, REF.STRUCT_ADDR_ref(a), REF_reftype(`NULL%?`(?()), (dt : deftype <: heaptype)))
    -- if (s.STRUCT_store[a].TYPE_structinst = dt)

  ;; 7-runtime-typing.watsup
  rule array{s : store, a : addr, dt : deftype}:
    `%|-%:%`(s, REF.ARRAY_ADDR_ref(a), REF_reftype(`NULL%?`(?()), (dt : deftype <: heaptype)))
    -- if (s.ARRAY_store[a].TYPE_arrayinst = dt)

  ;; 7-runtime-typing.watsup
  rule func{s : store, a : addr, dt : deftype}:
    `%|-%:%`(s, REF.FUNC_ADDR_ref(a), REF_reftype(`NULL%?`(?()), (dt : deftype <: heaptype)))
    -- if (s.FUNC_store[a].TYPE_funcinst = dt)

  ;; 7-runtime-typing.watsup
  rule host{s : store, a : addr}:
    `%|-%:%`(s, REF.HOST_ADDR_ref(a), REF_reftype(`NULL%?`(?()), ANY_heaptype))

  ;; 7-runtime-typing.watsup
  rule extern{s : store, addrref : addrref}:
    `%|-%:%`(s, REF.EXTERN_ref(addrref), REF_reftype(`NULL%?`(?()), EXTERN_heaptype))

;; 8-reduction.watsup
relation Step_pure: `%*_~>%*`(admininstr*, admininstr*)
  ;; 8-reduction.watsup
  rule unreachable:
    `%*_~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 8-reduction.watsup
  rule nop:
    `%*_~>%*`([NOP_admininstr], [])

  ;; 8-reduction.watsup
  rule drop{val : val}:
    `%*_~>%*`([(val : val <: admininstr) DROP_admininstr], [])

  ;; 8-reduction.watsup
  rule select-true{val_1 : val, val_2 : val, c : num_(I32_numtype), t*? : valtype*?}:
    `%*_~>%*`([(val_1 : val <: admininstr) (val_2 : val <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [(val_1 : val <: admininstr)])
    -- if (c =/= `%`(0))

  ;; 8-reduction.watsup
  rule select-false{val_1 : val, val_2 : val, c : num_(I32_numtype), t*? : valtype*?}:
    `%*_~>%*`([(val_1 : val <: admininstr) (val_2 : val <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [(val_2 : val <: admininstr)])
    -- if (c = `%`(0))

  ;; 8-reduction.watsup
  rule if-true{c : num_(I32_numtype), bt : blocktype, instr_1* : instr*, instr_2* : instr*}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= `%`(0))

  ;; 8-reduction.watsup
  rule if-false{c : num_(I32_numtype), bt : blocktype, instr_1* : instr*, instr_2* : instr*}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = `%`(0))

  ;; 8-reduction.watsup
  rule label-vals{n : n, instr* : instr*, val* : val*}:
    `%*_~>%*`([LABEL__admininstr(n, instr*{instr}, (val : val <: admininstr)*{val})], (val : val <: admininstr)*{val})

  ;; 8-reduction.watsup
  rule br-zero{n : n, instr'* : instr*, val'* : val*, val^n : val^n, instr* : instr*}:
    `%*_~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val' : val <: admininstr)*{val'} :: (val : val <: admininstr)^n{val} :: [BR_admininstr(`%`(0))] :: (instr : instr <: admininstr)*{instr})], (val : val <: admininstr)^n{val} :: (instr' : instr <: admininstr)*{instr'})

  ;; 8-reduction.watsup
  rule br-succ{n : n, instr'* : instr*, val* : val*, l : labelidx, instr* : instr*}:
    `%*_~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val : val <: admininstr)*{val} :: [BR_admininstr(`%`((l.`%`.0 + 1)))] :: (instr : instr <: admininstr)*{instr})], (val : val <: admininstr)*{val} :: [BR_admininstr(l)])

  ;; 8-reduction.watsup
  rule br_if-true{c : num_(I32_numtype), l : labelidx}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= `%`(0))

  ;; 8-reduction.watsup
  rule br_if-false{c : num_(I32_numtype), l : labelidx}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = `%`(0))

  ;; 8-reduction.watsup
  rule br_table-lt{i : nat, l* : labelidx*, l' : labelidx}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, `%`(i)) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 8-reduction.watsup
  rule br_table-ge{i : nat, l* : labelidx*, l' : labelidx}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, `%`(i)) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 8-reduction.watsup
  rule br_on_null-null{val : val, l : labelidx, ht : heaptype}:
    `%*_~>%*`([(val : val <: admininstr) BR_ON_NULL_admininstr(l)], [BR_admininstr(l)])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup
  rule br_on_null-addr{val : val, l : labelidx}:
    `%*_~>%*`([(val : val <: admininstr) BR_ON_NULL_admininstr(l)], [(val : val <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup
  rule br_on_non_null-null{val : val, l : labelidx, ht : heaptype}:
    `%*_~>%*`([(val : val <: admininstr) BR_ON_NON_NULL_admininstr(l)], [])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup
  rule br_on_non_null-addr{val : val, l : labelidx}:
    `%*_~>%*`([(val : val <: admininstr) BR_ON_NON_NULL_admininstr(l)], [(val : val <: admininstr) BR_admininstr(l)])
    -- otherwise

  ;; 8-reduction.watsup
  rule call_indirect-call{x : idx, y : idx}:
    `%*_~>%*`([CALL_INDIRECT_admininstr(x, y)], [TABLE.GET_admininstr(x) REF.CAST_admininstr(REF_reftype(`NULL%?`(?(())), ($idx(y) : typevar <: heaptype))) CALL_REF_admininstr(?(y))])

  ;; 8-reduction.watsup
  rule return_call_indirect{x : idx, y : idx}:
    `%*_~>%*`([RETURN_CALL_INDIRECT_admininstr(x, y)], [TABLE.GET_admininstr(x) REF.CAST_admininstr(REF_reftype(`NULL%?`(?(())), ($idx(y) : typevar <: heaptype))) RETURN_CALL_REF_admininstr(?(y))])

  ;; 8-reduction.watsup
  rule frame-vals{n : n, f : frame, val^n : val^n}:
    `%*_~>%*`([FRAME__admininstr(n, f, (val : val <: admininstr)^n{val})], (val : val <: admininstr)^n{val})

  ;; 8-reduction.watsup
  rule return-frame{n : n, f : frame, val'* : val*, val^n : val^n, instr* : instr*}:
    `%*_~>%*`([FRAME__admininstr(n, f, (val' : val <: admininstr)*{val'} :: (val : val <: admininstr)^n{val} :: [RETURN_admininstr] :: (instr : instr <: admininstr)*{instr})], (val : val <: admininstr)^n{val})

  ;; 8-reduction.watsup
  rule return-label{k : nat, instr'* : instr*, val* : val*, instr* : instr*}:
    `%*_~>%*`([LABEL__admininstr(k, instr'*{instr'}, (val : val <: admininstr)*{val} :: [RETURN_admininstr] :: (instr : instr <: admininstr)*{instr})], (val : val <: admininstr)*{val} :: [RETURN_admininstr])

  ;; 8-reduction.watsup
  rule unop-val{nt : numtype, c_1 : num_(nt), unop : unop_(nt), c : num_(nt)}:
    `%*_~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(nt, unop, c_1) = [c])

  ;; 8-reduction.watsup
  rule unop-trap{nt : numtype, c_1 : num_(nt), unop : unop_(nt)}:
    `%*_~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(nt, unop, c_1) = [])

  ;; 8-reduction.watsup
  rule binop-val{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), binop : binop_(nt), c : num_(nt)}:
    `%*_~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(nt, binop, c_1, c_2) = [c])

  ;; 8-reduction.watsup
  rule binop-trap{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), binop : binop_(nt)}:
    `%*_~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(nt, binop, c_1, c_2) = [])

  ;; 8-reduction.watsup
  rule testop{nt : numtype, c_1 : num_(nt), testop : testop_(nt), c : num_(I32_numtype)}:
    `%*_~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(nt, testop, c_1))

  ;; 8-reduction.watsup
  rule relop{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), relop : relop_(nt), c : num_(I32_numtype)}:
    `%*_~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(nt, relop, c_1, c_2))

  ;; 8-reduction.watsup
  rule cvtop-val{nt_1 : numtype, c_1 : num_(nt_1), nt_2 : numtype, cvtop : cvtop, sx? : sx?, c : num_(nt_2)}:
    `%*_~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, nt_2, cvtop, sx?{sx}, c_1) = [c])

  ;; 8-reduction.watsup
  rule cvtop-trap{nt_1 : numtype, c_1 : num_(nt_1), nt_2 : numtype, cvtop : cvtop, sx? : sx?}:
    `%*_~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, nt_2, cvtop, sx?{sx}, c_1) = [])

  ;; 8-reduction.watsup
  rule ref.i31{i : nat}:
    `%*_~>%*`([CONST_admininstr(I32_numtype, `%`(i)) REF.I31_admininstr], [REF.I31_NUM_admininstr($wrap(32, 31, `%`(i)))])

  ;; 8-reduction.watsup
  rule ref.is_null-true{val : val, ht : heaptype}:
    `%*_~>%*`([(val : val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, `%`(1))])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup
  rule ref.is_null-false{val : val}:
    `%*_~>%*`([(val : val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, `%`(0))])
    -- otherwise

  ;; 8-reduction.watsup
  rule ref.as_non_null-null{ref : ref, ht : heaptype}:
    `%*_~>%*`([(ref : ref <: admininstr) REF.AS_NON_NULL_admininstr], [TRAP_admininstr])
    -- if (ref = REF.NULL_ref(ht))

  ;; 8-reduction.watsup
  rule ref.as_non_null-addr{ref : ref}:
    `%*_~>%*`([(ref : ref <: admininstr) REF.AS_NON_NULL_admininstr], [(ref : ref <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup
  rule ref.eq-null{ref_1 : ref, ref_2 : ref, ht_1 : heaptype, ht_2 : heaptype}:
    `%*_~>%*`([(ref_1 : ref <: admininstr) (ref_2 : ref <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, `%`(1))])
    -- if ((ref_1 = REF.NULL_ref(ht_1)) /\ (ref_2 = REF.NULL_ref(ht_2)))

  ;; 8-reduction.watsup
  rule ref.eq-true{ref_1 : ref, ref_2 : ref}:
    `%*_~>%*`([(ref_1 : ref <: admininstr) (ref_2 : ref <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, `%`(1))])
    -- otherwise
    -- if (ref_1 = ref_2)

  ;; 8-reduction.watsup
  rule ref.eq-false{ref_1 : ref, ref_2 : ref}:
    `%*_~>%*`([(ref_1 : ref <: admininstr) (ref_2 : ref <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, `%`(0))])
    -- otherwise

  ;; 8-reduction.watsup
  rule i31.get-null{ht : heaptype, sx : sx}:
    `%*_~>%*`([REF.NULL_admininstr(ht) I31.GET_admininstr(sx)], [TRAP_admininstr])

  ;; 8-reduction.watsup
  rule i31.get-num{i : nat, sx : sx}:
    `%*_~>%*`([REF.I31_NUM_admininstr(`%`(i)) I31.GET_admininstr(sx)], [CONST_admininstr(I32_numtype, $ext(31, 32, sx, `%`(i)))])

  ;; 8-reduction.watsup
  rule extern.convert_any-null{ht : heaptype}:
    `%*_~>%*`([REF.NULL_admininstr(ht) EXTERN.CONVERT_ANY_admininstr], [REF.NULL_admininstr(EXTERN_heaptype)])

  ;; 8-reduction.watsup
  rule extern.convert_any-addr{addrref : addrref}:
    `%*_~>%*`([(addrref : addrref <: admininstr) EXTERN.CONVERT_ANY_admininstr], [REF.EXTERN_admininstr(addrref)])

  ;; 8-reduction.watsup
  rule any.convert_extern-null{ht : heaptype}:
    `%*_~>%*`([REF.NULL_admininstr(ht) ANY.CONVERT_EXTERN_admininstr], [REF.NULL_admininstr(ANY_heaptype)])

  ;; 8-reduction.watsup
  rule any.convert_extern-addr{addrref : addrref}:
    `%*_~>%*`([REF.EXTERN_admininstr(addrref) ANY.CONVERT_EXTERN_admininstr], [(addrref : addrref <: admininstr)])

  ;; 8-reduction.watsup
  rule vvunop{c_1 : vec_(V128_vnn), vvunop : vvunop, c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VVUNOP_admininstr(V128_vectype, vvunop)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vvunop(V128_vectype, vvunop, c_1) = c)

  ;; 8-reduction.watsup
  rule vvbinop{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), vvbinop : vvbinop, c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VVBINOP_admininstr(V128_vectype, vvbinop)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vvbinop(V128_vectype, vvbinop, c_1, c_2) = c)

  ;; 8-reduction.watsup
  rule vvternop{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), c_3 : vec_(V128_vnn), vvternop : vvternop, c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VCONST_admininstr(V128_vectype, c_3) VVTERNOP_admininstr(V128_vectype, vvternop)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vvternop(V128_vectype, vvternop, c_1, c_2, c_3) = c)

  ;; 8-reduction.watsup
  rule vvtestop{c_1 : vec_(V128_vnn), c : num_(I32_numtype)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VVTESTOP_admininstr(V128_vectype, ANY_TRUE_vvtestop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $ine($vsize(V128_vectype), c_1, `%`(0)))

  ;; 8-reduction.watsup
  rule vswizzle{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), inn : inn, N : N, c' : vec_(V128_vnn), c : iN($size((inn : inn <: numtype))), ci* : lane_($lanetype(`%X%`((inn : inn <: lanetype), `%`(N))))*, k^N : nat^N}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VSWIZZLE_admininstr(`%X%`((inn : inn <: imm), `%`(N)))], [VCONST_admininstr(V128_vectype, c')])
    -- if (ci*{ci} = $lanes_(`%X%`((inn : inn <: lanetype), `%`(N)), c_2))
    -- if (c*{} = $lanes_(`%X%`((inn : inn <: lanetype), `%`(N)), c_1) :: `%`(0)^(256 - N){})
    -- if (c' = $invlanes_(`%X%`((inn : inn <: lanetype), `%`(N)), c*{}[ci*{ci}[k].`%`.0]^(k<N){k}))

  ;; 8-reduction.watsup
  rule vshuffle{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), inn : inn, N : N, i* : nat*, c : vec_(V128_vnn), c' : iN($size((inn : inn <: numtype))), k^N : nat^N}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VSHUFFLE_admininstr(`%X%`((inn : inn <: imm), `%`(N)), `%`(i)*{i})], [VCONST_admininstr(V128_vectype, c)])
    -- if (c'*{} = $lanes_(`%X%`((inn : inn <: lanetype), `%`(N)), c_1) :: $lanes_(`%X%`((inn : inn <: lanetype), `%`(N)), c_2))
    -- if (c = $invlanes_(`%X%`((inn : inn <: lanetype), `%`(N)), c'*{}[i*{i}[k]]^(k<N){k}))

  ;; 8-reduction.watsup
  rule vsplat{lnn : lnn, c_1 : num_($lunpack(lnn)), N : N, c : vec_(V128_vnn)}:
    `%*_~>%*`([CONST_admininstr($lunpack(lnn), c_1) VSPLAT_admininstr(`%X%`(lnn, `%`(N)))], [VCONST_admininstr(V128_vectype, c)])
    -- if (c = $invlanes_(`%X%`(lnn, `%`(N)), $packnum(lnn, c_1)^N{}))

  ;; 8-reduction.watsup
  rule vextract_lane-num{c_1 : vec_(V128_vnn), nt : numtype, N : N, i : nat, c_2 : num_(nt)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VEXTRACT_LANE_admininstr(`%X%`((nt : numtype <: lanetype), `%`(N)), ?(), `%`(i))], [CONST_admininstr(nt, c_2)])
    -- if (c_2 = $lanes_(`%X%`((nt : numtype <: lanetype), `%`(N)), c_1)[i])

  ;; 8-reduction.watsup
  rule vextract_lane-pack{c_1 : vec_(V128_vnn), pt : packtype, N : N, sx : sx, i : nat, c_2 : num_(I32_numtype)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VEXTRACT_LANE_admininstr(`%X%`((pt : packtype <: lanetype), `%`(N)), ?(sx), `%`(i))], [CONST_admininstr(I32_numtype, c_2)])
    -- if (c_2 = $ext($psize(pt), 32, sx, $lanes_(`%X%`((pt : packtype <: lanetype), `%`(N)), c_1)[i]))

  ;; 8-reduction.watsup
  rule vreplace_lane{c_1 : vec_(V128_vnn), lnn : lnn, c_2 : num_($lunpack(lnn)), N : N, i : nat, c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) CONST_admininstr($lunpack(lnn), c_2) VREPLACE_LANE_admininstr(`%X%`(lnn, `%`(N)), `%`(i))], [VCONST_admininstr(V128_vectype, c)])
    -- if (c = $invlanes_(`%X%`(lnn, `%`(N)), $lanes_(`%X%`(lnn, `%`(N)), c_1)[[i] = $packnum(lnn, c_2)]))

  ;; 8-reduction.watsup
  rule vunop{c_1 : vec_(V128_vnn), sh : shape, vunop : vunop_(sh), c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VUNOP_admininstr(sh, vunop)], [VCONST_admininstr(V128_vectype, c)])
    -- if (c = $vunop(sh, vunop, c_1))

  ;; 8-reduction.watsup
  rule vbinop-val{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), sh : shape, vbinop : vbinop_(sh), c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VBINOP_admininstr(sh, vbinop)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vbinop(sh, vbinop, c_1, c_2) = [c])

  ;; 8-reduction.watsup
  rule vbinop-trap{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), sh : shape, vbinop : vbinop_(sh)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VBINOP_admininstr(sh, vbinop)], [TRAP_admininstr])
    -- if ($vbinop(sh, vbinop, c_1, c_2) = [])

  ;; 8-reduction.watsup
  rule vrelop{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), sh : shape, vrelop : vrelop_(sh), c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VRELOP_admininstr(sh, vrelop)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vrelop(sh, vrelop, c_1, c_2) = c)

  ;; 8-reduction.watsup
  rule vshiftop{c_1 : vec_(V128_vnn), n : n, imm : imm, N : N, vshiftop : vshiftop_(`%X%`(imm, `%`(N))), c : vec_(V128_vnn), c'* : lane_($lanetype(`%X%`((imm : imm <: lanetype), `%`(N))))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) CONST_admininstr(I32_numtype, `%`(n)) VSHIFTOP_admininstr(`%X%`(imm, `%`(N)), vshiftop)], [VCONST_admininstr(V128_vectype, c)])
    -- if (c'*{c'} = $lanes_(`%X%`((imm : imm <: lanetype), `%`(N)), c_1))
    -- if (c = $invlanes_(`%X%`((imm : imm <: lanetype), `%`(N)), $vishiftop(`%X%`(imm, `%`(N)), vshiftop, c', `%`(n))*{c'}))

  ;; 8-reduction.watsup
  rule vtestop-true{c : vec_(V128_vnn), inn : inn, N : N, ci_1* : lane_($lanetype(`%X%`((inn : inn <: lanetype), `%`(N))))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c) VTESTOP_admininstr(`%X%`((inn : inn <: lanetype), `%`(N)), ALL_TRUE_vtestop_(`%X%`((inn : inn <: lanetype), `%`(N))))], [CONST_admininstr(I32_numtype, `%`(1))])
    -- if (ci_1*{ci_1} = $lanes_(`%X%`((inn : inn <: lanetype), `%`(N)), c))
    -- (if (ci_1 =/= `%`(0)))*{ci_1}

  ;; 8-reduction.watsup
  rule vtestop-false{c : vec_(V128_vnn), inn : inn, N : N}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c) VTESTOP_admininstr(`%X%`((inn : inn <: lanetype), `%`(N)), ALL_TRUE_vtestop_(`%X%`((inn : inn <: lanetype), `%`(N))))], [CONST_admininstr(I32_numtype, `%`(0))])
    -- otherwise

  ;; 8-reduction.watsup
  rule vbitmask{c : vec_(V128_vnn), inn : inn, N : N, ci : num_(I32_numtype), ci_1* : lane_($lanetype(`%X%`((inn : inn <: lanetype), `%`(N))))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c) VBITMASK_admininstr(`%X%`((inn : inn <: imm), `%`(N)))], [CONST_admininstr(I32_numtype, ci)])
    -- if (ci_1*{ci_1} = $lanes_(`%X%`((inn : inn <: lanetype), `%`(N)), c))
    -- if ($ibits(32, ci) = `%`($ilt($size((inn : inn <: numtype)), S_sx, ci_1, `%`(0)).`%`.0)*{ci_1})

  ;; 8-reduction.watsup
  rule vnarrow{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), inn_1 : inn, N_1 : N, inn_2 : inn, N_2 : N, sx : sx, c : vec_(V128_vnn), ci_1* : lane_($lanetype(`%X%`((inn_1 : inn <: lanetype), `%`(N_1))))*, ci_2* : lane_($lanetype(`%X%`((inn_1 : inn <: lanetype), `%`(N_1))))*, cj_1* : iN($size((inn_2 : inn <: numtype)))*, cj_2* : iN($size((inn_2 : inn <: numtype)))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VNARROW_admininstr(`%X%`((inn_1 : inn <: imm), `%`(N_1)), `%X%`((inn_2 : inn <: imm), `%`(N_2)), sx)], [VCONST_admininstr(V128_vectype, c)])
    -- if (ci_1*{ci_1} = $lanes_(`%X%`((inn_1 : inn <: lanetype), `%`(N_1)), c_1))
    -- if (ci_2*{ci_2} = $lanes_(`%X%`((inn_1 : inn <: lanetype), `%`(N_1)), c_2))
    -- if (cj_1*{cj_1} = $narrow($size((inn_1 : inn <: numtype)), $size((inn_2 : inn <: numtype)), sx, ci_1)*{ci_1})
    -- if (cj_2*{cj_2} = $narrow($size((inn_1 : inn <: numtype)), $size((inn_2 : inn <: numtype)), sx, ci_2)*{ci_2})
    -- if (c = $invlanes_(`%X%`((inn_2 : inn <: lanetype), `%`(N_2)), cj_1*{cj_1} :: cj_2*{cj_2}))

  ;; 8-reduction.watsup
  rule vcvtop-normal{c_1 : vec_(V128_vnn), lnn_2 : lnn, N_2 : N, vcvtop : vcvtop, lnn_1 : lnn, N_1 : N, sx : sx, c : vec_(V128_vnn), c'* : lane_($lanetype(`%X%`(lnn_1, `%`(N_1))))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCVTOP_admininstr(`%X%`(lnn_2, `%`(N_2)), vcvtop, ?(), `%X%`(lnn_1, `%`(N_1)), ?(sx), `ZERO%?`(?()))], [VCONST_admininstr(V128_vectype, c)])
    -- if (c'*{c'} = $lanes_(`%X%`(lnn_1, `%`(N_1)), c_1))
    -- if (c = $invlanes_(`%X%`(lnn_2, `%`(N_2)), $vcvtop(`%X%`(lnn_1, `%`(N_1)), `%X%`(lnn_2, `%`(N_2)), vcvtop, ?(sx), c')*{c'}))

  ;; 8-reduction.watsup
  rule vcvtop-half{c_1 : vec_(V128_vnn), inn_2 : inn, N_2 : N, vcvtop : vcvtop, hf : half, inn_1 : inn, N_1 : N, sx? : sx?, c : vec_(V128_vnn), ci* : lane_($lanetype(`%X%`((inn_1 : inn <: lanetype), `%`(N_1))))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCVTOP_admininstr(`%X%`((inn_2 : inn <: lanetype), `%`(N_2)), vcvtop, ?(hf), `%X%`((inn_1 : inn <: lanetype), `%`(N_1)), sx?{sx}, `ZERO%?`(?()))], [VCONST_admininstr(V128_vectype, c)])
    -- if (ci*{ci} = $lanes_(`%X%`((inn_1 : inn <: lanetype), `%`(N_1)), c_1)[$halfop(hf, 0, N_2) : N_2])
    -- if (c = $invlanes_(`%X%`((inn_2 : inn <: lanetype), `%`(N_2)), $vcvtop(`%X%`((inn_1 : inn <: lanetype), `%`(N_1)), `%X%`((inn_2 : inn <: lanetype), `%`(N_2)), vcvtop, sx?{sx}, ci)*{ci}))

  ;; 8-reduction.watsup
  rule vcvtop-zero{c_1 : vec_(V128_vnn), inn_2 : inn, N_2 : N, vcvtop : vcvtop, inn_1 : inn, N_1 : N, sx? : sx?, c : vec_(V128_vnn), ci* : lane_($lanetype(`%X%`((inn_1 : inn <: lanetype), `%`(N_1))))*}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCVTOP_admininstr(`%X%`((inn_2 : inn <: lanetype), `%`(N_2)), vcvtop, ?(), `%X%`((inn_1 : inn <: lanetype), `%`(N_1)), sx?{sx}, `ZERO%?`(?(())))], [VCONST_admininstr(V128_vectype, c)])
    -- if (ci*{ci} = $lanes_(`%X%`((inn_1 : inn <: lanetype), `%`(N_1)), c_1))
    -- if (c = $invlanes_(`%X%`((inn_2 : inn <: lanetype), `%`(N_2)), $vcvtop(`%X%`((inn_1 : inn <: lanetype), `%`(N_1)), `%X%`((inn_2 : inn <: lanetype), `%`(N_2)), vcvtop, sx?{sx}, ci)*{ci} :: `%`(0)^N_1{}))

  ;; 8-reduction.watsup
  rule vextunop{c_1 : vec_(V128_vnn), sh_1 : ishape, sh_2 : ishape, vextunop : vextunop_(sh_1, sh_2), sx : sx, c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VEXTUNOP_admininstr(sh_1, sh_2, vextunop, sx)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vextunop(sh_1, sh_2, vextunop, sx, c_1) = c)

  ;; 8-reduction.watsup
  rule vextbinop{c_1 : vec_(V128_vnn), c_2 : vec_(V128_vnn), sh_1 : ishape, sh_2 : ishape, vextbinop : vextbinop_(sh_1, sh_2), sx : sx, c : vec_(V128_vnn)}:
    `%*_~>%*`([VCONST_admininstr(V128_vectype, c_1) VCONST_admininstr(V128_vectype, c_2) VEXTBINOP_admininstr(sh_1, sh_2, vextbinop, sx)], [VCONST_admininstr(V128_vectype, c)])
    -- if ($vextbinop(sh_1, sh_2, vextbinop, sx, c_1, c_2) = c)

  ;; 8-reduction.watsup
  rule local.tee{val : val, x : idx}:
    `%*_~>%*`([(val : val <: admininstr) LOCAL.TEE_admininstr(x)], [(val : val <: admininstr) (val : val <: admininstr) LOCAL.SET_admininstr(x)])

;; 8-reduction.watsup
def $blocktype(state : state, blocktype : blocktype) : functype
  ;; 8-reduction.watsup
  def $blocktype{z : state}(z, _RESULT_blocktype(?())) = `%->%`([], [])
  ;; 8-reduction.watsup
  def $blocktype{z : state, t : valtype}(z, _RESULT_blocktype(?(t))) = `%->%`([], [t])
  ;; 8-reduction.watsup
  def $blocktype{z : state, x : idx, ft : functype}(z, _IDX_blocktype(x)) = ft
    -- Expand: `%~~%`($type(z, x), FUNC_comptype(ft))

;; 8-reduction.watsup
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 8-reduction.watsup
  rule block{z : state, val^k : val^k, k : nat, bt : blocktype, instr* : instr*, n : n, t_1^k : valtype^k, t_2^n : valtype^n}:
    `%~>%*`(`%;%*`(z, (val : val <: admininstr)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})]), [LABEL__admininstr(n, [], (val : val <: admininstr)^k{val} :: (instr : instr <: admininstr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 8-reduction.watsup
  rule loop{z : state, val^k : val^k, k : nat, bt : blocktype, instr* : instr*, t_1^k : valtype^k, t_2^n : valtype^n, n : n}:
    `%~>%*`(`%;%*`(z, (val : val <: admininstr)^k{val} :: [LOOP_admininstr(bt, instr*{instr})]), [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], (val : val <: admininstr)^k{val} :: (instr : instr <: admininstr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 8-reduction.watsup
  rule br_on_cast-succeed{z : state, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype, rt : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) BR_ON_CAST_admininstr(l, rt_1, rt_2)]), [(ref : ref <: admininstr) BR_admininstr(l)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))

  ;; 8-reduction.watsup
  rule br_on_cast-fail{z : state, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) BR_ON_CAST_admininstr(l, rt_1, rt_2)]), [(ref : ref <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup
  rule br_on_cast_fail-succeed{z : state, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype, rt : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) BR_ON_CAST_FAIL_admininstr(l, rt_1, rt_2)]), [(ref : ref <: admininstr)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))

  ;; 8-reduction.watsup
  rule br_on_cast_fail-fail{z : state, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) BR_ON_CAST_FAIL_admininstr(l, rt_1, rt_2)]), [(ref : ref <: admininstr) BR_admininstr(l)])
    -- otherwise

  ;; 8-reduction.watsup
  rule call{z : state, x : idx}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x.`%`.0]) CALL_REF_admininstr(?())])

  ;; 8-reduction.watsup
  rule call_ref-null{z : state, ht : heaptype, x? : idx?}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CALL_REF_admininstr(x?{x})]), [TRAP_admininstr])

  ;; 8-reduction.watsup
  rule call_ref-func{z : state, val^n : val^n, n : n, a : addr, x? : idx?, m : m, f : frame, instr* : instr*, fi : funcinst, t_1^n : valtype^n, t_2^m : valtype^m, y : idx, t* : valtype*}:
    `%~>%*`(`%;%*`(z, (val : val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a) CALL_REF_admininstr(x?{x})]), [FRAME__admininstr(m, f, [LABEL__admininstr(m, [], (instr : instr <: admininstr)*{instr})])])
    -- if ($funcinst(z)[a] = fi)
    -- Expand: `%~~%`(fi.TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
    -- if (fi.CODE_funcinst = `FUNC%%*%`(y, LOCAL(t)*{t}, instr*{instr}))
    -- if (f = {LOCAL ?(val)^n{val} :: $default(t)*{t}, MODULE fi.MODULE_funcinst})

  ;; 8-reduction.watsup
  rule return_call{z : state, x : idx}:
    `%~>%*`(`%;%*`(z, [RETURN_CALL_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x.`%`.0]) RETURN_CALL_REF_admininstr(?())])

  ;; 8-reduction.watsup
  rule return_call_ref-label{z : state, k : nat, instr'* : instr*, val* : val*, x? : idx?, instr* : instr*}:
    `%~>%*`(`%;%*`(z, [LABEL__admininstr(k, instr'*{instr'}, (val : val <: admininstr)*{val} :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr : instr <: admininstr)*{instr})]), (val : val <: admininstr)*{val} :: [RETURN_CALL_REF_admininstr(x?{x})])

  ;; 8-reduction.watsup
  rule return_call_ref-frame-addr{z : state, k : nat, f : frame, val'* : val*, val^n : val^n, n : n, a : addr, x? : idx?, instr* : instr*, t_1^n : valtype^n, t_2^m : valtype^m, m : m}:
    `%~>%*`(`%;%*`(z, [FRAME__admininstr(k, f, (val' : val <: admininstr)*{val'} :: (val : val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a)] :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr : instr <: admininstr)*{instr})]), (val : val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(a) CALL_REF_admininstr(x?{x})])
    -- Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))

  ;; 8-reduction.watsup
  rule return_call_ref-frame-null{z : state, k : nat, f : frame, val* : val*, ht : heaptype, x? : idx?, instr* : instr*}:
    `%~>%*`(`%;%*`(z, [FRAME__admininstr(k, f, (val : val <: admininstr)*{val} :: [REF.NULL_admininstr(ht)] :: [RETURN_CALL_REF_admininstr(x?{x})] :: (instr : instr <: admininstr)*{instr})]), [TRAP_admininstr])

  ;; 8-reduction.watsup
  rule ref.func{z : state, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x.`%`.0])])

  ;; 8-reduction.watsup
  rule ref.test-true{z : state, ref : ref, rt : reftype, rt' : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) REF.TEST_admininstr(rt)]), [CONST_admininstr(I32_numtype, `%`(1))])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))

  ;; 8-reduction.watsup
  rule ref.test-false{z : state, ref : ref, rt : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) REF.TEST_admininstr(rt)]), [CONST_admininstr(I32_numtype, `%`(0))])
    -- otherwise

  ;; 8-reduction.watsup
  rule ref.cast-succeed{z : state, ref : ref, rt : reftype, rt' : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) REF.CAST_admininstr(rt)]), [(ref : ref <: admininstr)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))

  ;; 8-reduction.watsup
  rule ref.cast-fail{z : state, ref : ref, rt : reftype}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) REF.CAST_admininstr(rt)]), [TRAP_admininstr])
    -- otherwise

  ;; 8-reduction.watsup
  rule struct.new_default{z : state, x : idx, val* : val*, mut* : mut*, zt* : storagetype*}:
    `%~>%*`(`%;%*`(z, [STRUCT.NEW_DEFAULT_admininstr(x)]), (val : val <: admininstr)*{val} :: [STRUCT.NEW_admininstr(x)])
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- (if ($default($unpack(zt)) = ?(val)))*{val zt}

  ;; 8-reduction.watsup
  rule struct.get-null{z : state, ht : heaptype, sx? : sx?, x : idx, i : nat}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) STRUCT.GET_admininstr(sx?{sx}, x, `%`(i))]), [TRAP_admininstr])

  ;; 8-reduction.watsup
  rule struct.get-struct{z : state, a : addr, sx? : sx?, x : idx, i : nat, zt* : storagetype*, si : structinst, mut* : mut*}:
    `%~>%*`(`%;%*`(z, [REF.STRUCT_ADDR_admininstr(a) STRUCT.GET_admininstr(sx?{sx}, x, `%`(i))]), [($unpackval(zt*{zt}[i], sx?{sx}, si.FIELD_structinst[i]) : val <: admininstr)])
    -- if ($structinst(z)[a] = si)
    -- Expand: `%~~%`(si.TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))

  ;; 8-reduction.watsup
  rule array.new{z : state, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [(val : val <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.NEW_admininstr(x)]), (val : val <: admininstr)^n{} :: [ARRAY.NEW_FIXED_admininstr(x, n)])

  ;; 8-reduction.watsup
  rule array.new_default{z : state, n : n, x : idx, val : val, mut : mut, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(n)) ARRAY.NEW_DEFAULT_admininstr(x)]), (val : val <: admininstr)^n{} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ($default($unpack(zt)) = ?(val))

  ;; 8-reduction.watsup
  rule array.new_elem-oob{z : state, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.NEW_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$elem(z, y).ELEM_eleminst|)

  ;; 8-reduction.watsup
  rule array.new_elem-alloc{z : state, i : nat, n : n, x : idx, y : idx, ref^n : ref^n}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.NEW_ELEM_admininstr(x, y)]), (ref : ref <: admininstr)^n{ref} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- if (ref^n{ref} = $elem(z, y).ELEM_eleminst[i : n])

  ;; 8-reduction.watsup
  rule array.new_data-oob{z : state, i : nat, n : n, x : idx, y : idx, mut : mut, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.NEW_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ((i + ((n * $zsize(zt)) / 8)) > |$data(z, y).DATA_datainst|)

  ;; 8-reduction.watsup
  rule array.new_data-num{z : state, i : nat, n : n, x : idx, y : idx, nt : numtype, c^n : num_(nt)^n, mut : mut, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.NEW_DATA_admininstr(x, y)]), CONST_admininstr(nt, c)^n{c} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (nt = $nunpack(zt))
    -- if ($concat_(syntax byte, $nbytes(nt, c)^n{c}) = $data(z, y).DATA_datainst[i : ((n * $zsize(zt)) / 8)])

  ;; 8-reduction.watsup
  rule array.new_data-vec{z : state, i : nat, n : n, x : idx, y : idx, vt : vectype, c^n : vec_(vt)^n, mut : mut, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.NEW_DATA_admininstr(x, y)]), VCONST_admininstr(vt, c)^n{c} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (vt = $vunpack(zt))
    -- if ($concat_(syntax byte, $vbytes(vt, c)^n{c}) = $data(z, y).DATA_datainst[i : ((n * $zsize(zt)) / 8)])

  ;; 8-reduction.watsup
  rule array.get-null{z : state, ht : heaptype, i : nat, sx? : sx?, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, `%`(i)) ARRAY.GET_admininstr(sx?{sx}, x)]), [TRAP_admininstr])

  ;; 8-reduction.watsup
  rule array.get-oob{z : state, a : addr, i : nat, sx? : sx?, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) ARRAY.GET_admininstr(sx?{sx}, x)]), [TRAP_admininstr])
    -- if (i >= |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup
  rule array.get-array{z : state, a : addr, i : nat, sx? : sx?, x : idx, zt : storagetype, fv : fieldval, mut : mut}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) ARRAY.GET_admininstr(sx?{sx}, x)]), [($unpackval(zt, sx?{sx}, fv) : val <: admininstr)])
    -- if (fv = $arrayinst(z)[a].FIELD_arrayinst[i])
    -- Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))

  ;; 8-reduction.watsup
  rule array.len-null{z : state, ht : heaptype}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) ARRAY.LEN_admininstr]), [TRAP_admininstr])

  ;; 8-reduction.watsup
  rule array.len-array{z : state, a : addr, n : n}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) ARRAY.LEN_admininstr]), [CONST_admininstr(I32_numtype, `%`(n))])
    -- if (n = |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup
  rule array.fill-null{z : state, ht : heaptype, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.FILL_admininstr(x)]), [TRAP_admininstr])

  ;; 8-reduction.watsup
  rule array.fill-oob{z : state, a : addr, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup
  rule array.fill-zero{z : state, a : addr, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule array.fill-succ{z : state, a : addr, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.FILL_admininstr(x)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`((i + 1))) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`((n - 1))) ARRAY.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup
  rule array.copy-null1{z : state, ht_1 : heaptype, i_1 : nat, ref : ref, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht_1) CONST_admininstr(I32_numtype, `%`(i_1)) (ref : ref <: admininstr) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])

  ;; 8-reduction.watsup
  rule array.copy-null2{z : state, ref : ref, i_1 : nat, ht_2 : heaptype, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [(ref : ref <: admininstr) CONST_admininstr(I32_numtype, `%`(i_1)) REF.NULL_admininstr(ht_2) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])

  ;; 8-reduction.watsup
  rule array.copy-oob1{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, `%`(i_1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if ((i_1 + n) > |$arrayinst(z)[a_1].FIELD_arrayinst|)

  ;; 8-reduction.watsup
  rule array.copy-oob2{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, `%`(i_1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if ((i_2 + n) > |$arrayinst(z)[a_2].FIELD_arrayinst|)

  ;; 8-reduction.watsup
  rule array.copy-zero{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, `%`(i_1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.COPY_admininstr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule array.copy-le{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx, sx? : sx?, mut : mut, zt_2 : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, `%`(i_1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.COPY_admininstr(x_1, x_2)]), [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, `%`(i_1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, `%`(i_2)) ARRAY.GET_admininstr(sx?{sx}, x_2) ARRAY.SET_admininstr(x_1) REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, `%`((i_1 + 1))) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, `%`((i_2 + 1))) CONST_admininstr(I32_numtype, `%`((n - 1))) ARRAY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
    -- if (sx?{sx} = $sxfield(zt_2))
    -- if (i_1 <= i_2)

  ;; 8-reduction.watsup
  rule array.copy-gt{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx, sx? : sx?, mut : mut, zt_2 : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, `%`(i_1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.COPY_admininstr(x_1, x_2)]), [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, `%`(((i_1 + n) - 1))) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, `%`(((i_2 + n) - 1))) ARRAY.GET_admininstr(sx?{sx}, x_2) ARRAY.SET_admininstr(x_1) REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, `%`(i_1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`((n - 1))) ARRAY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
    -- if (sx?{sx} = $sxfield(zt_2))

  ;; 8-reduction.watsup
  rule array.init_elem-null{z : state, ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])

  ;; 8-reduction.watsup
  rule array.init_elem-oob1{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup
  rule array.init_elem-oob2{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((j + n) > |$elem(z, y).ELEM_eleminst|)

  ;; 8-reduction.watsup
  rule array.init_elem-zero{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.INIT_ELEM_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule array.init_elem-succ{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, ref : ref}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.INIT_ELEM_admininstr(x, y)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) (ref : ref <: admininstr) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`((i + 1))) CONST_admininstr(I32_numtype, `%`((j + 1))) CONST_admininstr(I32_numtype, `%`((n - 1))) ARRAY.INIT_ELEM_admininstr(x, y)])
    -- otherwise
    -- if (ref = $elem(z, y).ELEM_eleminst[j])

  ;; 8-reduction.watsup
  rule array.init_data-null{z : state, ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])

  ;; 8-reduction.watsup
  rule array.init_data-oob1{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup
  rule array.init_data-oob2{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, mut : mut, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ((j + ((n * $zsize(zt)) / 8)) > |$data(z, y).DATA_datainst|)

  ;; 8-reduction.watsup
  rule array.init_data-zero{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.INIT_DATA_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule array.init_data-num{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, nt : numtype, c : num_(nt), zt : storagetype, mut : mut}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.INIT_DATA_admininstr(x, y)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(nt, c) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`((i + 1))) CONST_admininstr(I32_numtype, `%`((j + ($zsize(zt) / 8)))) CONST_admininstr(I32_numtype, `%`((n - 1))) ARRAY.INIT_DATA_admininstr(x, y)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (nt = $nunpack(zt))
    -- if ($nbytes(nt, c) = $data(z, y).DATA_datainst[j : ($zsize(zt) / 8)])

  ;; 8-reduction.watsup
  rule array.init_data-num{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, vt : vectype, c : vec_(vt), zt : storagetype, mut : mut}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(n)) ARRAY.INIT_DATA_admininstr(x, y)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) VCONST_admininstr(vt, c) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`((i + 1))) CONST_admininstr(I32_numtype, `%`((j + ($zsize(zt) / 8)))) CONST_admininstr(I32_numtype, `%`((n - 1))) ARRAY.INIT_DATA_admininstr(x, y)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (vt = $vunpack((vt : vectype <: storagetype)))
    -- if ($vbytes(vt, c) = $data(z, y).DATA_datainst[j : ($zsize(zt) / 8)])

  ;; 8-reduction.watsup
  rule local.get{z : state, x : idx, val : val}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [(val : val <: admininstr)])
    -- if ($local(z, x) = ?(val))

  ;; 8-reduction.watsup
  rule global.get{z : state, x : idx}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [($global(z, x).VALUE_globalinst : val <: admininstr)])

  ;; 8-reduction.watsup
  rule table.get-oob{z : state, i : nat, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup
  rule table.get-val{z : state, i : nat, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) TABLE.GET_admininstr(x)]), [($table(z, x).ELEM_tableinst[i] : ref <: admininstr)])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup
  rule table.size{z : state, x : idx, n : n}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, `%`(n))])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 8-reduction.watsup
  rule table.fill-oob{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup
  rule table.fill-zero{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule table.fill-succ{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, `%`((i + 1))) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`((n - 1))) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup
  rule table.copy-oob{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 8-reduction.watsup
  rule table.copy-zero{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule table.copy-le{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(i)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, `%`((j + 1))) CONST_admininstr(I32_numtype, `%`((i + 1))) CONST_admininstr(I32_numtype, `%`((n - 1))) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 8-reduction.watsup
  rule table.copy-gt{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, `%`(((j + n) - 1))) CONST_admininstr(I32_numtype, `%`(((i + n) - 1))) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`((n - 1))) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup
  rule table.init-oob{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 8-reduction.watsup
  rule table.init-zero{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule table.init-succ{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, `%`(j)) ($elem(z, y).ELEM_eleminst[i] : ref <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, `%`((j + 1))) CONST_admininstr(I32_numtype, `%`((i + 1))) CONST_admininstr(I32_numtype, `%`((n - 1))) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup
  rule load-num-oob{z : state, i : nat, nt : numtype, x : idx, mo : memop}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) LOAD_admininstr(nt, ?(), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop.`%`.0) + ($size(nt) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule load-num-val{z : state, i : nat, nt : numtype, x : idx, mo : memop, c : num_(nt)}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) LOAD_admininstr(nt, ?(), x, mo)]), [CONST_admininstr(nt, c)])
    -- if ($nbytes(nt, c) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop.`%`.0) : ($size(nt) / 8)])

  ;; 8-reduction.watsup
  rule load-pack-oob{z : state, i : nat, inn : inn, n : n, sx : sx, x : idx, mo : memop}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) LOAD_admininstr((inn : inn <: numtype), ?((n, sx)), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop.`%`.0) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule load-pack-val{z : state, i : nat, inn : inn, n : n, sx : sx, x : idx, mo : memop, c : iN(n)}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) LOAD_admininstr((inn : inn <: numtype), ?((n, sx)), x, mo)]), [CONST_admininstr((inn : inn <: numtype), $ext(n, $size((inn : inn <: numtype)), sx, c))])
    -- if ($ibytes(n, c) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop.`%`.0) : (n / 8)])

  ;; 8-reduction.watsup
  rule vload-oob{z : state, i : nat, x : idx, mo : memop}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VLOAD_admininstr(?(), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop.`%`.0) + ($vsize(V128_vectype) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule vload-val{z : state, i : nat, x : idx, mo : memop, c : vec_(V128_vnn)}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VLOAD_admininstr(?(), x, mo)]), [VCONST_admininstr(V128_vectype, c)])
    -- if ($vbytes(V128_vectype, c) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop.`%`.0) : ($vsize(V128_vectype) / 8)])

  ;; 8-reduction.watsup
  rule vload-shape-oob{z : state, i : nat, M : M, N : N, sx : sx, x : idx, mo : memop}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VLOAD_admininstr(?(SHAPE_vloadop(M, N, sx)), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop.`%`.0) + ((M * N) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule vload-shape-val{z : state, i : nat, M : M, N : N, sx : sx, x : idx, mo : memop, c : vec_(V128_vnn), j^N : nat^N, k^N : nat^N, inn : inn}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VLOAD_admininstr(?(SHAPE_vloadop(M, N, sx)), x, mo)]), [VCONST_admininstr(V128_vectype, c)])
    -- (if ($ibytes(M, `%`(j)) = $mem(z, x).DATA_meminst[((i + mo.OFFSET_memop.`%`.0) + ((k * M) / 8)) : (M / 8)]))^(k<N){j k}
    -- if ($size((inn : inn <: numtype)) = (M * 2))
    -- if (c = $invlanes_(`%X%`((inn : inn <: lanetype), `%`(N)), $ext(M, $size((inn : inn <: numtype)), sx, `%`(j))^N{j}))

  ;; 8-reduction.watsup
  rule vload-splat-oob{z : state, i : nat, N : N, x : idx, mo : memop}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VLOAD_admininstr(?(SPLAT_vloadop(N)), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop.`%`.0) + (N / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule vload-splat-val{z : state, i : nat, N : N, x : idx, mo : memop, c : vec_(V128_vnn), j : nat, imm : imm, M : M}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VLOAD_admininstr(?(SPLAT_vloadop(N)), x, mo)]), [VCONST_admininstr(V128_vectype, c)])
    -- if ($ibytes(N, `%`(j)) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop.`%`.0) : (N / 8)])
    -- if (N = $lsize((imm : imm <: lanetype)))
    -- if (M = (128 / N))
    -- if (c = $invlanes_(`%X%`((imm : imm <: lanetype), `%`(M)), `%`(j)^M{}))

  ;; 8-reduction.watsup
  rule vload-zero-oob{z : state, i : nat, N : N, x : idx, mo : memop}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VLOAD_admininstr(?(ZERO_vloadop(N)), x, mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop.`%`.0) + (N / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule vload-zero-val{z : state, i : nat, N : N, x : idx, mo : memop, c : vec_(V128_vnn), j : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VLOAD_admininstr(?(ZERO_vloadop(N)), x, mo)]), [VCONST_admininstr(V128_vectype, c)])
    -- if ($ibytes(N, `%`(j)) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop.`%`.0) : (N / 8)])
    -- if (c = $ext(N, 128, U_sx, `%`(j)))

  ;; 8-reduction.watsup
  rule vload_lane-oob{z : state, i : nat, vt : vectype, c_1 : vec_(vt), N : N, x : idx, mo : memop, j : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VCONST_admininstr(vt, c_1) VLOAD_LANE_admininstr(N, x, mo, `%`(j))]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop.`%`.0) + (N / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule vload_lane-val{z : state, i : nat, vt : vectype, c_1 : vec_(vt), N : N, x : idx, mo : memop, j : nat, c : vec_(vt), k : nat, imm : imm, M : M}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VCONST_admininstr(vt, c_1) VLOAD_LANE_admininstr(N, x, mo, `%`(j))]), [VCONST_admininstr(vt, c)])
    -- if ($ibytes(N, `%`(k)) = $mem(z, x).DATA_meminst[(i + mo.OFFSET_memop.`%`.0) : (N / 8)])
    -- if (N = $lsize((imm : imm <: lanetype)))
    -- if (M = ($vsize(vt) / N))
    -- if (c = `%`($invlanes_(`%X%`((imm : imm <: lanetype), `%`(M)), $lanes_(`%X%`((imm : imm <: lanetype), `%`(M)), `%`(c_1.`%`.0))[[j] = `%`(k)]).`%`.0))

  ;; 8-reduction.watsup
  rule memory.size{z : state, x : idx, n : n}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, `%`(n))])
    -- if (((n * 64) * $Ki) = |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule memory.fill-oob{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) MEMORY.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule memory.fill-zero{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) MEMORY.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule memory.fill-succ{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) MEMORY.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) STORE_admininstr(I32_numtype, ?(8), x, $memop0) CONST_admininstr(I32_numtype, `%`((i + 1))) (val : val <: admininstr) CONST_admininstr(I32_numtype, `%`((n - 1))) MEMORY.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup
  rule memory.copy-oob{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i_1)) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`(n)) MEMORY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if (((i_1 + n) > |$mem(z, x_1).DATA_meminst|) \/ ((i_2 + n) > |$mem(z, x_2).DATA_meminst|))

  ;; 8-reduction.watsup
  rule memory.copy-zero{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i_1)) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`(n)) MEMORY.COPY_admininstr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule memory.copy-le{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i_1)) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`(n)) MEMORY.COPY_admininstr(x_1, x_2)]), [CONST_admininstr(I32_numtype, `%`(i_1)) CONST_admininstr(I32_numtype, `%`(i_2)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), x_2, $memop0) STORE_admininstr(I32_numtype, ?(8), x_1, $memop0) CONST_admininstr(I32_numtype, `%`((i_1 + 1))) CONST_admininstr(I32_numtype, `%`((i_2 + 1))) CONST_admininstr(I32_numtype, `%`((n - 1))) MEMORY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- if (i_1 <= i_2)

  ;; 8-reduction.watsup
  rule memory.copy-gt{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i_1)) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`(n)) MEMORY.COPY_admininstr(x_1, x_2)]), [CONST_admininstr(I32_numtype, `%`(((i_1 + n) - 1))) CONST_admininstr(I32_numtype, `%`(((i_2 + n) - 1))) LOAD_admininstr(I32_numtype, ?((8, U_sx)), x_2, $memop0) STORE_admininstr(I32_numtype, ?(8), x_1, $memop0) CONST_admininstr(I32_numtype, `%`(i_1)) CONST_admininstr(I32_numtype, `%`(i_2)) CONST_admininstr(I32_numtype, `%`((n - 1))) MEMORY.COPY_admininstr(x_1, x_2)])
    -- otherwise

  ;; 8-reduction.watsup
  rule memory.init-oob{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) MEMORY.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, y).DATA_datainst|) \/ ((j + n) > |$mem(z, x).DATA_meminst|))

  ;; 8-reduction.watsup
  rule memory.init-zero{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) MEMORY.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule memory.init-succ{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(I32_numtype, `%`(n)) MEMORY.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, `%`(j)) CONST_admininstr(I32_numtype, `%`($data(z, y).DATA_datainst[i].`%`.0)) STORE_admininstr(I32_numtype, ?(8), x, $memop0) CONST_admininstr(I32_numtype, `%`((j + 1))) CONST_admininstr(I32_numtype, `%`((i + 1))) CONST_admininstr(I32_numtype, `%`((n - 1))) MEMORY.INIT_admininstr(x, y)])
    -- otherwise

;; 8-reduction.watsup
relation Step: `%~>%`(config, config)
  ;; 8-reduction.watsup
  rule pure{z : state, instr* : instr*, instr'* : instr*}:
    `%~>%`(`%;%*`(z, (instr : instr <: admininstr)*{instr}), `%;%*`(z, (instr' : instr <: admininstr)*{instr'}))
    -- Step_pure: `%*_~>%*`((instr : instr <: admininstr)*{instr}, (instr' : instr <: admininstr)*{instr'})

  ;; 8-reduction.watsup
  rule read{z : state, instr* : instr*, instr'* : instr*}:
    `%~>%`(`%;%*`(z, (instr : instr <: admininstr)*{instr}), `%;%*`(z, (instr' : instr <: admininstr)*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, (instr : instr <: admininstr)*{instr}), (instr' : instr <: admininstr)*{instr'})

  ;; 8-reduction.watsup
  rule struct.new{z : state, val^n : val^n, n : n, x : idx, si : structinst, mut^n : mut^n, zt^n : storagetype^n}:
    `%~>%`(`%;%*`(z, (val : val <: admininstr)^n{val} :: [STRUCT.NEW_admininstr(x)]), `%;%*`($ext_structinst(z, [si]), [REF.STRUCT_ADDR_admininstr(|$structinst(z)|)]))
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)^n{mut zt}))
    -- if (si = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val zt}})

  ;; 8-reduction.watsup
  rule struct.set-null{z : state, ht : heaptype, val : val, x : idx, i : nat}:
    `%~>%`(`%;%*`(z, [REF.NULL_admininstr(ht) (val : val <: admininstr) STRUCT.SET_admininstr(x, `%`(i))]), `%;%*`(z, [TRAP_admininstr]))

  ;; 8-reduction.watsup
  rule struct.set-struct{z : state, a : addr, val : val, x : idx, i : nat, fv : fieldval, mut* : mut*, zt* : storagetype*}:
    `%~>%`(`%;%*`(z, [REF.STRUCT_ADDR_admininstr(a) (val : val <: admininstr) STRUCT.SET_admininstr(x, `%`(i))]), `%;%*`($with_struct(z, a, i, fv), []))
    -- Expand: `%~~%`($structinst(z)[a].TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- if (fv = $packval(zt*{zt}[i], val))

  ;; 8-reduction.watsup
  rule array.new_fixed{z : state, val^n : val^n, n : n, x : idx, ai : arrayinst, mut : mut, zt : storagetype}:
    `%~>%`(`%;%*`(z, (val : val <: admininstr)^n{val} :: [ARRAY.NEW_FIXED_admininstr(x, n)]), `%;%*`($ext_arrayinst(z, [ai]), [REF.ARRAY_ADDR_admininstr(|$arrayinst(z)|)]))
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (ai = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val}})

  ;; 8-reduction.watsup
  rule array.set-null{z : state, ht : heaptype, i : nat, val : val, x : idx}:
    `%~>%`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))

  ;; 8-reduction.watsup
  rule array.set-oob{z : state, a : addr, i : nat, val : val, x : idx}:
    `%~>%`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup
  rule array.set-array{z : state, a : addr, i : nat, val : val, x : idx, fv : fieldval, mut : mut, zt : storagetype}:
    `%~>%`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, `%`(i)) (val : val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`($with_array(z, a, i, fv), []))
    -- Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))
    -- if (fv = $packval(zt, val))

  ;; 8-reduction.watsup
  rule local.set{z : state, val : val, x : idx}:
    `%~>%`(`%;%*`(z, [(val : val <: admininstr) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 8-reduction.watsup
  rule global.set{z : state, val : val, x : idx}:
    `%~>%`(`%;%*`(z, [(val : val <: admininstr) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 8-reduction.watsup
  rule table.set-oob{z : state, i : nat, ref : ref, x : idx}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) (ref : ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup
  rule table.set-val{z : state, i : nat, ref : ref, x : idx}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) (ref : ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup
  rule table.grow-succeed{z : state, ref : ref, n : n, x : idx, ti : tableinst}:
    `%~>%`(`%;%*`(z, [(ref : ref <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti), [CONST_admininstr(I32_numtype, `%`(|$table(z, x).ELEM_tableinst|))]))
    -- if (ti = $growtable($table(z, x), n, ref))

  ;; 8-reduction.watsup
  rule table.grow-fail{z : state, ref : ref, n : n, x : idx}:
    `%~>%`(`%;%*`(z, [(ref : ref <: admininstr) CONST_admininstr(I32_numtype, `%`(n)) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, `%`($invsigned(32, - (1 : nat <: int))))]))

  ;; 8-reduction.watsup
  rule elem.drop{z : state, x : idx}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 8-reduction.watsup
  rule store-num-oob{z : state, i : nat, nt : numtype, c : num_(nt), x : idx, mo : memop}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), x, mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop.`%`.0) + ($size(nt) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule store-num-val{z : state, i : nat, nt : numtype, c : num_(nt), x : idx, mo : memop, b* : byte*}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), x, mo)]), `%;%*`($with_mem(z, x, (i + mo.OFFSET_memop.`%`.0), ($size(nt) / 8), b*{b}), []))
    -- if (b*{b} = $nbytes(nt, c))

  ;; 8-reduction.watsup
  rule store-pack-oob{z : state, i : nat, inn : inn, c : num_((inn : inn <: numtype)), nt : numtype, n : n, x : idx, mo : memop}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr((inn : inn <: numtype), c) STORE_admininstr(nt, ?(n), x, mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop.`%`.0) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule store-pack-val{z : state, i : nat, inn : inn, c : num_((inn : inn <: numtype)), nt : numtype, n : n, x : idx, mo : memop, b* : byte*}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) CONST_admininstr((inn : inn <: numtype), c) STORE_admininstr(nt, ?(n), x, mo)]), `%;%*`($with_mem(z, x, (i + mo.OFFSET_memop.`%`.0), (n / 8), b*{b}), []))
    -- if (b*{b} = $ibytes(n, $wrap($size((inn : inn <: numtype)), n, c)))

  ;; 8-reduction.watsup
  rule vstore-oob{z : state, i : nat, c : vec_(V128_vnn), x : idx, mo : memop}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VCONST_admininstr(V128_vectype, c) VSTORE_admininstr(x, mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop.`%`.0) + ($vsize(V128_vectype) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule vstore-val{z : state, i : nat, c : vec_(V128_vnn), x : idx, mo : memop, b* : byte*}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VCONST_admininstr(V128_vectype, c) VSTORE_admininstr(x, mo)]), `%;%*`($with_mem(z, x, (i + mo.OFFSET_memop.`%`.0), ($vsize(V128_vectype) / 8), b*{b}), []))
    -- if (b*{b} = $vbytes(V128_vectype, c))

  ;; 8-reduction.watsup
  rule vstore_lane-oob{z : state, i : nat, c : vec_(V128_vnn), N : N, x : idx, mo : memop, j : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VCONST_admininstr(V128_vectype, c) VSTORE_LANE_admininstr(N, x, mo, `%`(j))]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop.`%`.0) + N) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup
  rule vstore_lane-val{z : state, i : nat, c : vec_(V128_vnn), N : N, x : idx, mo : memop, j : nat, b* : byte*, imm : imm, M : M}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(i)) VCONST_admininstr(V128_vectype, c) VSTORE_LANE_admininstr(N, x, mo, `%`(j))]), `%;%*`($with_mem(z, x, (i + mo.OFFSET_memop.`%`.0), (N / 8), b*{b}), []))
    -- if (N = $lsize((imm : imm <: lanetype)))
    -- if (M = (128 / N))
    -- if (b*{b} = $ibytes(N, `%`($lanes_(`%X%`((imm : imm <: lanetype), `%`(M)), c)[j].`%`.0)))

  ;; 8-reduction.watsup
  rule memory.grow-succeed{z : state, n : n, x : idx, mi : meminst}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(n)) MEMORY.GROW_admininstr(x)]), `%;%*`($with_meminst(z, x, mi), [CONST_admininstr(I32_numtype, `%`((|$mem(z, x).DATA_meminst| / (64 * $Ki))))]))
    -- if (mi = $growmemory($mem(z, x), n))

  ;; 8-reduction.watsup
  rule memory.grow-fail{z : state, n : n, x : idx}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, `%`(n)) MEMORY.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, `%`($invsigned(32, - (1 : nat <: int))))]))

  ;; 8-reduction.watsup
  rule data.drop{z : state, x : idx}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 8-reduction.watsup
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

;; 8-reduction.watsup
relation Eval_expr: `%;%~>*%;%*`(state, expr, state, val*)
  ;; 8-reduction.watsup
  rule _{z : state, instr* : instr*, z' : state, val* : val*}:
    `%;%~>*%;%*`(z, instr*{instr}, z', val*{val})
    -- Steps: `%~>*%`(`%;%*`(z, (instr : instr <: admininstr)*{instr}), `%;%*`(z', (val : val <: admininstr)*{val}))

;; 9-module.watsup
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
    -- if (x = `%`(|deftype'*{deftype'}|))
}

;; 9-module.watsup
def $allocfunc(store : store, moduleinst : moduleinst, func : func) : (store, funcaddr)
  ;; 9-module.watsup
  def $allocfunc{s : store, mm : moduleinst, func : func, fi : funcinst, x : idx, local* : local*, expr : expr}(s, mm, func) = (s[FUNC_store =.. [fi]], |s.FUNC_store|)
    -- if (func = `FUNC%%*%`(x, local*{local}, expr))
    -- if (fi = {TYPE mm.TYPE_moduleinst[x.`%`.0], MODULE mm, CODE func})

;; 9-module.watsup
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

;; 9-module.watsup
def $allocglobal(store : store, globaltype : globaltype, val : val) : (store, globaladdr)
  ;; 9-module.watsup
  def $allocglobal{s : store, globaltype : globaltype, val : val, gi : globalinst}(s, globaltype, val) = (s[GLOBAL_store =.. [gi]], |s.GLOBAL_store|)
    -- if (gi = {TYPE globaltype, VALUE val})

;; 9-module.watsup
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

;; 9-module.watsup
def $alloctable(store : store, tabletype : tabletype, ref : ref) : (store, tableaddr)
  ;; 9-module.watsup
  def $alloctable{s : store, i : nat, j : nat, rt : reftype, ref : ref, ti : tableinst}(s, `%%`(`[%..%]`(`%`(i), `%`(j)), rt), ref) = (s[TABLE_store =.. [ti]], |s.TABLE_store|)
    -- if (ti = {TYPE `%%`(`[%..%]`(`%`(i), `%`(j)), rt), ELEM ref^i{}})

;; 9-module.watsup
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

;; 9-module.watsup
def $allocmem(store : store, memtype : memtype) : (store, memaddr)
  ;; 9-module.watsup
  def $allocmem{s : store, i : nat, j : nat, mi : meminst}(s, `%I8`(`[%..%]`(`%`(i), `%`(j)))) = (s[MEM_store =.. [mi]], |s.MEM_store|)
    -- if (mi = {TYPE `%I8`(`[%..%]`(`%`(i), `%`(j))), DATA `%`(0)^((i * 64) * $Ki){}})

;; 9-module.watsup
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

;; 9-module.watsup
def $allocelem(store : store, reftype : reftype, ref*) : (store, elemaddr)
  ;; 9-module.watsup
  def $allocelem{s : store, rt : reftype, ref* : ref*, ei : eleminst}(s, rt, ref*{ref}) = (s[ELEM_store =.. [ei]], |s.ELEM_store|)
    -- if (ei = {TYPE rt, ELEM ref*{ref}})

;; 9-module.watsup
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

;; 9-module.watsup
def $allocdata(store : store, byte*) : (store, dataaddr)
  ;; 9-module.watsup
  def $allocdata{s : store, byte* : byte*, di : datainst}(s, byte*{byte}) = (s[DATA_store =.. [di]], |s.DATA_store|)
    -- if (di = {DATA byte*{byte}})

;; 9-module.watsup
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

;; 9-module.watsup
def $instexport(funcaddr*, globaladdr*, tableaddr*, memaddr*, export : export) : exportinst
  ;; 9-module.watsup
  def $instexport{fa* : funcaddr*, ga* : globaladdr*, ta* : tableaddr*, ma* : memaddr*, name : name, x : idx}(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, FUNC_externidx(x))) = {NAME name, VALUE FUNC_externval(fa*{fa}[x.`%`.0])}
  ;; 9-module.watsup
  def $instexport{fa* : funcaddr*, ga* : globaladdr*, ta* : tableaddr*, ma* : memaddr*, name : name, x : idx}(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, GLOBAL_externidx(x))) = {NAME name, VALUE GLOBAL_externval(ga*{ga}[x.`%`.0])}
  ;; 9-module.watsup
  def $instexport{fa* : funcaddr*, ga* : globaladdr*, ta* : tableaddr*, ma* : memaddr*, name : name, x : idx}(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, TABLE_externidx(x))) = {NAME name, VALUE TABLE_externval(ta*{ta}[x.`%`.0])}
  ;; 9-module.watsup
  def $instexport{fa* : funcaddr*, ga* : globaladdr*, ta* : tableaddr*, ma* : memaddr*, name : name, x : idx}(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, MEM_externidx(x))) = {NAME name, VALUE MEM_externval(ma*{ma}[x.`%`.0])}

;; 9-module.watsup
def $allocmodule(store : store, module : module, externval*, val*, ref*, ref**) : (store, moduleinst)
  ;; 9-module.watsup
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

;; 9-module.watsup
def $runelem(elem : elem, idx : idx) : instr*
  ;; 9-module.watsup
  def $runelem{reftype : reftype, expr* : expr*, y : idx}(`ELEM%%*%`(reftype, expr*{expr}, PASSIVE_elemmode), y) = []
  ;; 9-module.watsup
  def $runelem{reftype : reftype, expr* : expr*, y : idx}(`ELEM%%*%`(reftype, expr*{expr}, DECLARE_elemmode), y) = [ELEM.DROP_instr(y)]
  ;; 9-module.watsup
  def $runelem{reftype : reftype, expr* : expr*, x : idx, instr* : instr*, y : idx}(`ELEM%%*%`(reftype, expr*{expr}, ACTIVE_elemmode(x, instr*{instr})), y) = instr*{instr} :: [CONST_instr(I32_numtype, `%`(0)) CONST_instr(I32_numtype, `%`(|expr*{expr}|)) TABLE.INIT_instr(x, y) ELEM.DROP_instr(y)]

;; 9-module.watsup
def $rundata(data : data, idx : idx) : instr*
  ;; 9-module.watsup
  def $rundata{byte* : byte*, y : idx}(`DATA%*%`(byte*{byte}, PASSIVE_datamode), y) = []
  ;; 9-module.watsup
  def $rundata{byte* : byte*, x : idx, instr* : instr*, y : idx}(`DATA%*%`(byte*{byte}, ACTIVE_datamode(x, instr*{instr})), y) = instr*{instr} :: [CONST_instr(I32_numtype, `%`(0)) CONST_instr(I32_numtype, `%`(|byte*{byte}|)) MEMORY.INIT_instr(x, y) DATA.DROP_instr(y)]

;; 9-module.watsup
def $instantiate(store : store, module : module, externval*) : config
  ;; 9-module.watsup
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
    -- if (instr_E*{instr_E} = $concat_(syntax instr, $runelem(elem*{elem}[i], `%`(i))^(i<n_E){i}))
    -- if (instr_D*{instr_D} = $concat_(syntax instr, $rundata(data*{data}[j], `%`(j))^(j<n_D){j}))

;; 9-module.watsup
def $invoke(store : store, funcaddr : funcaddr, val*) : config
  ;; 9-module.watsup
  def $invoke{s : store, fa : funcaddr, val^n : val^n, n : n, f : frame, x : idx, local* : local*, expr : expr, t_1^n : valtype^n, t_2* : valtype*}(s, fa, val^n{val}) = `%;%*`(`%;%`(s, f), (val : val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(fa) CALL_REF_admininstr(?(`%`(0)))])
    -- if (f = {LOCAL [], MODULE {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []}})
    -- if ($funcinst(`%;%`(s, f))[fa].CODE_funcinst = `FUNC%%*%`(x, local*{local}, expr))
    -- Expand: `%~~%`(s.FUNC_store[fa].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2*{t_2})))

;; A-binary.watsup
rec {

;; A-binary.watsup:49.1-49.24
def $utf8(name : name) : byte*
  ;; A-binary.watsup:50.1-50.47
  def $utf8{ch : nat, b : byte}([`%`(ch)]) = [b]
    -- if ((ch < 128) /\ (ch = b.`%`.0))
  ;; A-binary.watsup:51.1-51.96
  def $utf8{ch : nat, b_1 : byte, b_2 : byte}([`%`(ch)]) = [b_1 b_2]
    -- if (((128 <= ch) /\ (ch < 2048)) /\ (ch = (((2 ^ 6) * (b_1.`%`.0 - 192)) + (b_2.`%`.0 - 128))))
  ;; A-binary.watsup:52.1-52.148
  def $utf8{ch : nat, b_1 : byte, b_2 : byte, b_3 : byte}([`%`(ch)]) = [b_1 b_2 b_3]
    -- if ((((2048 <= ch) /\ (ch < 55296)) \/ ((57344 <= ch) /\ (ch < 65536))) /\ (ch = ((((2 ^ 12) * (b_1.`%`.0 - 224)) + ((2 ^ 6) * (b_2.`%`.0 - 128))) + (b_3.`%`.0 - 128))))
  ;; A-binary.watsup:53.1-53.148
  def $utf8{ch : nat, b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte}([`%`(ch)]) = [b_1 b_2 b_3 b_4]
    -- if (((65536 <= ch) /\ (ch < 69632)) /\ (ch = (((((2 ^ 18) * (b_1.`%`.0 - 240)) + ((2 ^ 12) * (b_2.`%`.0 - 128))) + ((2 ^ 6) * (b_3.`%`.0 - 128))) + (b_4.`%`.0 - 128))))
  ;; A-binary.watsup:54.1-54.44
  def $utf8{ch* : nat*}(`%`(ch)*{ch}) = $concat_(syntax byte, $utf8([`%`(ch)])*{ch})
}

;; A-binary.watsup
syntax castop = (nul, nul)

;; A-binary.watsup
syntax memidxop = (memidx, memop)

;; A-binary.watsup
syntax code = (local*, expr)

;; C-conventions.watsup
syntax A = nat

;; C-conventions.watsup
syntax B = nat

;; C-conventions.watsup
syntax sym =
  | _FIRST(A_1 : A)
  | _DOTS
  | _LAST(A_n : A)

;; C-conventions.watsup
syntax symsplit =
  | _FIRST(A_1 : A)
  | _LAST(A_2 : A)

;; C-conventions.watsup
syntax recorddots = `...`

;; C-conventions.watsup
syntax record =
{
  FIELD_1 A,
  FIELD_2 A,
  DOTS recorddots
}

;; C-conventions.watsup
syntax recordstar =
{
  FIELD_1 A*,
  FIELD_2 A*,
  DOTS recorddots
}

;; C-conventions.watsup
syntax recordeq = `%++%=%`(recordstar : recordstar, recordstar : recordstar, recordstar : recordstar)

;; C-conventions.watsup
syntax pth =
  | PTHSYNTAX

;; C-conventions.watsup
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
