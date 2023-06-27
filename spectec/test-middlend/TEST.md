# Preview

```sh
$ (cd ../spec && ../src/exe-watsup/main.exe *.watsup -l --print-all-il --all-passes --check)
== Parsing...
== Elaboration...

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:9.1-9.37
syntax name = text

;; 1-syntax.watsup:14.1-14.36
syntax byte = nat

;; 1-syntax.watsup:15.1-15.45
syntax u32 = nat

;; 1-syntax.watsup:22.1-22.36
syntax idx = nat

;; 1-syntax.watsup:23.1-23.49
syntax funcidx = idx

;; 1-syntax.watsup:24.1-24.49
syntax globalidx = idx

;; 1-syntax.watsup:25.1-25.47
syntax tableidx = idx

;; 1-syntax.watsup:26.1-26.46
syntax memidx = idx

;; 1-syntax.watsup:27.1-27.45
syntax elemidx = idx

;; 1-syntax.watsup:28.1-28.45
syntax dataidx = idx

;; 1-syntax.watsup:29.1-29.47
syntax labelidx = idx

;; 1-syntax.watsup:30.1-30.47
syntax localidx = idx

;; 1-syntax.watsup:39.1-40.22
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:41.1-42.5
syntax vectype =
  | V128

;; 1-syntax.watsup:43.1-44.20
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:45.1-46.34
syntax valtype =
  | I32
  | I64
  | F32
  | F64
  | V128
  | FUNCREF
  | EXTERNREF
  | BOT

;; 1-syntax.watsup:48.1-48.39
syntax in =
  | I32
  | I64

;; 1-syntax.watsup:49.1-49.39
syntax fn =
  | F32
  | F64

;; 1-syntax.watsup:56.1-57.11
syntax resulttype = valtype*

;; 1-syntax.watsup:59.1-60.17
syntax limits = `[%..%?]`(u32, u32?)

;; 1-syntax.watsup:61.1-62.15
syntax globaltype = `MUT%?%`(()?, valtype)

;; 1-syntax.watsup:63.1-64.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:65.1-66.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:67.1-68.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:69.1-70.10
syntax elemtype = reftype

;; 1-syntax.watsup:71.1-72.5
syntax datatype = OK

;; 1-syntax.watsup:73.1-74.66
syntax externtype =
  | GLOBAL(globaltype)
  | FUNC(functype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:86.1-86.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:88.1-88.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:89.1-89.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:91.1-93.62
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

;; 1-syntax.watsup:94.1-94.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:96.1-96.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:97.1-97.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:99.1-100.108
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:101.1-101.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:103.1-103.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:104.1-104.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:105.1-105.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:106.1-106.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:107.1-107.39
syntax cvtop =
  | CONVERT
  | REINTERPRET

;; 1-syntax.watsup:117.1-117.23
syntax c_numtype = nat

;; 1-syntax.watsup:118.1-118.23
syntax c_vectype = nat

;; 1-syntax.watsup:121.1-121.52
syntax blocktype = functype

;; 1-syntax.watsup:156.1-177.80
rec {

;; 1-syntax.watsup:156.1-177.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
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
  | LOAD(numtype, (n, sx)?, u32, u32)
  | STORE(numtype, n?, u32, u32)
}

;; 1-syntax.watsup:179.1-180.9
syntax expr = instr*

;; 1-syntax.watsup:187.1-187.50
syntax elemmode =
  | TABLE(tableidx, expr)
  | DECLARE

;; 1-syntax.watsup:188.1-188.39
syntax datamode =
  | MEMORY(memidx, expr)

;; 1-syntax.watsup:190.1-191.30
syntax func = `FUNC%%*%`(functype, valtype*, expr)

;; 1-syntax.watsup:192.1-193.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:194.1-195.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:196.1-197.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:198.1-199.31
syntax elem = `ELEM%%*%?`(reftype, expr*, elemmode?)

;; 1-syntax.watsup:200.1-201.23
syntax data = `DATA%*%?`(byte*, datamode?)

;; 1-syntax.watsup:202.1-203.16
syntax start = START(funcidx)

;; 1-syntax.watsup:205.1-206.62
syntax externuse =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:207.1-208.24
syntax export = EXPORT(name, externuse)

;; 1-syntax.watsup:209.1-210.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:212.1-213.70
syntax module = `MODULE%*%*%*%*%*%*%*%?%*`(import*, func*, global*, table*, mem*, elem*, data*, start?, export*)

;; 2-aux.watsup:3.1-3.14
def Ki : nat
  ;; 2-aux.watsup:4.1-4.15
  def Ki = 1024

;; 2-aux.watsup:9.1-9.25
rec {

;; 2-aux.watsup:9.1-9.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:10.1-10.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:11.1-11.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:12.1-12.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:19.1-19.55
def size : valtype -> nat
  ;; 2-aux.watsup:20.1-20.20
  def size(I32_valtype) = 32
  ;; 2-aux.watsup:21.1-21.20
  def size(I64_valtype) = 64
  ;; 2-aux.watsup:22.1-22.20
  def size(F32_valtype) = 32
  ;; 2-aux.watsup:23.1-23.20
  def size(F64_valtype) = 64
  ;; 2-aux.watsup:24.1-24.22
  def size(V128_valtype) = 128

;; 2-aux.watsup:29.1-29.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:30.1-30.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:32.1-32.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:33.1-33.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:35.1-44.39
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

;; 3-typing.watsup:3.1-6.60
syntax context = {FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:14.1-14.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:22.1-24.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%?]`(n_1, ?(n_2)), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:15.1-15.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:26.1-27.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:16.1-16.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:29.1-30.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:17.1-17.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:32.1-34.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:18.1-18.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:36.1-38.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:19.1-19.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:41.1-43.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:45.1-47.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:49.1-51.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:53.1-55.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:61.1-61.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:64.1-65.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:67.1-68.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:62.1-62.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:70.1-72.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:75.1-75.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:83.1-86.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%?]`(n_11, ?(n_12)), `[%..%?]`(n_21, ?(n_22)))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:76.1-76.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:88.1-89.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:77.1-77.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:91.1-92.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:78.1-78.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:94.1-96.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:79.1-79.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:98.1-100.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:80.1-80.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:103.1-105.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:107.1-109.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:111.1-113.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:115.1-117.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:172.1-172.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:174.1-176.29
  rule _ {C : context, ft : functype}:
    `%|-%:%`(C, ft, ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:123.1-124.67
rec {

;; 3-typing.watsup:123.1-123.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:153.1-154.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:156.1-157.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:159.1-160.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:163.1-164.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?(t)), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:166.1-169.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = (numtype <: valtype)) \/ (t' = (vectype <: valtype)))

  ;; 3-typing.watsup:178.1-181.57
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:183.1-186.57
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1]*{t_1}, RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:188.1-192.59
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:195.1-197.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:199.1-201.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:203.1-206.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:208.1-210.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 3-typing.watsup:212.1-214.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (C.FUNC_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:216.1-219.26
  rule call_indirect {C : context, ft : functype, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, ft), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (ft = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:222.1-223.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [(nt <: valtype)]))

  ;; 3-typing.watsup:225.1-226.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([(nt <: valtype)], [(nt <: valtype)]))

  ;; 3-typing.watsup:228.1-229.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([(nt <: valtype) (nt <: valtype)], [(nt <: valtype)]))

  ;; 3-typing.watsup:231.1-232.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([(nt <: valtype)], [I32_valtype]))

  ;; 3-typing.watsup:234.1-235.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([(nt <: valtype) (nt <: valtype)], [I32_valtype]))

  ;; 3-typing.watsup:238.1-240.23
  rule extend {C : context, n : n, nt : numtype}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([(nt <: valtype)], [(nt <: valtype)]))
    -- if (n <= $size(nt <: valtype))

  ;; 3-typing.watsup:242.1-245.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([(nt_2 <: valtype)], [(nt_1 <: valtype)]))
    -- if (nt_1 =/= nt_2)
    -- if ($size(nt_1 <: valtype) = $size(nt_2 <: valtype))

  ;; 3-typing.watsup:247.1-250.52
  rule convert-i {C : context, in_1 : in, in_2 : in, sx? : sx?}:
    `%|-%:%`(C, CVTOP_instr((in_1 <: numtype), CONVERT_cvtop, (in_2 <: numtype), sx?{sx}), `%->%`([(in_2 <: valtype)], [(in_1 <: valtype)]))
    -- if (in_1 =/= in_2)
    -- if ((sx?{sx} = ?()) <=> ($size(in_1 <: valtype) > $size(in_2 <: valtype)))

  ;; 3-typing.watsup:252.1-254.22
  rule convert-f {C : context, fn_1 : fn, fn_2 : fn}:
    `%|-%:%`(C, CVTOP_instr((fn_1 <: numtype), CONVERT_cvtop, (fn_2 <: numtype), ?()), `%->%`([(fn_2 <: valtype)], [(fn_1 <: valtype)]))
    -- if (fn_1 =/= fn_2)

  ;; 3-typing.watsup:257.1-258.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [(rt <: valtype)]))

  ;; 3-typing.watsup:260.1-262.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:264.1-265.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([(rt <: valtype)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-270.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:272.1-274.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:276.1-278.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:281.1-283.29
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(()?{}, t))

  ;; 3-typing.watsup:285.1-287.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(()), t))

  ;; 3-typing.watsup:290.1-292.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [(rt <: valtype)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:294.1-296.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype (rt <: valtype)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:298.1-300.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:302.1-304.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([(rt <: valtype) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:306.1-308.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype (rt <: valtype) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:310.1-313.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:315.1-318.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:320.1-322.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:325.1-327.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:329.1-331.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:333.1-335.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:337.1-339.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:341.1-344.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:346.1-348.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:350.1-355.32
  rule load {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, n_A, n_O), `%->%`([I32_valtype], [(nt <: valtype)]))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (in <: numtype)))

  ;; 3-typing.watsup:357.1-362.32
  rule store {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, n_A, n_O), `%->%`([I32_valtype (nt <: valtype)], []))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= ($size(nt <: valtype) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = (in <: numtype)))

;; 3-typing.watsup:124.1-124.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:133.1-134.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:136.1-139.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:141.1-146.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:148.1-150.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:125.1-125.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:128.1-130.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:367.1-367.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:371.1-372.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:374.1-375.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:377.1-378.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:380.1-382.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(), t))

;; 3-typing.watsup:368.1-368.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:385.1-386.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:369.1-369.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:389.1-392.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:397.1-397.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:408.1-412.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, `FUNC%%*%`(ft, t*{t}, expr), ft)
    -- if (ft = `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:398.1-398.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:414.1-418.40
  rule _ {C : context, expr : expr, gt : globaltype, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `MUT%?%`(()?{}, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:399.1-399.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:420.1-422.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:400.1-400.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:424.1-426.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:403.1-403.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:437.1-440.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:442.1-443.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:401.1-401.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:428.1-431.40
  rule _ {C : context, elemmode? : elemmode?, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%?`(rt, expr*{expr}, elemmode?{elemmode}), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [(rt <: valtype)]))*{expr}
    -- (Elemmode_ok: `%|-%:%`(C, elemmode, rt))?{elemmode}

;; 3-typing.watsup:404.1-404.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:445.1-448.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, MEMORY_datamode(0, expr))
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

;; 3-typing.watsup:402.1-402.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:433.1-435.40
  rule _ {C : context, b* : byte*, datamode? : datamode?}:
    `%|-%:OK`(C, `DATA%*%?`(b*{b}, datamode?{datamode}))
    -- (Datamode_ok: `%|-%:OK`(C, datamode))?{datamode}

;; 3-typing.watsup:405.1-405.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:450.1-452.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:455.1-455.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:459.1-461.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:457.1-457.83
relation Externuse_ok: `%|-%:%`(context, externuse, externtype)
  ;; 3-typing.watsup:467.1-469.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externuse(x), FUNC_externtype(ft))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:471.1-473.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externuse(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:475.1-477.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externuse(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:479.1-481.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externuse(x), MEM_externtype(mt))
    -- if (C.MEM_context[x] = mt)

;; 3-typing.watsup:456.1-456.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:463.1-465.39
  rule _ {C : context, externuse : externuse, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externuse), xt)
    -- Externuse_ok: `%|-%:%`(C, externuse, xt)

;; 3-typing.watsup:484.1-484.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:486.1-500.16
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (C = {FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

;; 4-runtime.watsup:3.1-3.39
syntax addr = nat

;; 4-runtime.watsup:4.1-4.53
syntax funcaddr = addr

;; 4-runtime.watsup:5.1-5.53
syntax globaladdr = addr

;; 4-runtime.watsup:6.1-6.51
syntax tableaddr = addr

;; 4-runtime.watsup:7.1-7.50
syntax memaddr = addr

;; 4-runtime.watsup:8.1-8.49
syntax elemaddr = addr

;; 4-runtime.watsup:9.1-9.49
syntax dataaddr = addr

;; 4-runtime.watsup:10.1-10.51
syntax labeladdr = addr

;; 4-runtime.watsup:11.1-11.49
syntax hostaddr = addr

;; 4-runtime.watsup:24.1-25.24
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:26.1-27.67
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:28.1-29.10
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:31.1-32.18
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:38.1-39.66
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:44.1-44.44
def default_ : valtype -> val
  ;; 4-runtime.watsup:45.1-45.35
  def default_(I32_valtype) = CONST_val(I32_numtype, 0)
  ;; 4-runtime.watsup:46.1-46.35
  def default_(I64_valtype) = CONST_val(I64_numtype, 0)
  ;; 4-runtime.watsup:47.1-47.35
  def default_(F32_valtype) = CONST_val(F32_numtype, 0)
  ;; 4-runtime.watsup:48.1-48.35
  def default_(F64_valtype) = CONST_val(F64_numtype, 0)
  ;; 4-runtime.watsup:49.1-49.44
  def default_(FUNCREF_valtype) = REF.NULL_val(FUNCREF_reftype)
  ;; 4-runtime.watsup:50.1-50.48
  def default_(EXTERNREF_valtype) = REF.NULL_val(EXTERNREF_reftype)

;; 4-runtime.watsup:72.1-74.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:84.1-91.25
syntax moduleinst = {FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:55.1-57.16
syntax funcinst = {MODULE moduleinst, CODE func}

;; 4-runtime.watsup:58.1-60.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:61.1-63.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:64.1-66.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:67.1-69.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:70.1-71.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:76.1-82.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:93.1-95.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:96.1-96.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:180.1-187.5
rec {

;; 4-runtime.watsup:180.1-187.5
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
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
  | LOAD(numtype, (n, sx)?, u32, u32)
  | STORE(numtype, n?, u32, u32)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)
  | CALL_ADDR(funcaddr)
  | LABEL_(n, instr*, admininstr*)
  | FRAME_(n, frame, admininstr*)
  | TRAP
}

;; 4-runtime.watsup:97.1-97.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:115.1-115.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:116.1-116.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:118.1-118.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:125.1-125.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:119.1-119.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:126.1-126.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:120.1-120.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:127.1-127.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:121.1-121.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:128.1-128.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:122.1-122.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:129.1-129.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:123.1-123.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:130.1-130.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:132.1-132.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:140.1-140.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:133.1-133.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:141.1-141.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:134.1-134.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:142.1-142.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:135.1-135.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:143.1-143.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:136.1-136.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:144.1-144.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:137.1-137.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:145.1-145.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:138.1-138.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:146.1-146.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:149.1-149.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:158.1-158.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:150.1-150.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:159.1-159.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:151.1-151.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:160.1-160.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:152.1-152.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:161.1-161.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:153.1-153.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:162.1-162.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:154.1-154.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:163.1-163.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:155.1-155.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:164.1-164.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:156.1-156.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:165.1-165.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:167.1-167.49
def grow_table : (tableinst, nat, ref) -> tableinst
  ;; 4-runtime.watsup:169.1-172.57
  def {i : nat, i' : nat, j? : nat?, n : n, r : ref, r'* : ref*, reftype : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ti'
    -- if (ti = {TYPE `%%`(`[%..%?]`(i, j?{j}), reftype), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%?]`(i', j?{j}), reftype), ELEM r'*{r'} :: r^n{}})

;; 4-runtime.watsup:168.1-168.41
def grow_memory : (meminst, nat) -> meminst
  ;; 4-runtime.watsup:173.1-176.66
  def {b* : byte*, i : nat, i' : nat, j? : nat?, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = mi'
    -- if (mi = {TYPE `%I8`(`[%..%?]`(i, j?{j})), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%?]`(i', j?{j})), DATA b*{b} :: 0^((n * 64) * $Ki){}})

;; 4-runtime.watsup:189.1-192.21
rec {

;; 4-runtime.watsup:189.1-192.21
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

;; 5-numerics.watsup:13.1-13.28
def bytes_ : (nat, c_numtype) -> byte*

;; 5-numerics.watsup:14.1-14.47
def inverse_of_bytes_ : (nat, byte*) -> c_numtype

;; 6-reduction.watsup:4.1-4.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:16.1-17.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:19.1-20.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:22.1-23.24
  rule drop {val : val}:
    `%*~>%*`([(val <: admininstr) DROP_admininstr], [])

  ;; 6-reduction.watsup:26.1-28.16
  rule select-true {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([(val_1 <: admininstr) (val_2 <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [(val_1 <: admininstr)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:30.1-32.14
  rule select-false {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([(val_1 <: admininstr) (val_2 <: admininstr) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [(val_2 <: admininstr)])
    -- if (c = 0)

  ;; 6-reduction.watsup:35.1-37.28
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`((val <: admininstr)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})], [LABEL__admininstr(n, [], (val <: admininstr)^k{val} :: (instr <: admininstr)*{instr})])
    -- if (bt = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:39.1-41.28
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`((val <: admininstr)^k{val} :: [LOOP_admininstr(bt, instr*{instr})], [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], (val <: admininstr)^k{val} :: (instr <: admininstr)*{instr})])
    -- if (bt = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:43.1-45.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:47.1-49.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:52.1-53.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, (val <: admininstr)*{val})], (val <: admininstr)*{val})

  ;; 6-reduction.watsup:57.1-58.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [BR_admininstr(0)] :: (instr <: admininstr)*{instr})], (val <: admininstr)^n{val} :: (instr' <: admininstr)*{instr'})

  ;; 6-reduction.watsup:60.1-61.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, (val <: admininstr)*{val} :: [BR_admininstr(l + 1)] :: (instr <: admininstr)*{instr})], (val <: admininstr)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:64.1-66.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:68.1-70.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:73.1-75.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:77.1-79.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:102.1-103.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, (val <: admininstr)^n{val})], (val <: admininstr)^n{val})

  ;; 6-reduction.watsup:105.1-106.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, (val' <: admininstr)*{val'} :: (val <: admininstr)^n{val} :: [RETURN_admininstr] :: (instr <: admininstr)*{instr})], (val <: admininstr)^n{val})

  ;; 6-reduction.watsup:108.1-109.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, (val <: admininstr)*{val} :: [RETURN_admininstr] :: (instr <: admininstr)*{instr})], (val <: admininstr)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:112.1-114.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 6-reduction.watsup:116.1-118.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:121.1-123.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 6-reduction.watsup:125.1-127.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:130.1-132.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 6-reduction.watsup:134.1-136.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 6-reduction.watsup:139.1-140.70
  rule extend {c : c_numtype, n : n, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, $size(nt <: valtype), S_sx, c))])

  ;; 6-reduction.watsup:143.1-145.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [c])

  ;; 6-reduction.watsup:147.1-149.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:156.1-158.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([(val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(rt))

  ;; 6-reduction.watsup:160.1-162.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([(val <: admininstr) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:171.1-172.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([(val <: admininstr) LOCAL.TEE_admininstr(x)], [(val <: admininstr) (val <: admininstr) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:5.1-5.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:82.1-83.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:85.1-89.17
  rule call_indirect-call {a : addr, ft : functype, ft' : functype, i : nat, instr* : instr*, t* : valtype*, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [CALL_ADDR_admininstr(a)])
    -- if ($table(z, x).ELEM_tableinst[i] = REF.FUNC_ADDR_ref(a))
    -- if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(ft', t*{t}, instr*{instr}))
    -- if (ft = ft')

  ;; 6-reduction.watsup:91.1-93.15
  rule call_indirect-trap {ft : functype, i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:95.1-99.52
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, m : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, (val <: admininstr)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], (instr <: admininstr)*{instr})])])
    -- if ($funcinst(z)[a] = {MODULE m, CODE func})
    -- if (func = `FUNC%%*%`(`%->%`(t_1^k{t_1}, t_2^n{t_2}), t*{t}, instr*{instr}))
    -- if (f = {LOCAL val^k{val} :: $default_(t)*{t}, MODULE m})

  ;; 6-reduction.watsup:152.1-153.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:165.1-166.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [($local(z, x) <: admininstr)])

  ;; 6-reduction.watsup:175.1-176.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [($global(z, x).VALUE_globalinst <: admininstr)])

  ;; 6-reduction.watsup:182.1-184.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:186.1-188.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [($table(z, x).ELEM_tableinst[i] <: admininstr)])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:199.1-201.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 6-reduction.watsup:214.1-216.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:218.1-221.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:223.1-227.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) (val <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:230.1-232.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:234.1-237.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:239.1-244.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:246.1-250.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:253.1-255.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:257.1-260.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:262.1-266.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) ($elem(z, y).ELEM_eleminst[i] <: admininstr) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:273.1-275.53
  rule load-num-trap {i : nat, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), n_A, n_O)]), [TRAP_admininstr])
    -- if (((i + n_O) + ($size(nt <: valtype) / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:277.1-279.71
  rule load-num-val {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), n_A, n_O)]), [CONST_admininstr(nt, c)])
    -- if ($bytes_($size(nt <: valtype), c) = $mem(z, 0).DATA_meminst[(i + n_O) : ($size(nt <: valtype) / 8)])

  ;; 6-reduction.watsup:281.1-283.45
  rule load-pack-trap {i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), n_A, n_O)]), [TRAP_admininstr])
    -- if (((i + n_O) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:285.1-287.55
  rule load-pack-val {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), n_A, n_O)]), [CONST_admininstr(nt, $ext(n, $size(nt <: valtype), sx, c))])
    -- if ($bytes_(n, c) = $mem(z, 0).DATA_meminst[(i + n_O) : (n / 8)])

  ;; 6-reduction.watsup:307.1-309.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:322.1-324.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:326.1-329.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:331.1-335.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (val <: admininstr) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) (val <: admininstr) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (i + 1)) (val <: admininstr) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:338.1-340.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:342.1-345.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:347.1-352.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), 0, 0) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:354.1-358.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), 0, 0) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:361.1-363.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:365.1-368.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:370.1-374.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- otherwise

;; 6-reduction.watsup:3.1-3.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:7.1-9.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*{instr}), `%;%*`(z, (instr' <: admininstr)*{instr'}))
    -- Step_pure: `%*~>%*`((instr <: admininstr)*{instr}, (instr' <: admininstr)*{instr'})

  ;; 6-reduction.watsup:11.1-13.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, (instr <: admininstr)*{instr}), `%;%*`(z, (instr' <: admininstr)*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, (instr <: admininstr)*{instr}), (instr' <: admininstr)*{instr'})

  ;; 6-reduction.watsup:168.1-169.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(val <: admininstr) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:178.1-179.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(val <: admininstr) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:190.1-192.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:194.1-196.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) (ref <: admininstr) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:204.1-208.36
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, ti' : tableinst, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti'), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if ($table(z, x) = ti)
    -- if ($grow_table(ti, n, ref) = ti')
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)

  ;; 6-reduction.watsup:210.1-211.64
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [(ref <: admininstr) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 6-reduction.watsup:269.1-270.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:290.1-292.53
  rule store-num-trap {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + n_O) + ($size(nt <: valtype) / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:294.1-296.35
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), n_A, n_O)]), `%;%*`($with_mem(z, 0, (i + n_O), ($size(nt <: valtype) / 8), b*{b}), []))
    -- if (b*{b} = $bytes_($size(nt <: valtype), c))

  ;; 6-reduction.watsup:298.1-300.45
  rule store-pack-trap {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + n_O) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:302.1-304.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), n_A, n_O)]), `%;%*`($with_mem(z, 0, (i + n_O), (n / 8), b*{b}), []))
    -- if (b*{b} = $bytes_(n, $wrap_(($size(nt <: valtype), n), c)))

  ;; 6-reduction.watsup:312.1-316.34
  rule memory.grow-succeed {mi : meminst, mi' : meminst, n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi'), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- if ($mem(z, 0) = mi)
    -- if ($grow_memory(mi, n) = mi')
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)

  ;; 6-reduction.watsup:318.1-319.59
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 6-reduction.watsup:377.1-378.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:3.1-3.64
rec {

;; 7-module.watsup:3.1-3.64
def alloc_import : (moduleinst, import*, externval*) -> moduleinst
  ;; 7-module.watsup:5.1-5.43
  def {m : moduleinst} alloc_import(m, [], []) = m
  ;; 7-module.watsup:7.1-12.60
  def {externtype : externtype, externval : externval, externval'* : externval*, fa : funcaddr, functype : functype, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = FUNC_externtype(functype))
    -- if (externval = FUNC_externval(fa))
    -- if (m_new = m[FUNC_moduleinst =.. [fa]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:14.1-19.60
  def {externtype : externtype, externval : externval, externval'* : externval*, ga : globaladdr, globaltype : globaltype, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = GLOBAL_externtype(globaltype))
    -- if (externval = GLOBAL_externval(ga))
    -- if (m_new = m[GLOBAL_moduleinst =.. [ga]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:21.1-26.60
  def {externtype : externtype, externval : externval, externval'* : externval*, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name, ta : tableaddr, tabletype : tabletype} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = TABLE_externtype(tabletype))
    -- if (externval = TABLE_externval(ta))
    -- if (m_new = m[TABLE_moduleinst =.. [ta]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:28.1-33.60
  def {externtype : externtype, externval : externval, externval'* : externval*, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, ma : memaddr, memtype : memtype, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = MEM_externtype(memtype))
    -- if (externval = MEM_externval(ma))
    -- if (m_new = m[MEM_moduleinst =.. [ma]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
}

;; 7-module.watsup:36.1-36.51
rec {

;; 7-module.watsup:36.1-36.51
def alloc_func : (state, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:38.1-38.48
  def {f : frame, s : store} alloc_func(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:40.1-44.56
  def {f : frame, fa : funcaddr, fa'* : funcaddr*, fi : funcinst, func : func, func'* : func*, s : store, s_new : store, s_res : store} alloc_func(`%;%`(s, f), [func] :: func'*{func'}) = (s_res, [fa] :: fa'*{fa'})
    -- if (fi = {MODULE f.MODULE_frame, CODE func})
    -- if (fa = |$funcinst(`%;%`(s, f))|)
    -- if (s_new = s[FUNC_store =.. [fi]])
    -- if ((s_res, fa'*{fa'}) = $alloc_func(`%;%`(s_new, f), func'*{func'}))
}

;; 7-module.watsup:47.1-47.57
rec {

;; 7-module.watsup:47.1-47.57
def alloc_global : (state, global*) -> (store, globaladdr*)
  ;; 7-module.watsup:49.1-49.50
  def {f : frame, s : store} alloc_global(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:51.1-57.60
  def {f : frame, ga : globaladdr, ga'* : globaladdr*, gi : globalinst, global : global, global'* : global*, globaltype : globaltype, instr* : instr*, s : store, s_new : store, s_res : store, val : val} alloc_global(`%;%`(s, f), [global] :: global'*{global'}) = (s_res, [ga] :: ga'*{ga'})
    -- if (global = GLOBAL(globaltype, instr*{instr}))
    -- Step_read: `%~>%*`(`%;%*`(`%;%`(s, f), (instr <: admininstr)*{instr}), [(val <: admininstr)])
    -- if (gi = {TYPE globaltype, VALUE val})
    -- if (ga = |$globalinst(`%;%`(s, f))|)
    -- if (s_new = s[GLOBAL_store =.. [gi]])
    -- if ((s_res, ga'*{ga'}) = $alloc_global(`%;%`(s_new, f), global'*{global'}))
}

;; 7-module.watsup:60.1-60.54
rec {

;; 7-module.watsup:60.1-60.54
def alloc_table : (state, table*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.49
  def {f : frame, s : store} alloc_table(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:64.1-70.58
  def {f : frame, i : nat, j? : nat?, reftype : reftype, s : store, s_new : store, s_res : store, ta : tableaddr, ta'* : tableaddr*, table : table, table'* : table*, tabletype : tabletype, ti : tableinst} alloc_table(`%;%`(s, f), [table] :: table'*{table'}) = (s_res, [ta] :: ta'*{ta'})
    -- if (table = TABLE(tabletype))
    -- if (tabletype = `%%`(`[%..%?]`(i, j?{j}), reftype))
    -- if (ti = {TYPE tabletype, ELEM REF.NULL_ref(reftype)^i{}})
    -- if (ta = |$tableinst(`%;%`(s, f))|)
    -- if (s_new = s[TABLE_store =.. [ti]])
    -- if ((s_res, ta'*{ta'}) = $alloc_table(`%;%`(s_new, f), table'*{table'}))
}

;; 7-module.watsup:73.1-73.48
rec {

;; 7-module.watsup:73.1-73.48
def alloc_mem : (state, mem*) -> (store, memaddr*)
  ;; 7-module.watsup:75.1-75.47
  def {f : frame, s : store} alloc_mem(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:77.1-83.54
  def {f : frame, i : nat, j? : nat?, ma : memaddr, ma'* : memaddr*, mem : mem, mem'* : mem*, memtype : memtype, mi : meminst, s : store, s_new : store, s_res : store} alloc_mem(`%;%`(s, f), [mem] :: mem'*{mem'}) = (s_res, [ma] :: ma'*{ma'})
    -- if (mem = MEMORY(memtype))
    -- if (memtype = `%I8`(`[%..%?]`(i, j?{j})))
    -- if (mi = {TYPE memtype, DATA 0^((i * 64) * $Ki){}})
    -- if (ma = |$meminst(`%;%`(s, f))|)
    -- if (s_new = s[MEM_store =.. [mi]])
    -- if ((s_res, ma'*{ma'}) = $alloc_mem(`%;%`(s_new, f), mem'*{mem'}))
}

;; 7-module.watsup:86.1-86.51
rec {

;; 7-module.watsup:86.1-86.51
def alloc_elem : (state, elem*) -> (store, elemaddr*)
  ;; 7-module.watsup:88.1-88.48
  def {f : frame, s : store} alloc_elem(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:90.1-96.56
  def {ea : elemaddr, ea'* : elemaddr*, ei : eleminst, elem : elem, elem'* : elem*, elemmode? : elemmode?, f : frame, instr** : instr**, ref* : ref*, reftype : reftype, s : store, s_new : store, s_res : store} alloc_elem(`%;%`(s, f), [elem] :: elem'*{elem'}) = (s_res, [ea] :: ea'*{ea'})
    -- if (elem = `ELEM%%*%?`(reftype, instr*{instr}*{instr}, elemmode?{elemmode}))
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f), (instr <: admininstr)*{instr}), [(ref <: admininstr)]))*{instr ref}
    -- if (ei = {TYPE reftype, ELEM ref*{ref}})
    -- if (ea = |$eleminst(`%;%`(s, f))|)
    -- if (s_new = s[ELEM_store =.. [ei]])
    -- if ((s_res, ea'*{ea'}) = $alloc_elem(`%;%`(s_new, f), elem'*{elem'}))
}

;; 7-module.watsup:99.1-99.51
rec {

;; 7-module.watsup:99.1-99.51
def alloc_data : (state, data*) -> (store, dataaddr*)
  ;; 7-module.watsup:101.1-101.48
  def {f : frame, s : store} alloc_data(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:103.1-108.56
  def {byte* : byte*, da : dataaddr, da'* : dataaddr*, data : data, data'* : data*, datamode? : datamode?, di : datainst, f : frame, s : store, s_new : store, s_res : store} alloc_data(`%;%`(s, f), [data] :: data'*{data'}) = (s_res, [da] :: da'*{da'})
    -- if (data = `DATA%*%?`(byte*{byte}, datamode?{datamode}))
    -- if (di = {DATA byte*{byte}})
    -- if (da = |$datainst(`%;%`(s, f))|)
    -- if (s_new = s[DATA_store =.. [di]])
    -- if ((s_res, da'*{da'}) = $alloc_data(`%;%`(s_new, f), data'*{data'}))
}

;; 7-module.watsup:111.1-111.62
rec {

;; 7-module.watsup:111.1-111.62
def replace_moduleinst : (store, funcaddr*, moduleinst) -> store
  ;; 7-module.watsup:113.1-113.43
  def {m : moduleinst, s : store} replace_moduleinst(s, [], m) = s
  ;; 7-module.watsup:115.1-117.52
  def {fa : funcaddr, fa'* : funcaddr*, m : moduleinst, s : store, s_new : store, s_res : store} replace_moduleinst(s, [fa] :: fa'*{fa'}, m) = s_res
    -- if (s_new = s[FUNC_store[fa].MODULE_funcinst = m])
    -- if (s_res = $replace_moduleinst(s_new, fa'*{fa'}, m))
}

;; 7-module.watsup:120.1-120.51
def alloc_export : (moduleinst, export) -> exportinst
  ;; 7-module.watsup:122.1-126.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = FUNC_externuse(x))
    -- if (externval = FUNC_externval(m.FUNC_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:128.1-132.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = GLOBAL_externuse(x))
    -- if (externval = GLOBAL_externval(m.GLOBAL_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:134.1-138.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = TABLE_externuse(x))
    -- if (externval = TABLE_externval(m.TABLE_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:140.1-144.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = MEM_externuse(x))
    -- if (externval = MEM_externval(m.MEM_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})

;; 7-module.watsup:147.1-147.67
def alloc_module : (store, module, externval*) -> (store, moduleinst)
  ;; 7-module.watsup:149.1-163.56
  def {da* : dataaddr*, data* : data*, ea* : elemaddr*, elem* : elem*, export* : export*, externval* : externval*, f : frame, fa* : funcaddr*, func* : func*, ga* : globaladdr*, global* : global*, import* : import*, m_ex : moduleinst, m_im : moduleinst, m_init : moduleinst, m_res : moduleinst, ma* : memaddr*, mem* : mem*, module : module, s : store, s_data : store, s_elem : store, s_func : store, s_global : store, s_mem : store, s_res : store, s_table : store, start? : start?, ta* : tableaddr*, table* : table*, xi* : exportinst*} alloc_module(s, module, externval*{externval}) = (s_res, m_res)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (m_init = {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (m_im = $alloc_import(m_init, import*{import}, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m_im})
    -- if ((s_func, fa*{fa}) = $alloc_func(`%;%`(s, f), func*{func}))
    -- if ((s_global, ga*{ga}) = $alloc_global(`%;%`(s_func, f), global*{global}))
    -- if ((s_table, ta*{ta}) = $alloc_table(`%;%`(s_global, f), table*{table}))
    -- if ((s_mem, ma*{ma}) = $alloc_mem(`%;%`(s_table, f), mem*{mem}))
    -- if ((s_elem, ea*{ea}) = $alloc_elem(`%;%`(s_mem, f), elem*{elem}))
    -- if ((s_data, da*{da}) = $alloc_data(`%;%`(s_elem, f), data*{data}))
    -- if (m_ex = m_im ++ {FUNC fa*{fa}, GLOBAL ga*{ga}, TABLE ta*{ta}, MEM ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT []})
    -- if (xi*{xi} = $alloc_export(m_ex, export)*{export})
    -- if (m_res = m_ex[EXPORT_moduleinst = xi*{xi}])
    -- if (s_res = $replace_moduleinst(s_data, fa*{fa}, m_res))

;; 7-module.watsup:166.1-166.41
rec {

;; 7-module.watsup:166.1-166.41
def run_elem : (state, elem*, idx) -> state
  ;; 7-module.watsup:168.1-168.41
  def {f : frame, i : nat, s : store} run_elem(`%;%`(s, f), [], i) = `%;%`(s, f)
  ;; 7-module.watsup:170.1-172.59
  def {elem : elem, elem'* : elem*, expr* : expr*, f : frame, f_res : frame, i : nat, reftype : reftype, s : store, s_res : store} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?()))
    -- if ($run_elem(`%;%`(s, f), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:174.1-179.67
  def {elem : elem, elem'* : elem*, elemmode : elemmode, expr* : expr*, f : frame, f_new : frame, f_res : frame, i : nat, instr* : instr*, n : n, reftype : reftype, s : store, s_new : store, s_res : store, x : idx} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?(elemmode)))
    -- if (n = |expr*{expr}|)
    -- if (elemmode = TABLE_elemmode(x, instr*{instr}))
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), (instr <: admininstr)*{instr} :: [CONST_admininstr(I32_numtype, 0) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, i) ELEM.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_elem(`%;%`(s_new, f_new), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:181.1-185.67
  def {elem : elem, elem'* : elem*, elemmode : elemmode, expr* : expr*, f : frame, f_new : frame, f_res : frame, i : nat, reftype : reftype, s : store, s_new : store, s_res : store} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?(elemmode)))
    -- if (elemmode = DECLARE_elemmode)
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), [ELEM.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_elem(`%;%`(s_new, f_new), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
}

;; 7-module.watsup:188.1-188.41
rec {

;; 7-module.watsup:188.1-188.41
def run_data : (state, data*, idx) -> state
  ;; 7-module.watsup:190.1-190.41
  def {f : frame, i : nat, s : store} run_data(`%;%`(s, f), [], i) = `%;%`(s, f)
  ;; 7-module.watsup:192.1-194.59
  def {byte* : byte*, data : data, data'* : data*, f : frame, f_res : frame, i : nat, s : store, s_res : store} run_data(`%;%`(s, f), [data] :: data'*{data'}, i) = `%;%`(s_res, f_res)
    -- if (data = `DATA%*%?`(byte*{byte}, ?()))
    -- if ($run_data(`%;%`(s, f), data'*{data'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:196.1-201.67
  def {byte* : byte*, data : data, data'* : data*, datamode : datamode, f : frame, f_new : frame, f_res : frame, i : nat, instr* : instr*, n : n, s : store, s_new : store, s_res : store} run_data(`%;%`(s, f), [data] :: data'*{data'}, i) = `%;%`(s_res, f_res)
    -- if (data = `DATA%*%?`(byte*{byte}, ?(datamode)))
    -- if (n = |byte*{byte}|)
    -- if (datamode = MEMORY_datamode(0, instr*{instr}))
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), (instr <: admininstr)*{instr} :: [CONST_admininstr(I32_numtype, 0) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(i) DATA.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_data(`%;%`(s_new, f_new), data'*{data'}, (i + 1)) = `%;%`(s_res, f_res))
}

;; 7-module.watsup:204.1-204.68
def instantiation : (store, module, externval*) -> (store, moduleinst)
  ;; 7-module.watsup:206.1-211.61
  def {data* : data*, elem* : elem*, export* : export*, externval* : externval*, f : frame, f_elem : frame, f_res : frame, func* : func*, global* : global*, import* : import*, m : moduleinst, mem* : mem*, module : module, s : store, s_alloc : store, s_elem : store, s_res : store, table* : table*} instantiation(s, module, externval*{externval}) = (s_res, m)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, ?(), export*{export}))
    -- if ((s_alloc, m) = $alloc_module(s, module, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m})
    -- if ($run_elem(`%;%`(s_alloc, f), elem*{elem}, 0) = `%;%`(s_elem, f_elem))
    -- if ($run_data(`%;%`(s_elem, f_elem), data*{data}, 0) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:213.1-220.62
  def {data* : data*, elem* : elem*, export* : export*, externval* : externval*, f : frame, f_data : frame, f_elem : frame, f_res : frame, func* : func*, global* : global*, import* : import*, m : moduleinst, mem* : mem*, module : module, s : store, s_alloc : store, s_data : store, s_elem : store, s_res : store, start : start, table* : table*, x : idx} instantiation(s, module, externval*{externval}) = (s_res, m)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, ?(start), export*{export}))
    -- if ((s_alloc, m) = $alloc_module(s, module, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m})
    -- if ($run_elem(`%;%`(s_alloc, f), elem*{elem}, 0) = `%;%`(s_elem, f_elem))
    -- if ($run_data(`%;%`(s_elem, f_elem), data*{data}, 0) = `%;%`(s_data, f_data))
    -- if (start = START(x))
    -- Step: `%~>%`(`%;%*`(`%;%`(s_data, f_data), [CALL_admininstr(x)]), `%;%*`(`%;%`(s_res, f_res), []))

;; 7-module.watsup:223.1-223.55
def invocation : (store, funcaddr, val*) -> (store, val*)
  ;; 7-module.watsup:225.1-232.55
  def {expr : expr, f : frame, f' : frame, fa : funcaddr, functype : functype, m : moduleinst, s : store, s' : store, val* : val*, val'* : val*, valtype* : valtype*, valtype'* : valtype*} invocation(s, fa, val*{val}) = (s', val'*{val'})
    -- if (m = {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE m})
    -- if ($funcinst(`%;%`(s, f))[fa].CODE_funcinst = `FUNC%%*%`(functype, valtype*{valtype}, expr))
    -- if (functype = `%->%`(valtype*{valtype}, valtype'*{valtype'}))
    -- if (|val*{val}| = |valtype*{valtype}|)
    -- if (|val'*{val'}| = |valtype'*{valtype'}|)
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), (val <: admininstr)*{val} :: [CALL_ADDR_admininstr(fa)]), `%;%*`(`%;%`(s', f'), (val' <: admininstr)*{val'}))

== IL Validation...
== Running pass sub

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:9.1-9.37
syntax name = text

;; 1-syntax.watsup:14.1-14.36
syntax byte = nat

;; 1-syntax.watsup:15.1-15.45
syntax u32 = nat

;; 1-syntax.watsup:22.1-22.36
syntax idx = nat

;; 1-syntax.watsup:23.1-23.49
syntax funcidx = idx

;; 1-syntax.watsup:24.1-24.49
syntax globalidx = idx

;; 1-syntax.watsup:25.1-25.47
syntax tableidx = idx

;; 1-syntax.watsup:26.1-26.46
syntax memidx = idx

;; 1-syntax.watsup:27.1-27.45
syntax elemidx = idx

;; 1-syntax.watsup:28.1-28.45
syntax dataidx = idx

;; 1-syntax.watsup:29.1-29.47
syntax labelidx = idx

;; 1-syntax.watsup:30.1-30.47
syntax localidx = idx

;; 1-syntax.watsup:39.1-40.22
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:41.1-42.5
syntax vectype =
  | V128

;; 1-syntax.watsup:43.1-44.20
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:45.1-46.34
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

;; 1-syntax.watsup:48.1-48.39
syntax in =
  | I32
  | I64

def numtype_in : in -> numtype
  def numtype_in(I32_in) = I32_numtype
  def numtype_in(I64_in) = I64_numtype

def valtype_in : in -> valtype
  def valtype_in(I32_in) = I32_valtype
  def valtype_in(I64_in) = I64_valtype

;; 1-syntax.watsup:49.1-49.39
syntax fn =
  | F32
  | F64

def numtype_fn : fn -> numtype
  def numtype_fn(F32_fn) = F32_numtype
  def numtype_fn(F64_fn) = F64_numtype

def valtype_fn : fn -> valtype
  def valtype_fn(F32_fn) = F32_valtype
  def valtype_fn(F64_fn) = F64_valtype

;; 1-syntax.watsup:56.1-57.11
syntax resulttype = valtype*

;; 1-syntax.watsup:59.1-60.17
syntax limits = `[%..%?]`(u32, u32?)

;; 1-syntax.watsup:61.1-62.15
syntax globaltype = `MUT%?%`(()?, valtype)

;; 1-syntax.watsup:63.1-64.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:65.1-66.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:67.1-68.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:69.1-70.10
syntax elemtype = reftype

;; 1-syntax.watsup:71.1-72.5
syntax datatype = OK

;; 1-syntax.watsup:73.1-74.66
syntax externtype =
  | GLOBAL(globaltype)
  | FUNC(functype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:86.1-86.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:88.1-88.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:89.1-89.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:91.1-93.62
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

;; 1-syntax.watsup:94.1-94.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:96.1-96.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:97.1-97.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:99.1-100.108
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:101.1-101.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:103.1-103.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:104.1-104.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:105.1-105.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:106.1-106.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:107.1-107.39
syntax cvtop =
  | CONVERT
  | REINTERPRET

;; 1-syntax.watsup:117.1-117.23
syntax c_numtype = nat

;; 1-syntax.watsup:118.1-118.23
syntax c_vectype = nat

;; 1-syntax.watsup:121.1-121.52
syntax blocktype = functype

;; 1-syntax.watsup:156.1-177.80
rec {

;; 1-syntax.watsup:156.1-177.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
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
  | LOAD(numtype, (n, sx)?, u32, u32)
  | STORE(numtype, n?, u32, u32)
}

;; 1-syntax.watsup:179.1-180.9
syntax expr = instr*

;; 1-syntax.watsup:187.1-187.50
syntax elemmode =
  | TABLE(tableidx, expr)
  | DECLARE

;; 1-syntax.watsup:188.1-188.39
syntax datamode =
  | MEMORY(memidx, expr)

;; 1-syntax.watsup:190.1-191.30
syntax func = `FUNC%%*%`(functype, valtype*, expr)

;; 1-syntax.watsup:192.1-193.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:194.1-195.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:196.1-197.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:198.1-199.31
syntax elem = `ELEM%%*%?`(reftype, expr*, elemmode?)

;; 1-syntax.watsup:200.1-201.23
syntax data = `DATA%*%?`(byte*, datamode?)

;; 1-syntax.watsup:202.1-203.16
syntax start = START(funcidx)

;; 1-syntax.watsup:205.1-206.62
syntax externuse =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:207.1-208.24
syntax export = EXPORT(name, externuse)

;; 1-syntax.watsup:209.1-210.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:212.1-213.70
syntax module = `MODULE%*%*%*%*%*%*%*%?%*`(import*, func*, global*, table*, mem*, elem*, data*, start?, export*)

;; 2-aux.watsup:3.1-3.14
def Ki : nat
  ;; 2-aux.watsup:4.1-4.15
  def Ki = 1024

;; 2-aux.watsup:9.1-9.25
rec {

;; 2-aux.watsup:9.1-9.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:10.1-10.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:11.1-11.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:12.1-12.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:19.1-19.55
def size : valtype -> nat
  ;; 2-aux.watsup:20.1-20.20
  def size(I32_valtype) = 32
  ;; 2-aux.watsup:21.1-21.20
  def size(I64_valtype) = 64
  ;; 2-aux.watsup:22.1-22.20
  def size(F32_valtype) = 32
  ;; 2-aux.watsup:23.1-23.20
  def size(F64_valtype) = 64
  ;; 2-aux.watsup:24.1-24.22
  def size(V128_valtype) = 128

;; 2-aux.watsup:29.1-29.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:30.1-30.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:32.1-32.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:33.1-33.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:35.1-44.39
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

;; 3-typing.watsup:3.1-6.60
syntax context = {FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:14.1-14.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:22.1-24.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%?]`(n_1, ?(n_2)), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:15.1-15.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:26.1-27.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:16.1-16.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:29.1-30.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:17.1-17.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:32.1-34.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:18.1-18.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:36.1-38.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:19.1-19.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:41.1-43.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:45.1-47.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:49.1-51.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:53.1-55.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:61.1-61.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:64.1-65.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:67.1-68.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:62.1-62.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:70.1-72.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:75.1-75.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:83.1-86.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%?]`(n_11, ?(n_12)), `[%..%?]`(n_21, ?(n_22)))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:76.1-76.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:88.1-89.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:77.1-77.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:91.1-92.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:78.1-78.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:94.1-96.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:79.1-79.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:98.1-100.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:80.1-80.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:103.1-105.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:107.1-109.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:111.1-113.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:115.1-117.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:172.1-172.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:174.1-176.29
  rule _ {C : context, ft : functype}:
    `%|-%:%`(C, ft, ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:123.1-124.67
rec {

;; 3-typing.watsup:123.1-123.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:153.1-154.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:156.1-157.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:159.1-160.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:163.1-164.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?(t)), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:166.1-169.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = $valtype_numtype(numtype)) \/ (t' = $valtype_vectype(vectype)))

  ;; 3-typing.watsup:178.1-181.57
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:183.1-186.57
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1]*{t_1}, RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:188.1-192.59
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:195.1-197.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:199.1-201.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:203.1-206.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:208.1-210.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 3-typing.watsup:212.1-214.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (C.FUNC_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:216.1-219.26
  rule call_indirect {C : context, ft : functype, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, ft), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (ft = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:222.1-223.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:225.1-226.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:228.1-229.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:231.1-232.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([$valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:234.1-235.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:238.1-240.23
  rule extend {C : context, n : n, nt : numtype}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))
    -- if (n <= $size($valtype_numtype(nt)))

  ;; 3-typing.watsup:242.1-245.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([$valtype_numtype(nt_2)], [$valtype_numtype(nt_1)]))
    -- if (nt_1 =/= nt_2)
    -- if ($size($valtype_numtype(nt_1)) = $size($valtype_numtype(nt_2)))

  ;; 3-typing.watsup:247.1-250.52
  rule convert-i {C : context, in_1 : in, in_2 : in, sx? : sx?}:
    `%|-%:%`(C, CVTOP_instr($numtype_in(in_1), CONVERT_cvtop, $numtype_in(in_2), sx?{sx}), `%->%`([$valtype_in(in_2)], [$valtype_in(in_1)]))
    -- if (in_1 =/= in_2)
    -- if ((sx?{sx} = ?()) <=> ($size($valtype_in(in_1)) > $size($valtype_in(in_2))))

  ;; 3-typing.watsup:252.1-254.22
  rule convert-f {C : context, fn_1 : fn, fn_2 : fn}:
    `%|-%:%`(C, CVTOP_instr($numtype_fn(fn_1), CONVERT_cvtop, $numtype_fn(fn_2), ?()), `%->%`([$valtype_fn(fn_2)], [$valtype_fn(fn_1)]))
    -- if (fn_1 =/= fn_2)

  ;; 3-typing.watsup:257.1-258.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [$valtype_reftype(rt)]))

  ;; 3-typing.watsup:260.1-262.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:264.1-265.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([$valtype_reftype(rt)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-270.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:272.1-274.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:276.1-278.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:281.1-283.29
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(()?{}, t))

  ;; 3-typing.watsup:285.1-287.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(()), t))

  ;; 3-typing.watsup:290.1-292.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [$valtype_reftype(rt)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:294.1-296.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype $valtype_reftype(rt)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:298.1-300.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:302.1-304.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([$valtype_reftype(rt) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:306.1-308.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype $valtype_reftype(rt) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:310.1-313.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:315.1-318.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:320.1-322.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:325.1-327.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:329.1-331.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:333.1-335.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:337.1-339.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:341.1-344.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:346.1-348.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:350.1-355.32
  rule load {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, n_A, n_O), `%->%`([I32_valtype], [$valtype_numtype(nt)]))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= ($size($valtype_numtype(nt)) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size($valtype_numtype(nt)) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_in(in)))

  ;; 3-typing.watsup:357.1-362.32
  rule store {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, n_A, n_O), `%->%`([I32_valtype $valtype_numtype(nt)], []))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= ($size($valtype_numtype(nt)) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size($valtype_numtype(nt)) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_in(in)))

;; 3-typing.watsup:124.1-124.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:133.1-134.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:136.1-139.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:141.1-146.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:148.1-150.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:125.1-125.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:128.1-130.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:367.1-367.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:371.1-372.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:374.1-375.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:377.1-378.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:380.1-382.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(), t))

;; 3-typing.watsup:368.1-368.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:385.1-386.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:369.1-369.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:389.1-392.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:397.1-397.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:408.1-412.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, `FUNC%%*%`(ft, t*{t}, expr), ft)
    -- if (ft = `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:398.1-398.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:414.1-418.40
  rule _ {C : context, expr : expr, gt : globaltype, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `MUT%?%`(()?{}, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:399.1-399.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:420.1-422.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:400.1-400.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:424.1-426.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:403.1-403.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:437.1-440.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:442.1-443.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:401.1-401.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:428.1-431.40
  rule _ {C : context, elemmode? : elemmode?, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%?`(rt, expr*{expr}, elemmode?{elemmode}), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [$valtype_reftype(rt)]))*{expr}
    -- (Elemmode_ok: `%|-%:%`(C, elemmode, rt))?{elemmode}

;; 3-typing.watsup:404.1-404.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:445.1-448.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, MEMORY_datamode(0, expr))
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

;; 3-typing.watsup:402.1-402.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:433.1-435.40
  rule _ {C : context, b* : byte*, datamode? : datamode?}:
    `%|-%:OK`(C, `DATA%*%?`(b*{b}, datamode?{datamode}))
    -- (Datamode_ok: `%|-%:OK`(C, datamode))?{datamode}

;; 3-typing.watsup:405.1-405.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:450.1-452.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:455.1-455.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:459.1-461.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:457.1-457.83
relation Externuse_ok: `%|-%:%`(context, externuse, externtype)
  ;; 3-typing.watsup:467.1-469.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externuse(x), FUNC_externtype(ft))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:471.1-473.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externuse(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:475.1-477.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externuse(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:479.1-481.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externuse(x), MEM_externtype(mt))
    -- if (C.MEM_context[x] = mt)

;; 3-typing.watsup:456.1-456.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:463.1-465.39
  rule _ {C : context, externuse : externuse, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externuse), xt)
    -- Externuse_ok: `%|-%:%`(C, externuse, xt)

;; 3-typing.watsup:484.1-484.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:486.1-500.16
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (C = {FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

;; 4-runtime.watsup:3.1-3.39
syntax addr = nat

;; 4-runtime.watsup:4.1-4.53
syntax funcaddr = addr

;; 4-runtime.watsup:5.1-5.53
syntax globaladdr = addr

;; 4-runtime.watsup:6.1-6.51
syntax tableaddr = addr

;; 4-runtime.watsup:7.1-7.50
syntax memaddr = addr

;; 4-runtime.watsup:8.1-8.49
syntax elemaddr = addr

;; 4-runtime.watsup:9.1-9.49
syntax dataaddr = addr

;; 4-runtime.watsup:10.1-10.51
syntax labeladdr = addr

;; 4-runtime.watsup:11.1-11.49
syntax hostaddr = addr

;; 4-runtime.watsup:24.1-25.24
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:26.1-27.67
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:28.1-29.10
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:31.1-32.18
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:38.1-39.66
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:44.1-44.44
def default_ : valtype -> val
  ;; 4-runtime.watsup:45.1-45.35
  def default_(I32_valtype) = CONST_val(I32_numtype, 0)
  ;; 4-runtime.watsup:46.1-46.35
  def default_(I64_valtype) = CONST_val(I64_numtype, 0)
  ;; 4-runtime.watsup:47.1-47.35
  def default_(F32_valtype) = CONST_val(F32_numtype, 0)
  ;; 4-runtime.watsup:48.1-48.35
  def default_(F64_valtype) = CONST_val(F64_numtype, 0)
  ;; 4-runtime.watsup:49.1-49.44
  def default_(FUNCREF_valtype) = REF.NULL_val(FUNCREF_reftype)
  ;; 4-runtime.watsup:50.1-50.48
  def default_(EXTERNREF_valtype) = REF.NULL_val(EXTERNREF_reftype)

;; 4-runtime.watsup:72.1-74.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:84.1-91.25
syntax moduleinst = {FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:55.1-57.16
syntax funcinst = {MODULE moduleinst, CODE func}

;; 4-runtime.watsup:58.1-60.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:61.1-63.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:64.1-66.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:67.1-69.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:70.1-71.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:76.1-82.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:93.1-95.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:96.1-96.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:180.1-187.5
rec {

;; 4-runtime.watsup:180.1-187.5
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
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
  | LOAD(numtype, (n, sx)?, u32, u32)
  | STORE(numtype, n?, u32, u32)
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
  def {x : valtype?} admininstr_instr(SELECT_instr(x)) = SELECT_admininstr(x)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(BLOCK_instr(x0, x1)) = BLOCK_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(LOOP_instr(x0, x1)) = LOOP_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*, x2 : instr*} admininstr_instr(IF_instr(x0, x1, x2)) = IF_admininstr(x0, x1, x2)
  def {x : labelidx} admininstr_instr(BR_instr(x)) = BR_admininstr(x)
  def {x : labelidx} admininstr_instr(BR_IF_instr(x)) = BR_IF_admininstr(x)
  def {x0 : labelidx*, x1 : labelidx} admininstr_instr(BR_TABLE_instr(x0, x1)) = BR_TABLE_admininstr(x0, x1)
  def {x : funcidx} admininstr_instr(CALL_instr(x)) = CALL_admininstr(x)
  def {x0 : tableidx, x1 : functype} admininstr_instr(CALL_INDIRECT_instr(x0, x1)) = CALL_INDIRECT_admininstr(x0, x1)
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
  def {x0 : numtype, x1 : (n, sx)?, x2 : u32, x3 : u32} admininstr_instr(LOAD_instr(x0, x1, x2, x3)) = LOAD_admininstr(x0, x1, x2, x3)
  def {x0 : numtype, x1 : n?, x2 : u32, x3 : u32} admininstr_instr(STORE_instr(x0, x1, x2, x3)) = STORE_admininstr(x0, x1, x2, x3)

def admininstr_ref : ref -> admininstr
  def {x : reftype} admininstr_ref(REF.NULL_ref(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_ref(REF.FUNC_ADDR_ref(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_ref(REF.HOST_ADDR_ref(x)) = REF.HOST_ADDR_admininstr(x)

def admininstr_val : val -> admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_val(CONST_val(x0, x1)) = CONST_admininstr(x0, x1)
  def {x : reftype} admininstr_val(REF.NULL_val(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_val(REF.FUNC_ADDR_val(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_val(REF.HOST_ADDR_val(x)) = REF.HOST_ADDR_admininstr(x)

;; 4-runtime.watsup:97.1-97.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:115.1-115.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:116.1-116.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:118.1-118.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:125.1-125.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:119.1-119.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:126.1-126.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:120.1-120.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:127.1-127.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:121.1-121.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:128.1-128.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:122.1-122.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:129.1-129.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:123.1-123.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:130.1-130.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:132.1-132.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:140.1-140.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:133.1-133.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:141.1-141.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:134.1-134.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:142.1-142.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:135.1-135.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:143.1-143.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:136.1-136.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:144.1-144.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:137.1-137.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:145.1-145.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:138.1-138.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:146.1-146.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:149.1-149.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:158.1-158.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:150.1-150.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:159.1-159.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:151.1-151.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:160.1-160.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:152.1-152.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:161.1-161.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:153.1-153.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:162.1-162.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:154.1-154.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:163.1-163.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:155.1-155.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:164.1-164.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:156.1-156.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:165.1-165.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:167.1-167.49
def grow_table : (tableinst, nat, ref) -> tableinst
  ;; 4-runtime.watsup:169.1-172.57
  def {i : nat, i' : nat, j? : nat?, n : n, r : ref, r'* : ref*, reftype : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ti'
    -- if (ti = {TYPE `%%`(`[%..%?]`(i, j?{j}), reftype), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%?]`(i', j?{j}), reftype), ELEM r'*{r'} :: r^n{}})

;; 4-runtime.watsup:168.1-168.41
def grow_memory : (meminst, nat) -> meminst
  ;; 4-runtime.watsup:173.1-176.66
  def {b* : byte*, i : nat, i' : nat, j? : nat?, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = mi'
    -- if (mi = {TYPE `%I8`(`[%..%?]`(i, j?{j})), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%?]`(i', j?{j})), DATA b*{b} :: 0^((n * 64) * $Ki){}})

;; 4-runtime.watsup:189.1-192.21
rec {

;; 4-runtime.watsup:189.1-192.21
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

;; 5-numerics.watsup:13.1-13.28
def bytes_ : (nat, c_numtype) -> byte*

;; 5-numerics.watsup:14.1-14.47
def inverse_of_bytes_ : (nat, byte*) -> c_numtype

;; 6-reduction.watsup:4.1-4.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:16.1-17.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:19.1-20.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:22.1-23.24
  rule drop {val : val}:
    `%*~>%*`([$admininstr_val(val) DROP_admininstr], [])

  ;; 6-reduction.watsup:26.1-28.16
  rule select-true {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [$admininstr_val(val_1)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:30.1-32.14
  rule select-false {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [$admininstr_val(val_2)])
    -- if (c = 0)

  ;; 6-reduction.watsup:35.1-37.28
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`($admininstr_val(val)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})], [LABEL__admininstr(n, [], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if (bt = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:39.1-41.28
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`($admininstr_val(val)^k{val} :: [LOOP_admininstr(bt, instr*{instr})], [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if (bt = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:43.1-45.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:47.1-49.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:52.1-53.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, $admininstr_val(val)*{val})], $admininstr_val(val)*{val})

  ;; 6-reduction.watsup:57.1-58.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [BR_admininstr(0)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val} :: $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:60.1-61.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val)*{val} :: [BR_admininstr(l + 1)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:64.1-66.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:68.1-70.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:73.1-75.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:77.1-79.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:102.1-103.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val)^n{val})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:105.1-106.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:108.1-109.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, $admininstr_val(val)*{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:112.1-114.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 6-reduction.watsup:116.1-118.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:121.1-123.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 6-reduction.watsup:125.1-127.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:130.1-132.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 6-reduction.watsup:134.1-136.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 6-reduction.watsup:139.1-140.70
  rule extend {c : c_numtype, n : n, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, $size($valtype_numtype(nt)), S_sx, c))])

  ;; 6-reduction.watsup:143.1-145.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [c])

  ;; 6-reduction.watsup:147.1-149.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:156.1-158.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(rt))

  ;; 6-reduction.watsup:160.1-162.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:171.1-172.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([$admininstr_val(val) LOCAL.TEE_admininstr(x)], [$admininstr_val(val) $admininstr_val(val) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:5.1-5.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:82.1-83.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:85.1-89.17
  rule call_indirect-call {a : addr, ft : functype, ft' : functype, i : nat, instr* : instr*, t* : valtype*, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [CALL_ADDR_admininstr(a)])
    -- if ($table(z, x).ELEM_tableinst[i] = REF.FUNC_ADDR_ref(a))
    -- if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(ft', t*{t}, instr*{instr}))
    -- if (ft = ft')

  ;; 6-reduction.watsup:91.1-93.15
  rule call_indirect-trap {ft : functype, i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:95.1-99.52
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, m : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], $admininstr_instr(instr)*{instr})])])
    -- if ($funcinst(z)[a] = {MODULE m, CODE func})
    -- if (func = `FUNC%%*%`(`%->%`(t_1^k{t_1}, t_2^n{t_2}), t*{t}, instr*{instr}))
    -- if (f = {LOCAL val^k{val} :: $default_(t)*{t}, MODULE m})

  ;; 6-reduction.watsup:152.1-153.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:165.1-166.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [$admininstr_val($local(z, x))])

  ;; 6-reduction.watsup:175.1-176.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [$admininstr_val($global(z, x).VALUE_globalinst)])

  ;; 6-reduction.watsup:182.1-184.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:186.1-188.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [$admininstr_ref($table(z, x).ELEM_tableinst[i])])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:199.1-201.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 6-reduction.watsup:214.1-216.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:218.1-221.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:223.1-227.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:230.1-232.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:234.1-237.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:239.1-244.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:246.1-250.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:253.1-255.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:257.1-260.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:262.1-266.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) $admininstr_ref($elem(z, y).ELEM_eleminst[i]) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:273.1-275.53
  rule load-num-trap {i : nat, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), n_A, n_O)]), [TRAP_admininstr])
    -- if (((i + n_O) + ($size($valtype_numtype(nt)) / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:277.1-279.71
  rule load-num-val {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), n_A, n_O)]), [CONST_admininstr(nt, c)])
    -- if ($bytes_($size($valtype_numtype(nt)), c) = $mem(z, 0).DATA_meminst[(i + n_O) : ($size($valtype_numtype(nt)) / 8)])

  ;; 6-reduction.watsup:281.1-283.45
  rule load-pack-trap {i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), n_A, n_O)]), [TRAP_admininstr])
    -- if (((i + n_O) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:285.1-287.55
  rule load-pack-val {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), n_A, n_O)]), [CONST_admininstr(nt, $ext(n, $size($valtype_numtype(nt)), sx, c))])
    -- if ($bytes_(n, c) = $mem(z, 0).DATA_meminst[(i + n_O) : (n / 8)])

  ;; 6-reduction.watsup:307.1-309.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:322.1-324.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:326.1-329.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:331.1-335.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:338.1-340.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:342.1-345.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:347.1-352.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), 0, 0) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:354.1-358.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), 0, 0) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:361.1-363.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:365.1-368.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:370.1-374.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- otherwise

;; 6-reduction.watsup:3.1-3.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:7.1-9.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_pure: `%*~>%*`($admininstr_instr(instr)*{instr}, $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:11.1-13.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, $admininstr_instr(instr)*{instr}), $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:168.1-169.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:178.1-179.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:190.1-192.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:194.1-196.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:204.1-208.36
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, ti' : tableinst, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti'), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if ($table(z, x) = ti)
    -- if ($grow_table(ti, n, ref) = ti')
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)

  ;; 6-reduction.watsup:210.1-211.64
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 6-reduction.watsup:269.1-270.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:290.1-292.53
  rule store-num-trap {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + n_O) + ($size($valtype_numtype(nt)) / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:294.1-296.35
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), n_A, n_O)]), `%;%*`($with_mem(z, 0, (i + n_O), ($size($valtype_numtype(nt)) / 8), b*{b}), []))
    -- if (b*{b} = $bytes_($size($valtype_numtype(nt)), c))

  ;; 6-reduction.watsup:298.1-300.45
  rule store-pack-trap {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + n_O) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:302.1-304.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), n_A, n_O)]), `%;%*`($with_mem(z, 0, (i + n_O), (n / 8), b*{b}), []))
    -- if (b*{b} = $bytes_(n, $wrap_(($size($valtype_numtype(nt)), n), c)))

  ;; 6-reduction.watsup:312.1-316.34
  rule memory.grow-succeed {mi : meminst, mi' : meminst, n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi'), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- if ($mem(z, 0) = mi)
    -- if ($grow_memory(mi, n) = mi')
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)

  ;; 6-reduction.watsup:318.1-319.59
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 6-reduction.watsup:377.1-378.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:3.1-3.64
rec {

;; 7-module.watsup:3.1-3.64
def alloc_import : (moduleinst, import*, externval*) -> moduleinst
  ;; 7-module.watsup:5.1-5.43
  def {m : moduleinst} alloc_import(m, [], []) = m
  ;; 7-module.watsup:7.1-12.60
  def {externtype : externtype, externval : externval, externval'* : externval*, fa : funcaddr, functype : functype, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = FUNC_externtype(functype))
    -- if (externval = FUNC_externval(fa))
    -- if (m_new = m[FUNC_moduleinst =.. [fa]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:14.1-19.60
  def {externtype : externtype, externval : externval, externval'* : externval*, ga : globaladdr, globaltype : globaltype, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = GLOBAL_externtype(globaltype))
    -- if (externval = GLOBAL_externval(ga))
    -- if (m_new = m[GLOBAL_moduleinst =.. [ga]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:21.1-26.60
  def {externtype : externtype, externval : externval, externval'* : externval*, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name, ta : tableaddr, tabletype : tabletype} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = TABLE_externtype(tabletype))
    -- if (externval = TABLE_externval(ta))
    -- if (m_new = m[TABLE_moduleinst =.. [ta]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:28.1-33.60
  def {externtype : externtype, externval : externval, externval'* : externval*, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, ma : memaddr, memtype : memtype, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = MEM_externtype(memtype))
    -- if (externval = MEM_externval(ma))
    -- if (m_new = m[MEM_moduleinst =.. [ma]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
}

;; 7-module.watsup:36.1-36.51
rec {

;; 7-module.watsup:36.1-36.51
def alloc_func : (state, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:38.1-38.48
  def {f : frame, s : store} alloc_func(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:40.1-44.56
  def {f : frame, fa : funcaddr, fa'* : funcaddr*, fi : funcinst, func : func, func'* : func*, s : store, s_new : store, s_res : store} alloc_func(`%;%`(s, f), [func] :: func'*{func'}) = (s_res, [fa] :: fa'*{fa'})
    -- if (fi = {MODULE f.MODULE_frame, CODE func})
    -- if (fa = |$funcinst(`%;%`(s, f))|)
    -- if (s_new = s[FUNC_store =.. [fi]])
    -- if ((s_res, fa'*{fa'}) = $alloc_func(`%;%`(s_new, f), func'*{func'}))
}

;; 7-module.watsup:47.1-47.57
rec {

;; 7-module.watsup:47.1-47.57
def alloc_global : (state, global*) -> (store, globaladdr*)
  ;; 7-module.watsup:49.1-49.50
  def {f : frame, s : store} alloc_global(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:51.1-57.60
  def {f : frame, ga : globaladdr, ga'* : globaladdr*, gi : globalinst, global : global, global'* : global*, globaltype : globaltype, instr* : instr*, s : store, s_new : store, s_res : store, val : val} alloc_global(`%;%`(s, f), [global] :: global'*{global'}) = (s_res, [ga] :: ga'*{ga'})
    -- if (global = GLOBAL(globaltype, instr*{instr}))
    -- Step_read: `%~>%*`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr}), [$admininstr_val(val)])
    -- if (gi = {TYPE globaltype, VALUE val})
    -- if (ga = |$globalinst(`%;%`(s, f))|)
    -- if (s_new = s[GLOBAL_store =.. [gi]])
    -- if ((s_res, ga'*{ga'}) = $alloc_global(`%;%`(s_new, f), global'*{global'}))
}

;; 7-module.watsup:60.1-60.54
rec {

;; 7-module.watsup:60.1-60.54
def alloc_table : (state, table*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.49
  def {f : frame, s : store} alloc_table(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:64.1-70.58
  def {f : frame, i : nat, j? : nat?, reftype : reftype, s : store, s_new : store, s_res : store, ta : tableaddr, ta'* : tableaddr*, table : table, table'* : table*, tabletype : tabletype, ti : tableinst} alloc_table(`%;%`(s, f), [table] :: table'*{table'}) = (s_res, [ta] :: ta'*{ta'})
    -- if (table = TABLE(tabletype))
    -- if (tabletype = `%%`(`[%..%?]`(i, j?{j}), reftype))
    -- if (ti = {TYPE tabletype, ELEM REF.NULL_ref(reftype)^i{}})
    -- if (ta = |$tableinst(`%;%`(s, f))|)
    -- if (s_new = s[TABLE_store =.. [ti]])
    -- if ((s_res, ta'*{ta'}) = $alloc_table(`%;%`(s_new, f), table'*{table'}))
}

;; 7-module.watsup:73.1-73.48
rec {

;; 7-module.watsup:73.1-73.48
def alloc_mem : (state, mem*) -> (store, memaddr*)
  ;; 7-module.watsup:75.1-75.47
  def {f : frame, s : store} alloc_mem(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:77.1-83.54
  def {f : frame, i : nat, j? : nat?, ma : memaddr, ma'* : memaddr*, mem : mem, mem'* : mem*, memtype : memtype, mi : meminst, s : store, s_new : store, s_res : store} alloc_mem(`%;%`(s, f), [mem] :: mem'*{mem'}) = (s_res, [ma] :: ma'*{ma'})
    -- if (mem = MEMORY(memtype))
    -- if (memtype = `%I8`(`[%..%?]`(i, j?{j})))
    -- if (mi = {TYPE memtype, DATA 0^((i * 64) * $Ki){}})
    -- if (ma = |$meminst(`%;%`(s, f))|)
    -- if (s_new = s[MEM_store =.. [mi]])
    -- if ((s_res, ma'*{ma'}) = $alloc_mem(`%;%`(s_new, f), mem'*{mem'}))
}

;; 7-module.watsup:86.1-86.51
rec {

;; 7-module.watsup:86.1-86.51
def alloc_elem : (state, elem*) -> (store, elemaddr*)
  ;; 7-module.watsup:88.1-88.48
  def {f : frame, s : store} alloc_elem(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:90.1-96.56
  def {ea : elemaddr, ea'* : elemaddr*, ei : eleminst, elem : elem, elem'* : elem*, elemmode? : elemmode?, f : frame, instr** : instr**, ref* : ref*, reftype : reftype, s : store, s_new : store, s_res : store} alloc_elem(`%;%`(s, f), [elem] :: elem'*{elem'}) = (s_res, [ea] :: ea'*{ea'})
    -- if (elem = `ELEM%%*%?`(reftype, instr*{instr}*{instr}, elemmode?{elemmode}))
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr}), [$admininstr_ref(ref)]))*{instr ref}
    -- if (ei = {TYPE reftype, ELEM ref*{ref}})
    -- if (ea = |$eleminst(`%;%`(s, f))|)
    -- if (s_new = s[ELEM_store =.. [ei]])
    -- if ((s_res, ea'*{ea'}) = $alloc_elem(`%;%`(s_new, f), elem'*{elem'}))
}

;; 7-module.watsup:99.1-99.51
rec {

;; 7-module.watsup:99.1-99.51
def alloc_data : (state, data*) -> (store, dataaddr*)
  ;; 7-module.watsup:101.1-101.48
  def {f : frame, s : store} alloc_data(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:103.1-108.56
  def {byte* : byte*, da : dataaddr, da'* : dataaddr*, data : data, data'* : data*, datamode? : datamode?, di : datainst, f : frame, s : store, s_new : store, s_res : store} alloc_data(`%;%`(s, f), [data] :: data'*{data'}) = (s_res, [da] :: da'*{da'})
    -- if (data = `DATA%*%?`(byte*{byte}, datamode?{datamode}))
    -- if (di = {DATA byte*{byte}})
    -- if (da = |$datainst(`%;%`(s, f))|)
    -- if (s_new = s[DATA_store =.. [di]])
    -- if ((s_res, da'*{da'}) = $alloc_data(`%;%`(s_new, f), data'*{data'}))
}

;; 7-module.watsup:111.1-111.62
rec {

;; 7-module.watsup:111.1-111.62
def replace_moduleinst : (store, funcaddr*, moduleinst) -> store
  ;; 7-module.watsup:113.1-113.43
  def {m : moduleinst, s : store} replace_moduleinst(s, [], m) = s
  ;; 7-module.watsup:115.1-117.52
  def {fa : funcaddr, fa'* : funcaddr*, m : moduleinst, s : store, s_new : store, s_res : store} replace_moduleinst(s, [fa] :: fa'*{fa'}, m) = s_res
    -- if (s_new = s[FUNC_store[fa].MODULE_funcinst = m])
    -- if (s_res = $replace_moduleinst(s_new, fa'*{fa'}, m))
}

;; 7-module.watsup:120.1-120.51
def alloc_export : (moduleinst, export) -> exportinst
  ;; 7-module.watsup:122.1-126.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = FUNC_externuse(x))
    -- if (externval = FUNC_externval(m.FUNC_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:128.1-132.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = GLOBAL_externuse(x))
    -- if (externval = GLOBAL_externval(m.GLOBAL_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:134.1-138.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = TABLE_externuse(x))
    -- if (externval = TABLE_externval(m.TABLE_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:140.1-144.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = MEM_externuse(x))
    -- if (externval = MEM_externval(m.MEM_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})

;; 7-module.watsup:147.1-147.67
def alloc_module : (store, module, externval*) -> (store, moduleinst)
  ;; 7-module.watsup:149.1-163.56
  def {da* : dataaddr*, data* : data*, ea* : elemaddr*, elem* : elem*, export* : export*, externval* : externval*, f : frame, fa* : funcaddr*, func* : func*, ga* : globaladdr*, global* : global*, import* : import*, m_ex : moduleinst, m_im : moduleinst, m_init : moduleinst, m_res : moduleinst, ma* : memaddr*, mem* : mem*, module : module, s : store, s_data : store, s_elem : store, s_func : store, s_global : store, s_mem : store, s_res : store, s_table : store, start? : start?, ta* : tableaddr*, table* : table*, xi* : exportinst*} alloc_module(s, module, externval*{externval}) = (s_res, m_res)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (m_init = {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (m_im = $alloc_import(m_init, import*{import}, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m_im})
    -- if ((s_func, fa*{fa}) = $alloc_func(`%;%`(s, f), func*{func}))
    -- if ((s_global, ga*{ga}) = $alloc_global(`%;%`(s_func, f), global*{global}))
    -- if ((s_table, ta*{ta}) = $alloc_table(`%;%`(s_global, f), table*{table}))
    -- if ((s_mem, ma*{ma}) = $alloc_mem(`%;%`(s_table, f), mem*{mem}))
    -- if ((s_elem, ea*{ea}) = $alloc_elem(`%;%`(s_mem, f), elem*{elem}))
    -- if ((s_data, da*{da}) = $alloc_data(`%;%`(s_elem, f), data*{data}))
    -- if (m_ex = m_im ++ {FUNC fa*{fa}, GLOBAL ga*{ga}, TABLE ta*{ta}, MEM ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT []})
    -- if (xi*{xi} = $alloc_export(m_ex, export)*{export})
    -- if (m_res = m_ex[EXPORT_moduleinst = xi*{xi}])
    -- if (s_res = $replace_moduleinst(s_data, fa*{fa}, m_res))

;; 7-module.watsup:166.1-166.41
rec {

;; 7-module.watsup:166.1-166.41
def run_elem : (state, elem*, idx) -> state
  ;; 7-module.watsup:168.1-168.41
  def {f : frame, i : nat, s : store} run_elem(`%;%`(s, f), [], i) = `%;%`(s, f)
  ;; 7-module.watsup:170.1-172.59
  def {elem : elem, elem'* : elem*, expr* : expr*, f : frame, f_res : frame, i : nat, reftype : reftype, s : store, s_res : store} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?()))
    -- if ($run_elem(`%;%`(s, f), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:174.1-179.67
  def {elem : elem, elem'* : elem*, elemmode : elemmode, expr* : expr*, f : frame, f_new : frame, f_res : frame, i : nat, instr* : instr*, n : n, reftype : reftype, s : store, s_new : store, s_res : store, x : idx} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?(elemmode)))
    -- if (n = |expr*{expr}|)
    -- if (elemmode = TABLE_elemmode(x, instr*{instr}))
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr} :: [CONST_admininstr(I32_numtype, 0) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, i) ELEM.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_elem(`%;%`(s_new, f_new), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:181.1-185.67
  def {elem : elem, elem'* : elem*, elemmode : elemmode, expr* : expr*, f : frame, f_new : frame, f_res : frame, i : nat, reftype : reftype, s : store, s_new : store, s_res : store} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?(elemmode)))
    -- if (elemmode = DECLARE_elemmode)
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), [ELEM.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_elem(`%;%`(s_new, f_new), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
}

;; 7-module.watsup:188.1-188.41
rec {

;; 7-module.watsup:188.1-188.41
def run_data : (state, data*, idx) -> state
  ;; 7-module.watsup:190.1-190.41
  def {f : frame, i : nat, s : store} run_data(`%;%`(s, f), [], i) = `%;%`(s, f)
  ;; 7-module.watsup:192.1-194.59
  def {byte* : byte*, data : data, data'* : data*, f : frame, f_res : frame, i : nat, s : store, s_res : store} run_data(`%;%`(s, f), [data] :: data'*{data'}, i) = `%;%`(s_res, f_res)
    -- if (data = `DATA%*%?`(byte*{byte}, ?()))
    -- if ($run_data(`%;%`(s, f), data'*{data'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:196.1-201.67
  def {byte* : byte*, data : data, data'* : data*, datamode : datamode, f : frame, f_new : frame, f_res : frame, i : nat, instr* : instr*, n : n, s : store, s_new : store, s_res : store} run_data(`%;%`(s, f), [data] :: data'*{data'}, i) = `%;%`(s_res, f_res)
    -- if (data = `DATA%*%?`(byte*{byte}, ?(datamode)))
    -- if (n = |byte*{byte}|)
    -- if (datamode = MEMORY_datamode(0, instr*{instr}))
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr} :: [CONST_admininstr(I32_numtype, 0) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(i) DATA.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_data(`%;%`(s_new, f_new), data'*{data'}, (i + 1)) = `%;%`(s_res, f_res))
}

;; 7-module.watsup:204.1-204.68
def instantiation : (store, module, externval*) -> (store, moduleinst)
  ;; 7-module.watsup:206.1-211.61
  def {data* : data*, elem* : elem*, export* : export*, externval* : externval*, f : frame, f_elem : frame, f_res : frame, func* : func*, global* : global*, import* : import*, m : moduleinst, mem* : mem*, module : module, s : store, s_alloc : store, s_elem : store, s_res : store, table* : table*} instantiation(s, module, externval*{externval}) = (s_res, m)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, ?(), export*{export}))
    -- if ((s_alloc, m) = $alloc_module(s, module, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m})
    -- if ($run_elem(`%;%`(s_alloc, f), elem*{elem}, 0) = `%;%`(s_elem, f_elem))
    -- if ($run_data(`%;%`(s_elem, f_elem), data*{data}, 0) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:213.1-220.62
  def {data* : data*, elem* : elem*, export* : export*, externval* : externval*, f : frame, f_data : frame, f_elem : frame, f_res : frame, func* : func*, global* : global*, import* : import*, m : moduleinst, mem* : mem*, module : module, s : store, s_alloc : store, s_data : store, s_elem : store, s_res : store, start : start, table* : table*, x : idx} instantiation(s, module, externval*{externval}) = (s_res, m)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, ?(start), export*{export}))
    -- if ((s_alloc, m) = $alloc_module(s, module, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m})
    -- if ($run_elem(`%;%`(s_alloc, f), elem*{elem}, 0) = `%;%`(s_elem, f_elem))
    -- if ($run_data(`%;%`(s_elem, f_elem), data*{data}, 0) = `%;%`(s_data, f_data))
    -- if (start = START(x))
    -- Step: `%~>%`(`%;%*`(`%;%`(s_data, f_data), [CALL_admininstr(x)]), `%;%*`(`%;%`(s_res, f_res), []))

;; 7-module.watsup:223.1-223.55
def invocation : (store, funcaddr, val*) -> (store, val*)
  ;; 7-module.watsup:225.1-232.55
  def {expr : expr, f : frame, f' : frame, fa : funcaddr, functype : functype, m : moduleinst, s : store, s' : store, val* : val*, val'* : val*, valtype* : valtype*, valtype'* : valtype*} invocation(s, fa, val*{val}) = (s', val'*{val'})
    -- if (m = {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE m})
    -- if ($funcinst(`%;%`(s, f))[fa].CODE_funcinst = `FUNC%%*%`(functype, valtype*{valtype}, expr))
    -- if (functype = `%->%`(valtype*{valtype}, valtype'*{valtype'}))
    -- if (|val*{val}| = |valtype*{valtype}|)
    -- if (|val'*{val'}| = |valtype'*{valtype'}|)
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_val(val)*{val} :: [CALL_ADDR_admininstr(fa)]), `%;%*`(`%;%`(s', f'), $admininstr_val(val')*{val'}))

== IL Validation...
== Running pass totalize

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:9.1-9.37
syntax name = text

;; 1-syntax.watsup:14.1-14.36
syntax byte = nat

;; 1-syntax.watsup:15.1-15.45
syntax u32 = nat

;; 1-syntax.watsup:22.1-22.36
syntax idx = nat

;; 1-syntax.watsup:23.1-23.49
syntax funcidx = idx

;; 1-syntax.watsup:24.1-24.49
syntax globalidx = idx

;; 1-syntax.watsup:25.1-25.47
syntax tableidx = idx

;; 1-syntax.watsup:26.1-26.46
syntax memidx = idx

;; 1-syntax.watsup:27.1-27.45
syntax elemidx = idx

;; 1-syntax.watsup:28.1-28.45
syntax dataidx = idx

;; 1-syntax.watsup:29.1-29.47
syntax labelidx = idx

;; 1-syntax.watsup:30.1-30.47
syntax localidx = idx

;; 1-syntax.watsup:39.1-40.22
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:41.1-42.5
syntax vectype =
  | V128

;; 1-syntax.watsup:43.1-44.20
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:45.1-46.34
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

;; 1-syntax.watsup:48.1-48.39
syntax in =
  | I32
  | I64

def numtype_in : in -> numtype
  def numtype_in(I32_in) = I32_numtype
  def numtype_in(I64_in) = I64_numtype

def valtype_in : in -> valtype
  def valtype_in(I32_in) = I32_valtype
  def valtype_in(I64_in) = I64_valtype

;; 1-syntax.watsup:49.1-49.39
syntax fn =
  | F32
  | F64

def numtype_fn : fn -> numtype
  def numtype_fn(F32_fn) = F32_numtype
  def numtype_fn(F64_fn) = F64_numtype

def valtype_fn : fn -> valtype
  def valtype_fn(F32_fn) = F32_valtype
  def valtype_fn(F64_fn) = F64_valtype

;; 1-syntax.watsup:56.1-57.11
syntax resulttype = valtype*

;; 1-syntax.watsup:59.1-60.17
syntax limits = `[%..%?]`(u32, u32?)

;; 1-syntax.watsup:61.1-62.15
syntax globaltype = `MUT%?%`(()?, valtype)

;; 1-syntax.watsup:63.1-64.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:65.1-66.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:67.1-68.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:69.1-70.10
syntax elemtype = reftype

;; 1-syntax.watsup:71.1-72.5
syntax datatype = OK

;; 1-syntax.watsup:73.1-74.66
syntax externtype =
  | GLOBAL(globaltype)
  | FUNC(functype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:86.1-86.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:88.1-88.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:89.1-89.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:91.1-93.62
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

;; 1-syntax.watsup:94.1-94.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:96.1-96.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:97.1-97.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:99.1-100.108
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:101.1-101.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:103.1-103.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:104.1-104.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:105.1-105.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:106.1-106.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:107.1-107.39
syntax cvtop =
  | CONVERT
  | REINTERPRET

;; 1-syntax.watsup:117.1-117.23
syntax c_numtype = nat

;; 1-syntax.watsup:118.1-118.23
syntax c_vectype = nat

;; 1-syntax.watsup:121.1-121.52
syntax blocktype = functype

;; 1-syntax.watsup:156.1-177.80
rec {

;; 1-syntax.watsup:156.1-177.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
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
  | LOAD(numtype, (n, sx)?, u32, u32)
  | STORE(numtype, n?, u32, u32)
}

;; 1-syntax.watsup:179.1-180.9
syntax expr = instr*

;; 1-syntax.watsup:187.1-187.50
syntax elemmode =
  | TABLE(tableidx, expr)
  | DECLARE

;; 1-syntax.watsup:188.1-188.39
syntax datamode =
  | MEMORY(memidx, expr)

;; 1-syntax.watsup:190.1-191.30
syntax func = `FUNC%%*%`(functype, valtype*, expr)

;; 1-syntax.watsup:192.1-193.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:194.1-195.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:196.1-197.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:198.1-199.31
syntax elem = `ELEM%%*%?`(reftype, expr*, elemmode?)

;; 1-syntax.watsup:200.1-201.23
syntax data = `DATA%*%?`(byte*, datamode?)

;; 1-syntax.watsup:202.1-203.16
syntax start = START(funcidx)

;; 1-syntax.watsup:205.1-206.62
syntax externuse =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:207.1-208.24
syntax export = EXPORT(name, externuse)

;; 1-syntax.watsup:209.1-210.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:212.1-213.70
syntax module = `MODULE%*%*%*%*%*%*%*%?%*`(import*, func*, global*, table*, mem*, elem*, data*, start?, export*)

;; 2-aux.watsup:3.1-3.14
def Ki : nat
  ;; 2-aux.watsup:4.1-4.15
  def Ki = 1024

;; 2-aux.watsup:9.1-9.25
rec {

;; 2-aux.watsup:9.1-9.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:10.1-10.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:11.1-11.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:12.1-12.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:19.1-19.55
def size : valtype -> nat?
  ;; 2-aux.watsup:20.1-20.20
  def size(I32_valtype) = ?(32)
  ;; 2-aux.watsup:21.1-21.20
  def size(I64_valtype) = ?(64)
  ;; 2-aux.watsup:22.1-22.20
  def size(F32_valtype) = ?(32)
  ;; 2-aux.watsup:23.1-23.20
  def size(F64_valtype) = ?(64)
  ;; 2-aux.watsup:24.1-24.22
  def size(V128_valtype) = ?(128)
  def {x : valtype} size(x) = ?()

;; 2-aux.watsup:29.1-29.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:30.1-30.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:32.1-32.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:33.1-33.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:35.1-44.39
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

;; 3-typing.watsup:3.1-6.60
syntax context = {FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:14.1-14.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:22.1-24.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%?]`(n_1, ?(n_2)), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:15.1-15.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:26.1-27.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:16.1-16.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:29.1-30.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:17.1-17.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:32.1-34.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:18.1-18.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:36.1-38.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:19.1-19.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:41.1-43.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:45.1-47.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:49.1-51.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:53.1-55.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:61.1-61.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:64.1-65.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:67.1-68.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:62.1-62.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:70.1-72.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:75.1-75.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:83.1-86.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%?]`(n_11, ?(n_12)), `[%..%?]`(n_21, ?(n_22)))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:76.1-76.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:88.1-89.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:77.1-77.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:91.1-92.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:78.1-78.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:94.1-96.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:79.1-79.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:98.1-100.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:80.1-80.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:103.1-105.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:107.1-109.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:111.1-113.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:115.1-117.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:172.1-172.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:174.1-176.29
  rule _ {C : context, ft : functype}:
    `%|-%:%`(C, ft, ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:123.1-124.67
rec {

;; 3-typing.watsup:123.1-123.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:153.1-154.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:156.1-157.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:159.1-160.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:163.1-164.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?(t)), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:166.1-169.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = $valtype_numtype(numtype)) \/ (t' = $valtype_vectype(vectype)))

  ;; 3-typing.watsup:178.1-181.57
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:183.1-186.57
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1]*{t_1}, RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:188.1-192.59
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:195.1-197.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:199.1-201.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:203.1-206.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:208.1-210.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 3-typing.watsup:212.1-214.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (C.FUNC_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:216.1-219.26
  rule call_indirect {C : context, ft : functype, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, ft), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (ft = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:222.1-223.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:225.1-226.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:228.1-229.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:231.1-232.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([$valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:234.1-235.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:238.1-240.23
  rule extend {C : context, n : n, nt : numtype}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))
    -- if (n <= !($size($valtype_numtype(nt))))

  ;; 3-typing.watsup:242.1-245.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([$valtype_numtype(nt_2)], [$valtype_numtype(nt_1)]))
    -- if (nt_1 =/= nt_2)
    -- if (!($size($valtype_numtype(nt_1))) = !($size($valtype_numtype(nt_2))))

  ;; 3-typing.watsup:247.1-250.52
  rule convert-i {C : context, in_1 : in, in_2 : in, sx? : sx?}:
    `%|-%:%`(C, CVTOP_instr($numtype_in(in_1), CONVERT_cvtop, $numtype_in(in_2), sx?{sx}), `%->%`([$valtype_in(in_2)], [$valtype_in(in_1)]))
    -- if (in_1 =/= in_2)
    -- if ((sx?{sx} = ?()) <=> (!($size($valtype_in(in_1))) > !($size($valtype_in(in_2)))))

  ;; 3-typing.watsup:252.1-254.22
  rule convert-f {C : context, fn_1 : fn, fn_2 : fn}:
    `%|-%:%`(C, CVTOP_instr($numtype_fn(fn_1), CONVERT_cvtop, $numtype_fn(fn_2), ?()), `%->%`([$valtype_fn(fn_2)], [$valtype_fn(fn_1)]))
    -- if (fn_1 =/= fn_2)

  ;; 3-typing.watsup:257.1-258.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [$valtype_reftype(rt)]))

  ;; 3-typing.watsup:260.1-262.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:264.1-265.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([$valtype_reftype(rt)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-270.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:272.1-274.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:276.1-278.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:281.1-283.29
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(()?{}, t))

  ;; 3-typing.watsup:285.1-287.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(()), t))

  ;; 3-typing.watsup:290.1-292.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [$valtype_reftype(rt)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:294.1-296.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype $valtype_reftype(rt)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:298.1-300.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:302.1-304.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([$valtype_reftype(rt) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:306.1-308.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype $valtype_reftype(rt) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:310.1-313.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:315.1-318.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:320.1-322.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:325.1-327.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:329.1-331.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:333.1-335.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:337.1-339.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:341.1-344.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:346.1-348.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:350.1-355.32
  rule load {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, n_A, n_O), `%->%`([I32_valtype], [$valtype_numtype(nt)]))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (!($size($valtype_numtype(nt))) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (!($size($valtype_numtype(nt))) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_in(in)))

  ;; 3-typing.watsup:357.1-362.32
  rule store {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, n_A, n_O), `%->%`([I32_valtype $valtype_numtype(nt)], []))
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (!($size($valtype_numtype(nt))) / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (!($size($valtype_numtype(nt))) / 8))))?{n}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_in(in)))

;; 3-typing.watsup:124.1-124.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:133.1-134.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:136.1-139.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:141.1-146.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:148.1-150.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:125.1-125.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:128.1-130.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:367.1-367.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:371.1-372.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:374.1-375.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:377.1-378.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:380.1-382.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(), t))

;; 3-typing.watsup:368.1-368.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:385.1-386.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:369.1-369.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:389.1-392.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:397.1-397.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:408.1-412.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, `FUNC%%*%`(ft, t*{t}, expr), ft)
    -- if (ft = `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:398.1-398.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:414.1-418.40
  rule _ {C : context, expr : expr, gt : globaltype, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `MUT%?%`(()?{}, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:399.1-399.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:420.1-422.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:400.1-400.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:424.1-426.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:403.1-403.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:437.1-440.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:442.1-443.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:401.1-401.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:428.1-431.40
  rule _ {C : context, elemmode? : elemmode?, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%?`(rt, expr*{expr}, elemmode?{elemmode}), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [$valtype_reftype(rt)]))*{expr}
    -- (Elemmode_ok: `%|-%:%`(C, elemmode, rt))?{elemmode}

;; 3-typing.watsup:404.1-404.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:445.1-448.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, MEMORY_datamode(0, expr))
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

;; 3-typing.watsup:402.1-402.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:433.1-435.40
  rule _ {C : context, b* : byte*, datamode? : datamode?}:
    `%|-%:OK`(C, `DATA%*%?`(b*{b}, datamode?{datamode}))
    -- (Datamode_ok: `%|-%:OK`(C, datamode))?{datamode}

;; 3-typing.watsup:405.1-405.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:450.1-452.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:455.1-455.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:459.1-461.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:457.1-457.83
relation Externuse_ok: `%|-%:%`(context, externuse, externtype)
  ;; 3-typing.watsup:467.1-469.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externuse(x), FUNC_externtype(ft))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:471.1-473.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externuse(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:475.1-477.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externuse(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:479.1-481.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externuse(x), MEM_externtype(mt))
    -- if (C.MEM_context[x] = mt)

;; 3-typing.watsup:456.1-456.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:463.1-465.39
  rule _ {C : context, externuse : externuse, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externuse), xt)
    -- Externuse_ok: `%|-%:%`(C, externuse, xt)

;; 3-typing.watsup:484.1-484.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:486.1-500.16
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (C = {FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

;; 4-runtime.watsup:3.1-3.39
syntax addr = nat

;; 4-runtime.watsup:4.1-4.53
syntax funcaddr = addr

;; 4-runtime.watsup:5.1-5.53
syntax globaladdr = addr

;; 4-runtime.watsup:6.1-6.51
syntax tableaddr = addr

;; 4-runtime.watsup:7.1-7.50
syntax memaddr = addr

;; 4-runtime.watsup:8.1-8.49
syntax elemaddr = addr

;; 4-runtime.watsup:9.1-9.49
syntax dataaddr = addr

;; 4-runtime.watsup:10.1-10.51
syntax labeladdr = addr

;; 4-runtime.watsup:11.1-11.49
syntax hostaddr = addr

;; 4-runtime.watsup:24.1-25.24
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:26.1-27.67
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:28.1-29.10
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:31.1-32.18
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:38.1-39.66
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:44.1-44.44
def default_ : valtype -> val?
  ;; 4-runtime.watsup:45.1-45.35
  def default_(I32_valtype) = ?(CONST_val(I32_numtype, 0))
  ;; 4-runtime.watsup:46.1-46.35
  def default_(I64_valtype) = ?(CONST_val(I64_numtype, 0))
  ;; 4-runtime.watsup:47.1-47.35
  def default_(F32_valtype) = ?(CONST_val(F32_numtype, 0))
  ;; 4-runtime.watsup:48.1-48.35
  def default_(F64_valtype) = ?(CONST_val(F64_numtype, 0))
  ;; 4-runtime.watsup:49.1-49.44
  def default_(FUNCREF_valtype) = ?(REF.NULL_val(FUNCREF_reftype))
  ;; 4-runtime.watsup:50.1-50.48
  def default_(EXTERNREF_valtype) = ?(REF.NULL_val(EXTERNREF_reftype))
  def {x : valtype} default_(x) = ?()

;; 4-runtime.watsup:72.1-74.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:84.1-91.25
syntax moduleinst = {FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:55.1-57.16
syntax funcinst = {MODULE moduleinst, CODE func}

;; 4-runtime.watsup:58.1-60.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:61.1-63.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:64.1-66.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:67.1-69.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:70.1-71.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:76.1-82.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:93.1-95.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:96.1-96.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:180.1-187.5
rec {

;; 4-runtime.watsup:180.1-187.5
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
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
  | LOAD(numtype, (n, sx)?, u32, u32)
  | STORE(numtype, n?, u32, u32)
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
  def {x : valtype?} admininstr_instr(SELECT_instr(x)) = SELECT_admininstr(x)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(BLOCK_instr(x0, x1)) = BLOCK_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(LOOP_instr(x0, x1)) = LOOP_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*, x2 : instr*} admininstr_instr(IF_instr(x0, x1, x2)) = IF_admininstr(x0, x1, x2)
  def {x : labelidx} admininstr_instr(BR_instr(x)) = BR_admininstr(x)
  def {x : labelidx} admininstr_instr(BR_IF_instr(x)) = BR_IF_admininstr(x)
  def {x0 : labelidx*, x1 : labelidx} admininstr_instr(BR_TABLE_instr(x0, x1)) = BR_TABLE_admininstr(x0, x1)
  def {x : funcidx} admininstr_instr(CALL_instr(x)) = CALL_admininstr(x)
  def {x0 : tableidx, x1 : functype} admininstr_instr(CALL_INDIRECT_instr(x0, x1)) = CALL_INDIRECT_admininstr(x0, x1)
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
  def {x0 : numtype, x1 : (n, sx)?, x2 : u32, x3 : u32} admininstr_instr(LOAD_instr(x0, x1, x2, x3)) = LOAD_admininstr(x0, x1, x2, x3)
  def {x0 : numtype, x1 : n?, x2 : u32, x3 : u32} admininstr_instr(STORE_instr(x0, x1, x2, x3)) = STORE_admininstr(x0, x1, x2, x3)

def admininstr_ref : ref -> admininstr
  def {x : reftype} admininstr_ref(REF.NULL_ref(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_ref(REF.FUNC_ADDR_ref(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_ref(REF.HOST_ADDR_ref(x)) = REF.HOST_ADDR_admininstr(x)

def admininstr_val : val -> admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_val(CONST_val(x0, x1)) = CONST_admininstr(x0, x1)
  def {x : reftype} admininstr_val(REF.NULL_val(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_val(REF.FUNC_ADDR_val(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_val(REF.HOST_ADDR_val(x)) = REF.HOST_ADDR_admininstr(x)

;; 4-runtime.watsup:97.1-97.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:115.1-115.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:116.1-116.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:118.1-118.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:125.1-125.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:119.1-119.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:126.1-126.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:120.1-120.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:127.1-127.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:121.1-121.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:128.1-128.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:122.1-122.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:129.1-129.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:123.1-123.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:130.1-130.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:132.1-132.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:140.1-140.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:133.1-133.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:141.1-141.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:134.1-134.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:142.1-142.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:135.1-135.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:143.1-143.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:136.1-136.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:144.1-144.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:137.1-137.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:145.1-145.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:138.1-138.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:146.1-146.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:149.1-149.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:158.1-158.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:150.1-150.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:159.1-159.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:151.1-151.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:160.1-160.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:152.1-152.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:161.1-161.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:153.1-153.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:162.1-162.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:154.1-154.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:163.1-163.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:155.1-155.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:164.1-164.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:156.1-156.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:165.1-165.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:167.1-167.49
def grow_table : (tableinst, nat, ref) -> tableinst
  ;; 4-runtime.watsup:169.1-172.57
  def {i : nat, i' : nat, j? : nat?, n : n, r : ref, r'* : ref*, reftype : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ti'
    -- if (ti = {TYPE `%%`(`[%..%?]`(i, j?{j}), reftype), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%?]`(i', j?{j}), reftype), ELEM r'*{r'} :: r^n{}})

;; 4-runtime.watsup:168.1-168.41
def grow_memory : (meminst, nat) -> meminst
  ;; 4-runtime.watsup:173.1-176.66
  def {b* : byte*, i : nat, i' : nat, j? : nat?, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = mi'
    -- if (mi = {TYPE `%I8`(`[%..%?]`(i, j?{j})), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%?]`(i', j?{j})), DATA b*{b} :: 0^((n * 64) * $Ki){}})

;; 4-runtime.watsup:189.1-192.21
rec {

;; 4-runtime.watsup:189.1-192.21
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

;; 5-numerics.watsup:13.1-13.28
def bytes_ : (nat, c_numtype) -> byte*

;; 5-numerics.watsup:14.1-14.47
def inverse_of_bytes_ : (nat, byte*) -> c_numtype

;; 6-reduction.watsup:4.1-4.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:16.1-17.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:19.1-20.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:22.1-23.24
  rule drop {val : val}:
    `%*~>%*`([$admininstr_val(val) DROP_admininstr], [])

  ;; 6-reduction.watsup:26.1-28.16
  rule select-true {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [$admininstr_val(val_1)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:30.1-32.14
  rule select-false {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [$admininstr_val(val_2)])
    -- if (c = 0)

  ;; 6-reduction.watsup:35.1-37.28
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`($admininstr_val(val)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})], [LABEL__admininstr(n, [], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if (bt = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:39.1-41.28
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`($admininstr_val(val)^k{val} :: [LOOP_admininstr(bt, instr*{instr})], [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if (bt = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:43.1-45.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:47.1-49.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:52.1-53.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, $admininstr_val(val)*{val})], $admininstr_val(val)*{val})

  ;; 6-reduction.watsup:57.1-58.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [BR_admininstr(0)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val} :: $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:60.1-61.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val)*{val} :: [BR_admininstr(l + 1)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:64.1-66.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:68.1-70.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:73.1-75.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:77.1-79.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:102.1-103.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val)^n{val})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:105.1-106.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:108.1-109.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, $admininstr_val(val)*{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:112.1-114.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 6-reduction.watsup:116.1-118.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:121.1-123.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 6-reduction.watsup:125.1-127.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:130.1-132.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 6-reduction.watsup:134.1-136.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 6-reduction.watsup:139.1-140.70
  rule extend {c : c_numtype, n : n, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, !($size($valtype_numtype(nt))), S_sx, c))])

  ;; 6-reduction.watsup:143.1-145.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [c])

  ;; 6-reduction.watsup:147.1-149.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:156.1-158.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(rt))

  ;; 6-reduction.watsup:160.1-162.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:171.1-172.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([$admininstr_val(val) LOCAL.TEE_admininstr(x)], [$admininstr_val(val) $admininstr_val(val) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:5.1-5.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:82.1-83.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:85.1-89.17
  rule call_indirect-call {a : addr, ft : functype, ft' : functype, i : nat, instr* : instr*, t* : valtype*, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [CALL_ADDR_admininstr(a)])
    -- if ($table(z, x).ELEM_tableinst[i] = REF.FUNC_ADDR_ref(a))
    -- if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(ft', t*{t}, instr*{instr}))
    -- if (ft = ft')

  ;; 6-reduction.watsup:91.1-93.15
  rule call_indirect-trap {ft : functype, i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:95.1-99.52
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, m : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], $admininstr_instr(instr)*{instr})])])
    -- if ($funcinst(z)[a] = {MODULE m, CODE func})
    -- if (func = `FUNC%%*%`(`%->%`(t_1^k{t_1}, t_2^n{t_2}), t*{t}, instr*{instr}))
    -- if (f = {LOCAL val^k{val} :: !($default_(t))*{t}, MODULE m})

  ;; 6-reduction.watsup:152.1-153.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:165.1-166.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [$admininstr_val($local(z, x))])

  ;; 6-reduction.watsup:175.1-176.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [$admininstr_val($global(z, x).VALUE_globalinst)])

  ;; 6-reduction.watsup:182.1-184.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:186.1-188.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [$admininstr_ref($table(z, x).ELEM_tableinst[i])])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:199.1-201.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 6-reduction.watsup:214.1-216.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:218.1-221.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:223.1-227.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:230.1-232.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:234.1-237.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:239.1-244.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:246.1-250.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:253.1-255.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:257.1-260.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:262.1-266.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) $admininstr_ref($elem(z, y).ELEM_eleminst[i]) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:273.1-275.53
  rule load-num-trap {i : nat, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), n_A, n_O)]), [TRAP_admininstr])
    -- if (((i + n_O) + (!($size($valtype_numtype(nt))) / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:277.1-279.71
  rule load-num-val {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), n_A, n_O)]), [CONST_admininstr(nt, c)])
    -- if ($bytes_(!($size($valtype_numtype(nt))), c) = $mem(z, 0).DATA_meminst[(i + n_O) : (!($size($valtype_numtype(nt))) / 8)])

  ;; 6-reduction.watsup:281.1-283.45
  rule load-pack-trap {i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), n_A, n_O)]), [TRAP_admininstr])
    -- if (((i + n_O) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:285.1-287.55
  rule load-pack-val {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), n_A, n_O)]), [CONST_admininstr(nt, $ext(n, !($size($valtype_numtype(nt))), sx, c))])
    -- if ($bytes_(n, c) = $mem(z, 0).DATA_meminst[(i + n_O) : (n / 8)])

  ;; 6-reduction.watsup:307.1-309.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:322.1-324.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:326.1-329.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:331.1-335.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:338.1-340.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:342.1-345.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:347.1-352.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), 0, 0) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:354.1-358.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), 0, 0) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:361.1-363.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:365.1-368.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:370.1-374.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- otherwise

;; 6-reduction.watsup:3.1-3.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:7.1-9.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_pure: `%*~>%*`($admininstr_instr(instr)*{instr}, $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:11.1-13.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, $admininstr_instr(instr)*{instr}), $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:168.1-169.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:178.1-179.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:190.1-192.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:194.1-196.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:204.1-208.36
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, ti' : tableinst, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti'), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if ($table(z, x) = ti)
    -- if ($grow_table(ti, n, ref) = ti')
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)

  ;; 6-reduction.watsup:210.1-211.64
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 6-reduction.watsup:269.1-270.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:290.1-292.53
  rule store-num-trap {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + n_O) + (!($size($valtype_numtype(nt))) / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:294.1-296.35
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), n_A, n_O)]), `%;%*`($with_mem(z, 0, (i + n_O), (!($size($valtype_numtype(nt))) / 8), b*{b}), []))
    -- if (b*{b} = $bytes_(!($size($valtype_numtype(nt))), c))

  ;; 6-reduction.watsup:298.1-300.45
  rule store-pack-trap {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + n_O) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:302.1-304.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), n_A, n_O)]), `%;%*`($with_mem(z, 0, (i + n_O), (n / 8), b*{b}), []))
    -- if (b*{b} = $bytes_(n, $wrap_((!($size($valtype_numtype(nt))), n), c)))

  ;; 6-reduction.watsup:312.1-316.34
  rule memory.grow-succeed {mi : meminst, mi' : meminst, n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi'), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- if ($mem(z, 0) = mi)
    -- if ($grow_memory(mi, n) = mi')
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)

  ;; 6-reduction.watsup:318.1-319.59
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 6-reduction.watsup:377.1-378.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:3.1-3.64
rec {

;; 7-module.watsup:3.1-3.64
def alloc_import : (moduleinst, import*, externval*) -> moduleinst
  ;; 7-module.watsup:5.1-5.43
  def {m : moduleinst} alloc_import(m, [], []) = m
  ;; 7-module.watsup:7.1-12.60
  def {externtype : externtype, externval : externval, externval'* : externval*, fa : funcaddr, functype : functype, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = FUNC_externtype(functype))
    -- if (externval = FUNC_externval(fa))
    -- if (m_new = m[FUNC_moduleinst =.. [fa]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:14.1-19.60
  def {externtype : externtype, externval : externval, externval'* : externval*, ga : globaladdr, globaltype : globaltype, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = GLOBAL_externtype(globaltype))
    -- if (externval = GLOBAL_externval(ga))
    -- if (m_new = m[GLOBAL_moduleinst =.. [ga]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:21.1-26.60
  def {externtype : externtype, externval : externval, externval'* : externval*, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name, ta : tableaddr, tabletype : tabletype} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = TABLE_externtype(tabletype))
    -- if (externval = TABLE_externval(ta))
    -- if (m_new = m[TABLE_moduleinst =.. [ta]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:28.1-33.60
  def {externtype : externtype, externval : externval, externval'* : externval*, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, ma : memaddr, memtype : memtype, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = MEM_externtype(memtype))
    -- if (externval = MEM_externval(ma))
    -- if (m_new = m[MEM_moduleinst =.. [ma]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
}

;; 7-module.watsup:36.1-36.51
rec {

;; 7-module.watsup:36.1-36.51
def alloc_func : (state, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:38.1-38.48
  def {f : frame, s : store} alloc_func(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:40.1-44.56
  def {f : frame, fa : funcaddr, fa'* : funcaddr*, fi : funcinst, func : func, func'* : func*, s : store, s_new : store, s_res : store} alloc_func(`%;%`(s, f), [func] :: func'*{func'}) = (s_res, [fa] :: fa'*{fa'})
    -- if (fi = {MODULE f.MODULE_frame, CODE func})
    -- if (fa = |$funcinst(`%;%`(s, f))|)
    -- if (s_new = s[FUNC_store =.. [fi]])
    -- if ((s_res, fa'*{fa'}) = $alloc_func(`%;%`(s_new, f), func'*{func'}))
}

;; 7-module.watsup:47.1-47.57
rec {

;; 7-module.watsup:47.1-47.57
def alloc_global : (state, global*) -> (store, globaladdr*)
  ;; 7-module.watsup:49.1-49.50
  def {f : frame, s : store} alloc_global(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:51.1-57.60
  def {f : frame, ga : globaladdr, ga'* : globaladdr*, gi : globalinst, global : global, global'* : global*, globaltype : globaltype, instr* : instr*, s : store, s_new : store, s_res : store, val : val} alloc_global(`%;%`(s, f), [global] :: global'*{global'}) = (s_res, [ga] :: ga'*{ga'})
    -- if (global = GLOBAL(globaltype, instr*{instr}))
    -- Step_read: `%~>%*`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr}), [$admininstr_val(val)])
    -- if (gi = {TYPE globaltype, VALUE val})
    -- if (ga = |$globalinst(`%;%`(s, f))|)
    -- if (s_new = s[GLOBAL_store =.. [gi]])
    -- if ((s_res, ga'*{ga'}) = $alloc_global(`%;%`(s_new, f), global'*{global'}))
}

;; 7-module.watsup:60.1-60.54
rec {

;; 7-module.watsup:60.1-60.54
def alloc_table : (state, table*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.49
  def {f : frame, s : store} alloc_table(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:64.1-70.58
  def {f : frame, i : nat, j? : nat?, reftype : reftype, s : store, s_new : store, s_res : store, ta : tableaddr, ta'* : tableaddr*, table : table, table'* : table*, tabletype : tabletype, ti : tableinst} alloc_table(`%;%`(s, f), [table] :: table'*{table'}) = (s_res, [ta] :: ta'*{ta'})
    -- if (table = TABLE(tabletype))
    -- if (tabletype = `%%`(`[%..%?]`(i, j?{j}), reftype))
    -- if (ti = {TYPE tabletype, ELEM REF.NULL_ref(reftype)^i{}})
    -- if (ta = |$tableinst(`%;%`(s, f))|)
    -- if (s_new = s[TABLE_store =.. [ti]])
    -- if ((s_res, ta'*{ta'}) = $alloc_table(`%;%`(s_new, f), table'*{table'}))
}

;; 7-module.watsup:73.1-73.48
rec {

;; 7-module.watsup:73.1-73.48
def alloc_mem : (state, mem*) -> (store, memaddr*)
  ;; 7-module.watsup:75.1-75.47
  def {f : frame, s : store} alloc_mem(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:77.1-83.54
  def {f : frame, i : nat, j? : nat?, ma : memaddr, ma'* : memaddr*, mem : mem, mem'* : mem*, memtype : memtype, mi : meminst, s : store, s_new : store, s_res : store} alloc_mem(`%;%`(s, f), [mem] :: mem'*{mem'}) = (s_res, [ma] :: ma'*{ma'})
    -- if (mem = MEMORY(memtype))
    -- if (memtype = `%I8`(`[%..%?]`(i, j?{j})))
    -- if (mi = {TYPE memtype, DATA 0^((i * 64) * $Ki){}})
    -- if (ma = |$meminst(`%;%`(s, f))|)
    -- if (s_new = s[MEM_store =.. [mi]])
    -- if ((s_res, ma'*{ma'}) = $alloc_mem(`%;%`(s_new, f), mem'*{mem'}))
}

;; 7-module.watsup:86.1-86.51
rec {

;; 7-module.watsup:86.1-86.51
def alloc_elem : (state, elem*) -> (store, elemaddr*)
  ;; 7-module.watsup:88.1-88.48
  def {f : frame, s : store} alloc_elem(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:90.1-96.56
  def {ea : elemaddr, ea'* : elemaddr*, ei : eleminst, elem : elem, elem'* : elem*, elemmode? : elemmode?, f : frame, instr** : instr**, ref* : ref*, reftype : reftype, s : store, s_new : store, s_res : store} alloc_elem(`%;%`(s, f), [elem] :: elem'*{elem'}) = (s_res, [ea] :: ea'*{ea'})
    -- if (elem = `ELEM%%*%?`(reftype, instr*{instr}*{instr}, elemmode?{elemmode}))
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr}), [$admininstr_ref(ref)]))*{instr ref}
    -- if (ei = {TYPE reftype, ELEM ref*{ref}})
    -- if (ea = |$eleminst(`%;%`(s, f))|)
    -- if (s_new = s[ELEM_store =.. [ei]])
    -- if ((s_res, ea'*{ea'}) = $alloc_elem(`%;%`(s_new, f), elem'*{elem'}))
}

;; 7-module.watsup:99.1-99.51
rec {

;; 7-module.watsup:99.1-99.51
def alloc_data : (state, data*) -> (store, dataaddr*)
  ;; 7-module.watsup:101.1-101.48
  def {f : frame, s : store} alloc_data(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:103.1-108.56
  def {byte* : byte*, da : dataaddr, da'* : dataaddr*, data : data, data'* : data*, datamode? : datamode?, di : datainst, f : frame, s : store, s_new : store, s_res : store} alloc_data(`%;%`(s, f), [data] :: data'*{data'}) = (s_res, [da] :: da'*{da'})
    -- if (data = `DATA%*%?`(byte*{byte}, datamode?{datamode}))
    -- if (di = {DATA byte*{byte}})
    -- if (da = |$datainst(`%;%`(s, f))|)
    -- if (s_new = s[DATA_store =.. [di]])
    -- if ((s_res, da'*{da'}) = $alloc_data(`%;%`(s_new, f), data'*{data'}))
}

;; 7-module.watsup:111.1-111.62
rec {

;; 7-module.watsup:111.1-111.62
def replace_moduleinst : (store, funcaddr*, moduleinst) -> store
  ;; 7-module.watsup:113.1-113.43
  def {m : moduleinst, s : store} replace_moduleinst(s, [], m) = s
  ;; 7-module.watsup:115.1-117.52
  def {fa : funcaddr, fa'* : funcaddr*, m : moduleinst, s : store, s_new : store, s_res : store} replace_moduleinst(s, [fa] :: fa'*{fa'}, m) = s_res
    -- if (s_new = s[FUNC_store[fa].MODULE_funcinst = m])
    -- if (s_res = $replace_moduleinst(s_new, fa'*{fa'}, m))
}

;; 7-module.watsup:120.1-120.51
def alloc_export : (moduleinst, export) -> exportinst
  ;; 7-module.watsup:122.1-126.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = FUNC_externuse(x))
    -- if (externval = FUNC_externval(m.FUNC_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:128.1-132.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = GLOBAL_externuse(x))
    -- if (externval = GLOBAL_externval(m.GLOBAL_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:134.1-138.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = TABLE_externuse(x))
    -- if (externval = TABLE_externval(m.TABLE_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:140.1-144.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = MEM_externuse(x))
    -- if (externval = MEM_externval(m.MEM_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})

;; 7-module.watsup:147.1-147.67
def alloc_module : (store, module, externval*) -> (store, moduleinst)
  ;; 7-module.watsup:149.1-163.56
  def {da* : dataaddr*, data* : data*, ea* : elemaddr*, elem* : elem*, export* : export*, externval* : externval*, f : frame, fa* : funcaddr*, func* : func*, ga* : globaladdr*, global* : global*, import* : import*, m_ex : moduleinst, m_im : moduleinst, m_init : moduleinst, m_res : moduleinst, ma* : memaddr*, mem* : mem*, module : module, s : store, s_data : store, s_elem : store, s_func : store, s_global : store, s_mem : store, s_res : store, s_table : store, start? : start?, ta* : tableaddr*, table* : table*, xi* : exportinst*} alloc_module(s, module, externval*{externval}) = (s_res, m_res)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (m_init = {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (m_im = $alloc_import(m_init, import*{import}, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m_im})
    -- if ((s_func, fa*{fa}) = $alloc_func(`%;%`(s, f), func*{func}))
    -- if ((s_global, ga*{ga}) = $alloc_global(`%;%`(s_func, f), global*{global}))
    -- if ((s_table, ta*{ta}) = $alloc_table(`%;%`(s_global, f), table*{table}))
    -- if ((s_mem, ma*{ma}) = $alloc_mem(`%;%`(s_table, f), mem*{mem}))
    -- if ((s_elem, ea*{ea}) = $alloc_elem(`%;%`(s_mem, f), elem*{elem}))
    -- if ((s_data, da*{da}) = $alloc_data(`%;%`(s_elem, f), data*{data}))
    -- if (m_ex = m_im ++ {FUNC fa*{fa}, GLOBAL ga*{ga}, TABLE ta*{ta}, MEM ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT []})
    -- if (xi*{xi} = $alloc_export(m_ex, export)*{export})
    -- if (m_res = m_ex[EXPORT_moduleinst = xi*{xi}])
    -- if (s_res = $replace_moduleinst(s_data, fa*{fa}, m_res))

;; 7-module.watsup:166.1-166.41
rec {

;; 7-module.watsup:166.1-166.41
def run_elem : (state, elem*, idx) -> state
  ;; 7-module.watsup:168.1-168.41
  def {f : frame, i : nat, s : store} run_elem(`%;%`(s, f), [], i) = `%;%`(s, f)
  ;; 7-module.watsup:170.1-172.59
  def {elem : elem, elem'* : elem*, expr* : expr*, f : frame, f_res : frame, i : nat, reftype : reftype, s : store, s_res : store} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?()))
    -- if ($run_elem(`%;%`(s, f), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:174.1-179.67
  def {elem : elem, elem'* : elem*, elemmode : elemmode, expr* : expr*, f : frame, f_new : frame, f_res : frame, i : nat, instr* : instr*, n : n, reftype : reftype, s : store, s_new : store, s_res : store, x : idx} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?(elemmode)))
    -- if (n = |expr*{expr}|)
    -- if (elemmode = TABLE_elemmode(x, instr*{instr}))
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr} :: [CONST_admininstr(I32_numtype, 0) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, i) ELEM.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_elem(`%;%`(s_new, f_new), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:181.1-185.67
  def {elem : elem, elem'* : elem*, elemmode : elemmode, expr* : expr*, f : frame, f_new : frame, f_res : frame, i : nat, reftype : reftype, s : store, s_new : store, s_res : store} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?(elemmode)))
    -- if (elemmode = DECLARE_elemmode)
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), [ELEM.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_elem(`%;%`(s_new, f_new), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
}

;; 7-module.watsup:188.1-188.41
rec {

;; 7-module.watsup:188.1-188.41
def run_data : (state, data*, idx) -> state
  ;; 7-module.watsup:190.1-190.41
  def {f : frame, i : nat, s : store} run_data(`%;%`(s, f), [], i) = `%;%`(s, f)
  ;; 7-module.watsup:192.1-194.59
  def {byte* : byte*, data : data, data'* : data*, f : frame, f_res : frame, i : nat, s : store, s_res : store} run_data(`%;%`(s, f), [data] :: data'*{data'}, i) = `%;%`(s_res, f_res)
    -- if (data = `DATA%*%?`(byte*{byte}, ?()))
    -- if ($run_data(`%;%`(s, f), data'*{data'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:196.1-201.67
  def {byte* : byte*, data : data, data'* : data*, datamode : datamode, f : frame, f_new : frame, f_res : frame, i : nat, instr* : instr*, n : n, s : store, s_new : store, s_res : store} run_data(`%;%`(s, f), [data] :: data'*{data'}, i) = `%;%`(s_res, f_res)
    -- if (data = `DATA%*%?`(byte*{byte}, ?(datamode)))
    -- if (n = |byte*{byte}|)
    -- if (datamode = MEMORY_datamode(0, instr*{instr}))
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr} :: [CONST_admininstr(I32_numtype, 0) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(i) DATA.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_data(`%;%`(s_new, f_new), data'*{data'}, (i + 1)) = `%;%`(s_res, f_res))
}

;; 7-module.watsup:204.1-204.68
def instantiation : (store, module, externval*) -> (store, moduleinst)
  ;; 7-module.watsup:206.1-211.61
  def {data* : data*, elem* : elem*, export* : export*, externval* : externval*, f : frame, f_elem : frame, f_res : frame, func* : func*, global* : global*, import* : import*, m : moduleinst, mem* : mem*, module : module, s : store, s_alloc : store, s_elem : store, s_res : store, table* : table*} instantiation(s, module, externval*{externval}) = (s_res, m)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, ?(), export*{export}))
    -- if ((s_alloc, m) = $alloc_module(s, module, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m})
    -- if ($run_elem(`%;%`(s_alloc, f), elem*{elem}, 0) = `%;%`(s_elem, f_elem))
    -- if ($run_data(`%;%`(s_elem, f_elem), data*{data}, 0) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:213.1-220.62
  def {data* : data*, elem* : elem*, export* : export*, externval* : externval*, f : frame, f_data : frame, f_elem : frame, f_res : frame, func* : func*, global* : global*, import* : import*, m : moduleinst, mem* : mem*, module : module, s : store, s_alloc : store, s_data : store, s_elem : store, s_res : store, start : start, table* : table*, x : idx} instantiation(s, module, externval*{externval}) = (s_res, m)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, ?(start), export*{export}))
    -- if ((s_alloc, m) = $alloc_module(s, module, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m})
    -- if ($run_elem(`%;%`(s_alloc, f), elem*{elem}, 0) = `%;%`(s_elem, f_elem))
    -- if ($run_data(`%;%`(s_elem, f_elem), data*{data}, 0) = `%;%`(s_data, f_data))
    -- if (start = START(x))
    -- Step: `%~>%`(`%;%*`(`%;%`(s_data, f_data), [CALL_admininstr(x)]), `%;%*`(`%;%`(s_res, f_res), []))

;; 7-module.watsup:223.1-223.55
def invocation : (store, funcaddr, val*) -> (store, val*)
  ;; 7-module.watsup:225.1-232.55
  def {expr : expr, f : frame, f' : frame, fa : funcaddr, functype : functype, m : moduleinst, s : store, s' : store, val* : val*, val'* : val*, valtype* : valtype*, valtype'* : valtype*} invocation(s, fa, val*{val}) = (s', val'*{val'})
    -- if (m = {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE m})
    -- if ($funcinst(`%;%`(s, f))[fa].CODE_funcinst = `FUNC%%*%`(functype, valtype*{valtype}, expr))
    -- if (functype = `%->%`(valtype*{valtype}, valtype'*{valtype'}))
    -- if (|val*{val}| = |valtype*{valtype}|)
    -- if (|val'*{val'}| = |valtype'*{valtype'}|)
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_val(val)*{val} :: [CALL_ADDR_admininstr(fa)]), `%;%*`(`%;%`(s', f'), $admininstr_val(val')*{val'}))

== IL Validation...
== Running pass the-elimination

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:9.1-9.37
syntax name = text

;; 1-syntax.watsup:14.1-14.36
syntax byte = nat

;; 1-syntax.watsup:15.1-15.45
syntax u32 = nat

;; 1-syntax.watsup:22.1-22.36
syntax idx = nat

;; 1-syntax.watsup:23.1-23.49
syntax funcidx = idx

;; 1-syntax.watsup:24.1-24.49
syntax globalidx = idx

;; 1-syntax.watsup:25.1-25.47
syntax tableidx = idx

;; 1-syntax.watsup:26.1-26.46
syntax memidx = idx

;; 1-syntax.watsup:27.1-27.45
syntax elemidx = idx

;; 1-syntax.watsup:28.1-28.45
syntax dataidx = idx

;; 1-syntax.watsup:29.1-29.47
syntax labelidx = idx

;; 1-syntax.watsup:30.1-30.47
syntax localidx = idx

;; 1-syntax.watsup:39.1-40.22
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:41.1-42.5
syntax vectype =
  | V128

;; 1-syntax.watsup:43.1-44.20
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:45.1-46.34
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

;; 1-syntax.watsup:48.1-48.39
syntax in =
  | I32
  | I64

def numtype_in : in -> numtype
  def numtype_in(I32_in) = I32_numtype
  def numtype_in(I64_in) = I64_numtype

def valtype_in : in -> valtype
  def valtype_in(I32_in) = I32_valtype
  def valtype_in(I64_in) = I64_valtype

;; 1-syntax.watsup:49.1-49.39
syntax fn =
  | F32
  | F64

def numtype_fn : fn -> numtype
  def numtype_fn(F32_fn) = F32_numtype
  def numtype_fn(F64_fn) = F64_numtype

def valtype_fn : fn -> valtype
  def valtype_fn(F32_fn) = F32_valtype
  def valtype_fn(F64_fn) = F64_valtype

;; 1-syntax.watsup:56.1-57.11
syntax resulttype = valtype*

;; 1-syntax.watsup:59.1-60.17
syntax limits = `[%..%?]`(u32, u32?)

;; 1-syntax.watsup:61.1-62.15
syntax globaltype = `MUT%?%`(()?, valtype)

;; 1-syntax.watsup:63.1-64.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:65.1-66.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:67.1-68.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:69.1-70.10
syntax elemtype = reftype

;; 1-syntax.watsup:71.1-72.5
syntax datatype = OK

;; 1-syntax.watsup:73.1-74.66
syntax externtype =
  | GLOBAL(globaltype)
  | FUNC(functype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:86.1-86.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:88.1-88.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:89.1-89.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:91.1-93.62
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

;; 1-syntax.watsup:94.1-94.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:96.1-96.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:97.1-97.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:99.1-100.108
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:101.1-101.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:103.1-103.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:104.1-104.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:105.1-105.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:106.1-106.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:107.1-107.39
syntax cvtop =
  | CONVERT
  | REINTERPRET

;; 1-syntax.watsup:117.1-117.23
syntax c_numtype = nat

;; 1-syntax.watsup:118.1-118.23
syntax c_vectype = nat

;; 1-syntax.watsup:121.1-121.52
syntax blocktype = functype

;; 1-syntax.watsup:156.1-177.80
rec {

;; 1-syntax.watsup:156.1-177.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
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
  | LOAD(numtype, (n, sx)?, u32, u32)
  | STORE(numtype, n?, u32, u32)
}

;; 1-syntax.watsup:179.1-180.9
syntax expr = instr*

;; 1-syntax.watsup:187.1-187.50
syntax elemmode =
  | TABLE(tableidx, expr)
  | DECLARE

;; 1-syntax.watsup:188.1-188.39
syntax datamode =
  | MEMORY(memidx, expr)

;; 1-syntax.watsup:190.1-191.30
syntax func = `FUNC%%*%`(functype, valtype*, expr)

;; 1-syntax.watsup:192.1-193.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:194.1-195.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:196.1-197.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:198.1-199.31
syntax elem = `ELEM%%*%?`(reftype, expr*, elemmode?)

;; 1-syntax.watsup:200.1-201.23
syntax data = `DATA%*%?`(byte*, datamode?)

;; 1-syntax.watsup:202.1-203.16
syntax start = START(funcidx)

;; 1-syntax.watsup:205.1-206.62
syntax externuse =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:207.1-208.24
syntax export = EXPORT(name, externuse)

;; 1-syntax.watsup:209.1-210.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:212.1-213.70
syntax module = `MODULE%*%*%*%*%*%*%*%?%*`(import*, func*, global*, table*, mem*, elem*, data*, start?, export*)

;; 2-aux.watsup:3.1-3.14
def Ki : nat
  ;; 2-aux.watsup:4.1-4.15
  def Ki = 1024

;; 2-aux.watsup:9.1-9.25
rec {

;; 2-aux.watsup:9.1-9.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:10.1-10.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:11.1-11.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:12.1-12.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:19.1-19.55
def size : valtype -> nat?
  ;; 2-aux.watsup:20.1-20.20
  def size(I32_valtype) = ?(32)
  ;; 2-aux.watsup:21.1-21.20
  def size(I64_valtype) = ?(64)
  ;; 2-aux.watsup:22.1-22.20
  def size(F32_valtype) = ?(32)
  ;; 2-aux.watsup:23.1-23.20
  def size(F64_valtype) = ?(64)
  ;; 2-aux.watsup:24.1-24.22
  def size(V128_valtype) = ?(128)
  def {x : valtype} size(x) = ?()

;; 2-aux.watsup:29.1-29.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:30.1-30.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:32.1-32.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:33.1-33.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:35.1-44.39
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

;; 3-typing.watsup:3.1-6.60
syntax context = {FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:14.1-14.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:22.1-24.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%?]`(n_1, ?(n_2)), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:15.1-15.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:26.1-27.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:16.1-16.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:29.1-30.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:17.1-17.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:32.1-34.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:18.1-18.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:36.1-38.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:19.1-19.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:41.1-43.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:45.1-47.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:49.1-51.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:53.1-55.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:61.1-61.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:64.1-65.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:67.1-68.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:62.1-62.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:70.1-72.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:75.1-75.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:83.1-86.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%?]`(n_11, ?(n_12)), `[%..%?]`(n_21, ?(n_22)))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:76.1-76.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:88.1-89.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:77.1-77.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:91.1-92.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:78.1-78.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:94.1-96.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:79.1-79.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:98.1-100.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:80.1-80.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:103.1-105.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:107.1-109.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:111.1-113.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:115.1-117.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:172.1-172.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:174.1-176.29
  rule _ {C : context, ft : functype}:
    `%|-%:%`(C, ft, ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:123.1-124.67
rec {

;; 3-typing.watsup:123.1-123.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:153.1-154.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:156.1-157.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:159.1-160.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:163.1-164.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?(t)), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:166.1-169.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = $valtype_numtype(numtype)) \/ (t' = $valtype_vectype(vectype)))

  ;; 3-typing.watsup:178.1-181.57
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:183.1-186.57
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1]*{t_1}, RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:188.1-192.59
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:195.1-197.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:199.1-201.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:203.1-206.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:208.1-210.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 3-typing.watsup:212.1-214.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (C.FUNC_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:216.1-219.26
  rule call_indirect {C : context, ft : functype, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, ft), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (ft = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:222.1-223.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:225.1-226.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:228.1-229.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:231.1-232.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([$valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:234.1-235.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:238.1-240.23
  rule extend {C : context, n : n, nt : numtype, o0 : nat}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (n <= o0)

  ;; 3-typing.watsup:242.1-245.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([$valtype_numtype(nt_2)], [$valtype_numtype(nt_1)]))
    -- if ($size($valtype_numtype(nt_1)) = ?(o0))
    -- if ($size($valtype_numtype(nt_2)) = ?(o1))
    -- if (nt_1 =/= nt_2)
    -- if (o0 = o1)

  ;; 3-typing.watsup:247.1-250.52
  rule convert-i {C : context, in_1 : in, in_2 : in, sx? : sx?, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr($numtype_in(in_1), CONVERT_cvtop, $numtype_in(in_2), sx?{sx}), `%->%`([$valtype_in(in_2)], [$valtype_in(in_1)]))
    -- if ($size($valtype_in(in_1)) = ?(o0))
    -- if ($size($valtype_in(in_2)) = ?(o1))
    -- if (in_1 =/= in_2)
    -- if ((sx?{sx} = ?()) <=> (o0 > o1))

  ;; 3-typing.watsup:252.1-254.22
  rule convert-f {C : context, fn_1 : fn, fn_2 : fn}:
    `%|-%:%`(C, CVTOP_instr($numtype_fn(fn_1), CONVERT_cvtop, $numtype_fn(fn_2), ?()), `%->%`([$valtype_fn(fn_2)], [$valtype_fn(fn_1)]))
    -- if (fn_1 =/= fn_2)

  ;; 3-typing.watsup:257.1-258.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [$valtype_reftype(rt)]))

  ;; 3-typing.watsup:260.1-262.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:264.1-265.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([$valtype_reftype(rt)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-270.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:272.1-274.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:276.1-278.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:281.1-283.29
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(()?{}, t))

  ;; 3-typing.watsup:285.1-287.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(()), t))

  ;; 3-typing.watsup:290.1-292.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [$valtype_reftype(rt)]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:294.1-296.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype $valtype_reftype(rt)], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:298.1-300.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:302.1-304.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([$valtype_reftype(rt) I32_valtype], [I32_valtype]))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:306.1-308.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype $valtype_reftype(rt) I32_valtype], []))
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:310.1-313.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:315.1-318.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:320.1-322.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:325.1-327.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:329.1-331.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:333.1-335.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:337.1-339.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:341.1-344.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:346.1-348.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:350.1-355.32
  rule load {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, n_A, n_O), `%->%`([I32_valtype], [$valtype_numtype(nt)]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- (if ($size($valtype_numtype(nt)) = ?(o1)))?{o1}
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_in(in)))

  ;; 3-typing.watsup:357.1-362.32
  rule store {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, n_A, n_O), `%->%`([I32_valtype $valtype_numtype(nt)], []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- (if ($size($valtype_numtype(nt)) = ?(o1)))?{o1}
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_in(in)))

;; 3-typing.watsup:124.1-124.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:133.1-134.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:136.1-139.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:141.1-146.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:148.1-150.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:125.1-125.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:128.1-130.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:367.1-367.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:371.1-372.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:374.1-375.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:377.1-378.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:380.1-382.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(), t))

;; 3-typing.watsup:368.1-368.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:385.1-386.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:369.1-369.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:389.1-392.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:397.1-397.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:408.1-412.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, `FUNC%%*%`(ft, t*{t}, expr), ft)
    -- if (ft = `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:398.1-398.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:414.1-418.40
  rule _ {C : context, expr : expr, gt : globaltype, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `MUT%?%`(()?{}, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:399.1-399.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:420.1-422.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:400.1-400.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:424.1-426.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:403.1-403.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:437.1-440.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE_elemmode(x, expr), rt)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:442.1-443.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:401.1-401.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:428.1-431.40
  rule _ {C : context, elemmode? : elemmode?, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%?`(rt, expr*{expr}, elemmode?{elemmode}), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [$valtype_reftype(rt)]))*{expr}
    -- (Elemmode_ok: `%|-%:%`(C, elemmode, rt))?{elemmode}

;; 3-typing.watsup:404.1-404.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:445.1-448.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, MEMORY_datamode(0, expr))
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

;; 3-typing.watsup:402.1-402.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:433.1-435.40
  rule _ {C : context, b* : byte*, datamode? : datamode?}:
    `%|-%:OK`(C, `DATA%*%?`(b*{b}, datamode?{datamode}))
    -- (Datamode_ok: `%|-%:OK`(C, datamode))?{datamode}

;; 3-typing.watsup:405.1-405.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:450.1-452.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:455.1-455.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:459.1-461.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:457.1-457.83
relation Externuse_ok: `%|-%:%`(context, externuse, externtype)
  ;; 3-typing.watsup:467.1-469.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externuse(x), FUNC_externtype(ft))
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:471.1-473.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externuse(x), GLOBAL_externtype(gt))
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:475.1-477.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externuse(x), TABLE_externtype(tt))
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:479.1-481.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externuse(x), MEM_externtype(mt))
    -- if (C.MEM_context[x] = mt)

;; 3-typing.watsup:456.1-456.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:463.1-465.39
  rule _ {C : context, externuse : externuse, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externuse), xt)
    -- Externuse_ok: `%|-%:%`(C, externuse, xt)

;; 3-typing.watsup:484.1-484.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:486.1-500.16
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (C = {FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

;; 4-runtime.watsup:3.1-3.39
syntax addr = nat

;; 4-runtime.watsup:4.1-4.53
syntax funcaddr = addr

;; 4-runtime.watsup:5.1-5.53
syntax globaladdr = addr

;; 4-runtime.watsup:6.1-6.51
syntax tableaddr = addr

;; 4-runtime.watsup:7.1-7.50
syntax memaddr = addr

;; 4-runtime.watsup:8.1-8.49
syntax elemaddr = addr

;; 4-runtime.watsup:9.1-9.49
syntax dataaddr = addr

;; 4-runtime.watsup:10.1-10.51
syntax labeladdr = addr

;; 4-runtime.watsup:11.1-11.49
syntax hostaddr = addr

;; 4-runtime.watsup:24.1-25.24
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:26.1-27.67
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:28.1-29.10
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:31.1-32.18
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:38.1-39.66
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:44.1-44.44
def default_ : valtype -> val?
  ;; 4-runtime.watsup:45.1-45.35
  def default_(I32_valtype) = ?(CONST_val(I32_numtype, 0))
  ;; 4-runtime.watsup:46.1-46.35
  def default_(I64_valtype) = ?(CONST_val(I64_numtype, 0))
  ;; 4-runtime.watsup:47.1-47.35
  def default_(F32_valtype) = ?(CONST_val(F32_numtype, 0))
  ;; 4-runtime.watsup:48.1-48.35
  def default_(F64_valtype) = ?(CONST_val(F64_numtype, 0))
  ;; 4-runtime.watsup:49.1-49.44
  def default_(FUNCREF_valtype) = ?(REF.NULL_val(FUNCREF_reftype))
  ;; 4-runtime.watsup:50.1-50.48
  def default_(EXTERNREF_valtype) = ?(REF.NULL_val(EXTERNREF_reftype))
  def {x : valtype} default_(x) = ?()

;; 4-runtime.watsup:72.1-74.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:84.1-91.25
syntax moduleinst = {FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:55.1-57.16
syntax funcinst = {MODULE moduleinst, CODE func}

;; 4-runtime.watsup:58.1-60.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:61.1-63.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:64.1-66.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:67.1-69.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:70.1-71.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:76.1-82.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:93.1-95.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:96.1-96.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:180.1-187.5
rec {

;; 4-runtime.watsup:180.1-187.5
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
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
  | LOAD(numtype, (n, sx)?, u32, u32)
  | STORE(numtype, n?, u32, u32)
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
  def {x : valtype?} admininstr_instr(SELECT_instr(x)) = SELECT_admininstr(x)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(BLOCK_instr(x0, x1)) = BLOCK_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(LOOP_instr(x0, x1)) = LOOP_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*, x2 : instr*} admininstr_instr(IF_instr(x0, x1, x2)) = IF_admininstr(x0, x1, x2)
  def {x : labelidx} admininstr_instr(BR_instr(x)) = BR_admininstr(x)
  def {x : labelidx} admininstr_instr(BR_IF_instr(x)) = BR_IF_admininstr(x)
  def {x0 : labelidx*, x1 : labelidx} admininstr_instr(BR_TABLE_instr(x0, x1)) = BR_TABLE_admininstr(x0, x1)
  def {x : funcidx} admininstr_instr(CALL_instr(x)) = CALL_admininstr(x)
  def {x0 : tableidx, x1 : functype} admininstr_instr(CALL_INDIRECT_instr(x0, x1)) = CALL_INDIRECT_admininstr(x0, x1)
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
  def {x0 : numtype, x1 : (n, sx)?, x2 : u32, x3 : u32} admininstr_instr(LOAD_instr(x0, x1, x2, x3)) = LOAD_admininstr(x0, x1, x2, x3)
  def {x0 : numtype, x1 : n?, x2 : u32, x3 : u32} admininstr_instr(STORE_instr(x0, x1, x2, x3)) = STORE_admininstr(x0, x1, x2, x3)

def admininstr_ref : ref -> admininstr
  def {x : reftype} admininstr_ref(REF.NULL_ref(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_ref(REF.FUNC_ADDR_ref(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_ref(REF.HOST_ADDR_ref(x)) = REF.HOST_ADDR_admininstr(x)

def admininstr_val : val -> admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_val(CONST_val(x0, x1)) = CONST_admininstr(x0, x1)
  def {x : reftype} admininstr_val(REF.NULL_val(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_val(REF.FUNC_ADDR_val(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_val(REF.HOST_ADDR_val(x)) = REF.HOST_ADDR_admininstr(x)

;; 4-runtime.watsup:97.1-97.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:115.1-115.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:116.1-116.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:118.1-118.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:125.1-125.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:119.1-119.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:126.1-126.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:120.1-120.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:127.1-127.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:121.1-121.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:128.1-128.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:122.1-122.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:129.1-129.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:123.1-123.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:130.1-130.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:132.1-132.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:140.1-140.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:133.1-133.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:141.1-141.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:134.1-134.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:142.1-142.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:135.1-135.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:143.1-143.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:136.1-136.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:144.1-144.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:137.1-137.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:145.1-145.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:138.1-138.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:146.1-146.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:149.1-149.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:158.1-158.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:150.1-150.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:159.1-159.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:151.1-151.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:160.1-160.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:152.1-152.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:161.1-161.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:153.1-153.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:162.1-162.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:154.1-154.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:163.1-163.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:155.1-155.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:164.1-164.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:156.1-156.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:165.1-165.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:167.1-167.49
def grow_table : (tableinst, nat, ref) -> tableinst
  ;; 4-runtime.watsup:169.1-172.57
  def {i : nat, i' : nat, j? : nat?, n : n, r : ref, r'* : ref*, reftype : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ti'
    -- if (ti = {TYPE `%%`(`[%..%?]`(i, j?{j}), reftype), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%?]`(i', j?{j}), reftype), ELEM r'*{r'} :: r^n{}})

;; 4-runtime.watsup:168.1-168.41
def grow_memory : (meminst, nat) -> meminst
  ;; 4-runtime.watsup:173.1-176.66
  def {b* : byte*, i : nat, i' : nat, j? : nat?, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = mi'
    -- if (mi = {TYPE `%I8`(`[%..%?]`(i, j?{j})), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%?]`(i', j?{j})), DATA b*{b} :: 0^((n * 64) * $Ki){}})

;; 4-runtime.watsup:189.1-192.21
rec {

;; 4-runtime.watsup:189.1-192.21
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

;; 5-numerics.watsup:13.1-13.28
def bytes_ : (nat, c_numtype) -> byte*

;; 5-numerics.watsup:14.1-14.47
def inverse_of_bytes_ : (nat, byte*) -> c_numtype

;; 6-reduction.watsup:4.1-4.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:16.1-17.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:19.1-20.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:22.1-23.24
  rule drop {val : val}:
    `%*~>%*`([$admininstr_val(val) DROP_admininstr], [])

  ;; 6-reduction.watsup:26.1-28.16
  rule select-true {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [$admininstr_val(val_1)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:30.1-32.14
  rule select-false {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [$admininstr_val(val_2)])
    -- if (c = 0)

  ;; 6-reduction.watsup:35.1-37.28
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`($admininstr_val(val)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})], [LABEL__admininstr(n, [], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if (bt = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:39.1-41.28
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`($admininstr_val(val)^k{val} :: [LOOP_admininstr(bt, instr*{instr})], [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if (bt = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:43.1-45.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:47.1-49.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:52.1-53.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, $admininstr_val(val)*{val})], $admininstr_val(val)*{val})

  ;; 6-reduction.watsup:57.1-58.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [BR_admininstr(0)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val} :: $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:60.1-61.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val)*{val} :: [BR_admininstr(l + 1)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:64.1-66.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:68.1-70.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:73.1-75.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:77.1-79.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:102.1-103.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val)^n{val})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:105.1-106.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:108.1-109.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, $admininstr_val(val)*{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:112.1-114.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 6-reduction.watsup:116.1-118.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:121.1-123.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 6-reduction.watsup:125.1-127.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:130.1-132.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 6-reduction.watsup:134.1-136.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 6-reduction.watsup:139.1-140.70
  rule extend {c : c_numtype, n : n, nt : numtype, o0 : nat}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, o0, S_sx, c))])
    -- if ($size($valtype_numtype(nt)) = ?(o0))

  ;; 6-reduction.watsup:143.1-145.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [c])

  ;; 6-reduction.watsup:147.1-149.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:156.1-158.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(rt))

  ;; 6-reduction.watsup:160.1-162.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:171.1-172.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([$admininstr_val(val) LOCAL.TEE_admininstr(x)], [$admininstr_val(val) $admininstr_val(val) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:5.1-5.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:82.1-83.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:85.1-89.17
  rule call_indirect-call {a : addr, ft : functype, ft' : functype, i : nat, instr* : instr*, t* : valtype*, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [CALL_ADDR_admininstr(a)])
    -- if ($table(z, x).ELEM_tableinst[i] = REF.FUNC_ADDR_ref(a))
    -- if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(ft', t*{t}, instr*{instr}))
    -- if (ft = ft')

  ;; 6-reduction.watsup:91.1-93.15
  rule call_indirect-trap {ft : functype, i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:95.1-99.52
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, m : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state, o0* : val*}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], $admininstr_instr(instr)*{instr})])])
    -- (if ($default_(t) = ?(o0)))*{t o0}
    -- if ($funcinst(z)[a] = {MODULE m, CODE func})
    -- if (func = `FUNC%%*%`(`%->%`(t_1^k{t_1}, t_2^n{t_2}), t*{t}, instr*{instr}))
    -- if (f = {LOCAL val^k{val} :: o0*{o0}, MODULE m})

  ;; 6-reduction.watsup:152.1-153.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])

  ;; 6-reduction.watsup:165.1-166.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [$admininstr_val($local(z, x))])

  ;; 6-reduction.watsup:175.1-176.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [$admininstr_val($global(z, x).VALUE_globalinst)])

  ;; 6-reduction.watsup:182.1-184.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:186.1-188.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [$admininstr_ref($table(z, x).ELEM_tableinst[i])])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:199.1-201.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 6-reduction.watsup:214.1-216.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:218.1-221.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:223.1-227.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:230.1-232.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:234.1-237.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:239.1-244.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:246.1-250.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:253.1-255.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:257.1-260.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:262.1-266.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) $admininstr_ref($elem(z, y).ELEM_eleminst[i]) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:273.1-275.53
  rule load-num-trap {i : nat, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), n_A, n_O)]), [TRAP_admininstr])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (((i + n_O) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:277.1-279.71
  rule load-num-val {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat, o1 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), n_A, n_O)]), [CONST_admininstr(nt, c)])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if ($size($valtype_numtype(nt)) = ?(o1))
    -- if ($bytes_(o0, c) = $mem(z, 0).DATA_meminst[(i + n_O) : (o1 / 8)])

  ;; 6-reduction.watsup:281.1-283.45
  rule load-pack-trap {i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), n_A, n_O)]), [TRAP_admininstr])
    -- if (((i + n_O) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:285.1-287.55
  rule load-pack-val {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), n_A, n_O)]), [CONST_admininstr(nt, $ext(n, o0, sx, c))])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if ($bytes_(n, c) = $mem(z, 0).DATA_meminst[(i + n_O) : (n / 8)])

  ;; 6-reduction.watsup:307.1-309.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:322.1-324.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:326.1-329.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:331.1-335.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:338.1-340.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:342.1-345.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:347.1-352.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), 0, 0) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:354.1-358.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), 0, 0) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:361.1-363.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:365.1-368.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:370.1-374.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- otherwise

;; 6-reduction.watsup:3.1-3.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:7.1-9.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_pure: `%*~>%*`($admininstr_instr(instr)*{instr}, $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:11.1-13.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, $admininstr_instr(instr)*{instr}), $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:168.1-169.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:178.1-179.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:190.1-192.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:194.1-196.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:204.1-208.36
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, ti' : tableinst, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti'), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if ($table(z, x) = ti)
    -- if ($grow_table(ti, n, ref) = ti')
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)

  ;; 6-reduction.watsup:210.1-211.64
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 6-reduction.watsup:269.1-270.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:290.1-292.53
  rule store-num-trap {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (((i + n_O) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:294.1-296.35
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat, o1 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), n_A, n_O)]), `%;%*`($with_mem(z, 0, (i + n_O), (o0 / 8), b*{b}), []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if ($size($valtype_numtype(nt)) = ?(o1))
    -- if (b*{b} = $bytes_(o1, c))

  ;; 6-reduction.watsup:298.1-300.45
  rule store-pack-trap {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + n_O) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:302.1-304.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), n_A, n_O)]), `%;%*`($with_mem(z, 0, (i + n_O), (n / 8), b*{b}), []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (b*{b} = $bytes_(n, $wrap_((o0, n), c)))

  ;; 6-reduction.watsup:312.1-316.34
  rule memory.grow-succeed {mi : meminst, mi' : meminst, n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi'), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- if ($mem(z, 0) = mi)
    -- if ($grow_memory(mi, n) = mi')
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)

  ;; 6-reduction.watsup:318.1-319.59
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 6-reduction.watsup:377.1-378.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:3.1-3.64
rec {

;; 7-module.watsup:3.1-3.64
def alloc_import : (moduleinst, import*, externval*) -> moduleinst
  ;; 7-module.watsup:5.1-5.43
  def {m : moduleinst} alloc_import(m, [], []) = m
  ;; 7-module.watsup:7.1-12.60
  def {externtype : externtype, externval : externval, externval'* : externval*, fa : funcaddr, functype : functype, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = FUNC_externtype(functype))
    -- if (externval = FUNC_externval(fa))
    -- if (m_new = m[FUNC_moduleinst =.. [fa]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:14.1-19.60
  def {externtype : externtype, externval : externval, externval'* : externval*, ga : globaladdr, globaltype : globaltype, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = GLOBAL_externtype(globaltype))
    -- if (externval = GLOBAL_externval(ga))
    -- if (m_new = m[GLOBAL_moduleinst =.. [ga]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:21.1-26.60
  def {externtype : externtype, externval : externval, externval'* : externval*, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name, ta : tableaddr, tabletype : tabletype} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = TABLE_externtype(tabletype))
    -- if (externval = TABLE_externval(ta))
    -- if (m_new = m[TABLE_moduleinst =.. [ta]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:28.1-33.60
  def {externtype : externtype, externval : externval, externval'* : externval*, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, ma : memaddr, memtype : memtype, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = MEM_externtype(memtype))
    -- if (externval = MEM_externval(ma))
    -- if (m_new = m[MEM_moduleinst =.. [ma]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
}

;; 7-module.watsup:36.1-36.51
rec {

;; 7-module.watsup:36.1-36.51
def alloc_func : (state, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:38.1-38.48
  def {f : frame, s : store} alloc_func(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:40.1-44.56
  def {f : frame, fa : funcaddr, fa'* : funcaddr*, fi : funcinst, func : func, func'* : func*, s : store, s_new : store, s_res : store} alloc_func(`%;%`(s, f), [func] :: func'*{func'}) = (s_res, [fa] :: fa'*{fa'})
    -- if (fi = {MODULE f.MODULE_frame, CODE func})
    -- if (fa = |$funcinst(`%;%`(s, f))|)
    -- if (s_new = s[FUNC_store =.. [fi]])
    -- if ((s_res, fa'*{fa'}) = $alloc_func(`%;%`(s_new, f), func'*{func'}))
}

;; 7-module.watsup:47.1-47.57
rec {

;; 7-module.watsup:47.1-47.57
def alloc_global : (state, global*) -> (store, globaladdr*)
  ;; 7-module.watsup:49.1-49.50
  def {f : frame, s : store} alloc_global(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:51.1-57.60
  def {f : frame, ga : globaladdr, ga'* : globaladdr*, gi : globalinst, global : global, global'* : global*, globaltype : globaltype, instr* : instr*, s : store, s_new : store, s_res : store, val : val} alloc_global(`%;%`(s, f), [global] :: global'*{global'}) = (s_res, [ga] :: ga'*{ga'})
    -- if (global = GLOBAL(globaltype, instr*{instr}))
    -- Step_read: `%~>%*`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr}), [$admininstr_val(val)])
    -- if (gi = {TYPE globaltype, VALUE val})
    -- if (ga = |$globalinst(`%;%`(s, f))|)
    -- if (s_new = s[GLOBAL_store =.. [gi]])
    -- if ((s_res, ga'*{ga'}) = $alloc_global(`%;%`(s_new, f), global'*{global'}))
}

;; 7-module.watsup:60.1-60.54
rec {

;; 7-module.watsup:60.1-60.54
def alloc_table : (state, table*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.49
  def {f : frame, s : store} alloc_table(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:64.1-70.58
  def {f : frame, i : nat, j? : nat?, reftype : reftype, s : store, s_new : store, s_res : store, ta : tableaddr, ta'* : tableaddr*, table : table, table'* : table*, tabletype : tabletype, ti : tableinst} alloc_table(`%;%`(s, f), [table] :: table'*{table'}) = (s_res, [ta] :: ta'*{ta'})
    -- if (table = TABLE(tabletype))
    -- if (tabletype = `%%`(`[%..%?]`(i, j?{j}), reftype))
    -- if (ti = {TYPE tabletype, ELEM REF.NULL_ref(reftype)^i{}})
    -- if (ta = |$tableinst(`%;%`(s, f))|)
    -- if (s_new = s[TABLE_store =.. [ti]])
    -- if ((s_res, ta'*{ta'}) = $alloc_table(`%;%`(s_new, f), table'*{table'}))
}

;; 7-module.watsup:73.1-73.48
rec {

;; 7-module.watsup:73.1-73.48
def alloc_mem : (state, mem*) -> (store, memaddr*)
  ;; 7-module.watsup:75.1-75.47
  def {f : frame, s : store} alloc_mem(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:77.1-83.54
  def {f : frame, i : nat, j? : nat?, ma : memaddr, ma'* : memaddr*, mem : mem, mem'* : mem*, memtype : memtype, mi : meminst, s : store, s_new : store, s_res : store} alloc_mem(`%;%`(s, f), [mem] :: mem'*{mem'}) = (s_res, [ma] :: ma'*{ma'})
    -- if (mem = MEMORY(memtype))
    -- if (memtype = `%I8`(`[%..%?]`(i, j?{j})))
    -- if (mi = {TYPE memtype, DATA 0^((i * 64) * $Ki){}})
    -- if (ma = |$meminst(`%;%`(s, f))|)
    -- if (s_new = s[MEM_store =.. [mi]])
    -- if ((s_res, ma'*{ma'}) = $alloc_mem(`%;%`(s_new, f), mem'*{mem'}))
}

;; 7-module.watsup:86.1-86.51
rec {

;; 7-module.watsup:86.1-86.51
def alloc_elem : (state, elem*) -> (store, elemaddr*)
  ;; 7-module.watsup:88.1-88.48
  def {f : frame, s : store} alloc_elem(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:90.1-96.56
  def {ea : elemaddr, ea'* : elemaddr*, ei : eleminst, elem : elem, elem'* : elem*, elemmode? : elemmode?, f : frame, instr** : instr**, ref* : ref*, reftype : reftype, s : store, s_new : store, s_res : store} alloc_elem(`%;%`(s, f), [elem] :: elem'*{elem'}) = (s_res, [ea] :: ea'*{ea'})
    -- if (elem = `ELEM%%*%?`(reftype, instr*{instr}*{instr}, elemmode?{elemmode}))
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr}), [$admininstr_ref(ref)]))*{instr ref}
    -- if (ei = {TYPE reftype, ELEM ref*{ref}})
    -- if (ea = |$eleminst(`%;%`(s, f))|)
    -- if (s_new = s[ELEM_store =.. [ei]])
    -- if ((s_res, ea'*{ea'}) = $alloc_elem(`%;%`(s_new, f), elem'*{elem'}))
}

;; 7-module.watsup:99.1-99.51
rec {

;; 7-module.watsup:99.1-99.51
def alloc_data : (state, data*) -> (store, dataaddr*)
  ;; 7-module.watsup:101.1-101.48
  def {f : frame, s : store} alloc_data(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:103.1-108.56
  def {byte* : byte*, da : dataaddr, da'* : dataaddr*, data : data, data'* : data*, datamode? : datamode?, di : datainst, f : frame, s : store, s_new : store, s_res : store} alloc_data(`%;%`(s, f), [data] :: data'*{data'}) = (s_res, [da] :: da'*{da'})
    -- if (data = `DATA%*%?`(byte*{byte}, datamode?{datamode}))
    -- if (di = {DATA byte*{byte}})
    -- if (da = |$datainst(`%;%`(s, f))|)
    -- if (s_new = s[DATA_store =.. [di]])
    -- if ((s_res, da'*{da'}) = $alloc_data(`%;%`(s_new, f), data'*{data'}))
}

;; 7-module.watsup:111.1-111.62
rec {

;; 7-module.watsup:111.1-111.62
def replace_moduleinst : (store, funcaddr*, moduleinst) -> store
  ;; 7-module.watsup:113.1-113.43
  def {m : moduleinst, s : store} replace_moduleinst(s, [], m) = s
  ;; 7-module.watsup:115.1-117.52
  def {fa : funcaddr, fa'* : funcaddr*, m : moduleinst, s : store, s_new : store, s_res : store} replace_moduleinst(s, [fa] :: fa'*{fa'}, m) = s_res
    -- if (s_new = s[FUNC_store[fa].MODULE_funcinst = m])
    -- if (s_res = $replace_moduleinst(s_new, fa'*{fa'}, m))
}

;; 7-module.watsup:120.1-120.51
def alloc_export : (moduleinst, export) -> exportinst
  ;; 7-module.watsup:122.1-126.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = FUNC_externuse(x))
    -- if (externval = FUNC_externval(m.FUNC_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:128.1-132.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = GLOBAL_externuse(x))
    -- if (externval = GLOBAL_externval(m.GLOBAL_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:134.1-138.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = TABLE_externuse(x))
    -- if (externval = TABLE_externval(m.TABLE_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:140.1-144.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = MEM_externuse(x))
    -- if (externval = MEM_externval(m.MEM_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})

;; 7-module.watsup:147.1-147.67
def alloc_module : (store, module, externval*) -> (store, moduleinst)
  ;; 7-module.watsup:149.1-163.56
  def {da* : dataaddr*, data* : data*, ea* : elemaddr*, elem* : elem*, export* : export*, externval* : externval*, f : frame, fa* : funcaddr*, func* : func*, ga* : globaladdr*, global* : global*, import* : import*, m_ex : moduleinst, m_im : moduleinst, m_init : moduleinst, m_res : moduleinst, ma* : memaddr*, mem* : mem*, module : module, s : store, s_data : store, s_elem : store, s_func : store, s_global : store, s_mem : store, s_res : store, s_table : store, start? : start?, ta* : tableaddr*, table* : table*, xi* : exportinst*} alloc_module(s, module, externval*{externval}) = (s_res, m_res)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (m_init = {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (m_im = $alloc_import(m_init, import*{import}, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m_im})
    -- if ((s_func, fa*{fa}) = $alloc_func(`%;%`(s, f), func*{func}))
    -- if ((s_global, ga*{ga}) = $alloc_global(`%;%`(s_func, f), global*{global}))
    -- if ((s_table, ta*{ta}) = $alloc_table(`%;%`(s_global, f), table*{table}))
    -- if ((s_mem, ma*{ma}) = $alloc_mem(`%;%`(s_table, f), mem*{mem}))
    -- if ((s_elem, ea*{ea}) = $alloc_elem(`%;%`(s_mem, f), elem*{elem}))
    -- if ((s_data, da*{da}) = $alloc_data(`%;%`(s_elem, f), data*{data}))
    -- if (m_ex = m_im ++ {FUNC fa*{fa}, GLOBAL ga*{ga}, TABLE ta*{ta}, MEM ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT []})
    -- if (xi*{xi} = $alloc_export(m_ex, export)*{export})
    -- if (m_res = m_ex[EXPORT_moduleinst = xi*{xi}])
    -- if (s_res = $replace_moduleinst(s_data, fa*{fa}, m_res))

;; 7-module.watsup:166.1-166.41
rec {

;; 7-module.watsup:166.1-166.41
def run_elem : (state, elem*, idx) -> state
  ;; 7-module.watsup:168.1-168.41
  def {f : frame, i : nat, s : store} run_elem(`%;%`(s, f), [], i) = `%;%`(s, f)
  ;; 7-module.watsup:170.1-172.59
  def {elem : elem, elem'* : elem*, expr* : expr*, f : frame, f_res : frame, i : nat, reftype : reftype, s : store, s_res : store} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?()))
    -- if ($run_elem(`%;%`(s, f), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:174.1-179.67
  def {elem : elem, elem'* : elem*, elemmode : elemmode, expr* : expr*, f : frame, f_new : frame, f_res : frame, i : nat, instr* : instr*, n : n, reftype : reftype, s : store, s_new : store, s_res : store, x : idx} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?(elemmode)))
    -- if (n = |expr*{expr}|)
    -- if (elemmode = TABLE_elemmode(x, instr*{instr}))
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr} :: [CONST_admininstr(I32_numtype, 0) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, i) ELEM.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_elem(`%;%`(s_new, f_new), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:181.1-185.67
  def {elem : elem, elem'* : elem*, elemmode : elemmode, expr* : expr*, f : frame, f_new : frame, f_res : frame, i : nat, reftype : reftype, s : store, s_new : store, s_res : store} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?(elemmode)))
    -- if (elemmode = DECLARE_elemmode)
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), [ELEM.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_elem(`%;%`(s_new, f_new), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
}

;; 7-module.watsup:188.1-188.41
rec {

;; 7-module.watsup:188.1-188.41
def run_data : (state, data*, idx) -> state
  ;; 7-module.watsup:190.1-190.41
  def {f : frame, i : nat, s : store} run_data(`%;%`(s, f), [], i) = `%;%`(s, f)
  ;; 7-module.watsup:192.1-194.59
  def {byte* : byte*, data : data, data'* : data*, f : frame, f_res : frame, i : nat, s : store, s_res : store} run_data(`%;%`(s, f), [data] :: data'*{data'}, i) = `%;%`(s_res, f_res)
    -- if (data = `DATA%*%?`(byte*{byte}, ?()))
    -- if ($run_data(`%;%`(s, f), data'*{data'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:196.1-201.67
  def {byte* : byte*, data : data, data'* : data*, datamode : datamode, f : frame, f_new : frame, f_res : frame, i : nat, instr* : instr*, n : n, s : store, s_new : store, s_res : store} run_data(`%;%`(s, f), [data] :: data'*{data'}, i) = `%;%`(s_res, f_res)
    -- if (data = `DATA%*%?`(byte*{byte}, ?(datamode)))
    -- if (n = |byte*{byte}|)
    -- if (datamode = MEMORY_datamode(0, instr*{instr}))
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr} :: [CONST_admininstr(I32_numtype, 0) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(i) DATA.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_data(`%;%`(s_new, f_new), data'*{data'}, (i + 1)) = `%;%`(s_res, f_res))
}

;; 7-module.watsup:204.1-204.68
def instantiation : (store, module, externval*) -> (store, moduleinst)
  ;; 7-module.watsup:206.1-211.61
  def {data* : data*, elem* : elem*, export* : export*, externval* : externval*, f : frame, f_elem : frame, f_res : frame, func* : func*, global* : global*, import* : import*, m : moduleinst, mem* : mem*, module : module, s : store, s_alloc : store, s_elem : store, s_res : store, table* : table*} instantiation(s, module, externval*{externval}) = (s_res, m)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, ?(), export*{export}))
    -- if ((s_alloc, m) = $alloc_module(s, module, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m})
    -- if ($run_elem(`%;%`(s_alloc, f), elem*{elem}, 0) = `%;%`(s_elem, f_elem))
    -- if ($run_data(`%;%`(s_elem, f_elem), data*{data}, 0) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:213.1-220.62
  def {data* : data*, elem* : elem*, export* : export*, externval* : externval*, f : frame, f_data : frame, f_elem : frame, f_res : frame, func* : func*, global* : global*, import* : import*, m : moduleinst, mem* : mem*, module : module, s : store, s_alloc : store, s_data : store, s_elem : store, s_res : store, start : start, table* : table*, x : idx} instantiation(s, module, externval*{externval}) = (s_res, m)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, ?(start), export*{export}))
    -- if ((s_alloc, m) = $alloc_module(s, module, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m})
    -- if ($run_elem(`%;%`(s_alloc, f), elem*{elem}, 0) = `%;%`(s_elem, f_elem))
    -- if ($run_data(`%;%`(s_elem, f_elem), data*{data}, 0) = `%;%`(s_data, f_data))
    -- if (start = START(x))
    -- Step: `%~>%`(`%;%*`(`%;%`(s_data, f_data), [CALL_admininstr(x)]), `%;%*`(`%;%`(s_res, f_res), []))

;; 7-module.watsup:223.1-223.55
def invocation : (store, funcaddr, val*) -> (store, val*)
  ;; 7-module.watsup:225.1-232.55
  def {expr : expr, f : frame, f' : frame, fa : funcaddr, functype : functype, m : moduleinst, s : store, s' : store, val* : val*, val'* : val*, valtype* : valtype*, valtype'* : valtype*} invocation(s, fa, val*{val}) = (s', val'*{val'})
    -- if (m = {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE m})
    -- if ($funcinst(`%;%`(s, f))[fa].CODE_funcinst = `FUNC%%*%`(functype, valtype*{valtype}, expr))
    -- if (functype = `%->%`(valtype*{valtype}, valtype'*{valtype'}))
    -- if (|val*{val}| = |valtype*{valtype}|)
    -- if (|val'*{val'}| = |valtype'*{valtype'}|)
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_val(val)*{val} :: [CALL_ADDR_admininstr(fa)]), `%;%*`(`%;%`(s', f'), $admininstr_val(val')*{val'}))

== IL Validation...
== Running pass sideconditions

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:9.1-9.37
syntax name = text

;; 1-syntax.watsup:14.1-14.36
syntax byte = nat

;; 1-syntax.watsup:15.1-15.45
syntax u32 = nat

;; 1-syntax.watsup:22.1-22.36
syntax idx = nat

;; 1-syntax.watsup:23.1-23.49
syntax funcidx = idx

;; 1-syntax.watsup:24.1-24.49
syntax globalidx = idx

;; 1-syntax.watsup:25.1-25.47
syntax tableidx = idx

;; 1-syntax.watsup:26.1-26.46
syntax memidx = idx

;; 1-syntax.watsup:27.1-27.45
syntax elemidx = idx

;; 1-syntax.watsup:28.1-28.45
syntax dataidx = idx

;; 1-syntax.watsup:29.1-29.47
syntax labelidx = idx

;; 1-syntax.watsup:30.1-30.47
syntax localidx = idx

;; 1-syntax.watsup:39.1-40.22
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:41.1-42.5
syntax vectype =
  | V128

;; 1-syntax.watsup:43.1-44.20
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:45.1-46.34
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

;; 1-syntax.watsup:48.1-48.39
syntax in =
  | I32
  | I64

def numtype_in : in -> numtype
  def numtype_in(I32_in) = I32_numtype
  def numtype_in(I64_in) = I64_numtype

def valtype_in : in -> valtype
  def valtype_in(I32_in) = I32_valtype
  def valtype_in(I64_in) = I64_valtype

;; 1-syntax.watsup:49.1-49.39
syntax fn =
  | F32
  | F64

def numtype_fn : fn -> numtype
  def numtype_fn(F32_fn) = F32_numtype
  def numtype_fn(F64_fn) = F64_numtype

def valtype_fn : fn -> valtype
  def valtype_fn(F32_fn) = F32_valtype
  def valtype_fn(F64_fn) = F64_valtype

;; 1-syntax.watsup:56.1-57.11
syntax resulttype = valtype*

;; 1-syntax.watsup:59.1-60.17
syntax limits = `[%..%?]`(u32, u32?)

;; 1-syntax.watsup:61.1-62.15
syntax globaltype = `MUT%?%`(()?, valtype)

;; 1-syntax.watsup:63.1-64.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:65.1-66.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:67.1-68.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:69.1-70.10
syntax elemtype = reftype

;; 1-syntax.watsup:71.1-72.5
syntax datatype = OK

;; 1-syntax.watsup:73.1-74.66
syntax externtype =
  | GLOBAL(globaltype)
  | FUNC(functype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:86.1-86.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:88.1-88.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:89.1-89.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:91.1-93.62
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

;; 1-syntax.watsup:94.1-94.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:96.1-96.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:97.1-97.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:99.1-100.108
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:101.1-101.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:103.1-103.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:104.1-104.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:105.1-105.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:106.1-106.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:107.1-107.39
syntax cvtop =
  | CONVERT
  | REINTERPRET

;; 1-syntax.watsup:117.1-117.23
syntax c_numtype = nat

;; 1-syntax.watsup:118.1-118.23
syntax c_vectype = nat

;; 1-syntax.watsup:121.1-121.52
syntax blocktype = functype

;; 1-syntax.watsup:156.1-177.80
rec {

;; 1-syntax.watsup:156.1-177.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
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
  | LOAD(numtype, (n, sx)?, u32, u32)
  | STORE(numtype, n?, u32, u32)
}

;; 1-syntax.watsup:179.1-180.9
syntax expr = instr*

;; 1-syntax.watsup:187.1-187.50
syntax elemmode =
  | TABLE(tableidx, expr)
  | DECLARE

;; 1-syntax.watsup:188.1-188.39
syntax datamode =
  | MEMORY(memidx, expr)

;; 1-syntax.watsup:190.1-191.30
syntax func = `FUNC%%*%`(functype, valtype*, expr)

;; 1-syntax.watsup:192.1-193.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:194.1-195.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:196.1-197.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:198.1-199.31
syntax elem = `ELEM%%*%?`(reftype, expr*, elemmode?)

;; 1-syntax.watsup:200.1-201.23
syntax data = `DATA%*%?`(byte*, datamode?)

;; 1-syntax.watsup:202.1-203.16
syntax start = START(funcidx)

;; 1-syntax.watsup:205.1-206.62
syntax externuse =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:207.1-208.24
syntax export = EXPORT(name, externuse)

;; 1-syntax.watsup:209.1-210.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:212.1-213.70
syntax module = `MODULE%*%*%*%*%*%*%*%?%*`(import*, func*, global*, table*, mem*, elem*, data*, start?, export*)

;; 2-aux.watsup:3.1-3.14
def Ki : nat
  ;; 2-aux.watsup:4.1-4.15
  def Ki = 1024

;; 2-aux.watsup:9.1-9.25
rec {

;; 2-aux.watsup:9.1-9.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:10.1-10.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:11.1-11.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:12.1-12.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:19.1-19.55
def size : valtype -> nat?
  ;; 2-aux.watsup:20.1-20.20
  def size(I32_valtype) = ?(32)
  ;; 2-aux.watsup:21.1-21.20
  def size(I64_valtype) = ?(64)
  ;; 2-aux.watsup:22.1-22.20
  def size(F32_valtype) = ?(32)
  ;; 2-aux.watsup:23.1-23.20
  def size(F64_valtype) = ?(64)
  ;; 2-aux.watsup:24.1-24.22
  def size(V128_valtype) = ?(128)
  def {x : valtype} size(x) = ?()

;; 2-aux.watsup:29.1-29.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:30.1-30.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:32.1-32.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:33.1-33.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:35.1-44.39
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

;; 3-typing.watsup:3.1-6.60
syntax context = {FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:14.1-14.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:22.1-24.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%?]`(n_1, ?(n_2)), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:15.1-15.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:26.1-27.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:16.1-16.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:29.1-30.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:17.1-17.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:32.1-34.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:18.1-18.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:36.1-38.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:19.1-19.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:41.1-43.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:45.1-47.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:49.1-51.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:53.1-55.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:61.1-61.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:64.1-65.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:67.1-68.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:62.1-62.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:70.1-72.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- if (|t_1*{t_1}| = |t_2*{t_2}|)
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:75.1-75.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:83.1-86.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%?]`(n_11, ?(n_12)), `[%..%?]`(n_21, ?(n_22)))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:76.1-76.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:88.1-89.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:77.1-77.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:91.1-92.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:78.1-78.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:94.1-96.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:79.1-79.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:98.1-100.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:80.1-80.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:103.1-105.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:107.1-109.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:111.1-113.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:115.1-117.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:172.1-172.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:174.1-176.29
  rule _ {C : context, ft : functype}:
    `%|-%:%`(C, ft, ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:123.1-124.67
rec {

;; 3-typing.watsup:123.1-123.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:153.1-154.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:156.1-157.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:159.1-160.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:163.1-164.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?(t)), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:166.1-169.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = $valtype_numtype(numtype)) \/ (t' = $valtype_vectype(vectype)))

  ;; 3-typing.watsup:178.1-181.57
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:183.1-186.57
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1]*{t_1}, RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:188.1-192.59
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:195.1-197.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (l < |C.LABEL_context|)
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:199.1-201.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (l < |C.LABEL_context|)
    -- if (C.LABEL_context[l] = t*{t})

  ;; 3-typing.watsup:203.1-206.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (if (l < |C.LABEL_context|))*{l}
    -- if (l' < |C.LABEL_context|)
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:208.1-210.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (C.RETURN_context = ?(t*{t}))

  ;; 3-typing.watsup:212.1-214.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:216.1-219.26
  rule call_indirect {C : context, ft : functype, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, ft), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, FUNCREF_reftype))
    -- if (ft = `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:222.1-223.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:225.1-226.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:228.1-229.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:231.1-232.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([$valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:234.1-235.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:238.1-240.23
  rule extend {C : context, n : n, nt : numtype, o0 : nat}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (n <= o0)

  ;; 3-typing.watsup:242.1-245.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([$valtype_numtype(nt_2)], [$valtype_numtype(nt_1)]))
    -- if ($size($valtype_numtype(nt_1)) = ?(o0))
    -- if ($size($valtype_numtype(nt_2)) = ?(o1))
    -- if (nt_1 =/= nt_2)
    -- if (o0 = o1)

  ;; 3-typing.watsup:247.1-250.52
  rule convert-i {C : context, in_1 : in, in_2 : in, sx? : sx?, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr($numtype_in(in_1), CONVERT_cvtop, $numtype_in(in_2), sx?{sx}), `%->%`([$valtype_in(in_2)], [$valtype_in(in_1)]))
    -- if ($size($valtype_in(in_1)) = ?(o0))
    -- if ($size($valtype_in(in_2)) = ?(o1))
    -- if (in_1 =/= in_2)
    -- if ((sx?{sx} = ?()) <=> (o0 > o1))

  ;; 3-typing.watsup:252.1-254.22
  rule convert-f {C : context, fn_1 : fn, fn_2 : fn}:
    `%|-%:%`(C, CVTOP_instr($numtype_fn(fn_1), CONVERT_cvtop, $numtype_fn(fn_2), ?()), `%->%`([$valtype_fn(fn_2)], [$valtype_fn(fn_1)]))
    -- if (fn_1 =/= fn_2)

  ;; 3-typing.watsup:257.1-258.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [$valtype_reftype(rt)]))

  ;; 3-typing.watsup:260.1-262.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:264.1-265.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([$valtype_reftype(rt)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-270.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (x < |C.LOCAL_context|)
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:272.1-274.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (x < |C.LOCAL_context|)
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:276.1-278.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (x < |C.LOCAL_context|)
    -- if (C.LOCAL_context[x] = t)

  ;; 3-typing.watsup:281.1-283.29
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = `MUT%?%`(()?{}, t))

  ;; 3-typing.watsup:285.1-287.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(()), t))

  ;; 3-typing.watsup:290.1-292.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [$valtype_reftype(rt)]))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:294.1-296.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype $valtype_reftype(rt)], []))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:298.1-300.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:302.1-304.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([$valtype_reftype(rt) I32_valtype], [I32_valtype]))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:306.1-308.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype $valtype_reftype(rt) I32_valtype], []))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))

  ;; 3-typing.watsup:310.1-313.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (x_1 < |C.TABLE_context|)
    -- if (x_2 < |C.TABLE_context|)
    -- if (C.TABLE_context[x_1] = `%%`(lim_1, rt))
    -- if (C.TABLE_context[x_2] = `%%`(lim_2, rt))

  ;; 3-typing.watsup:315.1-318.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (x_1 < |C.TABLE_context|)
    -- if (x_2 < |C.ELEM_context|)
    -- if (C.TABLE_context[x_1] = `%%`(lim, rt))
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:320.1-322.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (x < |C.ELEM_context|)
    -- if (C.ELEM_context[x] = rt)

  ;; 3-typing.watsup:325.1-327.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:329.1-331.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:333.1-335.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:337.1-339.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)

  ;; 3-typing.watsup:341.1-344.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- if (x < |C.DATA_context|)
    -- if (C.MEM_context[0] = mt)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:346.1-348.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (x < |C.DATA_context|)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:350.1-355.32
  rule load {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, n_A, n_O), `%->%`([I32_valtype], [$valtype_numtype(nt)]))
    -- if (0 < |C.MEM_context|)
    -- if ((n?{n} = ?()) <=> (o1?{o1} = ?()))
    -- if ((n?{n} = ?()) <=> (sx?{sx} = ?()))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- (if ($size($valtype_numtype(nt)) = ?(o1)))?{o1}
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_in(in)))

  ;; 3-typing.watsup:357.1-362.32
  rule store {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, n_A, n_O), `%->%`([I32_valtype $valtype_numtype(nt)], []))
    -- if (0 < |C.MEM_context|)
    -- if ((n?{n} = ?()) <=> (o1?{o1} = ?()))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- (if ($size($valtype_numtype(nt)) = ?(o1)))?{o1}
    -- if (C.MEM_context[0] = mt)
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_in(in)))

;; 3-typing.watsup:124.1-124.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:133.1-134.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:136.1-139.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:141.1-146.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:148.1-150.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:125.1-125.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:128.1-130.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:367.1-367.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:371.1-372.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:374.1-375.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:377.1-378.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:380.1-382.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(), t))

;; 3-typing.watsup:368.1-368.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:385.1-386.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:369.1-369.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:389.1-392.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:397.1-397.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:408.1-412.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, `FUNC%%*%`(ft, t*{t}, expr), ft)
    -- if (ft = `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Functype_ok: `|-%:OK`(ft)
    -- Expr_ok: `%|-%:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:398.1-398.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:414.1-418.40
  rule _ {C : context, expr : expr, gt : globaltype, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- if (gt = `MUT%?%`(()?{}, t))
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:399.1-399.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:420.1-422.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:400.1-400.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:424.1-426.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:403.1-403.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:437.1-440.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE_elemmode(x, expr), rt)
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = `%%`(lim, rt))
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

  ;; 3-typing.watsup:442.1-443.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:401.1-401.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:428.1-431.40
  rule _ {C : context, elemmode? : elemmode?, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%?`(rt, expr*{expr}, elemmode?{elemmode}), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [$valtype_reftype(rt)]))*{expr}
    -- (Elemmode_ok: `%|-%:%`(C, elemmode, rt))?{elemmode}

;; 3-typing.watsup:404.1-404.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:445.1-448.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, MEMORY_datamode(0, expr))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

;; 3-typing.watsup:402.1-402.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:433.1-435.40
  rule _ {C : context, b* : byte*, datamode? : datamode?}:
    `%|-%:OK`(C, `DATA%*%?`(b*{b}, datamode?{datamode}))
    -- (Datamode_ok: `%|-%:OK`(C, datamode))?{datamode}

;; 3-typing.watsup:405.1-405.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:450.1-452.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:455.1-455.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:459.1-461.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:457.1-457.83
relation Externuse_ok: `%|-%:%`(context, externuse, externtype)
  ;; 3-typing.watsup:467.1-469.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externuse(x), FUNC_externtype(ft))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = ft)

  ;; 3-typing.watsup:471.1-473.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externuse(x), GLOBAL_externtype(gt))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = gt)

  ;; 3-typing.watsup:475.1-477.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externuse(x), TABLE_externtype(tt))
    -- if (x < |C.TABLE_context|)
    -- if (C.TABLE_context[x] = tt)

  ;; 3-typing.watsup:479.1-481.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externuse(x), MEM_externtype(mt))
    -- if (x < |C.MEM_context|)
    -- if (C.MEM_context[x] = mt)

;; 3-typing.watsup:456.1-456.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:463.1-465.39
  rule _ {C : context, externuse : externuse, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externuse), xt)
    -- Externuse_ok: `%|-%:%`(C, externuse, xt)

;; 3-typing.watsup:484.1-484.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:486.1-500.16
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (|ft*{ft}| = |func*{func}|)
    -- if (|global*{global}| = |gt*{gt}|)
    -- if (|table*{table}| = |tt*{tt}|)
    -- if (|mem*{mem}| = |mt*{mt}|)
    -- if (|elem*{elem}| = |rt*{rt}|)
    -- if (C = {FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

;; 4-runtime.watsup:3.1-3.39
syntax addr = nat

;; 4-runtime.watsup:4.1-4.53
syntax funcaddr = addr

;; 4-runtime.watsup:5.1-5.53
syntax globaladdr = addr

;; 4-runtime.watsup:6.1-6.51
syntax tableaddr = addr

;; 4-runtime.watsup:7.1-7.50
syntax memaddr = addr

;; 4-runtime.watsup:8.1-8.49
syntax elemaddr = addr

;; 4-runtime.watsup:9.1-9.49
syntax dataaddr = addr

;; 4-runtime.watsup:10.1-10.51
syntax labeladdr = addr

;; 4-runtime.watsup:11.1-11.49
syntax hostaddr = addr

;; 4-runtime.watsup:24.1-25.24
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:26.1-27.67
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:28.1-29.10
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:31.1-32.18
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:38.1-39.66
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:44.1-44.44
def default_ : valtype -> val?
  ;; 4-runtime.watsup:45.1-45.35
  def default_(I32_valtype) = ?(CONST_val(I32_numtype, 0))
  ;; 4-runtime.watsup:46.1-46.35
  def default_(I64_valtype) = ?(CONST_val(I64_numtype, 0))
  ;; 4-runtime.watsup:47.1-47.35
  def default_(F32_valtype) = ?(CONST_val(F32_numtype, 0))
  ;; 4-runtime.watsup:48.1-48.35
  def default_(F64_valtype) = ?(CONST_val(F64_numtype, 0))
  ;; 4-runtime.watsup:49.1-49.44
  def default_(FUNCREF_valtype) = ?(REF.NULL_val(FUNCREF_reftype))
  ;; 4-runtime.watsup:50.1-50.48
  def default_(EXTERNREF_valtype) = ?(REF.NULL_val(EXTERNREF_reftype))
  def {x : valtype} default_(x) = ?()

;; 4-runtime.watsup:72.1-74.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:84.1-91.25
syntax moduleinst = {FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:55.1-57.16
syntax funcinst = {MODULE moduleinst, CODE func}

;; 4-runtime.watsup:58.1-60.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:61.1-63.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:64.1-66.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:67.1-69.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:70.1-71.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:76.1-82.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:93.1-95.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:96.1-96.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:180.1-187.5
rec {

;; 4-runtime.watsup:180.1-187.5
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
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
  | LOAD(numtype, (n, sx)?, u32, u32)
  | STORE(numtype, n?, u32, u32)
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
  def {x : valtype?} admininstr_instr(SELECT_instr(x)) = SELECT_admininstr(x)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(BLOCK_instr(x0, x1)) = BLOCK_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(LOOP_instr(x0, x1)) = LOOP_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*, x2 : instr*} admininstr_instr(IF_instr(x0, x1, x2)) = IF_admininstr(x0, x1, x2)
  def {x : labelidx} admininstr_instr(BR_instr(x)) = BR_admininstr(x)
  def {x : labelidx} admininstr_instr(BR_IF_instr(x)) = BR_IF_admininstr(x)
  def {x0 : labelidx*, x1 : labelidx} admininstr_instr(BR_TABLE_instr(x0, x1)) = BR_TABLE_admininstr(x0, x1)
  def {x : funcidx} admininstr_instr(CALL_instr(x)) = CALL_admininstr(x)
  def {x0 : tableidx, x1 : functype} admininstr_instr(CALL_INDIRECT_instr(x0, x1)) = CALL_INDIRECT_admininstr(x0, x1)
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
  def {x0 : numtype, x1 : (n, sx)?, x2 : u32, x3 : u32} admininstr_instr(LOAD_instr(x0, x1, x2, x3)) = LOAD_admininstr(x0, x1, x2, x3)
  def {x0 : numtype, x1 : n?, x2 : u32, x3 : u32} admininstr_instr(STORE_instr(x0, x1, x2, x3)) = STORE_admininstr(x0, x1, x2, x3)

def admininstr_ref : ref -> admininstr
  def {x : reftype} admininstr_ref(REF.NULL_ref(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_ref(REF.FUNC_ADDR_ref(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_ref(REF.HOST_ADDR_ref(x)) = REF.HOST_ADDR_admininstr(x)

def admininstr_val : val -> admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_val(CONST_val(x0, x1)) = CONST_admininstr(x0, x1)
  def {x : reftype} admininstr_val(REF.NULL_val(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_val(REF.FUNC_ADDR_val(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_val(REF.HOST_ADDR_val(x)) = REF.HOST_ADDR_admininstr(x)

;; 4-runtime.watsup:97.1-97.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:115.1-115.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:116.1-116.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:118.1-118.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:125.1-125.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:119.1-119.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:126.1-126.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:120.1-120.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:127.1-127.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:121.1-121.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:128.1-128.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:122.1-122.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:129.1-129.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:123.1-123.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:130.1-130.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:132.1-132.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:140.1-140.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:133.1-133.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:141.1-141.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:134.1-134.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:142.1-142.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:135.1-135.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:143.1-143.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:136.1-136.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:144.1-144.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:137.1-137.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:145.1-145.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:138.1-138.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:146.1-146.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:149.1-149.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:158.1-158.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:150.1-150.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:159.1-159.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:151.1-151.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:160.1-160.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:152.1-152.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:161.1-161.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:153.1-153.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:162.1-162.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:154.1-154.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:163.1-163.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:155.1-155.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:164.1-164.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:156.1-156.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:165.1-165.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:167.1-167.49
def grow_table : (tableinst, nat, ref) -> tableinst
  ;; 4-runtime.watsup:169.1-172.57
  def {i : nat, i' : nat, j? : nat?, n : n, r : ref, r'* : ref*, reftype : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ti'
    -- if (ti = {TYPE `%%`(`[%..%?]`(i, j?{j}), reftype), ELEM r'*{r'}})
    -- if (i' = (|r'*{r'}| + n))
    -- if (ti' = {TYPE `%%`(`[%..%?]`(i', j?{j}), reftype), ELEM r'*{r'} :: r^n{}})

;; 4-runtime.watsup:168.1-168.41
def grow_memory : (meminst, nat) -> meminst
  ;; 4-runtime.watsup:173.1-176.66
  def {b* : byte*, i : nat, i' : nat, j? : nat?, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = mi'
    -- if (mi = {TYPE `%I8`(`[%..%?]`(i, j?{j})), DATA b*{b}})
    -- if (i' = ((|b*{b}| / (64 * $Ki)) + n))
    -- if (mi' = {TYPE `%I8`(`[%..%?]`(i', j?{j})), DATA b*{b} :: 0^((n * 64) * $Ki){}})

;; 4-runtime.watsup:189.1-192.21
rec {

;; 4-runtime.watsup:189.1-192.21
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

;; 5-numerics.watsup:13.1-13.28
def bytes_ : (nat, c_numtype) -> byte*

;; 5-numerics.watsup:14.1-14.47
def inverse_of_bytes_ : (nat, byte*) -> c_numtype

;; 6-reduction.watsup:4.1-4.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:16.1-17.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:19.1-20.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:22.1-23.24
  rule drop {val : val}:
    `%*~>%*`([$admininstr_val(val) DROP_admininstr], [])

  ;; 6-reduction.watsup:26.1-28.16
  rule select-true {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [$admininstr_val(val_1)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:30.1-32.14
  rule select-false {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [$admininstr_val(val_2)])
    -- if (c = 0)

  ;; 6-reduction.watsup:35.1-37.28
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`($admininstr_val(val)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})], [LABEL__admininstr(n, [], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if (bt = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:39.1-41.28
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`($admininstr_val(val)^k{val} :: [LOOP_admininstr(bt, instr*{instr})], [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- if (bt = `%->%`(t_1^k{t_1}, t_2^n{t_2}))

  ;; 6-reduction.watsup:43.1-45.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:47.1-49.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:52.1-53.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, $admininstr_val(val)*{val})], $admininstr_val(val)*{val})

  ;; 6-reduction.watsup:57.1-58.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [BR_admininstr(0)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val} :: $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:60.1-61.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val)*{val} :: [BR_admininstr(l + 1)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:64.1-66.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:68.1-70.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:73.1-75.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:77.1-79.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:102.1-103.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val)^n{val})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:105.1-106.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:108.1-109.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, $admininstr_val(val)*{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:112.1-114.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- if ($unop(unop, nt, c_1) = [c])

  ;; 6-reduction.watsup:116.1-118.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:121.1-123.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- if ($binop(binop, nt, c_1, c_2) = [c])

  ;; 6-reduction.watsup:125.1-127.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:130.1-132.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $testop(testop, nt, c_1))

  ;; 6-reduction.watsup:134.1-136.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- if (c = $relop(relop, nt, c_1, c_2))

  ;; 6-reduction.watsup:139.1-140.70
  rule extend {c : c_numtype, n : n, nt : numtype, o0 : nat}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, o0, S_sx, c))])
    -- if ($size($valtype_numtype(nt)) = ?(o0))

  ;; 6-reduction.watsup:143.1-145.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [c])

  ;; 6-reduction.watsup:147.1-149.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:156.1-158.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- if (val = REF.NULL_val(rt))

  ;; 6-reduction.watsup:160.1-162.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:171.1-172.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([$admininstr_val(val) LOCAL.TEE_admininstr(x)], [$admininstr_val(val) $admininstr_val(val) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:5.1-5.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:82.1-83.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])
    -- if (x < |$funcaddr(z)|)

  ;; 6-reduction.watsup:85.1-89.17
  rule call_indirect-call {a : addr, ft : functype, ft' : functype, i : nat, instr* : instr*, t* : valtype*, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [CALL_ADDR_admininstr(a)])
    -- if (i < |$table(z, x).ELEM_tableinst|)
    -- if (a < |$funcinst(z)|)
    -- if ($table(z, x).ELEM_tableinst[i] = REF.FUNC_ADDR_ref(a))
    -- if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(ft', t*{t}, instr*{instr}))
    -- if (ft = ft')

  ;; 6-reduction.watsup:91.1-93.15
  rule call_indirect-trap {ft : functype, i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:95.1-99.52
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, m : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state, o0* : val*}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], $admininstr_instr(instr)*{instr})])])
    -- if (|t*{t}| = |o0*{o0}|)
    -- if (a < |$funcinst(z)|)
    -- (if ($default_(t) = ?(o0)))*{t o0}
    -- if ($funcinst(z)[a] = {MODULE m, CODE func})
    -- if (func = `FUNC%%*%`(`%->%`(t_1^k{t_1}, t_2^n{t_2}), t*{t}, instr*{instr}))
    -- if (f = {LOCAL val^k{val} :: o0*{o0}, MODULE m})

  ;; 6-reduction.watsup:152.1-153.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])
    -- if (x < |$funcaddr(z)|)

  ;; 6-reduction.watsup:165.1-166.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [$admininstr_val($local(z, x))])

  ;; 6-reduction.watsup:175.1-176.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [$admininstr_val($global(z, x).VALUE_globalinst)])

  ;; 6-reduction.watsup:182.1-184.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:186.1-188.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [$admininstr_ref($table(z, x).ELEM_tableinst[i])])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:199.1-201.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- if (|$table(z, x).ELEM_tableinst| = n)

  ;; 6-reduction.watsup:214.1-216.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:218.1-221.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:223.1-227.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:230.1-232.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:234.1-237.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:239.1-244.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:246.1-250.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:253.1-255.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:257.1-260.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:262.1-266.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) $admininstr_ref($elem(z, y).ELEM_eleminst[i]) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- if (i < |$elem(z, y).ELEM_eleminst|)
    -- otherwise

  ;; 6-reduction.watsup:273.1-275.53
  rule load-num-trap {i : nat, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), n_A, n_O)]), [TRAP_admininstr])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (((i + n_O) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:277.1-279.71
  rule load-num-val {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat, o1 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), n_A, n_O)]), [CONST_admininstr(nt, c)])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if ($size($valtype_numtype(nt)) = ?(o1))
    -- if ($bytes_(o0, c) = $mem(z, 0).DATA_meminst[(i + n_O) : (o1 / 8)])

  ;; 6-reduction.watsup:281.1-283.45
  rule load-pack-trap {i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), n_A, n_O)]), [TRAP_admininstr])
    -- if (((i + n_O) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:285.1-287.55
  rule load-pack-val {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), n_A, n_O)]), [CONST_admininstr(nt, $ext(n, o0, sx, c))])
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if ($bytes_(n, c) = $mem(z, 0).DATA_meminst[(i + n_O) : (n / 8)])

  ;; 6-reduction.watsup:307.1-309.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- if (((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:322.1-324.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:326.1-329.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:331.1-335.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:338.1-340.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:342.1-345.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:347.1-352.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), 0, 0) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:354.1-358.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), 0, 0) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:361.1-363.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:365.1-368.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:370.1-374.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- if (i < |$data(z, x).DATA_datainst|)
    -- otherwise

;; 6-reduction.watsup:3.1-3.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:7.1-9.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_pure: `%*~>%*`($admininstr_instr(instr)*{instr}, $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:11.1-13.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, $admininstr_instr(instr)*{instr}), $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:168.1-169.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:178.1-179.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:190.1-192.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:194.1-196.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:204.1-208.36
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, ti' : tableinst, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti'), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- if ($table(z, x) = ti)
    -- if ($grow_table(ti, n, ref) = ti')
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)

  ;; 6-reduction.watsup:210.1-211.64
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 6-reduction.watsup:269.1-270.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:290.1-292.53
  rule store-num-trap {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (((i + n_O) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:294.1-296.35
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat, o1 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), n_A, n_O)]), `%;%*`($with_mem(z, 0, (i + n_O), (o0 / 8), b*{b}), []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if ($size($valtype_numtype(nt)) = ?(o1))
    -- if (b*{b} = $bytes_(o1, c))

  ;; 6-reduction.watsup:298.1-300.45
  rule store-pack-trap {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + n_O) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:302.1-304.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), n_A, n_O)]), `%;%*`($with_mem(z, 0, (i + n_O), (n / 8), b*{b}), []))
    -- if ($size($valtype_numtype(nt)) = ?(o0))
    -- if (b*{b} = $bytes_(n, $wrap_((o0, n), c)))

  ;; 6-reduction.watsup:312.1-316.34
  rule memory.grow-succeed {mi : meminst, mi' : meminst, n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi'), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- if ($mem(z, 0) = mi)
    -- if ($grow_memory(mi, n) = mi')
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)

  ;; 6-reduction.watsup:318.1-319.59
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 6-reduction.watsup:377.1-378.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:3.1-3.64
rec {

;; 7-module.watsup:3.1-3.64
def alloc_import : (moduleinst, import*, externval*) -> moduleinst
  ;; 7-module.watsup:5.1-5.43
  def {m : moduleinst} alloc_import(m, [], []) = m
  ;; 7-module.watsup:7.1-12.60
  def {externtype : externtype, externval : externval, externval'* : externval*, fa : funcaddr, functype : functype, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = FUNC_externtype(functype))
    -- if (externval = FUNC_externval(fa))
    -- if (m_new = m[FUNC_moduleinst =.. [fa]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:14.1-19.60
  def {externtype : externtype, externval : externval, externval'* : externval*, ga : globaladdr, globaltype : globaltype, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = GLOBAL_externtype(globaltype))
    -- if (externval = GLOBAL_externval(ga))
    -- if (m_new = m[GLOBAL_moduleinst =.. [ga]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:21.1-26.60
  def {externtype : externtype, externval : externval, externval'* : externval*, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name, ta : tableaddr, tabletype : tabletype} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = TABLE_externtype(tabletype))
    -- if (externval = TABLE_externval(ta))
    -- if (m_new = m[TABLE_moduleinst =.. [ta]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
  ;; 7-module.watsup:28.1-33.60
  def {externtype : externtype, externval : externval, externval'* : externval*, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, ma : memaddr, memtype : memtype, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- if (import = IMPORT(name, name', externtype))
    -- if (externtype = MEM_externtype(memtype))
    -- if (externval = MEM_externval(ma))
    -- if (m_new = m[MEM_moduleinst =.. [ma]])
    -- if (m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'}))
}

;; 7-module.watsup:36.1-36.51
rec {

;; 7-module.watsup:36.1-36.51
def alloc_func : (state, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:38.1-38.48
  def {f : frame, s : store} alloc_func(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:40.1-44.56
  def {f : frame, fa : funcaddr, fa'* : funcaddr*, fi : funcinst, func : func, func'* : func*, s : store, s_new : store, s_res : store} alloc_func(`%;%`(s, f), [func] :: func'*{func'}) = (s_res, [fa] :: fa'*{fa'})
    -- if (fi = {MODULE f.MODULE_frame, CODE func})
    -- if (fa = |$funcinst(`%;%`(s, f))|)
    -- if (s_new = s[FUNC_store =.. [fi]])
    -- if ((s_res, fa'*{fa'}) = $alloc_func(`%;%`(s_new, f), func'*{func'}))
}

;; 7-module.watsup:47.1-47.57
rec {

;; 7-module.watsup:47.1-47.57
def alloc_global : (state, global*) -> (store, globaladdr*)
  ;; 7-module.watsup:49.1-49.50
  def {f : frame, s : store} alloc_global(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:51.1-57.60
  def {f : frame, ga : globaladdr, ga'* : globaladdr*, gi : globalinst, global : global, global'* : global*, globaltype : globaltype, instr* : instr*, s : store, s_new : store, s_res : store, val : val} alloc_global(`%;%`(s, f), [global] :: global'*{global'}) = (s_res, [ga] :: ga'*{ga'})
    -- if (global = GLOBAL(globaltype, instr*{instr}))
    -- Step_read: `%~>%*`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr}), [$admininstr_val(val)])
    -- if (gi = {TYPE globaltype, VALUE val})
    -- if (ga = |$globalinst(`%;%`(s, f))|)
    -- if (s_new = s[GLOBAL_store =.. [gi]])
    -- if ((s_res, ga'*{ga'}) = $alloc_global(`%;%`(s_new, f), global'*{global'}))
}

;; 7-module.watsup:60.1-60.54
rec {

;; 7-module.watsup:60.1-60.54
def alloc_table : (state, table*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.49
  def {f : frame, s : store} alloc_table(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:64.1-70.58
  def {f : frame, i : nat, j? : nat?, reftype : reftype, s : store, s_new : store, s_res : store, ta : tableaddr, ta'* : tableaddr*, table : table, table'* : table*, tabletype : tabletype, ti : tableinst} alloc_table(`%;%`(s, f), [table] :: table'*{table'}) = (s_res, [ta] :: ta'*{ta'})
    -- if (table = TABLE(tabletype))
    -- if (tabletype = `%%`(`[%..%?]`(i, j?{j}), reftype))
    -- if (ti = {TYPE tabletype, ELEM REF.NULL_ref(reftype)^i{}})
    -- if (ta = |$tableinst(`%;%`(s, f))|)
    -- if (s_new = s[TABLE_store =.. [ti]])
    -- if ((s_res, ta'*{ta'}) = $alloc_table(`%;%`(s_new, f), table'*{table'}))
}

;; 7-module.watsup:73.1-73.48
rec {

;; 7-module.watsup:73.1-73.48
def alloc_mem : (state, mem*) -> (store, memaddr*)
  ;; 7-module.watsup:75.1-75.47
  def {f : frame, s : store} alloc_mem(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:77.1-83.54
  def {f : frame, i : nat, j? : nat?, ma : memaddr, ma'* : memaddr*, mem : mem, mem'* : mem*, memtype : memtype, mi : meminst, s : store, s_new : store, s_res : store} alloc_mem(`%;%`(s, f), [mem] :: mem'*{mem'}) = (s_res, [ma] :: ma'*{ma'})
    -- if (mem = MEMORY(memtype))
    -- if (memtype = `%I8`(`[%..%?]`(i, j?{j})))
    -- if (mi = {TYPE memtype, DATA 0^((i * 64) * $Ki){}})
    -- if (ma = |$meminst(`%;%`(s, f))|)
    -- if (s_new = s[MEM_store =.. [mi]])
    -- if ((s_res, ma'*{ma'}) = $alloc_mem(`%;%`(s_new, f), mem'*{mem'}))
}

;; 7-module.watsup:86.1-86.51
rec {

;; 7-module.watsup:86.1-86.51
def alloc_elem : (state, elem*) -> (store, elemaddr*)
  ;; 7-module.watsup:88.1-88.48
  def {f : frame, s : store} alloc_elem(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:90.1-96.56
  def {ea : elemaddr, ea'* : elemaddr*, ei : eleminst, elem : elem, elem'* : elem*, elemmode? : elemmode?, f : frame, instr** : instr**, ref* : ref*, reftype : reftype, s : store, s_new : store, s_res : store} alloc_elem(`%;%`(s, f), [elem] :: elem'*{elem'}) = (s_res, [ea] :: ea'*{ea'})
    -- if (elem = `ELEM%%*%?`(reftype, instr*{instr}*{instr}, elemmode?{elemmode}))
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr}), [$admininstr_ref(ref)]))*{instr ref}
    -- if (ei = {TYPE reftype, ELEM ref*{ref}})
    -- if (ea = |$eleminst(`%;%`(s, f))|)
    -- if (s_new = s[ELEM_store =.. [ei]])
    -- if ((s_res, ea'*{ea'}) = $alloc_elem(`%;%`(s_new, f), elem'*{elem'}))
}

;; 7-module.watsup:99.1-99.51
rec {

;; 7-module.watsup:99.1-99.51
def alloc_data : (state, data*) -> (store, dataaddr*)
  ;; 7-module.watsup:101.1-101.48
  def {f : frame, s : store} alloc_data(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:103.1-108.56
  def {byte* : byte*, da : dataaddr, da'* : dataaddr*, data : data, data'* : data*, datamode? : datamode?, di : datainst, f : frame, s : store, s_new : store, s_res : store} alloc_data(`%;%`(s, f), [data] :: data'*{data'}) = (s_res, [da] :: da'*{da'})
    -- if (data = `DATA%*%?`(byte*{byte}, datamode?{datamode}))
    -- if (di = {DATA byte*{byte}})
    -- if (da = |$datainst(`%;%`(s, f))|)
    -- if (s_new = s[DATA_store =.. [di]])
    -- if ((s_res, da'*{da'}) = $alloc_data(`%;%`(s_new, f), data'*{data'}))
}

;; 7-module.watsup:111.1-111.62
rec {

;; 7-module.watsup:111.1-111.62
def replace_moduleinst : (store, funcaddr*, moduleinst) -> store
  ;; 7-module.watsup:113.1-113.43
  def {m : moduleinst, s : store} replace_moduleinst(s, [], m) = s
  ;; 7-module.watsup:115.1-117.52
  def {fa : funcaddr, fa'* : funcaddr*, m : moduleinst, s : store, s_new : store, s_res : store} replace_moduleinst(s, [fa] :: fa'*{fa'}, m) = s_res
    -- if (s_new = s[FUNC_store[fa].MODULE_funcinst = m])
    -- if (s_res = $replace_moduleinst(s_new, fa'*{fa'}, m))
}

;; 7-module.watsup:120.1-120.51
def alloc_export : (moduleinst, export) -> exportinst
  ;; 7-module.watsup:122.1-126.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = FUNC_externuse(x))
    -- if (externval = FUNC_externval(m.FUNC_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:128.1-132.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = GLOBAL_externuse(x))
    -- if (externval = GLOBAL_externval(m.GLOBAL_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:134.1-138.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = TABLE_externuse(x))
    -- if (externval = TABLE_externval(m.TABLE_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})
  ;; 7-module.watsup:140.1-144.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- if (export = EXPORT(name, externuse))
    -- if (externuse = MEM_externuse(x))
    -- if (externval = MEM_externval(m.MEM_moduleinst[x]))
    -- if (xi = {NAME name, VALUE externval})

;; 7-module.watsup:147.1-147.67
def alloc_module : (store, module, externval*) -> (store, moduleinst)
  ;; 7-module.watsup:149.1-163.56
  def {da* : dataaddr*, data* : data*, ea* : elemaddr*, elem* : elem*, export* : export*, externval* : externval*, f : frame, fa* : funcaddr*, func* : func*, ga* : globaladdr*, global* : global*, import* : import*, m_ex : moduleinst, m_im : moduleinst, m_init : moduleinst, m_res : moduleinst, ma* : memaddr*, mem* : mem*, module : module, s : store, s_data : store, s_elem : store, s_func : store, s_global : store, s_mem : store, s_res : store, s_table : store, start? : start?, ta* : tableaddr*, table* : table*, xi* : exportinst*} alloc_module(s, module, externval*{externval}) = (s_res, m_res)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}))
    -- if (m_init = {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (m_im = $alloc_import(m_init, import*{import}, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m_im})
    -- if ((s_func, fa*{fa}) = $alloc_func(`%;%`(s, f), func*{func}))
    -- if ((s_global, ga*{ga}) = $alloc_global(`%;%`(s_func, f), global*{global}))
    -- if ((s_table, ta*{ta}) = $alloc_table(`%;%`(s_global, f), table*{table}))
    -- if ((s_mem, ma*{ma}) = $alloc_mem(`%;%`(s_table, f), mem*{mem}))
    -- if ((s_elem, ea*{ea}) = $alloc_elem(`%;%`(s_mem, f), elem*{elem}))
    -- if ((s_data, da*{da}) = $alloc_data(`%;%`(s_elem, f), data*{data}))
    -- if (m_ex = m_im ++ {FUNC fa*{fa}, GLOBAL ga*{ga}, TABLE ta*{ta}, MEM ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT []})
    -- if (xi*{xi} = $alloc_export(m_ex, export)*{export})
    -- if (m_res = m_ex[EXPORT_moduleinst = xi*{xi}])
    -- if (s_res = $replace_moduleinst(s_data, fa*{fa}, m_res))

;; 7-module.watsup:166.1-166.41
rec {

;; 7-module.watsup:166.1-166.41
def run_elem : (state, elem*, idx) -> state
  ;; 7-module.watsup:168.1-168.41
  def {f : frame, i : nat, s : store} run_elem(`%;%`(s, f), [], i) = `%;%`(s, f)
  ;; 7-module.watsup:170.1-172.59
  def {elem : elem, elem'* : elem*, expr* : expr*, f : frame, f_res : frame, i : nat, reftype : reftype, s : store, s_res : store} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?()))
    -- if ($run_elem(`%;%`(s, f), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:174.1-179.67
  def {elem : elem, elem'* : elem*, elemmode : elemmode, expr* : expr*, f : frame, f_new : frame, f_res : frame, i : nat, instr* : instr*, n : n, reftype : reftype, s : store, s_new : store, s_res : store, x : idx} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?(elemmode)))
    -- if (n = |expr*{expr}|)
    -- if (elemmode = TABLE_elemmode(x, instr*{instr}))
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr} :: [CONST_admininstr(I32_numtype, 0) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, i) ELEM.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_elem(`%;%`(s_new, f_new), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:181.1-185.67
  def {elem : elem, elem'* : elem*, elemmode : elemmode, expr* : expr*, f : frame, f_new : frame, f_res : frame, i : nat, reftype : reftype, s : store, s_new : store, s_res : store} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- if (elem = `ELEM%%*%?`(reftype, expr*{expr}, ?(elemmode)))
    -- if (elemmode = DECLARE_elemmode)
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), [ELEM.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_elem(`%;%`(s_new, f_new), elem'*{elem'}, (i + 1)) = `%;%`(s_res, f_res))
}

;; 7-module.watsup:188.1-188.41
rec {

;; 7-module.watsup:188.1-188.41
def run_data : (state, data*, idx) -> state
  ;; 7-module.watsup:190.1-190.41
  def {f : frame, i : nat, s : store} run_data(`%;%`(s, f), [], i) = `%;%`(s, f)
  ;; 7-module.watsup:192.1-194.59
  def {byte* : byte*, data : data, data'* : data*, f : frame, f_res : frame, i : nat, s : store, s_res : store} run_data(`%;%`(s, f), [data] :: data'*{data'}, i) = `%;%`(s_res, f_res)
    -- if (data = `DATA%*%?`(byte*{byte}, ?()))
    -- if ($run_data(`%;%`(s, f), data'*{data'}, (i + 1)) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:196.1-201.67
  def {byte* : byte*, data : data, data'* : data*, datamode : datamode, f : frame, f_new : frame, f_res : frame, i : nat, instr* : instr*, n : n, s : store, s_new : store, s_res : store} run_data(`%;%`(s, f), [data] :: data'*{data'}, i) = `%;%`(s_res, f_res)
    -- if (data = `DATA%*%?`(byte*{byte}, ?(datamode)))
    -- if (n = |byte*{byte}|)
    -- if (datamode = MEMORY_datamode(0, instr*{instr}))
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr} :: [CONST_admininstr(I32_numtype, 0) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(i) DATA.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- if ($run_data(`%;%`(s_new, f_new), data'*{data'}, (i + 1)) = `%;%`(s_res, f_res))
}

;; 7-module.watsup:204.1-204.68
def instantiation : (store, module, externval*) -> (store, moduleinst)
  ;; 7-module.watsup:206.1-211.61
  def {data* : data*, elem* : elem*, export* : export*, externval* : externval*, f : frame, f_elem : frame, f_res : frame, func* : func*, global* : global*, import* : import*, m : moduleinst, mem* : mem*, module : module, s : store, s_alloc : store, s_elem : store, s_res : store, table* : table*} instantiation(s, module, externval*{externval}) = (s_res, m)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, ?(), export*{export}))
    -- if ((s_alloc, m) = $alloc_module(s, module, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m})
    -- if ($run_elem(`%;%`(s_alloc, f), elem*{elem}, 0) = `%;%`(s_elem, f_elem))
    -- if ($run_data(`%;%`(s_elem, f_elem), data*{data}, 0) = `%;%`(s_res, f_res))
  ;; 7-module.watsup:213.1-220.62
  def {data* : data*, elem* : elem*, export* : export*, externval* : externval*, f : frame, f_data : frame, f_elem : frame, f_res : frame, func* : func*, global* : global*, import* : import*, m : moduleinst, mem* : mem*, module : module, s : store, s_alloc : store, s_data : store, s_elem : store, s_res : store, start : start, table* : table*, x : idx} instantiation(s, module, externval*{externval}) = (s_res, m)
    -- if (module = `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, ?(start), export*{export}))
    -- if ((s_alloc, m) = $alloc_module(s, module, externval*{externval}))
    -- if (f = {LOCAL [], MODULE m})
    -- if ($run_elem(`%;%`(s_alloc, f), elem*{elem}, 0) = `%;%`(s_elem, f_elem))
    -- if ($run_data(`%;%`(s_elem, f_elem), data*{data}, 0) = `%;%`(s_data, f_data))
    -- if (start = START(x))
    -- Step: `%~>%`(`%;%*`(`%;%`(s_data, f_data), [CALL_admininstr(x)]), `%;%*`(`%;%`(s_res, f_res), []))

;; 7-module.watsup:223.1-223.55
def invocation : (store, funcaddr, val*) -> (store, val*)
  ;; 7-module.watsup:225.1-232.55
  def {expr : expr, f : frame, f' : frame, fa : funcaddr, functype : functype, m : moduleinst, s : store, s' : store, val* : val*, val'* : val*, valtype* : valtype*, valtype'* : valtype*} invocation(s, fa, val*{val}) = (s', val'*{val'})
    -- if (m = {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []})
    -- if (f = {LOCAL [], MODULE m})
    -- if ($funcinst(`%;%`(s, f))[fa].CODE_funcinst = `FUNC%%*%`(functype, valtype*{valtype}, expr))
    -- if (functype = `%->%`(valtype*{valtype}, valtype'*{valtype'}))
    -- if (|val*{val}| = |valtype*{valtype}|)
    -- if (|val'*{val'}| = |valtype'*{valtype'}|)
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_val(val)*{val} :: [CALL_ADDR_admininstr(fa)]), `%;%*`(`%;%`(s', f'), $admininstr_val(val')*{val'}))

