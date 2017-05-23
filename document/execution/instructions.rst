.. _exec-instr:
.. index:: instruction, function type, store

Instructions
------------


.. _exec-instr-numeric:
.. index:: numeric instruction
   pair: execution; instruction
   single: abstract syntax; instruction

Numeric Instructions
~~~~~~~~~~~~~~~~~~~~


.. _exec-const:

:math:`t\K{.}\CONST~c`
......................

1. Push the value :math:`t.\CONST~c` to the stack.

.. note::
   No formal reduction rule is required for this instruction, since |CONST| instructions coincide with :ref:`values <syntax-val>`.


.. _exec-unop:

:math:`t\K{.}\unop`
...................

1. Assert: due to :ref:`validation <valid-unop>`, a value of :ref:`value type <syntax-valtype>` :math:`t` is on the top of the stack.

2. Pop the value :math:`t.\CONST~c_1` from the stack.

3. If :math:`\unop_t(c_1)` is defined, then:

   a. Let :math:`c` be the result of computing :math:`\unop_t(c_1)`.

   b. Push the value :math:`t.\CONST~c` to the stack.

4. Else:

   a. Trap.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~t\K{.}\unop &\stepto& (t\K{.}\CONST~c)
     & (\mbox{if}~\unop_t(c_1) = c) \\
   (t\K{.}\CONST~c_1)~t\K{.}\unop &\stepto& \TRAP
     & (\mbox{otherwise})
   \end{array}


.. _exec-binop:

:math:`t\K{.}\binop`
....................

1. Assert: due to :ref:`validation <valid-binop>`, two values of :ref:`value type <syntax-valtype>` :math:`t` are on the top of the stack.

2. Pop the value :math:`t.\CONST~c_2` from the stack.

3. Pop the value :math:`t.\CONST~c_1` from the stack.

4. If :math:`\binop_t(c_1, c_2)` is defined, then:

   a. Let :math:`c` be the result of computing :math:`\binop_t(c_1, c_2)`.

   b. Push the value :math:`t.\CONST~c` to the stack.

5. Else:

   a. Trap.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~(t\K{.}\CONST~c_2)~t\K{.}\binop &\stepto& (t\K{.}\CONST~c)
     & (\mbox{if}~\binop_t(c_1,c_2) = c) \\
   (t\K{.}\CONST~c_1)~(t\K{.}\CONST~c_2)~t\K{.}\binop &\stepto& \TRAP
     & (\mbox{otherwise})
   \end{array}


.. _exec-testop:

:math:`t\K{.}\testop`
.....................

1. Assert: due to :ref:`validation <valid-testop>`, a value of :ref:`value type <syntax-valtype>` :math:`t` is on the top of the stack.

2. Pop the value :math:`t.\CONST~c_1` from the stack.

3. Let :math:`c` be the result of computing :math:`\testop_t(c_1)`.

