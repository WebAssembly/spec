
;; ../../../../specification/wasm-3.0/0.1-aux.vars.spectec
syntax N = nat

;; ../../../../specification/wasm-3.0/0.1-aux.vars.spectec
syntax M = nat

;; ../../../../specification/wasm-3.0/0.1-aux.vars.spectec
syntax K = nat

;; ../../../../specification/wasm-3.0/0.1-aux.vars.spectec
syntax n = nat

;; ../../../../specification/wasm-3.0/0.1-aux.vars.spectec
syntax m = nat

;; ../../../../specification/wasm-3.0/0.2-aux.num.spectec
def $min(nat : nat, nat : nat) : nat
  ;; ../../../../specification/wasm-3.0/0.2-aux.num.spectec
  def $min{i : nat, j : nat}(i, j) = (if (i <= j) then i else j)

;; ../../../../specification/wasm-3.0/0.2-aux.num.spectec
rec {

;; ../../../../specification/wasm-3.0/0.2-aux.num.spectec:9.1-9.56
def $sum(nat*) : nat
  ;; ../../../../specification/wasm-3.0/0.2-aux.num.spectec:10.1-10.18
  def $sum([]) = 0
  ;; ../../../../specification/wasm-3.0/0.2-aux.num.spectec:11.1-11.35
  def $sum{n : n, `n'*` : n*}([n] ++ n'*{n' <- `n'*`}) = (n + $sum(n'*{n' <- `n'*`}))
}

;; ../../../../specification/wasm-3.0/0.2-aux.num.spectec
rec {

;; ../../../../specification/wasm-3.0/0.2-aux.num.spectec:13.1-13.57
def $prod(nat*) : nat
  ;; ../../../../specification/wasm-3.0/0.2-aux.num.spectec:14.1-14.19
  def $prod([]) = 1
  ;; ../../../../specification/wasm-3.0/0.2-aux.num.spectec:15.1-15.37
  def $prod{n : n, `n'*` : n*}([n] ++ n'*{n' <- `n'*`}) = (n * $prod(n'*{n' <- `n'*`}))
}

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
def $opt_(syntax X, X*) : X?
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
  def $opt_{syntax X}(syntax X, []) = ?()
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
  def $opt_{syntax X, w : X}(syntax X, [w]) = ?(w)

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
rec {

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:14.1-14.82
def $concat_(syntax X, X**) : X*
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:15.1-15.34
  def $concat_{syntax X}(syntax X, []) = []
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:16.1-16.64
  def $concat_{syntax X, `w*` : X*, `w'**` : X**}(syntax X, [w*{w <- `w*`}] ++ w'*{w' <- `w'*`}*{`w'*` <- `w'**`}) = w*{w <- `w*`} ++ $concat_(syntax X, w'*{w' <- `w'*`}*{`w'*` <- `w'**`})
}

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
rec {

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:18.1-18.89
def $concatn_(syntax X, X**, nat : nat) : X*
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:19.1-19.38
  def $concatn_{syntax X, n : n}(syntax X, [], n) = []
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:20.1-20.73
  def $concatn_{syntax X, `w*` : X*, n : n, `w'**` : X**}(syntax X, [w^n{w <- `w*`}] ++ w'^n{w' <- `w'*`}*{`w'*` <- `w'**`}, n) = w^n{w <- `w*`} ++ $concatn_(syntax X, w'^n{w' <- `w'*`}*{`w'*` <- `w'**`}, n)
}

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
def $concatopt_(syntax X, X?*) : X*
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
  def $concatopt_{syntax X}(syntax X, []) = []
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
  def $concatopt_{syntax X, `w?` : X?, `w'?*` : X?*}(syntax X, [w?{w <- `w?`}] ++ w'?{w' <- `w'?`}*{`w'?` <- `w'?*`}) = lift(w?{w <- `w?`}) ++ $concat_(syntax X, lift(w'?{w' <- `w'?`})*{`w'?` <- `w'?*`})

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
def $inv_concat_(syntax X, X*) : X**

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
def $inv_concatn_(syntax X, nat : nat, X*) : X**

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
rec {

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:35.1-35.78
def $disjoint_(syntax X, X*) : bool
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:36.1-36.37
  def $disjoint_{syntax X}(syntax X, []) = true
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:37.1-37.68
  def $disjoint_{syntax X, w : X, `w'*` : X*}(syntax X, [w] ++ w'*{w' <- `w'*`}) = (~ (w <- w'*{w' <- `w'*`}) /\ $disjoint_(syntax X, w'*{w' <- `w'*`}))
}

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
rec {

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:40.1-40.38
def $setminus1_(syntax X, X : X, X*) : X*
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:44.1-44.38
  def $setminus1_{syntax X, w : X}(syntax X, w, []) = [w]
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:45.1-45.78
  def $setminus1_{syntax X, w : X, w_1 : X, `w'*` : X*}(syntax X, w, [w_1] ++ w'*{w' <- `w'*`}) = (if (w = w_1) then [] else $setminus1_(syntax X, w, w'*{w' <- `w'*`}))
}

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
rec {

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:39.1-39.56
def $setminus_(syntax X, X*, X*) : X*
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:42.1-42.40
  def $setminus_{syntax X, `w*` : X*}(syntax X, [], w*{w <- `w*`}) = []
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:43.1-43.90
  def $setminus_{syntax X, w_1 : X, `w'*` : X*, `w*` : X*}(syntax X, [w_1] ++ w'*{w' <- `w'*`}, w*{w <- `w*`}) = $setminus1_(syntax X, w_1, w*{w <- `w*`}) ++ $setminus_(syntax X, w'*{w' <- `w'*`}, w*{w <- `w*`})
}

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
rec {

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:51.1-51.46
def $setproduct2_(syntax X, X : X, X**) : X**
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:57.1-57.44
  def $setproduct2_{syntax X, w_1 : X}(syntax X, w_1, []) = []
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:58.1-58.90
  def $setproduct2_{syntax X, w_1 : X, `w'*` : X*, `w**` : X**}(syntax X, w_1, [w'*{w' <- `w'*`}] ++ w*{w <- `w*`}*{`w*` <- `w**`}) = [[w_1] ++ w'*{w' <- `w'*`}] ++ $setproduct2_(syntax X, w_1, w*{w <- `w*`}*{`w*` <- `w**`})
}

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
rec {

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:50.1-50.47
def $setproduct1_(syntax X, X*, X**) : X**
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:55.1-55.46
  def $setproduct1_{syntax X, `w**` : X**}(syntax X, [], w*{w <- `w*`}*{`w*` <- `w**`}) = []
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:56.1-56.107
  def $setproduct1_{syntax X, w_1 : X, `w'*` : X*, `w**` : X**}(syntax X, [w_1] ++ w'*{w' <- `w'*`}, w*{w <- `w*`}*{`w*` <- `w**`}) = $setproduct2_(syntax X, w_1, w*{w <- `w*`}*{`w*` <- `w**`}) ++ $setproduct1_(syntax X, w'*{w' <- `w'*`}, w*{w <- `w*`}*{`w*` <- `w**`})
}

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec
rec {

;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:49.1-49.84
def $setproduct_(syntax X, X**) : X**
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:53.1-53.40
  def $setproduct_{syntax X}(syntax X, []) = [[]]
  ;; ../../../../specification/wasm-3.0/0.3-aux.seq.spectec:54.1-54.90
  def $setproduct_{syntax X, `w_1*` : X*, `w**` : X**}(syntax X, [w_1*{w_1 <- `w_1*`}] ++ w*{w <- `w*`}*{`w*` <- `w**`}) = $setproduct1_(syntax X, w_1*{w_1 <- `w_1*`}, $setproduct_(syntax X, w*{w <- `w*`}*{`w*` <- `w**`}))
}

;; ../../../../specification/wasm-3.0/1.0-syntax.profiles.spectec
def $ND : bool

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax bit = 
  | `%`{i : nat}(i : nat)
    -- if ((i = 0) \/ (i = 1))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax byte = 
  | `%`{i : nat}(i : nat)
    -- if ((i >= 0) /\ (i <= 255))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax uN{N : N}(N) = 
  | `%`{i : nat}(i : nat)
    -- if ((i >= 0) /\ (i <= ((((2 ^ N) : nat <:> int) - (1 : nat <:> int)) : int <:> nat)))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax sN{N : N}(N) = 
  | `%`{i : int}(i : int)
    -- if ((((i >= - ((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int)) /\ (i <= - (1 : nat <:> int))) \/ (i = (0 : nat <:> int))) \/ ((i >= + (1 : nat <:> int)) /\ (i <= (+ ((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int) - (1 : nat <:> int)))))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax iN{N : N}(N) = uN(N)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax u8 = uN(8)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax u16 = uN(16)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax u31 = uN(31)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax u32 = uN(32)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax u64 = uN(64)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax s33 = sN(33)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax i32 = iN(32)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax i64 = iN(64)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax i128 = iN(128)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $signif(N : N) : nat
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $signif(32) = 23
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $signif(64) = 52

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $expon(N : N) : nat
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $expon(32) = 8
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $expon(64) = 11

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $M(N : N) : nat
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $M{N : N}(N) = $signif(N)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $E(N : N) : nat
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $E{N : N}(N) = $expon(N)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax exp = int

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax fNmag{N : N}(N) = 
  | NORM{m : m, exp : exp}(m : m, exp : exp)
    -- if ((m < (2 ^ $M(N))) /\ ((((2 : nat <:> int) - ((2 ^ ((($E(N) : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int)) <= exp) /\ (exp <= (((2 ^ ((($E(N) : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int) - (1 : nat <:> int)))))
  | SUBNORM{m : m, exp : exp}(m : m)
    -- if ((m < (2 ^ $M(N))) /\ (((2 : nat <:> int) - ((2 ^ ((($E(N) : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int)) = exp))
  | INF
  | NAN{m : m}(m : m)
    -- if ((1 <= m) /\ (m < (2 ^ $M(N))))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax fN{N : N}(N) = 
  | POS{fNmag : fNmag(N)}(fNmag : fNmag(N))
  | NEG{fNmag : fNmag(N)}(fNmag : fNmag(N))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax f32 = fN(32)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax f64 = fN(64)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $fzero(N : N) : fN(N)
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $fzero{N : N}(N) = POS_fN(SUBNORM_fNmag(0))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $fnat(N : N, nat : nat) : fN(N)
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $fnat{N : N, n : n}(N, n) = POS_fN(NORM_fNmag(n, (0 : nat <:> int)))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $fone(N : N) : fN(N)
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $fone{N : N}(N) = POS_fN(NORM_fNmag(1, (0 : nat <:> int)))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $canon_(N : N) : nat
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $canon_{N : N}(N) = (2 ^ ((($signif(N) : nat <:> int) - (1 : nat <:> int)) : int <:> nat))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax vN{N : N}(N) = uN(N)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax v128 = vN(128)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax list{syntax X}(syntax X) = 
  | `%`{`X*` : X*}(X*{X <- `X*`} : X*)
    -- if (|X*{X <- `X*`}| < (2 ^ 32))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax char = 
  | `%`{i : nat}(i : nat)
    -- if (((i >= 0) /\ (i <= 55295)) \/ ((i >= 57344) /\ (i <= 1114111)))

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
def $cont(byte : byte) : nat
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  def $cont{b : byte}(b) = (((b!`%`_byte.0 : nat <:> int) - (128 : nat <:> int)) : int <:> nat)
    -- if ((128 < b!`%`_byte.0) /\ (b!`%`_byte.0 < 192))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
rec {

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:91.1-91.25
def $utf8(char*) : byte*
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec:52.1-52.44
  def $utf8{`ch*` : char*}(ch*{ch <- `ch*`}) = $concat_(syntax byte, $utf8([ch])*{ch <- `ch*`})
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec:53.1-55.15
  def $utf8{ch : char, b : byte}([ch]) = [b]
    -- if (ch!`%`_char.0 < 128)
    -- if (`%`_byte(ch!`%`_char.0) = b)
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec:56.1-58.46
  def $utf8{ch : char, b_1 : byte, b_2 : byte}([ch]) = [b_1 b_2]
    -- if ((128 <= ch!`%`_char.0) /\ (ch!`%`_char.0 < 2048))
    -- if (ch!`%`_char.0 = (((2 ^ 6) * (((b_1!`%`_byte.0 : nat <:> int) - (192 : nat <:> int)) : int <:> nat)) + $cont(b_2)))
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec:59.1-61.64
  def $utf8{ch : char, b_1 : byte, b_2 : byte, b_3 : byte}([ch]) = [b_1 b_2 b_3]
    -- if (((2048 <= ch!`%`_char.0) /\ (ch!`%`_char.0 < 55296)) \/ ((57344 <= ch!`%`_char.0) /\ (ch!`%`_char.0 < 65536)))
    -- if (ch!`%`_char.0 = ((((2 ^ 12) * (((b_1!`%`_byte.0 : nat <:> int) - (224 : nat <:> int)) : int <:> nat)) + ((2 ^ 6) * $cont(b_2))) + $cont(b_3)))
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec:62.1-64.82
  def $utf8{ch : char, b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte}([ch]) = [b_1 b_2 b_3 b_4]
    -- if ((65536 <= ch!`%`_char.0) /\ (ch!`%`_char.0 < 69632))
    -- if (ch!`%`_char.0 = (((((2 ^ 18) * (((b_1!`%`_byte.0 : nat <:> int) - (240 : nat <:> int)) : int <:> nat)) + ((2 ^ 12) * $cont(b_2))) + ((2 ^ 6) * $cont(b_3))) + $cont(b_4)))
}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax name = 
  | `%`{`char*` : char*}(char*{char <- `char*`} : char*)
    -- if (|$utf8(char*{char <- `char*`})| < (2 ^ 32))

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax idx = u32

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax laneidx = u8

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax typeidx = idx

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax funcidx = idx

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax globalidx = idx

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax tableidx = idx

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax memidx = idx

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax tagidx = idx

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax elemidx = idx

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax dataidx = idx

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax labelidx = idx

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax localidx = idx

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax fieldidx = idx

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
syntax externidx = 
  | FUNC{funcidx : funcidx}(funcidx : funcidx)
  | GLOBAL{globalidx : globalidx}(globalidx : globalidx)
  | TABLE{tableidx : tableidx}(tableidx : tableidx)
  | MEM{memidx : memidx}(memidx : memidx)
  | TAG{tagidx : tagidx}(tagidx : tagidx)

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
rec {

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:129.1-129.86
def $funcsxx(externidx*) : typeidx*
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:135.1-135.24
  def $funcsxx([]) = []
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:136.1-136.45
  def $funcsxx{x : idx, `xx*` : externidx*}([FUNC_externidx(x)] ++ xx*{xx <- `xx*`}) = [x] ++ $funcsxx(xx*{xx <- `xx*`})
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:137.1-137.58
  def $funcsxx{externidx : externidx, `xx*` : externidx*}([externidx] ++ xx*{xx <- `xx*`}) = $funcsxx(xx*{xx <- `xx*`})
}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
rec {

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:130.1-130.88
def $globalsxx(externidx*) : globalidx*
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:139.1-139.26
  def $globalsxx([]) = []
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:140.1-140.51
  def $globalsxx{x : idx, `xx*` : externidx*}([GLOBAL_externidx(x)] ++ xx*{xx <- `xx*`}) = [x] ++ $globalsxx(xx*{xx <- `xx*`})
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:141.1-141.62
  def $globalsxx{externidx : externidx, `xx*` : externidx*}([externidx] ++ xx*{xx <- `xx*`}) = $globalsxx(xx*{xx <- `xx*`})
}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
rec {

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:131.1-131.87
def $tablesxx(externidx*) : tableidx*
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:143.1-143.25
  def $tablesxx([]) = []
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:144.1-144.48
  def $tablesxx{x : idx, `xx*` : externidx*}([TABLE_externidx(x)] ++ xx*{xx <- `xx*`}) = [x] ++ $tablesxx(xx*{xx <- `xx*`})
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:145.1-145.60
  def $tablesxx{externidx : externidx, `xx*` : externidx*}([externidx] ++ xx*{xx <- `xx*`}) = $tablesxx(xx*{xx <- `xx*`})
}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
rec {

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:132.1-132.85
def $memsxx(externidx*) : memidx*
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:147.1-147.23
  def $memsxx([]) = []
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:148.1-148.42
  def $memsxx{x : idx, `xx*` : externidx*}([MEM_externidx(x)] ++ xx*{xx <- `xx*`}) = [x] ++ $memsxx(xx*{xx <- `xx*`})
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:149.1-149.56
  def $memsxx{externidx : externidx, `xx*` : externidx*}([externidx] ++ xx*{xx <- `xx*`}) = $memsxx(xx*{xx <- `xx*`})
}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
rec {

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:133.1-133.85
def $tagsxx(externidx*) : tagidx*
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:151.1-151.23
  def $tagsxx([]) = []
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:152.1-152.42
  def $tagsxx{x : idx, `xx*` : externidx*}([TAG_externidx(x)] ++ xx*{xx <- `xx*`}) = [x] ++ $tagsxx(xx*{xx <- `xx*`})
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:153.1-153.56
  def $tagsxx{externidx : externidx, `xx*` : externidx*}([externidx] ++ xx*{xx <- `xx*`}) = $tagsxx(xx*{xx <- `xx*`})
}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
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

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $free_opt(free?) : free
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_opt(?()) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_opt{free : free}(?(free)) = free

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
rec {

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:172.1-172.29
def $free_list(free*) : free
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:177.1-177.25
  def $free_list([]) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec:178.1-178.57
  def $free_list{free : free, `free'*` : free*}([free] ++ free'*{free' <- `free'*`}) = free +++ $free_list(free'*{free' <- `free'*`})
}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $free_typeidx(typeidx : typeidx) : free
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_typeidx{typeidx : typeidx}(typeidx) = {TYPES [typeidx], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $free_funcidx(funcidx : funcidx) : free
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_funcidx{funcidx : funcidx}(funcidx) = {TYPES [], FUNCS [funcidx], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $free_globalidx(globalidx : globalidx) : free
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_globalidx{globalidx : globalidx}(globalidx) = {TYPES [], FUNCS [], GLOBALS [globalidx], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $free_tableidx(tableidx : tableidx) : free
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_tableidx{tableidx : tableidx}(tableidx) = {TYPES [], FUNCS [], GLOBALS [], TABLES [tableidx], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $free_memidx(memidx : memidx) : free
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_memidx{memidx : memidx}(memidx) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [memidx], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $free_elemidx(elemidx : elemidx) : free
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_elemidx{elemidx : elemidx}(elemidx) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [elemidx], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $free_dataidx(dataidx : dataidx) : free
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_dataidx{dataidx : dataidx}(dataidx) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [dataidx], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $free_localidx(localidx : localidx) : free
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_localidx{localidx : localidx}(localidx) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [localidx], LABELS []}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $free_labelidx(labelidx : labelidx) : free
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_labelidx{labelidx : labelidx}(labelidx) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS [labelidx]}

;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
def $free_externidx(externidx : externidx) : free
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_externidx{funcidx : funcidx}(FUNC_externidx(funcidx)) = $free_funcidx(funcidx)
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_externidx{globalidx : globalidx}(GLOBAL_externidx(globalidx)) = $free_globalidx(globalidx)
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_externidx{tableidx : tableidx}(TABLE_externidx(tableidx)) = $free_tableidx(tableidx)
  ;; ../../../../specification/wasm-3.0/1.1-syntax.values.spectec
  def $free_externidx{memidx : memidx}(MEM_externidx(memidx)) = $free_memidx(memidx)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax null = 
  | NULL

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax addrtype = 
  | I32
  | I64

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax numtype = 
  | I32
  | I64
  | F32
  | F64

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax vectype = 
  | V128

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax consttype = 
  | I32
  | I64
  | F32
  | F64
  | V128

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
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

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax mut = 
  | MUT

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax final = 
  | FINAL

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
rec {

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:37.1-38.43
syntax typeuse = 
  | _IDX{typeidx : typeidx}(typeidx : typeidx)
  | _DEF{rectype : rectype, n : n}(rectype : rectype, n : n)
  | REC{n : n}(n : n)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:43.1-44.26
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
  | _DEF{rectype : rectype, n : n}(rectype : rectype, n : n)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:51.1-52.14
syntax valtype = 
  | I32
  | I64
  | F32
  | F64
  | V128
  | REF{`null?` : null?, heaptype : heaptype}(null?{null <- `null?`} : null?, heaptype : heaptype)
  | BOT

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:92.1-92.66
syntax storagetype = 
  | BOT
  | I32
  | I64
  | F32
  | F64
  | V128
  | REF{`null?` : null?, heaptype : heaptype}(null?{null <- `null?`} : null?, heaptype : heaptype)
  | I8
  | I16

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:102.1-103.16
syntax resulttype = list(syntax valtype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:112.1-112.61
syntax fieldtype = 
  | `%%`{`mut?` : mut?, storagetype : storagetype}(mut?{mut <- `mut?`} : mut?, storagetype : storagetype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:114.1-117.34
syntax comptype = 
  | STRUCT{list : list(syntax fieldtype)}(list : list(syntax fieldtype))
  | ARRAY{fieldtype : fieldtype}(fieldtype : fieldtype)
  | `FUNC%->%`{resulttype : resulttype}(resulttype : resulttype, resulttype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:119.1-120.33
syntax subtype = 
  | SUB{`final?` : final?, `typeuse*` : typeuse*, comptype : comptype}(final?{final <- `final?`} : final?, typeuse*{typeuse <- `typeuse*`} : typeuse*, comptype : comptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:122.1-123.22
syntax rectype = 
  | REC{list : list(syntax subtype)}(list : list(syntax subtype))
}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax deftype = 
  | _DEF{rectype : rectype, n : n}(rectype : rectype, n : n)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax typevar = 
  | _IDX{typeidx : typeidx}(typeidx : typeidx)
  | REC{n : n}(n : n)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax reftype = 
  | REF{`null?` : null?, heaptype : heaptype}(null?{null <- `null?`} : null?, heaptype : heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax Inn = addrtype

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax Fnn = 
  | F32
  | F64

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax Vnn = vectype

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax Cnn = 
  | I32
  | I64
  | F32
  | F64
  | V128

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $ANYREF : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $ANYREF = REF_reftype(?(NULL_null), ANY_heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $EQREF : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $EQREF = REF_reftype(?(NULL_null), EQ_heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $I31REF : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $I31REF = REF_reftype(?(NULL_null), I31_heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $STRUCTREF : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $STRUCTREF = REF_reftype(?(NULL_null), STRUCT_heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $ARRAYREF : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $ARRAYREF = REF_reftype(?(NULL_null), ARRAY_heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $FUNCREF : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $FUNCREF = REF_reftype(?(NULL_null), FUNC_heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $EXNREF : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $EXNREF = REF_reftype(?(NULL_null), EXN_heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $EXTERNREF : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $EXTERNREF = REF_reftype(?(NULL_null), EXTERN_heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $NULLREF : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $NULLREF = REF_reftype(?(NULL_null), NONE_heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $NULLFUNCREF : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $NULLFUNCREF = REF_reftype(?(NULL_null), NOFUNC_heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $NULLEXNREF : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $NULLEXNREF = REF_reftype(?(NULL_null), NOEXN_heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $NULLEXTERNREF : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $NULLEXTERNREF = REF_reftype(?(NULL_null), NOEXTERN_heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax packtype = 
  | I8
  | I16

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax lanetype = 
  | I32
  | I64
  | F32
  | F64
  | I8
  | I16

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax Pnn = packtype

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax Jnn = 
  | I32
  | I64
  | I8
  | I16

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax Lnn = lanetype

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax limits = 
  | `[%..%]`{u64 : u64}(u64 : u64, u64?)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax tagtype = typeuse

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax globaltype = 
  | `%%`{`mut?` : mut?, valtype : valtype}(mut?{mut <- `mut?`} : mut?, valtype : valtype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax memtype = 
  | `%%PAGE`{addrtype : addrtype, limits : limits}(addrtype : addrtype, limits : limits)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax tabletype = 
  | `%%%`{addrtype : addrtype, limits : limits, reftype : reftype}(addrtype : addrtype, limits : limits, reftype : reftype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax datatype = 
  | OK

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax elemtype = reftype

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax externtype = 
  | TAG{tagtype : tagtype}(tagtype : tagtype)
  | GLOBAL{globaltype : globaltype}(globaltype : globaltype)
  | MEM{memtype : memtype}(memtype : memtype)
  | TABLE{tabletype : tabletype}(tabletype : tabletype)
  | FUNC{typeuse : typeuse}(typeuse : typeuse)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
syntax moduletype = 
  | `%->%`{`externtype*` : externtype*}(externtype*{externtype <- `externtype*`} : externtype*, externtype*)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $IN(N : N) : Inn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $IN(32) = I32_Inn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $IN(64) = I64_Inn

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $FN(N : N) : Fnn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $FN(32) = F32_Fnn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $FN(64) = F64_Fnn

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $JN(N : N) : Jnn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $JN(8) = I8_Jnn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $JN(16) = I16_Jnn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $JN(32) = I32_Jnn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $JN(64) = I64_Jnn

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $size(numtype : numtype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $size(I32_numtype) = 32
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $size(I64_numtype) = 64
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $size(F32_numtype) = 32
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $size(F64_numtype) = 64

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $vsize(vectype : vectype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $vsize(V128_vectype) = 128

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $psize(packtype : packtype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $psize(I8_packtype) = 8
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $psize(I16_packtype) = 16

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $lsize(lanetype : lanetype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $lsize{numtype : numtype}((numtype : numtype <: lanetype)) = $size(numtype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $lsize{packtype : packtype}((packtype : packtype <: lanetype)) = $psize(packtype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $zsize(storagetype : storagetype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $zsize{numtype : numtype}((numtype : numtype <: storagetype)) = $size(numtype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $zsize{vectype : vectype}((vectype : vectype <: storagetype)) = $vsize(vectype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $zsize{packtype : packtype}((packtype : packtype <: storagetype)) = $psize(packtype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $isize(Inn : Inn) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $isize{Inn : Inn}(Inn) = $size((Inn : addrtype <: numtype))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $jsize(Jnn : Jnn) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $jsize{Jnn : Jnn}(Jnn) = $lsize((Jnn : Jnn <: lanetype))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $fsize(Fnn : Fnn) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $fsize{Fnn : Fnn}(Fnn) = $size((Fnn : Fnn <: numtype))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $inv_isize(nat : nat) : Inn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $inv_isize(32) = I32_Inn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $inv_isize(64) = I64_Inn

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $inv_jsize(nat : nat) : Jnn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $inv_jsize(8) = I8_Jnn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $inv_jsize(16) = I16_Jnn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $inv_jsize{n : n}(n) = ($inv_isize(n) : addrtype <: Jnn)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $inv_fsize(nat : nat) : Fnn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $inv_fsize(32) = F32_Fnn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $inv_fsize(64) = F64_Fnn

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $sizenn(numtype : numtype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $sizenn{nt : numtype}(nt) = $size(nt)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $sizenn1(numtype : numtype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $sizenn1{nt : numtype}(nt) = $size(nt)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $sizenn2(numtype : numtype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $sizenn2{nt : numtype}(nt) = $size(nt)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $vsizenn(vectype : vectype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $vsizenn{vt : vectype}(vt) = $vsize(vt)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $psizenn(packtype : packtype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $psizenn{pt : packtype}(pt) = $psize(pt)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $lsizenn(lanetype : lanetype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $lsizenn{lt : lanetype}(lt) = $lsize(lt)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $lsizenn1(lanetype : lanetype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $lsizenn1{lt : lanetype}(lt) = $lsize(lt)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $lsizenn2(lanetype : lanetype) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $lsizenn2{lt : lanetype}(lt) = $lsize(lt)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $jsizenn(Jnn : Jnn) : nat
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $jsizenn{Jnn : Jnn}(Jnn) = $lsize((Jnn : Jnn <: lanetype))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $inv_jsizenn(nat : nat) : Jnn
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $inv_jsizenn{n : n}(n) = $inv_jsize(n)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $lunpack(lanetype : lanetype) : numtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $lunpack{numtype : numtype}((numtype : numtype <: lanetype)) = numtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $lunpack{packtype : packtype}((packtype : packtype <: lanetype)) = I32_numtype

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $unpack(storagetype : storagetype) : valtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $unpack{valtype : valtype}((valtype : valtype <: storagetype)) = valtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $unpack{packtype : packtype}((packtype : packtype <: storagetype)) = I32_valtype

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $nunpack(storagetype : storagetype) : numtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $nunpack{numtype : numtype}((numtype : numtype <: storagetype)) = numtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $nunpack{packtype : packtype}((packtype : packtype <: storagetype)) = I32_numtype

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $vunpack(storagetype : storagetype) : vectype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $vunpack{vectype : vectype}((vectype : vectype <: storagetype)) = vectype

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $cunpack(storagetype : storagetype) : consttype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $cunpack{consttype : consttype}((consttype : consttype <: storagetype)) = consttype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $cunpack{packtype : packtype}((packtype : packtype <: storagetype)) = I32_consttype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $cunpack{lanetype : lanetype}((lanetype : lanetype <: storagetype)) = ($lunpack(lanetype) : numtype <: consttype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $minat(addrtype : addrtype, addrtype : addrtype) : addrtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $minat{at_1 : addrtype, at_2 : addrtype}(at_1, at_2) = (if ($size((at_1 : addrtype <: numtype)) <= $size((at_2 : addrtype <: numtype))) then at_1 else at_2)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $diffrt(reftype : reftype, reftype : reftype) : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $diffrt{`null_1?` : null?, ht_1 : heaptype, ht_2 : heaptype}(REF_reftype(null_1?{null_1 <- `null_1?`}, ht_1), REF_reftype(?(NULL_null), ht_2)) = REF_reftype(?(), ht_1)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $diffrt{`null_1?` : null?, ht_1 : heaptype, ht_2 : heaptype}(REF_reftype(null_1?{null_1 <- `null_1?`}, ht_1), REF_reftype(?(), ht_2)) = REF_reftype(null_1?{null_1 <- `null_1?`}, ht_1)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $as_deftype(typeuse : typeuse) : deftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $as_deftype{dt : deftype}((dt : deftype <: typeuse)) = dt

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
rec {

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:308.1-308.87
def $tagsxt(externtype*) : tagtype*
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:314.1-314.23
  def $tagsxt([]) = []
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:315.1-315.44
  def $tagsxt{jt : tagtype, `xt*` : externtype*}([TAG_externtype(jt)] ++ xt*{xt <- `xt*`}) = [jt] ++ $tagsxt(xt*{xt <- `xt*`})
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:316.1-316.57
  def $tagsxt{externtype : externtype, `xt*` : externtype*}([externtype] ++ xt*{xt <- `xt*`}) = $tagsxt(xt*{xt <- `xt*`})
}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
rec {

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:309.1-309.90
def $globalsxt(externtype*) : globaltype*
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:318.1-318.26
  def $globalsxt([]) = []
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:319.1-319.53
  def $globalsxt{gt : globaltype, `xt*` : externtype*}([GLOBAL_externtype(gt)] ++ xt*{xt <- `xt*`}) = [gt] ++ $globalsxt(xt*{xt <- `xt*`})
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:320.1-320.63
  def $globalsxt{externtype : externtype, `xt*` : externtype*}([externtype] ++ xt*{xt <- `xt*`}) = $globalsxt(xt*{xt <- `xt*`})
}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
rec {

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:310.1-310.87
def $memsxt(externtype*) : memtype*
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:322.1-322.23
  def $memsxt([]) = []
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:323.1-323.44
  def $memsxt{mt : memtype, `xt*` : externtype*}([MEM_externtype(mt)] ++ xt*{xt <- `xt*`}) = [mt] ++ $memsxt(xt*{xt <- `xt*`})
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:324.1-324.57
  def $memsxt{externtype : externtype, `xt*` : externtype*}([externtype] ++ xt*{xt <- `xt*`}) = $memsxt(xt*{xt <- `xt*`})
}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
rec {

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:311.1-311.89
def $tablesxt(externtype*) : tabletype*
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:326.1-326.25
  def $tablesxt([]) = []
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:327.1-327.50
  def $tablesxt{tt : tabletype, `xt*` : externtype*}([TABLE_externtype(tt)] ++ xt*{xt <- `xt*`}) = [tt] ++ $tablesxt(xt*{xt <- `xt*`})
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:328.1-328.61
  def $tablesxt{externtype : externtype, `xt*` : externtype*}([externtype] ++ xt*{xt <- `xt*`}) = $tablesxt(xt*{xt <- `xt*`})
}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
rec {

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:312.1-312.88
def $funcsxt(externtype*) : deftype*
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:330.1-330.24
  def $funcsxt([]) = []
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:331.1-331.47
  def $funcsxt{dt : deftype, `xt*` : externtype*}([FUNC_externtype((dt : deftype <: typeuse))] ++ xt*{xt <- `xt*`}) = [dt] ++ $funcsxt(xt*{xt <- `xt*`})
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:332.1-332.59
  def $funcsxt{externtype : externtype, `xt*` : externtype*}([externtype] ++ xt*{xt <- `xt*`}) = $funcsxt(xt*{xt <- `xt*`})
}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
rec {

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:337.1-337.112
def $subst_typevar(typevar : typevar, typevar*, typeuse*) : typeuse
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:365.1-365.38
  def $subst_typevar{tv : typevar}(tv, [], []) = (tv : typevar <: typeuse)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:366.1-366.95
  def $subst_typevar{tv : typevar, tv_1 : typevar, `tv'*` : typevar*, tu_1 : typeuse, `tu'*` : typeuse*}(tv, [tv_1] ++ tv'*{tv' <- `tv'*`}, [tu_1] ++ tu'*{tu' <- `tu'*`}) = (if (tv = tv_1) then tu_1 else $subst_typevar(tv, tv'*{tv' <- `tv'*`}, tu'*{tu' <- `tu'*`}))
}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
rec {

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:401.1-401.59
def $minus_recs(typevar*, typeuse*) : (typevar*, typeuse*)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:402.1-402.39
  def $minus_recs([], []) = ([], [])
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:403.1-403.63
  def $minus_recs{n : n, `tv*` : typevar*, tu_1 : typeuse, `tu*` : typeuse*}([REC_typevar(n)] ++ tv*{tv <- `tv*`}, [tu_1] ++ tu*{tu <- `tu*`}) = $minus_recs(tv*{tv <- `tv*`}, tu*{tu <- `tu*`})
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:404.1-405.45
  def $minus_recs{x : idx, `tv*` : typevar*, tu_1 : typeuse, `tu*` : typeuse*, `tv'*` : typevar*, `tu'*` : typeuse*}([_IDX_typevar(x)] ++ tv*{tv <- `tv*`}, [tu_1] ++ tu*{tu <- `tu*`}) = ([_IDX_typevar(x)] ++ tv'*{tv' <- `tv'*`}, [tu_1] ++ tu'*{tu' <- `tu'*`})
    -- if ((tv'*{tv' <- `tv'*`}, tu'*{tu' <- `tu'*`}) = $minus_recs(tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))
}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_packtype(packtype : packtype, typevar*, typeuse*) : packtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_packtype{pt : packtype, `tv*` : typevar*, `tu*` : typeuse*}(pt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = pt

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_numtype(numtype : numtype, typevar*, typeuse*) : numtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_numtype{nt : numtype, `tv*` : typevar*, `tu*` : typeuse*}(nt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = nt

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_vectype(vectype : vectype, typevar*, typeuse*) : vectype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_vectype{vt : vectype, `tv*` : typevar*, `tu*` : typeuse*}(vt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = vt

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
rec {

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:338.1-338.112
def $subst_typeuse(typeuse : typeuse, typevar*, typeuse*) : typeuse
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:369.1-369.66
  def $subst_typeuse{tv' : typevar, `tv*` : typevar*, `tu*` : typeuse*}((tv' : typevar <: typeuse), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = $subst_typevar(tv', tv*{tv <- `tv*`}, tu*{tu <- `tu*`})
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:370.1-370.64
  def $subst_typeuse{dt : deftype, `tv*` : typevar*, `tu*` : typeuse*}((dt : deftype <: typeuse), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_deftype(dt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : deftype <: typeuse)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:343.1-343.112
def $subst_heaptype(heaptype : heaptype, typevar*, typeuse*) : heaptype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:376.1-376.67
  def $subst_heaptype{tv' : typevar, `tv*` : typevar*, `tu*` : typeuse*}((tv' : typevar <: heaptype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_typevar(tv', tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : typeuse <: heaptype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:377.1-377.65
  def $subst_heaptype{dt : deftype, `tv*` : typevar*, `tu*` : typeuse*}((dt : deftype <: heaptype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_deftype(dt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : deftype <: heaptype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:378.1-378.53
  def $subst_heaptype{ht : heaptype, `tv*` : typevar*, `tu*` : typeuse*}(ht, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ht

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:344.1-344.112
def $subst_reftype(reftype : reftype, typevar*, typeuse*) : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:380.1-380.87
  def $subst_reftype{`null?` : null?, ht : heaptype, `tv*` : typevar*, `tu*` : typeuse*}(REF_reftype(null?{null <- `null?`}, ht), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = REF_reftype(null?{null <- `null?`}, $subst_heaptype(ht, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:345.1-345.112
def $subst_valtype(valtype : valtype, typevar*, typeuse*) : valtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:382.1-382.64
  def $subst_valtype{nt : numtype, `tv*` : typevar*, `tu*` : typeuse*}((nt : numtype <: valtype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_numtype(nt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : numtype <: valtype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:383.1-383.64
  def $subst_valtype{vt : vectype, `tv*` : typevar*, `tu*` : typeuse*}((vt : vectype <: valtype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_vectype(vt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : vectype <: valtype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:384.1-384.64
  def $subst_valtype{rt : reftype, `tv*` : typevar*, `tu*` : typeuse*}((rt : reftype <: valtype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_reftype(rt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : reftype <: valtype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:385.1-385.40
  def $subst_valtype{`tv*` : typevar*, `tu*` : typeuse*}(BOT_valtype, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = BOT_valtype

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:348.1-348.112
def $subst_storagetype(storagetype : storagetype, typevar*, typeuse*) : storagetype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:389.1-389.66
  def $subst_storagetype{t : valtype, `tv*` : typevar*, `tu*` : typeuse*}((t : valtype <: storagetype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_valtype(t, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : valtype <: storagetype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:390.1-390.69
  def $subst_storagetype{pt : packtype, `tv*` : typevar*, `tu*` : typeuse*}((pt : packtype <: storagetype), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ($subst_packtype(pt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : packtype <: storagetype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:349.1-349.112
def $subst_fieldtype(fieldtype : fieldtype, typevar*, typeuse*) : fieldtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:392.1-392.82
  def $subst_fieldtype{`mut?` : mut?, zt : storagetype, `tv*` : typevar*, `tu*` : typeuse*}(`%%`_fieldtype(mut?{mut <- `mut?`}, zt), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = `%%`_fieldtype(mut?{mut <- `mut?`}, $subst_storagetype(zt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:351.1-351.112
def $subst_comptype(comptype : comptype, typevar*, typeuse*) : comptype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:394.1-394.85
  def $subst_comptype{`ft*` : fieldtype*, `tv*` : typevar*, `tu*` : typeuse*}(STRUCT_comptype(`%`_list(ft*{ft <- `ft*`})), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = STRUCT_comptype(`%`_list($subst_fieldtype(ft, tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{ft <- `ft*`}))
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:395.1-395.81
  def $subst_comptype{ft : fieldtype, `tv*` : typevar*, `tu*` : typeuse*}(ARRAY_comptype(ft), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = ARRAY_comptype($subst_fieldtype(ft, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:396.1-396.123
  def $subst_comptype{`t_1*` : valtype*, `t_2*` : valtype*, `tv*` : typevar*, `tu*` : typeuse*}(`FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = `FUNC%->%`_comptype(`%`_resulttype($subst_valtype(t_1, tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{t_1 <- `t_1*`}), `%`_resulttype($subst_valtype(t_2, tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{t_2 <- `t_2*`}))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:352.1-352.112
def $subst_subtype(subtype : subtype, typevar*, typeuse*) : subtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:398.1-399.74
  def $subst_subtype{`final?` : final?, `tu'*` : typeuse*, ct : comptype, `tv*` : typevar*, `tu*` : typeuse*}(SUB_subtype(final?{final <- `final?`}, tu'*{tu' <- `tu'*`}, ct), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = SUB_subtype(final?{final <- `final?`}, $subst_typeuse(tu', tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{tu' <- `tu'*`}, $subst_comptype(ct, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:353.1-353.112
def $subst_rectype(rectype : rectype, typevar*, typeuse*) : rectype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:407.1-408.45
  def $subst_rectype{`st*` : subtype*, `tv*` : typevar*, `tu*` : typeuse*, `tv'*` : typevar*, `tu'*` : typeuse*}(REC_rectype(`%`_list(st*{st <- `st*`})), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = REC_rectype(`%`_list($subst_subtype(st, tv'*{tv' <- `tv'*`}, tu'*{tu' <- `tu'*`})*{st <- `st*`}))
    -- if ((tv'*{tv' <- `tv'*`}, tu'*{tu' <- `tu'*`}) = $minus_recs(tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:354.1-354.112
def $subst_deftype(deftype : deftype, typevar*, typeuse*) : deftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:413.1-413.80
  def $subst_deftype{qt : rectype, i : n, `tv*` : typevar*, `tu*` : typeuse*}(_DEF_deftype(qt, i), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = _DEF_deftype($subst_rectype(qt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}), i)
}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_addrtype(addrtype : addrtype, typevar*, typeuse*) : addrtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_addrtype{at : addrtype, `tv*` : typevar*, `tu*` : typeuse*}(at, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = at

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_tagtype(tagtype : tagtype, typevar*, typeuse*) : tagtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_tagtype{tu' : typeuse, `tv*` : typevar*, `tu*` : typeuse*}(tu', tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = $subst_typeuse(tu', tv*{tv <- `tv*`}, tu*{tu <- `tu*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_globaltype(globaltype : globaltype, typevar*, typeuse*) : globaltype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_globaltype{`mut?` : mut?, t : valtype, `tv*` : typevar*, `tu*` : typeuse*}(`%%`_globaltype(mut?{mut <- `mut?`}, t), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = `%%`_globaltype(mut?{mut <- `mut?`}, $subst_valtype(t, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_memtype(memtype : memtype, typevar*, typeuse*) : memtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_memtype{at : addrtype, lim : limits, `tv*` : typevar*, `tu*` : typeuse*}(`%%PAGE`_memtype(at, lim), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = `%%PAGE`_memtype(at, lim)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_tabletype(tabletype : tabletype, typevar*, typeuse*) : tabletype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_tabletype{at : addrtype, lim : limits, rt : reftype, `tv*` : typevar*, `tu*` : typeuse*}(`%%%`_tabletype(at, lim, rt), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = `%%%`_tabletype(at, lim, $subst_reftype(rt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_externtype(externtype : externtype, typevar*, typeuse*) : externtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_externtype{jt : tagtype, `tv*` : typevar*, `tu*` : typeuse*}(TAG_externtype(jt), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = TAG_externtype($subst_tagtype(jt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_externtype{gt : globaltype, `tv*` : typevar*, `tu*` : typeuse*}(GLOBAL_externtype(gt), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = GLOBAL_externtype($subst_globaltype(gt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_externtype{tt : tabletype, `tv*` : typevar*, `tu*` : typeuse*}(TABLE_externtype(tt), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = TABLE_externtype($subst_tabletype(tt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_externtype{mt : memtype, `tv*` : typevar*, `tu*` : typeuse*}(MEM_externtype(mt), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = MEM_externtype($subst_memtype(mt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}))
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_externtype{dt : deftype, `tv*` : typevar*, `tu*` : typeuse*}(FUNC_externtype((dt : deftype <: typeuse)), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = FUNC_externtype(($subst_deftype(dt, tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) : deftype <: typeuse))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_moduletype(moduletype : moduletype, typevar*, typeuse*) : moduletype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_moduletype{`xt_1*` : externtype*, `xt_2*` : externtype*, `tv*` : typevar*, `tu*` : typeuse*}(`%->%`_moduletype(xt_1*{xt_1 <- `xt_1*`}, xt_2*{xt_2 <- `xt_2*`}), tv*{tv <- `tv*`}, tu*{tu <- `tu*`}) = `%->%`_moduletype($subst_externtype(xt_1, tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{xt_1 <- `xt_1*`}, $subst_externtype(xt_2, tv*{tv <- `tv*`}, tu*{tu <- `tu*`})*{xt_2 <- `xt_2*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_all_valtype(valtype : valtype, typeuse*) : valtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_all_valtype{t : valtype, `tu*` : typeuse*, n : n, `i*` : nat*}(t, tu^n{tu <- `tu*`}) = $subst_valtype(t, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_all_reftype(reftype : reftype, typeuse*) : reftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_all_reftype{rt : reftype, `tu*` : typeuse*, n : n, `i*` : nat*}(rt, tu^n{tu <- `tu*`}) = $subst_reftype(rt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_all_deftype(deftype : deftype, typeuse*) : deftype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_all_deftype{dt : deftype, `tu*` : typeuse*, n : n, `i*` : nat*}(dt, tu^n{tu <- `tu*`}) = $subst_deftype(dt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_all_tagtype(tagtype : tagtype, typeuse*) : tagtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_all_tagtype{jt : tagtype, `tu*` : typeuse*, n : n, `i*` : nat*}(jt, tu^n{tu <- `tu*`}) = $subst_tagtype(jt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_all_globaltype(globaltype : globaltype, typeuse*) : globaltype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_all_globaltype{gt : globaltype, `tu*` : typeuse*, n : n, `i*` : nat*}(gt, tu^n{tu <- `tu*`}) = $subst_globaltype(gt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_all_memtype(memtype : memtype, typeuse*) : memtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_all_memtype{mt : memtype, `tu*` : typeuse*, n : n, `i*` : nat*}(mt, tu^n{tu <- `tu*`}) = $subst_memtype(mt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_all_tabletype(tabletype : tabletype, typeuse*) : tabletype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_all_tabletype{tt : tabletype, `tu*` : typeuse*, n : n, `i*` : nat*}(tt, tu^n{tu <- `tu*`}) = $subst_tabletype(tt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_all_externtype(externtype : externtype, typeuse*) : externtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_all_externtype{xt : externtype, `tu*` : typeuse*, n : n, `i*` : nat*}(xt, tu^n{tu <- `tu*`}) = $subst_externtype(xt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $subst_all_moduletype(moduletype : moduletype, typeuse*) : moduletype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $subst_all_moduletype{mmt : moduletype, `tu*` : typeuse*, n : n, `i*` : nat*}(mmt, tu^n{tu <- `tu*`}) = $subst_moduletype(mmt, _IDX_typevar(`%`_typeidx(i))^(i<n){i <- `i*`}, tu^n{tu <- `tu*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
rec {

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:451.1-451.97
def $subst_all_deftypes(deftype*, typeuse*) : deftype*
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:452.1-452.40
  def $subst_all_deftypes{`tu*` : typeuse*}([], tu*{tu <- `tu*`}) = []
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:453.1-453.101
  def $subst_all_deftypes{dt_1 : deftype, `dt*` : deftype*, `tu*` : typeuse*}([dt_1] ++ dt*{dt <- `dt*`}, tu*{tu <- `tu*`}) = [$subst_all_deftype(dt_1, tu*{tu <- `tu*`})] ++ $subst_all_deftypes(dt*{dt <- `dt*`}, tu*{tu <- `tu*`})
}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $rollrt(typeidx : typeidx, rectype : rectype) : rectype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $rollrt{x : idx, rectype : rectype, `subtype*` : subtype*, `i*` : nat*, n : n}(x, rectype) = REC_rectype(`%`_list($subst_subtype(subtype, _IDX_typevar(`%`_typeidx((x!`%`_idx.0 + i)))^(i<n){i <- `i*`}, REC_typeuse(i)^(i<n){i <- `i*`})^n{subtype <- `subtype*`}))
    -- if (rectype = REC_rectype(`%`_list(subtype^n{subtype <- `subtype*`})))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $unrollrt(rectype : rectype) : rectype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $unrollrt{rectype : rectype, `subtype*` : subtype*, `i*` : nat*, n : n}(rectype) = REC_rectype(`%`_list($subst_subtype(subtype, REC_typevar(i)^(i<n){i <- `i*`}, _DEF_typeuse(rectype, i)^(i<n){i <- `i*`})^n{subtype <- `subtype*`}))
    -- if (rectype = REC_rectype(`%`_list(subtype^n{subtype <- `subtype*`})))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $rolldt(typeidx : typeidx, rectype : rectype) : deftype*
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $rolldt{x : idx, rectype : rectype, `subtype*` : subtype*, n : n, `i*` : nat*}(x, rectype) = _DEF_deftype(REC_rectype(`%`_list(subtype^n{subtype <- `subtype*`})), i)^(i<n){i <- `i*`}
    -- if ($rollrt(x, rectype) = REC_rectype(`%`_list(subtype^n{subtype <- `subtype*`})))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $unrolldt(deftype : deftype) : subtype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $unrolldt{rectype : rectype, i : n, `subtype*` : subtype*}(_DEF_deftype(rectype, i)) = subtype*{subtype <- `subtype*`}[i]
    -- if ($unrollrt(rectype) = REC_rectype(`%`_list(subtype*{subtype <- `subtype*`})))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $expanddt(deftype : deftype) : comptype
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $expanddt{deftype : deftype, comptype : comptype, `final?` : final?, `typeuse*` : typeuse*}(deftype) = comptype
    -- if ($unrolldt(deftype) = SUB_subtype(final?{final <- `final?`}, typeuse*{typeuse <- `typeuse*`}, comptype))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_addrtype(numtype : numtype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_addrtype{addrtype : addrtype}((addrtype : addrtype <: numtype)) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_numtype(numtype : numtype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_numtype{numtype : numtype}(numtype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_packtype(packtype : packtype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_packtype{packtype : packtype}(packtype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_lanetype(lanetype : lanetype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_lanetype{numtype : numtype}((numtype : numtype <: lanetype)) = $free_numtype(numtype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_lanetype{packtype : packtype}((packtype : packtype <: lanetype)) = $free_packtype(packtype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_vectype(vectype : vectype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_vectype{vectype : vectype}(vectype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_consttype(consttype : consttype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_consttype{numtype : numtype}((numtype : numtype <: consttype)) = $free_numtype(numtype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_consttype{vectype : vectype}((vectype : vectype <: consttype)) = $free_vectype(vectype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_absheaptype(absheaptype : absheaptype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_absheaptype{absheaptype : absheaptype}(absheaptype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_typevar(typevar : typevar) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_typevar{typeidx : typeidx}(_IDX_typevar(typeidx)) = $free_typeidx(typeidx)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_typevar{n : n}(REC_typevar(n)) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
rec {

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:484.1-484.36
def $free_heaptype(heaptype : heaptype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:532.1-532.65
  def $free_heaptype{absheaptype : absheaptype}((absheaptype : absheaptype <: heaptype)) = $free_absheaptype(absheaptype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:533.1-533.53
  def $free_heaptype{typeuse : typeuse}((typeuse : typeuse <: heaptype)) = $free_typeuse(typeuse)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:485.1-485.34
def $free_reftype(reftype : reftype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:535.1-535.65
  def $free_reftype{`null?` : null?, heaptype : heaptype}(REF_reftype(null?{null <- `null?`}, heaptype)) = $free_heaptype(heaptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:487.1-487.34
def $free_typeuse(typeuse : typeuse) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:529.1-529.52
  def $free_typeuse{typevar : typevar}((typevar : typevar <: typeuse)) = $free_typevar(typevar)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:530.1-530.52
  def $free_typeuse{deftype : deftype}((deftype : deftype <: typeuse)) = $free_deftype(deftype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:488.1-488.34
def $free_valtype(valtype : valtype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:537.1-537.52
  def $free_valtype{numtype : numtype}((numtype : numtype <: valtype)) = $free_numtype(numtype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:538.1-538.52
  def $free_valtype{vectype : vectype}((vectype : vectype <: valtype)) = $free_vectype(vectype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:539.1-539.52
  def $free_valtype{reftype : reftype}((reftype : reftype <: valtype)) = $free_reftype(reftype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:540.1-540.28
  def $free_valtype(BOT_valtype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:490.1-490.40
def $free_resulttype(resulttype : resulttype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:542.1-542.69
  def $free_resulttype{`valtype*` : valtype*}(`%`_resulttype(valtype*{valtype <- `valtype*`})) = $free_list($free_valtype(valtype)*{valtype <- `valtype*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:491.1-491.42
def $free_storagetype(storagetype : storagetype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:544.1-544.56
  def $free_storagetype{valtype : valtype}((valtype : valtype <: storagetype)) = $free_valtype(valtype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:545.1-545.59
  def $free_storagetype{packtype : packtype}((packtype : packtype <: storagetype)) = $free_packtype(packtype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:492.1-492.38
def $free_fieldtype(fieldtype : fieldtype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:547.1-547.71
  def $free_fieldtype{`mut?` : mut?, storagetype : storagetype}(`%%`_fieldtype(mut?{mut <- `mut?`}, storagetype)) = $free_storagetype(storagetype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:493.1-493.36
def $free_comptype(comptype : comptype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:549.1-549.80
  def $free_comptype{`fieldtype*` : fieldtype*}(STRUCT_comptype(`%`_list(fieldtype*{fieldtype <- `fieldtype*`}))) = $free_list($free_fieldtype(fieldtype)*{fieldtype <- `fieldtype*`})
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:550.1-550.65
  def $free_comptype{fieldtype : fieldtype}(ARRAY_comptype(fieldtype)) = $free_fieldtype(fieldtype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:551.1-551.121
  def $free_comptype{resulttype_1 : resulttype, resulttype_2 : resulttype}(`FUNC%->%`_comptype(resulttype_1, resulttype_2)) = $free_resulttype(resulttype_1) +++ $free_resulttype(resulttype_2)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:494.1-494.34
def $free_subtype(subtype : subtype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:553.1-554.66
  def $free_subtype{`final?` : final?, `typeuse*` : typeuse*, comptype : comptype}(SUB_subtype(final?{final <- `final?`}, typeuse*{typeuse <- `typeuse*`}, comptype)) = $free_list($free_typeuse(typeuse)*{typeuse <- `typeuse*`}) +++ $free_comptype(comptype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:495.1-495.34
def $free_rectype(rectype : rectype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:556.1-556.70
  def $free_rectype{`subtype*` : subtype*}(REC_rectype(`%`_list(subtype*{subtype <- `subtype*`}))) = $free_list($free_subtype(subtype)*{subtype <- `subtype*`})

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:523.1-523.34
def $free_deftype(deftype : deftype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec:524.1-524.59
  def $free_deftype{rectype : rectype, n : n}(_DEF_deftype(rectype, n)) = $free_rectype(rectype)
}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_tagtype(tagtype : tagtype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_tagtype{deftype : deftype}((deftype : deftype <: typeuse)) = $free_deftype(deftype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_globaltype(globaltype : globaltype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_globaltype{`mut?` : mut?, valtype : valtype}(`%%`_globaltype(mut?{mut <- `mut?`}, valtype)) = $free_valtype(valtype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_memtype(memtype : memtype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_memtype{addrtype : addrtype, limits : limits}(`%%PAGE`_memtype(addrtype, limits)) = $free_addrtype((addrtype : addrtype <: numtype))

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_tabletype(tabletype : tabletype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_tabletype{addrtype : addrtype, limits : limits, reftype : reftype}(`%%%`_tabletype(addrtype, limits, reftype)) = $free_addrtype((addrtype : addrtype <: numtype)) +++ $free_reftype(reftype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_datatype(datatype : datatype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_datatype(OK_datatype) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_elemtype(elemtype : elemtype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_elemtype{reftype : reftype}(reftype) = $free_reftype(reftype)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_externtype(externtype : externtype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_externtype{tagtype : tagtype}(TAG_externtype(tagtype)) = $free_tagtype(tagtype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_externtype{globaltype : globaltype}(GLOBAL_externtype(globaltype)) = $free_globaltype(globaltype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_externtype{memtype : memtype}(MEM_externtype(memtype)) = $free_memtype(memtype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_externtype{tabletype : tabletype}(TABLE_externtype(tabletype)) = $free_tabletype(tabletype)
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_externtype{typeuse : typeuse}(FUNC_externtype(typeuse)) = $free_typeuse(typeuse)

;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
def $free_moduletype(moduletype : moduletype) : free
  ;; ../../../../specification/wasm-3.0/1.2-syntax.types.spectec
  def $free_moduletype{`externtype_1*` : externtype*, `externtype_2*` : externtype*}(`%->%`_moduletype(externtype_1*{externtype_1 <- `externtype_1*`}, externtype_2*{externtype_2 <- `externtype_2*`})) = $free_list($free_externtype(externtype_1)*{externtype_1 <- `externtype_1*`}) +++ $free_list($free_externtype(externtype_2)*{externtype_2 <- `externtype_2*`})

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax num_(numtype : numtype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax num_{Inn : Inn}((Inn : addrtype <: numtype)) = iN($sizenn((Inn : addrtype <: numtype)))


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax num_{Fnn : Fnn}((Fnn : Fnn <: numtype)) = fN($sizenn((Fnn : Fnn <: numtype)))


;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax pack_{Pnn : Pnn}(Pnn) = iN($psizenn(Pnn))

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax lane_(lanetype : lanetype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax lane_{numtype : numtype}((numtype : numtype <: lanetype)) = num_(numtype)


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax lane_{packtype : packtype}((packtype : packtype <: lanetype)) = pack_(packtype)


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax lane_{Jnn : Jnn}((Jnn : Jnn <: lanetype)) = iN($lsize((Jnn : Jnn <: lanetype)))


;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vec_{Vnn : Vnn}(Vnn) = vN($vsize(Vnn))

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax lit_(storagetype : storagetype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax lit_{numtype : numtype}((numtype : numtype <: storagetype)) = num_(numtype)


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax lit_{vectype : vectype}((vectype : vectype <: storagetype)) = vec_(vectype)


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax lit_{packtype : packtype}((packtype : packtype <: storagetype)) = pack_(packtype)


;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax sz = 
  | `%`{i : nat}(i : nat)
    -- if ((((i = 8) \/ (i = 16)) \/ (i = 32)) \/ (i = 64))

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax sx = 
  | U
  | S

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax unop_(numtype : numtype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax unop_{Inn : Inn}((Inn : addrtype <: numtype)) = 
  | CLZ
  | CTZ
  | POPCNT
  | EXTEND{sz : sz}(sz : sz)
    -- if (sz!`%`_sz.0 < $sizenn((Inn : addrtype <: numtype)))


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax unop_{Fnn : Fnn}((Fnn : Fnn <: numtype)) = 
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST


;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax binop_(numtype : numtype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax binop_{Inn : Inn}((Inn : addrtype <: numtype)) = 
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


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax binop_{Fnn : Fnn}((Fnn : Fnn <: numtype)) = 
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN


;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax testop_{Inn : Inn}((Inn : addrtype <: numtype)) = 
  | EQZ

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax relop_(numtype : numtype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax relop_{Inn : Inn}((Inn : addrtype <: numtype)) = 
  | EQ
  | NE
  | LT{sx : sx}(sx : sx)
  | GT{sx : sx}(sx : sx)
  | LE{sx : sx}(sx : sx)
  | GE{sx : sx}(sx : sx)


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax relop_{Fnn : Fnn}((Fnn : Fnn <: numtype)) = 
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE


;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax cvtop__(numtype_1 : numtype, numtype_2 : numtype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax cvtop__{Inn_1 : Inn, Inn_2 : Inn}((Inn_1 : addrtype <: numtype), (Inn_2 : addrtype <: numtype)) = 
  | EXTEND{sx : sx}(sx : sx)
    -- if ($sizenn1((Inn_1 : addrtype <: numtype)) < $sizenn2((Inn_2 : addrtype <: numtype)))
  | WRAP
    -- if ($sizenn1((Inn_1 : addrtype <: numtype)) > $sizenn2((Inn_2 : addrtype <: numtype)))


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax cvtop__{Inn_1 : Inn, Fnn_2 : Fnn}((Inn_1 : addrtype <: numtype), (Fnn_2 : Fnn <: numtype)) = 
  | CONVERT{sx : sx}(sx : sx)
  | REINTERPRET
    -- if ($sizenn1((Inn_1 : addrtype <: numtype)) = $sizenn2((Fnn_2 : Fnn <: numtype)))


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax cvtop__{Fnn_1 : Fnn, Inn_2 : Inn}((Fnn_1 : Fnn <: numtype), (Inn_2 : addrtype <: numtype)) = 
  | TRUNC{sx : sx}(sx : sx)
  | TRUNC_SAT{sx : sx}(sx : sx)
  | REINTERPRET
    -- if ($sizenn1((Fnn_1 : Fnn <: numtype)) = $sizenn2((Inn_2 : addrtype <: numtype)))


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax cvtop__{Fnn_1 : Fnn, Fnn_2 : Fnn}((Fnn_1 : Fnn <: numtype), (Fnn_2 : Fnn <: numtype)) = 
  | PROMOTE
    -- if ($sizenn1((Fnn_1 : Fnn <: numtype)) < $sizenn2((Fnn_2 : Fnn <: numtype)))
  | DEMOTE
    -- if ($sizenn1((Fnn_1 : Fnn <: numtype)) > $sizenn2((Fnn_2 : Fnn <: numtype)))


;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax dim = 
  | `%`{i : nat}(i : nat)
    -- if (((((i = 1) \/ (i = 2)) \/ (i = 4)) \/ (i = 8)) \/ (i = 16))

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax shape = 
  | `%X%`{lanetype : lanetype, dim : dim}(lanetype : lanetype, dim : dim)
    -- if (($lsize(lanetype) * dim!`%`_dim.0) = 128)

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
def $dim(shape : shape) : dim
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  def $dim{Lnn : Lnn, N : N}(`%X%`_shape(Lnn, `%`_dim(N))) = `%`_dim(N)

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
def $lanetype(shape : shape) : lanetype
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  def $lanetype{Lnn : Lnn, N : N}(`%X%`_shape(Lnn, `%`_dim(N))) = Lnn

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
def $unpackshape(shape : shape) : numtype
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  def $unpackshape{Lnn : Lnn, N : N}(`%X%`_shape(Lnn, `%`_dim(N))) = $lunpack(Lnn)

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax ishape = 
  | `%`{shape : shape, Jnn : Jnn}(shape : shape)
    -- if ($lanetype(shape) = (Jnn : Jnn <: lanetype))

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax bshape = 
  | `%`{shape : shape}(shape : shape)
    -- if ($lanetype(shape) = I8_lanetype)

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax zero = 
  | ZERO

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax half = 
  | LOW
  | HIGH

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vvunop = 
  | NOT

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vvbinop = 
  | AND
  | ANDNOT
  | OR
  | XOR

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vvternop = 
  | BITSELECT

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vvtestop = 
  | ANY_TRUE

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vunop_(shape : shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax vunop_{Jnn : Jnn, M : M}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))) = 
  | ABS
  | NEG
  | POPCNT
    -- if ($lsizenn((Jnn : Jnn <: lanetype)) = 8)


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax vunop_{Fnn : Fnn, M : M}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))) = 
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST


;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vbinop_(shape : shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
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


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
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


;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vternop_(shape : shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax vternop_{Jnn : Jnn, M : M}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))) = 
  | RELAXED_LANESELECT


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax vternop_{Fnn : Fnn, M : M}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))) = 
  | RELAXED_MADD
  | RELAXED_NMADD


;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vtestop_{Jnn : Jnn, M : M}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))) = 
  | ALL_TRUE

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vrelop_(shape : shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
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


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax vrelop_{Fnn : Fnn, M : M}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))) = 
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE


;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vshiftop_{Jnn : Jnn, M : M}(`%`_ishape(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)))) = 
  | SHL
  | SHR{sx : sx}(sx : sx)

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vswizzlop_{M : M}(`%`_bshape(`%X%`_shape(I8_lanetype, `%`_dim(M)))) = 
  | SWIZZLE
  | RELAXED_SWIZZLE

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vextunop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%`_ishape(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))), `%`_ishape(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)))) = 
  | EXTADD_PAIRWISE{sx : sx}(sx : sx)
    -- if ((16 <= (2 * $lsizenn1((Jnn_1 : Jnn <: lanetype)))) /\ (((2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))) = $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) <= 32)))

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vextbinop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%`_ishape(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))), `%`_ishape(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)))) = 
  | EXTMUL{half : half, sx : sx}(half : half, sx : sx)
    -- if (((2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))) = $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) >= 16))
  | `DOTS`
    -- if (((2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))) = $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = 32))
  | `RELAXED_DOTS`
    -- if (((2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))) = $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = 16))

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vextternop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%`_ishape(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))), `%`_ishape(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)))) = 
  | `RELAXED_DOT_ADDS`
    -- if (((4 * $lsizenn1((Jnn_1 : Jnn <: lanetype))) = $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = 32))

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vcvtop__(shape_1 : shape, shape_2 : shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax vcvtop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))) = 
  | EXTEND{half : half, sx : sx}(half : half, sx : sx)
    -- if ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = (2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))))


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax vcvtop__{Jnn_1 : Jnn, M_1 : M, Fnn_2 : Fnn, M_2 : M}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2))) = 
  | CONVERT{`half?` : half?, sx : sx}(half?{half <- `half?`} : half?, sx : sx)
    -- if (((($sizenn2((Fnn_2 : Fnn <: numtype)) = $lsizenn1((Jnn_1 : Jnn <: lanetype))) /\ ($lsizenn1((Jnn_1 : Jnn <: lanetype)) = 32)) /\ (half?{half <- `half?`} = ?())) \/ (($sizenn2((Fnn_2 : Fnn <: numtype)) = (2 * $lsizenn1((Jnn_1 : Jnn <: lanetype)))) /\ (half?{half <- `half?`} = ?(LOW_half))))


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax vcvtop__{Fnn_1 : Fnn, M_1 : M, Jnn_2 : Jnn, M_2 : M}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))) = 
  | TRUNC_SAT{sx : sx, `zero?` : zero?}(sx : sx, zero?{zero <- `zero?`} : zero?)
    -- if (((($sizenn1((Fnn_1 : Fnn <: numtype)) = $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = 32)) /\ (zero?{zero <- `zero?`} = ?())) \/ (($sizenn1((Fnn_1 : Fnn <: numtype)) = (2 * $lsizenn2((Jnn_2 : Jnn <: lanetype)))) /\ (zero?{zero <- `zero?`} = ?(ZERO_zero))))
  | RELAXED_TRUNC{sx : sx, `zero?` : zero?}(sx : sx, zero?{zero <- `zero?`} : zero?)
    -- if (((($sizenn1((Fnn_1 : Fnn <: numtype)) = $lsizenn2((Jnn_2 : Jnn <: lanetype))) /\ ($lsizenn2((Jnn_2 : Jnn <: lanetype)) = 32)) /\ (zero?{zero <- `zero?`} = ?())) \/ (($sizenn1((Fnn_1 : Fnn <: numtype)) = (2 * $lsizenn2((Jnn_2 : Jnn <: lanetype)))) /\ (zero?{zero <- `zero?`} = ?(ZERO_zero))))


  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  syntax vcvtop__{Fnn_1 : Fnn, M_1 : M, Fnn_2 : Fnn, M_2 : M}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2))) = 
  | DEMOTE{zero : zero}(zero : zero)
    -- if ($sizenn1((Fnn_1 : Fnn <: numtype)) = (2 * $sizenn2((Fnn_2 : Fnn <: numtype))))
  | `PROMOTELOW`
    -- if ((2 * $sizenn1((Fnn_1 : Fnn <: numtype))) = $sizenn2((Fnn_2 : Fnn <: numtype)))


;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax memarg = 
{
  ALIGN{u32 : u32} u32,
  OFFSET{u64 : u64} u64
}

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax loadop_{Inn : Inn}((Inn : addrtype <: numtype)) = 
  | `%_%`{sz : sz, sx : sx}(sz : sz, sx : sx)
    -- if (sz!`%`_sz.0 < $sizenn((Inn : addrtype <: numtype)))

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax storeop_{Inn : Inn}((Inn : addrtype <: numtype)) = 
  | `%`{sz : sz}(sz : sz)
    -- if (sz!`%`_sz.0 < $sizenn((Inn : addrtype <: numtype)))

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax vloadop_{vectype : vectype}(vectype) = 
  | `SHAPE%X%_%`{sz : sz, M : M, sx : sx}(sz : sz, M : M, sx : sx)
    -- if (((sz!`%`_sz.0 * M) : nat <:> rat) = (($vsize(vectype) : nat <:> rat) / (2 : nat <:> rat)))
  | SPLAT{sz : sz}(sz : sz)
  | ZERO{sz : sz}(sz : sz)
    -- if (sz!`%`_sz.0 >= 32)

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax blocktype = 
  | _RESULT{`valtype?` : valtype?}(valtype?{valtype <- `valtype?`} : valtype?)
  | _IDX{typeidx : typeidx}(typeidx : typeidx)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax addr = nat

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax arrayaddr = addr

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax exnaddr = addr

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax funcaddr = addr

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax hostaddr = addr

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax structaddr = addr

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
rec {

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:35.1-42.23
syntax addrref = 
  | REF.I31_NUM{u31 : u31}(u31 : u31)
  | REF.STRUCT_ADDR{structaddr : structaddr}(structaddr : structaddr)
  | REF.ARRAY_ADDR{arrayaddr : arrayaddr}(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR{funcaddr : funcaddr}(funcaddr : funcaddr)
  | REF.EXN_ADDR{exnaddr : exnaddr}(exnaddr : exnaddr)
  | REF.HOST_ADDR{hostaddr : hostaddr}(hostaddr : hostaddr)
  | REF.EXTERN{addrref : addrref}(addrref : addrref)
}

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax catch = 
  | CATCH{tagidx : tagidx, labelidx : labelidx}(tagidx : tagidx, labelidx : labelidx)
  | CATCH_REF{tagidx : tagidx, labelidx : labelidx}(tagidx : tagidx, labelidx : labelidx)
  | CATCH_ALL{labelidx : labelidx}(labelidx : labelidx)
  | CATCH_ALL_REF{labelidx : labelidx}(labelidx : labelidx)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax dataaddr = addr

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax elemaddr = addr

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax globaladdr = addr

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax memaddr = addr

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax tableaddr = addr

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax tagaddr = addr

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax externaddr = 
  | TAG{tagaddr : tagaddr}(tagaddr : tagaddr)
  | GLOBAL{globaladdr : globaladdr}(globaladdr : globaladdr)
  | MEM{memaddr : memaddr}(memaddr : memaddr)
  | TABLE{tableaddr : tableaddr}(tableaddr : tableaddr)
  | FUNC{funcaddr : funcaddr}(funcaddr : funcaddr)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax exportinst = 
{
  NAME{name : name} name,
  ADDR{externaddr : externaddr} externaddr
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax moduleinst = 
{
  TYPES{`deftype*` : deftype*} deftype*,
  TAGS{`tagaddr*` : tagaddr*} tagaddr*,
  GLOBALS{`globaladdr*` : globaladdr*} globaladdr*,
  MEMS{`memaddr*` : memaddr*} memaddr*,
  TABLES{`tableaddr*` : tableaddr*} tableaddr*,
  FUNCS{`funcaddr*` : funcaddr*} funcaddr*,
  DATAS{`dataaddr*` : dataaddr*} dataaddr*,
  ELEMS{`elemaddr*` : elemaddr*} elemaddr*,
  EXPORTS{`exportinst*` : exportinst*} exportinst*
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
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

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax frame = 
{
  LOCALS{`val?*` : val?*} val?*,
  MODULE{moduleinst : moduleinst} moduleinst
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
rec {

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:136.1-142.9
syntax instr = 
  | NOP
  | UNREACHABLE
  | DROP
  | SELECT{`valtype*?` : valtype*?}(valtype*{valtype <- `valtype*`}?{`valtype*` <- `valtype*?`} : valtype*?)
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
  | STORE{numtype : numtype, `storeop_?` : storeop_(numtype)?, memidx : memidx, memarg : memarg}(numtype : numtype, storeop_?{storeop_ <- `storeop_?`} : storeop_(numtype)?, memidx : memidx, memarg : memarg)
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
  | VSWIZZLOP{bshape : bshape, vswizzlop_ : vswizzlop_(bshape)}(bshape : bshape, vswizzlop_ : vswizzlop_(bshape))
  | VSHUFFLE{bshape : bshape, `laneidx*` : laneidx*}(bshape : bshape, laneidx*{laneidx <- `laneidx*`} : laneidx*)
    -- if (`%`_dim(|laneidx*{laneidx <- `laneidx*`}|) = $dim(bshape!`%`_bshape.0))
  | VEXTUNOP{ishape_1 : ishape, ishape_2 : ishape, vextunop__ : vextunop__(ishape_2, ishape_1)}(ishape_1 : ishape, ishape_2 : ishape, vextunop__ : vextunop__(ishape_2, ishape_1))
  | VEXTBINOP{ishape_1 : ishape, ishape_2 : ishape, vextbinop__ : vextbinop__(ishape_2, ishape_1)}(ishape_1 : ishape, ishape_2 : ishape, vextbinop__ : vextbinop__(ishape_2, ishape_1))
  | VEXTTERNOP{ishape_1 : ishape, ishape_2 : ishape, vextternop__ : vextternop__(ishape_2, ishape_1)}(ishape_1 : ishape, ishape_2 : ishape, vextternop__ : vextternop__(ishape_2, ishape_1))
  | VNARROW{ishape_1 : ishape, ishape_2 : ishape, sx : sx}(ishape_1 : ishape, ishape_2 : ishape, sx : sx)
    -- if (($lsize($lanetype(ishape_2!`%`_ishape.0)) = (2 * $lsize($lanetype(ishape_1!`%`_ishape.0)))) /\ ((2 * $lsize($lanetype(ishape_1!`%`_ishape.0))) <= 32))
  | VCVTOP{shape_1 : shape, shape_2 : shape, vcvtop__ : vcvtop__(shape_2, shape_1)}(shape_1 : shape, shape_2 : shape, vcvtop__ : vcvtop__(shape_2, shape_1))
  | VSPLAT{shape : shape}(shape : shape)
  | VEXTRACT_LANE{shape : shape, `sx?` : sx?, laneidx : laneidx}(shape : shape, sx?{sx <- `sx?`} : sx?, laneidx : laneidx)
    -- if ((sx?{sx <- `sx?`} = ?()) <=> ($lanetype(shape) <- [I32_lanetype I64_lanetype F32_lanetype F64_lanetype]))
  | VREPLACE_LANE{shape : shape, laneidx : laneidx}(shape : shape, laneidx : laneidx)
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

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
syntax expr = instr*

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
def $memarg0 : memarg
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  def $memarg0 = {ALIGN `%`_u32(0), OFFSET `%`_u64(0)}

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
def $const(consttype : consttype, lit_ : lit_((consttype : consttype <: storagetype))) : instr
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  def $const{numtype : numtype, c : lit_((numtype : numtype <: storagetype))}((numtype : numtype <: consttype), c) = CONST_instr(numtype, c)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  def $const{vectype : vectype, c : lit_((vectype : vectype <: storagetype))}((vectype : vectype <: consttype), c) = VCONST_instr(vectype, c)

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
def $free_shape(shape : shape) : free
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  def $free_shape{lanetype : lanetype, dim : dim}(`%X%`_shape(lanetype, dim)) = $free_lanetype(lanetype)

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
def $free_blocktype(blocktype : blocktype) : free
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  def $free_blocktype{`valtype?` : valtype?}(_RESULT_blocktype(valtype?{valtype <- `valtype?`})) = $free_opt($free_valtype(valtype)?{valtype <- `valtype?`})
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  def $free_blocktype{typeidx : typeidx}(_IDX_blocktype(typeidx)) = $free_typeidx(typeidx)

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
rec {

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:572.1-572.44
def $shift_labelidxs(labelidx*) : labelidx*
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:573.1-573.32
  def $shift_labelidxs([]) = []
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:574.1-574.66
  def $shift_labelidxs{`labelidx'*` : labelidx*}([`%`_labelidx(0)] ++ labelidx'*{labelidx' <- `labelidx'*`}) = $shift_labelidxs(labelidx'*{labelidx' <- `labelidx'*`})
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:575.1-575.91
  def $shift_labelidxs{labelidx : labelidx, `labelidx'*` : labelidx*}([labelidx] ++ labelidx'*{labelidx' <- `labelidx'*`}) = [`%`_labelidx((((labelidx!`%`_labelidx.0 : nat <:> int) - (1 : nat <:> int)) : int <:> nat))] ++ $shift_labelidxs(labelidx'*{labelidx' <- `labelidx'*`})
}

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
rec {

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:417.1-417.30
def $free_instr(instr : instr) : free
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:428.1-428.26
  def $free_instr(NOP_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:429.1-429.34
  def $free_instr(UNREACHABLE_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:430.1-430.27
  def $free_instr(DROP_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:431.1-431.86
  def $free_instr{`valtype*?` : valtype*?}(SELECT_instr(valtype*{valtype <- `valtype*`}?{`valtype*` <- `valtype*?`})) = $free_opt($free_list($free_valtype(valtype)*{valtype <- `valtype*`})?{`valtype*` <- `valtype*?`})
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:433.1-433.92
  def $free_instr{blocktype : blocktype, `instr*` : instr*}(BLOCK_instr(blocktype, instr*{instr <- `instr*`})) = $free_blocktype(blocktype) +++ $free_block(instr*{instr <- `instr*`})
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:434.1-434.91
  def $free_instr{blocktype : blocktype, `instr*` : instr*}(LOOP_instr(blocktype, instr*{instr <- `instr*`})) = $free_blocktype(blocktype) +++ $free_block(instr*{instr <- `instr*`})
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:435.1-436.79
  def $free_instr{blocktype : blocktype, `instr_1*` : instr*, `instr_2*` : instr*}(`IF%%ELSE%`_instr(blocktype, instr_1*{instr_1 <- `instr_1*`}, instr_2*{instr_2 <- `instr_2*`})) = $free_blocktype(blocktype) +++ $free_block(instr_1*{instr_1 <- `instr_1*`}) +++ $free_block(instr_2*{instr_2 <- `instr_2*`})
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:438.1-438.56
  def $free_instr{labelidx : labelidx}(BR_instr(labelidx)) = $free_labelidx(labelidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:439.1-439.59
  def $free_instr{labelidx : labelidx}(BR_IF_instr(labelidx)) = $free_labelidx(labelidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:440.1-441.69
  def $free_instr{`labelidx*` : labelidx*, labelidx' : labelidx}(BR_TABLE_instr(labelidx*{labelidx <- `labelidx*`}, labelidx')) = $free_list($free_labelidx(labelidx)*{labelidx <- `labelidx*`}) +++ $free_labelidx(labelidx')
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:442.1-442.64
  def $free_instr{labelidx : labelidx}(BR_ON_NULL_instr(labelidx)) = $free_labelidx(labelidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:443.1-443.68
  def $free_instr{labelidx : labelidx}(BR_ON_NON_NULL_instr(labelidx)) = $free_labelidx(labelidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:444.1-445.83
  def $free_instr{labelidx : labelidx, reftype_1 : reftype, reftype_2 : reftype}(BR_ON_CAST_instr(labelidx, reftype_1, reftype_2)) = $free_labelidx(labelidx) +++ $free_reftype(reftype_1) +++ $free_reftype(reftype_2)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:446.1-447.83
  def $free_instr{labelidx : labelidx, reftype_1 : reftype, reftype_2 : reftype}(BR_ON_CAST_FAIL_instr(labelidx, reftype_1, reftype_2)) = $free_labelidx(labelidx) +++ $free_reftype(reftype_1) +++ $free_reftype(reftype_2)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:449.1-449.55
  def $free_instr{funcidx : funcidx}(CALL_instr(funcidx)) = $free_funcidx(funcidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:450.1-450.59
  def $free_instr{typeuse : typeuse}(CALL_REF_instr(typeuse)) = $free_typeuse(typeuse)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:451.1-452.53
  def $free_instr{tableidx : tableidx, typeuse : typeuse}(CALL_INDIRECT_instr(tableidx, typeuse)) = $free_tableidx(tableidx) +++ $free_typeuse(typeuse)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:453.1-453.29
  def $free_instr(RETURN_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:454.1-454.62
  def $free_instr{funcidx : funcidx}(RETURN_CALL_instr(funcidx)) = $free_funcidx(funcidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:455.1-455.66
  def $free_instr{typeuse : typeuse}(RETURN_CALL_REF_instr(typeuse)) = $free_typeuse(typeuse)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:456.1-457.53
  def $free_instr{tableidx : tableidx, typeuse : typeuse}(RETURN_CALL_INDIRECT_instr(tableidx, typeuse)) = $free_tableidx(tableidx) +++ $free_typeuse(typeuse)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:459.1-459.63
  def $free_instr{numtype : numtype, numlit : num_(numtype)}(CONST_instr(numtype, numlit)) = $free_numtype(numtype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:460.1-460.60
  def $free_instr{numtype : numtype, unop : unop_(numtype)}(UNOP_instr(numtype, unop)) = $free_numtype(numtype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:461.1-461.62
  def $free_instr{numtype : numtype, binop : binop_(numtype)}(BINOP_instr(numtype, binop)) = $free_numtype(numtype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:462.1-462.64
  def $free_instr{numtype : numtype, testop : testop_(numtype)}(TESTOP_instr(numtype, testop)) = $free_numtype(numtype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:463.1-463.62
  def $free_instr{numtype : numtype, relop : relop_(numtype)}(RELOP_instr(numtype, relop)) = $free_numtype(numtype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:464.1-465.55
  def $free_instr{numtype_1 : numtype, numtype_2 : numtype, cvtop : cvtop__(numtype_2, numtype_1)}(CVTOP_instr(numtype_1, numtype_2, cvtop)) = $free_numtype(numtype_1) +++ $free_numtype(numtype_2)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:467.1-467.64
  def $free_instr{vectype : vectype, veclit : vec_(vectype)}(VCONST_instr(vectype, veclit)) = $free_vectype(vectype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:468.1-468.64
  def $free_instr{vectype : vectype, vvunop : vvunop}(VVUNOP_instr(vectype, vvunop)) = $free_vectype(vectype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:469.1-469.66
  def $free_instr{vectype : vectype, vvbinop : vvbinop}(VVBINOP_instr(vectype, vvbinop)) = $free_vectype(vectype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:470.1-470.68
  def $free_instr{vectype : vectype, vvternop : vvternop}(VVTERNOP_instr(vectype, vvternop)) = $free_vectype(vectype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:471.1-471.68
  def $free_instr{vectype : vectype, vvtestop : vvtestop}(VVTESTOP_instr(vectype, vvtestop)) = $free_vectype(vectype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:472.1-472.56
  def $free_instr{shape : shape, vunop : vunop_(shape)}(VUNOP_instr(shape, vunop)) = $free_shape(shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:473.1-473.58
  def $free_instr{shape : shape, vbinop : vbinop_(shape)}(VBINOP_instr(shape, vbinop)) = $free_shape(shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:474.1-474.60
  def $free_instr{shape : shape, vternop : vternop_(shape)}(VTERNOP_instr(shape, vternop)) = $free_shape(shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:475.1-475.60
  def $free_instr{shape : shape, vtestop : vtestop_(shape)}(VTESTOP_instr(shape, vtestop)) = $free_shape(shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:476.1-476.58
  def $free_instr{shape : shape, vrelop : vrelop_(shape)}(VRELOP_instr(shape, vrelop)) = $free_shape(shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:477.1-477.64
  def $free_instr{ishape : ishape, vshiftop : vshiftop_(ishape)}(VSHIFTOP_instr(ishape, vshiftop)) = $free_shape(ishape!`%`_ishape.0)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:478.1-478.55
  def $free_instr{ishape : ishape}(VBITMASK_instr(ishape)) = $free_shape(ishape!`%`_ishape.0)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:479.1-479.66
  def $free_instr{bshape : bshape, vswizzlop : vswizzlop_(bshape)}(VSWIZZLOP_instr(bshape, vswizzlop)) = $free_shape(bshape!`%`_bshape.0)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:480.1-480.64
  def $free_instr{bshape : bshape, `laneidx*` : laneidx*}(VSHUFFLE_instr(bshape, laneidx*{laneidx <- `laneidx*`})) = $free_shape(bshape!`%`_bshape.0)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:481.1-482.49
  def $free_instr{ishape_1 : ishape, ishape_2 : ishape, vextunop : vextunop__(ishape_2, ishape_1)}(VEXTUNOP_instr(ishape_1, ishape_2, vextunop)) = $free_shape(ishape_1!`%`_ishape.0) +++ $free_shape(ishape_2!`%`_ishape.0)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:483.1-484.49
  def $free_instr{ishape_1 : ishape, ishape_2 : ishape, vextbinop : vextbinop__(ishape_2, ishape_1)}(VEXTBINOP_instr(ishape_1, ishape_2, vextbinop)) = $free_shape(ishape_1!`%`_ishape.0) +++ $free_shape(ishape_2!`%`_ishape.0)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:485.1-486.49
  def $free_instr{ishape_1 : ishape, ishape_2 : ishape, vextternop : vextternop__(ishape_2, ishape_1)}(VEXTTERNOP_instr(ishape_1, ishape_2, vextternop)) = $free_shape(ishape_1!`%`_ishape.0) +++ $free_shape(ishape_2!`%`_ishape.0)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:487.1-488.49
  def $free_instr{ishape_1 : ishape, ishape_2 : ishape, sx : sx}(VNARROW_instr(ishape_1, ishape_2, sx)) = $free_shape(ishape_1!`%`_ishape.0) +++ $free_shape(ishape_2!`%`_ishape.0)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:489.1-490.47
  def $free_instr{shape_1 : shape, shape_2 : shape, vcvtop : vcvtop__(shape_2, shape_1)}(VCVTOP_instr(shape_1, shape_2, vcvtop)) = $free_shape(shape_1) +++ $free_shape(shape_2)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:491.1-491.51
  def $free_instr{shape : shape}(VSPLAT_instr(shape)) = $free_shape(shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:492.1-492.70
  def $free_instr{shape : shape, `sx?` : sx?, laneidx : laneidx}(VEXTRACT_LANE_instr(shape, sx?{sx <- `sx?`}, laneidx)) = $free_shape(shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:493.1-493.66
  def $free_instr{shape : shape, laneidx : laneidx}(VREPLACE_LANE_instr(shape, laneidx)) = $free_shape(shape)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:495.1-495.62
  def $free_instr{heaptype : heaptype}(REF.NULL_instr(heaptype)) = $free_heaptype(heaptype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:496.1-496.34
  def $free_instr(REF.IS_NULL_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:497.1-497.38
  def $free_instr(REF.AS_NON_NULL_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:498.1-498.29
  def $free_instr(REF.EQ_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:499.1-499.59
  def $free_instr{reftype : reftype}(REF.TEST_instr(reftype)) = $free_reftype(reftype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:500.1-500.59
  def $free_instr{reftype : reftype}(REF.CAST_instr(reftype)) = $free_reftype(reftype)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:501.1-501.59
  def $free_instr{funcidx : funcidx}(REF.FUNC_instr(funcidx)) = $free_funcidx(funcidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:502.1-502.30
  def $free_instr(REF.I31_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:504.1-504.33
  def $free_instr{sx : sx}(I31.GET_instr(sx)) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:506.1-506.41
  def $free_instr{typeidx : typeidx}(STRUCT.NEW_instr(typeidx)) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:507.1-507.69
  def $free_instr{typeidx : typeidx}(STRUCT.NEW_DEFAULT_instr(typeidx)) = $free_typeidx(typeidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:508.1-508.69
  def $free_instr{`sx?` : sx?, typeidx : typeidx, u32 : u32}(STRUCT.GET_instr(sx?{sx <- `sx?`}, typeidx, u32)) = $free_typeidx(typeidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:509.1-509.65
  def $free_instr{typeidx : typeidx, u32 : u32}(STRUCT.SET_instr(typeidx, u32)) = $free_typeidx(typeidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:511.1-511.60
  def $free_instr{typeidx : typeidx}(ARRAY.NEW_instr(typeidx)) = $free_typeidx(typeidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:512.1-512.68
  def $free_instr{typeidx : typeidx}(ARRAY.NEW_DEFAULT_instr(typeidx)) = $free_typeidx(typeidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:513.1-513.70
  def $free_instr{typeidx : typeidx, u32 : u32}(ARRAY.NEW_FIXED_instr(typeidx, u32)) = $free_typeidx(typeidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:514.1-515.51
  def $free_instr{typeidx : typeidx, dataidx : dataidx}(ARRAY.NEW_DATA_instr(typeidx, dataidx)) = $free_typeidx(typeidx) +++ $free_dataidx(dataidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:516.1-517.51
  def $free_instr{typeidx : typeidx, elemidx : elemidx}(ARRAY.NEW_ELEM_instr(typeidx, elemidx)) = $free_typeidx(typeidx) +++ $free_elemidx(elemidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:518.1-518.64
  def $free_instr{`sx?` : sx?, typeidx : typeidx}(ARRAY.GET_instr(sx?{sx <- `sx?`}, typeidx)) = $free_typeidx(typeidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:519.1-519.60
  def $free_instr{typeidx : typeidx}(ARRAY.SET_instr(typeidx)) = $free_typeidx(typeidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:520.1-520.32
  def $free_instr(ARRAY.LEN_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:521.1-521.61
  def $free_instr{typeidx : typeidx}(ARRAY.FILL_instr(typeidx)) = $free_typeidx(typeidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:522.1-523.55
  def $free_instr{typeidx_1 : typeidx, typeidx_2 : typeidx}(ARRAY.COPY_instr(typeidx_1, typeidx_2)) = $free_typeidx(typeidx_1) +++ $free_typeidx(typeidx_2)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:524.1-525.51
  def $free_instr{typeidx : typeidx, dataidx : dataidx}(ARRAY.INIT_DATA_instr(typeidx, dataidx)) = $free_typeidx(typeidx) +++ $free_dataidx(dataidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:526.1-527.51
  def $free_instr{typeidx : typeidx, elemidx : elemidx}(ARRAY.INIT_ELEM_instr(typeidx, elemidx)) = $free_typeidx(typeidx) +++ $free_elemidx(elemidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:529.1-529.41
  def $free_instr(EXTERN.CONVERT_ANY_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:530.1-530.41
  def $free_instr(ANY.CONVERT_EXTERN_instr) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:532.1-532.63
  def $free_instr{localidx : localidx}(LOCAL.GET_instr(localidx)) = $free_localidx(localidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:533.1-533.63
  def $free_instr{localidx : localidx}(LOCAL.SET_instr(localidx)) = $free_localidx(localidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:534.1-534.63
  def $free_instr{localidx : localidx}(LOCAL.TEE_instr(localidx)) = $free_localidx(localidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:536.1-536.67
  def $free_instr{globalidx : globalidx}(GLOBAL.GET_instr(globalidx)) = $free_globalidx(globalidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:537.1-537.67
  def $free_instr{globalidx : globalidx}(GLOBAL.SET_instr(globalidx)) = $free_globalidx(globalidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:539.1-539.63
  def $free_instr{tableidx : tableidx}(TABLE.GET_instr(tableidx)) = $free_tableidx(tableidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:540.1-540.63
  def $free_instr{tableidx : tableidx}(TABLE.SET_instr(tableidx)) = $free_tableidx(tableidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:541.1-541.64
  def $free_instr{tableidx : tableidx}(TABLE.SIZE_instr(tableidx)) = $free_tableidx(tableidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:542.1-542.64
  def $free_instr{tableidx : tableidx}(TABLE.GROW_instr(tableidx)) = $free_tableidx(tableidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:543.1-543.64
  def $free_instr{tableidx : tableidx}(TABLE.FILL_instr(tableidx)) = $free_tableidx(tableidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:544.1-545.59
  def $free_instr{tableidx_1 : tableidx, tableidx_2 : tableidx}(TABLE.COPY_instr(tableidx_1, tableidx_2)) = $free_tableidx(tableidx_1) +++ $free_tableidx(tableidx_2)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:546.1-547.53
  def $free_instr{tableidx : tableidx, elemidx : elemidx}(TABLE.INIT_instr(tableidx, elemidx)) = $free_tableidx(tableidx) +++ $free_elemidx(elemidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:548.1-548.60
  def $free_instr{elemidx : elemidx}(ELEM.DROP_instr(elemidx)) = $free_elemidx(elemidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:550.1-551.49
  def $free_instr{numtype : numtype, `loadop?` : loadop_(numtype)?, memidx : memidx, memarg : memarg}(LOAD_instr(numtype, loadop?{loadop <- `loadop?`}, memidx, memarg)) = $free_numtype(numtype) +++ $free_memidx(memidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:552.1-553.49
  def $free_instr{numtype : numtype, `storeop?` : storeop_(numtype)?, memidx : memidx, memarg : memarg}(STORE_instr(numtype, storeop?{storeop <- `storeop?`}, memidx, memarg)) = $free_numtype(numtype) +++ $free_memidx(memidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:554.1-555.49
  def $free_instr{vectype : vectype, `vloadop?` : vloadop_(vectype)?, memidx : memidx, memarg : memarg}(VLOAD_instr(vectype, vloadop?{vloadop <- `vloadop?`}, memidx, memarg)) = $free_vectype(vectype) +++ $free_memidx(memidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:556.1-557.49
  def $free_instr{vectype : vectype, sz : sz, memidx : memidx, memarg : memarg, laneidx : laneidx}(VLOAD_LANE_instr(vectype, sz, memidx, memarg, laneidx)) = $free_vectype(vectype) +++ $free_memidx(memidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:558.1-559.49
  def $free_instr{vectype : vectype, memidx : memidx, memarg : memarg}(VSTORE_instr(vectype, memidx, memarg)) = $free_vectype(vectype) +++ $free_memidx(memidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:560.1-561.49
  def $free_instr{vectype : vectype, sz : sz, memidx : memidx, memarg : memarg, laneidx : laneidx}(VSTORE_LANE_instr(vectype, sz, memidx, memarg, laneidx)) = $free_vectype(vectype) +++ $free_memidx(memidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:562.1-562.59
  def $free_instr{memidx : memidx}(MEMORY.SIZE_instr(memidx)) = $free_memidx(memidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:563.1-563.59
  def $free_instr{memidx : memidx}(MEMORY.GROW_instr(memidx)) = $free_memidx(memidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:564.1-564.59
  def $free_instr{memidx : memidx}(MEMORY.FILL_instr(memidx)) = $free_memidx(memidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:565.1-566.51
  def $free_instr{memidx_1 : memidx, memidx_2 : memidx}(MEMORY.COPY_instr(memidx_1, memidx_2)) = $free_memidx(memidx_1) +++ $free_memidx(memidx_2)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:567.1-568.49
  def $free_instr{memidx : memidx, dataidx : dataidx}(MEMORY.INIT_instr(memidx, dataidx)) = $free_memidx(memidx) +++ $free_dataidx(dataidx)
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:569.1-569.60
  def $free_instr{dataidx : dataidx}(DATA.DROP_instr(dataidx)) = $free_dataidx(dataidx)

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:418.1-418.31
def $free_block(instr*) : free
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec:577.1-578.47
  def $free_block{`instr*` : instr*, free : free}(instr*{instr <- `instr*`}) = free[LABELS_free = $shift_labelidxs(free.LABELS_free)]
    -- if (free = $free_list($free_instr(instr)*{instr <- `instr*`}))
}

;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
def $free_expr(expr : expr) : free
  ;; ../../../../specification/wasm-3.0/1.3-syntax.instructions.spectec
  def $free_expr{`instr*` : instr*}(instr*{instr <- `instr*`}) = $free_list($free_instr(instr)*{instr <- `instr*`})

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax elemmode = 
  | ACTIVE{tableidx : tableidx, expr : expr}(tableidx : tableidx, expr : expr)
  | PASSIVE
  | DECLARE

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax datamode = 
  | ACTIVE{memidx : memidx, expr : expr}(memidx : memidx, expr : expr)
  | PASSIVE

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax type = 
  | TYPE{rectype : rectype}(rectype : rectype)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax tag = 
  | TAG{tagtype : tagtype}(tagtype : tagtype)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax global = 
  | GLOBAL{globaltype : globaltype, expr : expr}(globaltype : globaltype, expr : expr)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax mem = 
  | MEMORY{memtype : memtype}(memtype : memtype)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax table = 
  | TABLE{tabletype : tabletype, expr : expr}(tabletype : tabletype, expr : expr)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax data = 
  | DATA{`byte*` : byte*, datamode : datamode}(byte*{byte <- `byte*`} : byte*, datamode : datamode)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax local = 
  | LOCAL{valtype : valtype}(valtype : valtype)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax func = 
  | FUNC{typeidx : typeidx, `local*` : local*, expr : expr}(typeidx : typeidx, local*{local <- `local*`} : local*, expr : expr)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax elem = 
  | ELEM{reftype : reftype, `expr*` : expr*, elemmode : elemmode}(reftype : reftype, expr*{expr <- `expr*`} : expr*, elemmode : elemmode)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax start = 
  | START{funcidx : funcidx}(funcidx : funcidx)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax import = 
  | IMPORT{name : name, externtype : externtype}(name : name, name, externtype : externtype)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax export = 
  | EXPORT{name : name, externidx : externidx}(name : name, externidx : externidx)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
syntax module = 
  | MODULE{`type*` : type*, `import*` : import*, `tag*` : tag*, `global*` : global*, `mem*` : mem*, `table*` : table*, `func*` : func*, `data*` : data*, `elem*` : elem*, `start?` : start?, `export*` : export*}(type*{type <- `type*`} : type*, import*{import <- `import*`} : import*, tag*{tag <- `tag*`} : tag*, global*{global <- `global*`} : global*, mem*{mem <- `mem*`} : mem*, table*{table <- `table*`} : table*, func*{func <- `func*`} : func*, data*{data <- `data*`} : data*, elem*{elem <- `elem*`} : elem*, start?{start <- `start?`} : start?, export*{export <- `export*`} : export*)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_type(type : type) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_type{rectype : rectype}(TYPE_type(rectype)) = $free_rectype(rectype)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_tag(tag : tag) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_tag{tagtype : tagtype}(TAG_tag(tagtype)) = $free_tagtype(tagtype)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_global(global : global) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_global{globaltype : globaltype, expr : expr}(GLOBAL_global(globaltype, expr)) = $free_globaltype(globaltype) +++ $free_expr(expr)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_mem(mem : mem) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_mem{memtype : memtype}(MEMORY_mem(memtype)) = $free_memtype(memtype)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_table(table : table) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_table{tabletype : tabletype, expr : expr}(TABLE_table(tabletype, expr)) = $free_tabletype(tabletype) +++ $free_expr(expr)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_local(local : local) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_local{t : valtype}(LOCAL_local(t)) = $free_valtype(t)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_func(func : func) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_func{typeidx : typeidx, `local*` : local*, expr : expr}(FUNC_func(typeidx, local*{local <- `local*`}, expr)) = $free_typeidx(typeidx) +++ $free_list($free_local(local)*{local <- `local*`}) +++ $free_block(expr)[LOCALS_free = []]

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_datamode(datamode : datamode) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_datamode{memidx : memidx, expr : expr}(ACTIVE_datamode(memidx, expr)) = $free_memidx(memidx) +++ $free_expr(expr)
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_datamode(PASSIVE_datamode) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_data(data : data) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_data{`byte*` : byte*, datamode : datamode}(DATA_data(byte*{byte <- `byte*`}, datamode)) = $free_datamode(datamode)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_elemmode(elemmode : elemmode) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_elemmode{tableidx : tableidx, expr : expr}(ACTIVE_elemmode(tableidx, expr)) = $free_tableidx(tableidx) +++ $free_expr(expr)
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_elemmode(PASSIVE_elemmode) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_elemmode(DECLARE_elemmode) = {TYPES [], FUNCS [], GLOBALS [], TABLES [], MEMS [], ELEMS [], DATAS [], LOCALS [], LABELS []}

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_elem(elem : elem) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_elem{reftype : reftype, `expr*` : expr*, elemmode : elemmode}(ELEM_elem(reftype, expr*{expr <- `expr*`}, elemmode)) = $free_reftype(reftype) +++ $free_list($free_expr(expr)*{expr <- `expr*`}) +++ $free_elemmode(elemmode)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_start(start : start) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_start{funcidx : funcidx}(START_start(funcidx)) = $free_funcidx(funcidx)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_import(import : import) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_import{name_1 : name, name_2 : name, externtype : externtype}(IMPORT_import(name_1, name_2, externtype)) = $free_externtype(externtype)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_export(export : export) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_export{name : name, externidx : externidx}(EXPORT_export(name, externidx)) = $free_externidx(externidx)

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $free_module(module : module) : free
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $free_module{`type*` : type*, `import*` : import*, `tag*` : tag*, `global*` : global*, `mem*` : mem*, `table*` : table*, `func*` : func*, `data*` : data*, `elem*` : elem*, `start?` : start?, `export*` : export*}(MODULE_module(type*{type <- `type*`}, import*{import <- `import*`}, tag*{tag <- `tag*`}, global*{global <- `global*`}, mem*{mem <- `mem*`}, table*{table <- `table*`}, func*{func <- `func*`}, data*{data <- `data*`}, elem*{elem <- `elem*`}, start?{start <- `start?`}, export*{export <- `export*`})) = $free_list($free_type(type)*{type <- `type*`}) +++ $free_list($free_tag(tag)*{tag <- `tag*`}) +++ $free_list($free_global(global)*{global <- `global*`}) +++ $free_list($free_mem(mem)*{mem <- `mem*`}) +++ $free_list($free_table(table)*{table <- `table*`}) +++ $free_list($free_func(func)*{func <- `func*`}) +++ $free_list($free_data(data)*{data <- `data*`}) +++ $free_list($free_elem(elem)*{elem <- `elem*`}) +++ $free_opt($free_start(start)?{start <- `start?`}) +++ $free_list($free_import(import)*{import <- `import*`}) +++ $free_list($free_export(export)*{export <- `export*`})

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $funcidx_module(module : module) : funcidx*
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $funcidx_module{module : module}(module) = $free_module(module).FUNCS_free

;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
def $dataidx_funcs(func*) : dataidx*
  ;; ../../../../specification/wasm-3.0/1.4-syntax.modules.spectec
  def $dataidx_funcs{`func*` : func*}(func*{func <- `func*`}) = $free_list($free_func(func)*{func <- `func*`}).DATAS_free

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
syntax init = 
  | SET
  | UNSET

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
syntax localtype = 
  | `%%`{init : init, valtype : valtype}(init : init, valtype : valtype)

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
syntax instrtype = 
  | `%->_%%`{resulttype : resulttype, `localidx*` : localidx*}(resulttype : resulttype, localidx*{localidx <- `localidx*`} : localidx*, resulttype)

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
syntax context = 
{
  TYPES{`deftype*` : deftype*} deftype*,
  RECS{`subtype*` : subtype*} subtype*,
  TAGS{`tagtype*` : tagtype*} tagtype*,
  GLOBALS{`globaltype*` : globaltype*} globaltype*,
  MEMS{`memtype*` : memtype*} memtype*,
  TABLES{`tabletype*` : tabletype*} tabletype*,
  FUNCS{`deftype*` : deftype*} deftype*,
  DATAS{`datatype*` : datatype*} datatype*,
  ELEMS{`elemtype*` : elemtype*} elemtype*,
  LOCALS{`localtype*` : localtype*} localtype*,
  LABELS{`resulttype*` : resulttype*} resulttype*,
  RETURN{`resulttype?` : resulttype?} resulttype?,
  REFS{`funcidx*` : funcidx*} funcidx*
}

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
rec {

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec:46.1-46.144
def $with_locals(context : context, localidx*, localtype*) : context
  ;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec:48.1-48.34
  def $with_locals{C : context}(C, [], []) = C
  ;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec:49.1-49.90
  def $with_locals{C : context, x_1 : idx, `x*` : idx*, lct_1 : localtype, `lct*` : localtype*}(C, [x_1] ++ x*{x <- `x*`}, [lct_1] ++ lct*{lct <- `lct*`}) = $with_locals(C[LOCALS_context[x_1!`%`_idx.0] = lct_1], x*{x <- `x*`}, lct*{lct <- `lct*`})
}

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
rec {

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec:59.1-59.94
def $clos_deftypes(deftype*) : deftype*
  ;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec:68.1-68.30
  def $clos_deftypes([]) = []
  ;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec:69.1-69.101
  def $clos_deftypes{`dt*` : deftype*, dt_n : deftype, `dt'*` : deftype*}(dt*{dt <- `dt*`} ++ [dt_n]) = dt'*{dt' <- `dt'*`} ++ [$subst_all_deftype(dt_n, (dt' : deftype <: typeuse)*{dt' <- `dt'*`})]
    -- if (dt'*{dt' <- `dt'*`} = $clos_deftypes(dt*{dt <- `dt*`}))
}

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
def $clos_valtype(context : context, valtype : valtype) : valtype
  ;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
  def $clos_valtype{C : context, t : valtype, `dt*` : deftype*}(C, t) = $subst_all_valtype(t, (dt : deftype <: typeuse)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = $clos_deftypes(C.TYPES_context))

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
def $clos_deftype(context : context, deftype : deftype) : deftype
  ;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
  def $clos_deftype{C : context, dt : deftype, `dt'*` : deftype*}(C, dt) = $subst_all_deftype(dt, (dt' : deftype <: typeuse)*{dt' <- `dt'*`})
    -- if (dt'*{dt' <- `dt'*`} = $clos_deftypes(C.TYPES_context))

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
def $clos_tagtype(context : context, tagtype : tagtype) : tagtype
  ;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
  def $clos_tagtype{C : context, jt : tagtype, `dt*` : deftype*}(C, jt) = $subst_all_tagtype(jt, (dt : deftype <: typeuse)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = $clos_deftypes(C.TYPES_context))

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
def $clos_externtype(context : context, externtype : externtype) : externtype
  ;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
  def $clos_externtype{C : context, xt : externtype, `dt*` : deftype*}(C, xt) = $subst_all_externtype(xt, (dt : deftype <: typeuse)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = $clos_deftypes(C.TYPES_context))

;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
def $clos_moduletype(context : context, moduletype : moduletype) : moduletype
  ;; ../../../../specification/wasm-3.0/2.0-validation.contexts.spectec
  def $clos_moduletype{C : context, mmt : moduletype, `dt*` : deftype*}(C, mmt) = $subst_all_moduletype(mmt, (dt : deftype <: typeuse)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = $clos_deftypes(C.TYPES_context))

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
relation Numtype_ok: `%|-%:OK`(context, numtype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule _{C : context, numtype : numtype}:
    `%|-%:OK`(C, numtype)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
relation Vectype_ok: `%|-%:OK`(context, vectype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule _{C : context, vectype : vectype}:
    `%|-%:OK`(C, vectype)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
syntax oktypeidx = 
  | OK{typeidx : typeidx}(typeidx : typeidx)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
syntax oktypeidxnat = 
  | OK{typeidx : typeidx, nat : nat}(typeidx : typeidx, nat : nat)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
relation Packtype_ok: `%|-%:OK`(context, packtype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule _{C : context, packtype : packtype}:
    `%|-%:OK`(C, packtype)

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
relation Packtype_sub: `%|-%<:%`(context, packtype, packtype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule _{C : context, packtype : packtype}:
    `%|-%<:%`(C, packtype, packtype)

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
relation Numtype_sub: `%|-%<:%`(context, numtype, numtype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule _{C : context, numtype : numtype}:
    `%|-%<:%`(C, numtype, numtype)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
relation Expand: `%~~%`(deftype, comptype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule _{deftype : deftype, comptype : comptype}:
    `%~~%`(deftype, comptype)
    -- if ($expanddt(deftype) = comptype)

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
relation Vectype_sub: `%|-%<:%`(context, vectype, vectype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule _{C : context, vectype : vectype}:
    `%|-%<:%`(C, vectype, vectype)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
def $before(typeuse : typeuse, typeidx : typeidx, nat : nat) : bool
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  def $before{deftype : deftype, x : idx, i : nat}((deftype : deftype <: typeuse), x, i) = true
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  def $before{typeidx : typeidx, x : idx, i : nat}(_IDX_typeuse(typeidx), x, i) = (typeidx!`%`_typeidx.0 < x!`%`_idx.0)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  def $before{j : n, x : idx, i : nat}(REC_typeuse(j), x, i) = (j < i)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
def $unrollht(context : context, heaptype : heaptype) : subtype
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  def $unrollht{C : context, deftype : deftype}(C, (deftype : deftype <: heaptype)) = $unrolldt(deftype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  def $unrollht{C : context, typeidx : typeidx}(C, _IDX_heaptype(typeidx)) = $unrolldt(C.TYPES_context[typeidx!`%`_typeidx.0])
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  def $unrollht{C : context, i : n}(C, REC_heaptype(i)) = C.RECS_context[i]

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
rec {

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:9.1-9.92
relation Heaptype_ok: `%|-%:OK`(context, heaptype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:20.1-21.24
  rule abs{C : context, absheaptype : absheaptype}:
    `%|-%:OK`(C, (absheaptype : absheaptype <: heaptype))

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:23.1-25.35
  rule typeuse{C : context, typeuse : typeuse}:
    `%|-%:OK`(C, (typeuse : typeuse <: heaptype))
    -- Typeuse_ok: `%|-%:OK`(C, typeuse)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:10.1-10.91
relation Reftype_ok: `%|-%:OK`(context, reftype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:27.1-29.37
  rule _{C : context, heaptype : heaptype}:
    `%|-%:OK`(C, REF_reftype(NULL_null?{}, heaptype))
    -- Heaptype_ok: `%|-%:OK`(C, heaptype)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:11.1-11.91
relation Valtype_ok: `%|-%:OK`(context, valtype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:31.1-33.35
  rule num{C : context, numtype : numtype}:
    `%|-%:OK`(C, (numtype : numtype <: valtype))
    -- Numtype_ok: `%|-%:OK`(C, numtype)

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:35.1-37.35
  rule vec{C : context, vectype : vectype}:
    `%|-%:OK`(C, (vectype : vectype <: valtype))
    -- Vectype_ok: `%|-%:OK`(C, vectype)

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:39.1-41.35
  rule ref{C : context, reftype : reftype}:
    `%|-%:OK`(C, (reftype : reftype <: valtype))
    -- Reftype_ok: `%|-%:OK`(C, reftype)

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:43.1-44.16
  rule bot{C : context}:
    `%|-%:OK`(C, BOT_valtype)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:12.1-12.94
relation Typeuse_ok: `%|-%:OK`(context, typeuse)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:99.1-101.30
  rule typeidx{C : context, typeidx : typeidx, dt : deftype}:
    `%|-%:OK`(C, _IDX_typeuse(typeidx))
    -- if (C.TYPES_context[typeidx!`%`_typeidx.0] = dt)

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:103.1-105.23
  rule rec{C : context, i : n, st : subtype}:
    `%|-%:OK`(C, REC_typeuse(i))
    -- if (C.RECS_context[i] = st)

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:107.1-109.35
  rule deftype{C : context, deftype : deftype}:
    `%|-%:OK`(C, (deftype : deftype <: typeuse))
    -- Deftype_ok: `%|-%:OK`(C, deftype)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:49.1-49.100
relation Resulttype_ok: `%|-%:OK`(context, resulttype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:52.1-54.32
  rule _{C : context, `t*` : valtype*}:
    `%|-%:OK`(C, `%`_resulttype(t*{t <- `t*`}))
    -- (Valtype_ok: `%|-%:OK`(C, t))*{t <- `t*`}

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:85.1-85.104
relation Fieldtype_ok: `%|-%:OK`(context, fieldtype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:123.1-125.43
  rule _{C : context, storagetype : storagetype}:
    `%|-%:OK`(C, `%%`_fieldtype(MUT_mut?{}, storagetype))
    -- Storagetype_ok: `%|-%:OK`(C, storagetype)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:86.1-86.106
relation Storagetype_ok: `%|-%:OK`(context, storagetype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:115.1-117.35
  rule val{C : context, valtype : valtype}:
    `%|-%:OK`(C, (valtype : valtype <: storagetype))
    -- Valtype_ok: `%|-%:OK`(C, valtype)

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:119.1-121.37
  rule pack{C : context, packtype : packtype}:
    `%|-%:OK`(C, (packtype : packtype <: storagetype))
    -- Packtype_ok: `%|-%:OK`(C, packtype)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:87.1-87.103
relation Comptype_ok: `%|-%:OK`(context, comptype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:128.1-130.42
  rule struct{C : context, `fieldtype*` : fieldtype*}:
    `%|-%:OK`(C, STRUCT_comptype(`%`_list(fieldtype*{fieldtype <- `fieldtype*`})))
    -- (Fieldtype_ok: `%|-%:OK`(C, fieldtype))*{fieldtype <- `fieldtype*`}

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:132.1-134.39
  rule array{C : context, fieldtype : fieldtype}:
    `%|-%:OK`(C, ARRAY_comptype(fieldtype))
    -- Fieldtype_ok: `%|-%:OK`(C, fieldtype)

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:136.1-139.35
  rule func{C : context, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:OK`(C, `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t_1*{t_1 <- `t_1*`}))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t_2*{t_2 <- `t_2*`}))

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:88.1-88.126
relation Subtype_ok: `%|-%:%`(context, subtype, oktypeidx)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:142.1-149.49
  rule _{C : context, `x*` : idx*, comptype : comptype, x_0 : idx, `x'**` : idx**, `comptype'*` : comptype*}:
    `%|-%:%`(C, SUB_subtype(FINAL_final?{}, _IDX_typeuse(x)*{x <- `x*`}, comptype), OK_oktypeidx(x_0))
    -- if (|x*{x <- `x*`}| <= 1)
    -- (if (x!`%`_idx.0 < x_0!`%`_idx.0))*{x <- `x*`}
    -- (if ($unrolldt(C.TYPES_context[x!`%`_idx.0]) = SUB_subtype(?(), _IDX_typeuse(x')*{x' <- `x'*`}, comptype')))*{comptype' <- `comptype'*`, x <- `x*`, `x'*` <- `x'**`}
    -- Comptype_ok: `%|-%:OK`(C, comptype)
    -- (Comptype_sub: `%|-%<:%`(C, comptype, comptype'))*{comptype' <- `comptype'*`}

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:89.1-89.126
relation Rectype_ok: `%|-%:%`(context, rectype, oktypeidx)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:171.1-172.23
  rule empty{C : context, x : idx}:
    `%|-%:%`(C, REC_rectype(`%`_list([])), OK_oktypeidx(x))

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:174.1-177.48
  rule cons{C : context, subtype_1 : subtype, `subtype*` : subtype*, x : idx}:
    `%|-%:%`(C, REC_rectype(`%`_list([subtype_1] ++ subtype*{subtype <- `subtype*`})), OK_oktypeidx(x))
    -- Subtype_ok: `%|-%:%`(C, subtype_1, OK_oktypeidx(x))
    -- Rectype_ok: `%|-%:%`(C, REC_rectype(`%`_list(subtype*{subtype <- `subtype*`})), OK_oktypeidx(`%`_typeidx((x!`%`_idx.0 + 1))))

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:179.1-181.60
  rule _rec2{C : context, `subtype*` : subtype*, x : idx}:
    `%|-%:%`(C, REC_rectype(`%`_list(subtype*{subtype <- `subtype*`})), OK_oktypeidx(x))
    -- Rectype_ok2: `%|-%:%`({TYPES [], RECS subtype*{subtype <- `subtype*`}, TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []} +++ C, REC_rectype(`%`_list(subtype*{subtype <- `subtype*`})), OK_oktypeidxnat(x, 0))

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:90.1-90.126
relation Subtype_ok2: `%|-%:%`(context, subtype, oktypeidxnat)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:161.1-168.49
  rule _{C : context, `typeuse*` : typeuse*, compttype : comptype, x : idx, i : nat, `typeuse'**` : typeuse**, `comptype'*` : comptype*, comptype : comptype}:
    `%|-%:%`(C, SUB_subtype(FINAL_final?{}, typeuse*{typeuse <- `typeuse*`}, compttype), OK_oktypeidxnat(x, i))
    -- if (|typeuse*{typeuse <- `typeuse*`}| <= 1)
    -- (if $before(typeuse, x, i))*{typeuse <- `typeuse*`}
    -- (if ($unrollht(C, (typeuse : typeuse <: heaptype)) = SUB_subtype(?(), typeuse'*{typeuse' <- `typeuse'*`}, comptype')))*{comptype' <- `comptype'*`, typeuse <- `typeuse*`, `typeuse'*` <- `typeuse'**`}
    -- Comptype_ok: `%|-%:OK`(C, comptype)
    -- (Comptype_sub: `%|-%<:%`(C, comptype, comptype'))*{comptype' <- `comptype'*`}

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:91.1-91.126
relation Rectype_ok2: `%|-%:%`(context, rectype, oktypeidxnat)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:183.1-184.24
  rule empty{C : context, x : idx, i : nat}:
    `%|-%:%`(C, REC_rectype(`%`_list([])), OK_oktypeidxnat(x, i))

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:186.1-189.55
  rule cons{C : context, subtype_1 : subtype, `subtype*` : subtype*, x : idx, i : nat}:
    `%|-%:%`(C, REC_rectype(`%`_list([subtype_1] ++ subtype*{subtype <- `subtype*`})), OK_oktypeidxnat(x, i))
    -- Subtype_ok2: `%|-%:%`(C, subtype_1, OK_oktypeidxnat(x, i))
    -- Rectype_ok2: `%|-%:%`(C, REC_rectype(`%`_list(subtype*{subtype <- `subtype*`})), OK_oktypeidxnat(`%`_typeidx((x!`%`_idx.0 + 1)), (i + 1)))

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:92.1-92.102
relation Deftype_ok: `%|-%:OK`(context, deftype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:192.1-196.14
  rule _{C : context, rectype : rectype, i : n, x : idx, `subtype*` : subtype*, n : n}:
    `%|-%:OK`(C, _DEF_deftype(rectype, i))
    -- Rectype_ok: `%|-%:%`(C, rectype, OK_oktypeidx(x))
    -- if (rectype = REC_rectype(`%`_list(subtype^n{subtype <- `subtype*`})))
    -- if (i < n)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:95.1-95.108
relation Comptype_sub: `%|-%<:%`(context, comptype, comptype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:165.1-167.41
  rule struct{C : context, `ft_1*` : fieldtype*, `ft'_1*` : fieldtype*, `ft_2*` : fieldtype*}:
    `%|-%<:%`(C, STRUCT_comptype(`%`_list(ft_1*{ft_1 <- `ft_1*`} ++ ft'_1*{ft'_1 <- `ft'_1*`})), STRUCT_comptype(`%`_list(ft_2*{ft_2 <- `ft_2*`})))
    -- (Fieldtype_sub: `%|-%<:%`(C, ft_1, ft_2))*{ft_1 <- `ft_1*`, ft_2 <- `ft_2*`}

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:169.1-171.38
  rule array{C : context, ft_1 : fieldtype, ft_2 : fieldtype}:
    `%|-%<:%`(C, ARRAY_comptype(ft_1), ARRAY_comptype(ft_2))
    -- Fieldtype_sub: `%|-%<:%`(C, ft_1, ft_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:173.1-176.41
  rule func{C : context, `t_11*` : valtype*, `t_12*` : valtype*, `t_21*` : valtype*, `t_22*` : valtype*}:
    `%|-%<:%`(C, `FUNC%->%`_comptype(`%`_resulttype(t_11*{t_11 <- `t_11*`}), `%`_resulttype(t_12*{t_12 <- `t_12*`})), `FUNC%->%`_comptype(`%`_resulttype(t_21*{t_21 <- `t_21*`}), `%`_resulttype(t_22*{t_22 <- `t_22*`})))
    -- Resulttype_sub: `%|-%<:%`(C, `%`_resulttype(t_21*{t_21 <- `t_21*`}), `%`_resulttype(t_11*{t_11 <- `t_11*`}))
    -- Resulttype_sub: `%|-%<:%`(C, `%`_resulttype(t_12*{t_12 <- `t_12*`}), `%`_resulttype(t_22*{t_22 <- `t_22*`}))

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec:96.1-96.107
relation Deftype_sub: `%|-%<:%`(context, deftype, deftype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:179.1-181.66
  rule refl{C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- if ($clos_deftype(C, deftype_1) = $clos_deftype(C, deftype_2))

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:183.1-186.49
  rule super{C : context, deftype_1 : deftype, deftype_2 : deftype, `final?` : final?, `typeuse*` : typeuse*, ct : comptype, i : nat}:
    `%|-%<:%`(C, deftype_1, deftype_2)
    -- if ($unrolldt(deftype_1) = SUB_subtype(final?{final <- `final?`}, typeuse*{typeuse <- `typeuse*`}, ct))
    -- Heaptype_sub: `%|-%<:%`(C, (typeuse*{typeuse <- `typeuse*`}[i] : typeuse <: heaptype), (deftype_2 : deftype <: heaptype))

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:9.1-9.104
relation Heaptype_sub: `%|-%<:%`(context, heaptype, heaptype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:20.1-21.28
  rule refl{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, heaptype, heaptype)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:23.1-27.48
  rule trans{C : context, heaptype_1 : heaptype, heaptype_2 : heaptype, heaptype' : heaptype}:
    `%|-%<:%`(C, heaptype_1, heaptype_2)
    -- Heaptype_ok: `%|-%:OK`(C, heaptype')
    -- Heaptype_sub: `%|-%<:%`(C, heaptype_1, heaptype')
    -- Heaptype_sub: `%|-%<:%`(C, heaptype', heaptype_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:29.1-30.17
  rule `eq-any`{C : context}:
    `%|-%<:%`(C, EQ_heaptype, ANY_heaptype)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:32.1-33.17
  rule `i31-eq`{C : context}:
    `%|-%<:%`(C, I31_heaptype, EQ_heaptype)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:35.1-36.20
  rule `struct-eq`{C : context}:
    `%|-%<:%`(C, STRUCT_heaptype, EQ_heaptype)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:38.1-39.19
  rule `array-eq`{C : context}:
    `%|-%<:%`(C, ARRAY_heaptype, EQ_heaptype)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:41.1-43.42
  rule struct{C : context, deftype : deftype, `fieldtype*` : fieldtype*}:
    `%|-%<:%`(C, (deftype : deftype <: heaptype), STRUCT_heaptype)
    -- Expand: `%~~%`(deftype, STRUCT_comptype(`%`_list(fieldtype*{fieldtype <- `fieldtype*`})))

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:45.1-47.40
  rule array{C : context, deftype : deftype, fieldtype : fieldtype}:
    `%|-%<:%`(C, (deftype : deftype <: heaptype), ARRAY_heaptype)
    -- Expand: `%~~%`(deftype, ARRAY_comptype(fieldtype))

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:49.1-51.42
  rule func{C : context, deftype : deftype, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%<:%`(C, (deftype : deftype <: heaptype), FUNC_heaptype)
    -- Expand: `%~~%`(deftype, `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:53.1-55.46
  rule def{C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, (deftype_1 : deftype <: heaptype), (deftype_2 : deftype <: heaptype))
    -- Deftype_sub: `%|-%<:%`(C, deftype_1, deftype_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:57.1-59.53
  rule `typeidx-l`{C : context, typeidx : typeidx, heaptype : heaptype}:
    `%|-%<:%`(C, _IDX_heaptype(typeidx), heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, (C.TYPES_context[typeidx!`%`_typeidx.0] : deftype <: heaptype), heaptype)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:61.1-63.53
  rule `typeidx-r`{C : context, heaptype : heaptype, typeidx : typeidx}:
    `%|-%<:%`(C, heaptype, _IDX_heaptype(typeidx))
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, (C.TYPES_context[typeidx!`%`_typeidx.0] : deftype <: heaptype))

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:65.1-67.43
  rule rec{C : context, i : n, `typeuse*` : typeuse*, j : nat, `final?` : final?, ct : comptype}:
    `%|-%<:%`(C, REC_heaptype(i), (typeuse*{typeuse <- `typeuse*`}[j] : typeuse <: heaptype))
    -- if (C.RECS_context[i] = SUB_subtype(final?{final <- `final?`}, typeuse*{typeuse <- `typeuse*`}, ct))

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:69.1-71.40
  rule none{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NONE_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, ANY_heaptype)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:73.1-75.41
  rule nofunc{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOFUNC_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, FUNC_heaptype)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:77.1-79.40
  rule noexn{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOEXN_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, EXN_heaptype)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:81.1-83.43
  rule noextern{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, NOEXTERN_heaptype, heaptype)
    -- Heaptype_sub: `%|-%<:%`(C, heaptype, EXTERN_heaptype)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:85.1-86.23
  rule bot{C : context, heaptype : heaptype}:
    `%|-%<:%`(C, BOT_heaptype, heaptype)

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:10.1-10.103
relation Reftype_sub: `%|-%<:%`(context, reftype, reftype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:89.1-91.37
  rule nonnull{C : context, ht_1 : heaptype, ht_2 : heaptype}:
    `%|-%<:%`(C, REF_reftype(?(), ht_1), REF_reftype(?(), ht_2))
    -- Heaptype_sub: `%|-%<:%`(C, ht_1, ht_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:93.1-95.37
  rule null{C : context, ht_1 : heaptype, ht_2 : heaptype}:
    `%|-%<:%`(C, REF_reftype(NULL_null?{}, ht_1), REF_reftype(?(NULL_null), ht_2))
    -- Heaptype_sub: `%|-%<:%`(C, ht_1, ht_2)

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:11.1-11.103
relation Valtype_sub: `%|-%<:%`(context, valtype, valtype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:98.1-100.46
  rule num{C : context, numtype_1 : numtype, numtype_2 : numtype}:
    `%|-%<:%`(C, (numtype_1 : numtype <: valtype), (numtype_2 : numtype <: valtype))
    -- Numtype_sub: `%|-%<:%`(C, numtype_1, numtype_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:102.1-104.46
  rule vec{C : context, vectype_1 : vectype, vectype_2 : vectype}:
    `%|-%<:%`(C, (vectype_1 : vectype <: valtype), (vectype_2 : vectype <: valtype))
    -- Vectype_sub: `%|-%<:%`(C, vectype_1, vectype_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:106.1-108.46
  rule ref{C : context, reftype_1 : reftype, reftype_2 : reftype}:
    `%|-%<:%`(C, (reftype_1 : reftype <: valtype), (reftype_2 : reftype <: valtype))
    -- Reftype_sub: `%|-%<:%`(C, reftype_1, reftype_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:110.1-111.22
  rule bot{C : context, valtype : valtype}:
    `%|-%<:%`(C, BOT_valtype, valtype)

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:116.1-116.115
relation Resulttype_sub: `%|-%<:%`(context, resulttype, resulttype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:119.1-121.37
  rule _{C : context, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%<:%`(C, `%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))
    -- (Valtype_sub: `%|-%<:%`(C, t_1, t_2))*{t_1 <- `t_1*`, t_2 <- `t_2*`}

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:134.1-134.119
relation Storagetype_sub: `%|-%<:%`(context, storagetype, storagetype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:146.1-148.46
  rule val{C : context, valtype_1 : valtype, valtype_2 : valtype}:
    `%|-%<:%`(C, (valtype_1 : valtype <: storagetype), (valtype_2 : valtype <: storagetype))
    -- Valtype_sub: `%|-%<:%`(C, valtype_1, valtype_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:150.1-152.49
  rule pack{C : context, packtype_1 : packtype, packtype_2 : packtype}:
    `%|-%<:%`(C, (packtype_1 : packtype <: storagetype), (packtype_2 : packtype <: storagetype))
    -- Packtype_sub: `%|-%<:%`(C, packtype_1, packtype_2)

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:135.1-135.117
relation Fieldtype_sub: `%|-%<:%`(context, fieldtype, fieldtype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:155.1-157.40
  rule const{C : context, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%<:%`(C, `%%`_fieldtype(?(), zt_1), `%%`_fieldtype(?(), zt_2))
    -- Storagetype_sub: `%|-%<:%`(C, zt_1, zt_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec:159.1-162.40
  rule var{C : context, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%<:%`(C, `%%`_fieldtype(?(MUT_mut), zt_1), `%%`_fieldtype(?(MUT_mut), zt_2))
    -- Storagetype_sub: `%|-%<:%`(C, zt_1, zt_2)
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)
}

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
relation Instrtype_ok: `%|-%:OK`(context, instrtype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule _{C : context, `t_1*` : valtype*, `x*` : idx*, `t_2*` : valtype*, `lct*` : localtype*}:
    `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x*{x <- `x*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t_1*{t_1 <- `t_1*`}))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t_2*{t_2 <- `t_2*`}))
    -- (if (C.LOCALS_context[x!`%`_idx.0] = lct))*{lct <- `lct*`, x <- `x*`}

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
relation Expand_use: `%~~_%%`(typeuse, context, comptype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule deftype{deftype : deftype, C : context, comptype : comptype}:
    `%~~_%%`((deftype : deftype <: typeuse), C, comptype)
    -- Expand: `%~~%`(deftype, comptype)

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule typeidx{typeidx : typeidx, C : context, comptype : comptype}:
    `%~~_%%`(_IDX_typeuse(typeidx), C, comptype)
    -- Expand: `%~~%`(C.TYPES_context[typeidx!`%`_typeidx.0], comptype)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
relation Limits_ok: `%|-%:%`(context, limits, nat)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule _{C : context, n : n, `m?` : m?, k : nat}:
    `%|-%:%`(C, `[%..%]`_limits(`%`_u64(n), `%`_u64(m)?{m <- `m?`}), k)
    -- if (n <= k)
    -- (if ((n <= m) /\ (m <= k)))?{m <- `m?`}

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
relation Tagtype_ok: `%|-%:OK`(context, tagtype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule _{C : context, typeuse : typeuse, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:OK`(C, typeuse)
    -- Typeuse_ok: `%|-%:OK`(C, typeuse)
    -- Expand_use: `%~~_%%`(typeuse, C, `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
relation Globaltype_ok: `%|-%:OK`(context, globaltype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule _{C : context, t : valtype}:
    `%|-%:OK`(C, `%%`_globaltype(MUT_mut?{}, t))
    -- Valtype_ok: `%|-%:OK`(C, t)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
relation Memtype_ok: `%|-%:OK`(context, memtype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule _{C : context, addrtype : addrtype, limits : limits}:
    `%|-%:OK`(C, `%%PAGE`_memtype(addrtype, limits))
    -- Limits_ok: `%|-%:%`(C, limits, (2 ^ 16))

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
relation Tabletype_ok: `%|-%:OK`(context, tabletype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule _{C : context, addrtype : addrtype, limits : limits, reftype : reftype}:
    `%|-%:OK`(C, `%%%`_tabletype(addrtype, limits, reftype))
    -- Limits_ok: `%|-%:%`(C, limits, ((((2 ^ 32) : nat <:> int) - (1 : nat <:> int)) : int <:> nat))
    -- Reftype_ok: `%|-%:OK`(C, reftype)

;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
relation Externtype_ok: `%|-%:OK`(context, externtype)
  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule tag{C : context, tagtype : tagtype}:
    `%|-%:OK`(C, TAG_externtype(tagtype))
    -- Tagtype_ok: `%|-%:OK`(C, tagtype)

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule global{C : context, globaltype : globaltype}:
    `%|-%:OK`(C, GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `%|-%:OK`(C, globaltype)

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule mem{C : context, memtype : memtype}:
    `%|-%:OK`(C, MEM_externtype(memtype))
    -- Memtype_ok: `%|-%:OK`(C, memtype)

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule table{C : context, tabletype : tabletype}:
    `%|-%:OK`(C, TABLE_externtype(tabletype))
    -- Tabletype_ok: `%|-%:OK`(C, tabletype)

  ;; ../../../../specification/wasm-3.0/2.1-validation.types.spectec
  rule func{C : context, typeuse : typeuse, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:OK`(C, FUNC_externtype(typeuse))
    -- Typeuse_ok: `%|-%:OK`(C, typeuse)
    -- Expand_use: `%~~_%%`(typeuse, C, `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
relation Instrtype_sub: `%|-%<:%`(context, instrtype, instrtype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule _{C : context, `t_11*` : valtype*, `x_1*` : idx*, `t_12*` : valtype*, `t_21*` : valtype*, `x_2*` : idx*, `t_22*` : valtype*, `x*` : idx*, `t*` : valtype*}:
    `%|-%<:%`(C, `%->_%%`_instrtype(`%`_resulttype(t_11*{t_11 <- `t_11*`}), x_1*{x_1 <- `x_1*`}, `%`_resulttype(t_12*{t_12 <- `t_12*`})), `%->_%%`_instrtype(`%`_resulttype(t_21*{t_21 <- `t_21*`}), x_2*{x_2 <- `x_2*`}, `%`_resulttype(t_22*{t_22 <- `t_22*`})))
    -- Resulttype_sub: `%|-%<:%`(C, `%`_resulttype(t_21*{t_21 <- `t_21*`}), `%`_resulttype(t_11*{t_11 <- `t_11*`}))
    -- Resulttype_sub: `%|-%<:%`(C, `%`_resulttype(t_12*{t_12 <- `t_12*`}), `%`_resulttype(t_22*{t_22 <- `t_22*`}))
    -- if (x*{x <- `x*`} = $setminus_(syntax localidx, x_2*{x_2 <- `x_2*`}, x_1*{x_1 <- `x_1*`}))
    -- (if (C.LOCALS_context[x!`%`_idx.0] = `%%`_localtype(SET_init, t)))*{t <- `t*`, x <- `x*`}

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
relation Limits_sub: `%|-%<:%`(context, limits, limits)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule max{C : context, n_1 : n, m_1 : m, n_2 : n, `m_2?` : m?}:
    `%|-%<:%`(C, `[%..%]`_limits(`%`_u64(n_1), ?(`%`_u64(m_1))), `[%..%]`_limits(`%`_u64(n_2), `%`_u64(m_2)?{m_2 <- `m_2?`}))
    -- if (n_1 >= n_2)
    -- (if (m_1 <= m_2))?{m_2 <- `m_2?`}

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule eps{C : context, n_1 : n, n_2 : n}:
    `%|-%<:%`(C, `[%..%]`_limits(`%`_u64(n_1), ?()), `[%..%]`_limits(`%`_u64(n_2), ?()))
    -- if (n_1 >= n_2)

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
relation Tagtype_sub: `%|-%<:%`(context, tagtype, tagtype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule _{C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, (deftype_1 : deftype <: typeuse), (deftype_2 : deftype <: typeuse))
    -- Deftype_sub: `%|-%<:%`(C, deftype_1, deftype_2)
    -- Deftype_sub: `%|-%<:%`(C, deftype_2, deftype_1)

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
relation Globaltype_sub: `%|-%<:%`(context, globaltype, globaltype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule const{C : context, valtype_1 : valtype, valtype_2 : valtype}:
    `%|-%<:%`(C, `%%`_globaltype(?(), valtype_1), `%%`_globaltype(?(), valtype_2))
    -- Valtype_sub: `%|-%<:%`(C, valtype_1, valtype_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule var{C : context, valtype_1 : valtype, valtype_2 : valtype}:
    `%|-%<:%`(C, `%%`_globaltype(?(MUT_mut), valtype_1), `%%`_globaltype(?(MUT_mut), valtype_2))
    -- Valtype_sub: `%|-%<:%`(C, valtype_1, valtype_2)
    -- Valtype_sub: `%|-%<:%`(C, valtype_2, valtype_1)

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
relation Memtype_sub: `%|-%<:%`(context, memtype, memtype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule _{C : context, addrtype : addrtype, limits_1 : limits, limits_2 : limits}:
    `%|-%<:%`(C, `%%PAGE`_memtype(addrtype, limits_1), `%%PAGE`_memtype(addrtype, limits_2))
    -- Limits_sub: `%|-%<:%`(C, limits_1, limits_2)

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
relation Tabletype_sub: `%|-%<:%`(context, tabletype, tabletype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule _{C : context, addrtype : addrtype, limits_1 : limits, reftype_1 : reftype, limits_2 : limits, reftype_2 : reftype}:
    `%|-%<:%`(C, `%%%`_tabletype(addrtype, limits_1, reftype_1), `%%%`_tabletype(addrtype, limits_2, reftype_2))
    -- Limits_sub: `%|-%<:%`(C, limits_1, limits_2)
    -- Reftype_sub: `%|-%<:%`(C, reftype_1, reftype_2)
    -- Reftype_sub: `%|-%<:%`(C, reftype_2, reftype_1)

;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
relation Externtype_sub: `%|-%<:%`(context, externtype, externtype)
  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule tag{C : context, tagtype_1 : tagtype, tagtype_2 : tagtype}:
    `%|-%<:%`(C, TAG_externtype(tagtype_1), TAG_externtype(tagtype_2))
    -- Tagtype_sub: `%|-%<:%`(C, tagtype_1, tagtype_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule global{C : context, globaltype_1 : globaltype, globaltype_2 : globaltype}:
    `%|-%<:%`(C, GLOBAL_externtype(globaltype_1), GLOBAL_externtype(globaltype_2))
    -- Globaltype_sub: `%|-%<:%`(C, globaltype_1, globaltype_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule mem{C : context, memtype_1 : memtype, memtype_2 : memtype}:
    `%|-%<:%`(C, MEM_externtype(memtype_1), MEM_externtype(memtype_2))
    -- Memtype_sub: `%|-%<:%`(C, memtype_1, memtype_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule table{C : context, tabletype_1 : tabletype, tabletype_2 : tabletype}:
    `%|-%<:%`(C, TABLE_externtype(tabletype_1), TABLE_externtype(tabletype_2))
    -- Tabletype_sub: `%|-%<:%`(C, tabletype_1, tabletype_2)

  ;; ../../../../specification/wasm-3.0/2.2-validation.subtyping.spectec
  rule func{C : context, deftype_1 : deftype, deftype_2 : deftype}:
    `%|-%<:%`(C, FUNC_externtype((deftype_1 : deftype <: typeuse)), FUNC_externtype((deftype_2 : deftype <: typeuse)))
    -- Deftype_sub: `%|-%<:%`(C, deftype_1, deftype_2)

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
relation Blocktype_ok: `%|-%:%`(context, blocktype, instrtype)
  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule valtype{C : context, `valtype?` : valtype?}:
    `%|-%:%`(C, _RESULT_blocktype(valtype?{valtype <- `valtype?`}), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype(lift(valtype?{valtype <- `valtype?`}))))
    -- (Valtype_ok: `%|-%:OK`(C, valtype))?{valtype <- `valtype?`}

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule typeidx{C : context, typeidx : typeidx, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, _IDX_blocktype(typeidx), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Expand: `%~~%`(C.TYPES_context[typeidx!`%`_typeidx.0], `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
relation Catch_ok: `%|-%:OK`(context, catch)
  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule catch{C : context, x : idx, l : labelidx, `t*` : valtype*}:
    `%|-%:OK`(C, CATCH_catch(x, l))
    -- Expand: `%~~%`($as_deftype(C.TAGS_context[x!`%`_idx.0]), `FUNC%->%`_comptype(`%`_resulttype(t*{t <- `t*`}), `%`_resulttype([])))
    -- Resulttype_sub: `%|-%<:%`(C, `%`_resulttype(t*{t <- `t*`}), C.LABELS_context[l!`%`_labelidx.0])

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule catch_ref{C : context, x : idx, l : labelidx, `t*` : valtype*}:
    `%|-%:OK`(C, CATCH_REF_catch(x, l))
    -- Expand: `%~~%`($as_deftype(C.TAGS_context[x!`%`_idx.0]), `FUNC%->%`_comptype(`%`_resulttype(t*{t <- `t*`}), `%`_resulttype([])))
    -- Resulttype_sub: `%|-%<:%`(C, `%`_resulttype(t*{t <- `t*`} ++ [REF_valtype(?(), EXN_heaptype)]), C.LABELS_context[l!`%`_labelidx.0])

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule catch_all{C : context, l : labelidx}:
    `%|-%:OK`(C, CATCH_ALL_catch(l))
    -- Resulttype_sub: `%|-%<:%`(C, `%`_resulttype([]), C.LABELS_context[l!`%`_labelidx.0])

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule catch_all_ref{C : context, l : labelidx}:
    `%|-%:OK`(C, CATCH_ALL_REF_catch(l))
    -- Resulttype_sub: `%|-%<:%`(C, `%`_resulttype([REF_valtype(?(), EXN_heaptype)]), C.LABELS_context[l!`%`_labelidx.0])

;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
def $default_(valtype : valtype) : val?
  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
  def $default_{Inn : Inn}((Inn : addrtype <: valtype)) = ?(CONST_val((Inn : addrtype <: numtype), `%`_num_(0)))
  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
  def $default_{Fnn : Fnn}((Fnn : Fnn <: valtype)) = ?(CONST_val((Fnn : Fnn <: numtype), $fzero($size((Fnn : Fnn <: numtype)))))
  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
  def $default_{Vnn : Vnn}((Vnn : vectype <: valtype)) = ?(VCONST_val(Vnn, `%`_vec_(0)))
  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
  def $default_{ht : heaptype}(REF_valtype(?(NULL_null), ht)) = ?(REF.NULL_val(ht))
  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
  def $default_{ht : heaptype}(REF_valtype(?(), ht)) = ?()

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
relation Defaultable: `|-%DEFAULTABLE`(valtype)
  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
  rule _{t : valtype}:
    `|-%DEFAULTABLE`(t)
    -- if ($default_(t) =/= ?())

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
relation Memarg_ok: `|-%:%->%`(memarg, addrtype, N)
  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule _{n : n, m : m, at : addrtype, N : N}:
    `|-%:%->%`({ALIGN `%`_u32(n), OFFSET `%`_u64(m)}, at, N)
    -- if (((2 ^ n) : nat <:> rat) <= ((N : nat <:> rat) / (8 : nat <:> rat)))
    -- if (m < (2 ^ $size((at : addrtype <: numtype))))

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
def $is_packtype(storagetype : storagetype) : bool
  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  def $is_packtype{zt : storagetype}(zt) = (zt = ($unpack(zt) : valtype <: storagetype))

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
rec {

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:5.1-5.95
relation Instr_ok: `%|-%:%`(context, instr, instrtype)
  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:18.1-19.24
  rule nop{C : context}:
    `%|-%:%`(C, NOP_instr, `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:21.1-23.42
  rule unreachable{C : context, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:25.1-27.29
  rule drop{C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->_%%`_instrtype(`%`_resulttype([t]), [], `%`_resulttype([])))
    -- Valtype_ok: `%|-%:OK`(C, t)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:29.1-31.29
  rule `select-expl`{C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?([t])), `%->_%%`_instrtype(`%`_resulttype([t t I32_valtype]), [], `%`_resulttype([t])))
    -- Valtype_ok: `%|-%:OK`(C, t)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:33.1-37.37
  rule `select-impl`{C : context, t : valtype, t' : valtype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->_%%`_instrtype(`%`_resulttype([t t I32_valtype]), [], `%`_resulttype([t])))
    -- Valtype_ok: `%|-%:OK`(C, t)
    -- Valtype_sub: `%|-%<:%`(C, t, t')
    -- if ((t' = (numtype : numtype <: valtype)) \/ (t' = (vectype : vectype <: valtype)))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:53.1-56.67
  rule block{C : context, bt : blocktype, `instr*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*, `x*` : idx*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr <- `instr*`}), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 <- `t_2*`})], RETURN ?(), REFS []} +++ C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x*{x <- `x*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:58.1-61.67
  rule loop{C : context, bt : blocktype, `instr*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*, `x*` : idx*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr <- `instr*`}), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [`%`_resulttype(t_1*{t_1 <- `t_1*`})], RETURN ?(), REFS []} +++ C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x*{x <- `x*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:63.1-67.71
  rule if{C : context, bt : blocktype, `instr_1*` : instr*, `instr_2*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*, `x_1*` : idx*, `x_2*` : idx*}:
    `%|-%:%`(C, `IF%%ELSE%`_instr(bt, instr_1*{instr_1 <- `instr_1*`}, instr_2*{instr_2 <- `instr_2*`}), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ [I32_valtype]), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 <- `t_2*`})], RETURN ?(), REFS []} +++ C, instr_1*{instr_1 <- `instr_1*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x_1*{x_1 <- `x_1*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 <- `t_2*`})], RETURN ?(), REFS []} +++ C, instr_2*{instr_2 <- `instr_2*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x_2*{x_2 <- `x_2*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:72.1-75.42
  rule br{C : context, l : labelidx, `t_1*` : valtype*, `t*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ t*{t <- `t*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- if (C.LABELS_context[l!`%`_labelidx.0]!`%`_resulttype.0 = t*{t <- `t*`})
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:77.1-79.25
  rule br_if{C : context, l : labelidx, `t*` : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->_%%`_instrtype(`%`_resulttype(t*{t <- `t*`} ++ [I32_valtype]), [], `%`_resulttype(t*{t <- `t*`})))
    -- if (C.LABELS_context[l!`%`_labelidx.0]!`%`_resulttype.0 = t*{t <- `t*`})

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:81.1-85.49
  rule br_table{C : context, `l*` : labelidx*, l' : labelidx, `t_1*` : valtype*, `t*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l <- `l*`}, l'), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ t*{t <- `t*`} ++ [I32_valtype]), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- (Resulttype_sub: `%|-%<:%`(C, `%`_resulttype(t*{t <- `t*`}), C.LABELS_context[l!`%`_labelidx.0]))*{l <- `l*`}
    -- Resulttype_sub: `%|-%<:%`(C, `%`_resulttype(t*{t <- `t*`}), C.LABELS_context[l'!`%`_labelidx.0])
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ t*{t <- `t*`} ++ [I32_valtype]), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:87.1-90.31
  rule br_on_null{C : context, l : labelidx, `t*` : valtype*, ht : heaptype}:
    `%|-%:%`(C, BR_ON_NULL_instr(l), `%->_%%`_instrtype(`%`_resulttype(t*{t <- `t*`} ++ [REF_valtype(?(NULL_null), ht)]), [], `%`_resulttype(t*{t <- `t*`} ++ [REF_valtype(?(), ht)])))
    -- if (C.LABELS_context[l!`%`_labelidx.0]!`%`_resulttype.0 = t*{t <- `t*`})
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:92.1-94.40
  rule br_on_non_null{C : context, l : labelidx, `t*` : valtype*, ht : heaptype}:
    `%|-%:%`(C, BR_ON_NON_NULL_instr(l), `%->_%%`_instrtype(`%`_resulttype(t*{t <- `t*`} ++ [REF_valtype(?(NULL_null), ht)]), [], `%`_resulttype(t*{t <- `t*`})))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t <- `t*`} ++ [REF_valtype(NULL_null?{}, ht)]))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:96.1-102.34
  rule br_on_cast{C : context, l : labelidx, rt_1 : reftype, rt_2 : reftype, `t*` : valtype*, rt : reftype}:
    `%|-%:%`(C, BR_ON_CAST_instr(l, rt_1, rt_2), `%->_%%`_instrtype(`%`_resulttype(t*{t <- `t*`} ++ [(rt_1 : reftype <: valtype)]), [], `%`_resulttype(t*{t <- `t*`} ++ [($diffrt(rt_1, rt_2) : reftype <: valtype)])))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t <- `t*`} ++ [(rt : reftype <: valtype)]))
    -- Reftype_ok: `%|-%:OK`(C, rt_1)
    -- Reftype_ok: `%|-%:OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:104.1-110.49
  rule br_on_cast_fail{C : context, l : labelidx, rt_1 : reftype, rt_2 : reftype, `t*` : valtype*, rt : reftype}:
    `%|-%:%`(C, BR_ON_CAST_FAIL_instr(l, rt_1, rt_2), `%->_%%`_instrtype(`%`_resulttype(t*{t <- `t*`} ++ [(rt_1 : reftype <: valtype)]), [], `%`_resulttype(t*{t <- `t*`} ++ [(rt_2 : reftype <: valtype)])))
    -- if (C.LABELS_context[l!`%`_labelidx.0] = `%`_resulttype(t*{t <- `t*`} ++ [(rt : reftype <: valtype)]))
    -- Reftype_ok: `%|-%:OK`(C, rt_1)
    -- Reftype_ok: `%|-%:OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, $diffrt(rt_1, rt_2), rt)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:115.1-117.45
  rule call{C : context, x : idx, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, CALL_instr(x), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Expand: `%~~%`(C.FUNCS_context[x!`%`_idx.0], `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:119.1-121.45
  rule call_ref{C : context, x : idx, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, CALL_REF_instr(_IDX_typeuse(x)), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ [REF_valtype(?(NULL_null), _IDX_heaptype(x))]), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:123.1-127.45
  rule call_indirect{C : context, x : idx, y : idx, `t_1*` : valtype*, at : addrtype, `t_2*` : valtype*, lim : limits, rt : reftype}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, _IDX_typeuse(y)), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ [(at : addrtype <: valtype)]), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%%`_tabletype(at, lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(?(NULL_null), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPES_context[y!`%`_idx.0], `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:129.1-132.42
  rule return{C : context, `t_1*` : valtype*, `t*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ t*{t <- `t*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- if (C.RETURN_context = ?(`%`_resulttype(t*{t <- `t*`})))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:135.1-140.42
  rule return_call{C : context, x : idx, `t_3*` : valtype*, `t_1*` : valtype*, `t_4*` : valtype*, `t_2*` : valtype*, `t'_2*` : valtype*}:
    `%|-%:%`(C, RETURN_CALL_instr(x), `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 <- `t_3*`} ++ t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_4*{t_4 <- `t_4*`})))
    -- Expand: `%~~%`(C.FUNCS_context[x!`%`_idx.0], `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- if (C.RETURN_context = ?(`%`_resulttype(t'_2*{t'_2 <- `t'_2*`})))
    -- Resulttype_sub: `%|-%<:%`(C, `%`_resulttype(t_2*{t_2 <- `t_2*`}), `%`_resulttype(t'_2*{t'_2 <- `t'_2*`}))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 <- `t_3*`}), [], `%`_resulttype(t_4*{t_4 <- `t_4*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:143.1-148.42
  rule return_call_ref{C : context, x : idx, `t_3*` : valtype*, `t_1*` : valtype*, `t_4*` : valtype*, `t_2*` : valtype*, `t'_2*` : valtype*}:
    `%|-%:%`(C, RETURN_CALL_REF_instr(_IDX_typeuse(x)), `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 <- `t_3*`} ++ t_1*{t_1 <- `t_1*`} ++ [REF_valtype(?(NULL_null), _IDX_heaptype(x))]), [], `%`_resulttype(t_4*{t_4 <- `t_4*`})))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- if (C.RETURN_context = ?(`%`_resulttype(t'_2*{t'_2 <- `t'_2*`})))
    -- Resulttype_sub: `%|-%<:%`(C, `%`_resulttype(t_2*{t_2 <- `t_2*`}), `%`_resulttype(t'_2*{t'_2 <- `t'_2*`}))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 <- `t_3*`}), [], `%`_resulttype(t_4*{t_4 <- `t_4*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:151.1-159.42
  rule return_call_indirect{C : context, x : idx, y : idx, `t_3*` : valtype*, `t_1*` : valtype*, at : addrtype, `t_4*` : valtype*, lim : limits, rt : reftype, `t_2*` : valtype*, `t'_2*` : valtype*}:
    `%|-%:%`(C, RETURN_CALL_INDIRECT_instr(x, _IDX_typeuse(y)), `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 <- `t_3*`} ++ t_1*{t_1 <- `t_1*`} ++ [(at : addrtype <: valtype)]), [], `%`_resulttype(t_4*{t_4 <- `t_4*`})))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%%`_tabletype(at, lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(?(NULL_null), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPES_context[y!`%`_idx.0], `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- if (C.RETURN_context = ?(`%`_resulttype(t'_2*{t'_2 <- `t'_2*`})))
    -- Resulttype_sub: `%|-%<:%`(C, `%`_resulttype(t_2*{t_2 <- `t_2*`}), `%`_resulttype(t'_2*{t'_2 <- `t'_2*`}))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_3*{t_3 <- `t_3*`}), [], `%`_resulttype(t_4*{t_4 <- `t_4*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:166.1-169.42
  rule throw{C : context, x : idx, `t_1*` : valtype*, `t*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, THROW_instr(x), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ t*{t <- `t*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Expand: `%~~%`($as_deftype(C.TAGS_context[x!`%`_idx.0]), `FUNC%->%`_comptype(`%`_resulttype(t*{t <- `t*`}), `%`_resulttype([])))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:171.1-173.42
  rule throw_ref{C : context, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, THROW_REF_instr, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`} ++ [REF_valtype(?(NULL_null), EXN_heaptype)]), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrtype_ok: `%|-%:OK`(C, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:175.1-179.34
  rule try_table{C : context, bt : blocktype, `catch*` : catch*, `instr*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*, `x*` : idx*}:
    `%|-%:%`(C, TRY_TABLE_instr(bt, `%`_list(catch*{catch <- `catch*`}), instr*{instr <- `instr*`}), `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Instrs_ok: `%|-%:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 <- `t_2*`})], RETURN ?(), REFS []} +++ C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x*{x <- `x*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- (Catch_ok: `%|-%:OK`(C, catch))*{catch <- `catch*`}

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:202.1-204.31
  rule ref.null{C : context, ht : heaptype}:
    `%|-%:%`(C, REF.NULL_instr(ht), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([REF_valtype(?(NULL_null), ht)])))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:206.1-209.20
  rule ref.func{C : context, x : idx, dt : deftype}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([REF_valtype(?(), (dt : deftype <: heaptype))])))
    -- if (C.FUNCS_context[x!`%`_idx.0] = dt)
    -- if (x <- C.REFS_context)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:211.1-212.34
  rule ref.i31{C : context}:
    `%|-%:%`(C, REF.I31_instr, `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([REF_valtype(?(), I31_heaptype)])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:214.1-216.31
  rule ref.is_null{C : context, ht : heaptype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), ht)]), [], `%`_resulttype([I32_valtype])))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:218.1-220.31
  rule ref.as_non_null{C : context, ht : heaptype}:
    `%|-%:%`(C, REF.AS_NON_NULL_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), ht)]), [], `%`_resulttype([REF_valtype(?(), ht)])))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:222.1-223.51
  rule ref.eq{C : context}:
    `%|-%:%`(C, REF.EQ_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), EQ_heaptype) REF_valtype(?(NULL_null), EQ_heaptype)]), [], `%`_resulttype([I32_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:225.1-229.33
  rule ref.test{C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.TEST_instr(rt), `%->_%%`_instrtype(`%`_resulttype([(rt' : reftype <: valtype)]), [], `%`_resulttype([I32_valtype])))
    -- Reftype_ok: `%|-%:OK`(C, rt)
    -- Reftype_ok: `%|-%:OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:231.1-235.33
  rule ref.cast{C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.CAST_instr(rt), `%->_%%`_instrtype(`%`_resulttype([(rt' : reftype <: valtype)]), [], `%`_resulttype([(rt : reftype <: valtype)])))
    -- Reftype_ok: `%|-%:OK`(C, rt)
    -- Reftype_ok: `%|-%:OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:240.1-241.42
  rule i31.get{C : context, sx : sx}:
    `%|-%:%`(C, I31.GET_instr(sx), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), I31_heaptype)]), [], `%`_resulttype([I32_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:246.1-248.45
  rule struct.new{C : context, x : idx, `zt*` : storagetype*, `mut?*` : mut?*}:
    `%|-%:%`(C, STRUCT.NEW_instr(x), `%->_%%`_instrtype(`%`_resulttype($unpack(zt)*{zt <- `zt*`}), [], `%`_resulttype([REF_valtype(?(), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], STRUCT_comptype(`%`_list(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)*{`mut?` <- `mut?*`, zt <- `zt*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:250.1-253.48
  rule struct.new_default{C : context, x : idx, `mut?*` : mut?*, `zt*` : storagetype*}:
    `%|-%:%`(C, STRUCT.NEW_DEFAULT_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([REF_valtype(?(), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], STRUCT_comptype(`%`_list(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)*{`mut?` <- `mut?*`, zt <- `zt*`})))
    -- (Defaultable: `|-%DEFAULTABLE`($unpack(zt)))*{zt <- `zt*`}

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:258.1-262.39
  rule struct.get{C : context, `sx?` : sx?, x : idx, i : u32, zt : storagetype, `ft*` : fieldtype*, `mut?` : mut?}:
    `%|-%:%`(C, STRUCT.GET_instr(sx?{sx <- `sx?`}, x, i), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), _IDX_heaptype(x))]), [], `%`_resulttype([$unpack(zt)])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], STRUCT_comptype(`%`_list(ft*{ft <- `ft*`})))
    -- if (ft*{ft <- `ft*`}[i!`%`_u32.0] = `%%`_fieldtype(mut?{mut <- `mut?`}, zt))
    -- if ((sx?{sx <- `sx?`} = ?()) <=> $is_packtype(zt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:264.1-267.24
  rule struct.set{C : context, x : idx, i : u32, zt : storagetype, `ft*` : fieldtype*}:
    `%|-%:%`(C, STRUCT.SET_instr(x, i), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), _IDX_heaptype(x)) $unpack(zt)]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], STRUCT_comptype(`%`_list(ft*{ft <- `ft*`})))
    -- if (ft*{ft <- `ft*`}[i!`%`_u32.0] = `%%`_fieldtype(?(MUT_mut), zt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:272.1-274.43
  rule array.new{C : context, x : idx, zt : storagetype, `mut?` : mut?}:
    `%|-%:%`(C, ARRAY.NEW_instr(x), `%->_%%`_instrtype(`%`_resulttype([$unpack(zt) I32_valtype]), [], `%`_resulttype([REF_valtype(?(), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:276.1-279.45
  rule array.new_default{C : context, x : idx, `mut?` : mut?, zt : storagetype}:
    `%|-%:%`(C, ARRAY.NEW_DEFAULT_instr(x), `%->_%%`_instrtype(`%`_resulttype([I32_valtype]), [], `%`_resulttype([REF_valtype(?(), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))
    -- Defaultable: `|-%DEFAULTABLE`($unpack(zt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:281.1-283.43
  rule array.new_fixed{C : context, x : idx, n : n, zt : storagetype, `mut?` : mut?}:
    `%|-%:%`(C, ARRAY.NEW_FIXED_instr(x, `%`_u32(n)), `%->_%%`_instrtype(`%`_resulttype($unpack(zt)^n{}), [], `%`_resulttype([REF_valtype(?(), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:285.1-288.40
  rule array.new_elem{C : context, x : idx, y : idx, `mut?` : mut?, rt : reftype}:
    `%|-%:%`(C, ARRAY.NEW_ELEM_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype]), [], `%`_resulttype([REF_valtype(?(), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, (rt : reftype <: storagetype))))
    -- Reftype_sub: `%|-%<:%`(C, C.ELEMS_context[y!`%`_idx.0], rt)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:290.1-294.24
  rule array.new_data{C : context, x : idx, y : idx, `mut?` : mut?, zt : storagetype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, ARRAY.NEW_DATA_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype]), [], `%`_resulttype([REF_valtype(?(), _IDX_heaptype(x))])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))
    -- if (($unpack(zt) = (numtype : numtype <: valtype)) \/ ($unpack(zt) = (vectype : vectype <: valtype)))
    -- if (C.DATAS_context[y!`%`_idx.0] = OK_datatype)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:296.1-299.39
  rule array.get{C : context, `sx?` : sx?, x : idx, zt : storagetype, `mut?` : mut?}:
    `%|-%:%`(C, ARRAY.GET_instr(sx?{sx <- `sx?`}, x), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), _IDX_heaptype(x)) I32_valtype]), [], `%`_resulttype([$unpack(zt)])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))
    -- if ((sx?{sx <- `sx?`} = ?()) <=> $is_packtype(zt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:301.1-303.42
  rule array.set{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.SET_instr(x), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), _IDX_heaptype(x)) I32_valtype $unpack(zt)]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_fieldtype(?(MUT_mut), zt)))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:305.1-306.43
  rule array.len{C : context}:
    `%|-%:%`(C, ARRAY.LEN_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), ARRAY_heaptype)]), [], `%`_resulttype([I32_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:308.1-310.42
  rule array.fill{C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.FILL_instr(x), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), _IDX_heaptype(x)) I32_valtype $unpack(zt) I32_valtype]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_fieldtype(?(MUT_mut), zt)))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:312.1-316.40
  rule array.copy{C : context, x_1 : idx, x_2 : idx, zt_1 : storagetype, `mut?` : mut?, zt_2 : storagetype}:
    `%|-%:%`(C, ARRAY.COPY_instr(x_1, x_2), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), _IDX_heaptype(x_1)) I32_valtype REF_valtype(?(NULL_null), _IDX_heaptype(x_2)) I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x_1!`%`_idx.0], ARRAY_comptype(`%%`_fieldtype(?(MUT_mut), zt_1)))
    -- Expand: `%~~%`(C.TYPES_context[x_2!`%`_idx.0], ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt_2)))
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:318.1-321.44
  rule array.init_elem{C : context, x : idx, y : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.INIT_ELEM_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), _IDX_heaptype(x)) I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_fieldtype(?(MUT_mut), zt)))
    -- Storagetype_sub: `%|-%<:%`(C, (C.ELEMS_context[y!`%`_idx.0] : reftype <: storagetype), zt)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:323.1-327.24
  rule array.init_data{C : context, x : idx, y : idx, zt : storagetype, numtype : numtype, vectype : vectype}:
    `%|-%:%`(C, ARRAY.INIT_DATA_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([REF_valtype(?(NULL_null), _IDX_heaptype(x)) I32_valtype I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], ARRAY_comptype(`%%`_fieldtype(?(MUT_mut), zt)))
    -- if (($unpack(zt) = (numtype : numtype <: valtype)) \/ ($unpack(zt) = (vectype : vectype <: valtype)))
    -- if (C.DATAS_context[y!`%`_idx.0] = OK_datatype)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:332.1-334.26
  rule extern.convert_any{C : context, `null_1?` : null?, `null_2?` : null?}:
    `%|-%:%`(C, EXTERN.CONVERT_ANY_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(null_1?{null_1 <- `null_1?`}, ANY_heaptype)]), [], `%`_resulttype([REF_valtype(null_2?{null_2 <- `null_2?`}, EXTERN_heaptype)])))
    -- if (null_1?{null_1 <- `null_1?`} = null_2?{null_2 <- `null_2?`})

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:336.1-338.26
  rule any.convert_extern{C : context, `null_1?` : null?, `null_2?` : null?}:
    `%|-%:%`(C, ANY.CONVERT_EXTERN_instr, `%->_%%`_instrtype(`%`_resulttype([REF_valtype(null_1?{null_1 <- `null_1?`}, EXTERN_heaptype)]), [], `%`_resulttype([REF_valtype(null_2?{null_2 <- `null_2?`}, ANY_heaptype)])))
    -- if (null_1?{null_1 <- `null_1?`} = null_2?{null_2 <- `null_2?`})

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:343.1-345.28
  rule local.get{C : context, x : idx, t : valtype}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([t])))
    -- if (C.LOCALS_context[x!`%`_idx.0] = `%%`_localtype(SET_init, t))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:347.1-349.29
  rule local.set{C : context, x : idx, t : valtype, init : init}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->_%%`_instrtype(`%`_resulttype([t]), [x], `%`_resulttype([])))
    -- if (C.LOCALS_context[x!`%`_idx.0] = `%%`_localtype(init, t))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:351.1-353.29
  rule local.tee{C : context, x : idx, t : valtype, init : init}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->_%%`_instrtype(`%`_resulttype([t]), [x], `%`_resulttype([t])))
    -- if (C.LOCALS_context[x!`%`_idx.0] = `%%`_localtype(init, t))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:358.1-360.30
  rule global.get{C : context, x : idx, t : valtype, `mut?` : mut?}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([t])))
    -- if (C.GLOBALS_context[x!`%`_idx.0] = `%%`_globaltype(mut?{mut <- `mut?`}, t))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:362.1-364.29
  rule global.set{C : context, x : idx, t : valtype}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->_%%`_instrtype(`%`_resulttype([t]), [], `%`_resulttype([])))
    -- if (C.GLOBALS_context[x!`%`_idx.0] = `%%`_globaltype(?(MUT_mut), t))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:369.1-371.32
  rule table.get{C : context, x : idx, at : addrtype, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype)]), [], `%`_resulttype([(rt : reftype <: valtype)])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%%`_tabletype(at, lim, rt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:373.1-375.32
  rule table.set{C : context, x : idx, at : addrtype, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype) (rt : reftype <: valtype)]), [], `%`_resulttype([])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%%`_tabletype(at, lim, rt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:377.1-379.32
  rule table.size{C : context, x : idx, at : addrtype, lim : limits, rt : reftype}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([(at : addrtype <: valtype)])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%%`_tabletype(at, lim, rt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:381.1-383.32
  rule table.grow{C : context, x : idx, rt : reftype, at : addrtype, lim : limits}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->_%%`_instrtype(`%`_resulttype([(rt : reftype <: valtype) (at : addrtype <: valtype)]), [], `%`_resulttype([I32_valtype])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%%`_tabletype(at, lim, rt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:385.1-387.32
  rule table.fill{C : context, x : idx, at : addrtype, rt : reftype, lim : limits}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype) (rt : reftype <: valtype) (at : addrtype <: valtype)]), [], `%`_resulttype([])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%%`_tabletype(at, lim, rt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:389.1-393.36
  rule table.copy{C : context, x_1 : idx, x_2 : idx, at_1 : addrtype, at_2 : addrtype, lim_1 : limits, rt_1 : reftype, lim_2 : limits, rt_2 : reftype}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->_%%`_instrtype(`%`_resulttype([(at_1 : addrtype <: valtype) (at_2 : addrtype <: valtype) ($minat(at_1, at_2) : addrtype <: valtype)]), [], `%`_resulttype([])))
    -- if (C.TABLES_context[x_1!`%`_idx.0] = `%%%`_tabletype(at_1, lim_1, rt_1))
    -- if (C.TABLES_context[x_2!`%`_idx.0] = `%%%`_tabletype(at_2, lim_2, rt_2))
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:395.1-399.36
  rule table.init{C : context, x : idx, y : idx, at : addrtype, lim : limits, rt_1 : reftype, rt_2 : reftype}:
    `%|-%:%`(C, TABLE.INIT_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype) I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%%`_tabletype(at, lim, rt_1))
    -- if (C.ELEMS_context[y!`%`_idx.0] = rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:401.1-403.24
  rule elem.drop{C : context, x : idx, rt : reftype}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([])))
    -- if (C.ELEMS_context[x!`%`_idx.0] = rt)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:416.1-418.32
  rule memory.size{C : context, x : idx, at : addrtype, lim : limits}:
    `%|-%:%`(C, MEMORY.SIZE_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([(at : addrtype <: valtype)])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:420.1-422.32
  rule memory.grow{C : context, x : idx, at : addrtype, lim : limits}:
    `%|-%:%`(C, MEMORY.GROW_instr(x), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype)]), [], `%`_resulttype([(at : addrtype <: valtype)])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:424.1-426.32
  rule memory.fill{C : context, x : idx, at : addrtype, lim : limits}:
    `%|-%:%`(C, MEMORY.FILL_instr(x), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype) I32_valtype (at : addrtype <: valtype)]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:428.1-431.38
  rule memory.copy{C : context, x_1 : idx, x_2 : idx, at_1 : addrtype, at_2 : addrtype, lim_1 : limits, lim_2 : limits}:
    `%|-%:%`(C, MEMORY.COPY_instr(x_1, x_2), `%->_%%`_instrtype(`%`_resulttype([(at_1 : addrtype <: valtype) (at_2 : addrtype <: valtype) ($minat(at_1, at_2) : addrtype <: valtype)]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x_1!`%`_idx.0] = `%%PAGE`_memtype(at_1, lim_1))
    -- if (C.MEMS_context[x_2!`%`_idx.0] = `%%PAGE`_memtype(at_2, lim_2))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:433.1-436.24
  rule memory.init{C : context, x : idx, y : idx, at : addrtype, lim : limits}:
    `%|-%:%`(C, MEMORY.INIT_instr(x, y), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype) I32_valtype I32_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- if (C.DATAS_context[y!`%`_idx.0] = OK_datatype)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:438.1-440.24
  rule data.drop{C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([])))
    -- if (C.DATAS_context[x!`%`_idx.0] = OK_datatype)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:451.1-454.44
  rule `load-val`{C : context, nt : numtype, x : idx, memarg : memarg, at : addrtype, lim : limits}:
    `%|-%:%`(C, LOAD_instr(nt, ?(), x, memarg), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype)]), [], `%`_resulttype([(nt : numtype <: valtype)])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- Memarg_ok: `|-%:%->%`(memarg, at, $size(nt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:456.1-459.36
  rule `load-pack`{C : context, Inn : Inn, M : M, sx : sx, x : idx, memarg : memarg, at : addrtype, lim : limits}:
    `%|-%:%`(C, LOAD_instr((Inn : addrtype <: numtype), ?(`%_%`_loadop_(`%`_sz(M), sx)), x, memarg), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype)]), [], `%`_resulttype([(Inn : addrtype <: valtype)])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- Memarg_ok: `|-%:%->%`(memarg, at, M)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:470.1-473.44
  rule `store-val`{C : context, nt : numtype, x : idx, memarg : memarg, at : addrtype, lim : limits}:
    `%|-%:%`(C, STORE_instr(nt, ?(), x, memarg), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype) (nt : numtype <: valtype)]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- Memarg_ok: `|-%:%->%`(memarg, at, $size(nt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:475.1-478.36
  rule `store-pack`{C : context, Inn : Inn, M : M, x : idx, memarg : memarg, at : addrtype, lim : limits}:
    `%|-%:%`(C, STORE_instr((Inn : addrtype <: numtype), ?(`%`_storeop_(`%`_sz(M))), x, memarg), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype) (Inn : addrtype <: valtype)]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- Memarg_ok: `|-%:%->%`(memarg, at, M)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:480.1-483.47
  rule `vload-val`{C : context, x : idx, memarg : memarg, at : addrtype, lim : limits}:
    `%|-%:%`(C, VLOAD_instr(V128_vectype, ?(), x, memarg), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype)]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- Memarg_ok: `|-%:%->%`(memarg, at, $vsize(V128_vectype))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:485.1-488.41
  rule `vload-pack`{C : context, M : M, N : N, sx : sx, x : idx, memarg : memarg, at : addrtype, lim : limits}:
    `%|-%:%`(C, VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(M), N, sx)), x, memarg), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype)]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- Memarg_ok: `|-%:%->%`(memarg, at, (M * N))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:490.1-493.36
  rule `vload-splat`{C : context, N : N, x : idx, memarg : memarg, at : addrtype, lim : limits}:
    `%|-%:%`(C, VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(N))), x, memarg), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype)]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- Memarg_ok: `|-%:%->%`(memarg, at, N)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:495.1-498.36
  rule `vload-zero`{C : context, N : N, x : idx, memarg : memarg, at : addrtype, lim : limits}:
    `%|-%:%`(C, VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(N))), x, memarg), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype)]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- Memarg_ok: `|-%:%->%`(memarg, at, N)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:500.1-504.21
  rule vload_lane{C : context, N : N, x : idx, memarg : memarg, i : laneidx, at : addrtype, lim : limits}:
    `%|-%:%`(C, VLOAD_LANE_instr(V128_vectype, `%`_sz(N), x, memarg, i), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype) V128_valtype]), [], `%`_resulttype([V128_valtype])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- Memarg_ok: `|-%:%->%`(memarg, at, N)
    -- if ((i!`%`_laneidx.0 : nat <:> rat) < ((128 : nat <:> rat) / (N : nat <:> rat)))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:506.1-509.47
  rule vstore{C : context, x : idx, memarg : memarg, at : addrtype, lim : limits}:
    `%|-%:%`(C, VSTORE_instr(V128_vectype, x, memarg), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype) V128_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- Memarg_ok: `|-%:%->%`(memarg, at, $vsize(V128_vectype))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:511.1-515.21
  rule vstore_lane{C : context, N : N, x : idx, memarg : memarg, i : laneidx, at : addrtype, lim : limits}:
    `%|-%:%`(C, VSTORE_LANE_instr(V128_vectype, `%`_sz(N), x, memarg, i), `%->_%%`_instrtype(`%`_resulttype([(at : addrtype <: valtype) V128_valtype]), [], `%`_resulttype([])))
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- Memarg_ok: `|-%:%->%`(memarg, at, N)
    -- if ((i!`%`_laneidx.0 : nat <:> rat) < ((128 : nat <:> rat) / (N : nat <:> rat)))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:520.1-521.33
  rule const{C : context, nt : numtype, c_nt : num_(nt)}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([(nt : numtype <: valtype)])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:523.1-524.34
  rule unop{C : context, nt : numtype, unop_nt : unop_(nt)}:
    `%|-%:%`(C, UNOP_instr(nt, unop_nt), `%->_%%`_instrtype(`%`_resulttype([(nt : numtype <: valtype)]), [], `%`_resulttype([(nt : numtype <: valtype)])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:526.1-527.39
  rule binop{C : context, nt : numtype, binop_nt : binop_(nt)}:
    `%|-%:%`(C, BINOP_instr(nt, binop_nt), `%->_%%`_instrtype(`%`_resulttype([(nt : numtype <: valtype) (nt : numtype <: valtype)]), [], `%`_resulttype([(nt : numtype <: valtype)])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:529.1-530.39
  rule testop{C : context, nt : numtype, testop_nt : testop_(nt)}:
    `%|-%:%`(C, TESTOP_instr(nt, testop_nt), `%->_%%`_instrtype(`%`_resulttype([(nt : numtype <: valtype)]), [], `%`_resulttype([I32_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:532.1-533.40
  rule relop{C : context, nt : numtype, relop_nt : relop_(nt)}:
    `%|-%:%`(C, RELOP_instr(nt, relop_nt), `%->_%%`_instrtype(`%`_resulttype([(nt : numtype <: valtype) (nt : numtype <: valtype)]), [], `%`_resulttype([I32_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:535.1-536.44
  rule cvtop{C : context, nt_1 : numtype, nt_2 : numtype, cvtop : cvtop__(nt_2, nt_1)}:
    `%|-%:%`(C, CVTOP_instr(nt_1, nt_2, cvtop), `%->_%%`_instrtype(`%`_resulttype([(nt_2 : numtype <: valtype)]), [], `%`_resulttype([(nt_1 : numtype <: valtype)])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:541.1-542.35
  rule vconst{C : context, c : vec_(V128_Vnn)}:
    `%|-%:%`(C, VCONST_instr(V128_vectype, c), `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:544.1-545.41
  rule vvunop{C : context, vvunop : vvunop}:
    `%|-%:%`(C, VVUNOP_instr(V128_vectype, vvunop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:547.1-548.48
  rule vvbinop{C : context, vvbinop : vvbinop}:
    `%|-%:%`(C, VVBINOP_instr(V128_vectype, vvbinop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:550.1-551.55
  rule vvternop{C : context, vvternop : vvternop}:
    `%|-%:%`(C, VVTERNOP_instr(V128_vectype, vvternop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:553.1-554.44
  rule vvtestop{C : context, vvtestop : vvtestop}:
    `%|-%:%`(C, VVTESTOP_instr(V128_vectype, vvtestop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([I32_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:556.1-557.37
  rule vunop{C : context, sh : shape, vunop : vunop_(sh)}:
    `%|-%:%`(C, VUNOP_instr(sh, vunop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:559.1-560.44
  rule vbinop{C : context, sh : shape, vbinop : vbinop_(sh)}:
    `%|-%:%`(C, VBINOP_instr(sh, vbinop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:562.1-563.51
  rule vternop{C : context, sh : shape, vternop : vternop_(sh)}:
    `%|-%:%`(C, VTERNOP_instr(sh, vternop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:565.1-566.40
  rule vtestop{C : context, sh : shape, vtestop : vtestop_(sh)}:
    `%|-%:%`(C, VTESTOP_instr(sh, vtestop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([I32_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:568.1-569.44
  rule vrelop{C : context, sh : shape, vrelop : vrelop_(sh)}:
    `%|-%:%`(C, VRELOP_instr(sh, vrelop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:571.1-572.47
  rule vshiftop{C : context, sh : ishape, vshiftop : vshiftop_(sh)}:
    `%|-%:%`(C, VSHIFTOP_instr(sh, vshiftop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype I32_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:574.1-575.33
  rule vbitmask{C : context, sh : ishape}:
    `%|-%:%`(C, VBITMASK_instr(sh), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([I32_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:577.1-578.50
  rule vswizzlop{C : context, sh : bshape, vswizzlop : vswizzlop_(sh)}:
    `%|-%:%`(C, VSWIZZLOP_instr(sh, vswizzlop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:580.1-582.29
  rule vshuffle{C : context, sh : bshape, `i*` : laneidx*}:
    `%|-%:%`(C, VSHUFFLE_instr(sh, i*{i <- `i*`}), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))
    -- (if (i!`%`_laneidx.0 < (2 * $dim(sh!`%`_bshape.0)!`%`_dim.0)))*{i <- `i*`}

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:584.1-585.44
  rule vsplat{C : context, sh : shape}:
    `%|-%:%`(C, VSPLAT_instr(sh), `%->_%%`_instrtype(`%`_resulttype([($unpackshape(sh) : numtype <: valtype)]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:587.1-589.21
  rule vextract_lane{C : context, sh : shape, `sx?` : sx?, i : laneidx}:
    `%|-%:%`(C, VEXTRACT_LANE_instr(sh, sx?{sx <- `sx?`}, i), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([($unpackshape(sh) : numtype <: valtype)])))
    -- if (i!`%`_laneidx.0 < $dim(sh)!`%`_dim.0)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:591.1-593.21
  rule vreplace_lane{C : context, sh : shape, i : laneidx}:
    `%|-%:%`(C, VREPLACE_LANE_instr(sh, i), `%->_%%`_instrtype(`%`_resulttype([V128_valtype ($unpackshape(sh) : numtype <: valtype)]), [], `%`_resulttype([V128_valtype])))
    -- if (i!`%`_laneidx.0 < $dim(sh)!`%`_dim.0)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:595.1-596.50
  rule vextunop{C : context, sh_1 : ishape, sh_2 : ishape, vextunop : vextunop__(sh_2, sh_1)}:
    `%|-%:%`(C, VEXTUNOP_instr(sh_1, sh_2, vextunop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:598.1-599.57
  rule vextbinop{C : context, sh_1 : ishape, sh_2 : ishape, vextbinop : vextbinop__(sh_2, sh_1)}:
    `%|-%:%`(C, VEXTBINOP_instr(sh_1, sh_2, vextbinop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:601.1-602.64
  rule vextternop{C : context, sh_1 : ishape, sh_2 : ishape, vextternop : vextternop__(sh_2, sh_1)}:
    `%|-%:%`(C, VEXTTERNOP_instr(sh_1, sh_2, vextternop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:604.1-605.48
  rule vnarrow{C : context, sh_1 : ishape, sh_2 : ishape, sx : sx}:
    `%|-%:%`(C, VNARROW_instr(sh_1, sh_2, sx), `%->_%%`_instrtype(`%`_resulttype([V128_valtype V128_valtype]), [], `%`_resulttype([V128_valtype])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:607.1-608.46
  rule vcvtop{C : context, sh_1 : shape, sh_2 : shape, vcvtop : vcvtop__(sh_2, sh_1)}:
    `%|-%:%`(C, VCVTOP_instr(sh_1, sh_2, vcvtop), `%->_%%`_instrtype(`%`_resulttype([V128_valtype]), [], `%`_resulttype([V128_valtype])))

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:6.1-6.96
relation Instrs_ok: `%|-%:%`(context, instr*, instrtype)
  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:613.1-614.24
  rule empty{C : context}:
    `%|-%:%`(C, [], `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([])))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:617.1-621.82
  rule seq{C : context, instr_1 : instr, `instr_2*` : instr*, `t_1*` : valtype*, `x_1*` : idx*, `x_2*` : idx*, `t_3*` : valtype*, `t_2*` : valtype*, `init*` : init*, `t*` : valtype*}:
    `%|-%:%`(C, [instr_1] ++ instr_2*{instr_2 <- `instr_2*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x_1*{x_1 <- `x_1*`} ++ x_2*{x_2 <- `x_2*`}, `%`_resulttype(t_3*{t_3 <- `t_3*`})))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x_1*{x_1 <- `x_1*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- (if (C.LOCALS_context[x_1!`%`_idx.0] = `%%`_localtype(init, t)))*{init <- `init*`, t <- `t*`, x_1 <- `x_1*`}
    -- Instrs_ok: `%|-%:%`($with_locals(C, x_1*{x_1 <- `x_1*`}, `%%`_localtype(SET_init, t)*{t <- `t*`}), instr_2*{instr_2 <- `instr_2*`}, `%->_%%`_instrtype(`%`_resulttype(t_2*{t_2 <- `t_2*`}), x_2*{x_2 <- `x_2*`}, `%`_resulttype(t_3*{t_3 <- `t_3*`})))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:623.1-627.33
  rule sub{C : context, `instr*` : instr*, it' : instrtype, it : instrtype}:
    `%|-%:%`(C, instr*{instr <- `instr*`}, it')
    -- Instrs_ok: `%|-%:%`(C, instr*{instr <- `instr*`}, it)
    -- Instrtype_sub: `%|-%<:%`(C, it, it')
    -- Instrtype_ok: `%|-%:OK`(C, it')

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec:630.1-633.33
  rule frame{C : context, `instr*` : instr*, `t*` : valtype*, `t_1*` : valtype*, `x*` : idx*, `t_2*` : valtype*}:
    `%|-%:%`(C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype(t*{t <- `t*`} ++ t_1*{t_1 <- `t_1*`}), x*{x <- `x*`}, `%`_resulttype(t*{t <- `t*`} ++ t_2*{t_2 <- `t_2*`})))
    -- Instrs_ok: `%|-%:%`(C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), x*{x <- `x*`}, `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Resulttype_ok: `%|-%:OK`(C, `%`_resulttype(t*{t <- `t*`}))
}

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule _{C : context, `instr*` : instr*, `t*` : valtype*}:
    `%|-%:%`(C, instr*{instr <- `instr*`}, `%`_resulttype(t*{t <- `t*`}))
    -- Instrs_ok: `%|-%:%`(C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype(t*{t <- `t*`})))

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
relation Nondefaultable: `|-%NONDEFAULTABLE`(valtype)
  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
  rule _{t : valtype}:
    `|-%NONDEFAULTABLE`(t)
    -- if ($default_(t) = ?())

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
relation Instr_const: `%|-%CONST`(context, instr)
  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule const{C : context, nt : numtype, c_nt : num_(nt)}:
    `%|-%CONST`(C, CONST_instr(nt, c_nt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule vconst{C : context, vt : vectype, c_vt : vec_(vt)}:
    `%|-%CONST`(C, VCONST_instr(vt, c_vt))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule ref.null{C : context, ht : heaptype}:
    `%|-%CONST`(C, REF.NULL_instr(ht))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule ref.i31{C : context}:
    `%|-%CONST`(C, REF.I31_instr)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule ref.func{C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule struct.new{C : context, x : idx}:
    `%|-%CONST`(C, STRUCT.NEW_instr(x))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule struct.new_default{C : context, x : idx}:
    `%|-%CONST`(C, STRUCT.NEW_DEFAULT_instr(x))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule array.new{C : context, x : idx}:
    `%|-%CONST`(C, ARRAY.NEW_instr(x))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule array.new_default{C : context, x : idx}:
    `%|-%CONST`(C, ARRAY.NEW_DEFAULT_instr(x))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule array.new_fixed{C : context, x : idx, n : n}:
    `%|-%CONST`(C, ARRAY.NEW_FIXED_instr(x, `%`_u32(n)))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule any.convert_extern{C : context}:
    `%|-%CONST`(C, ANY.CONVERT_EXTERN_instr)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule extern.convert_any{C : context}:
    `%|-%CONST`(C, EXTERN.CONVERT_ANY_instr)

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule global.get{C : context, x : idx, t : valtype}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBALS_context[x!`%`_idx.0] = `%%`_globaltype(?(), t))

  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule binop{C : context, Inn : Inn, binop : binop_((Inn : addrtype <: numtype))}:
    `%|-%CONST`(C, BINOP_instr((Inn : addrtype <: numtype), binop))
    -- if (Inn <- [I32_Inn I64_Inn])
    -- if (binop <- [ADD_binop_ SUB_binop_ MUL_binop_])

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
relation Expr_const: `%|-%CONST`(context, expr)
  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule _{C : context, `instr*` : instr*}:
    `%|-%CONST`(C, instr*{instr <- `instr*`})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr <- `instr*`}

;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; ../../../../specification/wasm-3.0/2.3-validation.instructions.spectec
  rule _{C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, `%`_resulttype([t]))
    -- Expr_const: `%|-%CONST`(C, expr)

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Type_ok: `%|-%:%`(context, type, deftype*)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule _{C : context, rectype : rectype, `dt*` : deftype*, x : idx}:
    `%|-%:%`(C, TYPE_type(rectype), dt*{dt <- `dt*`})
    -- if (x!`%`_idx.0 = |C.TYPES_context|)
    -- if (dt*{dt <- `dt*`} = $rolldt(x, rectype))
    -- Rectype_ok: `%|-%:%`(C +++ {TYPES dt*{dt <- `dt*`}, RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rectype, OK_oktypeidx(x))

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Tag_ok: `%|-%:%`(context, tag, tagtype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule _{C : context, tagtype : tagtype}:
    `%|-%:%`(C, TAG_tag(tagtype), $clos_tagtype(C, tagtype))
    -- Tagtype_ok: `%|-%:OK`(C, tagtype)

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule _{C : context, globaltype : globaltype, expr : expr, t : valtype}:
    `%|-%:%`(C, GLOBAL_global(globaltype, expr), globaltype)
    -- Globaltype_ok: `%|-%:OK`(C, globaltype)
    -- if (globaltype = `%%`_globaltype(MUT_mut?{}, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule _{C : context, memtype : memtype}:
    `%|-%:%`(C, MEMORY_mem(memtype), memtype)
    -- Memtype_ok: `%|-%:OK`(C, memtype)

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule _{C : context, tabletype : tabletype, expr : expr, at : addrtype, lim : limits, rt : reftype}:
    `%|-%:%`(C, TABLE_table(tabletype, expr), tabletype)
    -- Tabletype_ok: `%|-%:OK`(C, tabletype)
    -- if (tabletype = `%%%`_tabletype(at, lim, rt))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, (rt : reftype <: valtype))

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Local_ok: `%|-%:%`(context, local, localtype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule set{C : context, t : valtype}:
    `%|-%:%`(C, LOCAL_local(t), `%%`_localtype(SET_init, t))
    -- Defaultable: `|-%DEFAULTABLE`(t)

  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule unset{C : context, t : valtype}:
    `%|-%:%`(C, LOCAL_local(t), `%%`_localtype(UNSET_init, t))
    -- Nondefaultable: `|-%NONDEFAULTABLE`(t)

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Func_ok: `%|-%:%`(context, func, deftype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule _{C : context, x : idx, `local*` : local*, expr : expr, `t_1*` : valtype*, `t_2*` : valtype*, `lct*` : localtype*}:
    `%|-%:%`(C, FUNC_func(x, local*{local <- `local*`}, expr), C.TYPES_context[x!`%`_idx.0])
    -- Expand: `%~~%`(C.TYPES_context[x!`%`_idx.0], `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- (Local_ok: `%|-%:%`(C, local, lct))*{lct <- `lct*`, local <- `local*`}
    -- Expr_ok: `%|-%:%`(C +++ {TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS `%%`_localtype(SET_init, t_1)*{t_1 <- `t_1*`} ++ lct*{lct <- `lct*`}, LABELS [`%`_resulttype(t_2*{t_2 <- `t_2*`})], RETURN ?(`%`_resulttype(t_2*{t_2 <- `t_2*`})), REFS []}, expr, `%`_resulttype(t_2*{t_2 <- `t_2*`}))

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Datamode_ok: `%|-%:%`(context, datamode, datatype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule passive{C : context}:
    `%|-%:%`(C, PASSIVE_datamode, OK_datatype)

  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule active{C : context, x : idx, expr : expr, at : addrtype, lim : limits}:
    `%|-%:%`(C, ACTIVE_datamode(x, expr), OK_datatype)
    -- if (C.MEMS_context[x!`%`_idx.0] = `%%PAGE`_memtype(at, lim))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, (at : addrtype <: valtype))

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Data_ok: `%|-%:%`(context, data, datatype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule _{C : context, `b*` : byte*, datamode : datamode}:
    `%|-%:%`(C, DATA_data(b*{b <- `b*`}, datamode), OK_datatype)
    -- Datamode_ok: `%|-%:%`(C, datamode, OK_datatype)

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Elemmode_ok: `%|-%:%`(context, elemmode, elemtype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule passive{C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule declare{C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule active{C : context, x : idx, expr : expr, rt : reftype, at : addrtype, lim : limits, rt' : reftype}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (C.TABLES_context[x!`%`_idx.0] = `%%%`_tabletype(at, lim, rt'))
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, (at : addrtype <: valtype))

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Elem_ok: `%|-%:%`(context, elem, elemtype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule _{C : context, elemtype : elemtype, `expr*` : expr*, elemmode : elemmode}:
    `%|-%:%`(C, ELEM_elem(elemtype, expr*{expr <- `expr*`}, elemmode), elemtype)
    -- Reftype_ok: `%|-%:OK`(C, elemtype)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, (elemtype : reftype <: valtype)))*{expr <- `expr*`}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, elemtype)

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Start_ok: `%|-%:OK`(context, start)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule _{C : context, x : idx}:
    `%|-%:OK`(C, START_start(x))
    -- Expand: `%~~%`(C.FUNCS_context[x!`%`_idx.0], `FUNC%->%`_comptype(`%`_resulttype([]), `%`_resulttype([])))

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule _{C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT_import(name_1, name_2, xt), $clos_externtype(C, xt))
    -- Externtype_ok: `%|-%:OK`(C, xt)

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule tag{C : context, x : idx, jt : tagtype}:
    `%|-%:%`(C, TAG_externidx(x), TAG_externtype(jt))
    -- if (C.TAGS_context[x!`%`_idx.0] = jt)

  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule global{C : context, x : idx, gt : globaltype}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (C.GLOBALS_context[x!`%`_idx.0] = gt)

  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule mem{C : context, x : idx, mt : memtype}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (C.MEMS_context[x!`%`_idx.0] = mt)

  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule table{C : context, x : idx, tt : tabletype}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (C.TABLES_context[x!`%`_idx.0] = tt)

  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule func{C : context, x : idx, dt : deftype}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype((dt : deftype <: typeuse)))
    -- if (C.FUNCS_context[x!`%`_idx.0] = dt)

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Export_ok: `%|-%:%%`(context, export, name, externtype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule _{C : context, name : name, externidx : externidx, xt : externtype}:
    `%|-%:%%`(C, EXPORT_export(name, externidx), name, xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec:136.1-136.100
relation Globals_ok: `%|-%:%`(context, global*, globaltype*)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec:180.1-181.17
  rule empty{C : context}:
    `%|-%:%`(C, [], [])

  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec:183.1-186.54
  rule cons{C : context, global_1 : global, `global*` : global*, gt_1 : globaltype, `gt*` : globaltype*}:
    `%|-%:%`(C, [global_1] ++ global*{global <- `global*`}, [gt_1] ++ gt*{gt <- `gt*`})
    -- Global_ok: `%|-%:%`(C, global_1, gt_1)
    -- Globals_ok: `%|-%:%`(C +++ {TYPES [], RECS [], TAGS [], GLOBALS [gt_1], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, global*{global <- `global*`}, gt*{gt <- `gt*`})
}

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec:135.1-135.98
relation Types_ok: `%|-%:%`(context, type*, deftype*)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec:172.1-173.17
  rule empty{C : context}:
    `%|-%:%`(C, [], [])

  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec:175.1-178.49
  rule cons{C : context, type_1 : type, `type*` : type*, `dt_1*` : deftype*, `dt*` : deftype*}:
    `%|-%:%`(C, [type_1] ++ type*{type <- `type*`}, dt_1*{dt_1 <- `dt_1*`} ++ dt*{dt <- `dt*`})
    -- Type_ok: `%|-%:%`(C, type_1, dt_1*{dt_1 <- `dt_1*`})
    -- Types_ok: `%|-%:%`(C +++ {TYPES dt_1*{dt_1 <- `dt_1*`}, RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, type*{type <- `type*`}, dt*{dt <- `dt*`})
}

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
syntax nonfuncs = 
  | `%%%%`{`global*` : global*, `mem*` : mem*, `table*` : table*, `elem*` : elem*}(global*{global <- `global*`} : global*, mem*{mem <- `mem*`} : mem*, table*{table <- `table*`} : table*, elem*{elem <- `elem*`} : elem*)

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
def $funcidx_nonfuncs(nonfuncs : nonfuncs) : funcidx*
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  def $funcidx_nonfuncs{`global*` : global*, `mem*` : mem*, `table*` : table*, `elem*` : elem*}(`%%%%`_nonfuncs(global*{global <- `global*`}, mem*{mem <- `mem*`}, table*{table <- `table*`}, elem*{elem <- `elem*`})) = $funcidx_module(MODULE_module([], [], [], global*{global <- `global*`}, mem*{mem <- `mem*`}, table*{table <- `table*`}, [], [], elem*{elem <- `elem*`}, ?(), []))

;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
relation Module_ok: `|-%:%`(module, moduletype)
  ;; ../../../../specification/wasm-3.0/2.4-validation.modules.spectec
  rule _{`type*` : type*, `import*` : import*, `tag*` : tag*, `global*` : global*, `mem*` : mem*, `table*` : table*, `func*` : func*, `data*` : data*, `elem*` : elem*, `start?` : start?, `export*` : export*, C : context, `xt_I*` : externtype*, `xt_E*` : externtype*, `dt'*` : deftype*, C' : context, `jt*` : tagtype*, `gt*` : globaltype*, `mt*` : memtype*, `tt*` : tabletype*, `dt*` : deftype*, `ok*` : datatype*, `rt*` : reftype*, `nm*` : name*, `jt_I*` : tagtype*, `mt_I*` : memtype*, `tt_I*` : tabletype*, `gt_I*` : globaltype*, `dt_I*` : deftype*, `x*` : idx*}:
    `|-%:%`(MODULE_module(type*{type <- `type*`}, import*{import <- `import*`}, tag*{tag <- `tag*`}, global*{global <- `global*`}, mem*{mem <- `mem*`}, table*{table <- `table*`}, func*{func <- `func*`}, data*{data <- `data*`}, elem*{elem <- `elem*`}, start?{start <- `start?`}, export*{export <- `export*`}), $clos_moduletype(C, `%->%`_moduletype(xt_I*{xt_I <- `xt_I*`}, xt_E*{xt_E <- `xt_E*`})))
    -- Types_ok: `%|-%:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, type*{type <- `type*`}, dt'*{dt' <- `dt'*`})
    -- (Import_ok: `%|-%:%`({TYPES dt'*{dt' <- `dt'*`}, RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, import, xt_I))*{import <- `import*`, xt_I <- `xt_I*`}
    -- (Tag_ok: `%|-%:%`(C', tag, jt))*{jt <- `jt*`, tag <- `tag*`}
    -- Globals_ok: `%|-%:%`(C', global*{global <- `global*`}, gt*{gt <- `gt*`})
    -- (Mem_ok: `%|-%:%`(C', mem, mt))*{mem <- `mem*`, mt <- `mt*`}
    -- (Table_ok: `%|-%:%`(C', table, tt))*{table <- `table*`, tt <- `tt*`}
    -- (Func_ok: `%|-%:%`(C, func, dt))*{dt <- `dt*`, func <- `func*`}
    -- (Data_ok: `%|-%:%`(C, data, ok))*{data <- `data*`, ok <- `ok*`}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem <- `elem*`, rt <- `rt*`}
    -- (Start_ok: `%|-%:OK`(C, start))?{start <- `start?`}
    -- (Export_ok: `%|-%:%%`(C, export, nm, xt_E))*{export <- `export*`, nm <- `nm*`, xt_E <- `xt_E*`}
    -- if $disjoint_(syntax name, nm*{nm <- `nm*`})
    -- if (C = C' +++ {TYPES [], RECS [], TAGS jt_I*{jt_I <- `jt_I*`} ++ jt*{jt <- `jt*`}, GLOBALS gt*{gt <- `gt*`}, MEMS mt_I*{mt_I <- `mt_I*`} ++ mt*{mt <- `mt*`}, TABLES tt_I*{tt_I <- `tt_I*`} ++ tt*{tt <- `tt*`}, FUNCS [], DATAS ok*{ok <- `ok*`}, ELEMS rt*{rt <- `rt*`}, LOCALS [], LABELS [], RETURN ?(), REFS []})
    -- if (C' = {TYPES dt'*{dt' <- `dt'*`}, RECS [], TAGS [], GLOBALS gt_I*{gt_I <- `gt_I*`}, MEMS [], TABLES [], FUNCS dt_I*{dt_I <- `dt_I*`} ++ dt*{dt <- `dt*`}, DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS x*{x <- `x*`}})
    -- if (x*{x <- `x*`} = $funcidx_nonfuncs(`%%%%`_nonfuncs(global*{global <- `global*`}, mem*{mem <- `mem*`}, table*{table <- `table*`}, elem*{elem <- `elem*`})))
    -- if (jt_I*{jt_I <- `jt_I*`} = $tagsxt(xt_I*{xt_I <- `xt_I*`}))
    -- if (gt_I*{gt_I <- `gt_I*`} = $globalsxt(xt_I*{xt_I <- `xt_I*`}))
    -- if (mt_I*{mt_I <- `mt_I*`} = $memsxt(xt_I*{xt_I <- `xt_I*`}))
    -- if (tt_I*{tt_I <- `tt_I*`} = $tablesxt(xt_I*{xt_I <- `xt_I*`}))
    -- if (dt_I*{dt_I <- `dt_I*`} = $funcsxt(xt_I*{xt_I <- `xt_I*`}))

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
syntax relaxed2 = 
  | `%`{i : nat}(i : nat)
    -- if ((i = 0) \/ (i = 1))

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
syntax relaxed4 = 
  | `%`{i : nat}(i : nat)
    -- if ((((i = 0) \/ (i = 1)) \/ (i = 2)) \/ (i = 3))

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
def $relaxed2(relaxed2 : relaxed2, syntax X, X : X, X : X) : X
  ;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
  def $relaxed2{i : relaxed2, syntax X, X_1 : X, X_2 : X}(i, syntax X, X_1, X_2) = (if $ND then [X_1 X_2][i!`%`_relaxed2.0] else [X_1 X_2][0])

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
def $relaxed4(relaxed4 : relaxed4, syntax X, X : X, X : X, X : X, X : X) : X
  ;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
  def $relaxed4{i : relaxed4, syntax X, X_1 : X, X_2 : X, X_3 : X, X_4 : X}(i, syntax X, X_1, X_2, X_3, X_4) = (if $ND then [X_1 X_2 X_3 X_4][i!`%`_relaxed4.0] else [X_1 X_2 X_3 X_4][0])

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
def $R_fmadd : relaxed2

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
def $R_fmin : relaxed4

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
def $R_fmax : relaxed4

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
def $R_idot : relaxed2

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
def $R_iq15mulr : relaxed2

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
def $R_trunc_u : relaxed4

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
def $R_trunc_s : relaxed2

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
def $R_swizzle : relaxed2

;; ../../../../specification/wasm-3.0/3.0-numerics.relaxed.spectec
def $R_laneselect : relaxed2

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $s33_to_u32(s33 : s33) : u32

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ibits_(N : N, iN : iN(N)) : bit*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fbits_(N : N, fN : fN(N)) : bit*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ibytes_(N : N, iN : iN(N)) : byte*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fbytes_(N : N, fN : fN(N)) : byte*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $nbytes_(numtype : numtype, num_ : num_(numtype)) : byte*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $vbytes_(vectype : vectype, vec_ : vec_(vectype)) : byte*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $zbytes_(storagetype : storagetype, lit_ : lit_(storagetype)) : byte*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $cbytes_(Cnn : Cnn, lit_ : lit_((Cnn : Cnn <: storagetype))) : byte*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $inv_ibits_(N : N, bit*) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $inv_fbits_(N : N, bit*) : fN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $inv_ibytes_(N : N, byte*) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $inv_fbytes_(N : N, byte*) : fN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $inv_nbytes_(numtype : numtype, byte*) : num_(numtype)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $inv_vbytes_(vectype : vectype, byte*) : vec_(vectype)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $inv_zbytes_(storagetype : storagetype, byte*) : lit_(storagetype)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $inv_cbytes_(Cnn : Cnn, byte*) : lit_((Cnn : Cnn <: storagetype))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $signed_(N : N, nat : nat) : int
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $signed_{N : N, i : nat}(N, i) = (i : nat <:> int)
    -- if (i < (2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $signed_{N : N, i : nat}(N, i) = ((i : nat <:> int) - ((2 ^ N) : nat <:> int))
    -- if (((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) <= i) /\ (i < (2 ^ N)))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $inv_signed_(N : N, int : int) : nat
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $inv_signed_{N : N, i : int}(N, i) = (i : int <:> nat)
    -- if (((0 : nat <:> int) <= i) /\ (i < ((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int)))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $inv_signed_{N : N, i : int}(N, i) = ((i + ((2 ^ N) : nat <:> int)) : int <:> nat)
    -- if ((- ((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int) <= i) /\ (i < (0 : nat <:> int)))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $sx(storagetype : storagetype) : sx?
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $sx{consttype : consttype}((consttype : consttype <: storagetype)) = ?()
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $sx{packtype : packtype}((packtype : packtype <: storagetype)) = ?(S_sx)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $zero(lanetype : lanetype) : lane_(lanetype)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $zero{Jnn : Jnn}((Jnn : Jnn <: lanetype)) = `%`_lane_(0)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $zero{Fnn : Fnn}((Fnn : Fnn <: lanetype)) = $fzero($size((Fnn : Fnn <: numtype)))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $bool(bool : bool) : nat
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $bool(false) = 0
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $bool(true) = 1

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $truncz(rat : rat) : int

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ceilz(rat : rat) : int

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $sat_u_(N : N, int : int) : nat
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $sat_u_{N : N, i : int}(N, i) = (if (i < (0 : nat <:> int)) then 0 else (if (i > (((2 ^ N) : nat <:> int) - (1 : nat <:> int))) then ((((2 ^ N) : nat <:> int) - (1 : nat <:> int)) : int <:> nat) else (i : int <:> nat)))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $sat_s_(N : N, int : int) : int
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $sat_s_{N : N, i : int}(N, i) = (if (i < - ((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int)) then - ((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int) else (if (i > (((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int) - (1 : nat <:> int))) then (((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int) - (1 : nat <:> int)) else i))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ineg_(N : N, iN : iN(N)) : iN(N)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $ineg_{N : N, i_1 : iN(N)}(N, i_1) = `%`_iN((((((2 ^ N) : nat <:> int) - (i_1!`%`_iN.0 : nat <:> int)) \ ((2 ^ N) : nat <:> int)) : int <:> nat))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $iabs_(N : N, iN : iN(N)) : iN(N)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $iabs_{N : N, i_1 : iN(N)}(N, i_1) = (if ($signed_(N, i_1!`%`_iN.0) >= (0 : nat <:> int)) then i_1 else $ineg_(N, i_1))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $iclz_(N : N, iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ictz_(N : N, iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ipopcnt_(N : N, iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $iextend_(N : N, M : M, sx : sx, iN : iN(N)) : iN(N)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $iextend_{N : N, M : M, i : iN(N)}(N, M, U_sx, i) = `%`_iN((i!`%`_iN.0 \ (2 ^ M)))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $iextend_{N : N, M : M, i : iN(N)}(N, M, S_sx, i) = `%`_iN($inv_signed_(N, $signed_(M, (i!`%`_iN.0 \ (2 ^ M)))))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $iadd_(N : N, iN : iN(N), iN : iN(N)) : iN(N)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $iadd_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, i_1, i_2) = `%`_iN(((i_1!`%`_iN.0 + i_2!`%`_iN.0) \ (2 ^ N)))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $isub_(N : N, iN : iN(N), iN : iN(N)) : iN(N)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $isub_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, i_1, i_2) = `%`_iN(((((((2 ^ N) + i_1!`%`_iN.0) : nat <:> int) - (i_2!`%`_iN.0 : nat <:> int)) \ ((2 ^ N) : nat <:> int)) : int <:> nat))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $imul_(N : N, iN : iN(N), iN : iN(N)) : iN(N)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $imul_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, i_1, i_2) = `%`_iN(((i_1!`%`_iN.0 * i_2!`%`_iN.0) \ (2 ^ N)))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $idiv_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)?
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $idiv_{N : N, i_1 : iN(N)}(N, U_sx, i_1, `%`_iN(0)) = ?()
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $idiv_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, U_sx, i_1, i_2) = ?(`%`_iN(($truncz(((i_1!`%`_iN.0 : nat <:> rat) / (i_2!`%`_iN.0 : nat <:> rat))) : int <:> nat)))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $idiv_{N : N, i_1 : iN(N)}(N, S_sx, i_1, `%`_iN(0)) = ?()
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $idiv_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, S_sx, i_1, i_2) = ?()
    -- if ((($signed_(N, i_1!`%`_iN.0) : int <:> rat) / ($signed_(N, i_2!`%`_iN.0) : int <:> rat)) = ((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> rat))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $idiv_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, S_sx, i_1, i_2) = ?(`%`_iN($inv_signed_(N, $truncz((($signed_(N, i_1!`%`_iN.0) : int <:> rat) / ($signed_(N, i_2!`%`_iN.0) : int <:> rat))))))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $irem_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)?
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $irem_{N : N, i_1 : iN(N)}(N, U_sx, i_1, `%`_iN(0)) = ?()
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $irem_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, U_sx, i_1, i_2) = ?(`%`_iN((((i_1!`%`_iN.0 : nat <:> int) - ((i_2!`%`_iN.0 * ($truncz(((i_1!`%`_iN.0 : nat <:> rat) / (i_2!`%`_iN.0 : nat <:> rat))) : int <:> nat)) : nat <:> int)) : int <:> nat)))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $irem_{N : N, i_1 : iN(N)}(N, S_sx, i_1, `%`_iN(0)) = ?()
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $irem_{N : N, i_1 : iN(N), i_2 : iN(N), j_1 : int, j_2 : int}(N, S_sx, i_1, i_2) = ?(`%`_iN($inv_signed_(N, (j_1 - (j_2 * $truncz(((j_1 : int <:> rat) / (j_2 : int <:> rat))))))))
    -- if ((j_1 = $signed_(N, i_1!`%`_iN.0)) /\ (j_2 = $signed_(N, i_2!`%`_iN.0)))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $imin_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $imin_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, U_sx, i_1, i_2) = i_1
    -- if (i_1!`%`_iN.0 <= i_2!`%`_iN.0)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $imin_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, U_sx, i_1, i_2) = i_2
    -- if (i_1!`%`_iN.0 > i_2!`%`_iN.0)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $imin_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, S_sx, i_1, i_2) = (if ($signed_(N, i_1!`%`_iN.0) <= $signed_(N, i_2!`%`_iN.0)) then i_1 else i_2)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $imax_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $imax_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, U_sx, i_1, i_2) = i_1
    -- if (i_1!`%`_iN.0 >= i_2!`%`_iN.0)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $imax_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, U_sx, i_1, i_2) = i_2
    -- if (i_1!`%`_iN.0 < i_2!`%`_iN.0)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $imax_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, S_sx, i_1, i_2) = (if ($signed_(N, i_1!`%`_iN.0) >= $signed_(N, i_2!`%`_iN.0)) then i_1 else i_2)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $iadd_sat_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $iadd_sat_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, U_sx, i_1, i_2) = `%`_iN($sat_u_(N, ((i_1!`%`_iN.0 + i_2!`%`_iN.0) : nat <:> int)))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $iadd_sat_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, S_sx, i_1, i_2) = `%`_iN($inv_signed_(N, $sat_s_(N, ($signed_(N, i_1!`%`_iN.0) + $signed_(N, i_2!`%`_iN.0)))))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $isub_sat_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $isub_sat_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, U_sx, i_1, i_2) = `%`_iN($sat_u_(N, ((i_1!`%`_iN.0 : nat <:> int) - (i_2!`%`_iN.0 : nat <:> int))))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $isub_sat_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, S_sx, i_1, i_2) = `%`_iN($inv_signed_(N, $sat_s_(N, ($signed_(N, i_1!`%`_iN.0) - $signed_(N, i_2!`%`_iN.0)))))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $iq15mulr_sat_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $irelaxed_q15mulr_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $iavgr_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $inot_(N : N, iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $irev_(N : N, iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $iand_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $iandnot_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ior_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ixor_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ishl_(N : N, iN : iN(N), u32 : u32) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ishr_(N : N, sx : sx, iN : iN(N), u32 : u32) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $irotl_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $irotr_(N : N, iN : iN(N), iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ibitselect_(N : N, iN : iN(N), iN : iN(N), iN : iN(N)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $irelaxed_laneselect_(N : N, iN : iN(N), iN : iN(N), iN : iN(N)) : iN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ieqz_(N : N, iN : iN(N)) : u32
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $ieqz_{N : N, i_1 : iN(N)}(N, i_1) = `%`_u32($bool((i_1!`%`_iN.0 = 0)))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $inez_(N : N, iN : iN(N)) : u32
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $inez_{N : N, i_1 : iN(N)}(N, i_1) = `%`_u32($bool((i_1!`%`_iN.0 =/= 0)))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ieq_(N : N, iN : iN(N), iN : iN(N)) : u32
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $ieq_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, i_1, i_2) = `%`_u32($bool((i_1 = i_2)))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ine_(N : N, iN : iN(N), iN : iN(N)) : u32
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $ine_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, i_1, i_2) = `%`_u32($bool((i_1 =/= i_2)))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ilt_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $ilt_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, U_sx, i_1, i_2) = `%`_u32($bool((i_1!`%`_iN.0 < i_2!`%`_iN.0)))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $ilt_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, S_sx, i_1, i_2) = `%`_u32($bool(($signed_(N, i_1!`%`_iN.0) < $signed_(N, i_2!`%`_iN.0))))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $igt_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $igt_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, U_sx, i_1, i_2) = `%`_u32($bool((i_1!`%`_iN.0 > i_2!`%`_iN.0)))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $igt_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, S_sx, i_1, i_2) = `%`_u32($bool(($signed_(N, i_1!`%`_iN.0) > $signed_(N, i_2!`%`_iN.0))))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ile_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $ile_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, U_sx, i_1, i_2) = `%`_u32($bool((i_1!`%`_iN.0 <= i_2!`%`_iN.0)))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $ile_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, S_sx, i_1, i_2) = `%`_u32($bool(($signed_(N, i_1!`%`_iN.0) <= $signed_(N, i_2!`%`_iN.0))))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ige_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $ige_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, U_sx, i_1, i_2) = `%`_u32($bool((i_1!`%`_iN.0 >= i_2!`%`_iN.0)))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $ige_{N : N, i_1 : iN(N), i_2 : iN(N)}(N, S_sx, i_1, i_2) = `%`_u32($bool(($signed_(N, i_1!`%`_iN.0) >= $signed_(N, i_2!`%`_iN.0))))

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fabs_(N : N, fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fneg_(N : N, fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fsqrt_(N : N, fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fceil_(N : N, fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ffloor_(N : N, fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $ftrunc_(N : N, fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fnearest_(N : N, fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fadd_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fsub_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fmul_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fdiv_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fmin_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fmax_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fpmin_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fpmax_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $frelaxed_min_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $frelaxed_max_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fcopysign_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $feq_(N : N, fN : fN(N), fN : fN(N)) : u32

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fne_(N : N, fN : fN(N), fN : fN(N)) : u32

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $flt_(N : N, fN : fN(N), fN : fN(N)) : u32

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fgt_(N : N, fN : fN(N), fN : fN(N)) : u32

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fle_(N : N, fN : fN(N), fN : fN(N)) : u32

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $fge_(N : N, fN : fN(N), fN : fN(N)) : u32

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $frelaxed_madd_(N : N, fN : fN(N), fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $frelaxed_nmadd_(N : N, fN : fN(N), fN : fN(N), fN : fN(N)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $wrap__(M : M, N : N, iN : iN(M)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $extend__(M : M, N : N, sx : sx, iN : iN(M)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $trunc__(M : M, N : N, sx : sx, fN : fN(M)) : iN(N)?

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $trunc_sat__(M : M, N : N, sx : sx, fN : fN(M)) : iN(N)?

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $relaxed_trunc__(M : M, N : N, sx : sx, fN : fN(M)) : iN(N)?

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $demote__(M : M, N : N, fN : fN(M)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $promote__(M : M, N : N, fN : fN(M)) : fN(N)*

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $convert__(M : M, N : N, sx : sx, iN : iN(M)) : fN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $narrow__(M : M, N : N, sx : sx, iN : iN(M)) : iN(N)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $reinterpret__(numtype_1 : numtype, numtype_2 : numtype, num_ : num_(numtype_1)) : num_(numtype_2)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $lpacknum_(lanetype : lanetype, num_ : num_($lunpack(lanetype))) : lane_(lanetype)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $lpacknum_{numtype : numtype, c : num_($lunpack((numtype : numtype <: lanetype)))}((numtype : numtype <: lanetype), c) = c
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $lpacknum_{packtype : packtype, c : num_($lunpack((packtype : packtype <: lanetype)))}((packtype : packtype <: lanetype), c) = $wrap__($size($lunpack((packtype : packtype <: lanetype))), $psize(packtype), c)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $cpacknum_(storagetype : storagetype, lit_ : lit_(($cunpack(storagetype) : consttype <: storagetype))) : lit_(storagetype)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cpacknum_{consttype : consttype, c : lit_(($cunpack((consttype : consttype <: storagetype)) : consttype <: storagetype))}((consttype : consttype <: storagetype), c) = c
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cpacknum_{packtype : packtype, c : lit_(($cunpack((packtype : packtype <: storagetype)) : consttype <: storagetype))}((packtype : packtype <: storagetype), c) = $wrap__($size($lunpack((packtype : packtype <: lanetype))), $psize(packtype), c)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $lunpacknum_(lanetype : lanetype, lane_ : lane_(lanetype)) : num_($lunpack(lanetype))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $lunpacknum_{numtype : numtype, c : lane_((numtype : numtype <: lanetype))}((numtype : numtype <: lanetype), c) = c
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $lunpacknum_{packtype : packtype, c : lane_((packtype : packtype <: lanetype))}((packtype : packtype <: lanetype), c) = $extend__($psize(packtype), $size($lunpack((packtype : packtype <: lanetype))), U_sx, c)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $cunpacknum_(storagetype : storagetype, lit_ : lit_(storagetype)) : lit_(($cunpack(storagetype) : consttype <: storagetype))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cunpacknum_{consttype : consttype, c : lit_((consttype : consttype <: storagetype))}((consttype : consttype <: storagetype), c) = c
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cunpacknum_{packtype : packtype, c : lit_((packtype : packtype <: storagetype))}((packtype : packtype <: storagetype), c) = $extend__($psize(packtype), $size($lunpack((packtype : packtype <: lanetype))), U_sx, c)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $unop_(numtype : numtype, unop_ : unop_(numtype), num_ : num_(numtype)) : num_(numtype)*
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $unop_{Inn : Inn, i : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), CLZ_unop_, i) = [$iclz_($sizenn((Inn : addrtype <: numtype)), i)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $unop_{Inn : Inn, i : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), CTZ_unop_, i) = [$ictz_($sizenn((Inn : addrtype <: numtype)), i)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $unop_{Inn : Inn, i : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), POPCNT_unop_, i) = [$ipopcnt_($sizenn((Inn : addrtype <: numtype)), i)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $unop_{Inn : Inn, M : M, i : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), EXTEND_unop_(`%`_sz(M)), i) = [$iextend_($sizenn((Inn : addrtype <: numtype)), M, S_sx, i)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $unop_{Fnn : Fnn, f : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), ABS_unop_, f) = $fabs_($sizenn((Fnn : Fnn <: numtype)), f)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $unop_{Fnn : Fnn, f : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), NEG_unop_, f) = $fneg_($sizenn((Fnn : Fnn <: numtype)), f)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $unop_{Fnn : Fnn, f : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), SQRT_unop_, f) = $fsqrt_($sizenn((Fnn : Fnn <: numtype)), f)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $unop_{Fnn : Fnn, f : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), CEIL_unop_, f) = $fceil_($sizenn((Fnn : Fnn <: numtype)), f)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $unop_{Fnn : Fnn, f : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), FLOOR_unop_, f) = $ffloor_($sizenn((Fnn : Fnn <: numtype)), f)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $unop_{Fnn : Fnn, f : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), TRUNC_unop_, f) = $ftrunc_($sizenn((Fnn : Fnn <: numtype)), f)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $unop_{Fnn : Fnn, f : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), NEAREST_unop_, f) = $fnearest_($sizenn((Fnn : Fnn <: numtype)), f)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $binop_(numtype : numtype, binop_ : binop_(numtype), num_ : num_(numtype), num_ : num_(numtype)) : num_(numtype)*
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Inn : Inn, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), ADD_binop_, i_1, i_2) = [$iadd_($sizenn((Inn : addrtype <: numtype)), i_1, i_2)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Inn : Inn, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), SUB_binop_, i_1, i_2) = [$isub_($sizenn((Inn : addrtype <: numtype)), i_1, i_2)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Inn : Inn, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), MUL_binop_, i_1, i_2) = [$imul_($sizenn((Inn : addrtype <: numtype)), i_1, i_2)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Inn : Inn, sx : sx, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), DIV_binop_(sx), i_1, i_2) = lift($idiv_($sizenn((Inn : addrtype <: numtype)), sx, i_1, i_2))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Inn : Inn, sx : sx, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), REM_binop_(sx), i_1, i_2) = lift($irem_($sizenn((Inn : addrtype <: numtype)), sx, i_1, i_2))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Inn : Inn, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), AND_binop_, i_1, i_2) = [$iand_($sizenn((Inn : addrtype <: numtype)), i_1, i_2)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Inn : Inn, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), OR_binop_, i_1, i_2) = [$ior_($sizenn((Inn : addrtype <: numtype)), i_1, i_2)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Inn : Inn, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), XOR_binop_, i_1, i_2) = [$ixor_($sizenn((Inn : addrtype <: numtype)), i_1, i_2)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Inn : Inn, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), SHL_binop_, i_1, i_2) = [$ishl_($sizenn((Inn : addrtype <: numtype)), i_1, `%`_u32(i_2!`%`_num_.0))]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Inn : Inn, sx : sx, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), SHR_binop_(sx), i_1, i_2) = [$ishr_($sizenn((Inn : addrtype <: numtype)), sx, i_1, `%`_u32(i_2!`%`_num_.0))]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Inn : Inn, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), ROTL_binop_, i_1, i_2) = [$irotl_($sizenn((Inn : addrtype <: numtype)), i_1, i_2)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Inn : Inn, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), ROTR_binop_, i_1, i_2) = [$irotr_($sizenn((Inn : addrtype <: numtype)), i_1, i_2)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), ADD_binop_, f_1, f_2) = $fadd_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), SUB_binop_, f_1, f_2) = $fsub_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), MUL_binop_, f_1, f_2) = $fmul_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), DIV_binop_, f_1, f_2) = $fdiv_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), MIN_binop_, f_1, f_2) = $fmin_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), MAX_binop_, f_1, f_2) = $fmax_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $binop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), COPYSIGN_binop_, f_1, f_2) = $fcopysign_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $testop_(numtype : numtype, testop_ : testop_(numtype), num_ : num_(numtype)) : u32
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $testop_{Inn : Inn, i : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), EQZ_testop_, i) = $ieqz_($sizenn((Inn : addrtype <: numtype)), i)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $relop_(numtype : numtype, relop_ : relop_(numtype), num_ : num_(numtype), num_ : num_(numtype)) : u32
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $relop_{Inn : Inn, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), EQ_relop_, i_1, i_2) = $ieq_($sizenn((Inn : addrtype <: numtype)), i_1, i_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $relop_{Inn : Inn, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), NE_relop_, i_1, i_2) = $ine_($sizenn((Inn : addrtype <: numtype)), i_1, i_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $relop_{Inn : Inn, sx : sx, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), LT_relop_(sx), i_1, i_2) = $ilt_($sizenn((Inn : addrtype <: numtype)), sx, i_1, i_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $relop_{Inn : Inn, sx : sx, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), GT_relop_(sx), i_1, i_2) = $igt_($sizenn((Inn : addrtype <: numtype)), sx, i_1, i_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $relop_{Inn : Inn, sx : sx, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), LE_relop_(sx), i_1, i_2) = $ile_($sizenn((Inn : addrtype <: numtype)), sx, i_1, i_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $relop_{Inn : Inn, sx : sx, i_1 : num_((Inn : addrtype <: numtype)), i_2 : num_((Inn : addrtype <: numtype))}((Inn : addrtype <: numtype), GE_relop_(sx), i_1, i_2) = $ige_($sizenn((Inn : addrtype <: numtype)), sx, i_1, i_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $relop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), EQ_relop_, f_1, f_2) = $feq_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $relop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), NE_relop_, f_1, f_2) = $fne_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $relop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), LT_relop_, f_1, f_2) = $flt_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $relop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), GT_relop_, f_1, f_2) = $fgt_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $relop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), LE_relop_, f_1, f_2) = $fle_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $relop_{Fnn : Fnn, f_1 : num_((Fnn : Fnn <: numtype)), f_2 : num_((Fnn : Fnn <: numtype))}((Fnn : Fnn <: numtype), GE_relop_, f_1, f_2) = $fge_($sizenn((Fnn : Fnn <: numtype)), f_1, f_2)

;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
def $cvtop__(numtype_1 : numtype, numtype_2 : numtype, cvtop__ : cvtop__(numtype_1, numtype_2), num_ : num_(numtype_1)) : num_(numtype_2)*
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cvtop__{Inn_1 : Inn, Inn_2 : Inn, sx : sx, i_1 : num_((Inn_1 : addrtype <: numtype))}((Inn_1 : addrtype <: numtype), (Inn_2 : addrtype <: numtype), EXTEND_cvtop__(sx), i_1) = [$extend__($sizenn1((Inn_1 : addrtype <: numtype)), $sizenn2((Inn_2 : addrtype <: numtype)), sx, i_1)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cvtop__{Inn_1 : Inn, Inn_2 : Inn, i_1 : num_((Inn_1 : addrtype <: numtype))}((Inn_1 : addrtype <: numtype), (Inn_2 : addrtype <: numtype), WRAP_cvtop__, i_1) = [$wrap__($sizenn1((Inn_1 : addrtype <: numtype)), $sizenn2((Inn_2 : addrtype <: numtype)), i_1)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cvtop__{Fnn_1 : Fnn, Inn_2 : Inn, sx : sx, f_1 : num_((Fnn_1 : Fnn <: numtype))}((Fnn_1 : Fnn <: numtype), (Inn_2 : addrtype <: numtype), TRUNC_cvtop__(sx), f_1) = lift($trunc__($sizenn1((Fnn_1 : Fnn <: numtype)), $sizenn2((Inn_2 : addrtype <: numtype)), sx, f_1))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cvtop__{Fnn_1 : Fnn, Inn_2 : Inn, sx : sx, f_1 : num_((Fnn_1 : Fnn <: numtype))}((Fnn_1 : Fnn <: numtype), (Inn_2 : addrtype <: numtype), TRUNC_SAT_cvtop__(sx), f_1) = lift($trunc_sat__($sizenn1((Fnn_1 : Fnn <: numtype)), $sizenn2((Inn_2 : addrtype <: numtype)), sx, f_1))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cvtop__{Inn_1 : Inn, Fnn_2 : Fnn, sx : sx, i_1 : num_((Inn_1 : addrtype <: numtype))}((Inn_1 : addrtype <: numtype), (Fnn_2 : Fnn <: numtype), CONVERT_cvtop__(sx), i_1) = [$convert__($sizenn1((Inn_1 : addrtype <: numtype)), $sizenn2((Fnn_2 : Fnn <: numtype)), sx, i_1)]
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cvtop__{Fnn_1 : Fnn, Fnn_2 : Fnn, f_1 : num_((Fnn_1 : Fnn <: numtype))}((Fnn_1 : Fnn <: numtype), (Fnn_2 : Fnn <: numtype), PROMOTE_cvtop__, f_1) = $promote__($sizenn1((Fnn_1 : Fnn <: numtype)), $sizenn2((Fnn_2 : Fnn <: numtype)), f_1)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cvtop__{Fnn_1 : Fnn, Fnn_2 : Fnn, f_1 : num_((Fnn_1 : Fnn <: numtype))}((Fnn_1 : Fnn <: numtype), (Fnn_2 : Fnn <: numtype), DEMOTE_cvtop__, f_1) = $demote__($sizenn1((Fnn_1 : Fnn <: numtype)), $sizenn2((Fnn_2 : Fnn <: numtype)), f_1)
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cvtop__{Inn_1 : Inn, Fnn_2 : Fnn, i_1 : num_((Inn_1 : addrtype <: numtype))}((Inn_1 : addrtype <: numtype), (Fnn_2 : Fnn <: numtype), REINTERPRET_cvtop__, i_1) = [$reinterpret__((Inn_1 : addrtype <: numtype), (Fnn_2 : Fnn <: numtype), i_1)]
    -- if ($size((Inn_1 : addrtype <: numtype)) = $size((Fnn_2 : Fnn <: numtype)))
  ;; ../../../../specification/wasm-3.0/3.1-numerics.scalar.spectec
  def $cvtop__{Fnn_1 : Fnn, Inn_2 : Inn, f_1 : num_((Fnn_1 : Fnn <: numtype))}((Fnn_1 : Fnn <: numtype), (Inn_2 : addrtype <: numtype), REINTERPRET_cvtop__, f_1) = [$reinterpret__((Fnn_1 : Fnn <: numtype), (Inn_2 : addrtype <: numtype), f_1)]
    -- if ($size((Fnn_1 : Fnn <: numtype)) = $size((Inn_2 : addrtype <: numtype)))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $lanes_(shape : shape, vec_ : vec_(V128_Vnn)) : lane_($lanetype(shape))*

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $inv_lanes_(shape : shape, lane_($lanetype(shape))*) : vec_(V128_Vnn)

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $zeroop(shape_1 : shape, shape_2 : shape, vcvtop__ : vcvtop__(shape_1, shape_2)) : zero?
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $zeroop{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, half : half, sx : sx}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), EXTEND_vcvtop__(half, sx)) = ?()
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $zeroop{Jnn_1 : Jnn, M_1 : M, Fnn_2 : Fnn, M_2 : M, `half?` : half?, sx : sx}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), CONVERT_vcvtop__(half?{half <- `half?`}, sx)) = ?()
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $zeroop{Fnn_1 : Fnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, sx : sx, `zero?` : zero?}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), TRUNC_SAT_vcvtop__(sx, zero?{zero <- `zero?`})) = zero?{zero <- `zero?`}
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $zeroop{Fnn_1 : Fnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, sx : sx, `zero?` : zero?}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), RELAXED_TRUNC_vcvtop__(sx, zero?{zero <- `zero?`})) = zero?{zero <- `zero?`}
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $zeroop{Fnn_1 : Fnn, M_1 : M, Fnn_2 : Fnn, M_2 : M, zero : zero}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), DEMOTE_vcvtop__(zero)) = ?(zero)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $zeroop{Fnn_1 : Fnn, M_1 : M, Fnn_2 : Fnn, M_2 : M}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), `PROMOTELOW`_vcvtop__) = ?()

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $halfop(shape_1 : shape, shape_2 : shape, vcvtop__ : vcvtop__(shape_1, shape_2)) : half?
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $halfop{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, half : half, sx : sx}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), EXTEND_vcvtop__(half, sx)) = ?(half)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $halfop{Jnn_1 : Jnn, M_1 : M, Fnn_2 : Fnn, M_2 : M, `half?` : half?, sx : sx}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), CONVERT_vcvtop__(half?{half <- `half?`}, sx)) = half?{half <- `half?`}
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $halfop{Fnn_1 : Fnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, sx : sx, `zero?` : zero?}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), TRUNC_SAT_vcvtop__(sx, zero?{zero <- `zero?`})) = ?()
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $halfop{Fnn_1 : Fnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, sx : sx, `zero?` : zero?}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), RELAXED_TRUNC_vcvtop__(sx, zero?{zero <- `zero?`})) = ?()
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $halfop{Fnn_1 : Fnn, M_1 : M, Fnn_2 : Fnn, M_2 : M, zero : zero}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), DEMOTE_vcvtop__(zero)) = ?()
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $halfop{Fnn_1 : Fnn, M_1 : M, Fnn_2 : Fnn, M_2 : M}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), `PROMOTELOW`_vcvtop__) = ?(LOW_half)

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $half(half : half, nat : nat, nat : nat) : nat
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $half{i : nat, j : nat}(LOW_half, i, j) = i
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $half{i : nat, j : nat}(HIGH_half, i, j) = j

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $iswizzle_lane_(N : N, iN(N)*, iN : iN(N)) : iN(N)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $iswizzle_lane_{N : N, `c*` : iN(N)*, i : iN(N)}(N, c*{c <- `c*`}, i) = (if (i!`%`_iN.0 < |c*{c <- `c*`}|) then c*{c <- `c*`}[i!`%`_iN.0] else `%`_iN(0))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $irelaxed_swizzle_lane_(N : N, iN(N)*, iN : iN(N)) : iN(N)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $irelaxed_swizzle_lane_{N : N, `c*` : iN(N)*, i : iN(N)}(N, c*{c <- `c*`}, i) = (if (i!`%`_iN.0 < |c*{c <- `c*`}|) then c*{c <- `c*`}[i!`%`_iN.0] else (if ($signed_(N, i!`%`_iN.0) < (0 : nat <:> int)) then `%`_iN(0) else $relaxed2($R_swizzle, syntax iN(N), `%`_iN(0), c*{c <- `c*`}[(i!`%`_iN.0 \ |c*{c <- `c*`}|)])))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivunop_(shape : shape, def $f_(N : N, iN : iN(N)) : iN(N), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivunop_{Jnn : Jnn, M : M, def $f_(N : N, iN : iN(N)) : iN(N), v_1 : vec_(V128_Vnn), `c*` : iN($lsizenn((Jnn : Jnn <: lanetype)))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, v_1) = [$inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})]
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c*{c <- `c*`} = $f_($lsizenn((Jnn : Jnn <: lanetype)), c_1)*{c_1 <- `c_1*`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $fvunop_(shape : shape, def $f_(N : N, fN : fN(N)) : fN(N)*, vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $fvunop_{Fnn : Fnn, M : M, def $f_(N : N, fN : fN(N)) : fN(N)*, v_1 : vec_(V128_Vnn), `c**` : lane_((Fnn : Fnn <: lanetype))**, `c_1*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $f_, v_1) = $inv_lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})*{`c*` <- `c**`}
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_((Fnn : Fnn <: lanetype)), $f_($sizenn((Fnn : Fnn <: numtype)), c_1)*{c_1 <- `c_1*`}))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivbinop_(shape : shape, def $f_(N : N, iN : iN(N), iN : iN(N)) : iN(N), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivbinop_{Jnn : Jnn, M : M, def $f_(N : N, iN : iN(N), iN : iN(N)) : iN(N), v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), `c*` : iN($lsizenn((Jnn : Jnn <: lanetype)))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, v_1, v_2) = [$inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})]
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_2))
    -- if (c*{c <- `c*`} = $f_($lsizenn((Jnn : Jnn <: lanetype)), c_1, c_2)*{c_1 <- `c_1*`, c_2 <- `c_2*`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivbinopsx_(shape : shape, def $f_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N), sx : sx, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivbinopsx_{Jnn : Jnn, M : M, def $f_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N), sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), `c*` : iN($lsizenn((Jnn : Jnn <: lanetype)))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, sx, v_1, v_2) = [$inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})]
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_2))
    -- if (c*{c <- `c*`} = $f_($lsizenn((Jnn : Jnn <: lanetype)), sx, c_1, c_2)*{c_1 <- `c_1*`, c_2 <- `c_2*`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivbinopsxnd_(shape : shape, def $f_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)*, sx : sx, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivbinopsxnd_{Jnn : Jnn, M : M, def $f_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : iN(N)*, sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), `c**` : lane_((Jnn : Jnn <: lanetype))**, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, sx, v_1, v_2) = $inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})*{`c*` <- `c**`}
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_2))
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_((Jnn : Jnn <: lanetype)), $f_($lsizenn((Jnn : Jnn <: lanetype)), sx, c_1, c_2)*{c_1 <- `c_1*`, c_2 <- `c_2*`}))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $fvbinop_(shape : shape, def $f_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $fvbinop_{Fnn : Fnn, M : M, def $f_(N : N, fN : fN(N), fN : fN(N)) : fN(N)*, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), `c**` : lane_((Fnn : Fnn <: lanetype))**, `c_1*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $f_, v_1, v_2) = $inv_lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})*{`c*` <- `c**`}
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), v_2))
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_((Fnn : Fnn <: lanetype)), $f_($sizenn((Fnn : Fnn <: numtype)), c_1, c_2)*{c_1 <- `c_1*`, c_2 <- `c_2*`}))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivternopnd_(shape : shape, def $f_(N : N, iN : iN(N), iN : iN(N), iN : iN(N)) : iN(N)*, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivternopnd_{Jnn : Jnn, M : M, def $f_(N : N, iN : iN(N), iN : iN(N), iN : iN(N)) : iN(N)*, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), v_3 : vec_(V128_Vnn), `c**` : lane_((Jnn : Jnn <: lanetype))**, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_3*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, v_1, v_2, v_3) = $inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})*{`c*` <- `c**`}
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_2))
    -- if (c_3*{c_3 <- `c_3*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_3))
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_((Jnn : Jnn <: lanetype)), $f_($lsizenn((Jnn : Jnn <: lanetype)), c_1, c_2, c_3)*{c_1 <- `c_1*`, c_2 <- `c_2*`, c_3 <- `c_3*`}))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $fvternop_(shape : shape, def $f_(N : N, fN : fN(N), fN : fN(N), fN : fN(N)) : fN(N)*, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $fvternop_{Fnn : Fnn, M : M, def $f_(N : N, fN : fN(N), fN : fN(N), fN : fN(N)) : fN(N)*, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), v_3 : vec_(V128_Vnn), `c**` : lane_((Fnn : Fnn <: lanetype))**, `c_1*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*, `c_3*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $f_, v_1, v_2, v_3) = $inv_lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})*{`c*` <- `c**`}
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), v_2))
    -- if (c_3*{c_3 <- `c_3*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), v_3))
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_((Fnn : Fnn <: lanetype)), $f_($sizenn((Fnn : Fnn <: numtype)), c_1, c_2, c_3)*{c_1 <- `c_1*`, c_2 <- `c_2*`, c_3 <- `c_3*`}))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivrelop_(shape : shape, def $f_(N : N, iN : iN(N), iN : iN(N)) : u32, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivrelop_{Jnn : Jnn, M : M, def $f_(N : N, iN : iN(N), iN : iN(N)) : u32, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), `c*` : iN($lsizenn((Jnn : Jnn <: lanetype)))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, v_1, v_2) = $inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_2))
    -- if (c*{c <- `c*`} = $extend__(1, $lsizenn((Jnn : Jnn <: lanetype)), S_sx, `%`_iN($f_($lsizenn((Jnn : Jnn <: lanetype)), c_1, c_2)!`%`_u32.0))*{c_1 <- `c_1*`, c_2 <- `c_2*`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivrelopsx_(shape : shape, def $f_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32, sx : sx, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivrelopsx_{Jnn : Jnn, M : M, def $f_(N : N, sx : sx, iN : iN(N), iN : iN(N)) : u32, sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), `c*` : iN($lsizenn((Jnn : Jnn <: lanetype)))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, sx, v_1, v_2) = $inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_2))
    -- if (c*{c <- `c*`} = $extend__(1, $lsizenn((Jnn : Jnn <: lanetype)), S_sx, `%`_iN($f_($lsizenn((Jnn : Jnn <: lanetype)), sx, c_1, c_2)!`%`_u32.0))*{c_1 <- `c_1*`, c_2 <- `c_2*`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $fvrelop_(shape : shape, def $f_(N : N, fN : fN(N), fN : fN(N)) : u32, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $fvrelop_{Fnn : Fnn, M : M, def $f_(N : N, fN : fN(N), fN : fN(N)) : u32, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), Inn : Inn, `c*` : iN($sizenn((Fnn : Fnn <: numtype)))*, `c_1*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $f_, v_1, v_2) = $inv_lanes_(`%X%`_shape((Inn : addrtype <: lanetype), `%`_dim(M)), `%`_lane_(c!`%`_iN.0)*{c <- `c*`})
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), v_2))
    -- if (c*{c <- `c*`} = $extend__(1, $sizenn((Fnn : Fnn <: numtype)), S_sx, `%`_iN($f_($sizenn((Fnn : Fnn <: numtype)), c_1, c_2)!`%`_u32.0))*{c_1 <- `c_1*`, c_2 <- `c_2*`})
    -- if ($isize(Inn) = $fsize(Fnn))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivshiftop_(shape : shape, def $f_(N : N, iN : iN(N), u32 : u32) : iN(N), vec_ : vec_(V128_Vnn), u32 : u32) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivshiftop_{Jnn : Jnn, M : M, def $f_(N : N, iN : iN(N), u32 : u32) : iN(N), v_1 : vec_(V128_Vnn), i : u32, `c*` : iN($lsizenn((Jnn : Jnn <: lanetype)))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, v_1, i) = $inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c*{c <- `c*`} = $f_($lsizenn((Jnn : Jnn <: lanetype)), c_1, i)*{c_1 <- `c_1*`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivshiftopsx_(shape : shape, def $f_(N : N, sx : sx, iN : iN(N), u32 : u32) : iN(N), sx : sx, vec_ : vec_(V128_Vnn), u32 : u32) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivshiftopsx_{Jnn : Jnn, M : M, def $f_(N : N, sx : sx, iN : iN(N), u32 : u32) : iN(N), sx : sx, v_1 : vec_(V128_Vnn), i : u32, `c*` : iN($lsizenn((Jnn : Jnn <: lanetype)))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, sx, v_1, i) = $inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c*{c <- `c*`} = $f_($lsizenn((Jnn : Jnn <: lanetype)), sx, c_1, i)*{c_1 <- `c_1*`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivbitmaskop_(shape : shape, vec_ : vec_(V128_Vnn)) : u32
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivbitmaskop_{Jnn : Jnn, M : M, v_1 : vec_(V128_Vnn), c : iN(32), `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1) = $irev_(32, c)
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1))
    -- if ($ibits_(32, c) = `%`_bit($ilt_($lsizenn((Jnn : Jnn <: lanetype)), S_sx, c_1, `%`_iN(0))!`%`_u32.0)*{c_1 <- `c_1*`} ++ `%`_bit(0)^(((32 : nat <:> int) - (M : nat <:> int)) : int <:> nat){})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivswizzlop_(shape : shape, def $f_(N : N, iN(N)*, iN : iN(N)) : iN(N), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivswizzlop_{Jnn : Jnn, M : M, def $f_(N : N, iN(N)*, iN : iN(N)) : iN(N), v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), `c*` : iN($lsizenn((Jnn : Jnn <: lanetype)))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $f_, v_1, v_2) = $inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_2))
    -- if (c*{c <- `c*`} = $f_($lsizenn((Jnn : Jnn <: lanetype)), c_1*{c_1 <- `c_1*`}, c_2)*{c_2 <- `c_2*`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivshufflop_(shape : shape, laneidx*, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivshufflop_{Jnn : Jnn, M : M, `i*` : laneidx*, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), `c*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), i*{i <- `i*`}, v_1, v_2) = $inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c*{c <- `c*`})
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v_2))
    -- if (c*{c <- `c*`} = c_1*{c_1 <- `c_1*`} ++ c_2*{c_2 <- `c_2*`}[i!`%`_laneidx.0]*{i <- `i*`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vvunop_(vectype : vectype, vvunop : vvunop, vec_ : vec_(vectype)) : vec_(vectype)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vvunop_{Vnn : Vnn, v : vec_(Vnn)}(Vnn, NOT_vvunop, v) = [$inot_($vsizenn(Vnn), v)]

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vvbinop_(vectype : vectype, vvbinop : vvbinop, vec_ : vec_(vectype), vec_ : vec_(vectype)) : vec_(vectype)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vvbinop_{Vnn : Vnn, v_1 : vec_(Vnn), v_2 : vec_(Vnn)}(Vnn, AND_vvbinop, v_1, v_2) = [$iand_($vsizenn(Vnn), v_1, v_2)]
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vvbinop_{Vnn : Vnn, v_1 : vec_(Vnn), v_2 : vec_(Vnn)}(Vnn, ANDNOT_vvbinop, v_1, v_2) = [$iandnot_($vsizenn(Vnn), v_1, v_2)]
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vvbinop_{Vnn : Vnn, v_1 : vec_(Vnn), v_2 : vec_(Vnn)}(Vnn, OR_vvbinop, v_1, v_2) = [$ior_($vsizenn(Vnn), v_1, v_2)]
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vvbinop_{Vnn : Vnn, v_1 : vec_(Vnn), v_2 : vec_(Vnn)}(Vnn, XOR_vvbinop, v_1, v_2) = [$ixor_($vsizenn(Vnn), v_1, v_2)]

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vvternop_(vectype : vectype, vvternop : vvternop, vec_ : vec_(vectype), vec_ : vec_(vectype), vec_ : vec_(vectype)) : vec_(vectype)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vvternop_{Vnn : Vnn, v_1 : vec_(Vnn), v_2 : vec_(Vnn), v_3 : vec_(Vnn)}(Vnn, BITSELECT_vvternop, v_1, v_2, v_3) = [$ibitselect_($vsizenn(Vnn), v_1, v_2, v_3)]

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vunop_(shape : shape, vunop_ : vunop_(shape), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vunop_{Fnn : Fnn, M : M, v : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), ABS_vunop_, v) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fabs_, v)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vunop_{Fnn : Fnn, M : M, v : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), NEG_vunop_, v) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fneg_, v)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vunop_{Fnn : Fnn, M : M, v : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), SQRT_vunop_, v) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fsqrt_, v)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vunop_{Fnn : Fnn, M : M, v : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), CEIL_vunop_, v) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fceil_, v)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vunop_{Fnn : Fnn, M : M, v : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), FLOOR_vunop_, v) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $ffloor_, v)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vunop_{Fnn : Fnn, M : M, v : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), TRUNC_vunop_, v) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $ftrunc_, v)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vunop_{Fnn : Fnn, M : M, v : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), NEAREST_vunop_, v) = $fvunop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fnearest_, v)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vunop_{Jnn : Jnn, M : M, v : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), ABS_vunop_, v) = $ivunop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $iabs_, v)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vunop_{Jnn : Jnn, M : M, v : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), NEG_vunop_, v) = $ivunop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ineg_, v)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vunop_{Jnn : Jnn, M : M, v : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), POPCNT_vunop_, v) = $ivunop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ipopcnt_, v)

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vbinop_(shape : shape, vbinop_ : vbinop_(shape), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Jnn : Jnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), ADD_vbinop_, v_1, v_2) = $ivbinop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $iadd_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Jnn : Jnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), SUB_vbinop_, v_1, v_2) = $ivbinop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $isub_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Jnn : Jnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), MUL_vbinop_, v_1, v_2) = $ivbinop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $imul_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Jnn : Jnn, M : M, sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), ADD_SAT_vbinop_(sx), v_1, v_2) = $ivbinopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $iadd_sat_, sx, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Jnn : Jnn, M : M, sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), SUB_SAT_vbinop_(sx), v_1, v_2) = $ivbinopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $isub_sat_, sx, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Jnn : Jnn, M : M, sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), MIN_vbinop_(sx), v_1, v_2) = $ivbinopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $imin_, sx, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Jnn : Jnn, M : M, sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), MAX_vbinop_(sx), v_1, v_2) = $ivbinopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $imax_, sx, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Jnn : Jnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), `AVGRU`_vbinop_, v_1, v_2) = $ivbinopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $iavgr_, U_sx, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Jnn : Jnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), `Q15MULR_SATS`_vbinop_, v_1, v_2) = $ivbinopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $iq15mulr_sat_, S_sx, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Jnn : Jnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), `RELAXED_Q15MULRS`_vbinop_, v_1, v_2) = $ivbinopsxnd_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $irelaxed_q15mulr_, S_sx, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), ADD_vbinop_, v_1, v_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fadd_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), SUB_vbinop_, v_1, v_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fsub_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), MUL_vbinop_, v_1, v_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fmul_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), DIV_vbinop_, v_1, v_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fdiv_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), MIN_vbinop_, v_1, v_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fmin_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), MAX_vbinop_, v_1, v_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fmax_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), PMIN_vbinop_, v_1, v_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fpmin_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), PMAX_vbinop_, v_1, v_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fpmax_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), RELAXED_MIN_vbinop_, v_1, v_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $frelaxed_min_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbinop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), RELAXED_MAX_vbinop_, v_1, v_2) = $fvbinop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $frelaxed_max_, v_1, v_2)

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vternop_(shape : shape, vternop_ : vternop_(shape), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vternop_{Jnn : Jnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), v_3 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), RELAXED_LANESELECT_vternop_, v_1, v_2, v_3) = $ivternopnd_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $irelaxed_laneselect_, v_1, v_2, v_3)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vternop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), v_3 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), RELAXED_MADD_vternop_, v_1, v_2, v_3) = $fvternop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $frelaxed_madd_, v_1, v_2, v_3)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vternop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), v_3 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), RELAXED_NMADD_vternop_, v_1, v_2, v_3) = $fvternop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $frelaxed_nmadd_, v_1, v_2, v_3)

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vrelop_(shape : shape, vrelop_ : vrelop_(shape), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vrelop_{Jnn : Jnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), EQ_vrelop_, v_1, v_2) = $ivrelop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ieq_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vrelop_{Jnn : Jnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), NE_vrelop_, v_1, v_2) = $ivrelop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ine_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vrelop_{Jnn : Jnn, M : M, sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), LT_vrelop_(sx), v_1, v_2) = $ivrelopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ilt_, sx, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vrelop_{Jnn : Jnn, M : M, sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), GT_vrelop_(sx), v_1, v_2) = $ivrelopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $igt_, sx, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vrelop_{Jnn : Jnn, M : M, sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), LE_vrelop_(sx), v_1, v_2) = $ivrelopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ile_, sx, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vrelop_{Jnn : Jnn, M : M, sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), GE_vrelop_(sx), v_1, v_2) = $ivrelopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ige_, sx, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vrelop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), EQ_vrelop_, v_1, v_2) = $fvrelop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $feq_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vrelop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), NE_vrelop_, v_1, v_2) = $fvrelop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fne_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vrelop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), LT_vrelop_, v_1, v_2) = $fvrelop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $flt_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vrelop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), GT_vrelop_, v_1, v_2) = $fvrelop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fgt_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vrelop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), LE_vrelop_, v_1, v_2) = $fvrelop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fle_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vrelop_{Fnn : Fnn, M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), GE_vrelop_, v_1, v_2) = $fvrelop_(`%X%`_shape((Fnn : Fnn <: lanetype), `%`_dim(M)), def $fge_, v_1, v_2)

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $lcvtop__(shape_1 : shape, shape_2 : shape, vcvtop__ : vcvtop__(shape_1, shape_2), lane_ : lane_($lanetype(shape_1))) : lane_($lanetype(shape_2))*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $lcvtop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, half : half, sx : sx, c_1 : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)))), c : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), EXTEND_vcvtop__(half, sx), c_1) = [c]
    -- if (c = $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), sx, c_1))
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $lcvtop__{Jnn_1 : Jnn, M_1 : M, Fnn_2 : Fnn, M_2 : M, `half?` : half?, sx : sx, c_1 : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)))), c : fN($lsizenn2((Fnn_2 : Fnn <: lanetype)))}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), CONVERT_vcvtop__(half?{half <- `half?`}, sx), c_1) = [c]
    -- if (c = $convert__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Fnn_2 : Fnn <: lanetype)), sx, c_1))
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $lcvtop__{Fnn_1 : Fnn, M_1 : M, Inn_2 : Inn, M_2 : M, sx : sx, `zero?` : zero?, c_1 : lane_($lanetype(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)))), `c?` : iN($lsizenn2((Inn_2 : addrtype <: lanetype)))?}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Inn_2 : addrtype <: lanetype), `%`_dim(M_2)), TRUNC_SAT_vcvtop__(sx, zero?{zero <- `zero?`}), c_1) = lift(c?{c <- `c?`})
    -- if (c?{c <- `c?`} = $trunc_sat__($lsizenn1((Fnn_1 : Fnn <: lanetype)), $lsizenn2((Inn_2 : addrtype <: lanetype)), sx, c_1))
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $lcvtop__{Fnn_1 : Fnn, M_1 : M, Inn_2 : Inn, M_2 : M, sx : sx, `zero?` : zero?, c_1 : lane_($lanetype(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)))), `c?` : iN($lsizenn2((Inn_2 : addrtype <: lanetype)))?}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Inn_2 : addrtype <: lanetype), `%`_dim(M_2)), RELAXED_TRUNC_vcvtop__(sx, zero?{zero <- `zero?`}), c_1) = lift(c?{c <- `c?`})
    -- if (c?{c <- `c?`} = $relaxed_trunc__($lsizenn1((Fnn_1 : Fnn <: lanetype)), $lsizenn2((Inn_2 : addrtype <: lanetype)), sx, c_1))
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $lcvtop__{Fnn_1 : Fnn, M_1 : M, Fnn_2 : Fnn, M_2 : M, c_1 : lane_($lanetype(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)))), `c*` : fN($lsizenn2((Fnn_2 : Fnn <: lanetype)))*}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), DEMOTE_vcvtop__(ZERO_zero), c_1) = c*{c <- `c*`}
    -- if (c*{c <- `c*`} = $demote__($lsizenn1((Fnn_1 : Fnn <: lanetype)), $lsizenn2((Fnn_2 : Fnn <: lanetype)), c_1))
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $lcvtop__{Fnn_1 : Fnn, M_1 : M, Fnn_2 : Fnn, M_2 : M, c_1 : lane_($lanetype(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)))), `c*` : fN($lsizenn2((Fnn_2 : Fnn <: lanetype)))*}(`%X%`_shape((Fnn_1 : Fnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Fnn_2 : Fnn <: lanetype), `%`_dim(M_2)), `PROMOTELOW`_vcvtop__, c_1) = c*{c <- `c*`}
    -- if (c*{c <- `c*`} = $promote__($lsizenn1((Fnn_1 : Fnn <: lanetype)), $lsizenn2((Fnn_2 : Fnn <: lanetype)), c_1))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vcvtop__(shape_1 : shape, shape_2 : shape, vcvtop__ : vcvtop__(shape_1, shape_2), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vcvtop__{Lnn_1 : Lnn, M : M, Lnn_2 : Lnn, vcvtop : vcvtop__(`%X%`_shape(Lnn_1, `%`_dim(M)), `%X%`_shape(Lnn_2, `%`_dim(M))), v_1 : vec_(V128_Vnn), v : vec_(V128_Vnn), `c_1*` : lane_($lanetype(`%X%`_shape(Lnn_1, `%`_dim(M))))*, `c**` : lane_(Lnn_2)**}(`%X%`_shape(Lnn_1, `%`_dim(M)), `%X%`_shape(Lnn_2, `%`_dim(M)), vcvtop, v_1) = v
    -- if (($halfop(`%X%`_shape(Lnn_1, `%`_dim(M)), `%X%`_shape(Lnn_2, `%`_dim(M)), vcvtop) = ?()) /\ ($zeroop(`%X%`_shape(Lnn_1, `%`_dim(M)), `%X%`_shape(Lnn_2, `%`_dim(M)), vcvtop) = ?()))
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape(Lnn_1, `%`_dim(M)), v_1))
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_(Lnn_2), $lcvtop__(`%X%`_shape(Lnn_1, `%`_dim(M)), `%X%`_shape(Lnn_2, `%`_dim(M)), vcvtop, c_1)*{c_1 <- `c_1*`}))
    -- if (v <- $inv_lanes_(`%X%`_shape(Lnn_2, `%`_dim(M)), c*{c <- `c*`})*{`c*` <- `c**`})
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vcvtop__{Lnn_1 : Lnn, M_1 : M, Lnn_2 : Lnn, M_2 : M, vcvtop : vcvtop__(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2))), v_1 : vec_(V128_Vnn), v : vec_(V128_Vnn), half : half, `c_1*` : lane_($lanetype(`%X%`_shape(Lnn_1, `%`_dim(M_1))))*, `c**` : lane_(Lnn_2)**}(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2)), vcvtop, v_1) = v
    -- if ($halfop(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2)), vcvtop) = ?(half))
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape(Lnn_1, `%`_dim(M_1)), v_1)[$half(half, 0, M_2) : M_2])
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_(Lnn_2), $lcvtop__(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2)), vcvtop, c_1)*{c_1 <- `c_1*`}))
    -- if (v <- $inv_lanes_(`%X%`_shape(Lnn_2, `%`_dim(M_2)), c*{c <- `c*`})*{`c*` <- `c**`})
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vcvtop__{Lnn_1 : Lnn, M_1 : M, Lnn_2 : Lnn, M_2 : M, vcvtop : vcvtop__(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2))), v_1 : vec_(V128_Vnn), v : vec_(V128_Vnn), `c_1*` : lane_($lanetype(`%X%`_shape(Lnn_1, `%`_dim(M_1))))*, `c**` : lane_(Lnn_2)**}(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2)), vcvtop, v_1) = v
    -- if ($zeroop(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2)), vcvtop) = ?(ZERO_zero))
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape(Lnn_1, `%`_dim(M_1)), v_1))
    -- if (c*{c <- `c*`}*{`c*` <- `c**`} = $setproduct_(syntax lane_(Lnn_2), $lcvtop__(`%X%`_shape(Lnn_1, `%`_dim(M_1)), `%X%`_shape(Lnn_2, `%`_dim(M_2)), vcvtop, c_1)*{c_1 <- `c_1*`} ++ [$zero(Lnn_2)]^M_1{}))
    -- if (v <- $inv_lanes_(`%X%`_shape(Lnn_2, `%`_dim(M_2)), c*{c <- `c*`})*{`c*` <- `c**`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vshiftop_(ishape : ishape, vshiftop_ : vshiftop_(ishape), vec_ : vec_(V128_Vnn), u32 : u32) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vshiftop_{Jnn : Jnn, M : M, v : vec_(V128_Vnn), i : u32}(`%`_ishape(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))), SHL_vshiftop_, v, i) = $ivshiftop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ishl_, v, i)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vshiftop_{Jnn : Jnn, M : M, sx : sx, v : vec_(V128_Vnn), i : u32}(`%`_ishape(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))), SHR_vshiftop_(sx), v, i) = $ivshiftopsx_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), def $ishr_, sx, v, i)

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vbitmaskop_(ishape : ishape, vec_ : vec_(V128_Vnn)) : u32
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vbitmaskop_{Jnn : Jnn, M : M, v : vec_(V128_Vnn)}(`%`_ishape(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))), v) = $ivbitmaskop_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), v)

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vswizzlop_(bshape : bshape, vswizzlop_ : vswizzlop_(bshape), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vswizzlop_{M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%`_bshape(`%X%`_shape(I8_lanetype, `%`_dim(M))), SWIZZLE_vswizzlop_, v_1, v_2) = $ivswizzlop_(`%X%`_shape(I8_lanetype, `%`_dim(M)), def $iswizzle_lane_, v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vswizzlop_{M : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%`_bshape(`%X%`_shape(I8_lanetype, `%`_dim(M))), RELAXED_SWIZZLE_vswizzlop_, v_1, v_2) = $ivswizzlop_(`%X%`_shape(I8_lanetype, `%`_dim(M)), def $irelaxed_swizzle_lane_, v_1, v_2)

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vshufflop_(bshape : bshape, laneidx*, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vshufflop_{M : M, `i*` : laneidx*, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%`_bshape(`%X%`_shape(I8_lanetype, `%`_dim(M))), i*{i <- `i*`}, v_1, v_2) = $ivshufflop_(`%X%`_shape(I8_lanetype, `%`_dim(M)), i*{i <- `i*`}, v_1, v_2)

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vnarrowop__(shape_1 : shape, shape_2 : shape, sx : sx, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vnarrowop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), v : vec_(V128_Vnn), `c_1*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `c'_1*` : iN($lsize((Jnn_2 : Jnn <: lanetype)))*, `c'_2*` : iN($lsize((Jnn_2 : Jnn <: lanetype)))*}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), sx, v_1, v_2) = v
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), v_1))
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), v_2))
    -- if (c'_1*{c'_1 <- `c'_1*`} = $narrow__($lsize((Jnn_1 : Jnn <: lanetype)), $lsize((Jnn_2 : Jnn <: lanetype)), sx, c_1)*{c_1 <- `c_1*`})
    -- if (c'_2*{c'_2 <- `c'_2*`} = $narrow__($lsize((Jnn_1 : Jnn <: lanetype)), $lsize((Jnn_2 : Jnn <: lanetype)), sx, c_2)*{c_2 <- `c_2*`})
    -- if (v = $inv_lanes_(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), c'_1*{c'_1 <- `c'_1*`} ++ c'_2*{c'_2 <- `c'_2*`}))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivadd_pairwise_(N : N, iN(N)*) : iN(N)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivadd_pairwise_{N : N, `i*` : iN(N)*, `j_1*` : N*, `j_2*` : N*}(N, i*{i <- `i*`}) = $iadd_(N, `%`_iN(j_1), `%`_iN(j_2))*{j_1 <- `j_1*`, j_2 <- `j_2*`}
    -- if ($concat_(syntax N, [j_1 j_2]*{j_1 <- `j_1*`, j_2 <- `j_2*`}) = i!`%`_iN.0*{i <- `i*`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivextunop__(shape_1 : shape, shape_2 : shape, def $f_(N : N, iN(N)*) : iN(N)*, sx : sx, vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivextunop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, def $f_(N : N, iN(N)*) : iN(N)*, sx : sx, v_1 : vec_(V128_Vnn), `c*` : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `c'_1*` : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))*}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), def $f_, sx, v_1) = $inv_lanes_(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), c*{c <- `c*`})
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), v_1))
    -- if (c'_1*{c'_1 <- `c'_1*`} = $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), sx, c_1)*{c_1 <- `c_1*`})
    -- if (c*{c <- `c*`} = $f_($lsizenn2((Jnn_2 : Jnn <: lanetype)), c'_1*{c'_1 <- `c'_1*`}))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vextunop__(ishape_1 : ishape, ishape_2 : ishape, vextunop__ : vextunop__(ishape_1, ishape_2), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vextunop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, sx : sx, v_1 : vec_(V128_Vnn)}(`%`_ishape(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))), `%`_ishape(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))), EXTADD_PAIRWISE_vextunop__(sx), v_1) = $ivextunop__(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), def $ivadd_pairwise_, sx, v_1)

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivdot_(N : N, iN(N)*, iN(N)*) : iN(N)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivdot_{N : N, `i_1*` : iN(N)*, `i_2*` : iN(N)*, `j_1*` : iN(N)*, `j_2*` : iN(N)*}(N, i_1*{i_1 <- `i_1*`}, i_2*{i_2 <- `i_2*`}) = $iadd_(N, j_1, j_2)*{j_1 <- `j_1*`, j_2 <- `j_2*`}
    -- if ($concat_(syntax iN(N), [j_1 j_2]*{j_1 <- `j_1*`, j_2 <- `j_2*`}) = $imul_(N, i_1, i_2)*{i_1 <- `i_1*`, i_2 <- `i_2*`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivdot_sat_(N : N, iN(N)*, iN(N)*) : iN(N)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivdot_sat_{N : N, `i_1*` : iN(N)*, `i_2*` : iN(N)*, `j_1*` : iN(N)*, `j_2*` : iN(N)*}(N, i_1*{i_1 <- `i_1*`}, i_2*{i_2 <- `i_2*`}) = $iadd_sat_(N, S_sx, j_1, j_2)*{j_1 <- `j_1*`, j_2 <- `j_2*`}
    -- if ($concat_(syntax iN(N), [j_1 j_2]*{j_1 <- `j_1*`, j_2 <- `j_2*`}) = $imul_(N, i_1, i_2)*{i_1 <- `i_1*`, i_2 <- `i_2*`})

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivextbinop__(shape_1 : shape, shape_2 : shape, def $f_(N : N, iN(N)*, iN(N)*) : iN(N)*, sx : sx, sx : sx, laneidx : laneidx, laneidx : laneidx, vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivextbinop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, def $f_(N : N, iN(N)*, iN(N)*) : iN(N)*, sx_1 : sx, sx_2 : sx, i : laneidx, k : laneidx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn), `c*` : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))*, `c_1*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `c_2*` : lane_($lanetype(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))))*, `c'_1*` : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))*, `c'_2*` : iN($lsizenn2((Jnn_2 : Jnn <: lanetype)))*}(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), def $f_, sx_1, sx_2, i, k, v_1, v_2) = $inv_lanes_(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), c*{c <- `c*`})
    -- if (c_1*{c_1 <- `c_1*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), v_1)[i!`%`_laneidx.0 : k!`%`_laneidx.0])
    -- if (c_2*{c_2 <- `c_2*`} = $lanes_(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), v_2)[i!`%`_laneidx.0 : k!`%`_laneidx.0])
    -- if (c'_1*{c'_1 <- `c'_1*`} = $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), sx_1, c_1)*{c_1 <- `c_1*`})
    -- if (c'_2*{c'_2 <- `c'_2*`} = $extend__($lsizenn1((Jnn_1 : Jnn <: lanetype)), $lsizenn2((Jnn_2 : Jnn <: lanetype)), sx_2, c_2)*{c_2 <- `c_2*`})
    -- if (c*{c <- `c*`} = $f_($lsizenn2((Jnn_2 : Jnn <: lanetype)), c'_1*{c'_1 <- `c'_1*`}, c'_2*{c'_2 <- `c'_2*`}))

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $ivmul_(N : N, iN(N)*, iN(N)*) : iN(N)*
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $ivmul_{N : N, `i_1*` : iN(N)*, `i_2*` : iN(N)*}(N, i_1*{i_1 <- `i_1*`}, i_2*{i_2 <- `i_2*`}) = $imul_(N, i_1, i_2)*{i_1 <- `i_1*`, i_2 <- `i_2*`}

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vextbinop__(ishape_1 : ishape, ishape_2 : ishape, vextbinop__ : vextbinop__(ishape_1, ishape_2), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vextbinop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, half : half, sx : sx, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%`_ishape(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))), `%`_ishape(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))), EXTMUL_vextbinop__(half, sx), v_1, v_2) = $ivextbinop__(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), def $ivmul_, sx, sx, `%`_laneidx($half(half, 0, M_2)), `%`_laneidx(M_2), v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vextbinop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%`_ishape(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))), `%`_ishape(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))), `DOTS`_vextbinop__, v_1, v_2) = $ivextbinop__(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), def $ivdot_, S_sx, S_sx, `%`_laneidx(0), `%`_laneidx(M_1), v_1, v_2)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vextbinop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, v_1 : vec_(V128_Vnn), v_2 : vec_(V128_Vnn)}(`%`_ishape(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))), `%`_ishape(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))), `RELAXED_DOTS`_vextbinop__, v_1, v_2) = $ivextbinop__(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1)), `%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), def $ivdot_sat_, S_sx, $relaxed2($R_idot, syntax sx, S_sx, U_sx), `%`_laneidx(0), `%`_laneidx(M_1), v_1, v_2)

;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
def $vextternop__(ishape_1 : ishape, ishape_2 : ishape, vextternop__ : vextternop__(ishape_1, ishape_2), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn), vec_ : vec_(V128_Vnn)) : vec_(V128_Vnn)
  ;; ../../../../specification/wasm-3.0/3.2-numerics.vector.spectec
  def $vextternop__{Jnn_1 : Jnn, M_1 : M, Jnn_2 : Jnn, M_2 : M, c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c_3 : vec_(V128_Vnn), c : vec_(V128_Vnn), Jnn : Jnn, M : M, c' : vec_(V128_Vnn), c'' : vec_(V128_Vnn)}(`%`_ishape(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))), `%`_ishape(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))), `RELAXED_DOT_ADDS`_vextternop__, c_1, c_2, c_3) = c
    -- if ($jsizenn(Jnn) = (2 * $lsizenn1((Jnn_1 : Jnn <: lanetype))))
    -- if (M = (2 * M_2))
    -- if (c' = $vextbinop__(`%`_ishape(`%X%`_shape((Jnn_1 : Jnn <: lanetype), `%`_dim(M_1))), `%`_ishape(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))), `RELAXED_DOTS`_vextbinop__, c_1, c_2))
    -- if (c'' = $vextunop__(`%`_ishape(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))), `%`_ishape(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2))), EXTADD_PAIRWISE_vextunop__(S_sx), c'))
    -- if (c <- $vbinop_(`%X%`_shape((Jnn_2 : Jnn <: lanetype), `%`_dim(M_2)), ADD_vbinop_, c'', c_3))

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax num = 
  | CONST{numtype : numtype, num_ : num_(numtype)}(numtype : numtype, num_ : num_(numtype))

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax vec = 
  | VCONST{vectype : vectype, vec_ : vec_(vectype)}(vectype : vectype, vec_ : vec_(vectype))

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax ref = 
  | REF.I31_NUM{u31 : u31}(u31 : u31)
  | REF.STRUCT_ADDR{structaddr : structaddr}(structaddr : structaddr)
  | REF.ARRAY_ADDR{arrayaddr : arrayaddr}(arrayaddr : arrayaddr)
  | REF.FUNC_ADDR{funcaddr : funcaddr}(funcaddr : funcaddr)
  | REF.EXN_ADDR{exnaddr : exnaddr}(exnaddr : exnaddr)
  | REF.HOST_ADDR{hostaddr : hostaddr}(hostaddr : hostaddr)
  | REF.EXTERN{addrref : addrref}(addrref : addrref)
  | REF.NULL{heaptype : heaptype}(heaptype : heaptype)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax result = 
  | _VALS{`val*` : val*}(val*{val <- `val*`} : val*)
  | `(REF.EXN_ADDR%)THROW_REF`{exnaddr : exnaddr}(exnaddr : exnaddr)
  | TRAP

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax hostfunc = 
  | `...`

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax funccode = 
  | FUNC{typeidx : typeidx, `local*` : local*, expr : expr}(typeidx : typeidx, local*{local <- `local*`} : local*, expr : expr)
  | `...`

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax taginst = 
{
  TYPE{tagtype : tagtype} tagtype
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax globalinst = 
{
  TYPE{globaltype : globaltype} globaltype,
  VALUE{val : val} val
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax meminst = 
{
  TYPE{memtype : memtype} memtype,
  BYTES{`byte*` : byte*} byte*
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax tableinst = 
{
  TYPE{tabletype : tabletype} tabletype,
  REFS{`ref*` : ref*} ref*
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax funcinst = 
{
  TYPE{deftype : deftype} deftype,
  MODULE{moduleinst : moduleinst} moduleinst,
  CODE{funccode : funccode} funccode
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax datainst = 
{
  BYTES{`byte*` : byte*} byte*
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax eleminst = 
{
  TYPE{elemtype : elemtype} elemtype,
  REFS{`ref*` : ref*} ref*
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax packval = 
  | PACK{packtype : packtype, iN : iN($psizenn(packtype))}(packtype : packtype, iN : iN($psizenn(packtype)))

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
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

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax structinst = 
{
  TYPE{deftype : deftype} deftype,
  FIELDS{`fieldval*` : fieldval*} fieldval*
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax arrayinst = 
{
  TYPE{deftype : deftype} deftype,
  FIELDS{`fieldval*` : fieldval*} fieldval*
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax exninst = 
{
  TAG{tagaddr : tagaddr} tagaddr,
  FIELDS{`val*` : val*} val*
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax store = 
{
  TAGS{`taginst*` : taginst*} taginst*,
  GLOBALS{`globalinst*` : globalinst*} globalinst*,
  MEMS{`meminst*` : meminst*} meminst*,
  TABLES{`tableinst*` : tableinst*} tableinst*,
  FUNCS{`funcinst*` : funcinst*} funcinst*,
  DATAS{`datainst*` : datainst*} datainst*,
  ELEMS{`eleminst*` : eleminst*} eleminst*,
  STRUCTS{`structinst*` : structinst*} structinst*,
  ARRAYS{`arrayinst*` : arrayinst*} arrayinst*,
  EXNS{`exninst*` : exninst*} exninst*
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax state = 
  | `%;%`{store : store, frame : frame}(store : store, frame : frame)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
syntax config = 
  | `%;%`{state : state, `instr*` : instr*}(state : state, instr*{instr <- `instr*`} : instr*)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $Ki : nat
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $Ki = 1024

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $packfield_(storagetype : storagetype, val : val) : fieldval
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $packfield_{valtype : valtype, val : val}((valtype : valtype <: storagetype), val) = (val : val <: fieldval)
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $packfield_{packtype : packtype, i : num_(I32_numtype)}((packtype : packtype <: storagetype), CONST_val(I32_numtype, i)) = PACK_fieldval(packtype, $wrap__(32, $psize(packtype), i))

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $unpackfield_(storagetype : storagetype, sx?, fieldval : fieldval) : val
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $unpackfield_{valtype : valtype, val : val}((valtype : valtype <: storagetype), ?(), (val : val <: fieldval)) = val
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $unpackfield_{packtype : packtype, sx : sx, i : iN($psizenn(packtype))}((packtype : packtype <: storagetype), ?(sx), PACK_fieldval(packtype, i)) = CONST_val(I32_numtype, $extend__($psize(packtype), 32, sx, i))

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
rec {

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:193.1-193.86
def $tagsxa(externaddr*) : tagaddr*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:199.1-199.23
  def $tagsxa([]) = []
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:200.1-200.42
  def $tagsxa{a : addr, `xa*` : externaddr*}([TAG_externaddr(a)] ++ xa*{xa <- `xa*`}) = [a] ++ $tagsxa(xa*{xa <- `xa*`})
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:201.1-201.57
  def $tagsxa{externaddr : externaddr, `xa*` : externaddr*}([externaddr] ++ xa*{xa <- `xa*`}) = $tagsxa(xa*{xa <- `xa*`})
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
rec {

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:194.1-194.89
def $globalsxa(externaddr*) : globaladdr*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:203.1-203.26
  def $globalsxa([]) = []
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:204.1-204.51
  def $globalsxa{a : addr, `xa*` : externaddr*}([GLOBAL_externaddr(a)] ++ xa*{xa <- `xa*`}) = [a] ++ $globalsxa(xa*{xa <- `xa*`})
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:205.1-205.63
  def $globalsxa{externaddr : externaddr, `xa*` : externaddr*}([externaddr] ++ xa*{xa <- `xa*`}) = $globalsxa(xa*{xa <- `xa*`})
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
rec {

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:195.1-195.86
def $memsxa(externaddr*) : memaddr*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:207.1-207.23
  def $memsxa([]) = []
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:208.1-208.42
  def $memsxa{a : addr, `xa*` : externaddr*}([MEM_externaddr(a)] ++ xa*{xa <- `xa*`}) = [a] ++ $memsxa(xa*{xa <- `xa*`})
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:209.1-209.57
  def $memsxa{externaddr : externaddr, `xa*` : externaddr*}([externaddr] ++ xa*{xa <- `xa*`}) = $memsxa(xa*{xa <- `xa*`})
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
rec {

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:196.1-196.88
def $tablesxa(externaddr*) : tableaddr*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:211.1-211.25
  def $tablesxa([]) = []
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:212.1-212.48
  def $tablesxa{a : addr, `xa*` : externaddr*}([TABLE_externaddr(a)] ++ xa*{xa <- `xa*`}) = [a] ++ $tablesxa(xa*{xa <- `xa*`})
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:213.1-213.61
  def $tablesxa{externaddr : externaddr, `xa*` : externaddr*}([externaddr] ++ xa*{xa <- `xa*`}) = $tablesxa(xa*{xa <- `xa*`})
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
rec {

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:197.1-197.87
def $funcsxa(externaddr*) : funcaddr*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:215.1-215.24
  def $funcsxa([]) = []
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:216.1-216.45
  def $funcsxa{a : addr, `xa*` : externaddr*}([FUNC_externaddr(a)] ++ xa*{xa <- `xa*`}) = [a] ++ $funcsxa(xa*{xa <- `xa*`})
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec:217.1-217.59
  def $funcsxa{externaddr : externaddr, `xa*` : externaddr*}([externaddr] ++ xa*{xa <- `xa*`}) = $funcsxa(xa*{xa <- `xa*`})
}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $store(state : state) : store
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $store{s : store, f : frame}(`%;%`_state(s, f)) = s

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $frame(state : state) : frame
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $frame{s : store, f : frame}(`%;%`_state(s, f)) = f

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $tagaddr(state : state) : tagaddr*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $tagaddr{s : store, f : frame}(`%;%`_state(s, f)) = f.MODULE_frame.TAGS_moduleinst

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $moduleinst(state : state) : moduleinst
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $moduleinst{s : store, f : frame}(`%;%`_state(s, f)) = f.MODULE_frame

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $taginst(state : state) : taginst*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $taginst{s : store, f : frame}(`%;%`_state(s, f)) = s.TAGS_store

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $globalinst(state : state) : globalinst*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $globalinst{s : store, f : frame}(`%;%`_state(s, f)) = s.GLOBALS_store

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $meminst(state : state) : meminst*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $meminst{s : store, f : frame}(`%;%`_state(s, f)) = s.MEMS_store

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $tableinst(state : state) : tableinst*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $tableinst{s : store, f : frame}(`%;%`_state(s, f)) = s.TABLES_store

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $funcinst(state : state) : funcinst*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $funcinst{s : store, f : frame}(`%;%`_state(s, f)) = s.FUNCS_store

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $datainst(state : state) : datainst*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $datainst{s : store, f : frame}(`%;%`_state(s, f)) = s.DATAS_store

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $eleminst(state : state) : eleminst*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $eleminst{s : store, f : frame}(`%;%`_state(s, f)) = s.ELEMS_store

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $structinst(state : state) : structinst*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $structinst{s : store, f : frame}(`%;%`_state(s, f)) = s.STRUCTS_store

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $arrayinst(state : state) : arrayinst*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $arrayinst{s : store, f : frame}(`%;%`_state(s, f)) = s.ARRAYS_store

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $exninst(state : state) : exninst*
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $exninst{s : store, f : frame}(`%;%`_state(s, f)) = s.EXNS_store

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $type(state : state, typeidx : typeidx) : deftype
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $type{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = f.MODULE_frame.TYPES_moduleinst[x!`%`_idx.0]

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $tag(state : state, tagidx : tagidx) : taginst
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $tag{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.TAGS_store[f.MODULE_frame.TAGS_moduleinst[x!`%`_idx.0]]

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $global(state : state, globalidx : globalidx) : globalinst
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $global{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.GLOBALS_store[f.MODULE_frame.GLOBALS_moduleinst[x!`%`_idx.0]]

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $mem(state : state, memidx : memidx) : meminst
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $mem{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.MEMS_store[f.MODULE_frame.MEMS_moduleinst[x!`%`_idx.0]]

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $table(state : state, tableidx : tableidx) : tableinst
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $table{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.TABLES_store[f.MODULE_frame.TABLES_moduleinst[x!`%`_idx.0]]

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $func(state : state, funcidx : funcidx) : funcinst
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $func{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.FUNCS_store[f.MODULE_frame.FUNCS_moduleinst[x!`%`_idx.0]]

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $data(state : state, dataidx : dataidx) : datainst
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $data{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.DATAS_store[f.MODULE_frame.DATAS_moduleinst[x!`%`_idx.0]]

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $elem(state : state, tableidx : tableidx) : eleminst
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $elem{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = s.ELEMS_store[f.MODULE_frame.ELEMS_moduleinst[x!`%`_idx.0]]

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $local(state : state, localidx : localidx) : val?
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $local{s : store, f : frame, x : idx}(`%;%`_state(s, f), x) = f.LOCALS_frame[x!`%`_idx.0]

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $with_local(state : state, localidx : localidx, val : val) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $with_local{s : store, f : frame, x : idx, v : val}(`%;%`_state(s, f), x, v) = `%;%`_state(s, f[LOCALS_frame[x!`%`_idx.0] = ?(v)])

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $with_global(state : state, globalidx : globalidx, val : val) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $with_global{s : store, f : frame, x : idx, v : val}(`%;%`_state(s, f), x, v) = `%;%`_state(s[GLOBALS_store[f.MODULE_frame.GLOBALS_moduleinst[x!`%`_idx.0]].VALUE_globalinst = v], f)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $with_table(state : state, tableidx : tableidx, nat : nat, ref : ref) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $with_table{s : store, f : frame, x : idx, i : nat, r : ref}(`%;%`_state(s, f), x, i, r) = `%;%`_state(s[TABLES_store[f.MODULE_frame.TABLES_moduleinst[x!`%`_idx.0]].REFS_tableinst[i] = r], f)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $with_tableinst(state : state, tableidx : tableidx, tableinst : tableinst) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $with_tableinst{s : store, f : frame, x : idx, ti : tableinst}(`%;%`_state(s, f), x, ti) = `%;%`_state(s[TABLES_store[f.MODULE_frame.TABLES_moduleinst[x!`%`_idx.0]] = ti], f)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $with_mem(state : state, memidx : memidx, nat : nat, nat : nat, byte*) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $with_mem{s : store, f : frame, x : idx, i : nat, j : nat, `b*` : byte*}(`%;%`_state(s, f), x, i, j, b*{b <- `b*`}) = `%;%`_state(s[MEMS_store[f.MODULE_frame.MEMS_moduleinst[x!`%`_idx.0]].BYTES_meminst[i : j] = b*{b <- `b*`}], f)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $with_meminst(state : state, memidx : memidx, meminst : meminst) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $with_meminst{s : store, f : frame, x : idx, mi : meminst}(`%;%`_state(s, f), x, mi) = `%;%`_state(s[MEMS_store[f.MODULE_frame.MEMS_moduleinst[x!`%`_idx.0]] = mi], f)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $with_elem(state : state, elemidx : elemidx, ref*) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $with_elem{s : store, f : frame, x : idx, `r*` : ref*}(`%;%`_state(s, f), x, r*{r <- `r*`}) = `%;%`_state(s[ELEMS_store[f.MODULE_frame.ELEMS_moduleinst[x!`%`_idx.0]].REFS_eleminst = r*{r <- `r*`}], f)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $with_data(state : state, dataidx : dataidx, byte*) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $with_data{s : store, f : frame, x : idx, `b*` : byte*}(`%;%`_state(s, f), x, b*{b <- `b*`}) = `%;%`_state(s[DATAS_store[f.MODULE_frame.DATAS_moduleinst[x!`%`_idx.0]].BYTES_datainst = b*{b <- `b*`}], f)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $with_struct(state : state, structaddr : structaddr, nat : nat, fieldval : fieldval) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $with_struct{s : store, f : frame, a : addr, i : nat, fv : fieldval}(`%;%`_state(s, f), a, i, fv) = `%;%`_state(s[STRUCTS_store[a].FIELDS_structinst[i] = fv], f)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $with_array(state : state, arrayaddr : arrayaddr, nat : nat, fieldval : fieldval) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $with_array{s : store, f : frame, a : addr, i : nat, fv : fieldval}(`%;%`_state(s, f), a, i, fv) = `%;%`_state(s[ARRAYS_store[a].FIELDS_arrayinst[i] = fv], f)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $add_structinst(state : state, structinst*) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $add_structinst{s : store, f : frame, `si*` : structinst*}(`%;%`_state(s, f), si*{si <- `si*`}) = `%;%`_state(s[STRUCTS_store =++ si*{si <- `si*`}], f)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $add_arrayinst(state : state, arrayinst*) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $add_arrayinst{s : store, f : frame, `ai*` : arrayinst*}(`%;%`_state(s, f), ai*{ai <- `ai*`}) = `%;%`_state(s[ARRAYS_store =++ ai*{ai <- `ai*`}], f)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $add_exninst(state : state, exninst*) : state
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $add_exninst{s : store, f : frame, `exn*` : exninst*}(`%;%`_state(s, f), exn*{exn <- `exn*`}) = `%;%`_state(s[EXNS_store =++ exn*{exn <- `exn*`}], f)

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $growtable(tableinst : tableinst, nat : nat, ref : ref) : tableinst
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $growtable{tableinst : tableinst, n : n, r : ref, tableinst' : tableinst, at : addrtype, i : u64, `j?` : u64?, rt : reftype, `r'*` : ref*, i' : u64}(tableinst, n, r) = tableinst'
    -- if (tableinst = {TYPE `%%%`_tabletype(at, `[%..%]`_limits(i, j?{j <- `j?`}), rt), REFS r'*{r' <- `r'*`}})
    -- if (tableinst' = {TYPE `%%%`_tabletype(at, `[%..%]`_limits(i', j?{j <- `j?`}), rt), REFS r'*{r' <- `r'*`} ++ r^n{}})
    -- if (i'!`%`_u64.0 = (|r'*{r' <- `r'*`}| + n))
    -- (if (i'!`%`_u64.0 <= j!`%`_u64.0))?{j <- `j?`}

;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
def $growmem(meminst : meminst, nat : nat) : meminst
  ;; ../../../../specification/wasm-3.0/4.0-execution.configurations.spectec
  def $growmem{meminst : meminst, n : n, meminst' : meminst, at : addrtype, i : u64, `j?` : u64?, `b*` : byte*, i' : u64}(meminst, n) = meminst'
    -- if (meminst = {TYPE `%%PAGE`_memtype(at, `[%..%]`_limits(i, j?{j <- `j?`})), BYTES b*{b <- `b*`}})
    -- if (meminst' = {TYPE `%%PAGE`_memtype(at, `[%..%]`_limits(i', j?{j <- `j?`})), BYTES b*{b <- `b*`} ++ `%`_byte(0)^(n * (64 * $Ki)){}})
    -- if ((i'!`%`_u64.0 : nat <:> rat) = (((|b*{b <- `b*`}| : nat <:> rat) / ((64 * $Ki) : nat <:> rat)) + (n : nat <:> rat)))
    -- (if (i'!`%`_u64.0 <= j!`%`_u64.0))?{j <- `j?`}

;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
relation Num_ok: `%|-%:%`(store, num, numtype)
  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
  rule _{s : store, nt : numtype, c : num_(nt)}:
    `%|-%:%`(s, CONST_num(nt, c), nt)

;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
relation Vec_ok: `%|-%:%`(store, vec, vectype)
  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
  rule _{s : store, vt : vectype, c : vec_(vt)}:
    `%|-%:%`(s, VCONST_vec(vt, c), vt)

;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
rec {

;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:25.1-25.60
relation Ref_ok: `%|-%:%`(store, ref, reftype)
  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:35.1-37.35
  rule null{s : store, ht : heaptype, ht' : heaptype}:
    `%|-%:%`(s, REF.NULL_ref(ht), REF_reftype(?(NULL_null), ht'))
    -- Heaptype_sub: `%|-%<:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, ht', ht)

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:39.1-40.33
  rule i31{s : store, i : u31}:
    `%|-%:%`(s, REF.I31_NUM_ref(i), REF_reftype(?(), I31_heaptype))

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:42.1-44.31
  rule struct{s : store, a : addr, dt : deftype}:
    `%|-%:%`(s, REF.STRUCT_ADDR_ref(a), REF_reftype(?(), (dt : deftype <: heaptype)))
    -- if (s.STRUCTS_store[a].TYPE_structinst = dt)

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:46.1-48.30
  rule array{s : store, a : addr, dt : deftype}:
    `%|-%:%`(s, REF.ARRAY_ADDR_ref(a), REF_reftype(?(), (dt : deftype <: heaptype)))
    -- if (s.ARRAYS_store[a].TYPE_arrayinst = dt)

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:50.1-52.29
  rule func{s : store, a : addr, dt : deftype}:
    `%|-%:%`(s, REF.FUNC_ADDR_ref(a), REF_reftype(?(), (dt : deftype <: heaptype)))
    -- if (s.FUNCS_store[a].TYPE_funcinst = dt)

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:54.1-56.24
  rule exn{s : store, a : addr, exn : exninst}:
    `%|-%:%`(s, REF.EXN_ADDR_ref(a), REF_reftype(?(), EXN_heaptype))
    -- if (s.EXNS_store[a] = exn)

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:58.1-59.35
  rule host{s : store, a : addr}:
    `%|-%:%`(s, REF.HOST_ADDR_ref(a), REF_reftype(?(), ANY_heaptype))

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:61.1-63.38
  rule extern{s : store, addrref : addrref}:
    `%|-%:%`(s, REF.EXTERN_ref(addrref), REF_reftype(?(), EXTERN_heaptype))
    -- Ref_ok: `%|-%:%`(s, (addrref : addrref <: ref), REF_reftype(?(), ANY_heaptype))

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:65.1-68.34
  rule sub{s : store, ref : ref, rt : reftype, rt' : reftype}:
    `%|-%:%`(s, ref, rt)
    -- Ref_ok: `%|-%:%`(s, ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt', rt)
}

;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
relation Val_ok: `%|-%:%`(store, val, valtype)
  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
  rule num{s : store, num : num, nt : numtype}:
    `%|-%:%`(s, (num : num <: val), (nt : numtype <: valtype))
    -- Num_ok: `%|-%:%`(s, num, nt)

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
  rule vec{s : store, vec : vec, vt : vectype}:
    `%|-%:%`(s, (vec : vec <: val), (vt : vectype <: valtype))
    -- Vec_ok: `%|-%:%`(s, vec, vt)

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
  rule ref{s : store, ref : ref, rt : reftype}:
    `%|-%:%`(s, (ref : ref <: val), (rt : reftype <: valtype))
    -- Ref_ok: `%|-%:%`(s, ref, rt)

;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec
rec {

;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:86.1-86.84
relation Externaddr_ok: `%|-%:%`(store, externaddr, externtype)
  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:88.1-90.28
  rule tag{s : store, a : addr, taginst : taginst}:
    `%|-%:%`(s, TAG_externaddr(a), TAG_externtype(taginst.TYPE_taginst))
    -- if (s.TAGS_store[a] = taginst)

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:92.1-94.34
  rule global{s : store, a : addr, globalinst : globalinst}:
    `%|-%:%`(s, GLOBAL_externaddr(a), GLOBAL_externtype(globalinst.TYPE_globalinst))
    -- if (s.GLOBALS_store[a] = globalinst)

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:96.1-98.28
  rule mem{s : store, a : addr, meminst : meminst}:
    `%|-%:%`(s, MEM_externaddr(a), MEM_externtype(meminst.TYPE_meminst))
    -- if (s.MEMS_store[a] = meminst)

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:100.1-102.32
  rule table{s : store, a : addr, tableinst : tableinst}:
    `%|-%:%`(s, TABLE_externaddr(a), TABLE_externtype(tableinst.TYPE_tableinst))
    -- if (s.TABLES_store[a] = tableinst)

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:104.1-106.30
  rule func{s : store, a : addr, funcinst : funcinst}:
    `%|-%:%`(s, FUNC_externaddr(a), FUNC_externtype((funcinst.TYPE_funcinst : deftype <: typeuse)))
    -- if (s.FUNCS_store[a] = funcinst)

  ;; ../../../../specification/wasm-3.0/4.1-execution.values.spectec:108.1-111.37
  rule sub{s : store, externaddr : externaddr, xt : externtype, xt' : externtype}:
    `%|-%:%`(s, externaddr, xt)
    -- Externaddr_ok: `%|-%:%`(s, externaddr, xt')
    -- Externtype_sub: `%|-%<:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, xt', xt)
}

;; ../../../../specification/wasm-3.0/4.2-execution.types.spectec
def $inst_valtype(moduleinst : moduleinst, valtype : valtype) : valtype
  ;; ../../../../specification/wasm-3.0/4.2-execution.types.spectec
  def $inst_valtype{moduleinst : moduleinst, t : valtype, `dt*` : deftype*}(moduleinst, t) = $subst_all_valtype(t, (dt : deftype <: typeuse)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = moduleinst.TYPES_moduleinst)

;; ../../../../specification/wasm-3.0/4.2-execution.types.spectec
def $inst_reftype(moduleinst : moduleinst, reftype : reftype) : reftype
  ;; ../../../../specification/wasm-3.0/4.2-execution.types.spectec
  def $inst_reftype{moduleinst : moduleinst, rt : reftype, `dt*` : deftype*}(moduleinst, rt) = $subst_all_reftype(rt, (dt : deftype <: typeuse)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = moduleinst.TYPES_moduleinst)

;; ../../../../specification/wasm-3.0/4.2-execution.types.spectec
def $inst_globaltype(moduleinst : moduleinst, globaltype : globaltype) : globaltype
  ;; ../../../../specification/wasm-3.0/4.2-execution.types.spectec
  def $inst_globaltype{moduleinst : moduleinst, gt : globaltype, `dt*` : deftype*}(moduleinst, gt) = $subst_all_globaltype(gt, (dt : deftype <: typeuse)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = moduleinst.TYPES_moduleinst)

;; ../../../../specification/wasm-3.0/4.2-execution.types.spectec
def $inst_memtype(moduleinst : moduleinst, memtype : memtype) : memtype
  ;; ../../../../specification/wasm-3.0/4.2-execution.types.spectec
  def $inst_memtype{moduleinst : moduleinst, mt : memtype, `dt*` : deftype*}(moduleinst, mt) = $subst_all_memtype(mt, (dt : deftype <: typeuse)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = moduleinst.TYPES_moduleinst)

;; ../../../../specification/wasm-3.0/4.2-execution.types.spectec
def $inst_tabletype(moduleinst : moduleinst, tabletype : tabletype) : tabletype
  ;; ../../../../specification/wasm-3.0/4.2-execution.types.spectec
  def $inst_tabletype{moduleinst : moduleinst, tt : tabletype, `dt*` : deftype*}(moduleinst, tt) = $subst_all_tabletype(tt, (dt : deftype <: typeuse)*{dt <- `dt*`})
    -- if (dt*{dt <- `dt*`} = moduleinst.TYPES_moduleinst)

;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
relation Step_pure: `%~>%`(instr*, instr*)
  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule unreachable:
    `%~>%`([UNREACHABLE_instr], [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule nop:
    `%~>%`([NOP_instr], [])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule drop{val : val}:
    `%~>%`([(val : val <: instr) DROP_instr], [])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `select-true`{val_1 : val, val_2 : val, c : num_(I32_numtype), `t*?` : valtype*?}:
    `%~>%`([(val_1 : val <: instr) (val_2 : val <: instr) CONST_instr(I32_numtype, c) SELECT_instr(t*{t <- `t*`}?{`t*` <- `t*?`})], [(val_1 : val <: instr)])
    -- if (c!`%`_num_.0 =/= 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `select-false`{val_1 : val, val_2 : val, c : num_(I32_numtype), `t*?` : valtype*?}:
    `%~>%`([(val_1 : val <: instr) (val_2 : val <: instr) CONST_instr(I32_numtype, c) SELECT_instr(t*{t <- `t*`}?{`t*` <- `t*?`})], [(val_2 : val <: instr)])
    -- if (c!`%`_num_.0 = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `if-true`{c : num_(I32_numtype), bt : blocktype, `instr_1*` : instr*, `instr_2*` : instr*}:
    `%~>%`([CONST_instr(I32_numtype, c) `IF%%ELSE%`_instr(bt, instr_1*{instr_1 <- `instr_1*`}, instr_2*{instr_2 <- `instr_2*`})], [BLOCK_instr(bt, instr_1*{instr_1 <- `instr_1*`})])
    -- if (c!`%`_num_.0 =/= 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `if-false`{c : num_(I32_numtype), bt : blocktype, `instr_1*` : instr*, `instr_2*` : instr*}:
    `%~>%`([CONST_instr(I32_numtype, c) `IF%%ELSE%`_instr(bt, instr_1*{instr_1 <- `instr_1*`}, instr_2*{instr_2 <- `instr_2*`})], [BLOCK_instr(bt, instr_2*{instr_2 <- `instr_2*`})])
    -- if (c!`%`_num_.0 = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `label-vals`{n : n, `instr*` : instr*, `val*` : val*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr*{instr <- `instr*`}, (val : val <: instr)*{val <- `val*`})], (val : val <: instr)*{val <- `val*`})

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br-label-zero`{n : n, `instr'*` : instr*, `val'*` : val*, `val*` : val*, l : labelidx, `instr*` : instr*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr'*{instr' <- `instr'*`}, (val' : val <: instr)*{val' <- `val'*`} ++ (val : val <: instr)^n{val <- `val*`} ++ [BR_instr(l)] ++ instr*{instr <- `instr*`})], (val : val <: instr)^n{val <- `val*`} ++ instr'*{instr' <- `instr'*`})
    -- if (l!`%`_labelidx.0 = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br-label-succ`{n : n, `instr'*` : instr*, `val*` : val*, l : labelidx, `instr*` : instr*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr'*{instr' <- `instr'*`}, (val : val <: instr)*{val <- `val*`} ++ [BR_instr(l)] ++ instr*{instr <- `instr*`})], (val : val <: instr)*{val <- `val*`} ++ [BR_instr(`%`_labelidx((((l!`%`_labelidx.0 : nat <:> int) - (1 : nat <:> int)) : int <:> nat)))])
    -- if (l!`%`_labelidx.0 > 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br-handler`{n : n, `catch*` : catch*, `val*` : val*, l : labelidx, `instr*` : instr*}:
    `%~>%`([`HANDLER_%{%}%`_instr(n, catch*{catch <- `catch*`}, (val : val <: instr)*{val <- `val*`} ++ [BR_instr(l)] ++ instr*{instr <- `instr*`})], (val : val <: instr)*{val <- `val*`} ++ [BR_instr(l)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br_if-true`{c : num_(I32_numtype), l : labelidx}:
    `%~>%`([CONST_instr(I32_numtype, c) BR_IF_instr(l)], [BR_instr(l)])
    -- if (c!`%`_num_.0 =/= 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br_if-false`{c : num_(I32_numtype), l : labelidx}:
    `%~>%`([CONST_instr(I32_numtype, c) BR_IF_instr(l)], [])
    -- if (c!`%`_num_.0 = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br_table-lt`{i : num_(I32_numtype), `l*` : labelidx*, l' : labelidx}:
    `%~>%`([CONST_instr(I32_numtype, i) BR_TABLE_instr(l*{l <- `l*`}, l')], [BR_instr(l*{l <- `l*`}[i!`%`_num_.0])])
    -- if (i!`%`_num_.0 < |l*{l <- `l*`}|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br_table-ge`{i : num_(I32_numtype), `l*` : labelidx*, l' : labelidx}:
    `%~>%`([CONST_instr(I32_numtype, i) BR_TABLE_instr(l*{l <- `l*`}, l')], [BR_instr(l')])
    -- if (i!`%`_num_.0 >= |l*{l <- `l*`}|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br_on_null-null`{val : val, l : labelidx, ht : heaptype}:
    `%~>%`([(val : val <: instr) BR_ON_NULL_instr(l)], [BR_instr(l)])
    -- if (val = REF.NULL_val(ht))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br_on_null-addr`{val : val, l : labelidx}:
    `%~>%`([(val : val <: instr) BR_ON_NULL_instr(l)], [(val : val <: instr)])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br_on_non_null-null`{val : val, l : labelidx, ht : heaptype}:
    `%~>%`([(val : val <: instr) BR_ON_NON_NULL_instr(l)], [])
    -- if (val = REF.NULL_val(ht))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br_on_non_null-addr`{val : val, l : labelidx}:
    `%~>%`([(val : val <: instr) BR_ON_NON_NULL_instr(l)], [(val : val <: instr) BR_instr(l)])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule call_indirect{x : idx, yy : typeuse}:
    `%~>%`([CALL_INDIRECT_instr(x, yy)], [TABLE.GET_instr(x) REF.CAST_instr(REF_reftype(?(NULL_null), (yy : typeuse <: heaptype))) CALL_REF_instr(yy)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule return_call_indirect{x : idx, yy : typeuse}:
    `%~>%`([RETURN_CALL_INDIRECT_instr(x, yy)], [TABLE.GET_instr(x) REF.CAST_instr(REF_reftype(?(NULL_null), (yy : typeuse <: heaptype))) RETURN_CALL_REF_instr(yy)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `frame-vals`{n : n, f : frame, `val*` : val*}:
    `%~>%`([`FRAME_%{%}%`_instr(n, f, (val : val <: instr)^n{val <- `val*`})], (val : val <: instr)^n{val <- `val*`})

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `return-frame`{n : n, f : frame, `val'*` : val*, `val*` : val*, `instr*` : instr*}:
    `%~>%`([`FRAME_%{%}%`_instr(n, f, (val' : val <: instr)*{val' <- `val'*`} ++ (val : val <: instr)^n{val <- `val*`} ++ [RETURN_instr] ++ instr*{instr <- `instr*`})], (val : val <: instr)^n{val <- `val*`})

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `return-label`{n : n, `instr'*` : instr*, `val*` : val*, `instr*` : instr*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr'*{instr' <- `instr'*`}, (val : val <: instr)*{val <- `val*`} ++ [RETURN_instr] ++ instr*{instr <- `instr*`})], (val : val <: instr)*{val <- `val*`} ++ [RETURN_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `return-handler`{n : n, `catch*` : catch*, `val*` : val*, `instr*` : instr*}:
    `%~>%`([`HANDLER_%{%}%`_instr(n, catch*{catch <- `catch*`}, (val : val <: instr)*{val <- `val*`} ++ [RETURN_instr] ++ instr*{instr <- `instr*`})], (val : val <: instr)*{val <- `val*`} ++ [RETURN_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `handler-vals`{n : n, `catch*` : catch*, `val*` : val*}:
    `%~>%`([`HANDLER_%{%}%`_instr(n, catch*{catch <- `catch*`}, (val : val <: instr)*{val <- `val*`})], (val : val <: instr)*{val <- `val*`})

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `trap-instrs`{`val*` : val*, `instr*` : instr*}:
    `%~>%`((val : val <: instr)*{val <- `val*`} ++ [TRAP_instr] ++ instr*{instr <- `instr*`}, [TRAP_instr])
    -- if ((val*{val <- `val*`} =/= []) \/ (instr*{instr <- `instr*`} =/= []))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `trap-label`{n : n, `instr'*` : instr*}:
    `%~>%`([`LABEL_%{%}%`_instr(n, instr'*{instr' <- `instr'*`}, [TRAP_instr])], [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `trap-frame`{n : n, f : frame}:
    `%~>%`([`FRAME_%{%}%`_instr(n, f, [TRAP_instr])], [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule local.tee{val : val, x : idx}:
    `%~>%`([(val : val <: instr) LOCAL.TEE_instr(x)], [(val : val <: instr) (val : val <: instr) LOCAL.SET_instr(x)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule ref.i31{i : num_(I32_numtype)}:
    `%~>%`([CONST_instr(I32_numtype, i) REF.I31_instr], [REF.I31_NUM_instr($wrap__(32, 31, i))])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `ref.is_null-true`{ref : ref, ht : heaptype}:
    `%~>%`([(ref : ref <: instr) REF.IS_NULL_instr], [CONST_instr(I32_numtype, `%`_num_(1))])
    -- if (ref = REF.NULL_ref(ht))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `ref.is_null-false`{ref : ref}:
    `%~>%`([(ref : ref <: instr) REF.IS_NULL_instr], [CONST_instr(I32_numtype, `%`_num_(0))])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `ref.as_non_null-null`{ref : ref, ht : heaptype}:
    `%~>%`([(ref : ref <: instr) REF.AS_NON_NULL_instr], [TRAP_instr])
    -- if (ref = REF.NULL_ref(ht))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `ref.as_non_null-addr`{ref : ref}:
    `%~>%`([(ref : ref <: instr) REF.AS_NON_NULL_instr], [(ref : ref <: instr)])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `ref.eq-null`{ref_1 : ref, ref_2 : ref, ht_1 : heaptype, ht_2 : heaptype}:
    `%~>%`([(ref_1 : ref <: instr) (ref_2 : ref <: instr) REF.EQ_instr], [CONST_instr(I32_numtype, `%`_num_(1))])
    -- if ((ref_1 = REF.NULL_ref(ht_1)) /\ (ref_2 = REF.NULL_ref(ht_2)))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `ref.eq-true`{ref_1 : ref, ref_2 : ref}:
    `%~>%`([(ref_1 : ref <: instr) (ref_2 : ref <: instr) REF.EQ_instr], [CONST_instr(I32_numtype, `%`_num_(1))])
    -- otherwise
    -- if (ref_1 = ref_2)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `ref.eq-false`{ref_1 : ref, ref_2 : ref}:
    `%~>%`([(ref_1 : ref <: instr) (ref_2 : ref <: instr) REF.EQ_instr], [CONST_instr(I32_numtype, `%`_num_(0))])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `i31.get-null`{ht : heaptype, sx : sx}:
    `%~>%`([REF.NULL_instr(ht) I31.GET_instr(sx)], [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `i31.get-num`{i : u31, sx : sx}:
    `%~>%`([REF.I31_NUM_instr(i) I31.GET_instr(sx)], [CONST_instr(I32_numtype, $extend__(31, 32, sx, i))])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule array.new{val : val, n : n, x : idx}:
    `%~>%`([(val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_instr(x)], (val : val <: instr)^n{} ++ [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `extern.convert_any-null`{ht : heaptype}:
    `%~>%`([REF.NULL_instr(ht) EXTERN.CONVERT_ANY_instr], [REF.NULL_instr(EXTERN_heaptype)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `extern.convert_any-addr`{addrref : addrref}:
    `%~>%`([(addrref : addrref <: instr) EXTERN.CONVERT_ANY_instr], [REF.EXTERN_instr(addrref)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `any.convert_extern-null`{ht : heaptype}:
    `%~>%`([REF.NULL_instr(ht) ANY.CONVERT_EXTERN_instr], [REF.NULL_instr(ANY_heaptype)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `any.convert_extern-addr`{addrref : addrref}:
    `%~>%`([REF.EXTERN_instr(addrref) ANY.CONVERT_EXTERN_instr], [(addrref : addrref <: instr)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `unop-val`{nt : numtype, c_1 : num_(nt), unop : unop_(nt), c : num_(nt)}:
    `%~>%`([CONST_instr(nt, c_1) UNOP_instr(nt, unop)], [CONST_instr(nt, c)])
    -- if (c <- $unop_(nt, unop, c_1))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `unop-trap`{nt : numtype, c_1 : num_(nt), unop : unop_(nt)}:
    `%~>%`([CONST_instr(nt, c_1) UNOP_instr(nt, unop)], [TRAP_instr])
    -- if ($unop_(nt, unop, c_1) = [])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `binop-val`{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), binop : binop_(nt), c : num_(nt)}:
    `%~>%`([CONST_instr(nt, c_1) CONST_instr(nt, c_2) BINOP_instr(nt, binop)], [CONST_instr(nt, c)])
    -- if (c <- $binop_(nt, binop, c_1, c_2))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `binop-trap`{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), binop : binop_(nt)}:
    `%~>%`([CONST_instr(nt, c_1) CONST_instr(nt, c_2) BINOP_instr(nt, binop)], [TRAP_instr])
    -- if ($binop_(nt, binop, c_1, c_2) = [])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule testop{nt : numtype, c_1 : num_(nt), testop : testop_(nt), c : num_(I32_numtype)}:
    `%~>%`([CONST_instr(nt, c_1) TESTOP_instr(nt, testop)], [CONST_instr(I32_numtype, c)])
    -- if (c = $testop_(nt, testop, c_1))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule relop{nt : numtype, c_1 : num_(nt), c_2 : num_(nt), relop : relop_(nt), c : num_(I32_numtype)}:
    `%~>%`([CONST_instr(nt, c_1) CONST_instr(nt, c_2) RELOP_instr(nt, relop)], [CONST_instr(I32_numtype, c)])
    -- if (c = $relop_(nt, relop, c_1, c_2))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `cvtop-val`{nt_1 : numtype, c_1 : num_(nt_1), nt_2 : numtype, cvtop : cvtop__(nt_1, nt_2), c : num_(nt_2)}:
    `%~>%`([CONST_instr(nt_1, c_1) CVTOP_instr(nt_2, nt_1, cvtop)], [CONST_instr(nt_2, c)])
    -- if (c <- $cvtop__(nt_1, nt_2, cvtop, c_1))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `cvtop-trap`{nt_1 : numtype, c_1 : num_(nt_1), nt_2 : numtype, cvtop : cvtop__(nt_1, nt_2)}:
    `%~>%`([CONST_instr(nt_1, c_1) CVTOP_instr(nt_2, nt_1, cvtop)], [TRAP_instr])
    -- if ($cvtop__(nt_1, nt_2, cvtop, c_1) = [])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vvunop{c_1 : vec_(V128_Vnn), vvunop : vvunop, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VVUNOP_instr(V128_vectype, vvunop)], [VCONST_instr(V128_vectype, c)])
    -- if (c <- $vvunop_(V128_vectype, vvunop, c_1))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vvbinop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), vvbinop : vvbinop, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VVBINOP_instr(V128_vectype, vvbinop)], [VCONST_instr(V128_vectype, c)])
    -- if (c <- $vvbinop_(V128_vectype, vvbinop, c_1, c_2))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vvternop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c_3 : vec_(V128_Vnn), vvternop : vvternop, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VCONST_instr(V128_vectype, c_3) VVTERNOP_instr(V128_vectype, vvternop)], [VCONST_instr(V128_vectype, c)])
    -- if (c <- $vvternop_(V128_vectype, vvternop, c_1, c_2, c_3))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vvtestop{c_1 : vec_(V128_Vnn), c : num_(I32_numtype)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VVTESTOP_instr(V128_vectype, ANY_TRUE_vvtestop)], [CONST_instr(I32_numtype, c)])
    -- if (c = $inez_($vsize(V128_vectype), c_1))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vunop-val`{c_1 : vec_(V128_Vnn), sh : shape, vunop : vunop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VUNOP_instr(sh, vunop)], [VCONST_instr(V128_vectype, c)])
    -- if (c <- $vunop_(sh, vunop, c_1))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vunop-trap`{c_1 : vec_(V128_Vnn), sh : shape, vunop : vunop_(sh)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VUNOP_instr(sh, vunop)], [TRAP_instr])
    -- if ($vunop_(sh, vunop, c_1) = [])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vbinop-val`{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh : shape, vbinop : vbinop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VBINOP_instr(sh, vbinop)], [VCONST_instr(V128_vectype, c)])
    -- if (c <- $vbinop_(sh, vbinop, c_1, c_2))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vbinop-trap`{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh : shape, vbinop : vbinop_(sh)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VBINOP_instr(sh, vbinop)], [TRAP_instr])
    -- if ($vbinop_(sh, vbinop, c_1, c_2) = [])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vternop-val`{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c_3 : vec_(V128_Vnn), sh : shape, vternop : vternop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VCONST_instr(V128_vectype, c_3) VTERNOP_instr(sh, vternop)], [VCONST_instr(V128_vectype, c)])
    -- if (c <- $vternop_(sh, vternop, c_1, c_2, c_3))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vternop-trap`{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c_3 : vec_(V128_Vnn), sh : shape, vternop : vternop_(sh)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VCONST_instr(V128_vectype, c_3) VTERNOP_instr(sh, vternop)], [TRAP_instr])
    -- if ($vternop_(sh, vternop, c_1, c_2, c_3) = [])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vtestop{c_1 : vec_(V128_Vnn), Jnn : Jnn, M : M, c : num_(I32_numtype), `i*` : lane_($lanetype(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M))))*}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VTESTOP_instr(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), ALL_TRUE_vtestop_)], [CONST_instr(I32_numtype, c)])
    -- if (i*{i <- `i*`} = $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c_1))
    -- if (c!`%`_num_.0 = $prod($inez_($jsizenn(Jnn), i)!`%`_u32.0*{i <- `i*`}))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vrelop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh : shape, vrelop : vrelop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VRELOP_instr(sh, vrelop)], [VCONST_instr(V128_vectype, c)])
    -- if (c = $vrelop_(sh, vrelop, c_1, c_2))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vshiftop{c_1 : vec_(V128_Vnn), i : num_(I32_numtype), sh : ishape, vshiftop : vshiftop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) CONST_instr(I32_numtype, i) VSHIFTOP_instr(sh, vshiftop)], [VCONST_instr(V128_vectype, c)])
    -- if (c = $vshiftop_(sh, vshiftop, c_1, i))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vbitmask{c_1 : vec_(V128_Vnn), sh : ishape, c : num_(I32_numtype)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VBITMASK_instr(sh)], [CONST_instr(I32_numtype, c)])
    -- if (c = $vbitmaskop_(sh, c_1))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vswizzlop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh : bshape, swizzlop : vswizzlop_(sh), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VSWIZZLOP_instr(sh, swizzlop)], [VCONST_instr(V128_vectype, c)])
    -- if (c = $vswizzlop_(sh, swizzlop, c_1, c_2))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vshuffle{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh : bshape, `i*` : laneidx*, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VSHUFFLE_instr(sh, i*{i <- `i*`})], [VCONST_instr(V128_vectype, c)])
    -- if (c = $vshufflop_(sh, i*{i <- `i*`}, c_1, c_2))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vsplat{Lnn : Lnn, c_1 : num_($lunpack(Lnn)), M : M, c : vec_(V128_Vnn)}:
    `%~>%`([CONST_instr($lunpack(Lnn), c_1) VSPLAT_instr(`%X%`_shape(Lnn, `%`_dim(M)))], [VCONST_instr(V128_vectype, c)])
    -- if (c = $inv_lanes_(`%X%`_shape(Lnn, `%`_dim(M)), $lpacknum_(Lnn, c_1)^M{}))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vextract_lane-num`{c_1 : vec_(V128_Vnn), nt : numtype, M : M, i : laneidx, c_2 : num_(nt)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VEXTRACT_LANE_instr(`%X%`_shape((nt : numtype <: lanetype), `%`_dim(M)), ?(), i)], [CONST_instr(nt, c_2)])
    -- if (c_2 = $lanes_(`%X%`_shape((nt : numtype <: lanetype), `%`_dim(M)), c_1)[i!`%`_laneidx.0])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vextract_lane-pack`{c_1 : vec_(V128_Vnn), pt : packtype, M : M, sx : sx, i : laneidx, c_2 : num_(I32_numtype)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VEXTRACT_LANE_instr(`%X%`_shape((pt : packtype <: lanetype), `%`_dim(M)), ?(sx), i)], [CONST_instr(I32_numtype, c_2)])
    -- if (c_2 = $extend__($psize(pt), 32, sx, $lanes_(`%X%`_shape((pt : packtype <: lanetype), `%`_dim(M)), c_1)[i!`%`_laneidx.0]))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vreplace_lane{c_1 : vec_(V128_Vnn), Lnn : Lnn, c_2 : num_($lunpack(Lnn)), M : M, i : laneidx, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) CONST_instr($lunpack(Lnn), c_2) VREPLACE_LANE_instr(`%X%`_shape(Lnn, `%`_dim(M)), i)], [VCONST_instr(V128_vectype, c)])
    -- if (c = $inv_lanes_(`%X%`_shape(Lnn, `%`_dim(M)), $lanes_(`%X%`_shape(Lnn, `%`_dim(M)), c_1)[[i!`%`_laneidx.0] = $lpacknum_(Lnn, c_2)]))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vextunop{c_1 : vec_(V128_Vnn), sh_2 : ishape, sh_1 : ishape, vextunop : vextunop__(sh_1, sh_2), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VEXTUNOP_instr(sh_2, sh_1, vextunop)], [VCONST_instr(V128_vectype, c)])
    -- if ($vextunop__(sh_1, sh_2, vextunop, c_1) = c)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vextbinop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh_2 : ishape, sh_1 : ishape, vextbinop : vextbinop__(sh_1, sh_2), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VEXTBINOP_instr(sh_2, sh_1, vextbinop)], [VCONST_instr(V128_vectype, c)])
    -- if ($vextbinop__(sh_1, sh_2, vextbinop, c_1, c_2) = c)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vextternop{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), c_3 : vec_(V128_Vnn), sh_2 : ishape, sh_1 : ishape, vextternop : vextternop__(sh_1, sh_2), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VCONST_instr(V128_vectype, c_3) VEXTTERNOP_instr(sh_2, sh_1, vextternop)], [VCONST_instr(V128_vectype, c)])
    -- if ($vextternop__(sh_1, sh_2, vextternop, c_1, c_2, c_3) = c)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vnarrow{c_1 : vec_(V128_Vnn), c_2 : vec_(V128_Vnn), sh_2 : ishape, sh_1 : ishape, sx : sx, c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCONST_instr(V128_vectype, c_2) VNARROW_instr(sh_2, sh_1, sx)], [VCONST_instr(V128_vectype, c)])
    -- if (c = $vnarrowop__(sh_1!`%`_ishape.0, sh_2!`%`_ishape.0, sx, c_1, c_2))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule vcvtop{c_1 : vec_(V128_Vnn), sh_2 : shape, sh_1 : shape, vcvtop : vcvtop__(sh_1, sh_2), c : vec_(V128_Vnn)}:
    `%~>%`([VCONST_instr(V128_vectype, c_1) VCVTOP_instr(sh_2, sh_1, vcvtop)], [VCONST_instr(V128_vectype, c)])
    -- if (c = $vcvtop__(sh_1, sh_2, vcvtop, c_1))

;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
def $blocktype_(state : state, blocktype : blocktype) : instrtype
  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  def $blocktype_{z : state, x : idx, `t_1*` : valtype*, `t_2*` : valtype*}(z, _IDX_blocktype(x)) = `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`}))
    -- Expand: `%~~%`($type(z, x), `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))
  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  def $blocktype_{z : state, `t?` : valtype?}(z, _RESULT_blocktype(t?{t <- `t?`})) = `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype(lift(t?{t <- `t?`})))

;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
relation Step_read: `%~>%`(config, instr*)
  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule block{z : state, `val*` : val*, m : m, bt : blocktype, `instr*` : instr*, n : n, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^m{val <- `val*`} ++ [BLOCK_instr(bt, instr*{instr <- `instr*`})]), [`LABEL_%{%}%`_instr(n, [], (val : val <: instr)^m{val <- `val*`} ++ instr*{instr <- `instr*`})])
    -- if ($blocktype_(z, bt) = `%->_%%`_instrtype(`%`_resulttype(t_1^m{t_1 <- `t_1*`}), [], `%`_resulttype(t_2^n{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule loop{z : state, `val*` : val*, m : m, bt : blocktype, `instr*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*, n : n}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^m{val <- `val*`} ++ [LOOP_instr(bt, instr*{instr <- `instr*`})]), [`LABEL_%{%}%`_instr(m, [LOOP_instr(bt, instr*{instr <- `instr*`})], (val : val <: instr)^m{val <- `val*`} ++ instr*{instr <- `instr*`})])
    -- if ($blocktype_(z, bt) = `%->_%%`_instrtype(`%`_resulttype(t_1^m{t_1 <- `t_1*`}), [], `%`_resulttype(t_2^n{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br_on_cast-succeed`{s : store, f : frame, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype, rt : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) BR_ON_CAST_instr(l, rt_1, rt_2)]), [(ref : ref <: instr) BR_instr(l)])
    -- Ref_ok: `%|-%:%`(s, ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt, $inst_reftype(f.MODULE_frame, rt_2))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br_on_cast-fail`{s : store, f : frame, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) BR_ON_CAST_instr(l, rt_1, rt_2)]), [(ref : ref <: instr)])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br_on_cast_fail-succeed`{s : store, f : frame, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype, rt : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) BR_ON_CAST_FAIL_instr(l, rt_1, rt_2)]), [(ref : ref <: instr)])
    -- Ref_ok: `%|-%:%`(s, ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt, $inst_reftype(f.MODULE_frame, rt_2))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `br_on_cast_fail-fail`{s : store, f : frame, ref : ref, l : labelidx, rt_1 : reftype, rt_2 : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) BR_ON_CAST_FAIL_instr(l, rt_1, rt_2)]), [(ref : ref <: instr) BR_instr(l)])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule call{z : state, x : idx, a : addr}:
    `%~>%`(`%;%`_config(z, [CALL_instr(x)]), [REF.FUNC_ADDR_instr(a) CALL_REF_instr(($funcinst(z)[a].TYPE_funcinst : deftype <: typeuse))])
    -- if ($moduleinst(z).FUNCS_moduleinst[x!`%`_idx.0] = a)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `call_ref-null`{z : state, ht : heaptype, yy : typeuse}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CALL_REF_instr(yy)]), [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `call_ref-func`{z : state, `val*` : val*, n : n, a : addr, yy : typeuse, m : m, f : frame, `instr*` : instr*, fi : funcinst, `t_1*` : valtype*, `t_2*` : valtype*, x : idx, `t*` : valtype*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^n{val <- `val*`} ++ [REF.FUNC_ADDR_instr(a) CALL_REF_instr(yy)]), [`FRAME_%{%}%`_instr(m, f, [`LABEL_%{%}%`_instr(m, [], instr*{instr <- `instr*`})])])
    -- if ($funcinst(z)[a] = fi)
    -- Expand: `%~~%`(fi.TYPE_funcinst, `FUNC%->%`_comptype(`%`_resulttype(t_1^n{t_1 <- `t_1*`}), `%`_resulttype(t_2^m{t_2 <- `t_2*`})))
    -- if (fi.CODE_funcinst = FUNC_funccode(x, LOCAL_local(t)*{t <- `t*`}, instr*{instr <- `instr*`}))
    -- if (f = {LOCALS ?(val)^n{val <- `val*`} ++ $default_(t)*{t <- `t*`}, MODULE fi.MODULE_funcinst})

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule return_call{z : state, x : idx, a : addr}:
    `%~>%`(`%;%`_config(z, [RETURN_CALL_instr(x)]), [REF.FUNC_ADDR_instr(a) RETURN_CALL_REF_instr(($funcinst(z)[a].TYPE_funcinst : deftype <: typeuse))])
    -- if ($moduleinst(z).FUNCS_moduleinst[x!`%`_idx.0] = a)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `return_call_ref-label`{z : state, k : n, `instr'*` : instr*, `val*` : val*, yy : typeuse, `instr*` : instr*}:
    `%~>%`(`%;%`_config(z, [`LABEL_%{%}%`_instr(k, instr'*{instr' <- `instr'*`}, (val : val <: instr)*{val <- `val*`} ++ [RETURN_CALL_REF_instr(yy)] ++ instr*{instr <- `instr*`})]), (val : val <: instr)*{val <- `val*`} ++ [RETURN_CALL_REF_instr(yy)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `return_call_ref-handler`{z : state, k : n, `catch*` : catch*, `val*` : val*, yy : typeuse, `instr*` : instr*}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(k, catch*{catch <- `catch*`}, (val : val <: instr)*{val <- `val*`} ++ [RETURN_CALL_REF_instr(yy)] ++ instr*{instr <- `instr*`})]), (val : val <: instr)*{val <- `val*`} ++ [RETURN_CALL_REF_instr(yy)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `return_call_ref-frame-null`{z : state, k : n, f : frame, `val*` : val*, ht : heaptype, yy : typeuse, `instr*` : instr*}:
    `%~>%`(`%;%`_config(z, [`FRAME_%{%}%`_instr(k, f, (val : val <: instr)*{val <- `val*`} ++ [REF.NULL_instr(ht)] ++ [RETURN_CALL_REF_instr(yy)] ++ instr*{instr <- `instr*`})]), [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `return_call_ref-frame-addr`{z : state, k : n, f : frame, `val'*` : val*, `val*` : val*, n : n, a : addr, yy : typeuse, `instr*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*, m : m}:
    `%~>%`(`%;%`_config(z, [`FRAME_%{%}%`_instr(k, f, (val' : val <: instr)*{val' <- `val'*`} ++ (val : val <: instr)^n{val <- `val*`} ++ [REF.FUNC_ADDR_instr(a)] ++ [RETURN_CALL_REF_instr(yy)] ++ instr*{instr <- `instr*`})]), (val : val <: instr)^n{val <- `val*`} ++ [REF.FUNC_ADDR_instr(a) CALL_REF_instr(yy)])
    -- Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, `FUNC%->%`_comptype(`%`_resulttype(t_1^n{t_1 <- `t_1*`}), `%`_resulttype(t_2^m{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `throw_ref-null`{z : state, ht : heaptype}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) THROW_REF_instr]), [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `throw_ref-instrs`{z : state, `val*` : val*, a : addr, `instr*` : instr*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)*{val <- `val*`} ++ [REF.EXN_ADDR_instr(a)] ++ [THROW_REF_instr] ++ instr*{instr <- `instr*`}), [REF.EXN_ADDR_instr(a) THROW_REF_instr])
    -- if ((val*{val <- `val*`} =/= []) \/ (instr*{instr <- `instr*`} =/= []))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `throw_ref-label`{z : state, n : n, `instr'*` : instr*, a : addr}:
    `%~>%`(`%;%`_config(z, [`LABEL_%{%}%`_instr(n, instr'*{instr' <- `instr'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), [REF.EXN_ADDR_instr(a) THROW_REF_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `throw_ref-frame`{z : state, n : n, f : frame, a : addr}:
    `%~>%`(`%;%`_config(z, [`FRAME_%{%}%`_instr(n, f, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), [REF.EXN_ADDR_instr(a) THROW_REF_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `throw_ref-handler-empty`{z : state, n : n, a : addr}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(n, [], [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), [REF.EXN_ADDR_instr(a) THROW_REF_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `throw_ref-handler-catch`{z : state, n : n, x : idx, l : labelidx, `catch'*` : catch*, a : addr, `val*` : val*}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(n, [CATCH_catch(x, l)] ++ catch'*{catch' <- `catch'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), (val : val <: instr)*{val <- `val*`} ++ [BR_instr(l)])
    -- if ($exninst(z)[a].TAG_exninst = $tagaddr(z)[x!`%`_idx.0])
    -- if (val*{val <- `val*`} = $exninst(z)[a].FIELDS_exninst)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `throw_ref-handler-catch_ref`{z : state, n : n, x : idx, l : labelidx, `catch'*` : catch*, a : addr, `val*` : val*}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(n, [CATCH_REF_catch(x, l)] ++ catch'*{catch' <- `catch'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), (val : val <: instr)*{val <- `val*`} ++ [REF.EXN_ADDR_instr(a) BR_instr(l)])
    -- if ($exninst(z)[a].TAG_exninst = $tagaddr(z)[x!`%`_idx.0])
    -- if (val*{val <- `val*`} = $exninst(z)[a].FIELDS_exninst)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `throw_ref-handler-catch_all`{z : state, n : n, l : labelidx, `catch'*` : catch*, a : addr}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(n, [CATCH_ALL_catch(l)] ++ catch'*{catch' <- `catch'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), [BR_instr(l)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `throw_ref-handler-catch_all_ref`{z : state, n : n, l : labelidx, `catch'*` : catch*, a : addr}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(n, [CATCH_ALL_REF_catch(l)] ++ catch'*{catch' <- `catch'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), [REF.EXN_ADDR_instr(a) BR_instr(l)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `throw_ref-handler-next`{z : state, n : n, catch : catch, `catch'*` : catch*, a : addr}:
    `%~>%`(`%;%`_config(z, [`HANDLER_%{%}%`_instr(n, [catch] ++ catch'*{catch' <- `catch'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])]), [`HANDLER_%{%}%`_instr(n, catch'*{catch' <- `catch'*`}, [REF.EXN_ADDR_instr(a) THROW_REF_instr])])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule try_table{z : state, `val*` : val*, m : m, bt : blocktype, `catch*` : catch*, `instr*` : instr*, n : n, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^m{val <- `val*`} ++ [TRY_TABLE_instr(bt, `%`_list(catch*{catch <- `catch*`}), instr*{instr <- `instr*`})]), [`HANDLER_%{%}%`_instr(n, catch*{catch <- `catch*`}, [`LABEL_%{%}%`_instr(n, [], (val : val <: instr)^m{val <- `val*`} ++ instr*{instr <- `instr*`})])])
    -- if ($blocktype_(z, bt) = `%->_%%`_instrtype(`%`_resulttype(t_1^m{t_1 <- `t_1*`}), [], `%`_resulttype(t_2^n{t_2 <- `t_2*`})))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule local.get{z : state, x : idx, val : val}:
    `%~>%`(`%;%`_config(z, [LOCAL.GET_instr(x)]), [(val : val <: instr)])
    -- if ($local(z, x) = ?(val))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule global.get{z : state, x : idx, val : val}:
    `%~>%`(`%;%`_config(z, [GLOBAL.GET_instr(x)]), [(val : val <: instr)])
    -- if ($global(z, x).VALUE_globalinst = val)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `table.get-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) TABLE.GET_instr(x)]), [TRAP_instr])
    -- if (i!`%`_num_.0 >= |$table(z, x).REFS_tableinst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `table.get-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) TABLE.GET_instr(x)]), [($table(z, x).REFS_tableinst[i!`%`_num_.0] : ref <: instr)])
    -- if (i!`%`_num_.0 < |$table(z, x).REFS_tableinst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule table.size{z : state, x : idx, at : addrtype, n : n, lim : limits, rt : reftype}:
    `%~>%`(`%;%`_config(z, [TABLE.SIZE_instr(x)]), [CONST_instr((at : addrtype <: numtype), `%`_num_(n))])
    -- if (|$table(z, x).REFS_tableinst| = n)
    -- if ($table(z, x).TYPE_tableinst = `%%%`_tabletype(at, lim, rt))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `table.fill-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) (val : val <: instr) CONST_instr((at : addrtype <: numtype), `%`_num_(n)) TABLE.FILL_instr(x)]), [TRAP_instr])
    -- if ((i!`%`_num_.0 + n) > |$table(z, x).REFS_tableinst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `table.fill-zero`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) (val : val <: instr) CONST_instr((at : addrtype <: numtype), `%`_num_(n)) TABLE.FILL_instr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `table.fill-succ`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) (val : val <: instr) CONST_instr((at : addrtype <: numtype), `%`_num_(n)) TABLE.FILL_instr(x)]), [CONST_instr((at : addrtype <: numtype), i) (val : val <: instr) TABLE.SET_instr(x) CONST_instr((at : addrtype <: numtype), `%`_num_((i!`%`_num_.0 + 1))) (val : val <: instr) CONST_instr((at : addrtype <: numtype), `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) TABLE.FILL_instr(x)])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `table.copy-oob`{z : state, at_1 : addrtype, i_1 : num_((at_1 : addrtype <: numtype)), at_2 : addrtype, i_2 : num_((at_2 : addrtype <: numtype)), at' : addrtype, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at_1 : addrtype <: numtype), i_1) CONST_instr((at_2 : addrtype <: numtype), i_2) CONST_instr((at' : addrtype <: numtype), `%`_num_(n)) TABLE.COPY_instr(x_1, x_2)]), [TRAP_instr])
    -- if (((i_1!`%`_num_.0 + n) > |$table(z, x_1).REFS_tableinst|) \/ ((i_2!`%`_num_.0 + n) > |$table(z, x_2).REFS_tableinst|))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `table.copy-zero`{z : state, at_1 : addrtype, i_1 : num_((at_1 : addrtype <: numtype)), at_2 : addrtype, i_2 : num_((at_2 : addrtype <: numtype)), at' : addrtype, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at_1 : addrtype <: numtype), i_1) CONST_instr((at_2 : addrtype <: numtype), i_2) CONST_instr((at' : addrtype <: numtype), `%`_num_(n)) TABLE.COPY_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `table.copy-le`{z : state, at_1 : addrtype, i_1 : num_((at_1 : addrtype <: numtype)), at_2 : addrtype, i_2 : num_((at_2 : addrtype <: numtype)), at' : addrtype, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at_1 : addrtype <: numtype), i_1) CONST_instr((at_2 : addrtype <: numtype), i_2) CONST_instr((at' : addrtype <: numtype), `%`_num_(n)) TABLE.COPY_instr(x, y)]), [CONST_instr((at_1 : addrtype <: numtype), i_1) CONST_instr((at_2 : addrtype <: numtype), i_2) TABLE.GET_instr(y) TABLE.SET_instr(x) CONST_instr((at_1 : addrtype <: numtype), `%`_num_((i_1!`%`_num_.0 + 1))) CONST_instr((at_2 : addrtype <: numtype), `%`_num_((i_2!`%`_num_.0 + 1))) CONST_instr((at' : addrtype <: numtype), `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) TABLE.COPY_instr(x, y)])
    -- otherwise
    -- if (i_1!`%`_num_.0 <= i_2!`%`_num_.0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `table.copy-gt`{z : state, at_1 : addrtype, i_1 : num_((at_1 : addrtype <: numtype)), at_2 : addrtype, i_2 : num_((at_2 : addrtype <: numtype)), at' : addrtype, n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at_1 : addrtype <: numtype), i_1) CONST_instr((at_2 : addrtype <: numtype), i_2) CONST_instr((at' : addrtype <: numtype), `%`_num_(n)) TABLE.COPY_instr(x, y)]), [CONST_instr((at_1 : addrtype <: numtype), `%`_num_(((((i_1!`%`_num_.0 + n) : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) CONST_instr((at_2 : addrtype <: numtype), `%`_num_(((((i_2!`%`_num_.0 + n) : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) TABLE.GET_instr(y) TABLE.SET_instr(x) CONST_instr((at_1 : addrtype <: numtype), i_1) CONST_instr((at_2 : addrtype <: numtype), i_2) CONST_instr((at' : addrtype <: numtype), `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) TABLE.COPY_instr(x, y)])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `table.init-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.INIT_instr(x, y)]), [TRAP_instr])
    -- if (((i!`%`_num_.0 + n) > |$table(z, x).REFS_tableinst|) \/ ((j!`%`_num_.0 + n) > |$elem(z, y).REFS_eleminst|))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `table.init-zero`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.INIT_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `table.init-succ`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.INIT_instr(x, y)]), [CONST_instr((at : addrtype <: numtype), i) ($elem(z, y).REFS_eleminst[j!`%`_num_.0] : ref <: instr) TABLE.SET_instr(x) CONST_instr((at : addrtype <: numtype), `%`_num_((i!`%`_num_.0 + 1))) CONST_instr(I32_numtype, `%`_num_((j!`%`_num_.0 + 1))) CONST_instr(I32_numtype, `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) TABLE.INIT_instr(x, y)])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `load-num-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), nt : numtype, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) LOAD_instr(nt, ?(), x, ao)]), [TRAP_instr])
    -- if (((i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) + ((($size(nt) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) > |$mem(z, x).BYTES_meminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `load-num-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), nt : numtype, x : idx, ao : memarg, c : num_(nt)}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) LOAD_instr(nt, ?(), x, ao)]), [CONST_instr(nt, c)])
    -- if ($nbytes_(nt, c) = $mem(z, x).BYTES_meminst[(i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) : ((($size(nt) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `load-pack-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), Inn : Inn, n : n, sx : sx, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) LOAD_instr((Inn : addrtype <: numtype), ?(`%_%`_loadop_(`%`_sz(n), sx)), x, ao)]), [TRAP_instr])
    -- if (((i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) + (((n : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) > |$mem(z, x).BYTES_meminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `load-pack-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), Inn : Inn, n : n, sx : sx, x : idx, ao : memarg, c : iN(n)}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) LOAD_instr((Inn : addrtype <: numtype), ?(`%_%`_loadop_(`%`_sz(n), sx)), x, ao)]), [CONST_instr((Inn : addrtype <: numtype), $extend__(n, $size((Inn : addrtype <: numtype)), sx, c))])
    -- if ($ibytes_(n, c) = $mem(z, x).BYTES_meminst[(i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) : (((n : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vload-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VLOAD_instr(V128_vectype, ?(), x, ao)]), [TRAP_instr])
    -- if (((i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) + ((($vsize(V128_vectype) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) > |$mem(z, x).BYTES_meminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vload-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), x : idx, ao : memarg, c : vec_(V128_Vnn)}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VLOAD_instr(V128_vectype, ?(), x, ao)]), [VCONST_instr(V128_vectype, c)])
    -- if ($vbytes_(V128_vectype, c) = $mem(z, x).BYTES_meminst[(i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) : ((($vsize(V128_vectype) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vload-pack-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), M : M, K : K, sx : sx, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(M), K, sx)), x, ao)]), [TRAP_instr])
    -- if (((i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) + ((((M * K) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) > |$mem(z, x).BYTES_meminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vload-pack-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), M : M, K : K, sx : sx, x : idx, ao : memarg, c : vec_(V128_Vnn), `j*` : iN(M)*, `k*` : nat*, Jnn : Jnn}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(M), K, sx)), x, ao)]), [VCONST_instr(V128_vectype, c)])
    -- (if ($ibytes_(M, j) = $mem(z, x).BYTES_meminst[((i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) + ((((k * M) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) : (((M : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)]))^(k<K){j <- `j*`, k <- `k*`}
    -- if ((c = $inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(K)), $extend__(M, $jsizenn(Jnn), sx, j)^K{j <- `j*`})) /\ ($jsizenn(Jnn) = (M * 2)))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vload-splat-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), N : N, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(N))), x, ao)]), [TRAP_instr])
    -- if (((i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) + (((N : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) > |$mem(z, x).BYTES_meminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vload-splat-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), N : N, x : idx, ao : memarg, c : vec_(V128_Vnn), j : iN(N), Jnn : Jnn, M : M}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(N))), x, ao)]), [VCONST_instr(V128_vectype, c)])
    -- if ($ibytes_(N, j) = $mem(z, x).BYTES_meminst[(i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) : (((N : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)])
    -- if (N = $jsize(Jnn))
    -- if ((M : nat <:> rat) = ((128 : nat <:> rat) / (N : nat <:> rat)))
    -- if (c = $inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), `%`_lane_(j!`%`_iN.0)^M{}))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vload-zero-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), N : N, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(N))), x, ao)]), [TRAP_instr])
    -- if (((i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) + (((N : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) > |$mem(z, x).BYTES_meminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vload-zero-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), N : N, x : idx, ao : memarg, c : vec_(V128_Vnn), j : iN(N)}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(N))), x, ao)]), [VCONST_instr(V128_vectype, c)])
    -- if ($ibytes_(N, j) = $mem(z, x).BYTES_meminst[(i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) : (((N : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)])
    -- if (c = $extend__(N, 128, U_sx, j))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vload_lane-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), c_1 : vec_(V128_Vnn), N : N, x : idx, ao : memarg, j : laneidx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VCONST_instr(V128_vectype, c_1) VLOAD_LANE_instr(V128_vectype, `%`_sz(N), x, ao, j)]), [TRAP_instr])
    -- if (((i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) + (((N : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) > |$mem(z, x).BYTES_meminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `vload_lane-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), c_1 : vec_(V128_Vnn), N : N, x : idx, ao : memarg, j : laneidx, c : vec_(V128_Vnn), k : iN(N), Jnn : Jnn, M : M}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VCONST_instr(V128_vectype, c_1) VLOAD_LANE_instr(V128_vectype, `%`_sz(N), x, ao, j)]), [VCONST_instr(V128_vectype, c)])
    -- if ($ibytes_(N, k) = $mem(z, x).BYTES_meminst[(i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) : (((N : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)])
    -- if (N = $jsize(Jnn))
    -- if ((M : nat <:> rat) = (($vsize(V128_vectype) : nat <:> rat) / (N : nat <:> rat)))
    -- if (c = $inv_lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), $lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c_1)[[j!`%`_laneidx.0] = `%`_lane_(k!`%`_iN.0)]))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule memory.size{z : state, x : idx, at : addrtype, n : n, lim : limits}:
    `%~>%`(`%;%`_config(z, [MEMORY.SIZE_instr(x)]), [CONST_instr((at : addrtype <: numtype), `%`_num_(n))])
    -- if ((n * (64 * $Ki)) = |$mem(z, x).BYTES_meminst|)
    -- if ($mem(z, x).TYPE_meminst = `%%PAGE`_memtype(at, lim))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `memory.fill-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) (val : val <: instr) CONST_instr((at : addrtype <: numtype), `%`_num_(n)) MEMORY.FILL_instr(x)]), [TRAP_instr])
    -- if ((i!`%`_num_.0 + n) > |$mem(z, x).BYTES_meminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `memory.fill-zero`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) (val : val <: instr) CONST_instr((at : addrtype <: numtype), `%`_num_(n)) MEMORY.FILL_instr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `memory.fill-succ`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) (val : val <: instr) CONST_instr((at : addrtype <: numtype), `%`_num_(n)) MEMORY.FILL_instr(x)]), [CONST_instr((at : addrtype <: numtype), i) (val : val <: instr) STORE_instr(I32_numtype, ?(`%`_storeop_(`%`_sz(8))), x, $memarg0) CONST_instr((at : addrtype <: numtype), `%`_num_((i!`%`_num_.0 + 1))) (val : val <: instr) CONST_instr((at : addrtype <: numtype), `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) MEMORY.FILL_instr(x)])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `memory.copy-oob`{z : state, at_1 : addrtype, i_1 : num_((at_1 : addrtype <: numtype)), at_2 : addrtype, i_2 : num_((at_2 : addrtype <: numtype)), at' : addrtype, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at_1 : addrtype <: numtype), i_1) CONST_instr((at_2 : addrtype <: numtype), i_2) CONST_instr((at' : addrtype <: numtype), `%`_num_(n)) MEMORY.COPY_instr(x_1, x_2)]), [TRAP_instr])
    -- if (((i_1!`%`_num_.0 + n) > |$mem(z, x_1).BYTES_meminst|) \/ ((i_2!`%`_num_.0 + n) > |$mem(z, x_2).BYTES_meminst|))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `memory.copy-zero`{z : state, at_1 : addrtype, i_1 : num_((at_1 : addrtype <: numtype)), at_2 : addrtype, i_2 : num_((at_2 : addrtype <: numtype)), at' : addrtype, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at_1 : addrtype <: numtype), i_1) CONST_instr((at_2 : addrtype <: numtype), i_2) CONST_instr((at' : addrtype <: numtype), `%`_num_(n)) MEMORY.COPY_instr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `memory.copy-le`{z : state, at_1 : addrtype, i_1 : num_((at_1 : addrtype <: numtype)), at_2 : addrtype, i_2 : num_((at_2 : addrtype <: numtype)), at' : addrtype, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at_1 : addrtype <: numtype), i_1) CONST_instr((at_2 : addrtype <: numtype), i_2) CONST_instr((at' : addrtype <: numtype), `%`_num_(n)) MEMORY.COPY_instr(x_1, x_2)]), [CONST_instr((at_1 : addrtype <: numtype), i_1) CONST_instr((at_2 : addrtype <: numtype), i_2) LOAD_instr(I32_numtype, ?(`%_%`_loadop_(`%`_sz(8), U_sx)), x_2, $memarg0) STORE_instr(I32_numtype, ?(`%`_storeop_(`%`_sz(8))), x_1, $memarg0) CONST_instr((at_1 : addrtype <: numtype), `%`_num_((i_1!`%`_num_.0 + 1))) CONST_instr((at_2 : addrtype <: numtype), `%`_num_((i_2!`%`_num_.0 + 1))) CONST_instr((at' : addrtype <: numtype), `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) MEMORY.COPY_instr(x_1, x_2)])
    -- otherwise
    -- if (i_1!`%`_num_.0 <= i_2!`%`_num_.0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `memory.copy-gt`{z : state, at_1 : addrtype, i_1 : num_((at_1 : addrtype <: numtype)), at_2 : addrtype, i_2 : num_((at_2 : addrtype <: numtype)), at' : addrtype, n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at_1 : addrtype <: numtype), i_1) CONST_instr((at_2 : addrtype <: numtype), i_2) CONST_instr((at' : addrtype <: numtype), `%`_num_(n)) MEMORY.COPY_instr(x_1, x_2)]), [CONST_instr((at_1 : addrtype <: numtype), `%`_num_(((((i_1!`%`_num_.0 + n) : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) CONST_instr((at_2 : addrtype <: numtype), `%`_num_(((((i_2!`%`_num_.0 + n) : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) LOAD_instr(I32_numtype, ?(`%_%`_loadop_(`%`_sz(8), U_sx)), x_2, $memarg0) STORE_instr(I32_numtype, ?(`%`_storeop_(`%`_sz(8))), x_1, $memarg0) CONST_instr((at_1 : addrtype <: numtype), i_1) CONST_instr((at_2 : addrtype <: numtype), i_2) CONST_instr((at' : addrtype <: numtype), `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) MEMORY.COPY_instr(x_1, x_2)])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `memory.init-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.INIT_instr(x, y)]), [TRAP_instr])
    -- if (((i!`%`_num_.0 + n) > |$mem(z, x).BYTES_meminst|) \/ ((j!`%`_num_.0 + n) > |$data(z, y).BYTES_datainst|))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `memory.init-zero`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.INIT_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `memory.init-succ`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.INIT_instr(x, y)]), [CONST_instr((at : addrtype <: numtype), i) CONST_instr(I32_numtype, `%`_num_($data(z, y).BYTES_datainst[j!`%`_num_.0]!`%`_byte.0)) STORE_instr(I32_numtype, ?(`%`_storeop_(`%`_sz(8))), x, $memarg0) CONST_instr((at : addrtype <: numtype), `%`_num_((i!`%`_num_.0 + 1))) CONST_instr(I32_numtype, `%`_num_((j!`%`_num_.0 + 1))) CONST_instr(I32_numtype, `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) MEMORY.INIT_instr(x, y)])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `ref.null-idx`{z : state, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(_IDX_heaptype(x))]), [REF.NULL_instr(($type(z, x) : deftype <: heaptype))])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule ref.func{z : state, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.FUNC_instr(x)]), [REF.FUNC_ADDR_instr($moduleinst(z).FUNCS_moduleinst[x!`%`_idx.0])])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `ref.test-true`{s : store, f : frame, ref : ref, rt : reftype, rt' : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) REF.TEST_instr(rt)]), [CONST_instr(I32_numtype, `%`_num_(1))])
    -- Ref_ok: `%|-%:%`(s, ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt', $inst_reftype(f.MODULE_frame, rt))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `ref.test-false`{s : store, f : frame, ref : ref, rt : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) REF.TEST_instr(rt)]), [CONST_instr(I32_numtype, `%`_num_(0))])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `ref.cast-succeed`{s : store, f : frame, ref : ref, rt : reftype, rt' : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) REF.CAST_instr(rt)]), [(ref : ref <: instr)])
    -- Ref_ok: `%|-%:%`(s, ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], RETURN ?(), REFS []}, rt', $inst_reftype(f.MODULE_frame, rt))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `ref.cast-fail`{s : store, f : frame, ref : ref, rt : reftype}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [(ref : ref <: instr) REF.CAST_instr(rt)]), [TRAP_instr])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule struct.new_default{z : state, x : idx, `val*` : val*, `mut?*` : mut?*, `zt*` : storagetype*}:
    `%~>%`(`%;%`_config(z, [STRUCT.NEW_DEFAULT_instr(x)]), (val : val <: instr)*{val <- `val*`} ++ [STRUCT.NEW_instr(x)])
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%`_list(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)*{`mut?` <- `mut?*`, zt <- `zt*`})))
    -- (if ($default_($unpack(zt)) = ?(val)))*{val <- `val*`, zt <- `zt*`}

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `struct.get-null`{z : state, ht : heaptype, `sx?` : sx?, x : idx, i : u32}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) STRUCT.GET_instr(sx?{sx <- `sx?`}, x, i)]), [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `struct.get-struct`{z : state, a : addr, `sx?` : sx?, x : idx, i : u32, `zt*` : storagetype*, `mut?*` : mut?*}:
    `%~>%`(`%;%`_config(z, [REF.STRUCT_ADDR_instr(a) STRUCT.GET_instr(sx?{sx <- `sx?`}, x, i)]), [($unpackfield_(zt*{zt <- `zt*`}[i!`%`_u32.0], sx?{sx <- `sx?`}, $structinst(z)[a].FIELDS_structinst[i!`%`_u32.0]) : val <: instr)])
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%`_list(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)*{`mut?` <- `mut?*`, zt <- `zt*`})))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule array.new_default{z : state, n : n, x : idx, val : val, `mut?` : mut?, zt : storagetype}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_DEFAULT_instr(x)]), (val : val <: instr)^n{} ++ [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))
    -- if ($default_($unpack(zt)) = ?(val))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.new_elem-oob`{z : state, i : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_ELEM_instr(x, y)]), [TRAP_instr])
    -- if ((i!`%`_num_.0 + n) > |$elem(z, y).REFS_eleminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.new_elem-alloc`{z : state, i : num_(I32_numtype), n : n, x : idx, y : idx, `ref*` : ref*}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_ELEM_instr(x, y)]), (ref : ref <: instr)^n{ref <- `ref*`} ++ [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))])
    -- if (ref^n{ref <- `ref*`} = $elem(z, y).REFS_eleminst[i!`%`_num_.0 : n])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.new_data-oob`{z : state, i : num_(I32_numtype), n : n, x : idx, y : idx, `mut?` : mut?, zt : storagetype}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_DATA_instr(x, y)]), [TRAP_instr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))
    -- if ((i!`%`_num_.0 + ((((n * $zsize(zt)) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) > |$data(z, y).BYTES_datainst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.new_data-num`{z : state, i : num_(I32_numtype), n : n, x : idx, y : idx, zt : storagetype, `c*` : lit_(zt)*, `mut?` : mut?}:
    `%~>%`(`%;%`_config(z, [CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.NEW_DATA_instr(x, y)]), $const($cunpack(zt), $cunpacknum_(zt, c))^n{c <- `c*`} ++ [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))
    -- if ($concatn_(syntax byte, $zbytes_(zt, c)^n{c <- `c*`}, ((($zsize(zt) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) = $data(z, y).BYTES_datainst[i!`%`_num_.0 : ((((n * $zsize(zt)) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.get-null`{z : state, ht : heaptype, i : num_(I32_numtype), `sx?` : sx?, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, i) ARRAY.GET_instr(sx?{sx <- `sx?`}, x)]), [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.get-oob`{z : state, a : addr, i : num_(I32_numtype), `sx?` : sx?, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) ARRAY.GET_instr(sx?{sx <- `sx?`}, x)]), [TRAP_instr])
    -- if (i!`%`_num_.0 >= |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.get-array`{z : state, a : addr, i : num_(I32_numtype), `sx?` : sx?, x : idx, zt : storagetype, `mut?` : mut?}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) ARRAY.GET_instr(sx?{sx <- `sx?`}, x)]), [($unpackfield_(zt, sx?{sx <- `sx?`}, $arrayinst(z)[a].FIELDS_arrayinst[i!`%`_num_.0]) : val <: instr)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.len-null`{z : state, ht : heaptype}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) ARRAY.LEN_instr]), [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.len-array`{z : state, a : addr}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) ARRAY.LEN_instr]), [CONST_instr(I32_numtype, `%`_num_(|$arrayinst(z)[a].FIELDS_arrayinst|))])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.fill-null`{z : state, ht : heaptype, i : num_(I32_numtype), val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, i) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.FILL_instr(x)]), [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.fill-oob`{z : state, a : addr, i : num_(I32_numtype), val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.FILL_instr(x)]), [TRAP_instr])
    -- if ((i!`%`_num_.0 + n) > |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.fill-zero`{z : state, a : addr, i : num_(I32_numtype), val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.FILL_instr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.fill-succ`{z : state, a : addr, i : num_(I32_numtype), val : val, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.FILL_instr(x)]), [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) (val : val <: instr) ARRAY.SET_instr(x) REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_((i!`%`_num_.0 + 1))) (val : val <: instr) CONST_instr(I32_numtype, `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) ARRAY.FILL_instr(x)])
    -- otherwise

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.copy-null1`{z : state, ht_1 : heaptype, i_1 : num_(I32_numtype), ref : ref, i_2 : num_(I32_numtype), n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht_1) CONST_instr(I32_numtype, i_1) (ref : ref <: instr) CONST_instr(I32_numtype, i_2) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.copy-null2`{z : state, ref : ref, i_1 : num_(I32_numtype), ht_2 : heaptype, i_2 : num_(I32_numtype), n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [(ref : ref <: instr) CONST_instr(I32_numtype, i_1) REF.NULL_instr(ht_2) CONST_instr(I32_numtype, i_2) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.copy-oob1`{z : state, a_1 : addr, i_1 : num_(I32_numtype), a_2 : addr, i_2 : num_(I32_numtype), n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, i_1) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, i_2) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [TRAP_instr])
    -- if ((i_1!`%`_num_.0 + n) > |$arrayinst(z)[a_1].FIELDS_arrayinst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.copy-oob2`{z : state, a_1 : addr, i_1 : num_(I32_numtype), a_2 : addr, i_2 : num_(I32_numtype), n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, i_1) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, i_2) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [TRAP_instr])
    -- if ((i_2!`%`_num_.0 + n) > |$arrayinst(z)[a_2].FIELDS_arrayinst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.copy-zero`{z : state, a_1 : addr, i_1 : num_(I32_numtype), a_2 : addr, i_2 : num_(I32_numtype), n : n, x_1 : idx, x_2 : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, i_1) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, i_2) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.copy-le`{z : state, a_1 : addr, i_1 : num_(I32_numtype), a_2 : addr, i_2 : num_(I32_numtype), n : n, x_1 : idx, x_2 : idx, `sx?` : sx?, `mut?` : mut?, zt_2 : storagetype}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, i_1) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, i_2) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, i_1) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, i_2) ARRAY.GET_instr(sx?{sx <- `sx?`}, x_2) ARRAY.SET_instr(x_1) REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_((i_1!`%`_num_.0 + 1))) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_((i_2!`%`_num_.0 + 1))) CONST_instr(I32_numtype, `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) ARRAY.COPY_instr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt_2)))
    -- if ((i_1!`%`_num_.0 <= i_2!`%`_num_.0) /\ (sx?{sx <- `sx?`} = $sx(zt_2)))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.copy-gt`{z : state, a_1 : addr, i_1 : num_(I32_numtype), a_2 : addr, i_2 : num_(I32_numtype), n : n, x_1 : idx, x_2 : idx, `sx?` : sx?, `mut?` : mut?, zt_2 : storagetype}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, i_1) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, i_2) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.COPY_instr(x_1, x_2)]), [REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, `%`_num_(((((i_1!`%`_num_.0 + n) : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, `%`_num_(((((i_2!`%`_num_.0 + n) : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) ARRAY.GET_instr(sx?{sx <- `sx?`}, x_2) ARRAY.SET_instr(x_1) REF.ARRAY_ADDR_instr(a_1) CONST_instr(I32_numtype, i_1) REF.ARRAY_ADDR_instr(a_2) CONST_instr(I32_numtype, i_2) CONST_instr(I32_numtype, `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) ARRAY.COPY_instr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt_2)))
    -- if (sx?{sx <- `sx?`} = $sx(zt_2))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.init_elem-null`{z : state, ht : heaptype, i : num_(I32_numtype), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.init_elem-oob1`{z : state, a : addr, i : num_(I32_numtype), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [TRAP_instr])
    -- if ((i!`%`_num_.0 + n) > |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.init_elem-oob2`{z : state, a : addr, i : num_(I32_numtype), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [TRAP_instr])
    -- if ((j!`%`_num_.0 + n) > |$elem(z, y).REFS_eleminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.init_elem-zero`{z : state, a : addr, i : num_(I32_numtype), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.init_elem-succ`{z : state, a : addr, i : num_(I32_numtype), j : num_(I32_numtype), n : n, x : idx, y : idx, ref : ref}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_ELEM_instr(x, y)]), [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) (ref : ref <: instr) ARRAY.SET_instr(x) REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_((i!`%`_num_.0 + 1))) CONST_instr(I32_numtype, `%`_num_((j!`%`_num_.0 + 1))) CONST_instr(I32_numtype, `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) ARRAY.INIT_ELEM_instr(x, y)])
    -- otherwise
    -- if (ref = $elem(z, y).REFS_eleminst[j!`%`_num_.0])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.init_data-null`{z : state, ht : heaptype, i : num_(I32_numtype), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [TRAP_instr])

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.init_data-oob1`{z : state, a : addr, i : num_(I32_numtype), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [TRAP_instr])
    -- if ((i!`%`_num_.0 + n) > |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.init_data-oob2`{z : state, a : addr, i : num_(I32_numtype), j : num_(I32_numtype), n : n, x : idx, y : idx, `mut?` : mut?, zt : storagetype}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [TRAP_instr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))
    -- if ((j!`%`_num_.0 + ((((n * $zsize(zt)) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) > |$data(z, y).BYTES_datainst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.init_data-zero`{z : state, a : addr, i : num_(I32_numtype), j : num_(I32_numtype), n : n, x : idx, y : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule `array.init_data-num`{z : state, a : addr, i : num_(I32_numtype), j : num_(I32_numtype), n : n, x : idx, y : idx, zt : storagetype, c : lit_(zt), `mut?` : mut?}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) CONST_instr(I32_numtype, j) CONST_instr(I32_numtype, `%`_num_(n)) ARRAY.INIT_DATA_instr(x, y)]), [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) $const($cunpack(zt), $cunpacknum_(zt, c)) ARRAY.SET_instr(x) REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, `%`_num_((i!`%`_num_.0 + 1))) CONST_instr(I32_numtype, `%`_num_((j!`%`_num_.0 + ((($zsize(zt) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)))) CONST_instr(I32_numtype, `%`_num_((((n : nat <:> int) - (1 : nat <:> int)) : int <:> nat))) ARRAY.INIT_DATA_instr(x, y)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))
    -- if ($zbytes_(zt, c) = $data(z, y).BYTES_datainst[j!`%`_num_.0 : ((($zsize(zt) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)])

;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
rec {

;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:5.1-5.88
relation Step: `%~>%`(config, config)
  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:13.1-15.34
  rule pure{z : state, `instr*` : instr*, `instr'*` : instr*}:
    `%~>%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z, instr'*{instr' <- `instr'*`}))
    -- Step_pure: `%~>%`(instr*{instr <- `instr*`}, instr'*{instr' <- `instr'*`})

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:17.1-19.37
  rule read{z : state, `instr*` : instr*, `instr'*` : instr*}:
    `%~>%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z, instr'*{instr' <- `instr'*`}))
    -- Step_read: `%~>%`(`%;%`_config(z, instr*{instr <- `instr*`}), instr'*{instr' <- `instr'*`})

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:32.1-35.41
  rule `ctxt-instrs`{z : state, `val*` : val*, `instr*` : instr*, `instr_1*` : instr*, z' : state, `instr'*` : instr*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)*{val <- `val*`} ++ instr*{instr <- `instr*`} ++ instr_1*{instr_1 <- `instr_1*`}), `%;%`_config(z', (val : val <: instr)*{val <- `val*`} ++ instr'*{instr' <- `instr'*`} ++ instr_1*{instr_1 <- `instr_1*`}))
    -- Step: `%~>%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z', instr'*{instr' <- `instr'*`}))
    -- if ((val*{val <- `val*`} =/= []) \/ (instr_1*{instr_1 <- `instr_1*`} =/= []))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:37.1-39.36
  rule `ctxt-label`{z : state, n : n, `instr_0*` : instr*, `instr*` : instr*, z' : state, `instr'*` : instr*}:
    `%~>%`(`%;%`_config(z, [`LABEL_%{%}%`_instr(n, instr_0*{instr_0 <- `instr_0*`}, instr*{instr <- `instr*`})]), `%;%`_config(z', [`LABEL_%{%}%`_instr(n, instr_0*{instr_0 <- `instr_0*`}, instr'*{instr' <- `instr'*`})]))
    -- Step: `%~>%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z', instr'*{instr' <- `instr'*`}))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:41.1-43.45
  rule `ctxt-frame`{s : store, f : frame, n : n, f' : frame, `instr*` : instr*, s' : store, f'' : frame, `instr'*` : instr*}:
    `%~>%`(`%;%`_config(`%;%`_state(s, f), [`FRAME_%{%}%`_instr(n, f', instr*{instr <- `instr*`})]), `%;%`_config(`%;%`_state(s', f), [`FRAME_%{%}%`_instr(n, f'', instr'*{instr' <- `instr'*`})]))
    -- Step: `%~>%`(`%;%`_config(`%;%`_state(s, f'), instr*{instr <- `instr*`}), `%;%`_config(`%;%`_state(s', f''), instr'*{instr' <- `instr'*`}))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:227.1-231.49
  rule throw{z : state, `val*` : val*, n : n, x : idx, exn : exninst, a : addr, `t*` : valtype*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^n{val <- `val*`} ++ [THROW_instr(x)]), `%;%`_config($add_exninst(z, [exn]), [REF.EXN_ADDR_instr(a) THROW_REF_instr]))
    -- Expand: `%~~%`($as_deftype($tag(z, x).TYPE_taginst), `FUNC%->%`_comptype(`%`_resulttype(t^n{t <- `t*`}), `%`_resulttype([])))
    -- if (a = |$exninst(z)|)
    -- if (exn = {TAG $tagaddr(z)[x!`%`_idx.0], FIELDS val^n{val <- `val*`}})

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:302.1-303.56
  rule local.set{z : state, val : val, x : idx}:
    `%~>%`(`%;%`_config(z, [(val : val <: instr) LOCAL.SET_instr(x)]), `%;%`_config($with_local(z, x, val), []))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:315.1-316.58
  rule global.set{z : state, val : val, x : idx}:
    `%~>%`(`%;%`_config(z, [(val : val <: instr) GLOBAL.SET_instr(x)]), `%;%`_config($with_global(z, x, val), []))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:329.1-331.33
  rule `table.set-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), ref : ref, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) (ref : ref <: instr) TABLE.SET_instr(x)]), `%;%`_config(z, [TRAP_instr]))
    -- if (i!`%`_num_.0 >= |$table(z, x).REFS_tableinst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:333.1-335.32
  rule `table.set-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), ref : ref, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) (ref : ref <: instr) TABLE.SET_instr(x)]), `%;%`_config($with_table(z, x, i!`%`_num_.0, ref), []))
    -- if (i!`%`_num_.0 < |$table(z, x).REFS_tableinst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:344.1-347.46
  rule `table.grow-succeed`{z : state, ref : ref, at : addrtype, n : n, x : idx, ti : tableinst}:
    `%~>%`(`%;%`_config(z, [(ref : ref <: instr) CONST_instr((at : addrtype <: numtype), `%`_num_(n)) TABLE.GROW_instr(x)]), `%;%`_config($with_tableinst(z, x, ti), [CONST_instr((at : addrtype <: numtype), `%`_num_(|$table(z, x).REFS_tableinst|))]))
    -- if (ti = $growtable($table(z, x), n, ref))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:349.1-350.87
  rule `table.grow-fail`{z : state, ref : ref, at : addrtype, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [(ref : ref <: instr) CONST_instr((at : addrtype <: numtype), `%`_num_(n)) TABLE.GROW_instr(x)]), `%;%`_config(z, [CONST_instr((at : addrtype <: numtype), `%`_num_($inv_signed_($size((at : addrtype <: numtype)), - (1 : nat <:> int))))]))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:410.1-411.51
  rule elem.drop{z : state, x : idx}:
    `%~>%`(`%;%`_config(z, [ELEM.DROP_instr(x)]), `%;%`_config($with_elem(z, x, []), []))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:494.1-497.60
  rule `store-num-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), nt : numtype, c : num_(nt), x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) CONST_instr(nt, c) STORE_instr(nt, ?(), x, ao)]), `%;%`_config(z, [TRAP_instr]))
    -- if (((i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) + ((($size(nt) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) > |$mem(z, x).BYTES_meminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:499.1-503.29
  rule `store-num-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), nt : numtype, c : num_(nt), x : idx, ao : memarg, `b*` : byte*}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) CONST_instr(nt, c) STORE_instr(nt, ?(), x, ao)]), `%;%`_config($with_mem(z, x, (i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0), ((($size(nt) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat), b*{b <- `b*`}), []))
    -- if (b*{b <- `b*`} = $nbytes_(nt, c))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:505.1-508.52
  rule `store-pack-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), Inn : Inn, c : num_((Inn : addrtype <: numtype)), n : n, x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) CONST_instr((Inn : addrtype <: numtype), c) STORE_instr((Inn : addrtype <: numtype), ?(`%`_storeop_(`%`_sz(n))), x, ao)]), `%;%`_config(z, [TRAP_instr]))
    -- if (((i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) + (((n : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) > |$mem(z, x).BYTES_meminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:510.1-514.52
  rule `store-pack-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), Inn : Inn, c : num_((Inn : addrtype <: numtype)), n : n, x : idx, ao : memarg, `b*` : byte*}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) CONST_instr((Inn : addrtype <: numtype), c) STORE_instr((Inn : addrtype <: numtype), ?(`%`_storeop_(`%`_sz(n))), x, ao)]), `%;%`_config($with_mem(z, x, (i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0), (((n : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat), b*{b <- `b*`}), []))
    -- if (b*{b <- `b*`} = $ibytes_(n, $wrap__($size((Inn : addrtype <: numtype)), n, c)))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:516.1-519.63
  rule `vstore-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), c : vec_(V128_Vnn), x : idx, ao : memarg}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VCONST_instr(V128_vectype, c) VSTORE_instr(V128_vectype, x, ao)]), `%;%`_config(z, [TRAP_instr]))
    -- if (((i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) + ((($vsize(V128_vectype) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat)) > |$mem(z, x).BYTES_meminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:521.1-524.31
  rule `vstore-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), c : vec_(V128_Vnn), x : idx, ao : memarg, `b*` : byte*}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VCONST_instr(V128_vectype, c) VSTORE_instr(V128_vectype, x, ao)]), `%;%`_config($with_mem(z, x, (i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0), ((($vsize(V128_vectype) : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat), b*{b <- `b*`}), []))
    -- if (b*{b <- `b*`} = $vbytes_(V128_vectype, c))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:527.1-530.50
  rule `vstore_lane-oob`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), c : vec_(V128_Vnn), N : N, x : idx, ao : memarg, j : laneidx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VCONST_instr(V128_vectype, c) VSTORE_LANE_instr(V128_vectype, `%`_sz(N), x, ao, j)]), `%;%`_config(z, [TRAP_instr]))
    -- if (((i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0) + N) > |$mem(z, x).BYTES_meminst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:532.1-537.49
  rule `vstore_lane-val`{z : state, at : addrtype, i : num_((at : addrtype <: numtype)), c : vec_(V128_Vnn), N : N, x : idx, ao : memarg, j : laneidx, `b*` : byte*, Jnn : Jnn, M : M}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), i) VCONST_instr(V128_vectype, c) VSTORE_LANE_instr(V128_vectype, `%`_sz(N), x, ao, j)]), `%;%`_config($with_mem(z, x, (i!`%`_num_.0 + ao.OFFSET_memarg!`%`_u64.0), (((N : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat), b*{b <- `b*`}), []))
    -- if (N = $jsize(Jnn))
    -- if ((M : nat <:> rat) = ((128 : nat <:> rat) / (N : nat <:> rat)))
    -- if (b*{b <- `b*`} = $ibytes_(N, `%`_iN($lanes_(`%X%`_shape((Jnn : Jnn <: lanetype), `%`_dim(M)), c)[j!`%`_laneidx.0]!`%`_lane_.0)))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:546.1-549.37
  rule `memory.grow-succeed`{z : state, at : addrtype, n : n, x : idx, mi : meminst}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), `%`_num_(n)) MEMORY.GROW_instr(x)]), `%;%`_config($with_meminst(z, x, mi), [CONST_instr((at : addrtype <: numtype), `%`_num_((((|$mem(z, x).BYTES_meminst| : nat <:> rat) / ((64 * $Ki) : nat <:> rat)) : rat <:> nat)))]))
    -- if (mi = $growmem($mem(z, x), n))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:551.1-552.84
  rule `memory.grow-fail`{z : state, at : addrtype, n : n, x : idx}:
    `%~>%`(`%;%`_config(z, [CONST_instr((at : addrtype <: numtype), `%`_num_(n)) MEMORY.GROW_instr(x)]), `%;%`_config(z, [CONST_instr((at : addrtype <: numtype), `%`_num_($inv_signed_($size((at : addrtype <: numtype)), - (1 : nat <:> int))))]))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:612.1-613.51
  rule data.drop{z : state, x : idx}:
    `%~>%`(`%;%`_config(z, [DATA.DROP_instr(x)]), `%;%`_config($with_data(z, x, []), []))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:693.1-697.65
  rule struct.new{z : state, `val*` : val*, n : n, x : idx, si : structinst, a : addr, `mut?*` : mut?*, `zt*` : storagetype*}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^n{val <- `val*`} ++ [STRUCT.NEW_instr(x)]), `%;%`_config($add_structinst(z, [si]), [REF.STRUCT_ADDR_instr(a)]))
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%`_list(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)^n{`mut?` <- `mut?*`, zt <- `zt*`})))
    -- if (a = |$structinst(z)|)
    -- if (si = {TYPE $type(z, x), FIELDS $packfield_(zt, val)^n{val <- `val*`, zt <- `zt*`}})

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:714.1-715.53
  rule `struct.set-null`{z : state, ht : heaptype, val : val, x : idx, i : u32}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) (val : val <: instr) STRUCT.SET_instr(x, i)]), `%;%`_config(z, [TRAP_instr]))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:717.1-720.46
  rule `struct.set-struct`{z : state, a : addr, val : val, x : idx, i : u32, `zt*` : storagetype*, `mut?*` : mut?*}:
    `%~>%`(`%;%`_config(z, [REF.STRUCT_ADDR_instr(a) (val : val <: instr) STRUCT.SET_instr(x, i)]), `%;%`_config($with_struct(z, a, i!`%`_u32.0, $packfield_(zt*{zt <- `zt*`}[i!`%`_u32.0], val)), []))
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%`_list(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)*{`mut?` <- `mut?*`, zt <- `zt*`})))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:733.1-738.65
  rule array.new_fixed{z : state, `val*` : val*, n : n, x : idx, ai : arrayinst, a : addr, `mut?` : mut?, zt : storagetype}:
    `%~>%`(`%;%`_config(z, (val : val <: instr)^n{val <- `val*`} ++ [ARRAY.NEW_FIXED_instr(x, `%`_u32(n))]), `%;%`_config($add_arrayinst(z, [ai]), [REF.ARRAY_ADDR_instr(a)]))
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))
    -- if ((a = |$arrayinst(z)|) /\ (ai = {TYPE $type(z, x), FIELDS $packfield_(zt, val)^n{val <- `val*`}}))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:778.1-779.64
  rule `array.set-null`{z : state, ht : heaptype, i : num_(I32_numtype), val : val, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.NULL_instr(ht) CONST_instr(I32_numtype, i) (val : val <: instr) ARRAY.SET_instr(x)]), `%;%`_config(z, [TRAP_instr]))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:781.1-783.39
  rule `array.set-oob`{z : state, a : addr, i : num_(I32_numtype), val : val, x : idx}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) (val : val <: instr) ARRAY.SET_instr(x)]), `%;%`_config(z, [TRAP_instr]))
    -- if (i!`%`_num_.0 >= |$arrayinst(z)[a].FIELDS_arrayinst|)

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:785.1-788.44
  rule `array.set-array`{z : state, a : addr, i : num_(I32_numtype), val : val, x : idx, zt : storagetype, `mut?` : mut?}:
    `%~>%`(`%;%`_config(z, [REF.ARRAY_ADDR_instr(a) CONST_instr(I32_numtype, i) (val : val <: instr) ARRAY.SET_instr(x)]), `%;%`_config($with_array(z, a, i!`%`_num_.0, $packfield_(zt, val)), []))
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`_fieldtype(mut?{mut <- `mut?`}, zt)))
}

;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
rec {

;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:8.1-8.92
relation Steps: `%~>*%`(config, config)
  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:21.1-22.26
  rule refl{z : state, `instr*` : instr*}:
    `%~>*%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z, instr*{instr <- `instr*`}))

  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec:24.1-27.44
  rule trans{z : state, `instr*` : instr*, z'' : state, `instr''*` : instr*, z' : state, `instr'*` : instr*}:
    `%~>*%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z'', instr''*{instr'' <- `instr''*`}))
    -- Step: `%~>%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z', instr'*{instr' <- `instr'*`}))
    -- Steps: `%~>*%`(`%;%`_config(z', instr'*{instr' <- `instr'*`}), `%;%`_config(z'', instr''*{instr'' <- `instr''*`}))
}

;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
relation Eval_expr: `%;%~>*%;%`(state, expr, state, val*)
  ;; ../../../../specification/wasm-3.0/4.3-execution.instructions.spectec
  rule _{z : state, `instr*` : instr*, z' : state, `val*` : val*}:
    `%;%~>*%;%`(z, instr*{instr <- `instr*`}, z', val*{val <- `val*`})
    -- Steps: `%~>*%`(`%;%`_config(z, instr*{instr <- `instr*`}), `%;%`_config(z', (val : val <: instr)*{val <- `val*`}))

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:7.1-7.63
def $alloctypes(type*) : deftype*
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:8.1-8.27
  def $alloctypes([]) = []
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:9.1-13.24
  def $alloctypes{`type'*` : type*, type : type, `deftype'*` : deftype*, `deftype*` : deftype*, rectype : rectype, x : idx}(type'*{type' <- `type'*`} ++ [type]) = deftype'*{deftype' <- `deftype'*`} ++ deftype*{deftype <- `deftype*`}
    -- if (deftype'*{deftype' <- `deftype'*`} = $alloctypes(type'*{type' <- `type'*`}))
    -- if (type = TYPE_type(rectype))
    -- if (deftype*{deftype <- `deftype*`} = $subst_all_deftypes($rolldt(x, rectype), (deftype' : deftype <: typeuse)*{deftype' <- `deftype'*`}))
    -- if (x!`%`_idx.0 = |deftype'*{deftype' <- `deftype'*`}|)
}

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $alloctag(store : store, tagtype : tagtype) : (store, tagaddr)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $alloctag{s : store, tagtype : tagtype, taginst : taginst}(s, tagtype) = (s +++ {TAGS [taginst], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], STRUCTS [], ARRAYS [], EXNS []}, |s.TAGS_store|)
    -- if (taginst = {TYPE tagtype})

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:20.1-20.102
def $alloctags(store : store, tagtype*) : (store, tagaddr*)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:21.1-21.34
  def $alloctags{s : store}(s, []) = (s, [])
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:22.1-24.49
  def $alloctags{s : store, tagtype : tagtype, `tagtype'*` : tagtype*, s_2 : store, ja : tagaddr, `ja'*` : tagaddr*, s_1 : store}(s, [tagtype] ++ tagtype'*{tagtype' <- `tagtype'*`}) = (s_2, [ja] ++ ja'*{ja' <- `ja'*`})
    -- if ((s_1, ja) = $alloctag(s, tagtype))
    -- if ((s_2, ja'*{ja' <- `ja'*`}) = $alloctags(s_1, tagtype'*{tagtype' <- `tagtype'*`}))
}

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $allocglobal(store : store, globaltype : globaltype, val : val) : (store, globaladdr)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $allocglobal{s : store, globaltype : globaltype, val : val, globalinst : globalinst}(s, globaltype, val) = (s +++ {TAGS [], GLOBALS [globalinst], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], STRUCTS [], ARRAYS [], EXNS []}, |s.GLOBALS_store|)
    -- if (globalinst = {TYPE globaltype, VALUE val})

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:31.1-31.122
def $allocglobals(store : store, globaltype*, val*) : (store, globaladdr*)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:32.1-32.42
  def $allocglobals{s : store}(s, [], []) = (s, [])
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:33.1-35.62
  def $allocglobals{s : store, globaltype : globaltype, `globaltype'*` : globaltype*, val : val, `val'*` : val*, s_2 : store, ga : globaladdr, `ga'*` : globaladdr*, s_1 : store}(s, [globaltype] ++ globaltype'*{globaltype' <- `globaltype'*`}, [val] ++ val'*{val' <- `val'*`}) = (s_2, [ga] ++ ga'*{ga' <- `ga'*`})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga' <- `ga'*`}) = $allocglobals(s_1, globaltype'*{globaltype' <- `globaltype'*`}, val'*{val' <- `val'*`}))
}

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $allocmem(store : store, memtype : memtype) : (store, memaddr)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $allocmem{s : store, at : addrtype, i : u64, `j?` : u64?, meminst : meminst}(s, `%%PAGE`_memtype(at, `[%..%]`_limits(i, j?{j <- `j?`}))) = (s +++ {TAGS [], GLOBALS [], MEMS [meminst], TABLES [], FUNCS [], DATAS [], ELEMS [], STRUCTS [], ARRAYS [], EXNS []}, |s.MEMS_store|)
    -- if (meminst = {TYPE `%%PAGE`_memtype(at, `[%..%]`_limits(i, j?{j <- `j?`})), BYTES `%`_byte(0)^(i!`%`_u64.0 * (64 * $Ki)){}})

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:42.1-42.102
def $allocmems(store : store, memtype*) : (store, memaddr*)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:43.1-43.34
  def $allocmems{s : store}(s, []) = (s, [])
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:44.1-46.49
  def $allocmems{s : store, memtype : memtype, `memtype'*` : memtype*, s_2 : store, ma : memaddr, `ma'*` : memaddr*, s_1 : store}(s, [memtype] ++ memtype'*{memtype' <- `memtype'*`}) = (s_2, [ma] ++ ma'*{ma' <- `ma'*`})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma' <- `ma'*`}) = $allocmems(s_1, memtype'*{memtype' <- `memtype'*`}))
}

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $alloctable(store : store, tabletype : tabletype, ref : ref) : (store, tableaddr)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $alloctable{s : store, at : addrtype, i : u64, `j?` : u64?, rt : reftype, ref : ref, tableinst : tableinst}(s, `%%%`_tabletype(at, `[%..%]`_limits(i, j?{j <- `j?`}), rt), ref) = (s +++ {TAGS [], GLOBALS [], MEMS [], TABLES [tableinst], FUNCS [], DATAS [], ELEMS [], STRUCTS [], ARRAYS [], EXNS []}, |s.TABLES_store|)
    -- if (tableinst = {TYPE `%%%`_tabletype(at, `[%..%]`_limits(i, j?{j <- `j?`}), rt), REFS ref^i!`%`_u64.0{}})

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:53.1-53.118
def $alloctables(store : store, tabletype*, ref*) : (store, tableaddr*)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:54.1-54.41
  def $alloctables{s : store}(s, [], []) = (s, [])
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:55.1-57.60
  def $alloctables{s : store, tabletype : tabletype, `tabletype'*` : tabletype*, ref : ref, `ref'*` : ref*, s_2 : store, ta : tableaddr, `ta'*` : tableaddr*, s_1 : store}(s, [tabletype] ++ tabletype'*{tabletype' <- `tabletype'*`}, [ref] ++ ref'*{ref' <- `ref'*`}) = (s_2, [ta] ++ ta'*{ta' <- `ta'*`})
    -- if ((s_1, ta) = $alloctable(s, tabletype, ref))
    -- if ((s_2, ta'*{ta' <- `ta'*`}) = $alloctables(s_1, tabletype'*{tabletype' <- `tabletype'*`}, ref'*{ref' <- `ref'*`}))
}

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $allocfunc(store : store, deftype : deftype, funccode : funccode, moduleinst : moduleinst) : (store, funcaddr)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $allocfunc{s : store, deftype : deftype, funccode : funccode, moduleinst : moduleinst, funcinst : funcinst}(s, deftype, funccode, moduleinst) = (s +++ {TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [funcinst], DATAS [], ELEMS [], STRUCTS [], ARRAYS [], EXNS []}, |s.FUNCS_store|)
    -- if (funcinst = {TYPE deftype, MODULE moduleinst, CODE funccode})

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:64.1-64.133
def $allocfuncs(store : store, deftype*, funccode*, moduleinst*) : (store, funcaddr*)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:65.1-65.45
  def $allocfuncs{s : store}(s, [], [], []) = (s, [])
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:66.1-68.71
  def $allocfuncs{s : store, dt : deftype, `dt'*` : deftype*, funccode : funccode, `funccode'*` : funccode*, moduleinst : moduleinst, `moduleinst'*` : moduleinst*, s_2 : store, fa : funcaddr, `fa'*` : funcaddr*, s_1 : store}(s, [dt] ++ dt'*{dt' <- `dt'*`}, [funccode] ++ funccode'*{funccode' <- `funccode'*`}, [moduleinst] ++ moduleinst'*{moduleinst' <- `moduleinst'*`}) = (s_2, [fa] ++ fa'*{fa' <- `fa'*`})
    -- if ((s_1, fa) = $allocfunc(s, dt, funccode, moduleinst))
    -- if ((s_2, fa'*{fa' <- `fa'*`}) = $allocfuncs(s_1, dt'*{dt' <- `dt'*`}, funccode'*{funccode' <- `funccode'*`}, moduleinst'*{moduleinst' <- `moduleinst'*`}))
}

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $allocdata(store : store, datatype : datatype, byte*) : (store, dataaddr)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $allocdata{s : store, `byte*` : byte*, datainst : datainst}(s, OK_datatype, byte*{byte <- `byte*`}) = (s +++ {TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [datainst], ELEMS [], STRUCTS [], ARRAYS [], EXNS []}, |s.DATAS_store|)
    -- if (datainst = {BYTES byte*{byte <- `byte*`}})

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:75.1-75.118
def $allocdatas(store : store, datatype*, byte**) : (store, dataaddr*)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:76.1-76.40
  def $allocdatas{s : store}(s, [], []) = (s, [])
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:77.1-79.53
  def $allocdatas{s : store, ok : datatype, `ok'*` : datatype*, `b*` : byte*, `b'**` : byte**, s_2 : store, da : dataaddr, `da'*` : dataaddr*, s_1 : store}(s, [ok] ++ ok'*{ok' <- `ok'*`}, [b*{b <- `b*`}] ++ b'*{b' <- `b'*`}*{`b'*` <- `b'**`}) = (s_2, [da] ++ da'*{da' <- `da'*`})
    -- if ((s_1, da) = $allocdata(s, ok, b*{b <- `b*`}))
    -- if ((s_2, da'*{da' <- `da'*`}) = $allocdatas(s_1, ok'*{ok' <- `ok'*`}, b'*{b' <- `b'*`}*{`b'*` <- `b'**`}))
}

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $allocelem(store : store, elemtype : elemtype, ref*) : (store, elemaddr)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $allocelem{s : store, elemtype : elemtype, `ref*` : ref*, eleminst : eleminst}(s, elemtype, ref*{ref <- `ref*`}) = (s +++ {TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [eleminst], STRUCTS [], ARRAYS [], EXNS []}, |s.ELEMS_store|)
    -- if (eleminst = {TYPE elemtype, REFS ref*{ref <- `ref*`}})

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:86.1-86.117
def $allocelems(store : store, elemtype*, ref**) : (store, elemaddr*)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:87.1-87.40
  def $allocelems{s : store}(s, [], []) = (s, [])
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:88.1-90.55
  def $allocelems{s : store, rt : reftype, `rt'*` : reftype*, `ref*` : ref*, `ref'**` : ref**, s_2 : store, ea : elemaddr, `ea'*` : elemaddr*, s_1 : store}(s, [rt] ++ rt'*{rt' <- `rt'*`}, [ref*{ref <- `ref*`}] ++ ref'*{ref' <- `ref'*`}*{`ref'*` <- `ref'**`}) = (s_2, [ea] ++ ea'*{ea' <- `ea'*`})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref <- `ref*`}))
    -- if ((s_2, ea'*{ea' <- `ea'*`}) = $allocelems(s_1, rt'*{rt' <- `rt'*`}, ref'*{ref' <- `ref'*`}*{`ref'*` <- `ref'**`}))
}

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $allocexport(moduleinst : moduleinst, export : export) : exportinst
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, TAG_externidx(x))) = {NAME name, ADDR TAG_externaddr(moduleinst.TAGS_moduleinst[x!`%`_idx.0])}
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, GLOBAL_externidx(x))) = {NAME name, ADDR GLOBAL_externaddr(moduleinst.GLOBALS_moduleinst[x!`%`_idx.0])}
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, MEM_externidx(x))) = {NAME name, ADDR MEM_externaddr(moduleinst.MEMS_moduleinst[x!`%`_idx.0])}
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, TABLE_externidx(x))) = {NAME name, ADDR TABLE_externaddr(moduleinst.TABLES_moduleinst[x!`%`_idx.0])}
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $allocexport{moduleinst : moduleinst, name : name, x : idx}(moduleinst, EXPORT_export(name, FUNC_externidx(x))) = {NAME name, ADDR FUNC_externaddr(moduleinst.FUNCS_moduleinst[x!`%`_idx.0])}

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $allocexports(moduleinst : moduleinst, export*) : exportinst*
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $allocexports{moduleinst : moduleinst, `export*` : export*}(moduleinst, export*{export <- `export*`}) = $allocexport(moduleinst, export)*{export <- `export*`}

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $allocmodule(store : store, module : module, externaddr*, val*, ref*, ref**) : (store, moduleinst)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $allocmodule{s : store, module : module, `externaddr*` : externaddr*, `val_G*` : val*, `ref_T*` : ref*, `ref_E**` : ref**, s_7 : store, moduleinst : moduleinst, `type*` : type*, `import*` : import*, `tag*` : tag*, `global*` : global*, `mem*` : mem*, `table*` : table*, `func*` : func*, `data*` : data*, `elem*` : elem*, `start?` : start?, `export*` : export*, `tagtype*` : tagtype*, `globaltype*` : globaltype*, `expr_G*` : expr*, `memtype*` : memtype*, `tabletype*` : tabletype*, `expr_T*` : expr*, `x*` : idx*, `local**` : local**, `expr_F*` : expr*, `byte**` : byte**, `datamode*` : datamode*, `elemtype*` : elemtype*, `expr_E**` : expr**, `elemmode*` : elemmode*, `aa_I*` : tagaddr*, `ga_I*` : globaladdr*, `ma_I*` : memaddr*, `ta_I*` : tableaddr*, `fa_I*` : funcaddr*, `dt*` : deftype*, `fa*` : nat*, `i_F*` : nat*, s_1 : store, `aa*` : tagaddr*, s_2 : store, `ga*` : globaladdr*, s_3 : store, `ma*` : memaddr*, s_4 : store, `ta*` : tableaddr*, s_5 : store, `da*` : dataaddr*, s_6 : store, `ea*` : elemaddr*, `xi*` : exportinst*}(s, module, externaddr*{externaddr <- `externaddr*`}, val_G*{val_G <- `val_G*`}, ref_T*{ref_T <- `ref_T*`}, ref_E*{ref_E <- `ref_E*`}*{`ref_E*` <- `ref_E**`}) = (s_7, moduleinst)
    -- if (module = MODULE_module(type*{type <- `type*`}, import*{import <- `import*`}, tag*{tag <- `tag*`}, global*{global <- `global*`}, mem*{mem <- `mem*`}, table*{table <- `table*`}, func*{func <- `func*`}, data*{data <- `data*`}, elem*{elem <- `elem*`}, start?{start <- `start?`}, export*{export <- `export*`}))
    -- if (tag*{tag <- `tag*`} = TAG_tag(tagtype)*{tagtype <- `tagtype*`})
    -- if (global*{global <- `global*`} = GLOBAL_global(globaltype, expr_G)*{expr_G <- `expr_G*`, globaltype <- `globaltype*`})
    -- if (mem*{mem <- `mem*`} = MEMORY_mem(memtype)*{memtype <- `memtype*`})
    -- if (table*{table <- `table*`} = TABLE_table(tabletype, expr_T)*{expr_T <- `expr_T*`, tabletype <- `tabletype*`})
    -- if (func*{func <- `func*`} = FUNC_func(x, local*{local <- `local*`}, expr_F)*{expr_F <- `expr_F*`, `local*` <- `local**`, x <- `x*`})
    -- if (data*{data <- `data*`} = DATA_data(byte*{byte <- `byte*`}, datamode)*{`byte*` <- `byte**`, datamode <- `datamode*`})
    -- if (elem*{elem <- `elem*`} = ELEM_elem(elemtype, expr_E*{expr_E <- `expr_E*`}, elemmode)*{elemmode <- `elemmode*`, elemtype <- `elemtype*`, `expr_E*` <- `expr_E**`})
    -- if (aa_I*{aa_I <- `aa_I*`} = $tagsxa(externaddr*{externaddr <- `externaddr*`}))
    -- if (ga_I*{ga_I <- `ga_I*`} = $globalsxa(externaddr*{externaddr <- `externaddr*`}))
    -- if (ma_I*{ma_I <- `ma_I*`} = $memsxa(externaddr*{externaddr <- `externaddr*`}))
    -- if (ta_I*{ta_I <- `ta_I*`} = $tablesxa(externaddr*{externaddr <- `externaddr*`}))
    -- if (fa_I*{fa_I <- `fa_I*`} = $funcsxa(externaddr*{externaddr <- `externaddr*`}))
    -- if (dt*{dt <- `dt*`} = $alloctypes(type*{type <- `type*`}))
    -- if (fa*{fa <- `fa*`} = (|s.FUNCS_store| + i_F)^(i_F<|func*{func <- `func*`}|){i_F <- `i_F*`})
    -- if ((s_1, aa*{aa <- `aa*`}) = $alloctags(s, $subst_all_tagtype(tagtype, (dt : deftype <: typeuse)*{dt <- `dt*`})*{tagtype <- `tagtype*`}))
    -- if ((s_2, ga*{ga <- `ga*`}) = $allocglobals(s_1, $subst_all_globaltype(globaltype, (dt : deftype <: typeuse)*{dt <- `dt*`})*{globaltype <- `globaltype*`}, val_G*{val_G <- `val_G*`}))
    -- if ((s_3, ma*{ma <- `ma*`}) = $allocmems(s_2, $subst_all_memtype(memtype, (dt : deftype <: typeuse)*{dt <- `dt*`})*{memtype <- `memtype*`}))
    -- if ((s_4, ta*{ta <- `ta*`}) = $alloctables(s_3, $subst_all_tabletype(tabletype, (dt : deftype <: typeuse)*{dt <- `dt*`})*{tabletype <- `tabletype*`}, ref_T*{ref_T <- `ref_T*`}))
    -- if ((s_5, da*{da <- `da*`}) = $allocdatas(s_4, OK_datatype^|data*{data <- `data*`}|{}, byte*{byte <- `byte*`}*{`byte*` <- `byte**`}))
    -- if ((s_6, ea*{ea <- `ea*`}) = $allocelems(s_5, $subst_all_reftype(elemtype, (dt : deftype <: typeuse)*{dt <- `dt*`})*{elemtype <- `elemtype*`}, ref_E*{ref_E <- `ref_E*`}*{`ref_E*` <- `ref_E**`}))
    -- if ((s_7, fa*{fa <- `fa*`}) = $allocfuncs(s_6, dt*{dt <- `dt*`}[x!`%`_idx.0]*{x <- `x*`}, FUNC_funccode(x, local*{local <- `local*`}, expr_F)*{expr_F <- `expr_F*`, `local*` <- `local**`, x <- `x*`}, moduleinst^|func*{func <- `func*`}|{}))
    -- if (xi*{xi <- `xi*`} = $allocexports({TYPES [], TAGS aa_I*{aa_I <- `aa_I*`} ++ aa*{aa <- `aa*`}, GLOBALS ga_I*{ga_I <- `ga_I*`} ++ ga*{ga <- `ga*`}, MEMS ma_I*{ma_I <- `ma_I*`} ++ ma*{ma <- `ma*`}, TABLES ta_I*{ta_I <- `ta_I*`} ++ ta*{ta <- `ta*`}, FUNCS fa_I*{fa_I <- `fa_I*`} ++ fa*{fa <- `fa*`}, DATAS [], ELEMS [], EXPORTS []}, export*{export <- `export*`}))
    -- if (moduleinst = {TYPES dt*{dt <- `dt*`}, TAGS aa_I*{aa_I <- `aa_I*`} ++ aa*{aa <- `aa*`}, GLOBALS ga_I*{ga_I <- `ga_I*`} ++ ga*{ga <- `ga*`}, MEMS ma_I*{ma_I <- `ma_I*`} ++ ma*{ma <- `ma*`}, TABLES ta_I*{ta_I <- `ta_I*`} ++ ta*{ta <- `ta*`}, FUNCS fa_I*{fa_I <- `fa_I*`} ++ fa*{fa <- `fa*`}, DATAS da*{da <- `da*`}, ELEMS ea*{ea <- `ea*`}, EXPORTS xi*{xi <- `xi*`}})

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $rundata_(dataidx : dataidx, data : data) : instr*
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $rundata_{x : idx, `b*` : byte*, n : n}(x, DATA_data(b^n{b <- `b*`}, PASSIVE_datamode)) = []
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $rundata_{x : idx, `b*` : byte*, n : n, y : idx, `instr*` : instr*}(x, DATA_data(b^n{b <- `b*`}, ACTIVE_datamode(y, instr*{instr <- `instr*`}))) = instr*{instr <- `instr*`} ++ [CONST_instr(I32_numtype, `%`_num_(0)) CONST_instr(I32_numtype, `%`_num_(n)) MEMORY.INIT_instr(y, x) DATA.DROP_instr(x)]

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $runelem_(elemidx : elemidx, elem : elem) : instr*
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $runelem_{x : idx, rt : reftype, `e*` : expr*, n : n}(x, ELEM_elem(rt, e^n{e <- `e*`}, PASSIVE_elemmode)) = []
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $runelem_{x : idx, rt : reftype, `e*` : expr*, n : n}(x, ELEM_elem(rt, e^n{e <- `e*`}, DECLARE_elemmode)) = [ELEM.DROP_instr(x)]
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $runelem_{x : idx, rt : reftype, `e*` : expr*, n : n, y : idx, `instr*` : instr*}(x, ELEM_elem(rt, e^n{e <- `e*`}, ACTIVE_elemmode(y, instr*{instr <- `instr*`}))) = instr*{instr <- `instr*`} ++ [CONST_instr(I32_numtype, `%`_num_(0)) CONST_instr(I32_numtype, `%`_num_(n)) TABLE.INIT_instr(y, x) ELEM.DROP_instr(x)]

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:160.1-160.94
def $evalglobals(state : state, globaltype*, expr*) : (state, val*)
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:161.1-161.41
  def $evalglobals{z : state}(z, [], []) = (z, [])
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec:162.1-167.81
  def $evalglobals{z : state, gt : globaltype, `gt'*` : globaltype*, expr : expr, `expr'*` : expr*, z' : state, val : val, `val'*` : val*, s : store, f : frame, s' : store, a : addr}(z, [gt] ++ gt'*{gt' <- `gt'*`}, [expr] ++ expr'*{expr' <- `expr'*`}) = (z', [val] ++ val'*{val' <- `val'*`})
    -- Eval_expr: `%;%~>*%;%`(z, expr, z, [val])
    -- if (z = `%;%`_state(s, f))
    -- if ((s', a) = $allocglobal(s, gt, val))
    -- if ((z', val'*{val' <- `val'*`}) = $evalglobals(`%;%`_state(s', f[MODULE_frame.GLOBALS_moduleinst =++ [a]]), gt'*{gt' <- `gt'*`}, expr'*{expr' <- `expr'*`}))
}

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $instantiate(store : store, module : module, externaddr*) : config
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $instantiate{s : store, module : module, `externaddr*` : externaddr*, s' : store, moduleinst : moduleinst, `instr_E*` : instr*, `instr_D*` : instr*, `instr_S?` : instr?, `xt_I*` : externtype*, `xt_E*` : externtype*, `type*` : type*, `import*` : import*, `tag*` : tag*, `global*` : global*, `mem*` : mem*, `table*` : table*, `func*` : func*, `data*` : data*, `elem*` : elem*, `start?` : start?, `export*` : export*, `globaltype*` : globaltype*, `expr_G*` : expr*, `tabletype*` : tabletype*, `expr_T*` : expr*, `byte**` : byte**, `datamode*` : datamode*, `reftype*` : reftype*, `expr_E**` : expr**, `elemmode*` : elemmode*, `x?` : idx?, moduleinst_0 : moduleinst, `i_F*` : nat*, z : state, z' : state, `val_G*` : val*, `ref_T*` : ref*, `ref_E**` : ref**, `i_D*` : nat*, `i_E*` : nat*}(s, module, externaddr*{externaddr <- `externaddr*`}) = `%;%`_config(`%;%`_state(s', {LOCALS [], MODULE moduleinst}), instr_E*{instr_E <- `instr_E*`} ++ instr_D*{instr_D <- `instr_D*`} ++ lift(instr_S?{instr_S <- `instr_S?`}))
    -- Module_ok: `|-%:%`(module, `%->%`_moduletype(xt_I*{xt_I <- `xt_I*`}, xt_E*{xt_E <- `xt_E*`}))
    -- (Externaddr_ok: `%|-%:%`(s, externaddr, xt_I))*{externaddr <- `externaddr*`, xt_I <- `xt_I*`}
    -- if (module = MODULE_module(type*{type <- `type*`}, import*{import <- `import*`}, tag*{tag <- `tag*`}, global*{global <- `global*`}, mem*{mem <- `mem*`}, table*{table <- `table*`}, func*{func <- `func*`}, data*{data <- `data*`}, elem*{elem <- `elem*`}, start?{start <- `start?`}, export*{export <- `export*`}))
    -- if (global*{global <- `global*`} = GLOBAL_global(globaltype, expr_G)*{expr_G <- `expr_G*`, globaltype <- `globaltype*`})
    -- if (table*{table <- `table*`} = TABLE_table(tabletype, expr_T)*{expr_T <- `expr_T*`, tabletype <- `tabletype*`})
    -- if (data*{data <- `data*`} = DATA_data(byte*{byte <- `byte*`}, datamode)*{`byte*` <- `byte**`, datamode <- `datamode*`})
    -- if (elem*{elem <- `elem*`} = ELEM_elem(reftype, expr_E*{expr_E <- `expr_E*`}, elemmode)*{elemmode <- `elemmode*`, `expr_E*` <- `expr_E**`, reftype <- `reftype*`})
    -- if (start?{start <- `start?`} = START_start(x)?{x <- `x?`})
    -- if (moduleinst_0 = {TYPES $alloctypes(type*{type <- `type*`}), TAGS [], GLOBALS $globalsxa(externaddr*{externaddr <- `externaddr*`}), MEMS [], TABLES [], FUNCS $funcsxa(externaddr*{externaddr <- `externaddr*`}) ++ (|s.FUNCS_store| + i_F)^(i_F<|func*{func <- `func*`}|){i_F <- `i_F*`}, DATAS [], ELEMS [], EXPORTS []})
    -- if (z = `%;%`_state(s, {LOCALS [], MODULE moduleinst_0}))
    -- if ((z', val_G*{val_G <- `val_G*`}) = $evalglobals(z, globaltype*{globaltype <- `globaltype*`}, expr_G*{expr_G <- `expr_G*`}))
    -- (Eval_expr: `%;%~>*%;%`(z', expr_T, z', [(ref_T : ref <: val)]))*{expr_T <- `expr_T*`, ref_T <- `ref_T*`}
    -- (Eval_expr: `%;%~>*%;%`(z', expr_E, z', [(ref_E : ref <: val)]))*{expr_E <- `expr_E*`, ref_E <- `ref_E*`}*{`expr_E*` <- `expr_E**`, `ref_E*` <- `ref_E**`}
    -- if ((s', moduleinst) = $allocmodule(s, module, externaddr*{externaddr <- `externaddr*`}, val_G*{val_G <- `val_G*`}, ref_T*{ref_T <- `ref_T*`}, ref_E*{ref_E <- `ref_E*`}*{`ref_E*` <- `ref_E**`}))
    -- if (instr_D*{instr_D <- `instr_D*`} = $concat_(syntax instr, $rundata_(`%`_dataidx(i_D), data*{data <- `data*`}[i_D])^(i_D<|data*{data <- `data*`}|){i_D <- `i_D*`}))
    -- if (instr_E*{instr_E <- `instr_E*`} = $concat_(syntax instr, $runelem_(`%`_elemidx(i_E), elem*{elem <- `elem*`}[i_E])^(i_E<|elem*{elem <- `elem*`}|){i_E <- `i_E*`}))
    -- if (instr_S?{instr_S <- `instr_S?`} = CALL_instr(x)?{x <- `x?`})

;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
def $invoke(store : store, funcaddr : funcaddr, val*) : config
  ;; ../../../../specification/wasm-3.0/4.4-execution.modules.spectec
  def $invoke{s : store, funcaddr : funcaddr, `val*` : val*, `t_1*` : valtype*, `t_2*` : valtype*}(s, funcaddr, val*{val <- `val*`}) = `%;%`_config(`%;%`_state(s, {LOCALS [], MODULE {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], EXPORTS []}}), (val : val <: instr)*{val <- `val*`} ++ [REF.FUNC_ADDR_instr(funcaddr) CALL_REF_instr((s.FUNCS_store[funcaddr].TYPE_funcinst : deftype <: typeuse))])
    -- Expand: `%~~%`(s.FUNCS_store[funcaddr].TYPE_funcinst, `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- (Val_ok: `%|-%:%`(s, val, t_1))*{t_1 <- `t_1*`, val <- `val*`}

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bbyte : byte
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:(0x00 | ... | 0xFF) => `%`_byte(`<implicit-prod-result>`)

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
rec {

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec:9.1-11.82
grammar BuN(N : N) : uN(N)
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec:10.5-10.83
  prod{n : n} `%`_byte(n):Bbyte => `%`_uN(n)
    -- if ((n < (2 ^ 7)) /\ (n < (2 ^ N)))
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec:11.5-11.82
  prod{n : n, m : m} {{`%`_byte(n):Bbyte} {`%`_uN(m):BuN((((N : nat <:> int) - (7 : nat <:> int)) : int <:> nat))}} => `%`_uN((((2 ^ 7) * m) + (((n : nat <:> int) - ((2 ^ 7) : nat <:> int)) : int <:> nat)))
    -- if ((n >= (2 ^ 7)) /\ (N > 7))
}

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
rec {

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec:13.1-16.82
grammar BsN(N : N) : sN(N)
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec:14.5-14.87
  prod{n : n} `%`_byte(n):Bbyte => `%`_sN((n : nat <:> int))
    -- if ((n < (2 ^ 6)) /\ (n < (2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat))))
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec:15.5-15.101
  prod{n : n} `%`_byte(n):Bbyte => `%`_sN(((n : nat <:> int) - ((2 ^ 7) : nat <:> int)))
    -- if ((((2 ^ 6) <= n) /\ (n < (2 ^ 7))) /\ ((n : nat <:> int) >= (((2 ^ 7) : nat <:> int) - ((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int))))
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec:16.5-16.82
  prod{n : n, i : sN((((N : nat <:> int) - (7 : nat <:> int)) : int <:> nat))} {{`%`_byte(n):Bbyte} {i:BsN((((N : nat <:> int) - (7 : nat <:> int)) : int <:> nat))}} => `%`_sN(((((2 ^ 7) * (i!`%`_sN.0 : int <:> nat)) + (((n : nat <:> int) - ((2 ^ 7) : nat <:> int)) : int <:> nat)) : nat <:> int))
    -- if ((n >= (2 ^ 7)) /\ (N > 7))
}

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar BiN(N : N) : iN(N)
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{i : sN(N)} i:BsN(N) => `%`_iN($inv_signed_(N, i!`%`_sN.0))

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar BfN(N : N) : fN(N)
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{`b*` : byte*} b*{b <- `b*`}:Bbyte^(((N : nat <:> rat) / (8 : nat <:> rat)) : rat <:> nat){} => $inv_fbytes_(N, b*{b <- `b*`})

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bu32 : u32
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{`<implicit-prod-result>` : uN(32)} `<implicit-prod-result>`:BuN(32) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bu64 : u64
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{`<implicit-prod-result>` : uN(64)} `<implicit-prod-result>`:BuN(64) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bs33 : s33
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{`<implicit-prod-result>` : sN(33)} `<implicit-prod-result>`:BsN(33) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bi32 : i32
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{`<implicit-prod-result>` : uN(32)} `<implicit-prod-result>`:BuN(32) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bi64 : i64
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{`<implicit-prod-result>` : uN(64)} `<implicit-prod-result>`:BuN(64) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bf32 : f32
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{`<implicit-prod-result>` : fN(32)} `<implicit-prod-result>`:BfN(32) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bf64 : f64
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{`<implicit-prod-result>` : fN(64)} `<implicit-prod-result>`:BfN(64) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Blist(syntax el, grammar BX : el) : el*
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{n : n, `el*` : el*} {{`%`_u32(n):Bu32} {el:BX^n{el <- `el*`}}} => el^n{el <- `el*`}

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bname : name
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{`b*` : byte*, name : name} b*{b <- `b*`}:Blist(syntax byte, grammar Bbyte) => name
    -- if ($utf8(name!`%`_name.0) = b*{b <- `b*`})

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Btypeidx : typeidx
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} x:Bu32 => x

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Btagidx : tagidx
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} x:Bu32 => x

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bglobalidx : globalidx
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} x:Bu32 => x

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bmemidx : memidx
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} x:Bu32 => x

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Btableidx : tableidx
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} x:Bu32 => x

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bfuncidx : funcidx
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} x:Bu32 => x

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bdataidx : dataidx
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} x:Bu32 => x

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Belemidx : elemidx
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} x:Bu32 => x

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Blocalidx : localidx
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} x:Bu32 => x

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Blabelidx : labelidx
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{l : labelidx} l:Bu32 => l

;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
grammar Bexternidx : externidx
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} {{0x00} {x:Bfuncidx}} => FUNC_externidx(x)
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} {{0x01} {x:Btableidx}} => TABLE_externidx(x)
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} {{0x02} {x:Bmemidx}} => MEM_externidx(x)
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} {{0x03} {x:Bglobalidx}} => GLOBAL_externidx(x)
  ;; ../../../../specification/wasm-3.0/5.1-binary.values.spectec
  prod{x : idx} {{0x04} {x:Btagidx}} => TAG_externidx(x)

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bnumtype : numtype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x7C => F64_numtype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x7D => F32_numtype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x7E => I64_numtype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x7F => I32_numtype

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bvectype : vectype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x7B => V128_vectype

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Babsheaptype : heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x69 => EXN_heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x6A => ARRAY_heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x6B => STRUCT_heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x6C => I31_heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x6D => EQ_heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x6E => ANY_heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x6F => EXTERN_heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x70 => FUNC_heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x71 => NONE_heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x72 => NOEXTERN_heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x73 => NOFUNC_heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x74 => NOEXN_heaptype

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bheaptype : heaptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{ht : heaptype} ht:Babsheaptype => ht
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{x33 : s33} x33:Bs33 => _IDX_heaptype($s33_to_u32(x33))
    -- if (x33!`%`_s33.0 >= (0 : nat <:> int))

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Breftype : reftype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{ht : heaptype} {{0x63} {ht:Bheaptype}} => REF_reftype(?(NULL_null), ht)
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{ht : heaptype} {{0x64} {ht:Bheaptype}} => REF_reftype(?(), ht)
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{ht : heaptype} ht:Babsheaptype => REF_reftype(?(NULL_null), ht)

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bvaltype : valtype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{nt : numtype} nt:Bnumtype => (nt : numtype <: valtype)
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{vt : vectype} vt:Bvectype => (vt : vectype <: valtype)
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{rt : reftype} rt:Breftype => (rt : reftype <: valtype)

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bresulttype : resulttype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{`t*` : valtype*} t*{t <- `t*`}:Blist(syntax valtype, grammar Bvaltype) => `%`_resulttype(t*{t <- `t*`})

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bmut : mut?
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x00 => ?()
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x01 => ?(MUT_mut)

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bpacktype : packtype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x77 => I16_packtype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod 0x78 => I8_packtype

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bstoragetype : storagetype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{t : valtype} t:Bvaltype => (t : valtype <: storagetype)
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{pt : packtype} pt:Bpacktype => (pt : packtype <: storagetype)

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bfieldtype : fieldtype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{zt : storagetype, `mut?` : mut?} {{zt:Bstoragetype} {mut?{mut <- `mut?`}:Bmut}} => `%%`_fieldtype(mut?{mut <- `mut?`}, zt)

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bcomptype : comptype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{ft : fieldtype} {{0x5E} {ft:Bfieldtype}} => ARRAY_comptype(ft)
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{`ft*` : fieldtype*} {{0x5F} {ft*{ft <- `ft*`}:Blist(syntax fieldtype, grammar Bfieldtype)}} => STRUCT_comptype(`%`_list(ft*{ft <- `ft*`}))
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{`t_1*` : valtype*, `t_2*` : valtype*} {{0x60} {`%`_resulttype(t_1*{t_1 <- `t_1*`}):Bresulttype} {`%`_resulttype(t_2*{t_2 <- `t_2*`}):Bresulttype}} => `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bsubtype : subtype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{`x*` : idx*, ct : comptype} {{0x4F} {x*{x <- `x*`}:Blist(syntax typeidx, grammar Btypeidx)} {ct:Bcomptype}} => SUB_subtype(?(FINAL_final), _IDX_typeuse(x)*{x <- `x*`}, ct)
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{`x*` : idx*, ct : comptype} {{0x50} {x*{x <- `x*`}:Blist(syntax typeidx, grammar Btypeidx)} {ct:Bcomptype}} => SUB_subtype(?(), _IDX_typeuse(x)*{x <- `x*`}, ct)
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{ct : comptype} ct:Bcomptype => SUB_subtype(?(FINAL_final), [], ct)

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Brectype : rectype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{`st*` : subtype*} {{0x4E} {st*{st <- `st*`}:Blist(syntax subtype, grammar Bsubtype)}} => REC_rectype(`%`_list(st*{st <- `st*`}))
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{st : subtype} st:Bsubtype => REC_rectype(`%`_list([st]))

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Blimits : (addrtype, limits)
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{n : n} {{0x00} {`%`_u64(n):Bu64}} => (I32_addrtype, `[%..%]`_limits(`%`_u64(n), ?()))
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{n : n, m : m} {{0x01} {`%`_u64(n):Bu64} {`%`_u64(m):Bu64}} => (I32_addrtype, `[%..%]`_limits(`%`_u64(n), ?(`%`_u64(m))))
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{n : n} {{0x04} {`%`_u64(n):Bu64}} => (I64_addrtype, `[%..%]`_limits(`%`_u64(n), ?()))
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{n : n, m : m} {{0x05} {`%`_u64(n):Bu64} {`%`_u64(m):Bu64}} => (I64_addrtype, `[%..%]`_limits(`%`_u64(n), ?(`%`_u64(m))))

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Btagtype : tagtype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{x : idx} {{0x00} {x:Btypeidx}} => _IDX_tagtype(x)

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bglobaltype : globaltype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{t : valtype, `mut?` : mut?} {{t:Bvaltype} {mut?{mut <- `mut?`}:Bmut}} => `%%`_globaltype(mut?{mut <- `mut?`}, t)

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bmemtype : memtype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{at : addrtype, lim : limits} (at, lim):Blimits => `%%PAGE`_memtype(at, lim)

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Btabletype : tabletype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{rt : reftype, at : addrtype, lim : limits} {{rt:Breftype} {(at, lim):Blimits}} => `%%%`_tabletype(at, lim, rt)

;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
grammar Bexterntype : externtype
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{x : idx} {{0x00} {x:Btypeidx}} => FUNC_externtype(_IDX_typeuse(x))
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{tt : tabletype} {{0x01} {tt:Btabletype}} => TABLE_externtype(tt)
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{mt : memtype} {{0x02} {mt:Bmemtype}} => MEM_externtype(mt)
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{gt : globaltype} {{0x03} {gt:Bglobaltype}} => GLOBAL_externtype(gt)
  ;; ../../../../specification/wasm-3.0/5.2-binary.types.spectec
  prod{jt : tagtype} {{0x04} {jt:Btagtype}} => TAG_externtype(jt)

;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
syntax castop = (null?, null?)

;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
grammar Bcastop : castop
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod 0x00 => (?(), ?())
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod 0x01 => (?(NULL_null), ?())
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod 0x02 => (?(), ?(NULL_null))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod 0x03 => (?(NULL_null), ?(NULL_null))

;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
grammar Bblocktype : blocktype
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod 0x40 => _RESULT_blocktype(?())
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod{t : valtype} t:Bvaltype => _RESULT_blocktype(?(t))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod{i : s33} i:Bs33 => _IDX_blocktype(`%`_typeidx((i!`%`_s33.0 : int <:> nat)))
    -- if (i!`%`_s33.0 >= (0 : nat <:> int))

;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
grammar Bcatch : catch
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod{x : idx, l : labelidx} {{0x00} {x:Btagidx} {l:Blabelidx}} => CATCH_catch(x, l)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod{x : idx, l : labelidx} {{0x01} {x:Btagidx} {l:Blabelidx}} => CATCH_REF_catch(x, l)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod{l : labelidx} {{0x02} {l:Blabelidx}} => CATCH_ALL_catch(l)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod{l : labelidx} {{0x03} {l:Blabelidx}} => CATCH_ALL_REF_catch(l)

;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
syntax memidxop = (memidx, memarg)

;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
grammar Bmemarg : memidxop
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod{n : n, m : m} {{`%`_u32(n):Bu32} {`%`_u64(m):Bu64}} => (`%`_memidx(0), {ALIGN `%`_u32(n), OFFSET `%`_u64(m)})
    -- if (n < (2 ^ 6))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod{n : n, x : idx, m : m} {{`%`_u32(n):Bu32} {x:Bmemidx} {`%`_u64(m):Bu64}} => (x, {ALIGN `%`_u32((((n : nat <:> int) - ((2 ^ 6) : nat <:> int)) : int <:> nat)), OFFSET `%`_u64(m)})
    -- if (((2 ^ 6) <= n) /\ (n < (2 ^ 7)))

;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
grammar Blaneidx : laneidx
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod{l : labelidx} `%`_byte(l!`%`_labelidx.0):Bbyte => `%`_laneidx(l!`%`_labelidx.0)

;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
rec {

;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:793.1-807.71
grammar Binstr : instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:8.5-8.24
  prod 0x00 => UNREACHABLE_instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:9.5-9.16
  prod 0x01 => NOP_instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:10.5-10.17
  prod 0x1A => DROP_instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:11.5-11.19
  prod 0x1B => SELECT_instr(?())
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:12.5-12.41
  prod{`t*` : valtype*} {{0x1C} {t*{t <- `t*`}:Blist(syntax valtype, grammar Bvaltype)}} => SELECT_instr(?(t*{t <- `t*`}))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:32.5-32.57
  prod{bt : blocktype, `in*` : instr*} {{0x02} {bt:Bblocktype} {in:Binstr*{in <- `in*`}} {0x0B}} => BLOCK_instr(bt, in*{in <- `in*`})
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:33.5-33.56
  prod{bt : blocktype, `in*` : instr*} {{0x03} {bt:Bblocktype} {in:Binstr*{in <- `in*`}} {0x0B}} => LOOP_instr(bt, in*{in <- `in*`})
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:34.5-34.63
  prod{bt : blocktype, `in*` : instr*} {{0x04} {bt:Bblocktype} {in:Binstr*{in <- `in*`}} {0x0B}} => `IF%%ELSE%`_instr(bt, in*{in <- `in*`}, [])
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:35.5-36.55
  prod{bt : blocktype, `in_1*` : instr*, `in_2*` : instr*} {{0x04} {bt:Bblocktype} {in_1:Binstr*{in_1 <- `in_1*`}} {0x05} {in_2:Binstr*{in_2 <- `in_2*`}} {0x0B}} => `IF%%ELSE%`_instr(bt, in_1*{in_1 <- `in_1*`}, in_2*{in_2 <- `in_2*`})
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:40.5-40.30
  prod{x : idx} {{0x08} {x:Btagidx}} => THROW_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:41.5-41.22
  prod 0x0A => THROW_REF_instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:42.5-42.29
  prod{l : labelidx} {{0x0C} {l:Blabelidx}} => BR_instr(l)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:43.5-43.32
  prod{l : labelidx} {{0x0D} {l:Blabelidx}} => BR_IF_instr(l)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:44.5-44.62
  prod{`l*` : labelidx*, l_n : labelidx} {{0x0E} {l*{l <- `l*`}:Blist(syntax labelidx, grammar Blabelidx)} {l_n:Blabelidx}} => BR_TABLE_instr(l*{l <- `l*`}, l_n)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:45.5-45.19
  prod 0x0F => RETURN_instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:46.5-46.30
  prod{x : idx} {{0x10} {x:Bfuncidx}} => CALL_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:47.5-47.60
  prod{y : idx, x : idx} {{0x11} {y:Btypeidx} {x:Btableidx}} => CALL_INDIRECT_instr(x, _IDX_typeuse(y))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:48.5-48.37
  prod{x : idx} {{0x12} {x:Bfuncidx}} => RETURN_CALL_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:49.5-49.67
  prod{y : idx, x : idx} {{0x13} {y:Btypeidx} {x:Btableidx}} => RETURN_CALL_INDIRECT_instr(x, _IDX_typeuse(y))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:50.5-50.41
  prod{x : idx} {{0x14} {x:Btypeidx}} => CALL_REF_instr(_IDX_typeuse(x))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:51.5-51.48
  prod{x : idx} {{0x15} {x:Btypeidx}} => RETURN_CALL_REF_instr(_IDX_typeuse(x))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:52.5-52.81
  prod{bt : blocktype, `c*` : catch*, `in*` : instr*} {{0x1F} {bt:Bblocktype} {c*{c <- `c*`}:Blist(syntax catch, grammar Bcatch)} {in:Binstr*{in <- `in*`}} {0x0B}} => TRY_TABLE_instr(bt, `%`_list(c*{c <- `c*`}), in*{in <- `in*`})
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:53.5-53.37
  prod{l : labelidx} {{0xD5} {l:Blabelidx}} => BR_ON_NULL_instr(l)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:54.5-54.41
  prod{l : labelidx} {{0xD6} {l:Blabelidx}} => BR_ON_NON_NULL_instr(l)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:55.5-56.100
  prod{`null_1?` : null?, `null_2?` : null?, l : labelidx, ht_1 : heaptype, ht_2 : heaptype} {{0xFB} {`%`_u32(24):Bu32} {(null_1?{null_1 <- `null_1?`}, null_2?{null_2 <- `null_2?`}):Bcastop} {l:Blabelidx} {ht_1:Bheaptype} {ht_2:Bheaptype}} => BR_ON_CAST_instr(l, REF_reftype(null_1?{null_1 <- `null_1?`}, ht_1), REF_reftype(null_2?{null_2 <- `null_2?`}, ht_2))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:57.5-58.105
  prod{`null_1?` : null?, `null_2?` : null?, l : labelidx, ht_1 : heaptype, ht_2 : heaptype} {{0xFB} {`%`_u32(25):Bu32} {(null_1?{null_1 <- `null_1?`}, null_2?{null_2 <- `null_2?`}):Bcastop} {l:Blabelidx} {ht_1:Bheaptype} {ht_2:Bheaptype}} => BR_ON_CAST_FAIL_instr(l, REF_reftype(null_1?{null_1 <- `null_1?`}, ht_1), REF_reftype(null_2?{null_2 <- `null_2?`}, ht_2))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:71.5-71.36
  prod{x : idx} {{0x20} {x:Blocalidx}} => LOCAL.GET_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:72.5-72.36
  prod{x : idx} {{0x21} {x:Blocalidx}} => LOCAL.SET_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:73.5-73.36
  prod{x : idx} {{0x22} {x:Blocalidx}} => LOCAL.TEE_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:77.5-77.38
  prod{x : idx} {{0x23} {x:Bglobalidx}} => GLOBAL.GET_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:78.5-78.38
  prod{x : idx} {{0x24} {x:Bglobalidx}} => GLOBAL.SET_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:85.5-85.36
  prod{x : idx} {{0x25} {x:Btableidx}} => TABLE.GET_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:86.5-86.36
  prod{x : idx} {{0x26} {x:Btableidx}} => TABLE.SET_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:87.5-87.58
  prod{y : idx, x : idx} {{0xFC} {`%`_u32(12):Bu32} {y:Belemidx} {x:Btableidx}} => TABLE.INIT_instr(x, y)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:88.5-88.43
  prod{x : idx} {{0xFC} {`%`_u32(13):Bu32} {x:Belemidx}} => ELEM.DROP_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:89.5-89.67
  prod{x_1 : idx, x_2 : idx} {{0xFC} {`%`_u32(14):Bu32} {x_1:Btableidx} {x_2:Btableidx}} => TABLE.COPY_instr(x_1, x_2)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:90.5-90.45
  prod{x : idx} {{0xFC} {`%`_u32(15):Bu32} {x:Btableidx}} => TABLE.GROW_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:91.5-91.45
  prod{x : idx} {{0xFC} {`%`_u32(16):Bu32} {x:Btableidx}} => TABLE.SIZE_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:92.5-92.45
  prod{x : idx} {{0xFC} {`%`_u32(17):Bu32} {x:Btableidx}} => TABLE.FILL_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:105.5-105.41
  prod{x : idx, ao : memarg} {{0x28} {(x, ao):Bmemarg}} => LOAD_instr(I32_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:106.5-106.41
  prod{x : idx, ao : memarg} {{0x29} {(x, ao):Bmemarg}} => LOAD_instr(I64_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:107.5-107.41
  prod{x : idx, ao : memarg} {{0x2A} {(x, ao):Bmemarg}} => LOAD_instr(F32_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:108.5-108.41
  prod{x : idx, ao : memarg} {{0x2B} {(x, ao):Bmemarg}} => LOAD_instr(F64_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:109.5-109.50
  prod{x : idx, ao : memarg} {{0x2C} {(x, ao):Bmemarg}} => LOAD_instr(I32_numtype, ?(`%_%`_loadop_(`%`_sz(8), S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:110.5-110.50
  prod{x : idx, ao : memarg} {{0x2D} {(x, ao):Bmemarg}} => LOAD_instr(I32_numtype, ?(`%_%`_loadop_(`%`_sz(8), U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:111.5-111.51
  prod{x : idx, ao : memarg} {{0x2E} {(x, ao):Bmemarg}} => LOAD_instr(I32_numtype, ?(`%_%`_loadop_(`%`_sz(16), S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:112.5-112.51
  prod{x : idx, ao : memarg} {{0x2F} {(x, ao):Bmemarg}} => LOAD_instr(I32_numtype, ?(`%_%`_loadop_(`%`_sz(16), U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:113.5-113.50
  prod{x : idx, ao : memarg} {{0x30} {(x, ao):Bmemarg}} => LOAD_instr(I64_numtype, ?(`%_%`_loadop_(`%`_sz(8), S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:114.5-114.50
  prod{x : idx, ao : memarg} {{0x31} {(x, ao):Bmemarg}} => LOAD_instr(I64_numtype, ?(`%_%`_loadop_(`%`_sz(8), U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:115.5-115.51
  prod{x : idx, ao : memarg} {{0x32} {(x, ao):Bmemarg}} => LOAD_instr(I64_numtype, ?(`%_%`_loadop_(`%`_sz(16), S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:116.5-116.51
  prod{x : idx, ao : memarg} {{0x33} {(x, ao):Bmemarg}} => LOAD_instr(I64_numtype, ?(`%_%`_loadop_(`%`_sz(16), U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:117.5-117.51
  prod{x : idx, ao : memarg} {{0x34} {(x, ao):Bmemarg}} => LOAD_instr(I64_numtype, ?(`%_%`_loadop_(`%`_sz(32), S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:118.5-118.51
  prod{x : idx, ao : memarg} {{0x35} {(x, ao):Bmemarg}} => LOAD_instr(I64_numtype, ?(`%_%`_loadop_(`%`_sz(32), U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:119.5-119.42
  prod{x : idx, ao : memarg} {{0x36} {(x, ao):Bmemarg}} => STORE_instr(I32_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:120.5-120.42
  prod{x : idx, ao : memarg} {{0x37} {(x, ao):Bmemarg}} => STORE_instr(I64_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:121.5-121.42
  prod{x : idx, ao : memarg} {{0x38} {(x, ao):Bmemarg}} => STORE_instr(F32_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:122.5-122.42
  prod{x : idx, ao : memarg} {{0x39} {(x, ao):Bmemarg}} => STORE_instr(F64_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:123.5-123.45
  prod{x : idx, ao : memarg} {{0x3A} {(x, ao):Bmemarg}} => STORE_instr(I32_numtype, ?(`%`_storeop_(`%`_sz(8))), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:124.5-124.46
  prod{x : idx, ao : memarg} {{0x3B} {(x, ao):Bmemarg}} => STORE_instr(I32_numtype, ?(`%`_storeop_(`%`_sz(16))), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:125.5-125.45
  prod{x : idx, ao : memarg} {{0x3C} {(x, ao):Bmemarg}} => STORE_instr(I64_numtype, ?(`%`_storeop_(`%`_sz(8))), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:126.5-126.46
  prod{x : idx, ao : memarg} {{0x3D} {(x, ao):Bmemarg}} => STORE_instr(I64_numtype, ?(`%`_storeop_(`%`_sz(16))), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:127.5-127.46
  prod{x : idx, ao : memarg} {{0x3E} {(x, ao):Bmemarg}} => STORE_instr(I64_numtype, ?(`%`_storeop_(`%`_sz(32))), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:128.5-128.36
  prod{x : idx} {{0x3F} {x:Bmemidx}} => MEMORY.SIZE_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:129.5-129.36
  prod{x : idx} {{0x40} {x:Bmemidx}} => MEMORY.GROW_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:130.5-130.56
  prod{y : idx, x : idx} {{0xFC} {`%`_u32(8):Bu32} {y:Bdataidx} {x:Bmemidx}} => MEMORY.INIT_instr(x, y)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:131.5-131.42
  prod{x : idx} {{0xFC} {`%`_u32(9):Bu32} {x:Bdataidx}} => DATA.DROP_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:132.5-132.64
  prod{x_1 : idx, x_2 : idx} {{0xFC} {`%`_u32(10):Bu32} {x_1:Bmemidx} {x_2:Bmemidx}} => MEMORY.COPY_instr(x_1, x_2)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:133.5-133.44
  prod{x : idx} {{0xFC} {`%`_u32(11):Bu32} {x:Bmemidx}} => MEMORY.FILL_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:140.5-140.37
  prod{ht : heaptype} {{0xD0} {ht:Bheaptype}} => REF.NULL_instr(ht)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:141.5-141.24
  prod 0xD1 => REF.IS_NULL_instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:142.5-142.34
  prod{x : idx} {{0xD2} {x:Bfuncidx}} => REF.FUNC_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:143.5-143.19
  prod 0xD3 => REF.EQ_instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:144.5-144.28
  prod 0xD4 => REF.AS_NON_NULL_instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:145.5-145.51
  prod{ht : heaptype} {{0xFB} {`%`_u32(20):Bu32} {ht:Bheaptype}} => REF.TEST_instr(REF_reftype(?(), ht))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:146.5-146.56
  prod{ht : heaptype} {{0xFB} {`%`_u32(21):Bu32} {ht:Bheaptype}} => REF.TEST_instr(REF_reftype(?(NULL_null), ht))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:147.5-147.51
  prod{ht : heaptype} {{0xFB} {`%`_u32(22):Bu32} {ht:Bheaptype}} => REF.CAST_instr(REF_reftype(?(), ht))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:148.5-148.56
  prod{ht : heaptype} {{0xFB} {`%`_u32(23):Bu32} {ht:Bheaptype}} => REF.CAST_instr(REF_reftype(?(NULL_null), ht))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:152.5-152.43
  prod{x : idx} {{0xFB} {`%`_u32(0):Bu32} {x:Btypeidx}} => STRUCT.NEW_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:153.5-153.51
  prod{x : idx} {{0xFB} {`%`_u32(1):Bu32} {x:Btypeidx}} => STRUCT.NEW_DEFAULT_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:154.5-154.52
  prod{x : idx, i : u32} {{0xFB} {`%`_u32(2):Bu32} {x:Btypeidx} {i:Bu32}} => STRUCT.GET_instr(?(), x, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:155.5-155.54
  prod{x : idx, i : u32} {{0xFB} {`%`_u32(3):Bu32} {x:Btypeidx} {i:Bu32}} => STRUCT.GET_instr(?(S_sx), x, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:156.5-156.54
  prod{x : idx, i : u32} {{0xFB} {`%`_u32(4):Bu32} {x:Btypeidx} {i:Bu32}} => STRUCT.GET_instr(?(U_sx), x, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:157.5-157.52
  prod{x : idx, i : u32} {{0xFB} {`%`_u32(5):Bu32} {x:Btypeidx} {i:Bu32}} => STRUCT.SET_instr(x, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:161.5-161.42
  prod{x : idx} {{0xFB} {`%`_u32(6):Bu32} {x:Btypeidx}} => ARRAY.NEW_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:162.5-162.50
  prod{x : idx} {{0xFB} {`%`_u32(7):Bu32} {x:Btypeidx}} => ARRAY.NEW_DEFAULT_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:163.5-163.57
  prod{x : idx, n : n} {{0xFB} {`%`_u32(8):Bu32} {x:Btypeidx} {`%`_u32(n):Bu32}} => ARRAY.NEW_FIXED_instr(x, `%`_u32(n))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:164.5-164.60
  prod{x : idx, y : idx} {{0xFB} {`%`_u32(9):Bu32} {x:Btypeidx} {y:Bdataidx}} => ARRAY.NEW_DATA_instr(x, y)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:165.5-165.61
  prod{x : idx, y : idx} {{0xFB} {`%`_u32(10):Bu32} {x:Btypeidx} {y:Belemidx}} => ARRAY.NEW_ELEM_instr(x, y)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:166.5-166.43
  prod{x : idx} {{0xFB} {`%`_u32(11):Bu32} {x:Btypeidx}} => ARRAY.GET_instr(?(), x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:167.5-167.45
  prod{x : idx} {{0xFB} {`%`_u32(12):Bu32} {x:Btypeidx}} => ARRAY.GET_instr(?(S_sx), x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:168.5-168.45
  prod{x : idx} {{0xFB} {`%`_u32(13):Bu32} {x:Btypeidx}} => ARRAY.GET_instr(?(U_sx), x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:169.5-169.43
  prod{x : idx} {{0xFB} {`%`_u32(14):Bu32} {x:Btypeidx}} => ARRAY.SET_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:170.5-170.30
  prod {{0xFB} {`%`_u32(15):Bu32}} => ARRAY.LEN_instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:171.5-171.44
  prod{x : idx} {{0xFB} {`%`_u32(16):Bu32} {x:Btypeidx}} => ARRAY.FILL_instr(x)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:172.5-172.65
  prod{x_1 : idx, x_2 : idx} {{0xFB} {`%`_u32(17):Bu32} {x_1:Btypeidx} {x_2:Btypeidx}} => ARRAY.COPY_instr(x_1, x_2)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:173.5-173.62
  prod{x : idx, y : idx} {{0xFB} {`%`_u32(18):Bu32} {x:Btypeidx} {y:Bdataidx}} => ARRAY.INIT_DATA_instr(x, y)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:174.5-174.62
  prod{x : idx, y : idx} {{0xFB} {`%`_u32(19):Bu32} {x:Btypeidx} {y:Belemidx}} => ARRAY.INIT_ELEM_instr(x, y)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:178.5-178.39
  prod {{0xFB} {`%`_u32(26):Bu32}} => ANY.CONVERT_EXTERN_instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:179.5-179.39
  prod {{0xFB} {`%`_u32(27):Bu32}} => EXTERN.CONVERT_ANY_instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:183.5-183.28
  prod {{0xFB} {`%`_u32(28):Bu32}} => REF.I31_instr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:184.5-184.30
  prod {{0xFB} {`%`_u32(29):Bu32}} => I31.GET_instr(S_sx)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:185.5-185.30
  prod {{0xFB} {`%`_u32(30):Bu32}} => I31.GET_instr(U_sx)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:192.5-192.31
  prod{i : i32} {{0x41} {i:Bi32}} => CONST_instr(I32_numtype, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:193.5-193.31
  prod{i : i64} {{0x42} {i:Bi64}} => CONST_instr(I64_numtype, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:194.5-194.31
  prod{p : f32} {{0x43} {p:Bf32}} => CONST_instr(F32_numtype, p)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:195.5-195.31
  prod{p : f64} {{0x44} {p:Bf64}} => CONST_instr(F64_numtype, p)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:199.5-199.27
  prod 0x45 => TESTOP_instr(I32_numtype, EQZ_testop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:203.5-203.25
  prod 0x46 => RELOP_instr(I32_numtype, EQ_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:204.5-204.25
  prod 0x47 => RELOP_instr(I32_numtype, NE_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:205.5-205.27
  prod 0x48 => RELOP_instr(I32_numtype, LT_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:206.5-206.27
  prod 0x49 => RELOP_instr(I32_numtype, LT_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:207.5-207.27
  prod 0x4A => RELOP_instr(I32_numtype, GT_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:208.5-208.27
  prod 0x4B => RELOP_instr(I32_numtype, GT_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:209.5-209.27
  prod 0x4C => RELOP_instr(I32_numtype, LE_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:210.5-210.27
  prod 0x4D => RELOP_instr(I32_numtype, LE_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:211.5-211.27
  prod 0x4E => RELOP_instr(I32_numtype, GE_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:212.5-212.27
  prod 0x4F => RELOP_instr(I32_numtype, GE_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:216.5-216.27
  prod 0x50 => TESTOP_instr(I64_numtype, EQZ_testop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:220.5-220.25
  prod 0x51 => RELOP_instr(I64_numtype, EQ_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:221.5-221.25
  prod 0x52 => RELOP_instr(I64_numtype, NE_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:222.5-222.27
  prod 0x53 => RELOP_instr(I64_numtype, LT_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:223.5-223.27
  prod 0x54 => RELOP_instr(I64_numtype, LT_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:224.5-224.27
  prod 0x55 => RELOP_instr(I64_numtype, GT_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:225.5-225.27
  prod 0x56 => RELOP_instr(I64_numtype, GT_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:226.5-226.27
  prod 0x57 => RELOP_instr(I64_numtype, LE_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:227.5-227.27
  prod 0x58 => RELOP_instr(I64_numtype, LE_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:228.5-228.27
  prod 0x59 => RELOP_instr(I64_numtype, GE_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:229.5-229.27
  prod 0x5A => RELOP_instr(I64_numtype, GE_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:233.5-233.25
  prod 0x5B => RELOP_instr(F32_numtype, EQ_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:234.5-234.25
  prod 0x5C => RELOP_instr(F32_numtype, NE_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:235.5-235.25
  prod 0x5D => RELOP_instr(F32_numtype, LT_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:236.5-236.25
  prod 0x5E => RELOP_instr(F32_numtype, GT_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:237.5-237.25
  prod 0x5F => RELOP_instr(F32_numtype, LE_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:238.5-238.25
  prod 0x60 => RELOP_instr(F32_numtype, GE_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:242.5-242.25
  prod 0x61 => RELOP_instr(F64_numtype, EQ_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:243.5-243.25
  prod 0x62 => RELOP_instr(F64_numtype, NE_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:244.5-244.25
  prod 0x63 => RELOP_instr(F64_numtype, LT_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:245.5-245.25
  prod 0x64 => RELOP_instr(F64_numtype, GT_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:246.5-246.25
  prod 0x65 => RELOP_instr(F64_numtype, LE_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:247.5-247.25
  prod 0x66 => RELOP_instr(F64_numtype, GE_relop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:251.5-251.25
  prod 0x67 => UNOP_instr(I32_numtype, CLZ_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:252.5-252.25
  prod 0x68 => UNOP_instr(I32_numtype, CTZ_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:253.5-253.28
  prod 0x69 => UNOP_instr(I32_numtype, POPCNT_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:257.5-257.26
  prod 0x6A => BINOP_instr(I32_numtype, ADD_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:258.5-258.26
  prod 0x6B => BINOP_instr(I32_numtype, SUB_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:259.5-259.26
  prod 0x6C => BINOP_instr(I32_numtype, MUL_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:260.5-260.28
  prod 0x6D => BINOP_instr(I32_numtype, DIV_binop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:261.5-261.28
  prod 0x6E => BINOP_instr(I32_numtype, DIV_binop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:262.5-262.28
  prod 0x6F => BINOP_instr(I32_numtype, REM_binop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:263.5-263.28
  prod 0x70 => BINOP_instr(I32_numtype, REM_binop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:264.5-264.26
  prod 0x71 => BINOP_instr(I32_numtype, AND_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:265.5-265.25
  prod 0x72 => BINOP_instr(I32_numtype, OR_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:266.5-266.26
  prod 0x73 => BINOP_instr(I32_numtype, XOR_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:267.5-267.26
  prod 0x74 => BINOP_instr(I32_numtype, SHL_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:268.5-268.28
  prod 0x75 => BINOP_instr(I32_numtype, SHR_binop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:269.5-269.28
  prod 0x76 => BINOP_instr(I32_numtype, SHR_binop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:270.5-270.27
  prod 0x77 => BINOP_instr(I32_numtype, ROTL_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:271.5-271.27
  prod 0x78 => BINOP_instr(I32_numtype, ROTR_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:275.5-275.25
  prod 0x79 => UNOP_instr(I64_numtype, CLZ_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:276.5-276.25
  prod 0x7A => UNOP_instr(I64_numtype, CTZ_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:277.5-277.28
  prod 0x7B => UNOP_instr(I64_numtype, POPCNT_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:281.5-281.31
  prod 0xC0 => UNOP_instr(I32_numtype, EXTEND_unop_(`%`_sz(8)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:282.5-282.32
  prod 0xC1 => UNOP_instr(I32_numtype, EXTEND_unop_(`%`_sz(16)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:286.5-286.31
  prod 0xC2 => UNOP_instr(I64_numtype, EXTEND_unop_(`%`_sz(8)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:287.5-287.32
  prod 0xC3 => UNOP_instr(I64_numtype, EXTEND_unop_(`%`_sz(16)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:288.5-288.32
  prod 0xC4 => UNOP_instr(I64_numtype, EXTEND_unop_(`%`_sz(32)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:292.5-292.26
  prod 0x7C => BINOP_instr(I64_numtype, ADD_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:293.5-293.26
  prod 0x7D => BINOP_instr(I64_numtype, SUB_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:294.5-294.26
  prod 0x7E => BINOP_instr(I64_numtype, MUL_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:295.5-295.28
  prod 0x7F => BINOP_instr(I64_numtype, DIV_binop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:296.5-296.28
  prod 0x80 => BINOP_instr(I64_numtype, DIV_binop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:297.5-297.28
  prod 0x81 => BINOP_instr(I64_numtype, REM_binop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:298.5-298.28
  prod 0x82 => BINOP_instr(I64_numtype, REM_binop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:299.5-299.26
  prod 0x83 => BINOP_instr(I64_numtype, AND_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:300.5-300.25
  prod 0x84 => BINOP_instr(I64_numtype, OR_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:301.5-301.26
  prod 0x85 => BINOP_instr(I64_numtype, XOR_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:302.5-302.26
  prod 0x86 => BINOP_instr(I64_numtype, SHL_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:303.5-303.28
  prod 0x87 => BINOP_instr(I64_numtype, SHR_binop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:304.5-304.28
  prod 0x88 => BINOP_instr(I64_numtype, SHR_binop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:305.5-305.27
  prod 0x89 => BINOP_instr(I64_numtype, ROTL_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:306.5-306.27
  prod 0x8A => BINOP_instr(I64_numtype, ROTR_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:310.5-310.25
  prod 0x8B => UNOP_instr(F32_numtype, ABS_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:311.5-311.25
  prod 0x8C => UNOP_instr(F32_numtype, NEG_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:312.5-312.26
  prod 0x8D => UNOP_instr(F32_numtype, CEIL_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:313.5-313.27
  prod 0x8E => UNOP_instr(F32_numtype, FLOOR_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:314.5-314.27
  prod 0x8F => UNOP_instr(F32_numtype, TRUNC_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:315.5-315.29
  prod 0x90 => UNOP_instr(F32_numtype, NEAREST_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:316.5-316.26
  prod 0x91 => UNOP_instr(F32_numtype, SQRT_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:320.5-320.26
  prod 0x92 => BINOP_instr(F32_numtype, ADD_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:321.5-321.26
  prod 0x93 => BINOP_instr(F32_numtype, SUB_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:322.5-322.26
  prod 0x94 => BINOP_instr(F32_numtype, MUL_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:323.5-323.26
  prod 0x95 => BINOP_instr(F32_numtype, DIV_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:324.5-324.26
  prod 0x96 => BINOP_instr(F32_numtype, MIN_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:325.5-325.26
  prod 0x97 => BINOP_instr(F32_numtype, MAX_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:326.5-326.31
  prod 0x98 => BINOP_instr(F32_numtype, COPYSIGN_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:330.5-330.25
  prod 0x99 => UNOP_instr(F64_numtype, ABS_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:331.5-331.25
  prod 0x9A => UNOP_instr(F64_numtype, NEG_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:332.5-332.26
  prod 0x9B => UNOP_instr(F64_numtype, CEIL_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:333.5-333.27
  prod 0x9C => UNOP_instr(F64_numtype, FLOOR_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:334.5-334.27
  prod 0x9D => UNOP_instr(F64_numtype, TRUNC_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:335.5-335.29
  prod 0x9E => UNOP_instr(F64_numtype, NEAREST_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:336.5-336.26
  prod 0x9F => UNOP_instr(F64_numtype, SQRT_unop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:340.5-340.26
  prod 0xA0 => BINOP_instr(F64_numtype, ADD_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:341.5-341.26
  prod 0xA1 => BINOP_instr(F64_numtype, SUB_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:342.5-342.26
  prod 0xA2 => BINOP_instr(F64_numtype, MUL_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:343.5-343.26
  prod 0xA3 => BINOP_instr(F64_numtype, DIV_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:344.5-344.26
  prod 0xA4 => BINOP_instr(F64_numtype, MIN_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:345.5-345.26
  prod 0xA5 => BINOP_instr(F64_numtype, MAX_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:346.5-346.31
  prod 0xA6 => BINOP_instr(F64_numtype, COPYSIGN_binop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:351.5-351.31
  prod 0xA7 => CVTOP_instr(I32_numtype, I64_numtype, WRAP_cvtop__)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:352.5-352.34
  prod 0xA8 => CVTOP_instr(I32_numtype, F32_numtype, TRUNC_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:353.5-353.34
  prod 0xA9 => CVTOP_instr(I32_numtype, F32_numtype, TRUNC_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:354.5-354.34
  prod 0xAA => CVTOP_instr(I32_numtype, F64_numtype, TRUNC_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:355.5-355.34
  prod 0xAB => CVTOP_instr(I32_numtype, F64_numtype, TRUNC_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:356.5-356.35
  prod 0xAC => CVTOP_instr(I64_numtype, I32_numtype, EXTEND_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:357.5-357.35
  prod 0xAD => CVTOP_instr(I64_numtype, I32_numtype, EXTEND_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:358.5-358.34
  prod 0xAE => CVTOP_instr(I64_numtype, F32_numtype, TRUNC_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:359.5-359.34
  prod 0xAF => CVTOP_instr(I64_numtype, F32_numtype, TRUNC_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:360.5-360.34
  prod 0xB0 => CVTOP_instr(I64_numtype, F64_numtype, TRUNC_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:361.5-361.34
  prod 0xB1 => CVTOP_instr(I64_numtype, F64_numtype, TRUNC_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:362.5-362.36
  prod 0xB2 => CVTOP_instr(F32_numtype, I32_numtype, CONVERT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:363.5-363.36
  prod 0xB3 => CVTOP_instr(F32_numtype, I32_numtype, CONVERT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:364.5-364.36
  prod 0xB4 => CVTOP_instr(F32_numtype, I64_numtype, CONVERT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:365.5-365.36
  prod 0xB5 => CVTOP_instr(F32_numtype, I64_numtype, CONVERT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:366.5-366.33
  prod 0xB6 => CVTOP_instr(F32_numtype, F64_numtype, DEMOTE_cvtop__)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:367.5-367.36
  prod 0xB7 => CVTOP_instr(F64_numtype, I32_numtype, CONVERT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:368.5-368.36
  prod 0xB8 => CVTOP_instr(F64_numtype, I32_numtype, CONVERT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:369.5-369.36
  prod 0xB9 => CVTOP_instr(F64_numtype, I64_numtype, CONVERT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:370.5-370.36
  prod 0xBA => CVTOP_instr(F64_numtype, I64_numtype, CONVERT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:371.5-371.34
  prod 0xBB => CVTOP_instr(F64_numtype, F32_numtype, PROMOTE_cvtop__)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:372.5-372.38
  prod 0xBC => CVTOP_instr(I32_numtype, F32_numtype, REINTERPRET_cvtop__)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:373.5-373.38
  prod 0xBD => CVTOP_instr(I64_numtype, F64_numtype, REINTERPRET_cvtop__)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:374.5-374.38
  prod 0xBE => CVTOP_instr(F32_numtype, I32_numtype, REINTERPRET_cvtop__)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:375.5-375.38
  prod 0xBF => CVTOP_instr(F64_numtype, I64_numtype, REINTERPRET_cvtop__)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:379.5-379.45
  prod {{0xFC} {`%`_u32(0):Bu32}} => CVTOP_instr(I32_numtype, F32_numtype, TRUNC_SAT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:380.5-380.45
  prod {{0xFC} {`%`_u32(1):Bu32}} => CVTOP_instr(I32_numtype, F32_numtype, TRUNC_SAT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:381.5-381.45
  prod {{0xFC} {`%`_u32(2):Bu32}} => CVTOP_instr(I32_numtype, F64_numtype, TRUNC_SAT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:382.5-382.45
  prod {{0xFC} {`%`_u32(3):Bu32}} => CVTOP_instr(I32_numtype, F64_numtype, TRUNC_SAT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:383.5-383.45
  prod {{0xFC} {`%`_u32(4):Bu32}} => CVTOP_instr(I64_numtype, F32_numtype, TRUNC_SAT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:384.5-384.45
  prod {{0xFC} {`%`_u32(5):Bu32}} => CVTOP_instr(I64_numtype, F32_numtype, TRUNC_SAT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:385.5-385.45
  prod {{0xFC} {`%`_u32(6):Bu32}} => CVTOP_instr(I64_numtype, F64_numtype, TRUNC_SAT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:386.5-386.45
  prod {{0xFC} {`%`_u32(7):Bu32}} => CVTOP_instr(I64_numtype, F64_numtype, TRUNC_SAT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:396.5-396.50
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(0):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:397.5-397.70
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(1):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(8), 8, S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:398.5-398.70
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(2):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(8), 8, U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:399.5-399.71
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(3):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(16), 4, S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:400.5-400.71
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(4):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(16), 4, U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:401.5-401.71
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(5):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(32), 2, S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:402.5-402.71
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(6):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(32), 2, U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:403.5-403.61
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(7):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(8))), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:404.5-404.62
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(8):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(16))), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:405.5-405.62
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(9):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(32))), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:406.5-406.63
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(10):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(64))), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:407.5-407.52
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(11):Bu32} {(x, ao):Bmemarg}} => VSTORE_instr(V128_vectype, x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:408.5-408.72
  prod{x : idx, ao : memarg, i : laneidx} {{0xFD} {`%`_u32(84):Bu32} {(x, ao):Bmemarg} {i:Blaneidx}} => VLOAD_LANE_instr(V128_vectype, `%`_sz(8), x, ao, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:409.5-409.73
  prod{x : idx, ao : memarg, i : laneidx} {{0xFD} {`%`_u32(85):Bu32} {(x, ao):Bmemarg} {i:Blaneidx}} => VLOAD_LANE_instr(V128_vectype, `%`_sz(16), x, ao, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:410.5-410.73
  prod{x : idx, ao : memarg, i : laneidx} {{0xFD} {`%`_u32(86):Bu32} {(x, ao):Bmemarg} {i:Blaneidx}} => VLOAD_LANE_instr(V128_vectype, `%`_sz(32), x, ao, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:411.5-411.73
  prod{x : idx, ao : memarg, i : laneidx} {{0xFD} {`%`_u32(87):Bu32} {(x, ao):Bmemarg} {i:Blaneidx}} => VLOAD_LANE_instr(V128_vectype, `%`_sz(64), x, ao, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:412.5-412.73
  prod{x : idx, ao : memarg, i : laneidx} {{0xFD} {`%`_u32(88):Bu32} {(x, ao):Bmemarg} {i:Blaneidx}} => VSTORE_LANE_instr(V128_vectype, `%`_sz(8), x, ao, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:413.5-413.74
  prod{x : idx, ao : memarg, i : laneidx} {{0xFD} {`%`_u32(89):Bu32} {(x, ao):Bmemarg} {i:Blaneidx}} => VSTORE_LANE_instr(V128_vectype, `%`_sz(16), x, ao, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:414.5-414.74
  prod{x : idx, ao : memarg, i : laneidx} {{0xFD} {`%`_u32(90):Bu32} {(x, ao):Bmemarg} {i:Blaneidx}} => VSTORE_LANE_instr(V128_vectype, `%`_sz(32), x, ao, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:415.5-415.74
  prod{x : idx, ao : memarg, i : laneidx} {{0xFD} {`%`_u32(91):Bu32} {(x, ao):Bmemarg} {i:Blaneidx}} => VSTORE_LANE_instr(V128_vectype, `%`_sz(64), x, ao, i)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:416.5-416.62
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(92):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(32))), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:417.5-417.62
  prod{x : idx, ao : memarg} {{0xFD} {`%`_u32(93):Bu32} {(x, ao):Bmemarg}} => VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(64))), x, ao)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:421.5-421.72
  prod{`b*` : byte*} {{0xFD} {`%`_u32(12):Bu32} {b:Bbyte^16{b <- `b*`}}} => VCONST_instr(V128_vectype, $inv_ibytes_(128, b^16{b <- `b*`}))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:425.5-425.61
  prod{`l*` : labelidx*} {{0xFD} {`%`_u32(13):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx^16{l <- `l*`}}} => VSHUFFLE_instr(`%`_bshape(`%X%`_shape(I8_lanetype, `%`_dim(16))), `%`_laneidx(l!`%`_labelidx.0)^16{l <- `l*`})
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:426.5-426.49
  prod {{0xFD} {`%`_u32(14):Bu32}} => VSWIZZLOP_instr(`%`_bshape(`%X%`_shape(I8_lanetype, `%`_dim(16))), SWIZZLE_vswizzlop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:427.5-427.58
  prod {{0xFD} {`%`_u32(256):Bu32}} => VSWIZZLOP_instr(`%`_bshape(`%X%`_shape(I8_lanetype, `%`_dim(16))), RELAXED_SWIZZLE_vswizzlop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:431.5-431.38
  prod {{0xFD} {`%`_u32(15):Bu32}} => VSPLAT_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:432.5-432.38
  prod {{0xFD} {`%`_u32(16):Bu32}} => VSPLAT_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:433.5-433.38
  prod {{0xFD} {`%`_u32(17):Bu32}} => VSPLAT_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:434.5-434.38
  prod {{0xFD} {`%`_u32(18):Bu32}} => VSPLAT_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:435.5-435.38
  prod {{0xFD} {`%`_u32(19):Bu32}} => VSPLAT_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:436.5-436.38
  prod {{0xFD} {`%`_u32(20):Bu32}} => VSPLAT_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:440.5-440.60
  prod{l : labelidx} {{0xFD} {`%`_u32(21):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ?(S_sx), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:441.5-441.60
  prod{l : labelidx} {{0xFD} {`%`_u32(22):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ?(U_sx), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:442.5-442.58
  prod{l : labelidx} {{0xFD} {`%`_u32(23):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VREPLACE_LANE_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:443.5-443.60
  prod{l : labelidx} {{0xFD} {`%`_u32(24):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ?(S_sx), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:444.5-444.60
  prod{l : labelidx} {{0xFD} {`%`_u32(25):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ?(U_sx), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:445.5-445.58
  prod{l : labelidx} {{0xFD} {`%`_u32(26):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VREPLACE_LANE_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:446.5-446.58
  prod{l : labelidx} {{0xFD} {`%`_u32(27):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), ?(), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:447.5-447.58
  prod{l : labelidx} {{0xFD} {`%`_u32(28):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VREPLACE_LANE_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:448.5-448.58
  prod{l : labelidx} {{0xFD} {`%`_u32(29):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), ?(), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:449.5-449.58
  prod{l : labelidx} {{0xFD} {`%`_u32(30):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VREPLACE_LANE_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:450.5-450.58
  prod{l : labelidx} {{0xFD} {`%`_u32(31):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), ?(), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:451.5-451.58
  prod{l : labelidx} {{0xFD} {`%`_u32(32):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VREPLACE_LANE_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:452.5-452.58
  prod{l : labelidx} {{0xFD} {`%`_u32(33):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), ?(), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:453.5-453.58
  prod{l : labelidx} {{0xFD} {`%`_u32(34):Bu32} {`%`_laneidx(l!`%`_labelidx.0):Blaneidx}} => VREPLACE_LANE_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), `%`_laneidx(l!`%`_labelidx.0))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:457.5-457.41
  prod {{0xFD} {`%`_u32(35):Bu32}} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), EQ_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:458.5-458.41
  prod {{0xFD} {`%`_u32(36):Bu32}} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), NE_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:459.5-459.43
  prod {{0xFD} {`%`_u32(37):Bu32}} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), LT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:460.5-460.43
  prod {{0xFD} {`%`_u32(38):Bu32}} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), LT_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:461.5-461.43
  prod {{0xFD} {`%`_u32(39):Bu32}} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), GT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:462.5-462.43
  prod {{0xFD} {`%`_u32(40):Bu32}} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), GT_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:463.5-463.43
  prod {{0xFD} {`%`_u32(41):Bu32}} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), LE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:464.5-464.43
  prod {{0xFD} {`%`_u32(42):Bu32}} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), LE_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:465.5-465.43
  prod {{0xFD} {`%`_u32(43):Bu32}} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), GE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:466.5-466.43
  prod {{0xFD} {`%`_u32(44):Bu32}} => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), GE_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:470.5-470.41
  prod {{0xFD} {`%`_u32(45):Bu32}} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), EQ_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:471.5-471.41
  prod {{0xFD} {`%`_u32(46):Bu32}} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), NE_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:472.5-472.43
  prod {{0xFD} {`%`_u32(47):Bu32}} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), LT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:473.5-473.43
  prod {{0xFD} {`%`_u32(48):Bu32}} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), LT_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:474.5-474.43
  prod {{0xFD} {`%`_u32(49):Bu32}} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), GT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:475.5-475.43
  prod {{0xFD} {`%`_u32(50):Bu32}} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), GT_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:476.5-476.43
  prod {{0xFD} {`%`_u32(51):Bu32}} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), LE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:477.5-477.43
  prod {{0xFD} {`%`_u32(52):Bu32}} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), LE_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:478.5-478.43
  prod {{0xFD} {`%`_u32(53):Bu32}} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), GE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:479.5-479.43
  prod {{0xFD} {`%`_u32(54):Bu32}} => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), GE_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:483.5-483.41
  prod {{0xFD} {`%`_u32(55):Bu32}} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), EQ_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:484.5-484.41
  prod {{0xFD} {`%`_u32(56):Bu32}} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), NE_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:485.5-485.43
  prod {{0xFD} {`%`_u32(57):Bu32}} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), LT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:486.5-486.43
  prod {{0xFD} {`%`_u32(58):Bu32}} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), LT_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:487.5-487.43
  prod {{0xFD} {`%`_u32(59):Bu32}} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), GT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:488.5-488.43
  prod {{0xFD} {`%`_u32(60):Bu32}} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), GT_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:489.5-489.43
  prod {{0xFD} {`%`_u32(61):Bu32}} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), LE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:490.5-490.43
  prod {{0xFD} {`%`_u32(62):Bu32}} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), LE_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:491.5-491.43
  prod {{0xFD} {`%`_u32(63):Bu32}} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), GE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:492.5-492.43
  prod {{0xFD} {`%`_u32(64):Bu32}} => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), GE_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:496.5-496.41
  prod {{0xFD} {`%`_u32(65):Bu32}} => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), EQ_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:497.5-497.41
  prod {{0xFD} {`%`_u32(66):Bu32}} => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), NE_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:498.5-498.41
  prod {{0xFD} {`%`_u32(67):Bu32}} => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), LT_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:499.5-499.41
  prod {{0xFD} {`%`_u32(68):Bu32}} => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), GT_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:500.5-500.41
  prod {{0xFD} {`%`_u32(69):Bu32}} => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), LE_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:501.5-501.41
  prod {{0xFD} {`%`_u32(70):Bu32}} => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), GE_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:505.5-505.41
  prod {{0xFD} {`%`_u32(71):Bu32}} => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), EQ_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:506.5-506.41
  prod {{0xFD} {`%`_u32(72):Bu32}} => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), NE_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:507.5-507.41
  prod {{0xFD} {`%`_u32(73):Bu32}} => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), LT_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:508.5-508.41
  prod {{0xFD} {`%`_u32(74):Bu32}} => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), GT_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:509.5-509.41
  prod {{0xFD} {`%`_u32(75):Bu32}} => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), LE_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:510.5-510.41
  prod {{0xFD} {`%`_u32(76):Bu32}} => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), GE_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:514.5-514.36
  prod {{0xFD} {`%`_u32(77):Bu32}} => VVUNOP_instr(V128_vectype, NOT_vvunop)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:518.5-518.37
  prod {{0xFD} {`%`_u32(78):Bu32}} => VVBINOP_instr(V128_vectype, AND_vvbinop)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:519.5-519.40
  prod {{0xFD} {`%`_u32(79):Bu32}} => VVBINOP_instr(V128_vectype, ANDNOT_vvbinop)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:520.5-520.36
  prod {{0xFD} {`%`_u32(80):Bu32}} => VVBINOP_instr(V128_vectype, OR_vvbinop)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:521.5-521.37
  prod {{0xFD} {`%`_u32(81):Bu32}} => VVBINOP_instr(V128_vectype, XOR_vvbinop)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:525.5-525.44
  prod {{0xFD} {`%`_u32(82):Bu32}} => VVTERNOP_instr(V128_vectype, BITSELECT_vvternop)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:529.5-529.43
  prod {{0xFD} {`%`_u32(83):Bu32}} => VVTESTOP_instr(V128_vectype, ANY_TRUE_vvtestop)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:533.5-533.41
  prod {{0xFD} {`%`_u32(96):Bu32}} => VUNOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ABS_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:534.5-534.41
  prod {{0xFD} {`%`_u32(97):Bu32}} => VUNOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), NEG_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:535.5-535.44
  prod {{0xFD} {`%`_u32(98):Bu32}} => VUNOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), POPCNT_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:539.5-539.48
  prod {{0xFD} {`%`_u32(99):Bu32}} => VTESTOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ALL_TRUE_vtestop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:543.5-543.41
  prod {{0xFD} {`%`_u32(100):Bu32}} => VBITMASK_instr(`%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:547.5-547.53
  prod {{0xFD} {`%`_u32(101):Bu32}} => VNARROW_instr(`%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), S_sx)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:548.5-548.53
  prod {{0xFD} {`%`_u32(102):Bu32}} => VNARROW_instr(`%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), U_sx)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:552.5-552.45
  prod {{0xFD} {`%`_u32(107):Bu32}} => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), SHL_vshiftop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:553.5-553.47
  prod {{0xFD} {`%`_u32(108):Bu32}} => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), SHR_vshiftop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:554.5-554.47
  prod {{0xFD} {`%`_u32(109):Bu32}} => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), SHR_vshiftop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:558.5-558.43
  prod {{0xFD} {`%`_u32(110):Bu32}} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ADD_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:559.5-559.49
  prod {{0xFD} {`%`_u32(111):Bu32}} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ADD_SAT_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:560.5-560.49
  prod {{0xFD} {`%`_u32(112):Bu32}} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ADD_SAT_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:561.5-561.43
  prod {{0xFD} {`%`_u32(113):Bu32}} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), SUB_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:562.5-562.49
  prod {{0xFD} {`%`_u32(114):Bu32}} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), SUB_SAT_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:563.5-563.49
  prod {{0xFD} {`%`_u32(115):Bu32}} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), SUB_SAT_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:564.5-564.45
  prod {{0xFD} {`%`_u32(118):Bu32}} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), MIN_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:565.5-565.45
  prod {{0xFD} {`%`_u32(119):Bu32}} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), MIN_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:566.5-566.45
  prod {{0xFD} {`%`_u32(120):Bu32}} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), MAX_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:567.5-567.45
  prod {{0xFD} {`%`_u32(121):Bu32}} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), MAX_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:568.5-568.46
  prod {{0xFD} {`%`_u32(123):Bu32}} => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), `AVGRU`_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:572.5-572.70
  prod {{0xFD} {`%`_u32(124):Bu32}} => VEXTUNOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), EXTADD_PAIRWISE_vextunop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:573.5-573.70
  prod {{0xFD} {`%`_u32(125):Bu32}} => VEXTUNOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), EXTADD_PAIRWISE_vextunop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:577.5-577.42
  prod {{0xFD} {`%`_u32(128):Bu32}} => VUNOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ABS_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:578.5-578.42
  prod {{0xFD} {`%`_u32(129):Bu32}} => VUNOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), NEG_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:582.5-582.53
  prod {{0xFD} {`%`_u32(130):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `Q15MULR_SATS`_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:583.5-583.43
  prod {{0xFD} {`%`_u32(142):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ADD_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:584.5-584.49
  prod {{0xFD} {`%`_u32(143):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ADD_SAT_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:585.5-585.49
  prod {{0xFD} {`%`_u32(144):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ADD_SAT_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:586.5-586.43
  prod {{0xFD} {`%`_u32(145):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), SUB_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:587.5-587.49
  prod {{0xFD} {`%`_u32(146):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), SUB_SAT_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:588.5-588.49
  prod {{0xFD} {`%`_u32(147):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), SUB_SAT_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:589.5-589.43
  prod {{0xFD} {`%`_u32(149):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MUL_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:590.5-590.45
  prod {{0xFD} {`%`_u32(150):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MIN_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:591.5-591.45
  prod {{0xFD} {`%`_u32(151):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MIN_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:592.5-592.45
  prod {{0xFD} {`%`_u32(152):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MAX_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:593.5-593.45
  prod {{0xFD} {`%`_u32(153):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MAX_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:594.5-594.46
  prod {{0xFD} {`%`_u32(155):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `AVGRU`_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:595.5-595.57
  prod {{0xFD} {`%`_u32(273):Bu32}} => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `RELAXED_Q15MULRS`_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:599.5-599.49
  prod {{0xFD} {`%`_u32(131):Bu32}} => VTESTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ALL_TRUE_vtestop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:603.5-603.41
  prod {{0xFD} {`%`_u32(132):Bu32}} => VBITMASK_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:607.5-607.53
  prod {{0xFD} {`%`_u32(133):Bu32}} => VNARROW_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), S_sx)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:608.5-608.53
  prod {{0xFD} {`%`_u32(134):Bu32}} => VNARROW_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), U_sx)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:612.5-612.63
  prod {{0xFD} {`%`_u32(135):Bu32}} => VCVTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%X%`_shape(I8_lanetype, `%`_dim(16)), EXTEND_vcvtop__(LOW_half, S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:613.5-613.64
  prod {{0xFD} {`%`_u32(136):Bu32}} => VCVTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%X%`_shape(I8_lanetype, `%`_dim(16)), EXTEND_vcvtop__(HIGH_half, S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:614.5-614.63
  prod {{0xFD} {`%`_u32(137):Bu32}} => VCVTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%X%`_shape(I8_lanetype, `%`_dim(16)), EXTEND_vcvtop__(LOW_half, U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:615.5-615.64
  prod {{0xFD} {`%`_u32(138):Bu32}} => VCVTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%X%`_shape(I8_lanetype, `%`_dim(16)), EXTEND_vcvtop__(HIGH_half, U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:619.5-619.45
  prod {{0xFD} {`%`_u32(139):Bu32}} => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), SHL_vshiftop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:620.5-620.47
  prod {{0xFD} {`%`_u32(140):Bu32}} => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), SHR_vshiftop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:621.5-621.47
  prod {{0xFD} {`%`_u32(141):Bu32}} => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), SHR_vshiftop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:625.5-625.66
  prod {{0xFD} {`%`_u32(156):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), EXTMUL_vextbinop__(LOW_half, S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:626.5-626.67
  prod {{0xFD} {`%`_u32(157):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), EXTMUL_vextbinop__(HIGH_half, S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:627.5-627.66
  prod {{0xFD} {`%`_u32(158):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), EXTMUL_vextbinop__(LOW_half, U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:628.5-628.67
  prod {{0xFD} {`%`_u32(159):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), EXTMUL_vextbinop__(HIGH_half, U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:629.5-629.67
  prod {{0xFD} {`%`_u32(274):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), `RELAXED_DOTS`_vextbinop__)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:633.5-633.70
  prod {{0xFD} {`%`_u32(126):Bu32}} => VEXTUNOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), EXTADD_PAIRWISE_vextunop__(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:634.5-634.70
  prod {{0xFD} {`%`_u32(127):Bu32}} => VEXTUNOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), EXTADD_PAIRWISE_vextunop__(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:638.5-638.42
  prod {{0xFD} {`%`_u32(160):Bu32}} => VUNOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), ABS_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:639.5-639.42
  prod {{0xFD} {`%`_u32(161):Bu32}} => VUNOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), NEG_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:643.5-643.49
  prod {{0xFD} {`%`_u32(163):Bu32}} => VTESTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), ALL_TRUE_vtestop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:647.5-647.41
  prod {{0xFD} {`%`_u32(164):Bu32}} => VBITMASK_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:651.5-651.63
  prod {{0xFD} {`%`_u32(167):Bu32}} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(I16_lanetype, `%`_dim(8)), EXTEND_vcvtop__(LOW_half, S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:652.5-652.64
  prod {{0xFD} {`%`_u32(168):Bu32}} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(I16_lanetype, `%`_dim(8)), EXTEND_vcvtop__(HIGH_half, S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:653.5-653.63
  prod {{0xFD} {`%`_u32(169):Bu32}} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(I16_lanetype, `%`_dim(8)), EXTEND_vcvtop__(LOW_half, U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:654.5-654.64
  prod {{0xFD} {`%`_u32(170):Bu32}} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(I16_lanetype, `%`_dim(8)), EXTEND_vcvtop__(HIGH_half, U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:658.5-658.45
  prod {{0xFD} {`%`_u32(171):Bu32}} => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), SHL_vshiftop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:659.5-659.49
  prod {{0xFD} {`%`_u32(172):Bu32}} => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), SHR_vshiftop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:660.5-660.49
  prod {{0xFD} {`%`_u32(173):Bu32}} => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), SHR_vshiftop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:664.5-664.43
  prod {{0xFD} {`%`_u32(174):Bu32}} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), ADD_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:665.5-665.43
  prod {{0xFD} {`%`_u32(177):Bu32}} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), SUB_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:666.5-666.43
  prod {{0xFD} {`%`_u32(181):Bu32}} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MUL_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:667.5-667.45
  prod {{0xFD} {`%`_u32(182):Bu32}} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MIN_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:668.5-668.45
  prod {{0xFD} {`%`_u32(183):Bu32}} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MIN_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:669.5-669.45
  prod {{0xFD} {`%`_u32(184):Bu32}} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MAX_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:670.5-670.45
  prod {{0xFD} {`%`_u32(185):Bu32}} => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MAX_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:674.5-674.59
  prod {{0xFD} {`%`_u32(186):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `DOTS`_vextbinop__)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:675.5-675.66
  prod {{0xFD} {`%`_u32(188):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), EXTMUL_vextbinop__(LOW_half, S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:676.5-676.67
  prod {{0xFD} {`%`_u32(189):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), EXTMUL_vextbinop__(HIGH_half, S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:677.5-677.66
  prod {{0xFD} {`%`_u32(190):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), EXTMUL_vextbinop__(LOW_half, U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:678.5-678.67
  prod {{0xFD} {`%`_u32(191):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), EXTMUL_vextbinop__(HIGH_half, U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:682.5-682.72
  prod {{0xFD} {`%`_u32(275):Bu32}} => VEXTTERNOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `RELAXED_DOT_ADDS`_vextternop__)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:686.5-686.42
  prod {{0xFD} {`%`_u32(192):Bu32}} => VUNOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), ABS_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:687.5-687.42
  prod {{0xFD} {`%`_u32(193):Bu32}} => VUNOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), NEG_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:691.5-691.49
  prod {{0xFD} {`%`_u32(195):Bu32}} => VTESTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), ALL_TRUE_vtestop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:695.5-695.41
  prod {{0xFD} {`%`_u32(196):Bu32}} => VBITMASK_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:699.5-699.63
  prod {{0xFD} {`%`_u32(199):Bu32}} => VCVTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), EXTEND_vcvtop__(LOW_half, S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:700.5-700.64
  prod {{0xFD} {`%`_u32(200):Bu32}} => VCVTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), EXTEND_vcvtop__(HIGH_half, S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:701.5-701.63
  prod {{0xFD} {`%`_u32(201):Bu32}} => VCVTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), EXTEND_vcvtop__(LOW_half, U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:702.5-702.64
  prod {{0xFD} {`%`_u32(202):Bu32}} => VCVTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), EXTEND_vcvtop__(HIGH_half, U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:706.5-706.45
  prod {{0xFD} {`%`_u32(203):Bu32}} => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), SHL_vshiftop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:707.5-707.49
  prod {{0xFD} {`%`_u32(204):Bu32}} => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), SHR_vshiftop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:708.5-708.49
  prod {{0xFD} {`%`_u32(205):Bu32}} => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), SHR_vshiftop_(U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:712.5-712.43
  prod {{0xFD} {`%`_u32(206):Bu32}} => VBINOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), ADD_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:713.5-713.43
  prod {{0xFD} {`%`_u32(209):Bu32}} => VBINOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), SUB_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:714.5-714.43
  prod {{0xFD} {`%`_u32(213):Bu32}} => VBINOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), MUL_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:718.5-718.42
  prod {{0xFD} {`%`_u32(214):Bu32}} => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), EQ_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:719.5-719.42
  prod {{0xFD} {`%`_u32(215):Bu32}} => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), NE_vrelop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:720.5-720.46
  prod {{0xFD} {`%`_u32(216):Bu32}} => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), LT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:721.5-721.46
  prod {{0xFD} {`%`_u32(217):Bu32}} => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), GT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:722.5-722.46
  prod {{0xFD} {`%`_u32(218):Bu32}} => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), LE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:723.5-723.46
  prod {{0xFD} {`%`_u32(219):Bu32}} => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), GE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:727.5-727.66
  prod {{0xFD} {`%`_u32(220):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), `%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), EXTMUL_vextbinop__(LOW_half, S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:728.5-728.67
  prod {{0xFD} {`%`_u32(221):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), `%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), EXTMUL_vextbinop__(HIGH_half, S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:729.5-729.66
  prod {{0xFD} {`%`_u32(222):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), `%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), EXTMUL_vextbinop__(LOW_half, U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:730.5-730.67
  prod {{0xFD} {`%`_u32(223):Bu32}} => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), `%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), EXTMUL_vextbinop__(HIGH_half, U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:734.5-734.43
  prod {{0xFD} {`%`_u32(103):Bu32}} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), CEIL_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:735.5-735.44
  prod {{0xFD} {`%`_u32(104):Bu32}} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), FLOOR_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:736.5-736.44
  prod {{0xFD} {`%`_u32(105):Bu32}} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), TRUNC_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:737.5-737.46
  prod {{0xFD} {`%`_u32(106):Bu32}} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), NEAREST_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:738.5-738.42
  prod {{0xFD} {`%`_u32(224):Bu32}} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), ABS_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:739.5-739.42
  prod {{0xFD} {`%`_u32(225):Bu32}} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), NEG_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:740.5-740.43
  prod {{0xFD} {`%`_u32(227):Bu32}} => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), SQRT_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:744.5-744.43
  prod {{0xFD} {`%`_u32(228):Bu32}} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), ADD_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:745.5-745.43
  prod {{0xFD} {`%`_u32(229):Bu32}} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), SUB_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:746.5-746.43
  prod {{0xFD} {`%`_u32(230):Bu32}} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), MUL_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:747.5-747.43
  prod {{0xFD} {`%`_u32(231):Bu32}} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), DIV_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:748.5-748.43
  prod {{0xFD} {`%`_u32(232):Bu32}} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), MIN_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:749.5-749.43
  prod {{0xFD} {`%`_u32(233):Bu32}} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), MAX_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:750.5-750.44
  prod {{0xFD} {`%`_u32(234):Bu32}} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), PMIN_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:751.5-751.44
  prod {{0xFD} {`%`_u32(235):Bu32}} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), PMAX_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:752.5-752.51
  prod {{0xFD} {`%`_u32(269):Bu32}} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_MIN_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:753.5-753.51
  prod {{0xFD} {`%`_u32(270):Bu32}} => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_MAX_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:757.5-757.53
  prod {{0xFD} {`%`_u32(261):Bu32}} => VTERNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_MADD_vternop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:758.5-758.54
  prod {{0xFD} {`%`_u32(262):Bu32}} => VTERNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_NMADD_vternop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:762.5-762.43
  prod {{0xFD} {`%`_u32(116):Bu32}} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), CEIL_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:763.5-763.44
  prod {{0xFD} {`%`_u32(117):Bu32}} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), FLOOR_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:764.5-764.44
  prod {{0xFD} {`%`_u32(122):Bu32}} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), TRUNC_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:765.5-765.46
  prod {{0xFD} {`%`_u32(148):Bu32}} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), NEAREST_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:766.5-766.42
  prod {{0xFD} {`%`_u32(236):Bu32}} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), ABS_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:767.5-767.42
  prod {{0xFD} {`%`_u32(237):Bu32}} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), NEG_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:768.5-768.43
  prod {{0xFD} {`%`_u32(239):Bu32}} => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), SQRT_vunop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:772.5-772.43
  prod {{0xFD} {`%`_u32(240):Bu32}} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), ADD_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:773.5-773.43
  prod {{0xFD} {`%`_u32(241):Bu32}} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), SUB_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:774.5-774.43
  prod {{0xFD} {`%`_u32(242):Bu32}} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), MUL_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:775.5-775.43
  prod {{0xFD} {`%`_u32(243):Bu32}} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), DIV_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:776.5-776.43
  prod {{0xFD} {`%`_u32(244):Bu32}} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), MIN_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:777.5-777.43
  prod {{0xFD} {`%`_u32(245):Bu32}} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), MAX_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:778.5-778.44
  prod {{0xFD} {`%`_u32(246):Bu32}} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), PMIN_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:779.5-779.44
  prod {{0xFD} {`%`_u32(247):Bu32}} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), PMAX_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:780.5-780.51
  prod {{0xFD} {`%`_u32(271):Bu32}} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_MIN_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:781.5-781.51
  prod {{0xFD} {`%`_u32(272):Bu32}} => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_MAX_vbinop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:785.5-785.53
  prod {{0xFD} {`%`_u32(263):Bu32}} => VTERNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_MADD_vternop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:786.5-786.54
  prod {{0xFD} {`%`_u32(264):Bu32}} => VTERNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_NMADD_vternop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:787.5-787.59
  prod {{0xFD} {`%`_u32(265):Bu32}} => VTERNOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), RELAXED_LANESELECT_vternop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:788.5-788.59
  prod {{0xFD} {`%`_u32(266):Bu32}} => VTERNOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), RELAXED_LANESELECT_vternop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:789.5-789.59
  prod {{0xFD} {`%`_u32(267):Bu32}} => VTERNOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), RELAXED_LANESELECT_vternop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:790.5-790.59
  prod {{0xFD} {`%`_u32(268):Bu32}} => VTERNOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), RELAXED_LANESELECT_vternop_)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:794.5-794.61
  prod {{0xFD} {`%`_u32(94):Bu32}} => VCVTOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), DEMOTE_vcvtop__(ZERO_zero))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:795.5-795.61
  prod {{0xFD} {`%`_u32(95):Bu32}} => VCVTOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), `%X%`_shape(F32_lanetype, `%`_dim(4)), `PROMOTELOW`_vcvtop__)
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:796.5-796.62
  prod {{0xFD} {`%`_u32(248):Bu32}} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F32_lanetype, `%`_dim(4)), TRUNC_SAT_vcvtop__(S_sx, ?()))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:797.5-797.62
  prod {{0xFD} {`%`_u32(249):Bu32}} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F32_lanetype, `%`_dim(4)), TRUNC_SAT_vcvtop__(U_sx, ?()))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:798.5-798.60
  prod {{0xFD} {`%`_u32(250):Bu32}} => VCVTOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), `%X%`_shape(I32_lanetype, `%`_dim(4)), CONVERT_vcvtop__(?(), S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:799.5-799.60
  prod {{0xFD} {`%`_u32(251):Bu32}} => VCVTOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), `%X%`_shape(I32_lanetype, `%`_dim(4)), CONVERT_vcvtop__(?(), U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:800.5-800.67
  prod {{0xFD} {`%`_u32(252):Bu32}} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), TRUNC_SAT_vcvtop__(S_sx, ?(ZERO_zero)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:801.5-801.67
  prod {{0xFD} {`%`_u32(253):Bu32}} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), TRUNC_SAT_vcvtop__(U_sx, ?(ZERO_zero)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:802.5-802.64
  prod {{0xFD} {`%`_u32(254):Bu32}} => VCVTOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), CONVERT_vcvtop__(?(LOW_half), S_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:803.5-803.64
  prod {{0xFD} {`%`_u32(255):Bu32}} => VCVTOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), CONVERT_vcvtop__(?(LOW_half), U_sx))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:804.5-804.66
  prod {{0xFD} {`%`_u32(257):Bu32}} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_TRUNC_vcvtop__(S_sx, ?()))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:805.5-805.66
  prod {{0xFD} {`%`_u32(258):Bu32}} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_TRUNC_vcvtop__(U_sx, ?()))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:806.5-806.71
  prod {{0xFD} {`%`_u32(259):Bu32}} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_TRUNC_vcvtop__(S_sx, ?(ZERO_zero)))
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec:807.5-807.71
  prod {{0xFD} {`%`_u32(260):Bu32}} => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_TRUNC_vcvtop__(U_sx, ?(ZERO_zero)))
}

;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
grammar Bexpr : expr
  ;; ../../../../specification/wasm-3.0/5.3-binary.instructions.spectec
  prod{`in*` : instr*} {{in:Binstr*{in <- `in*`}} {0x0B}} => in*{in <- `in*`}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bsection_(N : N, syntax en, grammar BX : en*) : en*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{len : nat, `en*` : en*} {{`%`_byte(N):Bbyte} {`%`_u32(len):Bu32} {en*{en <- `en*`}:BX}} => en*{en <- `en*`}
    -- if (len = 0)
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod eps => []

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bcustom : ()*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod {{Bname} {Bbyte*{}}} => [()]

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bcustomsec : ()
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod Bsection_(0, syntax (), grammar Bcustom) => ()

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Btype : type
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{qt : rectype} qt:Brectype => TYPE_type(qt)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Btypesec : type*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`ty*` : type*} ty*{ty <- `ty*`}:Bsection_(1, syntax type, grammar Blist(syntax type, grammar Btype)) => ty*{ty <- `ty*`}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bimport : import
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{nm_1 : name, nm_2 : name, xt : externtype} {{nm_1:Bname} {nm_2:Bname} {xt:Bexterntype}} => IMPORT_import(nm_1, nm_2, xt)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bimportsec : import*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`im*` : import*} im*{im <- `im*`}:Bsection_(2, syntax import, grammar Blist(syntax import, grammar Bimport)) => im*{im <- `im*`}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bfuncsec : typeidx*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`x*` : idx*} x*{x <- `x*`}:Bsection_(3, syntax typeidx, grammar Blist(syntax typeidx, grammar Btypeidx)) => x*{x <- `x*`}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Btable : table
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{tt : tabletype, ht : heaptype, at : addrtype, lim : limits} tt:Btabletype => TABLE_table(tt, [REF.NULL_instr(ht)])
    -- if (tt = `%%%`_tabletype(at, lim, REF_reftype(NULL_null?{}, ht)))
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{tt : tabletype, e : expr} {{0x40} {0x00} {tt:Btabletype} {e:Bexpr}} => TABLE_table(tt, e)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Btablesec : table*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`tab*` : table*} tab*{tab <- `tab*`}:Bsection_(4, syntax table, grammar Blist(syntax table, grammar Btable)) => tab*{tab <- `tab*`}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bmem : mem
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{mt : memtype} mt:Bmemtype => MEMORY_mem(mt)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bmemsec : mem*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`mem*` : mem*} mem*{mem <- `mem*`}:Bsection_(5, syntax mem, grammar Blist(syntax mem, grammar Bmem)) => mem*{mem <- `mem*`}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bglobal : global
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{gt : globaltype, e : expr} {{gt:Bglobaltype} {e:Bexpr}} => GLOBAL_global(gt, e)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bglobalsec : global*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`glob*` : global*} glob*{glob <- `glob*`}:Bsection_(6, syntax global, grammar Blist(syntax global, grammar Bglobal)) => glob*{glob <- `glob*`}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bexport : export
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{nm : name, xx : externidx} {{nm:Bname} {xx:Bexternidx}} => EXPORT_export(nm, xx)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bexportsec : export*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`ex*` : export*} ex*{ex <- `ex*`}:Bsection_(7, syntax export, grammar Blist(syntax export, grammar Bexport)) => ex*{ex <- `ex*`}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bstart : start*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{x : idx} x:Bfuncidx => [START_start(x)]

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
syntax startopt = start*

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bstartsec : start?
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{startopt : startopt} startopt:Bsection_(8, syntax start, grammar Bstart) => $opt_(syntax start, startopt)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Belemkind : reftype
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod 0x00 => REF_reftype(?(NULL_null), FUNC_heaptype)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Belem : elem
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{e_o : expr, `y*` : idx*} {{`%`_u32(0):Bu32} {e_o:Bexpr} {y*{y <- `y*`}:Blist(syntax funcidx, grammar Bfuncidx)}} => ELEM_elem(REF_reftype(?(), FUNC_heaptype), [REF.FUNC_instr(y)*{y <- `y*`}], ACTIVE_elemmode(`%`_tableidx(0), e_o))
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{rt : reftype, `y*` : idx*} {{`%`_u32(1):Bu32} {rt:Belemkind} {y*{y <- `y*`}:Blist(syntax funcidx, grammar Bfuncidx)}} => ELEM_elem(rt, [REF.FUNC_instr(y)*{y <- `y*`}], PASSIVE_elemmode)
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{x : idx, e : expr, rt : reftype, `y*` : idx*} {{`%`_u32(2):Bu32} {x:Btableidx} {e:Bexpr} {rt:Belemkind} {y*{y <- `y*`}:Blist(syntax funcidx, grammar Bfuncidx)}} => ELEM_elem(rt, [REF.FUNC_instr(y)*{y <- `y*`}], ACTIVE_elemmode(x, e))
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{rt : reftype, `y*` : idx*} {{`%`_u32(3):Bu32} {rt:Belemkind} {y*{y <- `y*`}:Blist(syntax funcidx, grammar Bfuncidx)}} => ELEM_elem(rt, [REF.FUNC_instr(y)*{y <- `y*`}], DECLARE_elemmode)
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{e_O : expr, `e*` : expr*} {{`%`_u32(4):Bu32} {e_O:Bexpr} {e*{e <- `e*`}:Blist(syntax expr, grammar Bexpr)}} => ELEM_elem(REF_reftype(?(NULL_null), FUNC_heaptype), e*{e <- `e*`}, ACTIVE_elemmode(`%`_tableidx(0), e_O))
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{rt : reftype, `e*` : expr*} {{`%`_u32(5):Bu32} {rt:Breftype} {e*{e <- `e*`}:Blist(syntax expr, grammar Bexpr)}} => ELEM_elem(rt, e*{e <- `e*`}, PASSIVE_elemmode)
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{x : idx, e_O : expr, `e*` : expr*} {{`%`_u32(6):Bu32} {x:Btableidx} {e_O:Bexpr} {e*{e <- `e*`}:Blist(syntax expr, grammar Bexpr)}} => ELEM_elem(REF_reftype(?(NULL_null), FUNC_heaptype), e*{e <- `e*`}, ACTIVE_elemmode(x, e_O))
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{rt : reftype, `e*` : expr*} {{`%`_u32(7):Bu32} {rt:Breftype} {e*{e <- `e*`}:Blist(syntax expr, grammar Bexpr)}} => ELEM_elem(rt, e*{e <- `e*`}, DECLARE_elemmode)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Belemsec : elem*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`elem*` : elem*} elem*{elem <- `elem*`}:Bsection_(9, syntax elem, grammar Blist(syntax elem, grammar Belem)) => elem*{elem <- `elem*`}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
syntax code = (local*, expr)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Blocals : local*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{n : n, t : valtype} {{`%`_u32(n):Bu32} {t:Bvaltype}} => LOCAL_local(t)^n{}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bfunc : code
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`loc**` : local**, e : expr} {{loc*{loc <- `loc*`}*{`loc*` <- `loc**`}:Blist(syntax local*, grammar Blocals)} {e:Bexpr}} => ($concat_(syntax local, loc*{loc <- `loc*`}*{`loc*` <- `loc**`}), e)
    -- if (|$concat_(syntax local, loc*{loc <- `loc*`}*{`loc*` <- `loc**`})| < (2 ^ 32))

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bcode : code
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{len : nat, code : code} {{`%`_u32(len):Bu32} {code:Bfunc}} => code
    -- if (len = 0)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bcodesec : code*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`code*` : code*} code*{code <- `code*`}:Bsection_(10, syntax code, grammar Blist(syntax code, grammar Bcode)) => code*{code <- `code*`}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bdata : data
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{e : expr, `b*` : byte*} {{`%`_u32(0):Bu32} {e:Bexpr} {b*{b <- `b*`}:Blist(syntax byte, grammar Bbyte)}} => DATA_data(b*{b <- `b*`}, ACTIVE_datamode(`%`_memidx(0), e))
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`b*` : byte*} {{`%`_u32(1):Bu32} {b*{b <- `b*`}:Blist(syntax byte, grammar Bbyte)}} => DATA_data(b*{b <- `b*`}, PASSIVE_datamode)
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{x : idx, e : expr, `b*` : byte*} {{`%`_u32(2):Bu32} {x:Bmemidx} {e:Bexpr} {b*{b <- `b*`}:Blist(syntax byte, grammar Bbyte)}} => DATA_data(b*{b <- `b*`}, ACTIVE_datamode(x, e))

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bdatasec : data*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`data*` : data*} data*{data <- `data*`}:Bsection_(11, syntax data, grammar Blist(syntax data, grammar Bdata)) => data*{data <- `data*`}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bdatacnt : u32*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{n : n} `%`_u32(n):Bu32 => [`%`_u32(n)]

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
syntax nopt = u32*

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bdatacntsec : u32?
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{nopt : nopt} nopt:Bsection_(12, syntax u32, grammar Bdatacnt) => $opt_(syntax u32, nopt)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Btag : tag
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{jt : tagtype} jt:Btagtype => TAG_tag(jt)

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Btagsec : tag*
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`tag*` : tag*} tag*{tag <- `tag*`}:Bsection_(13, syntax tag, grammar Blist(syntax tag, grammar Btag)) => tag*{tag <- `tag*`}

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bmagic : ()
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod {{0x00} {0x61} {0x73} {0x6D}} => ()

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bversion : ()
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod {{0x01} {0x00} {0x00} {0x00}} => ()

;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
grammar Bmodule : module
  ;; ../../../../specification/wasm-3.0/5.4-binary.modules.spectec
  prod{`type*` : type*, `import*` : import*, `typeidx*` : typeidx*, `table*` : table*, `mem*` : mem*, `tag*` : tag*, `global*` : global*, `export*` : export*, `start?` : start?, `elem*` : elem*, `n?` : n?, `local**` : local**, `expr*` : expr*, `data*` : data*, `func*` : func*} {{Bmagic} {Bversion} {Bcustomsec*{}} {type*{type <- `type*`}:Btypesec} {Bcustomsec*{}} {import*{import <- `import*`}:Bimportsec} {Bcustomsec*{}} {typeidx*{typeidx <- `typeidx*`}:Bfuncsec} {Bcustomsec*{}} {table*{table <- `table*`}:Btablesec} {Bcustomsec*{}} {mem*{mem <- `mem*`}:Bmemsec} {Bcustomsec*{}} {tag*{tag <- `tag*`}:Btagsec} {Bcustomsec*{}} {global*{global <- `global*`}:Bglobalsec} {Bcustomsec*{}} {export*{export <- `export*`}:Bexportsec} {Bcustomsec*{}} {start?{start <- `start?`}:Bstartsec} {Bcustomsec*{}} {elem*{elem <- `elem*`}:Belemsec} {Bcustomsec*{}} {`%`_u32(n)?{n <- `n?`}:Bdatacntsec} {Bcustomsec*{}} {(local*{local <- `local*`}, expr)*{expr <- `expr*`, `local*` <- `local**`}:Bcodesec} {Bcustomsec*{}} {data*{data <- `data*`}:Bdatasec} {Bcustomsec*{}}} => MODULE_module(type*{type <- `type*`}, import*{import <- `import*`}, tag*{tag <- `tag*`}, global*{global <- `global*`}, mem*{mem <- `mem*`}, table*{table <- `table*`}, func*{func <- `func*`}, data*{data <- `data*`}, elem*{elem <- `elem*`}, start?{start <- `start?`}, export*{export <- `export*`})
    -- (if (n = |data*{data <- `data*`}|))?{n <- `n?`}
    -- if ((n?{n <- `n?`} =/= ?()) \/ ($dataidx_funcs(func*{func <- `func*`}) = []))
    -- (if (func = FUNC_func(typeidx, local*{local <- `local*`}, expr)))*{expr <- `expr*`, func <- `func*`, `local*` <- `local**`, typeidx <- `typeidx*`}

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar Tchar : char
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:(0x00 | ... | 0xD7FF) => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:(0xE000 | ... | 0x10FFFF) => `%`_char(`<implicit-prod-result>`)

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar Tsource : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : char} [`<implicit-prod-result>`]:Tchar*{} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar TuNplain : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:eps => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar TsNplain : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:eps => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar TfNplain : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:eps => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tidchar : char
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:(0x30 | ... | 0x39) => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:(0x41 | ... | 0x5A) => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:(0x61 | ... | 0x7A) => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x21 => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x23 => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x24 => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x25 => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x26 => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x27 => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x2A => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x2B => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x2D => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x2E => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x2F => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x3A => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x3C => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x3D => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x3E => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x3F => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x40 => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x5C => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x5E => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x5F => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x60 => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x7C => `%`_char(`<implicit-prod-result>`)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x7E => `%`_char(`<implicit-prod-result>`)

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tdigit : nat
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x30 => 0
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x31 => 1
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x32 => 2
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x33 => 3
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x34 => 4
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x35 => 5
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x36 => 6
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x37 => 7
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x38 => 8
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x39 => 9

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Thexdigit : nat
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{d : nat} d:Tdigit => d
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x41 => 10
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x42 => 11
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x43 => 12
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x44 => 13
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x45 => 14
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x46 => 15
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x61 => 10
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x62 => 11
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x63 => 12
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x64 => 13
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x65 => 14
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod 0x66 => 15

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
rec {

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:22.1-24.46
grammar Thexnum : nat
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:23.5-23.21
  prod{h : nat} h:Thexdigit => h
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:24.5-24.46
  prod{n : n, h : nat} {{n:Thexnum} {"_"?{}} {h:Thexdigit}} => ((16 * n) + h)
}

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tstringchar : char
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{c : char} c:Tchar => c
    -- if ((((c!`%`_char.0 >= 32) /\ (c!`%`_char.0 =/= 127)) /\ (c =/= `%`_char(34))) /\ (c =/= `%`_char(92)))
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod "\\t" => `%`_char(9)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod "\\n" => `%`_char(10)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod "\\r" => `%`_char(13)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod "\\\"" => `%`_char(34)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod "\\'" => `%`_char(39)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod "\\\\" => `%`_char(92)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{n : n} {{"\\u{"} {n:Thexnum} {"}"}} => `%`_char(n)
    -- if ((n < 55296) \/ ((59392 <= n) /\ (n < 1114112)))

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tstringelem : byte*
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{c : char} c:Tstringchar => $utf8([c])
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{h_1 : nat, h_2 : nat} {{"\\"} {h_1:Thexdigit} {h_2:Thexdigit}} => [`%`_byte(((16 * h_1) + h_2))]

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tstring : byte*
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`b**` : byte**} {{"\""} {b*{b <- `b*`}:Tstringelem*{`b*` <- `b**`}} {"\""}} => $concat_(syntax byte, b*{b <- `b*`}*{`b*` <- `b**`})
    -- if (|$concat_(syntax byte, b*{b <- `b*`}*{`b*` <- `b**`})| < (2 ^ 32))

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tname : name
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`b*` : byte*, `c*` : char*} b*{b <- `b*`}:Tstring => `%`_name(c*{c <- `c*`})
    -- if (b*{b <- `b*`} = $utf8(c*{c <- `c*`}))

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tid : name
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`c*` : char*} {{"$"} {c*{c <- `c*`}:Tidchar+{}}} => `%`_name(c*{c <- `c*`})
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`c*` : char*} {{"$"} {`%`_name(c*{c <- `c*`}):Tname}} => `%`_name(c*{c <- `c*`})
    -- if (|c*{c <- `c*`}| > 0)

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar Tkeyword : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{(0x61 | ... | 0x7A)} {Tidchar*{}}} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar Treserved : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} [`<implicit-prod-result>`]:({Tidchar} | {Tstring} | {","} | {";"} | {"["} | {"]"} | {"{"} | {"}"})+{} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar Ttoken : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:Tkeyword => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:TuNplain => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:TsNplain => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:TfNplain => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : byte} [`<implicit-prod-result>`]:Tstring => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : name} `<implicit-prod-result>`:Tid => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x28 => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x29 => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:Treserved => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar Tannotid : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : char} [`<implicit-prod-result>`]:Tidchar+{} => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : name} `<implicit-prod-result>`:Tname => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
rec {

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec:56.1-57.26
grammar Tblockcomment : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec:57.5-57.26
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{"(;"} {Tblockchar*{}} {";)"}} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec:60.1-64.18
grammar Tblockchar : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec:61.5-61.47
  prod{`<implicit-prod-result>` : char, c : char} `<implicit-prod-result>`:c:Tchar => (`<implicit-prod-result>`, ()).1
    -- if ((c =/= `%`_char(59)) /\ (c =/= `%`_char(40)))
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec:62.5-62.47
  prod{`<implicit-prod-result>` : (), c : char} `<implicit-prod-result>`:{{";"+{}} {c:Tchar}} => (`<implicit-prod-result>`, ()).1
    -- if ((c =/= `%`_char(59)) /\ (c =/= `%`_char(41)))
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec:63.5-63.47
  prod{`<implicit-prod-result>` : (), c : char} `<implicit-prod-result>`:{{"("+{}} {c:Tchar}} => (`<implicit-prod-result>`, ()).1
    -- if ((c =/= `%`_char(59)) /\ (c =/= `%`_char(40)))
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec:64.5-64.18
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:Tblockcomment => (`<implicit-prod-result>`, ()).1
}

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar Teof : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : text} `<implicit-prod-result>`:"" => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar Tlinechar : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : char, c : char} `<implicit-prod-result>`:c:Tchar => (`<implicit-prod-result>`, ()).1
    -- if ((c!`%`_char.0 =/= 10) /\ (c!`%`_char.0 =/= 13))

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar Tnewline : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x0A => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x0D => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{0x0D} {0x0A}} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar Tlinecomment : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{";;"} {Tlinechar*{}} (Tnewline | Teof)} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar Tcomment : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:Tlinecomment => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:Tblockcomment => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
grammar Tformat : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:Tnewline => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
  prod{`<implicit-prod-result>` : nat} `<implicit-prod-result>`:0x09 => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec
rec {

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec:32.1-33.41
grammar Tspace : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec:33.5-33.41
  prod{`<implicit-prod-result>` : ()} [`<implicit-prod-result>`]:({" "} | Tformat | Tcomment | Tannot)*{} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec:69.1-70.41
grammar Tannot : ()
  ;; ../../../../specification/wasm-3.0/6.0-text.lexical.spectec:70.5-70.41
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{"(@"} Tannotid {(Tspace | Ttoken)*{}} {")"}} => (`<implicit-prod-result>`, ()).1
}

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tsign : int
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod eps => + (1 : nat <:> int)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod "+" => + (1 : nat <:> int)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod "-" => - (1 : nat <:> int)

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
rec {

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:18.1-20.40
grammar Tnum : nat
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:19.5-19.18
  prod{d : nat} d:Tdigit => d
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:20.5-20.40
  prod{n : n, d : nat} {{n:Tnum} {"_"?{}} {d:Tdigit}} => ((10 * n) + d)
}

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar TuN(N : N) : uN(N)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{n : n} n:Tnum => `%`_uN(n)
    -- if (n < (2 ^ N))
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{n : n} {{"0x"} {n:Thexnum}} => `%`_uN(n)
    -- if (n < (2 ^ N))

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar TsN(N : N) : sN(N)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{s : int, n : n} {{s:Tsign} {`%`_uN(n):TuN(N)}} => `%`_sN((s * (n : nat <:> int)))
    -- if ((- ((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int) <= (s * (n : nat <:> int))) /\ ((s * (n : nat <:> int)) < ((2 ^ (((N : nat <:> int) - (1 : nat <:> int)) : int <:> nat)) : nat <:> int)))

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar TiN(N : N) : iN(N)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{n : n} `%`_uN(n):TuN(N) => `%`_iN(n)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{i : sN(N)} i:TsN(N) => `%`_iN($inv_signed_(N, i!`%`_sN.0))

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
rec {

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:38.1-40.48
grammar Tfrac : rat
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:39.5-39.26
  prod{d : nat} d:Tdigit => ((d : nat <:> rat) / (10 : nat <:> rat))
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:40.5-40.48
  prod{d : nat, p : rat} {{d:Tdigit} {"_"?{}} {p:Tfrac}} => (((d + ((p / (10 : nat <:> rat)) : rat <:> nat)) : nat <:> rat) / (10 : nat <:> rat))
}

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
rec {

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:42.1-44.54
grammar Thexfrac : rat
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:43.5-43.29
  prod{h : nat} h:Thexdigit => ((h : nat <:> rat) / (16 : nat <:> rat))
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:44.5-44.54
  prod{h : nat, p : rat} {{h:Thexdigit} {"_"?{}} {p:Thexfrac}} => (((h + ((p / (16 : nat <:> rat)) : rat <:> nat)) : nat <:> rat) / (16 : nat <:> rat))
}

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tmant : rat
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{p : nat} {{p:Tnum} {"."?{}}} => (p : nat <:> rat)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{p : nat, q : rat} {{p:Tnum} {"."} {q:Tfrac}} => ((p + (q : rat <:> nat)) : nat <:> rat)

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Thexmant : rat
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{p : nat} {{p:Thexnum} {"."?{}}} => (p : nat <:> rat)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{p : nat, q : rat} {{p:Thexnum} {"."} {q:Thexfrac}} => ((p + (q : rat <:> nat)) : nat <:> rat)

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
def $ieee_(N : N, rat : rat) : fNmag(N)

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tfloat : rat
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{p : rat, s : int, ee : nat} {{p:Tmant} ({"E"} | {"e"}) {s:Tsign} {ee:Tnum}} => (p * ((10 ^ ((s * (ee : nat <:> int)) : int <:> nat)) : nat <:> rat))

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Thexfloat : rat
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{p : rat, s : int, ee : nat} {{"0x"} {p:Thexmant} ({"P"} | {"p"}) {s:Tsign} {ee:Tnum}} => (p * ((2 ^ ((s * (ee : nat <:> int)) : int <:> nat)) : nat <:> rat))

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar TfNmag(N : N) : fNmag(N)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{q : rat} q:Tfloat => $ieee_(N, q)
    -- if ($ieee_(N, q) =/= INF_fNmag)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{q : rat} q:Thexfloat => $ieee_(N, q)
    -- if ($ieee_(N, q) =/= INF_fNmag)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod "inf" => INF_fNmag
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod "nan" => NAN_fNmag($canon_(N))
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{n : n} {{"nan:0x"} {n:Thexnum}} => NAN_fNmag(n)
    -- if ((1 <= n) /\ (n < (2 ^ $signif(N))))

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar TfN(N : N) : fN(N)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{q : fNmag(N)} {{+ (1 : nat <:> int):Tsign} {q:TfNmag(N)}} => POS_fN(q)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{q : fNmag(N)} {{- (1 : nat <:> int):Tsign} {q:TfNmag(N)}} => NEG_fN(q)

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tu8 : u8
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : uN(8)} `<implicit-prod-result>`:TuN(8) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tu32 : u32
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : uN(32)} `<implicit-prod-result>`:TuN(32) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tu64 : u64
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : uN(64)} `<implicit-prod-result>`:TuN(64) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Ti8 : u8
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : iN(8)} `<implicit-prod-result>`:TiN(8) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Ti16 : u16
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : iN(16)} `<implicit-prod-result>`:TiN(16) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Ti32 : u32
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : iN(32)} `<implicit-prod-result>`:TiN(32) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Ti64 : u64
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : iN(64)} `<implicit-prod-result>`:TiN(64) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tf32 : f32
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : fN(32)} `<implicit-prod-result>`:TfN(32) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tf64 : f64
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : fN(64)} `<implicit-prod-result>`:TfN(64) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tlist(syntax el, grammar TX : el) : el*
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`el*` : el*} el:TX*{el <- `el*`} => el*{el <- `el*`}
    -- if (|el*{el <- `el*`}| < (2 ^ 32))

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
syntax idctxt = 
{
  TYPES{`name?*` : name?*} name?*,
  TAGS{`name?*` : name?*} name?*,
  GLOBALS{`name?*` : name?*} name?*,
  MEMS{`name?*` : name?*} name?*,
  TABLES{`name?*` : name?*} name?*,
  FUNCS{`name?*` : name?*} name?*,
  DATAS{`name?*` : name?*} name?*,
  ELEMS{`name?*` : name?*} name?*,
  LOCALS{`name?*` : name?*} name?*,
  LABELS{`name?*` : name?*} name?*,
  FIELDS{`name?**` : name?**} name?**,
  TYPEDEFS{`deftype?*` : deftype?*} deftype?*
}

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
syntax I = idctxt

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
rec {

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:154.1-154.56
def $concat_idctxt(idctxt*) : idctxt
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:155.1-155.29
  def $concat_idctxt([]) = {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []}
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec:156.1-156.52
  def $concat_idctxt{I : I, I' : I}([I I']) = I +++ $concat_idctxt(I'*{})
}

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
relation Idctxt_ok: `|-%:OK`(idctxt)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  rule _{I : I, `field**` : char**}:
    `|-%:OK`(I)
    -- if $disjoint_(syntax name, $concatopt_(syntax name, I.TYPES_I))
    -- if $disjoint_(syntax name, $concatopt_(syntax name, I.TAGS_I))
    -- if $disjoint_(syntax name, $concatopt_(syntax name, I.GLOBALS_I))
    -- if $disjoint_(syntax name, $concatopt_(syntax name, I.MEMS_I))
    -- if $disjoint_(syntax name, $concatopt_(syntax name, I.TABLES_I))
    -- if $disjoint_(syntax name, $concatopt_(syntax name, I.FUNCS_I))
    -- if $disjoint_(syntax name, $concatopt_(syntax name, I.DATAS_I))
    -- if $disjoint_(syntax name, $concatopt_(syntax name, I.ELEMS_I))
    -- if $disjoint_(syntax name, $concatopt_(syntax name, I.LOCALS_I))
    -- if $disjoint_(syntax name, $concatopt_(syntax name, I.LABELS_I))
    -- (if $disjoint_(syntax name, $concatopt_(syntax name, [?(`%`_name(field*{field <- `field*`}))])))*{`field*` <- `field**`}
    -- if ([?(`%`_name(field*{field <- `field*`}))*{`field*` <- `field**`}] = I.FIELDS_I)

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tidx_(ids : name?*) : idx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{x : idx} x:Tu32 => x
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{id : name, x : idx} id:Tid => x
    -- if (ids[x!`%`_idx.0] = ?(id))

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Ttypeidx_(I : I) : typeidx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : idx} `<implicit-prod-result>`:Tidx_(I.TYPES_I) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Ttagidx_(I : I) : tagidx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : idx} `<implicit-prod-result>`:Tidx_(I.TAGS_I) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tglobalidx_(I : I) : globalidx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : idx} `<implicit-prod-result>`:Tidx_(I.GLOBALS_I) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tmemidx_(I : I) : memidx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : idx} `<implicit-prod-result>`:Tidx_(I.MEMS_I) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Ttableidx_(I : I) : tableidx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : idx} `<implicit-prod-result>`:Tidx_(I.TABLES_I) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tfuncidx_(I : I) : funcidx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : idx} `<implicit-prod-result>`:Tidx_(I.FUNCS_I) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tdataidx_(I : I) : dataidx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : idx} `<implicit-prod-result>`:Tidx_(I.DATAS_I) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Telemidx_(I : I) : elemidx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : idx} `<implicit-prod-result>`:Tidx_(I.ELEMS_I) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tlocalidx_(I : I) : localidx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : idx} `<implicit-prod-result>`:Tidx_(I.LOCALS_I) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tlabelidx_(I : I) : labelidx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : idx} `<implicit-prod-result>`:Tidx_(I.LABELS_I) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Tfieldidx__(I : I, x : idx) : fieldidx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{`<implicit-prod-result>` : idx} `<implicit-prod-result>`:Tidx_(I.FIELDS_I[x!`%`_idx.0]) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
grammar Texternidx_(I : I) : externidx
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{x : idx} {{"("} {"tag"} {x:Ttagidx_(I)} {")"}} => TAG_externidx(x)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{x : idx} {{"("} {"global"} {x:Tglobalidx_(I)} {")"}} => GLOBAL_externidx(x)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{x : idx} {{"("} {"memory"} {x:Tmemidx_(I)} {")"}} => MEM_externidx(x)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{x : idx} {{"("} {"table"} {x:Ttableidx_(I)} {")"}} => TABLE_externidx(x)
  ;; ../../../../specification/wasm-3.0/6.1-text.values.spectec
  prod{x : idx} {{"("} {"func"} {x:Tfuncidx_(I)} {")"}} => FUNC_externidx(x)

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tnumtype : numtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "i32" => I32_numtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "i64" => I64_numtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "f32" => F32_numtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "f64" => F64_numtype

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tvectype : vectype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "v128" => V128_vectype

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tabsheaptype : heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "any" => ANY_heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "eq" => EQ_heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "i31" => I31_heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "struct" => STRUCT_heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "array" => ARRAY_heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "none" => NONE_heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "func" => FUNC_heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "nofunc" => NOFUNC_heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "exn" => EXN_heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "noexn" => NOEXN_heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "extern" => EXTERN_heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "noextern" => NOEXTERN_heaptype

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Theaptype_(I : I) : heaptype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{ht : heaptype} ht:Tabsheaptype => ht
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{x : idx} x:Ttypeidx_(I) => _IDX_heaptype(x)

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tnull : null
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "null" => NULL_null

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Treftype_(I : I) : reftype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`null?` : null?, ht : heaptype} {{"("} {"ref"} {null?{null <- `null?`}:Tnull?{}} {ht:Theaptype_(I)} {")"}} => REF_reftype(null?{null <- `null?`}, ht)

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tvaltype_(I : I) : valtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{nt : numtype} nt:Tnumtype => (nt : numtype <: valtype)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{vt : vectype} vt:Tvectype => (vt : vectype <: valtype)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{rt : reftype} rt:Treftype_(I) => (rt : reftype <: valtype)

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tpacktype : packtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "i8" => I8_packtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "i16" => I16_packtype

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tstoragetype_(I : I) : storagetype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{t : valtype} t:Tvaltype_(I) => (t : valtype <: storagetype)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{pt : packtype} pt:Tpacktype => (pt : packtype <: storagetype)

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tfieldtype_(I : I) : fieldtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{zt : storagetype} zt:Tstoragetype_(I) => `%%`_fieldtype(?(), zt)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{zt : storagetype} {{"("} {"mut"} {zt:Tstoragetype_(I)} {")"}} => `%%`_fieldtype(?(MUT_mut), zt)

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tfield_(I : I) : (fieldtype, name?)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`id?` : char?, ft : fieldtype} {{"("} {"field"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {ft:Tfieldtype_(I)} {")"}} => (ft, ?(`%`_name(lift(id?{id <- `id?`}))))

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tparam_(I : I) : (valtype, name?)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`id?` : char?, t : valtype} {{"("} {"param"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {t:Tvaltype_(I)} {")"}} => (t, ?(`%`_name(lift(id?{id <- `id?`}))))

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tresult_(I : I) : valtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{t : valtype} {{"("} {"result"} {t:Tvaltype_(I)} {")"}} => t

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tcomptype_(I : I) : (comptype, idctxt)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`ft*` : fieldtype*, `id?*` : char?*} {{"("} {"struct"} {(ft, ?(`%`_name(lift(id?{id <- `id?`}))))*{ft <- `ft*`, `id?` <- `id?*`}:Tlist(syntax (fieldtype, name?), grammar Tfield_(I))} {")"}} => (STRUCT_comptype(`%`_list(ft*{ft <- `ft*`})), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [?(`%`_name(lift(id?{id <- `id?`})))*{`id?` <- `id?*`}], TYPEDEFS []})
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{ft : fieldtype} {{"("} {"array"} {ft:Tfieldtype_(I)} {")"}} => (ARRAY_comptype(ft), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`t_1*` : valtype*, `id?*` : char?*, `t_2*` : valtype*} {{"("} {"func"} {(t_1, ?(`%`_name(lift(id?{id <- `id?`}))))*{`id?` <- `id?*`, t_1 <- `t_1*`}:Tlist(syntax (valtype, name?), grammar Tparam_(I))} {t_2*{t_2 <- `t_2*`}:Tlist(syntax valtype, grammar Tresult_(I))} {")"}} => (`FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`})), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tfinal : final
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "final" => FINAL_final

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tsubtype_(I : I) : (subtype, idctxt)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`fin?` : final?, `x*` : idx*, ct : comptype, I' : I} {{"("} {"sub"} {fin?{fin <- `fin?`}:Tfinal?{}} {x*{x <- `x*`}:Tlist(syntax typeidx, grammar Ttypeidx_(I))} {(ct, I'):Tcomptype_(I)} {")"}} => (SUB_subtype(fin?{fin <- `fin?`}, _IDX_typeuse(x)*{x <- `x*`}, ct), I')

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Ttypedef_(I : I) : (subtype, idctxt)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`id?` : char?, st : subtype, I' : I} {{"("} {"type"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {(st, I'):Tsubtype_(I)} {")"}} => (st, I' +++ {TYPES [?(`%`_name(lift(id?{id <- `id?`})))], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Trectype_(I : I) : (rectype, idctxt)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`st*` : subtype*, `I'*` : I*} {{"("} {"rec"} {(st, I')*{I' <- `I'*`, st <- `st*`}:Tlist(syntax (subtype, idctxt), grammar Ttypedef_(I))} {")"}} => (REC_rectype(`%`_list(st*{st <- `st*`})), $concat_idctxt(I'*{I' <- `I'*`}))

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Taddrtype : addrtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "i32" => I32_addrtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod "i64" => I64_addrtype

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tlimits : limits
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{n : n} `%`_u64(n):Tu64 => `[%..%]`_limits(`%`_u64(n), ?())
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{n : n, m : m} {{`%`_u64(n):Tu64} {`%`_u64(m):Tu64}} => `[%..%]`_limits(`%`_u64(n), ?(`%`_u64(m)))

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Ttypeuse_(I : I) : (typeidx, idctxt)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{x : idx, I' : I, `st*` : subtype*, i : n, `t_1*` : valtype*, `t_2*` : valtype*} {{"("} {"type"} {x:Ttypeidx_(I)} {")"}} => (x, I')
    -- if (I.TYPEDEFS_I[x!`%`_idx.0] = ?(_DEF_deftype(REC_rectype(`%`_list(st*{st <- `st*`})), i)))
    -- if (st*{st <- `st*`}[i] = SUB_subtype(?(FINAL_final), [], `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))))
    -- if (I' = {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS ?(`%`_name([]))^|t_1*{t_1 <- `t_1*`}|{}, LABELS [], FIELDS [], TYPEDEFS []})
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{x : idx, `t_1*` : valtype*, `id?*` : char?*, `t_2*` : valtype*, I' : I, `st*` : subtype*, i : n} {{"("} {"type"} {x:Ttypeidx_(I)} {")"} {(t_1, ?(`%`_name(lift(id?{id <- `id?`}))))*{`id?` <- `id?*`, t_1 <- `t_1*`}:Tparam_(I)*{}} {t_2*{t_2 <- `t_2*`}:Tresult_(I)*{}}} => (x, I')
    -- if (I.TYPEDEFS_I[x!`%`_idx.0] = ?(_DEF_deftype(REC_rectype(`%`_list(st*{st <- `st*`})), i)))
    -- if (st*{st <- `st*`}[i] = SUB_subtype(?(FINAL_final), [], `FUNC%->%`_comptype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), `%`_resulttype(t_2*{t_2 <- `t_2*`}))))
    -- if (I' = {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS ?(`%`_name(lift(id?{id <- `id?`})))*{`id?` <- `id?*`}, LABELS [], FIELDS [], TYPEDEFS []})
    -- Idctxt_ok: `|-%:OK`(I')

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Ttagtype_(I : I) : tagtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{x : idx, I' : I} (x, I'):Ttypeuse_(I) => _IDX_tagtype(x)

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tglobaltype_(I : I) : globaltype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{t : valtype} t:Tvaltype_(I) => `%%`_globaltype(?(), t)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{t : valtype} {{"("} {"mut"} {t:Tvaltype_(I)} {")"}} => `%%`_globaltype(?(MUT_mut), t)

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Tmemtype_(I : I) : memtype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{at : addrtype, lim : limits} {{at:Taddrtype} {lim:Tlimits}} => `%%PAGE`_memtype(at, lim)

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Ttabletype_(I : I) : tabletype
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{at : addrtype, lim : limits, rt : reftype} {{at:Taddrtype} {lim:Tlimits} {rt:Treftype_(I)}} => `%%%`_tabletype(at, lim, rt)

;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
grammar Texterntype_(I : I) : (externtype, idctxt)
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`id?` : char?, jt : tagtype} {{"("} {"tag"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {jt:Ttagtype_(I)} {")"}} => (TAG_externtype(jt), {TYPES [], TAGS [?(`%`_name(lift(id?{id <- `id?`})))], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`id?` : char?, gt : globaltype} {{"("} {"global"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {gt:Tglobaltype_(I)} {")"}} => (GLOBAL_externtype(gt), {TYPES [], TAGS [], GLOBALS [?(`%`_name(lift(id?{id <- `id?`})))], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`id?` : char?, mt : memtype} {{"("} {"memory"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {mt:Tmemtype_(I)} {")"}} => (MEM_externtype(mt), {TYPES [], TAGS [], GLOBALS [], MEMS [?(`%`_name(lift(id?{id <- `id?`})))], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`id?` : char?, tt : tabletype} {{"("} {"table"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {tt:Ttabletype_(I)} {")"}} => (TABLE_externtype(tt), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [?(`%`_name(lift(id?{id <- `id?`})))], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})
  ;; ../../../../specification/wasm-3.0/6.2-text.types.spectec
  prod{`id?` : char?, x : idx, I' : I} {{"("} {"func"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {(x, I'):Ttypeuse_(I)} {")"}} => (FUNC_externtype(_IDX_typeuse(x)), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [?(`%`_name(lift(id?{id <- `id?`})))], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
grammar Tlabel_(I : I) : (name?, I)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod eps => (?(), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []} +++ I)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{id : name} id:Tid => (?(id), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [?(id)], FIELDS [], TYPEDEFS []} +++ I)
    -- if ~ (?(id) <- I.LABELS_I)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{id : name, x : idx} id:Tid => (?(id), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [?(id)], FIELDS [], TYPEDEFS []} +++ I[LABELS_I[x!`%`_idx.0] = ?()])
    -- if (?(id) = I.LABELS_I[x!`%`_idx.0])

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
grammar Tblocktype_(I : I) : blocktype
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{`t?` : valtype?} t?{t <- `t?`}:Tresult_(I)?{} => _RESULT_blocktype(t?{t <- `t?`})
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, I' : I} (x, I'):Ttypeuse_(I) => _IDX_blocktype(x)
    -- if (I' = {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS ?(`%`_name([]))*{}, LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
grammar Tcatch_(I : I) : catch
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, l : labelidx} {{"("} {"catch"} {x:Ttagidx_(I)} {l:Tlabelidx_(I)} {")"}} => CATCH_catch(x, l)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, l : labelidx} {{"("} {"catch_ref"} {x:Ttagidx_(I)} {l:Tlabelidx_(I)} {")"}} => CATCH_REF_catch(x, l)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{l : labelidx} {{"("} {"catch_all"} {l:Tlabelidx_(I)} {")"}} => CATCH_ALL_catch(l)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{l : labelidx} {{"("} {"catch_all_ref"} {l:Tlabelidx_(I)} {")"}} => CATCH_ALL_REF_catch(l)

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
grammar Tfoldedinstr_(I : I) : instr*

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
grammar Tlaneidx : laneidx
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : u8} i:Tu8 => i

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
grammar Talign_(N : N) : u64
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{m : m, n : n} {{"align="} {`%`_u64(m):Tu64}} => `%`_u64(m)
    -- if (m = (2 ^ n))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod eps => `%`_u64(N)

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
grammar Toffset : u64
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{n : n} {{"offset="} {`%`_u64(n):Tu64}} => `%`_u64(n)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod eps => `%`_u64(0)

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
grammar Tmemarg_(N : N) : memarg
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{n : n, m : m} {{`%`_u64(n):Toffset} {`%`_u64(m):Talign_(N)}} => {ALIGN `%`_u32(n), OFFSET `%`_u64(m)}

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
grammar Tplaininstr_(I : I) : instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "unreachable" => UNREACHABLE_instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "nop" => NOP_instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "drop" => DROP_instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{`t*?` : valtype*?} {{"select"} {t*{t <- `t*`}:Tresult_(I)*{}?{`t*` <- `t*?`}}} => SELECT_instr(t*{t <- `t*`}?{`t*` <- `t*?`})
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{l : labelidx} {{"br"} {l:Tlabelidx_(I)}} => BR_instr(l)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{l : labelidx} {{"br_if"} {l:Tlabelidx_(I)}} => BR_IF_instr(l)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{`l*` : labelidx*, l' : labelidx} {{"br_table"} {l*{l <- `l*`}:Tlabelidx_(I)*{}} {l':Tlabelidx_(I)}} => BR_TABLE_instr(l*{l <- `l*`}, l')
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{l : labelidx} {{"br_on_null"} {l:Tlabelidx_(I)}} => BR_ON_NULL_instr(l)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{l : labelidx} {{"br_on_non_null"} {l:Tlabelidx_(I)}} => BR_ON_NON_NULL_instr(l)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{l : labelidx, rt_1 : reftype, rt_2 : reftype} {{"br_on_cast"} {l:Tlabelidx_(I)} {rt_1:Treftype_(I)} {rt_2:Treftype_(I)}} => BR_ON_CAST_instr(l, rt_1, rt_2)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{l : labelidx, rt_1 : reftype, rt_2 : reftype} {{"br_on_cast_fail"} {l:Tlabelidx_(I)} {rt_1:Treftype_(I)} {rt_2:Treftype_(I)}} => BR_ON_CAST_FAIL_instr(l, rt_1, rt_2)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"call"} {x:Tfuncidx_(I)}} => CALL_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"call_ref"} {x:Ttypeidx_(I)}} => CALL_REF_instr(_IDX_typeuse(x))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, y : idx, I' : I} {{"call_indirect"} {x:Ttableidx_(I)} {(y, I'):Ttypeuse_(I)}} => CALL_INDIRECT_instr(x, _IDX_typeuse(y))
    -- if (I' = {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS ?(`%`_name([]))*{}, LABELS [], FIELDS [], TYPEDEFS []})
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "return" => RETURN_instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"return_call"} {x:Tfuncidx_(I)}} => RETURN_CALL_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"return_call_ref"} {x:Ttypeidx_(I)}} => RETURN_CALL_REF_instr(_IDX_typeuse(x))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, y : idx, I' : I} {{"return_call_indirect"} {x:Ttableidx_(I)} {(y, I'):Ttypeuse_(I)}} => RETURN_CALL_INDIRECT_instr(x, _IDX_typeuse(y))
    -- if (I' = {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS ?(`%`_name([]))*{}, LABELS [], FIELDS [], TYPEDEFS []})
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"throw"} {x:Ttagidx_(I)}} => THROW_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "throw_ref" => THROW_REF_instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"local.get"} {x:Tlocalidx_(I)}} => LOCAL.GET_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"local.set"} {x:Tlocalidx_(I)}} => LOCAL.SET_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"local.tee"} {x:Tlocalidx_(I)}} => LOCAL.TEE_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"global.get"} {x:Tglobalidx_(I)}} => GLOBAL.GET_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"global.set"} {x:Tglobalidx_(I)}} => GLOBAL.SET_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"table.get"} {x:Ttableidx_(I)}} => TABLE.GET_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"table.set"} {x:Ttableidx_(I)}} => TABLE.SET_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"table.size"} {x:Ttableidx_(I)}} => TABLE.SIZE_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"table.grow"} {x:Ttableidx_(I)}} => TABLE.GROW_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"table.fill"} {x:Ttableidx_(I)}} => TABLE.FILL_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x_1 : idx, x_2 : idx} {{"table.copy"} {x_1:Ttableidx_(I)} {x_2:Ttableidx_(I)}} => TABLE.COPY_instr(x_1, x_2)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, y : idx} {{"table.init"} {x:Ttableidx_(I)} {y:Telemidx_(I)}} => TABLE.INIT_instr(x, y)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"elem.drop"} {x:Telemidx_(I)}} => ELEM.DROP_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i32.load"} {x:Tmemidx_(I)} {ao:Tmemarg_(4)}} => LOAD_instr(I32_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i64.load"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)}} => LOAD_instr(I64_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"f32.load"} {x:Tmemidx_(I)} {ao:Tmemarg_(4)}} => LOAD_instr(F32_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"f64.load"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)}} => LOAD_instr(F64_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i32.load8_s"} {x:Tmemidx_(I)} {ao:Tmemarg_(1)}} => LOAD_instr(I32_numtype, ?(`%_%`_loadop_(`%`_sz(8), S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i32.load8_u"} {x:Tmemidx_(I)} {ao:Tmemarg_(1)}} => LOAD_instr(I32_numtype, ?(`%_%`_loadop_(`%`_sz(8), U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i32.load16_s"} {x:Tmemidx_(I)} {ao:Tmemarg_(2)}} => LOAD_instr(I32_numtype, ?(`%_%`_loadop_(`%`_sz(16), S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i32.load16_u"} {x:Tmemidx_(I)} {ao:Tmemarg_(2)}} => LOAD_instr(I32_numtype, ?(`%_%`_loadop_(`%`_sz(16), U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i64.load8_s"} {x:Tmemidx_(I)} {ao:Tmemarg_(1)}} => LOAD_instr(I64_numtype, ?(`%_%`_loadop_(`%`_sz(8), S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i64.load8_u"} {x:Tmemidx_(I)} {ao:Tmemarg_(1)}} => LOAD_instr(I64_numtype, ?(`%_%`_loadop_(`%`_sz(8), U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i64.load16_s"} {x:Tmemidx_(I)} {ao:Tmemarg_(2)}} => LOAD_instr(I64_numtype, ?(`%_%`_loadop_(`%`_sz(16), S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i64.load16_u"} {x:Tmemidx_(I)} {ao:Tmemarg_(2)}} => LOAD_instr(I64_numtype, ?(`%_%`_loadop_(`%`_sz(16), U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i64.load32_s"} {x:Tmemidx_(I)} {ao:Tmemarg_(4)}} => LOAD_instr(I64_numtype, ?(`%_%`_loadop_(`%`_sz(32), S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i64.load32_u"} {x:Tmemidx_(I)} {ao:Tmemarg_(4)}} => LOAD_instr(I64_numtype, ?(`%_%`_loadop_(`%`_sz(32), U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load"} {x:Tmemidx_(I)} {ao:Tmemarg_(16)}} => VLOAD_instr(V128_vectype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load8x8_s"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)}} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(8), 8, S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load8x8_u"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)}} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(8), 8, U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load16x4_s"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)}} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(16), 4, S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load16x4_u"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)}} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(16), 4, U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load32x2_s"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)}} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(32), 2, S_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load32x2_u"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)}} => VLOAD_instr(V128_vectype, ?(`SHAPE%X%_%`_vloadop_(`%`_sz(32), 2, U_sx)), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load8_splat"} {x:Tmemidx_(I)} {ao:Tmemarg_(1)}} => VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(8))), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load16_splat"} {x:Tmemidx_(I)} {ao:Tmemarg_(2)}} => VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(16))), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load32_splat"} {x:Tmemidx_(I)} {ao:Tmemarg_(4)}} => VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(32))), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load64_splat"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)}} => VLOAD_instr(V128_vectype, ?(SPLAT_vloadop_(`%`_sz(64))), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load32_zero"} {x:Tmemidx_(I)} {ao:Tmemarg_(4)}} => VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(32))), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.load64_zero"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)}} => VLOAD_instr(V128_vectype, ?(ZERO_vloadop_(`%`_sz(64))), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg, i : laneidx} {{"v128.load8_lane"} {x:Tmemidx_(I)} {ao:Tmemarg_(1)} {i:Tlaneidx}} => VLOAD_LANE_instr(V128_vectype, `%`_sz(8), x, ao, i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg, i : laneidx} {{"v128.load16_lane"} {x:Tmemidx_(I)} {ao:Tmemarg_(2)} {i:Tlaneidx}} => VLOAD_LANE_instr(V128_vectype, `%`_sz(16), x, ao, i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg, i : laneidx} {{"v128.load32_lane"} {x:Tmemidx_(I)} {ao:Tmemarg_(4)} {i:Tlaneidx}} => VLOAD_LANE_instr(V128_vectype, `%`_sz(32), x, ao, i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg, i : laneidx} {{"v128.load64_lane"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)} {i:Tlaneidx}} => VLOAD_LANE_instr(V128_vectype, `%`_sz(64), x, ao, i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i32.store"} {x:Tmemidx_(I)} {ao:Tmemarg_(4)}} => STORE_instr(I32_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i64.store"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)}} => STORE_instr(I64_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"f32.store"} {x:Tmemidx_(I)} {ao:Tmemarg_(4)}} => STORE_instr(F32_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"f64.store"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)}} => STORE_instr(F64_numtype, ?(), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i32.store8"} {x:Tmemidx_(I)} {ao:Tmemarg_(1)}} => STORE_instr(I32_numtype, ?(`%`_storeop_(`%`_sz(8))), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i32.store16"} {x:Tmemidx_(I)} {ao:Tmemarg_(2)}} => STORE_instr(I32_numtype, ?(`%`_storeop_(`%`_sz(16))), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i64.store8"} {x:Tmemidx_(I)} {ao:Tmemarg_(1)}} => STORE_instr(I64_numtype, ?(`%`_storeop_(`%`_sz(8))), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i64.store16"} {x:Tmemidx_(I)} {ao:Tmemarg_(2)}} => STORE_instr(I64_numtype, ?(`%`_storeop_(`%`_sz(16))), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"i64.store32"} {x:Tmemidx_(I)} {ao:Tmemarg_(4)}} => STORE_instr(I64_numtype, ?(`%`_storeop_(`%`_sz(32))), x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg} {{"v128.store"} {x:Tmemidx_(I)} {ao:Tmemarg_(16)}} => VSTORE_instr(V128_vectype, x, ao)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg, i : laneidx} {{"v128.store8_lane"} {x:Tmemidx_(I)} {ao:Tmemarg_(1)} {i:Tlaneidx}} => VSTORE_LANE_instr(V128_vectype, `%`_sz(8), x, ao, i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg, i : laneidx} {{"v128.store16_lane"} {x:Tmemidx_(I)} {ao:Tmemarg_(2)} {i:Tlaneidx}} => VSTORE_LANE_instr(V128_vectype, `%`_sz(16), x, ao, i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg, i : laneidx} {{"v128.store32_lane"} {x:Tmemidx_(I)} {ao:Tmemarg_(4)} {i:Tlaneidx}} => VSTORE_LANE_instr(V128_vectype, `%`_sz(32), x, ao, i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, ao : memarg, i : laneidx} {{"v128.store64_lane"} {x:Tmemidx_(I)} {ao:Tmemarg_(8)} {i:Tlaneidx}} => VSTORE_LANE_instr(V128_vectype, `%`_sz(64), x, ao, i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"memory.size"} {x:Tmemidx_(I)}} => MEMORY.SIZE_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"memory.grow"} {x:Tmemidx_(I)}} => MEMORY.GROW_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"memory.fill"} {x:Tmemidx_(I)}} => MEMORY.FILL_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x_1 : idx, x_2 : idx} {{"memory.copy"} {x_1:Tmemidx_(I)} {x_2:Tmemidx_(I)}} => MEMORY.COPY_instr(x_1, x_2)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, y : idx} {{"memory.init"} {x:Tmemidx_(I)} {y:Tdataidx_(I)}} => MEMORY.INIT_instr(x, y)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"data.drop"} {x:Tdataidx_(I)}} => DATA.DROP_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{ht : heaptype} {{"ref.null"} {ht:Theaptype_(I)}} => REF.NULL_instr(ht)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"ref.func"} {x:Tfuncidx_(I)}} => REF.FUNC_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "ref.is_null" => REF.IS_NULL_instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "ref.as_non_null" => REF.AS_NON_NULL_instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "ref.eq" => REF.EQ_instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{rt : reftype} {{"ref.test"} {rt:Treftype_(I)}} => REF.TEST_instr(rt)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{rt : reftype} {{"ref.cast"} {rt:Treftype_(I)}} => REF.CAST_instr(rt)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "ref.i31" => REF.I31_instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i31.get_s" => I31.GET_instr(S_sx)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i31.get_u" => I31.GET_instr(U_sx)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"struct.new"} {x:Ttypeidx_(I)}} => STRUCT.NEW_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"struct.new_default"} {x:Ttypeidx_(I)}} => STRUCT.NEW_DEFAULT_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, i : fieldidx} {{"struct.get"} {x:Ttypeidx_(I)} {i:Tfieldidx__(I, x)}} => STRUCT.GET_instr(?(), x, i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, i : fieldidx} {{"struct.get_s"} {x:Ttypeidx_(I)} {i:Tfieldidx__(I, x)}} => STRUCT.GET_instr(?(S_sx), x, i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, i : fieldidx} {{"struct.get_u"} {x:Ttypeidx_(I)} {i:Tfieldidx__(I, x)}} => STRUCT.GET_instr(?(U_sx), x, i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, i : fieldidx} {{"struct.set"} {x:Ttypeidx_(I)} {i:Tfieldidx__(I, x)}} => STRUCT.SET_instr(x, i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"array.new"} {x:Ttypeidx_(I)}} => ARRAY.NEW_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"array.new_default"} {x:Ttypeidx_(I)}} => ARRAY.NEW_DEFAULT_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, n : n} {{"array.new_fixed"} {x:Ttypeidx_(I)} {`%`_u32(n):Tu32}} => ARRAY.NEW_FIXED_instr(x, `%`_u32(n))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, y : idx} {{"array.new_data"} {x:Ttypeidx_(I)} {y:Tdataidx_(I)}} => ARRAY.NEW_DATA_instr(x, y)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, y : idx} {{"array.new_elem"} {x:Ttypeidx_(I)} {y:Telemidx_(I)}} => ARRAY.NEW_ELEM_instr(x, y)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"array.get"} {x:Ttypeidx_(I)}} => ARRAY.GET_instr(?(), x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"array.get_s"} {x:Ttypeidx_(I)}} => ARRAY.GET_instr(?(S_sx), x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"array.get_u"} {x:Ttypeidx_(I)}} => ARRAY.GET_instr(?(U_sx), x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"array.set"} {x:Ttypeidx_(I)}} => ARRAY.SET_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "array.len" => ARRAY.LEN_instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx} {{"array.fill"} {x:Ttypeidx_(I)}} => ARRAY.FILL_instr(x)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x_1 : idx, x_2 : idx} {{"array.copy"} {x_1:Ttypeidx_(I)} {x_2:Ttypeidx_(I)}} => ARRAY.COPY_instr(x_1, x_2)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, y : idx} {{"array.init_data"} {x:Ttypeidx_(I)} {y:Tdataidx_(I)}} => ARRAY.INIT_DATA_instr(x, y)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{x : idx, y : idx} {{"array.init_elem"} {x:Ttypeidx_(I)} {y:Telemidx_(I)}} => ARRAY.INIT_ELEM_instr(x, y)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "any.convert_extern" => ANY.CONVERT_EXTERN_instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "extern.convert_any" => EXTERN.CONVERT_ANY_instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{c : u32} {{"i32.const"} {c:Ti32}} => CONST_instr(I32_numtype, c)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{c : u64} {{"i64.const"} {c:Ti64}} => CONST_instr(I64_numtype, c)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{c : f32} {{"f32.const"} {c:Tf32}} => CONST_instr(F32_numtype, c)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{c : f64} {{"f64.const"} {c:Tf64}} => CONST_instr(F64_numtype, c)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.eqz" => TESTOP_instr(I32_numtype, EQZ_testop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.eqz" => TESTOP_instr(I64_numtype, EQZ_testop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.eq" => RELOP_instr(I32_numtype, EQ_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.ne" => RELOP_instr(I32_numtype, NE_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.lt_s" => RELOP_instr(I32_numtype, LT_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.lt_u" => RELOP_instr(I32_numtype, LT_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.gt_s" => RELOP_instr(I32_numtype, GT_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.gt_u" => RELOP_instr(I32_numtype, GT_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.le_s" => RELOP_instr(I32_numtype, LE_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.le_u" => RELOP_instr(I32_numtype, LE_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.ge_s" => RELOP_instr(I32_numtype, GE_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.ge_u" => RELOP_instr(I32_numtype, GE_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.eq" => RELOP_instr(I64_numtype, EQ_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.ne" => RELOP_instr(I64_numtype, NE_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.lt_s" => RELOP_instr(I64_numtype, LT_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.lt_u" => RELOP_instr(I64_numtype, LT_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.gt_s" => RELOP_instr(I64_numtype, GT_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.gt_u" => RELOP_instr(I64_numtype, GT_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.le_s" => RELOP_instr(I64_numtype, LE_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.le_u" => RELOP_instr(I64_numtype, LE_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.ge_s" => RELOP_instr(I64_numtype, GE_relop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.ge_u" => RELOP_instr(I64_numtype, GE_relop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.eq" => RELOP_instr(F32_numtype, EQ_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.ne" => RELOP_instr(F32_numtype, NE_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.lt" => RELOP_instr(F32_numtype, LT_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.gt" => RELOP_instr(F32_numtype, GT_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.le" => RELOP_instr(F32_numtype, LE_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.ge" => RELOP_instr(F32_numtype, GE_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.eq" => RELOP_instr(F64_numtype, EQ_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.ne" => RELOP_instr(F64_numtype, NE_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.lt" => RELOP_instr(F64_numtype, LT_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.gt" => RELOP_instr(F64_numtype, GT_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.le" => RELOP_instr(F64_numtype, LE_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.ge" => RELOP_instr(F64_numtype, GE_relop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.clz" => UNOP_instr(I32_numtype, CLZ_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.ctz" => UNOP_instr(I32_numtype, CTZ_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.popcnt" => UNOP_instr(I32_numtype, POPCNT_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.extend8_s" => UNOP_instr(I32_numtype, EXTEND_unop_(`%`_sz(8)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.extend16_s" => UNOP_instr(I32_numtype, EXTEND_unop_(`%`_sz(16)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.clz" => UNOP_instr(I64_numtype, CLZ_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.ctz" => UNOP_instr(I64_numtype, CTZ_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.popcnt" => UNOP_instr(I64_numtype, POPCNT_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.extend8_s" => UNOP_instr(I64_numtype, EXTEND_unop_(`%`_sz(8)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.extend16_s" => UNOP_instr(I64_numtype, EXTEND_unop_(`%`_sz(16)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.extend32_s" => UNOP_instr(I64_numtype, EXTEND_unop_(`%`_sz(32)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.abs" => UNOP_instr(F32_numtype, ABS_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.neg" => UNOP_instr(F32_numtype, NEG_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.sqrt" => UNOP_instr(F32_numtype, SQRT_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.ceil" => UNOP_instr(F32_numtype, CEIL_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.floor" => UNOP_instr(F32_numtype, FLOOR_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.trunc" => UNOP_instr(F32_numtype, TRUNC_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.nearest" => UNOP_instr(F32_numtype, NEAREST_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.abs" => UNOP_instr(F64_numtype, ABS_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.neg" => UNOP_instr(F64_numtype, NEG_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.sqrt" => UNOP_instr(F64_numtype, SQRT_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.ceil" => UNOP_instr(F64_numtype, CEIL_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.floor" => UNOP_instr(F64_numtype, FLOOR_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.trunc" => UNOP_instr(F64_numtype, TRUNC_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.nearest" => UNOP_instr(F64_numtype, NEAREST_unop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.add" => BINOP_instr(I32_numtype, ADD_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.sub" => BINOP_instr(I32_numtype, SUB_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.mul" => BINOP_instr(I32_numtype, MUL_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.div_s" => BINOP_instr(I32_numtype, DIV_binop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.div_u" => BINOP_instr(I32_numtype, DIV_binop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.rem_s" => BINOP_instr(I32_numtype, REM_binop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.rem_u" => BINOP_instr(I32_numtype, REM_binop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.and" => BINOP_instr(I32_numtype, AND_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.or" => BINOP_instr(I32_numtype, OR_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.xor" => BINOP_instr(I32_numtype, XOR_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.shl" => BINOP_instr(I32_numtype, SHL_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.shr_s" => BINOP_instr(I32_numtype, SHR_binop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.shr_u" => BINOP_instr(I32_numtype, SHR_binop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.rotl" => BINOP_instr(I32_numtype, ROTL_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.rotr" => BINOP_instr(I32_numtype, ROTR_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.add" => BINOP_instr(I64_numtype, ADD_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.sub" => BINOP_instr(I64_numtype, SUB_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.mul" => BINOP_instr(I64_numtype, MUL_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.div_s" => BINOP_instr(I64_numtype, DIV_binop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.div_u" => BINOP_instr(I64_numtype, DIV_binop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.rem_s" => BINOP_instr(I64_numtype, REM_binop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.rem_u" => BINOP_instr(I64_numtype, REM_binop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.and" => BINOP_instr(I64_numtype, AND_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.or" => BINOP_instr(I64_numtype, OR_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.xor" => BINOP_instr(I64_numtype, XOR_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.shl" => BINOP_instr(I64_numtype, SHL_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.shr_s" => BINOP_instr(I64_numtype, SHR_binop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.shr_u" => BINOP_instr(I64_numtype, SHR_binop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.rotl" => BINOP_instr(I64_numtype, ROTL_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.rotr" => BINOP_instr(I64_numtype, ROTR_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.add" => BINOP_instr(F32_numtype, ADD_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.sub" => BINOP_instr(F32_numtype, SUB_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.mul" => BINOP_instr(F32_numtype, MUL_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.div" => BINOP_instr(F32_numtype, DIV_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.min" => BINOP_instr(F32_numtype, MIN_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.max" => BINOP_instr(F32_numtype, MAX_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.copysign" => BINOP_instr(F32_numtype, COPYSIGN_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.add" => BINOP_instr(F64_numtype, ADD_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.sub" => BINOP_instr(F64_numtype, SUB_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.mul" => BINOP_instr(F64_numtype, MUL_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.div" => BINOP_instr(F64_numtype, DIV_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.min" => BINOP_instr(F64_numtype, MIN_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.max" => BINOP_instr(F64_numtype, MAX_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.copysign" => BINOP_instr(F64_numtype, COPYSIGN_binop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.wrap_i64" => CVTOP_instr(I32_numtype, I64_numtype, WRAP_cvtop__)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.trunc_f32_s" => CVTOP_instr(I32_numtype, F32_numtype, TRUNC_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.trunc_f32_u" => CVTOP_instr(I32_numtype, F32_numtype, TRUNC_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.trunc_f64_s" => CVTOP_instr(I32_numtype, F64_numtype, TRUNC_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.trunc_f64_u" => CVTOP_instr(I32_numtype, F64_numtype, TRUNC_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.trunc_sat_f32_s" => CVTOP_instr(I32_numtype, F32_numtype, TRUNC_SAT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.trunc_sat_f32_u" => CVTOP_instr(I32_numtype, F32_numtype, TRUNC_SAT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.trunc_sat_f64_s" => CVTOP_instr(I32_numtype, F64_numtype, TRUNC_SAT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.trunc_sat_f64_u" => CVTOP_instr(I32_numtype, F64_numtype, TRUNC_SAT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.extend_i64_s" => CVTOP_instr(I64_numtype, I64_numtype, EXTEND_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.extend_i64_u" => CVTOP_instr(I64_numtype, I64_numtype, EXTEND_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.trunc_f32_s" => CVTOP_instr(I64_numtype, F32_numtype, TRUNC_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.trunc_f32_u" => CVTOP_instr(I64_numtype, F32_numtype, TRUNC_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.trunc_f64_s" => CVTOP_instr(I64_numtype, F64_numtype, TRUNC_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.trunc_f64_u" => CVTOP_instr(I64_numtype, F64_numtype, TRUNC_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.trunc_sat_f32_s" => CVTOP_instr(I64_numtype, F32_numtype, TRUNC_SAT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.trunc_sat_f32_u" => CVTOP_instr(I64_numtype, F32_numtype, TRUNC_SAT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.trunc_sat_f64_s" => CVTOP_instr(I64_numtype, F64_numtype, TRUNC_SAT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.trunc_sat_f64_u" => CVTOP_instr(I64_numtype, F64_numtype, TRUNC_SAT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.demote_f64" => CVTOP_instr(F32_numtype, F64_numtype, DEMOTE_cvtop__)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.convert_i32_s" => CVTOP_instr(F32_numtype, I32_numtype, CONVERT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.convert_i32_u" => CVTOP_instr(F32_numtype, I32_numtype, CONVERT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.convert_i64_s" => CVTOP_instr(F32_numtype, I64_numtype, CONVERT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.convert_i64_u" => CVTOP_instr(F32_numtype, I64_numtype, CONVERT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.promote_f32" => CVTOP_instr(F64_numtype, F32_numtype, PROMOTE_cvtop__)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.convert_i32_s" => CVTOP_instr(F64_numtype, I32_numtype, CONVERT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.convert_i32_u" => CVTOP_instr(F64_numtype, I32_numtype, CONVERT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.convert_i64_s" => CVTOP_instr(F64_numtype, I64_numtype, CONVERT_cvtop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.convert_i64_u" => CVTOP_instr(F64_numtype, I64_numtype, CONVERT_cvtop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32.reinterpret_f32" => CVTOP_instr(I32_numtype, F32_numtype, REINTERPRET_cvtop__)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64.reinterpret_f64" => CVTOP_instr(I64_numtype, F64_numtype, REINTERPRET_cvtop__)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32.reinterpret_i32" => CVTOP_instr(F32_numtype, I32_numtype, REINTERPRET_cvtop__)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64.reinterpret_i64" => CVTOP_instr(F64_numtype, I64_numtype, REINTERPRET_cvtop__)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{`c*` : u8*} {{"v128.const"} {"i8x16"} {c*{c <- `c*`}:Ti8^16{}}} => VCONST_instr(V128_vectype, $inv_ibytes_(128, $concat_(syntax byte, $ibytes_(8, c)*{c <- `c*`})))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{`c*` : u16*} {{"v128.const"} {"i16x8"} {c*{c <- `c*`}:Ti16^8{}}} => VCONST_instr(V128_vectype, $inv_ibytes_(128, $concat_(syntax byte, $ibytes_(16, c)*{c <- `c*`})))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{`c*` : u32*} {{"v128.const"} {"i32x4"} {c*{c <- `c*`}:Ti32^4{}}} => VCONST_instr(V128_vectype, $inv_ibytes_(128, $concat_(syntax byte, $ibytes_(32, c)*{c <- `c*`})))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{`c*` : u64*} {{"v128.const"} {"i64x2"} {c*{c <- `c*`}:Ti64^2{}}} => VCONST_instr(V128_vectype, $inv_ibytes_(128, $concat_(syntax byte, $ibytes_(64, c)*{c <- `c*`})))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{`c*` : f32*} {{"v128.const"} {"f32x4"} {c*{c <- `c*`}:Tf32^4{}}} => VCONST_instr(V128_vectype, $inv_ibytes_(128, $concat_(syntax byte, $fbytes_(32, c)*{c <- `c*`})))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{`c*` : f64*} {{"v128.const"} {"f64x2"} {c*{c <- `c*`}:Tf64^2{}}} => VCONST_instr(V128_vectype, $inv_ibytes_(128, $concat_(syntax byte, $fbytes_(64, c)*{c <- `c*`})))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{`i*` : laneidx*} {{"i8x16.shuffle"} {i*{i <- `i*`}:Tlaneidx^16{}}} => VSHUFFLE_instr(`%`_bshape(`%X%`_shape(I8_lanetype, `%`_dim(16))), i*{i <- `i*`})
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.swizzle" => VSWIZZLOP_instr(`%`_bshape(`%X%`_shape(I8_lanetype, `%`_dim(16))), SWIZZLE_vswizzlop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.relaxed_swizzle" => VSWIZZLOP_instr(`%`_bshape(`%X%`_shape(I8_lanetype, `%`_dim(16))), RELAXED_SWIZZLE_vswizzlop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.splat" => VSPLAT_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.splat" => VSPLAT_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.splat" => VSPLAT_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.splat" => VSPLAT_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.splat" => VSPLAT_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.splat" => VSPLAT_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"i8x16.extract_lane_s"} {i:Tlaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ?(S_sx), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"i8x16.extract_lane_u"} {i:Tlaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ?(U_sx), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"i16x8.extract_lane_s"} {i:Tlaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ?(S_sx), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"i16x8.extract_lane_u"} {i:Tlaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ?(U_sx), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"i32x4.extract_lane"} {i:Tlaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), ?(), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"i64x2.extract_lane"} {i:Tlaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), ?(), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"f32x4.extract_lane"} {i:Tlaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), ?(), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"f64x2.extract_lane"} {i:Tlaneidx}} => VEXTRACT_LANE_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), ?(), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"i8x16.replace_lane"} {i:Tlaneidx}} => VREPLACE_LANE_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"i16x8.replace_lane"} {i:Tlaneidx}} => VREPLACE_LANE_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"i32x4.replace_lane"} {i:Tlaneidx}} => VREPLACE_LANE_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"i64x2.replace_lane"} {i:Tlaneidx}} => VREPLACE_LANE_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"f32x4.replace_lane"} {i:Tlaneidx}} => VREPLACE_LANE_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{i : laneidx} {{"f64x2.replace_lane"} {i:Tlaneidx}} => VREPLACE_LANE_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), i)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "v128.any_true" => VVTESTOP_instr(V128_vectype, ANY_TRUE_vvtestop)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.all_true" => VTESTOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ALL_TRUE_vtestop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.all_true" => VTESTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ALL_TRUE_vtestop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.all_true" => VTESTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), ALL_TRUE_vtestop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.all_true" => VTESTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), ALL_TRUE_vtestop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.eq" => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), EQ_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.ne" => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), NE_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.lt_s" => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), LT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.lt_u" => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), LT_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.gt_s" => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), GT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.gt_u" => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), GT_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.le_s" => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), LE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.le_u" => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), LE_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.ge_s" => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), GE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.ge_u" => VRELOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), GE_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.eq" => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), EQ_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.ne" => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), NE_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.lt_s" => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), LT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.lt_u" => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), LT_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.gt_s" => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), GT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.gt_u" => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), GT_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.le_s" => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), LE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.le_u" => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), LE_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.ge_s" => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), GE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.ge_u" => VRELOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), GE_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.eq" => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), EQ_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.ne" => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), NE_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.lt_s" => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), LT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.lt_u" => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), LT_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.gt_s" => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), GT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.gt_u" => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), GT_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.le_s" => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), LE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.le_u" => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), LE_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.ge_s" => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), GE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.ge_u" => VRELOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), GE_vrelop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.eq" => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), EQ_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.ne" => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), NE_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.lt_s" => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), LT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.gt_s" => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), GT_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.le_s" => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), LE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.ge_s" => VRELOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), GE_vrelop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.eq" => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), EQ_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.ne" => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), NE_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.lt" => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), LT_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.gt" => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), GT_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.le" => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), LE_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.ge" => VRELOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), GE_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.eq" => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), EQ_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.ne" => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), NE_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.lt" => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), LT_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.gt" => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), GT_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.le" => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), LE_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.ge" => VRELOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), GE_vrelop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "v128.not" => VVUNOP_instr(V128_vectype, NOT_vvunop)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.abs" => VUNOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ABS_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.neg" => VUNOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), NEG_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.popcnt" => VUNOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), POPCNT_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.abs" => VUNOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ABS_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.neg" => VUNOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), NEG_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.abs" => VUNOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), ABS_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.neg" => VUNOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), NEG_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.abs" => VUNOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), ABS_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.neg" => VUNOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), NEG_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.abs" => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), ABS_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.neg" => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), NEG_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.sqrt" => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), SQRT_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.ceil" => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), CEIL_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.floor" => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), FLOOR_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.trunc" => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), TRUNC_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.nearest" => VUNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), NEAREST_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.abs" => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), ABS_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.neg" => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), NEG_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.sqrt" => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), SQRT_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.ceil" => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), CEIL_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.floor" => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), FLOOR_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.trunc" => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), TRUNC_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.nearest" => VUNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), NEAREST_vunop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "v128.and" => VVBINOP_instr(V128_vectype, AND_vvbinop)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "v128.andnot" => VVBINOP_instr(V128_vectype, ANDNOT_vvbinop)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "v128.or" => VVBINOP_instr(V128_vectype, OR_vvbinop)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "v128.xor" => VVBINOP_instr(V128_vectype, XOR_vvbinop)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.add" => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ADD_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.add_sat_s" => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ADD_SAT_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.add_sat_u" => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), ADD_SAT_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.sub" => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), SUB_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.sub_sat_s" => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), SUB_SAT_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.sub_sat_u" => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), SUB_SAT_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.min_s" => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), MIN_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.min_u" => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), MIN_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.max_s" => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), MAX_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.max_u" => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), MAX_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.avgr_u" => VBINOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), `AVGRU`_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.add" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ADD_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.add_sat_s" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ADD_SAT_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.add_sat_u" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), ADD_SAT_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.sub" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), SUB_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.sub_sat_s" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), SUB_SAT_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.sub_sat_u" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), SUB_SAT_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.mul" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MUL_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.min_s" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MIN_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.min_u" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MIN_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.max_s" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MAX_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.max_u" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), MAX_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.avgr_u" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `AVGRU`_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.q15mulr_sat_s" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `Q15MULR_SATS`_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.relaxed_q15mulr_s" => VBINOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `RELAXED_Q15MULRS`_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.add" => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), ADD_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.sub" => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), SUB_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.mul" => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MUL_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.min_s" => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MIN_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.min_u" => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MIN_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.max_s" => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MAX_vbinop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.max_u" => VBINOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), MAX_vbinop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.add" => VBINOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), ADD_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.sub" => VBINOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), SUB_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.mul" => VBINOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), MUL_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.add" => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), ADD_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.sub" => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), SUB_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.mul" => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), MUL_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.div" => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), DIV_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.min" => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), MIN_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.max" => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), MAX_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.pmin" => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), PMIN_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.pmax" => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), PMAX_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.relaxed_min" => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_MIN_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.relaxed_max" => VBINOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_MAX_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.add" => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), ADD_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.sub" => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), SUB_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.mul" => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), MUL_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.div" => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), DIV_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.min" => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), MIN_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.max" => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), MAX_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.pmin" => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), PMIN_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.pmax" => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), PMAX_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.relaxed_min" => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_MIN_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.relaxed_max" => VBINOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_MAX_vbinop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "v128.bitselect" => VVTERNOP_instr(V128_vectype, BITSELECT_vvternop)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.relaxed_laneselect" => VTERNOP_instr(`%X%`_shape(I8_lanetype, `%`_dim(16)), RELAXED_LANESELECT_vternop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.relaxed_laneselect" => VTERNOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), RELAXED_LANESELECT_vternop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.relaxed_laneselect" => VTERNOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), RELAXED_LANESELECT_vternop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.relaxed_laneselect" => VTERNOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), RELAXED_LANESELECT_vternop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.relaxed_madd" => VTERNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_MADD_vternop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.relaxed_nmadd" => VTERNOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_NMADD_vternop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.relaxed_madd" => VTERNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_MADD_vternop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.relaxed_nmadd" => VTERNOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_NMADD_vternop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.shl" => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), SHL_vshiftop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.shr_s" => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), SHR_vshiftop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.shr_u" => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), SHR_vshiftop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.shl" => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), SHL_vshiftop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.shr_s" => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), SHR_vshiftop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.shr_u" => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), SHR_vshiftop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.shl" => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), SHL_vshiftop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.shr_s" => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), SHR_vshiftop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.shr_u" => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), SHR_vshiftop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.shl" => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), SHL_vshiftop_)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.shr_s" => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), SHR_vshiftop_(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.shr_u" => VSHIFTOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), SHR_vshiftop_(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.bitmask" => VBITMASK_instr(`%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.bitmask" => VBITMASK_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.bitmask" => VBITMASK_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.bitmask" => VBITMASK_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.narrow_i16x8_s" => VNARROW_instr(`%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), S_sx)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i8x16.narrow_i16x8_u" => VNARROW_instr(`%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), U_sx)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.narrow_i32x4_s" => VNARROW_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), S_sx)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.narrow_i32x4_u" => VNARROW_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), U_sx)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.extend_low_i8x16_s" => VCVTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%X%`_shape(I8_lanetype, `%`_dim(16)), EXTEND_vcvtop__(LOW_half, S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.extend_low_i8x16_u" => VCVTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%X%`_shape(I8_lanetype, `%`_dim(16)), EXTEND_vcvtop__(LOW_half, U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.extend_high_i8x16_s" => VCVTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%X%`_shape(I8_lanetype, `%`_dim(16)), EXTEND_vcvtop__(HIGH_half, S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.extend_high_i8x16_u" => VCVTOP_instr(`%X%`_shape(I16_lanetype, `%`_dim(8)), `%X%`_shape(I8_lanetype, `%`_dim(16)), EXTEND_vcvtop__(HIGH_half, U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.extend_low_i16x8_s" => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(I16_lanetype, `%`_dim(8)), EXTEND_vcvtop__(LOW_half, S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.extend_low_i16x8_u" => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(I16_lanetype, `%`_dim(8)), EXTEND_vcvtop__(LOW_half, U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.extend_high_i16x8_s" => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(I16_lanetype, `%`_dim(8)), EXTEND_vcvtop__(HIGH_half, S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.extend_high_i16x8_u" => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(I16_lanetype, `%`_dim(8)), EXTEND_vcvtop__(HIGH_half, U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.trunc_sat_f32x4_s" => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F32_lanetype, `%`_dim(4)), TRUNC_SAT_vcvtop__(S_sx, ?()))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.trunc_sat_f32x4_u" => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F32_lanetype, `%`_dim(4)), TRUNC_SAT_vcvtop__(U_sx, ?()))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.trunc_sat_f64x2_s_zero" => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), TRUNC_SAT_vcvtop__(S_sx, ?(ZERO_zero)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.trunc_sat_f64x2_u_zero" => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), TRUNC_SAT_vcvtop__(U_sx, ?(ZERO_zero)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.relaxed_trunc_f32x4_s" => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_TRUNC_vcvtop__(S_sx, ?()))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.relaxed_trunc_f32x4_u" => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F32_lanetype, `%`_dim(4)), RELAXED_TRUNC_vcvtop__(U_sx, ?()))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.relaxed_trunc_f64x2_s_zero" => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_TRUNC_vcvtop__(S_sx, ?(ZERO_zero)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.relaxed_trunc_f64x2_u_zero" => VCVTOP_instr(`%X%`_shape(I32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), RELAXED_TRUNC_vcvtop__(U_sx, ?(ZERO_zero)))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.extend_low_i32x4_s" => VCVTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), EXTEND_vcvtop__(LOW_half, S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.extend_low_i32x4_u" => VCVTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), EXTEND_vcvtop__(LOW_half, U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.extend_high_i32x4_s" => VCVTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), EXTEND_vcvtop__(HIGH_half, S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.extend_high_i32x4_u" => VCVTOP_instr(`%X%`_shape(I64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), EXTEND_vcvtop__(HIGH_half, U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.demote_f64x2_zero" => VCVTOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), `%X%`_shape(F64_lanetype, `%`_dim(2)), DEMOTE_vcvtop__(ZERO_zero))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.convert_i32x4_s" => VCVTOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), `%X%`_shape(I32_lanetype, `%`_dim(4)), CONVERT_vcvtop__(?(), S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f32x4.convert_i32x4_u" => VCVTOP_instr(`%X%`_shape(F32_lanetype, `%`_dim(4)), `%X%`_shape(I32_lanetype, `%`_dim(4)), CONVERT_vcvtop__(?(), U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.promote_low_f32x4" => VCVTOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), `%X%`_shape(F32_lanetype, `%`_dim(4)), `PROMOTELOW`_vcvtop__)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.convert_low_i32x4_s" => VCVTOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), CONVERT_vcvtop__(?(LOW_half), S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "f64x2.convert_low_i32x4_u" => VCVTOP_instr(`%X%`_shape(F64_lanetype, `%`_dim(2)), `%X%`_shape(I32_lanetype, `%`_dim(4)), CONVERT_vcvtop__(?(LOW_half), U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.extadd_pairwise_i8x16_s" => VEXTUNOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), EXTADD_PAIRWISE_vextunop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.extadd_pairwise_i8x16_u" => VEXTUNOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), EXTADD_PAIRWISE_vextunop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.extadd_pairwise_i16x8_s" => VEXTUNOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), EXTADD_PAIRWISE_vextunop__(S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.extadd_pairwise_i16x8_u" => VEXTUNOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), EXTADD_PAIRWISE_vextunop__(U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.extmul_low_i8x16_s" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), EXTMUL_vextbinop__(LOW_half, S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.extmul_low_i8x16_u" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), EXTMUL_vextbinop__(LOW_half, U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.extmul_high_i8x16_s" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), EXTMUL_vextbinop__(HIGH_half, S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i16x8.extmul_high_i8x16_u" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `%`_ishape(`%X%`_shape(I8_lanetype, `%`_dim(16))), EXTMUL_vextbinop__(HIGH_half, U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.extmul_low_i16x8_s" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), EXTMUL_vextbinop__(LOW_half, S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.extmul_low_i16x8_u" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), EXTMUL_vextbinop__(LOW_half, U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.extmul_high_i16x8_s" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), EXTMUL_vextbinop__(HIGH_half, S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.extmul_high_i16x8_u" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), EXTMUL_vextbinop__(HIGH_half, U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i32x4.dot_i16x8_s" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), `%`_ishape(`%X%`_shape(I16_lanetype, `%`_dim(8))), `DOTS`_vextbinop__)
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.extmul_low_i32x4_s" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), `%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), EXTMUL_vextbinop__(LOW_half, S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.extmul_low_i32x4_u" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), `%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), EXTMUL_vextbinop__(LOW_half, U_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.extmul_high_i32x4_s" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), `%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), EXTMUL_vextbinop__(HIGH_half, S_sx))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod "i64x2.extmul_high_i32x4_u" => VEXTBINOP_instr(`%`_ishape(`%X%`_shape(I64_lanetype, `%`_dim(2))), `%`_ishape(`%X%`_shape(I32_lanetype, `%`_dim(4))), EXTMUL_vextbinop__(HIGH_half, U_sx))

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
rec {

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec:15.1-17.29
grammar Tinstr_(I : I) : instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec:16.5-16.29
  prod{in : instr} in:Tplaininstr_(I) => in
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec:17.5-17.29
  prod{in : instr} in:Tblockinstr_(I) => in

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec:23.1-24.52
grammar Tinstrs_(I : I) : instr*
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec:20.5-20.27
  prod{`in*` : instr*} in*{in <- `in*`}:Tinstr_(I)*{} => in*{in <- `in*`}
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec:24.5-24.52
  prod{`in**` : instr**} in*{in <- `in*`}*{`in*` <- `in**`}:Tfoldedinstr_(I)*{} => $concat_(syntax instr, in*{in <- `in*`}*{`in*` <- `in**`})

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec:88.1-90.65
grammar Tblockinstr_(I : I) : instr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec:63.5-67.35
  prod{`id?` : char?, I' : I, bt : blocktype, `in*` : instr*, `id'?` : char?} {{"block"} {(?(`%`_name(lift(id?{id <- `id?`}))), I'):Tlabel_(I)} {bt:Tblocktype_(I)} {in*{in <- `in*`}:Tinstrs_(I')} {"end"} {?(`%`_name(lift(id'?{id' <- `id'?`}))):Tid?{}}} => BLOCK_instr(bt, in*{in <- `in*`})
    -- if ((id'?{id' <- `id'?`} = ?()) \/ (id'?{id' <- `id'?`} = id?{id <- `id?`}))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec:68.5-72.35
  prod{`id?` : char?, I' : I, bt : blocktype, `in*` : instr*, `id'?` : char?} {{"loop"} {(?(`%`_name(lift(id?{id <- `id?`}))), I'):Tlabel_(I)} {bt:Tblocktype_(I)} {in*{in <- `in*`}:Tinstrs_(I')} {"end"} {?(`%`_name(lift(id'?{id' <- `id'?`}))):Tid?{}}} => LOOP_instr(bt, in*{in <- `in*`})
    -- if ((id'?{id' <- `id'?`} = ?()) \/ (id'?{id' <- `id'?`} = id?{id <- `id?`}))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec:73.5-79.71
  prod{`id?` : char?, I' : I, bt : blocktype, `in_1*` : instr*, `id_1?` : char?, `in_2*` : instr*, `id_2?` : char?} {{"if"} {(?(`%`_name(lift(id?{id <- `id?`}))), I'):Tlabel_(I)} {bt:Tblocktype_(I)} {in_1*{in_1 <- `in_1*`}:Tinstrs_(I')} {"else"} {?(`%`_name(lift(id_1?{id_1 <- `id_1?`}))):Tid?{}} {in_2*{in_2 <- `in_2*`}:Tinstrs_(I')} {"end"} {?(`%`_name(lift(id_2?{id_2 <- `id_2?`}))):Tid?{}}} => `IF%%ELSE%`_instr(bt, in_1*{in_1 <- `in_1*`}, in_2*{in_2 <- `in_2*`})
    -- if (((id_1?{id_1 <- `id_1?`} = ?()) \/ (id_1?{id_1 <- `id_1?`} = id?{id <- `id?`})) /\ ((id_2?{id_2 <- `id_2?`} = ?()) \/ (id_2?{id_2 <- `id_2?`} = id?{id <- `id?`})))
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec:80.5-85.35
  prod{`id?` : char?, I' : I, bt : blocktype, `c*` : catch*, `in*` : instr*, `id'?` : char?} {{"try_table"} {(?(`%`_name(lift(id?{id <- `id?`}))), I'):Tlabel_(I)} {bt:Tblocktype_(I)} {c*{c <- `c*`}:Tcatch_(I)*{}} {in*{in <- `in*`}:Tinstrs_(I')} {"end"} {?(`%`_name(lift(id'?{id' <- `id'?`}))):Tid?{}}} => TRY_TABLE_instr(bt, `%`_list(c*{c <- `c*`}), in*{in <- `in*`})
    -- if ((id'?{id' <- `id'?`} = ?()) \/ (id'?{id' <- `id'?`} = id?{id <- `id?`}))
}

;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
grammar Texpr_(I : I) : expr
  ;; ../../../../specification/wasm-3.0/6.3-text.instructions.spectec
  prod{`in*` : instr*} in*{in <- `in*`}:Tinstrs_(I) => in*{in <- `in*`}

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Ttype_(I : I) : (type, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{qt : rectype, I' : I, I'' : I, `st*` : subtype*, n : n, `i*` : nat*} (qt, I'):Trectype_(I) => (TYPE_type(qt), I' +++ I'')
    -- if (qt = REC_rectype(`%`_list(st^n{st <- `st*`})))
    -- if (I'' = {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS ?(_DEF_deftype(qt, i))^(i<n){i <- `i*`}})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Ttag_(I : I) : (tag, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`id?` : char?, jt : tagtype} {{"("} {"tag"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {jt:Ttagtype_(I)} {")"}} => (TAG_tag(jt), {TYPES [], TAGS [?(`%`_name(lift(id?{id <- `id?`})))], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Tglobal_(I : I) : (global, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`id?` : char?, gt : globaltype, e : expr} {{"("} {"global"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {gt:Tglobaltype_(I)} {e:Texpr_(I)} {")"}} => (GLOBAL_global(gt, e), {TYPES [], TAGS [], GLOBALS [?(`%`_name(lift(id?{id <- `id?`})))], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Tmem_(I : I) : (mem, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`id?` : char?, mt : memtype} {{"("} {"memory"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {mt:Tmemtype_(I)} {")"}} => (MEMORY_mem(mt), {TYPES [], TAGS [], GLOBALS [], MEMS [?(`%`_name(lift(id?{id <- `id?`})))], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Ttable_(I : I) : (table, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`id?` : char?, tt : tabletype, e : expr} {{"("} {"table"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {tt:Ttabletype_(I)} {e:Texpr_(I)} {")"}} => (TABLE_table(tt, e), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [?(`%`_name(lift(id?{id <- `id?`})))], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Tlocal_(I : I) : (local*, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`id?` : char?, t : valtype} {{"("} {"local"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {t:Tvaltype_(I)} {")"}} => ([LOCAL_local(t)], {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [?(`%`_name(lift(id?{id <- `id?`})))], LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Tfunc_(I : I) : (func, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`id?` : char?, x : idx, I_1 : I, `loc**` : local**, `I_2*` : I*, e : expr, I' : I} {{"("} {"func"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {(x, I_1):Ttypeuse_(I)} {(loc*{loc <- `loc*`}, I_2):Tlocal_(I)*{I_2 <- `I_2*`, `loc*` <- `loc**`}} {e:Texpr_(I')} {")"}} => (FUNC_func(x, $concat_(syntax local, loc*{loc <- `loc*`}*{`loc*` <- `loc**`}), e), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [?(`%`_name(lift(id?{id <- `id?`})))], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})
    -- if (I' = I +++ I_1 +++ $concat_idctxt(I_2*{I_2 <- `I_2*`}))
    -- Idctxt_ok: `|-%:OK`(I')

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Tdatastring : byte*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`b**` : byte**} b*{b <- `b*`}*{`b*` <- `b**`}:Tstring*{} => $concat_(syntax byte, b*{b <- `b*`}*{`b*` <- `b**`})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Tmemuse_(I : I) : memidx
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{x : idx} {{"("} {"memory"} {x:Tmemidx_(I)} {")"}} => x

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Toffset_(I : I) : expr
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{e : expr} {{"("} {"offset"} {e:Texpr_(I)} {")"}} => e

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Tdata_(I : I) : (data, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`id?` : char?, `b*` : byte*} {{"("} {"data"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {b*{b <- `b*`}:Tdatastring} {")"}} => (DATA_data(b*{b <- `b*`}, PASSIVE_datamode), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [?(`%`_name(lift(id?{id <- `id?`})))], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`id?` : char?, x : idx, e : expr, `b*` : byte*} {{"("} {"data"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {x:Tmemuse_(I)} {e:Toffset_(I)} {b*{b <- `b*`}:Tdatastring} {")"}} => (DATA_data(b*{b <- `b*`}, ACTIVE_datamode(x, e)), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [?(`%`_name(lift(id?{id <- `id?`})))], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Telemlist_(I : I) : (reftype, expr*)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{rt : reftype, `e*` : expr*} {{rt:Treftype_(I)} {e*{e <- `e*`}:Tlist(syntax expr, grammar Texpr_(I))}} => (rt, e*{e <- `e*`})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Ttableuse_(I : I) : tableidx
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{x : idx} {{"("} {"table"} {x:Ttableidx_(I)} {")"}} => x

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Telem_(I : I) : (elem, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`id?` : char?, rt : reftype, `e*` : expr*} {{"("} {"elem"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {(rt, e*{e <- `e*`}):Telemlist_(I)} {")"}} => (ELEM_elem(rt, e*{e <- `e*`}, PASSIVE_elemmode), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [?(`%`_name(lift(id?{id <- `id?`})))], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`id?` : char?, x : idx, e' : expr, rt : reftype, `e*` : expr*} {{"("} {"elem"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {x:Ttableuse_(I)} {e':Toffset_(I)} {(rt, e*{e <- `e*`}):Telemlist_(I)} {")"}} => (ELEM_elem(rt, e*{e <- `e*`}, ACTIVE_elemmode(x, e')), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [?(`%`_name(lift(id?{id <- `id?`})))], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`id?` : char?, rt : reftype, `e*` : expr*} {{"("} {"elem"} {?(`%`_name(lift(id?{id <- `id?`}))):Tid?{}} {"declare"} {(rt, e*{e <- `e*`}):Telemlist_(I)} {")"}} => (ELEM_elem(rt, e*{e <- `e*`}, DECLARE_elemmode), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [?(`%`_name(lift(id?{id <- `id?`})))], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Telemexpr_(I : I) : expr
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{e : expr} {{"("} {"item"} {e:Texpr_(I)} {")"}} => e

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Tstart_(I : I) : (start, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{x : idx} {{"("} {"start"} {x:Tfuncidx_(I)} {")"}} => (START_start(x), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Timport_(I : I) : (import, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{nm_1 : name, nm_2 : name, xt : externtype, I' : I} {{"("} {"import"} {nm_1:Tname} {nm_2:Tname} {(xt, I'):Texterntype_(I)} {")"}} => (IMPORT_import(nm_1, nm_2, xt), I')

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Texport_(I : I) : (export, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{nm : name, xx : externidx} {{"("} {"export"} {nm:Tname} {xx:Texternidx_(I)} {")"}} => (EXPORT_export(nm, xx), {TYPES [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [], FIELDS [], TYPEDEFS []})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Texportdots : ()
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{"("} {"export"} {Tname} {")"}} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Timportdots : ()
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{"("} {"import"} {Tname} {Tname} {")"}} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
def $dots : ()

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Texporttagdots_(I : I) : ()
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{Texportdots*{}} {Ttagtype_(I)}} => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{Texportdots*{}} Timportdots {Ttagtype_(I)}} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Texportglobaldots_(I : I) : ()
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{Texportdots*{}} {Tglobaltype_(I)} {Texpr_(I)}} => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{Texportdots*{}} Timportdots {Tglobaltype_(I)}} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Texportmemdots_(I : I) : ()
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{Texportdots*{}} {Tmemtype_(I)}} => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{Texportdots*{}} {Taddrtype?{}} {"("} {"data"} {Tdatastring} {")"}} => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{Texportdots*{}} Timportdots {Tmemtype_(I)}} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Texporttabledots_(I : I) : ()
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{Texportdots*{}} {Ttabletype_(I)} {Texpr_(I)?{}}} => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{Texportdots*{}} {Taddrtype?{}} {Treftype_(I)} {"("} {"elem"} {Telemlist_(I)} {")"}} => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{Texportdots*{}} Timportdots {Ttabletype_(I)}} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Texportfuncdots_(I : I) : ()
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{Texportdots*{}} {Ttypeuse_(I)} {Tlocal_(I)*{}} {Texpr_(I)}} => (`<implicit-prod-result>`, ()).1
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:{{Texportdots*{}} Timportdots {Ttypeuse_(I)}} => (`<implicit-prod-result>`, ()).1

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Texporttag_(I : I) : ()

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Texportglobal_(I : I) : ()

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Texportmem_(I : I) : ()

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Texporttable_(I : I) : ()

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Texportfunc_(I : I) : ()

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Tdatamem_(I : I) : ()

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Telemtable_(I : I) : ()

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
syntax decl = 
  | TYPE{rectype : rectype}(rectype : rectype)
  | IMPORT{name : name, externtype : externtype}(name : name, name, externtype : externtype)
  | TAG{tagtype : tagtype}(tagtype : tagtype)
  | GLOBAL{globaltype : globaltype, expr : expr}(globaltype : globaltype, expr : expr)
  | MEMORY{memtype : memtype}(memtype : memtype)
  | TABLE{tabletype : tabletype, expr : expr}(tabletype : tabletype, expr : expr)
  | FUNC{typeidx : typeidx, `local*` : local*, expr : expr}(typeidx : typeidx, local*{local <- `local*`} : local*, expr : expr)
  | DATA{`byte*` : byte*, datamode : datamode}(byte*{byte <- `byte*`} : byte*, datamode : datamode)
  | ELEM{reftype : reftype, `expr*` : expr*, elemmode : elemmode}(reftype : reftype, expr*{expr <- `expr*`} : expr*, elemmode : elemmode)
  | START{funcidx : funcidx}(funcidx : funcidx)
  | EXPORT{name : name, externidx : externidx}(name : name, externidx : externidx)

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:258.1-258.76
def $typesd(decl*) : type*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:270.1-270.23
  def $typesd([]) = []
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:271.1-271.48
  def $typesd{type : type, `decl'*` : decl*}([(type : type <: decl)] ++ decl'*{decl' <- `decl'*`}) = [type] ++ $typesd(decl'*{decl' <- `decl'*`})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:272.1-272.57
  def $typesd{decl : decl, `decl'*` : decl*}([decl] ++ decl'*{decl' <- `decl'*`}) = $typesd(decl'*{decl' <- `decl'*`})
}

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:259.1-259.78
def $importsd(decl*) : import*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:274.1-274.25
  def $importsd([]) = []
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:275.1-275.56
  def $importsd{import : import, `decl'*` : decl*}([(import : import <: decl)] ++ decl'*{decl' <- `decl'*`}) = [import] ++ $importsd(decl'*{decl' <- `decl'*`})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:276.1-276.61
  def $importsd{decl : decl, `decl'*` : decl*}([decl] ++ decl'*{decl' <- `decl'*`}) = $importsd(decl'*{decl' <- `decl'*`})
}

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:260.1-260.75
def $tagsd(decl*) : tag*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:278.1-278.22
  def $tagsd([]) = []
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:279.1-279.44
  def $tagsd{tag : tag, `decl'*` : decl*}([(tag : tag <: decl)] ++ decl'*{decl' <- `decl'*`}) = [tag] ++ $tagsd(decl'*{decl' <- `decl'*`})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:280.1-280.55
  def $tagsd{decl : decl, `decl'*` : decl*}([decl] ++ decl'*{decl' <- `decl'*`}) = $tagsd(decl'*{decl' <- `decl'*`})
}

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:261.1-261.78
def $globalsd(decl*) : global*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:282.1-282.25
  def $globalsd([]) = []
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:283.1-283.56
  def $globalsd{global : global, `decl'*` : decl*}([(global : global <: decl)] ++ decl'*{decl' <- `decl'*`}) = [global] ++ $globalsd(decl'*{decl' <- `decl'*`})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:284.1-284.61
  def $globalsd{decl : decl, `decl'*` : decl*}([decl] ++ decl'*{decl' <- `decl'*`}) = $globalsd(decl'*{decl' <- `decl'*`})
}

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:262.1-262.75
def $memsd(decl*) : mem*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:286.1-286.22
  def $memsd([]) = []
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:287.1-287.44
  def $memsd{mem : mem, `decl'*` : decl*}([(mem : mem <: decl)] ++ decl'*{decl' <- `decl'*`}) = [mem] ++ $memsd(decl'*{decl' <- `decl'*`})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:288.1-288.55
  def $memsd{decl : decl, `decl'*` : decl*}([decl] ++ decl'*{decl' <- `decl'*`}) = $memsd(decl'*{decl' <- `decl'*`})
}

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:263.1-263.77
def $tablesd(decl*) : table*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:290.1-290.24
  def $tablesd([]) = []
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:291.1-291.52
  def $tablesd{table : table, `decl'*` : decl*}([(table : table <: decl)] ++ decl'*{decl' <- `decl'*`}) = [table] ++ $tablesd(decl'*{decl' <- `decl'*`})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:292.1-292.59
  def $tablesd{decl : decl, `decl'*` : decl*}([decl] ++ decl'*{decl' <- `decl'*`}) = $tablesd(decl'*{decl' <- `decl'*`})
}

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:264.1-264.76
def $funcsd(decl*) : func*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:294.1-294.23
  def $funcsd([]) = []
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:295.1-295.48
  def $funcsd{func : func, `decl'*` : decl*}([(func : func <: decl)] ++ decl'*{decl' <- `decl'*`}) = [func] ++ $funcsd(decl'*{decl' <- `decl'*`})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:296.1-296.57
  def $funcsd{decl : decl, `decl'*` : decl*}([decl] ++ decl'*{decl' <- `decl'*`}) = $funcsd(decl'*{decl' <- `decl'*`})
}

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:265.1-265.76
def $datasd(decl*) : data*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:298.1-298.23
  def $datasd([]) = []
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:299.1-299.48
  def $datasd{data : data, `decl'*` : decl*}([(data : data <: decl)] ++ decl'*{decl' <- `decl'*`}) = [data] ++ $datasd(decl'*{decl' <- `decl'*`})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:300.1-300.57
  def $datasd{decl : decl, `decl'*` : decl*}([decl] ++ decl'*{decl' <- `decl'*`}) = $datasd(decl'*{decl' <- `decl'*`})
}

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:266.1-266.76
def $elemsd(decl*) : elem*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:302.1-302.23
  def $elemsd([]) = []
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:303.1-303.48
  def $elemsd{elem : elem, `decl'*` : decl*}([(elem : elem <: decl)] ++ decl'*{decl' <- `decl'*`}) = [elem] ++ $elemsd(decl'*{decl' <- `decl'*`})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:304.1-304.57
  def $elemsd{decl : decl, `decl'*` : decl*}([decl] ++ decl'*{decl' <- `decl'*`}) = $elemsd(decl'*{decl' <- `decl'*`})
}

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:267.1-267.77
def $startsd(decl*) : start*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:306.1-306.24
  def $startsd([]) = []
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:307.1-307.52
  def $startsd{start : start, `decl'*` : decl*}([(start : start <: decl)] ++ decl'*{decl' <- `decl'*`}) = [start] ++ $startsd(decl'*{decl' <- `decl'*`})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:308.1-308.59
  def $startsd{decl : decl, `decl'*` : decl*}([decl] ++ decl'*{decl' <- `decl'*`}) = $startsd(decl'*{decl' <- `decl'*`})
}

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
rec {

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:268.1-268.78
def $exportsd(decl*) : export*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:310.1-310.25
  def $exportsd([]) = []
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:311.1-311.56
  def $exportsd{export : export, `decl'*` : decl*}([(export : export <: decl)] ++ decl'*{decl' <- `decl'*`}) = [export] ++ $exportsd(decl'*{decl' <- `decl'*`})
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec:312.1-312.61
  def $exportsd{decl : decl, `decl'*` : decl*}([decl] ++ decl'*{decl' <- `decl'*`}) = $exportsd(decl'*{decl' <- `decl'*`})
}

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
def $ordered(decl*) : bool
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  def $ordered{`decl'*` : decl*}(decl'*{decl' <- `decl'*`}) = true
    -- if ($importsd(decl'*{decl' <- `decl'*`}) = [])
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  def $ordered{`decl_1*` : decl*, import : import, `decl_2*` : decl*}(decl_1*{decl_1 <- `decl_1*`} ++ [(import : import <: decl)] ++ decl_2*{decl_2 <- `decl_2*`}) = (((((($importsd(decl_1*{decl_1 <- `decl_1*`}) = []) /\ ($tagsd(decl_1*{decl_1 <- `decl_1*`}) = [])) /\ ($globalsd(decl_1*{decl_1 <- `decl_1*`}) = [])) /\ ($memsd(decl_1*{decl_1 <- `decl_1*`}) = [])) /\ ($tablesd(decl_1*{decl_1 <- `decl_1*`}) = [])) /\ ($funcsd(decl_1*{decl_1 <- `decl_1*`}) = []))

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Tdecl_(I : I) : (decl, idctxt)
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : (type, idctxt)} `<implicit-prod-result>`:Ttype_(I) => (`<implicit-prod-result>` : (type, idctxt) <: (decl, idctxt))
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : (import, idctxt)} `<implicit-prod-result>`:Timport_(I) => (`<implicit-prod-result>` : (import, idctxt) <: (decl, idctxt))
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : (tag, idctxt)} `<implicit-prod-result>`:Ttag_(I) => (`<implicit-prod-result>` : (tag, idctxt) <: (decl, idctxt))
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : (global, idctxt)} `<implicit-prod-result>`:Tglobal_(I) => (`<implicit-prod-result>` : (global, idctxt) <: (decl, idctxt))
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : (mem, idctxt)} `<implicit-prod-result>`:Tmem_(I) => (`<implicit-prod-result>` : (mem, idctxt) <: (decl, idctxt))
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : (table, idctxt)} `<implicit-prod-result>`:Ttable_(I) => (`<implicit-prod-result>` : (table, idctxt) <: (decl, idctxt))
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : (func, idctxt)} `<implicit-prod-result>`:Tfunc_(I) => (`<implicit-prod-result>` : (func, idctxt) <: (decl, idctxt))
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : (data, idctxt)} `<implicit-prod-result>`:Tdata_(I) => (`<implicit-prod-result>` : (data, idctxt) <: (decl, idctxt))
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : (elem, idctxt)} `<implicit-prod-result>`:Telem_(I) => (`<implicit-prod-result>` : (elem, idctxt) <: (decl, idctxt))
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : (start, idctxt)} `<implicit-prod-result>`:Tstart_(I) => (`<implicit-prod-result>` : (start, idctxt) <: (decl, idctxt))
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : (export, idctxt)} `<implicit-prod-result>`:Texport_(I) => (`<implicit-prod-result>` : (export, idctxt) <: (decl, idctxt))

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Tmodule : module
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`decl*` : decl*, `I*` : I*, I' : I, `type*` : type*, `import*` : import*, `tag*` : tag*, `global*` : global*, `mem*` : mem*, `table*` : table*, `func*` : func*, `data*` : data*, `elem*` : elem*, `start?` : start?, `export*` : export*} {{"("} {"module"} {Tid?{}} {(decl, I)*{I <- `I*`, decl <- `decl*`}:Tdecl_(I')*{}} {")"}} => MODULE_module(type*{type <- `type*`}, import*{import <- `import*`}, tag*{tag <- `tag*`}, global*{global <- `global*`}, mem*{mem <- `mem*`}, table*{table <- `table*`}, func*{func <- `func*`}, data*{data <- `data*`}, elem*{elem <- `elem*`}, start?{start <- `start?`}, export*{export <- `export*`})
    -- if (I' = $concat_idctxt(I*{I <- `I*`}))
    -- Idctxt_ok: `|-%:OK`(I')
    -- if (type*{type <- `type*`} = $typesd(decl*{decl <- `decl*`}))
    -- if (import*{import <- `import*`} = $importsd(decl*{decl <- `decl*`}))
    -- if (tag*{tag <- `tag*`} = $tagsd(decl*{decl <- `decl*`}))
    -- if (global*{global <- `global*`} = $globalsd(decl*{decl <- `decl*`}))
    -- if (mem*{mem <- `mem*`} = $memsd(decl*{decl <- `decl*`}))
    -- if (table*{table <- `table*`} = $tablesd(decl*{decl <- `decl*`}))
    -- if (func*{func <- `func*`} = $funcsd(decl*{decl <- `decl*`}))
    -- if (data*{data <- `data*`} = $datasd(decl*{decl <- `decl*`}))
    -- if (elem*{elem <- `elem*`} = $elemsd(decl*{decl <- `decl*`}))
    -- if (lift(start?{start <- `start?`}) = $startsd(decl*{decl <- `decl*`}))
    -- if (export*{export <- `export*`} = $exportsd(decl*{decl <- `decl*`}))
    -- if $ordered(decl*{decl <- `decl*`})

;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
grammar Tdecldots_(I : I) : (decl, idctxt)*
  ;; ../../../../specification/wasm-3.0/6.3-text.modules.spectec
  prod{`<implicit-prod-result>` : (decl, idctxt)} [`<implicit-prod-result>`]:Tdecl_(I)*{} => [`<implicit-prod-result>`]

;; ../../../../specification/wasm-3.0/X.1-notation.syntax.spectec
syntax A = nat

;; ../../../../specification/wasm-3.0/X.1-notation.syntax.spectec
syntax B = nat

;; ../../../../specification/wasm-3.0/X.1-notation.syntax.spectec
syntax sym = 
  | _FIRST{A_1 : A}(A_1 : A)
  | _DOTS
  | _LAST{A_n : A}(A_n : A)

;; ../../../../specification/wasm-3.0/X.1-notation.syntax.spectec
syntax symsplit = 
  | _FIRST{A_1 : A}(A_1 : A)
  | _LAST{A_2 : A}(A_2 : A)

;; ../../../../specification/wasm-3.0/X.1-notation.syntax.spectec
syntax recorddots = ()

;; ../../../../specification/wasm-3.0/X.1-notation.syntax.spectec
syntax record = 
{
  FIELD_1{A_1 : A} A,
  FIELD_2{A_2 : A} A,
  `...`{recorddots : recorddots} recorddots
}

;; ../../../../specification/wasm-3.0/X.1-notation.syntax.spectec
syntax pth = 
  | PTHSYNTAX

;; ../../../../specification/wasm-3.0/X.2-notation.typing.spectec
syntax T = nat

;; ../../../../specification/wasm-3.0/X.2-notation.typing.spectec
relation NotationTypingPremise: `%`(nat)

;; ../../../../specification/wasm-3.0/X.2-notation.typing.spectec
relation NotationTypingPremisedots: `...`

;; ../../../../specification/wasm-3.0/X.2-notation.typing.spectec
relation NotationTypingScheme: `%`(nat)
  ;; ../../../../specification/wasm-3.0/X.2-notation.typing.spectec
  rule _{conclusion : nat, premise_1 : nat, premise_2 : nat, premise_n : nat}:
    `%`(conclusion)
    -- NotationTypingPremise: `%`(premise_1)
    -- NotationTypingPremise: `%`(premise_2)
    -- NotationTypingPremisedots: `...`
    -- NotationTypingPremise: `%`(premise_n)

;; ../../../../specification/wasm-3.0/X.2-notation.typing.spectec
rec {

;; ../../../../specification/wasm-3.0/X.2-notation.typing.spectec:20.1-20.83
relation NotationTypingInstrScheme: `%|-%:%`(context, instr*, instrtype)
  ;; ../../../../specification/wasm-3.0/X.2-notation.typing.spectec:22.1-23.38
  rule i32.add{C : context}:
    `%|-%:%`(C, [BINOP_instr(I32_numtype, ADD_binop_)], `%->_%%`_instrtype(`%`_resulttype([I32_valtype I32_valtype]), [], `%`_resulttype([I32_valtype])))

  ;; ../../../../specification/wasm-3.0/X.2-notation.typing.spectec:25.1-27.29
  rule global.get{C : context, x : idx, t : valtype, mut : mut}:
    `%|-%:%`(C, [GLOBAL.GET_instr(x)], `%->_%%`_instrtype(`%`_resulttype([]), [], `%`_resulttype([t])))
    -- if (C.GLOBALS_context[x!`%`_idx.0] = `%%`_globaltype(?(mut), t))

  ;; ../../../../specification/wasm-3.0/X.2-notation.typing.spectec:29.1-32.78
  rule block{C : context, blocktype : blocktype, `instr*` : instr*, `t_1*` : valtype*, `t_2*` : valtype*}:
    `%|-%:%`(C, [BLOCK_instr(blocktype, instr*{instr <- `instr*`})], `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- Blocktype_ok: `%|-%:%`(C, blocktype, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
    -- NotationTypingInstrScheme: `%|-%:%`({TYPES [], RECS [], TAGS [], GLOBALS [], MEMS [], TABLES [], FUNCS [], DATAS [], ELEMS [], LOCALS [], LABELS [`%`_resulttype(t_2*{t_2 <- `t_2*`})], RETURN ?(), REFS []} +++ C, instr*{instr <- `instr*`}, `%->_%%`_instrtype(`%`_resulttype(t_1*{t_1 <- `t_1*`}), [], `%`_resulttype(t_2*{t_2 <- `t_2*`})))
}

;; ../../../../specification/wasm-3.0/X.3-notation.execution.spectec
relation NotationReduct: `~>%`(instr*)
  ;; ../../../../specification/wasm-3.0/X.3-notation.execution.spectec
  rule 2{q_1 : num_(F64_numtype), q_4 : num_(F64_numtype), q_3 : num_(F64_numtype)}:
    `~>%`([CONST_instr(F64_numtype, q_1) CONST_instr(F64_numtype, q_4) CONST_instr(F64_numtype, q_3) BINOP_instr(F64_numtype, ADD_binop_) BINOP_instr(F64_numtype, MUL_binop_)])

  ;; ../../../../specification/wasm-3.0/X.3-notation.execution.spectec
  rule 3{q_1 : num_(F64_numtype), q_5 : num_(F64_numtype)}:
    `~>%`([CONST_instr(F64_numtype, q_1) CONST_instr(F64_numtype, q_5) BINOP_instr(F64_numtype, MUL_binop_)])

  ;; ../../../../specification/wasm-3.0/X.3-notation.execution.spectec
  rule 4{q_6 : num_(F64_numtype)}:
    `~>%`([CONST_instr(F64_numtype, q_6)])

;; ../../../../specification/wasm-3.0/X.3-notation.execution.spectec
def $instrdots : instr*

;; ../../../../specification/wasm-3.0/X.3-notation.execution.spectec
syntax label = 
  | `LABEL_%{%}`{n : n, `instr*` : instr*}(n : n, instr*{instr <- `instr*`} : instr*)

;; ../../../../specification/wasm-3.0/X.3-notation.execution.spectec
syntax callframe = 
  | `FRAME_%{%}`{n : n, frame : frame}(n : n, frame : frame)

;; ../../../../specification/wasm-3.0/X.3-notation.execution.spectec
def $allocX(syntax X, syntax Y, store : store, X : X, Y : Y) : (store, addr)

;; ../../../../specification/wasm-3.0/X.3-notation.execution.spectec
rec {

;; ../../../../specification/wasm-3.0/X.3-notation.execution.spectec:32.1-32.117
def $allocXs(syntax X, syntax Y, store : store, X*, Y*) : (store, addr*)
  ;; ../../../../specification/wasm-3.0/X.3-notation.execution.spectec:33.1-33.57
  def $allocXs{syntax X, syntax Y, s : store}(syntax X, syntax Y, s, [], []) = (s, [])
  ;; ../../../../specification/wasm-3.0/X.3-notation.execution.spectec:34.1-36.65
  def $allocXs{syntax X, syntax Y, s : store, X : X, `X'*` : X*, Y : Y, `Y'*` : Y*, s_2 : store, a : addr, `a'*` : addr*, s_1 : store}(syntax X, syntax Y, s, [X] ++ X'*{X' <- `X'*`}, [Y] ++ Y'*{Y' <- `Y'*`}) = (s_2, [a] ++ a'*{a' <- `a'*`})
    -- if ((s_1, a) = $allocX(syntax X, syntax Y, s, X, Y))
    -- if ((s_2, a'*{a' <- `a'*`}) = $allocXs(syntax X, syntax Y, s_1, X'*{X' <- `X'*`}, Y'*{Y' <- `Y'*`}))
}

;; ../../../../specification/wasm-3.0/X.4-notation.binary.spectec
syntax symdots = 
  | `%`{i : nat}(i : nat)
    -- if (i = 0)

;; ../../../../specification/wasm-3.0/X.4-notation.binary.spectec
def $var(syntax X) : nat
  ;; ../../../../specification/wasm-3.0/X.4-notation.binary.spectec
  def $var{syntax X}(syntax X) = 0

;; ../../../../specification/wasm-3.0/X.4-notation.binary.spectec
grammar Bvar(syntax X) : ()
  ;; ../../../../specification/wasm-3.0/X.4-notation.binary.spectec
  prod 0x00 => ()

;; ../../../../specification/wasm-3.0/X.4-notation.binary.spectec
grammar Bsym : A
  ;; ../../../../specification/wasm-3.0/X.4-notation.binary.spectec
  prod Bvar(syntax B) => $var(syntax A)
  ;; ../../../../specification/wasm-3.0/X.4-notation.binary.spectec
  prod (Bvar(syntax symdots) | Bvar(syntax B)) => $var(syntax A)

;; ../../../../specification/wasm-3.0/X.4-notation.binary.spectec
grammar Bsymsplit : ()
  ;; ../../../../specification/wasm-3.0/X.4-notation.binary.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:Bvar(syntax B) => `<implicit-prod-result>`
  ;; ../../../../specification/wasm-3.0/X.4-notation.binary.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:Bvar(syntax B) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/X.5-notation.text.spectec
grammar Tvar(syntax X) : ()
  ;; ../../../../specification/wasm-3.0/X.5-notation.text.spectec
  prod 0x00 => ()

;; ../../../../specification/wasm-3.0/X.5-notation.text.spectec
grammar Tsym : A
  ;; ../../../../specification/wasm-3.0/X.5-notation.text.spectec
  prod Tvar(syntax T) => $var(syntax A)
  ;; ../../../../specification/wasm-3.0/X.5-notation.text.spectec
  prod (Tvar(syntax symdots) | Tvar(syntax T)) => $var(syntax A)

;; ../../../../specification/wasm-3.0/X.5-notation.text.spectec
grammar Tsymsplit : ()
  ;; ../../../../specification/wasm-3.0/X.5-notation.text.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:Tvar(syntax B) => `<implicit-prod-result>`
  ;; ../../../../specification/wasm-3.0/X.5-notation.text.spectec
  prod{`<implicit-prod-result>` : ()} `<implicit-prod-result>`:Tvar(syntax B) => `<implicit-prod-result>`

;; ../../../../specification/wasm-3.0/X.5-notation.text.spectec
syntax abbreviated = ()

;; ../../../../specification/wasm-3.0/X.5-notation.text.spectec
syntax expanded = ()

;; ../../../../specification/wasm-3.0/X.5-notation.text.spectec
syntax syntax = ()

;; ../../../../specification/wasm-3.0/X.5-notation.text.spectec
grammar Tabbrev : ()

