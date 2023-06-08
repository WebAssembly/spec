# Preview

```sh
$ (cd ../spec && dune exec ../src/exe-watsup/main.exe -- *.watsup -v -l --sideconditions --animate --prose)
watsup 0.3 generator
== Parsing...
== Elaboration...
== IL Validation...
== Side condition inference
== IL Validation...
== Animate
== IL Validation...
== Translating to AL...
Invalid premise `Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l'])` to be AL instr.
Invalid premise `(Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}` to be AL instr.
Invalid premise `(if (l < |C.LABEL_context|))*{l}` to be AL instr.
Invalid premise `(if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}` to be AL instr.
Invalid premise `(if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}` to be AL instr.
Bubbleup semantics for br: Top of the stack is frame / label
Bubbleup semantics for return: Top of the stack is frame / label

Ki
1. Return 1024.

min _x0 _x1
1. If _x0 is 0, then:
  a. Let j be _x1.
  b. Return 0.
2. Let i be _x0.
3. If _x1 is 0, then:
  a. Return 0.
4. Let (i + 1) be _x0.
5. Let (j + 1) be _x1.
6. Return $min(i, j).

size _x0
1. If _x0 is of the case I32, then:
  a. Return 32.
2. If _x0 is of the case I64, then:
  a. Return 64.
3. If _x0 is of the case F32, then:
  a. Return 32.
4. If _x0 is of the case F64, then:
  a. Return 64.
5. If _x0 is of the case V128, then:
  a. Return 128.

test_sub_ATOM_22 n_3_ATOM_y
1. Return 0.

curried_ n_1 n_2
1. Return (n_1 + n_2).

default_ _x0
1. If _x0 is of the case I32, then:
  a. Return (I32.CONST 0).
2. If _x0 is of the case I64, then:
  a. Return (I64.CONST 0).
3. If _x0 is of the case F32, then:
  a. Return (F32.CONST 0).
4. If _x0 is of the case F64, then:
  a. Return (F64.CONST 0).
5. If _x0 is of the case FUNCREF, then:
  a. Return (REF.NULL FUNCREF).
6. If _x0 is of the case EXTERNREF, then:
  a. Return (REF.NULL EXTERNREF).

funcaddr
1. Let f be the current frame.
2. Return f.MODULE.FUNC.

funcinst
1. Let f be the current frame.
2. Return s.FUNC.

func x
1. Let f be the current frame.
2. Return s.FUNC[f.MODULE.FUNC[x]].

global x
1. Let f be the current frame.
2. Return s.GLOBAL[f.MODULE.GLOBAL[x]].

table x
1. Let f be the current frame.
2. Return s.TABLE[f.MODULE.TABLE[x]].

mem x
1. Let f be the current frame.
2. Return s.MEM[f.MODULE.MEM[x]].

elem x
1. Let f be the current frame.
2. Return s.ELEM[f.MODULE.ELEM[x]].

data x
1. Let f be the current frame.
2. Return s.DATA[f.MODULE.DATA[x]].

local x
1. Let f be the current frame.
2. Return f.LOCAL[x].

with_local x v
1. Let f be the current frame.
2. Replace f.LOCAL[x] with v.

with_global x v
1. Let f be the current frame.
2. Replace s.GLOBAL[f.MODULE.GLOBAL[x]] with v.

with_table x i r
1. Let f be the current frame.
2. Replace s.TABLE[f.MODULE.TABLE[x]][i] with r.

with_tableext x r
1. Let f be the current frame.
2. Append the sequence r* to the s.TABLE[f.MODULE.TABLE[x]].

with_mem x i j b
1. Let f be the current frame.
2. Replace s.MEM[f.MODULE.MEM[x]][i : j] with b*.

with_memext x b
1. Let f be the current frame.
2. Append the sequence b* to the s.MEM[f.MODULE.MEM[x]].

with_elem x r
1. Let f be the current frame.
2. Replace s.ELEM[f.MODULE.ELEM[x]] with r*.

with_data x b
1. Let f be the current frame.
2. Replace s.DATA[f.MODULE.DATA[x]] with b*.

execution_of_unreachable
1. Trap.