4. Push the value :math:`\I32.\CONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~t\K{.}\testop &\stepto& (t\K{.}\CONST~c)
     & (\mbox{if}~\testop_t(c_1) = c) \\
   \end{array}


.. _exec-relop:

:math:`t\K{.}\relop`
....................

1. Assert: due to :ref:`validation <valid-relop>`, two values of :ref:`value type <syntax-valtype>` :math:`t` are on the top of the stack.

2. Pop the value :math:`t.\CONST~c_2` from the stack.

3. Pop the value :math:`t.\CONST~c_1` from the stack.

4. Let :math:`c` be the result of computing :math:`\relop_t(c_1, c_2)`.

5. Push the value :math:`\I32.\CONST~c` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~(t\K{.}\CONST~c_2)~t\K{.}\relop &\stepto& (t\K{.}\CONST~c)
     & (\mbox{if}~\relop_t(c_1,c_2) = c) \\
   \end{array}


.. _exec-cvtop:

:math:`t_2\K{.}\cvtop/t_1`
..........................

1. Assert: due to :ref:`validation <valid-cvtop>`, a value of :ref:`value type <syntax-valtype>` :math:`t_1` is on the top of the stack.

2. Pop the value :math:`t_1.\CONST~c_1` from the stack.

3. If :math:`\cvtop_{t_1,t_2}(c_1)` is defined:

   a. Let :math:`c_2` be the result of computing :math:`\cvtop_{t_1,t_2}(c_1)`.

   b. Push the value :math:`t_2.\CONST~c_2` to the stack.

4. Else:

   a. Trap.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (t\K{.}\CONST~c_1)~t_2\K{.}\cvtop\K{/}t_1 &\stepto& (t_2\K{.}\CONST~c_2)
     & (\mbox{if}~\cvtop_{t_1,t_2}(c_1) = c_2) \\
   (t\K{.}\CONST~c_1)~t_2\K{.}\cvtop\K{/}t_1 &\stepto& \TRAP
     & (\mbox{otherwise})
   \end{array}


.. _exec-instr-parametric:
.. index:: parametric instructions
   pair: execution; instruction
   single: abstract syntax; instruction

Parametric Instructions
~~~~~~~~~~~~~~~~~~~~~~~

.. _exec-drop:

:math:`\DROP`
.............

1. Assert: due to :ref:`validation <valid-drop>`, a value is on the top of the stack.

2. Pop the value :math:`\val` from the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \val~~\DROP &\stepto& \epsilon
   \end{array}


.. _exec-select:

:math:`\SELECT`
...............

1. Assert: due to :ref:`validation <valid-select>`, a value :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

2. Pop the value :math:`\I32.\CONST~c` from the stack.

3. Assert: due to :ref:`validation <valid-select>`, two more values (of the same :ref:`value type <syntax-valtype>`) are on the top of the stack.

4. Pop the value :math:`\val_2` from the stack.

5. Pop the value :math:`\val_1` from the stack.

6. If :math:`c` is not :math:`0`, then:

   a. Push the value :math:`\val_1` back to the stack.

7. Else:

   a. Push the value :math:`\val_2` back to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \val_1~\val_2~(\I32\K{.}\CONST~c)~\SELECT &\stepto& \val_1
     & (\mbox{if}~c \neq 0) \\
   \val_1~\val_2~(\I32\K{.}\CONST~c)~\SELECT &\stepto& \val_2
     & (\mbox{if}~c = 0) \\
   \end{array}


.. _exec-instr-variable:
.. index:: variable instructions, local index, global index, address, global address, global instance, store, frame
   pair: execution; instruction
   single: abstract syntax; instruction

Variable Instructions
~~~~~~~~~~~~~~~~~~~~~

.. _exec-get_local:

:math:`\GETLOCAL~x`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-get_local>`, :math:`F.\LOCALS[x]` exists.

3. Let :math:`\val` be the value :math:`F.\LOCALS[x]`.

4. Push the value :math:`\val` to the stack.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; (\GETLOCAL~x) &\stepto& F; \val
     & (\mbox{if}~F.\LOCALS[x] = \val) \\
   \end{array}


.. _exec-set_local:

:math:`\SETLOCAL~x`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-set_local>`, :math:`F.\LOCALS[x]` exists.

3. Assert: due to :ref:`validation <valid-set_local>`, a value is on the top of the stack.

4. Pop the value :math:`\val` from the stack.

5. Replace :math:`F.\LOCALS[x]` with the value :math:`\val`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; \val~(\SETLOCAL~x) &\stepto& F'; \epsilon
     & (\mbox{if}~F' = F \with \LOCALS[x] = \val) \\
   \end{array}


.. _exec-tee_local:

:math:`\TEELOCAL~x`
...................

1. Assert: due to :ref:`validation <valid-tee_local>`, a value is on the top of the stack.

2. Pop the value :math:`\val` from the stack.

3. Push the value :math:`\val` to the stack.

4. Push the value :math:`\val` to the stack.

5. :ref:`Execute <exec-set_local>` the instruction :math:`(\SETLOCAL~x)`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; \val~(\TEELOCAL~x) &\stepto& F'; \val~\val~(\SETLOCAL~x)
   \end{array}


.. _exec-get_global:

:math:`\GETGLOBAL~x`
....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-get_global>`, :math:`F.\MODULE.\GLOBALS[x]` exists.

3. Let :math:`a` be the :ref:`global address <syntax-globaladdr>` :math:`F.\MODULE.\GLOBALS[x]`.

4. Assert: due to :ref:`validation <valid-get_global>`, :math:`S.\GLOBALS[a]` exists.

5. Let :math:`\X{glob}` be the :ref:`global instance <syntax-globalinst>` :math:`S.\GLOBALS[a]`.

6. Let :math:`\val` be the value :math:`\X{glob}.\VALUE`.

7. Push the value :math:`\val` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\GETGLOBAL~x) &\stepto& S; F; \val
   \end{array}
   \\ \qquad
     (\mbox{if}~S.\GLOBALS[F.\MODULE.\GLOBALS[x]].\VALUE = \val) \\
   \end{array}