== IL Validation...
== Running pass animate
Animation failed:
  Valtype_sub: `|-%<:%`(t, t')
  if ((t' = $valtype_numtype(numtype)) \/ (t' = $valtype_vectype(vectype)))
Animation failed:
  (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
  Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])
Animation failed: if (C.TABLE_context[x_2] = `%%`(lim_2, rt))
Animation failed:
  if ((n?{n} = ?()) \/ (nt = $numtype_in(in)))
Animation failed:
  if ((n?{n} = ?()) \/ (nt = $numtype_in(in)))
Animation failed: if (functype = `%->%`(valtype*{valtype}, valtype'*{valtype'}))
Animation failed: if ($funcinst(`%;%`(s, f))[fa].CODE_funcinst = `FUNC%%*%`(functype, valtype*{valtype}, expr))
Animation failed: if (functype = `%->%`(valtype*{valtype}, valtype'*{valtype'}))

;; 1-syntax.watsup:3.1-3.15
syntax n = nat

;; 1-syntax.watsup:9.1-9.37
syntax name = text

;; 1-syntax.watsup:14.1-14.36
syntax byte = nat

;; 1-syntax.watsup:15.1-15.45
syntax u32 = nat

;; 1-syntax.watsup:22.1-22.36
syntax idx = nat

;; 1-syntax.watsup:23.1-23.49
syntax funcidx = idx

