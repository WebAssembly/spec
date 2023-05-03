# Preview

```sh
$ (cd ../spec && dune exec ../src/exe-watsup/main.exe -- *.watsup -v -l --totalize --sideconditions --animate --prose)
watsup 0.3 generator
== Parsing...
== Elaboration...
== IL Validation...
== Function totalization...
== IL Validation...
== Side condition inference
== IL Validation...
== Animate
Animation failed:if ($bytes_(!($size(nt <: valtype)), c) = $mem(z, 0)[(i + n_O) : (!($size(nt <: valtype)) / 8)])
Animation failed:where $bytes_(!($size(nt <: valtype)), c) := $mem(z, 0)[(i + n_O) : (!($size(nt <: valtype)) / 8)]
Animation failed:if ($bytes_(n, c) = $mem(z, 0)[(i + n_O) : (n / 8)])
Animation failed:where $bytes_(n, c) := $mem(z, 0)[(i + n_O) : (n / 8)]
== IL Validation...
== Prose Generation...
Bubbleup semantics for br: Top of the stack is frame / label
Bubbleup semantics for return: Top of the stack is frame / label
Invalid expression `!($default_(t))` to be AL identifier.
Invalid premise `(if ($default_(t) =/= ?()))*{t}` to be AL instr.
Ki
1. Return 1024.

size t
1. If t is YetE (I32_valtype) or t is YetE (F32_valtype), then:
  a. Return YetE (?(32)).
2. If t is YetE (I64_valtype) or t is YetE (F64_valtype), then:
  a. Return YetE (?(64)).
3. If t is YetE (V128_valtype), then:
  a. Return YetE (?(128)).
4. Return YetE (?()).

test_sub_ATOM_22 n_3_ATOM_y
1. Return 0.

curried_ n_1 n_2
1. Return (n_1 + n_2).

default_ t
1. If t is YetE (I32_valtype), then:
  a. Return YetE (?(CONST_val(I32_numtype, 0))).
2. If t is YetE (I64_valtype), then:
  a. Return YetE (?(CONST_val(I64_numtype, 0))).
3. If t is YetE (F32_valtype), then:
  a. Return YetE (?(CONST_val(F32_numtype, 0))).
4. If t is YetE (F64_valtype), then:
  a. Return YetE (?(CONST_val(F64_numtype, 0))).
5. Return YetE (?(REF.NULL_val(rt))).
6. Return YetE (?()).

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
1. Assert: due to validation, there are at least k values on the top of the stack.
2. Pop val^k from the stack.
3. Let YetE (`%->%`(tmp0, tmp1)) be bt.
4. Let t_1^k be tmp0.
5. Let t_2^n be tmp1.
6. If the length of t_1^k is k, then:
  a. If the length of t_2^n is n, then:
    1) If the length of val^k is k, then:
      a) Let L be YetE ().
      b) Enter the block Yet with label YetE ().

loop bt instr
1. Assert: due to validation, there are at least k values on the top of the stack.
2. Pop val^k from the stack.
3. Let YetE (`%->%`(tmp0, tmp1)) be bt.
4. Let t_1^k be tmp0.
5. Let t_2^n be tmp1.
6. If the length of t_1^k is k, then:
  a. If the length of t_2^n is n, then:
    1) If the length of val^k is k, then:
      a) Let L be YetE ().
      b) Enter the block Yet with label YetE ().

if bt instr_1 instr_2
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST c from the stack.
3. If c is not 0, then:
  a. Execute (BLOCK bt instr_1*).
4. Else:
  a. Execute (BLOCK bt instr_2*).

label n instr val
1. Pop val* from the stack.
2. Assert: Assert: due to validation, the label L is now on the top of the stack.
3. Pop the label from the stack.
4. Push val* to the stack.

br
1. Pop [val'*, [val^n, [[YetE (BR_admininstr(0))], instr*]]] from the stack.
2. Assert: Assert: due to validation, the label L is now on the top of the stack.
3. Pop the label from the stack.
4. If the length of val^n is n, then:
  a. Push val^n to the stack.
  b. Push instr'* to the stack.
5. Push val* to the stack.
6. Execute (BR l).

br_if l
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST c from the stack.
3. If c is not 0, then:
  a. Execute (BR l).

br_table l l'
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST i from the stack.
3. If i < the length of l*, then:
  a. Execute (BR l*[i]).
4. Else:
  a. Execute (BR l').

frame n f val
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: due to validation, there are at least n values on the top of the stack.
4. Pop val^n from the stack.
5. Assert: due to validation, the frame F is now on the top of the stack.
6. Pop the frame from the stack.
7. If the length of val^n is n, then:
  a. Push val^n to the stack.

return
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: due to validation, there are at least n values on the top of the stack.
4. Pop val^n from the stack.
5. Assert: due to validation, the stack contains at least one frame.
6. While the top of the stack is not a frame, do:
  a. Pop the top element from the stack.
7. Assert: due to validation, the frame F is now on the top of the stack.
8. Pop the frame from the stack.
9. If the length of val^n is n, then:
  a. Push val^n to the stack.
10. Push val* to the stack.
11. Execute (RETURN).

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
3. If $size(nt) is not YetE (?()), then:
  a. Push the value nt.CONST $ext(n, YetE (!($size(nt <: valtype))), YetE (S_sx), c) to the stack.

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
5. Execute (LOCAL.SET x).

call x
1. If x < the length of $funcaddr(z), then:
  a. Execute (CALL_ADDR $funcaddr(z)[x]).

call_indirect x ft
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST i from the stack.
3. If i ≥ the length of $table(z, x), then:
  a. Trap.
4. Else:
  a. If YetE (typeof($table(z, x)[i])) is not YetE (REF.FUNC_ADDR_ref), then:
    1) Trap.
  b. Else:
    1) Let the value ref.funcaddr a be $table(z, x)[i].
    2) If a ≥ the length of $funcinst(z), then:
      a) Trap.
    3) Else:
      a) Let YetE (`%;%`(m, func)) be $funcinst(z)[a].
      b) Execute (CALL_ADDR a).

call_addr a
1. Assert: due to validation, there are at least k values on the top of the stack.
2. Pop val^k from the stack.
3. If a < the length of $funcinst(z), then:
  a. Let YetE (`%;%`(m, tmp0)) be $funcinst(z)[a].
  b. Let YetE (`FUNC%%*%`(tmp1, t*{t}, instr*{instr})) be tmp0.
  c. Let YetE (`%->%`(tmp2, tmp3)) be tmp1.
  d. Let t_1^k be tmp2.
  e. Let t_2^n be tmp3.
  f. If the length of t_1^k is k, then:
    1) If the length of t_2^n is n, then:
      a) If the length of val^k is k, then:
        1. YetI: (if ($default_(t) =/= ?()))*{t}.
        2. Let f be { LOCAL [val^k, Yet*], MODULE m }.
        3. Let F be { module YetE (f.module), locals YetE (val^n :: default_t*) }.
        4. Push the activation of F with arity n to the stack.

ref.func x
1. If x < the length of $funcaddr(z), then:
  a. Push the value ref.funcaddr $funcaddr(z)[x] to the stack.

local.get x
1. Push $local(x) to the stack.

global.get x
1. Push $global(x) to the stack.

table.get x
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST i from the stack.
3. If i ≥ the length of $table(z, x), then:
  a. Trap.
4. Else:
  a. Push $table(z, x)[i] to the stack.

table.size x
1. Let n be the length of $table(z, x).
2. Push the value i32.CONST n to the stack.

table.fill x
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST i from the stack.
7. If (i + n) > the length of $table(z, x), then:
  a. Trap.
8. Else:
  a. If n is not 0, then:
    1) Push the value i32.CONST i to the stack.
    2) Push val to the stack.
    3) Execute (TABLE.SET x).
    4) Push the value i32.CONST (i + 1) to the stack.
    5) Push val to the stack.
    6) Push the value i32.CONST (n - 1) to the stack.
    7) Execute (TABLE.FILL x).

table.copy x y
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST j from the stack.
7. If (i + n) > the length of $table(z, y) or (j + n) > the length of $table(z, x), then:
  a. Trap.
8. Else:
  a. If n is not 0, then:
    1) If j ≤ i, then:
      a) Push the value i32.CONST j to the stack.
      b) Push the value i32.CONST i to the stack.
    2) Else:
      a) Push the value i32.CONST ((j + n) - 1) to the stack.
      b) Push the value i32.CONST ((i + n) - 1) to the stack.
    3) Execute (TABLE.GET y).
    4) Execute (TABLE.SET x).
    5) Push the value i32.CONST (j + 1) to the stack.
    6) Push the value i32.CONST (i + 1) to the stack.
    7) Push the value i32.CONST (n - 1) to the stack.
    8) Execute (TABLE.COPY x y).

table.init x y
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST j from the stack.
7. If (i + n) > the length of $elem(z, y) or (j + n) > the length of $table(z, x), then:
  a. Trap.
8. Else:
  a. If n is not 0, then:
    1) If i < the length of $elem(z, y), then:
      a) Push the value i32.CONST j to the stack.
      b) Push $elem(z, y)[i] to the stack.
      c) Execute (TABLE.SET x).
      d) Push the value i32.CONST (j + 1) to the stack.
      e) Push the value i32.CONST (i + 1) to the stack.
      f) Push the value i32.CONST (n - 1) to the stack.
      g) Execute (TABLE.INIT x y).

load nt ?() n_A n_O
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST i from the stack.
3. If $size(nt) is not YetE (?()), then:
  a. If ((i + n_O) + (YetE (!($size(nt <: valtype))) / 8)) ≥ the length of $mem(z, 0), then:
    1) Trap.
4. If $size(nt) is not YetE (?()), then:
  a. Let $bytes_(YetE (!($size(nt <: valtype))), c) be YetE ($mem(z, 0)[(i + n_O) : (!($size(nt <: valtype)) / 8)]).
  b. Push the value nt.CONST c to the stack.
5. If ((i + n_O) + (n / 8)) ≥ the length of $mem(z, 0), then:
  a. Trap.
6. Let $bytes_(n, c) be YetE ($mem(z, 0)[(i + n_O) : (n / 8)]).
7. Push the value nt.CONST c to the stack.

memory.fill
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST i from the stack.
7. If (i + n) > the length of $mem(z, 0), then:
  a. Trap.
8. Else:
  a. If n is not 0, then:
    1) Push the value i32.CONST i to the stack.
    2) Push val to the stack.
    3) Execute (STORE YetE (I32_numtype) YetE (?(8)) 0 0).
    4) Push the value i32.CONST (i + 1) to the stack.
    5) Push val to the stack.
    6) Push the value i32.CONST (n - 1) to the stack.
    7) Execute (MEMORY.FILL).

memory.copy
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST j from the stack.
7. If (i + n) > the length of $table(z, 0) or (j + n) > the length of $table(z, 0), then:
  a. Trap.
8. Else:
  a. If n is not 0, then:
    1) If j ≤ i, then:
      a) Push the value i32.CONST j to the stack.
      b) Push the value i32.CONST i to the stack.
    2) Else:
      a) Push the value i32.CONST ((j + n) - 1) to the stack.
      b) Push the value i32.CONST ((i + n) - 1) to the stack.
    3) Execute (LOAD YetE (I32_numtype) YetE (?((8, U_sx))) 0 0).
    4) Execute (STORE YetE (I32_numtype) YetE (?(8)) 0 0).
    5) Push the value i32.CONST (j + 1) to the stack.
    6) Push the value i32.CONST (i + 1) to the stack.
    7) Push the value i32.CONST (n - 1) to the stack.
    8) Execute (MEMORY.COPY).

memory.init x
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST j from the stack.
7. If (i + n) > the length of $data(z, x) or (j + n) > the length of $mem(z, 0), then:
  a. Trap.
8. Else:
  a. If n is not 0, then:
    1) If i < the length of $data(z, x), then:
      a) Push the value i32.CONST j to the stack.
      b) Push the value i32.CONST $data(z, x)[i] to the stack.
      c) Execute (STORE YetE (I32_numtype) YetE (?(8)) 0 0).
      d) Push the value i32.CONST (j + 1) to the stack.
      e) Push the value i32.CONST (i + 1) to the stack.
      f) Push the value i32.CONST (n - 1) to the stack.
      g) Execute (MEMORY.INIT x).

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
5. If i ≥ the length of $table(z, x), then:
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
  b. Push the value i32.CONST the length of $table(z, x) to the stack.
6. Or:
  a. Push the value i32.CONST -1 to the stack.

elem.drop x
1. Perform $with_elem(x, []).

store nt ?() n_A n_O
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST c from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. If $size(nt) is not YetE (?()), then:
  a. If ((i + n_O) + (YetE (!($size(nt <: valtype))) / 8)) ≥ the length of $mem(z, 0), then:
    1) Trap.
6. If $size(nt) is not YetE (?()), then:
  a. Let b* be $bytes_(YetE (!($size(nt <: valtype))), c).
  b. Perform $with_mem(0, (i + n_O), (YetE (!($size(nt <: valtype))) / 8), b*).
7. If ((i + n_O) + (n / 8)) ≥ the length of $mem(z, 0), then:
  a. Trap.
8. If $size(nt) is not YetE (?()), then:
  a. Let b* be $bytes_(n, $wrap_(YetE ((!($size(nt <: valtype)), n)), c)).
  b. Perform $with_mem(0, (i + n_O), (n / 8), b*).

memory.grow
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Either:
  a. Perform $with_memext(0, YetE (0^((n * 64) * $Ki){})).
  b. Push the value i32.CONST the length of $mem(z, 0) to the stack.
4. Or:
  a. Push the value i32.CONST -1 to the stack.

data.drop x
1. Perform $with_data(x, []).

== AL Validation...

Ki
Failure("ReturnI (ValueE 1024)")

size
Failure("YetE (I32_valtype)")

test_sub_ATOM_22
Failure("ReturnI (ValueE 0)")

curried_
Failure("ReturnI (AddE (NameE (N(n_1)), NameE (N(n_2))))")

default_
Failure("YetE (I32_valtype)")

funcaddr
Failure("FrameE")

funcinst
Failure("FrameE")

func
Failure("FrameE")

global
Failure("FrameE")

table
Failure("FrameE")

mem
Failure("FrameE")

elem
Failure("FrameE")

data
Failure("FrameE")

local
Failure("FrameE")

with_local
Failure("FrameE")

with_global
Failure("FrameE")

with_table
Failure("FrameE")

with_tableext
Failure("FrameE")

with_mem
Failure("FrameE")

with_memext
Failure("FrameE")

with_elem
Failure("FrameE")

with_data
Failure("FrameE")

unreachable
Ok

nop
Ok

drop
Ok

select
Ok

block
Failure("LetI (YetE (`%->%`(tmp0, tmp1)), NameE (N(bt)))")

loop
Failure("LetI (YetE (`%->%`(tmp0, tmp1)), NameE (N(bt)))")

if
Ok

label
Ok

br
Failure("PopI (ListE ([IterE (N(val'), *), ListE ([IterE (N(val), N(n)), ListE ([ListE ([YetE (BR_admininstr(0))]), IterE (N(instr), *)])])]))")

br_if
Ok

br_table
Ok

frame
Failure("FrameE")

return
Failure("FrameE")

unop
Ok

binop
Ok

testop
Ok

relop
Ok

extend
Failure("Unknwon function name: size")

cvtop
Ok

ref.is_null
Failure("YetE (typeof(val))")

local.tee
Ok

call
Ok

call_indirect
Failure("YetE (typeof($table(z, x)[i]))")

call_addr
Failure("LetI (YetE (`%;%`(m, tmp0)), IndexAccessE (AppE (N(funcinst), [ NameE (N(z)) ]), NameE (N(a))))")

ref.func
Ok

local.get
Failure("IntT is not subtype of StateT")

global.get
Failure("IntT is not subtype of StateT")

table.get
Ok

table.size
Ok

table.fill
Ok

table.copy
Ok

table.init
Ok

load
Failure("Unknwon function name: size")

memory.fill
Failure("YetE (I32_numtype)")

memory.copy
Failure("YetE (I32_numtype)")

memory.init
Failure("YetE (I32_numtype)")

local.set
Failure("IntT is not subtype of StateT")

global.set
Failure("IntT is not subtype of StateT")

table.set
Failure("IntT is not subtype of StateT")

table.grow
Failure("YetE (ref^n{})")

elem.drop
Failure("IntT is not subtype of StateT")

store
Failure("Unknwon function name: size")

memory.grow
Failure("YetE (0^((n * 64) * $Ki){})")

data.drop
Failure("IntT is not subtype of StateT")

Pass/Total: [21/66]
== Interpret AL...
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

local_get
Ok

global_get
Ok

== Complete.
```
