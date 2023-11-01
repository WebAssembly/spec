# Preview

```sh
$ (cd ../spec && dune exec ../src/exe-watsup/main.exe -- *.watsup -v -l --print-il --check)
watsup 0.4 generator
== Parsing...
== Elaboration...

;; 0-aux.watsup:12.1-12.15
syntax n = nat

;; 0-aux.watsup:17.1-17.14
def Ki : nat
  ;; 0-aux.watsup:18.1-18.15
  def Ki = 1024

;; 0-aux.watsup:23.1-23.25
rec {

;; 0-aux.watsup:23.1-23.25
def min : (nat, nat) -> nat
  ;; 0-aux.watsup:24.1-24.19
  def {j : nat} min(0, j) = 0
  ;; 0-aux.watsup:25.1-25.19
  def {i : nat} min(i, 0) = 0
  ;; 0-aux.watsup:26.1-26.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 0-aux.watsup:34.1-34.40
def test_sub_ATOM_22 : n -> nat
  ;; 0-aux.watsup:35.1-35.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 0-aux.watsup:37.1-37.26
def curried_ : (n, n) -> nat
  ;; 0-aux.watsup:38.1-38.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 0-aux.watsup:40.1-49.39
syntax testfuse =
  | AB_(nat, nat, nat)
  | CD(nat, nat, nat)
  | EF(nat, nat, nat)
  | GH(nat, nat, nat)
  | IJ(nat, nat, nat)
  | KL(nat, nat, nat)
  | MN(nat, nat, nat)
  | OP(nat, nat, nat)
  | QR(nat, nat, nat)

;; 1-syntax.watsup:5.1-5.37
syntax name = text

;; 1-syntax.watsup:12.1-12.36
syntax byte = nat

;; 1-syntax.watsup:13.1-13.45
syntax i31 = nat

;; 1-syntax.watsup:14.1-14.45
syntax i32 = nat

;; 1-syntax.watsup:23.1-23.36
syntax idx = i32

;; 1-syntax.watsup:24.1-24.45
syntax typeidx = idx

;; 1-syntax.watsup:25.1-25.49
syntax funcidx = idx

;; 1-syntax.watsup:26.1-26.49
syntax globalidx = idx

;; 1-syntax.watsup:27.1-27.47
syntax tableidx = idx

;; 1-syntax.watsup:28.1-28.46
syntax memidx = idx

;; 1-syntax.watsup:29.1-29.45
syntax elemidx = idx

;; 1-syntax.watsup:30.1-30.45
syntax dataidx = idx

;; 1-syntax.watsup:31.1-31.47
syntax labelidx = idx

;; 1-syntax.watsup:32.1-32.47
syntax localidx = idx

;; 1-syntax.watsup:45.1-45.19
syntax nul = `NULL%?`(()?)

;; 1-syntax.watsup:47.1-48.22
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:50.1-51.5
syntax vectype =
  | V128

;; 1-syntax.watsup:58.1-59.10
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

;; 1-syntax.watsup:83.1-83.18
syntax mut = `MUT%?`(()?)

;; 1-syntax.watsup:84.1-84.20
syntax fin = `FINAL%?`(()?)

;; 1-syntax.watsup:70.1-118.8
rec {

;; 1-syntax.watsup:70.1-71.10
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | REF(nul, heaptype)
  | BOT

;; 1-syntax.watsup:77.1-78.11
syntax resulttype = valtype*

;; 1-syntax.watsup:89.1-90.21
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

;; 1-syntax.watsup:92.1-93.18
syntax fieldtype = `%%`(mut, storagetype)

;; 1-syntax.watsup:95.1-96.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:98.1-101.14
syntax comptype =
  | STRUCT(fieldtype*)
  | ARRAY(fieldtype)
  | FUNC(functype)

;; 1-syntax.watsup:105.1-107.50
syntax subtype =
  | SUB(fin, typeidx*, comptype)
  | SUBD(fin, heaptype*, comptype)

;; 1-syntax.watsup:109.1-110.13
syntax rectype =
  | REC(subtype*)

;; 1-syntax.watsup:115.1-118.8
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
}

;; 1-syntax.watsup:65.1-66.17
syntax reftype =
  | REF(nul, heaptype)

;; 1-syntax.watsup:73.1-73.39
syntax iN =
  | I32
  | I64

;; 1-syntax.watsup:74.1-74.39
syntax fN =
  | F32
  | F64

;; 1-syntax.watsup:86.1-87.9
syntax packedtype =
  | I8
  | I16

;; 1-syntax.watsup:112.1-113.31
syntax deftype =
  | DEF(rectype, nat)

;; 1-syntax.watsup:123.1-124.16
syntax limits = `[%..%]`(i32, i32)

;; 1-syntax.watsup:125.1-126.14
syntax globaltype = `%%`(mut, valtype)

;; 1-syntax.watsup:127.1-128.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:129.1-130.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:131.1-132.10
syntax elemtype = reftype

;; 1-syntax.watsup:133.1-134.5
syntax datatype = OK

;; 1-syntax.watsup:135.1-136.65
syntax externtype =
  | FUNC(deftype)
  | GLOBAL(globaltype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:172.1-172.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:174.1-174.58
syntax unopIXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:175.1-175.89
syntax unopFXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:177.1-179.62
syntax binopIXX =
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

;; 1-syntax.watsup:180.1-180.86
syntax binopFXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:182.1-182.47
syntax testopIXX =
  | EQZ

;; 1-syntax.watsup:183.1-183.43
syntax testopFXX =
  |

;; 1-syntax.watsup:185.1-186.108
syntax relopIXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:187.1-187.69
syntax relopFXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:189.1-189.48
syntax unop_numtype =
  | _I(unopIXX)
  | _F(unopFXX)

;; 1-syntax.watsup:190.1-190.51
syntax binop_numtype =
  | _I(binopIXX)
  | _F(binopFXX)

;; 1-syntax.watsup:191.1-191.54
syntax testop_numtype =
  | _I(testopIXX)
  | _F(testopFXX)

;; 1-syntax.watsup:192.1-192.51
syntax relop_numtype =
  | _I(relopIXX)
  | _F(relopFXX)

;; 1-syntax.watsup:193.1-193.39
syntax cvtop =
  | CONVERT
  | REINTERPRET

;; 1-syntax.watsup:205.1-205.23
syntax c_numtype = nat

;; 1-syntax.watsup:206.1-206.23
syntax c_vectype = nat

;; 1-syntax.watsup:209.1-209.52
syntax blocktype = functype

;; 1-syntax.watsup:279.1-300.89
rec {

;; 1-syntax.watsup:279.1-300.89
syntax instr =
  | UNREACHABLE
  | NOP
  | DROP
  | SELECT(valtype?)
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
  | CALL_REF(typeidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | RETURN_CALL(funcidx)
  | RETURN_CALL_REF(typeidx)
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
  | STRUCT.GET(sx?, typeidx, i32)
  | STRUCT.SET(typeidx, i32)
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
  | EXTERN.INTERNALIZE
  | EXTERN.EXTERNALIZE
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
  | LOAD(numtype, (n, sx)?, memidx, i32, i32)
  | STORE(numtype, n?, memidx, i32, i32)
}

;; 1-syntax.watsup:302.1-303.9
syntax expr = instr*

;; 1-syntax.watsup:312.1-312.50
syntax elemmode =
  | TABLE(tableidx, expr)
  | DECLARE

;; 1-syntax.watsup:313.1-313.39
syntax datamode =
  | MEMORY(memidx, expr)

;; 1-syntax.watsup:315.1-316.15
syntax type = TYPE(rectype)

;; 1-syntax.watsup:317.1-318.16
syntax local = LOCAL(valtype)

;; 1-syntax.watsup:319.1-320.27
syntax func = `FUNC%%*%`(typeidx, local*, expr)

;; 1-syntax.watsup:321.1-322.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:323.1-324.23
syntax table = TABLE(tabletype, expr)

;; 1-syntax.watsup:325.1-326.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:327.1-328.31
syntax elem = `ELEM%%*%?`(reftype, expr*, elemmode?)

;; 1-syntax.watsup:329.1-330.23
syntax data = `DATA%*%?`(byte*, datamode?)

;; 1-syntax.watsup:331.1-332.16
syntax start = START(funcidx)

;; 1-syntax.watsup:334.1-335.62
syntax externuse =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:336.1-337.24
syntax export = EXPORT(name, externuse)

;; 1-syntax.watsup:338.1-339.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:341.1-342.76
syntax module = `MODULE%*%*%*%*%*%*%*%*%?%*`(type*, import*, func*, global*, table*, mem*, elem*, data*, start?, export*)

;; 2-syntax-aux.watsup:8.1-8.33
rec {

;; 2-syntax-aux.watsup:8.1-8.33
def setminus1 : (idx, idx*) -> idx*
  ;; 2-syntax-aux.watsup:13.1-13.31
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
  ;; 2-syntax-aux.watsup:10.1-10.37
  def {y* : idx*} setminus([], y*{y}) = []
  ;; 2-syntax-aux.watsup:11.1-11.66
  def {x* : idx*, x_1 : idx, y* : idx*} setminus([x_1] :: x*{x}, y*{y}) = $setminus1(x_1, y*{y}) :: $setminus(x*{x}, y*{y})
}

;; 2-syntax-aux.watsup:26.1-26.55
def size : valtype -> nat
  ;; 2-syntax-aux.watsup:27.1-27.20
  def size(I32_valtype) = 32
  ;; 2-syntax-aux.watsup:28.1-28.20
  def size(I64_valtype) = 64
  ;; 2-syntax-aux.watsup:29.1-29.20
  def size(F32_valtype) = 32
  ;; 2-syntax-aux.watsup:30.1-30.20
  def size(F64_valtype) = 64
  ;; 2-syntax-aux.watsup:31.1-31.22
  def size(V128_valtype) = 128

;; 2-syntax-aux.watsup:33.1-33.50
def packedsize : packedtype -> nat
  ;; 2-syntax-aux.watsup:34.1-34.24
  def packedsize(I8_packedtype) = 8
  ;; 2-syntax-aux.watsup:35.1-35.26
  def packedsize(I16_packedtype) = 16

;; 2-syntax-aux.watsup:37.1-37.52
def storagesize : storagetype -> nat
  ;; 2-syntax-aux.watsup:38.1-38.43
  def {valtype : valtype} storagesize(valtype <: storagetype) = $size(valtype)
  ;; 2-syntax-aux.watsup:39.1-39.55
  def {packedtype : packedtype} storagesize(packedtype <: storagetype) = $packedsize(packedtype)

;; 2-syntax-aux.watsup:44.1-44.62
def unpacktype : storagetype -> valtype
  ;; 2-syntax-aux.watsup:45.1-45.35
  def {valtype : valtype} unpacktype(valtype <: storagetype) = valtype
  ;; 2-syntax-aux.watsup:46.1-46.34
  def {packedtype : packedtype} unpacktype(packedtype <: storagetype) = I32_valtype

;; 2-syntax-aux.watsup:48.1-48.65
def unpacknumtype : storagetype -> numtype
  ;; 2-syntax-aux.watsup:49.1-49.38
  def {numtype : numtype} unpacknumtype(numtype <: storagetype) = numtype
  ;; 2-syntax-aux.watsup:50.1-50.37
  def {packedtype : packedtype} unpacknumtype(packedtype <: storagetype) = I32_numtype

;; 2-syntax-aux.watsup:52.1-52.51
def sxfield : storagetype -> sx?
  ;; 2-syntax-aux.watsup:53.1-53.32
  def {valtype : valtype} sxfield(valtype <: storagetype) = ?()
  ;; 2-syntax-aux.watsup:54.1-54.29
  def {packedtype : packedtype} sxfield(packedtype <: storagetype) = ?(S_sx)

;; 2-syntax-aux.watsup:59.1-59.59
def diffrt : (reftype, reftype) -> reftype
  ;; 2-syntax-aux.watsup:61.1-61.68
  def {ht_1 : heaptype, ht_2 : heaptype, nul_1 : nul} diffrt(REF_reftype(nul_1, ht_1), REF_reftype(`NULL%?`(?(())), ht_2)) = REF_reftype(`NULL%?`(?()), ht_1)
  ;; 2-syntax-aux.watsup:62.1-62.69
  def {ht_1 : heaptype, ht_2 : heaptype, nul_1 : nul} diffrt(REF_reftype(nul_1, ht_1), REF_reftype(`NULL%?`(?()), ht_2)) = REF_reftype(nul_1, ht_1)

;; 2-syntax-aux.watsup:67.1-67.42
syntax typevar =
  | _IDX(typeidx)
  | REC(nat)

;; 2-syntax-aux.watsup:70.1-70.42
def idx : typeidx -> typevar
  ;; 2-syntax-aux.watsup:71.1-71.21
  def {x : idx} idx(x) = _IDX_typevar(x)

;; 2-syntax-aux.watsup:76.1-76.92
rec {

;; 2-syntax-aux.watsup:76.1-76.92
def subst_typevar : (typevar, typevar*, heaptype*) -> heaptype
  ;; 2-syntax-aux.watsup:101.1-101.46
  def {xx : typevar} subst_typevar(xx, [], []) = (xx <: heaptype)
  ;; 2-syntax-aux.watsup:102.1-102.95
  def {ht'* : heaptype*, ht_1 : heaptype, xx : typevar, xx'* : typevar*, xx_1 : typevar} subst_typevar(xx, [xx_1] :: xx'*{xx'}, [ht_1] :: ht'*{ht'}) = ht_1
    -- if (xx = xx_1)
  ;; 2-syntax-aux.watsup:103.1-103.92
  def {ht'* : heaptype*, ht_1 : heaptype, xx : typevar, xx'* : typevar*, xx_1 : typevar} subst_typevar(xx, [xx_1] :: xx'*{xx'}, [ht_1] :: ht'*{ht'}) = $subst_typevar(xx, xx'*{xx'}, ht'*{ht'})
    -- otherwise
}

;; 2-syntax-aux.watsup:78.1-78.92
def subst_numtype : (numtype, typevar*, heaptype*) -> numtype
  ;; 2-syntax-aux.watsup:105.1-105.38
  def {ht* : heaptype*, nt : numtype, xx* : typevar*} subst_numtype(nt, xx*{xx}, ht*{ht}) = nt

;; 2-syntax-aux.watsup:79.1-79.92
def subst_vectype : (vectype, typevar*, heaptype*) -> vectype
  ;; 2-syntax-aux.watsup:106.1-106.38
  def {ht* : heaptype*, vt : vectype, xx* : typevar*} subst_vectype(vt, xx*{xx}, ht*{ht}) = vt

;; 2-syntax-aux.watsup:84.1-84.92
def subst_packedtype : (packedtype, typevar*, heaptype*) -> packedtype
  ;; 2-syntax-aux.watsup:119.1-119.41
  def {ht* : heaptype*, pt : packedtype, xx* : typevar*} subst_packedtype(pt, xx*{xx}, ht*{ht}) = pt

;; 2-syntax-aux.watsup:80.1-94.92
rec {

;; 2-syntax-aux.watsup:80.1-80.92
def subst_heaptype : (heaptype, typevar*, heaptype*) -> heaptype
  ;; 2-syntax-aux.watsup:108.1-108.67
  def {ht* : heaptype*, xx* : typevar*, xx' : typevar} subst_heaptype((xx' <: heaptype), xx*{xx}, ht*{ht}) = $subst_typevar(xx', xx*{xx}, ht*{ht})
  ;; 2-syntax-aux.watsup:109.1-109.65
  def {dt : deftype, ht* : heaptype*, xx* : typevar*} subst_heaptype((dt <: heaptype), xx*{xx}, ht*{ht}) = ($subst_deftype(dt, xx*{xx}, ht*{ht}) <: heaptype)
  ;; 2-syntax-aux.watsup:110.1-110.53
  def {ht : heaptype, xx* : typevar*} subst_heaptype(ht, xx*{xx}, ht*{}) = ht
    -- otherwise

;; 2-syntax-aux.watsup:81.1-81.92
def subst_reftype : (reftype, typevar*, heaptype*) -> reftype
  ;; 2-syntax-aux.watsup:112.1-112.83
  def {ht : heaptype, nul : nul, xx* : typevar*} subst_reftype(REF_reftype(nul, ht), xx*{xx}, ht*{}) = REF_reftype(nul, $subst_heaptype(ht, xx*{xx}, ht*{}))

;; 2-syntax-aux.watsup:82.1-82.92
def subst_valtype : (valtype, typevar*, heaptype*) -> valtype
  ;; 2-syntax-aux.watsup:114.1-114.64
  def {ht* : heaptype*, nt : numtype, xx* : typevar*} subst_valtype((nt <: valtype), xx*{xx}, ht*{ht}) = ($subst_numtype(nt, xx*{xx}, ht*{ht}) <: valtype)
  ;; 2-syntax-aux.watsup:115.1-115.64
  def {ht* : heaptype*, vt : vectype, xx* : typevar*} subst_valtype((vt <: valtype), xx*{xx}, ht*{ht}) = ($subst_vectype(vt, xx*{xx}, ht*{ht}) <: valtype)
  ;; 2-syntax-aux.watsup:116.1-116.64
  def {ht* : heaptype*, rt : reftype, xx* : typevar*} subst_valtype((rt <: valtype), xx*{xx}, ht*{ht}) = ($subst_reftype(rt, xx*{xx}, ht*{ht}) <: valtype)
  ;; 2-syntax-aux.watsup:117.1-117.40
  def {ht* : heaptype*, xx* : typevar*} subst_valtype(BOT_valtype, xx*{xx}, ht*{ht}) = BOT_valtype

;; 2-syntax-aux.watsup:85.1-85.92
def subst_storagetype : (storagetype, typevar*, heaptype*) -> storagetype
  ;; 2-syntax-aux.watsup:121.1-121.66
  def {ht* : heaptype*, t : valtype, xx* : typevar*} subst_storagetype((t <: storagetype), xx*{xx}, ht*{ht}) = ($subst_valtype(t, xx*{xx}, ht*{ht}) <: storagetype)
  ;; 2-syntax-aux.watsup:122.1-122.71
  def {ht* : heaptype*, pt : packedtype, xx* : typevar*} subst_storagetype((pt <: storagetype), xx*{xx}, ht*{ht}) = ($subst_packedtype(pt, xx*{xx}, ht*{ht}) <: storagetype)

;; 2-syntax-aux.watsup:86.1-86.92
def subst_fieldtype : (fieldtype, typevar*, heaptype*) -> fieldtype
  ;; 2-syntax-aux.watsup:124.1-124.80
  def {ht* : heaptype*, mut : mut, xx* : typevar*, zt : storagetype} subst_fieldtype(`%%`(mut, zt), xx*{xx}, ht*{ht}) = `%%`(mut, $subst_storagetype(zt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:88.1-88.92
def subst_comptype : (comptype, typevar*, heaptype*) -> comptype
  ;; 2-syntax-aux.watsup:126.1-126.85
  def {ht* : heaptype*, xx* : typevar*, yt* : fieldtype*} subst_comptype(STRUCT_comptype(yt*{yt}), xx*{xx}, ht*{ht}) = STRUCT_comptype($subst_fieldtype(yt, xx*{xx}, ht*{ht})*{yt})
  ;; 2-syntax-aux.watsup:127.1-127.81
  def {ht* : heaptype*, xx* : typevar*, yt : fieldtype} subst_comptype(ARRAY_comptype(yt), xx*{xx}, ht*{ht}) = ARRAY_comptype($subst_fieldtype(yt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:128.1-128.78
  def {ft : functype, ht* : heaptype*, xx* : typevar*} subst_comptype(FUNC_comptype(ft), xx*{xx}, ht*{ht}) = FUNC_comptype($subst_functype(ft, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:89.1-89.92
def subst_subtype : (subtype, typevar*, heaptype*) -> subtype
  ;; 2-syntax-aux.watsup:130.1-131.76
  def {ct : comptype, fin : fin, ht* : heaptype*, xx* : typevar*, y* : idx*} subst_subtype(SUB_subtype(fin, y*{y}, ct), xx*{xx}, ht*{ht}) = SUBD_subtype(fin, $subst_heaptype(_IDX_heaptype(y), xx*{xx}, ht*{ht})*{y}, $subst_comptype(ct, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:132.1-133.73
  def {ct : comptype, fin : fin, ht* : heaptype*, ht'* : heaptype*, xx* : typevar*} subst_subtype(SUBD_subtype(fin, ht'*{ht'}, ct), xx*{xx}, ht*{ht}) = SUBD_subtype(fin, $subst_heaptype(ht', xx*{xx}, ht*{ht})*{ht'}, $subst_comptype(ct, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:90.1-90.92
def subst_rectype : (rectype, typevar*, heaptype*) -> rectype
  ;; 2-syntax-aux.watsup:135.1-135.76
  def {ht* : heaptype*, st* : subtype*, xx* : typevar*} subst_rectype(REC_rectype(st*{st}), xx*{xx}, ht*{ht}) = REC_rectype($subst_subtype(st, xx*{xx}, ht*{ht})*{st})

;; 2-syntax-aux.watsup:91.1-91.92
def subst_deftype : (deftype, typevar*, heaptype*) -> deftype
  ;; 2-syntax-aux.watsup:137.1-137.78
  def {ht* : heaptype*, i : nat, qt : rectype, xx* : typevar*} subst_deftype(DEF_deftype(qt, i), xx*{xx}, ht*{ht}) = DEF_deftype($subst_rectype(qt, xx*{xx}, ht*{ht}), i)

;; 2-syntax-aux.watsup:94.1-94.92
def subst_functype : (functype, typevar*, heaptype*) -> functype
  ;; 2-syntax-aux.watsup:140.1-140.113
  def {ht* : heaptype*, t_1* : valtype*, t_2* : valtype*, xx* : typevar*} subst_functype(`%->%`(t_1*{t_1}, t_2*{t_2}), xx*{xx}, ht*{ht}) = `%->%`($subst_valtype(t_1, xx*{xx}, ht*{ht})*{t_1}, $subst_valtype(t_2, xx*{xx}, ht*{ht})*{t_2})
}

;; 2-syntax-aux.watsup:93.1-93.92
def subst_globaltype : (globaltype, typevar*, heaptype*) -> globaltype
  ;; 2-syntax-aux.watsup:139.1-139.75
  def {ht* : heaptype*, mut : mut, t : valtype, xx* : typevar*} subst_globaltype(`%%`(mut, t), xx*{xx}, ht*{ht}) = `%%`(mut, $subst_valtype(t, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:95.1-95.92
def subst_tabletype : (tabletype, typevar*, heaptype*) -> tabletype
  ;; 2-syntax-aux.watsup:142.1-142.76
  def {ht* : heaptype*, lim : limits, rt : reftype, xx* : typevar*} subst_tabletype(`%%`(lim, rt), xx*{xx}, ht*{ht}) = `%%`(lim, $subst_reftype(rt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:96.1-96.92
def subst_memtype : (memtype, typevar*, heaptype*) -> memtype
  ;; 2-syntax-aux.watsup:141.1-141.48
  def {ht* : heaptype*, lim : limits, xx* : typevar*} subst_memtype(`%I8`(lim), xx*{xx}, ht*{ht}) = `%I8`(lim)

;; 2-syntax-aux.watsup:98.1-98.92
def subst_externtype : (externtype, typevar*, heaptype*) -> externtype
  ;; 2-syntax-aux.watsup:144.1-144.79
  def {dt : deftype, ht* : heaptype*, xx* : typevar*} subst_externtype(FUNC_externtype(dt), xx*{xx}, ht*{ht}) = FUNC_externtype($subst_deftype(dt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:145.1-145.86
  def {gt : globaltype, ht* : heaptype*, xx* : typevar*} subst_externtype(GLOBAL_externtype(gt), xx*{xx}, ht*{ht}) = GLOBAL_externtype($subst_globaltype(gt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:146.1-146.83
  def {ht* : heaptype*, tt : tabletype, xx* : typevar*} subst_externtype(TABLE_externtype(tt), xx*{xx}, ht*{ht}) = TABLE_externtype($subst_tabletype(tt, xx*{xx}, ht*{ht}))
  ;; 2-syntax-aux.watsup:147.1-147.77
  def {ht* : heaptype*, mt : memtype, xx* : typevar*} subst_externtype(MEM_externtype(mt), xx*{xx}, ht*{ht}) = MEM_externtype($subst_memtype(mt, xx*{xx}, ht*{ht}))

;; 2-syntax-aux.watsup:150.1-150.74
def subst_all_reftype : (reftype, heaptype*) -> reftype
  ;; 2-syntax-aux.watsup:153.1-153.75
  def {ht^n : heaptype^n, n : n, rt : reftype, x^n : idx^n} subst_all_reftype(rt, ht^n{ht}) = $subst_reftype(rt, $idx(x)^(x<n){x}, ht^n{ht})

;; 2-syntax-aux.watsup:151.1-151.74
def subst_all_deftype : (deftype, heaptype*) -> deftype
  ;; 2-syntax-aux.watsup:154.1-154.75
  def {dt : deftype, ht^n : heaptype^n, n : n, x^n : idx^n} subst_all_deftype(dt, ht^n{ht}) = $subst_deftype(dt, $idx(x)^(x<n){x}, ht^n{ht})

;; 2-syntax-aux.watsup:156.1-156.77
rec {

;; 2-syntax-aux.watsup:156.1-156.77
def subst_all_deftypes : (deftype*, heaptype*) -> deftype*
  ;; 2-syntax-aux.watsup:158.1-158.48
  def {ht* : heaptype*} subst_all_deftypes([], ht*{ht}) = []
  ;; 2-syntax-aux.watsup:159.1-159.101
  def {dt* : deftype*, dt_1 : deftype, ht* : heaptype*} subst_all_deftypes([dt_1] :: dt*{dt}, ht*{ht}) = [$subst_all_deftype(dt_1, ht*{ht})] :: $subst_all_deftypes(dt*{dt}, ht*{ht})
}

;; 2-syntax-aux.watsup:164.1-164.65
def rollrt : (typeidx, rectype) -> rectype
  ;; 2-syntax-aux.watsup:173.1-173.93
  def {i^n^n : nat^n^n, n : n, st^n : subtype^n, x : idx} rollrt(x, REC_rectype(st^n{st})) = REC_rectype($subst_subtype(st, $idx(x + i)^(i<n){i}, REC_heaptype(i)^(i<n){i})^n{i st})

;; 2-syntax-aux.watsup:165.1-165.63
def unrollrt : rectype -> rectype
  ;; 2-syntax-aux.watsup:174.1-175.22
  def {i^n^n : nat^n^n, n : n, qt : rectype, st^n : subtype^n} unrollrt(REC_rectype(st^n{st})) = REC_rectype($subst_subtype(st, REC_typevar(i)^(i<n){i}, DEF_heaptype(qt, i)^(i<n){i})^n{i st})
    -- if (qt = REC_rectype(st^n{st}))

;; 2-syntax-aux.watsup:166.1-166.65
def rolldt : (typeidx, rectype) -> deftype*
  ;; 2-syntax-aux.watsup:177.1-177.79
  def {i^n : nat^n, n : n, qt : rectype, st^n : subtype^n, x : idx} rolldt(x, qt) = DEF_deftype(REC_rectype(st^n{st}), i)^(i<n){i}
    -- if ($rollrt(x, qt) = REC_rectype(st^n{st}))

;; 2-syntax-aux.watsup:167.1-167.63
def unrolldt : deftype -> subtype
  ;; 2-syntax-aux.watsup:178.1-178.77
  def {i : nat, qt : rectype, st* : subtype*} unrolldt(DEF_deftype(qt, i)) = st*{st}[i]
    -- if ($unrollrt(qt) = REC_rectype(st*{st}))

;; 2-syntax-aux.watsup:168.1-168.63
def expanddt : deftype -> comptype
  ;; 2-syntax-aux.watsup:180.1-180.85
  def {ct : comptype, dt : deftype, fin : fin, ht* : heaptype*} expanddt(dt) = ct
    -- if ($unrolldt(dt) = SUBD_subtype(fin, ht*{ht}, ct))

;; 2-syntax-aux.watsup:182.1-182.37
relation Expand: `%~~%`(deftype, comptype)
  ;; 2-syntax-aux.watsup:183.1-183.72
  rule _ {ct : comptype, dt : deftype}:
    `%~~%`(dt, ct)
    -- if ($expanddt(dt) = ct)

;; 2-syntax-aux.watsup:188.1-188.64
rec {

;; 2-syntax-aux.watsup:188.1-188.64
def funcsxt : externtype* -> deftype*
  ;; 2-syntax-aux.watsup:193.1-193.32
  def funcsxt([]) = []
  ;; 2-syntax-aux.watsup:194.1-194.47
  def {dt : deftype, et* : externtype*} funcsxt([FUNC_externtype(dt)] :: et*{et}) = [dt] :: $funcsxt(et*{et})
  ;; 2-syntax-aux.watsup:195.1-195.59
  def {et* : externtype*, externtype : externtype} funcsxt([externtype] :: et*{et}) = $funcsxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup:189.1-189.66
rec {

;; 2-syntax-aux.watsup:189.1-189.66
def globalsxt : externtype* -> globaltype*
  ;; 2-syntax-aux.watsup:197.1-197.34
  def globalsxt([]) = []
  ;; 2-syntax-aux.watsup:198.1-198.53
  def {et* : externtype*, gt : globaltype} globalsxt([GLOBAL_externtype(gt)] :: et*{et}) = [gt] :: $globalsxt(et*{et})
  ;; 2-syntax-aux.watsup:199.1-199.63
  def {et* : externtype*, externtype : externtype} globalsxt([externtype] :: et*{et}) = $globalsxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup:190.1-190.65
rec {

;; 2-syntax-aux.watsup:190.1-190.65
def tablesxt : externtype* -> tabletype*
  ;; 2-syntax-aux.watsup:201.1-201.33
  def tablesxt([]) = []
  ;; 2-syntax-aux.watsup:202.1-202.50
  def {et* : externtype*, tt : tabletype} tablesxt([TABLE_externtype(tt)] :: et*{et}) = [tt] :: $tablesxt(et*{et})
  ;; 2-syntax-aux.watsup:203.1-203.61
  def {et* : externtype*, externtype : externtype} tablesxt([externtype] :: et*{et}) = $tablesxt(et*{et})
    -- otherwise
}

;; 2-syntax-aux.watsup:191.1-191.63
rec {

;; 2-syntax-aux.watsup:191.1-191.63
def memsxt : externtype* -> memtype*
  ;; 2-syntax-aux.watsup:205.1-205.31
  def memsxt([]) = []
  ;; 2-syntax-aux.watsup:206.1-206.44
  def {et* : externtype*, mt : memtype} memsxt([MEM_externtype(mt)] :: et*{et}) = [mt] :: $memsxt(et*{et})
  ;; 2-syntax-aux.watsup:207.1-207.57
  def {et* : externtype*, externtype : externtype} memsxt([externtype] :: et*{et}) = $memsxt(et*{et})
    -- otherwise
}

;; 3-numerics.watsup:3.1-3.79
def unop : (unop_numtype, numtype, c_numtype) -> c_numtype*

;; 3-numerics.watsup:4.1-4.80
def binop : (binop_numtype, numtype, c_numtype, c_numtype) -> c_numtype*

;; 3-numerics.watsup:5.1-5.79
def testop : (testop_numtype, numtype, c_numtype) -> c_numtype

;; 3-numerics.watsup:6.1-6.80
def relop : (relop_numtype, numtype, c_numtype, c_numtype) -> c_numtype

;; 3-numerics.watsup:7.1-7.98
def cvtop : (cvtop, numtype, numtype, sx?, c_numtype) -> c_numtype*

;; 3-numerics.watsup:9.1-9.88
def wrap : (nat, nat, c_numtype) -> nat

;; 3-numerics.watsup:10.1-10.91
def ext : (nat, nat, sx, c_numtype) -> c_numtype

;; 3-numerics.watsup:12.1-12.83
def bytes : (nat, c_numtype) -> byte*

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

;; 4-runtime.watsup:12.1-12.51
syntax labeladdr = addr

;; 4-runtime.watsup:13.1-13.49
syntax hostaddr = addr

;; 4-runtime.watsup:14.1-14.56
syntax structaddr = addr

;; 4-runtime.watsup:15.1-15.51
syntax arrayaddr = addr

;; 4-runtime.watsup:34.1-35.24
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:36.1-42.19
rec {

;; 4-runtime.watsup:36.1-42.19
syntax addrref =
  | REF.I31_NUM(i31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)
}

;; 4-runtime.watsup:43.1-45.8
syntax ref =
  | REF.I31_NUM(i31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)
  | REF.NULL(heaptype)

;; 4-runtime.watsup:46.1-47.10
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(heaptype)
  | REF.I31_NUM(i31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)

;; 4-runtime.watsup:49.1-50.18
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:59.1-60.66
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:71.1-71.26
syntax c_packedtype = nat

;; 4-runtime.watsup:91.1-93.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:106.1-114.25
syntax moduleinst = {TYPE deftype*, FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:73.1-76.16
syntax funcinst = {TYPE deftype, MODULE moduleinst, CODE func}

;; 4-runtime.watsup:77.1-79.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:80.1-82.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:83.1-85.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:86.1-88.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:89.1-90.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:95.1-96.53
syntax packedval =
  | PACK(packedtype, c_packedtype)

;; 4-runtime.watsup:97.1-98.16
syntax fieldval =
  | CONST(numtype, c_numtype)
  | REF.NULL(heaptype)
  | REF.I31_NUM(i31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)
  | PACK(packedtype, c_packedtype)

;; 4-runtime.watsup:99.1-101.22
syntax structinst = {TYPE deftype, FIELD fieldval*}

;; 4-runtime.watsup:102.1-104.22
syntax arrayinst = {TYPE deftype, FIELD fieldval*}

;; 4-runtime.watsup:133.1-141.23
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*, STRUCT structinst*, ARRAY arrayinst*}

;; 4-runtime.watsup:143.1-145.24
syntax frame = {LOCAL val?*, MODULE moduleinst}

;; 4-runtime.watsup:147.1-147.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:159.1-165.5
rec {

;; 4-runtime.watsup:159.1-165.5
syntax admininstr =
  | UNREACHABLE
  | NOP
  | DROP
  | SELECT(valtype?)
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
  | CALL_REF(typeidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | RETURN_CALL(funcidx)
  | RETURN_CALL_REF(typeidx)
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
  | STRUCT.GET(sx?, typeidx, i32)
  | STRUCT.SET(typeidx, i32)
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
  | EXTERN.INTERNALIZE
  | EXTERN.EXTERNALIZE
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
  | LOAD(numtype, (n, sx)?, memidx, i32, i32)
  | STORE(numtype, n?, memidx, i32, i32)
  | REF.I31_NUM(i31)
  | REF.STRUCT_ADDR(structaddr)
  | REF.ARRAY_ADDR(arrayaddr)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | REF.EXTERN(addrref)
  | CALL_ADDR(funcaddr)
  | LABEL_(n, instr*, admininstr*)
  | FRAME_(n, frame, admininstr*)
  | TRAP
}

;; 4-runtime.watsup:148.1-148.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:167.1-170.21
rec {

;; 4-runtime.watsup:167.1-170.21
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
  ;; 5-runtime-aux.watsup:25.1-25.42
  def {ht : heaptype} default(REF_valtype(`NULL%?`(?(())), ht)) = ?(REF.NULL_val(ht))
  ;; 5-runtime-aux.watsup:26.1-26.39
  def {ht : heaptype} default(REF_valtype(`NULL%?`(?()), ht)) = ?()

;; 5-runtime-aux.watsup:31.1-31.73
def packval : (storagetype, val) -> fieldval
  ;; 5-runtime-aux.watsup:34.1-34.27
  def {t : valtype, val : val} packval((t <: storagetype), val) = (val <: fieldval)
  ;; 5-runtime-aux.watsup:35.1-35.70
  def {i : nat, pt : packedtype} packval((pt <: storagetype), CONST_val(I32_numtype, i)) = PACK_fieldval(pt, $wrap(32, $packedsize(pt), i))

;; 5-runtime-aux.watsup:32.1-32.83
def unpackval : (storagetype, sx?, fieldval) -> val
  ;; 5-runtime-aux.watsup:37.1-37.38
  def {t : valtype, val : val} unpackval((t <: storagetype), ?(), (val <: fieldval)) = val
  ;; 5-runtime-aux.watsup:38.1-38.79
  def {i : nat, pt : packedtype, sx : sx} unpackval((pt <: storagetype), ?(sx), PACK_fieldval(pt, i)) = CONST_val(I32_numtype, $ext($packedsize(pt), 32, sx, i))

;; 5-runtime-aux.watsup:43.1-43.62
rec {

;; 5-runtime-aux.watsup:43.1-43.62
def funcsxv : externval* -> funcaddr*
  ;; 5-runtime-aux.watsup:48.1-48.32
  def funcsxv([]) = []
  ;; 5-runtime-aux.watsup:49.1-49.47
  def {fa : funcaddr, xv* : externval*} funcsxv([FUNC_externval(fa)] :: xv*{xv}) = [fa] :: $funcsxv(xv*{xv})
  ;; 5-runtime-aux.watsup:50.1-50.58
  def {externval : externval, xv* : externval*} funcsxv([externval] :: xv*{xv}) = $funcsxv(xv*{xv})
    -- otherwise
}

;; 5-runtime-aux.watsup:44.1-44.64
rec {

;; 5-runtime-aux.watsup:44.1-44.64
def globalsxv : externval* -> globaladdr*
  ;; 5-runtime-aux.watsup:52.1-52.34
  def globalsxv([]) = []
  ;; 5-runtime-aux.watsup:53.1-53.53
  def {ga : globaladdr, xv* : externval*} globalsxv([GLOBAL_externval(ga)] :: xv*{xv}) = [ga] :: $globalsxv(xv*{xv})
  ;; 5-runtime-aux.watsup:54.1-54.62
  def {externval : externval, xv* : externval*} globalsxv([externval] :: xv*{xv}) = $globalsxv(xv*{xv})
    -- otherwise
}

;; 5-runtime-aux.watsup:45.1-45.63
rec {

;; 5-runtime-aux.watsup:45.1-45.63
def tablesxv : externval* -> tableaddr*
  ;; 5-runtime-aux.watsup:56.1-56.33
  def tablesxv([]) = []
  ;; 5-runtime-aux.watsup:57.1-57.50
  def {ta : tableaddr, xv* : externval*} tablesxv([TABLE_externval(ta)] :: xv*{xv}) = [ta] :: $tablesxv(xv*{xv})
  ;; 5-runtime-aux.watsup:58.1-58.60
  def {externval : externval, xv* : externval*} tablesxv([externval] :: xv*{xv}) = $tablesxv(xv*{xv})
    -- otherwise
}

;; 5-runtime-aux.watsup:46.1-46.61
rec {

;; 5-runtime-aux.watsup:46.1-46.61
def memsxv : externval* -> memaddr*
  ;; 5-runtime-aux.watsup:60.1-60.31
  def memsxv([]) = []
  ;; 5-runtime-aux.watsup:61.1-61.44
  def {ma : memaddr, xv* : externval*} memsxv([MEM_externval(ma)] :: xv*{xv}) = [ma] :: $memsxv(xv*{xv})
  ;; 5-runtime-aux.watsup:62.1-62.56
  def {externval : externval, xv* : externval*} memsxv([externval] :: xv*{xv}) = $memsxv(xv*{xv})
    -- otherwise
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
  ;; 5-runtime-aux.watsup:157.1-160.22
  def {i : nat, j : nat, n : n, r : ref, r'* : ref*, rt : reftype, ti : tableinst, tt' : tabletype} growtable(ti, n, r) = {TYPE tt', ELEM r'*{r'} :: r^n{}}
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM r'*{r'}})
    -- if (tt' = `%%`(`[%..%]`((i + n), j), rt))
    -- if ((i + n) <= j)

;; 5-runtime-aux.watsup:155.1-155.54
def growmemory : (meminst, nat) -> meminst
  ;; 5-runtime-aux.watsup:162.1-165.22
  def {b* : byte*, i : nat, j : nat, mi : meminst, mt' : memtype, n : n} growmemory(mi, n) = {TYPE mt', DATA b*{b} :: 0^((n * 64) * $Ki){}}
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA b*{b}})
    -- if (mt' = `%I8`(`[%..%]`((i + n), j)))
    -- if ((i + n) <= j)

;; 6-typing.watsup:5.1-6.12
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
  ;; 6-typing.watsup:28.1-28.42
  def {C : context} with_locals(C, [], []) = C
  ;; 6-typing.watsup:29.1-29.85
  def {C : context, lt* : localtype*, lt_1 : localtype, x* : idx*, x_1 : idx} with_locals(C, [x_1] :: x*{x}, [lt_1] :: lt*{lt}) = $with_locals(C[LOCAL_context[x_1] = lt_1], x*{x}, lt*{lt})
}

;; 6-typing.watsup:33.1-33.65
rec {

;; 6-typing.watsup:33.1-33.65
def clostypes : deftype* -> deftype*
  ;; 6-typing.watsup:37.1-37.34
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
  rule null {C : context, ht_1 : heaptype, ht_2 : heaptype, nul : nul}:
    `%|-%<:%`(C, REF_reftype(nul, ht_1), REF_reftype(`NULL%?`(?(())), ht_2))
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
  rule _ {C : context, ct : comptype, ct'* : comptype*, fin : fin, ht* : heaptype*, ht'** : heaptype**, i : nat, x : idx, y* : idx*}:
    `%|-%:%`(C, SUBD_subtype(fin, ht*{ht}, ct), OK_oktypeidxnat(x, i))
    -- if (|y*{y}| <= 1)
    -- (if $before(ht, x, i))*{ht}
    -- (if ($unrollht(C, ht) = SUBD_subtype(`FINAL%?`(?()), ht'*{ht'}, ct')))*{ct' ht ht'}
    -- Comptype_ok: `%|-%:OK`(C, ct)
    -- (Comptype_sub: `%|-%<:%`(C, ct, ct'))*{ct'}

;; 6-typing.watsup:120.1-120.76
rec {

;; 6-typing.watsup:120.1-120.76
relation Rectype_ok2: `%|-%:%`(context, rectype, oktypeidxnat)
  ;; 6-typing.watsup:196.1-197.28
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
  ;; 6-typing.watsup:184.1-185.27
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
  ;; 6-typing.watsup:567.1-569.31
  rule _ {C : context, ft : functype}:
    `%|-%:%`(C, ft, ft)
    -- Functype_ok: `%|-%:OK`(C, ft)

;; 6-typing.watsup:503.1-505.74
rec {

;; 6-typing.watsup:503.1-503.67
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 6-typing.watsup:544.1-545.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 6-typing.watsup:547.1-548.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 6-typing.watsup:550.1-551.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 6-typing.watsup:554.1-555.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?(t)), `%->%`([t t I32_valtype], [t]))

  ;; 6-typing.watsup:557.1-560.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `%|-%<:%`(C, t, t')
    -- if ((t' = (numtype <: valtype)) \/ (t' = (vectype <: valtype)))

  ;; 6-typing.watsup:571.1-574.61
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr*{instr}, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))

  ;; 6-typing.watsup:576.1-579.61
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*, x* : idx*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1*{t_1}], RETURN ?()}, instr*{instr}, `%->%*%`(t_1*{t_1}, x*{x}, t_2*{t_2}))

  ;; 6-typing.watsup:581.1-585.65
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*, x_1* : idx*, x_2* : idx*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%*%`(t_1*{t_1}, x_1*{x_1}, t_2*{t_2}))
    -- Instrs_ok: `%|-%*:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%*%`(t_1*{t_1}, x_2*{x_2}, t_2*{t_2}))

  ;; 6-typing.watsup:590.1-592.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 6-typing.watsup:594.1-596.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 6-typing.watsup:598.1-601.44
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `%|-%*<:%*`(C, t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `%|-%*<:%*`(C, t*{t}, C.LABEL_context[l'])

  ;; 6-typing.watsup:603.1-606.31
  rule br_on_null {C : context, ht : heaptype, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_ON_NULL_instr(l), `%->%`(t*{t} :: [REF_valtype(`NULL%?`(?(())), ht)], t*{t} :: [REF_valtype(`NULL%?`(?()), ht)]))
    -- if (C.LABEL_context[l] = t*{t})
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:608.1-611.31
  rule br_on_non_null {C : context, ht : heaptype, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_ON_NON_NULL_instr(l), `%->%`(t*{t} :: [REF_valtype(`NULL%?`(?(())), ht)], t*{t}))
    -- if (C.LABEL_context[l] = t*{t} :: [REF_valtype(`NULL%?`(?()), ht)])
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:613.1-619.34
  rule br_on_cast {C : context, l : labelidx, rt : reftype, rt_1 : reftype, rt_2 : reftype, t* : valtype*}:
    `%|-%:%`(C, BR_ON_CAST_instr(l, rt_1, rt_2), `%->%`(t*{t} :: [(rt_1 <: valtype)], t*{t} :: [($diffrt(rt_1, rt_2) <: valtype)]))
    -- if (C.LABEL_context[l] = t*{t} :: [(rt <: valtype)])
    -- Reftype_ok: `%|-%:OK`(C, rt_1)
    -- Reftype_ok: `%|-%:OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt)

  ;; 6-typing.watsup:621.1-627.49
  rule br_on_cast_fail {C : context, l : labelidx, rt : reftype, rt_1 : reftype, rt_2 : reftype, t* : valtype*}:
    `%|-%:%`(C, BR_ON_CAST_instr(l, rt_1, rt_2), `%->%`(t*{t} :: [(rt_1 <: valtype)], t*{t} :: [(rt_2 <: valtype)]))
    -- if (C.LABEL_context[l] = t*{t} :: [(rt <: valtype)])
    -- Reftype_ok: `%|-%:OK`(C, rt_1)
    -- Reftype_ok: `%|-%:OK`(C, rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)
    -- Reftype_sub: `%|-%<:%`(C, $diffrt(rt_1, rt_2), rt)

  ;; 6-typing.watsup:632.1-634.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 6-typing.watsup:636.1-638.46
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:640.1-642.46
  rule call_ref {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_REF_instr(x), `%->%`(t_1*{t_1} :: [REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype))], t_2*{t_2}))
    -- Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:644.1-648.46
  rule call_indirect {C : context, lim : limits, rt : reftype, t_1* : valtype*, t_2* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, y), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPE_context[y], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))

  ;; 6-typing.watsup:650.1-654.40
  rule return_call {C : context, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*, t_4* : valtype*, x : idx}:
    `%|-%:%`(C, RETURN_CALL_instr(x), `%->%`(t_3*{t_3} :: t_1*{t_1}, t_4*{t_4}))
    -- Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:656.1-660.40
  rule return_call_ref {C : context, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*, t_4* : valtype*, x : idx}:
    `%|-%:%`(C, RETURN_CALL_REF_instr(x), `%->%`(t_3*{t_3} :: t_1*{t_1} :: [REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype))], t_4*{t_4}))
    -- Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:662.1-668.40
  rule return_call_indirect {C : context, lim : limits, rt : reftype, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*, t_4* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, RETURN_CALL_INDIRECT_instr(x, y), `%->%`(t_3*{t_3} :: t_1*{t_1} :: [I32_valtype], t_4*{t_4}))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`(?(())), FUNC_heaptype))
    -- Expand: `%~~%`(C.TYPE_context[y], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- if (C.RETURN_context = ?(t'_2*{t'_2}))
    -- Resulttype_sub: `%|-%*<:%*`(C, t_2*{t_2}, t'_2*{t'_2})

  ;; 6-typing.watsup:673.1-674.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [(nt <: valtype)]))

  ;; 6-typing.watsup:676.1-677.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([(nt <: valtype)], [(nt <: valtype)]))

  ;; 6-typing.watsup:679.1-680.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([(nt <: valtype) (nt <: valtype)], [(nt <: valtype)]))

  ;; 6-typing.watsup:682.1-683.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([(nt <: valtype)], [I32_valtype]))

  ;; 6-typing.watsup:685.1-686.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([(nt <: valtype) (nt <: valtype)], [I32_valtype]))

  ;; 6-typing.watsup:689.1-691.23
  rule extend {C : context, n : n, nt : numtype}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([(nt <: valtype)], [(nt <: valtype)]))
    -- if (n <= $size(nt <: valtype))

  ;; 6-typing.watsup:693.1-696.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([(nt_2 <: valtype)], [(nt_1 <: valtype)]))
    -- if (nt_1 =/= nt_2)
    -- if ($size(nt_1 <: valtype) = $size(nt_2 <: valtype))

  ;; 6-typing.watsup:698.1-701.52
  rule convert-i {C : context, iN_1 : iN, iN_2 : iN, sx? : sx?}:
    `%|-%:%`(C, CVTOP_instr((iN_1 <: numtype), CONVERT_cvtop, (iN_2 <: numtype), sx?{sx}), `%->%`([(iN_2 <: valtype)], [(iN_1 <: valtype)]))
    -- if (iN_1 =/= iN_2)
    -- if ((sx?{sx} = ?()) <=> ($size(iN_1 <: valtype) > $size(iN_2 <: valtype)))

  ;; 6-typing.watsup:703.1-705.22
  rule convert-f {C : context, fN_1 : fN, fN_2 : fN}:
    `%|-%:%`(C, CVTOP_instr((fN_1 <: numtype), CONVERT_cvtop, (fN_2 <: numtype), ?()), `%->%`([(fN_2 <: valtype)], [(fN_1 <: valtype)]))
    -- if (fN_1 =/= fN_2)

  ;; 6-typing.watsup:710.1-712.31
  rule ref.null {C : context, ht : heaptype}:
    `%|-%:%`(C, REF.NULL_instr(ht), `%->%`([], [REF_valtype(`NULL%?`(?(())), ht)]))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:715.1-717.23
  rule ref.func {C : context, dt : deftype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [REF_valtype(`NULL%?`(?()), (dt <: heaptype))]))
    -- if (C.FUNC_context[x] = dt)

  ;; 6-typing.watsup:719.1-720.42
  rule ref.i31 {C : context}:
    `%|-%:%`(C, REF.I31_instr, `%->%`([I32_valtype], [REF_valtype(`NULL%?`(?()), I31_heaptype)]))

  ;; 6-typing.watsup:722.1-723.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([(rt <: valtype)], [I32_valtype]))

  ;; 6-typing.watsup:725.1-727.31
  rule ref.as_non_null {C : context, ht : heaptype}:
    `%|-%:%`(C, REF.AS_NON_NULL_instr, `%->%`([REF_valtype(`NULL%?`(?(())), ht)], [REF_valtype(`NULL%?`(?()), ht)]))
    -- Heaptype_ok: `%|-%:OK`(C, ht)

  ;; 6-typing.watsup:729.1-730.51
  rule ref.eq {C : context}:
    `%|-%:%`(C, REF.EQ_instr, `%->%`([REF_valtype(`NULL%?`(?(())), EQ_heaptype) REF_valtype(`NULL%?`(?(())), EQ_heaptype)], [I32_valtype]))

  ;; 6-typing.watsup:732.1-736.33
  rule ref.test {C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.TEST_instr(rt), `%->%`([(rt' <: valtype)], [I32_valtype]))
    -- Reftype_ok: `%|-%:OK`(C, rt)
    -- Reftype_ok: `%|-%:OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; 6-typing.watsup:738.1-742.33
  rule ref.cast {C : context, rt : reftype, rt' : reftype}:
    `%|-%:%`(C, REF.CAST_instr(rt), `%->%`([(rt' <: valtype)], [(rt <: valtype)]))
    -- Reftype_ok: `%|-%:OK`(C, rt)
    -- Reftype_ok: `%|-%:OK`(C, rt')
    -- Reftype_sub: `%|-%<:%`(C, rt, rt')

  ;; 6-typing.watsup:747.1-748.42
  rule i31.get {C : context, sx : sx}:
    `%|-%:%`(C, I31.GET_instr(sx), `%->%`([REF_valtype(`NULL%?`(?(())), I31_heaptype)], [I32_valtype]))

  ;; 6-typing.watsup:753.1-755.43
  rule struct.new {C : context, mut* : mut*, x : idx, zt* : storagetype*}:
    `%|-%:%`(C, STRUCT.NEW_instr(x), `%->%`($unpacktype(zt)*{zt}, [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(`%%`(mut, zt)*{mut zt}))

  ;; 6-typing.watsup:757.1-760.43
  rule struct.new_default {C : context, mut* : mut*, val* : val*, x : idx, zt* : storagetype*}:
    `%|-%:%`(C, STRUCT.NEW_DEFAULT_instr(x), `%->%`($unpacktype(zt)*{zt}, [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- (if ($default($unpacktype(zt)) = ?(val)))*{val zt}

  ;; 6-typing.watsup:762.1-766.47
  rule struct.get {C : context, i : nat, mut : mut, sx? : sx?, x : idx, yt* : fieldtype*, zt : storagetype}:
    `%|-%:%`(C, STRUCT.GET_instr(sx?{sx}, x, i), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype))], [$unpacktype(zt)]))
    -- Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(yt*{yt}))
    -- if (yt*{yt}[i] = `%%`(mut, zt))
    -- if ((sx?{sx} = ?()) <=> (zt = ($unpacktype(zt) <: storagetype)))

  ;; 6-typing.watsup:768.1-771.24
  rule struct.set {C : context, i : nat, x : idx, yt* : fieldtype*, zt : storagetype}:
    `%|-%:%`(C, STRUCT.SET_instr(x, i), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) $unpacktype(zt)], []))
    -- Expand: `%~~%`(C.TYPE_context[x], STRUCT_comptype(yt*{yt}))
    -- if (yt*{yt}[i] = `%%`(`MUT%?`(?(())), zt))

  ;; 6-typing.watsup:776.1-778.41
  rule array.new {C : context, mut : mut, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.NEW_instr(x), `%->%`([$unpacktype(zt) I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))

  ;; 6-typing.watsup:780.1-783.40
  rule array.new_default {C : context, mut : mut, val : val, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.NEW_DEFAULT_instr(x), `%->%`([I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))
    -- if ($default($unpacktype(zt)) = ?(val))

  ;; 6-typing.watsup:785.1-787.41
  rule array.new_fixed {C : context, mut : mut, n : n, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.NEW_FIXED_instr(x, n), `%->%`([$unpacktype(zt)], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))

  ;; 6-typing.watsup:789.1-792.39
  rule array.new_elem {C : context, mut : mut, rt : reftype, x : idx, y : idx}:
    `%|-%:%`(C, ARRAY.NEW_ELEM_instr(x, y), `%->%`([I32_valtype I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, (rt <: storagetype))))
    -- Reftype_sub: `%|-%<:%`(C, C.ELEM_context[y], rt)

  ;; 6-typing.watsup:794.1-798.23
  rule array.new_data {C : context, mut : mut, numtype : numtype, t : valtype, vectype : vectype, x : idx, y : idx}:
    `%|-%:%`(C, ARRAY.NEW_DATA_instr(x, y), `%->%`([I32_valtype I32_valtype], [REF_valtype(`NULL%?`(?()), ($idx(x) <: heaptype))]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, (t <: storagetype))))
    -- if ((t = (numtype <: valtype)) \/ (t = (vectype <: valtype)))
    -- if (C.DATA_context[y] = OK)

  ;; 6-typing.watsup:800.1-803.47
  rule array.get {C : context, mut : mut, sx? : sx?, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.GET_instr(sx?{sx}, x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype], [$unpacktype(zt)]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(mut, zt)))
    -- if ((sx?{sx} = ?()) <=> (zt = ($unpacktype(zt) <: storagetype)))

  ;; 6-typing.watsup:805.1-807.41
  rule array.set {C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.SET_instr(x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype $unpacktype(zt)], []))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:809.1-811.41
  rule array.len {C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.LEN_instr, `%->%`([REF_valtype(`NULL%?`(?(())), ARRAY_heaptype)], [I32_valtype]))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:813.1-815.41
  rule array.fill {C : context, x : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.FILL_instr(x), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype $unpacktype(zt) I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))

  ;; 6-typing.watsup:817.1-821.40
  rule array.copy {C : context, mut : mut, x_1 : idx, x_2 : idx, zt_1 : storagetype, zt_2 : storagetype}:
    `%|-%:%`(C, ARRAY.COPY_instr(x_1, x_2), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x_1) <: heaptype)) I32_valtype REF_valtype(`NULL%?`(?(())), ($idx(x_2) <: heaptype)) I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x_1], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt_1)))
    -- Expand: `%~~%`(C.TYPE_context[x_2], ARRAY_comptype(`%%`(mut, zt_2)))
    -- Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)

  ;; 6-typing.watsup:823.1-826.43
  rule array.init_elem {C : context, x : idx, y : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.INIT_ELEM_instr(x, y), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
    -- Storagetype_sub: `%|-%<:%`(C, (C.ELEM_context[y] <: storagetype), zt)

  ;; 6-typing.watsup:828.1-832.23
  rule array.init_data {C : context, numtype : numtype, t : valtype, vectype : vectype, x : idx, y : idx, zt : storagetype}:
    `%|-%:%`(C, ARRAY.INIT_DATA_instr(x, y), `%->%`([REF_valtype(`NULL%?`(?(())), ($idx(x) <: heaptype)) I32_valtype I32_valtype I32_valtype], []))
    -- Expand: `%~~%`(C.TYPE_context[x], ARRAY_comptype(`%%`(`MUT%?`(?(())), zt)))
    -- if ((t = (numtype <: valtype)) \/ (t = (vectype <: valtype)))
    -- if (C.DATA_context[y] = OK)

  ;; 6-typing.watsup:837.1-838.62
  rule extern.externalize {C : context, nul : nul}:
    `%|-%:%`(C, EXTERN.EXTERNALIZE_instr, `%->%`([REF_valtype(nul, ANY_heaptype)], [REF_valtype(nul, EXTERN_heaptype)]))

  ;; 6-typing.watsup:840.1-841.62
  rule extern.internalize {C : context, nul : nul}:
    `%|-%:%`(C, EXTERN.INTERNALIZE_instr, `%->%`([REF_valtype(nul, EXTERN_heaptype)], [REF_valtype(nul, ANY_heaptype)]))

  ;; 6-typing.watsup:846.1-848.28
  rule local.get {C : context, init : init, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = `%%`(init, t))

  ;; 6-typing.watsup:861.1-863.28
  rule global.get {C : context, mut : mut, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `%%`(mut, t))

  ;; 6-typing.watsup:865.1-867.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?(())), t))

  ;; 6-typing.watsup:872.1-874.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [(rt <: valtype)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 6-typing.watsup:876.1-878.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype (rt <: valtype)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 6-typing.watsup:880.1-882.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 6-typing.watsup:884.1-886.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([(rt <: valtype) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 6-typing.watsup:888.1-890.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype (rt <: valtype) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 6-typing.watsup:892.1-896.36
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt_1 : reftype, rt_2 : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt_1))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt_2))
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:898.1-902.36
  rule table.init {C : context, lim : limits, rt_1 : reftype, rt_2 : reftype, x : idx, y : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x, y), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt_1))
    -- if (C.ELEM_context[y] = rt_2)
    -- Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)

  ;; 6-typing.watsup:904.1-906.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 6-typing.watsup:911.1-913.22
  rule memory.size {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[x] = mt)

  ;; 6-typing.watsup:915.1-917.22
  rule memory.grow {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.GROW_instr(x), `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[x] = mt)

  ;; 6-typing.watsup:919.1-921.22
  rule memory.fill {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.FILL_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[x] = mt)

  ;; 6-typing.watsup:923.1-926.26
  rule memory.copy {C : context, mt_1 : memtype, mt_2 : memtype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, MEMORY.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[x_1] = mt_1)
    -- if (C.MEM_context[x_2] = mt_2)

  ;; 6-typing.watsup:928.1-931.23
  rule memory.init {C : context, mt : memtype, x : idx, y : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x, y), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[x] = mt)
    -- if (C.DATA_context[y] = OK)

  ;; 6-typing.watsup:933.1-935.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 6-typing.watsup:937.1-942.32
  rule load {C : context, iN : iN, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?, x : idx}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, x, n_A, n_O), `%->%`([I32_valtype], [(nt <: valtype)]))
    -- if (C.MEM_context[x] = mt)
    -- if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (iN <: numtype)))

  ;; 6-typing.watsup:944.1-949.32
  rule store {C : context, iN : iN, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, x : idx}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, x, n_A, n_O), `%->%`([I32_valtype (nt <: valtype)], []))
    -- if (C.MEM_context[x] = mt)
    -- if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (iN <: numtype)))

