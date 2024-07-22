# Preview

```sh
$ for v in 1 2 3; do ( \
>   echo "Generating prose for Wasm $v.0..." && \
>   cd ../spec/wasm-$v.0 && \
>   ../../src/exe-watsup/main.exe *.watsup -v -l --prose \
> ) done
Generating prose for Wasm 1.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Prose Generation...
=================
 Generated prose
=================
validation_of_NOP
- The instruction is valid with type ([] -> []).

validation_of_UNREACHABLE
- The instruction is valid with type (t_1* -> t_2*).

validation_of_DROP
- The instruction is valid with type ([t] -> []).

validation_of_SELECT
- The instruction is valid with type ([t, t, I32] -> [t]).

validation_of_BLOCK t? instr*
- Under the context C with .LABELS prepended by [t?], instr* must be valid with type ([] -> t?).
- The instruction is valid with type ([] -> t?).

validation_of_LOOP t? instr*
- Under the context C with .LABELS prepended by [?()], instr* must be valid with type ([] -> []).
- The instruction is valid with type ([] -> t?).

validation_of_IF t? instr_1* instr_2*
- Under the context C with .LABELS prepended by [t?], instr_1* must be valid with type ([] -> t?).
- Under the context C with .LABELS prepended by [t?], instr_2* must be valid with type ([] -> t?).
- The instruction is valid with type ([I32] -> t?).

validation_of_BR l
- |C.LABELS| must be greater than l.
- Let t? be C.LABELS[l].
- The instruction is valid with type (t_1* ++ t? -> t_2*).

validation_of_BR_IF l
- |C.LABELS| must be greater than l.
- Let t? be C.LABELS[l].
- The instruction is valid with type (t? ++ [I32] -> t?).

validation_of_BR_TABLE l* l'
- |C.LABELS| must be greater than l'.
- For all l in l*,
  - |C.LABELS| must be greater than l.
- For all l in l*,
  - Let t? be C.LABELS[l].
- t? must be equal to C.LABELS[l'].
- The instruction is valid with type (t_1* ++ t? -> t_2*).

validation_of_CALL x
- |C.FUNCS| must be greater than x.
- Let (t_1* -> t_2?) be C.FUNCS[x].
- The instruction is valid with type (t_1* -> t_2?).

validation_of_CALL_INDIRECT x
- |C.TYPES| must be greater than x.
- Let (t_1* -> t_2?) be C.TYPES[x].
- The instruction is valid with type (t_1* ++ [I32] -> t_2?).

validation_of_RETURN
- Let ?(t?) be C.RETURN.
- The instruction is valid with type (t_1* ++ t? -> t_2*).

validation_of_CONST t c_t
- The instruction is valid with type ([] -> [t]).

validation_of_UNOP t unop_t
- The instruction is valid with type ([t] -> [t]).

validation_of_BINOP t binop_t
- The instruction is valid with type ([t, t] -> [t]).

validation_of_TESTOP t testop_t
- The instruction is valid with type ([t] -> [I32]).

validation_of_RELOP t relop_t
- The instruction is valid with type ([t, t] -> [I32]).

validation_of_CVTOP nt_1 nt_2 REINTERPRET
- $size(nt_1) must be equal to $size(nt_2).
- The instruction is valid with type ([nt_2] -> [nt_1]).

validation_of_LOCAL.GET x
- |C.LOCALS| must be greater than x.
- Let t be C.LOCALS[x].
- The instruction is valid with type ([] -> [t]).

validation_of_LOCAL.SET x
- |C.LOCALS| must be greater than x.
- Let t be C.LOCALS[x].
- The instruction is valid with type ([t] -> []).

validation_of_LOCAL.TEE x
- |C.LOCALS| must be greater than x.
- Let t be C.LOCALS[x].
- The instruction is valid with type ([t] -> [t]).

validation_of_GLOBAL.GET x
- |C.GLOBALS| must be greater than x.
- Let (mut, t) be C.GLOBALS[x].
- The instruction is valid with type ([] -> [t]).

validation_of_GLOBAL.SET x
- |C.GLOBALS| must be greater than x.
- Let ((MUT ?(())), t) be C.GLOBALS[x].
- The instruction is valid with type ([t] -> []).

validation_of_MEMORY.SIZE
- |C.MEMS| must be greater than 0.
- Let mt be C.MEMS[0].
- The instruction is valid with type ([] -> [I32]).

validation_of_MEMORY.GROW
- |C.MEMS| must be greater than 0.
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32] -> [I32]).

validation_of_LOAD nt (n, sx)? memarg
- |C.MEMS| must be greater than 0.
- ((sx? is ?())) if and only if ((n? is ?())).
- (2 ^ memarg.ALIGN) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ memarg.ALIGN) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32] -> [nt]).

validation_of_STORE nt n? memarg
- |C.MEMS| must be greater than 0.
- (2 ^ memarg.ALIGN) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ memarg.ALIGN) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32, nt] -> []).

Ki
1. Return 1024.

min n_u0 n_u1
1. If (n_u0 is 0), then:
  a. Return 0.
2. If (n_u1 is 0), then:
  a. Return 0.
3. Assert: Due to validation, (n_u0 ≥ 1).
4. Let i be (n_u0 - 1).
5. Assert: Due to validation, (n_u1 ≥ 1).
6. Let j be (n_u1 - 1).
7. Return $min(i, j).

sum n_u0*
1. If (n_u0* is []), then:
  a. Return 0.
2. Let [n] ++ n'* be n_u0*.
3. Return (n + $sum(n'*)).

concat_ X_u0*
1. If (X_u0* is []), then:
  a. Return [].
2. Let [w*] ++ w'** be X_u0*.
3. Return w* ++ $concat_(w'**).

signif N_u0
1. If (N_u0 is 32), then:
  a. Return 23.
2. Assert: Due to validation, (N_u0 is 64).
3. Return 52.

expon N_u0
1. If (N_u0 is 32), then:
  a. Return 8.
2. Assert: Due to validation, (N_u0 is 64).
3. Return 11.

M N
1. Return $signif(N).

E N
1. Return $expon(N).

fzero N
1. Return (POS (SUBNORM 0)).

fone N
1. Return (POS (NORM 1 0)).

canon_ N
1. Return (2 ^ ($signif(N) - 1)).

utf8 char_u0*
1. If (|char_u0*| is 1), then:
  a. Let [ch] be char_u0*.
  b. If (ch < 128), then:
    1) Let b be ch.
    2) Return [b].
  c. If ((128 ≤ ch) and ((ch < 2048) and (ch ≥ (b_2 - 128)))), then:
    1) Let ((2 ^ 6) · (b_1 - 192)) be (ch - (b_2 - 128)).
    2) Return [b_1, b_2].
  d. If ((((2048 ≤ ch) and (ch < 55296)) or ((57344 ≤ ch) and (ch < 65536))) and (ch ≥ (b_3 - 128))), then:
    1) Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · (b_2 - 128))) be (ch - (b_3 - 128)).
    2) Return [b_1, b_2, b_3].
  e. If ((65536 ≤ ch) and ((ch < 69632) and (ch ≥ (b_4 - 128)))), then:
    1) Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · (b_2 - 128))) + ((2 ^ 6) · (b_3 - 128))) be (ch - (b_4 - 128)).
    2) Return [b_1, b_2, b_3, b_4].
2. Let ch* be char_u0*.
3. Return $concat_($utf8([ch])*).

size valty_u0
1. If (valty_u0 is I32), then:
  a. Return 32.
2. If (valty_u0 is I64), then:
  a. Return 64.
3. If (valty_u0 is F32), then:
  a. Return 32.
4. If (valty_u0 is F64), then:
  a. Return 64.

funcsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xt* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC ft) be y_0.
  b. Return [ft] ++ $funcsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $funcsxt(xt*).

globalsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xt* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be y_0.
  b. Return [gt] ++ $globalsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $globalsxt(xt*).

tablesxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xt* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE tt) be y_0.
  b. Return [tt] ++ $tablesxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $tablesxt(xt*).

memsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xt* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM mt) be y_0.
  b. Return [mt] ++ $memsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $memsxt(xt*).

memarg0
1. Return { ALIGN: 0; OFFSET: 0; }.

signed N i
1. If (0 ≤ (2 ^ (N - 1))), then:
  a. Return i.
2. Assert: Due to validation, ((2 ^ (N - 1)) ≤ i).
3. Assert: Due to validation, (i < (2 ^ N)).
4. Return (i - (2 ^ N)).

invsigned N ii
1. Let j be $signed_1^-1(N, ii).
2. Return j.

unop valty_u1 unop__u0 val__u3
1. If ((unop__u0 is CLZ) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN be val__u3.
  c. Return [$iclz($size(Inn), iN)].
2. If ((unop__u0 is CTZ) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN be val__u3.
  c. Return [$ictz($size(Inn), iN)].
3. If ((unop__u0 is POPCNT) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN be val__u3.
  c. Return [$ipopcnt($size(Inn), iN)].
4. If ((unop__u0 is ABS) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN be val__u3.
  c. Return [$fabs($size(Fnn), fN)].
5. If ((unop__u0 is NEG) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN be val__u3.
  c. Return [$fneg($size(Fnn), fN)].
6. If ((unop__u0 is SQRT) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN be val__u3.
  c. Return [$fsqrt($size(Fnn), fN)].
7. If ((unop__u0 is CEIL) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN be val__u3.
  c. Return [$fceil($size(Fnn), fN)].
8. If ((unop__u0 is FLOOR) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN be val__u3.
  c. Return [$ffloor($size(Fnn), fN)].
9. If ((unop__u0 is TRUNC) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN be val__u3.
  c. Return [$ftrunc($size(Fnn), fN)].
10. Assert: Due to validation, (unop__u0 is NEAREST).
11. Assert: Due to validation, the type of valty_u1 is Fnn.
12. Let Fnn be valty_u1.
13. Let fN be val__u3.
14. Return [$fnearest($size(Fnn), fN)].

binop valty_u1 binop_u0 val__u3 val__u5
1. If ((binop_u0 is ADD) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$iadd($size(Inn), iN_1, iN_2)].
2. If ((binop_u0 is SUB) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$isub($size(Inn), iN_1, iN_2)].
3. If ((binop_u0 is MUL) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$imul($size(Inn), iN_1, iN_2)].
4. If the type of valty_u1 is Inn, then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. If binop_u0 is of the case DIV, then:
    1) Let (DIV sx) be binop_u0.
    2) Return [$idiv($size(Inn), sx, iN_1, iN_2)].
  e. If binop_u0 is of the case REM, then:
    1) Let (REM sx) be binop_u0.
    2) Return [$irem($size(Inn), sx, iN_1, iN_2)].
5. If ((binop_u0 is AND) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$iand($size(Inn), iN_1, iN_2)].
6. If ((binop_u0 is OR) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$ior($size(Inn), iN_1, iN_2)].
7. If ((binop_u0 is XOR) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$ixor($size(Inn), iN_1, iN_2)].
8. If ((binop_u0 is SHL) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$ishl($size(Inn), iN_1, iN_2)].
9. If the type of valty_u1 is Inn, then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. If binop_u0 is of the case SHR, then:
    1) Let (SHR sx) be binop_u0.
    2) Return [$ishr($size(Inn), sx, iN_1, iN_2)].
10. If ((binop_u0 is ROTL) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$irotl($size(Inn), iN_1, iN_2)].
11. If ((binop_u0 is ROTR) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return [$irotr($size(Inn), iN_1, iN_2)].
12. If ((binop_u0 is ADD) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return [$fadd($size(Fnn), fN_1, fN_2)].
13. If ((binop_u0 is SUB) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return [$fsub($size(Fnn), fN_1, fN_2)].
14. If ((binop_u0 is MUL) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return [$fmul($size(Fnn), fN_1, fN_2)].
15. If ((binop_u0 is DIV) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return [$fdiv($size(Fnn), fN_1, fN_2)].
16. If ((binop_u0 is MIN) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return [$fmin($size(Fnn), fN_1, fN_2)].
17. If ((binop_u0 is MAX) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return [$fmax($size(Fnn), fN_1, fN_2)].
18. Assert: Due to validation, (binop_u0 is COPYSIGN).
19. Assert: Due to validation, the type of valty_u1 is Fnn.
20. Let Fnn be valty_u1.
21. Let fN_1 be val__u3.
22. Let fN_2 be val__u5.
23. Return [$fcopysign($size(Fnn), fN_1, fN_2)].

testop Inn EQZ iN
1. Return $ieqz($size(Inn), iN).

relop valty_u1 relop_u0 val__u3 val__u5
1. If ((relop_u0 is EQ) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return $ieq($size(Inn), iN_1, iN_2).
2. If ((relop_u0 is NE) and the type of valty_u1 is Inn), then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. Return $ine($size(Inn), iN_1, iN_2).
3. If the type of valty_u1 is Inn, then:
  a. Let Inn be valty_u1.
  b. Let iN_1 be val__u3.
  c. Let iN_2 be val__u5.
  d. If relop_u0 is of the case LT, then:
    1) Let (LT sx) be relop_u0.
    2) Return $ilt($size(Inn), sx, iN_1, iN_2).
  e. If relop_u0 is of the case GT, then:
    1) Let (GT sx) be relop_u0.
    2) Return $igt($size(Inn), sx, iN_1, iN_2).
  f. If relop_u0 is of the case LE, then:
    1) Let (LE sx) be relop_u0.
    2) Return $ile($size(Inn), sx, iN_1, iN_2).
  g. If relop_u0 is of the case GE, then:
    1) Let (GE sx) be relop_u0.
    2) Return $ige($size(Inn), sx, iN_1, iN_2).
4. If ((relop_u0 is EQ) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $feq($size(Fnn), fN_1, fN_2).
5. If ((relop_u0 is NE) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $fne($size(Fnn), fN_1, fN_2).
6. If ((relop_u0 is LT) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $flt($size(Fnn), fN_1, fN_2).
7. If ((relop_u0 is GT) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $fgt($size(Fnn), fN_1, fN_2).
8. If ((relop_u0 is LE) and the type of valty_u1 is Fnn), then:
  a. Let Fnn be valty_u1.
  b. Let fN_1 be val__u3.
  c. Let fN_2 be val__u5.
  d. Return $fle($size(Fnn), fN_1, fN_2).
9. Assert: Due to validation, (relop_u0 is GE).
10. Assert: Due to validation, the type of valty_u1 is Fnn.
11. Let Fnn be valty_u1.
12. Let fN_1 be val__u3.
13. Let fN_2 be val__u5.
14. Return $fge($size(Fnn), fN_1, fN_2).

cvtop valty_u0 valty_u1 cvtop_u2 val__u4
1. If ((valty_u0 is I32) and (valty_u1 is I64)), then:
  a. Let iN be val__u4.
  b. If cvtop_u2 is of the case EXTEND, then:
    1) Let (EXTEND sx) be cvtop_u2.
    2) Return [$ext(32, 64, sx, iN)].
2. If ((valty_u0 is I64) and ((valty_u1 is I32) and (cvtop_u2 is WRAP))), then:
  a. Let iN be val__u4.
  b. Return [$wrap(64, 32, iN)].
3. If the type of valty_u0 is Fnn, then:
  a. Let Fnn be valty_u0.
  b. If the type of valty_u1 is Inn, then:
    1) Let Inn be valty_u1.
    2) Let fN be val__u4.
    3) If cvtop_u2 is of the case TRUNC, then:
      a) Let (TRUNC sx) be cvtop_u2.
      b) Return [$trunc($size(Fnn), $size(Inn), sx, fN)].
4. If ((valty_u0 is F32) and ((valty_u1 is F64) and (cvtop_u2 is PROMOTE))), then:
  a. Let fN be val__u4.
  b. Return [$promote(32, 64, fN)].
5. If ((valty_u0 is F64) and ((valty_u1 is F32) and (cvtop_u2 is DEMOTE))), then:
  a. Let fN be val__u4.
  b. Return [$demote(64, 32, fN)].
6. If the type of valty_u1 is Fnn, then:
  a. Let Fnn be valty_u1.
  b. If the type of valty_u0 is Inn, then:
    1) Let Inn be valty_u0.
    2) Let iN be val__u4.
    3) If cvtop_u2 is of the case CONVERT, then:
      a) Let (CONVERT sx) be cvtop_u2.
      b) Return [$convert($size(Inn), $size(Fnn), sx, iN)].
7. Assert: Due to validation, (cvtop_u2 is REINTERPRET).
8. If the type of valty_u1 is Fnn, then:
  a. Let Fnn be valty_u1.
  b. If the type of valty_u0 is Inn, then:
    1) Let Inn be valty_u0.
    2) Let iN be val__u4.
    3) If ($size(Inn) is $size(Fnn)), then:
      a) Return [$reinterpret(Inn, Fnn, iN)].
9. Assert: Due to validation, the type of valty_u0 is Fnn.
10. Let Fnn be valty_u0.
11. Assert: Due to validation, the type of valty_u1 is Inn.
12. Let Inn be valty_u1.
13. Let fN be val__u4.
14. Assert: Due to validation, ($size(Inn) is $size(Fnn)).
15. Return [$reinterpret(Fnn, Inn, fN)].

invibytes N b*
1. Let n be $ibytes_1^-1(N, b*).
2. Return n.

invfbytes N b*
1. Let p be $fbytes_1^-1(N, b*).
2. Return p.

default_ valty_u0
1. If (valty_u0 is I32), then:
  a. Return (I32.CONST 0).
2. If (valty_u0 is I64), then:
  a. Return (I64.CONST 0).
3. If (valty_u0 is F32), then:
  a. Return (F32.CONST $fzero(32)).
4. Assert: Due to validation, (valty_u0 is F64).
5. Return (F64.CONST $fzero(64)).

funcsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $funcsxv(xv*).

globalsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globalsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $globalsxv(xv*).

tablesxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tablesxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $tablesxv(xv*).

memsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $memsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $memsxv(xv*).

store
1. Return.

frame
1. Let f be the current frame.
2. Return f.

funcaddr
1. Let f be the current frame.
2. Return f.MODULE.FUNCS.

funcinst
1. Return s.FUNCS.

globalinst
1. Return s.GLOBALS.

tableinst
1. Return s.TABLES.

meminst
1. Return s.MEMS.

moduleinst
1. Let f be the current frame.
2. Return f.MODULE.

type x
1. Let f be the current frame.
2. Return f.MODULE.TYPES[x].

func x
1. Let f be the current frame.
2. Return s.FUNCS[f.MODULE.FUNCS[x]].

global x
1. Let f be the current frame.
2. Return s.GLOBALS[f.MODULE.GLOBALS[x]].

table x
1. Let f be the current frame.
2. Return s.TABLES[f.MODULE.TABLES[x]].

mem x
1. Let f be the current frame.
2. Return s.MEMS[f.MODULE.MEMS[x]].

local x
1. Let f be the current frame.
2. Return f.LOCALS[x].

with_local x v
1. Let f be the current frame.
2. Replace f.LOCALS[x] with v.

with_global x v
1. Let f be the current frame.
2. Replace s.GLOBALS[f.MODULE.GLOBALS[x]].VALUE with v.

with_table x i a
1. Let f be the current frame.
2. Replace s.TABLES[f.MODULE.TABLES[x]].REFS[i] with ?(a).

with_tableinst x ti
1. Let f be the current frame.
2. Replace s.TABLES[f.MODULE.TABLES[x]] with ti.

with_mem x i j b*
1. Let f be the current frame.
2. Replace s.MEMS[f.MODULE.MEMS[x]].BYTES[i : j] with b*.

with_meminst x mi
1. Let f be the current frame.
2. Replace s.MEMS[f.MODULE.MEMS[x]] with mi.

growtable ti n
1. Let { TYPE: (i, j); REFS: ?(a)*; } be ti.
2. Let i' be (|a*| + n).
3. If (i' ≤ j), then:
  a. Let ti' be { TYPE: (i', j); REFS: ?(a)* ++ ?()^n; }.
  b. Return ti'.

growmemory mi n
1. Let { TYPE: (i, j); BYTES: b*; } be mi.
2. Let i' be ((|b*| / (64 · $Ki())) + n).
3. If (i' ≤ j), then:
  a. Let mi' be { TYPE: (i', j); BYTES: b* ++ 0^(n · (64 · $Ki())); }.
  b. Return mi'.

funcs exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcs(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $funcs(externval'*).

globals exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globals(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $globals(externval'*).

tables exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tables(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $tables(externval'*).

mems exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $mems(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $mems(externval'*).

allocfunc moduleinst func
1. Assert: Due to validation, func is of the case FUNC.
2. Let (FUNC x local* expr) be func.
3. Let fi be { TYPE: moduleinst.TYPES[x]; MODULE: moduleinst; CODE: func; }.
4. Let a be |s.FUNCS|.
5. Append fi to the s.FUNCS.
6. Return a.

allocfuncs moduleinst func_u0*
1. If (func_u0* is []), then:
  a. Return [].
2. Let [func] ++ func'* be func_u0*.
3. Let fa be $allocfunc(moduleinst, func).
4. Let fa'* be $allocfuncs(moduleinst, func'*).
5. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let gi be { TYPE: globaltype; VALUE: val; }.
2. Let a be |s.GLOBALS|.
3. Append gi to the s.GLOBALS.
4. Return a.

allocglobals globa_u0* val_u1*
1. If (globa_u0* is []), then:
  a. Assert: Due to validation, (val_u1* is []).
  b. Return [].
2. Else:
  a. Let [globaltype] ++ globaltype'* be globa_u0*.
  b. Assert: Due to validation, (|val_u1*| ≥ 1).
  c. Let [val] ++ val'* be val_u1*.
  d. Let ga be $allocglobal(globaltype, val).
  e. Let ga'* be $allocglobals(globaltype'*, val'*).
  f. Return [ga] ++ ga'*.

alloctable (i, j)
1. Let ti be { TYPE: (i, j); REFS: ?()^i; }.
2. Let a be |s.TABLES|.
3. Append ti to the s.TABLES.
4. Return a.

alloctables table_u0*
1. If (table_u0* is []), then:
  a. Return [].
2. Let [tabletype] ++ tabletype'* be table_u0*.
3. Let ta be $alloctable(tabletype).
4. Let ta'* be $alloctables(tabletype'*).
5. Return [ta] ++ ta'*.

allocmem (i, j)
1. Let mi be { TYPE: (i, j); BYTES: 0^(i · (64 · $Ki())); }.
2. Let a be |s.MEMS|.
3. Append mi to the s.MEMS.
4. Return a.

allocmems memty_u0*
1. If (memty_u0* is []), then:
  a. Return [].
2. Let [memtype] ++ memtype'* be memty_u0*.
3. Let ma be $allocmem(memtype).
4. Let ma'* be $allocmems(memtype'*).
5. Return [ma] ++ ma'*.

instexport fa* ga* ta* ma* (EXPORT name exter_u0)
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC x) be exter_u0.
  b. Return { NAME: name; VALUE: (FUNC fa*[x]); }.
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be exter_u0.
  b. Return { NAME: name; VALUE: (GLOBAL ga*[x]); }.
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE x) be exter_u0.
  b. Return { NAME: name; VALUE: (TABLE ta*[x]); }.
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM x) be exter_u0.
6. Return { NAME: name; VALUE: (MEM ma*[x]); }.

allocmodule module externval* val*
1. Let fa_ex* be $funcs(externval*).
2. Let ga_ex* be $globals(externval*).
3. Let ma_ex* be $mems(externval*).
4. Let ta_ex* be $tables(externval*).
5. Assert: Due to validation, module is of the case MODULE.
6. Let (MODULE y_0 import* func^n_func y_1 y_2 y_3 elem* data* start? export*) be module.
7. Assert: Due to validation, y_3 is of the case MEMORY.
8. Let (MEMORY memtype)^n_mem be y_3.
9. Assert: Due to validation, y_2 is of the case TABLE.
10. Let (TABLE tabletype)^n_table be y_2.
11. Assert: Due to validation, y_1 is of the case GLOBAL.
12. Let (GLOBAL globaltype expr_1)^n_global be y_1.
13. Assert: Due to validation, y_0 is of the case TYPE.
14. Let (TYPE ft)* be y_0.
15. Let fa* be (|s.FUNCS| + i_func)^(i_func<n_func).
16. Let ga* be (|s.GLOBALS| + i_global)^(i_global<n_global).
17. Let ta* be (|s.TABLES| + i_table)^(i_table<n_table).
18. Let ma* be (|s.MEMS| + i_mem)^(i_mem<n_mem).
19. Let xi* be $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*.
20. Let moduleinst be { TYPES: ft*; FUNCS: fa_ex* ++ fa*; GLOBALS: ga_ex* ++ ga*; TABLES: ta_ex* ++ ta*; MEMS: ma_ex* ++ ma*; EXPORTS: xi*; }.
21. Let y_0 be $allocfuncs(moduleinst, func^n_func).
22. Assert: Due to validation, (y_0 is fa*).
23. Let y_0 be $allocglobals(globaltype^n_global, val*).
24. Assert: Due to validation, (y_0 is ga*).
25. Let y_0 be $alloctables(tabletype^n_table).
26. Assert: Due to validation, (y_0 is ta*).
27. Let y_0 be $allocmems(memtype^n_mem).
28. Assert: Due to validation, (y_0 is ma*).
29. Return moduleinst.

initelem moduleinst u32_u0* funca_u1*
1. If ((u32_u0* is []) and (funca_u1* is [])), then:
  a. Return.
2. Assert: Due to validation, (|funca_u1*| ≥ 1).
3. Let [a*] ++ a'** be funca_u1*.
4. Assert: Due to validation, (|u32_u0*| ≥ 1).
5. Let [i] ++ i'* be u32_u0*.
6. Replace s.TABLES[moduleinst.TABLES[0]].REFS[i : |a*|] with ?(a)*.
7. Perform $initelem(moduleinst, i'*, a'**).
8. Return.

initdata moduleinst u32_u0* byte_u1*
1. If ((u32_u0* is []) and (byte_u1* is [])), then:
  a. Return.
2. Assert: Due to validation, (|byte_u1*| ≥ 1).
3. Let [b*] ++ b'** be byte_u1*.
4. Assert: Due to validation, (|u32_u0*| ≥ 1).
5. Let [i] ++ i'* be u32_u0*.
6. Replace s.MEMS[moduleinst.MEMS[0]].BYTES[i : |b*|] with b*.
7. Perform $initdata(moduleinst, i'*, b'**).
8. Return.

instantiate module externval*
1. Assert: Due to validation, module is of the case MODULE.
2. Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) be module.
3. Assert: Due to validation, type* is of the case TYPE.
4. Let (TYPE functype)* be type*.
5. Let n_F be |func*|.
6. Assert: Due to validation, start? is of the case START.
7. Let (START x')? be start?.
8. Assert: Due to validation, data* is of the case DATA.
9. Let (DATA expr_D b*)* be data*.
10. Assert: Due to validation, elem* is of the case ELEM.
11. Let (ELEM expr_E x*)* be elem*.
12. Assert: Due to validation, global* is of the case GLOBAL.
13. Let (GLOBAL globaltype expr_G)* be global*.
14. Let moduleinst_init be { TYPES: functype*; FUNCS: $funcs(externval*) ++ (|s.FUNCS| + i_F)^(i_F<n_F); GLOBALS: $globals(externval*); TABLES: []; MEMS: []; EXPORTS: []; }.
15. Let f_init be { LOCALS: []; MODULE: moduleinst_init; }.
16. Let z be f_init.
17. Push the activation of z to the stack.
18. Let [(I32.CONST i_D)]* be $eval_expr(expr_D)*.
19. Pop the activation of z from the stack.
20. Push the activation of z to the stack.
21. Let [(I32.CONST i_E)]* be $eval_expr(expr_E)*.
22. Pop the activation of z from the stack.
23. Push the activation of z to the stack.
24. Let [val]* be $eval_expr(expr_G)*.
25. Pop the activation of z from the stack.
26. Let moduleinst be $allocmodule(module, externval*, val*).
27. Let f be { LOCALS: []; MODULE: moduleinst; }.
28. Perform $initelem(moduleinst, i_E*, moduleinst.FUNCS[x]**).
29. Perform $initdata(moduleinst, i_D*, b**).
30. Push the activation of f with arity 0 to the stack.
31. If (CALL x')? is defined, then:
  a. Let ?(instr_0) be (CALL x')?.
  b. Execute the instruction instr_0.
32. Pop the activation of f with arity 0 from the stack.
33. Return f.MODULE.

invoke fa val^n
1. Let f be { LOCALS: []; MODULE: { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; EXPORTS: []; }; }.
2. Let (t_1^n -> t_2*) be $funcinst()[fa].TYPE.
3. Let k be |t_2*|.
4. Push the activation of f with arity k to the stack.
5. Push the values val^n to the stack.
6. Execute the instruction (CALL_ADDR fa).
7. Pop all values val* from the top of the stack.
8. Pop the activation of f with arity k from the stack.
9. Push the values val* to the stack.
10. Pop the values val^k from the stack.
11. Return val^k.

execution_of_UNREACHABLE
1. Trap.

execution_of_NOP
1. Do nothing.

execution_of_DROP
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Do nothing.

execution_of_SELECT
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value val_2 from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop the value val_1 from the stack.
7. If (c is not 0), then:
  a. Push the value val_1 to the stack.
8. Else:
  a. Push the value val_2 to the stack.

execution_of_IF t? instr_1* instr_2*
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute the instruction (BLOCK t? instr_1*).
4. Else:
  a. Execute the instruction (BLOCK t? instr_2*).

execution_of_LABEL_
1. Pop all values val* from the top of the stack.
2. Assert: Due to validation, a label is now on the top of the stack.
3. Pop the current label from the stack.
4. Push the values val* to the stack.

execution_of_BR n_u0
1. Pop all values val* from the top of the stack.
2. Let L be the current label.
3. Let n be the arity of L.
4. Let instr'* be the continuation of L.
5. Pop the current label from the stack.
6. Let admin_u1* be val*.
7. If ((n_u0 is 0) and (|admin_u1*| ≥ n)), then:
  a. Let val'* ++ val^n be admin_u1*.
  b. Push the values val^n to the stack.
  c. Execute the sequence (instr'*).
8. If (n_u0 ≥ 1), then:
  a. Let l be (n_u0 - 1).
  b. If the type of admin_u1 is val*, then:
    1) Let val* be admin_u1*.
    2) Push the values val* to the stack.
    3) Execute the instruction (BR l).

execution_of_BR_IF l
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute the instruction (BR l).
4. Else:
  a. Do nothing.

execution_of_BR_TABLE l* l'
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST i) from the stack.
3. If (i < |l*|), then:
  a. Execute the instruction (BR l*[i]).
4. Else:
  a. Execute the instruction (BR l').

execution_of_FRAME_
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop the values val^n from the stack.
5. Assert: Due to validation, a frame is now on the top of the stack.
6. Pop the current frame from the stack.
7. Push the values val^n to the stack.

execution_of_RETURN
1. Pop all values val* from the top of the stack.
2. If a frame is now on the top of the stack, then:
  a. Let f be the current frame.
  b. Let n be the arity of f.
  c. Pop the current frame from the stack.
  d. Let val'* ++ val^n be val*.
  e. Push the values val^n to the stack.
3. Else if a label is now on the top of the stack, then:
  a. Pop the current label from the stack.
  b. Push the values val* to the stack.
  c. Execute the instruction RETURN.

execution_of_TRAP
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_UNOP t unop
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop the value (t.CONST c_1) from the stack.
3. If (|$unop(t, unop, c_1)| is 1), then:
  a. Let [c] be $unop(t, unop, c_1).
  b. Push the value (t.CONST c) to the stack.
4. If ($unop(t, unop, c_1) is []), then:
  a. Trap.

execution_of_BINOP t binop
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop the value (t.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type t is on the top of the stack.
4. Pop the value (t.CONST c_1) from the stack.
5. If (|$binop(t, binop, c_1, c_2)| is 1), then:
  a. Let [c] be $binop(t, binop, c_1, c_2).
  b. Push the value (t.CONST c) to the stack.
6. If ($binop(t, binop, c_1, c_2) is []), then:
  a. Trap.

execution_of_TESTOP t testop
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop the value (t.CONST c_1) from the stack.
3. Let c be $testop(t, testop, c_1).
4. Push the value (I32.CONST c) to the stack.

execution_of_RELOP t relop
1. Assert: Due to validation, a value of value type t is on the top of the stack.
2. Pop the value (t.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type t is on the top of the stack.
4. Pop the value (t.CONST c_1) from the stack.
5. Let c be $relop(t, relop, c_1, c_2).
6. Push the value (I32.CONST c) to the stack.

execution_of_CVTOP t_2 t_1 cvtop
1. Assert: Due to validation, a value of value type t_1 is on the top of the stack.
2. Pop the value (t_1.CONST c_1) from the stack.
3. If (|$cvtop(t_1, t_2, cvtop, c_1)| is 1), then:
  a. Let [c] be $cvtop(t_1, t_2, cvtop, c_1).
  b. Push the value (t_2.CONST c) to the stack.
4. If ($cvtop(t_1, t_2, cvtop, c_1) is []), then:
  a. Trap.

execution_of_LOCAL.TEE x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Push the value val to the stack.
4. Push the value val to the stack.
5. Execute the instruction (LOCAL.SET x).

execution_of_BLOCK t? instr*
1. If t? is not defined, then:
  a. Let n be 0.
2. Else:
  a. Let n be 1.
3. Let L be the label_n{[]}.
4. Enter instr* with label L.

execution_of_LOOP t? instr*
1. Let L be the label_0{[(LOOP t? instr*)]}.
2. Enter instr* with label L.

execution_of_CALL x
1. Let z be the current state.
2. Assert: Due to validation, (x < |$funcaddr(z)|).
3. Execute the instruction (CALL_ADDR $funcaddr(z)[x]).

execution_of_CALL_INDIRECT x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If (i ≥ |$table(z, 0).REFS|), then:
  a. Trap.
5. If $table(z, 0).REFS[i] is not defined, then:
  a. Trap.
6. Let ?(a) be $table(z, 0).REFS[i].
7. If (a ≥ |$funcinst(z)|), then:
  a. Trap.
8. If ($type(z, x) is not $funcinst(z)[a].TYPE), then:
  a. Trap.
9. Execute the instruction (CALL_ADDR a).

execution_of_CALL_ADDR a
1. Let z be the current state.
2. Assert: Due to validation, (a < |$funcinst(z)|).
3. Let { TYPE: (t_1^k -> t_2^n); MODULE: mm; CODE: func; } be $funcinst(z)[a].
4. Assert: Due to validation, there are at least k values on the top of the stack.
5. Pop the values val^k from the stack.
6. Assert: Due to validation, func is of the case FUNC.
7. Let (FUNC x y_0 instr*) be func.
8. Assert: Due to validation, y_0 is of the case LOCAL.
9. Let (LOCAL t)* be y_0.
10. Let f be { LOCALS: val^k ++ $default_(t)*; MODULE: mm; }.
11. Let F be the activation of f with arity n.
12. Push F to the stack.
13. Let L be the label_n{[]}.
14. Enter instr* with label L.

execution_of_LOCAL.GET x
1. Let z be the current state.
2. Push the value $local(z, x) to the stack.

execution_of_GLOBAL.GET x
1. Let z be the current state.
2. Push the value $global(z, x).VALUE to the stack.

execution_of_LOAD valty_u0 sz_sx_u1? ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If sz_sx_u1? is not defined, then:
  a. Let t be valty_u0.
  b. If (((i + ao.OFFSET) + ($size(t) / 8)) > |$mem(z, 0).BYTES|), then:
    1) Trap.
  c. Let c be $bytes_1^-1(t, $mem(z, 0).BYTES[(i + ao.OFFSET) : ($size(t) / 8)]).
  d. Push the value (t.CONST c) to the stack.
5. If the type of valty_u0 is Inn, then:
  a. If sz_sx_u1? is defined, then:
    1) Let ?(y_0) be sz_sx_u1?.
    2) Let (n, sx) be y_0.
    3) If (((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|), then:
      a) Trap.
  b. Let Inn be valty_u0.
  c. If sz_sx_u1? is defined, then:
    1) Let ?(y_0) be sz_sx_u1?.
    2) Let (n, sx) be y_0.
    3) Let c be $ibytes_1^-1(n, $mem(z, 0).BYTES[(i + ao.OFFSET) : (n / 8)]).
    4) Push the value (Inn.CONST $ext(n, $size(Inn), sx, c)) to the stack.

execution_of_MEMORY.SIZE
1. Let z be the current state.
2. Let ((n · 64) · $Ki()) be |$mem(z, 0).BYTES|.
3. Push the value (I32.CONST n) to the stack.

execution_of_CTXT
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_LOCAL.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Perform $with_local(z, x, val).

execution_of_GLOBAL.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Perform $with_global(z, x, val).

execution_of_STORE valty_u1 sz_u2? ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type valty_u0 is on the top of the stack.
3. Pop the value (valty_u0.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If sz_u2? is not defined, then:
  a. Let t be valty_u1.
  b. If ((((i + ao.OFFSET) + ($size(t) / 8)) > |$mem(z, 0).BYTES|) and (valty_u0 is t)), then:
    1) Trap.
  c. If (valty_u0 is t), then:
    1) Let b* be $bytes(t, c).
    2) Perform $with_mem(z, 0, (i + ao.OFFSET), ($size(t) / 8), b*).
7. Else:
  a. Let ?(n) be sz_u2?.
  b. If the type of valty_u1 is Inn, then:
    1) Let Inn be valty_u1.
    2) If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|) and (valty_u0 is Inn)), then:
      a) Trap.
    3) If (valty_u0 is Inn), then:
      a) Let b* be $ibytes(n, $wrap($size(Inn), n, c)).
      b) Perform $with_mem(z, 0, (i + ao.OFFSET), (n / 8), b*).

execution_of_MEMORY.GROW
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Either:
  a. Let mi be $growmemory($mem(z, 0), n).
  b. Push the value (I32.CONST (|$mem(z, 0).BYTES| / (64 · $Ki()))) to the stack.
  c. Perform $with_meminst(z, 0, mi).
5. Or:
  a. Push the value (I32.CONST $invsigned(32, (- 1))) to the stack.

eval_expr instr*
1. Execute the sequence (instr*).
2. Pop the value val from the stack.
3. Return [val].

group_bytes_by n byte*
1. Let n' be |byte*|.
2. If (n' ≥ n), then:
  a. Return [byte*[0 : n]] ++ $group_bytes_by(n, byte*[n : (n' - n)]).
3. Return [].

execution_of_ARRAY.NEW_DATA x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If $expanddt($type(z, x)) is of the case ARRAY, then:
  a. Let (ARRAY y_0) be $expanddt($type(z, x)).
  b. Let (mut, zt) be y_0.
  c. If ((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|), then:
    1) Trap.
  d. Let cnn be $cunpack(zt).
  e. Let b* be $data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)].
  f. Let gb* be $group_bytes_by(($zsize(zt) / 8), b*).
  g. Let c^n be $inverse_of_ibytes($zsize(zt), gb)*.
  h. Push the values (cnn.CONST c)^n to the stack.
  i. Execute the instruction (ARRAY.NEW_FIXED x n).
== Complete.
Generating prose for Wasm 2.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Prose Generation...
=================
 Generated prose
=================
validation_of_NOP
- The instruction is valid with type ([] -> []).

validation_of_UNREACHABLE
- The instruction is valid with type (t_1* -> t_2*).

validation_of_DROP
- The instruction is valid with type ([t] -> []).

validation_of_SELECT ?([t])
- The instruction is valid with type ([t, t, I32] -> [t]).

validation_of_BLOCK bt instr*
- Under the context C with .LABELS prepended by [t_2*], instr* must be valid with type (t_1* -> t_2*).
- Under the context C, bt must be valid with type (t_1* -> t_2*).
- The instruction is valid with type (t_1* -> t_2*).

validation_of_LOOP bt instr*
- Under the context C with .LABELS prepended by [t_1*], instr* must be valid with type (t_1* -> t_2*).
- Under the context C, bt must be valid with type (t_1* -> t_2*).
- The instruction is valid with type (t_1* -> t_2*).

validation_of_IF bt instr_1* instr_2*
- Under the context C with .LABELS prepended by [t_2*], instr_2* must be valid with type (t_1* -> t_2*).
- Under the context C, bt must be valid with type (t_1* -> t_2*).
- Under the context C with .LABELS prepended by [t_2*], instr_1* must be valid with type (t_1* -> t_2*).
- The instruction is valid with type (t_1* ++ [I32] -> t_2*).

validation_of_BR l
- |C.LABELS| must be greater than l.
- Let t* be C.LABELS[l].
- The instruction is valid with type (t_1* ++ t* -> t_2*).

validation_of_BR_IF l
- |C.LABELS| must be greater than l.
- Let t* be C.LABELS[l].
- The instruction is valid with type (t* ++ [I32] -> t*).

validation_of_BR_TABLE l* l'
- For all l in l*,
  - |C.LABELS| must be greater than l.
- |C.LABELS| must be greater than l'.
- For all l in l*,
  - C.LABELS[l] must match t*.
- C.LABELS[l'] must match t*.
- The instruction is valid with type (t_1* ++ t* -> t_2*).

validation_of_CALL x
- |C.FUNCS| must be greater than x.
- Let (t_1* -> t_2*) be C.FUNCS[x].
- The instruction is valid with type (t_1* -> t_2*).

validation_of_CALL_INDIRECT x y
- |C.TABLES| must be greater than x.
- |C.TYPES| must be greater than y.
- Let (lim, FUNCREF) be C.TABLES[x].
- Let (t_1* -> t_2*) be C.TYPES[y].
- The instruction is valid with type (t_1* ++ [I32] -> t_2*).

validation_of_RETURN
- Let ?(t*) be C.RETURN.
- The instruction is valid with type (t_1* ++ t* -> t_2*).

validation_of_CONST nt c_nt
- The instruction is valid with type ([] -> [nt]).

validation_of_UNOP nt unop_nt
- The instruction is valid with type ([nt] -> [nt]).

validation_of_BINOP nt binop_nt
- The instruction is valid with type ([nt, nt] -> [nt]).

validation_of_TESTOP nt testop_nt
- The instruction is valid with type ([nt] -> [I32]).

validation_of_RELOP nt relop_nt
- The instruction is valid with type ([nt, nt] -> [I32]).

validation_of_CVTOP nt_1 nt_2 REINTERPRET
- $size(nt_1) must be equal to $size(nt_2).
- The instruction is valid with type ([nt_2] -> [nt_1]).

validation_of_REF.NULL rt
- The instruction is valid with type ([] -> [rt]).

validation_of_REF.FUNC x
- |C.FUNCS| must be greater than x.
- Let ft be C.FUNCS[x].
- The instruction is valid with type ([] -> [FUNCREF]).

validation_of_REF.IS_NULL
- The instruction is valid with type ([rt] -> [I32]).

validation_of_VCONST V128 c
- The instruction is valid with type ([] -> [V128]).

validation_of_VVUNOP V128 vvunop
- The instruction is valid with type ([V128] -> [V128]).

validation_of_VVBINOP V128 vvbinop
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_VVTERNOP V128 vvternop
- The instruction is valid with type ([V128, V128, V128] -> [V128]).

validation_of_VVTESTOP V128 vvtestop
- The instruction is valid with type ([V128] -> [I32]).

validation_of_VUNOP sh vunop_sh
- The instruction is valid with type ([V128] -> [V128]).

validation_of_VBINOP sh vbinop_sh
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_VTESTOP sh vtestop_sh
- The instruction is valid with type ([V128] -> [I32]).

validation_of_VRELOP sh vrelop_sh
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_VSHIFTOP sh vshiftop_sh
- The instruction is valid with type ([V128, I32] -> [V128]).

validation_of_VBITMASK sh
- The instruction is valid with type ([V128] -> [I32]).

validation_of_VSWIZZLE sh
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_VSHUFFLE sh i*
- For all i in i*,
  - i must be less than (2 · $dim(sh)).
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_VSPLAT sh
- The instruction is valid with type ([$shunpack(sh)] -> [V128]).

validation_of_VEXTRACT_LANE sh sx? i
- i must be less than $dim(sh).
- The instruction is valid with type ([V128] -> [$shunpack(sh)]).

validation_of_VREPLACE_LANE sh i
- i must be less than $dim(sh).
- The instruction is valid with type ([V128, $shunpack(sh)] -> [V128]).

validation_of_VEXTUNOP sh_1 sh_2 vextunop
- The instruction is valid with type ([V128] -> [V128]).

validation_of_VEXTBINOP sh_1 sh_2 vextbinop
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_VNARROW sh_1 sh_2 sx
- The instruction is valid with type ([V128, V128] -> [V128]).

validation_of_VCVTOP sh_1 sh_2 vcvtop hf? sx? zero?
- The instruction is valid with type ([V128] -> [V128]).

validation_of_LOCAL.GET x
- |C.LOCALS| must be greater than x.
- Let t be C.LOCALS[x].
- The instruction is valid with type ([] -> [t]).

validation_of_LOCAL.SET x
- |C.LOCALS| must be greater than x.
- Let t be C.LOCALS[x].
- The instruction is valid with type ([t] -> []).

validation_of_LOCAL.TEE x
- |C.LOCALS| must be greater than x.
- Let t be C.LOCALS[x].
- The instruction is valid with type ([t] -> [t]).

validation_of_GLOBAL.GET x
- |C.GLOBALS| must be greater than x.
- Let (mut, t) be C.GLOBALS[x].
- The instruction is valid with type ([] -> [t]).

validation_of_GLOBAL.SET x
- |C.GLOBALS| must be greater than x.
- Let ((MUT ?(())), t) be C.GLOBALS[x].
- The instruction is valid with type ([t] -> []).

validation_of_TABLE.GET x
- |C.TABLES| must be greater than x.
- Let (lim, rt) be C.TABLES[x].
- The instruction is valid with type ([I32] -> [rt]).

validation_of_TABLE.SET x
- |C.TABLES| must be greater than x.
- Let (lim, rt) be C.TABLES[x].
- The instruction is valid with type ([I32, rt] -> []).

validation_of_TABLE.SIZE x
- |C.TABLES| must be greater than x.
- Let (lim, rt) be C.TABLES[x].
- The instruction is valid with type ([] -> [I32]).

validation_of_TABLE.GROW x
- |C.TABLES| must be greater than x.
- Let (lim, rt) be C.TABLES[x].
- The instruction is valid with type ([rt, I32] -> [I32]).

validation_of_TABLE.FILL x
- |C.TABLES| must be greater than x.
- Let (lim, rt) be C.TABLES[x].
- The instruction is valid with type ([I32, rt, I32] -> []).

validation_of_TABLE.COPY x_1 x_2
- |C.TABLES| must be greater than x_1.
- |C.TABLES| must be greater than x_2.
- Let (lim_1, rt) be C.TABLES[x_1].
- Let (lim_2, rt) be C.TABLES[x_2].
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_TABLE.INIT x_1 x_2
- |C.TABLES| must be greater than x_1.
- |C.ELEMS| must be greater than x_2.
- Let (lim, rt) be C.TABLES[x_1].
- C.ELEMS[x_2] must be equal to rt.
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_ELEM.DROP x
- |C.ELEMS| must be greater than x.
- Let rt be C.ELEMS[x].
- The instruction is valid with type ([] -> []).

validation_of_MEMORY.SIZE
- |C.MEMS| must be greater than 0.
- Let mt be C.MEMS[0].
- The instruction is valid with type ([] -> [I32]).

validation_of_MEMORY.GROW
- |C.MEMS| must be greater than 0.
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32] -> [I32]).

validation_of_MEMORY.FILL
- |C.MEMS| must be greater than 0.
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_MEMORY.COPY
- |C.MEMS| must be greater than 0.
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_MEMORY.INIT x
- |C.MEMS| must be greater than 0.
- |C.DATAS| must be greater than x.
- C.DATAS[x] must be equal to OK.
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32, I32, I32] -> []).

validation_of_DATA.DROP x
- |C.DATAS| must be greater than x.
- C.DATAS[x] must be equal to OK.
- The instruction is valid with type ([] -> []).

validation_of_LOAD nt (n, sx)? memarg
- |C.MEMS| must be greater than 0.
- ((sx? is ?())) if and only if ((n? is ?())).
- (2 ^ memarg.ALIGN) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ memarg.ALIGN) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32] -> [nt]).

validation_of_STORE nt n? memarg
- |C.MEMS| must be greater than 0.
- (2 ^ memarg.ALIGN) must be less than or equal to ($size(nt) / 8).
- If n is defined,
  - (2 ^ memarg.ALIGN) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32, nt] -> []).

validation_of_VLOAD V128 ?((SHAPE M N sx)) memarg
- |C.MEMS| must be greater than 0.
- (2 ^ memarg.ALIGN) must be less than or equal to ((M / 8) · N).
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32] -> [V128]).

validation_of_VLOAD_LANE V128 n memarg laneidx
- |C.MEMS| must be greater than 0.
- (2 ^ memarg.ALIGN) must be less than or equal to (n / 8).
- laneidx must be less than (128 / n).
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32, V128] -> [V128]).

validation_of_VSTORE V128 memarg
- |C.MEMS| must be greater than 0.
- (2 ^ memarg.ALIGN) must be less than or equal to ($size(V128) / 8).
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32, V128] -> []).

validation_of_VSTORE_LANE V128 n memarg laneidx
- |C.MEMS| must be greater than 0.
- (2 ^ memarg.ALIGN) must be less than or equal to (n / 8).
- laneidx must be less than (128 / n).
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32, V128] -> []).

Ki
1. Return 1024.

min n_u0 n_u1
1. If (n_u0 is 0), then:
  a. Return 0.
2. If (n_u1 is 0), then:
  a. Return 0.
3. Assert: Due to validation, (n_u0 ≥ 1).
4. Let i be (n_u0 - 1).
5. Assert: Due to validation, (n_u1 ≥ 1).
6. Let j be (n_u1 - 1).
7. Return $min(i, j).

sum n_u0*
1. If (n_u0* is []), then:
  a. Return 0.
2. Let [n] ++ n'* be n_u0*.
3. Return (n + $sum(n'*)).

concat_ X_u0*
1. If (X_u0* is []), then:
  a. Return [].
2. Let [w*] ++ w'** be X_u0*.
3. Return w* ++ $concat_(w'**).

signif N_u0
1. If (N_u0 is 32), then:
  a. Return 23.
2. Assert: Due to validation, (N_u0 is 64).
3. Return 52.

expon N_u0
1. If (N_u0 is 32), then:
  a. Return 8.
2. Assert: Due to validation, (N_u0 is 64).
3. Return 11.

M N
1. Return $signif(N).

E N
1. Return $expon(N).

fzero N
1. Return (POS (SUBNORM 0)).

fone N
1. Return (POS (NORM 1 0)).

canon_ N
1. Return (2 ^ ($signif(N) - 1)).

utf8 char_u0*
1. If (|char_u0*| is 1), then:
  a. Let [ch] be char_u0*.
  b. If (ch < 128), then:
    1) Let b be ch.
    2) Return [b].
  c. If ((128 ≤ ch) and ((ch < 2048) and (ch ≥ (b_2 - 128)))), then:
    1) Let ((2 ^ 6) · (b_1 - 192)) be (ch - (b_2 - 128)).
    2) Return [b_1, b_2].
  d. If ((((2048 ≤ ch) and (ch < 55296)) or ((57344 ≤ ch) and (ch < 65536))) and (ch ≥ (b_3 - 128))), then:
    1) Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · (b_2 - 128))) be (ch - (b_3 - 128)).
    2) Return [b_1, b_2, b_3].
  e. If ((65536 ≤ ch) and ((ch < 69632) and (ch ≥ (b_4 - 128)))), then:
    1) Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · (b_2 - 128))) + ((2 ^ 6) · (b_3 - 128))) be (ch - (b_4 - 128)).
    2) Return [b_1, b_2, b_3, b_4].
2. Let ch* be char_u0*.
3. Return $concat_($utf8([ch])*).

size valty_u0
1. If (valty_u0 is I32), then:
  a. Return 32.
2. If (valty_u0 is I64), then:
  a. Return 64.
3. If (valty_u0 is F32), then:
  a. Return 32.
4. If (valty_u0 is F64), then:
  a. Return 64.
5. If (valty_u0 is V128), then:
  a. Return 128.

isize Inn
1. Return $size(Inn).

psize packt_u0
1. If (packt_u0 is I8), then:
  a. Return 8.
2. Assert: Due to validation, (packt_u0 is I16).
3. Return 16.

lsize lanet_u0
1. If the type of lanet_u0 is numtype, then:
  a. Let numtype be lanet_u0.
  b. Return $size(numtype).
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $psize(packtype).

lanetype (Lnn X N)
1. Return Lnn.

sizenn nt
1. Return $size(nt).

sizemm lt
1. Return $lsize(lt).

zero numty_u0
1. If the type of numty_u0 is Inn, then:
  a. Return 0.
2. Assert: Due to validation, the type of numty_u0 is Fnn.
3. Let Fnn be numty_u0.
4. Return $fzero($size(Fnn)).

dim (Lnn X N)
1. Return N.

shsize (Lnn X N)
1. Return ($lsize(Lnn) · N).

concat_bytes byte_u0*
1. If (byte_u0* is []), then:
  a. Return [].
2. Let [b*] ++ b'** be byte_u0*.
3. Return b* ++ $concat_bytes(b'**).

unpack lanet_u0
1. If the type of lanet_u0 is numtype, then:
  a. Let numtype be lanet_u0.
  b. Return numtype.
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Return I32.

shunpack (Lnn X N)
1. Return $unpack(Lnn).

funcsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xt* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC ft) be y_0.
  b. Return [ft] ++ $funcsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $funcsxt(xt*).

globalsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xt* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be y_0.
  b. Return [gt] ++ $globalsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $globalsxt(xt*).

tablesxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xt* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE tt) be y_0.
  b. Return [tt] ++ $tablesxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $tablesxt(xt*).

memsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xt* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM mt) be y_0.
  b. Return [mt] ++ $memsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $memsxt(xt*).

free_dataidx_instr instr_u0
1. If instr_u0 is of the case MEMORY.INIT, then:
  a. Let (MEMORY.INIT x) be instr_u0.
  b. Return [x].
2. If instr_u0 is of the case DATA.DROP, then:
  a. Let (DATA.DROP x) be instr_u0.
  b. Return [x].
3. Return [].

free_dataidx_instrs instr_u0*
1. If (instr_u0* is []), then:
  a. Return [].
2. Let [instr] ++ instr'* be instr_u0*.
3. Return $free_dataidx_instr(instr) ++ $free_dataidx_instrs(instr'*).

free_dataidx_expr in*
1. Return $free_dataidx_instrs(in*).

free_dataidx_func (FUNC x loc* e)
1. Return $free_dataidx_expr(e).

free_dataidx_funcs func_u0*
1. If (func_u0* is []), then:
  a. Return [].
2. Let [func] ++ func'* be func_u0*.
3. Return $free_dataidx_func(func) ++ $free_dataidx_funcs(func'*).

memarg0
1. Return { ALIGN: 0; OFFSET: 0; }.

signed N i
1. If (0 ≤ (2 ^ (N - 1))), then:
  a. Return i.
2. Assert: Due to validation, ((2 ^ (N - 1)) ≤ i).
3. Assert: Due to validation, (i < (2 ^ N)).
4. Return (i - (2 ^ N)).

invsigned N i
1. Let j be $signed_1^-1(N, i).
2. Return j.

unop numty_u1 unop__u0 num__u3
1. If ((unop__u0 is CLZ) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN be num__u3.
  c. Return [$iclz($size(Inn), iN)].
2. If ((unop__u0 is CTZ) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN be num__u3.
  c. Return [$ictz($size(Inn), iN)].
3. If ((unop__u0 is POPCNT) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN be num__u3.
  c. Return [$ipopcnt($size(Inn), iN)].
4. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Assert: Due to validation, unop__u0 is of the case EXTEND.
  c. Let (EXTEND N) be unop__u0.
  d. Let iN be num__u3.
  e. Return [$ext(N, $size(Inn), S, $wrap($size(Inn), N, iN))].
5. If ((unop__u0 is ABS) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return [$fabs($size(Fnn), fN)].
6. If ((unop__u0 is NEG) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return [$fneg($size(Fnn), fN)].
7. If ((unop__u0 is SQRT) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return [$fsqrt($size(Fnn), fN)].
8. If ((unop__u0 is CEIL) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return [$fceil($size(Fnn), fN)].
9. If ((unop__u0 is FLOOR) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return [$ffloor($size(Fnn), fN)].
10. If ((unop__u0 is TRUNC) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return [$ftrunc($size(Fnn), fN)].
11. Assert: Due to validation, (unop__u0 is NEAREST).
12. Assert: Due to validation, the type of numty_u1 is Fnn.
13. Let Fnn be numty_u1.
14. Let fN be num__u3.
15. Return [$fnearest($size(Fnn), fN)].

binop numty_u1 binop_u0 num__u3 num__u5
1. If ((binop_u0 is ADD) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$iadd($size(Inn), iN_1, iN_2)].
2. If ((binop_u0 is SUB) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$isub($size(Inn), iN_1, iN_2)].
3. If ((binop_u0 is MUL) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$imul($size(Inn), iN_1, iN_2)].
4. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. If binop_u0 is of the case DIV, then:
    1) Let (DIV sx) be binop_u0.
    2) Return [$idiv($size(Inn), sx, iN_1, iN_2)].
  e. If binop_u0 is of the case REM, then:
    1) Let (REM sx) be binop_u0.
    2) Return [$irem($size(Inn), sx, iN_1, iN_2)].
5. If ((binop_u0 is AND) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$iand($size(Inn), iN_1, iN_2)].
6. If ((binop_u0 is OR) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$ior($size(Inn), iN_1, iN_2)].
7. If ((binop_u0 is XOR) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$ixor($size(Inn), iN_1, iN_2)].
8. If ((binop_u0 is SHL) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$ishl($size(Inn), iN_1, iN_2)].
9. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. If binop_u0 is of the case SHR, then:
    1) Let (SHR sx) be binop_u0.
    2) Return [$ishr($size(Inn), sx, iN_1, iN_2)].
10. If ((binop_u0 is ROTL) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$irotl($size(Inn), iN_1, iN_2)].
11. If ((binop_u0 is ROTR) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$irotr($size(Inn), iN_1, iN_2)].
12. If ((binop_u0 is ADD) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return [$fadd($size(Fnn), fN_1, fN_2)].
13. If ((binop_u0 is SUB) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return [$fsub($size(Fnn), fN_1, fN_2)].
14. If ((binop_u0 is MUL) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return [$fmul($size(Fnn), fN_1, fN_2)].
15. If ((binop_u0 is DIV) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return [$fdiv($size(Fnn), fN_1, fN_2)].
16. If ((binop_u0 is MIN) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return [$fmin($size(Fnn), fN_1, fN_2)].
17. If ((binop_u0 is MAX) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return [$fmax($size(Fnn), fN_1, fN_2)].
18. Assert: Due to validation, (binop_u0 is COPYSIGN).
19. Assert: Due to validation, the type of numty_u1 is Fnn.
20. Let Fnn be numty_u1.
21. Let fN_1 be num__u3.
22. Let fN_2 be num__u5.
23. Return [$fcopysign($size(Fnn), fN_1, fN_2)].

testop Inn EQZ iN
1. Return $ieqz($size(Inn), iN).

relop numty_u1 relop_u0 num__u3 num__u5
1. If ((relop_u0 is EQ) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return $ieq($size(Inn), iN_1, iN_2).
2. If ((relop_u0 is NE) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return $ine($size(Inn), iN_1, iN_2).
3. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. If relop_u0 is of the case LT, then:
    1) Let (LT sx) be relop_u0.
    2) Return $ilt($size(Inn), sx, iN_1, iN_2).
  e. If relop_u0 is of the case GT, then:
    1) Let (GT sx) be relop_u0.
    2) Return $igt($size(Inn), sx, iN_1, iN_2).
  f. If relop_u0 is of the case LE, then:
    1) Let (LE sx) be relop_u0.
    2) Return $ile($size(Inn), sx, iN_1, iN_2).
  g. If relop_u0 is of the case GE, then:
    1) Let (GE sx) be relop_u0.
    2) Return $ige($size(Inn), sx, iN_1, iN_2).
4. If ((relop_u0 is EQ) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $feq($size(Fnn), fN_1, fN_2).
5. If ((relop_u0 is NE) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fne($size(Fnn), fN_1, fN_2).
6. If ((relop_u0 is LT) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $flt($size(Fnn), fN_1, fN_2).
7. If ((relop_u0 is GT) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fgt($size(Fnn), fN_1, fN_2).
8. If ((relop_u0 is LE) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fle($size(Fnn), fN_1, fN_2).
9. Assert: Due to validation, (relop_u0 is GE).
10. Assert: Due to validation, the type of numty_u1 is Fnn.
11. Let Fnn be numty_u1.
12. Let fN_1 be num__u3.
13. Let fN_2 be num__u5.
14. Return $fge($size(Fnn), fN_1, fN_2).

cvtop numty_u0 numty_u1 cvtop_u2 num__u4
1. If ((numty_u0 is I32) and (numty_u1 is I64)), then:
  a. Let iN be num__u4.
  b. If cvtop_u2 is of the case EXTEND, then:
    1) Let (EXTEND sx) be cvtop_u2.
    2) Return [$ext(32, 64, sx, iN)].
2. If ((numty_u0 is I64) and ((numty_u1 is I32) and (cvtop_u2 is WRAP))), then:
  a. Let iN be num__u4.
  b. Return [$wrap(64, 32, iN)].
3. If the type of numty_u0 is Fnn, then:
  a. Let Fnn be numty_u0.
  b. If the type of numty_u1 is Inn, then:
    1) Let Inn be numty_u1.
    2) Let fN be num__u4.
    3) If cvtop_u2 is of the case TRUNC, then:
      a) Let (TRUNC sx) be cvtop_u2.
      b) Return [$trunc($size(Fnn), $size(Inn), sx, fN)].
    4) If cvtop_u2 is of the case TRUNC_SAT, then:
      a) Let (TRUNC_SAT sx) be cvtop_u2.
      b) Return [$trunc_sat($size(Fnn), $size(Inn), sx, fN)].
4. If ((numty_u0 is F32) and ((numty_u1 is F64) and (cvtop_u2 is PROMOTE))), then:
  a. Let fN be num__u4.
  b. Return [$promote(32, 64, fN)].
5. If ((numty_u0 is F64) and ((numty_u1 is F32) and (cvtop_u2 is DEMOTE))), then:
  a. Let fN be num__u4.
  b. Return [$demote(64, 32, fN)].
6. If the type of numty_u1 is Fnn, then:
  a. Let Fnn be numty_u1.
  b. If the type of numty_u0 is Inn, then:
    1) Let Inn be numty_u0.
    2) Let iN be num__u4.
    3) If cvtop_u2 is of the case CONVERT, then:
      a) Let (CONVERT sx) be cvtop_u2.
      b) Return [$convert($size(Inn), $size(Fnn), sx, iN)].
7. Assert: Due to validation, (cvtop_u2 is REINTERPRET).
8. If the type of numty_u1 is Fnn, then:
  a. Let Fnn be numty_u1.
  b. If the type of numty_u0 is Inn, then:
    1) Let Inn be numty_u0.
    2) Let iN be num__u4.
    3) If ($size(Inn) is $size(Fnn)), then:
      a) Return [$reinterpret(Inn, Fnn, iN)].
9. Assert: Due to validation, the type of numty_u0 is Fnn.
10. Let Fnn be numty_u0.
11. Assert: Due to validation, the type of numty_u1 is Inn.
12. Let Inn be numty_u1.
13. Let fN be num__u4.
14. Assert: Due to validation, ($size(Inn) is $size(Fnn)).
15. Return [$reinterpret(Fnn, Inn, fN)].

invibytes N b*
1. Let n be $ibytes_1^-1(N, b*).
2. Return n.

invfbytes N b*
1. Let p be $fbytes_1^-1(N, b*).
2. Return p.

packnum lanet_u0 c
1. If the type of lanet_u0 is numtype, then:
  a. Return c.
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $wrap($size($unpack(packtype)), $psize(packtype), c).

unpacknum lanet_u0 c
1. If the type of lanet_u0 is numtype, then:
  a. Return c.
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $ext($psize(packtype), $size($unpack(packtype)), U, c).

invlanes_ sh c*
1. Let vc be $lanes__1^-1(sh, c*).
2. Return vc.

halfop half_u0 i j
1. If (half_u0 is LOW), then:
  a. Return i.
2. Assert: Due to validation, (half_u0 is HIGH).
3. Return j.

vvunop V128 NOT v128
1. Return $inot($size(V128), v128).

vvbinop V128 vvbin_u0 v128_1 v128_2
1. If (vvbin_u0 is AND), then:
  a. Return $iand($size(V128), v128_1, v128_2).
2. If (vvbin_u0 is ANDNOT), then:
  a. Return $iandnot($size(V128), v128_1, v128_2).
3. If (vvbin_u0 is OR), then:
  a. Return $ior($size(V128), v128_1, v128_2).
4. Assert: Due to validation, (vvbin_u0 is XOR).
5. Return $ixor($size(V128), v128_1, v128_2).

vvternop V128 BITSELECT v128_1 v128_2 v128_3
1. Return $ibitselect($size(V128), v128_1, v128_2, v128_3).

vunop (lanet_u1 X N) vunop_u0 v128_1
1. If ((vunop_u0 is ABS) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let v128 be $invlanes_((Jnn X N), $iabs($lsize(Jnn), lane_1)*).
  d. Return v128.
2. If ((vunop_u0 is NEG) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let v128 be $invlanes_((Jnn X N), $ineg($lsize(Jnn), lane_1)*).
  d. Return v128.
3. If ((vunop_u0 is POPCNT) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let v128 be $invlanes_((Jnn X N), $ipopcnt($lsize(Jnn), lane_1)*).
  d. Return v128.
4. If ((vunop_u0 is ABS) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128 be $invlanes_((Fnn X N), $fabs($size(Fnn), lane_1)*).
  d. Return v128.
5. If ((vunop_u0 is NEG) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128 be $invlanes_((Fnn X N), $fneg($size(Fnn), lane_1)*).
  d. Return v128.
6. If ((vunop_u0 is SQRT) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128 be $invlanes_((Fnn X N), $fsqrt($size(Fnn), lane_1)*).
  d. Return v128.
7. If ((vunop_u0 is CEIL) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128 be $invlanes_((Fnn X N), $fceil($size(Fnn), lane_1)*).
  d. Return v128.
8. If ((vunop_u0 is FLOOR) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128 be $invlanes_((Fnn X N), $ffloor($size(Fnn), lane_1)*).
  d. Return v128.
9. If ((vunop_u0 is TRUNC) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128 be $invlanes_((Fnn X N), $ftrunc($size(Fnn), lane_1)*).
  d. Return v128.
10. Assert: Due to validation, (vunop_u0 is NEAREST).
11. Assert: Due to validation, the type of lanet_u1 is Fnn.
12. Let Fnn be lanet_u1.
13. Let lane_1* be $lanes_((Fnn X N), v128_1).
14. Let v128 be $invlanes_((Fnn X N), $fnearest($size(Fnn), lane_1)*).
15. Return v128.

vbinop (lanet_u1 X N) vbino_u0 v128_1 v128_2
1. If ((vbino_u0 is ADD) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $iadd($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
2. If ((vbino_u0 is SUB) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $isub($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
3. If the type of lanet_u1 is Jnn, then:
  a. Let Jnn be lanet_u1.
  b. If vbino_u0 is of the case MIN, then:
    1) Let (MIN sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $imin($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
  c. If vbino_u0 is of the case MAX, then:
    1) Let (MAX sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $imax($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
  d. If vbino_u0 is of the case ADD_SAT, then:
    1) Let (ADD_SAT sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $iaddsat($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
  e. If vbino_u0 is of the case SUB_SAT, then:
    1) Let (SUB_SAT sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $isubsat($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
4. If ((vbino_u0 is MUL) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $imul($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
5. If ((vbino_u0 is AVGR_U) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $iavgr_u($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
6. If ((vbino_u0 is Q15MULR_SAT_S) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $iq15mulrsat_s($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
7. If ((vbino_u0 is ADD) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fadd($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
8. If ((vbino_u0 is SUB) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fsub($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
9. If ((vbino_u0 is MUL) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fmul($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
10. If ((vbino_u0 is DIV) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fdiv($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
11. If ((vbino_u0 is MIN) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fmin($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
12. If ((vbino_u0 is MAX) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fmax($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
13. If ((vbino_u0 is PMIN) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fpmin($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
14. Assert: Due to validation, (vbino_u0 is PMAX).
15. Assert: Due to validation, the type of lanet_u1 is Fnn.
16. Let Fnn be lanet_u1.
17. Let lane_1* be $lanes_((Fnn X N), v128_1).
18. Let lane_2* be $lanes_((Fnn X N), v128_2).
19. Let v128 be $invlanes_((Fnn X N), $fpmax($size(Fnn), lane_1, lane_2)*).
20. Return [v128].

vrelop (lanet_u1 X N) vrelo_u0 v128_1 v128_2
1. If ((vrelo_u0 is EQ) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let lane_3* be $ext(1, $lsize(Jnn), S, $ieq($lsize(Jnn), lane_1, lane_2))*.
  e. Let v128 be $invlanes_((Jnn X N), lane_3*).
  f. Return v128.
2. If ((vrelo_u0 is NE) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let lane_3* be $ext(1, $lsize(Jnn), S, $ine($lsize(Jnn), lane_1, lane_2))*.
  e. Let v128 be $invlanes_((Jnn X N), lane_3*).
  f. Return v128.
3. If the type of lanet_u1 is Jnn, then:
  a. Let Jnn be lanet_u1.
  b. If vrelo_u0 is of the case LT, then:
    1) Let (LT sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $ext(1, $lsize(Jnn), S, $ilt($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
  c. If vrelo_u0 is of the case GT, then:
    1) Let (GT sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $ext(1, $lsize(Jnn), S, $igt($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
  d. If vrelo_u0 is of the case LE, then:
    1) Let (LE sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $ext(1, $lsize(Jnn), S, $ile($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
  e. If vrelo_u0 is of the case GE, then:
    1) Let (GE sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $ext(1, $lsize(Jnn), S, $ige($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
4. If ((vrelo_u0 is EQ) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $ext(1, $size(Fnn), S, $feq($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
5. If ((vrelo_u0 is NE) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $ext(1, $size(Fnn), S, $fne($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
6. If ((vrelo_u0 is LT) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $ext(1, $size(Fnn), S, $flt($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
7. If ((vrelo_u0 is GT) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $ext(1, $size(Fnn), S, $fgt($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
8. If ((vrelo_u0 is LE) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $ext(1, $size(Fnn), S, $fle($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
9. Assert: Due to validation, (vrelo_u0 is GE).
10. Assert: Due to validation, the type of lanet_u1 is Fnn.
11. Let Fnn be lanet_u1.
12. Let lane_1* be $lanes_((Fnn X N), v128_1).
13. Let lane_2* be $lanes_((Fnn X N), v128_2).
14. Let Inn be $isize^-1($size(Fnn)).
15. Let lane_3* be $ext(1, $size(Fnn), S, $fge($size(Fnn), lane_1, lane_2))*.
16. Let v128 be $invlanes_((Inn X N), lane_3*).
17. Return v128.

vcvtop (lanet_u0 X N_1) (lanet_u1 X N_2) vcvto_u4 sx_u5? lane__u3
1. If ((lanet_u0 is I8) and ((lanet_u1 is I16) and (vcvto_u4 is EXTEND))), then:
  a. Let i8 be lane__u3.
  b. If sx_u5? is defined, then:
    1) Let ?(sx) be sx_u5?.
    2) Let i16 be $ext(8, 16, sx, i8).
    3) Return i16.
2. If ((lanet_u0 is I16) and ((lanet_u1 is I32) and (vcvto_u4 is EXTEND))), then:
  a. Let i16 be lane__u3.
  b. If sx_u5? is defined, then:
    1) Let ?(sx) be sx_u5?.
    2) Let i32 be $ext(16, 32, sx, i16).
    3) Return i32.
3. If (lanet_u0 is I32), then:
  a. If ((lanet_u1 is I64) and (vcvto_u4 is EXTEND)), then:
    1) Let i32 be lane__u3.
    2) If sx_u5? is defined, then:
      a) Let ?(sx) be sx_u5?.
      b) Let i64 be $ext(32, 64, sx, i32).
      c) Return i64.
  b. If ((lanet_u1 is F32) and (vcvto_u4 is CONVERT)), then:
    1) Let i32 be lane__u3.
    2) If sx_u5? is defined, then:
      a) Let ?(sx) be sx_u5?.
      b) Let f32 be $convert(32, 32, sx, i32).
      c) Return f32.
  c. If ((lanet_u1 is F64) and (vcvto_u4 is CONVERT)), then:
    1) Let i32 be lane__u3.
    2) If sx_u5? is defined, then:
      a) Let ?(sx) be sx_u5?.
      b) Let f64 be $convert(32, 64, sx, i32).
      c) Return f64.
4. If ((lanet_u0 is F32) and ((lanet_u1 is I32) and (vcvto_u4 is TRUNC_SAT))), then:
  a. Let f32 be lane__u3.
  b. If sx_u5? is defined, then:
    1) Let ?(sx) be sx_u5?.
    2) Let i32 be $trunc_sat(32, 32, sx, f32).
    3) Return i32.
5. If (lanet_u0 is F64), then:
  a. If ((lanet_u1 is I32) and (vcvto_u4 is TRUNC_SAT)), then:
    1) Let f64 be lane__u3.
    2) If sx_u5? is defined, then:
      a) Let ?(sx) be sx_u5?.
      b) Let i32 be $trunc_sat(64, 32, sx, f64).
      c) Return i32.
  b. If ((lanet_u1 is F32) and (vcvto_u4 is DEMOTE)), then:
    1) Let f64 be lane__u3.
    2) Let f32 be $demote(64, 32, f64).
    3) Return f32.
6. Assert: Due to validation, (lanet_u0 is F32).
7. Assert: Due to validation, (lanet_u1 is F64).
8. Assert: Due to validation, (vcvto_u4 is PROMOTE).
9. Let f32 be lane__u3.
10. Let f64 be $promote(32, 64, f32).
11. Return f64.

vextunop (Inn_1 X N_1) (Inn_2 X N_2) (EXTADD_PAIRWISE sx) c_1
1. Let ci* be $lanes_((Inn_2 X N_2), c_1).
2. Let [cj_1, cj_2]* be $concat_^-1($ext($lsize(Inn_2), $lsize(Inn_1), sx, ci)*).
3. Let c be $invlanes_((Inn_1 X N_1), $iadd($lsize(Inn_1), cj_1, cj_2)*).
4. Return c.

vextbinop (Inn_1 X N_1) (Inn_2 X N_2) vextb_u0 c_1 c_2
1. If vextb_u0 is of the case EXTMUL, then:
  a. Let (EXTMUL sx hf) be vextb_u0.
  b. Let ci_1* be $lanes_((Inn_2 X N_2), c_1)[$halfop(hf, 0, N_1) : N_1].
  c. Let ci_2* be $lanes_((Inn_2 X N_2), c_2)[$halfop(hf, 0, N_1) : N_1].
  d. Let c be $invlanes_((Inn_1 X N_1), $imul($lsize(Inn_1), $ext($lsize(Inn_2), $lsize(Inn_1), sx, ci_1), $ext($lsize(Inn_2), $lsize(Inn_1), sx, ci_2))*).
  e. Return c.
2. Assert: Due to validation, (vextb_u0 is DOT).
3. Let ci_1* be $lanes_((Inn_2 X N_2), c_1).
4. Let ci_2* be $lanes_((Inn_2 X N_2), c_2).
5. Let [cj_1, cj_2]* be $concat_^-1($imul($lsize(Inn_1), $ext($lsize(Inn_2), $lsize(Inn_1), S, ci_1), $ext($lsize(Inn_2), $lsize(Inn_1), S, ci_2))*).
6. Let c be $invlanes_((Inn_1 X N_1), $iadd($lsize(Inn_1), cj_1, cj_2)*).
7. Return c.

vshiftop (Jnn X N) vshif_u0 lane n
1. If (vshif_u0 is SHL), then:
  a. Return $ishl($lsize(Jnn), lane, n).
2. Assert: Due to validation, vshif_u0 is of the case SHR.
3. Let (SHR sx) be vshif_u0.
4. Return $ishr($lsize(Jnn), sx, lane, n).

default_ valty_u0
1. If (valty_u0 is I32), then:
  a. Return (I32.CONST 0).
2. If (valty_u0 is I64), then:
  a. Return (I64.CONST 0).
3. If (valty_u0 is F32), then:
  a. Return (F32.CONST $fzero(32)).
4. If (valty_u0 is F64), then:
  a. Return (F64.CONST $fzero(64)).
5. If (valty_u0 is V128), then:
  a. Return (V128.CONST 0).
6. If (valty_u0 is FUNCREF), then:
  a. Return (REF.NULL FUNCREF).
7. Assert: Due to validation, (valty_u0 is EXTERNREF).
8. Return (REF.NULL EXTERNREF).

funcsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $funcsxv(xv*).

globalsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globalsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $globalsxv(xv*).

tablesxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tablesxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $tablesxv(xv*).

memsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $memsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $memsxv(xv*).

store
1. Return.

frame
1. Let f be the current frame.
2. Return f.

funcaddr
1. Let f be the current frame.
2. Return f.MODULE.FUNCS.

funcinst
1. Return s.FUNCS.

globalinst
1. Return s.GLOBALS.

tableinst
1. Return s.TABLES.

meminst
1. Return s.MEMS.

eleminst
1. Return s.ELEMS.

datainst
1. Return s.DATAS.

moduleinst
1. Let f be the current frame.
2. Return f.MODULE.

type x
1. Let f be the current frame.
2. Return f.MODULE.TYPES[x].

func x
1. Let f be the current frame.
2. Return s.FUNCS[f.MODULE.FUNCS[x]].

global x
1. Let f be the current frame.
2. Return s.GLOBALS[f.MODULE.GLOBALS[x]].

table x
1. Let f be the current frame.
2. Return s.TABLES[f.MODULE.TABLES[x]].

mem x
1. Let f be the current frame.
2. Return s.MEMS[f.MODULE.MEMS[x]].

elem x
1. Let f be the current frame.
2. Return s.ELEMS[f.MODULE.ELEMS[x]].

data x
1. Let f be the current frame.
2. Return s.DATAS[f.MODULE.DATAS[x]].

local x
1. Let f be the current frame.
2. Return f.LOCALS[x].

with_local x v
1. Let f be the current frame.
2. Replace f.LOCALS[x] with v.

with_global x v
1. Let f be the current frame.
2. Replace s.GLOBALS[f.MODULE.GLOBALS[x]].VALUE with v.

with_table x i r
1. Let f be the current frame.
2. Replace s.TABLES[f.MODULE.TABLES[x]].REFS[i] with r.

with_tableinst x ti
1. Let f be the current frame.
2. Replace s.TABLES[f.MODULE.TABLES[x]] with ti.

with_mem x i j b*
1. Let f be the current frame.
2. Replace s.MEMS[f.MODULE.MEMS[x]].BYTES[i : j] with b*.

with_meminst x mi
1. Let f be the current frame.
2. Replace s.MEMS[f.MODULE.MEMS[x]] with mi.

with_elem x r*
1. Let f be the current frame.
2. Replace s.ELEMS[f.MODULE.ELEMS[x]].REFS with r*.

with_data x b*
1. Let f be the current frame.
2. Replace s.DATAS[f.MODULE.DATAS[x]].BYTES with b*.

growtable ti n r
1. Let { TYPE: ((i, j), rt); REFS: r'*; } be ti.
2. Let i' be (|r'*| + n).
3. If (i' ≤ j), then:
  a. Let ti' be { TYPE: ((i', j), rt); REFS: r'* ++ r^n; }.
  b. Return ti'.

growmemory mi n
1. Let { TYPE: (PAGE (i, j)); BYTES: b*; } be mi.
2. Let i' be ((|b*| / (64 · $Ki())) + n).
3. If (i' ≤ j), then:
  a. Let mi' be { TYPE: (PAGE (i', j)); BYTES: b* ++ 0^(n · (64 · $Ki())); }.
  b. Return mi'.

blocktype block_u1
1. If (block_u1 is (_RESULT ?())), then:
  a. Return ([] -> []).
2. If block_u1 is of the case _RESULT, then:
  a. Let (_RESULT y_0) be block_u1.
  b. If y_0 is defined, then:
    1) Let ?(t) be y_0.
    2) Return ([] -> [t]).
3. Assert: Due to validation, block_u1 is of the case _IDX.
4. Let (_IDX x) be block_u1.
5. Return $type(x).

funcs exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcs(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $funcs(externval'*).

globals exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globals(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $globals(externval'*).

tables exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tables(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $tables(externval'*).

mems exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ externval'* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $mems(externval'*).
4. Let [externval] ++ externval'* be exter_u0*.
5. Return $mems(externval'*).

allocfunc moduleinst func
1. Assert: Due to validation, func is of the case FUNC.
2. Let (FUNC x local* expr) be func.
3. Let fi be { TYPE: moduleinst.TYPES[x]; MODULE: moduleinst; CODE: func; }.
4. Let a be |s.FUNCS|.
5. Append fi to the s.FUNCS.
6. Return a.

allocfuncs moduleinst func_u0*
1. If (func_u0* is []), then:
  a. Return [].
2. Let [func] ++ func'* be func_u0*.
3. Let fa be $allocfunc(moduleinst, func).
4. Let fa'* be $allocfuncs(moduleinst, func'*).
5. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let gi be { TYPE: globaltype; VALUE: val; }.
2. Let a be |s.GLOBALS|.
3. Append gi to the s.GLOBALS.
4. Return a.

allocglobals globa_u0* val_u1*
1. If (globa_u0* is []), then:
  a. Assert: Due to validation, (val_u1* is []).
  b. Return [].
2. Else:
  a. Let [globaltype] ++ globaltype'* be globa_u0*.
  b. Assert: Due to validation, (|val_u1*| ≥ 1).
  c. Let [val] ++ val'* be val_u1*.
  d. Let ga be $allocglobal(globaltype, val).
  e. Let ga'* be $allocglobals(globaltype'*, val'*).
  f. Return [ga] ++ ga'*.

alloctable ((i, j), rt)
1. Let ti be { TYPE: ((i, j), rt); REFS: (REF.NULL rt)^i; }.
2. Let a be |s.TABLES|.
3. Append ti to the s.TABLES.
4. Return a.

alloctables table_u0*
1. If (table_u0* is []), then:
  a. Return [].
2. Let [tabletype] ++ tabletype'* be table_u0*.
3. Let ta be $alloctable(tabletype).
4. Let ta'* be $alloctables(tabletype'*).
5. Return [ta] ++ ta'*.

allocmem (PAGE (i, j))
1. Let mi be { TYPE: (PAGE (i, j)); BYTES: 0^(i · (64 · $Ki())); }.
2. Let a be |s.MEMS|.
3. Append mi to the s.MEMS.
4. Return a.

allocmems memty_u0*
1. If (memty_u0* is []), then:
  a. Return [].
2. Let [memtype] ++ memtype'* be memty_u0*.
3. Let ma be $allocmem(memtype).
4. Let ma'* be $allocmems(memtype'*).
5. Return [ma] ++ ma'*.

allocelem rt ref*
1. Let ei be { TYPE: rt; REFS: ref*; }.
2. Let a be |s.ELEMS|.
3. Append ei to the s.ELEMS.
4. Return a.

allocelems refty_u0* ref_u1*
1. If ((refty_u0* is []) and (ref_u1* is [])), then:
  a. Return [].
2. Assert: Due to validation, (|ref_u1*| ≥ 1).
3. Let [ref*] ++ ref'** be ref_u1*.
4. Assert: Due to validation, (|refty_u0*| ≥ 1).
5. Let [rt] ++ rt'* be refty_u0*.
6. Let ea be $allocelem(rt, ref*).
7. Let ea'* be $allocelems(rt'*, ref'**).
8. Return [ea] ++ ea'*.

allocdata byte*
1. Let di be { BYTES: byte*; }.
2. Let a be |s.DATAS|.
3. Append di to the s.DATAS.
4. Return a.

allocdatas byte_u0*
1. If (byte_u0* is []), then:
  a. Return [].
2. Let [byte*] ++ byte'** be byte_u0*.
3. Let da be $allocdata(byte*).
4. Let da'* be $allocdatas(byte'**).
5. Return [da] ++ da'*.

instexport fa* ga* ta* ma* (EXPORT name exter_u0)
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC x) be exter_u0.
  b. Return { NAME: name; VALUE: (FUNC fa*[x]); }.
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be exter_u0.
  b. Return { NAME: name; VALUE: (GLOBAL ga*[x]); }.
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE x) be exter_u0.
  b. Return { NAME: name; VALUE: (TABLE ta*[x]); }.
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM x) be exter_u0.
6. Return { NAME: name; VALUE: (MEM ma*[x]); }.

allocmodule module externval* val* ref**
1. Let fa_ex* be $funcs(externval*).
2. Let ga_ex* be $globals(externval*).
3. Let ma_ex* be $mems(externval*).
4. Let ta_ex* be $tables(externval*).
5. Assert: Due to validation, module is of the case MODULE.
6. Let (MODULE y_0 import* func^n_func y_1 y_2 y_3 y_4 y_5 start? export*) be module.
7. Assert: Due to validation, y_5 is of the case DATA.
8. Let (DATA byte* datamode)^n_data be y_5.
9. Assert: Due to validation, y_4 is of the case ELEM.
10. Let (ELEM rt expr_2* elemmode)^n_elem be y_4.
11. Assert: Due to validation, y_3 is of the case MEMORY.
12. Let (MEMORY memtype)^n_mem be y_3.
13. Assert: Due to validation, y_2 is of the case TABLE.
14. Let (TABLE tabletype)^n_table be y_2.
15. Assert: Due to validation, y_1 is of the case GLOBAL.
16. Let (GLOBAL globaltype expr_1)^n_global be y_1.
17. Assert: Due to validation, y_0 is of the case TYPE.
18. Let (TYPE ft)* be y_0.
19. Let fa* be (|s.FUNCS| + i_func)^(i_func<n_func).
20. Let ga* be (|s.GLOBALS| + i_global)^(i_global<n_global).
21. Let ta* be (|s.TABLES| + i_table)^(i_table<n_table).
22. Let ma* be (|s.MEMS| + i_mem)^(i_mem<n_mem).
23. Let ea* be (|s.ELEMS| + i_elem)^(i_elem<n_elem).
24. Let da* be (|s.DATAS| + i_data)^(i_data<n_data).
25. Let xi* be $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*.
26. Let moduleinst be { TYPES: ft*; FUNCS: fa_ex* ++ fa*; GLOBALS: ga_ex* ++ ga*; TABLES: ta_ex* ++ ta*; MEMS: ma_ex* ++ ma*; ELEMS: ea*; DATAS: da*; EXPORTS: xi*; }.
27. Let y_0 be $allocfuncs(moduleinst, func^n_func).
28. Assert: Due to validation, (y_0 is fa*).
29. Let y_0 be $allocglobals(globaltype^n_global, val*).
30. Assert: Due to validation, (y_0 is ga*).
31. Let y_0 be $alloctables(tabletype^n_table).
32. Assert: Due to validation, (y_0 is ta*).
33. Let y_0 be $allocmems(memtype^n_mem).
34. Assert: Due to validation, (y_0 is ma*).
35. Let y_0 be $allocelems(rt^n_elem, ref**).
36. Assert: Due to validation, (y_0 is ea*).
37. Let y_0 be $allocdatas(byte*^n_data).
38. Assert: Due to validation, (y_0 is da*).
39. Return moduleinst.

runelem (ELEM reftype expr* elemm_u0) i
1. If (elemm_u0 is PASSIVE), then:
  a. Return [].
2. If (elemm_u0 is DECLARE), then:
  a. Return [(ELEM.DROP i)].
3. Assert: Due to validation, elemm_u0 is of the case ACTIVE.
4. Let (ACTIVE x instr*) be elemm_u0.
5. Let n be |expr*|.
6. Return instr* ++ [(I32.CONST 0), (I32.CONST n), (TABLE.INIT x i), (ELEM.DROP i)].

rundata (DATA byte* datam_u0) i
1. If (datam_u0 is PASSIVE), then:
  a. Return [].
2. Assert: Due to validation, datam_u0 is of the case ACTIVE.
3. Let (ACTIVE y_0 instr*) be datam_u0.
4. Assert: Due to validation, (y_0 is 0).
5. Let n be |byte*|.
6. Return instr* ++ [(I32.CONST 0), (I32.CONST n), (MEMORY.INIT i), (DATA.DROP i)].

instantiate module externval*
1. Assert: Due to validation, module is of the case MODULE.
2. Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) be module.
3. Assert: Due to validation, type* is of the case TYPE.
4. Let (TYPE functype)* be type*.
5. Let n_D be |data*|.
6. Let n_E be |elem*|.
7. Let n_F be |func*|.
8. Assert: Due to validation, start? is of the case START.
9. Let (START x)? be start?.
10. Assert: Due to validation, global* is of the case GLOBAL.
11. Let (GLOBAL globaltype expr_G)* be global*.
12. Assert: Due to validation, elem* is of the case ELEM.
13. Let (ELEM reftype expr_E* elemmode)* be elem*.
14. Let instr_D* be $concat_($rundata(data*[j], j)^(j<n_D)).
15. Let instr_E* be $concat_($runelem(elem*[i], i)^(i<n_E)).
16. Let moduleinst_init be { TYPES: functype*; FUNCS: $funcs(externval*) ++ (|s.FUNCS| + i_F)^(i_F<n_F); GLOBALS: $globals(externval*); TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }.
17. Let f_init be { LOCALS: []; MODULE: moduleinst_init; }.
18. Let z be f_init.
19. Push the activation of z to the stack.
20. Let [val]* be $eval_expr(expr_G)*.
21. Pop the activation of z from the stack.
22. Push the activation of z to the stack.
23. Let [ref]** be $eval_expr(expr_E)**.
24. Pop the activation of z from the stack.
25. Let moduleinst be $allocmodule(module, externval*, val*, ref**).
26. Let f be { LOCALS: []; MODULE: moduleinst; }.
27. Push the activation of f with arity 0 to the stack.
28. Execute the sequence (instr_E*).
29. Execute the sequence (instr_D*).
30. If (CALL x)? is defined, then:
  a. Let ?(instr_0) be (CALL x)?.
  b. Execute the instruction instr_0.
31. Pop the activation of f with arity 0 from the stack.
32. Return f.MODULE.

invoke fa val^n
1. Let f be { LOCALS: []; MODULE: { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }; }.
2. Let (t_1^n -> t_2*) be $funcinst()[fa].TYPE.
3. Let k be |t_2*|.
4. Push the activation of f with arity k to the stack.
5. Push the values val^n to the stack.
6. Execute the instruction (CALL_ADDR fa).
7. Pop all values val* from the top of the stack.
8. Pop the activation of f with arity k from the stack.
9. Push the values val* to the stack.
10. Pop the values val^k from the stack.
11. Return val^k.

execution_of_UNREACHABLE
1. Trap.

execution_of_NOP
1. Do nothing.

execution_of_DROP
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Do nothing.

execution_of_SELECT t*?
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value val_2 from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop the value val_1 from the stack.
7. If (c is not 0), then:
  a. Push the value val_1 to the stack.
8. Else:
  a. Push the value val_2 to the stack.

execution_of_IF bt instr_1* instr_2*
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute the instruction (BLOCK bt instr_1*).
4. Else:
  a. Execute the instruction (BLOCK bt instr_2*).

execution_of_LABEL_
1. Pop all values val* from the top of the stack.
2. Assert: Due to validation, a label is now on the top of the stack.
3. Pop the current label from the stack.
4. Push the values val* to the stack.

execution_of_BR n_u0
1. Pop all values val* from the top of the stack.
2. Let L be the current label.
3. Let n be the arity of L.
4. Let instr'* be the continuation of L.
5. Pop the current label from the stack.
6. Let admin_u1* be val*.
7. If ((n_u0 is 0) and (|admin_u1*| ≥ n)), then:
  a. Let val'* ++ val^n be admin_u1*.
  b. Push the values val^n to the stack.
  c. Execute the sequence (instr'*).
8. If (n_u0 ≥ 1), then:
  a. Let l be (n_u0 - 1).
  b. If the type of admin_u1 is val*, then:
    1) Let val* be admin_u1*.
    2) Push the values val* to the stack.
    3) Execute the instruction (BR l).

execution_of_BR_IF l
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute the instruction (BR l).
4. Else:
  a. Do nothing.

execution_of_BR_TABLE l* l'
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST i) from the stack.
3. If (i < |l*|), then:
  a. Execute the instruction (BR l*[i]).
4. Else:
  a. Execute the instruction (BR l').

execution_of_FRAME_
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop the values val^n from the stack.
5. Assert: Due to validation, a frame is now on the top of the stack.
6. Pop the current frame from the stack.
7. Push the values val^n to the stack.

execution_of_RETURN
1. Pop all values val* from the top of the stack.
2. If a frame is now on the top of the stack, then:
  a. Let f be the current frame.
  b. Let n be the arity of f.
  c. Pop the current frame from the stack.
  d. Let val'* ++ val^n be val*.
  e. Push the values val^n to the stack.
3. Else if a label is now on the top of the stack, then:
  a. Pop the current label from the stack.
  b. Push the values val* to the stack.
  c. Execute the instruction RETURN.

execution_of_TRAP
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_UNOP nt unop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_1) from the stack.
3. If (|$unop(nt, unop, c_1)| is 1), then:
  a. Let [c] be $unop(nt, unop, c_1).
  b. Push the value (nt.CONST c) to the stack.
4. If ($unop(nt, unop, c_1) is []), then:
  a. Trap.

execution_of_BINOP nt binop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop the value (nt.CONST c_1) from the stack.
5. If (|$binop(nt, binop, c_1, c_2)| is 1), then:
  a. Let [c] be $binop(nt, binop, c_1, c_2).
  b. Push the value (nt.CONST c) to the stack.
6. If ($binop(nt, binop, c_1, c_2) is []), then:
  a. Trap.

execution_of_TESTOP nt testop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_1) from the stack.
3. Let c be $testop(nt, testop, c_1).
4. Push the value (I32.CONST c) to the stack.

execution_of_RELOP nt relop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop the value (nt.CONST c_1) from the stack.
5. Let c be $relop(nt, relop, c_1, c_2).
6. Push the value (I32.CONST c) to the stack.

execution_of_CVTOP nt_2 nt_1 cvtop
1. Assert: Due to validation, a value of value type nt_1 is on the top of the stack.
2. Pop the value (nt_1.CONST c_1) from the stack.
3. If (|$cvtop(nt_1, nt_2, cvtop, c_1)| is 1), then:
  a. Let [c] be $cvtop(nt_1, nt_2, cvtop, c_1).
  b. Push the value (nt_2.CONST c) to the stack.
4. If ($cvtop(nt_1, nt_2, cvtop, c_1) is []), then:
  a. Trap.

execution_of_REF.IS_NULL
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value ref from the stack.
3. If ref is of the case REF.NULL, then:
  a. Push the value (I32.CONST 1) to the stack.
4. Else:
  a. Push the value (I32.CONST 0) to the stack.

execution_of_VVUNOP V128 vvunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $vvunop(V128, vvunop, c_1).
4. Push the value (V128.CONST c) to the stack.

execution_of_VVBINOP V128 vvbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $vvbinop(V128, vvbinop, c_1, c_2).
6. Push the value (V128.CONST c) to the stack.

execution_of_VVTERNOP V128 vvternop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_3) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_2) from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop the value (V128.CONST c_1) from the stack.
7. Let c be $vvternop(V128, vvternop, c_1, c_2, c_3).
8. Push the value (V128.CONST c) to the stack.

execution_of_VVTESTOP V128 ANY_TRUE
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $ine($size(V128), c_1, 0).
4. Push the value (I32.CONST c) to the stack.

execution_of_VUNOP sh vunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $vunop(sh, vunop, c_1).
4. Push the value (V128.CONST c) to the stack.

execution_of_VBINOP sh vbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. If (|$vbinop(sh, vbinop, c_1, c_2)| is 1), then:
  a. Let [c] be $vbinop(sh, vbinop, c_1, c_2).
  b. Push the value (V128.CONST c) to the stack.
6. If ($vbinop(sh, vbinop, c_1, c_2) is []), then:
  a. Trap.

execution_of_VTESTOP (Jnn X N) ALL_TRUE
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c) from the stack.
3. Let ci_1* be $lanes_((Jnn X N), c).
4. If (ci_1 is not 0)*, then:
  a. Push the value (I32.CONST 1) to the stack.
5. Else:
  a. Push the value (I32.CONST 0) to the stack.

execution_of_VRELOP sh vrelop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $vrelop(sh, vrelop, c_1, c_2).
6. Push the value (V128.CONST c) to the stack.

execution_of_VSHIFTOP (Jnn X N) vshiftop
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c'* be $lanes_((Jnn X N), c_1).
6. Let c be $invlanes_((Jnn X N), $vshiftop((Jnn X N), vshiftop, c', n)*).
7. Push the value (V128.CONST c) to the stack.

execution_of_VBITMASK (Jnn X N)
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c) from the stack.
3. Let ci_1* be $lanes_((Jnn X N), c).
4. Let ci be $ibits_1^-1(32, $ilt($lsize(Jnn), S, ci_1, 0)*).
5. Push the value (I32.CONST ci) to the stack.

execution_of_VSWIZZLE (Pnn X N)
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c* be $lanes_((Pnn X N), c_1) ++ 0^(256 - N).
6. Let ci* be $lanes_((Pnn X N), c_2).
7. Assert: Due to validation, (ci*[k] < |c*|)^(k<N).
8. Assert: Due to validation, (k < |ci*|)^(k<N).
9. Let c' be $invlanes_((Pnn X N), c*[ci*[k]]^(k<N)).
10. Push the value (V128.CONST c') to the stack.

execution_of_VSHUFFLE (Pnn X N) i*
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Assert: Due to validation, (k < |i*|)^(k<N).
6. Let c'* be $lanes_((Pnn X N), c_1) ++ $lanes_((Pnn X N), c_2).
7. Assert: Due to validation, (i*[k] < |c'*|)^(k<N).
8. Let c be $invlanes_((Pnn X N), c'*[i*[k]]^(k<N)).
9. Push the value (V128.CONST c) to the stack.

execution_of_VSPLAT (Lnn X N)
1. Assert: Due to validation, a value of value type $unpack(Lnn) is on the top of the stack.
2. Pop the value (nt_0.CONST c_1) from the stack.
3. Let c be $invlanes_((Lnn X N), $packnum(Lnn, c_1)^N).
4. Push the value (V128.CONST c) to the stack.

execution_of_VEXTRACT_LANE (lanet_u0 X N) sx_u1? i
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. If (sx_u1? is not defined and the type of lanet_u0 is numtype), then:
  a. Let nt be lanet_u0.
  b. If (i < |$lanes_((nt X N), c_1)|), then:
    1) Let c_2 be $lanes_((nt X N), c_1)[i].
    2) Push the value (nt.CONST c_2) to the stack.
4. If the type of lanet_u0 is packtype, then:
  a. Let pt be lanet_u0.
  b. If sx_u1? is defined, then:
    1) Let ?(sx) be sx_u1?.
    2) If (i < |$lanes_((pt X N), c_1)|), then:
      a) Let c_2 be $ext($psize(pt), 32, sx, $lanes_((pt X N), c_1)[i]).
      b) Push the value (I32.CONST c_2) to the stack.

execution_of_VREPLACE_LANE (Lnn X N) i
1. Assert: Due to validation, a value of value type $unpack(Lnn) is on the top of the stack.
2. Pop the value (nt_0.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $invlanes_((Lnn X N), $lanes_((Lnn X N), c_1) with [i] replaced by $packnum(Lnn, c_2)).
6. Push the value (V128.CONST c) to the stack.

execution_of_VEXTUNOP sh_1 sh_2 vextunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $vextunop(sh_1, sh_2, vextunop, c_1).
4. Push the value (V128.CONST c) to the stack.

execution_of_VEXTBINOP sh_1 sh_2 vextbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $vextbinop(sh_1, sh_2, vextbinop, c_1, c_2).
6. Push the value (V128.CONST c) to the stack.

execution_of_VNARROW (Jnn_2 X N_2) (Jnn_1 X N_1) sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let ci_1* be $lanes_((Jnn_1 X N_1), c_1).
6. Let ci_2* be $lanes_((Jnn_1 X N_1), c_2).
7. Let cj_1* be $narrow($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_1)*.
8. Let cj_2* be $narrow($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_2)*.
9. Let c be $invlanes_((Jnn_2 X N_2), cj_1* ++ cj_2*).
10. Push the value (V128.CONST c) to the stack.

execution_of_VCVTOP (lanet_u2 X N_2) (lanet_u3 X N_1) vcvtop half_u0? sx_u1? zero_u4?
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. If (half_u0? is not defined and zero_u4? is not defined), then:
  a. Let Lnn_1 be lanet_u3.
  b. Let Lnn_2 be lanet_u2.
  c. If sx_u1? is defined, then:
    1) Let ?(sx) be sx_u1?.
    2) Let c'* be $lanes_((Lnn_1 X N_1), c_1).
    3) Let c be $invlanes_((Lnn_2 X N_2), $vcvtop((Lnn_1 X N_1), (Lnn_2 X N_2), vcvtop, ?(sx), c')*).
    4) Push the value (V128.CONST c) to the stack.
4. If zero_u4? is not defined, then:
  a. Let Lnn_1 be lanet_u3.
  b. Let Lnn_2 be lanet_u2.
  c. If half_u0? is defined, then:
    1) Let ?(hf) be half_u0?.
    2) Let sx? be sx_u1?.
    3) Let ci* be $lanes_((Lnn_1 X N_1), c_1)[$halfop(hf, 0, N_2) : N_2].
    4) Let c be $invlanes_((Lnn_2 X N_2), $vcvtop((Lnn_1 X N_1), (Lnn_2 X N_2), vcvtop, sx?, ci)*).
    5) Push the value (V128.CONST c) to the stack.
5. If (half_u0? is not defined and ((zero_u4? is ?(ZERO)) and the type of lanet_u3 is numtype)), then:
  a. Let nt_1 be lanet_u3.
  b. If the type of lanet_u2 is numtype, then:
    1) Let nt_2 be lanet_u2.
    2) Let sx? be sx_u1?.
    3) Let ci* be $lanes_((nt_1 X N_1), c_1).
    4) Let c be $invlanes_((nt_2 X N_2), $vcvtop((nt_1 X N_1), (nt_2 X N_2), vcvtop, sx?, ci)* ++ $zero(nt_2)^N_1).
    5) Push the value (V128.CONST c) to the stack.

execution_of_LOCAL.TEE x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Push the value val to the stack.
4. Push the value val to the stack.
5. Execute the instruction (LOCAL.SET x).

execution_of_BLOCK bt instr*
1. Let z be the current state.
2. Let (t_1^k -> t_2^n) be $blocktype(z, bt).
3. Assert: Due to validation, there are at least k values on the top of the stack.
4. Pop the values val^k from the stack.
5. Let L be the label_n{[]}.
6. Enter val^k ++ instr* with label L.

execution_of_LOOP bt instr*
1. Let z be the current state.
2. Let (t_1^k -> t_2^n) be $blocktype(z, bt).
3. Assert: Due to validation, there are at least k values on the top of the stack.
4. Pop the values val^k from the stack.
5. Let L be the label_k{[(LOOP bt instr*)]}.
6. Enter val^k ++ instr* with label L.

execution_of_CALL x
1. Let z be the current state.
2. Assert: Due to validation, (x < |$funcaddr(z)|).
3. Execute the instruction (CALL_ADDR $funcaddr(z)[x]).

execution_of_CALL_INDIRECT x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If (i ≥ |$table(z, x).REFS|), then:
  a. Trap.
5. If $table(z, x).REFS[i] is not of the case REF.FUNC_ADDR, then:
  a. Trap.
6. Let (REF.FUNC_ADDR a) be $table(z, x).REFS[i].
7. If (a ≥ |$funcinst(z)|), then:
  a. Trap.
8. If ($type(z, y) is not $funcinst(z)[a].TYPE), then:
  a. Trap.
9. Execute the instruction (CALL_ADDR a).

execution_of_CALL_ADDR a
1. Let z be the current state.
2. Assert: Due to validation, (a < |$funcinst(z)|).
3. Let { TYPE: (t_1^k -> t_2^n); MODULE: mm; CODE: func; } be $funcinst(z)[a].
4. Assert: Due to validation, there are at least k values on the top of the stack.
5. Pop the values val^k from the stack.
6. Assert: Due to validation, func is of the case FUNC.
7. Let (FUNC x y_0 instr*) be func.
8. Assert: Due to validation, y_0 is of the case LOCAL.
9. Let (LOCAL t)* be y_0.
10. Let f be { LOCALS: val^k ++ $default_(t)*; MODULE: mm; }.
11. Let F be the activation of f with arity n.
12. Push F to the stack.
13. Let L be the label_n{[]}.
14. Enter instr* with label L.

execution_of_REF.FUNC x
1. Let z be the current state.
2. Assert: Due to validation, (x < |$funcaddr(z)|).
3. Push the value (REF.FUNC_ADDR $funcaddr(z)[x]) to the stack.

execution_of_LOCAL.GET x
1. Let z be the current state.
2. Push the value $local(z, x) to the stack.

execution_of_GLOBAL.GET x
1. Let z be the current state.
2. Push the value $global(z, x).VALUE to the stack.

execution_of_TABLE.GET x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If (i ≥ |$table(z, x).REFS|), then:
  a. Trap.
5. Push the value $table(z, x).REFS[i] to the stack.

execution_of_TABLE.SIZE x
1. Let z be the current state.
2. Let n be |$table(z, x).REFS|.
3. Push the value (I32.CONST n) to the stack.

execution_of_TABLE.FILL x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value val from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. If ((i + n) > |$table(z, x).REFS|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else:
  a. Push the value (I32.CONST i) to the stack.
  b. Push the value val to the stack.
  c. Execute the instruction (TABLE.SET x).
  d. Push the value (I32.CONST (i + 1)) to the stack.
  e. Push the value val to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (TABLE.FILL x).

execution_of_TABLE.COPY x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$table(z, y).REFS|), then:
  a. Trap.
9. If ((j + n) > |$table(z, x).REFS|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else:
  a. If (j ≤ i), then:
    1) Push the value (I32.CONST j) to the stack.
    2) Push the value (I32.CONST i) to the stack.
    3) Execute the instruction (TABLE.GET y).
    4) Execute the instruction (TABLE.SET x).
    5) Push the value (I32.CONST (j + 1)) to the stack.
    6) Push the value (I32.CONST (i + 1)) to the stack.
  b. Else:
    1) Push the value (I32.CONST ((j + n) - 1)) to the stack.
    2) Push the value (I32.CONST ((i + n) - 1)) to the stack.
    3) Execute the instruction (TABLE.GET y).
    4) Execute the instruction (TABLE.SET x).
    5) Push the value (I32.CONST j) to the stack.
    6) Push the value (I32.CONST i) to the stack.
  c. Push the value (I32.CONST (n - 1)) to the stack.
  d. Execute the instruction (TABLE.COPY x y).

execution_of_TABLE.INIT x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$elem(z, y).REFS|), then:
  a. Trap.
9. If ((j + n) > |$table(z, x).REFS|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else if (i < |$elem(z, y).REFS|), then:
  a. Push the value (I32.CONST j) to the stack.
  b. Push the value $elem(z, y).REFS[i] to the stack.
  c. Execute the instruction (TABLE.SET x).
  d. Push the value (I32.CONST (j + 1)) to the stack.
  e. Push the value (I32.CONST (i + 1)) to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (TABLE.INIT x y).

execution_of_LOAD numty_u0 sz_sx_u1? ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If sz_sx_u1? is not defined, then:
  a. Let nt be numty_u0.
  b. If (((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, 0).BYTES|), then:
    1) Trap.
  c. Let c be $nbytes_1^-1(nt, $mem(z, 0).BYTES[(i + ao.OFFSET) : ($size(nt) / 8)]).
  d. Push the value (nt.CONST c) to the stack.
5. If the type of numty_u0 is Inn, then:
  a. If sz_sx_u1? is defined, then:
    1) Let ?(y_0) be sz_sx_u1?.
    2) Let (n, sx) be y_0.
    3) If (((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|), then:
      a) Trap.
  b. Let Inn be numty_u0.
  c. If sz_sx_u1? is defined, then:
    1) Let ?(y_0) be sz_sx_u1?.
    2) Let (n, sx) be y_0.
    3) Let c be $ibytes_1^-1(n, $mem(z, 0).BYTES[(i + ao.OFFSET) : (n / 8)]).
    4) Push the value (Inn.CONST $ext(n, $size(Inn), sx, c)) to the stack.

execution_of_VLOAD V128 vload_u0? ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If ((((i + ao.OFFSET) + ($size(V128) / 8)) > |$mem(z, 0).BYTES|) and vload_u0? is not defined), then:
  a. Trap.
5. If vload_u0? is not defined, then:
  a. Let c be $vbytes_1^-1(V128, $mem(z, 0).BYTES[(i + ao.OFFSET) : ($size(V128) / 8)]).
  b. Push the value (V128.CONST c) to the stack.
6. Else:
  a. Let ?(y_0) be vload_u0?.
  b. If y_0 is of the case SHAPE, then:
    1) Let (SHAPE M N sx) be y_0.
    2) If (((i + ao.OFFSET) + ((M · N) / 8)) > |$mem(z, 0).BYTES|), then:
      a) Trap.
    3) If the type of $lsize^-1((M · 2)) is Jnn, then:
      a) Let Jnn be $lsize^-1((M · 2)).
      b) Let j^N be $ibytes_1^-1(M, $mem(z, 0).BYTES[((i + ao.OFFSET) + ((k · M) / 8)) : (M / 8)])^(k<N).
      c) Let c be $invlanes_((Jnn X N), $ext(M, $lsize(Jnn), sx, j)^N).
      d) Push the value (V128.CONST c) to the stack.
  c. If y_0 is of the case SPLAT, then:
    1) Let (SPLAT N) be y_0.
    2) If (((i + ao.OFFSET) + (N / 8)) > |$mem(z, 0).BYTES|), then:
      a) Trap.
    3) Let M be (128 / N).
    4) If the type of $lsize^-1(N) is Jnn, then:
      a) Let Jnn be $lsize^-1(N).
      b) Let j be $ibytes_1^-1(N, $mem(z, 0).BYTES[(i + ao.OFFSET) : (N / 8)]).
      c) Let c be $invlanes_((Jnn X M), j^M).
      d) Push the value (V128.CONST c) to the stack.
  d. If y_0 is of the case ZERO, then:
    1) Let (ZERO N) be y_0.
    2) If (((i + ao.OFFSET) + (N / 8)) > |$mem(z, 0).BYTES|), then:
      a) Trap.
    3) Let j be $ibytes_1^-1(N, $mem(z, 0).BYTES[(i + ao.OFFSET) : (N / 8)]).
    4) Let c be $ext(N, 128, U, j).
    5) Push the value (V128.CONST c) to the stack.

execution_of_VLOAD_LANE V128 N ao j
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value (V128.CONST c_1) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (((i + ao.OFFSET) + (N / 8)) > |$mem(z, 0).BYTES|), then:
  a. Trap.
7. Let M be (128 / N).
8. If the type of $lsize^-1(N) is Jnn, then:
  a. Let Jnn be $lsize^-1(N).
  b. Let k be $ibytes_1^-1(N, $mem(z, 0).BYTES[(i + ao.OFFSET) : (N / 8)]).
  c. Let c be $invlanes_((Jnn X M), $lanes_((Jnn X M), c_1) with [j] replaced by k).
  d. Push the value (V128.CONST c) to the stack.

execution_of_MEMORY.SIZE
1. Let z be the current state.
2. Let ((n · 64) · $Ki()) be |$mem(z, 0).BYTES|.
3. Push the value (I32.CONST n) to the stack.

execution_of_MEMORY.FILL
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value val from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. If ((i + n) > |$mem(z, 0).BYTES|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else:
  a. Push the value (I32.CONST i) to the stack.
  b. Push the value val to the stack.
  c. Execute the instruction (STORE I32 ?(8) $memarg0()).
  d. Push the value (I32.CONST (i + 1)) to the stack.
  e. Push the value val to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction MEMORY.FILL.

execution_of_MEMORY.COPY
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$mem(z, 0).BYTES|), then:
  a. Trap.
9. If ((j + n) > |$mem(z, 0).BYTES|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else:
  a. If (j ≤ i), then:
    1) Push the value (I32.CONST j) to the stack.
    2) Push the value (I32.CONST i) to the stack.
    3) Execute the instruction (LOAD I32 ?((8, U)) $memarg0()).
    4) Execute the instruction (STORE I32 ?(8) $memarg0()).
    5) Push the value (I32.CONST (j + 1)) to the stack.
    6) Push the value (I32.CONST (i + 1)) to the stack.
  b. Else:
    1) Push the value (I32.CONST ((j + n) - 1)) to the stack.
    2) Push the value (I32.CONST ((i + n) - 1)) to the stack.
    3) Execute the instruction (LOAD I32 ?((8, U)) $memarg0()).
    4) Execute the instruction (STORE I32 ?(8) $memarg0()).
    5) Push the value (I32.CONST j) to the stack.
    6) Push the value (I32.CONST i) to the stack.
  c. Push the value (I32.CONST (n - 1)) to the stack.
  d. Execute the instruction MEMORY.COPY.

execution_of_MEMORY.INIT x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$data(z, x).BYTES|), then:
  a. Trap.
9. If ((j + n) > |$mem(z, 0).BYTES|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else if (i < |$data(z, x).BYTES|), then:
  a. Push the value (I32.CONST j) to the stack.
  b. Push the value (I32.CONST $data(z, x).BYTES[i]) to the stack.
  c. Execute the instruction (STORE I32 ?(8) $memarg0()).
  d. Push the value (I32.CONST (j + 1)) to the stack.
  e. Push the value (I32.CONST (i + 1)) to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (MEMORY.INIT x).

execution_of_CTXT
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_LOCAL.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Perform $with_local(z, x, val).

execution_of_GLOBAL.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Perform $with_global(z, x, val).

execution_of_TABLE.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value ref from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (i ≥ |$table(z, x).REFS|), then:
  a. Trap.
7. Perform $with_table(z, x, i, ref).

execution_of_TABLE.GROW x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value ref from the stack.
6. Either:
  a. Let ti be $growtable($table(z, x), n, ref).
  b. Push the value (I32.CONST |$table(z, x).REFS|) to the stack.
  c. Perform $with_tableinst(z, x, ti).
7. Or:
  a. Push the value (I32.CONST $invsigned(32, (- 1))) to the stack.

execution_of_ELEM.DROP x
1. Let z be the current state.
2. Perform $with_elem(z, x, []).

execution_of_STORE numty_u1 sz_u2? ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type numty_u0 is on the top of the stack.
3. Pop the value (numty_u0.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If sz_u2? is not defined, then:
  a. Let nt be numty_u1.
  b. If ((((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, 0).BYTES|) and (numty_u0 is nt)), then:
    1) Trap.
  c. If (numty_u0 is nt), then:
    1) Let b* be $nbytes(nt, c).
    2) Perform $with_mem(z, 0, (i + ao.OFFSET), ($size(nt) / 8), b*).
7. Else:
  a. Let ?(n) be sz_u2?.
  b. If the type of numty_u1 is Inn, then:
    1) Let Inn be numty_u1.
    2) If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|) and (numty_u0 is Inn)), then:
      a) Trap.
    3) If (numty_u0 is Inn), then:
      a) Let b* be $ibytes(n, $wrap($size(Inn), n, c)).
      b) Perform $with_mem(z, 0, (i + ao.OFFSET), (n / 8), b*).

execution_of_VSTORE V128 ao
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value (V128.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (((i + ao.OFFSET) + ($size(V128) / 8)) > |$mem(z, 0).BYTES|), then:
  a. Trap.
7. Let b* be $vbytes(V128, c).
8. Perform $with_mem(z, 0, (i + ao.OFFSET), ($size(V128) / 8), b*).

execution_of_VSTORE_LANE V128 N ao j
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value (V128.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (((i + ao.OFFSET) + N) > |$mem(z, 0).BYTES|), then:
  a. Trap.
7. Let M be (128 / N).
8. If the type of $lsize^-1(N) is Jnn, then:
  a. Let Jnn be $lsize^-1(N).
  b. If (j < |$lanes_((Jnn X M), c)|), then:
    1) Let b* be $ibytes(N, $lanes_((Jnn X M), c)[j]).
    2) Perform $with_mem(z, 0, (i + ao.OFFSET), (N / 8), b*).

execution_of_MEMORY.GROW
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Either:
  a. Let mi be $growmemory($mem(z, 0), n).
  b. Push the value (I32.CONST (|$mem(z, 0).BYTES| / (64 · $Ki()))) to the stack.
  c. Perform $with_meminst(z, 0, mi).
5. Or:
  a. Push the value (I32.CONST $invsigned(32, (- 1))) to the stack.

execution_of_DATA.DROP x
1. Let z be the current state.
2. Perform $with_data(z, x, []).

eval_expr instr*
1. Execute the sequence (instr*).
2. Pop the value val from the stack.
3. Return [val].

group_bytes_by n byte*
1. Let n' be |byte*|.
2. If (n' ≥ n), then:
  a. Return [byte*[0 : n]] ++ $group_bytes_by(n, byte*[n : (n' - n)]).
3. Return [].

execution_of_ARRAY.NEW_DATA x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If $expanddt($type(z, x)) is of the case ARRAY, then:
  a. Let (ARRAY y_0) be $expanddt($type(z, x)).
  b. Let (mut, zt) be y_0.
  c. If ((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|), then:
    1) Trap.
  d. Let cnn be $cunpack(zt).
  e. Let b* be $data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)].
  f. Let gb* be $group_bytes_by(($zsize(zt) / 8), b*).
  g. Let c^n be $inverse_of_ibytes($zsize(zt), gb)*.
  h. Push the values (cnn.CONST c)^n to the stack.
  i. Execute the instruction (ARRAY.NEW_FIXED x n).
== Complete.
Generating prose for Wasm 3.0...
watsup 0.4 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions...
== IL Validation after pass sideconditions...
== Running pass animate...
== IL Validation after pass animate...
== Translating to AL...
== Prose Generation...
6-typing.watsup:627.7-627.45: prem_to_instrs: Yet `Resulttype_sub: `%|-%<:%`(C, t*{t : valtype}, C.LABELS_context[l!`%`_labelidx.0]!`%`_resulttype.0)`
6-typing.watsup:628.6-628.45: prem_to_instrs: Yet `Resulttype_sub: `%|-%<:%`(C, t*{t : valtype}, C.LABELS_context[l'!`%`_labelidx.0]!`%`_resulttype.0)`
6-typing.watsup:645.6-645.36: prem_to_instrs: Yet `Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)`
6-typing.watsup:646.6-646.34: prem_to_instrs: Yet `Reftype_sub: `%|-%<:%`(C, rt_2, rt)`
6-typing.watsup:653.6-653.36: prem_to_instrs: Yet `Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)`
6-typing.watsup:654.6-654.49: prem_to_instrs: Yet `Reftype_sub: `%|-%<:%`(C, $diffrt(rt_1, rt_2), rt)`
6-typing.watsup:670.6-670.45: prem_to_instrs: Yet `Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`_nul(?(())), FUNC_heaptype))`
6-typing.watsup:683.6-683.40: prem_to_instrs: Yet `Resulttype_sub: `%|-%<:%`(C, t_2*{t_2 : valtype}, t'_2*{t'_2 : valtype})`
6-typing.watsup:691.6-691.40: prem_to_instrs: Yet `Resulttype_sub: `%|-%<:%`(C, t_2*{t_2 : valtype}, t'_2*{t'_2 : valtype})`
6-typing.watsup:698.6-698.45: prem_to_instrs: Yet `Reftype_sub: `%|-%<:%`(C, rt, REF_reftype(`NULL%?`_nul(?(())), FUNC_heaptype))`
6-typing.watsup:702.6-702.40: prem_to_instrs: Yet `Resulttype_sub: `%|-%<:%`(C, t_2*{t_2 : valtype}, t'_2*{t'_2 : valtype})`
6-typing.watsup:756.6-756.33: prem_to_instrs: Yet `Reftype_sub: `%|-%<:%`(C, rt, rt')`
6-typing.watsup:762.6-762.33: prem_to_instrs: Yet `Reftype_sub: `%|-%<:%`(C, rt, rt')`
6-typing.watsup:780.7-780.38: prem_to_instrs: Yet `where ?(val) = $default_($unpack(zt))`
6-typing.watsup:812.6-812.40: prem_to_instrs: Yet `Reftype_sub: `%|-%<:%`(C, C.ELEMS_context[y!`%`_idx.0], rt)`
6-typing.watsup:841.6-841.40: prem_to_instrs: Yet `Storagetype_sub: `%|-%<:%`(C, zt_2, zt_1)`
6-typing.watsup:846.6-846.44: prem_to_instrs: Yet `Storagetype_sub: `%|-%<:%`(C, (C.ELEMS_context[y!`%`_idx.0] : reftype <: storagetype), zt)`
6-typing.watsup:983.6-983.36: prem_to_instrs: Yet `Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)`
6-typing.watsup:989.6-989.36: prem_to_instrs: Yet `Reftype_sub: `%|-%<:%`(C, rt_2, rt_1)`
=================
 Generated prose
=================
validation_of_NOP
- The instruction is valid with type ([] ->_ [] ++ []).

validation_of_UNREACHABLE
- Under the context C, (t_1* ->_ [] ++ t_2*) must be valid.
- The instruction is valid with type (t_1* ->_ [] ++ t_2*).

validation_of_DROP
- Under the context C, t must be valid.
- The instruction is valid with type ([t] ->_ [] ++ []).

validation_of_SELECT ?([t])
- Under the context C, t must be valid.
- The instruction is valid with type ([t, t, I32] ->_ [] ++ [t]).

validation_of_BLOCK bt instr*
- Under the context C with .LABELS prepended by [t_2*], instr* must be valid with type (t_1* ->_ x* ++ t_2*).
- Under the context C, bt must be valid with type (t_1* ->_ [] ++ t_2*).
- The instruction is valid with type (t_1* ->_ [] ++ t_2*).

validation_of_LOOP bt instr*
- Under the context C with .LABELS prepended by [t_1*], instr* must be valid with type (t_1* ->_ x* ++ t_2*).
- Under the context C, bt must be valid with type (t_1* ->_ [] ++ t_2*).
- The instruction is valid with type (t_1* ->_ [] ++ t_2*).

validation_of_IF bt instr_1* instr_2*
- Under the context C with .LABELS prepended by [t_2*], instr_1* must be valid with type (t_1* ->_ x_1* ++ t_2*).
- Under the context C, bt must be valid with type (t_1* ->_ [] ++ t_2*).
- Under the context C with .LABELS prepended by [t_2*], instr_2* must be valid with type (t_1* ->_ x_2* ++ t_2*).
- The instruction is valid with type (t_1* ++ [I32] ->_ [] ++ t_2*).

validation_of_BR l
- |C.LABELS| must be greater than l.
- Let t* be C.LABELS[l].
- Under the context C, (t_1* ->_ [] ++ t_2*) must be valid.
- The instruction is valid with type (t_1* ++ t* ->_ [] ++ t_2*).

validation_of_BR_IF l
- |C.LABELS| must be greater than l.
- Let t* be C.LABELS[l].
- The instruction is valid with type (t* ++ [I32] ->_ [] ++ t*).

validation_of_BR_TABLE l* l'
- For all l in l*,
  - |C.LABELS| must be greater than l.
- |C.LABELS| must be greater than l'.
- For all l in l*,
  - Yet: TODO: prem_to_instrs rule_sub
- Yet: TODO: prem_to_instrs rule_sub
- Under the context C, (t_1* ->_ [] ++ t_2*) must be valid.
- The instruction is valid with type (t_1* ++ t* ->_ [] ++ t_2*).

validation_of_BR_ON_NULL l
- |C.LABELS| must be greater than l.
- Under the context C, ht must be valid.
- Let t* be C.LABELS[l].
- The instruction is valid with type (t* ++ [(REF (NULL ?(())) ht)] ->_ [] ++ t* ++ [(REF (NULL ?()) ht)]).

validation_of_BR_ON_NON_NULL l
- |C.LABELS| must be greater than l.
- Let t* ++ [(REF (NULL ?()) ht)] be C.LABELS[l].
- The instruction is valid with type (t* ++ [(REF (NULL ?(())) ht)] ->_ [] ++ t*).

validation_of_BR_ON_CAST l rt_1 rt_2
- |C.LABELS| must be greater than l.
- Under the context C, rt_1 must be valid.
- Under the context C, rt_2 must be valid.
- Yet: TODO: prem_to_instrs rule_sub
- Let t* ++ [rt] be C.LABELS[l].
- Yet: TODO: prem_to_instrs rule_sub
- The instruction is valid with type (t* ++ [rt_1] ->_ [] ++ t* ++ [$diffrt(rt_1, rt_2)]).

validation_of_BR_ON_CAST_FAIL l rt_1 rt_2
- |C.LABELS| must be greater than l.
- Under the context C, rt_1 must be valid.
- Under the context C, rt_2 must be valid.
- Yet: TODO: prem_to_instrs rule_sub
- Let t* ++ [rt] be C.LABELS[l].
- Yet: TODO: prem_to_instrs rule_sub
- The instruction is valid with type (t* ++ [rt_1] ->_ [] ++ t* ++ [rt_2]).

validation_of_CALL x
- |C.FUNCS| must be greater than x.
- Let (FUNC (t_1* -> t_2*)) be $expanddt(C.FUNCS[x]).
- The instruction is valid with type (t_1* ->_ [] ++ t_2*).

validation_of_CALL_REF $idx(x)
- |C.TYPES| must be greater than x.
- Let (FUNC (t_1* -> t_2*)) be $expanddt(C.TYPES[x]).
- The instruction is valid with type (t_1* ++ [(REF (NULL ?(())) $idx(x))] ->_ [] ++ t_2*).

validation_of_CALL_INDIRECT x $idx(y)
- |C.TABLES| must be greater than x.
- |C.TYPES| must be greater than y.
- Let (lim, rt) be C.TABLES[x].
- Let (FUNC (t_1* -> t_2*)) be $expanddt(C.TYPES[y]).
- Yet: TODO: prem_to_instrs rule_sub
- The instruction is valid with type (t_1* ++ [I32] ->_ [] ++ t_2*).

validation_of_RETURN
- Let ?(t*) be C.RETURN.
- Under the context C, (t_1* ->_ [] ++ t_2*) must be valid.
- The instruction is valid with type (t_1* ++ t* ->_ [] ++ t_2*).

validation_of_RETURN_CALL x
- |C.FUNCS| must be greater than x.
- Under the context C, (t_3* ->_ [] ++ t_4*) must be valid.
- Let (FUNC (t_1* -> t_2*)) be $expanddt(C.FUNCS[x]).
- Yet: TODO: prem_to_instrs rule_sub
- C.RETURN must be equal to ?(t'_2*).
- The instruction is valid with type (t_3* ++ t_1* ->_ [] ++ t_4*).

validation_of_RETURN_CALL_REF $idx(x)
- |C.TYPES| must be greater than x.
- Under the context C, (t_3* ->_ [] ++ t_4*) must be valid.
- Let (FUNC (t_1* -> t_2*)) be $expanddt(C.TYPES[x]).
- Yet: TODO: prem_to_instrs rule_sub
- C.RETURN must be equal to ?(t'_2*).
- The instruction is valid with type (t_3* ++ t_1* ++ [(REF (NULL ?(())) $idx(x))] ->_ [] ++ t_4*).

validation_of_RETURN_CALL_INDIRECT x $idx(y)
- |C.TABLES| must be greater than x.
- |C.TYPES| must be greater than y.
- Under the context C, (t_3* ->_ [] ++ t_4*) must be valid.
- Let (lim, rt) be C.TABLES[x].
- Let (FUNC (t_1* -> t_2*)) be $expanddt(C.TYPES[y]).
- Yet: TODO: prem_to_instrs rule_sub
- Yet: TODO: prem_to_instrs rule_sub
- C.RETURN must be equal to ?(t'_2*).
- The instruction is valid with type (t_3* ++ t_1* ++ [I32] ->_ [] ++ t_4*).

validation_of_CONST nt c_nt
- The instruction is valid with type ([] ->_ [] ++ [nt]).

validation_of_UNOP nt unop_nt
- The instruction is valid with type ([nt] ->_ [] ++ [nt]).

validation_of_BINOP nt binop_nt
- The instruction is valid with type ([nt, nt] ->_ [] ++ [nt]).

validation_of_TESTOP nt testop_nt
- The instruction is valid with type ([nt] ->_ [] ++ [I32]).

validation_of_RELOP nt relop_nt
- The instruction is valid with type ([nt, nt] ->_ [] ++ [I32]).

validation_of_CVTOP nt_1 nt_2 cvtop
- The instruction is valid with type ([nt_2] ->_ [] ++ [nt_1]).

validation_of_REF.NULL ht
- Under the context C, ht must be valid.
- The instruction is valid with type ([] ->_ [] ++ [(REF (NULL ?(())) ht)]).

validation_of_REF.FUNC x
- |C.FUNCS| must be greater than x.
- x must be contained in C.REFS.
- Let dt be C.FUNCS[x].
- The instruction is valid with type ([] ->_ [] ++ [(REF (NULL ?()) dt)]).

validation_of_REF.I31
- The instruction is valid with type ([I32] ->_ [] ++ [(REF (NULL ?()) I31)]).

validation_of_REF.IS_NULL
- Under the context C, ht must be valid.
- The instruction is valid with type ([(REF (NULL ?(())) ht)] ->_ [] ++ [I32]).

validation_of_REF.AS_NON_NULL
- Under the context C, ht must be valid.
- The instruction is valid with type ([(REF (NULL ?(())) ht)] ->_ [] ++ [(REF (NULL ?()) ht)]).

validation_of_REF.EQ
- The instruction is valid with type ([(REF (NULL ?(())) EQ), (REF (NULL ?(())) EQ)] ->_ [] ++ [I32]).

validation_of_REF.TEST rt
- Under the context C, rt must be valid.
- Yet: TODO: prem_to_instrs rule_sub
- Under the context C, rt' must be valid.
- The instruction is valid with type ([rt'] ->_ [] ++ [I32]).

validation_of_REF.CAST rt
- Under the context C, rt must be valid.
- Yet: TODO: prem_to_instrs rule_sub
- Under the context C, rt' must be valid.
- The instruction is valid with type ([rt'] ->_ [] ++ [rt]).

validation_of_I31.GET sx
- The instruction is valid with type ([(REF (NULL ?(())) I31)] ->_ [] ++ [I32]).

validation_of_STRUCT.NEW x
- |C.TYPES| must be greater than x.
- Let (STRUCT (mut, zt)*) be $expanddt(C.TYPES[x]).
- |zt*| must be equal to |mut*|.
- The instruction is valid with type ($unpack(zt)* ->_ [] ++ [(REF (NULL ?()) $idx(x))]).

validation_of_STRUCT.NEW_DEFAULT x
- |C.TYPES| must be greater than x.
- Let (STRUCT (mut, zt)*) be $expanddt(C.TYPES[x]).
- |zt*| must be equal to |mut*|.
- Yet: TODO: prem_to_intrs iter
- |zt*| must be equal to |val*|.
- The instruction is valid with type ([] ->_ [] ++ [(REF (NULL ?()) $idx(x))]).

validation_of_STRUCT.GET sx? x i
- |C.TYPES| must be greater than x.
- Let (STRUCT yt*) be $expanddt(C.TYPES[x]).
- |yt*| must be greater than i.
- Let (mut, zt) be yt*[i].
- ((zt is $unpack(zt))) if and only if ((sx? is ?())).
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x))] ->_ [] ++ [$unpack(zt)]).

validation_of_STRUCT.SET x i
- |C.TYPES| must be greater than x.
- Let (STRUCT yt*) be $expanddt(C.TYPES[x]).
- |yt*| must be greater than i.
- Let ((MUT ?(())), zt) be yt*[i].
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x)), $unpack(zt)] ->_ [] ++ []).