.. _exec-set_global:

:math:`\SETGLOBAL~x`
....................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-set_global>`, :math:`F.\MODULE.\GLOBALS[x]` exists.

3. Let :math:`a` be the :ref:`global address <syntax-globaladdr>` :math:`F.\MODULE.\GLOBALS[x]`.

4. Assert: due to :ref:`validation <valid-set_global>`, :math:`S.\GLOBALS[a]` exists.

5. Let :math:`\X{glob}` be the :ref:`global instance <syntax-globalinst>` :math:`S.\GLOBALS[a]`.

6. Assert: due to :ref:`validation <valid-set_global>`, a value is on the top of the stack.

7. Pop the value :math:`\val` from the stack.

8. Replace :math:`\X{glob}.\VALUE` with the value :math:`\val`.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; \val~(\SETGLOBAL~x) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
   (\mbox{if}~S' = S \with \GLOBALS[F.\MODULE.\GLOBALS[x]].\VALUE = \val) \\
   \end{array}


.. _exec-instr-memory:
.. _exec-memarg:
.. index:: memory instruction, memory index, store, frame, address, memory address, memory instance, store, frame, value type, width
   pair: execution; instruction
   single: abstract syntax; instruction

Memory Instructions
~~~~~~~~~~~~~~~~~~~

.. _exec-load:
.. _exec-loadn:

:math:`t\K{.}\LOAD~\memarg` and :math:`t\K{.}\LOAD{N}\K{\_}\sx~\memarg`
.......................................................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-loadn>`, :math:`F.\MODULE.\MEMS[0]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\MODULE.\MEMS[0]`.

4. Assert: due to :ref:`validation <valid-loadn>`, :math:`S.\MEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\MEMS[a]`.

6. Assert: due to :ref:`validation <valid-loadn>`, a value :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be :math:`i + \memarg.\OFFSET`.

9. If :math:`N` is not part of the instruction, then:

   a. Let :math:`N` be the :ref:`width <syntax-valtype>` :math:`|t|` of :ref:`value type <syntax-valtype>` :math:`t`.

10. If :math:`\X{ea} + N` is larger than the length of :math:`\X{mem}.\DATA`, then:

    a. Trap.

11. Let :math:`b^\ast` be the byte sequence :math:`\X{mem}.\DATA[\X{ea}:N]`.

12. If :math:`N` and :math:`\sx` are part of the instruction, then:

    a. Let :math:`n` be the integer for which :math:`\bytes_N(n) = b^\ast`.

    b. Let :math:`c` be the result of computing :math:`\extend_{\sx,N}(n)`.

13. Else:

    a. Let :math:`c` be the constant for which :math:`\bytes_t(c) = b^\ast`.

14. Push the value :math:`t.\CONST~c` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(t.\LOAD~\memarg) &\stepto& S; F; (t.\CONST~c)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\mbox{if} & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + |t| \leq |S.\MEMS[F.\MODULE.\MEMS[0]].\DATA| \\
     \wedge & \bytes_t(c) = S.\MEMS[F.\MODULE.\MEMS[0]].\DATA[\X{ea}:|t|])
     \end{array} \\
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(t.\LOAD{N}\K{\_}\sx~\memarg) &\stepto&
     S; F; (t.\CONST~\extend_{\sx,N}(n))
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\mbox{if} & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N \leq |S.\MEMS[F.\MODULE.\MEMS[0]].\DATA| \\
     \wedge & \bytes_N(n) = S.\MEMS[F.\MODULE.\MEMS[0]].\DATA[\X{ea}:N])
     \end{array} \\
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~k)~(t.\LOAD({N}\K{\_}\sx)^?~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\mbox{otherwise}) \\
   \end{array}

.. note::
   The alignment :math:`\memarg.\ALIGN` does not affect the semantics.
   Unaligned access is supported for all types, and succeeds regardless of the annotation.
   The only purpose of the annotation is to provide optimizatons hints.


.. _exec-store:
.. _exec-storen:

