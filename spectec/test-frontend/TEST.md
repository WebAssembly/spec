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
  def $sum{n : n, n'* : n*}([n] :: n'*{n' : nat}) = (n + $sum(n'*{n' : nat}))
}

;; 0-aux.watsup
rec {

;; 0-aux.watsup:39.1-39.59
def $concat_(syntax X, X**) : X*
  ;; 0-aux.watsup:40.1-40.34
  def $concat_{syntax X}(syntax X, []) = []
  ;; 0-aux.watsup:41.1-41.61
  def $concat_{syntax X, w* : X*, w'** : X**}(syntax X, [w*{w : X}] :: w'*{w' : X}*{w' : X}) = w*{w : X} :: $concat_(syntax X, w'*{w' : X}*{w' : X})
}

;; 1-syntax.watsup
syntax list{syntax X}(syntax X) =
  | `%`{X* : X*}(X*{X : X} : X*)
    -- if (|X*{X : X}| < (2 ^ 32))

;; 1-syntax.watsup
syntax bit =
  | `%`{i : nat}(i : nat)
    -- if ((i = 0) \/ (i = 1))

;; 1-syntax.watsup
syntax byte =
  | `%`{i : nat}(i : nat)
    -- if ((i >= 0) /\ (i <= 255))

;; 1-syntax.watsup
syntax uN{N : N}(N) =
  | `%`{i : nat}(i : nat)
    -- if ((i >= 0) /\ (i <= ((2 ^ N) - 1)))

;; 1-syntax.watsup
syntax sN{N : N}(N) =
  | `%`{i : int}(i : int)
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
  | `NAN(%)`{m : m}(m : m)
    -- if ((1 <= m) /\ (m < (2 ^ $M(N))))

;; 1-syntax.watsup
syntax fN{N : N}(N) =
  | POS{fNmag : fNmag(N)}(fNmag : fNmag(N))
  | NEG{fNmag : fNmag(N)}(fNmag : fNmag(N))

;; 1-syntax.watsup
syntax f32 = fN(32)

;; 1-syntax.watsup
syntax f64 = fN(64)

;; 1-syntax.watsup
def $fzero(N : N) : fN(N)
  ;; 1-syntax.watsup
  def $fzero{N : N}(N) = POS_fN(SUBNORM_fNmag(0))

;; 1-syntax.watsup
def $fone(N : N) : fN(N)
  ;; 1-syntax.watsup
  def $fone{N : N}(N) = POS_fN(NORM_fNmag(1, 0))

;; 1-syntax.watsup
def $canon_(N : N) : nat
  ;; 1-syntax.watsup
  def $canon_{N : N}(N) = (2 ^ ($signif(N) - 1))

;; 1-syntax.watsup
syntax vN{N : N}(N) = iN(N)

;; 1-syntax.watsup
syntax char =
  | `%`{i : nat}(i : nat)
    -- if (((i >= 0) /\ (i <= 55295)) \/ ((i >= 57344) /\ (i <= 1114111)))

;; A-binary.watsup
def $cont(byte : byte) : nat
  ;; A-binary.watsup
  def $cont{b : byte}(b) = (b!`%`_byte.0 - 128)
    -- if ((128 < b!`%`_byte.0) /\ (b!`%`_byte.0 < 192))

;; 1-syntax.watsup
rec {

;; 1-syntax.watsup:87.1-87.25
def $utf8(char*) : byte*
  ;; A-binary.watsup:53.1-53.44
  def $utf8{ch* : char*}(ch*{ch : char}) = $concat_(syntax byte, $utf8([ch])*{ch : char})
  ;; A-binary.watsup:54.1-56.15
  def $utf8{ch : char, b : byte}([ch]) = [b]
    -- if (ch!`%`_char.0 < 128)
    -- if (ch = `%`_char(b!`%`_byte.0))
  ;; A-binary.watsup:57.1-59.46
  def $utf8{ch : char, b_1 : byte, b_2 : byte}([ch]) = [b_1 b_2]
    -- if ((128 <= ch!`%`_char.0) /\ (ch!`%`_char.0 < 2048))
    -- if (ch = `%`_char((((2 ^ 6) * (b_1!`%`_byte.0 - 192)) + $cont(b_2))))
  ;; A-binary.watsup:60.1-62.64
  def $utf8{ch : char, b_1 : byte, b_2 : byte, b_3 : byte}([ch]) = [b_1 b_2 b_3]
    -- if (((2048 <= ch!`%`_char.0) /\ (ch!`%`_char.0 < 55296)) \/ ((57344 <= ch!`%`_char.0) /\ (ch!`%`_char.0 < 65536)))
    -- if (ch = `%`_char(((((2 ^ 12) * (b_1!`%`_byte.0 - 224)) + ((2 ^ 6) * $cont(b_2))) + $cont(b_3))))
  ;; A-binary.watsup:63.1-65.82
  def $utf8{ch : char, b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte}([ch]) = [b_1 b_2 b_3 b_4]
    -- if ((65536 <= ch!`%`_char.0) /\ (ch!`%`_char.0 < 69632))
    -- if (ch = `%`_char((((((2 ^ 18) * (b_1!`%`_byte.0 - 240)) + ((2 ^ 12) * $cont(b_2))) + ((2 ^ 6) * $cont(b_3))) + $cont(b_4))))
}

;; 1-syntax.watsup
syntax name =
  | `%`{char* : char*}(char*{char : char} : char*)
    -- if (|$utf8(char*{char : char})| < (2 ^ 32))

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
syntax fieldidx = idx

;; 1-syntax.watsup
syntax nul =
  | `NULL%?`(()?)

;; 1-syntax.watsup
syntax nul1 =
  | `NULL%?`(()?)

;; 1-syntax.watsup
syntax nul2 =
  | `NULL%?`(()?)

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
syntax consttype =
  | I32
  | I64
  | F32
  | F64
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
syntax mut =
  | `MUT%?`(()?)

;; 1-syntax.watsup
syntax fin =
  | `FINAL%?`(()?)

;; 1-syntax.watsup
rec {

;; 1-syntax.watsup:153.1-154.26
syntax typeuse =
  | _IDX{typeidx : typeidx}(typeidx : typeidx)
  | DEF{rectype : rectype, n : n}(rectype : rectype, n : n)
  | REC{n : n}(n : n)

;; 1-syntax.watsup:156.1-157.26
syntax heaptype =
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
  | _IDX{typeidx : typeidx}(typeidx : typeidx)
  | REC{n : n}(n : n)
  | DEF{rectype : rectype, n : n}(rectype : rectype, n : n)

;; 1-syntax.watsup:164.1-165.14
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | REF{nul : nul, heaptype : heaptype}(nul : nul, heaptype : heaptype)
  | BOT

;; 1-syntax.watsup:194.1-195.16
syntax resulttype = list(syntax valtype)

;; 1-syntax.watsup:202.1-202.66
syntax storagetype =
  | BOT
  | I32
  | I64
  | F32
  | F64
  | V128
  | REF{nul : nul, heaptype : heaptype}(nul : nul, heaptype : heaptype)
  | I8
  | I16

;; 1-syntax.watsup:218.1-218.60
syntax fieldtype =
  | `%%`{mut : mut, storagetype : storagetype}(mut : mut, storagetype : storagetype)

;; 1-syntax.watsup:220.1-220.90
syntax functype =
  | `%->%`{resulttype : resulttype}(resulttype : resulttype, resulttype)

;; 1-syntax.watsup:221.1-221.64
syntax structtype = list(syntax fieldtype)

;; 1-syntax.watsup:222.1-222.54
syntax arraytype = fieldtype

;; 1-syntax.watsup:224.1-227.18
syntax comptype =
  | STRUCT{structtype : structtype}(structtype : structtype)
  | ARRAY{arraytype : arraytype}(arraytype : arraytype)
  | FUNC{functype : functype}(functype : functype)

;; 1-syntax.watsup:229.1-230.30
syntax subtype =
  | SUB{fin : fin, typeuse* : typeuse*, comptype : comptype}(fin : fin, typeuse*{typeuse : typeuse} : typeuse*, comptype : comptype)

;; 1-syntax.watsup:232.1-233.22
syntax rectype =
  | REC{list : list(syntax subtype)}(list : list(syntax subtype))
}

;; 1-syntax.watsup
syntax deftype =
  | DEF{rectype : rectype, n : n}(rectype : rectype, n : n)

;; 1-syntax.watsup
syntax reftype =
  | REF{nul : nul, heaptype : heaptype}(nul : nul, heaptype : heaptype)

;; 1-syntax.watsup
syntax Inn =
  | I32
  | I64

;; 1-syntax.watsup
syntax Fnn =
  | F32
  | F64

;; 1-syntax.watsup
syntax Vnn =
  | V128

;; 1-syntax.watsup
syntax Cnn =
  | I32
  | I64
  | F32
  | F64
  | V128

;; 1-syntax.watsup
def $ANYREF : reftype
  ;; 1-syntax.watsup
  def $ANYREF = REF_reftype(`NULL%?`_nul(?(())), ANY_heaptype)

;; 1-syntax.watsup
def $EQREF : reftype
  ;; 1-syntax.watsup
  def $EQREF = REF_reftype(`NULL%?`_nul(?(())), EQ_heaptype)

;; 1-syntax.watsup
def $I31REF : reftype
  ;; 1-syntax.watsup
  def $I31REF = REF_reftype(`NULL%?`_nul(?(())), I31_heaptype)

;; 1-syntax.watsup
def $STRUCTREF : reftype
  ;; 1-syntax.watsup
  def $STRUCTREF = REF_reftype(`NULL%?`_nul(?(())), STRUCT_heaptype)

;; 1-syntax.watsup
def $ARRAYREF : reftype
  ;; 1-syntax.watsup
  def $ARRAYREF = REF_reftype(`NULL%?`_nul(?(())), ARRAY_heaptype)

;; 1-syntax.watsup
def $FUNCREF : reftype
  ;; 1-syntax.watsup
  def $FUNCREF = REF_reftype(`NULL%?`_nul(?(())), FUNC_heaptype)

;; 1-syntax.watsup
def $EXTERNREF : reftype
  ;; 1-syntax.watsup
  def $EXTERNREF = REF_reftype(`NULL%?`_nul(?(())), EXTERN_heaptype)

;; 1-syntax.watsup
def $NULLREF : reftype
  ;; 1-syntax.watsup
  def $NULLREF = REF_reftype(`NULL%?`_nul(?(())), NONE_heaptype)

;; 1-syntax.watsup
def $NULLFUNCREF : reftype
  ;; 1-syntax.watsup
  def $NULLFUNCREF = REF_reftype(`NULL%?`_nul(?(())), NOFUNC_heaptype)

;; 1-syntax.watsup
def $NULLEXTERNREF : reftype
  ;; 1-syntax.watsup
  def $NULLEXTERNREF = REF_reftype(`NULL%?`_nul(?(())), NOEXTERN_heaptype)

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
syntax Pnn =
  | I8
  | I16

;; 1-syntax.watsup
syntax Jnn =
  | I32
  | I64
  | I8
  | I16

;; 1-syntax.watsup
syntax Lnn =
  | I32
  | I64
  | F32
  | F64
  | I8
  | I16

;; 1-syntax.watsup
syntax mut1 =
  | `MUT%?`(()?)

;; 1-syntax.watsup
syntax mut2 =
  | `MUT%?`(()?)

;; 1-syntax.watsup
syntax limits =
  | `[%..%]`{u32 : u32}(u32 : u32, u32)

;; 1-syntax.watsup
syntax globaltype =
  | `%%`{mut : mut, valtype : valtype}(mut : mut, valtype : valtype)

;; 1-syntax.watsup
syntax tabletype =
  | `%%`{limits : limits, reftype : reftype}(limits : limits, reftype : reftype)

;; 1-syntax.watsup
syntax memtype =
  | `%PAGE`{limits : limits}(limits : limits)

;; 1-syntax.watsup
syntax elemtype = reftype

;; 1-syntax.watsup
syntax datatype =
  | OK

;; 1-syntax.watsup
syntax externtype =
  | FUNC{typeuse : typeuse}(typeuse : typeuse)
  | GLOBAL{globaltype : globaltype}(globaltype : globaltype)
  | TABLE{tabletype : tabletype}(tabletype : tabletype)
  | MEM{memtype : memtype}(memtype : memtype)

;; 1-syntax.watsup
syntax moduletype =
  | `%->%`{externtype* : externtype*}(externtype*{externtype : externtype} : externtype*, externtype*)

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
def $isize(Inn : Inn) : nat
  ;; 2-syntax-aux.watsup
  def $isize{Inn : Inn}(Inn) = $size((Inn : Inn <: numtype))

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
syntax dim =
  | `%`{i : nat}(i : nat)
    -- if (((((i = 1) \/ (i = 2)) \/ (i = 4)) \/ (i = 8)) \/ (i = 16))

;; 1-syntax.watsup
syntax shape =
  | `%X%`{lanetype : lanetype, dim : dim}(lanetype : lanetype, dim : dim)

;; 1-syntax.watsup
def $lanetype(shape : shape) : lanetype
  ;; 2-syntax-aux.watsup
  def $lanetype{Lnn : Lnn, N : N}(`%X%`_shape(Lnn, `%`_dim(N))) = Lnn

;; 1-syntax.watsup
def $sizenn(numtype : numtype) : nat
  ;; 1-syntax.watsup
  def $sizenn{nt : numtype}(nt) = $size(nt)

;; 1-syntax.watsup
def $sizenn1(numtype : numtype) : nat
  ;; 1-syntax.watsup
  def $sizenn1{nt : numtype}(nt) = $size(nt)

;; 1-syntax.watsup
def $sizenn2(numtype : numtype) : nat
  ;; 1-syntax.watsup
  def $sizenn2{nt : numtype}(nt) = $size(nt)

;; 1-syntax.watsup
def $psizenn(packtype : packtype) : nat
  ;; 1-syntax.watsup
  def $psizenn{pt : packtype}(pt) = $psize(pt)

;; 1-syntax.watsup
def $lsizenn(lanetype : lanetype) : nat
  ;; 1-syntax.watsup
  def $lsizenn{lt : lanetype}(lt) = $lsize(lt)

;; 1-syntax.watsup
def $lsizenn1(lanetype : lanetype) : nat
  ;; 1-syntax.watsup
  def $lsizenn1{lt : lanetype}(lt) = $lsize(lt)

;; 1-syntax.watsup
def $lsizenn2(lanetype : lanetype) : nat
  ;; 1-syntax.watsup
  def $lsizenn2{lt : lanetype}(lt) = $lsize(lt)

;; 1-syntax.watsup
syntax num_(numtype : numtype)
  ;; 1-syntax.watsup
  syntax num_{Inn : Inn}((Inn : Inn <: numtype)) = iN($sizenn((Inn : Inn <: numtype)))


  ;; 1-syntax.watsup
  syntax num_{Fnn : Fnn}((Fnn : Fnn <: numtype)) = fN($sizenn((Fnn : Fnn <: numtype)))


;; 1-syntax.watsup
syntax pack_{Pnn : Pnn}(Pnn) = iN($psizenn(Pnn))

;; 1-syntax.watsup
syntax lane_(lanetype : lanetype)
  ;; 1-syntax.watsup
  syntax lane_{numtype : numtype}((numtype : numtype <: lanetype)) = num_(numtype)


  ;; 1-syntax.watsup
  syntax lane_{packtype : packtype}((packtype : packtype <: lanetype)) = pack_(packtype)


  ;; 1-syntax.watsup
  syntax lane_{Jnn : Jnn}((Jnn : Jnn <: lanetype)) = iN($lsize((Jnn : Jnn <: lanetype)))


;; 1-syntax.watsup
syntax vec_{Vnn : Vnn}(Vnn) = vN($vsize(Vnn))

;; 1-syntax.watsup
syntax lit_(storagetype : storagetype)
  ;; 1-syntax.watsup
  syntax lit_{numtype : numtype}((numtype : numtype <: storagetype)) = num_(numtype)


  ;; 1-syntax.watsup
  syntax lit_{vectype : vectype}((vectype : vectype <: storagetype)) = vec_(vectype)


  ;; 1-syntax.watsup
  syntax lit_{packtype : packtype}((packtype : packtype <: storagetype)) = pack_(packtype)


;; 1-syntax.watsup
def $zero(numtype : numtype) : num_(numtype)
  ;; 1-syntax.watsup
  def $zero{Inn : Inn}((Inn : Inn <: numtype)) = `%`_num_(0)
  ;; 1-syntax.watsup
  def $zero{Fnn : Fnn}((Fnn : Fnn <: numtype)) = $fzero($size((Fnn : Fnn <: numtype)))

;; 1-syntax.watsup
syntax sz =
  | `%`{i : nat}(i : nat)
    -- if ((((i = 8) \/ (i = 16)) \/ (i = 32)) \/ (i = 64))

;; 1-syntax.watsup
syntax sx =
  | U
  | S

;; 1-syntax.watsup
syntax unop_(numtype : numtype)
  ;; 1-syntax.watsup
  syntax unop_{Inn : Inn}((Inn : Inn <: numtype)) =
  | CLZ
  | CTZ
  | POPCNT
  | EXTEND{sz : sz}(sz : sz)
    -- if (sz!`%`_sz.0 < $sizenn((Inn : Inn <: numtype)))


  ;; 1-syntax.watsup
  syntax unop_{Fnn : Fnn}((Fnn : Fnn <: numtype)) =
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
  syntax binop_{Inn : Inn}((Inn : Inn <: numtype)) =
  | ADD
  | SUB
  | MUL
  | DIV{sx : sx}(sx : sx)
  | REM{sx : sx}(sx : sx)
  | AND
  | OR
  | XOR
  | SHL
  | SHR{sx : sx}(sx : sx)
  | ROTL
  | ROTR


  ;; 1-syntax.watsup
  syntax binop_{Fnn : Fnn}((Fnn : Fnn <: numtype)) =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN


;; 1-syntax.watsup
syntax testop_{Inn : Inn}((Inn : Inn <: numtype)) =
  | EQZ

;; 1-syntax.watsup
syntax relop_(numtype : numtype)
  ;; 1-syntax.watsup
  syntax relop_{Inn : Inn}((Inn : Inn <: numtype)) =
  | EQ
  | NE
  | LT{sx : sx}(sx : sx)
  | GT{sx : sx}(sx : sx)
  | LE{sx : sx}(sx : sx)
  | GE{sx : sx}(sx : sx)


  ;; 1-syntax.watsup
  syntax relop_{Fnn : Fnn}((Fnn : Fnn <: numtype)) =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE


;; 1-syntax.watsup
syntax cvtop_{numtype_1 : numtype, numtype_2 : numtype}(numtype_1, numtype_2) =
  | CONVERT
  | CONVERT_SAT{numtype_1 : numtype, Inn : Inn, numtype_2 : numtype, Fnn : Fnn}
    -- if ((numtype_1 = (Inn : Inn <: numtype)) /\ (numtype_2 = (Fnn : Fnn <: numtype)))
  | REINTERPRET
    -- if ($size(numtype_1) =/= $size(numtype_2))

;; 1-syntax.watsup
syntax ishape =
  | `%X%`{Jnn : Jnn, dim : dim}(Jnn : Jnn, dim : dim)

;; 1-syntax.watsup
syntax fshape =
  | `%X%`{Fnn : Fnn, dim : dim}(Fnn : Fnn, dim : dim)

;; 1-syntax.watsup
syntax pshape =
  | `%X%`{Pnn : Pnn, dim : dim}(Pnn : Pnn, dim : dim)

;; 1-syntax.watsup
def $dim(shape : shape) : dim
  ;; 2-syntax-aux.watsup
  def $dim{Lnn : Lnn, N : N}(`%X%`_shape(Lnn, `%`_dim(N))) = `%`_dim(N)

;; 1-syntax.watsup
def $shsize(shape : shape) : nat
  ;; 2-syntax-aux.watsup
  def $shsize{Lnn : Lnn, N : N}(`%X%`_shape(Lnn, `%`_dim(N))) = ($lsize(Lnn) * N)

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
  syntax vunop_{Jnn : Jnn, M : M}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))) =
  | ABS
  | NEG
  | POPCNT{Jnn : Jnn}
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) = 8)


  ;; 1-syntax.watsup
  syntax vunop_{Fnn : Fnn, M : M}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))) =
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
  syntax vbinop_{Jnn : Jnn, M : M}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))) =
  | ADD
  | SUB
  | ADD_SAT{sx : sx}(sx : sx)
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) <= 16)
  | SUB_SAT{sx : sx}(sx : sx)
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) <= 16)
  | MUL
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) >= 16)
  | AVGR_U
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) <= 16)
  | Q15MULR_SAT_S{Jnn : Jnn}
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) = 16)
  | MIN{sx : sx}(sx : sx)
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) <= 32)
  | MAX{sx : sx}(sx : sx)
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) <= 32)


  ;; 1-syntax.watsup
  syntax vbinop_{Fnn : Fnn, M : M}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))) =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | PMIN
  | PMAX


;; 1-syntax.watsup
syntax vtestop_{Jnn : Jnn, M : M}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))) =
  | ALL_TRUE

;; 1-syntax.watsup
syntax vrelop_(shape : shape)
  ;; 1-syntax.watsup
  syntax vrelop_{Jnn : Jnn, M : M}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))) =
  | EQ
  | NE
  | LT{sx : sx}(sx : sx)
    -- if (($lsizenn((Jnn : Jnn <: lanetype)) =/= 64) \/ (sx = S_sx))
  | GT{sx : sx}(sx : sx)
    -- if (($lsizenn((Jnn : Jnn <: lanetype)) =/= 64) \/ (sx = S_sx))
  | LE{sx : sx}(sx : sx)
    -- if (($lsizenn((Jnn : Jnn <: lanetype)) =/= 64) \/ (sx = S_sx))
  | GE{sx : sx}(sx : sx)
    -- if (($lsizenn((Jnn : Jnn <: lanetype)) =/= 64) \/ (sx = S_sx))


  ;; 1-syntax.watsup
  syntax vrelop_{Fnn : Fnn, M : M}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))) =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE


;; 1-syntax.watsup
syntax vcvtop_(shape_1 : shape, shape_2 : shape)
  ;; 1-syntax.watsup
  syntax vcvtop_{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))) =
  | EXTEND{Jnn_2 : Jnn, Jnn_1 : Jnn}
    -- if ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = (2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))))


  ;; 1-syntax.watsup
  syntax vcvtop_{Jnn_1 : Jnn, M_1 : M, Fnn_2 : Fnn, M_2 : M}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2))) =
  | CONVERT
    -- if (($sizenn2((Fnn_2 : Fnn <: numtype)) >= $lsizenn1((Jnn_1 : Jnn <: lanetype))) /\ ($lsizenn1((Jnn_1 : Jnn <: lanetype)) = 32))


  ;; 1-syntax.watsup
  syntax vcvtop_{Fnn_1 : Fnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))) =
  | TRUNC_SAT
    -- if (($sizenn1((Fnn_1 : Fnn <: numtype)) >= $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = 32))


  ;; 1-syntax.watsup
  syntax vcvtop_{Fnn_1 : Fnn, M_1 : M, Fnn_2 : Fnn, M_2 : M}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2))) =
  | DEMOTE
    -- if ($sizenn1((Fnn_1 : Fnn <: numtype)) > $sizenn2((Fnn_2 : Fnn <: numtype)))
  | PROMOTE
    -- if ($sizenn1((Fnn_1 : Fnn <: numtype)) < $sizenn2((Fnn_2 : Fnn <: numtype)))


;; 1-syntax.watsup
syntax half =
  | LOW
  | HIGH

;; 1-syntax.watsup
syntax half_{shape_1 : shape, shape_2 : shape}(shape_1, shape_2) =
  | `%`{half : half, shape_1 : shape, imm_1 : lanetype, shape_2 : shape, imm_2 : lanetype}(half : half)
    -- if ((($lanetype(shape_1) = imm_1) /\ ($lanetype(shape_2) = imm_2)) \/ (($lanetype(shape_2) = F64_lanetype) /\ ($lsize($lanetype(shape_1)) = 32)))

;; 1-syntax.watsup
syntax zero_{shape_1 : shape, shape_2 : shape}(shape_1, shape_2) =
  | ZERO{shape_1 : shape, shape_2 : shape}
    -- if (($lanetype(shape_1) = F64_lanetype) /\ ($lsize($lanetype(shape_2)) = 32))

;; 1-syntax.watsup
syntax vshiftop_{Jnn : Jnn, M : M}(`%X%`_ishape(Jnn, `%`_dim(M))) =
  | SHL
  | SHR{sx : sx}(sx : sx)

;; 1-syntax.watsup
syntax vextunop_{Jnn : Jnn, M : M}(`%X%`_ishape(Jnn, `%`_dim(M))) =
  | EXTADD_PAIRWISE
    -- if ((16 <= $lsizenn((Jnn : Jnn <: lanetype))) /\ ($lsizenn((Jnn : Jnn <: lanetype)) <= 32))

;; 1-syntax.watsup
syntax vextbinop_{Jnn : Jnn, M : M}(`%X%`_ishape(Jnn, `%`_dim(M))) =
  | EXTMUL{half : half}(half : half)
  | DOT{Jnn : Jnn}
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) = 32)

;; 1-syntax.watsup
syntax memarg =
{
  ALIGN{u32 : u32} u32,
  OFFSET{u32 : u32} u32
}

;; 1-syntax.watsup
syntax loadop_{Inn : Inn}((Inn : Inn <: numtype)) =
  | `%%`{sz : sz, sx : sx}(sz : sz, sx : sx)
    -- if (sz!`%`_sz.0 < $sizenn((Inn : Inn <: numtype)))

;; 1-syntax.watsup
syntax vloadop_{vectype : vectype}(vectype) =
  | `SHAPE%X%%`{sz : sz, M : M, sx : sx, vectype : vectype}(sz : sz, M : M, sx : sx)
    -- if ((sz!`%`_sz.0 * M) = ($vsize(vectype) / 2))
  | SPLAT{sz : sz}(sz : sz)
  | ZERO{sz : sz}(sz : sz)
    -- if (sz!`%`_sz.0 >= 32)

;; 1-syntax.watsup
syntax blocktype =
  | _RESULT{valtype? : valtype?}(valtype?{valtype : valtype} : valtype?)
  | _IDX{funcidx : funcidx}(funcidx : funcidx)

;; 4-runtime.watsup
syntax addr = nat

;; 4-runtime.watsup
syntax arrayaddr = addr

;; 4-runtime.watsup
syntax funcaddr = addr

;; 4-runtime.watsup
syntax hostaddr = addr

;; 4-runtime.watsup
syntax structaddr = addr

;; 4-runtime.watsup
rec {

;; 4-runtime.watsup:37.1-43.23
syntax addrref =
  | REF.I31_NUM{u31 : u31}(u31 : u31)
  | REF.STRUCT_ADDR{structaddr : structaddr}(structaddr : structaddr)
  | REF.ARRAY_ADDR{arrayaddr : arrayaddr}(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR{funcaddr : funcaddr}(funcaddr : funcaddr)
  | REF.HOST_ADDR{hostaddr : hostaddr}(hostaddr : hostaddr)
  | REF.EXTERN{addrref : addrref}(addrref : addrref)
}

;; 4-runtime.watsup
syntax dataaddr = addr

;; 4-runtime.watsup
syntax elemaddr = addr

;; 4-runtime.watsup
syntax globaladdr = addr

;; 4-runtime.watsup
syntax memaddr = addr

;; 4-runtime.watsup
syntax tableaddr = addr

;; 4-runtime.watsup
syntax externval =
  | FUNC{funcaddr : funcaddr}(funcaddr : funcaddr)
  | GLOBAL{globaladdr : globaladdr}(globaladdr : globaladdr)
  | TABLE{tableaddr : tableaddr}(tableaddr : tableaddr)
  | MEM{memaddr : memaddr}(memaddr : memaddr)

;; 4-runtime.watsup
syntax exportinst =
{
  NAME{name : name} name,
  VALUE{externval : externval} externval
}

;; 4-runtime.watsup
syntax moduleinst =
{
  TYPES{deftype* : deftype*} deftype*,
  FUNCS{funcaddr* : funcaddr*} funcaddr*,
  GLOBALS{globaladdr* : globaladdr*} globaladdr*,
  TABLES{tableaddr* : tableaddr*} tableaddr*,
  MEMS{memaddr* : memaddr*} memaddr*,
  ELEMS{elemaddr* : elemaddr*} elemaddr*,
  DATAS{dataaddr* : dataaddr*} dataaddr*,
  EXPORTS{exportinst* : exportinst*} exportinst*
}

;; 4-runtime.watsup
syntax val =
  | CONST{numtype : numtype, num_ : num_(numtype)}(numtype : numtype, num_ : num_(numtype))
  | VCONST{vectype : vectype, vec_ : vec_(vectype)}(vectype : vectype, vec_ : vec_(vectype))
  | REF.NULL{heaptype : heaptype}(heaptype : heaptype)
  | REF.I31_NUM{u31 : u31}(u31 : u31)
  | REF.STRUCT_ADDR{structaddr : structaddr}(structaddr : structaddr)
  | REF.ARRAY_ADDR{arrayaddr : arrayaddr}(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR{funcaddr : funcaddr}(funcaddr : funcaddr)
  | REF.HOST_ADDR{hostaddr : hostaddr}(hostaddr : hostaddr)
  | REF.EXTERN{addrref : addrref}(addrref : addrref)

;; 4-runtime.watsup
syntax frame =
{
  LOCALS{val?* : val?*} val?*,
  MODULE{moduleinst : moduleinst} moduleinst
}

;; 4-runtime.watsup
rec {

;; 4-runtime.watsup:151.1-156.9
syntax instr =
  | NOP
  | UNREACHABLE
  | DROP
  | `SELECT()%?`{valtype*? : valtype*?}(valtype*{valtype : valtype}?{valtype : valtype} : valtype*?)
  | BLOCK{blocktype : blocktype, instr* : instr*}(blocktype : blocktype, instr*{instr : instr} : instr*)
  | LOOP{blocktype : blocktype, instr* : instr*}(blocktype : blocktype, instr*{instr : instr} : instr*)
  | `IF%%ELSE%`{blocktype : blocktype, instr* : instr*}(blocktype : blocktype, instr*{instr : instr} : instr*, instr*)
  | BR{labelidx : labelidx}(labelidx : labelidx)
  | BR_IF{labelidx : labelidx}(labelidx : labelidx)
  | BR_TABLE{labelidx : labelidx}(labelidx*{} : labelidx*, labelidx)
  | BR_ON_NULL{labelidx : labelidx}(labelidx : labelidx)
  | BR_ON_NON_NULL{labelidx : labelidx}(labelidx : labelidx)
  | BR_ON_CAST{labelidx : labelidx, reftype : reftype}(labelidx : labelidx, reftype : reftype, reftype)
  | BR_ON_CAST_FAIL{labelidx : labelidx, reftype : reftype}(labelidx : labelidx, reftype : reftype, reftype)
  | CALL{funcidx : funcidx}(funcidx : funcidx)
  | CALL_REF{typeuse : typeuse}(typeuse : typeuse)
  | CALL_INDIRECT{tableidx : tableidx, typeuse : typeuse}(tableidx : tableidx, typeuse : typeuse)
  | RETURN
  | RETURN_CALL{funcidx : funcidx}(funcidx : funcidx)
  | RETURN_CALL_REF{typeuse : typeuse}(typeuse : typeuse)
  | RETURN_CALL_INDIRECT{tableidx : tableidx, typeuse : typeuse}(tableidx : tableidx, typeuse : typeuse)
  | CONST{numtype : numtype, num_ : num_(numtype)}(numtype : numtype, num_ : num_(numtype))
  | UNOP{numtype : numtype, unop_ : unop_(numtype)}(numtype : numtype, unop_ : unop_(numtype))
  | BINOP{numtype : numtype, binop_ : binop_(numtype)}(numtype : numtype, binop_ : binop_(numtype))
  | TESTOP{numtype : numtype, testop_ : testop_(numtype)}(numtype : numtype, testop_ : testop_(numtype))
  | RELOP{numtype : numtype, relop_ : relop_(numtype)}(numtype : numtype, relop_ : relop_(numtype))
  | CVTOP{numtype_1 : numtype, numtype_2 : numtype, cvtop_ : cvtop_(numtype_2, numtype_1), sx? : sx?}(numtype_1 : numtype, numtype_2 : numtype, cvtop_ : cvtop_(numtype_2, numtype_1), sx?{sx : sx} : sx?)
    -- if (numtype_1 =/= numtype_2)
  | VCONST{vectype : vectype, vec_ : vec_(vectype)}(vectype : vectype, vec_ : vec_(vectype))
  | VVUNOP{vectype : vectype, vvunop : vvunop}(vectype : vectype, vvunop : vvunop)
  | VVBINOP{vectype : vectype, vvbinop : vvbinop}(vectype : vectype, vvbinop : vvbinop)
  | VVTERNOP{vectype : vectype, vvternop : vvternop}(vectype : vectype, vvternop : vvternop)
  | VVTESTOP{vectype : vectype, vvtestop : vvtestop}(vectype : vectype, vvtestop : vvtestop)
  | VUNOP{shape : shape, vunop_ : vunop_(shape)}(shape : shape, vunop_ : vunop_(shape))
  | VBINOP{shape : shape, vbinop_ : vbinop_(shape)}(shape : shape, vbinop_ : vbinop_(shape))
  | VTESTOP{shape : shape, vtestop_ : vtestop_(shape)}(shape : shape, vtestop_ : vtestop_(shape))
  | VRELOP{shape : shape, vrelop_ : vrelop_(shape)}(shape : shape, vrelop_ : vrelop_(shape))
  | VSHIFTOP{ishape : ishape, vshiftop_ : vshiftop_(ishape)}(ishape : ishape, vshiftop_ : vshiftop_(ishape))
  | VBITMASK{ishape : ishape}(ishape : ishape)
  | VSWIZZLE{ishape : ishape}(ishape : ishape)
    -- if (ishape = `%X%`_ishape(I8_Jnn, `%`_dim(16)))
  | VSHUFFLE{ishape : ishape, laneidx* : laneidx*}(ishape : ishape, laneidx*{laneidx : laneidx} : laneidx*)
    -- if ((ishape = `%X%`_ishape(I8_Jnn, `%`_dim(16))) /\ (|laneidx*{laneidx : laneidx}| = 16))
  | VEXTUNOP{ishape_1 : ishape, ishape_2 : ishape, vextunop_ : vextunop_(ishape_1), sx : sx}(ishape_1 : ishape, ishape_2 : ishape, vextunop_ : vextunop_(ishape_1), sx : sx)
    -- if ($lsize($lanetype((ishape_1 : ishape <: shape))) = (2 * $lsize($lanetype((ishape_2 : ishape <: shape)))))
  | VEXTBINOP{ishape_1 : ishape, ishape_2 : ishape, vextbinop_ : vextbinop_(ishape_1), sx : sx}(ishape_1 : ishape, ishape_2 : ishape, vextbinop_ : vextbinop_(ishape_1), sx : sx)
    -- if ($lsize($lanetype((ishape_1 : ishape <: shape))) = (2 * $lsize($lanetype((ishape_2 : ishape <: shape)))))
  | VNARROW{ishape_1 : ishape, ishape_2 : ishape, sx : sx}(ishape_1 : ishape, ishape_2 : ishape, sx : sx)
    -- if (($lsize($lanetype((ishape_2 : ishape <: shape))) = (2 * $lsize($lanetype((ishape_1 : ishape <: shape))))) /\ ((2 * $lsize($lanetype((ishape_1 : ishape <: shape)))) <= 32))
  | VCVTOP{shape_1 : shape, shape_2 : shape, vcvtop_ : vcvtop_(shape_2, shape_1), half_? : half_(shape_2, shape_1)?, sx? : sx?, zero_? : zero_(shape_2, shape_1)?}(shape_1 : shape, shape_2 : shape, vcvtop_ : vcvtop_(shape_2, shape_1), half_?{half_ : half_(shape_2, shape_1)} : half_(shape_2, shape_1)?, sx?{sx : sx} : sx?, zero_?{zero_ : zero_(shape_2, shape_1)} : zero_(shape_2, shape_1)?)
    -- if ($lanetype(shape_1) =/= $lanetype(shape_2))
  | VSPLAT{shape : shape}(shape : shape)
  | VEXTRACT_LANE{shape : shape, sx? : sx?, laneidx : laneidx, numtype : numtype}(shape : shape, sx?{sx : sx} : sx?, laneidx : laneidx)
    -- if (($lanetype(shape) = (numtype : numtype <: lanetype)) <=> (sx?{sx : sx} = ?()))
  | VREPLACE_LANE{shape : shape, laneidx : laneidx}(shape : shape, laneidx : laneidx)
  | REF.NULL{heaptype : heaptype}(heaptype : heaptype)
  | REF.IS_NULL
  | REF.AS_NON_NULL
  | REF.EQ
  | REF.TEST{reftype : reftype}(reftype : reftype)
  | REF.CAST{reftype : reftype}(reftype : reftype)
  | REF.FUNC{funcidx : funcidx}(funcidx : funcidx)
  | REF.I31
  | I31.GET{sx : sx}(sx : sx)
  | STRUCT.NEW{typeidx : typeidx}(typeidx : typeidx)
  | STRUCT.NEW_DEFAULT{typeidx : typeidx}(typeidx : typeidx)
  | STRUCT.GET{sx? : sx?, typeidx : typeidx, u32 : u32}(sx?{sx : sx} : sx?, typeidx : typeidx, u32 : u32)
  | STRUCT.SET{typeidx : typeidx, u32 : u32}(typeidx : typeidx, u32 : u32)
  | ARRAY.NEW{typeidx : typeidx}(typeidx : typeidx)
  | ARRAY.NEW_DEFAULT{typeidx : typeidx}(typeidx : typeidx)
  | ARRAY.NEW_FIXED{typeidx : typeidx, u32 : u32}(typeidx : typeidx, u32 : u32)
  | ARRAY.NEW_DATA{typeidx : typeidx, dataidx : dataidx}(typeidx : typeidx, dataidx : dataidx)
  | ARRAY.NEW_ELEM{typeidx : typeidx, elemidx : elemidx}(typeidx : typeidx, elemidx : elemidx)
  | ARRAY.GET{sx? : sx?, typeidx : typeidx}(sx?{sx : sx} : sx?, typeidx : typeidx)
  | ARRAY.SET{typeidx : typeidx}(typeidx : typeidx)
  | ARRAY.LEN
  | ARRAY.FILL{typeidx : typeidx}(typeidx : typeidx)
  | ARRAY.COPY{typeidx : typeidx}(typeidx : typeidx, typeidx)
  | ARRAY.INIT_DATA{typeidx : typeidx, dataidx : dataidx}(typeidx : typeidx, dataidx : dataidx)
  | ARRAY.INIT_ELEM{typeidx : typeidx, elemidx : elemidx}(typeidx : typeidx, elemidx : elemidx)
  | EXTERN.CONVERT_ANY
  | ANY.CONVERT_EXTERN
  | LOCAL.GET{localidx : localidx}(localidx : localidx)
  | LOCAL.SET{localidx : localidx}(localidx : localidx)
  | LOCAL.TEE{localidx : localidx}(localidx : localidx)
  | GLOBAL.GET{globalidx : globalidx}(globalidx : globalidx)
  | GLOBAL.SET{globalidx : globalidx}(globalidx : globalidx)
  | TABLE.GET{tableidx : tableidx}(tableidx : tableidx)
  | TABLE.SET{tableidx : tableidx}(tableidx : tableidx)
  | TABLE.SIZE{tableidx : tableidx}(tableidx : tableidx)
  | TABLE.GROW{tableidx : tableidx}(tableidx : tableidx)
  | TABLE.FILL{tableidx : tableidx}(tableidx : tableidx)
  | TABLE.COPY{tableidx : tableidx}(tableidx : tableidx, tableidx)
  | TABLE.INIT{tableidx : tableidx, elemidx : elemidx}(tableidx : tableidx, elemidx : elemidx)
  | ELEM.DROP{elemidx : elemidx}(elemidx : elemidx)
  | LOAD{numtype : numtype, loadop_? : loadop_(numtype)?, memidx : memidx, memarg : memarg}(numtype : numtype, loadop_?{loadop_ : loadop_(numtype)} : loadop_(numtype)?, memidx : memidx, memarg : memarg)
  | STORE{numtype : numtype, sz? : sz?, memidx : memidx, memarg : memarg}(numtype : numtype, sz?{sz : sz} : sz?, memidx : memidx, memarg : memarg)
  | VLOAD{vectype : vectype, vloadop_? : vloadop_(vectype)?, memidx : memidx, memarg : memarg}(vectype : vectype, vloadop_?{vloadop_ : vloadop_(vectype)} : vloadop_(vectype)?, memidx : memidx, memarg : memarg)
  | VLOAD_LANE{vectype : vectype, sz : sz, memidx : memidx, memarg : memarg, laneidx : laneidx}(vectype : vectype, sz : sz, memidx : memidx, memarg : memarg, laneidx : laneidx)
  | VSTORE{vectype : vectype, memidx : memidx, memarg : memarg}(vectype : vectype, memidx : memidx, memarg : memarg)
  | VSTORE_LANE{vectype : vectype, sz : sz, memidx : memidx, memarg : memarg, laneidx : laneidx}(vectype : vectype, sz : sz, memidx : memidx, memarg : memarg, laneidx : laneidx)
  | MEMORY.SIZE{memidx : memidx}(memidx : memidx)
  | MEMORY.GROW{memidx : memidx}(memidx : memidx)
  | MEMORY.FILL{memidx : memidx}(memidx : memidx)
  | MEMORY.COPY{memidx : memidx}(memidx : memidx, memidx)
  | MEMORY.INIT{memidx : memidx, dataidx : dataidx}(memidx : memidx, dataidx : dataidx)
  | DATA.DROP{dataidx : dataidx}(dataidx : dataidx)
  | REF.I31_NUM{u31 : u31}(u31 : u31)
  | REF.STRUCT_ADDR{structaddr : structaddr}(structaddr : structaddr)
  | REF.ARRAY_ADDR{arrayaddr : arrayaddr}(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR{funcaddr : funcaddr}(funcaddr : funcaddr)
  | REF.HOST_ADDR{hostaddr : hostaddr}(hostaddr : hostaddr)
  | REF.EXTERN{addrref : addrref}(addrref : addrref)
  | `LABEL_%{%}%`{n : n, instr* : instr*}(n : n, instr*{instr : instr} : instr*, instr*)
  | `FRAME_%{%}%`{n : n, frame : frame, instr* : instr*}(n : n, frame : frame, instr*{instr : instr} : instr*)
  | TRAP
}

;; 1-syntax.watsup
syntax expr = instr*

;; 1-syntax.watsup
syntax elemmode =
  | ACTIVE{tableidx : tableidx, expr : expr}(tableidx : tableidx, expr : expr)
  | PASSIVE
  | DECLARE

;; 1-syntax.watsup
syntax datamode =
  | ACTIVE{memidx : memidx, expr : expr}(memidx : memidx, expr : expr)
  | PASSIVE

;; 1-syntax.watsup
syntax type =
  | TYPE{rectype : rectype}(rectype : rectype)

;; 1-syntax.watsup
syntax local =
  | LOCAL{valtype : valtype}(valtype : valtype)

;; 1-syntax.watsup
syntax func =
  | FUNC{typeidx : typeidx, local* : local*, expr : expr}(typeidx : typeidx, local*{local : local} : local*, expr : expr)

;; 1-syntax.watsup
syntax global =
  | GLOBAL{globaltype : globaltype, expr : expr}(globaltype : globaltype, expr : expr)

;; 1-syntax.watsup
syntax table =
  | TABLE{tabletype : tabletype, expr : expr}(tabletype : tabletype, expr : expr)

;; 1-syntax.watsup
syntax mem =
  | MEMORY{memtype : memtype}(memtype : memtype)

;; 1-syntax.watsup
syntax elem =
  | ELEM{reftype : reftype, expr* : expr*, elemmode : elemmode}(reftype : reftype, expr*{expr : expr} : expr*, elemmode : elemmode)

;; 1-syntax.watsup
syntax data =
  | DATA{byte* : byte*, datamode : datamode}(byte*{byte : byte} : byte*, datamode : datamode)

;; 1-syntax.watsup
syntax start =
  | START{funcidx : funcidx}(funcidx : funcidx)

;; 1-syntax.watsup
syntax externidx =
  | FUNC{funcidx : funcidx}(funcidx : funcidx)
  | GLOBAL{globalidx : globalidx}(globalidx : globalidx)
  | TABLE{tableidx : tableidx}(tableidx : tableidx)
  | MEM{memidx : memidx}(memidx : memidx)

;; 1-syntax.watsup
syntax export =
  | EXPORT{name : name, externidx : externidx}(name : name, externidx : externidx)

;; 1-syntax.watsup
syntax import =
  | IMPORT{name : name, externtype : externtype}(name : name, name, externtype : externtype)

;; 1-syntax.watsup
syntax module =
  | MODULE{type* : type*, import* : import*, func* : func*, global* : global*, table* : table*, mem* : mem*, elem* : elem*, data* : data*, start* : start*, export* : export*}(type*{type : type} : type*, import*{import : import} : import*, func*{func : func} : func*, global*{global : global} : global*, table*{table : table} : table*, mem*{mem : mem} : mem*, elem*{elem : elem} : elem*, data*{data : data} : data*, start*{start : start} : start*, export*{export : export} : export*)

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:8.1-8.33
def $setminus1(idx : idx, idx*) : idx*
  ;; 2-syntax-aux.watsup:13.1-13.27
  def $setminus1{x : idx}(x, []) = [x]
  ;; 2-syntax-aux.watsup:14.1-14.61
  def $setminus1{x : idx, y_1 : idx, y* : idx*}(x, [y_1] :: y*{y : idx}) = []
    -- if (x = y_1)
  ;; 2-syntax-aux.watsup:15.1-15.60
  def $setminus1{x : idx, y_1 : idx, y* : idx*}(x, [y_1] :: y*{y : idx}) = $setminus1(x, y*{y : idx})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:7.1-7.49
def $setminus(idx*, idx*) : idx*
  ;; 2-syntax-aux.watsup:10.1-10.29
  def $setminus{y* : idx*}([], y*{y : idx}) = []
  ;; 2-syntax-aux.watsup:11.1-11.66
  def $setminus{x_1 : idx, x* : idx*, y* : idx*}([x_1] :: x*{x : idx}, y*{y : idx}) = $setminus1(x_1, y*{y : idx}) :: $setminus(x*{x : idx}, y*{y : idx})
}

;; 2-syntax-aux.watsup
def $IN(N : N) : numtype
  ;; 2-syntax-aux.watsup
  def $IN(32) = I32_numtype
  ;; 2-syntax-aux.watsup
  def $IN(64) = I64_numtype

;; 2-syntax-aux.watsup
def $FN(N : N) : numtype
  ;; 2-syntax-aux.watsup
  def $FN(32) = F32_numtype
  ;; 2-syntax-aux.watsup
  def $FN(64) = F64_numtype

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
def $cunpack(storagetype : storagetype) : consttype
  ;; 2-syntax-aux.watsup
  def $cunpack{consttype : consttype}((consttype : consttype <: storagetype)) = consttype
  ;; 2-syntax-aux.watsup
  def $cunpack{packtype : packtype}((packtype : packtype <: storagetype)) = I32_consttype
  ;; 2-syntax-aux.watsup
  def $cunpack{lanetype : lanetype}((lanetype : lanetype <: storagetype)) = ($lunpack(lanetype) : numtype <: consttype)

;; 2-syntax-aux.watsup
def $sx(storagetype : storagetype) : sx?
  ;; 2-syntax-aux.watsup
  def $sx{consttype : consttype}((consttype : consttype <: storagetype)) = ?()
  ;; 2-syntax-aux.watsup
  def $sx{packtype : packtype}((packtype : packtype <: storagetype)) = ?(S_sx)

;; 2-syntax-aux.watsup
def $const(consttype : consttype, lit_ : lit_((consttype : consttype <: storagetype))) : instr
  ;; 2-syntax-aux.watsup
  def $const{numtype : numtype, c : lit_((numtype : numtype <: storagetype))}((numtype : numtype <: consttype), c) = CONST_instr(numtype, c)
  ;; 2-syntax-aux.watsup
  def $const{vectype : vectype, c : lit_((vectype : vectype <: storagetype))}((vectype : vectype <: consttype), c) = VCONST_instr(vectype, c)

;; 2-syntax-aux.watsup
def $unpackshape(shape : shape) : numtype
  ;; 2-syntax-aux.watsup
  def $unpackshape{Lnn : Lnn, N : N}(`%X%`_shape(Lnn, `%`_dim(N))) = $lunpack(Lnn)

;; 2-syntax-aux.watsup
def $diffrt(reftype : reftype, reftype : reftype) : reftype
  ;; 2-syntax-aux.watsup
  def $diffrt{nul1 : nul1, ht_1 : heaptype, ht_2 : heaptype}(REF_reftype(nul1, ht_1), REF_reftype(`NULL%?`_nul(?(())), ht_2)) = REF_reftype(`NULL%?`_nul(?()), ht_1)
  ;; 2-syntax-aux.watsup
  def $diffrt{nul1 : nul1, ht_1 : heaptype, ht_2 : heaptype}(REF_reftype(nul1, ht_1), REF_reftype(`NULL%?`_nul(?()), ht_2)) = REF_reftype(nul1, ht_1)

;; 2-syntax-aux.watsup
syntax typevar =
  | _IDX{typeidx : typeidx}(typeidx : typeidx)
  | REC(nat)

;; 2-syntax-aux.watsup
def $idx(typeidx : typeidx) : typevar
  ;; 2-syntax-aux.watsup
  def $idx{x : idx}(x) = _IDX_typevar(x)

;; 2-syntax-aux.watsup
syntax free =
{
  TYPES{typeidx* : typeidx*} typeidx*,
  FUNCS{funcidx* : funcidx*} funcidx*,
  GLOBALS{globalidx* : globalidx*} globalidx*,
  TABLES{tableidx* : tableidx*} tableidx*,
  MEMS{memidx* : memidx*} memidx*,
  ELEMS{elemidx* : elemidx*} elemidx*,
  DATAS{dataidx* : dataidx*} dataidx*,
  LOCALS{localidx* : localidx*} localidx*,
  LABELS{labelidx* : labelidx*} labelidx*
}

;; 2-syntax-aux.watsup
def $free_opt(free?) : free
  ;; 2-syntax-aux.watsup
  def $free_opt(?()) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup
  def $free_opt{free : free}(?(free)) = free

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:168.1-168.29
def $free_list(free*) : free
  ;; 2-syntax-aux.watsup:169.1-169.25
  def $free_list([]) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:170.1-170.57
  def $free_list{free : free, free'* : free*}([free] :: free'*{free' : free}) = free ++ $free_list(free'*{free' : free})
}

;; 2-syntax-aux.watsup
def $free_typeidx(typeidx : typeidx) : free
  ;; 2-syntax-aux.watsup
  def $free_typeidx{typeidx : typeidx}(typeidx) = {TYPES [typeidx], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_funcidx(funcidx : funcidx) : free
  ;; 2-syntax-aux.watsup
  def $free_funcidx{funcidx : funcidx}(funcidx) = {TYPES [], FUNCS [funcidx], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_globalidx(globalidx : globalidx) : free
  ;; 2-syntax-aux.watsup
  def $free_globalidx{globalidx : globalidx}(globalidx) = {TYPES [], FUNCS [], GLOBALS [globalidx], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_tableidx(tableidx : tableidx) : free
  ;; 2-syntax-aux.watsup
  def $free_tableidx{tableidx : tableidx}(tableidx) = {TYPES [], FUNCS [], GLOBALS [], TABLES [tableidx], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_memidx(memidx : memidx) : free
  ;; 2-syntax-aux.watsup
  def $free_memidx{memidx : memidx}(memidx) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [memidx], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_elemidx(elemidx : elemidx) : free
  ;; 2-syntax-aux.watsup
  def $free_elemidx{elemidx : elemidx}(elemidx) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [elemidx], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_dataidx(dataidx : dataidx) : free
  ;; 2-syntax-aux.watsup
  def $free_dataidx{dataidx : dataidx}(dataidx) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [dataidx], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_localidx(localidx : localidx) : free
  ;; 2-syntax-aux.watsup
  def $free_localidx{localidx : localidx}(localidx) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [localidx], LABELS []}

;; 2-syntax-aux.watsup
def $free_labelidx(labelidx : labelidx) : free
  ;; 2-syntax-aux.watsup
  def $free_labelidx{labelidx : labelidx}(labelidx) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [labelidx]}

;; 2-syntax-aux.watsup
def $free_externidx(externidx : externidx) : free
  ;; 2-syntax-aux.watsup
  def $free_externidx{funcidx : funcidx}(FUNC_externidx(funcidx)) = $free_funcidx(funcidx)
  ;; 2-syntax-aux.watsup
  def $free_externidx{globalidx : globalidx}(GLOBAL_externidx(globalidx)) = $free_globalidx(globalidx)
  ;; 2-syntax-aux.watsup
  def $free_externidx{tableidx : tableidx}(TABLE_externidx(tableidx)) = $free_tableidx(tableidx)
  ;; 2-syntax-aux.watsup
  def $free_externidx{memidx : memidx}(MEM_externidx(memidx)) = $free_memidx(memidx)

;; 2-syntax-aux.watsup
def $free_numtype(numtype : numtype) : free
  ;; 2-syntax-aux.watsup
  def $free_numtype{numtype : numtype}(numtype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_packtype(packtype : packtype) : free
  ;; 2-syntax-aux.watsup
  def $free_packtype{packtype : packtype}(packtype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_lanetype(lanetype : lanetype) : free
  ;; 2-syntax-aux.watsup
  def $free_lanetype{numtype : numtype}((numtype : numtype <: lanetype)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup
  def $free_lanetype{packtype : packtype}((packtype : packtype <: lanetype)) = $free_packtype(packtype)

;; 2-syntax-aux.watsup
def $free_vectype(vectype : vectype) : free
  ;; 2-syntax-aux.watsup
  def $free_vectype{vectype : vectype}(vectype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_consttype(consttype : consttype) : free
  ;; 2-syntax-aux.watsup
  def $free_consttype{numtype : numtype}((numtype : numtype <: consttype)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup
  def $free_consttype{vectype : vectype}((vectype : vectype <: consttype)) = $free_vectype(vectype)

;; 2-syntax-aux.watsup
def $free_absheaptype(absheaptype : absheaptype) : free
  ;; 2-syntax-aux.watsup
  def $free_absheaptype{absheaptype : absheaptype}(absheaptype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:227.1-227.34
def $free_rectype(rectype : rectype) : free
  ;; 2-syntax-aux.watsup:280.1-280.70
  def $free_rectype{subtype* : subtype*}(REC_rectype(`%`_list(subtype*{subtype : subtype}))) = $free_list($free_subtype(subtype)*{subtype : subtype})

;; 2-syntax-aux.watsup:229.1-229.34
def $free_deftype(deftype : deftype) : free
  ;; 2-syntax-aux.watsup:230.1-230.58
  def $free_deftype{rectype : rectype, n : n}(DEF_deftype(rectype, n)) = $free_rectype(rectype)

;; 2-syntax-aux.watsup:232.1-232.34
def $free_typeuse(typeuse : typeuse) : free
  ;; 2-syntax-aux.watsup:233.1-233.57
  def $free_typeuse{typeidx : typeidx}(_IDX_typeuse(typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:234.1-234.30
  def $free_typeuse{n : n}(REC_typeuse(n)) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:235.1-235.52
  def $free_typeuse{deftype : deftype}((deftype : deftype <: typeuse)) = $free_deftype(deftype)

;; 2-syntax-aux.watsup:237.1-237.36
def $free_heaptype(heaptype : heaptype) : free
  ;; 2-syntax-aux.watsup:238.1-238.65
  def $free_heaptype{absheaptype : absheaptype}((absheaptype : absheaptype <: heaptype)) = $free_absheaptype(absheaptype)
  ;; 2-syntax-aux.watsup:239.1-239.53
  def $free_heaptype{typeuse : typeuse}((typeuse : typeuse <: heaptype)) = $free_typeuse(typeuse)

;; 2-syntax-aux.watsup:241.1-241.34
def $free_reftype(reftype : reftype) : free
  ;; 2-syntax-aux.watsup:242.1-242.63
  def $free_reftype{nul : nul, heaptype : heaptype}(REF_reftype(nul, heaptype)) = $free_heaptype(heaptype)

;; 2-syntax-aux.watsup:244.1-244.34
def $free_valtype(valtype : valtype) : free
  ;; 2-syntax-aux.watsup:245.1-245.52
  def $free_valtype{numtype : numtype}((numtype : numtype <: valtype)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup:246.1-246.52
  def $free_valtype{vectype : vectype}((vectype : vectype <: valtype)) = $free_vectype(vectype)
  ;; 2-syntax-aux.watsup:247.1-247.52
  def $free_valtype{reftype : reftype}((reftype : reftype <: valtype)) = $free_reftype(reftype)
  ;; 2-syntax-aux.watsup:248.1-248.28
  def $free_valtype(BOT_valtype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup:250.1-250.40
def $free_resulttype(resulttype : resulttype) : free
  ;; 2-syntax-aux.watsup:251.1-251.69
  def $free_resulttype{valtype* : valtype*}(`%`_resulttype(valtype*{valtype : valtype})) = $free_list($free_valtype(valtype)*{valtype : valtype})

;; 2-syntax-aux.watsup:253.1-253.42
def $free_storagetype(storagetype : storagetype) : free
  ;; 2-syntax-aux.watsup:254.1-254.56
  def $free_storagetype{valtype : valtype}((valtype : valtype <: storagetype)) = $free_valtype(valtype)
  ;; 2-syntax-aux.watsup:255.1-255.59
  def $free_storagetype{packtype : packtype}((packtype : packtype <: storagetype)) = $free_packtype(packtype)

;; 2-syntax-aux.watsup:257.1-257.38
def $free_fieldtype(fieldtype : fieldtype) : free
  ;; 2-syntax-aux.watsup:258.1-258.70
  def $free_fieldtype{mut : mut, storagetype : storagetype}(`%%`_fieldtype(mut, storagetype)) = $free_storagetype(storagetype)

;; 2-syntax-aux.watsup:260.1-260.36
def $free_functype(functype : functype) : free
  ;; 2-syntax-aux.watsup:261.1-262.67
  def $free_functype{resulttype_1 : resulttype, resulttype_2 : resulttype}(`%->%`_functype(resulttype_1, resulttype_2)) = $free_resulttype(resulttype_1) ++ $free_resulttype(resulttype_2)

;; 2-syntax-aux.watsup:264.1-264.40
def $free_structtype(structtype : structtype) : free
  ;; 2-syntax-aux.watsup:265.1-265.75
  def $free_structtype{fieldtype* : fieldtype*}(`%`_structtype(fieldtype*{fieldtype : fieldtype})) = $free_list($free_fieldtype(fieldtype)*{fieldtype : fieldtype})

;; 2-syntax-aux.watsup:267.1-267.38
def $free_arraytype(arraytype : arraytype) : free
  ;; 2-syntax-aux.watsup:268.1-268.60
  def $free_arraytype{fieldtype : fieldtype}(fieldtype) = $free_fieldtype(fieldtype)

;; 2-syntax-aux.watsup:270.1-270.36
def $free_comptype(comptype : comptype) : free
  ;; 2-syntax-aux.watsup:271.1-271.69
  def $free_comptype{structtype : structtype}(STRUCT_comptype(structtype)) = $free_structtype(structtype)
  ;; 2-syntax-aux.watsup:272.1-272.65
  def $free_comptype{arraytype : arraytype}(ARRAY_comptype(arraytype)) = $free_arraytype(arraytype)
  ;; 2-syntax-aux.watsup:273.1-273.61
  def $free_comptype{functype : functype}(FUNC_comptype(functype)) = $free_functype(functype)

;; 2-syntax-aux.watsup:275.1-275.34
def $free_subtype(subtype : subtype) : free
  ;; 2-syntax-aux.watsup:276.1-277.66
  def $free_subtype{fin : fin, typeuse* : typeuse*, comptype : comptype}(SUB_subtype(fin, typeuse*{typeuse : typeuse}, comptype)) = $free_list($free_typeuse(typeuse)*{typeuse : typeuse}) ++ $free_comptype(comptype)
}

;; 2-syntax-aux.watsup
def $free_globaltype(globaltype : globaltype) : free
  ;; 2-syntax-aux.watsup
  def $free_globaltype{mut : mut, valtype : valtype}(`%%`_globaltype(mut, valtype)) = $free_valtype(valtype)

;; 2-syntax-aux.watsup
def $free_tabletype(tabletype : tabletype) : free
  ;; 2-syntax-aux.watsup
  def $free_tabletype{limits : limits, reftype : reftype}(`%%`_tabletype(limits, reftype)) = $free_reftype(reftype)

;; 2-syntax-aux.watsup
def $free_memtype(memtype : memtype) : free
  ;; 2-syntax-aux.watsup
  def $free_memtype{limits : limits}(`%PAGE`_memtype(limits)) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_elemtype(elemtype : elemtype) : free
  ;; 2-syntax-aux.watsup
  def $free_elemtype{reftype : reftype}(reftype) = $free_reftype(reftype)

;; 2-syntax-aux.watsup
def $free_datatype(datatype : datatype) : free
  ;; 2-syntax-aux.watsup
  def $free_datatype(OK_datatype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_externtype(externtype : externtype) : free
  ;; 2-syntax-aux.watsup
  def $free_externtype{typeuse : typeuse}(FUNC_externtype(typeuse)) = $free_typeuse(typeuse)
  ;; 2-syntax-aux.watsup
  def $free_externtype{globaltype : globaltype}(GLOBAL_externtype(globaltype)) = $free_globaltype(globaltype)
  ;; 2-syntax-aux.watsup
  def $free_externtype{tabletype : tabletype}(TABLE_externtype(tabletype)) = $free_tabletype(tabletype)
  ;; 2-syntax-aux.watsup
  def $free_externtype{memtype : memtype}(MEM_externtype(memtype)) = $free_memtype(memtype)

;; 2-syntax-aux.watsup
def $free_moduletype(moduletype : moduletype) : free
  ;; 2-syntax-aux.watsup
  def $free_moduletype{externtype_1* : externtype*, externtype_2* : externtype*}(`%->%`_moduletype(externtype_1*{externtype_1 : externtype}, externtype_2*{externtype_2 : externtype})) = $free_list($free_externtype(externtype_1)*{externtype_1 : externtype}) ++ $free_list($free_externtype(externtype_2)*{externtype_2 : externtype})

;; 2-syntax-aux.watsup
def $free_blocktype(blocktype : blocktype) : free
  ;; 2-syntax-aux.watsup
  def $free_blocktype{valtype? : valtype?}(_RESULT_blocktype(valtype?{valtype : valtype})) = $free_opt($free_valtype(valtype)?{valtype : valtype})
  ;; 2-syntax-aux.watsup
  def $free_blocktype{funcidx : funcidx}(_IDX_blocktype(funcidx)) = $free_funcidx(funcidx)

;; 2-syntax-aux.watsup
def $free_shape(shape : shape) : free
  ;; 2-syntax-aux.watsup
  def $free_shape{lanetype : lanetype, dim : dim}(`%X%`_shape(lanetype, dim)) = $free_lanetype(lanetype)

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:459.1-459.44
def $shift_labelidxs(labelidx*) : labelidx*
  ;; 2-syntax-aux.watsup:460.1-460.32
  def $shift_labelidxs([]) = []
  ;; 2-syntax-aux.watsup:461.1-461.66
  def $shift_labelidxs{labelidx'* : labelidx*}([`%`_uN(0)] :: labelidx'*{labelidx' : labelidx}) = $shift_labelidxs(labelidx'*{labelidx' : labelidx})
  ;; 2-syntax-aux.watsup:462.1-462.91
  def $shift_labelidxs{labelidx : labelidx, labelidx'* : labelidx*}([labelidx] :: labelidx'*{labelidx' : labelidx}) = [`%`_uN((labelidx!`%`_labelidx.0 - 1))] :: $shift_labelidxs(labelidx'*{labelidx' : labelidx})
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:315.1-315.31
def $free_block(instr*) : free
  ;; 2-syntax-aux.watsup:465.1-466.47
  def $free_block{instr* : instr*, free : free}(instr*{instr : instr}) = free[LABELS_free = $shift_labelidxs(free.LABELS_free)]
    -- if (free = $free_list($free_instr(instr)*{instr : instr}))

;; 2-syntax-aux.watsup:317.1-317.30
def $free_instr(instr : instr) : free
  ;; 2-syntax-aux.watsup:318.1-318.26
  def $free_instr(NOP_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:319.1-319.34
  def $free_instr(UNREACHABLE_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:320.1-320.27
  def $free_instr(DROP_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:321.1-321.86
  def $free_instr{valtype*? : valtype*?}(`SELECT()%?`_instr(valtype*{valtype : valtype}?{valtype : valtype})) = $free_opt($free_list($free_valtype(valtype)*{valtype : valtype})?{valtype : valtype})
  ;; 2-syntax-aux.watsup:323.1-323.92
  def $free_instr{blocktype : blocktype, instr* : instr*}(BLOCK_instr(blocktype, instr*{instr : instr})) = $free_blocktype(blocktype) ++ $free_block(instr*{instr : instr})
  ;; 2-syntax-aux.watsup:324.1-324.91
  def $free_instr{blocktype : blocktype, instr* : instr*}(LOOP_instr(blocktype, instr*{instr : instr})) = $free_blocktype(blocktype) ++ $free_block(instr*{instr : instr})
  ;; 2-syntax-aux.watsup:325.1-326.79
  def $free_instr{blocktype : blocktype, instr_1* : instr*, instr_2* : instr*}(`IF%%ELSE%`_instr(blocktype, instr_1*{instr_1 : instr}, instr_2*{instr_2 : instr})) = $free_blocktype(blocktype) ++ $free_block(instr_1*{instr_1 : instr}) ++ $free_block(instr_2*{instr_2 : instr})
  ;; 2-syntax-aux.watsup:328.1-328.56
  def $free_instr{labelidx : labelidx}(BR_instr(labelidx)) = $free_labelidx(labelidx)
  ;; 2-syntax-aux.watsup:329.1-329.59
  def $free_instr{labelidx : labelidx}(BR_IF_instr(labelidx)) = $free_labelidx(labelidx)
  ;; 2-syntax-aux.watsup:330.1-331.68
  def $free_instr{labelidx : labelidx, labelidx' : labelidx}(BR_TABLE_instr(labelidx*{}, labelidx')) = $free_list($free_labelidx(labelidx)*{}) ++ $free_labelidx(labelidx)
  ;; 2-syntax-aux.watsup:332.1-332.64
  def $free_instr{labelidx : labelidx}(BR_ON_NULL_instr(labelidx)) = $free_labelidx(labelidx)
  ;; 2-syntax-aux.watsup:333.1-333.68
  def $free_instr{labelidx : labelidx}(BR_ON_NON_NULL_instr(labelidx)) = $free_labelidx(labelidx)
  ;; 2-syntax-aux.watsup:334.1-335.83
  def $free_instr{labelidx : labelidx, reftype_1 : reftype, reftype_2 : reftype}(BR_ON_CAST_instr(labelidx, reftype_1, reftype_2)) = $free_labelidx(labelidx) ++ $free_reftype(reftype_1) ++ $free_reftype(reftype_2)
  ;; 2-syntax-aux.watsup:336.1-337.83
  def $free_instr{labelidx : labelidx, reftype_1 : reftype, reftype_2 : reftype}(BR_ON_CAST_FAIL_instr(labelidx, reftype_1, reftype_2)) = $free_labelidx(labelidx) ++ $free_reftype(reftype_1) ++ $free_reftype(reftype_2)
  ;; 2-syntax-aux.watsup:339.1-339.55
  def $free_instr{funcidx : funcidx}(CALL_instr(funcidx)) = $free_funcidx(funcidx)
  ;; 2-syntax-aux.watsup:340.1-340.59
  def $free_instr{typeuse : typeuse}(CALL_REF_instr(typeuse)) = $free_typeuse(typeuse)
  ;; 2-syntax-aux.watsup:341.1-342.53
  def $free_instr{tableidx : tableidx, typeuse : typeuse}(CALL_INDIRECT_instr(tableidx, typeuse)) = $free_tableidx(tableidx) ++ $free_typeuse(typeuse)
  ;; 2-syntax-aux.watsup:343.1-343.29
  def $free_instr(RETURN_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:344.1-344.62
  def $free_instr{funcidx : funcidx}(RETURN_CALL_instr(funcidx)) = $free_funcidx(funcidx)
  ;; 2-syntax-aux.watsup:345.1-345.66
  def $free_instr{typeuse : typeuse}(RETURN_CALL_REF_instr(typeuse)) = $free_typeuse(typeuse)
  ;; 2-syntax-aux.watsup:346.1-347.53
  def $free_instr{tableidx : tableidx, typeuse : typeuse}(RETURN_CALL_INDIRECT_instr(tableidx, typeuse)) = $free_tableidx(tableidx) ++ $free_typeuse(typeuse)
  ;; 2-syntax-aux.watsup:349.1-349.63
  def $free_instr{numtype : numtype, numlit : num_(numtype)}(CONST_instr(numtype, numlit)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup:350.1-350.60
  def $free_instr{numtype : numtype, unop : unop_(numtype)}(UNOP_instr(numtype, unop)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup:351.1-351.62
  def $free_instr{numtype : numtype, binop : binop_(numtype)}(BINOP_instr(numtype, binop)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup:352.1-352.64
  def $free_instr{numtype : numtype, testop : testop_(numtype)}(TESTOP_instr(numtype, testop)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup:353.1-353.62
  def $free_instr{numtype : numtype, relop : relop_(numtype)}(RELOP_instr(numtype, relop)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup:354.1-355.55
  def $free_instr{numtype_1 : numtype, numtype_2 : numtype, cvtop : cvtop_(numtype_2, numtype_1), sx? : sx?}(CVTOP_instr(numtype_1, numtype_2, cvtop, sx?{sx : sx})) = $free_numtype(numtype_1) ++ $free_numtype(numtype_2)
  ;; 2-syntax-aux.watsup:357.1-357.64
  def $free_instr{vectype : vectype, veclit : vec_(vectype)}(VCONST_instr(vectype, veclit)) = $free_vectype(vectype)
  ;; 2-syntax-aux.watsup:358.1-358.64
  def $free_instr{vectype : vectype, vvunop : vvunop}(VVUNOP_instr(vectype, vvunop)) = $free_vectype(vectype)
  ;; 2-syntax-aux.watsup:359.1-359.66
  def $free_instr{vectype : vectype, vvbinop : vvbinop}(VVBINOP_instr(vectype, vvbinop)) = $free_vectype(vectype)
  ;; 2-syntax-aux.watsup:360.1-360.68
  def $free_instr{vectype : vectype, vvternop : vvternop}(VVTERNOP_instr(vectype, vvternop)) = $free_vectype(vectype)
  ;; 2-syntax-aux.watsup:361.1-361.68
  def $free_instr{vectype : vectype, vvtestop : vvtestop}(VVTESTOP_instr(vectype, vvtestop)) = $free_vectype(vectype)
  ;; 2-syntax-aux.watsup:362.1-362.56
  def $free_instr{shape : shape, vunop : vunop_(shape)}(VUNOP_instr(shape, vunop)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:363.1-363.58
  def $free_instr{shape : shape, vbinop : vbinop_(shape)}(VBINOP_instr(shape, vbinop)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:364.1-364.60
  def $free_instr{shape : shape, vtestop : vtestop_(shape)}(VTESTOP_instr(shape, vtestop)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:365.1-365.58
  def $free_instr{shape : shape, vrelop : vrelop_(shape)}(VRELOP_instr(shape, vrelop)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:366.1-366.64
  def $free_instr{ishape : ishape, vshiftop : vshiftop_(ishape)}(VSHIFTOP_instr(ishape, vshiftop)) = $free_shape((ishape : ishape <: shape))
  ;; 2-syntax-aux.watsup:367.1-367.55
  def $free_instr{ishape : ishape}(VBITMASK_instr(ishape)) = $free_shape((ishape : ishape <: shape))
  ;; 2-syntax-aux.watsup:368.1-368.55
  def $free_instr{ishape : ishape}(VSWIZZLE_instr(ishape)) = $free_shape((ishape : ishape <: shape))
  ;; 2-syntax-aux.watsup:369.1-369.64
  def $free_instr{ishape : ishape, laneidx* : laneidx*}(VSHUFFLE_instr(ishape, laneidx*{laneidx : laneidx})) = $free_shape((ishape : ishape <: shape))
  ;; 2-syntax-aux.watsup:370.1-371.49
  def $free_instr{ishape_1 : ishape, ishape_2 : ishape, vextunop : vextunop_(ishape_1), sx : sx}(VEXTUNOP_instr(ishape_1, ishape_2, vextunop, sx)) = $free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape))
  ;; 2-syntax-aux.watsup:372.1-373.49
  def $free_instr{ishape_1 : ishape, ishape_2 : ishape, vextbinop : vextbinop_(ishape_1), sx : sx}(VEXTBINOP_instr(ishape_1, ishape_2, vextbinop, sx)) = $free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape))
  ;; 2-syntax-aux.watsup:374.1-375.49
  def $free_instr{ishape_1 : ishape, ishape_2 : ishape, sx : sx}(VNARROW_instr(ishape_1, ishape_2, sx)) = $free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape))
  ;; 2-syntax-aux.watsup:376.1-377.47
  def $free_instr{shape_1 : shape, shape_2 : shape, vcvtop : vcvtop_(shape_2, shape_1), half? : half?, sx? : sx?, zero? : zero_(shape_2, shape_1)?}(VCVTOP_instr(shape_1, shape_2, vcvtop, `%`_half_(half)?{half : half}, sx?{sx : sx}, zero?{zero : zero_(shape_2, shape_1)})) = $free_shape(shape_1) ++ $free_shape(shape_2)
  ;; 2-syntax-aux.watsup:378.1-378.51
  def $free_instr{shape : shape}(VSPLAT_instr(shape)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:379.1-379.70
  def $free_instr{shape : shape, sx? : sx?, laneidx : laneidx}(VEXTRACT_LANE_instr(shape, sx?{sx : sx}, laneidx)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:380.1-380.66
  def $free_instr{shape : shape, laneidx : laneidx}(VREPLACE_LANE_instr(shape, laneidx)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:382.1-382.62
  def $free_instr{heaptype : heaptype}(REF.NULL_instr(heaptype)) = $free_heaptype(heaptype)
  ;; 2-syntax-aux.watsup:383.1-383.34
  def $free_instr(REF.IS_NULL_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:384.1-384.38
  def $free_instr(REF.AS_NON_NULL_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:385.1-385.29
  def $free_instr(REF.EQ_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:386.1-386.59
  def $free_instr{reftype : reftype}(REF.TEST_instr(reftype)) = $free_reftype(reftype)
  ;; 2-syntax-aux.watsup:387.1-387.59
  def $free_instr{reftype : reftype}(REF.CAST_instr(reftype)) = $free_reftype(reftype)
  ;; 2-syntax-aux.watsup:388.1-388.59
  def $free_instr{funcidx : funcidx}(REF.FUNC_instr(funcidx)) = $free_funcidx(funcidx)
  ;; 2-syntax-aux.watsup:389.1-389.30
  def $free_instr(REF.I31_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:391.1-391.33
  def $free_instr{sx : sx}(I31.GET_instr(sx)) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:393.1-393.41
  def $free_instr{typeidx : typeidx}(STRUCT.NEW_instr(typeidx)) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:394.1-394.69
  def $free_instr{typeidx : typeidx}(STRUCT.NEW_DEFAULT_instr(typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:395.1-395.69
  def $free_instr{sx? : sx?, typeidx : typeidx, u32 : u32}(STRUCT.GET_instr(sx?{sx : sx}, typeidx, u32)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:396.1-396.65
  def $free_instr{typeidx : typeidx, u32 : u32}(STRUCT.SET_instr(typeidx, u32)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:398.1-398.60
  def $free_instr{typeidx : typeidx}(ARRAY.NEW_instr(typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:399.1-399.68
  def $free_instr{typeidx : typeidx}(ARRAY.NEW_DEFAULT_instr(typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:400.1-400.70
  def $free_instr{typeidx : typeidx, u32 : u32}(ARRAY.NEW_FIXED_instr(typeidx, u32)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:401.1-402.51
  def $free_instr{typeidx : typeidx, dataidx : dataidx}(ARRAY.NEW_DATA_instr(typeidx, dataidx)) = $free_typeidx(typeidx) ++ $free_dataidx(dataidx)
  ;; 2-syntax-aux.watsup:403.1-404.51
  def $free_instr{typeidx : typeidx, elemidx : elemidx}(ARRAY.NEW_ELEM_instr(typeidx, elemidx)) = $free_typeidx(typeidx) ++ $free_elemidx(elemidx)
  ;; 2-syntax-aux.watsup:405.1-405.64
  def $free_instr{sx? : sx?, typeidx : typeidx}(ARRAY.GET_instr(sx?{sx : sx}, typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:406.1-406.60
  def $free_instr{typeidx : typeidx}(ARRAY.SET_instr(typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:407.1-407.32
  def $free_instr(ARRAY.LEN_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:408.1-408.61
  def $free_instr{typeidx : typeidx}(ARRAY.FILL_instr(typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:409.1-410.55
  def $free_instr{typeidx_1 : typeidx, typeidx_2 : typeidx}(ARRAY.COPY_instr(typeidx_1, typeidx_2)) = $free_typeidx(typeidx_1) ++ $free_typeidx(typeidx_2)
  ;; 2-syntax-aux.watsup:411.1-412.51
  def $free_instr{typeidx : typeidx, dataidx : dataidx}(ARRAY.INIT_DATA_instr(typeidx, dataidx)) = $free_typeidx(typeidx) ++ $free_dataidx(dataidx)
  ;; 2-syntax-aux.watsup:413.1-414.51
  def $free_instr{typeidx : typeidx, elemidx : elemidx}(ARRAY.INIT_ELEM_instr(typeidx, elemidx)) = $free_typeidx(typeidx) ++ $free_elemidx(elemidx)
  ;; 2-syntax-aux.watsup:416.1-416.41
  def $free_instr(EXTERN.CONVERT_ANY_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:417.1-417.41
  def $free_instr(ANY.CONVERT_EXTERN_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:419.1-419.63
  def $free_instr{localidx : localidx}(LOCAL.GET_instr(localidx)) = $free_localidx(localidx)
  ;; 2-syntax-aux.watsup:420.1-420.63
  def $free_instr{localidx : localidx}(LOCAL.SET_instr(localidx)) = $free_localidx(localidx)
  ;; 2-syntax-aux.watsup:421.1-421.63
  def $free_instr{localidx : localidx}(LOCAL.TEE_instr(localidx)) = $free_localidx(localidx)
  ;; 2-syntax-aux.watsup:423.1-423.67
  def $free_instr{globalidx : globalidx}(GLOBAL.GET_instr(globalidx)) = $free_globalidx(globalidx)
  ;; 2-syntax-aux.watsup:424.1-424.67
  def $free_instr{globalidx : globalidx}(GLOBAL.SET_instr(globalidx)) = $free_globalidx(globalidx)
  ;; 2-syntax-aux.watsup:426.1-426.63
  def $free_instr{tableidx : tableidx}(TABLE.GET_instr(tableidx)) = $free_tableidx(tableidx)
  ;; 2-syntax-aux.watsup:427.1-427.63
  def $free_instr{tableidx : tableidx}(TABLE.SET_instr(tableidx)) = $free_tableidx(tableidx)
  ;; 2-syntax-aux.watsup:428.1-428.64
  def $free_instr{tableidx : tableidx}(TABLE.SIZE_instr(tableidx)) = $free_tableidx(tableidx)
  ;; 2-syntax-aux.watsup:429.1-429.64
  def $free_instr{tableidx : tableidx}(TABLE.GROW_instr(tableidx)) = $free_tableidx(tableidx)
  ;; 2-syntax-aux.watsup:430.1-430.64
  def $free_instr{tableidx : tableidx}(TABLE.FILL_instr(tableidx)) = $free_tableidx(tableidx)
  ;; 2-syntax-aux.watsup:431.1-432.59
  def $free_instr{tableidx_1 : tableidx, tableidx_2 : tableidx}(TABLE.COPY_instr(tableidx_1, tableidx_2)) = $free_tableidx(tableidx_1) ++ $free_tableidx(tableidx_2)
  ;; 2-syntax-aux.watsup:433.1-434.53
  def $free_instr{tableidx : tableidx, elemidx : elemidx}(TABLE.INIT_instr(tableidx, elemidx)) = $free_tableidx(tableidx) ++ $free_elemidx(elemidx)
  ;; 2-syntax-aux.watsup:435.1-435.60
  def $free_instr{elemidx : elemidx}(ELEM.DROP_instr(elemidx)) = $free_elemidx(elemidx)
  ;; 2-syntax-aux.watsup:437.1-438.49
  def $free_instr{numtype : numtype, loadop : loadop_(numtype), memidx : memidx, memarg : memarg}(LOAD_instr(numtype, ?(loadop), memidx, memarg)) = $free_numtype(numtype) ++ $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:439.1-440.49
  def $free_instr{numtype : numtype, sz? : sz?, memidx : memidx, memarg : memarg}(STORE_instr(numtype, sz?{sz : sz}, memidx, memarg)) = $free_numtype(numtype) ++ $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:441.1-442.49
  def $free_instr{vectype : vectype, vloadop? : vloadop_(vectype)?, memidx : memidx, memarg : memarg}(VLOAD_instr(vectype, vloadop?{vloadop : vloadop_(vectype)}, memidx, memarg)) = $free_vectype(vectype) ++ $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:443.1-444.49
  def $free_instr{vectype : vectype, sz : sz, memidx : memidx, memarg : memarg, laneidx : laneidx}(VLOAD_LANE_instr(vectype, sz, memidx, memarg, laneidx)) = $free_vectype(vectype) ++ $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:445.1-446.49
  def $free_instr{vectype : vectype, memidx : memidx, memarg : memarg}(VSTORE_instr(vectype, memidx, memarg)) = $free_vectype(vectype) ++ $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:447.1-448.49
  def $free_instr{vectype : vectype, sz : sz, memidx : memidx, memarg : memarg, laneidx : laneidx}(VSTORE_LANE_instr(vectype, sz, memidx, memarg, laneidx)) = $free_vectype(vectype) ++ $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:449.1-449.59
  def $free_instr{memidx : memidx}(MEMORY.SIZE_instr(memidx)) = $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:450.1-450.59
  def $free_instr{memidx : memidx}(MEMORY.GROW_instr(memidx)) = $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:451.1-451.59
  def $free_instr{memidx : memidx}(MEMORY.FILL_instr(memidx)) = $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:452.1-453.51
  def $free_instr{memidx_1 : memidx, memidx_2 : memidx}(MEMORY.COPY_instr(memidx_1, memidx_2)) = $free_memidx(memidx_1) ++ $free_memidx(memidx_2)
  ;; 2-syntax-aux.watsup:454.1-455.49
  def $free_instr{memidx : memidx, dataidx : dataidx}(MEMORY.INIT_instr(memidx, dataidx)) = $free_memidx(memidx) ++ $free_dataidx(dataidx)
  ;; 2-syntax-aux.watsup:456.1-456.60
  def $free_instr{dataidx : dataidx}(DATA.DROP_instr(dataidx)) = $free_dataidx(dataidx)
}

;; 2-syntax-aux.watsup
def $free_expr(expr : expr) : free
  ;; 2-syntax-aux.watsup
  def $free_expr{instr* : instr*}(instr*{instr : instr}) = $free_list($free_instr(instr)*{instr : instr})

;; 2-syntax-aux.watsup
def $free_type(type : type) : free
  ;; 2-syntax-aux.watsup
  def $free_type{rectype : rectype}(TYPE_type(rectype)) = $free_rectype(rectype)

;; 2-syntax-aux.watsup
def $free_local(local : local) : free
  ;; 2-syntax-aux.watsup
  def $free_local{t : valtype}(LOCAL_local(t)) = $free_valtype(t)

;; 2-syntax-aux.watsup
def $free_func(func : func) : free
  ;; 2-syntax-aux.watsup
  def $free_func{typeidx : typeidx, local* : local*, expr : expr}(FUNC_func(typeidx, local*{local : local}, expr)) = $free_typeidx(typeidx) ++ $free_list($free_local(local)*{local : local}) ++ $free_block(expr)[LOCALS_free = []]

;; 2-syntax-aux.watsup
def $free_global(global : global) : free
  ;; 2-syntax-aux.watsup
  def $free_global{globaltype : globaltype, expr : expr}(GLOBAL_global(globaltype, expr)) = $free_globaltype(globaltype) ++ $free_expr(expr)

;; 2-syntax-aux.watsup
def $free_table(table : table) : free
  ;; 2-syntax-aux.watsup
  def $free_table{tabletype : tabletype, expr : expr}(TABLE_table(tabletype, expr)) = $free_tabletype(tabletype) ++ $free_expr(expr)

;; 2-syntax-aux.watsup
def $free_mem(mem : mem) : free
  ;; 2-syntax-aux.watsup
  def $free_mem{memtype : memtype}(MEMORY_mem(memtype)) = $free_memtype(memtype)

;; 2-syntax-aux.watsup
def $free_elemmode(elemmode : elemmode) : free
  ;; 2-syntax-aux.watsup
  def $free_elemmode{tableidx : tableidx, expr : expr}(ACTIVE_elemmode(tableidx, expr)) = $free_tableidx(tableidx) ++ $free_expr(expr)
  ;; 2-syntax-aux.watsup
  def $free_elemmode(PASSIVE_elemmode) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup
  def $free_elemmode(DECLARE_elemmode) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_datamode(datamode : datamode) : free
  ;; 2-syntax-aux.watsup
  def $free_datamode{memidx : memidx, expr : expr}(ACTIVE_datamode(memidx, expr)) = $free_memidx(memidx) ++ $free_expr(expr)
  ;; 2-syntax-aux.watsup
  def $free_datamode(PASSIVE_datamode) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_elem(elem : elem) : free
  ;; 2-syntax-aux.watsup
  def $free_elem{reftype : reftype, expr* : expr*, elemmode : elemmode}(ELEM_elem(reftype, expr*{expr : expr}, elemmode)) = $free_reftype(reftype) ++ $free_list($free_expr(expr)*{expr : expr}) ++ $free_elemmode(elemmode)

;; 2-syntax-aux.watsup
def $free_data(data : data) : free
  ;; 2-syntax-aux.watsup
  def $free_data{byte* : byte*, datamode : datamode}(DATA_data(byte*{byte : byte}, datamode)) = $free_datamode(datamode)

;; 2-syntax-aux.watsup
def $free_start(start : start) : free
  ;; 2-syntax-aux.watsup
  def $free_start{funcidx : funcidx}(START_start(funcidx)) = $free_funcidx(funcidx)

;; 2-syntax-aux.watsup
def $free_export(export : export) : free
  ;; 2-syntax-aux.watsup
  def $free_export{name : name, externidx : externidx}(EXPORT_export(name, externidx)) = $free_externidx(externidx)

;; 2-syntax-aux.watsup
def $free_import(import : import) : free
  ;; 2-syntax-aux.watsup
  def $free_import{name_1 : name, name_2 : name, externtype : externtype}(IMPORT_import(name_1, name_2, externtype)) = $free_externtype(externtype)

;; 2-syntax-aux.watsup
def $free_module(module : module) : free
  ;; 2-syntax-aux.watsup
  def $free_module{type* : type*, import* : import*, func* : func*, global* : global*, table* : table*, mem* : mem*, elem* : elem*, data* : data*, start* : start*, export* : export*}(MODULE_module(type*{type : type}, import*{import : import}, func*{func : func}, global*{global : global}, table*{table : table}, mem*{mem : mem}, elem*{elem : elem}, data*{data : data}, start*{start : start}, export*{export : export})) = $free_list($free_type(type)*{type : type}) ++ $free_list($free_import(import)*{import : import}) ++ $free_list($free_func(func)*{func : func}) ++ $free_list($free_global(global)*{global : global}) ++ $free_list($free_table(table)*{table : table}) ++ $free_list($free_mem(mem)*{mem : mem}) ++ $free_list($free_elem(elem)*{elem : elem}) ++ $free_list($free_data(data)*{data : data}) ++ $free_list($free_start(start)*{start : start}) ++ $free_list($free_export(export)*{export : export})

;; 2-syntax-aux.watsup
def $funcidx_module(module : module) : funcidx*
  ;; 2-syntax-aux.watsup
  def $funcidx_module{module : module}(module) = $free_module(module).FUNCS_free

;; 2-syntax-aux.watsup
def $dataidx_funcs(func*) : dataidx*
  ;; 2-syntax-aux.watsup
  def $dataidx_funcs{func* : func*}(func*{func : func}) = $free_list($free_func(func)*{func : func}).DATAS_free

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:544.1-544.112
def $subst_typevar(typevar : typevar, typevar*, typeuse*) : typeuse
  ;; 2-syntax-aux.watsup:571.1-571.38
  def $subst_typevar{tv : typevar}(tv, [], []) = (tv : typevar <: typeuse)
  ;; 2-syntax-aux.watsup:572.1-572.95
  def $subst_typevar{tv : typevar, tv_1 : typevar, tv'* : typevar*, tu_1 : typeuse, tu'* : typeuse*}(tv, [tv_1] :: tv'*{tv' : typevar}, [tu_1] :: tu'*{tu' : typeuse}) = tu_1
    -- if (tv = tv_1)
  ;; 2-syntax-aux.watsup:573.1-573.92
  def $subst_typevar{tv : typevar, tv_1 : typevar, tv'* : typevar*, tu_1 : typeuse, tu'* : typeuse*}(tv, [tv_1] :: tv'*{tv' : typevar}, [tu_1] :: tu'*{tu' : typeuse}) = $subst_typevar(tv, tv'*{tv' : typevar}, tu'*{tu' : typeuse})
    -- otherwise
}

;; 2-syntax-aux.watsup
def $subst_packtype(packtype : packtype, typevar*, typeuse*) : packtype
  ;; 2-syntax-aux.watsup
  def $subst_packtype{pt : packtype, tv* : typevar*, tu* : typeuse*}(pt, tv*{tv : typevar}, tu*{tu : typeuse}) = pt

;; 2-syntax-aux.watsup
def $subst_numtype(numtype : numtype, typevar*, typeuse*) : numtype
  ;; 2-syntax-aux.watsup
  def $subst_numtype{nt : numtype, tv* : typevar*, tu* : typeuse*}(nt, tv*{tv : typevar}, tu*{tu : typeuse}) = nt

;; 2-syntax-aux.watsup
def $subst_vectype(vectype : vectype, typevar*, typeuse*) : vectype
  ;; 2-syntax-aux.watsup
  def $subst_vectype{vt : vectype, tv* : typevar*, tu* : typeuse*}(vt, tv*{tv : typevar}, tu*{tu : typeuse}) = vt

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:545.1-545.112
def $subst_typeuse(typeuse : typeuse, typevar*, typeuse*) : typeuse
  ;; 2-syntax-aux.watsup:575.1-575.66
  def $subst_typeuse{tv' : typevar, tv* : typevar*, tu* : typeuse*}((tv' : typevar <: typeuse), tv*{tv : typevar}, tu*{tu : typeuse}) = $subst_typevar(tv', tv*{tv : typevar}, tu*{tu : typeuse})
  ;; 2-syntax-aux.watsup:576.1-576.64
  def $subst_typeuse{dt : deftype, tv* : typevar*, tu* : typeuse*}((dt : deftype <: typeuse), tv*{tv : typevar}, tu*{tu : typeuse}) = ($subst_deftype(dt, tv*{tv : typevar}, tu*{tu : typeuse}) : deftype <: typeuse)

;; 2-syntax-aux.watsup:549.1-549.112
def $subst_heaptype(heaptype : heaptype, typevar*, typeuse*) : heaptype
  ;; 2-syntax-aux.watsup:581.1-581.67
  def $subst_heaptype{tv' : typevar, tv* : typevar*, tu* : typeuse*}((tv' : typevar <: heaptype), tv*{tv : typevar}, tu*{tu : typeuse}) = ($subst_typevar(tv', tv*{tv : typevar}, tu*{tu : typeuse}) : typeuse <: heaptype)
  ;; 2-syntax-aux.watsup:582.1-582.65
  def $subst_heaptype{dt : deftype, tv* : typevar*, tu* : typeuse*}((dt : deftype <: heaptype), tv*{tv : typevar}, tu*{tu : typeuse}) = ($subst_deftype(dt, tv*{tv : typevar}, tu*{tu : typeuse}) : deftype <: heaptype)
  ;; 2-syntax-aux.watsup:583.1-583.53
  def $subst_heaptype{ht : heaptype, tv* : typevar*, tu* : typeuse*}(ht, tv*{tv : typevar}, tu*{tu : typeuse}) = ht
    -- otherwise

;; 2-syntax-aux.watsup:550.1-550.112
def $subst_reftype(reftype : reftype, typevar*, typeuse*) : reftype
  ;; 2-syntax-aux.watsup:585.1-585.83
  def $subst_reftype{nul : nul, ht : heaptype, tv* : typevar*, tu* : typeuse*}(REF_reftype(nul, ht), tv*{tv : typevar}, tu*{tu : typeuse}) = REF_reftype(nul, $subst_heaptype(ht, tv*{tv : typevar}, tu*{tu : typeuse}))

;; 2-syntax-aux.watsup:551.1-551.112
def $subst_valtype(valtype : valtype, typevar*, typeuse*) : valtype
  ;; 2-syntax-aux.watsup:587.1-587.64
  def $subst_valtype{nt : numtype, tv* : typevar*, tu* : typeuse*}((nt : numtype <: valtype), tv*{tv : typevar}, tu*{tu : typeuse}) = ($subst_numtype(nt, tv*{tv : typevar}, tu*{tu : typeuse}) : numtype <: valtype)
  ;; 2-syntax-aux.watsup:588.1-588.64
  def $subst_valtype{vt : vectype, tv* : typevar*, tu* : typeuse*}((vt : vectype <: valtype), tv*{tv : typevar}, tu*{tu : typeuse}) = ($subst_vectype(vt, tv*{tv : typevar}, tu*{tu : typeuse}) : vectype <: valtype)
  ;; 2-syntax-aux.watsup:589.1-589.64
  def $subst_valtype{rt : reftype, tv* : typevar*, tu* : typeuse*}((rt : reftype <: valtype), tv*{tv : typevar}, tu*{tu : typeuse}) = ($subst_reftype(rt, tv*{tv : typevar}, tu*{tu : typeuse}) : reftype <: valtype)
  ;; 2-syntax-aux.watsup:590.1-590.40
  def $subst_valtype{tv* : typevar*, tu* : typeuse*}(BOT_valtype, tv*{tv : typevar}, tu*{tu : typeuse}) = BOT_valtype

;; 2-syntax-aux.watsup:554.1-554.112
def $subst_storagetype(storagetype : storagetype, typevar*, typeuse*) : storagetype
  ;; 2-syntax-aux.watsup:594.1-594.66
  def $subst_storagetype{t : valtype, tv* : typevar*, tu* : typeuse*}((t : valtype <: storagetype), tv*{tv : typevar}, tu*{tu : typeuse}) = ($subst_valtype(t, tv*{tv : typevar}, tu*{tu : typeuse}) : valtype <: storagetype)
  ;; 2-syntax-aux.watsup:595.1-595.69
  def $subst_storagetype{pt : packtype, tv* : typevar*, tu* : typeuse*}((pt : packtype <: storagetype), tv*{tv : typevar}, tu*{tu : typeuse}) = ($subst_packtype(pt, tv*{tv : typevar}, tu*{tu : typeuse}) : packtype <: storagetype)

;; 2-syntax-aux.watsup:555.1-555.112
def $subst_fieldtype(fieldtype : fieldtype, typevar*, typeuse*) : fieldtype
  ;; 2-syntax-aux.watsup:597.1-597.80
  def $subst_fieldtype{mut : mut, zt : storagetype, tv* : typevar*, tu* : typeuse*}(`%%`_fieldtype(mut, zt), tv*{tv : typevar}, tu*{tu : typeuse}) = `%%`_fieldtype(mut, $subst_storagetype(zt, tv*{tv : typevar}, tu*{tu : typeuse}))

;; 2-syntax-aux.watsup:557.1-557.112
def $subst_comptype(comptype : comptype, typevar*, typeuse*) : comptype
  ;; 2-syntax-aux.watsup:599.1-599.85
  def $subst_comptype{yt* : fieldtype*, tv* : typevar*, tu* : typeuse*}(STRUCT_comptype(`%`_structtype(yt*{yt : fieldtype})), tv*{tv : typevar}, tu*{tu : typeuse}) = STRUCT_comptype(`%`_structtype($subst_fieldtype(yt, tv*{tv : typevar}, tu*{tu : typeuse})*{yt : fieldtype}))
  ;; 2-syntax-aux.watsup:600.1-600.81
  def $subst_comptype{yt : fieldtype, tv* : typevar*, tu* : typeuse*}(ARRAY_comptype(yt), tv*{tv : typevar}, tu*{tu : typeuse}) = ARRAY_comptype($subst_fieldtype(yt, tv*{tv : typevar}, tu*{tu : typeuse}))
  ;; 2-syntax-aux.watsup:601.1-601.78
  def $subst_comptype{ft : functype, tv* : typevar*, tu* : typeuse*}(FUNC_comptype(ft), tv*{tv : typevar}, tu*{tu : typeuse}) = FUNC_comptype($subst_functype(ft, tv*{tv : typevar}, tu*{tu : typeuse}))

;; 2-syntax-aux.watsup:558.1-558.112
def $subst_subtype(subtype : subtype, typevar*, typeuse*) : subtype
  ;; 2-syntax-aux.watsup:603.1-604.71
  def $subst_subtype{fin : fin, tu'* : typeuse*, ct : comptype, tv* : typevar*, tu* : typeuse*}(SUB_subtype(fin, tu'*{tu' : typeuse}, ct), tv*{tv : typevar}, tu*{tu : typeuse}) = SUB_subtype(fin, $subst_typeuse(tu', tv*{tv : typevar}, tu*{tu : typeuse})*{tu' : typeuse}, $subst_comptype(ct, tv*{tv : typevar}, tu*{tu : typeuse}))

;; 2-syntax-aux.watsup:559.1-559.112
def $subst_rectype(rectype : rectype, typevar*, typeuse*) : rectype
  ;; 2-syntax-aux.watsup:606.1-606.76
  def $subst_rectype{st* : subtype*, tv* : typevar*, tu* : typeuse*}(REC_rectype(`%`_list(st*{st : subtype})), tv*{tv : typevar}, tu*{tu : typeuse}) = REC_rectype(`%`_list($subst_subtype(st, tv*{tv : typevar}, tu*{tu : typeuse})*{st : subtype}))

;; 2-syntax-aux.watsup:560.1-560.112
def $subst_deftype(deftype : deftype, typevar*, typeuse*) : deftype
  ;; 2-syntax-aux.watsup:608.1-608.78
  def $subst_deftype{qt : rectype, i : nat, tv* : typevar*, tu* : typeuse*}(DEF_deftype(qt, i), tv*{tv : typevar}, tu*{tu : typeuse}) = DEF_deftype($subst_rectype(qt, tv*{tv : typevar}, tu*{tu : typeuse}), i)

;; 2-syntax-aux.watsup:563.1-563.112
def $subst_functype(functype : functype, typevar*, typeuse*) : functype
  ;; 2-syntax-aux.watsup:611.1-611.113
  def $subst_functype{t_1* : valtype*, t_2* : valtype*, tv* : typevar*, tu* : typeuse*}(`%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype})), tv*{tv : typevar}, tu*{tu : typeuse}) = `%->%`_functype(`%`_resulttype($subst_valtype(t_1, tv*{tv : typevar}, tu*{tu : typeuse})*{t_1 : valtype}), `%`_resulttype($subst_valtype(t_2, tv*{tv : typevar}, tu*{tu : typeuse})*{t_2 : valtype}))
}

;; 2-syntax-aux.watsup
def $subst_globaltype(globaltype : globaltype, typevar*, typeuse*) : globaltype
  ;; 2-syntax-aux.watsup
  def $subst_globaltype{mut : mut, t : valtype, tv* : typevar*, tu* : typeuse*}(`%%`_globaltype(mut, t), tv*{tv : typevar}, tu*{tu : typeuse}) = `%%`_globaltype(mut, $subst_valtype(t, tv*{tv : typevar}, tu*{tu : typeuse}))

;; 2-syntax-aux.watsup
def $subst_tabletype(tabletype : tabletype, typevar*, typeuse*) : tabletype
  ;; 2-syntax-aux.watsup
  def $subst_tabletype{lim : limits, rt : reftype, tv* : typevar*, tu* : typeuse*}(`%%`_tabletype(lim, rt), tv*{tv : typevar}, tu*{tu : typeuse}) = `%%`_tabletype(lim, $subst_reftype(rt, tv*{tv : typevar}, tu*{tu : typeuse}))

;; 2-syntax-aux.watsup
def $subst_memtype(memtype : memtype, typevar*, typeuse*) : memtype
  ;; 2-syntax-aux.watsup
  def $subst_memtype{lim : limits, tv* : typevar*, tu* : typeuse*}(`%PAGE`_memtype(lim), tv*{tv : typevar}, tu*{tu : typeuse}) = `%PAGE`_memtype(lim)

;; 2-syntax-aux.watsup
def $subst_externtype(externtype : externtype, typevar*, typeuse*) : externtype
  ;; 2-syntax-aux.watsup
  def $subst_externtype{dt : deftype, tv* : typevar*, tu* : typeuse*}(FUNC_externtype((dt : deftype <: typeuse)), tv*{tv : typevar}, tu*{tu : typeuse}) = FUNC_externtype(($subst_deftype(dt, tv*{tv : typevar}, tu*{tu : typeuse}) : deftype <: typeuse))
  ;; 2-syntax-aux.watsup
  def $subst_externtype{gt : globaltype, tv* : typevar*, tu* : typeuse*}(GLOBAL_externtype(gt), tv*{tv : typevar}, tu*{tu : typeuse}) = GLOBAL_externtype($subst_globaltype(gt, tv*{tv : typevar}, tu*{tu : typeuse}))
  ;; 2-syntax-aux.watsup
  def $subst_externtype{tt : tabletype, tv* : typevar*, tu* : typeuse*}(TABLE_externtype(tt), tv*{tv : typevar}, tu*{tu : typeuse}) = TABLE_externtype($subst_tabletype(tt, tv*{tv : typevar}, tu*{tu : typeuse}))
  ;; 2-syntax-aux.watsup
  def $subst_externtype{mt : memtype, tv* : typevar*, tu* : typeuse*}(MEM_externtype(mt), tv*{tv : typevar}, tu*{tu : typeuse}) = MEM_externtype($subst_memtype(mt, tv*{tv : typevar}, tu*{tu : typeuse}))

;; 2-syntax-aux.watsup
def $subst_moduletype(moduletype : moduletype, typevar*, typeuse*) : moduletype
  ;; 2-syntax-aux.watsup
  def $subst_moduletype{xt_1* : externtype*, xt_2* : externtype*, tv* : typevar*, tu* : typeuse*}(`%->%`_moduletype(xt_1*{xt_1 : externtype}, xt_2*{xt_2 : externtype}), tv*{tv : typevar}, tu*{tu : typeuse}) = `%->%`_moduletype($subst_externtype(xt_1, tv*{tv : typevar}, tu*{tu : typeuse})*{xt_1 : externtype}, $subst_externtype(xt_2, tv*{tv : typevar}, tu*{tu : typeuse})*{xt_2 : externtype})

;; 2-syntax-aux.watsup
def $subst_all_valtype(valtype : valtype, heaptype*) : valtype
  ;; 2-syntax-aux.watsup
  def $subst_all_valtype{t : valtype, tu^n : typeuse^n, n : n, i^n : nat^n}(t, (tu : typeuse <: heaptype)^n{tu : typeuse}) = $subst_valtype(t, $idx(`%`_typeidx(i))^(i<n){i : nat}, tu^n{tu : typeuse})

;; 2-syntax-aux.watsup
def $subst_all_reftype(reftype : reftype, heaptype*) : reftype
  ;; 2-syntax-aux.watsup
  def $subst_all_reftype{rt : reftype, tu^n : typeuse^n, n : n, i^n : nat^n}(rt, (tu : typeuse <: heaptype)^n{tu : typeuse}) = $subst_reftype(rt, $idx(`%`_typeidx(i))^(i<n){i : nat}, tu^n{tu : typeuse})

;; 2-syntax-aux.watsup
def $subst_all_deftype(deftype : deftype, heaptype*) : deftype
  ;; 2-syntax-aux.watsup
  def $subst_all_deftype{dt : deftype, tu^n : typeuse^n, n : n, i^n : nat^n}(dt, (tu : typeuse <: heaptype)^n{tu : typeuse}) = $subst_deftype(dt, $idx(`%`_typeidx(i))^(i<n){i : nat}, tu^n{tu : typeuse})

;; 2-syntax-aux.watsup
def $subst_all_moduletype(moduletype : moduletype, heaptype*) : moduletype
  ;; 2-syntax-aux.watsup
  def $subst_all_moduletype{mmt : moduletype, tu^n : typeuse^n, n : n, i^n : nat^n}(mmt, (tu : typeuse <: heaptype)^n{tu : typeuse}) = $subst_moduletype(mmt, $idx(`%`_typeidx(i))^(i<n){i : nat}, tu^n{tu : typeuse})

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:633.1-633.98
def $subst_all_deftypes(deftype*, heaptype*) : deftype*
  ;; 2-syntax-aux.watsup:634.1-634.40
  def $subst_all_deftypes{tu* : typeuse*}([], (tu : typeuse <: heaptype)*{tu : typeuse}) = []
  ;; 2-syntax-aux.watsup:635.1-635.101
  def $subst_all_deftypes{dt_1 : deftype, dt* : deftype*, tu* : typeuse*}([dt_1] :: dt*{dt : deftype}, (tu : typeuse <: heaptype)*{tu : typeuse}) = [$subst_all_deftype(dt_1, (tu : typeuse <: heaptype)*{tu : typeuse})] :: $subst_all_deftypes(dt*{dt : deftype}, (tu : typeuse <: heaptype)*{tu : typeuse})
}

;; 2-syntax-aux.watsup
def $rollrt(typeidx : typeidx, rectype : rectype) : rectype
  ;; 2-syntax-aux.watsup
  def $rollrt{x : idx, rectype : rectype, subtype^n : subtype^n, i^n : nat^n, n : n}(x, rectype) = REC_rectype(`%`_list($subst_subtype(subtype, $idx(`%`_typeidx((x!`%`_idx.0 + i)))^(i<n){i : nat}, REC_typeuse(i)^(i<n){i : nat})^n{subtype : subtype}))
    -- if (rectype = REC_rectype(`%`_list(subtype^n{subtype : subtype})))

;; 2-syntax-aux.watsup
def $unrollrt(rectype : rectype) : rectype
  ;; 2-syntax-aux.watsup
  def $unrollrt{rectype : rectype, subtype^n : subtype^n, i^n : nat^n, n : n}(rectype) = REC_rectype(`%`_list($subst_subtype(subtype, REC_typevar(i)^(i<n){i : nat}, DEF_typeuse(rectype, i)^(i<n){i : nat})^n{subtype : subtype}))
    -- if (rectype = REC_rectype(`%`_list(subtype^n{subtype : subtype})))

;; 2-syntax-aux.watsup
def $rolldt(typeidx : typeidx, rectype : rectype) : deftype*
  ;; 2-syntax-aux.watsup
  def $rolldt{x : idx, rectype : rectype, subtype^n : subtype^n, n : n, i^n : nat^n}(x, rectype) = DEF_deftype(REC_rectype(`%`_list(subtype^n{subtype : subtype})), i)^(i<n){i : nat}
    -- if ($rollrt(x, rectype) = REC_rectype(`%`_list(subtype^n{subtype : subtype})))

;; 2-syntax-aux.watsup
def $unrolldt(deftype : deftype) : subtype
  ;; 2-syntax-aux.watsup
  def $unrolldt{rectype : rectype, i : nat, subtype* : subtype*}(DEF_deftype(rectype, i)) = subtype*{subtype : subtype}[i]
    -- if ($unrollrt(rectype) = REC_rectype(`%`_list(subtype*{subtype : subtype})))

;; 2-syntax-aux.watsup
def $expanddt(deftype : deftype) : comptype
  ;; 2-syntax-aux.watsup
  def $expanddt{deftype : deftype, comptype : comptype, fin : fin, typeuse* : typeuse*}(deftype) = comptype
    -- if ($unrolldt(deftype) = SUB_subtype(fin, typeuse*{typeuse : typeuse}, comptype))

;; 2-syntax-aux.watsup
relation Expand: `%~~%`(deftype, comptype)
  ;; 2-syntax-aux.watsup
  rule _{deftype : deftype, comptype : comptype, fin : fin, typeuse* : typeuse*}:
    `%~~%`(deftype, comptype)
    -- if ($unrolldt(deftype) = SUB_subtype(fin, typeuse*{typeuse : typeuse}, comptype))

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:667.1-667.86
def $funcsxx(externidx*) : typeidx*
  ;; 2-syntax-aux.watsup:672.1-672.24
  def $funcsxx([]) = []
  ;; 2-syntax-aux.watsup:673.1-673.45
  def $funcsxx{x : idx, xx* : externidx*}([FUNC_externidx(x)] :: xx*{xx : externidx}) = [x] :: $funcsxx(xx*{xx : externidx})
  ;; 2-syntax-aux.watsup:674.1-674.58
  def $funcsxx{externidx : externidx, xx* : externidx*}([externidx] :: xx*{xx : externidx}) = $funcsxx(xx*{xx : externidx})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:668.1-668.88
def $globalsxx(externidx*) : globalidx*
  ;; 2-syntax-aux.watsup:676.1-676.26
  def $globalsxx([]) = []
  ;; 2-syntax-aux.watsup:677.1-677.51
  def $globalsxx{x : idx, xx* : externidx*}([GLOBAL_externidx(x)] :: xx*{xx : externidx}) = [x] :: $globalsxx(xx*{xx : externidx})
  ;; 2-syntax-aux.watsup:678.1-678.62
  def $globalsxx{externidx : externidx, xx* : externidx*}([externidx] :: xx*{xx : externidx}) = $globalsxx(xx*{xx : externidx})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:669.1-669.87
def $tablesxx(externidx*) : tableidx*
  ;; 2-syntax-aux.watsup:680.1-680.25
  def $tablesxx([]) = []
  ;; 2-syntax-aux.watsup:681.1-681.48
  def $tablesxx{x : idx, xx* : externidx*}([TABLE_externidx(x)] :: xx*{xx : externidx}) = [x] :: $tablesxx(xx*{xx : externidx})
  ;; 2-syntax-aux.watsup:682.1-682.60
  def $tablesxx{externidx : externidx, xx* : externidx*}([externidx] :: xx*{xx : externidx}) = $tablesxx(xx*{xx : externidx})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:670.1-670.85
def $memsxx(externidx*) : memidx*
  ;; 2-syntax-aux.watsup:684.1-684.23
  def $memsxx([]) = []
  ;; 2-syntax-aux.watsup:685.1-685.42
  def $memsxx{x : idx, xx* : externidx*}([MEM_externidx(x)] :: xx*{xx : externidx}) = [x] :: $memsxx(xx*{xx : externidx})
  ;; 2-syntax-aux.watsup:686.1-686.56
  def $memsxx{externidx : externidx, xx* : externidx*}([externidx] :: xx*{xx : externidx}) = $memsxx(xx*{xx : externidx})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:689.1-689.88
def $funcsxt(externtype*) : deftype*
  ;; 2-syntax-aux.watsup:694.1-694.24
  def $funcsxt([]) = []
  ;; 2-syntax-aux.watsup:695.1-695.47
  def $funcsxt{dt : deftype, xt* : externtype*}([FUNC_externtype((dt : deftype <: typeuse))] :: xt*{xt : externtype}) = [dt] :: $funcsxt(xt*{xt : externtype})
  ;; 2-syntax-aux.watsup:696.1-696.59
  def $funcsxt{externtype : externtype, xt* : externtype*}([externtype] :: xt*{xt : externtype}) = $funcsxt(xt*{xt : externtype})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:690.1-690.90
def $globalsxt(externtype*) : globaltype*
  ;; 2-syntax-aux.watsup:698.1-698.26
  def $globalsxt([]) = []
  ;; 2-syntax-aux.watsup:699.1-699.53
  def $globalsxt{gt : globaltype, xt* : externtype*}([GLOBAL_externtype(gt)] :: xt*{xt : externtype}) = [gt] :: $globalsxt(xt*{xt : externtype})
  ;; 2-syntax-aux.watsup:700.1-700.63
  def $globalsxt{externtype : externtype, xt* : externtype*}([externtype] :: xt*{xt : externtype}) = $globalsxt(xt*{xt : externtype})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:691.1-691.89
def $tablesxt(externtype*) : tabletype*
  ;; 2-syntax-aux.watsup:702.1-702.25
  def $tablesxt([]) = []
  ;; 2-syntax-aux.watsup:703.1-703.50
  def $tablesxt{tt : tabletype, xt* : externtype*}([TABLE_externtype(tt)] :: xt*{xt : externtype}) = [tt] :: $tablesxt(xt*{xt : externtype})
  ;; 2-syntax-aux.watsup:704.1-704.61
  def $tablesxt{externtype : externtype, xt* : externtype*}([externtype] :: xt*{xt : externtype}) = $tablesxt(xt*{xt : externtype})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:692.1-692.87
def $memsxt(externtype*) : memtype*
  ;; 2-syntax-aux.watsup:706.1-706.23
  def $memsxt([]) = []
  ;; 2-syntax-aux.watsup:707.1-707.44
  def $memsxt{mt : memtype, xt* : externtype*}([MEM_externtype(mt)] :: xt*{xt : externtype}) = [mt] :: $memsxt(xt*{xt : externtype})
  ;; 2-syntax-aux.watsup:708.1-708.57
  def $memsxt{externtype : externtype, xt* : externtype*}([externtype] :: xt*{xt : externtype}) = $memsxt(xt*{xt : externtype})
    -- otherwise
}

;; 2-syntax-aux.watsup
def $memarg0 : memarg
  ;; 2-syntax-aux.watsup
  def $memarg0 = {ALIGN `%`_u32(0), OFFSET `%`_u32(0)}

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
  def $unop{Inn : Inn, iN : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), CLZ_unop_, iN) = [$iclz($size((Inn : Inn <: numtype)), iN)]
  ;; 3-numerics.watsup
  def $unop{Inn : Inn, iN : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), CTZ_unop_, iN) = [$ictz($size((Inn : Inn <: numtype)), iN)]
  ;; 3-numerics.watsup
  def $unop{Inn : Inn, iN : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), POPCNT_unop_, iN) = [$ipopcnt($size((Inn : Inn <: numtype)), iN)]
  ;; 3-numerics.watsup
  def $unop{Inn : Inn, N : N, iN : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), EXTEND_unop_(`%`_sz(N)), iN) = [$ext(N, $size((Inn : Inn <: numtype)), S_sx, $wrap($size((Inn : Inn <: numtype)), N, iN))]
  ;; 3-numerics.watsup
  def $unop{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), ABS_unop_, fN) = [$fabs($size((Fnn : Fnn <: numtype)), fN)]
  ;; 3-numerics.watsup
  def $unop{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), NEG_unop_, fN) = [$fneg($size((Fnn : Fnn <: numtype)), fN)]
  ;; 3-numerics.watsup
  def $unop{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), SQRT_unop_, fN) = [$fsqrt($size((Fnn : Fnn <: numtype)), fN)]
  ;; 3-numerics.watsup
  def $unop{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), CEIL_unop_, fN) = [$fceil($size((Fnn : Fnn <: numtype)), fN)]
  ;; 3-numerics.watsup
  def $unop{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), FLOOR_unop_, fN) = [$ffloor($size((Fnn : Fnn <: numtype)), fN)]
  ;; 3-numerics.watsup
  def $unop{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), TRUNC_unop_, fN) = [$ftrunc($size((Fnn : Fnn <: numtype)), fN)]
  ;; 3-numerics.watsup
  def $unop{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), NEAREST_unop_, fN) = [$fnearest($size((Fnn : Fnn <: numtype)), fN)]

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
  def $binop{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), ADD_binop_, iN_1, iN_2) = [$iadd($size((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), SUB_binop_, iN_1, iN_2) = [$isub($size((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), MUL_binop_, iN_1, iN_2) = [$imul($size((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), DIV_binop_(sx), iN_1, iN_2) = [$idiv($size((Inn : Inn <: numtype)), sx, iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), REM_binop_(sx), iN_1, iN_2) = [$irem($size((Inn : Inn <: numtype)), sx, iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), AND_binop_, iN_1, iN_2) = [$iand($size((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), OR_binop_, iN_1, iN_2) = [$ior($size((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), XOR_binop_, iN_1, iN_2) = [$ixor($size((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), SHL_binop_, iN_1, iN_2) = [$ishl($size((Inn : Inn <: numtype)), iN_1, `%`_u32(iN_2!`%`_num_.0))]
  ;; 3-numerics.watsup
  def $binop{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), SHR_binop_(sx), iN_1, iN_2) = [$ishr($size((Inn : Inn <: numtype)), sx, iN_1, `%`_u32(iN_2!`%`_num_.0))]
  ;; 3-numerics.watsup
  def $binop{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), ROTL_binop_, iN_1, iN_2) = [$irotl($size((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), ROTR_binop_, iN_1, iN_2) = [$irotr($size((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), ADD_binop_, fN_1, fN_2) = [$fadd($size((Fnn : Fnn <: numtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup
  def $binop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), SUB_binop_, fN_1, fN_2) = [$fsub($size((Fnn : Fnn <: numtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup
  def $binop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), MUL_binop_, fN_1, fN_2) = [$fmul($size((Fnn : Fnn <: numtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup
  def $binop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), DIV_binop_, fN_1, fN_2) = [$fdiv($size((Fnn : Fnn <: numtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup
  def $binop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), MIN_binop_, fN_1, fN_2) = [$fmin($size((Fnn : Fnn <: numtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup
  def $binop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), MAX_binop_, fN_1, fN_2) = [$fmax($size((Fnn : Fnn <: numtype)), fN_1, fN_2)]
  ;; 3-numerics.watsup
  def $binop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), COPYSIGN_binop_, fN_1, fN_2) = [$fcopysign($size((Fnn : Fnn <: numtype)), fN_1, fN_2)]

;; 3-numerics.watsup
def $ieqz(N : N, iN : iN(N)) : u32

;; 3-numerics.watsup
def $testop(numtype : numtype, testop_ : testop_(numtype), num_ : num_(numtype)) : num_(I32_numtype)
  ;; 3-numerics.watsup
  def $testop{Inn : Inn, iN : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), EQZ_testop_, iN) = $ieqz($size((Inn : Inn <: numtype)), iN)

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
  def $relop{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), EQ_relop_, iN_1, iN_2) = $ieq($size((Inn : Inn <: numtype)), iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), NE_relop_, iN_1, iN_2) = $ine($size((Inn : Inn <: numtype)), iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), LT_relop_(sx), iN_1, iN_2) = $ilt($size((Inn : Inn <: numtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), GT_relop_(sx), iN_1, iN_2) = $igt($size((Inn : Inn <: numtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), LE_relop_(sx), iN_1, iN_2) = $ile($size((Inn : Inn <: numtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), GE_relop_(sx), iN_1, iN_2) = $ige($size((Inn : Inn <: numtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), EQ_relop_, fN_1, fN_2) = $feq($size((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), NE_relop_, fN_1, fN_2) = $fne($size((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), LT_relop_, fN_1, fN_2) = $flt($size((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), GT_relop_, fN_1, fN_2) = $fgt($size((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), LE_relop_, fN_1, fN_2) = $fle($size((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), GE_relop_, fN_1, fN_2) = $fge($size((Fnn : Fnn <: numtype)), fN_1, fN_2)

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
def $cvtop(numtype_1 : numtype, numtype_2 : numtype, cvtop_ : cvtop_(numtype_1, numtype_2), sx?, num_ : num_(numtype_1)) : num_(numtype_2)*
  ;; 3-numerics.watsup
  def $cvtop{sx : sx, iN : num_(I32_numtype)}(I32_numtype, I64_numtype, CONVERT_cvtop_, ?(sx), iN) = [$ext(32, 64, sx, iN)]
  ;; 3-numerics.watsup
  def $cvtop{sx? : sx?, iN : num_(I64_numtype)}(I64_numtype, I32_numtype, CONVERT_cvtop_, sx?{sx : sx}, iN) = [$wrap(64, 32, iN)]
  ;; 3-numerics.watsup
  def $cvtop{Fnn : Fnn, Inn : Inn, sx : sx, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), (Inn : Inn <: numtype), CONVERT_cvtop_, ?(sx), fN) = [$trunc($size((Fnn : Fnn <: numtype)), $size((Inn : Inn <: numtype)), sx, fN)]
  ;; 3-numerics.watsup
  def $cvtop{Fnn : Fnn, Inn : Inn, sx : sx, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), (Inn : Inn <: numtype), CONVERT_SAT_cvtop_, ?(sx), fN) = [$trunc_sat($size((Fnn : Fnn <: numtype)), $size((Inn : Inn <: numtype)), sx, fN)]
  ;; 3-numerics.watsup
  def $cvtop{sx? : sx?, fN : num_(F32_numtype)}(F32_numtype, F64_numtype, CONVERT_cvtop_, sx?{sx : sx}, fN) = [$promote(32, 64, fN)]
  ;; 3-numerics.watsup
  def $cvtop{sx? : sx?, fN : num_(F64_numtype)}(F64_numtype, F32_numtype, CONVERT_cvtop_, sx?{sx : sx}, fN) = [$demote(64, 32, fN)]
  ;; 3-numerics.watsup
  def $cvtop{Inn : Inn, Fnn : Fnn, sx : sx, iN : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), (Fnn : Fnn <: numtype), CONVERT_cvtop_, ?(sx), iN) = [$convert($size((Inn : Inn <: numtype)), $size((Fnn : Fnn <: numtype)), sx, iN)]
  ;; 3-numerics.watsup
  def $cvtop{Inn : Inn, Fnn : Fnn, sx? : sx?, iN : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), (Fnn : Fnn <: numtype), REINTERPRET_cvtop_, sx?{sx : sx}, iN) = [$reinterpret((Inn : Inn <: numtype), (Fnn : Fnn <: numtype), iN)]
    -- if ($size((Inn : Inn <: numtype)) = $size((Fnn : Fnn <: numtype)))
  ;; 3-numerics.watsup
  def $cvtop{Fnn : Fnn, Inn : Inn, sx? : sx?, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), (Inn : Inn <: numtype), REINTERPRET_cvtop_, sx?{sx : sx}, fN) = [$reinterpret((Fnn : Fnn <: numtype), (Inn : Inn <: numtype), fN)]
    -- if ($size((Inn : Inn <: numtype)) = $size((Fnn : Fnn <: numtype)))

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
def $zbytes(storagetype : storagetype, lit_ : lit_(storagetype)) : byte*

;; 3-numerics.watsup
def $cbytes(Cnn : Cnn, lit_ : lit_((Cnn : Cnn <: storagetype))) : byte*

;; 3-numerics.watsup
def $invibytes(N : N, byte*) : iN(N)
  ;; 3-numerics.watsup
  def $invibytes{N : N, b* : byte*, n : n}(N, b*{b : byte}) = `%`_iN(n)
    -- if ($ibytes(N, `%`_iN(n)) = b*{b : byte})

;; 3-numerics.watsup
def $invfbytes(N : N, byte*) : fN(N)
  ;; 3-numerics.watsup
  def $invfbytes{N : N, b* : byte*, p : fN(N)}(N, b*{b : byte}) = p
    -- if ($fbytes(N, p) = b*{b : byte})

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
def $lpacknum(lanetype : lanetype, num_ : num_($lunpack(lanetype))) : lane_(lanetype)
  ;; 3-numerics.watsup
  def $lpacknum{numtype : numtype, c : num_($lunpack((numtype : numtype <: lanetype)))}((numtype : numtype <: lanetype), c) = c
  ;; 3-numerics.watsup
  def $lpacknum{packtype : packtype, c : num_($lunpack((packtype : packtype <: lanetype)))}((packtype : packtype <: lanetype), c) = $wrap($size($lunpack((packtype : packtype <: lanetype))), $psize(packtype), c)

;; 3-numerics.watsup
def $lunpacknum(lanetype : lanetype, lane_ : lane_(lanetype)) : num_($lunpack(lanetype))
  ;; 3-numerics.watsup
  def $lunpacknum{numtype : numtype, c : lane_((numtype : numtype <: lanetype))}((numtype : numtype <: lanetype), c) = c
  ;; 3-numerics.watsup
  def $lunpacknum{packtype : packtype, c : lane_((packtype : packtype <: lanetype))}((packtype : packtype <: lanetype), c) = $ext($psize(packtype), $size($lunpack((packtype : packtype <: lanetype))), U_sx, c)

;; 3-numerics.watsup
def $cpacknum(storagetype : storagetype, lit_ : lit_(($cunpack(storagetype) : consttype <: storagetype))) : lit_(storagetype)
  ;; 3-numerics.watsup
  def $cpacknum{consttype : consttype, c : lit_(($cunpack((consttype : consttype <: storagetype)) : consttype <: storagetype))}((consttype : consttype <: storagetype), c) = c
  ;; 3-numerics.watsup
  def $cpacknum{packtype : packtype, c : lit_(($cunpack((packtype : packtype <: storagetype)) : consttype <: storagetype))}((packtype : packtype <: storagetype), c) = $wrap($size($lunpack((packtype : packtype <: lanetype))), $psize(packtype), c)

;; 3-numerics.watsup
def $cunpacknum(storagetype : storagetype, lit_ : lit_(storagetype)) : lit_(($cunpack(storagetype) : consttype <: storagetype))
  ;; 3-numerics.watsup
  def $cunpacknum{consttype : consttype, c : lit_((consttype : consttype <: storagetype))}((consttype : consttype <: storagetype), c) = c
  ;; 3-numerics.watsup
  def $cunpacknum{packtype : packtype, c : lit_((packtype : packtype <: storagetype))}((packtype : packtype <: storagetype), c) = $ext($psize(packtype), $size($lunpack((packtype : packtype <: lanetype))), U_sx, c)

;; 3-numerics.watsup
def $lanes_(shape : shape, vec_ : vec_(V128_Vnn)) : lane_($lanetype(shape))*

;; 3-numerics.watsup
def $invlanes_(shape : shape, lane_($lanetype(shape))*) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $invlanes_{sh : shape, c* : lane_($lanetype(sh))*, vc : vec_(V128_Vnn)}(sh, c*{c : lane_($lanetype(sh))}) = vc
    -- if (c*{c : lane_($lanetype(sh))} = $lanes_(sh, vc))

;; 3-numerics.watsup
def $half(half : half, nat : nat, nat : nat) : nat
  ;; 3-numerics.watsup
  def $half{i : nat, j : nat}(LOW_half, i, j) = i
  ;; 3-numerics.watsup
  def $half{i : nat, j : nat}(HIGH_half, i, j) = j

;; 3-numerics.watsup
def $vvunop(vectype : vectype, vvunop : vvunop, vec_ : vec_(vectype)) : vec_(vectype)
  ;; 3-numerics.watsup
  def $vvunop{v128 : vec_(V128_Vnn)}(V128_vectype, NOT_vvunop, v128) = $inot($vsize(V128_vectype), v128)

;; 3-numerics.watsup
def $vvbinop(vectype : vectype, vvbinop : vvbinop, vec_ : vec_(vectype), vec_ : vec_(vectype)) : vec_(vectype)
  ;; 3-numerics.watsup
  def $vvbinop{v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn)}(V128_vectype, AND_vvbinop, v128_1, v128_2) = $iand($vsize(V128_vectype), v128_1, v128_2)
  ;; 3-numerics.watsup
  def $vvbinop{v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn)}(V128_vectype, ANDNOT_vvbinop, v128_1, v128_2) = $iandnot($vsize(V128_vectype), v128_1, v128_2)
  ;; 3-numerics.watsup
  def $vvbinop{v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn)}(V128_vectype, OR_vvbinop, v128_1, v128_2) = $ior($vsize(V128_vectype), v128_1, v128_2)
  ;; 3-numerics.watsup
  def $vvbinop{v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn)}(V128_vectype, XOR_vvbinop, v128_1, v128_2) = $ixor($vsize(V128_vectype), v128_1, v128_2)

;; 3-numerics.watsup
def $vvternop(vectype : vectype, vvternop : vvternop, vec_ : vec_(vectype), vec_ : vec_(vectype), vec_ : vec_(vectype)) : vec_(vectype)
  ;; 3-numerics.watsup
  def $vvternop{v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128_3 : vec_(V128_Vnn)}(V128_vectype, BITSELECT_vvternop, v128_1, v128_2, v128_3) = $ibitselect($vsize(V128_vectype), v128_1, v128_2, v128_3)

;; 3-numerics.watsup
def $vunop(shape : shape, vunop_ : vunop_(shape), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $vunop{Jnn : Jnn, N : N, v128_1 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), ABS_vunop_, v128_1) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $iabs($lsize((Jnn : Jnn <: lanetype)), lane_1)*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype)))}))
  ;; 3-numerics.watsup
  def $vunop{Jnn : Jnn, N : N, v128_1 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), NEG_vunop_, v128_1) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $ineg($lsize((Jnn : Jnn <: lanetype)), lane_1)*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype)))}))
  ;; 3-numerics.watsup
  def $vunop{Jnn : Jnn, N : N, v128_1 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), POPCNT_vunop_, v128_1) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $ipopcnt($lsize((Jnn : Jnn <: lanetype)), lane_1)*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype)))}))
  ;; 3-numerics.watsup
  def $vunop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), ABS_vunop_, v128_1) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fabs($size((Fnn : Fnn <: numtype)), lane_1)*{lane_1 : fN($size((Fnn : Fnn <: numtype)))}))
  ;; 3-numerics.watsup
  def $vunop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), NEG_vunop_, v128_1) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fneg($size((Fnn : Fnn <: numtype)), lane_1)*{lane_1 : fN($size((Fnn : Fnn <: numtype)))}))
  ;; 3-numerics.watsup
  def $vunop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), SQRT_vunop_, v128_1) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fsqrt($size((Fnn : Fnn <: numtype)), lane_1)*{lane_1 : fN($size((Fnn : Fnn <: numtype)))}))
  ;; 3-numerics.watsup
  def $vunop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), CEIL_vunop_, v128_1) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fceil($size((Fnn : Fnn <: numtype)), lane_1)*{lane_1 : fN($size((Fnn : Fnn <: numtype)))}))
  ;; 3-numerics.watsup
  def $vunop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), FLOOR_vunop_, v128_1) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $ffloor($size((Fnn : Fnn <: numtype)), lane_1)*{lane_1 : fN($size((Fnn : Fnn <: numtype)))}))
  ;; 3-numerics.watsup
  def $vunop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), TRUNC_vunop_, v128_1) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $ftrunc($size((Fnn : Fnn <: numtype)), lane_1)*{lane_1 : fN($size((Fnn : Fnn <: numtype)))}))
  ;; 3-numerics.watsup
  def $vunop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), NEAREST_vunop_, v128_1) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (v128 = $invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fnearest($size((Fnn : Fnn <: numtype)), lane_1)*{lane_1 : fN($size((Fnn : Fnn <: numtype)))}))

;; 3-numerics.watsup
def $vbinop(shape : shape, vbinop_ : vbinop_(shape), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; 3-numerics.watsup
  def $vbinop{Jnn : Jnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), ADD_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $iadd($lsize((Jnn : Jnn <: lanetype)), lane_1, lane_2)*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Jnn : Jnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), SUB_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $isub($lsize((Jnn : Jnn <: lanetype)), lane_1, lane_2)*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Jnn : Jnn, N : N, sx : sx, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), MIN_vbinop_(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $imin($lsize((Jnn : Jnn <: lanetype)), sx, lane_1, lane_2)*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Jnn : Jnn, N : N, sx : sx, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), MAX_vbinop_(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $imax($lsize((Jnn : Jnn <: lanetype)), sx, lane_1, lane_2)*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Jnn : Jnn, N : N, sx : sx, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), ADD_SAT_vbinop_(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $iaddsat($lsize((Jnn : Jnn <: lanetype)), sx, lane_1, lane_2)*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Jnn : Jnn, N : N, sx : sx, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), SUB_SAT_vbinop_(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $isubsat($lsize((Jnn : Jnn <: lanetype)), sx, lane_1, lane_2)*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Jnn : Jnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), MUL_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $imul($lsize((Jnn : Jnn <: lanetype)), lane_1, lane_2)*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Jnn : Jnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), AVGR_U_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $iavgr_u($lsize((Jnn : Jnn <: lanetype)), lane_1, lane_2)*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Jnn : Jnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), Q15MULR_SAT_S_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $iq15mulrsat_s($lsize((Jnn : Jnn <: lanetype)), lane_1, lane_2)*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), ADD_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fadd($size((Fnn : Fnn <: numtype)), lane_1, lane_2)*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), SUB_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fsub($size((Fnn : Fnn <: numtype)), lane_1, lane_2)*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), MUL_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fmul($size((Fnn : Fnn <: numtype)), lane_1, lane_2)*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), DIV_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fdiv($size((Fnn : Fnn <: numtype)), lane_1, lane_2)*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), MIN_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fmin($size((Fnn : Fnn <: numtype)), lane_1, lane_2)*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), MAX_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fmax($size((Fnn : Fnn <: numtype)), lane_1, lane_2)*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), PMIN_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fpmin($size((Fnn : Fnn <: numtype)), lane_1, lane_2)*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})])
  ;; 3-numerics.watsup
  def $vbinop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn)*, lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), PMAX_vbinop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (v128 = [$invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), $fpmax($size((Fnn : Fnn <: numtype)), lane_1, lane_2)*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})])

;; 3-numerics.watsup
def $vrelop(shape : shape, vrelop_ : vrelop_(shape), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $vrelop{Jnn : Jnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_3* : iN($lsize((Jnn : Jnn <: lanetype)))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), EQ_vrelop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (lane_3*{lane_3 : iN($lsize((Jnn : Jnn <: lanetype)))} = $ext(1, $lsize((Jnn : Jnn <: lanetype)), S_sx, `%`_iN($ieq($lsize((Jnn : Jnn <: lanetype)), lane_1, lane_2)!`%`_u32.0))*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})
    -- if (v128 = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), lane_3*{lane_3 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))}))
  ;; 3-numerics.watsup
  def $vrelop{Jnn : Jnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_3* : iN($lsize((Jnn : Jnn <: lanetype)))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), NE_vrelop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (lane_3*{lane_3 : iN($lsize((Jnn : Jnn <: lanetype)))} = $ext(1, $lsize((Jnn : Jnn <: lanetype)), S_sx, `%`_iN($ine($lsize((Jnn : Jnn <: lanetype)), lane_1, lane_2)!`%`_u32.0))*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})
    -- if (v128 = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), lane_3*{lane_3 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))}))
  ;; 3-numerics.watsup
  def $vrelop{Jnn : Jnn, N : N, sx : sx, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_3* : iN($lsize((Jnn : Jnn <: lanetype)))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), LT_vrelop_(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (lane_3*{lane_3 : iN($lsize((Jnn : Jnn <: lanetype)))} = $ext(1, $lsize((Jnn : Jnn <: lanetype)), S_sx, `%`_iN($ilt($lsize((Jnn : Jnn <: lanetype)), sx, lane_1, lane_2)!`%`_u32.0))*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})
    -- if (v128 = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), lane_3*{lane_3 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))}))
  ;; 3-numerics.watsup
  def $vrelop{Jnn : Jnn, N : N, sx : sx, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_3* : iN($lsize((Jnn : Jnn <: lanetype)))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), GT_vrelop_(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (lane_3*{lane_3 : iN($lsize((Jnn : Jnn <: lanetype)))} = $ext(1, $lsize((Jnn : Jnn <: lanetype)), S_sx, `%`_iN($igt($lsize((Jnn : Jnn <: lanetype)), sx, lane_1, lane_2)!`%`_u32.0))*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})
    -- if (v128 = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), lane_3*{lane_3 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))}))
  ;; 3-numerics.watsup
  def $vrelop{Jnn : Jnn, N : N, sx : sx, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_3* : iN($lsize((Jnn : Jnn <: lanetype)))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), LE_vrelop_(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (lane_3*{lane_3 : iN($lsize((Jnn : Jnn <: lanetype)))} = $ext(1, $lsize((Jnn : Jnn <: lanetype)), S_sx, `%`_iN($ile($lsize((Jnn : Jnn <: lanetype)), sx, lane_1, lane_2)!`%`_u32.0))*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})
    -- if (v128 = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), lane_3*{lane_3 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))}))
  ;; 3-numerics.watsup
  def $vrelop{Jnn : Jnn, N : N, sx : sx, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*, lane_3* : iN($lsize((Jnn : Jnn <: lanetype)))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), GE_vrelop_(sx), v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (lane_3*{lane_3 : iN($lsize((Jnn : Jnn <: lanetype)))} = $ext(1, $lsize((Jnn : Jnn <: lanetype)), S_sx, `%`_iN($ige($lsize((Jnn : Jnn <: lanetype)), sx, lane_1, lane_2)!`%`_u32.0))*{lane_1 : iN($lsize((Jnn : Jnn <: lanetype))), lane_2 : iN($lsize((Jnn : Jnn <: lanetype)))})
    -- if (v128 = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), lane_3*{lane_3 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))}))
  ;; 3-numerics.watsup
  def $vrelop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_3* : iN($size((Fnn : Fnn <: numtype)))*, Inn : Inn}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), EQ_vrelop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (lane_3*{lane_3 : iN($size((Fnn : Fnn <: numtype)))} = $ext(1, $size((Fnn : Fnn <: numtype)), S_sx, `%`_iN($feq($size((Fnn : Fnn <: numtype)), lane_1, lane_2)!`%`_u32.0))*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})
    -- if ($isize(Inn) = $size((Fnn : Fnn <: numtype)))
    -- if (v128 = $invlanes_(`%X%`_shape((Inn : Inn <: lanetype), `%`_dim(N)), `%`_lane_(lane_3!`%`_iN.0)*{lane_3 : iN($size((Fnn : Fnn <: numtype)))}))
  ;; 3-numerics.watsup
  def $vrelop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_3* : iN($size((Fnn : Fnn <: numtype)))*, Inn : Inn}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), NE_vrelop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (lane_3*{lane_3 : iN($size((Fnn : Fnn <: numtype)))} = $ext(1, $size((Fnn : Fnn <: numtype)), S_sx, `%`_iN($fne($size((Fnn : Fnn <: numtype)), lane_1, lane_2)!`%`_u32.0))*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})
    -- if ($isize(Inn) = $size((Fnn : Fnn <: numtype)))
    -- if (v128 = $invlanes_(`%X%`_shape((Inn : Inn <: lanetype), `%`_dim(N)), `%`_lane_(lane_3!`%`_iN.0)*{lane_3 : iN($size((Fnn : Fnn <: numtype)))}))
  ;; 3-numerics.watsup
  def $vrelop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_3* : iN($size((Fnn : Fnn <: numtype)))*, Inn : Inn}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), LT_vrelop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (lane_3*{lane_3 : iN($size((Fnn : Fnn <: numtype)))} = $ext(1, $size((Fnn : Fnn <: numtype)), S_sx, `%`_iN($flt($size((Fnn : Fnn <: numtype)), lane_1, lane_2)!`%`_u32.0))*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})
    -- if ($isize(Inn) = $size((Fnn : Fnn <: numtype)))
    -- if (v128 = $invlanes_(`%X%`_shape((Inn : Inn <: lanetype), `%`_dim(N)), `%`_lane_(lane_3!`%`_iN.0)*{lane_3 : iN($size((Fnn : Fnn <: numtype)))}))
  ;; 3-numerics.watsup
  def $vrelop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_3* : iN($size((Fnn : Fnn <: numtype)))*, Inn : Inn}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), GT_vrelop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (lane_3*{lane_3 : iN($size((Fnn : Fnn <: numtype)))} = $ext(1, $size((Fnn : Fnn <: numtype)), S_sx, `%`_iN($fgt($size((Fnn : Fnn <: numtype)), lane_1, lane_2)!`%`_u32.0))*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})
    -- if ($isize(Inn) = $size((Fnn : Fnn <: numtype)))
    -- if (v128 = $invlanes_(`%X%`_shape((Inn : Inn <: lanetype), `%`_dim(N)), `%`_lane_(lane_3!`%`_iN.0)*{lane_3 : iN($size((Fnn : Fnn <: numtype)))}))
  ;; 3-numerics.watsup
  def $vrelop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_3* : iN($size((Fnn : Fnn <: numtype)))*, Inn : Inn}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), LE_vrelop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (lane_3*{lane_3 : iN($size((Fnn : Fnn <: numtype)))} = $ext(1, $size((Fnn : Fnn <: numtype)), S_sx, `%`_iN($fle($size((Fnn : Fnn <: numtype)), lane_1, lane_2)!`%`_u32.0))*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})
    -- if ($isize(Inn) = $size((Fnn : Fnn <: numtype)))
    -- if (v128 = $invlanes_(`%X%`_shape((Inn : Inn <: lanetype), `%`_dim(N)), `%`_lane_(lane_3!`%`_iN.0)*{lane_3 : iN($size((Fnn : Fnn <: numtype)))}))
  ;; 3-numerics.watsup
  def $vrelop{Fnn : Fnn, N : N, v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128 : vec_(V128_Vnn), lane_1* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_2* : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))*, lane_3* : iN($size((Fnn : Fnn <: numtype)))*, Inn : Inn}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), GE_vrelop_, v128_1, v128_2) = v128
    -- if (lane_1*{lane_1 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_1))
    -- if (lane_2*{lane_2 : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(N)), v128_2))
    -- if (lane_3*{lane_3 : iN($size((Fnn : Fnn <: numtype)))} = $ext(1, $size((Fnn : Fnn <: numtype)), S_sx, `%`_iN($fge($size((Fnn : Fnn <: numtype)), lane_1, lane_2)!`%`_u32.0))*{lane_1 : fN($size((Fnn : Fnn <: numtype))), lane_2 : fN($size((Fnn : Fnn <: numtype)))})
    -- if ($isize(Inn) = $size((Fnn : Fnn <: numtype)))
    -- if (v128 = $invlanes_(`%X%`_shape((Inn : Inn <: lanetype), `%`_dim(N)), `%`_lane_(lane_3!`%`_iN.0)*{lane_3 : iN($size((Fnn : Fnn <: numtype)))}))

;; 3-numerics.watsup
def $vcvtop(shape_1 : shape, shape_2 : shape, vcvtop_ : vcvtop_(shape_1, shape_2), sx?, lane_ : lane_($lanetype(shape_1))) : lane_($lanetype(shape_2))
  ;; 3-numerics.watsup
  def $vcvtop{N_1 : N, N_2 : N, sx : sx, i8 : lane_($lanetype(`%X%`_shape(I8_lanetype, `%`_dim(N_1)))), i16 : lane_($lanetype(`%X%`_shape(I16_lanetype, `%`_dim(N_2))))}(`%X%`_shape(I8_lanetype, `%`_dim(N_1)), `%X%`_shape(I16_lanetype, `%`_dim(N_2)), EXTEND_vcvtop_, ?(sx), i8) = i16
    -- if (i16 = $ext(8, 16, sx, i8))
  ;; 3-numerics.watsup
  def $vcvtop{N_1 : N, N_2 : N, sx : sx, i16 : lane_($lanetype(`%X%`_shape(I16_lanetype, `%`_dim(N_1)))), i32 : lane_($lanetype(`%X%`_shape(I32_lanetype, `%`_dim(N_2))))}(`%X%`_shape(I16_lanetype, `%`_dim(N_1)), `%X%`_shape(I32_lanetype, `%`_dim(N_2)), EXTEND_vcvtop_, ?(sx), i16) = i32
    -- if (i32 = $ext(16, 32, sx, i16))
  ;; 3-numerics.watsup
  def $vcvtop{N_1 : N, N_2 : N, sx : sx, i32 : lane_($lanetype(`%X%`_shape(I32_lanetype, `%`_dim(N_1)))), i64 : lane_($lanetype(`%X%`_shape(I64_lanetype, `%`_dim(N_2))))}(`%X%`_shape(I32_lanetype, `%`_dim(N_1)), `%X%`_shape(I64_lanetype, `%`_dim(N_2)), EXTEND_vcvtop_, ?(sx), i32) = i64
    -- if (i64 = $ext(32, 64, sx, i32))
  ;; 3-numerics.watsup
  def $vcvtop{N_1 : N, N_2 : N, sx : sx, i32 : lane_($lanetype(`%X%`_shape(I32_lanetype, `%`_dim(N_1)))), f32 : f32}(`%X%`_shape(I32_lanetype, `%`_dim(N_1)), `%X%`_shape(F32_lanetype, `%`_dim(N_2)), CONVERT_vcvtop_, ?(sx), i32) = f32
    -- if (f32 = $convert(32, 32, sx, i32))
  ;; 3-numerics.watsup
  def $vcvtop{N_1 : N, N_2 : N, sx : sx, i32 : lane_($lanetype(`%X%`_shape(I32_lanetype, `%`_dim(N_1)))), f64 : f64}(`%X%`_shape(I32_lanetype, `%`_dim(N_1)), `%X%`_shape(F64_lanetype, `%`_dim(N_2)), CONVERT_vcvtop_, ?(sx), i32) = f64
    -- if (f64 = $convert(32, 64, sx, i32))
  ;; 3-numerics.watsup
  def $vcvtop{N_1 : N, N_2 : N, sx : sx, f32 : f32, i32 : lane_($lanetype(`%X%`_shape(I32_lanetype, `%`_dim(N_2))))}(`%X%`_shape(F32_lanetype, `%`_dim(N_1)), `%X%`_shape(I32_lanetype, `%`_dim(N_2)), TRUNC_SAT_vcvtop_, ?(sx), f32) = i32
    -- if (i32 = $trunc_sat(32, 32, sx, f32))
  ;; 3-numerics.watsup
  def $vcvtop{N_1 : N, N_2 : N, sx : sx, f64 : f64, i32 : lane_($lanetype(`%X%`_shape(I32_lanetype, `%`_dim(N_2))))}(`%X%`_shape(F64_lanetype, `%`_dim(N_1)), `%X%`_shape(I32_lanetype, `%`_dim(N_2)), TRUNC_SAT_vcvtop_, ?(sx), f64) = i32
    -- if (i32 = $trunc_sat(64, 32, sx, f64))
  ;; 3-numerics.watsup
  def $vcvtop{N_1 : N, N_2 : N, sx? : sx?, f64 : f64, f32 : f32}(`%X%`_shape(F64_lanetype, `%`_dim(N_1)), `%X%`_shape(F32_lanetype, `%`_dim(N_2)), DEMOTE_vcvtop_, sx?{sx : sx}, f64) = f32
    -- if (f32 = $demote(64, 32, f64))
  ;; 3-numerics.watsup
  def $vcvtop{N_1 : N, N_2 : N, sx? : sx?, f32 : f32, f64 : f64}(`%X%`_shape(F32_lanetype, `%`_dim(N_1)), `%X%`_shape(F64_lanetype, `%`_dim(N_2)), PROMOTE_vcvtop_, sx?{sx : sx}, f32) = f64
    -- if (f64 = $promote(32, 64, f32))

;; 3-numerics.watsup
def $vextunop(ishape_1 : ishape, ishape_2 : ishape, vextunop_ : vextunop_(ishape_1), sx : sx, vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $vextunop{Inn_1 : Inn, N_1 : N, Inn_2 : Inn, N_2 : N, sx : sx, c_1 : vec_(V128_Vnn), c : vec_(V128_Vnn), cj_1* : iN($lsize((Inn_1 : Inn <: lanetype)))*, cj_2* : iN($lsize((Inn_1 : Inn <: lanetype)))*, ci* : lane_($lanetype(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2))))*}(`%X%`_ishape((Inn_1 : Inn <: Jnn), `%`_dim(N_1)), `%X%`_ishape((Inn_2 : Inn <: Jnn), `%`_dim(N_2)), EXTADD_PAIRWISE_vextunop_, sx, c_1) = c
    -- if (ci*{ci : lane_($lanetype(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2))))} = $lanes_(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2)), c_1))
    -- if ($concat_(syntax iN($lsize((Inn_1 : Inn <: lanetype))), [cj_1 cj_2]*{cj_1 : uN($lsize((Inn_1 : Inn <: lanetype))), cj_2 : uN($lsize((Inn_1 : Inn <: lanetype)))}) = $ext($lsize((Inn_2 : Inn <: lanetype)), $lsize((Inn_1 : Inn <: lanetype)), sx, ci)*{ci : iN($lsize((Inn_2 : Inn <: lanetype)))})
    -- if (c = $invlanes_(`%X%`_shape((Inn_1 : Inn <: lanetype), `%`_dim(N_1)), $iadd($lsize((Inn_1 : Inn <: lanetype)), cj_1, cj_2)*{cj_1 : iN($lsize((Inn_1 : Inn <: lanetype))), cj_2 : iN($lsize((Inn_1 : Inn <: lanetype)))}))

;; 3-numerics.watsup
def $vextbinop(ishape_1 : ishape, ishape_2 : ishape, vextbinop_ : vextbinop_(ishape_1), sx : sx, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $vextbinop{Inn_1 : Inn, N_1 : N, Inn_2 : Inn, N_2 : N, hf : half, sx : sx, c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c : vec_(V128_Vnn), ci_1* : lane_($lanetype(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2))))*, ci_2* : lane_($lanetype(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2))))*}(`%X%`_ishape((Inn_1 : Inn <: Jnn), `%`_dim(N_1)), `%X%`_ishape((Inn_2 : Inn <: Jnn), `%`_dim(N_2)), EXTMUL_vextbinop_(hf), sx, c_1, c_2) = c
    -- if (ci_1*{ci_1 : lane_($lanetype(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2))))} = $lanes_(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2)), c_1)[$half(hf, 0, N_1) : N_1])
    -- if (ci_2*{ci_2 : lane_($lanetype(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2))))} = $lanes_(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2)), c_2)[$half(hf, 0, N_1) : N_1])
    -- if (c = $invlanes_(`%X%`_shape((Inn_1 : Inn <: lanetype), `%`_dim(N_1)), $imul($lsize((Inn_1 : Inn <: lanetype)), $ext($lsize((Inn_2 : Inn <: lanetype)), $lsize((Inn_1 : Inn <: lanetype)), sx, ci_1), $ext($lsize((Inn_2 : Inn <: lanetype)), $lsize((Inn_1 : Inn <: lanetype)), sx, ci_2))*{ci_1 : iN($lsize((Inn_2 : Inn <: lanetype))), ci_2 : iN($lsize((Inn_2 : Inn <: lanetype)))}))
  ;; 3-numerics.watsup
  def $vextbinop{Inn_1 : Inn, N_1 : N, Inn_2 : Inn, N_2 : N, sx : sx, c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c : vec_(V128_Vnn), cj_1* : iN($lsize((Inn_1 : Inn <: lanetype)))*, cj_2* : iN($lsize((Inn_1 : Inn <: lanetype)))*, ci_1* : lane_($lanetype(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2))))*, ci_2* : lane_($lanetype(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2))))*}(`%X%`_ishape((Inn_1 : Inn <: Jnn), `%`_dim(N_1)), `%X%`_ishape((Inn_2 : Inn <: Jnn), `%`_dim(N_2)), DOT_vextbinop_, sx, c_1, c_2) = c
    -- if (ci_1*{ci_1 : lane_($lanetype(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2))))} = $lanes_(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2)), c_1))
    -- if (ci_2*{ci_2 : lane_($lanetype(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2))))} = $lanes_(`%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(N_2)), c_2))
    -- if ($concat_(syntax iN($lsize((Inn_1 : Inn <: lanetype))), [cj_1 cj_2]*{cj_1 : uN($lsize((Inn_1 : Inn <: lanetype))), cj_2 : uN($lsize((Inn_1 : Inn <: lanetype)))}) = $imul($lsize((Inn_1 : Inn <: lanetype)), $ext($lsize((Inn_2 : Inn <: lanetype)), $lsize((Inn_1 : Inn <: lanetype)), S_sx, ci_1), $ext($lsize((Inn_2 : Inn <: lanetype)), $lsize((Inn_1 : Inn <: lanetype)), S_sx, ci_2))*{ci_1 : iN($lsize((Inn_2 : Inn <: lanetype))), ci_2 : iN($lsize((Inn_2 : Inn <: lanetype)))})
    -- if (c = $invlanes_(`%X%`_shape((Inn_1 : Inn <: lanetype), `%`_dim(N_1)), $iadd($lsize((Inn_1 : Inn <: lanetype)), cj_1, cj_2)*{cj_1 : iN($lsize((Inn_1 : Inn <: lanetype))), cj_2 : iN($lsize((Inn_1 : Inn <: lanetype)))}))

;; 3-numerics.watsup
def $vshiftop(ishape : ishape, vshiftop_ : vshiftop_(ishape), lane_ : lane_($lanetype((ishape : ishape <: shape))), u32 : u32) : lane_($lanetype((ishape : ishape <: shape)))
  ;; 3-numerics.watsup
  def $vshiftop{Jnn : Jnn, N : N, lane : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)))), n : n}(`%X%`_ishape(Jnn, `%`_dim(N)), SHL_vshiftop_, lane, `%`_u32(n)) = $ishl($lsize((Jnn : Jnn <: lanetype)), lane, `%`_u32(n))
  ;; 3-numerics.watsup
  def $vshiftop{Jnn : Jnn, N : N, sx : sx, lane : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)))), n : n}(`%X%`_ishape(Jnn, `%`_dim(N)), SHR_vshiftop_(sx), lane, `%`_u32(n)) = $ishr($lsize((Jnn : Jnn <: lanetype)), sx, lane, `%`_u32(n))

;; 4-runtime.watsup
syntax num =
  | CONST{numtype : numtype, num_ : num_(numtype)}(numtype : numtype, num_ : num_(numtype))

;; 4-runtime.watsup
syntax vec =
  | VCONST{vectype : vectype, vec_ : vec_(vectype)}(vectype : vectype, vec_ : vec_(vectype))

;; 4-runtime.watsup
syntax ref =
  | REF.I31_NUM{u31 : u31}(u31 : u31)
  | REF.STRUCT_ADDR{structaddr : structaddr}(structaddr : structaddr)
  | REF.ARRAY_ADDR{arrayaddr : arrayaddr}(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR{funcaddr : funcaddr}(funcaddr : funcaddr)
  | REF.HOST_ADDR{hostaddr : hostaddr}(hostaddr : hostaddr)
  | REF.EXTERN{addrref : addrref}(addrref : addrref)
  | REF.NULL{heaptype : heaptype}(heaptype : heaptype)

;; 4-runtime.watsup
syntax result =
  | _VALS{val* : val*}(val*{val : val} : val*)
  | TRAP

;; 4-runtime.watsup
syntax hostfunc =
  | `...`

;; 4-runtime.watsup
syntax funccode =
  | FUNC{typeidx : typeidx, local* : local*, expr : expr}(typeidx : typeidx, local*{local : local} : local*, expr : expr)
  | `...`

;; 4-runtime.watsup
syntax funcinst =
{
  TYPE{deftype : deftype} deftype,
  MODULE{moduleinst : moduleinst} moduleinst,
  CODE{funccode : funccode} funccode
}

;; 4-runtime.watsup
syntax globalinst =
{
  TYPE{globaltype : globaltype} globaltype,
  VALUE{val : val} val
}

;; 4-runtime.watsup
syntax tableinst =
{
  TYPE{tabletype : tabletype} tabletype,
  REFS{ref* : ref*} ref*
}

;; 4-runtime.watsup
syntax meminst =
{
  TYPE{memtype : memtype} memtype,
  BYTES{byte* : byte*} byte*
}

;; 4-runtime.watsup
syntax eleminst =
{
  TYPE{elemtype : elemtype} elemtype,
  REFS{ref* : ref*} ref*
}

;; 4-runtime.watsup
syntax datainst =
{
  BYTES{byte* : byte*} byte*
}

;; 4-runtime.watsup
syntax packval =
  | PACK{packtype : packtype, iN : iN($psizenn(packtype))}(packtype : packtype, iN : iN($psizenn(packtype)))

;; 4-runtime.watsup
syntax fieldval =
  | CONST{numtype : numtype, num_ : num_(numtype)}(numtype : numtype, num_ : num_(numtype))
  | VCONST{vectype : vectype, vec_ : vec_(vectype)}(vectype : vectype, vec_ : vec_(vectype))
  | REF.NULL{heaptype : heaptype}(heaptype : heaptype)
  | REF.I31_NUM{u31 : u31}(u31 : u31)
  | REF.STRUCT_ADDR{structaddr : structaddr}(structaddr : structaddr)
  | REF.ARRAY_ADDR{arrayaddr : arrayaddr}(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR{funcaddr : funcaddr}(funcaddr : funcaddr)
  | REF.HOST_ADDR{hostaddr : hostaddr}(hostaddr : hostaddr)
  | REF.EXTERN{addrref : addrref}(addrref : addrref)
  | PACK{packtype : packtype, iN : iN($psizenn(packtype))}(packtype : packtype, iN : iN($psizenn(packtype)))

;; 4-runtime.watsup
syntax structinst =
{
  TYPE{deftype : deftype} deftype,
  FIELDS{fieldval* : fieldval*} fieldval*
}

;; 4-runtime.watsup
syntax arrayinst =
{
  TYPE{deftype : deftype} deftype,
  FIELDS{fieldval* : fieldval*} fieldval*
}

;; 4-runtime.watsup
syntax store =
{
  FUNCS{funcinst* : funcinst*} funcinst*,
  GLOBALS{globalinst* : globalinst*} globalinst*,
  TABLES{tableinst* : tableinst*} tableinst*,
  MEMS{meminst* : meminst*} meminst*,
  ELEMS{eleminst* : eleminst*} eleminst*,
  DATAS{datainst* : datainst*} datainst*,
  STRUCTS{structinst* : structinst*} structinst*,
  ARRAYS{arrayinst* : arrayinst*} arrayinst*
}

;; 4-runtime.watsup
syntax state =
  | `%;%`{store : store, frame : frame}(store : store, frame : frame)

;; 4-runtime.watsup
syntax config =
  | `%;%`{state : state, instr* : instr*}(state : state, instr*{instr : instr} : instr*)

;; 5-runtime-aux.watsup
def $inst_valtype(moduleinst : moduleinst, valtype : valtype) : valtype
  ;; 5-runtime-aux.watsup
  def $inst_valtype{moduleinst : moduleinst, t : valtype, dt* : deftype*}(moduleinst, t) = $subst_all_valtype(t, (dt : deftype <: heaptype)*{dt : deftype})
    -- if (dt*{dt : deftype} = moduleinst.TYPES_moduleinst)

;; 5-runtime-aux.watsup
def $inst_reftype(moduleinst : moduleinst, reftype : reftype) : reftype
  ;; 5-runtime-aux.watsup
  def $inst_reftype{moduleinst : moduleinst, rt : reftype, dt* : deftype*}(moduleinst, rt) = $subst_all_reftype(rt, (dt : deftype <: heaptype)*{dt : deftype})
    -- if (dt*{dt : deftype} = moduleinst.TYPES_moduleinst)

;; 5-runtime-aux.watsup
def $default_(valtype : valtype) : val?
  ;; 5-runtime-aux.watsup
  def $default_{Inn : Inn}((Inn : Inn <: valtype)) = ?(CONST_val((Inn : Inn <: numtype), `%`_num_(0)))
  ;; 5-runtime-aux.watsup
  def $default_{Fnn : Fnn}((Fnn : Fnn <: valtype)) = ?(CONST_val((Fnn : Fnn <: numtype), $fzero($size((Fnn : Fnn <: numtype)))))
  ;; 5-runtime-aux.watsup
  def $default_{Vnn : Vnn}((Vnn : Vnn <: valtype)) = ?(VCONST_val(Vnn, `%`_vec_(0)))
  ;; 5-runtime-aux.watsup
  def $default_{ht : heaptype}(REF_valtype(`NULL%?`_nul(?(())), ht)) = ?(REF.NULL_val(ht))
  ;; 5-runtime-aux.watsup
  def $default_{ht : heaptype}(REF_valtype(`NULL%?`_nul(?()), ht)) = ?()

;; 5-runtime-aux.watsup
def $packfield(storagetype : storagetype, val : val) : fieldval
  ;; 5-runtime-aux.watsup
  def $packfield{valtype : valtype, val : val}((valtype : valtype <: storagetype), val) = (val : val <: fieldval)
  ;; 5-runtime-aux.watsup
  def $packfield{packtype : packtype, i : nat}((packtype : packtype <: storagetype), CONST_val(I32_numtype, `%`_num_(i))) = PACK_fieldval(packtype, $wrap(32, $psize(packtype), `%`_iN(i)))

;; 5-runtime-aux.watsup
def $unpackfield(storagetype : storagetype, sx?, fieldval : fieldval) : val
  ;; 5-runtime-aux.watsup
  def $unpackfield{valtype : valtype, val : val}((valtype : valtype <: storagetype), ?(), (val : val <: fieldval)) = val
  ;; 5-runtime-aux.watsup
  def $unpackfield{packtype : packtype, sx : sx, i : nat}((packtype : packtype <: storagetype), ?(sx), PACK_fieldval(packtype, `%`_iN(i))) = CONST_val(I32_numtype, $ext($psize(packtype), 32, sx, `%`_iN(i)))

;; 5-runtime-aux.watsup
rec {

;; 5-runtime-aux.watsup:46.1-46.86
def $funcsxv(externval*) : funcaddr*
  ;; 5-runtime-aux.watsup:51.1-51.24
  def $funcsxv([]) = []
  ;; 5-runtime-aux.watsup:52.1-52.47
  def $funcsxv{fa : funcaddr, xv* : externval*}([FUNC_externval(fa)] :: xv*{xv : externval}) = [fa] :: $funcsxv(xv*{xv : externval})
  ;; 5-runtime-aux.watsup:53.1-53.58
  def $funcsxv{externval : externval, xv* : externval*}([externval] :: xv*{xv : externval}) = $funcsxv(xv*{xv : externval})
    -- otherwise
}

;; 5-runtime-aux.watsup
rec {

;; 5-runtime-aux.watsup:47.1-47.88
def $globalsxv(externval*) : globaladdr*
  ;; 5-runtime-aux.watsup:55.1-55.26
  def $globalsxv([]) = []
  ;; 5-runtime-aux.watsup:56.1-56.53
  def $globalsxv{ga : globaladdr, xv* : externval*}([GLOBAL_externval(ga)] :: xv*{xv : externval}) = [ga] :: $globalsxv(xv*{xv : externval})
  ;; 5-runtime-aux.watsup:57.1-57.62
  def $globalsxv{externval : externval, xv* : externval*}([externval] :: xv*{xv : externval}) = $globalsxv(xv*{xv : externval})
    -- otherwise
}

;; 5-runtime-aux.watsup
rec {

;; 5-runtime-aux.watsup:48.1-48.87
def $tablesxv(externval*) : tableaddr*
  ;; 5-runtime-aux.watsup:59.1-59.25
  def $tablesxv([]) = []
  ;; 5-runtime-aux.watsup:60.1-60.50
  def $tablesxv{ta : tableaddr, xv* : externval*}([TABLE_externval(ta)] :: xv*{xv : externval}) = [ta] :: $tablesxv(xv*{xv : externval})
  ;; 5-runtime-aux.watsup:61.1-61.60
  def $tablesxv{externval : externval, xv* : externval*}([externval] :: xv*{xv : externval}) = $tablesxv(xv*{xv : externval})
    -- otherwise
}

;; 5-runtime-aux.watsup
rec {

;; 5-runtime-aux.watsup:49.1-49.85
def $memsxv(externval*) : memaddr*
  ;; 5-runtime-aux.watsup:63.1-63.23
  def $memsxv([]) = []
  ;; 5-runtime-aux.watsup:64.1-64.44
  def $memsxv{ma : memaddr, xv* : externval*}([MEM_externval(ma)] :: xv*{xv : externval}) = [ma] :: $memsxv(xv*{xv : externval})
  ;; 5-runtime-aux.watsup:65.1-65.56
  def $memsxv{externval : externval, xv* : externval*}([externval] :: xv*{xv : externval}) = $memsxv(xv*{xv : externval})
    -- otherwise
}

;; 5-runtime-aux.watsup
def $store(state : state) : store
  ;; 5-runtime-aux.watsup
  def $store{s : store, f : frame}(`%;%`_state(s, f)) = s

;; 5-runtime-aux.watsup
def $frame(state : state) : frame
  ;; 5-runtime-aux.watsup
  def $frame{s : store, f : frame}(`%;%`_state(s, f)) = f

;; 5-runtime-aux.watsup
def $moduleinst(state : state) : moduleinst
  ;; 5-runtime-aux.watsup
  def $moduleinst{s : store, f : frame}(`%;%`_state(s, f)) = f.MODULE_frame

;; 5-runtime-aux.watsup
def $funcinst(state : state) : funcinst*
  ;; 5-runtime-aux.watsup
  def $funcinst{s : store, f : frame}(`%;%`_state(s, f)) = s.FUNCS_store

;; 5-runtime-aux.watsup
def $globalinst(state : state) : globalinst*
  ;; 5-runtime-aux.watsup
  def $globalinst{s : store, f : frame}(`%;%`_state(s, f)) = s.GLOBALS_store

;; 5-runtime-aux.watsup
def $tableinst(state : state) : tableinst*
  ;; 5-runtime-aux.watsup
  def $tableinst{s : store, f : frame}(`%;%`_state(s, f)) = s.TABLES_store

;; 5-runtime-aux.watsup
def $meminst(state : state) : meminst*
  ;; 5-runtime-aux.watsup
  def $meminst{s : store, f : frame}(`%;%`_state(s, f)) = s.MEMS_store

;; 5-runtime-aux.watsup
def $eleminst(state : state) : eleminst*
  ;; 5-runtime-aux.watsup
  def $eleminst{s : store, f : frame}(`%;%`_state(s, f)) = s.ELEMS_store

;; 5-runtime-aux.watsup
def $datainst(state : state) : datainst*
  ;; 5-runtime-aux.watsup
  def $datainst{s : store, f : frame}(`%;%`_state(s, f)) = s.DATAS_store

;; 5-runtime-aux.watsup
def $structinst(state : state) : structinst*
  ;; 5-runtime-aux.watsup
  def $structinst{s : store, f : frame}(`%;%`_state(s, f)) = s.STRUCTS_store

;; 5-runtime-aux.watsup
def $arrayinst(state : state) : arrayinst*
  ;; 5-runtime-aux.watsup
  def $arrayinst{s : store, f : frame}(`%;%`_state(s, f)) = s.ARRAYS_store

;; 5-runtime-aux.watsup
def $type(state : state, typeidx : typeidx) : deftype
  ;; 5-runtime-aux.watsup
  def $type{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = f.MODULE_frame.TYPES_moduleinst[x!`%`_idx.0]

;; 5-runtime-aux.watsup
def $func(state : state, funcidx : funcidx) : funcinst
  ;; 5-runtime-aux.watsup
  def $func{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.FUNCS_store[f.MODULE_frame.FUNCS_moduleinst[x!`%`_idx.0]]

;; 5-runtime-aux.watsup
def $global(state : state, globalidx : globalidx) : globalinst
  ;; 5-runtime-aux.watsup
  def $global{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.GLOBALS_store[f.MODULE_frame.GLOBALS_moduleinst[x!`%`_idx.0]]

;; 5-runtime-aux.watsup
def $table(state : state, tableidx : tableidx) : tableinst
  ;; 5-runtime-aux.watsup
  def $table{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.TABLES_store[f.MODULE_frame.TABLES_moduleinst[x!`%`_idx.0]]

;; 5-runtime-aux.watsup
def $mem(state : state, memidx : memidx) : meminst
  ;; 5-runtime-aux.watsup
  def $mem{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.MEMS_store[f.MODULE_frame.MEMS_moduleinst[x!`%`_idx.0]]

;; 5-runtime-aux.watsup
def $elem(state : state, tableidx : tableidx) : eleminst
  ;; 5-runtime-aux.watsup
  def $elem{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.ELEMS_store[f.MODULE_frame.ELEMS_moduleinst[x!`%`_idx.0]]

;; 5-runtime-aux.watsup
def $data(state : state, dataidx : dataidx) : datainst
  ;; 5-runtime-aux.watsup
  def $data{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.DATAS_store[f.MODULE_frame.DATAS_moduleinst[x!`%`_idx.0]]

;; 5-runtime-aux.watsup
def $local(state : state, localidx : localidx) : val?
  ;; 5-runtime-aux.watsup
  def $local{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = f.LOCALS_frame[x!`%`_idx.0]

;; 5-runtime-aux.watsup
def $with_local(state : state, localidx : localidx, val : val) : state
  ;; 5-runtime-aux.watsup
  def $with_local{s : store, f : frame, x : idx, v : val}(`%;%`_state(s, f), x, v) = `%;%`_state(s, f[LOCALS_frame[x!`%`_idx.0] = ?(v)])

;; 5-runtime-aux.watsup
def $with_global(state : state, globalidx : globalidx, val : val) : state
  ;; 5-runtime-aux.watsup
  def $with_global{s : store, f : frame, x : idx, v : val}(`%;%`_state(s, f), x, v) = `%;%`_state(s[GLOBALS_store[f.MODULE_frame.GLOBALS_moduleinst[x!`%`_idx.0]].VALUE_globalinst = v], f)

;; 5-runtime-aux.watsup
def $with_table(state : state, tableidx : tableidx, nat : nat, ref : ref) : state
  ;; 5-runtime-aux.watsup
  def $with_table{s : store, f : frame, x : idx, i : nat, r : ref}(`%;%`_state(s, f), x, i, r) = `%;%`_state(s[TABLES_store[f.MODULE_frame.TABLES_moduleinst[x!`%`_idx.0]].REFS_tableinst[i] = r], f)

;; 5-runtime-aux.watsup
def $with_tableinst(state : state, tableidx : tableidx, tableinst : tableinst) : state
  ;; 5-runtime-aux.watsup
  def $with_tableinst{s : store, f : frame, x : idx, ti : tableinst}(`%;%`_state(s, f), x, ti) = `%;%`_state(s[TABLES_store[f.MODULE_frame.TABLES_moduleinst[x!`%`_idx.0]] = ti], f)

;; 5-runtime-aux.watsup
def $with_mem(state : state, memidx : memidx, nat : nat, nat : nat, byte*) : state
  ;; 5-runtime-aux.watsup
  def $with_mem{s : store, f : frame, x : idx, i : nat, j : nat, b* : byte*}(`%;%`_state(s, f), x, i, j, b*{b : byte}) = `%;%`_state(s[MEMS_store[f.MODULE_frame.MEMS_moduleinst[x!`%`_idx.0]].BYTES_meminst[i : j] = b*{b : byte}], f)

;; 5-runtime-aux.watsup
def $with_meminst(state : state, memidx : memidx, meminst : meminst) : state
  ;; 5-runtime-aux.watsup
  def $with_meminst{s : store, f : frame, x : idx, mi : meminst}(`%;%`_state(s, f), x, mi) = `%;%`_state(s[MEMS_store[f.MODULE_frame.MEMS_moduleinst[x!`%`_idx.0]] = mi], f)

;; 5-runtime-aux.watsup
def $with_elem(state : state, elemidx : elemidx, ref*) : state
  ;; 5-runtime-aux.watsup
  def $with_elem{s : store, f : frame, x : idx, r* : ref*}(`%;%`_state(s, f), x, r*{r : ref}) = `%;%`_state(s[ELEMS_store[f.MODULE_frame.ELEMS_moduleinst[x!`%`_idx.0]].REFS_eleminst = r*{r : ref}], f)

;; 5-runtime-aux.watsup
def $with_data(state : state, dataidx : dataidx, byte*) : state
  ;; 5-runtime-aux.watsup
  def $with_data{s : store, f : frame, x : idx, b* : byte*}(`%;%`_state(s, f), x, b*{b : byte}) = `%;%`_state(s[DATAS_store[f.MODULE_frame.DATAS_moduleinst[x!`%`_idx.0]].BYTES_datainst = b*{b : byte}], f)

;; 5-runtime-aux.watsup
def $with_struct(state : state, structaddr : structaddr, nat : nat, fieldval : fieldval) : state
  ;; 5-runtime-aux.watsup
  def $with_struct{s : store, f : frame, a : addr, i : nat, fv : fieldval}(`%;%`_state(s, f), a, i, fv) = `%;%`_state(s[STRUCTS_store[a].FIELDS_structinst[i] = fv], f)

;; 5-runtime-aux.watsup
def $with_array(state : state, arrayaddr : arrayaddr, nat : nat, fieldval : fieldval) : state
  ;; 5-runtime-aux.watsup
  def $with_array{s : store, f : frame, a : addr, i : nat, fv : fieldval}(`%;%`_state(s, f), a, i, fv) = `%;%`_state(s[ARRAYS_store[a].FIELDS_arrayinst[i] = fv], f)

;; 5-runtime-aux.watsup
def $ext_structinst(state : state, structinst*) : state
  ;; 5-runtime-aux.watsup
  def $ext_structinst{s : store, f : frame, si* : structinst*}(`%;%`_state(s, f), si*{si : structinst}) = `%;%`_state(s[STRUCTS_store =.. si*{si : structinst}], f)

;; 5-runtime-aux.watsup
def $ext_arrayinst(state : state, arrayinst*) : state
  ;; 5-runtime-aux.watsup
  def $ext_arrayinst{s : store, f : frame, ai* : arrayinst*}(`%;%`_state(s, f), ai*{ai : arrayinst}) = `%;%`_state(s[ARRAYS_store =.. ai*{ai : arrayinst}], f)

;; 5-runtime-aux.watsup
def $growtable(tableinst : tableinst, nat : nat, ref : ref) : tableinst
  ;; 5-runtime-aux.watsup
  def $growtable{tableinst : tableinst, n : n, r : ref, tableinst' : tableinst, i : nat, j : nat, rt : reftype, r'* : ref*, i' : nat}(tableinst, n, r) = tableinst'
    -- if (tableinst = {TYPE `%%`_tabletype(`[%..%]`_limits(`%`_u32(i), `%`_u32(j)), rt), REFS r'*{r' : ref}})
    -- if (tableinst' = {TYPE `%%`_tabletype(`[%..%]`_limits(`%`_u32(i'), `%`_u32(j)), rt), REFS r'*{r' : ref} :: r^n{}})
    -- if ((i' = (|r'*{r' : ref}| + n)) /\ ((|r'*{r' : ref}| + n) <= j))

;; 5-runtime-aux.watsup
def $growmem(meminst : meminst, nat : nat) : meminst
  ;; 5-runtime-aux.watsup
  def $growmem{meminst : meminst, n : n, meminst' : meminst, i : nat, j : nat, b* : byte*, i' : nat}(meminst, n) = meminst'
    -- if (meminst = {TYPE `%PAGE`_memtype(`[%..%]`_limits(`%`_u32(i), `%`_u32(j))), BYTES b*{b : byte}})
    -- if (meminst' = {TYPE `%PAGE`_memtype(`[%..%]`_limits(`%`_u32(i'), `%`_u32(j))), BYTES b*{b : byte} :: `%`_byte(0)^(n * (64 * $Ki)){}})
    -- if ((i' = ((|b*{b : byte}| / (64 * $Ki)) + n)) /\ (((|b*{b : byte}| / (64 * $Ki)) + n) <= j))

;; 6-typing.watsup
syntax init =
  | SET
  | UNSET

;; 6-typing.watsup
syntax localtype =
  | `%%`{init : init, valtype : valtype}(init : init, valtype : valtype)

;; 6-typing.watsup
syntax instrtype =
  | `%->_%%`{resulttype : resulttype, localidx* : localidx*}(resulttype : resulttype, localidx*{localidx : localidx} : localidx*, resulttype)

;; 6-typing.watsup
syntax context =
{
  TYPES{deftype* : deftype*} deftype*,
  RECS{subtype* : subtype*} subtype*,
  FUNCS{deftype* : deftype*} deftype*,
  GLOBALS{globaltype* : globaltype*} globaltype*,
  TABLES{tabletype* : tabletype*} tabletype*,
  MEMS{memtype* : memtype*} memtype*,
  ELEMS{elemtype* : elemtype*} elemtype*,
  DATAS{datatype* : datatype*} datatype*,
  LOCALS{localtype* : localtype*} localtype*,
  LABELS{resulttype* : resulttype*} resulttype*,
  RETURN{resulttype? : resulttype?} resulttype?,
  REFS{funcidx* : funcidx*} funcidx*
}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:37.1-37.86
def $with_locals(context : context, localidx*, localtype*) : context
  ;; 6-typing.watsup:39.1-39.34
  def $with_locals{C : context}(C, [], []) = C
  ;; 6-typing.watsup:40.1-40.90
  def $with_locals{C : context, x_1 : idx, x* : idx*, lct_1 : localtype, lct* : localtype*}(C, [x_1] :: x*{x : localidx}, [lct_1] :: lct*{lct : localtype}) = $with_locals(C[LOCALS_context[x_1!`%`_idx.0] = lct_1], x*{x : localidx}, lct*{lct : localtype})
}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:46.1-46.94
def $clos_deftypes(deftype*) : deftype*
  ;; 6-typing.watsup:53.1-53.30
  def $clos_deftypes([]) = []
  ;; 6-typing.watsup:54.1-54.101
  def $clos_deftypes{dt* : deftype*, dt_n : deftype, dt'* : deftype*}(dt*{dt : deftype} :: [dt_n]) = dt'*{dt' : deftype} :: [$subst_all_deftype(dt_n, (dt' : deftype <: heaptype)*{dt' : deftype})]
    -- if (dt'*{dt' : deftype} = $clos_deftypes(dt*{dt : deftype}))
}

;; 6-typing.watsup
def $clos_valtype(context : context, valtype : valtype) : valtype
  ;; 6-typing.watsup
  def $clos_valtype{C : context, t : valtype, dt* : deftype*}(C, t) = $subst_all_valtype(t, (dt : deftype <: heaptype)*{dt : deftype})
    -- if (dt*{dt : deftype} = $clos_deftypes(C.TYPES_context))

;; 6-typing.watsup
def $clos_deftype(context : context, deftype : deftype) : deftype
  ;; 6-typing.watsup
  def $clos_deftype{C : context, dt : deftype, dt'* : deftype*}(C, dt) = $subst_all_deftype(dt, (dt' : deftype <: heaptype)*{dt' : deftype})
    -- if (dt'*{dt' : deftype} = $clos_deftypes(C.TYPES_context))

;; 6-typing.watsup
def $clos_moduletype(context : context, moduletype : moduletype) : moduletype
  ;; 6-typing.watsup
  def $clos_moduletype{C : context, mmt : moduletype, dt* : deftype*}(C, mmt) = $subst_all_moduletype(mmt, (dt : deftype <: heaptype)*{dt : deftype})
    -- if (dt*{dt : deftype} = $clos_deftypes(C.TYPES_context))

;; 6-typing.watsup
relation Numtype_ok: `%|-%:OK`(context, numtype)
  ;; 6-typing.watsup
  rule _{C : context, numtype : numtype}:
    `%|-%:OK`(C, numtype)

;; 6-typing.watsup
relation Vectype_ok: `%|-%:OK`(context, vectype)
  ;; 6-typing.watsup
  rule _{C : context, vectype : vectype}:
    `%|-%:OK`(C, vectype)

;; 6-typing.watsup
relation Heaptype_ok: `%|-%:OK`(context, heaptype)
  ;; 6-typing.watsup
  rule abs{C : context, absheaptype : absheaptype}:
    `%|-%:OK`(C, (absheaptype : absheaptype <: heaptype))

  ;; 6-typing.watsup
  rule typeidx{C : context, typeidx : typeidx, dt : deftype}:
    `%|-%:OK`(C, _IDX_heaptype(typeidx))
    -- if (C.TYPES_context[typeidx!`%`_typeidx.0] = dt)

  ;; 6-typing.watsup
  rule rec{C : context, i : nat, st : subtype}:
    `%|-%:OK`(C, REC_heaptype(i))
    -- if (C.RECS_context[i] = st)

;; 6-typing.watsup
relation Reftype_ok: `%|-%:OK`(context, reftype)
  ;; 6-typing.watsup
  rule _{C : context, heaptype : heaptype}:
    `%|-%:OK`(C, REF_reftype(`NULL%?`_nul(()?{}), heaptype))
    -- Heaptype_ok: `%|-%:OK`(C, heaptype)

;; 6-typing.watsup
relation Valtype_ok: `%|-%:OK`(context, valtype)
  ;; 6-typing.watsup
  rule num{C : context, numtype : numtype}:
    `%|-%:OK`(C, (numtype : numtype <: valtype))
    -- Numtype_ok: `%|-%:OK`(C, numtype)

  ;; 6-typing.watsup
  rule vec{C : context, vectype : vectype}:
    `%|-%:OK`(C, (vectype : vectype <: valtype))
    -- Vectype_ok: `%|-%:OK`(C, vectype)

  ;; 6-typing.watsup
  rule ref{C : context, reftype : reftype}:
    `%|-%:OK`(C, (reftype : reftype <: valtype))
    -- Reftype_ok: `%|-%:OK`(C, reftype)

  ;; 6-typing.watsup
  rule bot{C : context}:
    `%|-%:OK`(C, BOT_valtype)

;; 6-typing.watsup
relation Resulttype_ok: `%|-%:OK`(context, resulttype)
  ;; 6-typing.watsup
  rule _{C : context, t* : valtype*}:
    `%|-%:OK`(C, `%`_resulttype(t*{t : valtype}))
    -- (Valtype_ok: `%|-%:OK`(C, t))*{t : valtype}

;; 6-typing.watsup
relation Instrtype_ok: `%|-%:OK`(context, instrtype)
  ;; 6-typing.watsup
  rule _{C : context, t_1* : valtype*, x* : idx*, t_2* : valtype*, lct* : localtype*}:
    `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), x*{x : localidx}, `%`_resulttype(t_2*{t_2 : valtype})))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t_1*{t_1 : valtype}))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t_2*{t_2 : valtype}))
    -- (if (C.LOCALS_context[x!`%`_idx.0] = lct))*{lct : localtype, x : idx}

;; 6-typing.watsup
syntax oktypeidx =
  | OK{typeidx : typeidx}(typeidx : typeidx)

;; 6-typing.watsup
syntax oktypeidxnat =
  | OK{typeidx : typeidx}(typeidx : typeidx, nat)

;; 6-typing.watsup
relation Packtype_ok: `%|-%:OK`(context, packtype)
  ;; 6-typing.watsup
  rule _{C : context, packtype : packtype}:
    `%|-%:OK`(C, packtype)

;; 6-typing.watsup
relation Storagetype_ok: `%|-%:OK`(context, storagetype)
  ;; 6-typing.watsup
  rule val{C : context, valtype : valtype}:
    `%|-%:OK`(C, (valtype : valtype <: storagetype))
    -- Valtype_ok: `%|-%:OK`(C, valtype)

  ;; 6-typing.watsup
  rule pack{C : context, packtype : packtype}:
    `%|-%:OK`(C, (packtype : packtype <: storagetype))
    -- Packtype_ok: `%|-%:OK`(C, packtype)

;; 6-typing.watsup
relation Fieldtype_ok: `%|-%:OK`(context, fieldtype)
  ;; 6-typing.watsup
  rule _{C : context, storagetype : storagetype}:
    `%|-%:OK`(C, `%%`_fieldtype(`MUT%?`_mut(()?{}), storagetype))
    -- Storagetype_ok: `%|-%:OK`(C, storagetype)

;; 6-typing.watsup
relation Functype_ok: `%|-%:OK`(context, functype)
  ;; 6-typing.watsup
  rule _{C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:OK`(C, `%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype})))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t_1*{t_1 : valtype}))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t_2*{t_2 : valtype}))

;; 6-typing.watsup
relation Comptype_ok: `%|-%:OK`(context, comptype)
  ;; 6-typing.watsup
  rule struct{C : context, fieldtype* : fieldtype*}:
    `%|-%:OK`(C, STRUCT_comptype(`%`_structtype(fieldtype*{fieldtype : fieldtype})))
    -- (Fieldtype_ok: `%|-%:OK`(C, fieldtype))*{fieldtype : fieldtype}

  ;; 6-typing.watsup
  rule array{C : context, fieldtype : fieldtype}:
    `%|-%:OK`(C, ARRAY_comptype(fieldtype))
    -- Fieldtype_ok: `%|-%:OK`(C, fieldtype)

  ;; 6-typing.watsup
  rule func{C : context, functype : functype}:
    `%|-%:OK`(C, FUNC_comptype(functype))
    -- Functype_ok: `%|-%:OK`(C, functype)

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

;; 6-typing.watsup:141.1-141.107
relation Deftype_sub: `%|-%<:%`(context, deftype, deftype)
  ;; 6-typing.watsup:452.1-454.66
  rule refl{C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- if ($clos_deftype(C, deftype_1) = $clos_deftype(C, deftype_2))

  ;; 6-typing.watsup:456.1-459.49
  rule super{C : context, deftype_1 : deftype, deftype_2 : deftype, fin : fin, typeuse* : typeuse*, ct : comptype, i : nat}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- if ($unrolldt(deftype_1) = SUB_subtype(fin, typeuse*{typeuse : typeuse}, ct))
    -- Heaptype_sub: `%|-%<:%`(C, (typeuse*{typeuse : typeuse}[i] : typeuse <: heaptype), (deftype_2 : deftype <: heaptype))

;; 6-typing.watsup:289.1-289.104
relation Heaptype_sub: `%|-%<:%`(context, heaptype, heaptype)
  ;; 6-typing.watsup:300.1-301.28
  rule refl{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, heaptype, heaptype)

  ;; 6-typing.watsup:303.1-307.48
  rule trans{C : context, heaptype_1 : heaptype, heaptype_2 : heaptype, heaptype' : heaptype}:
    `%|-%<:%`(C, heaptype_1, heaptype_2)
    -- Heaptype_ok: `%|-%:OK`(C, heaptype')
    -- Heaptype_sub: `%|-%<:%`(C, heaptype_1, heaptype')
    -- Heaptype_sub: `%|-%<:%`(C, heaptype', heaptype_2)

  ;; 6-typing.watsup:309.1-310.17
  rule eq-any{C : context}:
    `%|-%<:%`(C, EQ_heaptype, ANY_heaptype)

  ;; 6-typing.watsup:312.1-313.17
  rule i31-eq{C : context}:
    `%|-%<:%`(C, I31_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:315.1-316.20
  rule struct-eq{C : context}:
    `%|-%<:%`(C, STRUCT_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:318.1-319.19
  rule array-eq{C : context}:
    `%|-%<:%`(C, ARRAY_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:321.1-323.42
  rule struct{C : context, deftype : deftype, fieldtype* : fieldtype*}:
    `%|-%<:%`(C, (deftype : deftype <: heaptype), STRUCT_heaptype)
    -- Expand: `%~~%`(deftype, STRUCT_comptype(`%`_structtype(fieldtype*{fieldtype : fieldtype})))

  ;; 6-typing.watsup:325.1-327.40
  rule array{C : context, deftype : deftype, fieldtype : fieldtype}:
    `%|-%<:%`(C, (deftype : deftype <: heaptype), ARRAY_heaptype)
    -- Expand: `%~~%`(deftype, ARRAY_comptype(fieldtype))

  ;; 6-typing.watsup:329.1-331.38
  rule func{C : context, deftype : deftype, functype : functype}:
    `%|-%<:%`(C, (deftype : deftype <: heaptype), FUNC_heaptype)
    -- Expand: `%~~%`(deftype, FUNC_comptype(functype))

  ;; 6-typing.watsup:333.1-335.46
  rule def{C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, (deftype_1 : deftype <: heaptype), (deftype_2 : deftype <: heaptype))
    -- Deftype_sub: `%|-%<:%`(C, deftype_1, deftype_2)

  ;; 6-typing.watsup:337.1-339.53
  rule typeidx-l{C : context, typeidx : typeidx, heaptype : heaptype}:
    `%|-%<:%`(C, _IDX_heaptype(typeidx), heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, (C.TYPES_context[typeidx!`%`_typeidx.0] : deftype <: heaptype), heaptype)

  ;; 6-typing.watsup:341.1-343.53
  rule typeidx-r{C : context, heaptype : heaptype, typeidx : typeidx}:
    `%|-%<:%`(C, heaptype, _IDX_heaptype(typeidx))
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, (C.TYPES_context[typeidx!`%`_typeidx.0] : deftype <: heaptype))

  ;; 6-typing.watsup:345.1-347.40
  rule rec{C : context, i : nat, typeuse* : typeuse*, j : nat, fin : fin, ct : comptype}:
    `%|-%<:%`(C, REC_heaptype(i), (typeuse*{typeuse : typeuse}[j] : typeuse <: heaptype))
    -- if (C.RECS_context[i] = SUB_subtype(fin, typeuse*{typeuse : typeuse}, ct))

  ;; 6-typing.watsup:349.1-351.40
  rule none{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NONE_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, ANY_heaptype)

  ;; 6-typing.watsup:353.1-355.41
  rule nofunc{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOFUNC_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, FUNC_heaptype)

  ;; 6-typing.watsup:357.1-359.43
  rule noextern{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOEXTERN_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, EXTERN_heaptype)

  ;; 6-typing.watsup:361.1-362.23
  rule bot{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, BOT_heaptype, heaptype)
}

;; 6-typing.watsup
relation Reftype_sub: `%|-%<:%`(context, reftype, reftype)
  ;; 6-typing.watsup
  rule nonnull{C : context, ht_1 : heaptype, ht_2 : heaptype}:
    `%|-%<:%`(C, REF_reftype(`NULL%?`_nul(?()), ht_1), REF_reftype(`NULL%?`_nul(?()), ht_2))
    -- Heaptype_sub: `%|-%<:%`(C, ht_1, ht_2)

  ;; 6-typing.watsup
  rule null{C : context, ht_1 : heaptype, ht_2 : heaptype}:
    `%|-%<:%`(C, REF_reftype(`NULL%?`_nul(()?{}), ht_1), REF_reftype(`NULL%?`_nul(?(())), ht_2))
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
    `%|-%<:%`(C, `%%`_fieldtype(`MUT%?`_mut(?()), zt_1), `%%`_fieldtype(`MUT%?`_mut(?()), zt_2))
    -- Storagetype_sub: `%|-%<:%`(C, zt_1, zt_2)

  ;; 6-typing.watsup
  rule var{C : context, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%<:%`(C, `%%`_fieldtype(`MUT%?`_mut(?(())), zt_1), `%%`_fieldtype(`MUT%?`_mut(?(())), zt_2))
    -- Storagetype_sub: `%|-%<:%`(C, zt_1, zt_2)
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

;; 6-typing.watsup
relation Resulttype_sub: `%|-%<:%`(context, valtype*, valtype*)
  ;; 6-typing.watsup
  rule _{C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%<:%`(C, t_1*{t_1 : valtype}, t_2*{t_2 : valtype})
    -- (Valtype_sub: `%|-%<:%`(C, t_1, t_2))*{t_1 : valtype, t_2 : valtype}

;; 6-typing.watsup
relation Functype_sub: `%|-%<:%`(context, functype, functype)
  ;; 6-typing.watsup
  rule _{C : context, t_11* : valtype*, t_12* : valtype*, t_21* : valtype*, t_22* : valtype*}:
    `%|-%<:%`(C, `%->%`_functype(`%`_resulttype(t_11*{t_11 : valtype}), `%`_resulttype(t_12*{t_12 : valtype})), `%->%`_functype(`%`_resulttype(t_21*{t_21 : valtype}), `%`_resulttype(t_22*{t_22 : valtype})))
    -- Resulttype_sub: `%|-%<:%`(C, t_21*{t_21 : valtype}, t_11*{t_11 : valtype})
    -- Resulttype_sub: `%|-%<:%`(C, t_12*{t_12 : valtype}, t_22*{t_22 : valtype})

;; 6-typing.watsup
relation Comptype_sub: `%|-%<:%`(context, comptype, comptype)
  ;; 6-typing.watsup
  rule struct{C : context, yt_1* : fieldtype*, yt'_1 : fieldtype, yt_2* : fieldtype*}:
    `%|-%<:%`(C, STRUCT_comptype(`%`_structtype(yt_1*{yt_1 : fieldtype} :: [yt'_1])), STRUCT_comptype(`%`_structtype(yt_2*{yt_2 : fieldtype})))
    -- (Fieldtype_sub: `%|-%<:%`(C, yt_1, yt_2))*{yt_1 : fieldtype, yt_2 : fieldtype}

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
  rule _{C : context, typeidx* : typeidx*, comptype : comptype, x_0 : idx, x* : idx*, x'** : idx**, comptype'* : comptype*}:
    `%|-%:%`(C, SUB_subtype(`FINAL%?`_fin(()?{}), ($idx(typeidx) : typevar <: typeuse)*{typeidx : typeidx}, comptype), OK_oktypeidx(x_0))
    -- if (|x*{x : idx}| <= 1)
    -- (if (x!`%`_idx.0 < x_0!`%`_idx.0))*{x : idx}
    -- (if ($unrolldt(C.TYPES_context[x!`%`_idx.0]) = SUB_subtype(`FINAL%?`_fin(?()), ($idx(x') : typevar <: typeuse)*{x' : typeidx}, comptype')))*{comptype' : comptype, x : idx, x' : typeidx}
    -- Comptype_ok: `%|-%:OK`(C, comptype)
    -- (Comptype_sub: `%|-%<:%`(C, comptype, comptype'))*{comptype' : comptype}

;; 6-typing.watsup
def $before(typeuse : typeuse, typeidx : typeidx, nat : nat) : bool
  ;; 6-typing.watsup
  def $before{deftype : deftype, x : idx, i : nat}((deftype : deftype <: typeuse), x, i) = true
  ;; 6-typing.watsup
  def $before{typeidx : typeidx, x : idx, i : nat}(_IDX_typeuse(typeidx), x, i) = (typeidx!`%`_typeidx.0 < x!`%`_idx.0)
  ;; 6-typing.watsup
  def $before{j : nat, x : idx, i : nat}(REC_typeuse(j), x, i) = (j < i)

;; 6-typing.watsup
def $unrollht(context : context, heaptype : heaptype) : subtype
  ;; 6-typing.watsup
  def $unrollht{C : context, deftype : deftype}(C, (deftype : deftype <: heaptype)) = $unrolldt(deftype)
  ;; 6-typing.watsup
  def $unrollht{C : context, typeidx : typeidx}(C, _IDX_heaptype(typeidx)) = $unrolldt(C.TYPES_context[typeidx!`%`_typeidx.0])
  ;; 6-typing.watsup
  def $unrollht{C : context, i : nat}(C, REC_heaptype(i)) = C.RECS_context[i]

;; 6-typing.watsup
relation Subtype_ok2: `%|-%:%`(context, subtype, oktypeidxnat)
  ;; 6-typing.watsup
  rule _{C : context, typeuse* : typeuse*, compttype : comptype, x : idx, i : nat, typeuse'** : typeuse**, comptype'* : comptype*, comptype : comptype}:
    `%|-%:%`(C, SUB_subtype(`FINAL%?`_fin(()?{}), typeuse*{typeuse : typeuse}, compttype), OK_oktypeidxnat(x, i))
    -- if (|typeuse*{typeuse : typeuse}| <= 1)
    -- (if $before(typeuse, x, i))*{typeuse : typeuse}
    -- (if ($unrollht(C, (typeuse : typeuse <: heaptype)) = SUB_subtype(`FINAL%?`_fin(?()), typeuse'*{typeuse' : typeuse}, comptype')))*{comptype' : comptype, typeuse : typeuse, typeuse' : typeuse}
    -- Comptype_ok: `%|-%:OK`(C, comptype)
    -- (Comptype_sub: `%|-%<:%`(C, comptype, comptype'))*{comptype' : comptype}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:136.1-136.105
relation Rectype_ok2: `%|-%:%`(context, rectype, oktypeidxnat)
  ;; 6-typing.watsup:214.1-215.24
  rule empty{C : context, x : idx, i : nat}:
    `%|-%:%`(C, REC_rectype(`%`_list([])), OK_oktypeidxnat(x, i))

  ;; 6-typing.watsup:217.1-220.55
  rule cons{C : context, subtype_1 : subtype, subtype* : subtype*, x : idx, i : nat}:
    `%|-%:%`(C, REC_rectype(`%`_list([subtype_1] :: subtype*{subtype : subtype})), OK_oktypeidxnat(x, i))
    -- Subtype_ok2: `%|-%:%`(C, subtype_1, OK_oktypeidxnat(x, i))
    -- Rectype_ok2: `%|-%:%`(C, REC_rectype(`%`_list(subtype*{subtype : subtype})), OK_oktypeidxnat(`%`_typeidx((x!`%`_idx.0 + 1)), (i + 1)))
}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:134.1-134.102
relation Rectype_ok: `%|-%:%`(context, rectype, oktypeidx)
  ;; 6-typing.watsup:202.1-203.23
  rule empty{C : context, x : idx}:
    `%|-%:%`(C, REC_rectype(`%`_list([])), OK_oktypeidx(x))

  ;; 6-typing.watsup:205.1-208.48
  rule cons{C : context, subtype_1 : subtype, subtype* : subtype*, x : idx}:
    `%|-%:%`(C, REC_rectype(`%`_list([subtype_1] :: subtype*{subtype : subtype})), OK_oktypeidx(x))
    -- Subtype_ok: `%|-%:%`(C, subtype_1, OK_oktypeidx(x))
    -- Rectype_ok: `%|-%:%`(C, REC_rectype(`%`_list(subtype*{subtype : subtype})), OK_oktypeidx(`%`_typeidx((x!`%`_idx.0 + 1))))

  ;; 6-typing.watsup:210.1-212.60
  rule rec2{C : context, subtype* : subtype*, x : idx}:
    `%|-%:%`(C, REC_rectype(`%`_list(subtype*{subtype : subtype})), OK_oktypeidx(x))
    -- Rectype_ok2: `%|-%:%`({TYPES [], RECS subtype*{subtype : subtype}, FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []} ++ C, REC_rectype(`%`_list(subtype*{subtype : subtype})), OK_oktypeidxnat(x, 0))
}

;; 6-typing.watsup
relation Deftype_ok: `%|-%:OK`(context, deftype)
  ;; 6-typing.watsup
  rule _{C : context, rectype : rectype, i : nat, x : idx, subtype^n : subtype^n, n : n}:
    `%|-%:OK`(C, DEF_deftype(rectype, i))
    -- Rectype_ok: `%|-%:%`(C, rectype, OK_oktypeidx(x))
    -- if (rectype = REC_rectype(`%`_list(subtype^n{subtype : subtype})))
    -- if (i < n)

;; 6-typing.watsup
relation Limits_ok: `%|-%:%`(context, limits, nat)
  ;; 6-typing.watsup
  rule _{C : context, n : n, m : m, k : nat}:
    `%|-%:%`(C, `[%..%]`_limits(`%`_u32(n), `%`_u32(m)), k)
    -- if ((n <= m) /\ (m <= k))

;; 6-typing.watsup
relation Globaltype_ok: `%|-%:OK`(context, globaltype)
  ;; 6-typing.watsup
  rule _{C : context, t : valtype}:
    `%|-%:OK`(C, `%%`_globaltype(`MUT%?`_mut(()?{}), t))
    -- Valtype_ok: `%|-%:OK`(C, t)

;; 6-typing.watsup
relation Tabletype_ok: `%|-%:OK`(context, tabletype)
  ;; 6-typing.watsup
  rule _{C : context, limits : limits, reftype : reftype}:
    `%|-%:OK`(C, `%%`_tabletype(limits, reftype))
    -- Limits_ok: `%|-%:%`(C, limits, ((2 ^ 32) - 1))
    -- Reftype_ok: `%|-%:OK`(C, reftype)

;; 6-typing.watsup
relation Memtype_ok: `%|-%:OK`(context, memtype)
  ;; 6-typing.watsup
  rule _{C : context, limits : limits}:
    `%|-%:OK`(C, `%PAGE`_memtype(limits))
    -- Limits_ok: `%|-%:%`(C, limits, (2 ^ 16))

;; 6-typing.watsup
relation Externtype_ok: `%|-%:OK`(context, externtype)
  ;; 6-typing.watsup
  rule func{C : context, deftype : deftype, functype : functype}:
    `%|-%:OK`(C, FUNC_externtype((deftype : deftype <: typeuse)))
    -- Deftype_ok: `%|-%:OK`(C, deftype)
    -- Expand: `%~~%`(deftype, FUNC_comptype(functype))

  ;; 6-typing.watsup
  rule global{C : context, globaltype : globaltype}:
    `%|-%:OK`(C, GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `%|-%:OK`(C, globaltype)

  ;; 6-typing.watsup
  rule table{C : context, tabletype : tabletype}:
    `%|-%:OK`(C, TABLE_externtype(tabletype))
    -- Tabletype_ok: `%|-%:OK`(C, tabletype)

  ;; 6-typing.watsup
  rule mem{C : context, memtype : memtype}:
    `%|-%:OK`(C, MEM_externtype(memtype))
    -- Memtype_ok: `%|-%:OK`(C, memtype)

;; 6-typing.watsup
relation Instrtype_sub: `%|-%<:%`(context, instrtype, instrtype)
  ;; 6-typing.watsup
  rule _{C : context, t_11* : valtype*, x_1* : idx*, t_12* : valtype*, t_21* : valtype*, x_2* : idx*, t_22* : valtype*, x* : idx*, t* : valtype*}:
    `%|-%<:%`(C, `%->_%%`_instrtype(`%`_resulttype(t_11*{t_11 : valtype}), x_1*{x_1 : localidx}, `%`_resulttype(t_12*{t_12 : valtype})), `%->_%%`_instrtype(`%`_resulttype(t_21*{t_21 : valtype}), x_2*{x_2 : localidx}, `%`_resulttype(t_22*{t_22 : valtype})))
    -- Resulttype_sub: `%|-%<:%`(C, t_21*{t_21 : valtype}, t_11*{t_11 : valtype})
    -- Resulttype_sub: `%|-%<:%`(C, t_12*{t_12 : valtype}, t_22*{t_22 : valtype})
    -- if (x*{x : idx} = $setminus(x_2*{x_2 : idx}, x_1*{x_1 : idx}))
    -- (if (C.LOCALS_context[x!`%`_idx.0] = `%%`_localtype(SET_init, t)))*{t : valtype, x : idx}

;; 6-typing.watsup
relation Limits_sub: `%|-%<:%`(context, limits, limits)
  ;; 6-typing.watsup
  rule _{C : context, n_1 : n, m_1 : m, n_2 : n, m_2 : m}:
    `%|-%<:%`(C, `[%..%]`_limits(`%`_u32(n_1), `%`_u32(m_1)), `[%..%]`_limits(`%`_u32(n_2), `%`_u32(m_2)))
    -- if (n_1 >= n_2)
    -- if (m_1 <= m_2)

;; 6-typing.watsup
relation Globaltype_sub: `%|-%<:%`(context, globaltype, globaltype)
  ;; 6-typing.watsup
  rule const{C : context, valtype_1 : valtype, valtype_2 : valtype}:
    `%|-%<:%`(C, `%%`_globaltype(`MUT%?`_mut(?()), valtype_1), `%%`_globaltype(`MUT%?`_mut(?()), valtype_2))
    -- Valtype_sub: `%|-%<:%`(C, valtype_1, valtype_2)

  ;; 6-typing.watsup
  rule var{C : context, valtype_1 : valtype, valtype_2 : valtype}:
    `%|-%<:%`(C, `%%`_globaltype(`MUT%?`_mut(?(())), valtype_1), `%%`_globaltype(`MUT%?`_mut(?(())), valtype_2))
    -- Valtype_sub: `%|-%<:%`(C, valtype_1, valtype_2)
    -- Valtype_sub: `%|-%<:%`(C, valtype_2, valtype_1)

;; 6-typing.watsup
relation Tabletype_sub: `%|-%<:%`(context, tabletype, tabletype)
  ;; 6-typing.watsup
  rule _{C : context, limits_1 : limits, reftype_1 : reftype, limits_2 : limits, reftype_2 : reftype}:
    `%|-%<:%`(C, `%%`_tabletype(limits_1, reftype_1), `%%`_tabletype(limits_2, reftype_2))
    -- Limits_sub: `%|-%<:%`(C, limits_1, limits_2)
    -- Reftype_sub: `%|-%<:%`(C, reftype_1, reftype_2)
    -- Reftype_sub: `%|-%<:%`(C, reftype_2, reftype_1)

;; 6-typing.watsup
relation Memtype_sub: `%|-%<:%`(context, memtype, memtype)
  ;; 6-typing.watsup
  rule _{C : context, limits_1 : limits, limits_2 : limits}:
    `%|-%<:%`(C, `%PAGE`_memtype(limits_1), `%PAGE`_memtype(limits_2))
    -- Limits_sub: `%|-%<:%`(C, limits_1, limits_2)

;; 6-typing.watsup
relation Externtype_sub: `%|-%<:%`(context, externtype, externtype)
  ;; 6-typing.watsup
  rule func{C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, FUNC_externtype((deftype_1 : deftype <: typeuse)), FUNC_externtype((deftype_2 : deftype <: typeuse)))
    -- Deftype_sub: `%|-%<:%`(C, deftype_1, deftype_2)

  ;; 6-typing.watsup
  rule global{C : context, globaltype_1 : globaltype, globaltype_2 : globaltype}:
    `%|-%<:%`(C, GLOBAL_externtype(globaltype_1), GLOBAL_externtype(globaltype_2))
    -- Globaltype_sub: `%|-%<:%`(C, globaltype_1, globaltype_2)

  ;; 6-typing.watsup
  rule table{C : context, tabletype_1 : tabletype, tabletype_2 : tabletype}:
    `%|-%<:%`(C, TABLE_externtype(tabletype_1), TABLE_externtype(tabletype_2))
    -- Tabletype_sub: `%|-%<:%`(C, tabletype_1, tabletype_2)

  ;; 6-typing.watsup
  rule mem{C : context, memtype_1 : memtype, memtype_2 : memtype}:
    `%|-%<:%`(C, MEM_externtype(memtype_1), MEM_externtype(memtype_2))
    -- Memtype_sub: `%|-%<:%`(C, memtype_1, memtype_2)

;; 6-typing.watsup
relation Blocktype_ok: `%|-%:%`(context, blocktype, instrtype)
  ;; 6-typing.watsup
  rule valtype{C : context, valtype? : valtype?}:
    `%|-%:%`(C, _RESULT_blocktype(valtype?{valtype : valtype}), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype(valtype?{valtype : valtype})))
    -- (Valtype_ok: `%|-%:OK`(C, valtype))?{valtype : valtype}

  ;; 6-typing.watsup
  rule typeidx{C : context, typeidx : typeidx, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, _IDX_blocktype(typeidx), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- Expand: `%~~%`(C.TYPES_context[typeidx!`%`_typeidx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype}))))

;; 6-typing.watsup
rec {

;; 6-typing.watsup:523.1-523.95
relation Instr_ok: `%|-%:%`(context, instr, instrtype)
  ;; 6-typing.watsup:562.1-563.24
  rule nop{C : context}:
    `%|-%:%`(C, NOP_instr, `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([])))

  ;; 6-typing.watsup:565.1-567.42
  rule unreachable{C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))

  ;; 6-typing.watsup:569.1-571.29
  rule drop{C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->_%%`_instrtype(`%`_resulttype([t]), [], `%`_resulttype([])))
    -- Valtype_ok: `%|-%:OK`(C, t)

  ;; 6-typing.watsup:574.1-576.29
  rule select-expl{C : context, t : valtype}:
    `%|-%:%`(C, `SELECT()%?`_instr(?([t])), `%->_%%`_instrtype(`%`_resulttype([t t I32_valtype]), [], `%`_resulttype([t])))
    -- Valtype_ok: `%|-%:OK`(C, t)

  ;; 6-typing.watsup:578.1-582.37
  rule select-impl{C : context, t : valtype, t' : valtype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, `SELECT()%?`_instr(?()), `%->_%%`_instrtype(`%`_resulttype([t t I32_valtype]), [], `%`_resulttype([t])))
    -- Valtype_ok: `%|-%:OK`(C, t)
    -- Valtype_sub: `%|-%<:%`(C, t, t')
    -- if ((t' = (numtype : numtype <: valtype)) \/ (t' = (vectype : vectype <: valtype)))

  ;; 6-typing.watsup:598.1-601.63
  rule block{C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr : instr}), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 : valtype})], RETURN ?(), REFS []} ++ C, instr*{instr : instr}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), x*{x : localidx}, `%`_resulttype(t_2*{t_2 : valtype})))

  ;; 6-typing.watsup:603.1-606.63
  rule loop{C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr : instr}), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [`%`_resulttype(t_1*{t_1 : valtype})], RETURN ?(), REFS []} ++ C, instr*{instr : instr}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), x*{x : localidx}, `%`_resulttype(t_2*{t_2 : valtype})))

  ;; 6-typing.watsup:608.1-612.67
  rule if{C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*, x_1* : idx*, x_2* : idx*}:
    `%|-%:%`(C, `IF%%ELSE%`_instr(bt, instr_1*{instr_1 : instr}, instr_2*{instr_2 : instr}), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype} :: [I32_valtype]), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 : valtype})], RETURN ?(), REFS []} ++ C, instr_1*{instr_1 : instr}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), x_1*{x_1 : localidx}, `%`_resulttype(t_2*{t_2 : valtype})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 : valtype})], RETURN ?(), REFS []} ++ C, instr_2*{instr_2 : instr}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), x_2*{x_2 : localidx}, `%`_resulttype(t_2*{t_2 : valtype})))

  ;; 6-typing.watsup:617.1-620.42
  rule br{C : context, l : labelidx, t_1* : valtype*, t* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype} :: t*{t : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t : valtype}))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))

  ;; 6-typing.watsup:622.1-624.25
  rule br_if{C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->_%%`_instrtype(`%`_resulttype(t*{t : valtype} :: [I32_valtype]), [], `%`_resulttype(t*{t : valtype})))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t : valtype}))

  ;; 6-typing.watsup:626.1-630.42
  rule br_table{C : context, l* : labelidx*, l' : labelidx, t_1* : valtype*, t* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l : labelidx}, l'), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype} :: t*{t : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- (Resulttype_sub: `%|-%<:%`(C, t*{t : valtype}, C.LABELS_context[l!`%`_labelidx.0]!`%`_resulttype.0))*{l : labelidx}
    -- Resulttype_sub: `%|-%<:%`(C, t*{t : valtype}, C.LABELS_context[l'!`%`_labelidx.0]!`%`_resulttype.0)
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))

  ;; 6-typing.watsup:632.1-635.31
  rule br_on_null{C : context, l : labelidx, t* : valtype*, ht : heaptype}:
    `%|-%:%`(C, BR_ON_NULL_instr(l), `%->_%%`_instrtype(`%`_resulttype(t*{t : valtype} :: [REF_valtype(`NULL%?`_nul(?(())), ht)]), [], `%`_resulttype(t*{t : valtype} :: [REF_valtype(`NULL%?`_nul(?()), ht)])))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t : valtype}))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:637.1-639.34
  rule br_on_non_null{C : context, l : labelidx, t* : valtype*, ht : heaptype}:
    `%|-%:%`(C, BR_ON_NON_NULL_instr(l), `%->_%%`_instrtype(`%`_resulttype(t*{t : valtype} :: [REF_valtype(`NULL%?`_nul(?(())), ht)]), [], `%`_resulttype(t*{t : valtype})))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t : valtype} :: [REF_valtype(`NULL%?`_nul(?()), ht)]))

  ;; 6-typing.watsup:641.1-647.34
  rule br_on_cast{C : context, l : labelidx, rt_1 : reftype, rt_2 : reftype, t* : valtype*, rt : reftype}:
    `%|-%:%`(C, BR_ON_CAST_instr(l, rt_1, rt_2), `%->_%%`_instrtype(`%`_resulttype(t*{t : valtype} :: [(rt_1 : reftype <: valtype)]), [], `%`_resulttype(t*{t : valtype} :: [($diffrt(rt_1, rt_2) : reftype <: valtype)])))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t : valtype} :: [(rt : reftype <: valtype)]))
    -- Reftype_ok: `%|-%:OK`(C, rt_1)
    -- Reftype_ok: `%|-%:OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt)

  ;; 6-typing.watsup:649.1-655.49
  rule br_on_cast_fail{C : context, l : labelidx, rt_1 : reftype, rt_2 : reftype, t* : valtype*, rt : reftype}:
    `%|-%:%`(C, BR_ON_CAST_FAIL_instr(l, rt_1, rt_2), `%->_%%`_instrtype(`%`_resulttype(t*{t : valtype} :: [(rt_1 : reftype <: valtype)]), [], `%`_resulttype(t*{t : valtype} :: [(rt_2 : reftype <: valtype)])))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t : valtype} :: [(rt : reftype <: valtype)]))
    -- Reftype_ok: `%|-%:OK`(C, rt_1)
    -- Reftype_ok: `%|-%:OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, $diffrt(rt_1, rt_2), rt)

  ;; 6-typing.watsup:660.1-662.47
  rule call{C : context, x : idx, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, CALL_instr(x), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- Expand: `%~~%`(C.FUNCS_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype}))))

  ;; 6-typing.watsup:664.1-666.47
  rule call_ref{C : context, x : idx, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, CALL_REF_instr(($idx(x) : typevar <: typeuse)), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype} :: [REF_valtype(`NULL%?`_nul(?(())), ($idx(x) : typevar <: heaptype))]), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype}))))

  ;; 6-typing.watsup:668.1-672.47
  rule call_indirect{C : context, x : idx, y : idx, t_1* : valtype*, t_2* : valtype*, lim : limits, rt : reftype}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, ($idx(y) : typevar <: typeuse)), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype} :: [I32_valtype]), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`_nul(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPES_context[y!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype}))))

  ;; 6-typing.watsup:674.1-677.42
  rule return{C : context, t_1* : valtype*, t* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype} :: t*{t : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- if (C.RETURN_context = ?(`%`_list(t*{t : valtype})))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))

  ;; 6-typing.watsup:680.1-685.42
  rule return_call{C : context, x : idx, t_3* : valtype*, t_1* : valtype*, t_4* : valtype*, t_2* : valtype*, t'_2* : valtype*}:
    `%|-%:%`(C, RETURN_CALL_instr(x), `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 : valtype} :: t_1*{t_1 : valtype}), [], `%`_resulttype(t_4*{t_4 : valtype})))
    -- Expand: `%~~%`(C.FUNCS_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype}))))
    -- if (C.RETURN_context = ?(`%`_list(t'_2*{t'_2 : valtype})))
    -- Resulttype_sub: `%|-%<:%`(C, t_2*{t_2 : valtype}, t'_2*{t'_2 : valtype})
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 : valtype}), [], `%`_resulttype(t_4*{t_4 : valtype})))

  ;; 6-typing.watsup:688.1-693.42
  rule return_call_ref{C : context, x : idx, t_3* : valtype*, t_1* : valtype*, t_4* : valtype*, t_2* : valtype*, t'_2* : valtype*}:
    `%|-%:%`(C, RETURN_CALL_REF_instr(($idx(x) : typevar <: typeuse)), `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 : valtype} :: t_1*{t_1 : valtype} :: [REF_valtype(`NULL%?`_nul(?(())), ($idx(x) : typevar <: heaptype))]), [], `%`_resulttype(t_4*{t_4 : valtype})))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype}))))
    -- if (C.RETURN_context = ?(`%`_list(t'_2*{t'_2 : valtype})))
    -- Resulttype_sub: `%|-%<:%`(C, t_2*{t_2 : valtype}, t'_2*{t'_2 : valtype})
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 : valtype}), [], `%`_resulttype(t_4*{t_4 : valtype})))

  ;; 6-typing.watsup:696.1-704.42
  rule return_call_indirect{C : context, x : idx, y : idx, t_3* : valtype*, t_1* : valtype*, t_4* : valtype*, lim : limits, rt : reftype, t_2* : valtype*, t'_2* : valtype*}:
    `%|-%:%`(C, RETURN_CALL_INDIRECT_instr(x, ($idx(y) : typevar <: typeuse)), `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 : valtype} :: t_1*{t_1 : valtype} :: [I32_valtype]), [], `%`_resulttype(t_4*{t_4 : valtype})))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`_nul(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPES_context[y!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype}))))
    -- if (C.RETURN_context = ?(`%`_list(t'_2*{t'_2 : valtype})))
    -- Resulttype_sub: `%|-%<:%`(C, t_2*{t_2 : valtype}, t'_2*{t'_2 : valtype})
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 : valtype}), [], `%`_resulttype(t_4*{t_4 : valtype})))

  ;; 6-typing.watsup:709.1-710.33
  rule const{C : context, nt : numtype, c_nt : num_(nt)}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([(nt : numtype <: valtype)])))

  ;; 6-typing.watsup:712.1-713.34
  rule unop{C : context, nt : numtype, unop_nt : unop_(nt)}:
    `%|-%:%`(C, UNOP_instr(nt, unop_nt), `%->_%%`_instrtype(`%`_resulttype([(nt : numtype <: valtype)]), [], `%`_resulttype([(nt : numtype <: valtype)])))

  ;; 6-typing.watsup:715.1-716.39
  rule binop{C : context, nt : numtype, binop_nt : binop_(nt)}:
    `%|-%:%`(C, BINOP_instr(nt, binop_nt), `%->_%%`_instrtype(`%`_resulttype([(nt : numtype <: valtype) (nt : numtype <: valtype)]), [], `%`_resulttype([(nt : numtype <: valtype)])))

  ;; 6-typing.watsup:718.1-719.39
  rule testop{C : context, nt : numtype, testop_nt : testop_(nt)}:
    `%|-%:%`(C, TESTOP_instr(nt, testop_nt), `%->_%%`_instrtype(`%`_resulttype([(nt : numtype <: valtype)]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:721.1-722.40
  rule relop{C : context, nt : numtype, relop_nt : relop_(nt)}:
    `%|-%:%`(C, RELOP_instr(nt, relop_nt), `%->_%%`_instrtype(`%`_resulttype([(nt : numtype <: valtype) (nt : numtype <: valtype)]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:726.1-728.34
  rule cvtop-reinterpret{C : context, nt_1 : numtype, nt_2 : numtype}:
    `%|-%:%`(C, CVTOP_instr(nt_1, nt_2, REINTERPRET_cvtop_, ?()), `%->_%%`_instrtype(`%`_resulttype([(nt_2 : numtype <: valtype)]), [], `%`_resulttype([(nt_1 : numtype <: valtype)])))
    -- if ($size(nt_1) = $size(nt_2))

  ;; 6-typing.watsup:730.1-732.112
  rule cvtop-convert{C : context, nt_1 : numtype, nt_2 : numtype, sx? : sx?, Inn_1 : Inn, Inn_2 : Inn, Fnn_1 : Fnn, Fnn_2 : Fnn}:
    `%|-%:%`(C, CVTOP_instr(nt_1, nt_2, CONVERT_cvtop_, sx?{sx : sx}), `%->_%%`_instrtype(`%`_resulttype([(nt_2 : numtype <: valtype)]), [], `%`_resulttype([(nt_1 : numtype <: valtype)])))
    -- if ((sx?{sx : sx} = ?()) <=> ((((nt_1 = (Inn_1 : Inn <: numtype)) /\ (nt_2 = (Inn_2 : Inn <: numtype))) /\ ($size(nt_1) > $size(nt_2))) \/ ((nt_1 = (Fnn_1 : Fnn <: numtype)) /\ (nt_2 = (Fnn_2 : Fnn <: numtype)))))

  ;; 6-typing.watsup:737.1-739.31
  rule ref.null{C : context, ht : heaptype}:
    `%|-%:%`(C, REF.NULL_instr(ht), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ht)])))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:741.1-744.29
  rule ref.func{C : context, x : idx, dt : deftype, x_1* : idx*, x_2* : idx*}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), (dt : deftype <: heaptype))])))
    -- if (C.FUNCS_context[x!`%`_idx.0] = dt)
    -- if (C.REFS_context = x_1*{x_1 : funcidx} :: [x] :: x_2*{x_2 : funcidx})

  ;; 6-typing.watsup:746.1-747.34
  rule ref.i31{C : context}:
    `%|-%:%`(C, REF.I31_instr, `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), I31_heaptype)])))

  ;; 6-typing.watsup:749.1-751.31
  rule ref.is_null{C : context, ht : heaptype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ht)]), [], `%`_resulttype([I32_valtype])))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:753.1-755.31
  rule ref.as_non_null{C : context, ht : heaptype}:
    `%|-%:%`(C, REF.AS_NON_NULL_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ht)]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), ht)])))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:757.1-758.51
  rule ref.eq{C : context}:
    `%|-%:%`(C, REF.EQ_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), EQ_heaptype) REF_valtype(`NULL%?`_nul(?(())), EQ_heaptype)]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:760.1-764.33
  rule ref.test{C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.TEST_instr(rt), `%->_%%`_instrtype(`%`_resulttype([(rt' : reftype <: valtype)]), [], `%`_resulttype([I32_valtype])))
    -- Reftype_ok: `%|-%:OK`(C, rt)
    -- Reftype_ok: `%|-%:OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; 6-typing.watsup:766.1-770.33
  rule ref.cast{C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.CAST_instr(rt), `%->_%%`_instrtype(`%`_resulttype([(rt' : reftype <: valtype)]), [], `%`_resulttype([(rt : reftype <: valtype)])))
    -- Reftype_ok: `%|-%:OK`(C, rt)
    -- Reftype_ok: `%|-%:OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; 6-typing.watsup:775.1-776.42
  rule i31.get{C : context, sx : sx}:
    `%|-%:%`(C, I31.GET_instr(sx), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), I31_heaptype)]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:781.1-783.44
  rule struct.new{C : context, x : idx, zt* : storagetype*, mut* : mut*}:
    `%|-%:%`(C, STRUCT.NEW_instr(x), `%->_%%`_instrtype(`%`_resulttype($unpack(zt)*{zt : storagetype}), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), ($idx(x) : typevar <: heaptype))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], STRUCT_comptype(`%`_structtype(`%%`_fieldtype(mut, zt)*{mut : mut, zt : storagetype})))

  ;; 6-typing.watsup:785.1-788.40
  rule struct.new_default{C : context, x : idx, mut* : mut*, zt* : storagetype*, val* : val*}:
    `%|-%:%`(C, STRUCT.NEW_DEFAULT_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), ($idx(x) : typevar <: heaptype))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], STRUCT_comptype(`%`_structtype(`%%`_fieldtype(mut, zt)*{mut : mut, zt : storagetype})))
    -- (if ($default_($unpack(zt)) = ?(val)))*{val : val, zt : storagetype}

  ;; 6-typing.watsup:790.1-794.39
  rule struct.get{C : context, sx? : sx?, x : idx, i : nat, zt : storagetype, yt* : fieldtype*, mut : mut}:
    `%|-%:%`(C, STRUCT.GET_instr(sx?{sx : sx}, x, `%`_u32(i)), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ($idx(x) : typevar <: heaptype))]), [], `%`_resulttype([$unpack(zt)])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], STRUCT_comptype(`%`_structtype(yt*{yt : fieldtype})))
    -- if (yt*{yt : fieldtype}[i] = `%%`_fieldtype(mut, zt))
    -- if ((sx?{sx : sx} = ?()) <=> (zt = ($unpack(zt) : valtype <: storagetype)))

  ;; 6-typing.watsup:796.1-799.24
  rule struct.set{C : context, x : idx, i : nat, zt : storagetype, yt* : fieldtype*}:
    `%|-%:%`(C, STRUCT.SET_instr(x, `%`_u32(i)), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ($idx(x) : typevar <: heaptype)) $unpack(zt)]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], STRUCT_comptype(`%`_structtype(yt*{yt : fieldtype})))
    -- if (yt*{yt : fieldtype}[i] = `%%`_fieldtype(`MUT%?`_mut(?(())), zt))

  ;; 6-typing.watsup:804.1-806.42
  rule array.new{C : context, x : idx, zt : storagetype, mut : mut}:
    `%|-%:%`(C, ARRAY.NEW_instr(x), `%->_%%`_instrtype(`%`_resulttype([$unpack(zt) I32_valtype]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), ($idx(x) : typevar <: heaptype))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, zt)))

  ;; 6-typing.watsup:808.1-811.37
  rule array.new_default{C : context, x : idx, mut : mut, zt : storagetype, val : val}:
    `%|-%:%`(C, ARRAY.NEW_DEFAULT_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), ($idx(x) : typevar <: heaptype))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ($default_($unpack(zt)) = ?(val))

  ;; 6-typing.watsup:813.1-815.42
  rule array.new_fixed{C : context, x : idx, n : n, zt : storagetype, mut : mut}:
    `%|-%:%`(C, ARRAY.NEW_FIXED_instr(x, `%`_u32(n)), `%->_%%`_instrtype(`%`_resulttype($unpack(zt)^n{}), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), ($idx(x) : typevar <: heaptype))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, zt)))

  ;; 6-typing.watsup:817.1-820.40
  rule array.new_elem{C : context, x : idx, y : idx, mut : mut, rt : reftype}:
    `%|-%:%`(C, ARRAY.NEW_ELEM_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), ($idx(x) : typevar <: heaptype))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, (rt : reftype <: storagetype))))
    -- Reftype_sub: `%|-%<:%`(C, C.ELEMS_context[y!`%`_idx.0], rt)

  ;; 6-typing.watsup:822.1-826.24
  rule array.new_data{C : context, x : idx, y : idx, mut : mut, zt : storagetype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, ARRAY.NEW_DATA_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), ($idx(x) : typevar <: heaptype))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if (($unpack(zt) = (numtype : numtype <: valtype)) \/ ($unpack(zt) = (vectype : vectype <: valtype)))
    -- if (C.DATAS_context[y!`%`_idx.0] = OK_datatype)

  ;; 6-typing.watsup:828.1-831.39
  rule array.get{C : context, sx? : sx?, x : idx, zt : storagetype, mut : mut}:
    `%|-%:%`(C, ARRAY.GET_instr(sx?{sx : sx}, x), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype]), [], `%`_resulttype([$unpack(zt)])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ((sx?{sx : sx} = ?()) <=> (zt = ($unpack(zt) : valtype <: storagetype)))

  ;; 6-typing.watsup:833.1-835.42
  rule array.set{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.SET_instr(x), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype $unpack(zt)]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(`MUT%?`_mut(?(())), zt)))

  ;; 6-typing.watsup:837.1-839.42
  rule array.len{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.LEN_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ARRAY_heaptype)]), [], `%`_resulttype([I32_valtype])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(`MUT%?`_mut(?(())), zt)))

  ;; 6-typing.watsup:841.1-843.42
  rule array.fill{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.FILL_instr(x), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype $unpack(zt) I32_valtype]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(`MUT%?`_mut(?(())), zt)))

  ;; 6-typing.watsup:845.1-849.40
  rule array.copy{C : context, x_1 : idx, x_2 : idx, zt_1 : storagetype, mut : mut, zt_2 : storagetype}:
    `%|-%:%`(C, ARRAY.COPY_instr(x_1, x_2), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ($idx(x_1) : typevar <: heaptype)) I32_valtype REF_valtype(`NULL%?`_nul(?(())), ($idx(x_2) : typevar <: heaptype)) I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x_1!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(`MUT%?`_mut(?(())), zt_1)))
    -- Expand: `%~~%`(C.TYPES_context[x_2!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, zt_2)))
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

  ;; 6-typing.watsup:851.1-854.44
  rule array.init_elem{C : context, x : idx, y : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.INIT_ELEM_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(`MUT%?`_mut(?(())), zt)))
    -- Storagetype_sub: `%|-%<:%`(C, (C.ELEMS_context[y!`%`_idx.0] : reftype <: storagetype), zt)

  ;; 6-typing.watsup:856.1-860.24
  rule array.init_data{C : context, x : idx, y : idx, zt : storagetype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, ARRAY.INIT_DATA_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ($idx(x) : typevar <: heaptype)) I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(`MUT%?`_mut(?(())), zt)))
    -- if (($unpack(zt) = (numtype : numtype <: valtype)) \/ ($unpack(zt) = (vectype : vectype <: valtype)))
    -- if (C.DATAS_context[y!`%`_idx.0] = OK_datatype)

  ;; 6-typing.watsup:865.1-866.62
  rule extern.convert_any{C : context, nul : nul}:
    `%|-%:%`(C, EXTERN.CONVERT_ANY_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(nul, ANY_heaptype)]), [], `%`_resulttype([REF_valtype(nul, EXTERN_heaptype)])))

  ;; 6-typing.watsup:868.1-869.62
  rule any.convert_extern{C : context, nul : nul}:
    `%|-%:%`(C, ANY.CONVERT_EXTERN_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(nul, EXTERN_heaptype)]), [], `%`_resulttype([REF_valtype(nul, ANY_heaptype)])))

  ;; 6-typing.watsup:874.1-875.35
  rule vconst{C : context, c : vec_(V128_Vnn)}:
    `%|-%:%`(C, VCONST_instr(V128_vectype, c), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:877.1-878.41
  rule vvunop{C : context, vvunop : vvunop}:
    `%|-%:%`(C, VVUNOP_instr(V128_vectype, vvunop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:880.1-881.48
  rule vvbinop{C : context, vvbinop : vvbinop}:
    `%|-%:%`(C, VVBINOP_instr(V128_vectype, vvbinop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:883.1-884.55
  rule vvternop{C : context, vvternop : vvternop}:
    `%|-%:%`(C, VVTERNOP_instr(V128_vectype, vvternop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:886.1-887.44
  rule vvtestop{C : context, vvtestop : vvtestop}:
    `%|-%:%`(C, VVTESTOP_instr(V128_vectype, vvtestop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:889.1-890.37
  rule vunop{C : context, sh : shape, vunop : vunop_(sh)}:
    `%|-%:%`(C, VUNOP_instr(sh, vunop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:892.1-893.44
  rule vbinop{C : context, sh : shape, vbinop : vbinop_(sh)}:
    `%|-%:%`(C, VBINOP_instr(sh, vbinop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:895.1-896.40
  rule vtestop{C : context, sh : shape, vtestop : vtestop_(sh)}:
    `%|-%:%`(C, VTESTOP_instr(sh, vtestop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:898.1-899.44
  rule vrelop{C : context, sh : shape, vrelop : vrelop_(sh)}:
    `%|-%:%`(C, VRELOP_instr(sh, vrelop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:901.1-902.47
  rule vshiftop{C : context, sh : ishape, vshiftop : vshiftop_(sh)}:
    `%|-%:%`(C, VSHIFTOP_instr(sh, vshiftop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype I32_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:904.1-905.33
  rule vbitmask{C : context, sh : ishape}:
    `%|-%:%`(C, VBITMASK_instr(sh), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:907.1-908.39
  rule vswizzle{C : context, sh : ishape}:
    `%|-%:%`(C, VSWIZZLE_instr(sh), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:910.1-912.29
  rule vshuffle{C : context, sh : ishape, i* : nat*}:
    `%|-%:%`(C, VSHUFFLE_instr(sh, `%`_laneidx(i)*{i : nat}), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))
    -- (if (i < (2 * $dim((sh : ishape <: shape))!`%`_dim.0)))*{i : nat}

  ;; 6-typing.watsup:914.1-915.44
  rule vsplat{C : context, sh : shape}:
    `%|-%:%`(C, VSPLAT_instr(sh), `%->_%%`_instrtype(`%`_resulttype([($unpackshape(sh) : numtype <: valtype)]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:918.1-920.21
  rule vextract_lane{C : context, sh : shape, sx? : sx?, i : nat}:
    `%|-%:%`(C, VEXTRACT_LANE_instr(sh, sx?{sx : sx}, `%`_laneidx(i)), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([($unpackshape(sh) : numtype <: valtype)])))
    -- if (i < $dim(sh)!`%`_dim.0)

  ;; 6-typing.watsup:922.1-924.21
  rule vreplace_lane{C : context, sh : shape, i : nat}:
    `%|-%:%`(C, VREPLACE_LANE_instr(sh, `%`_laneidx(i)), `%->_%%`_instrtype(`%`_resulttype([V128_valtype ($unpackshape(sh) : numtype <: valtype)]), [], `%`_resulttype([V128_valtype])))
    -- if (i < $dim(sh)!`%`_dim.0)

  ;; 6-typing.watsup:926.1-927.53
  rule vextunop{C : context, sh_1 : ishape, sh_2 : ishape, vextunop : vextunop_(sh_1), sx : sx}:
    `%|-%:%`(C, VEXTUNOP_instr(sh_1, sh_2, vextunop, sx), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:929.1-930.60
  rule vextbinop{C : context, sh_1 : ishape, sh_2 : ishape, vextbinop : vextbinop_(sh_1), sx : sx}:
    `%|-%:%`(C, VEXTBINOP_instr(sh_1, sh_2, vextbinop, sx), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:932.1-933.48
  rule vnarrow{C : context, sh_1 : ishape, sh_2 : ishape, sx : sx}:
    `%|-%:%`(C, VNARROW_instr(sh_1, sh_2, sx), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:936.1-938.160
  rule vcvtop{C : context, sh_1 : shape, sh_2 : shape, vcvtop : vcvtop_(sh_2, sh_1), hf? : half_(sh_2, sh_1)?, sx? : sx?, zero? : zero_(sh_2, sh_1)?, imm_1 : lanetype, imm_2 : lanetype, Fnn_1 : Fnn, Fnn_2 : Fnn}:
    `%|-%:%`(C, VCVTOP_instr(sh_1, sh_2, vcvtop, hf?{hf : half_(sh_2, sh_1)}, sx?{sx : sx}, zero?{zero : zero_(sh_2, sh_1)}), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([V128_valtype])))
    -- if ((sx?{sx : sx} = ?()) <=> (((($lanetype(sh_1) = imm_1) /\ ($lanetype(sh_2) = imm_2)) /\ ($lsize(imm_1) > $lsize(imm_2))) \/ (($lanetype(sh_1) = (Fnn_1 : Fnn <: lanetype)) /\ ($lanetype(sh_2) = (Fnn_2 : Fnn <: lanetype)))))

  ;; 6-typing.watsup:943.1-945.28
  rule local.get{C : context, x : idx, t : valtype}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([t])))
    -- if (C.LOCALS_context[x!`%`_idx.0] = `%%`_localtype(SET_init, t))

  ;; 6-typing.watsup:947.1-949.29
  rule local.set{C : context, x : idx, t : valtype, init : init}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->_%%`_instrtype(`%`_resulttype([t]), [x], `%`_resulttype([])))
    -- if (C.LOCALS_context[x!`%`_idx.0] = `%%`_localtype(init, t))

  ;; 6-typing.watsup:951.1-953.29
  rule local.tee{C : context, x : idx, t : valtype, init : init}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->_%%`_instrtype(`%`_resulttype([t]), [x], `%`_resulttype([t])))
    -- if (C.LOCALS_context[x!`%`_idx.0] = `%%`_localtype(init, t))

  ;; 6-typing.watsup:958.1-960.29
  rule global.get{C : context, x : idx, t : valtype, mut : mut}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([t])))
    -- if (C.GLOBALS_context[x!`%`_idx.0] = `%%`_globaltype(mut, t))

  ;; 6-typing.watsup:962.1-964.29
  rule global.set{C : context, x : idx, t : valtype}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->_%%`_instrtype(`%`_resulttype([t]), [], `%`_resulttype([])))
    -- if (C.GLOBALS_context[x!`%`_idx.0] = `%%`_globaltype(`MUT%?`_mut(?(())), t))

  ;; 6-typing.watsup:969.1-971.29
  rule table.get{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([(rt : reftype <: valtype)])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))

  ;; 6-typing.watsup:973.1-975.29
  rule table.set{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype (rt : reftype <: valtype)]), [], `%`_resulttype([])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))

  ;; 6-typing.watsup:977.1-979.29
  rule table.size{C : context, x : idx, lim : limits, rt : reftype}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([I32_valtype])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))

  ;; 6-typing.watsup:981.1-983.29
  rule table.grow{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->_%%`_instrtype(`%`_resulttype([(rt : reftype <: valtype) I32_valtype]), [], `%`_resulttype([I32_valtype])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))

  ;; 6-typing.watsup:985.1-987.29
  rule table.fill{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype (rt : reftype <: valtype) I32_valtype]), [], `%`_resulttype([])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))

  ;; 6-typing.watsup:989.1-993.36
  rule table.copy{C : context, x_1 : idx, x_2 : idx, lim_1 : limits, rt_1 : reftype, lim_2 : limits, rt_2 : reftype}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- if (C.TABLES_context[x_1!`%`_idx.0] = `%%`_tabletype(lim_1, rt_1))
    -- if (C.TABLES_context[x_2!`%`_idx.0] = `%%`_tabletype(lim_2, rt_2))
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:995.1-999.36
  rule table.init{C : context, x : idx, y : idx, lim : limits, rt_1 : reftype, rt_2 : reftype}:
    `%|-%:%`(C, TABLE.INIT_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt_1))
    -- if (C.ELEMS_context[y!`%`_idx.0] = rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:1001.1-1003.24
  rule elem.drop{C : context, x : idx, rt : reftype}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([])))
    -- if (C.ELEMS_context[x!`%`_idx.0] = rt)

  ;; 6-typing.watsup:1008.1-1010.23
  rule memory.size{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([I32_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)

  ;; 6-typing.watsup:1012.1-1014.23
  rule memory.grow{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([I32_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)

  ;; 6-typing.watsup:1016.1-1018.23
  rule memory.fill{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)

  ;; 6-typing.watsup:1020.1-1023.27
  rule memory.copy{C : context, x_1 : idx, x_2 : idx, mt_1 : memtype, mt_2 : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr(x_1, x_2), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x_1!`%`_idx.0] = mt_1)
    -- if (C.MEMS_context[x_2!`%`_idx.0] = mt_2)

  ;; 6-typing.watsup:1025.1-1028.24
  rule memory.init{C : context, x : idx, y : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.INIT_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if (C.DATAS_context[y!`%`_idx.0] = OK_datatype)

  ;; 6-typing.watsup:1030.1-1032.24
  rule data.drop{C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([])))
    -- if (C.DATAS_context[x!`%`_idx.0] = OK_datatype)

  ;; 6-typing.watsup:1043.1-1046.43
  rule load-val{C : context, nt : numtype, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, LOAD_instr(nt, ?(), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([(nt : numtype <: valtype)])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= ($size(nt) / 8))

  ;; 6-typing.watsup:1048.1-1051.35
  rule load-pack{C : context, Inn : Inn, M : M, sx : sx, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, LOAD_instr((Inn : Inn <: numtype), ?(`%%`_loadop_(`%`_sz(M), sx)), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([(Inn : Inn <: valtype)])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= (M / 8))

  ;; 6-typing.watsup:1062.1-1065.43
  rule store-val{C : context, nt : numtype, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, STORE_instr(nt, ?(), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype (nt : numtype <: valtype)]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= ($size(nt) / 8))

  ;; 6-typing.watsup:1067.1-1070.35
  rule store-pack{C : context, Inn : Inn, M : M, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, STORE_instr((Inn : Inn <: numtype), ?(`%`_sz(M)), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype (Inn : Inn <: valtype)]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= (M / 8))

  ;; 6-typing.watsup:1072.1-1075.46
  rule vload-val{C : context, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(V128_vectype, ?(), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= ($vsize(V128_vectype) / 8))

  ;; 6-typing.watsup:1077.1-1080.39
  rule vload-pack{C : context, M : M, N : N, sx : sx, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(V128_vectype, ?(`SHAPE%X%%`_vloadop_(`%`_sz(M), N, sx)), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= ((M / 8) * N))

  ;; 6-typing.watsup:1082.1-1085.35
  rule vload-splat{C : context, N : N, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(N))), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= (N / 8))

  ;; 6-typing.watsup:1087.1-1090.34
  rule vload-zero{C : context, N : N, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(N))), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) < (N / 8))

  ;; 6-typing.watsup:1092.1-1096.21
  rule vload_lane{C : context, N : N, x : idx, memarg : memarg, i : nat, mt : memtype}:
    `%|-%:%`(C, VLOAD_LANE_instr(V128_vectype, `%`_sz(N), x, memarg, `%`_laneidx(i)), `%->_%%`_instrtype(`%`_resulttype([I32_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) < (N / 8))
    -- if (i < (128 / N))

  ;; 6-typing.watsup:1098.1-1101.46
  rule vstore{C : context, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, VSTORE_instr(V128_vectype, x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype V128_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= ($vsize(V128_vectype) / 8))

  ;; 6-typing.watsup:1103.1-1107.21
  rule vstore_lane{C : context, N : N, x : idx, memarg : memarg, i : nat, mt : memtype}:
    `%|-%:%`(C, VSTORE_LANE_instr(V128_vectype, `%`_sz(N), x, memarg, `%`_laneidx(i)), `%->_%%`_instrtype(`%`_resulttype([I32_valtype V128_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) < (N / 8))
    -- if (i < (128 / N))

;; 6-typing.watsup:524.1-524.96
relation Instrs_ok: `%|-%:%`(context, instr*, instrtype)
  ;; 6-typing.watsup:537.1-538.24
  rule empty{C : context}:
    `%|-%:%`(C, [], `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([])))

  ;; 6-typing.watsup:541.1-545.82
  rule seq{C : context, instr_1 : instr, instr_2* : instr*, t_1* : valtype*, x_1* : idx*, x_2* : idx*, t_3* : valtype*, t_2* : valtype*, init* : init*, t* : valtype*}:
    `%|-%:%`(C, [instr_1] :: instr_2*{instr_2 : instr}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), x_1*{x_1 : localidx} :: x_2*{x_2 : localidx}, `%`_resulttype(t_3*{t_3 : valtype})))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), x_1*{x_1 : localidx}, `%`_resulttype(t_2*{t_2 : valtype})))
    -- (if (C.LOCALS_context[x_1!`%`_idx.0] = `%%`_localtype(init, t)))*{init : init, t : valtype, x_1 : idx}
    -- Instrs_ok: `%|-%:%`($with_locals(C, x_1*{x_1 : localidx}, `%%`_localtype(SET_init, t)*{t : valtype}), instr_2*{instr_2 : instr}, `%->_%%`_instrtype(`%`_resulttype(t_2*{t_2 : valtype}), x_2*{x_2 : localidx}, `%`_resulttype(t_3*{t_3 : valtype})))

  ;; 6-typing.watsup:547.1-551.33
  rule sub{C : context, instr* : instr*, it' : instrtype, it : instrtype}:
    `%|-%:%`(C, instr*{instr : instr}, it')
    -- Instrs_ok: `%|-%:%`(C, instr*{instr : instr}, it)
    -- Instrtype_sub: `%|-%<:%`(C, it, it')
    -- Instrtype_ok: `%|-%:OK`(C, it')

  ;; 6-typing.watsup:554.1-557.33
  rule frame{C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, x* : idx*, t_2* : valtype*}:
    `%|-%:%`(C, instr*{instr : instr}, `%->_%%`_instrtype(`%`_resulttype(t*{t : valtype} :: t_1*{t_1 : valtype}), x*{x : localidx}, `%`_resulttype(t*{t : valtype} :: t_2*{t_2 : valtype})))
    -- Instrs_ok: `%|-%:%`(C, instr*{instr : instr}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), x*{x : localidx}, `%`_resulttype(t_2*{t_2 : valtype})))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t*{t : valtype}))
}

;; 6-typing.watsup
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 6-typing.watsup
  rule _{C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr : instr}, `%`_resulttype(t*{t : valtype}))
    -- Instrs_ok: `%|-%:%`(C, instr*{instr : instr}, `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype(t*{t : valtype})))

;; 6-typing.watsup
rec {

;; 6-typing.watsup:1163.1-1163.86
def $in_binop(numtype : numtype, binop_ : binop_(numtype), binop_(numtype)*) : bool
  ;; 6-typing.watsup:1164.1-1164.42
  def $in_binop{nt : numtype, binop : binop_(nt), epsilon : binop_(nt)*}(nt, binop, epsilon) = false
  ;; 6-typing.watsup:1165.1-1165.99
  def $in_binop{nt : numtype, binop : binop_(nt), ibinop_1 : binop_(nt), ibinop'* : binop_(nt)*}(nt, binop, [ibinop_1] :: ibinop'*{ibinop' : binop_(nt)}) = ((binop = ibinop_1) \/ $in_binop(nt, binop, ibinop'*{ibinop' : binop_(nt)}))
}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:1159.1-1159.63
def $in_numtype(numtype : numtype, numtype*) : bool
  ;; 6-typing.watsup:1160.1-1160.37
  def $in_numtype{nt : numtype, epsilon : numtype*}(nt, epsilon) = false
  ;; 6-typing.watsup:1161.1-1161.68
  def $in_numtype{nt : numtype, nt_1 : numtype, nt'* : numtype*}(nt, [nt_1] :: nt'*{nt' : numtype}) = ((nt = nt_1) \/ $in_numtype(nt, nt'*{nt' : numtype}))
}

;; 6-typing.watsup
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 6-typing.watsup
  rule const{C : context, nt : numtype, c_nt : num_(nt)}:
    `%|-%CONST`(C, CONST_instr(nt, c_nt))

  ;; 6-typing.watsup
  rule vconst{C : context, vt : vectype, c_vt : vec_(vt)}:
    `%|-%CONST`(C, VCONST_instr(vt, c_vt))

  ;; 6-typing.watsup
  rule ref.null{C : context, ht : heaptype}:
    `%|-%CONST`(C, REF.NULL_instr(ht))

  ;; 6-typing.watsup
  rule ref.i31{C : context}:
    `%|-%CONST`(C, REF.I31_instr)

  ;; 6-typing.watsup
  rule ref.func{C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 6-typing.watsup
  rule struct.new{C : context, x : idx}:
    `%|-%CONST`(C, STRUCT.NEW_instr(x))

  ;; 6-typing.watsup
  rule struct.new_default{C : context, x : idx}:
    `%|-%CONST`(C, STRUCT.NEW_DEFAULT_instr(x))

  ;; 6-typing.watsup
  rule array.new{C : context, x : idx}:
    `%|-%CONST`(C, ARRAY.NEW_instr(x))

  ;; 6-typing.watsup
  rule array.new_default{C : context, x : idx}:
    `%|-%CONST`(C, ARRAY.NEW_DEFAULT_instr(x))

  ;; 6-typing.watsup
  rule array.new_fixed{C : context, x : idx, n : n}:
    `%|-%CONST`(C, ARRAY.NEW_FIXED_instr(x, `%`_u32(n)))

  ;; 6-typing.watsup
  rule any.convert_extern{C : context}:
    `%|-%CONST`(C, ANY.CONVERT_EXTERN_instr)

  ;; 6-typing.watsup
  rule extern.convert_any{C : context}:
    `%|-%CONST`(C, EXTERN.CONVERT_ANY_instr)

  ;; 6-typing.watsup
  rule global.get{C : context, x : idx, t : valtype}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBALS_context[x!`%`_idx.0] = `%%`_globaltype(`MUT%?`_mut(?()), t))

  ;; 6-typing.watsup
  rule binop{C : context, Inn : Inn, binop : binop_((Inn : Inn <: numtype))}:
    `%|-%CONST`(C, BINOP_instr((Inn : Inn <: numtype), binop))
    -- if $in_numtype((Inn : Inn <: numtype), [I32_numtype I64_numtype])
    -- if $in_binop((Inn : Inn <: numtype), binop, [ADD_binop_ SUB_binop_ MUL_binop_])

;; 6-typing.watsup
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 6-typing.watsup
  rule _{C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr : instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr : instr}

;; 6-typing.watsup
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 6-typing.watsup
  rule _{C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, `%`_resulttype([t]))
    -- Expr_const: `%|-%CONST`(C, expr)

;; 6-typing.watsup
relation Type_ok: `%|-%:%`(context, type, deftype*)
  ;; 6-typing.watsup
  rule _{C : context, rectype : rectype, dt* : deftype*, x : idx}:
    `%|-%:%`(C, TYPE_type(rectype), dt*{dt : deftype})
    -- if (x = `%`_idx(|C.TYPES_context|))
    -- if (dt*{dt : deftype} = $rolldt(x, rectype))
    -- Rectype_ok: `%|-%:%`(C[TYPES_context =.. dt*{dt : deftype}], rectype, OK_oktypeidx(x))

;; 6-typing.watsup
relation Local_ok: `%|-%:%`(context, local, localtype)
  ;; 6-typing.watsup
  rule set{C : context, t : valtype}:
    `%|-%:%`(C, LOCAL_local(t), `%%`_localtype(SET_init, t))
    -- if ($default_(t) =/= ?())

  ;; 6-typing.watsup
  rule unset{C : context, t : valtype}:
    `%|-%:%`(C, LOCAL_local(t), `%%`_localtype(UNSET_init, t))
    -- if ($default_(t) = ?())

;; 6-typing.watsup
relation Func_ok: `%|-%:%`(context, func, deftype)
  ;; 6-typing.watsup
  rule _{C : context, x : idx, local* : local*, expr : expr, t_1* : valtype*, t_2* : valtype*, lct* : localtype*}:
    `%|-%:%`(C, FUNC_func(x, local*{local : local}, expr), C.TYPES_context[x!`%`_idx.0])
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype}))))
    -- (Local_ok: `%|-%:%`(C, local, lct))*{lct : localtype, local : local}
    -- Expr_ok: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(`%`_resulttype(t_2*{t_2 : valtype})), REFS []} ++ {TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 : valtype})], RETURN ?(), REFS []} ++ {TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS `%%`_localtype(SET_init, t_1)*{t_1 : valtype} :: lct*{lct : localtype}, LABELS [], RETURN ?(), REFS []} ++ C, expr, `%`_resulttype(t_2*{t_2 : valtype}))

;; 6-typing.watsup
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 6-typing.watsup
  rule _{C : context, globaltype : globaltype, expr : expr, gt : globaltype, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL_global(globaltype, expr), globaltype)
    -- Globaltype_ok: `%|-%:OK`(C, gt)
    -- if (globaltype = `%%`_globaltype(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 6-typing.watsup
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 6-typing.watsup
  rule _{C : context, tabletype : tabletype, expr : expr, tt : tabletype, lim : limits, rt : reftype}:
    `%|-%:%`(C, TABLE_table(tabletype, expr), tabletype)
    -- Tabletype_ok: `%|-%:OK`(C, tt)
    -- if (tabletype = `%%`_tabletype(lim, rt))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, (rt : reftype <: valtype))

;; 6-typing.watsup
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 6-typing.watsup
  rule _{C : context, memtype : memtype}:
    `%|-%:%`(C, MEMORY_mem(memtype), memtype)
    -- Memtype_ok: `%|-%:OK`(C, memtype)

;; 6-typing.watsup
relation Elemmode_ok: `%|-%:%`(context, elemmode, elemtype)
  ;; 6-typing.watsup
  rule active{C : context, x : idx, expr : expr, rt : reftype, lim : limits, rt' : reftype}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt'))
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype)

  ;; 6-typing.watsup
  rule passive{C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; 6-typing.watsup
  rule declare{C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 6-typing.watsup
relation Elem_ok: `%|-%:%`(context, elem, elemtype)
  ;; 6-typing.watsup
  rule _{C : context, elemtype : elemtype, expr* : expr*, elemmode : elemmode}:
    `%|-%:%`(C, ELEM_elem(elemtype, expr*{expr : expr}, elemmode), elemtype)
    -- Reftype_ok: `%|-%:OK`(C, elemtype)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, (elemtype : reftype <: valtype)))*{expr : expr}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, elemtype)

;; 6-typing.watsup
relation Datamode_ok: `%|-%:%`(context, datamode, datatype)
  ;; 6-typing.watsup
  rule active{C : context, x : idx, expr : expr, mt : memtype}:
    `%|-%:%`(C, ACTIVE_datamode(x, expr), OK_datatype)
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype)

  ;; 6-typing.watsup
  rule passive{C : context}:
    `%|-%:%`(C, PASSIVE_datamode, OK_datatype)

;; 6-typing.watsup
relation Data_ok: `%|-%:%`(context, data, datatype)
  ;; 6-typing.watsup
  rule _{C : context, b* : byte*, datamode : datamode}:
    `%|-%:%`(C, DATA_data(b*{b : byte}, datamode), OK_datatype)
    -- Datamode_ok: `%|-%:%`(C, datamode, OK_datatype)

;; 6-typing.watsup
relation Start_ok: `%|-%:OK`(context, start)
  ;; 6-typing.watsup
  rule _{C : context, x : idx}:
    `%|-%:OK`(C, START_start(x))
    -- Expand: `%~~%`(C.FUNCS_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype([]), `%`_resulttype([]))))

;; 6-typing.watsup
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 6-typing.watsup
  rule _{C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT_import(name_1, name_2, xt), xt)
    -- Externtype_ok: `%|-%:OK`(C, xt)

;; 6-typing.watsup
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; 6-typing.watsup
  rule func{C : context, x : idx, dt : deftype}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype((dt : deftype <: typeuse)))
    -- if (C.FUNCS_context[x!`%`_idx.0] = dt)

  ;; 6-typing.watsup
  rule global{C : context, x : idx, gt : globaltype}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (C.GLOBALS_context[x!`%`_idx.0] = gt)

  ;; 6-typing.watsup
  rule table{C : context, x : idx, tt : tabletype}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (C.TABLES_context[x!`%`_idx.0] = tt)

  ;; 6-typing.watsup
  rule mem{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)

;; 6-typing.watsup
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 6-typing.watsup
  rule _{C : context, name : name, externidx : externidx, xt : externtype}:
    `%|-%:%`(C, EXPORT_export(name, externidx), xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 6-typing.watsup
rec {

;; 6-typing.watsup:1308.1-1308.100
relation Globals_ok: `%|-%:%`(context, global*, globaltype*)
  ;; 6-typing.watsup:1350.1-1351.17
  rule empty{C : context}:
    `%|-%:%`(C, [], [])

  ;; 6-typing.watsup:1353.1-1356.55
  rule cons{C : context, global_1 : global, global : global, gt_1 : globaltype, gt* : globaltype*}:
    `%|-%:%`(C, [global_1] :: global*{}, [gt_1] :: gt*{gt : globaltype})
    -- Global_ok: `%|-%:%`(C, global, gt_1)
    -- Globals_ok: `%|-%:%`(C[GLOBALS_context =.. [gt_1]], global*{}, gt*{gt : globaltype})
}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:1307.1-1307.98
relation Types_ok: `%|-%:%`(context, type*, deftype*)
  ;; 6-typing.watsup:1342.1-1343.17
  rule empty{C : context}:
    `%|-%:%`(C, [], [])

  ;; 6-typing.watsup:1345.1-1348.50
  rule cons{C : context, type_1 : type, type* : type*, dt_1* : deftype*, dt* : deftype*}:
    `%|-%:%`(C, [type_1] :: type*{type : type}, dt_1*{dt_1 : deftype} :: dt*{dt : deftype})
    -- Type_ok: `%|-%:%`(C, type_1, dt_1*{dt_1 : deftype})
    -- Types_ok: `%|-%:%`(C[TYPES_context =.. dt_1*{dt_1 : deftype}], type*{type : type}, dt*{dt : deftype})
}

;; 6-typing.watsup
syntax nonfuncs =
  | `%%%%%`{global* : global*, table* : table*, mem* : mem*, elem* : elem*, data* : data*}(global*{global : global} : global*, table*{table : table} : table*, mem*{mem : mem} : mem*, elem*{elem : elem} : elem*, data*{data : data} : data*)

;; 6-typing.watsup
def $funcidx_nonfuncs(nonfuncs : nonfuncs) : funcidx*
  ;; 6-typing.watsup
  def $funcidx_nonfuncs{global* : global*, table* : table*, mem* : mem*, elem* : elem*, data* : data*}(`%%%%%`_nonfuncs(global*{global : global}, table*{table : table}, mem*{mem : mem}, elem*{elem : elem}, data*{data : data})) = $funcidx_module(MODULE_module([], [], [], global*{global : global}, table*{table : table}, mem*{mem : mem}, elem*{elem : elem}, data*{data : data}, [], []))

;; 6-typing.watsup
relation Module_ok: `|-%:%`(module, moduletype)
  ;; 6-typing.watsup
  rule _{type* : type*, import* : import*, func* : func*, global* : global*, table* : table*, mem* : mem*, elem* : elem*, data* : data*, start? : start?, export* : export*, C : context, xt_I* : externtype*, xt_E* : externtype*, dt'* : deftype*, C' : context, gt* : globaltype*, tt* : tabletype*, mt* : memtype*, dt* : deftype*, rt* : reftype*, ok* : datatype*, dt_I* : deftype*, gt_I* : globaltype*, tt_I* : tabletype*, mt_I* : memtype*, x* : idx*}:
    `|-%:%`(MODULE_module(type*{type : type}, import*{import : import}, func*{func : func}, global*{global : global}, table*{table : table}, mem*{mem : mem}, elem*{elem : elem}, data*{data : data}, start?{start : start}, export*{export : export}), $clos_moduletype(C, `%->%`_moduletype(xt_I*{xt_I : externtype}, xt_E*{xt_E : externtype})))
    -- Types_ok: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, type*{type : type}, dt'*{dt' : deftype})
    -- (Import_ok: `%|-%:%`({TYPES dt'*{dt' : deftype}, RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, import, xt_I))*{import : import, xt_I : externtype}
    -- Globals_ok: `%|-%:%`(C', global*{global : global}, gt*{gt : globaltype})
    -- (Table_ok: `%|-%:%`(C', table, tt))*{table : table, tt : tabletype}
    -- (Mem_ok: `%|-%:%`(C', mem, mt))*{mem : mem, mt : memtype}
    -- (Func_ok: `%|-%:%`(C, func, dt))*{dt : deftype, func : func}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem : elem, rt : elemtype}
    -- (Data_ok: `%|-%:%`(C, data, ok))*{data : data, ok : datatype}
    -- (Start_ok: `%|-%:OK`(C, start))?{start : start}
    -- (Export_ok: `%|-%:%`(C, export, xt_E))*{export : export, xt_E : externtype}
    -- if (C = {TYPES dt'*{dt' : deftype}, RECS [], FUNCS dt_I*{dt_I : deftype} :: dt*{dt : deftype}, GLOBALS gt_I*{gt_I : globaltype} :: gt*{gt : globaltype}, TABLES tt_I*{tt_I : tabletype} :: tt*{tt : tabletype}, MEMS mt_I*{mt_I : memtype} :: mt*{mt : memtype}, ELEMS rt*{rt : elemtype}, DATAS ok*{ok : datatype}, LOCALS [], LABELS [], RETURN ?(), REFS x*{x : funcidx}})
    -- if (C' = {TYPES dt'*{dt' : deftype}, RECS [], FUNCS dt_I*{dt_I : deftype} :: dt*{dt : deftype}, GLOBALS gt_I*{gt_I : globaltype}, TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS x*{x : funcidx}})
    -- if (x*{x : idx} = $funcidx_nonfuncs(`%%%%%`_nonfuncs(global*{global : global}, table*{table : table}, mem*{mem : mem}, elem*{elem : elem}, data*{data : data})))
    -- if (dt_I*{dt_I : deftype} = $funcsxt(xt_I*{xt_I : externtype}))
    -- if (gt_I*{gt_I : globaltype} = $globalsxt(xt_I*{xt_I : externtype}))
    -- if (tt_I*{tt_I : tabletype} = $tablesxt(xt_I*{xt_I : externtype}))
    -- if (mt_I*{mt_I : memtype} = $memsxt(xt_I*{xt_I : externtype}))

;; 7-runtime-typing.watsup
relation Num_type: `%|-%:%`(store, num, numtype)
  ;; 7-runtime-typing.watsup
  rule _{s : store, nt : numtype, c : num_(nt)}:
    `%|-%:%`(s, CONST_num(nt, c), nt)

;; 7-runtime-typing.watsup
relation Vec_type: `%|-%:%`(store, vec, vectype)
  ;; 7-runtime-typing.watsup
  rule _{s : store, vt : vectype, c : vec_(vt)}:
    `%|-%:%`(s, VCONST_vec(vt, c), vt)

;; 7-runtime-typing.watsup
rec {

;; 7-runtime-typing.watsup:7.1-7.42
relation Ref_type: `%|-%:%`(store, ref, reftype)
  ;; 7-runtime-typing.watsup:17.1-18.35
  rule null{s : store, ht : heaptype}:
    `%|-%:%`(s, REF.NULL_ref(ht), REF_reftype(`NULL%?`_nul(?(())), ht))

  ;; 7-runtime-typing.watsup:20.1-21.37
  rule i31{s : store, i : nat}:
    `%|-%:%`(s, REF.I31_NUM_ref(`%`_u31(i)), REF_reftype(`NULL%?`_nul(?()), I31_heaptype))

  ;; 7-runtime-typing.watsup:23.1-25.31
  rule struct{s : store, a : addr, dt : deftype}:
    `%|-%:%`(s, REF.STRUCT_ADDR_ref(a), REF_reftype(`NULL%?`_nul(?()), (dt : deftype <: heaptype)))
    -- if (s.STRUCTS_store[a].TYPE_structinst = dt)

  ;; 7-runtime-typing.watsup:27.1-29.30
  rule array{s : store, a : addr, dt : deftype}:
    `%|-%:%`(s, REF.ARRAY_ADDR_ref(a), REF_reftype(`NULL%?`_nul(?()), (dt : deftype <: heaptype)))
    -- if (s.ARRAYS_store[a].TYPE_arrayinst = dt)

  ;; 7-runtime-typing.watsup:31.1-33.29
  rule func{s : store, a : addr, dt : deftype}:
    `%|-%:%`(s, REF.FUNC_ADDR_ref(a), REF_reftype(`NULL%?`_nul(?()), (dt : deftype <: heaptype)))
    -- if (s.FUNCS_store[a].TYPE_funcinst = dt)

  ;; 7-runtime-typing.watsup:35.1-36.39
  rule host{s : store, a : addr}:
    `%|-%:%`(s, REF.HOST_ADDR_ref(a), REF_reftype(`NULL%?`_nul(?()), ANY_heaptype))

  ;; 7-runtime-typing.watsup:38.1-39.45
  rule extern{s : store, addrref : addrref}:
    `%|-%:%`(s, REF.EXTERN_ref(addrref), REF_reftype(`NULL%?`_nul(?()), EXTERN_heaptype))

  ;; 7-runtime-typing.watsup:41.1-44.34
  rule sub{s : store, ref : ref, rt : reftype, rt' : reftype}:
    `%|-%:%`(s, ref, rt)
    -- Ref_type: `%|-%:%`(s, ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt', rt)
}

;; 7-runtime-typing.watsup
relation Val_type: `%|-%:%`(store, val, valtype)
  ;; 7-runtime-typing.watsup
  rule num{s : store, num : num, nt : numtype}:
    `%|-%:%`(s, (num : num <: val), (nt : numtype <: valtype))
    -- Num_type: `%|-%:%`(s, num, nt)

  ;; 7-runtime-typing.watsup
  rule vec{s : store, vec : vec, vt : vectype}:
    `%|-%:%`(s, (vec : vec <: val), (vt : vectype <: valtype))
    -- Vec_type: `%|-%:%`(s, vec, vt)

  ;; 7-runtime-typing.watsup
  rule ref{s : store, ref : ref, rt : reftype}:
    `%|-%:%`(s, (ref : ref <: val), (rt : reftype <: valtype))
    -- Ref_type: `%|-%:%`(s, ref, rt)

;; 7-runtime-typing.watsup
rec {

;; 7-runtime-typing.watsup:64.1-64.57
relation Externval_type: `%|-%:%`(store, externval, externtype)
  ;; 7-runtime-typing.watsup:66.1-68.30
  rule func{s : store, a : addr, funcinst : funcinst}:
    `%|-%:%`(s, FUNC_externval(a), FUNC_externtype((funcinst.TYPE_funcinst : deftype <: typeuse)))
    -- if (s.FUNCS_store[a] = funcinst)

  ;; 7-runtime-typing.watsup:70.1-72.34
  rule global{s : store, a : addr, globalinst : globalinst}:
    `%|-%:%`(s, GLOBAL_externval(a), GLOBAL_externtype(globalinst.TYPE_globalinst))
    -- if (s.GLOBALS_store[a] = globalinst)

  ;; 7-runtime-typing.watsup:74.1-76.32
  rule table{s : store, a : addr, tableinst : tableinst}:
    `%|-%:%`(s, TABLE_externval(a), TABLE_externtype(tableinst.TYPE_tableinst))
    -- if (s.TABLES_store[a] = tableinst)

  ;; 7-runtime-typing.watsup:78.1-80.28
  rule mem{s : store, a : addr, meminst : meminst}:
    `%|-%:%`(s, MEM_externval(a), MEM_externtype(meminst.TYPE_meminst))
    -- if (s.MEMS_store[a] = meminst)

  ;; 7-runtime-typing.watsup:82.1-85.37
  rule sub{s : store, externval : externval, xt : externtype, xt' : externtype}:
    `%|-%:%`(s, externval, xt)
    -- Externval_type: `%|-%:%`(s, externval, xt')
    -- Externtype_sub: `%|-%<:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, xt', xt)
}

;; 8-reduction.watsup
relation Step_pure: `%~>%`(instr*, instr*)
  ;; 8-reduction.watsup
  rule unreachable:
    `%~>%`([UNREACHABLE_instr], [TRAP_instr])

  ;; 8-reduction.watsup
  rule nop:
    `%~>%`([NOP_instr], [])

  ;; 8-reduction.watsup
  rule drop{val : val}:
    `%~>%`([(val : val <: instr) DROP_instr], [])

  ;; 8-reduction.watsup
  rule select-true{val_1 : val, val_2 : val, c : num_(I32_numtype), t*? : valtype*?}:
    `%~>%`([(val_1 : val <: instr) (val_2 : val <: instr) CONST_instr(I32_numtype, c) `SELECT()%?`_instr(t*{t : valtype}?{t : valtype})], [(val_1 : val <: instr)])
    -- if (c =/= `%`_num_(0))

  ;; 8-reduction.watsup
  rule select-false{val_1 : val, val_2 : val, c : num_(I32_numtype), t*? : valtype*?}:
    `%~>%`([(val_1 : val <: instr) (val_2 : val <: instr) CONST_instr(I32_numtype, c) `SELECT()%?`_instr(t*{t : valtype}?{t : valtype})], [(val_2 : val <: instr)])
    -- if (c = `%`_num_(0))

  ;; 8-reduction.watsup
  rule if-true{c : num_(I32_numtype), bt : blocktype, instr_1* : instr*, instr_2* : instr*}:
    `%~>%`([CONST_instr(I32_numtype, c) `IF%%ELSE%`_instr(bt, instr_1*{instr_1 : instr}, instr_2*{instr_2 : instr})], [BLOCK_instr(bt, instr_1*{instr_1 : instr})])
    -- if (c =/= `%`_num_(0))

  ;; 8-reduction.watsup
  rule if-false{c : num_(I32_numtype), bt : blocktype, instr_1* : instr*, instr_2* : instr*}:
    `%~>%`([CONST_instr(I32_numtype, c) `IF%%ELSE%`_instr(bt, instr_1*{instr_1 : instr}, instr_2*{instr_2 : instr})], [BLOCK_instr(bt, instr_2*{instr_2 : instr})])
    -- if (c = `%`_num_(0))

  ;; 8-reduction.watsup
  rule label-vals{n : n, instr* : instr*, val* : val*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr*{instr : instr}, (val : val <: instr)*{val : val})], (val : val <: instr)*{val : val})

  ;; 8-reduction.watsup
  rule br-zero{n : n, instr'* : instr*, val'* : val*, val^n : val^n, l : labelidx, instr* : instr*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr'*{instr' : instr}, (val' : val <: instr)*{val' : val} :: (val : val <: instr)^n{val : val} :: [BR_instr(l)] :: instr*{instr : instr})], (val : val <: instr)^n{val : val} :: instr'*{instr' : instr})
    -- if (l = `%`_labelidx(0))

  ;; 8-reduction.watsup
  rule br-succ{n : n, instr'* : instr*, val* : val*, l : labelidx, instr* : instr*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr'*{instr' : instr}, (val : val <: instr)*{val : val} :: [BR_instr(l)] :: instr*{instr : instr})], (val : val <: instr)*{val : val} :: [BR_instr(`%`_labelidx((l!`%`_labelidx.0 - 1)))])
    -- if (l!`%`_labelidx.0 > 0)

  ;; 8-reduction.watsup
  rule br_if-true{c : num_(I32_numtype), l : labelidx}:
    `%~>%`([CONST_instr(I32_numtype, c) BR_IF_instr(l)], [BR_instr(l)])
    -- if (c =/= `%`_num_(0))

  ;; 8-reduction.watsup
  rule br_if-false{c : num_(I32_numtype), l : labelidx}:
    `%~>%`([CONST_instr(I32_numtype, c) BR_IF_instr(l)], [])
    -- if (c = `%`_num_(0))

  ;; 8-reduction.watsup
  rule br_table-lt{i : nat, l* : labelidx*, l' : labelidx}:
    `%~>%`([CONST_instr(I32_numtype, `%`_num_(i)) BR_TABLE_instr(l*{l : labelidx}, l')], [BR_instr(l*{l : labelidx}[i])])
    -- if (i < |l*{l : labelidx}|)

  ;; 8-reduction.watsup
  rule br_table-ge{i : nat, l* : labelidx*, l' : labelidx}:
    `%~>%`([CONST_instr(I32_numtype, `%`_num_(i)) BR_TABLE_instr(l*{l : labelidx}, l')], [BR_instr(l')])
    -- if (i >= |l*{l : labelidx}|)

  ;; 8-reduction.watsup
  rule br_on_null-null{val : val, l : labelidx, ht : heaptype}:
    `%~>%`([(val : val <: instr) BR_ON_NULL_instr(l)], [BR_instr(l)])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup
  rule br_on_null-addr{val : val, l : labelidx}:
    `%~>%`([(val : val <: instr) BR_ON_NULL_instr(l)], [(val : val <: instr)])
    -- otherwise

  ;; 8-reduction.watsup
  rule br_on_non_null-null{val : val, l : labelidx, ht : heaptype}:
    `%~>%`([(val : val <: instr) BR_ON_NON_NULL_instr(l)], [])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup
  rule br_on_non_null-addr{val : val, l : labelidx}:
    `%~>%`([(val : val <: instr) BR_ON_NON_NULL_instr(l)], [(val : val <: instr) BR_instr(l)])
    -- otherwise

  ;; 8-reduction.watsup
  rule call_indirect{x : idx, yy : typeuse}:
    `%~>%`([CALL_INDIRECT_instr(x, yy)], [TABLE.GET_instr(x) REF.CAST_instr(REF_reftype(`NULL%?`_nul(?(())), (yy : typeuse <: heaptype))) CALL_REF_instr(yy)])

  ;; 8-reduction.watsup
  rule return_call_indirect{x : idx, yy : typeuse}:
    `%~>%`([RETURN_CALL_INDIRECT_instr(x, yy)], [TABLE.GET_instr(x) REF.CAST_instr(REF_reftype(`NULL%?`_nul(?(())), (yy : typeuse <: heaptype))) RETURN_CALL_REF_instr(yy)])

  ;; 8-reduction.watsup
  rule frame-vals{n : n, f : frame, val^n : val^n}:
    `%~>%`([`FRAME_%{%}%`_instr(n, f, (val : val <: instr)^n{val : val})], (val : val <: instr)^n{val : val})

  ;; 8-reduction.watsup
  rule return-frame{n : n, f : frame, val'* : val*, val^n : val^n, instr* : instr*}:
    `%~>%`([`FRAME_%{%}%`_instr(n, f, (val' : val <: instr)*{val' : val} :: (val : val <: instr)^n{val : val} :: [RETURN_instr] :: instr*{instr : instr})], (val : val <: instr)^n{val : val})

  ;; 8-reduction.watsup
  rule return-label{n : n, instr'* : instr*, val* : val*, instr* : instr*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr'*{instr' : instr}, (val : val <: instr)*{val : val} :: [RETURN_instr] :: instr*{instr : instr})], (val : val <: instr)*{val : val} :: [RETURN_instr])

  ;; 8-reduction.watsup
  rule trap-vals{val* : val*, instr* : instr*}:
    `%~>%`((val : val <: instr)*{val : val} :: [TRAP_instr] :: instr*{instr : instr}, [TRAP_instr])
    -- if ((val*{val : val} =/= []) \/ (instr*{instr : instr} =/= []))

  ;; 8-reduction.watsup
  rule trap-label{n : n, instr'* : instr*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr'*{instr' : instr}, [TRAP_instr])], [TRAP_instr])

  ;; 8-reduction.watsup
  rule trap-frame{n : n, f : frame}:
    `%~>%`([`FRAME_%{%}%`_instr(n, f, [TRAP_instr])], [TRAP_instr])

  ;; 8-reduction.watsup
  rule unop-val{nt : numtype, c_1 : num_(nt), unop : unop_(nt), c : num_(nt)}:
    `%~>%`([CONST_instr(nt, c_1) UNOP_instr(nt, unop)], [CONST_instr(nt, c)])
    -- if ($unop(nt, unop, c_1) = [c])

  ;; 8-reduction.watsup
  rule unop-trap{nt : numtype, c_1 : num_(nt), unop : unop_(nt)}:
    `%~>%`([CONST_instr(nt, c_1) UNOP_instr(nt, unop)], [TRAP_instr])
    -- if ($unop(nt, unop, c_1) = [])

  ;; 8-reduction.watsup
  rule binop-val{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), binop : binop_(nt), c : num_(nt)}:
    `%~>%`([CONST_instr(nt, c_1) CONST_instr(nt, c_2) BINOP_instr(nt, binop)], [CONST_instr(nt, c)])
    -- if ($binop(nt, binop, c_1, c_2) = [c])

  ;; 8-reduction.watsup
  rule binop-trap{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), binop : binop_(nt)}:
    `%~>%`([CONST_instr(nt, c_1) CONST_instr(nt, c_2) BINOP_instr(nt, binop)], [TRAP_instr])
    -- if ($binop(nt, binop, c_1, c_2) = [])

  ;; 8-reduction.watsup
  rule testop{nt : numtype, c_1 : num_(nt), testop : testop_(nt), c : num_(I32_numtype)}:
    `%~>%`([CONST_instr(nt, c_1) TESTOP_instr(nt, testop)], [CONST_instr(I32_numtype, c)])
    -- if (c = $testop(nt, testop, c_1))

  ;; 8-reduction.watsup
  rule relop{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), relop : relop_(nt), c : num_(I32_numtype)}:
    `%~>%`([CONST_instr(nt, c_1) CONST_instr(nt, c_2) RELOP_instr(nt, relop)], [CONST_instr(I32_numtype, c)])
    -- if (c = $relop(nt, relop, c_1, c_2))

  ;; 8-reduction.watsup
  rule cvtop-val{nt_1 : numtype, c_1 : num_(nt_1), nt_2 : numtype, cvtop : cvtop_(nt_1, nt_2), sx? : sx?, c : num_(nt_2)}:
    `%~>%`([CONST_instr(nt_1, c_1) CVTOP_instr(nt_2, nt_1, cvtop, sx?{sx : sx})], [CONST_instr(nt_2, c)])
    -- if ($cvtop(nt_1, nt_2, cvtop, sx?{sx : sx}, c_1) = [c])

  ;; 8-reduction.watsup
  rule cvtop-trap{nt_1 : numtype, c_1 : num_(nt_1), nt_2 : numtype, cvtop : cvtop_(nt_1, nt_2), sx? : sx?}:
    `%~>%`([CONST_instr(nt_1, c_1) CVTOP_instr(nt_2, nt_1, cvtop, sx?{sx : sx})], [TRAP_instr])
    -- if ($cvtop(nt_1, nt_2, cvtop, sx?{sx : sx}, c_1) = [])

  ;; 8-reduction.watsup
  rule ref.i31{i : nat}:
    `%~>%`([CONST_instr(I32_numtype, `%`_num_(i)) REF.I31_instr], [REF.I31_NUM_instr($wrap(32, 31, `%`_iN(i)))])

  ;; 8-reduction.watsup
  rule ref.is_null-true{ref : ref, ht : heaptype}:
    `%~>%`([(ref : ref <: instr) REF.IS_NULL_instr], [CONST_instr(I32_numtype, `%`_num_(1))])
    -- if (ref = REF.NULL_ref(ht))

  ;; 8-reduction.watsup
  rule ref.is_null-false{ref : ref}:
    `%~>%`([(ref : ref <: instr) REF.IS_NULL_instr], [CONST_instr(I32_numtype, `%`_num_(0))])
    -- otherwise

  ;; 8-reduction.watsup
  rule ref.as_non_null-null{ref : ref, ht : heaptype}:
    `%~>%`([(ref : ref <: instr) REF.AS_NON_NULL_instr], [TRAP_instr])
    -- if (ref = REF.NULL_ref(ht))

  ;; 8-reduction.watsup
  rule ref.as_non_null-addr{ref : ref}:
    `%~>%`([(ref : ref <: instr) REF.AS_NON_NULL_instr], [(ref : ref <: instr)])
    -- otherwise

  ;; 8-reduction.watsup
  rule ref.eq-null{ref_1 : ref, ref_2 : ref, ht_1 : heaptype, ht_2 : heaptype}:
    `%~>%`([(ref_1 : ref <: instr) (ref_2 : ref <: instr) REF.EQ_instr], [CONST_instr(I32_numtype, `%`_num_(1))])
    -- if ((ref_1 = REF.NULL_ref(ht_1)) /\ (ref_2 = REF.NULL_ref(ht_2)))

  ;; 8-reduction.watsup
  rule ref.eq-true{ref_1 : ref, ref_2 : ref}:
    `%~>%`([(ref_1 : ref <: instr) (ref_2 : ref <: instr) REF.EQ_instr], [CONST_instr(I32_numtype, `%`_num_(1))])
    -- otherwise
    -- if (ref_1 = ref_2)

  ;; 8-reduction.watsup
  rule ref.eq-false{ref_1 : ref, ref_2 : ref}:
    `%~>%`([(ref_1 : ref <: instr) (ref_2 : ref <: instr) REF.EQ_instr], [CONST_instr(I32_numtype, `%`_num_(0))])
    -- otherwise

  ;; 8-reduction.watsup
  rule i31.get-null{ht : heaptype, sx : sx}:
    `%~>%`([REF.NULL_instr(ht) I31.GET_instr(sx)], [TRAP_instr])

  ;; 8-reduction.watsup
  rule i31.get-num{i : nat, sx : sx}:
    `%~>%`([REF.I31_NUM_instr(`%`_u31(i)) I31.GET_instr(sx)], [CONST_instr(I32_numtype, $ext(31, 32, sx, `%`_iN(i)))])

  ;; 8-reduction.watsup
  rule array.new{val : val, n : n, x : idx}:
    `%~>%`([(val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_instr(x)], (val : val <: instr)^n{} :: [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))])

  ;; 8-reduction.watsup
  rule extern.convert_any-null{ht : heaptype}:
    `%~>%`([REF.NULL_instr(ht) EXTERN.CONVERT_ANY_instr], [REF.NULL_instr(EXTERN_heaptype)])

  ;; 8-reduction.watsup
  rule extern.convert_any-addr{addrref : addrref}:
    `%~>%`([(addrref : addrref <: instr) EXTERN.CONVERT_ANY_instr], [REF.EXTERN_instr(addrref)])

  ;; 8-reduction.watsup
  rule any.convert_extern-null{ht : heaptype}:
    `%~>%`([REF.NULL_instr(ht) ANY.CONVERT_EXTERN_instr], [REF.NULL_instr(ANY_heaptype)])

  ;; 8-reduction.watsup
  rule any.convert_extern-addr{addrref : addrref}:
    `%~>%`([REF.EXTERN_instr(addrref) ANY.CONVERT_EXTERN_instr], [(addrref : addrref <: instr)])

  ;; 8-reduction.watsup
  rule vvunop{c_1 : vec_(V128_Vnn), vvunop : vvunop, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VVUNOP_instr(V128_vectype, vvunop)], [VCONST_instr(V128_vectype, c)])
    -- if (c = $vvunop(V128_vectype, vvunop, c_1))

  ;; 8-reduction.watsup
  rule vvbinop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), vvbinop : vvbinop, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VVBINOP_instr(V128_vectype, vvbinop)], [VCONST_instr(V128_vectype, c)])
    -- if (c = $vvbinop(V128_vectype, vvbinop, c_1, c_2))

  ;; 8-reduction.watsup
  rule vvternop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c_3 : vec_(V128_Vnn), vvternop : vvternop, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VCONST_instr(V128_vectype, c_3) VVTERNOP_instr(V128_vectype, vvternop)], [VCONST_instr(V128_vectype, c)])
    -- if (c = $vvternop(V128_vectype, vvternop, c_1, c_2, c_3))

  ;; 8-reduction.watsup
  rule vvtestop{c_1 : vec_(V128_Vnn), c : num_(I32_numtype)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VVTESTOP_instr(V128_vectype, ANY_TRUE_vvtestop)], [CONST_instr(I32_numtype, c)])
    -- if (c = $ine($vsize(V128_vectype), c_1, `%`_iN(0)))

  ;; 8-reduction.watsup
  rule vunop{c_1 : vec_(V128_Vnn), sh : shape, vunop : vunop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VUNOP_instr(sh, vunop)], [VCONST_instr(V128_vectype, c)])
    -- if (c = $vunop(sh, vunop, c_1))

  ;; 8-reduction.watsup
  rule vbinop-val{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh : shape, vbinop : vbinop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VBINOP_instr(sh, vbinop)], [VCONST_instr(V128_vectype, c)])
    -- if ($vbinop(sh, vbinop, c_1, c_2) = [c])

  ;; 8-reduction.watsup
  rule vbinop-trap{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh : shape, vbinop : vbinop_(sh)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VBINOP_instr(sh, vbinop)], [TRAP_instr])
    -- if ($vbinop(sh, vbinop, c_1, c_2) = [])

  ;; 8-reduction.watsup
  rule vtestop-true{c : vec_(V128_Vnn), Jnn : Jnn, N : N, ci_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}:
    `%~>%`([VCONST_instr(V128_vectype, c) VTESTOP_instr(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), ALL_TRUE_vtestop_)], [CONST_instr(I32_numtype, `%`_num_(1))])
    -- if (ci_1*{ci_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), c))
    -- (if (ci_1 =/= `%`_lane_(0)))*{ci_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))}

  ;; 8-reduction.watsup
  rule vtestop-false{c : vec_(V128_Vnn), Jnn : Jnn, N : N}:
    `%~>%`([VCONST_instr(V128_vectype, c) VTESTOP_instr(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), ALL_TRUE_vtestop_)], [CONST_instr(I32_numtype, `%`_num_(0))])
    -- otherwise

  ;; 8-reduction.watsup
  rule vrelop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh : shape, vrelop : vrelop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VRELOP_instr(sh, vrelop)], [VCONST_instr(V128_vectype, c)])
    -- if ($vrelop(sh, vrelop, c_1, c_2) = c)

  ;; 8-reduction.watsup
  rule vshiftop{c_1 : vec_(V128_Vnn), n : n, Jnn : Jnn, N : N, vshiftop : vshiftop_(`%X%`_ishape(Jnn, `%`_dim(N))), c : vec_(V128_Vnn), c'* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) CONST_instr(I32_numtype, `%`_num_(n)) VSHIFTOP_instr(`%X%`_ishape(Jnn, `%`_dim(N)), vshiftop)], [VCONST_instr(V128_vectype, c)])
    -- if (c'*{c' : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), c_1))
    -- if (c = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $vshiftop(`%X%`_ishape(Jnn, `%`_dim(N)), vshiftop, c', `%`_u32(n))*{c' : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))}))

  ;; 8-reduction.watsup
  rule vbitmask{c : vec_(V128_Vnn), Jnn : Jnn, N : N, ci : num_(I32_numtype), ci_1* : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))*}:
    `%~>%`([VCONST_instr(V128_vectype, c) VBITMASK_instr(`%X%`_ishape(Jnn, `%`_dim(N)))], [CONST_instr(I32_numtype, ci)])
    -- if (ci_1*{ci_1 : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), c))
    -- if ($ibits(32, ci) = `%`_bit($ilt($lsize((Jnn : Jnn <: lanetype)), S_sx, ci_1, `%`_iN(0))!`%`_u32.0)*{ci_1 : iN($lsize((Jnn : Jnn <: lanetype)))})

  ;; 8-reduction.watsup
  rule vswizzle{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), Pnn : Pnn, N : N, c' : vec_(V128_Vnn), c* : iN($lsize((Pnn : Pnn <: lanetype)))*, ci* : lane_($lanetype(`%X%`_shape((Pnn : Pnn <: lanetype), `%`_dim(N))))*, k^N : nat^N}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VSWIZZLE_instr(`%X%`_ishape((Pnn : Pnn <: Jnn), `%`_dim(N)))], [VCONST_instr(V128_vectype, c')])
    -- if (ci*{ci : lane_($lanetype(`%X%`_shape((Pnn : Pnn <: lanetype), `%`_dim(N))))} = $lanes_(`%X%`_shape((Pnn : Pnn <: lanetype), `%`_dim(N)), c_2))
    -- if (c*{c : iN($lsize((Pnn : Pnn <: lanetype)))} = $lanes_(`%X%`_shape((Pnn : Pnn <: lanetype), `%`_dim(N)), c_1) :: `%`_iN(0)^(256 - N){})
    -- if (c' = $invlanes_(`%X%`_shape((Pnn : Pnn <: lanetype), `%`_dim(N)), c*{c : iN($lsize((Pnn : Pnn <: lanetype)))}[ci*{ci : lane_($lanetype(`%X%`_shape((Pnn : Pnn <: lanetype), `%`_dim(N))))}[k]!`%`_lane_.0]^(k<N){k : nat}))

  ;; 8-reduction.watsup
  rule vshuffle{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), Pnn : Pnn, N : N, i* : nat*, c : vec_(V128_Vnn), c'* : iN($lsize((Pnn : Pnn <: lanetype)))*, k^N : nat^N}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VSHUFFLE_instr(`%X%`_ishape((Pnn : Pnn <: Jnn), `%`_dim(N)), `%`_laneidx(i)*{i : nat})], [VCONST_instr(V128_vectype, c)])
    -- if (c'*{c' : iN($lsize((Pnn : Pnn <: lanetype)))} = $lanes_(`%X%`_shape((Pnn : Pnn <: lanetype), `%`_dim(N)), c_1) :: $lanes_(`%X%`_shape((Pnn : Pnn <: lanetype), `%`_dim(N)), c_2))
    -- if (c = $invlanes_(`%X%`_shape((Pnn : Pnn <: lanetype), `%`_dim(N)), c'*{c' : iN($lsize((Pnn : Pnn <: lanetype)))}[i*{i : nat}[k]]^(k<N){k : nat}))

  ;; 8-reduction.watsup
  rule vsplat{Lnn : Lnn, c_1 : num_($lunpack(Lnn)), N : N, c : vec_(V128_Vnn)}:
    `%~>%`([CONST_instr($lunpack(Lnn), c_1) VSPLAT_instr(`%X%`_shape(Lnn, `%`_dim(N)))], [VCONST_instr(V128_vectype, c)])
    -- if (c = $invlanes_(`%X%`_shape(Lnn, `%`_dim(N)), $lpacknum(Lnn, c_1)^N{}))

  ;; 8-reduction.watsup
  rule vextract_lane-num{c_1 : vec_(V128_Vnn), nt : numtype, N : N, i : nat, c_2 : num_(nt)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VEXTRACT_LANE_instr(`%X%`_shape((nt : numtype <: lanetype), `%`_dim(N)), ?(), `%`_laneidx(i))], [CONST_instr(nt, c_2)])
    -- if (c_2 = $lanes_(`%X%`_shape((nt : numtype <: lanetype), `%`_dim(N)), c_1)[i])

  ;; 8-reduction.watsup
  rule vextract_lane-pack{c_1 : vec_(V128_Vnn), pt : packtype, N : N, sx : sx, i : nat, c_2 : num_(I32_numtype)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VEXTRACT_LANE_instr(`%X%`_shape((pt : packtype <: lanetype), `%`_dim(N)), ?(sx), `%`_laneidx(i))], [CONST_instr(I32_numtype, c_2)])
    -- if (c_2 = $ext($psize(pt), 32, sx, $lanes_(`%X%`_shape((pt : packtype <: lanetype), `%`_dim(N)), c_1)[i]))

  ;; 8-reduction.watsup
  rule vreplace_lane{c_1 : vec_(V128_Vnn), Lnn : Lnn, c_2 : num_($lunpack(Lnn)), N : N, i : nat, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) CONST_instr($lunpack(Lnn), c_2) VREPLACE_LANE_instr(`%X%`_shape(Lnn, `%`_dim(N)), `%`_laneidx(i))], [VCONST_instr(V128_vectype, c)])
    -- if (c = $invlanes_(`%X%`_shape(Lnn, `%`_dim(N)), $lanes_(`%X%`_shape(Lnn, `%`_dim(N)), c_1)[[i] = $lpacknum(Lnn, c_2)]))

  ;; 8-reduction.watsup
  rule vextunop{c_1 : vec_(V128_Vnn), sh_1 : ishape, sh_2 : ishape, vextunop : vextunop_(sh_1), sx : sx, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VEXTUNOP_instr(sh_1, sh_2, vextunop, sx)], [VCONST_instr(V128_vectype, c)])
    -- if ($vextunop(sh_1, sh_2, vextunop, sx, c_1) = c)

  ;; 8-reduction.watsup
  rule vextbinop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh_1 : ishape, sh_2 : ishape, vextbinop : vextbinop_(sh_1), sx : sx, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VEXTBINOP_instr(sh_1, sh_2, vextbinop, sx)], [VCONST_instr(V128_vectype, c)])
    -- if ($vextbinop(sh_1, sh_2, vextbinop, sx, c_1, c_2) = c)

  ;; 8-reduction.watsup
  rule vnarrow{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), Jnn_2 : Jnn, N_2 : N, Jnn_1 : Jnn, N_1 : N, sx : sx, c : vec_(V128_Vnn), ci_1* : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(N_1))))*, ci_2* : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(N_1))))*, cj_1* : iN($lsize((Jnn_2 : Jnn <: lanetype)))*, cj_2* : iN($lsize((Jnn_2 : Jnn <: lanetype)))*}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VNARROW_instr(`%X%`_ishape(Jnn_2, `%`_dim(N_2)), `%X%`_ishape(Jnn_1, `%`_dim(N_1)), sx)], [VCONST_instr(V128_vectype, c)])
    -- if (ci_1*{ci_1 : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(N_1))))} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(N_1)), c_1))
    -- if (ci_2*{ci_2 : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(N_1))))} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(N_1)), c_2))
    -- if (cj_1*{cj_1 : iN($lsize((Jnn_2 : Jnn <: lanetype)))} = $narrow($lsize((Jnn_1 : Jnn <: lanetype)), $lsize((Jnn_2 : Jnn <: lanetype)), sx, ci_1)*{ci_1 : iN($lsize((Jnn_1 : Jnn <: lanetype)))})
    -- if (cj_2*{cj_2 : iN($lsize((Jnn_2 : Jnn <: lanetype)))} = $narrow($lsize((Jnn_1 : Jnn <: lanetype)), $lsize((Jnn_2 : Jnn <: lanetype)), sx, ci_2)*{ci_2 : iN($lsize((Jnn_1 : Jnn <: lanetype)))})
    -- if (c = $invlanes_(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(N_2)), cj_1*{cj_1 : lane_($lanetype(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(N_2))))} :: cj_2*{cj_2 : lane_($lanetype(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(N_2))))}))

  ;; 8-reduction.watsup
  rule vcvtop-full{c_1 : vec_(V128_Vnn), Lnn_2 : Lnn, N_2 : N, Lnn_1 : Lnn, N_1 : N, vcvtop : vcvtop_(`%X%`_shape(Lnn_1, `%`_dim(N_1)), `%X%`_shape(Lnn_2, `%`_dim(N_2))), sx? : sx?, c : vec_(V128_Vnn), c'* : lane_($lanetype(`%X%`_shape(Lnn_1, `%`_dim(N_1))))*}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCVTOP_instr(`%X%`_shape(Lnn_2, `%`_dim(N_2)), `%X%`_shape(Lnn_1, `%`_dim(N_1)), vcvtop, ?(), sx?{sx : sx}, ?())], [VCONST_instr(V128_vectype, c)])
    -- if (c'*{c' : lane_($lanetype(`%X%`_shape(Lnn_1, `%`_dim(N_1))))} = $lanes_(`%X%`_shape(Lnn_1, `%`_dim(N_1)), c_1))
    -- if (c = $invlanes_(`%X%`_shape(Lnn_2, `%`_dim(N_2)), $vcvtop(`%X%`_shape(Lnn_1, `%`_dim(N_1)), `%X%`_shape(Lnn_2, `%`_dim(N_2)), vcvtop, sx?{sx : sx}, c')*{c' : lane_($lanetype(`%X%`_shape(Lnn_1, `%`_dim(N_1))))}))

  ;; 8-reduction.watsup
  rule vcvtop-half{c_1 : vec_(V128_Vnn), Lnn_2 : Lnn, N_2 : N, Lnn_1 : Lnn, N_1 : N, vcvtop : vcvtop_(`%X%`_shape(Lnn_1, `%`_dim(N_1)), `%X%`_shape(Lnn_2, `%`_dim(N_2))), half : half, sx? : sx?, c : vec_(V128_Vnn), ci* : lane_($lanetype(`%X%`_shape(Lnn_1, `%`_dim(N_1))))*}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCVTOP_instr(`%X%`_shape(Lnn_2, `%`_dim(N_2)), `%X%`_shape(Lnn_1, `%`_dim(N_1)), vcvtop, ?(`%`_half_(half)), sx?{sx : sx}, ?())], [VCONST_instr(V128_vectype, c)])
    -- if (ci*{ci : lane_($lanetype(`%X%`_shape(Lnn_1, `%`_dim(N_1))))} = $lanes_(`%X%`_shape(Lnn_1, `%`_dim(N_1)), c_1)[$half(half, 0, N_2) : N_2])
    -- if (c = $invlanes_(`%X%`_shape(Lnn_2, `%`_dim(N_2)), $vcvtop(`%X%`_shape(Lnn_1, `%`_dim(N_1)), `%X%`_shape(Lnn_2, `%`_dim(N_2)), vcvtop, sx?{sx : sx}, ci)*{ci : lane_($lanetype(`%X%`_shape(Lnn_1, `%`_dim(N_1))))}))

  ;; 8-reduction.watsup
  rule vcvtop-zero{c_1 : vec_(V128_Vnn), nt_2 : numtype, N_2 : N, nt_1 : numtype, N_1 : N, vcvtop : vcvtop_(`%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(N_1)), `%X%`_shape((nt_2 : numtype <: lanetype), `%`_dim(N_2))), sx? : sx?, c : vec_(V128_Vnn), ci* : lane_($lanetype(`%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(N_1))))*}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCVTOP_instr(`%X%`_shape((nt_2 : numtype <: lanetype), `%`_dim(N_2)), `%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(N_1)), vcvtop, ?(), sx?{sx : sx}, ?(ZERO_zero_))], [VCONST_instr(V128_vectype, c)])
    -- if (ci*{ci : lane_($lanetype(`%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(N_1))))} = $lanes_(`%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(N_1)), c_1))
    -- if (c = $invlanes_(`%X%`_shape((nt_2 : numtype <: lanetype), `%`_dim(N_2)), $vcvtop(`%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(N_1)), `%X%`_shape((nt_2 : numtype <: lanetype), `%`_dim(N_2)), vcvtop, sx?{sx : sx}, ci)*{ci : lane_($lanetype(`%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(N_1))))} :: $zero(nt_2)^N_1{}))

  ;; 8-reduction.watsup
  rule local.tee{val : val, x : idx}:
    `%~>%`([(val : val <: instr) LOCAL.TEE_instr(x)], [(val : val <: instr) (val : val <: instr) LOCAL.SET_instr(x)])

;; 8-reduction.watsup
def $blocktype_(state : state, blocktype : blocktype) : functype
  ;; 8-reduction.watsup
  def $blocktype_{z : state, x : idx, ft : functype}(z, _IDX_blocktype(x)) = ft
    -- Expand: `%~~%`($type(z, x), FUNC_comptype(ft))
  ;; 8-reduction.watsup
  def $blocktype_{z : state, t? : valtype?}(z, _RESULT_blocktype(t?{t : valtype})) = `%->%`_functype(`%`_resulttype([]), `%`_resulttype(t?{t : valtype}))

;; 8-reduction.watsup
relation Step_read: `%~>%`(config, instr*)
  ;; 8-reduction.watsup
  rule block{z : state, val^m : val^m, m : m, bt : blocktype, instr* : instr*, n : n, t_1^m : valtype^m, t_2^n : valtype^n}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^m{val : val} :: [BLOCK_instr(bt, instr*{instr : instr})]), [`LABEL_%{%}%`_instr(n, [], (val : val <: instr)^m{val : val} :: instr*{instr : instr})])
    -- if ($blocktype_(z, bt) = `%->%`_functype(`%`_resulttype(t_1^m{t_1 : valtype}), `%`_resulttype(t_2^n{t_2 : valtype})))

  ;; 8-reduction.watsup
  rule loop{z : state, val^m : val^m, m : m, bt : blocktype, instr* : instr*, t_1^m : valtype^m, t_2^n : valtype^n, n : n}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^m{val : val} :: [LOOP_instr(bt, instr*{instr : instr})]), [`LABEL_%{%}%`_instr(m, [LOOP_instr(bt, instr*{instr : instr})], (val : val <: instr)^m{val : val} :: instr*{instr : instr})])
    -- if ($blocktype_(z, bt) = `%->%`_functype(`%`_resulttype(t_1^m{t_1 : valtype}), `%`_resulttype(t_2^n{t_2 : valtype})))

  ;; 8-reduction.watsup
  rule br_on_cast-succeed{s : store, f : frame, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype, rt : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) BR_ON_CAST_instr(l, rt_1, rt_2)]), [(ref : ref <: instr) BR_instr(l)])
    -- Ref_type: `%|-%:%`(s, ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt, $inst_reftype(f.MODULE_frame, rt_2))

  ;; 8-reduction.watsup
  rule br_on_cast-fail{s : store, f : frame, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) BR_ON_CAST_instr(l, rt_1, rt_2)]), [(ref : ref <: instr)])
    -- otherwise

  ;; 8-reduction.watsup
  rule br_on_cast_fail-succeed{s : store, f : frame, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype, rt : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) BR_ON_CAST_FAIL_instr(l, rt_1, rt_2)]), [(ref : ref <: instr)])
    -- Ref_type: `%|-%:%`(s, ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt, $inst_reftype(f.MODULE_frame, rt_2))

  ;; 8-reduction.watsup
  rule br_on_cast_fail-fail{s : store, f : frame, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) BR_ON_CAST_FAIL_instr(l, rt_1, rt_2)]), [(ref : ref <: instr) BR_instr(l)])
    -- otherwise

  ;; 8-reduction.watsup
  rule call{z : state, x : idx, a : addr}:
    `%~>%`(`%;%`_config(z, [CALL_instr(x)]), [REF.FUNC_ADDR_instr(a) CALL_REF_instr(($funcinst(z)[a].TYPE_funcinst : deftype <: typeuse))])
    -- if ($moduleinst(z).FUNCS_moduleinst[x!`%`_idx.0] = a)

  ;; 8-reduction.watsup
  rule call_ref-null{z : state, ht : heaptype, yy : typeuse}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CALL_REF_instr(yy)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule call_ref-func{z : state, val^n : val^n, n : n, a : addr, yy : typeuse, m : m, f : frame, instr* : instr*, fi : funcinst, t_1^n : valtype^n, t_2^m : valtype^m, x : idx, t* : valtype*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^n{val : val} :: [REF.FUNC_ADDR_instr(a) CALL_REF_instr(yy)]), [`FRAME_%{%}%`_instr(m, f, [`LABEL_%{%}%`_instr(m, [], instr*{instr : instr})])])
    -- if ($funcinst(z)[a] = fi)
    -- Expand: `%~~%`(fi.TYPE_funcinst, FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1^n{t_1 : valtype}), `%`_resulttype(t_2^m{t_2 : valtype}))))
    -- if (fi.CODE_funcinst = FUNC_funccode(x, LOCAL_local(t)*{t : valtype}, instr*{instr : instr}))
    -- if (f = {LOCALS ?(val)^n{val : val} :: $default_(t)*{t : valtype}, MODULE fi.MODULE_funcinst})

  ;; 8-reduction.watsup
  rule return_call{z : state, x : idx, a : addr}:
    `%~>%`(`%;%`_config(z, [RETURN_CALL_instr(x)]), [REF.FUNC_ADDR_instr(a) RETURN_CALL_REF_instr(($funcinst(z)[a].TYPE_funcinst : deftype <: typeuse))])
    -- if ($moduleinst(z).FUNCS_moduleinst[x!`%`_idx.0] = a)

  ;; 8-reduction.watsup
  rule return_call_ref-label{z : state, k : nat, instr'* : instr*, val* : val*, yy : typeuse, instr* : instr*}:
    `%~>%`(`%;%`_config(z, [`LABEL_%{%}%`_instr(k, instr'*{instr' : instr}, (val : val <: instr)*{val : val} :: [RETURN_CALL_REF_instr(yy)] :: instr*{instr : instr})]), (val : val <: instr)*{val : val} :: [RETURN_CALL_REF_instr(yy)])

  ;; 8-reduction.watsup
  rule return_call_ref-frame-null{z : state, k : nat, f : frame, val* : val*, ht : heaptype, yy : typeuse, instr* : instr*}:
    `%~>%`(`%;%`_config(z, [`FRAME_%{%}%`_instr(k, f, (val : val <: instr)*{val : val} :: [REF.NULL_instr(ht)] :: [RETURN_CALL_REF_instr(yy)] :: instr*{instr : instr})]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule return_call_ref-frame-addr{z : state, k : nat, f : frame, val'* : val*, val^n : val^n, n : n, a : addr, yy : typeuse, instr* : instr*, t_1^n : valtype^n, t_2^m : valtype^m, m : m}:
    `%~>%`(`%;%`_config(z, [`FRAME_%{%}%`_instr(k, f, (val' : val <: instr)*{val' : val} :: (val : val <: instr)^n{val : val} :: [REF.FUNC_ADDR_instr(a)] :: [RETURN_CALL_REF_instr(yy)] :: instr*{instr : instr})]), (val : val <: instr)^n{val : val} :: [REF.FUNC_ADDR_instr(a) CALL_REF_instr(yy)])
    -- Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1^n{t_1 : valtype}), `%`_resulttype(t_2^m{t_2 : valtype}))))

  ;; 8-reduction.watsup
  rule ref.null-idx{z : state, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(($idx(x) : typevar <: heaptype))]), [REF.NULL_instr(($type(z, x) : deftype <: heaptype))])

  ;; 8-reduction.watsup
  rule ref.func{z : state, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.FUNC_instr(x)]), [REF.FUNC_ADDR_instr($moduleinst(z).FUNCS_moduleinst[x!`%`_idx.0])])

  ;; 8-reduction.watsup
  rule ref.test-true{s : store, f : frame, ref : ref, rt : reftype, rt' : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) REF.TEST_instr(rt)]), [CONST_instr(I32_numtype, `%`_num_(1))])
    -- Ref_type: `%|-%:%`(s, ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt', $inst_reftype(f.MODULE_frame, rt))

  ;; 8-reduction.watsup
  rule ref.test-false{s : store, f : frame, ref : ref, rt : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) REF.TEST_instr(rt)]), [CONST_instr(I32_numtype, `%`_num_(0))])
    -- otherwise

  ;; 8-reduction.watsup
  rule ref.cast-succeed{s : store, f : frame, ref : ref, rt : reftype, rt' : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) REF.CAST_instr(rt)]), [(ref : ref <: instr)])
    -- Ref_type: `%|-%:%`(s, ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt', $inst_reftype(f.MODULE_frame, rt))

  ;; 8-reduction.watsup
  rule ref.cast-fail{s : store, f : frame, ref : ref, rt : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) REF.CAST_instr(rt)]), [TRAP_instr])
    -- otherwise

  ;; 8-reduction.watsup
  rule struct.new_default{z : state, x : idx, val* : val*, mut* : mut*, zt* : storagetype*}:
    `%~>%`(`%;%`_config(z, [STRUCT.NEW_DEFAULT_instr(x)]), (val : val <: instr)*{val : val} :: [STRUCT.NEW_instr(x)])
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%`_structtype(`%%`_fieldtype(mut, zt)*{mut : mut, zt : storagetype})))
    -- (if ($default_($unpack(zt)) = ?(val)))*{val : val, zt : storagetype}

  ;; 8-reduction.watsup
  rule struct.get-null{z : state, ht : heaptype, sx? : sx?, x : idx, i : nat}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) STRUCT.GET_instr(sx?{sx : sx}, x, `%`_u32(i))]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule struct.get-struct{z : state, a : addr, sx? : sx?, x : idx, i : nat, zt* : storagetype*, mut* : mut*}:
    `%~>%`(`%;%`_config(z, [REF.STRUCT_ADDR_instr(a) STRUCT.GET_instr(sx?{sx : sx}, x, `%`_u32(i))]), [($unpackfield(zt*{zt : storagetype}[i], sx?{sx : sx}, $structinst(z)[a].FIELDS_structinst[i]) : val <: instr)])
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%`_structtype(`%%`_fieldtype(mut, zt)*{mut : mut, zt : storagetype})))

  ;; 8-reduction.watsup
  rule array.new_default{z : state, n : n, x : idx, val : val, mut : mut, zt : storagetype}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_DEFAULT_instr(x)]), (val : val <: instr)^n{} :: [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ($default_($unpack(zt)) = ?(val))

  ;; 8-reduction.watsup
  rule array.new_elem-oob{z : state, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_ELEM_instr(x, y)]), [TRAP_instr])
    -- if ((i + n) > |$elem(z, y).REFS_eleminst|)

  ;; 8-reduction.watsup
  rule array.new_elem-alloc{z : state, i : nat, n : n, x : idx, y : idx, ref^n : ref^n}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_ELEM_instr(x, y)]), (ref : ref <: instr)^n{ref : ref} :: [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))])
    -- if (ref^n{ref : ref} = $elem(z, y).REFS_eleminst[i : n])

  ;; 8-reduction.watsup
  rule array.new_data-oob{z : state, i : nat, n : n, x : idx, y : idx, mut : mut, zt : storagetype}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_DATA_instr(x, y)]), [TRAP_instr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ((i + ((n * $zsize(zt)) / 8)) > |$data(z, y).BYTES_datainst|)

  ;; 8-reduction.watsup
  rule array.new_data-num{z : state, i : nat, n : n, x : idx, y : idx, zt : storagetype, c^n : lit_(zt)^n, mut : mut}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_DATA_instr(x, y)]), $const($cunpack(zt), $cunpacknum(zt, c))^n{c : lit_(zt)} :: [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ($concat_(syntax byte, $zbytes(zt, c)^n{c : lit_(zt)}) = $data(z, y).BYTES_datainst[i : ((n * $zsize(zt)) / 8)])

  ;; 8-reduction.watsup
  rule array.get-null{z : state, ht : heaptype, i : nat, sx? : sx?, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, `%`_num_(i)) ARRAY.GET_instr(sx?{sx : sx}, x)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule array.get-oob{z : state, a : addr, i : nat, sx? : sx?, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) ARRAY.GET_instr(sx?{sx : sx}, x)]), [TRAP_instr])
    -- if (i >= |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; 8-reduction.watsup
  rule array.get-array{z : state, a : addr, i : nat, sx? : sx?, x : idx, zt : storagetype, mut : mut}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) ARRAY.GET_instr(sx?{sx : sx}, x)]), [($unpackfield(zt, sx?{sx : sx}, $arrayinst(z)[a].FIELDS_arrayinst[i]) : val <: instr)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))

  ;; 8-reduction.watsup
  rule array.len-null{z : state, ht : heaptype}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) ARRAY.LEN_instr]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule array.len-array{z : state, a : addr}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) ARRAY.LEN_instr]), [CONST_instr(I32_numtype, `%`_num_(|$arrayinst(z)[a].FIELDS_arrayinst|))])

  ;; 8-reduction.watsup
  rule array.fill-null{z : state, ht : heaptype, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.FILL_instr(x)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule array.fill-oob{z : state, a : addr, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.FILL_instr(x)]), [TRAP_instr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; 8-reduction.watsup
  rule array.fill-zero{z : state, a : addr, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.FILL_instr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule array.fill-succ{z : state, a : addr, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.FILL_instr(x)]), [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) ARRAY.SET_instr(x) REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_((i + 1))) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_((n - 1))) ARRAY.FILL_instr(x)])
    -- otherwise

  ;; 8-reduction.watsup
  rule array.copy-null1{z : state, ht_1 : heaptype, i_1 : nat, ref : ref, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht_1) CONST_instr(I32_numtype, `%`_num_(i_1)) (ref : ref <: instr) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule array.copy-null2{z : state, ref : ref, i_1 : nat, ht_2 : heaptype, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [(ref : ref <: instr) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.NULL_instr(ht_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule array.copy-oob1{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [TRAP_instr])
    -- if ((i_1 + n) > |$arrayinst(z)[a_1].FIELDS_arrayinst|)

  ;; 8-reduction.watsup
  rule array.copy-oob2{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [TRAP_instr])
    -- if ((i_2 + n) > |$arrayinst(z)[a_2].FIELDS_arrayinst|)

  ;; 8-reduction.watsup
  rule array.copy-zero{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule array.copy-le{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx, sx? : sx?, mut : mut, zt_2 : storagetype}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) ARRAY.GET_instr(sx?{sx : sx}, x_2) ARRAY.SET_instr(x_1) REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_((i_1 + 1))) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_((i_2 + 1))) CONST_instr(I32_numtype, `%`_num_((n - 1))) ARRAY.COPY_instr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`_arraytype(mut, zt_2)))
    -- if ((i_1 <= i_2) /\ (sx?{sx : sx} = $sx(zt_2)))

  ;; 8-reduction.watsup
  rule array.copy-gt{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx, sx? : sx?, mut : mut, zt_2 : storagetype}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(((i_1 + n) - 1))) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(((i_2 + n) - 1))) ARRAY.GET_instr(sx?{sx : sx}, x_2) ARRAY.SET_instr(x_1) REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_((n - 1))) ARRAY.COPY_instr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`_arraytype(mut, zt_2)))
    -- if (sx?{sx : sx} = $sx(zt_2))

  ;; 8-reduction.watsup
  rule array.init_elem-null{z : state, ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule array.init_elem-oob1{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [TRAP_instr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; 8-reduction.watsup
  rule array.init_elem-oob2{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [TRAP_instr])
    -- if ((j + n) > |$elem(z, y).REFS_eleminst|)

  ;; 8-reduction.watsup
  rule array.init_elem-zero{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule array.init_elem-succ{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, ref : ref}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (ref : ref <: instr) ARRAY.SET_instr(x) REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_((i + 1))) CONST_instr(I32_numtype, `%`_num_((j + 1))) CONST_instr(I32_numtype, `%`_num_((n - 1))) ARRAY.INIT_ELEM_instr(x, y)])
    -- otherwise
    -- if (ref = $elem(z, y).REFS_eleminst[j])

  ;; 8-reduction.watsup
  rule array.init_data-null{z : state, ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule array.init_data-oob1{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [TRAP_instr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; 8-reduction.watsup
  rule array.init_data-oob2{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, mut : mut, zt : storagetype}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [TRAP_instr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ((j + ((n * $zsize(zt)) / 8)) > |$data(z, y).BYTES_datainst|)

  ;; 8-reduction.watsup
  rule array.init_data-zero{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule array.init_data-num{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, zt : storagetype, c : lit_(zt), mut : mut}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) $const($cunpack(zt), $cunpacknum(zt, c)) ARRAY.SET_instr(x) REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_((i + 1))) CONST_instr(I32_numtype, `%`_num_((j + ($zsize(zt) / 8)))) CONST_instr(I32_numtype, `%`_num_((n - 1))) ARRAY.INIT_DATA_instr(x, y)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ($zbytes(zt, c) = $data(z, y).BYTES_datainst[j : ($zsize(zt) / 8)])

  ;; 8-reduction.watsup
  rule local.get{z : state, x : idx, val : val}:
    `%~>%`(`%;%`_config(z, [LOCAL.GET_instr(x)]), [(val : val <: instr)])
    -- if ($local(z, x) = ?(val))

  ;; 8-reduction.watsup
  rule global.get{z : state, x : idx, val : val}:
    `%~>%`(`%;%`_config(z, [GLOBAL.GET_instr(x)]), [(val : val <: instr)])
    -- if ($global(z, x).VALUE_globalinst = val)

  ;; 8-reduction.watsup
  rule table.get-oob{z : state, i : nat, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) TABLE.GET_instr(x)]), [TRAP_instr])
    -- if (i >= |$table(z, x).REFS_tableinst|)

  ;; 8-reduction.watsup
  rule table.get-val{z : state, i : nat, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) TABLE.GET_instr(x)]), [($table(z, x).REFS_tableinst[i] : ref <: instr)])
    -- if (i < |$table(z, x).REFS_tableinst|)

  ;; 8-reduction.watsup
  rule table.size{z : state, x : idx, n : n}:
    `%~>%`(`%;%`_config(z, [TABLE.SIZE_instr(x)]), [CONST_instr(I32_numtype, `%`_num_(n))])
    -- if (|$table(z, x).REFS_tableinst| = n)

  ;; 8-reduction.watsup
  rule table.fill-oob{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.FILL_instr(x)]), [TRAP_instr])
    -- if ((i + n) > |$table(z, x).REFS_tableinst|)

  ;; 8-reduction.watsup
  rule table.fill-zero{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.FILL_instr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule table.fill-succ{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.FILL_instr(x)]), [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) TABLE.SET_instr(x) CONST_instr(I32_numtype, `%`_num_((i + 1))) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_((n - 1))) TABLE.FILL_instr(x)])
    -- otherwise

  ;; 8-reduction.watsup
  rule table.copy-oob{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.COPY_instr(x, y)]), [TRAP_instr])
    -- if (((i + n) > |$table(z, y).REFS_tableinst|) \/ ((j + n) > |$table(z, x).REFS_tableinst|))

  ;; 8-reduction.watsup
  rule table.copy-zero{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.COPY_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule table.copy-le{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.COPY_instr(x, y)]), [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) TABLE.GET_instr(y) TABLE.SET_instr(x) CONST_instr(I32_numtype, `%`_num_((j + 1))) CONST_instr(I32_numtype, `%`_num_((i + 1))) CONST_instr(I32_numtype, `%`_num_((n - 1))) TABLE.COPY_instr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 8-reduction.watsup
  rule table.copy-gt{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.COPY_instr(x, y)]), [CONST_instr(I32_numtype, `%`_num_(((j + n) - 1))) CONST_instr(I32_numtype, `%`_num_(((i + n) - 1))) TABLE.GET_instr(y) TABLE.SET_instr(x) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_((n - 1))) TABLE.COPY_instr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup
  rule table.init-oob{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.INIT_instr(x, y)]), [TRAP_instr])
    -- if (((i + n) > |$elem(z, y).REFS_eleminst|) \/ ((j + n) > |$table(z, x).REFS_tableinst|))

  ;; 8-reduction.watsup
  rule table.init-zero{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.INIT_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule table.init-succ{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.INIT_instr(x, y)]), [CONST_instr(I32_numtype, `%`_num_(j)) ($elem(z, y).REFS_eleminst[i] : ref <: instr) TABLE.SET_instr(x) CONST_instr(I32_numtype, `%`_num_((j + 1))) CONST_instr(I32_numtype, `%`_num_((i + 1))) CONST_instr(I32_numtype, `%`_num_((n - 1))) TABLE.INIT_instr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup
  rule load-num-oob{z : state, i : nat, nt : numtype, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) LOAD_instr(nt, ?(), x, ao)]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + ($size(nt) / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule load-num-val{z : state, i : nat, nt : numtype, x : idx, ao : memarg, c : num_(nt)}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) LOAD_instr(nt, ?(), x, ao)]), [CONST_instr(nt, c)])
    -- if ($nbytes(nt, c) = $mem(z, x).BYTES_meminst[(i + ao.OFFSET_memarg!`%`_u32.0) : ($size(nt) / 8)])

  ;; 8-reduction.watsup
  rule load-pack-oob{z : state, i : nat, Inn : Inn, n : n, sx : sx, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) LOAD_instr((Inn : Inn <: numtype), ?(`%%`_loadop_(`%`_sz(n), sx)), x, ao)]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + (n / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule load-pack-val{z : state, i : nat, Inn : Inn, n : n, sx : sx, x : idx, ao : memarg, c : iN(n)}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) LOAD_instr((Inn : Inn <: numtype), ?(`%%`_loadop_(`%`_sz(n), sx)), x, ao)]), [CONST_instr((Inn : Inn <: numtype), $ext(n, $size((Inn : Inn <: numtype)), sx, c))])
    -- if ($ibytes(n, c) = $mem(z, x).BYTES_meminst[(i + ao.OFFSET_memarg!`%`_u32.0) : (n / 8)])

  ;; 8-reduction.watsup
  rule vload-oob{z : state, i : nat, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(), x, ao)]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + ($vsize(V128_vectype) / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule vload-val{z : state, i : nat, x : idx, ao : memarg, c : vec_(V128_Vnn)}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(), x, ao)]), [VCONST_instr(V128_vectype, c)])
    -- if ($vbytes(V128_vectype, c) = $mem(z, x).BYTES_meminst[(i + ao.OFFSET_memarg!`%`_u32.0) : ($vsize(V128_vectype) / 8)])

  ;; 8-reduction.watsup
  rule vload-shape-oob{z : state, i : nat, M : M, N : N, sx : sx, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(`SHAPE%X%%`_vloadop_(`%`_sz(M), N, sx)), x, ao)]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + ((M * N) / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule vload-shape-val{z : state, i : nat, M : M, N : N, sx : sx, x : idx, ao : memarg, c : vec_(V128_Vnn), j^N : nat^N, k^N : nat^N, Jnn : Jnn}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(`SHAPE%X%%`_vloadop_(`%`_sz(M), N, sx)), x, ao)]), [VCONST_instr(V128_vectype, c)])
    -- (if ($ibytes(M, `%`_iN(j)) = $mem(z, x).BYTES_meminst[((i + ao.OFFSET_memarg!`%`_u32.0) + ((k * M) / 8)) : (M / 8)]))^(k<N){j : nat, k : nat}
    -- if ($lsize((Jnn : Jnn <: lanetype)) = (M * 2))
    -- if (c = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(N)), $ext(M, $lsize((Jnn : Jnn <: lanetype)), sx, `%`_iN(j))^N{j : nat}))

  ;; 8-reduction.watsup
  rule vload-splat-oob{z : state, i : nat, N : N, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(N))), x, ao)]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + (N / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule vload-splat-val{z : state, i : nat, N : N, x : idx, ao : memarg, c : vec_(V128_Vnn), j : nat, Jnn : Jnn, M : M}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(N))), x, ao)]), [VCONST_instr(V128_vectype, c)])
    -- if ($ibytes(N, `%`_iN(j)) = $mem(z, x).BYTES_meminst[(i + ao.OFFSET_memarg!`%`_u32.0) : (N / 8)])
    -- if (N = $lsize((Jnn : Jnn <: lanetype)))
    -- if (M = (128 / N))
    -- if (c = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), `%`_lane_(j)^M{}))

  ;; 8-reduction.watsup
  rule vload-zero-oob{z : state, i : nat, N : N, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(N))), x, ao)]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + (N / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule vload-zero-val{z : state, i : nat, N : N, x : idx, ao : memarg, c : vec_(V128_Vnn), j : nat}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(N))), x, ao)]), [VCONST_instr(V128_vectype, c)])
    -- if ($ibytes(N, `%`_iN(j)) = $mem(z, x).BYTES_meminst[(i + ao.OFFSET_memarg!`%`_u32.0) : (N / 8)])
    -- if (c = $ext(N, 128, U_sx, `%`_iN(j)))

  ;; 8-reduction.watsup
  rule vload_lane-oob{z : state, i : nat, c_1 : vec_(V128_Vnn), N : N, x : idx, ao : memarg, j : nat}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VCONST_instr(V128_vectype, c_1) VLOAD_LANE_instr(V128_vectype, `%`_sz(N), x, ao, `%`_laneidx(j))]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + (N / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule vload_lane-val{z : state, i : nat, c_1 : vec_(V128_Vnn), N : N, x : idx, ao : memarg, j : nat, c : vec_(V128_Vnn), k : nat, Jnn : Jnn, M : M}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VCONST_instr(V128_vectype, c_1) VLOAD_LANE_instr(V128_vectype, `%`_sz(N), x, ao, `%`_laneidx(j))]), [VCONST_instr(V128_vectype, c)])
    -- if ($ibytes(N, `%`_iN(k)) = $mem(z, x).BYTES_meminst[(i + ao.OFFSET_memarg!`%`_u32.0) : (N / 8)])
    -- if (N = $lsize((Jnn : Jnn <: lanetype)))
    -- if (M = ($vsize(V128_vectype) / N))
    -- if (c = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c_1)[[j] = `%`_lane_(k)]))

  ;; 8-reduction.watsup
  rule memory.size{z : state, x : idx, n : n}:
    `%~>%`(`%;%`_config(z, [MEMORY.SIZE_instr(x)]), [CONST_instr(I32_numtype, `%`_num_(n))])
    -- if ((n * (64 * $Ki)) = |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule memory.fill-oob{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.FILL_instr(x)]), [TRAP_instr])
    -- if ((i + n) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule memory.fill-zero{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.FILL_instr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule memory.fill-succ{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.FILL_instr(x)]), [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) STORE_instr(I32_numtype, ?(`%`_sz(8)), x, $memarg0) CONST_instr(I32_numtype, `%`_num_((i + 1))) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_((n - 1))) MEMORY.FILL_instr(x)])
    -- otherwise

  ;; 8-reduction.watsup
  rule memory.copy-oob{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i_1)) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.COPY_instr(x_1, x_2)]), [TRAP_instr])
    -- if (((i_1 + n) > |$mem(z, x_1).BYTES_meminst|) \/ ((i_2 + n) > |$mem(z, x_2).BYTES_meminst|))

  ;; 8-reduction.watsup
  rule memory.copy-zero{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i_1)) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.COPY_instr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule memory.copy-le{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i_1)) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.COPY_instr(x_1, x_2)]), [CONST_instr(I32_numtype, `%`_num_(i_1)) CONST_instr(I32_numtype, `%`_num_(i_2)) LOAD_instr(I32_numtype, ?(`%%`_loadop_(`%`_sz(8), U_sx)), x_2, $memarg0) STORE_instr(I32_numtype, ?(`%`_sz(8)), x_1, $memarg0) CONST_instr(I32_numtype, `%`_num_((i_1 + 1))) CONST_instr(I32_numtype, `%`_num_((i_2 + 1))) CONST_instr(I32_numtype, `%`_num_((n - 1))) MEMORY.COPY_instr(x_1, x_2)])
    -- otherwise
    -- if (i_1 <= i_2)

  ;; 8-reduction.watsup
  rule memory.copy-gt{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i_1)) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.COPY_instr(x_1, x_2)]), [CONST_instr(I32_numtype, `%`_num_(((i_1 + n) - 1))) CONST_instr(I32_numtype, `%`_num_(((i_2 + n) - 1))) LOAD_instr(I32_numtype, ?(`%%`_loadop_(`%`_sz(8), U_sx)), x_2, $memarg0) STORE_instr(I32_numtype, ?(`%`_sz(8)), x_1, $memarg0) CONST_instr(I32_numtype, `%`_num_(i_1)) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_((n - 1))) MEMORY.COPY_instr(x_1, x_2)])
    -- otherwise

  ;; 8-reduction.watsup
  rule memory.init-oob{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.INIT_instr(x, y)]), [TRAP_instr])
    -- if (((i + n) > |$data(z, y).BYTES_datainst|) \/ ((j + n) > |$mem(z, x).BYTES_meminst|))

  ;; 8-reduction.watsup
  rule memory.init-zero{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.INIT_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule memory.init-succ{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.INIT_instr(x, y)]), [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_($data(z, y).BYTES_datainst[i]!`%`_byte.0)) STORE_instr(I32_numtype, ?(`%`_sz(8)), x, $memarg0) CONST_instr(I32_numtype, `%`_num_((j + 1))) CONST_instr(I32_numtype, `%`_num_((i + 1))) CONST_instr(I32_numtype, `%`_num_((n - 1))) MEMORY.INIT_instr(x, y)])
    -- otherwise

;; 8-reduction.watsup
rec {

;; 8-reduction.watsup:5.1-5.74
relation Step: `%~>%`(config, config)
  ;; 8-reduction.watsup:10.1-12.34
  rule pure{z : state, instr* : instr*, instr'* : instr*}:
    `%~>%`(`%;%`_config(z, instr*{instr : instr}), `%;%`_config(z, instr'*{instr' : instr}))
    -- Step_pure: `%~>%`(instr*{instr : instr}, instr'*{instr' : instr})

  ;; 8-reduction.watsup:14.1-16.37
  rule read{z : state, instr* : instr*, instr'* : instr*}:
    `%~>%`(`%;%`_config(z, instr*{instr : instr}), `%;%`_config(z, instr'*{instr' : instr}))
    -- Step_read: `%~>%`(`%;%`_config(z, instr*{instr : instr}), instr'*{instr' : instr})

  ;; 8-reduction.watsup:225.1-227.36
  rule ctxt-label{z : state, n : n, instr_0* : instr*, instr* : instr*, z' : state, instr'* : instr*}:
    `%~>%`(`%;%`_config(z, [`LABEL_%{%}%`_instr(n, instr_0*{instr_0 : instr}, instr*{instr : instr})]), `%;%`_config(z', [`LABEL_%{%}%`_instr(n, instr_0*{instr_0 : instr}, instr'*{instr' : instr})]))
    -- Step: `%~>%`(`%;%`_config(z, instr*{instr : instr}), `%;%`_config(z', instr'*{instr' : instr}))

  ;; 8-reduction.watsup:229.1-231.44
  rule ctxt-frame{s : store, f : frame, n : n, f' : frame, instr* : instr*, s' : store, instr'* : instr*}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [`FRAME_%{%}%`_instr(n, f', instr*{instr : instr})]), `%;%`_config(`%;%`_state(s', f), [`FRAME_%{%}%`_instr(n, f', instr'*{instr' : instr})]))
    -- Step: `%~>%`(`%;%`_config(`%;%`_state(s, f'), instr*{instr : instr}), `%;%`_config(`%;%`_state(s', f'), instr'*{instr' : instr}))

  ;; 8-reduction.watsup:349.1-353.64
  rule struct.new{z : state, val^n : val^n, n : n, x : idx, si : structinst, a : addr, mut^n : mut^n, zt^n : storagetype^n}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^n{val : val} :: [STRUCT.NEW_instr(x)]), `%;%`_config($ext_structinst(z, [si]), [REF.STRUCT_ADDR_instr(a)]))
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%`_structtype(`%%`_fieldtype(mut, zt)^n{mut : mut, zt : storagetype})))
    -- if (a = |$structinst(z)|)
    -- if (si = {TYPE $type(z, x), FIELDS $packfield(zt, val)^n{val : val, zt : storagetype}})

  ;; 8-reduction.watsup:369.1-370.53
  rule struct.set-null{z : state, ht : heaptype, val : val, x : idx, i : nat}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) (val : val <: instr) STRUCT.SET_instr(x, `%`_u32(i))]), `%;%`_config(z, [TRAP_instr]))

  ;; 8-reduction.watsup:372.1-374.45
  rule struct.set-struct{z : state, a : addr, val : val, x : idx, i : nat, zt* : storagetype*, mut* : mut*}:
    `%~>%`(`%;%`_config(z, [REF.STRUCT_ADDR_instr(a) (val : val <: instr) STRUCT.SET_instr(x, `%`_u32(i))]), `%;%`_config($with_struct(z, a, i, $packfield(zt*{zt : storagetype}[i], val)), []))
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%`_structtype(`%%`_fieldtype(mut, zt)*{mut : mut, zt : storagetype})))

  ;; 8-reduction.watsup:387.1-392.64
  rule array.new_fixed{z : state, val^n : val^n, n : n, x : idx, ai : arrayinst, a : addr, mut : mut, zt : storagetype}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^n{val : val} :: [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))]), `%;%`_config($ext_arrayinst(z, [ai]), [REF.ARRAY_ADDR_instr(a)]))
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ((a = |$arrayinst(z)|) /\ (ai = {TYPE $type(z, x), FIELDS $packfield(zt, val)^n{val : val}}))

  ;; 8-reduction.watsup:432.1-433.64
  rule array.set-null{z : state, ht : heaptype, i : nat, val : val, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) ARRAY.SET_instr(x)]), `%;%`_config(z, [TRAP_instr]))

  ;; 8-reduction.watsup:435.1-437.39
  rule array.set-oob{z : state, a : addr, i : nat, val : val, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) ARRAY.SET_instr(x)]), `%;%`_config(z, [TRAP_instr]))
    -- if (i >= |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; 8-reduction.watsup:439.1-442.43
  rule array.set-array{z : state, a : addr, i : nat, val : val, x : idx, zt : storagetype, mut : mut}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) ARRAY.SET_instr(x)]), `%;%`_config($with_array(z, a, i, $packfield(zt, val)), []))
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))

  ;; 8-reduction.watsup:737.1-738.56
  rule local.set{z : state, val : val, x : idx}:
    `%~>%`(`%;%`_config(z, [(val : val <: instr) LOCAL.SET_instr(x)]), `%;%`_config($with_local(z, x, val), []))

  ;; 8-reduction.watsup:750.1-751.58
  rule global.set{z : state, val : val, x : idx}:
    `%~>%`(`%;%`_config(z, [(val : val <: instr) GLOBAL.SET_instr(x)]), `%;%`_config($with_global(z, x, val), []))

  ;; 8-reduction.watsup:764.1-766.33
  rule table.set-oob{z : state, i : nat, ref : ref, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (ref : ref <: instr) TABLE.SET_instr(x)]), `%;%`_config(z, [TRAP_instr]))
    -- if (i >= |$table(z, x).REFS_tableinst|)

  ;; 8-reduction.watsup:768.1-770.32
  rule table.set-val{z : state, i : nat, ref : ref, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (ref : ref <: instr) TABLE.SET_instr(x)]), `%;%`_config($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).REFS_tableinst|)

  ;; 8-reduction.watsup:778.1-781.46
  rule table.grow-succeed{z : state, ref : ref, n : n, x : idx, ti : tableinst}:
    `%~>%`(`%;%`_config(z, [(ref : ref <: instr) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.GROW_instr(x)]), `%;%`_config($with_tableinst(z, x, ti), [CONST_instr(I32_numtype, `%`_num_(|$table(z, x).REFS_tableinst|))]))
    -- if (ti = $growtable($table(z, x), n, ref))

  ;; 8-reduction.watsup:783.1-784.80
  rule table.grow-fail{z : state, ref : ref, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [(ref : ref <: instr) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.GROW_instr(x)]), `%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_($invsigned(32, - (1 : nat <: int))))]))

  ;; 8-reduction.watsup:844.1-845.51
  rule elem.drop{z : state, x : idx}:
    `%~>%`(`%;%`_config(z, [ELEM.DROP_instr(x)]), `%;%`_config($with_elem(z, x, []), []))

  ;; 8-reduction.watsup:924.1-927.60
  rule store-num-oob{z : state, i : nat, nt : numtype, c : num_(nt), x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(nt, c) STORE_instr(nt, ?(), x, ao)]), `%;%`_config(z, [TRAP_instr]))
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + ($size(nt) / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup:929.1-933.28
  rule store-num-val{z : state, i : nat, nt : numtype, c : num_(nt), x : idx, ao : memarg, b* : byte*}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(nt, c) STORE_instr(nt, ?(), x, ao)]), `%;%`_config($with_mem(z, x, (i + ao.OFFSET_memarg!`%`_u32.0), ($size(nt) / 8), b*{b : byte}), []))
    -- if (b*{b : byte} = $nbytes(nt, c))

  ;; 8-reduction.watsup:935.1-938.52
  rule store-pack-oob{z : state, i : nat, Inn : Inn, c : num_((Inn : Inn <: numtype)), nt : numtype, n : n, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr((Inn : Inn <: numtype), c) STORE_instr(nt, ?(`%`_sz(n)), x, ao)]), `%;%`_config(z, [TRAP_instr]))
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + (n / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup:940.1-944.49
  rule store-pack-val{z : state, i : nat, Inn : Inn, c : num_((Inn : Inn <: numtype)), nt : numtype, n : n, x : idx, ao : memarg, b* : byte*}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr((Inn : Inn <: numtype), c) STORE_instr(nt, ?(`%`_sz(n)), x, ao)]), `%;%`_config($with_mem(z, x, (i + ao.OFFSET_memarg!`%`_u32.0), (n / 8), b*{b : byte}), []))
    -- if (b*{b : byte} = $ibytes(n, $wrap($size((Inn : Inn <: numtype)), n, c)))

  ;; 8-reduction.watsup:946.1-948.63
  rule vstore-oob{z : state, i : nat, c : vec_(V128_Vnn), x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VCONST_instr(V128_vectype, c) VSTORE_instr(V128_vectype, x, ao)]), `%;%`_config(z, [TRAP_instr]))
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + ($vsize(V128_vectype) / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup:950.1-952.30
  rule vstore-val{z : state, i : nat, c : vec_(V128_Vnn), x : idx, ao : memarg, b* : byte*}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VCONST_instr(V128_vectype, c) VSTORE_instr(V128_vectype, x, ao)]), `%;%`_config($with_mem(z, x, (i + ao.OFFSET_memarg!`%`_u32.0), ($vsize(V128_vectype) / 8), b*{b : byte}), []))
    -- if (b*{b : byte} = $vbytes(V128_vectype, c))

  ;; 8-reduction.watsup:955.1-957.50
  rule vstore_lane-oob{z : state, i : nat, c : vec_(V128_Vnn), N : N, x : idx, ao : memarg, j : nat}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VCONST_instr(V128_vectype, c) VSTORE_LANE_instr(V128_vectype, `%`_sz(N), x, ao, `%`_laneidx(j))]), `%;%`_config(z, [TRAP_instr]))
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + N) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup:959.1-963.48
  rule vstore_lane-val{z : state, i : nat, c : vec_(V128_Vnn), N : N, x : idx, ao : memarg, j : nat, b* : byte*, Jnn : Jnn, M : M}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VCONST_instr(V128_vectype, c) VSTORE_LANE_instr(V128_vectype, `%`_sz(N), x, ao, `%`_laneidx(j))]), `%;%`_config($with_mem(z, x, (i + ao.OFFSET_memarg!`%`_u32.0), (N / 8), b*{b : byte}), []))
    -- if (N = $lsize((Jnn : Jnn <: lanetype)))
    -- if (M = (128 / N))
    -- if (b*{b : byte} = $ibytes(N, `%`_iN($lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c)[j]!`%`_lane_.0)))

  ;; 8-reduction.watsup:971.1-974.37
  rule memory.grow-succeed{z : state, n : n, x : idx, mi : meminst}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.GROW_instr(x)]), `%;%`_config($with_meminst(z, x, mi), [CONST_instr(I32_numtype, `%`_num_((|$mem(z, x).BYTES_meminst| / (64 * $Ki))))]))
    -- if (mi = $growmem($mem(z, x), n))

  ;; 8-reduction.watsup:976.1-977.77
  rule memory.grow-fail{z : state, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.GROW_instr(x)]), `%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_($invsigned(32, - (1 : nat <: int))))]))

  ;; 8-reduction.watsup:1037.1-1038.51
  rule data.drop{z : state, x : idx}:
    `%~>%`(`%;%`_config(z, [DATA.DROP_instr(x)]), `%;%`_config($with_data(z, x, []), []))
}

;; 8-reduction.watsup
rec {

;; 8-reduction.watsup:8.1-8.78
relation Steps: `%~>*%`(config, config)
  ;; 8-reduction.watsup:18.1-19.26
  rule refl{z : state, instr* : instr*}:
    `%~>*%`(`%;%`_config(z, instr*{instr : instr}), `%;%`_config(z, instr*{instr : instr}))

  ;; 8-reduction.watsup:21.1-24.43
  rule trans{z : state, instr* : instr*, z'' : state, instr''* : instr*, z' : state, instr' : instr}:
    `%~>*%`(`%;%`_config(z, instr*{instr : instr}), `%;%`_config(z'', instr''*{instr'' : instr}))
    -- Step: `%~>%`(`%;%`_config(z, instr*{instr : instr}), `%;%`_config(z', instr'*{}))
    -- Steps: `%~>*%`(`%;%`_config(z', [instr']), `%;%`_config(z'', instr''*{instr'' : instr}))
}

;; 8-reduction.watsup
relation Eval_expr: `%;%~>*%;%`(state, expr, state, val*)
  ;; 8-reduction.watsup
  rule _{z : state, instr* : instr*, z' : state, val* : val*}:
    `%;%~>*%;%`(z, instr*{instr : instr}, z', val*{val : val})
    -- Steps: `%~>*%`(`%;%`_config(z, instr*{instr : instr}), `%;%`_config(z', (val : val <: instr)*{val : val}))

;; 9-module.watsup
rec {

;; 9-module.watsup:7.1-7.63
def $alloctypes(type*) : deftype*
  ;; 9-module.watsup:8.1-8.27
  def $alloctypes([]) = []
  ;; 9-module.watsup:9.1-13.24
  def $alloctypes{type'* : type*, type : type, deftype'* : deftype*, deftype* : deftype*, rectype : rectype, x : idx}(type'*{type' : type} :: [type]) = deftype'*{deftype' : deftype} :: deftype*{deftype : deftype}
    -- if (deftype'*{deftype' : deftype} = $alloctypes(type'*{type' : type}))
    -- if (type = TYPE_type(rectype))
    -- if (deftype*{deftype : deftype} = $subst_all_deftypes($rolldt(x, rectype), (deftype' : deftype <: heaptype)*{deftype' : deftype}))
    -- if (x = `%`_idx(|deftype'*{deftype' : deftype}|))
}

;; 9-module.watsup
def $allocfunc(store : store, deftype : deftype, funccode : funccode, moduleinst : moduleinst) : (store, funcaddr)
  ;; 9-module.watsup
  def $allocfunc{s : store, deftype : deftype, funccode : funccode, moduleinst : moduleinst, funcinst : funcinst}(s, deftype, funccode, moduleinst) = (s ++ {FUNCS [funcinst], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], STRUCTS [], ARRAYS []}, |s.FUNCS_store|)
    -- if (funcinst = {TYPE deftype, MODULE moduleinst, CODE funccode})

;; 9-module.watsup
rec {

;; 9-module.watsup:20.1-20.113
def $allocfuncs(store : store, deftype*, funccode*, moduleinst*) : (store, funcaddr*)
  ;; 9-module.watsup:21.1-21.45
  def $allocfuncs{s : store}(s, [], [], []) = (s, [])
  ;; 9-module.watsup:22.1-24.71
  def $allocfuncs{s : store, dt : deftype, dt'* : deftype*, funccode : funccode, funccode'* : funccode*, moduleinst : moduleinst, moduleinst'* : moduleinst*, s_2 : store, fa : funcaddr, fa'* : funcaddr*, s_1 : store}(s, [dt] :: dt'*{dt' : deftype}, [funccode] :: funccode'*{funccode' : funccode}, [moduleinst] :: moduleinst'*{moduleinst' : moduleinst}) = (s_2, [fa] :: fa'*{fa' : funcaddr})
    -- if ((s_1, fa) = $allocfunc(s, dt, funccode, moduleinst))
    -- if ((s_2, fa'*{fa' : funcaddr}) = $allocfuncs(s_1, dt'*{dt' : deftype}, funccode'*{funccode' : funccode}, moduleinst'*{moduleinst' : moduleinst}))
}

;; 9-module.watsup
def $allocglobal(store : store, globaltype : globaltype, val : val) : (store, globaladdr)
  ;; 9-module.watsup
  def $allocglobal{s : store, globaltype : globaltype, val : val, globalinst : globalinst}(s, globaltype, val) = (s ++ {FUNCS [], GLOBALS [globalinst], TABLES [], MEMS [], ELEMS [], DATAS [], STRUCTS [], ARRAYS []}, |s.GLOBALS_store|)
    -- if (globalinst = {TYPE globaltype, VALUE val})

;; 9-module.watsup
rec {

;; 9-module.watsup:31.1-31.102
def $allocglobals(store : store, globaltype*, val*) : (store, globaladdr*)
  ;; 9-module.watsup:32.1-32.42
  def $allocglobals{s : store}(s, [], []) = (s, [])
  ;; 9-module.watsup:33.1-35.62
  def $allocglobals{s : store, globaltype : globaltype, globaltype'* : globaltype*, val : val, val'* : val*, s_2 : store, ga : globaladdr, ga'* : globaladdr*, s_1 : store}(s, [globaltype] :: globaltype'*{globaltype' : globaltype}, [val] :: val'*{val' : val}) = (s_2, [ga] :: ga'*{ga' : globaladdr})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga' : globaladdr}) = $allocglobals(s_1, globaltype'*{globaltype' : globaltype}, val'*{val' : val}))
}

;; 9-module.watsup
def $alloctable(store : store, tabletype : tabletype, ref : ref) : (store, tableaddr)
  ;; 9-module.watsup
  def $alloctable{s : store, i : nat, j : nat, rt : reftype, ref : ref, tableinst : tableinst}(s, `%%`_tabletype(`[%..%]`_limits(`%`_u32(i), `%`_u32(j)), rt), ref) = (s ++ {FUNCS [], GLOBALS [], TABLES [tableinst], MEMS [], ELEMS [], DATAS [], STRUCTS [], ARRAYS []}, |s.TABLES_store|)
    -- if (tableinst = {TYPE `%%`_tabletype(`[%..%]`_limits(`%`_u32(i), `%`_u32(j)), rt), REFS ref^i{}})

;; 9-module.watsup
rec {

;; 9-module.watsup:42.1-42.98
def $alloctables(store : store, tabletype*, ref*) : (store, tableaddr*)
  ;; 9-module.watsup:43.1-43.41
  def $alloctables{s : store}(s, [], []) = (s, [])
  ;; 9-module.watsup:44.1-46.60
  def $alloctables{s : store, tabletype : tabletype, tabletype'* : tabletype*, ref : ref, ref'* : ref*, s_2 : store, ta : tableaddr, ta'* : tableaddr*, s_1 : store}(s, [tabletype] :: tabletype'*{tabletype' : tabletype}, [ref] :: ref'*{ref' : ref}) = (s_2, [ta] :: ta'*{ta' : tableaddr})
    -- if ((s_1, ta) = $alloctable(s, tabletype, ref))
    -- if ((s_2, ta'*{ta' : tableaddr}) = $alloctables(s_1, tabletype'*{tabletype' : tabletype}, ref'*{ref' : ref}))
}

;; 9-module.watsup
def $allocmem(store : store, memtype : memtype) : (store, memaddr)
  ;; 9-module.watsup
  def $allocmem{s : store, i : nat, j : nat, meminst : meminst}(s, `%PAGE`_memtype(`[%..%]`_limits(`%`_u32(i), `%`_u32(j)))) = (s ++ {FUNCS [], GLOBALS [], TABLES [], MEMS [meminst], ELEMS [], DATAS [], STRUCTS [], ARRAYS []}, |s.MEMS_store|)
    -- if (meminst = {TYPE `%PAGE`_memtype(`[%..%]`_limits(`%`_u32(i), `%`_u32(j))), BYTES `%`_byte(0)^(i * (64 * $Ki)){}})

;; 9-module.watsup
rec {

;; 9-module.watsup:53.1-53.82
def $allocmems(store : store, memtype*) : (store, memaddr*)
  ;; 9-module.watsup:54.1-54.34
  def $allocmems{s : store}(s, []) = (s, [])
  ;; 9-module.watsup:55.1-57.49
  def $allocmems{s : store, memtype : memtype, memtype'* : memtype*, s_2 : store, ma : memaddr, ma'* : memaddr*, s_1 : store}(s, [memtype] :: memtype'*{memtype' : memtype}) = (s_2, [ma] :: ma'*{ma' : memaddr})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma' : memaddr}) = $allocmems(s_1, memtype'*{memtype' : memtype}))
}

;; 9-module.watsup
def $allocelem(store : store, elemtype : elemtype, ref*) : (store, elemaddr)
  ;; 9-module.watsup
  def $allocelem{s : store, elemtype : elemtype, ref* : ref*, eleminst : eleminst}(s, elemtype, ref*{ref : ref}) = (s ++ {FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [eleminst], DATAS [], STRUCTS [], ARRAYS []}, |s.ELEMS_store|)
    -- if (eleminst = {TYPE elemtype, REFS ref*{ref : ref}})

;; 9-module.watsup
rec {

;; 9-module.watsup:64.1-64.97
def $allocelems(store : store, elemtype*, ref**) : (store, elemaddr*)
  ;; 9-module.watsup:65.1-65.40
  def $allocelems{s : store}(s, [], []) = (s, [])
  ;; 9-module.watsup:66.1-68.55
  def $allocelems{s : store, rt : reftype, rt'* : reftype*, ref* : ref*, ref'** : ref**, s_2 : store, ea : elemaddr, ea'* : elemaddr*, s_1 : store}(s, [rt] :: rt'*{rt' : elemtype}, [ref*{ref : ref}] :: ref'*{ref' : ref}*{ref' : ref}) = (s_2, [ea] :: ea'*{ea' : elemaddr})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref : ref}))
    -- if ((s_2, ea'*{ea' : elemaddr}) = $allocelems(s_2, rt'*{rt' : elemtype}, ref'*{ref' : ref}*{ref' : ref}))
}

;; 9-module.watsup
def $allocdata(store : store, datatype : datatype, byte*) : (store, dataaddr)
  ;; 9-module.watsup
  def $allocdata{s : store, byte* : byte*, datainst : datainst}(s, OK_datatype, byte*{byte : byte}) = (s ++ {FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [datainst], STRUCTS [], ARRAYS []}, |s.DATAS_store|)
    -- if (datainst = {BYTES byte*{byte : byte}})

;; 9-module.watsup
rec {

;; 9-module.watsup:75.1-75.98
def $allocdatas(store : store, datatype*, byte**) : (store, dataaddr*)
  ;; 9-module.watsup:76.1-76.40
  def $allocdatas{s : store}(s, [], []) = (s, [])
  ;; 9-module.watsup:77.1-79.53
  def $allocdatas{s : store, ok : datatype, ok'* : datatype*, b* : byte*, b'** : byte**, s_2 : store, da : dataaddr, da'* : dataaddr*, s_1 : store}(s, [ok] :: ok'*{ok' : datatype}, [b*{b : byte}] :: b'*{b' : byte}*{b' : byte}) = (s_2, [da] :: da'*{da' : dataaddr})
    -- if ((s_1, da) = $allocdata(s, ok, b*{b : byte}))
    -- if ((s_2, da'*{da' : dataaddr}) = $allocdatas(s_1, ok'*{ok' : datatype}, b'*{b' : byte}*{b' : byte}))
}

;; 9-module.watsup
def $allocexport(moduleinst : moduleinst, export : export) : exportinst
  ;; 9-module.watsup
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, FUNC_externidx(x))) = {NAME name, VALUE FUNC_externval(moduleinst.FUNCS_moduleinst[x!`%`_idx.0])}
  ;; 9-module.watsup
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, GLOBAL_externidx(x))) = {NAME name, VALUE GLOBAL_externval(moduleinst.GLOBALS_moduleinst[x!`%`_idx.0])}
  ;; 9-module.watsup
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, TABLE_externidx(x))) = {NAME name, VALUE TABLE_externval(moduleinst.TABLES_moduleinst[x!`%`_idx.0])}
  ;; 9-module.watsup
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, MEM_externidx(x))) = {NAME name, VALUE MEM_externval(moduleinst.MEMS_moduleinst[x!`%`_idx.0])}

;; 9-module.watsup
def $allocexports(moduleinst : moduleinst, export*) : exportinst*
  ;; 9-module.watsup
  def $allocexports{moduleinst : moduleinst, export* : export*}(moduleinst, export*{export : export}) = $allocexport(moduleinst, export)*{export : export}

;; 9-module.watsup
def $allocmodule(store : store, module : module, externval*, val*, ref*, ref**) : (store, moduleinst)
  ;; 9-module.watsup
  def $allocmodule{s : store, module : module, externval* : externval*, val_G* : val*, ref_T* : ref*, ref_E** : ref**, s_6 : store, moduleinst : moduleinst, type* : type*, import* : import*, func* : func*, global* : global*, table* : table*, mem* : mem*, elem* : elem*, data* : data*, start? : start?, export* : export*, x* : idx*, local** : local**, expr_F* : expr*, globaltype* : globaltype*, expr_G* : expr*, tabletype* : tabletype*, expr_T* : expr*, memtype* : memtype*, elemtype* : elemtype*, expr_E** : expr**, elemmode* : elemmode*, byte** : byte**, datamode* : datamode*, fa_I* : funcaddr*, ga_I* : globaladdr*, ta_I* : tableaddr*, ma_I* : memaddr*, fa* : funcaddr*, i_F^|func*{func : func}| : nat^|func*{func : func}|, ga* : globaladdr*, i_G^|global*{global : global}| : nat^|global*{global : global}|, ta* : tableaddr*, i_T^|table*{table : table}| : nat^|table*{table : table}|, ma* : memaddr*, i_M^|mem*{mem : mem}| : nat^|mem*{mem : mem}|, ea* : elemaddr*, i_E^|elem*{elem : elem}| : nat^|elem*{elem : elem}|, da* : dataaddr*, i_D^|data*{data : data}| : nat^|data*{data : data}|, dt* : deftype*, s_1 : store, s_2 : store, s_3 : store, s_4 : store, s_5 : store, xi* : exportinst*}(s, module, externval*{externval : externval}, val_G*{val_G : val}, ref_T*{ref_T : ref}, ref_E*{ref_E : ref}*{ref_E : ref}) = (s_6, moduleinst)
    -- if (module = MODULE_module(type*{type : type}, import*{import : import}, func*{func : func}, global*{global : global}, table*{table : table}, mem*{mem : mem}, elem*{elem : elem}, data*{data : data}, start?{start : start}, export*{export : export}))
    -- if (func*{func : func} = FUNC_func(x, local*{local : local}, expr_F)*{expr_F : expr, local : local, x : typeidx})
    -- if (global*{global : global} = GLOBAL_global(globaltype, expr_G)*{expr_G : expr, globaltype : globaltype})
    -- if (table*{table : table} = TABLE_table(tabletype, expr_T)*{expr_T : expr, tabletype : tabletype})
    -- if (mem*{mem : mem} = MEMORY_mem(memtype)*{memtype : memtype})
    -- if (elem*{elem : elem} = ELEM_elem(elemtype, expr_E*{expr_E : expr}, elemmode)*{elemmode : elemmode, elemtype : reftype, expr_E : expr})
    -- if (data*{data : data} = DATA_data(byte*{byte : byte}, datamode)*{byte : byte, datamode : datamode})
    -- if (fa_I*{fa_I : funcaddr} = $funcsxv(externval*{externval : externval}))
    -- if (ga_I*{ga_I : globaladdr} = $globalsxv(externval*{externval : externval}))
    -- if (ta_I*{ta_I : tableaddr} = $tablesxv(externval*{externval : externval}))
    -- if (ma_I*{ma_I : memaddr} = $memsxv(externval*{externval : externval}))
    -- if (fa*{fa : funcaddr} = (|s.FUNCS_store| + i_F)^(i_F<|func*{func : func}|){i_F : nat})
    -- if (ga*{ga : globaladdr} = (|s.GLOBALS_store| + i_G)^(i_G<|global*{global : global}|){i_G : nat})
    -- if (ta*{ta : tableaddr} = (|s.TABLES_store| + i_T)^(i_T<|table*{table : table}|){i_T : nat})
    -- if (ma*{ma : memaddr} = (|s.MEMS_store| + i_M)^(i_M<|mem*{mem : mem}|){i_M : nat})
    -- if (ea*{ea : elemaddr} = (|s.ELEMS_store| + i_E)^(i_E<|elem*{elem : elem}|){i_E : nat})
    -- if (da*{da : dataaddr} = (|s.DATAS_store| + i_D)^(i_D<|data*{data : data}|){i_D : nat})
    -- if (dt*{dt : deftype} = $alloctypes(type*{type : type}))
    -- if ((s_1, fa*{fa : funcaddr}) = $allocfuncs(s, dt*{dt : deftype}[x!`%`_idx.0]*{x : idx}, FUNC_funccode(x, local*{local : local}, expr_F)*{expr_F : expr, local : local, x : typeidx}, moduleinst^|func*{func : func}|{}))
    -- if ((s_2, ga*{ga : globaladdr}) = $allocglobals(s_1, globaltype*{globaltype : globaltype}, val_G*{val_G : val}))
    -- if ((s_3, ta*{ta : tableaddr}) = $alloctables(s_2, tabletype*{tabletype : tabletype}, ref_T*{ref_T : ref}))
    -- if ((s_4, ma*{ma : memaddr}) = $allocmems(s_3, memtype*{memtype : memtype}))
    -- if ((s_5, ea*{ea : elemaddr}) = $allocelems(s_4, elemtype*{elemtype : elemtype}, ref_E*{ref_E : ref}*{ref_E : ref}))
    -- if ((s_6, da*{da : dataaddr}) = $allocdatas(s_5, OK_datatype^|data*{data : data}|{}, byte*{byte : byte}*{byte : byte}))
    -- if (xi*{xi : exportinst} = $allocexports({TYPES [], FUNCS fa_I*{fa_I : funcaddr} :: fa*{fa : funcaddr}, GLOBALS ga_I*{ga_I : globaladdr} :: ga*{ga : globaladdr}, TABLES ta_I*{ta_I : tableaddr} :: ta*{ta : tableaddr}, MEMS ma_I*{ma_I : memaddr} :: ma*{ma : memaddr}, ELEMS [], DATAS [], EXPORTS []}, export*{export : export}))
    -- if (moduleinst = {TYPES dt*{dt : deftype}, FUNCS fa_I*{fa_I : funcaddr} :: fa*{fa : funcaddr}, GLOBALS ga_I*{ga_I : globaladdr} :: ga*{ga : globaladdr}, TABLES ta_I*{ta_I : tableaddr} :: ta*{ta : tableaddr}, MEMS ma_I*{ma_I : memaddr} :: ma*{ma : memaddr}, ELEMS ea*{ea : elemaddr}, DATAS da*{da : dataaddr}, EXPORTS xi*{xi : exportinst}})

;; 9-module.watsup
def $runelem_(elemidx : elemidx, elem : elem) : instr*
  ;; 9-module.watsup
  def $runelem_{x : idx, rt : reftype, e^n : expr^n, n : n}(x, ELEM_elem(rt, e^n{e : expr}, PASSIVE_elemmode)) = []
  ;; 9-module.watsup
  def $runelem_{x : idx, rt : reftype, e^n : expr^n, n : n}(x, ELEM_elem(rt, e^n{e : expr}, DECLARE_elemmode)) = [ELEM.DROP_instr(x)]
  ;; 9-module.watsup
  def $runelem_{x : idx, rt : reftype, e^n : expr^n, n : n, y : idx, instr* : instr*}(x, ELEM_elem(rt, e^n{e : expr}, ACTIVE_elemmode(y, instr*{instr : instr}))) = instr*{instr : instr} :: [CONST_instr(I32_numtype, `%`_num_(0)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.INIT_instr(y, x) ELEM.DROP_instr(x)]

;; 9-module.watsup
def $rundata_(dataidx : dataidx, data : data) : instr*
  ;; 9-module.watsup
  def $rundata_{x : idx, b^n : byte^n, n : n}(x, DATA_data(b^n{b : byte}, PASSIVE_datamode)) = []
  ;; 9-module.watsup
  def $rundata_{x : idx, b^n : byte^n, n : n, y : idx, instr* : instr*}(x, DATA_data(b^n{b : byte}, ACTIVE_datamode(y, instr*{instr : instr}))) = instr*{instr : instr} :: [CONST_instr(I32_numtype, `%`_num_(0)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.INIT_instr(y, x) DATA.DROP_instr(x)]

;; 9-module.watsup
def $instantiate(store : store, module : module, externval*) : config
  ;; 9-module.watsup
  def $instantiate{s : store, module : module, externval* : externval*, s' : store, f : frame, instr_E* : instr*, instr_D* : instr*, instr_S? : instr?, type* : type*, import* : import*, func* : func*, global* : global*, table* : table*, mem* : mem*, elem* : elem*, data* : data*, start? : start?, export* : export*, globaltype* : globaltype*, expr_G* : expr*, tabletype* : tabletype*, expr_T* : expr*, reftype* : reftype*, expr_E** : expr**, elemmode* : elemmode*, byte** : byte**, datamode* : datamode*, x? : idx?, moduleinst_0 : moduleinst, i_F^|func*{func : func}| : nat^|func*{func : func}|, z : state, val_G* : val*, ref_T* : ref*, ref_E** : ref**, moduleinst : moduleinst, i_E^|elem*{elem : elem}| : nat^|elem*{elem : elem}|, i_D^|data*{data : data}| : nat^|data*{data : data}|}(s, module, externval*{externval : externval}) = `%;%`_config(`%;%`_state(s', f), instr_E*{instr_E : instr} :: instr_D*{instr_D : instr} :: instr_S?{instr_S : instr})
    -- if (module = MODULE_module(type*{type : type}, import*{import : import}, func*{func : func}, global*{global : global}, table*{table : table}, mem*{mem : mem}, elem*{elem : elem}, data*{data : data}, start?{start : start}, export*{export : export}))
    -- if (global*{global : global} = GLOBAL_global(globaltype, expr_G)*{expr_G : expr, globaltype : globaltype})
    -- if (table*{table : table} = TABLE_table(tabletype, expr_T)*{expr_T : expr, tabletype : tabletype})
    -- if (elem*{elem : elem} = ELEM_elem(reftype, expr_E*{expr_E : expr}, elemmode)*{elemmode : elemmode, expr_E : expr, reftype : reftype})
    -- if (data*{data : data} = DATA_data(byte*{byte : byte}, datamode)*{byte : byte, datamode : datamode})
    -- if (start?{start : start} = START_start(x)?{x : funcidx})
    -- if (moduleinst_0 = {TYPES $alloctypes(type*{type : type}), FUNCS $funcsxv(externval*{externval : externval}) :: (|s.FUNCS_store| + i_F)^(i_F<|func*{func : func}|){i_F : nat}, GLOBALS $globalsxv(externval*{externval : externval}), TABLES [], MEMS [], ELEMS [], DATAS [], EXPORTS []})
    -- if (z = `%;%`_state(s, {LOCALS [], MODULE moduleinst_0}))
    -- (Eval_expr: `%;%~>*%;%`(z, expr_G, z, [val_G]))*{expr_G : expr, val_G : val}
    -- (Eval_expr: `%;%~>*%;%`(z, expr_T, z, [(ref_T : ref <: val)]))*{expr_T : expr, ref_T : ref}
    -- (Eval_expr: `%;%~>*%;%`(z, expr_E, z, [(ref_E : ref <: val)]))*{expr_E : expr, ref_E : ref}*{expr_E : expr, ref_E : ref}
    -- if ((s', moduleinst) = $allocmodule(s, module, externval*{externval : externval}, val_G*{val_G : val}, ref_T*{ref_T : ref}, ref_E*{ref_E : ref}*{ref_E : ref}))
    -- if (f = {LOCALS [], MODULE moduleinst})
    -- if (instr_E*{instr_E : instr} = $concat_(syntax instr, $runelem_(`%`_elemidx(i_E), elem*{elem : elem}[i_E])^(i_E<|elem*{elem : elem}|){i_E : nat}))
    -- if (instr_D*{instr_D : instr} = $concat_(syntax instr, $rundata_(`%`_dataidx(i_D), data*{data : data}[i_D])^(i_D<|data*{data : data}|){i_D : nat}))
    -- if (instr_S?{instr_S : instr} = CALL_instr(x)?{x : funcidx})

;; 9-module.watsup
def $invoke(store : store, funcaddr : funcaddr, val*) : config
  ;; 9-module.watsup
  def $invoke{s : store, funcaddr : funcaddr, val* : val*, f : frame, t_1* : valtype*, t_2* : valtype*}(s, funcaddr, val*{val : val}) = `%;%`_config(`%;%`_state(s, f), (val : val <: instr)*{val : val} :: [REF.FUNC_ADDR_instr(funcaddr) CALL_REF_instr((s.FUNCS_store[funcaddr].TYPE_funcinst : deftype <: typeuse))])
    -- Expand: `%~~%`(s.FUNCS_store[funcaddr].TYPE_funcinst, FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype}))))
    -- if (f = {LOCALS [], MODULE {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], EXPORTS []}})

;; A-binary.watsup
syntax castop = (nul, nul)

;; A-binary.watsup
syntax memidxop = (memidx, memarg)

;; A-binary.watsup
syntax code = (local*, expr)

;; C-conventions.watsup
syntax A = nat

;; C-conventions.watsup
syntax B = nat

;; C-conventions.watsup
syntax sym =
  | _FIRST{A_1 : A}(A_1 : A)
  | _DOTS
  | _LAST{A_n : A}(A_n : A)

;; C-conventions.watsup
syntax symsplit =
  | _FIRST{A_1 : A}(A_1 : A)
  | _LAST{A_2 : A}(A_2 : A)

;; C-conventions.watsup
syntax recorddots =
  | `()`

;; C-conventions.watsup
syntax record =
{
  FIELD_1{A_1 : A} A,
  FIELD_2{A_2 : A} A,
  `...`{recorddots : recorddots} recorddots
}

;; C-conventions.watsup
syntax pth =
  | PTHSYNTAX

;; C-conventions.watsup
syntax T = nat

;; C-conventions.watsup
relation NotationTypingPremise: `%`(nat)

;; C-conventions.watsup
relation NotationTypingPremisedots: `...`

;; C-conventions.watsup
relation NotationTypingScheme: `%`(nat)
  ;; C-conventions.watsup
  rule _{conclusion : nat, premise_1 : nat, premise_2 : nat, premise_n : nat}:
    `%`(conclusion)
    -- NotationTypingPremise: `%`(premise_1)
    -- NotationTypingPremise: `%`(premise_2)
    -- NotationTypingPremisedots: `...`
    -- NotationTypingPremise: `%`(premise_n)

;; C-conventions.watsup
rec {

;; C-conventions.watsup:38.1-38.82
relation NotationTypingInstrScheme: `%|-%:%`(context, instr*, functype)
  ;; C-conventions.watsup:40.1-41.38
  rule i32.add{C : context}:
    `%|-%:%`(C, [BINOP_instr(I32_numtype, ADD_binop_)], `%->%`_functype(`%`_resulttype([I32_valtype I32_valtype]), `%`_resulttype([I32_valtype])))

  ;; C-conventions.watsup:43.1-45.29
  rule global.get{C : context, x : idx, t : valtype, mut : mut}:
    `%|-%:%`(C, [GLOBAL.GET_instr(x)], `%->%`_functype(`%`_resulttype([]), `%`_resulttype([t])))
    -- if (C.GLOBALS_context[x!`%`_idx.0] = `%%`_globaltype(mut, t))

  ;; C-conventions.watsup:47.1-50.74
  rule block{C : context, blocktype : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, [BLOCK_instr(blocktype, instr*{instr : instr})], `%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype})))
    -- Blocktype_ok: `%|-%:%`(C, blocktype, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 : valtype}), [], `%`_resulttype(t_2*{t_2 : valtype})))
    -- NotationTypingInstrScheme: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 : valtype})], RETURN ?(), REFS []} ++ C, instr*{instr : instr}, `%->%`_functype(`%`_resulttype(t_1*{t_1 : valtype}), `%`_resulttype(t_2*{t_2 : valtype})))
}

;; C-conventions.watsup
relation NotationReduct: `~>%`(instr*)
  ;; C-conventions.watsup
  rule 2{q_1 : num_(F64_numtype), q_4 : num_(F64_numtype), q_3 : num_(F64_numtype)}:
    `~>%`([CONST_instr(F64_numtype, q_1) CONST_instr(F64_numtype, q_4) CONST_instr(F64_numtype, q_3) BINOP_instr(F64_numtype, ADD_binop_) BINOP_instr(F64_numtype, MUL_binop_)])

  ;; C-conventions.watsup
  rule 3{q_1 : num_(F64_numtype), q_5 : num_(F64_numtype)}:
    `~>%`([CONST_instr(F64_numtype, q_1) CONST_instr(F64_numtype, q_5) BINOP_instr(F64_numtype, MUL_binop_)])

  ;; C-conventions.watsup
  rule 4{q_6 : num_(F64_numtype)}:
    `~>%`([CONST_instr(F64_numtype, q_6)])

;; C-conventions.watsup
def $instrdots : instr*

;; C-conventions.watsup
syntax label =
  | `LABEL_%{%}`{n : n, instr* : instr*}(n : n, instr*{instr : instr} : instr*)

;; C-conventions.watsup
syntax callframe =
  | `FRAME_%{%}`{n : n, frame : frame}(n : n, frame : frame)

;; C-conventions.watsup
def $allocX(syntax X, syntax Y, store : store, X : X, Y : Y) : (store, addr)

;; C-conventions.watsup
rec {

;; C-conventions.watsup:80.1-80.117
def $allocXs(syntax X, syntax Y, store : store, X*, Y*) : (store, addr*)
  ;; C-conventions.watsup:81.1-81.57
  def $allocXs{syntax X, syntax Y, s : store}(syntax X, syntax Y, s, [], []) = (s, [])
  ;; C-conventions.watsup:82.1-84.65
  def $allocXs{syntax X, syntax Y, s : store, X : X, X'* : X*, Y : Y, Y'* : Y*, s_2 : store, a : addr, a'* : addr*, s_1 : store}(syntax X, syntax Y, s, [X] :: X'*{X' : X}, [Y] :: Y'*{Y' : Y}) = (s_2, [a] :: a'*{a' : addr})
    -- if ((s_1, a) = $allocX(syntax X, syntax Y, s, X, Y))
    -- if ((s_2, a'*{a' : addr}) = $allocXs(syntax X, syntax Y, s_1, X'*{X' : X}, Y'*{Y' : Y}))
}

;; C-conventions.watsup
def $symdots : A

== IL Validation...
== Complete.
```