;; 6-typing.watsup:504.1-504.67
relation Instrf_ok: `%|-%:%`(context, instr, instrtype)
  ;; 6-typing.watsup:518.1-520.41
  rule instr {C : context, instr : instr, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, instr, `%->%*%`(t_1*{t_1}, [], t_2*{t_2}))
    -- Instr_ok: `%|-%:%`(C, instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 6-typing.watsup:850.1-852.28
  rule local.set {C : context, init : init, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%*%`([t], [x], []))
    -- if (C.LOCAL_context[x] = `%%`(init, t))

  ;; 6-typing.watsup:854.1-856.28
  rule local.tee {C : context, init : init, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%*%`([t], [x], [t]))
    -- if (C.LOCAL_context[x] = `%%`(init, t))

;; 6-typing.watsup:505.1-505.74
relation Instrs_ok: `%|-%*:%`(context, instr*, instrtype)
  ;; 6-typing.watsup:522.1-523.45
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
  ;; 6-typing.watsup:511.1-513.53
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- Instrs_ok: `%|-%*:%`(C, instr*{instr}, `%->%*%`([], [], t*{t}))

;; 6-typing.watsup:976.1-976.58
rec {

;; 6-typing.watsup:976.1-976.58
def in_binop : (binop_numtype, binopIXX*) -> bool
  ;; 6-typing.watsup:977.1-977.38
  def {binop : binop_numtype} in_binop(binop, []) = false
  ;; 6-typing.watsup:978.1-978.100
  def {binop : binop_numtype, binopIXX'* : binopIXX*, binopIXX_1 : binopIXX} in_binop(binop, [binopIXX_1] :: binopIXX'*{binopIXX'}) = ((binop = _I_binop_numtype(binopIXX_1)) \/ $in_binop(binop, binopIXX'*{binopIXX'}))
}

;; 6-typing.watsup:973.1-973.63
rec {

;; 6-typing.watsup:973.1-973.63
def in_numtype : (numtype, numtype*) -> bool
  ;; 6-typing.watsup:974.1-974.37
  def {nt : numtype} in_numtype(nt, []) = false
  ;; 6-typing.watsup:975.1-975.68
  def {nt : numtype, nt'* : numtype*, nt_1 : numtype} in_numtype(nt, [nt_1] :: nt'*{nt'}) = ((nt = nt_1) \/ $in_numtype(nt, nt'*{nt'}))
}

;; 6-typing.watsup:956.1-956.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 6-typing.watsup:960.1-961.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 6-typing.watsup:963.1-964.27
  rule ref.null {C : context, ht : heaptype}:
    `%|-%CONST`(C, REF.NULL_instr(ht))

  ;; 6-typing.watsup:966.1-967.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 6-typing.watsup:969.1-971.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?()), t))

  ;; 6-typing.watsup:980.1-983.38
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%CONST`(C, BINOP_instr(nt, binop))
    -- if $in_numtype(nt, [I32_numtype I64_numtype])
    -- if $in_binop(binop, [ADD_binopIXX SUB_binopIXX MUL_binopIXX])

;; 6-typing.watsup:957.1-957.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 6-typing.watsup:986.1-987.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 6-typing.watsup:958.1-958.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 6-typing.watsup:990.1-993.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 6-typing.watsup:1002.1-1002.73
relation Type_ok: `%|-%:%*`(context, type, deftype*)
  ;; 6-typing.watsup:1014.1-1018.53
  rule _ {C : context, dt* : deftype*, rectype : rectype, x : idx}:
    `%|-%:%*`(C, TYPE(rectype), dt*{dt})
    -- if (x = |C.TYPE_context|)
    -- if (dt*{dt} = $rolldt(x, rectype))
    -- Rectype_ok: `%|-%:%`(C[TYPE_context =.. dt*{dt}], rectype, OK_oktypeidx(x))

;; 6-typing.watsup:1004.1-1004.74
relation Local_ok: `%|-%:%`(context, local, localtype)
  ;; 6-typing.watsup:1020.1-1022.32
  rule set {C : context, t : valtype}:
    `%|-%:%`(C, LOCAL(t), `%%`(SET_init, t))
    -- if ($default(t) =/= ?())

  ;; 6-typing.watsup:1024.1-1026.30
  rule unset {C : context, t : valtype}:
    `%|-%:%`(C, LOCAL(t), `%%`(UNSET_init, t))
    -- if ($default(t) = ?())

;; 6-typing.watsup:1003.1-1003.73
relation Func_ok: `%|-%:%`(context, func, deftype)
  ;; 6-typing.watsup:1028.1-1032.82
  rule _ {C : context, expr : expr, local* : local*, lt* : localtype*, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, `FUNC%%*%`(x, local*{local}, expr), C.TYPE_context[x])
    -- Expand: `%~~%`(C.TYPE_context[x], FUNC_comptype(`%->%`(t_1*{t_1}, t_2*{t_2})))
    -- (Local_ok: `%|-%:%`(C, local, lt))*{local lt}
    -- Expr_ok: `%|-%:%`(C ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL `%%`(SET_init, t_1)*{t_1} :: lt*{lt}, LABEL [], RETURN ?()} ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 6-typing.watsup:1005.1-1005.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 6-typing.watsup:1034.1-1038.40
  rule _ {C : context, expr : expr, gt : globaltype, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `%|-%:OK`(C, gt)
    -- if (gt = `%%`(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 6-typing.watsup:1006.1-1006.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 6-typing.watsup:1040.1-1042.32
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt, []), tt)
    -- Tabletype_ok: `%|-%:OK`(C, tt)

;; 6-typing.watsup:1007.1-1007.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 6-typing.watsup:1044.1-1046.30
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `%|-%:OK`(C, mt)

;; 6-typing.watsup:1010.1-1010.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 6-typing.watsup:1057.1-1060.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 6-typing.watsup:1062.1-1063.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 6-typing.watsup:1008.1-1008.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 6-typing.watsup:1048.1-1051.40
  rule _ {C : context, elemmode? : elemmode?, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%?`(rt, expr*{expr}, elemmode?{elemmode}), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [(rt <: valtype)]))*{expr}
    -- (Elemmode_ok: `%|-%:%`(C, elemmode, rt))?{elemmode}

;; 6-typing.watsup:1011.1-1011.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 6-typing.watsup:1065.1-1068.45
  rule _ {C : context, expr : expr, mt : memtype, x : idx}:
    `%|-%:OK`(C, MEMORY_datamode(x, expr))
    -- if (C.MEM_context[x] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

;; 6-typing.watsup:1009.1-1009.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 6-typing.watsup:1053.1-1055.40
  rule _ {C : context, b* : byte*, datamode? : datamode?}:
    `%|-%:OK`(C, `DATA%*%?`(b*{b}, datamode?{datamode}))
    -- (Datamode_ok: `%|-%:OK`(C, datamode))?{datamode}

;; 6-typing.watsup:1012.1-1012.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 6-typing.watsup:1070.1-1072.52
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- Expand: `%~~%`(C.FUNC_context[x], FUNC_comptype(`%->%`([], [])))

;; 6-typing.watsup:1077.1-1077.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 6-typing.watsup:1081.1-1083.33
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `%|-%:OK`(C, xt)

;; 6-typing.watsup:1079.1-1079.83
relation Externuse_ok: `%|-%:%`(context, externuse, externtype)
  ;; 6-typing.watsup:1090.1-1092.23
  rule func {C : context, dt : deftype, x : idx}:
    `%|-%:%`(C, FUNC_externuse(x), FUNC_externtype(dt))
    -- if (C.FUNC_context[x] = dt)

  ;; 6-typing.watsup:1094.1-1096.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externuse(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 6-typing.watsup:1098.1-1100.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externuse(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 6-typing.watsup:1102.1-1104.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externuse(x), MEM_externtype(mt))
    -- if (C.MEM_context[x] = mt)

;; 6-typing.watsup:1078.1-1078.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 6-typing.watsup:1085.1-1087.39
  rule _ {C : context, externuse : externuse, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externuse), xt)
    -- Externuse_ok: `%|-%:%`(C, externuse, xt)

;; 6-typing.watsup:1111.1-1111.77
rec {

;; 6-typing.watsup:1111.1-1111.77
relation Globals_ok: `%|-%*:%*`(context, global*, globaltype*)
  ;; 6-typing.watsup:1154.1-1155.25
  rule empty {C : context}:
    `%|-%*:%*`(C, [], [])

  ;; 6-typing.watsup:1157.1-1160.54
  rule cons {C : context, global : global, global_1 : global, gt* : globaltype*, gt_1 : globaltype}:
    `%|-%*:%*`(C, [global_1] :: global*{}, [gt_1] :: gt*{gt})
    -- Global_ok: `%|-%:%`(C, global, gt_1)
    -- Globals_ok: `%|-%*:%*`(C[GLOBAL_context =.. [gt_1]], global*{}, gt*{gt})
}

;; 6-typing.watsup:1110.1-1110.75
rec {

;; 6-typing.watsup:1110.1-1110.75
relation Types_ok: `%|-%*:%*`(context, type*, deftype*)
  ;; 6-typing.watsup:1146.1-1147.25
  rule empty {C : context}:
    `%|-%*:%*`(C, [], [])

  ;; 6-typing.watsup:1149.1-1152.49
  rule cons {C : context, dt* : deftype*, dt_1 : deftype, type* : type*, type_1 : type}:
    `%|-%*:%*`(C, [type_1] :: type*{type}, dt_1*{} :: dt*{dt})
    -- Type_ok: `%|-%:%*`(C, type_1, [dt_1])
    -- Types_ok: `%|-%*:%*`(C[TYPE_context =.. dt_1*{}], type*{type}, dt*{dt})
}

;; 6-typing.watsup:1109.1-1109.76
relation Module_ok: `|-%:OK`(module)
  ;; 6-typing.watsup:1120.1-1143.29
  rule _ {C : context, C' : context, data^n : data^n, dt* : deftype*, dt'* : deftype*, elem* : elem*, et* : externtype*, export* : export*, func* : func*, global* : global*, gt* : globaltype*, idt* : deftype*, igt* : globaltype*, import* : import*, imt* : memtype*, itt* : tabletype*, ixt* : externtype*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*, type* : type*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%*%?%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
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

  ;; 7-runtime-typing.watsup:10.1-11.41
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

  ;; 7-runtime-typing.watsup:25.1-26.43
  rule host {a : addr, s : store}:
    `%|-%:%`(s, REF.HOST_ADDR_ref(a), REF_reftype(`NULL%?`(?()), ANY_heaptype))

  ;; 7-runtime-typing.watsup:28.1-29.49
  rule extern {addrref : addrref, s : store}:
    `%|-%:%`(s, REF.EXTERN_ref(addrref), REF_reftype(`NULL%?`(?()), EXTERN_heaptype))

;; 8-reduction.watsup:6.1-6.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 8-reduction.watsup:42.1-43.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 8-reduction.watsup:45.1-46.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 8-reduction.watsup:48.1-49.24
  rule drop {val : val}:
    `%*~>%*`([(val <: admininstr) DROP_admininstr], [])

  ;; 8-reduction.watsup:52.1-54.16
  rule select-true {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([(val_1 <: admininstr) (val_2 <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [(val_1 <: admininstr)])
    -- if (c =/= 0)

  ;; 8-reduction.watsup:56.1-58.14
  rule select-false {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([(val_1 <: admininstr) (val_2 <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [(val_2 <: admininstr)])
    -- if (c = 0)

  ;; 8-reduction.watsup:63.1-65.28
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`((val <: admininstr)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})], [LABEL__admininstr(n, [], (val <: admininstr)^k{val} :: (instr <: admininstr)*{instr})])
    -- if (bt = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 8-reduction.watsup:67.1-69.28
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`((val <: admininstr)^k{val} :: [LOOP_admininstr(bt, instr*{instr})], [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], (val <: admininstr)^k{val} :: (instr <: admininstr)*{instr})])
    -- if (bt = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 8-reduction.watsup:71.1-73.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 8-reduction.watsup:75.1-77.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 8-reduction.watsup:80.1-81.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, (val <: admininstr)*{val})], (val <: admininstr)*{val})

  ;; 8-reduction.watsup:87.1-88.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [BR_admininstr(0)] :: (instr <: admininstr)*{instr})], (val <: admininstr)^n{val} :: (instr' <: admininstr)*{instr'})

  ;; 8-reduction.watsup:90.1-91.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val <: admininstr)*{val} :: [BR_admininstr(l + 1)] :: (instr <: admininstr)*{instr})], (val <: admininstr)*{val} :: [BR_admininstr(l)])

  ;; 8-reduction.watsup:94.1-96.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 8-reduction.watsup:98.1-100.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 8-reduction.watsup:103.1-105.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 8-reduction.watsup:107.1-109.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 8-reduction.watsup:112.1-114.26
  rule br_on_null-null {ht : heaptype, l : labelidx, val : val}:
    `%*~>%*`([(val <: admininstr) BR_ON_NULL_admininstr(l)], [BR_admininstr(l)])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup:116.1-118.15
  rule br_on_null-addr {l : labelidx, val : val}:
    `%*~>%*`([(val <: admininstr) BR_ON_NULL_admininstr(l)], [(val <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup:121.1-123.26
  rule br_on_non_null-null {ht : heaptype, l : labelidx, val : val}:
    `%*~>%*`([(val <: admininstr) BR_ON_NON_NULL_admininstr(l)], [])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup:125.1-127.15
  rule br_on_non_null-addr {l : labelidx, val : val}:
    `%*~>%*`([(val <: admininstr) BR_ON_NON_NULL_admininstr(l)], [(val <: admininstr) BR_admininstr(l)])
    -- otherwise

  ;; 8-reduction.watsup:174.1-175.84
  rule call_indirect-call {x : idx, y : idx}:
    `%*~>%*`([CALL_INDIRECT_admininstr(x, y)], [TABLE.GET_admininstr(x) REF.CAST_admininstr(REF_reftype(`NULL%?`(?(())), ($idx(y) <: heaptype))) CALL_REF_admininstr(y)])

  ;; 8-reduction.watsup:177.1-178.98
  rule return_call_indirect {x : idx, y : idx}:
    `%*~>%*`([RETURN_CALL_INDIRECT_admininstr(x, y)], [TABLE.GET_admininstr(x) REF.CAST_admininstr(REF_reftype(`NULL%?`(?(())), ($idx(y) <: heaptype))) RETURN_CALL_REF_admininstr(y)])

  ;; 8-reduction.watsup:189.1-190.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, (val <: admininstr)^n{val})], (val <: admininstr)^n{val})

  ;; 8-reduction.watsup:192.1-193.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [RETURN_admininstr] :: (instr <: admininstr)*{instr})], (val <: admininstr)^n{val})

  ;; 8-reduction.watsup:195.1-196.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, (val <: admininstr)*{val} :: [RETURN_admininstr] :: (instr <: admininstr)*{instr})], (val <: admininstr)*{val} :: [RETURN_admininstr])

  ;; 8-reduction.watsup:201.1-203.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 8-reduction.watsup:205.1-207.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 8-reduction.watsup:210.1-212.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 8-reduction.watsup:214.1-216.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 8-reduction.watsup:219.1-221.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 8-reduction.watsup:223.1-225.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 8-reduction.watsup:228.1-229.70
  rule extend {c : c_numtype, n : n, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, $size(nt <: valtype), S_sx, c))])

  ;; 8-reduction.watsup:232.1-234.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(cvtop, nt_1, nt_2, sx?{sx}, c_1) = [c])

  ;; 8-reduction.watsup:236.1-238.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(cvtop, nt_1, nt_2, sx?{sx}, c_1) = [])

  ;; 8-reduction.watsup:246.1-247.60
  rule ref.i31 {i : nat}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) REF.I31_admininstr], [REF.I31_NUM_admininstr($wrap(32, 31, i))])

  ;; 8-reduction.watsup:250.1-252.28
  rule ref.is_null-true {ht : heaptype, val : val}:
    `%*~>%*`([(val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(ht))

  ;; 8-reduction.watsup:254.1-256.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([(val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:259.1-261.28
  rule ref.as_non_null-null {ht : heaptype, ref : ref}:
    `%*~>%*`([(ref <: admininstr) REF.AS_NON_NULL_admininstr], [TRAP_admininstr])
    -- if (ref = REF.NULL_ref(ht))

  ;; 8-reduction.watsup:263.1-265.15
  rule ref.as_non_null-addr {ref : ref}:
    `%*~>%*`([(ref <: admininstr) REF.AS_NON_NULL_admininstr], [(ref <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup:268.1-270.55
  rule ref.eq-null {ht_1 : heaptype, ht_2 : heaptype, ref_1 : ref, ref_2 : ref}:
    `%*~>%*`([(ref_1 <: admininstr) (ref_2 <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if ((ref_1 = REF.NULL_ref(ht_1)) /\ (ref_2 = REF.NULL_ref(ht_2)))

  ;; 8-reduction.watsup:272.1-275.22
  rule ref.eq-true {ref_1 : ref, ref_2 : ref}:
    `%*~>%*`([(ref_1 <: admininstr) (ref_2 <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- otherwise
    -- if (ref_1 = ref_2)

  ;; 8-reduction.watsup:277.1-279.15
  rule ref.eq-false {ref_1 : ref, ref_2 : ref}:
    `%*~>%*`([(ref_1 <: admininstr) (ref_2 <: admininstr) REF.EQ_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:304.1-305.39
  rule i31.get-null {ht : heaptype, sx : sx}:
    `%*~>%*`([REF.NULL_admininstr(ht) I31.GET_admininstr(sx)], [TRAP_admininstr])

  ;; 8-reduction.watsup:307.1-308.68
  rule i31.get-num {i : nat, sx : sx}:
    `%*~>%*`([REF.I31_NUM_admininstr(i) I31.GET_admininstr(sx)], [CONST_admininstr(I32_numtype, $ext(31, 32, sx, i))])

  ;; 8-reduction.watsup:515.1-516.58
  rule extern.externalize-null {ht : heaptype}:
    `%*~>%*`([REF.NULL_admininstr(ht) EXTERN.EXTERNALIZE_admininstr], [REF.NULL_admininstr(EXTERN_heaptype)])

  ;; 8-reduction.watsup:518.1-519.55
  rule extern.externalize-addr {addrref : addrref}:
    `%*~>%*`([(addrref <: admininstr) EXTERN.EXTERNALIZE_admininstr], [REF.EXTERN_admininstr(addrref)])

  ;; 8-reduction.watsup:522.1-523.55
  rule extern.internalize-null {ht : heaptype}:
    `%*~>%*`([REF.NULL_admininstr(ht) EXTERN.INTERNALIZE_admininstr], [REF.NULL_admininstr(ANY_heaptype)])

  ;; 8-reduction.watsup:525.1-526.55
  rule extern.internalize-addr {addrref : addrref}:
    `%*~>%*`([REF.EXTERN_admininstr(addrref) EXTERN.INTERNALIZE_admininstr], [(addrref <: admininstr)])

  ;; 8-reduction.watsup:538.1-539.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([(val <: admininstr) LOCAL.TEE_admininstr(x)], [(val <: admininstr) (val <: admininstr) LOCAL.SET_admininstr(x)])

;; 8-reduction.watsup:7.1-7.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 8-reduction.watsup:130.1-133.66
  rule br_on_cast-succeed {l : labelidx, ref : ref, rt : reftype, rt_1 : reftype, rt_2 : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) BR_ON_CAST_admininstr(l, rt_1, rt_2)]), [(ref <: admininstr) BR_admininstr(l)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))

  ;; 8-reduction.watsup:135.1-137.15
  rule br_on_cast-fail {l : labelidx, ref : ref, rt_1 : reftype, rt_2 : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) BR_ON_CAST_admininstr(l, rt_1, rt_2)]), [(ref <: admininstr)])
    -- otherwise

  ;; 8-reduction.watsup:140.1-143.66
  rule br_on_cast_fail-succeed {l : labelidx, ref : ref, rt : reftype, rt_1 : reftype, rt_2 : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) BR_ON_CAST_FAIL_admininstr(l, rt_1, rt_2)]), [(ref <: admininstr)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt)
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt, $inst_reftype($moduleinst(z), rt_2))

  ;; 8-reduction.watsup:145.1-147.15
  rule br_on_cast_fail-fail {l : labelidx, ref : ref, rt_1 : reftype, rt_2 : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) BR_ON_CAST_FAIL_admininstr(l, rt_1, rt_2)]), [(ref <: admininstr) BR_admininstr(l)])
    -- otherwise

  ;; 8-reduction.watsup:152.1-153.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])

  ;; 8-reduction.watsup:155.1-156.42
  rule call_ref-null {ht : heaptype, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CALL_REF_admininstr(x)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:158.1-159.54
  rule call_ref-func {a : addr, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_ADDR_admininstr(a) CALL_REF_admininstr(x)]), [CALL_ADDR_admininstr(a)])

  ;; 8-reduction.watsup:162.1-163.60
  rule return_call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [RETURN_CALL_admininstr(x)]), [RETURN_CALL_REF_admininstr($funcaddr(z)[x])])

  ;; 8-reduction.watsup:165.1-167.59
  rule return_call_ref-frame {a : addr, f : frame, instr* : instr*, k : nat, m : nat, n : n, ref : ref, t_1^n : valtype^n, t_2^m : valtype^m, val^n : val^n, val'* : val*, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [FRAME__admininstr(k, f, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [(ref <: admininstr)] :: [RETURN_CALL_REF_admininstr(x)] :: (instr <: admininstr)*{instr})]), (val <: admininstr)^n{val} :: [(ref <: admininstr) CALL_REF_admininstr(x)])
    -- Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))

  ;; 8-reduction.watsup:169.1-171.59
  rule return_call_ref-label {a : addr, instr* : instr*, instr'* : instr*, k : nat, m : nat, n : n, ref : ref, t_1^n : valtype^n, t_2^m : valtype^m, val^n : val^n, val'* : val*, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LABEL__admininstr(k, instr'*{instr'}, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [(ref <: admininstr)] :: [RETURN_CALL_REF_admininstr(x)] :: (instr <: admininstr)*{instr})]), (val <: admininstr)^n{val} :: [(ref <: admininstr) RETURN_CALL_REF_admininstr(x)])
    -- Expand: `%~~%`($funcinst(z)[a].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))

  ;; 8-reduction.watsup:181.1-186.59
  rule call_addr {a : addr, f : frame, fi : funcinst, instr* : instr*, m : nat, n : n, t* : valtype*, t_1^n : valtype^n, t_2^m : valtype^m, val^n : val^n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, (val <: admininstr)^n{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(m, f, [LABEL__admininstr(m, [], (instr <: admininstr)*{instr})])])
    -- if ($funcinst(z)[a] = fi)
    -- Expand: `%~~%`(fi.TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2^m{t_2})))
    -- if (fi.CODE_funcinst = `FUNC%%*%`(x, LOCAL(t)*{t}, instr*{instr}))
    -- if (f = {LOCAL ?(val)^n{val} :: $default(t)*{t}, MODULE fi.MODULE_funcinst})

  ;; 8-reduction.watsup:243.1-244.55
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

  ;; 8-reduction.watsup:282.1-285.65
  rule ref.test-true {ref : ref, rt : reftype, rt' : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) REF.TEST_admininstr(rt)]), [CONST_admininstr(I32_numtype, 1)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))

  ;; 8-reduction.watsup:287.1-289.15
  rule ref.test-false {ref : ref, rt : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) REF.TEST_admininstr(rt)]), [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 8-reduction.watsup:292.1-295.65
  rule ref.cast-succeed {ref : ref, rt : reftype, rt' : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) REF.CAST_admininstr(rt)]), [(ref <: admininstr)])
    -- Ref_ok: `%|-%:%`($store(z), ref, rt')
    -- Reftype_sub: `%|-%<:%`({TYPE [], REC [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?()}, rt', $inst_reftype($moduleinst(z), rt))

  ;; 8-reduction.watsup:297.1-299.15
  rule ref.cast-fail {ref : ref, rt : reftype, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) REF.CAST_admininstr(rt)]), [TRAP_admininstr])
    -- otherwise

  ;; 8-reduction.watsup:318.1-321.43
  rule struct.new_default {mut* : mut*, val* : val*, x : idx, z : state, zt* : storagetype*}:
    `%~>%*`(`%;%*`(z, [STRUCT.NEW_DEFAULT_admininstr(x)]), (val <: admininstr)*{val} :: [STRUCT.NEW_admininstr(x)])
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- (if ($default($unpacktype(zt)) = ?(val)))*{val zt}

  ;; 8-reduction.watsup:324.1-325.50
  rule struct.get-null {ht : heaptype, i : nat, sx? : sx?, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) STRUCT.GET_admininstr(sx?{sx}, x, i)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:327.1-330.41
  rule struct.get-struct {a : addr, i : nat, mut* : mut*, si : structinst, sx? : sx?, x : idx, z : state, zt* : storagetype*}:
    `%~>%*`(`%;%*`(z, [REF.STRUCT_ADDR_admininstr(a) STRUCT.GET_admininstr(sx?{sx}, x, i)]), [($unpackval(zt*{zt}[i], sx?{sx}, si.FIELD_structinst[i]) <: admininstr)])
    -- if ($structinst(z)[a] = si)
    -- Expand: `%~~%`(si.TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))

  ;; 8-reduction.watsup:344.1-345.70
  rule array.new {n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [(val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.NEW_admininstr(x)]), (val <: admininstr)^n{} :: [ARRAY.NEW_FIXED_admininstr(x, n)])

  ;; 8-reduction.watsup:347.1-350.40
  rule array.new_default {mut : mut, n : n, val : val, x : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) ARRAY.NEW_DEFAULT_admininstr(x)]), (val <: admininstr)^n{} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ($default($unpacktype(zt)) = ?(val))

  ;; 8-reduction.watsup:358.1-360.38
  rule array.new_elem-oob {i : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$elem(z, y).ELEM_eleminst|)

  ;; 8-reduction.watsup:362.1-364.40
  rule array.new_elem-alloc {i : nat, n : n, ref^n : ref^n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_ELEM_admininstr(x, y)]), (ref <: admininstr)^n{ref} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- if (ref^n{ref} = $elem(z, y).ELEM_eleminst[i : n])

  ;; 8-reduction.watsup:367.1-370.59
  rule array.new_data-oob {i : nat, mut : mut, n : n, x : idx, y : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ((i + ((n * $storagesize(zt)) / 8)) > |$data(z, y).DATA_datainst|)

  ;; 8-reduction.watsup:372.1-376.85
  rule array.new_data-alloc {c^n : c_numtype^n, i : nat, mut : mut, n : n, nt : numtype, x : idx, y : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) ARRAY.NEW_DATA_admininstr(x, y)]), CONST_admininstr(nt, c)^n{c} :: [ARRAY.NEW_FIXED_admininstr(x, n)])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (nt = $unpacknumtype(zt))
    -- if ($bytes($storagesize(zt), c)^n{c} = [$data(z, y).DATA_datainst][i : ((n * $storagesize(zt)) / 8)])

  ;; 8-reduction.watsup:379.1-380.61
  rule array.get-null {ht : heaptype, i : nat, sx? : sx?, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) ARRAY.GET_admininstr(sx?{sx}, x)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:382.1-385.39
  rule array.get-array {a : addr, ai : arrayinst, i : nat, mut : mut, sx? : sx?, x : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) ARRAY.GET_admininstr(sx?{sx}, x)]), [($unpackval(zt, sx?{sx}, ai.FIELD_arrayinst[i]) <: admininstr)])
    -- if ($arrayinst(z)[a] = ai)
    -- Expand: `%~~%`(ai.TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))

  ;; 8-reduction.watsup:397.1-398.39
  rule array.len-null {ht : heaptype, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) ARRAY.LEN_admininstr]), [TRAP_admininstr])

  ;; 8-reduction.watsup:400.1-402.37
  rule array.len-array {a : addr, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) ARRAY.LEN_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (n = |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:405.1-406.76
  rule array.fill-null {ht : heaptype, i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:408.1-410.44
  rule array.fill-oob {a : addr, i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:412.1-415.14
  rule array.fill-zero {a : addr, i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:417.1-421.15
  rule array.fill-succ {a : addr, i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) ARRAY.FILL_admininstr(x)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (val <: admininstr) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup:423.1-424.102
  rule array.copy-null1 {ht_1 : heaptype, i_1 : nat, i_2 : nat, n : n, ref : ref, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht_1) CONST_admininstr(I32_numtype, i_1) (ref <: admininstr) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:426.1-427.102
  rule array.copy-null2 {ht_2 : heaptype, i_1 : nat, i_2 : nat, n : n, ref : ref, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, i_1) REF.NULL_admininstr(ht_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:429.1-431.48
  rule array.copy-oob1 {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if ((i_1 + n) > |$arrayinst(z)[a_1].FIELD_arrayinst|)

  ;; 8-reduction.watsup:433.1-435.48
  rule array.copy-oob2 {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if ((i_2 + n) > |$arrayinst(z)[a_2].FIELD_arrayinst|)

  ;; 8-reduction.watsup:437.1-440.14
  rule array.copy-zero {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:442.1-451.19
  rule array.copy-le {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, mut : mut, n : n, sx? : sx?, x : idx, x_1 : idx, x_2 : idx, z : state, zt_2 : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) ARRAY.GET_admininstr(sx?{sx}, x) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, (i_1 + 1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, (i_2 + 1)) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x_2), ARRAY_comptype(`%%`(mut, zt_2)))
    -- if (sx?{sx} = $sxfield(zt_2))
    -- if (i_1 <= i_2)

  ;; 8-reduction.watsup:453.1-459.15
  rule array.copy-gt {a_1 : addr, a_2 : addr, i_1 : nat, i_2 : nat, n : n, sx? : sx?, x : idx, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) ARRAY.COPY_admininstr(x_1, x_2)]), [REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, ((i_1 + n) - 1)) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, ((i_2 + n) - 1)) ARRAY.GET_admininstr(sx?{sx}, x) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a_1) CONST_admininstr(I32_numtype, i_1) REF.ARRAY_ADDR_admininstr(a_2) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.COPY_admininstr(x_1, x_2)])
    -- otherwise

  ;; 8-reduction.watsup:462.1-463.93
  rule array.init_elem-null {ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:465.1-467.44
  rule array.init_elem-oob1 {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:469.1-471.38
  rule array.init_elem-oob2 {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((j + n) > |$elem(z, y).ELEM_eleminst|)

  ;; 8-reduction.watsup:473.1-476.14
  rule array.init_elem-zero {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:478.1-483.34
  rule array.init_elem-succ {a : addr, i : nat, j : nat, n : n, ref : ref, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_ELEM_admininstr(x, y)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) (ref <: admininstr) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.INIT_ELEM_admininstr(x, y)])
    -- otherwise
    -- if (ref = $elem(z, y).ELEM_eleminst[j])

  ;; 8-reduction.watsup:486.1-487.93
  rule array.init_data-null {ht : heaptype, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.NULL_admininstr(ht) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])

  ;; 8-reduction.watsup:489.1-491.44
  rule array.init_data-oob1 {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- if ((i + n) > |$arrayinst(z)[a].FIELD_arrayinst|)

  ;; 8-reduction.watsup:493.1-496.59
  rule array.init_data-oob2 {a : addr, i : nat, j : nat, mut : mut, n : n, x : idx, y : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [TRAP_admininstr])
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if ((j + ((n * $storagesize(zt)) / 8)) > |$data(z, y).DATA_datainst|)

  ;; 8-reduction.watsup:498.1-501.14
  rule array.init_data-zero {a : addr, i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:503.1-510.79
  rule array.init_data-succ {a : addr, c : c_numtype, i : nat, j : nat, mut : mut, n : n, nt : numtype, x : idx, y : idx, z : state, zt : storagetype}:
    `%~>%*`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, n) ARRAY.INIT_DATA_admininstr(x, y)]), [REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) ARRAY.SET_admininstr(x) REF.ARRAY_ADDR_admininstr(a) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (n - 1)) ARRAY.INIT_DATA_admininstr(x, y)])
    -- otherwise
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (nt = $unpacknumtype(zt))
    -- if ($bytes($storagesize(zt), c) = $data(z, y).DATA_datainst[j : ($storagesize(zt) / 8)])

  ;; 8-reduction.watsup:531.1-533.27
  rule local.get {val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [(val <: admininstr)])
    -- if ($local(z, x) = ?(val))

  ;; 8-reduction.watsup:544.1-545.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [($global(z, x).VALUE_globalinst <: admininstr)])

  ;; 8-reduction.watsup:553.1-555.33
  rule table.get-oob {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:557.1-559.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [($table(z, x).ELEM_tableinst[i] <: admininstr)])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:570.1-572.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 8-reduction.watsup:583.1-585.39
  rule table.fill-oob {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:587.1-590.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:592.1-596.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) (val <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup:599.1-601.73
  rule table.copy-oob {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 8-reduction.watsup:603.1-606.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:608.1-613.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 8-reduction.watsup:615.1-619.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup:622.1-624.72
  rule table.init-oob {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 8-reduction.watsup:626.1-629.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:631.1-635.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) ($elem(z, y).ELEM_eleminst[i] <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 8-reduction.watsup:644.1-646.53
  rule load-num-oob {i : nat, n_A : n, n_O : n, nt : numtype, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), x, n_A, n_O)]), [TRAP_admininstr])
    -- if (((i + n_O) + ($size(nt <: valtype) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:648.1-650.70
  rule load-num-val {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), x, n_A, n_O)]), [CONST_admininstr(nt, c)])
    -- if ($bytes($size(nt <: valtype), c) = $mem(z, x).DATA_meminst[(i + n_O) : ($size(nt <: valtype) / 8)])

  ;; 8-reduction.watsup:652.1-654.45
  rule load-pack-oob {i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), x, n_A, n_O)]), [TRAP_admininstr])
    -- if (((i + n_O) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:656.1-658.54
  rule load-pack-val {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), x, n_A, n_O)]), [CONST_admininstr(nt, $ext(n, $size(nt <: valtype), sx, c))])
    -- if ($bytes(n, c) = $mem(z, x).DATA_meminst[(i + n_O) : (n / 8)])

  ;; 8-reduction.watsup:678.1-680.44
  rule memory.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:691.1-693.37
  rule memory.fill-oob {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:695.1-698.14
  rule memory.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:700.1-704.15
  rule memory.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) (val <: admininstr) STORE_admininstr(I32_numtype, ?(8), x, 0, 0) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr(x)])
    -- otherwise

  ;; 8-reduction.watsup:707.1-709.77
  rule memory.copy-oob {i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [TRAP_admininstr])
    -- if (((i_1 + n) > |$mem(z, x_1).DATA_meminst|) \/ ((i_2 + n) > |$mem(z, x_2).DATA_meminst|))

  ;; 8-reduction.watsup:711.1-714.14
  rule memory.copy-zero {i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:716.1-721.19
  rule memory.copy-le {i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) LOAD_admininstr(I32_numtype, ?((8, U_sx)), x_2, 0, 0) STORE_admininstr(I32_numtype, ?(8), x_1, 0, 0) CONST_admininstr(I32_numtype, (i_1 + 1)) CONST_admininstr(I32_numtype, (i_2 + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr(x_1, x_2)])
    -- otherwise
    -- if (i_1 <= i_2)

  ;; 8-reduction.watsup:723.1-727.15
  rule memory.copy-gt {i_1 : nat, i_2 : nat, n : n, x_1 : idx, x_2 : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr(x_1, x_2)]), [CONST_admininstr(I32_numtype, ((i_1 + n) - 1)) CONST_admininstr(I32_numtype, ((i_2 + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), x_2, 0, 0) STORE_admininstr(I32_numtype, ?(8), x_1, 0, 0) CONST_admininstr(I32_numtype, i_1) CONST_admininstr(I32_numtype, i_2) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr(x_1, x_2)])
    -- otherwise

  ;; 8-reduction.watsup:730.1-732.70
  rule memory.init-oob {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, y).DATA_datainst|) \/ ((j + n) > |$mem(z, x).DATA_meminst|))

  ;; 8-reduction.watsup:734.1-737.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 8-reduction.watsup:739.1-743.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, y).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), x, 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x, y)])
    -- otherwise