validation_of_ARRAY.NEW x
- |C.TYPES| must be greater than x.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPES[x]).
- The instruction is valid with type ([$unpack(zt), I32] ->_ [] ++ [(REF (NULL ?()) $idx(x))]).

validation_of_ARRAY.NEW_DEFAULT x
- |C.TYPES| must be greater than x.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPES[x]).
- Let ?(val) be $default_($unpack(zt)).
- The instruction is valid with type ([I32] ->_ [] ++ [(REF (NULL ?()) $idx(x))]).

validation_of_ARRAY.NEW_FIXED x n
- |C.TYPES| must be greater than x.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPES[x]).
- The instruction is valid with type ($unpack(zt)^n ->_ [] ++ [(REF (NULL ?()) $idx(x))]).

validation_of_ARRAY.NEW_ELEM x y
- |C.TYPES| must be greater than x.
- |C.ELEMS| must be greater than y.
- Let (ARRAY (mut, rt)) be $expanddt(C.TYPES[x]).
- Yet: TODO: prem_to_instrs rule_sub
- The instruction is valid with type ([I32, I32] ->_ [] ++ [(REF (NULL ?()) $idx(x))]).

validation_of_ARRAY.NEW_DATA x y
- |C.TYPES| must be greater than x.
- |C.DATAS| must be greater than y.
- C.DATAS[y] must be equal to OK.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPES[x]).
- Let numtype be $unpack(zt).
- The instruction is valid with type ([I32, I32] ->_ [] ++ [(REF (NULL ?()) $idx(x))]).