execution_of_nop
1. Do nothing.

execution_of_drop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.

execution_of_select t
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val_2 from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop val_1 from the stack.
7. If c is not 0, then:
  a. Push val_1 to the stack.
8. Else:
  a. Push val_2 to the stack.

execution_of_block bt instr
1. Let [t_1^k]->[t_2^n] be bt.
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. Let L be the label_n{[]}.
5. Push L to the stack.
6. Push val^k to the stack.
7. Jump to instr*.
8. Exit current context.

execution_of_loop bt instr
1. Let [t_1^k]->[t_2^n] be bt.
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. Let L be the label_k{[(LOOP bt instr*)]}.
5. Push L to the stack.
6. Push val^k to the stack.
7. Jump to instr*.
8. Exit current context.

execution_of_if bt instr_1 instr_2
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If c is not 0, then:
  a. Execute (BLOCK bt instr_1*).
4. Else:
  a. Execute (BLOCK bt instr_2*).

execution_of_label n instr val
1. Pop val* from the stack.
2. Assert: Due to validation, the label L is now on the top of the stack.
3. Pop the label from the stack.
4. Push val* to the stack.

execution_of_br
1. Pop _x2 ++ _x1 ++ _x0 from the stack.
2. Assert: Due to validation, the label L is now on the top of the stack.
3. Pop the label from the stack.
4. Let val'* be _x2.
5. Let val^n be _x1.
6. Let [(BR 0)] ++ instr* be _x0.
7. Push val^n to the stack.
8. Push instr'* to the stack.
9. Let val* be _x2.
10. If |_x1| is 1, then:
  a. Let [(BR (l + 1))] be _x1.
  b. Let instr* be _x0.
  c. Push val* to the stack.
  d. Execute (BR l).

execution_of_br_if l
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If c is not 0, then:
  a. Execute (BR l).

execution_of_br_table l l'
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If i < |l*|, then:
  a. Execute (BR l*[i]).
4. Else:
  a. Execute (BR l').

execution_of_frame n f val
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop val^n from the stack.
5. Assert: Due to validation, the frame F is now on the top of the stack.
6. Pop the frame from the stack.
7. Push val^n to the stack.

execution_of_return
1. If _x0 is of the case FRAME_, then:
  a. Let (FRAME_ n f val'* ++ val^n ++ [RETURN] ++ instr*) be _x0.
  b. Push val^n to the stack.
2. If _x0 is of the case LABEL_, then:
  a. Let (LABEL_ k instr'* val* ++ [RETURN] ++ instr*) be _x0.
  b. Push val* to the stack.
  c. Execute RETURN.

execution_of_unop nt unop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_1) from the stack.
3. If |$unop(unop, nt, c_1)| is 1, then:
  a. Let [c] be $unop(unop, nt, c_1).
  b. Push (nt.CONST c) to the stack.
4. If $unop(unop, nt, c_1) is [], then:
  a. Trap.

execution_of_binop nt binop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop (nt.CONST c_1) from the stack.
5. If |$binop(binop, nt, c_1, c_2)| is 1, then:
  a. Let [c] be $binop(binop, nt, c_1, c_2).
  b. Push (nt.CONST c) to the stack.
6. If $binop(binop, nt, c_1, c_2) is [], then:
  a. Trap.

execution_of_testop nt testop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_1) from the stack.
3. Let c be $testop(testop, nt, c_1).
4. Push (I32.CONST c) to the stack.

execution_of_relop nt relop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop (nt.CONST c_1) from the stack.
5. Let c be $relop(relop, nt, c_1, c_2).
6. Push (I32.CONST c) to the stack.

execution_of_extend nt n
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Push (nt.CONST $ext(n, $size(nt), S, c)) to the stack.

execution_of_cvtop nt_2 cvtop nt_1 sx
1. Assert: Due to validation, a value of value type nt_1 is on the top of the stack.
2. Pop (nt_1.CONST c_1) from the stack.
3. If |$cvtop(nt_2, cvtop, nt_1, sx?, c_1)| is 1, then:
  a. Let [c] be $cvtop(nt_2, cvtop, nt_1, sx?, c_1).
  b. Push (nt_2.CONST c) to the stack.
4. If $cvtop(nt_2, cvtop, nt_1, sx?, c_1) is [], then:
  a. Trap.

execution_of_ref.is_null
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. If val is not of the case REF.NULL, then:
  a. Push (I32.CONST 0) to the stack.
4. Else:
  a. Let (REF.NULL rt) be val.
  b. Push (I32.CONST 1) to the stack.

execution_of_local.tee x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Push val to the stack.
4. Push val to the stack.
5. Execute (LOCAL.SET x).

execution_of_call x
1. If x < |$funcaddr()|, then:
  a. Execute (CALL_ADDR $funcaddr()[x]).

execution_of_call_indirect x ft
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If i ≥ |$table(x)|, then:
  a. Trap.
4. Else if $table(x)[i] is not of the case REF.FUNC_ADDR, then:
  a. Trap.
5. Else:
  a. Let (REF.FUNC_ADDR a) be $table(x)[i].
  b. If a ≥ |$funcinst()|, then:
    1) Trap.
  c. Else:
    1) Let (m, (FUNC bt t* instr*)) be $funcinst()[a].
    2) If ft is bt, then:
      a) Execute (CALL_ADDR a).
    3) Else:
      a) Trap.