:math:`t\K{.}\STORE~\memarg` and :math:`t\K{.}\STORE{N}~\memarg`
................................................................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-storen>`, :math:`F.\MODULE.\MEMS[0]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\MODULE.\MEMS[0]`.

4. Assert: due to :ref:`validation <valid-storen>`, :math:`S.\MEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\MEMS[a]`.

6. Assert: due to :ref:`validation <valid-storen>`, a value :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

7. Pop the value :math:`\I32.\CONST~i` from the stack.

8. Let :math:`\X{ea}` be :math:`i + \memarg.\OFFSET`.

9. If :math:`N` is not part of the instruction, then:

   a. Let :math:`N` be the :ref:`width <syntax-valtype>` :math:`|t|` of :ref:`value type <syntax-valtype>` :math:`t`.

10. If :math:`\X{ea} + N` is larger than the length of :math:`\X{mem}.\DATA`, then:

    a. Trap.

11. Assert: due to :ref:`validation <valid-storen>`, a value of :ref:`value type <syntax-valtype>` :math:`t` is on the top of the stack.

12. Pop the value :math:`t.\CONST~c` from the stack.

13. If :math:`N` is part of the instruction, then:

    a. Let :math:`n` be the result of computing :math:`\wrap_N(c)`.

    b. Let :math:`b^\ast` be the byte sequence :math:`\bytes_N(n)`.

14. Else:

    a. Let :math:`b^\ast` be the byte sequence :math:`\bytes_t(c)`.

15. Replace the bytes :math:`\X{mem}.\DATA[\X{ea}:N]` with :math:`b^\ast`.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(t.\STORE~\memarg) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\mbox{if} & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + |t| \leq |S.\MEMS[F.\MODULE.\MEMS[0]].\DATA| \\
     \wedge & S' = S \with \MEMS[F.\MODULE.\MEMS[0]].\DATA[\X{ea}:|t|] = \bytes_t(c)
     \end{array} \\
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(t.\STORE{N}~\memarg) &\stepto& S'; F; \epsilon
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\mbox{if} & \X{ea} = i + \memarg.\OFFSET \\
     \wedge & \X{ea} + N \leq |S.\MEMS[F.\MODULE.\MEMS[0]].\DATA| \\
     \wedge & S' = S \with \MEMS[F.\MODULE.\MEMS[0]].\DATA[\X{ea}:N] = \bytes_N(\wrap_N(c))
     \end{array} \\
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~k)~(t.\STORE{N}^?~\memarg) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\mbox{otherwise}) \\
   \end{array}


.. _exec-current_memory:

:math:`\CURRENTMEMORY`
......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-current_memory>`, :math:`F.\MODULE.\MEMS[0]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\MODULE.\MEMS[0]`.

4. Assert: due to :ref:`validation <valid-current_memory>`, :math:`S.\MEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\MEMS[a]`.

6. Let :math:`\X{sz}` be the length of :math:`\X{mem}.\DATA` divided by the :ref:`page size <page-size>`.

7. Push the value :math:`\I32.\CONST~\X{sz}` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; \CURRENTMEMORY &\stepto& S; F; (\I32.\CONST~\X{sz})
   \end{array}
   \\ \qquad
     (\mbox{if}~|S.\MEMS[F.\MODULE.\MEMS[0]].\DATA| = \X{sz}\cdot64\,\F{Ki}) \\
   \end{array}


.. _exec-grow_memory:

:math:`\GROWMEMORY`
...................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-grow_memory>`, :math:`F.\MODULE.\MEMS[0]` exists.

3. Let :math:`a` be the :ref:`memory address <syntax-memaddr>` :math:`F.\MODULE.\MEMS[0]`.

4. Assert: due to :ref:`validation <valid-grow_memory>`, :math:`S.\MEMS[a]` exists.

5. Let :math:`\X{mem}` be the :ref:`memory instance <syntax-meminst>` :math:`S.\MEMS[a]`.

6. Let :math:`\X{sz}` be the length of :math:`S.\MEMS[a]` divided by the :ref:`page size <page-size>`.

7. Assert: due to :ref:`validation <valid-grow_memory>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

8. Pop the value :math:`\I32.\CONST~n` from the stack.

9. If :math:`\X{mem}.\MAX` is not empty and :math:`\X{sz} + n` is larger than :math:`\X{mem}.\MAX`, then:

  a. Push the value :math:`\I32.\CONST~(-1)` to the stack.

10. Else, either:

    a. Let :math:`\X{len}` be :math:`n` multiplied with the :ref:`page size <page-size>`.

    b. Append :math:`\X{len}` bytes with value :math:`\hex{00}` to :math:`S.\MEMS[a]`.

    c. Push the value :math:`\I32.\CONST~\X{sz}` to the stack.