validation_of_ARRAY.GET sx? x
- |C.TYPES| must be greater than x.
- Let (ARRAY (mut, zt)) be $expanddt(C.TYPES[x]).
- ((zt is $unpack(zt))) if and only if ((sx? is ?())).
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x)), I32] ->_ [] ++ [$unpack(zt)]).

validation_of_ARRAY.SET x
- |C.TYPES| must be greater than x.
- Let (ARRAY ((MUT ?(())), zt)) be $expanddt(C.TYPES[x]).
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x)), I32, $unpack(zt)] ->_ [] ++ []).

validation_of_ARRAY.LEN
- Let $expanddt(C.TYPES[x]) be (ARRAY ((MUT ?(())), zt)).
- |C.TYPES| must be greater than x.
- The instruction is valid with type ([(REF (NULL ?(())) ARRAY)] ->_ [] ++ [I32]).

validation_of_ARRAY.FILL x
- |C.TYPES| must be greater than x.
- Let (ARRAY ((MUT ?(())), zt)) be $expanddt(C.TYPES[x]).
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x)), I32, $unpack(zt), I32] ->_ [] ++ []).

validation_of_ARRAY.COPY x_1 x_2
- |C.TYPES| must be greater than x_1.
- |C.TYPES| must be greater than x_2.
- Let (ARRAY (mut, zt_2)) be $expanddt(C.TYPES[x_2]).
- Yet: TODO: prem_to_instrs rule_sub
- $expanddt(C.TYPES[x_1]) must be equal to (ARRAY ((MUT ?(())), zt_1)).
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x_1)), I32, (REF (NULL ?(())) $idx(x_2)), I32, I32] ->_ [] ++ []).