execution_of_call_addr a
1. If a < |$funcinst()|, then:
  a. Let (m, (FUNC [t_1^k]->[t_2^n] t* instr*)) be $funcinst()[a].
  b. Assert: Due to validation, there are at least k values on the top of the stack.
  c. Pop val^k from the stack.
  d. Let f be { LOCAL: val^k ++ $default_(t)*; MODULE: m; }.
  e. Push the activation of f with arity n to the stack.
  f. Let L be the label_n{[]}.
  g. Push L to the stack.
  h. Jump to instr*.
  i. Exit current context.
  j. Exit current context.

execution_of_ref.func x
1. If x < |$funcaddr()|, then:
  a. Push (REF.FUNC_ADDR $funcaddr()[x]) to the stack.

execution_of_local.get x
1. Push $local(x) to the stack.

execution_of_global.get x
1. Push $global(x) to the stack.

execution_of_table.get x
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If i ≥ |$table(x)|, then:
  a. Trap.
4. Else:
  a. Push $table(x)[i] to the stack.

execution_of_table.size x
1. Let n be |$table(x)|.
2. Push (I32.CONST n) to the stack.

execution_of_table.fill x
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. If (i + n) > |$table(x)|, then:
  a. Trap.
8. Else if n is not 0, then:
  a. Push (I32.CONST i) to the stack.
  b. Push val to the stack.
  c. Execute (TABLE.SET x).
  d. Push (I32.CONST (i + 1)) to the stack.
  e. Push val to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (TABLE.FILL x).

execution_of_table.copy x y
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$table(y)| or (j + n) > |$table(x)|, then:
  a. Trap.
8. Else if n is not 0, then:
  a. If j ≤ i, then:
    1) Push (I32.CONST j) to the stack.
    2) Push (I32.CONST i) to the stack.
    3) Execute (TABLE.GET y).
    4) Execute (TABLE.SET x).
    5) Push (I32.CONST (j + 1)) to the stack.
    6) Push (I32.CONST (i + 1)) to the stack.
  b. Else:
    1) Push (I32.CONST ((j + n) - 1)) to the stack.
    2) Push (I32.CONST ((i + n) - 1)) to the stack.
    3) Execute (TABLE.GET y).
    4) Execute (TABLE.SET x).
    5) Push (I32.CONST j) to the stack.
    6) Push (I32.CONST i) to the stack.
  c. Push (I32.CONST (n - 1)) to the stack.
  d. Execute (TABLE.COPY x y).

execution_of_table.init x y
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$elem(y)| or (j + n) > |$table(x)|, then:
  a. Trap.
8. Else if n is not 0 and i < |$elem(y)|, then:
  a. Push (I32.CONST j) to the stack.
  b. Push $elem(y)[i] to the stack.
  c. Execute (TABLE.SET x).
  d. Push (I32.CONST (j + 1)) to the stack.
  e. Push (I32.CONST (i + 1)) to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (TABLE.INIT x y).

