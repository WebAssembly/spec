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
8-reduction.watsup:159.12-159.36: translate_rulepr: Yet `(`%;%`_config(z, (instr : instr <: admininstr)*{instr : instr}), `%;%`_config(z', (instr' : instr <: admininstr)*{instr' : instr}))`
8-reduction.watsup:163.12-163.44: translate_rulepr: Yet `(`%;%`_config(`%;%`_state(s, f'), (instr : instr <: admininstr)*{instr : instr}), `%;%`_config(`%;%`_state(s', f'), (instr' : instr <: admininstr)*{instr' : instr}))`
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
- Under the context prepend(C.LABELS, [t?]), instr* must be valid with type ([] -> t?).
- The instruction is valid with type ([] -> t?).

validation_of_LOOP t? instr*
- Under the context prepend(C.LABELS, [?()]), instr* must be valid with type ([] -> []).
- The instruction is valid with type ([] -> t?).

validation_of_IF t? instr_1* instr_2*
- Under the context prepend(C.LABELS, [t?]), instr_1* must be valid with type ([] -> t?).
- Under the context prepend(C.LABELS, [t?]), instr_2* must be valid with type ([] -> t?).
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
- ((sx? == ?())) if and only if ((n? == ?())).
- (2 ^ memarg.ALIGN) must be less than or equal to ($size(nt) / 8).
- If n != None,
  - (2 ^ memarg.ALIGN) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32] -> [nt]).

validation_of_STORE nt n? memarg
- |C.MEMS| must be greater than 0.
- (2 ^ memarg.ALIGN) must be less than or equal to ($size(nt) / 8).
- If n != None,
  - (2 ^ memarg.ALIGN) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32, nt] -> []).

Ki = {
 Return 1024
}

min n_u0 n_u1 = {
 If ((n_u0 == 0)) {
   Return 0
 }
 If ((n_u1 == 0)) {
   Return 0
 }
 Assert((n_u0 ≥ 1))
 Let i = (n_u0 - 1)
 Assert((n_u1 ≥ 1))
 Let j = (n_u1 - 1)
 Return $min(i, j)
}

sum n_u0* = {
 If ((n_u0* == [])) {
   Return 0
 }
 Let [n] ++ n'* = n_u0*
 Return (n + $sum(n'*))
}

concat_ X_u0* = {
 If ((X_u0* == [])) {
   Return []
 }
 Let [w*] ++ w'** = X_u0*
 Return w* ++ $concat_(w'**)
}

signif N_u0 = {
 If ((N_u0 == 32)) {
   Return 23
 }
 Assert((N_u0 == 64))
 Return 52
}

expon N_u0 = {
 If ((N_u0 == 32)) {
   Return 8
 }
 Assert((N_u0 == 64))
 Return 11
}

M N = {
 Return $signif(N)
}

E N = {
 Return $expon(N)
}

fzero N = {
 Return (POS (SUBNORM 0))
}

fone N = {
 Return (POS (NORM 1 0))
}

canon_ N = {
 Return (2 ^ ($signif(N) - 1))
}

utf8 char_u0* = {
 If ((|char_u0*| == 1)) {
   Let [ch] = char_u0*
   If ((ch < 128)) {
     Let b = ch
     Return [b]
   }
   If (((128 ≤ ch) && ((ch < 2048) && (ch ≥ (b_2 - 128))))) {
     Let ((2 ^ 6) · (b_1 - 192)) = (ch - (b_2 - 128))
     Return [b_1, b_2]
   }
   If (((((2048 ≤ ch) && (ch < 55296)) || ((57344 ≤ ch) && (ch < 65536))) && (ch ≥ (b_3 - 128)))) {
     Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · (b_2 - 128))) = (ch - (b_3 - 128))
     Return [b_1, b_2, b_3]
   }
   If (((65536 ≤ ch) && ((ch < 69632) && (ch ≥ (b_4 - 128))))) {
     Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · (b_2 - 128))) + ((2 ^ 6) · (b_3 - 128))) = (ch - (b_4 - 128))
     Return [b_1, b_2, b_3, b_4]
   }
 }
 Let ch* = char_u0*
 Return $concat_($utf8([ch])*)
}

size valty_u0 = {
 If ((valty_u0 == I32)) {
   Return 32
 }
 If ((valty_u0 == I64)) {
   Return 64
 }
 If ((valty_u0 == F32)) {
   Return 32
 }
 If ((valty_u0 == F64)) {
   Return 64
 }
}

funcsxt exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xt* = exter_u0*
 If (case(y_0) == FUNC) {
   Let (FUNC ft) = y_0
   Return [ft] ++ $funcsxt(xt*)
 }
 Let [externtype] ++ xt* = exter_u0*
 Return $funcsxt(xt*)
}

globalsxt exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xt* = exter_u0*
 If (case(y_0) == GLOBAL) {
   Let (GLOBAL gt) = y_0
   Return [gt] ++ $globalsxt(xt*)
 }
 Let [externtype] ++ xt* = exter_u0*
 Return $globalsxt(xt*)
}

tablesxt exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xt* = exter_u0*
 If (case(y_0) == TABLE) {
   Let (TABLE tt) = y_0
   Return [tt] ++ $tablesxt(xt*)
 }
 Let [externtype] ++ xt* = exter_u0*
 Return $tablesxt(xt*)
}

memsxt exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xt* = exter_u0*
 If (case(y_0) == MEM) {
   Let (MEM mt) = y_0
   Return [mt] ++ $memsxt(xt*)
 }
 Let [externtype] ++ xt* = exter_u0*
 Return $memsxt(xt*)
}

memarg0 = {
 Return { ALIGN: 0; OFFSET: 0; }
}

signed N i = {
 If ((0 ≤ (2 ^ (N - 1)))) {
   Return i
 }
 Assert(((2 ^ (N - 1)) ≤ i))
 Assert((i < (2 ^ N)))
 Return (i - (2 ^ N))
}

invsigned N ii = {
 Let j = $inverse_of_signed(N, ii)
 Return j
}