;; 1-syntax.watsup:24.1-24.49
syntax globalidx = idx

;; 1-syntax.watsup:25.1-25.47
syntax tableidx = idx

;; 1-syntax.watsup:26.1-26.46
syntax memidx = idx

;; 1-syntax.watsup:27.1-27.45
syntax elemidx = idx

;; 1-syntax.watsup:28.1-28.45
syntax dataidx = idx

;; 1-syntax.watsup:29.1-29.47
syntax labelidx = idx

;; 1-syntax.watsup:30.1-30.47
syntax localidx = idx

;; 1-syntax.watsup:39.1-40.22
syntax numtype =
  | I32
  | I64
  | F32
  | F64

;; 1-syntax.watsup:41.1-42.5
syntax vectype =
  | V128

;; 1-syntax.watsup:43.1-44.20
syntax reftype =
  | FUNCREF
  | EXTERNREF

;; 1-syntax.watsup:45.1-46.34
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

;; 1-syntax.watsup:48.1-48.39
syntax in =
  | I32
  | I64

def numtype_in : in -> numtype
  def numtype_in(I32_in) = I32_numtype
  def numtype_in(I64_in) = I64_numtype

def valtype_in : in -> valtype
  def valtype_in(I32_in) = I32_valtype
  def valtype_in(I64_in) = I64_valtype