execution_of_load nt _x0 n_A n_O
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If _x0 is not defined, then:
  a. If ((i + n_O) + ($size(nt) / 8)) > |$mem(0)|, then:
    1) Trap.
  b. Let c be $inverse_of_bytes_($size(nt), $mem(0)[(i + n_O) : ($size(nt) / 8)]).
  c. Push (nt.CONST c) to the stack.
4. Else:
  a. Let ?([n, sx]) be _x0.
  b. If ((i + n_O) + (n / 8)) > |$mem(0)|, then:
    1) Trap.
  c. Let c be $inverse_of_bytes_(n, $mem(0)[(i + n_O) : (n / 8)]).
  d. Push (nt.CONST $ext(n, $size(nt), sx, c)) to the stack.

execution_of_memory.size
1. Let ((n · 64) · $Ki()) be |$mem(0)|.
2. Push (I32.CONST n) to the stack.

execution_of_memory.fill
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
6. Pop (I32.CONST i) from the stack.
7. If (i + n) > |$mem(0)|, then:
  a. Trap.
8. Else if n is not 0, then:
  a. Push (I32.CONST i) to the stack.
  b. Push val to the stack.
  c. Execute (STORE I32 ?(8) 0 0).
  d. Push (I32.CONST (i + 1)) to the stack.
  e. Push val to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute MEMORY.FILL.

execution_of_memory.copy
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$table(0)| or (j + n) > |$table(0)|, then:
  a. Trap.
8. Else if n is not 0, then:
  a. If j ≤ i, then:
    1) Push (I32.CONST j) to the stack.
    2) Push (I32.CONST i) to the stack.
    3) Execute (LOAD I32 ?([8, U]) 0 0).
    4) Execute (STORE I32 ?(8) 0 0).
    5) Push (I32.CONST (j + 1)) to the stack.
    6) Push (I32.CONST (i + 1)) to the stack.
  b. Else:
    1) Push (I32.CONST ((j + n) - 1)) to the stack.
    2) Push (I32.CONST ((i + n) - 1)) to the stack.
    3) Execute (LOAD I32 ?([8, U]) 0 0).
    4) Execute (STORE I32 ?(8) 0 0).
    5) Push (I32.CONST j) to the stack.
    6) Push (I32.CONST i) to the stack.
  c. Push (I32.CONST (n - 1)) to the stack.
  d. Execute MEMORY.COPY.

execution_of_memory.init x
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
6. Pop (I32.CONST j) from the stack.
7. If (i + n) > |$data(x)| or (j + n) > |$mem(0)|, then:
  a. Trap.
8. Else if n is not 0 and i < |$data(x)|, then:
  a. Push (I32.CONST j) to the stack.
  b. Push (I32.CONST $data(x)[i]) to the stack.
  c. Execute (STORE I32 ?(8) 0 0).
  d. Push (I32.CONST (j + 1)) to the stack.
  e. Push (I32.CONST (i + 1)) to the stack.
  f. Push (I32.CONST (n - 1)) to the stack.
  g. Execute (MEMORY.INIT x).

execution_of_local.set x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Perform $with_local(x, val).

execution_of_global.set x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Perform $with_global(x, val).

execution_of_table.set x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If i ≥ |$table(x)|, then:
  a. Trap.
6. Else:
  a. Perform $with_table(x, i, ref).

execution_of_table.grow x
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop ref from the stack.
5. Either:
  a. Push (I32.CONST |$table(x)|) to the stack.
  b. Perform $with_tableext(x, ref^n).
6. Or:
  a. Push (I32.CONST -1) to the stack.

execution_of_elem.drop x
1. Perform $with_elem(x, []).

execution_of_store nt _x0 n_A n_O
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If _x0 is not defined, then:
  a. If ((i + n_O) + ($size(nt) / 8)) > |$mem(0)|, then:
    1) Trap.
  b. Let b* be $bytes_($size(nt), c).
  c. Perform $with_mem(0, (i + n_O), ($size(nt) / 8), b*).