validation_of_ARRAY.INIT_ELEM x y
- |C.TYPES| must be greater than x.
- |C.ELEMS| must be greater than y.
- Yet: TODO: prem_to_instrs rule_sub
- $expanddt(C.TYPES[x]) must be equal to (ARRAY ((MUT ?(())), zt)).
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x)), I32, I32, I32] ->_ [] ++ []).

validation_of_ARRAY.INIT_DATA x y
- |C.TYPES| must be greater than x.
- |C.DATAS| must be greater than y.
- C.DATAS[y] must be equal to OK.
- Let (ARRAY ((MUT ?(())), zt)) be $expanddt(C.TYPES[x]).
- Let numtype be $unpack(zt).
- The instruction is valid with type ([(REF (NULL ?(())) $idx(x)), I32, I32, I32] ->_ [] ++ []).

validation_of_EXTERN.CONVERT_ANY
- The instruction is valid with type ([(REF nul ANY)] ->_ [] ++ [(REF nul EXTERN)]).

validation_of_ANY.CONVERT_EXTERN
- The instruction is valid with type ([(REF nul EXTERN)] ->_ [] ++ [(REF nul ANY)]).

validation_of_VCONST V128 c
- The instruction is valid with type ([] ->_ [] ++ [V128]).

validation_of_VVUNOP V128 vvunop
- The instruction is valid with type ([V128] ->_ [] ++ [V128]).

validation_of_VVBINOP V128 vvbinop
- The instruction is valid with type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VVTERNOP V128 vvternop
- The instruction is valid with type ([V128, V128, V128] ->_ [] ++ [V128]).

validation_of_VVTESTOP V128 vvtestop
- The instruction is valid with type ([V128] ->_ [] ++ [I32]).

validation_of_VUNOP sh vunop
- The instruction is valid with type ([V128] ->_ [] ++ [V128]).

validation_of_VBINOP sh vbinop
- The instruction is valid with type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VTESTOP sh vtestop
- The instruction is valid with type ([V128] ->_ [] ++ [I32]).

validation_of_VRELOP sh vrelop
- The instruction is valid with type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VSHIFTOP sh vshiftop
- The instruction is valid with type ([V128, I32] ->_ [] ++ [V128]).

validation_of_VBITMASK sh
- The instruction is valid with type ([V128] ->_ [] ++ [I32]).

validation_of_VSWIZZLE sh
- The instruction is valid with type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VSHUFFLE sh i*
- For all i in i*,
  - i must be less than (2 · $dim(sh)).
- The instruction is valid with type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VSPLAT sh
- The instruction is valid with type ([$unpackshape(sh)] ->_ [] ++ [V128]).

validation_of_VEXTRACT_LANE sh sx? i
- i must be less than $dim(sh).
- The instruction is valid with type ([V128] ->_ [] ++ [$unpackshape(sh)]).

validation_of_VREPLACE_LANE sh i
- i must be less than $dim(sh).
- The instruction is valid with type ([V128, $unpackshape(sh)] ->_ [] ++ [V128]).

validation_of_VEXTUNOP sh_1 sh_2 vextunop
- The instruction is valid with type ([V128] ->_ [] ++ [V128]).

validation_of_VEXTBINOP sh_1 sh_2 vextbinop
- The instruction is valid with type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VNARROW sh_1 sh_2 sx
- The instruction is valid with type ([V128, V128] ->_ [] ++ [V128]).

validation_of_VCVTOP sh_1 sh_2 vcvtop half? sx? zero?
- The instruction is valid with type ([V128] ->_ [] ++ [V128]).

validation_of_LOCAL.GET x
- |C.LOCALS| must be greater than x.
- Let (SET, t) be C.LOCALS[x].
- The instruction is valid with type ([] ->_ [] ++ [t]).

validation_of_LOCAL.SET x
- |C.LOCALS| must be greater than x.
- Let (init, t) be C.LOCALS[x].
- The instruction is valid with type ([t] ->_ [x] ++ []).

validation_of_LOCAL.TEE x
- |C.LOCALS| must be greater than x.
- Let (init, t) be C.LOCALS[x].
- The instruction is valid with type ([t] ->_ [x] ++ [t]).

validation_of_GLOBAL.GET x
- |C.GLOBALS| must be greater than x.
- Let (mut, t) be C.GLOBALS[x].
- The instruction is valid with type ([] ->_ [] ++ [t]).

validation_of_GLOBAL.SET x
- |C.GLOBALS| must be greater than x.
- Let ((MUT ?(())), t) be C.GLOBALS[x].
- The instruction is valid with type ([t] ->_ [] ++ []).

validation_of_TABLE.GET x
- |C.TABLES| must be greater than x.
- Let (lim, rt) be C.TABLES[x].
- The instruction is valid with type ([I32] ->_ [] ++ [rt]).

validation_of_TABLE.SET x
- |C.TABLES| must be greater than x.
- Let (lim, rt) be C.TABLES[x].
- The instruction is valid with type ([I32, rt] ->_ [] ++ []).

validation_of_TABLE.SIZE x
- |C.TABLES| must be greater than x.
- Let (lim, rt) be C.TABLES[x].
- The instruction is valid with type ([] ->_ [] ++ [I32]).

validation_of_TABLE.GROW x
- |C.TABLES| must be greater than x.
- Let (lim, rt) be C.TABLES[x].
- The instruction is valid with type ([rt, I32] ->_ [] ++ [I32]).

validation_of_TABLE.FILL x
- |C.TABLES| must be greater than x.
- Let (lim, rt) be C.TABLES[x].
- The instruction is valid with type ([I32, rt, I32] ->_ [] ++ []).

validation_of_TABLE.COPY x_1 x_2
- |C.TABLES| must be greater than x_1.
- |C.TABLES| must be greater than x_2.
- Let (lim_1, rt_1) be C.TABLES[x_1].
- Let (lim_2, rt_2) be C.TABLES[x_2].
- Yet: TODO: prem_to_instrs rule_sub
- The instruction is valid with type ([I32, I32, I32] ->_ [] ++ []).

