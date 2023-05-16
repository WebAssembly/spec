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
Animation failed:if ($bytes_($size(nt <: valtype), c) = $mem(z, 0)[(i + n_O) : ($size(nt <: valtype) / 8)])
Animation failed:where $bytes_($size(nt <: valtype), c) := $mem(z, 0)[(i + n_O) : ($size(nt <: valtype) / 8)]
Animation failed:if ($bytes_(n, c) = $mem(z, 0)[(i + n_O) : (n / 8)])
Animation failed:where $bytes_(n, c) := $mem(z, 0)[(i + n_O) : (n / 8)]
== IL Validation...
== Prose Generation...
Bubbleup semantics for br: Top of the stack is frame / label
Bubbleup semantics for return: Top of the stack is frame / label
Ki
1. Return 1024.

size t
1. If t is i32 or t is f32, then:
  a. Return 32.
2. If t is i64 or t is f64, then:
  a. Return 64.
3. If t is v128, then:
  a. Return 128.

test_sub_ATOM_22 n_3_ATOM_y
1. Return 0.

curried_ n_1 n_2
1. Return (n_1 + n_2).

default_ t
1. If t is i32, then:
  a. Return the value i32.CONST 0.
2. If t is i64, then:
  a. Return the value i64.CONST 0.
3. If t is f32, then:
  a. Return the value f32.CONST 0.
4. If t is f64, then:
  a. Return the value f64.CONST 0.
5. Return the value ref.null rt.

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
2. Replace YetE (s.MEM_top[f.MODULE_frame.MEM_moduleinst[x]][i : j]) with b*.

with_memext x b
1. Let f be the current frame.
2. Replace s.MEM[f.MODULE.MEM[x]] with b*.

with_elem x r
1. Let f be the current frame.
2. Replace s.TABLE[f.MODULE.TABLE[x]] with r*.

with_data x b
1. Let f be the current frame.
2. Replace s.MEM[f.MODULE.MEM[x]] with b*.

unreachable
1. Trap.

nop
1. Do nothing.

drop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.

select t
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST c from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val_2 from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop val_1 from the stack.
7. If c is not 0, then:
  a. Push val_1 to the stack.
8. Else:
  a. Push val_2 to the stack.

block bt instr
1. Let tmp0->tmp1 be bt.
2. Let t_1^k be tmp0.
3. Assert: Due to validation, there are at least k values on the top of the stack.
4. Pop val^k from the stack.
5. Let t_2^n be tmp1.
6. If the length of t_1^k is k, then:
  a. If the length of t_2^n is n, then:
    1) If the length of val^k is k, then:
      a) Let L be the label_n{[]}.
      b) Push L to the stack.
      c) Push val^k to the stack.
      d) Jump to instr*.
      e) Exit current context.

loop bt instr
1. Let tmp0->tmp1 be bt.
2. Let t_1^k be tmp0.
3. Assert: Due to validation, there are at least k values on the top of the stack.
4. Pop val^k from the stack.
5. Let t_2^n be tmp1.
6. If the length of t_1^k is k, then:
  a. If the length of t_2^n is n, then:
    1) If the length of val^k is k, then:
      a) Let L be the label_n{[loop bt instr*]}.
      b) Push L to the stack.
      c) Push val^k to the stack.
      d) Jump to instr*.
      e) Exit current context.

if bt instr_1 instr_2
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST c from the stack.
3. If c is not 0, then:
  a. Execute (block bt instr_1*).
4. Else:
  a. Execute (block bt instr_2*).

label n instr val
1. Pop val* from the stack.
2. Assert: Due to validation, the label L is now on the top of the stack.
3. Pop the label from the stack.
4. Push val* to the stack.

br
1. Pop val'* ++ val^n ++ [YetE (BR_admininstr(0))] ++ instr* from the stack.
2. Assert: Due to validation, the label L is now on the top of the stack.
3. Pop the label from the stack.
4. If the length of val^n is n, then:
  a. Push val^n to the stack.
  b. Push instr'* to the stack.
5. Push val* to the stack.
6. Execute (br l).

br_if l
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST c from the stack.
3. If c is not 0, then:
  a. Execute (br l).

br_table l l'
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST i from the stack.
3. If i < the length of l*, then:
  a. Execute (br l*[i]).