6. Else:
  a. Let ?(n) be _x0.
  b. If ((i + n_O) + (n / 8)) > |$mem(0)|, then:
    1) Trap.
  c. Let b* be $bytes_(n, $wrap_([$size(nt), n], c)).
  d. Perform $with_mem(0, (i + n_O), (n / 8), b*).

execution_of_memory.grow
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Either:
  a. Push (I32.CONST ((|$mem(0)| / 64) / $Ki())) to the stack.
  b. Perform $with_memext(0, 0^((n · 64) · $Ki())).
4. Or:
  a. Push (I32.CONST -1) to the stack.

execution_of_data.drop x
1. Perform $with_data(x, []).

validation_of_unreachable
1. The instruction is valid with type [t_1*]->[t_2*].

validation_of_nop
1. The instruction is valid with type []->[].

validation_of_drop
1. The instruction is valid with type [t]->[].

validation_of_select ?(t)
1. The instruction is valid with type [t, t, I32]->[t].

validation_of_block bt instr
1. Under the context C, bt must be valid with type [t_1*]->[t_2*].
2. Under the context C ++ { LABEL: t_2*; }, instr* must be valid with type [t_1*]->[t_2*].
3. The instruction is valid with type [t_1*]->[t_2*].

validation_of_loop bt instr
1. Under the context C, bt must be valid with type [t_1*]->[t_2*].
2. Under the context C ++ { LABEL: t_1*; }, instr* must be valid with type [t_1*]->[t_2*].
3. The instruction is valid with type [t_1*]->[t_2*].

validation_of_if bt instr_1 instr_2
1. Under the context C, bt must be valid with type [t_1*]->[t_2*].
2. Under the context C ++ { LABEL: t_2*; }, instr_1* must be valid with type [t_1*]->[t_2*].
3. Under the context C ++ { LABEL: t_2*; }, instr_2* must be valid with type [t_1*]->[t_2*].
4. The instruction is valid with type [t_1*]->[t_2*].

validation_of_br l
1. If l < |C.LABEL| and C.LABEL[l] is t*, then:
  a. The instruction is valid with type [t_1* ++ t*]->[t_2*].

validation_of_br_if l
1. If l < |C.LABEL| and C.LABEL[l] is t*, then:
  a. The instruction is valid with type [t* ++ [I32]]->[t*].