11. Or:

    a. Push the value :math:`\I32.\CONST~(-1)` to the stack.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~n)~\GROWMEMORY &\stepto& S'; F; (\I32.\CONST~\X{sz})
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\mbox{if} & F.\MODULE.\MEMS[0] = a \\
     \wedge & |S.\MEMS[a].\DATA| = \X{sz}\cdot64\,\F{Ki} \\
     \wedge & (\X{sz} + n \leq S.\MEMS[a].\MAX \vee S.\MEMS[a].\MAX = \epsilon) \\
     \wedge & S' = S \with \MEMS[a].\DATA = S.\MEMS[a].\DATA~(\hex{00})^{n\cdot64\,\F{Ki}}) \\
     \end{array} \\
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~n)~\GROWMEMORY &\stepto& S; F; (\I32.\CONST~{-1})
   \end{array}
   \end{array}

.. note::
   The |GROWMEMORY| instruction is non-deterministic.
   It may either succeed, returning the old memory size :math:`\X{sz}`,
   or fail, returning :math:`{-1}`.
   Failure *must* occur if the referenced memory instance has a maximum size defined that would be exceeded.
   However, failure *can* occur in other cases as well.
   In practice, the choice depends on the resources available to the :ref:`embedder <embedder>`.


.. _exec-instr-control:
.. _exec-label:
.. index:: control instructions, structured control, label, block, branch, result type, label index, function index, type index, vector, address, table address, table instance, store, frame
   pair: execution; instruction
   single: abstract syntax; instruction

Control Instructions
~~~~~~~~~~~~~~~~~~~~

.. _exec-nop:

:math:`\NOP`
............

1. Do nothing.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \NOP &\stepto& \epsilon
   \end{array}


.. _exec-unreachable:

:math:`\UNREACHABLE`
....................

1. Trap.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \UNREACHABLE &\stepto& \TRAP
   \end{array}


.. _exec-block:

:math:`\BLOCK~[t^?]~\instr^\ast~\END`
.....................................

1. Let :math:`n` be the arity :math:`|t^?|` of the :ref:`result type <syntax-resulttype>` :math:`t^?`.

2. Let :math:`L` be the label whose arity is :math:`n` and whose continuation is the end of the block.

3. :ref:`Enter <exec-instr-seq-enter>` the instruction sequence :math:`\instr^\ast` with label :math:`L`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \BLOCK~[t^n]~\instr^\ast~\END &\stepto&
     \LABEL_n\{\epsilon\}~\instr^\ast~\END
   \end{array}


.. _exec-loop:

:math:`\LOOP~[t^?]~\instr^\ast~\END`
....................................

1. Let :math:`L` be the label whose arity is :math:`0` and whose continuation is the start of the loop.

2. :ref:`Enter <exec-instr-seq-enter>` the instruction sequence :math:`\instr^\ast` with label :math:`L`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \LOOP~[t^?]~\instr^\ast~\END &\stepto&
     \LABEL_0\{\LOOP~[t^?]~\instr^\ast~\END\}~\instr^\ast~\END
   \end{array}


.. _exec-if:

:math:`\IF~[t^?]~\instr_1^\ast~\ELSE~\instr_2^\ast~\END`
........................................................

1. Assert: due to :ref:`validation <valid-if>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

2. Pop the value :math:`\I32.\CONST~c` from the stack.

3. Let :math:`n` be the arity :math:`|t^?|` of the :ref:`result type <syntax-resulttype>` :math:`t^?`.

4. Let :math:`L` be the label whose arity is :math:`n` and whose continuation is the end of the |IF| instruction.

5. If :math:`c` is not :math:`0`, then:

   a. :ref:`Enter <exec-instr-seq-enter>` the instruction sequence :math:`\instr_1^\ast` with label :math:`L`.

6. Else:

   a. :ref:`Enter <exec-instr-seq-enter>` the instruction sequence :math:`\instr_2^\ast` with label :math:`L`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\I32.\CONST~c)~\IF~[t^n]~\instr_1^\ast~\ELSE~\instr_2^\ast~\END &\stepto&
     \LABEL_n\{\epsilon\}~\instr_1^\ast~\END
     & (\mbox{if}~c \neq 0) \\
   (\I32.\CONST~c)~\IF~[t^n]~\instr_1^\ast~\ELSE~\instr_2^\ast~\END &\stepto&
     \LABEL_n\{\epsilon\}~\instr_2^\ast~\END
     & (\mbox{if}~c = 0) \\
   \end{array}


.. _exec-br:

:math:`\BR~l`
.............

1. Assert: due to :ref:`validation <valid-br>`, the stack contains at least :math:`l+1` labels.

2. Let :math:`L` be the :math:`l`-th label appearing on the stack, starting from the top and counting from zero.

3. Let :math:`n` be the arity of :math:`L`.

4. Assert: due to :ref:`validation <valid-br>`, there are at least :math:`n` values on the top of the stack.

5. Pop the values :math:`\val^n` from the stack.

6. Repeat :math:`l+1` times:

   a. While the top of the stack is a value, do:

      i. Pop the value from the stack.

   b. Assert: due to :ref:`validation <valid-br>`, the top of the stack now is a label.

   c. Pop the label from the stack.

7. Push the values :math:`\val^n` to the stack.

8. Jump to the continuation of :math:`L`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \LABEL_n\{\instr^\ast\}~\XB^l[\val^n~(\BR~l)]~\END &\stepto& \val^n~\instr^\ast
   \end{array}


.. _exec-br_if:

:math:`\BRIF~l`
...............

1. Assert: due to :ref:`validation <valid-br_if>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