validation_of_TABLE.INIT x y
- |C.TABLES| must be greater than x.
- |C.ELEMS| must be greater than y.
- Let rt_2 be C.ELEMS[y].
- Let (lim, rt_1) be C.TABLES[x].
- Yet: TODO: prem_to_instrs rule_sub
- The instruction is valid with type ([I32, I32, I32] ->_ [] ++ []).

validation_of_ELEM.DROP x
- |C.ELEMS| must be greater than x.
- Let rt be C.ELEMS[x].
- The instruction is valid with type ([] ->_ [] ++ []).

validation_of_MEMORY.SIZE x
- |C.MEMS| must be greater than x.
- Let mt be C.MEMS[x].
- The instruction is valid with type ([] ->_ [] ++ [I32]).

validation_of_MEMORY.GROW x
- |C.MEMS| must be greater than x.
- Let mt be C.MEMS[x].
- The instruction is valid with type ([I32] ->_ [] ++ [I32]).

validation_of_MEMORY.FILL x
- |C.MEMS| must be greater than x.
- Let mt be C.MEMS[x].
- The instruction is valid with type ([I32, I32, I32] ->_ [] ++ []).

validation_of_MEMORY.COPY x_1 x_2
- |C.MEMS| must be greater than x_1.
- |C.MEMS| must be greater than x_2.
- Let mt_1 be C.MEMS[x_1].
- Let mt_2 be C.MEMS[x_2].
- The instruction is valid with type ([I32, I32, I32] ->_ [] ++ []).

validation_of_MEMORY.INIT x y
- |C.MEMS| must be greater than x.
- |C.DATAS| must be greater than y.
- C.DATAS[y] must be equal to OK.
- Let mt be C.MEMS[x].
- The instruction is valid with type ([I32, I32, I32] ->_ [] ++ []).

validation_of_DATA.DROP x
- |C.DATAS| must be greater than x.
- C.DATAS[x] must be equal to OK.
- The instruction is valid with type ([] ->_ [] ++ []).

validation_of_LOAD nt ?() x memarg
- |C.MEMS| must be greater than x.
- (2 ^ memarg.ALIGN) must be less than or equal to ($size(nt) / 8).
- Let mt be C.MEMS[x].
- The instruction is valid with type ([I32] ->_ [] ++ [nt]).

validation_of_STORE nt ?() x memarg
- |C.MEMS| must be greater than x.
- (2 ^ memarg.ALIGN) must be less than or equal to ($size(nt) / 8).
- Let mt be C.MEMS[x].
- The instruction is valid with type ([I32, nt] ->_ [] ++ []).

validation_of_VLOAD V128 ?() x memarg
- |C.MEMS| must be greater than x.
- (2 ^ memarg.ALIGN) must be less than or equal to ($vsize(V128) / 8).
- Let mt be C.MEMS[x].
- The instruction is valid with type ([I32] ->_ [] ++ [V128]).

validation_of_VLOAD_LANE V128 N x memarg i
- |C.MEMS| must be greater than x.
- (2 ^ memarg.ALIGN) must be less than or equal to (N / 8).
- i must be less than (128 / N).
- Let mt be C.MEMS[x].
- The instruction is valid with type ([I32, V128] ->_ [] ++ [V128]).

validation_of_VSTORE V128 x memarg
- |C.MEMS| must be greater than x.
- (2 ^ memarg.ALIGN) must be less than or equal to ($vsize(V128) / 8).
- Let mt be C.MEMS[x].
- The instruction is valid with type ([I32, V128] ->_ [] ++ []).

validation_of_VSTORE_LANE V128 N x memarg i
- |C.MEMS| must be greater than x.
- (2 ^ memarg.ALIGN) must be less than or equal to (N / 8).
- i must be less than (128 / N).
- Let mt be C.MEMS[x].
- The instruction is valid with type ([I32, V128] ->_ [] ++ []).

Ki
1. Return 1024.

min n_u0 n_u1
1. If (n_u0 is 0), then:
  a. Return 0.
2. If (n_u1 is 0), then:
  a. Return 0.
3. Assert: Due to validation, (n_u0 ≥ 1).
4. Let i be (n_u0 - 1).
5. Assert: Due to validation, (n_u1 ≥ 1).
6. Let j be (n_u1 - 1).
7. Return $min(i, j).

sum n_u0*
1. If (n_u0* is []), then:
  a. Return 0.
2. Let [n] ++ n'* be n_u0*.
3. Return (n + $sum(n'*)).

concat_ X_u0*
1. If (X_u0* is []), then:
  a. Return [].
2. Let [w*] ++ w'** be X_u0*.
3. Return w* ++ $concat_(w'**).

disjoint_ X_u0*
1. If (X_u0* is []), then:
  a. Return true.
2. Let [w] ++ w'* be X_u0*.
3. Return (not w <- w'* and $disjoint_(w'*)).

signif N_u0
1. If (N_u0 is 32), then:
  a. Return 23.
2. Assert: Due to validation, (N_u0 is 64).
3. Return 52.

expon N_u0
1. If (N_u0 is 32), then:
  a. Return 8.
2. Assert: Due to validation, (N_u0 is 64).
3. Return 11.

M N
1. Return $signif(N).

E N
1. Return $expon(N).

fzero N
1. Return (POS (SUBNORM 0)).

fone N
1. Return (POS (NORM 1 0)).

canon_ N
1. Return (2 ^ ($signif(N) - 1)).

cont b
1. Assert: Due to validation, (128 < b).
2. Assert: Due to validation, (b < 192).
3. Return (b - 128).

utf8 char_u0*
1. Let ch* be char_u0*.
2. Return $concat_($utf8([ch])*).
3. Assert: Due to validation, (|char_u0*| is 1).
4. Let [ch] be char_u0*.
5. If (ch < 128), then:
  a. Let b be ch.
  b. Return [b].
6. If ((128 ≤ ch) and ((ch < 2048) and (ch ≥ $cont(b_2)))), then:
  a. Let ((2 ^ 6) · (b_1 - 192)) be (ch - $cont(b_2)).
  b. Return [b_1, b_2].
7. If ((((2048 ≤ ch) and (ch < 55296)) or ((57344 ≤ ch) and (ch < 65536))) and (ch ≥ $cont(b_3))), then:
  a. Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · $cont(b_2))) be (ch - $cont(b_3)).
  b. Return [b_1, b_2, b_3].
8. Assert: Due to validation, (65536 ≤ ch).
9. Assert: Due to validation, (ch < 69632).
10. Assert: Due to validation, (ch ≥ $cont(b_4)).
11. Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · $cont(b_2))) + ((2 ^ 6) · $cont(b_3))) be (ch - $cont(b_4)).
12. Return [b_1, b_2, b_3, b_4].

ANYREF
1. Return (REF (NULL ?(())) ANY).

EQREF
1. Return (REF (NULL ?(())) EQ).

I31REF
1. Return (REF (NULL ?(())) I31).

STRUCTREF
1. Return (REF (NULL ?(())) STRUCT).

ARRAYREF
1. Return (REF (NULL ?(())) ARRAY).

FUNCREF
1. Return (REF (NULL ?(())) FUNC).

EXTERNREF
1. Return (REF (NULL ?(())) EXTERN).

NULLREF
1. Return (REF (NULL ?(())) NONE).

NULLFUNCREF
1. Return (REF (NULL ?(())) NOFUNC).

NULLEXTERNREF
1. Return (REF (NULL ?(())) NOEXTERN).

size numty_u0
1. If (numty_u0 is I32), then:
  a. Return 32.
2. If (numty_u0 is I64), then:
  a. Return 64.
3. If (numty_u0 is F32), then:
  a. Return 32.
4. Assert: Due to validation, (numty_u0 is F64).
5. Return 64.

isize Inn
1. Return $size(Inn).

vsize V128
1. Return 128.

psize packt_u0
1. If (packt_u0 is I8), then:
  a. Return 8.
2. Assert: Due to validation, (packt_u0 is I16).
3. Return 16.

lsize lanet_u0
1. If the type of lanet_u0 is numtype, then:
  a. Let numtype be lanet_u0.
  b. Return $size(numtype).
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $psize(packtype).

zsize stora_u0
1. If the type of stora_u0 is numtype, then:
  a. Let numtype be stora_u0.
  b. Return $size(numtype).
2. If the type of stora_u0 is vectype, then:
  a. Let vectype be stora_u0.
  b. Return $vsize(vectype).
3. Assert: Due to validation, the type of stora_u0 is packtype.
4. Let packtype be stora_u0.
5. Return $psize(packtype).

lanetype (Lnn X N)
1. Return Lnn.

sizenn nt
1. Return $size(nt).

sizenn1 nt
1. Return $size(nt).

sizenn2 nt
1. Return $size(nt).

psizenn pt
1. Return $psize(pt).

lsizenn lt
1. Return $lsize(lt).

lsizenn1 lt
1. Return $lsize(lt).

lsizenn2 lt
1. Return $lsize(lt).

zero numty_u0
1. If the type of numty_u0 is Inn, then:
  a. Return 0.
2. Assert: Due to validation, the type of numty_u0 is Fnn.
3. Let Fnn be numty_u0.
4. Return $fzero($size(Fnn)).

dim (Lnn X N)
1. Return N.

shsize (Lnn X N)
1. Return ($lsize(Lnn) · N).

setminus1 x idx_u0*
1. If (idx_u0* is []), then:
  a. Return [x].
2. Let [y_1] ++ y* be idx_u0*.
3. If (x is y_1), then:
  a. Return [].
4. Let [y_1] ++ y* be idx_u0*.
5. Return $setminus1(x, y*).

setminus idx_u0* y*
1. If (idx_u0* is []), then:
  a. Return [].
2. Let [x_1] ++ x* be idx_u0*.
3. Return $setminus1(x_1, y*) ++ $setminus(x*, y*).

IN N_u0
1. If (N_u0 is 32), then:
  a. Return I32.
2. Assert: Due to validation, (N_u0 is 64).
3. Return I64.

FN N_u0
1. If (N_u0 is 32), then:
  a. Return F32.
2. Assert: Due to validation, (N_u0 is 64).
3. Return F64.

JN N_u0
1. If (N_u0 is 8), then:
  a. Return I8.
2. If (N_u0 is 16), then:
  a. Return I16.
3. If (N_u0 is 32), then:
  a. Return I32.
4. Assert: Due to validation, (N_u0 is 64).
5. Return I64.

lunpack lanet_u0
1. If the type of lanet_u0 is numtype, then:
  a. Let numtype be lanet_u0.
  b. Return numtype.
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Return I32.

unpack stora_u0
1. If the type of stora_u0 is valtype, then:
  a. Let valtype be stora_u0.
  b. Return valtype.
2. Assert: Due to validation, the type of stora_u0 is packtype.
3. Return I32.

nunpack stora_u0
1. If the type of stora_u0 is numtype, then:
  a. Let numtype be stora_u0.
  b. Return numtype.
2. If the type of stora_u0 is packtype, then:
  a. Return I32.

vunpack vectype
1. Return vectype.

cunpack stora_u0
1. If the type of stora_u0 is consttype, then:
  a. Let consttype be stora_u0.
  b. Return consttype.
2. If the type of stora_u0 is packtype, then:
  a. Return I32.
3. If the type of stora_u0 is lanetype, then:
  a. Let lanetype be stora_u0.
  b. Return $lunpack(lanetype).

sx stora_u0
1. If the type of stora_u0 is consttype, then:
  a. Return ?().
2. Assert: Due to validation, the type of stora_u0 is packtype.
3. Return ?(S).

const const_u0 c
1. If the type of const_u0 is numtype, then:
  a. Let numtype be const_u0.
  b. Return (numtype.CONST c).
2. Assert: Due to validation, the type of const_u0 is vectype.
3. Let vectype be const_u0.
4. Return (vectype.CONST c).

unpackshape (Lnn X N)
1. Return $lunpack(Lnn).

diffrt (REF nul1 ht_1) (REF (NULL _u0?) ht_2)
1. If (_u0? is ?(())), then:
  a. Return (REF (NULL ?()) ht_1).
2. Assert: Due to validation, _u0? is not defined.
3. Return (REF nul1 ht_1).

idx x
1. Return (_IDX x).

free_opt free_u0?
1. If free_u0? is not defined, then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
2. Let ?(free) be free_u0?.
3. Return free.

free_list free_u0*
1. If (free_u0* is []), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
2. Return YetE (free ++ $free_list(free'*{free' : free})).

free_typeidx typeidx
1. Return { TYPES: [typeidx]; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_funcidx funcidx
1. Return { TYPES: []; FUNCS: [funcidx]; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_globalidx globalidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: [globalidx]; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_tableidx tableidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: [tableidx]; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_memidx memidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: [memidx]; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_elemidx elemidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: [elemidx]; DATAS: []; LOCALS: []; LABELS: []; }.

free_dataidx dataidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: [dataidx]; LOCALS: []; LABELS: []; }.

free_localidx localidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: [localidx]; LABELS: []; }.

free_labelidx labelidx
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: [labelidx]; }.

free_externidx exter_u0
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC funcidx) be exter_u0.
  b. Return $free_funcidx(funcidx).
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL globalidx) be exter_u0.
  b. Return $free_globalidx(globalidx).
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE tableidx) be exter_u0.
  b. Return $free_tableidx(tableidx).
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM memidx) be exter_u0.
6. Return $free_memidx(memidx).

free_numtype numtype
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_packtype packtype
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_lanetype lanet_u0
1. If the type of lanet_u0 is numtype, then:
  a. Let numtype be lanet_u0.
  b. Return $free_numtype(numtype).
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $free_packtype(packtype).

free_vectype vectype
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_consttype const_u0
1. If the type of const_u0 is numtype, then:
  a. Let numtype be const_u0.
  b. Return $free_numtype(numtype).
2. Assert: Due to validation, the type of const_u0 is vectype.
3. Let vectype be const_u0.
4. Return $free_vectype(vectype).

free_absheaptype absheaptype
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_rectype (REC subtype*)
1. Return $free_list($free_subtype(subtype)*).

free_deftype (DEF rectype n)
1. Return $free_rectype(rectype).

free_typeuse typeu_u0
1. If typeu_u0 is of the case _IDX, then:
  a. Let (_IDX typeidx) be typeu_u0.
  b. Return $free_typeidx(typeidx).
2. If typeu_u0 is of the case REC, then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
3. Assert: Due to validation, the type of typeu_u0 is deftype.
4. Let deftype be typeu_u0.
5. Return $free_deftype(deftype).

free_heaptype heapt_u0
1. If the type of heapt_u0 is absheaptype, then:
  a. Let absheaptype be heapt_u0.
  b. Return $free_absheaptype(absheaptype).
2. Assert: Due to validation, the type of heapt_u0 is typeuse.
3. Let typeuse be heapt_u0.
4. Return $free_typeuse(typeuse).

free_reftype (REF nul heaptype)
1. Return $free_heaptype(heaptype).

free_valtype valty_u0
1. If the type of valty_u0 is numtype, then:
  a. Let numtype be valty_u0.
  b. Return $free_numtype(numtype).
2. If the type of valty_u0 is vectype, then:
  a. Let vectype be valty_u0.
  b. Return $free_vectype(vectype).
3. If the type of valty_u0 is reftype, then:
  a. Let reftype be valty_u0.
  b. Return $free_reftype(reftype).
4. Assert: Due to validation, (valty_u0 is BOT).
5. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_resulttype valtype*
1. Return $free_list($free_valtype(valtype)*).

free_storagetype stora_u0
1. If the type of stora_u0 is valtype, then:
  a. Let valtype be stora_u0.
  b. Return $free_valtype(valtype).
2. Assert: Due to validation, the type of stora_u0 is packtype.
3. Let packtype be stora_u0.
4. Return $free_packtype(packtype).

free_fieldtype (mut, storagetype)
1. Return $free_storagetype(storagetype).

free_functype (resulttype_1 -> resulttype_2)
1. Return YetE ($free_resulttype(resulttype_1) ++ $free_resulttype(resulttype_2)).

free_structtype fieldtype*
1. Return $free_list($free_fieldtype(fieldtype)*).

free_arraytype fieldtype
1. Return $free_fieldtype(fieldtype).

free_comptype compt_u0
1. If compt_u0 is of the case STRUCT, then:
  a. Let (STRUCT structtype) be compt_u0.
  b. Return $free_structtype(structtype).
2. If compt_u0 is of the case ARRAY, then:
  a. Let (ARRAY arraytype) be compt_u0.
  b. Return $free_arraytype(arraytype).
3. Assert: Due to validation, compt_u0 is of the case FUNC.
4. Let (FUNC functype) be compt_u0.
5. Return $free_functype(functype).

free_subtype (SUB fin typeuse* comptype)
1. Return YetE ($free_list($free_typeuse(typeuse)*{typeuse : typeuse}) ++ $free_comptype(comptype)).

free_globaltype (mut, valtype)
1. Return $free_valtype(valtype).

free_tabletype (limits, reftype)
1. Return $free_reftype(reftype).

free_memtype (PAGE limits)
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_elemtype reftype
1. Return $free_reftype(reftype).

free_datatype OK
1. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_externtype exter_u0
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC typeuse) be exter_u0.
  b. Return $free_typeuse(typeuse).
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL globaltype) be exter_u0.
  b. Return $free_globaltype(globaltype).
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE tabletype) be exter_u0.
  b. Return $free_tabletype(tabletype).
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM memtype) be exter_u0.
6. Return $free_memtype(memtype).

free_moduletype (externtype_1* -> externtype_2*)
1. Return YetE ($free_list($free_externtype(externtype_1)*{externtype_1 : externtype}) ++ $free_list($free_externtype(externtype_2)*{externtype_2 : externtype})).

free_blocktype block_u0
1. If block_u0 is of the case _RESULT, then:
  a. Let (_RESULT valtype?) be block_u0.
  b. Return $free_opt($free_valtype(valtype)?).
2. Assert: Due to validation, block_u0 is of the case _IDX.
3. Let (_IDX funcidx) be block_u0.
4. Return $free_funcidx(funcidx).

free_shape (lanetype X dim)
1. Return $free_lanetype(lanetype).

shift_labelidxs label_u0*
1. If (label_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ labelidx'* be label_u0*.
3. If (y_0 is 0), then:
  a. Return $shift_labelidxs(labelidx'*).
4. Let [labelidx] ++ labelidx'* be label_u0*.
5. Return [(labelidx - 1)] ++ $shift_labelidxs(labelidx'*).

free_block instr*
1. Let free be $free_list($free_instr(instr)*).
2. Return free with .LABELS replaced by $shift_labelidxs(free.LABELS).

free_instr instr_u0
1. If (instr_u0 is NOP), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
2. If (instr_u0 is UNREACHABLE), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
3. If (instr_u0 is DROP), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
4. If instr_u0 is of the case SELECT, then:
  a. Let (SELECT valtype*?) be instr_u0.
  b. Return $free_opt($free_list($free_valtype(valtype)*)?).
5. If instr_u0 is of the case BLOCK, then:
  a. Return YetE ($free_blocktype(blocktype) ++ $free_block(instr*{instr : instr})).
6. If instr_u0 is of the case LOOP, then:
  a. Return YetE ($free_blocktype(blocktype) ++ $free_block(instr*{instr : instr})).
7. If instr_u0 is of the case IF, then:
  a. Return YetE ($free_blocktype(blocktype) ++ $free_block(instr_1*{instr_1 : instr}) ++ $free_block(instr_2*{instr_2 : instr})).
8. If instr_u0 is of the case BR, then:
  a. Let (BR labelidx) be instr_u0.
  b. Return $free_labelidx(labelidx).
9. If instr_u0 is of the case BR_IF, then:
  a. Let (BR_IF labelidx) be instr_u0.
  b. Return $free_labelidx(labelidx).
10. If instr_u0 is of the case BR_TABLE, then:
  a. Return YetE ($free_list($free_labelidx(labelidx)*{}) ++ $free_labelidx(labelidx)).
11. If instr_u0 is of the case BR_ON_NULL, then:
  a. Let (BR_ON_NULL labelidx) be instr_u0.
  b. Return $free_labelidx(labelidx).
12. If instr_u0 is of the case BR_ON_NON_NULL, then:
  a. Let (BR_ON_NON_NULL labelidx) be instr_u0.
  b. Return $free_labelidx(labelidx).
13. If instr_u0 is of the case BR_ON_CAST, then:
  a. Return YetE ($free_labelidx(labelidx) ++ $free_reftype(reftype_1) ++ $free_reftype(reftype_2)).
14. If instr_u0 is of the case BR_ON_CAST_FAIL, then:
  a. Return YetE ($free_labelidx(labelidx) ++ $free_reftype(reftype_1) ++ $free_reftype(reftype_2)).
15. If instr_u0 is of the case CALL, then:
  a. Let (CALL funcidx) be instr_u0.
  b. Return $free_funcidx(funcidx).
16. If instr_u0 is of the case CALL_REF, then:
  a. Let (CALL_REF typeuse) be instr_u0.
  b. Return $free_typeuse(typeuse).
17. If instr_u0 is of the case CALL_INDIRECT, then:
  a. Return YetE ($free_tableidx(tableidx) ++ $free_typeuse(typeuse)).
18. If (instr_u0 is RETURN), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
19. If instr_u0 is of the case RETURN_CALL, then:
  a. Let (RETURN_CALL funcidx) be instr_u0.
  b. Return $free_funcidx(funcidx).
20. If instr_u0 is of the case RETURN_CALL_REF, then:
  a. Let (RETURN_CALL_REF typeuse) be instr_u0.
  b. Return $free_typeuse(typeuse).
21. If instr_u0 is of the case RETURN_CALL_INDIRECT, then:
  a. Return YetE ($free_tableidx(tableidx) ++ $free_typeuse(typeuse)).
22. If instr_u0 is of the case CONST, then:
  a. Let (numtype.CONST numlit) be instr_u0.
  b. Return $free_numtype(numtype).
23. If instr_u0 is of the case UNOP, then:
  a. Let (UNOP numtype unop) be instr_u0.
  b. Return $free_numtype(numtype).
24. If instr_u0 is of the case BINOP, then:
  a. Let (BINOP numtype binop) be instr_u0.
  b. Return $free_numtype(numtype).
25. If instr_u0 is of the case TESTOP, then:
  a. Let (TESTOP numtype testop) be instr_u0.
  b. Return $free_numtype(numtype).
26. If instr_u0 is of the case RELOP, then:
  a. Let (RELOP numtype relop) be instr_u0.
  b. Return $free_numtype(numtype).
27. If instr_u0 is of the case CVTOP, then:
  a. Return YetE ($free_numtype(numtype_1) ++ $free_numtype(numtype_2)).
28. If instr_u0 is of the case VCONST, then:
  a. Let (vectype.CONST veclit) be instr_u0.
  b. Return $free_vectype(vectype).
29. If instr_u0 is of the case VVUNOP, then:
  a. Let (VVUNOP vectype vvunop) be instr_u0.
  b. Return $free_vectype(vectype).
30. If instr_u0 is of the case VVBINOP, then:
  a. Let (VVBINOP vectype vvbinop) be instr_u0.
  b. Return $free_vectype(vectype).
31. If instr_u0 is of the case VVTERNOP, then:
  a. Let (VVTERNOP vectype vvternop) be instr_u0.
  b. Return $free_vectype(vectype).
32. If instr_u0 is of the case VVTESTOP, then:
  a. Let (VVTESTOP vectype vvtestop) be instr_u0.
  b. Return $free_vectype(vectype).
33. If instr_u0 is of the case VUNOP, then:
  a. Let (VUNOP shape vunop) be instr_u0.
  b. Return $free_shape(shape).
34. If instr_u0 is of the case VBINOP, then:
  a. Let (VBINOP shape vbinop) be instr_u0.
  b. Return $free_shape(shape).
35. If instr_u0 is of the case VTESTOP, then:
  a. Let (VTESTOP shape vtestop) be instr_u0.
  b. Return $free_shape(shape).
36. If instr_u0 is of the case VRELOP, then:
  a. Let (VRELOP shape vrelop) be instr_u0.
  b. Return $free_shape(shape).
37. If instr_u0 is of the case VSHIFTOP, then:
  a. Let (VSHIFTOP ishape vshiftop) be instr_u0.
  b. Return $free_shape(ishape).
38. If instr_u0 is of the case VBITMASK, then:
  a. Let (VBITMASK ishape) be instr_u0.
  b. Return $free_shape(ishape).
39. If instr_u0 is of the case VSWIZZLE, then:
  a. Let (VSWIZZLE ishape) be instr_u0.
  b. Return $free_shape(ishape).
40. If instr_u0 is of the case VSHUFFLE, then:
  a. Let (VSHUFFLE ishape laneidx*) be instr_u0.
  b. Return $free_shape(ishape).
41. If instr_u0 is of the case VEXTUNOP, then:
  a. Return YetE ($free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape))).
42. If instr_u0 is of the case VEXTBINOP, then:
  a. Return YetE ($free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape))).
43. If instr_u0 is of the case VNARROW, then:
  a. Return YetE ($free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape))).
44. If instr_u0 is of the case VCVTOP, then:
  a. Return YetE ($free_shape(shape_1) ++ $free_shape(shape_2)).
45. If instr_u0 is of the case VSPLAT, then:
  a. Let (VSPLAT shape) be instr_u0.
  b. Return $free_shape(shape).
46. If instr_u0 is of the case VEXTRACT_LANE, then:
  a. Let (VEXTRACT_LANE shape sx? laneidx) be instr_u0.
  b. Return $free_shape(shape).
47. If instr_u0 is of the case VREPLACE_LANE, then:
  a. Let (VREPLACE_LANE shape laneidx) be instr_u0.
  b. Return $free_shape(shape).
48. If instr_u0 is of the case REF.NULL, then:
  a. Let (REF.NULL heaptype) be instr_u0.
  b. Return $free_heaptype(heaptype).
49. If (instr_u0 is REF.IS_NULL), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
50. If (instr_u0 is REF.AS_NON_NULL), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
51. If (instr_u0 is REF.EQ), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
52. If instr_u0 is of the case REF.TEST, then:
  a. Let (REF.TEST reftype) be instr_u0.
  b. Return $free_reftype(reftype).
53. If instr_u0 is of the case REF.CAST, then:
  a. Let (REF.CAST reftype) be instr_u0.
  b. Return $free_reftype(reftype).
54. If instr_u0 is of the case REF.FUNC, then:
  a. Let (REF.FUNC funcidx) be instr_u0.
  b. Return $free_funcidx(funcidx).
55. If (instr_u0 is REF.I31), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
56. If instr_u0 is of the case I31.GET, then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
57. If instr_u0 is of the case STRUCT.NEW, then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
58. If instr_u0 is of the case STRUCT.NEW_DEFAULT, then:
  a. Let (STRUCT.NEW_DEFAULT typeidx) be instr_u0.
  b. Return $free_typeidx(typeidx).
59. If instr_u0 is of the case STRUCT.GET, then:
  a. Let (STRUCT.GET sx? typeidx u32) be instr_u0.
  b. Return $free_typeidx(typeidx).
60. If instr_u0 is of the case STRUCT.SET, then:
  a. Let (STRUCT.SET typeidx u32) be instr_u0.
  b. Return $free_typeidx(typeidx).
61. If instr_u0 is of the case ARRAY.NEW, then:
  a. Let (ARRAY.NEW typeidx) be instr_u0.
  b. Return $free_typeidx(typeidx).
62. If instr_u0 is of the case ARRAY.NEW_DEFAULT, then:
  a. Let (ARRAY.NEW_DEFAULT typeidx) be instr_u0.
  b. Return $free_typeidx(typeidx).
63. If instr_u0 is of the case ARRAY.NEW_FIXED, then:
  a. Let (ARRAY.NEW_FIXED typeidx u32) be instr_u0.
  b. Return $free_typeidx(typeidx).
64. If instr_u0 is of the case ARRAY.NEW_DATA, then:
  a. Return YetE ($free_typeidx(typeidx) ++ $free_dataidx(dataidx)).
65. If instr_u0 is of the case ARRAY.NEW_ELEM, then:
  a. Return YetE ($free_typeidx(typeidx) ++ $free_elemidx(elemidx)).
66. If instr_u0 is of the case ARRAY.GET, then:
  a. Let (ARRAY.GET sx? typeidx) be instr_u0.
  b. Return $free_typeidx(typeidx).
67. If instr_u0 is of the case ARRAY.SET, then:
  a. Let (ARRAY.SET typeidx) be instr_u0.
  b. Return $free_typeidx(typeidx).
68. If (instr_u0 is ARRAY.LEN), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
69. If instr_u0 is of the case ARRAY.FILL, then:
  a. Let (ARRAY.FILL typeidx) be instr_u0.
  b. Return $free_typeidx(typeidx).
70. If instr_u0 is of the case ARRAY.COPY, then:
  a. Return YetE ($free_typeidx(typeidx_1) ++ $free_typeidx(typeidx_2)).
71. If instr_u0 is of the case ARRAY.INIT_DATA, then:
  a. Return YetE ($free_typeidx(typeidx) ++ $free_dataidx(dataidx)).
72. If instr_u0 is of the case ARRAY.INIT_ELEM, then:
  a. Return YetE ($free_typeidx(typeidx) ++ $free_elemidx(elemidx)).
73. If (instr_u0 is EXTERN.CONVERT_ANY), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
74. If (instr_u0 is ANY.CONVERT_EXTERN), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
75. If instr_u0 is of the case LOCAL.GET, then:
  a. Let (LOCAL.GET localidx) be instr_u0.
  b. Return $free_localidx(localidx).
76. If instr_u0 is of the case LOCAL.SET, then:
  a. Let (LOCAL.SET localidx) be instr_u0.
  b. Return $free_localidx(localidx).
77. If instr_u0 is of the case LOCAL.TEE, then:
  a. Let (LOCAL.TEE localidx) be instr_u0.
  b. Return $free_localidx(localidx).
78. If instr_u0 is of the case GLOBAL.GET, then:
  a. Let (GLOBAL.GET globalidx) be instr_u0.
  b. Return $free_globalidx(globalidx).
79. If instr_u0 is of the case GLOBAL.SET, then:
  a. Let (GLOBAL.SET globalidx) be instr_u0.
  b. Return $free_globalidx(globalidx).
80. If instr_u0 is of the case TABLE.GET, then:
  a. Let (TABLE.GET tableidx) be instr_u0.
  b. Return $free_tableidx(tableidx).
81. If instr_u0 is of the case TABLE.SET, then:
  a. Let (TABLE.SET tableidx) be instr_u0.
  b. Return $free_tableidx(tableidx).
82. If instr_u0 is of the case TABLE.SIZE, then:
  a. Let (TABLE.SIZE tableidx) be instr_u0.
  b. Return $free_tableidx(tableidx).
83. If instr_u0 is of the case TABLE.GROW, then:
  a. Let (TABLE.GROW tableidx) be instr_u0.
  b. Return $free_tableidx(tableidx).
84. If instr_u0 is of the case TABLE.FILL, then:
  a. Let (TABLE.FILL tableidx) be instr_u0.
  b. Return $free_tableidx(tableidx).
85. If instr_u0 is of the case TABLE.COPY, then:
  a. Return YetE ($free_tableidx(tableidx_1) ++ $free_tableidx(tableidx_2)).
86. If instr_u0 is of the case TABLE.INIT, then:
  a. Return YetE ($free_tableidx(tableidx) ++ $free_elemidx(elemidx)).
87. If instr_u0 is of the case ELEM.DROP, then:
  a. Let (ELEM.DROP elemidx) be instr_u0.
  b. Return $free_elemidx(elemidx).
88. If instr_u0 is of the case LOAD, then:
  a. Let (LOAD numtype y_0 memidx memarg) be instr_u0.
  b. If y_0 is defined, then:
    1) Return YetE ($free_numtype(numtype) ++ $free_memidx(memidx)).
89. If instr_u0 is of the case STORE, then:
  a. Return YetE ($free_numtype(numtype) ++ $free_memidx(memidx)).
90. If instr_u0 is of the case VLOAD, then:
  a. Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx)).
91. If instr_u0 is of the case VLOAD_LANE, then:
  a. Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx)).
92. If instr_u0 is of the case VSTORE, then:
  a. Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx)).
93. If instr_u0 is of the case VSTORE_LANE, then:
  a. Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx)).
94. If instr_u0 is of the case MEMORY.SIZE, then:
  a. Let (MEMORY.SIZE memidx) be instr_u0.
  b. Return $free_memidx(memidx).
95. If instr_u0 is of the case MEMORY.GROW, then:
  a. Let (MEMORY.GROW memidx) be instr_u0.
  b. Return $free_memidx(memidx).
96. If instr_u0 is of the case MEMORY.FILL, then:
  a. Let (MEMORY.FILL memidx) be instr_u0.
  b. Return $free_memidx(memidx).
97. If instr_u0 is of the case MEMORY.COPY, then:
  a. Return YetE ($free_memidx(memidx_1) ++ $free_memidx(memidx_2)).
98. If instr_u0 is of the case MEMORY.INIT, then:
  a. Return YetE ($free_memidx(memidx) ++ $free_dataidx(dataidx)).
99. Assert: Due to validation, instr_u0 is of the case DATA.DROP.
100. Let (DATA.DROP dataidx) be instr_u0.
101. Return $free_dataidx(dataidx).

free_expr instr*
1. Return $free_list($free_instr(instr)*).

free_type (TYPE rectype)
1. Return $free_rectype(rectype).

free_local (LOCAL t)
1. Return $free_valtype(t).

free_func (FUNC typeidx local* expr)
1. Return YetE ($free_typeidx(typeidx) ++ $free_list($free_local(local)*{local : local}) ++ $free_block(expr)[LOCALS_free = []]).

free_global (GLOBAL globaltype expr)
1. Return YetE ($free_globaltype(globaltype) ++ $free_expr(expr)).

free_table (TABLE tabletype expr)
1. Return YetE ($free_tabletype(tabletype) ++ $free_expr(expr)).

free_mem (MEMORY memtype)
1. Return $free_memtype(memtype).

free_elemmode elemm_u0
1. If elemm_u0 is of the case ACTIVE, then:
  a. Return YetE ($free_tableidx(tableidx) ++ $free_expr(expr)).
2. If (elemm_u0 is PASSIVE), then:
  a. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.
3. Assert: Due to validation, (elemm_u0 is DECLARE).
4. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_datamode datam_u0
1. If datam_u0 is of the case ACTIVE, then:
  a. Return YetE ($free_memidx(memidx) ++ $free_expr(expr)).
2. Assert: Due to validation, (datam_u0 is PASSIVE).
3. Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }.

free_elem (ELEM reftype expr* elemmode)
1. Return YetE ($free_reftype(reftype) ++ $free_list($free_expr(expr)*{expr : expr}) ++ $free_elemmode(elemmode)).

free_data (DATA byte* datamode)
1. Return $free_datamode(datamode).

free_start (START funcidx)
1. Return $free_funcidx(funcidx).

free_export (EXPORT name externidx)
1. Return $free_externidx(externidx).

free_import (IMPORT name_1 name_2 externtype)
1. Return $free_externtype(externtype).

free_module (MODULE type* import* func* global* table* mem* elem* data* start* export*)
1. Return YetE ($free_list($free_type(type)*{type : type}) ++ $free_list($free_import(import)*{import : import}) ++ $free_list($free_func(func)*{func : func}) ++ $free_list($free_global(global)*{global : global}) ++ $free_list($free_table(table)*{table : table}) ++ $free_list($free_mem(mem)*{mem : mem}) ++ $free_list($free_elem(elem)*{elem : elem}) ++ $free_list($free_data(data)*{data : data}) ++ $free_list($free_start(start)*{start : start}) ++ $free_list($free_export(export)*{export : export})).

