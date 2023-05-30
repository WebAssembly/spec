# Preview

```sh
$ (cd ../spec && dune exec ../src/exe-watsup/main.exe -- *.watsup -v -l --sideconditions --animate --prose --root "..") 2>/dev/null
watsup 0.3 generator
== Parsing...
== Elaboration...
== IL Validation...
== Side condition inference
== IL Validation...
== Animate
== IL Validation...
== Prose Generation...
Bubbleup semantics for br: Top of the stack is frame / label
Bubbleup semantics for return: Top of the stack is frame / label
Ki
1. Return 1024.

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
2. Replace s.TABLE[f.MODULE.TABLE[x]] with r*.

with_mem x i j b
1. Let f be the current frame.
2. Replace s.MEM[f.MODULE.MEM[x]][i : j] with b*.

with_memext x b
1. Let f be the current frame.
2. Replace s.MEM[f.MODULE.MEM[x]] with b*.

with_elem x r
1. Let f be the current frame.
2. Replace s.ELEM[f.MODULE.ELEM[x]] with r*.

with_data x b
1. Let f be the current frame.
2. Replace s.DATA[f.MODULE.DATA[x]] with b*.

unreachable
1. Trap.

nop
1. Do nothing.

drop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.

select t
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

block bt instr
1. Let [t_1^k]->[t_2^n] be bt.
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. If |t_1^k| is k and |t_2^n| is n and |val^k| is k, then:
  a. Let L be the label_n{[]}.
  b. Push L to the stack.
  c. Push val^k to the stack.
  d. Jump to instr*.
  e. Exit current context.

loop bt instr
1. Let [t_1^k]->[t_2^n] be bt.
2. Assert: Due to validation, there are at least k values on the top of the stack.
3. Pop val^k from the stack.
4. If |t_1^k| is k and |t_2^n| is n and |val^k| is k, then:
  a. Let L be the label_k{[(LOOP bt instr*)]}.
  b. Push L to the stack.
  c. Push val^k to the stack.
  d. Jump to instr*.
  e. Exit current context.

if bt instr_1 instr_2
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If c is not 0, then:
  a. Execute (BLOCK bt instr_1*).
4. Else:
  a. Execute (BLOCK bt instr_2*).

label n instr val
1. Pop val* from the stack.
2. Assert: Due to validation, the label L is now on the top of the stack.
3. Pop the label from the stack.
4. Push val* to the stack.

br
1. Pop _x2 ++ _x1 ++ _x0 from the stack.
2. Assert: Due to validation, the label L is now on the top of the stack.
3. Pop the label from the stack.
4. Let val'* be _x2.
5. Let val^n be _x1.
6. Let [(BR 0)] ++ instr* be _x0.
7. If |val^n| is n, then:
  a. Push val^n to the stack.
  b. Push instr'* to the stack.
8. Let val* be _x2.
9. If |_x1| is 1, then:
  a. Let [(BR (l + 1))] be _x1.
  b. Let instr* be _x0.
  c. Push val* to the stack.
  d. Execute (BR l).

br_if l
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST c) from the stack.
3. If c is not 0, then:
  a. Execute (BR l).

br_table l l'
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If i < |l*|, then:
  a. Execute (BR l*[i]).
4. Else:
  a. Execute (BR l').

frame n f val
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop val^n from the stack.
5. Assert: Due to validation, the frame F is now on the top of the stack.
6. Pop the frame from the stack.
7. If |val^n| is n, then:
  a. Push val^n to the stack.

return
1. If _x0 is of the case FRAME_, then:
  a. Let (FRAME_ n f val'* ++ val^n ++ [RETURN] ++ instr*) be _x0.
  b. If |val^n| is n, then:
    1) Push val^n to the stack.
2. If _x0 is of the case LABEL_, then:
  a. Let (LABEL_ k instr'* val* ++ [RETURN] ++ instr*) be _x0.
  b. Push val* to the stack.
  c. Execute RETURN.

unop nt unop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_1) from the stack.
3. If |$unop(unop, nt, c_1)| is 1, then:
  a. Let [c] be $unop(unop, nt, c_1).
  b. Push (nt.CONST c) to the stack.
4. If $unop(unop, nt, c_1) is [], then:
  a. Trap.

binop nt binop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop (nt.CONST c_1) from the stack.
5. If |$binop(binop, nt, c_1, c_2)| is 1, then:
  a. Let [c] be $binop(binop, nt, c_1, c_2).
  b. Push (nt.CONST c) to the stack.
6. If $binop(binop, nt, c_1, c_2) is [], then:
  a. Trap.

testop nt testop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_1) from the stack.
3. Let c be $testop(testop, nt, c_1).
4. Push (I32.CONST c) to the stack.

relop nt relop
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_2) from the stack.
3. Assert: Due to validation, a value of value type nt is on the top of the stack.
4. Pop (nt.CONST c_1) from the stack.
5. Let c be $relop(relop, nt, c_1, c_2).
6. Push (I32.CONST c) to the stack.

extend nt n
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Push (nt.CONST $ext(n, $size(nt), S, c)) to the stack.

cvtop nt_1 cvtop nt_2 sx
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c_1) from the stack.
3. If |$cvtop(nt_1, cvtop, nt_2, sx?, c_1)| is 1, then:
  a. Let [c] be $cvtop(nt_1, cvtop, nt_2, sx?, c_1).
  b. Push (nt.CONST c) to the stack.
4. If $cvtop(nt_1, cvtop, nt_2, sx?, c_1) is [], then:
  a. Trap.

ref.is_null
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. If val is not of the case REF.NULL, then:
  a. Push (I32.CONST 0) to the stack.
4. Else:
  a. Let (REF.NULL rt) be val.
  b. Push (I32.CONST 1) to the stack.

local.tee x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Push val to the stack.
4. Push val to the stack.
5. Execute (LOCAL.SET x).

call x
1. If x < |$funcaddr()|, then:
  a. Execute (CALL_ADDR $funcaddr()[x]).

call_indirect x ft
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
    1) Let (m, func) be $funcinst()[a].
    2) Execute (CALL_ADDR a).

call_addr a
1. If a < |$funcinst()|, then:
  a. Let (m, (FUNC [t_1^k]->[t_2^n] t* instr*)) be $funcinst()[a].
  b. Assert: Due to validation, there are at least k values on the top of the stack.
  c. Pop val^k from the stack.
  d. If |t_1^k| is k and |t_2^n| is n and |val^k| is k, then:
    1) Let f be { LOCAL: val^k ++ $default_(t)*; MODULE: m; }.
    2) Push the activation of f with arity n to the stack.
    3) Let L be the label_n{[]}.
    4) Push L to the stack.
    5) Jump to instr*.
    6) Exit current context.
    7) Exit current context.

ref.func x
1. If x < |$funcaddr()|, then:
  a. Push (REF.FUNC_ADDR $funcaddr()[x]) to the stack.

local.get x
1. Push $local(x) to the stack.

global.get x
1. Push $global(x) to the stack.

table.get x
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If i ≥ |$table(x)|, then:
  a. Trap.
4. Else:
  a. Push $table(x)[i] to the stack.

table.size x
1. Let n be |$table(x)|.
2. Push (I32.CONST n) to the stack.

table.fill x
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

table.copy x y
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
  b. Else:
    1) Push (I32.CONST ((j + n) - 1)) to the stack.
    2) Push (I32.CONST ((i + n) - 1)) to the stack.
  c. Execute (TABLE.GET y).
  d. Execute (TABLE.SET x).
  e. Push (I32.CONST (j + 1)) to the stack.
  f. Push (I32.CONST (i + 1)) to the stack.
  g. Push (I32.CONST (n - 1)) to the stack.
  h. Execute (TABLE.COPY x y).

table.init x y
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

load nt _x0 n_A n_O
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST i) from the stack.
3. If _x0 is not defined, then:
  a. If ((i + n_O) + ($size(nt) / 8)) ≥ |$mem(0)|, then:
    1) Trap.
  b. Let c be $inverse_of_bytes_($size(nt), $mem(0)[(i + n_O) : ($size(nt) / 8)]).
4. Else:
  a. Let ?([n, sx]) be _x0.
  b. If ((i + n_O) + (n / 8)) ≥ |$mem(0)|, then:
    1) Trap.
  c. Let c be $inverse_of_bytes_(n, $mem(0)[(i + n_O) : (n / 8)]).
5. Push (nt.CONST c) to the stack.

memory.size
1. Let ((n · 64) · $Ki()) be |$mem(0)|.
2. Push (I32.CONST n) to the stack.

memory.fill
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

memory.copy
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

memory.init x
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

local.set x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Perform $with_local(x, val).

global.set x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Perform $with_global(x, val).

table.set x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If i ≥ |$table(x)|, then:
  a. Trap.
6. Else:
  a. Perform $with_table(x, i, ref).

table.grow x
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop ref from the stack.
5. Either:
  a. Perform $with_tableext(x, ref^n).
  b. Push (I32.CONST |$table(x)|) to the stack.
6. Or:
  a. Push (I32.CONST -1) to the stack.

elem.drop x
1. Perform $with_elem(x, []).

store nt _x0 n_A n_O
1. Assert: Due to validation, a value of value type nt is on the top of the stack.
2. Pop (nt.CONST c) from the stack.
3. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
4. Pop (I32.CONST i) from the stack.
5. If _x0 is not defined, then:
  a. If ((i + n_O) + ($size(nt) / 8)) ≥ |$mem(0)|, then:
    1) Trap.
  b. Let b* be $bytes_($size(nt), c).
  c. Perform $with_mem(0, (i + n_O), ($size(nt) / 8), b*).
6. Else:
  a. Let ?(n) be _x0.
  b. If ((i + n_O) + (n / 8)) ≥ |$mem(0)|, then:
    1) Trap.
  c. Let b* be $bytes_(n, $wrap_([$size(nt), n], c)).
  d. Perform $with_mem(0, (i + n_O), (n / 8), b*).

memory.grow
1. Assert: Due to validation, a value of value type I32_numtype is on the top of the stack.
2. Pop (I32.CONST n) from the stack.
3. Either:
  a. Perform $with_memext(0, 0^((n · 64) · $Ki())).
  b. Push (I32.CONST |$mem(0)|) to the stack.
4. Or:
  a. Push (I32.CONST -1) to the stack.

data.drop x
1. Perform $with_data(x, []).

== Initializing AL interprter with generated AL...
** Manual algorithms **

br l
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

return
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

instantiation module
1. Let (MODULE _ global* _ _ _ data*) be module.
2. Let moduleinst_init be { FUNC: []; TABLE: []; }.
3. Let f_init be the activation of { LOCAL: []; MODULE: moduleinst_init; } with arity 0.
4. Push f_init to the stack.
5. Let val* be $exec_global(global)*.
6. Pop f_init from the stack.
7. Let moduleinst be $alloc_module(module, val*).
8. Let f be the activation of { LOCAL: []; MODULE: moduleinst; } with arity 0.
9. Push f to the stack.
10. For i in range |data*|:
  a. Let (DATA init mode) be data*[i].
  b. If mode is defined, then:
    1) Let ?((MEMORY memidx dinstrs*)) be mode.
    2) Assert: memidx is 0.
    3) Execute the sequence (dinstrs*).
    4) Execute (I32.CONST 0).
    5) Execute (I32.CONST |init|).
    6) Execute (MEMORY.INIT i).
    7) Execute (DATA.DROP i).
11. Pop f from the stack.

exec_global global
1. Let (GLOBAL _ instr*) be global.
2. Jump to instr*.
3. Pop val from the stack.
4. Return val.

alloc_module module val*
1. Let (MODULE func* global* table* memory* _ data*) be module.
2. Let funcaddr* be $alloc_func(func)*.
3. Let tableaddr* be $alloc_table(table)*.
4. Let globaladdr* be $alloc_global(val)*.
5. Let memoryaddr* be $alloc_memory(memory)*.
6. Let dataaddr* be $alloc_data(data)*.
7. Let moduleinst be { DATA: dataaddr*; FUNC: funcaddr*; GLOBAL: globaladdr*; MEM: memoryaddr*; TABLE: tableaddr*; }.
8. For i in range |s.FUNC|:
  a. Let (_, func') be s.FUNC[i].
  b. Replace s.FUNC[i] with (moduleinst, func').
9. Return moduleinst.

alloc_func func
1. Let a be |s.FUNC|.
2. Let dummy_module_inst be { FUNC: []; TABLE: []; }.
3. Let funcinst be (dummy_module_inst, func).
4. Append funcinst to the s.FUNC.
5. Return a.

alloc_global val
1. Let a be |s.GLOBAL|.
2. Append val to the s.GLOBAL.
3. Return a.

alloc_table table
1. Let (TABLE (n, _) reftype) be table.
2. Let a be |s.TABLE|.
3. Let tableinst be (REF.NULL reftype)^n.
4. Append tableinst to the s.TABLE.
5. Return a.

alloc_memory memory
1. Let (MEMORY (min, _)) be memory.
2. Let a be |s.MEM|.
3. Let memoryinst be 0^((min · 64) · $Ki()).
4. Append memoryinst to the s.MEM.
5. Return a.

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

== Interpreting AL...
sample.wast: [27/27] (100.00%)
forward.wast: [4/4] (100.00%)
float_misc.wast: [61/440] (13.86%)
table_copy.wast: [Uncaught exception in 0th assertion: This test contains a (register ...) command]
ref_null.wast: [2/2] (100.00%)
memory.wast: [16/45] (35.56%)
unwind.wast: [49/49] (100.00%)
call.wast: [45/70] (64.29%)
local_get.wast: [15/19] (78.95%)
fac.wast: [0/6] (0.00%)
func.wast: [78/96] (81.25%)
exports.wast: [4/9] (44.44%)
local_set.wast: [18/19] (94.74%)
linking.wast: [Uncaught exception in 0th assertion: This test contains a (register ...) command]
float_literals.wast: [Uncaught exception in 0th assertion: Module Instantiation failed due to float_of_string]
align.wast: [38/48] (79.17%)
if.wast: [99/123] (80.49%)
const.wast: [Uncaught exception in 0th assertion: Module Instantiation failed due to int_of_string]
f64_cmp.wast: [0/2400] (0.00%)
block.wast: [47/52] (90.38%)
labels.wast: [25/25] (100.00%)
switch.wast: [18/26] (69.23%)
i64.wast: [0/384] (0.00%)
memory_copy.wast: [Uncaught exception in 30th assertion: Direct invocation failed due to Backend_al.Interpreter.Trap]
stack.wast: [2/5] (40.00%)
loop.wast: [44/77] (57.14%)
conversions.wast: [0/593] (0.00%)
endianness.wast: [3/68] (4.41%)
return.wast: [63/63] (100.00%)
store.wast: [9/9] (100.00%)
memory_redundancy.wast: [1/4] (25.00%)
i32.wast: [243/374] (64.97%)
unreachable.wast: [63/63] (100.00%)
bulk.wast: [Uncaught exception in 7th assertion: Direct invocation failed due to Backend_al.Interpreter.Timeout]
traps.wast: [14/32] (43.75%)
local_tee.wast: [Uncaught exception in 0th assertion: Module Instantiation failed due to float_of_string]
f64_bitwise.wast: [0/360] (0.00%)
binary.wast: [Uncaught exception in 0th assertion: This test contains a binary module]
memory_grow.wast: [7/84] (8.33%)
call_indirect.wast: [25/132] (18.94%)
load.wast: [31/37] (83.78%)
memory_fill.wast: [Uncaught exception in 0th assertion: Direct invocation failed due to Backend_al.Interpreter.Trap]
memory_size.wast: [5/36] (13.89%)
imports.wast: [Uncaught exception in 0th assertion: This test contains a (register ...) command]
left-to-right.wast: [0/95] (0.00%)
ref_is_null.wast: [10/11] (90.91%)
memory_trap.wast: [Uncaught exception in 13th assertion: Module Instantiation failed due to Backend_al.Interpreter.Trap]
binary-leb128.wast: [Uncaught exception in 0th assertion: This test contains a binary module]
br_table.wast: [126/149] (84.56%)
select.wast: [66/118] (55.93%)
f32_bitwise.wast: [32/360] (8.89%)
memory_init.wast: [Uncaught exception in 30th assertion: Direct invocation failed due to Algorithm yet: memory.init 1 not found]
elem.wast: [Uncaught exception in 8th assertion: This test contains a (register ...) command]
table_get.wast: [5/9] (55.56%)
f32.wast: [1463/2500] (58.52%)
start.wast: [0/6] (0.00%)
float_exprs.wast: [Uncaught exception in 318th assertion: Direct invocation failed due to TODO: bytes of floats]
float_memory.wast: [Uncaught exception in 0th assertion: Module Instantiation failed due to float_of_string]
table_size.wast: [5/36] (13.89%)
table_set.wast: [13/18] (72.22%)
f32_cmp.wast: [1536/2400] (64.00%)
br_if.wast: [88/88] (100.00%)
ref_func.wast: [Uncaught exception in 0th assertion: This test contains a (register ...) command]
names.wast: [481/482] (99.79%)
unreached-valid.wast: [5/5] (100.00%)
table_fill.wast: [35/35] (100.00%)
data.wast: [Uncaught exception in 0th assertion: Module Instantiation failed due to Backend_al.Interpreter.Trap]
int_literals.wast: [Uncaught exception in 0th assertion: Module Instantiation failed due to int_of_string]
address.wast: [148/255] (58.04%)
table_grow.wast: [8/38] (21.05%)
func_ptrs.wast: [Uncaught exception in 3th assertion: Direct invocation failed due to Invalid_argument("index out of bounds")]
table_init.wast: [Uncaught exception in 0th assertion: This test contains a (register ...) command]
global.wast: [Uncaught exception in 0th assertion: Module Instantiation failed due to Not_found]
custom.wast: [Uncaught exception in 0th assertion: This test contains a binary module]
int_exprs.wast: [25/89] (28.09%)
f64.wast: [0/2500] (0.00%)
br.wast: [76/76] (100.00%)
nop.wast: [72/83] (86.75%)
Total [5340/15543] (34.36%; Normalized 56.15%)
== Complete.
```
