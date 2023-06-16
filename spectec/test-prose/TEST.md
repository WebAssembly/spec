# Preview

```sh
$ (cd ../spec && dune exec ../src/exe-watsup/main.exe -- *.watsup -v -l --sideconditions --animate --prose)
watsup 0.3 generator
== Parsing...
== Elaboration...
== IL Validation...
== Running pass sideconditions
== IL Validation...
== Running pass animate
Animation failed:if ($funcinst(z)[a].CODE_funcinst = `FUNC%%*%`(ft', t*{t}, instr*{instr}))
Animation failed:if ($bytes_($size(nt <: valtype), c) = $mem(z, 0).DATA_meminst[(i + n_O) : ($size(nt <: valtype) / 8)])
Animation failed:if ($bytes_(n, c) = $mem(z, 0).DATA_meminst[(i + n_O) : (n / 8)])
== IL Validation...
== Prose Generation...
unreachable
1. Trap.

nop
1. Do nothing.

drop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE ((val <: admininstr)) from the stack.

select
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, c)) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop YetE ((val_2 <: admininstr)) from the stack.
5. Assert: Due to validation, a value is on the top of the stack.
6. Pop YetE ((val_1 <: admininstr)) from the stack.
7. If YetC (), then:
  a. Push YetE ((val_1 <: admininstr)) to the stack.
8. If YetC (), then:
  a. Push YetE ((val_2 <: admininstr)) to the stack.

block
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE ((val <: admininstr)^k{val}) from the stack.
3. Let L be YetE ().
4. Enter the block Yet with label YetE ().

loop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE ((val <: admininstr)^k{val}) from the stack.
3. Let L be YetE ().
4. Enter the block Yet with label YetE ().

if
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, c)) from the stack.
3. If YetC (), then:
  a. Execute (BLOCK YetE (bt) YetE (instr_1*{instr_1})).
4. If YetC (), then:
  a. Execute (BLOCK YetE (bt) YetE (instr_2*{instr_2})).

label
1. Push YetE ((val <: admininstr)*{val}) to the stack.

br
1. If YetC (), then:
  a. Push YetE ((val <: admininstr)^n{val}) to the stack.
  b. Push YetE ((instr' <: admininstr)*{instr'}) to the stack.
2. If YetC (), then:
  a. Push YetE ((val <: admininstr)*{val}) to the stack.
  b. Execute (BR YetE (l)).

br_if
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, c)) from the stack.
3. If YetC (), then:
  a. Execute (BR YetE (l)).
4. If YetC (), then:
  a. Do nothing.

br_table
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, i)) from the stack.
3. If YetC (), then:
  a. Execute (BR YetE (l*{l}[i])).
4. If YetC (), then:
  a. Execute (BR YetE (l')).

frame
1. Push YetE ((val <: admininstr)^n{val}) to the stack.

return
1. If YetC (), then:
  a. Push YetE ((val <: admininstr)^n{val}) to the stack.
2. If YetC (), then:
  a. Push YetE ((val <: admininstr)*{val}) to the stack.
  b. Execute (RETURN).

unop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE (CONST_admininstr(nt, c_1)) from the stack.
3. If YetC (), then:
  a. Push YetE (CONST_admininstr(nt, c)) to the stack.
4. If YetC (), then:
  a. Trap.

binop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE (CONST_admininstr(nt, c_2)) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop YetE (CONST_admininstr(nt, c_1)) from the stack.
5. If YetC (), then:
  a. Push YetE (CONST_admininstr(nt, c)) to the stack.
6. If YetC (), then:
  a. Trap.

testop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE (CONST_admininstr(nt, c_1)) from the stack.
3. Push YetE (CONST_admininstr(I32_numtype, c)) to the stack.

relop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE (CONST_admininstr(nt, c_2)) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop YetE (CONST_admininstr(nt, c_1)) from the stack.
5. Push YetE (CONST_admininstr(I32_numtype, c)) to the stack.

extend
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE (CONST_admininstr(nt, c)) from the stack.
3. Push YetE (CONST_admininstr(nt, $ext(n, $size(nt <: valtype), S_sx, c))) to the stack.

cvtop
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE (CONST_admininstr(nt_1, c_1)) from the stack.
3. If YetC (), then:
  a. Push YetE (CONST_admininstr(nt_2, c)) to the stack.
4. If YetC (), then:
  a. Trap.

ref.is_null
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE ((val <: admininstr)) from the stack.
3. If YetC (), then:
  a. Push YetE (CONST_admininstr(I32_numtype, 1)) to the stack.
4. If YetC (), then:
  a. Push YetE (CONST_admininstr(I32_numtype, 0)) to the stack.

local.tee
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE ((val <: admininstr)) from the stack.
3. Push YetE ((val <: admininstr)) to the stack.
4. Push YetE ((val <: admininstr)) to the stack.
5. Execute (LOCAL.SET YetE (x)).

call
1. Execute (CALL_ADDR YetE ($funcaddr(z)[x])).

call_indirect
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, i)) from the stack.
3. If YetC (), then:
  a. Execute (CALL_ADDR YetE (a)).
4. If YetC (), then:
  a. Trap.

call_addr
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE ((val <: admininstr)^k{val}) from the stack.
3. Let F be the current frame.
4. Push YetE ((n, f, [LABEL__admininstr(n, [], (instr <: admininstr)*{instr})])) to the stack.

ref.func
1. Push YetE (REF.FUNC_ADDR_admininstr($funcaddr(z)[x])) to the stack.

local.get
1. Push YetE (($local(z, x) <: admininstr)) to the stack.

global.get
1. Push YetE (($global(z, x).VALUE_globalinst <: admininstr)) to the stack.

table.get
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, i)) from the stack.
3. If YetC (), then:
  a. Trap.
4. If YetC (), then:
  a. Push YetE (($table(z, x).ELEM_tableinst[i] <: admininstr)) to the stack.

table.size
1. Push YetE (CONST_admininstr(I32_numtype, n)) to the stack.

table.fill
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, n)) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop YetE ((val <: admininstr)) from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop YetE (CONST_admininstr(I32_numtype, i)) from the stack.
7. If YetC (), then:
  a. Trap.
8. If YetC (), then:
  a. Do nothing.
9. If YetC (), then:
  a. Push YetE (CONST_admininstr(I32_numtype, i)) to the stack.
  b. Push YetE ((val <: admininstr)) to the stack.
  c. Execute (TABLE.SET YetE (x)).
  d. Push YetE (CONST_admininstr(I32_numtype, (i + 1))) to the stack.
  e. Push YetE ((val <: admininstr)) to the stack.
  f. Push YetE (CONST_admininstr(I32_numtype, (n - 1))) to the stack.
  g. Execute (TABLE.FILL YetE (x)).

table.copy
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, n)) from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop YetE (CONST_admininstr(I32_numtype, i)) from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop YetE (CONST_admininstr(I32_numtype, j)) from the stack.
7. If YetC (), then:
  a. Trap.
8. If YetC (), then:
  a. Do nothing.
9. If YetC (), then:
  a. Push YetE (CONST_admininstr(I32_numtype, j)) to the stack.
  b. Push YetE (CONST_admininstr(I32_numtype, i)) to the stack.
  c. Execute (TABLE.GET YetE (y)).
  d. Execute (TABLE.SET YetE (x)).
  e. Push YetE (CONST_admininstr(I32_numtype, (j + 1))) to the stack.
  f. Push YetE (CONST_admininstr(I32_numtype, (i + 1))) to the stack.
  g. Push YetE (CONST_admininstr(I32_numtype, (n - 1))) to the stack.
  h. Execute (TABLE.COPY YetE (x) YetE (y)).
10. If YetC (), then:
  a. Push YetE (CONST_admininstr(I32_numtype, ((j + n) - 1))) to the stack.
  b. Push YetE (CONST_admininstr(I32_numtype, ((i + n) - 1))) to the stack.
  c. Execute (TABLE.GET YetE (y)).
  d. Execute (TABLE.SET YetE (x)).
  e. Push YetE (CONST_admininstr(I32_numtype, j)) to the stack.
  f. Push YetE (CONST_admininstr(I32_numtype, i)) to the stack.
  g. Push YetE (CONST_admininstr(I32_numtype, (n - 1))) to the stack.
  h. Execute (TABLE.COPY YetE (x) YetE (y)).

table.init
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, n)) from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop YetE (CONST_admininstr(I32_numtype, i)) from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop YetE (CONST_admininstr(I32_numtype, j)) from the stack.
7. If YetC (), then:
  a. Trap.
8. If YetC (), then:
  a. Do nothing.
9. If YetC (), then:
  a. Push YetE (CONST_admininstr(I32_numtype, j)) to the stack.
  b. Push YetE (($elem(z, y).ELEM_eleminst[i] <: admininstr)) to the stack.
  c. Execute (TABLE.SET YetE (x)).
  d. Push YetE (CONST_admininstr(I32_numtype, (j + 1))) to the stack.
  e. Push YetE (CONST_admininstr(I32_numtype, (i + 1))) to the stack.
  f. Push YetE (CONST_admininstr(I32_numtype, (n - 1))) to the stack.
  g. Execute (TABLE.INIT YetE (x) YetE (y)).

load
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, i)) from the stack.
3. If YetC (), then:
  a. Trap.
4. If YetC (), then:
  a. Push YetE (CONST_admininstr(nt, c)) to the stack.
5. If YetC (), then:
  a. Trap.
6. If YetC (), then:
  a. Push YetE (CONST_admininstr(nt, $ext(n, $size(nt <: valtype), sx, c))) to the stack.

memory.size
1. Push YetE (CONST_admininstr(I32_numtype, n)) to the stack.

memory.fill
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, n)) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop YetE ((val <: admininstr)) from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop YetE (CONST_admininstr(I32_numtype, i)) from the stack.
7. If YetC (), then:
  a. Trap.
8. If YetC (), then:
  a. Do nothing.
9. If YetC (), then:
  a. Push YetE (CONST_admininstr(I32_numtype, i)) to the stack.
  b. Push YetE ((val <: admininstr)) to the stack.
  c. Execute (STORE YetE (I32_numtype) YetE (?(8)) YetE (0) YetE (0)).
  d. Push YetE (CONST_admininstr(I32_numtype, (i + 1))) to the stack.
  e. Push YetE ((val <: admininstr)) to the stack.
  f. Push YetE (CONST_admininstr(I32_numtype, (n - 1))) to the stack.
  g. Execute (MEMORY.FILL).

memory.copy
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, n)) from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop YetE (CONST_admininstr(I32_numtype, i)) from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop YetE (CONST_admininstr(I32_numtype, j)) from the stack.
7. If YetC (), then:
  a. Trap.
8. If YetC (), then:
  a. Do nothing.
9. If YetC (), then:
  a. Push YetE (CONST_admininstr(I32_numtype, j)) to the stack.
  b. Push YetE (CONST_admininstr(I32_numtype, i)) to the stack.
  c. Execute (LOAD YetE (I32_numtype) YetE (?((8, U_sx))) YetE (0) YetE (0)).
  d. Execute (STORE YetE (I32_numtype) YetE (?(8)) YetE (0) YetE (0)).
  e. Push YetE (CONST_admininstr(I32_numtype, (j + 1))) to the stack.
  f. Push YetE (CONST_admininstr(I32_numtype, (i + 1))) to the stack.
  g. Push YetE (CONST_admininstr(I32_numtype, (n - 1))) to the stack.
  h. Execute (MEMORY.COPY).
10. If YetC (), then:
  a. Push YetE (CONST_admininstr(I32_numtype, ((j + n) - 1))) to the stack.
  b. Push YetE (CONST_admininstr(I32_numtype, ((i + n) - 1))) to the stack.
  c. Execute (LOAD YetE (I32_numtype) YetE (?((8, U_sx))) YetE (0) YetE (0)).
  d. Execute (STORE YetE (I32_numtype) YetE (?(8)) YetE (0) YetE (0)).
  e. Push YetE (CONST_admininstr(I32_numtype, j)) to the stack.
  f. Push YetE (CONST_admininstr(I32_numtype, i)) to the stack.
  g. Push YetE (CONST_admininstr(I32_numtype, (n - 1))) to the stack.
  h. Execute (MEMORY.COPY).

memory.init
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, n)) from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop YetE (CONST_admininstr(I32_numtype, i)) from the stack.
5. Assert: Due to validation, a value of value type i32 is on the top of the stack.
6. Pop YetE (CONST_admininstr(I32_numtype, j)) from the stack.
7. If YetC (), then:
  a. Trap.
8. If YetC (), then:
  a. Do nothing.
9. If YetC (), then:
  a. Push YetE (CONST_admininstr(I32_numtype, j)) to the stack.
  b. Push YetE (CONST_admininstr(I32_numtype, $data(z, x).DATA_datainst[i])) to the stack.
  c. Execute (STORE YetE (I32_numtype) YetE (?(8)) YetE (0) YetE (0)).
  d. Push YetE (CONST_admininstr(I32_numtype, (j + 1))) to the stack.
  e. Push YetE (CONST_admininstr(I32_numtype, (i + 1))) to the stack.
  f. Push YetE (CONST_admininstr(I32_numtype, (n - 1))) to the stack.
  g. Execute (MEMORY.INIT YetE (x)).

local.set
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE ((val <: admininstr)) from the stack.
3. YetI: Perform $with_local(z, x, val).

global.set
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE ((val <: admininstr)) from the stack.
3. YetI: Perform $with_global(z, x, val).

table.set
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE ((ref <: admininstr)) from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop YetE (CONST_admininstr(I32_numtype, i)) from the stack.
5. If YetC (), then:
  a. YetI: Perform z.
  b. Trap.
6. If YetC (), then:
  a. YetI: Perform $with_table(z, x, i, ref).

table.grow
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, n)) from the stack.
3. Assert: Due to validation, a value is on the top of the stack.
4. Pop YetE ((ref <: admininstr)) from the stack.
5. If YetC (), then:
  a. YetI: Perform $with_tableinst(z, x, ti').
  b. Push YetE (CONST_admininstr(I32_numtype, |$table(z, x).ELEM_tableinst|)) to the stack.
6. If YetC (), then:
  a. YetI: Perform z.
  b. Push YetE (CONST_admininstr(I32_numtype, - 1)) to the stack.

elem.drop
1. YetI: Perform $with_elem(z, x, []).

store
1. Assert: Due to validation, a value is on the top of the stack.
2. Pop YetE (CONST_admininstr(nt, c)) from the stack.
3. Assert: Due to validation, a value of value type i32 is on the top of the stack.
4. Pop YetE (CONST_admininstr(I32_numtype, i)) from the stack.
5. If YetC (), then:
  a. YetI: Perform z.
  b. Trap.
6. If YetC (), then:
  a. YetI: Perform $with_mem(z, 0, (i + n_O), ($size(nt <: valtype) / 8), b*{b}).
7. If YetC (), then:
  a. YetI: Perform z.
  b. Trap.
8. If YetC (), then:
  a. YetI: Perform $with_mem(z, 0, (i + n_O), (n / 8), b*{b}).

memory.grow
1. Assert: Due to validation, a value of value type i32 is on the top of the stack.
2. Pop YetE (CONST_admininstr(I32_numtype, n)) from the stack.
3. If YetC (), then:
  a. YetI: Perform $with_meminst(z, 0, mi').
  b. Push YetE (CONST_admininstr(I32_numtype, (|$mem(z, 0).DATA_meminst| / (64 * $Ki)))) to the stack.
4. If YetC (), then:
  a. YetI: Perform z.
  b. Push YetE (CONST_admininstr(I32_numtype, - 1)) to the stack.

data.drop
1. YetI: Perform $with_data(z, x, []).

== Complete.
```