unop valty_u1 unop__u0 val__u3 = {
 If (((unop__u0 == CLZ) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN = val__u3
   Return [$iclz($size(Inn), iN)]
 }
 If (((unop__u0 == CTZ) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN = val__u3
   Return [$ictz($size(Inn), iN)]
 }
 If (((unop__u0 == POPCNT) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN = val__u3
   Return [$ipopcnt($size(Inn), iN)]
 }
 If (((unop__u0 == ABS) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN = val__u3
   Return [$fabs($size(Fnn), fN)]
 }
 If (((unop__u0 == NEG) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN = val__u3
   Return [$fneg($size(Fnn), fN)]
 }
 If (((unop__u0 == SQRT) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN = val__u3
   Return [$fsqrt($size(Fnn), fN)]
 }
 If (((unop__u0 == CEIL) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN = val__u3
   Return [$fceil($size(Fnn), fN)]
 }
 If (((unop__u0 == FLOOR) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN = val__u3
   Return [$ffloor($size(Fnn), fN)]
 }
 If (((unop__u0 == TRUNC) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN = val__u3
   Return [$ftrunc($size(Fnn), fN)]
 }
 Assert((unop__u0 == NEAREST))
 Assert(type(valty_u1) == Fnn)
 Let Fnn = valty_u1
 Let fN = val__u3
 Return [$fnearest($size(Fnn), fN)]
}

binop valty_u1 binop_u0 val__u3 val__u5 = {
 If (((binop_u0 == ADD) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$iadd($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == SUB) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$isub($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == MUL) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$imul($size(Inn), iN_1, iN_2)]
 }
 If (type(valty_u1) == Inn) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   If (case(binop_u0) == DIV) {
     Let (DIV sx) = binop_u0
     Return [$idiv($size(Inn), sx, iN_1, iN_2)]
   }
   If (case(binop_u0) == REM) {
     Let (REM sx) = binop_u0
     Return [$irem($size(Inn), sx, iN_1, iN_2)]
   }
 }
 If (((binop_u0 == AND) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$iand($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == OR) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$ior($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == XOR) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$ixor($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == SHL) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$ishl($size(Inn), iN_1, iN_2)]
 }
 If (type(valty_u1) == Inn) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   If (case(binop_u0) == SHR) {
     Let (SHR sx) = binop_u0
     Return [$ishr($size(Inn), sx, iN_1, iN_2)]
   }
 }
 If (((binop_u0 == ROTL) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$irotl($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == ROTR) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return [$irotr($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == ADD) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return [$fadd($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == SUB) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return [$fsub($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == MUL) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return [$fmul($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == DIV) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return [$fdiv($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == MIN) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return [$fmin($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == MAX) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return [$fmax($size(Fnn), fN_1, fN_2)]
 }
 Assert((binop_u0 == COPYSIGN))
 Assert(type(valty_u1) == Fnn)
 Let Fnn = valty_u1
 Let fN_1 = val__u3
 Let fN_2 = val__u5
 Return [$fcopysign($size(Fnn), fN_1, fN_2)]
}

testop Inn EQZ iN = {
 Return $ieqz($size(Inn), iN)
}

relop valty_u1 relop_u0 val__u3 val__u5 = {
 If (((relop_u0 == EQ) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return $ieq($size(Inn), iN_1, iN_2)
 }
 If (((relop_u0 == NE) && type(valty_u1) == Inn)) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   Return $ine($size(Inn), iN_1, iN_2)
 }
 If (type(valty_u1) == Inn) {
   Let Inn = valty_u1
   Let iN_1 = val__u3
   Let iN_2 = val__u5
   If (case(relop_u0) == LT) {
     Let (LT sx) = relop_u0
     Return $ilt($size(Inn), sx, iN_1, iN_2)
   }
   If (case(relop_u0) == GT) {
     Let (GT sx) = relop_u0
     Return $igt($size(Inn), sx, iN_1, iN_2)
   }
   If (case(relop_u0) == LE) {
     Let (LE sx) = relop_u0
     Return $ile($size(Inn), sx, iN_1, iN_2)
   }
   If (case(relop_u0) == GE) {
     Let (GE sx) = relop_u0
     Return $ige($size(Inn), sx, iN_1, iN_2)
   }
 }
 If (((relop_u0 == EQ) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $feq($size(Fnn), fN_1, fN_2)
 }
 If (((relop_u0 == NE) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $fne($size(Fnn), fN_1, fN_2)
 }
 If (((relop_u0 == LT) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $flt($size(Fnn), fN_1, fN_2)
 }
 If (((relop_u0 == GT) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $fgt($size(Fnn), fN_1, fN_2)
 }
 If (((relop_u0 == LE) && type(valty_u1) == Fnn)) {
   Let Fnn = valty_u1
   Let fN_1 = val__u3
   Let fN_2 = val__u5
   Return $fle($size(Fnn), fN_1, fN_2)
 }
 Assert((relop_u0 == GE))
 Assert(type(valty_u1) == Fnn)
 Let Fnn = valty_u1
 Let fN_1 = val__u3
 Let fN_2 = val__u5
 Return $fge($size(Fnn), fN_1, fN_2)
}

cvtop valty_u0 valty_u1 cvtop_u2 val__u4 = {
 If (((valty_u0 == I32) && (valty_u1 == I64))) {
   Let iN = val__u4
   If (case(cvtop_u2) == EXTEND) {
     Let (EXTEND sx) = cvtop_u2
     Return [$ext(32, 64, sx, iN)]
   }
 }
 If (((valty_u0 == I64) && ((valty_u1 == I32) && (cvtop_u2 == WRAP)))) {
   Let iN = val__u4
   Return [$wrap(64, 32, iN)]
 }
 If (type(valty_u0) == Fnn) {
   Let Fnn = valty_u0
   If (type(valty_u1) == Inn) {
     Let Inn = valty_u1
     Let fN = val__u4
     If (case(cvtop_u2) == TRUNC) {
       Let (TRUNC sx) = cvtop_u2
       Return [$trunc($size(Fnn), $size(Inn), sx, fN)]
     }
   }
 }
 If (((valty_u0 == F32) && ((valty_u1 == F64) && (cvtop_u2 == PROMOTE)))) {
   Let fN = val__u4
   Return [$promote(32, 64, fN)]
 }
 If (((valty_u0 == F64) && ((valty_u1 == F32) && (cvtop_u2 == DEMOTE)))) {
   Let fN = val__u4
   Return [$demote(64, 32, fN)]
 }
 If (type(valty_u1) == Fnn) {
   Let Fnn = valty_u1
   If (type(valty_u0) == Inn) {
     Let Inn = valty_u0
     Let iN = val__u4
     If (case(cvtop_u2) == CONVERT) {
       Let (CONVERT sx) = cvtop_u2
       Return [$convert($size(Inn), $size(Fnn), sx, iN)]
     }
   }
 }
 Assert((cvtop_u2 == REINTERPRET))
 If (type(valty_u1) == Fnn) {
   Let Fnn = valty_u1
   If (type(valty_u0) == Inn) {
     Let Inn = valty_u0
     Let iN = val__u4
     If (($size(Inn) == $size(Fnn))) {
       Return [$reinterpret(Inn, Fnn, iN)]
     }
   }
 }
 Assert(type(valty_u0) == Fnn)
 Let Fnn = valty_u0
 Assert(type(valty_u1) == Inn)
 Let Inn = valty_u1
 Let fN = val__u4
 Assert(($size(Inn) == $size(Fnn)))
 Return [$reinterpret(Fnn, Inn, fN)]
}

invibytes N b* = {
 Let n = $inverse_of_ibytes(N, b*)
 Return n
}

invfbytes N b* = {
 Let p = $inverse_of_fbytes(N, b*)
 Return p
}

default_ valty_u0 = {
 If ((valty_u0 == I32)) {
   Return (I32.CONST 0)
 }
 If ((valty_u0 == I64)) {
   Return (I64.CONST 0)
 }
 If ((valty_u0 == F32)) {
   Return (F32.CONST $fzero(32))
 }
 Assert((valty_u0 == F64))
 Return (F64.CONST $fzero(64))
}

funcsxv exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xv* = exter_u0*
 If (case(y_0) == FUNC) {
   Let (FUNC fa) = y_0
   Return [fa] ++ $funcsxv(xv*)
 }
 Let [externval] ++ xv* = exter_u0*
 Return $funcsxv(xv*)
}

globalsxv exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xv* = exter_u0*
 If (case(y_0) == GLOBAL) {
   Let (GLOBAL ga) = y_0
   Return [ga] ++ $globalsxv(xv*)
 }
 Let [externval] ++ xv* = exter_u0*
 Return $globalsxv(xv*)
}

tablesxv exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xv* = exter_u0*
 If (case(y_0) == TABLE) {
   Let (TABLE ta) = y_0
   Return [ta] ++ $tablesxv(xv*)
 }
 Let [externval] ++ xv* = exter_u0*
 Return $tablesxv(xv*)
}

memsxv exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xv* = exter_u0*
 If (case(y_0) == MEM) {
   Let (MEM ma) = y_0
   Return [ma] ++ $memsxv(xv*)
 }
 Let [externval] ++ xv* = exter_u0*
 Return $memsxv(xv*)
}

store = {
 Return
}

frame = {
 Let f = current_frame()
 Return f
}

funcaddr = {
 Let f = current_frame()
 Return f.MODULE.FUNCS
}

funcinst = {
 Return s.FUNCS
}

globalinst = {
 Return s.GLOBALS
}

tableinst = {
 Return s.TABLES
}

meminst = {
 Return s.MEMS
}

moduleinst = {
 Let f = current_frame()
 Return f.MODULE
}

type x = {
 Let f = current_frame()
 Return f.MODULE.TYPES[x]
}

func x = {
 Let f = current_frame()
 Return s.FUNCS[f.MODULE.FUNCS[x]]
}

global x = {
 Let f = current_frame()
 Return s.GLOBALS[f.MODULE.GLOBALS[x]]
}

table x = {
 Let f = current_frame()
 Return s.TABLES[f.MODULE.TABLES[x]]
}

mem x = {
 Let f = current_frame()
 Return s.MEMS[f.MODULE.MEMS[x]]
}

local x = {
 Let f = current_frame()
 Return f.LOCALS[x]
}

with_local x v = {
 Let f = current_frame()
 f.LOCALS[x] := v
}

with_global x v = {
 Let f = current_frame()
 s.GLOBALS[f.MODULE.GLOBALS[x]].VALUE := v
}

with_table x i a = {
 Let f = current_frame()
 s.TABLES[f.MODULE.TABLES[x]].REFS[i] := ?(a)
}

with_tableinst x ti = {
 Let f = current_frame()
 s.TABLES[f.MODULE.TABLES[x]] := ti
}

with_mem x i j b* = {
 Let f = current_frame()
 s.MEMS[f.MODULE.MEMS[x]].BYTES[i : j] := b*
}

with_meminst x mi = {
 Let f = current_frame()
 s.MEMS[f.MODULE.MEMS[x]] := mi
}

growtable ti n = {
 Let { TYPE: (i, j); REFS: ?(a)*; } = ti
 Let i' = (|a*| + n)
 If ((i' ≤ j)) {
   Let ti' = { TYPE: (i', j); REFS: ?(a)* ++ ?()^n; }
   Return ti'
 }
}

growmemory mi n = {
 Let { TYPE: (i, j); BYTES: b*; } = mi
 Let i' = ((|b*| / (64 · $Ki())) + n)
 If ((i' ≤ j)) {
   Let mi' = { TYPE: (i', j); BYTES: b* ++ 0^(n · (64 · $Ki())); }
   Return mi'
 }
}

funcs exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ externval'* = exter_u0*
 If (case(y_0) == FUNC) {
   Let (FUNC fa) = y_0
   Return [fa] ++ $funcs(externval'*)
 }
 Let [externval] ++ externval'* = exter_u0*
 Return $funcs(externval'*)
}

globals exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ externval'* = exter_u0*
 If (case(y_0) == GLOBAL) {
   Let (GLOBAL ga) = y_0
   Return [ga] ++ $globals(externval'*)
 }
 Let [externval] ++ externval'* = exter_u0*
 Return $globals(externval'*)
}

tables exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ externval'* = exter_u0*
 If (case(y_0) == TABLE) {
   Let (TABLE ta) = y_0
   Return [ta] ++ $tables(externval'*)
 }
 Let [externval] ++ externval'* = exter_u0*
 Return $tables(externval'*)
}

mems exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ externval'* = exter_u0*
 If (case(y_0) == MEM) {
   Let (MEM ma) = y_0
   Return [ma] ++ $mems(externval'*)
 }
 Let [externval] ++ externval'* = exter_u0*
 Return $mems(externval'*)
}

allocfunc moduleinst func = {
 Assert(case(func) == FUNC)
 Let (FUNC x local* expr) = func
 Let fi = { TYPE: moduleinst.TYPES[x]; MODULE: moduleinst; CODE: func; }
 Let a = |s.FUNCS|
 fi :+ s.FUNCS
 Return a
}

allocfuncs moduleinst func_u0* = {
 If ((func_u0* == [])) {
   Return []
 }
 Let [func] ++ func'* = func_u0*
 Let fa = $allocfunc(moduleinst, func)
 Let fa'* = $allocfuncs(moduleinst, func'*)
 Return [fa] ++ fa'*
}

allocglobal globaltype val = {
 Let gi = { TYPE: globaltype; VALUE: val; }
 Let a = |s.GLOBALS|
 gi :+ s.GLOBALS
 Return a
}

allocglobals globa_u0* val_u1* = {
 If ((globa_u0* == [])) {
   Assert((val_u1* == []))
   Return []
 }
 Else {
   Let [globaltype] ++ globaltype'* = globa_u0*
   Assert((|val_u1*| ≥ 1))
   Let [val] ++ val'* = val_u1*
   Let ga = $allocglobal(globaltype, val)
   Let ga'* = $allocglobals(globaltype'*, val'*)
   Return [ga] ++ ga'*
 }
}

alloctable (i, j) = {
 Let ti = { TYPE: (i, j); REFS: ?()^i; }
 Let a = |s.TABLES|
 ti :+ s.TABLES
 Return a
}

alloctables table_u0* = {
 If ((table_u0* == [])) {
   Return []
 }
 Let [tabletype] ++ tabletype'* = table_u0*
 Let ta = $alloctable(tabletype)
 Let ta'* = $alloctables(tabletype'*)
 Return [ta] ++ ta'*
}

allocmem (i, j) = {
 Let mi = { TYPE: (i, j); BYTES: 0^(i · (64 · $Ki())); }
 Let a = |s.MEMS|
 mi :+ s.MEMS
 Return a
}

allocmems memty_u0* = {
 If ((memty_u0* == [])) {
   Return []
 }
 Let [memtype] ++ memtype'* = memty_u0*
 Let ma = $allocmem(memtype)
 Let ma'* = $allocmems(memtype'*)
 Return [ma] ++ ma'*
}

instexport fa* ga* ta* ma* (EXPORT name exter_u0) = {
 If (case(exter_u0) == FUNC) {
   Let (FUNC x) = exter_u0
   Return { NAME: name; VALUE: (FUNC fa*[x]); }
 }
 If (case(exter_u0) == GLOBAL) {
   Let (GLOBAL x) = exter_u0
   Return { NAME: name; VALUE: (GLOBAL ga*[x]); }
 }
 If (case(exter_u0) == TABLE) {
   Let (TABLE x) = exter_u0
   Return { NAME: name; VALUE: (TABLE ta*[x]); }
 }
 Assert(case(exter_u0) == MEM)
 Let (MEM x) = exter_u0
 Return { NAME: name; VALUE: (MEM ma*[x]); }
}

allocmodule module externval* val* = {
 Let fa_ex* = $funcs(externval*)
 Let ga_ex* = $globals(externval*)
 Let ma_ex* = $mems(externval*)
 Let ta_ex* = $tables(externval*)
 Assert(case(module) == MODULE)
 Let (MODULE y_0 import* func^n_func y_1 y_2 y_3 elem* data* start? export*) = module
 Let (MEMORY memtype)^n_mem = y_3
 Let (TABLE tabletype)^n_table = y_2
 Let (GLOBAL globaltype expr_1)^n_global = y_1
 Let (TYPE ft)* = y_0
 Let fa* = (|s.FUNCS| + i_func)^(i_func<n_func)
 Let ga* = (|s.GLOBALS| + i_global)^(i_global<n_global)
 Let ta* = (|s.TABLES| + i_table)^(i_table<n_table)
 Let ma* = (|s.MEMS| + i_mem)^(i_mem<n_mem)
 Let xi* = $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*
 Let moduleinst = { TYPES: ft*; FUNCS: fa_ex* ++ fa*; GLOBALS: ga_ex* ++ ga*; TABLES: ta_ex* ++ ta*; MEMS: ma_ex* ++ ma*; EXPORTS: xi*; }
 Let y_0 = $allocfuncs(moduleinst, func^n_func)
 Assert((y_0 == fa*))
 Let y_0 = $allocglobals(globaltype^n_global, val*)
 Assert((y_0 == ga*))
 Let y_0 = $alloctables(tabletype^n_table)
 Assert((y_0 == ta*))
 Let y_0 = $allocmems(memtype^n_mem)
 Assert((y_0 == ma*))
 Return moduleinst
}

initelem moduleinst u32_u0* funca_u1* = {
 If (((u32_u0* == []) && (funca_u1* == []))) {
   Return
 }
 Assert((|funca_u1*| ≥ 1))
 Let [a*] ++ a'** = funca_u1*
 Assert((|u32_u0*| ≥ 1))
 Let [i] ++ i'* = u32_u0*
 s.TABLES[moduleinst.TABLES[0]].REFS[i : |a*|] := ?(a)*
 $initelem(moduleinst, i'*, a'**)
 Return
}

initdata moduleinst u32_u0* byte_u1* = {
 If (((u32_u0* == []) && (byte_u1* == []))) {
   Return
 }
 Assert((|byte_u1*| ≥ 1))
 Let [b*] ++ b'** = byte_u1*
 Assert((|u32_u0*| ≥ 1))
 Let [i] ++ i'* = u32_u0*
 s.MEMS[moduleinst.MEMS[0]].BYTES[i : |b*|] := b*
 $initdata(moduleinst, i'*, b'**)
 Return
}

instantiate module externval* = {
 Assert(case(module) == MODULE)
 Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) = module
 Let (TYPE functype)* = type*
 Let n_F = |func*|
 Let (START x')? = start?
 Let (DATA expr_D b*)* = data*
 Let (ELEM expr_E x*)* = elem*
 Let (GLOBAL globaltype expr_G)* = global*
 Let moduleinst_init = { TYPES: functype*; FUNCS: $funcs(externval*) ++ (|s.FUNCS| + i_F)^(i_F<n_F); GLOBALS: $globals(externval*); TABLES: []; MEMS: []; EXPORTS: []; }
 Let f_init = { LOCALS: []; MODULE: moduleinst_init; }
 Let z = f_init
 Push(callframe(z))
 Let [(I32.CONST i_D)]* = $eval_expr(expr_D)*
 Pop(callframe(z))
 Push(callframe(z))
 Let [(I32.CONST i_E)]* = $eval_expr(expr_E)*
 Pop(callframe(z))
 Push(callframe(z))
 Let [val]* = $eval_expr(expr_G)*
 Pop(callframe(z))
 Let moduleinst = $allocmodule(module, externval*, val*)
 Let f = { LOCALS: []; MODULE: moduleinst; }
 $initelem(moduleinst, i_E*, moduleinst.FUNCS[x]**)
 $initdata(moduleinst, i_D*, b**)
 Push(callframe(0, f))
 If ((CALL x')? != None) {
   Let ?(instr_0) = (CALL x')?
   Execute instr_0
 }
 Pop(callframe(0, f))
 Return f.MODULE
}

invoke fa val^n = {
 Let f = { LOCALS: []; MODULE: { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; EXPORTS: []; }; }
 Let (t_1^n -> t_2*) = $funcinst()[fa].TYPE
 Let k = |t_2*|
 Push(callframe(k, f))
 Push(val^n)
 Execute (CALL_ADDR fa)
 Pop_all(val*)
 Pop(callframe(k, f))
 Push(val*)
 Pop(val^k)
 Return val^k
}

execution_of_UNREACHABLE = {
 Trap
}

execution_of_NOP = {
 Nop
}

execution_of_DROP = {
 Assert(top_value())
 Pop(val)
 Nop
}

execution_of_SELECT = {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 Assert(top_value())
 Pop(val_2)
 Assert(top_value())
 Pop(val_1)
 If ((c != 0)) {
   Push(val_1)
 }
 Else {
   Push(val_2)
 }
}

execution_of_IF t? instr_1* instr_2* = {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 If ((c != 0)) {
   Execute (BLOCK t? instr_1*)
 }
 Else {
   Execute (BLOCK t? instr_2*)
 }
}

execution_of_LABEL_ = {
 Pop_all(val*)
 Assert(top_label())
 Pop(current_label())
 Push(val*)
}

execution_of_BR n_u0 = {
 Pop_all(val*)
 Let L = current_label()
 Let n = arity(L)
 Let instr'* = cont(L)
 Pop(current_label())
 Let admin_u1* = val*
 If (((n_u0 == 0) && (|admin_u1*| ≥ n))) {
   Let val'* ++ val^n = admin_u1*
   Push(val^n)
   Execute instr'*
 }
 If ((n_u0 ≥ 1)) {
   Let l = (n_u0 - 1)
   Let val* = admin_u1*
   Push(val*)
   Execute (BR l)
 }
}

execution_of_BR_IF l = {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 If ((c != 0)) {
   Execute (BR l)
 }
 Else {
   Nop
 }
}

execution_of_BR_TABLE l* l' = {
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i < |l*|)) {
   Execute (BR l*[i])
 }
 Else {
   Execute (BR l')
 }
}

execution_of_FRAME_ = {
 Let f = current_frame()
 Let n = arity(f)
 Assert(top_values(n))
 Pop(val^n)
 Assert(top_frame())
 Pop(current_frame())
 Push(val^n)
}

execution_of_RETURN = {
 Pop_all(val*)
 If (top_frame()) {
   Let F = current_frame()
   Let n = arity(F)
   Pop(current_frame())
   Let val'* ++ val^n = val*
   Push(val^n)
 }
 Else if (top_label()) {
   Pop(current_label())
   Push(val*)
   Execute RETURN
 }
}

execution_of_TRAP = {
 YetI: TODO: It is likely that the value stack of two rules are different.
}

execution_of_UNOP t unop = {
 Assert(top_value(t))
 Pop((t.CONST c_1))
 If ((|$unop(t, unop, c_1)| == 1)) {
   Let [c] = $unop(t, unop, c_1)
   Push((t.CONST c))
 }
 If (($unop(t, unop, c_1) == [])) {
   Trap
 }
}

execution_of_BINOP t binop = {
 Assert(top_value(t))
 Pop((t.CONST c_2))
 Assert(top_value(t))
 Pop((t.CONST c_1))
 If ((|$binop(t, binop, c_1, c_2)| == 1)) {
   Let [c] = $binop(t, binop, c_1, c_2)
   Push((t.CONST c))
 }
 If (($binop(t, binop, c_1, c_2) == [])) {
   Trap
 }
}

execution_of_TESTOP t testop = {
 Assert(top_value(t))
 Pop((t.CONST c_1))
 Let c = $testop(t, testop, c_1)
 Push((I32.CONST c))
}

execution_of_RELOP t relop = {
 Assert(top_value(t))
 Pop((t.CONST c_2))
 Assert(top_value(t))
 Pop((t.CONST c_1))
 Let c = $relop(t, relop, c_1, c_2)
 Push((I32.CONST c))
}

execution_of_CVTOP t_2 t_1 cvtop = {
 Assert(top_value(t_1))
 Pop((t_1.CONST c_1))
 If ((|$cvtop(t_1, t_2, cvtop, c_1)| == 1)) {
   Let [c] = $cvtop(t_1, t_2, cvtop, c_1)
   Push((t_2.CONST c))
 }
 If (($cvtop(t_1, t_2, cvtop, c_1) == [])) {
   Trap
 }
}

execution_of_LOCAL.TEE x = {
 Assert(top_value())
 Pop(val)
 Push(val)
 Push(val)
 Execute (LOCAL.SET x)
}

execution_of_BLOCK t? instr* = {
 If (!(t? != None)) {
   Let n = 0
 }
 Else {
   Let n = 1
 }
 Let L = label(n, [])
 Enter (instr*, L) {
 }
}

execution_of_LOOP t? instr* = {
 Let L = label(0, [(LOOP t? instr*)])
 Enter (instr*, L) {
 }
}

execution_of_CALL x = {
 Let z = current_state()
 Assert((x < |$funcaddr(z)|))
 Execute (CALL_ADDR $funcaddr(z)[x])
}

execution_of_CALL_INDIRECT x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i ≥ |$table(z, 0).REFS|)) {
   Trap
 }
 If (!($table(z, 0).REFS[i] != None)) {
   Trap
 }
 Let ?(a) = $table(z, 0).REFS[i]
 If ((a ≥ |$funcinst(z)|)) {
   Trap
 }
 If (($type(z, x) != $funcinst(z)[a].TYPE)) {
   Trap
 }
 Execute (CALL_ADDR a)
}

execution_of_CALL_ADDR a = {
 Let z = current_state()
 Assert((a < |$funcinst(z)|))
 Let { TYPE: (t_1^k -> t_2^n); MODULE: mm; CODE: func; } = $funcinst(z)[a]
 Assert(top_values(k))
 Pop(val^k)
 Assert(case(func) == FUNC)
 Let (FUNC x y_0 instr*) = func
 Let (LOCAL t)* = y_0
 Let f = { LOCALS: val^k ++ $default_(t)*; MODULE: mm; }
 Let F = callframe(n, f)
 Push(F)
 Let L = label(n, [])
 Enter (instr*, L) {
 }
}

execution_of_LOCAL.GET x = {
 Let z = current_state()
 Push($local(z, x))
}

execution_of_GLOBAL.GET x = {
 Let z = current_state()
 Push($global(z, x).VALUE)
}

execution_of_LOAD valty_u0 sz_sx_u1? ao = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (!(sz_sx_u1? != None)) {
   Let t = valty_u0
   If ((((i + ao.OFFSET) + ($size(t) / 8)) > |$mem(z, 0).BYTES|)) {
     Trap
   }
   Let c = $inverse_of_bytes(t, $mem(z, 0).BYTES[(i + ao.OFFSET) : ($size(t) / 8)])
   Push((t.CONST c))
 }
 If (type(valty_u0) == Inn) {
   If (sz_sx_u1? != None) {
     Let ?(y_0) = sz_sx_u1?
     Let (n, sx) = y_0
     If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|)) {
       Trap
     }
   }
   Let Inn = valty_u0
   If (sz_sx_u1? != None) {
     Let ?(y_0) = sz_sx_u1?
     Let (n, sx) = y_0
     Let c = $inverse_of_ibytes(n, $mem(z, 0).BYTES[(i + ao.OFFSET) : (n / 8)])
     Push((Inn.CONST $ext(n, $size(Inn), sx, c)))
   }
 }
}

execution_of_MEMORY.SIZE = {
 Let z = current_state()
 Let ((n · 64) · $Ki()) = |$mem(z, 0).BYTES|
 Push((I32.CONST n))
}

execution_of_CTXT = {
 Pop_all(val*)
 YetI: TODO: translate_context.
 If (case(admin_u1) == LABEL_) {
   Let (LABEL_ n instr_0* instr*) = admin_u1
   YetI: TODO: translate_rulepr Step.
   Let L = label(n, instr_0*)
   Enter (instr'*, L) {
   }
 }
 YetI: TODO: translate_rulepr Step.
 If (case(admin_u1) == FRAME_) {
   Let (FRAME_ n y_0 instr*) = admin_u1
   If ((y_0 == f')) {
     Execute (FRAME_ n f' instr'*)
   }
 }
}

execution_of_LOCAL.SET x = {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 $with_local(z, x, val)
}

execution_of_GLOBAL.SET x = {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 $with_global(z, x, val)
}

execution_of_STORE valty_u1 sz_u2? ao = {
 Let z = current_state()
 Assert(top_value(valty_u0))
 Pop((valty_u0.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (!(sz_u2? != None)) {
   Let t = valty_u1
   If (((((i + ao.OFFSET) + ($size(t) / 8)) > |$mem(z, 0).BYTES|) && (valty_u0 == t))) {
     Trap
   }
   If ((valty_u0 == t)) {
     Let b* = $bytes(t, c)
     $with_mem(z, 0, (i + ao.OFFSET), ($size(t) / 8), b*)
   }
 }
 Else {
   Let ?(n) = sz_u2?
   If (type(valty_u1) == Inn) {
     Let Inn = valty_u1
     If (((((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|) && (valty_u0 == Inn))) {
       Trap
     }
     If ((valty_u0 == Inn)) {
       Let b* = $ibytes(n, $wrap($size(Inn), n, c))
       $with_mem(z, 0, (i + ao.OFFSET), (n / 8), b*)
     }
   }
 }
}

execution_of_MEMORY.GROW = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Either {
   Let mi = $growmemory($mem(z, 0), n)
   Push((I32.CONST (|$mem(z, 0).BYTES| / (64 · $Ki()))))
   $with_meminst(z, 0, mi)
 }
 Or {
   Push((I32.CONST $invsigned(32, -(1))))
 }
}

eval_expr instr* = {
 Execute instr*
 Pop(val)
 Return [val]
}

group_bytes_by n byte* = {
 Let n' = |byte*|
 If ((n' ≥ n)) {
   Return [byte*[0 : n]] ++ $group_bytes_by(n, byte*[n : (n' - n)])
 }
 Return []
}

execution_of_ARRAY.NEW_DATA x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (case($expanddt($type(z, x))) == ARRAY) {
   Let (ARRAY y_0) = $expanddt($type(z, x))
   Let (mut, zt) = y_0
   If (((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|)) {
     Trap
   }
   Let cnn = $cunpack(zt)
   Let b* = $data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)]
   Let gb* = $group_bytes_by(($zsize(zt) / 8), b*)
   Let c^n = $inverse_of_ibytes($zsize(zt), gb)*
   Push((cnn.CONST c)^n)
   Execute (ARRAY.NEW_FIXED x n)
 }
}
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
8-reduction.watsup:165.12-165.36: translate_rulepr: Yet `(`%;%`_config(z, (instr : instr <: admininstr)*{instr : instr}), `%;%`_config(z', (instr' : instr <: admininstr)*{instr' : instr}))`
8-reduction.watsup:169.12-169.44: translate_rulepr: Yet `(`%;%`_config(`%;%`_state(s, f'), (instr : instr <: admininstr)*{instr : instr}), `%;%`_config(`%;%`_state(s', f'), (instr' : instr <: admininstr)*{instr' : instr}))`
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
- Under the context prepend(C.LABELS, [t_2*]), instr* must be valid with type (t_1* -> t_2*).
- Under the context C, bt must be valid with type (t_1* -> t_2*).
- The instruction is valid with type (t_1* -> t_2*).

validation_of_LOOP bt instr*
- Under the context prepend(C.LABELS, [t_1*]), instr* must be valid with type (t_1* -> t_2*).
- Under the context C, bt must be valid with type (t_1* -> t_2*).
- The instruction is valid with type (t_1* -> t_2*).

validation_of_IF bt instr_1* instr_2*
- Under the context prepend(C.LABELS, [t_2*]), instr_2* must be valid with type (t_1* -> t_2*).
- Under the context C, bt must be valid with type (t_1* -> t_2*).
- Under the context prepend(C.LABELS, [t_2*]), instr_1* must be valid with type (t_1* -> t_2*).
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

validation_of_VEXTUNOP sh_1 sh_2 vextunop sx
- The instruction is valid with type ([V128] -> [V128]).

validation_of_VEXTBINOP sh_1 sh_2 vextbinop sx
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
- ((sx? == ?())) if and only if ((n? == ?())).
- (2 ^ memarg.ALIGN) must be less than or equal to ($size(nt) / 8).
- If n != None,
  - (2 ^ memarg.ALIGN) must be less than or equal to (n / 8).
  - (n / 8) must be less than ($size(nt) / 8).
- n? must be equal to ?().
- Let mt be C.MEMS[0].
- The instruction is valid with type ([I32] -> [nt]).

validation_of_STORE nt n? memarg
- |C.MEMS| must be greater than 0.
- (2 ^ memarg.ALIGN) must be less than or equal to ($size(nt) / 8).
- If n != None,
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

Ki = {
 Return 1024
}

min n_u0 n_u1 = {
 If ((n_u0 == 0)) {
   Return 0
 }
 If ((n_u1 == 0)) {
   Return 0
 }
 Assert((n_u0 ≥ 1))
 Let i = (n_u0 - 1)
 Assert((n_u1 ≥ 1))
 Let j = (n_u1 - 1)
 Return $min(i, j)
}

sum n_u0* = {
 If ((n_u0* == [])) {
   Return 0
 }
 Let [n] ++ n'* = n_u0*
 Return (n + $sum(n'*))
}

concat_ X_u0* = {
 If ((X_u0* == [])) {
   Return []
 }
 Let [w*] ++ w'** = X_u0*
 Return w* ++ $concat_(w'**)
}

signif N_u0 = {
 If ((N_u0 == 32)) {
   Return 23
 }
 Assert((N_u0 == 64))
 Return 52
}

expon N_u0 = {
 If ((N_u0 == 32)) {
   Return 8
 }
 Assert((N_u0 == 64))
 Return 11
}

M N = {
 Return $signif(N)
}

E N = {
 Return $expon(N)
}

fzero N = {
 Return (POS (SUBNORM 0))
}

fone N = {
 Return (POS (NORM 1 0))
}

canon_ N = {
 Return (2 ^ ($signif(N) - 1))
}

utf8 char_u0* = {
 If ((|char_u0*| == 1)) {
   Let [ch] = char_u0*
   If ((ch < 128)) {
     Let b = ch
     Return [b]
   }
   If (((128 ≤ ch) && ((ch < 2048) && (ch ≥ (b_2 - 128))))) {
     Let ((2 ^ 6) · (b_1 - 192)) = (ch - (b_2 - 128))
     Return [b_1, b_2]
   }
   If (((((2048 ≤ ch) && (ch < 55296)) || ((57344 ≤ ch) && (ch < 65536))) && (ch ≥ (b_3 - 128)))) {
     Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · (b_2 - 128))) = (ch - (b_3 - 128))
     Return [b_1, b_2, b_3]
   }
   If (((65536 ≤ ch) && ((ch < 69632) && (ch ≥ (b_4 - 128))))) {
     Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · (b_2 - 128))) + ((2 ^ 6) · (b_3 - 128))) = (ch - (b_4 - 128))
     Return [b_1, b_2, b_3, b_4]
   }
 }
 Let ch* = char_u0*
 Return $concat_($utf8([ch])*)
}

size valty_u0 = {
 If ((valty_u0 == I32)) {
   Return 32
 }
 If ((valty_u0 == I64)) {
   Return 64
 }
 If ((valty_u0 == F32)) {
   Return 32
 }
 If ((valty_u0 == F64)) {
   Return 64
 }
 If ((valty_u0 == V128)) {
   Return 128
 }
}

isize Inn = {
 Return $size(Inn)
}

psize packt_u0 = {
 If ((packt_u0 == I8)) {
   Return 8
 }
 Assert((packt_u0 == I16))
 Return 16
}

lsize lanet_u0 = {
 If (type(lanet_u0) == numtype) {
   Let numtype = lanet_u0
   Return $size(numtype)
 }
 Assert(type(lanet_u0) == packtype)
 Let packtype = lanet_u0
 Return $psize(packtype)
}

lanetype (Lnn X N) = {
 Return Lnn
}

sizenn nt = {
 Return $size(nt)
}

sizemm lt = {
 Return $lsize(lt)
}

zero numty_u0 = {
 If (type(numty_u0) == Inn) {
   Return 0
 }
 Assert(type(numty_u0) == Fnn)
 Let Fnn = numty_u0
 Return $fzero($size(Fnn))
}

dim (Lnn X N) = {
 Return N
}

shsize (Lnn X N) = {
 Return ($lsize(Lnn) · N)
}

concat_bytes byte_u0* = {
 If ((byte_u0* == [])) {
   Return []
 }
 Let [b*] ++ b'** = byte_u0*
 Return b* ++ $concat_bytes(b'**)
}

unpack lanet_u0 = {
 If (type(lanet_u0) == numtype) {
   Let numtype = lanet_u0
   Return numtype
 }
 Assert(type(lanet_u0) == packtype)
 Return I32
}

shunpack (Lnn X N) = {
 Return $unpack(Lnn)
}

funcsxt exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xt* = exter_u0*
 If (case(y_0) == FUNC) {
   Let (FUNC ft) = y_0
   Return [ft] ++ $funcsxt(xt*)
 }
 Let [externtype] ++ xt* = exter_u0*
 Return $funcsxt(xt*)
}

globalsxt exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xt* = exter_u0*
 If (case(y_0) == GLOBAL) {
   Let (GLOBAL gt) = y_0
   Return [gt] ++ $globalsxt(xt*)
 }
 Let [externtype] ++ xt* = exter_u0*
 Return $globalsxt(xt*)
}

tablesxt exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xt* = exter_u0*
 If (case(y_0) == TABLE) {
   Let (TABLE tt) = y_0
   Return [tt] ++ $tablesxt(xt*)
 }
 Let [externtype] ++ xt* = exter_u0*
 Return $tablesxt(xt*)
}

memsxt exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xt* = exter_u0*
 If (case(y_0) == MEM) {
   Let (MEM mt) = y_0
   Return [mt] ++ $memsxt(xt*)
 }
 Let [externtype] ++ xt* = exter_u0*
 Return $memsxt(xt*)
}

free_dataidx_instr instr_u0 = {
 If (case(instr_u0) == MEMORY.INIT) {
   Let (MEMORY.INIT x) = instr_u0
   Return [x]
 }
 If (case(instr_u0) == DATA.DROP) {
   Let (DATA.DROP x) = instr_u0
   Return [x]
 }
 Return []
}

free_dataidx_instrs instr_u0* = {
 If ((instr_u0* == [])) {
   Return []
 }
 Let [instr] ++ instr'* = instr_u0*
 Return $free_dataidx_instr(instr) ++ $free_dataidx_instrs(instr'*)
}

free_dataidx_expr in* = {
 Return $free_dataidx_instrs(in*)
}

free_dataidx_func (FUNC x loc* e) = {
 Return $free_dataidx_expr(e)
}

free_dataidx_funcs func_u0* = {
 If ((func_u0* == [])) {
   Return []
 }
 Let [func] ++ func'* = func_u0*
 Return $free_dataidx_func(func) ++ $free_dataidx_funcs(func'*)
}

memarg0 = {
 Return { ALIGN: 0; OFFSET: 0; }
}

signed N i = {
 If ((0 ≤ (2 ^ (N - 1)))) {
   Return i
 }
 Assert(((2 ^ (N - 1)) ≤ i))
 Assert((i < (2 ^ N)))
 Return (i - (2 ^ N))
}

invsigned N i = {
 Let j = $inverse_of_signed(N, i)
 Return j
}

unop numty_u1 unop__u0 num__u3 = {
 If (((unop__u0 == CLZ) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN = num__u3
   Return [$iclz($size(Inn), iN)]
 }
 If (((unop__u0 == CTZ) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN = num__u3
   Return [$ictz($size(Inn), iN)]
 }
 If (((unop__u0 == POPCNT) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN = num__u3
   Return [$ipopcnt($size(Inn), iN)]
 }
 If (type(numty_u1) == Inn) {
   Let Inn = numty_u1
   Assert(case(unop__u0) == EXTEND)
   Let (EXTEND N) = unop__u0
   Let iN = num__u3
   Return [$ext(N, $size(Inn), S, $wrap($size(Inn), N, iN))]
 }
 If (((unop__u0 == ABS) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN = num__u3
   Return [$fabs($size(Fnn), fN)]
 }
 If (((unop__u0 == NEG) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN = num__u3
   Return [$fneg($size(Fnn), fN)]
 }
 If (((unop__u0 == SQRT) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN = num__u3
   Return [$fsqrt($size(Fnn), fN)]
 }
 If (((unop__u0 == CEIL) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN = num__u3
   Return [$fceil($size(Fnn), fN)]
 }
 If (((unop__u0 == FLOOR) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN = num__u3
   Return [$ffloor($size(Fnn), fN)]
 }
 If (((unop__u0 == TRUNC) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN = num__u3
   Return [$ftrunc($size(Fnn), fN)]
 }
 Assert((unop__u0 == NEAREST))
 Assert(type(numty_u1) == Fnn)
 Let Fnn = numty_u1
 Let fN = num__u3
 Return [$fnearest($size(Fnn), fN)]
}

binop numty_u1 binop_u0 num__u3 num__u5 = {
 If (((binop_u0 == ADD) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$iadd($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == SUB) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$isub($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == MUL) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$imul($size(Inn), iN_1, iN_2)]
 }
 If (type(numty_u1) == Inn) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   If (case(binop_u0) == DIV) {
     Let (DIV sx) = binop_u0
     Return [$idiv($size(Inn), sx, iN_1, iN_2)]
   }
   If (case(binop_u0) == REM) {
     Let (REM sx) = binop_u0
     Return [$irem($size(Inn), sx, iN_1, iN_2)]
   }
 }
 If (((binop_u0 == AND) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$iand($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == OR) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$ior($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == XOR) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$ixor($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == SHL) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$ishl($size(Inn), iN_1, iN_2)]
 }
 If (type(numty_u1) == Inn) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   If (case(binop_u0) == SHR) {
     Let (SHR sx) = binop_u0
     Return [$ishr($size(Inn), sx, iN_1, iN_2)]
   }
 }
 If (((binop_u0 == ROTL) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$irotl($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == ROTR) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$irotr($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == ADD) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return [$fadd($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == SUB) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return [$fsub($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == MUL) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return [$fmul($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == DIV) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return [$fdiv($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == MIN) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return [$fmin($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == MAX) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return [$fmax($size(Fnn), fN_1, fN_2)]
 }
 Assert((binop_u0 == COPYSIGN))
 Assert(type(numty_u1) == Fnn)
 Let Fnn = numty_u1
 Let fN_1 = num__u3
 Let fN_2 = num__u5
 Return [$fcopysign($size(Fnn), fN_1, fN_2)]
}

testop Inn EQZ iN = {
 Return $ieqz($size(Inn), iN)
}

relop numty_u1 relop_u0 num__u3 num__u5 = {
 If (((relop_u0 == EQ) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return $ieq($size(Inn), iN_1, iN_2)
 }
 If (((relop_u0 == NE) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return $ine($size(Inn), iN_1, iN_2)
 }
 If (type(numty_u1) == Inn) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   If (case(relop_u0) == LT) {
     Let (LT sx) = relop_u0
     Return $ilt($size(Inn), sx, iN_1, iN_2)
   }
   If (case(relop_u0) == GT) {
     Let (GT sx) = relop_u0
     Return $igt($size(Inn), sx, iN_1, iN_2)
   }
   If (case(relop_u0) == LE) {
     Let (LE sx) = relop_u0
     Return $ile($size(Inn), sx, iN_1, iN_2)
   }
   If (case(relop_u0) == GE) {
     Let (GE sx) = relop_u0
     Return $ige($size(Inn), sx, iN_1, iN_2)
   }
 }
 If (((relop_u0 == EQ) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $feq($size(Fnn), fN_1, fN_2)
 }
 If (((relop_u0 == NE) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fne($size(Fnn), fN_1, fN_2)
 }
 If (((relop_u0 == LT) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $flt($size(Fnn), fN_1, fN_2)
 }
 If (((relop_u0 == GT) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fgt($size(Fnn), fN_1, fN_2)
 }
 If (((relop_u0 == LE) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fle($size(Fnn), fN_1, fN_2)
 }
 Assert((relop_u0 == GE))
 Assert(type(numty_u1) == Fnn)
 Let Fnn = numty_u1
 Let fN_1 = num__u3
 Let fN_2 = num__u5
 Return $fge($size(Fnn), fN_1, fN_2)
}

cvtop numty_u0 numty_u1 cvtop_u2 num__u4 = {
 If (((numty_u0 == I32) && (numty_u1 == I64))) {
   Let iN = num__u4
   If (case(cvtop_u2) == EXTEND) {
     Let (EXTEND sx) = cvtop_u2
     Return [$ext(32, 64, sx, iN)]
   }
 }
 If (((numty_u0 == I64) && ((numty_u1 == I32) && (cvtop_u2 == WRAP)))) {
   Let iN = num__u4
   Return [$wrap(64, 32, iN)]
 }
 If (type(numty_u0) == Fnn) {
   Let Fnn = numty_u0
   If (type(numty_u1) == Inn) {
     Let Inn = numty_u1
     Let fN = num__u4
     If (case(cvtop_u2) == TRUNC) {
       Let (TRUNC sx) = cvtop_u2
       Return [$trunc($size(Fnn), $size(Inn), sx, fN)]
     }
     If (case(cvtop_u2) == TRUNC_SAT) {
       Let (TRUNC_SAT sx) = cvtop_u2
       Return [$trunc_sat($size(Fnn), $size(Inn), sx, fN)]
     }
   }
 }
 If (((numty_u0 == F32) && ((numty_u1 == F64) && (cvtop_u2 == PROMOTE)))) {
   Let fN = num__u4
   Return [$promote(32, 64, fN)]
 }
 If (((numty_u0 == F64) && ((numty_u1 == F32) && (cvtop_u2 == DEMOTE)))) {
   Let fN = num__u4
   Return [$demote(64, 32, fN)]
 }
 If (type(numty_u1) == Fnn) {
   Let Fnn = numty_u1
   If (type(numty_u0) == Inn) {
     Let Inn = numty_u0
     Let iN = num__u4
     If (case(cvtop_u2) == CONVERT) {
       Let (CONVERT sx) = cvtop_u2
       Return [$convert($size(Inn), $size(Fnn), sx, iN)]
     }
   }
 }
 Assert((cvtop_u2 == REINTERPRET))
 If (type(numty_u1) == Fnn) {
   Let Fnn = numty_u1
   If (type(numty_u0) == Inn) {
     Let Inn = numty_u0
     Let iN = num__u4
     If (($size(Inn) == $size(Fnn))) {
       Return [$reinterpret(Inn, Fnn, iN)]
     }
   }
 }
 Assert(type(numty_u0) == Fnn)
 Let Fnn = numty_u0
 Assert(type(numty_u1) == Inn)
 Let Inn = numty_u1
 Let fN = num__u4
 Assert(($size(Inn) == $size(Fnn)))
 Return [$reinterpret(Fnn, Inn, fN)]
}

invibytes N b* = {
 Let n = $inverse_of_ibytes(N, b*)
 Return n
}

invfbytes N b* = {
 Let p = $inverse_of_fbytes(N, b*)
 Return p
}

packnum lanet_u0 c = {
 If (type(lanet_u0) == numtype) {
   Return c
 }
 Assert(type(lanet_u0) == packtype)
 Let packtype = lanet_u0
 Return $wrap($size($unpack(packtype)), $psize(packtype), c)
}

unpacknum lanet_u0 c = {
 If (type(lanet_u0) == numtype) {
   Return c
 }
 Assert(type(lanet_u0) == packtype)
 Let packtype = lanet_u0
 Return $ext($psize(packtype), $size($unpack(packtype)), U, c)
}

invlanes_ sh c* = {
 Let vc = $inverse_of_lanes_(sh, c*)
 Return vc
}

halfop half_u0 i j = {
 If ((half_u0 == LOW)) {
   Return i
 }
 Assert((half_u0 == HIGH))
 Return j
}

vvunop V128 NOT v128 = {
 Return $inot($size(V128), v128)
}

vvbinop V128 vvbin_u0 v128_1 v128_2 = {
 If ((vvbin_u0 == AND)) {
   Return $iand($size(V128), v128_1, v128_2)
 }
 If ((vvbin_u0 == ANDNOT)) {
   Return $iandnot($size(V128), v128_1, v128_2)
 }
 If ((vvbin_u0 == OR)) {
   Return $ior($size(V128), v128_1, v128_2)
 }
 Assert((vvbin_u0 == XOR))
 Return $ixor($size(V128), v128_1, v128_2)
}

vvternop V128 BITSELECT v128_1 v128_2 v128_3 = {
 Return $ibitselect($size(V128), v128_1, v128_2, v128_3)
}

vunop (lanet_u1 X N) vunop_u0 v128_1 = {
 If (((vunop_u0 == ABS) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let v128 = $invlanes_((Jnn X N), $iabs($lsize(Jnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == NEG) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let v128 = $invlanes_((Jnn X N), $ineg($lsize(Jnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == POPCNT) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let v128 = $invlanes_((Jnn X N), $ipopcnt($lsize(Jnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == ABS) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let v128 = $invlanes_((Fnn X N), $fabs($size(Fnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == NEG) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let v128 = $invlanes_((Fnn X N), $fneg($size(Fnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == SQRT) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let v128 = $invlanes_((Fnn X N), $fsqrt($size(Fnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == CEIL) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let v128 = $invlanes_((Fnn X N), $fceil($size(Fnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == FLOOR) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let v128 = $invlanes_((Fnn X N), $ffloor($size(Fnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == TRUNC) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let v128 = $invlanes_((Fnn X N), $ftrunc($size(Fnn), lane_1)*)
   Return v128
 }
 Assert((vunop_u0 == NEAREST))
 Assert(type(lanet_u1) == Fnn)
 Let Fnn = lanet_u1
 Let lane_1* = $lanes_((Fnn X N), v128_1)
 Let v128 = $invlanes_((Fnn X N), $fnearest($size(Fnn), lane_1)*)
 Return v128
}

vbinop (lanet_u1 X N) vbino_u0 v128_1 v128_2 = {
 If (((vbino_u0 == ADD) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let v128 = $invlanes_((Jnn X N), $iadd($lsize(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == SUB) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let v128 = $invlanes_((Jnn X N), $isub($lsize(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (type(lanet_u1) == Jnn) {
   Let Jnn = lanet_u1
   If (case(vbino_u0) == MIN) {
     Let (MIN sx) = vbino_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let v128 = $invlanes_((Jnn X N), $imin($lsize(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
   If (case(vbino_u0) == MAX) {
     Let (MAX sx) = vbino_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let v128 = $invlanes_((Jnn X N), $imax($lsize(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
   If (case(vbino_u0) == ADD_SAT) {
     Let (ADD_SAT sx) = vbino_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let v128 = $invlanes_((Jnn X N), $iaddsat($lsize(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
   If (case(vbino_u0) == SUB_SAT) {
     Let (SUB_SAT sx) = vbino_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let v128 = $invlanes_((Jnn X N), $isubsat($lsize(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
 }
 If (((vbino_u0 == MUL) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let v128 = $invlanes_((Jnn X N), $imul($lsize(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == AVGR_U) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let v128 = $invlanes_((Jnn X N), $iavgr_u($lsize(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == Q15MULR_SAT_S) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let v128 = $invlanes_((Jnn X N), $iq15mulrsat_s($lsize(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == ADD) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fadd($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == SUB) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fsub($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == MUL) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fmul($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == DIV) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fdiv($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == MIN) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fmin($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == MAX) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fmax($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == PMIN) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fpmin($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 Assert((vbino_u0 == PMAX))
 Assert(type(lanet_u1) == Fnn)
 Let Fnn = lanet_u1
 Let lane_1* = $lanes_((Fnn X N), v128_1)
 Let lane_2* = $lanes_((Fnn X N), v128_2)
 Let v128 = $invlanes_((Fnn X N), $fpmax($size(Fnn), lane_1, lane_2)*)
 Return [v128]
}

vrelop (lanet_u1 X N) vrelo_u0 v128_1 v128_2 = {
 If (((vrelo_u0 == EQ) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let lane_3* = $ext(1, $lsize(Jnn), S, $ieq($lsize(Jnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Jnn X N), lane_3*)
   Return v128
 }
 If (((vrelo_u0 == NE) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let lane_3* = $ext(1, $lsize(Jnn), S, $ine($lsize(Jnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Jnn X N), lane_3*)
   Return v128
 }
 If (type(lanet_u1) == Jnn) {
   Let Jnn = lanet_u1
   If (case(vrelo_u0) == LT) {
     Let (LT sx) = vrelo_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let lane_3* = $ext(1, $lsize(Jnn), S, $ilt($lsize(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X N), lane_3*)
     Return v128
   }
   If (case(vrelo_u0) == GT) {
     Let (GT sx) = vrelo_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let lane_3* = $ext(1, $lsize(Jnn), S, $igt($lsize(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X N), lane_3*)
     Return v128
   }
   If (case(vrelo_u0) == LE) {
     Let (LE sx) = vrelo_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let lane_3* = $ext(1, $lsize(Jnn), S, $ile($lsize(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X N), lane_3*)
     Return v128
   }
   If (case(vrelo_u0) == GE) {
     Let (GE sx) = vrelo_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let lane_3* = $ext(1, $lsize(Jnn), S, $ige($lsize(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X N), lane_3*)
     Return v128
   }
 }
 If (((vrelo_u0 == EQ) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let Inn = $inverse_of_isize($size(Fnn))
   Let lane_3* = $ext(1, $size(Fnn), S, $feq($size(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X N), lane_3*)
   Return v128
 }
 If (((vrelo_u0 == NE) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let Inn = $inverse_of_isize($size(Fnn))
   Let lane_3* = $ext(1, $size(Fnn), S, $fne($size(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X N), lane_3*)
   Return v128
 }
 If (((vrelo_u0 == LT) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let Inn = $inverse_of_isize($size(Fnn))
   Let lane_3* = $ext(1, $size(Fnn), S, $flt($size(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X N), lane_3*)
   Return v128
 }
 If (((vrelo_u0 == GT) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let Inn = $inverse_of_isize($size(Fnn))
   Let lane_3* = $ext(1, $size(Fnn), S, $fgt($size(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X N), lane_3*)
   Return v128
 }
 If (((vrelo_u0 == LE) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let Inn = $inverse_of_isize($size(Fnn))
   Let lane_3* = $ext(1, $size(Fnn), S, $fle($size(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X N), lane_3*)
   Return v128
 }
 Assert((vrelo_u0 == GE))
 Assert(type(lanet_u1) == Fnn)
 Let Fnn = lanet_u1
 Let lane_1* = $lanes_((Fnn X N), v128_1)
 Let lane_2* = $lanes_((Fnn X N), v128_2)
 Let Inn = $inverse_of_isize($size(Fnn))
 Let lane_3* = $ext(1, $size(Fnn), S, $fge($size(Fnn), lane_1, lane_2))*
 Let v128 = $invlanes_((Inn X N), lane_3*)
 Return v128
}

vcvtop (lanet_u0 X N_1) (lanet_u1 X N_2) vcvto_u4 sx_u5? lane__u3 = {
 If (((lanet_u0 == I8) && ((lanet_u1 == I16) && (vcvto_u4 == EXTEND)))) {
   Let i8 = lane__u3
   If (sx_u5? != None) {
     Let ?(sx) = sx_u5?
     Let i16 = $ext(8, 16, sx, i8)
     Return i16
   }
 }
 If (((lanet_u0 == I16) && ((lanet_u1 == I32) && (vcvto_u4 == EXTEND)))) {
   Let i16 = lane__u3
   If (sx_u5? != None) {
     Let ?(sx) = sx_u5?
     Let i32 = $ext(16, 32, sx, i16)
     Return i32
   }
 }
 If ((lanet_u0 == I32)) {
   If (((lanet_u1 == I64) && (vcvto_u4 == EXTEND))) {
     Let i32 = lane__u3
     If (sx_u5? != None) {
       Let ?(sx) = sx_u5?
       Let i64 = $ext(32, 64, sx, i32)
       Return i64
     }
   }
   If (((lanet_u1 == F32) && (vcvto_u4 == CONVERT))) {
     Let i32 = lane__u3
     If (sx_u5? != None) {
       Let ?(sx) = sx_u5?
       Let f32 = $convert(32, 32, sx, i32)
       Return f32
     }
   }
   If (((lanet_u1 == F64) && (vcvto_u4 == CONVERT))) {
     Let i32 = lane__u3
     If (sx_u5? != None) {
       Let ?(sx) = sx_u5?
       Let f64 = $convert(32, 64, sx, i32)
       Return f64
     }
   }
 }
 If (((lanet_u0 == F32) && ((lanet_u1 == I32) && (vcvto_u4 == TRUNC_SAT)))) {
   Let f32 = lane__u3
   If (sx_u5? != None) {
     Let ?(sx) = sx_u5?
     Let i32 = $trunc_sat(32, 32, sx, f32)
     Return i32
   }
 }
 If ((lanet_u0 == F64)) {
   If (((lanet_u1 == I32) && (vcvto_u4 == TRUNC_SAT))) {
     Let f64 = lane__u3
     If (sx_u5? != None) {
       Let ?(sx) = sx_u5?
       Let i32 = $trunc_sat(64, 32, sx, f64)
       Return i32
     }
   }
   If (((lanet_u1 == F32) && (vcvto_u4 == DEMOTE))) {
     Let f64 = lane__u3
     Let f32 = $demote(64, 32, f64)
     Return f32
   }
 }
 Assert((lanet_u0 == F32))
 Assert((lanet_u1 == F64))
 Assert((vcvto_u4 == PROMOTE))
 Let f32 = lane__u3
 Let f64 = $promote(32, 64, f32)
 Return f64
}

vextunop (Inn_1 X N_1) (Inn_2 X N_2) EXTADD_PAIRWISE sx c_1 = {
 Let ci* = $lanes_((Inn_2 X N_2), c_1)
 Let [cj_1, cj_2]* = $inverse_of_concat_($ext($lsize(Inn_2), $lsize(Inn_1), sx, ci)*)
 Let c = $invlanes_((Inn_1 X N_1), $iadd($lsize(Inn_1), cj_1, cj_2)*)
 Return c
}

vextbinop (Inn_1 X N_1) (Inn_2 X N_2) vextb_u0 sx c_1 c_2 = {
 If (case(vextb_u0) == EXTMUL) {
   Let (EXTMUL hf) = vextb_u0
   Let ci_1* = $lanes_((Inn_2 X N_2), c_1)[$halfop(hf, 0, N_1) : N_1]
   Let ci_2* = $lanes_((Inn_2 X N_2), c_2)[$halfop(hf, 0, N_1) : N_1]
   Let c = $invlanes_((Inn_1 X N_1), $imul($lsize(Inn_1), $ext($lsize(Inn_2), $lsize(Inn_1), sx, ci_1), $ext($lsize(Inn_2), $lsize(Inn_1), sx, ci_2))*)
   Return c
 }
 Assert((vextb_u0 == DOT))
 Let ci_1* = $lanes_((Inn_2 X N_2), c_1)
 Let ci_2* = $lanes_((Inn_2 X N_2), c_2)
 Let [cj_1, cj_2]* = $inverse_of_concat_($imul($lsize(Inn_1), $ext($lsize(Inn_2), $lsize(Inn_1), S, ci_1), $ext($lsize(Inn_2), $lsize(Inn_1), S, ci_2))*)
 Let c = $invlanes_((Inn_1 X N_1), $iadd($lsize(Inn_1), cj_1, cj_2)*)
 Return c
}

vshiftop (Jnn X N) vshif_u0 lane n = {
 If ((vshif_u0 == SHL)) {
   Return $ishl($lsize(Jnn), lane, n)
 }
 Assert(case(vshif_u0) == SHR)
 Let (SHR sx) = vshif_u0
 Return $ishr($lsize(Jnn), sx, lane, n)
}

default_ valty_u0 = {
 If ((valty_u0 == I32)) {
   Return (I32.CONST 0)
 }
 If ((valty_u0 == I64)) {
   Return (I64.CONST 0)
 }
 If ((valty_u0 == F32)) {
   Return (F32.CONST $fzero(32))
 }
 If ((valty_u0 == F64)) {
   Return (F64.CONST $fzero(64))
 }
 If ((valty_u0 == V128)) {
   Return (V128.CONST 0)
 }
 If ((valty_u0 == FUNCREF)) {
   Return (REF.NULL FUNCREF)
 }
 Assert((valty_u0 == EXTERNREF))
 Return (REF.NULL EXTERNREF)
}

funcsxv exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xv* = exter_u0*
 If (case(y_0) == FUNC) {
   Let (FUNC fa) = y_0
   Return [fa] ++ $funcsxv(xv*)
 }
 Let [externval] ++ xv* = exter_u0*
 Return $funcsxv(xv*)
}

globalsxv exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xv* = exter_u0*
 If (case(y_0) == GLOBAL) {
   Let (GLOBAL ga) = y_0
   Return [ga] ++ $globalsxv(xv*)
 }
 Let [externval] ++ xv* = exter_u0*
 Return $globalsxv(xv*)
}

tablesxv exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xv* = exter_u0*
 If (case(y_0) == TABLE) {
   Let (TABLE ta) = y_0
   Return [ta] ++ $tablesxv(xv*)
 }
 Let [externval] ++ xv* = exter_u0*
 Return $tablesxv(xv*)
}

memsxv exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xv* = exter_u0*
 If (case(y_0) == MEM) {
   Let (MEM ma) = y_0
   Return [ma] ++ $memsxv(xv*)
 }
 Let [externval] ++ xv* = exter_u0*
 Return $memsxv(xv*)
}

store = {
 Return
}

frame = {
 Let f = current_frame()
 Return f
}

funcaddr = {
 Let f = current_frame()
 Return f.MODULE.FUNCS
}

funcinst = {
 Return s.FUNCS
}

globalinst = {
 Return s.GLOBALS
}

tableinst = {
 Return s.TABLES
}

meminst = {
 Return s.MEMS
}

eleminst = {
 Return s.ELEMS
}

datainst = {
 Return s.DATAS
}

moduleinst = {
 Let f = current_frame()
 Return f.MODULE
}

type x = {
 Let f = current_frame()
 Return f.MODULE.TYPES[x]
}

func x = {
 Let f = current_frame()
 Return s.FUNCS[f.MODULE.FUNCS[x]]
}

global x = {
 Let f = current_frame()
 Return s.GLOBALS[f.MODULE.GLOBALS[x]]
}

table x = {
 Let f = current_frame()
 Return s.TABLES[f.MODULE.TABLES[x]]
}

mem x = {
 Let f = current_frame()
 Return s.MEMS[f.MODULE.MEMS[x]]
}

elem x = {
 Let f = current_frame()
 Return s.ELEMS[f.MODULE.ELEMS[x]]
}

data x = {
 Let f = current_frame()
 Return s.DATAS[f.MODULE.DATAS[x]]
}

local x = {
 Let f = current_frame()
 Return f.LOCALS[x]
}

with_local x v = {
 Let f = current_frame()
 f.LOCALS[x] := v
}

with_global x v = {
 Let f = current_frame()
 s.GLOBALS[f.MODULE.GLOBALS[x]].VALUE := v
}

with_table x i r = {
 Let f = current_frame()
 s.TABLES[f.MODULE.TABLES[x]].REFS[i] := r
}

with_tableinst x ti = {
 Let f = current_frame()
 s.TABLES[f.MODULE.TABLES[x]] := ti
}

with_mem x i j b* = {
 Let f = current_frame()
 s.MEMS[f.MODULE.MEMS[x]].BYTES[i : j] := b*
}

with_meminst x mi = {
 Let f = current_frame()
 s.MEMS[f.MODULE.MEMS[x]] := mi
}

with_elem x r* = {
 Let f = current_frame()
 s.ELEMS[f.MODULE.ELEMS[x]].REFS := r*
}

with_data x b* = {
 Let f = current_frame()
 s.DATAS[f.MODULE.DATAS[x]].BYTES := b*
}

growtable ti n r = {
 Let { TYPE: ((i, j), rt); REFS: r'*; } = ti
 Let i' = (|r'*| + n)
 If ((i' ≤ j)) {
   Let ti' = { TYPE: ((i', j), rt); REFS: r'* ++ r^n; }
   Return ti'
 }
}

growmemory mi n = {
 Let { TYPE: (PAGE (i, j)); BYTES: b*; } = mi
 Let i' = ((|b*| / (64 · $Ki())) + n)
 If ((i' ≤ j)) {
   Let mi' = { TYPE: (PAGE (i', j)); BYTES: b* ++ 0^(n · (64 · $Ki())); }
   Return mi'
 }
}

blocktype block_u1 = {
 If ((block_u1 == (_RESULT ?()))) {
   Return ([] -> [])
 }
 If (case(block_u1) == _RESULT) {
   Let (_RESULT y_0) = block_u1
   If (y_0 != None) {
     Let ?(t) = y_0
     Return ([] -> [t])
   }
 }
 Assert(case(block_u1) == _IDX)
 Let (_IDX x) = block_u1
 Return $type(x)
}

funcs exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ externval'* = exter_u0*
 If (case(y_0) == FUNC) {
   Let (FUNC fa) = y_0
   Return [fa] ++ $funcs(externval'*)
 }
 Let [externval] ++ externval'* = exter_u0*
 Return $funcs(externval'*)
}

globals exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ externval'* = exter_u0*
 If (case(y_0) == GLOBAL) {
   Let (GLOBAL ga) = y_0
   Return [ga] ++ $globals(externval'*)
 }
 Let [externval] ++ externval'* = exter_u0*
 Return $globals(externval'*)
}

tables exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ externval'* = exter_u0*
 If (case(y_0) == TABLE) {
   Let (TABLE ta) = y_0
   Return [ta] ++ $tables(externval'*)
 }
 Let [externval] ++ externval'* = exter_u0*
 Return $tables(externval'*)
}

mems exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ externval'* = exter_u0*
 If (case(y_0) == MEM) {
   Let (MEM ma) = y_0
   Return [ma] ++ $mems(externval'*)
 }
 Let [externval] ++ externval'* = exter_u0*
 Return $mems(externval'*)
}

allocfunc moduleinst func = {
 Assert(case(func) == FUNC)
 Let (FUNC x local* expr) = func
 Let fi = { TYPE: moduleinst.TYPES[x]; MODULE: moduleinst; CODE: func; }
 Let a = |s.FUNCS|
 fi :+ s.FUNCS
 Return a
}

allocfuncs moduleinst func_u0* = {
 If ((func_u0* == [])) {
   Return []
 }
 Let [func] ++ func'* = func_u0*
 Let fa = $allocfunc(moduleinst, func)
 Let fa'* = $allocfuncs(moduleinst, func'*)
 Return [fa] ++ fa'*
}

allocglobal globaltype val = {
 Let gi = { TYPE: globaltype; VALUE: val; }
 Let a = |s.GLOBALS|
 gi :+ s.GLOBALS
 Return a
}

allocglobals globa_u0* val_u1* = {
 If ((globa_u0* == [])) {
   Assert((val_u1* == []))
   Return []
 }
 Else {
   Let [globaltype] ++ globaltype'* = globa_u0*
   Assert((|val_u1*| ≥ 1))
   Let [val] ++ val'* = val_u1*
   Let ga = $allocglobal(globaltype, val)
   Let ga'* = $allocglobals(globaltype'*, val'*)
   Return [ga] ++ ga'*
 }
}

alloctable ((i, j), rt) = {
 Let ti = { TYPE: ((i, j), rt); REFS: (REF.NULL rt)^i; }
 Let a = |s.TABLES|
 ti :+ s.TABLES
 Return a
}

alloctables table_u0* = {
 If ((table_u0* == [])) {
   Return []
 }
 Let [tabletype] ++ tabletype'* = table_u0*
 Let ta = $alloctable(tabletype)
 Let ta'* = $alloctables(tabletype'*)
 Return [ta] ++ ta'*
}

allocmem (PAGE (i, j)) = {
 Let mi = { TYPE: (PAGE (i, j)); BYTES: 0^(i · (64 · $Ki())); }
 Let a = |s.MEMS|
 mi :+ s.MEMS
 Return a
}

allocmems memty_u0* = {
 If ((memty_u0* == [])) {
   Return []
 }
 Let [memtype] ++ memtype'* = memty_u0*
 Let ma = $allocmem(memtype)
 Let ma'* = $allocmems(memtype'*)
 Return [ma] ++ ma'*
}

allocelem rt ref* = {
 Let ei = { TYPE: rt; REFS: ref*; }
 Let a = |s.ELEMS|
 ei :+ s.ELEMS
 Return a
}

allocelems refty_u0* ref_u1* = {
 If (((refty_u0* == []) && (ref_u1* == []))) {
   Return []
 }
 Assert((|ref_u1*| ≥ 1))
 Let [ref*] ++ ref'** = ref_u1*
 Assert((|refty_u0*| ≥ 1))
 Let [rt] ++ rt'* = refty_u0*
 Let ea = $allocelem(rt, ref*)
 Let ea'* = $allocelems(rt'*, ref'**)
 Return [ea] ++ ea'*
}

allocdata byte* = {
 Let di = { BYTES: byte*; }
 Let a = |s.DATAS|
 di :+ s.DATAS
 Return a
}

allocdatas byte_u0* = {
 If ((byte_u0* == [])) {
   Return []
 }
 Let [byte*] ++ byte'** = byte_u0*
 Let da = $allocdata(byte*)
 Let da'* = $allocdatas(byte'**)
 Return [da] ++ da'*
}

instexport fa* ga* ta* ma* (EXPORT name exter_u0) = {
 If (case(exter_u0) == FUNC) {
   Let (FUNC x) = exter_u0
   Return { NAME: name; VALUE: (FUNC fa*[x]); }
 }
 If (case(exter_u0) == GLOBAL) {
   Let (GLOBAL x) = exter_u0
   Return { NAME: name; VALUE: (GLOBAL ga*[x]); }
 }
 If (case(exter_u0) == TABLE) {
   Let (TABLE x) = exter_u0
   Return { NAME: name; VALUE: (TABLE ta*[x]); }
 }
 Assert(case(exter_u0) == MEM)
 Let (MEM x) = exter_u0
 Return { NAME: name; VALUE: (MEM ma*[x]); }
}

allocmodule module externval* val* ref** = {
 Let fa_ex* = $funcs(externval*)
 Let ga_ex* = $globals(externval*)
 Let ma_ex* = $mems(externval*)
 Let ta_ex* = $tables(externval*)
 Assert(case(module) == MODULE)
 Let (MODULE y_0 import* func^n_func y_1 y_2 y_3 y_4 y_5 start? export*) = module
 Let (DATA byte* datamode)^n_data = y_5
 Let (ELEM rt expr_2* elemmode)^n_elem = y_4
 Let (MEMORY memtype)^n_mem = y_3
 Let (TABLE tabletype)^n_table = y_2
 Let (GLOBAL globaltype expr_1)^n_global = y_1
 Let (TYPE ft)* = y_0
 Let fa* = (|s.FUNCS| + i_func)^(i_func<n_func)
 Let ga* = (|s.GLOBALS| + i_global)^(i_global<n_global)
 Let ta* = (|s.TABLES| + i_table)^(i_table<n_table)
 Let ma* = (|s.MEMS| + i_mem)^(i_mem<n_mem)
 Let ea* = (|s.ELEMS| + i_elem)^(i_elem<n_elem)
 Let da* = (|s.DATAS| + i_data)^(i_data<n_data)
 Let xi* = $instexport(fa_ex* ++ fa*, ga_ex* ++ ga*, ta_ex* ++ ta*, ma_ex* ++ ma*, export)*
 Let moduleinst = { TYPES: ft*; FUNCS: fa_ex* ++ fa*; GLOBALS: ga_ex* ++ ga*; TABLES: ta_ex* ++ ta*; MEMS: ma_ex* ++ ma*; ELEMS: ea*; DATAS: da*; EXPORTS: xi*; }
 Let y_0 = $allocfuncs(moduleinst, func^n_func)
 Assert((y_0 == fa*))
 Let y_0 = $allocglobals(globaltype^n_global, val*)
 Assert((y_0 == ga*))
 Let y_0 = $alloctables(tabletype^n_table)
 Assert((y_0 == ta*))
 Let y_0 = $allocmems(memtype^n_mem)
 Assert((y_0 == ma*))
 Let y_0 = $allocelems(rt^n_elem, ref**)
 Assert((y_0 == ea*))
 Let y_0 = $allocdatas(byte*^n_data)
 Assert((y_0 == da*))
 Return moduleinst
}

runelem (ELEM reftype expr* elemm_u0) i = {
 If ((elemm_u0 == PASSIVE)) {
   Return []
 }
 If ((elemm_u0 == DECLARE)) {
   Return [(ELEM.DROP i)]
 }
 Assert(case(elemm_u0) == ACTIVE)
 Let (ACTIVE x instr*) = elemm_u0
 Let n = |expr*|
 Return instr* ++ [(I32.CONST 0), (I32.CONST n), (TABLE.INIT x i), (ELEM.DROP i)]
}

rundata (DATA byte* datam_u0) i = {
 If ((datam_u0 == PASSIVE)) {
   Return []
 }
 Assert(case(datam_u0) == ACTIVE)
 Let (ACTIVE y_0 instr*) = datam_u0
 Assert((y_0 == 0))
 Let n = |byte*|
 Return instr* ++ [(I32.CONST 0), (I32.CONST n), (MEMORY.INIT i), (DATA.DROP i)]
}

instantiate module externval* = {
 Assert(case(module) == MODULE)
 Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) = module
 Let (TYPE functype)* = type*
 Let n_D = |data*|
 Let n_E = |elem*|
 Let n_F = |func*|
 Let (START x)? = start?
 Let (GLOBAL globaltype expr_G)* = global*
 Let (ELEM reftype expr_E* elemmode)* = elem*
 Let instr_D* = $concat_($rundata(data*[j], j)^(j<n_D))
 Let instr_E* = $concat_($runelem(elem*[i], i)^(i<n_E))
 Let moduleinst_init = { TYPES: functype*; FUNCS: $funcs(externval*) ++ (|s.FUNCS| + i_F)^(i_F<n_F); GLOBALS: $globals(externval*); TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }
 Let f_init = { LOCALS: []; MODULE: moduleinst_init; }
 Let z = f_init
 Push(callframe(z))
 Let [val]* = $eval_expr(expr_G)*
 Pop(callframe(z))
 Push(callframe(z))
 Let [ref]** = $eval_expr(expr_E)**
 Pop(callframe(z))
 Let moduleinst = $allocmodule(module, externval*, val*, ref**)
 Let f = { LOCALS: []; MODULE: moduleinst; }
 Push(callframe(0, f))
 Execute instr_E*
 Execute instr_D*
 If ((CALL x)? != None) {
   Let ?(instr_0) = (CALL x)?
   Execute instr_0
 }
 Pop(callframe(0, f))
 Return f.MODULE
}

invoke fa val^n = {
 Let f = { LOCALS: []; MODULE: { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }; }
 Let (t_1^n -> t_2*) = $funcinst()[fa].TYPE
 Let k = |t_2*|
 Push(callframe(k, f))
 Push(val^n)
 Execute (CALL_ADDR fa)
 Pop_all(val*)
 Pop(callframe(k, f))
 Push(val*)
 Pop(val^k)
 Return val^k
}

execution_of_UNREACHABLE = {
 Trap
}

execution_of_NOP = {
 Nop
}

execution_of_DROP = {
 Assert(top_value())
 Pop(val)
 Nop
}

execution_of_SELECT t*? = {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 Assert(top_value())
 Pop(val_2)
 Assert(top_value())
 Pop(val_1)
 If ((c != 0)) {
   Push(val_1)
 }
 Else {
   Push(val_2)
 }
}

execution_of_IF bt instr_1* instr_2* = {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 If ((c != 0)) {
   Execute (BLOCK bt instr_1*)
 }
 Else {
   Execute (BLOCK bt instr_2*)
 }
}

execution_of_LABEL_ = {
 Pop_all(val*)
 Assert(top_label())
 Pop(current_label())
 Push(val*)
}

execution_of_BR n_u0 = {
 Pop_all(val*)
 Let L = current_label()
 Let n = arity(L)
 Let instr'* = cont(L)
 Pop(current_label())
 Let admin_u1* = val*
 If (((n_u0 == 0) && (|admin_u1*| ≥ n))) {
   Let val'* ++ val^n = admin_u1*
   Push(val^n)
   Execute instr'*
 }
 If ((n_u0 ≥ 1)) {
   Let l = (n_u0 - 1)
   Let val* = admin_u1*
   Push(val*)
   Execute (BR l)
 }
}

execution_of_BR_IF l = {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 If ((c != 0)) {
   Execute (BR l)
 }
 Else {
   Nop
 }
}

execution_of_BR_TABLE l* l' = {
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i < |l*|)) {
   Execute (BR l*[i])
 }
 Else {
   Execute (BR l')
 }
}

execution_of_FRAME_ = {
 Let f = current_frame()
 Let n = arity(f)
 Assert(top_values(n))
 Pop(val^n)
 Assert(top_frame())
 Pop(current_frame())
 Push(val^n)
}

execution_of_RETURN = {
 Pop_all(val*)
 If (top_frame()) {
   Let F = current_frame()
   Let n = arity(F)
   Pop(current_frame())
   Let val'* ++ val^n = val*
   Push(val^n)
 }
 Else if (top_label()) {
   Pop(current_label())
   Push(val*)
   Execute RETURN
 }
}

execution_of_TRAP = {
 YetI: TODO: It is likely that the value stack of two rules are different.
}

execution_of_UNOP nt unop = {
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 If ((|$unop(nt, unop, c_1)| == 1)) {
   Let [c] = $unop(nt, unop, c_1)
   Push((nt.CONST c))
 }
 If (($unop(nt, unop, c_1) == [])) {
   Trap
 }
}

execution_of_BINOP nt binop = {
 Assert(top_value(nt))
 Pop((nt.CONST c_2))
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 If ((|$binop(nt, binop, c_1, c_2)| == 1)) {
   Let [c] = $binop(nt, binop, c_1, c_2)
   Push((nt.CONST c))
 }
 If (($binop(nt, binop, c_1, c_2) == [])) {
   Trap
 }
}

execution_of_TESTOP nt testop = {
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 Let c = $testop(nt, testop, c_1)
 Push((I32.CONST c))
}

execution_of_RELOP nt relop = {
 Assert(top_value(nt))
 Pop((nt.CONST c_2))
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 Let c = $relop(nt, relop, c_1, c_2)
 Push((I32.CONST c))
}

execution_of_CVTOP nt_2 nt_1 cvtop = {
 Assert(top_value(nt_1))
 Pop((nt_1.CONST c_1))
 If ((|$cvtop(nt_1, nt_2, cvtop, c_1)| == 1)) {
   Let [c] = $cvtop(nt_1, nt_2, cvtop, c_1)
   Push((nt_2.CONST c))
 }
 If (($cvtop(nt_1, nt_2, cvtop, c_1) == [])) {
   Trap
 }
}

execution_of_REF.IS_NULL = {
 Assert(top_value())
 Pop(ref)
 If (case(ref) == REF.NULL) {
   Push((I32.CONST 1))
 }
 Else {
   Push((I32.CONST 0))
 }
}

execution_of_VVUNOP V128 vvunop = {
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vvunop(V128, vvunop, c_1)
 Push((V128.CONST c))
}

execution_of_VVBINOP V128 vvbinop = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vvbinop(V128, vvbinop, c_1, c_2)
 Push((V128.CONST c))
}

execution_of_VVTERNOP V128 vvternop = {
 Assert(top_value())
 Pop((V128.CONST c_3))
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vvternop(V128, vvternop, c_1, c_2, c_3)
 Push((V128.CONST c))
}

execution_of_VVTESTOP V128 ANY_TRUE = {
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $ine($size(V128), c_1, 0)
 Push((I32.CONST c))
}

execution_of_VUNOP sh vunop = {
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vunop(sh, vunop, c_1)
 Push((V128.CONST c))
}

execution_of_VBINOP sh vbinop = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 If ((|$vbinop(sh, vbinop, c_1, c_2)| == 1)) {
   Let [c] = $vbinop(sh, vbinop, c_1, c_2)
   Push((V128.CONST c))
 }
 If (($vbinop(sh, vbinop, c_1, c_2) == [])) {
   Trap
 }
}

execution_of_VTESTOP (Jnn X N) ALL_TRUE = {
 Assert(top_value())
 Pop((V128.CONST c))
 Let ci_1* = $lanes_((Jnn X N), c)
 If ((ci_1 != 0)*) {
   Push((I32.CONST 1))
 }
 Else {
   Push((I32.CONST 0))
 }
}

execution_of_VRELOP sh vrelop = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vrelop(sh, vrelop, c_1, c_2)
 Push((V128.CONST c))
}

execution_of_VSHIFTOP (Jnn X N) vshiftop = {
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c'* = $lanes_((Jnn X N), c_1)
 Let c = $invlanes_((Jnn X N), $vshiftop((Jnn X N), vshiftop, c', n)*)
 Push((V128.CONST c))
}

execution_of_VBITMASK (Jnn X N) = {
 Assert(top_value())
 Pop((V128.CONST c))
 Let ci_1* = $lanes_((Jnn X N), c)
 Let ci = $inverse_of_ibits(32, $ilt($lsize(Jnn), S, ci_1, 0)*)
 Push((I32.CONST ci))
}

execution_of_VSWIZZLE (Pnn X N) = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c* = $lanes_((Pnn X N), c_1) ++ 0^(256 - N)
 Let ci* = $lanes_((Pnn X N), c_2)
 Assert((ci*[k] < |c*|)^(k<N))
 Assert((k < |ci*|)^(k<N))
 Let c' = $invlanes_((Pnn X N), c*[ci*[k]]^(k<N))
 Push((V128.CONST c'))
}

execution_of_VSHUFFLE (Pnn X N) i* = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Assert((k < |i*|)^(k<N))
 Let c'* = $lanes_((Pnn X N), c_1) ++ $lanes_((Pnn X N), c_2)
 Assert((i*[k] < |c'*|)^(k<N))
 Let c = $invlanes_((Pnn X N), c'*[i*[k]]^(k<N))
 Push((V128.CONST c))
}

execution_of_VSPLAT (Lnn X N) = {
 Assert(top_value($unpack(Lnn)))
 Pop((nt_0.CONST c_1))
 Let c = $invlanes_((Lnn X N), $packnum(Lnn, c_1)^N)
 Push((V128.CONST c))
}

execution_of_VEXTRACT_LANE (lanet_u0 X N) sx_u1? i = {
 Assert(top_value())
 Pop((V128.CONST c_1))
 If ((!(sx_u1? != None) && type(lanet_u0) == numtype)) {
   Let nt = lanet_u0
   If ((i < |$lanes_((nt X N), c_1)|)) {
     Let c_2 = $lanes_((nt X N), c_1)[i]
     Push((nt.CONST c_2))
   }
 }
 If (type(lanet_u0) == packtype) {
   Let pt = lanet_u0
   If (sx_u1? != None) {
     Let ?(sx) = sx_u1?
     If ((i < |$lanes_((pt X N), c_1)|)) {
       Let c_2 = $ext($psize(pt), 32, sx, $lanes_((pt X N), c_1)[i])
       Push((I32.CONST c_2))
     }
   }
 }
}

execution_of_VREPLACE_LANE (Lnn X N) i = {
 Assert(top_value($unpack(Lnn)))
 Pop((nt_0.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $invlanes_((Lnn X N), update($lanes_((Lnn X N), c_1)[i], $packnum(Lnn, c_2)))
 Push((V128.CONST c))
}

execution_of_VEXTUNOP sh_1 sh_2 vextunop sx = {
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vextunop(sh_1, sh_2, vextunop, sx, c_1)
 Push((V128.CONST c))
}

execution_of_VEXTBINOP sh_1 sh_2 vextbinop sx = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vextbinop(sh_1, sh_2, vextbinop, sx, c_1, c_2)
 Push((V128.CONST c))
}

execution_of_VNARROW (Jnn_2 X N_2) (Jnn_1 X N_1) sx = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let ci_1* = $lanes_((Jnn_1 X N_1), c_1)
 Let ci_2* = $lanes_((Jnn_1 X N_1), c_2)
 Let cj_1* = $narrow($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_1)*
 Let cj_2* = $narrow($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_2)*
 Let c = $invlanes_((Jnn_2 X N_2), cj_1* ++ cj_2*)
 Push((V128.CONST c))
}

execution_of_VCVTOP (lanet_u2 X N_2) (lanet_u3 X N_1) vcvtop half_u0? sx_u1? zero_u4? = {
 Assert(top_value())
 Pop((V128.CONST c_1))
 If ((!(half_u0? != None) && !(zero_u4? != None))) {
   Let Lnn_1 = lanet_u3
   Let Lnn_2 = lanet_u2
   If (sx_u1? != None) {
     Let ?(sx) = sx_u1?
     Let c'* = $lanes_((Lnn_1 X N_1), c_1)
     Let c = $invlanes_((Lnn_2 X N_2), $vcvtop((Lnn_1 X N_1), (Lnn_2 X N_2), vcvtop, ?(sx), c')*)
     Push((V128.CONST c))
   }
 }
 If (!(zero_u4? != None)) {
   Let Lnn_1 = lanet_u3
   Let Lnn_2 = lanet_u2
   If (half_u0? != None) {
     Let ?(hf) = half_u0?
     Let sx? = sx_u1?
     Let ci* = $lanes_((Lnn_1 X N_1), c_1)[$halfop(hf, 0, N_2) : N_2]
     Let c = $invlanes_((Lnn_2 X N_2), $vcvtop((Lnn_1 X N_1), (Lnn_2 X N_2), vcvtop, sx?, ci)*)
     Push((V128.CONST c))
   }
 }
 If ((!(half_u0? != None) && ((zero_u4? == ?(ZERO)) && type(lanet_u3) == numtype))) {
   Let nt_1 = lanet_u3
   If (type(lanet_u2) == numtype) {
     Let nt_2 = lanet_u2
     Let sx? = sx_u1?
     Let ci* = $lanes_((nt_1 X N_1), c_1)
     Let c = $invlanes_((nt_2 X N_2), $vcvtop((nt_1 X N_1), (nt_2 X N_2), vcvtop, sx?, ci)* ++ $zero(nt_2)^N_1)
     Push((V128.CONST c))
   }
 }
}

execution_of_LOCAL.TEE x = {
 Assert(top_value())
 Pop(val)
 Push(val)
 Push(val)
 Execute (LOCAL.SET x)
}

execution_of_BLOCK bt instr* = {
 Let z = current_state()
 Let (t_1^k -> t_2^n) = $blocktype(z, bt)
 Assert(top_values(k))
 Pop(val^k)
 Let L = label(n, [])
 Enter (val^k ++ instr*, L) {
 }
}

execution_of_LOOP bt instr* = {
 Let z = current_state()
 Let (t_1^k -> t_2^n) = $blocktype(z, bt)
 Assert(top_values(k))
 Pop(val^k)
 Let L = label(k, [(LOOP bt instr*)])
 Enter (val^k ++ instr*, L) {
 }
}

execution_of_CALL x = {
 Let z = current_state()
 Assert((x < |$funcaddr(z)|))
 Execute (CALL_ADDR $funcaddr(z)[x])
}

execution_of_CALL_INDIRECT x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i ≥ |$table(z, x).REFS|)) {
   Trap
 }
 If (!(case($table(z, x).REFS[i]) == REF.FUNC_ADDR)) {
   Trap
 }
 Let (REF.FUNC_ADDR a) = $table(z, x).REFS[i]
 If ((a ≥ |$funcinst(z)|)) {
   Trap
 }
 If (($type(z, y) != $funcinst(z)[a].TYPE)) {
   Trap
 }
 Execute (CALL_ADDR a)
}

execution_of_CALL_ADDR a = {
 Let z = current_state()
 Assert((a < |$funcinst(z)|))
 Let { TYPE: (t_1^k -> t_2^n); MODULE: mm; CODE: func; } = $funcinst(z)[a]
 Assert(top_values(k))
 Pop(val^k)
 Assert(case(func) == FUNC)
 Let (FUNC x y_0 instr*) = func
 Let (LOCAL t)* = y_0
 Let f = { LOCALS: val^k ++ $default_(t)*; MODULE: mm; }
 Let F = callframe(n, f)
 Push(F)
 Let L = label(n, [])
 Enter (instr*, L) {
 }
}

execution_of_REF.FUNC x = {
 Let z = current_state()
 Assert((x < |$funcaddr(z)|))
 Push((REF.FUNC_ADDR $funcaddr(z)[x]))
}

execution_of_LOCAL.GET x = {
 Let z = current_state()
 Push($local(z, x))
}

execution_of_GLOBAL.GET x = {
 Let z = current_state()
 Push($global(z, x).VALUE)
}

execution_of_TABLE.GET x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i ≥ |$table(z, x).REFS|)) {
   Trap
 }
 Push($table(z, x).REFS[i])
}

execution_of_TABLE.SIZE x = {
 Let z = current_state()
 Let n = |$table(z, x).REFS|
 Push((I32.CONST n))
}

execution_of_TABLE.FILL x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(val)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((i + n) > |$table(z, x).REFS|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   Push((I32.CONST i))
   Push(val)
   Execute (TABLE.SET x)
   Push((I32.CONST (i + 1)))
   Push(val)
   Push((I32.CONST (n - 1)))
   Execute (TABLE.FILL x)
 }
}

execution_of_TABLE.COPY x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$table(z, y).REFS|)) {
   Trap
 }
 If (((j + n) > |$table(z, x).REFS|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   If ((j ≤ i)) {
     Push((I32.CONST j))
     Push((I32.CONST i))
     Execute (TABLE.GET y)
     Execute (TABLE.SET x)
     Push((I32.CONST (j + 1)))
     Push((I32.CONST (i + 1)))
   }
   Else {
     Push((I32.CONST ((j + n) - 1)))
     Push((I32.CONST ((i + n) - 1)))
     Execute (TABLE.GET y)
     Execute (TABLE.SET x)
     Push((I32.CONST j))
     Push((I32.CONST i))
   }
   Push((I32.CONST (n - 1)))
   Execute (TABLE.COPY x y)
 }
}

execution_of_TABLE.INIT x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$elem(z, y).REFS|)) {
   Trap
 }
 If (((j + n) > |$table(z, x).REFS|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else if ((i < |$elem(z, y).REFS|)) {
   Push((I32.CONST j))
   Push($elem(z, y).REFS[i])
   Execute (TABLE.SET x)
   Push((I32.CONST (j + 1)))
   Push((I32.CONST (i + 1)))
   Push((I32.CONST (n - 1)))
   Execute (TABLE.INIT x y)
 }
}

execution_of_LOAD numty_u0 sz_sx_u1? ao = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (!(sz_sx_u1? != None)) {
   Let nt = numty_u0
   If ((((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, 0).BYTES|)) {
     Trap
   }
   Let c = $inverse_of_nbytes(nt, $mem(z, 0).BYTES[(i + ao.OFFSET) : ($size(nt) / 8)])
   Push((nt.CONST c))
 }
 If (type(numty_u0) == Inn) {
   If (sz_sx_u1? != None) {
     Let ?(y_0) = sz_sx_u1?
     Let (n, sx) = y_0
     If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|)) {
       Trap
     }
   }
   Let Inn = numty_u0
   If (sz_sx_u1? != None) {
     Let ?(y_0) = sz_sx_u1?
     Let (n, sx) = y_0
     Let c = $inverse_of_ibytes(n, $mem(z, 0).BYTES[(i + ao.OFFSET) : (n / 8)])
     Push((Inn.CONST $ext(n, $size(Inn), sx, c)))
   }
 }
}

execution_of_VLOAD V128 vload_u0? ao = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((((i + ao.OFFSET) + ($size(V128) / 8)) > |$mem(z, 0).BYTES|) && !(vload_u0? != None))) {
   Trap
 }
 If (!(vload_u0? != None)) {
   Let c = $inverse_of_vbytes(V128, $mem(z, 0).BYTES[(i + ao.OFFSET) : ($size(V128) / 8)])
   Push((V128.CONST c))
 }
 Else {
   Let ?(y_0) = vload_u0?
   If (case(y_0) == SHAPE) {
     Let (SHAPE M N sx) = y_0
     If ((((i + ao.OFFSET) + ((M · N) / 8)) > |$mem(z, 0).BYTES|)) {
       Trap
     }
     If (type($inverse_of_lsize((M · 2))) == Jnn) {
       Let Jnn = $inverse_of_lsize((M · 2))
       Let j^N = $inverse_of_ibytes(M, $mem(z, 0).BYTES[((i + ao.OFFSET) + ((k · M) / 8)) : (M / 8)])^(k<N)
       Let c = $invlanes_((Jnn X N), $ext(M, $lsize(Jnn), sx, j)^N)
       Push((V128.CONST c))
     }
   }
   If (case(y_0) == SPLAT) {
     Let (SPLAT N) = y_0
     If ((((i + ao.OFFSET) + (N / 8)) > |$mem(z, 0).BYTES|)) {
       Trap
     }
     Let M = (128 / N)
     If (type($inverse_of_lsize(N)) == Jnn) {
       Let Jnn = $inverse_of_lsize(N)
       Let j = $inverse_of_ibytes(N, $mem(z, 0).BYTES[(i + ao.OFFSET) : (N / 8)])
       Let c = $invlanes_((Jnn X M), j^M)
       Push((V128.CONST c))
     }
   }
   If (case(y_0) == ZERO) {
     Let (ZERO N) = y_0
     If ((((i + ao.OFFSET) + (N / 8)) > |$mem(z, 0).BYTES|)) {
       Trap
     }
     Let j = $inverse_of_ibytes(N, $mem(z, 0).BYTES[(i + ao.OFFSET) : (N / 8)])
     Let c = $ext(N, 128, U, j)
     Push((V128.CONST c))
   }
 }
}

execution_of_VLOAD_LANE V128 N ao j = {
 Let z = current_state()
 Assert(top_value())
 Pop((V128.CONST c_1))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((((i + ao.OFFSET) + (N / 8)) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 Let M = (128 / N)
 If (type($inverse_of_lsize(N)) == Jnn) {
   Let Jnn = $inverse_of_lsize(N)
   Let k = $inverse_of_ibytes(N, $mem(z, 0).BYTES[(i + ao.OFFSET) : (N / 8)])
   Let c = $invlanes_((Jnn X M), update($lanes_((Jnn X M), c_1)[j], k))
   Push((V128.CONST c))
 }
}

execution_of_MEMORY.SIZE = {
 Let z = current_state()
 Let ((n · 64) · $Ki()) = |$mem(z, 0).BYTES|
 Push((I32.CONST n))
}

execution_of_MEMORY.FILL = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(val)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((i + n) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   Push((I32.CONST i))
   Push(val)
   Execute (STORE I32 ?(8) $memarg0())
   Push((I32.CONST (i + 1)))
   Push(val)
   Push((I32.CONST (n - 1)))
   Execute MEMORY.FILL
 }
}

execution_of_MEMORY.COPY = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 If (((j + n) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   If ((j ≤ i)) {
     Push((I32.CONST j))
     Push((I32.CONST i))
     Execute (LOAD I32 ?((8, U)) $memarg0())
     Execute (STORE I32 ?(8) $memarg0())
     Push((I32.CONST (j + 1)))
     Push((I32.CONST (i + 1)))
   }
   Else {
     Push((I32.CONST ((j + n) - 1)))
     Push((I32.CONST ((i + n) - 1)))
     Execute (LOAD I32 ?((8, U)) $memarg0())
     Execute (STORE I32 ?(8) $memarg0())
     Push((I32.CONST j))
     Push((I32.CONST i))
   }
   Push((I32.CONST (n - 1)))
   Execute MEMORY.COPY
 }
}

execution_of_MEMORY.INIT x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$data(z, x).BYTES|)) {
   Trap
 }
 If (((j + n) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else if ((i < |$data(z, x).BYTES|)) {
   Push((I32.CONST j))
   Push((I32.CONST $data(z, x).BYTES[i]))
   Execute (STORE I32 ?(8) $memarg0())
   Push((I32.CONST (j + 1)))
   Push((I32.CONST (i + 1)))
   Push((I32.CONST (n - 1)))
   Execute (MEMORY.INIT x)
 }
}

execution_of_CTXT = {
 Pop_all(val*)
 YetI: TODO: translate_context.
 If (case(admin_u1) == LABEL_) {
   Let (LABEL_ n instr_0* instr*) = admin_u1
   YetI: TODO: translate_rulepr Step.
   Let L = label(n, instr_0*)
   Enter (instr'*, L) {
   }
 }
 YetI: TODO: translate_rulepr Step.
 If (case(admin_u1) == FRAME_) {
   Let (FRAME_ n y_0 instr*) = admin_u1
   If ((y_0 == f')) {
     Execute (FRAME_ n f' instr'*)
   }
 }
}

execution_of_LOCAL.SET x = {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 $with_local(z, x, val)
}

execution_of_GLOBAL.SET x = {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 $with_global(z, x, val)
}

execution_of_TABLE.SET x = {
 Let z = current_state()
 Assert(top_value())
 Pop(ref)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i ≥ |$table(z, x).REFS|)) {
   Trap
 }
 $with_table(z, x, i, ref)
}

execution_of_TABLE.GROW x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(ref)
 Either {
   Let ti = $growtable($table(z, x), n, ref)
   Push((I32.CONST |$table(z, x).REFS|))
   $with_tableinst(z, x, ti)
 }
 Or {
   Push((I32.CONST $invsigned(32, -(1))))
 }
}

execution_of_ELEM.DROP x = {
 Let z = current_state()
 $with_elem(z, x, [])
}

execution_of_STORE numty_u1 sz_u2? ao = {
 Let z = current_state()
 Assert(top_value(numty_u0))
 Pop((numty_u0.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (!(sz_u2? != None)) {
   Let nt = numty_u1
   If (((((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, 0).BYTES|) && (numty_u0 == nt))) {
     Trap
   }
   If ((numty_u0 == nt)) {
     Let b* = $nbytes(nt, c)
     $with_mem(z, 0, (i + ao.OFFSET), ($size(nt) / 8), b*)
   }
 }
 Else {
   Let ?(n) = sz_u2?
   If (type(numty_u1) == Inn) {
     Let Inn = numty_u1
     If (((((i + ao.OFFSET) + (n / 8)) > |$mem(z, 0).BYTES|) && (numty_u0 == Inn))) {
       Trap
     }
     If ((numty_u0 == Inn)) {
       Let b* = $ibytes(n, $wrap($size(Inn), n, c))
       $with_mem(z, 0, (i + ao.OFFSET), (n / 8), b*)
     }
   }
 }
}

execution_of_VSTORE V128 ao = {
 Let z = current_state()
 Assert(top_value())
 Pop((V128.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((((i + ao.OFFSET) + ($size(V128) / 8)) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 Let b* = $vbytes(V128, c)
 $with_mem(z, 0, (i + ao.OFFSET), ($size(V128) / 8), b*)
}

execution_of_VSTORE_LANE V128 N ao j = {
 Let z = current_state()
 Assert(top_value())
 Pop((V128.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((((i + ao.OFFSET) + N) > |$mem(z, 0).BYTES|)) {
   Trap
 }
 Let M = (128 / N)
 If (type($inverse_of_lsize(N)) == Jnn) {
   Let Jnn = $inverse_of_lsize(N)
   If ((j < |$lanes_((Jnn X M), c)|)) {
     Let b* = $ibytes(N, $lanes_((Jnn X M), c)[j])
     $with_mem(z, 0, (i + ao.OFFSET), (N / 8), b*)
   }
 }
}

execution_of_MEMORY.GROW = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Either {
   Let mi = $growmemory($mem(z, 0), n)
   Push((I32.CONST (|$mem(z, 0).BYTES| / (64 · $Ki()))))
   $with_meminst(z, 0, mi)
 }
 Or {
   Push((I32.CONST $invsigned(32, -(1))))
 }
}

execution_of_DATA.DROP x = {
 Let z = current_state()
 $with_data(z, x, [])
}

eval_expr instr* = {
 Execute instr*
 Pop(val)
 Return [val]
}

group_bytes_by n byte* = {
 Let n' = |byte*|
 If ((n' ≥ n)) {
   Return [byte*[0 : n]] ++ $group_bytes_by(n, byte*[n : (n' - n)])
 }
 Return []
}

execution_of_ARRAY.NEW_DATA x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (case($expanddt($type(z, x))) == ARRAY) {
   Let (ARRAY y_0) = $expanddt($type(z, x))
   Let (mut, zt) = y_0
   If (((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|)) {
     Trap
   }
   Let cnn = $cunpack(zt)
   Let b* = $data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)]
   Let gb* = $group_bytes_by(($zsize(zt) / 8), b*)
   Let c^n = $inverse_of_ibytes($zsize(zt), gb)*
   Push((cnn.CONST c)^n)
   Execute (ARRAY.NEW_FIXED x n)
 }
}
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
8-reduction.watsup:227.12-227.36: translate_rulepr: Yet `(`%;%`_config(z, instr*{instr : instr}), `%;%`_config(z', instr'*{instr' : instr}))`
8-reduction.watsup:231.12-231.44: translate_rulepr: Yet `(`%;%`_config(`%;%`_state(s, f'), instr*{instr : instr}), `%;%`_config(`%;%`_state(s', f'), instr'*{instr' : instr}))`
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
- Under the context prepend(C.LABELS, [t_2*]), instr* must be valid with type (t_1* ->_ x* ++ t_2*).
- Under the context C, bt must be valid with type (t_1* ->_ [] ++ t_2*).
- The instruction is valid with type (t_1* ->_ [] ++ t_2*).

validation_of_LOOP bt instr*
- Under the context prepend(C.LABELS, [t_1*]), instr* must be valid with type (t_1* ->_ x* ++ t_2*).
- Under the context C, bt must be valid with type (t_1* ->_ [] ++ t_2*).
- The instruction is valid with type (t_1* ->_ [] ++ t_2*).

validation_of_IF bt instr_1* instr_2*
- Under the context prepend(C.LABELS, [t_2*]), instr_1* must be valid with type (t_1* ->_ x_1* ++ t_2*).
- Under the context C, bt must be valid with type (t_1* ->_ [] ++ t_2*).
- Under the context prepend(C.LABELS, [t_2*]), instr_2* must be valid with type (t_1* ->_ x_2* ++ t_2*).
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
- ((zt == $unpack(zt))) if and only if ((sx? == ?())).
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
- ((zt == $unpack(zt))) if and only if ((sx? == ?())).
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

validation_of_VEXTUNOP sh_1 sh_2 vextunop sx
- The instruction is valid with type ([V128] ->_ [] ++ [V128]).

validation_of_VEXTBINOP sh_1 sh_2 vextbinop sx
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

Ki = {
 Return 1024
}

min n_u0 n_u1 = {
 If ((n_u0 == 0)) {
   Return 0
 }
 If ((n_u1 == 0)) {
   Return 0
 }
 Assert((n_u0 ≥ 1))
 Let i = (n_u0 - 1)
 Assert((n_u1 ≥ 1))
 Let j = (n_u1 - 1)
 Return $min(i, j)
}

sum n_u0* = {
 If ((n_u0* == [])) {
   Return 0
 }
 Let [n] ++ n'* = n_u0*
 Return (n + $sum(n'*))
}

concat_ X_u0* = {
 If ((X_u0* == [])) {
   Return []
 }
 Let [w*] ++ w'** = X_u0*
 Return w* ++ $concat_(w'**)
}

disjoint_ X_u0* = {
 If ((X_u0* == [])) {
   Return true
 }
 Let [w] ++ w'* = X_u0*
 Return (!(w <- w'*) && $disjoint_(w'*))
}

signif N_u0 = {
 If ((N_u0 == 32)) {
   Return 23
 }
 Assert((N_u0 == 64))
 Return 52
}

expon N_u0 = {
 If ((N_u0 == 32)) {
   Return 8
 }
 Assert((N_u0 == 64))
 Return 11
}

M N = {
 Return $signif(N)
}

E N = {
 Return $expon(N)
}

fzero N = {
 Return (POS (SUBNORM 0))
}

fone N = {
 Return (POS (NORM 1 0))
}

canon_ N = {
 Return (2 ^ ($signif(N) - 1))
}

cont b = {
 Assert((128 < b))
 Assert((b < 192))
 Return (b - 128)
}

utf8 char_u0* = {
 Let ch* = char_u0*
 Return $concat_($utf8([ch])*)
 Assert((|char_u0*| == 1))
 Let [ch] = char_u0*
 If ((ch < 128)) {
   Let b = ch
   Return [b]
 }
 If (((128 ≤ ch) && ((ch < 2048) && (ch ≥ $cont(b_2))))) {
   Let ((2 ^ 6) · (b_1 - 192)) = (ch - $cont(b_2))
   Return [b_1, b_2]
 }
 If (((((2048 ≤ ch) && (ch < 55296)) || ((57344 ≤ ch) && (ch < 65536))) && (ch ≥ $cont(b_3)))) {
   Let (((2 ^ 12) · (b_1 - 224)) + ((2 ^ 6) · $cont(b_2))) = (ch - $cont(b_3))
   Return [b_1, b_2, b_3]
 }
 Assert((65536 ≤ ch))
 Assert((ch < 69632))
 Assert((ch ≥ $cont(b_4)))
 Let ((((2 ^ 18) · (b_1 - 240)) + ((2 ^ 12) · $cont(b_2))) + ((2 ^ 6) · $cont(b_3))) = (ch - $cont(b_4))
 Return [b_1, b_2, b_3, b_4]
}

ANYREF = {
 Return (REF (NULL ?(())) ANY)
}

EQREF = {
 Return (REF (NULL ?(())) EQ)
}

I31REF = {
 Return (REF (NULL ?(())) I31)
}

STRUCTREF = {
 Return (REF (NULL ?(())) STRUCT)
}

ARRAYREF = {
 Return (REF (NULL ?(())) ARRAY)
}

FUNCREF = {
 Return (REF (NULL ?(())) FUNC)
}

EXTERNREF = {
 Return (REF (NULL ?(())) EXTERN)
}

NULLREF = {
 Return (REF (NULL ?(())) NONE)
}

NULLFUNCREF = {
 Return (REF (NULL ?(())) NOFUNC)
}

NULLEXTERNREF = {
 Return (REF (NULL ?(())) NOEXTERN)
}

size numty_u0 = {
 If ((numty_u0 == I32)) {
   Return 32
 }
 If ((numty_u0 == I64)) {
   Return 64
 }
 If ((numty_u0 == F32)) {
   Return 32
 }
 Assert((numty_u0 == F64))
 Return 64
}

isize Inn = {
 Return $size(Inn)
}

vsize V128 = {
 Return 128
}

psize packt_u0 = {
 If ((packt_u0 == I8)) {
   Return 8
 }
 Assert((packt_u0 == I16))
 Return 16
}

lsize lanet_u0 = {
 If (type(lanet_u0) == numtype) {
   Let numtype = lanet_u0
   Return $size(numtype)
 }
 Assert(type(lanet_u0) == packtype)
 Let packtype = lanet_u0
 Return $psize(packtype)
}

zsize stora_u0 = {
 If (type(stora_u0) == numtype) {
   Let numtype = stora_u0
   Return $size(numtype)
 }
 If (type(stora_u0) == vectype) {
   Let vectype = stora_u0
   Return $vsize(vectype)
 }
 Assert(type(stora_u0) == packtype)
 Let packtype = stora_u0
 Return $psize(packtype)
}

lanetype (Lnn X N) = {
 Return Lnn
}

sizenn nt = {
 Return $size(nt)
}

sizenn1 nt = {
 Return $size(nt)
}

sizenn2 nt = {
 Return $size(nt)
}

psizenn pt = {
 Return $psize(pt)
}

lsizenn lt = {
 Return $lsize(lt)
}

lsizenn1 lt = {
 Return $lsize(lt)
}

lsizenn2 lt = {
 Return $lsize(lt)
}

zero numty_u0 = {
 If (type(numty_u0) == Inn) {
   Return 0
 }
 Assert(type(numty_u0) == Fnn)
 Let Fnn = numty_u0
 Return $fzero($size(Fnn))
}

dim (Lnn X N) = {
 Return N
}

shsize (Lnn X N) = {
 Return ($lsize(Lnn) · N)
}

setminus1 x idx_u0* = {
 If ((idx_u0* == [])) {
   Return [x]
 }
 Let [y_1] ++ y* = idx_u0*
 If ((x == y_1)) {
   Return []
 }
 Let [y_1] ++ y* = idx_u0*
 Return $setminus1(x, y*)
}

setminus idx_u0* y* = {
 If ((idx_u0* == [])) {
   Return []
 }
 Let [x_1] ++ x* = idx_u0*
 Return $setminus1(x_1, y*) ++ $setminus(x*, y*)
}

IN N_u0 = {
 If ((N_u0 == 32)) {
   Return I32
 }
 Assert((N_u0 == 64))
 Return I64
}

FN N_u0 = {
 If ((N_u0 == 32)) {
   Return F32
 }
 Assert((N_u0 == 64))
 Return F64
}

JN N_u0 = {
 If ((N_u0 == 8)) {
   Return I8
 }
 If ((N_u0 == 16)) {
   Return I16
 }
 If ((N_u0 == 32)) {
   Return I32
 }
 Assert((N_u0 == 64))
 Return I64
}

lunpack lanet_u0 = {
 If (type(lanet_u0) == numtype) {
   Let numtype = lanet_u0
   Return numtype
 }
 Assert(type(lanet_u0) == packtype)
 Return I32
}

unpack stora_u0 = {
 If (type(stora_u0) == valtype) {
   Let valtype = stora_u0
   Return valtype
 }
 Assert(type(stora_u0) == packtype)
 Return I32
}

nunpack stora_u0 = {
 If (type(stora_u0) == numtype) {
   Let numtype = stora_u0
   Return numtype
 }
 If (type(stora_u0) == packtype) {
   Return I32
 }
}

vunpack vectype = {
 Return vectype
}

cunpack stora_u0 = {
 If (type(stora_u0) == consttype) {
   Let consttype = stora_u0
   Return consttype
 }
 If (type(stora_u0) == packtype) {
   Return I32
 }
 If (type(stora_u0) == lanetype) {
   Let lanetype = stora_u0
   Return $lunpack(lanetype)
 }
}

sx stora_u0 = {
 If (type(stora_u0) == consttype) {
   Return ?()
 }
 Assert(type(stora_u0) == packtype)
 Return ?(S)
}

const const_u0 c = {
 If (type(const_u0) == numtype) {
   Let numtype = const_u0
   Return (numtype.CONST c)
 }
 Assert(type(const_u0) == vectype)
 Let vectype = const_u0
 Return (vectype.CONST c)
}

unpackshape (Lnn X N) = {
 Return $lunpack(Lnn)
}

diffrt (REF nul1 ht_1) (REF (NULL _u0?) ht_2) = {
 If ((_u0? == ?(()))) {
   Return (REF (NULL ?()) ht_1)
 }
 Assert(!(_u0? != None))
 Return (REF nul1 ht_1)
}

idx x = {
 Return (_IDX x)
}

free_opt free_u0? = {
 If (!(free_u0? != None)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 Let ?(free) = free_u0?
 Return free
}

free_list free_u0* = {
 If ((free_u0* == [])) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 Return YetE (free ++ $free_list(free'*{free' : free}))
}

free_typeidx typeidx = {
 Return { TYPES: [typeidx]; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_funcidx funcidx = {
 Return { TYPES: []; FUNCS: [funcidx]; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_globalidx globalidx = {
 Return { TYPES: []; FUNCS: []; GLOBALS: [globalidx]; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_tableidx tableidx = {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: [tableidx]; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_memidx memidx = {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: [memidx]; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_elemidx elemidx = {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: [elemidx]; DATAS: []; LOCALS: []; LABELS: []; }
}

free_dataidx dataidx = {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: [dataidx]; LOCALS: []; LABELS: []; }
}

free_localidx localidx = {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: [localidx]; LABELS: []; }
}

free_labelidx labelidx = {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: [labelidx]; }
}

free_externidx exter_u0 = {
 If (case(exter_u0) == FUNC) {
   Let (FUNC funcidx) = exter_u0
   Return $free_funcidx(funcidx)
 }
 If (case(exter_u0) == GLOBAL) {
   Let (GLOBAL globalidx) = exter_u0
   Return $free_globalidx(globalidx)
 }
 If (case(exter_u0) == TABLE) {
   Let (TABLE tableidx) = exter_u0
   Return $free_tableidx(tableidx)
 }
 Assert(case(exter_u0) == MEM)
 Let (MEM memidx) = exter_u0
 Return $free_memidx(memidx)
}

free_numtype numtype = {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_packtype packtype = {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_lanetype lanet_u0 = {
 If (type(lanet_u0) == numtype) {
   Let numtype = lanet_u0
   Return $free_numtype(numtype)
 }
 Assert(type(lanet_u0) == packtype)
 Let packtype = lanet_u0
 Return $free_packtype(packtype)
}

free_vectype vectype = {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_consttype const_u0 = {
 If (type(const_u0) == numtype) {
   Let numtype = const_u0
   Return $free_numtype(numtype)
 }
 Assert(type(const_u0) == vectype)
 Let vectype = const_u0
 Return $free_vectype(vectype)
}

free_absheaptype absheaptype = {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_rectype (REC subtype*) = {
 Return $free_list($free_subtype(subtype)*)
}

free_deftype (DEF rectype n) = {
 Return $free_rectype(rectype)
}

free_typeuse typeu_u0 = {
 If (case(typeu_u0) == _IDX) {
   Let (_IDX typeidx) = typeu_u0
   Return $free_typeidx(typeidx)
 }
 If (case(typeu_u0) == REC) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 Assert(type(typeu_u0) == deftype)
 Let deftype = typeu_u0
 Return $free_deftype(deftype)
}

free_heaptype heapt_u0 = {
 If (type(heapt_u0) == absheaptype) {
   Let absheaptype = heapt_u0
   Return $free_absheaptype(absheaptype)
 }
 Assert(type(heapt_u0) == typeuse)
 Let typeuse = heapt_u0
 Return $free_typeuse(typeuse)
}

free_reftype (REF nul heaptype) = {
 Return $free_heaptype(heaptype)
}

free_valtype valty_u0 = {
 If (type(valty_u0) == numtype) {
   Let numtype = valty_u0
   Return $free_numtype(numtype)
 }
 If (type(valty_u0) == vectype) {
   Let vectype = valty_u0
   Return $free_vectype(vectype)
 }
 If (type(valty_u0) == reftype) {
   Let reftype = valty_u0
   Return $free_reftype(reftype)
 }
 Assert((valty_u0 == BOT))
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_resulttype valtype* = {
 Return $free_list($free_valtype(valtype)*)
}

free_storagetype stora_u0 = {
 If (type(stora_u0) == valtype) {
   Let valtype = stora_u0
   Return $free_valtype(valtype)
 }
 Assert(type(stora_u0) == packtype)
 Let packtype = stora_u0
 Return $free_packtype(packtype)
}

free_fieldtype (mut, storagetype) = {
 Return $free_storagetype(storagetype)
}

free_functype (resulttype_1 -> resulttype_2) = {
 Return YetE ($free_resulttype(resulttype_1) ++ $free_resulttype(resulttype_2))
}

free_structtype fieldtype* = {
 Return $free_list($free_fieldtype(fieldtype)*)
}

free_arraytype fieldtype = {
 Return $free_fieldtype(fieldtype)
}

free_comptype compt_u0 = {
 If (case(compt_u0) == STRUCT) {
   Let (STRUCT structtype) = compt_u0
   Return $free_structtype(structtype)
 }
 If (case(compt_u0) == ARRAY) {
   Let (ARRAY arraytype) = compt_u0
   Return $free_arraytype(arraytype)
 }
 Assert(case(compt_u0) == FUNC)
 Let (FUNC functype) = compt_u0
 Return $free_functype(functype)
}

free_subtype (SUB fin typeuse* comptype) = {
 Return YetE ($free_list($free_typeuse(typeuse)*{typeuse : typeuse}) ++ $free_comptype(comptype))
}

free_globaltype (mut, valtype) = {
 Return $free_valtype(valtype)
}

free_tabletype (limits, reftype) = {
 Return $free_reftype(reftype)
}

free_memtype (PAGE limits) = {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_elemtype reftype = {
 Return $free_reftype(reftype)
}

free_datatype OK = {
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_externtype exter_u0 = {
 If (case(exter_u0) == FUNC) {
   Let (FUNC typeuse) = exter_u0
   Return $free_typeuse(typeuse)
 }
 If (case(exter_u0) == GLOBAL) {
   Let (GLOBAL globaltype) = exter_u0
   Return $free_globaltype(globaltype)
 }
 If (case(exter_u0) == TABLE) {
   Let (TABLE tabletype) = exter_u0
   Return $free_tabletype(tabletype)
 }
 Assert(case(exter_u0) == MEM)
 Let (MEM memtype) = exter_u0
 Return $free_memtype(memtype)
}

free_moduletype (externtype_1* -> externtype_2*) = {
 Return YetE ($free_list($free_externtype(externtype_1)*{externtype_1 : externtype}) ++ $free_list($free_externtype(externtype_2)*{externtype_2 : externtype}))
}

free_blocktype block_u0 = {
 If (case(block_u0) == _RESULT) {
   Let (_RESULT valtype?) = block_u0
   Return $free_opt($free_valtype(valtype)?)
 }
 Assert(case(block_u0) == _IDX)
 Let (_IDX funcidx) = block_u0
 Return $free_funcidx(funcidx)
}

free_shape (lanetype X dim) = {
 Return $free_lanetype(lanetype)
}

shift_labelidxs label_u0* = {
 If ((label_u0* == [])) {
   Return []
 }
 Let [y_0] ++ labelidx'* = label_u0*
 If ((y_0 == 0)) {
   Return $shift_labelidxs(labelidx'*)
 }
 Let [labelidx] ++ labelidx'* = label_u0*
 Return [(labelidx - 1)] ++ $shift_labelidxs(labelidx'*)
}

free_block instr* = {
 Let free = $free_list($free_instr(instr)*)
 Return update(free.LABELS, $shift_labelidxs(free.LABELS))
}

free_instr instr_u0 = {
 If ((instr_u0 == NOP)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If ((instr_u0 == UNREACHABLE)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If ((instr_u0 == DROP)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == SELECT) {
   Let (SELECT valtype*?) = instr_u0
   Return $free_opt($free_list($free_valtype(valtype)*)?)
 }
 If (case(instr_u0) == BLOCK) {
   Return YetE ($free_blocktype(blocktype) ++ $free_block(instr*{instr : instr}))
 }
 If (case(instr_u0) == LOOP) {
   Return YetE ($free_blocktype(blocktype) ++ $free_block(instr*{instr : instr}))
 }
 If (case(instr_u0) == IF) {
   Return YetE ($free_blocktype(blocktype) ++ $free_block(instr_1*{instr_1 : instr}) ++ $free_block(instr_2*{instr_2 : instr}))
 }
 If (case(instr_u0) == BR) {
   Let (BR labelidx) = instr_u0
   Return $free_labelidx(labelidx)
 }
 If (case(instr_u0) == BR_IF) {
   Let (BR_IF labelidx) = instr_u0
   Return $free_labelidx(labelidx)
 }
 If (case(instr_u0) == BR_TABLE) {
   Return YetE ($free_list($free_labelidx(labelidx)*{}) ++ $free_labelidx(labelidx))
 }
 If (case(instr_u0) == BR_ON_NULL) {
   Let (BR_ON_NULL labelidx) = instr_u0
   Return $free_labelidx(labelidx)
 }
 If (case(instr_u0) == BR_ON_NON_NULL) {
   Let (BR_ON_NON_NULL labelidx) = instr_u0
   Return $free_labelidx(labelidx)
 }
 If (case(instr_u0) == BR_ON_CAST) {
   Return YetE ($free_labelidx(labelidx) ++ $free_reftype(reftype_1) ++ $free_reftype(reftype_2))
 }
 If (case(instr_u0) == BR_ON_CAST_FAIL) {
   Return YetE ($free_labelidx(labelidx) ++ $free_reftype(reftype_1) ++ $free_reftype(reftype_2))
 }
 If (case(instr_u0) == CALL) {
   Let (CALL funcidx) = instr_u0
   Return $free_funcidx(funcidx)
 }
 If (case(instr_u0) == CALL_REF) {
   Let (CALL_REF typeuse) = instr_u0
   Return $free_typeuse(typeuse)
 }
 If (case(instr_u0) == CALL_INDIRECT) {
   Return YetE ($free_tableidx(tableidx) ++ $free_typeuse(typeuse))
 }
 If ((instr_u0 == RETURN)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == RETURN_CALL) {
   Let (RETURN_CALL funcidx) = instr_u0
   Return $free_funcidx(funcidx)
 }
 If (case(instr_u0) == RETURN_CALL_REF) {
   Let (RETURN_CALL_REF typeuse) = instr_u0
   Return $free_typeuse(typeuse)
 }
 If (case(instr_u0) == RETURN_CALL_INDIRECT) {
   Return YetE ($free_tableidx(tableidx) ++ $free_typeuse(typeuse))
 }
 If (case(instr_u0) == CONST) {
   Let (numtype.CONST numlit) = instr_u0
   Return $free_numtype(numtype)
 }
 If (case(instr_u0) == UNOP) {
   Let (UNOP numtype unop) = instr_u0
   Return $free_numtype(numtype)
 }
 If (case(instr_u0) == BINOP) {
   Let (BINOP numtype binop) = instr_u0
   Return $free_numtype(numtype)
 }
 If (case(instr_u0) == TESTOP) {
   Let (TESTOP numtype testop) = instr_u0
   Return $free_numtype(numtype)
 }
 If (case(instr_u0) == RELOP) {
   Let (RELOP numtype relop) = instr_u0
   Return $free_numtype(numtype)
 }
 If (case(instr_u0) == CVTOP) {
   Return YetE ($free_numtype(numtype_1) ++ $free_numtype(numtype_2))
 }
 If (case(instr_u0) == VCONST) {
   Let (vectype.CONST veclit) = instr_u0
   Return $free_vectype(vectype)
 }
 If (case(instr_u0) == VVUNOP) {
   Let (VVUNOP vectype vvunop) = instr_u0
   Return $free_vectype(vectype)
 }
 If (case(instr_u0) == VVBINOP) {
   Let (VVBINOP vectype vvbinop) = instr_u0
   Return $free_vectype(vectype)
 }
 If (case(instr_u0) == VVTERNOP) {
   Let (VVTERNOP vectype vvternop) = instr_u0
   Return $free_vectype(vectype)
 }
 If (case(instr_u0) == VVTESTOP) {
   Let (VVTESTOP vectype vvtestop) = instr_u0
   Return $free_vectype(vectype)
 }
 If (case(instr_u0) == VUNOP) {
   Let (VUNOP shape vunop) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == VBINOP) {
   Let (VBINOP shape vbinop) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == VTESTOP) {
   Let (VTESTOP shape vtestop) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == VRELOP) {
   Let (VRELOP shape vrelop) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == VSHIFTOP) {
   Let (VSHIFTOP ishape vshiftop) = instr_u0
   Return $free_shape(ishape)
 }
 If (case(instr_u0) == VBITMASK) {
   Let (VBITMASK ishape) = instr_u0
   Return $free_shape(ishape)
 }
 If (case(instr_u0) == VSWIZZLE) {
   Let (VSWIZZLE ishape) = instr_u0
   Return $free_shape(ishape)
 }
 If (case(instr_u0) == VSHUFFLE) {
   Let (VSHUFFLE ishape laneidx*) = instr_u0
   Return $free_shape(ishape)
 }
 If (case(instr_u0) == VEXTUNOP) {
   Return YetE ($free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape)))
 }
 If (case(instr_u0) == VEXTBINOP) {
   Return YetE ($free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape)))
 }
 If (case(instr_u0) == VNARROW) {
   Return YetE ($free_shape((ishape_1 : ishape <: shape)) ++ $free_shape((ishape_2 : ishape <: shape)))
 }
 If (case(instr_u0) == VCVTOP) {
   Return YetE ($free_shape(shape_1) ++ $free_shape(shape_2))
 }
 If (case(instr_u0) == VSPLAT) {
   Let (VSPLAT shape) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == VEXTRACT_LANE) {
   Let (VEXTRACT_LANE shape sx? laneidx) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == VREPLACE_LANE) {
   Let (VREPLACE_LANE shape laneidx) = instr_u0
   Return $free_shape(shape)
 }
 If (case(instr_u0) == REF.NULL) {
   Let (REF.NULL heaptype) = instr_u0
   Return $free_heaptype(heaptype)
 }
 If ((instr_u0 == REF.IS_NULL)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If ((instr_u0 == REF.AS_NON_NULL)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If ((instr_u0 == REF.EQ)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == REF.TEST) {
   Let (REF.TEST reftype) = instr_u0
   Return $free_reftype(reftype)
 }
 If (case(instr_u0) == REF.CAST) {
   Let (REF.CAST reftype) = instr_u0
   Return $free_reftype(reftype)
 }
 If (case(instr_u0) == REF.FUNC) {
   Let (REF.FUNC funcidx) = instr_u0
   Return $free_funcidx(funcidx)
 }
 If ((instr_u0 == REF.I31)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == I31.GET) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == STRUCT.NEW) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == STRUCT.NEW_DEFAULT) {
   Let (STRUCT.NEW_DEFAULT typeidx) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == STRUCT.GET) {
   Let (STRUCT.GET sx? typeidx u32) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == STRUCT.SET) {
   Let (STRUCT.SET typeidx u32) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == ARRAY.NEW) {
   Let (ARRAY.NEW typeidx) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == ARRAY.NEW_DEFAULT) {
   Let (ARRAY.NEW_DEFAULT typeidx) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == ARRAY.NEW_FIXED) {
   Let (ARRAY.NEW_FIXED typeidx u32) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == ARRAY.NEW_DATA) {
   Return YetE ($free_typeidx(typeidx) ++ $free_dataidx(dataidx))
 }
 If (case(instr_u0) == ARRAY.NEW_ELEM) {
   Return YetE ($free_typeidx(typeidx) ++ $free_elemidx(elemidx))
 }
 If (case(instr_u0) == ARRAY.GET) {
   Let (ARRAY.GET sx? typeidx) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == ARRAY.SET) {
   Let (ARRAY.SET typeidx) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If ((instr_u0 == ARRAY.LEN)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == ARRAY.FILL) {
   Let (ARRAY.FILL typeidx) = instr_u0
   Return $free_typeidx(typeidx)
 }
 If (case(instr_u0) == ARRAY.COPY) {
   Return YetE ($free_typeidx(typeidx_1) ++ $free_typeidx(typeidx_2))
 }
 If (case(instr_u0) == ARRAY.INIT_DATA) {
   Return YetE ($free_typeidx(typeidx) ++ $free_dataidx(dataidx))
 }
 If (case(instr_u0) == ARRAY.INIT_ELEM) {
   Return YetE ($free_typeidx(typeidx) ++ $free_elemidx(elemidx))
 }
 If ((instr_u0 == EXTERN.CONVERT_ANY)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If ((instr_u0 == ANY.CONVERT_EXTERN)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 If (case(instr_u0) == LOCAL.GET) {
   Let (LOCAL.GET localidx) = instr_u0
   Return $free_localidx(localidx)
 }
 If (case(instr_u0) == LOCAL.SET) {
   Let (LOCAL.SET localidx) = instr_u0
   Return $free_localidx(localidx)
 }
 If (case(instr_u0) == LOCAL.TEE) {
   Let (LOCAL.TEE localidx) = instr_u0
   Return $free_localidx(localidx)
 }
 If (case(instr_u0) == GLOBAL.GET) {
   Let (GLOBAL.GET globalidx) = instr_u0
   Return $free_globalidx(globalidx)
 }
 If (case(instr_u0) == GLOBAL.SET) {
   Let (GLOBAL.SET globalidx) = instr_u0
   Return $free_globalidx(globalidx)
 }
 If (case(instr_u0) == TABLE.GET) {
   Let (TABLE.GET tableidx) = instr_u0
   Return $free_tableidx(tableidx)
 }
 If (case(instr_u0) == TABLE.SET) {
   Let (TABLE.SET tableidx) = instr_u0
   Return $free_tableidx(tableidx)
 }
 If (case(instr_u0) == TABLE.SIZE) {
   Let (TABLE.SIZE tableidx) = instr_u0
   Return $free_tableidx(tableidx)
 }
 If (case(instr_u0) == TABLE.GROW) {
   Let (TABLE.GROW tableidx) = instr_u0
   Return $free_tableidx(tableidx)
 }
 If (case(instr_u0) == TABLE.FILL) {
   Let (TABLE.FILL tableidx) = instr_u0
   Return $free_tableidx(tableidx)
 }
 If (case(instr_u0) == TABLE.COPY) {
   Return YetE ($free_tableidx(tableidx_1) ++ $free_tableidx(tableidx_2))
 }
 If (case(instr_u0) == TABLE.INIT) {
   Return YetE ($free_tableidx(tableidx) ++ $free_elemidx(elemidx))
 }
 If (case(instr_u0) == ELEM.DROP) {
   Let (ELEM.DROP elemidx) = instr_u0
   Return $free_elemidx(elemidx)
 }
 If (case(instr_u0) == LOAD) {
   Let (LOAD numtype y_0 memidx memarg) = instr_u0
   If (y_0 != None) {
     Return YetE ($free_numtype(numtype) ++ $free_memidx(memidx))
   }
 }
 If (case(instr_u0) == STORE) {
   Return YetE ($free_numtype(numtype) ++ $free_memidx(memidx))
 }
 If (case(instr_u0) == VLOAD) {
   Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx))
 }
 If (case(instr_u0) == VLOAD_LANE) {
   Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx))
 }
 If (case(instr_u0) == VSTORE) {
   Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx))
 }
 If (case(instr_u0) == VSTORE_LANE) {
   Return YetE ($free_vectype(vectype) ++ $free_memidx(memidx))
 }
 If (case(instr_u0) == MEMORY.SIZE) {
   Let (MEMORY.SIZE memidx) = instr_u0
   Return $free_memidx(memidx)
 }
 If (case(instr_u0) == MEMORY.GROW) {
   Let (MEMORY.GROW memidx) = instr_u0
   Return $free_memidx(memidx)
 }
 If (case(instr_u0) == MEMORY.FILL) {
   Let (MEMORY.FILL memidx) = instr_u0
   Return $free_memidx(memidx)
 }
 If (case(instr_u0) == MEMORY.COPY) {
   Return YetE ($free_memidx(memidx_1) ++ $free_memidx(memidx_2))
 }
 If (case(instr_u0) == MEMORY.INIT) {
   Return YetE ($free_memidx(memidx) ++ $free_dataidx(dataidx))
 }
 Assert(case(instr_u0) == DATA.DROP)
 Let (DATA.DROP dataidx) = instr_u0
 Return $free_dataidx(dataidx)
}

free_expr instr* = {
 Return $free_list($free_instr(instr)*)
}

free_type (TYPE rectype) = {
 Return $free_rectype(rectype)
}

free_local (LOCAL t) = {
 Return $free_valtype(t)
}

free_func (FUNC typeidx local* expr) = {
 Return YetE ($free_typeidx(typeidx) ++ $free_list($free_local(local)*{local : local}) ++ $free_block(expr)[LOCALS_free = []])
}

free_global (GLOBAL globaltype expr) = {
 Return YetE ($free_globaltype(globaltype) ++ $free_expr(expr))
}

free_table (TABLE tabletype expr) = {
 Return YetE ($free_tabletype(tabletype) ++ $free_expr(expr))
}

free_mem (MEMORY memtype) = {
 Return $free_memtype(memtype)
}

free_elemmode elemm_u0 = {
 If (case(elemm_u0) == ACTIVE) {
   Return YetE ($free_tableidx(tableidx) ++ $free_expr(expr))
 }
 If ((elemm_u0 == PASSIVE)) {
   Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
 }
 Assert((elemm_u0 == DECLARE))
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_datamode datam_u0 = {
 If (case(datam_u0) == ACTIVE) {
   Return YetE ($free_memidx(memidx) ++ $free_expr(expr))
 }
 Assert((datam_u0 == PASSIVE))
 Return { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; LOCALS: []; LABELS: []; }
}

free_elem (ELEM reftype expr* elemmode) = {
 Return YetE ($free_reftype(reftype) ++ $free_list($free_expr(expr)*{expr : expr}) ++ $free_elemmode(elemmode))
}

free_data (DATA byte* datamode) = {
 Return $free_datamode(datamode)
}

free_start (START funcidx) = {
 Return $free_funcidx(funcidx)
}

free_export (EXPORT name externidx) = {
 Return $free_externidx(externidx)
}

free_import (IMPORT name_1 name_2 externtype) = {
 Return $free_externtype(externtype)
}

free_module (MODULE type* import* func* global* table* mem* elem* data* start* export*) = {
 Return YetE ($free_list($free_type(type)*{type : type}) ++ $free_list($free_import(import)*{import : import}) ++ $free_list($free_func(func)*{func : func}) ++ $free_list($free_global(global)*{global : global}) ++ $free_list($free_table(table)*{table : table}) ++ $free_list($free_mem(mem)*{mem : mem}) ++ $free_list($free_elem(elem)*{elem : elem}) ++ $free_list($free_data(data)*{data : data}) ++ $free_list($free_start(start)*{start : start}) ++ $free_list($free_export(export)*{export : export}))
}

funcidx_module module = {
 Return $free_module(module).FUNCS
}

dataidx_funcs func* = {
 Return $free_list($free_func(func)*).DATAS
}

subst_typevar tv typev_u0* typeu_u1* = {
 If (((typev_u0* == []) && (typeu_u1* == []))) {
   Return tv
 }
 Assert((|typeu_u1*| ≥ 1))
 Let [tu_1] ++ tu'* = typeu_u1*
 If ((|typev_u0*| ≥ 1)) {
   Let [tv_1] ++ tv'* = typev_u0*
   If ((tv == tv_1)) {
     Return tu_1
   }
 }
 Let [tu_1] ++ tu'* = typeu_u1*
 Assert((|typev_u0*| ≥ 1))
 Let [tv_1] ++ tv'* = typev_u0*
 Return $subst_typevar(tv, tv'*, tu'*)
}

subst_packtype pt tv* tu* = {
 Return pt
}

subst_numtype nt tv* tu* = {
 Return nt
}

subst_vectype vt tv* tu* = {
 Return vt
}

subst_typeuse typeu_u0 tv* tu* = {
 If (type(typeu_u0) == typevar) {
   Let tv' = typeu_u0
   Return $subst_typevar(tv', tv*, tu*)
 }
 Assert(type(typeu_u0) == deftype)
 Let dt = typeu_u0
 Return $subst_deftype(dt, tv*, tu*)
}

subst_heaptype heapt_u0 tv* tu* = {
 If (type(heapt_u0) == typevar) {
   Let tv' = heapt_u0
   Return $subst_typevar(tv', tv*, tu*)
 }
 If (type(heapt_u0) == deftype) {
   Let dt = heapt_u0
   Return $subst_deftype(dt, tv*, tu*)
 }
 Let ht = heapt_u0
 Return ht
}

subst_reftype (REF nul ht) tv* tu* = {
 Return (REF nul $subst_heaptype(ht, tv*, tu*))
}

subst_valtype valty_u0 tv* tu* = {
 If (type(valty_u0) == numtype) {
   Let nt = valty_u0
   Return $subst_numtype(nt, tv*, tu*)
 }
 If (type(valty_u0) == vectype) {
   Let vt = valty_u0
   Return $subst_vectype(vt, tv*, tu*)
 }
 If (type(valty_u0) == reftype) {
   Let rt = valty_u0
   Return $subst_reftype(rt, tv*, tu*)
 }
 Assert((valty_u0 == BOT))
 Return BOT
}

subst_storagetype stora_u0 tv* tu* = {
 If (type(stora_u0) == valtype) {
   Let t = stora_u0
   Return $subst_valtype(t, tv*, tu*)
 }
 Assert(type(stora_u0) == packtype)
 Let pt = stora_u0
 Return $subst_packtype(pt, tv*, tu*)
}

subst_fieldtype (mut, zt) tv* tu* = {
 Return (mut, $subst_storagetype(zt, tv*, tu*))
}

subst_comptype compt_u0 tv* tu* = {
 If (case(compt_u0) == STRUCT) {
   Let (STRUCT yt*) = compt_u0
   Return (STRUCT $subst_fieldtype(yt, tv*, tu*)*)
 }
 If (case(compt_u0) == ARRAY) {
   Let (ARRAY yt) = compt_u0
   Return (ARRAY $subst_fieldtype(yt, tv*, tu*))
 }
 Assert(case(compt_u0) == FUNC)
 Let (FUNC ft) = compt_u0
 Return (FUNC $subst_functype(ft, tv*, tu*))
}

subst_subtype (SUB fin tu'* ct) tv* tu* = {
 Return (SUB fin $subst_typeuse(tu', tv*, tu*)* $subst_comptype(ct, tv*, tu*))
}

subst_rectype (REC st*) tv* tu* = {
 Return (REC $subst_subtype(st, tv*, tu*)*)
}

subst_deftype (DEF qt i) tv* tu* = {
 Return (DEF $subst_rectype(qt, tv*, tu*) i)
}

subst_functype (t_1* -> t_2*) tv* tu* = {
 Return ($subst_valtype(t_1, tv*, tu*)* -> $subst_valtype(t_2, tv*, tu*)*)
}

subst_globaltype (mut, t) tv* tu* = {
 Return (mut, $subst_valtype(t, tv*, tu*))
}

subst_tabletype (lim, rt) tv* tu* = {
 Return (lim, $subst_reftype(rt, tv*, tu*))
}

subst_memtype (PAGE lim) tv* tu* = {
 Return (PAGE lim)
}

subst_externtype exter_u0 tv* tu* = {
 If (case(exter_u0) == FUNC) {
   Let (FUNC dt) = exter_u0
   Return (FUNC $subst_deftype(dt, tv*, tu*))
 }
 If (case(exter_u0) == GLOBAL) {
   Let (GLOBAL gt) = exter_u0
   Return (GLOBAL $subst_globaltype(gt, tv*, tu*))
 }
 If (case(exter_u0) == TABLE) {
   Let (TABLE tt) = exter_u0
   Return (TABLE $subst_tabletype(tt, tv*, tu*))
 }
 Assert(case(exter_u0) == MEM)
 Let (MEM mt) = exter_u0
 Return (MEM $subst_memtype(mt, tv*, tu*))
}

subst_moduletype (xt_1* -> xt_2*) tv* tu* = {
 Return ($subst_externtype(xt_1, tv*, tu*)* -> $subst_externtype(xt_2, tv*, tu*)*)
}

subst_all_valtype t tu^n = {
 Return $subst_valtype(t, $idx(i)^(i<n), tu^n)
}

subst_all_reftype rt tu^n = {
 Return $subst_reftype(rt, $idx(i)^(i<n), tu^n)
}

subst_all_deftype dt tu^n = {
 Return $subst_deftype(dt, $idx(i)^(i<n), tu^n)
}

subst_all_moduletype mmt tu^n = {
 Return $subst_moduletype(mmt, $idx(i)^(i<n), tu^n)
}

subst_all_deftypes defty_u0* tu* = {
 If ((defty_u0* == [])) {
   Return []
 }
 Let [dt_1] ++ dt* = defty_u0*
 Return [$subst_all_deftype(dt_1, tu*)] ++ $subst_all_deftypes(dt*, tu*)
}

rollrt x rectype = {
 Assert(case(rectype) == REC)
 Let (REC subtype^n) = rectype
 Return (REC $subst_subtype(subtype, $idx((x + i))^(i<n), (REC i)^(i<n))^n)
}

unrollrt rectype = {
 Assert(case(rectype) == REC)
 Let (REC subtype^n) = rectype
 Return (REC $subst_subtype(subtype, (REC i)^(i<n), (DEF rectype i)^(i<n))^n)
}

rolldt x rectype = {
 Assert(case($rollrt(x, rectype)) == REC)
 Let (REC subtype^n) = $rollrt(x, rectype)
 Return (DEF (REC subtype^n) i)^(i<n)
}

unrolldt (DEF rectype i) = {
 Assert(case($unrollrt(rectype)) == REC)
 Let (REC subtype*) = $unrollrt(rectype)
 Return subtype*[i]
}

expanddt deftype = {
 Assert(case($unrolldt(deftype)) == SUB)
 Let (SUB fin typeuse* comptype) = $unrolldt(deftype)
 Return comptype
}

funcsxx exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xx* = exter_u0*
 If (case(y_0) == FUNC) {
   Let (FUNC x) = y_0
   Return [x] ++ $funcsxx(xx*)
 }
 Let [externidx] ++ xx* = exter_u0*
 Return $funcsxx(xx*)
}

globalsxx exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xx* = exter_u0*
 If (case(y_0) == GLOBAL) {
   Let (GLOBAL x) = y_0
   Return [x] ++ $globalsxx(xx*)
 }
 Let [externidx] ++ xx* = exter_u0*
 Return $globalsxx(xx*)
}

tablesxx exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xx* = exter_u0*
 If (case(y_0) == TABLE) {
   Let (TABLE x) = y_0
   Return [x] ++ $tablesxx(xx*)
 }
 Let [externidx] ++ xx* = exter_u0*
 Return $tablesxx(xx*)
}

memsxx exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xx* = exter_u0*
 If (case(y_0) == MEM) {
   Let (MEM x) = y_0
   Return [x] ++ $memsxx(xx*)
 }
 Let [externidx] ++ xx* = exter_u0*
 Return $memsxx(xx*)
}

funcsxt exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xt* = exter_u0*
 If (case(y_0) == FUNC) {
   Let (FUNC dt) = y_0
   Return [dt] ++ $funcsxt(xt*)
 }
 Let [externtype] ++ xt* = exter_u0*
 Return $funcsxt(xt*)
}

globalsxt exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xt* = exter_u0*
 If (case(y_0) == GLOBAL) {
   Let (GLOBAL gt) = y_0
   Return [gt] ++ $globalsxt(xt*)
 }
 Let [externtype] ++ xt* = exter_u0*
 Return $globalsxt(xt*)
}

tablesxt exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xt* = exter_u0*
 If (case(y_0) == TABLE) {
   Let (TABLE tt) = y_0
   Return [tt] ++ $tablesxt(xt*)
 }
 Let [externtype] ++ xt* = exter_u0*
 Return $tablesxt(xt*)
}

memsxt exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xt* = exter_u0*
 If (case(y_0) == MEM) {
   Let (MEM mt) = y_0
   Return [mt] ++ $memsxt(xt*)
 }
 Let [externtype] ++ xt* = exter_u0*
 Return $memsxt(xt*)
}

memarg0 = {
 Return { ALIGN: 0; OFFSET: 0; }
}

signed N i = {
 If ((0 ≤ (2 ^ (N - 1)))) {
   Return i
 }
 Assert(((2 ^ (N - 1)) ≤ i))
 Assert((i < (2 ^ N)))
 Return (i - (2 ^ N))
}

invsigned N i = {
 Let j = $inverse_of_signed(N, i)
 Return j
}

unop numty_u1 unop__u0 num__u3 = {
 If (((unop__u0 == CLZ) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN = num__u3
   Return [$iclz($size(Inn), iN)]
 }
 If (((unop__u0 == CTZ) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN = num__u3
   Return [$ictz($size(Inn), iN)]
 }
 If (((unop__u0 == POPCNT) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN = num__u3
   Return [$ipopcnt($size(Inn), iN)]
 }
 If (type(numty_u1) == Inn) {
   Let Inn = numty_u1
   Assert(case(unop__u0) == EXTEND)
   Let (EXTEND N) = unop__u0
   Let iN = num__u3
   Return [$ext(N, $size(Inn), S, $wrap($size(Inn), N, iN))]
 }
 If (((unop__u0 == ABS) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN = num__u3
   Return [$fabs($size(Fnn), fN)]
 }
 If (((unop__u0 == NEG) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN = num__u3
   Return [$fneg($size(Fnn), fN)]
 }
 If (((unop__u0 == SQRT) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN = num__u3
   Return [$fsqrt($size(Fnn), fN)]
 }
 If (((unop__u0 == CEIL) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN = num__u3
   Return [$fceil($size(Fnn), fN)]
 }
 If (((unop__u0 == FLOOR) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN = num__u3
   Return [$ffloor($size(Fnn), fN)]
 }
 If (((unop__u0 == TRUNC) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN = num__u3
   Return [$ftrunc($size(Fnn), fN)]
 }
 Assert((unop__u0 == NEAREST))
 Assert(type(numty_u1) == Fnn)
 Let Fnn = numty_u1
 Let fN = num__u3
 Return [$fnearest($size(Fnn), fN)]
}

binop numty_u1 binop_u0 num__u3 num__u5 = {
 If (((binop_u0 == ADD) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$iadd($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == SUB) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$isub($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == MUL) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$imul($size(Inn), iN_1, iN_2)]
 }
 If (type(numty_u1) == Inn) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   If (case(binop_u0) == DIV) {
     Let (DIV sx) = binop_u0
     Return [$idiv($size(Inn), sx, iN_1, iN_2)]
   }
   If (case(binop_u0) == REM) {
     Let (REM sx) = binop_u0
     Return [$irem($size(Inn), sx, iN_1, iN_2)]
   }
 }
 If (((binop_u0 == AND) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$iand($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == OR) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$ior($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == XOR) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$ixor($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == SHL) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$ishl($size(Inn), iN_1, iN_2)]
 }
 If (type(numty_u1) == Inn) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   If (case(binop_u0) == SHR) {
     Let (SHR sx) = binop_u0
     Return [$ishr($size(Inn), sx, iN_1, iN_2)]
   }
 }
 If (((binop_u0 == ROTL) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$irotl($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == ROTR) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return [$irotr($size(Inn), iN_1, iN_2)]
 }
 If (((binop_u0 == ADD) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return [$fadd($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == SUB) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return [$fsub($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == MUL) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return [$fmul($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == DIV) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return [$fdiv($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == MIN) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return [$fmin($size(Fnn), fN_1, fN_2)]
 }
 If (((binop_u0 == MAX) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return [$fmax($size(Fnn), fN_1, fN_2)]
 }
 Assert((binop_u0 == COPYSIGN))
 Assert(type(numty_u1) == Fnn)
 Let Fnn = numty_u1
 Let fN_1 = num__u3
 Let fN_2 = num__u5
 Return [$fcopysign($size(Fnn), fN_1, fN_2)]
}

testop Inn EQZ iN = {
 Return $ieqz($size(Inn), iN)
}

relop numty_u1 relop_u0 num__u3 num__u5 = {
 If (((relop_u0 == EQ) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return $ieq($size(Inn), iN_1, iN_2)
 }
 If (((relop_u0 == NE) && type(numty_u1) == Inn)) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   Return $ine($size(Inn), iN_1, iN_2)
 }
 If (type(numty_u1) == Inn) {
   Let Inn = numty_u1
   Let iN_1 = num__u3
   Let iN_2 = num__u5
   If (case(relop_u0) == LT) {
     Let (LT sx) = relop_u0
     Return $ilt($size(Inn), sx, iN_1, iN_2)
   }
   If (case(relop_u0) == GT) {
     Let (GT sx) = relop_u0
     Return $igt($size(Inn), sx, iN_1, iN_2)
   }
   If (case(relop_u0) == LE) {
     Let (LE sx) = relop_u0
     Return $ile($size(Inn), sx, iN_1, iN_2)
   }
   If (case(relop_u0) == GE) {
     Let (GE sx) = relop_u0
     Return $ige($size(Inn), sx, iN_1, iN_2)
   }
 }
 If (((relop_u0 == EQ) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $feq($size(Fnn), fN_1, fN_2)
 }
 If (((relop_u0 == NE) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fne($size(Fnn), fN_1, fN_2)
 }
 If (((relop_u0 == LT) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $flt($size(Fnn), fN_1, fN_2)
 }
 If (((relop_u0 == GT) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fgt($size(Fnn), fN_1, fN_2)
 }
 If (((relop_u0 == LE) && type(numty_u1) == Fnn)) {
   Let Fnn = numty_u1
   Let fN_1 = num__u3
   Let fN_2 = num__u5
   Return $fle($size(Fnn), fN_1, fN_2)
 }
 Assert((relop_u0 == GE))
 Assert(type(numty_u1) == Fnn)
 Let Fnn = numty_u1
 Let fN_1 = num__u3
 Let fN_2 = num__u5
 Return $fge($size(Fnn), fN_1, fN_2)
}

cvtop numty_u1 numty_u4 cvtop_u0 num__u3 = {
 If (type(numty_u1) == Inn) {
   Let Inn_1 = numty_u1
   If (type(numty_u4) == Inn) {
     Let Inn_2 = numty_u4
     Let iN_1 = num__u3
     If (case(cvtop_u0) == EXTEND) {
       Let (EXTEND sx) = cvtop_u0
       Return [$ext($sizenn1(Inn_1), $sizenn2(Inn_2), sx, iN_1)]
     }
   }
 }
 If (((cvtop_u0 == WRAP) && type(numty_u1) == Inn)) {
   Let Inn_1 = numty_u1
   If (type(numty_u4) == Inn) {
     Let Inn_2 = numty_u4
     Let iN_1 = num__u3
     Return [$wrap($sizenn1(Inn_1), $sizenn2(Inn_2), iN_1)]
   }
 }
 If (type(numty_u1) == Fnn) {
   Let Fnn_1 = numty_u1
   If (type(numty_u4) == Inn) {
     Let Inn_2 = numty_u4
     Let fN_1 = num__u3
     If (case(cvtop_u0) == TRUNC) {
       Let (TRUNC sx) = cvtop_u0
       Return [$trunc($sizenn1(Fnn_1), $sizenn2(Inn_2), sx, fN_1)]
     }
     If (case(cvtop_u0) == TRUNC_SAT) {
       Let (TRUNC_SAT sx) = cvtop_u0
       Return [$trunc_sat($sizenn1(Fnn_1), $sizenn2(Inn_2), sx, fN_1)]
     }
   }
 }
 If (type(numty_u4) == Fnn) {
   Let Fnn_2 = numty_u4
   If (type(numty_u1) == Inn) {
     Let Inn_1 = numty_u1
     Let iN_1 = num__u3
     If (case(cvtop_u0) == CONVERT) {
       Let (CONVERT sx) = cvtop_u0
       Return [$convert($sizenn1(Inn_1), $sizenn2(Fnn_2), sx, iN_1)]
     }
   }
 }
 If (((cvtop_u0 == PROMOTE) && type(numty_u1) == Fnn)) {
   Let Fnn_1 = numty_u1
   If (type(numty_u4) == Fnn) {
     Let Fnn_2 = numty_u4
     Let fN_1 = num__u3
     Return [$promote($sizenn1(Fnn_1), $sizenn2(Fnn_2), fN_1)]
   }
 }
 If (((cvtop_u0 == DEMOTE) && type(numty_u1) == Fnn)) {
   Let Fnn_1 = numty_u1
   If (type(numty_u4) == Fnn) {
     Let Fnn_2 = numty_u4
     Let fN_1 = num__u3
     Return [$demote($sizenn1(Fnn_1), $sizenn2(Fnn_2), fN_1)]
   }
 }
 Assert((cvtop_u0 == REINTERPRET))
 If (type(numty_u4) == Fnn) {
   Let Fnn_2 = numty_u4
   If (type(numty_u1) == Inn) {
     Let Inn_1 = numty_u1
     Let iN_1 = num__u3
     If (($sizenn1(Inn_1) == $sizenn2(Fnn_2))) {
       Return [$reinterpret(Inn_1, Fnn_2, iN_1)]
     }
   }
 }
 Assert(type(numty_u1) == Fnn)
 Let Fnn_1 = numty_u1
 Assert(type(numty_u4) == Inn)
 Let Inn_2 = numty_u4
 Let fN_1 = num__u3
 Assert(type($inverse_of_sizenn2($sizenn1(Inn_1))) == Fnn)
 Return [$reinterpret(Fnn_1, Inn_2, fN_1)]
}

invibytes N b* = {
 Let n = $inverse_of_ibytes(N, b*)
 Return n
}

invfbytes N b* = {
 Let p = $inverse_of_fbytes(N, b*)
 Return p
}

lpacknum lanet_u0 c = {
 If (type(lanet_u0) == numtype) {
   Return c
 }
 Assert(type(lanet_u0) == packtype)
 Let packtype = lanet_u0
 Return $wrap($size($lunpack(packtype)), $psize(packtype), c)
}

lunpacknum lanet_u0 c = {
 If (type(lanet_u0) == numtype) {
   Return c
 }
 Assert(type(lanet_u0) == packtype)
 Let packtype = lanet_u0
 Return $ext($psize(packtype), $size($lunpack(packtype)), U, c)
}

cpacknum stora_u0 c = {
 If (type(stora_u0) == consttype) {
   Return c
 }
 Assert(type(stora_u0) == packtype)
 Let packtype = stora_u0
 Return $wrap($size($lunpack(packtype)), $psize(packtype), c)
}

cunpacknum stora_u0 c = {
 If (type(stora_u0) == consttype) {
   Return c
 }
 Assert(type(stora_u0) == packtype)
 Let packtype = stora_u0
 Return $ext($psize(packtype), $size($lunpack(packtype)), U, c)
}

invlanes_ sh c* = {
 Let vc = $inverse_of_lanes_(sh, c*)
 Return vc
}

half (lanet_u1 X M_1) (lanet_u2 X M_2) half__u0 i j = {
 If (((half__u0 == LOW) && (type(lanet_u1) == Jnn && type(lanet_u2) == Jnn))) {
   Return i
 }
 If (((half__u0 == HIGH) && (type(lanet_u1) == Jnn && type(lanet_u2) == Jnn))) {
   Return j
 }
 Assert((half__u0 == LOW))
 Assert(type(lanet_u2) == Fnn)
 Return i
}

vvunop V128 NOT v128 = {
 Return $inot($vsize(V128), v128)
}

vvbinop V128 vvbin_u0 v128_1 v128_2 = {
 If ((vvbin_u0 == AND)) {
   Return $iand($vsize(V128), v128_1, v128_2)
 }
 If ((vvbin_u0 == ANDNOT)) {
   Return $iandnot($vsize(V128), v128_1, v128_2)
 }
 If ((vvbin_u0 == OR)) {
   Return $ior($vsize(V128), v128_1, v128_2)
 }
 Assert((vvbin_u0 == XOR))
 Return $ixor($vsize(V128), v128_1, v128_2)
}

vvternop V128 BITSELECT v128_1 v128_2 v128_3 = {
 Return $ibitselect($vsize(V128), v128_1, v128_2, v128_3)
}

vunop (lanet_u1 X N) vunop_u0 v128_1 = {
 If (((vunop_u0 == ABS) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let v128 = $invlanes_((Jnn X N), $iabs($lsize(Jnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == NEG) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let v128 = $invlanes_((Jnn X N), $ineg($lsize(Jnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == POPCNT) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let v128 = $invlanes_((Jnn X N), $ipopcnt($lsize(Jnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == ABS) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let v128 = $invlanes_((Fnn X N), $fabs($size(Fnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == NEG) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let v128 = $invlanes_((Fnn X N), $fneg($size(Fnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == SQRT) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let v128 = $invlanes_((Fnn X N), $fsqrt($size(Fnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == CEIL) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let v128 = $invlanes_((Fnn X N), $fceil($size(Fnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == FLOOR) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let v128 = $invlanes_((Fnn X N), $ffloor($size(Fnn), lane_1)*)
   Return v128
 }
 If (((vunop_u0 == TRUNC) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let v128 = $invlanes_((Fnn X N), $ftrunc($size(Fnn), lane_1)*)
   Return v128
 }
 Assert((vunop_u0 == NEAREST))
 Assert(type(lanet_u1) == Fnn)
 Let Fnn = lanet_u1
 Let lane_1* = $lanes_((Fnn X N), v128_1)
 Let v128 = $invlanes_((Fnn X N), $fnearest($size(Fnn), lane_1)*)
 Return v128
}

vbinop (lanet_u1 X N) vbino_u0 v128_1 v128_2 = {
 If (((vbino_u0 == ADD) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let v128 = $invlanes_((Jnn X N), $iadd($lsize(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == SUB) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let v128 = $invlanes_((Jnn X N), $isub($lsize(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (type(lanet_u1) == Jnn) {
   Let Jnn = lanet_u1
   If (case(vbino_u0) == MIN) {
     Let (MIN sx) = vbino_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let v128 = $invlanes_((Jnn X N), $imin($lsize(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
   If (case(vbino_u0) == MAX) {
     Let (MAX sx) = vbino_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let v128 = $invlanes_((Jnn X N), $imax($lsize(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
   If (case(vbino_u0) == ADD_SAT) {
     Let (ADD_SAT sx) = vbino_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let v128 = $invlanes_((Jnn X N), $iaddsat($lsize(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
   If (case(vbino_u0) == SUB_SAT) {
     Let (SUB_SAT sx) = vbino_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let v128 = $invlanes_((Jnn X N), $isubsat($lsize(Jnn), sx, lane_1, lane_2)*)
     Return [v128]
   }
 }
 If (((vbino_u0 == MUL) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let v128 = $invlanes_((Jnn X N), $imul($lsize(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == AVGR_U) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let v128 = $invlanes_((Jnn X N), $iavgr_u($lsize(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == Q15MULR_SAT_S) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let v128 = $invlanes_((Jnn X N), $iq15mulrsat_s($lsize(Jnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == ADD) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fadd($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == SUB) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fsub($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == MUL) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fmul($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == DIV) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fdiv($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == MIN) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fmin($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == MAX) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fmax($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 If (((vbino_u0 == PMIN) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let v128 = $invlanes_((Fnn X N), $fpmin($size(Fnn), lane_1, lane_2)*)
   Return [v128]
 }
 Assert((vbino_u0 == PMAX))
 Assert(type(lanet_u1) == Fnn)
 Let Fnn = lanet_u1
 Let lane_1* = $lanes_((Fnn X N), v128_1)
 Let lane_2* = $lanes_((Fnn X N), v128_2)
 Let v128 = $invlanes_((Fnn X N), $fpmax($size(Fnn), lane_1, lane_2)*)
 Return [v128]
}

vrelop (lanet_u1 X N) vrelo_u0 v128_1 v128_2 = {
 If (((vrelo_u0 == EQ) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let lane_3* = $ext(1, $lsize(Jnn), S, $ieq($lsize(Jnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Jnn X N), lane_3*)
   Return v128
 }
 If (((vrelo_u0 == NE) && type(lanet_u1) == Jnn)) {
   Let Jnn = lanet_u1
   Let lane_1* = $lanes_((Jnn X N), v128_1)
   Let lane_2* = $lanes_((Jnn X N), v128_2)
   Let lane_3* = $ext(1, $lsize(Jnn), S, $ine($lsize(Jnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Jnn X N), lane_3*)
   Return v128
 }
 If (type(lanet_u1) == Jnn) {
   Let Jnn = lanet_u1
   If (case(vrelo_u0) == LT) {
     Let (LT sx) = vrelo_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let lane_3* = $ext(1, $lsize(Jnn), S, $ilt($lsize(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X N), lane_3*)
     Return v128
   }
   If (case(vrelo_u0) == GT) {
     Let (GT sx) = vrelo_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let lane_3* = $ext(1, $lsize(Jnn), S, $igt($lsize(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X N), lane_3*)
     Return v128
   }
   If (case(vrelo_u0) == LE) {
     Let (LE sx) = vrelo_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let lane_3* = $ext(1, $lsize(Jnn), S, $ile($lsize(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X N), lane_3*)
     Return v128
   }
   If (case(vrelo_u0) == GE) {
     Let (GE sx) = vrelo_u0
     Let lane_1* = $lanes_((Jnn X N), v128_1)
     Let lane_2* = $lanes_((Jnn X N), v128_2)
     Let lane_3* = $ext(1, $lsize(Jnn), S, $ige($lsize(Jnn), sx, lane_1, lane_2))*
     Let v128 = $invlanes_((Jnn X N), lane_3*)
     Return v128
   }
 }
 If (((vrelo_u0 == EQ) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let Inn = $inverse_of_isize($size(Fnn))
   Let lane_3* = $ext(1, $size(Fnn), S, $feq($size(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X N), lane_3*)
   Return v128
 }
 If (((vrelo_u0 == NE) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let Inn = $inverse_of_isize($size(Fnn))
   Let lane_3* = $ext(1, $size(Fnn), S, $fne($size(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X N), lane_3*)
   Return v128
 }
 If (((vrelo_u0 == LT) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let Inn = $inverse_of_isize($size(Fnn))
   Let lane_3* = $ext(1, $size(Fnn), S, $flt($size(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X N), lane_3*)
   Return v128
 }
 If (((vrelo_u0 == GT) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let Inn = $inverse_of_isize($size(Fnn))
   Let lane_3* = $ext(1, $size(Fnn), S, $fgt($size(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X N), lane_3*)
   Return v128
 }
 If (((vrelo_u0 == LE) && type(lanet_u1) == Fnn)) {
   Let Fnn = lanet_u1
   Let lane_1* = $lanes_((Fnn X N), v128_1)
   Let lane_2* = $lanes_((Fnn X N), v128_2)
   Let Inn = $inverse_of_isize($size(Fnn))
   Let lane_3* = $ext(1, $size(Fnn), S, $fle($size(Fnn), lane_1, lane_2))*
   Let v128 = $invlanes_((Inn X N), lane_3*)
   Return v128
 }
 Assert((vrelo_u0 == GE))
 Assert(type(lanet_u1) == Fnn)
 Let Fnn = lanet_u1
 Let lane_1* = $lanes_((Fnn X N), v128_1)
 Let lane_2* = $lanes_((Fnn X N), v128_2)
 Let Inn = $inverse_of_isize($size(Fnn))
 Let lane_3* = $ext(1, $size(Fnn), S, $fge($size(Fnn), lane_1, lane_2))*
 Let v128 = $invlanes_((Inn X N), lane_3*)
 Return v128
}

vcvtop (lanet_u0 X N_1) (lanet_u1 X N_2) vcvto_u6 sx_u7? lane__u3 = {
 If (((lanet_u0 == I8) && ((lanet_u1 == I16) && (vcvto_u6 == EXTEND)))) {
   Let i8 = lane__u3
   If (sx_u7? != None) {
     Let ?(sx) = sx_u7?
     Let i16 = $ext(8, 16, sx, i8)
     Return i16
   }
 }
 If (((lanet_u0 == I16) && ((lanet_u1 == I32) && (vcvto_u6 == EXTEND)))) {
   Let i16 = lane__u3
   If (sx_u7? != None) {
     Let ?(sx) = sx_u7?
     Let i32 = $ext(16, 32, sx, i16)
     Return i32
   }
 }
 If ((lanet_u0 == I32)) {
   If (((lanet_u1 == I64) && (vcvto_u6 == EXTEND))) {
     Let i32 = lane__u3
     If (sx_u7? != None) {
       Let ?(sx) = sx_u7?
       Let i64 = $ext(32, 64, sx, i32)
       Return i64
     }
   }
   If (((lanet_u1 == F32) && (vcvto_u6 == CONVERT))) {
     Let i32 = lane__u3
     If (sx_u7? != None) {
       Let ?(sx) = sx_u7?
       Let f32 = $convert(32, 32, sx, i32)
       Return f32
     }
   }
   If (((lanet_u1 == F64) && (vcvto_u6 == CONVERT))) {
     Let i32 = lane__u3
     If (sx_u7? != None) {
       Let ?(sx) = sx_u7?
       Let f64 = $convert(32, 64, sx, i32)
       Return f64
     }
   }
 }
 If (((lanet_u0 == F32) && ((lanet_u1 == I32) && (vcvto_u6 == TRUNC_SAT)))) {
   Let f32 = lane__u3
   If (sx_u7? != None) {
     Let ?(sx) = sx_u7?
     Let i32 = $trunc_sat(32, 32, sx, f32)
     Return i32
   }
 }
 If ((lanet_u0 == F64)) {
   If (((lanet_u1 == I32) && (vcvto_u6 == TRUNC_SAT))) {
     Let f64 = lane__u3
     If (sx_u7? != None) {
       Let ?(sx) = sx_u7?
       Let i32 = $trunc_sat(64, 32, sx, f64)
       Return i32
     }
   }
   If (((lanet_u1 == F32) && (vcvto_u6 == DEMOTE))) {
     Let f64 = lane__u3
     Let f32 = $demote(64, 32, f64)
     Return f32
   }
 }
 Assert((lanet_u0 == F32))
 Assert((lanet_u1 == F64))
 Assert((vcvto_u6 == PROMOTE))
 Let f32 = lane__u3
 Let f64 = $promote(32, 64, f32)
 Return f64
}

vextunop (Jnn_1 X N_1) (Jnn_2 X N_2) EXTADD_PAIRWISE sx c_1 = {
 Let ci* = $lanes_((Jnn_1 X N_1), c_1)
 Let [cj_1, cj_2]* = $inverse_of_concat_($ext($lsize(Jnn_1), $lsize(Jnn_2), sx, ci)*)
 Let c = $invlanes_((Jnn_2 X N_2), $iadd($lsize(Jnn_2), cj_1, cj_2)*)
 Return c
}

vextbinop (Jnn_1 X N_1) (Jnn_2 X N_2) vextb_u0 sx c_1 c_2 = {
 If (case(vextb_u0) == EXTMUL) {
   Let (EXTMUL half) = vextb_u0
   Let ci_1* = $lanes_((Jnn_1 X N_1), c_1)[$half((Jnn_1 X N_1), (Jnn_2 X N_2), half, 0, N_2) : N_2]
   Let ci_2* = $lanes_((Jnn_1 X N_1), c_2)[$half((Jnn_1 X N_1), (Jnn_2 X N_2), half, 0, N_2) : N_2]
   Let c = $invlanes_((Jnn_2 X N_2), $imul($lsize(Jnn_2), $ext($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_1), $ext($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_2))*)
   Return c
 }
 Assert((vextb_u0 == DOT))
 Let ci_1* = $lanes_((Jnn_1 X N_1), c_1)
 Let ci_2* = $lanes_((Jnn_1 X N_1), c_2)
 Let [cj_1, cj_2]* = $inverse_of_concat_($imul($lsize(Jnn_2), $ext($lsize(Jnn_1), $lsize(Jnn_2), S, ci_1), $ext($lsize(Jnn_1), $lsize(Jnn_2), S, ci_2))*)
 Let c = $invlanes_((Jnn_2 X N_2), $iadd($lsize(Jnn_2), cj_1, cj_2)*)
 Return c
}

vshiftop (Jnn X N) vshif_u0 lane n = {
 If ((vshif_u0 == SHL)) {
   Return $ishl($lsize(Jnn), lane, n)
 }
 Assert(case(vshif_u0) == SHR)
 Let (SHR sx) = vshif_u0
 Return $ishr($lsize(Jnn), sx, lane, n)
}

inst_valtype moduleinst t = {
 Let dt* = moduleinst.TYPES
 Return $subst_all_valtype(t, dt*)
}

inst_reftype moduleinst rt = {
 Let dt* = moduleinst.TYPES
 Return $subst_all_reftype(rt, dt*)
}

default_ valty_u0 = {
 If (type(valty_u0) == Inn) {
   Let Inn = valty_u0
   Return ?((Inn.CONST 0))
 }
 If (type(valty_u0) == Fnn) {
   Let Fnn = valty_u0
   Return ?((Fnn.CONST $fzero($size(Fnn))))
 }
 If (type(valty_u0) == Vnn) {
   Let Vnn = valty_u0
   Return ?((Vnn.CONST 0))
 }
 Assert(case(valty_u0) == REF)
 Let (REF y_0 ht) = valty_u0
 If ((y_0 == (NULL ?(())))) {
   Return ?((REF.NULL ht))
 }
 Assert((y_0 == (NULL ?())))
 Return ?()
}

packfield stora_u0 val_u1 = {
 Let val = val_u1
 If (type(stora_u0) == valtype) {
   Return val
 }
 Assert(case(val_u1) == CONST)
 Let (y_0.CONST i) = val_u1
 Assert((y_0 == I32))
 Assert(type(stora_u0) == packtype)
 Let packtype = stora_u0
 Return (PACK packtype $wrap(32, $psize(packtype), i))
}

unpackfield stora_u0 sx_u1? field_u2 = {
 If (!(sx_u1? != None)) {
   Assert(type(field_u2) == val)
   Let val = field_u2
   Assert(type(stora_u0) == valtype)
   Return val
 }
 Else {
   Let ?(sx) = sx_u1?
   Assert(case(field_u2) == PACK)
   Let (PACK packtype i) = field_u2
   Assert((stora_u0 == packtype))
   Return (I32.CONST $ext($psize(packtype), 32, sx, i))
 }
}

funcsxv exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xv* = exter_u0*
 If (case(y_0) == FUNC) {
   Let (FUNC fa) = y_0
   Return [fa] ++ $funcsxv(xv*)
 }
 Let [externval] ++ xv* = exter_u0*
 Return $funcsxv(xv*)
}

globalsxv exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xv* = exter_u0*
 If (case(y_0) == GLOBAL) {
   Let (GLOBAL ga) = y_0
   Return [ga] ++ $globalsxv(xv*)
 }
 Let [externval] ++ xv* = exter_u0*
 Return $globalsxv(xv*)
}

tablesxv exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xv* = exter_u0*
 If (case(y_0) == TABLE) {
   Let (TABLE ta) = y_0
   Return [ta] ++ $tablesxv(xv*)
 }
 Let [externval] ++ xv* = exter_u0*
 Return $tablesxv(xv*)
}

memsxv exter_u0* = {
 If ((exter_u0* == [])) {
   Return []
 }
 Let [y_0] ++ xv* = exter_u0*
 If (case(y_0) == MEM) {
   Let (MEM ma) = y_0
   Return [ma] ++ $memsxv(xv*)
 }
 Let [externval] ++ xv* = exter_u0*
 Return $memsxv(xv*)
}

store = {
 Return
}

frame = {
 Let f = current_frame()
 Return f
}

moduleinst = {
 Let f = current_frame()
 Return f.MODULE
}

funcinst = {
 Return s.FUNCS
}

globalinst = {
 Return s.GLOBALS
}

tableinst = {
 Return s.TABLES
}

meminst = {
 Return s.MEMS
}

eleminst = {
 Return s.ELEMS
}

datainst = {
 Return s.DATAS
}

structinst = {
 Return s.STRUCTS
}

arrayinst = {
 Return s.ARRAYS
}

type x = {
 Let f = current_frame()
 Return f.MODULE.TYPES[x]
}

func x = {
 Let f = current_frame()
 Return s.FUNCS[f.MODULE.FUNCS[x]]
}

global x = {
 Let f = current_frame()
 Return s.GLOBALS[f.MODULE.GLOBALS[x]]
}

table x = {
 Let f = current_frame()
 Return s.TABLES[f.MODULE.TABLES[x]]
}

mem x = {
 Let f = current_frame()
 Return s.MEMS[f.MODULE.MEMS[x]]
}

elem x = {
 Let f = current_frame()
 Return s.ELEMS[f.MODULE.ELEMS[x]]
}

data x = {
 Let f = current_frame()
 Return s.DATAS[f.MODULE.DATAS[x]]
}

local x = {
 Let f = current_frame()
 Return f.LOCALS[x]
}

with_local x v = {
 Let f = current_frame()
 f.LOCALS[x] := ?(v)
}

with_global x v = {
 Let f = current_frame()
 s.GLOBALS[f.MODULE.GLOBALS[x]].VALUE := v
}

with_table x i r = {
 Let f = current_frame()
 s.TABLES[f.MODULE.TABLES[x]].REFS[i] := r
}

with_tableinst x ti = {
 Let f = current_frame()
 s.TABLES[f.MODULE.TABLES[x]] := ti
}

with_mem x i j b* = {
 Let f = current_frame()
 s.MEMS[f.MODULE.MEMS[x]].BYTES[i : j] := b*
}

with_meminst x mi = {
 Let f = current_frame()
 s.MEMS[f.MODULE.MEMS[x]] := mi
}

with_elem x r* = {
 Let f = current_frame()
 s.ELEMS[f.MODULE.ELEMS[x]].REFS := r*
}

with_data x b* = {
 Let f = current_frame()
 s.DATAS[f.MODULE.DATAS[x]].BYTES := b*
}

with_struct a i fv = {
 s.STRUCTS[a].FIELDS[i] := fv
}

with_array a i fv = {
 s.ARRAYS[a].FIELDS[i] := fv
}

ext_structinst si* = {
 Let f = current_frame()
 Return (append(s.STRUCTS, si*), f)
}

ext_arrayinst ai* = {
 Let f = current_frame()
 Return (append(s.ARRAYS, ai*), f)
}

growtable tableinst n r = {
 Let { TYPE: ((i, j), rt); REFS: r'*; } = tableinst
 If (((|r'*| + n) ≤ j)) {
   Let i' = (|r'*| + n)
   Let tableinst' = { TYPE: ((i', j), rt); REFS: r'* ++ r^n; }
   Return tableinst'
 }
}

growmem meminst n = {
 Let { TYPE: (PAGE (i, j)); BYTES: b*; } = meminst
 If ((((|b*| / (64 · $Ki())) + n) ≤ j)) {
   Let i' = ((|b*| / (64 · $Ki())) + n)
   Let meminst' = { TYPE: (PAGE (i', j)); BYTES: b* ++ 0^(n · (64 · $Ki())); }
   Return meminst'
 }
}

with_locals C local_u0* local_u1* = {
 If (((local_u0* == []) && (local_u1* == []))) {
   Return C
 }
 Assert((|local_u1*| ≥ 1))
 Let [lct_1] ++ lct* = local_u1*
 Assert((|local_u0*| ≥ 1))
 Let [x_1] ++ x* = local_u0*
 Return $with_locals(update(C.LOCALS[x_1], lct_1), x*, lct*)
}

clos_deftypes defty_u0* = {
 If ((defty_u0* == [])) {
   Return []
 }
 Let dt* ++ [dt_n] = defty_u0*
 Let dt'* = $clos_deftypes(dt*)
 Return dt'* ++ [$subst_all_deftype(dt_n, dt'*)]
}

clos_valtype C t = {
 Let dt* = $clos_deftypes(C.TYPES)
 Return $subst_all_valtype(t, dt*)
}

clos_deftype C dt = {
 Let dt'* = $clos_deftypes(C.TYPES)
 Return $subst_all_deftype(dt, dt'*)
}

clos_moduletype C mmt = {
 Let dt* = $clos_deftypes(C.TYPES)
 Return $subst_all_moduletype(mmt, dt*)
}

before typeu_u0 x i = {
 If (type(typeu_u0) == deftype) {
   Return true
 }
 If (case(typeu_u0) == _IDX) {
   Let (_IDX typeidx) = typeu_u0
   Return (typeidx < x)
 }
 Assert(case(typeu_u0) == REC)
 Let (REC j) = typeu_u0
 Return (j < i)
}

unrollht C heapt_u0 = {
 If (type(heapt_u0) == deftype) {
   Let deftype = heapt_u0
   Return $unrolldt(deftype)
 }
 If (case(heapt_u0) == _IDX) {
   Let (_IDX typeidx) = heapt_u0
   Return $unrolldt(C.TYPES[typeidx])
 }
 Assert(case(heapt_u0) == REC)
 Let (REC i) = heapt_u0
 Return C.RECS[i]
}

funcidx_nonfuncs YetE (`%%%%%`_nonfuncs(global*{global : global}, table*{table : table}, mem*{mem : mem}, elem*{elem : elem}, data*{data : data})) = {
 Return $funcidx_module((MODULE [] [] [] global* table* mem* elem* data* [] []))
}

blocktype_ block_u0 = {
 If (case(block_u0) == _IDX) {
   Let (_IDX x) = block_u0
   Assert(case($expanddt($type(x))) == FUNC)
   Let (FUNC ft) = $expanddt($type(x))
   Return ft
 }
 Assert(case(block_u0) == _RESULT)
 Let (_RESULT t?) = block_u0
 Return ([] -> t?)
}

alloctypes type_u0* = {
 If ((type_u0* == [])) {
   Return []
 }
 Let type'* ++ [type] = type_u0*
 Assert(case(type) == TYPE)
 Let (TYPE rectype) = type
 Let deftype'* = $alloctypes(type'*)
 Let x = |deftype'*|
 Let deftype* = $subst_all_deftypes($rolldt(x, rectype), deftype'*)
 Return deftype'* ++ deftype*
}

allocfunc deftype funccode moduleinst = {
 Let funcinst = { TYPE: deftype; MODULE: moduleinst; CODE: funccode; }
 Let a = |s.FUNCS|
 funcinst :+ s.FUNCS
 Return a
}

allocfuncs defty_u0* funcc_u1* modul_u2* = {
 If ((defty_u0* == [])) {
   Assert((funcc_u1* == []))
   Assert((modul_u2* == []))
   Return []
 }
 Else {
   Let [dt] ++ dt'* = defty_u0*
   Assert((|funcc_u1*| ≥ 1))
   Let [funccode] ++ funccode'* = funcc_u1*
   Assert((|modul_u2*| ≥ 1))
   Let [moduleinst] ++ moduleinst'* = modul_u2*
   Let fa = $allocfunc(dt, funccode, moduleinst)
   Let fa'* = $allocfuncs(dt'*, funccode'*, moduleinst'*)
   Return [fa] ++ fa'*
 }
}

allocglobal globaltype val = {
 Let globalinst = { TYPE: globaltype; VALUE: val; }
 Let a = |s.GLOBALS|
 globalinst :+ s.GLOBALS
 Return a
}

allocglobals globa_u0* val_u1* = {
 If ((globa_u0* == [])) {
   Assert((val_u1* == []))
   Return []
 }
 Else {
   Let [globaltype] ++ globaltype'* = globa_u0*
   Assert((|val_u1*| ≥ 1))
   Let [val] ++ val'* = val_u1*
   Let ga = $allocglobal(globaltype, val)
   Let ga'* = $allocglobals(globaltype'*, val'*)
   Return [ga] ++ ga'*
 }
}

alloctable ((i, j), rt) ref = {
 Let tableinst = { TYPE: ((i, j), rt); REFS: ref^i; }
 Let a = |s.TABLES|
 tableinst :+ s.TABLES
 Return a
}

alloctables table_u0* ref_u1* = {
 If (((table_u0* == []) && (ref_u1* == []))) {
   Return []
 }
 Assert((|ref_u1*| ≥ 1))
 Let [ref] ++ ref'* = ref_u1*
 Assert((|table_u0*| ≥ 1))
 Let [tabletype] ++ tabletype'* = table_u0*
 Let ta = $alloctable(tabletype, ref)
 Let ta'* = $alloctables(tabletype'*, ref'*)
 Return [ta] ++ ta'*
}

allocmem (PAGE (i, j)) = {
 Let meminst = { TYPE: (PAGE (i, j)); BYTES: 0^(i · (64 · $Ki())); }
 Let a = |s.MEMS|
 meminst :+ s.MEMS
 Return a
}

allocmems memty_u0* = {
 If ((memty_u0* == [])) {
   Return []
 }
 Let [memtype] ++ memtype'* = memty_u0*
 Let ma = $allocmem(memtype)
 Let ma'* = $allocmems(memtype'*)
 Return [ma] ++ ma'*
}

allocelem elemtype ref* = {
 Let eleminst = { TYPE: elemtype; REFS: ref*; }
 Let a = |s.ELEMS|
 eleminst :+ s.ELEMS
 Return a
}

allocelems elemt_u0* ref_u1* = {
 If (((elemt_u0* == []) && (ref_u1* == []))) {
   Return []
 }
 Assert((|ref_u1*| ≥ 1))
 Let [ref*] ++ ref'** = ref_u1*
 Assert((|elemt_u0*| ≥ 1))
 Let [rt] ++ rt'* = elemt_u0*
 Let ea = $allocelem(rt, ref*)
 Let ea'* = $allocelems(rt'*, ref'**)
 Return [ea] ++ ea'*
}

allocdata OK byte* = {
 Let datainst = { BYTES: byte*; }
 Let a = |s.DATAS|
 datainst :+ s.DATAS
 Return a
}

allocdatas datat_u0* byte_u1* = {
 If (((datat_u0* == []) && (byte_u1* == []))) {
   Return []
 }
 Assert((|byte_u1*| ≥ 1))
 Let [b*] ++ b'** = byte_u1*
 Assert((|datat_u0*| ≥ 1))
 Let [ok] ++ ok'* = datat_u0*
 Let da = $allocdata(ok, b*)
 Let da'* = $allocdatas(ok'*, b'**)
 Return [da] ++ da'*
}

allocexport moduleinst (EXPORT name exter_u0) = {
 If (case(exter_u0) == FUNC) {
   Let (FUNC x) = exter_u0
   Return { NAME: name; VALUE: (FUNC moduleinst.FUNCS[x]); }
 }
 If (case(exter_u0) == GLOBAL) {
   Let (GLOBAL x) = exter_u0
   Return { NAME: name; VALUE: (GLOBAL moduleinst.GLOBALS[x]); }
 }
 If (case(exter_u0) == TABLE) {
   Let (TABLE x) = exter_u0
   Return { NAME: name; VALUE: (TABLE moduleinst.TABLES[x]); }
 }
 Assert(case(exter_u0) == MEM)
 Let (MEM x) = exter_u0
 Return { NAME: name; VALUE: (MEM moduleinst.MEMS[x]); }
}

allocexports moduleinst export* = {
 Return $allocexport(moduleinst, export)*
}

allocmodule module externval* val_G* ref_T* ref_E** = {
 Let fa_I* = $funcsxv(externval*)
 Let ga_I* = $globalsxv(externval*)
 Let ma_I* = $memsxv(externval*)
 Let ta_I* = $tablesxv(externval*)
 Assert(case(module) == MODULE)
 Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) = module
 Let fa* = (|s.FUNCS| + i_F)^(i_F<|func*|)
 Let ga* = (|s.GLOBALS| + i_G)^(i_G<|global*|)
 Let ta* = (|s.TABLES| + i_T)^(i_T<|table*|)
 Let ma* = (|s.MEMS| + i_M)^(i_M<|mem*|)
 Let ea* = (|s.ELEMS| + i_E)^(i_E<|elem*|)
 Let da* = (|s.DATAS| + i_D)^(i_D<|data*|)
 Let (MEMORY memtype)* = mem*
 Let dt* = $alloctypes(type*)
 Let (DATA byte* datamode)* = data*
 Let (GLOBAL globaltype expr_G)* = global*
 Let (TABLE tabletype expr_T)* = table*
 Let (ELEM elemtype expr_E* elemmode)* = elem*
 Let (FUNC x local* expr_F)* = func*
 Let xi* = $allocexports({ TYPES: []; FUNCS: fa_I* ++ fa*; GLOBALS: ga_I* ++ ga*; TABLES: ta_I* ++ ta*; MEMS: ma_I* ++ ma*; ELEMS: []; DATAS: []; EXPORTS: []; }, export*)
 Let moduleinst = { TYPES: dt*; FUNCS: fa_I* ++ fa*; GLOBALS: ga_I* ++ ga*; TABLES: ta_I* ++ ta*; MEMS: ma_I* ++ ma*; ELEMS: ea*; DATAS: da*; EXPORTS: xi*; }
 Let y_0 = $allocfuncs(dt*[x]*, (FUNC x local* expr_F)*, moduleinst^|func*|)
 Assert((y_0 == fa*))
 Let y_0 = $allocglobals(globaltype*, val_G*)
 Assert((y_0 == ga*))
 Let y_0 = $alloctables(tabletype*, ref_T*)
 Assert((y_0 == ta*))
 Let y_0 = $allocmems(memtype*)
 Assert((y_0 == ma*))
 Let y_0 = $allocelems(elemtype*, ref_E**)
 Assert((y_0 == ea*))
 Let y_0 = $allocdatas(OK^|data*|, byte**)
 Assert((y_0 == da*))
 Return moduleinst
}

runelem_ x (ELEM rt e^n elemm_u0) = {
 If ((elemm_u0 == PASSIVE)) {
   Return []
 }
 If ((elemm_u0 == DECLARE)) {
   Return [(ELEM.DROP x)]
 }
 Assert(case(elemm_u0) == ACTIVE)
 Let (ACTIVE y instr*) = elemm_u0
 Return instr* ++ [(I32.CONST 0), (I32.CONST n), (TABLE.INIT y x), (ELEM.DROP x)]
}

rundata_ x (DATA b^n datam_u0) = {
 If ((datam_u0 == PASSIVE)) {
   Return []
 }
 Assert(case(datam_u0) == ACTIVE)
 Let (ACTIVE y instr*) = datam_u0
 Return instr* ++ [(I32.CONST 0), (I32.CONST n), (MEMORY.INIT y x), (DATA.DROP x)]
}

instantiate module externval* = {
 Assert(case(module) == MODULE)
 Let (MODULE type* import* func* global* table* mem* elem* data* start? export*) = module
 Let instr_D* = $concat_($rundata_(i_D, data*[i_D])^(i_D<|data*|))
 Let instr_E* = $concat_($runelem_(i_E, elem*[i_E])^(i_E<|elem*|))
 Let (START x)? = start?
 Let moduleinst_0 = { TYPES: $alloctypes(type*); FUNCS: $funcsxv(externval*) ++ (|s.FUNCS| + i_F)^(i_F<|func*|); GLOBALS: $globalsxv(externval*); TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }
 Let (GLOBAL globaltype expr_G)* = global*
 Let (TABLE tabletype expr_T)* = table*
 Let (ELEM reftype expr_E* elemmode)* = elem*
 Let instr_S? = (CALL x)?
 Let z = { LOCALS: []; MODULE: moduleinst_0; }
 Push(callframe(z))
 Let [val_G]* = $eval_expr(expr_G)*
 Pop(callframe(z))
 Push(callframe(z))
 Let [ref_T]* = $eval_expr(expr_T)*
 Pop(callframe(z))
 Push(callframe(z))
 Let [ref_E]** = $eval_expr(expr_E)**
 Pop(callframe(z))
 Let moduleinst = $allocmodule(module, externval*, val_G*, ref_T*, ref_E**)
 Let f = { LOCALS: []; MODULE: moduleinst; }
 Push(callframe(0, f))
 Execute instr_E*
 Execute instr_D*
 If (instr_S? != None) {
   Let ?(instr_0) = instr_S?
   Execute instr_0
 }
 Pop(callframe(0, f))
 Return f.MODULE
}

invoke funcaddr val* = {
 Let f = { LOCALS: []; MODULE: { TYPES: []; FUNCS: []; GLOBALS: []; TABLES: []; MEMS: []; ELEMS: []; DATAS: []; EXPORTS: []; }; }
 Assert(case($expanddt(s.FUNCS[funcaddr].TYPE)) == FUNC)
 Let (FUNC y_0) = $expanddt(s.FUNCS[funcaddr].TYPE)
 Let (t_1* -> t_2*) = y_0
 Let k = |t_2*|
 Push(callframe(k, f))
 Push(val*)
 Push((REF.FUNC_ADDR funcaddr))
 Execute (CALL_REF s.FUNCS[funcaddr].TYPE)
 Pop_all(val*)
 Pop(callframe(k, f))
 Push(val*)
 Pop(val^k)
 Return val^k
}

allocXs X_u0* Y_u1* = {
 If ((X_u0* == [])) {
   Assert((Y_u1* == []))
   Return []
 }
 Else {
   Let [X] ++ X'* = X_u0*
   Assert((|Y_u1*| ≥ 1))
   Let [Y] ++ Y'* = Y_u1*
   Let a = $allocX(X, Y)
   Let a'* = $allocXs(X'*, Y'*)
   Return [a] ++ a'*
 }
}

execution_of_UNREACHABLE = {
 Trap
}

execution_of_NOP = {
 Nop
}

execution_of_DROP = {
 Assert(top_value())
 Pop(val)
 Nop
}

execution_of_SELECT t*? = {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 Assert(top_value())
 Pop(val_2)
 Assert(top_value())
 Pop(val_1)
 If ((c != 0)) {
   Push(val_1)
 }
 Else {
   Push(val_2)
 }
}

execution_of_IF bt instr_1* instr_2* = {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 If ((c != 0)) {
   Execute (BLOCK bt instr_1*)
 }
 Else {
   Execute (BLOCK bt instr_2*)
 }
}

execution_of_LABEL_ = {
 Pop_all(val*)
 Assert(top_label())
 Pop(current_label())
 Push(val*)
}

execution_of_BR l = {
 Pop_all(val*)
 Let L = current_label()
 Let n = arity(L)
 Let instr'* = cont(L)
 Pop(current_label())
 Let instr_u0* = val*
 If (((l == 0) && (|instr_u0*| ≥ n))) {
   Let val'* ++ val^n = instr_u0*
   Push(val^n)
   Execute instr'*
 }
 If ((l > 0)) {
   Let val* = instr_u0*
   Push(val*)
   Execute (BR (l - 1))
 }
}

execution_of_BR_IF l = {
 Assert(top_value(I32))
 Pop((I32.CONST c))
 If ((c != 0)) {
   Execute (BR l)
 }
 Else {
   Nop
 }
}

execution_of_BR_TABLE l* l' = {
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i < |l*|)) {
   Execute (BR l*[i])
 }
 Else {
   Execute (BR l')
 }
}

execution_of_BR_ON_NULL l = {
 Assert(top_value())
 Pop(val)
 If (case(val) == REF.NULL) {
   Execute (BR l)
 }
 Else {
   Push(val)
 }
}

execution_of_BR_ON_NON_NULL l = {
 Assert(top_value())
 Pop(val)
 If (case(val) == REF.NULL) {
   Nop
 }
 Else {
   Push(val)
   Execute (BR l)
 }
}

execution_of_CALL_INDIRECT x yy = {
 Execute (TABLE.GET x)
 Execute (REF.CAST (REF (NULL ?(())) yy))
 Execute (CALL_REF yy)
}

execution_of_RETURN_CALL_INDIRECT x yy = {
 Execute (TABLE.GET x)
 Execute (REF.CAST (REF (NULL ?(())) yy))
 Execute (RETURN_CALL_REF yy)
}

execution_of_FRAME_ = {
 Let f = current_frame()
 Let n = arity(f)
 Assert(top_values(n))
 Pop(val^n)
 Assert(top_frame())
 Pop(current_frame())
 Push(val^n)
}

execution_of_RETURN = {
 Pop_all(val*)
 If (top_frame()) {
   Let F = current_frame()
   Let n = arity(F)
   Pop(current_frame())
   Let val'* ++ val^n = val*
   Push(val^n)
 }
 Else if (top_label()) {
   Pop(current_label())
   Push(val*)
   Execute RETURN
 }
}

execution_of_TRAP = {
 YetI: TODO: It is likely that the value stack of two rules are different.
}

execution_of_UNOP nt unop = {
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 If ((|$unop(nt, unop, c_1)| == 1)) {
   Let [c] = $unop(nt, unop, c_1)
   Push((nt.CONST c))
 }
 If (($unop(nt, unop, c_1) == [])) {
   Trap
 }
}

execution_of_BINOP nt binop = {
 Assert(top_value(nt))
 Pop((nt.CONST c_2))
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 If ((|$binop(nt, binop, c_1, c_2)| == 1)) {
   Let [c] = $binop(nt, binop, c_1, c_2)
   Push((nt.CONST c))
 }
 If (($binop(nt, binop, c_1, c_2) == [])) {
   Trap
 }
}

execution_of_TESTOP nt testop = {
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 Let c = $testop(nt, testop, c_1)
 Push((I32.CONST c))
}

execution_of_RELOP nt relop = {
 Assert(top_value(nt))
 Pop((nt.CONST c_2))
 Assert(top_value(nt))
 Pop((nt.CONST c_1))
 Let c = $relop(nt, relop, c_1, c_2)
 Push((I32.CONST c))
}

execution_of_CVTOP nt_2 nt_1 cvtop = {
 Assert(top_value(nt_1))
 Pop((nt_1.CONST c_1))
 If ((|$cvtop(nt_1, nt_2, cvtop, c_1)| == 1)) {
   Let [c] = $cvtop(nt_1, nt_2, cvtop, c_1)
   Push((nt_2.CONST c))
 }
 If (($cvtop(nt_1, nt_2, cvtop, c_1) == [])) {
   Trap
 }
}

execution_of_REF.I31 = {
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Push((REF.I31_NUM $wrap(32, 31, i)))
}

execution_of_REF.IS_NULL = {
 Assert(top_value())
 Pop(ref)
 If (case(ref) == REF.NULL) {
   Push((I32.CONST 1))
 }
 Else {
   Push((I32.CONST 0))
 }
}

execution_of_REF.AS_NON_NULL = {
 Assert(top_value())
 Pop(ref)
 If (case(ref) == REF.NULL) {
   Trap
 }
 Push(ref)
}

execution_of_REF.EQ = {
 Assert(top_value())
 Pop(ref_2)
 Assert(top_value())
 Pop(ref_1)
 If ((case(ref_1) == REF.NULL && case(ref_2) == REF.NULL)) {
   Push((I32.CONST 1))
 }
 Else if ((ref_1 == ref_2)) {
   Push((I32.CONST 1))
 }
 Else {
   Push((I32.CONST 0))
 }
}

execution_of_I31.GET sx = {
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.I31_NUM) {
   Let (REF.I31_NUM i) = instr_u0
   Push((I32.CONST $ext(31, 32, sx, i)))
 }
}

execution_of_ARRAY.NEW x = {
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(val)
 Push(val^n)
 Execute (ARRAY.NEW_FIXED x n)
}

execution_of_EXTERN.CONVERT_ANY = {
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Push((REF.NULL EXTERN))
 }
 If (type(instr_u0) == addrref) {
   Let addrref = instr_u0
   Push((REF.EXTERN addrref))
 }
}

execution_of_ANY.CONVERT_EXTERN = {
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Push((REF.NULL ANY))
 }
 If (case(instr_u0) == REF.EXTERN) {
   Let (REF.EXTERN addrref) = instr_u0
   Push(addrref)
 }
}

execution_of_VVUNOP V128 vvunop = {
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vvunop(V128, vvunop, c_1)
 Push((V128.CONST c))
}

execution_of_VVBINOP V128 vvbinop = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vvbinop(V128, vvbinop, c_1, c_2)
 Push((V128.CONST c))
}

execution_of_VVTERNOP V128 vvternop = {
 Assert(top_value())
 Pop((V128.CONST c_3))
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vvternop(V128, vvternop, c_1, c_2, c_3)
 Push((V128.CONST c))
}

execution_of_VVTESTOP V128 ANY_TRUE = {
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $ine($vsize(V128), c_1, 0)
 Push((I32.CONST c))
}

execution_of_VUNOP sh vunop = {
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vunop(sh, vunop, c_1)
 Push((V128.CONST c))
}

execution_of_VBINOP sh vbinop = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 If ((|$vbinop(sh, vbinop, c_1, c_2)| == 1)) {
   Let [c] = $vbinop(sh, vbinop, c_1, c_2)
   Push((V128.CONST c))
 }
 If (($vbinop(sh, vbinop, c_1, c_2) == [])) {
   Trap
 }
}

execution_of_VTESTOP (Jnn X M) ALL_TRUE = {
 Assert(top_value())
 Pop((V128.CONST c))
 Let ci_1* = $lanes_((Jnn X M), c)
 If ((ci_1 != 0)*) {
   Push((I32.CONST 1))
 }
 Else {
   Push((I32.CONST 0))
 }
}

execution_of_VRELOP sh vrelop = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vrelop(sh, vrelop, c_1, c_2)
 Push((V128.CONST c))
}

execution_of_VSHIFTOP (Jnn X M) vshiftop = {
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c'* = $lanes_((Jnn X M), c_1)
 Let c = $invlanes_((Jnn X M), $vshiftop((Jnn X M), vshiftop, c', n)*)
 Push((V128.CONST c))
}

execution_of_VBITMASK (Jnn X M) = {
 Assert(top_value())
 Pop((V128.CONST c))
 Let ci_1* = $lanes_((Jnn X M), c)
 Let ci = $inverse_of_ibits(32, $ilt($lsize(Jnn), S, ci_1, 0)*)
 Push((I32.CONST ci))
}

execution_of_VSWIZZLE (Pnn X M) = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c* = $lanes_((Pnn X M), c_1) ++ 0^(256 - M)
 Let ci* = $lanes_((Pnn X M), c_2)
 Assert((ci*[k] < |c*|)^(k<M))
 Assert((k < |ci*|)^(k<M))
 Let c' = $invlanes_((Pnn X M), c*[ci*[k]]^(k<M))
 Push((V128.CONST c'))
}

execution_of_VSHUFFLE (Pnn X M) i* = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Assert((k < |i*|)^(k<M))
 Let c'* = $lanes_((Pnn X M), c_1) ++ $lanes_((Pnn X M), c_2)
 Assert((i*[k] < |c'*|)^(k<M))
 Let c = $invlanes_((Pnn X M), c'*[i*[k]]^(k<M))
 Push((V128.CONST c))
}

execution_of_VSPLAT (Lnn X M) = {
 Assert(top_value($lunpack(Lnn)))
 Pop((nt_0.CONST c_1))
 Let c = $invlanes_((Lnn X M), $lpacknum(Lnn, c_1)^M)
 Push((V128.CONST c))
}

execution_of_VEXTRACT_LANE (lanet_u0 X M) sx_u1? i = {
 Assert(top_value())
 Pop((V128.CONST c_1))
 If ((!(sx_u1? != None) && type(lanet_u0) == numtype)) {
   Let nt = lanet_u0
   If ((i < |$lanes_((nt X M), c_1)|)) {
     Let c_2 = $lanes_((nt X M), c_1)[i]
     Push((nt.CONST c_2))
   }
 }
 If (type(lanet_u0) == packtype) {
   Let pt = lanet_u0
   If (sx_u1? != None) {
     Let ?(sx) = sx_u1?
     If ((i < |$lanes_((pt X M), c_1)|)) {
       Let c_2 = $ext($psize(pt), 32, sx, $lanes_((pt X M), c_1)[i])
       Push((I32.CONST c_2))
     }
   }
 }
}

execution_of_VREPLACE_LANE (Lnn X M) i = {
 Assert(top_value($lunpack(Lnn)))
 Pop((nt_0.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $invlanes_((Lnn X M), update($lanes_((Lnn X M), c_1)[i], $lpacknum(Lnn, c_2)))
 Push((V128.CONST c))
}

execution_of_VEXTUNOP sh_2 sh_1 vextunop sx = {
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vextunop(sh_1, sh_2, vextunop, sx, c_1)
 Push((V128.CONST c))
}

execution_of_VEXTBINOP sh_2 sh_1 vextbinop sx = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let c = $vextbinop(sh_1, sh_2, vextbinop, sx, c_1, c_2)
 Push((V128.CONST c))
}

execution_of_VNARROW (Jnn_2 X M_2) (Jnn_1 X M_1) sx = {
 Assert(top_value())
 Pop((V128.CONST c_2))
 Assert(top_value())
 Pop((V128.CONST c_1))
 Let ci_1* = $lanes_((Jnn_1 X M_1), c_1)
 Let ci_2* = $lanes_((Jnn_1 X M_1), c_2)
 Let cj_1* = $narrow($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_1)*
 Let cj_2* = $narrow($lsize(Jnn_1), $lsize(Jnn_2), sx, ci_2)*
 Let c = $invlanes_((Jnn_2 X M_2), cj_1* ++ cj_2*)
 Push((V128.CONST c))
}

execution_of_VCVTOP (lanet_u5 X n_u0) (lanet_u6 X n_u1) vcvtop half__u4? sx? zero__u13? = {
 Assert(top_value())
 Pop((V128.CONST c_1))
 If ((!(half__u4? != None) && !(zero__u13? != None))) {
   Let Lnn_1 = lanet_u6
   Let Lnn_2 = lanet_u5
   Let M = n_u1
   If ((n_u0 == M)) {
     Let c'* = $lanes_((Lnn_1 X M), c_1)
     Let c = $invlanes_((Lnn_2 X M), $vcvtop((Lnn_1 X M), (Lnn_2 X M), vcvtop, sx?, c')*)
     Push((V128.CONST c))
   }
 }
 If (!(zero__u13? != None)) {
   Let Lnn_1 = lanet_u6
   Let Lnn_2 = lanet_u5
   Let M_1 = n_u1
   Let M_2 = n_u0
   If (half__u4? != None) {
     Let ?(half) = half__u4?
     Let ci* = $lanes_((Lnn_1 X M_1), c_1)[$half((Lnn_1 X M_1), (Lnn_2 X M_2), half, 0, M_2) : M_2]
     Let c = $invlanes_((Lnn_2 X M_2), $vcvtop((Lnn_1 X M_1), (Lnn_2 X M_2), vcvtop, sx?, ci)*)
     Push((V128.CONST c))
   }
 }
 If (!(half__u4? != None)) {
   Let M_1 = n_u1
   Let M_2 = n_u0
   If (type(lanet_u6) == numtype) {
     Let nt_1 = lanet_u6
     If (type(lanet_u5) == numtype) {
       Let nt_2 = lanet_u5
       If (zero__u13? != None) {
         Let ci* = $lanes_((nt_1 X M_1), c_1)
         Let c = $invlanes_((nt_2 X M_2), $vcvtop((nt_1 X M_1), (nt_2 X M_2), vcvtop, sx?, ci)* ++ $zero(nt_2)^M_1)
         Push((V128.CONST c))
       }
     }
   }
 }
}

execution_of_LOCAL.TEE x = {
 Assert(top_value())
 Pop(val)
 Push(val)
 Push(val)
 Execute (LOCAL.SET x)
}

execution_of_BLOCK bt instr* = {
 Let z = current_state()
 Let (t_1^m -> t_2^n) = $blocktype_(z, bt)
 Assert(top_values(m))
 Pop(val^m)
 Let L = label(n, [])
 Enter (val^m ++ instr*, L) {
 }
}

execution_of_LOOP bt instr* = {
 Let z = current_state()
 Let (t_1^m -> t_2^n) = $blocktype_(z, bt)
 Assert(top_values(m))
 Pop(val^m)
 Let L = label(m, [(LOOP bt instr*)])
 Enter (val^m ++ instr*, L) {
 }
}

execution_of_BR_ON_CAST l rt_1 rt_2 = {
 Let f = current_frame()
 Assert(top_value())
 Pop(ref)
 Let rt = $ref_type_of(ref)
 If (!(rt <: $inst_reftype(f.MODULE, rt_2))) {
   Push(ref)
 }
 Else {
   Push(ref)
   Execute (BR l)
 }
}

execution_of_BR_ON_CAST_FAIL l rt_1 rt_2 = {
 Let f = current_frame()
 Assert(top_value())
 Pop(ref)
 Let rt = $ref_type_of(ref)
 If (rt <: $inst_reftype(f.MODULE, rt_2)) {
   Push(ref)
 }
 Else {
   Push(ref)
   Execute (BR l)
 }
}

execution_of_CALL x = {
 Let z = current_state()
 Assert((x < |$moduleinst(z).FUNCS|))
 Let a = $moduleinst(z).FUNCS[x]
 Assert((a < |$funcinst(z)|))
 Push((REF.FUNC_ADDR a))
 Execute (CALL_REF $funcinst(z)[a].TYPE)
}

execution_of_CALL_REF yy = {
 Let z = current_state()
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.FUNC_ADDR) {
   Let (REF.FUNC_ADDR a) = instr_u0
   If ((a < |$funcinst(z)|)) {
     Let fi = $funcinst(z)[a]
     Assert(case(fi.CODE) == FUNC)
     Let (FUNC x y_0 instr*) = fi.CODE
     Let (LOCAL t)* = y_0
     Assert(case($expanddt(fi.TYPE)) == FUNC)
     Let (FUNC y_0) = $expanddt(fi.TYPE)
     Let (t_1^n -> t_2^m) = y_0
     Assert(top_values(n))
     Pop(val^n)
     Let f = { LOCALS: ?(val)^n ++ $default_(t)*; MODULE: fi.MODULE; }
     Let F = callframe(m, f)
     Push(F)
     Let L = label(m, [])
     Enter (instr*, L) {
     }
   }
 }
}

execution_of_RETURN_CALL x = {
 Let z = current_state()
 Assert((x < |$moduleinst(z).FUNCS|))
 Let a = $moduleinst(z).FUNCS[x]
 Assert((a < |$funcinst(z)|))
 Push((REF.FUNC_ADDR a))
 Execute (RETURN_CALL_REF $funcinst(z)[a].TYPE)
}

execution_of_RETURN_CALL_REF yy = {
 Let z = current_state()
 Pop_all(val*)
 If (top_label()) {
   Pop(current_label())
   Push(val*)
   Execute (RETURN_CALL_REF yy)
 }
 Else if (top_frame()) {
   Pop(current_frame())
   Let instr_u1* ++ instr_u0 = val*
   If (case(instr_u0) == REF.FUNC_ADDR) {
     Let (REF.FUNC_ADDR a) = instr_u0
     If ((a < |$funcinst(z)|)) {
       Assert(case($expanddt($funcinst(z)[a].TYPE)) == FUNC)
       Let (FUNC y_0) = $expanddt($funcinst(z)[a].TYPE)
       Let (t_1^n -> t_2^m) = y_0
       If ((|instr_u1*| ≥ n)) {
         Let val'* ++ val^n = instr_u1*
         Push(val^n)
         Push((REF.FUNC_ADDR a))
         Execute (CALL_REF yy)
       }
     }
   }
   If (case(instr_u0) == REF.NULL) {
     Trap
   }
 }
}

execution_of_REF.NULL $idx(x) = {
 Let z = current_state()
 Push((REF.NULL $type(z, x)))
}

execution_of_REF.FUNC x = {
 Let z = current_state()
 Assert((x < |$moduleinst(z).FUNCS|))
 Push((REF.FUNC_ADDR $moduleinst(z).FUNCS[x]))
}

execution_of_REF.TEST rt = {
 Let f = current_frame()
 Assert(top_value())
 Pop(ref)
 Let rt' = $ref_type_of(ref)
 If (rt' <: $inst_reftype(f.MODULE, rt)) {
   Push((I32.CONST 1))
 }
 Else {
   Push((I32.CONST 0))
 }
}

execution_of_REF.CAST rt = {
 Let f = current_frame()
 Assert(top_value())
 Pop(ref)
 Let rt' = $ref_type_of(ref)
 If (!(rt' <: $inst_reftype(f.MODULE, rt))) {
   Trap
 }
 Push(ref)
}

execution_of_STRUCT.NEW_DEFAULT x = {
 Let z = current_state()
 Assert(case($expanddt($type(z, x))) == STRUCT)
 Let (STRUCT y_0) = $expanddt($type(z, x))
 Let (mut, zt)* = y_0
 Assert((|mut*| == |zt*|))
 Assert($default_($unpack(zt)) != None*)
 Let ?(val)* = $default_($unpack(zt))*
 Assert((|val*| == |zt*|))
 Push(val*)
 Execute (STRUCT.NEW x)
}

execution_of_STRUCT.GET sx? x i = {
 Let z = current_state()
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 Assert(case($expanddt($type(z, x))) == STRUCT)
 Let (STRUCT y_0) = $expanddt($type(z, x))
 Let (mut, zt)* = y_0
 If (case(instr_u0) == REF.STRUCT_ADDR) {
   Let (REF.STRUCT_ADDR a) = instr_u0
   If (((i < |$structinst(z)[a].FIELDS|) && ((a < |$structinst(z)|) && ((|mut*| == |zt*|) && (i < |zt*|))))) {
     Push($unpackfield(zt*[i], sx?, $structinst(z)[a].FIELDS[i]))
   }
 }
}

execution_of_ARRAY.NEW_DEFAULT x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(case($expanddt($type(z, x))) == ARRAY)
 Let (ARRAY y_0) = $expanddt($type(z, x))
 Let (mut, zt) = y_0
 Assert($default_($unpack(zt)) != None)
 Let ?(val) = $default_($unpack(zt))
 Push(val^n)
 Execute (ARRAY.NEW_FIXED x n)
}

execution_of_ARRAY.NEW_ELEM x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((i + n) > |$elem(z, y).REFS|)) {
   Trap
 }
 Let ref^n = $elem(z, y).REFS[i : n]
 Push(ref^n)
 Execute (ARRAY.NEW_FIXED x n)
}

execution_of_ARRAY.NEW_DATA x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(case($expanddt($type(z, x))) == ARRAY)
 Let (ARRAY y_0) = $expanddt($type(z, x))
 Let (mut, zt) = y_0
 If (((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|)) {
   Trap
 }
 Let $zbytes(zt, c)^n = $inverse_of_concat_($data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)])
 Push($const($cunpack(zt), $cunpacknum(zt, c))^n)
 Execute (ARRAY.NEW_FIXED x n)
}

execution_of_ARRAY.GET sx? x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If (((a < |$arrayinst(z)|) && (i ≥ |$arrayinst(z)[a].FIELDS|))) {
     Trap
   }
 }
 Assert(case($expanddt($type(z, x))) == ARRAY)
 Let (ARRAY y_0) = $expanddt($type(z, x))
 Let (mut, zt) = y_0
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If (((i < |$arrayinst(z)[a].FIELDS|) && (a < |$arrayinst(z)|))) {
     Push($unpackfield(zt, sx?, $arrayinst(z)[a].FIELDS[i]))
   }
 }
}

execution_of_ARRAY.LEN = {
 Let z = current_state()
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If ((a < |$arrayinst(z)|)) {
     Push((I32.CONST |$arrayinst(z)[a].FIELDS|))
   }
 }
}

execution_of_ARRAY.FILL x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(val)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If (((a < |$arrayinst(z)|) && ((i + n) > |$arrayinst(z)[a].FIELDS|))) {
     Trap
   }
   If ((n == 0)) {
     Nop
   }
   Else {
     Let (REF.ARRAY_ADDR a) = instr_u0
     Push((REF.ARRAY_ADDR a))
     Push((I32.CONST i))
     Push(val)
     Execute (ARRAY.SET x)
     Push((REF.ARRAY_ADDR a))
     Push((I32.CONST (i + 1)))
     Push(val)
     Push((I32.CONST (n - 1)))
     Execute (ARRAY.FILL x)
   }
 }
}

execution_of_ARRAY.COPY x_1 x_2 = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i_2))
 Assert(top_value())
 Pop(instr_u1)
 Assert(top_value(I32))
 Pop((I32.CONST i_1))
 Assert(top_value())
 Pop(instr_u0)
 If ((case(instr_u0) == REF.NULL && type(instr_u1) == ref)) {
   Trap
 }
 If ((case(instr_u1) == REF.NULL && type(instr_u0) == ref)) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a_1) = instr_u0
   If (case(instr_u1) == REF.ARRAY_ADDR) {
     If (((a_1 < |$arrayinst(z)|) && ((i_1 + n) > |$arrayinst(z)[a_1].FIELDS|))) {
       Trap
     }
     Let (REF.ARRAY_ADDR a_2) = instr_u1
     If (((a_2 < |$arrayinst(z)|) && ((i_2 + n) > |$arrayinst(z)[a_2].FIELDS|))) {
       Trap
     }
   }
   If ((n == 0)) {
     If (case(instr_u1) == REF.ARRAY_ADDR) {
       Nop
     }
   }
   Else if ((i_1 > i_2)) {
     Assert(case($expanddt($type(z, x_2))) == ARRAY)
     Let (ARRAY y_0) = $expanddt($type(z, x_2))
     Let (mut, zt_2) = y_0
     Let (REF.ARRAY_ADDR a_1) = instr_u0
     If (case(instr_u1) == REF.ARRAY_ADDR) {
       Let (REF.ARRAY_ADDR a_2) = instr_u1
       Let sx? = $sx(zt_2)
       Push((REF.ARRAY_ADDR a_1))
       Push((I32.CONST ((i_1 + n) - 1)))
       Push((REF.ARRAY_ADDR a_2))
       Push((I32.CONST ((i_2 + n) - 1)))
       Execute (ARRAY.GET sx? x_2)
       Execute (ARRAY.SET x_1)
       Push((REF.ARRAY_ADDR a_1))
       Push((I32.CONST i_1))
       Push((REF.ARRAY_ADDR a_2))
       Push((I32.CONST i_2))
       Push((I32.CONST (n - 1)))
       Execute (ARRAY.COPY x_1 x_2)
     }
   }
   Else {
     Assert(case($expanddt($type(z, x_2))) == ARRAY)
     Let (ARRAY y_0) = $expanddt($type(z, x_2))
     Let (mut, zt_2) = y_0
     Let (REF.ARRAY_ADDR a_1) = instr_u0
     If (case(instr_u1) == REF.ARRAY_ADDR) {
       Let (REF.ARRAY_ADDR a_2) = instr_u1
       Let sx? = $sx(zt_2)
       Push((REF.ARRAY_ADDR a_1))
       Push((I32.CONST i_1))
       Push((REF.ARRAY_ADDR a_2))
       Push((I32.CONST i_2))
       Execute (ARRAY.GET sx? x_2)
       Execute (ARRAY.SET x_1)
       Push((REF.ARRAY_ADDR a_1))
       Push((I32.CONST (i_1 + 1)))
       Push((REF.ARRAY_ADDR a_2))
       Push((I32.CONST (i_2 + 1)))
       Push((I32.CONST (n - 1)))
       Execute (ARRAY.COPY x_1 x_2)
     }
   }
 }
}

execution_of_ARRAY.INIT_ELEM x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If (((a < |$arrayinst(z)|) && ((i + n) > |$arrayinst(z)[a].FIELDS|))) {
     Trap
   }
 }
 If (((j + n) > |$elem(z, y).REFS|)) {
   If (case(instr_u0) == REF.ARRAY_ADDR) {
     Trap
   }
   If (((n == 0) && (j < |$elem(z, y).REFS|))) {
     Let ref = $elem(z, y).REFS[j]
     If (case(instr_u0) == REF.ARRAY_ADDR) {
       Let (REF.ARRAY_ADDR a) = instr_u0
       Push((REF.ARRAY_ADDR a))
       Push((I32.CONST i))
       Push(ref)
       Execute (ARRAY.SET x)
       Push((REF.ARRAY_ADDR a))
       Push((I32.CONST (i + 1)))
       Push((I32.CONST (j + 1)))
       Push((I32.CONST (n - 1)))
       Execute (ARRAY.INIT_ELEM x y)
     }
   }
 }
 Else if ((n == 0)) {
   If (case(instr_u0) == REF.ARRAY_ADDR) {
     Nop
   }
 }
 Else {
   If ((j < |$elem(z, y).REFS|)) {
     Let ref = $elem(z, y).REFS[j]
     If (case(instr_u0) == REF.ARRAY_ADDR) {
       Let (REF.ARRAY_ADDR a) = instr_u0
       Push((REF.ARRAY_ADDR a))
       Push((I32.CONST i))
       Push(ref)
       Execute (ARRAY.SET x)
       Push((REF.ARRAY_ADDR a))
       Push((I32.CONST (i + 1)))
       Push((I32.CONST (j + 1)))
       Push((I32.CONST (n - 1)))
       Execute (ARRAY.INIT_ELEM x y)
     }
   }
 }
}

execution_of_ARRAY.INIT_DATA x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If (((a < |$arrayinst(z)|) && ((i + n) > |$arrayinst(z)[a].FIELDS|))) {
     Trap
   }
 }
 If (!(case($expanddt($type(z, x))) == ARRAY)) {
   If (((n == 0) && case(instr_u0) == REF.ARRAY_ADDR)) {
     Nop
   }
 }
 Else {
   Let (ARRAY y_0) = $expanddt($type(z, x))
   Let (mut, zt) = y_0
   If (case(instr_u0) == REF.ARRAY_ADDR) {
     If (((j + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|)) {
       Trap
     }
     If ((n == 0)) {
       Nop
     }
     Else {
       Let (ARRAY y_0) = $expanddt($type(z, x))
       Let (mut, zt) = y_0
       Let (REF.ARRAY_ADDR a) = instr_u0
       Let c = $inverse_of_zbytes(zt, $data(z, y).BYTES[j : ($zsize(zt) / 8)])
       Push((REF.ARRAY_ADDR a))
       Push((I32.CONST i))
       Push($const($cunpack(zt), $cunpacknum(zt, c)))
       Execute (ARRAY.SET x)
       Push((REF.ARRAY_ADDR a))
       Push((I32.CONST (i + 1)))
       Push((I32.CONST (j + ($zsize(zt) / 8))))
       Push((I32.CONST (n - 1)))
       Execute (ARRAY.INIT_DATA x y)
     }
   }
 }
}

execution_of_LOCAL.GET x = {
 Let z = current_state()
 Assert($local(z, x) != None)
 Let ?(val) = $local(z, x)
 Push(val)
}

execution_of_GLOBAL.GET x = {
 Let z = current_state()
 Let val = $global(z, x).VALUE
 Push(val)
}

execution_of_TABLE.GET x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i ≥ |$table(z, x).REFS|)) {
   Trap
 }
 Push($table(z, x).REFS[i])
}

execution_of_TABLE.SIZE x = {
 Let z = current_state()
 Let n = |$table(z, x).REFS|
 Push((I32.CONST n))
}

execution_of_TABLE.FILL x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(val)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((i + n) > |$table(z, x).REFS|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   Push((I32.CONST i))
   Push(val)
   Execute (TABLE.SET x)
   Push((I32.CONST (i + 1)))
   Push(val)
   Push((I32.CONST (n - 1)))
   Execute (TABLE.FILL x)
 }
}

execution_of_TABLE.COPY x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$table(z, y).REFS|)) {
   Trap
 }
 If (((j + n) > |$table(z, x).REFS|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   If ((j ≤ i)) {
     Push((I32.CONST j))
     Push((I32.CONST i))
     Execute (TABLE.GET y)
     Execute (TABLE.SET x)
     Push((I32.CONST (j + 1)))
     Push((I32.CONST (i + 1)))
   }
   Else {
     Push((I32.CONST ((j + n) - 1)))
     Push((I32.CONST ((i + n) - 1)))
     Execute (TABLE.GET y)
     Execute (TABLE.SET x)
     Push((I32.CONST j))
     Push((I32.CONST i))
   }
   Push((I32.CONST (n - 1)))
   Execute (TABLE.COPY x y)
 }
}

execution_of_TABLE.INIT x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$elem(z, y).REFS|)) {
   Trap
 }
 If (((j + n) > |$table(z, x).REFS|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else if ((i < |$elem(z, y).REFS|)) {
   Push((I32.CONST j))
   Push($elem(z, y).REFS[i])
   Execute (TABLE.SET x)
   Push((I32.CONST (j + 1)))
   Push((I32.CONST (i + 1)))
   Push((I32.CONST (n - 1)))
   Execute (TABLE.INIT x y)
 }
}

execution_of_LOAD numty_u0 loado_u2? x ao = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (!(loado_u2? != None)) {
   Let nt = numty_u0
   If ((((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, x).BYTES|)) {
     Trap
   }
   Let c = $inverse_of_nbytes(nt, $mem(z, x).BYTES[(i + ao.OFFSET) : ($size(nt) / 8)])
   Push((nt.CONST c))
 }
 If (type(numty_u0) == Inn) {
   If (loado_u2? != None) {
     Let ?(y_0) = loado_u2?
     Let (n, sx) = y_0
     If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, x).BYTES|)) {
       Trap
     }
   }
   Let Inn = numty_u0
   If (loado_u2? != None) {
     Let ?(y_0) = loado_u2?
     Let (n, sx) = y_0
     Let c = $inverse_of_ibytes(n, $mem(z, x).BYTES[(i + ao.OFFSET) : (n / 8)])
     Push((Inn.CONST $ext(n, $size(Inn), sx, c)))
   }
 }
}

execution_of_VLOAD V128 vload_u0? x ao = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((((i + ao.OFFSET) + ($vsize(V128) / 8)) > |$mem(z, x).BYTES|) && !(vload_u0? != None))) {
   Trap
 }
 If (!(vload_u0? != None)) {
   Let c = $inverse_of_vbytes(V128, $mem(z, x).BYTES[(i + ao.OFFSET) : ($vsize(V128) / 8)])
   Push((V128.CONST c))
 }
 Else {
   Let ?(y_0) = vload_u0?
   If (case(y_0) == SHAPE) {
     Let (SHAPE M K sx) = y_0
     If ((((i + ao.OFFSET) + ((M · K) / 8)) > |$mem(z, x).BYTES|)) {
       Trap
     }
     If (type($inverse_of_lsizenn((M · 2))) == Jnn) {
       Let Jnn = $inverse_of_lsizenn((M · 2))
       Let j^K = $inverse_of_ibytes(M, $mem(z, x).BYTES[((i + ao.OFFSET) + ((k · M) / 8)) : (M / 8)])^(k<K)
       Let c = $invlanes_((Jnn X K), $ext(M, $lsizenn(Jnn), sx, j)^K)
       Push((V128.CONST c))
     }
   }
   If (case(y_0) == SPLAT) {
     Let (SPLAT N) = y_0
     If ((((i + ao.OFFSET) + (N / 8)) > |$mem(z, x).BYTES|)) {
       Trap
     }
     Let M = (128 / N)
     If (type($inverse_of_lsize(N)) == Jnn) {
       Let Jnn = $inverse_of_lsize(N)
       Let j = $inverse_of_ibytes(N, $mem(z, x).BYTES[(i + ao.OFFSET) : (N / 8)])
       Let c = $invlanes_((Jnn X M), j^M)
       Push((V128.CONST c))
     }
   }
   If (case(y_0) == ZERO) {
     Let (ZERO N) = y_0
     If ((((i + ao.OFFSET) + (N / 8)) > |$mem(z, x).BYTES|)) {
       Trap
     }
     Let j = $inverse_of_ibytes(N, $mem(z, x).BYTES[(i + ao.OFFSET) : (N / 8)])
     Let c = $ext(N, 128, U, j)
     Push((V128.CONST c))
   }
 }
}

execution_of_VLOAD_LANE V128 N x ao j = {
 Let z = current_state()
 Assert(top_value())
 Pop((V128.CONST c_1))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((((i + ao.OFFSET) + (N / 8)) > |$mem(z, x).BYTES|)) {
   Trap
 }
 Let M = ($vsize(V128) / N)
 If (type($inverse_of_lsize(N)) == Jnn) {
   Let Jnn = $inverse_of_lsize(N)
   Let k = $inverse_of_ibytes(N, $mem(z, x).BYTES[(i + ao.OFFSET) : (N / 8)])
   Let c = $invlanes_((Jnn X M), update($lanes_((Jnn X M), c_1)[j], k))
   Push((V128.CONST c))
 }
}

execution_of_MEMORY.SIZE x = {
 Let z = current_state()
 Let (n · (64 · $Ki())) = |$mem(z, x).BYTES|
 Push((I32.CONST n))
}

execution_of_MEMORY.FILL x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(val)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (((i + n) > |$mem(z, x).BYTES|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   Push((I32.CONST i))
   Push(val)
   Execute (STORE I32 ?(8) x $memarg0())
   Push((I32.CONST (i + 1)))
   Push(val)
   Push((I32.CONST (n - 1)))
   Execute (MEMORY.FILL x)
 }
}

execution_of_MEMORY.COPY x_1 x_2 = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i_2))
 Assert(top_value(I32))
 Pop((I32.CONST i_1))
 If (((i_1 + n) > |$mem(z, x_1).BYTES|)) {
   Trap
 }
 If (((i_2 + n) > |$mem(z, x_2).BYTES|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else {
   If ((i_1 ≤ i_2)) {
     Push((I32.CONST i_1))
     Push((I32.CONST i_2))
     Execute (LOAD I32 ?((8, U)) x_2 $memarg0())
     Execute (STORE I32 ?(8) x_1 $memarg0())
     Push((I32.CONST (i_1 + 1)))
     Push((I32.CONST (i_2 + 1)))
   }
   Else {
     Push((I32.CONST ((i_1 + n) - 1)))
     Push((I32.CONST ((i_2 + n) - 1)))
     Execute (LOAD I32 ?((8, U)) x_2 $memarg0())
     Execute (STORE I32 ?(8) x_1 $memarg0())
     Push((I32.CONST i_1))
     Push((I32.CONST i_2))
   }
   Push((I32.CONST (n - 1)))
   Execute (MEMORY.COPY x_1 x_2)
 }
}

execution_of_MEMORY.INIT x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value(I32))
 Pop((I32.CONST j))
 If (((i + n) > |$data(z, y).BYTES|)) {
   Trap
 }
 If (((j + n) > |$mem(z, x).BYTES|)) {
   Trap
 }
 If ((n == 0)) {
   Nop
 }
 Else if ((i < |$data(z, y).BYTES|)) {
   Push((I32.CONST j))
   Push((I32.CONST $data(z, y).BYTES[i]))
   Execute (STORE I32 ?(8) x $memarg0())
   Push((I32.CONST (j + 1)))
   Push((I32.CONST (i + 1)))
   Push((I32.CONST (n - 1)))
   Execute (MEMORY.INIT x y)
 }
}

execution_of_CTXT = {
 Pop_all(val*)
 YetI: TODO: translate_context.
 If (case(instr_u1) == LABEL_) {
   Let (LABEL_ n instr_0* instr*) = instr_u1
   YetI: TODO: translate_rulepr Step.
   Let L = label(n, instr_0*)
   Enter (instr'*, L) {
   }
 }
 YetI: TODO: translate_rulepr Step.
 If (case(instr_u1) == FRAME_) {
   Let (FRAME_ n y_0 instr*) = instr_u1
   If ((y_0 == f')) {
     Execute (FRAME_ n f' instr'*)
   }
 }
}

execution_of_STRUCT.NEW x = {
 Let z = current_state()
 Let a = |$structinst(z)|
 Assert(case($expanddt($type(z, x))) == STRUCT)
 Let (STRUCT y_0) = $expanddt($type(z, x))
 Let (mut, zt)^n = y_0
 Assert(top_values(n))
 Pop(val^n)
 Let si = { TYPE: $type(z, x); FIELDS: $packfield(zt, val)^n; }
 Push((REF.STRUCT_ADDR a))
 $ext_structinst(z, [si])
}

execution_of_STRUCT.SET x i = {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 Assert(case($expanddt($type(z, x))) == STRUCT)
 Let (STRUCT y_0) = $expanddt($type(z, x))
 Let (mut, zt)* = y_0
 If (case(instr_u0) == REF.STRUCT_ADDR) {
   Let (REF.STRUCT_ADDR a) = instr_u0
   If (((|mut*| == |zt*|) && (i < |zt*|))) {
     $with_struct(z, a, i, $packfield(zt*[i], val))
   }
 }
}

execution_of_ARRAY.NEW_FIXED x n = {
 Let z = current_state()
 Assert(top_values(n))
 Pop(val^n)
 Let a = |$arrayinst(z)|
 Assert(case($expanddt($type(z, x))) == ARRAY)
 Let (ARRAY y_0) = $expanddt($type(z, x))
 Let (mut, zt) = y_0
 Let ai = { TYPE: $type(z, x); FIELDS: $packfield(zt, val)^n; }
 Push((REF.ARRAY_ADDR a))
 $ext_arrayinst(z, [ai])
}

execution_of_ARRAY.SET x = {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 Assert(top_value())
 Pop(instr_u0)
 If (case(instr_u0) == REF.NULL) {
   Trap
 }
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   If (((a < |$arrayinst(z)|) && (i ≥ |$arrayinst(z)[a].FIELDS|))) {
     Trap
   }
 }
 Assert(case($expanddt($type(z, x))) == ARRAY)
 Let (ARRAY y_0) = $expanddt($type(z, x))
 Let (mut, zt) = y_0
 If (case(instr_u0) == REF.ARRAY_ADDR) {
   Let (REF.ARRAY_ADDR a) = instr_u0
   $with_array(z, a, i, $packfield(zt, val))
 }
}

execution_of_LOCAL.SET x = {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 $with_local(z, x, val)
}

execution_of_GLOBAL.SET x = {
 Let z = current_state()
 Assert(top_value())
 Pop(val)
 $with_global(z, x, val)
}

execution_of_TABLE.SET x = {
 Let z = current_state()
 Assert(top_value())
 Pop(ref)
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((i ≥ |$table(z, x).REFS|)) {
   Trap
 }
 $with_table(z, x, i, ref)
}

execution_of_TABLE.GROW x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value())
 Pop(ref)
 Either {
   Let ti = $growtable($table(z, x), n, ref)
   Push((I32.CONST |$table(z, x).REFS|))
   $with_tableinst(z, x, ti)
 }
 Or {
   Push((I32.CONST $invsigned(32, -(1))))
 }
}

execution_of_ELEM.DROP x = {
 Let z = current_state()
 $with_elem(z, x, [])
}

execution_of_STORE nt sz_u1? x ao = {
 Let z = current_state()
 Assert(top_value(numty_u0))
 Pop((numty_u0.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((numty_u0 == nt)) {
   If (((((i + ao.OFFSET) + ($size(nt) / 8)) > |$mem(z, x).BYTES|) && !(sz_u1? != None))) {
     Trap
   }
   If (!(sz_u1? != None)) {
     Let b* = $nbytes(nt, c)
     $with_mem(z, x, (i + ao.OFFSET), ($size(nt) / 8), b*)
   }
 }
 If (type(numty_u0) == Inn) {
   If (sz_u1? != None) {
     Let ?(n) = sz_u1?
     If ((((i + ao.OFFSET) + (n / 8)) > |$mem(z, x).BYTES|)) {
       Trap
     }
   }
   Let Inn = numty_u0
   If (sz_u1? != None) {
     Let ?(n) = sz_u1?
     Let b* = $ibytes(n, $wrap($size(Inn), n, c))
     $with_mem(z, x, (i + ao.OFFSET), (n / 8), b*)
   }
 }
}

execution_of_VSTORE V128 x ao = {
 Let z = current_state()
 Assert(top_value())
 Pop((V128.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((((i + ao.OFFSET) + ($vsize(V128) / 8)) > |$mem(z, x).BYTES|)) {
   Trap
 }
 Let b* = $vbytes(V128, c)
 $with_mem(z, x, (i + ao.OFFSET), ($vsize(V128) / 8), b*)
}

execution_of_VSTORE_LANE V128 N x ao j = {
 Let z = current_state()
 Assert(top_value())
 Pop((V128.CONST c))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If ((((i + ao.OFFSET) + N) > |$mem(z, x).BYTES|)) {
   Trap
 }
 Let M = (128 / N)
 If (type($inverse_of_lsize(N)) == Jnn) {
   Let Jnn = $inverse_of_lsize(N)
   If ((j < |$lanes_((Jnn X M), c)|)) {
     Let b* = $ibytes(N, $lanes_((Jnn X M), c)[j])
     $with_mem(z, x, (i + ao.OFFSET), (N / 8), b*)
   }
 }
}

execution_of_MEMORY.GROW x = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Either {
   Let mi = $growmem($mem(z, x), n)
   Push((I32.CONST (|$mem(z, x).BYTES| / (64 · $Ki()))))
   $with_meminst(z, x, mi)
 }
 Or {
   Push((I32.CONST $invsigned(32, -(1))))
 }
}

execution_of_DATA.DROP x = {
 Let z = current_state()
 $with_data(z, x, [])
}

eval_expr instr* = {
 Execute instr*
 Pop(val)
 Return [val]
}

group_bytes_by n byte* = {
 Let n' = |byte*|
 If ((n' ≥ n)) {
   Return [byte*[0 : n]] ++ $group_bytes_by(n, byte*[n : (n' - n)])
 }
 Return []
}

execution_of_ARRAY.NEW_DATA x y = {
 Let z = current_state()
 Assert(top_value(I32))
 Pop((I32.CONST n))
 Assert(top_value(I32))
 Pop((I32.CONST i))
 If (case($expanddt($type(z, x))) == ARRAY) {
   Let (ARRAY y_0) = $expanddt($type(z, x))
   Let (mut, zt) = y_0
   If (((i + ((n · $zsize(zt)) / 8)) > |$data(z, y).BYTES|)) {
     Trap
   }
   Let cnn = $cunpack(zt)
   Let b* = $data(z, y).BYTES[i : ((n · $zsize(zt)) / 8)]
   Let gb* = $group_bytes_by(($zsize(zt) / 8), b*)
   Let c^n = $inverse_of_ibytes($zsize(zt), gb)*
   Push((cnn.CONST c)^n)
   Execute (ARRAY.NEW_FIXED x n)
 }
}
== Complete.
```