4. Else:
  a. Execute (br l').

frame n f val
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop val^n from the stack.
5. Assert: Due to validation, the frame F is now on the top of the stack.
6. Pop the frame from the stack.
7. If the length of val^n is n, then:
  a. Push val^n to the stack.

return
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: Due to validation, there are at least n values on the top of the stack.
4. Pop val^n from the stack.
5. Assert: Due to validation, the stack contains at least one frame.
6. While the top of the stack is not a frame, do:
  a. Pop the top element from the stack.
7. Assert: Due to validation, the frame F is now on the top of the stack.
8. Pop the frame from the stack.
9. If the length of val^n is n, then:
  a. Push val^n to the stack.
10. Push val* to the stack.
11. Execute (return).

unop nt unop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value nt.CONST c_1 from the stack.
3. If the length of $unop(unop, nt, c_1) is 1, then:
  a. Let [c] be $unop(unop, nt, c_1).
  b. Push the value nt.CONST c to the stack.
4. If $unop(unop, nt, c_1) is [], then:
  a. Trap.

binop nt binop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value nt.CONST c_2 from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value nt.CONST c_1 from the stack.
5. If the length of $binop(binop, nt, c_1, c_2) is 1, then:
  a. Let [c] be $binop(binop, nt, c_1, c_2).
  b. Push the value nt.CONST c to the stack.
6. If $binop(binop, nt, c_1, c_2) is [], then:
  a. Trap.

testop nt testop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value nt.CONST c_1 from the stack.
3. Let c be $testop(testop, nt, c_1).
4. Push the value i32.CONST c to the stack.

relop nt relop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value nt.CONST c_2 from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value nt.CONST c_1 from the stack.
5. Let c be $relop(relop, nt, c_1, c_2).
6. Push the value i32.CONST c to the stack.

extend nt n
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value nt.CONST c from the stack.
3. Push the value nt.CONST $ext(n, $size(nt), YetE (S_sx), c) to the stack.

cvtop nt_1 cvtop nt_2 sx
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value nt.CONST c_1 from the stack.
3. If the length of $cvtop(nt_1, cvtop, nt_2, sx?, c_1) is 1, then:
  a. Let [c] be $cvtop(nt_1, cvtop, nt_2, sx?, c_1).
  b. Push the value nt.CONST c to the stack.
4. If $cvtop(nt_1, cvtop, nt_2, sx?, c_1) is [], then:
  a. Trap.

ref.is_null
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. If YetE (typeof(val)) is not YetE (REF.NULL_val), then:
  a. Push the value i32.CONST 0 to the stack.
4. Else:
  a. Let the value ref.null rt be val.
  b. Push the value i32.CONST 1 to the stack.

local.tee x
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Push val to the stack.
4. Push val to the stack.
5. Execute (local.set x).

call x
1. If x < the length of $funcaddr(), then:
  a. Execute (call_addr $funcaddr()[x]).

call_indirect x ft
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST i from the stack.
3. If i ≥ the length of $table(x), then:
  a. Trap.
4. Else:
  a. If YetE (typeof($table(z, x)[i])) is not YetE (REF.FUNC_ADDR_ref), then:
    1) Trap.
  b. Else:
    1) Let the value ref.funcaddr a be $table(x)[i].
    2) If a ≥ the length of $funcinst(), then:
      a) Trap.
    3) Else:
      a) Let (m, func) be $funcinst()[a].
      b) Execute (call_addr a).

call_addr a
1. If a < the length of $funcinst(), then:
  a. Let (m, tmp0) be $funcinst()[a].
  b. Let FUNC(tmp1, t*, instr*) be tmp0.
  c. Let tmp2->tmp3 be tmp1.
  d. Let t_1^k be tmp2.
  e. Assert: Due to validation, there are at least k values on the top of the stack.
  f. Pop val^k from the stack.
  g. Let t_2^n be tmp3.
  h. If the length of t_1^k is k, then:
    1) If the length of t_2^n is n, then:
      a) If the length of val^k is k, then:
        1. Let f be { LOCAL: val^k ++ $default_(t)*; MODULE: m; }.
        2. Push the activation of f with arity n to the stack.
        3. Let L be the label_n{[]}.
        4. Push L to the stack.
        5. Jump to instr*.
        6. Exit current context.
        7. Exit current context.

ref.func x
1. If x < the length of $funcaddr(), then:
  a. Push the value ref.funcaddr $funcaddr()[x] to the stack.

local.get x
1. Push $local(x) to the stack.

global.get x
1. Push $global(x) to the stack.

table.get x
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST i from the stack.
3. If i ≥ the length of $table(x), then:
  a. Trap.
4. Else:
  a. Push $table(x)[i] to the stack.

table.size x
1. Let n be the length of $table(x).
2. Push the value i32.CONST n to the stack.

table.fill x
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST i from the stack.
7. If (i + n) > the length of $table(x), then:
  a. Trap.
8. Else:
  a. If n is not 0, then:
    1) Push the value i32.CONST i to the stack.
    2) Push val to the stack.
    3) Execute (table.set x).
    4) Push the value i32.CONST (i + 1) to the stack.
    5) Push val to the stack.
    6) Push the value i32.CONST (n - 1) to the stack.
    7) Execute (table.fill x).