2. Pop the value :math:`\I32.\CONST~c` from the stack.

3. If :math:`c` is not :math:`0`, then:

   a. :ref:`Execute <exec-br>` the instruction :math:`(\BR~l)`.

4. Else:

   a. Do nothing.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\I32.\CONST~c)~(\BRIF~l) &\stepto& (\BR~l)
     & (\mbox{if}~c \neq 0) \\
   (\I32.\CONST~c)~(\BRIF~l) &\stepto& \epsilon
     & (\mbox{if}~c = 0) \\
   \end{array}


.. _exec-br_table:

:math:`\BRTABLE~l^\ast~l_N`
...........................

1. Assert: due to :ref:`validation <valid-if>`, a value of :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

2. Pop the value :math:`\I32.\CONST~i` from the stack.

3. If :math:`i` is smaller than the length of :math:`l^\ast`, then:

   a. Let :math:`l_i` be the label :math:`l^\ast[i]`.

   b. :ref:`Execute <exec-br>` the instruction :math:`(\BR~l_i)`.

4. Else:

   a. :ref:`Execute <exec-br>` the instruction :math:`(\BR~l_N)`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   (\I32.\CONST~i)~(\BRTABLE~l^\ast~l_N) &\stepto& (\BR~l_i)
     & (\mbox{if}~l^\ast[i] = l_i) \\
   (\I32.\CONST~i)~(\BRTABLE~l^\ast~l_N) &\stepto& (\BR~l_N)
     & (\mbox{if}~|l^\ast| \leq i) \\
   \end{array}


.. _exec-return:

:math:`\RETURN`
...............

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`n` be the arity of :math:`F`.

3. Assert: due to :ref:`validation <valid-br>`, there are at least :math:`n` values on the top of the stack.

4. Pop the results :math:`\val^n` from the stack.

5. Assert: due to :ref:`validation <valid-return>`, the stack contains at least one :ref:`frame <syntax-frame>`.

6. While the top of the stack is not a frame, do:

   a. Pop the top element from the stack.

7. Assert: the top of the stack is the frame :math:`F`.

8. Pop the frame from the stack.

9. Push :math:`\val^n` to the stack.

10. Jump to the instruction after the original call.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \FRAME_n\{F\}~\XB^k[\val^n~\RETURN]~\END &\stepto& \val^n
   \end{array}


.. _exec-call:

:math:`\CALL~x`
...............

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-call>`, :math:`F.\MODULE.\FUNCS[x]` exists.

3. Let :math:`a` be the :ref:`function address <syntax-funcaddr>` :math:`F.\MODULE.\FUNCS[x]`.

4. :ref:`Invoke <exec-invoke>` the function instance at address :math:`a`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   F; (\CALL~x) &\stepto& F; (\INVOKE~a)
     & (\mbox{if}~F.\MODULE.\FUNCS[x] = a)
   \end{array}


.. _exec-call_indirect:

:math:`\CALLINDIRECT~x`
.......................

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\MODULE.\TABLES[0]` exists.

3. Let :math:`\X{ta}` be the :ref:`table address <syntax-tableaddr>` :math:`F.\MODULE.\TABLES[0]`.

4. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`S.\TABLES[\X{ta}]` exists.

5. Let :math:`\X{tab}` be the :ref:`table instance <syntax-tableinst>` :math:`S.\TABLES[\X{ta}]`.

6. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`F.\MODULE.\TYPES[x]` exists.

