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
syntax K = nat

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

;; 0-aux.watsup:28.1-28.25
def $min(nat : nat, nat : nat) : nat
  ;; 0-aux.watsup:29.1-29.19
  def $min{j : nat}(0, j) = 0
  ;; 0-aux.watsup:30.1-30.19
  def $min{i : nat}(i, 0) = 0
  ;; 0-aux.watsup:31.1-31.38
  def $min{i : nat, j : nat}((i + 1), (j + 1)) = $min(i, j)
}

;; 0-aux.watsup
rec {

;; 0-aux.watsup:33.1-33.56
def $sum(nat*) : nat
  ;; 0-aux.watsup:34.1-34.18
  def $sum([]) = 0
  ;; 0-aux.watsup:35.1-35.35
  def $sum{n : n, `n'*` : n*}([n] ++ n'*{n' <- `n'*`}) = (n + $sum(n'*{n' <- `n'*`}))
}

;; 0-aux.watsup
rec {

;; 0-aux.watsup:37.1-37.57
def $prod(nat*) : nat
  ;; 0-aux.watsup:38.1-38.19
  def $prod([]) = 1
  ;; 0-aux.watsup:39.1-39.37
  def $prod{n : n, `n'*` : n*}([n] ++ n'*{n' <- `n'*`}) = (n * $prod(n'*{n' <- `n'*`}))
}

;; 0-aux.watsup
def $opt_(syntax X, X*) : X?
  ;; 0-aux.watsup
  def $opt_{syntax X}(syntax X, []) = ?()
  ;; 0-aux.watsup
  def $opt_{syntax X, w : X}(syntax X, [w]) = ?(w)

;; 0-aux.watsup
def $list_(syntax X, X?) : X*
  ;; 0-aux.watsup
  def $list_{syntax X}(syntax X, ?()) = []
  ;; 0-aux.watsup
  def $list_{syntax X, w : X}(syntax X, ?(w)) = [w]

;; 0-aux.watsup
rec {

;; 0-aux.watsup:53.1-53.55
def $concat_(syntax X, X**) : X*
  ;; 0-aux.watsup:54.1-54.34
  def $concat_{syntax X}(syntax X, []) = []
  ;; 0-aux.watsup:55.1-55.64
  def $concat_{syntax X, `w*` : X*, `w'**` : X**}(syntax X, [w*{w <- `w*`}] ++ w'*{w' <- `w'*`}*{`w'*` <- `w'**`}) = w*{w <- `w*`} ++ $concat_(syntax X, w'*{w' <- `w'*`}*{`w'*` <- `w'**`})
}

;; 0-aux.watsup
rec {

;; 0-aux.watsup:57.1-57.61
def $concatn_(syntax X, X**, nat : nat) : X*
  ;; 0-aux.watsup:58.1-58.38
  def $concatn_{syntax X, n : n}(syntax X, [], n) = []
  ;; 0-aux.watsup:59.1-59.73
  def $concatn_{syntax X, `w*` : X*, n : n, `w'**` : X**}(syntax X, [w^n{w <- `w*`}] ++ w'^n{w' <- `w'*`}*{`w'*` <- `w'**`}, n) = w^n{w <- `w*`} ++ $concatn_(syntax X, w'^n{w' <- `w'*`}*{`w'*` <- `w'**`}, n)
}

;; 0-aux.watsup
rec {

;; 0-aux.watsup:61.1-61.78
def $disjoint_(syntax X, X*) : bool
  ;; 0-aux.watsup:62.1-62.37
  def $disjoint_{syntax X}(syntax X, []) = true
  ;; 0-aux.watsup:63.1-63.68
  def $disjoint_{syntax X, w : X, `w'*` : X*}(syntax X, [w] ++ w'*{w' <- `w'*`}) = (~ w <- w'*{w' <- `w'*`} /\ $disjoint_(syntax X, w'*{w' <- `w'*`}))
}

;; 0-aux.watsup
rec {

;; 0-aux.watsup:66.1-66.38
def $setminus1_(syntax X, X : X, X*) : X*
  ;; 0-aux.watsup:70.1-70.38
  def $setminus1_{syntax X, w : X}(syntax X, w, []) = [w]
  ;; 0-aux.watsup:71.1-71.78
  def $setminus1_{syntax X, w : X, w_1 : X, `w'*` : X*}(syntax X, w, [w_1] ++ w'*{w' <- `w'*`}) = []
    -- if (w = w_1)
  ;; 0-aux.watsup:72.1-72.77
  def $setminus1_{syntax X, w : X, w_1 : X, `w'*` : X*}(syntax X, w, [w_1] ++ w'*{w' <- `w'*`}) = $setminus1_(syntax X, w, w'*{w' <- `w'*`})
    -- otherwise
}

;; 0-aux.watsup
rec {

;; 0-aux.watsup:65.1-65.56
def $setminus_(syntax X, X*, X*) : X*
  ;; 0-aux.watsup:68.1-68.40
  def $setminus_{syntax X, `w*` : X*}(syntax X, [], w*{w <- `w*`}) = []
  ;; 0-aux.watsup:69.1-69.90
  def $setminus_{syntax X, w_1 : X, `w'*` : X*, `w*` : X*}(syntax X, [w_1] ++ w'*{w' <- `w'*`}, w*{w <- `w*`}) = $setminus1_(syntax X, w_1, w*{w <- `w*`}) ++ $setminus_(syntax X, w'*{w' <- `w'*`}, w*{w <- `w*`})
}

;; 0-aux.watsup
rec {

;; 0-aux.watsup:77.1-77.46
def $setproduct2_(syntax X, X : X, X**) : X**
  ;; 0-aux.watsup:83.1-83.44
  def $setproduct2_{syntax X, w_1 : X}(syntax X, w_1, []) = []
  ;; 0-aux.watsup:84.1-84.90
  def $setproduct2_{syntax X, w_1 : X, `w'*` : X*, `w**` : X**}(syntax X, w_1, [w'*{w' <- `w'*`}] ++ w*{w <- `w*`}*{`w*` <- `w**`}) = [[w_1] ++ w'*{w' <- `w'*`}] ++ $setproduct2_(syntax X, w_1, w*{w <- `w*`}*{`w*` <- `w**`})
}

;; 0-aux.watsup
rec {

;; 0-aux.watsup:76.1-76.47
def $setproduct1_(syntax X, X*, X**) : X**
  ;; 0-aux.watsup:81.1-81.46
  def $setproduct1_{syntax X, `w**` : X**}(syntax X, [], w*{w <- `w*`}*{`w*` <- `w**`}) = []
  ;; 0-aux.watsup:82.1-82.107
  def $setproduct1_{syntax X, w_1 : X, `w'*` : X*, `w**` : X**}(syntax X, [w_1] ++ w'*{w' <- `w'*`}, w*{w <- `w*`}*{`w*` <- `w**`}) = $setproduct2_(syntax X, w_1, w*{w <- `w*`}*{`w*` <- `w**`}) ++ $setproduct1_(syntax X, w'*{w' <- `w'*`}, w*{w <- `w*`}*{`w*` <- `w**`})
}

;; 0-aux.watsup
rec {

;; 0-aux.watsup:75.1-75.82
def $setproduct_(syntax X, X**) : X**
  ;; 0-aux.watsup:79.1-79.40
  def $setproduct_{syntax X}(syntax X, []) = [[]]
  ;; 0-aux.watsup:80.1-80.90
  def $setproduct_{syntax X, `w_1*` : X*, `w**` : X**}(syntax X, [w_1*{w_1 <- `w_1*`}] ++ w*{w <- `w*`}*{`w*` <- `w**`}) = $setproduct1_(syntax X, w_1*{w_1 <- `w_1*`}, $setproduct_(syntax X, w*{w <- `w*`}*{`w*` <- `w**`}))
}

;; 1-syntax.watsup
def $ND : bool

;; 1-syntax.watsup
syntax list{syntax X}(syntax X) =
  | `%`{`X*` : X*}(X*{X <- `X*`} : X*)
    -- if (|X*{X <- `X*`}| < (2 ^ 32))

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
  | SUBNORM{m : m, n : n}(m : m)
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

;; 1-syntax.watsup:94.1-94.25
def $utf8(char*) : byte*
  ;; A-binary.watsup:53.1-53.44
  def $utf8{`ch*` : char*}(ch*{ch <- `ch*`}) = $concat_(syntax byte, $utf8([ch])*{ch <- `ch*`})
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
  | `%`{`char*` : char*}(char*{char <- `char*`} : char*)
    -- if (|$utf8(char*{char <- `char*`})| < (2 ^ 32))

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
syntax tagidx = idx

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
  | EXN
  | NOEXN
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

;; 1-syntax.watsup:162.1-163.26
syntax typeuse =
  | _IDX{typeidx : typeidx}(typeidx : typeidx)
  | DEF{rectype : rectype, n : n}(rectype : rectype, n : n)
  | REC{n : n}(n : n)

;; 1-syntax.watsup:165.1-166.26
syntax heaptype =
  | ANY
  | EQ
  | I31
  | STRUCT
  | ARRAY
  | NONE
  | FUNC
  | NOFUNC
  | EXN
  | NOEXN
  | EXTERN
  | NOEXTERN
  | BOT
  | _IDX{typeidx : typeidx}(typeidx : typeidx)
  | REC{n : n}(n : n)
  | DEF{rectype : rectype, n : n}(rectype : rectype, n : n)

;; 1-syntax.watsup:173.1-174.14
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | REF{nul : nul, heaptype : heaptype}(nul : nul, heaptype : heaptype)
  | BOT

;; 1-syntax.watsup:203.1-204.16
syntax resulttype = list(syntax valtype)

;; 1-syntax.watsup:211.1-211.66
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

;; 1-syntax.watsup:227.1-227.60
syntax fieldtype =
  | `%%`{mut : mut, storagetype : storagetype}(mut : mut, storagetype : storagetype)

;; 1-syntax.watsup:229.1-229.90
syntax functype =
  | `%->%`{resulttype : resulttype}(resulttype : resulttype, resulttype)

;; 1-syntax.watsup:230.1-230.64
syntax structtype = list(syntax fieldtype)

;; 1-syntax.watsup:231.1-231.54
syntax arraytype = fieldtype

;; 1-syntax.watsup:233.1-236.18
syntax comptype =
  | STRUCT{structtype : structtype}(structtype : structtype)
  | ARRAY{arraytype : arraytype}(arraytype : arraytype)
  | FUNC{functype : functype}(functype : functype)

;; 1-syntax.watsup:238.1-239.30
syntax subtype =
  | SUB{fin : fin, `typeuse*` : typeuse*, comptype : comptype}(fin : fin, typeuse*{typeuse <- `typeuse*`} : typeuse*, comptype : comptype)

;; 1-syntax.watsup:241.1-242.22
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
syntax tagtype = deftype

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
  | TAG{typeuse : typeuse}(typeuse : typeuse)

;; 1-syntax.watsup
syntax moduletype =
  | `%->%`{`externtype*` : externtype*}(externtype*{externtype <- `externtype*`} : externtype*, externtype*)

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
syntax cvtop__(numtype_1 : numtype, numtype_2 : numtype)
  ;; 1-syntax.watsup
  syntax cvtop__{Inn_1 : Inn, Inn_2 : Inn}((Inn_1 : Inn <: numtype), (Inn_2 : Inn <: numtype)) =
  | EXTEND{sx : sx}(sx : sx)
    -- if ($sizenn1((Inn_1 : Inn <: numtype)) < $sizenn2((Inn_2 : Inn <: numtype)))
  | WRAP
    -- if ($sizenn1((Inn_1 : Inn <: numtype)) > $sizenn2((Inn_2 : Inn <: numtype)))


  ;; 1-syntax.watsup
  syntax cvtop__{Inn_1 : Inn, Fnn_2 : Fnn}((Inn_1 : Inn <: numtype), (Fnn_2 : Fnn <: numtype)) =
  | CONVERT{sx : sx}(sx : sx)
  | REINTERPRET
    -- if ($sizenn1((Inn_1 : Inn <: numtype)) = $sizenn2((Fnn_2 : Fnn <: numtype)))


  ;; 1-syntax.watsup
  syntax cvtop__{Fnn_1 : Fnn, Inn_2 : Inn}((Fnn_1 : Fnn <: numtype), (Inn_2 : Inn <: numtype)) =
  | TRUNC{sx : sx}(sx : sx)
  | TRUNC_SAT{sx : sx}(sx : sx)
  | REINTERPRET
    -- if ($sizenn1((Fnn_1 : Fnn <: numtype)) = $sizenn2((Inn_2 : Inn <: numtype)))


  ;; 1-syntax.watsup
  syntax cvtop__{Fnn_1 : Fnn, Fnn_2 : Fnn}((Fnn_1 : Fnn <: numtype), (Fnn_2 : Fnn <: numtype)) =
  | PROMOTE
    -- if ($sizenn1((Fnn_1 : Fnn <: numtype)) < $sizenn2((Fnn_2 : Fnn <: numtype)))
  | DEMOTE
    -- if ($sizenn1((Fnn_1 : Fnn <: numtype)) > $sizenn2((Fnn_2 : Fnn <: numtype)))


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
syntax half__(shape_1 : shape, shape_2 : shape)
  ;; 1-syntax.watsup
  syntax half__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))) =
  | LOW
  | HIGH
    -- if ((2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))) = $lsizenn1((Jnn_2 : Jnn <: lanetype)))


  ;; 1-syntax.watsup
  syntax half__{Lnn_1 : Lnn, M_1 : M, Fnn_2 : Fnn, M_2 : M}(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2))) =
  | LOW
    -- if (((2 * $lsizenn1(Lnn_1)) = $sizenn1((Fnn_2 : Fnn <: numtype))) /\ ($sizenn1((Fnn_2 : Fnn <: numtype)) = 64))


;; 1-syntax.watsup
syntax zero__{Fnn_1 : Fnn, M_1 : M, Lnn_2 : Lnn, M_2 : M}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2))) =
  | ZERO
    -- if (((2 * $lsizenn2(Lnn_2)) = $sizenn1((Fnn_1 : Fnn <: numtype))) /\ ($sizenn1((Fnn_1 : Fnn <: numtype)) = 64))

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
  | POPCNT
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
  | `AVGRU`
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) <= 16)
  | `Q15MULR_SATS`
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) = 16)
  | `RELAXED_Q15MULRS`
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
  | RELAXED_MIN
  | RELAXED_MAX


;; 1-syntax.watsup
syntax vternop_(shape : shape)
  ;; 1-syntax.watsup
  syntax vternop_{Jnn : Jnn, M : M}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))) =
  | RELAXED_LANESELECT


  ;; 1-syntax.watsup
  syntax vternop_{Fnn : Fnn, M : M}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))) =
  | RELAXED_MADD
  | RELAXED_NMADD


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
syntax vcvtop__(shape_1 : shape, shape_2 : shape)
  ;; 1-syntax.watsup
  syntax vcvtop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))) =
  | EXTEND{sx : sx}(sx : sx)
    -- if ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = (2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))))


  ;; 1-syntax.watsup
  syntax vcvtop__{Jnn_1 : Jnn, M_1 : M, Fnn_2 : Fnn, M_2 : M}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2))) =
  | CONVERT{sx : sx}(sx : sx)
    -- if (($sizenn2((Fnn_2 : Fnn <: numtype)) >= $lsizenn1((Jnn_1 : Jnn <: lanetype))) /\ ($lsizenn1((Jnn_1 : Jnn <: lanetype)) = 32))


  ;; 1-syntax.watsup
  syntax vcvtop__{Fnn_1 : Fnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))) =
  | TRUNC_SAT{sx : sx}(sx : sx)
    -- if (($sizenn1((Fnn_1 : Fnn <: numtype)) >= $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = 32))
  | RELAXED_TRUNC{sx : sx}(sx : sx)
    -- if (($sizenn1((Fnn_1 : Fnn <: numtype)) >= $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = 32))


  ;; 1-syntax.watsup
  syntax vcvtop__{Fnn_1 : Fnn, M_1 : M, Fnn_2 : Fnn, M_2 : M}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2))) =
  | DEMOTE
    -- if ($sizenn1((Fnn_1 : Fnn <: numtype)) > $sizenn2((Fnn_2 : Fnn <: numtype)))
  | PROMOTE
    -- if ($sizenn1((Fnn_1 : Fnn <: numtype)) < $sizenn2((Fnn_2 : Fnn <: numtype)))


;; 1-syntax.watsup
syntax vswizzlop_{M : M}(`%X%`_ishape(I8_Jnn, `%`_dim(M))) =
  | SWIZZLE
  | RELAXED_SWIZZLE

;; 1-syntax.watsup
syntax vshiftop_{Jnn : Jnn, M : M}(`%X%`_ishape(Jnn, `%`_dim(M))) =
  | SHL
  | SHR{sx : sx}(sx : sx)

;; 1-syntax.watsup
syntax vextunop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%X%`_ishape(Jnn_1, `%`_dim(M_1)), `%X%`_ishape(Jnn_2, `%`_dim(M_2))) =
  | EXTADD_PAIRWISE{sx : sx}(sx : sx)
    -- if ((16 <= (2 * $lsizenn1((Jnn_1 : Jnn <: lanetype)))) /\ (((2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))) = $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) <= 32)))

;; 1-syntax.watsup
syntax vextbinop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%X%`_ishape(Jnn_1, `%`_dim(M_1)), `%X%`_ishape(Jnn_2, `%`_dim(M_2))) =
  | EXTMUL{sx : sx, half__ : half__(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)))}(sx : sx, half__ : half__(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))))
    -- if (((2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))) = $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) >= 16))
  | `DOTS`
    -- if (((2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))) = $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = 32))
  | `RELAXED_DOTS`
    -- if (((2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))) = $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = 16))

;; 1-syntax.watsup
syntax vextternop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%X%`_ishape(Jnn_1, `%`_dim(M_1)), `%X%`_ishape(Jnn_2, `%`_dim(M_2))) =
  | `RELAXED_DOT_ADDS`
    -- if (((4 * $lsizenn1((Jnn_1 : Jnn <: lanetype))) = $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = 32))

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
  | `SHAPE%X%%`{sz : sz, M : M, sx : sx}(sz : sz, M : M, sx : sx)
    -- if ((sz!`%`_sz.0 * M) = ($vsize(vectype) / 2))
  | SPLAT{sz : sz}(sz : sz)
  | ZERO{sz : sz}(sz : sz)
    -- if (sz!`%`_sz.0 >= 32)

;; 1-syntax.watsup
syntax blocktype =
  | _RESULT{`valtype?` : valtype?}(valtype?{valtype <- `valtype?`} : valtype?)
  | _IDX{funcidx : funcidx}(funcidx : funcidx)

;; 4-runtime.watsup
syntax addr = nat

;; 4-runtime.watsup
syntax arrayaddr = addr

;; 4-runtime.watsup
syntax exnaddr = addr

;; 4-runtime.watsup
syntax funcaddr = addr

;; 4-runtime.watsup
syntax hostaddr = addr

;; 4-runtime.watsup
syntax structaddr = addr

;; 4-runtime.watsup
rec {

;; 4-runtime.watsup:35.1-42.23
syntax addrref =
  | REF.I31_NUM{u31 : u31}(u31 : u31)
  | REF.STRUCT_ADDR{structaddr : structaddr}(structaddr : structaddr)
  | REF.ARRAY_ADDR{arrayaddr : arrayaddr}(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR{funcaddr : funcaddr}(funcaddr : funcaddr)
  | REF.EXN_ADDR{exnaddr : exnaddr}(exnaddr : exnaddr)
  | REF.HOST_ADDR{hostaddr : hostaddr}(hostaddr : hostaddr)
  | REF.EXTERN{addrref : addrref}(addrref : addrref)
}

;; 1-syntax.watsup
syntax catch =
  | CATCH{tagidx : tagidx, labelidx : labelidx}(tagidx : tagidx, labelidx : labelidx)
  | CATCH_REF{tagidx : tagidx, labelidx : labelidx}(tagidx : tagidx, labelidx : labelidx)
  | CATCH_ALL{labelidx : labelidx}(labelidx : labelidx)
  | CATCH_ALL_REF{labelidx : labelidx}(labelidx : labelidx)

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
syntax tagaddr = addr

;; 4-runtime.watsup
syntax externaddr =
  | FUNC{funcaddr : funcaddr}(funcaddr : funcaddr)
  | GLOBAL{globaladdr : globaladdr}(globaladdr : globaladdr)
  | TABLE{tableaddr : tableaddr}(tableaddr : tableaddr)
  | MEM{memaddr : memaddr}(memaddr : memaddr)
  | TAG{tagaddr : tagaddr}(tagaddr : tagaddr)

;; 4-runtime.watsup
syntax exportinst =
{
  NAME{name : name} name,
  ADDR{externaddr : externaddr} externaddr
}

;; 4-runtime.watsup
syntax moduleinst =
{
  TYPES{`deftype*` : deftype*} deftype*,
  FUNCS{`funcaddr*` : funcaddr*} funcaddr*,
  GLOBALS{`globaladdr*` : globaladdr*} globaladdr*,
  TABLES{`tableaddr*` : tableaddr*} tableaddr*,
  MEMS{`memaddr*` : memaddr*} memaddr*,
  TAGS{`tagaddr*` : tagaddr*} tagaddr*,
  ELEMS{`elemaddr*` : elemaddr*} elemaddr*,
  DATAS{`dataaddr*` : dataaddr*} dataaddr*,
  EXPORTS{`exportinst*` : exportinst*} exportinst*
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
  | REF.EXN_ADDR{exnaddr : exnaddr}(exnaddr : exnaddr)
  | REF.HOST_ADDR{hostaddr : hostaddr}(hostaddr : hostaddr)
  | REF.EXTERN{addrref : addrref}(addrref : addrref)

;; 4-runtime.watsup
syntax frame =
{
  LOCALS{`val?*` : val?*} val?*,
  MODULE{moduleinst : moduleinst} moduleinst
}

;; 4-runtime.watsup
rec {

;; 4-runtime.watsup:151.1-157.9
syntax instr =
  | NOP
  | UNREACHABLE
  | DROP
  | `SELECT()%?`{`valtype*?` : valtype*?}(valtype*{valtype <- `valtype*`}?{`valtype*` <- `valtype*?`} : valtype*?)
  | BLOCK{blocktype : blocktype, `instr*` : instr*}(blocktype : blocktype, instr*{instr <- `instr*`} : instr*)
  | LOOP{blocktype : blocktype, `instr*` : instr*}(blocktype : blocktype, instr*{instr <- `instr*`} : instr*)
  | `IF%%ELSE%`{blocktype : blocktype, `instr*` : instr*}(blocktype : blocktype, instr*{instr <- `instr*`} : instr*, instr*)
  | BR{labelidx : labelidx}(labelidx : labelidx)
  | BR_IF{labelidx : labelidx}(labelidx : labelidx)
  | BR_TABLE{`labelidx*` : labelidx*}(labelidx*{labelidx <- `labelidx*`} : labelidx*, labelidx)
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
  | THROW{tagidx : tagidx}(tagidx : tagidx)
  | THROW_REF
  | TRY_TABLE{blocktype : blocktype, list : list(syntax catch), `instr*` : instr*}(blocktype : blocktype, list : list(syntax catch), instr*{instr <- `instr*`} : instr*)
  | CONST{numtype : numtype, num_ : num_(numtype)}(numtype : numtype, num_ : num_(numtype))
  | UNOP{numtype : numtype, unop_ : unop_(numtype)}(numtype : numtype, unop_ : unop_(numtype))
  | BINOP{numtype : numtype, binop_ : binop_(numtype)}(numtype : numtype, binop_ : binop_(numtype))
  | TESTOP{numtype : numtype, testop_ : testop_(numtype)}(numtype : numtype, testop_ : testop_(numtype))
  | RELOP{numtype : numtype, relop_ : relop_(numtype)}(numtype : numtype, relop_ : relop_(numtype))
  | CVTOP{numtype_1 : numtype, numtype_2 : numtype, cvtop__ : cvtop__(numtype_2, numtype_1)}(numtype_1 : numtype, numtype_2 : numtype, cvtop__ : cvtop__(numtype_2, numtype_1))
  | VCONST{vectype : vectype, vec_ : vec_(vectype)}(vectype : vectype, vec_ : vec_(vectype))
  | VVUNOP{vectype : vectype, vvunop : vvunop}(vectype : vectype, vvunop : vvunop)
  | VVBINOP{vectype : vectype, vvbinop : vvbinop}(vectype : vectype, vvbinop : vvbinop)
  | VVTERNOP{vectype : vectype, vvternop : vvternop}(vectype : vectype, vvternop : vvternop)
  | VVTESTOP{vectype : vectype, vvtestop : vvtestop}(vectype : vectype, vvtestop : vvtestop)
  | VUNOP{shape : shape, vunop_ : vunop_(shape)}(shape : shape, vunop_ : vunop_(shape))
  | VBINOP{shape : shape, vbinop_ : vbinop_(shape)}(shape : shape, vbinop_ : vbinop_(shape))
  | VTERNOP{shape : shape, vternop_ : vternop_(shape)}(shape : shape, vternop_ : vternop_(shape))
  | VTESTOP{shape : shape, vtestop_ : vtestop_(shape)}(shape : shape, vtestop_ : vtestop_(shape))
  | VRELOP{shape : shape, vrelop_ : vrelop_(shape)}(shape : shape, vrelop_ : vrelop_(shape))
  | VSHIFTOP{ishape : ishape, vshiftop_ : vshiftop_(ishape)}(ishape : ishape, vshiftop_ : vshiftop_(ishape))
  | VBITMASK{ishape : ishape}(ishape : ishape)
  | VSWIZZLOP{ishape : ishape, vswizzlop_ : vswizzlop_(ishape)}(ishape : ishape, vswizzlop_ : vswizzlop_(ishape))
  | VSHUFFLE{ishape : ishape, `laneidx*` : laneidx*}(ishape : ishape, laneidx*{laneidx <- `laneidx*`} : laneidx*)
    -- if ((ishape = `%X%`_ishape(I8_Jnn, `%`_dim(16))) /\ (|laneidx*{laneidx <- `laneidx*`}| = 16))
  | VEXTUNOP{ishape_1 : ishape, ishape_2 : ishape, vextunop__ : vextunop__(ishape_2, ishape_1)}(ishape_1 : ishape, ishape_2 : ishape, vextunop__ : vextunop__(ishape_2, ishape_1))
  | VEXTBINOP{ishape_1 : ishape, ishape_2 : ishape, vextbinop__ : vextbinop__(ishape_2, ishape_1)}(ishape_1 : ishape, ishape_2 : ishape, vextbinop__ : vextbinop__(ishape_2, ishape_1))
  | VEXTTERNOP{ishape_1 : ishape, ishape_2 : ishape, vextternop__ : vextternop__(ishape_2, ishape_1)}(ishape_1 : ishape, ishape_2 : ishape, vextternop__ : vextternop__(ishape_2, ishape_1))
  | VNARROW{ishape_1 : ishape, ishape_2 : ishape, sx : sx}(ishape_1 : ishape, ishape_2 : ishape, sx : sx)
    -- if (($lsize($lanetype((ishape_2 : ishape <: shape))) = (2 * $lsize($lanetype((ishape_1 : ishape <: shape))))) /\ ((2 * $lsize($lanetype((ishape_1 : ishape <: shape)))) <= 32))
  | VCVTOP{shape_1 : shape, shape_2 : shape, vcvtop__ : vcvtop__(shape_2, shape_1), `half__?` : half__(shape_2, shape_1)?, `zero__?` : zero__(shape_2, shape_1)?}(shape_1 : shape, shape_2 : shape, vcvtop__ : vcvtop__(shape_2, shape_1), half__?{half__ <- `half__?`} : half__(shape_2, shape_1)?, zero__?{zero__ <- `zero__?`} : zero__(shape_2, shape_1)?)
  | VSPLAT{shape : shape}(shape : shape)
  | VEXTRACT_LANE{shape : shape, `sx?` : sx?, laneidx : laneidx, numtype : numtype}(shape : shape, sx?{sx <- `sx?`} : sx?, laneidx : laneidx)
    -- if ((sx?{sx <- `sx?`} = ?()) <=> ($lanetype(shape) = (numtype : numtype <: lanetype)))
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
  | STRUCT.GET{`sx?` : sx?, typeidx : typeidx, u32 : u32}(sx?{sx <- `sx?`} : sx?, typeidx : typeidx, u32 : u32)
  | STRUCT.SET{typeidx : typeidx, u32 : u32}(typeidx : typeidx, u32 : u32)
  | ARRAY.NEW{typeidx : typeidx}(typeidx : typeidx)
  | ARRAY.NEW_DEFAULT{typeidx : typeidx}(typeidx : typeidx)
  | ARRAY.NEW_FIXED{typeidx : typeidx, u32 : u32}(typeidx : typeidx, u32 : u32)
  | ARRAY.NEW_DATA{typeidx : typeidx, dataidx : dataidx}(typeidx : typeidx, dataidx : dataidx)
  | ARRAY.NEW_ELEM{typeidx : typeidx, elemidx : elemidx}(typeidx : typeidx, elemidx : elemidx)
  | ARRAY.GET{`sx?` : sx?, typeidx : typeidx}(sx?{sx <- `sx?`} : sx?, typeidx : typeidx)
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
  | LOAD{numtype : numtype, `loadop_?` : loadop_(numtype)?, memidx : memidx, memarg : memarg}(numtype : numtype, loadop_?{loadop_ <- `loadop_?`} : loadop_(numtype)?, memidx : memidx, memarg : memarg)
  | STORE{numtype : numtype, `sz?` : sz?, memidx : memidx, memarg : memarg}(numtype : numtype, sz?{sz <- `sz?`} : sz?, memidx : memidx, memarg : memarg)
  | VLOAD{vectype : vectype, `vloadop_?` : vloadop_(vectype)?, memidx : memidx, memarg : memarg}(vectype : vectype, vloadop_?{vloadop_ <- `vloadop_?`} : vloadop_(vectype)?, memidx : memidx, memarg : memarg)
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
  | REF.EXN_ADDR{exnaddr : exnaddr}(exnaddr : exnaddr)
  | REF.HOST_ADDR{hostaddr : hostaddr}(hostaddr : hostaddr)
  | REF.EXTERN{addrref : addrref}(addrref : addrref)
  | `LABEL_%{%}%`{n : n, `instr*` : instr*}(n : n, instr*{instr <- `instr*`} : instr*, instr*)
  | `FRAME_%{%}%`{n : n, frame : frame, `instr*` : instr*}(n : n, frame : frame, instr*{instr <- `instr*`} : instr*)
  | `HANDLER_%{%}%`{n : n, `catch*` : catch*, `instr*` : instr*}(n : n, catch*{catch <- `catch*`} : catch*, instr*{instr <- `instr*`} : instr*)
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
  | FUNC{typeidx : typeidx, `local*` : local*, expr : expr}(typeidx : typeidx, local*{local <- `local*`} : local*, expr : expr)

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
syntax tag =
  | TAG{typeidx : typeidx}(typeidx : typeidx)

;; 1-syntax.watsup
syntax elem =
  | ELEM{reftype : reftype, `expr*` : expr*, elemmode : elemmode}(reftype : reftype, expr*{expr <- `expr*`} : expr*, elemmode : elemmode)

;; 1-syntax.watsup
syntax data =
  | DATA{`byte*` : byte*, datamode : datamode}(byte*{byte <- `byte*`} : byte*, datamode : datamode)

;; 1-syntax.watsup
syntax start =
  | START{funcidx : funcidx}(funcidx : funcidx)

;; 1-syntax.watsup
syntax externidx =
  | FUNC{funcidx : funcidx}(funcidx : funcidx)
  | GLOBAL{globalidx : globalidx}(globalidx : globalidx)
  | TABLE{tableidx : tableidx}(tableidx : tableidx)
  | MEM{memidx : memidx}(memidx : memidx)
  | TAG{tagidx : tagidx}(tagidx : tagidx)

;; 1-syntax.watsup
syntax export =
  | EXPORT{name : name, externidx : externidx}(name : name, externidx : externidx)

;; 1-syntax.watsup
syntax import =
  | IMPORT{name : name, externtype : externtype}(name : name, name, externtype : externtype)

;; 1-syntax.watsup
syntax module =
  | MODULE{`type*` : type*, `import*` : import*, `func*` : func*, `global*` : global*, `table*` : table*, `mem*` : mem*, `tag*` : tag*, `elem*` : elem*, `data*` : data*, `start?` : start?, `export*` : export*}(type*{type <- `type*`} : type*, import*{import <- `import*`} : import*, func*{func <- `func*`} : func*, global*{global <- `global*`} : global*, table*{table <- `table*`} : table*, mem*{mem <- `mem*`} : mem*, tag*{tag <- `tag*`} : tag*, elem*{elem <- `elem*`} : elem*, data*{data <- `data*`} : data*, start?{start <- `start?`} : start?, export*{export <- `export*`} : export*)

;; 2-syntax-aux.watsup
def $IN(N : N) : Inn
  ;; 2-syntax-aux.watsup
  def $IN(32) = I32_Inn
  ;; 2-syntax-aux.watsup
  def $IN(64) = I64_Inn

;; 2-syntax-aux.watsup
def $FN(N : N) : Fnn
  ;; 2-syntax-aux.watsup
  def $FN(32) = F32_Fnn
  ;; 2-syntax-aux.watsup
  def $FN(64) = F64_Fnn

;; 2-syntax-aux.watsup
def $JN(N : N) : Jnn
  ;; 2-syntax-aux.watsup
  def $JN(8) = I8_Jnn
  ;; 2-syntax-aux.watsup
  def $JN(16) = I16_Jnn
  ;; 2-syntax-aux.watsup
  def $JN(32) = I32_Jnn
  ;; 2-syntax-aux.watsup
  def $JN(64) = I64_Jnn

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
  | REC{nat : nat}(nat : nat)

;; 2-syntax-aux.watsup
syntax free =
{
  TYPES{`typeidx*` : typeidx*} typeidx*,
  FUNCS{`funcidx*` : funcidx*} funcidx*,
  GLOBALS{`globalidx*` : globalidx*} globalidx*,
  TABLES{`tableidx*` : tableidx*} tableidx*,
  MEMS{`memidx*` : memidx*} memidx*,
  ELEMS{`elemidx*` : elemidx*} elemidx*,
  DATAS{`dataidx*` : dataidx*} dataidx*,
  LOCALS{`localidx*` : localidx*} localidx*,
  LABELS{`labelidx*` : labelidx*} labelidx*
}

;; 2-syntax-aux.watsup
def $free_opt(free?) : free
  ;; 2-syntax-aux.watsup
  def $free_opt(?()) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup
  def $free_opt{free : free}(?(free)) = free

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:152.1-152.29
def $free_list(free*) : free
  ;; 2-syntax-aux.watsup:153.1-153.25
  def $free_list([]) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:154.1-154.57
  def $free_list{free : free, `free'*` : free*}([free] ++ free'*{free' <- `free'*`}) = free +++ $free_list(free'*{free' <- `free'*`})
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

;; 2-syntax-aux.watsup:211.1-211.34
def $free_rectype(rectype : rectype) : free
  ;; 2-syntax-aux.watsup:264.1-264.70
  def $free_rectype{`subtype*` : subtype*}(REC_rectype(`%`_list(subtype*{subtype <- `subtype*`}))) = $free_list($free_subtype(subtype)*{subtype <- `subtype*`})

;; 2-syntax-aux.watsup:213.1-213.34
def $free_deftype(deftype : deftype) : free
  ;; 2-syntax-aux.watsup:214.1-214.58
  def $free_deftype{rectype : rectype, n : n}(DEF_deftype(rectype, n)) = $free_rectype(rectype)

;; 2-syntax-aux.watsup:216.1-216.34
def $free_typeuse(typeuse : typeuse) : free
  ;; 2-syntax-aux.watsup:217.1-217.57
  def $free_typeuse{typeidx : typeidx}(_IDX_typeuse(typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:218.1-218.30
  def $free_typeuse{n : n}(REC_typeuse(n)) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:219.1-219.52
  def $free_typeuse{deftype : deftype}((deftype : deftype <: typeuse)) = $free_deftype(deftype)

;; 2-syntax-aux.watsup:221.1-221.36
def $free_heaptype(heaptype : heaptype) : free
  ;; 2-syntax-aux.watsup:222.1-222.65
  def $free_heaptype{absheaptype : absheaptype}((absheaptype : absheaptype <: heaptype)) = $free_absheaptype(absheaptype)
  ;; 2-syntax-aux.watsup:223.1-223.53
  def $free_heaptype{typeuse : typeuse}((typeuse : typeuse <: heaptype)) = $free_typeuse(typeuse)

;; 2-syntax-aux.watsup:225.1-225.34
def $free_reftype(reftype : reftype) : free
  ;; 2-syntax-aux.watsup:226.1-226.63
  def $free_reftype{nul : nul, heaptype : heaptype}(REF_reftype(nul, heaptype)) = $free_heaptype(heaptype)

;; 2-syntax-aux.watsup:228.1-228.34
def $free_valtype(valtype : valtype) : free
  ;; 2-syntax-aux.watsup:229.1-229.52
  def $free_valtype{numtype : numtype}((numtype : numtype <: valtype)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup:230.1-230.52
  def $free_valtype{vectype : vectype}((vectype : vectype <: valtype)) = $free_vectype(vectype)
  ;; 2-syntax-aux.watsup:231.1-231.52
  def $free_valtype{reftype : reftype}((reftype : reftype <: valtype)) = $free_reftype(reftype)
  ;; 2-syntax-aux.watsup:232.1-232.28
  def $free_valtype(BOT_valtype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup:234.1-234.40
def $free_resulttype(resulttype : resulttype) : free
  ;; 2-syntax-aux.watsup:235.1-235.69
  def $free_resulttype{`valtype*` : valtype*}(`%`_resulttype(valtype*{valtype <- `valtype*`})) = $free_list($free_valtype(valtype)*{valtype <- `valtype*`})

;; 2-syntax-aux.watsup:237.1-237.42
def $free_storagetype(storagetype : storagetype) : free
  ;; 2-syntax-aux.watsup:238.1-238.56
  def $free_storagetype{valtype : valtype}((valtype : valtype <: storagetype)) = $free_valtype(valtype)
  ;; 2-syntax-aux.watsup:239.1-239.59
  def $free_storagetype{packtype : packtype}((packtype : packtype <: storagetype)) = $free_packtype(packtype)

;; 2-syntax-aux.watsup:241.1-241.38
def $free_fieldtype(fieldtype : fieldtype) : free
  ;; 2-syntax-aux.watsup:242.1-242.70
  def $free_fieldtype{mut : mut, storagetype : storagetype}(`%%`_fieldtype(mut, storagetype)) = $free_storagetype(storagetype)

;; 2-syntax-aux.watsup:244.1-244.36
def $free_functype(functype : functype) : free
  ;; 2-syntax-aux.watsup:245.1-246.67
  def $free_functype{resulttype_1 : resulttype, resulttype_2 : resulttype}(`%->%`_functype(resulttype_1, resulttype_2)) = $free_resulttype(resulttype_1) +++ $free_resulttype(resulttype_2)

;; 2-syntax-aux.watsup:248.1-248.40
def $free_structtype(structtype : structtype) : free
  ;; 2-syntax-aux.watsup:249.1-249.75
  def $free_structtype{`fieldtype*` : fieldtype*}(`%`_structtype(fieldtype*{fieldtype <- `fieldtype*`})) = $free_list($free_fieldtype(fieldtype)*{fieldtype <- `fieldtype*`})

;; 2-syntax-aux.watsup:251.1-251.38
def $free_arraytype(arraytype : arraytype) : free
  ;; 2-syntax-aux.watsup:252.1-252.60
  def $free_arraytype{fieldtype : fieldtype}(fieldtype) = $free_fieldtype(fieldtype)

;; 2-syntax-aux.watsup:254.1-254.36
def $free_comptype(comptype : comptype) : free
  ;; 2-syntax-aux.watsup:255.1-255.69
  def $free_comptype{structtype : structtype}(STRUCT_comptype(structtype)) = $free_structtype(structtype)
  ;; 2-syntax-aux.watsup:256.1-256.65
  def $free_comptype{arraytype : arraytype}(ARRAY_comptype(arraytype)) = $free_arraytype(arraytype)
  ;; 2-syntax-aux.watsup:257.1-257.61
  def $free_comptype{functype : functype}(FUNC_comptype(functype)) = $free_functype(functype)

;; 2-syntax-aux.watsup:259.1-259.34
def $free_subtype(subtype : subtype) : free
  ;; 2-syntax-aux.watsup:260.1-261.66
  def $free_subtype{fin : fin, `typeuse*` : typeuse*, comptype : comptype}(SUB_subtype(fin, typeuse*{typeuse <- `typeuse*`}, comptype)) = $free_list($free_typeuse(typeuse)*{typeuse <- `typeuse*`}) +++ $free_comptype(comptype)
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
  def $free_moduletype{`externtype_1*` : externtype*, `externtype_2*` : externtype*}(`%->%`_moduletype(externtype_1*{externtype_1 <- `externtype_1*`}, externtype_2*{externtype_2 <- `externtype_2*`})) = $free_list($free_externtype(externtype_1)*{externtype_1 <- `externtype_1*`}) +++ $free_list($free_externtype(externtype_2)*{externtype_2 <- `externtype_2*`})

;; 2-syntax-aux.watsup
def $free_blocktype(blocktype : blocktype) : free
  ;; 2-syntax-aux.watsup
  def $free_blocktype{`valtype?` : valtype?}(_RESULT_blocktype(valtype?{valtype <- `valtype?`})) = $free_opt($free_valtype(valtype)?{valtype <- `valtype?`})
  ;; 2-syntax-aux.watsup
  def $free_blocktype{funcidx : funcidx}(_IDX_blocktype(funcidx)) = $free_funcidx(funcidx)

;; 2-syntax-aux.watsup
def $free_shape(shape : shape) : free
  ;; 2-syntax-aux.watsup
  def $free_shape{lanetype : lanetype, dim : dim}(`%X%`_shape(lanetype, dim)) = $free_lanetype(lanetype)

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:444.1-444.44
def $shift_labelidxs(labelidx*) : labelidx*
  ;; 2-syntax-aux.watsup:445.1-445.32
  def $shift_labelidxs([]) = []
  ;; 2-syntax-aux.watsup:446.1-446.66
  def $shift_labelidxs{`labelidx'*` : labelidx*}([`%`_uN(0)] ++ labelidx'*{labelidx' <- `labelidx'*`}) = $shift_labelidxs(labelidx'*{labelidx' <- `labelidx'*`})
  ;; 2-syntax-aux.watsup:447.1-447.91
  def $shift_labelidxs{labelidx : labelidx, `labelidx'*` : labelidx*}([labelidx] ++ labelidx'*{labelidx' <- `labelidx'*`}) = [`%`_uN((labelidx!`%`_labelidx.0 - 1))] ++ $shift_labelidxs(labelidx'*{labelidx' <- `labelidx'*`})
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:299.1-299.31
def $free_block(instr*) : free
  ;; 2-syntax-aux.watsup:450.1-451.47
  def $free_block{`instr*` : instr*, free : free}(instr*{instr <- `instr*`}) = free[LABELS_free = $shift_labelidxs(free.LABELS_free)]
    -- if (free = $free_list($free_instr(instr)*{instr <- `instr*`}))

;; 2-syntax-aux.watsup:301.1-301.30
def $free_instr(instr : instr) : free
  ;; 2-syntax-aux.watsup:302.1-302.26
  def $free_instr(NOP_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:303.1-303.34
  def $free_instr(UNREACHABLE_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:304.1-304.27
  def $free_instr(DROP_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:305.1-305.86
  def $free_instr{`valtype*?` : valtype*?}(`SELECT()%?`_instr(valtype*{valtype <- `valtype*`}?{`valtype*` <- `valtype*?`})) = $free_opt($free_list($free_valtype(valtype)*{valtype <- `valtype*`})?{`valtype*` <- `valtype*?`})
  ;; 2-syntax-aux.watsup:307.1-307.92
  def $free_instr{blocktype : blocktype, `instr*` : instr*}(BLOCK_instr(blocktype, instr*{instr <- `instr*`})) = $free_blocktype(blocktype) +++ $free_block(instr*{instr <- `instr*`})
  ;; 2-syntax-aux.watsup:308.1-308.91
  def $free_instr{blocktype : blocktype, `instr*` : instr*}(LOOP_instr(blocktype, instr*{instr <- `instr*`})) = $free_blocktype(blocktype) +++ $free_block(instr*{instr <- `instr*`})
  ;; 2-syntax-aux.watsup:309.1-310.79
  def $free_instr{blocktype : blocktype, `instr_1*` : instr*, `instr_2*` : instr*}(`IF%%ELSE%`_instr(blocktype, instr_1*{instr_1 <- `instr_1*`}, instr_2*{instr_2 <- `instr_2*`})) = $free_blocktype(blocktype) +++ $free_block(instr_1*{instr_1 <- `instr_1*`}) +++ $free_block(instr_2*{instr_2 <- `instr_2*`})
  ;; 2-syntax-aux.watsup:312.1-312.56
  def $free_instr{labelidx : labelidx}(BR_instr(labelidx)) = $free_labelidx(labelidx)
  ;; 2-syntax-aux.watsup:313.1-313.59
  def $free_instr{labelidx : labelidx}(BR_IF_instr(labelidx)) = $free_labelidx(labelidx)
  ;; 2-syntax-aux.watsup:314.1-315.68
  def $free_instr{labelidx : labelidx, labelidx' : labelidx}(BR_TABLE_instr(labelidx*{}, labelidx')) = $free_list($free_labelidx(labelidx)*{}) +++ $free_labelidx(labelidx)
  ;; 2-syntax-aux.watsup:316.1-316.64
  def $free_instr{labelidx : labelidx}(BR_ON_NULL_instr(labelidx)) = $free_labelidx(labelidx)
  ;; 2-syntax-aux.watsup:317.1-317.68
  def $free_instr{labelidx : labelidx}(BR_ON_NON_NULL_instr(labelidx)) = $free_labelidx(labelidx)
  ;; 2-syntax-aux.watsup:318.1-319.83
  def $free_instr{labelidx : labelidx, reftype_1 : reftype, reftype_2 : reftype}(BR_ON_CAST_instr(labelidx, reftype_1, reftype_2)) = $free_labelidx(labelidx) +++ $free_reftype(reftype_1) +++ $free_reftype(reftype_2)
  ;; 2-syntax-aux.watsup:320.1-321.83
  def $free_instr{labelidx : labelidx, reftype_1 : reftype, reftype_2 : reftype}(BR_ON_CAST_FAIL_instr(labelidx, reftype_1, reftype_2)) = $free_labelidx(labelidx) +++ $free_reftype(reftype_1) +++ $free_reftype(reftype_2)
  ;; 2-syntax-aux.watsup:323.1-323.55
  def $free_instr{funcidx : funcidx}(CALL_instr(funcidx)) = $free_funcidx(funcidx)
  ;; 2-syntax-aux.watsup:324.1-324.59
  def $free_instr{typeuse : typeuse}(CALL_REF_instr(typeuse)) = $free_typeuse(typeuse)
  ;; 2-syntax-aux.watsup:325.1-326.53
  def $free_instr{tableidx : tableidx, typeuse : typeuse}(CALL_INDIRECT_instr(tableidx, typeuse)) = $free_tableidx(tableidx) +++ $free_typeuse(typeuse)
  ;; 2-syntax-aux.watsup:327.1-327.29
  def $free_instr(RETURN_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:328.1-328.62
  def $free_instr{funcidx : funcidx}(RETURN_CALL_instr(funcidx)) = $free_funcidx(funcidx)
  ;; 2-syntax-aux.watsup:329.1-329.66
  def $free_instr{typeuse : typeuse}(RETURN_CALL_REF_instr(typeuse)) = $free_typeuse(typeuse)
  ;; 2-syntax-aux.watsup:330.1-331.53
  def $free_instr{tableidx : tableidx, typeuse : typeuse}(RETURN_CALL_INDIRECT_instr(tableidx, typeuse)) = $free_tableidx(tableidx) +++ $free_typeuse(typeuse)
  ;; 2-syntax-aux.watsup:333.1-333.63
  def $free_instr{numtype : numtype, numlit : num_(numtype)}(CONST_instr(numtype, numlit)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup:334.1-334.60
  def $free_instr{numtype : numtype, unop : unop_(numtype)}(UNOP_instr(numtype, unop)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup:335.1-335.62
  def $free_instr{numtype : numtype, binop : binop_(numtype)}(BINOP_instr(numtype, binop)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup:336.1-336.64
  def $free_instr{numtype : numtype, testop : testop_(numtype)}(TESTOP_instr(numtype, testop)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup:337.1-337.62
  def $free_instr{numtype : numtype, relop : relop_(numtype)}(RELOP_instr(numtype, relop)) = $free_numtype(numtype)
  ;; 2-syntax-aux.watsup:338.1-339.55
  def $free_instr{numtype_1 : numtype, numtype_2 : numtype, cvtop : cvtop__(numtype_2, numtype_1)}(CVTOP_instr(numtype_1, numtype_2, cvtop)) = $free_numtype(numtype_1) +++ $free_numtype(numtype_2)
  ;; 2-syntax-aux.watsup:341.1-341.64
  def $free_instr{vectype : vectype, veclit : vec_(vectype)}(VCONST_instr(vectype, veclit)) = $free_vectype(vectype)
  ;; 2-syntax-aux.watsup:342.1-342.64
  def $free_instr{vectype : vectype, vvunop : vvunop}(VVUNOP_instr(vectype, vvunop)) = $free_vectype(vectype)
  ;; 2-syntax-aux.watsup:343.1-343.66
  def $free_instr{vectype : vectype, vvbinop : vvbinop}(VVBINOP_instr(vectype, vvbinop)) = $free_vectype(vectype)
  ;; 2-syntax-aux.watsup:344.1-344.68
  def $free_instr{vectype : vectype, vvternop : vvternop}(VVTERNOP_instr(vectype, vvternop)) = $free_vectype(vectype)
  ;; 2-syntax-aux.watsup:345.1-345.68
  def $free_instr{vectype : vectype, vvtestop : vvtestop}(VVTESTOP_instr(vectype, vvtestop)) = $free_vectype(vectype)
  ;; 2-syntax-aux.watsup:346.1-346.56
  def $free_instr{shape : shape, vunop : vunop_(shape)}(VUNOP_instr(shape, vunop)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:347.1-347.58
  def $free_instr{shape : shape, vbinop : vbinop_(shape)}(VBINOP_instr(shape, vbinop)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:348.1-348.60
  def $free_instr{shape : shape, vternop : vternop_(shape)}(VTERNOP_instr(shape, vternop)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:349.1-349.60
  def $free_instr{shape : shape, vtestop : vtestop_(shape)}(VTESTOP_instr(shape, vtestop)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:350.1-350.58
  def $free_instr{shape : shape, vrelop : vrelop_(shape)}(VRELOP_instr(shape, vrelop)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:351.1-351.64
  def $free_instr{ishape : ishape, vshiftop : vshiftop_(ishape)}(VSHIFTOP_instr(ishape, vshiftop)) = $free_shape((ishape : ishape <: shape))
  ;; 2-syntax-aux.watsup:352.1-352.55
  def $free_instr{ishape : ishape}(VBITMASK_instr(ishape)) = $free_shape((ishape : ishape <: shape))
  ;; 2-syntax-aux.watsup:353.1-353.66
  def $free_instr{ishape : ishape, vswizzlop : vswizzlop_(ishape)}(VSWIZZLOP_instr(ishape, vswizzlop)) = $free_shape((ishape : ishape <: shape))
  ;; 2-syntax-aux.watsup:354.1-354.64
  def $free_instr{ishape : ishape, `laneidx*` : laneidx*}(VSHUFFLE_instr(ishape, laneidx*{laneidx <- `laneidx*`})) = $free_shape((ishape : ishape <: shape))
  ;; 2-syntax-aux.watsup:355.1-356.49
  def $free_instr{ishape_1 : ishape, ishape_2 : ishape, vextunop : vextunop__(ishape_2, ishape_1)}(VEXTUNOP_instr(ishape_1, ishape_2, vextunop)) = $free_shape((ishape_1 : ishape <: shape)) +++ $free_shape((ishape_2 : ishape <: shape))
  ;; 2-syntax-aux.watsup:357.1-358.49
  def $free_instr{ishape_1 : ishape, ishape_2 : ishape, vextbinop : vextbinop__(ishape_2, ishape_1)}(VEXTBINOP_instr(ishape_1, ishape_2, vextbinop)) = $free_shape((ishape_1 : ishape <: shape)) +++ $free_shape((ishape_2 : ishape <: shape))
  ;; 2-syntax-aux.watsup:359.1-360.49
  def $free_instr{ishape_1 : ishape, ishape_2 : ishape, sx : sx}(VNARROW_instr(ishape_1, ishape_2, sx)) = $free_shape((ishape_1 : ishape <: shape)) +++ $free_shape((ishape_2 : ishape <: shape))
  ;; 2-syntax-aux.watsup:361.1-362.47
  def $free_instr{shape_1 : shape, shape_2 : shape, vcvtop : vcvtop__(shape_2, shape_1), `half?` : half__(shape_2, shape_1)?, `zero?` : zero__(shape_2, shape_1)?}(VCVTOP_instr(shape_1, shape_2, vcvtop, half?{half <- `half?`}, zero?{zero <- `zero?`})) = $free_shape(shape_1) +++ $free_shape(shape_2)
  ;; 2-syntax-aux.watsup:363.1-363.51
  def $free_instr{shape : shape}(VSPLAT_instr(shape)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:364.1-364.70
  def $free_instr{shape : shape, `sx?` : sx?, laneidx : laneidx}(VEXTRACT_LANE_instr(shape, sx?{sx <- `sx?`}, laneidx)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:365.1-365.66
  def $free_instr{shape : shape, laneidx : laneidx}(VREPLACE_LANE_instr(shape, laneidx)) = $free_shape(shape)
  ;; 2-syntax-aux.watsup:367.1-367.62
  def $free_instr{heaptype : heaptype}(REF.NULL_instr(heaptype)) = $free_heaptype(heaptype)
  ;; 2-syntax-aux.watsup:368.1-368.34
  def $free_instr(REF.IS_NULL_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:369.1-369.38
  def $free_instr(REF.AS_NON_NULL_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:370.1-370.29
  def $free_instr(REF.EQ_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:371.1-371.59
  def $free_instr{reftype : reftype}(REF.TEST_instr(reftype)) = $free_reftype(reftype)
  ;; 2-syntax-aux.watsup:372.1-372.59
  def $free_instr{reftype : reftype}(REF.CAST_instr(reftype)) = $free_reftype(reftype)
  ;; 2-syntax-aux.watsup:373.1-373.59
  def $free_instr{funcidx : funcidx}(REF.FUNC_instr(funcidx)) = $free_funcidx(funcidx)
  ;; 2-syntax-aux.watsup:374.1-374.30
  def $free_instr(REF.I31_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:376.1-376.33
  def $free_instr{sx : sx}(I31.GET_instr(sx)) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:378.1-378.41
  def $free_instr{typeidx : typeidx}(STRUCT.NEW_instr(typeidx)) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:379.1-379.69
  def $free_instr{typeidx : typeidx}(STRUCT.NEW_DEFAULT_instr(typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:380.1-380.69
  def $free_instr{`sx?` : sx?, typeidx : typeidx, u32 : u32}(STRUCT.GET_instr(sx?{sx <- `sx?`}, typeidx, u32)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:381.1-381.65
  def $free_instr{typeidx : typeidx, u32 : u32}(STRUCT.SET_instr(typeidx, u32)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:383.1-383.60
  def $free_instr{typeidx : typeidx}(ARRAY.NEW_instr(typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:384.1-384.68
  def $free_instr{typeidx : typeidx}(ARRAY.NEW_DEFAULT_instr(typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:385.1-385.70
  def $free_instr{typeidx : typeidx, u32 : u32}(ARRAY.NEW_FIXED_instr(typeidx, u32)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:386.1-387.51
  def $free_instr{typeidx : typeidx, dataidx : dataidx}(ARRAY.NEW_DATA_instr(typeidx, dataidx)) = $free_typeidx(typeidx) +++ $free_dataidx(dataidx)
  ;; 2-syntax-aux.watsup:388.1-389.51
  def $free_instr{typeidx : typeidx, elemidx : elemidx}(ARRAY.NEW_ELEM_instr(typeidx, elemidx)) = $free_typeidx(typeidx) +++ $free_elemidx(elemidx)
  ;; 2-syntax-aux.watsup:390.1-390.64
  def $free_instr{`sx?` : sx?, typeidx : typeidx}(ARRAY.GET_instr(sx?{sx <- `sx?`}, typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:391.1-391.60
  def $free_instr{typeidx : typeidx}(ARRAY.SET_instr(typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:392.1-392.32
  def $free_instr(ARRAY.LEN_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:393.1-393.61
  def $free_instr{typeidx : typeidx}(ARRAY.FILL_instr(typeidx)) = $free_typeidx(typeidx)
  ;; 2-syntax-aux.watsup:394.1-395.55
  def $free_instr{typeidx_1 : typeidx, typeidx_2 : typeidx}(ARRAY.COPY_instr(typeidx_1, typeidx_2)) = $free_typeidx(typeidx_1) +++ $free_typeidx(typeidx_2)
  ;; 2-syntax-aux.watsup:396.1-397.51
  def $free_instr{typeidx : typeidx, dataidx : dataidx}(ARRAY.INIT_DATA_instr(typeidx, dataidx)) = $free_typeidx(typeidx) +++ $free_dataidx(dataidx)
  ;; 2-syntax-aux.watsup:398.1-399.51
  def $free_instr{typeidx : typeidx, elemidx : elemidx}(ARRAY.INIT_ELEM_instr(typeidx, elemidx)) = $free_typeidx(typeidx) +++ $free_elemidx(elemidx)
  ;; 2-syntax-aux.watsup:401.1-401.41
  def $free_instr(EXTERN.CONVERT_ANY_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:402.1-402.41
  def $free_instr(ANY.CONVERT_EXTERN_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup:404.1-404.63
  def $free_instr{localidx : localidx}(LOCAL.GET_instr(localidx)) = $free_localidx(localidx)
  ;; 2-syntax-aux.watsup:405.1-405.63
  def $free_instr{localidx : localidx}(LOCAL.SET_instr(localidx)) = $free_localidx(localidx)
  ;; 2-syntax-aux.watsup:406.1-406.63
  def $free_instr{localidx : localidx}(LOCAL.TEE_instr(localidx)) = $free_localidx(localidx)
  ;; 2-syntax-aux.watsup:408.1-408.67
  def $free_instr{globalidx : globalidx}(GLOBAL.GET_instr(globalidx)) = $free_globalidx(globalidx)
  ;; 2-syntax-aux.watsup:409.1-409.67
  def $free_instr{globalidx : globalidx}(GLOBAL.SET_instr(globalidx)) = $free_globalidx(globalidx)
  ;; 2-syntax-aux.watsup:411.1-411.63
  def $free_instr{tableidx : tableidx}(TABLE.GET_instr(tableidx)) = $free_tableidx(tableidx)
  ;; 2-syntax-aux.watsup:412.1-412.63
  def $free_instr{tableidx : tableidx}(TABLE.SET_instr(tableidx)) = $free_tableidx(tableidx)
  ;; 2-syntax-aux.watsup:413.1-413.64
  def $free_instr{tableidx : tableidx}(TABLE.SIZE_instr(tableidx)) = $free_tableidx(tableidx)
  ;; 2-syntax-aux.watsup:414.1-414.64
  def $free_instr{tableidx : tableidx}(TABLE.GROW_instr(tableidx)) = $free_tableidx(tableidx)
  ;; 2-syntax-aux.watsup:415.1-415.64
  def $free_instr{tableidx : tableidx}(TABLE.FILL_instr(tableidx)) = $free_tableidx(tableidx)
  ;; 2-syntax-aux.watsup:416.1-417.59
  def $free_instr{tableidx_1 : tableidx, tableidx_2 : tableidx}(TABLE.COPY_instr(tableidx_1, tableidx_2)) = $free_tableidx(tableidx_1) +++ $free_tableidx(tableidx_2)
  ;; 2-syntax-aux.watsup:418.1-419.53
  def $free_instr{tableidx : tableidx, elemidx : elemidx}(TABLE.INIT_instr(tableidx, elemidx)) = $free_tableidx(tableidx) +++ $free_elemidx(elemidx)
  ;; 2-syntax-aux.watsup:420.1-420.60
  def $free_instr{elemidx : elemidx}(ELEM.DROP_instr(elemidx)) = $free_elemidx(elemidx)
  ;; 2-syntax-aux.watsup:422.1-423.49
  def $free_instr{numtype : numtype, loadop : loadop_(numtype), memidx : memidx, memarg : memarg}(LOAD_instr(numtype, ?(loadop), memidx, memarg)) = $free_numtype(numtype) +++ $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:424.1-425.49
  def $free_instr{numtype : numtype, `sz?` : sz?, memidx : memidx, memarg : memarg}(STORE_instr(numtype, sz?{sz <- `sz?`}, memidx, memarg)) = $free_numtype(numtype) +++ $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:426.1-427.49
  def $free_instr{vectype : vectype, `vloadop?` : vloadop_(vectype)?, memidx : memidx, memarg : memarg}(VLOAD_instr(vectype, vloadop?{vloadop <- `vloadop?`}, memidx, memarg)) = $free_vectype(vectype) +++ $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:428.1-429.49
  def $free_instr{vectype : vectype, sz : sz, memidx : memidx, memarg : memarg, laneidx : laneidx}(VLOAD_LANE_instr(vectype, sz, memidx, memarg, laneidx)) = $free_vectype(vectype) +++ $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:430.1-431.49
  def $free_instr{vectype : vectype, memidx : memidx, memarg : memarg}(VSTORE_instr(vectype, memidx, memarg)) = $free_vectype(vectype) +++ $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:432.1-433.49
  def $free_instr{vectype : vectype, sz : sz, memidx : memidx, memarg : memarg, laneidx : laneidx}(VSTORE_LANE_instr(vectype, sz, memidx, memarg, laneidx)) = $free_vectype(vectype) +++ $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:434.1-434.59
  def $free_instr{memidx : memidx}(MEMORY.SIZE_instr(memidx)) = $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:435.1-435.59
  def $free_instr{memidx : memidx}(MEMORY.GROW_instr(memidx)) = $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:436.1-436.59
  def $free_instr{memidx : memidx}(MEMORY.FILL_instr(memidx)) = $free_memidx(memidx)
  ;; 2-syntax-aux.watsup:437.1-438.51
  def $free_instr{memidx_1 : memidx, memidx_2 : memidx}(MEMORY.COPY_instr(memidx_1, memidx_2)) = $free_memidx(memidx_1) +++ $free_memidx(memidx_2)
  ;; 2-syntax-aux.watsup:439.1-440.49
  def $free_instr{memidx : memidx, dataidx : dataidx}(MEMORY.INIT_instr(memidx, dataidx)) = $free_memidx(memidx) +++ $free_dataidx(dataidx)
  ;; 2-syntax-aux.watsup:441.1-441.60
  def $free_instr{dataidx : dataidx}(DATA.DROP_instr(dataidx)) = $free_dataidx(dataidx)
}

;; 2-syntax-aux.watsup
def $free_expr(expr : expr) : free
  ;; 2-syntax-aux.watsup
  def $free_expr{`instr*` : instr*}(instr*{instr <- `instr*`}) = $free_list($free_instr(instr)*{instr <- `instr*`})

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
  def $free_func{typeidx : typeidx, `local*` : local*, expr : expr}(FUNC_func(typeidx, local*{local <- `local*`}, expr)) = $free_typeidx(typeidx) +++ $free_list($free_local(local)*{local <- `local*`}) +++ $free_block(expr)[LOCALS_free = []]

;; 2-syntax-aux.watsup
def $free_global(global : global) : free
  ;; 2-syntax-aux.watsup
  def $free_global{globaltype : globaltype, expr : expr}(GLOBAL_global(globaltype, expr)) = $free_globaltype(globaltype) +++ $free_expr(expr)

;; 2-syntax-aux.watsup
def $free_table(table : table) : free
  ;; 2-syntax-aux.watsup
  def $free_table{tabletype : tabletype, expr : expr}(TABLE_table(tabletype, expr)) = $free_tabletype(tabletype) +++ $free_expr(expr)

;; 2-syntax-aux.watsup
def $free_mem(mem : mem) : free
  ;; 2-syntax-aux.watsup
  def $free_mem{memtype : memtype}(MEMORY_mem(memtype)) = $free_memtype(memtype)

;; 2-syntax-aux.watsup
def $free_tag(tag : tag) : free
  ;; 2-syntax-aux.watsup
  def $free_tag{typeidx : typeidx}(TAG_tag(typeidx)) = $free_typeidx(typeidx)

;; 2-syntax-aux.watsup
def $free_elemmode(elemmode : elemmode) : free
  ;; 2-syntax-aux.watsup
  def $free_elemmode{tableidx : tableidx, expr : expr}(ACTIVE_elemmode(tableidx, expr)) = $free_tableidx(tableidx) +++ $free_expr(expr)
  ;; 2-syntax-aux.watsup
  def $free_elemmode(PASSIVE_elemmode) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; 2-syntax-aux.watsup
  def $free_elemmode(DECLARE_elemmode) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_datamode(datamode : datamode) : free
  ;; 2-syntax-aux.watsup
  def $free_datamode{memidx : memidx, expr : expr}(ACTIVE_datamode(memidx, expr)) = $free_memidx(memidx) +++ $free_expr(expr)
  ;; 2-syntax-aux.watsup
  def $free_datamode(PASSIVE_datamode) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; 2-syntax-aux.watsup
def $free_elem(elem : elem) : free
  ;; 2-syntax-aux.watsup
  def $free_elem{reftype : reftype, `expr*` : expr*, elemmode : elemmode}(ELEM_elem(reftype, expr*{expr <- `expr*`}, elemmode)) = $free_reftype(reftype) +++ $free_list($free_expr(expr)*{expr <- `expr*`}) +++ $free_elemmode(elemmode)

;; 2-syntax-aux.watsup
def $free_data(data : data) : free
  ;; 2-syntax-aux.watsup
  def $free_data{`byte*` : byte*, datamode : datamode}(DATA_data(byte*{byte <- `byte*`}, datamode)) = $free_datamode(datamode)

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
  def $free_module{`type*` : type*, `import*` : import*, `func*` : func*, `global*` : global*, `table*` : table*, `mem*` : mem*, `tag*` : tag*, `elem*` : elem*, `data*` : data*, `start?` : start?, `export*` : export*}(MODULE_module(type*{type <- `type*`}, import*{import <- `import*`}, func*{func <- `func*`}, global*{global <- `global*`}, table*{table <- `table*`}, mem*{mem <- `mem*`}, tag*{tag <- `tag*`}, elem*{elem <- `elem*`}, data*{data <- `data*`}, start?{start <- `start?`}, export*{export <- `export*`})) = $free_list($free_type(type)*{type <- `type*`}) +++ $free_list($free_import(import)*{import <- `import*`}) +++ $free_list($free_func(func)*{func <- `func*`}) +++ $free_list($free_global(global)*{global <- `global*`}) +++ $free_list($free_table(table)*{table <- `table*`}) +++ $free_list($free_mem(mem)*{mem <- `mem*`}) +++ $free_list($free_tag(tag)*{tag <- `tag*`}) +++ $free_list($free_elem(elem)*{elem <- `elem*`}) +++ $free_list($free_data(data)*{data <- `data*`}) +++ $free_opt($free_start(start)?{start <- `start?`}) +++ $free_list($free_export(export)*{export <- `export*`})

;; 2-syntax-aux.watsup
def $funcidx_module(module : module) : funcidx*
  ;; 2-syntax-aux.watsup
  def $funcidx_module{module : module}(module) = $free_module(module).FUNCS_free

;; 2-syntax-aux.watsup
def $dataidx_funcs(func*) : dataidx*
  ;; 2-syntax-aux.watsup
  def $dataidx_funcs{`func*` : func*}(func*{func <- `func*`}) = $free_list($free_func(func)*{func <- `func*`}).DATAS_free

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:533.1-533.112
def $subst_typevar(typevar : typevar, typevar*, typeuse*) : typeuse
  ;; 2-syntax-aux.watsup:560.1-560.38
  def $subst_typevar{tv : typevar}(tv, [], []) = (tv : typevar <: typeuse)
  ;; 2-syntax-aux.watsup:561.1-561.95
  def $subst_typevar{tv : typevar, tv_1 : typevar, `tv'*` : typevar*, tu_1 : typeuse, `tu'*` : typeuse*}(tv, [tv_1] ++ tv'*{tv' <- `tv'*`}, [tu_1] ++ tu'*{tu' <- `tu'*`}) = tu_1
    -- if (tv = tv_1)
  ;; 2-syntax-aux.watsup:562.1-562.92
  def $subst_typevar{tv : typevar, tv_1 : typevar, `tv'*` : typevar*, tu_1 : typeuse, `tu'*` : typeuse*}(tv, [tv_1] ++ tv'*{tv' <- `tv'*`}, [tu_1] ++ tu'*{tu' <- `tu'*`}) = $subst_typevar(tv, tv'*{tv' <- `tv'*`}, tu'*{tu' <- `tu'*`})
    -- otherwise
}

;; 2-syntax-aux.watsup
def $subst_packtype(packtype : packtype, typevar*, typeuse*) : packtype
  ;; 2-syntax-aux.watsup
  def $subst_packtype{pt : packtype, `tv*` : typevar*, `tu*` : typeuse*}(pt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = pt

;; 2-syntax-aux.watsup
def $subst_numtype(numtype : numtype, typevar*, typeuse*) : numtype
  ;; 2-syntax-aux.watsup
  def $subst_numtype{nt : numtype, `tv*` : typevar*, `tu*` : typeuse*}(nt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = nt

;; 2-syntax-aux.watsup
def $subst_vectype(vectype : vectype, typevar*, typeuse*) : vectype
  ;; 2-syntax-aux.watsup
  def $subst_vectype{vt : vectype, `tv*` : typevar*, `tu*` : typeuse*}(vt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = vt

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:534.1-534.112
def $subst_typeuse(typeuse : typeuse, typevar*, typeuse*) : typeuse
  ;; 2-syntax-aux.watsup:564.1-564.66
  def $subst_typeuse{tv' : typevar, `tv*` : typevar*, `tu*` : typeuse*}((tv' : typevar <: typeuse), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = $subst_typevar(tv', tv*{tv <- `tv*`}, tu*{tu <- `tu*`})
  ;; 2-syntax-aux.watsup:565.1-565.64
  def $subst_typeuse{dt : deftype, `tv*` : typevar*, `tu*` : typeuse*}((dt : deftype <: typeuse), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_deftype(dt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : deftype <: typeuse)

;; 2-syntax-aux.watsup:538.1-538.112
def $subst_heaptype(heaptype : heaptype, typevar*, typeuse*) : heaptype
  ;; 2-syntax-aux.watsup:570.1-570.67
  def $subst_heaptype{tv' : typevar, `tv*` : typevar*, `tu*` : typeuse*}((tv' : typevar <: heaptype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_typevar(tv', tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : typeuse <: heaptype)
  ;; 2-syntax-aux.watsup:571.1-571.65
  def $subst_heaptype{dt : deftype, `tv*` : typevar*, `tu*` : typeuse*}((dt : deftype <: heaptype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_deftype(dt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : deftype <: heaptype)
  ;; 2-syntax-aux.watsup:572.1-572.53
  def $subst_heaptype{ht : heaptype, `tv*` : typevar*, `tu*` : typeuse*}(ht, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ht
    -- otherwise

;; 2-syntax-aux.watsup:539.1-539.112
def $subst_reftype(reftype : reftype, typevar*, typeuse*) : reftype
  ;; 2-syntax-aux.watsup:574.1-574.83
  def $subst_reftype{nul : nul, ht : heaptype, `tv*` : typevar*, `tu*` : typeuse*}(REF_reftype(nul, ht), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = REF_reftype(nul, $subst_heaptype(ht, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; 2-syntax-aux.watsup:540.1-540.112
def $subst_valtype(valtype : valtype, typevar*, typeuse*) : valtype
  ;; 2-syntax-aux.watsup:576.1-576.64
  def $subst_valtype{nt : numtype, `tv*` : typevar*, `tu*` : typeuse*}((nt : numtype <: valtype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_numtype(nt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : numtype <: valtype)
  ;; 2-syntax-aux.watsup:577.1-577.64
  def $subst_valtype{vt : vectype, `tv*` : typevar*, `tu*` : typeuse*}((vt : vectype <: valtype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_vectype(vt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : vectype <: valtype)
  ;; 2-syntax-aux.watsup:578.1-578.64
  def $subst_valtype{rt : reftype, `tv*` : typevar*, `tu*` : typeuse*}((rt : reftype <: valtype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_reftype(rt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : reftype <: valtype)
  ;; 2-syntax-aux.watsup:579.1-579.40
  def $subst_valtype{`tv*` : typevar*, `tu*` : typeuse*}(BOT_valtype, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = BOT_valtype

;; 2-syntax-aux.watsup:543.1-543.112
def $subst_storagetype(storagetype : storagetype, typevar*, typeuse*) : storagetype
  ;; 2-syntax-aux.watsup:583.1-583.66
  def $subst_storagetype{t : valtype, `tv*` : typevar*, `tu*` : typeuse*}((t : valtype <: storagetype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_valtype(t, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : valtype <: storagetype)
  ;; 2-syntax-aux.watsup:584.1-584.69
  def $subst_storagetype{pt : packtype, `tv*` : typevar*, `tu*` : typeuse*}((pt : packtype <: storagetype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_packtype(pt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : packtype <: storagetype)

;; 2-syntax-aux.watsup:544.1-544.112
def $subst_fieldtype(fieldtype : fieldtype, typevar*, typeuse*) : fieldtype
  ;; 2-syntax-aux.watsup:586.1-586.80
  def $subst_fieldtype{mut : mut, zt : storagetype, `tv*` : typevar*, `tu*` : typeuse*}(`%%`_fieldtype(mut, zt), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = `%%`_fieldtype(mut, $subst_storagetype(zt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; 2-syntax-aux.watsup:546.1-546.112
def $subst_comptype(comptype : comptype, typevar*, typeuse*) : comptype
  ;; 2-syntax-aux.watsup:588.1-588.85
  def $subst_comptype{`yt*` : fieldtype*, `tv*` : typevar*, `tu*` : typeuse*}(STRUCT_comptype(`%`_structtype(yt*{yt <- `yt*`})), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = STRUCT_comptype(`%`_structtype($subst_fieldtype(yt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{yt <- `yt*`}))
  ;; 2-syntax-aux.watsup:589.1-589.81
  def $subst_comptype{yt : fieldtype, `tv*` : typevar*, `tu*` : typeuse*}(ARRAY_comptype(yt), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ARRAY_comptype($subst_fieldtype(yt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))
  ;; 2-syntax-aux.watsup:590.1-590.78
  def $subst_comptype{ft : functype, `tv*` : typevar*, `tu*` : typeuse*}(FUNC_comptype(ft), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = FUNC_comptype($subst_functype(ft, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; 2-syntax-aux.watsup:547.1-547.112
def $subst_subtype(subtype : subtype, typevar*, typeuse*) : subtype
  ;; 2-syntax-aux.watsup:592.1-593.71
  def $subst_subtype{fin : fin, `tu'*` : typeuse*, ct : comptype, `tv*` : typevar*, `tu*` : typeuse*}(SUB_subtype(fin, tu'*{tu' <- `tu'*`}, ct), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = SUB_subtype(fin, $subst_typeuse(tu', tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{tu' <- `tu'*`}, $subst_comptype(ct, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; 2-syntax-aux.watsup:548.1-548.112
def $subst_rectype(rectype : rectype, typevar*, typeuse*) : rectype
  ;; 2-syntax-aux.watsup:595.1-595.76
  def $subst_rectype{`st*` : subtype*, `tv*` : typevar*, `tu*` : typeuse*}(REC_rectype(`%`_list(st*{st <- `st*`})), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = REC_rectype(`%`_list($subst_subtype(st, tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{st <- `st*`}))

;; 2-syntax-aux.watsup:549.1-549.112
def $subst_deftype(deftype : deftype, typevar*, typeuse*) : deftype
  ;; 2-syntax-aux.watsup:597.1-597.78
  def $subst_deftype{qt : rectype, i : nat, `tv*` : typevar*, `tu*` : typeuse*}(DEF_deftype(qt, i), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = DEF_deftype($subst_rectype(qt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}), i)

;; 2-syntax-aux.watsup:552.1-552.112
def $subst_functype(functype : functype, typevar*, typeuse*) : functype
  ;; 2-syntax-aux.watsup:600.1-600.113
  def $subst_functype{`t_1*` : valtype*, `t_2*` : valtype*, `tv*` : typevar*, `tu*` : typeuse*}(`%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = `%->%`_functype(`%`_resulttype($subst_valtype(t_1, tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{t_1 <- `t_1*`}), `%`_resulttype($subst_valtype(t_2, tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{t_2 <- `t_2*`}))
}

;; 2-syntax-aux.watsup
def $subst_globaltype(globaltype : globaltype, typevar*, typeuse*) : globaltype
  ;; 2-syntax-aux.watsup
  def $subst_globaltype{mut : mut, t : valtype, `tv*` : typevar*, `tu*` : typeuse*}(`%%`_globaltype(mut, t), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = `%%`_globaltype(mut, $subst_valtype(t, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; 2-syntax-aux.watsup
def $subst_tabletype(tabletype : tabletype, typevar*, typeuse*) : tabletype
  ;; 2-syntax-aux.watsup
  def $subst_tabletype{lim : limits, rt : reftype, `tv*` : typevar*, `tu*` : typeuse*}(`%%`_tabletype(lim, rt), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = `%%`_tabletype(lim, $subst_reftype(rt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; 2-syntax-aux.watsup
def $subst_memtype(memtype : memtype, typevar*, typeuse*) : memtype
  ;; 2-syntax-aux.watsup
  def $subst_memtype{lim : limits, `tv*` : typevar*, `tu*` : typeuse*}(`%PAGE`_memtype(lim), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = `%PAGE`_memtype(lim)

;; 2-syntax-aux.watsup
def $subst_externtype(externtype : externtype, typevar*, typeuse*) : externtype
  ;; 2-syntax-aux.watsup
  def $subst_externtype{dt : deftype, `tv*` : typevar*, `tu*` : typeuse*}(FUNC_externtype((dt : deftype <: typeuse)), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = FUNC_externtype(($subst_deftype(dt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : deftype <: typeuse))
  ;; 2-syntax-aux.watsup
  def $subst_externtype{gt : globaltype, `tv*` : typevar*, `tu*` : typeuse*}(GLOBAL_externtype(gt), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = GLOBAL_externtype($subst_globaltype(gt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))
  ;; 2-syntax-aux.watsup
  def $subst_externtype{tt : tabletype, `tv*` : typevar*, `tu*` : typeuse*}(TABLE_externtype(tt), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = TABLE_externtype($subst_tabletype(tt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))
  ;; 2-syntax-aux.watsup
  def $subst_externtype{mt : memtype, `tv*` : typevar*, `tu*` : typeuse*}(MEM_externtype(mt), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = MEM_externtype($subst_memtype(mt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; 2-syntax-aux.watsup
def $subst_moduletype(moduletype : moduletype, typevar*, typeuse*) : moduletype
  ;; 2-syntax-aux.watsup
  def $subst_moduletype{`xt_1*` : externtype*, `xt_2*` : externtype*, `tv*` : typevar*, `tu*` : typeuse*}(`%->%`_moduletype(xt_1*{xt_1 <- `xt_1*`}, xt_2*{xt_2 <- `xt_2*`}), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = `%->%`_moduletype($subst_externtype(xt_1, tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{xt_1 <- `xt_1*`}, $subst_externtype(xt_2, tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{xt_2 <- `xt_2*`})

;; 2-syntax-aux.watsup
def $subst_all_valtype(valtype : valtype, heaptype*) : valtype
  ;; 2-syntax-aux.watsup
  def $subst_all_valtype{t : valtype, `tu*` : typeuse*, n : n, `i*` : nat*}(t, (tu : typeuse <: heaptype)^n{tu <- `tu*`}) = $subst_valtype(t, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; 2-syntax-aux.watsup
def $subst_all_reftype(reftype : reftype, heaptype*) : reftype
  ;; 2-syntax-aux.watsup
  def $subst_all_reftype{rt : reftype, `tu*` : typeuse*, n : n, `i*` : nat*}(rt, (tu : typeuse <: heaptype)^n{tu <- `tu*`}) = $subst_reftype(rt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; 2-syntax-aux.watsup
def $subst_all_deftype(deftype : deftype, heaptype*) : deftype
  ;; 2-syntax-aux.watsup
  def $subst_all_deftype{dt : deftype, `tu*` : typeuse*, n : n, `i*` : nat*}(dt, (tu : typeuse <: heaptype)^n{tu <- `tu*`}) = $subst_deftype(dt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; 2-syntax-aux.watsup
def $subst_all_globaltype(globaltype : globaltype, heaptype*) : globaltype
  ;; 2-syntax-aux.watsup
  def $subst_all_globaltype{gt : globaltype, `tu*` : typeuse*, n : n, `i*` : nat*}(gt, (tu : typeuse <: heaptype)^n{tu <- `tu*`}) = $subst_globaltype(gt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; 2-syntax-aux.watsup
def $subst_all_tabletype(tabletype : tabletype, heaptype*) : tabletype
  ;; 2-syntax-aux.watsup
  def $subst_all_tabletype{tt : tabletype, `tu*` : typeuse*, n : n, `i*` : nat*}(tt, (tu : typeuse <: heaptype)^n{tu <- `tu*`}) = $subst_tabletype(tt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; 2-syntax-aux.watsup
def $subst_all_memtype(memtype : memtype, heaptype*) : memtype
  ;; 2-syntax-aux.watsup
  def $subst_all_memtype{mt : memtype, `tu*` : typeuse*, n : n, `i*` : nat*}(mt, (tu : typeuse <: heaptype)^n{tu <- `tu*`}) = $subst_memtype(mt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; 2-syntax-aux.watsup
def $subst_all_moduletype(moduletype : moduletype, heaptype*) : moduletype
  ;; 2-syntax-aux.watsup
  def $subst_all_moduletype{mmt : moduletype, `tu*` : typeuse*, n : n, `i*` : nat*}(mmt, (tu : typeuse <: heaptype)^n{tu <- `tu*`}) = $subst_moduletype(mmt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:628.1-628.98
def $subst_all_deftypes(deftype*, heaptype*) : deftype*
  ;; 2-syntax-aux.watsup:629.1-629.40
  def $subst_all_deftypes{`tu*` : typeuse*}([], (tu : typeuse <: heaptype)*{tu <- `tu*`}) = []
  ;; 2-syntax-aux.watsup:630.1-630.101
  def $subst_all_deftypes{dt_1 : deftype, `dt*` : deftype*, `tu*` : typeuse*}([dt_1] ++ dt*{dt <- `dt*`}, (tu : typeuse <: heaptype)*{tu <- `tu*`}) = [$subst_all_deftype(dt_1, (tu : typeuse <: heaptype)*{tu <- `tu*`})] ++ $subst_all_deftypes(dt*{dt <- `dt*`}, (tu : typeuse <: heaptype)*{tu <- `tu*`})
}

;; 2-syntax-aux.watsup
def $rollrt(typeidx : typeidx, rectype : rectype) : rectype
  ;; 2-syntax-aux.watsup
  def $rollrt{x : idx, rectype : rectype, `subtype*` : subtype*, `i*` : nat*, n : n}(x, rectype) = REC_rectype(`%`_list($subst_subtype(subtype, _IDX_typevar(`%`_typeidx((x!`%`_idx.0 + i)))^(i<n){i <- `i*`}, REC_typeuse(i)^(i<n){i <- `i*`})^n{subtype <- `subtype*`}))
    -- if (rectype = REC_rectype(`%`_list(subtype^n{subtype <- `subtype*`})))

;; 2-syntax-aux.watsup
def $unrollrt(rectype : rectype) : rectype
  ;; 2-syntax-aux.watsup
  def $unrollrt{rectype : rectype, `subtype*` : subtype*, `i*` : nat*, n : n}(rectype) = REC_rectype(`%`_list($subst_subtype(subtype, REC_typevar(i)^(i<n){i <- `i*`}, DEF_typeuse(rectype, i)^(i<n){i <- `i*`})^n{subtype <- `subtype*`}))
    -- if (rectype = REC_rectype(`%`_list(subtype^n{subtype <- `subtype*`})))

;; 2-syntax-aux.watsup
def $rolldt(typeidx : typeidx, rectype : rectype) : deftype*
  ;; 2-syntax-aux.watsup
  def $rolldt{x : idx, rectype : rectype, `subtype*` : subtype*, n : n, `i*` : nat*}(x, rectype) = DEF_deftype(REC_rectype(`%`_list(subtype^n{subtype <- `subtype*`})), i)^(i<n){i <- `i*`}
    -- if ($rollrt(x, rectype) = REC_rectype(`%`_list(subtype^n{subtype <- `subtype*`})))

;; 2-syntax-aux.watsup
def $unrolldt(deftype : deftype) : subtype
  ;; 2-syntax-aux.watsup
  def $unrolldt{rectype : rectype, i : nat, `subtype*` : subtype*}(DEF_deftype(rectype, i)) = subtype*{subtype <- `subtype*`}[i]
    -- if ($unrollrt(rectype) = REC_rectype(`%`_list(subtype*{subtype <- `subtype*`})))

;; 2-syntax-aux.watsup
def $expanddt(deftype : deftype) : comptype
  ;; 2-syntax-aux.watsup
  def $expanddt{deftype : deftype, comptype : comptype, fin : fin, `typeuse*` : typeuse*}(deftype) = comptype
    -- if ($unrolldt(deftype) = SUB_subtype(fin, typeuse*{typeuse <- `typeuse*`}, comptype))

;; 2-syntax-aux.watsup
relation Expand: `%~~%`(deftype, comptype)
  ;; 2-syntax-aux.watsup
  rule _{deftype : deftype, comptype : comptype, fin : fin, `typeuse*` : typeuse*}:
    `%~~%`(deftype, comptype)
    -- if ($unrolldt(deftype) = SUB_subtype(fin, typeuse*{typeuse <- `typeuse*`}, comptype))

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:662.1-662.86
def $funcsxx(externidx*) : typeidx*
  ;; 2-syntax-aux.watsup:668.1-668.24
  def $funcsxx([]) = []
  ;; 2-syntax-aux.watsup:669.1-669.45
  def $funcsxx{x : idx, `xx*` : externidx*}([FUNC_externidx(x)] ++ xx*{xx <- `xx*`}) = [x] ++ $funcsxx(xx*{xx <- `xx*`})
  ;; 2-syntax-aux.watsup:670.1-670.58
  def $funcsxx{externidx : externidx, `xx*` : externidx*}([externidx] ++ xx*{xx <- `xx*`}) = $funcsxx(xx*{xx <- `xx*`})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:663.1-663.88
def $globalsxx(externidx*) : globalidx*
  ;; 2-syntax-aux.watsup:672.1-672.26
  def $globalsxx([]) = []
  ;; 2-syntax-aux.watsup:673.1-673.51
  def $globalsxx{x : idx, `xx*` : externidx*}([GLOBAL_externidx(x)] ++ xx*{xx <- `xx*`}) = [x] ++ $globalsxx(xx*{xx <- `xx*`})
  ;; 2-syntax-aux.watsup:674.1-674.62
  def $globalsxx{externidx : externidx, `xx*` : externidx*}([externidx] ++ xx*{xx <- `xx*`}) = $globalsxx(xx*{xx <- `xx*`})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:664.1-664.87
def $tablesxx(externidx*) : tableidx*
  ;; 2-syntax-aux.watsup:676.1-676.25
  def $tablesxx([]) = []
  ;; 2-syntax-aux.watsup:677.1-677.48
  def $tablesxx{x : idx, `xx*` : externidx*}([TABLE_externidx(x)] ++ xx*{xx <- `xx*`}) = [x] ++ $tablesxx(xx*{xx <- `xx*`})
  ;; 2-syntax-aux.watsup:678.1-678.60
  def $tablesxx{externidx : externidx, `xx*` : externidx*}([externidx] ++ xx*{xx <- `xx*`}) = $tablesxx(xx*{xx <- `xx*`})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:665.1-665.85
def $memsxx(externidx*) : memidx*
  ;; 2-syntax-aux.watsup:680.1-680.23
  def $memsxx([]) = []
  ;; 2-syntax-aux.watsup:681.1-681.42
  def $memsxx{x : idx, `xx*` : externidx*}([MEM_externidx(x)] ++ xx*{xx <- `xx*`}) = [x] ++ $memsxx(xx*{xx <- `xx*`})
  ;; 2-syntax-aux.watsup:682.1-682.56
  def $memsxx{externidx : externidx, `xx*` : externidx*}([externidx] ++ xx*{xx <- `xx*`}) = $memsxx(xx*{xx <- `xx*`})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:666.1-666.85
def $tagsxx(externidx*) : tagidx*
  ;; 2-syntax-aux.watsup:684.1-684.23
  def $tagsxx([]) = []
  ;; 2-syntax-aux.watsup:685.1-685.42
  def $tagsxx{x : idx, `xx*` : externidx*}([TAG_externidx(x)] ++ xx*{xx <- `xx*`}) = [x] ++ $tagsxx(xx*{xx <- `xx*`})
  ;; 2-syntax-aux.watsup:686.1-686.56
  def $tagsxx{externidx : externidx, `xx*` : externidx*}([externidx] ++ xx*{xx <- `xx*`}) = $tagsxx(xx*{xx <- `xx*`})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:689.1-689.88
def $funcsxt(externtype*) : deftype*
  ;; 2-syntax-aux.watsup:695.1-695.24
  def $funcsxt([]) = []
  ;; 2-syntax-aux.watsup:696.1-696.47
  def $funcsxt{dt : deftype, `xt*` : externtype*}([FUNC_externtype((dt : deftype <: typeuse))] ++ xt*{xt <- `xt*`}) = [dt] ++ $funcsxt(xt*{xt <- `xt*`})
  ;; 2-syntax-aux.watsup:697.1-697.59
  def $funcsxt{externtype : externtype, `xt*` : externtype*}([externtype] ++ xt*{xt <- `xt*`}) = $funcsxt(xt*{xt <- `xt*`})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:690.1-690.90
def $globalsxt(externtype*) : globaltype*
  ;; 2-syntax-aux.watsup:699.1-699.26
  def $globalsxt([]) = []
  ;; 2-syntax-aux.watsup:700.1-700.53
  def $globalsxt{gt : globaltype, `xt*` : externtype*}([GLOBAL_externtype(gt)] ++ xt*{xt <- `xt*`}) = [gt] ++ $globalsxt(xt*{xt <- `xt*`})
  ;; 2-syntax-aux.watsup:701.1-701.63
  def $globalsxt{externtype : externtype, `xt*` : externtype*}([externtype] ++ xt*{xt <- `xt*`}) = $globalsxt(xt*{xt <- `xt*`})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:691.1-691.89
def $tablesxt(externtype*) : tabletype*
  ;; 2-syntax-aux.watsup:703.1-703.25
  def $tablesxt([]) = []
  ;; 2-syntax-aux.watsup:704.1-704.50
  def $tablesxt{tt : tabletype, `xt*` : externtype*}([TABLE_externtype(tt)] ++ xt*{xt <- `xt*`}) = [tt] ++ $tablesxt(xt*{xt <- `xt*`})
  ;; 2-syntax-aux.watsup:705.1-705.61
  def $tablesxt{externtype : externtype, `xt*` : externtype*}([externtype] ++ xt*{xt <- `xt*`}) = $tablesxt(xt*{xt <- `xt*`})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:692.1-692.87
def $memsxt(externtype*) : memtype*
  ;; 2-syntax-aux.watsup:707.1-707.23
  def $memsxt([]) = []
  ;; 2-syntax-aux.watsup:708.1-708.44
  def $memsxt{mt : memtype, `xt*` : externtype*}([MEM_externtype(mt)] ++ xt*{xt <- `xt*`}) = [mt] ++ $memsxt(xt*{xt <- `xt*`})
  ;; 2-syntax-aux.watsup:709.1-709.57
  def $memsxt{externtype : externtype, `xt*` : externtype*}([externtype] ++ xt*{xt <- `xt*`}) = $memsxt(xt*{xt <- `xt*`})
    -- otherwise
}

;; 2-syntax-aux.watsup
rec {

;; 2-syntax-aux.watsup:693.1-693.87
def $tagsxt(externtype*) : tagtype*
  ;; 2-syntax-aux.watsup:711.1-711.23
  def $tagsxt([]) = []
  ;; 2-syntax-aux.watsup:712.1-712.44
  def $tagsxt{at : tagtype, `xt*` : externtype*}([TAG_externtype((at : deftype <: typeuse))] ++ xt*{xt <- `xt*`}) = [at] ++ $tagsxt(xt*{xt <- `xt*`})
  ;; 2-syntax-aux.watsup:713.1-713.57
  def $tagsxt{externtype : externtype, `xt*` : externtype*}([externtype] ++ xt*{xt <- `xt*`}) = $tagsxt(xt*{xt <- `xt*`})
    -- otherwise
}

;; 2-syntax-aux.watsup
def $memarg0 : memarg
  ;; 2-syntax-aux.watsup
  def $memarg0 = {ALIGN `%`_u32(0), OFFSET `%`_u32(0)}

;; 3-numerics.watsup
syntax relaxed2 =
  | `%`{i : nat}(i : nat)
    -- if ((i = 0) \/ (i = 1))

;; 3-numerics.watsup
syntax relaxed4 =
  | `%`{i : nat}(i : nat)
    -- if ((((i = 0) \/ (i = 1)) \/ (i = 2)) \/ (i = 3))

;; 3-numerics.watsup
def $relaxed2(relaxed2 : relaxed2, syntax X, X : X, X : X) : X
  ;; 3-numerics.watsup
  def $relaxed2{i : nat, syntax X, X_1 : X, X_2 : X}(`%`_relaxed2(i), syntax X, X_1, X_2) = [X_1 X_2][i]
    -- if $ND
  ;; 3-numerics.watsup
  def $relaxed2{i : nat, syntax X, X_1 : X, X_2 : X}(`%`_relaxed2(i), syntax X, X_1, X_2) = [X_1 X_2][0]
    -- otherwise

;; 3-numerics.watsup
def $relaxed4(relaxed4 : relaxed4, syntax X, X : X, X : X, X : X, X : X) : X
  ;; 3-numerics.watsup
  def $relaxed4{i : nat, syntax X, X_1 : X, X_2 : X, X_3 : X, X_4 : X}(`%`_relaxed4(i), syntax X, X_1, X_2, X_3, X_4) = [X_1 X_2 X_3 X_4][i]
    -- if $ND
  ;; 3-numerics.watsup
  def $relaxed4{i : nat, syntax X, X_1 : X, X_2 : X, X_3 : X, X_4 : X}(`%`_relaxed4(i), syntax X, X_1, X_2, X_3, X_4) = [X_1 X_2 X_3 X_4][0]
    -- otherwise

;; 3-numerics.watsup
def $R_fmadd : relaxed2

;; 3-numerics.watsup
def $R_fmin : relaxed4

;; 3-numerics.watsup
def $R_fmax : relaxed4

;; 3-numerics.watsup
def $R_idot : relaxed2

;; 3-numerics.watsup
def $R_iq15mulr : relaxed2

;; 3-numerics.watsup
def $R_trunc_u : relaxed4

;; 3-numerics.watsup
def $R_trunc_s : relaxed2

;; 3-numerics.watsup
def $R_swizzle : relaxed2

;; 3-numerics.watsup
def $R_laneselect : relaxed2

;; 3-numerics.watsup
def $s33_to_u32(s33 : s33) : u32

;; 3-numerics.watsup
def $signed_(N : N, nat : nat) : int
  ;; 3-numerics.watsup
  def $signed_{N : N, i : nat}(N, i) = (i : nat <: int)
    -- if (0 <= (2 ^ (N - 1)))
  ;; 3-numerics.watsup
  def $signed_{N : N, i : nat}(N, i) = ((i - (2 ^ N)) : nat <: int)
    -- if (((2 ^ (N - 1)) <= i) /\ (i < (2 ^ N)))

;; 3-numerics.watsup
def $invsigned_(N : N, int : int) : nat
  ;; 3-numerics.watsup
  def $invsigned_{N : N, i : nat, j : nat}(N, (i : nat <: int)) = j
    -- if ($signed_(N, j) = (i : nat <: int))

;; 3-numerics.watsup
def $sat_u_(N : N, nat : nat) : nat
  ;; 3-numerics.watsup
  def $sat_u_{N : N, i : nat}(N, i) = 0
    -- if (i < 0)
  ;; 3-numerics.watsup
  def $sat_u_{N : N, i : nat}(N, i) = ((2 ^ N) - 1)
    -- if (i > ((2 ^ N) - 1))
  ;; 3-numerics.watsup
  def $sat_u_{N : N, i : nat}(N, i) = i
    -- otherwise

;; 3-numerics.watsup
def $sat_s_(N : N, int : int) : int
  ;; 3-numerics.watsup
  def $sat_s_{N : N, i : nat}(N, (i : nat <: int)) = - ((2 ^ (N - 1)) : nat <: int)
    -- if ((i : nat <: int) < - ((2 ^ (N - 1)) : nat <: int))
  ;; 3-numerics.watsup
  def $sat_s_{N : N, i : nat}(N, (i : nat <: int)) = (((2 ^ (N - 1)) - 1) : nat <: int)
    -- if (i > ((2 ^ (N - 1)) - 1))
  ;; 3-numerics.watsup
  def $sat_s_{N : N, i : nat}(N, (i : nat <: int)) = (i : nat <: int)
    -- otherwise

;; 3-numerics.watsup
def $wrap__(M : M, N : N, iN : iN(M)) : iN(N)

;; 3-numerics.watsup
def $extend__(M : M, N : N, sx : sx, iN : iN(M)) : iN(N)

;; 3-numerics.watsup
def $trunc__(M : M, N : N, sx : sx, fN : fN(M)) : iN(N)?

;; 3-numerics.watsup
def $trunc_sat__(M : M, N : N, sx : sx, fN : fN(M)) : iN(N)?

;; 3-numerics.watsup
def $relaxed_trunc__(M : M, N : N, sx : sx, fN : fN(M)) : iN(N)?

;; 3-numerics.watsup
def $demote__(M : M, N : N, fN : fN(M)) : fN(N)*

;; 3-numerics.watsup
def $promote__(M : M, N : N, fN : fN(M)) : fN(N)*

;; 3-numerics.watsup
def $convert__(M : M, N : N, sx : sx, iN : iN(M)) : fN(N)

;; 3-numerics.watsup
def $narrow__(M : M, N : N, sx : sx, iN : iN(M)) : iN(N)

;; 3-numerics.watsup
def $reinterpret__(numtype_1 : numtype, numtype_2 : numtype, num_ : num_(numtype_1)) : num_(numtype_2)

;; 3-numerics.watsup
def $ibits_(N : N, iN : iN(N)) : bit*

;; 3-numerics.watsup
def $fbits_(N : N, fN : fN(N)) : bit*

;; 3-numerics.watsup
def $ibytes_(N : N, iN : iN(N)) : byte*

;; 3-numerics.watsup
def $fbytes_(N : N, fN : fN(N)) : byte*

;; 3-numerics.watsup
def $nbytes_(numtype : numtype, num_ : num_(numtype)) : byte*

;; 3-numerics.watsup
def $vbytes_(vectype : vectype, vec_ : vec_(vectype)) : byte*

;; 3-numerics.watsup
def $zbytes_(storagetype : storagetype, lit_ : lit_(storagetype)) : byte*

;; 3-numerics.watsup
def $cbytes_(Cnn : Cnn, lit_ : lit_((Cnn : Cnn <: storagetype))) : byte*

;; 3-numerics.watsup
def $invibytes_(N : N, byte*) : iN(N)
  ;; 3-numerics.watsup
  def $invibytes_{N : N, `b*` : byte*, n : n}(N, b*{b <- `b*`}) = `%`_iN(n)
    -- if ($ibytes_(N, `%`_iN(n)) = b*{b <- `b*`})

;; 3-numerics.watsup
def $invfbytes_(N : N, byte*) : fN(N)
  ;; 3-numerics.watsup
  def $invfbytes_{N : N, `b*` : byte*, p : fN(N)}(N, b*{b <- `b*`}) = p
    -- if ($fbytes_(N, p) = b*{b <- `b*`})

;; 3-numerics.watsup
def $iadd_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $isub_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $imul_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $idiv_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)?

;; 3-numerics.watsup
def $irem_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)?

;; 3-numerics.watsup
def $inot_(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $iand_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $iandnot_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ior_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ixor_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ishl_(N : N, iN : iN(N), u32 : u32) : iN(N)

;; 3-numerics.watsup
def $ishr_(N : N, sx : sx, iN : iN(N), u32 : u32) : iN(N)

;; 3-numerics.watsup
def $irotl_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $irotr_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $iclz_(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ictz_(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ipopcnt_(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ieqz_(N : N, iN : iN(N)) : u32

;; 3-numerics.watsup
def $inez_(N : N, iN : iN(N)) : u32

;; 3-numerics.watsup
def $ieq_(N : N, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup
def $ine_(N : N, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup
def $ilt_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup
def $igt_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup
def $ile_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup
def $ige_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32

;; 3-numerics.watsup
def $ibitselect_(N : N, iN : iN(N), iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $irelaxed_laneselect_(N : N, iN : iN(N), iN : iN(N), iN : iN(N)) : iN(N)*

;; 3-numerics.watsup
def $iabs_(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $ineg_(N : N, iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $imin_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $imax_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $iadd_sat_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $isub_sat_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $iavgr_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $iq15mulr_sat_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; 3-numerics.watsup
def $irelaxed_q15mulr_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)*

;; 3-numerics.watsup
def $fadd_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fsub_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fmul_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fdiv_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fmin_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fmax_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fpmin_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fpmax_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $frelaxed_min_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $frelaxed_max_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fcopysign_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fabs_(N : N, fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fneg_(N : N, fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fsqrt_(N : N, fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fceil_(N : N, fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $ffloor_(N : N, fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $ftrunc_(N : N, fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $fnearest_(N : N, fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $feq_(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup
def $fne_(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup
def $flt_(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup
def $fgt_(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup
def $fle_(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup
def $fge_(N : N, fN : fN(N), fN : fN(N)) : u32

;; 3-numerics.watsup
def $frelaxed_madd_(N : N, fN : fN(N), fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $frelaxed_nmadd_(N : N, fN : fN(N), fN : fN(N), fN : fN(N)) : fN(N)*

;; 3-numerics.watsup
def $lpacknum_(lanetype : lanetype, num_ : num_($lunpack(lanetype))) : lane_(lanetype)
  ;; 3-numerics.watsup
  def $lpacknum_{numtype : numtype, c : num_($lunpack((numtype : numtype <: lanetype)))}((numtype : numtype <: lanetype), c) = c
  ;; 3-numerics.watsup
  def $lpacknum_{packtype : packtype, c : num_($lunpack((packtype : packtype <: lanetype)))}((packtype : packtype <: lanetype), c) = $wrap__($size($lunpack((packtype : packtype <: lanetype))), $psize(packtype), c)

;; 3-numerics.watsup
def $lunpacknum_(lanetype : lanetype, lane_ : lane_(lanetype)) : num_($lunpack(lanetype))
  ;; 3-numerics.watsup
  def $lunpacknum_{numtype : numtype, c : lane_((numtype : numtype <: lanetype))}((numtype : numtype <: lanetype), c) = c
  ;; 3-numerics.watsup
  def $lunpacknum_{packtype : packtype, c : lane_((packtype : packtype <: lanetype))}((packtype : packtype <: lanetype), c) = $extend__($psize(packtype), $size($lunpack((packtype : packtype <: lanetype))), U_sx, c)

;; 3-numerics.watsup
def $cpacknum_(storagetype : storagetype, lit_ : lit_(($cunpack(storagetype) : consttype <: storagetype))) : lit_(storagetype)
  ;; 3-numerics.watsup
  def $cpacknum_{consttype : consttype, c : lit_(($cunpack((consttype : consttype <: storagetype)) : consttype <: storagetype))}((consttype : consttype <: storagetype), c) = c
  ;; 3-numerics.watsup
  def $cpacknum_{packtype : packtype, c : lit_(($cunpack((packtype : packtype <: storagetype)) : consttype <: storagetype))}((packtype : packtype <: storagetype), c) = $wrap__($size($lunpack((packtype : packtype <: lanetype))), $psize(packtype), c)

;; 3-numerics.watsup
def $cunpacknum_(storagetype : storagetype, lit_ : lit_(storagetype)) : lit_(($cunpack(storagetype) : consttype <: storagetype))
  ;; 3-numerics.watsup
  def $cunpacknum_{consttype : consttype, c : lit_((consttype : consttype <: storagetype))}((consttype : consttype <: storagetype), c) = c
  ;; 3-numerics.watsup
  def $cunpacknum_{packtype : packtype, c : lit_((packtype : packtype <: storagetype))}((packtype : packtype <: storagetype), c) = $extend__($psize(packtype), $size($lunpack((packtype : packtype <: lanetype))), U_sx, c)

;; 3-numerics.watsup
def $lanes_(shape : shape, vec_ : vec_(V128_Vnn)) : lane_($lanetype(shape))*

;; 3-numerics.watsup
def $invlanes_(shape : shape, lane_($lanetype(shape))*) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $invlanes_{sh : shape, `c*` : lane_($lanetype(sh))*, vc : vec_(V128_Vnn)}(sh, c*{c <- `c*`}) = vc
    -- if (c*{c <- `c*`} = $lanes_(sh, vc))

;; 3-numerics.watsup
def $half__(shape_1 : shape, shape_2 : shape, half__ : half__(shape_1, shape_2), nat : nat, nat : nat) : nat
  ;; 3-numerics.watsup
  def $half__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, i : nat, j : nat}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), LOW_half__, i, j) = i
  ;; 3-numerics.watsup
  def $half__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, i : nat, j : nat}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), HIGH_half__, i, j) = j
  ;; 3-numerics.watsup
  def $half__{Lnn_1 : Lnn, M_1 : M, Fnn_2 : Fnn, M_2 : M, i : nat, j : nat}(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), LOW_half__, i, j) = i

;; 3-numerics.watsup
def $unop_(numtype : numtype, unop_ : unop_(numtype), num_ : num_(numtype)) : num_(numtype)*
  ;; 3-numerics.watsup
  def $unop_{Inn : Inn, iN : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), CLZ_unop_, iN) = [$iclz_($sizenn((Inn : Inn <: numtype)), iN)]
  ;; 3-numerics.watsup
  def $unop_{Inn : Inn, iN : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), CTZ_unop_, iN) = [$ictz_($sizenn((Inn : Inn <: numtype)), iN)]
  ;; 3-numerics.watsup
  def $unop_{Inn : Inn, iN : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), POPCNT_unop_, iN) = [$ipopcnt_($sizenn((Inn : Inn <: numtype)), iN)]
  ;; 3-numerics.watsup
  def $unop_{Inn : Inn, M : M, iN : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), EXTEND_unop_(`%`_sz(M)), iN) = [$extend__(M, $sizenn((Inn : Inn <: numtype)), S_sx, $wrap__($sizenn((Inn : Inn <: numtype)), M, iN))]
  ;; 3-numerics.watsup
  def $unop_{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), ABS_unop_, fN) = $fabs_($sizenn((Fnn : Fnn <: numtype)), fN)
  ;; 3-numerics.watsup
  def $unop_{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), NEG_unop_, fN) = $fneg_($sizenn((Fnn : Fnn <: numtype)), fN)
  ;; 3-numerics.watsup
  def $unop_{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), SQRT_unop_, fN) = $fsqrt_($sizenn((Fnn : Fnn <: numtype)), fN)
  ;; 3-numerics.watsup
  def $unop_{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), CEIL_unop_, fN) = $fceil_($sizenn((Fnn : Fnn <: numtype)), fN)
  ;; 3-numerics.watsup
  def $unop_{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), FLOOR_unop_, fN) = $ffloor_($sizenn((Fnn : Fnn <: numtype)), fN)
  ;; 3-numerics.watsup
  def $unop_{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), TRUNC_unop_, fN) = $ftrunc_($sizenn((Fnn : Fnn <: numtype)), fN)
  ;; 3-numerics.watsup
  def $unop_{Fnn : Fnn, fN : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), NEAREST_unop_, fN) = $fnearest_($sizenn((Fnn : Fnn <: numtype)), fN)

;; 3-numerics.watsup
def $binop_(numtype : numtype, binop_ : binop_(numtype), num_ : num_(numtype), num_ : num_(numtype)) : num_(numtype)*
  ;; 3-numerics.watsup
  def $binop_{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), ADD_binop_, iN_1, iN_2) = [$iadd_($sizenn((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop_{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), SUB_binop_, iN_1, iN_2) = [$isub_($sizenn((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop_{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), MUL_binop_, iN_1, iN_2) = [$imul_($sizenn((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop_{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), DIV_binop_(sx), iN_1, iN_2) = $list_(syntax num_((Inn : Inn <: numtype)), $idiv_($sizenn((Inn : Inn <: numtype)), sx, iN_1, iN_2))
  ;; 3-numerics.watsup
  def $binop_{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), REM_binop_(sx), iN_1, iN_2) = $list_(syntax num_((Inn : Inn <: numtype)), $irem_($sizenn((Inn : Inn <: numtype)), sx, iN_1, iN_2))
  ;; 3-numerics.watsup
  def $binop_{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), AND_binop_, iN_1, iN_2) = [$iand_($sizenn((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop_{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), OR_binop_, iN_1, iN_2) = [$ior_($sizenn((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop_{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), XOR_binop_, iN_1, iN_2) = [$ixor_($sizenn((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop_{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), SHL_binop_, iN_1, iN_2) = [$ishl_($sizenn((Inn : Inn <: numtype)), iN_1, `%`_u32(iN_2!`%`_num_.0))]
  ;; 3-numerics.watsup
  def $binop_{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), SHR_binop_(sx), iN_1, iN_2) = [$ishr_($sizenn((Inn : Inn <: numtype)), sx, iN_1, `%`_u32(iN_2!`%`_num_.0))]
  ;; 3-numerics.watsup
  def $binop_{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), ROTL_binop_, iN_1, iN_2) = [$irotl_($sizenn((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop_{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), ROTR_binop_, iN_1, iN_2) = [$irotr_($sizenn((Inn : Inn <: numtype)), iN_1, iN_2)]
  ;; 3-numerics.watsup
  def $binop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), ADD_binop_, fN_1, fN_2) = $fadd_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $binop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), SUB_binop_, fN_1, fN_2) = $fsub_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $binop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), MUL_binop_, fN_1, fN_2) = $fmul_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $binop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), DIV_binop_, fN_1, fN_2) = $fdiv_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $binop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), MIN_binop_, fN_1, fN_2) = $fmin_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $binop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), MAX_binop_, fN_1, fN_2) = $fmax_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $binop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), COPYSIGN_binop_, fN_1, fN_2) = $fcopysign_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)

;; 3-numerics.watsup
def $testop_(numtype : numtype, testop_ : testop_(numtype), num_ : num_(numtype)) : u32
  ;; 3-numerics.watsup
  def $testop_{Inn : Inn, iN : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), EQZ_testop_, iN) = $ieqz_($sizenn((Inn : Inn <: numtype)), iN)

;; 3-numerics.watsup
def $relop_(numtype : numtype, relop_ : relop_(numtype), num_ : num_(numtype), num_ : num_(numtype)) : u32
  ;; 3-numerics.watsup
  def $relop_{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), EQ_relop_, iN_1, iN_2) = $ieq_($sizenn((Inn : Inn <: numtype)), iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop_{Inn : Inn, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), NE_relop_, iN_1, iN_2) = $ine_($sizenn((Inn : Inn <: numtype)), iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop_{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), LT_relop_(sx), iN_1, iN_2) = $ilt_($sizenn((Inn : Inn <: numtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop_{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), GT_relop_(sx), iN_1, iN_2) = $igt_($sizenn((Inn : Inn <: numtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop_{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), LE_relop_(sx), iN_1, iN_2) = $ile_($sizenn((Inn : Inn <: numtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop_{Inn : Inn, sx : sx, iN_1 : num_((Inn : Inn <: numtype)), iN_2 : num_((Inn : Inn <: numtype))}((Inn : Inn <: numtype), GE_relop_(sx), iN_1, iN_2) = $ige_($sizenn((Inn : Inn <: numtype)), sx, iN_1, iN_2)
  ;; 3-numerics.watsup
  def $relop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), EQ_relop_, fN_1, fN_2) = $feq_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), NE_relop_, fN_1, fN_2) = $fne_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), LT_relop_, fN_1, fN_2) = $flt_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), GT_relop_, fN_1, fN_2) = $fgt_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), LE_relop_, fN_1, fN_2) = $fle_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)
  ;; 3-numerics.watsup
  def $relop_{Fnn : Fnn, fN_1 : num_((Fnn : Fnn <: numtype)), fN_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), GE_relop_, fN_1, fN_2) = $fge_($sizenn((Fnn : Fnn <: numtype)), fN_1, fN_2)

;; 3-numerics.watsup
def $cvtop__(numtype_1 : numtype, numtype_2 : numtype, cvtop__ : cvtop__(numtype_1, numtype_2), num_ : num_(numtype_1)) : num_(numtype_2)*
  ;; 3-numerics.watsup
  def $cvtop__{Inn_1 : Inn, Inn_2 : Inn, sx : sx, iN_1 : num_((Inn_1 : Inn <: numtype))}((Inn_1 : Inn <: numtype), (Inn_2 : Inn <: numtype), EXTEND_cvtop__(sx), iN_1) = [$extend__($sizenn1((Inn_1 : Inn <: numtype)), $sizenn2((Inn_2 : Inn <: numtype)), sx, iN_1)]
  ;; 3-numerics.watsup
  def $cvtop__{Inn_1 : Inn, Inn_2 : Inn, iN_1 : num_((Inn_1 : Inn <: numtype))}((Inn_1 : Inn <: numtype), (Inn_2 : Inn <: numtype), WRAP_cvtop__, iN_1) = [$wrap__($sizenn1((Inn_1 : Inn <: numtype)), $sizenn2((Inn_2 : Inn <: numtype)), iN_1)]
  ;; 3-numerics.watsup
  def $cvtop__{Fnn_1 : Fnn, Inn_2 : Inn, sx : sx, fN_1 : num_((Fnn_1 : Fnn <: numtype))}((Fnn_1 : Fnn <: numtype), (Inn_2 : Inn <: numtype), TRUNC_cvtop__(sx), fN_1) = $list_(syntax num_((Inn_2 : Inn <: numtype)), $trunc__($sizenn1((Fnn_1 : Fnn <: numtype)), $sizenn2((Inn_2 : Inn <: numtype)), sx, fN_1))
  ;; 3-numerics.watsup
  def $cvtop__{Fnn_1 : Fnn, Inn_2 : Inn, sx : sx, fN_1 : num_((Fnn_1 : Fnn <: numtype))}((Fnn_1 : Fnn <: numtype), (Inn_2 : Inn <: numtype), TRUNC_SAT_cvtop__(sx), fN_1) = $list_(syntax num_((Inn_2 : Inn <: numtype)), $trunc_sat__($sizenn1((Fnn_1 : Fnn <: numtype)), $sizenn2((Inn_2 : Inn <: numtype)), sx, fN_1))
  ;; 3-numerics.watsup
  def $cvtop__{Inn_1 : Inn, Fnn_2 : Fnn, sx : sx, iN_1 : num_((Inn_1 : Inn <: numtype))}((Inn_1 : Inn <: numtype), (Fnn_2 : Fnn <: numtype), CONVERT_cvtop__(sx), iN_1) = [$convert__($sizenn1((Inn_1 : Inn <: numtype)), $sizenn2((Fnn_2 : Fnn <: numtype)), sx, iN_1)]
  ;; 3-numerics.watsup
  def $cvtop__{Fnn_1 : Fnn, Fnn_2 : Fnn, fN_1 : num_((Fnn_1 : Fnn <: numtype))}((Fnn_1 : Fnn <: numtype), (Fnn_2 : Fnn <: numtype), PROMOTE_cvtop__, fN_1) = $promote__($sizenn1((Fnn_1 : Fnn <: numtype)), $sizenn2((Fnn_2 : Fnn <: numtype)), fN_1)
  ;; 3-numerics.watsup
  def $cvtop__{Fnn_1 : Fnn, Fnn_2 : Fnn, fN_1 : num_((Fnn_1 : Fnn <: numtype))}((Fnn_1 : Fnn <: numtype), (Fnn_2 : Fnn <: numtype), DEMOTE_cvtop__, fN_1) = $demote__($sizenn1((Fnn_1 : Fnn <: numtype)), $sizenn2((Fnn_2 : Fnn <: numtype)), fN_1)
  ;; 3-numerics.watsup
  def $cvtop__{Inn_1 : Inn, Fnn_2 : Fnn, iN_1 : num_((Inn_1 : Inn <: numtype))}((Inn_1 : Inn <: numtype), (Fnn_2 : Fnn <: numtype), REINTERPRET_cvtop__, iN_1) = [$reinterpret__((Inn_1 : Inn <: numtype), (Fnn_2 : Fnn <: numtype), iN_1)]
    -- if ($size((Inn_1 : Inn <: numtype)) = $size((Fnn_2 : Fnn <: numtype)))
  ;; 3-numerics.watsup
  def $cvtop__{Fnn_1 : Fnn, Inn_2 : Inn, fN_1 : num_((Fnn_1 : Fnn <: numtype))}((Fnn_1 : Fnn <: numtype), (Inn_2 : Inn <: numtype), REINTERPRET_cvtop__, fN_1) = [$reinterpret__((Fnn_1 : Fnn <: numtype), (Inn_2 : Inn <: numtype), fN_1)]
    -- if ($size((Fnn_1 : Fnn <: numtype)) = $size((Inn_2 : Inn <: numtype)))

;; 3-numerics.watsup
def $vvunop_(vectype : vectype, vvunop : vvunop, vec_ : vec_(vectype)) : vec_(vectype)*
  ;; 3-numerics.watsup
  def $vvunop_{v128 : vec_(V128_Vnn)}(V128_vectype, NOT_vvunop, v128) = [$inot_($vsize(V128_vectype), v128)]

;; 3-numerics.watsup
def $vvbinop_(vectype : vectype, vvbinop : vvbinop, vec_ : vec_(vectype), vec_ : vec_(vectype)) : vec_(vectype)*
  ;; 3-numerics.watsup
  def $vvbinop_{v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn)}(V128_vectype, AND_vvbinop, v128_1, v128_2) = [$iand_($vsize(V128_vectype), v128_1, v128_2)]
  ;; 3-numerics.watsup
  def $vvbinop_{v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn)}(V128_vectype, ANDNOT_vvbinop, v128_1, v128_2) = [$iandnot_($vsize(V128_vectype), v128_1, v128_2)]
  ;; 3-numerics.watsup
  def $vvbinop_{v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn)}(V128_vectype, OR_vvbinop, v128_1, v128_2) = [$ior_($vsize(V128_vectype), v128_1, v128_2)]
  ;; 3-numerics.watsup
  def $vvbinop_{v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn)}(V128_vectype, XOR_vvbinop, v128_1, v128_2) = [$ixor_($vsize(V128_vectype), v128_1, v128_2)]

;; 3-numerics.watsup
def $vvternop_(vectype : vectype, vvternop : vvternop, vec_ : vec_(vectype), vec_ : vec_(vectype), vec_ : vec_(vectype)) : vec_(vectype)*
  ;; 3-numerics.watsup
  def $vvternop_{v128_1 : vec_(V128_Vnn), v128_2 : vec_(V128_Vnn), v128_3 : vec_(V128_Vnn)}(V128_vectype, BITSELECT_vvternop, v128_1, v128_2, v128_3) = [$ibitselect_($vsize(V128_vectype), v128_1, v128_2, v128_3)]

;; 3-numerics.watsup
def $fvunop_(shape : shape, def $f_(N : N, fN : fN(N)) : fN(N)*, vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; 3-numerics.watsup
  def $fvunop_{Fnn : Fnn, M : M, def $f_(N : N, fN : fN(N)) : fN(N)*, vN_1 : vec_(V128_Vnn), `c**` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))**, `c_1*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $f_, vN_1) = $invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})*{`c*` <- `c**`}
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_((Fnn : Fnn <: lanetype)), $f_($sizenn((Fnn : Fnn <: numtype)), c_1)*{c_1 <- `c_1*`}))

;; 3-numerics.watsup
def $ivunop_(shape : shape, def $f_(N : N, iN : iN(N)) : iN(N), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; 3-numerics.watsup
  def $ivunop_{Jnn : Jnn, M : M, def $f_(N : N, iN : iN(N)) : iN(N), vN_1 : vec_(V128_Vnn), `c*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, vN_1) = [$invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})]
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c*{c <- `c*`} = $f_($lsizenn((Jnn : Jnn <: lanetype)), c_1)*{c_1 <- `c_1*`})

;; 3-numerics.watsup
def $vunop_(shape : shape, vunop_ : vunop_(shape), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; 3-numerics.watsup
  def $vunop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), ABS_vunop_, vN_1) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fabs_, vN_1)
  ;; 3-numerics.watsup
  def $vunop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), NEG_vunop_, vN_1) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fneg_, vN_1)
  ;; 3-numerics.watsup
  def $vunop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), SQRT_vunop_, vN_1) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fsqrt_, vN_1)
  ;; 3-numerics.watsup
  def $vunop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), CEIL_vunop_, vN_1) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fceil_, vN_1)
  ;; 3-numerics.watsup
  def $vunop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), FLOOR_vunop_, vN_1) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $ffloor_, vN_1)
  ;; 3-numerics.watsup
  def $vunop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), TRUNC_vunop_, vN_1) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $ftrunc_, vN_1)
  ;; 3-numerics.watsup
  def $vunop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), NEAREST_vunop_, vN_1) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fnearest_, vN_1)
  ;; 3-numerics.watsup
  def $vunop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), ABS_vunop_, vN_1) = $ivunop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $iabs_, vN_1)
  ;; 3-numerics.watsup
  def $vunop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), NEG_vunop_, vN_1) = $ivunop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ineg_, vN_1)
  ;; 3-numerics.watsup
  def $vunop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), POPCNT_vunop_, vN_1) = $ivunop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ipopcnt_, vN_1)

;; 3-numerics.watsup
def $fvbinop_(shape : shape, def $f_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; 3-numerics.watsup
  def $fvbinop_{Fnn : Fnn, M : M, def $f_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn), `c**` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))**, `c_1*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $f_, vN_1, vN_2) = $invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})*{`c*` <- `c**`}
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), vN_2))
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_((Fnn : Fnn <: lanetype)), $f_($sizenn((Fnn : Fnn <: numtype)), c_1, c_2)*{c_1 <- `c_1*`, c_2 <- `c_2*`}))

;; 3-numerics.watsup
def $ivbinop_(shape : shape, def $f_(N : N, iN : iN(N), iN : iN(N)) : iN(N), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; 3-numerics.watsup
  def $ivbinop_{Jnn : Jnn, M : M, def $f_(N : N, iN : iN(N), iN : iN(N)) : iN(N), vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn), `c*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, vN_1, vN_2) = [$invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})]
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_2))
    -- if (c*{c <- `c*`} = $f_($lsizenn((Jnn : Jnn <: lanetype)), c_1, c_2)*{c_1 <- `c_1*`, c_2 <- `c_2*`})

;; 3-numerics.watsup
def $ivbinopsx_(shape : shape, def $f_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N), sx : sx, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; 3-numerics.watsup
  def $ivbinopsx_{Jnn : Jnn, M : M, def $f_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N), sx : sx, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn), `c*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, sx, vN_1, vN_2) = [$invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})]
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_2))
    -- if (c*{c <- `c*`} = $f_($lsizenn((Jnn : Jnn <: lanetype)), sx, c_1, c_2)*{c_1 <- `c_1*`, c_2 <- `c_2*`})

;; 3-numerics.watsup
def $ivbinopsxnd_(shape : shape, def $f_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)*, sx : sx, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; 3-numerics.watsup
  def $ivbinopsxnd_{Jnn : Jnn, M : M, def $f_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)*, sx : sx, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn), `c**` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))**, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, sx, vN_1, vN_2) = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})*{`c*` <- `c**`}
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_2))
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_((Jnn : Jnn <: lanetype)), $f_($lsizenn((Jnn : Jnn <: lanetype)), sx, c_1, c_2)*{c_1 <- `c_1*`, c_2 <- `c_2*`}))

;; 3-numerics.watsup
def $vbinop_(shape : shape, vbinop_ : vbinop_(shape), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; 3-numerics.watsup
  def $vbinop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), ADD_vbinop_, vN_1, vN_2) = $ivbinop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $iadd_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), SUB_vbinop_, vN_1, vN_2) = $ivbinop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $isub_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), MUL_vbinop_, vN_1, vN_2) = $ivbinop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $imul_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Jnn : Jnn, M : M, sx : sx, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), ADD_SAT_vbinop_(sx), vN_1, vN_2) = $ivbinopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $iadd_sat_, sx, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Jnn : Jnn, M : M, sx : sx, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), SUB_SAT_vbinop_(sx), vN_1, vN_2) = $ivbinopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $isub_sat_, sx, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Jnn : Jnn, M : M, sx : sx, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), MIN_vbinop_(sx), vN_1, vN_2) = $ivbinopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $imin_, sx, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Jnn : Jnn, M : M, sx : sx, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), MAX_vbinop_(sx), vN_1, vN_2) = $ivbinopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $imax_, sx, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), `AVGRU`_vbinop_, vN_1, vN_2) = $ivbinopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $iavgr_, U_sx, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), `Q15MULR_SATS`_vbinop_, vN_1, vN_2) = $ivbinopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $iq15mulr_sat_, S_sx, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), `RELAXED_Q15MULRS`_vbinop_, vN_1, vN_2) = $ivbinopsxnd_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $irelaxed_q15mulr_, S_sx, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), ADD_vbinop_, vN_1, vN_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fadd_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), SUB_vbinop_, vN_1, vN_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fsub_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), MUL_vbinop_, vN_1, vN_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fmul_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), DIV_vbinop_, vN_1, vN_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fdiv_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), MIN_vbinop_, vN_1, vN_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fmin_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), MAX_vbinop_, vN_1, vN_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fmax_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), PMIN_vbinop_, vN_1, vN_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fpmin_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), PMAX_vbinop_, vN_1, vN_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fpmax_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), RELAXED_MIN_vbinop_, vN_1, vN_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $frelaxed_min_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vbinop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), RELAXED_MAX_vbinop_, vN_1, vN_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $frelaxed_max_, vN_1, vN_2)

;; 3-numerics.watsup
def $fvternop_(shape : shape, def $f_(N : N, fN : fN(N), fN : fN(N), fN : fN(N)) : fN(N)*, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; 3-numerics.watsup
  def $fvternop_{Fnn : Fnn, M : M, def $f_(N : N, fN : fN(N), fN : fN(N), fN : fN(N)) : fN(N)*, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn), vN_3 : vec_(V128_Vnn), `c**` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))**, `c_1*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*, `c_3*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $f_, vN_1, vN_2, vN_3) = $invlanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})*{`c*` <- `c**`}
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), vN_2))
    -- if (c_3*{c_3 <- `c_3*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), vN_3))
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_((Fnn : Fnn <: lanetype)), $f_($sizenn((Fnn : Fnn <: numtype)), c_1, c_2, c_3)*{c_1 <- `c_1*`, c_2 <- `c_2*`, c_3 <- `c_3*`}))

;; 3-numerics.watsup
def $ivternopnd_(shape : shape, def $f_(N : N, iN : iN(N), iN : iN(N), iN : iN(N)) : iN(N)*, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; 3-numerics.watsup
  def $ivternopnd_{Jnn : Jnn, M : M, def $f_(N : N, iN : iN(N), iN : iN(N), iN : iN(N)) : iN(N)*, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn), vN_3 : vec_(V128_Vnn), `c**` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))**, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_3*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, vN_1, vN_2, vN_3) = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})*{`c*` <- `c**`}
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_2))
    -- if (c_3*{c_3 <- `c_3*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_3))
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_((Jnn : Jnn <: lanetype)), $f_($lsizenn((Jnn : Jnn <: lanetype)), c_1, c_2, c_3)*{c_1 <- `c_1*`, c_2 <- `c_2*`, c_3 <- `c_3*`}))

;; 3-numerics.watsup
def $vternop_(shape : shape, vternop_ : vternop_(shape), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; 3-numerics.watsup
  def $vternop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn), vN_3 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), RELAXED_LANESELECT_vternop_, vN_1, vN_2, vN_3) = $ivternopnd_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $irelaxed_laneselect_, vN_1, vN_2, vN_3)
  ;; 3-numerics.watsup
  def $vternop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn), vN_3 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), RELAXED_MADD_vternop_, vN_1, vN_2, vN_3) = $fvternop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $frelaxed_madd_, vN_1, vN_2, vN_3)
  ;; 3-numerics.watsup
  def $vternop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn), vN_3 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), RELAXED_NMADD_vternop_, vN_1, vN_2, vN_3) = $fvternop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $frelaxed_nmadd_, vN_1, vN_2, vN_3)

;; 3-numerics.watsup
def $ivtestop_(shape : shape, def $f_(N : N, iN : iN(N)) : u32, vec_ : vec_(V128_Vnn)) : u32
  ;; 3-numerics.watsup
  def $ivtestop_{Jnn : Jnn, M : M, def $f_(N : N, iN : iN(N)) : u32, vN_1 : vec_(V128_Vnn), `c*` : nat*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, vN_1) = `%`_u32($prod(c*{c <- `c*`}))
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c*{c <- `c*`} = $f_($lsizenn((Jnn : Jnn <: lanetype)), c_1)!`%`_u32.0*{c_1 <- `c_1*`})

;; 3-numerics.watsup
def $vtestop_(shape : shape, vtestop_ : vtestop_(shape), vec_ : vec_(V128_Vnn)) : u32
  ;; 3-numerics.watsup
  def $vtestop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), ALL_TRUE_vtestop_, vN_1) = $ivtestop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $inez_, vN_1)

;; 3-numerics.watsup
def $fvrelop_(shape : shape, def $f_(N : N, fN : fN(N), fN : fN(N)) : u32, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $fvrelop_{Fnn : Fnn, M : M, def $f_(N : N, fN : fN(N), fN : fN(N)) : u32, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn), Inn : Inn, `c*` : lane_($lanetype(`%X%`_shape((Inn : Inn <: lanetype), `%`_dim(M))))*, `c_1*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $f_, vN_1, vN_2) = $invlanes_(`%X%`_shape((Inn : Inn <: lanetype), `%`_dim(M)), c*{c <- `c*`})
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), vN_2))
    -- if (c*{c <- `c*`} = `%`_lane_($extend__(1, $sizenn((Fnn : Fnn <: numtype)), S_sx, `%`_iN($f_($sizenn((Fnn : Fnn <: numtype)), c_1, c_2)!`%`_u32.0))!`%`_iN.0)*{c_1 <- `c_1*`, c_2 <- `c_2*`})
    -- if ($size((Inn : Inn <: numtype)) = $size((Fnn : Fnn <: numtype)))

;; 3-numerics.watsup
def $ivrelop_(shape : shape, def $f_(N : N, iN : iN(N), iN : iN(N)) : u32, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $ivrelop_{Jnn : Jnn, M : M, def $f_(N : N, iN : iN(N), iN : iN(N)) : u32, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn), `c*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, vN_1, vN_2) = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_2))
    -- if (c*{c <- `c*`} = $extend__(1, $lsizenn((Jnn : Jnn <: lanetype)), S_sx, `%`_iN($f_($lsizenn((Jnn : Jnn <: lanetype)), c_1, c_2)!`%`_u32.0))*{c_1 <- `c_1*`, c_2 <- `c_2*`})

;; 3-numerics.watsup
def $ivrelopsx_(shape : shape, def $f_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32, sx : sx, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $ivrelopsx_{Jnn : Jnn, M : M, def $f_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32, sx : sx, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn), `c*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, sx, vN_1, vN_2) = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), vN_2))
    -- if (c*{c <- `c*`} = $extend__(1, $lsizenn((Jnn : Jnn <: lanetype)), S_sx, `%`_iN($f_($lsizenn((Jnn : Jnn <: lanetype)), sx, c_1, c_2)!`%`_u32.0))*{c_1 <- `c_1*`, c_2 <- `c_2*`})

;; 3-numerics.watsup
def $vrelop_(shape : shape, vrelop_ : vrelop_(shape), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $vrelop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), EQ_vrelop_, vN_1, vN_2) = $ivrelop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ieq_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vrelop_{Jnn : Jnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), NE_vrelop_, vN_1, vN_2) = $ivrelop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ine_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vrelop_{Jnn : Jnn, M : M, sx : sx, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), LT_vrelop_(sx), vN_1, vN_2) = $ivrelopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ilt_, sx, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vrelop_{Jnn : Jnn, M : M, sx : sx, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), GT_vrelop_(sx), vN_1, vN_2) = $ivrelopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $igt_, sx, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vrelop_{Jnn : Jnn, M : M, sx : sx, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), LE_vrelop_(sx), vN_1, vN_2) = $ivrelopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ile_, sx, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vrelop_{Jnn : Jnn, M : M, sx : sx, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), GE_vrelop_(sx), vN_1, vN_2) = $ivrelopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ige_, sx, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vrelop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), EQ_vrelop_, vN_1, vN_2) = $fvrelop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $feq_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vrelop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), NE_vrelop_, vN_1, vN_2) = $fvrelop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fne_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vrelop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), LT_vrelop_, vN_1, vN_2) = $fvrelop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $flt_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vrelop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), GT_vrelop_, vN_1, vN_2) = $fvrelop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fgt_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vrelop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), LE_vrelop_, vN_1, vN_2) = $fvrelop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fle_, vN_1, vN_2)
  ;; 3-numerics.watsup
  def $vrelop_{Fnn : Fnn, M : M, vN_1 : vec_(V128_Vnn), vN_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), GE_vrelop_, vN_1, vN_2) = $fvrelop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fge_, vN_1, vN_2)

;; 3-numerics.watsup
def $vcvtop__(shape_1 : shape, shape_2 : shape, vcvtop__ : vcvtop__(shape_1, shape_2), lane_ : lane_($lanetype(shape_1))) : lane_($lanetype(shape_2))*
  ;; 3-numerics.watsup
  def $vcvtop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, sx : sx, iN_1 : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)))), iN_2 : lane_($lanetype(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))))}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), EXTEND_vcvtop__(sx), iN_1) = [iN_2]
    -- if (iN_2 = $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), sx, iN_1))
  ;; 3-numerics.watsup
  def $vcvtop__{Jnn_1 : Jnn, M_1 : M, Fnn_2 : Fnn, M_2 : M, sx : sx, iN_1 : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)))), fN_2 : lane_($lanetype(`%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2))))}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), CONVERT_vcvtop__(sx), iN_1) = [fN_2]
    -- if (fN_2 = $convert__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Fnn_2 : Fnn <: lanetype)), sx, iN_1))
  ;; 3-numerics.watsup
  def $vcvtop__{Fnn_1 : Fnn, M_1 : M, Inn_2 : Inn, M_2 : M, sx : sx, fN_1 : lane_($lanetype(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)))), `iN_2?` : lane_((Inn_2 : Inn <: lanetype))?}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(M_2)), TRUNC_SAT_vcvtop__(sx), fN_1) = $list_(syntax lane_((Inn_2 : Inn <: lanetype)), iN_2?{iN_2 <- `iN_2?`})
    -- if (iN_2?{iN_2 <- `iN_2?`} = $trunc_sat__($lsizenn1((Fnn_1 : Fnn <: lanetype)), $lsizenn2((Inn_2 : Inn <: lanetype)), sx, fN_1))
  ;; 3-numerics.watsup
  def $vcvtop__{Fnn_1 : Fnn, M_1 : M, Inn_2 : Inn, M_2 : M, sx : sx, fN_1 : lane_($lanetype(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)))), `iN_2?` : lane_((Inn_2 : Inn <: lanetype))?}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Inn_2 : Inn <: lanetype), `%`_dim(M_2)), RELAXED_TRUNC_vcvtop__(sx), fN_1) = $list_(syntax lane_((Inn_2 : Inn <: lanetype)), iN_2?{iN_2 <- `iN_2?`})
    -- if (iN_2?{iN_2 <- `iN_2?`} = $relaxed_trunc__($lsizenn1((Fnn_1 : Fnn <: lanetype)), $lsizenn2((Inn_2 : Inn <: lanetype)), sx, fN_1))
  ;; 3-numerics.watsup
  def $vcvtop__{Fnn_1 : Fnn, M_1 : M, Fnn_2 : Fnn, M_2 : M, fN_1 : lane_($lanetype(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)))), `fN_2*` : lane_($lanetype(`%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2))))*}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), DEMOTE_vcvtop__, fN_1) = fN_2*{fN_2 <- `fN_2*`}
    -- if (fN_2*{fN_2 <- `fN_2*`} = $demote__($lsizenn1((Fnn_1 : Fnn <: lanetype)), $lsizenn2((Fnn_2 : Fnn <: lanetype)), fN_1))
  ;; 3-numerics.watsup
  def $vcvtop__{Fnn_1 : Fnn, M_1 : M, Fnn_2 : Fnn, M_2 : M, fN_1 : lane_($lanetype(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)))), `fN_2*` : lane_($lanetype(`%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2))))*}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), PROMOTE_vcvtop__, fN_1) = fN_2*{fN_2 <- `fN_2*`}
    -- if (fN_2*{fN_2 <- `fN_2*`} = $promote__($lsizenn1((Fnn_1 : Fnn <: lanetype)), $lsizenn2((Fnn_2 : Fnn <: lanetype)), fN_1))

;; 3-numerics.watsup
def $vextunop__(ishape_1 : ishape, ishape_2 : ishape, vextunop__ : vextunop__(ishape_1, ishape_2), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $vextunop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, sx : sx, c_1 : vec_(V128_Vnn), c : vec_(V128_Vnn), `cj_1*` : iN($lsize((Jnn_2 : Jnn <: lanetype)))*, `cj_2*` : iN($lsize((Jnn_2 : Jnn <: lanetype)))*, `ci*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*}(`%X%`_ishape(Jnn_1, `%`_dim(M_1)), `%X%`_ishape(Jnn_2, `%`_dim(M_2)), EXTADD_PAIRWISE_vextunop__(sx), c_1) = c
    -- if (ci*{ci <- `ci*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), c_1))
    -- if ($concat_(syntax iN($lsizenn2((Jnn_2 : Jnn <: lanetype))), [cj_1 cj_2]*{cj_1 <- `cj_1*`, cj_2 <- `cj_2*`}) = $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), sx, ci)*{ci <- `ci*`})
    -- if (c = $invlanes_(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), $iadd_($lsizenn2((Jnn_2 : Jnn <: lanetype)), cj_1, cj_2)*{cj_1 <- `cj_1*`, cj_2 <- `cj_2*`}))

;; 3-numerics.watsup
def $vextbinop__(ishape_1 : ishape, ishape_2 : ishape, vextbinop__ : vextbinop__(ishape_1, ishape_2), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $vextbinop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, sx : sx, half : half__(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))), c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c : vec_(V128_Vnn), `ci_1*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `ci_2*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*}(`%X%`_ishape(Jnn_1, `%`_dim(M_1)), `%X%`_ishape(Jnn_2, `%`_dim(M_2)), EXTMUL_vextbinop__(sx, half), c_1, c_2) = c
    -- if (ci_1*{ci_1 <- `ci_1*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), c_1)[$half__(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), half, 0, M_2) : M_2])
    -- if (ci_2*{ci_2 <- `ci_2*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), c_2)[$half__(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), half, 0, M_2) : M_2])
    -- if (c = $invlanes_(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), $imul_($lsizenn2((Jnn_2 : Jnn <: lanetype)), $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), sx, ci_1), $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), sx, ci_2))*{ci_1 <- `ci_1*`, ci_2 <- `ci_2*`}))
  ;; 3-numerics.watsup
  def $vextbinop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c : vec_(V128_Vnn), `cj_1*` : iN($lsize((Jnn_2 : Jnn <: lanetype)))*, `cj_2*` : iN($lsize((Jnn_2 : Jnn <: lanetype)))*, `ci_1*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `ci_2*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `ci'_1*` : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))*, `ci'_2*` : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))*}(`%X%`_ishape(Jnn_1, `%`_dim(M_1)), `%X%`_ishape(Jnn_2, `%`_dim(M_2)), `DOTS`_vextbinop__, c_1, c_2) = c
    -- if (ci_1*{ci_1 <- `ci_1*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), c_1))
    -- if (ci_2*{ci_2 <- `ci_2*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), c_2))
    -- if (ci'_1*{ci'_1 <- `ci'_1*`} = $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), S_sx, ci_1)*{ci_1 <- `ci_1*`})
    -- if (ci'_2*{ci'_2 <- `ci'_2*`} = $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), S_sx, ci_2)*{ci_2 <- `ci_2*`})
    -- if ($concat_(syntax iN($lsizenn2((Jnn_2 : Jnn <: lanetype))), [cj_1 cj_2]*{cj_1 <- `cj_1*`, cj_2 <- `cj_2*`}) = $imul_($lsizenn2((Jnn_2 : Jnn <: lanetype)), ci'_1, ci'_2)*{ci'_1 <- `ci'_1*`, ci'_2 <- `ci'_2*`})
    -- if (c = $invlanes_(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), $iadd_($lsizenn2((Jnn_2 : Jnn <: lanetype)), cj_1, cj_2)*{cj_1 <- `cj_1*`, cj_2 <- `cj_2*`}))
  ;; 3-numerics.watsup
  def $vextbinop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c : vec_(V128_Vnn), `cj_1*` : iN($lsize((Jnn_2 : Jnn <: lanetype)))*, `cj_2*` : iN($lsize((Jnn_2 : Jnn <: lanetype)))*, `ci_1*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `ci_2*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `ci'_1*` : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))*, `ci'_2*` : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))*}(`%X%`_ishape(Jnn_1, `%`_dim(M_1)), `%X%`_ishape(Jnn_2, `%`_dim(M_2)), `RELAXED_DOTS`_vextbinop__, c_1, c_2) = c
    -- if (ci_1*{ci_1 <- `ci_1*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), c_1))
    -- if (ci_2*{ci_2 <- `ci_2*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), c_2))
    -- if (ci'_1*{ci'_1 <- `ci'_1*`} = $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), S_sx, ci_1)*{ci_1 <- `ci_1*`})
    -- if (ci'_2*{ci'_2 <- `ci'_2*`} = $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), $relaxed2($R_idot, syntax sx, S_sx, U_sx), ci_2)*{ci_2 <- `ci_2*`})
    -- if ($concat_(syntax iN($lsizenn2((Jnn_2 : Jnn <: lanetype))), [cj_1 cj_2]*{cj_1 <- `cj_1*`, cj_2 <- `cj_2*`}) = $imul_($lsizenn2((Jnn_2 : Jnn <: lanetype)), ci'_1, ci'_2)*{ci'_1 <- `ci'_1*`, ci'_2 <- `ci'_2*`})
    -- if (c = $invlanes_(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), $iadd_sat_($lsizenn2((Jnn_2 : Jnn <: lanetype)), S_sx, cj_1, cj_2)*{cj_1 <- `cj_1*`, cj_2 <- `cj_2*`}))

;; 3-numerics.watsup
def $vextternop__(ishape_1 : ishape, ishape_2 : ishape, vextternop__ : vextternop__(ishape_1, ishape_2), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; 3-numerics.watsup
  def $vextternop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c_3 : vec_(V128_Vnn), c : vec_(V128_Vnn), `cj_1*` : iN($lsize((Jnn_2 : Jnn <: lanetype)))*, `cj_2*` : iN($lsize((Jnn_2 : Jnn <: lanetype)))*, `ci_1*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `ci_2*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `ci_3*` : lane_($lanetype(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))))*, Jnn : Jnn, `ci'_1*` : iN($lsizenn((Jnn : Jnn <: lanetype)))*, `ci'_2*` : iN($lsizenn((Jnn : Jnn <: lanetype)))*, `ck_1*` : iN($lsizenn((Jnn : Jnn <: lanetype)))*, `ck_2*` : iN($lsizenn((Jnn : Jnn <: lanetype)))*, `ck'_1*` : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))*, `ck'_2*` : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))*, `ck*` : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))*}(`%X%`_ishape(Jnn_1, `%`_dim(M_1)), `%X%`_ishape(Jnn_2, `%`_dim(M_2)), `RELAXED_DOT_ADDS`_vextternop__, c_1, c_2, c_3) = c
    -- if (ci_1*{ci_1 <- `ci_1*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), c_1))
    -- if (ci_2*{ci_2 <- `ci_2*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), c_2))
    -- if (ci_3*{ci_3 <- `ci_3*`} = $lanes_(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), c_3))
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) = (2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))))
    -- if (ci'_1*{ci'_1 <- `ci'_1*`} = $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn((Jnn : Jnn <: lanetype)), S_sx, ci_1)*{ci_1 <- `ci_1*`})
    -- if (ci'_2*{ci'_2 <- `ci'_2*`} = $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn((Jnn : Jnn <: lanetype)), $relaxed2($R_idot, syntax sx, S_sx, U_sx), ci_2)*{ci_2 <- `ci_2*`})
    -- if ($concat_(syntax iN($lsizenn((Jnn : Jnn <: lanetype))), [`%`_uN(cj_1!`%`_iN.0) `%`_uN(cj_2!`%`_iN.0)]*{cj_1 <- `cj_1*`, cj_2 <- `cj_2*`}) = $imul_($lsizenn((Jnn : Jnn <: lanetype)), ci'_1, ci'_2)*{ci'_1 <- `ci'_1*`, ci'_2 <- `ci'_2*`})
    -- if ($concat_(syntax iN($lsizenn((Jnn : Jnn <: lanetype))), [ck_1 ck_2]*{ck_1 <- `ck_1*`, ck_2 <- `ck_2*`}) = $iadd_sat_($lsizenn((Jnn : Jnn <: lanetype)), S_sx, `%`_iN(cj_1!`%`_iN.0), `%`_iN(cj_2!`%`_iN.0))*{cj_1 <- `cj_1*`, cj_2 <- `cj_2*`})
    -- if (ck'_1*{ck'_1 <- `ck'_1*`} = $extend__($lsizenn((Jnn : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), S_sx, ck_1)*{ck_1 <- `ck_1*`})
    -- if (ck'_2*{ck'_2 <- `ck'_2*`} = $extend__($lsizenn((Jnn : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), S_sx, ck_2)*{ck_2 <- `ck_2*`})
    -- if (ck*{ck <- `ck*`} = $iadd_($lsizenn2((Jnn_2 : Jnn <: lanetype)), ck'_1, ck'_2)*{ck'_1 <- `ck'_1*`, ck'_2 <- `ck'_2*`})
    -- if (c = $invlanes_(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), $iadd_($lsizenn2((Jnn_2 : Jnn <: lanetype)), ck, ci_3)*{ci_3 <- `ci_3*`, ck <- `ck*`}))

;; 3-numerics.watsup
def $vshiftop_(ishape : ishape, vshiftop_ : vshiftop_(ishape), lane_ : lane_($lanetype((ishape : ishape <: shape))), u32 : u32) : lane_($lanetype((ishape : ishape <: shape)))
  ;; 3-numerics.watsup
  def $vshiftop_{Jnn : Jnn, M : M, lane : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)))), n : n}(`%X%`_ishape(Jnn, `%`_dim(M)), SHL_vshiftop_, lane, `%`_u32(n)) = $ishl_($lsizenn((Jnn : Jnn <: lanetype)), lane, `%`_u32(n))
  ;; 3-numerics.watsup
  def $vshiftop_{Jnn : Jnn, M : M, sx : sx, lane : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)))), n : n}(`%X%`_ishape(Jnn, `%`_dim(M)), SHR_vshiftop_(sx), lane, `%`_u32(n)) = $ishr_($lsizenn((Jnn : Jnn <: lanetype)), sx, lane, `%`_u32(n))

;; 3-numerics.watsup
def $fvtestop_(shape : shape, def $f_(N : N, fN : fN(N)) : u32, vec_ : vec_(V128_Vnn)) : u32
  ;; 3-numerics.watsup
  def $fvtestop_{Fnn : Fnn, M : M, def $f_(N : N, fN : fN(N)) : u32, vN_1 : vec_(V128_Vnn), `c*` : nat*, `c_1*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $f_, vN_1) = `%`_u32($prod(c*{c <- `c*`}))
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), vN_1))
    -- if (c*{c <- `c*`} = $f_($sizenn((Fnn : Fnn <: numtype)), c_1)!`%`_u32.0*{c_1 <- `c_1*`})

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
  | REF.EXN_ADDR{exnaddr : exnaddr}(exnaddr : exnaddr)
  | REF.HOST_ADDR{hostaddr : hostaddr}(hostaddr : hostaddr)
  | REF.EXTERN{addrref : addrref}(addrref : addrref)
  | REF.NULL{heaptype : heaptype}(heaptype : heaptype)

;; 4-runtime.watsup
syntax result =
  | _VALS{`val*` : val*}(val*{val <- `val*`} : val*)
  | `_EXN(REF.EXN_ADDR%)THROW_REF`{exnaddr : exnaddr}(exnaddr : exnaddr)
  | TRAP

;; 4-runtime.watsup
syntax hostfunc =
  | `...`

;; 4-runtime.watsup
syntax funccode =
  | FUNC{typeidx : typeidx, `local*` : local*, expr : expr}(typeidx : typeidx, local*{local <- `local*`} : local*, expr : expr)
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
  REFS{`ref*` : ref*} ref*
}

;; 4-runtime.watsup
syntax meminst =
{
  TYPE{memtype : memtype} memtype,
  BYTES{`byte*` : byte*} byte*
}

;; 4-runtime.watsup
syntax taginst =
{
  TYPE{tagtype : tagtype} tagtype
}

;; 4-runtime.watsup
syntax eleminst =
{
  TYPE{elemtype : elemtype} elemtype,
  REFS{`ref*` : ref*} ref*
}

;; 4-runtime.watsup
syntax datainst =
{
  BYTES{`byte*` : byte*} byte*
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
  | REF.EXN_ADDR{exnaddr : exnaddr}(exnaddr : exnaddr)
  | REF.HOST_ADDR{hostaddr : hostaddr}(hostaddr : hostaddr)
  | REF.EXTERN{addrref : addrref}(addrref : addrref)
  | PACK{packtype : packtype, iN : iN($psizenn(packtype))}(packtype : packtype, iN : iN($psizenn(packtype)))

;; 4-runtime.watsup
syntax structinst =
{
  TYPE{deftype : deftype} deftype,
  FIELDS{`fieldval*` : fieldval*} fieldval*
}

;; 4-runtime.watsup
syntax arrayinst =
{
  TYPE{deftype : deftype} deftype,
  FIELDS{`fieldval*` : fieldval*} fieldval*
}

;; 4-runtime.watsup
syntax exninst =
{
  TAG{tagaddr : tagaddr} tagaddr,
  FIELDS{`val*` : val*} val*
}

;; 4-runtime.watsup
syntax store =
{
  FUNCS{`funcinst*` : funcinst*} funcinst*,
  GLOBALS{`globalinst*` : globalinst*} globalinst*,
  TABLES{`tableinst*` : tableinst*} tableinst*,
  MEMS{`meminst*` : meminst*} meminst*,
  TAGS{`taginst*` : taginst*} taginst*,
  ELEMS{`eleminst*` : eleminst*} eleminst*,
  DATAS{`datainst*` : datainst*} datainst*,
  STRUCTS{`structinst*` : structinst*} structinst*,
  ARRAYS{`arrayinst*` : arrayinst*} arrayinst*,
  EXNS{`exninst*` : exninst*} exninst*
}

;; 4-runtime.watsup
syntax state =
  | `%;%`{store : store, frame : frame}(store : store, frame : frame)

;; 4-runtime.watsup
syntax config =
  | `%;%`{state : state, `instr*` : instr*}(state : state, instr*{instr <- `instr*`} : instr*)

;; 4-runtime.watsup
syntax evalctx =
  | `LABEL_%{%}`{n : n, `instr*` : instr*}(n : n, instr*{instr <- `instr*`} : instr*)
  | `FRAME_%{%}`{n : n, frame : frame}(n : n, frame : frame)
  | `HANDLER_%{%}`{n : n, `catch*` : catch*}(n : n, catch*{catch <- `catch*`} : catch*)

;; 5-runtime-aux.watsup
def $inst_valtype(moduleinst : moduleinst, valtype : valtype) : valtype
  ;; 5-runtime-aux.watsup
  def $inst_valtype{moduleinst : moduleinst, t : valtype, `dt*` : deftype*}(moduleinst, t) = $subst_all_valtype(t, (dt : deftype <: heaptype)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = moduleinst.TYPES_moduleinst)

;; 5-runtime-aux.watsup
def $inst_reftype(moduleinst : moduleinst, reftype : reftype) : reftype
  ;; 5-runtime-aux.watsup
  def $inst_reftype{moduleinst : moduleinst, rt : reftype, `dt*` : deftype*}(moduleinst, rt) = $subst_all_reftype(rt, (dt : deftype <: heaptype)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = moduleinst.TYPES_moduleinst)

;; 5-runtime-aux.watsup
def $inst_globaltype(moduleinst : moduleinst, globaltype : globaltype) : globaltype
  ;; 5-runtime-aux.watsup
  def $inst_globaltype{moduleinst : moduleinst, gt : globaltype, `dt*` : deftype*}(moduleinst, gt) = $subst_all_globaltype(gt, (dt : deftype <: heaptype)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = moduleinst.TYPES_moduleinst)

;; 5-runtime-aux.watsup
def $inst_tabletype(moduleinst : moduleinst, tabletype : tabletype) : tabletype
  ;; 5-runtime-aux.watsup
  def $inst_tabletype{moduleinst : moduleinst, tt : tabletype, `dt*` : deftype*}(moduleinst, tt) = $subst_all_tabletype(tt, (dt : deftype <: heaptype)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = moduleinst.TYPES_moduleinst)

;; 5-runtime-aux.watsup
def $inst_memtype(moduleinst : moduleinst, memtype : memtype) : memtype
  ;; 5-runtime-aux.watsup
  def $inst_memtype{moduleinst : moduleinst, mt : memtype, `dt*` : deftype*}(moduleinst, mt) = $subst_all_memtype(mt, (dt : deftype <: heaptype)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = moduleinst.TYPES_moduleinst)

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
def $packfield_(storagetype : storagetype, val : val) : fieldval
  ;; 5-runtime-aux.watsup
  def $packfield_{valtype : valtype, val : val}((valtype : valtype <: storagetype), val) = (val : val <: fieldval)
  ;; 5-runtime-aux.watsup
  def $packfield_{packtype : packtype, i : nat}((packtype : packtype <: storagetype), CONST_val(I32_numtype, `%`_num_(i))) = PACK_fieldval(packtype, $wrap__(32, $psize(packtype), `%`_iN(i)))

;; 5-runtime-aux.watsup
def $unpackfield_(storagetype : storagetype, sx?, fieldval : fieldval) : val
  ;; 5-runtime-aux.watsup
  def $unpackfield_{valtype : valtype, val : val}((valtype : valtype <: storagetype), ?(), (val : val <: fieldval)) = val
  ;; 5-runtime-aux.watsup
  def $unpackfield_{packtype : packtype, sx : sx, i : nat}((packtype : packtype <: storagetype), ?(sx), PACK_fieldval(packtype, `%`_iN(i))) = CONST_val(I32_numtype, $extend__($psize(packtype), 32, sx, `%`_iN(i)))

;; 5-runtime-aux.watsup
rec {

;; 5-runtime-aux.watsup:55.1-55.87
def $funcsxa(externaddr*) : funcaddr*
  ;; 5-runtime-aux.watsup:61.1-61.24
  def $funcsxa([]) = []
  ;; 5-runtime-aux.watsup:62.1-62.47
  def $funcsxa{fa : funcaddr, `xa*` : externaddr*}([FUNC_externaddr(fa)] ++ xa*{xa <- `xa*`}) = [fa] ++ $funcsxa(xa*{xa <- `xa*`})
  ;; 5-runtime-aux.watsup:63.1-63.59
  def $funcsxa{externaddr : externaddr, `xa*` : externaddr*}([externaddr] ++ xa*{xa <- `xa*`}) = $funcsxa(xa*{xa <- `xa*`})
    -- otherwise
}

;; 5-runtime-aux.watsup
rec {

;; 5-runtime-aux.watsup:56.1-56.89
def $globalsxa(externaddr*) : globaladdr*
  ;; 5-runtime-aux.watsup:65.1-65.26
  def $globalsxa([]) = []
  ;; 5-runtime-aux.watsup:66.1-66.53
  def $globalsxa{ga : globaladdr, `xa*` : externaddr*}([GLOBAL_externaddr(ga)] ++ xa*{xa <- `xa*`}) = [ga] ++ $globalsxa(xa*{xa <- `xa*`})
  ;; 5-runtime-aux.watsup:67.1-67.63
  def $globalsxa{externaddr : externaddr, `xa*` : externaddr*}([externaddr] ++ xa*{xa <- `xa*`}) = $globalsxa(xa*{xa <- `xa*`})
    -- otherwise
}

;; 5-runtime-aux.watsup
rec {

;; 5-runtime-aux.watsup:57.1-57.88
def $tablesxa(externaddr*) : tableaddr*
  ;; 5-runtime-aux.watsup:69.1-69.25
  def $tablesxa([]) = []
  ;; 5-runtime-aux.watsup:70.1-70.50
  def $tablesxa{ta : tableaddr, `xa*` : externaddr*}([TABLE_externaddr(ta)] ++ xa*{xa <- `xa*`}) = [ta] ++ $tablesxa(xa*{xa <- `xa*`})
  ;; 5-runtime-aux.watsup:71.1-71.61
  def $tablesxa{externaddr : externaddr, `xa*` : externaddr*}([externaddr] ++ xa*{xa <- `xa*`}) = $tablesxa(xa*{xa <- `xa*`})
    -- otherwise
}

;; 5-runtime-aux.watsup
rec {

;; 5-runtime-aux.watsup:58.1-58.86
def $memsxa(externaddr*) : memaddr*
  ;; 5-runtime-aux.watsup:73.1-73.23
  def $memsxa([]) = []
  ;; 5-runtime-aux.watsup:74.1-74.44
  def $memsxa{ma : memaddr, `xa*` : externaddr*}([MEM_externaddr(ma)] ++ xa*{xa <- `xa*`}) = [ma] ++ $memsxa(xa*{xa <- `xa*`})
  ;; 5-runtime-aux.watsup:75.1-75.57
  def $memsxa{externaddr : externaddr, `xa*` : externaddr*}([externaddr] ++ xa*{xa <- `xa*`}) = $memsxa(xa*{xa <- `xa*`})
    -- otherwise
}

;; 5-runtime-aux.watsup
rec {

;; 5-runtime-aux.watsup:59.1-59.86
def $tagsxa(externaddr*) : tagaddr*
  ;; 5-runtime-aux.watsup:77.1-77.23
  def $tagsxa([]) = []
  ;; 5-runtime-aux.watsup:78.1-78.44
  def $tagsxa{ha : tagaddr, `xa*` : externaddr*}([TAG_externaddr(ha)] ++ xa*{xa <- `xa*`}) = [ha] ++ $tagsxa(xa*{xa <- `xa*`})
  ;; 5-runtime-aux.watsup:79.1-79.57
  def $tagsxa{externaddr : externaddr, `xa*` : externaddr*}([externaddr] ++ xa*{xa <- `xa*`}) = $tagsxa(xa*{xa <- `xa*`})
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
def $tagaddr(state : state) : tagaddr*
  ;; 5-runtime-aux.watsup
  def $tagaddr{s : store, f : frame}(`%;%`_state(s, f)) = f.MODULE_frame.TAGS_moduleinst

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
def $taginst(state : state) : taginst*
  ;; 5-runtime-aux.watsup
  def $taginst{s : store, f : frame}(`%;%`_state(s, f)) = s.TAGS_store

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
def $exninst(state : state) : exninst*
  ;; 5-runtime-aux.watsup
  def $exninst{s : store, f : frame}(`%;%`_state(s, f)) = s.EXNS_store

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
def $tag(state : state, tagidx : tagidx) : taginst
  ;; 5-runtime-aux.watsup
  def $tag{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.TAGS_store[f.MODULE_frame.TAGS_moduleinst[x!`%`_idx.0]]

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
  def $with_mem{s : store, f : frame, x : idx, i : nat, j : nat, `b*` : byte*}(`%;%`_state(s, f), x, i, j, b*{b <- `b*`}) = `%;%`_state(s[MEMS_store[f.MODULE_frame.MEMS_moduleinst[x!`%`_idx.0]].BYTES_meminst[i : j] = b*{b <- `b*`}], f)

;; 5-runtime-aux.watsup
def $with_meminst(state : state, memidx : memidx, meminst : meminst) : state
  ;; 5-runtime-aux.watsup
  def $with_meminst{s : store, f : frame, x : idx, mi : meminst}(`%;%`_state(s, f), x, mi) = `%;%`_state(s[MEMS_store[f.MODULE_frame.MEMS_moduleinst[x!`%`_idx.0]] = mi], f)

;; 5-runtime-aux.watsup
def $with_elem(state : state, elemidx : elemidx, ref*) : state
  ;; 5-runtime-aux.watsup
  def $with_elem{s : store, f : frame, x : idx, `r*` : ref*}(`%;%`_state(s, f), x, r*{r <- `r*`}) = `%;%`_state(s[ELEMS_store[f.MODULE_frame.ELEMS_moduleinst[x!`%`_idx.0]].REFS_eleminst = r*{r <- `r*`}], f)

;; 5-runtime-aux.watsup
def $with_data(state : state, dataidx : dataidx, byte*) : state
  ;; 5-runtime-aux.watsup
  def $with_data{s : store, f : frame, x : idx, `b*` : byte*}(`%;%`_state(s, f), x, b*{b <- `b*`}) = `%;%`_state(s[DATAS_store[f.MODULE_frame.DATAS_moduleinst[x!`%`_idx.0]].BYTES_datainst = b*{b <- `b*`}], f)

;; 5-runtime-aux.watsup
def $with_struct(state : state, structaddr : structaddr, nat : nat, fieldval : fieldval) : state
  ;; 5-runtime-aux.watsup
  def $with_struct{s : store, f : frame, a : addr, i : nat, fv : fieldval}(`%;%`_state(s, f), a, i, fv) = `%;%`_state(s[STRUCTS_store[a].FIELDS_structinst[i] = fv], f)

;; 5-runtime-aux.watsup
def $with_array(state : state, arrayaddr : arrayaddr, nat : nat, fieldval : fieldval) : state
  ;; 5-runtime-aux.watsup
  def $with_array{s : store, f : frame, a : addr, i : nat, fv : fieldval}(`%;%`_state(s, f), a, i, fv) = `%;%`_state(s[ARRAYS_store[a].FIELDS_arrayinst[i] = fv], f)

;; 5-runtime-aux.watsup
def $add_structinst(state : state, structinst*) : state
  ;; 5-runtime-aux.watsup
  def $add_structinst{s : store, f : frame, `si*` : structinst*}(`%;%`_state(s, f), si*{si <- `si*`}) = `%;%`_state(s[STRUCTS_store =++ si*{si <- `si*`}], f)

;; 5-runtime-aux.watsup
def $add_arrayinst(state : state, arrayinst*) : state
  ;; 5-runtime-aux.watsup
  def $add_arrayinst{s : store, f : frame, `ai*` : arrayinst*}(`%;%`_state(s, f), ai*{ai <- `ai*`}) = `%;%`_state(s[ARRAYS_store =++ ai*{ai <- `ai*`}], f)

;; 5-runtime-aux.watsup
def $add_exninst(state : state, exninst*) : state
  ;; 5-runtime-aux.watsup
  def $add_exninst{s : store, f : frame, `exn*` : exninst*}(`%;%`_state(s, f), exn*{exn <- `exn*`}) = `%;%`_state(s[EXNS_store =++ exn*{exn <- `exn*`}], f)

;; 5-runtime-aux.watsup
def $growtable(tableinst : tableinst, nat : nat, ref : ref) : tableinst
  ;; 5-runtime-aux.watsup
  def $growtable{tableinst : tableinst, n : n, r : ref, tableinst' : tableinst, i : nat, j : nat, rt : reftype, `r'*` : ref*, i' : nat}(tableinst, n, r) = tableinst'
    -- if (tableinst = {TYPE `%%`_tabletype(`[%..%]`_limits(`%`_u32(i), `%`_u32(j)), rt), REFS r'*{r' <- `r'*`}})
    -- if (tableinst' = {TYPE `%%`_tabletype(`[%..%]`_limits(`%`_u32(i'), `%`_u32(j)), rt), REFS r'*{r' <- `r'*`} ++ r^n{}})
    -- if ((i' = (|r'*{r' <- `r'*`}| + n)) /\ ((|r'*{r' <- `r'*`}| + n) <= j))

;; 5-runtime-aux.watsup
def $growmem(meminst : meminst, nat : nat) : meminst
  ;; 5-runtime-aux.watsup
  def $growmem{meminst : meminst, n : n, meminst' : meminst, i : nat, j : nat, `b*` : byte*, i' : nat}(meminst, n) = meminst'
    -- if (meminst = {TYPE `%PAGE`_memtype(`[%..%]`_limits(`%`_u32(i), `%`_u32(j))), BYTES b*{b <- `b*`}})
    -- if (meminst' = {TYPE `%PAGE`_memtype(`[%..%]`_limits(`%`_u32(i'), `%`_u32(j))), BYTES b*{b <- `b*`} ++ `%`_byte(0)^(n * (64 * $Ki)){}})
    -- if ((i' = ((|b*{b <- `b*`}| / (64 * $Ki)) + n)) /\ (((|b*{b <- `b*`}| / (64 * $Ki)) + n) <= j))

;; 6-typing.watsup
syntax init =
  | SET
  | UNSET

;; 6-typing.watsup
syntax localtype =
  | `%%`{init : init, valtype : valtype}(init : init, valtype : valtype)

;; 6-typing.watsup
syntax instrtype =
  | `%->_%%`{resulttype : resulttype, `localidx*` : localidx*}(resulttype : resulttype, localidx*{localidx <- `localidx*`} : localidx*, resulttype)

;; 6-typing.watsup
syntax context =
{
  TYPES{`deftype*` : deftype*} deftype*,
  RECS{`subtype*` : subtype*} subtype*,
  FUNCS{`deftype*` : deftype*} deftype*,
  GLOBALS{`globaltype*` : globaltype*} globaltype*,
  TABLES{`tabletype*` : tabletype*} tabletype*,
  MEMS{`memtype*` : memtype*} memtype*,
  TAGS{`tagtype*` : tagtype*} tagtype*,
  ELEMS{`elemtype*` : elemtype*} elemtype*,
  DATAS{`datatype*` : datatype*} datatype*,
  LOCALS{`localtype*` : localtype*} localtype*,
  LABELS{`resulttype*` : resulttype*} resulttype*,
  RETURN{`resulttype?` : resulttype?} resulttype?,
  REFS{`funcidx*` : funcidx*} funcidx*
}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:37.1-37.86
def $with_locals(context : context, localidx*, localtype*) : context
  ;; 6-typing.watsup:39.1-39.34
  def $with_locals{C : context}(C, [], []) = C
  ;; 6-typing.watsup:40.1-40.90
  def $with_locals{C : context, x_1 : idx, `x*` : idx*, lct_1 : localtype, `lct*` : localtype*}(C, [x_1] ++ x*{x <- `x*`}, [lct_1] ++ lct*{lct <- `lct*`}) = $with_locals(C[LOCALS_context[x_1!`%`_idx.0] = lct_1], x*{x <- `x*`}, lct*{lct <- `lct*`})
}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:46.1-46.94
def $clos_deftypes(deftype*) : deftype*
  ;; 6-typing.watsup:53.1-53.30
  def $clos_deftypes([]) = []
  ;; 6-typing.watsup:54.1-54.101
  def $clos_deftypes{`dt*` : deftype*, dt_n : deftype, `dt'*` : deftype*}(dt*{dt <- `dt*`} ++ [dt_n]) = dt'*{dt' <- `dt'*`} ++ [$subst_all_deftype(dt_n, (dt' : deftype <: heaptype)*{dt' <- `dt'*`})]
    -- if (dt'*{dt' <- `dt'*`} = $clos_deftypes(dt*{dt <- `dt*`}))
}

;; 6-typing.watsup
def $clos_valtype(context : context, valtype : valtype) : valtype
  ;; 6-typing.watsup
  def $clos_valtype{C : context, t : valtype, `dt*` : deftype*}(C, t) = $subst_all_valtype(t, (dt : deftype <: heaptype)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = $clos_deftypes(C.TYPES_context))

;; 6-typing.watsup
def $clos_deftype(context : context, deftype : deftype) : deftype
  ;; 6-typing.watsup
  def $clos_deftype{C : context, dt : deftype, `dt'*` : deftype*}(C, dt) = $subst_all_deftype(dt, (dt' : deftype <: heaptype)*{dt' <- `dt'*`})
    -- if (dt'*{dt' <- `dt'*`} = $clos_deftypes(C.TYPES_context))

;; 6-typing.watsup
def $clos_moduletype(context : context, moduletype : moduletype) : moduletype
  ;; 6-typing.watsup
  def $clos_moduletype{C : context, mmt : moduletype, `dt*` : deftype*}(C, mmt) = $subst_all_moduletype(mmt, (dt : deftype <: heaptype)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = $clos_deftypes(C.TYPES_context))

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
  rule _{C : context, `t*` : valtype*}:
    `%|-%:OK`(C, `%`_resulttype(t*{t <- `t*`}))
    -- (Valtype_ok: `%|-%:OK`(C, t))*{t <- `t*`}

;; 6-typing.watsup
relation Instrtype_ok: `%|-%:OK`(context, instrtype)
  ;; 6-typing.watsup
  rule _{C : context, `t_1*` : valtype*, `x*` : idx*, `t_2*` : valtype*, `lct*` : localtype*}:
    `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x*{x <- `x*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t_1*{t_1 <- `t_1*`}))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t_2*{t_2 <- `t_2*`}))
    -- (if (C.LOCALS_context[x!`%`_idx.0] = lct))*{lct <- `lct*`, x <- `x*`}

;; 6-typing.watsup
syntax oktypeidx =
  | OK{typeidx : typeidx}(typeidx : typeidx)

;; 6-typing.watsup
syntax oktypeidxnat =
  | OK{typeidx : typeidx, nat : nat}(typeidx : typeidx, nat : nat)

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
  rule _{C : context, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:OK`(C, `%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t_1*{t_1 <- `t_1*`}))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t_2*{t_2 <- `t_2*`}))

;; 6-typing.watsup
relation Comptype_ok: `%|-%:OK`(context, comptype)
  ;; 6-typing.watsup
  rule struct{C : context, `fieldtype*` : fieldtype*}:
    `%|-%:OK`(C, STRUCT_comptype(`%`_structtype(fieldtype*{fieldtype <- `fieldtype*`})))
    -- (Fieldtype_ok: `%|-%:OK`(C, fieldtype))*{fieldtype <- `fieldtype*`}

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
  ;; 6-typing.watsup:462.1-464.66
  rule refl{C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- if ($clos_deftype(C, deftype_1) = $clos_deftype(C, deftype_2))

  ;; 6-typing.watsup:466.1-469.49
  rule super{C : context, deftype_1 : deftype, deftype_2 : deftype, fin : fin, `typeuse*` : typeuse*, ct : comptype, i : nat}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- if ($unrolldt(deftype_1) = SUB_subtype(fin, typeuse*{typeuse <- `typeuse*`}, ct))
    -- Heaptype_sub: `%|-%<:%`(C, (typeuse*{typeuse <- `typeuse*`}[i] : typeuse <: heaptype), (deftype_2 : deftype <: heaptype))

;; 6-typing.watsup:299.1-299.104
relation Heaptype_sub: `%|-%<:%`(context, heaptype, heaptype)
  ;; 6-typing.watsup:310.1-311.28
  rule refl{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, heaptype, heaptype)

  ;; 6-typing.watsup:313.1-317.48
  rule trans{C : context, heaptype_1 : heaptype, heaptype_2 : heaptype, heaptype' : heaptype}:
    `%|-%<:%`(C, heaptype_1, heaptype_2)
    -- Heaptype_ok: `%|-%:OK`(C, heaptype')
    -- Heaptype_sub: `%|-%<:%`(C, heaptype_1, heaptype')
    -- Heaptype_sub: `%|-%<:%`(C, heaptype', heaptype_2)

  ;; 6-typing.watsup:319.1-320.17
  rule `eq-any`{C : context}:
    `%|-%<:%`(C, EQ_heaptype, ANY_heaptype)

  ;; 6-typing.watsup:322.1-323.17
  rule `i31-eq`{C : context}:
    `%|-%<:%`(C, I31_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:325.1-326.20
  rule `struct-eq`{C : context}:
    `%|-%<:%`(C, STRUCT_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:328.1-329.19
  rule `array-eq`{C : context}:
    `%|-%<:%`(C, ARRAY_heaptype, EQ_heaptype)

  ;; 6-typing.watsup:331.1-333.42
  rule struct{C : context, deftype : deftype, `fieldtype*` : fieldtype*}:
    `%|-%<:%`(C, (deftype : deftype <: heaptype), STRUCT_heaptype)
    -- Expand: `%~~%`(deftype, STRUCT_comptype(`%`_structtype(fieldtype*{fieldtype <- `fieldtype*`})))

  ;; 6-typing.watsup:335.1-337.40
  rule array{C : context, deftype : deftype, fieldtype : fieldtype}:
    `%|-%<:%`(C, (deftype : deftype <: heaptype), ARRAY_heaptype)
    -- Expand: `%~~%`(deftype, ARRAY_comptype(fieldtype))

  ;; 6-typing.watsup:339.1-341.38
  rule func{C : context, deftype : deftype, functype : functype}:
    `%|-%<:%`(C, (deftype : deftype <: heaptype), FUNC_heaptype)
    -- Expand: `%~~%`(deftype, FUNC_comptype(functype))

  ;; 6-typing.watsup:343.1-345.46
  rule def{C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, (deftype_1 : deftype <: heaptype), (deftype_2 : deftype <: heaptype))
    -- Deftype_sub: `%|-%<:%`(C, deftype_1, deftype_2)

  ;; 6-typing.watsup:347.1-349.53
  rule `typeidx-l`{C : context, typeidx : typeidx, heaptype : heaptype}:
    `%|-%<:%`(C, _IDX_heaptype(typeidx), heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, (C.TYPES_context[typeidx!`%`_typeidx.0] : deftype <: heaptype), heaptype)

  ;; 6-typing.watsup:351.1-353.53
  rule `typeidx-r`{C : context, heaptype : heaptype, typeidx : typeidx}:
    `%|-%<:%`(C, heaptype, _IDX_heaptype(typeidx))
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, (C.TYPES_context[typeidx!`%`_typeidx.0] : deftype <: heaptype))

  ;; 6-typing.watsup:355.1-357.40
  rule rec{C : context, i : nat, `typeuse*` : typeuse*, j : nat, fin : fin, ct : comptype}:
    `%|-%<:%`(C, REC_heaptype(i), (typeuse*{typeuse <- `typeuse*`}[j] : typeuse <: heaptype))
    -- if (C.RECS_context[i] = SUB_subtype(fin, typeuse*{typeuse <- `typeuse*`}, ct))

  ;; 6-typing.watsup:359.1-361.40
  rule none{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NONE_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, ANY_heaptype)

  ;; 6-typing.watsup:363.1-365.41
  rule nofunc{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOFUNC_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, FUNC_heaptype)

  ;; 6-typing.watsup:367.1-369.43
  rule noextern{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOEXTERN_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, EXTERN_heaptype)

  ;; 6-typing.watsup:371.1-372.23
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
  rule _{C : context, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%<:%`(C, t_1*{t_1 <- `t_1*`}, t_2*{t_2 <- `t_2*`})
    -- (Valtype_sub: `%|-%<:%`(C, t_1, t_2))*{t_1 <- `t_1*`, t_2 <- `t_2*`}

;; 6-typing.watsup
relation Functype_sub: `%|-%<:%`(context, functype, functype)
  ;; 6-typing.watsup
  rule _{C : context, `t_11*` : valtype*, `t_12*` : valtype*, `t_21*` : valtype*, `t_22*` : valtype*}:
    `%|-%<:%`(C, `%->%`_functype(`%`_resulttype(t_11*{t_11 <- `t_11*`}), `%`_resulttype(t_12*{t_12 <- `t_12*`})), `%->%`_functype(`%`_resulttype(t_21*{t_21 <- `t_21*`}), `%`_resulttype(t_22*{t_22 <- `t_22*`})))
    -- Resulttype_sub: `%|-%<:%`(C, t_21*{t_21 <- `t_21*`}, t_11*{t_11 <- `t_11*`})
    -- Resulttype_sub: `%|-%<:%`(C, t_12*{t_12 <- `t_12*`}, t_22*{t_22 <- `t_22*`})

;; 6-typing.watsup
relation Comptype_sub: `%|-%<:%`(context, comptype, comptype)
  ;; 6-typing.watsup
  rule struct{C : context, `yt_1*` : fieldtype*, yt'_1 : fieldtype, `yt_2*` : fieldtype*}:
    `%|-%<:%`(C, STRUCT_comptype(`%`_structtype(yt_1*{yt_1 <- `yt_1*`} ++ [yt'_1])), STRUCT_comptype(`%`_structtype(yt_2*{yt_2 <- `yt_2*`})))
    -- (Fieldtype_sub: `%|-%<:%`(C, yt_1, yt_2))*{yt_1 <- `yt_1*`, yt_2 <- `yt_2*`}

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
  rule _{C : context, `x*` : idx*, comptype : comptype, x_0 : idx, `x'**` : idx**, `comptype'*` : comptype*}:
    `%|-%:%`(C, SUB_subtype(`FINAL%?`_fin(()?{}), _IDX_typeuse(x)*{x <- `x*`}, comptype), OK_oktypeidx(x_0))
    -- if (|x*{x <- `x*`}| <= 1)
    -- (if (x!`%`_idx.0 < x_0!`%`_idx.0))*{x <- `x*`}
    -- (if ($unrolldt(C.TYPES_context[x!`%`_idx.0]) = SUB_subtype(`FINAL%?`_fin(?()), _IDX_typeuse(x')*{x' <- `x'*`}, comptype')))*{comptype' <- `comptype'*`, x <- `x*`, `x'*` <- `x'**`}
    -- Comptype_ok: `%|-%:OK`(C, comptype)
    -- (Comptype_sub: `%|-%<:%`(C, comptype, comptype'))*{comptype' <- `comptype'*`}

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
  rule _{C : context, `typeuse*` : typeuse*, compttype : comptype, x : idx, i : nat, `typeuse'**` : typeuse**, `comptype'*` : comptype*, comptype : comptype}:
    `%|-%:%`(C, SUB_subtype(`FINAL%?`_fin(()?{}), typeuse*{typeuse <- `typeuse*`}, compttype), OK_oktypeidxnat(x, i))
    -- if (|typeuse*{typeuse <- `typeuse*`}| <= 1)
    -- (if $before(typeuse, x, i))*{typeuse <- `typeuse*`}
    -- (if ($unrollht(C, (typeuse : typeuse <: heaptype)) = SUB_subtype(`FINAL%?`_fin(?()), typeuse'*{typeuse' <- `typeuse'*`}, comptype')))*{comptype' <- `comptype'*`, typeuse <- `typeuse*`, `typeuse'*` <- `typeuse'**`}
    -- Comptype_ok: `%|-%:OK`(C, comptype)
    -- (Comptype_sub: `%|-%<:%`(C, comptype, comptype'))*{comptype' <- `comptype'*`}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:136.1-136.105
relation Rectype_ok2: `%|-%:%`(context, rectype, oktypeidxnat)
  ;; 6-typing.watsup:214.1-215.24
  rule empty{C : context, x : idx, i : nat}:
    `%|-%:%`(C, REC_rectype(`%`_list([])), OK_oktypeidxnat(x, i))

  ;; 6-typing.watsup:217.1-220.55
  rule cons{C : context, subtype_1 : subtype, `subtype*` : subtype*, x : idx, i : nat}:
    `%|-%:%`(C, REC_rectype(`%`_list([subtype_1] ++ subtype*{subtype <- `subtype*`})), OK_oktypeidxnat(x, i))
    -- Subtype_ok2: `%|-%:%`(C, subtype_1, OK_oktypeidxnat(x, i))
    -- Rectype_ok2: `%|-%:%`(C, REC_rectype(`%`_list(subtype*{subtype <- `subtype*`})), OK_oktypeidxnat(`%`_typeidx((x!`%`_idx.0 + 1)), (i + 1)))
}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:134.1-134.102
relation Rectype_ok: `%|-%:%`(context, rectype, oktypeidx)
  ;; 6-typing.watsup:202.1-203.23
  rule empty{C : context, x : idx}:
    `%|-%:%`(C, REC_rectype(`%`_list([])), OK_oktypeidx(x))

  ;; 6-typing.watsup:205.1-208.48
  rule cons{C : context, subtype_1 : subtype, `subtype*` : subtype*, x : idx}:
    `%|-%:%`(C, REC_rectype(`%`_list([subtype_1] ++ subtype*{subtype <- `subtype*`})), OK_oktypeidx(x))
    -- Subtype_ok: `%|-%:%`(C, subtype_1, OK_oktypeidx(x))
    -- Rectype_ok: `%|-%:%`(C, REC_rectype(`%`_list(subtype*{subtype <- `subtype*`})), OK_oktypeidx(`%`_typeidx((x!`%`_idx.0 + 1))))

  ;; 6-typing.watsup:210.1-212.60
  rule rec2{C : context, `subtype*` : subtype*, x : idx}:
    `%|-%:%`(C, REC_rectype(`%`_list(subtype*{subtype <- `subtype*`})), OK_oktypeidx(x))
    -- Rectype_ok2: `%|-%:%`({TYPES [], RECS subtype*{subtype <- `subtype*`}, FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []} +++ C, REC_rectype(`%`_list(subtype*{subtype <- `subtype*`})), OK_oktypeidxnat(x, 0))
}

;; 6-typing.watsup
relation Deftype_ok: `%|-%:OK`(context, deftype)
  ;; 6-typing.watsup
  rule _{C : context, rectype : rectype, i : nat, x : idx, `subtype*` : subtype*, n : n}:
    `%|-%:OK`(C, DEF_deftype(rectype, i))
    -- Rectype_ok: `%|-%:%`(C, rectype, OK_oktypeidx(x))
    -- if (rectype = REC_rectype(`%`_list(subtype^n{subtype <- `subtype*`})))
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
relation Tagtype_ok: `%|-%:OK`(context, tagtype)
  ;; 6-typing.watsup
  rule _{C : context, deftype : deftype, functype : functype}:
    `%|-%:OK`(C, deftype)
    -- Deftype_ok: `%|-%:OK`(C, deftype)
    -- Expand: `%~~%`(deftype, FUNC_comptype(functype))

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
  rule tag{C : context, tagtype : tagtype}:
    `%|-%:OK`(C, TAG_externtype((tagtype : deftype <: typeuse)))
    -- Tagtype_ok: `%|-%:OK`(C, tagtype)

;; 6-typing.watsup
relation Instrtype_sub: `%|-%<:%`(context, instrtype, instrtype)
  ;; 6-typing.watsup
  rule _{C : context, `t_11*` : valtype*, `x_1*` : idx*, `t_12*` : valtype*, `t_21*` : valtype*, `x_2*` : idx*, `t_22*` : valtype*, `x*` : idx*, `t*` : valtype*}:
    `%|-%<:%`(C, `%->_%%`_instrtype(`%`_resulttype(t_11*{t_11 <- `t_11*`}), x_1*{x_1 <- `x_1*`}, `%`_resulttype(t_12*{t_12 <- `t_12*`})), `%->_%%`_instrtype(`%`_resulttype(t_21*{t_21 <- `t_21*`}), x_2*{x_2 <- `x_2*`}, `%`_resulttype(t_22*{t_22 <- `t_22*`})))
    -- Resulttype_sub: `%|-%<:%`(C, t_21*{t_21 <- `t_21*`}, t_11*{t_11 <- `t_11*`})
    -- Resulttype_sub: `%|-%<:%`(C, t_12*{t_12 <- `t_12*`}, t_22*{t_22 <- `t_22*`})
    -- if (x*{x <- `x*`} = $setminus_(syntax localidx, x_2*{x_2 <- `x_2*`}, x_1*{x_1 <- `x_1*`}))
    -- (if (C.LOCALS_context[x!`%`_idx.0] = `%%`_localtype(SET_init, t)))*{t <- `t*`, x <- `x*`}

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
relation Tagtype_sub: `%|-%<:%`(context, tagtype, tagtype)
  ;; 6-typing.watsup
  rule _{C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- Deftype_sub: `%|-%<:%`(C, deftype_1, deftype_2)
    -- Deftype_sub: `%|-%<:%`(C, deftype_2, deftype_1)

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
  rule tag{C : context, tagtype_1 : tagtype, tagtype_2 : tagtype}:
    `%|-%<:%`(C, TAG_externtype((tagtype_1 : deftype <: typeuse)), TAG_externtype((tagtype_2 : deftype <: typeuse)))
    -- Tagtype_sub: `%|-%<:%`(C, tagtype_1, tagtype_2)

;; 6-typing.watsup
relation Blocktype_ok: `%|-%:%`(context, blocktype, instrtype)
  ;; 6-typing.watsup
  rule valtype{C : context, `valtype?` : valtype?}:
    `%|-%:%`(C, _RESULT_blocktype(valtype?{valtype <- `valtype?`}), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype(valtype?{valtype <- `valtype?`})))
    -- (Valtype_ok: `%|-%:OK`(C, valtype))?{valtype <- `valtype?`}

  ;; 6-typing.watsup
  rule typeidx{C : context, typeidx : typeidx, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, _IDX_blocktype(typeidx), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Expand: `%~~%`(C.TYPES_context[typeidx!`%`_typeidx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))))

;; 6-typing.watsup
relation Catch_ok: `%|-%:OK`(context, catch)
  ;; 6-typing.watsup
  rule catch{C : context, x : idx, l : labelidx, `t*` : valtype*}:
    `%|-%:OK`(C, CATCH_catch(x, l))
    -- Expand: `%~~%`(C.TAGS_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t*{t <- `t*`}), `%`_resulttype([]))))
    -- Resulttype_sub: `%|-%<:%`(C, t*{t <- `t*`}, C.LABELS_context[l!`%`_labelidx.0]!`%`_resulttype.0)

  ;; 6-typing.watsup
  rule catch_ref{C : context, x : idx, l : labelidx, `t*` : valtype*}:
    `%|-%:OK`(C, CATCH_REF_catch(x, l))
    -- Expand: `%~~%`(C.TAGS_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t*{t <- `t*`}), `%`_resulttype([]))))
    -- Resulttype_sub: `%|-%<:%`(C, t*{t <- `t*`} ++ [REF_valtype(`NULL%?`_nul(?()), EXN_heaptype)], C.LABELS_context[l!`%`_labelidx.0]!`%`_resulttype.0)

  ;; 6-typing.watsup
  rule catch_all{C : context, l : labelidx}:
    `%|-%:OK`(C, CATCH_ALL_catch(l))
    -- Resulttype_sub: `%|-%<:%`(C, [], C.LABELS_context[l!`%`_labelidx.0]!`%`_resulttype.0)

  ;; 6-typing.watsup
  rule catch_all_ref{C : context, l : labelidx}:
    `%|-%:OK`(C, CATCH_ALL_REF_catch(l))
    -- Resulttype_sub: `%|-%<:%`(C, [REF_valtype(`NULL%?`_nul(?()), EXN_heaptype)], C.LABELS_context[l!`%`_labelidx.0]!`%`_resulttype.0)

;; 6-typing.watsup
rec {

;; 6-typing.watsup:543.1-543.95
relation Instr_ok: `%|-%:%`(context, instr, instrtype)
  ;; 6-typing.watsup:582.1-583.24
  rule nop{C : context}:
    `%|-%:%`(C, NOP_instr, `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([])))

  ;; 6-typing.watsup:585.1-587.42
  rule unreachable{C : context, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; 6-typing.watsup:589.1-591.29
  rule drop{C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->_%%`_instrtype(`%`_resulttype([t]), [], `%`_resulttype([])))
    -- Valtype_ok: `%|-%:OK`(C, t)

  ;; 6-typing.watsup:594.1-596.29
  rule `select-expl`{C : context, t : valtype}:
    `%|-%:%`(C, `SELECT()%?`_instr(?([t])), `%->_%%`_instrtype(`%`_resulttype([t t I32_valtype]), [], `%`_resulttype([t])))
    -- Valtype_ok: `%|-%:OK`(C, t)

  ;; 6-typing.watsup:598.1-602.37
  rule `select-impl`{C : context, t : valtype, t' : valtype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, `SELECT()%?`_instr(?()), `%->_%%`_instrtype(`%`_resulttype([t t I32_valtype]), [], `%`_resulttype([t])))
    -- Valtype_ok: `%|-%:OK`(C, t)
    -- Valtype_sub: `%|-%<:%`(C, t, t')
    -- if ((t' = (numtype : numtype <: valtype)) \/ (t' = (vectype : vectype <: valtype)))

  ;; 6-typing.watsup:618.1-621.67
  rule block{C : context, bt : blocktype, `instr*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*, `x*` : idx*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr <- `instr*`}), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 <- `t_2*`})], RETURN ?(), REFS []} +++ C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x*{x <- `x*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; 6-typing.watsup:623.1-626.67
  rule loop{C : context, bt : blocktype, `instr*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*, `x*` : idx*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr <- `instr*`}), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [`%`_resulttype(t_1*{t_1 <- `t_1*`})], RETURN ?(), REFS []} +++ C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x*{x <- `x*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; 6-typing.watsup:628.1-632.71
  rule if{C : context, bt : blocktype, `instr_1*` : instr*, `instr_2*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*, `x_1*` : idx*, `x_2*` : idx*}:
    `%|-%:%`(C, `IF%%ELSE%`_instr(bt, instr_1*{instr_1 <- `instr_1*`}, instr_2*{instr_2 <- `instr_2*`}), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ [I32_valtype]), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 <- `t_2*`})], RETURN ?(), REFS []} +++ C, instr_1*{instr_1 <- `instr_1*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x_1*{x_1 <- `x_1*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 <- `t_2*`})], RETURN ?(), REFS []} +++ C, instr_2*{instr_2 <- `instr_2*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x_2*{x_2 <- `x_2*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; 6-typing.watsup:637.1-640.42
  rule br{C : context, l : labelidx, `t_1*` : valtype*, `t*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ t*{t <- `t*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t <- `t*`}))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; 6-typing.watsup:642.1-644.25
  rule br_if{C : context, l : labelidx, `t*` : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->_%%`_instrtype(`%`_resulttype(t*{t <- `t*`} ++ [I32_valtype]), [], `%`_resulttype(t*{t <- `t*`})))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t <- `t*`}))

  ;; 6-typing.watsup:646.1-650.42
  rule br_table{C : context, `l*` : labelidx*, l' : labelidx, `t_1*` : valtype*, `t*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l <- `l*`}, l'), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ t*{t <- `t*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- (Resulttype_sub: `%|-%<:%`(C, t*{t <- `t*`}, C.LABELS_context[l!`%`_labelidx.0]!`%`_resulttype.0))*{l <- `l*`}
    -- Resulttype_sub: `%|-%<:%`(C, t*{t <- `t*`}, C.LABELS_context[l'!`%`_labelidx.0]!`%`_resulttype.0)
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; 6-typing.watsup:652.1-655.31
  rule br_on_null{C : context, l : labelidx, `t*` : valtype*, ht : heaptype}:
    `%|-%:%`(C, BR_ON_NULL_instr(l), `%->_%%`_instrtype(`%`_resulttype(t*{t <- `t*`} ++ [REF_valtype(`NULL%?`_nul(?(())), ht)]), [], `%`_resulttype(t*{t <- `t*`} ++ [REF_valtype(`NULL%?`_nul(?()), ht)])))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t <- `t*`}))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:657.1-659.34
  rule br_on_non_null{C : context, l : labelidx, `t*` : valtype*, ht : heaptype}:
    `%|-%:%`(C, BR_ON_NON_NULL_instr(l), `%->_%%`_instrtype(`%`_resulttype(t*{t <- `t*`} ++ [REF_valtype(`NULL%?`_nul(?(())), ht)]), [], `%`_resulttype(t*{t <- `t*`})))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t <- `t*`} ++ [REF_valtype(`NULL%?`_nul(?()), ht)]))

  ;; 6-typing.watsup:661.1-667.34
  rule br_on_cast{C : context, l : labelidx, rt_1 : reftype, rt_2 : reftype, `t*` : valtype*, rt : reftype}:
    `%|-%:%`(C, BR_ON_CAST_instr(l, rt_1, rt_2), `%->_%%`_instrtype(`%`_resulttype(t*{t <- `t*`} ++ [(rt_1 : reftype <: valtype)]), [], `%`_resulttype(t*{t <- `t*`} ++ [($diffrt(rt_1, rt_2) : reftype <: valtype)])))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t <- `t*`} ++ [(rt : reftype <: valtype)]))
    -- Reftype_ok: `%|-%:OK`(C, rt_1)
    -- Reftype_ok: `%|-%:OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt)

  ;; 6-typing.watsup:669.1-675.49
  rule br_on_cast_fail{C : context, l : labelidx, rt_1 : reftype, rt_2 : reftype, `t*` : valtype*, rt : reftype}:
    `%|-%:%`(C, BR_ON_CAST_FAIL_instr(l, rt_1, rt_2), `%->_%%`_instrtype(`%`_resulttype(t*{t <- `t*`} ++ [(rt_1 : reftype <: valtype)]), [], `%`_resulttype(t*{t <- `t*`} ++ [(rt_2 : reftype <: valtype)])))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t <- `t*`} ++ [(rt : reftype <: valtype)]))
    -- Reftype_ok: `%|-%:OK`(C, rt_1)
    -- Reftype_ok: `%|-%:OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, $diffrt(rt_1, rt_2), rt)

  ;; 6-typing.watsup:680.1-682.47
  rule call{C : context, x : idx, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, CALL_instr(x), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Expand: `%~~%`(C.FUNCS_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))))

  ;; 6-typing.watsup:684.1-686.47
  rule call_ref{C : context, x : idx, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, CALL_REF_instr(_IDX_typeuse(x)), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ [REF_valtype(`NULL%?`_nul(?(())), _IDX_heaptype(x))]), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))))

  ;; 6-typing.watsup:688.1-692.47
  rule call_indirect{C : context, x : idx, y : idx, `t_1*` : valtype*, `t_2*` : valtype*, lim : limits, rt : reftype}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, _IDX_typeuse(y)), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ [I32_valtype]), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`_nul(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPES_context[y!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))))

  ;; 6-typing.watsup:694.1-697.42
  rule return{C : context, `t_1*` : valtype*, `t*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ t*{t <- `t*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- if (C.RETURN_context = ?(`%`_list(t*{t <- `t*`})))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; 6-typing.watsup:700.1-705.42
  rule return_call{C : context, x : idx, `t_3*` : valtype*, `t_1*` : valtype*, `t_4*` : valtype*, `t_2*` : valtype*, `t'_2*` : valtype*}:
    `%|-%:%`(C, RETURN_CALL_instr(x), `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 <- `t_3*`} ++ t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_4*{t_4 <- `t_4*`})))
    -- Expand: `%~~%`(C.FUNCS_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))))
    -- if (C.RETURN_context = ?(`%`_list(t'_2*{t'_2 <- `t'_2*`})))
    -- Resulttype_sub: `%|-%<:%`(C, t_2*{t_2 <- `t_2*`}, t'_2*{t'_2 <- `t'_2*`})
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 <- `t_3*`}), [], `%`_resulttype(t_4*{t_4 <- `t_4*`})))

  ;; 6-typing.watsup:708.1-713.42
  rule return_call_ref{C : context, x : idx, `t_3*` : valtype*, `t_1*` : valtype*, `t_4*` : valtype*, `t_2*` : valtype*, `t'_2*` : valtype*}:
    `%|-%:%`(C, RETURN_CALL_REF_instr(_IDX_typeuse(x)), `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 <- `t_3*`} ++ t_1*{t_1 <- `t_1*`} ++ [REF_valtype(`NULL%?`_nul(?(())), _IDX_heaptype(x))]), [], `%`_resulttype(t_4*{t_4 <- `t_4*`})))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))))
    -- if (C.RETURN_context = ?(`%`_list(t'_2*{t'_2 <- `t'_2*`})))
    -- Resulttype_sub: `%|-%<:%`(C, t_2*{t_2 <- `t_2*`}, t'_2*{t'_2 <- `t'_2*`})
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 <- `t_3*`}), [], `%`_resulttype(t_4*{t_4 <- `t_4*`})))

  ;; 6-typing.watsup:716.1-724.42
  rule return_call_indirect{C : context, x : idx, y : idx, `t_3*` : valtype*, `t_1*` : valtype*, `t_4*` : valtype*, lim : limits, rt : reftype, `t_2*` : valtype*, `t'_2*` : valtype*}:
    `%|-%:%`(C, RETURN_CALL_INDIRECT_instr(x, _IDX_typeuse(y)), `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 <- `t_3*`} ++ t_1*{t_1 <- `t_1*`} ++ [I32_valtype]), [], `%`_resulttype(t_4*{t_4 <- `t_4*`})))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`_nul(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPES_context[y!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))))
    -- if (C.RETURN_context = ?(`%`_list(t'_2*{t'_2 <- `t'_2*`})))
    -- Resulttype_sub: `%|-%<:%`(C, t_2*{t_2 <- `t_2*`}, t'_2*{t'_2 <- `t'_2*`})
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 <- `t_3*`}), [], `%`_resulttype(t_4*{t_4 <- `t_4*`})))

  ;; 6-typing.watsup:731.1-734.42
  rule throw{C : context, x : idx, `t_1*` : valtype*, `t*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, THROW_instr(x), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ t*{t <- `t*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Expand: `%~~%`(C.TAGS_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t*{t <- `t*`}), `%`_resulttype([]))))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; 6-typing.watsup:736.1-738.42
  rule throw_ref{C : context, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, THROW_REF_instr, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ [REF_valtype(`NULL%?`_nul(?(())), EXN_heaptype)]), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; 6-typing.watsup:740.1-744.34
  rule try_table{C : context, bt : blocktype, `catch*` : catch*, `instr*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*, `x*` : idx*}:
    `%|-%:%`(C, TRY_TABLE_instr(bt, `%`_list(catch*{catch <- `catch*`}), instr*{instr <- `instr*`}), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 <- `t_2*`})], RETURN ?(), REFS []} +++ C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x*{x <- `x*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- (Catch_ok: `%|-%:OK`(C, catch))*{catch <- `catch*`}

  ;; 6-typing.watsup:767.1-768.33
  rule const{C : context, nt : numtype, c_nt : num_(nt)}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([(nt : numtype <: valtype)])))

  ;; 6-typing.watsup:770.1-771.34
  rule unop{C : context, nt : numtype, unop_nt : unop_(nt)}:
    `%|-%:%`(C, UNOP_instr(nt, unop_nt), `%->_%%`_instrtype(`%`_resulttype([(nt : numtype <: valtype)]), [], `%`_resulttype([(nt : numtype <: valtype)])))

  ;; 6-typing.watsup:773.1-774.39
  rule binop{C : context, nt : numtype, binop_nt : binop_(nt)}:
    `%|-%:%`(C, BINOP_instr(nt, binop_nt), `%->_%%`_instrtype(`%`_resulttype([(nt : numtype <: valtype) (nt : numtype <: valtype)]), [], `%`_resulttype([(nt : numtype <: valtype)])))

  ;; 6-typing.watsup:776.1-777.39
  rule testop{C : context, nt : numtype, testop_nt : testop_(nt)}:
    `%|-%:%`(C, TESTOP_instr(nt, testop_nt), `%->_%%`_instrtype(`%`_resulttype([(nt : numtype <: valtype)]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:779.1-780.40
  rule relop{C : context, nt : numtype, relop_nt : relop_(nt)}:
    `%|-%:%`(C, RELOP_instr(nt, relop_nt), `%->_%%`_instrtype(`%`_resulttype([(nt : numtype <: valtype) (nt : numtype <: valtype)]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:782.1-783.44
  rule cvtop{C : context, nt_1 : numtype, nt_2 : numtype, cvtop : cvtop__(nt_2, nt_1)}:
    `%|-%:%`(C, CVTOP_instr(nt_1, nt_2, cvtop), `%->_%%`_instrtype(`%`_resulttype([(nt_2 : numtype <: valtype)]), [], `%`_resulttype([(nt_1 : numtype <: valtype)])))

  ;; 6-typing.watsup:788.1-790.31
  rule ref.null{C : context, ht : heaptype}:
    `%|-%:%`(C, REF.NULL_instr(ht), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ht)])))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:792.1-795.20
  rule ref.func{C : context, x : idx, dt : deftype}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), (dt : deftype <: heaptype))])))
    -- if (C.FUNCS_context[x!`%`_idx.0] = dt)
    -- if x <- C.REFS_context

  ;; 6-typing.watsup:797.1-798.34
  rule ref.i31{C : context}:
    `%|-%:%`(C, REF.I31_instr, `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), I31_heaptype)])))

  ;; 6-typing.watsup:800.1-802.31
  rule ref.is_null{C : context, ht : heaptype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ht)]), [], `%`_resulttype([I32_valtype])))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:804.1-806.31
  rule ref.as_non_null{C : context, ht : heaptype}:
    `%|-%:%`(C, REF.AS_NON_NULL_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ht)]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), ht)])))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:808.1-809.51
  rule ref.eq{C : context}:
    `%|-%:%`(C, REF.EQ_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), EQ_heaptype) REF_valtype(`NULL%?`_nul(?(())), EQ_heaptype)]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:811.1-815.33
  rule ref.test{C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.TEST_instr(rt), `%->_%%`_instrtype(`%`_resulttype([(rt' : reftype <: valtype)]), [], `%`_resulttype([I32_valtype])))
    -- Reftype_ok: `%|-%:OK`(C, rt)
    -- Reftype_ok: `%|-%:OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; 6-typing.watsup:817.1-821.33
  rule ref.cast{C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.CAST_instr(rt), `%->_%%`_instrtype(`%`_resulttype([(rt' : reftype <: valtype)]), [], `%`_resulttype([(rt : reftype <: valtype)])))
    -- Reftype_ok: `%|-%:OK`(C, rt)
    -- Reftype_ok: `%|-%:OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; 6-typing.watsup:826.1-827.42
  rule i31.get{C : context, sx : sx}:
    `%|-%:%`(C, I31.GET_instr(sx), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), I31_heaptype)]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:832.1-834.44
  rule struct.new{C : context, x : idx, `zt*` : storagetype*, `mut*` : mut*}:
    `%|-%:%`(C, STRUCT.NEW_instr(x), `%->_%%`_instrtype(`%`_resulttype($unpack(zt)*{zt <- `zt*`}), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], STRUCT_comptype(`%`_structtype(`%%`_fieldtype(mut, zt)*{mut <- `mut*`, zt <- `zt*`})))

  ;; 6-typing.watsup:836.1-839.40
  rule struct.new_default{C : context, x : idx, `mut*` : mut*, `zt*` : storagetype*, `val*` : val*}:
    `%|-%:%`(C, STRUCT.NEW_DEFAULT_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], STRUCT_comptype(`%`_structtype(`%%`_fieldtype(mut, zt)*{mut <- `mut*`, zt <- `zt*`})))
    -- (if ($default_($unpack(zt)) = ?(val)))*{val <- `val*`, zt <- `zt*`}

  ;; 6-typing.watsup:841.1-845.39
  rule struct.get{C : context, `sx?` : sx?, x : idx, i : nat, zt : storagetype, `yt*` : fieldtype*, mut : mut}:
    `%|-%:%`(C, STRUCT.GET_instr(sx?{sx <- `sx?`}, x, `%`_u32(i)), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), _IDX_heaptype(x))]), [], `%`_resulttype([$unpack(zt)])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], STRUCT_comptype(`%`_structtype(yt*{yt <- `yt*`})))
    -- if (yt*{yt <- `yt*`}[i] = `%%`_fieldtype(mut, zt))
    -- if ((sx?{sx <- `sx?`} = ?()) <=> (zt = ($unpack(zt) : valtype <: storagetype)))

  ;; 6-typing.watsup:847.1-850.24
  rule struct.set{C : context, x : idx, i : nat, zt : storagetype, `yt*` : fieldtype*}:
    `%|-%:%`(C, STRUCT.SET_instr(x, `%`_u32(i)), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), _IDX_heaptype(x)) $unpack(zt)]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], STRUCT_comptype(`%`_structtype(yt*{yt <- `yt*`})))
    -- if (yt*{yt <- `yt*`}[i] = `%%`_fieldtype(`MUT%?`_mut(?(())), zt))

  ;; 6-typing.watsup:855.1-857.42
  rule array.new{C : context, x : idx, zt : storagetype, mut : mut}:
    `%|-%:%`(C, ARRAY.NEW_instr(x), `%->_%%`_instrtype(`%`_resulttype([$unpack(zt) I32_valtype]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, zt)))

  ;; 6-typing.watsup:859.1-862.37
  rule array.new_default{C : context, x : idx, mut : mut, zt : storagetype, val : val}:
    `%|-%:%`(C, ARRAY.NEW_DEFAULT_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ($default_($unpack(zt)) = ?(val))

  ;; 6-typing.watsup:864.1-866.42
  rule array.new_fixed{C : context, x : idx, n : n, zt : storagetype, mut : mut}:
    `%|-%:%`(C, ARRAY.NEW_FIXED_instr(x, `%`_u32(n)), `%->_%%`_instrtype(`%`_resulttype($unpack(zt)^n{}), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, zt)))

  ;; 6-typing.watsup:868.1-871.40
  rule array.new_elem{C : context, x : idx, y : idx, mut : mut, rt : reftype}:
    `%|-%:%`(C, ARRAY.NEW_ELEM_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, (rt : reftype <: storagetype))))
    -- Reftype_sub: `%|-%<:%`(C, C.ELEMS_context[y!`%`_idx.0], rt)

  ;; 6-typing.watsup:873.1-877.24
  rule array.new_data{C : context, x : idx, y : idx, mut : mut, zt : storagetype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, ARRAY.NEW_DATA_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype]), [], `%`_resulttype([REF_valtype(`NULL%?`_nul(?()), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if (($unpack(zt) = (numtype : numtype <: valtype)) \/ ($unpack(zt) = (vectype : vectype <: valtype)))
    -- if (C.DATAS_context[y!`%`_idx.0] = OK_datatype)

  ;; 6-typing.watsup:879.1-882.39
  rule array.get{C : context, `sx?` : sx?, x : idx, zt : storagetype, mut : mut}:
    `%|-%:%`(C, ARRAY.GET_instr(sx?{sx <- `sx?`}, x), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), _IDX_heaptype(x)) I32_valtype]), [], `%`_resulttype([$unpack(zt)])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ((sx?{sx <- `sx?`} = ?()) <=> (zt = ($unpack(zt) : valtype <: storagetype)))

  ;; 6-typing.watsup:884.1-886.42
  rule array.set{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.SET_instr(x), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), _IDX_heaptype(x)) I32_valtype $unpack(zt)]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(`MUT%?`_mut(?(())), zt)))

  ;; 6-typing.watsup:888.1-890.42
  rule array.len{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.LEN_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), ARRAY_heaptype)]), [], `%`_resulttype([I32_valtype])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(`MUT%?`_mut(?(())), zt)))

  ;; 6-typing.watsup:892.1-894.42
  rule array.fill{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.FILL_instr(x), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), _IDX_heaptype(x)) I32_valtype $unpack(zt) I32_valtype]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(`MUT%?`_mut(?(())), zt)))

  ;; 6-typing.watsup:896.1-900.40
  rule array.copy{C : context, x_1 : idx, x_2 : idx, zt_1 : storagetype, mut : mut, zt_2 : storagetype}:
    `%|-%:%`(C, ARRAY.COPY_instr(x_1, x_2), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), _IDX_heaptype(x_1)) I32_valtype REF_valtype(`NULL%?`_nul(?(())), _IDX_heaptype(x_2)) I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x_1!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(`MUT%?`_mut(?(())), zt_1)))
    -- Expand: `%~~%`(C.TYPES_context[x_2!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(mut, zt_2)))
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

  ;; 6-typing.watsup:902.1-905.44
  rule array.init_elem{C : context, x : idx, y : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.INIT_ELEM_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), _IDX_heaptype(x)) I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(`MUT%?`_mut(?(())), zt)))
    -- Storagetype_sub: `%|-%<:%`(C, (C.ELEMS_context[y!`%`_idx.0] : reftype <: storagetype), zt)

  ;; 6-typing.watsup:907.1-911.24
  rule array.init_data{C : context, x : idx, y : idx, zt : storagetype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, ARRAY.INIT_DATA_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(`NULL%?`_nul(?(())), _IDX_heaptype(x)) I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_arraytype(`MUT%?`_mut(?(())), zt)))
    -- if (($unpack(zt) = (numtype : numtype <: valtype)) \/ ($unpack(zt) = (vectype : vectype <: valtype)))
    -- if (C.DATAS_context[y!`%`_idx.0] = OK_datatype)

  ;; 6-typing.watsup:916.1-918.20
  rule extern.convert_any{C : context, nul1 : nul1, nul2 : nul2}:
    `%|-%:%`(C, EXTERN.CONVERT_ANY_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(nul1, ANY_heaptype)]), [], `%`_resulttype([REF_valtype(nul2, EXTERN_heaptype)])))
    -- if (nul1 = nul2)

  ;; 6-typing.watsup:920.1-922.20
  rule any.convert_extern{C : context, nul1 : nul1, nul2 : nul2}:
    `%|-%:%`(C, ANY.CONVERT_EXTERN_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(nul1, EXTERN_heaptype)]), [], `%`_resulttype([REF_valtype(nul2, ANY_heaptype)])))
    -- if (nul1 = nul2)

  ;; 6-typing.watsup:927.1-928.35
  rule vconst{C : context, c : vec_(V128_Vnn)}:
    `%|-%:%`(C, VCONST_instr(V128_vectype, c), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:930.1-931.41
  rule vvunop{C : context, vvunop : vvunop}:
    `%|-%:%`(C, VVUNOP_instr(V128_vectype, vvunop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:933.1-934.48
  rule vvbinop{C : context, vvbinop : vvbinop}:
    `%|-%:%`(C, VVBINOP_instr(V128_vectype, vvbinop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:936.1-937.55
  rule vvternop{C : context, vvternop : vvternop}:
    `%|-%:%`(C, VVTERNOP_instr(V128_vectype, vvternop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:939.1-940.44
  rule vvtestop{C : context, vvtestop : vvtestop}:
    `%|-%:%`(C, VVTESTOP_instr(V128_vectype, vvtestop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:942.1-943.37
  rule vunop{C : context, sh : shape, vunop : vunop_(sh)}:
    `%|-%:%`(C, VUNOP_instr(sh, vunop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:945.1-946.44
  rule vbinop{C : context, sh : shape, vbinop : vbinop_(sh)}:
    `%|-%:%`(C, VBINOP_instr(sh, vbinop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:948.1-949.51
  rule vternop{C : context, sh : shape, vternop : vternop_(sh)}:
    `%|-%:%`(C, VTERNOP_instr(sh, vternop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:951.1-952.40
  rule vtestop{C : context, sh : shape, vtestop : vtestop_(sh)}:
    `%|-%:%`(C, VTESTOP_instr(sh, vtestop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:954.1-955.44
  rule vrelop{C : context, sh : shape, vrelop : vrelop_(sh)}:
    `%|-%:%`(C, VRELOP_instr(sh, vrelop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:957.1-958.47
  rule vshiftop{C : context, sh : ishape, vshiftop : vshiftop_(sh)}:
    `%|-%:%`(C, VSHIFTOP_instr(sh, vshiftop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype I32_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:960.1-961.33
  rule vbitmask{C : context, sh : ishape}:
    `%|-%:%`(C, VBITMASK_instr(sh), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([I32_valtype])))

  ;; 6-typing.watsup:963.1-964.50
  rule vswizzlop{C : context, sh : ishape, vswizzlop : vswizzlop_(sh)}:
    `%|-%:%`(C, VSWIZZLOP_instr(sh, vswizzlop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:966.1-968.29
  rule vshuffle{C : context, sh : ishape, `i*` : nat*}:
    `%|-%:%`(C, VSHUFFLE_instr(sh, `%`_laneidx(i)*{i <- `i*`}), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))
    -- (if (i < (2 * $dim((sh : ishape <: shape))!`%`_dim.0)))*{i <- `i*`}

  ;; 6-typing.watsup:970.1-971.44
  rule vsplat{C : context, sh : shape}:
    `%|-%:%`(C, VSPLAT_instr(sh), `%->_%%`_instrtype(`%`_resulttype([($unpackshape(sh) : numtype <: valtype)]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:973.1-975.21
  rule vextract_lane{C : context, sh : shape, `sx?` : sx?, i : nat}:
    `%|-%:%`(C, VEXTRACT_LANE_instr(sh, sx?{sx <- `sx?`}, `%`_laneidx(i)), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([($unpackshape(sh) : numtype <: valtype)])))
    -- if (i < $dim(sh)!`%`_dim.0)

  ;; 6-typing.watsup:977.1-979.21
  rule vreplace_lane{C : context, sh : shape, i : nat}:
    `%|-%:%`(C, VREPLACE_LANE_instr(sh, `%`_laneidx(i)), `%->_%%`_instrtype(`%`_resulttype([V128_valtype ($unpackshape(sh) : numtype <: valtype)]), [], `%`_resulttype([V128_valtype])))
    -- if (i < $dim(sh)!`%`_dim.0)

  ;; 6-typing.watsup:981.1-982.50
  rule vextunop{C : context, sh_1 : ishape, sh_2 : ishape, vextunop : vextunop__(sh_2, sh_1)}:
    `%|-%:%`(C, VEXTUNOP_instr(sh_1, sh_2, vextunop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:984.1-985.57
  rule vextbinop{C : context, sh_1 : ishape, sh_2 : ishape, vextbinop : vextbinop__(sh_2, sh_1)}:
    `%|-%:%`(C, VEXTBINOP_instr(sh_1, sh_2, vextbinop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:987.1-988.64
  rule vextternop{C : context, sh_1 : ishape, sh_2 : ishape, vextternop : vextternop__(sh_2, sh_1)}:
    `%|-%:%`(C, VEXTTERNOP_instr(sh_1, sh_2, vextternop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:990.1-991.48
  rule vnarrow{C : context, sh_1 : ishape, sh_2 : ishape, sx : sx}:
    `%|-%:%`(C, VNARROW_instr(sh_1, sh_2, sx), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:993.1-994.58
  rule vcvtop{C : context, sh_1 : shape, sh_2 : shape, vcvtop : vcvtop__(sh_2, sh_1), `half?` : half__(sh_2, sh_1)?, `zero?` : zero__(sh_2, sh_1)?}:
    `%|-%:%`(C, VCVTOP_instr(sh_1, sh_2, vcvtop, half?{half <- `half?`}, zero?{zero <- `zero?`}), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; 6-typing.watsup:999.1-1001.28
  rule local.get{C : context, x : idx, t : valtype}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([t])))
    -- if (C.LOCALS_context[x!`%`_idx.0] = `%%`_localtype(SET_init, t))

  ;; 6-typing.watsup:1003.1-1005.29
  rule local.set{C : context, x : idx, t : valtype, init : init}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->_%%`_instrtype(`%`_resulttype([t]), [x], `%`_resulttype([])))
    -- if (C.LOCALS_context[x!`%`_idx.0] = `%%`_localtype(init, t))

  ;; 6-typing.watsup:1007.1-1009.29
  rule local.tee{C : context, x : idx, t : valtype, init : init}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->_%%`_instrtype(`%`_resulttype([t]), [x], `%`_resulttype([t])))
    -- if (C.LOCALS_context[x!`%`_idx.0] = `%%`_localtype(init, t))

  ;; 6-typing.watsup:1014.1-1016.29
  rule global.get{C : context, x : idx, t : valtype, mut : mut}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([t])))
    -- if (C.GLOBALS_context[x!`%`_idx.0] = `%%`_globaltype(mut, t))

  ;; 6-typing.watsup:1018.1-1020.29
  rule global.set{C : context, x : idx, t : valtype}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->_%%`_instrtype(`%`_resulttype([t]), [], `%`_resulttype([])))
    -- if (C.GLOBALS_context[x!`%`_idx.0] = `%%`_globaltype(`MUT%?`_mut(?(())), t))

  ;; 6-typing.watsup:1025.1-1027.29
  rule table.get{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([(rt : reftype <: valtype)])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))

  ;; 6-typing.watsup:1029.1-1031.29
  rule table.set{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype (rt : reftype <: valtype)]), [], `%`_resulttype([])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))

  ;; 6-typing.watsup:1033.1-1035.29
  rule table.size{C : context, x : idx, lim : limits, rt : reftype}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([I32_valtype])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))

  ;; 6-typing.watsup:1037.1-1039.29
  rule table.grow{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->_%%`_instrtype(`%`_resulttype([(rt : reftype <: valtype) I32_valtype]), [], `%`_resulttype([I32_valtype])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))

  ;; 6-typing.watsup:1041.1-1043.29
  rule table.fill{C : context, x : idx, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype (rt : reftype <: valtype) I32_valtype]), [], `%`_resulttype([])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt))

  ;; 6-typing.watsup:1045.1-1049.36
  rule table.copy{C : context, x_1 : idx, x_2 : idx, lim_1 : limits, rt_1 : reftype, lim_2 : limits, rt_2 : reftype}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- if (C.TABLES_context[x_1!`%`_idx.0] = `%%`_tabletype(lim_1, rt_1))
    -- if (C.TABLES_context[x_2!`%`_idx.0] = `%%`_tabletype(lim_2, rt_2))
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:1051.1-1055.36
  rule table.init{C : context, x : idx, y : idx, lim : limits, rt_1 : reftype, rt_2 : reftype}:
    `%|-%:%`(C, TABLE.INIT_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%`_tabletype(lim, rt_1))
    -- if (C.ELEMS_context[y!`%`_idx.0] = rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:1057.1-1059.24
  rule elem.drop{C : context, x : idx, rt : reftype}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([])))
    -- if (C.ELEMS_context[x!`%`_idx.0] = rt)

  ;; 6-typing.watsup:1064.1-1066.23
  rule memory.size{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([I32_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)

  ;; 6-typing.watsup:1068.1-1070.23
  rule memory.grow{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([I32_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)

  ;; 6-typing.watsup:1072.1-1074.23
  rule memory.fill{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)

  ;; 6-typing.watsup:1076.1-1079.27
  rule memory.copy{C : context, x_1 : idx, x_2 : idx, mt_1 : memtype, mt_2 : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr(x_1, x_2), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x_1!`%`_idx.0] = mt_1)
    -- if (C.MEMS_context[x_2!`%`_idx.0] = mt_2)

  ;; 6-typing.watsup:1081.1-1084.24
  rule memory.init{C : context, x : idx, y : idx, mt : memtype}:
    `%|-%:%`(C, MEMORY.INIT_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if (C.DATAS_context[y!`%`_idx.0] = OK_datatype)

  ;; 6-typing.watsup:1086.1-1088.24
  rule data.drop{C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([])))
    -- if (C.DATAS_context[x!`%`_idx.0] = OK_datatype)

  ;; 6-typing.watsup:1099.1-1102.43
  rule `load-val`{C : context, nt : numtype, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, LOAD_instr(nt, ?(), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([(nt : numtype <: valtype)])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= ($size(nt) / 8))

  ;; 6-typing.watsup:1104.1-1107.35
  rule `load-pack`{C : context, Inn : Inn, M : M, sx : sx, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, LOAD_instr((Inn : Inn <: numtype), ?(`%%`_loadop_(`%`_sz(M), sx)), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([(Inn : Inn <: valtype)])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= (M / 8))

  ;; 6-typing.watsup:1118.1-1121.43
  rule `store-val`{C : context, nt : numtype, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, STORE_instr(nt, ?(), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype (nt : numtype <: valtype)]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= ($size(nt) / 8))

  ;; 6-typing.watsup:1123.1-1126.35
  rule `store-pack`{C : context, Inn : Inn, M : M, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, STORE_instr((Inn : Inn <: numtype), ?(`%`_sz(M)), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype (Inn : Inn <: valtype)]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= (M / 8))

  ;; 6-typing.watsup:1128.1-1131.46
  rule `vload-val`{C : context, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(V128_vectype, ?(), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= ($vsize(V128_vectype) / 8))

  ;; 6-typing.watsup:1133.1-1136.39
  rule `vload-pack`{C : context, M : M, N : N, sx : sx, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(V128_vectype, ?(`SHAPE%X%%`_vloadop_(`%`_sz(M), N, sx)), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= ((M / 8) * N))

  ;; 6-typing.watsup:1138.1-1141.35
  rule `vload-splat`{C : context, N : N, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(N))), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= (N / 8))

  ;; 6-typing.watsup:1143.1-1146.35
  rule `vload-zero`{C : context, N : N, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(N))), x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= (N / 8))

  ;; 6-typing.watsup:1148.1-1152.21
  rule vload_lane{C : context, N : N, x : idx, memarg : memarg, i : nat, mt : memtype}:
    `%|-%:%`(C, VLOAD_LANE_instr(V128_vectype, `%`_sz(N), x, memarg, `%`_laneidx(i)), `%->_%%`_instrtype(`%`_resulttype([I32_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= (N / 8))
    -- if (i < (128 / N))

  ;; 6-typing.watsup:1154.1-1157.46
  rule vstore{C : context, x : idx, memarg : memarg, mt : memtype}:
    `%|-%:%`(C, VSTORE_instr(V128_vectype, x, memarg), `%->_%%`_instrtype(`%`_resulttype([I32_valtype V128_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= ($vsize(V128_vectype) / 8))

  ;; 6-typing.watsup:1159.1-1163.21
  rule vstore_lane{C : context, N : N, x : idx, memarg : memarg, i : nat, mt : memtype}:
    `%|-%:%`(C, VSTORE_LANE_instr(V128_vectype, `%`_sz(N), x, memarg, `%`_laneidx(i)), `%->_%%`_instrtype(`%`_resulttype([I32_valtype V128_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)
    -- if ((2 ^ memarg.ALIGN_memarg!`%`_u32.0) <= (N / 8))
    -- if (i < (128 / N))

;; 6-typing.watsup:544.1-544.96
relation Instrs_ok: `%|-%:%`(context, instr*, instrtype)
  ;; 6-typing.watsup:557.1-558.24
  rule empty{C : context}:
    `%|-%:%`(C, [], `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([])))

  ;; 6-typing.watsup:561.1-565.82
  rule seq{C : context, instr_1 : instr, `instr_2*` : instr*, `t_1*` : valtype*, `x_1*` : idx*, `x_2*` : idx*, `t_3*` : valtype*, `t_2*` : valtype*, `init*` : init*, `t*` : valtype*}:
    `%|-%:%`(C, [instr_1] ++ instr_2*{instr_2 <- `instr_2*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x_1*{x_1 <- `x_1*`} ++ x_2*{x_2 <- `x_2*`}, `%`_resulttype(t_3*{t_3 <- `t_3*`})))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x_1*{x_1 <- `x_1*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- (if (C.LOCALS_context[x_1!`%`_idx.0] = `%%`_localtype(init, t)))*{init <- `init*`, t <- `t*`, x_1 <- `x_1*`}
    -- Instrs_ok: `%|-%:%`($with_locals(C, x_1*{x_1 <- `x_1*`}, `%%`_localtype(SET_init, t)*{t <- `t*`}), instr_2*{instr_2 <- `instr_2*`}, `%->_%%`_instrtype(`%`_resulttype(t_2*{t_2 <- `t_2*`}), x_2*{x_2 <- `x_2*`}, `%`_resulttype(t_3*{t_3 <- `t_3*`})))

  ;; 6-typing.watsup:567.1-571.33
  rule sub{C : context, `instr*` : instr*, it' : instrtype, it : instrtype}:
    `%|-%:%`(C, instr*{instr <- `instr*`}, it')
    -- Instrs_ok: `%|-%:%`(C, instr*{instr <- `instr*`}, it)
    -- Instrtype_sub: `%|-%<:%`(C, it, it')
    -- Instrtype_ok: `%|-%:OK`(C, it')

  ;; 6-typing.watsup:574.1-577.33
  rule frame{C : context, `instr*` : instr*, `t*` : valtype*, `t_1*` : valtype*, `x*` : idx*, `t_2*` : valtype*}:
    `%|-%:%`(C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype(t*{t <- `t*`} ++ t_1*{t_1 <- `t_1*`}), x*{x <- `x*`}, `%`_resulttype(t*{t <- `t*`} ++ t_2*{t_2 <- `t_2*`})))
    -- Instrs_ok: `%|-%:%`(C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x*{x <- `x*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t*{t <- `t*`}))
}

;; 6-typing.watsup
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 6-typing.watsup
  rule _{C : context, `instr*` : instr*, `t*` : valtype*}:
    `%|-%:%`(C, instr*{instr <- `instr*`}, `%`_resulttype(t*{t <- `t*`}))
    -- Instrs_ok: `%|-%:%`(C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype(t*{t <- `t*`})))

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
    -- if Inn <- [I32_Inn I64_Inn]
    -- if binop <- [ADD_binop_ SUB_binop_ MUL_binop_]

;; 6-typing.watsup
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 6-typing.watsup
  rule _{C : context, `instr*` : instr*}:
    `%|-%CONST`(C, instr*{instr <- `instr*`})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr <- `instr*`}

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
  rule _{C : context, rectype : rectype, `dt*` : deftype*, x : idx}:
    `%|-%:%`(C, TYPE_type(rectype), dt*{dt <- `dt*`})
    -- if (x = `%`_idx(|C.TYPES_context|))
    -- if (dt*{dt <- `dt*`} = $rolldt(x, rectype))
    -- Rectype_ok: `%|-%:%`(C +++ {TYPES dt*{dt <- `dt*`}, RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rectype, OK_oktypeidx(x))

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
  rule _{C : context, x : idx, `local*` : local*, expr : expr, `t_1*` : valtype*, `t_2*` : valtype*, `lct*` : localtype*}:
    `%|-%:%`(C, FUNC_func(x, local*{local <- `local*`}, expr), C.TYPES_context[x!`%`_idx.0])
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))))
    -- (Local_ok: `%|-%:%`(C, local, lct))*{lct <- `lct*`, local <- `local*`}
    -- Expr_ok: `%|-%:%`(C +++ {TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS `%%`_localtype(SET_init, t_1)*{t_1 <- `t_1*`} ++ lct*{lct <- `lct*`}, LABELS [`%`_resulttype(t_2*{t_2 <- `t_2*`})], RETURN ?(`%`_resulttype(t_2*{t_2 <- `t_2*`})), REFS []}, expr, `%`_resulttype(t_2*{t_2 <- `t_2*`}))

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
relation Tag_ok: `%|-%:%`(context, tag, tagtype)
  ;; 6-typing.watsup
  rule _{C : context, x : idx, functype : functype}:
    `%|-%:%`(C, TAG_tag(x), C.TYPES_context[x!`%`_idx.0])
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], FUNC_comptype(functype))

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
  rule _{C : context, elemtype : elemtype, `expr*` : expr*, elemmode : elemmode}:
    `%|-%:%`(C, ELEM_elem(elemtype, expr*{expr <- `expr*`}, elemmode), elemtype)
    -- Reftype_ok: `%|-%:OK`(C, elemtype)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, (elemtype : reftype <: valtype)))*{expr <- `expr*`}
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
  rule _{C : context, `b*` : byte*, datamode : datamode}:
    `%|-%:%`(C, DATA_data(b*{b <- `b*`}, datamode), OK_datatype)
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
  rule tag{C : context, x : idx, at : tagtype}:
    `%|-%:%`(C, TAG_externidx(x), TAG_externtype((at : deftype <: typeuse)))
    -- if (C.TAGS_context[x!`%`_idx.0] = at)

;; 6-typing.watsup
relation Export_ok: `%|-%:%%`(context, export, name, externtype)
  ;; 6-typing.watsup
  rule _{C : context, name : name, externidx : externidx, xt : externtype}:
    `%|-%:%%`(C, EXPORT_export(name, externidx), name, xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 6-typing.watsup
rec {

;; 6-typing.watsup:1364.1-1364.100
relation Globals_ok: `%|-%:%`(context, global*, globaltype*)
  ;; 6-typing.watsup:1408.1-1409.17
  rule empty{C : context}:
    `%|-%:%`(C, [], [])

  ;; 6-typing.watsup:1411.1-1414.54
  rule cons{C : context, global_1 : global, `global*` : global*, gt_1 : globaltype, `gt*` : globaltype*}:
    `%|-%:%`(C, [global_1] ++ global*{global <- `global*`}, [gt_1] ++ gt*{gt <- `gt*`})
    -- Global_ok: `%|-%:%`(C, global_1, gt_1)
    -- Globals_ok: `%|-%:%`(C +++ {TYPES [], RECS [], FUNCS [], GLOBALS [gt_1], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, global*{global <- `global*`}, gt*{gt <- `gt*`})
}

;; 6-typing.watsup
rec {

;; 6-typing.watsup:1363.1-1363.98
relation Types_ok: `%|-%:%`(context, type*, deftype*)
  ;; 6-typing.watsup:1400.1-1401.17
  rule empty{C : context}:
    `%|-%:%`(C, [], [])

  ;; 6-typing.watsup:1403.1-1406.49
  rule cons{C : context, type_1 : type, `type*` : type*, `dt_1*` : deftype*, `dt*` : deftype*}:
    `%|-%:%`(C, [type_1] ++ type*{type <- `type*`}, dt_1*{dt_1 <- `dt_1*`} ++ dt*{dt <- `dt*`})
    -- Type_ok: `%|-%:%`(C, type_1, dt_1*{dt_1 <- `dt_1*`})
    -- Types_ok: `%|-%:%`(C +++ {TYPES dt_1*{dt_1 <- `dt_1*`}, RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, type*{type <- `type*`}, dt*{dt <- `dt*`})
}

;; 6-typing.watsup
syntax nonfuncs =
  | `%%%%%`{`global*` : global*, `table*` : table*, `mem*` : mem*, `elem*` : elem*, `data*` : data*}(global*{global <- `global*`} : global*, table*{table <- `table*`} : table*, mem*{mem <- `mem*`} : mem*, elem*{elem <- `elem*`} : elem*, data*{data <- `data*`} : data*)

;; 6-typing.watsup
def $funcidx_nonfuncs(nonfuncs : nonfuncs) : funcidx*
  ;; 6-typing.watsup
  def $funcidx_nonfuncs{`global*` : global*, `table*` : table*, `mem*` : mem*, `elem*` : elem*, `data*` : data*}(`%%%%%`_nonfuncs(global*{global <- `global*`}, table*{table <- `table*`}, mem*{mem <- `mem*`}, elem*{elem <- `elem*`}, data*{data <- `data*`})) = $funcidx_module(MODULE_module([], [], [], global*{global <- `global*`}, table*{table <- `table*`}, mem*{mem <- `mem*`}, [], elem*{elem <- `elem*`}, data*{data <- `data*`}, ?(), []))

;; 6-typing.watsup
relation Module_ok: `|-%:%`(module, moduletype)
  ;; 6-typing.watsup
  rule _{`type*` : type*, `import*` : import*, `func*` : func*, `global*` : global*, `table*` : table*, `mem*` : mem*, `tag*` : tag*, `elem*` : elem*, `data*` : data*, `start?` : start?, `export*` : export*, C : context, `xt_I*` : externtype*, `xt_E*` : externtype*, `dt'*` : deftype*, C' : context, `gt*` : globaltype*, `tt*` : tabletype*, `mt*` : memtype*, `at*` : tagtype*, `dt*` : deftype*, `rt*` : reftype*, `ok*` : datatype*, `nm*` : name*, `tt_I*` : tabletype*, `mt_I*` : memtype*, `at_I*` : tagtype*, `dt_I*` : deftype*, `gt_I*` : globaltype*, `x*` : idx*}:
    `|-%:%`(MODULE_module(type*{type <- `type*`}, import*{import <- `import*`}, func*{func <- `func*`}, global*{global <- `global*`}, table*{table <- `table*`}, mem*{mem <- `mem*`}, tag*{tag <- `tag*`}, elem*{elem <- `elem*`}, data*{data <- `data*`}, start?{start <- `start?`}, export*{export <- `export*`}), $clos_moduletype(C, `%->%`_moduletype(xt_I*{xt_I <- `xt_I*`}, xt_E*{xt_E <- `xt_E*`})))
    -- Types_ok: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, type*{type <- `type*`}, dt'*{dt' <- `dt'*`})
    -- (Import_ok: `%|-%:%`({TYPES dt'*{dt' <- `dt'*`}, RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, import, xt_I))*{import <- `import*`, xt_I <- `xt_I*`}
    -- Globals_ok: `%|-%:%`(C', global*{global <- `global*`}, gt*{gt <- `gt*`})
    -- (Table_ok: `%|-%:%`(C', table, tt))*{table <- `table*`, tt <- `tt*`}
    -- (Mem_ok: `%|-%:%`(C', mem, mt))*{mem <- `mem*`, mt <- `mt*`}
    -- (Tag_ok: `%|-%:%`(C', tag, at))*{at <- `at*`, tag <- `tag*`}
    -- (Func_ok: `%|-%:%`(C, func, dt))*{dt <- `dt*`, func <- `func*`}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem <- `elem*`, rt <- `rt*`}
    -- (Data_ok: `%|-%:%`(C, data, ok))*{data <- `data*`, ok <- `ok*`}
    -- (Start_ok: `%|-%:OK`(C, start))?{start <- `start?`}
    -- (Export_ok: `%|-%:%%`(C, export, nm, xt_E))*{export <- `export*`, nm <- `nm*`, xt_E <- `xt_E*`}
    -- if $disjoint_(syntax name, nm*{nm <- `nm*`})
    -- if (C = C' +++ {TYPES [], RECS [], FUNCS [], GLOBALS gt*{gt <- `gt*`}, TABLES tt_I*{tt_I <- `tt_I*`} ++ tt*{tt <- `tt*`}, MEMS mt_I*{mt_I <- `mt_I*`} ++ mt*{mt <- `mt*`}, TAGS at_I*{at_I <- `at_I*`} ++ at*{at <- `at*`}, ELEMS rt*{rt <- `rt*`}, DATAS ok*{ok <- `ok*`}, LOCALS [], LABELS [], RETURN ?(), REFS []})
    -- if (C' = {TYPES dt'*{dt' <- `dt'*`}, RECS [], FUNCS dt_I*{dt_I <- `dt_I*`} ++ dt*{dt <- `dt*`}, GLOBALS gt_I*{gt_I <- `gt_I*`}, TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS x*{x <- `x*`}})
    -- if (x*{x <- `x*`} = $funcidx_nonfuncs(`%%%%%`_nonfuncs(global*{global <- `global*`}, table*{table <- `table*`}, mem*{mem <- `mem*`}, elem*{elem <- `elem*`}, data*{data <- `data*`})))
    -- if (dt_I*{dt_I <- `dt_I*`} = $funcsxt(xt_I*{xt_I <- `xt_I*`}))
    -- if (gt_I*{gt_I <- `gt_I*`} = $globalsxt(xt_I*{xt_I <- `xt_I*`}))
    -- if (tt_I*{tt_I <- `tt_I*`} = $tablesxt(xt_I*{xt_I <- `xt_I*`}))
    -- if (mt_I*{mt_I <- `mt_I*`} = $memsxt(xt_I*{xt_I <- `xt_I*`}))
    -- if (at_I*{at_I <- `at_I*`} = $tagsxt(xt_I*{xt_I <- `xt_I*`}))

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

  ;; 7-runtime-typing.watsup:35.1-36.38
  rule exn{s : store, a : addr}:
    `%|-%:%`(s, REF.EXN_ADDR_ref(a), REF_reftype(`NULL%?`_nul(?()), EXN_heaptype))

  ;; 7-runtime-typing.watsup:38.1-39.39
  rule host{s : store, a : addr}:
    `%|-%:%`(s, REF.HOST_ADDR_ref(a), REF_reftype(`NULL%?`_nul(?()), ANY_heaptype))

  ;; 7-runtime-typing.watsup:41.1-42.45
  rule extern{s : store, addrref : addrref}:
    `%|-%:%`(s, REF.EXTERN_ref(addrref), REF_reftype(`NULL%?`_nul(?()), EXTERN_heaptype))

  ;; 7-runtime-typing.watsup:44.1-47.34
  rule sub{s : store, ref : ref, rt : reftype, rt' : reftype}:
    `%|-%:%`(s, ref, rt)
    -- Ref_type: `%|-%:%`(s, ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt', rt)
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

;; 7-runtime-typing.watsup:67.1-67.59
relation Externaddr_type: `%|-%:%`(store, externaddr, externtype)
  ;; 7-runtime-typing.watsup:69.1-71.30
  rule func{s : store, a : addr, funcinst : funcinst}:
    `%|-%:%`(s, FUNC_externaddr(a), FUNC_externtype((funcinst.TYPE_funcinst : deftype <: typeuse)))
    -- if (s.FUNCS_store[a] = funcinst)

  ;; 7-runtime-typing.watsup:73.1-75.34
  rule global{s : store, a : addr, globalinst : globalinst}:
    `%|-%:%`(s, GLOBAL_externaddr(a), GLOBAL_externtype(globalinst.TYPE_globalinst))
    -- if (s.GLOBALS_store[a] = globalinst)

  ;; 7-runtime-typing.watsup:77.1-79.32
  rule table{s : store, a : addr, tableinst : tableinst}:
    `%|-%:%`(s, TABLE_externaddr(a), TABLE_externtype(tableinst.TYPE_tableinst))
    -- if (s.TABLES_store[a] = tableinst)

  ;; 7-runtime-typing.watsup:81.1-83.28
  rule mem{s : store, a : addr, meminst : meminst}:
    `%|-%:%`(s, MEM_externaddr(a), MEM_externtype(meminst.TYPE_meminst))
    -- if (s.MEMS_store[a] = meminst)

  ;; 7-runtime-typing.watsup:85.1-87.28
  rule tag{s : store, a : addr, taginst : taginst}:
    `%|-%:%`(s, TAG_externaddr(a), TAG_externtype((taginst.TYPE_taginst : deftype <: typeuse)))
    -- if (s.TAGS_store[a] = taginst)

  ;; 7-runtime-typing.watsup:89.1-92.37
  rule sub{s : store, externaddr : externaddr, xt : externtype, xt' : externtype}:
    `%|-%:%`(s, externaddr, xt)
    -- Externaddr_type: `%|-%:%`(s, externaddr, xt')
    -- Externtype_sub: `%|-%<:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, xt', xt)
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
  rule `select-true`{val_1 : val, val_2 : val, c : num_(I32_numtype), `t*?` : valtype*?}:
    `%~>%`([(val_1 : val <: instr) (val_2 : val <: instr) CONST_instr(I32_numtype, c) `SELECT()%?`_instr(t*{t <- `t*`}?{`t*` <- `t*?`})], [(val_1 : val <: instr)])
    -- if (c =/= `%`_num_(0))

  ;; 8-reduction.watsup
  rule `select-false`{val_1 : val, val_2 : val, c : num_(I32_numtype), `t*?` : valtype*?}:
    `%~>%`([(val_1 : val <: instr) (val_2 : val <: instr) CONST_instr(I32_numtype, c) `SELECT()%?`_instr(t*{t <- `t*`}?{`t*` <- `t*?`})], [(val_2 : val <: instr)])
    -- if (c = `%`_num_(0))

  ;; 8-reduction.watsup
  rule `if-true`{c : num_(I32_numtype), bt : blocktype, `instr_1*` : instr*, `instr_2*` : instr*}:
    `%~>%`([CONST_instr(I32_numtype, c) `IF%%ELSE%`_instr(bt, instr_1*{instr_1 <- `instr_1*`}, instr_2*{instr_2 <- `instr_2*`})], [BLOCK_instr(bt, instr_1*{instr_1 <- `instr_1*`})])
    -- if (c =/= `%`_num_(0))

  ;; 8-reduction.watsup
  rule `if-false`{c : num_(I32_numtype), bt : blocktype, `instr_1*` : instr*, `instr_2*` : instr*}:
    `%~>%`([CONST_instr(I32_numtype, c) `IF%%ELSE%`_instr(bt, instr_1*{instr_1 <- `instr_1*`}, instr_2*{instr_2 <- `instr_2*`})], [BLOCK_instr(bt, instr_2*{instr_2 <- `instr_2*`})])
    -- if (c = `%`_num_(0))

  ;; 8-reduction.watsup
  rule `label-vals`{n : n, `instr*` : instr*, `val*` : val*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr*{instr <- `instr*`}, (val : val <: instr)*{val <- `val*`})], (val : val <: instr)*{val <- `val*`})

  ;; 8-reduction.watsup
  rule `br-label-zero`{n : n, `instr'*` : instr*, `val'*` : val*, `val*` : val*, l : labelidx, `instr*` : instr*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr'*{instr' <- `instr'*`}, (val' : val <: instr)*{val' <- `val'*`} ++ (val : val <: instr)^n{val <- `val*`} ++ [BR_instr(l)] ++ instr*{instr <- `instr*`})], (val : val <: instr)^n{val <- `val*`} ++ instr'*{instr' <- `instr'*`})
    -- if (l = `%`_labelidx(0))

  ;; 8-reduction.watsup
  rule `br-label-succ`{n : n, `instr'*` : instr*, `val*` : val*, l : labelidx, `instr*` : instr*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr'*{instr' <- `instr'*`}, (val : val <: instr)*{val <- `val*`} ++ [BR_instr(l)] ++ instr*{instr <- `instr*`})], (val : val <: instr)*{val <- `val*`} ++ [BR_instr(`%`_labelidx((l!`%`_labelidx.0 - 1)))])
    -- if (l!`%`_labelidx.0 > 0)

  ;; 8-reduction.watsup
  rule `br-handler`{n : n, `catch*` : catch*, `val*` : val*, l : labelidx, `instr*` : instr*}:
    `%~>%`([`HANDLER_%{%}%`_instr(n, catch*{catch <- `catch*`}, (val : val <: instr)*{val <- `val*`} ++ [BR_instr(l)] ++ instr*{instr <- `instr*`})], (val : val <: instr)*{val <- `val*`} ++ [BR_instr(l)])

  ;; 8-reduction.watsup
  rule `br_if-true`{c : num_(I32_numtype), l : labelidx}:
    `%~>%`([CONST_instr(I32_numtype, c) BR_IF_instr(l)], [BR_instr(l)])
    -- if (c =/= `%`_num_(0))

  ;; 8-reduction.watsup
  rule `br_if-false`{c : num_(I32_numtype), l : labelidx}:
    `%~>%`([CONST_instr(I32_numtype, c) BR_IF_instr(l)], [])
    -- if (c = `%`_num_(0))

  ;; 8-reduction.watsup
  rule `br_table-lt`{i : nat, `l*` : labelidx*, l' : labelidx}:
    `%~>%`([CONST_instr(I32_numtype, `%`_num_(i)) BR_TABLE_instr(l*{l <- `l*`}, l')], [BR_instr(l*{l <- `l*`}[i])])
    -- if (i < |l*{l <- `l*`}|)

  ;; 8-reduction.watsup
  rule `br_table-ge`{i : nat, `l*` : labelidx*, l' : labelidx}:
    `%~>%`([CONST_instr(I32_numtype, `%`_num_(i)) BR_TABLE_instr(l*{l <- `l*`}, l')], [BR_instr(l')])
    -- if (i >= |l*{l <- `l*`}|)

  ;; 8-reduction.watsup
  rule `br_on_null-null`{val : val, l : labelidx, ht : heaptype}:
    `%~>%`([(val : val <: instr) BR_ON_NULL_instr(l)], [BR_instr(l)])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup
  rule `br_on_null-addr`{val : val, l : labelidx}:
    `%~>%`([(val : val <: instr) BR_ON_NULL_instr(l)], [(val : val <: instr)])
    -- otherwise

  ;; 8-reduction.watsup
  rule `br_on_non_null-null`{val : val, l : labelidx, ht : heaptype}:
    `%~>%`([(val : val <: instr) BR_ON_NON_NULL_instr(l)], [])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup
  rule `br_on_non_null-addr`{val : val, l : labelidx}:
    `%~>%`([(val : val <: instr) BR_ON_NON_NULL_instr(l)], [(val : val <: instr) BR_instr(l)])
    -- otherwise

  ;; 8-reduction.watsup
  rule call_indirect{x : idx, yy : typeuse}:
    `%~>%`([CALL_INDIRECT_instr(x, yy)], [TABLE.GET_instr(x) REF.CAST_instr(REF_reftype(`NULL%?`_nul(?(())), (yy : typeuse <: heaptype))) CALL_REF_instr(yy)])

  ;; 8-reduction.watsup
  rule return_call_indirect{x : idx, yy : typeuse}:
    `%~>%`([RETURN_CALL_INDIRECT_instr(x, yy)], [TABLE.GET_instr(x) REF.CAST_instr(REF_reftype(`NULL%?`_nul(?(())), (yy : typeuse <: heaptype))) RETURN_CALL_REF_instr(yy)])

  ;; 8-reduction.watsup
  rule `frame-vals`{n : n, f : frame, `val*` : val*}:
    `%~>%`([`FRAME_%{%}%`_instr(n, f, (val : val <: instr)^n{val <- `val*`})], (val : val <: instr)^n{val <- `val*`})

  ;; 8-reduction.watsup
  rule `return-frame`{n : n, f : frame, `val'*` : val*, `val*` : val*, `instr*` : instr*}:
    `%~>%`([`FRAME_%{%}%`_instr(n, f, (val' : val <: instr)*{val' <- `val'*`} ++ (val : val <: instr)^n{val <- `val*`} ++ [RETURN_instr] ++ instr*{instr <- `instr*`})], (val : val <: instr)^n{val <- `val*`})

  ;; 8-reduction.watsup
  rule `return-label`{n : n, `instr'*` : instr*, `val*` : val*, `instr*` : instr*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr'*{instr' <- `instr'*`}, (val : val <: instr)*{val <- `val*`} ++ [RETURN_instr] ++ instr*{instr <- `instr*`})], (val : val <: instr)*{val <- `val*`} ++ [RETURN_instr])

  ;; 8-reduction.watsup
  rule `return-handler`{n : n, `catch*` : catch*, `val*` : val*, `instr*` : instr*}:
    `%~>%`([`HANDLER_%{%}%`_instr(n, catch*{catch <- `catch*`}, (val : val <: instr)*{val <- `val*`} ++ [RETURN_instr] ++ instr*{instr <- `instr*`})], (val : val <: instr)*{val <- `val*`} ++ [RETURN_instr])

  ;; 8-reduction.watsup
  rule `handler-vals`{n : n, `catch*` : catch*, `val*` : val*}:
    `%~>%`([`HANDLER_%{%}%`_instr(n, catch*{catch <- `catch*`}, (val : val <: instr)*{val <- `val*`})], (val : val <: instr)*{val <- `val*`})

  ;; 8-reduction.watsup
  rule `trap-instrs`{`val*` : val*, `instr*` : instr*}:
    `%~>%`((val : val <: instr)*{val <- `val*`} ++ [TRAP_instr] ++ instr*{instr <- `instr*`}, [TRAP_instr])
    -- if ((val*{val <- `val*`} =/= []) \/ (instr*{instr <- `instr*`} =/= []))

  ;; 8-reduction.watsup
  rule `trap-label`{n : n, `instr'*` : instr*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr'*{instr' <- `instr'*`}, [TRAP_instr])], [TRAP_instr])

  ;; 8-reduction.watsup
  rule `trap-frame`{n : n, f : frame}:
    `%~>%`([`FRAME_%{%}%`_instr(n, f, [TRAP_instr])], [TRAP_instr])

  ;; 8-reduction.watsup
  rule `unop-val`{nt : numtype, c_1 : num_(nt), unop : unop_(nt), c : num_(nt)}:
    `%~>%`([CONST_instr(nt, c_1) UNOP_instr(nt, unop)], [CONST_instr(nt, c)])
    -- if c <- $unop_(nt, unop, c_1)

  ;; 8-reduction.watsup
  rule `unop-trap`{nt : numtype, c_1 : num_(nt), unop : unop_(nt)}:
    `%~>%`([CONST_instr(nt, c_1) UNOP_instr(nt, unop)], [TRAP_instr])
    -- if ($unop_(nt, unop, c_1) = [])

  ;; 8-reduction.watsup
  rule `binop-val`{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), binop : binop_(nt), c : num_(nt)}:
    `%~>%`([CONST_instr(nt, c_1) CONST_instr(nt, c_2) BINOP_instr(nt, binop)], [CONST_instr(nt, c)])
    -- if c <- $binop_(nt, binop, c_1, c_2)

  ;; 8-reduction.watsup
  rule `binop-trap`{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), binop : binop_(nt)}:
    `%~>%`([CONST_instr(nt, c_1) CONST_instr(nt, c_2) BINOP_instr(nt, binop)], [TRAP_instr])
    -- if ($binop_(nt, binop, c_1, c_2) = [])

  ;; 8-reduction.watsup
  rule testop{nt : numtype, c_1 : num_(nt), testop : testop_(nt), c : num_(I32_numtype)}:
    `%~>%`([CONST_instr(nt, c_1) TESTOP_instr(nt, testop)], [CONST_instr(I32_numtype, c)])
    -- if (c = $testop_(nt, testop, c_1))

  ;; 8-reduction.watsup
  rule relop{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), relop : relop_(nt), c : num_(I32_numtype)}:
    `%~>%`([CONST_instr(nt, c_1) CONST_instr(nt, c_2) RELOP_instr(nt, relop)], [CONST_instr(I32_numtype, c)])
    -- if (c = $relop_(nt, relop, c_1, c_2))

  ;; 8-reduction.watsup
  rule `cvtop-val`{nt_1 : numtype, c_1 : num_(nt_1), nt_2 : numtype, cvtop : cvtop__(nt_1, nt_2), c : num_(nt_2)}:
    `%~>%`([CONST_instr(nt_1, c_1) CVTOP_instr(nt_2, nt_1, cvtop)], [CONST_instr(nt_2, c)])
    -- if c <- $cvtop__(nt_1, nt_2, cvtop, c_1)

  ;; 8-reduction.watsup
  rule `cvtop-trap`{nt_1 : numtype, c_1 : num_(nt_1), nt_2 : numtype, cvtop : cvtop__(nt_1, nt_2)}:
    `%~>%`([CONST_instr(nt_1, c_1) CVTOP_instr(nt_2, nt_1, cvtop)], [TRAP_instr])
    -- if ($cvtop__(nt_1, nt_2, cvtop, c_1) = [])

  ;; 8-reduction.watsup
  rule ref.i31{i : nat}:
    `%~>%`([CONST_instr(I32_numtype, `%`_num_(i)) REF.I31_instr], [REF.I31_NUM_instr($wrap__(32, 31, `%`_iN(i)))])

  ;; 8-reduction.watsup
  rule `ref.is_null-true`{ref : ref, ht : heaptype}:
    `%~>%`([(ref : ref <: instr) REF.IS_NULL_instr], [CONST_instr(I32_numtype, `%`_num_(1))])
    -- if (ref = REF.NULL_ref(ht))

  ;; 8-reduction.watsup
  rule `ref.is_null-false`{ref : ref}:
    `%~>%`([(ref : ref <: instr) REF.IS_NULL_instr], [CONST_instr(I32_numtype, `%`_num_(0))])
    -- otherwise

  ;; 8-reduction.watsup
  rule `ref.as_non_null-null`{ref : ref, ht : heaptype}:
    `%~>%`([(ref : ref <: instr) REF.AS_NON_NULL_instr], [TRAP_instr])
    -- if (ref = REF.NULL_ref(ht))

  ;; 8-reduction.watsup
  rule `ref.as_non_null-addr`{ref : ref}:
    `%~>%`([(ref : ref <: instr) REF.AS_NON_NULL_instr], [(ref : ref <: instr)])
    -- otherwise

  ;; 8-reduction.watsup
  rule `ref.eq-null`{ref_1 : ref, ref_2 : ref, ht_1 : heaptype, ht_2 : heaptype}:
    `%~>%`([(ref_1 : ref <: instr) (ref_2 : ref <: instr) REF.EQ_instr], [CONST_instr(I32_numtype, `%`_num_(1))])
    -- if ((ref_1 = REF.NULL_ref(ht_1)) /\ (ref_2 = REF.NULL_ref(ht_2)))

  ;; 8-reduction.watsup
  rule `ref.eq-true`{ref_1 : ref, ref_2 : ref}:
    `%~>%`([(ref_1 : ref <: instr) (ref_2 : ref <: instr) REF.EQ_instr], [CONST_instr(I32_numtype, `%`_num_(1))])
    -- otherwise
    -- if (ref_1 = ref_2)

  ;; 8-reduction.watsup
  rule `ref.eq-false`{ref_1 : ref, ref_2 : ref}:
    `%~>%`([(ref_1 : ref <: instr) (ref_2 : ref <: instr) REF.EQ_instr], [CONST_instr(I32_numtype, `%`_num_(0))])
    -- otherwise

  ;; 8-reduction.watsup
  rule `i31.get-null`{ht : heaptype, sx : sx}:
    `%~>%`([REF.NULL_instr(ht) I31.GET_instr(sx)], [TRAP_instr])

  ;; 8-reduction.watsup
  rule `i31.get-num`{i : nat, sx : sx}:
    `%~>%`([REF.I31_NUM_instr(`%`_u31(i)) I31.GET_instr(sx)], [CONST_instr(I32_numtype, $extend__(31, 32, sx, `%`_iN(i)))])

  ;; 8-reduction.watsup
  rule array.new{val : val, n : n, x : idx}:
    `%~>%`([(val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_instr(x)], (val : val <: instr)^n{} ++ [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))])

  ;; 8-reduction.watsup
  rule `extern.convert_any-null`{ht : heaptype}:
    `%~>%`([REF.NULL_instr(ht) EXTERN.CONVERT_ANY_instr], [REF.NULL_instr(EXTERN_heaptype)])

  ;; 8-reduction.watsup
  rule `extern.convert_any-addr`{addrref : addrref}:
    `%~>%`([(addrref : addrref <: instr) EXTERN.CONVERT_ANY_instr], [REF.EXTERN_instr(addrref)])

  ;; 8-reduction.watsup
  rule `any.convert_extern-null`{ht : heaptype}:
    `%~>%`([REF.NULL_instr(ht) ANY.CONVERT_EXTERN_instr], [REF.NULL_instr(ANY_heaptype)])

  ;; 8-reduction.watsup
  rule `any.convert_extern-addr`{addrref : addrref}:
    `%~>%`([REF.EXTERN_instr(addrref) ANY.CONVERT_EXTERN_instr], [(addrref : addrref <: instr)])

  ;; 8-reduction.watsup
  rule vvunop{c_1 : vec_(V128_Vnn), vvunop : vvunop, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VVUNOP_instr(V128_vectype, vvunop)], [VCONST_instr(V128_vectype, c)])
    -- if c <- $vvunop_(V128_vectype, vvunop, c_1)

  ;; 8-reduction.watsup
  rule vvbinop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), vvbinop : vvbinop, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VVBINOP_instr(V128_vectype, vvbinop)], [VCONST_instr(V128_vectype, c)])
    -- if c <- $vvbinop_(V128_vectype, vvbinop, c_1, c_2)

  ;; 8-reduction.watsup
  rule vvternop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c_3 : vec_(V128_Vnn), vvternop : vvternop, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VCONST_instr(V128_vectype, c_3) VVTERNOP_instr(V128_vectype, vvternop)], [VCONST_instr(V128_vectype, c)])
    -- if c <- $vvternop_(V128_vectype, vvternop, c_1, c_2, c_3)

  ;; 8-reduction.watsup
  rule vvtestop{c_1 : vec_(V128_Vnn), c : num_(I32_numtype)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VVTESTOP_instr(V128_vectype, ANY_TRUE_vvtestop)], [CONST_instr(I32_numtype, c)])
    -- if (c = $ine_($vsize(V128_vectype), c_1, `%`_iN(0)))

  ;; 8-reduction.watsup
  rule `vunop-val`{c_1 : vec_(V128_Vnn), sh : shape, vunop : vunop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VUNOP_instr(sh, vunop)], [VCONST_instr(V128_vectype, c)])
    -- if c <- $vunop_(sh, vunop, c_1)

  ;; 8-reduction.watsup
  rule `vunop-trap`{c_1 : vec_(V128_Vnn), sh : shape, vunop : vunop_(sh)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VUNOP_instr(sh, vunop)], [TRAP_instr])
    -- if ($vunop_(sh, vunop, c_1) = [])

  ;; 8-reduction.watsup
  rule `vbinop-val`{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh : shape, vbinop : vbinop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VBINOP_instr(sh, vbinop)], [VCONST_instr(V128_vectype, c)])
    -- if c <- $vbinop_(sh, vbinop, c_1, c_2)

  ;; 8-reduction.watsup
  rule `vbinop-trap`{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh : shape, vbinop : vbinop_(sh)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VBINOP_instr(sh, vbinop)], [TRAP_instr])
    -- if ($vbinop_(sh, vbinop, c_1, c_2) = [])

  ;; 8-reduction.watsup
  rule `vternop-val`{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c_3 : vec_(V128_Vnn), sh : shape, vternop : vternop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VCONST_instr(V128_vectype, c_3) VTERNOP_instr(sh, vternop)], [VCONST_instr(V128_vectype, c)])
    -- if c <- $vternop_(sh, vternop, c_1, c_2, c_3)

  ;; 8-reduction.watsup
  rule `vternop-trap`{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c_3 : vec_(V128_Vnn), sh : shape, vternop : vternop_(sh)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VCONST_instr(V128_vectype, c_3) VTERNOP_instr(sh, vternop)], [TRAP_instr])
    -- if ($vternop_(sh, vternop, c_1, c_2, c_3) = [])

  ;; 8-reduction.watsup
  rule vtestop{c_1 : vec_(V128_Vnn), sh : shape, vtestop : vtestop_(sh), i : nat}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VTESTOP_instr(sh, vtestop)], [CONST_instr(I32_numtype, `%`_num_(i))])
    -- if ($vtestop_(sh, vtestop, c_1) = `%`_u32(i))

  ;; 8-reduction.watsup
  rule vrelop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh : shape, vrelop : vrelop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VRELOP_instr(sh, vrelop)], [VCONST_instr(V128_vectype, c)])
    -- if ($vrelop_(sh, vrelop, c_1, c_2) = c)

  ;; 8-reduction.watsup
  rule vshiftop{c_1 : vec_(V128_Vnn), n : n, Jnn : Jnn, M : M, vshiftop : vshiftop_(`%X%`_ishape(Jnn, `%`_dim(M))), c : vec_(V128_Vnn), `c'*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) CONST_instr(I32_numtype, `%`_num_(n)) VSHIFTOP_instr(`%X%`_ishape(Jnn, `%`_dim(M)), vshiftop)], [VCONST_instr(V128_vectype, c)])
    -- if (c'*{c' <- `c'*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c_1))
    -- if (c = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), $vshiftop_(`%X%`_ishape(Jnn, `%`_dim(M)), vshiftop, c', `%`_u32(n))*{c' <- `c'*`}))

  ;; 8-reduction.watsup
  rule vbitmask{c : vec_(V128_Vnn), Jnn : Jnn, M : M, ci : num_(I32_numtype), `ci_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}:
    `%~>%`([VCONST_instr(V128_vectype, c) VBITMASK_instr(`%X%`_ishape(Jnn, `%`_dim(M)))], [CONST_instr(I32_numtype, ci)])
    -- if (ci_1*{ci_1 <- `ci_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c))
    -- if ($ibits_(32, ci) = `%`_bit($ilt_($lsize((Jnn : Jnn <: lanetype)), S_sx, ci_1, `%`_iN(0))!`%`_u32.0)*{ci_1 <- `ci_1*`})

  ;; 8-reduction.watsup
  rule `vswizzlop-swizzle`{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), M : M, c : vec_(V128_Vnn), `c'*` : iN(8)*, `ci*` : lane_($lanetype(`%X%`_shape(I8_lanetype, `%`_dim(M))))*, `k*` : nat*}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VSWIZZLOP_instr(`%X%`_ishape(I8_Jnn, `%`_dim(M)), SWIZZLE_vswizzlop_)], [VCONST_instr(V128_vectype, c)])
    -- if (ci*{ci <- `ci*`} = $lanes_(`%X%`_shape(I8_lanetype, `%`_dim(M)), c_2))
    -- if (c'*{c' <- `c'*`} = $lanes_(`%X%`_shape(I8_lanetype, `%`_dim(M)), c_1) ++ `%`_iN(0)^(256 - M){})
    -- if (c = $invlanes_(`%X%`_shape(I8_lanetype, `%`_dim(M)), c'*{c' <- `c'*`}[ci*{ci <- `ci*`}[k]!`%`_lane_.0]^(k<M){k <- `k*`}))

  ;; 8-reduction.watsup
  rule `vswizzlop-relaxed_swizzle`{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), M : M, c : vec_(V128_Vnn), `c'*` : iN(8)*, `ci*` : lane_($lanetype(`%X%`_shape(I8_lanetype, `%`_dim(M))))*, `k*` : nat*}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VSWIZZLOP_instr(`%X%`_ishape(I8_Jnn, `%`_dim(M)), RELAXED_SWIZZLE_vswizzlop_)], [VCONST_instr(V128_vectype, c)])
    -- if (ci*{ci <- `ci*`} = $lanes_(`%X%`_shape(I8_lanetype, `%`_dim(M)), c_2))
    -- if (c'*{c' <- `c'*`} = $lanes_(`%X%`_shape(I8_lanetype, `%`_dim(M)), c_1) ++ `%`_iN(0)^(256 - M){})
    -- if (c = $invlanes_(`%X%`_shape(I8_lanetype, `%`_dim(M)), c'*{c' <- `c'*`}[ci*{ci <- `ci*`}[k]!`%`_lane_.0]^(k<M){k <- `k*`}))

  ;; 8-reduction.watsup
  rule vshuffle{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), Pnn : Pnn, M : M, `i*` : nat*, c : vec_(V128_Vnn), `c'*` : iN($lsize((Pnn : Pnn <: lanetype)))*, `k*` : nat*}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VSHUFFLE_instr(`%X%`_ishape((Pnn : Pnn <: Jnn), `%`_dim(M)), `%`_laneidx(i)*{i <- `i*`})], [VCONST_instr(V128_vectype, c)])
    -- if (c'*{c' <- `c'*`} = $lanes_(`%X%`_shape((Pnn : Pnn <: lanetype), `%`_dim(M)), c_1) ++ $lanes_(`%X%`_shape((Pnn : Pnn <: lanetype), `%`_dim(M)), c_2))
    -- if (c = $invlanes_(`%X%`_shape((Pnn : Pnn <: lanetype), `%`_dim(M)), c'*{c' <- `c'*`}[i*{i <- `i*`}[k]]^(k<M){k <- `k*`}))

  ;; 8-reduction.watsup
  rule vsplat{Lnn : Lnn, c_1 : num_($lunpack(Lnn)), M : M, c : vec_(V128_Vnn)}:
    `%~>%`([CONST_instr($lunpack(Lnn), c_1) VSPLAT_instr(`%X%`_shape(Lnn, `%`_dim(M)))], [VCONST_instr(V128_vectype, c)])
    -- if (c = $invlanes_(`%X%`_shape(Lnn, `%`_dim(M)), $lpacknum_(Lnn, c_1)^M{}))

  ;; 8-reduction.watsup
  rule `vextract_lane-num`{c_1 : vec_(V128_Vnn), nt : numtype, M : M, i : nat, c_2 : num_(nt)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VEXTRACT_LANE_instr(`%X%`_shape((nt : numtype <: lanetype), `%`_dim(M)), ?(), `%`_laneidx(i))], [CONST_instr(nt, c_2)])
    -- if (c_2 = $lanes_(`%X%`_shape((nt : numtype <: lanetype), `%`_dim(M)), c_1)[i])

  ;; 8-reduction.watsup
  rule `vextract_lane-pack`{c_1 : vec_(V128_Vnn), pt : packtype, M : M, sx : sx, i : nat, c_2 : num_(I32_numtype)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VEXTRACT_LANE_instr(`%X%`_shape((pt : packtype <: lanetype), `%`_dim(M)), ?(sx), `%`_laneidx(i))], [CONST_instr(I32_numtype, c_2)])
    -- if (c_2 = $extend__($psize(pt), 32, sx, $lanes_(`%X%`_shape((pt : packtype <: lanetype), `%`_dim(M)), c_1)[i]))

  ;; 8-reduction.watsup
  rule vreplace_lane{c_1 : vec_(V128_Vnn), Lnn : Lnn, c_2 : num_($lunpack(Lnn)), M : M, i : nat, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) CONST_instr($lunpack(Lnn), c_2) VREPLACE_LANE_instr(`%X%`_shape(Lnn, `%`_dim(M)), `%`_laneidx(i))], [VCONST_instr(V128_vectype, c)])
    -- if (c = $invlanes_(`%X%`_shape(Lnn, `%`_dim(M)), $lanes_(`%X%`_shape(Lnn, `%`_dim(M)), c_1)[[i] = $lpacknum_(Lnn, c_2)]))

  ;; 8-reduction.watsup
  rule vextunop{c_1 : vec_(V128_Vnn), sh_2 : ishape, sh_1 : ishape, vextunop : vextunop__(sh_1, sh_2), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VEXTUNOP_instr(sh_2, sh_1, vextunop)], [VCONST_instr(V128_vectype, c)])
    -- if ($vextunop__(sh_1, sh_2, vextunop, c_1) = c)

  ;; 8-reduction.watsup
  rule vextbinop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh_2 : ishape, sh_1 : ishape, vextbinop : vextbinop__(sh_1, sh_2), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VEXTBINOP_instr(sh_2, sh_1, vextbinop)], [VCONST_instr(V128_vectype, c)])
    -- if ($vextbinop__(sh_1, sh_2, vextbinop, c_1, c_2) = c)

  ;; 8-reduction.watsup
  rule vextternop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c_3 : vec_(V128_Vnn), sh_2 : ishape, sh_1 : ishape, vextternop : vextternop__(sh_1, sh_2), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VCONST_instr(V128_vectype, c_3) VEXTTERNOP_instr(sh_2, sh_1, vextternop)], [VCONST_instr(V128_vectype, c)])
    -- if ($vextternop__(sh_1, sh_2, vextternop, c_1, c_2, c_3) = c)

  ;; 8-reduction.watsup
  rule vnarrow{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), Jnn_2 : Jnn, M_2 : M, Jnn_1 : Jnn, M_1 : M, sx : sx, c : vec_(V128_Vnn), `ci_1*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `ci_2*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `cj_1*` : iN($lsize((Jnn_2 : Jnn <: lanetype)))*, `cj_2*` : iN($lsize((Jnn_2 : Jnn <: lanetype)))*}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VNARROW_instr(`%X%`_ishape(Jnn_2, `%`_dim(M_2)), `%X%`_ishape(Jnn_1, `%`_dim(M_1)), sx)], [VCONST_instr(V128_vectype, c)])
    -- if (ci_1*{ci_1 <- `ci_1*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), c_1))
    -- if (ci_2*{ci_2 <- `ci_2*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), c_2))
    -- if (cj_1*{cj_1 <- `cj_1*`} = $narrow__($lsize((Jnn_1 : Jnn <: lanetype)), $lsize((Jnn_2 : Jnn <: lanetype)), sx, ci_1)*{ci_1 <- `ci_1*`})
    -- if (cj_2*{cj_2 <- `cj_2*`} = $narrow__($lsize((Jnn_1 : Jnn <: lanetype)), $lsize((Jnn_2 : Jnn <: lanetype)), sx, ci_2)*{ci_2 <- `ci_2*`})
    -- if (c = $invlanes_(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), cj_1*{cj_1 <- `cj_1*`} ++ cj_2*{cj_2 <- `cj_2*`}))

  ;; 8-reduction.watsup
  rule `vcvtop-full`{c_1 : vec_(V128_Vnn), Lnn_2 : Lnn, M : M, Lnn_1 : Lnn, vcvtop : vcvtop__(`%X%`_shape(Lnn_1, `%`_dim(M)), `%X%`_shape(Lnn_2, `%`_dim(M))), c : vec_(V128_Vnn), `ci*` : lane_($lanetype(`%X%`_shape(Lnn_1, `%`_dim(M))))*, `cj**` : lane_(Lnn_2)**}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCVTOP_instr(`%X%`_shape(Lnn_2, `%`_dim(M)), `%X%`_shape(Lnn_1, `%`_dim(M)), vcvtop, ?(), ?())], [VCONST_instr(V128_vectype, c)])
    -- if (ci*{ci <- `ci*`} = $lanes_(`%X%`_shape(Lnn_1, `%`_dim(M)), c_1))
    -- if (cj*{cj <- `cj*`}*{`cj*` <- `cj**`} = $setproduct_(syntax lane_(Lnn_2), $vcvtop__(`%X%`_shape(Lnn_1, `%`_dim(M)), `%X%`_shape(Lnn_2, `%`_dim(M)), vcvtop, ci)*{ci <- `ci*`}))
    -- if c <- $invlanes_(`%X%`_shape(Lnn_2, `%`_dim(M)), cj*{cj <- `cj*`})*{`cj*` <- `cj**`}

  ;; 8-reduction.watsup
  rule `vcvtop-half`{c_1 : vec_(V128_Vnn), Lnn_2 : Lnn, M_2 : M, Lnn_1 : Lnn, M_1 : M, vcvtop : vcvtop__(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2))), half : half__(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2))), c : vec_(V128_Vnn), `ci*` : lane_($lanetype(`%X%`_shape(Lnn_1, `%`_dim(M_1))))*, `cj**` : lane_(Lnn_2)**}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCVTOP_instr(`%X%`_shape(Lnn_2, `%`_dim(M_2)), `%X%`_shape(Lnn_1, `%`_dim(M_1)), vcvtop, ?(half), ?())], [VCONST_instr(V128_vectype, c)])
    -- if (ci*{ci <- `ci*`} = $lanes_(`%X%`_shape(Lnn_1, `%`_dim(M_1)), c_1)[$half__(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2)), half, 0, M_2) : M_2])
    -- if (cj*{cj <- `cj*`}*{`cj*` <- `cj**`} = $setproduct_(syntax lane_(Lnn_2), $vcvtop__(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2)), vcvtop, ci)*{ci <- `ci*`}))
    -- if c <- $invlanes_(`%X%`_shape(Lnn_2, `%`_dim(M_2)), cj*{cj <- `cj*`})*{`cj*` <- `cj**`}

  ;; 8-reduction.watsup
  rule `vcvtop-zero`{c_1 : vec_(V128_Vnn), nt_2 : numtype, M_2 : M, nt_1 : numtype, M_1 : M, vcvtop : vcvtop__(`%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(M_1)), `%X%`_shape((nt_2 : numtype <: lanetype), `%`_dim(M_2))), zero : zero__(`%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(M_1)), `%X%`_shape((nt_2 : numtype <: lanetype), `%`_dim(M_2))), c : vec_(V128_Vnn), `ci*` : lane_($lanetype(`%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(M_1))))*, `cj**` : lane_((nt_2 : numtype <: lanetype))**}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCVTOP_instr(`%X%`_shape((nt_2 : numtype <: lanetype), `%`_dim(M_2)), `%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(M_1)), vcvtop, ?(), ?(zero))], [VCONST_instr(V128_vectype, c)])
    -- if (ci*{ci <- `ci*`} = $lanes_(`%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(M_1)), c_1))
    -- if (cj*{cj <- `cj*`}*{`cj*` <- `cj**`} = $setproduct_(syntax lane_((nt_2 : numtype <: lanetype)), $vcvtop__(`%X%`_shape((nt_1 : numtype <: lanetype), `%`_dim(M_1)), `%X%`_shape((nt_2 : numtype <: lanetype), `%`_dim(M_2)), vcvtop, ci)*{ci <- `ci*`} ++ [$zero(nt_2)]^M_1{}))
    -- if c <- $invlanes_(`%X%`_shape((nt_2 : numtype <: lanetype), `%`_dim(M_2)), cj*{cj <- `cj*`})*{`cj*` <- `cj**`}

  ;; 8-reduction.watsup
  rule local.tee{val : val, x : idx}:
    `%~>%`([(val : val <: instr) LOCAL.TEE_instr(x)], [(val : val <: instr) (val : val <: instr) LOCAL.SET_instr(x)])

;; 8-reduction.watsup
def $blocktype_(state : state, blocktype : blocktype) : functype
  ;; 8-reduction.watsup
  def $blocktype_{z : state, x : idx, ft : functype}(z, _IDX_blocktype(x)) = ft
    -- Expand: `%~~%`($type(z, x), FUNC_comptype(ft))
  ;; 8-reduction.watsup
  def $blocktype_{z : state, `t?` : valtype?}(z, _RESULT_blocktype(t?{t <- `t?`})) = `%->%`_functype(`%`_resulttype([]), `%`_resulttype(t?{t <- `t?`}))

;; 8-reduction.watsup
relation Step_read: `%~>%`(config, instr*)
  ;; 8-reduction.watsup
  rule block{z : state, `val*` : val*, m : m, bt : blocktype, `instr*` : instr*, n : n, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^m{val <- `val*`} ++ [BLOCK_instr(bt, instr*{instr <- `instr*`})]), [`LABEL_%{%}%`_instr(n, [], (val : val <: instr)^m{val <- `val*`} ++ instr*{instr <- `instr*`})])
    -- if ($blocktype_(z, bt) = `%->%`_functype(`%`_resulttype(t_1^m{t_1 <- `t_1*`}), `%`_resulttype(t_2^n{t_2 <- `t_2*`})))

  ;; 8-reduction.watsup
  rule loop{z : state, `val*` : val*, m : m, bt : blocktype, `instr*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*, n : n}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^m{val <- `val*`} ++ [LOOP_instr(bt, instr*{instr <- `instr*`})]), [`LABEL_%{%}%`_instr(m, [LOOP_instr(bt, instr*{instr <- `instr*`})], (val : val <: instr)^m{val <- `val*`} ++ instr*{instr <- `instr*`})])
    -- if ($blocktype_(z, bt) = `%->%`_functype(`%`_resulttype(t_1^m{t_1 <- `t_1*`}), `%`_resulttype(t_2^n{t_2 <- `t_2*`})))

  ;; 8-reduction.watsup
  rule `br_on_cast-succeed`{s : store, f : frame, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype, rt : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) BR_ON_CAST_instr(l, rt_1, rt_2)]), [(ref : ref <: instr) BR_instr(l)])
    -- Ref_type: `%|-%:%`(s, ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt, $inst_reftype(f.MODULE_frame, rt_2))

  ;; 8-reduction.watsup
  rule `br_on_cast-fail`{s : store, f : frame, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) BR_ON_CAST_instr(l, rt_1, rt_2)]), [(ref : ref <: instr)])
    -- otherwise

  ;; 8-reduction.watsup
  rule `br_on_cast_fail-succeed`{s : store, f : frame, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype, rt : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) BR_ON_CAST_FAIL_instr(l, rt_1, rt_2)]), [(ref : ref <: instr)])
    -- Ref_type: `%|-%:%`(s, ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt, $inst_reftype(f.MODULE_frame, rt_2))

  ;; 8-reduction.watsup
  rule `br_on_cast_fail-fail`{s : store, f : frame, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) BR_ON_CAST_FAIL_instr(l, rt_1, rt_2)]), [(ref : ref <: instr) BR_instr(l)])
    -- otherwise

  ;; 8-reduction.watsup
  rule call{z : state, x : idx, a : addr}:
    `%~>%`(`%;%`_config(z, [CALL_instr(x)]), [REF.FUNC_ADDR_instr(a) CALL_REF_instr(($funcinst(z)[a].TYPE_funcinst : deftype <: typeuse))])
    -- if ($moduleinst(z).FUNCS_moduleinst[x!`%`_idx.0] = a)

  ;; 8-reduction.watsup
  rule `call_ref-null`{z : state, ht : heaptype, yy : typeuse}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CALL_REF_instr(yy)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule `call_ref-func`{z : state, `val*` : val*, n : n, a : addr, yy : typeuse, m : m, f : frame, `instr*` : instr*, fi : funcinst, `t_1*` : valtype*, `t_2*` : valtype*, x : idx, `t*` : valtype*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^n{val <- `val*`} ++ [REF.FUNC_ADDR_instr(a) CALL_REF_instr(yy)]), [`FRAME_%{%}%`_instr(m, f, [`LABEL_%{%}%`_instr(m, [], instr*{instr <- `instr*`})])])
    -- if ($funcinst(z)[a] = fi)
    -- Expand: `%~~%`(fi.TYPE_funcinst, FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1^n{t_1 <- `t_1*`}), `%`_resulttype(t_2^m{t_2 <- `t_2*`}))))
    -- if (fi.CODE_funcinst = FUNC_funccode(x, LOCAL_local(t)*{t <- `t*`}, instr*{instr <- `instr*`}))
    -- if (f = {LOCALS ?(val)^n{val <- `val*`} ++ $default_(t)*{t <- `t*`}, MODULE fi.MODULE_funcinst})

  ;; 8-reduction.watsup
  rule return_call{z : state, x : idx, a : addr}:
    `%~>%`(`%;%`_config(z, [RETURN_CALL_instr(x)]), [REF.FUNC_ADDR_instr(a) RETURN_CALL_REF_instr(($funcinst(z)[a].TYPE_funcinst : deftype <: typeuse))])
    -- if ($moduleinst(z).FUNCS_moduleinst[x!`%`_idx.0] = a)

  ;; 8-reduction.watsup
  rule `return_call_ref-label`{z : state, k : nat, `instr'*` : instr*, `val*` : val*, yy : typeuse, `instr*` : instr*}:
    `%~>%`(`%;%`_config(z, [`LABEL_%{%}%`_instr(k, instr'*{instr' <- `instr'*`}, (val : val <: instr)*{val <- `val*`} ++ [RETURN_CALL_REF_instr(yy)] ++ instr*{instr <- `instr*`})]), (val : val <: instr)*{val <- `val*`} ++ [RETURN_CALL_REF_instr(yy)])

  ;; 8-reduction.watsup
  rule `return_call_ref-handler`{z : state, k : nat, `catch*` : catch*, `val*` : val*, yy : typeuse, `instr*` : instr*}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(k, catch*{catch <- `catch*`}, (val : val <: instr)*{val <- `val*`} ++ [RETURN_CALL_REF_instr(yy)] ++ instr*{instr <- `instr*`})]), (val : val <: instr)*{val <- `val*`} ++ [RETURN_CALL_REF_instr(yy)])

  ;; 8-reduction.watsup
  rule `return_call_ref-frame-null`{z : state, k : nat, f : frame, `val*` : val*, ht : heaptype, yy : typeuse, `instr*` : instr*}:
    `%~>%`(`%;%`_config(z, [`FRAME_%{%}%`_instr(k, f, (val : val <: instr)*{val <- `val*`} ++ [REF.NULL_instr(ht)] ++ [RETURN_CALL_REF_instr(yy)] ++ instr*{instr <- `instr*`})]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule `return_call_ref-frame-addr`{z : state, k : nat, f : frame, `val'*` : val*, `val*` : val*, n : n, a : addr, yy : typeuse, `instr*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*, m : m}:
    `%~>%`(`%;%`_config(z, [`FRAME_%{%}%`_instr(k, f, (val' : val <: instr)*{val' <- `val'*`} ++ (val : val <: instr)^n{val <- `val*`} ++ [REF.FUNC_ADDR_instr(a)] ++ [RETURN_CALL_REF_instr(yy)] ++ instr*{instr <- `instr*`})]), (val : val <: instr)^n{val <- `val*`} ++ [REF.FUNC_ADDR_instr(a) CALL_REF_instr(yy)])
    -- Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1^n{t_1 <- `t_1*`}), `%`_resulttype(t_2^m{t_2 <- `t_2*`}))))

  ;; 8-reduction.watsup
  rule `throw_ref-null`{z : state, ht : heaptype}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) THROW_REF_instr]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule `throw_ref-instrs`{z : state, `val*` : val*, a : addr, `instr*` : instr*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)*{val <- `val*`} ++ [REF.EXN_ADDR_instr(a)] ++ [THROW_REF_instr] ++ instr*{instr <- `instr*`}), [REF.EXN_ADDR_instr(a) THROW_REF_instr])
    -- if ((val*{val <- `val*`} =/= []) \/ (instr*{instr <- `instr*`} =/= []))

  ;; 8-reduction.watsup
  rule `throw_ref-label`{z : state, n : n, `instr'*` : instr*, a : addr}:
    `%~>%`(`%;%`_config(z, [`LABEL_%{%}%`_instr(n, instr'*{instr' <- `instr'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), [REF.EXN_ADDR_instr(a) THROW_REF_instr])

  ;; 8-reduction.watsup
  rule `throw_ref-frame`{z : state, n : n, f : frame, a : addr}:
    `%~>%`(`%;%`_config(z, [`FRAME_%{%}%`_instr(n, f, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), [REF.EXN_ADDR_instr(a) THROW_REF_instr])

  ;; 8-reduction.watsup
  rule `throw_ref-handler-empty`{z : state, n : n, a : addr}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(n, [], [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), [REF.EXN_ADDR_instr(a) THROW_REF_instr])

  ;; 8-reduction.watsup
  rule `throw_ref-handler-catch`{z : state, n : n, x : idx, l : labelidx, `catch'*` : catch*, a : addr, `val*` : val*}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(n, [CATCH_catch(x, l)] ++ catch'*{catch' <- `catch'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), (val : val <: instr)*{val <- `val*`} ++ [BR_instr(l)])
    -- if ($exninst(z)[a].TAG_exninst = $tagaddr(z)[x!`%`_idx.0])
    -- if (val*{val <- `val*`} = $exninst(z)[a].FIELDS_exninst)

  ;; 8-reduction.watsup
  rule `throw_ref-handler-catch_ref`{z : state, n : n, x : idx, l : labelidx, `catch'*` : catch*, a : addr, `val*` : val*}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(n, [CATCH_REF_catch(x, l)] ++ catch'*{catch' <- `catch'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), (val : val <: instr)*{val <- `val*`} ++ [REF.EXN_ADDR_instr(a) BR_instr(l)])
    -- if ($exninst(z)[a].TAG_exninst = $tagaddr(z)[x!`%`_idx.0])
    -- if (val*{val <- `val*`} = $exninst(z)[a].FIELDS_exninst)

  ;; 8-reduction.watsup
  rule `throw_ref-handler-catch_all`{z : state, n : n, l : labelidx, `catch'*` : catch*, a : addr}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(n, [CATCH_ALL_catch(l)] ++ catch'*{catch' <- `catch'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), [BR_instr(l)])

  ;; 8-reduction.watsup
  rule `throw_ref-handler-catch_all_ref`{z : state, n : n, l : labelidx, `catch'*` : catch*, a : addr}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(n, [CATCH_ALL_REF_catch(l)] ++ catch'*{catch' <- `catch'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), [REF.EXN_ADDR_instr(a) BR_instr(l)])

  ;; 8-reduction.watsup
  rule `throw_ref-handler-next`{z : state, n : n, catch : catch, `catch'*` : catch*, a : addr}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(n, [catch] ++ catch'*{catch' <- `catch'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), [`HANDLER_%{%}%`_instr(n, catch'*{catch' <- `catch'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])])
    -- otherwise

  ;; 8-reduction.watsup
  rule try_table{z : state, `val*` : val*, m : m, bt : blocktype, `catch*` : catch*, `instr*` : instr*, n : n, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^m{val <- `val*`} ++ [TRY_TABLE_instr(bt, `%`_list(catch*{catch <- `catch*`}), instr*{instr <- `instr*`})]), [`HANDLER_%{%}%`_instr(n, catch*{catch <- `catch*`}, [`LABEL_%{%}%`_instr(n, [], (val : val <: instr)^m{val <- `val*`} ++ instr*{instr <- `instr*`})])])
    -- if ($blocktype_(z, bt) = `%->%`_functype(`%`_resulttype(t_1^m{t_1 <- `t_1*`}), `%`_resulttype(t_2^n{t_2 <- `t_2*`})))

  ;; 8-reduction.watsup
  rule `ref.null-idx`{z : state, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(_IDX_heaptype(x))]), [REF.NULL_instr(($type(z, x) : deftype <: heaptype))])

  ;; 8-reduction.watsup
  rule ref.func{z : state, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.FUNC_instr(x)]), [REF.FUNC_ADDR_instr($moduleinst(z).FUNCS_moduleinst[x!`%`_idx.0])])

  ;; 8-reduction.watsup
  rule `ref.test-true`{s : store, f : frame, ref : ref, rt : reftype, rt' : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) REF.TEST_instr(rt)]), [CONST_instr(I32_numtype, `%`_num_(1))])
    -- Ref_type: `%|-%:%`(s, ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt', $inst_reftype(f.MODULE_frame, rt))

  ;; 8-reduction.watsup
  rule `ref.test-false`{s : store, f : frame, ref : ref, rt : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) REF.TEST_instr(rt)]), [CONST_instr(I32_numtype, `%`_num_(0))])
    -- otherwise

  ;; 8-reduction.watsup
  rule `ref.cast-succeed`{s : store, f : frame, ref : ref, rt : reftype, rt' : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) REF.CAST_instr(rt)]), [(ref : ref <: instr)])
    -- Ref_type: `%|-%:%`(s, ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt', $inst_reftype(f.MODULE_frame, rt))

  ;; 8-reduction.watsup
  rule `ref.cast-fail`{s : store, f : frame, ref : ref, rt : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) REF.CAST_instr(rt)]), [TRAP_instr])
    -- otherwise

  ;; 8-reduction.watsup
  rule struct.new_default{z : state, x : idx, `val*` : val*, `mut*` : mut*, `zt*` : storagetype*}:
    `%~>%`(`%;%`_config(z, [STRUCT.NEW_DEFAULT_instr(x)]), (val : val <: instr)*{val <- `val*`} ++ [STRUCT.NEW_instr(x)])
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%`_structtype(`%%`_fieldtype(mut, zt)*{mut <- `mut*`, zt <- `zt*`})))
    -- (if ($default_($unpack(zt)) = ?(val)))*{val <- `val*`, zt <- `zt*`}

  ;; 8-reduction.watsup
  rule `struct.get-null`{z : state, ht : heaptype, `sx?` : sx?, x : idx, i : nat}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) STRUCT.GET_instr(sx?{sx <- `sx?`}, x, `%`_u32(i))]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule `struct.get-struct`{z : state, a : addr, `sx?` : sx?, x : idx, i : nat, `zt*` : storagetype*, `mut*` : mut*}:
    `%~>%`(`%;%`_config(z, [REF.STRUCT_ADDR_instr(a) STRUCT.GET_instr(sx?{sx <- `sx?`}, x, `%`_u32(i))]), [($unpackfield_(zt*{zt <- `zt*`}[i], sx?{sx <- `sx?`}, $structinst(z)[a].FIELDS_structinst[i]) : val <: instr)])
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%`_structtype(`%%`_fieldtype(mut, zt)*{mut <- `mut*`, zt <- `zt*`})))

  ;; 8-reduction.watsup
  rule array.new_default{z : state, n : n, x : idx, val : val, mut : mut, zt : storagetype}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_DEFAULT_instr(x)]), (val : val <: instr)^n{} ++ [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ($default_($unpack(zt)) = ?(val))

  ;; 8-reduction.watsup
  rule `array.new_elem-oob`{z : state, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_ELEM_instr(x, y)]), [TRAP_instr])
    -- if ((i + n) > |$elem(z, y).REFS_eleminst|)

  ;; 8-reduction.watsup
  rule `array.new_elem-alloc`{z : state, i : nat, n : n, x : idx, y : idx, `ref*` : ref*}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_ELEM_instr(x, y)]), (ref : ref <: instr)^n{ref <- `ref*`} ++ [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))])
    -- if (ref^n{ref <- `ref*`} = $elem(z, y).REFS_eleminst[i : n])

  ;; 8-reduction.watsup
  rule `array.new_data-oob`{z : state, i : nat, n : n, x : idx, y : idx, mut : mut, zt : storagetype}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_DATA_instr(x, y)]), [TRAP_instr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ((i + ((n * $zsize(zt)) / 8)) > |$data(z, y).BYTES_datainst|)

  ;; 8-reduction.watsup
  rule `array.new_data-num`{z : state, i : nat, n : n, x : idx, y : idx, zt : storagetype, `c*` : lit_(zt)*, mut : mut}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_DATA_instr(x, y)]), $const($cunpack(zt), $cunpacknum_(zt, c))^n{c <- `c*`} ++ [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ($concatn_(syntax byte, $zbytes_(zt, c)^n{c <- `c*`}, ($zsize(zt) / 8)) = $data(z, y).BYTES_datainst[i : ((n * $zsize(zt)) / 8)])

  ;; 8-reduction.watsup
  rule `array.get-null`{z : state, ht : heaptype, i : nat, `sx?` : sx?, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, `%`_num_(i)) ARRAY.GET_instr(sx?{sx <- `sx?`}, x)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule `array.get-oob`{z : state, a : addr, i : nat, `sx?` : sx?, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) ARRAY.GET_instr(sx?{sx <- `sx?`}, x)]), [TRAP_instr])
    -- if (i >= |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; 8-reduction.watsup
  rule `array.get-array`{z : state, a : addr, i : nat, `sx?` : sx?, x : idx, zt : storagetype, mut : mut}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) ARRAY.GET_instr(sx?{sx <- `sx?`}, x)]), [($unpackfield_(zt, sx?{sx <- `sx?`}, $arrayinst(z)[a].FIELDS_arrayinst[i]) : val <: instr)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))

  ;; 8-reduction.watsup
  rule `array.len-null`{z : state, ht : heaptype}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) ARRAY.LEN_instr]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule `array.len-array`{z : state, a : addr}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) ARRAY.LEN_instr]), [CONST_instr(I32_numtype, `%`_num_(|$arrayinst(z)[a].FIELDS_arrayinst|))])

  ;; 8-reduction.watsup
  rule `array.fill-null`{z : state, ht : heaptype, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.FILL_instr(x)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule `array.fill-oob`{z : state, a : addr, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.FILL_instr(x)]), [TRAP_instr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; 8-reduction.watsup
  rule `array.fill-zero`{z : state, a : addr, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.FILL_instr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule `array.fill-succ`{z : state, a : addr, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.FILL_instr(x)]), [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) ARRAY.SET_instr(x) REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_((i + 1))) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_((n - 1))) ARRAY.FILL_instr(x)])
    -- otherwise

  ;; 8-reduction.watsup
  rule `array.copy-null1`{z : state, ht_1 : heaptype, i_1 : nat, ref : ref, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht_1) CONST_instr(I32_numtype, `%`_num_(i_1)) (ref : ref <: instr) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule `array.copy-null2`{z : state, ref : ref, i_1 : nat, ht_2 : heaptype, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [(ref : ref <: instr) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.NULL_instr(ht_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule `array.copy-oob1`{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [TRAP_instr])
    -- if ((i_1 + n) > |$arrayinst(z)[a_1].FIELDS_arrayinst|)

  ;; 8-reduction.watsup
  rule `array.copy-oob2`{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [TRAP_instr])
    -- if ((i_2 + n) > |$arrayinst(z)[a_2].FIELDS_arrayinst|)

  ;; 8-reduction.watsup
  rule `array.copy-zero`{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule `array.copy-le`{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx, `sx?` : sx?, mut : mut, zt_2 : storagetype}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) ARRAY.GET_instr(sx?{sx <- `sx?`}, x_2) ARRAY.SET_instr(x_1) REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_((i_1 + 1))) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_((i_2 + 1))) CONST_instr(I32_numtype, `%`_num_((n - 1))) ARRAY.COPY_instr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`_arraytype(mut, zt_2)))
    -- if ((i_1 <= i_2) /\ (sx?{sx <- `sx?`} = $sx(zt_2)))

  ;; 8-reduction.watsup
  rule `array.copy-gt`{z : state, a_1 : addr, i_1 : nat, a_2 : addr, i_2 : nat, n : n, x_1 : idx, x_2 : idx, `sx?` : sx?, mut : mut, zt_2 : storagetype}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(((i_1 + n) - 1))) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(((i_2 + n) - 1))) ARRAY.GET_instr(sx?{sx <- `sx?`}, x_2) ARRAY.SET_instr(x_1) REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(i_1)) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_((n - 1))) ARRAY.COPY_instr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`_arraytype(mut, zt_2)))
    -- if (sx?{sx <- `sx?`} = $sx(zt_2))

  ;; 8-reduction.watsup
  rule `array.init_elem-null`{z : state, ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule `array.init_elem-oob1`{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [TRAP_instr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; 8-reduction.watsup
  rule `array.init_elem-oob2`{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [TRAP_instr])
    -- if ((j + n) > |$elem(z, y).REFS_eleminst|)

  ;; 8-reduction.watsup
  rule `array.init_elem-zero`{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule `array.init_elem-succ`{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, ref : ref}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (ref : ref <: instr) ARRAY.SET_instr(x) REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_((i + 1))) CONST_instr(I32_numtype, `%`_num_((j + 1))) CONST_instr(I32_numtype, `%`_num_((n - 1))) ARRAY.INIT_ELEM_instr(x, y)])
    -- otherwise
    -- if (ref = $elem(z, y).REFS_eleminst[j])

  ;; 8-reduction.watsup
  rule `array.init_data-null`{z : state, ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [TRAP_instr])

  ;; 8-reduction.watsup
  rule `array.init_data-oob1`{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [TRAP_instr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; 8-reduction.watsup
  rule `array.init_data-oob2`{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, mut : mut, zt : storagetype}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [TRAP_instr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ((j + ((n * $zsize(zt)) / 8)) > |$data(z, y).BYTES_datainst|)

  ;; 8-reduction.watsup
  rule `array.init_data-zero`{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule `array.init_data-num`{z : state, a : addr, i : nat, j : nat, n : n, x : idx, y : idx, zt : storagetype, c : lit_(zt), mut : mut}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) $const($cunpack(zt), $cunpacknum_(zt, c)) ARRAY.SET_instr(x) REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_((i + 1))) CONST_instr(I32_numtype, `%`_num_((j + ($zsize(zt) / 8)))) CONST_instr(I32_numtype, `%`_num_((n - 1))) ARRAY.INIT_DATA_instr(x, y)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ($zbytes_(zt, c) = $data(z, y).BYTES_datainst[j : ($zsize(zt) / 8)])

  ;; 8-reduction.watsup
  rule local.get{z : state, x : idx, val : val}:
    `%~>%`(`%;%`_config(z, [LOCAL.GET_instr(x)]), [(val : val <: instr)])
    -- if ($local(z, x) = ?(val))

  ;; 8-reduction.watsup
  rule global.get{z : state, x : idx, val : val}:
    `%~>%`(`%;%`_config(z, [GLOBAL.GET_instr(x)]), [(val : val <: instr)])
    -- if ($global(z, x).VALUE_globalinst = val)

  ;; 8-reduction.watsup
  rule `table.get-oob`{z : state, i : nat, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) TABLE.GET_instr(x)]), [TRAP_instr])
    -- if (i >= |$table(z, x).REFS_tableinst|)

  ;; 8-reduction.watsup
  rule `table.get-val`{z : state, i : nat, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) TABLE.GET_instr(x)]), [($table(z, x).REFS_tableinst[i] : ref <: instr)])
    -- if (i < |$table(z, x).REFS_tableinst|)

  ;; 8-reduction.watsup
  rule table.size{z : state, x : idx, n : n}:
    `%~>%`(`%;%`_config(z, [TABLE.SIZE_instr(x)]), [CONST_instr(I32_numtype, `%`_num_(n))])
    -- if (|$table(z, x).REFS_tableinst| = n)

  ;; 8-reduction.watsup
  rule `table.fill-oob`{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.FILL_instr(x)]), [TRAP_instr])
    -- if ((i + n) > |$table(z, x).REFS_tableinst|)

  ;; 8-reduction.watsup
  rule `table.fill-zero`{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.FILL_instr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule `table.fill-succ`{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.FILL_instr(x)]), [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) TABLE.SET_instr(x) CONST_instr(I32_numtype, `%`_num_((i + 1))) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_((n - 1))) TABLE.FILL_instr(x)])
    -- otherwise

  ;; 8-reduction.watsup
  rule `table.copy-oob`{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.COPY_instr(x, y)]), [TRAP_instr])
    -- if (((i + n) > |$table(z, y).REFS_tableinst|) \/ ((j + n) > |$table(z, x).REFS_tableinst|))

  ;; 8-reduction.watsup
  rule `table.copy-zero`{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.COPY_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule `table.copy-le`{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.COPY_instr(x, y)]), [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) TABLE.GET_instr(y) TABLE.SET_instr(x) CONST_instr(I32_numtype, `%`_num_((j + 1))) CONST_instr(I32_numtype, `%`_num_((i + 1))) CONST_instr(I32_numtype, `%`_num_((n - 1))) TABLE.COPY_instr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 8-reduction.watsup
  rule `table.copy-gt`{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.COPY_instr(x, y)]), [CONST_instr(I32_numtype, `%`_num_(((j + n) - 1))) CONST_instr(I32_numtype, `%`_num_(((i + n) - 1))) TABLE.GET_instr(y) TABLE.SET_instr(x) CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_((n - 1))) TABLE.COPY_instr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup
  rule `table.init-oob`{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.INIT_instr(x, y)]), [TRAP_instr])
    -- if (((i + n) > |$elem(z, y).REFS_eleminst|) \/ ((j + n) > |$table(z, x).REFS_tableinst|))

  ;; 8-reduction.watsup
  rule `table.init-zero`{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.INIT_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule `table.init-succ`{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.INIT_instr(x, y)]), [CONST_instr(I32_numtype, `%`_num_(j)) ($elem(z, y).REFS_eleminst[i] : ref <: instr) TABLE.SET_instr(x) CONST_instr(I32_numtype, `%`_num_((j + 1))) CONST_instr(I32_numtype, `%`_num_((i + 1))) CONST_instr(I32_numtype, `%`_num_((n - 1))) TABLE.INIT_instr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup
  rule `load-num-oob`{z : state, i : nat, nt : numtype, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) LOAD_instr(nt, ?(), x, ao)]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + ($size(nt) / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule `load-num-val`{z : state, i : nat, nt : numtype, x : idx, ao : memarg, c : num_(nt)}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) LOAD_instr(nt, ?(), x, ao)]), [CONST_instr(nt, c)])
    -- if ($nbytes_(nt, c) = $mem(z, x).BYTES_meminst[(i + ao.OFFSET_memarg!`%`_u32.0) : ($size(nt) / 8)])

  ;; 8-reduction.watsup
  rule `load-pack-oob`{z : state, i : nat, Inn : Inn, n : n, sx : sx, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) LOAD_instr((Inn : Inn <: numtype), ?(`%%`_loadop_(`%`_sz(n), sx)), x, ao)]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + (n / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule `load-pack-val`{z : state, i : nat, Inn : Inn, n : n, sx : sx, x : idx, ao : memarg, c : iN(n)}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) LOAD_instr((Inn : Inn <: numtype), ?(`%%`_loadop_(`%`_sz(n), sx)), x, ao)]), [CONST_instr((Inn : Inn <: numtype), $extend__(n, $size((Inn : Inn <: numtype)), sx, c))])
    -- if ($ibytes_(n, c) = $mem(z, x).BYTES_meminst[(i + ao.OFFSET_memarg!`%`_u32.0) : (n / 8)])

  ;; 8-reduction.watsup
  rule `vload-oob`{z : state, i : nat, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(), x, ao)]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + ($vsize(V128_vectype) / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule `vload-val`{z : state, i : nat, x : idx, ao : memarg, c : vec_(V128_Vnn)}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(), x, ao)]), [VCONST_instr(V128_vectype, c)])
    -- if ($vbytes_(V128_vectype, c) = $mem(z, x).BYTES_meminst[(i + ao.OFFSET_memarg!`%`_u32.0) : ($vsize(V128_vectype) / 8)])

  ;; 8-reduction.watsup
  rule `vload-pack-oob`{z : state, i : nat, M : M, K : K, sx : sx, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(`SHAPE%X%%`_vloadop_(`%`_sz(M), K, sx)), x, ao)]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + ((M * K) / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule `vload-pack-val`{z : state, i : nat, M : M, K : K, sx : sx, x : idx, ao : memarg, c : vec_(V128_Vnn), `j*` : nat*, `k*` : nat*, Jnn : Jnn}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(`SHAPE%X%%`_vloadop_(`%`_sz(M), K, sx)), x, ao)]), [VCONST_instr(V128_vectype, c)])
    -- (if ($ibytes_(M, `%`_iN(j)) = $mem(z, x).BYTES_meminst[((i + ao.OFFSET_memarg!`%`_u32.0) + ((k * M) / 8)) : (M / 8)]))^(k<K){j <- `j*`, k <- `k*`}
    -- if ((c = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(K)), $extend__(M, $lsizenn((Jnn : Jnn <: lanetype)), sx, `%`_iN(j))^K{j <- `j*`})) /\ ($lsizenn((Jnn : Jnn <: lanetype)) = (M * 2)))

  ;; 8-reduction.watsup
  rule `vload-splat-oob`{z : state, i : nat, N : N, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(N))), x, ao)]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + (N / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule `vload-splat-val`{z : state, i : nat, N : N, x : idx, ao : memarg, c : vec_(V128_Vnn), j : nat, Jnn : Jnn, M : M}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(N))), x, ao)]), [VCONST_instr(V128_vectype, c)])
    -- if ($ibytes_(N, `%`_iN(j)) = $mem(z, x).BYTES_meminst[(i + ao.OFFSET_memarg!`%`_u32.0) : (N / 8)])
    -- if (N = $lsize((Jnn : Jnn <: lanetype)))
    -- if (M = (128 / N))
    -- if (c = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), `%`_lane_(j)^M{}))

  ;; 8-reduction.watsup
  rule `vload-zero-oob`{z : state, i : nat, N : N, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(N))), x, ao)]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + (N / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule `vload-zero-val`{z : state, i : nat, N : N, x : idx, ao : memarg, c : vec_(V128_Vnn), j : nat}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(N))), x, ao)]), [VCONST_instr(V128_vectype, c)])
    -- if ($ibytes_(N, `%`_iN(j)) = $mem(z, x).BYTES_meminst[(i + ao.OFFSET_memarg!`%`_u32.0) : (N / 8)])
    -- if (c = $extend__(N, 128, U_sx, `%`_iN(j)))

  ;; 8-reduction.watsup
  rule `vload_lane-oob`{z : state, i : nat, c_1 : vec_(V128_Vnn), N : N, x : idx, ao : memarg, j : nat}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VCONST_instr(V128_vectype, c_1) VLOAD_LANE_instr(V128_vectype, `%`_sz(N), x, ao, `%`_laneidx(j))]), [TRAP_instr])
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + (N / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule `vload_lane-val`{z : state, i : nat, c_1 : vec_(V128_Vnn), N : N, x : idx, ao : memarg, j : nat, c : vec_(V128_Vnn), k : nat, Jnn : Jnn, M : M}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VCONST_instr(V128_vectype, c_1) VLOAD_LANE_instr(V128_vectype, `%`_sz(N), x, ao, `%`_laneidx(j))]), [VCONST_instr(V128_vectype, c)])
    -- if ($ibytes_(N, `%`_iN(k)) = $mem(z, x).BYTES_meminst[(i + ao.OFFSET_memarg!`%`_u32.0) : (N / 8)])
    -- if (N = $lsize((Jnn : Jnn <: lanetype)))
    -- if (M = ($vsize(V128_vectype) / N))
    -- if (c = $invlanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c_1)[[j] = `%`_lane_(k)]))

  ;; 8-reduction.watsup
  rule memory.size{z : state, x : idx, n : n}:
    `%~>%`(`%;%`_config(z, [MEMORY.SIZE_instr(x)]), [CONST_instr(I32_numtype, `%`_num_(n))])
    -- if ((n * (64 * $Ki)) = |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule `memory.fill-oob`{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.FILL_instr(x)]), [TRAP_instr])
    -- if ((i + n) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup
  rule `memory.fill-zero`{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.FILL_instr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule `memory.fill-succ`{z : state, i : nat, val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.FILL_instr(x)]), [CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) STORE_instr(I32_numtype, ?(`%`_sz(8)), x, $memarg0) CONST_instr(I32_numtype, `%`_num_((i + 1))) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_((n - 1))) MEMORY.FILL_instr(x)])
    -- otherwise

  ;; 8-reduction.watsup
  rule `memory.copy-oob`{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i_1)) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.COPY_instr(x_1, x_2)]), [TRAP_instr])
    -- if (((i_1 + n) > |$mem(z, x_1).BYTES_meminst|) \/ ((i_2 + n) > |$mem(z, x_2).BYTES_meminst|))

  ;; 8-reduction.watsup
  rule `memory.copy-zero`{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i_1)) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.COPY_instr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule `memory.copy-le`{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i_1)) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.COPY_instr(x_1, x_2)]), [CONST_instr(I32_numtype, `%`_num_(i_1)) CONST_instr(I32_numtype, `%`_num_(i_2)) LOAD_instr(I32_numtype, ?(`%%`_loadop_(`%`_sz(8), U_sx)), x_2, $memarg0) STORE_instr(I32_numtype, ?(`%`_sz(8)), x_1, $memarg0) CONST_instr(I32_numtype, `%`_num_((i_1 + 1))) CONST_instr(I32_numtype, `%`_num_((i_2 + 1))) CONST_instr(I32_numtype, `%`_num_((n - 1))) MEMORY.COPY_instr(x_1, x_2)])
    -- otherwise
    -- if (i_1 <= i_2)

  ;; 8-reduction.watsup
  rule `memory.copy-gt`{z : state, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i_1)) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.COPY_instr(x_1, x_2)]), [CONST_instr(I32_numtype, `%`_num_(((i_1 + n) - 1))) CONST_instr(I32_numtype, `%`_num_(((i_2 + n) - 1))) LOAD_instr(I32_numtype, ?(`%%`_loadop_(`%`_sz(8), U_sx)), x_2, $memarg0) STORE_instr(I32_numtype, ?(`%`_sz(8)), x_1, $memarg0) CONST_instr(I32_numtype, `%`_num_(i_1)) CONST_instr(I32_numtype, `%`_num_(i_2)) CONST_instr(I32_numtype, `%`_num_((n - 1))) MEMORY.COPY_instr(x_1, x_2)])
    -- otherwise

  ;; 8-reduction.watsup
  rule `memory.init-oob`{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.INIT_instr(x, y)]), [TRAP_instr])
    -- if (((i + n) > |$data(z, y).BYTES_datainst|) \/ ((j + n) > |$mem(z, x).BYTES_meminst|))

  ;; 8-reduction.watsup
  rule `memory.init-zero`{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.INIT_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup
  rule `memory.init-succ`{z : state, j : nat, i : nat, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.INIT_instr(x, y)]), [CONST_instr(I32_numtype, `%`_num_(j)) CONST_instr(I32_numtype, `%`_num_($data(z, y).BYTES_datainst[i]!`%`_byte.0)) STORE_instr(I32_numtype, ?(`%`_sz(8)), x, $memarg0) CONST_instr(I32_numtype, `%`_num_((j + 1))) CONST_instr(I32_numtype, `%`_num_((i + 1))) CONST_instr(I32_numtype, `%`_num_((n - 1))) MEMORY.INIT_instr(x, y)])
    -- otherwise

;; 8-reduction.watsup
rec {

;; 8-reduction.watsup:5.1-5.88
relation Step: `%~>%`(config, config)
  ;; 8-reduction.watsup:10.1-12.34
  rule pure{z : state, `instr*` : instr*, `instr'*` : instr*}:
    `%~>%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z, instr'*{instr' <- `instr'*`}))
    -- Step_pure: `%~>%`(instr*{instr <- `instr*`}, instr'*{instr' <- `instr'*`})

  ;; 8-reduction.watsup:14.1-16.37
  rule read{z : state, `instr*` : instr*, `instr'*` : instr*}:
    `%~>%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z, instr'*{instr' <- `instr'*`}))
    -- Step_read: `%~>%`(`%;%`_config(z, instr*{instr <- `instr*`}), instr'*{instr' <- `instr'*`})

  ;; 8-reduction.watsup:42.1-45.41
  rule `ctxt-instrs`{z : state, `val*` : val*, `instr*` : instr*, `instr_1*` : instr*, z' : state, `instr'*` : instr*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)*{val <- `val*`} ++ instr*{instr <- `instr*`} ++ instr_1*{instr_1 <- `instr_1*`}), `%;%`_config(z', (val : val <: instr)*{val <- `val*`} ++ instr'*{instr' <- `instr'*`} ++ instr_1*{instr_1 <- `instr_1*`}))
    -- Step: `%~>%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z', instr'*{instr' <- `instr'*`}))
    -- if ((val*{val <- `val*`} =/= []) \/ (instr_1*{instr_1 <- `instr_1*`} =/= []))

  ;; 8-reduction.watsup:47.1-49.36
  rule `ctxt-label`{z : state, n : n, `instr_0*` : instr*, `instr*` : instr*, z' : state, `instr'*` : instr*}:
    `%~>%`(`%;%`_config(z, [`LABEL_%{%}%`_instr(n, instr_0*{instr_0 <- `instr_0*`}, instr*{instr <- `instr*`})]), `%;%`_config(z', [`LABEL_%{%}%`_instr(n, instr_0*{instr_0 <- `instr_0*`}, instr'*{instr' <- `instr'*`})]))
    -- Step: `%~>%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z', instr'*{instr' <- `instr'*`}))

  ;; 8-reduction.watsup:51.1-53.44
  rule `ctxt-frame`{s : store, f : frame, n : n, f' : frame, `instr*` : instr*, s' : store, `instr'*` : instr*}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [`FRAME_%{%}%`_instr(n, f', instr*{instr <- `instr*`})]), `%;%`_config(`%;%`_state(s', f), [`FRAME_%{%}%`_instr(n, f', instr'*{instr' <- `instr'*`})]))
    -- Step: `%~>%`(`%;%`_config(`%;%`_state(s, f'), instr*{instr <- `instr*`}), `%;%`_config(`%;%`_state(s', f'), instr'*{instr' <- `instr'*`}))

  ;; 8-reduction.watsup:237.1-242.49
  rule throw{z : state, `val*` : val*, n : n, x : idx, exn : exninst, a : addr, `t*` : valtype*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^n{val <- `val*`} ++ [THROW_instr(x)]), `%;%`_config($add_exninst(z, [exn]), [REF.EXN_ADDR_instr(a) THROW_REF_instr]))
    -- Expand: `%~~%`($tag(z, x).TYPE_taginst, FUNC_comptype(`%->%`_functype(`%`_resulttype(t^n{t <- `t*`}), `%`_resulttype([]))))
    -- if (a = |$exninst(z)|)
    -- if (exn = {TAG $tagaddr(z)[x!`%`_idx.0], FIELDS val^n{val <- `val*`}})

  ;; 8-reduction.watsup:417.1-421.65
  rule struct.new{z : state, `val*` : val*, n : n, x : idx, si : structinst, a : addr, `mut*` : mut*, `zt*` : storagetype*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^n{val <- `val*`} ++ [STRUCT.NEW_instr(x)]), `%;%`_config($add_structinst(z, [si]), [REF.STRUCT_ADDR_instr(a)]))
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%`_structtype(`%%`_fieldtype(mut, zt)^n{mut <- `mut*`, zt <- `zt*`})))
    -- if (a = |$structinst(z)|)
    -- if (si = {TYPE $type(z, x), FIELDS $packfield_(zt, val)^n{val <- `val*`, zt <- `zt*`}})

  ;; 8-reduction.watsup:437.1-438.53
  rule `struct.set-null`{z : state, ht : heaptype, val : val, x : idx, i : nat}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) (val : val <: instr) STRUCT.SET_instr(x, `%`_u32(i))]), `%;%`_config(z, [TRAP_instr]))

  ;; 8-reduction.watsup:440.1-442.45
  rule `struct.set-struct`{z : state, a : addr, val : val, x : idx, i : nat, `zt*` : storagetype*, `mut*` : mut*}:
    `%~>%`(`%;%`_config(z, [REF.STRUCT_ADDR_instr(a) (val : val <: instr) STRUCT.SET_instr(x, `%`_u32(i))]), `%;%`_config($with_struct(z, a, i, $packfield_(zt*{zt <- `zt*`}[i], val)), []))
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%`_structtype(`%%`_fieldtype(mut, zt)*{mut <- `mut*`, zt <- `zt*`})))

  ;; 8-reduction.watsup:455.1-460.65
  rule array.new_fixed{z : state, `val*` : val*, n : n, x : idx, ai : arrayinst, a : addr, mut : mut, zt : storagetype}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^n{val <- `val*`} ++ [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))]), `%;%`_config($add_arrayinst(z, [ai]), [REF.ARRAY_ADDR_instr(a)]))
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))
    -- if ((a = |$arrayinst(z)|) /\ (ai = {TYPE $type(z, x), FIELDS $packfield_(zt, val)^n{val <- `val*`}}))

  ;; 8-reduction.watsup:500.1-501.64
  rule `array.set-null`{z : state, ht : heaptype, i : nat, val : val, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) ARRAY.SET_instr(x)]), `%;%`_config(z, [TRAP_instr]))

  ;; 8-reduction.watsup:503.1-505.39
  rule `array.set-oob`{z : state, a : addr, i : nat, val : val, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) ARRAY.SET_instr(x)]), `%;%`_config(z, [TRAP_instr]))
    -- if (i >= |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; 8-reduction.watsup:507.1-510.43
  rule `array.set-array`{z : state, a : addr, i : nat, val : val, x : idx, zt : storagetype, mut : mut}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_(i)) (val : val <: instr) ARRAY.SET_instr(x)]), `%;%`_config($with_array(z, a, i, $packfield_(zt, val)), []))
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_arraytype(mut, zt)))

  ;; 8-reduction.watsup:828.1-829.56
  rule local.set{z : state, val : val, x : idx}:
    `%~>%`(`%;%`_config(z, [(val : val <: instr) LOCAL.SET_instr(x)]), `%;%`_config($with_local(z, x, val), []))

  ;; 8-reduction.watsup:841.1-842.58
  rule global.set{z : state, val : val, x : idx}:
    `%~>%`(`%;%`_config(z, [(val : val <: instr) GLOBAL.SET_instr(x)]), `%;%`_config($with_global(z, x, val), []))

  ;; 8-reduction.watsup:855.1-857.33
  rule `table.set-oob`{z : state, i : nat, ref : ref, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (ref : ref <: instr) TABLE.SET_instr(x)]), `%;%`_config(z, [TRAP_instr]))
    -- if (i >= |$table(z, x).REFS_tableinst|)

  ;; 8-reduction.watsup:859.1-861.32
  rule `table.set-val`{z : state, i : nat, ref : ref, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) (ref : ref <: instr) TABLE.SET_instr(x)]), `%;%`_config($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).REFS_tableinst|)

  ;; 8-reduction.watsup:869.1-872.46
  rule `table.grow-succeed`{z : state, ref : ref, n : n, x : idx, ti : tableinst}:
    `%~>%`(`%;%`_config(z, [(ref : ref <: instr) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.GROW_instr(x)]), `%;%`_config($with_tableinst(z, x, ti), [CONST_instr(I32_numtype, `%`_num_(|$table(z, x).REFS_tableinst|))]))
    -- if (ti = $growtable($table(z, x), n, ref))

  ;; 8-reduction.watsup:874.1-875.81
  rule `table.grow-fail`{z : state, ref : ref, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [(ref : ref <: instr) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.GROW_instr(x)]), `%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_($invsigned_(32, - (1 : nat <: int))))]))

  ;; 8-reduction.watsup:935.1-936.51
  rule elem.drop{z : state, x : idx}:
    `%~>%`(`%;%`_config(z, [ELEM.DROP_instr(x)]), `%;%`_config($with_elem(z, x, []), []))

  ;; 8-reduction.watsup:1019.1-1022.60
  rule `store-num-oob`{z : state, i : nat, nt : numtype, c : num_(nt), x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(nt, c) STORE_instr(nt, ?(), x, ao)]), `%;%`_config(z, [TRAP_instr]))
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + ($size(nt) / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup:1024.1-1028.29
  rule `store-num-val`{z : state, i : nat, nt : numtype, c : num_(nt), x : idx, ao : memarg, `b*` : byte*}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr(nt, c) STORE_instr(nt, ?(), x, ao)]), `%;%`_config($with_mem(z, x, (i + ao.OFFSET_memarg!`%`_u32.0), ($size(nt) / 8), b*{b <- `b*`}), []))
    -- if (b*{b <- `b*`} = $nbytes_(nt, c))

  ;; 8-reduction.watsup:1030.1-1033.52
  rule `store-pack-oob`{z : state, i : nat, Inn : Inn, c : num_((Inn : Inn <: numtype)), nt : numtype, n : n, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr((Inn : Inn <: numtype), c) STORE_instr(nt, ?(`%`_sz(n)), x, ao)]), `%;%`_config(z, [TRAP_instr]))
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + (n / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup:1035.1-1039.52
  rule `store-pack-val`{z : state, i : nat, Inn : Inn, c : num_((Inn : Inn <: numtype)), nt : numtype, n : n, x : idx, ao : memarg, `b*` : byte*}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) CONST_instr((Inn : Inn <: numtype), c) STORE_instr(nt, ?(`%`_sz(n)), x, ao)]), `%;%`_config($with_mem(z, x, (i + ao.OFFSET_memarg!`%`_u32.0), (n / 8), b*{b <- `b*`}), []))
    -- if (b*{b <- `b*`} = $ibytes_(n, $wrap__($size((Inn : Inn <: numtype)), n, c)))

  ;; 8-reduction.watsup:1041.1-1043.63
  rule `vstore-oob`{z : state, i : nat, c : vec_(V128_Vnn), x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VCONST_instr(V128_vectype, c) VSTORE_instr(V128_vectype, x, ao)]), `%;%`_config(z, [TRAP_instr]))
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + ($vsize(V128_vectype) / 8)) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup:1045.1-1047.31
  rule `vstore-val`{z : state, i : nat, c : vec_(V128_Vnn), x : idx, ao : memarg, `b*` : byte*}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VCONST_instr(V128_vectype, c) VSTORE_instr(V128_vectype, x, ao)]), `%;%`_config($with_mem(z, x, (i + ao.OFFSET_memarg!`%`_u32.0), ($vsize(V128_vectype) / 8), b*{b <- `b*`}), []))
    -- if (b*{b <- `b*`} = $vbytes_(V128_vectype, c))

  ;; 8-reduction.watsup:1050.1-1052.50
  rule `vstore_lane-oob`{z : state, i : nat, c : vec_(V128_Vnn), N : N, x : idx, ao : memarg, j : nat}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VCONST_instr(V128_vectype, c) VSTORE_LANE_instr(V128_vectype, `%`_sz(N), x, ao, `%`_laneidx(j))]), `%;%`_config(z, [TRAP_instr]))
    -- if (((i + ao.OFFSET_memarg!`%`_u32.0) + N) > |$mem(z, x).BYTES_meminst|)

  ;; 8-reduction.watsup:1054.1-1058.49
  rule `vstore_lane-val`{z : state, i : nat, c : vec_(V128_Vnn), N : N, x : idx, ao : memarg, j : nat, `b*` : byte*, Jnn : Jnn, M : M}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(i)) VCONST_instr(V128_vectype, c) VSTORE_LANE_instr(V128_vectype, `%`_sz(N), x, ao, `%`_laneidx(j))]), `%;%`_config($with_mem(z, x, (i + ao.OFFSET_memarg!`%`_u32.0), (N / 8), b*{b <- `b*`}), []))
    -- if (N = $lsize((Jnn : Jnn <: lanetype)))
    -- if (M = (128 / N))
    -- if (b*{b <- `b*`} = $ibytes_(N, `%`_iN($lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c)[j]!`%`_lane_.0)))

  ;; 8-reduction.watsup:1066.1-1069.37
  rule `memory.grow-succeed`{z : state, n : n, x : idx, mi : meminst}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.GROW_instr(x)]), `%;%`_config($with_meminst(z, x, mi), [CONST_instr(I32_numtype, `%`_num_((|$mem(z, x).BYTES_meminst| / (64 * $Ki))))]))
    -- if (mi = $growmem($mem(z, x), n))

  ;; 8-reduction.watsup:1071.1-1072.78
  rule `memory.grow-fail`{z : state, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.GROW_instr(x)]), `%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_($invsigned_(32, - (1 : nat <: int))))]))

  ;; 8-reduction.watsup:1132.1-1133.51
  rule data.drop{z : state, x : idx}:
    `%~>%`(`%;%`_config(z, [DATA.DROP_instr(x)]), `%;%`_config($with_data(z, x, []), []))
}

;; 8-reduction.watsup
rec {

;; 8-reduction.watsup:8.1-8.92
relation Steps: `%~>*%`(config, config)
  ;; 8-reduction.watsup:18.1-19.26
  rule refl{z : state, `instr*` : instr*}:
    `%~>*%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z, instr*{instr <- `instr*`}))

  ;; 8-reduction.watsup:21.1-24.44
  rule trans{z : state, `instr*` : instr*, z'' : state, `instr''*` : instr*, z' : state, `instr'*` : instr*}:
    `%~>*%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z'', instr''*{instr'' <- `instr''*`}))
    -- Step: `%~>%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z', instr'*{instr' <- `instr'*`}))
    -- Steps: `%~>*%`(`%;%`_config(z', instr'*{instr' <- `instr'*`}), `%;%`_config(z'', instr''*{instr'' <- `instr''*`}))
}

;; 8-reduction.watsup
relation Eval_expr: `%;%~>*%;%`(state, expr, state, val*)
  ;; 8-reduction.watsup
  rule _{z : state, `instr*` : instr*, z' : state, `val*` : val*}:
    `%;%~>*%;%`(z, instr*{instr <- `instr*`}, z', val*{val <- `val*`})
    -- Steps: `%~>*%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z', (val : val <: instr)*{val <- `val*`}))

;; 9-module.watsup
rec {

;; 9-module.watsup:7.1-7.63
def $alloctypes(type*) : deftype*
  ;; 9-module.watsup:8.1-8.27
  def $alloctypes([]) = []
  ;; 9-module.watsup:9.1-13.24
  def $alloctypes{`type'*` : type*, type : type, `deftype'*` : deftype*, `deftype*` : deftype*, rectype : rectype, x : idx}(type'*{type' <- `type'*`} ++ [type]) = deftype'*{deftype' <- `deftype'*`} ++ deftype*{deftype <- `deftype*`}
    -- if (deftype'*{deftype' <- `deftype'*`} = $alloctypes(type'*{type' <- `type'*`}))
    -- if (type = TYPE_type(rectype))
    -- if (deftype*{deftype <- `deftype*`} = $subst_all_deftypes($rolldt(x, rectype), (deftype' : deftype <: heaptype)*{deftype' <- `deftype'*`}))
    -- if (x = `%`_idx(|deftype'*{deftype' <- `deftype'*`}|))
}

;; 9-module.watsup
def $allocfunc(store : store, deftype : deftype, funccode : funccode, moduleinst : moduleinst) : (store, funcaddr)
  ;; 9-module.watsup
  def $allocfunc{s : store, deftype : deftype, funccode : funccode, moduleinst : moduleinst, funcinst : funcinst}(s, deftype, funccode, moduleinst) = (s +++ {FUNCS [funcinst], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], STRUCTS [], ARRAYS [], EXNS []}, |s.FUNCS_store|)
    -- if (funcinst = {TYPE deftype, MODULE moduleinst, CODE funccode})

;; 9-module.watsup
rec {

;; 9-module.watsup:20.1-20.113
def $allocfuncs(store : store, deftype*, funccode*, moduleinst*) : (store, funcaddr*)
  ;; 9-module.watsup:21.1-21.45
  def $allocfuncs{s : store}(s, [], [], []) = (s, [])
  ;; 9-module.watsup:22.1-24.71
  def $allocfuncs{s : store, dt : deftype, `dt'*` : deftype*, funccode : funccode, `funccode'*` : funccode*, moduleinst : moduleinst, `moduleinst'*` : moduleinst*, s_2 : store, fa : funcaddr, `fa'*` : funcaddr*, s_1 : store}(s, [dt] ++ dt'*{dt' <- `dt'*`}, [funccode] ++ funccode'*{funccode' <- `funccode'*`}, [moduleinst] ++ moduleinst'*{moduleinst' <- `moduleinst'*`}) = (s_2, [fa] ++ fa'*{fa' <- `fa'*`})
    -- if ((s_1, fa) = $allocfunc(s, dt, funccode, moduleinst))
    -- if ((s_2, fa'*{fa' <- `fa'*`}) = $allocfuncs(s_1, dt'*{dt' <- `dt'*`}, funccode'*{funccode' <- `funccode'*`}, moduleinst'*{moduleinst' <- `moduleinst'*`}))
}

;; 9-module.watsup
def $allocglobal(store : store, globaltype : globaltype, val : val) : (store, globaladdr)
  ;; 9-module.watsup
  def $allocglobal{s : store, globaltype : globaltype, val : val, globalinst : globalinst}(s, globaltype, val) = (s +++ {FUNCS [], GLOBALS [globalinst], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], STRUCTS [], ARRAYS [], EXNS []}, |s.GLOBALS_store|)
    -- if (globalinst = {TYPE globaltype, VALUE val})

;; 9-module.watsup
rec {

;; 9-module.watsup:31.1-31.102
def $allocglobals(store : store, globaltype*, val*) : (store, globaladdr*)
  ;; 9-module.watsup:32.1-32.42
  def $allocglobals{s : store}(s, [], []) = (s, [])
  ;; 9-module.watsup:33.1-35.62
  def $allocglobals{s : store, globaltype : globaltype, `globaltype'*` : globaltype*, val : val, `val'*` : val*, s_2 : store, ga : globaladdr, `ga'*` : globaladdr*, s_1 : store}(s, [globaltype] ++ globaltype'*{globaltype' <- `globaltype'*`}, [val] ++ val'*{val' <- `val'*`}) = (s_2, [ga] ++ ga'*{ga' <- `ga'*`})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga' <- `ga'*`}) = $allocglobals(s_1, globaltype'*{globaltype' <- `globaltype'*`}, val'*{val' <- `val'*`}))
}

;; 9-module.watsup
def $alloctable(store : store, tabletype : tabletype, ref : ref) : (store, tableaddr)
  ;; 9-module.watsup
  def $alloctable{s : store, i : nat, j : nat, rt : reftype, ref : ref, tableinst : tableinst}(s, `%%`_tabletype(`[%..%]`_limits(`%`_u32(i), `%`_u32(j)), rt), ref) = (s +++ {FUNCS [], GLOBALS [], TABLES [tableinst], MEMS [], TAGS [], ELEMS [], DATAS [], STRUCTS [], ARRAYS [], EXNS []}, |s.TABLES_store|)
    -- if (tableinst = {TYPE `%%`_tabletype(`[%..%]`_limits(`%`_u32(i), `%`_u32(j)), rt), REFS ref^i{}})

;; 9-module.watsup
rec {

;; 9-module.watsup:42.1-42.98
def $alloctables(store : store, tabletype*, ref*) : (store, tableaddr*)
  ;; 9-module.watsup:43.1-43.41
  def $alloctables{s : store}(s, [], []) = (s, [])
  ;; 9-module.watsup:44.1-46.60
  def $alloctables{s : store, tabletype : tabletype, `tabletype'*` : tabletype*, ref : ref, `ref'*` : ref*, s_2 : store, ta : tableaddr, `ta'*` : tableaddr*, s_1 : store}(s, [tabletype] ++ tabletype'*{tabletype' <- `tabletype'*`}, [ref] ++ ref'*{ref' <- `ref'*`}) = (s_2, [ta] ++ ta'*{ta' <- `ta'*`})
    -- if ((s_1, ta) = $alloctable(s, tabletype, ref))
    -- if ((s_2, ta'*{ta' <- `ta'*`}) = $alloctables(s_1, tabletype'*{tabletype' <- `tabletype'*`}, ref'*{ref' <- `ref'*`}))
}

;; 9-module.watsup
def $allocmem(store : store, memtype : memtype) : (store, memaddr)
  ;; 9-module.watsup
  def $allocmem{s : store, i : nat, j : nat, meminst : meminst}(s, `%PAGE`_memtype(`[%..%]`_limits(`%`_u32(i), `%`_u32(j)))) = (s +++ {FUNCS [], GLOBALS [], TABLES [], MEMS [meminst], TAGS [], ELEMS [], DATAS [], STRUCTS [], ARRAYS [], EXNS []}, |s.MEMS_store|)
    -- if (meminst = {TYPE `%PAGE`_memtype(`[%..%]`_limits(`%`_u32(i), `%`_u32(j))), BYTES `%`_byte(0)^(i * (64 * $Ki)){}})

;; 9-module.watsup
rec {

;; 9-module.watsup:53.1-53.82
def $allocmems(store : store, memtype*) : (store, memaddr*)
  ;; 9-module.watsup:54.1-54.34
  def $allocmems{s : store}(s, []) = (s, [])
  ;; 9-module.watsup:55.1-57.49
  def $allocmems{s : store, memtype : memtype, `memtype'*` : memtype*, s_2 : store, ma : memaddr, `ma'*` : memaddr*, s_1 : store}(s, [memtype] ++ memtype'*{memtype' <- `memtype'*`}) = (s_2, [ma] ++ ma'*{ma' <- `ma'*`})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma' <- `ma'*`}) = $allocmems(s_1, memtype'*{memtype' <- `memtype'*`}))
}

;; 9-module.watsup
def $alloctag(store : store, tagtype : tagtype) : (store, tagaddr)
  ;; 9-module.watsup
  def $alloctag{s : store, tagtype : tagtype, taginst : taginst}(s, tagtype) = (s +++ {FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [taginst], ELEMS [], DATAS [], STRUCTS [], ARRAYS [], EXNS []}, |s.TAGS_store|)
    -- if (taginst = {TYPE tagtype})

;; 9-module.watsup
rec {

;; 9-module.watsup:64.1-64.82
def $alloctags(store : store, tagtype*) : (store, tagaddr*)
  ;; 9-module.watsup:65.1-65.34
  def $alloctags{s : store}(s, []) = (s, [])
  ;; 9-module.watsup:66.1-68.44
  def $alloctags{s : store, at : tagtype, `at'*` : tagtype*, s_2 : store, aa : tagaddr, `aa'*` : tagaddr*, s_1 : store}(s, [at] ++ at'*{at' <- `at'*`}) = (s_2, [aa] ++ aa'*{aa' <- `aa'*`})
    -- if ((s_1, aa) = $alloctag(s, at))
    -- if ((s_2, aa'*{aa' <- `aa'*`}) = $alloctags(s_1, at'*{at' <- `at'*`}))
}

;; 9-module.watsup
def $allocelem(store : store, elemtype : elemtype, ref*) : (store, elemaddr)
  ;; 9-module.watsup
  def $allocelem{s : store, elemtype : elemtype, `ref*` : ref*, eleminst : eleminst}(s, elemtype, ref*{ref <- `ref*`}) = (s +++ {FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [eleminst], DATAS [], STRUCTS [], ARRAYS [], EXNS []}, |s.ELEMS_store|)
    -- if (eleminst = {TYPE elemtype, REFS ref*{ref <- `ref*`}})

;; 9-module.watsup
rec {

;; 9-module.watsup:75.1-75.97
def $allocelems(store : store, elemtype*, ref**) : (store, elemaddr*)
  ;; 9-module.watsup:76.1-76.40
  def $allocelems{s : store}(s, [], []) = (s, [])
  ;; 9-module.watsup:77.1-79.55
  def $allocelems{s : store, rt : reftype, `rt'*` : reftype*, `ref*` : ref*, `ref'**` : ref**, s_2 : store, ea : elemaddr, `ea'*` : elemaddr*, s_1 : store}(s, [rt] ++ rt'*{rt' <- `rt'*`}, [ref*{ref <- `ref*`}] ++ ref'*{ref' <- `ref'*`}*{`ref'*` <- `ref'**`}) = (s_2, [ea] ++ ea'*{ea' <- `ea'*`})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref <- `ref*`}))
    -- if ((s_2, ea'*{ea' <- `ea'*`}) = $allocelems(s_1, rt'*{rt' <- `rt'*`}, ref'*{ref' <- `ref'*`}*{`ref'*` <- `ref'**`}))
}

;; 9-module.watsup
def $allocdata(store : store, datatype : datatype, byte*) : (store, dataaddr)
  ;; 9-module.watsup
  def $allocdata{s : store, `byte*` : byte*, datainst : datainst}(s, OK_datatype, byte*{byte <- `byte*`}) = (s +++ {FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [datainst], STRUCTS [], ARRAYS [], EXNS []}, |s.DATAS_store|)
    -- if (datainst = {BYTES byte*{byte <- `byte*`}})

;; 9-module.watsup
rec {

;; 9-module.watsup:86.1-86.98
def $allocdatas(store : store, datatype*, byte**) : (store, dataaddr*)
  ;; 9-module.watsup:87.1-87.40
  def $allocdatas{s : store}(s, [], []) = (s, [])
  ;; 9-module.watsup:88.1-90.53
  def $allocdatas{s : store, ok : datatype, `ok'*` : datatype*, `b*` : byte*, `b'**` : byte**, s_2 : store, da : dataaddr, `da'*` : dataaddr*, s_1 : store}(s, [ok] ++ ok'*{ok' <- `ok'*`}, [b*{b <- `b*`}] ++ b'*{b' <- `b'*`}*{`b'*` <- `b'**`}) = (s_2, [da] ++ da'*{da' <- `da'*`})
    -- if ((s_1, da) = $allocdata(s, ok, b*{b <- `b*`}))
    -- if ((s_2, da'*{da' <- `da'*`}) = $allocdatas(s_1, ok'*{ok' <- `ok'*`}, b'*{b' <- `b'*`}*{`b'*` <- `b'**`}))
}

;; 9-module.watsup
def $allocexport(moduleinst : moduleinst, export : export) : exportinst
  ;; 9-module.watsup
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, FUNC_externidx(x))) = {NAME name, ADDR FUNC_externaddr(moduleinst.FUNCS_moduleinst[x!`%`_idx.0])}
  ;; 9-module.watsup
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, GLOBAL_externidx(x))) = {NAME name, ADDR GLOBAL_externaddr(moduleinst.GLOBALS_moduleinst[x!`%`_idx.0])}
  ;; 9-module.watsup
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, TABLE_externidx(x))) = {NAME name, ADDR TABLE_externaddr(moduleinst.TABLES_moduleinst[x!`%`_idx.0])}
  ;; 9-module.watsup
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, MEM_externidx(x))) = {NAME name, ADDR MEM_externaddr(moduleinst.MEMS_moduleinst[x!`%`_idx.0])}
  ;; 9-module.watsup
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, TAG_externidx(x))) = {NAME name, ADDR TAG_externaddr(moduleinst.TAGS_moduleinst[x!`%`_idx.0])}

;; 9-module.watsup
def $allocexports(moduleinst : moduleinst, export*) : exportinst*
  ;; 9-module.watsup
  def $allocexports{moduleinst : moduleinst, `export*` : export*}(moduleinst, export*{export <- `export*`}) = $allocexport(moduleinst, export)*{export <- `export*`}

;; 9-module.watsup
def $allocmodule(store : store, module : module, externaddr*, val*, ref*, ref**) : (store, moduleinst)
  ;; 9-module.watsup
  def $allocmodule{s : store, module : module, `externaddr*` : externaddr*, `val_G*` : val*, `ref_T*` : ref*, `ref_E**` : ref**, s_7 : store, moduleinst : moduleinst, `type*` : type*, `import*` : import*, `func*` : func*, `global*` : global*, `table*` : table*, `mem*` : mem*, `tag*` : tag*, `elem*` : elem*, `data*` : data*, `start?` : start?, `export*` : export*, `x*` : idx*, `local**` : local**, `expr_F*` : expr*, `globaltype*` : globaltype*, `expr_G*` : expr*, `tabletype*` : tabletype*, `expr_T*` : expr*, `memtype*` : memtype*, `y*` : idx*, `elemtype*` : elemtype*, `expr_E**` : expr**, `elemmode*` : elemmode*, `byte**` : byte**, `datamode*` : datamode*, `fa_I*` : funcaddr*, `ga_I*` : globaladdr*, `ta_I*` : tableaddr*, `ma_I*` : memaddr*, `aa_I*` : tagaddr*, `fa*` : nat*, `i_F*` : nat*, `ga*` : nat*, `i_G*` : nat*, `ta*` : nat*, `i_T*` : nat*, `aa*` : nat*, `i_A*` : nat*, `ma*` : nat*, `i_M*` : nat*, `ea*` : nat*, `i_E*` : nat*, `da*` : nat*, `i_D*` : nat*, `dt*` : deftype*, s_1 : store, s_2 : store, s_3 : store, s_4 : store, s_5 : store, s_6 : store, `xi*` : exportinst*}(s, module, externaddr*{externaddr <- `externaddr*`}, val_G*{val_G <- `val_G*`}, ref_T*{ref_T <- `ref_T*`}, ref_E*{ref_E <- `ref_E*`}*{`ref_E*` <- `ref_E**`}) = (s_7, moduleinst)
    -- if (module = MODULE_module(type*{type <- `type*`}, import*{import <- `import*`}, func*{func <- `func*`}, global*{global <- `global*`}, table*{table <- `table*`}, mem*{mem <- `mem*`}, tag*{tag <- `tag*`}, elem*{elem <- `elem*`}, data*{data <- `data*`}, start?{start <- `start?`}, export*{export <- `export*`}))
    -- if (func*{func <- `func*`} = FUNC_func(x, local*{local <- `local*`}, expr_F)*{expr_F <- `expr_F*`, `local*` <- `local**`, x <- `x*`})
    -- if (global*{global <- `global*`} = GLOBAL_global(globaltype, expr_G)*{expr_G <- `expr_G*`, globaltype <- `globaltype*`})
    -- if (table*{table <- `table*`} = TABLE_table(tabletype, expr_T)*{expr_T <- `expr_T*`, tabletype <- `tabletype*`})
    -- if (mem*{mem <- `mem*`} = MEMORY_mem(memtype)*{memtype <- `memtype*`})
    -- if (tag*{tag <- `tag*`} = TAG_tag(y)*{y <- `y*`})
    -- if (elem*{elem <- `elem*`} = ELEM_elem(elemtype, expr_E*{expr_E <- `expr_E*`}, elemmode)*{elemmode <- `elemmode*`, elemtype <- `elemtype*`, `expr_E*` <- `expr_E**`})
    -- if (data*{data <- `data*`} = DATA_data(byte*{byte <- `byte*`}, datamode)*{`byte*` <- `byte**`, datamode <- `datamode*`})
    -- if (fa_I*{fa_I <- `fa_I*`} = $funcsxa(externaddr*{externaddr <- `externaddr*`}))
    -- if (ga_I*{ga_I <- `ga_I*`} = $globalsxa(externaddr*{externaddr <- `externaddr*`}))
    -- if (ta_I*{ta_I <- `ta_I*`} = $tablesxa(externaddr*{externaddr <- `externaddr*`}))
    -- if (ma_I*{ma_I <- `ma_I*`} = $memsxa(externaddr*{externaddr <- `externaddr*`}))
    -- if (aa_I*{aa_I <- `aa_I*`} = $tagsxa(externaddr*{externaddr <- `externaddr*`}))
    -- if (fa*{fa <- `fa*`} = (|s.FUNCS_store| + i_F)^(i_F<|func*{func <- `func*`}|){i_F <- `i_F*`})
    -- if (ga*{ga <- `ga*`} = (|s.GLOBALS_store| + i_G)^(i_G<|global*{global <- `global*`}|){i_G <- `i_G*`})
    -- if (ta*{ta <- `ta*`} = (|s.TABLES_store| + i_T)^(i_T<|table*{table <- `table*`}|){i_T <- `i_T*`})
    -- if (aa*{aa <- `aa*`} = (|s.TAGS_store| + i_A)^(i_A<|tag*{tag <- `tag*`}|){i_A <- `i_A*`})
    -- if (ma*{ma <- `ma*`} = (|s.MEMS_store| + i_M)^(i_M<|mem*{mem <- `mem*`}|){i_M <- `i_M*`})
    -- if (ea*{ea <- `ea*`} = (|s.ELEMS_store| + i_E)^(i_E<|elem*{elem <- `elem*`}|){i_E <- `i_E*`})
    -- if (da*{da <- `da*`} = (|s.DATAS_store| + i_D)^(i_D<|data*{data <- `data*`}|){i_D <- `i_D*`})
    -- if (dt*{dt <- `dt*`} = $alloctypes(type*{type <- `type*`}))
    -- if ((s_1, fa*{fa <- `fa*`}) = $allocfuncs(s, dt*{dt <- `dt*`}[x!`%`_idx.0]*{x <- `x*`}, FUNC_funccode(x, local*{local <- `local*`}, expr_F)*{expr_F <- `expr_F*`, `local*` <- `local**`, x <- `x*`}, moduleinst^|func*{func <- `func*`}|{}))
    -- if ((s_2, ga*{ga <- `ga*`}) = $allocglobals(s_1, $subst_all_globaltype(globaltype, (dt : deftype <: heaptype)*{dt <- `dt*`})*{globaltype <- `globaltype*`}, val_G*{val_G <- `val_G*`}))
    -- if ((s_3, ta*{ta <- `ta*`}) = $alloctables(s_2, $subst_all_tabletype(tabletype, (dt : deftype <: heaptype)*{dt <- `dt*`})*{tabletype <- `tabletype*`}, ref_T*{ref_T <- `ref_T*`}))
    -- if ((s_4, ma*{ma <- `ma*`}) = $allocmems(s_3, $subst_all_memtype(memtype, (dt : deftype <: heaptype)*{dt <- `dt*`})*{memtype <- `memtype*`}))
    -- if ((s_5, aa*{aa <- `aa*`}) = $alloctags(s_4, dt*{dt <- `dt*`}[y!`%`_idx.0]*{y <- `y*`}))
    -- if ((s_6, ea*{ea <- `ea*`}) = $allocelems(s_5, $subst_all_reftype(elemtype, (dt : deftype <: heaptype)*{dt <- `dt*`})*{elemtype <- `elemtype*`}, ref_E*{ref_E <- `ref_E*`}*{`ref_E*` <- `ref_E**`}))
    -- if ((s_7, da*{da <- `da*`}) = $allocdatas(s_6, OK_datatype^|data*{data <- `data*`}|{}, byte*{byte <- `byte*`}*{`byte*` <- `byte**`}))
    -- if (xi*{xi <- `xi*`} = $allocexports({TYPES [], FUNCS fa_I*{fa_I <- `fa_I*`} ++ fa*{fa <- `fa*`}, GLOBALS ga_I*{ga_I <- `ga_I*`} ++ ga*{ga <- `ga*`}, TABLES ta_I*{ta_I <- `ta_I*`} ++ ta*{ta <- `ta*`}, MEMS ma_I*{ma_I <- `ma_I*`} ++ ma*{ma <- `ma*`}, TAGS aa_I*{aa_I <- `aa_I*`} ++ aa*{aa <- `aa*`}, ELEMS [], DATAS [], EXPORTS []}, export*{export <- `export*`}))
    -- if (moduleinst = {TYPES dt*{dt <- `dt*`}, FUNCS fa_I*{fa_I <- `fa_I*`} ++ fa*{fa <- `fa*`}, GLOBALS ga_I*{ga_I <- `ga_I*`} ++ ga*{ga <- `ga*`}, TABLES ta_I*{ta_I <- `ta_I*`} ++ ta*{ta <- `ta*`}, MEMS ma_I*{ma_I <- `ma_I*`} ++ ma*{ma <- `ma*`}, TAGS aa_I*{aa_I <- `aa_I*`} ++ aa*{aa <- `aa*`}, ELEMS ea*{ea <- `ea*`}, DATAS da*{da <- `da*`}, EXPORTS xi*{xi <- `xi*`}})

;; 9-module.watsup
def $runelem_(elemidx : elemidx, elem : elem) : instr*
  ;; 9-module.watsup
  def $runelem_{x : idx, rt : reftype, `e*` : expr*, n : n}(x, ELEM_elem(rt, e^n{e <- `e*`}, PASSIVE_elemmode)) = []
  ;; 9-module.watsup
  def $runelem_{x : idx, rt : reftype, `e*` : expr*, n : n}(x, ELEM_elem(rt, e^n{e <- `e*`}, DECLARE_elemmode)) = [ELEM.DROP_instr(x)]
  ;; 9-module.watsup
  def $runelem_{x : idx, rt : reftype, `e*` : expr*, n : n, y : idx, `instr*` : instr*}(x, ELEM_elem(rt, e^n{e <- `e*`}, ACTIVE_elemmode(y, instr*{instr <- `instr*`}))) = instr*{instr <- `instr*`} ++ [CONST_instr(I32_numtype, `%`_num_(0)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.INIT_instr(y, x) ELEM.DROP_instr(x)]

;; 9-module.watsup
def $rundata_(dataidx : dataidx, data : data) : instr*
  ;; 9-module.watsup
  def $rundata_{x : idx, `b*` : byte*, n : n}(x, DATA_data(b^n{b <- `b*`}, PASSIVE_datamode)) = []
  ;; 9-module.watsup
  def $rundata_{x : idx, `b*` : byte*, n : n, y : idx, `instr*` : instr*}(x, DATA_data(b^n{b <- `b*`}, ACTIVE_datamode(y, instr*{instr <- `instr*`}))) = instr*{instr <- `instr*`} ++ [CONST_instr(I32_numtype, `%`_num_(0)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.INIT_instr(y, x) DATA.DROP_instr(x)]

;; 9-module.watsup
rec {

;; 9-module.watsup:170.1-170.94
def $evalglobals(state : state, globaltype*, expr*) : (state, val*)
  ;; 9-module.watsup:171.1-171.41
  def $evalglobals{z : state}(z, [], []) = (z, [])
  ;; 9-module.watsup:172.1-177.81
  def $evalglobals{z : state, gt : globaltype, `gt'*` : globaltype*, expr : expr, `expr'*` : expr*, z' : state, val : val, `val'*` : val*, s : store, f : frame, s' : store, a : addr}(z, [gt] ++ gt'*{gt' <- `gt'*`}, [expr] ++ expr'*{expr' <- `expr'*`}) = (z', [val] ++ val'*{val' <- `val'*`})
    -- Eval_expr: `%;%~>*%;%`(z, expr, z, [val])
    -- if (z = `%;%`_state(s, f))
    -- if ((s', a) = $allocglobal(s, gt, val))
    -- if ((z', val'*{val' <- `val'*`}) = $evalglobals(`%;%`_state(s', f[MODULE_frame.GLOBALS_moduleinst =++ [a]]), gt'*{gt' <- `gt'*`}, expr'*{expr' <- `expr'*`}))
}

;; 9-module.watsup
def $instantiate(store : store, module : module, externaddr*) : config
  ;; 9-module.watsup
  def $instantiate{s : store, module : module, `externaddr*` : externaddr*, s' : store, f : frame, `instr_E*` : instr*, `instr_D*` : instr*, `instr_S?` : instr?, `xt_I*` : externtype*, `xt_E*` : externtype*, `type*` : type*, `import*` : import*, `func*` : func*, `global*` : global*, `table*` : table*, `mem*` : mem*, `tag*` : tag*, `elem*` : elem*, `data*` : data*, `start?` : start?, `export*` : export*, `globaltype*` : globaltype*, `expr_G*` : expr*, `tabletype*` : tabletype*, `expr_T*` : expr*, `reftype*` : reftype*, `expr_E**` : expr**, `elemmode*` : elemmode*, `byte**` : byte**, `datamode*` : datamode*, `x?` : idx?, moduleinst_0 : moduleinst, `i_F*` : nat*, z : state, z' : state, `val_G*` : val*, `ref_T*` : ref*, `ref_E**` : ref**, moduleinst : moduleinst, `i_E*` : nat*, `i_D*` : nat*}(s, module, externaddr*{externaddr <- `externaddr*`}) = `%;%`_config(`%;%`_state(s', f), instr_E*{instr_E <- `instr_E*`} ++ instr_D*{instr_D <- `instr_D*`} ++ instr_S?{instr_S <- `instr_S?`})
    -- Module_ok: `|-%:%`(module, `%->%`_moduletype(xt_I*{xt_I <- `xt_I*`}, xt_E*{xt_E <- `xt_E*`}))
    -- (Externaddr_type: `%|-%:%`(s, externaddr, xt_I))*{externaddr <- `externaddr*`, xt_I <- `xt_I*`}
    -- if (module = MODULE_module(type*{type <- `type*`}, import*{import <- `import*`}, func*{func <- `func*`}, global*{global <- `global*`}, table*{table <- `table*`}, mem*{mem <- `mem*`}, tag*{tag <- `tag*`}, elem*{elem <- `elem*`}, data*{data <- `data*`}, start?{start <- `start?`}, export*{export <- `export*`}))
    -- if (global*{global <- `global*`} = GLOBAL_global(globaltype, expr_G)*{expr_G <- `expr_G*`, globaltype <- `globaltype*`})
    -- if (table*{table <- `table*`} = TABLE_table(tabletype, expr_T)*{expr_T <- `expr_T*`, tabletype <- `tabletype*`})
    -- if (elem*{elem <- `elem*`} = ELEM_elem(reftype, expr_E*{expr_E <- `expr_E*`}, elemmode)*{elemmode <- `elemmode*`, `expr_E*` <- `expr_E**`, reftype <- `reftype*`})
    -- if (data*{data <- `data*`} = DATA_data(byte*{byte <- `byte*`}, datamode)*{`byte*` <- `byte**`, datamode <- `datamode*`})
    -- if (start?{start <- `start?`} = START_start(x)?{x <- `x?`})
    -- if (moduleinst_0 = {TYPES $alloctypes(type*{type <- `type*`}), FUNCS $funcsxa(externaddr*{externaddr <- `externaddr*`}) ++ (|s.FUNCS_store| + i_F)^(i_F<|func*{func <- `func*`}|){i_F <- `i_F*`}, GLOBALS $globalsxa(externaddr*{externaddr <- `externaddr*`}), TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], EXPORTS []})
    -- if (z = `%;%`_state(s, {LOCALS [], MODULE moduleinst_0}))
    -- if ((z', val_G*{val_G <- `val_G*`}) = $evalglobals(z, globaltype*{globaltype <- `globaltype*`}, expr_G*{expr_G <- `expr_G*`}))
    -- (Eval_expr: `%;%~>*%;%`(z', expr_T, z', [(ref_T : ref <: val)]))*{expr_T <- `expr_T*`, ref_T <- `ref_T*`}
    -- (Eval_expr: `%;%~>*%;%`(z', expr_E, z', [(ref_E : ref <: val)]))*{expr_E <- `expr_E*`, ref_E <- `ref_E*`}*{`expr_E*` <- `expr_E**`, `ref_E*` <- `ref_E**`}
    -- if ((s', moduleinst) = $allocmodule(s, module, externaddr*{externaddr <- `externaddr*`}, val_G*{val_G <- `val_G*`}, ref_T*{ref_T <- `ref_T*`}, ref_E*{ref_E <- `ref_E*`}*{`ref_E*` <- `ref_E**`}))
    -- if (f = {LOCALS [], MODULE moduleinst})
    -- if (instr_E*{instr_E <- `instr_E*`} = $concat_(syntax instr, $runelem_(`%`_elemidx(i_E), elem*{elem <- `elem*`}[i_E])^(i_E<|elem*{elem <- `elem*`}|){i_E <- `i_E*`}))
    -- if (instr_D*{instr_D <- `instr_D*`} = $concat_(syntax instr, $rundata_(`%`_dataidx(i_D), data*{data <- `data*`}[i_D])^(i_D<|data*{data <- `data*`}|){i_D <- `i_D*`}))
    -- if (instr_S?{instr_S <- `instr_S?`} = CALL_instr(x)?{x <- `x?`})

;; 9-module.watsup
def $invoke(store : store, funcaddr : funcaddr, val*) : config
  ;; 9-module.watsup
  def $invoke{s : store, funcaddr : funcaddr, `val*` : val*, f : frame, `t_1*` : valtype*, `t_2*` : valtype*}(s, funcaddr, val*{val <- `val*`}) = `%;%`_config(`%;%`_state(s, f), (val : val <: instr)*{val <- `val*`} ++ [REF.FUNC_ADDR_instr(funcaddr) CALL_REF_instr((s.FUNCS_store[funcaddr].TYPE_funcinst : deftype <: typeuse))])
    -- Expand: `%~~%`(s.FUNCS_store[funcaddr].TYPE_funcinst, FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))))
    -- (Val_type: `%|-%:%`(s, val, t_1))*{t_1 <- `t_1*`, val <- `val*`}
    -- if (f = {LOCALS [], MODULE {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], EXPORTS []}})

;; A-binary.watsup
grammar Bbyte : byte
  ;; A-binary.watsup
  prod{b : byte} b!`%`_byte.0:0x00 | ... | b!`%`_byte.0:0xFF => b

;; A-binary.watsup
rec {

;; A-binary.watsup:20.1-22.82
grammar BuN(N : N) : uN(N)
  ;; A-binary.watsup:21.5-21.83
  prod{n : n} `%`_byte(n):Bbyte => `%`_uN(n)
    -- if ((n < (2 ^ 7)) /\ (n < (2 ^ N)))
  ;; A-binary.watsup:22.5-22.82
  prod{n : n, m : m} {`%`_byte(n):Bbyte `%`_uN(m):BuN((N - 7))} => `%`_uN((((2 ^ 7) * m) + (n - (2 ^ 7))))
    -- if ((n >= (2 ^ 7)) /\ (N > 7))
}

;; A-binary.watsup
grammar Bu32 : u32
  ;; A-binary.watsup
  prod{n : n} `%`_uN(n):BuN(32) => `%`_u32(n)

;; A-binary.watsup
grammar Blist(syntax el, grammar BX : el) : el*
  ;; A-binary.watsup
  prod{n : n, `el*` : el*} {`%`_u32(n):Bu32 el:BX^n{el <- `el*`}} => el^n{el <- `el*`}

;; A-binary.watsup
grammar BsN(N : N) : sN(N)
  ;; A-binary.watsup
  prod{n : n} `%`_byte(n):Bbyte => `%`_sN((n : n <: int))
    -- if ((n < (2 ^ 6)) /\ (n < (2 ^ (N - 1))))
  ;; A-binary.watsup
  prod{n : n} `%`_byte(n):Bbyte => `%`_sN(((n - (2 ^ 7)) : nat <: int))
    -- if ((((2 ^ 6) <= n) /\ (n < (2 ^ 7))) /\ (n >= ((2 ^ 7) - (2 ^ (N - 1)))))
  ;; A-binary.watsup
  prod{n : n, i : nat} {`%`_byte(n):Bbyte `%`_uN(i):BuN((N - 7))} => `%`_sN(((((2 ^ 7) * i) + (n - (2 ^ 7))) : nat <: int))
    -- if ((n >= (2 ^ 7)) /\ (N > 7))

;; A-binary.watsup
grammar BiN(N : N) : iN(N)
  ;; A-binary.watsup
  prod{i : nat} `%`_sN((i : nat <: int)):BsN(N) => `%`_iN($invsigned_(N, (i : nat <: int)))

;; A-binary.watsup
grammar BfN(N : N) : fN(N)
  ;; A-binary.watsup
  prod{`b*` : byte*} b*{b <- `b*`}:Bbyte^(N / 8){} => $invfbytes_(N, b*{b <- `b*`})

;; A-binary.watsup
grammar Bu64 : u64
  ;; A-binary.watsup
  prod{n : n} `%`_uN(n):BuN(64) => `%`_u64(n)

;; A-binary.watsup
grammar Bs33 : s33
  ;; A-binary.watsup
  prod{i : nat} `%`_sN((i : nat <: int)):BsN(33) => `%`_s33((i : nat <: int))

;; A-binary.watsup
grammar Bf32 : f32
  ;; A-binary.watsup
  prod{p : fN(32)} p:BfN(32) => p

;; A-binary.watsup
grammar Bf64 : f64
  ;; A-binary.watsup
  prod{p : fN(64)} p:BfN(64) => p

;; A-binary.watsup
grammar Bname : name
  ;; A-binary.watsup
  prod{`b*` : byte*, name : name} b*{b <- `b*`}:Blist(syntax byte, grammar Bbyte) => name
    -- if ($utf8(name!`%`_name.0) = b*{b <- `b*`})

;; A-binary.watsup
grammar Btypeidx : typeidx
  ;; A-binary.watsup
  prod{x : idx} x:Bu32 => x

;; A-binary.watsup
grammar Bfuncidx : funcidx
  ;; A-binary.watsup
  prod{x : idx} x:Bu32 => x

;; A-binary.watsup
grammar Bglobalidx : globalidx
  ;; A-binary.watsup
  prod{x : idx} x:Bu32 => x

;; A-binary.watsup
grammar Btableidx : tableidx
  ;; A-binary.watsup
  prod{x : idx} x:Bu32 => x

;; A-binary.watsup
grammar Bmemidx : memidx
  ;; A-binary.watsup
  prod{x : idx} x:Bu32 => x

;; A-binary.watsup
grammar Btagidx : tagidx
  ;; A-binary.watsup
  prod{x : idx} x:Bu32 => x

;; A-binary.watsup
grammar Belemidx : elemidx
  ;; A-binary.watsup
  prod{x : idx} x:Bu32 => x

;; A-binary.watsup
grammar Bdataidx : dataidx
  ;; A-binary.watsup
  prod{x : idx} x:Bu32 => x

;; A-binary.watsup
grammar Blocalidx : localidx
  ;; A-binary.watsup
  prod{x : idx} x:Bu32 => x

;; A-binary.watsup
grammar Blabelidx : labelidx
  ;; A-binary.watsup
  prod{l : labelidx} l:Bu32 => l

;; A-binary.watsup
grammar Bexternidx : externidx
  ;; A-binary.watsup
  prod{x : idx} {0x00 x:Bfuncidx} => FUNC_externidx(x)
  ;; A-binary.watsup
  prod{x : idx} {0x01 x:Btableidx} => TABLE_externidx(x)
  ;; A-binary.watsup
  prod{x : idx} {0x02 x:Bmemidx} => MEM_externidx(x)
  ;; A-binary.watsup
  prod{x : idx} {0x03 x:Bglobalidx} => GLOBAL_externidx(x)
  ;; A-binary.watsup
  prod{x : idx} {0x04 x:Btagidx} => TAG_externidx(x)

;; A-binary.watsup
grammar Bnumtype : numtype
  ;; A-binary.watsup
  prod 0x7C => F64_numtype
  ;; A-binary.watsup
  prod 0x7D => F32_numtype
  ;; A-binary.watsup
  prod 0x7E => I64_numtype
  ;; A-binary.watsup
  prod 0x7F => I32_numtype

;; A-binary.watsup
grammar Bvectype : vectype
  ;; A-binary.watsup
  prod 0x7B => V128_vectype

;; A-binary.watsup
grammar Babsheaptype : heaptype
  ;; A-binary.watsup
  prod 0x69 => EXN_heaptype
  ;; A-binary.watsup
  prod 0x6A => ARRAY_heaptype
  ;; A-binary.watsup
  prod 0x6B => STRUCT_heaptype
  ;; A-binary.watsup
  prod 0x6C => I31_heaptype
  ;; A-binary.watsup
  prod 0x6D => EQ_heaptype
  ;; A-binary.watsup
  prod 0x6E => ANY_heaptype
  ;; A-binary.watsup
  prod 0x6F => EXTERN_heaptype
  ;; A-binary.watsup
  prod 0x70 => FUNC_heaptype
  ;; A-binary.watsup
  prod 0x71 => NONE_heaptype
  ;; A-binary.watsup
  prod 0x72 => NOEXTERN_heaptype
  ;; A-binary.watsup
  prod 0x73 => NOFUNC_heaptype
  ;; A-binary.watsup
  prod 0x74 => NOEXN_heaptype

;; A-binary.watsup
grammar Bheaptype : heaptype
  ;; A-binary.watsup
  prod{ht : heaptype} ht:Babsheaptype => ht
  ;; A-binary.watsup
  prod{x33 : s33} x33:Bs33 => _IDX_heaptype($s33_to_u32(x33))
    -- if (x33!`%`_s33.0 >= (0 : nat <: int))

;; A-binary.watsup
grammar Breftype : reftype
  ;; A-binary.watsup
  prod{ht : heaptype} {0x63 ht:Bheaptype} => REF_reftype(`NULL%?`_nul(?(())), ht)
  ;; A-binary.watsup
  prod{ht : heaptype} {0x64 ht:Bheaptype} => REF_reftype(`NULL%?`_nul(?()), ht)
  ;; A-binary.watsup
  prod{ht : heaptype} ht:Babsheaptype => REF_reftype(`NULL%?`_nul(?(())), ht)

;; A-binary.watsup
grammar Bvaltype : valtype
  ;; A-binary.watsup
  prod{nt : numtype} nt:Bnumtype => (nt : numtype <: valtype)
  ;; A-binary.watsup
  prod{vt : vectype} vt:Bvectype => (vt : vectype <: valtype)
  ;; A-binary.watsup
  prod{rt : reftype} rt:Breftype => (rt : reftype <: valtype)

;; A-binary.watsup
grammar Bresulttype : resulttype
  ;; A-binary.watsup
  prod{`t*` : valtype*} t*{t <- `t*`}:Blist(syntax valtype, grammar Bvaltype) => `%`_resulttype(t*{t <- `t*`})

;; A-binary.watsup
grammar Bmut : mut
  ;; A-binary.watsup
  prod 0x00 => `MUT%?`_mut(?())
  ;; A-binary.watsup
  prod 0x01 => `MUT%?`_mut(?(()))

;; A-binary.watsup
grammar Bpacktype : packtype
  ;; A-binary.watsup
  prod 0x77 => I16_packtype
  ;; A-binary.watsup
  prod 0x78 => I8_packtype

;; A-binary.watsup
grammar Bstoragetype : storagetype
  ;; A-binary.watsup
  prod{t : valtype} t:Bvaltype => (t : valtype <: storagetype)
  ;; A-binary.watsup
  prod{pt : packtype} pt:Bpacktype => (pt : packtype <: storagetype)

;; A-binary.watsup
grammar Bfieldtype : fieldtype
  ;; A-binary.watsup
  prod{zt : storagetype, mut : mut} {zt:Bstoragetype mut:Bmut} => `%%`_fieldtype(mut, zt)

;; A-binary.watsup
grammar Bcomptype : comptype
  ;; A-binary.watsup
  prod{yt : fieldtype} {0x5E yt:Bfieldtype} => ARRAY_comptype(yt)
  ;; A-binary.watsup
  prod{`yt*` : fieldtype*} {0x5F yt*{yt <- `yt*`}:Blist(syntax fieldtype, grammar Bfieldtype)} => STRUCT_comptype(`%`_structtype(yt*{yt <- `yt*`}))
  ;; A-binary.watsup
  prod{`t_1*` : valtype*, `t_2*` : valtype*} {0x60 `%`_resulttype(t_1*{t_1 <- `t_1*`}):Bresulttype `%`_resulttype(t_2*{t_2 <- `t_2*`}):Bresulttype} => FUNC_comptype(`%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))

;; A-binary.watsup
grammar Bsubtype : subtype
  ;; A-binary.watsup
  prod{`x*` : idx*, ct : comptype} {0x4F x*{x <- `x*`}:Blist(syntax typeidx, grammar Btypeidx) ct:Bcomptype} => SUB_subtype(`FINAL%?`_fin(?(())), _IDX_typeuse(x)*{x <- `x*`}, ct)
  ;; A-binary.watsup
  prod{`x*` : idx*, ct : comptype} {0x50 x*{x <- `x*`}:Blist(syntax typeidx, grammar Btypeidx) ct:Bcomptype} => SUB_subtype(`FINAL%?`_fin(?()), _IDX_typeuse(x)*{x <- `x*`}, ct)
  ;; A-binary.watsup
  prod{ct : comptype} ct:Bcomptype => SUB_subtype(`FINAL%?`_fin(?(())), [], ct)

;; A-binary.watsup
grammar Brectype : rectype
  ;; A-binary.watsup
  prod{`st*` : subtype*} {0x4E st*{st <- `st*`}:Blist(syntax subtype, grammar Bsubtype)} => REC_rectype(`%`_list(st*{st <- `st*`}))
  ;; A-binary.watsup
  prod{st : subtype} st:Bsubtype => REC_rectype(`%`_list([st]))

;; A-binary.watsup
grammar Blimits : limits
  ;; A-binary.watsup
  prod{n : n} {0x00 `%`_u32(n):Bu32} => `[%..%]`_limits(`%`_u32(n), `%`_u32(((2 ^ 32) - 1)))
  ;; A-binary.watsup
  prod{n : n, m : m} {0x01 `%`_u32(n):Bu32 `%`_u32(m):Bu32} => `[%..%]`_limits(`%`_u32(n), `%`_u32(m))

;; A-binary.watsup
grammar Bglobaltype : globaltype
  ;; A-binary.watsup
  prod{t : valtype, mut : mut} {t:Bvaltype mut:Bmut} => `%%`_globaltype(mut, t)

;; A-binary.watsup
grammar Btabletype : tabletype
  ;; A-binary.watsup
  prod{rt : reftype, lim : limits} {rt:Breftype lim:Blimits} => `%%`_tabletype(lim, rt)

;; A-binary.watsup
grammar Bmemtype : memtype
  ;; A-binary.watsup
  prod{lim : limits} lim:Blimits => `%PAGE`_memtype(lim)

;; A-binary.watsup
grammar Btagtype : typeidx
  ;; A-binary.watsup
  prod{x : idx} {0x00 x:Btypeidx} => x

;; A-binary.watsup
grammar Bexterntype : externtype
  ;; A-binary.watsup
  prod{x : idx} {0x00 x:Btypeidx} => FUNC_externtype(_IDX_typeuse(x))
  ;; A-binary.watsup
  prod{tt : tabletype} {0x01 tt:Btabletype} => TABLE_externtype(tt)
  ;; A-binary.watsup
  prod{mt : memtype} {0x02 mt:Bmemtype} => MEM_externtype(mt)
  ;; A-binary.watsup
  prod{gt : globaltype} {0x03 gt:Bglobaltype} => GLOBAL_externtype(gt)
  ;; A-binary.watsup
  prod{x : idx} {0x04 x:Btagtype} => TAG_externtype(_IDX_typeuse(x))

;; A-binary.watsup
grammar Bblocktype : blocktype
  ;; A-binary.watsup
  prod 0x40 => _RESULT_blocktype(?())
  ;; A-binary.watsup
  prod{t : valtype} t:Bvaltype => _RESULT_blocktype(?(t))
  ;; A-binary.watsup
  prod{i : nat} `%`_s33((i : nat <: int)):Bs33 => _IDX_blocktype(`%`_funcidx(i))
    -- if (i >= 0)

;; A-binary.watsup
grammar Bcatch : catch
  ;; A-binary.watsup
  prod{x : idx, l : labelidx} {0x00 x:Btagidx l:Blabelidx} => CATCH_catch(x, l)
  ;; A-binary.watsup
  prod{x : idx, l : labelidx} {0x01 x:Btagidx l:Blabelidx} => CATCH_REF_catch(x, l)
  ;; A-binary.watsup
  prod{l : labelidx} {0x02 l:Blabelidx} => CATCH_ALL_catch(l)
  ;; A-binary.watsup
  prod{l : labelidx} {0x03 l:Blabelidx} => CATCH_ALL_REF_catch(l)

;; A-binary.watsup
syntax castop = (nul, nul)

;; A-binary.watsup
grammar Bcastop : castop
  ;; A-binary.watsup
  prod 0x00 => (`NULL%?`_nul(?()), `NULL%?`_nul(?()))
  ;; A-binary.watsup
  prod 0x01 => (`NULL%?`_nul(?(())), `NULL%?`_nul(?()))
  ;; A-binary.watsup
  prod 0x02 => (`NULL%?`_nul(?()), `NULL%?`_nul(?(())))
  ;; A-binary.watsup
  prod 0x03 => (`NULL%?`_nul(?(())), `NULL%?`_nul(?(())))

;; A-binary.watsup
syntax memidxop = (memidx, memarg)

;; A-binary.watsup
grammar Bmemarg : memidxop
  ;; A-binary.watsup
  prod{n : n, m : m} {`%`_u32(n):Bu32 `%`_u32(m):Bu32} => (`%`_memidx(0), {ALIGN `%`_u32(n), OFFSET `%`_u32(m)})
    -- if (n < (2 ^ 6))
  ;; A-binary.watsup
  prod{n : n, x : idx, m : m} {`%`_u32(n):Bu32 x:Bmemidx `%`_u32(m):Bu32} => (x, {ALIGN `%`_u32((n - (2 ^ 6))), OFFSET `%`_u32(m)})
    -- if (((2 ^ 6) <= n) /\ (n < (2 ^ 7)))

;; A-binary.watsup
grammar Blaneidx : laneidx
  ;; A-binary.watsup
  prod{l : labelidx} `%`_byte(l!`%`_labelidx.0):Bbyte => `%`_laneidx(l!`%`_labelidx.0)

;; A-binary.watsup
rec {

;; A-binary.watsup:992.1-1006.73
grammar Binstr : instr
  ;; A-binary.watsup:214.5-214.24
  prod 0x00 => UNREACHABLE_instr
  ;; A-binary.watsup:215.5-215.16
  prod 0x01 => NOP_instr
  ;; A-binary.watsup:216.5-216.57
  prod{bt : blocktype, `in*` : instr*} {0x02 bt:Bblocktype in:Binstr*{in <- `in*`} 0x0B} => BLOCK_instr(bt, in*{in <- `in*`})
  ;; A-binary.watsup:217.5-217.56
  prod{bt : blocktype, `in*` : instr*} {0x03 bt:Bblocktype in:Binstr*{in <- `in*`} 0x0B} => LOOP_instr(bt, in*{in <- `in*`})
  ;; A-binary.watsup:218.5-218.63
  prod{bt : blocktype, `in*` : instr*} {0x04 bt:Bblocktype in:Binstr*{in <- `in*`} 0x0B} => `IF%%ELSE%`_instr(bt, in*{in <- `in*`}, [])
  ;; A-binary.watsup:219.5-220.55
  prod{bt : blocktype, `in_1*` : instr*, `in_2*` : instr*} {0x04 bt:Bblocktype in_1:Binstr*{in_1 <- `in_1*`} 0x05 in_2:Binstr*{in_2 <- `in_2*`} 0x0B} => `IF%%ELSE%`_instr(bt, in_1*{in_1 <- `in_1*`}, in_2*{in_2 <- `in_2*`})
  ;; A-binary.watsup:221.5-221.30
  prod{x : idx} {0x08 x:Btagidx} => THROW_instr(x)
  ;; A-binary.watsup:222.5-222.22
  prod 0x0A => THROW_REF_instr
  ;; A-binary.watsup:223.5-223.29
  prod{l : labelidx} {0x0C l:Blabelidx} => BR_instr(l)
  ;; A-binary.watsup:224.5-224.32
  prod{l : labelidx} {0x0D l:Blabelidx} => BR_IF_instr(l)
  ;; A-binary.watsup:225.5-225.62
  prod{`l*` : labelidx*, l_n : labelidx} {0x0E l*{l <- `l*`}:Blist(syntax labelidx, grammar Blabelidx) l_n:Blabelidx} => BR_TABLE_instr(l*{l <- `l*`}, l_n)
  ;; A-binary.watsup:226.5-226.19
  prod 0x0F => RETURN_instr
  ;; A-binary.watsup:227.5-227.30
  prod{x : idx} {0x10 x:Bfuncidx} => CALL_instr(x)
  ;; A-binary.watsup:228.5-228.60
  prod{y : idx, x : idx} {0x11 y:Btypeidx x:Btableidx} => CALL_INDIRECT_instr(x, _IDX_typeuse(y))
  ;; A-binary.watsup:229.5-229.37
  prod{x : idx} {0x12 x:Bfuncidx} => RETURN_CALL_instr(x)
  ;; A-binary.watsup:230.5-230.67
  prod{y : idx, x : idx} {0x13 y:Btypeidx x:Btableidx} => RETURN_CALL_INDIRECT_instr(x, _IDX_typeuse(y))
  ;; A-binary.watsup:231.5-231.81
  prod{bt : blocktype, `c*` : catch*, `in*` : instr*} {0x1F bt:Bblocktype c*{c <- `c*`}:Blist(syntax catch, grammar Bcatch) in:Binstr*{in <- `in*`} 0x0B} => TRY_TABLE_instr(bt, `%`_list(c*{c <- `c*`}), in*{in <- `in*`})
  ;; A-binary.watsup:252.5-252.37
  prod{ht : heaptype} {0xD0 ht:Bheaptype} => REF.NULL_instr(ht)
  ;; A-binary.watsup:253.5-253.24
  prod 0xD1 => REF.IS_NULL_instr
  ;; A-binary.watsup:254.5-254.34
  prod{x : idx} {0xD2 x:Bfuncidx} => REF.FUNC_instr(x)
  ;; A-binary.watsup:255.5-255.19
  prod 0xD3 => REF.EQ_instr
  ;; A-binary.watsup:256.5-256.28
  prod 0xD4 => REF.AS_NON_NULL_instr
  ;; A-binary.watsup:257.5-257.37
  prod{l : labelidx} {0xD5 l:Blabelidx} => BR_ON_NULL_instr(l)
  ;; A-binary.watsup:258.5-258.41
  prod{l : labelidx} {0xD6 l:Blabelidx} => BR_ON_NON_NULL_instr(l)
  ;; A-binary.watsup:262.5-262.43
  prod{x : idx} {0xFB `%`_u32(0):Bu32 x:Btypeidx} => STRUCT.NEW_instr(x)
  ;; A-binary.watsup:263.5-263.51
  prod{x : idx} {0xFB `%`_u32(1):Bu32 x:Btypeidx} => STRUCT.NEW_DEFAULT_instr(x)
  ;; A-binary.watsup:264.5-264.52
  prod{x : idx, i : nat} {0xFB `%`_u32(2):Bu32 x:Btypeidx `%`_u32(i):Bu32} => STRUCT.GET_instr(?(), x, `%`_u32(i))
  ;; A-binary.watsup:265.5-265.54
  prod{x : idx, i : nat} {0xFB `%`_u32(3):Bu32 x:Btypeidx `%`_u32(i):Bu32} => STRUCT.GET_instr(?(S_sx), x, `%`_u32(i))
  ;; A-binary.watsup:266.5-266.54
  prod{x : idx, i : nat} {0xFB `%`_u32(4):Bu32 x:Btypeidx `%`_u32(i):Bu32} => STRUCT.GET_instr(?(U_sx), x, `%`_u32(i))
  ;; A-binary.watsup:267.5-267.52
  prod{x : idx, i : nat} {0xFB `%`_u32(5):Bu32 x:Btypeidx `%`_u32(i):Bu32} => STRUCT.SET_instr(x, `%`_u32(i))
  ;; A-binary.watsup:271.5-271.42
  prod{x : idx} {0xFB `%`_u32(6):Bu32 x:Btypeidx} => ARRAY.NEW_instr(x)
  ;; A-binary.watsup:272.5-272.50
  prod{x : idx} {0xFB `%`_u32(7):Bu32 x:Btypeidx} => ARRAY.NEW_DEFAULT_instr(x)
  ;; A-binary.watsup:273.5-273.57
  prod{x : idx, n : n} {0xFB `%`_u32(8):Bu32 x:Btypeidx `%`_u32(n):Bu32} => ARRAY.NEW_FIXED_instr(x, `%`_u32(n))
  ;; A-binary.watsup:274.5-274.60
  prod{x : idx, y : idx} {0xFB `%`_u32(9):Bu32 x:Btypeidx y:Bdataidx} => ARRAY.NEW_DATA_instr(x, y)
  ;; A-binary.watsup:275.5-275.61
  prod{x : idx, y : idx} {0xFB `%`_u32(10):Bu32 x:Btypeidx y:Belemidx} => ARRAY.NEW_ELEM_instr(x, y)
  ;; A-binary.watsup:276.5-276.43
  prod{x : idx} {0xFB `%`_u32(11):Bu32 x:Btypeidx} => ARRAY.GET_instr(?(), x)
  ;; A-binary.watsup:277.5-277.45
  prod{x : idx} {0xFB `%`_u32(12):Bu32 x:Btypeidx} => ARRAY.GET_instr(?(S_sx), x)
  ;; A-binary.watsup:278.5-278.45
  prod{x : idx} {0xFB `%`_u32(13):Bu32 x:Btypeidx} => ARRAY.GET_instr(?(U_sx), x)
  ;; A-binary.watsup:279.5-279.43
  prod{x : idx} {0xFB `%`_u32(14):Bu32 x:Btypeidx} => ARRAY.SET_instr(x)
  ;; A-binary.watsup:280.5-280.30
  prod {0xFB `%`_u32(15):Bu32} => ARRAY.LEN_instr
  ;; A-binary.watsup:281.5-281.44
  prod{x : idx} {0xFB `%`_u32(16):Bu32 x:Btypeidx} => ARRAY.FILL_instr(x)
  ;; A-binary.watsup:282.5-282.65
  prod{x_1 : idx, x_2 : idx} {0xFB `%`_u32(17):Bu32 x_1:Btypeidx x_2:Btypeidx} => ARRAY.COPY_instr(x_1, x_2)
  ;; A-binary.watsup:283.5-283.62
  prod{x : idx, y : idx} {0xFB `%`_u32(18):Bu32 x:Btypeidx y:Bdataidx} => ARRAY.INIT_DATA_instr(x, y)
  ;; A-binary.watsup:284.5-284.62
  prod{x : idx, y : idx} {0xFB `%`_u32(19):Bu32 x:Btypeidx y:Belemidx} => ARRAY.INIT_ELEM_instr(x, y)
  ;; A-binary.watsup:288.5-288.51
  prod{ht : heaptype} {0xFB `%`_u32(20):Bu32 ht:Bheaptype} => REF.TEST_instr(REF_reftype(`NULL%?`_nul(?()), ht))
  ;; A-binary.watsup:289.5-289.56
  prod{ht : heaptype} {0xFB `%`_u32(21):Bu32 ht:Bheaptype} => REF.TEST_instr(REF_reftype(`NULL%?`_nul(?(())), ht))
  ;; A-binary.watsup:290.5-290.51
  prod{ht : heaptype} {0xFB `%`_u32(22):Bu32 ht:Bheaptype} => REF.CAST_instr(REF_reftype(`NULL%?`_nul(?()), ht))
  ;; A-binary.watsup:291.5-291.56
  prod{ht : heaptype} {0xFB `%`_u32(23):Bu32 ht:Bheaptype} => REF.CAST_instr(REF_reftype(`NULL%?`_nul(?(())), ht))
  ;; A-binary.watsup:292.5-293.94
  prod{nul1 : nul1, nul2 : nul2, l : labelidx, ht_1 : heaptype, ht_2 : heaptype} {0xFB `%`_u32(24):Bu32 (nul1, nul2):Bcastop l:Blabelidx ht_1:Bheaptype ht_2:Bheaptype} => BR_ON_CAST_instr(l, REF_reftype(nul1, ht_1), REF_reftype(nul2, ht_2))
  ;; A-binary.watsup:294.5-295.99
  prod{nul1 : nul1, nul2 : nul2, l : labelidx, ht_1 : heaptype, ht_2 : heaptype} {0xFB `%`_u32(25):Bu32 (nul1, nul2):Bcastop l:Blabelidx ht_1:Bheaptype ht_2:Bheaptype} => BR_ON_CAST_FAIL_instr(l, REF_reftype(nul1, ht_1), REF_reftype(nul2, ht_2))
  ;; A-binary.watsup:299.5-299.39
  prod {0xFB `%`_u32(26):Bu32} => ANY.CONVERT_EXTERN_instr
  ;; A-binary.watsup:300.5-300.39
  prod {0xFB `%`_u32(27):Bu32} => EXTERN.CONVERT_ANY_instr
  ;; A-binary.watsup:304.5-304.28
  prod {0xFB `%`_u32(28):Bu32} => REF.I31_instr
  ;; A-binary.watsup:305.5-305.30
  prod {0xFB `%`_u32(29):Bu32} => I31.GET_instr(S_sx)
  ;; A-binary.watsup:306.5-306.30
  prod {0xFB `%`_u32(30):Bu32} => I31.GET_instr(U_sx)
  ;; A-binary.watsup:313.5-313.17
  prod 0x1A => DROP_instr
  ;; A-binary.watsup:314.5-314.19
  prod 0x1B => `SELECT()%?`_instr(?())
  ;; A-binary.watsup:315.5-315.41
  prod{ts : valtype} {0x1C [ts]:Blist(syntax valtype, grammar Bvaltype)} => `SELECT()%?`_instr(?([ts]))
  ;; A-binary.watsup:322.5-322.36
  prod{x : idx} {0x20 x:Blocalidx} => LOCAL.GET_instr(x)
  ;; A-binary.watsup:323.5-323.36
  prod{x : idx} {0x21 x:Blocalidx} => LOCAL.SET_instr(x)
  ;; A-binary.watsup:324.5-324.36
  prod{x : idx} {0x22 x:Blocalidx} => LOCAL.TEE_instr(x)
  ;; A-binary.watsup:328.5-328.38
  prod{x : idx} {0x23 x:Bglobalidx} => GLOBAL.GET_instr(x)
  ;; A-binary.watsup:329.5-329.38
  prod{x : idx} {0x24 x:Bglobalidx} => GLOBAL.SET_instr(x)
  ;; A-binary.watsup:336.5-336.36
  prod{x : idx} {0x25 x:Btableidx} => TABLE.GET_instr(x)
  ;; A-binary.watsup:337.5-337.36
  prod{x : idx} {0x26 x:Btableidx} => TABLE.SET_instr(x)
  ;; A-binary.watsup:338.5-338.58
  prod{y : idx, x : idx} {0xFC `%`_u32(12):Bu32 y:Belemidx x:Btableidx} => TABLE.INIT_instr(x, y)
  ;; A-binary.watsup:339.5-339.43
  prod{x : idx} {0xFC `%`_u32(13):Bu32 x:Belemidx} => ELEM.DROP_instr(x)
  ;; A-binary.watsup:340.5-340.67
  prod{x_1 : idx, x_2 : idx} {0xFC `%`_u32(14):Bu32 x_1:Btableidx x_2:Btableidx} => TABLE.COPY_instr(x_1, x_2)
  ;; A-binary.watsup:341.5-341.45
  prod{x : idx} {0xFC `%`_u32(15):Bu32 x:Btableidx} => TABLE.GROW_instr(x)
  ;; A-binary.watsup:342.5-342.45
  prod{x : idx} {0xFC `%`_u32(16):Bu32 x:Btableidx} => TABLE.SIZE_instr(x)
  ;; A-binary.watsup:343.5-343.45
  prod{x : idx} {0xFC `%`_u32(17):Bu32 x:Btableidx} => TABLE.FILL_instr(x)
  ;; A-binary.watsup:356.5-356.41
  prod{x : idx, ao : memarg} {0x28 (x, ao):Bmemarg} => LOAD_instr(I32_numtype, ?(), x, ao)
  ;; A-binary.watsup:357.5-357.41
  prod{x : idx, ao : memarg} {0x29 (x, ao):Bmemarg} => LOAD_instr(I64_numtype, ?(), x, ao)
  ;; A-binary.watsup:358.5-358.41
  prod{x : idx, ao : memarg} {0x2A (x, ao):Bmemarg} => LOAD_instr(F32_numtype, ?(), x, ao)
  ;; A-binary.watsup:359.5-359.41
  prod{x : idx, ao : memarg} {0x2B (x, ao):Bmemarg} => LOAD_instr(F64_numtype, ?(), x, ao)
  ;; A-binary.watsup:360.5-360.48
  prod{x : idx, ao : memarg} {0x2C (x, ao):Bmemarg} => LOAD_instr(I32_numtype, ?(`%%`_loadop_(`%`_sz(8), S_sx)), x, ao)
  ;; A-binary.watsup:361.5-361.48
  prod{x : idx, ao : memarg} {0x2D (x, ao):Bmemarg} => LOAD_instr(I32_numtype, ?(`%%`_loadop_(`%`_sz(8), U_sx)), x, ao)
  ;; A-binary.watsup:362.5-362.49
  prod{x : idx, ao : memarg} {0x2E (x, ao):Bmemarg} => LOAD_instr(I32_numtype, ?(`%%`_loadop_(`%`_sz(16), S_sx)), x, ao)
  ;; A-binary.watsup:363.5-363.49
  prod{x : idx, ao : memarg} {0x2F (x, ao):Bmemarg} => LOAD_instr(I32_numtype, ?(`%%`_loadop_(`%`_sz(16), U_sx)), x, ao)
  ;; A-binary.watsup:364.5-364.48
  prod{x : idx, ao : memarg} {0x30 (x, ao):Bmemarg} => LOAD_instr(I64_numtype, ?(`%%`_loadop_(`%`_sz(8), S_sx)), x, ao)
  ;; A-binary.watsup:365.5-365.48
  prod{x : idx, ao : memarg} {0x31 (x, ao):Bmemarg} => LOAD_instr(I64_numtype, ?(`%%`_loadop_(`%`_sz(8), U_sx)), x, ao)
  ;; A-binary.watsup:366.5-366.49
  prod{x : idx, ao : memarg} {0x32 (x, ao):Bmemarg} => LOAD_instr(I64_numtype, ?(`%%`_loadop_(`%`_sz(16), S_sx)), x, ao)
  ;; A-binary.watsup:367.5-367.49
  prod{x : idx, ao : memarg} {0x33 (x, ao):Bmemarg} => LOAD_instr(I64_numtype, ?(`%%`_loadop_(`%`_sz(16), U_sx)), x, ao)
  ;; A-binary.watsup:368.5-368.49
  prod{x : idx, ao : memarg} {0x34 (x, ao):Bmemarg} => LOAD_instr(I64_numtype, ?(`%%`_loadop_(`%`_sz(32), S_sx)), x, ao)
  ;; A-binary.watsup:369.5-369.49
  prod{x : idx, ao : memarg} {0x35 (x, ao):Bmemarg} => LOAD_instr(I64_numtype, ?(`%%`_loadop_(`%`_sz(32), U_sx)), x, ao)
  ;; A-binary.watsup:370.5-370.42
  prod{x : idx, ao : memarg} {0x36 (x, ao):Bmemarg} => STORE_instr(I32_numtype, ?(), x, ao)
  ;; A-binary.watsup:371.5-371.42
  prod{x : idx, ao : memarg} {0x37 (x, ao):Bmemarg} => STORE_instr(I64_numtype, ?(), x, ao)
  ;; A-binary.watsup:372.5-372.42
  prod{x : idx, ao : memarg} {0x38 (x, ao):Bmemarg} => STORE_instr(F32_numtype, ?(), x, ao)
  ;; A-binary.watsup:373.5-373.42
  prod{x : idx, ao : memarg} {0x39 (x, ao):Bmemarg} => STORE_instr(F64_numtype, ?(), x, ao)
  ;; A-binary.watsup:374.5-374.45
  prod{x : idx, ao : memarg} {0x3A (x, ao):Bmemarg} => STORE_instr(I32_numtype, ?(`%`_sz(8)), x, ao)
  ;; A-binary.watsup:375.5-375.46
  prod{x : idx, ao : memarg} {0x3B (x, ao):Bmemarg} => STORE_instr(I32_numtype, ?(`%`_sz(16)), x, ao)
  ;; A-binary.watsup:376.5-376.45
  prod{x : idx, ao : memarg} {0x3C (x, ao):Bmemarg} => STORE_instr(I64_numtype, ?(`%`_sz(8)), x, ao)
  ;; A-binary.watsup:377.5-377.46
  prod{x : idx, ao : memarg} {0x3D (x, ao):Bmemarg} => STORE_instr(I64_numtype, ?(`%`_sz(16)), x, ao)
  ;; A-binary.watsup:378.5-378.46
  prod{x : idx, ao : memarg} {0x3E (x, ao):Bmemarg} => STORE_instr(I64_numtype, ?(`%`_sz(32)), x, ao)
  ;; A-binary.watsup:379.5-379.36
  prod{x : idx} {0x3F x:Bmemidx} => MEMORY.SIZE_instr(x)
  ;; A-binary.watsup:380.5-380.36
  prod{x : idx} {0x40 x:Bmemidx} => MEMORY.GROW_instr(x)
  ;; A-binary.watsup:381.5-381.56
  prod{y : idx, x : idx} {0xFC `%`_u32(8):Bu32 y:Bdataidx x:Bmemidx} => MEMORY.INIT_instr(x, y)
  ;; A-binary.watsup:382.5-382.42
  prod{x : idx} {0xFC `%`_u32(9):Bu32 x:Bdataidx} => DATA.DROP_instr(x)
  ;; A-binary.watsup:383.5-383.64
  prod{x_1 : idx, x_2 : idx} {0xFC `%`_u32(10):Bu32 x_1:Bmemidx x_2:Bmemidx} => MEMORY.COPY_instr(x_1, x_2)
  ;; A-binary.watsup:384.5-384.44
  prod{x : idx} {0xFC `%`_u32(11):Bu32 x:Bmemidx} => MEMORY.FILL_instr(x)
  ;; A-binary.watsup:392.5-392.31
  prod{n : n} {0x41 `%`_u32(n):Bu32} => CONST_instr(I32_numtype, `%`_num_(n))
  ;; A-binary.watsup:393.5-393.31
  prod{n : n} {0x42 `%`_u64(n):Bu64} => CONST_instr(I64_numtype, `%`_num_(n))
  ;; A-binary.watsup:394.5-394.31
  prod{p : f32} {0x43 p:Bf32} => CONST_instr(F32_numtype, p)
  ;; A-binary.watsup:395.5-395.31
  prod{p : f64} {0x44 p:Bf64} => CONST_instr(F64_numtype, p)
  ;; A-binary.watsup:399.5-399.27
  prod 0x45 => TESTOP_instr(I32_numtype, EQZ_testop_)
  ;; A-binary.watsup:403.5-403.25
  prod 0x46 => RELOP_instr(I32_numtype, EQ_relop_)
  ;; A-binary.watsup:404.5-404.25
  prod 0x47 => RELOP_instr(I32_numtype, NE_relop_)
  ;; A-binary.watsup:405.5-405.29
  prod 0x48 => RELOP_instr(I32_numtype, LT_relop_(S_sx))
  ;; A-binary.watsup:406.5-406.29
  prod 0x49 => RELOP_instr(I32_numtype, LT_relop_(U_sx))
  ;; A-binary.watsup:407.5-407.29
  prod 0x4A => RELOP_instr(I32_numtype, GT_relop_(S_sx))
  ;; A-binary.watsup:408.5-408.29
  prod 0x4B => RELOP_instr(I32_numtype, GT_relop_(U_sx))
  ;; A-binary.watsup:409.5-409.29
  prod 0x4C => RELOP_instr(I32_numtype, LE_relop_(S_sx))
  ;; A-binary.watsup:410.5-410.29
  prod 0x4D => RELOP_instr(I32_numtype, LE_relop_(U_sx))
  ;; A-binary.watsup:411.5-411.29
  prod 0x4E => RELOP_instr(I32_numtype, GE_relop_(S_sx))
  ;; A-binary.watsup:412.5-412.29
  prod 0x4F => RELOP_instr(I32_numtype, GE_relop_(U_sx))
  ;; A-binary.watsup:416.5-416.27
  prod 0x50 => TESTOP_instr(I64_numtype, EQZ_testop_)
  ;; A-binary.watsup:420.5-420.25
  prod 0x51 => RELOP_instr(I64_numtype, EQ_relop_)
  ;; A-binary.watsup:421.5-421.25
  prod 0x52 => RELOP_instr(I64_numtype, NE_relop_)
  ;; A-binary.watsup:422.5-422.29
  prod 0x53 => RELOP_instr(I64_numtype, LT_relop_(S_sx))
  ;; A-binary.watsup:423.5-423.29
  prod 0x54 => RELOP_instr(I64_numtype, LT_relop_(U_sx))
  ;; A-binary.watsup:424.5-424.29
  prod 0x55 => RELOP_instr(I64_numtype, GT_relop_(S_sx))
  ;; A-binary.watsup:425.5-425.29
  prod 0x56 => RELOP_instr(I64_numtype, GT_relop_(U_sx))
  ;; A-binary.watsup:426.5-426.29
  prod 0x57 => RELOP_instr(I64_numtype, LE_relop_(S_sx))
  ;; A-binary.watsup:427.5-427.29
  prod 0x58 => RELOP_instr(I64_numtype, LE_relop_(U_sx))
  ;; A-binary.watsup:428.5-428.29
  prod 0x59 => RELOP_instr(I64_numtype, GE_relop_(S_sx))
  ;; A-binary.watsup:429.5-429.29
  prod 0x5A => RELOP_instr(I64_numtype, GE_relop_(U_sx))
  ;; A-binary.watsup:433.5-433.25
  prod 0x5B => RELOP_instr(F32_numtype, EQ_relop_)
  ;; A-binary.watsup:434.5-434.25
  prod 0x5C => RELOP_instr(F32_numtype, NE_relop_)
  ;; A-binary.watsup:435.5-435.25
  prod 0x5D => RELOP_instr(F32_numtype, LT_relop_)
  ;; A-binary.watsup:436.5-436.25
  prod 0x5E => RELOP_instr(F32_numtype, GT_relop_)
  ;; A-binary.watsup:437.5-437.25
  prod 0x5F => RELOP_instr(F32_numtype, LE_relop_)
  ;; A-binary.watsup:438.5-438.25
  prod 0x60 => RELOP_instr(F32_numtype, GE_relop_)
  ;; A-binary.watsup:442.5-442.25
  prod 0x61 => RELOP_instr(F64_numtype, EQ_relop_)
  ;; A-binary.watsup:443.5-443.25
  prod 0x62 => RELOP_instr(F64_numtype, NE_relop_)
  ;; A-binary.watsup:444.5-444.25
  prod 0x63 => RELOP_instr(F64_numtype, LT_relop_)
  ;; A-binary.watsup:445.5-445.25
  prod 0x64 => RELOP_instr(F64_numtype, GT_relop_)
  ;; A-binary.watsup:446.5-446.25
  prod 0x65 => RELOP_instr(F64_numtype, LE_relop_)
  ;; A-binary.watsup:447.5-447.25
  prod 0x66 => RELOP_instr(F64_numtype, GE_relop_)
  ;; A-binary.watsup:451.5-451.25
  prod 0x67 => UNOP_instr(I32_numtype, CLZ_unop_)
  ;; A-binary.watsup:452.5-452.25
  prod 0x68 => UNOP_instr(I32_numtype, CTZ_unop_)
  ;; A-binary.watsup:453.5-453.28
  prod 0x69 => UNOP_instr(I32_numtype, POPCNT_unop_)
  ;; A-binary.watsup:457.5-457.26
  prod 0x6A => BINOP_instr(I32_numtype, ADD_binop_)
  ;; A-binary.watsup:458.5-458.26
  prod 0x6B => BINOP_instr(I32_numtype, SUB_binop_)
  ;; A-binary.watsup:459.5-459.26
  prod 0x6C => BINOP_instr(I32_numtype, MUL_binop_)
  ;; A-binary.watsup:460.5-460.30
  prod 0x6D => BINOP_instr(I32_numtype, DIV_binop_(S_sx))
  ;; A-binary.watsup:461.5-461.30
  prod 0x6E => BINOP_instr(I32_numtype, DIV_binop_(U_sx))
  ;; A-binary.watsup:462.5-462.30
  prod 0x6F => BINOP_instr(I32_numtype, REM_binop_(S_sx))
  ;; A-binary.watsup:463.5-463.30
  prod 0x70 => BINOP_instr(I32_numtype, REM_binop_(U_sx))
  ;; A-binary.watsup:464.5-464.26
  prod 0x71 => BINOP_instr(I32_numtype, AND_binop_)
  ;; A-binary.watsup:465.5-465.25
  prod 0x72 => BINOP_instr(I32_numtype, OR_binop_)
  ;; A-binary.watsup:466.5-466.26
  prod 0x73 => BINOP_instr(I32_numtype, XOR_binop_)
  ;; A-binary.watsup:467.5-467.26
  prod 0x74 => BINOP_instr(I32_numtype, SHL_binop_)
  ;; A-binary.watsup:468.5-468.30
  prod 0x75 => BINOP_instr(I32_numtype, SHR_binop_(S_sx))
  ;; A-binary.watsup:469.5-469.30
  prod 0x76 => BINOP_instr(I32_numtype, SHR_binop_(U_sx))
  ;; A-binary.watsup:470.5-470.27
  prod 0x77 => BINOP_instr(I32_numtype, ROTL_binop_)
  ;; A-binary.watsup:471.5-471.27
  prod 0x78 => BINOP_instr(I32_numtype, ROTR_binop_)
  ;; A-binary.watsup:475.5-475.25
  prod 0x79 => UNOP_instr(I64_numtype, CLZ_unop_)
  ;; A-binary.watsup:476.5-476.25
  prod 0x7A => UNOP_instr(I64_numtype, CTZ_unop_)
  ;; A-binary.watsup:477.5-477.28
  prod 0x7B => UNOP_instr(I64_numtype, POPCNT_unop_)
  ;; A-binary.watsup:481.5-481.33
  prod 0xC0 => UNOP_instr(I32_numtype, EXTEND_unop_(`%`_sz(8)))
  ;; A-binary.watsup:482.5-482.34
  prod 0xC1 => UNOP_instr(I32_numtype, EXTEND_unop_(`%`_sz(16)))
  ;; A-binary.watsup:486.5-486.33
  prod 0xC2 => UNOP_instr(I64_numtype, EXTEND_unop_(`%`_sz(8)))
  ;; A-binary.watsup:487.5-487.34
  prod 0xC3 => UNOP_instr(I64_numtype, EXTEND_unop_(`%`_sz(16)))
  ;; A-binary.watsup:488.5-488.34
  prod 0xC4 => UNOP_instr(I64_numtype, EXTEND_unop_(`%`_sz(32)))
  ;; A-binary.watsup:492.5-492.26
  prod 0x7C => BINOP_instr(I64_numtype, ADD_binop_)
  ;; A-binary.watsup:493.5-493.26
  prod 0x7D => BINOP_instr(I64_numtype, SUB_binop_)
  ;; A-binary.watsup:494.5-494.26
  prod 0x7E => BINOP_instr(I64_numtype, MUL_binop_)
  ;; A-binary.watsup:495.5-495.30
  prod 0x7F => BINOP_instr(I64_numtype, DIV_binop_(S_sx))
  ;; A-binary.watsup:496.5-496.30
  prod 0x80 => BINOP_instr(I64_numtype, DIV_binop_(U_sx))
  ;; A-binary.watsup:497.5-497.30
  prod 0x81 => BINOP_instr(I64_numtype, REM_binop_(S_sx))
  ;; A-binary.watsup:498.5-498.30
  prod 0x82 => BINOP_instr(I64_numtype, REM_binop_(U_sx))
  ;; A-binary.watsup:499.5-499.26
  prod 0x83 => BINOP_instr(I64_numtype, AND_binop_)
  ;; A-binary.watsup:500.5-500.25
  prod 0x84 => BINOP_instr(I64_numtype, OR_binop_)
  ;; A-binary.watsup:501.5-501.26
  prod 0x85 => BINOP_instr(I64_numtype, XOR_binop_)
  ;; A-binary.watsup:502.5-502.26
  prod 0x86 => BINOP_instr(I64_numtype, SHL_binop_)
  ;; A-binary.watsup:503.5-503.30
  prod 0x87 => BINOP_instr(I64_numtype, SHR_binop_(S_sx))
  ;; A-binary.watsup:504.5-504.30
  prod 0x88 => BINOP_instr(I64_numtype, SHR_binop_(U_sx))
  ;; A-binary.watsup:505.5-505.27
  prod 0x89 => BINOP_instr(I64_numtype, ROTL_binop_)
  ;; A-binary.watsup:506.5-506.27
  prod 0x8A => BINOP_instr(I64_numtype, ROTR_binop_)
  ;; A-binary.watsup:510.5-510.25
  prod 0x8B => UNOP_instr(F32_numtype, ABS_unop_)
  ;; A-binary.watsup:511.5-511.25
  prod 0x8C => UNOP_instr(F32_numtype, NEG_unop_)
  ;; A-binary.watsup:512.5-512.26
  prod 0x8D => UNOP_instr(F32_numtype, CEIL_unop_)
  ;; A-binary.watsup:513.5-513.27
  prod 0x8E => UNOP_instr(F32_numtype, FLOOR_unop_)
  ;; A-binary.watsup:514.5-514.27
  prod 0x8F => UNOP_instr(F32_numtype, TRUNC_unop_)
  ;; A-binary.watsup:515.5-515.29
  prod 0x90 => UNOP_instr(F32_numtype, NEAREST_unop_)
  ;; A-binary.watsup:516.5-516.26
  prod 0x91 => UNOP_instr(F32_numtype, SQRT_unop_)
  ;; A-binary.watsup:520.5-520.26
  prod 0x92 => BINOP_instr(F32_numtype, ADD_binop_)
  ;; A-binary.watsup:521.5-521.26
  prod 0x93 => BINOP_instr(F32_numtype, SUB_binop_)
  ;; A-binary.watsup:522.5-522.26
  prod 0x94 => BINOP_instr(F32_numtype, MUL_binop_)
  ;; A-binary.watsup:523.5-523.26
  prod 0x95 => BINOP_instr(F32_numtype, DIV_binop_)
  ;; A-binary.watsup:524.5-524.26
  prod 0x96 => BINOP_instr(F32_numtype, MIN_binop_)
  ;; A-binary.watsup:525.5-525.26
  prod 0x97 => BINOP_instr(F32_numtype, MAX_binop_)
  ;; A-binary.watsup:526.5-526.31
  prod 0x98 => BINOP_instr(F32_numtype, COPYSIGN_binop_)
  ;; A-binary.watsup:530.5-530.25
  prod 0x99 => UNOP_instr(F64_numtype, ABS_unop_)
  ;; A-binary.watsup:531.5-531.25
  prod 0x9A => UNOP_instr(F64_numtype, NEG_unop_)
  ;; A-binary.watsup:532.5-532.26
  prod 0x9B => UNOP_instr(F64_numtype, CEIL_unop_)
  ;; A-binary.watsup:533.5-533.27
  prod 0x9C => UNOP_instr(F64_numtype, FLOOR_unop_)
  ;; A-binary.watsup:534.5-534.27
  prod 0x9D => UNOP_instr(F64_numtype, TRUNC_unop_)
  ;; A-binary.watsup:535.5-535.29
  prod 0x9E => UNOP_instr(F64_numtype, NEAREST_unop_)
  ;; A-binary.watsup:536.5-536.26
  prod 0x9F => UNOP_instr(F64_numtype, SQRT_unop_)
  ;; A-binary.watsup:540.5-540.26
  prod 0xA0 => BINOP_instr(F64_numtype, ADD_binop_)
  ;; A-binary.watsup:541.5-541.26
  prod 0xA1 => BINOP_instr(F64_numtype, SUB_binop_)
  ;; A-binary.watsup:542.5-542.26
  prod 0xA2 => BINOP_instr(F64_numtype, MUL_binop_)
  ;; A-binary.watsup:543.5-543.26
  prod 0xA3 => BINOP_instr(F64_numtype, DIV_binop_)
  ;; A-binary.watsup:544.5-544.26
  prod 0xA4 => BINOP_instr(F64_numtype, MIN_binop_)
  ;; A-binary.watsup:545.5-545.26
  prod 0xA5 => BINOP_instr(F64_numtype, MAX_binop_)
  ;; A-binary.watsup:546.5-546.31
  prod 0xA6 => BINOP_instr(F64_numtype, COPYSIGN_binop_)
  ;; A-binary.watsup:551.5-551.31
  prod 0xA7 => CVTOP_instr(I32_numtype, I64_numtype, WRAP_cvtop__)
  ;; A-binary.watsup:552.5-552.36
  prod 0xA8 => CVTOP_instr(I32_numtype, F32_numtype, TRUNC_cvtop__(S_sx))
  ;; A-binary.watsup:553.5-553.36
  prod 0xA9 => CVTOP_instr(I32_numtype, F32_numtype, TRUNC_cvtop__(U_sx))
  ;; A-binary.watsup:554.5-554.36
  prod 0xAA => CVTOP_instr(I32_numtype, F64_numtype, TRUNC_cvtop__(S_sx))
  ;; A-binary.watsup:555.5-555.36
  prod 0xAB => CVTOP_instr(I32_numtype, F64_numtype, TRUNC_cvtop__(U_sx))
  ;; A-binary.watsup:556.5-556.37
  prod 0xAC => CVTOP_instr(I64_numtype, I32_numtype, EXTEND_cvtop__(S_sx))
  ;; A-binary.watsup:557.5-557.37
  prod 0xAD => CVTOP_instr(I64_numtype, I32_numtype, EXTEND_cvtop__(U_sx))
  ;; A-binary.watsup:558.5-558.36
  prod 0xAE => CVTOP_instr(I64_numtype, F32_numtype, TRUNC_cvtop__(S_sx))
  ;; A-binary.watsup:559.5-559.36
  prod 0xAF => CVTOP_instr(I64_numtype, F32_numtype, TRUNC_cvtop__(U_sx))
  ;; A-binary.watsup:560.5-560.36
  prod 0xB0 => CVTOP_instr(I64_numtype, F64_numtype, TRUNC_cvtop__(S_sx))
  ;; A-binary.watsup:561.5-561.36
  prod 0xB1 => CVTOP_instr(I64_numtype, F64_numtype, TRUNC_cvtop__(U_sx))
  ;; A-binary.watsup:562.5-562.38
  prod 0xB2 => CVTOP_instr(F32_numtype, I32_numtype, CONVERT_cvtop__(S_sx))
  ;; A-binary.watsup:563.5-563.38
  prod 0xB3 => CVTOP_instr(F32_numtype, I32_numtype, CONVERT_cvtop__(U_sx))
  ;; A-binary.watsup:564.5-564.38
  prod 0xB4 => CVTOP_instr(F32_numtype, I64_numtype, CONVERT_cvtop__(S_sx))
  ;; A-binary.watsup:565.5-565.38
  prod 0xB5 => CVTOP_instr(F32_numtype, I64_numtype, CONVERT_cvtop__(U_sx))
  ;; A-binary.watsup:566.5-566.33
  prod 0xB6 => CVTOP_instr(F32_numtype, F64_numtype, DEMOTE_cvtop__)
  ;; A-binary.watsup:567.5-567.38
  prod 0xB7 => CVTOP_instr(F64_numtype, I32_numtype, CONVERT_cvtop__(S_sx))
  ;; A-binary.watsup:568.5-568.38
  prod 0xB8 => CVTOP_instr(F64_numtype, I32_numtype, CONVERT_cvtop__(U_sx))
  ;; A-binary.watsup:569.5-569.38
  prod 0xB9 => CVTOP_instr(F64_numtype, I64_numtype, CONVERT_cvtop__(S_sx))
  ;; A-binary.watsup:570.5-570.38
  prod 0xBA => CVTOP_instr(F64_numtype, I64_numtype, CONVERT_cvtop__(U_sx))
  ;; A-binary.watsup:571.5-571.34
  prod 0xBB => CVTOP_instr(F32_numtype, F64_numtype, PROMOTE_cvtop__)
  ;; A-binary.watsup:572.5-572.38
  prod 0xBC => CVTOP_instr(I32_numtype, F32_numtype, REINTERPRET_cvtop__)
  ;; A-binary.watsup:573.5-573.38
  prod 0xBD => CVTOP_instr(I64_numtype, F64_numtype, REINTERPRET_cvtop__)
  ;; A-binary.watsup:574.5-574.38
  prod 0xBE => CVTOP_instr(F32_numtype, I32_numtype, REINTERPRET_cvtop__)
  ;; A-binary.watsup:575.5-575.38
  prod 0xBF => CVTOP_instr(F64_numtype, I64_numtype, REINTERPRET_cvtop__)
  ;; A-binary.watsup:579.5-579.47
  prod {0xFC `%`_u32(0):Bu32} => CVTOP_instr(I32_numtype, F32_numtype, TRUNC_SAT_cvtop__(S_sx))
  ;; A-binary.watsup:580.5-580.47
  prod {0xFC `%`_u32(1):Bu32} => CVTOP_instr(I32_numtype, F32_numtype, TRUNC_SAT_cvtop__(U_sx))
  ;; A-binary.watsup:581.5-581.47
  prod {0xFC `%`_u32(2):Bu32} => CVTOP_instr(I32_numtype, F64_numtype, TRUNC_SAT_cvtop__(S_sx))
  ;; A-binary.watsup:582.5-582.47
  prod {0xFC `%`_u32(3):Bu32} => CVTOP_instr(I32_numtype, F64_numtype, TRUNC_SAT_cvtop__(U_sx))
  ;; A-binary.watsup:583.5-583.47
  prod {0xFC `%`_u32(4):Bu32} => CVTOP_instr(I64_numtype, F32_numtype, TRUNC_SAT_cvtop__(S_sx))
  ;; A-binary.watsup:584.5-584.47
  prod {0xFC `%`_u32(5):Bu32} => CVTOP_instr(I64_numtype, F32_numtype, TRUNC_SAT_cvtop__(U_sx))
  ;; A-binary.watsup:585.5-585.47
  prod {0xFC `%`_u32(6):Bu32} => CVTOP_instr(I64_numtype, F64_numtype, TRUNC_SAT_cvtop__(S_sx))
  ;; A-binary.watsup:586.5-586.47
  prod {0xFC `%`_u32(7):Bu32} => CVTOP_instr(I64_numtype, F64_numtype, TRUNC_SAT_cvtop__(U_sx))
  ;; A-binary.watsup:596.5-596.50
  prod{x : idx, ao : memarg} {0xFD `%`_u32(0):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(), x, ao)
  ;; A-binary.watsup:597.5-597.68
  prod{x : idx, ao : memarg} {0xFD `%`_u32(1):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%%`_vloadop_(`%`_sz(8), 8, S_sx)), x, ao)
  ;; A-binary.watsup:598.5-598.68
  prod{x : idx, ao : memarg} {0xFD `%`_u32(2):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%%`_vloadop_(`%`_sz(8), 8, U_sx)), x, ao)
  ;; A-binary.watsup:599.5-599.69
  prod{x : idx, ao : memarg} {0xFD `%`_u32(3):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%%`_vloadop_(`%`_sz(16), 4, S_sx)), x, ao)
  ;; A-binary.watsup:600.5-600.69
  prod{x : idx, ao : memarg} {0xFD `%`_u32(4):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%%`_vloadop_(`%`_sz(16), 4, U_sx)), x, ao)
  ;; A-binary.watsup:601.5-601.69
  prod{x : idx, ao : memarg} {0xFD `%`_u32(5):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%%`_vloadop_(`%`_sz(32), 2, S_sx)), x, ao)
  ;; A-binary.watsup:602.5-602.69
  prod{x : idx, ao : memarg} {0xFD `%`_u32(6):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%%`_vloadop_(`%`_sz(32), 2, U_sx)), x, ao)
  ;; A-binary.watsup:603.5-603.61
  prod{x : idx, ao : memarg} {0xFD `%`_u32(7):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(8))), x, ao)
  ;; A-binary.watsup:604.5-604.62
  prod{x : idx, ao : memarg} {0xFD `%`_u32(8):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(16))), x, ao)
  ;; A-binary.watsup:605.5-605.62
  prod{x : idx, ao : memarg} {0xFD `%`_u32(9):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(32))), x, ao)
  ;; A-binary.watsup:606.5-606.63
  prod{x : idx, ao : memarg} {0xFD `%`_u32(10):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(64))), x, ao)
  ;; A-binary.watsup:607.5-607.52
  prod{x : idx, ao : memarg} {0xFD `%`_u32(11):Bu32 (x, ao):Bmemarg} => VSTORE_instr(V128_vectype, x, ao)
  ;; A-binary.watsup:608.5-608.72
  prod{x : idx, ao : memarg, l : labelidx} {0xFD `%`_u32(84):Bu32 (x, ao):Bmemarg `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VLOAD_LANE_instr(V128_vectype, `%`_sz(8), x, ao, `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:609.5-609.73
  prod{x : idx, ao : memarg, l : labelidx} {0xFD `%`_u32(85):Bu32 (x, ao):Bmemarg `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VLOAD_LANE_instr(V128_vectype, `%`_sz(16), x, ao, `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:610.5-610.73
  prod{x : idx, ao : memarg, l : labelidx} {0xFD `%`_u32(86):Bu32 (x, ao):Bmemarg `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VLOAD_LANE_instr(V128_vectype, `%`_sz(32), x, ao, `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:611.5-611.73
  prod{x : idx, ao : memarg, l : labelidx} {0xFD `%`_u32(87):Bu32 (x, ao):Bmemarg `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VLOAD_LANE_instr(V128_vectype, `%`_sz(64), x, ao, `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:612.5-612.73
  prod{x : idx, ao : memarg, l : labelidx} {0xFD `%`_u32(88):Bu32 (x, ao):Bmemarg `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VSTORE_LANE_instr(V128_vectype, `%`_sz(8), x, ao, `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:613.5-613.74
  prod{x : idx, ao : memarg, l : labelidx} {0xFD `%`_u32(89):Bu32 (x, ao):Bmemarg `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VSTORE_LANE_instr(V128_vectype, `%`_sz(16), x, ao, `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:614.5-614.74
  prod{x : idx, ao : memarg, l : labelidx} {0xFD `%`_u32(90):Bu32 (x, ao):Bmemarg `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VSTORE_LANE_instr(V128_vectype, `%`_sz(32), x, ao, `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:615.5-615.74
  prod{x : idx, ao : memarg, l : labelidx} {0xFD `%`_u32(91):Bu32 (x, ao):Bmemarg `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VSTORE_LANE_instr(V128_vectype, `%`_sz(64), x, ao, `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:616.5-616.62
  prod{x : idx, ao : memarg} {0xFD `%`_u32(92):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(32))), x, ao)
  ;; A-binary.watsup:617.5-617.62
  prod{x : idx, ao : memarg} {0xFD `%`_u32(93):Bu32 (x, ao):Bmemarg} => VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(64))), x, ao)
  ;; A-binary.watsup:621.5-621.71
  prod{`b*` : byte*} {0xFD `%`_u32(12):Bu32 b:Bbyte^16{b <- `b*`}} => VCONST_instr(V128_vectype, $invibytes_(128, b^16{b <- `b*`}))
  ;; A-binary.watsup:625.5-625.58
  prod{l : labelidx} {0xFD `%`_u32(13):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx^16{}} => VSHUFFLE_instr(`%X%`_ishape(I8_Jnn, `%`_dim(16)), [`%`_uN(l!`%`_labelidx.0)])
  ;; A-binary.watsup:626.5-626.49
  prod {0xFD `%`_u32(14):Bu32} => VSWIZZLOP_instr(`%X%`_ishape(I8_Jnn, `%`_dim(16)), SWIZZLE_vswizzlop_)
  ;; A-binary.watsup:627.5-627.58
  prod {0xFD `%`_u32(256):Bu32} => VSWIZZLOP_instr(`%X%`_ishape(I8_Jnn, `%`_dim(16)), RELAXED_SWIZZLE_vswizzlop_)
  ;; A-binary.watsup:631.5-631.38
  prod {0xFD `%`_u32(15):Bu32} => VSPLAT_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)))
  ;; A-binary.watsup:632.5-632.38
  prod {0xFD `%`_u32(16):Bu32} => VSPLAT_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)))
  ;; A-binary.watsup:633.5-633.38
  prod {0xFD `%`_u32(17):Bu32} => VSPLAT_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)))
  ;; A-binary.watsup:634.5-634.38
  prod {0xFD `%`_u32(18):Bu32} => VSPLAT_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)))
  ;; A-binary.watsup:635.5-635.38
  prod {0xFD `%`_u32(19):Bu32} => VSPLAT_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)))
  ;; A-binary.watsup:636.5-636.38
  prod {0xFD `%`_u32(20):Bu32} => VSPLAT_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)))
  ;; A-binary.watsup:640.5-640.60
  prod{l : labelidx} {0xFD `%`_u32(21):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VEXTRACT_LANE_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ?(S_sx), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:641.5-641.60
  prod{l : labelidx} {0xFD `%`_u32(22):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VEXTRACT_LANE_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ?(U_sx), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:642.5-642.58
  prod{l : labelidx} {0xFD `%`_u32(23):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VREPLACE_LANE_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:643.5-643.60
  prod{l : labelidx} {0xFD `%`_u32(24):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VEXTRACT_LANE_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ?(S_sx), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:644.5-644.60
  prod{l : labelidx} {0xFD `%`_u32(25):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VEXTRACT_LANE_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ?(U_sx), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:645.5-645.58
  prod{l : labelidx} {0xFD `%`_u32(26):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VREPLACE_LANE_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:646.5-646.58
  prod{l : labelidx} {0xFD `%`_u32(27):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VEXTRACT_LANE_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), ?(), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:647.5-647.58
  prod{l : labelidx} {0xFD `%`_u32(28):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VREPLACE_LANE_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:648.5-648.58
  prod{l : labelidx} {0xFD `%`_u32(29):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VEXTRACT_LANE_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), ?(), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:649.5-649.58
  prod{l : labelidx} {0xFD `%`_u32(30):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VREPLACE_LANE_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:650.5-650.58
  prod{l : labelidx} {0xFD `%`_u32(31):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VEXTRACT_LANE_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), ?(), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:651.5-651.58
  prod{l : labelidx} {0xFD `%`_u32(32):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VREPLACE_LANE_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:652.5-652.58
  prod{l : labelidx} {0xFD `%`_u32(33):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VEXTRACT_LANE_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), ?(), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:653.5-653.58
  prod{l : labelidx} {0xFD `%`_u32(34):Bu32 `%`_laneidx(l!`%`_labelidx.0):Blaneidx} => VREPLACE_LANE_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), `%`_laneidx(l!`%`_labelidx.0))
  ;; A-binary.watsup:657.5-657.41
  prod {0xFD `%`_u32(35):Bu32} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), EQ_vrelop_)
  ;; A-binary.watsup:658.5-658.41
  prod {0xFD `%`_u32(36):Bu32} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), NE_vrelop_)
  ;; A-binary.watsup:659.5-659.45
  prod {0xFD `%`_u32(37):Bu32} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), LT_vrelop_(S_sx))
  ;; A-binary.watsup:660.5-660.45
  prod {0xFD `%`_u32(38):Bu32} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), LT_vrelop_(U_sx))
  ;; A-binary.watsup:661.5-661.45
  prod {0xFD `%`_u32(39):Bu32} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), GT_vrelop_(S_sx))
  ;; A-binary.watsup:662.5-662.45
  prod {0xFD `%`_u32(40):Bu32} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), GT_vrelop_(U_sx))
  ;; A-binary.watsup:663.5-663.45
  prod {0xFD `%`_u32(41):Bu32} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), LE_vrelop_(S_sx))
  ;; A-binary.watsup:664.5-664.45
  prod {0xFD `%`_u32(42):Bu32} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), LE_vrelop_(U_sx))
  ;; A-binary.watsup:665.5-665.45
  prod {0xFD `%`_u32(43):Bu32} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), GE_vrelop_(S_sx))
  ;; A-binary.watsup:666.5-666.45
  prod {0xFD `%`_u32(44):Bu32} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), GE_vrelop_(U_sx))
  ;; A-binary.watsup:670.5-670.41
  prod {0xFD `%`_u32(45):Bu32} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), EQ_vrelop_)
  ;; A-binary.watsup:671.5-671.41
  prod {0xFD `%`_u32(46):Bu32} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), NE_vrelop_)
  ;; A-binary.watsup:672.5-672.45
  prod {0xFD `%`_u32(47):Bu32} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), LT_vrelop_(S_sx))
  ;; A-binary.watsup:673.5-673.45
  prod {0xFD `%`_u32(48):Bu32} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), LT_vrelop_(U_sx))
  ;; A-binary.watsup:674.5-674.45
  prod {0xFD `%`_u32(49):Bu32} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), GT_vrelop_(S_sx))
  ;; A-binary.watsup:675.5-675.45
  prod {0xFD `%`_u32(50):Bu32} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), GT_vrelop_(U_sx))
  ;; A-binary.watsup:676.5-676.45
  prod {0xFD `%`_u32(51):Bu32} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), LE_vrelop_(S_sx))
  ;; A-binary.watsup:677.5-677.45
  prod {0xFD `%`_u32(52):Bu32} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), LE_vrelop_(U_sx))
  ;; A-binary.watsup:678.5-678.45
  prod {0xFD `%`_u32(53):Bu32} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), GE_vrelop_(S_sx))
  ;; A-binary.watsup:679.5-679.45
  prod {0xFD `%`_u32(54):Bu32} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), GE_vrelop_(U_sx))
  ;; A-binary.watsup:683.5-683.41
  prod {0xFD `%`_u32(55):Bu32} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), EQ_vrelop_)
  ;; A-binary.watsup:684.5-684.41
  prod {0xFD `%`_u32(56):Bu32} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), NE_vrelop_)
  ;; A-binary.watsup:685.5-685.45
  prod {0xFD `%`_u32(57):Bu32} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), LT_vrelop_(S_sx))
  ;; A-binary.watsup:686.5-686.45
  prod {0xFD `%`_u32(58):Bu32} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), LT_vrelop_(U_sx))
  ;; A-binary.watsup:687.5-687.45
  prod {0xFD `%`_u32(59):Bu32} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), GT_vrelop_(S_sx))
  ;; A-binary.watsup:688.5-688.45
  prod {0xFD `%`_u32(60):Bu32} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), GT_vrelop_(U_sx))
  ;; A-binary.watsup:689.5-689.45
  prod {0xFD `%`_u32(61):Bu32} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), LE_vrelop_(S_sx))
  ;; A-binary.watsup:690.5-690.45
  prod {0xFD `%`_u32(62):Bu32} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), LE_vrelop_(U_sx))
  ;; A-binary.watsup:691.5-691.45
  prod {0xFD `%`_u32(63):Bu32} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), GE_vrelop_(S_sx))
  ;; A-binary.watsup:692.5-692.45
  prod {0xFD `%`_u32(64):Bu32} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), GE_vrelop_(U_sx))
  ;; A-binary.watsup:696.5-696.41
  prod {0xFD `%`_u32(65):Bu32} => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), EQ_vrelop_)
  ;; A-binary.watsup:697.5-697.41
  prod {0xFD `%`_u32(66):Bu32} => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), NE_vrelop_)
  ;; A-binary.watsup:698.5-698.41
  prod {0xFD `%`_u32(67):Bu32} => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), LT_vrelop_)
  ;; A-binary.watsup:699.5-699.41
  prod {0xFD `%`_u32(68):Bu32} => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), GT_vrelop_)
  ;; A-binary.watsup:700.5-700.41
  prod {0xFD `%`_u32(69):Bu32} => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), LE_vrelop_)
  ;; A-binary.watsup:701.5-701.41
  prod {0xFD `%`_u32(70):Bu32} => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), GE_vrelop_)
  ;; A-binary.watsup:705.5-705.41
  prod {0xFD `%`_u32(71):Bu32} => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), EQ_vrelop_)
  ;; A-binary.watsup:706.5-706.41
  prod {0xFD `%`_u32(72):Bu32} => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), NE_vrelop_)
  ;; A-binary.watsup:707.5-707.41
  prod {0xFD `%`_u32(73):Bu32} => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), LT_vrelop_)
  ;; A-binary.watsup:708.5-708.41
  prod {0xFD `%`_u32(74):Bu32} => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), GT_vrelop_)
  ;; A-binary.watsup:709.5-709.41
  prod {0xFD `%`_u32(75):Bu32} => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), LE_vrelop_)
  ;; A-binary.watsup:710.5-710.41
  prod {0xFD `%`_u32(76):Bu32} => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), GE_vrelop_)
  ;; A-binary.watsup:714.5-714.36
  prod {0xFD `%`_u32(77):Bu32} => VVUNOP_instr(V128_vectype, NOT_vvunop)
  ;; A-binary.watsup:718.5-718.37
  prod {0xFD `%`_u32(78):Bu32} => VVBINOP_instr(V128_vectype, AND_vvbinop)
  ;; A-binary.watsup:719.5-719.40
  prod {0xFD `%`_u32(79):Bu32} => VVBINOP_instr(V128_vectype, ANDNOT_vvbinop)
  ;; A-binary.watsup:720.5-720.36
  prod {0xFD `%`_u32(80):Bu32} => VVBINOP_instr(V128_vectype, OR_vvbinop)
  ;; A-binary.watsup:721.5-721.37
  prod {0xFD `%`_u32(81):Bu32} => VVBINOP_instr(V128_vectype, XOR_vvbinop)
  ;; A-binary.watsup:725.5-725.44
  prod {0xFD `%`_u32(82):Bu32} => VVTERNOP_instr(V128_vectype, BITSELECT_vvternop)
  ;; A-binary.watsup:729.5-729.43
  prod {0xFD `%`_u32(83):Bu32} => VVTESTOP_instr(V128_vectype, ANY_TRUE_vvtestop)
  ;; A-binary.watsup:733.5-733.41
  prod {0xFD `%`_u32(96):Bu32} => VUNOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ABS_vunop_)
  ;; A-binary.watsup:734.5-734.41
  prod {0xFD `%`_u32(97):Bu32} => VUNOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), NEG_vunop_)
  ;; A-binary.watsup:735.5-735.44
  prod {0xFD `%`_u32(98):Bu32} => VUNOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), POPCNT_vunop_)
  ;; A-binary.watsup:739.5-739.48
  prod {0xFD `%`_u32(99):Bu32} => VTESTOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ALL_TRUE_vtestop_)
  ;; A-binary.watsup:743.5-743.41
  prod {0xFD `%`_u32(100):Bu32} => VBITMASK_instr(`%X%`_ishape(I8_Jnn, `%`_dim(16)))
  ;; A-binary.watsup:747.5-747.53
  prod {0xFD `%`_u32(101):Bu32} => VNARROW_instr(`%X%`_ishape(I8_Jnn, `%`_dim(16)), `%X%`_ishape(I16_Jnn, `%`_dim(8)), S_sx)
  ;; A-binary.watsup:748.5-748.53
  prod {0xFD `%`_u32(102):Bu32} => VNARROW_instr(`%X%`_ishape(I8_Jnn, `%`_dim(16)), `%X%`_ishape(I16_Jnn, `%`_dim(8)), U_sx)
  ;; A-binary.watsup:752.5-752.45
  prod {0xFD `%`_u32(107):Bu32} => VSHIFTOP_instr(`%X%`_ishape(I8_Jnn, `%`_dim(16)), SHL_vshiftop_)
  ;; A-binary.watsup:753.5-753.49
  prod {0xFD `%`_u32(108):Bu32} => VSHIFTOP_instr(`%X%`_ishape(I8_Jnn, `%`_dim(16)), SHR_vshiftop_(S_sx))
  ;; A-binary.watsup:754.5-754.49
  prod {0xFD `%`_u32(109):Bu32} => VSHIFTOP_instr(`%X%`_ishape(I8_Jnn, `%`_dim(16)), SHR_vshiftop_(U_sx))
  ;; A-binary.watsup:758.5-758.43
  prod {0xFD `%`_u32(110):Bu32} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ADD_vbinop_)
  ;; A-binary.watsup:759.5-759.51
  prod {0xFD `%`_u32(111):Bu32} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ADD_SAT_vbinop_(S_sx))
  ;; A-binary.watsup:760.5-760.51
  prod {0xFD `%`_u32(112):Bu32} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ADD_SAT_vbinop_(U_sx))
  ;; A-binary.watsup:761.5-761.43
  prod {0xFD `%`_u32(113):Bu32} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), SUB_vbinop_)
  ;; A-binary.watsup:762.5-762.51
  prod {0xFD `%`_u32(114):Bu32} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), SUB_SAT_vbinop_(S_sx))
  ;; A-binary.watsup:763.5-763.51
  prod {0xFD `%`_u32(115):Bu32} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), SUB_SAT_vbinop_(U_sx))
  ;; A-binary.watsup:764.5-764.47
  prod {0xFD `%`_u32(118):Bu32} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), MIN_vbinop_(S_sx))
  ;; A-binary.watsup:765.5-765.47
  prod {0xFD `%`_u32(119):Bu32} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), MIN_vbinop_(U_sx))
  ;; A-binary.watsup:766.5-766.47
  prod {0xFD `%`_u32(120):Bu32} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), MAX_vbinop_(S_sx))
  ;; A-binary.watsup:767.5-767.47
  prod {0xFD `%`_u32(121):Bu32} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), MAX_vbinop_(U_sx))
  ;; A-binary.watsup:768.5-768.48
  prod {0xFD `%`_u32(123):Bu32} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), `AVGRU`_vbinop_)
  ;; A-binary.watsup:772.5-772.72
  prod {0xFD `%`_u32(124):Bu32} => VEXTUNOP_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)), `%X%`_ishape(I8_Jnn, `%`_dim(16)), EXTADD_PAIRWISE_vextunop__(S_sx))
  ;; A-binary.watsup:773.5-773.72
  prod {0xFD `%`_u32(125):Bu32} => VEXTUNOP_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)), `%X%`_ishape(I8_Jnn, `%`_dim(16)), EXTADD_PAIRWISE_vextunop__(U_sx))
  ;; A-binary.watsup:777.5-777.42
  prod {0xFD `%`_u32(128):Bu32} => VUNOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ABS_vunop_)
  ;; A-binary.watsup:778.5-778.42
  prod {0xFD `%`_u32(129):Bu32} => VUNOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), NEG_vunop_)
  ;; A-binary.watsup:782.5-782.55
  prod {0xFD `%`_u32(130):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `Q15MULR_SATS`_vbinop_)
  ;; A-binary.watsup:783.5-783.59
  prod {0xFD `%`_u32(273):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `RELAXED_Q15MULRS`_vbinop_)
  ;; A-binary.watsup:787.5-787.49
  prod {0xFD `%`_u32(131):Bu32} => VTESTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ALL_TRUE_vtestop_)
  ;; A-binary.watsup:791.5-791.41
  prod {0xFD `%`_u32(132):Bu32} => VBITMASK_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)))
  ;; A-binary.watsup:795.5-795.53
  prod {0xFD `%`_u32(133):Bu32} => VNARROW_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)), `%X%`_ishape(I32_Jnn, `%`_dim(4)), S_sx)
  ;; A-binary.watsup:796.5-796.53
  prod {0xFD `%`_u32(134):Bu32} => VNARROW_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)), `%X%`_ishape(I32_Jnn, `%`_dim(4)), U_sx)
  ;; A-binary.watsup:800.5-800.65
  prod {0xFD `%`_u32(135):Bu32} => VCVTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%X%`_shape(I8_lanetype, `%`_dim(16)), EXTEND_vcvtop__(S_sx), ?(LOW_half__), ?())
  ;; A-binary.watsup:801.5-801.66
  prod {0xFD `%`_u32(136):Bu32} => VCVTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%X%`_shape(I8_lanetype, `%`_dim(16)), EXTEND_vcvtop__(S_sx), ?(HIGH_half__), ?())
  ;; A-binary.watsup:802.5-802.65
  prod {0xFD `%`_u32(137):Bu32} => VCVTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%X%`_shape(I8_lanetype, `%`_dim(16)), EXTEND_vcvtop__(U_sx), ?(LOW_half__), ?())
  ;; A-binary.watsup:803.5-803.66
  prod {0xFD `%`_u32(138):Bu32} => VCVTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%X%`_shape(I8_lanetype, `%`_dim(16)), EXTEND_vcvtop__(U_sx), ?(HIGH_half__), ?())
  ;; A-binary.watsup:807.5-807.45
  prod {0xFD `%`_u32(139):Bu32} => VSHIFTOP_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)), SHL_vshiftop_)
  ;; A-binary.watsup:808.5-808.49
  prod {0xFD `%`_u32(140):Bu32} => VSHIFTOP_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)), SHR_vshiftop_(S_sx))
  ;; A-binary.watsup:809.5-809.49
  prod {0xFD `%`_u32(141):Bu32} => VSHIFTOP_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)), SHR_vshiftop_(U_sx))
  ;; A-binary.watsup:813.5-813.43
  prod {0xFD `%`_u32(142):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ADD_vbinop_)
  ;; A-binary.watsup:814.5-814.51
  prod {0xFD `%`_u32(143):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ADD_SAT_vbinop_(S_sx))
  ;; A-binary.watsup:815.5-815.51
  prod {0xFD `%`_u32(144):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ADD_SAT_vbinop_(U_sx))
  ;; A-binary.watsup:816.5-816.43
  prod {0xFD `%`_u32(145):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), SUB_vbinop_)
  ;; A-binary.watsup:817.5-817.51
  prod {0xFD `%`_u32(146):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), SUB_SAT_vbinop_(S_sx))
  ;; A-binary.watsup:818.5-818.51
  prod {0xFD `%`_u32(147):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), SUB_SAT_vbinop_(U_sx))
  ;; A-binary.watsup:819.5-819.43
  prod {0xFD `%`_u32(149):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MUL_vbinop_)
  ;; A-binary.watsup:820.5-820.47
  prod {0xFD `%`_u32(150):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MIN_vbinop_(S_sx))
  ;; A-binary.watsup:821.5-821.47
  prod {0xFD `%`_u32(151):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MIN_vbinop_(U_sx))
  ;; A-binary.watsup:822.5-822.47
  prod {0xFD `%`_u32(152):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MAX_vbinop_(S_sx))
  ;; A-binary.watsup:823.5-823.47
  prod {0xFD `%`_u32(153):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MAX_vbinop_(U_sx))
  ;; A-binary.watsup:824.5-824.48
  prod {0xFD `%`_u32(155):Bu32} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `AVGRU`_vbinop_)
  ;; A-binary.watsup:828.5-828.68
  prod {0xFD `%`_u32(156):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)), `%X%`_ishape(I8_Jnn, `%`_dim(16)), EXTMUL_vextbinop__(S_sx, LOW_half__))
  ;; A-binary.watsup:829.5-829.69
  prod {0xFD `%`_u32(157):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)), `%X%`_ishape(I8_Jnn, `%`_dim(16)), EXTMUL_vextbinop__(S_sx, HIGH_half__))
  ;; A-binary.watsup:830.5-830.68
  prod {0xFD `%`_u32(158):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)), `%X%`_ishape(I8_Jnn, `%`_dim(16)), EXTMUL_vextbinop__(U_sx, LOW_half__))
  ;; A-binary.watsup:831.5-831.69
  prod {0xFD `%`_u32(159):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)), `%X%`_ishape(I8_Jnn, `%`_dim(16)), EXTMUL_vextbinop__(U_sx, HIGH_half__))
  ;; A-binary.watsup:832.5-832.69
  prod {0xFD `%`_u32(274):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I16_Jnn, `%`_dim(8)), `%X%`_ishape(I8_Jnn, `%`_dim(16)), `RELAXED_DOTS`_vextbinop__)
  ;; A-binary.watsup:836.5-836.72
  prod {0xFD `%`_u32(126):Bu32} => VEXTUNOP_instr(`%X%`_ishape(I32_Jnn, `%`_dim(4)), `%X%`_ishape(I16_Jnn, `%`_dim(8)), EXTADD_PAIRWISE_vextunop__(S_sx))
  ;; A-binary.watsup:837.5-837.72
  prod {0xFD `%`_u32(127):Bu32} => VEXTUNOP_instr(`%X%`_ishape(I32_Jnn, `%`_dim(4)), `%X%`_ishape(I16_Jnn, `%`_dim(8)), EXTADD_PAIRWISE_vextunop__(U_sx))
  ;; A-binary.watsup:841.5-841.42
  prod {0xFD `%`_u32(160):Bu32} => VUNOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), ABS_vunop_)
  ;; A-binary.watsup:842.5-842.42
  prod {0xFD `%`_u32(161):Bu32} => VUNOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), NEG_vunop_)
  ;; A-binary.watsup:846.5-846.49
  prod {0xFD `%`_u32(163):Bu32} => VTESTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), ALL_TRUE_vtestop_)
  ;; A-binary.watsup:850.5-850.41
  prod {0xFD `%`_u32(164):Bu32} => VBITMASK_instr(`%X%`_ishape(I32_Jnn, `%`_dim(4)))
  ;; A-binary.watsup:854.5-854.65
  prod {0xFD `%`_u32(167):Bu32} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(I16_lanetype, `%`_dim(8)), EXTEND_vcvtop__(S_sx), ?(LOW_half__), ?())
  ;; A-binary.watsup:855.5-855.66
  prod {0xFD `%`_u32(168):Bu32} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(I16_lanetype, `%`_dim(8)), EXTEND_vcvtop__(S_sx), ?(HIGH_half__), ?())
  ;; A-binary.watsup:856.5-856.65
  prod {0xFD `%`_u32(169):Bu32} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(I16_lanetype, `%`_dim(8)), EXTEND_vcvtop__(U_sx), ?(LOW_half__), ?())
  ;; A-binary.watsup:857.5-857.66
  prod {0xFD `%`_u32(170):Bu32} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(I16_lanetype, `%`_dim(8)), EXTEND_vcvtop__(U_sx), ?(HIGH_half__), ?())
  ;; A-binary.watsup:861.5-861.45
  prod {0xFD `%`_u32(171):Bu32} => VSHIFTOP_instr(`%X%`_ishape(I32_Jnn, `%`_dim(4)), SHL_vshiftop_)
  ;; A-binary.watsup:862.5-862.49
  prod {0xFD `%`_u32(172):Bu32} => VSHIFTOP_instr(`%X%`_ishape(I32_Jnn, `%`_dim(4)), SHR_vshiftop_(S_sx))
  ;; A-binary.watsup:863.5-863.49
  prod {0xFD `%`_u32(173):Bu32} => VSHIFTOP_instr(`%X%`_ishape(I32_Jnn, `%`_dim(4)), SHR_vshiftop_(U_sx))
  ;; A-binary.watsup:867.5-867.43
  prod {0xFD `%`_u32(174):Bu32} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), ADD_vbinop_)
  ;; A-binary.watsup:868.5-868.43
  prod {0xFD `%`_u32(177):Bu32} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), SUB_vbinop_)
  ;; A-binary.watsup:869.5-869.43
  prod {0xFD `%`_u32(181):Bu32} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MUL_vbinop_)
  ;; A-binary.watsup:870.5-870.47
  prod {0xFD `%`_u32(182):Bu32} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MIN_vbinop_(S_sx))
  ;; A-binary.watsup:871.5-871.47
  prod {0xFD `%`_u32(183):Bu32} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MIN_vbinop_(U_sx))
  ;; A-binary.watsup:872.5-872.47
  prod {0xFD `%`_u32(184):Bu32} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MAX_vbinop_(S_sx))
  ;; A-binary.watsup:873.5-873.47
  prod {0xFD `%`_u32(185):Bu32} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MAX_vbinop_(U_sx))
  ;; A-binary.watsup:877.5-877.61
  prod {0xFD `%`_u32(186):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I32_Jnn, `%`_dim(4)), `%X%`_ishape(I16_Jnn, `%`_dim(8)), `DOTS`_vextbinop__)
  ;; A-binary.watsup:878.5-878.68
  prod {0xFD `%`_u32(188):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I32_Jnn, `%`_dim(4)), `%X%`_ishape(I16_Jnn, `%`_dim(8)), EXTMUL_vextbinop__(S_sx, LOW_half__))
  ;; A-binary.watsup:879.5-879.69
  prod {0xFD `%`_u32(189):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I32_Jnn, `%`_dim(4)), `%X%`_ishape(I16_Jnn, `%`_dim(8)), EXTMUL_vextbinop__(S_sx, HIGH_half__))
  ;; A-binary.watsup:880.5-880.68
  prod {0xFD `%`_u32(190):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I32_Jnn, `%`_dim(4)), `%X%`_ishape(I16_Jnn, `%`_dim(8)), EXTMUL_vextbinop__(U_sx, LOW_half__))
  ;; A-binary.watsup:881.5-881.69
  prod {0xFD `%`_u32(191):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I32_Jnn, `%`_dim(4)), `%X%`_ishape(I16_Jnn, `%`_dim(8)), EXTMUL_vextbinop__(U_sx, HIGH_half__))
  ;; A-binary.watsup:885.5-885.74
  prod {0xFD `%`_u32(275):Bu32} => VEXTTERNOP_instr(`%X%`_ishape(I32_Jnn, `%`_dim(4)), `%X%`_ishape(I16_Jnn, `%`_dim(8)), `RELAXED_DOT_ADDS`_vextternop__)
  ;; A-binary.watsup:889.5-889.42
  prod {0xFD `%`_u32(192):Bu32} => VUNOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), ABS_vunop_)
  ;; A-binary.watsup:890.5-890.42
  prod {0xFD `%`_u32(193):Bu32} => VUNOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), NEG_vunop_)
  ;; A-binary.watsup:894.5-894.49
  prod {0xFD `%`_u32(195):Bu32} => VTESTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), ALL_TRUE_vtestop_)
  ;; A-binary.watsup:898.5-898.41
  prod {0xFD `%`_u32(196):Bu32} => VBITMASK_instr(`%X%`_ishape(I64_Jnn, `%`_dim(2)))
  ;; A-binary.watsup:902.5-902.65
  prod {0xFD `%`_u32(199):Bu32} => VCVTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), EXTEND_vcvtop__(S_sx), ?(LOW_half__), ?())
  ;; A-binary.watsup:903.5-903.66
  prod {0xFD `%`_u32(200):Bu32} => VCVTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), EXTEND_vcvtop__(S_sx), ?(HIGH_half__), ?())
  ;; A-binary.watsup:904.5-904.65
  prod {0xFD `%`_u32(201):Bu32} => VCVTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), EXTEND_vcvtop__(U_sx), ?(LOW_half__), ?())
  ;; A-binary.watsup:905.5-905.66
  prod {0xFD `%`_u32(202):Bu32} => VCVTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), EXTEND_vcvtop__(U_sx), ?(HIGH_half__), ?())
  ;; A-binary.watsup:909.5-909.45
  prod {0xFD `%`_u32(203):Bu32} => VSHIFTOP_instr(`%X%`_ishape(I64_Jnn, `%`_dim(2)), SHL_vshiftop_)
  ;; A-binary.watsup:910.5-910.49
  prod {0xFD `%`_u32(204):Bu32} => VSHIFTOP_instr(`%X%`_ishape(I64_Jnn, `%`_dim(2)), SHR_vshiftop_(S_sx))
  ;; A-binary.watsup:911.5-911.49
  prod {0xFD `%`_u32(205):Bu32} => VSHIFTOP_instr(`%X%`_ishape(I64_Jnn, `%`_dim(2)), SHR_vshiftop_(U_sx))
  ;; A-binary.watsup:915.5-915.43
  prod {0xFD `%`_u32(206):Bu32} => VBINOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), ADD_vbinop_)
  ;; A-binary.watsup:916.5-916.43
  prod {0xFD `%`_u32(209):Bu32} => VBINOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), SUB_vbinop_)
  ;; A-binary.watsup:917.5-917.43
  prod {0xFD `%`_u32(213):Bu32} => VBINOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), MUL_vbinop_)
  ;; A-binary.watsup:921.5-921.42
  prod {0xFD `%`_u32(214):Bu32} => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), EQ_vrelop_)
  ;; A-binary.watsup:922.5-922.42
  prod {0xFD `%`_u32(215):Bu32} => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), NE_vrelop_)
  ;; A-binary.watsup:923.5-923.46
  prod {0xFD `%`_u32(216):Bu32} => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), LT_vrelop_(S_sx))
  ;; A-binary.watsup:924.5-924.46
  prod {0xFD `%`_u32(217):Bu32} => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), GT_vrelop_(S_sx))
  ;; A-binary.watsup:925.5-925.46
  prod {0xFD `%`_u32(218):Bu32} => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), LE_vrelop_(S_sx))
  ;; A-binary.watsup:926.5-926.46
  prod {0xFD `%`_u32(219):Bu32} => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), GE_vrelop_(S_sx))
  ;; A-binary.watsup:930.5-930.68
  prod {0xFD `%`_u32(220):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I64_Jnn, `%`_dim(2)), `%X%`_ishape(I32_Jnn, `%`_dim(4)), EXTMUL_vextbinop__(S_sx, LOW_half__))
  ;; A-binary.watsup:931.5-931.69
  prod {0xFD `%`_u32(221):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I64_Jnn, `%`_dim(2)), `%X%`_ishape(I32_Jnn, `%`_dim(4)), EXTMUL_vextbinop__(S_sx, HIGH_half__))
  ;; A-binary.watsup:932.5-932.68
  prod {0xFD `%`_u32(222):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I64_Jnn, `%`_dim(2)), `%X%`_ishape(I32_Jnn, `%`_dim(4)), EXTMUL_vextbinop__(U_sx, LOW_half__))
  ;; A-binary.watsup:933.5-933.69
  prod {0xFD `%`_u32(223):Bu32} => VEXTBINOP_instr(`%X%`_ishape(I64_Jnn, `%`_dim(2)), `%X%`_ishape(I32_Jnn, `%`_dim(4)), EXTMUL_vextbinop__(U_sx, HIGH_half__))
  ;; A-binary.watsup:937.5-937.43
  prod {0xFD `%`_u32(103):Bu32} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), CEIL_vunop_)
  ;; A-binary.watsup:938.5-938.44
  prod {0xFD `%`_u32(104):Bu32} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), FLOOR_vunop_)
  ;; A-binary.watsup:939.5-939.44
  prod {0xFD `%`_u32(105):Bu32} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), TRUNC_vunop_)
  ;; A-binary.watsup:940.5-940.46
  prod {0xFD `%`_u32(106):Bu32} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), NEAREST_vunop_)
  ;; A-binary.watsup:941.5-941.42
  prod {0xFD `%`_u32(224):Bu32} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), ABS_vunop_)
  ;; A-binary.watsup:942.5-942.42
  prod {0xFD `%`_u32(225):Bu32} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), NEG_vunop_)
  ;; A-binary.watsup:943.5-943.43
  prod {0xFD `%`_u32(227):Bu32} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), SQRT_vunop_)
  ;; A-binary.watsup:947.5-947.43
  prod {0xFD `%`_u32(228):Bu32} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), ADD_vbinop_)
  ;; A-binary.watsup:948.5-948.43
  prod {0xFD `%`_u32(229):Bu32} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), SUB_vbinop_)
  ;; A-binary.watsup:949.5-949.43
  prod {0xFD `%`_u32(230):Bu32} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), MUL_vbinop_)
  ;; A-binary.watsup:950.5-950.43
  prod {0xFD `%`_u32(231):Bu32} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), DIV_vbinop_)
  ;; A-binary.watsup:951.5-951.43
  prod {0xFD `%`_u32(232):Bu32} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), MIN_vbinop_)
  ;; A-binary.watsup:952.5-952.43
  prod {0xFD `%`_u32(233):Bu32} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), MAX_vbinop_)
  ;; A-binary.watsup:953.5-953.44
  prod {0xFD `%`_u32(234):Bu32} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), PMIN_vbinop_)
  ;; A-binary.watsup:954.5-954.44
  prod {0xFD `%`_u32(235):Bu32} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), PMAX_vbinop_)
  ;; A-binary.watsup:955.5-955.51
  prod {0xFD `%`_u32(269):Bu32} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_MIN_vbinop_)
  ;; A-binary.watsup:956.5-956.51
  prod {0xFD `%`_u32(270):Bu32} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_MAX_vbinop_)
  ;; A-binary.watsup:960.5-960.53
  prod {0xFD `%`_u32(261):Bu32} => VTERNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_MADD_vternop_)
  ;; A-binary.watsup:961.5-961.54
  prod {0xFD `%`_u32(262):Bu32} => VTERNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_NMADD_vternop_)
  ;; A-binary.watsup:965.5-965.43
  prod {0xFD `%`_u32(116):Bu32} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), CEIL_vunop_)
  ;; A-binary.watsup:966.5-966.44
  prod {0xFD `%`_u32(117):Bu32} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), FLOOR_vunop_)
  ;; A-binary.watsup:967.5-967.44
  prod {0xFD `%`_u32(122):Bu32} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), TRUNC_vunop_)
  ;; A-binary.watsup:968.5-968.46
  prod {0xFD `%`_u32(148):Bu32} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), NEAREST_vunop_)
  ;; A-binary.watsup:969.5-969.42
  prod {0xFD `%`_u32(236):Bu32} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), ABS_vunop_)
  ;; A-binary.watsup:970.5-970.42
  prod {0xFD `%`_u32(237):Bu32} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), NEG_vunop_)
  ;; A-binary.watsup:971.5-971.43
  prod {0xFD `%`_u32(239):Bu32} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), SQRT_vunop_)
  ;; A-binary.watsup:975.5-975.43
  prod {0xFD `%`_u32(240):Bu32} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), ADD_vbinop_)
  ;; A-binary.watsup:976.5-976.43
  prod {0xFD `%`_u32(241):Bu32} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), SUB_vbinop_)
  ;; A-binary.watsup:977.5-977.43
  prod {0xFD `%`_u32(242):Bu32} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), MUL_vbinop_)
  ;; A-binary.watsup:978.5-978.43
  prod {0xFD `%`_u32(243):Bu32} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), DIV_vbinop_)
  ;; A-binary.watsup:979.5-979.43
  prod {0xFD `%`_u32(244):Bu32} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), MIN_vbinop_)
  ;; A-binary.watsup:980.5-980.43
  prod {0xFD `%`_u32(245):Bu32} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), MAX_vbinop_)
  ;; A-binary.watsup:981.5-981.44
  prod {0xFD `%`_u32(246):Bu32} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), PMIN_vbinop_)
  ;; A-binary.watsup:982.5-982.44
  prod {0xFD `%`_u32(247):Bu32} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), PMAX_vbinop_)
  ;; A-binary.watsup:983.5-983.51
  prod {0xFD `%`_u32(271):Bu32} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_MIN_vbinop_)
  ;; A-binary.watsup:984.5-984.51
  prod {0xFD `%`_u32(272):Bu32} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_MAX_vbinop_)
  ;; A-binary.watsup:988.5-988.53
  prod {0xFD `%`_u32(263):Bu32} => VTERNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_MADD_vternop_)
  ;; A-binary.watsup:989.5-989.54
  prod {0xFD `%`_u32(264):Bu32} => VTERNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_NMADD_vternop_)
  ;; A-binary.watsup:993.5-993.61
  prod {0xFD `%`_u32(94):Bu32} => VCVTOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), DEMOTE_vcvtop__, ?(), ?(ZERO_zero__))
  ;; A-binary.watsup:994.5-994.61
  prod {0xFD `%`_u32(95):Bu32} => VCVTOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), `%X%`_shape(F32_lanetype, `%`_dim(4)), PROMOTE_vcvtop__, ?(LOW_half__), ?())
  ;; A-binary.watsup:995.5-995.64
  prod {0xFD `%`_u32(248):Bu32} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F32_lanetype, `%`_dim(4)), TRUNC_SAT_vcvtop__(S_sx), ?(), ?())
  ;; A-binary.watsup:996.5-996.64
  prod {0xFD `%`_u32(249):Bu32} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F32_lanetype, `%`_dim(4)), TRUNC_SAT_vcvtop__(U_sx), ?(), ?())
  ;; A-binary.watsup:997.5-997.62
  prod {0xFD `%`_u32(250):Bu32} => VCVTOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), `%X%`_shape(I32_lanetype, `%`_dim(4)), CONVERT_vcvtop__(S_sx), ?(), ?())
  ;; A-binary.watsup:998.5-998.62
  prod {0xFD `%`_u32(251):Bu32} => VCVTOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), `%X%`_shape(I32_lanetype, `%`_dim(4)), CONVERT_vcvtop__(U_sx), ?(), ?())
  ;; A-binary.watsup:999.5-999.69
  prod {0xFD `%`_u32(252):Bu32} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), TRUNC_SAT_vcvtop__(S_sx), ?(), ?(ZERO_zero__))
  ;; A-binary.watsup:1000.5-1000.69
  prod {0xFD `%`_u32(253):Bu32} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), TRUNC_SAT_vcvtop__(U_sx), ?(), ?(ZERO_zero__))
  ;; A-binary.watsup:1001.5-1001.66
  prod {0xFD `%`_u32(254):Bu32} => VCVTOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), CONVERT_vcvtop__(S_sx), ?(LOW_half__), ?())
  ;; A-binary.watsup:1002.5-1002.66
  prod {0xFD `%`_u32(255):Bu32} => VCVTOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), CONVERT_vcvtop__(U_sx), ?(LOW_half__), ?())
  ;; A-binary.watsup:1003.5-1003.68
  prod {0xFD `%`_u32(257):Bu32} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_TRUNC_vcvtop__(S_sx), ?(), ?())
  ;; A-binary.watsup:1004.5-1004.68
  prod {0xFD `%`_u32(258):Bu32} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_TRUNC_vcvtop__(U_sx), ?(), ?())
  ;; A-binary.watsup:1005.5-1005.73
  prod {0xFD `%`_u32(259):Bu32} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_TRUNC_vcvtop__(S_sx), ?(), ?(ZERO_zero__))
  ;; A-binary.watsup:1006.5-1006.73
  prod {0xFD `%`_u32(260):Bu32} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_TRUNC_vcvtop__(U_sx), ?(), ?(ZERO_zero__))
}

;; A-binary.watsup
grammar Bexpr : expr
  ;; A-binary.watsup
  prod{`in*` : instr*} {in:Binstr*{in <- `in*`} 0x0B} => in*{in <- `in*`}

;; A-binary.watsup
grammar Bsection_(N : N, syntax en, grammar BX : en*) : en*
  ;; A-binary.watsup
  prod{len : nat, `en*` : en*} {`%`_byte(N):Bbyte `%`_u32(len):Bu32 en*{en <- `en*`}:BX} => en*{en <- `en*`}
    -- if (len = 0)
  ;; A-binary.watsup
  prod eps => []

;; A-binary.watsup
grammar Bcustom : ()*
  ;; A-binary.watsup
  prod {Bname Bbyte*{}} => [()]

;; A-binary.watsup
grammar Bcustomsec : ()
  ;; A-binary.watsup
  prod Bsection_(0, syntax (), grammar Bcustom) => ()

;; A-binary.watsup
grammar Btype : type
  ;; A-binary.watsup
  prod{qt : rectype} qt:Brectype => TYPE_type(qt)

;; A-binary.watsup
grammar Btypesec : type*
  ;; A-binary.watsup
  prod{`ty*` : type*} ty*{ty <- `ty*`}:Bsection_(1, syntax type, grammar Blist(syntax type, grammar Btype)) => ty*{ty <- `ty*`}

;; A-binary.watsup
grammar Bimport : import
  ;; A-binary.watsup
  prod{nm_1 : name, nm_2 : name, xt : externtype} {nm_1:Bname nm_2:Bname xt:Bexterntype} => IMPORT_import(nm_1, nm_2, xt)

;; A-binary.watsup
grammar Bimportsec : import*
  ;; A-binary.watsup
  prod{`im*` : import*} im*{im <- `im*`}:Bsection_(2, syntax import, grammar Blist(syntax import, grammar Bimport)) => im*{im <- `im*`}

;; A-binary.watsup
grammar Bfuncsec : typeidx*
  ;; A-binary.watsup
  prod{`x*` : idx*} x*{x <- `x*`}:Bsection_(3, syntax typeidx, grammar Blist(syntax typeidx, grammar Btypeidx)) => x*{x <- `x*`}

;; A-binary.watsup
grammar Btable : table
  ;; A-binary.watsup
  prod{tt : tabletype, ht : heaptype, lim : limits} tt:Btabletype => TABLE_table(tt, [REF.NULL_instr(ht)])
    -- if (tt = `%%`_tabletype(lim, REF_reftype(`NULL%?`_nul(()?{}), ht)))
  ;; A-binary.watsup
  prod{tt : tabletype, e : expr} {0x40 0x00 tt:Btabletype e:Bexpr} => TABLE_table(tt, e)

;; A-binary.watsup
grammar Btablesec : table*
  ;; A-binary.watsup
  prod{`tab*` : table*} tab*{tab <- `tab*`}:Bsection_(4, syntax table, grammar Blist(syntax table, grammar Btable)) => tab*{tab <- `tab*`}

;; A-binary.watsup
grammar Bmem : mem
  ;; A-binary.watsup
  prod{mt : memtype} mt:Bmemtype => MEMORY_mem(mt)

;; A-binary.watsup
grammar Bmemsec : mem*
  ;; A-binary.watsup
  prod{`mem*` : mem*} mem*{mem <- `mem*`}:Bsection_(5, syntax mem, grammar Blist(syntax mem, grammar Bmem)) => mem*{mem <- `mem*`}

;; A-binary.watsup
grammar Bglobal : global
  ;; A-binary.watsup
  prod{gt : globaltype, e : expr} {gt:Bglobaltype e:Bexpr} => GLOBAL_global(gt, e)

;; A-binary.watsup
grammar Bglobalsec : global*
  ;; A-binary.watsup
  prod{`glob*` : global*} glob*{glob <- `glob*`}:Bsection_(6, syntax global, grammar Blist(syntax global, grammar Bglobal)) => glob*{glob <- `glob*`}

;; A-binary.watsup
grammar Bexport : export
  ;; A-binary.watsup
  prod{nm : name, xx : externidx} {nm:Bname xx:Bexternidx} => EXPORT_export(nm, xx)

;; A-binary.watsup
grammar Bexportsec : export*
  ;; A-binary.watsup
  prod{`ex*` : export*} ex*{ex <- `ex*`}:Bsection_(7, syntax export, grammar Blist(syntax export, grammar Bexport)) => ex*{ex <- `ex*`}

;; A-binary.watsup
grammar Bstart : start*
  ;; A-binary.watsup
  prod{x : idx} x:Bfuncidx => [START_start(x)]

;; A-binary.watsup
syntax startopt = start*

;; A-binary.watsup
grammar Bstartsec : start?
  ;; A-binary.watsup
  prod{startopt : startopt} startopt:Bsection_(8, syntax start, grammar Bstart) => $opt_(syntax start, startopt)

;; A-binary.watsup
grammar Belemkind : reftype
  ;; A-binary.watsup
  prod 0x00 => REF_reftype(`NULL%?`_nul(?(())), FUNC_heaptype)

;; A-binary.watsup
grammar Belem : elem
  ;; A-binary.watsup
  prod{e_o : expr, `y*` : idx*} {`%`_u32(0):Bu32 e_o:Bexpr y*{y <- `y*`}:Blist(syntax funcidx, grammar Bfuncidx)} => ELEM_elem(REF_reftype(`NULL%?`_nul(?()), FUNC_heaptype), [REF.FUNC_instr(y)]*{y <- `y*`}, ACTIVE_elemmode(`%`_tableidx(0), e_o))
  ;; A-binary.watsup
  prod{rt : reftype, `y*` : idx*} {`%`_u32(1):Bu32 rt:Belemkind y*{y <- `y*`}:Blist(syntax funcidx, grammar Bfuncidx)} => ELEM_elem(rt, [REF.FUNC_instr(y)]*{y <- `y*`}, PASSIVE_elemmode)
  ;; A-binary.watsup
  prod{x : idx, e : expr, rt : reftype, `y*` : idx*} {`%`_u32(2):Bu32 x:Btableidx e:Bexpr rt:Belemkind y*{y <- `y*`}:Blist(syntax funcidx, grammar Bfuncidx)} => ELEM_elem(rt, [REF.FUNC_instr(y)]*{y <- `y*`}, ACTIVE_elemmode(x, e))
  ;; A-binary.watsup
  prod{rt : reftype, `y*` : idx*} {`%`_u32(3):Bu32 rt:Belemkind y*{y <- `y*`}:Blist(syntax funcidx, grammar Bfuncidx)} => ELEM_elem(rt, [REF.FUNC_instr(y)]*{y <- `y*`}, DECLARE_elemmode)
  ;; A-binary.watsup
  prod{e_O : expr, `e*` : expr*} {`%`_u32(4):Bu32 e_O:Bexpr e*{e <- `e*`}:Blist(syntax expr, grammar Bexpr)} => ELEM_elem(REF_reftype(`NULL%?`_nul(?(())), FUNC_heaptype), e*{e <- `e*`}, ACTIVE_elemmode(`%`_tableidx(0), e_O))
  ;; A-binary.watsup
  prod{rt : reftype, `e*` : expr*} {`%`_u32(5):Bu32 rt:Breftype e*{e <- `e*`}:Blist(syntax expr, grammar Bexpr)} => ELEM_elem(rt, e*{e <- `e*`}, PASSIVE_elemmode)
  ;; A-binary.watsup
  prod{x : idx, e_O : expr, `e*` : expr*} {`%`_u32(6):Bu32 x:Btableidx e_O:Bexpr e*{e <- `e*`}:Blist(syntax expr, grammar Bexpr)} => ELEM_elem(REF_reftype(`NULL%?`_nul(?(())), FUNC_heaptype), e*{e <- `e*`}, ACTIVE_elemmode(x, e_O))
  ;; A-binary.watsup
  prod{rt : reftype, `e*` : expr*} {`%`_u32(7):Bu32 rt:Breftype e*{e <- `e*`}:Blist(syntax expr, grammar Bexpr)} => ELEM_elem(rt, e*{e <- `e*`}, DECLARE_elemmode)

;; A-binary.watsup
grammar Belemsec : elem*
  ;; A-binary.watsup
  prod{`elem*` : elem*} elem*{elem <- `elem*`}:Bsection_(9, syntax elem, grammar Blist(syntax elem, grammar Belem)) => elem*{elem <- `elem*`}

;; A-binary.watsup
syntax code = (local*, expr)

;; A-binary.watsup
grammar Blocals : local*
  ;; A-binary.watsup
  prod{n : n, t : valtype} {`%`_u32(n):Bu32 t:Bvaltype} => LOCAL_local(t)^n{}

;; A-binary.watsup
grammar Bfunc : code
  ;; A-binary.watsup
  prod{`loc**` : local**, e : expr} {loc*{loc <- `loc*`}*{`loc*` <- `loc**`}:Blist(syntax local*, grammar Blocals) e:Bexpr} => ($concat_(syntax local, loc*{loc <- `loc*`}*{`loc*` <- `loc**`}), e)
    -- if (|$concat_(syntax local, loc*{loc <- `loc*`}*{`loc*` <- `loc**`})| < (2 ^ 32))

;; A-binary.watsup
grammar Bcode : code
  ;; A-binary.watsup
  prod{len : nat, code : code} {`%`_u32(len):Bu32 code:Bfunc} => code
    -- if (len = 0)

;; A-binary.watsup
grammar Bcodesec : code*
  ;; A-binary.watsup
  prod{`code*` : code*} code*{code <- `code*`}:Bsection_(10, syntax code, grammar Blist(syntax code, grammar Bcode)) => code*{code <- `code*`}

;; A-binary.watsup
grammar Bdata : data
  ;; A-binary.watsup
  prod{e : expr, `b*` : byte*} {`%`_u32(0):Bu32 e:Bexpr b*{b <- `b*`}:Blist(syntax byte, grammar Bbyte)} => DATA_data(b*{b <- `b*`}, ACTIVE_datamode(`%`_memidx(0), e))
  ;; A-binary.watsup
  prod{`b*` : byte*} {`%`_u32(1):Bu32 b*{b <- `b*`}:Blist(syntax byte, grammar Bbyte)} => DATA_data(b*{b <- `b*`}, PASSIVE_datamode)
  ;; A-binary.watsup
  prod{x : idx, e : expr, `b*` : byte*} {`%`_u32(2):Bu32 x:Bmemidx e:Bexpr b*{b <- `b*`}:Blist(syntax byte, grammar Bbyte)} => DATA_data(b*{b <- `b*`}, ACTIVE_datamode(x, e))

;; A-binary.watsup
grammar Bdatasec : data*
  ;; A-binary.watsup
  prod{`data*` : data*} data*{data <- `data*`}:Bsection_(11, syntax data, grammar Blist(syntax data, grammar Bdata)) => data*{data <- `data*`}

;; A-binary.watsup
grammar Bdatacnt : u32*
  ;; A-binary.watsup
  prod{n : n} `%`_u32(n):Bu32 => [`%`_uN(n)]

;; A-binary.watsup
syntax nopt = u32*

;; A-binary.watsup
grammar Bdatacntsec : u32?
  ;; A-binary.watsup
  prod{nopt : nopt} nopt:Bsection_(12, syntax u32, grammar Bdatacnt) => $opt_(syntax u32, nopt)

;; A-binary.watsup
grammar Btag : tag
  ;; A-binary.watsup
  prod{x : idx} x:Btypeidx => TAG_tag(x)

;; A-binary.watsup
grammar Btagsec : tag*
  ;; A-binary.watsup
  prod{`tag*` : tag*} tag*{tag <- `tag*`}:Bsection_(13, syntax tag, grammar Blist(syntax tag, grammar Btag)) => tag*{tag <- `tag*`}

;; A-binary.watsup
grammar Bmagic : ()
  ;; A-binary.watsup
  prod {0x00 0x61 0x73 0x6D} => ()

;; A-binary.watsup
grammar Bversion : ()
  ;; A-binary.watsup
  prod {0x01 0x00 0x00 0x00} => ()

;; A-binary.watsup
grammar Bmodule : module
  ;; A-binary.watsup
  prod{`type*` : type*, `import*` : import*, `typeidx*` : typeidx*, `table*` : table*, `mem*` : mem*, `tag*` : tag*, `global*` : global*, `export*` : export*, `start?` : start?, `elem*` : elem*, `n?` : n?, `local**` : local**, `expr*` : expr*, `data*` : data*, `func*` : func*} {Bmagic Bversion Bcustomsec*{} type*{type <- `type*`}:Btypesec Bcustomsec*{} import*{import <- `import*`}:Bimportsec Bcustomsec*{} typeidx*{typeidx <- `typeidx*`}:Bfuncsec Bcustomsec*{} table*{table <- `table*`}:Btablesec Bcustomsec*{} mem*{mem <- `mem*`}:Bmemsec Bcustomsec*{} tag*{tag <- `tag*`}:Btagsec Bcustomsec*{} global*{global <- `global*`}:Bglobalsec Bcustomsec*{} export*{export <- `export*`}:Bexportsec Bcustomsec*{} start?{start <- `start?`}:Bstartsec Bcustomsec*{} elem*{elem <- `elem*`}:Belemsec Bcustomsec*{} `%`_u32(n)?{n <- `n?`}:Bdatacntsec Bcustomsec*{} (local*{local <- `local*`}, expr)*{expr <- `expr*`, `local*` <- `local**`}:Bcodesec Bcustomsec*{} data*{data <- `data*`}:Bdatasec Bcustomsec*{}} => MODULE_module(type*{type <- `type*`}, import*{import <- `import*`}, func*{func <- `func*`}, global*{global <- `global*`}, table*{table <- `table*`}, mem*{mem <- `mem*`}, tag*{tag <- `tag*`}, elem*{elem <- `elem*`}, data*{data <- `data*`}, start?{start <- `start?`}, export*{export <- `export*`})
    -- (if (n = |data*{data <- `data*`}|))?{n <- `n?`}
    -- if ((n?{n <- `n?`} =/= ?()) \/ ($dataidx_funcs(func*{func <- `func*`}) = []))
    -- (if (func = FUNC_func(typeidx, local*{local <- `local*`}, expr)))*{expr <- `expr*`, func <- `func*`, `local*` <- `local**`, typeidx <- `typeidx*`}

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

  ;; C-conventions.watsup:47.1-50.78
  rule block{C : context, blocktype : blocktype, `instr*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, [BLOCK_instr(blocktype, instr*{instr <- `instr*`})], `%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Blocktype_ok: `%|-%:%`(C, blocktype, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- NotationTypingInstrScheme: `%|-%:%`({TYPES [], RECS [], FUNCS [], GLOBALS [], TABLES [], MEMS [], TAGS [], ELEMS [], DATAS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 <- `t_2*`})], RETURN ?(), REFS []} +++ C, instr*{instr <- `instr*`}, `%->%`_functype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))
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
  | `LABEL_%{%}`{n : n, `instr*` : instr*}(n : n, instr*{instr <- `instr*`} : instr*)

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
  def $allocXs{syntax X, syntax Y, s : store, X : X, `X'*` : X*, Y : Y, `Y'*` : Y*, s_2 : store, a : addr, `a'*` : addr*, s_1 : store}(syntax X, syntax Y, s, [X] ++ X'*{X' <- `X'*`}, [Y] ++ Y'*{Y' <- `Y'*`}) = (s_2, [a] ++ a'*{a' <- `a'*`})
    -- if ((s_1, a) = $allocX(syntax X, syntax Y, s, X, Y))
    -- if ((s_2, a'*{a' <- `a'*`}) = $allocXs(syntax X, syntax Y, s_1, X'*{X' <- `X'*`}, Y'*{Y' <- `Y'*`}))
}

;; C-conventions.watsup
grammar Btypewriter : ()
  ;; C-conventions.watsup
  prod 0x00 => ()

;; C-conventions.watsup
syntax symdots =
  | `%`{i : nat}(i : nat)
    -- if (i = 0)

;; C-conventions.watsup
def $var(syntax X) : nat
  ;; C-conventions.watsup
  def $var{syntax X}(syntax X) = 0

;; C-conventions.watsup
grammar Bvar(syntax X) : ()
  ;; C-conventions.watsup
  prod 0x00 => ()

;; C-conventions.watsup
grammar Bsym : A
  ;; C-conventions.watsup
  prod Bvar(syntax B) => $var(syntax A)
  ;; C-conventions.watsup
  prod (Bvar(syntax symdots) | Bvar(syntax B)) => $var(syntax A)

== IL Validation...
== Complete.
```