table.copy x y
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST j from the stack.
7. If (i + n) > the length of $table(y) or (j + n) > the length of $table(x), then:
  a. Trap.
8. Else:
  a. If n is not 0, then:
    1) If j ≤ i, then:
      a) Push the value i32.CONST j to the stack.
      b) Push the value i32.CONST i to the stack.
    2) Else:
      a) Push the value i32.CONST ((j + n) - 1) to the stack.
      b) Push the value i32.CONST ((i + n) - 1) to the stack.
    3) Execute (table.get y).
    4) Execute (table.set x).
    5) Push the value i32.CONST (j + 1) to the stack.
    6) Push the value i32.CONST (i + 1) to the stack.
    7) Push the value i32.CONST (n - 1) to the stack.
    8) Execute (table.copy x y).

table.init x y
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST j from the stack.
7. If (i + n) > the length of $elem(y) or (j + n) > the length of $table(x), then:
  a. Trap.
8. Else:
  a. If n is not 0, then:
    1) If i < the length of $elem(y), then:
      a) Push the value i32.CONST j to the stack.
      b) Push $elem(y)[i] to the stack.
      c) Execute (table.set x).
      d) Push the value i32.CONST (j + 1) to the stack.
      e) Push the value i32.CONST (i + 1) to the stack.
      f) Push the value i32.CONST (n - 1) to the stack.
      g) Execute (table.init x y).

load nt ?() n_A n_O
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST i from the stack.
3. If ((i + n_O) + ($size(nt) / 8)) ≥ the length of $mem(0), then:
  a. Trap.
4. Let $bytes_($size(nt), c) be YetE ($mem(z, 0)[(i + n_O) : ($size(nt <: valtype) / 8)]).
5. Push the value nt.CONST c to the stack.
6. If ((i + n_O) + (n / 8)) ≥ the length of $mem(0), then:
  a. Trap.
7. Let $bytes_(n, c) be YetE ($mem(z, 0)[(i + n_O) : (n / 8)]).
8. Push the value nt.CONST c to the stack.

memory.fill
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST i from the stack.
7. If (i + n) > the length of $mem(0), then:
  a. Trap.
8. Else:
  a. If n is not 0, then:
    1) Push the value i32.CONST i to the stack.
    2) Push val to the stack.
    3) Execute (store i32 ?(8) 0 0).
    4) Push the value i32.CONST (i + 1) to the stack.
    5) Push val to the stack.
    6) Push the value i32.CONST (n - 1) to the stack.
    7) Execute (memory.fill).

memory.copy
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST j from the stack.
7. If (i + n) > the length of $table(0) or (j + n) > the length of $table(0), then:
  a. Trap.
8. Else:
  a. If n is not 0, then:
    1) If j ≤ i, then:
      a) Push the value i32.CONST j to the stack.
      b) Push the value i32.CONST i to the stack.
    2) Else:
      a) Push the value i32.CONST ((j + n) - 1) to the stack.
      b) Push the value i32.CONST ((i + n) - 1) to the stack.
    3) Execute (load i32 ?((8, YetE (U_sx))) 0 0).
    4) Execute (store i32 ?(8) 0 0).
    5) Push the value i32.CONST (j + 1) to the stack.
    6) Push the value i32.CONST (i + 1) to the stack.
    7) Push the value i32.CONST (n - 1) to the stack.
    8) Execute (memory.copy).

memory.init x
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST j from the stack.
7. If (i + n) > the length of $data(x) or (j + n) > the length of $mem(0), then:
  a. Trap.
8. Else:
  a. If n is not 0, then:
    1) If i < the length of $data(x), then:
      a) Push the value i32.CONST j to the stack.
      b) Push the value i32.CONST $data(x)[i] to the stack.
      c) Execute (store i32 ?(8) 0 0).
      d) Push the value i32.CONST (j + 1) to the stack.
      e) Push the value i32.CONST (i + 1) to the stack.
      f) Push the value i32.CONST (n - 1) to the stack.
      g) Execute (memory.init x).

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
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. If i ≥ the length of $table(x), then:
  a. Trap.
6. Else:
  a. Perform $with_table(x, i, ref).

table.grow x
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop ref from the stack.
5. Either:
  a. Perform $with_tableext(x, YetE (ref^n{})).
  b. Push the value i32.CONST the length of $table(x) to the stack.
6. Or:
  a. Push the value i32.CONST -1 to the stack.

elem.drop x
1. Perform $with_elem(x, []).