;; 1-syntax.watsup:49.1-49.39
syntax fn =
  | F32
  | F64

def numtype_fn : fn -> numtype
  def numtype_fn(F32_fn) = F32_numtype
  def numtype_fn(F64_fn) = F64_numtype

def valtype_fn : fn -> valtype
  def valtype_fn(F32_fn) = F32_valtype
  def valtype_fn(F64_fn) = F64_valtype

;; 1-syntax.watsup:56.1-57.11
syntax resulttype = valtype*

;; 1-syntax.watsup:59.1-60.17
syntax limits = `[%..%?]`(u32, u32?)

;; 1-syntax.watsup:61.1-62.15
syntax globaltype = `MUT%?%`(()?, valtype)

;; 1-syntax.watsup:63.1-64.27
syntax functype = `%->%`(resulttype, resulttype)

;; 1-syntax.watsup:65.1-66.17
syntax tabletype = `%%`(limits, reftype)

;; 1-syntax.watsup:67.1-68.12
syntax memtype = `%I8`(limits)

;; 1-syntax.watsup:69.1-70.10
syntax elemtype = reftype

;; 1-syntax.watsup:71.1-72.5
syntax datatype = OK

;; 1-syntax.watsup:73.1-74.66
syntax externtype =
  | GLOBAL(globaltype)
  | FUNC(functype)
  | TABLE(tabletype)
  | MEM(memtype)