funcidx_module module
1. Return $free_module(module).FUNCS.

dataidx_funcs func*
1. Return $free_list($free_func(func)*).DATAS.

subst_typevar tv typev_u0* typeu_u1*
1. If ((typev_u0* is []) and (typeu_u1* is [])), then:
  a. Return tv.
2. Assert: Due to validation, (|typeu_u1*| ≥ 1).
3. Let [tu_1] ++ tu'* be typeu_u1*.
4. If (|typev_u0*| ≥ 1), then:
  a. Let [tv_1] ++ tv'* be typev_u0*.
  b. If (tv is tv_1), then:
    1) Return tu_1.
5. Let [tu_1] ++ tu'* be typeu_u1*.
6. Assert: Due to validation, (|typev_u0*| ≥ 1).
7. Let [tv_1] ++ tv'* be typev_u0*.
8. Return $subst_typevar(tv, tv'*, tu'*).

subst_packtype pt tv* tu*
1. Return pt.

subst_numtype nt tv* tu*
1. Return nt.

subst_vectype vt tv* tu*
1. Return vt.

subst_typeuse typeu_u0 tv* tu*
1. If the type of typeu_u0 is typevar, then:
  a. Let tv' be typeu_u0.
  b. Return $subst_typevar(tv', tv*, tu*).
2. Assert: Due to validation, the type of typeu_u0 is deftype.
3. Let dt be typeu_u0.
4. Return $subst_deftype(dt, tv*, tu*).

subst_heaptype heapt_u0 tv* tu*
1. If the type of heapt_u0 is typevar, then:
  a. Let tv' be heapt_u0.
  b. Return $subst_typevar(tv', tv*, tu*).
2. If the type of heapt_u0 is deftype, then:
  a. Let dt be heapt_u0.
  b. Return $subst_deftype(dt, tv*, tu*).
3. Let ht be heapt_u0.
4. Return ht.

subst_reftype (REF nul ht) tv* tu*
1. Return (REF nul $subst_heaptype(ht, tv*, tu*)).

subst_valtype valty_u0 tv* tu*
1. If the type of valty_u0 is numtype, then:
  a. Let nt be valty_u0.
  b. Return $subst_numtype(nt, tv*, tu*).
2. If the type of valty_u0 is vectype, then:
  a. Let vt be valty_u0.
  b. Return $subst_vectype(vt, tv*, tu*).
3. If the type of valty_u0 is reftype, then:
  a. Let rt be valty_u0.
  b. Return $subst_reftype(rt, tv*, tu*).
4. Assert: Due to validation, (valty_u0 is BOT).
5. Return BOT.

subst_storagetype stora_u0 tv* tu*
1. If the type of stora_u0 is valtype, then:
  a. Let t be stora_u0.
  b. Return $subst_valtype(t, tv*, tu*).
2. Assert: Due to validation, the type of stora_u0 is packtype.
3. Let pt be stora_u0.
4. Return $subst_packtype(pt, tv*, tu*).

subst_fieldtype (mut, zt) tv* tu*
1. Return (mut, $subst_storagetype(zt, tv*, tu*)).

subst_comptype compt_u0 tv* tu*
1. If compt_u0 is of the case STRUCT, then:
  a. Let (STRUCT yt*) be compt_u0.
  b. Return (STRUCT $subst_fieldtype(yt, tv*, tu*)*).
2. If compt_u0 is of the case ARRAY, then:
  a. Let (ARRAY yt) be compt_u0.
  b. Return (ARRAY $subst_fieldtype(yt, tv*, tu*)).
3. Assert: Due to validation, compt_u0 is of the case FUNC.
4. Let (FUNC ft) be compt_u0.
5. Return (FUNC $subst_functype(ft, tv*, tu*)).

subst_subtype (SUB fin tu'* ct) tv* tu*
1. Return (SUB fin $subst_typeuse(tu', tv*, tu*)* $subst_comptype(ct, tv*, tu*)).

subst_rectype (REC st*) tv* tu*
1. Return (REC $subst_subtype(st, tv*, tu*)*).

subst_deftype (DEF qt i) tv* tu*
1. Return (DEF $subst_rectype(qt, tv*, tu*) i).

subst_functype (t_1* -> t_2*) tv* tu*
1. Return ($subst_valtype(t_1, tv*, tu*)* -> $subst_valtype(t_2, tv*, tu*)*).

subst_globaltype (mut, t) tv* tu*
1. Return (mut, $subst_valtype(t, tv*, tu*)).

subst_tabletype (lim, rt) tv* tu*
1. Return (lim, $subst_reftype(rt, tv*, tu*)).

subst_memtype (PAGE lim) tv* tu*
1. Return (PAGE lim).

subst_externtype exter_u0 tv* tu*
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC dt) be exter_u0.
  b. Return (FUNC $subst_deftype(dt, tv*, tu*)).
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be exter_u0.
  b. Return (GLOBAL $subst_globaltype(gt, tv*, tu*)).
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE tt) be exter_u0.
  b. Return (TABLE $subst_tabletype(tt, tv*, tu*)).
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM mt) be exter_u0.
6. Return (MEM $subst_memtype(mt, tv*, tu*)).

subst_moduletype (xt_1* -> xt_2*) tv* tu*
1. Return ($subst_externtype(xt_1, tv*, tu*)* -> $subst_externtype(xt_2, tv*, tu*)*).

subst_all_valtype t tu^n
1. Return $subst_valtype(t, $idx(i)^(i<n), tu^n).

subst_all_reftype rt tu^n
1. Return $subst_reftype(rt, $idx(i)^(i<n), tu^n).

subst_all_deftype dt tu^n
1. Return $subst_deftype(dt, $idx(i)^(i<n), tu^n).

subst_all_moduletype mmt tu^n
1. Return $subst_moduletype(mmt, $idx(i)^(i<n), tu^n).

subst_all_deftypes defty_u0* tu*
1. If (defty_u0* is []), then:
  a. Return [].
2. Let [dt_1] ++ dt* be defty_u0*.
3. Return [$subst_all_deftype(dt_1, tu*)] ++ $subst_all_deftypes(dt*, tu*).

rollrt x rectype
1. Assert: Due to validation, rectype is of the case REC.
2. Let (REC subtype^n) be rectype.
3. Return (REC $subst_subtype(subtype, $idx((x + i))^(i<n), (REC i)^(i<n))^n).

unrollrt rectype
1. Assert: Due to validation, rectype is of the case REC.
2. Let (REC subtype^n) be rectype.
3. Return (REC $subst_subtype(subtype, (REC i)^(i<n), (DEF rectype i)^(i<n))^n).

rolldt x rectype
1. Assert: Due to validation, $rollrt(x, rectype) is of the case REC.
2. Let (REC subtype^n) be $rollrt(x, rectype).
3. Return (DEF (REC subtype^n) i)^(i<n).

unrolldt (DEF rectype i)
1. Assert: Due to validation, $unrollrt(rectype) is of the case REC.
2. Let (REC subtype*) be $unrollrt(rectype).
3. Return subtype*[i].

expanddt deftype
1. Assert: Due to validation, $unrolldt(deftype) is of the case SUB.
2. Let (SUB fin typeuse* comptype) be $unrolldt(deftype).
3. Return comptype.

funcsxx exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xx* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC x) be y_0.
  b. Return [x] ++ $funcsxx(xx*).
4. Let [externidx] ++ xx* be exter_u0*.
5. Return $funcsxx(xx*).

globalsxx exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xx* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be y_0.
  b. Return [x] ++ $globalsxx(xx*).
4. Let [externidx] ++ xx* be exter_u0*.
5. Return $globalsxx(xx*).

tablesxx exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xx* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE x) be y_0.
  b. Return [x] ++ $tablesxx(xx*).
4. Let [externidx] ++ xx* be exter_u0*.
5. Return $tablesxx(xx*).

memsxx exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xx* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM x) be y_0.
  b. Return [x] ++ $memsxx(xx*).
4. Let [externidx] ++ xx* be exter_u0*.
5. Return $memsxx(xx*).

funcsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xt* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC dt) be y_0.
  b. Return [dt] ++ $funcsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $funcsxt(xt*).

globalsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xt* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL gt) be y_0.
  b. Return [gt] ++ $globalsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $globalsxt(xt*).

tablesxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xt* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE tt) be y_0.
  b. Return [tt] ++ $tablesxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $tablesxt(xt*).

memsxt exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xt* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM mt) be y_0.
  b. Return [mt] ++ $memsxt(xt*).
4. Let [externtype] ++ xt* be exter_u0*.
5. Return $memsxt(xt*).

memarg0
1. Return { ALIGN: 0; OFFSET: 0; }.

signed N i
1. If (0 ≤ (2 ^ (N - 1))), then:
  a. Return i.
2. Assert: Due to validation, ((2 ^ (N - 1)) ≤ i).
3. Assert: Due to validation, (i < (2 ^ N)).
4. Return (i - (2 ^ N)).

invsigned N i
1. Let j be $signed_1^-1(N, i).
2. Return j.

unop numty_u1 unop__u0 num__u3
1. If ((unop__u0 is CLZ) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN be num__u3.
  c. Return [$iclz($size(Inn), iN)].
2. If ((unop__u0 is CTZ) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN be num__u3.
  c. Return [$ictz($size(Inn), iN)].
3. If ((unop__u0 is POPCNT) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN be num__u3.
  c. Return [$ipopcnt($size(Inn), iN)].
4. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Assert: Due to validation, unop__u0 is of the case EXTEND.
  c. Let (EXTEND N) be unop__u0.
  d. Let iN be num__u3.
  e. Return [$ext(N, $size(Inn), S, $wrap($size(Inn), N, iN))].
5. If ((unop__u0 is ABS) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return [$fabs($size(Fnn), fN)].
6. If ((unop__u0 is NEG) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return [$fneg($size(Fnn), fN)].
7. If ((unop__u0 is SQRT) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return [$fsqrt($size(Fnn), fN)].
8. If ((unop__u0 is CEIL) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return [$fceil($size(Fnn), fN)].
9. If ((unop__u0 is FLOOR) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return [$ffloor($size(Fnn), fN)].
10. If ((unop__u0 is TRUNC) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN be num__u3.
  c. Return [$ftrunc($size(Fnn), fN)].
11. Assert: Due to validation, (unop__u0 is NEAREST).
12. Assert: Due to validation, the type of numty_u1 is Fnn.
13. Let Fnn be numty_u1.
14. Let fN be num__u3.
15. Return [$fnearest($size(Fnn), fN)].

binop numty_u1 binop_u0 num__u3 num__u5
1. If ((binop_u0 is ADD) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$iadd($size(Inn), iN_1, iN_2)].
2. If ((binop_u0 is SUB) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$isub($size(Inn), iN_1, iN_2)].
3. If ((binop_u0 is MUL) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$imul($size(Inn), iN_1, iN_2)].
4. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. If binop_u0 is of the case DIV, then:
    1) Let (DIV sx) be binop_u0.
    2) Return [$idiv($size(Inn), sx, iN_1, iN_2)].
  e. If binop_u0 is of the case REM, then:
    1) Let (REM sx) be binop_u0.
    2) Return [$irem($size(Inn), sx, iN_1, iN_2)].
5. If ((binop_u0 is AND) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$iand($size(Inn), iN_1, iN_2)].
6. If ((binop_u0 is OR) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$ior($size(Inn), iN_1, iN_2)].
7. If ((binop_u0 is XOR) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$ixor($size(Inn), iN_1, iN_2)].
8. If ((binop_u0 is SHL) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$ishl($size(Inn), iN_1, iN_2)].
9. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. If binop_u0 is of the case SHR, then:
    1) Let (SHR sx) be binop_u0.
    2) Return [$ishr($size(Inn), sx, iN_1, iN_2)].
10. If ((binop_u0 is ROTL) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$irotl($size(Inn), iN_1, iN_2)].
11. If ((binop_u0 is ROTR) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return [$irotr($size(Inn), iN_1, iN_2)].
12. If ((binop_u0 is ADD) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return [$fadd($size(Fnn), fN_1, fN_2)].
13. If ((binop_u0 is SUB) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return [$fsub($size(Fnn), fN_1, fN_2)].
14. If ((binop_u0 is MUL) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return [$fmul($size(Fnn), fN_1, fN_2)].
15. If ((binop_u0 is DIV) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return [$fdiv($size(Fnn), fN_1, fN_2)].
16. If ((binop_u0 is MIN) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return [$fmin($size(Fnn), fN_1, fN_2)].
17. If ((binop_u0 is MAX) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return [$fmax($size(Fnn), fN_1, fN_2)].
18. Assert: Due to validation, (binop_u0 is COPYSIGN).
19. Assert: Due to validation, the type of numty_u1 is Fnn.
20. Let Fnn be numty_u1.
21. Let fN_1 be num__u3.
22. Let fN_2 be num__u5.
23. Return [$fcopysign($size(Fnn), fN_1, fN_2)].

testop Inn EQZ iN
1. Return $ieqz($size(Inn), iN).

relop numty_u1 relop_u0 num__u3 num__u5
1. If ((relop_u0 is EQ) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return $ieq($size(Inn), iN_1, iN_2).
2. If ((relop_u0 is NE) and the type of numty_u1 is Inn), then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. Return $ine($size(Inn), iN_1, iN_2).
3. If the type of numty_u1 is Inn, then:
  a. Let Inn be numty_u1.
  b. Let iN_1 be num__u3.
  c. Let iN_2 be num__u5.
  d. If relop_u0 is of the case LT, then:
    1) Let (LT sx) be relop_u0.
    2) Return $ilt($size(Inn), sx, iN_1, iN_2).
  e. If relop_u0 is of the case GT, then:
    1) Let (GT sx) be relop_u0.
    2) Return $igt($size(Inn), sx, iN_1, iN_2).
  f. If relop_u0 is of the case LE, then:
    1) Let (LE sx) be relop_u0.
    2) Return $ile($size(Inn), sx, iN_1, iN_2).
  g. If relop_u0 is of the case GE, then:
    1) Let (GE sx) be relop_u0.
    2) Return $ige($size(Inn), sx, iN_1, iN_2).
4. If ((relop_u0 is EQ) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $feq($size(Fnn), fN_1, fN_2).
5. If ((relop_u0 is NE) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fne($size(Fnn), fN_1, fN_2).
6. If ((relop_u0 is LT) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $flt($size(Fnn), fN_1, fN_2).
7. If ((relop_u0 is GT) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fgt($size(Fnn), fN_1, fN_2).
8. If ((relop_u0 is LE) and the type of numty_u1 is Fnn), then:
  a. Let Fnn be numty_u1.
  b. Let fN_1 be num__u3.
  c. Let fN_2 be num__u5.
  d. Return $fle($size(Fnn), fN_1, fN_2).
9. Assert: Due to validation, (relop_u0 is GE).
10. Assert: Due to validation, the type of numty_u1 is Fnn.
11. Let Fnn be numty_u1.
12. Let fN_1 be num__u3.
13. Let fN_2 be num__u5.
14. Return $fge($size(Fnn), fN_1, fN_2).

cvtop numty_u1 numty_u4 cvtop_u0 num__u3
1. If the type of numty_u1 is Inn, then:
  a. Let Inn_1 be numty_u1.
  b. If the type of numty_u4 is Inn, then:
    1) Let Inn_2 be numty_u4.
    2) Let iN_1 be num__u3.
    3) If cvtop_u0 is of the case EXTEND, then:
      a) Let (EXTEND sx) be cvtop_u0.
      b) Return [$ext($sizenn1(Inn_1), $sizenn2(Inn_2), sx, iN_1)].
2. If ((cvtop_u0 is WRAP) and the type of numty_u1 is Inn), then:
  a. Let Inn_1 be numty_u1.
  b. If the type of numty_u4 is Inn, then:
    1) Let Inn_2 be numty_u4.
    2) Let iN_1 be num__u3.
    3) Return [$wrap($sizenn1(Inn_1), $sizenn2(Inn_2), iN_1)].
3. If the type of numty_u1 is Fnn, then:
  a. Let Fnn_1 be numty_u1.
  b. If the type of numty_u4 is Inn, then:
    1) Let Inn_2 be numty_u4.
    2) Let fN_1 be num__u3.
    3) If cvtop_u0 is of the case TRUNC, then:
      a) Let (TRUNC sx) be cvtop_u0.
      b) Return [$trunc($sizenn1(Fnn_1), $sizenn2(Inn_2), sx, fN_1)].
    4) If cvtop_u0 is of the case TRUNC_SAT, then:
      a) Let (TRUNC_SAT sx) be cvtop_u0.
      b) Return [$trunc_sat($sizenn1(Fnn_1), $sizenn2(Inn_2), sx, fN_1)].
4. If the type of numty_u4 is Fnn, then:
  a. Let Fnn_2 be numty_u4.
  b. If the type of numty_u1 is Inn, then:
    1) Let Inn_1 be numty_u1.
    2) Let iN_1 be num__u3.
    3) If cvtop_u0 is of the case CONVERT, then:
      a) Let (CONVERT sx) be cvtop_u0.
      b) Return [$convert($sizenn1(Inn_1), $sizenn2(Fnn_2), sx, iN_1)].
5. If ((cvtop_u0 is PROMOTE) and the type of numty_u1 is Fnn), then:
  a. Let Fnn_1 be numty_u1.
  b. If the type of numty_u4 is Fnn, then:
    1) Let Fnn_2 be numty_u4.
    2) Let fN_1 be num__u3.
    3) Return [$promote($sizenn1(Fnn_1), $sizenn2(Fnn_2), fN_1)].
6. If ((cvtop_u0 is DEMOTE) and the type of numty_u1 is Fnn), then:
  a. Let Fnn_1 be numty_u1.
  b. If the type of numty_u4 is Fnn, then:
    1) Let Fnn_2 be numty_u4.
    2) Let fN_1 be num__u3.
    3) Return [$demote($sizenn1(Fnn_1), $sizenn2(Fnn_2), fN_1)].
7. Assert: Due to validation, (cvtop_u0 is REINTERPRET).
8. If the type of numty_u4 is Fnn, then:
  a. Let Fnn_2 be numty_u4.
  b. If the type of numty_u1 is Inn, then:
    1) Let Inn_1 be numty_u1.
    2) Let iN_1 be num__u3.
    3) If ($sizenn1(Inn_1) is $sizenn2(Fnn_2)), then:
      a) Return [$reinterpret(Inn_1, Fnn_2, iN_1)].
9. Assert: Due to validation, the type of numty_u1 is Fnn.
10. Let Fnn_1 be numty_u1.
11. Assert: Due to validation, the type of numty_u4 is Inn.
12. Let Inn_2 be numty_u4.
13. Let fN_1 be num__u3.
14. Assert: Due to validation, ($sizenn1(Fnn_1) is $sizenn2(Inn_2)).
15. Return [$reinterpret(Fnn_1, Inn_2, fN_1)].

invibytes N b*
1. Let n be $ibytes_1^-1(N, b*).
2. Return n.

invfbytes N b*
1. Let p be $fbytes_1^-1(N, b*).
2. Return p.

lpacknum lanet_u0 c
1. If the type of lanet_u0 is numtype, then:
  a. Return c.
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $wrap($size($lunpack(packtype)), $psize(packtype), c).

lunpacknum lanet_u0 c
1. If the type of lanet_u0 is numtype, then:
  a. Return c.
2. Assert: Due to validation, the type of lanet_u0 is packtype.
3. Let packtype be lanet_u0.
4. Return $ext($psize(packtype), $size($lunpack(packtype)), U, c).

cpacknum stora_u0 c
1. If the type of stora_u0 is consttype, then:
  a. Return c.
2. Assert: Due to validation, the type of stora_u0 is packtype.
3. Let packtype be stora_u0.
4. Return $wrap($size($lunpack(packtype)), $psize(packtype), c).

cunpacknum stora_u0 c
1. If the type of stora_u0 is consttype, then:
  a. Return c.
2. Assert: Due to validation, the type of stora_u0 is packtype.
3. Let packtype be stora_u0.
4. Return $ext($psize(packtype), $size($lunpack(packtype)), U, c).

invlanes_ sh c*
1. Let vc be $lanes__1^-1(sh, c*).
2. Return vc.

half (lanet_u1 X M_1) (lanet_u2 X M_2) half__u0 i j
1. If ((half__u0 is LOW) and (the type of lanet_u1 is Jnn and the type of lanet_u2 is Jnn)), then:
  a. Return i.
2. If ((half__u0 is HIGH) and (the type of lanet_u1 is Jnn and the type of lanet_u2 is Jnn)), then:
  a. Return j.
3. Assert: Due to validation, (half__u0 is LOW).
4. Assert: Due to validation, the type of lanet_u2 is Fnn.
5. Return i.

vvunop V128 NOT v128
1. Return $inot($vsize(V128), v128).

vvbinop V128 vvbin_u0 v128_1 v128_2
1. If (vvbin_u0 is AND), then:
  a. Return $iand($vsize(V128), v128_1, v128_2).
2. If (vvbin_u0 is ANDNOT), then:
  a. Return $iandnot($vsize(V128), v128_1, v128_2).
3. If (vvbin_u0 is OR), then:
  a. Return $ior($vsize(V128), v128_1, v128_2).
4. Assert: Due to validation, (vvbin_u0 is XOR).
5. Return $ixor($vsize(V128), v128_1, v128_2).

vvternop V128 BITSELECT v128_1 v128_2 v128_3
1. Return $ibitselect($vsize(V128), v128_1, v128_2, v128_3).