;; 8-reduction.watsup:5.1-5.63
relation Step: `%~>%`(config, config)
  ;; 8-reduction.watsup:9.1-11.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*{instr}), `%;%*`(z, (instr' <: admininstr)*{instr'}))
    -- Step_pure: `%*~>%*`((instr <: admininstr)*{instr}, (instr' <: admininstr)*{instr'})

  ;; 8-reduction.watsup:13.1-15.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*{instr}), `%;%*`(z, (instr' <: admininstr)*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, (instr <: admininstr)*{instr}), (instr' <: admininstr)*{instr'})

  ;; 8-reduction.watsup:313.1-316.61
  rule struct.new {mut^n : mut^n, n : n, si : structinst, val^n : val^n, x : idx, z : state, zt^n : storagetype^n}:
    `%~>%`(`%;%*`(z, (val <: admininstr)^n{val} :: [STRUCT.NEW_admininstr(x)]), `%;%*`($ext_structinst(z, [si]), [REF.STRUCT_ADDR_admininstr(|$structinst(z)|)]))
    -- Expand: `%~~%`($type(z, x), STRUCT_comptype(`%%`(mut, zt)^n{mut zt}))
    -- if (si = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val zt}})

  ;; 8-reduction.watsup:333.1-334.53
  rule struct.set-null {ht : heaptype, i : nat, val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [REF.NULL_admininstr(ht) (val <: admininstr) STRUCT.SET_admininstr(x, i)]), `%;%*`(z, [TRAP_admininstr]))

  ;; 8-reduction.watsup:336.1-339.35
  rule struct.set-struct {a : addr, fv : fieldval, i : nat, mut* : mut*, val : val, x : idx, z : state, zt* : storagetype*}:
    `%~>%`(`%;%*`(z, [REF.STRUCT_ADDR_admininstr(a) (val <: admininstr) STRUCT.SET_admininstr(x, i)]), `%;%*`($with_struct(z, a, i, fv), []))
    -- Expand: `%~~%`($structinst(z)[a].TYPE_structinst, STRUCT_comptype(`%%`(mut, zt)*{mut zt}))
    -- if (fv = $packval(zt*{zt}[i], val))

  ;; 8-reduction.watsup:352.1-355.61
  rule array.new_fixed {ai : arrayinst, mut : mut, n : n, val^n : val^n, x : idx, z : state, zt : storagetype}:
    `%~>%`(`%;%*`(z, (val <: admininstr)^n{val} :: [ARRAY.NEW_FIXED_admininstr(x, n)]), `%;%*`($ext_arrayinst(z, [ai]), [REF.ARRAY_ADDR_admininstr(|$arrayinst(z)|)]))
    -- Expand: `%~~%`($type(z, x), ARRAY_comptype(`%%`(mut, zt)))
    -- if (ai = {TYPE $type(z, x), FIELD $packval(zt, val)^n{val}})

  ;; 8-reduction.watsup:388.1-389.50
  rule array.set-null {ht : heaptype, val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [REF.NULL_admininstr(ht) (val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))

  ;; 8-reduction.watsup:391.1-394.31
  rule array.set-array {a : addr, fv : fieldval, i : nat, mut : mut, val : val, x : idx, z : state, zt : storagetype}:
    `%~>%`(`%;%*`(z, [REF.ARRAY_ADDR_admininstr(a) (val <: admininstr) ARRAY.SET_admininstr(x)]), `%;%*`($with_array(z, a, i, fv), []))
    -- Expand: `%~~%`($arrayinst(z)[a].TYPE_arrayinst, ARRAY_comptype(`%%`(mut, zt)))
    -- if (fv = $packval(zt, val))

  ;; 8-reduction.watsup:535.1-536.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(val <: admininstr) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 8-reduction.watsup:547.1-548.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(val <: admininstr) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 8-reduction.watsup:561.1-563.33
  rule table.set-oob {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:565.1-567.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 8-reduction.watsup:575.1-577.46
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if ($growtable($table(z, x), n, ref) = ti)

  ;; 8-reduction.watsup:579.1-580.64
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 8-reduction.watsup:638.1-639.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 8-reduction.watsup:661.1-663.53
  rule store-num-oob {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), x, n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + n_O) + ($size(nt <: valtype) / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:665.1-667.34
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), x, n_A, n_O)]), `%;%*`($with_mem(z, x, (i + n_O), ($size(nt <: valtype) / 8), b*{b}), []))
    -- if (b*{b} = $bytes($size(nt <: valtype), c))

  ;; 8-reduction.watsup:669.1-671.45
  rule store-pack-oob {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), x, n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + n_O) + (n / 8)) > |$mem(z, x).DATA_meminst|)

  ;; 8-reduction.watsup:673.1-675.47
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), x, n_A, n_O)]), `%;%*`($with_mem(z, x, (i + n_O), (n / 8), b*{b}), []))
    -- if (b*{b} = $bytes(n, $wrap($size(nt <: valtype), n, c)))

  ;; 8-reduction.watsup:683.1-685.40
  rule memory.grow-succeed {mi : meminst, n : n, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr(x)]), `%;%*`($with_meminst(z, x, mi), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- if ($growmemory($mem(z, x), n) = mi)

  ;; 8-reduction.watsup:687.1-688.61
  rule memory.grow-fail {n : n, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 8-reduction.watsup:746.1-747.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 8-reduction.watsup:20.1-20.59
rec {

;; 8-reduction.watsup:20.1-20.59
relation Eval: `%~>*%;%*`(config, state, val*)
  ;; 8-reduction.watsup:23.1-24.22
  rule done {val* : val*, z : state}:
    `%~>*%;%*`(`%;%*`(z, (val <: admininstr)*{val}), z, val*{val})

  ;; 8-reduction.watsup:26.1-29.43
  rule step {admininstr* : admininstr*, admininstr' : admininstr, val* : val*, z : state, z' : state, z'' : state}:
    `%~>*%;%*`(`%;%*`(z, admininstr*{admininstr}), z'', val*{val})
    -- Step: `%~>%`(`%;%*`(z, admininstr*{admininstr}), `%;%*`(z', admininstr'*{}))
    -- Eval: `%~>*%;%*`(`%;%*`(z', [admininstr']), z'', val*{val})
}

;; 8-reduction.watsup:21.1-21.69
relation Eval_expr: `%;%~>*%;%*`(state, expr, state, val*)
  ;; 8-reduction.watsup:31.1-33.35
  rule _ {instr* : instr*, val* : val*, z : state, z' : state}:
    `%;%~>*%;%*`(z, instr*{instr}, z', val*{val})
    -- Eval: `%~>*%;%*`(`%;%*`(z, (instr <: admininstr)*{instr}), z, val*{val})

;; 9-module.watsup:7.1-7.37
rec {

;; 9-module.watsup:7.1-7.37
def alloctypes : rectype* -> deftype*
  ;; 9-module.watsup:8.1-8.35
  def alloctypes([]) = []
  ;; 9-module.watsup:9.1-12.24
  def {deftype* : deftype*, deftype'* : deftype*, rectype : rectype, rectype'* : rectype*, x : idx} alloctypes(rectype'*{rectype'} :: [rectype]) = deftype'*{deftype'} :: deftype*{deftype}
    -- if (deftype'*{deftype'} = $alloctypes(rectype'*{rectype'}))
    -- if (deftype*{deftype} = $subst_all_deftypes($rolldt(x, rectype), (deftype' <: heaptype)*{deftype'}))
    -- if (x = |deftype'*{deftype'}|)
}