validation_of_br_table l l'
1. YetI: (if (l < |C.LABEL_context|))*{l}.
2. If l' < |C.LABEL|, then:
  a. YetI: (Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l]))*{l}.
  b. YetI: Resulttype_sub: `|-%*<:%*`(t*{t}, C.LABEL_context[l']).
  c. The instruction is valid with type [t_1* ++ t*]->[t_2*].

validation_of_return
1. If C.RETURN is ?(t*), then:
  a. The instruction is valid with type [t_1* ++ t*]->[t_2*].

validation_of_call x
1. If x < |C.FUNC| and C.FUNC[x] is [t_1*]->[t_2*], then:
  a. The instruction is valid with type [t_1*]->[t_2*].

validation_of_call_indirect x ft
1. If x < |C.TABLE| and C.TABLE[x] is YetE (MixE ([[], [], []], TupE ([VarE "lim", CaseE (Atom "FUNCREF", TupE ([]))]))) and ft is [t_1*]->[t_2*], then:
  a. The instruction is valid with type [t_1* ++ [I32]]->[t_2*].

validation_of_const nt c_nt
1. The instruction is valid with type []->[nt].

validation_of_unop nt unop
1. The instruction is valid with type [nt]->[nt].

validation_of_binop nt binop
1. The instruction is valid with type [nt, nt]->[nt].

validation_of_testop nt testop
1. The instruction is valid with type [nt]->[I32].

validation_of_relop nt relop
1. The instruction is valid with type [nt, nt]->[I32].

validation_of_extend nt n
1. If n ≤ $size(nt), then:
  a. The instruction is valid with type [nt]->[nt].

validation_of_reinterpret nt_1 REINTERPRET_cvtop nt_2 ?()
1. If nt_1 is not nt_2 and $size(nt_1) is $size(nt_2), then:
  a. The instruction is valid with type [nt_2]->[nt_1].

validation_of_convert in_1 CONVERT_cvtop in_2 sx
1. If in_1 is not in_2 and sx? is ?() <=> $size(in_1) > $size(in_2), then:
  a. The instruction is valid with type [in_2]->[in_1].

validation_of_ref.null rt
1. The instruction is valid with type []->[rt].

validation_of_ref.func x
1. If x < |C.FUNC| and C.FUNC[x] is ft, then:
  a. The instruction is valid with type []->[FUNCREF].

validation_of_ref.is_null
1. The instruction is valid with type [rt]->[I32].

validation_of_local.get x
1. If x < |C.LOCAL| and C.LOCAL[x] is t, then:
  a. The instruction is valid with type []->[t].

validation_of_local.set x
1. If x < |C.LOCAL| and C.LOCAL[x] is t, then:
  a. The instruction is valid with type [t]->[].

validation_of_local.tee x
1. If x < |C.LOCAL| and C.LOCAL[x] is t, then:
  a. The instruction is valid with type [t]->[t].

validation_of_global.get x
1. If x < |C.GLOBAL| and C.GLOBAL[x] is YetE (MixE ([[Atom "MUT"], [Quest], []], TupE ([IterE (TupE ([]), (Opt, [])), VarE "t"]))), then:
  a. The instruction is valid with type []->[t].

validation_of_global.set x
1. If x < |C.GLOBAL| and C.GLOBAL[x] is YetE (MixE ([[Atom "MUT"], [Quest], []], TupE ([OptE (TupE ([])), VarE "t"]))), then:
  a. The instruction is valid with type [t]->[].

validation_of_table.get x
1. If x < |C.TABLE| and C.TABLE[x] is YetE (MixE ([[], [], []], TupE ([VarE "lim", VarE "rt"]))), then:
  a. The instruction is valid with type [I32]->[rt].

validation_of_table.set x
1. If x < |C.TABLE| and C.TABLE[x] is YetE (MixE ([[], [], []], TupE ([VarE "lim", VarE "rt"]))), then:
  a. The instruction is valid with type [I32, rt]->[].

validation_of_table.size x
1. If x < |C.TABLE| and C.TABLE[x] is tt, then:
  a. The instruction is valid with type []->[I32].

validation_of_table.grow x
1. If x < |C.TABLE| and C.TABLE[x] is YetE (MixE ([[], [], []], TupE ([VarE "lim", VarE "rt"]))), then:
  a. The instruction is valid with type [rt, I32]->[I32].

validation_of_table.fill x
1. If x < |C.TABLE| and C.TABLE[x] is YetE (MixE ([[], [], []], TupE ([VarE "lim", VarE "rt"]))), then:
  a. The instruction is valid with type [I32, rt, I32]->[].

validation_of_table.copy x_1 x_2
1. If x_1 < |C.TABLE| and x_2 < |C.TABLE| and C.TABLE[x_1] is YetE (MixE ([[], [], []], TupE ([VarE "lim_1", VarE "rt"]))) and C.TABLE[x_2] is YetE (MixE ([[], [], []], TupE ([VarE "lim_2", VarE "rt"]))), then:
  a. The instruction is valid with type [I32, I32, I32]->[].

validation_of_table.init x_1 x_2
1. If x_1 < |C.TABLE| and x_2 < |C.ELEM| and C.TABLE[x_1] is YetE (MixE ([[], [], []], TupE ([VarE "lim", VarE "rt"]))) and C.ELEM[x_2] is rt, then:
  a. The instruction is valid with type [I32, I32, I32]->[].

validation_of_elem.drop x
1. If x < |C.ELEM| and C.ELEM[x] is rt, then:
  a. The instruction is valid with type []->[].

validation_of_memory.size
1. If 0 < |C.MEM| and C.MEM[0] is mt, then:
  a. The instruction is valid with type []->[I32].

validation_of_memory.grow
1. If 0 < |C.MEM| and C.MEM[0] is mt, then:
  a. The instruction is valid with type [I32]->[I32].

validation_of_memory.fill
1. If 0 < |C.MEM| and C.MEM[0] is mt, then:
  a. The instruction is valid with type [I32, I32, I32]->[I32].

validation_of_memory.copy
1. If 0 < |C.MEM| and C.MEM[0] is mt, then:
  a. The instruction is valid with type [I32, I32, I32]->[I32].

validation_of_memory.init x
1. If 0 < |C.MEM| and x < |C.DATA| and C.MEM[0] is mt and C.DATA[x] is YetE (MixE ([[Atom "OK"]], TupE ([]))), then:
  a. The instruction is valid with type [I32, I32, I32]->[I32].

validation_of_data.drop x
1. If x < |C.DATA| and C.DATA[x] is YetE (MixE ([[Atom "OK"]], TupE ([]))), then:
  a. The instruction is valid with type []->[].

validation_of_load nt (n, sx) n_A n_O
1. If 0 < |C.MEM| and n? is ?() <=> sx? is ?() and C.MEM[0] is mt and (2 ^ n_A) ≤ ($size(nt) / 8), then:
  a. YetI: (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}.
  b. If n? is ?() or nt is in, then:
    1) The instruction is valid with type [I32]->[nt].

validation_of_store nt n n_A n_O
1. If 0 < |C.MEM| and C.MEM[0] is mt and (2 ^ n_A) ≤ ($size(nt) / 8), then:
  a. YetI: (if (((2 ^ n_A) <= (n / 8)) /\ ((n / 8) < ($size(nt <: valtype) / 8))))?{n}.
  b. If n? is ?() or nt is in, then:
    1) The instruction is valid with type [I32, nt]->[].

