# Preview

```sh
$ (cd ../spec && ../src/exe-watsup/main.exe *.watsup -l --print-all-il --all-passes --check)
== Parsing...
== Elaboration...

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:4.1-4.15
syntax m = nat

;; 1-syntax.watsup:18.1-18.50
syntax byte = nat

;; 1-syntax.watsup:21.1-21.58
syntax uN = nat

;; 1-syntax.watsup:22.1-22.87
syntax sN = nat

;; 1-syntax.watsup:23.1-23.36
syntax iN = uN

;; 1-syntax.watsup:26.1-26.58
syntax u32 = nat

;; 1-syntax.watsup:27.1-27.58
syntax u64 = nat

;; 1-syntax.watsup:28.1-28.61
syntax u128 = nat

;; 1-syntax.watsup:29.1-29.69
syntax s33 = nat

;; 1-syntax.watsup:34.1-34.21
def signif : nat -> nat
  ;; 1-syntax.watsup:35.1-35.21
  def signif(32) = 23
  ;; 1-syntax.watsup:36.1-36.21
  def signif(64) = 52

;; 1-syntax.watsup:38.1-38.20
def expon : nat -> nat
  ;; 1-syntax.watsup:39.1-39.19
  def expon(32) = 8
  ;; 1-syntax.watsup:40.1-40.20
  def expon(64) = 11

;; 1-syntax.watsup:42.1-42.35
def M : nat -> nat
  ;; 1-syntax.watsup:43.1-43.23
  def {N : nat} M(N) = $signif(N)

;; 1-syntax.watsup:45.1-45.35
def E : nat -> nat
  ;; 1-syntax.watsup:46.1-46.22
  def {N : nat} E(N) = $expon(N)

;; 1-syntax.watsup:51.1-55.81
syntax fNmag =
  |  {N : nat, n : n}NORM(m, n)
    -- if (((2 - (2 ^ ($E(N) - 1))) <= n) /\ (n <= ((2 ^ ($E(N) - 1)) - 1)))
  |  {N : nat, n : n}SUBNORM(m, n)
    -- if ((2 - (2 ^ ($E(N) - 1))) = n)
  | INF
  |  {N : nat, n : n}NAN(n)
    -- if ((1 <= n) /\ (n < $M(N)))

;; 1-syntax.watsup:49.1-49.107
syntax fN =
  | POS(fNmag)
  | NEG(fNmag)

;; 1-syntax.watsup:58.1-58.35
def fNzero : fN
  ;; 1-syntax.watsup:59.1-59.29
  def fNzero = POS_fN(NORM_fNmag(0, 0))

;; 1-syntax.watsup:62.1-62.51
syntax f32 = fN

;; 1-syntax.watsup:63.1-63.51
syntax f64 = fN

;; 1-syntax.watsup:71.1-71.85
syntax char = nat

;; 1-syntax.watsup:73.1-73.38
syntax name = char*

;; 1-syntax.watsup:80.1-80.36
syntax idx = u32

;; 1-syntax.watsup:81.1-81.45
syntax typeidx = idx

;; 1-syntax.watsup:82.1-82.49
syntax funcidx = idx

;; 1-syntax.watsup:83.1-83.49
syntax globalidx = idx

;; 1-syntax.watsup:84.1-84.47
syntax tableidx = idx

;; 1-syntax.watsup:85.1-85.46
syntax memidx = idx

;; 1-syntax.watsup:86.1-86.45
syntax elemidx = idx

;; 1-syntax.watsup:87.1-87.45
syntax dataidx = idx

;; 1-syntax.watsup:88.1-88.47
syntax labelidx = idx

;; 1-syntax.watsup:89.1-89.47
syntax localidx = idx

;; 1-syntax.watsup:98.1-99.26
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:100.1-101.9
syntax vectype =
  | V128

;; 1-syntax.watsup:102.1-103.24
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:104.1-105.38
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | FUNCREF
  | EXTERNREF
  | BOT

;; 1-syntax.watsup:107.1-107.40
syntax inn =
  | I32
  | I64

;; 1-syntax.watsup:108.1-108.40
syntax fnn =
  | F32
  | F64

;; 1-syntax.watsup:115.1-116.11
syntax resulttype = valtype*

;; 1-syntax.watsup:118.1-118.18
syntax mut = `MUT%?`(()?)

;; 1-syntax.watsup:120.1-121.16
syntax limits = `[%..%]`(u32, u32)

;; 1-syntax.watsup:122.1-123.14
syntax globaltype = `%%`(mut, valtype)

;; 1-syntax.watsup:124.1-125.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:126.1-127.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:128.1-129.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:130.1-131.10
syntax elemtype = reftype

;; 1-syntax.watsup:132.1-133.5
syntax datatype = OK

;; 1-syntax.watsup:134.1-135.70
syntax externtype =
  | FUNC(functype)
  | GLOBAL(globaltype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:147.1-147.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:149.1-149.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:150.1-150.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:152.1-154.66
syntax binop_IXX =
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

;; 1-syntax.watsup:155.1-155.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:157.1-157.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:158.1-158.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:160.1-161.112
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:162.1-162.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:164.1-164.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:165.1-165.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:166.1-166.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:167.1-167.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:168.1-168.53
syntax cvtop =
  | CONVERT
  | REINTERPRET
  | CONVERT_SAT

;; 1-syntax.watsup:176.1-176.68
syntax memop = {ALIGN u32, OFFSET u32}

;; 1-syntax.watsup:184.1-184.23
syntax c_numtype = nat

;; 1-syntax.watsup:185.1-185.23
syntax c_vectype = nat

;; 1-syntax.watsup:188.1-190.17
syntax blocktype =
  | _RESULT(valtype?)
  | _IDX(funcidx)

;; 1-syntax.watsup:248.1-256.80
rec {

;; 1-syntax.watsup:248.1-256.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
}

;; 1-syntax.watsup:258.1-259.9
syntax expr = instr*

;; 1-syntax.watsup:269.1-269.61
syntax elemmode =
  | ACTIVE(tableidx, expr)
  | PASSIVE
  | DECLARE

;; 1-syntax.watsup:270.1-270.49
syntax datamode =
  | ACTIVE(memidx, expr)
  | PASSIVE

;; 1-syntax.watsup:272.1-273.16
syntax type = TYPE(functype)

;; 1-syntax.watsup:274.1-275.16
syntax local = LOCAL(valtype)

;; 1-syntax.watsup:276.1-277.27
syntax func = `FUNC%%*%`(typeidx, local*, expr)

;; 1-syntax.watsup:278.1-279.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:280.1-281.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:282.1-283.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:284.1-285.30
syntax elem = `ELEM%%*%`(reftype, expr*, elemmode)

;; 1-syntax.watsup:286.1-287.22
syntax data = `DATA%*%`(byte*, datamode)

;; 1-syntax.watsup:288.1-289.16
syntax start = START(funcidx)

;; 1-syntax.watsup:291.1-292.66
syntax externidx =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:293.1-294.24
syntax export = EXPORT(name, externidx)

;; 1-syntax.watsup:295.1-296.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:298.1-299.76
syntax module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*, import*, func*, global*, table*, mem*, elem*, data*, start*, export*)

;; 2-aux.watsup:7.1-7.14
def Ki : nat
  ;; 2-aux.watsup:8.1-8.15
  def Ki = 1024

;; 2-aux.watsup:13.1-13.25
rec {

;; 2-aux.watsup:13.1-13.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:14.1-14.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:15.1-15.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:16.1-16.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:18.1-18.21
rec {

;; 2-aux.watsup:18.1-18.21
def sum : nat* -> nat
  ;; 2-aux.watsup:19.1-19.22
  def sum([]) = 0
  ;; 2-aux.watsup:20.1-20.35
  def {n : n, n'* : n*} sum([n] :: n'*{n'}) = (n + $sum(n'*{n'}))
}

;; 2-aux.watsup:31.1-31.55
def size : valtype -> nat
  ;; 2-aux.watsup:32.1-32.20
  def size(I32_valtype) = 32
  ;; 2-aux.watsup:33.1-33.20
  def size(I64_valtype) = 64
  ;; 2-aux.watsup:34.1-34.20
  def size(F32_valtype) = 32
  ;; 2-aux.watsup:35.1-35.20
  def size(F64_valtype) = 64
  ;; 2-aux.watsup:36.1-36.22
  def size(V128_valtype) = 128

;; 2-aux.watsup:43.1-43.57
def signed : (nat, nat) -> int
  ;; 2-aux.watsup:44.1-44.54
  def {N : nat, i : nat} signed(N, i) = (i <: int)
    -- if (0 <= (2 ^ (N - 1)))
  ;; 2-aux.watsup:45.1-45.60
  def {N : nat, i : nat} signed(N, i) = ((i - (2 ^ N)) <: int)
    -- if (((2 ^ (N - 1)) <= i) /\ (i < (2 ^ N)))

;; 2-aux.watsup:47.1-47.63
def invsigned : (nat, int) -> nat
  ;; 2-aux.watsup:48.1-48.56
  def {N : nat, i : nat, j : nat} invsigned(N, (i <: int)) = j
    -- if ($signed(N, j) = (i <: int))

;; 2-aux.watsup:55.1-55.33
def memop0 : memop
  ;; 2-aux.watsup:56.1-56.34
  def memop0 = {ALIGN 0, OFFSET 0}

;; 2-aux.watsup:61.1-61.68
def free_dataidx_instr : instr -> dataidx*
  ;; 2-aux.watsup:62.1-62.43
  def {x : idx} free_dataidx_instr(MEMORY.INIT_instr(x)) = [x]
  ;; 2-aux.watsup:63.1-63.41
  def {x : idx} free_dataidx_instr(DATA.DROP_instr(x)) = [x]
  ;; 2-aux.watsup:64.1-64.38
  def {in : instr} free_dataidx_instr(in) = []

;; 2-aux.watsup:66.1-66.70
rec {

;; 2-aux.watsup:66.1-66.70
def free_dataidx_instrs : instr* -> dataidx*
  ;; 2-aux.watsup:67.1-67.44
  def free_dataidx_instrs([]) = []
  ;; 2-aux.watsup:68.1-68.99
  def {instr : instr, instr'* : instr*} free_dataidx_instrs([instr] :: instr'*{instr'}) = $free_dataidx_instr(instr) :: $free_dataidx_instrs(instr'*{instr'})
}

;; 2-aux.watsup:70.1-70.66
def free_dataidx_expr : expr -> dataidx*
  ;; 2-aux.watsup:71.1-71.56
  def {in* : instr*} free_dataidx_expr(in*{in}) = $free_dataidx_instrs(in*{in})

;; 2-aux.watsup:73.1-73.66
def free_dataidx_func : func -> dataidx*
  ;; 2-aux.watsup:74.1-74.62
  def {e : expr, loc* : local*, x : idx} free_dataidx_func(`FUNC%%*%`(x, loc*{loc}, e)) = $free_dataidx_expr(e)

;; 2-aux.watsup:76.1-76.68
rec {

;; 2-aux.watsup:76.1-76.68
def free_dataidx_funcs : func* -> dataidx*
  ;; 2-aux.watsup:77.1-77.43
  def free_dataidx_funcs([]) = []
  ;; 2-aux.watsup:78.1-78.92
  def {func : func, func'* : func*} free_dataidx_funcs([func] :: func'*{func'}) = $free_dataidx_func(func) :: $free_dataidx_funcs(func'*{func'})
}

;; 2-aux.watsup:86.1-86.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:87.1-87.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:89.1-89.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:90.1-90.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:92.1-101.43
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

;; 3-typing.watsup:5.1-8.60
syntax context = {TYPE functype*, FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:18.1-18.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:26.1-28.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%]`(n_1, n_2), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:19.1-19.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:30.1-31.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:20.1-20.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:33.1-34.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:21.1-21.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:36.1-38.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:22.1-22.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:40.1-42.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:23.1-23.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:45.1-47.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:49.1-51.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:53.1-55.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:57.1-59.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:69.1-69.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:72.1-73.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:75.1-76.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:70.1-70.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:78.1-80.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:85.1-85.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:93.1-96.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%]`(n_11, n_12), `[%..%]`(n_21, n_22))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:86.1-86.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:98.1-99.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:87.1-87.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:101.1-102.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:88.1-88.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:104.1-106.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:89.1-89.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:108.1-110.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:90.1-90.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:113.1-115.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:117.1-119.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:121.1-123.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:125.1-127.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:192.1-192.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:194.1-195.44
  rule void {C : context}:
    `%|-%:%`(C, _RESULT_blocktype(?()), `%->%`([], []))

  ;; 3-typing.watsup:197.1-198.32
  rule result {C : context, t : valtype}:
    `%|-%:%`(C, _RESULT_blocktype(?(t)), `%->%`([], [t]))

  ;; 3-typing.watsup:200.1-202.23
  rule typeidx {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, _IDX_blocktype(x), ft)
    -- if (C.TYPE_context[x] = ft)

;; 3-typing.watsup:135.1-136.67
rec {

;; 3-typing.watsup:135.1-135.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:171.1-172.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:174.1-175.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:177.1-178.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:181.1-182.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?([t])), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:184.1-187.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = (numtype <: valtype)) \/ (t' = (vectype <: valtype)))

  ;; 3-typing.watsup:205.1-208.59
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:210.1-213.59
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1*{t_1}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:215.1-219.61
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:224.1-226.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:228.1-230.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:232.1-235.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:240.1-242.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 3-typing.watsup:244.1-246.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (C.FUNC_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:248.1-251.33
  rule call_indirect {C : context, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, y), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (C.TYPE_context[y] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:256.1-257.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [(nt <: valtype)]))

  ;; 3-typing.watsup:259.1-260.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([(nt <: valtype)], [(nt <: valtype)]))

  ;; 3-typing.watsup:262.1-263.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([(nt <: valtype) (nt <: valtype)], [(nt <: valtype)]))

  ;; 3-typing.watsup:265.1-266.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([(nt <: valtype)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-269.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([(nt <: valtype) (nt <: valtype)], [I32_valtype]))

  ;; 3-typing.watsup:272.1-274.23
  rule extend {C : context, n : n, nt : numtype}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([(nt <: valtype)], [(nt <: valtype)]))
    -- if (n <= $size(nt <: valtype))

  ;; 3-typing.watsup:276.1-279.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([(nt_2 <: valtype)], [(nt_1 <: valtype)]))
    -- if (nt_1 =/= nt_2)
    -- if ($size(nt_1 <: valtype) = $size(nt_2 <: valtype))

  ;; 3-typing.watsup:281.1-284.54
  rule convert-i {C : context, inn_1 : inn, inn_2 : inn, sx? : sx?}:
    `%|-%:%`(C, CVTOP_instr((inn_1 <: numtype), CONVERT_cvtop, (inn_2 <: numtype), sx?{sx}), `%->%`([(inn_2 <: valtype)], [(inn_1 <: valtype)]))
    -- if (inn_1 =/= inn_2)
    -- if ((sx?{sx} = ?()) <=> ($size(inn_1 <: valtype) > $size(inn_2 <: valtype)))

  ;; 3-typing.watsup:286.1-288.24
  rule convert-f {C : context, fnn_1 : fnn, fnn_2 : fnn}:
    `%|-%:%`(C, CVTOP_instr((fnn_1 <: numtype), CONVERT_cvtop, (fnn_2 <: numtype), ?()), `%->%`([(fnn_2 <: valtype)], [(fnn_1 <: valtype)]))
    -- if (fnn_1 =/= fnn_2)

  ;; 3-typing.watsup:293.1-294.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [(rt <: valtype)]))

  ;; 3-typing.watsup:296.1-298.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:300.1-301.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([(rt <: valtype)], [I32_valtype]))

  ;; 3-typing.watsup:306.1-308.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:310.1-312.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:314.1-316.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:321.1-323.28
  rule global.get {C : context, mut : mut, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `%%`(mut, t))

  ;; 3-typing.watsup:325.1-327.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?(())), t))

  ;; 3-typing.watsup:332.1-334.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [(rt <: valtype)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:336.1-338.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype (rt <: valtype)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:340.1-342.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:344.1-346.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([(rt <: valtype) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:348.1-350.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype (rt <: valtype) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:352.1-355.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:357.1-360.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:362.1-364.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:369.1-371.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:373.1-375.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:377.1-379.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:381.1-383.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:385.1-388.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:390.1-392.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:394.1-399.33
  rule load {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [(nt <: valtype)]))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (inn <: numtype)))

  ;; 3-typing.watsup:401.1-406.33
  rule store {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype (nt <: valtype)], []))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (inn <: numtype)))

;; 3-typing.watsup:136.1-136.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:149.1-150.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:152.1-155.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:157.1-162.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:164.1-166.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:137.1-137.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:142.1-144.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:413.1-413.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:417.1-418.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:420.1-421.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:423.1-424.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:426.1-428.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?()), t))

;; 3-typing.watsup:414.1-414.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:431.1-432.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:415.1-415.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:435.1-438.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:445.1-445.73
relation Type_ok: `|-%:%`(type, functype)
  ;; 3-typing.watsup:459.1-461.29
  rule _ {ft : functype}:
    `|-%:%`(TYPE(ft), ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:446.1-446.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:463.1-467.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, `FUNC%%*%`(x, LOCAL(t)*{t}, expr), ft)
    -- if (C.TYPE_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:447.1-447.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:469.1-473.40
  rule _ {C : context, expr : expr, gt : globaltype, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `%%`(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:448.1-448.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:475.1-477.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:449.1-449.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:479.1-481.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:452.1-452.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:492.1-495.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:497.1-498.20
  rule passive {C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; 3-typing.watsup:500.1-501.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:450.1-450.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:483.1-486.37
  rule _ {C : context, elemmode : elemmode, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%`(rt, expr*{expr}, elemmode), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [(rt <: valtype)]))*{expr}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, rt)

;; 3-typing.watsup:453.1-453.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:503.1-506.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, ACTIVE_datamode(0, expr))
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:508.1-509.20
  rule passive {C : context}:
    `%|-%:OK`(C, PASSIVE_datamode)

;; 3-typing.watsup:451.1-451.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:488.1-490.37
  rule _ {C : context, b* : byte*, datamode : datamode}:
    `%|-%:OK`(C, `DATA%*%`(b*{b}, datamode))
    -- Datamode_ok: `%|-%:OK`(C, datamode)

;; 3-typing.watsup:454.1-454.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:511.1-513.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:518.1-518.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:522.1-524.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:520.1-520.83
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; 3-typing.watsup:531.1-533.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype(ft))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:535.1-537.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:539.1-541.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:543.1-545.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (C.MEM_context[x] = mt)

;; 3-typing.watsup:519.1-519.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:526.1-528.39
  rule _ {C : context, externidx : externidx, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externidx), xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 3-typing.watsup:550.1-550.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:552.1-567.20
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, ft'* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*, type* : type*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (C = {TYPE ft'*{ft'}, FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Type_ok: `|-%:%`(type, ft'))*{ft' type}
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

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

;; 4-runtime.watsup:30.1-31.28
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:32.1-33.71
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:34.1-35.14
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:37.1-38.22
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:47.1-48.70
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:55.1-55.44
def default_ : valtype -> val
  ;; 4-runtime.watsup:56.1-56.35
  def default_(I32_valtype) = CONST_val(I32_numtype, 0)
  ;; 4-runtime.watsup:57.1-57.35
  def default_(I64_valtype) = CONST_val(I64_numtype, 0)
  ;; 4-runtime.watsup:58.1-58.35
  def default_(F32_valtype) = CONST_val(F32_numtype, 0)
  ;; 4-runtime.watsup:59.1-59.35
  def default_(F64_valtype) = CONST_val(F64_numtype, 0)
  ;; 4-runtime.watsup:60.1-60.44
  def default_(FUNCREF_valtype) = REF.NULL_val(FUNCREF_reftype)
  ;; 4-runtime.watsup:61.1-61.48
  def default_(EXTERNREF_valtype) = REF.NULL_val(EXTERNREF_reftype)

;; 4-runtime.watsup:88.1-90.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:92.1-100.25
syntax moduleinst = {TYPE functype*, FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:70.1-73.16
syntax funcinst = {TYPE functype, MODULE moduleinst, CODE func}

;; 4-runtime.watsup:74.1-76.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:77.1-79.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:80.1-82.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:83.1-85.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:86.1-87.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:114.1-120.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:122.1-124.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:126.1-126.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:213.1-220.9
rec {

;; 4-runtime.watsup:213.1-220.9
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | CALL_ADDR(funcaddr)
  | LABEL_(n, instr*, admininstr*)
  | FRAME_(n, frame, admininstr*)
  | TRAP
}

;; 4-runtime.watsup:127.1-127.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:136.1-136.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:137.1-137.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:139.1-139.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:146.1-146.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:140.1-140.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:147.1-147.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:141.1-141.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:148.1-148.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:142.1-142.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:149.1-149.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:143.1-143.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:150.1-150.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:144.1-144.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:151.1-151.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:153.1-153.67
def type : (state, typeidx) -> functype
  ;; 4-runtime.watsup:162.1-162.40
  def {f : frame, s : store, x : idx} type(`%;%`(s, f), x) = f.MODULE_frame.TYPE_moduleinst[x]

;; 4-runtime.watsup:154.1-154.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:163.1-163.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:155.1-155.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:164.1-164.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:156.1-156.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:165.1-165.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:157.1-157.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:166.1-166.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:158.1-158.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:167.1-167.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:159.1-159.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:168.1-168.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:160.1-160.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:169.1-169.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:172.1-172.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:181.1-181.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:173.1-173.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:182.1-182.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:174.1-174.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:183.1-183.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:175.1-175.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:184.1-184.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:176.1-176.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:185.1-185.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:177.1-177.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:186.1-186.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:178.1-178.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:187.1-187.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:179.1-179.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:188.1-188.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:193.1-193.63
def grow_table : (tableinst, nat, ref) -> tableinst
  ;; 4-runtime.watsup:196.1-200.36
  def {i : nat, i' : nat, j : nat, n : n, r : ref, r'* : ref*, rt : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ti'
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%]`(i', j), rt), ELEM r'*{r'} :: r^n{}})
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)

;; 4-runtime.watsup:194.1-194.55
def grow_memory : (meminst, nat) -> meminst
  ;; 4-runtime.watsup:202.1-206.34
  def {b* : byte*, i : nat, i' : nat, j : nat, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = mi'
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%]`(i', j)), DATA b*{b} :: 0^((n * 64) * $Ki){}})
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)

;; 4-runtime.watsup:222.1-225.25
rec {

;; 4-runtime.watsup:222.1-225.25
syntax E =
  | _HOLE
  | _SEQ(val*, E, instr*)
  | LABEL_(n, instr*, E)
}

;; 5-numerics.watsup:3.1-3.79
def unop : (unop_numtype, numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:4.1-4.80
def binop : (binop_numtype, numtype, c_numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:5.1-5.79
def testop : (testop_numtype, numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:6.1-6.80
def relop : (relop_numtype, numtype, c_numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:8.1-8.84
def ext : (nat, nat, sx, c_numtype) -> c_numtype

;; 5-numerics.watsup:9.1-9.84
def cvtop : (numtype, cvtop, numtype, sx?, c_numtype) -> c_numtype*

;; 5-numerics.watsup:11.1-11.32
def wrap_ : ((nat, nat), c_numtype) -> nat

;; 5-numerics.watsup:13.1-13.60
def ibytes : (nat, iN) -> byte*

;; 5-numerics.watsup:14.1-14.60
def fbytes : (nat, fN) -> byte*

;; 5-numerics.watsup:15.1-15.58
def ntbytes : (numtype, c_numtype) -> byte*

;; 5-numerics.watsup:17.1-17.30
def invibytes : (nat, byte*) -> iN
  ;; 5-numerics.watsup:20.1-20.52
  def {N : nat, b* : byte*, n : n} invibytes(N, b*{b}) = n
    -- if ($ibytes(N, n) = b*{b})

;; 5-numerics.watsup:18.1-18.30
def invfbytes : (nat, byte*) -> fN
  ;; 5-numerics.watsup:21.1-21.52
  def {N : nat, b* : byte*, p : fN} invfbytes(N, b*{b}) = p
    -- if ($fbytes(N, p) = b*{b})

;; 6-reduction.watsup:6.1-6.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:24.1-25.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:27.1-28.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:30.1-31.24
  rule drop {val : val}:
    `%*~>%*`([(val <: admininstr) DROP_admininstr], [])

  ;; 6-reduction.watsup:34.1-36.16
  rule select-true {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([(val_1 <: admininstr) (val_2 <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [(val_1 <: admininstr)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:38.1-40.14
  rule select-false {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([(val_1 <: admininstr) (val_2 <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [(val_2 <: admininstr)])
    -- if (c = 0)

  ;; 6-reduction.watsup:58.1-60.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:62.1-64.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:67.1-68.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, (val <: admininstr)*{val})], (val <: admininstr)*{val})

  ;; 6-reduction.watsup:74.1-75.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [BR_admininstr(0)] :: (instr <: admininstr)*{instr})], (val <: admininstr)^n{val} :: (instr' <: admininstr)*{instr'})

  ;; 6-reduction.watsup:77.1-78.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val <: admininstr)*{val} :: [BR_admininstr(l + 1)] :: (instr <: admininstr)*{instr})], (val <: admininstr)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:81.1-83.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:85.1-87.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:90.1-92.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:94.1-96.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:121.1-122.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, (val <: admininstr)^n{val})], (val <: admininstr)^n{val})

  ;; 6-reduction.watsup:124.1-125.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [RETURN_admininstr] :: (instr <: admininstr)*{instr})], (val <: admininstr)^n{val})

  ;; 6-reduction.watsup:127.1-128.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, (val <: admininstr)*{val} :: [RETURN_admininstr] :: (instr <: admininstr)*{instr})], (val <: admininstr)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:133.1-135.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 6-reduction.watsup:137.1-139.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:142.1-144.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 6-reduction.watsup:146.1-148.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:151.1-153.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 6-reduction.watsup:155.1-157.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 6-reduction.watsup:160.1-161.70
  rule extend {c : c_numtype, n : n, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, $size(nt <: valtype), S_sx, c))])

  ;; 6-reduction.watsup:164.1-166.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [c])

  ;; 6-reduction.watsup:168.1-170.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:179.1-181.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([(val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(rt))

  ;; 6-reduction.watsup:183.1-185.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([(val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:196.1-197.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([(val <: admininstr) LOCAL.TEE_admininstr(x)], [(val <: admininstr) (val <: admininstr) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:45.1-45.73
def blocktype : (state, blocktype) -> functype
  ;; 6-reduction.watsup:46.1-46.56
  def {z : state} blocktype(z, _RESULT_blocktype(?())) = `%->%`([], [])
  ;; 6-reduction.watsup:47.1-47.44
  def {t : valtype, z : state} blocktype(z, _RESULT_blocktype(?(t))) = `%->%`([], [t])
  ;; 6-reduction.watsup:48.1-48.40
  def {x : idx, z : state} blocktype(z, _IDX_blocktype(x)) = $type(z, x)

;; 6-reduction.watsup:7.1-7.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:50.1-52.43
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, (val <: admininstr)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})]), [LABEL__admininstr(n, [], (val <: admininstr)^k{val} :: (instr <: admininstr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:54.1-56.43
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, (val <: admininstr)^k{val} :: [LOOP_admininstr(bt, instr*{instr})]), [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], (val <: admininstr)^k{val} :: (instr <: admininstr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:101.1-102.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:104.1-108.35
  rule call_indirect-call {a : addr, i : nat, instr* : instr*, t* : valtype*, x : idx, y : idx, y' : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [CALL_ADDR_admininstr(a)])
    -- if ($table(z, x).ELEM_tableinst[i] = REF.FUNC_ADDR_ref(a))
    -- if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(y', LOCAL(t)*{t}, instr*{instr}))
    -- if ($type(z, y) = $type(z, y'))

  ;; 6-reduction.watsup:110.1-112.15
  rule call_indirect-trap {i : nat, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:114.1-118.53
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, mm : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, (val <: admininstr)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], (instr <: admininstr)*{instr})])])
    -- if ($funcinst(z)[a] = {TYPE `%->%`(t_1^k{t_1}, t_2^n{t_2}), MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, LOCAL(t)*{t}, instr*{instr}))
    -- if (f = {LOCAL val^k{val} :: $default_(t)*{t}, MODULE mm})

  ;; 6-reduction.watsup:175.1-176.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:190.1-191.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [($local(z, x) <: admininstr)])

  ;; 6-reduction.watsup:202.1-203.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [($global(z, x).VALUE_globalinst <: admininstr)])

  ;; 6-reduction.watsup:211.1-213.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:215.1-217.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [($table(z, x).ELEM_tableinst[i] <: admininstr)])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:228.1-230.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 6-reduction.watsup:241.1-243.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:245.1-248.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:250.1-254.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) (val <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:257.1-259.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:261.1-264.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:266.1-271.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:273.1-277.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:280.1-282.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:284.1-287.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:289.1-293.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) ($elem(z, y).ELEM_eleminst[i] <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:302.1-304.59
  rule load-num-trap {i : nat, mo : memop, nt : numtype, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + ($size(nt <: valtype) / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:306.1-308.71
  rule load-num-val {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [CONST_admininstr(nt, c)])
    -- if ($ntbytes(nt, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : ($size(nt <: valtype) / 8)])

  ;; 6-reduction.watsup:310.1-312.51
  rule load-pack-trap {i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:314.1-316.61
  rule load-pack-val {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [CONST_admininstr(nt, $ext(n, $size(nt <: valtype), sx, c))])
    -- if ($ibytes(n, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])

  ;; 6-reduction.watsup:336.1-338.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:349.1-351.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:353.1-356.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:358.1-362.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) (val <: admininstr) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:365.1-367.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:369.1-372.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:374.1-379.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:381.1-385.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:388.1-390.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:392.1-395.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:397.1-401.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- otherwise

;; 6-reduction.watsup:5.1-5.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:9.1-11.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*{instr}), `%;%*`(z, (instr' <: admininstr)*{instr'}))
    -- Step_pure: `%*~>%*`((instr <: admininstr)*{instr}, (instr' <: admininstr)*{instr'})

  ;; 6-reduction.watsup:13.1-15.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*{instr}), `%;%*`(z, (instr' <: admininstr)*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, (instr <: admininstr)*{instr}), (instr' <: admininstr)*{instr'})

  ;; 6-reduction.watsup:193.1-194.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(val <: admininstr) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:205.1-206.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(val <: admininstr) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:219.1-221.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:223.1-225.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:233.1-235.47
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if ($grow_table($table(z, x), n, ref) = ti)

  ;; 6-reduction.watsup:237.1-238.80
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:296.1-297.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:319.1-321.59
  rule store-num-trap {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + ($size(nt <: valtype) / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:323.1-325.29
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, mo : memop, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), ($size(nt <: valtype) / 8), b*{b}), []))
    -- if (b*{b} = $ntbytes(nt, c))

  ;; 6-reduction.watsup:327.1-329.51
  rule store-pack-trap {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:331.1-333.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), (n / 8), b*{b}), []))
    -- if (b*{b} = $ibytes(n, $wrap_(($size(nt <: valtype), n), c)))

  ;; 6-reduction.watsup:341.1-343.41
  rule memory.grow-succeed {mi : meminst, n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- if ($grow_memory($mem(z, 0), n) = mi)

  ;; 6-reduction.watsup:345.1-346.75
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:404.1-405.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:5.1-5.35
rec {

;; 7-module.watsup:5.1-5.35
def funcs : externval* -> funcaddr*
  ;; 7-module.watsup:6.1-6.30
  def funcs([]) = []
  ;; 7-module.watsup:7.1-7.59
  def {externval'* : externval*, fa : funcaddr} funcs([FUNC_externval(fa)] :: externval'*{externval'}) = [fa] :: $funcs(externval'*{externval'})
  ;; 7-module.watsup:8.1-9.15
  def {externval : externval, externval'* : externval*} funcs([externval] :: externval'*{externval'}) = $funcs(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:11.1-11.39
rec {

;; 7-module.watsup:11.1-11.39
def globals : externval* -> globaladdr*
  ;; 7-module.watsup:12.1-12.32
  def globals([]) = []
  ;; 7-module.watsup:13.1-13.65
  def {externval'* : externval*, ga : globaladdr} globals([GLOBAL_externval(ga)] :: externval'*{externval'}) = [ga] :: $globals(externval'*{externval'})
  ;; 7-module.watsup:14.1-15.15
  def {externval : externval, externval'* : externval*} globals([externval] :: externval'*{externval'}) = $globals(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:17.1-17.37
rec {

;; 7-module.watsup:17.1-17.37
def tables : externval* -> tableaddr*
  ;; 7-module.watsup:18.1-18.31
  def tables([]) = []
  ;; 7-module.watsup:19.1-19.62
  def {externval'* : externval*, ta : tableaddr} tables([TABLE_externval(ta)] :: externval'*{externval'}) = [ta] :: $tables(externval'*{externval'})
  ;; 7-module.watsup:20.1-21.15
  def {externval : externval, externval'* : externval*} tables([externval] :: externval'*{externval'}) = $tables(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:23.1-23.33
rec {

;; 7-module.watsup:23.1-23.33
def mems : externval* -> memaddr*
  ;; 7-module.watsup:24.1-24.29
  def mems([]) = []
  ;; 7-module.watsup:25.1-25.56
  def {externval'* : externval*, ma : memaddr} mems([MEM_externval(ma)] :: externval'*{externval'}) = [ma] :: $mems(externval'*{externval'})
  ;; 7-module.watsup:26.1-27.15
  def {externval : externval, externval'* : externval*} mems([externval] :: externval'*{externval'}) = $mems(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:36.1-36.60
def allocfunc : (store, moduleinst, func) -> (store, funcaddr)
  ;; 7-module.watsup:37.1-39.34
  def {expr : expr, fi : funcinst, func : func, local* : local*, mm : moduleinst, s : store, x : idx} allocfunc(s, mm, func) = (s[FUNC_store =.. [fi]], |s.FUNC_store|)
    -- if (fi = {TYPE mm.TYPE_moduleinst[x], MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, local*{local}, expr))

;; 7-module.watsup:41.1-41.63
rec {

;; 7-module.watsup:41.1-41.63
def allocfuncs : (store, moduleinst, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:42.1-42.47
  def {mm : moduleinst, s : store} allocfuncs(s, mm, []) = (s, [])
  ;; 7-module.watsup:43.1-45.51
  def {fa : funcaddr, fa'* : funcaddr*, func : func, func'* : func*, mm : moduleinst, s : store, s_1 : store, s_2 : store} allocfuncs(s, mm, [func] :: func'*{func'}) = (s_2, [fa] :: fa'*{fa'})
    -- if ((s_1, fa) = $allocfunc(s, mm, func))
    -- if ((s_2, fa'*{fa'}) = $allocfuncs(s_1, mm, func'*{func'}))
}

;; 7-module.watsup:47.1-47.63
def allocglobal : (store, globaltype, val) -> (store, globaladdr)
  ;; 7-module.watsup:48.1-49.44
  def {gi : globalinst, globaltype : globaltype, s : store, val : val} allocglobal(s, globaltype, val) = (s[GLOBAL_store =.. [gi]], |s.GLOBAL_store|)
    -- if (gi = {TYPE globaltype, VALUE val})

;; 7-module.watsup:51.1-51.67
rec {

;; 7-module.watsup:51.1-51.67
def allocglobals : (store, globaltype*, val*) -> (store, globaladdr*)
  ;; 7-module.watsup:52.1-52.54
  def {s : store} allocglobals(s, [], []) = (s, [])
  ;; 7-module.watsup:53.1-55.62
  def {ga : globaladdr, ga'* : globaladdr*, globaltype : globaltype, globaltype'* : globaltype*, s : store, s_1 : store, s_2 : store, val : val, val'* : val*} allocglobals(s, [globaltype] :: globaltype'*{globaltype'}, [val] :: val'*{val'}) = (s_2, [ga] :: ga'*{ga'})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga'}) = $allocglobals(s_1, globaltype'*{globaltype'}, val'*{val'}))
}

;; 7-module.watsup:57.1-57.55
def alloctable : (store, tabletype) -> (store, tableaddr)
  ;; 7-module.watsup:58.1-59.59
  def {i : nat, j : nat, rt : reftype, s : store, ti : tableinst} alloctable(s, `%%`(`[%..%]`(i, j), rt)) = (s[TABLE_store =.. [ti]], |s.TABLE_store|)
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM REF.NULL_ref(rt)^i{}})

;; 7-module.watsup:61.1-61.58
rec {

;; 7-module.watsup:61.1-61.58
def alloctables : (store, tabletype*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.44
  def {s : store} alloctables(s, []) = (s, [])
  ;; 7-module.watsup:63.1-65.53
  def {s : store, s_1 : store, s_2 : store, ta : tableaddr, ta'* : tableaddr*, tabletype : tabletype, tabletype'* : tabletype*} alloctables(s, [tabletype] :: tabletype'*{tabletype'}) = (s_2, [ta] :: ta'*{ta'})
    -- if ((s_1, ta) = $alloctable(s, tabletype))
    -- if ((s_2, ta'*{ta'}) = $alloctables(s_1, tabletype'*{tabletype'}))
}

;; 7-module.watsup:67.1-67.49
def allocmem : (store, memtype) -> (store, memaddr)
  ;; 7-module.watsup:68.1-69.62
  def {i : nat, j : nat, mi : meminst, s : store} allocmem(s, `%I8`(`[%..%]`(i, j))) = (s[MEM_store =.. [mi]], |s.MEM_store|)
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA 0^((i * 64) * $Ki){}})

;; 7-module.watsup:71.1-71.52
rec {

;; 7-module.watsup:71.1-71.52
def allocmems : (store, memtype*) -> (store, memaddr*)
  ;; 7-module.watsup:72.1-72.42
  def {s : store} allocmems(s, []) = (s, [])
  ;; 7-module.watsup:73.1-75.49
  def {ma : memaddr, ma'* : memaddr*, memtype : memtype, memtype'* : memtype*, s : store, s_1 : store, s_2 : store} allocmems(s, [memtype] :: memtype'*{memtype'}) = (s_2, [ma] :: ma'*{ma'})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma'}) = $allocmems(s_1, memtype'*{memtype'}))
}

;; 7-module.watsup:77.1-77.57
def allocelem : (store, reftype, ref*) -> (store, elemaddr)
  ;; 7-module.watsup:78.1-79.36
  def {ei : eleminst, ref* : ref*, rt : reftype, s : store} allocelem(s, rt, ref*{ref}) = (s[ELEM_store =.. [ei]], |s.ELEM_store|)
    -- if (ei = {TYPE rt, ELEM ref*{ref}})

;; 7-module.watsup:81.1-81.63
rec {

;; 7-module.watsup:81.1-81.63
def allocelems : (store, reftype*, ref**) -> (store, elemaddr*)
  ;; 7-module.watsup:82.1-82.52
  def {s : store} allocelems(s, [], []) = (s, [])
  ;; 7-module.watsup:83.1-85.55
  def {ea : elemaddr, ea'* : elemaddr*, ref* : ref*, ref'** : ref**, rt : reftype, rt'* : reftype*, s : store, s_1 : store, s_2 : store} allocelems(s, [rt] :: rt'*{rt'}, [ref*{ref}] :: ref'*{ref'}*{ref'}) = (s_2, [ea] :: ea'*{ea'})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref}))
    -- if ((s_2, ea'*{ea'}) = $allocelems(s_2, rt'*{rt'}, ref'*{ref'}*{ref'}))
}

;; 7-module.watsup:87.1-87.49
def allocdata : (store, byte*) -> (store, dataaddr)
  ;; 7-module.watsup:88.1-89.28
  def {byte* : byte*, di : datainst, s : store} allocdata(s, byte*{byte}) = (s[DATA_store =.. [di]], |s.DATA_store|)
    -- if (di = {DATA byte*{byte}})

;; 7-module.watsup:91.1-91.54
rec {

;; 7-module.watsup:91.1-91.54
def allocdatas : (store, byte**) -> (store, dataaddr*)
  ;; 7-module.watsup:92.1-92.43
  def {s : store} allocdatas(s, []) = (s, [])
  ;; 7-module.watsup:93.1-95.50
  def {byte* : byte*, byte'** : byte**, da : dataaddr, da'* : dataaddr*, s : store, s_1 : store, s_2 : store} allocdatas(s, [byte]*{byte} :: byte'*{byte'}*{byte'}) = (s_2, [da] :: da'*{da'})
    -- if ((s_1, da) = $allocdata(s, byte*{byte}))
    -- if ((s_2, da'*{da'}) = $allocdatas(s_1, byte'*{byte'}*{byte'}))
}

;; 7-module.watsup:100.1-100.83
def instexport : (funcaddr*, globaladdr*, tableaddr*, memaddr*, export) -> exportinst
  ;; 7-module.watsup:101.1-101.95
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, FUNC_externidx(x))) = {NAME name, VALUE FUNC_externval(fa*{fa}[x])}
  ;; 7-module.watsup:102.1-102.99
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, GLOBAL_externidx(x))) = {NAME name, VALUE GLOBAL_externval(ga*{ga}[x])}
  ;; 7-module.watsup:103.1-103.97
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, TABLE_externidx(x))) = {NAME name, VALUE TABLE_externval(ta*{ta}[x])}
  ;; 7-module.watsup:104.1-104.93
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, MEM_externidx(x))) = {NAME name, VALUE MEM_externval(ma*{ma}[x])}

;; 7-module.watsup:107.1-107.81
def allocmodule : (store, module, externval*, val*, ref**) -> (store, moduleinst)
  ;; 7-module.watsup:108.1-147.54
  def {byte*^n_data : byte*^n_data, da* : dataaddr*, datamode^n_data : datamode^n_data, ea* : elemaddr*, elemmode^n_elem : elemmode^n_elem, export* : export*, expr_1^n_global : expr^n_global, expr_2*^n_elem : expr*^n_elem, externval* : externval*, fa* : funcaddr*, fa_ex* : funcaddr*, ft : functype, func^n_func : func^n_func, ga* : globaladdr*, ga_ex* : globaladdr*, globaltype^n_global : globaltype^n_global, i_data^n_data : nat^n_data, i_elem^n_elem : nat^n_elem, i_func^n_func : nat^n_func, i_global^n_global : nat^n_global, i_mem^n_mem : nat^n_mem, i_table^n_table : nat^n_table, import* : import*, ma* : memaddr*, ma_ex* : memaddr*, memtype^n_mem : memtype^n_mem, mm : moduleinst, module : module, n_data : n, n_elem : n, n_func : n, n_global : n, n_mem : n, n_table : n, ref** : ref**, rt^n_elem : reftype^n_elem, s : store, s_1 : store, s_2 : store, s_3 : store, s_4 : store, s_5 : store, s_6 : store, start? : start?, ta* : tableaddr*, ta_ex* : tableaddr*, tabletype^n_table : tabletype^n_table, val* : val*, xi* : exportinst*} allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}) = (s_6, mm)
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(TYPE(ft)*{}, import*{import}, func^n_func{func}, GLOBAL(globaltype, expr_1)^n_global{expr_1 globaltype}, TABLE(tabletype)^n_table{tabletype}, MEMORY(memtype)^n_mem{memtype}, `ELEM%%*%`(rt, expr_2*{expr_2}, elemmode)^n_elem{elemmode expr_2 rt}, `DATA%*%`(byte*{byte}, datamode)^n_data{byte datamode}, start?{start}, export*{export}))
    -- if (fa_ex*{fa_ex} = $funcs(externval*{externval}))
    -- if (ga_ex*{ga_ex} = $globals(externval*{externval}))
    -- if (ta_ex*{ta_ex} = $tables(externval*{externval}))
    -- if (ma_ex*{ma_ex} = $mems(externval*{externval}))
    -- if (fa*{fa} = (|s.FUNC_store| + i_func)^(i_func<n_func){i_func})
    -- if (ga*{ga} = (|s.GLOBAL_store| + i_global)^(i_global<n_global){i_global})
    -- if (ta*{ta} = (|s.TABLE_store| + i_table)^(i_table<n_table){i_table})
    -- if (ma*{ma} = (|s.MEM_store| + i_mem)^(i_mem<n_mem){i_mem})
    -- if (ea*{ea} = (|s.ELEM_store| + i_elem)^(i_elem<n_elem){i_elem})
    -- if (da*{da} = (|s.DATA_store| + i_data)^(i_data<n_data){i_data})
    -- if (xi*{xi} = $instexport(fa_ex*{fa_ex} :: fa*{fa}, ga_ex*{ga_ex} :: ga*{ga}, ta_ex*{ta_ex} :: ta*{ta}, ma_ex*{ma_ex} :: ma*{ma}, export)*{export})
    -- if (mm = {TYPE [ft], FUNC fa_ex*{fa_ex} :: fa*{fa}, GLOBAL ga_ex*{ga_ex} :: ga*{ga}, TABLE ta_ex*{ta_ex} :: ta*{ta}, MEM ma_ex*{ma_ex} :: ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT xi*{xi}})
    -- if ((s_1, fa*{fa}) = $allocfuncs(s, mm, func^n_func{func}))
    -- if ((s_2, ga*{ga}) = $allocglobals(s_1, globaltype^n_global{globaltype}, val*{val}))
    -- if ((s_3, ta*{ta}) = $alloctables(s_2, tabletype^n_table{tabletype}))
    -- if ((s_4, ma*{ma}) = $allocmems(s_3, memtype^n_mem{memtype}))
    -- if ((s_5, ea*{ea}) = $allocelems(s_4, rt^n_elem{rt}, ref*{ref}*{ref}))
    -- if ((s_6, da*{da}) = $allocdatas(s_5, byte*{byte}^n_data{byte}))

;; 7-module.watsup:154.1-154.36
rec {

;; 7-module.watsup:154.1-154.36
def concat_instr : instr** -> instr*
  ;; 7-module.watsup:155.1-155.37
  def concat_instr([]) = []
  ;; 7-module.watsup:156.1-156.68
  def {instr* : instr*, instr'** : instr**} concat_instr([instr]*{instr} :: instr'*{instr'}*{instr'}) = instr*{instr} :: $concat_instr(instr'*{instr'}*{instr'})
}

;; 7-module.watsup:158.1-158.33
def runelem : (elem, idx) -> instr*
  ;; 7-module.watsup:159.1-159.56
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, PASSIVE_elemmode), i) = []
  ;; 7-module.watsup:160.1-160.62
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, DECLARE_elemmode), i) = [ELEM.DROP_instr(i)]
  ;; 7-module.watsup:161.1-163.20
  def {expr* : expr*, i : nat, instr* : instr*, n : n, reftype : reftype, x : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, ACTIVE_elemmode(x, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) TABLE.INIT_instr(x, i) ELEM.DROP_instr(i)]
    -- if (n = |expr*{expr}|)

;; 7-module.watsup:165.1-165.33
def rundata : (data, idx) -> instr*
  ;; 7-module.watsup:166.1-166.48
  def {byte* : byte*, i : nat} rundata(`DATA%*%`(byte*{byte}, PASSIVE_datamode), i) = []
  ;; 7-module.watsup:167.1-169.20
  def {byte* : byte*, i : nat, instr* : instr*, n : n} rundata(`DATA%*%`(byte*{byte}, ACTIVE_datamode(0, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) MEMORY.INIT_instr(i) DATA.DROP_instr(i)]
    -- if (n = |byte*{byte}|)

;; 7-module.watsup:171.1-171.53
def instantiate : (store, module, externval*) -> config
  ;; 7-module.watsup:172.1-196.28
  def {data* : data*, elem* : elem*, elemmode* : elemmode*, export* : export*, externval* : externval*, f : frame, f_init : frame, func* : func*, functype* : functype*, global* : global*, globaltype* : globaltype*, i^n_elem : nat^n_elem, import* : import*, instr_1** : instr**, instr_2*** : instr***, instr_data* : instr*, instr_elem* : instr*, j^n_data : nat^n_data, mem* : mem*, mm : moduleinst, mm_init : moduleinst, module : module, n_data : n, n_elem : n, ref** : ref**, reftype* : reftype*, s : store, s' : store, start? : start?, table* : table*, type* : type*, val* : val*, x? : idx?} instantiate(s, module, externval*{externval}) = `%;%*`(`%;%`(s', f), (instr_elem <: admininstr)*{instr_elem} :: (instr_data <: admininstr)*{instr_data} :: CALL_admininstr(x)?{x})
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (type*{type} = TYPE(functype)*{functype})
    -- if (global*{global} = GLOBAL(globaltype, instr_1*{instr_1})*{globaltype instr_1})
    -- if (elem*{elem} = `ELEM%%*%`(reftype, instr_2*{instr_2}*{instr_2}, elemmode)*{elemmode instr_2 reftype})
    -- if (mm_init = {TYPE functype*{functype}, FUNC $funcs(externval*{externval}), GLOBAL $globals(externval*{externval}), TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f_init = {LOCAL [], MODULE mm_init})
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), (instr_1 <: admininstr)*{instr_1}), [(val <: admininstr)]))*{instr_1 val}
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), (instr_2 <: admininstr)*{instr_2}), [(ref <: admininstr)]))*{instr_2 ref}*{instr_2 ref}
    -- if ((s', mm) = $allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}))
    -- if (f = {LOCAL [], MODULE mm})
    -- if (n_elem = |elem*{elem}|)
    -- if (instr_elem*{instr_elem} = $concat_instr($runelem(elem*{elem}[i], i)^(i<n_elem){i}))
    -- if (n_data = |data*{data}|)
    -- if (instr_data*{instr_data} = $concat_instr($rundata(data*{data}[j], j)^(j<n_data){j}))
    -- if (start?{start} = START(x)?{x})

;; 7-module.watsup:203.1-203.44
def invoke : (store, funcaddr, val*) -> config
  ;; 7-module.watsup:204.1-215.51
  def {f : frame, fa : funcaddr, mm : moduleinst, n : n, s : store, t_1^n : valtype^n, t_2* : valtype*, val^n : val^n} invoke(s, fa, val^n{val}) = `%;%*`(`%;%`(s, f), (val <: admininstr)^n{val} :: [CALL_ADDR_admininstr(fa)])
    -- if (mm = {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE mm})
    -- if ($funcinst(`%;%`(s, f))[fa].TYPE_funcinst = `%->%`(t_1^n{t_1}, t_2*{t_2}))

;; A-binary.watsup:47.1-47.57
rec {

;; A-binary.watsup:47.1-47.57
def concat_bytes : byte** -> byte*
  ;; A-binary.watsup:48.1-48.37
  def concat_bytes([]) = []
  ;; A-binary.watsup:49.1-49.52
  def {b* : byte*, b'** : byte**} concat_bytes([b]*{b} :: b'*{b'}*{b'}) = b*{b} :: $concat_bytes(b'*{b'}*{b'})
}

;; A-binary.watsup:51.1-51.24
rec {

;; A-binary.watsup:51.1-51.24
def utf8 : name -> byte*
  ;; A-binary.watsup:52.1-52.44
  def {b : byte, c : c_numtype} utf8([c]) = [b]
    -- if ((c < 128) /\ (c = b))
  ;; A-binary.watsup:53.1-53.93
  def {b_1 : byte, b_2 : byte, c : c_numtype} utf8([c]) = [b_1 b_2]
    -- if (((128 <= c) /\ (c < 2048)) /\ (c = (((2 ^ 6) * (b_1 - 192)) + (b_2 - 128))))
  ;; A-binary.watsup:54.1-54.144
  def {b_1 : byte, b_2 : byte, b_3 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3]
    -- if ((((2048 <= c) /\ (c < 55296)) \/ ((57344 <= c) /\ (c < 65536))) /\ (c = ((((2 ^ 12) * (b_1 - 224)) + ((2 ^ 6) * (b_2 - 128))) + (b_3 - 128))))
  ;; A-binary.watsup:55.1-55.145
  def {b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3 b_4]
    -- if (((65536 <= c) /\ (c < 69632)) /\ (c = (((((2 ^ 18) * (b_1 - 240)) + ((2 ^ 12) * (b_2 - 128))) + ((2 ^ 6) * (b_3 - 128))) + (b_4 - 128))))
  ;; A-binary.watsup:56.1-56.41
  def {c* : c_numtype*} utf8(c*{c}) = $concat_bytes($utf8([c])*{c})
}

;; A-binary.watsup:577.1-577.60
rec {

;; A-binary.watsup:577.1-577.60
def concat_locals : local** -> local*
  ;; A-binary.watsup:578.1-578.38
  def concat_locals([]) = []
  ;; A-binary.watsup:579.1-579.62
  def {loc* : local*, loc'** : local**} concat_locals([loc]*{loc} :: loc'*{loc'}*{loc'}) = loc*{loc} :: $concat_locals(loc'*{loc'}*{loc'})
}

;; A-binary.watsup:582.1-582.29
syntax code = (local*, expr)

== IL Validation...
== Running pass sub...

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:4.1-4.15
syntax m = nat

;; 1-syntax.watsup:18.1-18.50
syntax byte = nat

;; 1-syntax.watsup:21.1-21.58
syntax uN = nat

;; 1-syntax.watsup:22.1-22.87
syntax sN = nat

;; 1-syntax.watsup:23.1-23.36
syntax iN = uN

;; 1-syntax.watsup:26.1-26.58
syntax u32 = nat

;; 1-syntax.watsup:27.1-27.58
syntax u64 = nat

;; 1-syntax.watsup:28.1-28.61
syntax u128 = nat

;; 1-syntax.watsup:29.1-29.69
syntax s33 = nat

;; 1-syntax.watsup:34.1-34.21
def signif : nat -> nat
  ;; 1-syntax.watsup:35.1-35.21
  def signif(32) = 23
  ;; 1-syntax.watsup:36.1-36.21
  def signif(64) = 52

;; 1-syntax.watsup:38.1-38.20
def expon : nat -> nat
  ;; 1-syntax.watsup:39.1-39.19
  def expon(32) = 8
  ;; 1-syntax.watsup:40.1-40.20
  def expon(64) = 11

;; 1-syntax.watsup:42.1-42.35
def M : nat -> nat
  ;; 1-syntax.watsup:43.1-43.23
  def {N : nat} M(N) = $signif(N)

;; 1-syntax.watsup:45.1-45.35
def E : nat -> nat
  ;; 1-syntax.watsup:46.1-46.22
  def {N : nat} E(N) = $expon(N)

;; 1-syntax.watsup:51.1-55.81
syntax fNmag =
  |  {N : nat, n : n}NORM(m, n)
    -- if (((2 - (2 ^ ($E(N) - 1))) <= n) /\ (n <= ((2 ^ ($E(N) - 1)) - 1)))
  |  {N : nat, n : n}SUBNORM(m, n)
    -- if ((2 - (2 ^ ($E(N) - 1))) = n)
  | INF
  |  {N : nat, n : n}NAN(n)
    -- if ((1 <= n) /\ (n < $M(N)))

;; 1-syntax.watsup:49.1-49.107
syntax fN =
  | POS(fNmag)
  | NEG(fNmag)

;; 1-syntax.watsup:58.1-58.35
def fNzero : fN
  ;; 1-syntax.watsup:59.1-59.29
  def fNzero = POS_fN(NORM_fNmag(0, 0))

;; 1-syntax.watsup:62.1-62.51
syntax f32 = fN

;; 1-syntax.watsup:63.1-63.51
syntax f64 = fN

;; 1-syntax.watsup:71.1-71.85
syntax char = nat

;; 1-syntax.watsup:73.1-73.38
syntax name = char*

;; 1-syntax.watsup:80.1-80.36
syntax idx = u32

;; 1-syntax.watsup:81.1-81.45
syntax typeidx = idx

;; 1-syntax.watsup:82.1-82.49
syntax funcidx = idx

;; 1-syntax.watsup:83.1-83.49
syntax globalidx = idx

;; 1-syntax.watsup:84.1-84.47
syntax tableidx = idx

;; 1-syntax.watsup:85.1-85.46
syntax memidx = idx

;; 1-syntax.watsup:86.1-86.45
syntax elemidx = idx

;; 1-syntax.watsup:87.1-87.45
syntax dataidx = idx

;; 1-syntax.watsup:88.1-88.47
syntax labelidx = idx

;; 1-syntax.watsup:89.1-89.47
syntax localidx = idx

;; 1-syntax.watsup:98.1-99.26
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:100.1-101.9
syntax vectype =
  | V128

;; 1-syntax.watsup:102.1-103.24
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:104.1-105.38
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | FUNCREF
  | EXTERNREF
  | BOT

def valtype_numtype : numtype -> valtype
  def valtype_numtype(I32_numtype) = I32_valtype
  def valtype_numtype(I64_numtype) = I64_valtype
  def valtype_numtype(F32_numtype) = F32_valtype
  def valtype_numtype(F64_numtype) = F64_valtype

def valtype_reftype : reftype -> valtype
  def valtype_reftype(FUNCREF_reftype) = FUNCREF_valtype
  def valtype_reftype(EXTERNREF_reftype) = EXTERNREF_valtype

def valtype_vectype : vectype -> valtype
  def valtype_vectype(V128_vectype) = V128_valtype

;; 1-syntax.watsup:107.1-107.40
syntax inn =
  | I32
  | I64

def numtype_inn : inn -> numtype
  def numtype_inn(I32_inn) = I32_numtype
  def numtype_inn(I64_inn) = I64_numtype

def valtype_inn : inn -> valtype
  def valtype_inn(I32_inn) = I32_valtype
  def valtype_inn(I64_inn) = I64_valtype

;; 1-syntax.watsup:108.1-108.40
syntax fnn =
  | F32
  | F64

def numtype_fnn : fnn -> numtype
  def numtype_fnn(F32_fnn) = F32_numtype
  def numtype_fnn(F64_fnn) = F64_numtype

def valtype_fnn : fnn -> valtype
  def valtype_fnn(F32_fnn) = F32_valtype
  def valtype_fnn(F64_fnn) = F64_valtype

;; 1-syntax.watsup:115.1-116.11
syntax resulttype = valtype*

;; 1-syntax.watsup:118.1-118.18
syntax mut = `MUT%?`(()?)

;; 1-syntax.watsup:120.1-121.16
syntax limits = `[%..%]`(u32, u32)

;; 1-syntax.watsup:122.1-123.14
syntax globaltype = `%%`(mut, valtype)

;; 1-syntax.watsup:124.1-125.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:126.1-127.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:128.1-129.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:130.1-131.10
syntax elemtype = reftype

;; 1-syntax.watsup:132.1-133.5
syntax datatype = OK

;; 1-syntax.watsup:134.1-135.70
syntax externtype =
  | FUNC(functype)
  | GLOBAL(globaltype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:147.1-147.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:149.1-149.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:150.1-150.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:152.1-154.66
syntax binop_IXX =
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

;; 1-syntax.watsup:155.1-155.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:157.1-157.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:158.1-158.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:160.1-161.112
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:162.1-162.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:164.1-164.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:165.1-165.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:166.1-166.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:167.1-167.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:168.1-168.53
syntax cvtop =
  | CONVERT
  | REINTERPRET
  | CONVERT_SAT

;; 1-syntax.watsup:176.1-176.68
syntax memop = {ALIGN u32, OFFSET u32}

;; 1-syntax.watsup:184.1-184.23
syntax c_numtype = nat

;; 1-syntax.watsup:185.1-185.23
syntax c_vectype = nat

;; 1-syntax.watsup:188.1-190.17
syntax blocktype =
  | _RESULT(valtype?)
  | _IDX(funcidx)

;; 1-syntax.watsup:248.1-256.80
rec {

;; 1-syntax.watsup:248.1-256.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
}

;; 1-syntax.watsup:258.1-259.9
syntax expr = instr*

;; 1-syntax.watsup:269.1-269.61
syntax elemmode =
  | ACTIVE(tableidx, expr)
  | PASSIVE
  | DECLARE

;; 1-syntax.watsup:270.1-270.49
syntax datamode =
  | ACTIVE(memidx, expr)
  | PASSIVE

;; 1-syntax.watsup:272.1-273.16
syntax type = TYPE(functype)

;; 1-syntax.watsup:274.1-275.16
syntax local = LOCAL(valtype)

;; 1-syntax.watsup:276.1-277.27
syntax func = `FUNC%%*%`(typeidx, local*, expr)

;; 1-syntax.watsup:278.1-279.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:280.1-281.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:282.1-283.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:284.1-285.30
syntax elem = `ELEM%%*%`(reftype, expr*, elemmode)

;; 1-syntax.watsup:286.1-287.22
syntax data = `DATA%*%`(byte*, datamode)

;; 1-syntax.watsup:288.1-289.16
syntax start = START(funcidx)

;; 1-syntax.watsup:291.1-292.66
syntax externidx =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:293.1-294.24
syntax export = EXPORT(name, externidx)

;; 1-syntax.watsup:295.1-296.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:298.1-299.76
syntax module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*, import*, func*, global*, table*, mem*, elem*, data*, start*, export*)

;; 2-aux.watsup:7.1-7.14
def Ki : nat
  ;; 2-aux.watsup:8.1-8.15
  def Ki = 1024

;; 2-aux.watsup:13.1-13.25
rec {

;; 2-aux.watsup:13.1-13.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:14.1-14.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:15.1-15.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:16.1-16.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:18.1-18.21
rec {

;; 2-aux.watsup:18.1-18.21
def sum : nat* -> nat
  ;; 2-aux.watsup:19.1-19.22
  def sum([]) = 0
  ;; 2-aux.watsup:20.1-20.35
  def {n : n, n'* : n*} sum([n] :: n'*{n'}) = (n + $sum(n'*{n'}))
}

;; 2-aux.watsup:31.1-31.55
def size : valtype -> nat
  ;; 2-aux.watsup:32.1-32.20
  def size(I32_valtype) = 32
  ;; 2-aux.watsup:33.1-33.20
  def size(I64_valtype) = 64
  ;; 2-aux.watsup:34.1-34.20
  def size(F32_valtype) = 32
  ;; 2-aux.watsup:35.1-35.20
  def size(F64_valtype) = 64
  ;; 2-aux.watsup:36.1-36.22
  def size(V128_valtype) = 128

;; 2-aux.watsup:43.1-43.57
def signed : (nat, nat) -> int
  ;; 2-aux.watsup:44.1-44.54
  def {N : nat, i : nat} signed(N, i) = (i <: int)
    -- if (0 <= (2 ^ (N - 1)))
  ;; 2-aux.watsup:45.1-45.60
  def {N : nat, i : nat} signed(N, i) = ((i - (2 ^ N)) <: int)
    -- if (((2 ^ (N - 1)) <= i) /\ (i < (2 ^ N)))

;; 2-aux.watsup:47.1-47.63
def invsigned : (nat, int) -> nat
  ;; 2-aux.watsup:48.1-48.56
  def {N : nat, i : nat, j : nat} invsigned(N, (i <: int)) = j
    -- if ($signed(N, j) = (i <: int))

;; 2-aux.watsup:55.1-55.33
def memop0 : memop
  ;; 2-aux.watsup:56.1-56.34
  def memop0 = {ALIGN 0, OFFSET 0}

;; 2-aux.watsup:61.1-61.68
def free_dataidx_instr : instr -> dataidx*
  ;; 2-aux.watsup:62.1-62.43
  def {x : idx} free_dataidx_instr(MEMORY.INIT_instr(x)) = [x]
  ;; 2-aux.watsup:63.1-63.41
  def {x : idx} free_dataidx_instr(DATA.DROP_instr(x)) = [x]
  ;; 2-aux.watsup:64.1-64.38
  def {in : instr} free_dataidx_instr(in) = []

;; 2-aux.watsup:66.1-66.70
rec {

;; 2-aux.watsup:66.1-66.70
def free_dataidx_instrs : instr* -> dataidx*
  ;; 2-aux.watsup:67.1-67.44
  def free_dataidx_instrs([]) = []
  ;; 2-aux.watsup:68.1-68.99
  def {instr : instr, instr'* : instr*} free_dataidx_instrs([instr] :: instr'*{instr'}) = $free_dataidx_instr(instr) :: $free_dataidx_instrs(instr'*{instr'})
}

;; 2-aux.watsup:70.1-70.66
def free_dataidx_expr : expr -> dataidx*
  ;; 2-aux.watsup:71.1-71.56
  def {in* : instr*} free_dataidx_expr(in*{in}) = $free_dataidx_instrs(in*{in})

;; 2-aux.watsup:73.1-73.66
def free_dataidx_func : func -> dataidx*
  ;; 2-aux.watsup:74.1-74.62
  def {e : expr, loc* : local*, x : idx} free_dataidx_func(`FUNC%%*%`(x, loc*{loc}, e)) = $free_dataidx_expr(e)

;; 2-aux.watsup:76.1-76.68
rec {

;; 2-aux.watsup:76.1-76.68
def free_dataidx_funcs : func* -> dataidx*
  ;; 2-aux.watsup:77.1-77.43
  def free_dataidx_funcs([]) = []
  ;; 2-aux.watsup:78.1-78.92
  def {func : func, func'* : func*} free_dataidx_funcs([func] :: func'*{func'}) = $free_dataidx_func(func) :: $free_dataidx_funcs(func'*{func'})
}

;; 2-aux.watsup:86.1-86.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:87.1-87.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:89.1-89.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:90.1-90.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:92.1-101.43
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

;; 3-typing.watsup:5.1-8.60
syntax context = {TYPE functype*, FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:18.1-18.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:26.1-28.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%]`(n_1, n_2), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:19.1-19.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:30.1-31.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:20.1-20.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:33.1-34.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:21.1-21.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:36.1-38.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:22.1-22.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:40.1-42.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:23.1-23.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:45.1-47.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:49.1-51.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:53.1-55.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:57.1-59.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:69.1-69.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:72.1-73.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:75.1-76.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:70.1-70.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:78.1-80.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:85.1-85.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:93.1-96.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%]`(n_11, n_12), `[%..%]`(n_21, n_22))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:86.1-86.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:98.1-99.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:87.1-87.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:101.1-102.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:88.1-88.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:104.1-106.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:89.1-89.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:108.1-110.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:90.1-90.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:113.1-115.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:117.1-119.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:121.1-123.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:125.1-127.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:192.1-192.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:194.1-195.44
  rule void {C : context}:
    `%|-%:%`(C, _RESULT_blocktype(?()), `%->%`([], []))

  ;; 3-typing.watsup:197.1-198.32
  rule result {C : context, t : valtype}:
    `%|-%:%`(C, _RESULT_blocktype(?(t)), `%->%`([], [t]))

  ;; 3-typing.watsup:200.1-202.23
  rule typeidx {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, _IDX_blocktype(x), ft)
    -- if (C.TYPE_context[x] = ft)

;; 3-typing.watsup:135.1-136.67
rec {

;; 3-typing.watsup:135.1-135.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:171.1-172.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:174.1-175.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:177.1-178.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:181.1-182.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?([t])), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:184.1-187.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = $valtype_numtype(numtype)) \/ (t' = $valtype_vectype(vectype)))

  ;; 3-typing.watsup:205.1-208.59
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:210.1-213.59
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1*{t_1}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:215.1-219.61
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:224.1-226.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:228.1-230.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:232.1-235.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:240.1-242.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 3-typing.watsup:244.1-246.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (C.FUNC_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:248.1-251.33
  rule call_indirect {C : context, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, y), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (C.TYPE_context[y] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:256.1-257.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:259.1-260.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:262.1-263.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:265.1-266.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([$valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-269.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:272.1-274.23
  rule extend {C : context, n : n, nt : numtype}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))
    -- if (n <= $size($valtype_numtype(nt)))

  ;; 3-typing.watsup:276.1-279.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([$valtype_numtype(nt_2)], [$valtype_numtype(nt_1)]))
    -- if (nt_1 =/= nt_2)
    -- if ($size($valtype_numtype(nt_1)) = $size($valtype_numtype(nt_2)))

  ;; 3-typing.watsup:281.1-284.54
  rule convert-i {C : context, inn_1 : inn, inn_2 : inn, sx? : sx?}:
    `%|-%:%`(C, CVTOP_instr($numtype_inn(inn_1), CONVERT_cvtop, $numtype_inn(inn_2), sx?{sx}), `%->%`([$valtype_inn(inn_2)], [$valtype_inn(inn_1)]))
    -- if (inn_1 =/= inn_2)
    -- if ((sx?{sx} = ?()) <=> ($size($valtype_inn(inn_1)) > $size($valtype_inn(inn_2))))

  ;; 3-typing.watsup:286.1-288.24
  rule convert-f {C : context, fnn_1 : fnn, fnn_2 : fnn}:
    `%|-%:%`(C, CVTOP_instr($numtype_fnn(fnn_1), CONVERT_cvtop, $numtype_fnn(fnn_2), ?()), `%->%`([$valtype_fnn(fnn_2)], [$valtype_fnn(fnn_1)]))
    -- if (fnn_1 =/= fnn_2)

  ;; 3-typing.watsup:293.1-294.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [$valtype_reftype(rt)]))

  ;; 3-typing.watsup:296.1-298.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:300.1-301.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([$valtype_reftype(rt)], [I32_valtype]))

  ;; 3-typing.watsup:306.1-308.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:310.1-312.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:314.1-316.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:321.1-323.28
  rule global.get {C : context, mut : mut, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `%%`(mut, t))

  ;; 3-typing.watsup:325.1-327.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?(())), t))

  ;; 3-typing.watsup:332.1-334.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [$valtype_reftype(rt)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:336.1-338.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype $valtype_reftype(rt)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:340.1-342.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:344.1-346.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([$valtype_reftype(rt) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:348.1-350.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype $valtype_reftype(rt) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:352.1-355.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:357.1-360.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:362.1-364.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:369.1-371.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:373.1-375.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:377.1-379.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:381.1-383.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:385.1-388.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:390.1-392.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:394.1-399.33
  rule load {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [$valtype_numtype(nt)]))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= ($size($valtype_numtype(nt)) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size($valtype_numtype(nt)) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_inn(inn)))

  ;; 3-typing.watsup:401.1-406.33
  rule store {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype $valtype_numtype(nt)], []))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= ($size($valtype_numtype(nt)) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size($valtype_numtype(nt)) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_inn(inn)))

;; 3-typing.watsup:136.1-136.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:149.1-150.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:152.1-155.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:157.1-162.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:164.1-166.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:137.1-137.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:142.1-144.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:413.1-413.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:417.1-418.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:420.1-421.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:423.1-424.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:426.1-428.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?()), t))

;; 3-typing.watsup:414.1-414.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:431.1-432.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:415.1-415.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:435.1-438.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:445.1-445.73
relation Type_ok: `|-%:%`(type, functype)
  ;; 3-typing.watsup:459.1-461.29
  rule _ {ft : functype}:
    `|-%:%`(TYPE(ft), ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:446.1-446.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:463.1-467.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, `FUNC%%*%`(x, LOCAL(t)*{t}, expr), ft)
    -- if (C.TYPE_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:447.1-447.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:469.1-473.40
  rule _ {C : context, expr : expr, gt : globaltype, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `%%`(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:448.1-448.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:475.1-477.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:449.1-449.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:479.1-481.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:452.1-452.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:492.1-495.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:497.1-498.20
  rule passive {C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; 3-typing.watsup:500.1-501.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:450.1-450.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:483.1-486.37
  rule _ {C : context, elemmode : elemmode, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%`(rt, expr*{expr}, elemmode), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [$valtype_reftype(rt)]))*{expr}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, rt)

;; 3-typing.watsup:453.1-453.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:503.1-506.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, ACTIVE_datamode(0, expr))
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:508.1-509.20
  rule passive {C : context}:
    `%|-%:OK`(C, PASSIVE_datamode)

;; 3-typing.watsup:451.1-451.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:488.1-490.37
  rule _ {C : context, b* : byte*, datamode : datamode}:
    `%|-%:OK`(C, `DATA%*%`(b*{b}, datamode))
    -- Datamode_ok: `%|-%:OK`(C, datamode)

;; 3-typing.watsup:454.1-454.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:511.1-513.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:518.1-518.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:522.1-524.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:520.1-520.83
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; 3-typing.watsup:531.1-533.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype(ft))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:535.1-537.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:539.1-541.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:543.1-545.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (C.MEM_context[x] = mt)

;; 3-typing.watsup:519.1-519.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:526.1-528.39
  rule _ {C : context, externidx : externidx, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externidx), xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 3-typing.watsup:550.1-550.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:552.1-567.20
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, ft'* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*, type* : type*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (C = {TYPE ft'*{ft'}, FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Type_ok: `|-%:%`(type, ft'))*{ft' type}
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

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

;; 4-runtime.watsup:30.1-31.28
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:32.1-33.71
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:34.1-35.14
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:37.1-38.22
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:47.1-48.70
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:55.1-55.44
def default_ : valtype -> val
  ;; 4-runtime.watsup:56.1-56.35
  def default_(I32_valtype) = CONST_val(I32_numtype, 0)
  ;; 4-runtime.watsup:57.1-57.35
  def default_(I64_valtype) = CONST_val(I64_numtype, 0)
  ;; 4-runtime.watsup:58.1-58.35
  def default_(F32_valtype) = CONST_val(F32_numtype, 0)
  ;; 4-runtime.watsup:59.1-59.35
  def default_(F64_valtype) = CONST_val(F64_numtype, 0)
  ;; 4-runtime.watsup:60.1-60.44
  def default_(FUNCREF_valtype) = REF.NULL_val(FUNCREF_reftype)
  ;; 4-runtime.watsup:61.1-61.48
  def default_(EXTERNREF_valtype) = REF.NULL_val(EXTERNREF_reftype)

;; 4-runtime.watsup:88.1-90.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:92.1-100.25
syntax moduleinst = {TYPE functype*, FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:70.1-73.16
syntax funcinst = {TYPE functype, MODULE moduleinst, CODE func}

;; 4-runtime.watsup:74.1-76.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:77.1-79.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:80.1-82.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:83.1-85.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:86.1-87.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:114.1-120.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:122.1-124.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:126.1-126.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:213.1-220.9
rec {

;; 4-runtime.watsup:213.1-220.9
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | CALL_ADDR(funcaddr)
  | LABEL_(n, instr*, admininstr*)
  | FRAME_(n, frame, admininstr*)
  | TRAP
}

def admininstr_instr : instr -> admininstr
  def admininstr_instr(UNREACHABLE_instr) = UNREACHABLE_admininstr
  def admininstr_instr(NOP_instr) = NOP_admininstr
  def admininstr_instr(DROP_instr) = DROP_admininstr
  def {x : valtype*?} admininstr_instr(SELECT_instr(x)) = SELECT_admininstr(x)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(BLOCK_instr(x0, x1)) = BLOCK_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(LOOP_instr(x0, x1)) = LOOP_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*, x2 : instr*} admininstr_instr(IF_instr(x0, x1, x2)) = IF_admininstr(x0, x1, x2)
  def {x : labelidx} admininstr_instr(BR_instr(x)) = BR_admininstr(x)
  def {x : labelidx} admininstr_instr(BR_IF_instr(x)) = BR_IF_admininstr(x)
  def {x0 : labelidx*, x1 : labelidx} admininstr_instr(BR_TABLE_instr(x0, x1)) = BR_TABLE_admininstr(x0, x1)
  def {x : funcidx} admininstr_instr(CALL_instr(x)) = CALL_admininstr(x)
  def {x0 : tableidx, x1 : typeidx} admininstr_instr(CALL_INDIRECT_instr(x0, x1)) = CALL_INDIRECT_admininstr(x0, x1)
  def admininstr_instr(RETURN_instr) = RETURN_admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_instr(CONST_instr(x0, x1)) = CONST_admininstr(x0, x1)
  def {x0 : numtype, x1 : unop_numtype} admininstr_instr(UNOP_instr(x0, x1)) = UNOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : binop_numtype} admininstr_instr(BINOP_instr(x0, x1)) = BINOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : testop_numtype} admininstr_instr(TESTOP_instr(x0, x1)) = TESTOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : relop_numtype} admininstr_instr(RELOP_instr(x0, x1)) = RELOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : n} admininstr_instr(EXTEND_instr(x0, x1)) = EXTEND_admininstr(x0, x1)
  def {x0 : numtype, x1 : cvtop, x2 : numtype, x3 : sx?} admininstr_instr(CVTOP_instr(x0, x1, x2, x3)) = CVTOP_admininstr(x0, x1, x2, x3)
  def {x : reftype} admininstr_instr(REF.NULL_instr(x)) = REF.NULL_admininstr(x)
  def {x : funcidx} admininstr_instr(REF.FUNC_instr(x)) = REF.FUNC_admininstr(x)
  def admininstr_instr(REF.IS_NULL_instr) = REF.IS_NULL_admininstr
  def {x : localidx} admininstr_instr(LOCAL.GET_instr(x)) = LOCAL.GET_admininstr(x)
  def {x : localidx} admininstr_instr(LOCAL.SET_instr(x)) = LOCAL.SET_admininstr(x)
  def {x : localidx} admininstr_instr(LOCAL.TEE_instr(x)) = LOCAL.TEE_admininstr(x)
  def {x : globalidx} admininstr_instr(GLOBAL.GET_instr(x)) = GLOBAL.GET_admininstr(x)
  def {x : globalidx} admininstr_instr(GLOBAL.SET_instr(x)) = GLOBAL.SET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.GET_instr(x)) = TABLE.GET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.SET_instr(x)) = TABLE.SET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.SIZE_instr(x)) = TABLE.SIZE_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.GROW_instr(x)) = TABLE.GROW_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.FILL_instr(x)) = TABLE.FILL_admininstr(x)
  def {x0 : tableidx, x1 : tableidx} admininstr_instr(TABLE.COPY_instr(x0, x1)) = TABLE.COPY_admininstr(x0, x1)
  def {x0 : tableidx, x1 : elemidx} admininstr_instr(TABLE.INIT_instr(x0, x1)) = TABLE.INIT_admininstr(x0, x1)
  def {x : elemidx} admininstr_instr(ELEM.DROP_instr(x)) = ELEM.DROP_admininstr(x)
  def admininstr_instr(MEMORY.SIZE_instr) = MEMORY.SIZE_admininstr
  def admininstr_instr(MEMORY.GROW_instr) = MEMORY.GROW_admininstr
  def admininstr_instr(MEMORY.FILL_instr) = MEMORY.FILL_admininstr
  def admininstr_instr(MEMORY.COPY_instr) = MEMORY.COPY_admininstr
  def {x : dataidx} admininstr_instr(MEMORY.INIT_instr(x)) = MEMORY.INIT_admininstr(x)
  def {x : dataidx} admininstr_instr(DATA.DROP_instr(x)) = DATA.DROP_admininstr(x)
  def {x0 : numtype, x1 : (n, sx)?, x2 : memop} admininstr_instr(LOAD_instr(x0, x1, x2)) = LOAD_admininstr(x0, x1, x2)
  def {x0 : numtype, x1 : n?, x2 : memop} admininstr_instr(STORE_instr(x0, x1, x2)) = STORE_admininstr(x0, x1, x2)

def admininstr_ref : ref -> admininstr
  def {x : reftype} admininstr_ref(REF.NULL_ref(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_ref(REF.FUNC_ADDR_ref(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_ref(REF.HOST_ADDR_ref(x)) = REF.HOST_ADDR_admininstr(x)

def admininstr_val : val -> admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_val(CONST_val(x0, x1)) = CONST_admininstr(x0, x1)
  def {x : reftype} admininstr_val(REF.NULL_val(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_val(REF.FUNC_ADDR_val(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_val(REF.HOST_ADDR_val(x)) = REF.HOST_ADDR_admininstr(x)

;; 4-runtime.watsup:127.1-127.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:136.1-136.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:137.1-137.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:139.1-139.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:146.1-146.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:140.1-140.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:147.1-147.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:141.1-141.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:148.1-148.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:142.1-142.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:149.1-149.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:143.1-143.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:150.1-150.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:144.1-144.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:151.1-151.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:153.1-153.67
def type : (state, typeidx) -> functype
  ;; 4-runtime.watsup:162.1-162.40
  def {f : frame, s : store, x : idx} type(`%;%`(s, f), x) = f.MODULE_frame.TYPE_moduleinst[x]

;; 4-runtime.watsup:154.1-154.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:163.1-163.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:155.1-155.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:164.1-164.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:156.1-156.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:165.1-165.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:157.1-157.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:166.1-166.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:158.1-158.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:167.1-167.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:159.1-159.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:168.1-168.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:160.1-160.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:169.1-169.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:172.1-172.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:181.1-181.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:173.1-173.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:182.1-182.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:174.1-174.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:183.1-183.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:175.1-175.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:184.1-184.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:176.1-176.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:185.1-185.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:177.1-177.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:186.1-186.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:178.1-178.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:187.1-187.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:179.1-179.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:188.1-188.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:193.1-193.63
def grow_table : (tableinst, nat, ref) -> tableinst
  ;; 4-runtime.watsup:196.1-200.36
  def {i : nat, i' : nat, j : nat, n : n, r : ref, r'* : ref*, rt : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ti'
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%]`(i', j), rt), ELEM r'*{r'} :: r^n{}})
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)

;; 4-runtime.watsup:194.1-194.55
def grow_memory : (meminst, nat) -> meminst
  ;; 4-runtime.watsup:202.1-206.34
  def {b* : byte*, i : nat, i' : nat, j : nat, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = mi'
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%]`(i', j)), DATA b*{b} :: 0^((n * 64) * $Ki){}})
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)

;; 4-runtime.watsup:222.1-225.25
rec {

;; 4-runtime.watsup:222.1-225.25
syntax E =
  | _HOLE
  | _SEQ(val*, E, instr*)
  | LABEL_(n, instr*, E)
}

;; 5-numerics.watsup:3.1-3.79
def unop : (unop_numtype, numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:4.1-4.80
def binop : (binop_numtype, numtype, c_numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:5.1-5.79
def testop : (testop_numtype, numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:6.1-6.80
def relop : (relop_numtype, numtype, c_numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:8.1-8.84
def ext : (nat, nat, sx, c_numtype) -> c_numtype

;; 5-numerics.watsup:9.1-9.84
def cvtop : (numtype, cvtop, numtype, sx?, c_numtype) -> c_numtype*

;; 5-numerics.watsup:11.1-11.32
def wrap_ : ((nat, nat), c_numtype) -> nat

;; 5-numerics.watsup:13.1-13.60
def ibytes : (nat, iN) -> byte*

;; 5-numerics.watsup:14.1-14.60
def fbytes : (nat, fN) -> byte*

;; 5-numerics.watsup:15.1-15.58
def ntbytes : (numtype, c_numtype) -> byte*

;; 5-numerics.watsup:17.1-17.30
def invibytes : (nat, byte*) -> iN
  ;; 5-numerics.watsup:20.1-20.52
  def {N : nat, b* : byte*, n : n} invibytes(N, b*{b}) = n
    -- if ($ibytes(N, n) = b*{b})

;; 5-numerics.watsup:18.1-18.30
def invfbytes : (nat, byte*) -> fN
  ;; 5-numerics.watsup:21.1-21.52
  def {N : nat, b* : byte*, p : fN} invfbytes(N, b*{b}) = p
    -- if ($fbytes(N, p) = b*{b})

;; 6-reduction.watsup:6.1-6.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:24.1-25.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:27.1-28.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:30.1-31.24
  rule drop {val : val}:
    `%*~>%*`([$admininstr_val(val) DROP_admininstr], [])

  ;; 6-reduction.watsup:34.1-36.16
  rule select-true {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [$admininstr_val(val_1)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:38.1-40.14
  rule select-false {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [$admininstr_val(val_2)])
    -- if (c = 0)

  ;; 6-reduction.watsup:58.1-60.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:62.1-64.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:67.1-68.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, $admininstr_val(val)*{val})], $admininstr_val(val)*{val})

  ;; 6-reduction.watsup:74.1-75.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [BR_admininstr(0)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val} :: $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:77.1-78.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val)*{val} :: [BR_admininstr(l + 1)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:81.1-83.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:85.1-87.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:90.1-92.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:94.1-96.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:121.1-122.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val)^n{val})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:124.1-125.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:127.1-128.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, $admininstr_val(val)*{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:133.1-135.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 6-reduction.watsup:137.1-139.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:142.1-144.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 6-reduction.watsup:146.1-148.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:151.1-153.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 6-reduction.watsup:155.1-157.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 6-reduction.watsup:160.1-161.70
  rule extend {c : c_numtype, n : n, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, $size($valtype_numtype(nt)), S_sx, c))])

  ;; 6-reduction.watsup:164.1-166.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [c])

  ;; 6-reduction.watsup:168.1-170.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:179.1-181.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(rt))

  ;; 6-reduction.watsup:183.1-185.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:196.1-197.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([$admininstr_val(val) LOCAL.TEE_admininstr(x)], [$admininstr_val(val) $admininstr_val(val) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:45.1-45.73
def blocktype : (state, blocktype) -> functype
  ;; 6-reduction.watsup:46.1-46.56
  def {z : state} blocktype(z, _RESULT_blocktype(?())) = `%->%`([], [])
  ;; 6-reduction.watsup:47.1-47.44
  def {t : valtype, z : state} blocktype(z, _RESULT_blocktype(?(t))) = `%->%`([], [t])
  ;; 6-reduction.watsup:48.1-48.40
  def {x : idx, z : state} blocktype(z, _IDX_blocktype(x)) = $type(z, x)

;; 6-reduction.watsup:7.1-7.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:50.1-52.43
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})]), [LABEL__admininstr(n, [], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:54.1-56.43
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [LOOP_admininstr(bt, instr*{instr})]), [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:101.1-102.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:104.1-108.35
  rule call_indirect-call {a : addr, i : nat, instr* : instr*, t* : valtype*, x : idx, y : idx, y' : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [CALL_ADDR_admininstr(a)])
    -- if ($table(z, x).ELEM_tableinst[i] = REF.FUNC_ADDR_ref(a))
    -- if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(y', LOCAL(t)*{t}, instr*{instr}))
    -- if ($type(z, y) = $type(z, y'))

  ;; 6-reduction.watsup:110.1-112.15
  rule call_indirect-trap {i : nat, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:114.1-118.53
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, mm : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], $admininstr_instr(instr)*{instr})])])
    -- if ($funcinst(z)[a] = {TYPE `%->%`(t_1^k{t_1}, t_2^n{t_2}), MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, LOCAL(t)*{t}, instr*{instr}))
    -- if (f = {LOCAL val^k{val} :: $default_(t)*{t}, MODULE mm})

  ;; 6-reduction.watsup:175.1-176.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:190.1-191.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [$admininstr_val($local(z, x))])

  ;; 6-reduction.watsup:202.1-203.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [$admininstr_val($global(z, x).VALUE_globalinst)])

  ;; 6-reduction.watsup:211.1-213.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:215.1-217.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [$admininstr_ref($table(z, x).ELEM_tableinst[i])])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:228.1-230.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 6-reduction.watsup:241.1-243.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:245.1-248.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:250.1-254.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:257.1-259.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:261.1-264.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:266.1-271.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:273.1-277.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:280.1-282.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:284.1-287.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:289.1-293.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) $admininstr_ref($elem(z, y).ELEM_eleminst[i]) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:302.1-304.59
  rule load-num-trap {i : nat, mo : memop, nt : numtype, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + ($size($valtype_numtype(nt)) / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:306.1-308.71
  rule load-num-val {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [CONST_admininstr(nt, c)])
    -- if ($ntbytes(nt, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : ($size($valtype_numtype(nt)) / 8)])

  ;; 6-reduction.watsup:310.1-312.51
  rule load-pack-trap {i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:314.1-316.61
  rule load-pack-val {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [CONST_admininstr(nt, $ext(n, $size($valtype_numtype(nt)), sx, c))])
    -- if ($ibytes(n, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])

  ;; 6-reduction.watsup:336.1-338.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:349.1-351.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:353.1-356.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:358.1-362.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:365.1-367.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:369.1-372.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:374.1-379.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:381.1-385.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:388.1-390.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:392.1-395.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:397.1-401.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- otherwise

;; 6-reduction.watsup:5.1-5.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:9.1-11.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_pure: `%*~>%*`($admininstr_instr(instr)*{instr}, $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:13.1-15.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, $admininstr_instr(instr)*{instr}), $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:193.1-194.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:205.1-206.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:219.1-221.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:223.1-225.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:233.1-235.47
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if ($grow_table($table(z, x), n, ref) = ti)

  ;; 6-reduction.watsup:237.1-238.80
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:296.1-297.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:319.1-321.59
  rule store-num-trap {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + ($size($valtype_numtype(nt)) / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:323.1-325.29
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, mo : memop, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), ($size($valtype_numtype(nt)) / 8), b*{b}), []))
    -- if (b*{b} = $ntbytes(nt, c))

  ;; 6-reduction.watsup:327.1-329.51
  rule store-pack-trap {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:331.1-333.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), (n / 8), b*{b}), []))
    -- if (b*{b} = $ibytes(n, $wrap_(($size($valtype_numtype(nt)), n), c)))

  ;; 6-reduction.watsup:341.1-343.41
  rule memory.grow-succeed {mi : meminst, n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- if ($grow_memory($mem(z, 0), n) = mi)

  ;; 6-reduction.watsup:345.1-346.75
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:404.1-405.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:5.1-5.35
rec {

;; 7-module.watsup:5.1-5.35
def funcs : externval* -> funcaddr*
  ;; 7-module.watsup:6.1-6.30
  def funcs([]) = []
  ;; 7-module.watsup:7.1-7.59
  def {externval'* : externval*, fa : funcaddr} funcs([FUNC_externval(fa)] :: externval'*{externval'}) = [fa] :: $funcs(externval'*{externval'})
  ;; 7-module.watsup:8.1-9.15
  def {externval : externval, externval'* : externval*} funcs([externval] :: externval'*{externval'}) = $funcs(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:11.1-11.39
rec {

;; 7-module.watsup:11.1-11.39
def globals : externval* -> globaladdr*
  ;; 7-module.watsup:12.1-12.32
  def globals([]) = []
  ;; 7-module.watsup:13.1-13.65
  def {externval'* : externval*, ga : globaladdr} globals([GLOBAL_externval(ga)] :: externval'*{externval'}) = [ga] :: $globals(externval'*{externval'})
  ;; 7-module.watsup:14.1-15.15
  def {externval : externval, externval'* : externval*} globals([externval] :: externval'*{externval'}) = $globals(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:17.1-17.37
rec {

;; 7-module.watsup:17.1-17.37
def tables : externval* -> tableaddr*
  ;; 7-module.watsup:18.1-18.31
  def tables([]) = []
  ;; 7-module.watsup:19.1-19.62
  def {externval'* : externval*, ta : tableaddr} tables([TABLE_externval(ta)] :: externval'*{externval'}) = [ta] :: $tables(externval'*{externval'})
  ;; 7-module.watsup:20.1-21.15
  def {externval : externval, externval'* : externval*} tables([externval] :: externval'*{externval'}) = $tables(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:23.1-23.33
rec {

;; 7-module.watsup:23.1-23.33
def mems : externval* -> memaddr*
  ;; 7-module.watsup:24.1-24.29
  def mems([]) = []
  ;; 7-module.watsup:25.1-25.56
  def {externval'* : externval*, ma : memaddr} mems([MEM_externval(ma)] :: externval'*{externval'}) = [ma] :: $mems(externval'*{externval'})
  ;; 7-module.watsup:26.1-27.15
  def {externval : externval, externval'* : externval*} mems([externval] :: externval'*{externval'}) = $mems(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:36.1-36.60
def allocfunc : (store, moduleinst, func) -> (store, funcaddr)
  ;; 7-module.watsup:37.1-39.34
  def {expr : expr, fi : funcinst, func : func, local* : local*, mm : moduleinst, s : store, x : idx} allocfunc(s, mm, func) = (s[FUNC_store =.. [fi]], |s.FUNC_store|)
    -- if (fi = {TYPE mm.TYPE_moduleinst[x], MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, local*{local}, expr))

;; 7-module.watsup:41.1-41.63
rec {

;; 7-module.watsup:41.1-41.63
def allocfuncs : (store, moduleinst, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:42.1-42.47
  def {mm : moduleinst, s : store} allocfuncs(s, mm, []) = (s, [])
  ;; 7-module.watsup:43.1-45.51
  def {fa : funcaddr, fa'* : funcaddr*, func : func, func'* : func*, mm : moduleinst, s : store, s_1 : store, s_2 : store} allocfuncs(s, mm, [func] :: func'*{func'}) = (s_2, [fa] :: fa'*{fa'})
    -- if ((s_1, fa) = $allocfunc(s, mm, func))
    -- if ((s_2, fa'*{fa'}) = $allocfuncs(s_1, mm, func'*{func'}))
}

;; 7-module.watsup:47.1-47.63
def allocglobal : (store, globaltype, val) -> (store, globaladdr)
  ;; 7-module.watsup:48.1-49.44
  def {gi : globalinst, globaltype : globaltype, s : store, val : val} allocglobal(s, globaltype, val) = (s[GLOBAL_store =.. [gi]], |s.GLOBAL_store|)
    -- if (gi = {TYPE globaltype, VALUE val})

;; 7-module.watsup:51.1-51.67
rec {

;; 7-module.watsup:51.1-51.67
def allocglobals : (store, globaltype*, val*) -> (store, globaladdr*)
  ;; 7-module.watsup:52.1-52.54
  def {s : store} allocglobals(s, [], []) = (s, [])
  ;; 7-module.watsup:53.1-55.62
  def {ga : globaladdr, ga'* : globaladdr*, globaltype : globaltype, globaltype'* : globaltype*, s : store, s_1 : store, s_2 : store, val : val, val'* : val*} allocglobals(s, [globaltype] :: globaltype'*{globaltype'}, [val] :: val'*{val'}) = (s_2, [ga] :: ga'*{ga'})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga'}) = $allocglobals(s_1, globaltype'*{globaltype'}, val'*{val'}))
}

;; 7-module.watsup:57.1-57.55
def alloctable : (store, tabletype) -> (store, tableaddr)
  ;; 7-module.watsup:58.1-59.59
  def {i : nat, j : nat, rt : reftype, s : store, ti : tableinst} alloctable(s, `%%`(`[%..%]`(i, j), rt)) = (s[TABLE_store =.. [ti]], |s.TABLE_store|)
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM REF.NULL_ref(rt)^i{}})

;; 7-module.watsup:61.1-61.58
rec {

;; 7-module.watsup:61.1-61.58
def alloctables : (store, tabletype*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.44
  def {s : store} alloctables(s, []) = (s, [])
  ;; 7-module.watsup:63.1-65.53
  def {s : store, s_1 : store, s_2 : store, ta : tableaddr, ta'* : tableaddr*, tabletype : tabletype, tabletype'* : tabletype*} alloctables(s, [tabletype] :: tabletype'*{tabletype'}) = (s_2, [ta] :: ta'*{ta'})
    -- if ((s_1, ta) = $alloctable(s, tabletype))
    -- if ((s_2, ta'*{ta'}) = $alloctables(s_1, tabletype'*{tabletype'}))
}

;; 7-module.watsup:67.1-67.49
def allocmem : (store, memtype) -> (store, memaddr)
  ;; 7-module.watsup:68.1-69.62
  def {i : nat, j : nat, mi : meminst, s : store} allocmem(s, `%I8`(`[%..%]`(i, j))) = (s[MEM_store =.. [mi]], |s.MEM_store|)
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA 0^((i * 64) * $Ki){}})

;; 7-module.watsup:71.1-71.52
rec {

;; 7-module.watsup:71.1-71.52
def allocmems : (store, memtype*) -> (store, memaddr*)
  ;; 7-module.watsup:72.1-72.42
  def {s : store} allocmems(s, []) = (s, [])
  ;; 7-module.watsup:73.1-75.49
  def {ma : memaddr, ma'* : memaddr*, memtype : memtype, memtype'* : memtype*, s : store, s_1 : store, s_2 : store} allocmems(s, [memtype] :: memtype'*{memtype'}) = (s_2, [ma] :: ma'*{ma'})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma'}) = $allocmems(s_1, memtype'*{memtype'}))
}

;; 7-module.watsup:77.1-77.57
def allocelem : (store, reftype, ref*) -> (store, elemaddr)
  ;; 7-module.watsup:78.1-79.36
  def {ei : eleminst, ref* : ref*, rt : reftype, s : store} allocelem(s, rt, ref*{ref}) = (s[ELEM_store =.. [ei]], |s.ELEM_store|)
    -- if (ei = {TYPE rt, ELEM ref*{ref}})

;; 7-module.watsup:81.1-81.63
rec {

;; 7-module.watsup:81.1-81.63
def allocelems : (store, reftype*, ref**) -> (store, elemaddr*)
  ;; 7-module.watsup:82.1-82.52
  def {s : store} allocelems(s, [], []) = (s, [])
  ;; 7-module.watsup:83.1-85.55
  def {ea : elemaddr, ea'* : elemaddr*, ref* : ref*, ref'** : ref**, rt : reftype, rt'* : reftype*, s : store, s_1 : store, s_2 : store} allocelems(s, [rt] :: rt'*{rt'}, [ref*{ref}] :: ref'*{ref'}*{ref'}) = (s_2, [ea] :: ea'*{ea'})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref}))
    -- if ((s_2, ea'*{ea'}) = $allocelems(s_2, rt'*{rt'}, ref'*{ref'}*{ref'}))
}

;; 7-module.watsup:87.1-87.49
def allocdata : (store, byte*) -> (store, dataaddr)
  ;; 7-module.watsup:88.1-89.28
  def {byte* : byte*, di : datainst, s : store} allocdata(s, byte*{byte}) = (s[DATA_store =.. [di]], |s.DATA_store|)
    -- if (di = {DATA byte*{byte}})

;; 7-module.watsup:91.1-91.54
rec {

;; 7-module.watsup:91.1-91.54
def allocdatas : (store, byte**) -> (store, dataaddr*)
  ;; 7-module.watsup:92.1-92.43
  def {s : store} allocdatas(s, []) = (s, [])
  ;; 7-module.watsup:93.1-95.50
  def {byte* : byte*, byte'** : byte**, da : dataaddr, da'* : dataaddr*, s : store, s_1 : store, s_2 : store} allocdatas(s, [byte]*{byte} :: byte'*{byte'}*{byte'}) = (s_2, [da] :: da'*{da'})
    -- if ((s_1, da) = $allocdata(s, byte*{byte}))
    -- if ((s_2, da'*{da'}) = $allocdatas(s_1, byte'*{byte'}*{byte'}))
}

;; 7-module.watsup:100.1-100.83
def instexport : (funcaddr*, globaladdr*, tableaddr*, memaddr*, export) -> exportinst
  ;; 7-module.watsup:101.1-101.95
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, FUNC_externidx(x))) = {NAME name, VALUE FUNC_externval(fa*{fa}[x])}
  ;; 7-module.watsup:102.1-102.99
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, GLOBAL_externidx(x))) = {NAME name, VALUE GLOBAL_externval(ga*{ga}[x])}
  ;; 7-module.watsup:103.1-103.97
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, TABLE_externidx(x))) = {NAME name, VALUE TABLE_externval(ta*{ta}[x])}
  ;; 7-module.watsup:104.1-104.93
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, MEM_externidx(x))) = {NAME name, VALUE MEM_externval(ma*{ma}[x])}

;; 7-module.watsup:107.1-107.81
def allocmodule : (store, module, externval*, val*, ref**) -> (store, moduleinst)
  ;; 7-module.watsup:108.1-147.54
  def {byte*^n_data : byte*^n_data, da* : dataaddr*, datamode^n_data : datamode^n_data, ea* : elemaddr*, elemmode^n_elem : elemmode^n_elem, export* : export*, expr_1^n_global : expr^n_global, expr_2*^n_elem : expr*^n_elem, externval* : externval*, fa* : funcaddr*, fa_ex* : funcaddr*, ft : functype, func^n_func : func^n_func, ga* : globaladdr*, ga_ex* : globaladdr*, globaltype^n_global : globaltype^n_global, i_data^n_data : nat^n_data, i_elem^n_elem : nat^n_elem, i_func^n_func : nat^n_func, i_global^n_global : nat^n_global, i_mem^n_mem : nat^n_mem, i_table^n_table : nat^n_table, import* : import*, ma* : memaddr*, ma_ex* : memaddr*, memtype^n_mem : memtype^n_mem, mm : moduleinst, module : module, n_data : n, n_elem : n, n_func : n, n_global : n, n_mem : n, n_table : n, ref** : ref**, rt^n_elem : reftype^n_elem, s : store, s_1 : store, s_2 : store, s_3 : store, s_4 : store, s_5 : store, s_6 : store, start? : start?, ta* : tableaddr*, ta_ex* : tableaddr*, tabletype^n_table : tabletype^n_table, val* : val*, xi* : exportinst*} allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}) = (s_6, mm)
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(TYPE(ft)*{}, import*{import}, func^n_func{func}, GLOBAL(globaltype, expr_1)^n_global{expr_1 globaltype}, TABLE(tabletype)^n_table{tabletype}, MEMORY(memtype)^n_mem{memtype}, `ELEM%%*%`(rt, expr_2*{expr_2}, elemmode)^n_elem{elemmode expr_2 rt}, `DATA%*%`(byte*{byte}, datamode)^n_data{byte datamode}, start?{start}, export*{export}))
    -- if (fa_ex*{fa_ex} = $funcs(externval*{externval}))
    -- if (ga_ex*{ga_ex} = $globals(externval*{externval}))
    -- if (ta_ex*{ta_ex} = $tables(externval*{externval}))
    -- if (ma_ex*{ma_ex} = $mems(externval*{externval}))
    -- if (fa*{fa} = (|s.FUNC_store| + i_func)^(i_func<n_func){i_func})
    -- if (ga*{ga} = (|s.GLOBAL_store| + i_global)^(i_global<n_global){i_global})
    -- if (ta*{ta} = (|s.TABLE_store| + i_table)^(i_table<n_table){i_table})
    -- if (ma*{ma} = (|s.MEM_store| + i_mem)^(i_mem<n_mem){i_mem})
    -- if (ea*{ea} = (|s.ELEM_store| + i_elem)^(i_elem<n_elem){i_elem})
    -- if (da*{da} = (|s.DATA_store| + i_data)^(i_data<n_data){i_data})
    -- if (xi*{xi} = $instexport(fa_ex*{fa_ex} :: fa*{fa}, ga_ex*{ga_ex} :: ga*{ga}, ta_ex*{ta_ex} :: ta*{ta}, ma_ex*{ma_ex} :: ma*{ma}, export)*{export})
    -- if (mm = {TYPE [ft], FUNC fa_ex*{fa_ex} :: fa*{fa}, GLOBAL ga_ex*{ga_ex} :: ga*{ga}, TABLE ta_ex*{ta_ex} :: ta*{ta}, MEM ma_ex*{ma_ex} :: ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT xi*{xi}})
    -- if ((s_1, fa*{fa}) = $allocfuncs(s, mm, func^n_func{func}))
    -- if ((s_2, ga*{ga}) = $allocglobals(s_1, globaltype^n_global{globaltype}, val*{val}))
    -- if ((s_3, ta*{ta}) = $alloctables(s_2, tabletype^n_table{tabletype}))
    -- if ((s_4, ma*{ma}) = $allocmems(s_3, memtype^n_mem{memtype}))
    -- if ((s_5, ea*{ea}) = $allocelems(s_4, rt^n_elem{rt}, ref*{ref}*{ref}))
    -- if ((s_6, da*{da}) = $allocdatas(s_5, byte*{byte}^n_data{byte}))

;; 7-module.watsup:154.1-154.36
rec {

;; 7-module.watsup:154.1-154.36
def concat_instr : instr** -> instr*
  ;; 7-module.watsup:155.1-155.37
  def concat_instr([]) = []
  ;; 7-module.watsup:156.1-156.68
  def {instr* : instr*, instr'** : instr**} concat_instr([instr]*{instr} :: instr'*{instr'}*{instr'}) = instr*{instr} :: $concat_instr(instr'*{instr'}*{instr'})
}

;; 7-module.watsup:158.1-158.33
def runelem : (elem, idx) -> instr*
  ;; 7-module.watsup:159.1-159.56
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, PASSIVE_elemmode), i) = []
  ;; 7-module.watsup:160.1-160.62
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, DECLARE_elemmode), i) = [ELEM.DROP_instr(i)]
  ;; 7-module.watsup:161.1-163.20
  def {expr* : expr*, i : nat, instr* : instr*, n : n, reftype : reftype, x : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, ACTIVE_elemmode(x, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) TABLE.INIT_instr(x, i) ELEM.DROP_instr(i)]
    -- if (n = |expr*{expr}|)

;; 7-module.watsup:165.1-165.33
def rundata : (data, idx) -> instr*
  ;; 7-module.watsup:166.1-166.48
  def {byte* : byte*, i : nat} rundata(`DATA%*%`(byte*{byte}, PASSIVE_datamode), i) = []
  ;; 7-module.watsup:167.1-169.20
  def {byte* : byte*, i : nat, instr* : instr*, n : n} rundata(`DATA%*%`(byte*{byte}, ACTIVE_datamode(0, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) MEMORY.INIT_instr(i) DATA.DROP_instr(i)]
    -- if (n = |byte*{byte}|)

;; 7-module.watsup:171.1-171.53
def instantiate : (store, module, externval*) -> config
  ;; 7-module.watsup:172.1-196.28
  def {data* : data*, elem* : elem*, elemmode* : elemmode*, export* : export*, externval* : externval*, f : frame, f_init : frame, func* : func*, functype* : functype*, global* : global*, globaltype* : globaltype*, i^n_elem : nat^n_elem, import* : import*, instr_1** : instr**, instr_2*** : instr***, instr_data* : instr*, instr_elem* : instr*, j^n_data : nat^n_data, mem* : mem*, mm : moduleinst, mm_init : moduleinst, module : module, n_data : n, n_elem : n, ref** : ref**, reftype* : reftype*, s : store, s' : store, start? : start?, table* : table*, type* : type*, val* : val*, x? : idx?} instantiate(s, module, externval*{externval}) = `%;%*`(`%;%`(s', f), $admininstr_instr(instr_elem)*{instr_elem} :: $admininstr_instr(instr_data)*{instr_data} :: CALL_admininstr(x)?{x})
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (type*{type} = TYPE(functype)*{functype})
    -- if (global*{global} = GLOBAL(globaltype, instr_1*{instr_1})*{globaltype instr_1})
    -- if (elem*{elem} = `ELEM%%*%`(reftype, instr_2*{instr_2}*{instr_2}, elemmode)*{elemmode instr_2 reftype})
    -- if (mm_init = {TYPE functype*{functype}, FUNC $funcs(externval*{externval}), GLOBAL $globals(externval*{externval}), TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f_init = {LOCAL [], MODULE mm_init})
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), $admininstr_instr(instr_1)*{instr_1}), [$admininstr_val(val)]))*{instr_1 val}
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), $admininstr_instr(instr_2)*{instr_2}), [$admininstr_ref(ref)]))*{instr_2 ref}*{instr_2 ref}
    -- if ((s', mm) = $allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}))
    -- if (f = {LOCAL [], MODULE mm})
    -- if (n_elem = |elem*{elem}|)
    -- if (instr_elem*{instr_elem} = $concat_instr($runelem(elem*{elem}[i], i)^(i<n_elem){i}))
    -- if (n_data = |data*{data}|)
    -- if (instr_data*{instr_data} = $concat_instr($rundata(data*{data}[j], j)^(j<n_data){j}))
    -- if (start?{start} = START(x)?{x})

;; 7-module.watsup:203.1-203.44
def invoke : (store, funcaddr, val*) -> config
  ;; 7-module.watsup:204.1-215.51
  def {f : frame, fa : funcaddr, mm : moduleinst, n : n, s : store, t_1^n : valtype^n, t_2* : valtype*, val^n : val^n} invoke(s, fa, val^n{val}) = `%;%*`(`%;%`(s, f), $admininstr_val(val)^n{val} :: [CALL_ADDR_admininstr(fa)])
    -- if (mm = {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE mm})
    -- if ($funcinst(`%;%`(s, f))[fa].TYPE_funcinst = `%->%`(t_1^n{t_1}, t_2*{t_2}))

;; A-binary.watsup:47.1-47.57
rec {

;; A-binary.watsup:47.1-47.57
def concat_bytes : byte** -> byte*
  ;; A-binary.watsup:48.1-48.37
  def concat_bytes([]) = []
  ;; A-binary.watsup:49.1-49.52
  def {b* : byte*, b'** : byte**} concat_bytes([b]*{b} :: b'*{b'}*{b'}) = b*{b} :: $concat_bytes(b'*{b'}*{b'})
}

;; A-binary.watsup:51.1-51.24
rec {

;; A-binary.watsup:51.1-51.24
def utf8 : name -> byte*
  ;; A-binary.watsup:52.1-52.44
  def {b : byte, c : c_numtype} utf8([c]) = [b]
    -- if ((c < 128) /\ (c = b))
  ;; A-binary.watsup:53.1-53.93
  def {b_1 : byte, b_2 : byte, c : c_numtype} utf8([c]) = [b_1 b_2]
    -- if (((128 <= c) /\ (c < 2048)) /\ (c = (((2 ^ 6) * (b_1 - 192)) + (b_2 - 128))))
  ;; A-binary.watsup:54.1-54.144
  def {b_1 : byte, b_2 : byte, b_3 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3]
    -- if ((((2048 <= c) /\ (c < 55296)) \/ ((57344 <= c) /\ (c < 65536))) /\ (c = ((((2 ^ 12) * (b_1 - 224)) + ((2 ^ 6) * (b_2 - 128))) + (b_3 - 128))))
  ;; A-binary.watsup:55.1-55.145
  def {b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3 b_4]
    -- if (((65536 <= c) /\ (c < 69632)) /\ (c = (((((2 ^ 18) * (b_1 - 240)) + ((2 ^ 12) * (b_2 - 128))) + ((2 ^ 6) * (b_3 - 128))) + (b_4 - 128))))
  ;; A-binary.watsup:56.1-56.41
  def {c* : c_numtype*} utf8(c*{c}) = $concat_bytes($utf8([c])*{c})
}

;; A-binary.watsup:577.1-577.60
rec {

;; A-binary.watsup:577.1-577.60
def concat_locals : local** -> local*
  ;; A-binary.watsup:578.1-578.38
  def concat_locals([]) = []
  ;; A-binary.watsup:579.1-579.62
  def {loc* : local*, loc'** : local**} concat_locals([loc]*{loc} :: loc'*{loc'}*{loc'}) = loc*{loc} :: $concat_locals(loc'*{loc'}*{loc'})
}

;; A-binary.watsup:582.1-582.29
syntax code = (local*, expr)

== IL Validation after pass sub...
== Running pass totalize...

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:4.1-4.15
syntax m = nat

;; 1-syntax.watsup:18.1-18.50
syntax byte = nat

;; 1-syntax.watsup:21.1-21.58
syntax uN = nat

;; 1-syntax.watsup:22.1-22.87
syntax sN = nat

;; 1-syntax.watsup:23.1-23.36
syntax iN = uN

;; 1-syntax.watsup:26.1-26.58
syntax u32 = nat

;; 1-syntax.watsup:27.1-27.58
syntax u64 = nat

;; 1-syntax.watsup:28.1-28.61
syntax u128 = nat

;; 1-syntax.watsup:29.1-29.69
syntax s33 = nat

;; 1-syntax.watsup:34.1-34.21
def signif : nat -> nat
  ;; 1-syntax.watsup:35.1-35.21
  def signif(32) = 23
  ;; 1-syntax.watsup:36.1-36.21
  def signif(64) = 52

;; 1-syntax.watsup:38.1-38.20
def expon : nat -> nat
  ;; 1-syntax.watsup:39.1-39.19
  def expon(32) = 8
  ;; 1-syntax.watsup:40.1-40.20
  def expon(64) = 11

;; 1-syntax.watsup:42.1-42.35
def M : nat -> nat
  ;; 1-syntax.watsup:43.1-43.23
  def {N : nat} M(N) = $signif(N)

;; 1-syntax.watsup:45.1-45.35
def E : nat -> nat
  ;; 1-syntax.watsup:46.1-46.22
  def {N : nat} E(N) = $expon(N)

;; 1-syntax.watsup:51.1-55.81
syntax fNmag =
  |  {N : nat, n : n}NORM(m, n)
    -- if (((2 - (2 ^ ($E(N) - 1))) <= n) /\ (n <= ((2 ^ ($E(N) - 1)) - 1)))
  |  {N : nat, n : n}SUBNORM(m, n)
    -- if ((2 - (2 ^ ($E(N) - 1))) = n)
  | INF
  |  {N : nat, n : n}NAN(n)
    -- if ((1 <= n) /\ (n < $M(N)))

;; 1-syntax.watsup:49.1-49.107
syntax fN =
  | POS(fNmag)
  | NEG(fNmag)

;; 1-syntax.watsup:58.1-58.35
def fNzero : fN
  ;; 1-syntax.watsup:59.1-59.29
  def fNzero = POS_fN(NORM_fNmag(0, 0))

;; 1-syntax.watsup:62.1-62.51
syntax f32 = fN

;; 1-syntax.watsup:63.1-63.51
syntax f64 = fN

;; 1-syntax.watsup:71.1-71.85
syntax char = nat

;; 1-syntax.watsup:73.1-73.38
syntax name = char*

;; 1-syntax.watsup:80.1-80.36
syntax idx = u32

;; 1-syntax.watsup:81.1-81.45
syntax typeidx = idx

;; 1-syntax.watsup:82.1-82.49
syntax funcidx = idx

;; 1-syntax.watsup:83.1-83.49
syntax globalidx = idx

;; 1-syntax.watsup:84.1-84.47
syntax tableidx = idx

;; 1-syntax.watsup:85.1-85.46
syntax memidx = idx

;; 1-syntax.watsup:86.1-86.45
syntax elemidx = idx

;; 1-syntax.watsup:87.1-87.45
syntax dataidx = idx

;; 1-syntax.watsup:88.1-88.47
syntax labelidx = idx

;; 1-syntax.watsup:89.1-89.47
syntax localidx = idx

;; 1-syntax.watsup:98.1-99.26
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:100.1-101.9
syntax vectype =
  | V128

;; 1-syntax.watsup:102.1-103.24
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:104.1-105.38
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | FUNCREF
  | EXTERNREF
  | BOT

def valtype_numtype : numtype -> valtype
  def valtype_numtype(I32_numtype) = I32_valtype
  def valtype_numtype(I64_numtype) = I64_valtype
  def valtype_numtype(F32_numtype) = F32_valtype
  def valtype_numtype(F64_numtype) = F64_valtype

def valtype_reftype : reftype -> valtype
  def valtype_reftype(FUNCREF_reftype) = FUNCREF_valtype
  def valtype_reftype(EXTERNREF_reftype) = EXTERNREF_valtype

def valtype_vectype : vectype -> valtype
  def valtype_vectype(V128_vectype) = V128_valtype

;; 1-syntax.watsup:107.1-107.40
syntax inn =
  | I32
  | I64

def numtype_inn : inn -> numtype
  def numtype_inn(I32_inn) = I32_numtype
  def numtype_inn(I64_inn) = I64_numtype

def valtype_inn : inn -> valtype
  def valtype_inn(I32_inn) = I32_valtype
  def valtype_inn(I64_inn) = I64_valtype

;; 1-syntax.watsup:108.1-108.40
syntax fnn =
  | F32
  | F64

def numtype_fnn : fnn -> numtype
  def numtype_fnn(F32_fnn) = F32_numtype
  def numtype_fnn(F64_fnn) = F64_numtype

def valtype_fnn : fnn -> valtype
  def valtype_fnn(F32_fnn) = F32_valtype
  def valtype_fnn(F64_fnn) = F64_valtype

;; 1-syntax.watsup:115.1-116.11
syntax resulttype = valtype*

;; 1-syntax.watsup:118.1-118.18
syntax mut = `MUT%?`(()?)

;; 1-syntax.watsup:120.1-121.16
syntax limits = `[%..%]`(u32, u32)

;; 1-syntax.watsup:122.1-123.14
syntax globaltype = `%%`(mut, valtype)

;; 1-syntax.watsup:124.1-125.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:126.1-127.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:128.1-129.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:130.1-131.10
syntax elemtype = reftype

;; 1-syntax.watsup:132.1-133.5
syntax datatype = OK

;; 1-syntax.watsup:134.1-135.70
syntax externtype =
  | FUNC(functype)
  | GLOBAL(globaltype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:147.1-147.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:149.1-149.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:150.1-150.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:152.1-154.66
syntax binop_IXX =
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

;; 1-syntax.watsup:155.1-155.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:157.1-157.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:158.1-158.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:160.1-161.112
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:162.1-162.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:164.1-164.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:165.1-165.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:166.1-166.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:167.1-167.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:168.1-168.53
syntax cvtop =
  | CONVERT
  | REINTERPRET
  | CONVERT_SAT

;; 1-syntax.watsup:176.1-176.68
syntax memop = {ALIGN u32, OFFSET u32}

;; 1-syntax.watsup:184.1-184.23
syntax c_numtype = nat

;; 1-syntax.watsup:185.1-185.23
syntax c_vectype = nat

;; 1-syntax.watsup:188.1-190.17
syntax blocktype =
  | _RESULT(valtype?)
  | _IDX(funcidx)

;; 1-syntax.watsup:248.1-256.80
rec {

;; 1-syntax.watsup:248.1-256.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
}

;; 1-syntax.watsup:258.1-259.9
syntax expr = instr*

;; 1-syntax.watsup:269.1-269.61
syntax elemmode =
  | ACTIVE(tableidx, expr)
  | PASSIVE
  | DECLARE

;; 1-syntax.watsup:270.1-270.49
syntax datamode =
  | ACTIVE(memidx, expr)
  | PASSIVE

;; 1-syntax.watsup:272.1-273.16
syntax type = TYPE(functype)

;; 1-syntax.watsup:274.1-275.16
syntax local = LOCAL(valtype)

;; 1-syntax.watsup:276.1-277.27
syntax func = `FUNC%%*%`(typeidx, local*, expr)

;; 1-syntax.watsup:278.1-279.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:280.1-281.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:282.1-283.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:284.1-285.30
syntax elem = `ELEM%%*%`(reftype, expr*, elemmode)

;; 1-syntax.watsup:286.1-287.22
syntax data = `DATA%*%`(byte*, datamode)

;; 1-syntax.watsup:288.1-289.16
syntax start = START(funcidx)

;; 1-syntax.watsup:291.1-292.66
syntax externidx =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:293.1-294.24
syntax export = EXPORT(name, externidx)

;; 1-syntax.watsup:295.1-296.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:298.1-299.76
syntax module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*, import*, func*, global*, table*, mem*, elem*, data*, start*, export*)

;; 2-aux.watsup:7.1-7.14
def Ki : nat
  ;; 2-aux.watsup:8.1-8.15
  def Ki = 1024

;; 2-aux.watsup:13.1-13.25
rec {

;; 2-aux.watsup:13.1-13.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:14.1-14.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:15.1-15.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:16.1-16.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:18.1-18.21
rec {

;; 2-aux.watsup:18.1-18.21
def sum : nat* -> nat
  ;; 2-aux.watsup:19.1-19.22
  def sum([]) = 0
  ;; 2-aux.watsup:20.1-20.35
  def {n : n, n'* : n*} sum([n] :: n'*{n'}) = (n + $sum(n'*{n'}))
}

;; 2-aux.watsup:31.1-31.55
def size : valtype -> nat?
  ;; 2-aux.watsup:32.1-32.20
  def size(I32_valtype) = ?(32)
  ;; 2-aux.watsup:33.1-33.20
  def size(I64_valtype) = ?(64)
  ;; 2-aux.watsup:34.1-34.20
  def size(F32_valtype) = ?(32)
  ;; 2-aux.watsup:35.1-35.20
  def size(F64_valtype) = ?(64)
  ;; 2-aux.watsup:36.1-36.22
  def size(V128_valtype) = ?(128)
  def {x : valtype} size(x) = ?()

;; 2-aux.watsup:43.1-43.57
def signed : (nat, nat) -> int
  ;; 2-aux.watsup:44.1-44.54
  def {N : nat, i : nat} signed(N, i) = (i <: int)
    -- if (0 <= (2 ^ (N - 1)))
  ;; 2-aux.watsup:45.1-45.60
  def {N : nat, i : nat} signed(N, i) = ((i - (2 ^ N)) <: int)
    -- if (((2 ^ (N - 1)) <= i) /\ (i < (2 ^ N)))

;; 2-aux.watsup:47.1-47.63
def invsigned : (nat, int) -> nat
  ;; 2-aux.watsup:48.1-48.56
  def {N : nat, i : nat, j : nat} invsigned(N, (i <: int)) = j
    -- if ($signed(N, j) = (i <: int))

;; 2-aux.watsup:55.1-55.33
def memop0 : memop
  ;; 2-aux.watsup:56.1-56.34
  def memop0 = {ALIGN 0, OFFSET 0}

;; 2-aux.watsup:61.1-61.68
def free_dataidx_instr : instr -> dataidx*
  ;; 2-aux.watsup:62.1-62.43
  def {x : idx} free_dataidx_instr(MEMORY.INIT_instr(x)) = [x]
  ;; 2-aux.watsup:63.1-63.41
  def {x : idx} free_dataidx_instr(DATA.DROP_instr(x)) = [x]
  ;; 2-aux.watsup:64.1-64.38
  def {in : instr} free_dataidx_instr(in) = []

;; 2-aux.watsup:66.1-66.70
rec {

;; 2-aux.watsup:66.1-66.70
def free_dataidx_instrs : instr* -> dataidx*
  ;; 2-aux.watsup:67.1-67.44
  def free_dataidx_instrs([]) = []
  ;; 2-aux.watsup:68.1-68.99
  def {instr : instr, instr'* : instr*} free_dataidx_instrs([instr] :: instr'*{instr'}) = $free_dataidx_instr(instr) :: $free_dataidx_instrs(instr'*{instr'})
}

;; 2-aux.watsup:70.1-70.66
def free_dataidx_expr : expr -> dataidx*
  ;; 2-aux.watsup:71.1-71.56
  def {in* : instr*} free_dataidx_expr(in*{in}) = $free_dataidx_instrs(in*{in})

;; 2-aux.watsup:73.1-73.66
def free_dataidx_func : func -> dataidx*
  ;; 2-aux.watsup:74.1-74.62
  def {e : expr, loc* : local*, x : idx} free_dataidx_func(`FUNC%%*%`(x, loc*{loc}, e)) = $free_dataidx_expr(e)

;; 2-aux.watsup:76.1-76.68
rec {

;; 2-aux.watsup:76.1-76.68
def free_dataidx_funcs : func* -> dataidx*
  ;; 2-aux.watsup:77.1-77.43
  def free_dataidx_funcs([]) = []
  ;; 2-aux.watsup:78.1-78.92
  def {func : func, func'* : func*} free_dataidx_funcs([func] :: func'*{func'}) = $free_dataidx_func(func) :: $free_dataidx_funcs(func'*{func'})
}

;; 2-aux.watsup:86.1-86.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:87.1-87.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:89.1-89.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:90.1-90.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:92.1-101.43
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

;; 3-typing.watsup:5.1-8.60
syntax context = {TYPE functype*, FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:18.1-18.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:26.1-28.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%]`(n_1, n_2), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:19.1-19.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:30.1-31.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:20.1-20.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:33.1-34.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:21.1-21.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:36.1-38.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:22.1-22.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:40.1-42.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:23.1-23.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:45.1-47.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:49.1-51.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:53.1-55.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:57.1-59.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:69.1-69.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:72.1-73.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:75.1-76.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:70.1-70.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:78.1-80.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:85.1-85.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:93.1-96.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%]`(n_11, n_12), `[%..%]`(n_21, n_22))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:86.1-86.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:98.1-99.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:87.1-87.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:101.1-102.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:88.1-88.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:104.1-106.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:89.1-89.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:108.1-110.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:90.1-90.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:113.1-115.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:117.1-119.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:121.1-123.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:125.1-127.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:192.1-192.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:194.1-195.44
  rule void {C : context}:
    `%|-%:%`(C, _RESULT_blocktype(?()), `%->%`([], []))

  ;; 3-typing.watsup:197.1-198.32
  rule result {C : context, t : valtype}:
    `%|-%:%`(C, _RESULT_blocktype(?(t)), `%->%`([], [t]))

  ;; 3-typing.watsup:200.1-202.23
  rule typeidx {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, _IDX_blocktype(x), ft)
    -- if (C.TYPE_context[x] = ft)

;; 3-typing.watsup:135.1-136.67
rec {

;; 3-typing.watsup:135.1-135.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:171.1-172.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:174.1-175.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:177.1-178.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:181.1-182.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?([t])), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:184.1-187.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = $valtype_numtype(numtype)) \/ (t' = $valtype_vectype(vectype)))

  ;; 3-typing.watsup:205.1-208.59
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:210.1-213.59
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1*{t_1}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:215.1-219.61
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:224.1-226.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:228.1-230.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:232.1-235.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:240.1-242.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 3-typing.watsup:244.1-246.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (C.FUNC_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:248.1-251.33
  rule call_indirect {C : context, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, y), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (C.TYPE_context[y] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:256.1-257.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:259.1-260.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:262.1-263.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:265.1-266.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([$valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-269.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:272.1-274.23
  rule extend {C : context, n : n, nt : numtype}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))
    -- if (n <= !($size($valtype_numtype(nt))))

  ;; 3-typing.watsup:276.1-279.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([$valtype_numtype(nt_2)], [$valtype_numtype(nt_1)]))
    -- if (nt_1 =/= nt_2)
    -- if (!($size($valtype_numtype(nt_1))) = !($size($valtype_numtype(nt_2))))

  ;; 3-typing.watsup:281.1-284.54
  rule convert-i {C : context, inn_1 : inn, inn_2 : inn, sx? : sx?}:
    `%|-%:%`(C, CVTOP_instr($numtype_inn(inn_1), CONVERT_cvtop, $numtype_inn(inn_2), sx?{sx}), `%->%`([$valtype_inn(inn_2)], [$valtype_inn(inn_1)]))
    -- if (inn_1 =/= inn_2)
    -- if ((sx?{sx} = ?()) <=> (!($size($valtype_inn(inn_1))) > !($size($valtype_inn(inn_2)))))

  ;; 3-typing.watsup:286.1-288.24
  rule convert-f {C : context, fnn_1 : fnn, fnn_2 : fnn}:
    `%|-%:%`(C, CVTOP_instr($numtype_fnn(fnn_1), CONVERT_cvtop, $numtype_fnn(fnn_2), ?()), `%->%`([$valtype_fnn(fnn_2)], [$valtype_fnn(fnn_1)]))
    -- if (fnn_1 =/= fnn_2)

  ;; 3-typing.watsup:293.1-294.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [$valtype_reftype(rt)]))

  ;; 3-typing.watsup:296.1-298.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:300.1-301.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([$valtype_reftype(rt)], [I32_valtype]))

  ;; 3-typing.watsup:306.1-308.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:310.1-312.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:314.1-316.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:321.1-323.28
  rule global.get {C : context, mut : mut, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `%%`(mut, t))

  ;; 3-typing.watsup:325.1-327.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?(())), t))

  ;; 3-typing.watsup:332.1-334.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [$valtype_reftype(rt)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:336.1-338.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype $valtype_reftype(rt)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:340.1-342.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:344.1-346.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([$valtype_reftype(rt) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:348.1-350.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype $valtype_reftype(rt) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:352.1-355.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:357.1-360.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:362.1-364.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:369.1-371.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:373.1-375.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:377.1-379.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:381.1-383.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:385.1-388.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:390.1-392.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:394.1-399.33
  rule load {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [$valtype_numtype(nt)]))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (!($size($valtype_numtype(nt))) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (!($size($valtype_numtype(nt))) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_inn(inn)))

  ;; 3-typing.watsup:401.1-406.33
  rule store {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype $valtype_numtype(nt)], []))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (!($size($valtype_numtype(nt))) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (!($size($valtype_numtype(nt))) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_inn(inn)))

;; 3-typing.watsup:136.1-136.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:149.1-150.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:152.1-155.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:157.1-162.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:164.1-166.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:137.1-137.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:142.1-144.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:413.1-413.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:417.1-418.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:420.1-421.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:423.1-424.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:426.1-428.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?()), t))

;; 3-typing.watsup:414.1-414.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:431.1-432.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:415.1-415.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:435.1-438.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:445.1-445.73
relation Type_ok: `|-%:%`(type, functype)
  ;; 3-typing.watsup:459.1-461.29
  rule _ {ft : functype}:
    `|-%:%`(TYPE(ft), ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:446.1-446.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:463.1-467.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, `FUNC%%*%`(x, LOCAL(t)*{t}, expr), ft)
    -- if (C.TYPE_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:447.1-447.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:469.1-473.40
  rule _ {C : context, expr : expr, gt : globaltype, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `%%`(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:448.1-448.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:475.1-477.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:449.1-449.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:479.1-481.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:452.1-452.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:492.1-495.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:497.1-498.20
  rule passive {C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; 3-typing.watsup:500.1-501.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:450.1-450.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:483.1-486.37
  rule _ {C : context, elemmode : elemmode, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%`(rt, expr*{expr}, elemmode), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [$valtype_reftype(rt)]))*{expr}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, rt)

;; 3-typing.watsup:453.1-453.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:503.1-506.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, ACTIVE_datamode(0, expr))
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:508.1-509.20
  rule passive {C : context}:
    `%|-%:OK`(C, PASSIVE_datamode)

;; 3-typing.watsup:451.1-451.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:488.1-490.37
  rule _ {C : context, b* : byte*, datamode : datamode}:
    `%|-%:OK`(C, `DATA%*%`(b*{b}, datamode))
    -- Datamode_ok: `%|-%:OK`(C, datamode)

;; 3-typing.watsup:454.1-454.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:511.1-513.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:518.1-518.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:522.1-524.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:520.1-520.83
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; 3-typing.watsup:531.1-533.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype(ft))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:535.1-537.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:539.1-541.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:543.1-545.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (C.MEM_context[x] = mt)

;; 3-typing.watsup:519.1-519.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:526.1-528.39
  rule _ {C : context, externidx : externidx, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externidx), xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 3-typing.watsup:550.1-550.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:552.1-567.20
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, ft'* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*, type* : type*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (C = {TYPE ft'*{ft'}, FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Type_ok: `|-%:%`(type, ft'))*{ft' type}
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

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

;; 4-runtime.watsup:30.1-31.28
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:32.1-33.71
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:34.1-35.14
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:37.1-38.22
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:47.1-48.70
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:55.1-55.44
def default_ : valtype -> val?
  ;; 4-runtime.watsup:56.1-56.35
  def default_(I32_valtype) = ?(CONST_val(I32_numtype, 0))
  ;; 4-runtime.watsup:57.1-57.35
  def default_(I64_valtype) = ?(CONST_val(I64_numtype, 0))
  ;; 4-runtime.watsup:58.1-58.35
  def default_(F32_valtype) = ?(CONST_val(F32_numtype, 0))
  ;; 4-runtime.watsup:59.1-59.35
  def default_(F64_valtype) = ?(CONST_val(F64_numtype, 0))
  ;; 4-runtime.watsup:60.1-60.44
  def default_(FUNCREF_valtype) = ?(REF.NULL_val(FUNCREF_reftype))
  ;; 4-runtime.watsup:61.1-61.48
  def default_(EXTERNREF_valtype) = ?(REF.NULL_val(EXTERNREF_reftype))
  def {x : valtype} default_(x) = ?()

;; 4-runtime.watsup:88.1-90.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:92.1-100.25
syntax moduleinst = {TYPE functype*, FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:70.1-73.16
syntax funcinst = {TYPE functype, MODULE moduleinst, CODE func}

;; 4-runtime.watsup:74.1-76.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:77.1-79.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:80.1-82.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:83.1-85.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:86.1-87.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:114.1-120.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:122.1-124.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:126.1-126.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:213.1-220.9
rec {

;; 4-runtime.watsup:213.1-220.9
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | CALL_ADDR(funcaddr)
  | LABEL_(n, instr*, admininstr*)
  | FRAME_(n, frame, admininstr*)
  | TRAP
}

def admininstr_instr : instr -> admininstr
  def admininstr_instr(UNREACHABLE_instr) = UNREACHABLE_admininstr
  def admininstr_instr(NOP_instr) = NOP_admininstr
  def admininstr_instr(DROP_instr) = DROP_admininstr
  def {x : valtype*?} admininstr_instr(SELECT_instr(x)) = SELECT_admininstr(x)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(BLOCK_instr(x0, x1)) = BLOCK_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(LOOP_instr(x0, x1)) = LOOP_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*, x2 : instr*} admininstr_instr(IF_instr(x0, x1, x2)) = IF_admininstr(x0, x1, x2)
  def {x : labelidx} admininstr_instr(BR_instr(x)) = BR_admininstr(x)
  def {x : labelidx} admininstr_instr(BR_IF_instr(x)) = BR_IF_admininstr(x)
  def {x0 : labelidx*, x1 : labelidx} admininstr_instr(BR_TABLE_instr(x0, x1)) = BR_TABLE_admininstr(x0, x1)
  def {x : funcidx} admininstr_instr(CALL_instr(x)) = CALL_admininstr(x)
  def {x0 : tableidx, x1 : typeidx} admininstr_instr(CALL_INDIRECT_instr(x0, x1)) = CALL_INDIRECT_admininstr(x0, x1)
  def admininstr_instr(RETURN_instr) = RETURN_admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_instr(CONST_instr(x0, x1)) = CONST_admininstr(x0, x1)
  def {x0 : numtype, x1 : unop_numtype} admininstr_instr(UNOP_instr(x0, x1)) = UNOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : binop_numtype} admininstr_instr(BINOP_instr(x0, x1)) = BINOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : testop_numtype} admininstr_instr(TESTOP_instr(x0, x1)) = TESTOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : relop_numtype} admininstr_instr(RELOP_instr(x0, x1)) = RELOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : n} admininstr_instr(EXTEND_instr(x0, x1)) = EXTEND_admininstr(x0, x1)
  def {x0 : numtype, x1 : cvtop, x2 : numtype, x3 : sx?} admininstr_instr(CVTOP_instr(x0, x1, x2, x3)) = CVTOP_admininstr(x0, x1, x2, x3)
  def {x : reftype} admininstr_instr(REF.NULL_instr(x)) = REF.NULL_admininstr(x)
  def {x : funcidx} admininstr_instr(REF.FUNC_instr(x)) = REF.FUNC_admininstr(x)
  def admininstr_instr(REF.IS_NULL_instr) = REF.IS_NULL_admininstr
  def {x : localidx} admininstr_instr(LOCAL.GET_instr(x)) = LOCAL.GET_admininstr(x)
  def {x : localidx} admininstr_instr(LOCAL.SET_instr(x)) = LOCAL.SET_admininstr(x)
  def {x : localidx} admininstr_instr(LOCAL.TEE_instr(x)) = LOCAL.TEE_admininstr(x)
  def {x : globalidx} admininstr_instr(GLOBAL.GET_instr(x)) = GLOBAL.GET_admininstr(x)
  def {x : globalidx} admininstr_instr(GLOBAL.SET_instr(x)) = GLOBAL.SET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.GET_instr(x)) = TABLE.GET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.SET_instr(x)) = TABLE.SET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.SIZE_instr(x)) = TABLE.SIZE_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.GROW_instr(x)) = TABLE.GROW_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.FILL_instr(x)) = TABLE.FILL_admininstr(x)
  def {x0 : tableidx, x1 : tableidx} admininstr_instr(TABLE.COPY_instr(x0, x1)) = TABLE.COPY_admininstr(x0, x1)
  def {x0 : tableidx, x1 : elemidx} admininstr_instr(TABLE.INIT_instr(x0, x1)) = TABLE.INIT_admininstr(x0, x1)
  def {x : elemidx} admininstr_instr(ELEM.DROP_instr(x)) = ELEM.DROP_admininstr(x)
  def admininstr_instr(MEMORY.SIZE_instr) = MEMORY.SIZE_admininstr
  def admininstr_instr(MEMORY.GROW_instr) = MEMORY.GROW_admininstr
  def admininstr_instr(MEMORY.FILL_instr) = MEMORY.FILL_admininstr
  def admininstr_instr(MEMORY.COPY_instr) = MEMORY.COPY_admininstr
  def {x : dataidx} admininstr_instr(MEMORY.INIT_instr(x)) = MEMORY.INIT_admininstr(x)
  def {x : dataidx} admininstr_instr(DATA.DROP_instr(x)) = DATA.DROP_admininstr(x)
  def {x0 : numtype, x1 : (n, sx)?, x2 : memop} admininstr_instr(LOAD_instr(x0, x1, x2)) = LOAD_admininstr(x0, x1, x2)
  def {x0 : numtype, x1 : n?, x2 : memop} admininstr_instr(STORE_instr(x0, x1, x2)) = STORE_admininstr(x0, x1, x2)

def admininstr_ref : ref -> admininstr
  def {x : reftype} admininstr_ref(REF.NULL_ref(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_ref(REF.FUNC_ADDR_ref(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_ref(REF.HOST_ADDR_ref(x)) = REF.HOST_ADDR_admininstr(x)

def admininstr_val : val -> admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_val(CONST_val(x0, x1)) = CONST_admininstr(x0, x1)
  def {x : reftype} admininstr_val(REF.NULL_val(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_val(REF.FUNC_ADDR_val(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_val(REF.HOST_ADDR_val(x)) = REF.HOST_ADDR_admininstr(x)

;; 4-runtime.watsup:127.1-127.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:136.1-136.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:137.1-137.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:139.1-139.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:146.1-146.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:140.1-140.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:147.1-147.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:141.1-141.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:148.1-148.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:142.1-142.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:149.1-149.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:143.1-143.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:150.1-150.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:144.1-144.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:151.1-151.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:153.1-153.67
def type : (state, typeidx) -> functype
  ;; 4-runtime.watsup:162.1-162.40
  def {f : frame, s : store, x : idx} type(`%;%`(s, f), x) = f.MODULE_frame.TYPE_moduleinst[x]

;; 4-runtime.watsup:154.1-154.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:163.1-163.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:155.1-155.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:164.1-164.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:156.1-156.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:165.1-165.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:157.1-157.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:166.1-166.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:158.1-158.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:167.1-167.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:159.1-159.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:168.1-168.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:160.1-160.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:169.1-169.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:172.1-172.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:181.1-181.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:173.1-173.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:182.1-182.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:174.1-174.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:183.1-183.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:175.1-175.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:184.1-184.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:176.1-176.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:185.1-185.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:177.1-177.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:186.1-186.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:178.1-178.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:187.1-187.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:179.1-179.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:188.1-188.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:193.1-193.63
def grow_table : (tableinst, nat, ref) -> tableinst?
  ;; 4-runtime.watsup:196.1-200.36
  def {i : nat, i' : nat, j : nat, n : n, r : ref, r'* : ref*, rt : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ?(ti')
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%]`(i', j), rt), ELEM r'*{r'} :: r^n{}})
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)
  def {x : (tableinst, nat, ref)} grow_table(x) = ?()

;; 4-runtime.watsup:194.1-194.55
def grow_memory : (meminst, nat) -> meminst?
  ;; 4-runtime.watsup:202.1-206.34
  def {b* : byte*, i : nat, i' : nat, j : nat, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = ?(mi')
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%]`(i', j)), DATA b*{b} :: 0^((n * 64) * $Ki){}})
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)
  def {x : (meminst, nat)} grow_memory(x) = ?()

;; 4-runtime.watsup:222.1-225.25
rec {

;; 4-runtime.watsup:222.1-225.25
syntax E =
  | _HOLE
  | _SEQ(val*, E, instr*)
  | LABEL_(n, instr*, E)
}

;; 5-numerics.watsup:3.1-3.79
def unop : (unop_numtype, numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:4.1-4.80
def binop : (binop_numtype, numtype, c_numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:5.1-5.79
def testop : (testop_numtype, numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:6.1-6.80
def relop : (relop_numtype, numtype, c_numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:8.1-8.84
def ext : (nat, nat, sx, c_numtype) -> c_numtype

;; 5-numerics.watsup:9.1-9.84
def cvtop : (numtype, cvtop, numtype, sx?, c_numtype) -> c_numtype*

;; 5-numerics.watsup:11.1-11.32
def wrap_ : ((nat, nat), c_numtype) -> nat

;; 5-numerics.watsup:13.1-13.60
def ibytes : (nat, iN) -> byte*

;; 5-numerics.watsup:14.1-14.60
def fbytes : (nat, fN) -> byte*

;; 5-numerics.watsup:15.1-15.58
def ntbytes : (numtype, c_numtype) -> byte*

;; 5-numerics.watsup:17.1-17.30
def invibytes : (nat, byte*) -> iN
  ;; 5-numerics.watsup:20.1-20.52
  def {N : nat, b* : byte*, n : n} invibytes(N, b*{b}) = n
    -- if ($ibytes(N, n) = b*{b})

;; 5-numerics.watsup:18.1-18.30
def invfbytes : (nat, byte*) -> fN
  ;; 5-numerics.watsup:21.1-21.52
  def {N : nat, b* : byte*, p : fN} invfbytes(N, b*{b}) = p
    -- if ($fbytes(N, p) = b*{b})

;; 6-reduction.watsup:6.1-6.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:24.1-25.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:27.1-28.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:30.1-31.24
  rule drop {val : val}:
    `%*~>%*`([$admininstr_val(val) DROP_admininstr], [])

  ;; 6-reduction.watsup:34.1-36.16
  rule select-true {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [$admininstr_val(val_1)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:38.1-40.14
  rule select-false {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [$admininstr_val(val_2)])
    -- if (c = 0)

  ;; 6-reduction.watsup:58.1-60.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:62.1-64.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:67.1-68.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, $admininstr_val(val)*{val})], $admininstr_val(val)*{val})

  ;; 6-reduction.watsup:74.1-75.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [BR_admininstr(0)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val} :: $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:77.1-78.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val)*{val} :: [BR_admininstr(l + 1)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:81.1-83.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:85.1-87.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:90.1-92.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:94.1-96.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:121.1-122.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val)^n{val})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:124.1-125.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:127.1-128.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, $admininstr_val(val)*{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:133.1-135.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 6-reduction.watsup:137.1-139.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:142.1-144.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 6-reduction.watsup:146.1-148.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:151.1-153.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 6-reduction.watsup:155.1-157.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 6-reduction.watsup:160.1-161.70
  rule extend {c : c_numtype, n : n, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, !($size($valtype_numtype(nt))), S_sx, c))])

  ;; 6-reduction.watsup:164.1-166.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [c])

  ;; 6-reduction.watsup:168.1-170.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:179.1-181.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(rt))

  ;; 6-reduction.watsup:183.1-185.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:196.1-197.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([$admininstr_val(val) LOCAL.TEE_admininstr(x)], [$admininstr_val(val) $admininstr_val(val) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:45.1-45.73
def blocktype : (state, blocktype) -> functype
  ;; 6-reduction.watsup:46.1-46.56
  def {z : state} blocktype(z, _RESULT_blocktype(?())) = `%->%`([], [])
  ;; 6-reduction.watsup:47.1-47.44
  def {t : valtype, z : state} blocktype(z, _RESULT_blocktype(?(t))) = `%->%`([], [t])
  ;; 6-reduction.watsup:48.1-48.40
  def {x : idx, z : state} blocktype(z, _IDX_blocktype(x)) = $type(z, x)

;; 6-reduction.watsup:7.1-7.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:50.1-52.43
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})]), [LABEL__admininstr(n, [], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:54.1-56.43
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [LOOP_admininstr(bt, instr*{instr})]), [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:101.1-102.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:104.1-108.35
  rule call_indirect-call {a : addr, i : nat, instr* : instr*, t* : valtype*, x : idx, y : idx, y' : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [CALL_ADDR_admininstr(a)])
    -- if ($table(z, x).ELEM_tableinst[i] = REF.FUNC_ADDR_ref(a))
    -- if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(y', LOCAL(t)*{t}, instr*{instr}))
    -- if ($type(z, y) = $type(z, y'))

  ;; 6-reduction.watsup:110.1-112.15
  rule call_indirect-trap {i : nat, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:114.1-118.53
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, mm : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], $admininstr_instr(instr)*{instr})])])
    -- if ($funcinst(z)[a] = {TYPE `%->%`(t_1^k{t_1}, t_2^n{t_2}), MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, LOCAL(t)*{t}, instr*{instr}))
    -- if (f = {LOCAL val^k{val} :: !($default_(t))*{t}, MODULE mm})

  ;; 6-reduction.watsup:175.1-176.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:190.1-191.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [$admininstr_val($local(z, x))])

  ;; 6-reduction.watsup:202.1-203.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [$admininstr_val($global(z, x).VALUE_globalinst)])

  ;; 6-reduction.watsup:211.1-213.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:215.1-217.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [$admininstr_ref($table(z, x).ELEM_tableinst[i])])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:228.1-230.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 6-reduction.watsup:241.1-243.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:245.1-248.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:250.1-254.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:257.1-259.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:261.1-264.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:266.1-271.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:273.1-277.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:280.1-282.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:284.1-287.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:289.1-293.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) $admininstr_ref($elem(z, y).ELEM_eleminst[i]) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:302.1-304.59
  rule load-num-trap {i : nat, mo : memop, nt : numtype, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (!($size($valtype_numtype(nt))) / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:306.1-308.71
  rule load-num-val {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [CONST_admininstr(nt, c)])
    -- if ($ntbytes(nt, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (!($size($valtype_numtype(nt))) / 8)])

  ;; 6-reduction.watsup:310.1-312.51
  rule load-pack-trap {i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:314.1-316.61
  rule load-pack-val {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [CONST_admininstr(nt, $ext(n, !($size($valtype_numtype(nt))), sx, c))])
    -- if ($ibytes(n, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])

  ;; 6-reduction.watsup:336.1-338.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:349.1-351.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:353.1-356.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:358.1-362.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:365.1-367.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:369.1-372.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:374.1-379.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:381.1-385.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:388.1-390.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:392.1-395.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:397.1-401.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- otherwise

;; 6-reduction.watsup:5.1-5.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:9.1-11.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_pure: `%*~>%*`($admininstr_instr(instr)*{instr}, $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:13.1-15.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, $admininstr_instr(instr)*{instr}), $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:193.1-194.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:205.1-206.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:219.1-221.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:223.1-225.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:233.1-235.47
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if (!($grow_table($table(z, x), n, ref)) = ti)

  ;; 6-reduction.watsup:237.1-238.80
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:296.1-297.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:319.1-321.59
  rule store-num-trap {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + (!($size($valtype_numtype(nt))) / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:323.1-325.29
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, mo : memop, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), (!($size($valtype_numtype(nt))) / 8), b*{b}), []))
    -- if (b*{b} = $ntbytes(nt, c))

  ;; 6-reduction.watsup:327.1-329.51
  rule store-pack-trap {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:331.1-333.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), (n / 8), b*{b}), []))
    -- if (b*{b} = $ibytes(n, $wrap_((!($size($valtype_numtype(nt))), n), c)))

  ;; 6-reduction.watsup:341.1-343.41
  rule memory.grow-succeed {mi : meminst, n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- if (!($grow_memory($mem(z, 0), n)) = mi)

  ;; 6-reduction.watsup:345.1-346.75
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:404.1-405.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:5.1-5.35
rec {

;; 7-module.watsup:5.1-5.35
def funcs : externval* -> funcaddr*
  ;; 7-module.watsup:6.1-6.30
  def funcs([]) = []
  ;; 7-module.watsup:7.1-7.59
  def {externval'* : externval*, fa : funcaddr} funcs([FUNC_externval(fa)] :: externval'*{externval'}) = [fa] :: $funcs(externval'*{externval'})
  ;; 7-module.watsup:8.1-9.15
  def {externval : externval, externval'* : externval*} funcs([externval] :: externval'*{externval'}) = $funcs(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:11.1-11.39
rec {

;; 7-module.watsup:11.1-11.39
def globals : externval* -> globaladdr*
  ;; 7-module.watsup:12.1-12.32
  def globals([]) = []
  ;; 7-module.watsup:13.1-13.65
  def {externval'* : externval*, ga : globaladdr} globals([GLOBAL_externval(ga)] :: externval'*{externval'}) = [ga] :: $globals(externval'*{externval'})
  ;; 7-module.watsup:14.1-15.15
  def {externval : externval, externval'* : externval*} globals([externval] :: externval'*{externval'}) = $globals(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:17.1-17.37
rec {

;; 7-module.watsup:17.1-17.37
def tables : externval* -> tableaddr*
  ;; 7-module.watsup:18.1-18.31
  def tables([]) = []
  ;; 7-module.watsup:19.1-19.62
  def {externval'* : externval*, ta : tableaddr} tables([TABLE_externval(ta)] :: externval'*{externval'}) = [ta] :: $tables(externval'*{externval'})
  ;; 7-module.watsup:20.1-21.15
  def {externval : externval, externval'* : externval*} tables([externval] :: externval'*{externval'}) = $tables(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:23.1-23.33
rec {

;; 7-module.watsup:23.1-23.33
def mems : externval* -> memaddr*
  ;; 7-module.watsup:24.1-24.29
  def mems([]) = []
  ;; 7-module.watsup:25.1-25.56
  def {externval'* : externval*, ma : memaddr} mems([MEM_externval(ma)] :: externval'*{externval'}) = [ma] :: $mems(externval'*{externval'})
  ;; 7-module.watsup:26.1-27.15
  def {externval : externval, externval'* : externval*} mems([externval] :: externval'*{externval'}) = $mems(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:36.1-36.60
def allocfunc : (store, moduleinst, func) -> (store, funcaddr)
  ;; 7-module.watsup:37.1-39.34
  def {expr : expr, fi : funcinst, func : func, local* : local*, mm : moduleinst, s : store, x : idx} allocfunc(s, mm, func) = (s[FUNC_store =.. [fi]], |s.FUNC_store|)
    -- if (fi = {TYPE mm.TYPE_moduleinst[x], MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, local*{local}, expr))

;; 7-module.watsup:41.1-41.63
rec {

;; 7-module.watsup:41.1-41.63
def allocfuncs : (store, moduleinst, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:42.1-42.47
  def {mm : moduleinst, s : store} allocfuncs(s, mm, []) = (s, [])
  ;; 7-module.watsup:43.1-45.51
  def {fa : funcaddr, fa'* : funcaddr*, func : func, func'* : func*, mm : moduleinst, s : store, s_1 : store, s_2 : store} allocfuncs(s, mm, [func] :: func'*{func'}) = (s_2, [fa] :: fa'*{fa'})
    -- if ((s_1, fa) = $allocfunc(s, mm, func))
    -- if ((s_2, fa'*{fa'}) = $allocfuncs(s_1, mm, func'*{func'}))
}

;; 7-module.watsup:47.1-47.63
def allocglobal : (store, globaltype, val) -> (store, globaladdr)
  ;; 7-module.watsup:48.1-49.44
  def {gi : globalinst, globaltype : globaltype, s : store, val : val} allocglobal(s, globaltype, val) = (s[GLOBAL_store =.. [gi]], |s.GLOBAL_store|)
    -- if (gi = {TYPE globaltype, VALUE val})

;; 7-module.watsup:51.1-51.67
rec {

;; 7-module.watsup:51.1-51.67
def allocglobals : (store, globaltype*, val*) -> (store, globaladdr*)
  ;; 7-module.watsup:52.1-52.54
  def {s : store} allocglobals(s, [], []) = (s, [])
  ;; 7-module.watsup:53.1-55.62
  def {ga : globaladdr, ga'* : globaladdr*, globaltype : globaltype, globaltype'* : globaltype*, s : store, s_1 : store, s_2 : store, val : val, val'* : val*} allocglobals(s, [globaltype] :: globaltype'*{globaltype'}, [val] :: val'*{val'}) = (s_2, [ga] :: ga'*{ga'})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga'}) = $allocglobals(s_1, globaltype'*{globaltype'}, val'*{val'}))
}

;; 7-module.watsup:57.1-57.55
def alloctable : (store, tabletype) -> (store, tableaddr)
  ;; 7-module.watsup:58.1-59.59
  def {i : nat, j : nat, rt : reftype, s : store, ti : tableinst} alloctable(s, `%%`(`[%..%]`(i, j), rt)) = (s[TABLE_store =.. [ti]], |s.TABLE_store|)
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM REF.NULL_ref(rt)^i{}})

;; 7-module.watsup:61.1-61.58
rec {

;; 7-module.watsup:61.1-61.58
def alloctables : (store, tabletype*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.44
  def {s : store} alloctables(s, []) = (s, [])
  ;; 7-module.watsup:63.1-65.53
  def {s : store, s_1 : store, s_2 : store, ta : tableaddr, ta'* : tableaddr*, tabletype : tabletype, tabletype'* : tabletype*} alloctables(s, [tabletype] :: tabletype'*{tabletype'}) = (s_2, [ta] :: ta'*{ta'})
    -- if ((s_1, ta) = $alloctable(s, tabletype))
    -- if ((s_2, ta'*{ta'}) = $alloctables(s_1, tabletype'*{tabletype'}))
}

;; 7-module.watsup:67.1-67.49
def allocmem : (store, memtype) -> (store, memaddr)
  ;; 7-module.watsup:68.1-69.62
  def {i : nat, j : nat, mi : meminst, s : store} allocmem(s, `%I8`(`[%..%]`(i, j))) = (s[MEM_store =.. [mi]], |s.MEM_store|)
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA 0^((i * 64) * $Ki){}})

;; 7-module.watsup:71.1-71.52
rec {

;; 7-module.watsup:71.1-71.52
def allocmems : (store, memtype*) -> (store, memaddr*)
  ;; 7-module.watsup:72.1-72.42
  def {s : store} allocmems(s, []) = (s, [])
  ;; 7-module.watsup:73.1-75.49
  def {ma : memaddr, ma'* : memaddr*, memtype : memtype, memtype'* : memtype*, s : store, s_1 : store, s_2 : store} allocmems(s, [memtype] :: memtype'*{memtype'}) = (s_2, [ma] :: ma'*{ma'})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma'}) = $allocmems(s_1, memtype'*{memtype'}))
}

;; 7-module.watsup:77.1-77.57
def allocelem : (store, reftype, ref*) -> (store, elemaddr)
  ;; 7-module.watsup:78.1-79.36
  def {ei : eleminst, ref* : ref*, rt : reftype, s : store} allocelem(s, rt, ref*{ref}) = (s[ELEM_store =.. [ei]], |s.ELEM_store|)
    -- if (ei = {TYPE rt, ELEM ref*{ref}})

;; 7-module.watsup:81.1-81.63
rec {

;; 7-module.watsup:81.1-81.63
def allocelems : (store, reftype*, ref**) -> (store, elemaddr*)
  ;; 7-module.watsup:82.1-82.52
  def {s : store} allocelems(s, [], []) = (s, [])
  ;; 7-module.watsup:83.1-85.55
  def {ea : elemaddr, ea'* : elemaddr*, ref* : ref*, ref'** : ref**, rt : reftype, rt'* : reftype*, s : store, s_1 : store, s_2 : store} allocelems(s, [rt] :: rt'*{rt'}, [ref*{ref}] :: ref'*{ref'}*{ref'}) = (s_2, [ea] :: ea'*{ea'})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref}))
    -- if ((s_2, ea'*{ea'}) = $allocelems(s_2, rt'*{rt'}, ref'*{ref'}*{ref'}))
}

;; 7-module.watsup:87.1-87.49
def allocdata : (store, byte*) -> (store, dataaddr)
  ;; 7-module.watsup:88.1-89.28
  def {byte* : byte*, di : datainst, s : store} allocdata(s, byte*{byte}) = (s[DATA_store =.. [di]], |s.DATA_store|)
    -- if (di = {DATA byte*{byte}})

;; 7-module.watsup:91.1-91.54
rec {

;; 7-module.watsup:91.1-91.54
def allocdatas : (store, byte**) -> (store, dataaddr*)
  ;; 7-module.watsup:92.1-92.43
  def {s : store} allocdatas(s, []) = (s, [])
  ;; 7-module.watsup:93.1-95.50
  def {byte* : byte*, byte'** : byte**, da : dataaddr, da'* : dataaddr*, s : store, s_1 : store, s_2 : store} allocdatas(s, [byte]*{byte} :: byte'*{byte'}*{byte'}) = (s_2, [da] :: da'*{da'})
    -- if ((s_1, da) = $allocdata(s, byte*{byte}))
    -- if ((s_2, da'*{da'}) = $allocdatas(s_1, byte'*{byte'}*{byte'}))
}

;; 7-module.watsup:100.1-100.83
def instexport : (funcaddr*, globaladdr*, tableaddr*, memaddr*, export) -> exportinst
  ;; 7-module.watsup:101.1-101.95
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, FUNC_externidx(x))) = {NAME name, VALUE FUNC_externval(fa*{fa}[x])}
  ;; 7-module.watsup:102.1-102.99
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, GLOBAL_externidx(x))) = {NAME name, VALUE GLOBAL_externval(ga*{ga}[x])}
  ;; 7-module.watsup:103.1-103.97
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, TABLE_externidx(x))) = {NAME name, VALUE TABLE_externval(ta*{ta}[x])}
  ;; 7-module.watsup:104.1-104.93
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, MEM_externidx(x))) = {NAME name, VALUE MEM_externval(ma*{ma}[x])}

;; 7-module.watsup:107.1-107.81
def allocmodule : (store, module, externval*, val*, ref**) -> (store, moduleinst)
  ;; 7-module.watsup:108.1-147.54
  def {byte*^n_data : byte*^n_data, da* : dataaddr*, datamode^n_data : datamode^n_data, ea* : elemaddr*, elemmode^n_elem : elemmode^n_elem, export* : export*, expr_1^n_global : expr^n_global, expr_2*^n_elem : expr*^n_elem, externval* : externval*, fa* : funcaddr*, fa_ex* : funcaddr*, ft : functype, func^n_func : func^n_func, ga* : globaladdr*, ga_ex* : globaladdr*, globaltype^n_global : globaltype^n_global, i_data^n_data : nat^n_data, i_elem^n_elem : nat^n_elem, i_func^n_func : nat^n_func, i_global^n_global : nat^n_global, i_mem^n_mem : nat^n_mem, i_table^n_table : nat^n_table, import* : import*, ma* : memaddr*, ma_ex* : memaddr*, memtype^n_mem : memtype^n_mem, mm : moduleinst, module : module, n_data : n, n_elem : n, n_func : n, n_global : n, n_mem : n, n_table : n, ref** : ref**, rt^n_elem : reftype^n_elem, s : store, s_1 : store, s_2 : store, s_3 : store, s_4 : store, s_5 : store, s_6 : store, start? : start?, ta* : tableaddr*, ta_ex* : tableaddr*, tabletype^n_table : tabletype^n_table, val* : val*, xi* : exportinst*} allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}) = (s_6, mm)
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(TYPE(ft)*{}, import*{import}, func^n_func{func}, GLOBAL(globaltype, expr_1)^n_global{expr_1 globaltype}, TABLE(tabletype)^n_table{tabletype}, MEMORY(memtype)^n_mem{memtype}, `ELEM%%*%`(rt, expr_2*{expr_2}, elemmode)^n_elem{elemmode expr_2 rt}, `DATA%*%`(byte*{byte}, datamode)^n_data{byte datamode}, start?{start}, export*{export}))
    -- if (fa_ex*{fa_ex} = $funcs(externval*{externval}))
    -- if (ga_ex*{ga_ex} = $globals(externval*{externval}))
    -- if (ta_ex*{ta_ex} = $tables(externval*{externval}))
    -- if (ma_ex*{ma_ex} = $mems(externval*{externval}))
    -- if (fa*{fa} = (|s.FUNC_store| + i_func)^(i_func<n_func){i_func})
    -- if (ga*{ga} = (|s.GLOBAL_store| + i_global)^(i_global<n_global){i_global})
    -- if (ta*{ta} = (|s.TABLE_store| + i_table)^(i_table<n_table){i_table})
    -- if (ma*{ma} = (|s.MEM_store| + i_mem)^(i_mem<n_mem){i_mem})
    -- if (ea*{ea} = (|s.ELEM_store| + i_elem)^(i_elem<n_elem){i_elem})
    -- if (da*{da} = (|s.DATA_store| + i_data)^(i_data<n_data){i_data})
    -- if (xi*{xi} = $instexport(fa_ex*{fa_ex} :: fa*{fa}, ga_ex*{ga_ex} :: ga*{ga}, ta_ex*{ta_ex} :: ta*{ta}, ma_ex*{ma_ex} :: ma*{ma}, export)*{export})
    -- if (mm = {TYPE [ft], FUNC fa_ex*{fa_ex} :: fa*{fa}, GLOBAL ga_ex*{ga_ex} :: ga*{ga}, TABLE ta_ex*{ta_ex} :: ta*{ta}, MEM ma_ex*{ma_ex} :: ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT xi*{xi}})
    -- if ((s_1, fa*{fa}) = $allocfuncs(s, mm, func^n_func{func}))
    -- if ((s_2, ga*{ga}) = $allocglobals(s_1, globaltype^n_global{globaltype}, val*{val}))
    -- if ((s_3, ta*{ta}) = $alloctables(s_2, tabletype^n_table{tabletype}))
    -- if ((s_4, ma*{ma}) = $allocmems(s_3, memtype^n_mem{memtype}))
    -- if ((s_5, ea*{ea}) = $allocelems(s_4, rt^n_elem{rt}, ref*{ref}*{ref}))
    -- if ((s_6, da*{da}) = $allocdatas(s_5, byte*{byte}^n_data{byte}))

;; 7-module.watsup:154.1-154.36
rec {

;; 7-module.watsup:154.1-154.36
def concat_instr : instr** -> instr*
  ;; 7-module.watsup:155.1-155.37
  def concat_instr([]) = []
  ;; 7-module.watsup:156.1-156.68
  def {instr* : instr*, instr'** : instr**} concat_instr([instr]*{instr} :: instr'*{instr'}*{instr'}) = instr*{instr} :: $concat_instr(instr'*{instr'}*{instr'})
}

;; 7-module.watsup:158.1-158.33
def runelem : (elem, idx) -> instr*
  ;; 7-module.watsup:159.1-159.56
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, PASSIVE_elemmode), i) = []
  ;; 7-module.watsup:160.1-160.62
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, DECLARE_elemmode), i) = [ELEM.DROP_instr(i)]
  ;; 7-module.watsup:161.1-163.20
  def {expr* : expr*, i : nat, instr* : instr*, n : n, reftype : reftype, x : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, ACTIVE_elemmode(x, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) TABLE.INIT_instr(x, i) ELEM.DROP_instr(i)]
    -- if (n = |expr*{expr}|)

;; 7-module.watsup:165.1-165.33
def rundata : (data, idx) -> instr*
  ;; 7-module.watsup:166.1-166.48
  def {byte* : byte*, i : nat} rundata(`DATA%*%`(byte*{byte}, PASSIVE_datamode), i) = []
  ;; 7-module.watsup:167.1-169.20
  def {byte* : byte*, i : nat, instr* : instr*, n : n} rundata(`DATA%*%`(byte*{byte}, ACTIVE_datamode(0, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) MEMORY.INIT_instr(i) DATA.DROP_instr(i)]
    -- if (n = |byte*{byte}|)

;; 7-module.watsup:171.1-171.53
def instantiate : (store, module, externval*) -> config
  ;; 7-module.watsup:172.1-196.28
  def {data* : data*, elem* : elem*, elemmode* : elemmode*, export* : export*, externval* : externval*, f : frame, f_init : frame, func* : func*, functype* : functype*, global* : global*, globaltype* : globaltype*, i^n_elem : nat^n_elem, import* : import*, instr_1** : instr**, instr_2*** : instr***, instr_data* : instr*, instr_elem* : instr*, j^n_data : nat^n_data, mem* : mem*, mm : moduleinst, mm_init : moduleinst, module : module, n_data : n, n_elem : n, ref** : ref**, reftype* : reftype*, s : store, s' : store, start? : start?, table* : table*, type* : type*, val* : val*, x? : idx?} instantiate(s, module, externval*{externval}) = `%;%*`(`%;%`(s', f), $admininstr_instr(instr_elem)*{instr_elem} :: $admininstr_instr(instr_data)*{instr_data} :: CALL_admininstr(x)?{x})
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (type*{type} = TYPE(functype)*{functype})
    -- if (global*{global} = GLOBAL(globaltype, instr_1*{instr_1})*{globaltype instr_1})
    -- if (elem*{elem} = `ELEM%%*%`(reftype, instr_2*{instr_2}*{instr_2}, elemmode)*{elemmode instr_2 reftype})
    -- if (mm_init = {TYPE functype*{functype}, FUNC $funcs(externval*{externval}), GLOBAL $globals(externval*{externval}), TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f_init = {LOCAL [], MODULE mm_init})
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), $admininstr_instr(instr_1)*{instr_1}), [$admininstr_val(val)]))*{instr_1 val}
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), $admininstr_instr(instr_2)*{instr_2}), [$admininstr_ref(ref)]))*{instr_2 ref}*{instr_2 ref}
    -- if ((s', mm) = $allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}))
    -- if (f = {LOCAL [], MODULE mm})
    -- if (n_elem = |elem*{elem}|)
    -- if (instr_elem*{instr_elem} = $concat_instr($runelem(elem*{elem}[i], i)^(i<n_elem){i}))
    -- if (n_data = |data*{data}|)
    -- if (instr_data*{instr_data} = $concat_instr($rundata(data*{data}[j], j)^(j<n_data){j}))
    -- if (start?{start} = START(x)?{x})

;; 7-module.watsup:203.1-203.44
def invoke : (store, funcaddr, val*) -> config
  ;; 7-module.watsup:204.1-215.51
  def {f : frame, fa : funcaddr, mm : moduleinst, n : n, s : store, t_1^n : valtype^n, t_2* : valtype*, val^n : val^n} invoke(s, fa, val^n{val}) = `%;%*`(`%;%`(s, f), $admininstr_val(val)^n{val} :: [CALL_ADDR_admininstr(fa)])
    -- if (mm = {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE mm})
    -- if ($funcinst(`%;%`(s, f))[fa].TYPE_funcinst = `%->%`(t_1^n{t_1}, t_2*{t_2}))

;; A-binary.watsup:47.1-47.57
rec {

;; A-binary.watsup:47.1-47.57
def concat_bytes : byte** -> byte*
  ;; A-binary.watsup:48.1-48.37
  def concat_bytes([]) = []
  ;; A-binary.watsup:49.1-49.52
  def {b* : byte*, b'** : byte**} concat_bytes([b]*{b} :: b'*{b'}*{b'}) = b*{b} :: $concat_bytes(b'*{b'}*{b'})
}

;; A-binary.watsup:51.1-51.24
rec {

;; A-binary.watsup:51.1-51.24
def utf8 : name -> byte*
  ;; A-binary.watsup:52.1-52.44
  def {b : byte, c : c_numtype} utf8([c]) = [b]
    -- if ((c < 128) /\ (c = b))
  ;; A-binary.watsup:53.1-53.93
  def {b_1 : byte, b_2 : byte, c : c_numtype} utf8([c]) = [b_1 b_2]
    -- if (((128 <= c) /\ (c < 2048)) /\ (c = (((2 ^ 6) * (b_1 - 192)) + (b_2 - 128))))
  ;; A-binary.watsup:54.1-54.144
  def {b_1 : byte, b_2 : byte, b_3 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3]
    -- if ((((2048 <= c) /\ (c < 55296)) \/ ((57344 <= c) /\ (c < 65536))) /\ (c = ((((2 ^ 12) * (b_1 - 224)) + ((2 ^ 6) * (b_2 - 128))) + (b_3 - 128))))
  ;; A-binary.watsup:55.1-55.145
  def {b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3 b_4]
    -- if (((65536 <= c) /\ (c < 69632)) /\ (c = (((((2 ^ 18) * (b_1 - 240)) + ((2 ^ 12) * (b_2 - 128))) + ((2 ^ 6) * (b_3 - 128))) + (b_4 - 128))))
  ;; A-binary.watsup:56.1-56.41
  def {c* : c_numtype*} utf8(c*{c}) = $concat_bytes($utf8([c])*{c})
}

;; A-binary.watsup:577.1-577.60
rec {

;; A-binary.watsup:577.1-577.60
def concat_locals : local** -> local*
  ;; A-binary.watsup:578.1-578.38
  def concat_locals([]) = []
  ;; A-binary.watsup:579.1-579.62
  def {loc* : local*, loc'** : local**} concat_locals([loc]*{loc} :: loc'*{loc'}*{loc'}) = loc*{loc} :: $concat_locals(loc'*{loc'}*{loc'})
}

;; A-binary.watsup:582.1-582.29
syntax code = (local*, expr)

== IL Validation after pass totalize...
== Running pass the-elimination...

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:4.1-4.15
syntax m = nat

;; 1-syntax.watsup:18.1-18.50
syntax byte = nat

;; 1-syntax.watsup:21.1-21.58
syntax uN = nat

;; 1-syntax.watsup:22.1-22.87
syntax sN = nat

;; 1-syntax.watsup:23.1-23.36
syntax iN = uN

;; 1-syntax.watsup:26.1-26.58
syntax u32 = nat

;; 1-syntax.watsup:27.1-27.58
syntax u64 = nat

;; 1-syntax.watsup:28.1-28.61
syntax u128 = nat

;; 1-syntax.watsup:29.1-29.69
syntax s33 = nat

;; 1-syntax.watsup:34.1-34.21
def signif : nat -> nat
  ;; 1-syntax.watsup:35.1-35.21
  def signif(32) = 23
  ;; 1-syntax.watsup:36.1-36.21
  def signif(64) = 52

;; 1-syntax.watsup:38.1-38.20
def expon : nat -> nat
  ;; 1-syntax.watsup:39.1-39.19
  def expon(32) = 8
  ;; 1-syntax.watsup:40.1-40.20
  def expon(64) = 11

;; 1-syntax.watsup:42.1-42.35
def M : nat -> nat
  ;; 1-syntax.watsup:43.1-43.23
  def {N : nat} M(N) = $signif(N)

;; 1-syntax.watsup:45.1-45.35
def E : nat -> nat
  ;; 1-syntax.watsup:46.1-46.22
  def {N : nat} E(N) = $expon(N)

;; 1-syntax.watsup:51.1-55.81
syntax fNmag =
  |  {N : nat, n : n}NORM(m, n)
    -- if (((2 - (2 ^ ($E(N) - 1))) <= n) /\ (n <= ((2 ^ ($E(N) - 1)) - 1)))
  |  {N : nat, n : n}SUBNORM(m, n)
    -- if ((2 - (2 ^ ($E(N) - 1))) = n)
  | INF
  |  {N : nat, n : n}NAN(n)
    -- if ((1 <= n) /\ (n < $M(N)))

;; 1-syntax.watsup:49.1-49.107
syntax fN =
  | POS(fNmag)
  | NEG(fNmag)

;; 1-syntax.watsup:58.1-58.35
def fNzero : fN
  ;; 1-syntax.watsup:59.1-59.29
  def fNzero = POS_fN(NORM_fNmag(0, 0))

;; 1-syntax.watsup:62.1-62.51
syntax f32 = fN

;; 1-syntax.watsup:63.1-63.51
syntax f64 = fN

;; 1-syntax.watsup:71.1-71.85
syntax char = nat

;; 1-syntax.watsup:73.1-73.38
syntax name = char*

;; 1-syntax.watsup:80.1-80.36
syntax idx = u32

;; 1-syntax.watsup:81.1-81.45
syntax typeidx = idx

;; 1-syntax.watsup:82.1-82.49
syntax funcidx = idx

;; 1-syntax.watsup:83.1-83.49
syntax globalidx = idx

;; 1-syntax.watsup:84.1-84.47
syntax tableidx = idx

;; 1-syntax.watsup:85.1-85.46
syntax memidx = idx

;; 1-syntax.watsup:86.1-86.45
syntax elemidx = idx

;; 1-syntax.watsup:87.1-87.45
syntax dataidx = idx

;; 1-syntax.watsup:88.1-88.47
syntax labelidx = idx

;; 1-syntax.watsup:89.1-89.47
syntax localidx = idx

;; 1-syntax.watsup:98.1-99.26
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:100.1-101.9
syntax vectype =
  | V128

;; 1-syntax.watsup:102.1-103.24
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:104.1-105.38
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | FUNCREF
  | EXTERNREF
  | BOT

def valtype_numtype : numtype -> valtype
  def valtype_numtype(I32_numtype) = I32_valtype
  def valtype_numtype(I64_numtype) = I64_valtype
  def valtype_numtype(F32_numtype) = F32_valtype
  def valtype_numtype(F64_numtype) = F64_valtype

def valtype_reftype : reftype -> valtype
  def valtype_reftype(FUNCREF_reftype) = FUNCREF_valtype
  def valtype_reftype(EXTERNREF_reftype) = EXTERNREF_valtype

def valtype_vectype : vectype -> valtype
  def valtype_vectype(V128_vectype) = V128_valtype

;; 1-syntax.watsup:107.1-107.40
syntax inn =
  | I32
  | I64

def numtype_inn : inn -> numtype
  def numtype_inn(I32_inn) = I32_numtype
  def numtype_inn(I64_inn) = I64_numtype

def valtype_inn : inn -> valtype
  def valtype_inn(I32_inn) = I32_valtype
  def valtype_inn(I64_inn) = I64_valtype

;; 1-syntax.watsup:108.1-108.40
syntax fnn =
  | F32
  | F64

def numtype_fnn : fnn -> numtype
  def numtype_fnn(F32_fnn) = F32_numtype
  def numtype_fnn(F64_fnn) = F64_numtype

def valtype_fnn : fnn -> valtype
  def valtype_fnn(F32_fnn) = F32_valtype
  def valtype_fnn(F64_fnn) = F64_valtype

;; 1-syntax.watsup:115.1-116.11
syntax resulttype = valtype*

;; 1-syntax.watsup:118.1-118.18
syntax mut = `MUT%?`(()?)

;; 1-syntax.watsup:120.1-121.16
syntax limits = `[%..%]`(u32, u32)

;; 1-syntax.watsup:122.1-123.14
syntax globaltype = `%%`(mut, valtype)

;; 1-syntax.watsup:124.1-125.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:126.1-127.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:128.1-129.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:130.1-131.10
syntax elemtype = reftype

;; 1-syntax.watsup:132.1-133.5
syntax datatype = OK

;; 1-syntax.watsup:134.1-135.70
syntax externtype =
  | FUNC(functype)
  | GLOBAL(globaltype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:147.1-147.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:149.1-149.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:150.1-150.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:152.1-154.66
syntax binop_IXX =
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

;; 1-syntax.watsup:155.1-155.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:157.1-157.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:158.1-158.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:160.1-161.112
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:162.1-162.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:164.1-164.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:165.1-165.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:166.1-166.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:167.1-167.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:168.1-168.53
syntax cvtop =
  | CONVERT
  | REINTERPRET
  | CONVERT_SAT

;; 1-syntax.watsup:176.1-176.68
syntax memop = {ALIGN u32, OFFSET u32}

;; 1-syntax.watsup:184.1-184.23
syntax c_numtype = nat

;; 1-syntax.watsup:185.1-185.23
syntax c_vectype = nat

;; 1-syntax.watsup:188.1-190.17
syntax blocktype =
  | _RESULT(valtype?)
  | _IDX(funcidx)

;; 1-syntax.watsup:248.1-256.80
rec {

;; 1-syntax.watsup:248.1-256.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
}

;; 1-syntax.watsup:258.1-259.9
syntax expr = instr*

;; 1-syntax.watsup:269.1-269.61
syntax elemmode =
  | ACTIVE(tableidx, expr)
  | PASSIVE
  | DECLARE

;; 1-syntax.watsup:270.1-270.49
syntax datamode =
  | ACTIVE(memidx, expr)
  | PASSIVE

;; 1-syntax.watsup:272.1-273.16
syntax type = TYPE(functype)

;; 1-syntax.watsup:274.1-275.16
syntax local = LOCAL(valtype)

;; 1-syntax.watsup:276.1-277.27
syntax func = `FUNC%%*%`(typeidx, local*, expr)

;; 1-syntax.watsup:278.1-279.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:280.1-281.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:282.1-283.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:284.1-285.30
syntax elem = `ELEM%%*%`(reftype, expr*, elemmode)

;; 1-syntax.watsup:286.1-287.22
syntax data = `DATA%*%`(byte*, datamode)

;; 1-syntax.watsup:288.1-289.16
syntax start = START(funcidx)

;; 1-syntax.watsup:291.1-292.66
syntax externidx =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:293.1-294.24
syntax export = EXPORT(name, externidx)

;; 1-syntax.watsup:295.1-296.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:298.1-299.76
syntax module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*, import*, func*, global*, table*, mem*, elem*, data*, start*, export*)

;; 2-aux.watsup:7.1-7.14
def Ki : nat
  ;; 2-aux.watsup:8.1-8.15
  def Ki = 1024

;; 2-aux.watsup:13.1-13.25
rec {

;; 2-aux.watsup:13.1-13.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:14.1-14.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:15.1-15.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:16.1-16.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:18.1-18.21
rec {

;; 2-aux.watsup:18.1-18.21
def sum : nat* -> nat
  ;; 2-aux.watsup:19.1-19.22
  def sum([]) = 0
  ;; 2-aux.watsup:20.1-20.35
  def {n : n, n'* : n*} sum([n] :: n'*{n'}) = (n + $sum(n'*{n'}))
}

;; 2-aux.watsup:31.1-31.55
def size : valtype -> nat?
  ;; 2-aux.watsup:32.1-32.20
  def size(I32_valtype) = ?(32)
  ;; 2-aux.watsup:33.1-33.20
  def size(I64_valtype) = ?(64)
  ;; 2-aux.watsup:34.1-34.20
  def size(F32_valtype) = ?(32)
  ;; 2-aux.watsup:35.1-35.20
  def size(F64_valtype) = ?(64)
  ;; 2-aux.watsup:36.1-36.22
  def size(V128_valtype) = ?(128)
  def {x : valtype} size(x) = ?()

;; 2-aux.watsup:43.1-43.57
def signed : (nat, nat) -> int
  ;; 2-aux.watsup:44.1-44.54
  def {N : nat, i : nat} signed(N, i) = (i <: int)
    -- if (0 <= (2 ^ (N - 1)))
  ;; 2-aux.watsup:45.1-45.60
  def {N : nat, i : nat} signed(N, i) = ((i - (2 ^ N)) <: int)
    -- if (((2 ^ (N - 1)) <= i) /\ (i < (2 ^ N)))

;; 2-aux.watsup:47.1-47.63
def invsigned : (nat, int) -> nat
  ;; 2-aux.watsup:48.1-48.56
  def {N : nat, i : nat, j : nat} invsigned(N, (i <: int)) = j
    -- if ($signed(N, j) = (i <: int))

;; 2-aux.watsup:55.1-55.33
def memop0 : memop
  ;; 2-aux.watsup:56.1-56.34
  def memop0 = {ALIGN 0, OFFSET 0}

;; 2-aux.watsup:61.1-61.68
def free_dataidx_instr : instr -> dataidx*
  ;; 2-aux.watsup:62.1-62.43
  def {x : idx} free_dataidx_instr(MEMORY.INIT_instr(x)) = [x]
  ;; 2-aux.watsup:63.1-63.41
  def {x : idx} free_dataidx_instr(DATA.DROP_instr(x)) = [x]
  ;; 2-aux.watsup:64.1-64.38
  def {in : instr} free_dataidx_instr(in) = []

;; 2-aux.watsup:66.1-66.70
rec {

;; 2-aux.watsup:66.1-66.70
def free_dataidx_instrs : instr* -> dataidx*
  ;; 2-aux.watsup:67.1-67.44
  def free_dataidx_instrs([]) = []
  ;; 2-aux.watsup:68.1-68.99
  def {instr : instr, instr'* : instr*} free_dataidx_instrs([instr] :: instr'*{instr'}) = $free_dataidx_instr(instr) :: $free_dataidx_instrs(instr'*{instr'})
}

;; 2-aux.watsup:70.1-70.66
def free_dataidx_expr : expr -> dataidx*
  ;; 2-aux.watsup:71.1-71.56
  def {in* : instr*} free_dataidx_expr(in*{in}) = $free_dataidx_instrs(in*{in})

;; 2-aux.watsup:73.1-73.66
def free_dataidx_func : func -> dataidx*
  ;; 2-aux.watsup:74.1-74.62
  def {e : expr, loc* : local*, x : idx} free_dataidx_func(`FUNC%%*%`(x, loc*{loc}, e)) = $free_dataidx_expr(e)

;; 2-aux.watsup:76.1-76.68
rec {

;; 2-aux.watsup:76.1-76.68
def free_dataidx_funcs : func* -> dataidx*
  ;; 2-aux.watsup:77.1-77.43
  def free_dataidx_funcs([]) = []
  ;; 2-aux.watsup:78.1-78.92
  def {func : func, func'* : func*} free_dataidx_funcs([func] :: func'*{func'}) = $free_dataidx_func(func) :: $free_dataidx_funcs(func'*{func'})
}

;; 2-aux.watsup:86.1-86.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:87.1-87.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:89.1-89.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:90.1-90.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:92.1-101.43
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

;; 3-typing.watsup:5.1-8.60
syntax context = {TYPE functype*, FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:18.1-18.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:26.1-28.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%]`(n_1, n_2), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:19.1-19.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:30.1-31.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:20.1-20.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:33.1-34.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:21.1-21.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:36.1-38.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:22.1-22.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:40.1-42.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:23.1-23.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:45.1-47.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:49.1-51.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:53.1-55.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:57.1-59.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:69.1-69.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:72.1-73.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:75.1-76.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:70.1-70.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:78.1-80.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:85.1-85.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:93.1-96.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%]`(n_11, n_12), `[%..%]`(n_21, n_22))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:86.1-86.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:98.1-99.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:87.1-87.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:101.1-102.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:88.1-88.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:104.1-106.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:89.1-89.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:108.1-110.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:90.1-90.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:113.1-115.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:117.1-119.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:121.1-123.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:125.1-127.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:192.1-192.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:194.1-195.44
  rule void {C : context}:
    `%|-%:%`(C, _RESULT_blocktype(?()), `%->%`([], []))

  ;; 3-typing.watsup:197.1-198.32
  rule result {C : context, t : valtype}:
    `%|-%:%`(C, _RESULT_blocktype(?(t)), `%->%`([], [t]))

  ;; 3-typing.watsup:200.1-202.23
  rule typeidx {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, _IDX_blocktype(x), ft)
    -- if (C.TYPE_context[x] = ft)

;; 3-typing.watsup:135.1-136.67
rec {

;; 3-typing.watsup:135.1-135.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:171.1-172.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:174.1-175.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:177.1-178.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:181.1-182.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?([t])), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:184.1-187.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = $valtype_numtype(numtype)) \/ (t' = $valtype_vectype(vectype)))

  ;; 3-typing.watsup:205.1-208.59
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:210.1-213.59
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1*{t_1}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:215.1-219.61
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:224.1-226.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:228.1-230.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:232.1-235.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:240.1-242.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 3-typing.watsup:244.1-246.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (C.FUNC_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:248.1-251.33
  rule call_indirect {C : context, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, y), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (C.TYPE_context[y] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:256.1-257.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:259.1-260.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:262.1-263.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:265.1-266.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([$valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-269.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:272.1-274.23
  rule extend {C : context, n : n, nt : numtype, o0 : nat}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (n <= o0)

  ;; 3-typing.watsup:276.1-279.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([$valtype_numtype(nt_2)], [$valtype_numtype(nt_1)]))
    -- if ($size($valtype_numtype(nt_1)) = ?(o0))
    -- if ($size($valtype_numtype(nt_2)) = ?(o1))
    -- if (nt_1 =/= nt_2)
    -- if (o0 = o1)

  ;; 3-typing.watsup:281.1-284.54
  rule convert-i {C : context, inn_1 : inn, inn_2 : inn, sx? : sx?, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr($numtype_inn(inn_1), CONVERT_cvtop, $numtype_inn(inn_2), sx?{sx}), `%->%`([$valtype_inn(inn_2)], [$valtype_inn(inn_1)]))
    -- if ($size($valtype_inn(inn_1)) = ?(o0))
    -- if ($size($valtype_inn(inn_2)) = ?(o1))
    -- if (inn_1 =/= inn_2)
    -- if ((sx?{sx} = ?()) <=> (o0 > o1))

  ;; 3-typing.watsup:286.1-288.24
  rule convert-f {C : context, fnn_1 : fnn, fnn_2 : fnn}:
    `%|-%:%`(C, CVTOP_instr($numtype_fnn(fnn_1), CONVERT_cvtop, $numtype_fnn(fnn_2), ?()), `%->%`([$valtype_fnn(fnn_2)], [$valtype_fnn(fnn_1)]))
    -- if (fnn_1 =/= fnn_2)

  ;; 3-typing.watsup:293.1-294.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [$valtype_reftype(rt)]))

  ;; 3-typing.watsup:296.1-298.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:300.1-301.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([$valtype_reftype(rt)], [I32_valtype]))

  ;; 3-typing.watsup:306.1-308.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:310.1-312.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:314.1-316.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:321.1-323.28
  rule global.get {C : context, mut : mut, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `%%`(mut, t))

  ;; 3-typing.watsup:325.1-327.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?(())), t))

  ;; 3-typing.watsup:332.1-334.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [$valtype_reftype(rt)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:336.1-338.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype $valtype_reftype(rt)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:340.1-342.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:344.1-346.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([$valtype_reftype(rt) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:348.1-350.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype $valtype_reftype(rt) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:352.1-355.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:357.1-360.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:362.1-364.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:369.1-371.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:373.1-375.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:377.1-379.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:381.1-383.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:385.1-388.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:390.1-392.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:394.1-399.33
  rule load {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [$valtype_numtype(nt)]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- (if ($size($valtype_numtype(nt)) = ?(o1)))?{o1}
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_inn(inn)))

  ;; 3-typing.watsup:401.1-406.33
  rule store {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype $valtype_numtype(nt)], []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- (if ($size($valtype_numtype(nt)) = ?(o1)))?{o1}
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_inn(inn)))

;; 3-typing.watsup:136.1-136.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:149.1-150.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:152.1-155.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:157.1-162.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:164.1-166.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:137.1-137.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:142.1-144.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:413.1-413.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:417.1-418.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:420.1-421.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:423.1-424.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:426.1-428.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?()), t))

;; 3-typing.watsup:414.1-414.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:431.1-432.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:415.1-415.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:435.1-438.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:445.1-445.73
relation Type_ok: `|-%:%`(type, functype)
  ;; 3-typing.watsup:459.1-461.29
  rule _ {ft : functype}:
    `|-%:%`(TYPE(ft), ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:446.1-446.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:463.1-467.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, `FUNC%%*%`(x, LOCAL(t)*{t}, expr), ft)
    -- if (C.TYPE_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:447.1-447.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:469.1-473.40
  rule _ {C : context, expr : expr, gt : globaltype, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `%%`(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:448.1-448.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:475.1-477.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:449.1-449.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:479.1-481.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:452.1-452.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:492.1-495.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:497.1-498.20
  rule passive {C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; 3-typing.watsup:500.1-501.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:450.1-450.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:483.1-486.37
  rule _ {C : context, elemmode : elemmode, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%`(rt, expr*{expr}, elemmode), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [$valtype_reftype(rt)]))*{expr}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, rt)

;; 3-typing.watsup:453.1-453.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:503.1-506.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, ACTIVE_datamode(0, expr))
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:508.1-509.20
  rule passive {C : context}:
    `%|-%:OK`(C, PASSIVE_datamode)

;; 3-typing.watsup:451.1-451.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:488.1-490.37
  rule _ {C : context, b* : byte*, datamode : datamode}:
    `%|-%:OK`(C, `DATA%*%`(b*{b}, datamode))
    -- Datamode_ok: `%|-%:OK`(C, datamode)

;; 3-typing.watsup:454.1-454.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:511.1-513.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:518.1-518.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:522.1-524.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:520.1-520.83
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; 3-typing.watsup:531.1-533.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype(ft))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:535.1-537.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:539.1-541.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:543.1-545.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (C.MEM_context[x] = mt)

;; 3-typing.watsup:519.1-519.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:526.1-528.39
  rule _ {C : context, externidx : externidx, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externidx), xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 3-typing.watsup:550.1-550.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:552.1-567.20
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, ft'* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*, type* : type*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (C = {TYPE ft'*{ft'}, FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Type_ok: `|-%:%`(type, ft'))*{ft' type}
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

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

;; 4-runtime.watsup:30.1-31.28
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:32.1-33.71
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:34.1-35.14
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:37.1-38.22
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:47.1-48.70
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:55.1-55.44
def default_ : valtype -> val?
  ;; 4-runtime.watsup:56.1-56.35
  def default_(I32_valtype) = ?(CONST_val(I32_numtype, 0))
  ;; 4-runtime.watsup:57.1-57.35
  def default_(I64_valtype) = ?(CONST_val(I64_numtype, 0))
  ;; 4-runtime.watsup:58.1-58.35
  def default_(F32_valtype) = ?(CONST_val(F32_numtype, 0))
  ;; 4-runtime.watsup:59.1-59.35
  def default_(F64_valtype) = ?(CONST_val(F64_numtype, 0))
  ;; 4-runtime.watsup:60.1-60.44
  def default_(FUNCREF_valtype) = ?(REF.NULL_val(FUNCREF_reftype))
  ;; 4-runtime.watsup:61.1-61.48
  def default_(EXTERNREF_valtype) = ?(REF.NULL_val(EXTERNREF_reftype))
  def {x : valtype} default_(x) = ?()

;; 4-runtime.watsup:88.1-90.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:92.1-100.25
syntax moduleinst = {TYPE functype*, FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:70.1-73.16
syntax funcinst = {TYPE functype, MODULE moduleinst, CODE func}

;; 4-runtime.watsup:74.1-76.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:77.1-79.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:80.1-82.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:83.1-85.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:86.1-87.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:114.1-120.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:122.1-124.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:126.1-126.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:213.1-220.9
rec {

;; 4-runtime.watsup:213.1-220.9
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | CALL_ADDR(funcaddr)
  | LABEL_(n, instr*, admininstr*)
  | FRAME_(n, frame, admininstr*)
  | TRAP
}

def admininstr_instr : instr -> admininstr
  def admininstr_instr(UNREACHABLE_instr) = UNREACHABLE_admininstr
  def admininstr_instr(NOP_instr) = NOP_admininstr
  def admininstr_instr(DROP_instr) = DROP_admininstr
  def {x : valtype*?} admininstr_instr(SELECT_instr(x)) = SELECT_admininstr(x)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(BLOCK_instr(x0, x1)) = BLOCK_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(LOOP_instr(x0, x1)) = LOOP_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*, x2 : instr*} admininstr_instr(IF_instr(x0, x1, x2)) = IF_admininstr(x0, x1, x2)
  def {x : labelidx} admininstr_instr(BR_instr(x)) = BR_admininstr(x)
  def {x : labelidx} admininstr_instr(BR_IF_instr(x)) = BR_IF_admininstr(x)
  def {x0 : labelidx*, x1 : labelidx} admininstr_instr(BR_TABLE_instr(x0, x1)) = BR_TABLE_admininstr(x0, x1)
  def {x : funcidx} admininstr_instr(CALL_instr(x)) = CALL_admininstr(x)
  def {x0 : tableidx, x1 : typeidx} admininstr_instr(CALL_INDIRECT_instr(x0, x1)) = CALL_INDIRECT_admininstr(x0, x1)
  def admininstr_instr(RETURN_instr) = RETURN_admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_instr(CONST_instr(x0, x1)) = CONST_admininstr(x0, x1)
  def {x0 : numtype, x1 : unop_numtype} admininstr_instr(UNOP_instr(x0, x1)) = UNOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : binop_numtype} admininstr_instr(BINOP_instr(x0, x1)) = BINOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : testop_numtype} admininstr_instr(TESTOP_instr(x0, x1)) = TESTOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : relop_numtype} admininstr_instr(RELOP_instr(x0, x1)) = RELOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : n} admininstr_instr(EXTEND_instr(x0, x1)) = EXTEND_admininstr(x0, x1)
  def {x0 : numtype, x1 : cvtop, x2 : numtype, x3 : sx?} admininstr_instr(CVTOP_instr(x0, x1, x2, x3)) = CVTOP_admininstr(x0, x1, x2, x3)
  def {x : reftype} admininstr_instr(REF.NULL_instr(x)) = REF.NULL_admininstr(x)
  def {x : funcidx} admininstr_instr(REF.FUNC_instr(x)) = REF.FUNC_admininstr(x)
  def admininstr_instr(REF.IS_NULL_instr) = REF.IS_NULL_admininstr
  def {x : localidx} admininstr_instr(LOCAL.GET_instr(x)) = LOCAL.GET_admininstr(x)
  def {x : localidx} admininstr_instr(LOCAL.SET_instr(x)) = LOCAL.SET_admininstr(x)
  def {x : localidx} admininstr_instr(LOCAL.TEE_instr(x)) = LOCAL.TEE_admininstr(x)
  def {x : globalidx} admininstr_instr(GLOBAL.GET_instr(x)) = GLOBAL.GET_admininstr(x)
  def {x : globalidx} admininstr_instr(GLOBAL.SET_instr(x)) = GLOBAL.SET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.GET_instr(x)) = TABLE.GET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.SET_instr(x)) = TABLE.SET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.SIZE_instr(x)) = TABLE.SIZE_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.GROW_instr(x)) = TABLE.GROW_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.FILL_instr(x)) = TABLE.FILL_admininstr(x)
  def {x0 : tableidx, x1 : tableidx} admininstr_instr(TABLE.COPY_instr(x0, x1)) = TABLE.COPY_admininstr(x0, x1)
  def {x0 : tableidx, x1 : elemidx} admininstr_instr(TABLE.INIT_instr(x0, x1)) = TABLE.INIT_admininstr(x0, x1)
  def {x : elemidx} admininstr_instr(ELEM.DROP_instr(x)) = ELEM.DROP_admininstr(x)
  def admininstr_instr(MEMORY.SIZE_instr) = MEMORY.SIZE_admininstr
  def admininstr_instr(MEMORY.GROW_instr) = MEMORY.GROW_admininstr
  def admininstr_instr(MEMORY.FILL_instr) = MEMORY.FILL_admininstr
  def admininstr_instr(MEMORY.COPY_instr) = MEMORY.COPY_admininstr
  def {x : dataidx} admininstr_instr(MEMORY.INIT_instr(x)) = MEMORY.INIT_admininstr(x)
  def {x : dataidx} admininstr_instr(DATA.DROP_instr(x)) = DATA.DROP_admininstr(x)
  def {x0 : numtype, x1 : (n, sx)?, x2 : memop} admininstr_instr(LOAD_instr(x0, x1, x2)) = LOAD_admininstr(x0, x1, x2)
  def {x0 : numtype, x1 : n?, x2 : memop} admininstr_instr(STORE_instr(x0, x1, x2)) = STORE_admininstr(x0, x1, x2)

def admininstr_ref : ref -> admininstr
  def {x : reftype} admininstr_ref(REF.NULL_ref(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_ref(REF.FUNC_ADDR_ref(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_ref(REF.HOST_ADDR_ref(x)) = REF.HOST_ADDR_admininstr(x)

def admininstr_val : val -> admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_val(CONST_val(x0, x1)) = CONST_admininstr(x0, x1)
  def {x : reftype} admininstr_val(REF.NULL_val(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_val(REF.FUNC_ADDR_val(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_val(REF.HOST_ADDR_val(x)) = REF.HOST_ADDR_admininstr(x)

;; 4-runtime.watsup:127.1-127.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:136.1-136.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:137.1-137.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:139.1-139.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:146.1-146.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:140.1-140.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:147.1-147.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:141.1-141.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:148.1-148.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:142.1-142.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:149.1-149.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:143.1-143.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:150.1-150.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:144.1-144.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:151.1-151.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:153.1-153.67
def type : (state, typeidx) -> functype
  ;; 4-runtime.watsup:162.1-162.40
  def {f : frame, s : store, x : idx} type(`%;%`(s, f), x) = f.MODULE_frame.TYPE_moduleinst[x]

;; 4-runtime.watsup:154.1-154.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:163.1-163.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:155.1-155.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:164.1-164.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:156.1-156.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:165.1-165.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:157.1-157.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:166.1-166.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:158.1-158.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:167.1-167.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:159.1-159.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:168.1-168.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:160.1-160.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:169.1-169.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:172.1-172.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:181.1-181.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:173.1-173.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:182.1-182.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:174.1-174.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:183.1-183.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:175.1-175.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:184.1-184.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:176.1-176.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:185.1-185.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:177.1-177.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:186.1-186.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:178.1-178.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:187.1-187.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:179.1-179.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:188.1-188.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:193.1-193.63
def grow_table : (tableinst, nat, ref) -> tableinst?
  ;; 4-runtime.watsup:196.1-200.36
  def {i : nat, i' : nat, j : nat, n : n, r : ref, r'* : ref*, rt : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ?(ti')
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%]`(i', j), rt), ELEM r'*{r'} :: r^n{}})
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)
  def {x : (tableinst, nat, ref)} grow_table(x) = ?()

;; 4-runtime.watsup:194.1-194.55
def grow_memory : (meminst, nat) -> meminst?
  ;; 4-runtime.watsup:202.1-206.34
  def {b* : byte*, i : nat, i' : nat, j : nat, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = ?(mi')
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%]`(i', j)), DATA b*{b} :: 0^((n * 64) * $Ki){}})
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)
  def {x : (meminst, nat)} grow_memory(x) = ?()

;; 4-runtime.watsup:222.1-225.25
rec {

;; 4-runtime.watsup:222.1-225.25
syntax E =
  | _HOLE
  | _SEQ(val*, E, instr*)
  | LABEL_(n, instr*, E)
}

;; 5-numerics.watsup:3.1-3.79
def unop : (unop_numtype, numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:4.1-4.80
def binop : (binop_numtype, numtype, c_numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:5.1-5.79
def testop : (testop_numtype, numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:6.1-6.80
def relop : (relop_numtype, numtype, c_numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:8.1-8.84
def ext : (nat, nat, sx, c_numtype) -> c_numtype

;; 5-numerics.watsup:9.1-9.84
def cvtop : (numtype, cvtop, numtype, sx?, c_numtype) -> c_numtype*

;; 5-numerics.watsup:11.1-11.32
def wrap_ : ((nat, nat), c_numtype) -> nat

;; 5-numerics.watsup:13.1-13.60
def ibytes : (nat, iN) -> byte*

;; 5-numerics.watsup:14.1-14.60
def fbytes : (nat, fN) -> byte*

;; 5-numerics.watsup:15.1-15.58
def ntbytes : (numtype, c_numtype) -> byte*

;; 5-numerics.watsup:17.1-17.30
def invibytes : (nat, byte*) -> iN
  ;; 5-numerics.watsup:20.1-20.52
  def {N : nat, b* : byte*, n : n} invibytes(N, b*{b}) = n
    -- if ($ibytes(N, n) = b*{b})

;; 5-numerics.watsup:18.1-18.30
def invfbytes : (nat, byte*) -> fN
  ;; 5-numerics.watsup:21.1-21.52
  def {N : nat, b* : byte*, p : fN} invfbytes(N, b*{b}) = p
    -- if ($fbytes(N, p) = b*{b})

;; 6-reduction.watsup:6.1-6.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:24.1-25.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:27.1-28.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:30.1-31.24
  rule drop {val : val}:
    `%*~>%*`([$admininstr_val(val) DROP_admininstr], [])

  ;; 6-reduction.watsup:34.1-36.16
  rule select-true {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [$admininstr_val(val_1)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:38.1-40.14
  rule select-false {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [$admininstr_val(val_2)])
    -- if (c = 0)

  ;; 6-reduction.watsup:58.1-60.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:62.1-64.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:67.1-68.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, $admininstr_val(val)*{val})], $admininstr_val(val)*{val})

  ;; 6-reduction.watsup:74.1-75.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [BR_admininstr(0)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val} :: $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:77.1-78.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val)*{val} :: [BR_admininstr(l + 1)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:81.1-83.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:85.1-87.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:90.1-92.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:94.1-96.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:121.1-122.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val)^n{val})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:124.1-125.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:127.1-128.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, $admininstr_val(val)*{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:133.1-135.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 6-reduction.watsup:137.1-139.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:142.1-144.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 6-reduction.watsup:146.1-148.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:151.1-153.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 6-reduction.watsup:155.1-157.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 6-reduction.watsup:160.1-161.70
  rule extend {c : c_numtype, n : n, nt : numtype, o0 : nat}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, o0, S_sx, c))])
    -- if ($size($valtype_numtype(nt)) = ?(o0))

  ;; 6-reduction.watsup:164.1-166.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [c])

  ;; 6-reduction.watsup:168.1-170.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:179.1-181.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(rt))

  ;; 6-reduction.watsup:183.1-185.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:196.1-197.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([$admininstr_val(val) LOCAL.TEE_admininstr(x)], [$admininstr_val(val) $admininstr_val(val) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:45.1-45.73
def blocktype : (state, blocktype) -> functype
  ;; 6-reduction.watsup:46.1-46.56
  def {z : state} blocktype(z, _RESULT_blocktype(?())) = `%->%`([], [])
  ;; 6-reduction.watsup:47.1-47.44
  def {t : valtype, z : state} blocktype(z, _RESULT_blocktype(?(t))) = `%->%`([], [t])
  ;; 6-reduction.watsup:48.1-48.40
  def {x : idx, z : state} blocktype(z, _IDX_blocktype(x)) = $type(z, x)

;; 6-reduction.watsup:7.1-7.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:50.1-52.43
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})]), [LABEL__admininstr(n, [], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:54.1-56.43
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [LOOP_admininstr(bt, instr*{instr})]), [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:101.1-102.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:104.1-108.35
  rule call_indirect-call {a : addr, i : nat, instr* : instr*, t* : valtype*, x : idx, y : idx, y' : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [CALL_ADDR_admininstr(a)])
    -- if ($table(z, x).ELEM_tableinst[i] = REF.FUNC_ADDR_ref(a))
    -- if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(y', LOCAL(t)*{t}, instr*{instr}))
    -- if ($type(z, y) = $type(z, y'))

  ;; 6-reduction.watsup:110.1-112.15
  rule call_indirect-trap {i : nat, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:114.1-118.53
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, mm : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, x : idx, z : state, o0* : val*}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], $admininstr_instr(instr)*{instr})])])
    -- (if ($default_(t) = ?(o0)))*{t o0}
    -- if ($funcinst(z)[a] = {TYPE `%->%`(t_1^k{t_1}, t_2^n{t_2}), MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, LOCAL(t)*{t}, instr*{instr}))
    -- if (f = {LOCAL val^k{val} :: o0*{o0}, MODULE mm})

  ;; 6-reduction.watsup:175.1-176.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:190.1-191.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [$admininstr_val($local(z, x))])

  ;; 6-reduction.watsup:202.1-203.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [$admininstr_val($global(z, x).VALUE_globalinst)])

  ;; 6-reduction.watsup:211.1-213.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:215.1-217.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [$admininstr_ref($table(z, x).ELEM_tableinst[i])])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:228.1-230.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 6-reduction.watsup:241.1-243.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:245.1-248.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:250.1-254.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:257.1-259.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:261.1-264.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:266.1-271.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:273.1-277.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:280.1-282.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:284.1-287.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:289.1-293.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) $admininstr_ref($elem(z, y).ELEM_eleminst[i]) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:302.1-304.59
  rule load-num-trap {i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [TRAP_admininstr])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (((i + mo.OFFSET_memop) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:306.1-308.71
  rule load-num-val {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [CONST_admininstr(nt, c)])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if ($ntbytes(nt, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (o0 / 8)])

  ;; 6-reduction.watsup:310.1-312.51
  rule load-pack-trap {i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:314.1-316.61
  rule load-pack-val {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [CONST_admininstr(nt, $ext(n, o0, sx, c))])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if ($ibytes(n, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])

  ;; 6-reduction.watsup:336.1-338.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:349.1-351.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:353.1-356.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:358.1-362.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:365.1-367.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:369.1-372.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:374.1-379.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:381.1-385.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:388.1-390.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:392.1-395.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:397.1-401.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- otherwise

;; 6-reduction.watsup:5.1-5.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:9.1-11.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_pure: `%*~>%*`($admininstr_instr(instr)*{instr}, $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:13.1-15.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, $admininstr_instr(instr)*{instr}), $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:193.1-194.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:205.1-206.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:219.1-221.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:223.1-225.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:233.1-235.47
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, x : idx, z : state, o0 : tableinst}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if ($grow_table($table(z, x), n, ref) = ?(o0))
    -- if (o0 = ti)

  ;; 6-reduction.watsup:237.1-238.80
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:296.1-297.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:319.1-321.59
  rule store-num-trap {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (((i + mo.OFFSET_memop) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:323.1-325.29
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), (o0 / 8), b*{b}), []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (b*{b} = $ntbytes(nt, c))

  ;; 6-reduction.watsup:327.1-329.51
  rule store-pack-trap {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:331.1-333.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), (n / 8), b*{b}), []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (b*{b} = $ibytes(n, $wrap_((o0, n), c)))

  ;; 6-reduction.watsup:341.1-343.41
  rule memory.grow-succeed {mi : meminst, n : n, z : state, o0 : meminst}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- if ($grow_memory($mem(z, 0), n) = ?(o0))
    -- if (o0 = mi)

  ;; 6-reduction.watsup:345.1-346.75
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:404.1-405.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:5.1-5.35
rec {

;; 7-module.watsup:5.1-5.35
def funcs : externval* -> funcaddr*
  ;; 7-module.watsup:6.1-6.30
  def funcs([]) = []
  ;; 7-module.watsup:7.1-7.59
  def {externval'* : externval*, fa : funcaddr} funcs([FUNC_externval(fa)] :: externval'*{externval'}) = [fa] :: $funcs(externval'*{externval'})
  ;; 7-module.watsup:8.1-9.15
  def {externval : externval, externval'* : externval*} funcs([externval] :: externval'*{externval'}) = $funcs(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:11.1-11.39
rec {

;; 7-module.watsup:11.1-11.39
def globals : externval* -> globaladdr*
  ;; 7-module.watsup:12.1-12.32
  def globals([]) = []
  ;; 7-module.watsup:13.1-13.65
  def {externval'* : externval*, ga : globaladdr} globals([GLOBAL_externval(ga)] :: externval'*{externval'}) = [ga] :: $globals(externval'*{externval'})
  ;; 7-module.watsup:14.1-15.15
  def {externval : externval, externval'* : externval*} globals([externval] :: externval'*{externval'}) = $globals(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:17.1-17.37
rec {

;; 7-module.watsup:17.1-17.37
def tables : externval* -> tableaddr*
  ;; 7-module.watsup:18.1-18.31
  def tables([]) = []
  ;; 7-module.watsup:19.1-19.62
  def {externval'* : externval*, ta : tableaddr} tables([TABLE_externval(ta)] :: externval'*{externval'}) = [ta] :: $tables(externval'*{externval'})
  ;; 7-module.watsup:20.1-21.15
  def {externval : externval, externval'* : externval*} tables([externval] :: externval'*{externval'}) = $tables(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:23.1-23.33
rec {

;; 7-module.watsup:23.1-23.33
def mems : externval* -> memaddr*
  ;; 7-module.watsup:24.1-24.29
  def mems([]) = []
  ;; 7-module.watsup:25.1-25.56
  def {externval'* : externval*, ma : memaddr} mems([MEM_externval(ma)] :: externval'*{externval'}) = [ma] :: $mems(externval'*{externval'})
  ;; 7-module.watsup:26.1-27.15
  def {externval : externval, externval'* : externval*} mems([externval] :: externval'*{externval'}) = $mems(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:36.1-36.60
def allocfunc : (store, moduleinst, func) -> (store, funcaddr)
  ;; 7-module.watsup:37.1-39.34
  def {expr : expr, fi : funcinst, func : func, local* : local*, mm : moduleinst, s : store, x : idx} allocfunc(s, mm, func) = (s[FUNC_store =.. [fi]], |s.FUNC_store|)
    -- if (fi = {TYPE mm.TYPE_moduleinst[x], MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, local*{local}, expr))

;; 7-module.watsup:41.1-41.63
rec {

;; 7-module.watsup:41.1-41.63
def allocfuncs : (store, moduleinst, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:42.1-42.47
  def {mm : moduleinst, s : store} allocfuncs(s, mm, []) = (s, [])
  ;; 7-module.watsup:43.1-45.51
  def {fa : funcaddr, fa'* : funcaddr*, func : func, func'* : func*, mm : moduleinst, s : store, s_1 : store, s_2 : store} allocfuncs(s, mm, [func] :: func'*{func'}) = (s_2, [fa] :: fa'*{fa'})
    -- if ((s_1, fa) = $allocfunc(s, mm, func))
    -- if ((s_2, fa'*{fa'}) = $allocfuncs(s_1, mm, func'*{func'}))
}

;; 7-module.watsup:47.1-47.63
def allocglobal : (store, globaltype, val) -> (store, globaladdr)
  ;; 7-module.watsup:48.1-49.44
  def {gi : globalinst, globaltype : globaltype, s : store, val : val} allocglobal(s, globaltype, val) = (s[GLOBAL_store =.. [gi]], |s.GLOBAL_store|)
    -- if (gi = {TYPE globaltype, VALUE val})

;; 7-module.watsup:51.1-51.67
rec {

;; 7-module.watsup:51.1-51.67
def allocglobals : (store, globaltype*, val*) -> (store, globaladdr*)
  ;; 7-module.watsup:52.1-52.54
  def {s : store} allocglobals(s, [], []) = (s, [])
  ;; 7-module.watsup:53.1-55.62
  def {ga : globaladdr, ga'* : globaladdr*, globaltype : globaltype, globaltype'* : globaltype*, s : store, s_1 : store, s_2 : store, val : val, val'* : val*} allocglobals(s, [globaltype] :: globaltype'*{globaltype'}, [val] :: val'*{val'}) = (s_2, [ga] :: ga'*{ga'})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga'}) = $allocglobals(s_1, globaltype'*{globaltype'}, val'*{val'}))
}

;; 7-module.watsup:57.1-57.55
def alloctable : (store, tabletype) -> (store, tableaddr)
  ;; 7-module.watsup:58.1-59.59
  def {i : nat, j : nat, rt : reftype, s : store, ti : tableinst} alloctable(s, `%%`(`[%..%]`(i, j), rt)) = (s[TABLE_store =.. [ti]], |s.TABLE_store|)
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM REF.NULL_ref(rt)^i{}})

;; 7-module.watsup:61.1-61.58
rec {

;; 7-module.watsup:61.1-61.58
def alloctables : (store, tabletype*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.44
  def {s : store} alloctables(s, []) = (s, [])
  ;; 7-module.watsup:63.1-65.53
  def {s : store, s_1 : store, s_2 : store, ta : tableaddr, ta'* : tableaddr*, tabletype : tabletype, tabletype'* : tabletype*} alloctables(s, [tabletype] :: tabletype'*{tabletype'}) = (s_2, [ta] :: ta'*{ta'})
    -- if ((s_1, ta) = $alloctable(s, tabletype))
    -- if ((s_2, ta'*{ta'}) = $alloctables(s_1, tabletype'*{tabletype'}))
}

;; 7-module.watsup:67.1-67.49
def allocmem : (store, memtype) -> (store, memaddr)
  ;; 7-module.watsup:68.1-69.62
  def {i : nat, j : nat, mi : meminst, s : store} allocmem(s, `%I8`(`[%..%]`(i, j))) = (s[MEM_store =.. [mi]], |s.MEM_store|)
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA 0^((i * 64) * $Ki){}})

;; 7-module.watsup:71.1-71.52
rec {

;; 7-module.watsup:71.1-71.52
def allocmems : (store, memtype*) -> (store, memaddr*)
  ;; 7-module.watsup:72.1-72.42
  def {s : store} allocmems(s, []) = (s, [])
  ;; 7-module.watsup:73.1-75.49
  def {ma : memaddr, ma'* : memaddr*, memtype : memtype, memtype'* : memtype*, s : store, s_1 : store, s_2 : store} allocmems(s, [memtype] :: memtype'*{memtype'}) = (s_2, [ma] :: ma'*{ma'})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma'}) = $allocmems(s_1, memtype'*{memtype'}))
}

;; 7-module.watsup:77.1-77.57
def allocelem : (store, reftype, ref*) -> (store, elemaddr)
  ;; 7-module.watsup:78.1-79.36
  def {ei : eleminst, ref* : ref*, rt : reftype, s : store} allocelem(s, rt, ref*{ref}) = (s[ELEM_store =.. [ei]], |s.ELEM_store|)
    -- if (ei = {TYPE rt, ELEM ref*{ref}})

;; 7-module.watsup:81.1-81.63
rec {

;; 7-module.watsup:81.1-81.63
def allocelems : (store, reftype*, ref**) -> (store, elemaddr*)
  ;; 7-module.watsup:82.1-82.52
  def {s : store} allocelems(s, [], []) = (s, [])
  ;; 7-module.watsup:83.1-85.55
  def {ea : elemaddr, ea'* : elemaddr*, ref* : ref*, ref'** : ref**, rt : reftype, rt'* : reftype*, s : store, s_1 : store, s_2 : store} allocelems(s, [rt] :: rt'*{rt'}, [ref*{ref}] :: ref'*{ref'}*{ref'}) = (s_2, [ea] :: ea'*{ea'})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref}))
    -- if ((s_2, ea'*{ea'}) = $allocelems(s_2, rt'*{rt'}, ref'*{ref'}*{ref'}))
}

;; 7-module.watsup:87.1-87.49
def allocdata : (store, byte*) -> (store, dataaddr)
  ;; 7-module.watsup:88.1-89.28
  def {byte* : byte*, di : datainst, s : store} allocdata(s, byte*{byte}) = (s[DATA_store =.. [di]], |s.DATA_store|)
    -- if (di = {DATA byte*{byte}})

;; 7-module.watsup:91.1-91.54
rec {

;; 7-module.watsup:91.1-91.54
def allocdatas : (store, byte**) -> (store, dataaddr*)
  ;; 7-module.watsup:92.1-92.43
  def {s : store} allocdatas(s, []) = (s, [])
  ;; 7-module.watsup:93.1-95.50
  def {byte* : byte*, byte'** : byte**, da : dataaddr, da'* : dataaddr*, s : store, s_1 : store, s_2 : store} allocdatas(s, [byte]*{byte} :: byte'*{byte'}*{byte'}) = (s_2, [da] :: da'*{da'})
    -- if ((s_1, da) = $allocdata(s, byte*{byte}))
    -- if ((s_2, da'*{da'}) = $allocdatas(s_1, byte'*{byte'}*{byte'}))
}

;; 7-module.watsup:100.1-100.83
def instexport : (funcaddr*, globaladdr*, tableaddr*, memaddr*, export) -> exportinst
  ;; 7-module.watsup:101.1-101.95
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, FUNC_externidx(x))) = {NAME name, VALUE FUNC_externval(fa*{fa}[x])}
  ;; 7-module.watsup:102.1-102.99
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, GLOBAL_externidx(x))) = {NAME name, VALUE GLOBAL_externval(ga*{ga}[x])}
  ;; 7-module.watsup:103.1-103.97
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, TABLE_externidx(x))) = {NAME name, VALUE TABLE_externval(ta*{ta}[x])}
  ;; 7-module.watsup:104.1-104.93
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, MEM_externidx(x))) = {NAME name, VALUE MEM_externval(ma*{ma}[x])}

;; 7-module.watsup:107.1-107.81
def allocmodule : (store, module, externval*, val*, ref**) -> (store, moduleinst)
  ;; 7-module.watsup:108.1-147.54
  def {byte*^n_data : byte*^n_data, da* : dataaddr*, datamode^n_data : datamode^n_data, ea* : elemaddr*, elemmode^n_elem : elemmode^n_elem, export* : export*, expr_1^n_global : expr^n_global, expr_2*^n_elem : expr*^n_elem, externval* : externval*, fa* : funcaddr*, fa_ex* : funcaddr*, ft : functype, func^n_func : func^n_func, ga* : globaladdr*, ga_ex* : globaladdr*, globaltype^n_global : globaltype^n_global, i_data^n_data : nat^n_data, i_elem^n_elem : nat^n_elem, i_func^n_func : nat^n_func, i_global^n_global : nat^n_global, i_mem^n_mem : nat^n_mem, i_table^n_table : nat^n_table, import* : import*, ma* : memaddr*, ma_ex* : memaddr*, memtype^n_mem : memtype^n_mem, mm : moduleinst, module : module, n_data : n, n_elem : n, n_func : n, n_global : n, n_mem : n, n_table : n, ref** : ref**, rt^n_elem : reftype^n_elem, s : store, s_1 : store, s_2 : store, s_3 : store, s_4 : store, s_5 : store, s_6 : store, start? : start?, ta* : tableaddr*, ta_ex* : tableaddr*, tabletype^n_table : tabletype^n_table, val* : val*, xi* : exportinst*} allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}) = (s_6, mm)
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(TYPE(ft)*{}, import*{import}, func^n_func{func}, GLOBAL(globaltype, expr_1)^n_global{expr_1 globaltype}, TABLE(tabletype)^n_table{tabletype}, MEMORY(memtype)^n_mem{memtype}, `ELEM%%*%`(rt, expr_2*{expr_2}, elemmode)^n_elem{elemmode expr_2 rt}, `DATA%*%`(byte*{byte}, datamode)^n_data{byte datamode}, start?{start}, export*{export}))
    -- if (fa_ex*{fa_ex} = $funcs(externval*{externval}))
    -- if (ga_ex*{ga_ex} = $globals(externval*{externval}))
    -- if (ta_ex*{ta_ex} = $tables(externval*{externval}))
    -- if (ma_ex*{ma_ex} = $mems(externval*{externval}))
    -- if (fa*{fa} = (|s.FUNC_store| + i_func)^(i_func<n_func){i_func})
    -- if (ga*{ga} = (|s.GLOBAL_store| + i_global)^(i_global<n_global){i_global})
    -- if (ta*{ta} = (|s.TABLE_store| + i_table)^(i_table<n_table){i_table})
    -- if (ma*{ma} = (|s.MEM_store| + i_mem)^(i_mem<n_mem){i_mem})
    -- if (ea*{ea} = (|s.ELEM_store| + i_elem)^(i_elem<n_elem){i_elem})
    -- if (da*{da} = (|s.DATA_store| + i_data)^(i_data<n_data){i_data})
    -- if (xi*{xi} = $instexport(fa_ex*{fa_ex} :: fa*{fa}, ga_ex*{ga_ex} :: ga*{ga}, ta_ex*{ta_ex} :: ta*{ta}, ma_ex*{ma_ex} :: ma*{ma}, export)*{export})
    -- if (mm = {TYPE [ft], FUNC fa_ex*{fa_ex} :: fa*{fa}, GLOBAL ga_ex*{ga_ex} :: ga*{ga}, TABLE ta_ex*{ta_ex} :: ta*{ta}, MEM ma_ex*{ma_ex} :: ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT xi*{xi}})
    -- if ((s_1, fa*{fa}) = $allocfuncs(s, mm, func^n_func{func}))
    -- if ((s_2, ga*{ga}) = $allocglobals(s_1, globaltype^n_global{globaltype}, val*{val}))
    -- if ((s_3, ta*{ta}) = $alloctables(s_2, tabletype^n_table{tabletype}))
    -- if ((s_4, ma*{ma}) = $allocmems(s_3, memtype^n_mem{memtype}))
    -- if ((s_5, ea*{ea}) = $allocelems(s_4, rt^n_elem{rt}, ref*{ref}*{ref}))
    -- if ((s_6, da*{da}) = $allocdatas(s_5, byte*{byte}^n_data{byte}))

;; 7-module.watsup:154.1-154.36
rec {

;; 7-module.watsup:154.1-154.36
def concat_instr : instr** -> instr*
  ;; 7-module.watsup:155.1-155.37
  def concat_instr([]) = []
  ;; 7-module.watsup:156.1-156.68
  def {instr* : instr*, instr'** : instr**} concat_instr([instr]*{instr} :: instr'*{instr'}*{instr'}) = instr*{instr} :: $concat_instr(instr'*{instr'}*{instr'})
}

;; 7-module.watsup:158.1-158.33
def runelem : (elem, idx) -> instr*
  ;; 7-module.watsup:159.1-159.56
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, PASSIVE_elemmode), i) = []
  ;; 7-module.watsup:160.1-160.62
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, DECLARE_elemmode), i) = [ELEM.DROP_instr(i)]
  ;; 7-module.watsup:161.1-163.20
  def {expr* : expr*, i : nat, instr* : instr*, n : n, reftype : reftype, x : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, ACTIVE_elemmode(x, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) TABLE.INIT_instr(x, i) ELEM.DROP_instr(i)]
    -- if (n = |expr*{expr}|)

;; 7-module.watsup:165.1-165.33
def rundata : (data, idx) -> instr*
  ;; 7-module.watsup:166.1-166.48
  def {byte* : byte*, i : nat} rundata(`DATA%*%`(byte*{byte}, PASSIVE_datamode), i) = []
  ;; 7-module.watsup:167.1-169.20
  def {byte* : byte*, i : nat, instr* : instr*, n : n} rundata(`DATA%*%`(byte*{byte}, ACTIVE_datamode(0, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) MEMORY.INIT_instr(i) DATA.DROP_instr(i)]
    -- if (n = |byte*{byte}|)

;; 7-module.watsup:171.1-171.53
def instantiate : (store, module, externval*) -> config
  ;; 7-module.watsup:172.1-196.28
  def {data* : data*, elem* : elem*, elemmode* : elemmode*, export* : export*, externval* : externval*, f : frame, f_init : frame, func* : func*, functype* : functype*, global* : global*, globaltype* : globaltype*, i^n_elem : nat^n_elem, import* : import*, instr_1** : instr**, instr_2*** : instr***, instr_data* : instr*, instr_elem* : instr*, j^n_data : nat^n_data, mem* : mem*, mm : moduleinst, mm_init : moduleinst, module : module, n_data : n, n_elem : n, ref** : ref**, reftype* : reftype*, s : store, s' : store, start? : start?, table* : table*, type* : type*, val* : val*, x? : idx?} instantiate(s, module, externval*{externval}) = `%;%*`(`%;%`(s', f), $admininstr_instr(instr_elem)*{instr_elem} :: $admininstr_instr(instr_data)*{instr_data} :: CALL_admininstr(x)?{x})
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (type*{type} = TYPE(functype)*{functype})
    -- if (global*{global} = GLOBAL(globaltype, instr_1*{instr_1})*{globaltype instr_1})
    -- if (elem*{elem} = `ELEM%%*%`(reftype, instr_2*{instr_2}*{instr_2}, elemmode)*{elemmode instr_2 reftype})
    -- if (mm_init = {TYPE functype*{functype}, FUNC $funcs(externval*{externval}), GLOBAL $globals(externval*{externval}), TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f_init = {LOCAL [], MODULE mm_init})
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), $admininstr_instr(instr_1)*{instr_1}), [$admininstr_val(val)]))*{instr_1 val}
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), $admininstr_instr(instr_2)*{instr_2}), [$admininstr_ref(ref)]))*{instr_2 ref}*{instr_2 ref}
    -- if ((s', mm) = $allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}))
    -- if (f = {LOCAL [], MODULE mm})
    -- if (n_elem = |elem*{elem}|)
    -- if (instr_elem*{instr_elem} = $concat_instr($runelem(elem*{elem}[i], i)^(i<n_elem){i}))
    -- if (n_data = |data*{data}|)
    -- if (instr_data*{instr_data} = $concat_instr($rundata(data*{data}[j], j)^(j<n_data){j}))
    -- if (start?{start} = START(x)?{x})

;; 7-module.watsup:203.1-203.44
def invoke : (store, funcaddr, val*) -> config
  ;; 7-module.watsup:204.1-215.51
  def {f : frame, fa : funcaddr, mm : moduleinst, n : n, s : store, t_1^n : valtype^n, t_2* : valtype*, val^n : val^n} invoke(s, fa, val^n{val}) = `%;%*`(`%;%`(s, f), $admininstr_val(val)^n{val} :: [CALL_ADDR_admininstr(fa)])
    -- if (mm = {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE mm})
    -- if ($funcinst(`%;%`(s, f))[fa].TYPE_funcinst = `%->%`(t_1^n{t_1}, t_2*{t_2}))

;; A-binary.watsup:47.1-47.57
rec {

;; A-binary.watsup:47.1-47.57
def concat_bytes : byte** -> byte*
  ;; A-binary.watsup:48.1-48.37
  def concat_bytes([]) = []
  ;; A-binary.watsup:49.1-49.52
  def {b* : byte*, b'** : byte**} concat_bytes([b]*{b} :: b'*{b'}*{b'}) = b*{b} :: $concat_bytes(b'*{b'}*{b'})
}

;; A-binary.watsup:51.1-51.24
rec {

;; A-binary.watsup:51.1-51.24
def utf8 : name -> byte*
  ;; A-binary.watsup:52.1-52.44
  def {b : byte, c : c_numtype} utf8([c]) = [b]
    -- if ((c < 128) /\ (c = b))
  ;; A-binary.watsup:53.1-53.93
  def {b_1 : byte, b_2 : byte, c : c_numtype} utf8([c]) = [b_1 b_2]
    -- if (((128 <= c) /\ (c < 2048)) /\ (c = (((2 ^ 6) * (b_1 - 192)) + (b_2 - 128))))
  ;; A-binary.watsup:54.1-54.144
  def {b_1 : byte, b_2 : byte, b_3 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3]
    -- if ((((2048 <= c) /\ (c < 55296)) \/ ((57344 <= c) /\ (c < 65536))) /\ (c = ((((2 ^ 12) * (b_1 - 224)) + ((2 ^ 6) * (b_2 - 128))) + (b_3 - 128))))
  ;; A-binary.watsup:55.1-55.145
  def {b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3 b_4]
    -- if (((65536 <= c) /\ (c < 69632)) /\ (c = (((((2 ^ 18) * (b_1 - 240)) + ((2 ^ 12) * (b_2 - 128))) + ((2 ^ 6) * (b_3 - 128))) + (b_4 - 128))))
  ;; A-binary.watsup:56.1-56.41
  def {c* : c_numtype*} utf8(c*{c}) = $concat_bytes($utf8([c])*{c})
}

;; A-binary.watsup:577.1-577.60
rec {

;; A-binary.watsup:577.1-577.60
def concat_locals : local** -> local*
  ;; A-binary.watsup:578.1-578.38
  def concat_locals([]) = []
  ;; A-binary.watsup:579.1-579.62
  def {loc* : local*, loc'** : local**} concat_locals([loc]*{loc} :: loc'*{loc'}*{loc'}) = loc*{loc} :: $concat_locals(loc'*{loc'}*{loc'})
}

;; A-binary.watsup:582.1-582.29
syntax code = (local*, expr)

== IL Validation after pass the-elimination...
== Running pass wildcards...

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:4.1-4.15
syntax m = nat

;; 1-syntax.watsup:18.1-18.50
syntax byte = nat

;; 1-syntax.watsup:21.1-21.58
syntax uN = nat

;; 1-syntax.watsup:22.1-22.87
syntax sN = nat

;; 1-syntax.watsup:23.1-23.36
syntax iN = uN

;; 1-syntax.watsup:26.1-26.58
syntax u32 = nat

;; 1-syntax.watsup:27.1-27.58
syntax u64 = nat

;; 1-syntax.watsup:28.1-28.61
syntax u128 = nat

;; 1-syntax.watsup:29.1-29.69
syntax s33 = nat

;; 1-syntax.watsup:34.1-34.21
def signif : nat -> nat
  ;; 1-syntax.watsup:35.1-35.21
  def signif(32) = 23
  ;; 1-syntax.watsup:36.1-36.21
  def signif(64) = 52

;; 1-syntax.watsup:38.1-38.20
def expon : nat -> nat
  ;; 1-syntax.watsup:39.1-39.19
  def expon(32) = 8
  ;; 1-syntax.watsup:40.1-40.20
  def expon(64) = 11

;; 1-syntax.watsup:42.1-42.35
def M : nat -> nat
  ;; 1-syntax.watsup:43.1-43.23
  def {N : nat} M(N) = $signif(N)

;; 1-syntax.watsup:45.1-45.35
def E : nat -> nat
  ;; 1-syntax.watsup:46.1-46.22
  def {N : nat} E(N) = $expon(N)

;; 1-syntax.watsup:51.1-55.81
syntax fNmag =
  |  {N : nat, n : n}NORM(m, n)
    -- if (((2 - (2 ^ ($E(N) - 1))) <= n) /\ (n <= ((2 ^ ($E(N) - 1)) - 1)))
  |  {N : nat, n : n}SUBNORM(m, n)
    -- if ((2 - (2 ^ ($E(N) - 1))) = n)
  | INF
  |  {N : nat, n : n}NAN(n)
    -- if ((1 <= n) /\ (n < $M(N)))

;; 1-syntax.watsup:49.1-49.107
syntax fN =
  | POS(fNmag)
  | NEG(fNmag)

;; 1-syntax.watsup:58.1-58.35
def fNzero : fN
  ;; 1-syntax.watsup:59.1-59.29
  def fNzero = POS_fN(NORM_fNmag(0, 0))

;; 1-syntax.watsup:62.1-62.51
syntax f32 = fN

;; 1-syntax.watsup:63.1-63.51
syntax f64 = fN

;; 1-syntax.watsup:71.1-71.85
syntax char = nat

;; 1-syntax.watsup:73.1-73.38
syntax name = char*

;; 1-syntax.watsup:80.1-80.36
syntax idx = u32

;; 1-syntax.watsup:81.1-81.45
syntax typeidx = idx

;; 1-syntax.watsup:82.1-82.49
syntax funcidx = idx

;; 1-syntax.watsup:83.1-83.49
syntax globalidx = idx

;; 1-syntax.watsup:84.1-84.47
syntax tableidx = idx

;; 1-syntax.watsup:85.1-85.46
syntax memidx = idx

;; 1-syntax.watsup:86.1-86.45
syntax elemidx = idx

;; 1-syntax.watsup:87.1-87.45
syntax dataidx = idx

;; 1-syntax.watsup:88.1-88.47
syntax labelidx = idx

;; 1-syntax.watsup:89.1-89.47
syntax localidx = idx

;; 1-syntax.watsup:98.1-99.26
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:100.1-101.9
syntax vectype =
  | V128

;; 1-syntax.watsup:102.1-103.24
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:104.1-105.38
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | FUNCREF
  | EXTERNREF
  | BOT

def valtype_numtype : numtype -> valtype
  def valtype_numtype(I32_numtype) = I32_valtype
  def valtype_numtype(I64_numtype) = I64_valtype
  def valtype_numtype(F32_numtype) = F32_valtype
  def valtype_numtype(F64_numtype) = F64_valtype

def valtype_reftype : reftype -> valtype
  def valtype_reftype(FUNCREF_reftype) = FUNCREF_valtype
  def valtype_reftype(EXTERNREF_reftype) = EXTERNREF_valtype

def valtype_vectype : vectype -> valtype
  def valtype_vectype(V128_vectype) = V128_valtype

;; 1-syntax.watsup:107.1-107.40
syntax inn =
  | I32
  | I64

def numtype_inn : inn -> numtype
  def numtype_inn(I32_inn) = I32_numtype
  def numtype_inn(I64_inn) = I64_numtype

def valtype_inn : inn -> valtype
  def valtype_inn(I32_inn) = I32_valtype
  def valtype_inn(I64_inn) = I64_valtype

;; 1-syntax.watsup:108.1-108.40
syntax fnn =
  | F32
  | F64

def numtype_fnn : fnn -> numtype
  def numtype_fnn(F32_fnn) = F32_numtype
  def numtype_fnn(F64_fnn) = F64_numtype

def valtype_fnn : fnn -> valtype
  def valtype_fnn(F32_fnn) = F32_valtype
  def valtype_fnn(F64_fnn) = F64_valtype

;; 1-syntax.watsup:115.1-116.11
syntax resulttype = valtype*

;; 1-syntax.watsup:118.1-118.18
syntax mut = `MUT%?`(()?)

;; 1-syntax.watsup:120.1-121.16
syntax limits = `[%..%]`(u32, u32)

;; 1-syntax.watsup:122.1-123.14
syntax globaltype = `%%`(mut, valtype)

;; 1-syntax.watsup:124.1-125.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:126.1-127.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:128.1-129.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:130.1-131.10
syntax elemtype = reftype

;; 1-syntax.watsup:132.1-133.5
syntax datatype = OK

;; 1-syntax.watsup:134.1-135.70
syntax externtype =
  | FUNC(functype)
  | GLOBAL(globaltype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:147.1-147.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:149.1-149.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:150.1-150.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:152.1-154.66
syntax binop_IXX =
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

;; 1-syntax.watsup:155.1-155.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:157.1-157.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:158.1-158.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:160.1-161.112
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:162.1-162.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:164.1-164.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:165.1-165.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:166.1-166.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:167.1-167.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:168.1-168.53
syntax cvtop =
  | CONVERT
  | REINTERPRET
  | CONVERT_SAT

;; 1-syntax.watsup:176.1-176.68
syntax memop = {ALIGN u32, OFFSET u32}

;; 1-syntax.watsup:184.1-184.23
syntax c_numtype = nat

;; 1-syntax.watsup:185.1-185.23
syntax c_vectype = nat

;; 1-syntax.watsup:188.1-190.17
syntax blocktype =
  | _RESULT(valtype?)
  | _IDX(funcidx)

;; 1-syntax.watsup:248.1-256.80
rec {

;; 1-syntax.watsup:248.1-256.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
}

;; 1-syntax.watsup:258.1-259.9
syntax expr = instr*

;; 1-syntax.watsup:269.1-269.61
syntax elemmode =
  | ACTIVE(tableidx, expr)
  | PASSIVE
  | DECLARE

;; 1-syntax.watsup:270.1-270.49
syntax datamode =
  | ACTIVE(memidx, expr)
  | PASSIVE

;; 1-syntax.watsup:272.1-273.16
syntax type = TYPE(functype)

;; 1-syntax.watsup:274.1-275.16
syntax local = LOCAL(valtype)

;; 1-syntax.watsup:276.1-277.27
syntax func = `FUNC%%*%`(typeidx, local*, expr)

;; 1-syntax.watsup:278.1-279.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:280.1-281.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:282.1-283.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:284.1-285.30
syntax elem = `ELEM%%*%`(reftype, expr*, elemmode)

;; 1-syntax.watsup:286.1-287.22
syntax data = `DATA%*%`(byte*, datamode)

;; 1-syntax.watsup:288.1-289.16
syntax start = START(funcidx)

;; 1-syntax.watsup:291.1-292.66
syntax externidx =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:293.1-294.24
syntax export = EXPORT(name, externidx)

;; 1-syntax.watsup:295.1-296.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:298.1-299.76
syntax module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*, import*, func*, global*, table*, mem*, elem*, data*, start*, export*)

;; 2-aux.watsup:7.1-7.14
def Ki : nat
  ;; 2-aux.watsup:8.1-8.15
  def Ki = 1024

;; 2-aux.watsup:13.1-13.25
rec {

;; 2-aux.watsup:13.1-13.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:14.1-14.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:15.1-15.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:16.1-16.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:18.1-18.21
rec {

;; 2-aux.watsup:18.1-18.21
def sum : nat* -> nat
  ;; 2-aux.watsup:19.1-19.22
  def sum([]) = 0
  ;; 2-aux.watsup:20.1-20.35
  def {n : n, n'* : n*} sum([n] :: n'*{n'}) = (n + $sum(n'*{n'}))
}

;; 2-aux.watsup:31.1-31.55
def size : valtype -> nat?
  ;; 2-aux.watsup:32.1-32.20
  def size(I32_valtype) = ?(32)
  ;; 2-aux.watsup:33.1-33.20
  def size(I64_valtype) = ?(64)
  ;; 2-aux.watsup:34.1-34.20
  def size(F32_valtype) = ?(32)
  ;; 2-aux.watsup:35.1-35.20
  def size(F64_valtype) = ?(64)
  ;; 2-aux.watsup:36.1-36.22
  def size(V128_valtype) = ?(128)
  def {x : valtype} size(x) = ?()

;; 2-aux.watsup:43.1-43.57
def signed : (nat, nat) -> int
  ;; 2-aux.watsup:44.1-44.54
  def {N : nat, i : nat} signed(N, i) = (i <: int)
    -- if (0 <= (2 ^ (N - 1)))
  ;; 2-aux.watsup:45.1-45.60
  def {N : nat, i : nat} signed(N, i) = ((i - (2 ^ N)) <: int)
    -- if (((2 ^ (N - 1)) <= i) /\ (i < (2 ^ N)))

;; 2-aux.watsup:47.1-47.63
def invsigned : (nat, int) -> nat
  ;; 2-aux.watsup:48.1-48.56
  def {N : nat, i : nat, j : nat} invsigned(N, (i <: int)) = j
    -- if ($signed(N, j) = (i <: int))

;; 2-aux.watsup:55.1-55.33
def memop0 : memop
  ;; 2-aux.watsup:56.1-56.34
  def memop0 = {ALIGN 0, OFFSET 0}

;; 2-aux.watsup:61.1-61.68
def free_dataidx_instr : instr -> dataidx*
  ;; 2-aux.watsup:62.1-62.43
  def {x : idx} free_dataidx_instr(MEMORY.INIT_instr(x)) = [x]
  ;; 2-aux.watsup:63.1-63.41
  def {x : idx} free_dataidx_instr(DATA.DROP_instr(x)) = [x]
  ;; 2-aux.watsup:64.1-64.38
  def {in : instr} free_dataidx_instr(in) = []

;; 2-aux.watsup:66.1-66.70
rec {

;; 2-aux.watsup:66.1-66.70
def free_dataidx_instrs : instr* -> dataidx*
  ;; 2-aux.watsup:67.1-67.44
  def free_dataidx_instrs([]) = []
  ;; 2-aux.watsup:68.1-68.99
  def {instr : instr, instr'* : instr*} free_dataidx_instrs([instr] :: instr'*{instr'}) = $free_dataidx_instr(instr) :: $free_dataidx_instrs(instr'*{instr'})
}

;; 2-aux.watsup:70.1-70.66
def free_dataidx_expr : expr -> dataidx*
  ;; 2-aux.watsup:71.1-71.56
  def {in* : instr*} free_dataidx_expr(in*{in}) = $free_dataidx_instrs(in*{in})

;; 2-aux.watsup:73.1-73.66
def free_dataidx_func : func -> dataidx*
  ;; 2-aux.watsup:74.1-74.62
  def {e : expr, loc* : local*, x : idx} free_dataidx_func(`FUNC%%*%`(x, loc*{loc}, e)) = $free_dataidx_expr(e)

;; 2-aux.watsup:76.1-76.68
rec {

;; 2-aux.watsup:76.1-76.68
def free_dataidx_funcs : func* -> dataidx*
  ;; 2-aux.watsup:77.1-77.43
  def free_dataidx_funcs([]) = []
  ;; 2-aux.watsup:78.1-78.92
  def {func : func, func'* : func*} free_dataidx_funcs([func] :: func'*{func'}) = $free_dataidx_func(func) :: $free_dataidx_funcs(func'*{func'})
}

;; 2-aux.watsup:86.1-86.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:87.1-87.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:89.1-89.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:90.1-90.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:92.1-101.43
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

;; 3-typing.watsup:5.1-8.60
syntax context = {TYPE functype*, FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:18.1-18.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:26.1-28.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%]`(n_1, n_2), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:19.1-19.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:30.1-31.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:20.1-20.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:33.1-34.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:21.1-21.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:36.1-38.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:22.1-22.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:40.1-42.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:23.1-23.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:45.1-47.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:49.1-51.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:53.1-55.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:57.1-59.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:69.1-69.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:72.1-73.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:75.1-76.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:70.1-70.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:78.1-80.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:85.1-85.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:93.1-96.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%]`(n_11, n_12), `[%..%]`(n_21, n_22))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:86.1-86.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:98.1-99.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:87.1-87.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:101.1-102.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:88.1-88.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:104.1-106.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:89.1-89.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:108.1-110.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:90.1-90.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:113.1-115.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:117.1-119.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:121.1-123.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:125.1-127.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:192.1-192.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:194.1-195.44
  rule void {C : context}:
    `%|-%:%`(C, _RESULT_blocktype(?()), `%->%`([], []))

  ;; 3-typing.watsup:197.1-198.32
  rule result {C : context, t : valtype}:
    `%|-%:%`(C, _RESULT_blocktype(?(t)), `%->%`([], [t]))

  ;; 3-typing.watsup:200.1-202.23
  rule typeidx {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, _IDX_blocktype(x), ft)
    -- if (C.TYPE_context[x] = ft)

;; 3-typing.watsup:135.1-136.67
rec {

;; 3-typing.watsup:135.1-135.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:171.1-172.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:174.1-175.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:177.1-178.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:181.1-182.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?([t])), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:184.1-187.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = $valtype_numtype(numtype)) \/ (t' = $valtype_vectype(vectype)))

  ;; 3-typing.watsup:205.1-208.59
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:210.1-213.59
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1*{t_1}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:215.1-219.61
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:224.1-226.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:228.1-230.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:232.1-235.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:240.1-242.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 3-typing.watsup:244.1-246.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (C.FUNC_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:248.1-251.33
  rule call_indirect {C : context, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, y), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (C.TYPE_context[y] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:256.1-257.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:259.1-260.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:262.1-263.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:265.1-266.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([$valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-269.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:272.1-274.23
  rule extend {C : context, n : n, nt : numtype, o0 : nat}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (n <= o0)

  ;; 3-typing.watsup:276.1-279.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([$valtype_numtype(nt_2)], [$valtype_numtype(nt_1)]))
    -- if ($size($valtype_numtype(nt_1)) = ?(o0))
    -- if ($size($valtype_numtype(nt_2)) = ?(o1))
    -- if (nt_1 =/= nt_2)
    -- if (o0 = o1)

  ;; 3-typing.watsup:281.1-284.54
  rule convert-i {C : context, inn_1 : inn, inn_2 : inn, sx? : sx?, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr($numtype_inn(inn_1), CONVERT_cvtop, $numtype_inn(inn_2), sx?{sx}), `%->%`([$valtype_inn(inn_2)], [$valtype_inn(inn_1)]))
    -- if ($size($valtype_inn(inn_1)) = ?(o0))
    -- if ($size($valtype_inn(inn_2)) = ?(o1))
    -- if (inn_1 =/= inn_2)
    -- if ((sx?{sx} = ?()) <=> (o0 > o1))

  ;; 3-typing.watsup:286.1-288.24
  rule convert-f {C : context, fnn_1 : fnn, fnn_2 : fnn}:
    `%|-%:%`(C, CVTOP_instr($numtype_fnn(fnn_1), CONVERT_cvtop, $numtype_fnn(fnn_2), ?()), `%->%`([$valtype_fnn(fnn_2)], [$valtype_fnn(fnn_1)]))
    -- if (fnn_1 =/= fnn_2)

  ;; 3-typing.watsup:293.1-294.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [$valtype_reftype(rt)]))

  ;; 3-typing.watsup:296.1-298.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:300.1-301.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([$valtype_reftype(rt)], [I32_valtype]))

  ;; 3-typing.watsup:306.1-308.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:310.1-312.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:314.1-316.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:321.1-323.28
  rule global.get {C : context, mut : mut, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `%%`(mut, t))

  ;; 3-typing.watsup:325.1-327.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?(())), t))

  ;; 3-typing.watsup:332.1-334.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [$valtype_reftype(rt)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:336.1-338.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype $valtype_reftype(rt)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:340.1-342.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:344.1-346.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([$valtype_reftype(rt) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:348.1-350.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype $valtype_reftype(rt) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:352.1-355.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:357.1-360.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:362.1-364.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:369.1-371.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:373.1-375.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:377.1-379.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:381.1-383.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:385.1-388.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:390.1-392.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:394.1-399.33
  rule load {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [$valtype_numtype(nt)]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- (if ($size($valtype_numtype(nt)) = ?(o1)))?{o1}
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_inn(inn)))

  ;; 3-typing.watsup:401.1-406.33
  rule store {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype $valtype_numtype(nt)], []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- (if ($size($valtype_numtype(nt)) = ?(o1)))?{o1}
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_inn(inn)))

;; 3-typing.watsup:136.1-136.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:149.1-150.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:152.1-155.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:157.1-162.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:164.1-166.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:137.1-137.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:142.1-144.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:413.1-413.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:417.1-418.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:420.1-421.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:423.1-424.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:426.1-428.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?()), t))

;; 3-typing.watsup:414.1-414.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:431.1-432.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:415.1-415.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:435.1-438.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:445.1-445.73
relation Type_ok: `|-%:%`(type, functype)
  ;; 3-typing.watsup:459.1-461.29
  rule _ {ft : functype}:
    `|-%:%`(TYPE(ft), ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:446.1-446.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:463.1-467.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, `FUNC%%*%`(x, LOCAL(t)*{t}, expr), ft)
    -- if (C.TYPE_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:447.1-447.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:469.1-473.40
  rule _ {C : context, expr : expr, gt : globaltype, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `%%`(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:448.1-448.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:475.1-477.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:449.1-449.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:479.1-481.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:452.1-452.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:492.1-495.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:497.1-498.20
  rule passive {C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; 3-typing.watsup:500.1-501.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:450.1-450.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:483.1-486.37
  rule _ {C : context, elemmode : elemmode, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%`(rt, expr*{expr}, elemmode), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [$valtype_reftype(rt)]))*{expr}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, rt)

;; 3-typing.watsup:453.1-453.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:503.1-506.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, ACTIVE_datamode(0, expr))
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:508.1-509.20
  rule passive {C : context}:
    `%|-%:OK`(C, PASSIVE_datamode)

;; 3-typing.watsup:451.1-451.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:488.1-490.37
  rule _ {C : context, b* : byte*, datamode : datamode}:
    `%|-%:OK`(C, `DATA%*%`(b*{b}, datamode))
    -- Datamode_ok: `%|-%:OK`(C, datamode)

;; 3-typing.watsup:454.1-454.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:511.1-513.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:518.1-518.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:522.1-524.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:520.1-520.83
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; 3-typing.watsup:531.1-533.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype(ft))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:535.1-537.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:539.1-541.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:543.1-545.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (C.MEM_context[x] = mt)

;; 3-typing.watsup:519.1-519.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:526.1-528.39
  rule _ {C : context, externidx : externidx, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externidx), xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 3-typing.watsup:550.1-550.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:552.1-567.20
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, ft'* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*, type* : type*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (C = {TYPE ft'*{ft'}, FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Type_ok: `|-%:%`(type, ft'))*{ft' type}
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

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

;; 4-runtime.watsup:30.1-31.28
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:32.1-33.71
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:34.1-35.14
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:37.1-38.22
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:47.1-48.70
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:55.1-55.44
def default_ : valtype -> val?
  ;; 4-runtime.watsup:56.1-56.35
  def default_(I32_valtype) = ?(CONST_val(I32_numtype, 0))
  ;; 4-runtime.watsup:57.1-57.35
  def default_(I64_valtype) = ?(CONST_val(I64_numtype, 0))
  ;; 4-runtime.watsup:58.1-58.35
  def default_(F32_valtype) = ?(CONST_val(F32_numtype, 0))
  ;; 4-runtime.watsup:59.1-59.35
  def default_(F64_valtype) = ?(CONST_val(F64_numtype, 0))
  ;; 4-runtime.watsup:60.1-60.44
  def default_(FUNCREF_valtype) = ?(REF.NULL_val(FUNCREF_reftype))
  ;; 4-runtime.watsup:61.1-61.48
  def default_(EXTERNREF_valtype) = ?(REF.NULL_val(EXTERNREF_reftype))
  def {x : valtype} default_(x) = ?()

;; 4-runtime.watsup:88.1-90.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:92.1-100.25
syntax moduleinst = {TYPE functype*, FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:70.1-73.16
syntax funcinst = {TYPE functype, MODULE moduleinst, CODE func}

;; 4-runtime.watsup:74.1-76.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:77.1-79.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:80.1-82.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:83.1-85.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:86.1-87.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:114.1-120.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:122.1-124.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:126.1-126.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:213.1-220.9
rec {

;; 4-runtime.watsup:213.1-220.9
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | CALL_ADDR(funcaddr)
  | LABEL_(n, instr*, admininstr*)
  | FRAME_(n, frame, admininstr*)
  | TRAP
}

def admininstr_instr : instr -> admininstr
  def admininstr_instr(UNREACHABLE_instr) = UNREACHABLE_admininstr
  def admininstr_instr(NOP_instr) = NOP_admininstr
  def admininstr_instr(DROP_instr) = DROP_admininstr
  def {x : valtype*?} admininstr_instr(SELECT_instr(x)) = SELECT_admininstr(x)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(BLOCK_instr(x0, x1)) = BLOCK_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(LOOP_instr(x0, x1)) = LOOP_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*, x2 : instr*} admininstr_instr(IF_instr(x0, x1, x2)) = IF_admininstr(x0, x1, x2)
  def {x : labelidx} admininstr_instr(BR_instr(x)) = BR_admininstr(x)
  def {x : labelidx} admininstr_instr(BR_IF_instr(x)) = BR_IF_admininstr(x)
  def {x0 : labelidx*, x1 : labelidx} admininstr_instr(BR_TABLE_instr(x0, x1)) = BR_TABLE_admininstr(x0, x1)
  def {x : funcidx} admininstr_instr(CALL_instr(x)) = CALL_admininstr(x)
  def {x0 : tableidx, x1 : typeidx} admininstr_instr(CALL_INDIRECT_instr(x0, x1)) = CALL_INDIRECT_admininstr(x0, x1)
  def admininstr_instr(RETURN_instr) = RETURN_admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_instr(CONST_instr(x0, x1)) = CONST_admininstr(x0, x1)
  def {x0 : numtype, x1 : unop_numtype} admininstr_instr(UNOP_instr(x0, x1)) = UNOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : binop_numtype} admininstr_instr(BINOP_instr(x0, x1)) = BINOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : testop_numtype} admininstr_instr(TESTOP_instr(x0, x1)) = TESTOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : relop_numtype} admininstr_instr(RELOP_instr(x0, x1)) = RELOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : n} admininstr_instr(EXTEND_instr(x0, x1)) = EXTEND_admininstr(x0, x1)
  def {x0 : numtype, x1 : cvtop, x2 : numtype, x3 : sx?} admininstr_instr(CVTOP_instr(x0, x1, x2, x3)) = CVTOP_admininstr(x0, x1, x2, x3)
  def {x : reftype} admininstr_instr(REF.NULL_instr(x)) = REF.NULL_admininstr(x)
  def {x : funcidx} admininstr_instr(REF.FUNC_instr(x)) = REF.FUNC_admininstr(x)
  def admininstr_instr(REF.IS_NULL_instr) = REF.IS_NULL_admininstr
  def {x : localidx} admininstr_instr(LOCAL.GET_instr(x)) = LOCAL.GET_admininstr(x)
  def {x : localidx} admininstr_instr(LOCAL.SET_instr(x)) = LOCAL.SET_admininstr(x)
  def {x : localidx} admininstr_instr(LOCAL.TEE_instr(x)) = LOCAL.TEE_admininstr(x)
  def {x : globalidx} admininstr_instr(GLOBAL.GET_instr(x)) = GLOBAL.GET_admininstr(x)
  def {x : globalidx} admininstr_instr(GLOBAL.SET_instr(x)) = GLOBAL.SET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.GET_instr(x)) = TABLE.GET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.SET_instr(x)) = TABLE.SET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.SIZE_instr(x)) = TABLE.SIZE_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.GROW_instr(x)) = TABLE.GROW_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.FILL_instr(x)) = TABLE.FILL_admininstr(x)
  def {x0 : tableidx, x1 : tableidx} admininstr_instr(TABLE.COPY_instr(x0, x1)) = TABLE.COPY_admininstr(x0, x1)
  def {x0 : tableidx, x1 : elemidx} admininstr_instr(TABLE.INIT_instr(x0, x1)) = TABLE.INIT_admininstr(x0, x1)
  def {x : elemidx} admininstr_instr(ELEM.DROP_instr(x)) = ELEM.DROP_admininstr(x)
  def admininstr_instr(MEMORY.SIZE_instr) = MEMORY.SIZE_admininstr
  def admininstr_instr(MEMORY.GROW_instr) = MEMORY.GROW_admininstr
  def admininstr_instr(MEMORY.FILL_instr) = MEMORY.FILL_admininstr
  def admininstr_instr(MEMORY.COPY_instr) = MEMORY.COPY_admininstr
  def {x : dataidx} admininstr_instr(MEMORY.INIT_instr(x)) = MEMORY.INIT_admininstr(x)
  def {x : dataidx} admininstr_instr(DATA.DROP_instr(x)) = DATA.DROP_admininstr(x)
  def {x0 : numtype, x1 : (n, sx)?, x2 : memop} admininstr_instr(LOAD_instr(x0, x1, x2)) = LOAD_admininstr(x0, x1, x2)
  def {x0 : numtype, x1 : n?, x2 : memop} admininstr_instr(STORE_instr(x0, x1, x2)) = STORE_admininstr(x0, x1, x2)

def admininstr_ref : ref -> admininstr
  def {x : reftype} admininstr_ref(REF.NULL_ref(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_ref(REF.FUNC_ADDR_ref(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_ref(REF.HOST_ADDR_ref(x)) = REF.HOST_ADDR_admininstr(x)

def admininstr_val : val -> admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_val(CONST_val(x0, x1)) = CONST_admininstr(x0, x1)
  def {x : reftype} admininstr_val(REF.NULL_val(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_val(REF.FUNC_ADDR_val(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_val(REF.HOST_ADDR_val(x)) = REF.HOST_ADDR_admininstr(x)

;; 4-runtime.watsup:127.1-127.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:136.1-136.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:137.1-137.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:139.1-139.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:146.1-146.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:140.1-140.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:147.1-147.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:141.1-141.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:148.1-148.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:142.1-142.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:149.1-149.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:143.1-143.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:150.1-150.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:144.1-144.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:151.1-151.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:153.1-153.67
def type : (state, typeidx) -> functype
  ;; 4-runtime.watsup:162.1-162.40
  def {f : frame, s : store, x : idx} type(`%;%`(s, f), x) = f.MODULE_frame.TYPE_moduleinst[x]

;; 4-runtime.watsup:154.1-154.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:163.1-163.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:155.1-155.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:164.1-164.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:156.1-156.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:165.1-165.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:157.1-157.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:166.1-166.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:158.1-158.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:167.1-167.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:159.1-159.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:168.1-168.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:160.1-160.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:169.1-169.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:172.1-172.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:181.1-181.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:173.1-173.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:182.1-182.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:174.1-174.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:183.1-183.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:175.1-175.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:184.1-184.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:176.1-176.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:185.1-185.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:177.1-177.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:186.1-186.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:178.1-178.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:187.1-187.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:179.1-179.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:188.1-188.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:193.1-193.63
def grow_table : (tableinst, nat, ref) -> tableinst?
  ;; 4-runtime.watsup:196.1-200.36
  def {i : nat, i' : nat, j : nat, n : n, r : ref, r'* : ref*, rt : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ?(ti')
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%]`(i', j), rt), ELEM r'*{r'} :: r^n{}})
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)
  def {x : (tableinst, nat, ref)} grow_table(x) = ?()

;; 4-runtime.watsup:194.1-194.55
def grow_memory : (meminst, nat) -> meminst?
  ;; 4-runtime.watsup:202.1-206.34
  def {b* : byte*, i : nat, i' : nat, j : nat, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = ?(mi')
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%]`(i', j)), DATA b*{b} :: 0^((n * 64) * $Ki){}})
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)
  def {x : (meminst, nat)} grow_memory(x) = ?()

;; 4-runtime.watsup:222.1-225.25
rec {

;; 4-runtime.watsup:222.1-225.25
syntax E =
  | _HOLE
  | _SEQ(val*, E, instr*)
  | LABEL_(n, instr*, E)
}

;; 5-numerics.watsup:3.1-3.79
def unop : (unop_numtype, numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:4.1-4.80
def binop : (binop_numtype, numtype, c_numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:5.1-5.79
def testop : (testop_numtype, numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:6.1-6.80
def relop : (relop_numtype, numtype, c_numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:8.1-8.84
def ext : (nat, nat, sx, c_numtype) -> c_numtype

;; 5-numerics.watsup:9.1-9.84
def cvtop : (numtype, cvtop, numtype, sx?, c_numtype) -> c_numtype*

;; 5-numerics.watsup:11.1-11.32
def wrap_ : ((nat, nat), c_numtype) -> nat

;; 5-numerics.watsup:13.1-13.60
def ibytes : (nat, iN) -> byte*

;; 5-numerics.watsup:14.1-14.60
def fbytes : (nat, fN) -> byte*

;; 5-numerics.watsup:15.1-15.58
def ntbytes : (numtype, c_numtype) -> byte*

;; 5-numerics.watsup:17.1-17.30
def invibytes : (nat, byte*) -> iN
  ;; 5-numerics.watsup:20.1-20.52
  def {N : nat, b* : byte*, n : n} invibytes(N, b*{b}) = n
    -- if ($ibytes(N, n) = b*{b})

;; 5-numerics.watsup:18.1-18.30
def invfbytes : (nat, byte*) -> fN
  ;; 5-numerics.watsup:21.1-21.52
  def {N : nat, b* : byte*, p : fN} invfbytes(N, b*{b}) = p
    -- if ($fbytes(N, p) = b*{b})

;; 6-reduction.watsup:6.1-6.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:24.1-25.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:27.1-28.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:30.1-31.24
  rule drop {val : val}:
    `%*~>%*`([$admininstr_val(val) DROP_admininstr], [])

  ;; 6-reduction.watsup:34.1-36.16
  rule select-true {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [$admininstr_val(val_1)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:38.1-40.14
  rule select-false {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [$admininstr_val(val_2)])
    -- if (c = 0)

  ;; 6-reduction.watsup:58.1-60.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:62.1-64.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:67.1-68.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, $admininstr_val(val)*{val})], $admininstr_val(val)*{val})

  ;; 6-reduction.watsup:74.1-75.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [BR_admininstr(0)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val} :: $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:77.1-78.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val)*{val} :: [BR_admininstr(l + 1)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:81.1-83.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:85.1-87.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:90.1-92.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:94.1-96.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:121.1-122.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val)^n{val})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:124.1-125.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:127.1-128.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, $admininstr_val(val)*{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:133.1-135.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 6-reduction.watsup:137.1-139.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:142.1-144.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 6-reduction.watsup:146.1-148.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:151.1-153.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 6-reduction.watsup:155.1-157.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 6-reduction.watsup:160.1-161.70
  rule extend {c : c_numtype, n : n, nt : numtype, o0 : nat}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, o0, S_sx, c))])
    -- if ($size($valtype_numtype(nt)) = ?(o0))

  ;; 6-reduction.watsup:164.1-166.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [c])

  ;; 6-reduction.watsup:168.1-170.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:179.1-181.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(rt))

  ;; 6-reduction.watsup:183.1-185.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:196.1-197.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([$admininstr_val(val) LOCAL.TEE_admininstr(x)], [$admininstr_val(val) $admininstr_val(val) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:45.1-45.73
def blocktype : (state, blocktype) -> functype
  ;; 6-reduction.watsup:46.1-46.56
  def {z : state} blocktype(z, _RESULT_blocktype(?())) = `%->%`([], [])
  ;; 6-reduction.watsup:47.1-47.44
  def {t : valtype, z : state} blocktype(z, _RESULT_blocktype(?(t))) = `%->%`([], [t])
  ;; 6-reduction.watsup:48.1-48.40
  def {x : idx, z : state} blocktype(z, _IDX_blocktype(x)) = $type(z, x)

;; 6-reduction.watsup:7.1-7.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:50.1-52.43
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})]), [LABEL__admininstr(n, [], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:54.1-56.43
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [LOOP_admininstr(bt, instr*{instr})]), [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:101.1-102.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:104.1-108.35
  rule call_indirect-call {a : addr, i : nat, instr* : instr*, t* : valtype*, x : idx, y : idx, y' : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [CALL_ADDR_admininstr(a)])
    -- if ($table(z, x).ELEM_tableinst[i] = REF.FUNC_ADDR_ref(a))
    -- if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(y', LOCAL(t)*{t}, instr*{instr}))
    -- if ($type(z, y) = $type(z, y'))

  ;; 6-reduction.watsup:110.1-112.15
  rule call_indirect-trap {i : nat, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:114.1-118.53
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, mm : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, x : idx, z : state, o0* : val*}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], $admininstr_instr(instr)*{instr})])])
    -- (if ($default_(t) = ?(o0)))*{t o0}
    -- if ($funcinst(z)[a] = {TYPE `%->%`(t_1^k{t_1}, t_2^n{t_2}), MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, LOCAL(t)*{t}, instr*{instr}))
    -- if (f = {LOCAL val^k{val} :: o0*{o0}, MODULE mm})

  ;; 6-reduction.watsup:175.1-176.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:190.1-191.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [$admininstr_val($local(z, x))])

  ;; 6-reduction.watsup:202.1-203.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [$admininstr_val($global(z, x).VALUE_globalinst)])

  ;; 6-reduction.watsup:211.1-213.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:215.1-217.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [$admininstr_ref($table(z, x).ELEM_tableinst[i])])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:228.1-230.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 6-reduction.watsup:241.1-243.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:245.1-248.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:250.1-254.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:257.1-259.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:261.1-264.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:266.1-271.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:273.1-277.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:280.1-282.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:284.1-287.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:289.1-293.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) $admininstr_ref($elem(z, y).ELEM_eleminst[i]) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:302.1-304.59
  rule load-num-trap {i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [TRAP_admininstr])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (((i + mo.OFFSET_memop) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:306.1-308.71
  rule load-num-val {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [CONST_admininstr(nt, c)])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if ($ntbytes(nt, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (o0 / 8)])

  ;; 6-reduction.watsup:310.1-312.51
  rule load-pack-trap {i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:314.1-316.61
  rule load-pack-val {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [CONST_admininstr(nt, $ext(n, o0, sx, c))])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if ($ibytes(n, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])

  ;; 6-reduction.watsup:336.1-338.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:349.1-351.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:353.1-356.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:358.1-362.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:365.1-367.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:369.1-372.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:374.1-379.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:381.1-385.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:388.1-390.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:392.1-395.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:397.1-401.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- otherwise

;; 6-reduction.watsup:5.1-5.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:9.1-11.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_pure: `%*~>%*`($admininstr_instr(instr)*{instr}, $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:13.1-15.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, $admininstr_instr(instr)*{instr}), $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:193.1-194.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:205.1-206.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:219.1-221.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:223.1-225.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:233.1-235.47
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, x : idx, z : state, o0 : tableinst}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if ($grow_table($table(z, x), n, ref) = ?(o0))
    -- if (o0 = ti)

  ;; 6-reduction.watsup:237.1-238.80
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:296.1-297.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:319.1-321.59
  rule store-num-trap {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (((i + mo.OFFSET_memop) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:323.1-325.29
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), (o0 / 8), b*{b}), []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (b*{b} = $ntbytes(nt, c))

  ;; 6-reduction.watsup:327.1-329.51
  rule store-pack-trap {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:331.1-333.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), (n / 8), b*{b}), []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (b*{b} = $ibytes(n, $wrap_((o0, n), c)))

  ;; 6-reduction.watsup:341.1-343.41
  rule memory.grow-succeed {mi : meminst, n : n, z : state, o0 : meminst}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- if ($grow_memory($mem(z, 0), n) = ?(o0))
    -- if (o0 = mi)

  ;; 6-reduction.watsup:345.1-346.75
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:404.1-405.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:5.1-5.35
rec {

;; 7-module.watsup:5.1-5.35
def funcs : externval* -> funcaddr*
  ;; 7-module.watsup:6.1-6.30
  def funcs([]) = []
  ;; 7-module.watsup:7.1-7.59
  def {externval'* : externval*, fa : funcaddr} funcs([FUNC_externval(fa)] :: externval'*{externval'}) = [fa] :: $funcs(externval'*{externval'})
  ;; 7-module.watsup:8.1-9.15
  def {externval : externval, externval'* : externval*} funcs([externval] :: externval'*{externval'}) = $funcs(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:11.1-11.39
rec {

;; 7-module.watsup:11.1-11.39
def globals : externval* -> globaladdr*
  ;; 7-module.watsup:12.1-12.32
  def globals([]) = []
  ;; 7-module.watsup:13.1-13.65
  def {externval'* : externval*, ga : globaladdr} globals([GLOBAL_externval(ga)] :: externval'*{externval'}) = [ga] :: $globals(externval'*{externval'})
  ;; 7-module.watsup:14.1-15.15
  def {externval : externval, externval'* : externval*} globals([externval] :: externval'*{externval'}) = $globals(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:17.1-17.37
rec {

;; 7-module.watsup:17.1-17.37
def tables : externval* -> tableaddr*
  ;; 7-module.watsup:18.1-18.31
  def tables([]) = []
  ;; 7-module.watsup:19.1-19.62
  def {externval'* : externval*, ta : tableaddr} tables([TABLE_externval(ta)] :: externval'*{externval'}) = [ta] :: $tables(externval'*{externval'})
  ;; 7-module.watsup:20.1-21.15
  def {externval : externval, externval'* : externval*} tables([externval] :: externval'*{externval'}) = $tables(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:23.1-23.33
rec {

;; 7-module.watsup:23.1-23.33
def mems : externval* -> memaddr*
  ;; 7-module.watsup:24.1-24.29
  def mems([]) = []
  ;; 7-module.watsup:25.1-25.56
  def {externval'* : externval*, ma : memaddr} mems([MEM_externval(ma)] :: externval'*{externval'}) = [ma] :: $mems(externval'*{externval'})
  ;; 7-module.watsup:26.1-27.15
  def {externval : externval, externval'* : externval*} mems([externval] :: externval'*{externval'}) = $mems(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:36.1-36.60
def allocfunc : (store, moduleinst, func) -> (store, funcaddr)
  ;; 7-module.watsup:37.1-39.34
  def {expr : expr, fi : funcinst, func : func, local* : local*, mm : moduleinst, s : store, x : idx} allocfunc(s, mm, func) = (s[FUNC_store =.. [fi]], |s.FUNC_store|)
    -- if (fi = {TYPE mm.TYPE_moduleinst[x], MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, local*{local}, expr))

;; 7-module.watsup:41.1-41.63
rec {

;; 7-module.watsup:41.1-41.63
def allocfuncs : (store, moduleinst, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:42.1-42.47
  def {mm : moduleinst, s : store} allocfuncs(s, mm, []) = (s, [])
  ;; 7-module.watsup:43.1-45.51
  def {fa : funcaddr, fa'* : funcaddr*, func : func, func'* : func*, mm : moduleinst, s : store, s_1 : store, s_2 : store} allocfuncs(s, mm, [func] :: func'*{func'}) = (s_2, [fa] :: fa'*{fa'})
    -- if ((s_1, fa) = $allocfunc(s, mm, func))
    -- if ((s_2, fa'*{fa'}) = $allocfuncs(s_1, mm, func'*{func'}))
}

;; 7-module.watsup:47.1-47.63
def allocglobal : (store, globaltype, val) -> (store, globaladdr)
  ;; 7-module.watsup:48.1-49.44
  def {gi : globalinst, globaltype : globaltype, s : store, val : val} allocglobal(s, globaltype, val) = (s[GLOBAL_store =.. [gi]], |s.GLOBAL_store|)
    -- if (gi = {TYPE globaltype, VALUE val})

;; 7-module.watsup:51.1-51.67
rec {

;; 7-module.watsup:51.1-51.67
def allocglobals : (store, globaltype*, val*) -> (store, globaladdr*)
  ;; 7-module.watsup:52.1-52.54
  def {s : store} allocglobals(s, [], []) = (s, [])
  ;; 7-module.watsup:53.1-55.62
  def {ga : globaladdr, ga'* : globaladdr*, globaltype : globaltype, globaltype'* : globaltype*, s : store, s_1 : store, s_2 : store, val : val, val'* : val*} allocglobals(s, [globaltype] :: globaltype'*{globaltype'}, [val] :: val'*{val'}) = (s_2, [ga] :: ga'*{ga'})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga'}) = $allocglobals(s_1, globaltype'*{globaltype'}, val'*{val'}))
}

;; 7-module.watsup:57.1-57.55
def alloctable : (store, tabletype) -> (store, tableaddr)
  ;; 7-module.watsup:58.1-59.59
  def {i : nat, j : nat, rt : reftype, s : store, ti : tableinst} alloctable(s, `%%`(`[%..%]`(i, j), rt)) = (s[TABLE_store =.. [ti]], |s.TABLE_store|)
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM REF.NULL_ref(rt)^i{}})

;; 7-module.watsup:61.1-61.58
rec {

;; 7-module.watsup:61.1-61.58
def alloctables : (store, tabletype*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.44
  def {s : store} alloctables(s, []) = (s, [])
  ;; 7-module.watsup:63.1-65.53
  def {s : store, s_1 : store, s_2 : store, ta : tableaddr, ta'* : tableaddr*, tabletype : tabletype, tabletype'* : tabletype*} alloctables(s, [tabletype] :: tabletype'*{tabletype'}) = (s_2, [ta] :: ta'*{ta'})
    -- if ((s_1, ta) = $alloctable(s, tabletype))
    -- if ((s_2, ta'*{ta'}) = $alloctables(s_1, tabletype'*{tabletype'}))
}

;; 7-module.watsup:67.1-67.49
def allocmem : (store, memtype) -> (store, memaddr)
  ;; 7-module.watsup:68.1-69.62
  def {i : nat, j : nat, mi : meminst, s : store} allocmem(s, `%I8`(`[%..%]`(i, j))) = (s[MEM_store =.. [mi]], |s.MEM_store|)
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA 0^((i * 64) * $Ki){}})

;; 7-module.watsup:71.1-71.52
rec {

;; 7-module.watsup:71.1-71.52
def allocmems : (store, memtype*) -> (store, memaddr*)
  ;; 7-module.watsup:72.1-72.42
  def {s : store} allocmems(s, []) = (s, [])
  ;; 7-module.watsup:73.1-75.49
  def {ma : memaddr, ma'* : memaddr*, memtype : memtype, memtype'* : memtype*, s : store, s_1 : store, s_2 : store} allocmems(s, [memtype] :: memtype'*{memtype'}) = (s_2, [ma] :: ma'*{ma'})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma'}) = $allocmems(s_1, memtype'*{memtype'}))
}

;; 7-module.watsup:77.1-77.57
def allocelem : (store, reftype, ref*) -> (store, elemaddr)
  ;; 7-module.watsup:78.1-79.36
  def {ei : eleminst, ref* : ref*, rt : reftype, s : store} allocelem(s, rt, ref*{ref}) = (s[ELEM_store =.. [ei]], |s.ELEM_store|)
    -- if (ei = {TYPE rt, ELEM ref*{ref}})

;; 7-module.watsup:81.1-81.63
rec {

;; 7-module.watsup:81.1-81.63
def allocelems : (store, reftype*, ref**) -> (store, elemaddr*)
  ;; 7-module.watsup:82.1-82.52
  def {s : store} allocelems(s, [], []) = (s, [])
  ;; 7-module.watsup:83.1-85.55
  def {ea : elemaddr, ea'* : elemaddr*, ref* : ref*, ref'** : ref**, rt : reftype, rt'* : reftype*, s : store, s_1 : store, s_2 : store} allocelems(s, [rt] :: rt'*{rt'}, [ref*{ref}] :: ref'*{ref'}*{ref'}) = (s_2, [ea] :: ea'*{ea'})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref}))
    -- if ((s_2, ea'*{ea'}) = $allocelems(s_2, rt'*{rt'}, ref'*{ref'}*{ref'}))
}

;; 7-module.watsup:87.1-87.49
def allocdata : (store, byte*) -> (store, dataaddr)
  ;; 7-module.watsup:88.1-89.28
  def {byte* : byte*, di : datainst, s : store} allocdata(s, byte*{byte}) = (s[DATA_store =.. [di]], |s.DATA_store|)
    -- if (di = {DATA byte*{byte}})

;; 7-module.watsup:91.1-91.54
rec {

;; 7-module.watsup:91.1-91.54
def allocdatas : (store, byte**) -> (store, dataaddr*)
  ;; 7-module.watsup:92.1-92.43
  def {s : store} allocdatas(s, []) = (s, [])
  ;; 7-module.watsup:93.1-95.50
  def {byte* : byte*, byte'** : byte**, da : dataaddr, da'* : dataaddr*, s : store, s_1 : store, s_2 : store} allocdatas(s, [byte]*{byte} :: byte'*{byte'}*{byte'}) = (s_2, [da] :: da'*{da'})
    -- if ((s_1, da) = $allocdata(s, byte*{byte}))
    -- if ((s_2, da'*{da'}) = $allocdatas(s_1, byte'*{byte'}*{byte'}))
}

;; 7-module.watsup:100.1-100.83
def instexport : (funcaddr*, globaladdr*, tableaddr*, memaddr*, export) -> exportinst
  ;; 7-module.watsup:101.1-101.95
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, FUNC_externidx(x))) = {NAME name, VALUE FUNC_externval(fa*{fa}[x])}
  ;; 7-module.watsup:102.1-102.99
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, GLOBAL_externidx(x))) = {NAME name, VALUE GLOBAL_externval(ga*{ga}[x])}
  ;; 7-module.watsup:103.1-103.97
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, TABLE_externidx(x))) = {NAME name, VALUE TABLE_externval(ta*{ta}[x])}
  ;; 7-module.watsup:104.1-104.93
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, MEM_externidx(x))) = {NAME name, VALUE MEM_externval(ma*{ma}[x])}

;; 7-module.watsup:107.1-107.81
def allocmodule : (store, module, externval*, val*, ref**) -> (store, moduleinst)
  ;; 7-module.watsup:108.1-147.54
  def {byte*^n_data : byte*^n_data, da* : dataaddr*, datamode^n_data : datamode^n_data, ea* : elemaddr*, elemmode^n_elem : elemmode^n_elem, export* : export*, expr_1^n_global : expr^n_global, expr_2*^n_elem : expr*^n_elem, externval* : externval*, fa* : funcaddr*, fa_ex* : funcaddr*, ft : functype, func^n_func : func^n_func, ga* : globaladdr*, ga_ex* : globaladdr*, globaltype^n_global : globaltype^n_global, i_data^n_data : nat^n_data, i_elem^n_elem : nat^n_elem, i_func^n_func : nat^n_func, i_global^n_global : nat^n_global, i_mem^n_mem : nat^n_mem, i_table^n_table : nat^n_table, import* : import*, ma* : memaddr*, ma_ex* : memaddr*, memtype^n_mem : memtype^n_mem, mm : moduleinst, module : module, n_data : n, n_elem : n, n_func : n, n_global : n, n_mem : n, n_table : n, ref** : ref**, rt^n_elem : reftype^n_elem, s : store, s_1 : store, s_2 : store, s_3 : store, s_4 : store, s_5 : store, s_6 : store, start? : start?, ta* : tableaddr*, ta_ex* : tableaddr*, tabletype^n_table : tabletype^n_table, val* : val*, xi* : exportinst*} allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}) = (s_6, mm)
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(TYPE(ft)*{}, import*{import}, func^n_func{func}, GLOBAL(globaltype, expr_1)^n_global{expr_1 globaltype}, TABLE(tabletype)^n_table{tabletype}, MEMORY(memtype)^n_mem{memtype}, `ELEM%%*%`(rt, expr_2*{expr_2}, elemmode)^n_elem{elemmode expr_2 rt}, `DATA%*%`(byte*{byte}, datamode)^n_data{byte datamode}, start?{start}, export*{export}))
    -- if (fa_ex*{fa_ex} = $funcs(externval*{externval}))
    -- if (ga_ex*{ga_ex} = $globals(externval*{externval}))
    -- if (ta_ex*{ta_ex} = $tables(externval*{externval}))
    -- if (ma_ex*{ma_ex} = $mems(externval*{externval}))
    -- if (fa*{fa} = (|s.FUNC_store| + i_func)^(i_func<n_func){i_func})
    -- if (ga*{ga} = (|s.GLOBAL_store| + i_global)^(i_global<n_global){i_global})
    -- if (ta*{ta} = (|s.TABLE_store| + i_table)^(i_table<n_table){i_table})
    -- if (ma*{ma} = (|s.MEM_store| + i_mem)^(i_mem<n_mem){i_mem})
    -- if (ea*{ea} = (|s.ELEM_store| + i_elem)^(i_elem<n_elem){i_elem})
    -- if (da*{da} = (|s.DATA_store| + i_data)^(i_data<n_data){i_data})
    -- if (xi*{xi} = $instexport(fa_ex*{fa_ex} :: fa*{fa}, ga_ex*{ga_ex} :: ga*{ga}, ta_ex*{ta_ex} :: ta*{ta}, ma_ex*{ma_ex} :: ma*{ma}, export)*{export})
    -- if (mm = {TYPE [ft], FUNC fa_ex*{fa_ex} :: fa*{fa}, GLOBAL ga_ex*{ga_ex} :: ga*{ga}, TABLE ta_ex*{ta_ex} :: ta*{ta}, MEM ma_ex*{ma_ex} :: ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT xi*{xi}})
    -- if ((s_1, fa*{fa}) = $allocfuncs(s, mm, func^n_func{func}))
    -- if ((s_2, ga*{ga}) = $allocglobals(s_1, globaltype^n_global{globaltype}, val*{val}))
    -- if ((s_3, ta*{ta}) = $alloctables(s_2, tabletype^n_table{tabletype}))
    -- if ((s_4, ma*{ma}) = $allocmems(s_3, memtype^n_mem{memtype}))
    -- if ((s_5, ea*{ea}) = $allocelems(s_4, rt^n_elem{rt}, ref*{ref}*{ref}))
    -- if ((s_6, da*{da}) = $allocdatas(s_5, byte*{byte}^n_data{byte}))

;; 7-module.watsup:154.1-154.36
rec {

;; 7-module.watsup:154.1-154.36
def concat_instr : instr** -> instr*
  ;; 7-module.watsup:155.1-155.37
  def concat_instr([]) = []
  ;; 7-module.watsup:156.1-156.68
  def {instr* : instr*, instr'** : instr**} concat_instr([instr]*{instr} :: instr'*{instr'}*{instr'}) = instr*{instr} :: $concat_instr(instr'*{instr'}*{instr'})
}

;; 7-module.watsup:158.1-158.33
def runelem : (elem, idx) -> instr*
  ;; 7-module.watsup:159.1-159.56
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, PASSIVE_elemmode), i) = []
  ;; 7-module.watsup:160.1-160.62
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, DECLARE_elemmode), i) = [ELEM.DROP_instr(i)]
  ;; 7-module.watsup:161.1-163.20
  def {expr* : expr*, i : nat, instr* : instr*, n : n, reftype : reftype, x : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, ACTIVE_elemmode(x, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) TABLE.INIT_instr(x, i) ELEM.DROP_instr(i)]
    -- if (n = |expr*{expr}|)

;; 7-module.watsup:165.1-165.33
def rundata : (data, idx) -> instr*
  ;; 7-module.watsup:166.1-166.48
  def {byte* : byte*, i : nat} rundata(`DATA%*%`(byte*{byte}, PASSIVE_datamode), i) = []
  ;; 7-module.watsup:167.1-169.20
  def {byte* : byte*, i : nat, instr* : instr*, n : n} rundata(`DATA%*%`(byte*{byte}, ACTIVE_datamode(0, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) MEMORY.INIT_instr(i) DATA.DROP_instr(i)]
    -- if (n = |byte*{byte}|)

;; 7-module.watsup:171.1-171.53
def instantiate : (store, module, externval*) -> config
  ;; 7-module.watsup:172.1-196.28
  def {data* : data*, elem* : elem*, elemmode* : elemmode*, export* : export*, externval* : externval*, f : frame, f_init : frame, func* : func*, functype* : functype*, global* : global*, globaltype* : globaltype*, i^n_elem : nat^n_elem, import* : import*, instr_1** : instr**, instr_2*** : instr***, instr_data* : instr*, instr_elem* : instr*, j^n_data : nat^n_data, mem* : mem*, mm : moduleinst, mm_init : moduleinst, module : module, n_data : n, n_elem : n, ref** : ref**, reftype* : reftype*, s : store, s' : store, start? : start?, table* : table*, type* : type*, val* : val*, x? : idx?} instantiate(s, module, externval*{externval}) = `%;%*`(`%;%`(s', f), $admininstr_instr(instr_elem)*{instr_elem} :: $admininstr_instr(instr_data)*{instr_data} :: CALL_admininstr(x)?{x})
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (type*{type} = TYPE(functype)*{functype})
    -- if (global*{global} = GLOBAL(globaltype, instr_1*{instr_1})*{globaltype instr_1})
    -- if (elem*{elem} = `ELEM%%*%`(reftype, instr_2*{instr_2}*{instr_2}, elemmode)*{elemmode instr_2 reftype})
    -- if (mm_init = {TYPE functype*{functype}, FUNC $funcs(externval*{externval}), GLOBAL $globals(externval*{externval}), TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f_init = {LOCAL [], MODULE mm_init})
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), $admininstr_instr(instr_1)*{instr_1}), [$admininstr_val(val)]))*{instr_1 val}
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), $admininstr_instr(instr_2)*{instr_2}), [$admininstr_ref(ref)]))*{instr_2 ref}*{instr_2 ref}
    -- if ((s', mm) = $allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}))
    -- if (f = {LOCAL [], MODULE mm})
    -- if (n_elem = |elem*{elem}|)
    -- if (instr_elem*{instr_elem} = $concat_instr($runelem(elem*{elem}[i], i)^(i<n_elem){i}))
    -- if (n_data = |data*{data}|)
    -- if (instr_data*{instr_data} = $concat_instr($rundata(data*{data}[j], j)^(j<n_data){j}))
    -- if (start?{start} = START(x)?{x})

;; 7-module.watsup:203.1-203.44
def invoke : (store, funcaddr, val*) -> config
  ;; 7-module.watsup:204.1-215.51
  def {f : frame, fa : funcaddr, mm : moduleinst, n : n, s : store, t_1^n : valtype^n, t_2* : valtype*, val^n : val^n} invoke(s, fa, val^n{val}) = `%;%*`(`%;%`(s, f), $admininstr_val(val)^n{val} :: [CALL_ADDR_admininstr(fa)])
    -- if (mm = {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE mm})
    -- if ($funcinst(`%;%`(s, f))[fa].TYPE_funcinst = `%->%`(t_1^n{t_1}, t_2*{t_2}))

;; A-binary.watsup:47.1-47.57
rec {

;; A-binary.watsup:47.1-47.57
def concat_bytes : byte** -> byte*
  ;; A-binary.watsup:48.1-48.37
  def concat_bytes([]) = []
  ;; A-binary.watsup:49.1-49.52
  def {b* : byte*, b'** : byte**} concat_bytes([b]*{b} :: b'*{b'}*{b'}) = b*{b} :: $concat_bytes(b'*{b'}*{b'})
}

;; A-binary.watsup:51.1-51.24
rec {

;; A-binary.watsup:51.1-51.24
def utf8 : name -> byte*
  ;; A-binary.watsup:52.1-52.44
  def {b : byte, c : c_numtype} utf8([c]) = [b]
    -- if ((c < 128) /\ (c = b))
  ;; A-binary.watsup:53.1-53.93
  def {b_1 : byte, b_2 : byte, c : c_numtype} utf8([c]) = [b_1 b_2]
    -- if (((128 <= c) /\ (c < 2048)) /\ (c = (((2 ^ 6) * (b_1 - 192)) + (b_2 - 128))))
  ;; A-binary.watsup:54.1-54.144
  def {b_1 : byte, b_2 : byte, b_3 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3]
    -- if ((((2048 <= c) /\ (c < 55296)) \/ ((57344 <= c) /\ (c < 65536))) /\ (c = ((((2 ^ 12) * (b_1 - 224)) + ((2 ^ 6) * (b_2 - 128))) + (b_3 - 128))))
  ;; A-binary.watsup:55.1-55.145
  def {b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3 b_4]
    -- if (((65536 <= c) /\ (c < 69632)) /\ (c = (((((2 ^ 18) * (b_1 - 240)) + ((2 ^ 12) * (b_2 - 128))) + ((2 ^ 6) * (b_3 - 128))) + (b_4 - 128))))
  ;; A-binary.watsup:56.1-56.41
  def {c* : c_numtype*} utf8(c*{c}) = $concat_bytes($utf8([c])*{c})
}

;; A-binary.watsup:577.1-577.60
rec {

;; A-binary.watsup:577.1-577.60
def concat_locals : local** -> local*
  ;; A-binary.watsup:578.1-578.38
  def concat_locals([]) = []
  ;; A-binary.watsup:579.1-579.62
  def {loc* : local*, loc'** : local**} concat_locals([loc]*{loc} :: loc'*{loc'}*{loc'}) = loc*{loc} :: $concat_locals(loc'*{loc'}*{loc'})
}

;; A-binary.watsup:582.1-582.29
syntax code = (local*, expr)

== IL Validation after pass wildcards...
== Running pass sideconditions...

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:4.1-4.15
syntax m = nat

;; 1-syntax.watsup:18.1-18.50
syntax byte = nat

;; 1-syntax.watsup:21.1-21.58
syntax uN = nat

;; 1-syntax.watsup:22.1-22.87
syntax sN = nat

;; 1-syntax.watsup:23.1-23.36
syntax iN = uN

;; 1-syntax.watsup:26.1-26.58
syntax u32 = nat

;; 1-syntax.watsup:27.1-27.58
syntax u64 = nat

;; 1-syntax.watsup:28.1-28.61
syntax u128 = nat

;; 1-syntax.watsup:29.1-29.69
syntax s33 = nat

;; 1-syntax.watsup:34.1-34.21
def signif : nat -> nat
  ;; 1-syntax.watsup:35.1-35.21
  def signif(32) = 23
  ;; 1-syntax.watsup:36.1-36.21
  def signif(64) = 52

;; 1-syntax.watsup:38.1-38.20
def expon : nat -> nat
  ;; 1-syntax.watsup:39.1-39.19
  def expon(32) = 8
  ;; 1-syntax.watsup:40.1-40.20
  def expon(64) = 11

;; 1-syntax.watsup:42.1-42.35
def M : nat -> nat
  ;; 1-syntax.watsup:43.1-43.23
  def {N : nat} M(N) = $signif(N)

;; 1-syntax.watsup:45.1-45.35
def E : nat -> nat
  ;; 1-syntax.watsup:46.1-46.22
  def {N : nat} E(N) = $expon(N)

;; 1-syntax.watsup:51.1-55.81
syntax fNmag =
  |  {N : nat, n : n}NORM(m, n)
    -- if (((2 - (2 ^ ($E(N) - 1))) <= n) /\ (n <= ((2 ^ ($E(N) - 1)) - 1)))
  |  {N : nat, n : n}SUBNORM(m, n)
    -- if ((2 - (2 ^ ($E(N) - 1))) = n)
  | INF
  |  {N : nat, n : n}NAN(n)
    -- if ((1 <= n) /\ (n < $M(N)))

;; 1-syntax.watsup:49.1-49.107
syntax fN =
  | POS(fNmag)
  | NEG(fNmag)

;; 1-syntax.watsup:58.1-58.35
def fNzero : fN
  ;; 1-syntax.watsup:59.1-59.29
  def fNzero = POS_fN(NORM_fNmag(0, 0))

;; 1-syntax.watsup:62.1-62.51
syntax f32 = fN

;; 1-syntax.watsup:63.1-63.51
syntax f64 = fN

;; 1-syntax.watsup:71.1-71.85
syntax char = nat

;; 1-syntax.watsup:73.1-73.38
syntax name = char*

;; 1-syntax.watsup:80.1-80.36
syntax idx = u32

;; 1-syntax.watsup:81.1-81.45
syntax typeidx = idx

;; 1-syntax.watsup:82.1-82.49
syntax funcidx = idx

;; 1-syntax.watsup:83.1-83.49
syntax globalidx = idx

;; 1-syntax.watsup:84.1-84.47
syntax tableidx = idx

;; 1-syntax.watsup:85.1-85.46
syntax memidx = idx

;; 1-syntax.watsup:86.1-86.45
syntax elemidx = idx

;; 1-syntax.watsup:87.1-87.45
syntax dataidx = idx

;; 1-syntax.watsup:88.1-88.47
syntax labelidx = idx

;; 1-syntax.watsup:89.1-89.47
syntax localidx = idx

;; 1-syntax.watsup:98.1-99.26
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:100.1-101.9
syntax vectype =
  | V128

;; 1-syntax.watsup:102.1-103.24
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:104.1-105.38
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | FUNCREF
  | EXTERNREF
  | BOT

def valtype_numtype : numtype -> valtype
  def valtype_numtype(I32_numtype) = I32_valtype
  def valtype_numtype(I64_numtype) = I64_valtype
  def valtype_numtype(F32_numtype) = F32_valtype
  def valtype_numtype(F64_numtype) = F64_valtype

def valtype_reftype : reftype -> valtype
  def valtype_reftype(FUNCREF_reftype) = FUNCREF_valtype
  def valtype_reftype(EXTERNREF_reftype) = EXTERNREF_valtype

def valtype_vectype : vectype -> valtype
  def valtype_vectype(V128_vectype) = V128_valtype

;; 1-syntax.watsup:107.1-107.40
syntax inn =
  | I32
  | I64

def numtype_inn : inn -> numtype
  def numtype_inn(I32_inn) = I32_numtype
  def numtype_inn(I64_inn) = I64_numtype

def valtype_inn : inn -> valtype
  def valtype_inn(I32_inn) = I32_valtype
  def valtype_inn(I64_inn) = I64_valtype

;; 1-syntax.watsup:108.1-108.40
syntax fnn =
  | F32
  | F64

def numtype_fnn : fnn -> numtype
  def numtype_fnn(F32_fnn) = F32_numtype
  def numtype_fnn(F64_fnn) = F64_numtype

def valtype_fnn : fnn -> valtype
  def valtype_fnn(F32_fnn) = F32_valtype
  def valtype_fnn(F64_fnn) = F64_valtype

;; 1-syntax.watsup:115.1-116.11
syntax resulttype = valtype*

;; 1-syntax.watsup:118.1-118.18
syntax mut = `MUT%?`(()?)

;; 1-syntax.watsup:120.1-121.16
syntax limits = `[%..%]`(u32, u32)

;; 1-syntax.watsup:122.1-123.14
syntax globaltype = `%%`(mut, valtype)

;; 1-syntax.watsup:124.1-125.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:126.1-127.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:128.1-129.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:130.1-131.10
syntax elemtype = reftype

;; 1-syntax.watsup:132.1-133.5
syntax datatype = OK

;; 1-syntax.watsup:134.1-135.70
syntax externtype =
  | FUNC(functype)
  | GLOBAL(globaltype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:147.1-147.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:149.1-149.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:150.1-150.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:152.1-154.66
syntax binop_IXX =
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

;; 1-syntax.watsup:155.1-155.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:157.1-157.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:158.1-158.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:160.1-161.112
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:162.1-162.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:164.1-164.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:165.1-165.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:166.1-166.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:167.1-167.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:168.1-168.53
syntax cvtop =
  | CONVERT
  | REINTERPRET
  | CONVERT_SAT

;; 1-syntax.watsup:176.1-176.68
syntax memop = {ALIGN u32, OFFSET u32}

;; 1-syntax.watsup:184.1-184.23
syntax c_numtype = nat

;; 1-syntax.watsup:185.1-185.23
syntax c_vectype = nat

;; 1-syntax.watsup:188.1-190.17
syntax blocktype =
  | _RESULT(valtype?)
  | _IDX(funcidx)

;; 1-syntax.watsup:248.1-256.80
rec {

;; 1-syntax.watsup:248.1-256.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
}

;; 1-syntax.watsup:258.1-259.9
syntax expr = instr*

;; 1-syntax.watsup:269.1-269.61
syntax elemmode =
  | ACTIVE(tableidx, expr)
  | PASSIVE
  | DECLARE

;; 1-syntax.watsup:270.1-270.49
syntax datamode =
  | ACTIVE(memidx, expr)
  | PASSIVE

;; 1-syntax.watsup:272.1-273.16
syntax type = TYPE(functype)

;; 1-syntax.watsup:274.1-275.16
syntax local = LOCAL(valtype)

;; 1-syntax.watsup:276.1-277.27
syntax func = `FUNC%%*%`(typeidx, local*, expr)

;; 1-syntax.watsup:278.1-279.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:280.1-281.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:282.1-283.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:284.1-285.30
syntax elem = `ELEM%%*%`(reftype, expr*, elemmode)

;; 1-syntax.watsup:286.1-287.22
syntax data = `DATA%*%`(byte*, datamode)

;; 1-syntax.watsup:288.1-289.16
syntax start = START(funcidx)

;; 1-syntax.watsup:291.1-292.66
syntax externidx =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:293.1-294.24
syntax export = EXPORT(name, externidx)

;; 1-syntax.watsup:295.1-296.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:298.1-299.76
syntax module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*, import*, func*, global*, table*, mem*, elem*, data*, start*, export*)

;; 2-aux.watsup:7.1-7.14
def Ki : nat
  ;; 2-aux.watsup:8.1-8.15
  def Ki = 1024

;; 2-aux.watsup:13.1-13.25
rec {

;; 2-aux.watsup:13.1-13.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:14.1-14.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:15.1-15.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:16.1-16.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:18.1-18.21
rec {

;; 2-aux.watsup:18.1-18.21
def sum : nat* -> nat
  ;; 2-aux.watsup:19.1-19.22
  def sum([]) = 0
  ;; 2-aux.watsup:20.1-20.35
  def {n : n, n'* : n*} sum([n] :: n'*{n'}) = (n + $sum(n'*{n'}))
}

;; 2-aux.watsup:31.1-31.55
def size : valtype -> nat?
  ;; 2-aux.watsup:32.1-32.20
  def size(I32_valtype) = ?(32)
  ;; 2-aux.watsup:33.1-33.20
  def size(I64_valtype) = ?(64)
  ;; 2-aux.watsup:34.1-34.20
  def size(F32_valtype) = ?(32)
  ;; 2-aux.watsup:35.1-35.20
  def size(F64_valtype) = ?(64)
  ;; 2-aux.watsup:36.1-36.22
  def size(V128_valtype) = ?(128)
  def {x : valtype} size(x) = ?()

;; 2-aux.watsup:43.1-43.57
def signed : (nat, nat) -> int
  ;; 2-aux.watsup:44.1-44.54
  def {N : nat, i : nat} signed(N, i) = (i <: int)
    -- if (0 <= (2 ^ (N - 1)))
  ;; 2-aux.watsup:45.1-45.60
  def {N : nat, i : nat} signed(N, i) = ((i - (2 ^ N)) <: int)
    -- if (((2 ^ (N - 1)) <= i) /\ (i < (2 ^ N)))

;; 2-aux.watsup:47.1-47.63
def invsigned : (nat, int) -> nat
  ;; 2-aux.watsup:48.1-48.56
  def {N : nat, i : nat, j : nat} invsigned(N, (i <: int)) = j
    -- if ($signed(N, j) = (i <: int))

;; 2-aux.watsup:55.1-55.33
def memop0 : memop
  ;; 2-aux.watsup:56.1-56.34
  def memop0 = {ALIGN 0, OFFSET 0}

;; 2-aux.watsup:61.1-61.68
def free_dataidx_instr : instr -> dataidx*
  ;; 2-aux.watsup:62.1-62.43
  def {x : idx} free_dataidx_instr(MEMORY.INIT_instr(x)) = [x]
  ;; 2-aux.watsup:63.1-63.41
  def {x : idx} free_dataidx_instr(DATA.DROP_instr(x)) = [x]
  ;; 2-aux.watsup:64.1-64.38
  def {in : instr} free_dataidx_instr(in) = []

;; 2-aux.watsup:66.1-66.70
rec {

;; 2-aux.watsup:66.1-66.70
def free_dataidx_instrs : instr* -> dataidx*
  ;; 2-aux.watsup:67.1-67.44
  def free_dataidx_instrs([]) = []
  ;; 2-aux.watsup:68.1-68.99
  def {instr : instr, instr'* : instr*} free_dataidx_instrs([instr] :: instr'*{instr'}) = $free_dataidx_instr(instr) :: $free_dataidx_instrs(instr'*{instr'})
}

;; 2-aux.watsup:70.1-70.66
def free_dataidx_expr : expr -> dataidx*
  ;; 2-aux.watsup:71.1-71.56
  def {in* : instr*} free_dataidx_expr(in*{in}) = $free_dataidx_instrs(in*{in})

;; 2-aux.watsup:73.1-73.66
def free_dataidx_func : func -> dataidx*
  ;; 2-aux.watsup:74.1-74.62
  def {e : expr, loc* : local*, x : idx} free_dataidx_func(`FUNC%%*%`(x, loc*{loc}, e)) = $free_dataidx_expr(e)

;; 2-aux.watsup:76.1-76.68
rec {

;; 2-aux.watsup:76.1-76.68
def free_dataidx_funcs : func* -> dataidx*
  ;; 2-aux.watsup:77.1-77.43
  def free_dataidx_funcs([]) = []
  ;; 2-aux.watsup:78.1-78.92
  def {func : func, func'* : func*} free_dataidx_funcs([func] :: func'*{func'}) = $free_dataidx_func(func) :: $free_dataidx_funcs(func'*{func'})
}

;; 2-aux.watsup:86.1-86.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:87.1-87.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:89.1-89.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:90.1-90.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:92.1-101.43
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

;; 3-typing.watsup:5.1-8.60
syntax context = {TYPE functype*, FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:18.1-18.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:26.1-28.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%]`(n_1, n_2), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:19.1-19.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:30.1-31.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:20.1-20.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:33.1-34.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:21.1-21.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:36.1-38.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:22.1-22.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:40.1-42.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:23.1-23.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:45.1-47.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:49.1-51.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:53.1-55.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:57.1-59.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:69.1-69.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:72.1-73.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:75.1-76.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:70.1-70.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:78.1-80.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- if (|t_1*{t_1}| = |t_2*{t_2}|)
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:85.1-85.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:93.1-96.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%]`(n_11, n_12), `[%..%]`(n_21, n_22))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:86.1-86.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:98.1-99.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:87.1-87.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:101.1-102.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:88.1-88.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:104.1-106.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:89.1-89.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:108.1-110.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:90.1-90.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:113.1-115.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:117.1-119.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:121.1-123.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:125.1-127.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:192.1-192.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:194.1-195.44
  rule void {C : context}:
    `%|-%:%`(C, _RESULT_blocktype(?()), `%->%`([], []))

  ;; 3-typing.watsup:197.1-198.32
  rule result {C : context, t : valtype}:
    `%|-%:%`(C, _RESULT_blocktype(?(t)), `%->%`([], [t]))

  ;; 3-typing.watsup:200.1-202.23
  rule typeidx {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, _IDX_blocktype(x), ft)
    -- if (x < |C.TYPE_context|)
    -- if (C.TYPE_context[x] = ft)

;; 3-typing.watsup:135.1-136.67
rec {

;; 3-typing.watsup:135.1-135.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:171.1-172.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:174.1-175.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:177.1-178.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:181.1-182.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?([t])), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:184.1-187.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = $valtype_numtype(numtype)) \/ (t' = $valtype_vectype(vectype)))

  ;; 3-typing.watsup:205.1-208.59
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:210.1-213.59
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1*{t_1}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:215.1-219.61
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:224.1-226.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (l < |C.LABEL_context|)
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:228.1-230.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (l < |C.LABEL_context|)
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:232.1-235.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (if (l < |C.LABEL_context|))*{l}
    -- if (l' < |C.LABEL_context|)
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:240.1-242.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 3-typing.watsup:244.1-246.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:248.1-251.33
  rule call_indirect {C : context, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, y), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (x < |C.TABLE_context|)
    -- if (y < |C.TYPE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (C.TYPE_context[y] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:256.1-257.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:259.1-260.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:262.1-263.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:265.1-266.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([$valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-269.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:272.1-274.23
  rule extend {C : context, n : n, nt : numtype, o0 : nat}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (n <= o0)

  ;; 3-typing.watsup:276.1-279.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([$valtype_numtype(nt_2)], [$valtype_numtype(nt_1)]))
    -- if ($size($valtype_numtype(nt_1)) = ?(o0))
    -- if ($size($valtype_numtype(nt_2)) = ?(o1))
    -- if (nt_1 =/= nt_2)
    -- if (o0 = o1)

  ;; 3-typing.watsup:281.1-284.54
  rule convert-i {C : context, inn_1 : inn, inn_2 : inn, sx? : sx?, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr($numtype_inn(inn_1), CONVERT_cvtop, $numtype_inn(inn_2), sx?{sx}), `%->%`([$valtype_inn(inn_2)], [$valtype_inn(inn_1)]))
    -- if ($size($valtype_inn(inn_1)) = ?(o0))
    -- if ($size($valtype_inn(inn_2)) = ?(o1))
    -- if (inn_1 =/= inn_2)
    -- if ((sx?{sx} = ?()) <=> (o0 > o1))

  ;; 3-typing.watsup:286.1-288.24
  rule convert-f {C : context, fnn_1 : fnn, fnn_2 : fnn}:
    `%|-%:%`(C, CVTOP_instr($numtype_fnn(fnn_1), CONVERT_cvtop, $numtype_fnn(fnn_2), ?()), `%->%`([$valtype_fnn(fnn_2)], [$valtype_fnn(fnn_1)]))
    -- if (fnn_1 =/= fnn_2)

  ;; 3-typing.watsup:293.1-294.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [$valtype_reftype(rt)]))

  ;; 3-typing.watsup:296.1-298.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:300.1-301.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([$valtype_reftype(rt)], [I32_valtype]))

  ;; 3-typing.watsup:306.1-308.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (x < |C.LOCAL_context|)
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:310.1-312.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (x < |C.LOCAL_context|)
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:314.1-316.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (x < |C.LOCAL_context|)
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:321.1-323.28
  rule global.get {C : context, mut : mut, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = `%%`(mut, t))

  ;; 3-typing.watsup:325.1-327.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?(())), t))

  ;; 3-typing.watsup:332.1-334.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [$valtype_reftype(rt)]))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:336.1-338.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype $valtype_reftype(rt)], []))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:340.1-342.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:344.1-346.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([$valtype_reftype(rt) I32_valtype], [I32_valtype]))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:348.1-350.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype $valtype_reftype(rt) I32_valtype], []))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:352.1-355.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (x_1 < |C.TABLE_context|)
    -- if (x_2 < |C.TABLE_context|)
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:357.1-360.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (x_1 < |C.TABLE_context|)
    -- if (x_2 < |C.ELEM_context|)
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:362.1-364.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (x < |C.ELEM_context|)
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:369.1-371.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:373.1-375.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:377.1-379.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:381.1-383.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:385.1-388.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (0 < |C.MEM_context|)
    -- if (x < |C.DATA_context|)
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:390.1-392.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (x < |C.DATA_context|)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:394.1-399.33
  rule load {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [$valtype_numtype(nt)]))
    -- if (0 < |C.MEM_context|)
    -- if ((n?{n} = ?()) <=> (o1?{o1} = ?()))
    -- if ((n?{n} = ?()) <=> (sx?{sx} = ?()))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- (if ($size($valtype_numtype(nt)) = ?(o1)))?{o1}
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_inn(inn)))

  ;; 3-typing.watsup:401.1-406.33
  rule store {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype $valtype_numtype(nt)], []))
    -- if (0 < |C.MEM_context|)
    -- if ((n?{n} = ?()) <=> (o1?{o1} = ?()))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- (if ($size($valtype_numtype(nt)) = ?(o1)))?{o1}
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_inn(inn)))

;; 3-typing.watsup:136.1-136.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:149.1-150.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:152.1-155.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:157.1-162.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:164.1-166.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:137.1-137.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:142.1-144.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:413.1-413.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:417.1-418.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:420.1-421.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:423.1-424.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:426.1-428.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?()), t))

;; 3-typing.watsup:414.1-414.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:431.1-432.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:415.1-415.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:435.1-438.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:445.1-445.73
relation Type_ok: `|-%:%`(type, functype)
  ;; 3-typing.watsup:459.1-461.29
  rule _ {ft : functype}:
    `|-%:%`(TYPE(ft), ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:446.1-446.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:463.1-467.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, `FUNC%%*%`(x, LOCAL(t)*{t}, expr), ft)
    -- if (x < |C.TYPE_context|)
    -- if (C.TYPE_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:447.1-447.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:469.1-473.40
  rule _ {C : context, expr : expr, gt : globaltype, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `%%`(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:448.1-448.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:475.1-477.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:449.1-449.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:479.1-481.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:452.1-452.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:492.1-495.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:497.1-498.20
  rule passive {C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; 3-typing.watsup:500.1-501.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:450.1-450.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:483.1-486.37
  rule _ {C : context, elemmode : elemmode, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%`(rt, expr*{expr}, elemmode), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [$valtype_reftype(rt)]))*{expr}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, rt)

;; 3-typing.watsup:453.1-453.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:503.1-506.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, ACTIVE_datamode(0, expr))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:508.1-509.20
  rule passive {C : context}:
    `%|-%:OK`(C, PASSIVE_datamode)

;; 3-typing.watsup:451.1-451.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:488.1-490.37
  rule _ {C : context, b* : byte*, datamode : datamode}:
    `%|-%:OK`(C, `DATA%*%`(b*{b}, datamode))
    -- Datamode_ok: `%|-%:OK`(C, datamode)

;; 3-typing.watsup:454.1-454.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:511.1-513.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:518.1-518.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:522.1-524.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:520.1-520.83
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; 3-typing.watsup:531.1-533.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype(ft))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:535.1-537.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:539.1-541.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:543.1-545.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (x < |C.MEM_context|)
    -- if (C.MEM_context[x] = mt)

;; 3-typing.watsup:519.1-519.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:526.1-528.39
  rule _ {C : context, externidx : externidx, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externidx), xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 3-typing.watsup:550.1-550.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:552.1-567.20
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, ft'* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*, type* : type*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (|ft'*{ft'}| = |type*{type}|)
    -- if (|ft*{ft}| = |func*{func}|)
    -- if (|global*{global}| = |gt*{gt}|)
    -- if (|table*{table}| = |tt*{tt}|)
    -- if (|mem*{mem}| = |mt*{mt}|)
    -- if (|elem*{elem}| = |rt*{rt}|)
    -- if (C = {TYPE ft'*{ft'}, FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Type_ok: `|-%:%`(type, ft'))*{ft' type}
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

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

;; 4-runtime.watsup:30.1-31.28
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:32.1-33.71
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:34.1-35.14
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:37.1-38.22
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:47.1-48.70
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:55.1-55.44
def default_ : valtype -> val?
  ;; 4-runtime.watsup:56.1-56.35
  def default_(I32_valtype) = ?(CONST_val(I32_numtype, 0))
  ;; 4-runtime.watsup:57.1-57.35
  def default_(I64_valtype) = ?(CONST_val(I64_numtype, 0))
  ;; 4-runtime.watsup:58.1-58.35
  def default_(F32_valtype) = ?(CONST_val(F32_numtype, 0))
  ;; 4-runtime.watsup:59.1-59.35
  def default_(F64_valtype) = ?(CONST_val(F64_numtype, 0))
  ;; 4-runtime.watsup:60.1-60.44
  def default_(FUNCREF_valtype) = ?(REF.NULL_val(FUNCREF_reftype))
  ;; 4-runtime.watsup:61.1-61.48
  def default_(EXTERNREF_valtype) = ?(REF.NULL_val(EXTERNREF_reftype))
  def {x : valtype} default_(x) = ?()

;; 4-runtime.watsup:88.1-90.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:92.1-100.25
syntax moduleinst = {TYPE functype*, FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:70.1-73.16
syntax funcinst = {TYPE functype, MODULE moduleinst, CODE func}

;; 4-runtime.watsup:74.1-76.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:77.1-79.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:80.1-82.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:83.1-85.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:86.1-87.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:114.1-120.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:122.1-124.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:126.1-126.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:213.1-220.9
rec {

;; 4-runtime.watsup:213.1-220.9
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | CALL_ADDR(funcaddr)
  | LABEL_(n, instr*, admininstr*)
  | FRAME_(n, frame, admininstr*)
  | TRAP
}

def admininstr_instr : instr -> admininstr
  def admininstr_instr(UNREACHABLE_instr) = UNREACHABLE_admininstr
  def admininstr_instr(NOP_instr) = NOP_admininstr
  def admininstr_instr(DROP_instr) = DROP_admininstr
  def {x : valtype*?} admininstr_instr(SELECT_instr(x)) = SELECT_admininstr(x)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(BLOCK_instr(x0, x1)) = BLOCK_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(LOOP_instr(x0, x1)) = LOOP_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*, x2 : instr*} admininstr_instr(IF_instr(x0, x1, x2)) = IF_admininstr(x0, x1, x2)
  def {x : labelidx} admininstr_instr(BR_instr(x)) = BR_admininstr(x)
  def {x : labelidx} admininstr_instr(BR_IF_instr(x)) = BR_IF_admininstr(x)
  def {x0 : labelidx*, x1 : labelidx} admininstr_instr(BR_TABLE_instr(x0, x1)) = BR_TABLE_admininstr(x0, x1)
  def {x : funcidx} admininstr_instr(CALL_instr(x)) = CALL_admininstr(x)
  def {x0 : tableidx, x1 : typeidx} admininstr_instr(CALL_INDIRECT_instr(x0, x1)) = CALL_INDIRECT_admininstr(x0, x1)
  def admininstr_instr(RETURN_instr) = RETURN_admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_instr(CONST_instr(x0, x1)) = CONST_admininstr(x0, x1)
  def {x0 : numtype, x1 : unop_numtype} admininstr_instr(UNOP_instr(x0, x1)) = UNOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : binop_numtype} admininstr_instr(BINOP_instr(x0, x1)) = BINOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : testop_numtype} admininstr_instr(TESTOP_instr(x0, x1)) = TESTOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : relop_numtype} admininstr_instr(RELOP_instr(x0, x1)) = RELOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : n} admininstr_instr(EXTEND_instr(x0, x1)) = EXTEND_admininstr(x0, x1)
  def {x0 : numtype, x1 : cvtop, x2 : numtype, x3 : sx?} admininstr_instr(CVTOP_instr(x0, x1, x2, x3)) = CVTOP_admininstr(x0, x1, x2, x3)
  def {x : reftype} admininstr_instr(REF.NULL_instr(x)) = REF.NULL_admininstr(x)
  def {x : funcidx} admininstr_instr(REF.FUNC_instr(x)) = REF.FUNC_admininstr(x)
  def admininstr_instr(REF.IS_NULL_instr) = REF.IS_NULL_admininstr
  def {x : localidx} admininstr_instr(LOCAL.GET_instr(x)) = LOCAL.GET_admininstr(x)
  def {x : localidx} admininstr_instr(LOCAL.SET_instr(x)) = LOCAL.SET_admininstr(x)
  def {x : localidx} admininstr_instr(LOCAL.TEE_instr(x)) = LOCAL.TEE_admininstr(x)
  def {x : globalidx} admininstr_instr(GLOBAL.GET_instr(x)) = GLOBAL.GET_admininstr(x)
  def {x : globalidx} admininstr_instr(GLOBAL.SET_instr(x)) = GLOBAL.SET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.GET_instr(x)) = TABLE.GET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.SET_instr(x)) = TABLE.SET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.SIZE_instr(x)) = TABLE.SIZE_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.GROW_instr(x)) = TABLE.GROW_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.FILL_instr(x)) = TABLE.FILL_admininstr(x)
  def {x0 : tableidx, x1 : tableidx} admininstr_instr(TABLE.COPY_instr(x0, x1)) = TABLE.COPY_admininstr(x0, x1)
  def {x0 : tableidx, x1 : elemidx} admininstr_instr(TABLE.INIT_instr(x0, x1)) = TABLE.INIT_admininstr(x0, x1)
  def {x : elemidx} admininstr_instr(ELEM.DROP_instr(x)) = ELEM.DROP_admininstr(x)
  def admininstr_instr(MEMORY.SIZE_instr) = MEMORY.SIZE_admininstr
  def admininstr_instr(MEMORY.GROW_instr) = MEMORY.GROW_admininstr
  def admininstr_instr(MEMORY.FILL_instr) = MEMORY.FILL_admininstr
  def admininstr_instr(MEMORY.COPY_instr) = MEMORY.COPY_admininstr
  def {x : dataidx} admininstr_instr(MEMORY.INIT_instr(x)) = MEMORY.INIT_admininstr(x)
  def {x : dataidx} admininstr_instr(DATA.DROP_instr(x)) = DATA.DROP_admininstr(x)
  def {x0 : numtype, x1 : (n, sx)?, x2 : memop} admininstr_instr(LOAD_instr(x0, x1, x2)) = LOAD_admininstr(x0, x1, x2)
  def {x0 : numtype, x1 : n?, x2 : memop} admininstr_instr(STORE_instr(x0, x1, x2)) = STORE_admininstr(x0, x1, x2)

def admininstr_ref : ref -> admininstr
  def {x : reftype} admininstr_ref(REF.NULL_ref(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_ref(REF.FUNC_ADDR_ref(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_ref(REF.HOST_ADDR_ref(x)) = REF.HOST_ADDR_admininstr(x)

def admininstr_val : val -> admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_val(CONST_val(x0, x1)) = CONST_admininstr(x0, x1)
  def {x : reftype} admininstr_val(REF.NULL_val(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_val(REF.FUNC_ADDR_val(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_val(REF.HOST_ADDR_val(x)) = REF.HOST_ADDR_admininstr(x)

;; 4-runtime.watsup:127.1-127.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:136.1-136.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:137.1-137.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:139.1-139.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:146.1-146.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:140.1-140.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:147.1-147.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:141.1-141.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:148.1-148.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:142.1-142.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:149.1-149.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:143.1-143.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:150.1-150.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:144.1-144.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:151.1-151.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:153.1-153.67
def type : (state, typeidx) -> functype
  ;; 4-runtime.watsup:162.1-162.40
  def {f : frame, s : store, x : idx} type(`%;%`(s, f), x) = f.MODULE_frame.TYPE_moduleinst[x]

;; 4-runtime.watsup:154.1-154.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:163.1-163.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:155.1-155.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:164.1-164.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:156.1-156.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:165.1-165.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:157.1-157.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:166.1-166.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:158.1-158.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:167.1-167.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:159.1-159.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:168.1-168.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:160.1-160.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:169.1-169.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:172.1-172.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:181.1-181.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:173.1-173.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:182.1-182.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:174.1-174.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:183.1-183.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:175.1-175.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:184.1-184.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:176.1-176.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:185.1-185.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:177.1-177.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:186.1-186.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:178.1-178.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:187.1-187.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:179.1-179.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:188.1-188.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:193.1-193.63
def grow_table : (tableinst, nat, ref) -> tableinst?
  ;; 4-runtime.watsup:196.1-200.36
  def {i : nat, i' : nat, j : nat, n : n, r : ref, r'* : ref*, rt : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ?(ti')
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%]`(i', j), rt), ELEM r'*{r'} :: r^n{}})
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)
  def {x : (tableinst, nat, ref)} grow_table(x) = ?()

;; 4-runtime.watsup:194.1-194.55
def grow_memory : (meminst, nat) -> meminst?
  ;; 4-runtime.watsup:202.1-206.34
  def {b* : byte*, i : nat, i' : nat, j : nat, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = ?(mi')
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%]`(i', j)), DATA b*{b} :: 0^((n * 64) * $Ki){}})
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)
  def {x : (meminst, nat)} grow_memory(x) = ?()

;; 4-runtime.watsup:222.1-225.25
rec {

;; 4-runtime.watsup:222.1-225.25
syntax E =
  | _HOLE
  | _SEQ(val*, E, instr*)
  | LABEL_(n, instr*, E)
}

;; 5-numerics.watsup:3.1-3.79
def unop : (unop_numtype, numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:4.1-4.80
def binop : (binop_numtype, numtype, c_numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:5.1-5.79
def testop : (testop_numtype, numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:6.1-6.80
def relop : (relop_numtype, numtype, c_numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:8.1-8.84
def ext : (nat, nat, sx, c_numtype) -> c_numtype

;; 5-numerics.watsup:9.1-9.84
def cvtop : (numtype, cvtop, numtype, sx?, c_numtype) -> c_numtype*

;; 5-numerics.watsup:11.1-11.32
def wrap_ : ((nat, nat), c_numtype) -> nat

;; 5-numerics.watsup:13.1-13.60
def ibytes : (nat, iN) -> byte*

;; 5-numerics.watsup:14.1-14.60
def fbytes : (nat, fN) -> byte*

;; 5-numerics.watsup:15.1-15.58
def ntbytes : (numtype, c_numtype) -> byte*

;; 5-numerics.watsup:17.1-17.30
def invibytes : (nat, byte*) -> iN
  ;; 5-numerics.watsup:20.1-20.52
  def {N : nat, b* : byte*, n : n} invibytes(N, b*{b}) = n
    -- if ($ibytes(N, n) = b*{b})

;; 5-numerics.watsup:18.1-18.30
def invfbytes : (nat, byte*) -> fN
  ;; 5-numerics.watsup:21.1-21.52
  def {N : nat, b* : byte*, p : fN} invfbytes(N, b*{b}) = p
    -- if ($fbytes(N, p) = b*{b})

;; 6-reduction.watsup:6.1-6.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:24.1-25.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:27.1-28.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:30.1-31.24
  rule drop {val : val}:
    `%*~>%*`([$admininstr_val(val) DROP_admininstr], [])

  ;; 6-reduction.watsup:34.1-36.16
  rule select-true {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [$admininstr_val(val_1)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:38.1-40.14
  rule select-false {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [$admininstr_val(val_2)])
    -- if (c = 0)

  ;; 6-reduction.watsup:58.1-60.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:62.1-64.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:67.1-68.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, $admininstr_val(val)*{val})], $admininstr_val(val)*{val})

  ;; 6-reduction.watsup:74.1-75.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [BR_admininstr(0)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val} :: $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:77.1-78.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val)*{val} :: [BR_admininstr(l + 1)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:81.1-83.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:85.1-87.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:90.1-92.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:94.1-96.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:121.1-122.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val)^n{val})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:124.1-125.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:127.1-128.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, $admininstr_val(val)*{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:133.1-135.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 6-reduction.watsup:137.1-139.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:142.1-144.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 6-reduction.watsup:146.1-148.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:151.1-153.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 6-reduction.watsup:155.1-157.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 6-reduction.watsup:160.1-161.70
  rule extend {c : c_numtype, n : n, nt : numtype, o0 : nat}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, o0, S_sx, c))])
    -- if ($size($valtype_numtype(nt)) = ?(o0))

  ;; 6-reduction.watsup:164.1-166.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [c])

  ;; 6-reduction.watsup:168.1-170.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:179.1-181.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(rt))

  ;; 6-reduction.watsup:183.1-185.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:196.1-197.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([$admininstr_val(val) LOCAL.TEE_admininstr(x)], [$admininstr_val(val) $admininstr_val(val) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:45.1-45.73
def blocktype : (state, blocktype) -> functype
  ;; 6-reduction.watsup:46.1-46.56
  def {z : state} blocktype(z, _RESULT_blocktype(?())) = `%->%`([], [])
  ;; 6-reduction.watsup:47.1-47.44
  def {t : valtype, z : state} blocktype(z, _RESULT_blocktype(?(t))) = `%->%`([], [t])
  ;; 6-reduction.watsup:48.1-48.40
  def {x : idx, z : state} blocktype(z, _IDX_blocktype(x)) = $type(z, x)

;; 6-reduction.watsup:7.1-7.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:50.1-52.43
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})]), [LABEL__admininstr(n, [], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:54.1-56.43
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [LOOP_admininstr(bt, instr*{instr})]), [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if ($blocktype(z, bt) = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:101.1-102.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])
    -- if (x < |$funcaddr(z)|)

  ;; 6-reduction.watsup:104.1-108.35
  rule call_indirect-call {a : addr, i : nat, instr* : instr*, t* : valtype*, x : idx, y : idx, y' : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [CALL_ADDR_admininstr(a)])
    -- if (i < |$table(z, x).ELEM_tableinst|)
    -- if (a < |$funcinst(z)|)
    -- if ($table(z, x).ELEM_tableinst[i] = REF.FUNC_ADDR_ref(a))
    -- if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(y', LOCAL(t)*{t}, instr*{instr}))
    -- if ($type(z, y) = $type(z, y'))

  ;; 6-reduction.watsup:110.1-112.15
  rule call_indirect-trap {i : nat, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:114.1-118.53
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, mm : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, x : idx, z : state, o0* : val*}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], $admininstr_instr(instr)*{instr})])])
    -- if (|t*{t}| = |o0*{o0}|)
    -- if (a < |$funcinst(z)|)
    -- (if ($default_(t) = ?(o0)))*{t o0}
    -- if ($funcinst(z)[a] = {TYPE `%->%`(t_1^k{t_1}, t_2^n{t_2}), MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, LOCAL(t)*{t}, instr*{instr}))
    -- if (f = {LOCAL val^k{val} :: o0*{o0}, MODULE mm})

  ;; 6-reduction.watsup:175.1-176.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])
    -- if (x < |$funcaddr(z)|)

  ;; 6-reduction.watsup:190.1-191.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [$admininstr_val($local(z, x))])

  ;; 6-reduction.watsup:202.1-203.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [$admininstr_val($global(z, x).VALUE_globalinst)])

  ;; 6-reduction.watsup:211.1-213.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:215.1-217.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [$admininstr_ref($table(z, x).ELEM_tableinst[i])])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:228.1-230.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 6-reduction.watsup:241.1-243.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:245.1-248.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:250.1-254.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:257.1-259.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:261.1-264.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:266.1-271.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:273.1-277.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:280.1-282.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:284.1-287.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:289.1-293.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) $admininstr_ref($elem(z, y).ELEM_eleminst[i]) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- if (i < |$elem(z, y).ELEM_eleminst|)
    -- otherwise

  ;; 6-reduction.watsup:302.1-304.59
  rule load-num-trap {i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [TRAP_admininstr])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (((i + mo.OFFSET_memop) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:306.1-308.71
  rule load-num-val {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [CONST_admininstr(nt, c)])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if ($ntbytes(nt, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (o0 / 8)])

  ;; 6-reduction.watsup:310.1-312.51
  rule load-pack-trap {i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:314.1-316.61
  rule load-pack-val {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [CONST_admininstr(nt, $ext(n, o0, sx, c))])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if ($ibytes(n, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])

  ;; 6-reduction.watsup:336.1-338.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:349.1-351.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:353.1-356.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:358.1-362.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:365.1-367.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:369.1-372.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:374.1-379.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:381.1-385.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:388.1-390.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:392.1-395.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:397.1-401.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- if (i < |$data(z, x).DATA_datainst|)
    -- otherwise

;; 6-reduction.watsup:5.1-5.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:9.1-11.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_pure: `%*~>%*`($admininstr_instr(instr)*{instr}, $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:13.1-15.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, $admininstr_instr(instr)*{instr}), $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:193.1-194.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:205.1-206.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:219.1-221.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:223.1-225.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:233.1-235.47
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, x : idx, z : state, o0 : tableinst}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if ($grow_table($table(z, x), n, ref) = ?(o0))
    -- if (o0 = ti)

  ;; 6-reduction.watsup:237.1-238.80
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:296.1-297.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:319.1-321.59
  rule store-num-trap {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (((i + mo.OFFSET_memop) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:323.1-325.29
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), (o0 / 8), b*{b}), []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (b*{b} = $ntbytes(nt, c))

  ;; 6-reduction.watsup:327.1-329.51
  rule store-pack-trap {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:331.1-333.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), (n / 8), b*{b}), []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (b*{b} = $ibytes(n, $wrap_((o0, n), c)))

  ;; 6-reduction.watsup:341.1-343.41
  rule memory.grow-succeed {mi : meminst, n : n, z : state, o0 : meminst}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- if ($grow_memory($mem(z, 0), n) = ?(o0))
    -- if (o0 = mi)

  ;; 6-reduction.watsup:345.1-346.75
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:404.1-405.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:5.1-5.35
rec {

;; 7-module.watsup:5.1-5.35
def funcs : externval* -> funcaddr*
  ;; 7-module.watsup:6.1-6.30
  def funcs([]) = []
  ;; 7-module.watsup:7.1-7.59
  def {externval'* : externval*, fa : funcaddr} funcs([FUNC_externval(fa)] :: externval'*{externval'}) = [fa] :: $funcs(externval'*{externval'})
  ;; 7-module.watsup:8.1-9.15
  def {externval : externval, externval'* : externval*} funcs([externval] :: externval'*{externval'}) = $funcs(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:11.1-11.39
rec {

;; 7-module.watsup:11.1-11.39
def globals : externval* -> globaladdr*
  ;; 7-module.watsup:12.1-12.32
  def globals([]) = []
  ;; 7-module.watsup:13.1-13.65
  def {externval'* : externval*, ga : globaladdr} globals([GLOBAL_externval(ga)] :: externval'*{externval'}) = [ga] :: $globals(externval'*{externval'})
  ;; 7-module.watsup:14.1-15.15
  def {externval : externval, externval'* : externval*} globals([externval] :: externval'*{externval'}) = $globals(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:17.1-17.37
rec {

;; 7-module.watsup:17.1-17.37
def tables : externval* -> tableaddr*
  ;; 7-module.watsup:18.1-18.31
  def tables([]) = []
  ;; 7-module.watsup:19.1-19.62
  def {externval'* : externval*, ta : tableaddr} tables([TABLE_externval(ta)] :: externval'*{externval'}) = [ta] :: $tables(externval'*{externval'})
  ;; 7-module.watsup:20.1-21.15
  def {externval : externval, externval'* : externval*} tables([externval] :: externval'*{externval'}) = $tables(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:23.1-23.33
rec {

;; 7-module.watsup:23.1-23.33
def mems : externval* -> memaddr*
  ;; 7-module.watsup:24.1-24.29
  def mems([]) = []
  ;; 7-module.watsup:25.1-25.56
  def {externval'* : externval*, ma : memaddr} mems([MEM_externval(ma)] :: externval'*{externval'}) = [ma] :: $mems(externval'*{externval'})
  ;; 7-module.watsup:26.1-27.15
  def {externval : externval, externval'* : externval*} mems([externval] :: externval'*{externval'}) = $mems(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:36.1-36.60
def allocfunc : (store, moduleinst, func) -> (store, funcaddr)
  ;; 7-module.watsup:37.1-39.34
  def {expr : expr, fi : funcinst, func : func, local* : local*, mm : moduleinst, s : store, x : idx} allocfunc(s, mm, func) = (s[FUNC_store =.. [fi]], |s.FUNC_store|)
    -- if (fi = {TYPE mm.TYPE_moduleinst[x], MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, local*{local}, expr))

;; 7-module.watsup:41.1-41.63
rec {

;; 7-module.watsup:41.1-41.63
def allocfuncs : (store, moduleinst, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:42.1-42.47
  def {mm : moduleinst, s : store} allocfuncs(s, mm, []) = (s, [])
  ;; 7-module.watsup:43.1-45.51
  def {fa : funcaddr, fa'* : funcaddr*, func : func, func'* : func*, mm : moduleinst, s : store, s_1 : store, s_2 : store} allocfuncs(s, mm, [func] :: func'*{func'}) = (s_2, [fa] :: fa'*{fa'})
    -- if ((s_1, fa) = $allocfunc(s, mm, func))
    -- if ((s_2, fa'*{fa'}) = $allocfuncs(s_1, mm, func'*{func'}))
}

;; 7-module.watsup:47.1-47.63
def allocglobal : (store, globaltype, val) -> (store, globaladdr)
  ;; 7-module.watsup:48.1-49.44
  def {gi : globalinst, globaltype : globaltype, s : store, val : val} allocglobal(s, globaltype, val) = (s[GLOBAL_store =.. [gi]], |s.GLOBAL_store|)
    -- if (gi = {TYPE globaltype, VALUE val})

;; 7-module.watsup:51.1-51.67
rec {

;; 7-module.watsup:51.1-51.67
def allocglobals : (store, globaltype*, val*) -> (store, globaladdr*)
  ;; 7-module.watsup:52.1-52.54
  def {s : store} allocglobals(s, [], []) = (s, [])
  ;; 7-module.watsup:53.1-55.62
  def {ga : globaladdr, ga'* : globaladdr*, globaltype : globaltype, globaltype'* : globaltype*, s : store, s_1 : store, s_2 : store, val : val, val'* : val*} allocglobals(s, [globaltype] :: globaltype'*{globaltype'}, [val] :: val'*{val'}) = (s_2, [ga] :: ga'*{ga'})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga'}) = $allocglobals(s_1, globaltype'*{globaltype'}, val'*{val'}))
}

;; 7-module.watsup:57.1-57.55
def alloctable : (store, tabletype) -> (store, tableaddr)
  ;; 7-module.watsup:58.1-59.59
  def {i : nat, j : nat, rt : reftype, s : store, ti : tableinst} alloctable(s, `%%`(`[%..%]`(i, j), rt)) = (s[TABLE_store =.. [ti]], |s.TABLE_store|)
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM REF.NULL_ref(rt)^i{}})

;; 7-module.watsup:61.1-61.58
rec {

;; 7-module.watsup:61.1-61.58
def alloctables : (store, tabletype*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.44
  def {s : store} alloctables(s, []) = (s, [])
  ;; 7-module.watsup:63.1-65.53
  def {s : store, s_1 : store, s_2 : store, ta : tableaddr, ta'* : tableaddr*, tabletype : tabletype, tabletype'* : tabletype*} alloctables(s, [tabletype] :: tabletype'*{tabletype'}) = (s_2, [ta] :: ta'*{ta'})
    -- if ((s_1, ta) = $alloctable(s, tabletype))
    -- if ((s_2, ta'*{ta'}) = $alloctables(s_1, tabletype'*{tabletype'}))
}

;; 7-module.watsup:67.1-67.49
def allocmem : (store, memtype) -> (store, memaddr)
  ;; 7-module.watsup:68.1-69.62
  def {i : nat, j : nat, mi : meminst, s : store} allocmem(s, `%I8`(`[%..%]`(i, j))) = (s[MEM_store =.. [mi]], |s.MEM_store|)
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA 0^((i * 64) * $Ki){}})

;; 7-module.watsup:71.1-71.52
rec {

;; 7-module.watsup:71.1-71.52
def allocmems : (store, memtype*) -> (store, memaddr*)
  ;; 7-module.watsup:72.1-72.42
  def {s : store} allocmems(s, []) = (s, [])
  ;; 7-module.watsup:73.1-75.49
  def {ma : memaddr, ma'* : memaddr*, memtype : memtype, memtype'* : memtype*, s : store, s_1 : store, s_2 : store} allocmems(s, [memtype] :: memtype'*{memtype'}) = (s_2, [ma] :: ma'*{ma'})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma'}) = $allocmems(s_1, memtype'*{memtype'}))
}

;; 7-module.watsup:77.1-77.57
def allocelem : (store, reftype, ref*) -> (store, elemaddr)
  ;; 7-module.watsup:78.1-79.36
  def {ei : eleminst, ref* : ref*, rt : reftype, s : store} allocelem(s, rt, ref*{ref}) = (s[ELEM_store =.. [ei]], |s.ELEM_store|)
    -- if (ei = {TYPE rt, ELEM ref*{ref}})

;; 7-module.watsup:81.1-81.63
rec {

;; 7-module.watsup:81.1-81.63
def allocelems : (store, reftype*, ref**) -> (store, elemaddr*)
  ;; 7-module.watsup:82.1-82.52
  def {s : store} allocelems(s, [], []) = (s, [])
  ;; 7-module.watsup:83.1-85.55
  def {ea : elemaddr, ea'* : elemaddr*, ref* : ref*, ref'** : ref**, rt : reftype, rt'* : reftype*, s : store, s_1 : store, s_2 : store} allocelems(s, [rt] :: rt'*{rt'}, [ref*{ref}] :: ref'*{ref'}*{ref'}) = (s_2, [ea] :: ea'*{ea'})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref}))
    -- if ((s_2, ea'*{ea'}) = $allocelems(s_2, rt'*{rt'}, ref'*{ref'}*{ref'}))
}

;; 7-module.watsup:87.1-87.49
def allocdata : (store, byte*) -> (store, dataaddr)
  ;; 7-module.watsup:88.1-89.28
  def {byte* : byte*, di : datainst, s : store} allocdata(s, byte*{byte}) = (s[DATA_store =.. [di]], |s.DATA_store|)
    -- if (di = {DATA byte*{byte}})

;; 7-module.watsup:91.1-91.54
rec {

;; 7-module.watsup:91.1-91.54
def allocdatas : (store, byte**) -> (store, dataaddr*)
  ;; 7-module.watsup:92.1-92.43
  def {s : store} allocdatas(s, []) = (s, [])
  ;; 7-module.watsup:93.1-95.50
  def {byte* : byte*, byte'** : byte**, da : dataaddr, da'* : dataaddr*, s : store, s_1 : store, s_2 : store} allocdatas(s, [byte]*{byte} :: byte'*{byte'}*{byte'}) = (s_2, [da] :: da'*{da'})
    -- if ((s_1, da) = $allocdata(s, byte*{byte}))
    -- if ((s_2, da'*{da'}) = $allocdatas(s_1, byte'*{byte'}*{byte'}))
}

;; 7-module.watsup:100.1-100.83
def instexport : (funcaddr*, globaladdr*, tableaddr*, memaddr*, export) -> exportinst
  ;; 7-module.watsup:101.1-101.95
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, FUNC_externidx(x))) = {NAME name, VALUE FUNC_externval(fa*{fa}[x])}
  ;; 7-module.watsup:102.1-102.99
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, GLOBAL_externidx(x))) = {NAME name, VALUE GLOBAL_externval(ga*{ga}[x])}
  ;; 7-module.watsup:103.1-103.97
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, TABLE_externidx(x))) = {NAME name, VALUE TABLE_externval(ta*{ta}[x])}
  ;; 7-module.watsup:104.1-104.93
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, MEM_externidx(x))) = {NAME name, VALUE MEM_externval(ma*{ma}[x])}

;; 7-module.watsup:107.1-107.81
def allocmodule : (store, module, externval*, val*, ref**) -> (store, moduleinst)
  ;; 7-module.watsup:108.1-147.54
  def {byte*^n_data : byte*^n_data, da* : dataaddr*, datamode^n_data : datamode^n_data, ea* : elemaddr*, elemmode^n_elem : elemmode^n_elem, export* : export*, expr_1^n_global : expr^n_global, expr_2*^n_elem : expr*^n_elem, externval* : externval*, fa* : funcaddr*, fa_ex* : funcaddr*, ft : functype, func^n_func : func^n_func, ga* : globaladdr*, ga_ex* : globaladdr*, globaltype^n_global : globaltype^n_global, i_data^n_data : nat^n_data, i_elem^n_elem : nat^n_elem, i_func^n_func : nat^n_func, i_global^n_global : nat^n_global, i_mem^n_mem : nat^n_mem, i_table^n_table : nat^n_table, import* : import*, ma* : memaddr*, ma_ex* : memaddr*, memtype^n_mem : memtype^n_mem, mm : moduleinst, module : module, n_data : n, n_elem : n, n_func : n, n_global : n, n_mem : n, n_table : n, ref** : ref**, rt^n_elem : reftype^n_elem, s : store, s_1 : store, s_2 : store, s_3 : store, s_4 : store, s_5 : store, s_6 : store, start? : start?, ta* : tableaddr*, ta_ex* : tableaddr*, tabletype^n_table : tabletype^n_table, val* : val*, xi* : exportinst*} allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}) = (s_6, mm)
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(TYPE(ft)*{}, import*{import}, func^n_func{func}, GLOBAL(globaltype, expr_1)^n_global{expr_1 globaltype}, TABLE(tabletype)^n_table{tabletype}, MEMORY(memtype)^n_mem{memtype}, `ELEM%%*%`(rt, expr_2*{expr_2}, elemmode)^n_elem{elemmode expr_2 rt}, `DATA%*%`(byte*{byte}, datamode)^n_data{byte datamode}, start?{start}, export*{export}))
    -- if (fa_ex*{fa_ex} = $funcs(externval*{externval}))
    -- if (ga_ex*{ga_ex} = $globals(externval*{externval}))
    -- if (ta_ex*{ta_ex} = $tables(externval*{externval}))
    -- if (ma_ex*{ma_ex} = $mems(externval*{externval}))
    -- if (fa*{fa} = (|s.FUNC_store| + i_func)^(i_func<n_func){i_func})
    -- if (ga*{ga} = (|s.GLOBAL_store| + i_global)^(i_global<n_global){i_global})
    -- if (ta*{ta} = (|s.TABLE_store| + i_table)^(i_table<n_table){i_table})
    -- if (ma*{ma} = (|s.MEM_store| + i_mem)^(i_mem<n_mem){i_mem})
    -- if (ea*{ea} = (|s.ELEM_store| + i_elem)^(i_elem<n_elem){i_elem})
    -- if (da*{da} = (|s.DATA_store| + i_data)^(i_data<n_data){i_data})
    -- if (xi*{xi} = $instexport(fa_ex*{fa_ex} :: fa*{fa}, ga_ex*{ga_ex} :: ga*{ga}, ta_ex*{ta_ex} :: ta*{ta}, ma_ex*{ma_ex} :: ma*{ma}, export)*{export})
    -- if (mm = {TYPE [ft], FUNC fa_ex*{fa_ex} :: fa*{fa}, GLOBAL ga_ex*{ga_ex} :: ga*{ga}, TABLE ta_ex*{ta_ex} :: ta*{ta}, MEM ma_ex*{ma_ex} :: ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT xi*{xi}})
    -- if ((s_1, fa*{fa}) = $allocfuncs(s, mm, func^n_func{func}))
    -- if ((s_2, ga*{ga}) = $allocglobals(s_1, globaltype^n_global{globaltype}, val*{val}))
    -- if ((s_3, ta*{ta}) = $alloctables(s_2, tabletype^n_table{tabletype}))
    -- if ((s_4, ma*{ma}) = $allocmems(s_3, memtype^n_mem{memtype}))
    -- if ((s_5, ea*{ea}) = $allocelems(s_4, rt^n_elem{rt}, ref*{ref}*{ref}))
    -- if ((s_6, da*{da}) = $allocdatas(s_5, byte*{byte}^n_data{byte}))

;; 7-module.watsup:154.1-154.36
rec {

;; 7-module.watsup:154.1-154.36
def concat_instr : instr** -> instr*
  ;; 7-module.watsup:155.1-155.37
  def concat_instr([]) = []
  ;; 7-module.watsup:156.1-156.68
  def {instr* : instr*, instr'** : instr**} concat_instr([instr]*{instr} :: instr'*{instr'}*{instr'}) = instr*{instr} :: $concat_instr(instr'*{instr'}*{instr'})
}

;; 7-module.watsup:158.1-158.33
def runelem : (elem, idx) -> instr*
  ;; 7-module.watsup:159.1-159.56
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, PASSIVE_elemmode), i) = []
  ;; 7-module.watsup:160.1-160.62
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, DECLARE_elemmode), i) = [ELEM.DROP_instr(i)]
  ;; 7-module.watsup:161.1-163.20
  def {expr* : expr*, i : nat, instr* : instr*, n : n, reftype : reftype, x : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, ACTIVE_elemmode(x, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) TABLE.INIT_instr(x, i) ELEM.DROP_instr(i)]
    -- if (n = |expr*{expr}|)

;; 7-module.watsup:165.1-165.33
def rundata : (data, idx) -> instr*
  ;; 7-module.watsup:166.1-166.48
  def {byte* : byte*, i : nat} rundata(`DATA%*%`(byte*{byte}, PASSIVE_datamode), i) = []
  ;; 7-module.watsup:167.1-169.20
  def {byte* : byte*, i : nat, instr* : instr*, n : n} rundata(`DATA%*%`(byte*{byte}, ACTIVE_datamode(0, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) MEMORY.INIT_instr(i) DATA.DROP_instr(i)]
    -- if (n = |byte*{byte}|)

;; 7-module.watsup:171.1-171.53
def instantiate : (store, module, externval*) -> config
  ;; 7-module.watsup:172.1-196.28
  def {data* : data*, elem* : elem*, elemmode* : elemmode*, export* : export*, externval* : externval*, f : frame, f_init : frame, func* : func*, functype* : functype*, global* : global*, globaltype* : globaltype*, i^n_elem : nat^n_elem, import* : import*, instr_1** : instr**, instr_2*** : instr***, instr_data* : instr*, instr_elem* : instr*, j^n_data : nat^n_data, mem* : mem*, mm : moduleinst, mm_init : moduleinst, module : module, n_data : n, n_elem : n, ref** : ref**, reftype* : reftype*, s : store, s' : store, start? : start?, table* : table*, type* : type*, val* : val*, x? : idx?} instantiate(s, module, externval*{externval}) = `%;%*`(`%;%`(s', f), $admininstr_instr(instr_elem)*{instr_elem} :: $admininstr_instr(instr_data)*{instr_data} :: CALL_admininstr(x)?{x})
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (type*{type} = TYPE(functype)*{functype})
    -- if (global*{global} = GLOBAL(globaltype, instr_1*{instr_1})*{globaltype instr_1})
    -- if (elem*{elem} = `ELEM%%*%`(reftype, instr_2*{instr_2}*{instr_2}, elemmode)*{elemmode instr_2 reftype})
    -- if (mm_init = {TYPE functype*{functype}, FUNC $funcs(externval*{externval}), GLOBAL $globals(externval*{externval}), TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f_init = {LOCAL [], MODULE mm_init})
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), $admininstr_instr(instr_1)*{instr_1}), [$admininstr_val(val)]))*{instr_1 val}
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), $admininstr_instr(instr_2)*{instr_2}), [$admininstr_ref(ref)]))*{instr_2 ref}*{instr_2 ref}
    -- if ((s', mm) = $allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}))
    -- if (f = {LOCAL [], MODULE mm})
    -- if (n_elem = |elem*{elem}|)
    -- if (instr_elem*{instr_elem} = $concat_instr($runelem(elem*{elem}[i], i)^(i<n_elem){i}))
    -- if (n_data = |data*{data}|)
    -- if (instr_data*{instr_data} = $concat_instr($rundata(data*{data}[j], j)^(j<n_data){j}))
    -- if (start?{start} = START(x)?{x})

;; 7-module.watsup:203.1-203.44
def invoke : (store, funcaddr, val*) -> config
  ;; 7-module.watsup:204.1-215.51
  def {f : frame, fa : funcaddr, mm : moduleinst, n : n, s : store, t_1^n : valtype^n, t_2* : valtype*, val^n : val^n} invoke(s, fa, val^n{val}) = `%;%*`(`%;%`(s, f), $admininstr_val(val)^n{val} :: [CALL_ADDR_admininstr(fa)])
    -- if (mm = {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE mm})
    -- if ($funcinst(`%;%`(s, f))[fa].TYPE_funcinst = `%->%`(t_1^n{t_1}, t_2*{t_2}))

;; A-binary.watsup:47.1-47.57
rec {

;; A-binary.watsup:47.1-47.57
def concat_bytes : byte** -> byte*
  ;; A-binary.watsup:48.1-48.37
  def concat_bytes([]) = []
  ;; A-binary.watsup:49.1-49.52
  def {b* : byte*, b'** : byte**} concat_bytes([b]*{b} :: b'*{b'}*{b'}) = b*{b} :: $concat_bytes(b'*{b'}*{b'})
}

;; A-binary.watsup:51.1-51.24
rec {

;; A-binary.watsup:51.1-51.24
def utf8 : name -> byte*
  ;; A-binary.watsup:52.1-52.44
  def {b : byte, c : c_numtype} utf8([c]) = [b]
    -- if ((c < 128) /\ (c = b))
  ;; A-binary.watsup:53.1-53.93
  def {b_1 : byte, b_2 : byte, c : c_numtype} utf8([c]) = [b_1 b_2]
    -- if (((128 <= c) /\ (c < 2048)) /\ (c = (((2 ^ 6) * (b_1 - 192)) + (b_2 - 128))))
  ;; A-binary.watsup:54.1-54.144
  def {b_1 : byte, b_2 : byte, b_3 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3]
    -- if ((((2048 <= c) /\ (c < 55296)) \/ ((57344 <= c) /\ (c < 65536))) /\ (c = ((((2 ^ 12) * (b_1 - 224)) + ((2 ^ 6) * (b_2 - 128))) + (b_3 - 128))))
  ;; A-binary.watsup:55.1-55.145
  def {b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3 b_4]
    -- if (((65536 <= c) /\ (c < 69632)) /\ (c = (((((2 ^ 18) * (b_1 - 240)) + ((2 ^ 12) * (b_2 - 128))) + ((2 ^ 6) * (b_3 - 128))) + (b_4 - 128))))
  ;; A-binary.watsup:56.1-56.41
  def {c* : c_numtype*} utf8(c*{c}) = $concat_bytes($utf8([c])*{c})
}

;; A-binary.watsup:577.1-577.60
rec {

;; A-binary.watsup:577.1-577.60
def concat_locals : local** -> local*
  ;; A-binary.watsup:578.1-578.38
  def concat_locals([]) = []
  ;; A-binary.watsup:579.1-579.62
  def {loc* : local*, loc'** : local**} concat_locals([loc]*{loc} :: loc'*{loc'}*{loc'}) = loc*{loc} :: $concat_locals(loc'*{loc'}*{loc'})
}

;; A-binary.watsup:582.1-582.29
syntax code = (local*, expr)

== IL Validation after pass sideconditions...
== Running pass animate...
Animation failed:if ($type(z, y) = $type(z, y'))
Animation failed:if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(y', LOCAL(t)*{t}, instr*{instr}))
Animation failed:if ($ntbytes(nt, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (o0 / 8)])
Animation failed:if ($ibytes(n, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)])

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:4.1-4.15
syntax m = nat

;; 1-syntax.watsup:18.1-18.50
syntax byte = nat

;; 1-syntax.watsup:21.1-21.58
syntax uN = nat

;; 1-syntax.watsup:22.1-22.87
syntax sN = nat

;; 1-syntax.watsup:23.1-23.36
syntax iN = uN

;; 1-syntax.watsup:26.1-26.58
syntax u32 = nat

;; 1-syntax.watsup:27.1-27.58
syntax u64 = nat

;; 1-syntax.watsup:28.1-28.61
syntax u128 = nat

;; 1-syntax.watsup:29.1-29.69
syntax s33 = nat

;; 1-syntax.watsup:34.1-34.21
def signif : nat -> nat
  ;; 1-syntax.watsup:35.1-35.21
  def signif(32) = 23
  ;; 1-syntax.watsup:36.1-36.21
  def signif(64) = 52

;; 1-syntax.watsup:38.1-38.20
def expon : nat -> nat
  ;; 1-syntax.watsup:39.1-39.19
  def expon(32) = 8
  ;; 1-syntax.watsup:40.1-40.20
  def expon(64) = 11

;; 1-syntax.watsup:42.1-42.35
def M : nat -> nat
  ;; 1-syntax.watsup:43.1-43.23
  def {N : nat} M(N) = $signif(N)

;; 1-syntax.watsup:45.1-45.35
def E : nat -> nat
  ;; 1-syntax.watsup:46.1-46.22
  def {N : nat} E(N) = $expon(N)

;; 1-syntax.watsup:51.1-55.81
syntax fNmag =
  |  {N : nat, n : n}NORM(m, n)
    -- if (((2 - (2 ^ ($E(N) - 1))) <= n) /\ (n <= ((2 ^ ($E(N) - 1)) - 1)))
  |  {N : nat, n : n}SUBNORM(m, n)
    -- if ((2 - (2 ^ ($E(N) - 1))) = n)
  | INF
  |  {N : nat, n : n}NAN(n)
    -- if ((1 <= n) /\ (n < $M(N)))

;; 1-syntax.watsup:49.1-49.107
syntax fN =
  | POS(fNmag)
  | NEG(fNmag)

;; 1-syntax.watsup:58.1-58.35
def fNzero : fN
  ;; 1-syntax.watsup:59.1-59.29
  def fNzero = POS_fN(NORM_fNmag(0, 0))

;; 1-syntax.watsup:62.1-62.51
syntax f32 = fN

;; 1-syntax.watsup:63.1-63.51
syntax f64 = fN

;; 1-syntax.watsup:71.1-71.85
syntax char = nat

;; 1-syntax.watsup:73.1-73.38
syntax name = char*

;; 1-syntax.watsup:80.1-80.36
syntax idx = u32

;; 1-syntax.watsup:81.1-81.45
syntax typeidx = idx

;; 1-syntax.watsup:82.1-82.49
syntax funcidx = idx

;; 1-syntax.watsup:83.1-83.49
syntax globalidx = idx

;; 1-syntax.watsup:84.1-84.47
syntax tableidx = idx

;; 1-syntax.watsup:85.1-85.46
syntax memidx = idx

;; 1-syntax.watsup:86.1-86.45
syntax elemidx = idx

;; 1-syntax.watsup:87.1-87.45
syntax dataidx = idx

;; 1-syntax.watsup:88.1-88.47
syntax labelidx = idx

;; 1-syntax.watsup:89.1-89.47
syntax localidx = idx

;; 1-syntax.watsup:98.1-99.26
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:100.1-101.9
syntax vectype =
  | V128

;; 1-syntax.watsup:102.1-103.24
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:104.1-105.38
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | FUNCREF
  | EXTERNREF
  | BOT

def valtype_numtype : numtype -> valtype
  def valtype_numtype(I32_numtype) = I32_valtype
  def valtype_numtype(I64_numtype) = I64_valtype
  def valtype_numtype(F32_numtype) = F32_valtype
  def valtype_numtype(F64_numtype) = F64_valtype

def valtype_reftype : reftype -> valtype
  def valtype_reftype(FUNCREF_reftype) = FUNCREF_valtype
  def valtype_reftype(EXTERNREF_reftype) = EXTERNREF_valtype

def valtype_vectype : vectype -> valtype
  def valtype_vectype(V128_vectype) = V128_valtype

;; 1-syntax.watsup:107.1-107.40
syntax inn =
  | I32
  | I64

def numtype_inn : inn -> numtype
  def numtype_inn(I32_inn) = I32_numtype
  def numtype_inn(I64_inn) = I64_numtype

def valtype_inn : inn -> valtype
  def valtype_inn(I32_inn) = I32_valtype
  def valtype_inn(I64_inn) = I64_valtype

;; 1-syntax.watsup:108.1-108.40
syntax fnn =
  | F32
  | F64

def numtype_fnn : fnn -> numtype
  def numtype_fnn(F32_fnn) = F32_numtype
  def numtype_fnn(F64_fnn) = F64_numtype

def valtype_fnn : fnn -> valtype
  def valtype_fnn(F32_fnn) = F32_valtype
  def valtype_fnn(F64_fnn) = F64_valtype

;; 1-syntax.watsup:115.1-116.11
syntax resulttype = valtype*

;; 1-syntax.watsup:118.1-118.18
syntax mut = `MUT%?`(()?)

;; 1-syntax.watsup:120.1-121.16
syntax limits = `[%..%]`(u32, u32)

;; 1-syntax.watsup:122.1-123.14
syntax globaltype = `%%`(mut, valtype)

;; 1-syntax.watsup:124.1-125.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:126.1-127.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:128.1-129.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:130.1-131.10
syntax elemtype = reftype

;; 1-syntax.watsup:132.1-133.5
syntax datatype = OK

;; 1-syntax.watsup:134.1-135.70
syntax externtype =
  | FUNC(functype)
  | GLOBAL(globaltype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:147.1-147.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:149.1-149.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:150.1-150.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:152.1-154.66
syntax binop_IXX =
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

;; 1-syntax.watsup:155.1-155.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:157.1-157.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:158.1-158.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:160.1-161.112
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:162.1-162.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:164.1-164.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:165.1-165.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:166.1-166.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:167.1-167.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:168.1-168.53
syntax cvtop =
  | CONVERT
  | REINTERPRET
  | CONVERT_SAT

;; 1-syntax.watsup:176.1-176.68
syntax memop = {ALIGN u32, OFFSET u32}

;; 1-syntax.watsup:184.1-184.23
syntax c_numtype = nat

;; 1-syntax.watsup:185.1-185.23
syntax c_vectype = nat

;; 1-syntax.watsup:188.1-190.17
syntax blocktype =
  | _RESULT(valtype?)
  | _IDX(funcidx)

;; 1-syntax.watsup:248.1-256.80
rec {

;; 1-syntax.watsup:248.1-256.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
}

;; 1-syntax.watsup:258.1-259.9
syntax expr = instr*

;; 1-syntax.watsup:269.1-269.61
syntax elemmode =
  | ACTIVE(tableidx, expr)
  | PASSIVE
  | DECLARE

;; 1-syntax.watsup:270.1-270.49
syntax datamode =
  | ACTIVE(memidx, expr)
  | PASSIVE

;; 1-syntax.watsup:272.1-273.16
syntax type = TYPE(functype)

;; 1-syntax.watsup:274.1-275.16
syntax local = LOCAL(valtype)

;; 1-syntax.watsup:276.1-277.27
syntax func = `FUNC%%*%`(typeidx, local*, expr)

;; 1-syntax.watsup:278.1-279.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:280.1-281.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:282.1-283.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:284.1-285.30
syntax elem = `ELEM%%*%`(reftype, expr*, elemmode)

;; 1-syntax.watsup:286.1-287.22
syntax data = `DATA%*%`(byte*, datamode)

;; 1-syntax.watsup:288.1-289.16
syntax start = START(funcidx)

;; 1-syntax.watsup:291.1-292.66
syntax externidx =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:293.1-294.24
syntax export = EXPORT(name, externidx)

;; 1-syntax.watsup:295.1-296.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:298.1-299.76
syntax module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*, import*, func*, global*, table*, mem*, elem*, data*, start*, export*)

;; 2-aux.watsup:7.1-7.14
def Ki : nat
  ;; 2-aux.watsup:8.1-8.15
  def Ki = 1024

;; 2-aux.watsup:13.1-13.25
rec {

;; 2-aux.watsup:13.1-13.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:14.1-14.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:15.1-15.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:16.1-16.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:18.1-18.21
rec {

;; 2-aux.watsup:18.1-18.21
def sum : nat* -> nat
  ;; 2-aux.watsup:19.1-19.22
  def sum([]) = 0
  ;; 2-aux.watsup:20.1-20.35
  def {n : n, n'* : n*} sum([n] :: n'*{n'}) = (n + $sum(n'*{n'}))
}

;; 2-aux.watsup:31.1-31.55
def size : valtype -> nat?
  ;; 2-aux.watsup:32.1-32.20
  def size(I32_valtype) = ?(32)
  ;; 2-aux.watsup:33.1-33.20
  def size(I64_valtype) = ?(64)
  ;; 2-aux.watsup:34.1-34.20
  def size(F32_valtype) = ?(32)
  ;; 2-aux.watsup:35.1-35.20
  def size(F64_valtype) = ?(64)
  ;; 2-aux.watsup:36.1-36.22
  def size(V128_valtype) = ?(128)
  def {x : valtype} size(x) = ?()

;; 2-aux.watsup:43.1-43.57
def signed : (nat, nat) -> int
  ;; 2-aux.watsup:44.1-44.54
  def {N : nat, i : nat} signed(N, i) = (i <: int)
    -- if (0 <= (2 ^ (N - 1)))
  ;; 2-aux.watsup:45.1-45.60
  def {N : nat, i : nat} signed(N, i) = ((i - (2 ^ N)) <: int)
    -- if (((2 ^ (N - 1)) <= i) /\ (i < (2 ^ N)))

;; 2-aux.watsup:47.1-47.63
def invsigned : (nat, int) -> nat
  ;; 2-aux.watsup:48.1-48.56
  def {N : nat, i : nat, j : nat} invsigned(N, (i <: int)) = j
    -- if ($signed(N, j) = (i <: int))

;; 2-aux.watsup:55.1-55.33
def memop0 : memop
  ;; 2-aux.watsup:56.1-56.34
  def memop0 = {ALIGN 0, OFFSET 0}

;; 2-aux.watsup:61.1-61.68
def free_dataidx_instr : instr -> dataidx*
  ;; 2-aux.watsup:62.1-62.43
  def {x : idx} free_dataidx_instr(MEMORY.INIT_instr(x)) = [x]
  ;; 2-aux.watsup:63.1-63.41
  def {x : idx} free_dataidx_instr(DATA.DROP_instr(x)) = [x]
  ;; 2-aux.watsup:64.1-64.38
  def {in : instr} free_dataidx_instr(in) = []

;; 2-aux.watsup:66.1-66.70
rec {

;; 2-aux.watsup:66.1-66.70
def free_dataidx_instrs : instr* -> dataidx*
  ;; 2-aux.watsup:67.1-67.44
  def free_dataidx_instrs([]) = []
  ;; 2-aux.watsup:68.1-68.99
  def {instr : instr, instr'* : instr*} free_dataidx_instrs([instr] :: instr'*{instr'}) = $free_dataidx_instr(instr) :: $free_dataidx_instrs(instr'*{instr'})
}

;; 2-aux.watsup:70.1-70.66
def free_dataidx_expr : expr -> dataidx*
  ;; 2-aux.watsup:71.1-71.56
  def {in* : instr*} free_dataidx_expr(in*{in}) = $free_dataidx_instrs(in*{in})

;; 2-aux.watsup:73.1-73.66
def free_dataidx_func : func -> dataidx*
  ;; 2-aux.watsup:74.1-74.62
  def {e : expr, loc* : local*, x : idx} free_dataidx_func(`FUNC%%*%`(x, loc*{loc}, e)) = $free_dataidx_expr(e)

;; 2-aux.watsup:76.1-76.68
rec {

;; 2-aux.watsup:76.1-76.68
def free_dataidx_funcs : func* -> dataidx*
  ;; 2-aux.watsup:77.1-77.43
  def free_dataidx_funcs([]) = []
  ;; 2-aux.watsup:78.1-78.92
  def {func : func, func'* : func*} free_dataidx_funcs([func] :: func'*{func'}) = $free_dataidx_func(func) :: $free_dataidx_funcs(func'*{func'})
}

;; 2-aux.watsup:86.1-86.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:87.1-87.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:89.1-89.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:90.1-90.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:92.1-101.43
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

;; 3-typing.watsup:5.1-8.60
syntax context = {TYPE functype*, FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:18.1-18.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:26.1-28.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%]`(n_1, n_2), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:19.1-19.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:30.1-31.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:20.1-20.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:33.1-34.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:21.1-21.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:36.1-38.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:22.1-22.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:40.1-42.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:23.1-23.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:45.1-47.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:49.1-51.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:53.1-55.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:57.1-59.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:69.1-69.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:72.1-73.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:75.1-76.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:70.1-70.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:78.1-80.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- if (|t_1*{t_1}| = |t_2*{t_2}|)
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:85.1-85.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:93.1-96.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%]`(n_11, n_12), `[%..%]`(n_21, n_22))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:86.1-86.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:98.1-99.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:87.1-87.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:101.1-102.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:88.1-88.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:104.1-106.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:89.1-89.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:108.1-110.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:90.1-90.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:113.1-115.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:117.1-119.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:121.1-123.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:125.1-127.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:192.1-192.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:194.1-195.44
  rule void {C : context}:
    `%|-%:%`(C, _RESULT_blocktype(?()), `%->%`([], []))

  ;; 3-typing.watsup:197.1-198.32
  rule result {C : context, t : valtype}:
    `%|-%:%`(C, _RESULT_blocktype(?(t)), `%->%`([], [t]))

  ;; 3-typing.watsup:200.1-202.23
  rule typeidx {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, _IDX_blocktype(x), ft)
    -- if (x < |C.TYPE_context|)
    -- if (C.TYPE_context[x] = ft)

;; 3-typing.watsup:135.1-136.67
rec {

;; 3-typing.watsup:135.1-135.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:171.1-172.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:174.1-175.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:177.1-178.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:181.1-182.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?([t])), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:184.1-187.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = $valtype_numtype(numtype)) \/ (t' = $valtype_vectype(vectype)))

  ;; 3-typing.watsup:205.1-208.59
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:210.1-213.59
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1*{t_1}], RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:215.1-219.61
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:224.1-226.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (l < |C.LABEL_context|)
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:228.1-230.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (l < |C.LABEL_context|)
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:232.1-235.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (if (l < |C.LABEL_context|))*{l}
    -- if (l' < |C.LABEL_context|)
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:240.1-242.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 3-typing.watsup:244.1-246.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:248.1-251.33
  rule call_indirect {C : context, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx, y : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, y), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (x < |C.TABLE_context|)
    -- if (y < |C.TYPE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (C.TYPE_context[y] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:256.1-257.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:259.1-260.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:262.1-263.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:265.1-266.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([$valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-269.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:272.1-274.23
  rule extend {C : context, n : n, nt : numtype, o0 : nat}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (n <= o0)

  ;; 3-typing.watsup:276.1-279.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([$valtype_numtype(nt_2)], [$valtype_numtype(nt_1)]))
    -- if ($size($valtype_numtype(nt_1)) = ?(o0))
    -- if ($size($valtype_numtype(nt_2)) = ?(o1))
    -- if (nt_1 =/= nt_2)
    -- if (o0 = o1)

  ;; 3-typing.watsup:281.1-284.54
  rule convert-i {C : context, inn_1 : inn, inn_2 : inn, sx? : sx?, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr($numtype_inn(inn_1), CONVERT_cvtop, $numtype_inn(inn_2), sx?{sx}), `%->%`([$valtype_inn(inn_2)], [$valtype_inn(inn_1)]))
    -- if ($size($valtype_inn(inn_1)) = ?(o0))
    -- if ($size($valtype_inn(inn_2)) = ?(o1))
    -- if (inn_1 =/= inn_2)
    -- if ((sx?{sx} = ?()) <=> (o0 > o1))

  ;; 3-typing.watsup:286.1-288.24
  rule convert-f {C : context, fnn_1 : fnn, fnn_2 : fnn}:
    `%|-%:%`(C, CVTOP_instr($numtype_fnn(fnn_1), CONVERT_cvtop, $numtype_fnn(fnn_2), ?()), `%->%`([$valtype_fnn(fnn_2)], [$valtype_fnn(fnn_1)]))
    -- if (fnn_1 =/= fnn_2)

  ;; 3-typing.watsup:293.1-294.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [$valtype_reftype(rt)]))

  ;; 3-typing.watsup:296.1-298.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:300.1-301.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([$valtype_reftype(rt)], [I32_valtype]))

  ;; 3-typing.watsup:306.1-308.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (x < |C.LOCAL_context|)
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:310.1-312.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (x < |C.LOCAL_context|)
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:314.1-316.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (x < |C.LOCAL_context|)
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:321.1-323.28
  rule global.get {C : context, mut : mut, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = `%%`(mut, t))

  ;; 3-typing.watsup:325.1-327.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?(())), t))

  ;; 3-typing.watsup:332.1-334.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [$valtype_reftype(rt)]))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:336.1-338.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype $valtype_reftype(rt)], []))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:340.1-342.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:344.1-346.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([$valtype_reftype(rt) I32_valtype], [I32_valtype]))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:348.1-350.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype $valtype_reftype(rt) I32_valtype], []))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:352.1-355.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (x_1 < |C.TABLE_context|)
    -- if (x_2 < |C.TABLE_context|)
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:357.1-360.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (x_1 < |C.TABLE_context|)
    -- if (x_2 < |C.ELEM_context|)
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:362.1-364.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (x < |C.ELEM_context|)
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:369.1-371.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:373.1-375.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:377.1-379.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:381.1-383.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:385.1-388.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (0 < |C.MEM_context|)
    -- if (x < |C.DATA_context|)
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:390.1-392.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (x < |C.DATA_context|)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:394.1-399.33
  rule load {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype], [$valtype_numtype(nt)]))
    -- if (0 < |C.MEM_context|)
    -- if ((n?{n} = ?()) <=> (o1?{o1} = ?()))
    -- if ((n?{n} = ?()) <=> (sx?{sx} = ?()))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- (if ($size($valtype_numtype(nt)) = ?(o1)))?{o1}
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_inn(inn)))

  ;; 3-typing.watsup:401.1-406.33
  rule store {C : context, inn : inn, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, {ALIGN n_A, OFFSET n_O}), `%->%`([I32_valtype $valtype_numtype(nt)], []))
    -- if (0 < |C.MEM_context|)
    -- if ((n?{n} = ?()) <=> (o1?{o1} = ?()))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- (if ($size($valtype_numtype(nt)) = ?(o1)))?{o1}
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_inn(inn)))

;; 3-typing.watsup:136.1-136.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:149.1-150.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:152.1-155.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:157.1-162.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:164.1-166.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:137.1-137.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:142.1-144.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:413.1-413.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:417.1-418.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:420.1-421.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:423.1-424.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:426.1-428.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = `%%`(`MUT%?`(?()), t))

;; 3-typing.watsup:414.1-414.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:431.1-432.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:415.1-415.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:435.1-438.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:445.1-445.73
relation Type_ok: `|-%:%`(type, functype)
  ;; 3-typing.watsup:459.1-461.29
  rule _ {ft : functype}:
    `|-%:%`(TYPE(ft), ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:446.1-446.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:463.1-467.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, `FUNC%%*%`(x, LOCAL(t)*{t}, expr), ft)
    -- if (x < |C.TYPE_context|)
    -- if (C.TYPE_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:447.1-447.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:469.1-473.40
  rule _ {C : context, expr : expr, gt : globaltype, mut : mut, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `%%`(mut, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:448.1-448.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:475.1-477.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:449.1-449.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:479.1-481.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:452.1-452.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:492.1-495.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, ACTIVE_elemmode(x, expr), rt)
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:497.1-498.20
  rule passive {C : context, rt : reftype}:
    `%|-%:%`(C, PASSIVE_elemmode, rt)

  ;; 3-typing.watsup:500.1-501.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:450.1-450.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:483.1-486.37
  rule _ {C : context, elemmode : elemmode, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%`(rt, expr*{expr}, elemmode), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [$valtype_reftype(rt)]))*{expr}
    -- Elemmode_ok: `%|-%:%`(C, elemmode, rt)

;; 3-typing.watsup:453.1-453.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:503.1-506.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, ACTIVE_datamode(0, expr))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:508.1-509.20
  rule passive {C : context}:
    `%|-%:OK`(C, PASSIVE_datamode)

;; 3-typing.watsup:451.1-451.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:488.1-490.37
  rule _ {C : context, b* : byte*, datamode : datamode}:
    `%|-%:OK`(C, `DATA%*%`(b*{b}, datamode))
    -- Datamode_ok: `%|-%:OK`(C, datamode)

;; 3-typing.watsup:454.1-454.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:511.1-513.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:518.1-518.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:522.1-524.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:520.1-520.83
relation Externidx_ok: `%|-%:%`(context, externidx, externtype)
  ;; 3-typing.watsup:531.1-533.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externidx(x), FUNC_externtype(ft))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:535.1-537.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externidx(x), GLOBAL_externtype(gt))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:539.1-541.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externidx(x), TABLE_externtype(tt))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:543.1-545.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externidx(x), MEM_externtype(mt))
    -- if (x < |C.MEM_context|)
    -- if (C.MEM_context[x] = mt)

;; 3-typing.watsup:519.1-519.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:526.1-528.39
  rule _ {C : context, externidx : externidx, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externidx), xt)
    -- Externidx_ok: `%|-%:%`(C, externidx, xt)

;; 3-typing.watsup:550.1-550.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:552.1-567.20
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, ft'* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*, type* : type*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (|ft'*{ft'}| = |type*{type}|)
    -- if (|ft*{ft}| = |func*{func}|)
    -- if (|global*{global}| = |gt*{gt}|)
    -- if (|table*{table}| = |tt*{tt}|)
    -- if (|mem*{mem}| = |mt*{mt}|)
    -- if (|elem*{elem}| = |rt*{rt}|)
    -- if (C = {TYPE ft'*{ft'}, FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Type_ok: `|-%:%`(type, ft'))*{ft' type}
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

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

;; 4-runtime.watsup:30.1-31.28
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:32.1-33.71
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:34.1-35.14
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:37.1-38.22
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:47.1-48.70
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:55.1-55.44
def default_ : valtype -> val?
  ;; 4-runtime.watsup:56.1-56.35
  def default_(I32_valtype) = ?(CONST_val(I32_numtype, 0))
  ;; 4-runtime.watsup:57.1-57.35
  def default_(I64_valtype) = ?(CONST_val(I64_numtype, 0))
  ;; 4-runtime.watsup:58.1-58.35
  def default_(F32_valtype) = ?(CONST_val(F32_numtype, 0))
  ;; 4-runtime.watsup:59.1-59.35
  def default_(F64_valtype) = ?(CONST_val(F64_numtype, 0))
  ;; 4-runtime.watsup:60.1-60.44
  def default_(FUNCREF_valtype) = ?(REF.NULL_val(FUNCREF_reftype))
  ;; 4-runtime.watsup:61.1-61.48
  def default_(EXTERNREF_valtype) = ?(REF.NULL_val(EXTERNREF_reftype))
  def {x : valtype} default_(x) = ?()

;; 4-runtime.watsup:88.1-90.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:92.1-100.25
syntax moduleinst = {TYPE functype*, FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:70.1-73.16
syntax funcinst = {TYPE functype, MODULE moduleinst, CODE func}

;; 4-runtime.watsup:74.1-76.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:77.1-79.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:80.1-82.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:83.1-85.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:86.1-87.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:114.1-120.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:122.1-124.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:126.1-126.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:213.1-220.9
rec {

;; 4-runtime.watsup:213.1-220.9
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, typeidx)
  | RETURN
  | CONST(numtype, c_numtype)
  | UNOP(numtype, unop_numtype)
  | BINOP(numtype, binop_numtype)
  | TESTOP(numtype, testop_numtype)
  | RELOP(numtype, relop_numtype)
  | EXTEND(numtype, n)
  | CVTOP(numtype, cvtop, numtype, sx?)
  | REF.NULL(reftype)
  | REF.FUNC(funcidx)
  | REF.IS_NULL
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
  | MEMORY.SIZE
  | MEMORY.GROW
  | MEMORY.FILL
  | MEMORY.COPY
  | MEMORY.INIT(dataidx)
  | DATA.DROP(dataidx)
  | LOAD(numtype, (n, sx)?, memop)
  | STORE(numtype, n?, memop)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | CALL_ADDR(funcaddr)
  | LABEL_(n, instr*, admininstr*)
  | FRAME_(n, frame, admininstr*)
  | TRAP
}

def admininstr_instr : instr -> admininstr
  def admininstr_instr(UNREACHABLE_instr) = UNREACHABLE_admininstr
  def admininstr_instr(NOP_instr) = NOP_admininstr
  def admininstr_instr(DROP_instr) = DROP_admininstr
  def {x : valtype*?} admininstr_instr(SELECT_instr(x)) = SELECT_admininstr(x)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(BLOCK_instr(x0, x1)) = BLOCK_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(LOOP_instr(x0, x1)) = LOOP_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*, x2 : instr*} admininstr_instr(IF_instr(x0, x1, x2)) = IF_admininstr(x0, x1, x2)
  def {x : labelidx} admininstr_instr(BR_instr(x)) = BR_admininstr(x)
  def {x : labelidx} admininstr_instr(BR_IF_instr(x)) = BR_IF_admininstr(x)
  def {x0 : labelidx*, x1 : labelidx} admininstr_instr(BR_TABLE_instr(x0, x1)) = BR_TABLE_admininstr(x0, x1)
  def {x : funcidx} admininstr_instr(CALL_instr(x)) = CALL_admininstr(x)
  def {x0 : tableidx, x1 : typeidx} admininstr_instr(CALL_INDIRECT_instr(x0, x1)) = CALL_INDIRECT_admininstr(x0, x1)
  def admininstr_instr(RETURN_instr) = RETURN_admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_instr(CONST_instr(x0, x1)) = CONST_admininstr(x0, x1)
  def {x0 : numtype, x1 : unop_numtype} admininstr_instr(UNOP_instr(x0, x1)) = UNOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : binop_numtype} admininstr_instr(BINOP_instr(x0, x1)) = BINOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : testop_numtype} admininstr_instr(TESTOP_instr(x0, x1)) = TESTOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : relop_numtype} admininstr_instr(RELOP_instr(x0, x1)) = RELOP_admininstr(x0, x1)
  def {x0 : numtype, x1 : n} admininstr_instr(EXTEND_instr(x0, x1)) = EXTEND_admininstr(x0, x1)
  def {x0 : numtype, x1 : cvtop, x2 : numtype, x3 : sx?} admininstr_instr(CVTOP_instr(x0, x1, x2, x3)) = CVTOP_admininstr(x0, x1, x2, x3)
  def {x : reftype} admininstr_instr(REF.NULL_instr(x)) = REF.NULL_admininstr(x)
  def {x : funcidx} admininstr_instr(REF.FUNC_instr(x)) = REF.FUNC_admininstr(x)
  def admininstr_instr(REF.IS_NULL_instr) = REF.IS_NULL_admininstr
  def {x : localidx} admininstr_instr(LOCAL.GET_instr(x)) = LOCAL.GET_admininstr(x)
  def {x : localidx} admininstr_instr(LOCAL.SET_instr(x)) = LOCAL.SET_admininstr(x)
  def {x : localidx} admininstr_instr(LOCAL.TEE_instr(x)) = LOCAL.TEE_admininstr(x)
  def {x : globalidx} admininstr_instr(GLOBAL.GET_instr(x)) = GLOBAL.GET_admininstr(x)
  def {x : globalidx} admininstr_instr(GLOBAL.SET_instr(x)) = GLOBAL.SET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.GET_instr(x)) = TABLE.GET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.SET_instr(x)) = TABLE.SET_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.SIZE_instr(x)) = TABLE.SIZE_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.GROW_instr(x)) = TABLE.GROW_admininstr(x)
  def {x : tableidx} admininstr_instr(TABLE.FILL_instr(x)) = TABLE.FILL_admininstr(x)
  def {x0 : tableidx, x1 : tableidx} admininstr_instr(TABLE.COPY_instr(x0, x1)) = TABLE.COPY_admininstr(x0, x1)
  def {x0 : tableidx, x1 : elemidx} admininstr_instr(TABLE.INIT_instr(x0, x1)) = TABLE.INIT_admininstr(x0, x1)
  def {x : elemidx} admininstr_instr(ELEM.DROP_instr(x)) = ELEM.DROP_admininstr(x)
  def admininstr_instr(MEMORY.SIZE_instr) = MEMORY.SIZE_admininstr
  def admininstr_instr(MEMORY.GROW_instr) = MEMORY.GROW_admininstr
  def admininstr_instr(MEMORY.FILL_instr) = MEMORY.FILL_admininstr
  def admininstr_instr(MEMORY.COPY_instr) = MEMORY.COPY_admininstr
  def {x : dataidx} admininstr_instr(MEMORY.INIT_instr(x)) = MEMORY.INIT_admininstr(x)
  def {x : dataidx} admininstr_instr(DATA.DROP_instr(x)) = DATA.DROP_admininstr(x)
  def {x0 : numtype, x1 : (n, sx)?, x2 : memop} admininstr_instr(LOAD_instr(x0, x1, x2)) = LOAD_admininstr(x0, x1, x2)
  def {x0 : numtype, x1 : n?, x2 : memop} admininstr_instr(STORE_instr(x0, x1, x2)) = STORE_admininstr(x0, x1, x2)

def admininstr_ref : ref -> admininstr
  def {x : reftype} admininstr_ref(REF.NULL_ref(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_ref(REF.FUNC_ADDR_ref(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_ref(REF.HOST_ADDR_ref(x)) = REF.HOST_ADDR_admininstr(x)

def admininstr_val : val -> admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_val(CONST_val(x0, x1)) = CONST_admininstr(x0, x1)
  def {x : reftype} admininstr_val(REF.NULL_val(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_val(REF.FUNC_ADDR_val(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_val(REF.HOST_ADDR_val(x)) = REF.HOST_ADDR_admininstr(x)

;; 4-runtime.watsup:127.1-127.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:136.1-136.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:137.1-137.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:139.1-139.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:146.1-146.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:140.1-140.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:147.1-147.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:141.1-141.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:148.1-148.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:142.1-142.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:149.1-149.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:143.1-143.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:150.1-150.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:144.1-144.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:151.1-151.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:153.1-153.67
def type : (state, typeidx) -> functype
  ;; 4-runtime.watsup:162.1-162.40
  def {f : frame, s : store, x : idx} type(`%;%`(s, f), x) = f.MODULE_frame.TYPE_moduleinst[x]

;; 4-runtime.watsup:154.1-154.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:163.1-163.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:155.1-155.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:164.1-164.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:156.1-156.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:165.1-165.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:157.1-157.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:166.1-166.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:158.1-158.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:167.1-167.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:159.1-159.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:168.1-168.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:160.1-160.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:169.1-169.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:172.1-172.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:181.1-181.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:173.1-173.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:182.1-182.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:174.1-174.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:183.1-183.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:175.1-175.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:184.1-184.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:176.1-176.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:185.1-185.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:177.1-177.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:186.1-186.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:178.1-178.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:187.1-187.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:179.1-179.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:188.1-188.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:193.1-193.63
def grow_table : (tableinst, nat, ref) -> tableinst?
  ;; 4-runtime.watsup:196.1-200.36
  def {i : nat, i' : nat, j : nat, n : n, r : ref, r'* : ref*, rt : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ?(ti')
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%]`(i', j), rt), ELEM r'*{r'} :: r^n{}})
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)
  def {x : (tableinst, nat, ref)} grow_table(x) = ?()

;; 4-runtime.watsup:194.1-194.55
def grow_memory : (meminst, nat) -> meminst?
  ;; 4-runtime.watsup:202.1-206.34
  def {b* : byte*, i : nat, i' : nat, j : nat, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = ?(mi')
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%]`(i', j)), DATA b*{b} :: 0^((n * 64) * $Ki){}})
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)
  def {x : (meminst, nat)} grow_memory(x) = ?()

;; 4-runtime.watsup:222.1-225.25
rec {

;; 4-runtime.watsup:222.1-225.25
syntax E =
  | _HOLE
  | _SEQ(val*, E, instr*)
  | LABEL_(n, instr*, E)
}

;; 5-numerics.watsup:3.1-3.79
def unop : (unop_numtype, numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:4.1-4.80
def binop : (binop_numtype, numtype, c_numtype, c_numtype) -> c_numtype*

;; 5-numerics.watsup:5.1-5.79
def testop : (testop_numtype, numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:6.1-6.80
def relop : (relop_numtype, numtype, c_numtype, c_numtype) -> c_numtype

;; 5-numerics.watsup:8.1-8.84
def ext : (nat, nat, sx, c_numtype) -> c_numtype

;; 5-numerics.watsup:9.1-9.84
def cvtop : (numtype, cvtop, numtype, sx?, c_numtype) -> c_numtype*

;; 5-numerics.watsup:11.1-11.32
def wrap_ : ((nat, nat), c_numtype) -> nat

;; 5-numerics.watsup:13.1-13.60
def ibytes : (nat, iN) -> byte*

;; 5-numerics.watsup:14.1-14.60
def fbytes : (nat, fN) -> byte*

;; 5-numerics.watsup:15.1-15.58
def ntbytes : (numtype, c_numtype) -> byte*

;; 5-numerics.watsup:17.1-17.30
def invibytes : (nat, byte*) -> iN
  ;; 5-numerics.watsup:20.1-20.52
  def {N : nat, b* : byte*, n : n} invibytes(N, b*{b}) = n
    -- if ($ibytes(N, n) = b*{b})

;; 5-numerics.watsup:18.1-18.30
def invfbytes : (nat, byte*) -> fN
  ;; 5-numerics.watsup:21.1-21.52
  def {N : nat, b* : byte*, p : fN} invfbytes(N, b*{b}) = p
    -- if ($fbytes(N, p) = b*{b})

;; 6-reduction.watsup:6.1-6.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:24.1-25.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:27.1-28.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:30.1-31.24
  rule drop {val : val}:
    `%*~>%*`([$admininstr_val(val) DROP_admininstr], [])

  ;; 6-reduction.watsup:34.1-36.16
  rule select-true {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [$admininstr_val(val_1)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:38.1-40.14
  rule select-false {c : c_numtype, t*? : valtype*?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t*{t}?{t})], [$admininstr_val(val_2)])
    -- if (c = 0)

  ;; 6-reduction.watsup:58.1-60.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:62.1-64.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:67.1-68.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, $admininstr_val(val)*{val})], $admininstr_val(val)*{val})

  ;; 6-reduction.watsup:74.1-75.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [BR_admininstr(0)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val} :: $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:77.1-78.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val)*{val} :: [BR_admininstr(l + 1)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:81.1-83.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:85.1-87.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:90.1-92.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:94.1-96.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:121.1-122.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val)^n{val})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:124.1-125.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:127.1-128.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, $admininstr_val(val)*{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:133.1-135.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- where [c] = $unop(unop, nt, c_1)

  ;; 6-reduction.watsup:137.1-139.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:142.1-144.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- where [c] = $binop(binop, nt, c_1, c_2)

  ;; 6-reduction.watsup:146.1-148.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:151.1-153.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- where c = $testop(testop, nt, c_1)

  ;; 6-reduction.watsup:155.1-157.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- where c = $relop(relop, nt, c_1, c_2)

  ;; 6-reduction.watsup:160.1-161.70
  rule extend {c : c_numtype, n : n, nt : numtype, o0 : nat}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, o0, S_sx, c))])
    -- where ?(o0) = $size($valtype_numtype(nt))

  ;; 6-reduction.watsup:164.1-166.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- where [c] = $cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1)

  ;; 6-reduction.watsup:168.1-170.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:179.1-181.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- where REF.NULL_val(rt) = val

  ;; 6-reduction.watsup:183.1-185.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:196.1-197.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([$admininstr_val(val) LOCAL.TEE_admininstr(x)], [$admininstr_val(val) $admininstr_val(val) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:45.1-45.73
def blocktype : (state, blocktype) -> functype
  ;; 6-reduction.watsup:46.1-46.56
  def {z : state} blocktype(z, _RESULT_blocktype(?())) = `%->%`([], [])
  ;; 6-reduction.watsup:47.1-47.44
  def {t : valtype, z : state} blocktype(z, _RESULT_blocktype(?(t))) = `%->%`([], [t])
  ;; 6-reduction.watsup:48.1-48.40
  def {x : idx, z : state} blocktype(z, _IDX_blocktype(x)) = $type(z, x)

;; 6-reduction.watsup:7.1-7.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:50.1-52.43
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})]), [LABEL__admininstr(n, [], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- where `%->%`(t_1^k{t_1}, t_2^n{t_2}) = $blocktype(z, bt)

  ;; 6-reduction.watsup:54.1-56.43
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [LOOP_admininstr(bt, instr*{instr})]), [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- where `%->%`(t_1^k{t_1}, t_2^n{t_2}) = $blocktype(z, bt)

  ;; 6-reduction.watsup:101.1-102.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])
    -- if (x < |$funcaddr(z)|)

  ;; 6-reduction.watsup:104.1-108.35
  rule call_indirect-call {a : addr, i : nat, instr* : instr*, t* : valtype*, x : idx, y : idx, y' : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [CALL_ADDR_admininstr(a)])
    -- if (i < |$table(z, x).ELEM_tableinst|)
    -- where REF.FUNC_ADDR_ref(a) = $table(z, x).ELEM_tableinst[i]
    -- where $type(z, y') = $type(z, y)
    -- if (a < |$funcinst(z)|)
    -- where `FUNC%%*%`(y', LOCAL(t)*{t}, instr*{instr}) = $funcinst(z)[a].CODE_funcinst

  ;; 6-reduction.watsup:110.1-112.15
  rule call_indirect-trap {i : nat, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, y)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:114.1-118.53
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, mm : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, x : idx, z : state, o0* : val*}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], $admininstr_instr(instr)*{instr})])])
    -- if (a < |$funcinst(z)|)
    -- where {TYPE `%->%`(t_1^k{t_1}, t_2^n{t_2}), MODULE mm, CODE func} = $funcinst(z)[a]
    -- where `FUNC%%*%`(x, LOCAL(t)*{t}, instr*{instr}) = func
    -- where |o0*{o0}| = |t*{t}|
    -- (if ($default_(t) = ?(o0)))*{t o0}
    -- where f = {LOCAL val^k{val} :: o0*{o0}, MODULE mm}

  ;; 6-reduction.watsup:175.1-176.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])
    -- if (x < |$funcaddr(z)|)

  ;; 6-reduction.watsup:190.1-191.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [$admininstr_val($local(z, x))])

  ;; 6-reduction.watsup:202.1-203.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [$admininstr_val($global(z, x).VALUE_globalinst)])

  ;; 6-reduction.watsup:211.1-213.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:215.1-217.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [$admininstr_ref($table(z, x).ELEM_tableinst[i])])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:228.1-230.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- where n = |$table(z, x).ELEM_tableinst|

  ;; 6-reduction.watsup:241.1-243.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:245.1-248.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:250.1-254.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:257.1-259.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:261.1-264.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:266.1-271.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:273.1-277.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:280.1-282.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:284.1-287.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:289.1-293.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) $admininstr_ref($elem(z, y).ELEM_eleminst[i]) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise
    -- if (i < |$elem(z, y).ELEM_eleminst|)

  ;; 6-reduction.watsup:302.1-304.59
  rule load-num-trap {i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [TRAP_admininstr])
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- if (((i + mo.OFFSET_memop) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:306.1-308.71
  rule load-num-val {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), mo)]), [CONST_admininstr(nt, c)])
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- where $ntbytes(nt, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (o0 / 8)]

  ;; 6-reduction.watsup:310.1-312.51
  rule load-pack-trap {i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [TRAP_admininstr])
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:314.1-316.61
  rule load-pack-val {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, sx : sx, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), mo)]), [CONST_admininstr(nt, $ext(n, o0, sx, c))])
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- where $ibytes(n, c) = $mem(z, 0).DATA_meminst[(i + mo.OFFSET_memop) : (n / 8)]

  ;; 6-reduction.watsup:336.1-338.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- where ((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|

  ;; 6-reduction.watsup:349.1-351.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:353.1-356.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:358.1-362.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:365.1-367.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:369.1-372.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:374.1-379.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:381.1-385.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), $memop0) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:388.1-390.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:392.1-395.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:397.1-401.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), $memop0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- otherwise
    -- if (i < |$data(z, x).DATA_datainst|)

;; 6-reduction.watsup:5.1-5.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:9.1-11.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_pure: `%*~>%*`($admininstr_instr(instr)*{instr}, $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:13.1-15.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, $admininstr_instr(instr)*{instr}), $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:193.1-194.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:205.1-206.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:219.1-221.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:223.1-225.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:233.1-235.47
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, x : idx, z : state, o0 : tableinst}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- where ?(o0) = $grow_table($table(z, x), n, ref)
    -- where ti = o0

  ;; 6-reduction.watsup:237.1-238.80
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:296.1-297.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:319.1-321.59
  rule store-num-trap {c : c_numtype, i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- if (((i + mo.OFFSET_memop) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:323.1-325.29
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, mo : memop, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), (o0 / 8), b*{b}), []))
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- where b*{b} = $ntbytes(nt, c)

  ;; 6-reduction.watsup:327.1-329.51
  rule store-pack-trap {c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + mo.OFFSET_memop) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:331.1-333.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, mo : memop, n : n, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), mo)]), `%;%*`($with_mem(z, 0, (i + mo.OFFSET_memop), (n / 8), b*{b}), []))
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- where b*{b} = $ibytes(n, $wrap_((o0, n), c))

  ;; 6-reduction.watsup:341.1-343.41
  rule memory.grow-succeed {mi : meminst, n : n, z : state, o0 : meminst}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- where ?(o0) = $grow_memory($mem(z, 0), n)
    -- where mi = o0

  ;; 6-reduction.watsup:345.1-346.75
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, $invsigned(32, - (1 <: int)))]))

  ;; 6-reduction.watsup:404.1-405.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:5.1-5.35
rec {

;; 7-module.watsup:5.1-5.35
def funcs : externval* -> funcaddr*
  ;; 7-module.watsup:6.1-6.30
  def funcs([]) = []
  ;; 7-module.watsup:7.1-7.59
  def {externval'* : externval*, fa : funcaddr} funcs([FUNC_externval(fa)] :: externval'*{externval'}) = [fa] :: $funcs(externval'*{externval'})
  ;; 7-module.watsup:8.1-9.15
  def {externval : externval, externval'* : externval*} funcs([externval] :: externval'*{externval'}) = $funcs(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:11.1-11.39
rec {

;; 7-module.watsup:11.1-11.39
def globals : externval* -> globaladdr*
  ;; 7-module.watsup:12.1-12.32
  def globals([]) = []
  ;; 7-module.watsup:13.1-13.65
  def {externval'* : externval*, ga : globaladdr} globals([GLOBAL_externval(ga)] :: externval'*{externval'}) = [ga] :: $globals(externval'*{externval'})
  ;; 7-module.watsup:14.1-15.15
  def {externval : externval, externval'* : externval*} globals([externval] :: externval'*{externval'}) = $globals(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:17.1-17.37
rec {

;; 7-module.watsup:17.1-17.37
def tables : externval* -> tableaddr*
  ;; 7-module.watsup:18.1-18.31
  def tables([]) = []
  ;; 7-module.watsup:19.1-19.62
  def {externval'* : externval*, ta : tableaddr} tables([TABLE_externval(ta)] :: externval'*{externval'}) = [ta] :: $tables(externval'*{externval'})
  ;; 7-module.watsup:20.1-21.15
  def {externval : externval, externval'* : externval*} tables([externval] :: externval'*{externval'}) = $tables(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:23.1-23.33
rec {

;; 7-module.watsup:23.1-23.33
def mems : externval* -> memaddr*
  ;; 7-module.watsup:24.1-24.29
  def mems([]) = []
  ;; 7-module.watsup:25.1-25.56
  def {externval'* : externval*, ma : memaddr} mems([MEM_externval(ma)] :: externval'*{externval'}) = [ma] :: $mems(externval'*{externval'})
  ;; 7-module.watsup:26.1-27.15
  def {externval : externval, externval'* : externval*} mems([externval] :: externval'*{externval'}) = $mems(externval'*{externval'})
    -- otherwise
}

;; 7-module.watsup:36.1-36.60
def allocfunc : (store, moduleinst, func) -> (store, funcaddr)
  ;; 7-module.watsup:37.1-39.34
  def {expr : expr, fi : funcinst, func : func, local* : local*, mm : moduleinst, s : store, x : idx} allocfunc(s, mm, func) = (s[FUNC_store =.. [fi]], |s.FUNC_store|)
    -- if (fi = {TYPE mm.TYPE_moduleinst[x], MODULE mm, CODE func})
    -- if (func = `FUNC%%*%`(x, local*{local}, expr))

;; 7-module.watsup:41.1-41.63
rec {

;; 7-module.watsup:41.1-41.63
def allocfuncs : (store, moduleinst, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:42.1-42.47
  def {mm : moduleinst, s : store} allocfuncs(s, mm, []) = (s, [])
  ;; 7-module.watsup:43.1-45.51
  def {fa : funcaddr, fa'* : funcaddr*, func : func, func'* : func*, mm : moduleinst, s : store, s_1 : store, s_2 : store} allocfuncs(s, mm, [func] :: func'*{func'}) = (s_2, [fa] :: fa'*{fa'})
    -- if ((s_1, fa) = $allocfunc(s, mm, func))
    -- if ((s_2, fa'*{fa'}) = $allocfuncs(s_1, mm, func'*{func'}))
}

;; 7-module.watsup:47.1-47.63
def allocglobal : (store, globaltype, val) -> (store, globaladdr)
  ;; 7-module.watsup:48.1-49.44
  def {gi : globalinst, globaltype : globaltype, s : store, val : val} allocglobal(s, globaltype, val) = (s[GLOBAL_store =.. [gi]], |s.GLOBAL_store|)
    -- if (gi = {TYPE globaltype, VALUE val})

;; 7-module.watsup:51.1-51.67
rec {

;; 7-module.watsup:51.1-51.67
def allocglobals : (store, globaltype*, val*) -> (store, globaladdr*)
  ;; 7-module.watsup:52.1-52.54
  def {s : store} allocglobals(s, [], []) = (s, [])
  ;; 7-module.watsup:53.1-55.62
  def {ga : globaladdr, ga'* : globaladdr*, globaltype : globaltype, globaltype'* : globaltype*, s : store, s_1 : store, s_2 : store, val : val, val'* : val*} allocglobals(s, [globaltype] :: globaltype'*{globaltype'}, [val] :: val'*{val'}) = (s_2, [ga] :: ga'*{ga'})
    -- if ((s_1, ga) = $allocglobal(s, globaltype, val))
    -- if ((s_2, ga'*{ga'}) = $allocglobals(s_1, globaltype'*{globaltype'}, val'*{val'}))
}

;; 7-module.watsup:57.1-57.55
def alloctable : (store, tabletype) -> (store, tableaddr)
  ;; 7-module.watsup:58.1-59.59
  def {i : nat, j : nat, rt : reftype, s : store, ti : tableinst} alloctable(s, `%%`(`[%..%]`(i, j), rt)) = (s[TABLE_store =.. [ti]], |s.TABLE_store|)
    -- if (ti = {TYPE `%%`(`[%..%]`(i, j), rt), ELEM REF.NULL_ref(rt)^i{}})

;; 7-module.watsup:61.1-61.58
rec {

;; 7-module.watsup:61.1-61.58
def alloctables : (store, tabletype*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.44
  def {s : store} alloctables(s, []) = (s, [])
  ;; 7-module.watsup:63.1-65.53
  def {s : store, s_1 : store, s_2 : store, ta : tableaddr, ta'* : tableaddr*, tabletype : tabletype, tabletype'* : tabletype*} alloctables(s, [tabletype] :: tabletype'*{tabletype'}) = (s_2, [ta] :: ta'*{ta'})
    -- if ((s_1, ta) = $alloctable(s, tabletype))
    -- if ((s_2, ta'*{ta'}) = $alloctables(s_1, tabletype'*{tabletype'}))
}

;; 7-module.watsup:67.1-67.49
def allocmem : (store, memtype) -> (store, memaddr)
  ;; 7-module.watsup:68.1-69.62
  def {i : nat, j : nat, mi : meminst, s : store} allocmem(s, `%I8`(`[%..%]`(i, j))) = (s[MEM_store =.. [mi]], |s.MEM_store|)
    -- if (mi = {TYPE `%I8`(`[%..%]`(i, j)), DATA 0^((i * 64) * $Ki){}})

;; 7-module.watsup:71.1-71.52
rec {

;; 7-module.watsup:71.1-71.52
def allocmems : (store, memtype*) -> (store, memaddr*)
  ;; 7-module.watsup:72.1-72.42
  def {s : store} allocmems(s, []) = (s, [])
  ;; 7-module.watsup:73.1-75.49
  def {ma : memaddr, ma'* : memaddr*, memtype : memtype, memtype'* : memtype*, s : store, s_1 : store, s_2 : store} allocmems(s, [memtype] :: memtype'*{memtype'}) = (s_2, [ma] :: ma'*{ma'})
    -- if ((s_1, ma) = $allocmem(s, memtype))
    -- if ((s_2, ma'*{ma'}) = $allocmems(s_1, memtype'*{memtype'}))
}

;; 7-module.watsup:77.1-77.57
def allocelem : (store, reftype, ref*) -> (store, elemaddr)
  ;; 7-module.watsup:78.1-79.36
  def {ei : eleminst, ref* : ref*, rt : reftype, s : store} allocelem(s, rt, ref*{ref}) = (s[ELEM_store =.. [ei]], |s.ELEM_store|)
    -- if (ei = {TYPE rt, ELEM ref*{ref}})

;; 7-module.watsup:81.1-81.63
rec {

;; 7-module.watsup:81.1-81.63
def allocelems : (store, reftype*, ref**) -> (store, elemaddr*)
  ;; 7-module.watsup:82.1-82.52
  def {s : store} allocelems(s, [], []) = (s, [])
  ;; 7-module.watsup:83.1-85.55
  def {ea : elemaddr, ea'* : elemaddr*, ref* : ref*, ref'** : ref**, rt : reftype, rt'* : reftype*, s : store, s_1 : store, s_2 : store} allocelems(s, [rt] :: rt'*{rt'}, [ref*{ref}] :: ref'*{ref'}*{ref'}) = (s_2, [ea] :: ea'*{ea'})
    -- if ((s_1, ea) = $allocelem(s, rt, ref*{ref}))
    -- if ((s_2, ea'*{ea'}) = $allocelems(s_2, rt'*{rt'}, ref'*{ref'}*{ref'}))
}

;; 7-module.watsup:87.1-87.49
def allocdata : (store, byte*) -> (store, dataaddr)
  ;; 7-module.watsup:88.1-89.28
  def {byte* : byte*, di : datainst, s : store} allocdata(s, byte*{byte}) = (s[DATA_store =.. [di]], |s.DATA_store|)
    -- if (di = {DATA byte*{byte}})

;; 7-module.watsup:91.1-91.54
rec {

;; 7-module.watsup:91.1-91.54
def allocdatas : (store, byte**) -> (store, dataaddr*)
  ;; 7-module.watsup:92.1-92.43
  def {s : store} allocdatas(s, []) = (s, [])
  ;; 7-module.watsup:93.1-95.50
  def {byte* : byte*, byte'** : byte**, da : dataaddr, da'* : dataaddr*, s : store, s_1 : store, s_2 : store} allocdatas(s, [byte]*{byte} :: byte'*{byte'}*{byte'}) = (s_2, [da] :: da'*{da'})
    -- if ((s_1, da) = $allocdata(s, byte*{byte}))
    -- if ((s_2, da'*{da'}) = $allocdatas(s_1, byte'*{byte'}*{byte'}))
}

;; 7-module.watsup:100.1-100.83
def instexport : (funcaddr*, globaladdr*, tableaddr*, memaddr*, export) -> exportinst
  ;; 7-module.watsup:101.1-101.95
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, FUNC_externidx(x))) = {NAME name, VALUE FUNC_externval(fa*{fa}[x])}
  ;; 7-module.watsup:102.1-102.99
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, GLOBAL_externidx(x))) = {NAME name, VALUE GLOBAL_externval(ga*{ga}[x])}
  ;; 7-module.watsup:103.1-103.97
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, TABLE_externidx(x))) = {NAME name, VALUE TABLE_externval(ta*{ta}[x])}
  ;; 7-module.watsup:104.1-104.93
  def {fa* : funcaddr*, ga* : globaladdr*, ma* : memaddr*, name : name, ta* : tableaddr*, x : idx} instexport(fa*{fa}, ga*{ga}, ta*{ta}, ma*{ma}, EXPORT(name, MEM_externidx(x))) = {NAME name, VALUE MEM_externval(ma*{ma}[x])}

;; 7-module.watsup:107.1-107.81
def allocmodule : (store, module, externval*, val*, ref**) -> (store, moduleinst)
  ;; 7-module.watsup:108.1-147.54
  def {byte*^n_data : byte*^n_data, da* : dataaddr*, datamode^n_data : datamode^n_data, ea* : elemaddr*, elemmode^n_elem : elemmode^n_elem, export* : export*, expr_1^n_global : expr^n_global, expr_2*^n_elem : expr*^n_elem, externval* : externval*, fa* : funcaddr*, fa_ex* : funcaddr*, ft : functype, func^n_func : func^n_func, ga* : globaladdr*, ga_ex* : globaladdr*, globaltype^n_global : globaltype^n_global, i_data^n_data : nat^n_data, i_elem^n_elem : nat^n_elem, i_func^n_func : nat^n_func, i_global^n_global : nat^n_global, i_mem^n_mem : nat^n_mem, i_table^n_table : nat^n_table, import* : import*, ma* : memaddr*, ma_ex* : memaddr*, memtype^n_mem : memtype^n_mem, mm : moduleinst, module : module, n_data : n, n_elem : n, n_func : n, n_global : n, n_mem : n, n_table : n, ref** : ref**, rt^n_elem : reftype^n_elem, s : store, s_1 : store, s_2 : store, s_3 : store, s_4 : store, s_5 : store, s_6 : store, start? : start?, ta* : tableaddr*, ta_ex* : tableaddr*, tabletype^n_table : tabletype^n_table, val* : val*, xi* : exportinst*} allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}) = (s_6, mm)
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(TYPE(ft)*{}, import*{import}, func^n_func{func}, GLOBAL(globaltype, expr_1)^n_global{expr_1 globaltype}, TABLE(tabletype)^n_table{tabletype}, MEMORY(memtype)^n_mem{memtype}, `ELEM%%*%`(rt, expr_2*{expr_2}, elemmode)^n_elem{elemmode expr_2 rt}, `DATA%*%`(byte*{byte}, datamode)^n_data{byte datamode}, start?{start}, export*{export}))
    -- if (fa_ex*{fa_ex} = $funcs(externval*{externval}))
    -- if (ga_ex*{ga_ex} = $globals(externval*{externval}))
    -- if (ta_ex*{ta_ex} = $tables(externval*{externval}))
    -- if (ma_ex*{ma_ex} = $mems(externval*{externval}))
    -- if (fa*{fa} = (|s.FUNC_store| + i_func)^(i_func<n_func){i_func})
    -- if (ga*{ga} = (|s.GLOBAL_store| + i_global)^(i_global<n_global){i_global})
    -- if (ta*{ta} = (|s.TABLE_store| + i_table)^(i_table<n_table){i_table})
    -- if (ma*{ma} = (|s.MEM_store| + i_mem)^(i_mem<n_mem){i_mem})
    -- if (ea*{ea} = (|s.ELEM_store| + i_elem)^(i_elem<n_elem){i_elem})
    -- if (da*{da} = (|s.DATA_store| + i_data)^(i_data<n_data){i_data})
    -- if (xi*{xi} = $instexport(fa_ex*{fa_ex} :: fa*{fa}, ga_ex*{ga_ex} :: ga*{ga}, ta_ex*{ta_ex} :: ta*{ta}, ma_ex*{ma_ex} :: ma*{ma}, export)*{export})
    -- if (mm = {TYPE [ft], FUNC fa_ex*{fa_ex} :: fa*{fa}, GLOBAL ga_ex*{ga_ex} :: ga*{ga}, TABLE ta_ex*{ta_ex} :: ta*{ta}, MEM ma_ex*{ma_ex} :: ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT xi*{xi}})
    -- if ((s_1, fa*{fa}) = $allocfuncs(s, mm, func^n_func{func}))
    -- if ((s_2, ga*{ga}) = $allocglobals(s_1, globaltype^n_global{globaltype}, val*{val}))
    -- if ((s_3, ta*{ta}) = $alloctables(s_2, tabletype^n_table{tabletype}))
    -- if ((s_4, ma*{ma}) = $allocmems(s_3, memtype^n_mem{memtype}))
    -- if ((s_5, ea*{ea}) = $allocelems(s_4, rt^n_elem{rt}, ref*{ref}*{ref}))
    -- if ((s_6, da*{da}) = $allocdatas(s_5, byte*{byte}^n_data{byte}))

;; 7-module.watsup:154.1-154.36
rec {

;; 7-module.watsup:154.1-154.36
def concat_instr : instr** -> instr*
  ;; 7-module.watsup:155.1-155.37
  def concat_instr([]) = []
  ;; 7-module.watsup:156.1-156.68
  def {instr* : instr*, instr'** : instr**} concat_instr([instr]*{instr} :: instr'*{instr'}*{instr'}) = instr*{instr} :: $concat_instr(instr'*{instr'}*{instr'})
}

;; 7-module.watsup:158.1-158.33
def runelem : (elem, idx) -> instr*
  ;; 7-module.watsup:159.1-159.56
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, PASSIVE_elemmode), i) = []
  ;; 7-module.watsup:160.1-160.62
  def {expr* : expr*, i : nat, reftype : reftype} runelem(`ELEM%%*%`(reftype, expr*{expr}, DECLARE_elemmode), i) = [ELEM.DROP_instr(i)]
  ;; 7-module.watsup:161.1-163.20
  def {expr* : expr*, i : nat, instr* : instr*, n : n, reftype : reftype, x : idx} runelem(`ELEM%%*%`(reftype, expr*{expr}, ACTIVE_elemmode(x, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) TABLE.INIT_instr(x, i) ELEM.DROP_instr(i)]
    -- if (n = |expr*{expr}|)

;; 7-module.watsup:165.1-165.33
def rundata : (data, idx) -> instr*
  ;; 7-module.watsup:166.1-166.48
  def {byte* : byte*, i : nat} rundata(`DATA%*%`(byte*{byte}, PASSIVE_datamode), i) = []
  ;; 7-module.watsup:167.1-169.20
  def {byte* : byte*, i : nat, instr* : instr*, n : n} rundata(`DATA%*%`(byte*{byte}, ACTIVE_datamode(0, instr*{instr})), i) = instr*{instr} :: [CONST_instr(I32_numtype, 0) CONST_instr(I32_numtype, n) MEMORY.INIT_instr(i) DATA.DROP_instr(i)]
    -- if (n = |byte*{byte}|)

;; 7-module.watsup:171.1-171.53
def instantiate : (store, module, externval*) -> config
  ;; 7-module.watsup:172.1-196.28
  def {data* : data*, elem* : elem*, elemmode* : elemmode*, export* : export*, externval* : externval*, f : frame, f_init : frame, func* : func*, functype* : functype*, global* : global*, globaltype* : globaltype*, i^n_elem : nat^n_elem, import* : import*, instr_1** : instr**, instr_2*** : instr***, instr_data* : instr*, instr_elem* : instr*, j^n_data : nat^n_data, mem* : mem*, mm : moduleinst, mm_init : moduleinst, module : module, n_data : n, n_elem : n, ref** : ref**, reftype* : reftype*, s : store, s' : store, start? : start?, table* : table*, type* : type*, val* : val*, x? : idx?} instantiate(s, module, externval*{externval}) = `%;%*`(`%;%`(s', f), $admininstr_instr(instr_elem)*{instr_elem} :: $admininstr_instr(instr_data)*{instr_data} :: CALL_admininstr(x)?{x})
    -- if (module = `MODULE%*%*%*%*%*%*%*%*%*%*`(type*{type}, import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (type*{type} = TYPE(functype)*{functype})
    -- if (global*{global} = GLOBAL(globaltype, instr_1*{instr_1})*{globaltype instr_1})
    -- if (elem*{elem} = `ELEM%%*%`(reftype, instr_2*{instr_2}*{instr_2}, elemmode)*{elemmode instr_2 reftype})
    -- if (mm_init = {TYPE functype*{functype}, FUNC $funcs(externval*{externval}), GLOBAL $globals(externval*{externval}), TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f_init = {LOCAL [], MODULE mm_init})
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), $admininstr_instr(instr_1)*{instr_1}), [$admininstr_val(val)]))*{instr_1 val}
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f_init), $admininstr_instr(instr_2)*{instr_2}), [$admininstr_ref(ref)]))*{instr_2 ref}*{instr_2 ref}
    -- if ((s', mm) = $allocmodule(s, module, externval*{externval}, val*{val}, ref*{ref}*{ref}))
    -- if (f = {LOCAL [], MODULE mm})
    -- if (n_elem = |elem*{elem}|)
    -- if (instr_elem*{instr_elem} = $concat_instr($runelem(elem*{elem}[i], i)^(i<n_elem){i}))
    -- if (n_data = |data*{data}|)
    -- if (instr_data*{instr_data} = $concat_instr($rundata(data*{data}[j], j)^(j<n_data){j}))
    -- if (start?{start} = START(x)?{x})

;; 7-module.watsup:203.1-203.44
def invoke : (store, funcaddr, val*) -> config
  ;; 7-module.watsup:204.1-215.51
  def {f : frame, fa : funcaddr, mm : moduleinst, n : n, s : store, t_1^n : valtype^n, t_2* : valtype*, val^n : val^n} invoke(s, fa, val^n{val}) = `%;%*`(`%;%`(s, f), $admininstr_val(val)^n{val} :: [CALL_ADDR_admininstr(fa)])
    -- if (mm = {TYPE [], FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE mm})
    -- if ($funcinst(`%;%`(s, f))[fa].TYPE_funcinst = `%->%`(t_1^n{t_1}, t_2*{t_2}))

;; A-binary.watsup:47.1-47.57
rec {

;; A-binary.watsup:47.1-47.57
def concat_bytes : byte** -> byte*
  ;; A-binary.watsup:48.1-48.37
  def concat_bytes([]) = []
  ;; A-binary.watsup:49.1-49.52
  def {b* : byte*, b'** : byte**} concat_bytes([b]*{b} :: b'*{b'}*{b'}) = b*{b} :: $concat_bytes(b'*{b'}*{b'})
}

;; A-binary.watsup:51.1-51.24
rec {

;; A-binary.watsup:51.1-51.24
def utf8 : name -> byte*
  ;; A-binary.watsup:52.1-52.44
  def {b : byte, c : c_numtype} utf8([c]) = [b]
    -- if ((c < 128) /\ (c = b))
  ;; A-binary.watsup:53.1-53.93
  def {b_1 : byte, b_2 : byte, c : c_numtype} utf8([c]) = [b_1 b_2]
    -- if (((128 <= c) /\ (c < 2048)) /\ (c = (((2 ^ 6) * (b_1 - 192)) + (b_2 - 128))))
  ;; A-binary.watsup:54.1-54.144
  def {b_1 : byte, b_2 : byte, b_3 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3]
    -- if ((((2048 <= c) /\ (c < 55296)) \/ ((57344 <= c) /\ (c < 65536))) /\ (c = ((((2 ^ 12) * (b_1 - 224)) + ((2 ^ 6) * (b_2 - 128))) + (b_3 - 128))))
  ;; A-binary.watsup:55.1-55.145
  def {b_1 : byte, b_2 : byte, b_3 : byte, b_4 : byte, c : c_numtype} utf8([c]) = [b_1 b_2 b_3 b_4]
    -- if (((65536 <= c) /\ (c < 69632)) /\ (c = (((((2 ^ 18) * (b_1 - 240)) + ((2 ^ 12) * (b_2 - 128))) + ((2 ^ 6) * (b_3 - 128))) + (b_4 - 128))))
  ;; A-binary.watsup:56.1-56.41
  def {c* : c_numtype*} utf8(c*{c}) = $concat_bytes($utf8([c])*{c})
}

;; A-binary.watsup:577.1-577.60
rec {

;; A-binary.watsup:577.1-577.60
def concat_locals : local** -> local*
  ;; A-binary.watsup:578.1-578.38
  def concat_locals([]) = []
  ;; A-binary.watsup:579.1-579.62
  def {loc* : local*, loc'** : local**} concat_locals([loc]*{loc} :: loc'*{loc'}*{loc'}) = loc*{loc} :: $concat_locals(loc'*{loc'}*{loc'})
}

;; A-binary.watsup:582.1-582.29
syntax code = (local*, expr)

== IL Validation after pass animate...
== Complete.
```
# More tricky tests

```sh
$ (cd ../test-middlend; ../src/exe-watsup/main.exe test.watsup -l --print-all-il --all-passes --check)
== Parsing...
== Elaboration...

;; test.watsup:5.1-5.29
relation HasSize: `%|-%`(nat, nat)

;; test.watsup:6.1-6.41
relation TestNestedIter: `**%*|-*%*`(nat***, nat**)
  ;; test.watsup:11.1-13.21
  rule _ {m*+ : nat*+, n**+ : nat**+}:
    `**%*|-*%*`(n*{n}*{n}+{n}, m*{m}+{m})
    -- (if (|n*{n}| = m))*{m n}+{m n}

== IL Validation...
== Running pass sub...

;; test.watsup:5.1-5.29
relation HasSize: `%|-%`(nat, nat)

;; test.watsup:6.1-6.41
relation TestNestedIter: `**%*|-*%*`(nat***, nat**)
  ;; test.watsup:11.1-13.21
  rule _ {m*+ : nat*+, n**+ : nat**+}:
    `**%*|-*%*`(n*{n}*{n}+{n}, m*{m}+{m})
    -- (if (|n*{n}| = m))*{m n}+{m n}

== IL Validation after pass sub...
== Running pass totalize...

;; test.watsup:5.1-5.29
relation HasSize: `%|-%`(nat, nat)

;; test.watsup:6.1-6.41
relation TestNestedIter: `**%*|-*%*`(nat***, nat**)
  ;; test.watsup:11.1-13.21
  rule _ {m*+ : nat*+, n**+ : nat**+}:
    `**%*|-*%*`(n*{n}*{n}+{n}, m*{m}+{m})
    -- (if (|n*{n}| = m))*{m n}+{m n}

== IL Validation after pass totalize...
== Running pass the-elimination...

;; test.watsup:5.1-5.29
relation HasSize: `%|-%`(nat, nat)

;; test.watsup:6.1-6.41
relation TestNestedIter: `**%*|-*%*`(nat***, nat**)
  ;; test.watsup:11.1-13.21
  rule _ {m*+ : nat*+, n**+ : nat**+}:
    `**%*|-*%*`(n*{n}*{n}+{n}, m*{m}+{m})
    -- (if (|n*{n}| = m))*{m n}+{m n}

== IL Validation after pass the-elimination...
== Running pass wildcards...

;; test.watsup:5.1-5.29
relation HasSize: `%|-%`(nat, nat)

;; test.watsup:6.1-6.41
relation TestNestedIter: `**%*|-*%*`(nat***, nat**)
  ;; test.watsup:11.1-13.21
  rule _ {m*+ : nat*+, n**+ : nat**+}:
    `**%*|-*%*`(n*{n}*{n}+{n}, m*{m}+{m})
    -- (if (|n*{n}| = m))*{m n}+{m n}

== IL Validation after pass wildcards...
== Running pass sideconditions...

;; test.watsup:5.1-5.29
relation HasSize: `%|-%`(nat, nat)

;; test.watsup:6.1-6.41
relation TestNestedIter: `**%*|-*%*`(nat***, nat**)
  ;; test.watsup:11.1-13.21
  rule _ {m*+ : nat*+, n**+ : nat**+}:
    `**%*|-*%*`(n*{n}*{n}+{n}, m*{m}+{m})
    -- if (|m*{m}+{m}| = |n*{n}*{n}+{n}|)
    -- (if (|m*{m}| = |n*{n}*{n}|))+{m n}
    -- (if (|n*{n}| = m))*{m n}+{m n}

== IL Validation after pass sideconditions...
== Running pass animate...

;; test.watsup:5.1-5.29
relation HasSize: `%|-%`(nat, nat)

;; test.watsup:6.1-6.41
relation TestNestedIter: `**%*|-*%*`(nat***, nat**)
  ;; test.watsup:11.1-13.21
  rule _ {m*+ : nat*+, n**+ : nat**+}:
    `**%*|-*%*`(n*{n}*{n}+{n}, m*{m}+{m})
    -- if (|m*{m}+{m}| = |n*{n}*{n}+{n}|)
    -- (if (|m*{m}| = |n*{n}*{n}|))+{m n}
    -- (if (|n*{n}| = m))*{m n}+{m n}

== IL Validation after pass animate...
== Complete.
```