store nt ?() n_A n_O
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST c from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. If ((i + n_O) + ($size(nt) / 8)) ≥ the length of $mem(0), then:
  a. Trap.
6. Let b* be $bytes_($size(nt), c).
7. Perform $with_mem(0, (i + n_O), ($size(nt) / 8), b*).
8. If ((i + n_O) + (n / 8)) ≥ the length of $mem(0), then:
  a. Trap.
9. Let b* be $bytes_(n, $wrap_(($size(nt), n), c)).
10. Perform $with_mem(0, (i + n_O), (n / 8), b*).

memory.grow
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Either:
  a. Perform $with_memext(0, YetE (0^((n * 64) * $Ki){})).
  b. Push the value i32.CONST the length of $mem(0) to the stack.
4. Or:
  a. Push the value i32.CONST -1 to the stack.

data.drop x
1. Perform $with_data(x, []).

== Interpret AL...
** Manual algorithms **

br l
1. If l is 0, then:
  a. Let L be the current label.
  b. Let n be the arity of L.
  c. Assert: Due to validation, there are at least n values on the top of the stack.
  d. Pop val^n from the stack.
  e. While the top of the stack is value, do:
    1) Pop val' from the stack.
  f. Assert: Due to validation, the label L is now on the top of the stack.
  g. Pop the label from the stack.
  h. Push val^n to the stack.
  i. Jump to the continuation of L.
2. Else:
  a. Let val* be [].
  b. While the top of the stack is value, do:
    1) Pop val' from the stack.
    2) Let val* be [val'] ++ val*.
  c. Assert: Due to validation, the label L is now on the top of the stack.
  d. Pop the label from the stack.
  e. Push val* to the stack.
  f. Execute (br (l - 1)).

instantiation module
1. Let moduleinst_init be ModuleInstV (TODO).
2. Let f_init be the activation of { LOCAL: []; MODULE: moduleinst_init; } with arity 0.
3. Push f_init to the stack.
4. Pop f_init from the stack.
5. Let moduleinst be $alloc_module(module).
6. Let f be the activation of { LOCAL: []; MODULE: moduleinst; } with arity 0.
7. Push f to the stack.
8. Pop f from the stack.

alloc_module module
1. Let MODULE(func*) be module.
2. Let funcaddr* be $alloc_func(func)*.
3. Let moduleinst be { FUNC: funcaddr*; }.
4. For i in range |s.FUNC| in
  a. Let (_, func') be s.FUNC[i].
  b. Replace s.FUNC[i] with (moduleinst, func').
5. Return moduleinst.

alloc_func func
1. Let a be the length of s.FUNC.
2. Let dummy_module_inst be { FUNC: []; }.
3. Let funcinst be (dummy_module_inst, func).
4. Append funcinst to the s.FUNC.
5. Return a.

invocation funcaddr
1. Let funcinst be s.FUNC[funcaddr].
2. Let f be the activation of { LOCAL: []; MODULE: { FUNC: []; }; } with arity 0.
3. Push f to the stack.
4. Execute (call_addr funcaddr).

** Test instrs **

binop
Ok

testop
Ok

relop i32
Ok

relop f32
Ok

nop
Ok

drop
Ok

select
Ok

local_set
Ok

local_get
Ok

local_tee
Ok

global_set
Ok

global_get1
Ok

global_get2
Ok

table_get
Ok

call_nop
Ok

call_add
Ok

call_sum
Ok

block
Ok

br_zero
Ok

br_succ
Ok

if_true
Ok

if_false
Ok

** Test module **

binop
Ok

testop
Ok

relop i32
Ok

relop f32
Ok

nop
Ok

drop
Ok

select
Ok

local_set
Fail!
Expected: 8
Actual: FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })is not a wasm value.
[Stack]
FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })

local_get
Fail!
Expected: 7
Actual: FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })is not a wasm value.
[Stack]
FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })

local_tee
Fail!
Expected: 6
Actual: FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })is not a wasm value.
[Stack]
FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })

global_set
Fail!
Expected: 43
Actual: FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })is not a wasm value.
[Stack]
FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })

global_get1
Fail!
Expected: 5.2
Actual: FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })is not a wasm value.
[Stack]
FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })

global_get2
Fail!
Expected: 42
Actual: FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })is not a wasm value.
[Stack]
FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })

table_get
Fail!
Expected: null
Actual: FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })is not a wasm value.
[Stack]
FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })

call_nop
Ok

call_add
Fail!
Expected: 3
Actual: 2
[Stack]
(const i32 2)
(const i32 1)
FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })

call_sum
Fail!
Expected: 55
Actual: 10
[Stack]
(const i32 10)
FrameV ({ LOCAL: []; MODULE: { FUNC: []; }; })

== Complete.
```