execution_of_br l
1. If l is 0, then:
  a. Let L be the current label.
  b. Let n be the arity of L.
  c. Assert: Due to validation, there are at least n values on the top of the stack.
  d. Pop val^n from the stack.
  e. While the top of the stack is value, do:
    1) Pop val' from the stack.
  f. Exit current context.
  g. Push val^n to the stack.
  h. Execute the sequence (the continuation of L).
2. Else:
  a. Let L be the current label.
  b. Exit current context.
  c. Execute (BR (l - 1)).

execution_of_return
1. Pop all values val'* from the stack.
2. If the top of the stack is frame, then:
  a. Pop F from the stack.
  b. Let n be the arity of F.
  c. Push F to the stack.
  d. Push val'* to the stack.
  e. Pop val^n from the stack.
  f. Exit current context.
  g. Push val^n to the stack.
3. Else:
  a. Pop L from the stack.
  b. Push L to the stack.
  c. Push val'* to the stack.
  d. Exit current context.
  e. Execute RETURN.

instantiation module externval*
1. Let (MODULE _ _ _ _ _ elem* data* start? _) be module.
2. Let moduleinst be $alloc_module(module, externval*).
3. Let f be the activation of { LOCAL: []; MODULE: moduleinst; } with arity 0.
4. Push f to the stack.
5. For i in range |elem*|:
  a. Let (ELEM _ einit mode_opt) be elem*[i].
  b. If mode_opt is defined, then:
    1) Let ?(mode) be mode_opt.
    2) If mode is of the case TABLE, then:
      a) Let (TABLE tableidx einstrs*) be mode.
      b) Execute the sequence (einstrs*).
      c) Execute (I32.CONST 0).
      d) Execute (I32.CONST |einit|).
      e) Execute (TABLE.INIT tableidx i).
      f) Execute (ELEM.DROP i).
    3) If mode is of the case DECLARE, then:
      a) Execute (ELEM.DROP i).
6. For i in range |data*|:
  a. Let (DATA dinit mode) be data*[i].
  b. If mode is defined, then:
    1) Let ?((MEMORY memidx dinstrs*)) be mode.
    2) Assert: memidx is 0.
    3) Execute the sequence (dinstrs*).
    4) Execute (I32.CONST 0).
    5) Execute (I32.CONST |dinit|).
    6) Execute (MEMORY.INIT i).
    7) Execute (DATA.DROP i).
7. If start? is defined, then:
  a. Let ?((START start_idx)) be start?.
  b. Execute (CALL start_idx).