vunop (lanet_u1 X N) vunop_u0 v128_1
1. If ((vunop_u0 is ABS) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let v128 be $invlanes_((Jnn X N), $iabs($lsize(Jnn), lane_1)*).
  d. Return v128.
2. If ((vunop_u0 is NEG) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let v128 be $invlanes_((Jnn X N), $ineg($lsize(Jnn), lane_1)*).
  d. Return v128.
3. If ((vunop_u0 is POPCNT) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let v128 be $invlanes_((Jnn X N), $ipopcnt($lsize(Jnn), lane_1)*).
  d. Return v128.
4. If ((vunop_u0 is ABS) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128 be $invlanes_((Fnn X N), $fabs($size(Fnn), lane_1)*).
  d. Return v128.
5. If ((vunop_u0 is NEG) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128 be $invlanes_((Fnn X N), $fneg($size(Fnn), lane_1)*).
  d. Return v128.
6. If ((vunop_u0 is SQRT) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128 be $invlanes_((Fnn X N), $fsqrt($size(Fnn), lane_1)*).
  d. Return v128.
7. If ((vunop_u0 is CEIL) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128 be $invlanes_((Fnn X N), $fceil($size(Fnn), lane_1)*).
  d. Return v128.
8. If ((vunop_u0 is FLOOR) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128 be $invlanes_((Fnn X N), $ffloor($size(Fnn), lane_1)*).
  d. Return v128.
9. If ((vunop_u0 is TRUNC) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let v128 be $invlanes_((Fnn X N), $ftrunc($size(Fnn), lane_1)*).
  d. Return v128.
10. Assert: Due to validation, (vunop_u0 is NEAREST).
11. Assert: Due to validation, the type of lanet_u1 is Fnn.
12. Let Fnn be lanet_u1.
13. Let lane_1* be $lanes_((Fnn X N), v128_1).
14. Let v128 be $invlanes_((Fnn X N), $fnearest($size(Fnn), lane_1)*).
15. Return v128.

vbinop (lanet_u1 X N) vbino_u0 v128_1 v128_2
1. If ((vbino_u0 is ADD) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $iadd($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
2. If ((vbino_u0 is SUB) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $isub($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
3. If the type of lanet_u1 is Jnn, then:
  a. Let Jnn be lanet_u1.
  b. If vbino_u0 is of the case MIN, then:
    1) Let (MIN sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $imin($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
  c. If vbino_u0 is of the case MAX, then:
    1) Let (MAX sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $imax($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
  d. If vbino_u0 is of the case ADD_SAT, then:
    1) Let (ADD_SAT sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $iaddsat($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
  e. If vbino_u0 is of the case SUB_SAT, then:
    1) Let (SUB_SAT sx) be vbino_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let v128 be $invlanes_((Jnn X N), $isubsat($lsize(Jnn), sx, lane_1, lane_2)*).
    5) Return [v128].
4. If ((vbino_u0 is MUL) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $imul($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
5. If ((vbino_u0 is AVGR_U) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $iavgr_u($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
6. If ((vbino_u0 is Q15MULR_SAT_S) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let v128 be $invlanes_((Jnn X N), $iq15mulrsat_s($lsize(Jnn), lane_1, lane_2)*).
  e. Return [v128].
7. If ((vbino_u0 is ADD) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fadd($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
8. If ((vbino_u0 is SUB) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fsub($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
9. If ((vbino_u0 is MUL) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fmul($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
10. If ((vbino_u0 is DIV) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fdiv($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
11. If ((vbino_u0 is MIN) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fmin($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
12. If ((vbino_u0 is MAX) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fmax($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
13. If ((vbino_u0 is PMIN) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let v128 be $invlanes_((Fnn X N), $fpmin($size(Fnn), lane_1, lane_2)*).
  e. Return [v128].
14. Assert: Due to validation, (vbino_u0 is PMAX).
15. Assert: Due to validation, the type of lanet_u1 is Fnn.
16. Let Fnn be lanet_u1.
17. Let lane_1* be $lanes_((Fnn X N), v128_1).
18. Let lane_2* be $lanes_((Fnn X N), v128_2).
19. Let v128 be $invlanes_((Fnn X N), $fpmax($size(Fnn), lane_1, lane_2)*).
20. Return [v128].

vrelop (lanet_u1 X N) vrelo_u0 v128_1 v128_2
1. If ((vrelo_u0 is EQ) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let lane_3* be $ext(1, $lsize(Jnn), S, $ieq($lsize(Jnn), lane_1, lane_2))*.
  e. Let v128 be $invlanes_((Jnn X N), lane_3*).
  f. Return v128.
2. If ((vrelo_u0 is NE) and the type of lanet_u1 is Jnn), then:
  a. Let Jnn be lanet_u1.
  b. Let lane_1* be $lanes_((Jnn X N), v128_1).
  c. Let lane_2* be $lanes_((Jnn X N), v128_2).
  d. Let lane_3* be $ext(1, $lsize(Jnn), S, $ine($lsize(Jnn), lane_1, lane_2))*.
  e. Let v128 be $invlanes_((Jnn X N), lane_3*).
  f. Return v128.
3. If the type of lanet_u1 is Jnn, then:
  a. Let Jnn be lanet_u1.
  b. If vrelo_u0 is of the case LT, then:
    1) Let (LT sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $ext(1, $lsize(Jnn), S, $ilt($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
  c. If vrelo_u0 is of the case GT, then:
    1) Let (GT sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $ext(1, $lsize(Jnn), S, $igt($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
  d. If vrelo_u0 is of the case LE, then:
    1) Let (LE sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $ext(1, $lsize(Jnn), S, $ile($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
  e. If vrelo_u0 is of the case GE, then:
    1) Let (GE sx) be vrelo_u0.
    2) Let lane_1* be $lanes_((Jnn X N), v128_1).
    3) Let lane_2* be $lanes_((Jnn X N), v128_2).
    4) Let lane_3* be $ext(1, $lsize(Jnn), S, $ige($lsize(Jnn), sx, lane_1, lane_2))*.
    5) Let v128 be $invlanes_((Jnn X N), lane_3*).
    6) Return v128.
4. If ((vrelo_u0 is EQ) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $ext(1, $size(Fnn), S, $feq($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
5. If ((vrelo_u0 is NE) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $ext(1, $size(Fnn), S, $fne($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
6. If ((vrelo_u0 is LT) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $ext(1, $size(Fnn), S, $flt($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
7. If ((vrelo_u0 is GT) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $ext(1, $size(Fnn), S, $fgt($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
8. If ((vrelo_u0 is LE) and the type of lanet_u1 is Fnn), then:
  a. Let Fnn be lanet_u1.
  b. Let lane_1* be $lanes_((Fnn X N), v128_1).
  c. Let lane_2* be $lanes_((Fnn X N), v128_2).
  d. Let Inn be $isize^-1($size(Fnn)).
  e. Let lane_3* be $ext(1, $size(Fnn), S, $fle($size(Fnn), lane_1, lane_2))*.
  f. Let v128 be $invlanes_((Inn X N), lane_3*).
  g. Return v128.
9. Assert: Due to validation, (vrelo_u0 is GE).
10. Assert: Due to validation, the type of lanet_u1 is Fnn.
11. Let Fnn be lanet_u1.
12. Let lane_1* be $lanes_((Fnn X N), v128_1).
13. Let lane_2* be $lanes_((Fnn X N), v128_2).
14. Let Inn be $isize^-1($size(Fnn)).
15. Let lane_3* be $ext(1, $size(Fnn), S, $fge($size(Fnn), lane_1, lane_2))*.
16. Let v128 be $invlanes_((Inn X N), lane_3*).
17. Return v128.

vcvtop (lanet_u0 X N_1) (lanet_u1 X N_2) vcvto_u6 sx_u7? lane__u3
1. If ((lanet_u0 is I8) and ((lanet_u1 is I16) and (vcvto_u6 is EXTEND))), then:
  a. Let i8 be lane__u3.
  b. If sx_u7? is defined, then:
    1) Let ?(sx) be sx_u7?.
    2) Let i16 be $ext(8, 16, sx, i8).
    3) Return i16.
2. If ((lanet_u0 is I16) and ((lanet_u1 is I32) and (vcvto_u6 is EXTEND))), then:
  a. Let i16 be lane__u3.
  b. If sx_u7? is defined, then:
    1) Let ?(sx) be sx_u7?.
    2) Let i32 be $ext(16, 32, sx, i16).
    3) Return i32.
3. If (lanet_u0 is I32), then:
  a. If ((lanet_u1 is I64) and (vcvto_u6 is EXTEND)), then:
    1) Let i32 be lane__u3.
    2) If sx_u7? is defined, then:
      a) Let ?(sx) be sx_u7?.
      b) Let i64 be $ext(32, 64, sx, i32).
      c) Return i64.
  b. If ((lanet_u1 is F32) and (vcvto_u6 is CONVERT)), then:
    1) Let i32 be lane__u3.
    2) If sx_u7? is defined, then:
      a) Let ?(sx) be sx_u7?.
      b) Let f32 be $convert(32, 32, sx, i32).
      c) Return f32.
  c. If ((lanet_u1 is F64) and (vcvto_u6 is CONVERT)), then:
    1) Let i32 be lane__u3.
    2) If sx_u7? is defined, then:
      a) Let ?(sx) be sx_u7?.
      b) Let f64 be $convert(32, 64, sx, i32).
      c) Return f64.
4. If ((lanet_u0 is F32) and ((lanet_u1 is I32) and (vcvto_u6 is TRUNC_SAT))), then:
  a. Let f32 be lane__u3.
  b. If sx_u7? is defined, then:
    1) Let ?(sx) be sx_u7?.
    2) Let i32 be $trunc_sat(32, 32, sx, f32).
    3) Return i32.
5. If (lanet_u0 is F64), then:
  a. If ((lanet_u1 is I32) and (vcvto_u6 is TRUNC_SAT)), then:
    1) Let f64 be lane__u3.
    2) If sx_u7? is defined, then:
      a) Let ?(sx) be sx_u7?.
      b) Let i32 be $trunc_sat(64, 32, sx, f64).
      c) Return i32.
  b. If ((lanet_u1 is F32) and (vcvto_u6 is DEMOTE)), then:
    1) Let f64 be lane__u3.
    2) Let f32 be $demote(64, 32, f64).
    3) Return f32.
6. Assert: Due to validation, (lanet_u0 is F32).
7. Assert: Due to validation, (lanet_u1 is F64).
8. Assert: Due to validation, (vcvto_u6 is PROMOTE).
9. Let f32 be lane__u3.
10. Let f64 be $promote(32, 64, f32).
11. Return f64.

vextunop (Jnn_1 X N_1) (Jnn_2 X N_2) (EXTADD_PAIRWISE sx) c_1
1. Let ci* be $lanes_((Jnn_1 X N_1), c_1).
2. Let [cj_1, cj_2]* be $concat_^-1($ext($lsize(Jnn_1), $lsize(Jnn_2), sx, ci)*).
3. Let c be $invlanes_((Jnn_2 X N_2), $iadd($lsize(Jnn_2), cj_1, cj_2)*).
4. Return c.

vextbinop (Jnn_1 X N_1) (Jnn_2 X N_2) vextb_u0 c_1 c_2
1. If vextb_u0 is of the case EXTMUL, then:
  a. Let (EXTMUL sx half) be vextb_u0.
  b. Let ci_1* be $lanes_((Jnn_1 X N_1), c_1)[$half((Jnn_1 X N_1), (Jnn_2 X N_2), half, 0, N_2) : N_2].
  c. Let ci_2* be $lanes_((Jnn_1 X N_1), c_2)[$half((Jnn_1 X N_1), (Jnn_2 X N_2), half, 0, N_2) : N_2].
  d. Let c be $invlanes_((Jnn_2 X N_2), $imul($lsize(Jnn_2), $ext($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_1), $ext($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_2))*).
  e. Return c.
2. Assert: Due to validation, (vextb_u0 is DOT).
3. Let ci_1* be $lanes_((Jnn_1 X N_1), c_1).
4. Let ci_2* be $lanes_((Jnn_1 X N_1), c_2).
5. Let [cj_1, cj_2]* be $concat_^-1($imul($lsize(Jnn_2), $ext($lsize(Jnn_1), $lsize(Jnn_2), S, ci_1), $ext($lsize(Jnn_1), $lsize(Jnn_2), S, ci_2))*).
6. Let c be $invlanes_((Jnn_2 X N_2), $iadd($lsize(Jnn_2), cj_1, cj_2)*).
7. Return c.

vshiftop (Jnn X N) vshif_u0 lane n
1. If (vshif_u0 is SHL), then:
  a. Return $ishl($lsize(Jnn), lane, n).
2. Assert: Due to validation, vshif_u0 is of the case SHR.
3. Let (SHR sx) be vshif_u0.
4. Return $ishr($lsize(Jnn), sx, lane, n).

inst_valtype moduleinst t
1. Let dt* be moduleinst.TYPES.
2. Return $subst_all_valtype(t, dt*).

inst_reftype moduleinst rt
1. Let dt* be moduleinst.TYPES.
2. Return $subst_all_reftype(rt, dt*).

default_ valty_u0
1. If the type of valty_u0 is Inn, then:
  a. Let Inn be valty_u0.
  b. Return ?((Inn.CONST 0)).
2. If the type of valty_u0 is Fnn, then:
  a. Let Fnn be valty_u0.
  b. Return ?((Fnn.CONST $fzero($size(Fnn)))).
3. If the type of valty_u0 is Vnn, then:
  a. Let Vnn be valty_u0.
  b. Return ?((Vnn.CONST 0)).
4. Assert: Due to validation, valty_u0 is of the case REF.
5. Let (REF y_0 ht) be valty_u0.
6. If (y_0 is (NULL ?(()))), then:
  a. Return ?((REF.NULL ht)).
7. Assert: Due to validation, (y_0 is (NULL ?())).
8. Return ?().

packfield stora_u0 val_u1
1. Let val be val_u1.
2. If the type of stora_u0 is valtype, then:
  a. Return val.
3. Assert: Due to validation, val_u1 is of the case CONST.
4. Let (y_0.CONST i) be val_u1.
5. Assert: Due to validation, (y_0 is I32).
6. Assert: Due to validation, the type of stora_u0 is packtype.
7. Let packtype be stora_u0.
8. Return (PACK packtype $wrap(32, $psize(packtype), i)).

unpackfield stora_u0 sx_u1? field_u2
1. If sx_u1? is not defined, then:
  a. Assert: Due to validation, the type of field_u2 is val.
  b. Let val be field_u2.
  c. Assert: Due to validation, the type of stora_u0 is valtype.
  d. Return val.
2. Else:
  a. Let ?(sx) be sx_u1?.
  b. Assert: Due to validation, field_u2 is of the case PACK.
  c. Let (PACK packtype i) be field_u2.
  d. Assert: Due to validation, (stora_u0 is packtype).
  e. Return (I32.CONST $ext($psize(packtype), 32, sx, i)).

funcsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case FUNC, then:
  a. Let (FUNC fa) be y_0.
  b. Return [fa] ++ $funcsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $funcsxv(xv*).

globalsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case GLOBAL, then:
  a. Let (GLOBAL ga) be y_0.
  b. Return [ga] ++ $globalsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $globalsxv(xv*).

tablesxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case TABLE, then:
  a. Let (TABLE ta) be y_0.
  b. Return [ta] ++ $tablesxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $tablesxv(xv*).

memsxv exter_u0*
1. If (exter_u0* is []), then:
  a. Return [].
2. Let [y_0] ++ xv* be exter_u0*.
3. If y_0 is of the case MEM, then:
  a. Let (MEM ma) be y_0.
  b. Return [ma] ++ $memsxv(xv*).
4. Let [externval] ++ xv* be exter_u0*.
5. Return $memsxv(xv*).

store
1. Return.

frame
1. Let f be the current frame.
2. Return f.

moduleinst
1. Let f be the current frame.
2. Return f.MODULE.

funcinst
1. Return s.FUNCS.

globalinst
1. Return s.GLOBALS.

tableinst
1. Return s.TABLES.

meminst
1. Return s.MEMS.

eleminst
1. Return s.ELEMS.

datainst
1. Return s.DATAS.

structinst
1. Return s.STRUCTS.

arrayinst
1. Return s.ARRAYS.

type x
1. Let f be the current frame.
2. Return f.MODULE.TYPES[x].

func x
1. Let f be the current frame.
2. Return s.FUNCS[f.MODULE.FUNCS[x]].

global x
1. Let f be the current frame.
2. Return s.GLOBALS[f.MODULE.GLOBALS[x]].

table x
1. Let f be the current frame.
2. Return s.TABLES[f.MODULE.TABLES[x]].

mem x
1. Let f be the current frame.
2. Return s.MEMS[f.MODULE.MEMS[x]].

elem x
1. Let f be the current frame.
2. Return s.ELEMS[f.MODULE.ELEMS[x]].

data x
1. Let f be the current frame.
2. Return s.DATAS[f.MODULE.DATAS[x]].

local x
1. Let f be the current frame.
2. Return f.LOCALS[x].

with_local x v
1. Let f be the current frame.
2. Replace f.LOCALS[x] with ?(v).

with_global x v
1. Let f be the current frame.
2. Replace s.GLOBALS[f.MODULE.GLOBALS[x]].VALUE with v.

with_table x i r
1. Let f be the current frame.
2. Replace s.TABLES[f.MODULE.TABLES[x]].REFS[i] with r.

with_tableinst x ti
1. Let f be the current frame.
2. Replace s.TABLES[f.MODULE.TABLES[x]] with ti.

with_mem x i j b*
1. Let f be the current frame.
2. Replace s.MEMS[f.MODULE.MEMS[x]].BYTES[i : j] with b*.

with_meminst x mi
1. Let f be the current frame.
2. Replace s.MEMS[f.MODULE.MEMS[x]] with mi.

with_elem x r*
1. Let f be the current frame.
2. Replace s.ELEMS[f.MODULE.ELEMS[x]].REFS with r*.

with_data x b*
1. Let f be the current frame.
2. Replace s.DATAS[f.MODULE.DATAS[x]].BYTES with b*.

with_struct a i fv
1. Let f be the current frame.
2. Replace s.STRUCTS[a].FIELDS[i] with fv.

with_array a i fv
1. Let f be the current frame.
2. Replace s.ARRAYS[a].FIELDS[i] with fv.

ext_structinst si*
1. Let f be the current frame.
2. Return (s with .STRUCTS appended by si*, f).

ext_arrayinst ai*
1. Let f be the current frame.
2. Return (s with .ARRAYS appended by ai*, f).

growtable tableinst n r
1. Let { TYPE: ((i, j), rt); REFS: r'*; } be tableinst.
2. If ((|r'*| + n) ≤ j), then:
  a. Let i' be (|r'*| + n).
  b. Let tableinst' be { TYPE: ((i', j), rt); REFS: r'* ++ r^n; }.
  c. Return tableinst'.

growmem meminst n
1. Let { TYPE: (PAGE (i, j)); BYTES: b*; } be meminst.
2. If (((|b*| / (64 · $Ki())) + n) ≤ j), then:
  a. Let i' be ((|b*| / (64 · $Ki())) + n).
  b. Let meminst' be { TYPE: (PAGE (i', j)); BYTES: b* ++ 0^(n · (64 · $Ki())); }.
  c. Return meminst'.

with_locals C local_u0* local_u1*
1. If ((local_u0* is []) and (local_u1* is [])), then:
  a. Return C.
2. Assert: Due to validation, (|local_u1*| ≥ 1).
3. Let [lct_1] ++ lct* be local_u1*.
4. Assert: Due to validation, (|local_u0*| ≥ 1).
5. Let [x_1] ++ x* be local_u0*.
6. Return $with_locals(C with .LOCALS[x_1] replaced by lct_1, x*, lct*).

clos_deftypes defty_u0*
1. If (defty_u0* is []), then:
  a. Return [].
2. Let dt* ++ [dt_n] be defty_u0*.
3. Let dt'* be $clos_deftypes(dt*).
4. Return dt'* ++ [$subst_all_deftype(dt_n, dt'*)].

clos_valtype C t
1. Let dt* be $clos_deftypes(C.TYPES).
2. Return $subst_all_valtype(t, dt*).

clos_deftype C dt
1. Let dt'* be $clos_deftypes(C.TYPES).
2. Return $subst_all_deftype(dt, dt'*).

clos_moduletype C mmt
1. Let dt* be $clos_deftypes(C.TYPES).
2. Return $subst_all_moduletype(mmt, dt*).

before typeu_u0 x i
1. If the type of typeu_u0 is deftype, then:
  a. Return true.
2. If typeu_u0 is of the case _IDX, then:
  a. Let (_IDX typeidx) be typeu_u0.
  b. Return (typeidx < x).
3. Assert: Due to validation, typeu_u0 is of the case REC.
4. Let (REC j) be typeu_u0.
5. Return (j < i).

unrollht C heapt_u0
1. If the type of heapt_u0 is deftype, then:
  a. Let deftype be heapt_u0.
  b. Return $unrolldt(deftype).
2. If heapt_u0 is of the case _IDX, then:
  a. Let (_IDX typeidx) be heapt_u0.
  b. Return $unrolldt(C.TYPES[typeidx]).
3. Assert: Due to validation, heapt_u0 is of the case REC.
4. Let (REC i) be heapt_u0.
5. Return C.RECS[i].

funcidx_nonfuncs YetE (`%%%%%`_nonfuncs(global*{global : global}, table*{table : table}, mem*{mem : mem}, elem*{elem : elem}, data*{data : data}))
1. Return $funcidx_module((MODULE [] [] [] global* table* mem* elem* data* [] [])).

blocktype_ block_u0
1. If block_u0 is of the case _IDX, then:
  a. Let (_IDX x) be block_u0.
  b. Assert: Due to validation, $expanddt($type(x)) is of the case FUNC.
  c. Let (FUNC ft) be $expanddt($type(x)).
  d. Return ft.
2. Assert: Due to validation, block_u0 is of the case _RESULT.
3. Let (_RESULT t?) be block_u0.
4. Return ([] -> t?).

alloctypes type_u0*
1. If (type_u0* is []), then:
  a. Return [].
2. Let type'* ++ [type] be type_u0*.
3. Assert: Due to validation, type is of the case TYPE.
4. Let (TYPE rectype) be type.
5. Let deftype'* be $alloctypes(type'*).
6. Let x be |deftype'*|.
7. Let deftype* be $subst_all_deftypes($rolldt(x, rectype), deftype'*).
8. Return deftype'* ++ deftype*.

allocfunc deftype funccode moduleinst
1. Let funcinst be { TYPE: deftype; MODULE: moduleinst; CODE: funccode; }.
2. Let a be |s.FUNCS|.
3. Append funcinst to the s.FUNCS.
4. Return a.

allocfuncs defty_u0* funcc_u1* modul_u2*
1. If (defty_u0* is []), then:
  a. Assert: Due to validation, (funcc_u1* is []).
  b. Assert: Due to validation, (modul_u2* is []).
  c. Return [].
2. Else:
  a. Let [dt] ++ dt'* be defty_u0*.
  b. Assert: Due to validation, (|funcc_u1*| ≥ 1).
  c. Let [funccode] ++ funccode'* be funcc_u1*.
  d. Assert: Due to validation, (|modul_u2*| ≥ 1).
  e. Let [moduleinst] ++ moduleinst'* be modul_u2*.
  f. Let fa be $allocfunc(dt, funccode, moduleinst).
  g. Let fa'* be $allocfuncs(dt'*, funccode'*, moduleinst'*).
  h. Return [fa] ++ fa'*.

allocglobal globaltype val
1. Let globalinst be { TYPE: globaltype; VALUE: val; }.
2. Let a be |s.GLOBALS|.
3. Append globalinst to the s.GLOBALS.
4. Return a.

allocglobals globa_u0* val_u1*
1. If (globa_u0* is []), then:
  a. Assert: Due to validation, (val_u1* is []).
  b. Return [].
2. Else:
  a. Let [globaltype] ++ globaltype'* be globa_u0*.
  b. Assert: Due to validation, (|val_u1*| ≥ 1).
  c. Let [val] ++ val'* be val_u1*.
  d. Let ga be $allocglobal(globaltype, val).
  e. Let ga'* be $allocglobals(globaltype'*, val'*).
  f. Return [ga] ++ ga'*.

alloctable ((i, j), rt) ref
1. Let tableinst be { TYPE: ((i, j), rt); REFS: ref^i; }.
2. Let a be |s.TABLES|.
3. Append tableinst to the s.TABLES.
4. Return a.

alloctables table_u0* ref_u1*
1. If ((table_u0* is []) and (ref_u1* is [])), then:
  a. Return [].
2. Assert: Due to validation, (|ref_u1*| ≥ 1).
3. Let [ref] ++ ref'* be ref_u1*.
4. Assert: Due to validation, (|table_u0*| ≥ 1).
5. Let [tabletype] ++ tabletype'* be table_u0*.
6. Let ta be $alloctable(tabletype, ref).
7. Let ta'* be $alloctables(tabletype'*, ref'*).
8. Return [ta] ++ ta'*.

allocmem (PAGE (i, j))
1. Let meminst be { TYPE: (PAGE (i, j)); BYTES: 0^(i · (64 · $Ki())); }.
2. Let a be |s.MEMS|.
3. Append meminst to the s.MEMS.
4. Return a.

allocmems memty_u0*
1. If (memty_u0* is []), then:
  a. Return [].
2. Let [memtype] ++ memtype'* be memty_u0*.
3. Let ma be $allocmem(memtype).
4. Let ma'* be $allocmems(memtype'*).
5. Return [ma] ++ ma'*.

allocelem elemtype ref*
1. Let eleminst be { TYPE: elemtype; REFS: ref*; }.
2. Let a be |s.ELEMS|.
3. Append eleminst to the s.ELEMS.
4. Return a.

allocelems elemt_u0* ref_u1*
1. If ((elemt_u0* is []) and (ref_u1* is [])), then:
  a. Return [].
2. Assert: Due to validation, (|ref_u1*| ≥ 1).
3. Let [ref*] ++ ref'** be ref_u1*.
4. Assert: Due to validation, (|elemt_u0*| ≥ 1).
5. Let [rt] ++ rt'* be elemt_u0*.
6. Let ea be $allocelem(rt, ref*).
7. Let ea'* be $allocelems(rt'*, ref'**).
8. Return [ea] ++ ea'*.

allocdata OK byte*
1. Let datainst be { BYTES: byte*; }.
2. Let a be |s.DATAS|.
3. Append datainst to the s.DATAS.
4. Return a.

allocdatas datat_u0* byte_u1*
1. If ((datat_u0* is []) and (byte_u1* is [])), then:
  a. Return [].
2. Assert: Due to validation, (|byte_u1*| ≥ 1).
3. Let [b*] ++ b'** be byte_u1*.
4. Assert: Due to validation, (|datat_u0*| ≥ 1).
5. Let [ok] ++ ok'* be datat_u0*.
6. Let da be $allocdata(ok, b*).
7. Let da'* be $allocdatas(ok'*, b'**).
8. Return [da] ++ da'*.

allocexport moduleinst (EXPORT name exter_u0)
1. If exter_u0 is of the case FUNC, then:
  a. Let (FUNC x) be exter_u0.
  b. Return { NAME: name; VALUE: (FUNC moduleinst.FUNCS[x]); }.
2. If exter_u0 is of the case GLOBAL, then:
  a. Let (GLOBAL x) be exter_u0.
  b. Return { NAME: name; VALUE: (GLOBAL moduleinst.GLOBALS[x]); }.
3. If exter_u0 is of the case TABLE, then:
  a. Let (TABLE x) be exter_u0.
  b. Return { NAME: name; VALUE: (TABLE moduleinst.TABLES[x]); }.
4. Assert: Due to validation, exter_u0 is of the case MEM.
5. Let (MEM x) be exter_u0.
6. Return { NAME: name; VALUE: (MEM moduleinst.MEMS[x]); }.

allocexports moduleinst export*
1. Return $allocexport(moduleinst, export)*.

allocmodule module externval* val_G* ref_T* ref_E**
1. Let fa_I* be $funcsxv(externval*).
2. Let ga_I* be $globalsxv(externval*).
3. Let ma_I* be $memsxv(externval*).
4. Let ta_I* be $tablesxv(externval*).
5. Assert: Due to validation, module is of the case MODULE.
6. Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) be module.
7. Let fa* be (|s.FUNCS| + i_F)^(i_F<|func*|).
8. Let ga* be (|s.GLOBALS| + i_G)^(i_G<|global*|).
9. Let ta* be (|s.TABLES| + i_T)^(i_T<|table*|).
10. Let ma* be (|s.MEMS| + i_M)^(i_M<|mem*|).
11. Let ea* be (|s.ELEMS| + i_E)^(i_E<|elem*|).
12. Let da* be (|s.DATAS| + i_D)^(i_D<|data*|).
13. Assert: Due to validation, mem* is of the case MEMORY.
14. Let (MEMORY memtype)* be mem*.
15. Let dt* be $alloctypes(type*).
16. Assert: Due to validation, data* is of the case DATA.
17. Let (DATA byte* datamode)* be data*.
18. Assert: Due to validation, global* is of the case GLOBAL.
19. Let (GLOBAL globaltype expr_G)* be global*.
20. Assert: Due to validation, table* is of the case TABLE.
21. Let (TABLE tabletype expr_T)* be table*.
22. Assert: Due to validation, elem* is of the case ELEM.
23. Let (ELEM elemtype expr_E* elemmode)* be elem*.
24. Assert: Due to validation, func* is of the case FUNC.
25. Let (FUNC x local* expr_F)* be func*.
26. Let xi* be $allocexports({ TYPES: []; FUNCS: fa_I* ++ fa*; GLOBALS: ga_I* ++ ga*; TABLES: ta_I* ++ ta*; MEMS: ma_I* ++ ma*; ELEMS: []; DATAS: []; EXPORTS: []; }, export*).
27. Let moduleinst be { TYPES: dt*; FUNCS: fa_I* ++ fa*; GLOBALS: ga_I* ++ ga*; TABLES: ta_I* ++ ta*; MEMS: ma_I* ++ ma*; ELEMS: ea*; DATAS: da*; EXPORTS: xi*; }.
28. Let y_0 be $allocfuncs(dt*[x]*, (FUNC x local* expr_F)*, moduleinst^|func*|).
29. Assert: Due to validation, (y_0 is fa*).
30. Let y_0 be $allocglobals(globaltype*, val_G*).
31. Assert: Due to validation, (y_0 is ga*).
32. Let y_0 be $alloctables(tabletype*, ref_T*).
33. Assert: Due to validation, (y_0 is ta*).
34. Let y_0 be $allocmems(memtype*).
35. Assert: Due to validation, (y_0 is ma*).
36. Let y_0 be $allocelems(elemtype*, ref_E**).
37. Assert: Due to validation, (y_0 is ea*).
38. Let y_0 be $allocdatas(OK^|data*|, byte**).
39. Assert: Due to validation, (y_0 is da*).
40. Return moduleinst.

runelem_ x (ELEM rt e^n elemm_u0)
1. If (elemm_u0 is PASSIVE), then:
  a. Return [].
2. If (elemm_u0 is DECLARE), then:
  a. Return [(ELEM.DROP x)].
3. Assert: Due to validation, elemm_u0 is of the case ACTIVE.
4. Let (ACTIVE y instr*) be elemm_u0.
5. Return instr* ++ [(I32.CONST 0), (I32.CONST n), (TABLE.INIT y x), (ELEM.DROP x)].

rundata_ x (DATA b^n datam_u0)
1. If (datam_u0 is PASSIVE), then:
  a. Return [].
2. Assert: Due to validation, datam_u0 is of the case ACTIVE.
3. Let (ACTIVE y instr*) be datam_u0.
4. Return instr* ++ [(I32.CONST 0), (I32.CONST n), (MEMORY.INIT y x), (DATA.DROP x)].

instantiate module externval*
1. Assert: Due to validation, module is of the case MODULE.
2. Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) be module.
3. Let instr_D* be $concat_($rundata_(i_D, data*[i_D])^(i_D<|data*|)).
4. Let instr_E* be $concat_($runelem_(i_E, elem*[i_E])^(i_E<|elem*|)).
5. Assert: Due to validation, start? is of the case START.
6. Let (START x)? be start?.
7. Let moduleinst_0 be { TYPES: $alloctypes(type*); FUNCS: $funcsxv(externval*) ++ (|s.FUNCS| + i_F)^(i_F<|func*|); GLOBALS: $globalsxv(externval*); TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }.
8. Assert: Due to validation, data* is of the case DATA.
9. Assert: Due to validation, global* is of the case GLOBAL.
10. Let (GLOBAL globaltype expr_G)* be global*.
11. Assert: Due to validation, table* is of the case TABLE.
12. Let (TABLE tabletype expr_T)* be table*.
13. Assert: Due to validation, elem* is of the case ELEM.
14. Let (ELEM reftype expr_E* elemmode)* be elem*.
15. Let instr_S? be (CALL x)?.
16. Let z be { LOCALS: []; MODULE: moduleinst_0; }.
17. Push the activation of z to the stack.
18. Let [val_G]* be $eval_expr(expr_G)*.
19. Pop the activation of z from the stack.
20. Push the activation of z to the stack.
21. Let [ref_T]* be $eval_expr(expr_T)*.
22. Pop the activation of z from the stack.
23. Push the activation of z to the stack.
24. Let [ref_E]** be $eval_expr(expr_E)**.
25. Pop the activation of z from the stack.
26. Let moduleinst be $allocmodule(module, externval*, val_G*, ref_T*, ref_E**).
27. Let f be { LOCALS: []; MODULE: moduleinst; }.
28. Push the activation of f with arity 0 to the stack.
29. Execute the sequence (instr_E*).
30. Execute the sequence (instr_D*).
31. If instr_S? is defined, then:
  a. Let ?(instr_0) be instr_S?.
  b. Execute the instruction instr_0.
32. Pop the activation of f with arity 0 from the stack.
33. Return f.MODULE.

invoke funcaddr val*
1. Let f be { LOCALS: []; MODULE: { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }; }.
2. Assert: Due to validation, $expanddt(s.FUNCS[funcaddr].TYPE) is of the case FUNC.
3. Let (FUNC y_0) be $expanddt(s.FUNCS[funcaddr].TYPE).
4. Let (t_1* -> t_2*) be y_0.
5. Let k be |t_2*|.
6. Push the activation of f with arity k to the stack.
7. Push the values val* to the stack.
8. Push the value (REF.FUNC_ADDR funcaddr) to the stack.
9. Execute the instruction (CALL_REF s.FUNCS[funcaddr].TYPE).
10. Pop all values val* from the top of the stack.
11. Pop the activation of f with arity k from the stack.
12. Push the values val* to the stack.
13. Pop the values val^k from the stack.
14. Return val^k.

allocXs X_u0* Y_u1*
1. If (X_u0* is []), then:
  a. Assert: Due to validation, (Y_u1* is []).
  b. Return [].
2. Else:
  a. Let [X] ++ X'* be X_u0*.
  b. Assert: Due to validation, (|Y_u1*| ≥ 1).
  c. Let [Y] ++ Y'* be Y_u1*.
  d. Let a be $allocX(X, Y).
  e. Let a'* be $allocXs(X'*, Y'*).
  f. Return [a] ++ a'*.

execution_of_UNREACHABLE
1. Trap.

execution_of_NOP
1. Do nothing.

execution_of_DROP
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Do nothing.

execution_of_SELECT t*?
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value val_2 from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop the value val_1 from the stack.
7. If (c is not 0), then:
  a. Push the value val_1 to the stack.
8. Else:
  a. Push the value val_2 to the stack.

execution_of_IF bt instr_1* instr_2*
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute the instruction (BLOCK bt instr_1*).
4. Else:
  a. Execute the instruction (BLOCK bt instr_2*).

execution_of_LABEL_
1. Pop all values val* from the top of the stack.
2. Assert: Due to validation, a label is now on the top of the stack.
3. Pop the current label from the stack.
4. Push the values val* to the stack.

execution_of_BR l
1. Pop all values val* from the top of the stack.
2. Let L be the current label.
3. Let n be the arity of L.
4. Let instr'* be the continuation of L.
5. Pop the current label from the stack.
6. Let instr_u0* be val*.
7. If ((l is 0) and (|instr_u0*| ≥ n)), then:
  a. Let val'* ++ val^n be instr_u0*.
  b. Push the values val^n to the stack.
  c. Execute the sequence (instr'*).
8. If ((l > 0) and the type of instr_u0 is val*), then:
  a. Let val* be instr_u0*.
  b. Push the values val* to the stack.
  c. Execute the instruction (BR (l - 1)).

execution_of_BR_IF l
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST c) from the stack.
3. If (c is not 0), then:
  a. Execute the instruction (BR l).
4. Else:
  a. Do nothing.

execution_of_BR_TABLE l* l'
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST i) from the stack.
3. If (i < |l*|), then:
  a. Execute the instruction (BR l*[i]).
4. Else:
  a. Execute the instruction (BR l').

execution_of_BR_ON_NULL l
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. If val is of the case REF.NULL, then:
  a. Execute the instruction (BR l).
4. Else:
  a. Push the value val to the stack.

execution_of_BR_ON_NON_NULL l
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. If val is of the case REF.NULL, then:
  a. Do nothing.
4. Else:
  a. Push the value val to the stack.
  b. Execute the instruction (BR l).

execution_of_CALL_INDIRECT x yy
1. Execute the instruction (TABLE.GET x).
2. Execute the instruction (REF.CAST (REF (NULL ?(())) yy)).
3. Execute the instruction (CALL_REF yy).

execution_of_RETURN_CALL_INDIRECT x yy
1. Execute the instruction (TABLE.GET x).
2. Execute the instruction (REF.CAST (REF (NULL ?(())) yy)).
3. Execute the instruction (RETURN_CALL_REF yy).

execution_of_FRAME_
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop the values val^n from the stack.
5. Assert: Due to validation, a frame is now on the top of the stack.
6. Pop the current frame from the stack.
7. Push the values val^n to the stack.

execution_of_RETURN
1. Pop all values val* from the top of the stack.
2. If a frame is now on the top of the stack, then:
  a. Let f be the current frame.
  b. Let n be the arity of f.
  c. Pop the current frame from the stack.
  d. Let val'* ++ val^n be val*.
  e. Push the values val^n to the stack.
3. Else if a label is now on the top of the stack, then:
  a. Pop the current label from the stack.
  b. Push the values val* to the stack.
  c. Execute the instruction RETURN.

execution_of_TRAP
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_UNOP nt unop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_1) from the stack.
3. If (|$unop(nt, unop, c_1)| is 1), then:
  a. Let [c] be $unop(nt, unop, c_1).
  b. Push the value (nt.CONST c) to the stack.
4. If ($unop(nt, unop, c_1) is []), then:
  a. Trap.

execution_of_BINOP nt binop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop the value (nt.CONST c_1) from the stack.
5. If (|$binop(nt, binop, c_1, c_2)| is 1), then:
  a. Let [c] be $binop(nt, binop, c_1, c_2).
  b. Push the value (nt.CONST c) to the stack.
6. If ($binop(nt, binop, c_1, c_2) is []), then:
  a. Trap.

execution_of_TESTOP nt testop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_1) from the stack.
3. Let c be $testop(nt, testop, c_1).
4. Push the value (I32.CONST c) to the stack.

execution_of_RELOP nt relop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop the value (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop the value (nt.CONST c_1) from the stack.
5. Let c be $relop(nt, relop, c_1, c_2).
6. Push the value (I32.CONST c) to the stack.

execution_of_CVTOP nt_2 nt_1 cvtop
1. Assert: Due to validation, a value of value type nt_1 is on the top of the stack.
2. Pop the value (nt_1.CONST c_1) from the stack.
3. If (|$cvtop(nt_1, nt_2, cvtop, c_1)| is 1), then:
  a. Let [c] be $cvtop(nt_1, nt_2, cvtop, c_1).
  b. Push the value (nt_2.CONST c) to the stack.
4. If ($cvtop(nt_1, nt_2, cvtop, c_1) is []), then:
  a. Trap.

execution_of_REF.I31
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST i) from the stack.
3. Push the value (REF.I31_NUM $wrap(32, 31, i)) to the stack.

execution_of_REF.IS_NULL
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value ref from the stack.
3. If ref is of the case REF.NULL, then:
  a. Push the value (I32.CONST 1) to the stack.
4. Else:
  a. Push the value (I32.CONST 0) to the stack.

execution_of_REF.AS_NON_NULL
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value ref from the stack.
3. If ref is of the case REF.NULL, then:
  a. Trap.
4. Push the value ref to the stack.

execution_of_REF.EQ
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value ref_2 from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value ref_1 from the stack.
5. If (ref_1 is of the case REF.NULL and ref_2 is of the case REF.NULL), then:
  a. Push the value (I32.CONST 1) to the stack.
6. Else if (ref_1 is ref_2), then:
  a. Push the value (I32.CONST 1) to the stack.
7. Else:
  a. Push the value (I32.CONST 0) to the stack.

execution_of_I31.GET sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value instr_u0 from the stack.
3. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
4. If instr_u0 is of the case REF.I31_NUM, then:
  a. Let (REF.I31_NUM i) be instr_u0.
  b. Push the value (I32.CONST $ext(31, 32, sx, i)) to the stack.

execution_of_ARRAY.NEW x
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value val from the stack.
5. Push the values val^n to the stack.
6. Execute the instruction (ARRAY.NEW_FIXED x n).

execution_of_EXTERN.CONVERT_ANY
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value instr_u0 from the stack.
3. If instr_u0 is of the case REF.NULL, then:
  a. Push the value (REF.NULL EXTERN) to the stack.
4. If the type of instr_u0 is addrref, then:
  a. Let addrref be instr_u0.
  b. Push the value (REF.EXTERN addrref) to the stack.

execution_of_ANY.CONVERT_EXTERN
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value instr_u0 from the stack.
3. If instr_u0 is of the case REF.NULL, then:
  a. Push the value (REF.NULL ANY) to the stack.
4. If instr_u0 is of the case REF.EXTERN, then:
  a. Let (REF.EXTERN addrref) be instr_u0.
  b. Push the value addrref to the stack.

execution_of_VVUNOP V128 vvunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $vvunop(V128, vvunop, c_1).
4. Push the value (V128.CONST c) to the stack.

execution_of_VVBINOP V128 vvbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $vvbinop(V128, vvbinop, c_1, c_2).
6. Push the value (V128.CONST c) to the stack.

execution_of_VVTERNOP V128 vvternop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_3) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_2) from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop the value (V128.CONST c_1) from the stack.
7. Let c be $vvternop(V128, vvternop, c_1, c_2, c_3).
8. Push the value (V128.CONST c) to the stack.

execution_of_VVTESTOP V128 ANY_TRUE
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $ine($vsize(V128), c_1, 0).
4. Push the value (I32.CONST c) to the stack.

execution_of_VUNOP sh vunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $vunop(sh, vunop, c_1).
4. Push the value (V128.CONST c) to the stack.

execution_of_VBINOP sh vbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. If (|$vbinop(sh, vbinop, c_1, c_2)| is 1), then:
  a. Let [c] be $vbinop(sh, vbinop, c_1, c_2).
  b. Push the value (V128.CONST c) to the stack.
6. If ($vbinop(sh, vbinop, c_1, c_2) is []), then:
  a. Trap.

execution_of_VTESTOP (Jnn X M) ALL_TRUE
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c) from the stack.
3. Let ci_1* be $lanes_((Jnn X M), c).
4. If (ci_1 is not 0)*, then:
  a. Push the value (I32.CONST 1) to the stack.
5. Else:
  a. Push the value (I32.CONST 0) to the stack.

execution_of_VRELOP sh vrelop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $vrelop(sh, vrelop, c_1, c_2).
6. Push the value (V128.CONST c) to the stack.

execution_of_VSHIFTOP (Jnn X M) vshiftop
1. Assert: Due to validation, a value of value type I32 is on the top of the stack.
2. Pop the value (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c'* be $lanes_((Jnn X M), c_1).
6. Let c be $invlanes_((Jnn X M), $vshiftop((Jnn X M), vshiftop, c', n)*).
7. Push the value (V128.CONST c) to the stack.

execution_of_VBITMASK (Jnn X M)
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c) from the stack.
3. Let ci_1* be $lanes_((Jnn X M), c).
4. Let ci be $ibits_1^-1(32, $ilt($lsize(Jnn), S, ci_1, 0)*).
5. Push the value (I32.CONST ci) to the stack.

execution_of_VSWIZZLE (Pnn X M)
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c* be $lanes_((Pnn X M), c_1) ++ 0^(256 - M).
6. Let ci* be $lanes_((Pnn X M), c_2).
7. Assert: Due to validation, (ci*[k] < |c*|)^(k<M).
8. Assert: Due to validation, (k < |ci*|)^(k<M).
9. Let c' be $invlanes_((Pnn X M), c*[ci*[k]]^(k<M)).
10. Push the value (V128.CONST c') to the stack.

execution_of_VSHUFFLE (Pnn X M) i*
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Assert: Due to validation, (k < |i*|)^(k<M).
6. Let c'* be $lanes_((Pnn X M), c_1) ++ $lanes_((Pnn X M), c_2).
7. Assert: Due to validation, (i*[k] < |c'*|)^(k<M).
8. Let c be $invlanes_((Pnn X M), c'*[i*[k]]^(k<M)).
9. Push the value (V128.CONST c) to the stack.

execution_of_VSPLAT (Lnn X M)
1. Assert: Due to validation, a value of value type $lunpack(Lnn) is on the top of the stack.
2. Pop the value (nt_0.CONST c_1) from the stack.
3. Let c be $invlanes_((Lnn X M), $lpacknum(Lnn, c_1)^M).
4. Push the value (V128.CONST c) to the stack.

execution_of_VEXTRACT_LANE (lanet_u0 X M) sx_u1? i
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. If (sx_u1? is not defined and the type of lanet_u0 is numtype), then:
  a. Let nt be lanet_u0.
  b. If (i < |$lanes_((nt X M), c_1)|), then:
    1) Let c_2 be $lanes_((nt X M), c_1)[i].
    2) Push the value (nt.CONST c_2) to the stack.
4. If the type of lanet_u0 is packtype, then:
  a. Let pt be lanet_u0.
  b. If sx_u1? is defined, then:
    1) Let ?(sx) be sx_u1?.
    2) If (i < |$lanes_((pt X M), c_1)|), then:
      a) Let c_2 be $ext($psize(pt), 32, sx, $lanes_((pt X M), c_1)[i]).
      b) Push the value (I32.CONST c_2) to the stack.

execution_of_VREPLACE_LANE (Lnn X M) i
1. Assert: Due to validation, a value of value type $lunpack(Lnn) is on the top of the stack.
2. Pop the value (nt_0.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $invlanes_((Lnn X M), $lanes_((Lnn X M), c_1) with [i] replaced by $lpacknum(Lnn, c_2)).
6. Push the value (V128.CONST c) to the stack.

execution_of_VEXTUNOP sh_2 sh_1 vextunop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. Let c be $vextunop(sh_1, sh_2, vextunop, c_1).
4. Push the value (V128.CONST c) to the stack.

execution_of_VEXTBINOP sh_2 sh_1 vextbinop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let c be $vextbinop(sh_1, sh_2, vextbinop, c_1, c_2).
6. Push the value (V128.CONST c) to the stack.

execution_of_VNARROW (Jnn_2 X M_2) (Jnn_1 X M_1) sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_2) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value (V128.CONST c_1) from the stack.
5. Let ci_1* be $lanes_((Jnn_1 X M_1), c_1).
6. Let ci_2* be $lanes_((Jnn_1 X M_1), c_2).
7. Let cj_1* be $narrow($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_1)*.
8. Let cj_2* be $narrow($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_2)*.
9. Let c be $invlanes_((Jnn_2 X M_2), cj_1* ++ cj_2*).
10. Push the value (V128.CONST c) to the stack.

execution_of_VCVTOP (lanet_u5 X n_u0) (lanet_u6 X n_u1) vcvtop half__u4? sx? zero__u13?
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value (V128.CONST c_1) from the stack.
3. If (half__u4? is not defined and zero__u13? is not defined), then:
  a. Let Lnn_1 be lanet_u6.
  b. Let Lnn_2 be lanet_u5.
  c. Let M be n_u1.
  d. If (n_u0 is M), then:
    1) Let c'* be $lanes_((Lnn_1 X M), c_1).
    2) Let c be $invlanes_((Lnn_2 X M), $vcvtop((Lnn_1 X M), (Lnn_2 X M), vcvtop, sx?, c')*).
    3) Push the value (V128.CONST c) to the stack.
4. If zero__u13? is not defined, then:
  a. Let Lnn_1 be lanet_u6.
  b. Let Lnn_2 be lanet_u5.
  c. Let M_1 be n_u1.
  d. Let M_2 be n_u0.
  e. If half__u4? is defined, then:
    1) Let ?(half) be half__u4?.
    2) Let ci* be $lanes_((Lnn_1 X M_1), c_1)[$half((Lnn_1 X M_1), (Lnn_2 X M_2), half, 0, M_2) : M_2].
    3) Let c be $invlanes_((Lnn_2 X M_2), $vcvtop((Lnn_1 X M_1), (Lnn_2 X M_2), vcvtop, sx?, ci)*).
    4) Push the value (V128.CONST c) to the stack.
5. If half__u4? is not defined, then:
  a. Let M_1 be n_u1.
  b. Let M_2 be n_u0.
  c. If the type of lanet_u6 is numtype, then:
    1) Let nt_1 be lanet_u6.
    2) If the type of lanet_u5 is numtype, then:
      a) Let nt_2 be lanet_u5.
      b) If zero__u13? is defined, then:
        1. Let ci* be $lanes_((nt_1 X M_1), c_1).
        2. Let c be $invlanes_((nt_2 X M_2), $vcvtop((nt_1 X M_1), (nt_2 X M_2), vcvtop, sx?, ci)* ++ $zero(nt_2)^M_1).
        3. Push the value (V128.CONST c) to the stack.