;; 9-module.watsup:14.1-14.60
def allocfunc : (store, moduleinst, func) -> (store, funcaddr)
  ;; 9-module.watsup:15.1-17.55
  def {expr : expr, fi : funcinst, func : func, local* : local*, mm : moduleinst, s : store, x : idx} allocfunc(s, mm, func) = (s[FUNC_store =.. [fi]], |s.FUNC_store|)
    -- if (func = `FUNC%%*%`(x, local*{local}, expr))
    -- if (fi = {TYPE mm.TYPE_moduleinst[x], MODULE mm, CODE func})

;; 9-module.watsup:19.1-19.63
rec {

;; 9-module.watsup:19.1-19.63
def allocfuncs : (store, moduleinst, func*) -> (store, funcaddr*)
  ;; 9-module.watsup:20.1-20.47
  def {mm : moduleinst, s : store} allocfuncs(s, mm, []) = (s, [])
  ;; 9-module.watsup:21.1-23.51
  def {fa : funcaddr, fa'* : funcaddr*, func : func, func'* : func*, mm : moduleinst, s : store, s_1 : store, s_2 : store} allocfuncs(s, mm, [func] :: func'*{func'}) = (s_2, [fa] :: fa'*{fa'})
    -- if ((s_1, fa) = $allocfunc(s, mm, func))
    -- if ((s_2, fa'*{fa'}) = $allocfuncs(s_1, mm, func'*{func'}))
}