7. Let :math:`\X{ft}_{\F{expect}}` be the :ref:`function type <syntax-functype>` :math:`F.\MODULE.\TYPES[x]`.

8. Assert: due to :ref:`validation <valid-call_indirect>`, a value with :ref:`value type <syntax-valtype>` |I32| is on the top of the stack.

9. Pop the value :math:`\I32.\CONST~i` from the stack.

10. If :math:`i` is not smaller than the length of :math:`\X{tab}.\ELEM`, then:

    a. Trap.

11. If :math:`\X{tab}.\ELEM[i]` is uninitialized, then:

    a. Trap.

12. Let :math:`a` be the :ref:`function address <syntax-funcaddr>` :math:`\X{tab}.\ELEM[i]`.

13. Assert: due to :ref:`validation <valid-call_indirect>`, :math:`S.\FUNCS[a]` exists.

14. Let :math:`\X{f}` be the :ref:`function instance <syntax-funcinst>` :math:`S.\FUNCS[a]`.

15. Assert: due to :ref:`validation <valid-func>`, :math:`\X{f}.\MODULE.\TYPES[\X{f}.\CODE.\TYPE]` exists.

16. Let :math:`\X{ft}_{\F{actual}}` be the :ref:`function type <syntax-functype>` :math:`\X{f}.\MODULE.\TYPES[\X{f}.\CODE.\TYPE]`.

15. If :math:`\X{ft}_{\F{actual}}` and :math:`\X{ft}_{\F{expect}}` differ, then:

    a. Trap.

17. :ref:`Invoke <exec-invoke>` the function instance at address :math:`a`.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\CALLINDIRECT~x) &\stepto& S; F; (\INVOKE~a)
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\mbox{if} & S.\TABLES[F.\MODULE.\TABLES[0]].\ELEM[i] = a \\
     \wedge & S.\FUNCS[a] = f \\
     \wedge & F.\MODULE.\TYPES[x] = f.\MODULE.\TYPES[f.\CODE.\TYPE])
     \end{array} \\
   \begin{array}{lcl@{\qquad}l}
   S; F; (\I32.\CONST~i)~(\CALLINDIRECT~x) &\stepto& S; F; \TRAP
   \end{array}
   \\ \qquad
     (\mbox{otherwise})
   \end{array}


.. _exec-instr-seq:
.. index:: instruction, instruction sequence

Instruction Sequences
~~~~~~~~~~~~~~~~~~~~~

The following auxiliary rules define the semantics of executing an :ref:`instruction sequence <syntax-instr-seq>`
that is part of a :ref:`structured control instruction <exec-instr-control>`.


.. _exec-instr-seq-enter:

Entering :math:`\instr^\ast` with label :math:`L`
.................................................

1. Push :math:`L` to the stack.

2. :ref:`Jump <exec-jump>` to the start of the instruction sequence :math:`\instr^\ast`.

.. note::
   No formal reduction rule is needed for entering an instruction sequence,
   because the label :math:`L` is embedded in the :ref:`administrative instruction <syntax-instr-admin>` that structured control instructions reduce to directly.


.. _exec-instr-seq-exit:

Exiting :math:`\instr^\ast` with label :math:`L`
................................................

When the end of a labelled instruction sequence is reached without a jump or trap aborting it, then the following steps are performed.

1. Let :math:`n` be the arity of :math:`L`.

2. Assert: due to :ref:`validation <valid-instr-seq>`, there are :math:`n` values on the top of the stack.

3. Pop the results :math:`\val^n` from the stack.

4. Assert: due to :ref:`validation <valid-instr-seq>`, the label :math:`L` is now on the top of the stack.

5. Pop the label from the stack.

6. Push :math:`\val^n` back to the stack.

7. Jump to the position after the |END| of the :ref:`structured control instruction <syntax-instr-control>` associated with the label :math:`L`.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \LABEL_n\{\instr^\ast\}~\val^n~\END &\stepto& \val^n
   \end{array}

.. note::
   This semantics also applies to the instruction sequence contained in a |LOOP| instruction.
   Therefor, execution of a loop falls off the end, unless a backwards branch is performed explicitly.


.. index:: ! invocation, function, function instance, label, frame

Function Calls
~~~~~~~~~~~~~~

The following auxiliary rules define the semantics of invoking a :ref:`function instance <syntax-funcinst>`
through one of the :ref:`call instructions <exec-instr-control>`
and returning from it.


.. _exec-invoke:

Invocation of :ref:`function address <syntax-funcaddr>` :math:`a`
.................................................................