execution_of_LOCAL.TEE x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value val from the stack.
3. Push the value val to the stack.
4. Push the value val to the stack.
5. Execute the instruction (LOCAL.SET x).

execution_of_BLOCK bt instr*
1. Let z be the current state.
2. Let (t_1^m -> t_2^n) be $blocktype_(z, bt).
3. Assert: Due to validation, there are at least m values on the top of the stack.
4. Pop the values val^m from the stack.
5. Let L be the label_n{[]}.
6. Enter val^m ++ instr* with label L.

execution_of_LOOP bt instr*
1. Let z be the current state.
2. Let (t_1^m -> t_2^n) be $blocktype_(z, bt).
3. Assert: Due to validation, there are at least m values on the top of the stack.
4. Pop the values val^m from the stack.
5. Let L be the label_m{[(LOOP bt instr*)]}.
6. Enter val^m ++ instr* with label L.

execution_of_BR_ON_CAST l rt_1 rt_2
1. Let f be the current frame.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value ref from the stack.
4. Let rt be $ref_type_of(ref).
5. If rt does not match $inst_reftype(f.MODULE, rt_2), then:
  a. Push the value ref to the stack.
6. Else:
  a. Push the value ref to the stack.
  b. Execute the instruction (BR l).

execution_of_BR_ON_CAST_FAIL l rt_1 rt_2
1. Let f be the current frame.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value ref from the stack.
4. Let rt be $ref_type_of(ref).
5. If rt matches $inst_reftype(f.MODULE, rt_2), then:
  a. Push the value ref to the stack.
6. Else:
  a. Push the value ref to the stack.
  b. Execute the instruction (BR l).

execution_of_CALL x
1. Let z be the current state.
2. Assert: Due to validation, (x < |$moduleinst(z).FUNCS|).
3. Let a be $moduleinst(z).FUNCS[x].
4. Assert: Due to validation, (a < |$funcinst(z)|).
5. Push the value (REF.FUNC_ADDR a) to the stack.
6. Execute the instruction (CALL_REF $funcinst(z)[a].TYPE).

execution_of_CALL_REF yy
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value instr_u0 from the stack.
4. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
5. If instr_u0 is of the case REF.FUNC_ADDR, then:
  a. Let (REF.FUNC_ADDR a) be instr_u0.
  b. If (a < |$funcinst(z)|), then:
    1) Let fi be $funcinst(z)[a].
    2) Assert: Due to validation, fi.CODE is of the case FUNC.
    3) Let (FUNC x y_0 instr*) be fi.CODE.
    4) Assert: Due to validation, y_0 is of the case LOCAL.
    5) Let (LOCAL t)* be y_0.
    6) Assert: Due to validation, $expanddt(fi.TYPE) is of the case FUNC.
    7) Let (FUNC y_0) be $expanddt(fi.TYPE).
    8) Let (t_1^n -> t_2^m) be y_0.
    9) Assert: Due to validation, there are at least n values on the top of the stack.
    10) Pop the values val^n from the stack.
    11) Let f be { LOCALS: ?(val)^n ++ $default_(t)*; MODULE: fi.MODULE; }.
    12) Let F be the activation of f with arity m.
    13) Push F to the stack.
    14) Let L be the label_m{[]}.
    15) Enter instr* with label L.

execution_of_RETURN_CALL x
1. Let z be the current state.
2. Assert: Due to validation, (x < |$moduleinst(z).FUNCS|).
3. Let a be $moduleinst(z).FUNCS[x].
4. Assert: Due to validation, (a < |$funcinst(z)|).
5. Push the value (REF.FUNC_ADDR a) to the stack.
6. Execute the instruction (RETURN_CALL_REF $funcinst(z)[a].TYPE).

execution_of_RETURN_CALL_REF yy
1. Let z be the current state.
2. Pop all values val* from the top of the stack.
3. If a label is now on the top of the stack, then:
  a. Pop the current label from the stack.
  b. Push the values val* to the stack.
  c. Execute the instruction (RETURN_CALL_REF yy).
4. Else if a frame is now on the top of the stack, then:
  a. Pop the current frame from the stack.
  b. Let instr_u1* ++ instr_u0 be val*.
  c. If instr_u0 is of the case REF.FUNC_ADDR, then:
    1) Let (REF.FUNC_ADDR a) be instr_u0.
    2) If (a < |$funcinst(z)|), then:
      a) Assert: Due to validation, $expanddt($funcinst(z)[a].TYPE) is of the case FUNC.
      b) Let (FUNC y_0) be $expanddt($funcinst(z)[a].TYPE).
      c) Let (t_1^n -> t_2^m) be y_0.
      d) If (|instr_u1*| ≥ n), then:
        1. Let val'* ++ val^n be instr_u1*.
        2. Push the values val^n to the stack.
        3. Push the value (REF.FUNC_ADDR a) to the stack.
        4. Execute the instruction (CALL_REF yy).
  d. If (instr_u0 is of the case REF.NULL and the type of instr_u1 is val*), then:
    1) Trap.

execution_of_REF.NULL $idx(x)
1. Let z be the current state.
2. Push the value (REF.NULL $type(z, x)) to the stack.

execution_of_REF.FUNC x
1. Let z be the current state.
2. Assert: Due to validation, (x < |$moduleinst(z).FUNCS|).
3. Push the value (REF.FUNC_ADDR $moduleinst(z).FUNCS[x]) to the stack.

execution_of_REF.TEST rt
1. Let f be the current frame.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value ref from the stack.
4. Let rt' be $ref_type_of(ref).
5. If rt' matches $inst_reftype(f.MODULE, rt), then:
  a. Push the value (I32.CONST 1) to the stack.
6. Else:
  a. Push the value (I32.CONST 0) to the stack.

execution_of_REF.CAST rt
1. Let f be the current frame.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value ref from the stack.
4. Let rt' be $ref_type_of(ref).
5. If rt' does not match $inst_reftype(f.MODULE, rt), then:
  a. Trap.
6. Push the value ref to the stack.

execution_of_STRUCT.NEW_DEFAULT x
1. Let z be the current state.
2. Assert: Due to validation, $expanddt($type(z, x)) is of the case STRUCT.
3. Let (STRUCT y_0) be $expanddt($type(z, x)).
4. Let (mut, zt)* be y_0.
5. Assert: Due to validation, (|mut*| is |zt*|).
6. Assert: Due to validation, $default_($unpack(zt)) is defined*.
7. Let ?(val)* be $default_($unpack(zt))*.
8. Assert: Due to validation, (|val*| is |zt*|).
9. Push the values val* to the stack.
10. Execute the instruction (STRUCT.NEW x).

execution_of_STRUCT.GET sx? x i
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value instr_u0 from the stack.
4. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
5. Assert: Due to validation, $expanddt($type(z, x)) is of the case STRUCT.
6. Let (STRUCT y_0) be $expanddt($type(z, x)).
7. Let (mut, zt)* be y_0.
8. If instr_u0 is of the case REF.STRUCT_ADDR, then:
  a. Let (REF.STRUCT_ADDR a) be instr_u0.
  b. If ((i < |$structinst(z)[a].FIELDS|) and ((a < |$structinst(z)|) and ((|mut*| is |zt*|) and (i < |zt*|)))), then:
    1) Push the value $unpackfield(zt*[i], sx?, $structinst(z)[a].FIELDS[i]) to the stack.

execution_of_ARRAY.NEW_DEFAULT x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, $expanddt($type(z, x)) is of the case ARRAY.
5. Let (ARRAY y_0) be $expanddt($type(z, x)).
6. Let (mut, zt) be y_0.
7. Assert: Due to validation, $default_($unpack(zt)) is defined.
8. Let ?(val) be $default_($unpack(zt)).
9. Push the values val^n to the stack.
10. Execute the instruction (ARRAY.NEW_FIXED x n).

execution_of_ARRAY.NEW_ELEM x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If ((i + n) > |$elem(z, y).REFS|), then:
  a. Trap.
7. Let ref^n be $elem(z, y).REFS[i : n].
8. Push the values ref^n to the stack.
9. Execute the instruction (ARRAY.NEW_FIXED x n).

execution_of_ARRAY.NEW_DATA x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, $expanddt($type(z, x)) is of the case ARRAY.
7. Let (ARRAY y_0) be $expanddt($type(z, x)).
8. Let (mut, zt) be y_0.
9. If ((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|), then:
  a. Trap.
10. Let c^n be $zbytes_1^-1(zt, $concat_^-1($data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)])).
11. Push the values $const($cunpack(zt), $cunpacknum(zt, c))^n to the stack.
12. Execute the instruction (ARRAY.NEW_FIXED x n).

execution_of_ARRAY.GET sx? x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value instr_u0 from the stack.
6. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
7. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If ((a < |$arrayinst(z)|) and (i ≥ |$arrayinst(z)[a].FIELDS|)), then:
    1) Trap.
8. Assert: Due to validation, $expanddt($type(z, x)) is of the case ARRAY.
9. Let (ARRAY y_0) be $expanddt($type(z, x)).
10. Let (mut, zt) be y_0.
11. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If ((i < |$arrayinst(z)[a].FIELDS|) and (a < |$arrayinst(z)|)), then:
    1) Push the value $unpackfield(zt, sx?, $arrayinst(z)[a].FIELDS[i]) to the stack.

execution_of_ARRAY.LEN
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value instr_u0 from the stack.
4. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
5. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If (a < |$arrayinst(z)|), then:
    1) Push the value (I32.CONST |$arrayinst(z)[a].FIELDS|) to the stack.

execution_of_ARRAY.FILL x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value val from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. Assert: Due to validation, a value is on the top of the stack.
9. Pop the value instr_u0 from the stack.
10. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
11. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If ((a < |$arrayinst(z)|) and ((i + n) > |$arrayinst(z)[a].FIELDS|)), then:
    1) Trap.
  c. If (n is 0), then:
    1) Do nothing.
  d. Else:
    1) Let (REF.ARRAY_ADDR a) be instr_u0.
    2) Push the value (REF.ARRAY_ADDR a) to the stack.
    3) Push the value (I32.CONST i) to the stack.
    4) Push the value val to the stack.
    5) Execute the instruction (ARRAY.SET x).
    6) Push the value (REF.ARRAY_ADDR a) to the stack.
    7) Push the value (I32.CONST (i + 1)) to the stack.
    8) Push the value val to the stack.
    9) Push the value (I32.CONST (n - 1)) to the stack.
    10) Execute the instruction (ARRAY.FILL x).

execution_of_ARRAY.COPY x_1 x_2
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i_2) from the stack.
6. Assert: Due to validation, a value is on the top of the stack.
7. Pop the value instr_u1 from the stack.
8. Assert: Due to validation, a value of value type I32 is on the top of the stack.
9. Pop the value (I32.CONST i_1) from the stack.
10. Assert: Due to validation, a value is on the top of the stack.
11. Pop the value instr_u0 from the stack.
12. If (instr_u0 is of the case REF.NULL and the type of instr_u1 is ref), then:
  a. Trap.
13. If (instr_u1 is of the case REF.NULL and the type of instr_u0 is ref), then:
  a. Trap.
14. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a_1) be instr_u0.
  b. If instr_u1 is of the case REF.ARRAY_ADDR, then:
    1) If ((a_1 < |$arrayinst(z)|) and ((i_1 + n) > |$arrayinst(z)[a_1].FIELDS|)), then:
      a) Trap.
    2) Let (REF.ARRAY_ADDR a_2) be instr_u1.
    3) If ((a_2 < |$arrayinst(z)|) and ((i_2 + n) > |$arrayinst(z)[a_2].FIELDS|)), then:
      a) Trap.
  c. If (n is 0), then:
    1) If instr_u1 is of the case REF.ARRAY_ADDR, then:
      a) Do nothing.
  d. Else if (i_1 > i_2), then:
    1) Assert: Due to validation, $expanddt($type(z, x_2)) is of the case ARRAY.
    2) Let (ARRAY y_0) be $expanddt($type(z, x_2)).
    3) Let (mut, zt_2) be y_0.
    4) Let (REF.ARRAY_ADDR a_1) be instr_u0.
    5) If instr_u1 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a_2) be instr_u1.
      b) Let sx? be $sx(zt_2).
      c) Push the value (REF.ARRAY_ADDR a_1) to the stack.
      d) Push the value (I32.CONST ((i_1 + n) - 1)) to the stack.
      e) Push the value (REF.ARRAY_ADDR a_2) to the stack.
      f) Push the value (I32.CONST ((i_2 + n) - 1)) to the stack.
      g) Execute the instruction (ARRAY.GET sx? x_2).
      h) Execute the instruction (ARRAY.SET x_1).
      i) Push the value (REF.ARRAY_ADDR a_1) to the stack.
      j) Push the value (I32.CONST i_1) to the stack.
      k) Push the value (REF.ARRAY_ADDR a_2) to the stack.
      l) Push the value (I32.CONST i_2) to the stack.
      m) Push the value (I32.CONST (n - 1)) to the stack.
      n) Execute the instruction (ARRAY.COPY x_1 x_2).
  e. Else:
    1) Assert: Due to validation, $expanddt($type(z, x_2)) is of the case ARRAY.
    2) Let (ARRAY y_0) be $expanddt($type(z, x_2)).
    3) Let (mut, zt_2) be y_0.
    4) Let (REF.ARRAY_ADDR a_1) be instr_u0.
    5) If instr_u1 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a_2) be instr_u1.
      b) Let sx? be $sx(zt_2).
      c) Push the value (REF.ARRAY_ADDR a_1) to the stack.
      d) Push the value (I32.CONST i_1) to the stack.
      e) Push the value (REF.ARRAY_ADDR a_2) to the stack.
      f) Push the value (I32.CONST i_2) to the stack.
      g) Execute the instruction (ARRAY.GET sx? x_2).
      h) Execute the instruction (ARRAY.SET x_1).
      i) Push the value (REF.ARRAY_ADDR a_1) to the stack.
      j) Push the value (I32.CONST (i_1 + 1)) to the stack.
      k) Push the value (REF.ARRAY_ADDR a_2) to the stack.
      l) Push the value (I32.CONST (i_2 + 1)) to the stack.
      m) Push the value (I32.CONST (n - 1)) to the stack.
      n) Execute the instruction (ARRAY.COPY x_1 x_2).

execution_of_ARRAY.INIT_ELEM x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST j) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. Assert: Due to validation, a value is on the top of the stack.
9. Pop the value instr_u0 from the stack.
10. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
11. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If ((a < |$arrayinst(z)|) and ((i + n) > |$arrayinst(z)[a].FIELDS|)), then:
    1) Trap.
12. If ((j + n) > |$elem(z, y).REFS|), then:
  a. If instr_u0 is of the case REF.ARRAY_ADDR, then:
    1) Trap.
  b. If ((n is 0) and (j < |$elem(z, y).REFS|)), then:
    1) Let ref be $elem(z, y).REFS[j].
    2) If instr_u0 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a) be instr_u0.
      b) Push the value (REF.ARRAY_ADDR a) to the stack.
      c) Push the value (I32.CONST i) to the stack.
      d) Push the value ref to the stack.
      e) Execute the instruction (ARRAY.SET x).
      f) Push the value (REF.ARRAY_ADDR a) to the stack.
      g) Push the value (I32.CONST (i + 1)) to the stack.
      h) Push the value (I32.CONST (j + 1)) to the stack.
      i) Push the value (I32.CONST (n - 1)) to the stack.
      j) Execute the instruction (ARRAY.INIT_ELEM x y).
13. Else if (n is 0), then:
  a. If instr_u0 is of the case REF.ARRAY_ADDR, then:
    1) Do nothing.
14. Else:
  a. If (j < |$elem(z, y).REFS|), then:
    1) Let ref be $elem(z, y).REFS[j].
    2) If instr_u0 is of the case REF.ARRAY_ADDR, then:
      a) Let (REF.ARRAY_ADDR a) be instr_u0.
      b) Push the value (REF.ARRAY_ADDR a) to the stack.
      c) Push the value (I32.CONST i) to the stack.
      d) Push the value ref to the stack.
      e) Execute the instruction (ARRAY.SET x).
      f) Push the value (REF.ARRAY_ADDR a) to the stack.
      g) Push the value (I32.CONST (i + 1)) to the stack.
      h) Push the value (I32.CONST (j + 1)) to the stack.
      i) Push the value (I32.CONST (n - 1)) to the stack.
      j) Execute the instruction (ARRAY.INIT_ELEM x y).

execution_of_ARRAY.INIT_DATA x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST j) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. Assert: Due to validation, a value is on the top of the stack.
9. Pop the value instr_u0 from the stack.
10. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
11. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If ((a < |$arrayinst(z)|) and ((i + n) > |$arrayinst(z)[a].FIELDS|)), then:
    1) Trap.
12. If $expanddt($type(z, x)) is not of the case ARRAY, then:
  a. If ((n is 0) and instr_u0 is of the case REF.ARRAY_ADDR), then:
    1) Do nothing.
13. Else:
  a. Let (ARRAY y_0) be $expanddt($type(z, x)).
  b. Let (mut, zt) be y_0.
  c. If instr_u0 is of the case REF.ARRAY_ADDR, then:
    1) If ((j + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|), then:
      a) Trap.
    2) If (n is 0), then:
      a) Do nothing.
    3) Else:
      a) Let (ARRAY y_0) be $expanddt($type(z, x)).
      b) Let (mut, zt) be y_0.
      c) Let (REF.ARRAY_ADDR a) be instr_u0.
      d) Let c be $zbytes_1^-1(zt, $data(z, y).BYTES[j : ($zsize(zt) / 8)]).
      e) Push the value (REF.ARRAY_ADDR a) to the stack.
      f) Push the value (I32.CONST i) to the stack.
      g) Push the value $const($cunpack(zt), $cunpacknum(zt, c)) to the stack.
      h) Execute the instruction (ARRAY.SET x).
      i) Push the value (REF.ARRAY_ADDR a) to the stack.
      j) Push the value (I32.CONST (i + 1)) to the stack.
      k) Push the value (I32.CONST (j + ($zsize(zt) / 8))) to the stack.
      l) Push the value (I32.CONST (n - 1)) to the stack.
      m) Execute the instruction (ARRAY.INIT_DATA x y).

execution_of_LOCAL.GET x
1. Let z be the current state.
2. Assert: Due to validation, $local(z, x) is defined.
3. Let ?(val) be $local(z, x).
4. Push the value val to the stack.

execution_of_GLOBAL.GET x
1. Let z be the current state.
2. Let val be $global(z, x).VALUE.
3. Push the value val to the stack.

execution_of_TABLE.GET x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If (i ≥ |$table(z, x).REFS|), then:
  a. Trap.
5. Push the value $table(z, x).REFS[i] to the stack.

execution_of_TABLE.SIZE x
1. Let z be the current state.
2. Let n be |$table(z, x).REFS|.
3. Push the value (I32.CONST n) to the stack.

execution_of_TABLE.FILL x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value val from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. If ((i + n) > |$table(z, x).REFS|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else:
  a. Push the value (I32.CONST i) to the stack.
  b. Push the value val to the stack.
  c. Execute the instruction (TABLE.SET x).
  d. Push the value (I32.CONST (i + 1)) to the stack.
  e. Push the value val to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (TABLE.FILL x).

execution_of_TABLE.COPY x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$table(z, y).REFS|), then:
  a. Trap.
9. If ((j + n) > |$table(z, x).REFS|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else:
  a. If (j ≤ i), then:
    1) Push the value (I32.CONST j) to the stack.
    2) Push the value (I32.CONST i) to the stack.
    3) Execute the instruction (TABLE.GET y).
    4) Execute the instruction (TABLE.SET x).
    5) Push the value (I32.CONST (j + 1)) to the stack.
    6) Push the value (I32.CONST (i + 1)) to the stack.
  b. Else:
    1) Push the value (I32.CONST ((j + n) - 1)) to the stack.
    2) Push the value (I32.CONST ((i + n) - 1)) to the stack.
    3) Execute the instruction (TABLE.GET y).
    4) Execute the instruction (TABLE.SET x).
    5) Push the value (I32.CONST j) to the stack.
    6) Push the value (I32.CONST i) to the stack.
  c. Push the value (I32.CONST (n - 1)) to the stack.
  d. Execute the instruction (TABLE.COPY x y).

execution_of_TABLE.INIT x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$elem(z, y).REFS|), then:
  a. Trap.
9. If ((j + n) > |$table(z, x).REFS|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else if (i < |$elem(z, y).REFS|), then:
  a. Push the value (I32.CONST j) to the stack.
  b. Push the value $elem(z, y).REFS[i] to the stack.
  c. Execute the instruction (TABLE.SET x).
  d. Push the value (I32.CONST (j + 1)) to the stack.
  e. Push the value (I32.CONST (i + 1)) to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (TABLE.INIT x y).

execution_of_LOAD numty_u0 loado_u2? x ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If loado_u2? is not defined, then:
  a. Let nt be numty_u0.
  b. If (((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, x).BYTES|), then:
    1) Trap.
  c. Let c be $nbytes_1^-1(nt, $mem(z, x).BYTES[(i + ao.OFFSET) : ($size(nt) / 8)]).
  d. Push the value (nt.CONST c) to the stack.
5. If the type of numty_u0 is Inn, then:
  a. If loado_u2? is defined, then:
    1) Let ?(y_0) be loado_u2?.
    2) Let (n, sx) be y_0.
    3) If (((i + ao.OFFSET) + (n / 8)) > |$mem(z, x).BYTES|), then:
      a) Trap.
  b. Let Inn be numty_u0.
  c. If loado_u2? is defined, then:
    1) Let ?(y_0) be loado_u2?.
    2) Let (n, sx) be y_0.
    3) Let c be $ibytes_1^-1(n, $mem(z, x).BYTES[(i + ao.OFFSET) : (n / 8)]).
    4) Push the value (Inn.CONST $ext(n, $size(Inn), sx, c)) to the stack.

execution_of_VLOAD V128 vload_u0? x ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST i) from the stack.
4. If ((((i + ao.OFFSET) + ($vsize(V128) / 8)) > |$mem(z, x).BYTES|) and vload_u0? is not defined), then:
  a. Trap.
5. If vload_u0? is not defined, then:
  a. Let c be $vbytes_1^-1(V128, $mem(z, x).BYTES[(i + ao.OFFSET) : ($vsize(V128) / 8)]).
  b. Push the value (V128.CONST c) to the stack.
6. Else:
  a. Let ?(y_0) be vload_u0?.
  b. If y_0 is of the case SHAPE, then:
    1) Let (SHAPE M K sx) be y_0.
    2) If (((i + ao.OFFSET) + ((M · K) / 8)) > |$mem(z, x).BYTES|), then:
      a) Trap.
    3) If the type of $lsizenn^-1((M · 2)) is Jnn, then:
      a) Let Jnn be $lsizenn^-1((M · 2)).
      b) Let j^K be $ibytes_1^-1(M, $mem(z, x).BYTES[((i + ao.OFFSET) + ((k · M) / 8)) : (M / 8)])^(k<K).
      c) Let c be $invlanes_((Jnn X K), $ext(M, $lsizenn(Jnn), sx, j)^K).
      d) Push the value (V128.CONST c) to the stack.
  c. If y_0 is of the case SPLAT, then:
    1) Let (SPLAT N) be y_0.
    2) If (((i + ao.OFFSET) + (N / 8)) > |$mem(z, x).BYTES|), then:
      a) Trap.
    3) Let M be (128 / N).
    4) If the type of $lsize^-1(N) is Jnn, then:
      a) Let Jnn be $lsize^-1(N).
      b) Let j be $ibytes_1^-1(N, $mem(z, x).BYTES[(i + ao.OFFSET) : (N / 8)]).
      c) Let c be $invlanes_((Jnn X M), j^M).
      d) Push the value (V128.CONST c) to the stack.
  d. If y_0 is of the case ZERO, then:
    1) Let (ZERO N) be y_0.
    2) If (((i + ao.OFFSET) + (N / 8)) > |$mem(z, x).BYTES|), then:
      a) Trap.
    3) Let j be $ibytes_1^-1(N, $mem(z, x).BYTES[(i + ao.OFFSET) : (N / 8)]).
    4) Let c be $ext(N, 128, U, j).
    5) Push the value (V128.CONST c) to the stack.

execution_of_VLOAD_LANE V128 N x ao j
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value (V128.CONST c_1) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (((i + ao.OFFSET) + (N / 8)) > |$mem(z, x).BYTES|), then:
  a. Trap.
7. Let M be ($vsize(V128) / N).
8. If the type of $lsize^-1(N) is Jnn, then:
  a. Let Jnn be $lsize^-1(N).
  b. Let k be $ibytes_1^-1(N, $mem(z, x).BYTES[(i + ao.OFFSET) : (N / 8)]).
  c. Let c be $invlanes_((Jnn X M), $lanes_((Jnn X M), c_1) with [j] replaced by k).
  d. Push the value (V128.CONST c) to the stack.

execution_of_MEMORY.SIZE x
1. Let z be the current state.
2. Let (n · (64 · $Ki())) be |$mem(z, x).BYTES|.
3. Push the value (I32.CONST n) to the stack.

execution_of_MEMORY.FILL x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value val from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i) from the stack.
8. If ((i + n) > |$mem(z, x).BYTES|), then:
  a. Trap.
9. If (n is 0), then:
  a. Do nothing.
10. Else:
  a. Push the value (I32.CONST i) to the stack.
  b. Push the value val to the stack.
  c. Execute the instruction (STORE I32 ?(8) x $memarg0()).
  d. Push the value (I32.CONST (i + 1)) to the stack.
  e. Push the value val to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (MEMORY.FILL x).

execution_of_MEMORY.COPY x_1 x_2
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i_2) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST i_1) from the stack.
8. If ((i_1 + n) > |$mem(z, x_1).BYTES|), then:
  a. Trap.
9. If ((i_2 + n) > |$mem(z, x_2).BYTES|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else:
  a. If (i_1 ≤ i_2), then:
    1) Push the value (I32.CONST i_1) to the stack.
    2) Push the value (I32.CONST i_2) to the stack.
    3) Execute the instruction (LOAD I32 ?((8, U)) x_2 $memarg0()).
    4) Execute the instruction (STORE I32 ?(8) x_1 $memarg0()).
    5) Push the value (I32.CONST (i_1 + 1)) to the stack.
    6) Push the value (I32.CONST (i_2 + 1)) to the stack.
  b. Else:
    1) Push the value (I32.CONST ((i_1 + n) - 1)) to the stack.
    2) Push the value (I32.CONST ((i_2 + n) - 1)) to the stack.
    3) Execute the instruction (LOAD I32 ?((8, U)) x_2 $memarg0()).
    4) Execute the instruction (STORE I32 ?(8) x_1 $memarg0()).
    5) Push the value (I32.CONST i_1) to the stack.
    6) Push the value (I32.CONST i_2) to the stack.
  c. Push the value (I32.CONST (n - 1)) to the stack.
  d. Execute the instruction (MEMORY.COPY x_1 x_2).

execution_of_MEMORY.INIT x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value of value type I32 is on the top of the stack.
7. Pop the value (I32.CONST j) from the stack.
8. If ((i + n) > |$data(z, y).BYTES|), then:
  a. Trap.
9. If ((j + n) > |$mem(z, x).BYTES|), then:
  a. Trap.
10. If (n is 0), then:
  a. Do nothing.
11. Else if (i < |$data(z, y).BYTES|), then:
  a. Push the value (I32.CONST j) to the stack.
  b. Push the value (I32.CONST $data(z, y).BYTES[i]) to the stack.
  c. Execute the instruction (STORE I32 ?(8) x $memarg0()).
  d. Push the value (I32.CONST (j + 1)) to the stack.
  e. Push the value (I32.CONST (i + 1)) to the stack.
  f. Push the value (I32.CONST (n - 1)) to the stack.
  g. Execute the instruction (MEMORY.INIT x y).

execution_of_CTXT
1. YetI: TODO: It is likely that the value stack of two rules are different.

execution_of_STRUCT.NEW x
1. Let z be the current state.
2. Let a be |$structinst(z)|.
3. Assert: Due to validation, $expanddt($type(z, x)) is of the case STRUCT.
4. Let (STRUCT y_0) be $expanddt($type(z, x)).
5. Let (mut, zt)^n be y_0.
6. Assert: Due to validation, there are at least n values on the top of the stack.
7. Pop the values val^n from the stack.
8. Let si be { TYPE: $type(z, x); FIELDS: $packfield(zt, val)^n; }.
9. Push the value (REF.STRUCT_ADDR a) to the stack.
10. Perform $ext_structinst(z, [si]).

execution_of_STRUCT.SET x i
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value instr_u0 from the stack.
6. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
7. Assert: Due to validation, $expanddt($type(z, x)) is of the case STRUCT.
8. Let (STRUCT y_0) be $expanddt($type(z, x)).
9. Let (mut, zt)* be y_0.
10. If instr_u0 is of the case REF.STRUCT_ADDR, then:
  a. Let (REF.STRUCT_ADDR a) be instr_u0.
  b. If ((|mut*| is |zt*|) and (i < |zt*|)), then:
    1) Perform $with_struct(z, a, i, $packfield(zt*[i], val)).

execution_of_ARRAY.NEW_FIXED x n
1. Let z be the current state.
2. Assert: Due to validation, there are at least n values on the top of the stack.
3. Pop the values val^n from the stack.
4. Let a be |$arrayinst(z)|.
5. Assert: Due to validation, $expanddt($type(z, x)) is of the case ARRAY.
6. Let (ARRAY y_0) be $expanddt($type(z, x)).
7. Let (mut, zt) be y_0.
8. Let ai be { TYPE: $type(z, x); FIELDS: $packfield(zt, val)^n; }.
9. Push the value (REF.ARRAY_ADDR a) to the stack.
10. Perform $ext_arrayinst(z, [ai]).

execution_of_ARRAY.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. Assert: Due to validation, a value is on the top of the stack.
7. Pop the value instr_u0 from the stack.
8. If instr_u0 is of the case REF.NULL, then:
  a. Trap.
9. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. If ((a < |$arrayinst(z)|) and (i ≥ |$arrayinst(z)[a].FIELDS|)), then:
    1) Trap.
10. Assert: Due to validation, $expanddt($type(z, x)) is of the case ARRAY.
11. Let (ARRAY y_0) be $expanddt($type(z, x)).
12. Let (mut, zt) be y_0.
13. If instr_u0 is of the case REF.ARRAY_ADDR, then:
  a. Let (REF.ARRAY_ADDR a) be instr_u0.
  b. Perform $with_array(z, a, i, $packfield(zt, val)).

execution_of_LOCAL.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Perform $with_local(z, x, val).

execution_of_GLOBAL.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value val from the stack.
4. Perform $with_global(z, x, val).

execution_of_TABLE.SET x
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value ref from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (i ≥ |$table(z, x).REFS|), then:
  a. Trap.
7. Perform $with_table(z, x, i, ref).

execution_of_TABLE.GROW x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value is on the top of the stack.
5. Pop the value ref from the stack.
6. Either:
  a. Let ti be $growtable($table(z, x), n, ref).
  b. Push the value (I32.CONST |$table(z, x).REFS|) to the stack.
  c. Perform $with_tableinst(z, x, ti).
7. Or:
  a. Push the value (I32.CONST $invsigned(32, (- 1))) to the stack.

execution_of_ELEM.DROP x
1. Let z be the current state.
2. Perform $with_elem(z, x, []).

execution_of_STORE nt sz_u1? x ao
1. Let z be the current state.
2. Assert: Due to validation, a value of value type numty_u0 is on the top of the stack.
3. Pop the value (numty_u0.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (numty_u0 is nt), then:
  a. If ((((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, x).BYTES|) and sz_u1? is not defined), then:
    1) Trap.
  b. If sz_u1? is not defined, then:
    1) Let b* be $nbytes(nt, c).
    2) Perform $with_mem(z, x, (i + ao.OFFSET), ($size(nt) / 8), b*).
7. If the type of numty_u0 is Inn, then:
  a. If sz_u1? is defined, then:
    1) Let ?(n) be sz_u1?.
    2) If (((i + ao.OFFSET) + (n / 8)) > |$mem(z, x).BYTES|), then:
      a) Trap.
  b. Let Inn be numty_u0.
  c. If sz_u1? is defined, then:
    1) Let ?(n) be sz_u1?.
    2) Let b* be $ibytes(n, $wrap($size(Inn), n, c)).
    3) Perform $with_mem(z, x, (i + ao.OFFSET), (n / 8), b*).

execution_of_VSTORE V128 x ao
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value (V128.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (((i + ao.OFFSET) + ($vsize(V128) / 8)) > |$mem(z, x).BYTES|), then:
  a. Trap.
7. Let b* be $vbytes(V128, c).
8. Perform $with_mem(z, x, (i + ao.OFFSET), ($vsize(V128) / 8), b*).

execution_of_VSTORE_LANE V128 N x ao j
1. Let z be the current state.
2. Assert: Due to validation, a value is on the top of the stack.
3. Pop the value (V128.CONST c) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If (((i + ao.OFFSET) + N) > |$mem(z, x).BYTES|), then:
  a. Trap.
7. Let M be (128 / N).
8. If the type of $lsize^-1(N) is Jnn, then:
  a. Let Jnn be $lsize^-1(N).
  b. If (j < |$lanes_((Jnn X M), c)|), then:
    1) Let b* be $ibytes(N, $lanes_((Jnn X M), c)[j]).
    2) Perform $with_mem(z, x, (i + ao.OFFSET), (N / 8), b*).

execution_of_MEMORY.GROW x
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Either:
  a. Let mi be $growmem($mem(z, x), n).
  b. Push the value (I32.CONST (|$mem(z, x).BYTES| / (64 · $Ki()))) to the stack.
  c. Perform $with_meminst(z, x, mi).
5. Or:
  a. Push the value (I32.CONST $invsigned(32, (- 1))) to the stack.

execution_of_DATA.DROP x
1. Let z be the current state.
2. Perform $with_data(z, x, []).

eval_expr instr*
1. Execute the sequence (instr*).
2. Pop the value val from the stack.
3. Return [val].

group_bytes_by n byte*
1. Let n' be |byte*|.
2. If (n' ≥ n), then:
  a. Return [byte*[0 : n]] ++ $group_bytes_by(n, byte*[n : (n' - n)]).
3. Return [].

execution_of_ARRAY.NEW_DATA x y
1. Let z be the current state.
2. Assert: Due to validation, a value of value type I32 is on the top of the stack.
3. Pop the value (I32.CONST n) from the stack.
4. Assert: Due to validation, a value of value type I32 is on the top of the stack.
5. Pop the value (I32.CONST i) from the stack.
6. If $expanddt($type(z, x)) is of the case ARRAY, then:
  a. Let (ARRAY y_0) be $expanddt($type(z, x)).
  b. Let (mut, zt) be y_0.
  c. If ((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|), then:
    1) Trap.
  d. Let cnn be $cunpack(zt).
  e. Let b* be $data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)].
  f. Let gb* be $group_bytes_by(($zsize(zt) / 8), b*).
  g. Let c^n be $inverse_of_ibytes($zsize(zt), gb)*.
  h. Push the values (cnn.CONST c)^n to the stack.
  i. Execute the instruction (ARRAY.NEW_FIXED x n).
== Complete.
```