;; 9-module.watsup:25.1-25.63
def allocglobal : (store, globaltype, val) -> (store, globaladdr)
  ;; 9-module.watsup:26.1-27.44
  def {gi : globalinst, globaltype : globaltype, s : store, val : val} allocglobal(s, globaltype, val) = (s[GLOBAL_store =.. [gi]], |s.GLOBAL_store|)
    -- if (gi = {TYPE globaltype, VALUE val})

;; 9-module.watsup:29.1-29.67
rec {

;; 9-module.watsup:29.1-29.67
def allocglobals : (store, globaltype*, val*) -> (store, globaladdr*)
  ;; 9-module.watsup:30.1-30.54
  def {s : store} allocglobals(s, [], []) = (s, [])
  ;; 9-module.watsup:31.1-33.62
  def {ga : globaladdr, ga'* : globaladdr*, globaltype : globaltype, globaltype'* : globaltype*, s : store, s_1 : store, s_2 : store, val : val, val'* : val*} allocglobals(s, [globaltype] :: globaltype'*{globaltype'}, [val] :: val'*{val'}) = (s_2, [ga] :: ga'*{ga'})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga'}) = $allocglobals(s_1, globaltype'*{globaltype'}, val'*{val'}))
}

;; 9-module.watsup:35.1-35.60
def alloctable : (store, tabletype, ref) -> (store, tableaddr)
  ;; 9-module.watsup:36.1-37.49
  def {i : nat, j : nat, ref : ref, rt : reftype, s : store, ti : tableinst} alloctable(s, `%%`(`[%..%]`(i, j), rt), ref) = (s[TABLE_store =.. [ti]], |s.TABLE_store|)
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM ref^i{}})