8. Pop f from the stack.
9. Return moduleinst.

alloc_module module externval*
1. Let (MODULE import* func* global* table* memory* elem* data* _ export*) be module.
2. Let moduleinst be { DATA: []; ELEM: []; EXPORT: []; FUNC: []; GLOBAL: []; MEM: []; TABLE: []; }.
3. For i in range |import*|:
  a. Let (IMPORT _ _ import_type) be import*[i].
  b. Let (EXPORT _ externuse) be externval*[i].
  c. If import_type is of the case FUNC and externuse is of the case FUNC, then:
    1) Let (FUNC funcaddr') be externuse.
    2) Append funcaddr' to the moduleinst.FUNC.
4. Let f_init be the activation of { LOCAL: []; MODULE: moduleinst; } with arity 0.
5. Push f_init to the stack.
6. Let funcaddr* be $alloc_func(func)*.
7. Append the sequence funcaddr* to the moduleinst.FUNC.
8. Let tableaddr* be $alloc_table(table)*.
9. Append the sequence tableaddr* to the moduleinst.TABLE.
10. Let globaladdr* be $alloc_global(global)*.
11. Append the sequence globaladdr* to the moduleinst.GLOBAL.
12. Let memoryaddr* be $alloc_memory(memory)*.
13. Append the sequence memoryaddr* to the moduleinst.MEM.
14. Let elemaddr* be $alloc_elem(elem)*.
15. Append the sequence elemaddr* to the moduleinst.ELEM.
16. Let dataaddr* be $alloc_data(data)*.
17. Append the sequence dataaddr* to the moduleinst.DATA.
18. Pop f_init from the stack.
19. For i in range |s.FUNC|:
  a. Let (_, func') be s.FUNC[i].
  b. Replace s.FUNC[i] with (moduleinst, func').
20. Append the sequence export* to the moduleinst.EXPORT.
21. Return moduleinst.

init_global global
1. Let (GLOBAL _ instr*) be global.
2. Jump to instr*.
3. Pop val from the stack.
4. Return val.

init_elem elem
1. Let (ELEM _ instr* _) be elem.
2. Let ref* be $exec_expr(instr)*.
3. Return ref*.

exec_expr instr*
1. Jump to instr*.
2. Pop val from the stack.
3. Return val.

alloc_func func
1. Let a be |s.FUNC|.
2. Let dummy_module_inst be { FUNC: []; TABLE: []; }.
3. Let funcinst be (dummy_module_inst, func).
4. Append funcinst to the s.FUNC.
5. Return a.

alloc_table table
1. Let (TABLE (n, _) reftype) be table.
2. Let a be |s.TABLE|.
3. Let tableinst be (REF.NULL reftype)^n.
4. Append tableinst to the s.TABLE.
5. Return a.

alloc_global global
1. Let a be |s.GLOBAL|.
2. Let val be $init_global(global).
3. Append val to the s.GLOBAL.
4. Return a.

alloc_memory memory
1. Let (MEMORY (min, _)) be memory.
2. Let a be |s.MEM|.
3. Let memoryinst be 0^((min · 64) · $Ki()).
4. Append memoryinst to the s.MEM.
5. Return a.

alloc_elem elem
1. Let a be |s.ELEM|.
2. Let ref* be $init_elem(elem).
3. Append ref* to the s.ELEM.
4. Return a.

alloc_data data
1. Let (DATA init _) be data.
2. Let a be |s.DATA|.
3. Append init to the s.DATA.
4. Return a.

invocation funcaddr val*
1. Let (_, func) be s.FUNC[funcaddr].
2. Let (FUNC functype _ _) be func.
3. Let [_^n]->[_^m] be functype.
4. Assert: |val*| is n.
5. Let f be the activation of { LOCAL: []; MODULE: { FUNC: []; TABLE: []; }; } with arity 0.
6. Push f to the stack.
7. Push val* to the stack.
8. Execute (CALL_ADDR funcaddr).
9. Pop val_res^m from the stack.
10. Pop f from the stack.
11. Return val_res^m.

== Complete.
```