;; 1-syntax.watsup:86.1-86.44
syntax sx =
  | U
  | S

;; 1-syntax.watsup:88.1-88.39
syntax unop_IXX =
  | CLZ
  | CTZ
  | POPCNT

;; 1-syntax.watsup:89.1-89.70
syntax unop_FXX =
  | ABS
  | NEG
  | SQRT
  | CEIL
  | FLOOR
  | TRUNC
  | NEAREST

;; 1-syntax.watsup:91.1-93.62
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

;; 1-syntax.watsup:94.1-94.66
syntax binop_FXX =
  | ADD
  | SUB
  | MUL
  | DIV
  | MIN
  | MAX
  | COPYSIGN

;; 1-syntax.watsup:96.1-96.26
syntax testop_IXX =
  | EQZ

;; 1-syntax.watsup:97.1-97.22
syntax testop_FXX =
  |

;; 1-syntax.watsup:99.1-100.108
syntax relop_IXX =
  | EQ
  | NE
  | LT(sx)
  | GT(sx)
  | LE(sx)
  | GE(sx)

;; 1-syntax.watsup:101.1-101.49
syntax relop_FXX =
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE

;; 1-syntax.watsup:103.1-103.50
syntax unop_numtype =
  | _I(unop_IXX)
  | _F(unop_FXX)