;; 9-module.watsup:39.1-39.64
rec {

;; 9-module.watsup:39.1-39.64
def alloctables : (store, tabletype*, ref*) -> (store, tableaddr*)
  ;; 9-module.watsup:40.1-40.53
  def {s : store} alloctables(s, [], []) = (s, [])
  ;; 9-module.watsup:41.1-43.60
  def {ref : ref, ref'* : ref*, s : store, s_1 : store, s_2 : store, ta : tableaddr, ta'* : tableaddr*, tabletype : tabletype, tabletype'* : tabletype*} alloctables(s, [tabletype] :: tabletype'*{tabletype'}, [ref] :: ref'*{ref'}) = (s_2, [ta] :: ta'*{ta'})
    -- if ((s_1, ta) = $alloctable(s, tabletype, ref))
    -- if ((s_2, ta'*{ta'}) = $alloctables(s_1, tabletype'*{tabletype'}, ref'*{ref'}))
}

;; 9-module.watsup:45.1-45.49
def allocmem : (store, memtype) -> (store, memaddr)
  ;; 9-module.watsup:46.1-47.62
  def {i : nat, j : nat, mi : meminst, s : store} allocmem(s, `%I8`(`[%..%]`(i, j))) = (s[MEM_store =.. [mi]], |s.MEM_store|)
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA 0^((i * 64) * $Ki){}})