1. Assert: due to :ref:`validation <valid-call>`, :math:`S.\FUNCS[a]` exists.

2. Let :math:`f` be the :ref:`function instance <sytnax-funcinst>`, :math:`S.\FUNCS[a]`.

3. Assert: due to :ref:`validation <valid-func>`, :math:`f.\MODULE.\TYPES[f.\CODE.\TYPE]` exists.

4. Let :math:`[t_1^n] \to [t_2^m]` be the :ref:`function type <syntax-functype>` :math:`f.\MODULE.\TYPES[f.\CODE.\TYPE]`.

5. Let :math:`t^\ast` be the list of :ref:`value types <syntax-valtype>` :math:`f.\CODE.\LOCALS`.

6. Let :math:`\instr^\ast~\END` be the :ref:`expression <syntax-expr>` :math:`f.\CODE.\BODY`.

7. Assert: due to :ref:`validation <valid-call>`, :math:`n` values are on the top of the stack.

8. Pop the values :math:`\val^n` from the stack.

9. Let :math:`\val_0^\ast` be the list of zero values of types :math:`t^\ast`.

10. Let :math:`F` be the :ref:`frame <syntax-frame>` :math:`\{ \MODULE~f.\MODULE, \LOCALS~\val^n~\val_0^\ast \}`.

11. Push the activation of :math:`F` with arity :math:`m` to the stack.

12. :ref:`Execute <exec-block>` the instruction :math:`\BLOCK~[t_2^m]~\instr^\ast~\END`.

.. math::
   \begin{array}{l}
   \begin{array}{lcl@{\qquad}l}
   \val^n~(\INVOKE~a) &\stepto& \FRAME_m\{F\}~\BLOCK~[t_2^m]~\instr^\ast~\END~\END
   \end{array}
   \\ \qquad
     \begin{array}[t]{@{}r@{~}l@{}}
     (\mbox{if} & S.\FUNCS[a] = f \\
     \wedge & f.\CODE = \{ \TYPE~x, \LOCALS~t^k, \BODY~\instr^\ast~\END \} \\
     \wedge & f.\MODULE.\TYPES[x] = [t_1^n] \to [t_2^m] \\
     \wedge & F = \{ \MODULE~f.\MODULE, ~\LOCALS~\val^n~(t.\CONST~0)^k \})
     \end{array} \\
   \end{array}


.. _exec-invoke-exit:

Returning from a function
.........................

When the end of a funtion is reached without a jump (|RETURN|) or trap aborting it, then the following steps are performed.

1. Let :math:`F` be the :ref:`current <exec-notation-textual>` :ref:`frame <syntax-frame>`.

2. Let :math:`n` be the arity of the activation of :math:`F`.

3. Assert: due to :ref:`validation <valid-instr-seq>`, there are :math:`n` values on the top of the stack.

4. Pop the results :math:`\val^n` from the stack.

5. Assert: due to :ref:`validation <valid-func>`, the frame :math:`F` is now on the top of the stack.

6. Pop the frame from the stack.

7. Push :math:`\val^n` back to the stack.

8. Jump to the instruction after the original call.

.. math::
   \begin{array}{lcl@{\qquad}l}
   \FRAME_n\{F\}~\val^n~\END &\stepto& \val^n
   \end{array}


.. _exec-expr:
.. index:: expression
   pair: execution; expression
   single: abstract syntax; expression

Expressions
~~~~~~~~~~~

An :ref:`expression <syntax-expr>` is *evaluated* relative to its containing :ref:`module instance <syntax-modinst>` :math:`\moduleinst`.
To evaluate it, the instruction sequence is entered as follows:

1. Let :math:`F` be the :ref:`frame <syntax-frame>` :math:`\{ \MODULE~\moduleinst, \LOCALS~\epsilon \}`.

2. Push :math:`F` to the stack.

3. :ref:`Jump <exec-jump>` to the start of the instruction sequence :math:`\instr^\ast` of the expression.

Once execution of the instruction sequence is complete, it is exited as follows:

1. Assert: due to :ref:`validation <valid-constant>`, the instruction sequence is terminated without a trap, leaving a single value and the original frame on the stack.

2. Pop the result :math:`\val` from the stack.

3. Pop the frame from the stack.

The value :math:`\val` is returned.

.. math::
   \frac{
     S; F; \instr^\ast \stepto^\ast S'; F'; v
   }{
     S; F; \instr^\ast~\END \stepto^\ast S'; F'; v
   }
