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
unreachable
1. Trap.

nop
1. Do nothing.

drop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.

select
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST c from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val_2 from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop val_1 from the stack.
7. If c is not 0, then:
  a. Push val_1 to the stack.
8. If c is 0, then:
  a. Push val_2 to the stack.

block
1. Assert: due to validation, there are at least k values on the top of the stack.
2. Pop val^k from the stack.
3. Let the length of t_1^k be k.
4. Let the length of t_2^n be n.
5. Let the length of val^k be k.
6. Let L be YetE ().
7. Enter the block Yet with label YetE ().

loop
1. Assert: due to validation, there are at least k values on the top of the stack.
2. Pop val^k from the stack.
3. Let the length of t_1^k be k.
4. Let the length of t_2^n be n.
5. Let the length of val^k be k.
6. Let L be YetE ().
7. Enter the block Yet with label YetE ().

if
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST c from the stack.
3. If c is not 0, then:
  a. Execute (BLOCK bt instr_1^*).
4. If c is 0, then:
  a. Execute (BLOCK bt instr_2^*).

label
1. Pop val^* from the stack.
2. Assert: Assert: due to validation, the label L is now on the top of the stack.
3. Pop the label from the stack.
4. Push val^* to the stack.

br
1. Pop [val'^*, [val^n, [[YetE (BR_admininstr(0))], instr^*]]] from the stack.
2. Assert: Assert: due to validation, the label L is now on the top of the stack.
3. Pop the label from the stack.
4. If the length of val^n is n, then:
  a. Push val^n to the stack.
  b. Push instr'^* to the stack.
5. If YetC ([]), then:
  a. Push val^* to the stack.
  b. Execute (BR l).

br_if
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST c from the stack.
3. If c is not 0, then:
  a. Execute (BR l).
4. If c is 0, then:
  a. Do nothing.

br_table
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST i from the stack.
3. If i < the length of l^*, then:
  a. Execute (BR l^*[i]).
4. If i ≥ the length of l^*, then:
  a. Execute (BR l').

frame
1. Let f be the current frame.
2. Let n be the arity of f.
3. Assert: due to validation, there are at least n values on the top of the stack.
4. Pop val^n from the stack.
5. Assert: due to validation, the frame F is now on the top of the stack.
6. Pop the frame from the stack.
7. Let the length of val^n be n.
8. Push val^n to the stack.

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
10. If YetC ([]), then:
  a. Push val^* to the stack.
  b. Execute (RETURN).

unop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value nt.CONST c_1 from the stack.
3. If YetC (Animation), then:
  a. Push the value nt.CONST c to the stack.
4. If $unop(unop, nt, c_1) is [], then:
  a. Trap.

binop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value nt.CONST c_2 from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value nt.CONST c_1 from the stack.
5. If YetC (Animation), then:
  a. Push the value nt.CONST c to the stack.
6. If $binop(binop, nt, c_1, c_2) is [], then:
  a. Trap.

testop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value nt.CONST c_1 from the stack.
3. Push the value i32.CONST c to the stack.

relop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value nt.CONST c_2 from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop the value nt.CONST c_1 from the stack.
5. Push the value i32.CONST c to the stack.

extend
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value nt.CONST c from the stack.
3. Push the value nt.CONST $ext(n, YetE (!($size(nt <: valtype))), YetE (S_sx), c) to the stack.

cvtop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop the value nt.CONST c_1 from the stack.
3. If YetC (Animation), then:
  a. Push the value nt.CONST c to the stack.
4. If $cvtop(nt_1, cvtop, nt_2, sx^?, c_1) is [], then:
  a. Trap.

ref.is_null
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. If YetC (Animation), then:
  a. Push the value i32.CONST 1 to the stack.
4. If YetC (Otherwise), then:
  a. Push the value i32.CONST 0 to the stack.

local.tee
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Push val to the stack.
4. Push val to the stack.
5. Execute (LOCAL.SET x).

call
1. Execute (CALL_ADDR $funcaddr(z)[x]).

call_indirect
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST i from the stack.
3. If i < the length of $table(z, x) and YetC (Animation), then:
  a. Execute (CALL_ADDR a).
4. If YetC (Otherwise), then:
  a. Trap.

call_addr
1. Assert: due to validation, there are at least k values on the top of the stack.
2. Pop val^k from the stack.
3. Let the length of t_1^k be k.
4. Let the length of t_2^n be n.
5. Let the length of val^k be k.
6. Let F be { module YetE (f.module), locals YetE (val^n :: default_t*) }.
7. Push the activation of F with arity n to the stack.

ref.func
1. Push the value ref.funcaddr $funcaddr(z)[x] to the stack.

local.get
1. Push $local(z, x) to the stack.

global.get
1. Push $global(z, x) to the stack.

table.get
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST i from the stack.
3. If i ≥ the length of $table(z, x), then:
  a. Trap.
4. If i < the length of $table(z, x), then:
  a. Push $table(z, x)[i] to the stack.

table.size
1. Push the value i32.CONST n to the stack.

table.fill
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST i from the stack.
7. If (i + n) > the length of $table(z, x), then:
  a. Trap.
8. If YetC (Otherwise) and n is 0, then:
  a. Do nothing.
9. If YetC (Otherwise), then:
  a. Push the value i32.CONST i to the stack.
  b. Push val to the stack.
  c. Execute (TABLE.SET x).
  d. Push the value i32.CONST (i + 1) to the stack.
  e. Push val to the stack.
  f. Push the value i32.CONST (n - 1) to the stack.
  g. Execute (TABLE.FILL x).

table.copy
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST j from the stack.
7. If (i + n) > the length of $table(z, y) or (j + n) > the length of $table(z, x), then:
  a. Trap.
8. If YetC (Otherwise) and n is 0, then:
  a. Do nothing.
9. If YetC (Otherwise) and j ≤ i, then:
  a. Push the value i32.CONST j to the stack.
  b. Push the value i32.CONST i to the stack.
  c. Execute (TABLE.GET y).
  d. Execute (TABLE.SET x).
  e. Push the value i32.CONST (j + 1) to the stack.
  f. Push the value i32.CONST (i + 1) to the stack.
  g. Push the value i32.CONST (n - 1) to the stack.
  h. Execute (TABLE.COPY x y).
10. If YetC (Otherwise), then:
  a. Push the value i32.CONST ((j + n) - 1) to the stack.
  b. Push the value i32.CONST ((i + n) - 1) to the stack.
  c. Execute (TABLE.GET y).
  d. Execute (TABLE.SET x).
  e. Push the value i32.CONST (j + 1) to the stack.
  f. Push the value i32.CONST (i + 1) to the stack.
  g. Push the value i32.CONST (n - 1) to the stack.
  h. Execute (TABLE.COPY x y).

table.init
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST j from the stack.
7. If (i + n) > the length of $elem(z, y) or (j + n) > the length of $table(z, x), then:
  a. Trap.
8. If YetC (Otherwise) and n is 0, then:
  a. Do nothing.
9. If i < the length of $elem(z, y) and YetC (Otherwise), then:
  a. Push the value i32.CONST j to the stack.
  b. Push $elem(z, y)[i] to the stack.
  c. Execute (TABLE.SET x).
  d. Push the value i32.CONST (j + 1) to the stack.
  e. Push the value i32.CONST (i + 1) to the stack.
  f. Push the value i32.CONST (n - 1) to the stack.
  g. Execute (TABLE.INIT x y).

load
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST i from the stack.
3. If $size(nt) is not YetE (?()) and ((i + n_O) + (YetE (!($size(nt <: valtype))) / 8)) ≥ the length of $mem(z, 0), then:
  a. Trap.
4. If $size(nt) is not YetE (?()) and YetC (Animation), then:
  a. Push the value nt.CONST c to the stack.
5. If ((i + n_O) + (n / 8)) ≥ the length of $mem(z, 0), then:
  a. Trap.
6. If YetC (Animation), then:
  a. Push the value nt.CONST c to the stack.

memory.fill
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop val from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST i from the stack.
7. If (i + n) > the length of $mem(z, 0), then:
  a. Trap.
8. If YetC (Otherwise) and n is 0, then:
  a. Do nothing.
9. If YetC (Otherwise), then:
  a. Push the value i32.CONST i to the stack.
  b. Push val to the stack.
  c. Execute (STORE YetE (I32_numtype) YetE (?(8)) 0 0).
  d. Push the value i32.CONST (i + 1) to the stack.
  e. Push val to the stack.
  f. Push the value i32.CONST (n - 1) to the stack.
  g. Execute (MEMORY.FILL).

memory.copy
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST j from the stack.
7. If (i + n) > the length of $table(z, 0) or (j + n) > the length of $table(z, 0), then:
  a. Trap.
8. If YetC (Otherwise) and n is 0, then:
  a. Do nothing.
9. If YetC (Otherwise) and j ≤ i, then:
  a. Push the value i32.CONST j to the stack.
  b. Push the value i32.CONST i to the stack.
  c. Execute (LOAD YetE (I32_numtype) YetE (?((8, U_sx))) 0 0).
  d. Execute (STORE YetE (I32_numtype) YetE (?(8)) 0 0).
  e. Push the value i32.CONST (j + 1) to the stack.
  f. Push the value i32.CONST (i + 1) to the stack.
  g. Push the value i32.CONST (n - 1) to the stack.
  h. Execute (MEMORY.COPY).
10. If YetC (Otherwise), then:
  a. Push the value i32.CONST ((j + n) - 1) to the stack.
  b. Push the value i32.CONST ((i + n) - 1) to the stack.
  c. Execute (LOAD YetE (I32_numtype) YetE (?((8, U_sx))) 0 0).
  d. Execute (STORE YetE (I32_numtype) YetE (?(8)) 0 0).
  e. Push the value i32.CONST (j + 1) to the stack.
  f. Push the value i32.CONST (i + 1) to the stack.
  g. Push the value i32.CONST (n - 1) to the stack.
  h. Execute (MEMORY.COPY).

memory.init
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop the value i32.CONST j from the stack.
7. If (i + n) > the length of $data(z, x) or (j + n) > the length of $mem(z, 0), then:
  a. Trap.
8. If YetC (Otherwise) and n is 0, then:
  a. Do nothing.
9. If i < the length of $data(z, x) and YetC (Otherwise), then:
  a. Push the value i32.CONST j to the stack.
  b. Push the value i32.CONST $data(z, x)[i] to the stack.
  c. Execute (STORE YetE (I32_numtype) YetE (?(8)) 0 0).
  d. Push the value i32.CONST (j + 1) to the stack.
  e. Push the value i32.CONST (i + 1) to the stack.
  f. Push the value i32.CONST (n - 1) to the stack.
  g. Execute (MEMORY.INIT x).

local.set
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Perform $with_local(z, x, val).

global.set
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop val from the stack.
3. Perform $with_global(z, x, val).

table.set
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop ref from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. If i ≥ the length of $table(z, x), then:
  a. Trap.
6. If i < the length of $table(z, x), then:
  a. Perform $with_table(z, x, i, ref).

table.grow
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop ref from the stack.
5. Either:
  a. Perform $with_tableext(z, x, YetE (ref^n{})).
  b. Push the value i32.CONST the length of $table(z, x) to the stack.
6. Or:
  a. Push the value i32.CONST -1 to the stack.

elem.drop
1. Perform $with_elem(z, x, []).

store
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST c from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop the value i32.CONST i from the stack.
5. If $size(nt) is not YetE (?()) and ((i + n_O) + (YetE (!($size(nt <: valtype))) / 8)) ≥ the length of $mem(z, 0), then:
  a. Trap.
6. If $size(nt) is not YetE (?()) and YetC (Animation), then:
  a. Perform $with_mem(z, 0, (i + n_O), (YetE (!($size(nt <: valtype))) / 8), b^*).
7. If ((i + n_O) + (n / 8)) ≥ the length of $mem(z, 0), then:
  a. Trap.
8. If $size(nt) is not YetE (?()) and YetC (Animation), then:
  a. Perform $with_mem(z, 0, (i + n_O), (n / 8), b^*).

memory.grow
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop the value i32.CONST n from the stack.
3. Either:
  a. Perform $with_memext(z, 0, YetE (0^((n * 64) * $Ki){})).
  b. Push the value i32.CONST the length of $mem(z, 0) to the stack.
4. Or:
  a. Push the value i32.CONST -1 to the stack.

data.drop
1. Perform $with_data(z, x, []).

== Complete.
```