;; 9-module.watsup:49.1-49.52
rec {

;; 9-module.watsup:49.1-49.52
def allocmems : (store, memtype*) -> (store, memaddr*)
  ;; 9-module.watsup:50.1-50.42
  def {s : store} allocmems(s, []) = (s, [])
  ;; 9-module.watsup:51.1-53.49
  def {ma : memaddr, ma'* : memaddr*, memtype : memtype, memtype'* : memtype*, s : store, s_1 : store, s_2 : store} allocmems(s, [memtype] :: memtype'*{memtype'}) = (s_2, [ma] :: ma'*{ma'})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma'}) = $allocmems(s_1, memtype'*{memtype'}))
}

;; 9-module.watsup:55.1-55.57
def allocelem : (store, reftype, ref*) -> (store, elemaddr)
  ;; 9-module.watsup:56.1-57.36
  def {ei : eleminst, ref* : ref*, rt : reftype, s : store} allocelem(s, rt, ref*{ref}) = (s[ELEM_store =.. [ei]], |s.ELEM_store|)
    -- if (ei = {TYPE rt, ELEM ref*{ref}})

;; 9-module.watsup:59.1-59.63
rec {

;; 9-module.watsup:59.1-59.63
def allocelems : (store, reftype*, ref**) -> (store, elemaddr*)
  ;; 9-module.watsup:60.1-60.52
  def {s : store} allocelems(s, [], []) = (s, [])
  ;; 9-module.watsup:61.1-63.55
  def {ea : elemaddr, ea'* : elemaddr*, ref* : ref*, ref'** : ref**, rt : reftype, rt'* : reftype*, s : store, s_1 : store, s_2 : store} allocelems(s, [rt] :: rt'*{rt'}, [ref*{ref}] :: ref'*{ref'}*{ref'}) = (s_2, [ea] :: ea'*{ea'})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref}))
    -- if ((s_2, ea'*{ea'}) = $allocelems(s_2, rt'*{rt'}, ref'*{ref'}*{ref'}))
}