;; 1-syntax.watsup:104.1-104.53
syntax binop_numtype =
  | _I(binop_IXX)
  | _F(binop_FXX)

;; 1-syntax.watsup:105.1-105.56
syntax testop_numtype =
  | _I(testop_IXX)
  | _F(testop_FXX)

;; 1-syntax.watsup:106.1-106.53
syntax relop_numtype =
  | _I(relop_IXX)
  | _F(relop_FXX)

;; 1-syntax.watsup:107.1-107.39
syntax cvtop =
  | CONVERT
  | REINTERPRET

;; 1-syntax.watsup:117.1-117.23
syntax c_numtype = nat

;; 1-syntax.watsup:118.1-118.23
syntax c_vectype = nat

;; 1-syntax.watsup:121.1-121.52
syntax blocktype = functype

;; 1-syntax.watsup:156.1-177.80
rec {

;; 1-syntax.watsup:156.1-177.80
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
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
  | LOAD(numtype, (n, sx)?, u32, u32)
  | STORE(numtype, n?, u32, u32)
}

;; 1-syntax.watsup:179.1-180.9
syntax expr = instr*

;; 1-syntax.watsup:187.1-187.50
syntax elemmode =
  | TABLE(tableidx, expr)
  | DECLARE

;; 1-syntax.watsup:188.1-188.39
syntax datamode =
  | MEMORY(memidx, expr)

;; 1-syntax.watsup:190.1-191.30
syntax func = `FUNC%%*%`(functype, valtype*, expr)

;; 1-syntax.watsup:192.1-193.25
syntax global = GLOBAL(globaltype, expr)

;; 1-syntax.watsup:194.1-195.18
syntax table = TABLE(tabletype)

;; 1-syntax.watsup:196.1-197.17
syntax mem = MEMORY(memtype)

;; 1-syntax.watsup:198.1-199.31
syntax elem = `ELEM%%*%?`(reftype, expr*, elemmode?)

;; 1-syntax.watsup:200.1-201.23
syntax data = `DATA%*%?`(byte*, datamode?)

;; 1-syntax.watsup:202.1-203.16
syntax start = START(funcidx)

;; 1-syntax.watsup:205.1-206.62
syntax externuse =
  | FUNC(funcidx)
  | GLOBAL(globalidx)
  | TABLE(tableidx)
  | MEM(memidx)

;; 1-syntax.watsup:207.1-208.24
syntax export = EXPORT(name, externuse)

;; 1-syntax.watsup:209.1-210.30
syntax import = IMPORT(name, name, externtype)

;; 1-syntax.watsup:212.1-213.70
syntax module = `MODULE%*%*%*%*%*%*%*%?%*`(import*, func*, global*, table*, mem*, elem*, data*, start?, export*)

;; 2-aux.watsup:3.1-3.14
def Ki : nat
  ;; 2-aux.watsup:4.1-4.15
  def Ki = 1024

;; 2-aux.watsup:9.1-9.25
rec {

;; 2-aux.watsup:9.1-9.25
def min : (nat, nat) -> nat
  ;; 2-aux.watsup:10.1-10.19
  def {j : nat} min(0, j) = 0
  ;; 2-aux.watsup:11.1-11.19
  def {i : nat} min(i, 0) = 0
  ;; 2-aux.watsup:12.1-12.38
  def {i : nat, j : nat} min((i + 1), (j + 1)) = $min(i, j)
}

;; 2-aux.watsup:19.1-19.55
def size : valtype -> nat?
  ;; 2-aux.watsup:20.1-20.20
  def size(I32_valtype) = ?(32)
  ;; 2-aux.watsup:21.1-21.20
  def size(I64_valtype) = ?(64)
  ;; 2-aux.watsup:22.1-22.20
  def size(F32_valtype) = ?(32)
  ;; 2-aux.watsup:23.1-23.20
  def size(F64_valtype) = ?(64)
  ;; 2-aux.watsup:24.1-24.22
  def size(V128_valtype) = ?(128)
  def {x : valtype} size(x) = ?()

;; 2-aux.watsup:29.1-29.40
def test_sub_ATOM_22 : n -> nat
  ;; 2-aux.watsup:30.1-30.38
  def {n_3_ATOM_y : n} test_sub_ATOM_22(n_3_ATOM_y) = 0

;; 2-aux.watsup:32.1-32.26
def curried_ : (n, n) -> nat
  ;; 2-aux.watsup:33.1-33.39
  def {n_1 : n, n_2 : n} curried_(n_1, n_2) = (n_1 + n_2)

;; 2-aux.watsup:35.1-44.39
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

;; 3-typing.watsup:3.1-6.60
syntax context = {FUNC functype*, GLOBAL globaltype*, TABLE tabletype*, MEM memtype*, ELEM elemtype*, DATA datatype*, LOCAL valtype*, LABEL resulttype*, RETURN resulttype?}

;; 3-typing.watsup:14.1-14.66
relation Limits_ok: `|-%:%`(limits, nat)
  ;; 3-typing.watsup:22.1-24.24
  rule _ {k : nat, n_1 : n, n_2 : n}:
    `|-%:%`(`[%..%?]`(n_1, ?(n_2)), k)
    -- if ((n_1 <= n_2) /\ (n_2 <= k))

;; 3-typing.watsup:15.1-15.64
relation Functype_ok: `|-%:OK`(functype)
  ;; 3-typing.watsup:26.1-27.13
  rule _ {ft : functype}:
    `|-%:OK`(ft)

;; 3-typing.watsup:16.1-16.66
relation Globaltype_ok: `|-%:OK`(globaltype)
  ;; 3-typing.watsup:29.1-30.13
  rule _ {gt : globaltype}:
    `|-%:OK`(gt)

;; 3-typing.watsup:17.1-17.65
relation Tabletype_ok: `|-%:OK`(tabletype)
  ;; 3-typing.watsup:32.1-34.35
  rule _ {lim : limits, rt : reftype}:
    `|-%:OK`(`%%`(lim, rt))
    -- Limits_ok: `|-%:%`(lim, ((2 ^ 32) - 1))

;; 3-typing.watsup:18.1-18.63
relation Memtype_ok: `|-%:OK`(memtype)
  ;; 3-typing.watsup:36.1-38.33
  rule _ {lim : limits}:
    `|-%:OK`(`%I8`(lim))
    -- Limits_ok: `|-%:%`(lim, (2 ^ 16))

;; 3-typing.watsup:19.1-19.66
relation Externtype_ok: `|-%:OK`(externtype)
  ;; 3-typing.watsup:41.1-43.35
  rule func {functype : functype}:
    `|-%:OK`(FUNC_externtype(functype))
    -- Functype_ok: `|-%:OK`(functype)

  ;; 3-typing.watsup:45.1-47.39
  rule global {globaltype : globaltype}:
    `|-%:OK`(GLOBAL_externtype(globaltype))
    -- Globaltype_ok: `|-%:OK`(globaltype)

  ;; 3-typing.watsup:49.1-51.37
  rule table {tabletype : tabletype}:
    `|-%:OK`(TABLE_externtype(tabletype))
    -- Tabletype_ok: `|-%:OK`(tabletype)

  ;; 3-typing.watsup:53.1-55.33
  rule mem {memtype : memtype}:
    `|-%:OK`(MEM_externtype(memtype))
    -- Memtype_ok: `|-%:OK`(memtype)

;; 3-typing.watsup:61.1-61.65
relation Valtype_sub: `|-%<:%`(valtype, valtype)
  ;; 3-typing.watsup:64.1-65.12
  rule refl {t : valtype}:
    `|-%<:%`(t, t)

  ;; 3-typing.watsup:67.1-68.14
  rule bot {t : valtype}:
    `|-%<:%`(BOT_valtype, t)

;; 3-typing.watsup:62.1-62.72
relation Resulttype_sub: `|-%*<:%*`(valtype*, valtype*)
  ;; 3-typing.watsup:70.1-72.35
  rule _ {t_1* : valtype*, t_2* : valtype*}:
    `|-%*<:%*`(t_1*{t_1}, t_2*{t_2})
    -- if (|t_1*{t_1}| = |t_2*{t_2}|)
    -- (Valtype_sub: `|-%<:%`(t_1, t_2))*{t_1 t_2}

;; 3-typing.watsup:75.1-75.75
relation Limits_sub: `|-%<:%`(limits, limits)
  ;; 3-typing.watsup:83.1-86.21
  rule _ {n_11 : n, n_12 : n, n_21 : n, n_22 : n}:
    `|-%<:%`(`[%..%?]`(n_11, ?(n_12)), `[%..%?]`(n_21, ?(n_22)))
    -- if (n_11 >= n_21)
    -- if (n_12 <= n_22)

;; 3-typing.watsup:76.1-76.73
relation Functype_sub: `|-%<:%`(functype, functype)
  ;; 3-typing.watsup:88.1-89.14
  rule _ {ft : functype}:
    `|-%<:%`(ft, ft)

;; 3-typing.watsup:77.1-77.75
relation Globaltype_sub: `|-%<:%`(globaltype, globaltype)
  ;; 3-typing.watsup:91.1-92.14
  rule _ {gt : globaltype}:
    `|-%<:%`(gt, gt)

;; 3-typing.watsup:78.1-78.74
relation Tabletype_sub: `|-%<:%`(tabletype, tabletype)
  ;; 3-typing.watsup:94.1-96.35
  rule _ {lim_1 : limits, lim_2 : limits, rt : reftype}:
    `|-%<:%`(`%%`(lim_1, rt), `%%`(lim_2, rt))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:79.1-79.72
relation Memtype_sub: `|-%<:%`(memtype, memtype)
  ;; 3-typing.watsup:98.1-100.35
  rule _ {lim_1 : limits, lim_2 : limits}:
    `|-%<:%`(`%I8`(lim_1), `%I8`(lim_2))
    -- Limits_sub: `|-%<:%`(lim_1, lim_2)

;; 3-typing.watsup:80.1-80.75
relation Externtype_sub: `|-%<:%`(externtype, externtype)
  ;; 3-typing.watsup:103.1-105.35
  rule func {ft_1 : functype, ft_2 : functype}:
    `|-%<:%`(FUNC_externtype(ft_1), FUNC_externtype(ft_2))
    -- Functype_sub: `|-%<:%`(ft_1, ft_2)

  ;; 3-typing.watsup:107.1-109.37
  rule global {gt_1 : globaltype, gt_2 : globaltype}:
    `|-%<:%`(GLOBAL_externtype(gt_1), GLOBAL_externtype(gt_2))
    -- Globaltype_sub: `|-%<:%`(gt_1, gt_2)

  ;; 3-typing.watsup:111.1-113.36
  rule table {tt_1 : tabletype, tt_2 : tabletype}:
    `|-%<:%`(TABLE_externtype(tt_1), TABLE_externtype(tt_2))
    -- Tabletype_sub: `|-%<:%`(tt_1, tt_2)

  ;; 3-typing.watsup:115.1-117.34
  rule mem {mt_1 : memtype, mt_2 : memtype}:
    `|-%<:%`(MEM_externtype(mt_1), MEM_externtype(mt_2))
    -- Memtype_sub: `|-%<:%`(mt_1, mt_2)

;; 3-typing.watsup:172.1-172.76
relation Blocktype_ok: `%|-%:%`(context, blocktype, functype)
  ;; 3-typing.watsup:174.1-176.29
  rule _ {C : context, ft : functype}:
    `%|-%:%`(C, ft, ft)
    -- Functype_ok: `|-%:OK`(ft)