;; 9-module.watsup:65.1-65.49
def allocdata : (store, byte*) -> (store, dataaddr)
  ;; 9-module.watsup:66.1-67.28
  def {byte* : byte*, di : datainst, s : store} allocdata(s, byte*{byte}) = (s[DATA_store =.. [di]], |s.DATA_store|)
    -- if (di = {DATA byte*{byte}})

;; 9-module.watsup:69.1-69.54
rec {

;; 9-module.watsup:69.1-69.54
def allocdatas : (store, byte**) -> (store, dataaddr*)
  ;; 9-module.watsup:70.1-70.43
  def {s : store} allocdatas(s, []) = (s, [])
  ;; 9-module.watsup:71.1-73.50
  def {byte* : byte*, byte'** : byte**, da : dataaddr, da'* : dataaddr*, s : store, s_1 : store, s_2 : store} allocdatas(s, [byte*{byte}] :: byte'*{byte'}*{byte'}) = (s_2, [da] :: da'*{da'})
    -- if ((s_1, da) = $allocdata(s, byte*{byte}))
    -- if ((s_2, da'*{da'}) = $allocdatas(s_1, byte'*{byte'}*{byte'}))
}

;; 9-module.watsup:78.1-78.83
def instexport : (funcaddr*, globaladdr*, tableaddr*, memaddr*, export) -> exportinst
  ;; 9-module.watsup:79.1-79.95
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, FUNC_externuse(x))) = {NAME name, VALUE FUNC_externval(fa*{fa}[x])}
  ;; 9-module.watsup:80.1-80.99
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, GLOBAL_externuse(x))) = {NAME name, VALUE GLOBAL_externval(ga*{ga}[x])}
  ;; 9-module.watsup:81.1-81.97
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, TABLE_externuse(x))) = {NAME name, VALUE TABLE_externval(ta*{ta}[x])}
  ;; 9-module.watsup:82.1-82.93
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, MEM_externuse(x))) = {NAME name, VALUE MEM_externval(ma*{ma}[x])}

;; 9-module.watsup:85.1-85.87
def allocmodule : (store, module, externval*, val*, ref*, ref**) -> (store, moduleinst)
  ;; 9-module.watsup:86.1-126.51
  def {byte*^n_d : byte*^n_d, da* : dataaddr*, datamode?^n_d : datamode?^n_d, dt* : deftype*, ea* : elemaddr*, elemmode?^n_e : elemmode?^n_e, export* : export*, expr_e*^n_e : expr*^n_e, expr_g^n_g : expr^n_g, expr_t^n_t : expr^n_t, externval* : externval*, fa* : funcaddr*, fa_ex* : funcaddr*, func^n_f : func^n_f, ga* : globaladdr*, ga_ex* : globaladdr*, globaltype^n_g : globaltype^n_g, i_d^n_d : nat^n_d, i_e^n_e : nat^n_e, i_f^n_f : nat^n_f, i_g^n_g : nat^n_g, i_m^n_m : nat^n_m, i_t^n_t : nat^n_t, import* : import*, ma* : memaddr*, ma_ex* : memaddr*, memtype^n_m : memtype^n_m, mm : moduleinst, module : module, n_d : n, n_e : n, n_f : n, n_g : n, n_m : n, n_t : n, rectype* : rectype*, ref_e** : ref**, ref_t* : ref*, reftype^n_e : reftype^n_e, s : store, s_1 : store, s_2 : store, s_3 : store, s_4 : store, s_5 : store, s_6 : store, start? : start?, ta* : tableaddr*, ta_ex* : tableaddr*, tabletype^n_t : tabletype^n_t, val_g* : val*, xi* : exportinst*} allocmodule(s, module, externval*{externval}, val_g*{val_g}, ref_t*{ref_t}, ref_e*{ref_e}*{ref_e}) = (s_6, mm)
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%?%*`(TYPE(rectype)*{rectype}, import*{import}, func^n_f{func}, GLOBAL(globaltype, expr_g)^n_g{expr_g globaltype}, TABLE(tabletype, expr_t)^n_t{expr_t tabletype}, MEMORY(memtype)^n_m{memtype}, `ELEM%%*%?`(reftype, expr_e*{expr_e}, elemmode?{elemmode})^n_e{elemmode expr_e reftype}, `DATA%*%?`(byte*{byte}, datamode?{datamode})^n_d{byte datamode}, start?{start}, export*{export}))
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
    -- if (mm = {TYPE $alloctypes(rectype*{rectype}), FUNC fa_ex*{fa_ex} :: fa*{fa}, GLOBAL ga_ex*{ga_ex} :: ga*{ga}, TABLE ta_ex*{ta_ex} :: ta*{ta}, MEM ma_ex*{ma_ex} :: ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT xi*{xi}})
    -- if (dt*{dt} = $alloctypes(rectype*{rectype}))
    -- if ((s_1, fa*{fa}) = $allocfuncs(s, mm, func^n_f{func}))
    -- if ((s_2, ga*{ga}) = $allocglobals(s_1, globaltype^n_g{globaltype}, val_g*{val_g}))
    -- if ((s_3, ta*{ta}) = $alloctables(s_2, tabletype^n_t{tabletype}, ref_t*{ref_t}))
    -- if ((s_4, ma*{ma}) = $allocmems(s_3, memtype^n_m{memtype}))
    -- if ((s_5, ea*{ea}) = $allocelems(s_4, reftype^n_e{reftype}, ref_e*{ref_e}*{ref_e}))
    -- if ((s_6, da*{da}) = $allocdatas(s_5, byte*{byte}^n_d{byte}))

;; 9-module.watsup:133.1-133.38
rec {

;; 9-module.watsup:133.1-133.38
def concat_instr : instr** -> instr*
  ;; 9-module.watsup:134.1-134.37
  def concat_instr([]) = []
  ;; 9-module.watsup:135.1-135.74
  def {instr* : instr*, instr'** : instr**} concat_instr([instr*{instr}] :: instr'*{instr'}*{instr'}) = instr*{instr} :: $concat_instr(instr'*{instr'}*{instr'})
}

;; 9-module.watsup:137.1-137.33
def runelem : (elem, idx) -> instr*
  ;; 9-module.watsup:138.1-138.46
  def {expr* : expr*, reftype : reftype, y : idx} runelem(`ELEM%%*%?`(reftype, expr*{expr}, ?()), y) = []
  ;; 9-module.watsup:139.1-139.62
  def {expr* : expr*, reftype : reftype, y : idx} runelem(`ELEM%%*%?`(reftype, expr*{expr}, ?(DECLARE_elemmode)), y) = [ELEM.DROP_instr(y)]
  ;; 9-module.watsup:140.1-141.77
  def {expr* : expr*, instr* : instr*, reftype : reftype, x : idx, y : idx} runelem(`ELEM%%*%?`(reftype, expr*{expr}, ?(TABLE_elemmode(x, instr*{instr}))), y) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, |expr*{expr}|) TABLE.INIT_instr(x, y) ELEM.DROP_instr(y)]

;; 9-module.watsup:143.1-143.33
def rundata : (data, idx) -> instr*
  ;; 9-module.watsup:144.1-144.38
  def {byte* : byte*, y : idx} rundata(`DATA%*%?`(byte*{byte}, ?()), y) = []
  ;; 9-module.watsup:145.1-146.78
  def {byte* : byte*, instr* : instr*, x : idx, y : idx} rundata(`DATA%*%?`(byte*{byte}, ?(MEMORY_datamode(x, instr*{instr}))), y) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, |byte*{byte}|) MEMORY.INIT_instr(x, y) DATA.DROP_instr(y)]

;; 9-module.watsup:148.1-148.53
def instantiate : (store, module, externval*) -> config
  ;; 9-module.watsup:149.1-174.64
  def {data* : data*, elem* : elem*, elemmode?* : elemmode?*, export* : export*, expr_e** : expr**, expr_g* : expr*, expr_t* : expr*, externval* : externval*, f : frame, func^n_func : func^n_func, global* : global*, globaltype* : globaltype*, i^n_e : nat^n_e, i_func^n_func : nat^n_func, import* : import*, instr_d* : instr*, instr_e* : instr*, j^n_d : nat^n_d, mem* : mem*, mm : moduleinst, mm_init : moduleinst, module : module, n_d : n, n_e : n, n_func : n, ref_e** : ref**, ref_t* : ref*, reftype* : reftype*, s : store, s' : store, start? : start?, table* : table*, tabletype* : tabletype*, type* : type*, val_g* : val*, x? : idx?, z : state} instantiate(s, module, externval*{externval}) = `%;%*`(`%;%`(s', f), (instr_e <: admininstr)*{instr_e} :: (instr_d <: admininstr)*{instr_d} :: CALL_admininstr(x)?{x})
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%?%*`(type*{type}, import*{import}, func^n_func{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (global*{global} = GLOBAL(globaltype, expr_g)*{expr_g globaltype})
    -- if (table*{table} = TABLE(tabletype, expr_t)*{expr_t tabletype})
    -- if (elem*{elem} = `ELEM%%*%?`(reftype, expr_e*{expr_e}, elemmode?{elemmode})*{elemmode expr_e reftype})
    -- if (start?{start} = START(x)?{x})
    -- if (n_e = |elem*{elem}|)
    -- if (n_d = |data*{data}|)
    -- if (mm_init = {TYPE [], FUNC $funcsxv(externval*{externval}) :: (|s.FUNC_store| + i_func)^(i_func<n_func){i_func}, GLOBAL $globalsxv(externval*{externval}), TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (z = `%;%`(s, {LOCAL [], MODULE mm_init}))
    -- (Eval_expr: `%;%~>*%;%*`(z, expr_g, z, [val_g]))*{expr_g val_g}
    -- (Eval_expr: `%;%~>*%;%*`(z, expr_t, z, [(ref_t <: val)]))*{expr_t ref_t}
    -- (Eval_expr: `%;%~>*%;%*`(z, expr_e, z, [(ref_e <: val)]))*{expr_e ref_e}*{expr_e ref_e}
    -- if ((s', mm) = $allocmodule(s, module, externval*{externval}, val_g*{val_g}, ref_t*{ref_t}, ref_e*{ref_e}*{ref_e}))
    -- if (f = {LOCAL [], MODULE mm})
    -- if (instr_e*{instr_e} = $concat_instr($runelem(elem*{elem}[i], i)^(i<n_e){i}))
    -- if (instr_d*{instr_d} = $concat_instr($rundata(data*{data}[j], j)^(j<n_d){j}))

;; 9-module.watsup:181.1-181.44
def invoke : (store, funcaddr, val*) -> config
  ;; 9-module.watsup:182.1-195.53
  def {expr : expr, f : frame, fa : funcaddr, local* : local*, mm : moduleinst, n : n, s : store, t_1^n : valtype^n, t_2* : valtype*, val^n : val^n, x : idx} invoke(s, fa, val^n{val}) = `%;%*`(`%;%`(s, f), (val <: admininstr)^n{val} :: [REF.FUNC_ADDR_admininstr(fa) CALL_REF_admininstr(0)])
    -- if (mm = {TYPE [s.FUNC_store[fa].TYPE_funcinst], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE mm})
    -- if ($funcinst(`%;%`(s, f))[fa].CODE_funcinst = `FUNC%%*%`(x, local*{local}, expr))
    -- Expand: `%~~%`(s.FUNC_store[fa].TYPE_funcinst, FUNC_comptype(`%->%`(t_1^n{t_1}, t_2*{t_2})))

== IL Validation...
== Complete.
```