;; 3-typing.watsup:123.1-124.67
rec {

;; 3-typing.watsup:123.1-123.66
relation Instr_ok: `%|-%:%`(context, instr, functype)
  ;; 3-typing.watsup:153.1-154.34
  rule unreachable {C : context, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, UNREACHABLE_instr, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:156.1-157.32
  rule nop {C : context}:
    `%|-%:%`(C, NOP_instr, `%->%`([], []))

  ;; 3-typing.watsup:159.1-160.27
  rule drop {C : context, t : valtype}:
    `%|-%:%`(C, DROP_instr, `%->%`([t], []))

  ;; 3-typing.watsup:163.1-164.31
  rule select-expl {C : context, t : valtype}:
    `%|-%:%`(C, SELECT_instr(?(t)), `%->%`([t t I32_valtype], [t]))

  ;; 3-typing.watsup:166.1-169.37
  rule select-impl {C : context, numtype : numtype, t : valtype, t' : valtype, vectype : vectype}:
    `%|-%:%`(C, SELECT_instr(?()), `%->%`([t t I32_valtype], [t]))
    -- Valtype_sub: `|-%<:%`(t, t')
    -- if ((t' = $valtype_numtype(numtype)) \/ (t' = $valtype_vectype(vectype)))

  ;; 3-typing.watsup:178.1-181.57
  rule block {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BLOCK_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:183.1-186.57
  rule loop {C : context, bt : blocktype, instr* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, LOOP_instr(bt, instr*{instr}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_1]*{t_1}, RETURN ?()}, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:188.1-192.59
  rule if {C : context, bt : blocktype, instr_1* : instr*, instr_2* : instr*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, IF_instr(bt, instr_1*{instr_1}, instr_2*{instr_2}), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Blocktype_ok: `%|-%:%`(C, bt, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr_1*{instr_1}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2]*{t_2}, RETURN ?()}, instr_2*{instr_2}, `%->%`(t_1*{t_1}, t_2*{t_2}))

  ;; 3-typing.watsup:195.1-197.24
  rule br {C : context, l : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_instr(l), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- if (l < |C.LABEL_context|)
    -- where t*{t} = C.LABEL_context[l]

  ;; 3-typing.watsup:199.1-201.24
  rule br_if {C : context, l : labelidx, t* : valtype*}:
    `%|-%:%`(C, BR_IF_instr(l), `%->%`(t*{t} :: [I32_valtype], t*{t}))
    -- if (l < |C.LABEL_context|)
    -- where t*{t} = C.LABEL_context[l]

  ;; 3-typing.watsup:203.1-206.42
  rule br_table {C : context, l* : labelidx*, l' : labelidx, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, BR_TABLE_instr(l*{l}, l'), `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- (if (l < |C.LABEL_context|))*{l}
    -- if (l' < |C.LABEL_context|)
    -- (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}
    -- Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])

  ;; 3-typing.watsup:208.1-210.24
  rule return {C : context, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, RETURN_instr, `%->%`(t_1*{t_1} :: t*{t}, t_2*{t_2}))
    -- where ?(t*{t}) = C.RETURN_context

  ;; 3-typing.watsup:212.1-214.33
  rule call {C : context, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_instr(x), `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- if (x < |C.FUNC_context|)
    -- where `%->%`(t_1*{t_1}, t_2*{t_2}) = C.FUNC_context[x]

  ;; 3-typing.watsup:216.1-219.26
  rule call_indirect {C : context, ft : functype, lim : limits, t_1* : valtype*, t_2* : valtype*, x : idx}:
    `%|-%:%`(C, CALL_INDIRECT_instr(x, ft), `%->%`(t_1*{t_1} :: [I32_valtype], t_2*{t_2}))
    -- if (x < |C.TABLE_context|)
    -- where `%->%`(t_1*{t_1}, t_2*{t_2}) = ft
    -- where `%%`(lim, FUNCREF_reftype) = C.TABLE_context[x]

  ;; 3-typing.watsup:222.1-223.37
  rule const {C : context, c_nt : c_numtype, nt : numtype}:
    `%|-%:%`(C, CONST_instr(nt, c_nt), `%->%`([], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:225.1-226.31
  rule unop {C : context, nt : numtype, unop : unop_numtype}:
    `%|-%:%`(C, UNOP_instr(nt, unop), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:228.1-229.36
  rule binop {C : context, binop : binop_numtype, nt : numtype}:
    `%|-%:%`(C, BINOP_instr(nt, binop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [$valtype_numtype(nt)]))

  ;; 3-typing.watsup:231.1-232.36
  rule testop {C : context, nt : numtype, testop : testop_numtype}:
    `%|-%:%`(C, TESTOP_instr(nt, testop), `%->%`([$valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:234.1-235.37
  rule relop {C : context, nt : numtype, relop : relop_numtype}:
    `%|-%:%`(C, RELOP_instr(nt, relop), `%->%`([$valtype_numtype(nt) $valtype_numtype(nt)], [I32_valtype]))

  ;; 3-typing.watsup:238.1-240.23
  rule extend {C : context, n : n, nt : numtype, o0 : nat}:
    `%|-%:%`(C, EXTEND_instr(nt, n), `%->%`([$valtype_numtype(nt)], [$valtype_numtype(nt)]))
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- if (n <= o0)

  ;; 3-typing.watsup:242.1-245.34
  rule reinterpret {C : context, nt_1 : numtype, nt_2 : numtype, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr(nt_1, REINTERPRET_cvtop, nt_2, ?()), `%->%`([$valtype_numtype(nt_2)], [$valtype_numtype(nt_1)]))
    -- if (nt_1 =/= nt_2)
    -- where ?(o0) = $size($valtype_numtype(nt_1))
    -- where o1 = o0
    -- if ($size($valtype_numtype(nt_2)) = ?(o1))

  ;; 3-typing.watsup:247.1-250.52
  rule convert-i {C : context, in_1 : in, in_2 : in, sx? : sx?, o0 : nat, o1 : nat}:
    `%|-%:%`(C, CVTOP_instr($numtype_in(in_1), CONVERT_cvtop, $numtype_in(in_2), sx?{sx}), `%->%`([$valtype_in(in_2)], [$valtype_in(in_1)]))
    -- if (in_1 =/= in_2)
    -- where ?(o0) = $size($valtype_in(in_1))
    -- where ?(o1) = $size($valtype_in(in_2))
    -- if ((sx?{sx} = ?()) <=> (o0 > o1))

  ;; 3-typing.watsup:252.1-254.22
  rule convert-f {C : context, fn_1 : fn, fn_2 : fn}:
    `%|-%:%`(C, CVTOP_instr($numtype_fn(fn_1), CONVERT_cvtop, $numtype_fn(fn_2), ?()), `%->%`([$valtype_fn(fn_2)], [$valtype_fn(fn_1)]))
    -- if (fn_1 =/= fn_2)

  ;; 3-typing.watsup:257.1-258.35
  rule ref.null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.NULL_instr(rt), `%->%`([], [$valtype_reftype(rt)]))

  ;; 3-typing.watsup:260.1-262.23
  rule ref.func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, REF.FUNC_instr(x), `%->%`([], [FUNCREF_valtype]))
    -- if (x < |C.FUNC_context|)
    -- where ft = C.FUNC_context[x]

  ;; 3-typing.watsup:264.1-265.31
  rule ref.is_null {C : context, rt : reftype}:
    `%|-%:%`(C, REF.IS_NULL_instr, `%->%`([$valtype_reftype(rt)], [I32_valtype]))

  ;; 3-typing.watsup:268.1-270.23
  rule local.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.GET_instr(x), `%->%`([], [t]))
    -- if (x < |C.LOCAL_context|)
    -- where t = C.LOCAL_context[x]

  ;; 3-typing.watsup:272.1-274.23
  rule local.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.SET_instr(x), `%->%`([t], []))
    -- if (x < |C.LOCAL_context|)
    -- where t = C.LOCAL_context[x]

  ;; 3-typing.watsup:276.1-278.23
  rule local.tee {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, LOCAL.TEE_instr(x), `%->%`([t], [t]))
    -- if (x < |C.LOCAL_context|)
    -- where t = C.LOCAL_context[x]

  ;; 3-typing.watsup:281.1-283.29
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.GET_instr(x), `%->%`([], [t]))
    -- if (x < |C.GLOBAL_context|)
    -- where `MUT%?%`(()?{}, t) = C.GLOBAL_context[x]

  ;; 3-typing.watsup:285.1-287.28
  rule global.set {C : context, t : valtype, x : idx}:
    `%|-%:%`(C, GLOBAL.SET_instr(x), `%->%`([t], []))
    -- if (x < |C.GLOBAL_context|)
    -- where `MUT%?%`(?(()), t) = C.GLOBAL_context[x]

  ;; 3-typing.watsup:290.1-292.28
  rule table.get {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GET_instr(x), `%->%`([I32_valtype], [$valtype_reftype(rt)]))
    -- if (x < |C.TABLE_context|)
    -- where `%%`(lim, rt) = C.TABLE_context[x]

  ;; 3-typing.watsup:294.1-296.28
  rule table.set {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.SET_instr(x), `%->%`([I32_valtype $valtype_reftype(rt)], []))
    -- if (x < |C.TABLE_context|)
    -- where `%%`(lim, rt) = C.TABLE_context[x]

  ;; 3-typing.watsup:298.1-300.24
  rule table.size {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE.SIZE_instr(x), `%->%`([], [I32_valtype]))
    -- if (x < |C.TABLE_context|)
    -- where tt = C.TABLE_context[x]

  ;; 3-typing.watsup:302.1-304.28
  rule table.grow {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.GROW_instr(x), `%->%`([$valtype_reftype(rt) I32_valtype], [I32_valtype]))
    -- if (x < |C.TABLE_context|)
    -- where `%%`(lim, rt) = C.TABLE_context[x]

  ;; 3-typing.watsup:306.1-308.28
  rule table.fill {C : context, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE.FILL_instr(x), `%->%`([I32_valtype $valtype_reftype(rt) I32_valtype], []))
    -- if (x < |C.TABLE_context|)
    -- where `%%`(lim, rt) = C.TABLE_context[x]

  ;; 3-typing.watsup:310.1-313.32
  rule table.copy {C : context, lim_1 : limits, lim_2 : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.COPY_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (x_1 < |C.TABLE_context|)
    -- if (x_2 < |C.TABLE_context|)
    -- where `%%`(lim_1, rt) = C.TABLE_context[x_1]
    -- where `%%`(lim_2, rt) = C.TABLE_context[x_2]

  ;; 3-typing.watsup:315.1-318.25
  rule table.init {C : context, lim : limits, rt : reftype, x_1 : idx, x_2 : idx}:
    `%|-%:%`(C, TABLE.INIT_instr(x_1, x_2), `%->%`([I32_valtype I32_valtype I32_valtype], []))
    -- if (x_1 < |C.TABLE_context|)
    -- if (x_2 < |C.ELEM_context|)
    -- where `%%`(lim, rt) = C.TABLE_context[x_1]
    -- if (C.ELEM_context[x_2] = rt)

  ;; 3-typing.watsup:320.1-322.23
  rule elem.drop {C : context, rt : reftype, x : idx}:
    `%|-%:%`(C, ELEM.DROP_instr(x), `%->%`([], []))
    -- if (x < |C.ELEM_context|)
    -- where rt = C.ELEM_context[x]

  ;; 3-typing.watsup:325.1-327.22
  rule memory.size {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.SIZE_instr, `%->%`([], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- where mt = C.MEM_context[0]

  ;; 3-typing.watsup:329.1-331.22
  rule memory.grow {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.GROW_instr, `%->%`([I32_valtype], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- where mt = C.MEM_context[0]

  ;; 3-typing.watsup:333.1-335.22
  rule memory.fill {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.FILL_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- where mt = C.MEM_context[0]

  ;; 3-typing.watsup:337.1-339.22
  rule memory.copy {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY.COPY_instr, `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- where mt = C.MEM_context[0]

  ;; 3-typing.watsup:341.1-344.23
  rule memory.init {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEMORY.INIT_instr(x), `%->%`([I32_valtype I32_valtype I32_valtype], [I32_valtype]))
    -- if (0 < |C.MEM_context|)
    -- if (x < |C.DATA_context|)
    -- if (C.DATA_context[x] = OK)
    -- where mt = C.MEM_context[0]

  ;; 3-typing.watsup:346.1-348.23
  rule data.drop {C : context, x : idx}:
    `%|-%:%`(C, DATA.DROP_instr(x), `%->%`([], []))
    -- if (x < |C.DATA_context|)
    -- if (C.DATA_context[x] = OK)

  ;; 3-typing.watsup:350.1-355.32
  rule load {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, sx? : sx?, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, LOAD_instr(nt, (n, sx)?{n sx}, n_A, n_O), `%->%`([I32_valtype], [$valtype_numtype(nt)]))
    -- if (0 < |C.MEM_context|)
    -- if ((n?{n} = ?()) <=> (sx?{sx} = ?()))
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- where mt = C.MEM_context[0]
    -- (where ?(o1) = $size($valtype_numtype(nt)))?{o1}
    -- if ((n?{n} = ?()) <=> (o1?{o1} = ?()))
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_in(in)))

  ;; 3-typing.watsup:357.1-362.32
  rule store {C : context, in : in, mt : memtype, n? : n?, n_A : n, n_O : n, nt : numtype, o0 : nat, o1? : nat?}:
    `%|-%:%`(C, STORE_instr(nt, n?{n}, n_A, n_O), `%->%`([I32_valtype $valtype_numtype(nt)], []))
    -- if (0 < |C.MEM_context|)
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- where mt = C.MEM_context[0]
    -- (where ?(o1) = $size($valtype_numtype(nt)))?{o1}
    -- if ((n?{n} = ?()) <=> (o1?{o1} = ?()))
    -- if ((2 ^ n_A) <= (o0 / 8))
    -- (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < (o1 / 8))))?{n o1}
    -- if ((n?{n} = ?()) \/ (nt = $numtype_in(in)))

;; 3-typing.watsup:124.1-124.67
relation InstrSeq_ok: `%|-%*:%`(context, instr*, functype)
  ;; 3-typing.watsup:133.1-134.36
  rule empty {C : context}:
    `%|-%*:%`(C, [], `%->%`([], []))

  ;; 3-typing.watsup:136.1-139.46
  rule seq {C : context, instr_1 : instr, instr_2 : instr, t_1* : valtype*, t_2* : valtype*, t_3* : valtype*}:
    `%|-%*:%`(C, [instr_1] :: instr_2*{}, `%->%`(t_1*{t_1}, t_3*{t_3}))
    -- Instr_ok: `%|-%:%`(C, instr_1, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, [instr_2], `%->%`(t_2*{t_2}, t_3*{t_3}))

  ;; 3-typing.watsup:141.1-146.38
  rule weak {C : context, instr* : instr*, t'_1* : valtype*, t'_2* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t'_1*{t'_1}, t'_2*{t'_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
    -- Resulttype_sub: `|-%*<:%*`(t'_1*{t'_1}, t_1*{t_1})
    -- Resulttype_sub: `|-%*<:%*`(t_2*{t_2}, t'_2*{t'_2})

  ;; 3-typing.watsup:148.1-150.45
  rule frame {C : context, instr* : instr*, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%*:%`(C, instr*{instr}, `%->%`(t*{t} :: t_1*{t_1}, t*{t} :: t_2*{t_2}))
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`(t_1*{t_1}, t_2*{t_2}))
}

;; 3-typing.watsup:125.1-125.71
relation Expr_ok: `%|-%:%`(context, expr, resulttype)
  ;; 3-typing.watsup:128.1-130.46
  rule _ {C : context, instr* : instr*, t* : valtype*}:
    `%|-%:%`(C, instr*{instr}, t*{t})
    -- InstrSeq_ok: `%|-%*:%`(C, instr*{instr}, `%->%`([], t*{t}))

;; 3-typing.watsup:367.1-367.78
relation Instr_const: `%|-%CONST`(context, instr)
  ;; 3-typing.watsup:371.1-372.26
  rule const {C : context, c : c_numtype, nt : numtype}:
    `%|-%CONST`(C, CONST_instr(nt, c))

  ;; 3-typing.watsup:374.1-375.27
  rule ref.null {C : context, rt : reftype}:
    `%|-%CONST`(C, REF.NULL_instr(rt))

  ;; 3-typing.watsup:377.1-378.26
  rule ref.func {C : context, x : idx}:
    `%|-%CONST`(C, REF.FUNC_instr(x))

  ;; 3-typing.watsup:380.1-382.32
  rule global.get {C : context, t : valtype, x : idx}:
    `%|-%CONST`(C, GLOBAL.GET_instr(x))
    -- if (x < |C.GLOBAL_context|)
    -- if (C.GLOBAL_context[x] = `MUT%?%`(?(), t))

;; 3-typing.watsup:368.1-368.77
relation Expr_const: `%|-%CONST`(context, expr)
  ;; 3-typing.watsup:385.1-386.38
  rule _ {C : context, instr* : instr*}:
    `%|-%CONST`(C, instr*{instr})
    -- (Instr_const: `%|-%CONST`(C, instr))*{instr}

;; 3-typing.watsup:369.1-369.78
relation Expr_ok_const: `%|-%:%CONST`(context, expr, valtype)
  ;; 3-typing.watsup:389.1-392.33
  rule _ {C : context, expr : expr, t : valtype}:
    `%|-%:%CONST`(C, expr, t)
    -- Expr_ok: `%|-%:%`(C, expr, [t])
    -- Expr_const: `%|-%CONST`(C, expr)

;; 3-typing.watsup:397.1-397.73
relation Func_ok: `%|-%:%`(context, func, functype)
  ;; 3-typing.watsup:408.1-412.75
  rule _ {C : context, expr : expr, ft : functype, t* : valtype*, t_1* : valtype*, t_2* : valtype*}:
    `%|-%:%`(C, `FUNC%%*%`(ft, t*{t}, expr), ft)
    -- Functype_ok: `|-%:OK`(ft)
    -- where `%->%`(t_1*{t_1}, t_2*{t_2}) = ft
    -- Expr_ok: `%|-%:%`(C ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL t_1*{t_1} :: t*{t}, LABEL [], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [t_2*{t_2}], RETURN ?()} ++ {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], LOCAL [], LABEL [], RETURN ?(t_2*{t_2})}, expr, t_2*{t_2})

;; 3-typing.watsup:398.1-398.75
relation Global_ok: `%|-%:%`(context, global, globaltype)
  ;; 3-typing.watsup:414.1-418.40
  rule _ {C : context, expr : expr, gt : globaltype, t : valtype}:
    `%|-%:%`(C, GLOBAL(gt, expr), gt)
    -- Globaltype_ok: `|-%:OK`(gt)
    -- where `MUT%?%`(()?{}, t) = gt
    -- Expr_ok_const: `%|-%:%CONST`(C, expr, t)

;; 3-typing.watsup:399.1-399.74
relation Table_ok: `%|-%:%`(context, table, tabletype)
  ;; 3-typing.watsup:420.1-422.30
  rule _ {C : context, tt : tabletype}:
    `%|-%:%`(C, TABLE(tt), tt)
    -- Tabletype_ok: `|-%:OK`(tt)

;; 3-typing.watsup:400.1-400.72
relation Mem_ok: `%|-%:%`(context, mem, memtype)
  ;; 3-typing.watsup:424.1-426.28
  rule _ {C : context, mt : memtype}:
    `%|-%:%`(C, MEMORY(mt), mt)
    -- Memtype_ok: `|-%:OK`(mt)

;; 3-typing.watsup:403.1-403.77
relation Elemmode_ok: `%|-%:%`(context, elemmode, reftype)
  ;; 3-typing.watsup:437.1-440.45
  rule active {C : context, expr : expr, lim : limits, rt : reftype, x : idx}:
    `%|-%:%`(C, TABLE_elemmode(x, expr), rt)
    -- if (x < |C.TABLE_context|)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}
    -- where `%%`(lim, rt) = C.TABLE_context[x]

  ;; 3-typing.watsup:442.1-443.20
  rule declare {C : context, rt : reftype}:
    `%|-%:%`(C, DECLARE_elemmode, rt)

;; 3-typing.watsup:401.1-401.73
relation Elem_ok: `%|-%:%`(context, elem, reftype)
  ;; 3-typing.watsup:428.1-431.40
  rule _ {C : context, elemmode? : elemmode?, expr* : expr*, rt : reftype}:
    `%|-%:%`(C, `ELEM%%*%?`(rt, expr*{expr}, elemmode?{elemmode}), rt)
    -- (Expr_ok: `%|-%:%`(C, expr, [$valtype_reftype(rt)]))*{expr}
    -- (Elemmode_ok: `%|-%:%`(C, elemmode, rt))?{elemmode}

;; 3-typing.watsup:404.1-404.77
relation Datamode_ok: `%|-%:OK`(context, datamode)
  ;; 3-typing.watsup:445.1-448.45
  rule _ {C : context, expr : expr, mt : memtype}:
    `%|-%:OK`(C, MEMORY_datamode(0, expr))
    -- if (0 < |C.MEM_context|)
    -- if (C.MEM_context[0] = mt)
    -- (Expr_ok_const: `%|-%:%CONST`(C, expr, I32_valtype))*{}

;; 3-typing.watsup:402.1-402.73
relation Data_ok: `%|-%:OK`(context, data)
  ;; 3-typing.watsup:433.1-435.40
  rule _ {C : context, b* : byte*, datamode? : datamode?}:
    `%|-%:OK`(C, `DATA%*%?`(b*{b}, datamode?{datamode}))
    -- (Datamode_ok: `%|-%:OK`(C, datamode))?{datamode}

;; 3-typing.watsup:405.1-405.74
relation Start_ok: `%|-%:OK`(context, start)
  ;; 3-typing.watsup:450.1-452.39
  rule _ {C : context, x : idx}:
    `%|-%:OK`(C, START(x))
    -- if (x < |C.FUNC_context|)
    -- if (C.FUNC_context[x] = `%->%`([], []))

;; 3-typing.watsup:455.1-455.80
relation Import_ok: `%|-%:%`(context, import, externtype)
  ;; 3-typing.watsup:459.1-461.31
  rule _ {C : context, name_1 : name, name_2 : name, xt : externtype}:
    `%|-%:%`(C, IMPORT(name_1, name_2, xt), xt)
    -- Externtype_ok: `|-%:OK`(xt)

;; 3-typing.watsup:457.1-457.83
relation Externuse_ok: `%|-%:%`(context, externuse, externtype)
  ;; 3-typing.watsup:467.1-469.23
  rule func {C : context, ft : functype, x : idx}:
    `%|-%:%`(C, FUNC_externuse(x), FUNC_externtype(ft))
    -- if (x < |C.FUNC_context|)
    -- where ft = C.FUNC_context[x]

  ;; 3-typing.watsup:471.1-473.25
  rule global {C : context, gt : globaltype, x : idx}:
    `%|-%:%`(C, GLOBAL_externuse(x), GLOBAL_externtype(gt))
    -- if (x < |C.GLOBAL_context|)
    -- where gt = C.GLOBAL_context[x]

  ;; 3-typing.watsup:475.1-477.24
  rule table {C : context, tt : tabletype, x : idx}:
    `%|-%:%`(C, TABLE_externuse(x), TABLE_externtype(tt))
    -- if (x < |C.TABLE_context|)
    -- where tt = C.TABLE_context[x]

  ;; 3-typing.watsup:479.1-481.22
  rule mem {C : context, mt : memtype, x : idx}:
    `%|-%:%`(C, MEM_externuse(x), MEM_externtype(mt))
    -- if (x < |C.MEM_context|)
    -- where mt = C.MEM_context[x]

;; 3-typing.watsup:456.1-456.80
relation Export_ok: `%|-%:%`(context, export, externtype)
  ;; 3-typing.watsup:463.1-465.39
  rule _ {C : context, externuse : externuse, name : name, xt : externtype}:
    `%|-%:%`(C, EXPORT(name, externuse), xt)
    -- Externuse_ok: `%|-%:%`(C, externuse, xt)

;; 3-typing.watsup:484.1-484.62
relation Module_ok: `|-%:OK`(module)
  ;; 3-typing.watsup:486.1-500.16
  rule _ {C : context, data^n : data^n, elem* : elem*, export* : export*, ft* : functype*, func* : func*, global* : global*, gt* : globaltype*, import* : import*, mem* : mem*, mt* : memtype*, n : n, rt* : reftype*, start? : start?, table* : table*, tt* : tabletype*}:
    `|-%:OK`(`MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data^n{data}, start?{start}, export*{export}))
    -- if (|ft*{ft}| = |func*{func}|)
    -- if (|global*{global}| = |gt*{gt}|)
    -- if (|table*{table}| = |tt*{tt}|)
    -- if (|mem*{mem}| = |mt*{mt}|)
    -- if (|elem*{elem}| = |rt*{rt}|)
    -- if (C = {FUNC ft*{ft}, GLOBAL gt*{gt}, TABLE tt*{tt}, MEM mt*{mt}, ELEM rt*{rt}, DATA OK^n{}, LOCAL [], LABEL [], RETURN ?()})
    -- (Func_ok: `%|-%:%`(C, func, ft))*{ft func}
    -- (Global_ok: `%|-%:%`(C, global, gt))*{global gt}
    -- (Table_ok: `%|-%:%`(C, table, tt))*{table tt}
    -- (Mem_ok: `%|-%:%`(C, mem, mt))*{mem mt}
    -- (Elem_ok: `%|-%:%`(C, elem, rt))*{elem rt}
    -- (Data_ok: `%|-%:OK`(C, data))^n{data}
    -- (Start_ok: `%|-%:OK`(C, start))?{start}
    -- if (|mem*{mem}| <= 1)

;; 4-runtime.watsup:3.1-3.39
syntax addr = nat

;; 4-runtime.watsup:4.1-4.53
syntax funcaddr = addr

;; 4-runtime.watsup:5.1-5.53
syntax globaladdr = addr

;; 4-runtime.watsup:6.1-6.51
syntax tableaddr = addr

;; 4-runtime.watsup:7.1-7.50
syntax memaddr = addr

;; 4-runtime.watsup:8.1-8.49
syntax elemaddr = addr

;; 4-runtime.watsup:9.1-9.49
syntax dataaddr = addr

;; 4-runtime.watsup:10.1-10.51
syntax labeladdr = addr

;; 4-runtime.watsup:11.1-11.49
syntax hostaddr = addr

;; 4-runtime.watsup:24.1-25.24
syntax num =
  | CONST(numtype, c_numtype)

;; 4-runtime.watsup:26.1-27.67
syntax ref =
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:28.1-29.10
syntax val =
  | CONST(numtype, c_numtype)
  | REF.NULL(reftype)
  | REF.FUNC_ADDR(funcaddr)
  | REF.HOST_ADDR(hostaddr)

;; 4-runtime.watsup:31.1-32.18
syntax result =
  | _VALS(val*)
  | TRAP

;; 4-runtime.watsup:38.1-39.66
syntax externval =
  | FUNC(funcaddr)
  | GLOBAL(globaladdr)
  | TABLE(tableaddr)
  | MEM(memaddr)

;; 4-runtime.watsup:44.1-44.44
def default_ : valtype -> val?
  ;; 4-runtime.watsup:45.1-45.35
  def default_(I32_valtype) = ?(CONST_val(I32_numtype, 0))
  ;; 4-runtime.watsup:46.1-46.35
  def default_(I64_valtype) = ?(CONST_val(I64_numtype, 0))
  ;; 4-runtime.watsup:47.1-47.35
  def default_(F32_valtype) = ?(CONST_val(F32_numtype, 0))
  ;; 4-runtime.watsup:48.1-48.35
  def default_(F64_valtype) = ?(CONST_val(F64_numtype, 0))
  ;; 4-runtime.watsup:49.1-49.44
  def default_(FUNCREF_valtype) = ?(REF.NULL_val(FUNCREF_reftype))
  ;; 4-runtime.watsup:50.1-50.48
  def default_(EXTERNREF_valtype) = ?(REF.NULL_val(EXTERNREF_reftype))
  def {x : valtype} default_(x) = ?()

;; 4-runtime.watsup:72.1-74.22
syntax exportinst = {NAME name, VALUE externval}

;; 4-runtime.watsup:84.1-91.25
syntax moduleinst = {FUNC funcaddr*, GLOBAL globaladdr*, TABLE tableaddr*, MEM memaddr*, ELEM elemaddr*, DATA dataaddr*, EXPORT exportinst*}

;; 4-runtime.watsup:55.1-57.16
syntax funcinst = {MODULE moduleinst, CODE func}

;; 4-runtime.watsup:58.1-60.16
syntax globalinst = {TYPE globaltype, VALUE val}

;; 4-runtime.watsup:61.1-63.16
syntax tableinst = {TYPE tabletype, ELEM ref*}

;; 4-runtime.watsup:64.1-66.17
syntax meminst = {TYPE memtype, DATA byte*}

;; 4-runtime.watsup:67.1-69.16
syntax eleminst = {TYPE elemtype, ELEM ref*}

;; 4-runtime.watsup:70.1-71.17
syntax datainst = {DATA byte*}

;; 4-runtime.watsup:76.1-82.21
syntax store = {FUNC funcinst*, GLOBAL globalinst*, TABLE tableinst*, MEM meminst*, ELEM eleminst*, DATA datainst*}

;; 4-runtime.watsup:93.1-95.24
syntax frame = {LOCAL val*, MODULE moduleinst}

;; 4-runtime.watsup:96.1-96.47
syntax state = `%;%`(store, frame)

;; 4-runtime.watsup:180.1-187.5
rec {

;; 4-runtime.watsup:180.1-187.5
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
  | CALL(funcidx)
  | CALL_INDIRECT(tableidx, functype)
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
  | LOAD(numtype, (n, sx)?, u32, u32)
  | STORE(numtype, n?, u32, u32)
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
  def {x : valtype?} admininstr_instr(SELECT_instr(x)) = SELECT_admininstr(x)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(BLOCK_instr(x0, x1)) = BLOCK_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*} admininstr_instr(LOOP_instr(x0, x1)) = LOOP_admininstr(x0, x1)
  def {x0 : blocktype, x1 : instr*, x2 : instr*} admininstr_instr(IF_instr(x0, x1, x2)) = IF_admininstr(x0, x1, x2)
  def {x : labelidx} admininstr_instr(BR_instr(x)) = BR_admininstr(x)
  def {x : labelidx} admininstr_instr(BR_IF_instr(x)) = BR_IF_admininstr(x)
  def {x0 : labelidx*, x1 : labelidx} admininstr_instr(BR_TABLE_instr(x0, x1)) = BR_TABLE_admininstr(x0, x1)
  def {x : funcidx} admininstr_instr(CALL_instr(x)) = CALL_admininstr(x)
  def {x0 : tableidx, x1 : functype} admininstr_instr(CALL_INDIRECT_instr(x0, x1)) = CALL_INDIRECT_admininstr(x0, x1)
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
  def {x0 : numtype, x1 : (n, sx)?, x2 : u32, x3 : u32} admininstr_instr(LOAD_instr(x0, x1, x2, x3)) = LOAD_admininstr(x0, x1, x2, x3)
  def {x0 : numtype, x1 : n?, x2 : u32, x3 : u32} admininstr_instr(STORE_instr(x0, x1, x2, x3)) = STORE_admininstr(x0, x1, x2, x3)

def admininstr_ref : ref -> admininstr
  def {x : reftype} admininstr_ref(REF.NULL_ref(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_ref(REF.FUNC_ADDR_ref(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_ref(REF.HOST_ADDR_ref(x)) = REF.HOST_ADDR_admininstr(x)

def admininstr_val : val -> admininstr
  def {x0 : numtype, x1 : c_numtype} admininstr_val(CONST_val(x0, x1)) = CONST_admininstr(x0, x1)
  def {x : reftype} admininstr_val(REF.NULL_val(x)) = REF.NULL_admininstr(x)
  def {x : funcaddr} admininstr_val(REF.FUNC_ADDR_val(x)) = REF.FUNC_ADDR_admininstr(x)
  def {x : hostaddr} admininstr_val(REF.HOST_ADDR_val(x)) = REF.HOST_ADDR_admininstr(x)

;; 4-runtime.watsup:97.1-97.62
syntax config = `%;%*`(state, admininstr*)

;; 4-runtime.watsup:115.1-115.59
def funcaddr : state -> funcaddr*
  ;; 4-runtime.watsup:116.1-116.38
  def {f : frame, s : store} funcaddr(`%;%`(s, f)) = f.MODULE_frame.FUNC_moduleinst

;; 4-runtime.watsup:118.1-118.52
def funcinst : state -> funcinst*
  ;; 4-runtime.watsup:125.1-125.31
  def {f : frame, s : store} funcinst(`%;%`(s, f)) = s.FUNC_store

;; 4-runtime.watsup:119.1-119.58
def globalinst : state -> globalinst*
  ;; 4-runtime.watsup:126.1-126.35
  def {f : frame, s : store} globalinst(`%;%`(s, f)) = s.GLOBAL_store

;; 4-runtime.watsup:120.1-120.55
def tableinst : state -> tableinst*
  ;; 4-runtime.watsup:127.1-127.33
  def {f : frame, s : store} tableinst(`%;%`(s, f)) = s.TABLE_store

;; 4-runtime.watsup:121.1-121.49
def meminst : state -> meminst*
  ;; 4-runtime.watsup:128.1-128.29
  def {f : frame, s : store} meminst(`%;%`(s, f)) = s.MEM_store

;; 4-runtime.watsup:122.1-122.52
def eleminst : state -> eleminst*
  ;; 4-runtime.watsup:129.1-129.31
  def {f : frame, s : store} eleminst(`%;%`(s, f)) = s.ELEM_store

;; 4-runtime.watsup:123.1-123.52
def datainst : state -> datainst*
  ;; 4-runtime.watsup:130.1-130.31
  def {f : frame, s : store} datainst(`%;%`(s, f)) = s.DATA_store

;; 4-runtime.watsup:132.1-132.67
def func : (state, funcidx) -> funcinst
  ;; 4-runtime.watsup:140.1-140.48
  def {f : frame, s : store, x : idx} func(`%;%`(s, f), x) = s.FUNC_store[f.MODULE_frame.FUNC_moduleinst[x]]

;; 4-runtime.watsup:133.1-133.69
def global : (state, globalidx) -> globalinst
  ;; 4-runtime.watsup:141.1-141.54
  def {f : frame, s : store, x : idx} global(`%;%`(s, f), x) = s.GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]]

;; 4-runtime.watsup:134.1-134.68
def table : (state, tableidx) -> tableinst
  ;; 4-runtime.watsup:142.1-142.51
  def {f : frame, s : store, x : idx} table(`%;%`(s, f), x) = s.TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]]

;; 4-runtime.watsup:135.1-135.66
def mem : (state, memidx) -> meminst
  ;; 4-runtime.watsup:143.1-143.45
  def {f : frame, s : store, x : idx} mem(`%;%`(s, f), x) = s.MEM_store[f.MODULE_frame.MEM_moduleinst[x]]

;; 4-runtime.watsup:136.1-136.67
def elem : (state, tableidx) -> eleminst
  ;; 4-runtime.watsup:144.1-144.48
  def {f : frame, s : store, x : idx} elem(`%;%`(s, f), x) = s.ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]]

;; 4-runtime.watsup:137.1-137.67
def data : (state, dataidx) -> datainst
  ;; 4-runtime.watsup:145.1-145.48
  def {f : frame, s : store, x : idx} data(`%;%`(s, f), x) = s.DATA_store[f.MODULE_frame.DATA_moduleinst[x]]

;; 4-runtime.watsup:138.1-138.68
def local : (state, localidx) -> val
  ;; 4-runtime.watsup:146.1-146.35
  def {f : frame, s : store, x : idx} local(`%;%`(s, f), x) = f.LOCAL_frame[x]

;; 4-runtime.watsup:149.1-149.78
def with_local : (state, localidx, val) -> state
  ;; 4-runtime.watsup:158.1-158.52
  def {f : frame, s : store, v : val, x : idx} with_local(`%;%`(s, f), x, v) = `%;%`(s, f[LOCAL_frame[x] = v])

;; 4-runtime.watsup:150.1-150.85
def with_global : (state, globalidx, val) -> state
  ;; 4-runtime.watsup:159.1-159.77
  def {f : frame, s : store, v : val, x : idx} with_global(`%;%`(s, f), x, v) = `%;%`(s[GLOBAL_store[f.MODULE_frame.GLOBAL_moduleinst[x]].VALUE_globalinst = v], f)

;; 4-runtime.watsup:151.1-151.88
def with_table : (state, tableidx, nat, ref) -> state
  ;; 4-runtime.watsup:160.1-160.79
  def {f : frame, i : nat, r : ref, s : store, x : idx} with_table(`%;%`(s, f), x, i, r) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]].ELEM_tableinst[i] = r], f)

;; 4-runtime.watsup:152.1-152.84
def with_tableinst : (state, tableidx, tableinst) -> state
  ;; 4-runtime.watsup:161.1-161.74
  def {f : frame, s : store, ti : tableinst, x : idx} with_tableinst(`%;%`(s, f), x, ti) = `%;%`(s[TABLE_store[f.MODULE_frame.TABLE_moduleinst[x]] = ti], f)

;; 4-runtime.watsup:153.1-153.93
def with_mem : (state, memidx, nat, nat, byte*) -> state
  ;; 4-runtime.watsup:162.1-162.82
  def {b* : byte*, f : frame, i : nat, j : nat, s : store, x : idx} with_mem(`%;%`(s, f), x, i, j, b*{b}) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]].DATA_meminst[i : j] = b*{b}], f)

;; 4-runtime.watsup:154.1-154.77
def with_meminst : (state, memidx, meminst) -> state
  ;; 4-runtime.watsup:163.1-163.68
  def {f : frame, mi : meminst, s : store, x : idx} with_meminst(`%;%`(s, f), x, mi) = `%;%`(s[MEM_store[f.MODULE_frame.MEM_moduleinst[x]] = mi], f)

;; 4-runtime.watsup:155.1-155.82
def with_elem : (state, elemidx, ref*) -> state
  ;; 4-runtime.watsup:164.1-164.72
  def {f : frame, r* : ref*, s : store, x : idx} with_elem(`%;%`(s, f), x, r*{r}) = `%;%`(s[ELEM_store[f.MODULE_frame.ELEM_moduleinst[x]].ELEM_eleminst = r*{r}], f)

;; 4-runtime.watsup:156.1-156.82
def with_data : (state, dataidx, byte*) -> state
  ;; 4-runtime.watsup:165.1-165.72
  def {b* : byte*, f : frame, s : store, x : idx} with_data(`%;%`(s, f), x, b*{b}) = `%;%`(s[DATA_store[f.MODULE_frame.DATA_moduleinst[x]].DATA_datainst = b*{b}], f)

;; 4-runtime.watsup:167.1-167.49
def grow_table : (tableinst, nat, ref) -> tableinst
  ;; 4-runtime.watsup:169.1-172.57
  def {i : nat, i' : nat, j? : nat?, n : n, r : ref, r'* : ref*, reftype : reftype, ti : tableinst, ti' : tableinst} grow_table(ti, n, r) = ti'
    -- where {TYPE `%%`(`[%..%?]`(i, j?{j}), reftype), ELEM r'*{r'}} = ti
    -- where i' = (|r'*{r'}| + n)
    -- where ti' = {TYPE `%%`(`[%..%?]`(i', j?{j}), reftype), ELEM r'*{r'} :: r^n{}}

;; 4-runtime.watsup:168.1-168.41
def grow_memory : (meminst, nat) -> meminst
  ;; 4-runtime.watsup:173.1-176.66
  def {b* : byte*, i : nat, i' : nat, j? : nat?, mi : meminst, mi' : meminst, n : n} grow_memory(mi, n) = mi'
    -- where {TYPE `%I8`(`[%..%?]`(i, j?{j})), DATA b*{b}} = mi
    -- where i' = ((|b*{b}| / (64 * $Ki)) + n)
    -- where mi' = {TYPE `%I8`(`[%..%?]`(i', j?{j})), DATA b*{b} :: 0^((n * 64) * $Ki){}}

;; 4-runtime.watsup:189.1-192.21
rec {

;; 4-runtime.watsup:189.1-192.21
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

;; 5-numerics.watsup:13.1-13.28
def bytes_ : (nat, c_numtype) -> byte*

;; 5-numerics.watsup:14.1-14.47
def inverse_of_bytes_ : (nat, byte*) -> c_numtype

;; 6-reduction.watsup:4.1-4.63
relation Step_pure: `%*~>%*`(admininstr*, admininstr*)
  ;; 6-reduction.watsup:16.1-17.24
  rule unreachable:
    `%*~>%*`([UNREACHABLE_admininstr], [TRAP_admininstr])

  ;; 6-reduction.watsup:19.1-20.19
  rule nop:
    `%*~>%*`([NOP_admininstr], [])

  ;; 6-reduction.watsup:22.1-23.24
  rule drop {val : val}:
    `%*~>%*`([$admininstr_val(val) DROP_admininstr], [])

  ;; 6-reduction.watsup:26.1-28.16
  rule select-true {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [$admininstr_val(val_1)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:30.1-32.14
  rule select-false {c : c_numtype, t? : valtype?, val_1 : val, val_2 : val}:
    `%*~>%*`([$admininstr_val(val_1) $admininstr_val(val_2) CONST_admininstr(I32_numtype, c) SELECT_admininstr(t?{t})], [$admininstr_val(val_2)])
    -- if (c = 0)

  ;; 6-reduction.watsup:35.1-37.28
  rule block {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`($admininstr_val(val)^k{val} :: [BLOCK_admininstr(bt, instr*{instr})], [LABEL__admininstr(n, [], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- where `%->%`(t_1^k{t_1}, t_2^n{t_2}) = bt

  ;; 6-reduction.watsup:39.1-41.28
  rule loop {bt : blocktype, instr* : instr*, k : nat, n : n, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k}:
    `%*~>%*`($admininstr_val(val)^k{val} :: [LOOP_admininstr(bt, instr*{instr})], [LABEL__admininstr(k, [LOOP_instr(bt, instr*{instr})], $admininstr_val(val)^k{val} :: $admininstr_instr(instr)*{instr})])
    -- where `%->%`(t_1^k{t_1}, t_2^n{t_2}) = bt

  ;; 6-reduction.watsup:43.1-45.16
  rule if-true {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_1*{instr_1})])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:47.1-49.14
  rule if-false {bt : blocktype, c : c_numtype, instr_1* : instr*, instr_2* : instr*}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) IF_admininstr(bt, instr_1*{instr_1}, instr_2*{instr_2})], [BLOCK_admininstr(bt, instr_2*{instr_2})])
    -- if (c = 0)

  ;; 6-reduction.watsup:52.1-53.38
  rule label-vals {instr* : instr*, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr*{instr}, $admininstr_val(val)*{val})], $admininstr_val(val)*{val})

  ;; 6-reduction.watsup:57.1-58.69
  rule br-zero {instr* : instr*, instr'* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [BR_admininstr(0)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val} :: $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:60.1-61.65
  rule br-succ {instr* : instr*, instr'* : instr*, l : labelidx, n : n, val* : val*}:
    `%*~>%*`([LABEL__admininstr(n, instr'*{instr'}, $admininstr_val(val)*{val} :: [BR_admininstr(l + 1)] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [BR_admininstr(l)])

  ;; 6-reduction.watsup:64.1-66.16
  rule br_if-true {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [BR_admininstr(l)])
    -- if (c =/= 0)

  ;; 6-reduction.watsup:68.1-70.14
  rule br_if-false {c : c_numtype, l : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, c) BR_IF_admininstr(l)], [])
    -- if (c = 0)

  ;; 6-reduction.watsup:73.1-75.17
  rule br_table-lt {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l*{l}[i])])
    -- if (i < |l*{l}|)

  ;; 6-reduction.watsup:77.1-79.18
  rule br_table-ge {i : nat, l* : labelidx*, l' : labelidx}:
    `%*~>%*`([CONST_admininstr(I32_numtype, i) BR_TABLE_admininstr(l*{l}, l')], [BR_admininstr(l')])
    -- if (i >= |l*{l}|)

  ;; 6-reduction.watsup:102.1-103.35
  rule frame-vals {f : frame, n : n, val^n : val^n}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val)^n{val})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:105.1-106.55
  rule return-frame {f : frame, instr* : instr*, n : n, val^n : val^n, val'* : val*}:
    `%*~>%*`([FRAME__admininstr(n, f, $admininstr_val(val')*{val'} :: $admininstr_val(val)^n{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)^n{val})

  ;; 6-reduction.watsup:108.1-109.60
  rule return-label {instr* : instr*, instr'* : instr*, k : nat, val* : val*}:
    `%*~>%*`([LABEL__admininstr(k, instr'*{instr'}, $admininstr_val(val)*{val} :: [RETURN_admininstr] :: $admininstr_instr(instr)*{instr})], $admininstr_val(val)*{val} :: [RETURN_admininstr])

  ;; 6-reduction.watsup:112.1-114.33
  rule unop-val {c : c_numtype, c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [CONST_admininstr(nt, c)])
    -- where [c] = $unop(unop, nt, c_1)

  ;; 6-reduction.watsup:116.1-118.39
  rule unop-trap {c_1 : c_numtype, nt : numtype, unop : unop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) UNOP_admininstr(nt, unop)], [TRAP_admininstr])
    -- if ($unop(unop, nt, c_1) = [])

  ;; 6-reduction.watsup:121.1-123.40
  rule binop-val {binop : binop_numtype, c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [CONST_admininstr(nt, c)])
    -- where [c] = $binop(binop, nt, c_1, c_2)

  ;; 6-reduction.watsup:125.1-127.46
  rule binop-trap {binop : binop_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) BINOP_admininstr(nt, binop)], [TRAP_admininstr])
    -- if ($binop(binop, nt, c_1, c_2) = [])

  ;; 6-reduction.watsup:130.1-132.37
  rule testop {c : c_numtype, c_1 : c_numtype, nt : numtype, testop : testop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) TESTOP_admininstr(nt, testop)], [CONST_admininstr(I32_numtype, c)])
    -- where c = $testop(testop, nt, c_1)

  ;; 6-reduction.watsup:134.1-136.40
  rule relop {c : c_numtype, c_1 : c_numtype, c_2 : c_numtype, nt : numtype, relop : relop_numtype}:
    `%*~>%*`([CONST_admininstr(nt, c_1) CONST_admininstr(nt, c_2) RELOP_admininstr(nt, relop)], [CONST_admininstr(I32_numtype, c)])
    -- where c = $relop(relop, nt, c_1, c_2)

  ;; 6-reduction.watsup:139.1-140.70
  rule extend {c : c_numtype, n : n, nt : numtype, o0 : nat}:
    `%*~>%*`([CONST_admininstr(nt, c) EXTEND_admininstr(nt, n)], [CONST_admininstr(nt, $ext(n, o0, S_sx, c))])
    -- where ?(o0) = $size($valtype_numtype(nt))

  ;; 6-reduction.watsup:143.1-145.48
  rule cvtop-val {c : c_numtype, c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [CONST_admininstr(nt_2, c)])
    -- where [c] = $cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1)

  ;; 6-reduction.watsup:147.1-149.54
  rule cvtop-trap {c_1 : c_numtype, cvtop : cvtop, nt_1 : numtype, nt_2 : numtype, sx? : sx?}:
    `%*~>%*`([CONST_admininstr(nt_1, c_1) CVTOP_admininstr(nt_2, cvtop, nt_1, sx?{sx})], [TRAP_admininstr])
    -- if ($cvtop(nt_1, cvtop, nt_2, sx?{sx}, c_1) = [])

  ;; 6-reduction.watsup:156.1-158.28
  rule ref.is_null-true {rt : reftype, val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 1)])
    -- where REF.NULL_val(rt) = val

  ;; 6-reduction.watsup:160.1-162.15
  rule ref.is_null-false {val : val}:
    `%*~>%*`([$admininstr_val(val) REF.IS_NULL_admininstr], [CONST_admininstr(I32_numtype, 0)])
    -- otherwise

  ;; 6-reduction.watsup:171.1-172.47
  rule local.tee {val : val, x : idx}:
    `%*~>%*`([$admininstr_val(val) LOCAL.TEE_admininstr(x)], [$admininstr_val(val) $admininstr_val(val) LOCAL.SET_admininstr(x)])

;; 6-reduction.watsup:5.1-5.63
relation Step_read: `%~>%*`(config, admininstr*)
  ;; 6-reduction.watsup:82.1-83.47
  rule call {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CALL_admininstr(x)]), [CALL_ADDR_admininstr($funcaddr(z)[x])])
    -- if (x < |$funcaddr(z)|)

  ;; 6-reduction.watsup:85.1-89.17
  rule call_indirect-call {a : addr, ft : functype, ft' : functype, i : nat, instr* : instr*, t* : valtype*, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [CALL_ADDR_admininstr(a)])
    -- if (i < |$table(z, x).ELEM_tableinst|)
    -- where REF.FUNC_ADDR_ref(a) = $table(z, x).ELEM_tableinst[i]
    -- if (a < |$funcinst(z)|)
    -- where `FUNC%%*%`(ft', t*{t}, instr*{instr}) = $funcinst(z)[a].CODE_funcinst
    -- if (ft = ft')

  ;; 6-reduction.watsup:91.1-93.15
  rule call_indirect-trap {ft : functype, i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CALL_INDIRECT_admininstr(x, ft)]), [TRAP_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:95.1-99.52
  rule call_addr {a : addr, f : frame, func : func, instr* : instr*, k : nat, m : moduleinst, n : n, t* : valtype*, t_1^k : valtype^k, t_2^n : valtype^n, val^k : val^k, z : state, o0* : val*}:
    `%~>%*`(`%;%*`(z, $admininstr_val(val)^k{val} :: [CALL_ADDR_admininstr(a)]), [FRAME__admininstr(n, f, [LABEL__admininstr(n, [], $admininstr_instr(instr)*{instr})])])
    -- if (a < |$funcinst(z)|)
    -- where {MODULE m, CODE func} = $funcinst(z)[a]
    -- where `FUNC%%*%`(`%->%`(t_1^k{t_1}, t_2^n{t_2}), t*{t}, instr*{instr}) = func
    -- where |o0*{o0}| = |t*{t}|
    -- (if ($default_(t) = ?(o0)))*{t o0}
    -- where f = {LOCAL val^k{val} :: o0*{o0}, MODULE m}

  ;; 6-reduction.watsup:152.1-153.53
  rule ref.func {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [REF.FUNC_admininstr(x)]), [REF.FUNC_ADDR_admininstr($funcaddr(z)[x])])
    -- if (x < |$funcaddr(z)|)

  ;; 6-reduction.watsup:165.1-166.37
  rule local.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [LOCAL.GET_admininstr(x)]), [$admininstr_val($local(z, x))])

  ;; 6-reduction.watsup:175.1-176.45
  rule global.get {x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [GLOBAL.GET_admininstr(x)]), [$admininstr_val($global(z, x).VALUE_globalinst)])

  ;; 6-reduction.watsup:182.1-184.33
  rule table.get-trap {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [TRAP_admininstr])
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:186.1-188.32
  rule table.get-val {i : nat, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(x)]), [$admininstr_ref($table(z, x).ELEM_tableinst[i])])
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:199.1-201.32
  rule table.size {n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [TABLE.SIZE_admininstr(x)]), [CONST_admininstr(I32_numtype, n)])
    -- where n = |$table(z, x).ELEM_tableinst|

  ;; 6-reduction.watsup:214.1-216.39
  rule table.fill-trap {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [TRAP_admininstr])
    -- if ((i + n) > |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:218.1-221.14
  rule table.fill-zero {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:223.1-227.15
  rule table.fill-succ {i : nat, n : n, val : val, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) TABLE.FILL_admininstr(x)]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) TABLE.FILL_admininstr(x)])
    -- otherwise

  ;; 6-reduction.watsup:230.1-232.73
  rule table.copy-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$table(z, y).ELEM_tableinst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:234.1-237.14
  rule table.copy-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:239.1-244.15
  rule table.copy-le {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:246.1-250.15
  rule table.copy-gt {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.COPY_admininstr(x, y)]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) TABLE.GET_admininstr(y) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) TABLE.COPY_admininstr(x, y)])
    -- otherwise

  ;; 6-reduction.watsup:253.1-255.72
  rule table.init-trap {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [TRAP_admininstr])
    -- if (((i + n) > |$elem(z, y).ELEM_eleminst|) \/ ((j + n) > |$table(z, x).ELEM_tableinst|))

  ;; 6-reduction.watsup:257.1-260.14
  rule table.init-zero {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:262.1-266.15
  rule table.init-succ {i : nat, j : nat, n : n, x : idx, y : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, y)]), [CONST_admininstr(I32_numtype, j) $admininstr_ref($elem(z, y).ELEM_eleminst[i]) TABLE.SET_admininstr(x) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) TABLE.INIT_admininstr(x, y)])
    -- otherwise
    -- if (i < |$elem(z, y).ELEM_eleminst|)

  ;; 6-reduction.watsup:273.1-275.53
  rule load-num-trap {i : nat, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), n_A, n_O)]), [TRAP_admininstr])
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- if (((i + n_O) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:277.1-279.71
  rule load-num-val {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat, o1 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?(), n_A, n_O)]), [CONST_admininstr(nt, c)])
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- where ?(o1) = $size($valtype_numtype(nt))
    -- where c = $inverse_of_bytes_(o0, $mem(z, 0).DATA_meminst[(i + n_O) : (o1 / 8)])

  ;; 6-reduction.watsup:281.1-283.45
  rule load-pack-trap {i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), n_A, n_O)]), [TRAP_admininstr])
    -- if (((i + n_O) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:285.1-287.55
  rule load-pack-val {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, sx : sx, z : state, o0 : nat}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) LOAD_admininstr(nt, ?((n, sx)), n_A, n_O)]), [CONST_admininstr(nt, $ext(n, o0, sx, c))])
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- where c = $inverse_of_bytes_(n, $mem(z, 0).DATA_meminst[(i + n_O) : (n / 8)])

  ;; 6-reduction.watsup:307.1-309.44
  rule memory.size {n : n, z : state}:
    `%~>%*`(`%;%*`(z, [MEMORY.SIZE_admininstr]), [CONST_admininstr(I32_numtype, n)])
    -- where ((n * 64) * $Ki) = |$mem(z, 0).DATA_meminst|

  ;; 6-reduction.watsup:322.1-324.37
  rule memory.fill-trap {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [TRAP_admininstr])
    -- if ((i + n) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:326.1-329.14
  rule memory.fill-zero {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:331.1-335.15
  rule memory.fill-succ {i : nat, n : n, val : val, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_val(val) CONST_admininstr(I32_numtype, n) MEMORY.FILL_admininstr]), [CONST_admininstr(I32_numtype, i) $admininstr_val(val) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (i + 1)) $admininstr_val(val) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.FILL_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:338.1-340.69
  rule memory.copy-trap {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [TRAP_admininstr])
    -- if (((i + n) > |$mem(z, 0).DATA_meminst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:342.1-345.14
  rule memory.copy-zero {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:347.1-352.15
  rule memory.copy-le {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) LOAD_admininstr(I32_numtype, ?((8, U_sx)), 0, 0) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise
    -- if (j <= i)

  ;; 6-reduction.watsup:354.1-358.15
  rule memory.copy-gt {i : nat, j : nat, n : n, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.COPY_admininstr]), [CONST_admininstr(I32_numtype, ((j + n) - 1)) CONST_admininstr(I32_numtype, ((i + n) - 1)) LOAD_admininstr(I32_numtype, ?((8, U_sx)), 0, 0) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.COPY_admininstr])
    -- otherwise

  ;; 6-reduction.watsup:361.1-363.70
  rule memory.init-trap {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [TRAP_admininstr])
    -- if (((i + n) > |$data(z, x).DATA_datainst|) \/ ((j + n) > |$mem(z, 0).DATA_meminst|))

  ;; 6-reduction.watsup:365.1-368.14
  rule memory.init-zero {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [])
    -- otherwise
    -- if (n = 0)

  ;; 6-reduction.watsup:370.1-374.15
  rule memory.init-succ {i : nat, j : nat, n : n, x : idx, z : state}:
    `%~>%*`(`%;%*`(z, [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, i) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(x)]), [CONST_admininstr(I32_numtype, j) CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i]) STORE_admininstr(I32_numtype, ?(8), 0, 0) CONST_admininstr(I32_numtype, (j + 1)) CONST_admininstr(I32_numtype, (i + 1)) CONST_admininstr(I32_numtype, (n - 1)) MEMORY.INIT_admininstr(x)])
    -- otherwise
    -- if (i < |$data(z, x).DATA_datainst|)

;; 6-reduction.watsup:3.1-3.63
relation Step: `%~>%`(config, config)
  ;; 6-reduction.watsup:7.1-9.34
  rule pure {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_pure: `%*~>%*`($admininstr_instr(instr)*{instr}, $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:11.1-13.37
  rule read {instr* : instr*, instr'* : instr*, z : state}:
    `%~>%`(`%;%*`(z, $admininstr_instr(instr)*{instr}), `%;%*`(z, $admininstr_instr(instr')*{instr'}))
    -- Step_read: `%~>%*`(`%;%*`(z, $admininstr_instr(instr)*{instr}), $admininstr_instr(instr')*{instr'})

  ;; 6-reduction.watsup:168.1-169.60
  rule local.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) LOCAL.SET_admininstr(x)]), `%;%*`($with_local(z, x, val), []))

  ;; 6-reduction.watsup:178.1-179.62
  rule global.set {val : val, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_val(val) GLOBAL.SET_admininstr(x)]), `%;%*`($with_global(z, x, val), []))

  ;; 6-reduction.watsup:190.1-192.33
  rule table.set-trap {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (i >= |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:194.1-196.32
  rule table.set-val {i : nat, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) $admininstr_ref(ref) TABLE.SET_admininstr(x)]), `%;%*`($with_table(z, x, i, ref), []))
    -- if (i < |$table(z, x).ELEM_tableinst|)

  ;; 6-reduction.watsup:204.1-208.36
  rule table.grow-succeed {n : n, ref : ref, ti : tableinst, ti' : tableinst, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`($with_tableinst(z, x, ti'), [CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)]))
    -- where ti = $table(z, x)
    -- where ti' = $grow_table(ti, n, ref)
    -- Tabletype_ok: `|-%:OK`(ti'.TYPE_tableinst)

  ;; 6-reduction.watsup:210.1-211.64
  rule table.grow-fail {n : n, ref : ref, x : idx, z : state}:
    `%~>%`(`%;%*`(z, [$admininstr_ref(ref) CONST_admininstr(I32_numtype, n) TABLE.GROW_admininstr(x)]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 6-reduction.watsup:269.1-270.59
  rule elem.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [ELEM.DROP_admininstr(x)]), `%;%*`($with_elem(z, x, []), []))

  ;; 6-reduction.watsup:290.1-292.53
  rule store-num-trap {c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- if (((i + n_O) + (o0 / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:294.1-296.35
  rule store-num-val {b* : byte*, c : c_numtype, i : nat, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat, o1 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(), n_A, n_O)]), `%;%*`($with_mem(z, 0, (i + n_O), (o0 / 8), b*{b}), []))
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- where ?(o1) = $size($valtype_numtype(nt))
    -- where b*{b} = $bytes_(o1, c)

  ;; 6-reduction.watsup:298.1-300.45
  rule store-pack-trap {c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), n_A, n_O)]), `%;%*`(z, [TRAP_admininstr]))
    -- if (((i + n_O) + (n / 8)) > |$mem(z, 0).DATA_meminst|)

  ;; 6-reduction.watsup:302.1-304.50
  rule store-pack-val {b* : byte*, c : c_numtype, i : nat, n : n, n_A : n, n_O : n, nt : numtype, z : state, o0 : nat}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, i) CONST_admininstr(nt, c) STORE_admininstr(nt, ?(n), n_A, n_O)]), `%;%*`($with_mem(z, 0, (i + n_O), (n / 8), b*{b}), []))
    -- where ?(o0) = $size($valtype_numtype(nt))
    -- where b*{b} = $bytes_(n, $wrap_((o0, n), c))

  ;; 6-reduction.watsup:312.1-316.34
  rule memory.grow-succeed {mi : meminst, mi' : meminst, n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`($with_meminst(z, 0, mi'), [CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))]))
    -- where mi = $mem(z, 0)
    -- where mi' = $grow_memory(mi, n)
    -- Memtype_ok: `|-%:OK`(mi'.TYPE_meminst)

  ;; 6-reduction.watsup:318.1-319.59
  rule memory.grow-fail {n : n, z : state}:
    `%~>%`(`%;%*`(z, [CONST_admininstr(I32_numtype, n) MEMORY.GROW_admininstr]), `%;%*`(z, [CONST_admininstr(I32_numtype, - 1)]))

  ;; 6-reduction.watsup:377.1-378.59
  rule data.drop {x : idx, z : state}:
    `%~>%`(`%;%*`(z, [DATA.DROP_admininstr(x)]), `%;%*`($with_data(z, x, []), []))

;; 7-module.watsup:3.1-3.64
rec {

;; 7-module.watsup:3.1-3.64
def alloc_import : (moduleinst, import*, externval*) -> moduleinst
  ;; 7-module.watsup:5.1-5.43
  def {m : moduleinst} alloc_import(m, [], []) = m
  ;; 7-module.watsup:7.1-12.60
  def {externtype : externtype, externval : externval, externval'* : externval*, fa : funcaddr, functype : functype, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- where IMPORT(name, name', externtype) = import
    -- where FUNC_externtype(functype) = externtype
    -- where FUNC_externval(fa) = externval
    -- where m_new = m[FUNC_moduleinst =.. [fa]]
    -- where m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'})
  ;; 7-module.watsup:14.1-19.60
  def {externtype : externtype, externval : externval, externval'* : externval*, ga : globaladdr, globaltype : globaltype, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- where IMPORT(name, name', externtype) = import
    -- where GLOBAL_externtype(globaltype) = externtype
    -- where GLOBAL_externval(ga) = externval
    -- where m_new = m[GLOBAL_moduleinst =.. [ga]]
    -- where m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'})
  ;; 7-module.watsup:21.1-26.60
  def {externtype : externtype, externval : externval, externval'* : externval*, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, name : name, name' : name, ta : tableaddr, tabletype : tabletype} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- where IMPORT(name, name', externtype) = import
    -- where TABLE_externtype(tabletype) = externtype
    -- where TABLE_externval(ta) = externval
    -- where m_new = m[TABLE_moduleinst =.. [ta]]
    -- where m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'})
  ;; 7-module.watsup:28.1-33.60
  def {externtype : externtype, externval : externval, externval'* : externval*, import : import, import'* : import*, m : moduleinst, m_new : moduleinst, m_res : moduleinst, ma : memaddr, memtype : memtype, name : name, name' : name} alloc_import(m, [import] :: import'*{import'}, [externval] :: externval'*{externval'}) = m_res
    -- where IMPORT(name, name', externtype) = import
    -- where MEM_externtype(memtype) = externtype
    -- where MEM_externval(ma) = externval
    -- where m_new = m[MEM_moduleinst =.. [ma]]
    -- where m_res = $alloc_import(m_new, import'*{import'}, externval'*{externval'})
}

;; 7-module.watsup:36.1-36.51
rec {

;; 7-module.watsup:36.1-36.51
def alloc_func : (state, func*) -> (store, funcaddr*)
  ;; 7-module.watsup:38.1-38.48
  def {f : frame, s : store} alloc_func(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:40.1-44.56
  def {f : frame, fa : funcaddr, fa'* : funcaddr*, fi : funcinst, func : func, func'* : func*, s : store, s_new : store, s_res : store} alloc_func(`%;%`(s, f), [func] :: func'*{func'}) = (s_res, [fa] :: fa'*{fa'})
    -- where fi = {MODULE f.MODULE_frame, CODE func}
    -- where s_new = s[FUNC_store =.. [fi]]
    -- where (s_res, fa'*{fa'}) = $alloc_func(`%;%`(s_new, f), func'*{func'})
    -- where fa = |$funcinst(`%;%`(s, f))|
}

;; 7-module.watsup:47.1-47.57
rec {

;; 7-module.watsup:47.1-47.57
def alloc_global : (state, global*) -> (store, globaladdr*)
  ;; 7-module.watsup:49.1-49.50
  def {f : frame, s : store} alloc_global(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:51.1-57.60
  def {f : frame, ga : globaladdr, ga'* : globaladdr*, gi : globalinst, global : global, global'* : global*, globaltype : globaltype, instr* : instr*, s : store, s_new : store, s_res : store, val : val} alloc_global(`%;%`(s, f), [global] :: global'*{global'}) = (s_res, [ga] :: ga'*{ga'})
    -- where GLOBAL(globaltype, instr*{instr}) = global
    -- Step_read: `%~>%*`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr}), [$admininstr_val(val)])
    -- where gi = {TYPE globaltype, VALUE val}
    -- where s_new = s[GLOBAL_store =.. [gi]]
    -- where (s_res, ga'*{ga'}) = $alloc_global(`%;%`(s_new, f), global'*{global'})
    -- where ga = |$globalinst(`%;%`(s, f))|
}

;; 7-module.watsup:60.1-60.54
rec {

;; 7-module.watsup:60.1-60.54
def alloc_table : (state, table*) -> (store, tableaddr*)
  ;; 7-module.watsup:62.1-62.49
  def {f : frame, s : store} alloc_table(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:64.1-70.58
  def {f : frame, i : nat, j? : nat?, reftype : reftype, s : store, s_new : store, s_res : store, ta : tableaddr, ta'* : tableaddr*, table : table, table'* : table*, tabletype : tabletype, ti : tableinst} alloc_table(`%;%`(s, f), [table] :: table'*{table'}) = (s_res, [ta] :: ta'*{ta'})
    -- where TABLE(tabletype) = table
    -- where `%%`(`[%..%?]`(i, j?{j}), reftype) = tabletype
    -- where ti = {TYPE tabletype, ELEM REF.NULL_ref(reftype)^i{}}
    -- where s_new = s[TABLE_store =.. [ti]]
    -- where (s_res, ta'*{ta'}) = $alloc_table(`%;%`(s_new, f), table'*{table'})
    -- where ta = |$tableinst(`%;%`(s, f))|
}

;; 7-module.watsup:73.1-73.48
rec {

;; 7-module.watsup:73.1-73.48
def alloc_mem : (state, mem*) -> (store, memaddr*)
  ;; 7-module.watsup:75.1-75.47
  def {f : frame, s : store} alloc_mem(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:77.1-83.54
  def {f : frame, i : nat, j? : nat?, ma : memaddr, ma'* : memaddr*, mem : mem, mem'* : mem*, memtype : memtype, mi : meminst, s : store, s_new : store, s_res : store} alloc_mem(`%;%`(s, f), [mem] :: mem'*{mem'}) = (s_res, [ma] :: ma'*{ma'})
    -- where MEMORY(memtype) = mem
    -- where `%I8`(`[%..%?]`(i, j?{j})) = memtype
    -- where mi = {TYPE memtype, DATA 0^((i * 64) * $Ki){}}
    -- where s_new = s[MEM_store =.. [mi]]
    -- where (s_res, ma'*{ma'}) = $alloc_mem(`%;%`(s_new, f), mem'*{mem'})
    -- where ma = |$meminst(`%;%`(s, f))|
}

;; 7-module.watsup:86.1-86.51
rec {

;; 7-module.watsup:86.1-86.51
def alloc_elem : (state, elem*) -> (store, elemaddr*)
  ;; 7-module.watsup:88.1-88.48
  def {f : frame, s : store} alloc_elem(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:90.1-96.56
  def {ea : elemaddr, ea'* : elemaddr*, ei : eleminst, elem : elem, elem'* : elem*, elemmode? : elemmode?, f : frame, instr** : instr**, ref* : ref*, reftype : reftype, s : store, s_new : store, s_res : store} alloc_elem(`%;%`(s, f), [elem] :: elem'*{elem'}) = (s_res, [ea] :: ea'*{ea'})
    -- where `ELEM%%*%?`(reftype, instr*{instr}*{instr}, elemmode?{elemmode}) = elem
    -- (Step_read: `%~>%*`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr}), [$admininstr_ref(ref)]))*{instr ref}
    -- where ei = {TYPE reftype, ELEM ref*{ref}}
    -- where s_new = s[ELEM_store =.. [ei]]
    -- where (s_res, ea'*{ea'}) = $alloc_elem(`%;%`(s_new, f), elem'*{elem'})
    -- where ea = |$eleminst(`%;%`(s, f))|
}

;; 7-module.watsup:99.1-99.51
rec {

;; 7-module.watsup:99.1-99.51
def alloc_data : (state, data*) -> (store, dataaddr*)
  ;; 7-module.watsup:101.1-101.48
  def {f : frame, s : store} alloc_data(`%;%`(s, f), []) = (s, [])
  ;; 7-module.watsup:103.1-108.56
  def {byte* : byte*, da : dataaddr, da'* : dataaddr*, data : data, data'* : data*, datamode? : datamode?, di : datainst, f : frame, s : store, s_new : store, s_res : store} alloc_data(`%;%`(s, f), [data] :: data'*{data'}) = (s_res, [da] :: da'*{da'})
    -- where `DATA%*%?`(byte*{byte}, datamode?{datamode}) = data
    -- where di = {DATA byte*{byte}}
    -- where s_new = s[DATA_store =.. [di]]
    -- where (s_res, da'*{da'}) = $alloc_data(`%;%`(s_new, f), data'*{data'})
    -- where da = |$datainst(`%;%`(s, f))|
}

;; 7-module.watsup:111.1-111.62
rec {

;; 7-module.watsup:111.1-111.62
def replace_moduleinst : (store, funcaddr*, moduleinst) -> store
  ;; 7-module.watsup:113.1-113.43
  def {m : moduleinst, s : store} replace_moduleinst(s, [], m) = s
  ;; 7-module.watsup:115.1-117.52
  def {fa : funcaddr, fa'* : funcaddr*, m : moduleinst, s : store, s_new : store, s_res : store} replace_moduleinst(s, [fa] :: fa'*{fa'}, m) = s_res
    -- where s_new = s[FUNC_store[fa].MODULE_funcinst = m]
    -- where s_res = $replace_moduleinst(s_new, fa'*{fa'}, m)
}

;; 7-module.watsup:120.1-120.51
def alloc_export : (moduleinst, export) -> exportinst
  ;; 7-module.watsup:122.1-126.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- where EXPORT(name, externuse) = export
    -- where FUNC_externuse(x) = externuse
    -- where externval = FUNC_externval(m.FUNC_moduleinst[x])
    -- where xi = {NAME name, VALUE externval}
  ;; 7-module.watsup:128.1-132.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- where EXPORT(name, externuse) = export
    -- where GLOBAL_externuse(x) = externuse
    -- where externval = GLOBAL_externval(m.GLOBAL_moduleinst[x])
    -- where xi = {NAME name, VALUE externval}
  ;; 7-module.watsup:134.1-138.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- where EXPORT(name, externuse) = export
    -- where TABLE_externuse(x) = externuse
    -- where externval = TABLE_externval(m.TABLE_moduleinst[x])
    -- where xi = {NAME name, VALUE externval}
  ;; 7-module.watsup:140.1-144.44
  def {export : export, externuse : externuse, externval : externval, m : moduleinst, name : name, x : idx, xi : exportinst} alloc_export(m, export) = xi
    -- where EXPORT(name, externuse) = export
    -- where MEM_externuse(x) = externuse
    -- where externval = MEM_externval(m.MEM_moduleinst[x])
    -- where xi = {NAME name, VALUE externval}

;; 7-module.watsup:147.1-147.67
def alloc_module : (store, module, externval*) -> (store, moduleinst)
  ;; 7-module.watsup:149.1-163.56
  def {da* : dataaddr*, data* : data*, ea* : elemaddr*, elem* : elem*, export* : export*, externval* : externval*, f : frame, fa* : funcaddr*, func* : func*, ga* : globaladdr*, global* : global*, import* : import*, m_ex : moduleinst, m_im : moduleinst, m_init : moduleinst, m_res : moduleinst, ma* : memaddr*, mem* : mem*, module : module, s : store, s_data : store, s_elem : store, s_func : store, s_global : store, s_mem : store, s_res : store, s_table : store, start? : start?, ta* : tableaddr*, table* : table*, xi* : exportinst*} alloc_module(s, module, externval*{externval}) = (s_res, m_res)
    -- where `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, start?{start}, export*{export}) = module
    -- where m_init = {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []}
    -- where m_im = $alloc_import(m_init, import*{import}, externval*{externval})
    -- where f = {LOCAL [], MODULE m_im}
    -- where (s_func, fa*{fa}) = $alloc_func(`%;%`(s, f), func*{func})
    -- where (s_global, ga*{ga}) = $alloc_global(`%;%`(s_func, f), global*{global})
    -- where (s_table, ta*{ta}) = $alloc_table(`%;%`(s_global, f), table*{table})
    -- where (s_mem, ma*{ma}) = $alloc_mem(`%;%`(s_table, f), mem*{mem})
    -- where (s_elem, ea*{ea}) = $alloc_elem(`%;%`(s_mem, f), elem*{elem})
    -- where (s_data, da*{da}) = $alloc_data(`%;%`(s_elem, f), data*{data})
    -- where m_ex = m_im ++ {FUNC fa*{fa}, GLOBAL ga*{ga}, TABLE ta*{ta}, MEM ma*{ma}, ELEM ea*{ea}, DATA da*{da}, EXPORT []}
    -- where xi*{xi} = $alloc_export(m_ex, export)*{export}
    -- where m_res = m_ex[EXPORT_moduleinst = xi*{xi}]
    -- where s_res = $replace_moduleinst(s_data, fa*{fa}, m_res)

;; 7-module.watsup:166.1-166.41
rec {

;; 7-module.watsup:166.1-166.41
def run_elem : (state, elem*, idx) -> state
  ;; 7-module.watsup:168.1-168.41
  def {f : frame, i : nat, s : store} run_elem(`%;%`(s, f), [], i) = `%;%`(s, f)
  ;; 7-module.watsup:170.1-172.59
  def {elem : elem, elem'* : elem*, expr* : expr*, f : frame, f_res : frame, i : nat, reftype : reftype, s : store, s_res : store} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- where `ELEM%%*%?`(reftype, expr*{expr}, ?()) = elem
    -- where `%;%`(s_res, f_res) = $run_elem(`%;%`(s, f), elem'*{elem'}, (i + 1))
  ;; 7-module.watsup:174.1-179.67
  def {elem : elem, elem'* : elem*, elemmode : elemmode, expr* : expr*, f : frame, f_new : frame, f_res : frame, i : nat, instr* : instr*, n : n, reftype : reftype, s : store, s_new : store, s_res : store, x : idx} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- where `ELEM%%*%?`(reftype, expr*{expr}, ?(elemmode)) = elem
    -- where TABLE_elemmode(x, instr*{instr}) = elemmode
    -- where n = |expr*{expr}|
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr} :: [CONST_admininstr(I32_numtype, 0) CONST_admininstr(I32_numtype, n) TABLE.INIT_admininstr(x, i) ELEM.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- where `%;%`(s_res, f_res) = $run_elem(`%;%`(s_new, f_new), elem'*{elem'}, (i + 1))
  ;; 7-module.watsup:181.1-185.67
  def {elem : elem, elem'* : elem*, elemmode : elemmode, expr* : expr*, f : frame, f_new : frame, f_res : frame, i : nat, reftype : reftype, s : store, s_new : store, s_res : store} run_elem(`%;%`(s, f), [elem] :: elem'*{elem'}, i) = `%;%`(s_res, f_res)
    -- where `ELEM%%*%?`(reftype, expr*{expr}, ?(elemmode)) = elem
    -- if (elemmode = DECLARE_elemmode)
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), [ELEM.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- where `%;%`(s_res, f_res) = $run_elem(`%;%`(s_new, f_new), elem'*{elem'}, (i + 1))
}

;; 7-module.watsup:188.1-188.41
rec {

;; 7-module.watsup:188.1-188.41
def run_data : (state, data*, idx) -> state
  ;; 7-module.watsup:190.1-190.41
  def {f : frame, i : nat, s : store} run_data(`%;%`(s, f), [], i) = `%;%`(s, f)
  ;; 7-module.watsup:192.1-194.59
  def {byte* : byte*, data : data, data'* : data*, f : frame, f_res : frame, i : nat, s : store, s_res : store} run_data(`%;%`(s, f), [data] :: data'*{data'}, i) = `%;%`(s_res, f_res)
    -- where `%;%`(s_res, f_res) = $run_data(`%;%`(s, f), data'*{data'}, (i + 1))
    -- where `DATA%*%?`(byte*{byte}, ?()) = data
  ;; 7-module.watsup:196.1-201.67
  def {byte* : byte*, data : data, data'* : data*, datamode : datamode, f : frame, f_new : frame, f_res : frame, i : nat, instr* : instr*, n : n, s : store, s_new : store, s_res : store} run_data(`%;%`(s, f), [data] :: data'*{data'}, i) = `%;%`(s_res, f_res)
    -- where `DATA%*%?`(byte*{byte}, ?(datamode)) = data
    -- where n = |byte*{byte}|
    -- where MEMORY_datamode(0, instr*{instr}) = datamode
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_instr(instr)*{instr} :: [CONST_admininstr(I32_numtype, 0) CONST_admininstr(I32_numtype, n) MEMORY.INIT_admininstr(i) DATA.DROP_admininstr(i)]), `%;%*`(`%;%`(s_new, f_new), []))
    -- where `%;%`(s_res, f_res) = $run_data(`%;%`(s_new, f_new), data'*{data'}, (i + 1))
}

;; 7-module.watsup:204.1-204.68
def instantiation : (store, module, externval*) -> (store, moduleinst)
  ;; 7-module.watsup:206.1-211.61
  def {data* : data*, elem* : elem*, export* : export*, externval* : externval*, f : frame, f_elem : frame, f_res : frame, func* : func*, global* : global*, import* : import*, m : moduleinst, mem* : mem*, module : module, s : store, s_alloc : store, s_elem : store, s_res : store, table* : table*} instantiation(s, module, externval*{externval}) = (s_res, m)
    -- where `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, ?(), export*{export}) = module
    -- where (s_alloc, m) = $alloc_module(s, module, externval*{externval})
    -- where f = {LOCAL [], MODULE m}
    -- where `%;%`(s_elem, f_elem) = $run_elem(`%;%`(s_alloc, f), elem*{elem}, 0)
    -- where `%;%`(s_res, f_res) = $run_data(`%;%`(s_elem, f_elem), data*{data}, 0)
  ;; 7-module.watsup:213.1-220.62
  def {data* : data*, elem* : elem*, export* : export*, externval* : externval*, f : frame, f_data : frame, f_elem : frame, f_res : frame, func* : func*, global* : global*, import* : import*, m : moduleinst, mem* : mem*, module : module, s : store, s_alloc : store, s_data : store, s_elem : store, s_res : store, start : start, table* : table*, x : idx} instantiation(s, module, externval*{externval}) = (s_res, m)
    -- where `MODULE%*%*%*%*%*%*%*%?%*`(import*{import}, func*{func}, global*{global}, table*{table}, mem*{mem}, elem*{elem}, data*{data}, ?(start), export*{export}) = module
    -- where (s_alloc, m) = $alloc_module(s, module, externval*{externval})
    -- where f = {LOCAL [], MODULE m}
    -- where `%;%`(s_elem, f_elem) = $run_elem(`%;%`(s_alloc, f), elem*{elem}, 0)
    -- where `%;%`(s_data, f_data) = $run_data(`%;%`(s_elem, f_elem), data*{data}, 0)
    -- where START(x) = start
    -- Step: `%~>%`(`%;%*`(`%;%`(s_data, f_data), [CALL_admininstr(x)]), `%;%*`(`%;%`(s_res, f_res), []))

;; 7-module.watsup:223.1-223.55
def invocation : (store, funcaddr, val*) -> (store, val*)
  ;; 7-module.watsup:225.1-232.55
  def {expr : expr, f : frame, f' : frame, fa : funcaddr, functype : functype, m : moduleinst, s : store, s' : store, val* : val*, val'* : val*, valtype* : valtype*, valtype'* : valtype*} invocation(s, fa, val*{val}) = (s', val'*{val'})
    -- where |valtype*{valtype}| = |val*{val}|
    -- where m = {FUNC [], GLOBAL [], TABLE [], MEM [], ELEM [], DATA [], EXPORT []}
    -- where f = {LOCAL [], MODULE m}
    -- where `FUNC%%*%`(functype, valtype*{valtype}, expr) = $funcinst(`%;%`(s, f))[fa].CODE_funcinst
    -- Step: `%~>%`(`%;%*`(`%;%`(s, f), $admininstr_val(val)*{val} :: [CALL_ADDR_admininstr(fa)]), `%;%*`(`%;%`(s', f'), $admininstr_val(val')*{val'}))
    -- where |valtype'*{valtype'}| = |val'*{val'}|
    -- where `%->%`(valtype*{valtype}, valtype'*{valtype'}) = functype

== IL Validation...
== Complete.
```
